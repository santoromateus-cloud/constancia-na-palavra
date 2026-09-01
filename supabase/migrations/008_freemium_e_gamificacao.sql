-- ====== CONSTÂNCIA NA PALAVRA — camada GRÁTIS + gamificação ======
-- 01/09/2026. Muda o modelo de acesso de "pago ou nada" para FREEMIUM:
--
--   GRÁTIS (conta criada, sem pagar): marcar capítulos lidos nos 66 livros,
--     ver o progresso AT/NT/total, definir uma meta com data de início e fim.
--     A Bíblia NUNCA fica atrás do paywall — é postura teológica, não concessão.
--
--   PAGO: planos de leitura curados, Lavra, Pérolas, Dias de Graça, selos,
--     mural e dupla. O que se vende é o jogo, o plano e a companhia.
--
-- Padrão das migrations anteriores: RLS em toda tabela, cada usuária só toca no
-- que é dela, conteúdo de catálogo legível por autenticadas, escrita de catálogo
-- só por service role.

-- ── GRÁTIS · progresso capítulo a capítulo (o checkbox) ───────────────────────
-- Uma linha por capítulo marcado. livro = slug de src/lib/biblia.ts ('salmos').
-- Sem linha = não lido (desmarcar é DELETE, não update) — mantém a tabela enxuta
-- e o "lido_em" sempre verdadeiro.
create table if not exists biblia_progresso (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  livro text not null,
  capitulo int not null check (capitulo > 0),
  lido_em date not null default current_date,
  criado_em timestamptz default now(),
  unique (user_id, livro, capitulo)
);
create index if not exists idx_biblia_prog_user on biblia_progresso (user_id);
create index if not exists idx_biblia_prog_user_data on biblia_progresso (user_id, lido_em desc);

-- ── GRÁTIS · meta da leitora (a "Start Date / End Date" do print) ─────────────
-- Uma meta por usuária. O app calcula quantos capítulos por dia faltam.
create table if not exists meta_leitura (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data_inicio date not null default current_date,
  data_fim date not null,
  escopo text not null default 'biblia' check (escopo in ('biblia','at','nt')),
  criado_em timestamptz default now(),
  atualizado_em timestamptz default now()
);

-- ── PAGO · Pérolas (recompensa variável — catálogo curado) ───────────────────
create table if not exists perolas (
  id uuid primary key default gen_random_uuid(),
  referencia text not null,                  -- 'Salmos 119:105'
  texto text not null,                       -- Almeida, domínio público
  raridade text not null default 'comum' check (raridade in ('comum','dourada')),
  ativo boolean not null default true,
  criado_em timestamptz default now()
);
create index if not exists idx_perolas_raridade on perolas (raridade) where ativo;

create table if not exists perolas_usuario (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  perola_id uuid not null references perolas(id) on delete cascade,
  revelada_em timestamptz default now(),
  unique (user_id, perola_id)
);
create index if not exists idx_perolas_user on perolas_usuario (user_id, revelada_em desc);

-- ── PAGO · Dias de Graça (o streak-freeze) ───────────────────────────────────
-- REGRA DURA: Dia de Graça NUNCA é vendido, só conquistado (1 a cada 7 dias de
-- constância, teto 3). Vender graça seria simonia e dark pattern de uma vez.
create table if not exists gracas (
  user_id uuid primary key references auth.users(id) on delete cascade,
  saldo int not null default 0 check (saldo >= 0 and saldo <= 3),
  total_ganhas int not null default 0,
  total_usadas int not null default 0,
  atualizado_em timestamptz default now()
);

-- ── PAGO · Selos e títulos (escada de identidade) ────────────────────────────
create table if not exists titulos_usuario (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  titulo text not null,                      -- 'constante' | 'perseverante' | ...
  dias int not null,
  conquistado_em timestamptz default now(),
  unique (user_id, titulo)
);
create index if not exists idx_titulos_user on titulos_usuario (user_id);

-- ============================ RLS ============================
alter table biblia_progresso enable row level security;
alter table meta_leitura     enable row level security;
alter table perolas          enable row level security;
alter table perolas_usuario  enable row level security;
alter table gracas           enable row level security;
alter table titulos_usuario  enable row level security;

-- biblia_progresso: cada usuária lê, cria e APAGA o seu (desmarcar = delete).
create policy "biblia_prog_select_own" on biblia_progresso
  for select using (auth.uid() = user_id);
create policy "biblia_prog_insert_own" on biblia_progresso
  for insert with check (auth.uid() = user_id);
create policy "biblia_prog_delete_own" on biblia_progresso
  for delete using (auth.uid() = user_id);

-- meta_leitura: cada usuária só a sua.
create policy "meta_select_own" on meta_leitura
  for select using (auth.uid() = user_id);
create policy "meta_insert_own" on meta_leitura
  for insert with check (auth.uid() = user_id);
create policy "meta_update_own" on meta_leitura
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "meta_delete_own" on meta_leitura
  for delete using (auth.uid() = user_id);

-- perolas (catálogo): leitura livre pra autenticadas; escrita = service role.
create policy "perolas_select_auth" on perolas
  for select to authenticated using (ativo = true);

-- perolas_usuario / gracas / titulos: cada usuária só o seu.
create policy "perolas_user_select_own" on perolas_usuario
  for select using (auth.uid() = user_id);
create policy "perolas_user_insert_own" on perolas_usuario
  for insert with check (auth.uid() = user_id);

create policy "gracas_select_own" on gracas
  for select using (auth.uid() = user_id);
create policy "gracas_insert_own" on gracas
  for insert with check (auth.uid() = user_id);
create policy "gracas_update_own" on gracas
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "titulos_select_own" on titulos_usuario
  for select using (auth.uid() = user_id);
create policy "titulos_insert_own" on titulos_usuario
  for insert with check (auth.uid() = user_id);
