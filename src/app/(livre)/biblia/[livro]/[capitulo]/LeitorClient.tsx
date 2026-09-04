"use client";

import { useEffect, useState, useTransition } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Check } from "lucide-react";
import { IconeBiblia, IconeEspiga } from "../../../../(app)/Icones";
import type { Livro } from "@/lib/biblia";
import type { RefCapitulo } from "@/lib/leitor";
import { alternarCapitulo } from "../../../actions";

/* ─────────────────────────────────────────────────────────────────────────────
   O LEITOR — a tela em que a leitora lê o capítulo e, no fim, marca.

   Desenho:
   · Texto em Lora, um versículo por parágrafo, número pequeno e dourado na
     margem. Três tamanhos de letra (guardados no aparelho dela): muita leitora
     lê no celular, à noite, com a letra grande.
   · Setas de capítulo em cima e embaixo, atravessando livros (Gênesis 50 →
     Êxodo 1).
   · "Li este capítulo" no fim do texto — onde ela chega quando termina de ler.
     Marca na hora (otimista), o servidor confirma, e o botão de continuar
     aparece apontando pro próximo capítulo. Quem lê na Bíblia de papel e só
     quer marcar tem o mesmo botão em dois toques.
   · Quando o capítulo fecha o livro, a festa é a mesma da grade: "Que colheita".
   ───────────────────────────────────────────────────────────────────────────── */

type Tamanho = "p" | "m" | "g";
const CHAVE_TAMANHO = "cnp:leitor:tamanho";

type Props = {
  livro: Livro;
  capitulo: number;
  versiculos: string[];
  lidoInicial: boolean;
  lidoEm: string | null;
  lidosNoLivro: number;
  anterior: RefCapitulo | null;
  proximo: RefCapitulo | null;
  fimDoLivro: boolean;
};

function Seta({ dir, size = 18 }: { dir: "esq" | "dir"; size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" aria-hidden>
      <path
        d={dir === "esq" ? "M15 5 8 12l7 7" : "M9 5l7 7-7 7"}
        stroke="currentColor"
        strokeWidth={1.9}
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

function dataCurta(iso: string | null): string | null {
  if (!iso) return null;
  const d = new Date(iso + "T00:00:00");
  if (Number.isNaN(d.getTime())) return null;
  return d.toLocaleDateString("pt-BR", { day: "2-digit", month: "2-digit" });
}

export default function LeitorClient({
  livro,
  capitulo,
  versiculos,
  lidoInicial,
  lidoEm,
  lidosNoLivro,
  anterior,
  proximo,
  fimDoLivro,
}: Props) {
  const router = useRouter();
  const [lido, setLido] = useState(lidoInicial);
  const [lidosLivro, setLidosLivro] = useState(lidosNoLivro);
  const [festa, setFesta] = useState(false);
  const [colheita, setColheita] = useState(false);
  const [tamanho, setTamanho] = useState<Tamanho>("m");
  const [pendente, startTransition] = useTransition();

  // Tamanho da letra: lido do aparelho depois de montar (evita divergir do servidor).
  useEffect(() => {
    try {
      const t = localStorage.getItem(CHAVE_TAMANHO);
      if (t === "p" || t === "m" || t === "g") setTamanho(t);
    } catch {}
  }, []);
  function mudarTamanho(t: Tamanho) {
    setTamanho(t);
    try {
      localStorage.setItem(CHAVE_TAMANHO, t);
    } catch {}
  }

  // Setas do teclado no computador. No celular não muda nada.
  useEffect(() => {
    function onKey(e: KeyboardEvent) {
      const alvo = e.target as HTMLElement | null;
      if (alvo && /^(INPUT|TEXTAREA|SELECT)$/.test(alvo.tagName)) return;
      if (e.key === "ArrowLeft" && anterior) router.push(`/biblia/${anterior.slug}/${anterior.capitulo}`);
      if (e.key === "ArrowRight" && proximo) router.push(`/biblia/${proximo.slug}/${proximo.capitulo}`);
    }
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [anterior, proximo, router]);

  function marcar() {
    if (lido || pendente) return;
    setLido(true);
    setLidosLivro((n) => {
      const novo = n + 1;
      if (novo >= livro.capitulos) setColheita(true);
      return novo;
    });
    setFesta(true);
    setTimeout(() => setFesta(false), 2200);
    startTransition(async () => {
      const r = await alternarCapitulo(livro.slug, capitulo, true);
      if (!r.ok) {
        // o servidor não gravou: desfaz na tela, sem fingir
        setLido(false);
        setLidosLivro((n) => Math.max(0, n - 1));
        setColheita(false);
      }
    });
  }

  function desmarcar() {
    if (!lido || pendente) return;
    setLido(false);
    setColheita(false);
    setLidosLivro((n) => Math.max(0, n - 1));
    startTransition(async () => {
      const r = await alternarCapitulo(livro.slug, capitulo, false);
      if (!r.ok) {
        setLido(true);
        setLidosLivro((n) => n + 1);
      }
    });
  }

  const testamento = livro.testamento === "at" ? "Antigo Testamento" : "Novo Testamento";
  const quando = dataCurta(lidoEm);
  const hrefAnt = anterior ? `/biblia/${anterior.slug}/${anterior.capitulo}` : null;
  const hrefProx = proximo ? `/biblia/${proximo.slug}/${proximo.capitulo}` : null;

  const setas = (pos: "topo" | "base") => (
    <nav className={"ld-setas " + pos} aria-label="Navegar entre capítulos">
      {hrefAnt && anterior ? (
        <Link href={hrefAnt} className="ld-seta" prefetch={false}>
          <Seta dir="esq" />
          <span>
            <small>Anterior</small>
            {anterior.nome} {anterior.capitulo}
          </span>
        </Link>
      ) : (
        <span className="ld-seta vazia" aria-hidden />
      )}
      {hrefProx && proximo ? (
        <Link href={hrefProx} className="ld-seta dir" prefetch={false}>
          <span>
            <small>Próximo</small>
            {proximo.nome} {proximo.capitulo}
          </span>
          <Seta dir="dir" />
        </Link>
      ) : (
        <span className="ld-seta vazia" aria-hidden />
      )}
    </nav>
  );

  return (
    <main className={"ld ld-" + tamanho}>
      {/* ── Cabeçalho do capítulo ─────────────────────────────── */}
      <header className="ld-cab">
        <Link href="/biblia" className="ld-volta" prefetch={false}>
          <IconeBiblia size={15} /> Minha Bíblia
        </Link>
        <div className="ld-kick">
          {testamento} · {livro.grupo}
        </div>
        <h1>
          {livro.nome} <span className="tnum">{capitulo}</span>
        </h1>
        <p className="ld-sub">
          Capítulo <b className="tnum">{capitulo}</b> de <b className="tnum">{livro.capitulos}</b>
          {lidosLivro > 0 && (
            <>
              {" "}
              · <b className="tnum">{lidosLivro}</b> {lidosLivro === 1 ? "lido" : "lidos"} neste livro
            </>
          )}
        </p>
        <div className="ld-barra" aria-hidden>
          <i style={{ width: `${Math.round((lidosLivro / livro.capitulos) * 100)}%` }} />
        </div>

        <div className="ld-letra" role="group" aria-label="Tamanho da letra">
          <button type="button" className={tamanho === "p" ? "on" : ""} onClick={() => mudarTamanho("p")} aria-label="Letra pequena">
            <span style={{ fontSize: 13 }}>A</span>
          </button>
          <button type="button" className={tamanho === "m" ? "on" : ""} onClick={() => mudarTamanho("m")} aria-label="Letra média">
            <span style={{ fontSize: 16 }}>A</span>
          </button>
          <button type="button" className={tamanho === "g" ? "on" : ""} onClick={() => mudarTamanho("g")} aria-label="Letra grande">
            <span style={{ fontSize: 20 }}>A</span>
          </button>
        </div>
      </header>

      {setas("topo")}

      {/* ── O texto ────────────────────────────────────────────── */}
      <article className="ld-texto" lang="pt-BR">
        {versiculos.map((v, i) => (
          <p key={i} className="ld-vs" id={`v${i + 1}`}>
            <b className="ld-n tnum" aria-label={`Versículo ${i + 1}`}>
              {i + 1}
            </b>
            {v}
          </p>
        ))}
        <div className="ld-fecho" aria-hidden>
          <i />
          <IconeEspiga size={16} />
          <i />
        </div>
      </article>

      {/* ── A ação: marcar e seguir ──────────────────────────────── */}
      <section className={"ld-acao" + (festa ? " festa" : "")}>
        {colheita && (
          <div className="ld-colheita">
            <IconeEspiga size={20} />
            <span>
              <b>Que colheita!</b> Você leu {livro.nome} inteiro.
            </span>
          </div>
        )}

        {lido ? (
          <div className="ld-feito">
            <span className="ld-feito-ico">
              <Check size={18} strokeWidth={3} />
            </span>
            <span className="ld-feito-txt">
              <b>Capítulo lido</b>
              {quando && !festa ? <small>guardado em {quando}</small> : <small>guardado no seu marcador</small>}
            </span>
            <button type="button" className="ld-desfazer" onClick={desmarcar} disabled={pendente}>
              Desmarcar
            </button>
          </div>
        ) : (
          <button type="button" className="ld-btn" onClick={marcar} disabled={pendente}>
            <Check size={19} strokeWidth={3} aria-hidden /> Li este capítulo
          </button>
        )}

        {hrefProx && proximo && (
          <Link href={hrefProx} className={"ld-prox" + (lido ? " on" : "")} prefetch={false}>
            <span>
              <small>{fimDoLivro ? `Próximo livro` : `Continuar`}</small>
              {proximo.nome} {proximo.capitulo}
            </span>
            <Seta dir="dir" size={20} />
          </Link>
        )}
        {!hrefProx && lido && (
          <p className="ld-fim">
            Este é o último capítulo da Bíblia. Volte para a{" "}
            <Link href="/biblia" prefetch={false}>
              sua Bíblia
            </Link>{" "}
            e veja a caminhada inteira.
          </p>
        )}
      </section>

      {setas("base")}

      <style jsx global>{`
        .ld{max-width:720px;margin:0 auto;padding:clamp(18px,4vw,34px) clamp(16px,4vw,24px) 100px}

        /* cabeçalho */
        .ld-cab{position:relative;background:var(--paper);border:1px solid var(--line);border-radius:24px;padding:clamp(18px,3.4vw,28px) clamp(18px,3.4vw,28px) 20px;box-shadow:var(--shadow-sm)}
        .ld-volta{display:inline-flex;align-items:center;gap:7px;font-size:12.5px;font-weight:700;color:var(--muted);letter-spacing:.2px;margin-bottom:14px;transition:color .2s}
        .ld-volta:hover{color:var(--ouro)}
        .ld-kick{font-size:11px;letter-spacing:1.6px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .ld-cab h1{font-size:clamp(30px,5vw,44px);line-height:1.02;margin:8px 0 0;color:var(--ink)}
        .ld-cab h1 span{color:var(--ouro)}
        .ld-sub{font-size:13.5px;color:var(--muted);margin-top:8px}
        .ld-sub b{color:var(--base);font-weight:700}
        .ld-barra{height:5px;border-radius:99px;background:var(--line);overflow:hidden;margin-top:12px;max-width:260px}
        .ld-barra i{display:block;height:100%;border-radius:99px;background:linear-gradient(90deg,#C9A85C,#6A7A42);transition:width .7s cubic-bezier(.16,1,.3,1)}

        .ld-letra{position:absolute;right:clamp(14px,3vw,22px);top:clamp(14px,3vw,22px);display:flex;gap:2px;background:color-mix(in srgb,var(--areia) 30%,transparent);border:1px solid var(--line);border-radius:99px;padding:3px}
        .ld-letra button{display:grid;place-items:center;width:34px;height:30px;border:0;border-radius:99px;background:transparent;color:var(--muted);font-family:var(--serif);font-weight:600;cursor:pointer;transition:.2s;line-height:1}
        .ld-letra button:hover{color:var(--base)}
        .ld-letra button.on{background:var(--paper);color:var(--ouro);box-shadow:var(--shadow-sm)}

        /* setas */
        .ld-setas{display:flex;justify-content:space-between;gap:10px;margin:14px 0}
        .ld-setas.base{margin-top:22px}
        .ld-seta{display:inline-flex;align-items:center;gap:8px;padding:10px 14px;border-radius:14px;border:1px solid var(--line);background:var(--paper);color:var(--base);font-size:14px;font-weight:600;transition:.2s;max-width:48%}
        .ld-seta span{display:flex;flex-direction:column;line-height:1.15;min-width:0}
        .ld-seta span small{font-size:10.5px;letter-spacing:1px;text-transform:uppercase;color:var(--muted);font-weight:700}
        .ld-seta.dir span{align-items:flex-end;text-align:right}
        .ld-seta:hover{border-color:var(--ambar);color:var(--ouro);transform:translateY(-1px)}
        .ld-seta.vazia{visibility:hidden}

        /* texto */
        .ld-texto{background:var(--paper);border:1px solid var(--line);border-radius:24px;padding:clamp(22px,4vw,40px) clamp(18px,4.5vw,44px) 26px;box-shadow:var(--shadow-sm);font-family:var(--serif);color:#33291B;line-height:1.82}
        .ld-p .ld-texto{font-size:16.5px}
        .ld-m .ld-texto{font-size:19px}
        .ld-g .ld-texto{font-size:22px;line-height:1.86}
        .ld-vs{position:relative;padding-left:1.8em;margin:0 0 .55em;text-wrap:pretty}
        .ld-vs:last-of-type{margin-bottom:0}
        .ld-n{position:absolute;left:0;top:.42em;font-family:var(--sans);font-size:.58em;font-weight:700;color:var(--ouro);letter-spacing:.02em;line-height:1}
        .ld-fecho{display:flex;align-items:center;gap:12px;color:var(--ambar);margin:28px 0 0}
        .ld-fecho i{flex:1;height:1px;background:linear-gradient(90deg,transparent,var(--fio),transparent)}

        /* ação */
        .ld-acao{position:relative;margin-top:14px;background:var(--paper);border:1px solid var(--line);border-radius:24px;padding:clamp(16px,3vw,22px);box-shadow:var(--shadow-sm);display:flex;flex-direction:column;gap:12px}
        .ld-acao.festa{animation:ldPulso 2.2s ease-out}
        @keyframes ldPulso{0%{box-shadow:0 0 0 0 color-mix(in srgb,var(--ambar) 70%,transparent)}60%{box-shadow:0 0 0 14px transparent}100%{box-shadow:var(--shadow-sm)}}

        .ld-btn{display:flex;align-items:center;justify-content:center;gap:10px;width:100%;font-family:var(--sans);font-weight:700;font-size:16px;letter-spacing:.2px;color:#FCF8EF;background:linear-gradient(140deg,#63703F,#4A5430);border:0;border-radius:17px;padding:18px;cursor:pointer;box-shadow:0 12px 28px -12px rgba(74,84,48,.8);transition:transform .2s cubic-bezier(.34,1.56,.64,1),box-shadow .2s}
        .ld-btn:hover:not(:disabled){transform:translateY(-2px);box-shadow:0 18px 34px -14px rgba(74,84,48,.85)}
        .ld-btn:active:not(:disabled){transform:scale(.98)}
        .ld-btn:disabled{opacity:.7;cursor:progress}

        .ld-feito{display:flex;align-items:center;gap:12px;background:color-mix(in srgb,var(--areia) 46%,var(--paper));border:1px solid color-mix(in srgb,var(--ambar) 50%,var(--line));border-radius:17px;padding:13px 16px;animation:ldEntra .45s cubic-bezier(.34,1.56,.64,1)}
        @keyframes ldEntra{0%{transform:scale(.96);opacity:0}100%{transform:none;opacity:1}}
        .ld-feito-ico{display:grid;place-items:center;width:34px;height:34px;border-radius:50%;background:linear-gradient(140deg,#C9A85C,#8F6D1E);color:#FCF8EF;flex:none}
        .ld-feito-txt{display:flex;flex-direction:column;line-height:1.2;flex:1;min-width:0}
        .ld-feito-txt b{font-family:var(--serif);font-size:16px;color:var(--base)}
        .ld-feito-txt small{font-size:12px;color:var(--muted);margin-top:2px}
        .ld-desfazer{font-family:var(--sans);font-size:12px;font-weight:700;letter-spacing:.4px;text-transform:uppercase;color:var(--muted);background:transparent;border:0;cursor:pointer;padding:6px 4px}
        .ld-desfazer:hover{color:var(--coral);text-decoration:underline}

        .ld-prox{display:flex;align-items:center;justify-content:space-between;gap:12px;padding:14px 16px;border-radius:16px;border:1px solid var(--line);background:transparent;color:var(--base);transition:.25s}
        .ld-prox span{display:flex;flex-direction:column;line-height:1.15;font-family:var(--serif);font-size:17px;font-weight:600}
        .ld-prox span small{font-family:var(--sans);font-size:10.5px;letter-spacing:1px;text-transform:uppercase;color:var(--muted);font-weight:700;margin-bottom:2px}
        .ld-prox:hover{border-color:var(--ambar);color:var(--ouro);transform:translateX(2px)}
        .ld-prox.on{background:var(--base);border-color:var(--base);color:var(--areia);animation:ldSobe .5s cubic-bezier(.16,1,.3,1)}
        .ld-prox.on span small{color:color-mix(in srgb,var(--areia) 70%,transparent)}
        .ld-prox.on:hover{color:var(--creme);transform:translateX(3px)}
        @keyframes ldSobe{from{opacity:0;transform:translateY(8px)}to{opacity:1;transform:none}}
        .ld-fim{font-family:var(--serif);font-style:italic;font-size:15px;color:var(--base);text-align:center;margin:4px 0}
        .ld-fim a{color:var(--ouro);text-decoration:underline}

        .ld-colheita{display:flex;align-items:center;gap:10px;background:var(--base);color:var(--areia);border-radius:16px;padding:13px 16px;font-size:14.5px;animation:ldSobe .5s cubic-bezier(.16,1,.3,1)}
        .ld-colheita svg{color:var(--ambar);flex:none}
        .ld-colheita b{color:var(--creme)}

        @media(max-width:560px){
          .ld-letra{position:static;margin-top:14px;align-self:flex-start;width:max-content}
          .ld-seta{padding:9px 11px;font-size:13px}
          .ld-seta span small{display:none}
        }
        @media (prefers-reduced-motion: reduce){
          .ld-acao.festa,.ld-feito,.ld-prox.on,.ld-colheita{animation:none}
          .ld-seta,.ld-prox,.ld-btn,.ld-barra i{transition:none}
        }
      `}</style>
    </main>
  );
}
