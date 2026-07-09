-- ============ CONSTÂNCIA NA PALAVRA — produto: planos de leitura + mural ============
-- A "alma" do produto (E4). Segue o padrão das migrations 001–004:
--   • RLS ligado em TODA tabela;
--   • cada usuária lê/escreve só o que é dela (auth.uid());
--   • conteúdo dos planos (reading_plans/_days) é público pra autenticadas (SELECT);
--   • escrita de conteúdo e moderação = service role (supabaseAdmin), sem policy p/ cliente.
-- Sem IA. Sem cota. O acesso à área é gated por assinatura ativa (quota.temAcesso).

-- ── Catálogo de planos (ex.: Provérbios em 31 dias) ───────────────────────────
create table if not exists reading_plans (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  titulo text not null,
  descricao text,
  total_dias int not null default 0,
  ordem int not null default 0,
  ativo boolean not null default true,
  criado_em timestamptz default now()
);

-- ── Dias de cada plano (dia -> referência + texto bíblico) ────────────────────
create table if not exists reading_plan_days (
  id uuid primary key default gen_random_uuid(),
  plan_id uuid not null references reading_plans(id) on delete cascade,
  dia int not null,
  referencia text not null,                  -- ex.: 'Provérbios 1'
  texto text,                                -- texto de domínio público; pode ser null (pendência)
  unique (plan_id, dia)
);
create index if not exists idx_plan_days_plan on reading_plan_days (plan_id, dia);

-- ── Plano ativo de cada usuária (1 ativo por vez) ─────────────────────────────
create table if not exists user_plans (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  plan_id uuid not null references reading_plans(id) on delete cascade,
  iniciado_em timestamptz default now(),
  dia_atual int not null default 1,
  ativo boolean not null default true
);
-- no máximo UM plano ativo por usuária (unique parcial)
create unique index if not exists uniq_user_plano_ativo on user_plans (user_id) where (ativo);
create index if not exists idx_user_plans_user on user_plans (user_id);

-- ── Check-ins (1 por dia de plano; idempotente) ───────────────────────────────
create table if not exists checkins (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  plan_id uuid not null references reading_plans(id) on delete cascade,
  dia int not null,
  data date not null default current_date,
  criado_em timestamptz default now(),
  unique (user_id, plan_id, dia)
);
create index if not exists idx_checkins_user_data on checkins (user_id, data desc);

-- ── Mural da comunidade ───────────────────────────────────────────────────────
create table if not exists wall_posts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  texto text not null,
  referencia text,
  aprovado boolean not null default true,    -- auto-aprovado; moderação futura via service role
  criado_em timestamptz default now()
);
create index if not exists idx_wall_posts_criado on wall_posts (criado_em desc);

create table if not exists wall_reactions (
  id uuid primary key default gen_random_uuid(),
  post_id uuid not null references wall_posts(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  tipo text not null check (tipo in ('amem','orando')),
  criado_em timestamptz default now(),
  unique (post_id, user_id, tipo)
);
create index if not exists idx_wall_reactions_post on wall_reactions (post_id);

-- ============================ RLS ============================
alter table reading_plans      enable row level security;
alter table reading_plan_days  enable row level security;
alter table user_plans         enable row level security;
alter table checkins           enable row level security;
alter table wall_posts         enable row level security;
alter table wall_reactions     enable row level security;

-- Conteúdo dos planos: leitura livre pra qualquer autenticada. Escrita = service role.
create policy "reading_plans_select_auth" on reading_plans
  for select to authenticated using (true);
create policy "reading_plan_days_select_auth" on reading_plan_days
  for select to authenticated using (true);

-- user_plans: cada usuária só o SEU (select/insert/update).
create policy "user_plans_select_own" on user_plans
  for select using (auth.uid() = user_id);
create policy "user_plans_insert_own" on user_plans
  for insert with check (auth.uid() = user_id);
create policy "user_plans_update_own" on user_plans
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- checkins: cada usuária só o SEU (select/insert). Não há update/delete pra cliente.
create policy "checkins_select_own" on checkins
  for select using (auth.uid() = user_id);
create policy "checkins_insert_own" on checkins
  for insert with check (auth.uid() = user_id);

-- wall_posts: qualquer autenticada LÊ os aprovados; só escreve o SEU.
create policy "wall_posts_select_aprovado" on wall_posts
  for select to authenticated using (aprovado = true);
create policy "wall_posts_insert_own" on wall_posts
  for insert with check (auth.uid() = user_id);

-- wall_reactions: qualquer autenticada LÊ; só cria/remove a SUA (toggle da reação).
create policy "wall_reactions_select_auth" on wall_reactions
  for select to authenticated using (true);
create policy "wall_reactions_insert_own" on wall_reactions
  for insert with check (auth.uid() = user_id);
create policy "wall_reactions_delete_own" on wall_reactions
  for delete using (auth.uid() = user_id);
