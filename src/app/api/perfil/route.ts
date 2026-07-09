import { NextResponse } from 'next/server'
import { createClient as createServerSupabase } from '@/lib/supabase-server'
import { ensurePerfil, temAcesso } from '@/lib/quota'
import { ehAdmin } from '@/lib/admin'

// Estado da conta pro front (selo do plano na página /conta e no /admin).
// Self-healing: ensurePerfil cria a ficha se ela não existir (fix 06/07/2026) e
// sincroniza o plano a partir da assinatura Hotmart pelo e-mail.
export const dynamic = 'force-dynamic'

export async function GET() {
  const supabase = await createServerSupabase()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return NextResponse.json({ logado: false })

  const perfil = await ensurePerfil(user.id, user.email)
  const nome =
    (user.user_metadata?.name as string) ??
    (user.user_metadata?.full_name as string) ??
    null

  return NextResponse.json({
    logado: true,
    email: user.email ?? null,
    nome,
    plano: perfil.plano ?? 'free',
    acesso: temAcesso(perfil),
    admin: ehAdmin(user.email),
  })
}
