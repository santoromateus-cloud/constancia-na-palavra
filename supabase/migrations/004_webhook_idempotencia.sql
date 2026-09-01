-- ============ CONSTÂNCIA NA PALAVRA — idempotência do webhook Hotmart ============
-- Bug conhecido (skill bugs-conhecidos #11): provider reenvia o mesmo webhook 2-3x
-- (retry de rede) e, em cenários de fora-de-ordem, um evento de cancelamento pode
-- chegar antes do de ativação. O upsert por e-mail já torna o estado final idempotente,
-- mas não impede reprocessar o MESMO evento (ex.: logar 2 vezes o mesmo `eventos`,
-- ou reverter um estado mais novo com um webhook antigo que chegou atrasado).
-- Esta tabela é o registro de "já vi essa transaction+evento" — dedup explícito.

create table if not exists webhook_transacoes_processadas (
  transaction text not null,
  evento text not null,
  processado_em timestamptz default now(),
  primary key (transaction, evento)
);

alter table webhook_transacoes_processadas enable row level security;
-- só o service role (webhook, roda com supabaseAdmin) toca esta tabela — sem policy pra clientes.
