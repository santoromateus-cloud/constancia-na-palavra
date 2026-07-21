import { listarPlanos, getPlanoAtivo } from "@/lib/leitura";
import { ativarPlano } from "../actions";

export const metadata = { title: "Planos de leitura — Constância na Palavra" };
export const dynamic = "force-dynamic";

export default async function Planos() {
  const [planos, ativo] = await Promise.all([listarPlanos(), getPlanoAtivo()]);
  const ativoId = ativo?.plan_id ?? null;

  return (
    <main className="pl-wrap">
      <header className="pl-head">
        <span className="pl-kick">Planos de leitura</span>
        <h1>Escolha a sua caminhada.</h1>
        <p className="pl-sub">
          Um capítulo por dia, na ordem certa. Escolha um plano e a leitura de hoje
          já aparece em <b>Ler</b>. Você pode trocar quando quiser — seu progresso fica salvo.
        </p>
      </header>

      {planos.length === 0 ? (
        <p className="pl-vazio">Nenhum plano disponível ainda. Volte em breve.</p>
      ) : (
        <section className="pl-grid">
          {planos.map((p) => {
            const isAtivo = p.id === ativoId;
            return (
              <article key={p.id} className={"pl-card" + (isAtivo ? " on" : "")}>
                {isAtivo && <span className="pl-badge">Plano atual</span>}
                <h2>{p.titulo}</h2>
                <p className="pl-desc">{p.descricao}</p>
                <div className="pl-dias">{p.total_dias} dias · 1 capítulo por dia</div>
                <form action={ativarPlano.bind(null, p.id)}>
                  <button type="submit" className={"pl-btn" + (isAtivo ? " pl-btn-sec" : "")}>
                    {isAtivo ? "Continuar lendo →" : "Começar este plano →"}
                  </button>
                </form>
              </article>
            );
          })}
        </section>
      )}

      <style>{`
        .pl-wrap{min-height:calc(100vh - 60px);background:var(--creme);padding:28px 18px 60px}
        .pl-head{max-width:680px;margin:0 auto 26px;text-align:center}
        .pl-kick{font-size:12px;letter-spacing:2.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .pl-head h1{font-family:var(--serif);font-size:clamp(26px,3.6vw,38px);margin:12px 0 0}
        .pl-sub{font-size:15px;color:#6C5C45;line-height:1.6;margin:14px auto 0;max-width:52ch}
        .pl-grid{max-width:680px;margin:0 auto;display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:18px}
        .pl-card{position:relative;background:var(--paper);border:1px solid var(--line);border-radius:20px;padding:26px;box-shadow:var(--shadow-sm);display:flex;flex-direction:column}
        .pl-card.on{border:1.5px solid var(--coral);box-shadow:var(--shadow)}
        .pl-badge{position:absolute;top:-11px;left:22px;background:var(--coral);color:#FCF8EF;font-size:10.5px;font-weight:700;letter-spacing:.6px;text-transform:uppercase;padding:4px 11px;border-radius:999px}
        .pl-card h2{font-family:var(--serif);font-size:22px;color:var(--base);margin:0 0 8px}
        .pl-desc{font-size:14px;color:#6C5C45;line-height:1.55;flex:1}
        .pl-dias{font-size:12.5px;color:var(--muted);font-weight:600;margin:16px 0 18px}
        .pl-btn{display:block;width:100%;text-align:center;background:var(--coral);color:#FCF8EF;border:none;border-radius:13px;padding:14px;font-family:var(--sans);font-weight:700;font-size:14.5px;cursor:pointer;transition:.2s}
        .pl-btn:hover{background:#47512C;transform:translateY(-1px)}
        .pl-btn-sec{background:var(--base)}
        .pl-btn-sec:hover{background:#2E2416}
        .pl-vazio{text-align:center;color:var(--muted);font-size:15px;margin-top:40px}
      `}</style>
    </main>
  );
}
