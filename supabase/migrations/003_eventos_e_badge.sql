-- ============ FALA SEM TRAVA — instrumentação mínima (eventos + badge B1-B5) ============
-- Sem isso nenhuma evidência do badge é coletável (Auditoria FST 2026-07-03, item 1 do
-- essencial). Tabela append-only + views que leem o estado atual. As views cobrem o que dá
-- pra medir HOJE (B1, B2, B3); B4 (recorrência mês 2) só existe com ≥60 dias de dado —
-- a view já fica pronta pra quando existir histórico; B5 (margem de IA) não está aqui:
-- não há log de custo por treino ainda, é item futuro (não bloqueia o paywall).

create table if not exists eventos (
  id uuid primary key default gen_random_uuid(),
  tipo text not null,                 -- treino_feito | compra_aprovada | cancelamento | reembolso | signup | login
  user_id uuid references auth.users(id) on delete set null,
  email text,
  metadata jsonb default '{}'::jsonb,
  criado_em timestamptz default now()
);

create index if not exists idx_eventos_tipo_data on eventos (tipo, criado_em desc);
create index if not exists idx_eventos_user on eventos (user_id, criado_em desc);
create index if not exists idx_eventos_email on eventos (email);

-- append-only: RLS ligado, sem policy pra anon/authenticated. Só o service role
-- (supabaseAdmin, usado nas rotas server-side) escreve e lê — mesmo padrão de `assinaturas`.
alter table eventos enable row level security;

-- ── E-mails internos a excluir dos badges (admin/QA) ──
-- Ajustar aqui conforme a lista real antes de ler o badge pra valer (evita coorte fundadora
-- inflando B1-B3 — Auditoria FST §4, "ponto cego da coorte fundadora").
create or replace view vw_emails_internos as
  select unnest(array[
    'admin@exemplo.com'
    -- trocar pelos e-mails internos (admin/QA) reais antes de ler o badge
  ]) as email;

-- ── B1 — Cobrança real: pagantes ativos, desconhecidos (exclui internos) ──
create or replace view vw_badge_b1_cobranca as
  select count(*) as pagantes_ativos
  from assinaturas
  where status = 'active'
    and plano in ('standard', 'premium')
    and email not in (select email from vw_emails_internos);

-- ── B2 — Conversão free→pago (sobre quem se cadastrou) ──
create or replace view vw_badge_b2_conversao as
  select
    (select count(*) from perfis where email not in (select email from vw_emails_internos)) as cadastros,
    (select pagantes_ativos from vw_badge_b1_cobranca) as pagantes,
    round(
      100.0 * (select pagantes_ativos from vw_badge_b1_cobranca)
      / nullif((select count(*) from perfis where email not in (select email from vw_emails_internos)), 0)
    , 2) as conversao_pct;

-- ── B3 — Retenção D7: de quem fez o 1º treino, quem voltou a treinar entre o dia 7 e o dia 14 ──
create or replace view vw_badge_b3_retencao_d7 as
  with primeiro_treino as (
    select user_id, min(criado_em) as data_1o_treino
    from eventos
    where tipo = 'treino_feito' and user_id is not null
    group by user_id
  ),
  retornou as (
    select pt.user_id
    from primeiro_treino pt
    where exists (
      select 1 from eventos e
      where e.user_id = pt.user_id
        and e.tipo = 'treino_feito'
        and e.criado_em >= pt.data_1o_treino + interval '7 days'
        and e.criado_em <  pt.data_1o_treino + interval '14 days'
    )
  )
  select
    (select count(*) from primeiro_treino) as base_1o_treino,
    (select count(*) from retornou) as retornou_d7,
    round(
      100.0 * (select count(*) from retornou)
      / nullif((select count(*) from primeiro_treino), 0)
    , 2) as retencao_d7_pct;

-- ── B4 — Recorrência mês 2 (esqueleto — só fica confiável com ≥60 dias de assinatura) ──
-- Lê o histórico de eventos compra_aprovada por e-mail: renovou = teve 2 eventos de
-- compra_aprovada em meses de calendário consecutivos.
create or replace view vw_badge_b4_recorrencia as
  with compras as (
    select email, date_trunc('month', criado_em) as mes
    from eventos
    where tipo = 'compra_aprovada'
    group by email, date_trunc('month', criado_em)
  ),
  primeira_coorte as (
    select email, min(mes) as mes0 from compras group by email
  ),
  renovou as (
    select pc.email
    from primeira_coorte pc
    where exists (
      select 1 from compras c
      where c.email = pc.email and c.mes = pc.mes0 + interval '1 month'
    )
  )
  select
    (select count(*) from primeira_coorte) as coorte_mes1,
    (select count(*) from renovou) as renovou_mes2,
    round(
      100.0 * (select count(*) from renovou)
      / nullif((select count(*) from primeira_coorte), 0)
    , 2) as recorrencia_pct;

-- ── Resumo único (o que o futuro digest lê de 1 vez) ──
create or replace view vw_badge_resumo as
  select
    (select pagantes_ativos from vw_badge_b1_cobranca) as b1_pagantes,
    (select conversao_pct from vw_badge_b2_conversao) as b2_conversao_pct,
    (select retencao_d7_pct from vw_badge_b3_retencao_d7) as b3_retencao_d7_pct,
    (select recorrencia_pct from vw_badge_b4_recorrencia) as b4_recorrencia_pct;
