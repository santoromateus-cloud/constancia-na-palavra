-- ============================================================
-- 012 — O CADERNO (camada paga)
--
-- A leitora lê o capítulo e responde quatro perguntas sobre ele:
--   uma promessa · uma ordem · um princípio · um passo
--
-- Duas decisões que estão no schema, não só na tela:
--
-- 1. SÓ O PASSO É OBRIGATÓRIO (check constraint). Nem todo capítulo tem as
--    quatro coisas — Levítico 13 não tem promessa, genealogia não tem ordem.
--    Exigir as quatro todo dia ensinaria a inventar promessa que não está no
--    texto, que é pior do que não escrever nada. O passo é o único que sempre
--    existe, porque sempre dá pra fazer alguma coisa com o que se leu.
--
-- 2. A ENTRADA SOBREVIVE AO CAMINHO. plan_id é ON DELETE SET NULL e a
--    referência fica gravada na linha. Se um caminho for removido do catálogo,
--    o que ela escreveu continua dela. Texto de leitora não se apaga por
--    manutenção de catálogo.
--
-- A pérola do dia é guardada JUNTO com a entrada (perola_n/perola_texto) —
-- é a primeira vez que a pérola para de ser calculada e jogada fora.
--
-- 02/09/2026
-- ============================================================

create table if not exists caderno (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  plan_id uuid references reading_plans(id) on delete set null,
  dia int,
  referencia text,
  data date not null default current_date,

  promessa text,
  ordem text,
  principio text,
  passo text not null,

  perola_n int,
  perola_texto text,

  criado_em timestamptz not null default now(),
  atualizado_em timestamptz not null default now(),

  constraint caderno_passo_nao_vazio check (length(btrim(passo)) > 0)
);

-- uma entrada por dia de caminho (a lib faz read-then-write, este índice é a
-- rede de proteção contra corrida de duplo toque)
create unique index if not exists caderno_dia_unico
  on caderno (user_id, plan_id, dia);

-- a estante dela, em ordem de leitura
create index if not exists caderno_por_usuaria_idx
  on caderno (user_id, criado_em desc);

alter table caderno enable row level security;

-- O caderno é PRIVADO. Nada aqui é compartilhado, nem anonimamente: é o lugar
-- onde ela escreve o que não contaria pra ninguém. Se um dia algum trecho for
-- para o mural, vai por uma ação explícita dela, copiado, nunca por leitura
-- cruzada de tabela.
drop policy if exists "caderno_select_own" on caderno;
create policy "caderno_select_own" on caderno
  for select to authenticated using (auth.uid() = user_id);

drop policy if exists "caderno_insert_own" on caderno;
create policy "caderno_insert_own" on caderno
  for insert to authenticated with check (auth.uid() = user_id);

drop policy if exists "caderno_update_own" on caderno;
create policy "caderno_update_own" on caderno
  for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "caderno_delete_own" on caderno;
create policy "caderno_delete_own" on caderno
  for delete to authenticated using (auth.uid() = user_id);
