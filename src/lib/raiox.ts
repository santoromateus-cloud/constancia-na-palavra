import { createClient } from '@/lib/supabase-server'
import { calcRecorde, calcStreak } from '@/lib/leitura'
import { getEstadoTracker, type Meta } from '@/lib/tracker'
import { LIVROS } from '@/lib/biblia'

// ── O RAIO-X DA CAMINHADA ────────────────
// Uma tela só que responde às três perguntas que fazem a leitora voltar:
//   1. Onde eu parei?      → o caminho ativo, o dia exato e o botão de continuar
//   2. O que eu já andei?  → a constância no calendário, caminho por caminho
//   3. Falta muito?        → a Bíblia inteira e a meta, com o ritmo necessário
//
// A regra que atravessa a tela: ela NUNCA recomeça. Todo caminho já tocado
// guarda o dia em que ela parou, e voltar é um toque. Nada aqui cobra: o que
// está vazio convida, o que está cheio celebra.

export type CaminhoRaioX = {
  id: string
  titulo: string
  totalDias: number
  diasLidos: number
  pct: number
  /** Próximo dia a ler nesse caminho (é onde ela volta). */
  diaAtual: number
  ativo: boolean
  concluido: boolean
}

export type LivroEmAndamento = {
  nome: string
  lidos: number
  capitulos: number
  pct: number
}

export type DiaMarcado = {
  data: string
  /** true = dia de caminho (check-in). false = só capítulo da Bíblia marcado. */
  caminho: boolean
}

export type RaioX = {
  atual: {
    id: string
    titulo: string
    diaAtual: number
    totalDias: number
    pct: number
    referencia: string | null
  } | null
  streak: number
  recorde: number
  espigas: number
  diasDeConstancia: number
  dias: DiaMarcado[]
  primeiraData: string | null
  caminhos: CaminhoRaioX[]
  biblia: {
    pctTotal: number
    totalLidos: number
    lidosAT: number
    lidosNT: number
    pctAT: number
    pctNT: number
    livrosCompletos: number
    meta: Meta | null
    ritmoNecessario: number | null
    diasRestantes: number | null
    emAndamento: LivroEmAndamento[]
  }
}

type UserPlanRow = { plan_id: string; dia_atual: number; ativo: boolean }
type PlanoRow = { id: string; titulo: string; total_dias: number; ordem: number }
type CheckinRow = { plan_id: string; data: string }

export async function getRaioX(): Promise<RaioX | null> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return null

  const [{ data: ups }, { data: planos }, { data: checks }, tracker] = await Promise.all([
    supabase.from('user_plans').select('plan_id, dia_atual, ativo').eq('user_id', user.id),
    supabase.from('reading_plans').select('id, titulo, total_dias, ordem').order('ordem'),
    supabase.from('checkins').select('plan_id, data').eq('user_id', user.id),
    getEstadoTracker(),
  ])

  const userPlans = (ups ?? []) as UserPlanRow[]
  const catalogo = (planos ?? []) as PlanoRow[]
  const checkins = (checks ?? []) as CheckinRow[]

  // ── constância (mesma conta da tela de Hoje, pra não existirem dois números
  //    diferentes pra mesma coisa) ────────────────────
  const datasCheckin = checkins.map((c) => c.data)
  const streak = calcStreak(datasCheckin)
  const recorde = Math.max(calcRecorde(datasCheckin), streak)
  const espigas = datasCheckin.length
  const diasDeConstancia = new Set(datasCheckin).size

  // ── o calendário: dia de caminho vence dia de só-capítulo quando cai no
  //    mesmo dia, porque o check-in é o compromisso maior ──────────────────
  const mapaDias = new Map<string, boolean>()
  for (const d of tracker?.datasLidas ?? []) mapaDias.set(d, false)
  for (const d of datasCheckin) mapaDias.set(d, true)
  const dias: DiaMarcado[] = [...mapaDias.entries()]
    .map(([data, caminho]) => ({ data, caminho }))
    .sort((a, b) => a.data.localeCompare(b.data))
  const primeiraData = dias.length > 0 ? dias[0].data : null

  // ── os caminhos que ela já tocou ─────────────────
  const lidosPorPlano = new Map<string, number>()
  for (const c of checkins) lidosPorPlano.set(c.plan_id, (lidosPorPlano.get(c.plan_id) ?? 0) + 1)

  const porId = new Map(catalogo.map((p) => [p.id, p]))
  const caminhos: CaminhoRaioX[] = userPlans
    .map((up) => {
      const p = porId.get(up.plan_id)
      if (!p) return null
      const diasLidos = lidosPorPlano.get(up.plan_id) ?? 0
      return {
        id: p.id,
        titulo: p.titulo,
        totalDias: p.total_dias,
        diasLidos,
        pct: p.total_dias > 0 ? Math.round((diasLidos / p.total_dias) * 100) : 0,
        diaAtual: Math.min(up.dia_atual, p.total_dias),
        ativo: up.ativo,
        concluido: p.total_dias > 0 && diasLidos >= p.total_dias,
      }
    })
    .filter((c): c is CaminhoRaioX => c !== null)
    // ativo primeiro, depois o que está mais adiantado
    .sort((a, b) => Number(b.ativo) - Number(a.ativo) || b.pct - a.pct)

  // ── onde ela parou: o caminho ativo e a referência do próximo dia ────────
  let atual: RaioX['atual'] = null
  const ativo = caminhos.find((c) => c.ativo)
  if (ativo) {
    const { data: dia } = await supabase
      .from('reading_plan_days')
      .select('referencia')
      .eq('plan_id', ativo.id)
      .eq('dia', ativo.diaAtual)
      .maybeSingle()
    atual = {
      id: ativo.id,
      titulo: ativo.titulo,
      diaAtual: ativo.diaAtual,
      totalDias: ativo.totalDias,
      pct: ativo.pct,
      referencia: (dia as { referencia: string | null } | null)?.referencia ?? null,
    }
  }

  // ── a Bíblia: os livros que ela começou e ainda não fechou ───────────
  const porLivro = tracker?.porLivro ?? {}
  const emAndamento: LivroEmAndamento[] = LIVROS.map((l) => {
    const lidos = (porLivro[l.slug] ?? []).filter((c) => c >= 1 && c <= l.capitulos).length
    return { nome: l.nome, lidos, capitulos: l.capitulos, pct: Math.round((lidos / l.capitulos) * 100) }
  })
    .filter((l) => l.lidos > 0 && l.lidos < l.capitulos)
    .sort((a, b) => b.pct - a.pct || b.lidos - a.lidos)
    .slice(0, 4)

  return {
    atual,
    streak,
    recorde,
    espigas,
    diasDeConstancia,
    dias,
    primeiraData,
    caminhos,
    biblia: {
      pctTotal: tracker?.pctTotal ?? 0,
      totalLidos: tracker?.totalLidos ?? 0,
      lidosAT: tracker?.lidosAT ?? 0,
      lidosNT: tracker?.lidosNT ?? 0,
      pctAT: tracker?.pctAT ?? 0,
      pctNT: tracker?.pctNT ?? 0,
      livrosCompletos: tracker?.livrosCompletos ?? 0,
      meta: tracker?.meta ?? null,
      ritmoNecessario: tracker?.ritmoNecessario ?? null,
      diasRestantes: tracker?.diasRestantes ?? null,
      emAndamento,
    },
  }
}
