-- ============================================================================
-- CONSTANCIA NA PALAVRA — PASSO 1 de 6 — freemium + colunas das camadas (migrations 008 e 009)
-- Cria as tabelas do marcador da Biblia e da gamificacao, e as colunas de
-- comentario / geografia / curiosidade nos dias dos caminhos.
-- Rode os arquivos NA ORDEM DO NUMERO. Cada um e idempotente: pode rodar de
-- novo sem duplicar nada, inclusive se voce ja tinha rodado a 008 antes.
-- ============================================================================

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

-- REEXECUTAVEL (01/09/2026): cada policy leva um "drop policy if exists"
-- antes. Sem isso, rodar esta migration duas vezes parava no primeiro
-- "policy ja existe" e dava a impressao de que tudo quebrou.
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
drop policy if exists "biblia_prog_select_own" on biblia_progresso;
create policy "biblia_prog_select_own" on biblia_progresso
  for select using (auth.uid() = user_id);
drop policy if exists "biblia_prog_insert_own" on biblia_progresso;
create policy "biblia_prog_insert_own" on biblia_progresso
  for insert with check (auth.uid() = user_id);
drop policy if exists "biblia_prog_delete_own" on biblia_progresso;
create policy "biblia_prog_delete_own" on biblia_progresso
  for delete using (auth.uid() = user_id);

-- meta_leitura: cada usuária só a sua.
drop policy if exists "meta_select_own" on meta_leitura;
create policy "meta_select_own" on meta_leitura
  for select using (auth.uid() = user_id);
drop policy if exists "meta_insert_own" on meta_leitura;
create policy "meta_insert_own" on meta_leitura
  for insert with check (auth.uid() = user_id);
drop policy if exists "meta_update_own" on meta_leitura;
create policy "meta_update_own" on meta_leitura
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
drop policy if exists "meta_delete_own" on meta_leitura;
create policy "meta_delete_own" on meta_leitura
  for delete using (auth.uid() = user_id);

-- perolas (catálogo): leitura livre pra autenticadas; escrita = service role.
drop policy if exists "perolas_select_auth" on perolas;
create policy "perolas_select_auth" on perolas
  for select to authenticated using (ativo = true);

-- perolas_usuario / gracas / titulos: cada usuária só o seu.
drop policy if exists "perolas_user_select_own" on perolas_usuario;
create policy "perolas_user_select_own" on perolas_usuario
  for select using (auth.uid() = user_id);
drop policy if exists "perolas_user_insert_own" on perolas_usuario;
create policy "perolas_user_insert_own" on perolas_usuario
  for insert with check (auth.uid() = user_id);

drop policy if exists "gracas_select_own" on gracas;
create policy "gracas_select_own" on gracas
  for select using (auth.uid() = user_id);
drop policy if exists "gracas_insert_own" on gracas;
create policy "gracas_insert_own" on gracas
  for insert with check (auth.uid() = user_id);
drop policy if exists "gracas_update_own" on gracas;
create policy "gracas_update_own" on gracas
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "titulos_select_own" on titulos_usuario;
create policy "titulos_select_own" on titulos_usuario
  for select using (auth.uid() = user_id);
drop policy if exists "titulos_insert_own" on titulos_usuario;
create policy "titulos_insert_own" on titulos_usuario
  for insert with check (auth.uid() = user_id);

-- ====== CONSTÂNCIA NA PALAVRA — as camadas de cada dia de leitura ======
-- 01/09/2026. Hoje um dia de plano é só referência + texto bíblico. Esta
-- migration abre as camadas que o mercado mais procura e que os apps
-- concorrentes menos entregam (mapa, contexto histórico e comentário):
--
--   comentário  — a voz que explica o texto, com AUTOR e OBRA citados
--   geografia   — onde a cena aconteceu, e por que o lugar importa
--   curiosidade — o fato de contexto que muda a leitura
--
-- ── REGRA DURA DE DIREITO AUTORAL (não relaxar) ──────────────────────────────
-- Só entra comentário de autor em DOMÍNIO PÚBLICO. Spurgeon (†1892), J.C. Ryle
-- (†1900), Matthew Henry (†1714), Andrew Murray (†1917) entram. Autor do século
-- XX ainda protegido (Billy Graham †2018, Tozer †1963 e afins) NÃO entra, mesmo
-- que citado com crédito — o nome que responde pela página é o da Elisangela.
--
-- Segunda armadilha: a obra original ser livre NÃO liberta a TRADUÇÃO. Toda
-- tradução brasileira publicada tem direito autoral próprio. Então o texto em
-- português aqui é tradução nossa, feita do original em domínio público — e
-- comentario_obra registra de onde veio, para a origem nunca se perder.
--
-- Mesma coisa para o texto bíblico: só Almeida em domínio público. ARC, ACF e
-- ARA são de sociedades bíblicas e NÃO podem entrar.

alter table reading_plan_days
  add column if not exists comentario text,
  add column if not exists comentario_autor text,
  add column if not exists comentario_obra text,
  add column if not exists geografia text,
  add column if not exists geografia_lugar text,
  add column if not exists curiosidade text,
  add column if not exists fonte text;

comment on column reading_plan_days.comentario is
  'Comentário sobre a passagem. SOMENTE autor em domínio público, traduzido por nós do original livre.';
comment on column reading_plan_days.comentario_autor is
  'Autor do comentário (ex.: Charles Spurgeon). Obrigatório quando comentario existe — comentário sem crédito não sobe.';
comment on column reading_plan_days.comentario_obra is
  'Obra e ano de origem (ex.: O Tesouro de Davi, 1885). Prova de que o original é domínio público.';
comment on column reading_plan_days.geografia is
  'Onde a cena aconteceu e por que o lugar importa para entender o texto.';
comment on column reading_plan_days.curiosidade is
  'Fato de contexto histórico, cultural ou linguístico, verificável, que muda a leitura.';
comment on column reading_plan_days.fonte is
  'De onde o texto bíblico deste dia foi capturado. Rastreabilidade da curadoria.';

-- Trava no banco, não só na cabeça de quem cura: comentário sem autor não entra.
-- Se a regra de crédito depender de disciplina humana, um dia ela falha.
alter table reading_plan_days
  drop constraint if exists comentario_exige_credito;
alter table reading_plan_days
  add constraint comentario_exige_credito
  check (comentario is null or (comentario_autor is not null and comentario_obra is not null));

-- Índice para a tela de leitura pedir só os dias que já têm camada pronta.
create index if not exists idx_plan_days_com_camada
  on reading_plan_days (plan_id, dia)
  where comentario is not null or geografia is not null or curiosidade is not null;
