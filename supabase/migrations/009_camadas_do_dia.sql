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
