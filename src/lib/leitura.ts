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
      /** Total de dias lidos em TODOS os planos — é o tamanho da Lavra dela. */
      espigas: number
      /** Recorde de dias seguidos, pra celebrar o recomeço sem apagar o passado. */
      recorde: number
      /** A Pérola do dia: um versículo tirado do texto que ela acabou de ler. */
      perola: { n: number; texto: string } | null
      /** Dias de Graça no cofre (1 a cada 7 de constância, teto 3). */
      gracas: number
      /** As camadas do dia (migration 009/010). Só existem nos caminhos que
       *  têm essa prática — nos outros vêm null e a tela não mostra nada. */
      camadas: CamadasDoDia
    }

/** O que vem POR CIMA do texto bíblico naquele dia, quando o caminho tem.
 *  Comentário só aparece com autor E obra: a 009 tem CHECK no banco pra isso,
 *  porque citar sem creditar não é uma decisão que se deixa na disciplina. */
export type CamadasDoDia = {
  comentario: string | null
  comentarioAutor: string | null
  comentarioObra: string | null
  geografia: string | null
  geografiaLugar: string | null
  curiosidade: string | null
  fonte: string | null
}

const SEM_CAMADAS: CamadasDoDia = {
  comentario: null,
  comentarioAutor: null,
  comentarioObra: null,
  geografia: null,
  geografiaLugar: null,
  curiosidade: null,
  fonte: null,
}

function hojeISO(): string {
  return new Date().toISOString().slice(0, 10)
}

/** Maior sequência de dias de calendário já alcançada (o recorde dela). */
export function calcRecorde(datas: string[]): number {
  const ordenadas = [...new Set(datas)].sort()
  if (ordenadas.length === 0) return 0
  let melhor = 1
  let atual = 1
  for (let i = 1; i < ordenadas.length; i++) {
    const anterior = new Date(ordenadas[i - 1] + 'T00:00:00Z').getTime()
    const agora = new Date(ordenadas[i] + 'T00:00:00Z').getTime()
    atual = agora - anterior === 86_400_000 ? atual + 1 : 1
    if (atual > melhor) melhor = atual
  }
  return melhor
}

/**
 * A PÉROLA do dia: um versículo tirado do texto que ela acabou de ler.
 *
 * Decisão de curadoria: em vez de um catálogo separado de versículos (que
 * precisaria ser curado e verificado à parte), a joia sai do PRÓPRIO capítulo
 * do dia. Vantagem dupla — não inventa nada e não depende de fonte nova, e a
 * pérola conversa com o que ela leu naquele minuto em vez de ser aleatória.
 *
 * A escolha é determinística pelo dia do plano: a mesma leitora, no mesmo dia,
 * vê sempre a mesma pérola. Nada de sorteio que muda ao recarregar a página.
 */
export function extrairPerola(texto: string | null, dia: number): { n: number; texto: string } | null {
  if (!texto) return null
  // O texto vem no formato "1 No princípio...\n2 E a terra era sem forma..."
  const versiculos: { n: number; texto: string }[] = []
  for (const linha of texto.split('\n')) {
    const m = linha.match(/^\s*(\d+)\s+(.+)$/)
    if (!m) continue
    const corpo = m[2].trim()
    // versículo curto demais não vira joia; longo demais não cabe no card
    if (corpo.length < 60 || corpo.length > 260) continue
    versiculos.push({ n: Number(m[1]), texto: corpo })
  }
  if (versiculos.length === 0) return null
  return versiculos[(dia * 7) % versiculos.length]
}

/** Dias de Graça: 1 a cada 7 dias de constância acumulada, teto 3.
 *  REGRA DURA do doc de gamificação: graça NUNCA é vendida, só conquistada. */
export function calcGracas(diasLidos: number, usadas = 0): number {
  return Math.max(0, Math.min(3, Math.floor(diasLidos / 7) - usadas))
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
  let camadas: CamadasDoDia = SEM_CAMADAS
  // Duas tentativas de propósito. O select COM as camadas depende das colunas
  // da migration 009; num banco onde ela ainda não rodou, o PostgREST devolve
  // erro de coluna inexistente e a leitora ficaria sem o TEXTO do dia por causa
  // de um recurso que ela nem tem. Se o primeiro select falhar, cai pro select
  // antigo e a tela funciona igual, só sem as camadas.
  // (Regra que este projeto aprendeu do jeito ruim: o código nunca pode quebrar
  // esperando um asset ou uma migration que ainda não subiu.)
  let dayRow: Record<string, string | null> | null = null
  const comCamadas = await supabase
    .from('reading_plan_days')
    .select(
      'referencia, texto, comentario, comentario_autor, comentario_obra, geografia, geografia_lugar, curiosidade, fonte',
    )
    .eq('plan_id', up.plan_id)
    .eq('dia', diaAtual)
    .maybeSingle()
  if (comCamadas.error) {
    const basico = await supabase
      .from('reading_plan_days')
      .select('referencia, texto')
      .eq('plan_id', up.plan_id)
      .eq('dia', diaAtual)
      .maybeSingle()
    dayRow = (basico.data ?? null) as Record<string, string | null> | null
  } else {
    dayRow = (comCamadas.data ?? null) as Record<string, string | null> | null
  }

  if (dayRow) {
    const d = dayRow as Record<string, string | null>
    referencia = d.referencia
    texto = d.texto
    camadas = {
      comentario: d.comentario ?? null,
      comentarioAutor: d.comentario_autor ?? null,
      comentarioObra: d.comentario_obra ?? null,
      geografia: d.geografia ?? null,
      geografiaLugar: d.geografia_lugar ?? null,
      curiosidade: d.curiosidade ?? null,
      fonte: d.fonte ?? null,
    }
  }

  const progressoPct = p.total_dias > 0 ? Math.round((diasLidos / p.total_dias) * 100) : 0

  // A Lavra, a Candeia e o recorde são da LEITORA, não do plano.
  //
  // Corrigido em 01/09/2026, visto em produção: a sequência e o recorde saíam
  // dos checkins do plano ATIVO enquanto a Lavra contava todos. Dava a tela
  // absurda "31 dias na Palavra · recorde 0 dias" pra quem tinha acabado de
  // trocar de caminho. Ler é ler: quem leu ontem em Provérbios e hoje em João
  // não quebrou sequência nenhuma. Progresso e porcentagem seguem do plano;
  // constância é da pessoa.
  const { data: todosChecks } = await supabase
    .from('checkins')
    .select('data')
    .eq('user_id', user.id)
  const datasTodas = ((todosChecks ?? []) as { data: string }[]).map((c) => c.data)
  const espigas = datasTodas.length || diasLidos

  const streak = calcStreak(datasTodas)
  const jaLeuHoje = datasTodas.includes(hojeISO())
  const recorde = Math.max(calcRecorde(datasTodas), streak)
  const perola = extrairPerola(texto, diaAtual)
  const gracas = calcGracas(espigas)

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
    espigas,
    recorde,
    perola,
    gracas,
    camadas,
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

/** Dias lidos por plano, pra desenhar a trilha e o progresso de cada caminho.
 *  Uma consulta só, agrupada na aplicação — a leitora tem poucos planos. */
export async function getProgressoPorPlano(): Promise<Record<string, number>> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return {}

  const { data } = await supabase.from('checkins').select('plan_id').eq('user_id', user.id)
  const mapa: Record<string, number> = {}
  for (const linha of (data ?? []) as { plan_id: string }[]) {
    mapa[linha.plan_id] = (mapa[linha.plan_id] ?? 0) + 1
  }
  return mapa
}
