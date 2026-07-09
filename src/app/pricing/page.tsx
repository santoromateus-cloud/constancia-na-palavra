'use client'

import Link from 'next/link'

// ─── Links do Hotmart (preencher via env vars no Vercel quando os produtos existirem) ───
// Constância: Mensal R$39,90 e Vitalício R$397 — os dois dão o MESMO acesso.
// Fallback seguro = /pricing (nunca href="#"). Enquanto os produtos não existem, o
// botão volta pra esta própria página em vez de morrer.
const HOTMART_MENSAL = process.env.NEXT_PUBLIC_HOTMART_MENSAL_URL || '/pricing'
const HOTMART_VITALICIO = process.env.NEXT_PUBLIC_HOTMART_VITALICIO_URL || '/pricing'

const card: React.CSSProperties = {
  background: 'var(--paper)', border: '1px solid var(--line)', borderRadius: 22,
  padding: 32, boxShadow: 'var(--shadow-sm)', display: 'flex', flexDirection: 'column',
}
const feat: React.CSSProperties = { display: 'flex', alignItems: 'flex-start', gap: 10, fontSize: 14.5, color: '#46505f', lineHeight: 1.5 }
const check = <span aria-hidden style={{ color: 'var(--verde)', fontWeight: 800, marginTop: 1 }}>✓</span>

export default function PricingPage() {
  return (
    <main style={{ minHeight: '100vh' }}>
      <style>{`
        @keyframes cnpPulse{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.35;transform:scale(.65)}}
        @keyframes cnpSheen{0%{background-position:-180% 0}60%,100%{background-position:180% 0}}
        .prelaunch{position:relative;overflow:hidden}
        .prelaunch::after{content:"";position:absolute;inset:0;background:linear-gradient(100deg,transparent 30%,rgba(255,255,255,.5) 50%,transparent 70%);background-size:200% 100%;animation:cnpSheen 4.5s ease-in-out infinite;pointer-events:none}
        .pdot{width:8px;height:8px;border-radius:50%;background:#e07a5f;animation:cnpPulse 1.6s ease-in-out infinite;flex:none}
        @media (prefers-reduced-motion: reduce){.prelaunch::after{animation:none}.pdot{animation:none}}
      `}</style>

      {/* Faixa de pré-lançamento (animada) */}
      <div className="prelaunch" style={{ background: 'var(--areia)', color: '#5a4a2a', textAlign: 'center', fontSize: 13, fontWeight: 600, padding: '9px 16px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 9 }}>
        <span className="pdot" aria-hidden />
        <span>Pré-lançamento — preço de fundadoras. Vai subir em breve.</span>
      </div>

      {/* Nav */}
      <nav style={{
        position: 'sticky', top: 0, zIndex: 50, backdropFilter: 'blur(12px)',
        background: 'color-mix(in srgb, var(--creme) 86%, transparent)',
        borderBottom: '1px solid var(--line)',
      }}>
        <div style={{ maxWidth: 1080, margin: '0 auto', height: 66, padding: '0 24px', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <Link href="/" style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <span className="serif" style={{ fontWeight: 700, fontSize: 17, color: 'var(--ink)' }}>Constância na Palavra</span>
          </Link>
          <Link href="/login" className="btn-ghost" style={{ fontWeight: 600, fontSize: 14, color: 'var(--base)' }}>Entrar</Link>
        </div>
      </nav>

      <div style={{ maxWidth: 900, margin: '0 auto', padding: 'clamp(40px,6vw,76px) 24px 90px' }}>

        {/* Header */}
        <header style={{ textAlign: 'center', maxWidth: 660, margin: '0 auto clamp(40px,5vw,60px)' }} className="reveal d1">
          <span className="kick" style={{ justifyContent: 'center' }}>Planos</span>
          <h1 style={{ fontSize: 'clamp(34px,5vw,58px)', lineHeight: 1.03, margin: '18px 0 0' }}>
            Escolha como começar.{' '}
            <span style={{ color: 'var(--coral)', fontStyle: 'italic', fontWeight: 500 }}>Os dois abrem tudo.</span>
          </h1>
          <p style={{ fontSize: 'clamp(16px,1.5vw,18px)', color: '#46505f', margin: '20px auto 0', maxWidth: '52ch', lineHeight: 1.6 }}>
            Mensal ou vitalício, o acesso é o mesmo: sua leitura da Bíblia todos os dias, a
            sequência que segura sua constância e a companhia das irmãs no mural.
          </p>
        </header>

        {/* Cards */}
        <section style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: 22, alignItems: 'stretch' }}>

          {/* Mensal */}
          <article style={card} className="reveal d2">
            <p style={{ fontSize: 11.5, fontWeight: 700, letterSpacing: 1.4, textTransform: 'uppercase', color: 'var(--muted)' }}>Mensal</p>
            <div style={{ display: 'flex', alignItems: 'baseline', gap: 5, margin: '14px 0 2px' }}>
              <span className="serif" style={{ fontSize: 52, fontWeight: 600, color: 'var(--ink)' }}>R$39,90</span>
              <span style={{ color: 'var(--muted)', fontSize: 15 }}>/mês</span>
            </div>
            <p style={{ fontSize: 13.5, color: 'var(--muted)', marginBottom: 26 }}>Cancele quando quiser</p>
            <ul style={{ listStyle: 'none', display: 'flex', flexDirection: 'column', gap: 12, marginBottom: 28, flex: 1 }}>
              {['Sua leitura da Bíblia todos os dias', 'A sequência que segura sua constância', 'O mural da comunidade', 'Um versículo pra guardar por dia'].map(f => (
                <li key={f} style={feat}>{check}{f}</li>
              ))}
            </ul>
            <a href={HOTMART_MENSAL} target={HOTMART_MENSAL.startsWith('http') ? '_blank' : undefined} rel="noopener noreferrer" className="btn btn-google" style={{ justifyContent: 'center' }}>Assinar o mensal →</a>
          </article>

          {/* Vitalício */}
          <article style={{ ...card, border: '1.5px solid var(--coral)', boxShadow: 'var(--shadow)', position: 'relative' }} className="reveal d3">
            <span style={{
              position: 'absolute', top: -13, left: '50%', transform: 'translateX(-50%)',
              background: 'var(--coral)', color: '#fff', fontSize: 11, fontWeight: 700,
              padding: '5px 16px', borderRadius: 999, letterSpacing: 0.8, textTransform: 'uppercase', whiteSpace: 'nowrap',
            }}>Acesso pra sempre</span>
            <p style={{ fontSize: 11.5, fontWeight: 700, letterSpacing: 1.4, textTransform: 'uppercase', color: 'var(--coral)' }}>Vitalício</p>
            <div style={{ display: 'flex', alignItems: 'baseline', gap: 5, margin: '14px 0 2px' }}>
              <span className="serif" style={{ fontSize: 52, fontWeight: 600, color: 'var(--ink)' }}>R$397</span>
              <span style={{ color: 'var(--muted)', fontSize: 15 }}>uma vez</span>
            </div>
            <p style={{ fontSize: 12.5, color: 'var(--coral)', fontWeight: 600, marginBottom: 16 }}>Pague uma vez, sem mensalidade</p>
            <p style={{ fontSize: 12.5, fontWeight: 700, color: 'var(--ink)', marginBottom: 12 }}>Tudo do mensal, mais:</p>
            <ul style={{ listStyle: 'none', display: 'flex', flexDirection: 'column', gap: 12, marginBottom: 28, flex: 1 }}>
              {['Acesso pra sempre, sem cobrança mensal', 'Sua constância sem data pra acabar', 'O melhor custo pra quem vem pra ficar'].map(f => (
                <li key={f} style={feat}>{check}{f}</li>
              ))}
            </ul>
            <a href={HOTMART_VITALICIO} target={HOTMART_VITALICIO.startsWith('http') ? '_blank' : undefined} rel="noopener noreferrer" className="btn btn-primary" style={{ justifyContent: 'center' }}>Quero o vitalício →</a>
          </article>
        </section>

        {/* Reassurance */}
        <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'center', gap: '14px 28px', marginTop: 40, fontSize: 13, color: 'var(--muted)' }} className="reveal d5">
          <span>🔒 Pagamento seguro pela Hotmart</span>
          <span>↩️ Mensal: cancele quando quiser</span>
          <span>📖 Um dia de cada vez, na Palavra</span>
        </div>

        {/* Contato */}
        <p style={{ textAlign: 'center', marginTop: 30, fontSize: 14, color: 'var(--muted)' }} className="reveal d6">
          Dúvidas? Fala com a gente: <a href="mailto:ola@constancianapalavra.com.br" style={{ color: 'var(--coral)', fontWeight: 600 }}>ola@constancianapalavra.com.br</a>
        </p>
      </div>
    </main>
  )
}
