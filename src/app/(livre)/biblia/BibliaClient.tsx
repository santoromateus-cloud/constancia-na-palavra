"use client";

import { useMemo, useState, useTransition } from "react";
import Link from "next/link";
import { ChevronDown, Check, Sparkles } from "lucide-react";
import {
  IconeCadeado,
  IconeCandeia,
  IconeEspiga,
  IconeIrmas,
  IconeMeta,
  IconePerola,
} from "../../(app)/Icones";
import type { Livro } from "@/lib/biblia";
import type { EstadoTracker } from "@/lib/tracker";
import { alternarCapitulo, alternarLivroInteiro, definirMeta } from "../actions";

type Props = {
  pago: boolean;
  livrosAT: Livro[];
  livrosNT: Livro[];
  totais: { at: number; nt: number; biblia: number };
  inicial: EstadoTracker;
};

// ── Anel de progresso (SVG, anima sozinho ao mudar) ───────────────────────────
function Anel({
  pct,
  tamanho = 148,
  espessura = 11,
  children,
}: {
  pct: number;
  tamanho?: number;
  espessura?: number;
  children?: React.ReactNode;
}) {
  const r = (tamanho - espessura) / 2;
  const circ = 2 * Math.PI * r;
  return (
    <div className="anel" style={{ width: tamanho, height: tamanho }}>
      <svg width={tamanho} height={tamanho} aria-hidden>
        <circle
          cx={tamanho / 2}
          cy={tamanho / 2}
          r={r}
          fill="none"
          stroke="var(--line)"
          strokeWidth={espessura}
        />
        <circle
          className="anel-arco"
          cx={tamanho / 2}
          cy={tamanho / 2}
          r={r}
          fill="none"
          stroke="url(#gradOuro)"
          strokeWidth={espessura}
          strokeLinecap="round"
          strokeDasharray={circ}
          strokeDashoffset={circ - (circ * Math.min(Math.max(pct, 0), 100)) / 100}
          transform={`rotate(-90 ${tamanho / 2} ${tamanho / 2})`}
        />
        <defs>
          <linearGradient id="gradOuro" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#C9A85C" />
            <stop offset="55%" stopColor="#8F6D1E" />
            <stop offset="100%" stopColor="#6A7A42" />
          </linearGradient>
        </defs>
      </svg>
      <div className="anel-mid">{children}</div>
    </div>
  );
}

export default function BibliaClient({ pago, livrosAT, livrosNT, totais, inicial }: Props) {
  const [porLivro, setPorLivro] = useState<Record<string, number[]>>(inicial.porLivro);
  const [aba, setAba] = useState<"at" | "nt">("nt");
  const [aberto, setAberto] = useState<string | null>(null);
  const [festa, setFesta] = useState<string | null>(null);
  const [, startTransition] = useTransition();

  const livros = aba === "at" ? livrosAT : livrosNT;

  // Contagens derivadas do estado local: a UI responde no toque, o servidor
  // confirma depois (optimistic). Recontar aqui é barato e evita ida ao banco.
  const { lidosAT, lidosNT, total, pctTotal, pctAT, pctNT, completos } = useMemo(() => {
    const contar = (lista: Livro[]) =>
      lista.reduce((s, l) => s + (porLivro[l.slug]?.filter((c) => c >= 1 && c <= l.capitulos).length ?? 0), 0);
    const at = contar(livrosAT);
    const nt = contar(livrosNT);
    const comp = [...livrosAT, ...livrosNT].filter(
      (l) => (porLivro[l.slug]?.length ?? 0) >= l.capitulos,
    ).length;
    const pct = (n: number, t: number) => (t > 0 ? Math.round((n / t) * 100) : 0);
    return {
      lidosAT: at,
      lidosNT: nt,
      total: at + nt,
      pctTotal: pct(at + nt, totais.biblia),
      pctAT: pct(at, totais.at),
      pctNT: pct(nt, totais.nt),
      completos: comp,
    };
  }, [porLivro, livrosAT, livrosNT, totais]);

  function toggleCapitulo(livro: Livro, cap: number) {
    const atuais = porLivro[livro.slug] ?? [];
    const marcado = atuais.includes(cap);
    const proximos = marcado ? atuais.filter((c) => c !== cap) : [...atuais, cap].sort((a, b) => a - b);
    setPorLivro((s) => ({ ...s, [livro.slug]: proximos }));
    if (!marcado && proximos.length >= livro.capitulos) {
      setFesta(livro.slug);
      setTimeout(() => setFesta(null), 2200);
    }
    startTransition(() => {
      void alternarCapitulo(livro.slug, cap, !marcado);
    });
  }

  function toggleLivro(livro: Livro) {
    const completo = (porLivro[livro.slug]?.length ?? 0) >= livro.capitulos;
    const proximos = completo ? [] : Array.from({ length: livro.capitulos }, (_, i) => i + 1);
    setPorLivro((s) => ({ ...s, [livro.slug]: proximos }));
    if (!completo) {
      setFesta(livro.slug);
      setTimeout(() => setFesta(null), 2200);
    }
    startTransition(() => {
      void alternarLivroInteiro(livro.slug, !completo);
    });
  }

  const meta = inicial.meta;
  const ritmo = inicial.ritmoNecessario;
  const restantes = inicial.diasRestantes;

  return (
    <main className="bb">
      {/* ── Painel de progresso ─────────────────────────────────────────── */}
      <section className="bb-painel">
        <div className="bb-anelbox">
          <Anel pct={pctTotal}>
            <b className="tnum">{pctTotal}%</b>
            <span>da Bíblia</span>
          </Anel>
        </div>

        <div className="bb-nums">
          <h1>Minha Bíblia</h1>
          <p className="bb-lead">
            Marque cada capítulo que você ler. É seu, fica guardado, e não custa nada —
            para sempre.
          </p>

          <div className="bb-grade">
            <div className="bb-stat">
              <span className="bb-rot">Antigo Testamento</span>
              <b className="tnum">
                {lidosAT}
                <small>/{totais.at}</small>
              </b>
              <div className="bb-barra">
                <i style={{ width: `${pctAT}%` }} />
              </div>
            </div>
            <div className="bb-stat">
              <span className="bb-rot">Novo Testamento</span>
              <b className="tnum">
                {lidosNT}
                <small>/{totais.nt}</small>
              </b>
              <div className="bb-barra">
                <i style={{ width: `${pctNT}%` }} />
              </div>
            </div>
            <div className="bb-stat">
              <span className="bb-rot">Livros inteiros</span>
              <b className="tnum">
                {completos}
                <small>/66</small>
              </b>
              <div className="bb-barra">
                <i style={{ width: `${Math.round((completos / 66) * 100)}%` }} />
              </div>
            </div>
          </div>

          <p className="bb-frase">
            {total === 0
              ? "Comece por onde a sua leitura está hoje. Um capítulo já conta."
              : `${total.toLocaleString("pt-BR")} ${total === 1 ? "capítulo lido" : "capítulos lidos"}. Continue.`}
          </p>
        </div>
      </section>

      {/* ── Meta ───────────────────────────────────────────────────────── */}
      <section className="bb-meta">
        <div className="bb-meta-cab">
          <IconeMeta size={18} />
          <h2>Minha meta</h2>
        </div>
        {meta && ritmo !== null && restantes !== null ? (
          <p className="bb-meta-linha">
            {restantes > 0 ? (
              <>
                Faltam <b>{restantes} {restantes === 1 ? "dia" : "dias"}</b> para{" "}
                {new Date(meta.data_fim + "T00:00:00").toLocaleDateString("pt-BR")}. No ritmo de{" "}
                <b>{ritmo.toLocaleString("pt-BR")} {ritmo === 1 ? "capítulo" : "capítulos"} por dia</b>, você chega.
              </>
            ) : (
              <>
                A data da sua meta já passou. Ainda faltam <b>{ritmo} capítulos</b> — dá para
                escolher uma data nova sem perder nada do que você já leu.
              </>
            )}
          </p>
        ) : (
          <p className="bb-meta-linha bb-meta-vazia">
            Ainda sem meta. Escolha uma data e o app calcula o ritmo por você.
          </p>
        )}
        <form action={definirMeta} className="bb-meta-form">
          <label>
            <span>Começo</span>
            <input
              type="date"
              name="data_inicio"
              defaultValue={meta?.data_inicio ?? new Date().toISOString().slice(0, 10)}
              required
            />
          </label>
          <label>
            <span>Fim</span>
            <input type="date" name="data_fim" defaultValue={meta?.data_fim ?? ""} required />
          </label>
          <label>
            <span>Quero ler</span>
            <select name="escopo" defaultValue={meta?.escopo ?? "biblia"}>
              <option value="biblia">A Bíblia inteira</option>
              <option value="at">O Antigo Testamento</option>
              <option value="nt">O Novo Testamento</option>
            </select>
          </label>
          <button type="submit" className="bb-meta-btn">
            Salvar meta
          </button>
        </form>
      </section>

      {/* ── Livros ─────────────────────────────────────────────────────── */}
      <section className="bb-livros">
        <div className="bb-abas" role="tablist">
          <button
            role="tab"
            aria-selected={aba === "at"}
            className={"bb-tab" + (aba === "at" ? " on" : "")}
            onClick={() => setAba("at")}
          >
            Antigo Testamento
          </button>
          <button
            role="tab"
            aria-selected={aba === "nt"}
            className={"bb-tab" + (aba === "nt" ? " on" : "")}
            onClick={() => setAba("nt")}
          >
            Novo Testamento
          </button>
        </div>

        <ul className="bb-lista">
          {livros.map((l) => {
            const lidos = porLivro[l.slug] ?? [];
            const n = lidos.filter((c) => c >= 1 && c <= l.capitulos).length;
            const pct = Math.round((n / l.capitulos) * 100);
            const completo = n >= l.capitulos;
            const expandido = aberto === l.slug;
            return (
              <li
                key={l.slug}
                className={
                  "bb-livro" + (completo ? " completo" : "") + (festa === l.slug ? " festa" : "")
                }
              >
                <button
                  className="bb-livro-cab"
                  onClick={() => setAberto(expandido ? null : l.slug)}
                  aria-expanded={expandido}
                >
                  <span className="bb-livro-nome">
                    {l.nome}
                    <small>{l.grupo}</small>
                  </span>
                  <span className="bb-livro-dir">
                    <span className="bb-mini">
                      <Anel pct={pct} tamanho={40} espessura={4}>
                        {completo ? <Check size={14} strokeWidth={3.2} /> : <i className="tnum">{pct}</i>}
                      </Anel>
                    </span>
                    <ChevronDown size={17} className={"bb-chev" + (expandido ? " on" : "")} />
                  </span>
                </button>

                {expandido && (
                  <div className="bb-caps">
                    <div className="bb-caps-topo">
                      <span>
                        {n} de {l.capitulos} {l.capitulos === 1 ? "capítulo" : "capítulos"}
                      </span>
                      <button className="bb-todos" onClick={() => toggleLivro(l)}>
                        {completo ? "Desmarcar tudo" : "Marcar tudo"}
                      </button>
                    </div>
                    <div className="bb-grid">
                      {Array.from({ length: l.capitulos }, (_, i) => i + 1).map((c) => {
                        const on = lidos.includes(c);
                        return (
                          <button
                            key={c}
                            className={"bb-cap" + (on ? " on" : "")}
                            onClick={() => toggleCapitulo(l, c)}
                            aria-pressed={on}
                            aria-label={`${l.nome} ${c}`}
                          >
                            {on ? <Check size={15} strokeWidth={3.2} aria-hidden /> : c}
                          </button>
                        );
                      })}
                    </div>
                  </div>
                )}

                {festa === l.slug && (
                  <span className="bb-festa" aria-hidden>
                    <Sparkles size={15} /> {l.nome} inteiro. Que colheita!
                  </span>
                )}
              </li>
            );
          })}
        </ul>
      </section>

      {/* ── Ponte pro pago ─────────────────────────────────────────────── */}
      {!pago && (
        <section className="bb-ponte">
          <span className="bb-ponte-kick">
            <IconeCadeado size={12} strokeWidth={2.2} /> O que mais existe aqui dentro
          </span>
          <h2>O marcador é seu de graça. A caminhada é melhor acompanhada.</h2>
          <p>
            Os planos guiados da Elisangela, a Candeia que conta os seus dias seguidos, as
            Pérolas que você coleciona a cada leitura, a Lavra que cresce no seu ritmo e o
            Mural das Irmãs — tudo isso mora no plano completo.
          </p>
          <ul className="bb-ponte-lista">
            <li>
              <IconeCandeia size={22} />
              <span>
                <b>Candeia e Dias de Graça</b>
                A sequência que perdoa o dia que faltou
              </span>
            </li>
            <li>
              <IconeEspiga size={22} />
              <span>
                <b>A Lavra</b>
                O seu campo, uma espiga por leitura
              </span>
            </li>
            <li>
              <IconePerola size={22} />
              <span>
                <b>Pérolas</b>
                Um versículo-joia guardado a cada dia
              </span>
            </li>
            <li>
              <IconeIrmas size={22} />
              <span>
                <b>Mural das Irmãs</b>
                Você não caminha sozinha
              </span>
            </li>
          </ul>
          <Link href="/pricing" className="bb-ponte-btn">
            Ver o plano completo →
          </Link>
          <small>A Bíblia e o seu marcador continuam de graça, com ou sem plano.</small>
        </section>
      )}

      <style jsx global>{`
        .bb{max-width:980px;margin:0 auto;padding:clamp(20px,4vw,38px) clamp(14px,4vw,22px) 90px}

        .anel{position:relative;display:grid;place-items:center;flex:none}
        .anel svg{display:block}
        .anel-arco{transition:stroke-dashoffset .7s cubic-bezier(.16,1,.3,1)}
        .anel-mid{position:absolute;inset:0;display:flex;flex-direction:column;align-items:center;justify-content:center;line-height:1}
        .anel-mid b{font-family:var(--display);font-size:34px;color:var(--base)}
        .anel-mid span{font-size:11px;color:var(--muted);margin-top:5px;letter-spacing:.4px}

        /* painel */
        .bb-painel{display:flex;gap:clamp(18px,4vw,42px);align-items:center;background:var(--paper);border:1px solid var(--line);border-radius:26px;padding:clamp(20px,3.4vw,34px);box-shadow:var(--shadow-sm)}
        .bb-anelbox{flex:none}
        .bb-nums{flex:1;min-width:0}
        .bb-nums h1{font-size:clamp(26px,3.6vw,38px);line-height:1.05;margin:0}
        .bb-lead{font-size:14.5px;color:#6C5C45;line-height:1.55;margin:9px 0 20px;max-width:46ch}
        .bb-grade{display:grid;grid-template-columns:repeat(3,1fr);gap:clamp(10px,2vw,20px)}
        .bb-stat{display:flex;flex-direction:column;gap:5px}
        .bb-rot{font-size:11px;letter-spacing:1.1px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .bb-stat b{font-family:var(--display);font-size:23px;color:var(--base);line-height:1}
        .bb-stat b small{font-size:13px;color:var(--muted);font-family:var(--sans);font-weight:500}
        .bb-barra{height:5px;border-radius:99px;background:var(--line);overflow:hidden}
        .bb-barra i{display:block;height:100%;border-radius:99px;background:linear-gradient(90deg,#C9A85C,#6A7A42);transition:width .7s cubic-bezier(.16,1,.3,1)}
        .bb-frase{font-family:var(--serif);font-style:italic;font-size:14.5px;color:var(--base);margin-top:18px}

        /* meta */
        .bb-meta{background:linear-gradient(135deg,color-mix(in srgb,var(--areia) 42%,var(--paper)),var(--paper));border:1px solid var(--line);border-radius:22px;padding:clamp(18px,3vw,26px);margin-top:16px}
        .bb-meta-cab{display:flex;align-items:center;gap:9px;color:var(--ouro)}
        .bb-meta-cab h2{font-size:19px;color:var(--base);margin:0}
        .bb-meta-linha{font-size:14.5px;color:#5D4E39;line-height:1.6;margin:10px 0 16px;max-width:62ch}
        .bb-meta-linha b{color:var(--base);font-weight:700}
        .bb-meta-vazia{color:var(--muted)}
        .bb-meta-form{display:flex;flex-wrap:wrap;gap:12px;align-items:flex-end}
        .bb-meta-form label{display:flex;flex-direction:column;gap:5px;font-size:11.5px;letter-spacing:.6px;text-transform:uppercase;font-weight:700;color:var(--muted)}
        .bb-meta-form input,.bb-meta-form select{font-family:var(--sans);font-size:14.5px;color:var(--ink);background:var(--paper);border:1px solid var(--line);border-radius:11px;padding:10px 12px;min-height:42px}
        .bb-meta-form input:focus,.bb-meta-form select:focus{outline:2px solid var(--ambar);outline-offset:1px}
        .bb-meta-btn{font-family:var(--sans);font-weight:700;font-size:14px;background:var(--coral);color:#FCF8EF;border:0;border-radius:11px;padding:12px 20px;min-height:42px;cursor:pointer;transition:.2s}
        .bb-meta-btn:hover{background:#47512C;transform:translateY(-1px)}

        /* abas */
        .bb-abas{display:flex;gap:8px;margin:30px 0 16px}
        .bb-tab{font-family:var(--sans);font-weight:700;font-size:14px;padding:11px 20px;border-radius:99px;border:1px solid var(--line);background:transparent;color:var(--muted);cursor:pointer;transition:.2s}
        .bb-tab:hover{color:var(--base);border-color:var(--ambar)}
        .bb-tab.on{background:var(--base);border-color:var(--base);color:var(--areia)}

        /* livros */
        .bb-lista{list-style:none;display:flex;flex-direction:column;gap:8px}
        .bb-livro{background:var(--paper);border:1px solid var(--line);border-radius:18px;overflow:hidden;transition:border-color .25s,box-shadow .25s;position:relative}
        .bb-livro.completo{border-color:color-mix(in srgb,var(--ambar) 62%,var(--line))}
        .bb-livro.festa{box-shadow:0 0 0 3px color-mix(in srgb,var(--ambar) 42%,transparent);animation:bbPulso 2.2s ease-out}
        @keyframes bbPulso{0%{box-shadow:0 0 0 0 color-mix(in srgb,var(--ambar) 70%,transparent)}60%{box-shadow:0 0 0 12px transparent}100%{box-shadow:0 0 0 0 transparent}}
        .bb-livro-cab{width:100%;display:flex;align-items:center;justify-content:space-between;gap:14px;padding:15px 18px;background:transparent;border:0;cursor:pointer;text-align:left;font-family:var(--sans)}
        .bb-livro-nome{display:flex;flex-direction:column;gap:2px;font-family:var(--serif);font-size:17px;font-weight:600;color:var(--ink)}
        .bb-livro-nome small{font-family:var(--sans);font-size:11px;letter-spacing:.7px;text-transform:uppercase;color:var(--muted);font-weight:600}
        .bb-livro-dir{display:flex;align-items:center;gap:12px;flex:none}
        .bb-mini .anel-mid i{font-family:var(--sans);font-style:normal;font-size:11px;font-weight:700;color:var(--muted)}
        .bb-mini .anel-mid{color:var(--verde)}
        .bb-chev{color:var(--muted);transition:transform .25s}
        .bb-chev.on{transform:rotate(180deg)}

        .bb-caps{padding:0 18px 18px;animation:bbAbre .3s cubic-bezier(.16,1,.3,1)}
        @keyframes bbAbre{from{opacity:0;transform:translateY(-6px)}to{opacity:1;transform:none}}
        .bb-caps-topo{display:flex;align-items:center;justify-content:space-between;gap:12px;padding:0 0 12px;font-size:12.5px;color:var(--muted);border-top:1px solid var(--line);padding-top:13px}
        .bb-todos{font-family:var(--sans);font-size:12px;font-weight:700;letter-spacing:.5px;text-transform:uppercase;color:var(--ouro);background:transparent;border:0;cursor:pointer;padding:4px 2px}
        .bb-todos:hover{color:var(--coral);text-decoration:underline}
        .bb-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(44px,1fr));gap:7px}
        .bb-cap{aspect-ratio:1;display:grid;place-items:center;font-family:var(--sans);font-size:13.5px;font-weight:600;color:var(--muted);background:transparent;border:1.5px solid var(--line);border-radius:11px;cursor:pointer;transition:transform .16s,background .2s,border-color .2s,color .2s;min-width:40px}
        .bb-cap:hover{border-color:var(--ambar);color:var(--base);transform:translateY(-1px)}
        .bb-cap.on{background:linear-gradient(140deg,#C9A85C,#8F6D1E);border-color:transparent;color:#FCF8EF;animation:bbMarca .34s cubic-bezier(.34,1.56,.64,1)}
        @keyframes bbMarca{0%{transform:scale(.82)}55%{transform:scale(1.14)}100%{transform:scale(1)}}

        .bb-festa{position:absolute;right:16px;top:14px;display:inline-flex;align-items:center;gap:6px;background:var(--base);color:var(--areia);font-size:11.5px;font-weight:700;padding:6px 12px;border-radius:99px;animation:bbSobe .5s cubic-bezier(.16,1,.3,1)}
        @keyframes bbSobe{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:none}}

        /* ponte pro pago */
        .bb-ponte{margin-top:34px;background:var(--base);color:var(--creme);border-radius:26px;padding:clamp(24px,4vw,40px);position:relative;overflow:hidden}
        .bb-ponte::after{content:"";position:absolute;inset:0;background:radial-gradient(70% 90% at 100% 0%,rgba(201,168,92,.24),transparent 60%);pointer-events:none}
        .bb-ponte-kick{display:inline-flex;align-items:center;gap:8px;font-size:11.5px;letter-spacing:1.6px;text-transform:uppercase;font-weight:700;color:var(--ambar)}
        .bb-ponte h2{font-size:clamp(23px,3.2vw,32px);line-height:1.14;margin:13px 0 0;color:var(--creme);max-width:22ch}
        .bb-ponte p{font-size:15px;line-height:1.65;color:color-mix(in srgb,var(--creme) 78%,transparent);margin:14px 0 0;max-width:56ch}
        .bb-ponte-lista{list-style:none;display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:9px;margin:22px 0 26px}
        .bb-ponte-lista li{display:flex;align-items:flex-start;gap:12px;background:rgba(255,255,255,.05);border:1px solid rgba(232,217,174,.14);border-radius:14px;padding:14px 16px;transition:.22s}
        .bb-ponte-lista li:hover{background:rgba(255,255,255,.08);border-color:rgba(232,217,174,.3)}
        .bb-ponte-lista li > svg{color:var(--ambar);flex:none;margin-top:1px}
        .bb-ponte-lista li span{display:flex;flex-direction:column;gap:3px;font-size:12.5px;line-height:1.45;color:color-mix(in srgb,var(--creme) 68%,transparent)}
        .bb-ponte-lista li b{font-family:var(--serif);font-size:14.5px;font-weight:600;color:var(--creme)}
        .bb-ponte-btn{display:inline-flex;align-items:center;background:var(--ambar);color:#2E2416;font-weight:700;font-size:15px;border-radius:13px;padding:14px 24px;transition:.2s;position:relative;z-index:1}
        .bb-ponte-btn:hover{transform:translateY(-2px);background:#E8D9AE}
        .bb-ponte small{display:block;margin-top:14px;font-size:12.5px;color:color-mix(in srgb,var(--creme) 58%,transparent)}

        @media(max-width:760px){
          .bb-painel{flex-direction:column;text-align:center}
          .bb-lead{margin-left:auto;margin-right:auto}
          .bb-grade{grid-template-columns:1fr;gap:14px;text-align:left}
          .bb-meta-form label{flex:1 1 44%}
          .bb-meta-btn{flex:1 1 100%;justify-content:center}
        }
        @media (prefers-reduced-motion: reduce){
          .anel-arco,.bb-barra i,.bb-cap,.bb-livro{transition:none}
          .bb-cap.on,.bb-livro.festa,.bb-festa,.bb-caps{animation:none}
        }
      `}</style>
    </main>
  );
}
