import { createServerClient, type CookieOptions } from '@supabase/ssr'
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { supabaseAdmin } from '@/lib/supabase-admin'
import { ehAdmin } from '@/lib/admin'

type CookieToSet = { name: string; value: string; options: CookieOptions }

export async function GET(request: NextRequest) {
  const { searchParams, origin } = new URL(request.url)
  const code = searchParams.get('code')
  const next = searchParams.get('next') ?? '/ler'

  if (code) {
    const response = NextResponse.redirect(`${origin}${next}`)
    const supabase = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
      {
        cookies: {
          getAll: () => request.cookies.getAll(),
          setAll: (cookiesToSet: CookieToSet[]) => {
            cookiesToSet.forEach(({ name, value, options }) =>
              response.cookies.set(name, value, options)
            )
          },
        },
      }
    )
    const { data, error } = await supabase.auth.exchangeCodeForSession(code)
    if (!error) {
      // garante o perfil e sincroniza o plano a partir da assinatura (Hotmart),
      // cobrindo o caso de quem pagou ANTES de criar a conta.
      try {
        const user = data?.user
        if (user?.email) {
          const email = user.email.toLowerCase()
          const nome = (user.user_metadata?.name as string) ?? (user.user_metadata?.full_name as string) ?? null
          await supabaseAdmin.from('perfis').upsert({ id: user.id, email, nome }, { onConflict: 'id' })
          // plano autoritativo: assinatura ativa (compra/concessão) vence; admin só
          // cai no vitalício-padrão quando não há assinatura ativa (fix 07/07/2026).
          const { data: ass } = await supabaseAdmin
            .from('assinaturas').select('plano, status').eq('email', email).maybeSingle()
          const assinaturaAtiva = ass && ass.status === 'active' ? ass.plano : null
          const plano = assinaturaAtiva ?? (ehAdmin(email) ? 'vitalicio' : 'free')
          const statusP = ass?.status ?? (ehAdmin(email) ? 'active' : null)
          await supabaseAdmin.from('perfis')
            .update({ plano, assinatura_status: statusP }).eq('id', user.id)
        }
      } catch (e) {
        console.warn('sync de plano no login falhou (não bloqueia):', e)
      }
      return response
    }
  }
  return NextResponse.redirect(`${origin}/login?error=auth_failed`)
}
