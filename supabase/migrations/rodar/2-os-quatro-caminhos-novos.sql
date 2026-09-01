-- ============================================================================
-- CONSTANCIA NA PALAVRA — PASSO 2 de 6 — cadastro dos 4 caminhos novos
-- So o cadastro dos caminhos. O texto biblico vem nos passos 3 a 6.
-- Rode os arquivos NA ORDEM DO NUMERO. Cada um e idempotente: pode rodar de
-- novo sem duplicar nada.
-- ============================================================================

-- ============================================================================
-- CONSTÂNCIA NA PALAVRA — 010 · OS CAMINHOS NOVOS
--
-- Quatro caminhos a mais, escolhidos pelas praticas que a leitora de Biblia
-- mais procura e que os apps concorrentes menos entregam: leitura cronologica,
-- geografia, curiosidades de contexto e comentario de autoridade.
--
-- PROVENIENCIA E DIREITO AUTORAL (regra dura do projeto):
--  * Texto biblico: Joao Ferreira de Almeida, edicao "aa" — DOMINIO PUBLICO.
--    Capturado de bibliajfa.com.br/aa/<livro>/<capitulo> em 01/09/2026, capitulo
--    a capitulo, com a contagem de versiculos conferida contra o canonico.
--    ARC, ACF e ARA sao PROIBIDAS aqui: tem direito autoral vivo.
--  * Comentario: Charles Haddon Spurgeon (1834-1892), "The Treasury of David"
--    (1885) — DOMINIO PUBLICO. Fonte por salmo gravada na coluna `fonte`.
--    Traducao feita do ORIGINAL EM INGLES, nao copiada de traducao brasileira
--    publicada: traducao tem direito autoral proprio, o original nao.
--    Por isso Billy Graham e qualquer autor do seculo 20 ficaram de fora, mesmo
--    com credito — credito nao substitui licenca.
--  * Geografia e curiosidades: notas escritas para este produto a partir de
--    fatos historicos e geograficos estabelecidos (lugares, distancias, moedas,
--    medidas, costumes). Nao ha citacao de obra de terceiro nessas colunas.
--
-- Depende da 009 (colunas comentario / geografia / curiosidade). A 009 tem uma
-- CHECK que recusa comentario sem autor e sem obra — de proposito.
--
-- Idempotente: `on conflict` atualiza. Pode rodar de novo sem duplicar nada.
-- ============================================================================

insert into reading_plans (id, slug, titulo, descricao, total_dias, ordem, ativo) values
  ('55555555-5555-4555-8555-555555555555', 'biblia-cronologica-40-dias', 'A Bíblia na ordem em que aconteceu', 'Do Éden a Pentecostes na ordem dos acontecimentos, não na ordem dos livros. Quarenta capítulos que contam a história inteira de ponta a ponta.', 40, 5, true),
  ('66666666-6666-4666-8666-666666666666', 'onde-tudo-aconteceu-21-dias', 'Onde tudo aconteceu', 'Cada dia uma passagem e o lugar onde ela se passou: a estrada, o monte, o poço, a cidade. A Bíblia deixa de ser abstrata quando você sabe onde pisar.', 21, 6, true),
  ('77777777-7777-4777-8777-777777777777', 'curiosidades-da-biblia-21-dias', 'O que você não sabia da Bíblia', 'O costume, a moeda, a medida, o detalhe que a leitora de hoje não vê — e que muda o sentido da passagem inteira quando você enxerga.', 21, 7, true),
  ('88888888-8888-4888-8888-888888888888', 'salmos-com-spurgeon-30-dias', 'Salmos com Spurgeon', 'Trinta salmos com um trecho do comentário de Charles Spurgeon, o pregador que passou a vida dentro deste livro. Você lê o salmo e ouve quem morou nele.', 30, 8, true)
on conflict (slug) do update set
  titulo = excluded.titulo, descricao = excluded.descricao,
  total_dias = excluded.total_dias, ordem = excluded.ordem, ativo = excluded.ativo;
