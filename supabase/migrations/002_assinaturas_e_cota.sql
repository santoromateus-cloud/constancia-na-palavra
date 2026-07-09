-- ============ FALA SEM TRAVA — assinaturas (Hotmart) + cota por plano ============
-- Modelo de planos: free (3 treinos/mês) · standard (1 treino/dia) · premium (ilimitado).
-- Fonte da verdade da assinatura = tabela `assinaturas` por e-mail (vem do webhook
-- do Hotmart, que pode chegar ANTES da pessoa ter conta). `perfis.plano` é o espelho
-- pro gating rápido; é sincronizado no login e pelo webhook.

-- cota diária (pro Standard) — a mensal (free) já existe em perfis
alter table perfis add column if not exists analises_no_dia int default 0;
alter table perfis add column if not exists dia_referencia date;
alter table perfis add column if not exists assinatura_status text;          -- active | cancelled | overdue
alter table perfis add column if not exists hotmart_subscriber_code text;

create table if not exists assinaturas (
  email text primary key,
  plano text not null default 'free',          -- free | standard | premium
  status text not null default 'active',        -- active | cancelled | refunded | overdue
  hotmart_subscriber_code text,
  hotmart_transaction text,
  criada_em timestamptz default now(),
  atualizada_em timestamptz default now()
);

alter table assinaturas enable row level security;
-- a pessoa só enxerga a própria assinatura (casada pelo e-mail do token).
-- escrita é exclusiva do service role (webhook) — sem policy de insert/update pra clientes.
create policy "assinatura_propria_select" on assinaturas
  for select using ( (auth.jwt() ->> 'email') = email );
