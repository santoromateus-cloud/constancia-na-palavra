import { listarPlanos, getPlanoAtivo, getProgressoPorPlano } from "@/lib/leitura";
import { ativarPlano } from "../actions";
import { IconeGeografia } from "../Icones";
import Trilha from "./Trilha";

export const metadata = { title: "Os caminhos — Constância na Palavra" };
export const dynamic = "force-dynamic";

/* Os caminhos: a trilha do caminho ativo (Trilha.tsx) + os outros
   caminhos pra trocar. Trocar não perde progresso — a Lavra é da leitora. */

export default async function Planos() {
  const [planos, ativo, progresso] = await Promise.all([
    listarPlanos(),
    getPlanoAtivo(),
    getProgressoPorPlano(),
  ]);
  const ativoId = ativo?.plan_id ?? null;
  const planoAtivo = planos.find((p) => p.id === ativoId) ?? null;
  const lidosAtivo = ativoId ? (progresso[ativoId] ?? 0) : 0;
  const outros = planos.filter((p) => p.id !== ativoId);

  return (
    <main className="cm">
      {planoAtivo && (
        <section className="trilha-box">
          <header className="tr-head">
            <div>
              <span className="tr-kick">
                <IconeGeografia size={14} /> Caminho atual
              </span>
              <h1>{planoAtivo.titulo}</h1>
            </div>
            <div className="tr-cont">
              <b className="tnum">{lidosAtivo}</b>
              <span>de {planoAtivo.total_dias}</span>
            </div>
          </header>

          <Trilha totalDias={planoAtivo.total_dias} lidos={lidosAtivo} />

          <p className="tr-frase">
            {lidosAtivo === 0
              ? "O primeiro nó está aceso esperando você."
              : lidosAtivo >= planoAtivo.total_dias
                ? "Caminho inteiro percorrido. Escolha o próximo aqui embaixo."
                : `Faltam ${planoAtivo.total_dias - lidosAtivo} ${planoAtivo.total_dias - lidosAtivo === 1 ? "dia" : "dias"} para o fim deste caminho.`}
          </p>
        </section>
      )}

      <header className="cm-head">
        <span className="cm-kick">{planoAtivo ? "Trocar de caminho" : "Os caminhos"}</span>
        <h2>{planoAtivo ? "Outros caminhos abertos" : "Escolha a sua caminhada."}</h2>
        <p>
          Você troca de caminho quando quiser e o seu progresso continua guardado — a Lavra é
          sua, não do plano. Nada do que você já leu se perde.
        </p>
      </header>

      {outros.length === 0 && !planoAtivo ? (
        <p className="cm-vazio">Nenhum caminho disponível ainda.</p>
      ) : (
        <section className="cm-grid">
          {outros.map((p) => {
            const lidos = progresso[p.id] ?? 0;
            const pct = p.total_dias > 0 ? Math.round((lidos / p.total_dias) * 100) : 0;
            return (
              <article key={p.id} className="cm-card">
                <div className="cm-anel">
                  <svg viewBox="0 0 72 72" width="72" height="72" aria-hidden>
                    <circle cx="36" cy="36" r="32" fill="none" stroke="var(--line)" strokeWidth="3" />
                    <circle
                      cx="36" cy="36" r="32" fill="none"
                      stroke="url(#cmOuro)" strokeWidth="3.4" strokeLinecap="round"
                      strokeDasharray={2 * Math.PI * 32}
                      strokeDashoffset={2 * Math.PI * 32 * (1 - pct / 100)}
                      transform="rotate(-90 36 36)"
                    />
                    <defs>
                      <linearGradient id="cmOuro" x1="0" y1="0" x2="1" y2="1">
                        <stop offset="0%" stopColor="#C9A85C" />
                        <stop offset="100%" stopColor="#6A7A42" />
                      </linearGradient>
                    </defs>
                  </svg>
                  <b className="tnum">{p.total_dias}</b>
                </div>
                <h3>{p.titulo}</h3>
                <p>{p.descricao}</p>
                {lidos > 0 && (
                  <span className="cm-retomar">
                    Você parou no dia {lidos}. Continua de lá.
                  </span>
                )}
                <form action={ativarPlano.bind(null, p.id)}>
                  <button type="submit" className="cm-btn">
                    {lidos > 0 ? "Retomar este caminho →" : "Começar este caminho →"}
                  </button>
                </form>
              </article>
            );
          })}
        </section>
      )}

      <style>{`
        .cm{max-width:760px;margin:0 auto;padding:clamp(18px,3.4vw,30px) clamp(14px,4vw,20px) 90px}

        /* ---------- TRILHA ---------- */
        .trilha-box{background:var(--paper);border:1px solid var(--line);border-radius:26px;padding:clamp(20px,3.6vw,30px);box-shadow:var(--shadow-sm);margin-bottom:34px}
        .tr-head{display:flex;align-items:flex-start;justify-content:space-between;gap:16px;margin-bottom:6px}
        .tr-kick{display:inline-flex;align-items:center;gap:7px;font-size:11.5px;letter-spacing:1.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .tr-head h1{font-family:var(--display);font-size:clamp(24px,3.8vw,34px);line-height:1.08;margin:9px 0 0;color:var(--ink)}
        .tr-cont{text-align:right;flex:none}
        .tr-cont b{font-family:var(--display);font-size:30px;color:var(--base);display:block;line-height:1}
        .tr-cont span{font-size:11.5px;color:var(--muted)}

        .trilha{position:relative;margin:24px 0 6px}
        .tr-fio{position:absolute;inset:0;width:100%;height:100%}
        .no{
          position:absolute;transform:translate(-50%,-50%);
          width:46px;height:46px;border-radius:50%;
          display:flex;align-items:center;justify-content:center;
          background:var(--paper);border:2px solid var(--line);color:var(--muted);
          font-size:13px;font-weight:700;
          transition:transform .2s cubic-bezier(.34,1.56,.64,1),box-shadow .25s;
        }
        .no i{font-style:normal}
        .no:hover{transform:translate(-50%,-50%) scale(1.12)}
        .no.marco{width:54px;height:54px}

        /* dia já lido: espiga dourada em campo cheio */
        .no.feito{
          background:linear-gradient(145deg,#D8BC77,#A98634);
          border-color:transparent;color:#FCF8EF;
          box-shadow:0 6px 16px -6px rgba(143,109,30,.65);
        }
        /* dia de hoje: a candeia, pulsando — é pra onde o olho vai */
        .no.hoje{
          background:linear-gradient(145deg,#63703F,#454F2B);
          border-color:transparent;color:#F2E2B4;width:58px;height:58px;
          box-shadow:0 0 0 0 rgba(106,122,66,.55);
          animation:noPulsa 2.1s ease-out infinite;
          z-index:2;
        }
        @keyframes noPulsa{
          0%{box-shadow:0 0 0 0 rgba(106,122,66,.5)}
          70%{box-shadow:0 0 0 16px rgba(106,122,66,0)}
          100%{box-shadow:0 0 0 0 rgba(106,122,66,0)}
        }
        .tr-frase{font-family:var(--serif);font-style:italic;font-size:14px;color:var(--muted);text-align:center;margin-top:14px}

        /* ---------- escolher caminho ---------- */
        .cm-head{text-align:center;max-width:560px;margin:0 auto 22px}
        .cm-kick{font-size:11.5px;letter-spacing:1.6px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .cm-head h2{font-family:var(--display);font-size:clamp(22px,3.4vw,30px);line-height:1.1;margin:11px 0 0}
        .cm-head p{font-size:14.5px;line-height:1.6;color:#6C5C45;margin:12px 0 0}

        .cm-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(248px,1fr));gap:16px}
        .cm-card{
          background:var(--paper);border:1px solid var(--line);border-radius:22px;
          padding:26px 22px 22px;box-shadow:var(--shadow-sm);
          display:flex;flex-direction:column;align-items:center;text-align:center;
          transition:transform .26s cubic-bezier(.16,1,.3,1),box-shadow .26s,border-color .26s;
        }
        .cm-card:hover{transform:translateY(-4px);box-shadow:var(--shadow);border-color:color-mix(in srgb,var(--ambar) 52%,var(--line))}
        .cm-anel{position:relative;width:72px;height:72px;display:grid;place-items:center;margin-bottom:12px}
        .cm-anel svg{position:absolute;inset:0}
        .cm-anel b{font-family:var(--display);font-size:26px;color:var(--base)}
        .cm-card h3{font-family:var(--display);font-weight:400;font-size:20px;color:var(--ink);margin:0 0 8px;line-height:1.15}
        .cm-card p{font-size:13.5px;line-height:1.55;color:#6C5C45;flex:1;margin-bottom:16px}
        .cm-retomar{display:block;font-family:var(--serif);font-style:italic;font-size:12.5px;color:var(--ouro);margin-bottom:14px}
        .cm-btn{
          width:100%;font-family:var(--sans);font-weight:700;font-size:14.5px;color:#FCF8EF;
          background:linear-gradient(140deg,#63703F,#4A5430);border:0;border-radius:14px;
          padding:14px;cursor:pointer;transition:transform .2s,box-shadow .2s;
          box-shadow:0 10px 22px -12px rgba(74,84,48,.85);
        }
        .cm-btn:hover{transform:translateY(-2px);box-shadow:0 16px 28px -14px rgba(74,84,48,.9)}
        .cm-vazio{text-align:center;color:var(--muted);font-size:15px;margin-top:40px}

        @media(max-width:520px){
          .no{width:40px;height:40px;font-size:12px}
          .no.marco{width:46px;height:46px}
          .no.hoje{width:50px;height:50px}
        }
        @media (prefers-reduced-motion: reduce){
          .no,.cm-card,.cm-btn{transition:none}
          .no.hoje{animation:none}
        }
      `}</style>
    </main>
  );
}
