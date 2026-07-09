import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { supabaseAdmin } from '@/lib/supabase-admin'

// Webhook do Hotmart (v2). Compra aprovada -> libera o plano pro e-mail do comprador.
// Fonte da verdade = tabela `assinaturas` (por e-mail). `perfis.plano` é sincronizado
// aqui (se a pessoa já tem conta) e também no login (callback), caso pague antes de logar.

// Oferta -> plano. Constância: mensal (R$39,90) e vitalício (R$397) dão o MESMO acesso.
const OFFER_MENSAL = (process.env.HOTMART_OFFER_MENSAL ?? '').trim()
const OFFER_VITALICIO = (process.env.HOTMART_OFFER_VITALICIO ?? '').trim()

function planoDaOferta(off?: string | null): 'mensal' | 'vitalicio' {
  if (off && off.trim() === OFFER_VITALICIO) return 'vitalicio'
  return 'mensal' // default seguro (assinatura mensal)
}

const ATIVA = new Set(['PURCHASE_APPROVED', 'PURCHASE_COMPLETE'])
const CANCELA = new Set([
  'PURCHASE_REFUNDED', 'PURCHASE_CHARGEBACK', 'PURCHASE_PROTEST',
  'PURCHASE_CANCELED', 'PURCHASE_EXPIRED', 'SUBSCRIPTION_CANCELLATION',
])

// procura uma chave em qualquer profundidade do objeto (payload do Hotmart varia)
function pegar(obj: unknown, chaves: string[]): string | null {
  const visto = new Set<unknown>()
  const fila: unknown[] = [obj]
  while (fila.length) {
    const cur = fila.shift()
    if (!cur || typeof cur !== 'object' || visto.has(cur)) continue
    visto.add(cur)
    for (const [k, v] of Object.entries(cur as Record<string, unknown>)) {
      if (chaves.includes(k) && (typeof v === 'string' || typeof v === 'number')) return String(v)
      if (v && typeof v === 'object') fila.push(v)
    }
  }
  return null
}

export async function POST(request: NextRequest) {
  let body: unknown
  try { body = await request.json() } catch { return NextResponse.json({ ok: false }, { status: 400 }) }

  // valida o hottok (header ou corpo). Enquanto a env não estiver setada, aceita (só ativa por evento).
  const token = process.env.HOTMART_WEBHOOK_TOKEN
  const hottok = request.headers.get('x-hotmart-hottok') || pegar(body, ['hottok']) || ''
  if (token && hottok !== token) return NextResponse.json({ ok: false, erro: 'token' }, { status: 401 })

  const evento = pegar(body, ['event']) || ''
  const email = (pegar(body, ['email']) || '').toLowerCase().trim()
  const off = pegar(body, ['code', 'offer_code', 'off'])  // código da oferta comprada
  const subscriberCode = pegar(body, ['subscriber_code'])
  const transaction = pegar(body, ['transaction'])

  if (!email) return NextResponse.json({ ok: true, ignored: 'sem_email' })

  // Idempotência (bug conhecido #11 — provider reenvia o mesmo webhook 2-3x, retry de
  // rede). O upsert por e-mail já converge pro mesmo estado, mas sem transaction isso
  // reprocessa e reloga o mesmo evento várias vezes. Sem `transaction` no payload, segue
  // sem dedupe (alguns eventos da Hotmart não trazem) — degrada, não bloqueia.
  if (transaction) {
    const { error: dupErr } = await supabaseAdmin
      .from('webhook_transacoes_processadas')
      .insert({ transaction, evento })
    if (dupErr) {
      // violação de PK = já processamos esse (transaction, evento) exato -> ignora, idempotente
      return NextResponse.json({ ok: true, duplicado: true })
    }
  }

  if (ATIVA.has(evento)) {
    const plano = planoDaOferta(off)
    await supabaseAdmin.from('assinaturas').upsert({
      email, plano, status: 'active',
      hotmart_subscriber_code: subscriberCode, hotmart_transaction: transaction,
      atualizada_em: new Date().toISOString(),
    }, { onConflict: 'email' })
    await supabaseAdmin.from('perfis')
      .update({ plano, assinatura_status: 'active', hotmart_subscriber_code: subscriberCode })
      .eq('email', email)
    await logEvento('compra_aprovada', email, { plano, evento, transaction })
    return NextResponse.json({ ok: true, plano })
  }

  if (CANCELA.has(evento)) {
    await supabaseAdmin.from('assinaturas')
      .update({ status: 'cancelled', atualizada_em: new Date().toISOString() }).eq('email', email)
    await supabaseAdmin.from('perfis')
      .update({ plano: 'free', assinatura_status: 'cancelled' }).eq('email', email)
    await logEvento('cancelamento', email, { evento, transaction })
    return NextResponse.json({ ok: true, cancelado: true })
  }

  return NextResponse.json({ ok: true, ignored: evento })
}

// instrumentação mínima (Auditoria FST): badge B1/B2/B4 leem daqui. Nunca bloqueia o webhook.
async function logEvento(tipo: string, email: string, metadata: Record<string, unknown>) {
  try {
    await supabaseAdmin.from('eventos').insert({ tipo, email, metadata })
  } catch (e) {
    console.warn('log de evento do webhook falhou (não bloqueia):', e)
  }
}
