import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { createClient as createServerSupabase } from '@/lib/supabase-server'
import { supabaseAdmin } from '@/lib/supabase-admin'
import { ehAdmin } from '@/lib/admin'

// Libera acesso de cortesia (vitalício por padrão) pra uma lista de e-mails.
// SÓ admin pode chamar — a checagem é no SERVIDOR (sessão + lista de admins),
// nunca confia no cliente. Ninguém se auto-libera acesso pago.
const RX_EMAIL = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

export async function POST(request: NextRequest) {
  const supabase = await createServerSupabase()
  const { data: { user } } = await supabase.auth.getUser()
  if (!ehAdmin(user?.email)) {
    return NextResponse.json({ error: 'nao_autorizado' }, { status: 403 })
  }

  let body: { emails?: string; plano?: string }
  try { body = await request.json() } catch { return NextResponse.json({ error: 'json' }, { status: 400 }) }

  // 'free' = cancelar acesso. O valor do plano é a fonte da verdade; status fica
  // 'active' (a concessão é explícita), então cancelar gruda até em admin.
  const ALLOWED = ['free', 'mensal', 'vitalicio']
  const plano = ALLOWED.includes(body.plano ?? '') ? (body.plano as string) : 'vitalicio'
  const brutos = (body.emails || '').split(/[\s,;]+/).map((e) => e.trim().toLowerCase()).filter(Boolean)
  const validos = [...new Set(brutos.filter((e) => RX_EMAIL.test(e)))]
  const invalidos = brutos.filter((e) => !RX_EMAIL.test(e))

  const liberados: string[] = []
  const falhas: string[] = []
  for (const email of validos) {
    const { error } = await supabaseAdmin.from('assinaturas').upsert(
      { email, plano, status: 'active', atualizada_em: new Date().toISOString() },
      { onConflict: 'email' },
    )
    // se a pessoa já tem conta, aplica no perfil também (efeito imediato, sem re-login)
    await supabaseAdmin.from('perfis').update({ plano, assinatura_status: 'active' }).eq('email', email)
    if (error) falhas.push(email); else liberados.push(email)
  }
  return NextResponse.json({ ok: true, plano, liberados, invalidos, falhas })
}
