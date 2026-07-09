import Link from "next/link";
import { getEstadoLeitura } from "@/lib/leitura";
import { liHoje } from "../actions";

export const metadata = { title: "Minha leitura de hoje — Constância na Palavra" };
export const dynamic = "force-dynamic";

export default async function Ler() {
  const estado = await getEstadoLeitura();

  // Sem plano de leitura escolhido → CTA pra /planos.
  if (!estado.temPlano) {
    return (
      <main className="ler-wrap">
        <section className="ler-card ler-empty">
          <span className="ler-kick">Sua leitura</span>
          <h1>Escolha por onde começar.</h1>
          <p className="ler-nota">
            Você ainda não tem um plano de leitura ativo. Escolha um plano e a sua
            primeira leitura já aparece aqui — um dia de cada vez.
          </p>
          <Link href="/planos" className="ler-btn ler-btn-link">Escolher meu plano →</Link>
        </section>
        <style>{sharedCss}</style>
      </main>
    );
  }

  // Plano concluído → medalha.
  if (estado.concluido) {
    return (
      <main className="ler-wrap">
        <section className="ler-card ler-medal">
          <div className="ler-medalha" aria-hidden>🏅</div>
          <span className="ler-kick">Plano concluído</span>
          <h1>Você terminou {estado.plano.titulo}!</h1>
          <p className="ler-nota">
            {estado.totalDias} dias na Palavra, um de cada vez. Que constância linda.
            Pronta pra próxima caminhada?
          </p>
          <div className="ler-stats">
            <div className="ler-stat"><b>🔥 {estado.streak}</b><span>sequência</span></div>
            <div className="ler-stat"><b>{estado.diasLidos}/{estado.totalDias}</b><span>dias lidos</span></div>
          </div>
          <Link href="/planos" className="ler-btn ler-btn-link">Escolher um novo plano →</Link>
        </section>
        <style>{sharedCss}</style>
      </main>
    );
  }

  return (
    <main className="ler-wrap">
      <section className="ler-card">
        <div className="ler-head">
          <span className="ler-kick">Sua leitura de hoje</span>
          <span className="ler-streak" title="dias seguidos na Palavra">🔥 {estado.streak}</span>
        </div>
        <h2 className="ler-plano">{estado.plano.titulo}</h2>

        <div className="ler-prog">
          <div className="ler-prog-bar"><i style={{ width: Math.max(3, estado.progressoPct) + "%" }} /></div>
          <div className="ler-prog-meta">
            Dia {estado.diaAtual} de {estado.totalDias} · {estado.progressoPct}% do plano
          </div>
        </div>

        {estado.jaLeuHoje && (
          <div className="ler-banner">🔥 Você já leu hoje! Quer adiantar o próximo capítulo?</div>
        )}

        <p className="ler-ref">{estado.referencia ?? `Dia ${estado.diaAtual}`}</p>

        {estado.texto ? (
          <div className="ler-texto">{estado.texto}</div>
        ) : (
          <div className="ler-texto ler-texto-vazio">
            O texto deste dia ainda não foi carregado. Abra a sua Bíblia em{" "}
            <b>{estado.referencia ?? `dia ${estado.diaAtual}`}</b> e volte pra marcar.
          </div>
        )}

        <form action={liHoje}>
          <button type="submit" className={"ler-btn" + (estado.jaLeuHoje ? " ler-btn-sec" : "")}>
            {estado.jaLeuHoje ? "Adiantar o próximo capítulo →" : "Li hoje"}
          </button>
        </form>

        <p className="ler-mini">Cada leitura marca o seu dia e segura a sua sequência.</p>
      </section>
      <style>{sharedCss}</style>
    </main>
  );
}

const sharedCss = `
  .ler-wrap{min-height:calc(100vh - 60px);background:var(--creme);padding:24px 18px 60px}
  .ler-card{max-width:680px;margin:0 auto;background:var(--paper);border:1px solid var(--line);border-radius:24px;padding:clamp(24px,4vw,40px);box-shadow:var(--shadow)}
  .ler-head{display:flex;align-items:center;justify-content:space-between;gap:12px}
  .ler-kick{font-size:12px;letter-spacing:2.5px;text-transform:uppercase;font-weight:700;color:var(--coral)}
  .ler-streak{font-size:15px;font-weight:800;color:#b45b3e}
  .ler-plano{font-family:var(--serif);font-size:clamp(20px,2.6vw,26px);margin:10px 0 0;color:var(--base)}
  .ler-prog{margin:18px 0 22px}
  .ler-prog-bar{height:9px;border-radius:6px;background:color-mix(in srgb,var(--coral) 14%,#fff);overflow:hidden}
  .ler-prog-bar i{display:block;height:100%;border-radius:6px;background:var(--coral);transition:width .8s cubic-bezier(.16,1,.3,1)}
  .ler-prog-meta{font-size:12.5px;color:var(--muted);margin-top:6px}
  .ler-banner{background:color-mix(in srgb,var(--verde) 12%,#fff);border:1px solid color-mix(in srgb,var(--verde) 30%,transparent);color:#1f7a6e;border-radius:12px;padding:11px 14px;font-size:13.5px;font-weight:600;margin-bottom:18px}
  .ler-ref{font-family:var(--serif);font-size:clamp(22px,3vw,30px);color:var(--ink);margin:0 0 14px;font-weight:600}
  .ler-texto{white-space:pre-line;font-size:16.5px;line-height:1.7;color:#2b3440;background:color-mix(in srgb,var(--areia) 16%,var(--paper));border-left:4px solid var(--coral);border-radius:0 14px 14px 0;padding:20px 22px;margin-bottom:24px;max-height:52vh;overflow-y:auto}
  .ler-texto-vazio{white-space:normal;color:#54606e;font-style:italic}
  .ler-btn{display:block;width:100%;text-align:center;background:var(--coral);color:#fff;border:none;border-radius:14px;padding:15px;font-family:var(--sans);font-weight:700;font-size:15px;cursor:pointer;transition:.2s}
  .ler-btn:hover{background:#d96f53;transform:translateY(-1px)}
  .ler-btn-sec{background:var(--base)}
  .ler-btn-sec:hover{background:#26384a}
  .ler-btn-link{text-decoration:none}
  .ler-mini{margin-top:16px;font-size:12.5px;color:var(--muted);text-align:center}
  .ler-empty h1,.ler-medal h1{font-family:var(--serif);font-size:clamp(24px,3.2vw,32px);margin:12px 0 10px}
  .ler-nota{font-size:15px;color:#54606e;line-height:1.6;margin-bottom:22px}
  .ler-medal{text-align:center}
  .ler-medalha{font-size:64px;line-height:1;margin-bottom:6px}
  .ler-stats{display:flex;gap:12px;justify-content:center;margin:0 0 22px}
  .ler-stat{background:color-mix(in srgb,var(--base) 5%,var(--paper));border:1px solid var(--line);border-radius:14px;padding:12px 20px;text-align:center}
  .ler-stat b{display:block;font-family:var(--serif);font-size:20px;color:var(--base)}
  .ler-stat span{font-size:12px;color:var(--muted)}
`;
