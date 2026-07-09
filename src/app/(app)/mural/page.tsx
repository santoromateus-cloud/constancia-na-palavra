import { listarMural, MAX_TEXTO } from "@/lib/mural";
import { publicarMural, reagirMural } from "../actions";

export const metadata = { title: "Mural das irmãs — Constância na Palavra" };
export const dynamic = "force-dynamic";

function quando(iso: string): string {
  try {
    return new Date(iso).toLocaleDateString("pt-BR", { day: "2-digit", month: "short" });
  } catch {
    return "";
  }
}

export default async function Mural() {
  const posts = await listarMural();

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
          <button type="submit" className="mu-btn">Publicar</button>
        </div>
      </form>

      {/* Lista */}
      {posts.length === 0 ? (
        <p className="mu-vazio">Ainda não há recados. Seja a primeira a compartilhar 💛</p>
      ) : (
        <section className="mu-list">
          {posts.map((p) => (
            <article key={p.id} className="mu-post">
              <div className="mu-post-top">
                <span className="mu-autora">{p.souAutora ? "Você" : "Uma irmã"}</span>
                <span className="mu-data">{quando(p.criado_em)}</span>
              </div>
              {p.referencia && <div className="mu-ref">{p.referencia}</div>}
              <p className="mu-texto">{p.texto}</p>
              <div className="mu-reacoes">
                <form action={reagirMural.bind(null, p.id, "amem")}>
                  <button type="submit" className={"mu-react" + (p.minhasReacoes.amem ? " on" : "")}>
                    🙏 Amém <b>{p.reacoes.amem}</b>
                  </button>
                </form>
                <form action={reagirMural.bind(null, p.id, "orando")}>
                  <button type="submit" className={"mu-react" + (p.minhasReacoes.orando ? " on" : "")}>
                    💛 Orando <b>{p.reacoes.orando}</b>
                  </button>
                </form>
              </div>
            </article>
          ))}
        </section>
      )}

      <style>{`
        .mu-wrap{min-height:calc(100vh - 60px);background:var(--creme);padding:28px 18px 60px}
        .mu-head{max-width:640px;margin:0 auto 22px;text-align:center}
        .mu-kick{font-size:12px;letter-spacing:2.5px;text-transform:uppercase;font-weight:700;color:var(--coral)}
        .mu-head h1{font-family:var(--serif);font-size:clamp(24px,3.4vw,34px);margin:12px 0 0}
        .mu-sub{font-size:14.5px;color:#54606e;line-height:1.6;margin:12px auto 0;max-width:50ch}
        .mu-form{max-width:640px;margin:0 auto 26px;background:var(--paper);border:1px solid var(--line);border-radius:18px;padding:18px;box-shadow:var(--shadow-sm)}
        .mu-textarea{width:100%;border:1px solid var(--line);border-radius:12px;padding:12px 14px;font-family:var(--sans);font-size:15px;color:var(--ink);background:var(--creme);resize:vertical;line-height:1.5;outline:none}
        .mu-textarea:focus{border-color:var(--coral)}
        .mu-form-row{display:flex;gap:10px;margin-top:10px;flex-wrap:wrap}
        .mu-input{flex:1;min-width:180px;border:1px solid var(--line);border-radius:12px;padding:11px 14px;font-family:var(--sans);font-size:14px;color:var(--ink);background:var(--creme);outline:none}
        .mu-input:focus{border-color:var(--coral)}
        .mu-btn{background:var(--coral);color:#fff;border:none;border-radius:12px;padding:11px 22px;font-family:var(--sans);font-weight:700;font-size:14.5px;cursor:pointer;transition:.2s}
        .mu-btn:hover{background:#d96f53;transform:translateY(-1px)}
        .mu-list{max-width:640px;margin:0 auto;display:flex;flex-direction:column;gap:14px}
        .mu-post{background:var(--paper);border:1px solid var(--line);border-radius:18px;padding:18px 20px;box-shadow:var(--shadow-sm)}
        .mu-post-top{display:flex;align-items:baseline;justify-content:space-between;gap:10px}
        .mu-autora{font-size:13px;font-weight:700;color:var(--base)}
        .mu-data{font-size:12px;color:var(--muted)}
        .mu-ref{font-family:var(--serif);font-size:14px;font-style:italic;color:var(--coral);margin-top:6px}
        .mu-texto{font-size:15px;color:#2b3440;line-height:1.6;margin:8px 0 14px;white-space:pre-line}
        .mu-reacoes{display:flex;gap:10px}
        .mu-react{display:inline-flex;align-items:center;gap:6px;background:transparent;border:1px solid var(--line);border-radius:999px;padding:7px 14px;font-family:var(--sans);font-size:13px;font-weight:600;color:var(--base);cursor:pointer;transition:.18s}
        .mu-react b{font-variant-numeric:tabular-nums}
        .mu-react:hover{border-color:var(--coral);color:var(--coral)}
        .mu-react.on{background:color-mix(in srgb,var(--coral) 12%,transparent);border-color:var(--coral);color:var(--coral)}
        .mu-vazio{text-align:center;color:var(--muted);font-size:15px;margin-top:30px}
      `}</style>
    </main>
  );
}
