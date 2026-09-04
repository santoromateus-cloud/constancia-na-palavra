import { LIVROS, getLivro } from '@/lib/biblia'

// ── O leitor da Bíblia (camada GRÁTIS) ───────────────────────────────────────
// Navegação entre capítulos na ordem canônica: Gênesis 50 → Êxodo 1, Malaquias 4 →
// Mateus 1. O texto em si vem de src/data/biblia (gerado no build); aqui só a
// aritmética de "anterior" e "próximo", que a tela usa nas setas e no botão de
// continuar.

export type RefCapitulo = { slug: string; nome: string; capitulo: number }

export type Vizinhos = {
  anterior: RefCapitulo | null
  proximo: RefCapitulo | null
  /** true quando `proximo` já é o capítulo 1 de outro livro (ou não existe) */
  fimDoLivro: boolean
}

export function vizinhos(slug: string, capitulo: number): Vizinhos {
  const i = LIVROS.findIndex((l) => l.slug === slug)
  const livro = LIVROS[i]
  if (!livro) return { anterior: null, proximo: null, fimDoLivro: true }

  let anterior: RefCapitulo | null = null
  if (capitulo > 1) anterior = { slug, nome: livro.nome, capitulo: capitulo - 1 }
  else if (i > 0) {
    const prev = LIVROS[i - 1]
    anterior = { slug: prev.slug, nome: prev.nome, capitulo: prev.capitulos }
  }

  let proximo: RefCapitulo | null = null
  const fimDoLivro = capitulo >= livro.capitulos
  if (!fimDoLivro) proximo = { slug, nome: livro.nome, capitulo: capitulo + 1 }
  else if (i < LIVROS.length - 1) {
    const next = LIVROS[i + 1]
    proximo = { slug: next.slug, nome: next.nome, capitulo: 1 }
  }

  return { anterior, proximo, fimDoLivro }
}

/** Valida o par (slug, capítulo) vindo da URL. Devolve null para qualquer coisa fora do cânon. */
export function validarCapitulo(slug: string, capituloBruto: string): { slug: string; capitulo: number } | null {
  const livro = getLivro(slug)
  if (!livro) return null
  if (!/^\d{1,3}$/.test(capituloBruto)) return null
  const capitulo = Number(capituloBruto)
  if (capitulo < 1 || capitulo > livro.capitulos) return null
  return { slug, capitulo }
}
