import { createClient } from '@/lib/supabase-server'

// ── Lógica de leitura (server-side) do Constância na Palavra ───────────────────
// Tudo roda com o client de SESSÃO da usuária (RLS garante que ela só toca no que é
// dela). Sem IA, sem cota — o gate de assinatura é feito no layout da área logada.
// Modelo: dia_atual = próximo dia a ler; cada check-in registra um dia concluído e
// avança dia_atual. Streak = dias de calendário consecutivos com pelo menos 1 leitura.

export type PlanoLeitura = {
  id: string
  slug: string
  titulo: string
  descricao: string | null
  total_dias: number
  ordem: number
}

export type EstadoLeitura =
  | { temPlano: false }
  | {
      temPlano: true
      plano: PlanoLeitura
      diaAtual: number
      totalDias: number
      referencia: string | null
      texto: string | null
      jaLeuHoje: boolean
      streak: number
      diasLidos: number
      progressoPct: number
      concluido: boolean
    }

function hojeISO(): string {
  return new Date().toISOString().slice(0, 10)
}

/** Streak = quantos dias de calendário consecutivos, terminando hoje ou ontem, têm leitura. */
export function calcStreak(datas: string[]): number {
  const set = new Set(datas)
  if (set.size === 0) return 0
  const iso = (d: Date) => d.toISOString().slice(0, 10)
  const cursor = new Date()
  // âncora: se não leu hoje, tenta ontem; se nem ontem, a sequência está quebrada
  if (!set.has(iso(cursor))) {
    cursor.setUTCDate(cursor.getUTCDate() - 1)
    if (!set.has(iso(cursor))) return 0
  }
  let streak = 0
  while (set.has(iso(cursor))) {
    streak++
    cursor.setUTCDate(cursor.getUTCDate() - 1)
  }
  return streak
}

/** Todos os planos ativos do catálogo, na ordem definida. */
export async function listarPlanos(): Promise<PlanoLeitura[]> {
  const supabase = await createClient()
  const { data } = await supabase
    .from('reading_plans')
    .select('id, slug, titulo, descricao, total_dias, ordem')
    .eq('ativo', true)
    .order('ordem', { ascending: true })
  return (data ?? []) as PlanoLeitura[]
}

type UserPlanRow = { id: string; plan_id: string; dia_atual: number; ativo: boolean }

/** O user_plan ativo da usuária (ou null). */
export async function getPlanoAtivo(): Promise<UserPlanRow | null> {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return null
  const { data } = await supabase
    .from('user_plans')
    .select('id, plan_id, dia_atual, ativo')
    .eq('user_id', user.id)
    .eq('ativo', true)
    .maybeSingle()
  return (data as UserPlanRow | null) ?? null
}

/** Estado completo da tela /ler: dia atual, texto, streak, progresso, conclusão. */
export async function getEstadoLeitura(): Promise<EstadoLeitura> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { temPlano: false }

  const up = await getPlanoAtivo()
  if (!up) return { temPlano: false }

  const { data: plano } = await supabase
    .from('reading_plans')
    .select('id, slug, titulo, descricao, total_dias, ordem')
    .eq('id', up.plan_id)
    .maybeSingle()
  if (!plano) return { temPlano: false }

  const p = plano as PlanoLeitura

  const { data: checks } = await supabase
    .from('checkins')
    .select('data, dia')
    .eq('user_id', user.id)
    .eq('plan_id', up.plan_id)
  const datas = ((checks ?? []) as { data: string; dia: number }[]).map((c) => c.data)
  const diasLidos = datas.length
  const concluido = diasLidos >= p.total_dias
  const diaAtual = Math.min(up.dia_atual, p.total_dias)

  let referencia: string | null = null
  let texto: string | null = null
  const { data: dayRow } = await supabase
    .from('reading_plan_days')
    .select('referencia, texto')
    .eq('plan_id', up.plan_id)
    .eq('dia', diaAtual)
    .maybeSingle()
  if (dayRow) {
    referencia = (dayRow as { referencia: string | null }).referencia
    texto = (dayRow as { texto: string | null }).texto
  }

  const streak = calcStreak(datas)
  const jaLeuHoje = datas.includes(hojeISO())
  const progressoPct = p.total_dias > 0 ? Math.round((diasLidos / p.total_dias) * 100) : 0

  return {
    temPlano: true,
    plano: p,
    diaAtual,
    totalDias: p.total_dias,
    referencia,
    texto,
    jaLeuHoje,
    streak,
    diasLidos,
    progressoPct,
    concluido,
  }
}

export type CheckinResult = {
  ok: boolean
  motivo?: 'sem_plano' | 'concluido'
  novoCheckin?: boolean
  concluido?: boolean
}

/** Registra a leitura do dia atual (idempotente por dia de plano) e avança o dia. */
export async function registrarCheckin(): Promise<CheckinResult> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { ok: false, motivo: 'sem_plano' }

  const up = await getPlanoAtivo()
  if (!up) return { ok: false, motivo: 'sem_plano' }

  const { data: plano } = await supabase
    .from('reading_plans')
    .select('total_dias')
    .eq('id', up.plan_id)
    .maybeSingle()
  const totalDias = (plano as { total_dias: number } | null)?.total_dias ?? 0

  const dia = Math.min(up.dia_atual, totalDias)

  // insert idempotente: se o dia já foi lido, ignoreDuplicates não devolve linha
  const { data: inserted } = await supabase
    .from('checkins')
    .upsert(
      { user_id: user.id, plan_id: up.plan_id, dia, data: hojeISO() },
      { onConflict: 'user_id,plan_id,dia', ignoreDuplicates: true },
    )
    .select('id')

  const novoCheckin = !!(inserted && inserted.length > 0)

  if (novoCheckin && dia < totalDias) {
    await supabase.from('user_plans').update({ dia_atual: dia + 1 }).eq('id', up.id)
  }

  // conclusão: nº de check-ins alcançou o total de dias
  const { count } = await supabase
    .from('checkins')
    .select('id', { count: 'exact', head: true })
    .eq('user_id', user.id)
    .eq('plan_id', up.plan_id)
  const concluido = (count ?? 0) >= totalDias && totalDias > 0

  return { ok: true, novoCheckin, concluido }
}

/** Escolhe/ativa um plano de leitura: desativa o atual e (re)ativa o escolhido. */
export async function escolherPlano(planId: string): Promise<{ ok: boolean }> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { ok: false }

  // desativa qualquer plano ativo atual
  await supabase
    .from('user_plans')
    .update({ ativo: false })
    .eq('user_id', user.id)
    .eq('ativo', true)

  // reativa se já existir (preserva progresso), senão cria do dia 1
  const { data: existente } = await supabase
    .from('user_plans')
    .select('id')
    .eq('user_id', user.id)
    .eq('plan_id', planId)
    .maybeSingle()

  if (existente) {
    await supabase.from('user_plans').update({ ativo: true }).eq('id', (existente as { id: string }).id)
  } else {
    await supabase.from('user_plans').insert({
      user_id: user.id,
      plan_id: planId,
      dia_atual: 1,
      ativo: true,
    })
  }
  return { ok: true }
}
