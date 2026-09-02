import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { createClient as createServerSupabase } from '@/lib/supabase-server'
import { supabaseAdmin } from '@/lib/supabase-admin'
import { ehAdmin } from '@/lib/admin'

export const dynamic = 'force-dynamic'

// ── CURADORIA DO MURAL (admin-only) ───────────────────────────────────────────
// A tabela wall_posts não tem policy de UPDATE de propósito: publicar não é
// coisa que a leitora possa fazer nem por engano. Quem publica é este endereço,
// com service role, depois de re-checar ehAdmin no SERVIDOR — igual às outras
// rotas /api/admin/*. Nunca confiar no cliente.

const LIMITE_FILA = 100
const LIMITE_NO_AR = 30

type Row = {
  id: string
  user_id: string
  texto: string
  referencia: string | null
  criado_em: string
  aprovado: boolean
  recusado: boolean | null
  da_casa: boolean | null
  moderado_em: string | null
}

async function comEmail(rows: Row[]) {
  const ids = [...new Set(rows.map((r) => r.user_id))]
  if (ids.length === 0) return []
  const { data } = await supabaseAdmin.from('perfis').select('id, email').in('id', ids)
  const mapa = new Map((data ?? []).map((p: { id: string; email: string | null }) => [p.id, p.email]))
  return rows.map((r) => ({
    id: r.id,
    texto: r.texto,
    referencia: r.referencia,
    criado_em: r.criado_em,
    autora: mapa.get(r.user_id) ?? '—',
    daCasa: r.da_casa === true,
    moderadoEm: r.moderado_em,
  }))
}

export async function GET() {
  const supabase = await createServerSupabase()
  const { data: { user } } = await supabase.auth.getUser()
  if (!ehAdmin(user?.email)) {
    return NextResponse.json({ error: 'nao_autorizado' }, { status: 403 })
  }

  const [filaRes, noArRes, recusadosRes] = await Promise.all([
    supabaseAdmin
      .from('wall_posts')
      .select('id, user_id, texto, referencia, criado_em, aprovado, recusado, da_casa, moderado_em')
      .eq('aprovado', false).eq('recusado', false)
      .order('criado_em', { ascending: true })
      .limit(LIMITE_FILA),
    supabaseAdmin
      .from('wall_posts')
      .select('id, user_id, texto, referencia, criado_em, aprovado, recusado, da_casa, moderado_em')
      .eq('aprovado', true)
      .order('criado_em', { ascending: false })
      .limit(LIMITE_NO_AR),
    supabaseAdmin
      .from('wall_posts')
      .select('id, user_id, texto, referencia, criado_em, aprovado, recusado, da_casa, moderado_em')
      .eq('recusado', true)
      .order('criado_em', { ascending: false })
      .limit(LIMITE_NO_AR),
  ])

  const [fila, noAr, recusados] = await Promise.all([
    comEmail((filaRes.data ?? []) as Row[]),
    comEmail((noArRes.data ?? []) as Row[]),
    comEmail((recusadosRes.data ?? []) as Row[]),
  ])

  return NextResponse.json({ fila, noAr, recusados })
}

// acao: 'publicar' | 'recusar' | 'tirar'
// tirar = já estava no ar e volta a não estar (o botão de emergência da
// Elisângela). Não apaga nada: o recado da mulher continua existindo.
export async function POST(request: NextRequest) {
  const supabase = await createServerSupabase()
  const { data: { user } } = await supabase.auth.getUser()
  if (!ehAdmin(user?.email)) {
    return NextResponse.json({ error: 'nao_autorizado' }, { status: 403 })
  }

  let body: { id?: string; acao?: string }
  try { body = await request.json() } catch { return NextResponse.json({ error: 'json' }, { status: 400 }) }

  const id = (body.id ?? '').trim()
  const acao = body.acao ?? ''
  if (!id) return NextResponse.json({ error: 'sem_id' }, { status: 400 })

  const patch =
    acao === 'publicar' ? { aprovado: true, recusado: false, moderado_em: new Date().toISOString() }
    : acao === 'recusar' ? { aprovado: false, recusado: true, moderado_em: new Date().toISOString() }
    : acao === 'tirar' ? { aprovado: false, recusado: true, moderado_em: new Date().toISOString() }
    : null

  if (!patch) return NextResponse.json({ error: 'acao_invalida' }, { status: 400 })

  const { error } = await supabaseAdmin.from('wall_posts').update(patch).eq('id', id)
  if (error) return NextResponse.json({ error: 'falha' }, { status: 500 })
  return NextResponse.json({ ok: true, id, acao })
}
