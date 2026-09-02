import { listarMural, MAX_TEXTO } from "@/lib/mural";
import { publicarMural, reagirMural } from "../actions";

export const metadata = { title: "Mural das irmãs — Constância na Palavra" };
export const dynamic = "force-dynamic";

/* ============================================================
   O MURAL DAS IRMÃS — com curadoria ANTES (02/09/2026)

   O que mudou: nenhum recado aparece para as outras sem a Elisângela ter
   lido. A autora vê o dela na hora, marcado "em análise", para não ficar a
   sensação de que sumiu. As outras só veem o que já passou por ela.

   O rosto que está na página de vendas é o dela. Um mural aberto sem
   curadoria é o nome dela respondendo por qualquer coisa que alguém escreva
   num dia ruim. Curadoria antes é mais trabalho para ela e menos risco —
   e foi a escolha do Mateus.
   ============================================================ */

function quando(iso: string): string {
  try {
    return new Date(iso).toLocaleDateString("pt-BR", { day: "2-digit", month: "short" });
  } catch {
    return "";
  }
}

/* Chama pequena: o "amém" que acende junto. Ícone e não emoji — emoji aqui
   quebraria a identidade da casa em toda tela que ele aparece. */
function IconeAmem({ size = 15 }: { size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor"
      strokeWidth={1.7} strokeLinecap="round" strokeLinejoin="round" aria-hidden>
      <path d="M12 3.4c2.7 2.5 4.1 4.7 4.1 6.8a4.1 4.1 0 0 1-8.2 0c0-2.1 1.4-4.3 4.1-6.8Z" />
      <path d="M9.4 20.6h5.2" />
    </svg>
  );
}

/* Mãos postas: o "estou orando". */
function IconeOrando({ size = 15 }: { size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor"
      strokeWidth={1.7} strokeLinecap="round" strokeLinejoin="round" aria-hidden>
      <path d="M12 3.6v9.2" />
      <path d="M9.2 20.6c-1.7-1.3-2.6-3-2.6-5.1V9.2a1.7 1.7 0 0 1 3.4 0" />
      <path d="M14.8 20.6c1.7-1.3 2.6-3 2.6-5.1V9.2a1.7 1.7 0 0 0-3.4 0" />
      <path d="M9.2 20.6h5.6" />
    </svg>
  );
}

export default async function Mural() {
  const posts = await listarMural();
  const noAr = posts.filter((p) => !p.pendente && !p.recusado);

  return (
    <main className="mu-wrap">
      <header className="mu-head">
        <span className="mu-kick">Mural das irmãs</span>
        <h1>Você não caminha sozinha.</h1>
        <p className="mu-sub">
          Deixe um versículo que te tocou, um pedido de oração ou uma palavra de
          incentivo. Reaja às irmãs com um amém ou um “estou orando”.
        </p>
      </header>

      {/* Form de novo post */}
      <form action={publicarMural} className="mu-form">
        <textarea
          name="texto"
          required
          maxLength={MAX_TEXTO}
          rows={3}
          placeholder="O que a Palavra falou com você hoje?"
          className="mu-textarea"
        />
        <div className="mu-form-row">
          <input
            name="referencia"
            maxLength={120}
            placeholder="Referência (opcional) — ex.: Provérbios 3:5"
            className="mu-input"
          />
          <button type="submit" className="mu-btn">Enviar</button>
        </div>
        <p className="mu-aviso">
          A Elisângela lê cada recado antes de ele aparecer para as outras. O seu
          fica aqui embaixo, marcado, até ela publicar.
        </p>
      </form>

      {/* Lista */}
      {posts.length === 0 ? (
        <p className="mu-vazio">Ainda não há recados por aqui. Se quiser, seja a primeira.</p>
      ) : (
        <section className="mu-list">
          {posts.map((p) => (
            <article
              key={p.id}
              className={"mu-post" + (p.pendente || p.recusado ? " esperando" : "") + (p.daCasa ? " casa" : "")}
            >
              <div className="mu-post-top">
                <span className="mu-autora">
                  {p.daCasa ? "Elisângela" : p.souAutora ? "Você" : "Uma irmã"}
                </span>
                <span className="mu-data">
                  {p.pendente ? (
                    <b className="mu-selo">Em análise</b>
                  ) : p.recusado ? (
                    <b className="mu-selo recusado">Não publicado</b>
                  ) : (
                    quando(p.criado_em)
                  )}
                </span>
              </div>
              {p.referencia && <div className="mu-ref">{p.referencia}</div>}
              <p className="mu-texto">{p.texto}</p>

              {p.pendente ? (
                <p className="mu-nota">
                  Recebemos o seu recado. Ele aparece para as irmãs assim que a
                  Elisângela ler.
                </p>
              ) : p.recusado ? (
                <p className="mu-nota">
                  Este recado ficou só entre você e a Elisângela. Pode escrever
                  outro quando quiser.
                </p>
              ) : (
                <div className="mu-reacoes">
                  <form action={reagirMural.bind(null, p.id, "amem")}>
                    <button type="submit" className={"mu-react" + (p.minhasReacoes.amem ? " on" : "")}>
                      <IconeAmem /> Amém <b>{p.reacoes.amem}</b>
                    </button>
                  </form>
                  <form action={reagirMural.bind(null, p.id, "orando")}>
                    <button type="submit" className={"mu-react" + (p.minhasReacoes.orando ? " on" : "")}>
                      <IconeOrando /> Orando <b>{p.reacoes.orando}</b>
                    </button>
                  </form>
                </div>
              )}
            </article>
          ))}
        </section>
      )}

      {noAr.length === 0 && posts.length > 0 && (
        <p className="mu-vazio">
          Assim que os primeiros recados forem publicados, eles aparecem aqui.
        </p>
      )}

      <style>{`
        .mu-wrap{min-height:calc(100vh - 60px);background:var(--creme);padding:28px 18px 60px}
        .mu-head{max-width:640px;margin:0 auto 22px;text-align:center}
        .mu-kick{font-size:12px;letter-spacing:2.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .mu-head h1{font-family:var(--serif);font-size:clamp(24px,3.4vw,34px);margin:12px 0 0}
        .mu-sub{font-size:14.5px;color:#6C5C45;line-height:1.6;margin:12px auto 0;max-width:50ch}
        .mu-form{max-width:640px;margin:0 auto 26px;background:var(--paper);border:1px solid var(--line);border-radius:18px;padding:18px;box-shadow:var(--shadow-sm)}
        .mu-textarea{width:100%;border:1px solid var(--line);border-radius:12px;padding:12px 14px;font-family:var(--sans);font-size:15px;color:var(--ink);background:var(--creme);resize:vertical;line-height:1.5;outline:none}
        .mu-textarea:focus{border-color:var(--coral)}
        .mu-form-row{display:flex;gap:10px;margin-top:10px;flex-wrap:wrap}
        .mu-input{flex:1;min-width:180px;border:1px solid var(--line);border-radius:12px;padding:11px 14px;font-family:var(--sans);font-size:14px;color:var(--ink);background:var(--creme);outline:none}
        .mu-input:focus{border-color:var(--coral)}
        .mu-btn{background:var(--coral);color:#FCF8EF;border:none;border-radius:12px;padding:11px 22px;font-family:var(--sans);font-weight:700;font-size:14.5px;cursor:pointer;transition:.2s}
        .mu-btn:hover{background:#47512C;transform:translateY(-1px)}
        .mu-aviso{font-size:12.5px;color:var(--muted);line-height:1.55;margin:11px 2px 0}
        .mu-list{max-width:640px;margin:0 auto;display:flex;flex-direction:column;gap:14px}
        .mu-post{background:var(--paper);border:1px solid var(--line);border-radius:18px;padding:18px 20px;box-shadow:var(--shadow-sm)}
        .mu-post.esperando{background:color-mix(in srgb,var(--areia) 45%,var(--paper));border-style:dashed}
        .mu-post.casa{border-color:color-mix(in srgb,var(--ouro) 55%,var(--line))}
        .mu-post-top{display:flex;align-items:baseline;justify-content:space-between;gap:10px}
        .mu-autora{font-size:13px;font-weight:700;color:var(--base)}
        .mu-post.casa .mu-autora{color:var(--ouro)}
        .mu-data{font-size:12px;color:var(--muted)}
        .mu-selo{display:inline-block;font-size:11px;font-weight:700;letter-spacing:.5px;text-transform:uppercase;color:var(--ouro);border:1px solid color-mix(in srgb,var(--ouro) 45%,transparent);border-radius:999px;padding:3px 10px}
        .mu-selo.recusado{color:var(--muted);border-color:var(--line)}
        .mu-ref{font-family:var(--serif);font-size:14px;font-style:italic;color:var(--coral);margin-top:6px}
        .mu-texto{font-size:15px;color:#2b3440;line-height:1.6;margin:8px 0 14px;white-space:pre-line}
        .mu-nota{font-size:12.5px;color:var(--muted);line-height:1.55;margin:0}
        .mu-reacoes{display:flex;gap:10px}
        .mu-react{display:inline-flex;align-items:center;gap:6px;background:transparent;border:1px solid var(--line);border-radius:999px;padding:7px 14px;font-family:var(--sans);font-size:13px;font-weight:600;color:var(--base);cursor:pointer;transition:.18s}
        .mu-react b{font-variant-numeric:tabular-nums}
        .mu-react svg{opacity:.75}
        .mu-react:hover{border-color:var(--coral);color:var(--coral)}
        .mu-react.on{background:color-mix(in srgb,var(--coral) 12%,transparent);border-color:var(--coral);color:var(--coral)}
        .mu-react.on svg{opacity:1}
        .mu-vazio{text-align:center;color:var(--muted);font-size:15px;margin-top:30px}
      `}</style>
    </main>
  );
}
