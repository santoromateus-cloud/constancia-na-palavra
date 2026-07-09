import { createClient } from '@/lib/supabase-server'

// ── Mural da comunidade (server-side) ─────────────────────────────────────────
// Roda com o client de sessão (RLS): qualquer autenticada lê os posts aprovados e
// as reações; cada uma só cria o SEU post e a SUA reação (toggle). Sem IA.
// Privacidade: não expomos e-mail/nome de outras usuárias (RLS de perfis é própria),
// então os posts aparecem sem identificação pessoal — "uma irmã".

export type ReacaoTipo = 'amem' | 'orando'

export type MuralPost = {
  id: string
  texto: string
  referencia: string | null
  criado_em: string
  souAutora: boolean
  reacoes: Record<ReacaoTipo, number>
  minhasReacoes: Record<ReacaoTipo, boolean>
}

const LIMITE_POSTS = 50
export const MAX_TEXTO = 500

/** Lista os posts aprovados (mais recentes) com contagem de reações e o que a usuária já reagiu. */
export async function listarMural(): Promise<MuralPost[]> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()

  const { data: postsData } = await supabase
    .from('wall_posts')
    .select('id, user_id, texto, referencia, criado_em')
    .eq('aprovado', true)
    .order('criado_em', { ascending: false })
    .limit(LIMITE_POSTS)

  const posts = (postsData ?? []) as {
    id: string
    user_id: string
    texto: string
    referencia: string | null
    criado_em: string
  }[]
  if (posts.length === 0) return []

  const ids = posts.map((p) => p.id)
  const { data: reacoesData } = await supabase
    .from('wall_reactions')
    .select('post_id, tipo, user_id')
    .in('post_id', ids)

  const reacoes = (reacoesData ?? []) as { post_id: string; tipo: ReacaoTipo; user_id: string }[]

  return posts.map((p) => {
    const doPost = reacoes.filter((r) => r.post_id === p.id)
    const conta = (tipo: ReacaoTipo) => doPost.filter((r) => r.tipo === tipo).length
    const minha = (tipo: ReacaoTipo) => !!user && doPost.some((r) => r.tipo === tipo && r.user_id === user.id)
    return {
      id: p.id,
      texto: p.texto,
      referencia: p.referencia,
      criado_em: p.criado_em,
      souAutora: !!user && p.user_id === user.id,
      reacoes: { amem: conta('amem'), orando: conta('orando') },
      minhasReacoes: { amem: minha('amem'), orando: minha('orando') },
    }
  })
}

/** Publica um post no mural (auto-aprovado). */
export async function publicarPost(texto: string, referencia: string | null): Promise<{ ok: boolean; erro?: string }> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { ok: false, erro: 'nao_logada' }

  const t = (texto ?? '').trim().slice(0, MAX_TEXTO)
  if (!t) return { ok: false, erro: 'vazio' }
  const ref = (referencia ?? '').trim().slice(0, 120) || null

  const { error } = await supabase.from('wall_posts').insert({
    user_id: user.id,
    texto: t,
    referencia: ref,
    aprovado: true,
  })
  return error ? { ok: false, erro: 'falha' } : { ok: true }
}

/** Alterna (toggle) uma reação da usuária num post. */
export async function alternarReacao(postId: string, tipo: ReacaoTipo): Promise<{ ok: boolean }> {
  const supabase = await createClient()
  const {
    data: { user },
  } = await supabase.auth.getUser()
  if (!user) return { ok: false }
  if (tipo !== 'amem' && tipo !== 'orando') return { ok: false }

  const { data: existente } = await supabase
    .from('wall_reactions')
    .select('id')
    .eq('post_id', postId)
    .eq('user_id', user.id)
    .eq('tipo', tipo)
    .maybeSingle()

  if (existente) {
    await supabase.from('wall_reactions').delete().eq('id', (existente as { id: string }).id)
  } else {
    await supabase.from('wall_reactions').insert({ post_id: postId, user_id: user.id, tipo })
  }
  return { ok: true }
}
