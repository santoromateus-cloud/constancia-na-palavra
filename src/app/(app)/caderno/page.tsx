import Link from "next/link";
import { listarCaderno, getResumoCaderno } from "@/lib/caderno";
import { apagarDoCaderno } from "../actions";
import { IconePerola } from "../Icones";

export const metadata = { title: "O seu caderno — Constância na Palavra" };
export const dynamic = "force-dynamic";

/* ============================================================
   O CADERNO — a estante dela

   Esta tela é a única do produto em que tudo o que aparece foi escrito pela
   leitora. Por isso ela não tem número de vaidade no topo: tem a contagem do
   que ela produziu (promessas, ordens, princípios) e depois o texto, inteiro,
   em ordem de leitura.

   Duas decisões de tom:
   · Nada daqui é compartilhável. Não existe botão de enviar para o mural.
     Se um dia existir, vai ser copiar e colar, decisão dela, texto por texto.
   · Apagar existe, mas em dois toques (o <details>). Um toque errado numa
     lista do que ela escreveu ao longo de meses seria imperdoável.
   ============================================================ */

const MESES = [
  "janeiro", "fevereiro", "março", "abril", "maio", "junho",
  "julho", "agosto", "setembro", "outubro", "novembro", "dezembro",
];

function porExtenso(iso: string): string {
  const [a, m, d] = iso.slice(0, 10).split("-");
  if (!a || !m || !d) return "";
  return `${Number(d)} de ${MESES[Number(m) - 1]} de ${a}`;
}

function IconeCaderno({ size = 15 }: { size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor"
      strokeWidth={1.6} strokeLinecap="round" strokeLinejoin="round" aria-hidden>
      <path d="M4 5.5A1.5 1.5 0 0 1 5.5 4H19v13.5H5.5A1.5 1.5 0 0 0 4 19V5.5Z" />
      <path d="M4 19a1.5 1.5 0 0 0 1.5 1.5H19" />
      <path d="M8.6 9h6.2M8.6 12.4h4.2" />
    </svg>
  );
}

export default async function CadernoPage() {
  const [entradas, resumo] = await Promise.all([listarCaderno(), getResumoCaderno()]);

  return (
    <main className="cdn">
      <header className="cdn-head">
        <span className="cdn-kick"><IconeCaderno size={15} /> O seu caderno</span>
        <h1>O que a Palavra falou com você.</h1>
        {resumo.total > 0 ? (
          <p className="cdn-sub">
            {resumo.total === 1 ? "Uma leitura escrita" : `${resumo.total} leituras escritas`}
            {resumo.primeiraData && <> desde {porExtenso(resumo.primeiraData)}</>}. Ninguém além de
            você lê esta página.
          </p>
        ) : (
          <p className="cdn-sub">
            Aqui fica tudo o que você escrever sobre as suas leituras. Ninguém além de você
            lê esta página.
          </p>
        )}
      </header>

      {resumo.total > 0 && (
        <section className="cdn-nums">
          <div><b className="tnum">{resumo.promessas}</b><span>{resumo.promessas === 1 ? "promessa" : "promessas"}</span></div>
          <div><b className="tnum">{resumo.ordens}</b><span>{resumo.ordens === 1 ? "ordem" : "ordens"}</span></div>
          <div><b className="tnum">{resumo.principios}</b><span>{resumo.principios === 1 ? "princípio" : "princípios"}</span></div>
          <div><b className="tnum">{resumo.total}</b><span>{resumo.total === 1 ? "passo" : "passos"}</span></div>
        </section>
      )}

      {entradas.length === 0 ? (
        <section className="cdn-vazio">
          <h2>O seu caderno começa na próxima leitura.</h2>
          <p>
            Depois de ler o capítulo do dia, quatro perguntas esperam por você: uma promessa,
            uma ordem, um princípio e um passo. Nem todo capítulo traz as quatro — escreva as
            que estiverem no texto. O passo é o único que nunca falta.
          </p>
          <Link href="/ler" className="cdn-btn">Ir para a leitura de hoje →</Link>
        </section>
      ) : (
        <section className="cdn-lista">
          {entradas.map((e) => (
            <article key={e.id} className="cdn-item">
              <div className="cdn-item-topo">
                <h2>{e.referencia ?? (e.dia ? `Dia ${e.dia}` : "Leitura")}</h2>
                <span className="cdn-data">{porExtenso(e.criadoEm)}</span>
              </div>

              <dl className="cdn-campos">
                {e.promessa && (
                  <div><dt>Uma promessa</dt><dd>{e.promessa}</dd></div>
                )}
                {e.ordem && (
                  <div><dt>Uma ordem</dt><dd>{e.ordem}</dd></div>
                )}
                {e.principio && (
                  <div><dt>Um princípio</dt><dd>{e.principio}</dd></div>
                )}
                <div className="passo"><dt>Um passo</dt><dd>{e.passo}</dd></div>
              </dl>

              {e.perola && (
                <p className="cdn-perola">
                  <IconePerola size={14} />
                  <span>
                    “{e.perola.texto}”
                    <b>{e.referencia}:{e.perola.n}</b>
                  </span>
                </p>
              )}

              <details className="cdn-apagar">
                <summary>apagar esta entrada</summary>
                <form action={apagarDoCaderno.bind(null, e.id)}>
                  <p>Isso não tem volta. O que você escreveu neste dia some.</p>
                  <button type="submit">Apagar mesmo assim</button>
                </form>
              </details>
            </article>
          ))}
        </section>
      )}

      <style>{`
        .cdn{max-width:720px;margin:0 auto;padding:clamp(20px,3.6vw,32px) clamp(14px,4vw,20px) 90px}
        .cdn-head{text-align:center;max-width:56ch;margin:0 auto 24px}
        .cdn-kick{display:inline-flex;align-items:center;gap:8px;font-size:11.5px;letter-spacing:1.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .cdn-head h1{font-family:var(--display);font-weight:400;font-size:clamp(26px,4vw,36px);line-height:1.08;margin:12px 0 0;color:var(--ink)}
        .cdn-sub{font-size:14.5px;line-height:1.6;color:#6C5C45;margin:12px 0 0}

        .cdn-nums{display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-bottom:22px}
        .cdn-nums div{text-align:center;background:color-mix(in srgb,var(--areia) 20%,var(--paper));border:1px solid var(--line);border-radius:16px;padding:14px 6px}
        .cdn-nums b{display:block;font-family:var(--display);font-size:clamp(21px,3.4vw,26px);color:var(--base);line-height:1}
        .cdn-nums span{display:block;font-size:10.5px;color:var(--muted);margin-top:5px;line-height:1.25}

        .cdn-vazio{background:var(--paper);border:1px solid var(--line);border-radius:24px;padding:clamp(24px,4vw,36px);text-align:center;box-shadow:var(--shadow-sm)}
        .cdn-vazio h2{font-family:var(--display);font-weight:400;font-size:clamp(21px,3vw,27px);line-height:1.15;color:var(--ink);margin:0}
        .cdn-vazio p{font-size:15px;line-height:1.65;color:#6C5C45;margin:14px auto 24px;max-width:52ch}
        .cdn-btn{display:inline-block;background:linear-gradient(140deg,#63703F,#4A5430);color:#FCF8EF;font-weight:700;font-size:15px;border-radius:15px;padding:14px 26px;transition:transform .2s;box-shadow:0 12px 28px -12px rgba(74,84,48,.8)}
        .cdn-btn:hover{transform:translateY(-2px)}

        .cdn-lista{display:flex;flex-direction:column;gap:14px}
        .cdn-item{
          background:var(--paper);border:1px solid var(--line);
          border-left:3px solid var(--fio);border-radius:6px 22px 22px 6px;
          padding:clamp(18px,3vw,24px);box-shadow:var(--shadow-sm);
        }
        .cdn-item-topo{display:flex;align-items:baseline;justify-content:space-between;gap:12px;flex-wrap:wrap}
        .cdn-item-topo h2{font-family:var(--display);font-weight:400;font-size:20px;color:var(--ink);margin:0;line-height:1.15}
        .cdn-data{font-size:12px;color:var(--muted)}

        .cdn-campos{display:flex;flex-direction:column;gap:12px;margin-top:14px}
        .cdn-campos dt{font-size:11px;letter-spacing:1.2px;text-transform:uppercase;font-weight:700;color:var(--muted)}
        .cdn-campos dd{font-family:var(--serif);font-size:15.5px;line-height:1.65;color:#33291B;margin:4px 0 0;white-space:pre-line}
        .cdn-campos .passo dt{color:var(--coral)}
        .cdn-campos .passo dd{color:var(--base)}

        .cdn-perola{
          display:flex;gap:9px;align-items:flex-start;margin-top:16px;padding-top:14px;
          border-top:1px solid var(--line);color:var(--ouro);
        }
        .cdn-perola span{font-family:var(--serif);font-style:italic;font-size:14px;line-height:1.6;color:#5D4E39}
        .cdn-perola b{display:block;font-style:normal;font-size:11px;letter-spacing:1.2px;text-transform:uppercase;color:var(--ouro);margin-top:6px}

        .cdn-apagar{margin-top:14px}
        .cdn-apagar summary{font-size:11.5px;color:var(--muted);cursor:pointer;list-style:none}
        .cdn-apagar summary::-webkit-details-marker{display:none}
        .cdn-apagar summary:hover{color:var(--coral)}
        .cdn-apagar p{font-size:12.5px;color:var(--muted);margin:10px 0 8px}
        .cdn-apagar button{
          font-family:var(--sans);font-size:12.5px;font-weight:700;color:#8C3A3A;
          background:transparent;border:1px solid #E7C9C9;border-radius:999px;
          padding:7px 16px;cursor:pointer;
        }
        .cdn-apagar button:hover{background:#FBEFEF}

        @media(max-width:560px){
          .cdn-nums{grid-template-columns:repeat(2,1fr)}
        }
      `}</style>
    </main>
  );
}
