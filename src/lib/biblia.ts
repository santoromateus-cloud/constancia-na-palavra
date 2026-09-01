// ── Catálogo da Bíblia (camada GRÁTIS do Constância) ──────────────────────────
// Os 66 livros e a contagem de capítulos de cada um. Dado estático: não vive no
// banco porque não muda nunca e evita uma consulta em toda renderização da tela.
// Totais conferidos: AT 929 · NT 260 · Bíblia 1.189 capítulos.

export type Livro = {
  slug: string
  nome: string
  capitulos: number
  testamento: 'at' | 'nt'
  grupo: string
}

export const LIVROS: Livro[] = [
  // ── Antigo Testamento (39 livros · 929 capítulos) ──
  { slug: 'genesis', nome: 'Gênesis', capitulos: 50, testamento: 'at', grupo: 'Pentateuco' },
  { slug: 'exodo', nome: 'Êxodo', capitulos: 40, testamento: 'at', grupo: 'Pentateuco' },
  { slug: 'levitico', nome: 'Levítico', capitulos: 27, testamento: 'at', grupo: 'Pentateuco' },
  { slug: 'numeros', nome: 'Números', capitulos: 36, testamento: 'at', grupo: 'Pentateuco' },
  { slug: 'deuteronomio', nome: 'Deuteronômio', capitulos: 34, testamento: 'at', grupo: 'Pentateuco' },
  { slug: 'josue', nome: 'Josué', capitulos: 24, testamento: 'at', grupo: 'Históricos' },
  { slug: 'juizes', nome: 'Juízes', capitulos: 21, testamento: 'at', grupo: 'Históricos' },
  { slug: 'rute', nome: 'Rute', capitulos: 4, testamento: 'at', grupo: 'Históricos' },
  { slug: '1samuel', nome: '1 Samuel', capitulos: 31, testamento: 'at', grupo: 'Históricos' },
  { slug: '2samuel', nome: '2 Samuel', capitulos: 24, testamento: 'at', grupo: 'Históricos' },
  { slug: '1reis', nome: '1 Reis', capitulos: 22, testamento: 'at', grupo: 'Históricos' },
  { slug: '2reis', nome: '2 Reis', capitulos: 25, testamento: 'at', grupo: 'Históricos' },
  { slug: '1cronicas', nome: '1 Crônicas', capitulos: 29, testamento: 'at', grupo: 'Históricos' },
  { slug: '2cronicas', nome: '2 Crônicas', capitulos: 36, testamento: 'at', grupo: 'Históricos' },
  { slug: 'esdras', nome: 'Esdras', capitulos: 10, testamento: 'at', grupo: 'Históricos' },
  { slug: 'neemias', nome: 'Neemias', capitulos: 13, testamento: 'at', grupo: 'Históricos' },
  { slug: 'ester', nome: 'Ester', capitulos: 10, testamento: 'at', grupo: 'Históricos' },
  { slug: 'jo', nome: 'Jó', capitulos: 42, testamento: 'at', grupo: 'Poéticos' },
  { slug: 'salmos', nome: 'Salmos', capitulos: 150, testamento: 'at', grupo: 'Poéticos' },
  { slug: 'proverbios', nome: 'Provérbios', capitulos: 31, testamento: 'at', grupo: 'Poéticos' },
  { slug: 'eclesiastes', nome: 'Eclesiastes', capitulos: 12, testamento: 'at', grupo: 'Poéticos' },
  { slug: 'cantares', nome: 'Cantares', capitulos: 8, testamento: 'at', grupo: 'Poéticos' },
  { slug: 'isaias', nome: 'Isaías', capitulos: 66, testamento: 'at', grupo: 'Profetas maiores' },
  { slug: 'jeremias', nome: 'Jeremias', capitulos: 52, testamento: 'at', grupo: 'Profetas maiores' },
  { slug: 'lamentacoes', nome: 'Lamentações', capitulos: 5, testamento: 'at', grupo: 'Profetas maiores' },
  { slug: 'ezequiel', nome: 'Ezequiel', capitulos: 48, testamento: 'at', grupo: 'Profetas maiores' },
  { slug: 'daniel', nome: 'Daniel', capitulos: 12, testamento: 'at', grupo: 'Profetas maiores' },
  { slug: 'oseias', nome: 'Oseias', capitulos: 14, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'joel', nome: 'Joel', capitulos: 3, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'amos', nome: 'Amós', capitulos: 9, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'obadias', nome: 'Obadias', capitulos: 1, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'jonas', nome: 'Jonas', capitulos: 4, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'miqueias', nome: 'Miqueias', capitulos: 7, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'naum', nome: 'Naum', capitulos: 3, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'habacuque', nome: 'Habacuque', capitulos: 3, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'sofonias', nome: 'Sofonias', capitulos: 3, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'ageu', nome: 'Ageu', capitulos: 2, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'zacarias', nome: 'Zacarias', capitulos: 14, testamento: 'at', grupo: 'Profetas menores' },
  { slug: 'malaquias', nome: 'Malaquias', capitulos: 4, testamento: 'at', grupo: 'Profetas menores' },

  // ── Novo Testamento (27 livros · 260 capítulos) ──
  { slug: 'mateus', nome: 'Mateus', capitulos: 28, testamento: 'nt', grupo: 'Evangelhos' },
  { slug: 'marcos', nome: 'Marcos', capitulos: 16, testamento: 'nt', grupo: 'Evangelhos' },
  { slug: 'lucas', nome: 'Lucas', capitulos: 24, testamento: 'nt', grupo: 'Evangelhos' },
  { slug: 'joao', nome: 'João', capitulos: 21, testamento: 'nt', grupo: 'Evangelhos' },
  { slug: 'atos', nome: 'Atos', capitulos: 28, testamento: 'nt', grupo: 'História' },
  { slug: 'romanos', nome: 'Romanos', capitulos: 16, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: '1corintios', nome: '1 Coríntios', capitulos: 16, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: '2corintios', nome: '2 Coríntios', capitulos: 13, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: 'galatas', nome: 'Gálatas', capitulos: 6, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: 'efesios', nome: 'Efésios', capitulos: 6, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: 'filipenses', nome: 'Filipenses', capitulos: 4, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: 'colossenses', nome: 'Colossenses', capitulos: 4, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: '1tessalonicenses', nome: '1 Tessalonicenses', capitulos: 5, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: '2tessalonicenses', nome: '2 Tessalonicenses', capitulos: 3, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: '1timoteo', nome: '1 Timóteo', capitulos: 6, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: '2timoteo', nome: '2 Timóteo', capitulos: 4, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: 'tito', nome: 'Tito', capitulos: 3, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: 'filemom', nome: 'Filemom', capitulos: 1, testamento: 'nt', grupo: 'Cartas de Paulo' },
  { slug: 'hebreus', nome: 'Hebreus', capitulos: 13, testamento: 'nt', grupo: 'Cartas gerais' },
  { slug: 'tiago', nome: 'Tiago', capitulos: 5, testamento: 'nt', grupo: 'Cartas gerais' },
  { slug: '1pedro', nome: '1 Pedro', capitulos: 5, testamento: 'nt', grupo: 'Cartas gerais' },
  { slug: '2pedro', nome: '2 Pedro', capitulos: 3, testamento: 'nt', grupo: 'Cartas gerais' },
  { slug: '1joao', nome: '1 João', capitulos: 5, testamento: 'nt', grupo: 'Cartas gerais' },
  { slug: '2joao', nome: '2 João', capitulos: 1, testamento: 'nt', grupo: 'Cartas gerais' },
  { slug: '3joao', nome: '3 João', capitulos: 1, testamento: 'nt', grupo: 'Cartas gerais' },
  { slug: 'judas', nome: 'Judas', capitulos: 1, testamento: 'nt', grupo: 'Cartas gerais' },
  { slug: 'apocalipse', nome: 'Apocalipse', capitulos: 22, testamento: 'nt', grupo: 'Profecia' },
]

export const LIVROS_AT = LIVROS.filter((l) => l.testamento === 'at')
export const LIVROS_NT = LIVROS.filter((l) => l.testamento === 'nt')

export const TOTAL_AT = LIVROS_AT.reduce((s, l) => s + l.capitulos, 0) // 929
export const TOTAL_NT = LIVROS_NT.reduce((s, l) => s + l.capitulos, 0) // 260
export const TOTAL_BIBLIA = TOTAL_AT + TOTAL_NT // 1189

const POR_SLUG = new Map(LIVROS.map((l) => [l.slug, l]))
export function getLivro(slug: string): Livro | undefined {
  return POR_SLUG.get(slug)
}

/** Chave de um capítulo no formato guardado no banco: 'salmos:23'. */
export function chaveCapitulo(slug: string, capitulo: number): string {
  return `${slug}:${capitulo}`
}
