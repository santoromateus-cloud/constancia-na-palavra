# Constância na Palavra — o que rodar no Supabase

São 6 arquivos. Rode **na ordem do número**, um de cada vez, no SQL Editor do
Supabase (projeto MS EducaVerbum): abre o arquivo, copia tudo, cola, **Run**.

Cada arquivo pode ser rodado quantas vezes você quiser. Já testei os seis
rodando **três vezes seguidas** contra um Postgres 16 e nada duplicou nem
quebrou. Se você não lembra se já tinha rodado a 008 e a 009 antes, roda de
novo sem medo: o arquivo 1 agora derruba e recria as políticas em vez de
parar no "policy já existe".

| # | Arquivo | O que faz |
|---|---|---|
| 1 | `1-freemium-e-camadas.sql` | Tabelas do marcador da Bíblia e da gamificação (as antigas 008 e 009), mais as colunas de comentário, geografia e curiosidade. |
| 2 | `2-os-quatro-caminhos-novos.sql` | Cadastra os 4 caminhos novos. Só o cadastro. |
| 3 | `3-caminho-cronologico.sql` | "A Bíblia na ordem em que aconteceu", 40 dias de texto. |
| 4 | `4-caminho-geografia.sql` | "Onde tudo aconteceu", 21 dias de texto. |
| 5 | `5-caminho-curiosidades.sql` | "O que você não sabia da Bíblia", 21 dias de texto. |
| 6 | `6-caminho-spurgeon-e-camadas.sql` | "Salmos com Spurgeon", 30 dias, mais as notas de geografia e de curiosidade dos caminhos 4 e 5. |

O 3 é o maior (167 KB). Se o editor do Supabase reclamar do tamanho, roda o
arquivo em duas metades: corta em qualquer linha que comece com `  ('5555...`
e repete o `insert into reading_plan_days (plan_id, dia, referencia, texto)
values` no começo da segunda metade, trocando a vírgula final pela linha
`on conflict (plan_id, dia) do update set referencia = excluded.referencia,
texto = excluded.texto;`.

## Como conferir que deu certo

Cola isso no SQL Editor depois do passo 6:

```sql
select p.ordem, p.titulo, p.total_dias,
       count(d.dia) as dias_com_texto,
       count(d.comentario) as com_comentario,
       count(d.geografia) as com_geografia,
       count(d.curiosidade) as com_curiosidade
from reading_plans p
left join reading_plan_days d on d.plan_id = p.id
group by p.id, p.ordem, p.titulo, p.total_dias
order by p.ordem;
```

Tem que voltar 8 linhas, assim:

| ordem | título | dias | coment. | geo | curio |
|---|---|---|---|---|---|
| 1 | Provérbios em 31 dias | 31 | 0 | 0 | 0 |
| 2 | Evangelho de João em 21 dias | 21 | 0 | 0 | 0 |
| 3 | Mulheres da Bíblia em 15 dias | 15 | 0 | 0 | 0 |
| 4 | Evangelho de Marcos em 16 dias | 16 | 0 | 0 | 0 |
| 5 | A Bíblia na ordem em que aconteceu | 40 | 0 | 0 | 0 |
| 6 | Onde tudo aconteceu | 21 | 0 | 21 | 0 |
| 7 | O que você não sabia da Bíblia | 21 | 0 | 0 | 21 |
| 8 | Salmos com Spurgeon | 30 | 30 | 0 | 0 |

## De onde vem o conteúdo

**Texto bíblico:** João Ferreira de Almeida, edição "aa", **domínio público**,
de `bibliajfa.com.br/aa/<livro>/<capítulo>`. Capítulo a capítulo, com a
contagem de versículos conferida contra o canônico em cada um. ARC, ACF e ARA
ficaram de fora: têm direito autoral vivo.

**Comentário:** Charles Haddon Spurgeon (1834–1892), *The Treasury of David*
(1885), **domínio público**. Traduzido do original em inglês, não copiado de
tradução brasileira publicada, porque tradução tem direito autoral próprio.
Cada dia grava o autor, a obra e a URL exata da fonte.

Billy Graham e qualquer autor do século 20 ficaram de fora mesmo com crédito.
Crédito não substitui licença, e o banco recusa comentário sem autor e sem
obra por CHECK, não por disciplina.

**Geografia e curiosidades:** notas escritas para este produto a partir de
fatos históricos e geográficos estabelecidos (lugares, distâncias, moedas,
medidas, costumes). Não há citação de obra de terceiro nessas colunas.

## Enquanto você não roda

O site já está no ar com a página nova e não depende disso pra funcionar.
A tela de leitura tem uma proteção: se as colunas das camadas ainda não
existem, ela cai pro modo antigo e a leitora vê o texto do dia normalmente,
só sem comentário, geografia e curiosidade. Nada quebra esperando você.

Os 4 caminhos novos só aparecem no app depois que você rodar os arquivos 2 a 6.
