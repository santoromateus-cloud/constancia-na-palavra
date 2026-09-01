import { createClient } from '@/lib/supabase-server'
import { LIVROS, LIVROS_AT, LIVROS_NT, TOTAL_AT, TOTAL_BIBLIA, TOTAL_NT, getLivro } from '@/lib/biblia'

// ── Camada GRÁTIS: o marcador de capítulos ────────────────────────────────────
// Roda com o client de SESSÃO da leitora (RLS garante que ela só toca no que é
// dela). Não exige assinatura: é a porta de entrada do produto. Marcar = insert,
// desmarcar = delete (sem linha = não lido).

export type ProgressoLivro = {
  slug: string
  nome: string
  capitulos: number
  lidos: number[]
  pct: number
}

export type Meta = {
  data_inicio: string
  data_fim: string
  escopo: 'biblia' | 'at' | 'nt'
}

export type EstadoTracker = {
  porLivro: Record<string, number[]>
  totalLidos: number
  lidosAT: number
  lidosNT: number
  pctTotal: number
  pctAT: number
  pctNT: number
  meta: Meta | null
  ritmoNecessario: number | null
  diasRestantes: number | null
  livrosCompletos: number
  datasLidas: string[]
}

type LinhaProgresso = { livro: string; capitulo: number; lido_em: string }

function hojeISO(): string {
  return new Date().toISOString().slice(0, 10)
}

/** Estado completo da tela /biblia: o que já foi lido, os percentuais e a meta. */
export async function getEstadoTracker(): Promise<EstadoTracker | null> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return null

  const [{ data: linhas }, { data: metaRow }] = await Promise.all([
    supabase.from('biblia_progresso').select('livro, capitulo, lido_em').eq('user_id', user.id),
    supabase
      .from('meta_leitura')
      .select('data_inicio, data_fim, escopo')
      .eq('user_id', user.id)
      .maybeSingle(),
  ])

  const rows = (linhas ?? []) as LinhaProgresso[]

  const porLivro: Record<string, number[]> = {}
  const datas = new Set<string>()
  for (const r of rows) {
    if (!getLivro(r.livro)) continue // ignora slug órfão em vez de inflar o total
    ;(porLivro[r.livro] ??= []).push(r.capitulo)
    if (r.lido_em) datas.add(r.lido_em)
  }
  for (const slug of Object.keys(porLivro)) porLivro[slug].sort((a, b) => a - b)

  const contar = (livros: typeof LIVROS) =>
    livros.reduce((soma, l) => {
      const marcados = porLivro[l.slug]
      if (!marcados) return soma
      // clamp: um capítulo além do total do livro não pode inflar o percentual
      return soma + marcados.filter((c) => c >= 1 && c <= l.capitulos).length
    }, 0)

  const lidosAT = contar(LIVROS_AT)
  const lidosNT = contar(LIVROS_NT)
  const totalLidos = lidosAT + lidosNT

  const livrosCompletos = LIVROS.filter(
    (l) => (porLivro[l.slug]?.filter((c) => c >= 1 && c <= l.capitulos).length ?? 0) >= l.capitulos,
  ).length

  const meta = (metaRow as Meta | null) ?? null
  let ritmoNecessario: number | null = null
  let diasRestantes: number | null = null
  if (meta) {
    const fim = new Date(meta.data_fim + 'T00:00:00Z')
    const hoje = new Date(hojeISO() + 'T00:00:00Z')
    diasRestantes = Math.ceil((fim.getTime() - hoje.getTime()) / 86_400_000)
    const alvo = meta.escopo === 'at' ? TOTAL_AT : meta.escopo === 'nt' ? TOTAL_NT : TOTAL_BIBLIA
    const jaLidos = meta.escopo === 'at' ? lidosAT : meta.escopo === 'nt' ? lidosNT : totalLidos
    const faltam = Math.max(alvo - jaLidos, 0)
    // meta vencida (ou vencendo hoje) → mostra o que falta, não divide por zero
    ritmoNecessario = diasRestantes > 0 ? Math.round((faltam / diasRestantes) * 10) / 10 : faltam
  }

  const pct = (n: number, total: number) => (total > 0 ? Math.round((n / total) * 100) : 0)

  return {
    porLivro,
    totalLidos,
    lidosAT,
    lidosNT,
    pctTotal: pct(totalLidos, TOTAL_BIBLIA),
    pctAT: pct(lidosAT, TOTAL_AT),
    pctNT: pct(lidosNT, TOTAL_NT),
    meta,
    ritmoNecessario,
    diasRestantes,
    livrosCompletos,
    datasLidas: [...datas].sort(),
  }
}
