import { NextResponse } from 'next/server'
import { createClient as createServerSupabase } from '@/lib/supabase-server'
import { supabaseAdmin } from '@/lib/supabase-admin'
import { ehAdmin } from '@/lib/admin'

export const dynamic = 'force-dynamic'

// Lista todos os usuários pro painel /admin (admin-only, checado no servidor).
// Une CONTAS (perfis, quem já logou) + CONCESSÕES (assinaturas, quem foi liberado
// mas talvez ainda não logou). O perfil tem precedência (é o estado sincronizado).
export async function GET() {
  const supabase = await createServerSupabase()
  const { data: { user } } = await supabase.auth.getUser()
  if (!ehAdmin(user?.email)) {
    return NextResponse.json({ error: 'nao_autorizado' }, { status: 403 })
  }

  const [perfisRes, assinaturasRes] = await Promise.all([
    supabaseAdmin.from('perfis').select('email, plano, assinatura_status'),
    supabaseAdmin.from('assinaturas').select('email, plano, status'),
  ])

  const map = new Map<string, { email: string; plano: string; status: string | null; origem: string }>()
  for (const a of assinaturasRes.data ?? []) {
    if (!a.email) continue
    map.set(a.email, { email: a.email, plano: a.status === 'active' ? (a.plano ?? 'free') : 'free', status: a.status, origem: 'concessão' })
  }
  for (const p of perfisRes.data ?? []) {
    if (!p.email) continue
    map.set(p.email, { email: p.email, plano: p.plano ?? 'free', status: p.assinatura_status, origem: 'conta' })
  }
  const usuarios = [...map.values()].sort((x, y) => x.email.localeCompare(y.email))
  return NextResponse.json({ usuarios, total: usuarios.length })
}
