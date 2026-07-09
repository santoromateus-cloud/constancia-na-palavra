import { supabaseAdmin } from '@/lib/supabase-admin'
import { ehAdmin } from '@/lib/admin'

// ── Gating do Constância na Palavra ───────────────────────────────────────────
// O Constância NÃO tem cota de uso. O acesso é BINÁRIO: quem tem plano ativo
// (mensal OU vitalício) entra na área logada /ler; quem está no free vê o paywall.
// Os dois planos pagos dão o MESMO acesso.

export type Perfil = { plano: string | null }

const PLANOS_ATIVOS = new Set(['mensal', 'vitalicio'])

/** True se o perfil tem um plano pago ativo (mensal ou vitalício). Gate server-side. */
export function temAcesso(perfil: Perfil | null | undefined): boolean {
  return !!perfil && PLANOS_ATIVOS.has((perfil.plano ?? '').toLowerCase())
}

// ── Garante a ficha (perfis) — FAIL-CLOSED (bug corrigido 06/07/2026) ──────────
// O gate antigo lia a ficha com .single(); quando a linha NÃO existia (o callback
// que cria o perfil no login não estava no ar), caía num fallback silencioso e o
// acesso ficava inconsistente. Agora: sem ficha -> cria na hora, puxando o plano da
// assinatura Hotmart pelo e-mail (cobre quem pagou ANTES de ter conta). NÃO troque o
// .maybeSingle() por .single() — é uma armadilha já paga (o .single() estoura quando
// não há linha e derruba o gate).
export async function ensurePerfil(userId: string, email?: string | null): Promise<Perfil> {
  const mail = email ? email.toLowerCase() : null
  const admin = ehAdmin(mail)

  // Plano autoritativo: uma assinatura ATIVA (compra Hotmart OU concessão do /admin)
  // VENCE o padrão do admin. O admin só cai no vitalício-padrão quando NÃO existe
  // assinatura ativa. Assim, liberar mensal a um admin gruda (fix 07/07/2026).
  let assPlano: string | null = null
  let assStatus: string | null = null
  if (mail) {
    const { data: ass } = await supabaseAdmin
      .from('assinaturas').select('plano, status').eq('email', mail).maybeSingle()
    if (ass) {
      assStatus = ass.status
      if (ass.status === 'active') assPlano = ass.plano
    }
  }
  const planoAlvo = assPlano ?? (admin ? 'vitalicio' : 'free')
  const statusAlvo = assStatus ?? (admin ? 'active' : null)

  const { data } = await supabaseAdmin
    .from('perfis')
    .select('plano')
    .eq('id', userId)
    .maybeSingle()
  if (data) {
    // reconcilia ficha desatualizada com o plano autoritativo
    if (data.plano !== planoAlvo) {
      await supabaseAdmin.from('perfis')
        .update({ plano: planoAlvo, assinatura_status: statusAlvo }).eq('id', userId)
      return { plano: planoAlvo }
    }
    return { plano: data.plano }
  }
  await supabaseAdmin.from('perfis').upsert(
    { id: userId, email: mail, plano: planoAlvo, assinatura_status: statusAlvo },
    { onConflict: 'id' },
  )
  return { plano: planoAlvo }
}
