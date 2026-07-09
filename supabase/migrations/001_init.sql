-- ============ FALA SEM TRAVA — schema inicial ============
-- Login Google é gerenciado pelo Supabase Auth (auth.users).
-- Aqui ficam o perfil, as sessões de treino e a evolução. LGPD: guardamos
-- a transcrição e as métricas, NUNCA o áudio (descartado após transcrever).

create table if not exists perfis (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text,
  email text,
  criado_em timestamptz default now(),
  plano text default 'free',                 -- free | pago
  analises_no_mes int default 0,             -- cota
  mes_referencia text                        -- 'YYYY-MM' p/ resetar a cota
);

create table if not exists sessoes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  criado_em timestamptz default now(),
  origem text default 'texto',               -- texto | audio
  transcricao text,                          -- guardamos texto, NUNCA o áudio
  duracao_seg int,
  nota int,
  wpm int,
  muletas_total int,
  muletas_por_100 numeric,
  frase_media numeric,
  vocab numeric,
  metricas jsonb,                            -- payload completo do analyzeSpeech()
  coach_texto text
);

create index if not exists idx_sessoes_user_data on sessoes (user_id, criado_em desc);

-- RLS: cada pessoa só enxerga o que é dela.
alter table perfis enable row level security;
alter table sessoes enable row level security;

create policy "perfil_proprio_select" on perfis for select using (auth.uid() = id);
create policy "perfil_proprio_update" on perfis for update using (auth.uid() = id);
create policy "perfil_proprio_insert" on perfis for insert with check (auth.uid() = id);

create policy "sessao_propria_select" on sessoes for select using (auth.uid() = user_id);
create policy "sessao_propria_insert" on sessoes for insert with check (auth.uid() = user_id);
