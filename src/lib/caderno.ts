import { createClient } from '@/lib/supabase-server'

// ── O CADERNO (camada paga) ───────────────────────────────────────────────
// Quatro perguntas sobre o capítulo que ela acabou de ler:
//   uma promessa · uma ordem · um princípio · um passo
//
// A regra que atravessa o recurso: as três primeiras são OPCIONAIS, o passo é
// obrigatório. Nem todo capítulo tem promessa ou ordem, e um formulário que
// exige as quatro todo dia ensina a inventar o que não está no texto. O passo
// sempre existe, porque sempre dá pra fazer alguma coisa com o que se leu.
//
// Privacidade: RLS de dono, sem exceção. O caderno não vai pro mural nem
// anonimamente — é onde ela escreve o que não contaria pra ninguém.

export const MAX_CAMPO = 600

export type EntradaCaderno = {
  id: string
  planId: string | null
  dia: number | null
  referencia: string | null
  data: string
  promessa: string | null
  ordem: string | null
  principio: string | null
  passo: string
  perola: { n: number; texto: string } | null
  criadoEm: string
}

export type ResumoCaderno = {
  total: number
  promessas: number
  ordens: number
  principios: number
  primeiraData: string | null
}

type LinhaCaderno = {
  id: string
  plan_id: string | null
  dia: number | null
  referencia: string | null
  data: string
  promessa: string | null
  ordem: string | null
  principio: string | null
  passo: string
  perola_n: number | null
  perola_texto: string | null
  criado_em: string
}

const COLUNAS =
  'id, plan_id, dia, referencia, data, promessa, ordem, principio, passo, perola_n, perola_texto, criado_em'

function daLinha(l: LinhaCaderno): EntradaCaderno {
  return {
    id: l.id,
    planId: l.plan_id,
    dia: l.dia,
    referencia: l.referencia,
    data: l.data,
    promessa: l.promessa,
    ordem: l.ordem,
    principio: l.principio,
    passo: l.passo,
    perola: l.perola_n !== null && l.perola_texto ? { n: l.perola_n, texto: l.perola_texto } : null,
    criadoEm: l.criado_em,
  }
}

/** Limpa e corta um campo. Vazio vira null (não guardamos string em branco). */
function limpar(v: string | null | undefined): string | null {
  const t = (v ?? '').trim().slice(0, MAX_CAMPO)
  return t.length > 0 ? t : null
}

/** A entrada que ela já escreveu para este dia do caminho (ou null). */
export async function getEntradaDoDia(planId: string, dia: number): Promise<EntradaCaderno | null> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return null

  const { data } = await supabase
    .from('caderno')
    .select(COLUNAS)
    .eq('user_id', user.id)
    .eq('plan_id', planId)
    .eq('dia', dia)
    .maybeSingle()

  return data ? daLinha(data as LinhaCaderno) : null
}

/** A estante dela: tudo o que já escreveu, do mais novo para o mais antigo. */
export async function listarCaderno(limite = 200): Promise<EntradaCaderno[]> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return []

  const { data } = await supabase
    .from('caderno')
    .select(COLUNAS)
    .eq('user_id', user.id)
    .order('criado_em', { ascending: false })
    .limit(limite)

  return ((data ?? []) as LinhaCaderno[]).map(daLinha)
}

/** Os números do caderno para o Raio-X. Uma consulta só, contada aqui. */
export async function getResumoCaderno(): Promise<ResumoCaderno> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  const vazio: ResumoCaderno = { total: 0, promessas: 0, ordens: 0, principios: 0, primeiraData: null }
  if (!user) return vazio

  const { data } = await supabase
    .from('caderno')
    .select('promessa, ordem, principio, criado_em')
    .eq('user_id', user.id)
    .order('criado_em', { ascending: true })

  const linhas = (data ?? []) as {
    promessa: string | null
    ordem: string | null
    principio: string | null
    criado_em: string
  }[]
  if (linhas.length === 0) return vazio

  return {
    total: linhas.length,
    promessas: linhas.filter((l) => !!l.promessa).length,
    ordens: linhas.filter((l) => !!l.ordem).length,
    principios: linhas.filter((l) => !!l.principio).length,
    primeiraData: linhas[0].criado_em.slice(0, 10),
  }
}

export type EntradaInput = {
  planId: string
  dia: number
  referencia: string | null
  promessa: string | null
  ordem: string | null
  principio: string | null
  passo: string
  perola: { n: number; texto: string } | null
}

/**
 * Grava a entrada do dia. Read-then-write em vez de upsert: o índice único
 * (user_id, plan_id, dia) existe como rede de proteção, mas a inferência de
 * ON CONFLICT pelo PostgREST com colunas anuláveis é frágil demais para uma
 * escrita que é texto de gente.
 */
export async function salvarEntrada(e: EntradaInput): Promise<{ ok: boolean; erro?: string }> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { ok: false, erro: 'nao_logada' }

  const passo = limpar(e.passo)
  if (!passo) return { ok: false, erro: 'sem_passo' }

  const campos = {
    referencia: limpar(e.referencia),
    promessa: limpar(e.promessa),
    ordem: limpar(e.ordem),
    principio: limpar(e.principio),
    passo,
    perola_n: e.perola?.n ?? null,
    perola_texto: e.perola ? e.perola.texto.slice(0, 1000) : null,
    atualizado_em: new Date().toISOString(),
  }

  const { data: existente } = await supabase
    .from('caderno')
    .select('id')
    .eq('user_id', user.id)
    .eq('plan_id', e.planId)
    .eq('dia', e.dia)
    .maybeSingle()

  const { error } = existente
    ? await supabase.from('caderno').update(campos).eq('id', (existente as { id: string }).id)
    : await supabase.from('caderno').insert({
        user_id: user.id,
        plan_id: e.planId,
        dia: e.dia,
        ...campos,
      })

  return error ? { ok: false, erro: 'falha' } : { ok: true }
}

/** Apaga uma entrada. É dela: se ela quer tirar, tira. */
export async function apagarEntrada(id: string): Promise<{ ok: boolean }> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { ok: false }

  const { error } = await supabase.from('caderno').delete().eq('id', id).eq('user_id', user.id)
  return { ok: !error }
}
