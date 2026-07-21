// Paywall de ASSINATURA — mostrado na área logada quando a irmã está autenticada
// mas sem plano ativo (mensal/vitalicio). Dois planos que dão o MESMO acesso.
// Checkout via env (Vercel); fallback seguro = /pricing (nunca href="#").
const HOTMART_MENSAL = process.env.NEXT_PUBLIC_HOTMART_MENSAL_URL || "/pricing";
const HOTMART_VITALICIO = process.env.NEXT_PUBLIC_HOTMART_VITALICIO_URL || "/pricing";

export default function Paywall() {
  return (
    <main className="pw-wrap">
      <section className="pw-card">
        <span className="pw-kick">Constância na Palavra</span>
        <h1>Um dia de cada vez, na Palavra — com as irmãs.</h1>
        <p className="pw-sub">
          Falta só um passo pra começar a sua caminhada diária na Bíblia, com
          acompanhamento e a companhia da comunidade. Escolha como quer começar —
          os dois planos abrem tudo.
        </p>

        <div className="pw-plans">
          <div className="pw-plan">
            <b>Mensal</b>
            <span className="pw-price">R$39,90<small>/mês</small></span>
            <p>Sua leitura diária, o acompanhamento e o mural. Cancele quando quiser.</p>
            <a className="pw-btn pw-btn-ghost" href={HOTMART_MENSAL} target="_blank" rel="noopener noreferrer">
              Começar no mensal →
            </a>
          </div>
          <div className="pw-plan pw-plan-dest">
            <span className="pw-tag">Acesso pra sempre</span>
            <b>Vitalício</b>
            <span className="pw-price">R$397<small> uma vez</small></span>
            <p>O mesmo acesso, pago uma única vez. Sua constância sem data pra acabar.</p>
            <a className="pw-btn pw-btn-primary" href={HOTMART_VITALICIO} target="_blank" rel="noopener noreferrer">
              Quero o vitalício →
            </a>
          </div>
        </div>

        <a className="pw-skip" href="/pricing">Ver os planos com calma</a>
      </section>

      <style>{`
        .pw-wrap{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:32px 20px;background:var(--creme)}
        .pw-card{position:relative;background:var(--paper);border:1px solid var(--line);border-radius:24px;padding:clamp(26px,4vw,44px);max-width:640px;width:100%;box-shadow:var(--shadow)}
        .pw-kick{font-size:12px;letter-spacing:2.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .pw-card h1{font-family:var(--serif);font-size:clamp(26px,3.4vw,36px);line-height:1.1;margin:12px 0 0}
        .pw-sub{font-size:15px;color:#6C5C45;line-height:1.6;margin:16px 0 26px;max-width:52ch}
        .pw-plans{display:grid;grid-template-columns:1fr 1fr;gap:16px}
        .pw-plan{border:1px solid var(--line);border-radius:18px;padding:20px;display:flex;flex-direction:column;gap:8px;position:relative;background:var(--paper)}
        .pw-plan-dest{border-color:var(--coral);border-width:1.5px;box-shadow:var(--shadow-sm)}
        .pw-plan b{font-family:var(--serif);font-size:18px;color:var(--ink)}
        .pw-tag{position:absolute;top:-11px;left:50%;transform:translateX(-50%);background:var(--coral);color:#FCF8EF;font-size:10px;font-weight:700;padding:4px 12px;border-radius:999px;white-space:nowrap;letter-spacing:.5px;text-transform:uppercase}
        .pw-price{font-family:var(--serif);font-size:30px;font-weight:600;color:var(--base)}
        .pw-price small{font-size:13px;font-weight:500;color:var(--muted)}
        .pw-plan p{font-size:13px;color:#6C5C45;line-height:1.5;margin:0 0 6px;flex:1}
        .pw-btn{display:flex;align-items:center;justify-content:center;border-radius:12px;padding:13px;font-weight:700;font-size:14.5px;text-decoration:none;transition:.2s}
        .pw-btn-primary{background:var(--coral);color:#FCF8EF}
        .pw-btn-primary:hover{background:#47512C;transform:translateY(-1px)}
        .pw-btn-ghost{background:transparent;border:1px solid var(--line);color:var(--ink)}
        .pw-btn-ghost:hover{border-color:var(--coral);color:var(--coral)}
        .pw-skip{display:block;text-align:center;margin-top:22px;font-size:13px;color:var(--muted);text-decoration:underline}
        @media(max-width:520px){.pw-plans{grid-template-columns:1fr}}
      `}</style>
    </main>
  );
}
