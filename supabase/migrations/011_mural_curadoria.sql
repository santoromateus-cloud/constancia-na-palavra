-- ============================================================
-- 011 — CURADORIA ANTES no Mural das Irmãs
--
-- Até aqui o mural era auto-aprovado: quem escrevia ia ao ar na hora, para
-- todas. Com o rosto da Elisângela em cima da tela, isso é risco dela, não do
-- sistema. A partir desta migration NADA aparece para as outras antes de ela
-- ler. O recado entra na fila, a autora vê o dela em análise, e só o painel
-- (service role) publica.
--
-- 02/09/2026
-- ============================================================

-- 1. o padrão passa a ser NÃO publicado
alter table wall_posts alter column aprovado set default false;

-- 2. a autora enxerga o próprio recado enquanto ele espera a curadoria
drop policy if exists "wall_posts_select_own" on wall_posts;
create policy "wall_posts_select_own" on wall_posts
  for select to authenticated
  using (auth.uid() = user_id);

-- 3. ninguém se auto-aprova: o insert só passa com aprovado = false
drop policy if exists "wall_posts_insert_own" on wall_posts;
create policy "wall_posts_insert_own" on wall_posts
  for insert to authenticated
  with check (auth.uid() = user_id and aprovado = false);

-- 4. estado da moderação
--    recusado: a Elisângela leu e não publicou (a autora vê "não publicado",
--    sem bronca e sem motivo exposto — o mural não é tribunal)
--    da_casa: recado da própria Elisângela, mostrado com o nome dela em vez
--    de "uma irmã". Nada aqui finge ser leitora que não existe.
alter table wall_posts add column if not exists moderado_em timestamptz;
alter table wall_posts add column if not exists recusado boolean not null default false;
alter table wall_posts add column if not exists da_casa boolean not null default false;

-- 5. a fila da moderação, por ordem de chegada
create index if not exists wall_posts_fila_idx
  on wall_posts (aprovado, recusado, criado_em desc);
