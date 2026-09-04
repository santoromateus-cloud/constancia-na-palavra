"use client";

import { useEffect, useRef, useState, useTransition } from "react";
import Link from "next/link";
import {
  IconeCandeia,
  IconeComentario,
  IconeCuriosidade,
  IconeEspiga,
  IconeGeografia,
  IconePerola,
} from "../Icones";
import { liHoje, salvarCaderno } from "../actions";

/* ============================================================
   A TELA DE HOJE — o núcleo da gamificação
   Três mecânicas do doc GAMIFICACAO-LOCKIN, agora com tela:
     1. Candeia   — a sequência de dias, com chama viva
     2. A Seara   — o campo que cresce, uma espiga por leitura
     5. Pérolas   — o versículo-joia revelado no check-in
   Mais o Recomeço com Memória (3): quem quebra a sequência não perde o que andou.
   E, desde 02/09/2026, O CADERNO: as quatro perguntas sobre o capítulo lido.

   Regra de design que atravessa tudo: motor é honra, crescimento e
   companhia — nunca culpa. Nada aqui diz "você falhou".
   ============================================================ */

type Perola = { n: number; texto: string } | null;

type Camadas = {
  comentario: string | null;
  comentarioAutor: string | null;
  comentarioObra: string | null;
  geografia: string | null;
  geografiaLugar: string | null;
  curiosidade: string | null;
  fonte: string | null;
};

/* O que já está escrito no caderno para o dia que está na tela (ou null). */
type EntradaSalva = {
  promessa: string | null;
  ordem: string | null;
  principio: string | null;
  passo: string;
} | null;

type Props = {
  planoId: string;
  planoTitulo: string;
  referencia: string | null;
  texto: string | null;
  diaAtual: number;
  totalDias: number;
  progressoPct: number;
  jaLeuHoje: boolean;
  concluido: boolean;
  streak: number;
  recorde: number;
  espigas: number;
  perola: Perola;
  camadas: Camadas;
  entrada: EntradaSalva;
};

/* Caderno aberto com a caneta em cima: o ícone da peça. Local e não em
   Icones.tsx porque é pequeno e só três telas usam — mesmo padrão dos
   ícones do mural. */
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

/* ── AS CAMADAS DO DIA ──────────────────────────────
   O que vem por cima do texto nos caminhos que têm essa prática: o
   comentário de um autor de domínio público, o lugar onde a cena se
   passou e a curiosidade de contexto.

   Ficam ANTES da pérola e sem depender do check-in de propósito: a
   pérola é prêmio (só aparece depois de marcar), mas geografia e
   contexto ajudam a ENTENDER — segurar isso atrás de um botão seria
   cobrar pedágio na compreensão.

   O crédito nunca é opcional: o autor e a obra vêm coladas na citação,
   e o banco recusa comentário sem os dois (CHECK da migration 009). */
function Camadas({ c }: { c: Camadas }) {
  const temComentario = Boolean(c.comentario && c.comentarioAutor && c.comentarioObra);
  if (!temComentario && !c.geografia && !c.curiosidade) return null;

  return (
    <section className="camadas">
      {temComentario && (
        <article className="cd cd-com">
          <span className="cd-kick">
            <IconeComentario size={15} /> O comentário
          </span>
          <blockquote>{c.comentario}</blockquote>
          <cite>
            {c.comentarioAutor}
            <b>{c.comentarioObra}</b>
          </cite>
        </article>
      )}

      {c.geografia && (
        <article className="cd cd-geo">
          <span className="cd-kick">
            <IconeGeografia size={15} /> Onde foi
          </span>
          {c.geografiaLugar && <h3>{c.geografiaLugar}</h3>}
          <p>{c.geografia}</p>
        </article>
      )}

      {c.curiosidade && (
        <article className="cd cd-cur">
          <span className="cd-kick">
            <IconeCuriosidade size={15} /> O detalhe que muda tudo
          </span>
          <p>{c.curiosidade}</p>
        </article>
      )}
    </section>
  );
}

/* ── A SEARA ─────────────────────────
   Campo de espigas em SVG. Uma espiga por dia lido, até 30 na tela;
   depois disso o campo continua no contador, senão vira poluição.
   O que importa é a leitora ver o campo dela crescer, não contar grão. */
function Seara({ espigas, brotando }: { espigas: number; brotando: boolean }) {
  const visiveis = Math.min(espigas, 30);
  const haste = Array.from({ length: visiveis }, (_, i) => i);

  return (
    <div className={"lavra" + (brotando ? " brotou" : "")}>
      <svg viewBox="0 0 320 84" className="lavra-svg" aria-hidden>
        <defs>
          <linearGradient id="lvTerra" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#B8A57A" stopOpacity=".28" />
            <stop offset="100%" stopColor="#8A793F" stopOpacity=".16" />
          </linearGradient>
        </defs>
        {/* a terra */}
        <path d="M0 70 Q80 64 160 68 T320 66 L320 84 L0 84 Z" fill="url(#lvTerra)" />
        <path d="M0 70 Q80 64 160 68 T320 66" fill="none" stroke="#A8945F" strokeOpacity=".4" strokeWidth="1" />

        {haste.map((i) => {
          const x = 12 + i * 10.2;
          const alt = 26 + ((i * 13) % 11); // altura variada, campo não é régua
          const base = 69 - ((i * 7) % 4);
          const nova = brotando && i === visiveis - 1;
          return (
            <g key={i} className={"lv-espiga" + (nova ? " nova" : "")} style={{ ["--d" as string]: `${i * 24}ms` }}>
              <path
                d={`M${x} ${base} L${x} ${base - alt}`}
                stroke="#6A7A42"
                strokeWidth="1.4"
                strokeLinecap="round"
                fill="none"
              />
              {[0, 1, 2].map((g) => {
                const gy = base - alt + 4 + g * 6;
                return (
                  <g key={g}>
                    <path d={`M${x} ${gy} q-3.4 -1.4 -3.4 -4 q3.4 .6 3.4 4Z`} fill="#C9A85C" />
                    <path d={`M${x} ${gy} q3.4 -1.4 3.4 -4 q-3.4 .6 -3.4 4Z`} fill="#C9A85C" />
                  </g>
                );
              })}
            </g>
          );
        })}
      </svg>

      <style jsx>{`
        .lavra{position:relative;width:100%}
        .lavra-svg{display:block;width:100%;height:auto}
        .lavra :global(.lv-espiga){
          transform-origin:center bottom;
          animation:lvBalanca 4.6s ease-in-out infinite;
          animation-delay:var(--d);
        }
        @keyframes lvBalanca{
          0%,100%{transform:rotate(-.9deg)}
          50%{transform:rotate(.9deg)}
        }
        .lavra :global(.lv-espiga.nova){animation:lvBrota .9s cubic-bezier(.34,1.56,.64,1)}
        @keyframes lvBrota{
          0%{transform:scaleY(0) translateY(6px);opacity:0}
          60%{transform:scaleY(1.12) translateY(0);opacity:1}
          100%{transform:scaleY(1)}
        }
        @media (prefers-reduced-motion: reduce){
          .lavra :global(.lv-espiga){animation:none}
        }
      `}</style>
    </div>
  );
}

/* ── CELEBRAÇÃO ───────────────────────
   1,5s de dopamina limpa: partículas douradas subindo do botão.
   BJ Fogg — a emoção positiva no instante do hábito é o que consolida. */
function Particulas({ ativo }: { ativo: boolean }) {
  if (!ativo) return null;
  const p = Array.from({ length: 18 }, (_, i) => i);
  return (
    <div className="parts" aria-hidden>
      {p.map((i) => (
        <i
          key={i}
          style={{
            ["--x" as string]: `${(i % 2 ? 1 : -1) * (8 + ((i * 17) % 46))}px`,
            ["--d" as string]: `${(i * 34) % 260}ms`,
            ["--s" as string]: `${5 + ((i * 5) % 5)}px`,
          }}
        />
      ))}
      <style jsx>{`
        .parts{position:absolute;inset:0;pointer-events:none;overflow:visible}
        .parts i{
          position:absolute;left:50%;top:50%;
          width:var(--s);height:var(--s);border-radius:50%;
          background:radial-gradient(circle at 35% 30%,#F2E2B4,#C9A85C 60%,#8F6D1E);
          opacity:0;animation:sobe 1.25s cubic-bezier(.16,1,.3,1) forwards;
          animation-delay:var(--d);
        }
        @keyframes sobe{
          0%{opacity:0;transform:translate(-50%,-50%) scale(.4)}
          22%{opacity:1}
          100%{opacity:0;transform:translate(calc(-50% + var(--x)),-190%) scale(.85)}
        }
        @media (prefers-reduced-motion: reduce){.parts{display:none}}
      `}</style>
    </div>
  );
}

/* LEITURA LIVRE (02/09/2026) — a decisão que muda esta tela.
   Antes: um registro por dia de calendário. Quem lia três capítulos numa sentada
   via a tela travada em "Leitura de hoje guardada" e o caminho parado — o app
   dizia "chega por hoje" pra quem estava com vontade de ler. Isso é o oposto do
   produto.
   Agora: ela registra QUANTOS DIAS QUISER. O caminho anda de verdade a cada
   toque, a Seara ganha uma espiga por dia lido. O que NÃO infla é a constância:
   a Candeia (sequência) e o recorde continuam contando por dia de calendário,
   no servidor. Ler muito num dia rende caminho e Seara; voltar
   amanhã é o que rende sequência. */

export default function LerClient(p: Props) {
  // marcado = registrou o dia que está na tela AGORA (some quando o servidor
  // devolve o próximo dia, porque a página remonta com key={diaAtual})
  const [marcado, setMarcado] = useState(false);
  const [festa, setFesta] = useState(false);
  const [mostrarPerola, setMostrarPerola] = useState(p.jaLeuHoje);
  const [pendente, startTransition] = useTransition();
  const jaMontou = useRef(false);

  // ── O CADERNO: o rascunho vive aqui, no dia que está na tela ──
  const [promessa, setPromessa] = useState(p.entrada?.promessa ?? "");
  const [ordem, setOrdem] = useState(p.entrada?.ordem ?? "");
  const [principio, setPrincipio] = useState(p.entrada?.principio ?? "");
  const [passo, setPasso] = useState(p.entrada?.passo ?? "");
  const [salvando, setSalvando] = useState(false);
  const [salvo, setSalvo] = useState(!!p.entrada);
  const [erroCaderno, setErroCaderno] = useState("");

  // otimista: a tela responde no toque, o servidor confirma.
  // A sequência só sobe se este for o PRIMEIRO registro do dia de calendário.
  const primeiroDeHoje = marcado && !p.jaLeuHoje;
  const streak = p.streak + (primeiroDeHoje ? 1 : 0);
  const espigas = p.espigas + (marcado ? 1 : 0);

  useEffect(() => {
    jaMontou.current = true;
  }, []);

  async function guardarCaderno(silencioso = false): Promise<boolean> {
    if (!passo.trim()) {
      if (!silencioso) setErroCaderno("Escreva pelo menos o passo de hoje.");
      return false;
    }
    setSalvando(true);
    setErroCaderno("");
    try {
      const r = await salvarCaderno({
        planId: p.planoId,
        dia: p.diaAtual,
        referencia: p.referencia,
        promessa,
        ordem,
        principio,
        passo,
        perola: p.perola,
      });
      if (!r.ok) {
        setErroCaderno("Não consegui guardar agora. Tente de novo.");
        return false;
      }
      setSalvo(true);
      return true;
    } catch {
      setErroCaderno("Não consegui guardar agora. Tente de novo.");
      return false;
    } finally {
      setSalvando(false);
    }
  }

  async function marcar() {
    if (marcado || p.concluido) return;
    // Se ela escreveu no caderno e não guardou, o toque em "Li hoje" guarda
    // junto. A página avança de dia logo em seguida e o rascunho iria embora —
    // perder texto de leitora por causa de uma remontagem é inaceitável.
    if (passo.trim() && !salvo) await guardarCaderno(true);

    setMarcado(true);
    setFesta(true);
    setTimeout(() => setMostrarPerola(true), 520);
    setTimeout(() => setFesta(false), 1500);
    startTransition(() => {
      void liHoje();
    });
  }

  const quebrou = p.streak === 0 && p.espigas > 0 && !marcado;
  const passagem = p.referencia ?? `Dia ${p.diaAtual}`;

  return (
    <main className="hoje">
      {/* ── CANDEIA: a sequência, com a chama viva ── */}
      <section className={"candeia-box" + (festa ? " festa" : "")}>
        <div className="candeia-luz" aria-hidden />
        <div className="candeia-ico">
          <IconeCandeia size={54} strokeWidth={1.3} />
        </div>
        <div className="candeia-num">
          <b className="tnum">{streak}</b>
          <span>{streak === 1 ? "dia seguido" : "dias seguidos"}</span>
        </div>
        <div className="candeia-lado">
          <div className="cl-item">
            <b className="tnum">{espigas}</b>
            <span>na Palavra</span>
          </div>
          <div className="cl-item">
            <b className="tnum">{p.recorde}</b>
            <span>seu recorde</span>
          </div>
        </div>
      </section>

      {/* Recomeço com Memória: quem quebrou a sequência não leva bronca.
          O maior churn de app de streak é o dia seguinte à quebra. */}
      {quebrou && (
        <p className="recomeco">
          Seu recorde foi de <b>{p.recorde} dias</b>, e você já tem{" "}
          <b>{p.espigas} dias na Palavra</b>. A graça é nova a cada manhã. Recomece de onde
          você parou, não do zero.
        </p>
      )}

      {/* ── A SEARA ── */}
      <section className="lavra-box">
        <header>
          <span className="lb-kick">
            <IconeEspiga size={15} /> A sua Seara
          </span>
          <span className="lb-conta">
            {espigas} {espigas === 1 ? "espiga" : "espigas"}
          </span>
        </header>
        <Seara espigas={espigas} brotando={festa} />
        <p className="lb-frase">
          {espigas === 0
            ? "Seu campo está pronto. A primeira espiga nasce na sua primeira leitura."
            : "No tempo próprio ceifaremos, se não desfalecermos."}
        </p>
      </section>

      {/* ── A LEITURA DE HOJE ── */}
      <section className="leitura">
        <div className="lt-topo">
          <div>
            <span className="lt-plano">{p.planoTitulo}</span>
            <h1>{passagem}</h1>
          </div>
          <div className="lt-dia">
            <b className="tnum">{p.diaAtual}</b>
            <span>de {p.totalDias}</span>
          </div>
        </div>

        <div className="lt-barra">
          <i style={{ width: `${Math.max(3, p.progressoPct)}%` }} />
        </div>

        {p.texto ? (
          <div className="lt-texto">{p.texto}</div>
        ) : (
          <div className="lt-texto lt-vazio">
            O texto deste dia ainda não foi carregado. Abra a sua Bíblia em{" "}
            <b>{passagem}</b> e volte para marcar.
          </div>
        )}

        <div className="lt-acao">
          <Particulas ativo={festa} />
          <button
            type="button"
            onClick={marcar}
            disabled={marcado || pendente || p.concluido}
            className={"lt-btn" + (marcado || p.concluido ? " feito" : "")}
          >
            {p.concluido
              ? "Caminho concluído"
              : marcado
                ? "Guardado"
                : p.jaLeuHoje
                  ? "Li este dia também"
                  : "Li hoje"}
          </button>
        </div>

        {!marcado && !p.concluido && (
          <p className="lt-mini">
            {p.jaLeuHoje
              ? "A sua sequência de hoje já está contada. Siga lendo à vontade — o caminho anda junto."
              : "Um toque. É só isso que a sua sequência pede."}
          </p>
        )}
      </section>

      {/* ── AS CAMADAS: comentário, geografia e curiosidade do dia ── */}
      <Camadas c={p.camadas} />

      {/* ── A PÉROLA: a joia que ela guarda do que acabou de ler ── */}
      {mostrarPerola && p.perola && (
        <section className="perola">
          <span className="pr-kick">
            <IconePerola size={16} /> A pérola de hoje
          </span>
          <blockquote>{p.perola.texto}</blockquote>
          <cite>
            {p.referencia}:{p.perola.n}
          </cite>
        </section>
      )}

      {/* ── O CADERNO ────────────────────────────────
          As quatro perguntas sobre o capítulo que ela acabou de ler.
          Três opcionais, uma obrigatória — a regra está explicada na tela
          porque ela é a diferença entre ler o texto e forçar um molde sobre
          ele. Nada daqui vai para o mural: é dela e só dela. */}
      <section className="caderno">
        <header className="cad-topo">
          <span className="cad-kick">
            <IconeCaderno size={15} /> O seu caderno
          </span>
          <span className="cad-ref">{passagem}</span>
        </header>

        <p className="cad-regra">
          Nem todo capítulo traz as quatro coisas. Escreva as que estiverem no texto —
          o passo é o único que nunca falta.
        </p>

        <div className="cad-campos">
          <label className="cad-campo">
            <span className="cad-rot">Uma promessa</span>
            <textarea
              value={promessa}
              onChange={(e) => { setPromessa(e.target.value); setSalvo(false); }}
              maxLength={600}
              rows={2}
              placeholder="O que Deus prometeu aqui?"
            />
          </label>

          <label className="cad-campo">
            <span className="cad-rot">Uma ordem</span>
            <textarea
              value={ordem}
              onChange={(e) => { setOrdem(e.target.value); setSalvo(false); }}
              maxLength={600}
              rows={2}
              placeholder="O que Ele mandou fazer?"
            />
          </label>

          <label className="cad-campo">
            <span className="cad-rot">Um princípio</span>
            <textarea
              value={principio}
              onChange={(e) => { setPrincipio(e.target.value); setSalvo(false); }}
              maxLength={600}
              rows={2}
              placeholder="O que isso ensina que vale para sempre?"
            />
          </label>

          <label className="cad-campo obrigatorio">
            <span className="cad-rot">
              Um passo <b>hoje</b>
            </span>
            <textarea
              value={passo}
              onChange={(e) => { setPasso(e.target.value); setSalvo(false); setErroCaderno(""); }}
              maxLength={600}
              rows={2}
              placeholder="O que eu faço com isso hoje?"
            />
          </label>
        </div>

        {erroCaderno && <p className="cad-erro">{erroCaderno}</p>}

        <div className="cad-pe">
          <button
            type="button"
            className={"cad-btn" + (salvo ? " feito" : "")}
            onClick={() => void guardarCaderno()}
            disabled={salvando}
          >
            {salvando ? "Guardando…" : salvo ? "Guardado no caderno" : "Guardar no caderno"}
          </button>
          <Link href="/caderno" className="cad-link">ver o meu caderno →</Link>
        </div>
      </section>

      {p.progressoPct >= 100 && (
        <Link href="/planos" className="proximo">
          Você terminou este caminho. Escolher o próximo →
        </Link>
      )}

      <style jsx global>{`
        .hoje{max-width:720px;margin:0 auto;padding:clamp(18px,3.4vw,30px) clamp(14px,4vw,20px) 90px;display:flex;flex-direction:column;gap:16px}

        /* ---------- CANDEIA ---------- */
        .candeia-box{
          position:relative;overflow:hidden;
          display:flex;align-items:center;gap:clamp(14px,3vw,26px);
          background:linear-gradient(150deg,#3B2F1E 0%,#2C2215 100%);
          color:var(--creme);border-radius:26px;
          padding:clamp(20px,3.4vw,28px) clamp(20px,3.6vw,30px);
          box-shadow:0 20px 50px -24px rgba(44,34,21,.7);
        }
        /* halo quente atrás da chama — pulsa devagar, como luz de vela */
        .candeia-luz{
          position:absolute;left:clamp(24px,4vw,40px);top:50%;width:190px;height:190px;
          transform:translateY(-50%);pointer-events:none;
          background:radial-gradient(circle,rgba(201,168,92,.34),transparent 66%);
          animation:halo 3.6s ease-in-out infinite;
        }
        @keyframes halo{0%,100%{opacity:.55;transform:translateY(-50%) scale(1)}50%{opacity:.95;transform:translateY(-50%) scale(1.1)}}
        .candeia-ico{position:relative;color:var(--ambar);flex:none;animation:tremula 3.2s ease-in-out infinite;transform-origin:50% 80%}
        @keyframes tremula{0%,100%{transform:rotate(-1.2deg) scale(1)}50%{transform:rotate(1.2deg) scale(1.04)}}
        .candeia-box.festa .candeia-ico{animation:acende .9s cubic-bezier(.34,1.56,.64,1)}
        @keyframes acende{0%{transform:scale(1)}45%{transform:scale(1.32)}100%{transform:scale(1)}}

        .candeia-num{position:relative;flex:none;line-height:1}
        .candeia-num b{font-family:var(--display);font-size:clamp(42px,7vw,58px);color:#FCF8EF;display:block}
        .candeia-num span{font-size:12px;letter-spacing:1.4px;text-transform:uppercase;font-weight:700;color:var(--ambar);margin-top:6px;display:block}

        .candeia-lado{position:relative;margin-left:auto;display:flex;gap:clamp(10px,2.4vw,22px)}
        .cl-item{text-align:right}
        .cl-item b{font-family:var(--display);font-size:20px;color:var(--areia);display:block;line-height:1}
        .cl-item span{font-size:10.5px;color:color-mix(in srgb,var(--creme) 56%,transparent);margin-top:4px;display:block}

        /* ---------- recomeço sem culpa ---------- */
        .recomeco{
          background:color-mix(in srgb,var(--areia) 38%,var(--paper));
          border:1px solid var(--line);border-left:3px solid var(--ambar);
          border-radius:0 16px 16px 0;padding:15px 18px;
          font-family:var(--serif);font-size:14.5px;line-height:1.6;color:#5D4E39;
        }
        .recomeco b{color:var(--base);font-weight:600}

        /* ---------- LAVRA ---------- */
        .lavra-box{background:var(--paper);border:1px solid var(--line);border-radius:24px;padding:20px clamp(16px,3vw,24px) 14px;box-shadow:var(--shadow-sm)}
        .lavra-box header{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-bottom:6px}
        .lb-kick{display:inline-flex;align-items:center;gap:7px;font-size:11.5px;letter-spacing:1.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .lb-conta{font-size:12.5px;color:var(--muted);font-weight:600}
        .lb-frase{font-family:var(--serif);font-style:italic;font-size:13.5px;color:var(--muted);text-align:center;margin-top:2px}

        /* ---------- LEITURA ---------- */
        .leitura{background:var(--paper);border:1px solid var(--line);border-radius:26px;padding:clamp(20px,3.6vw,32px);box-shadow:var(--shadow-sm)}
        .lt-topo{display:flex;align-items:flex-start;justify-content:space-between;gap:16px}
        .lt-plano{font-size:11.5px;letter-spacing:1.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .lt-topo h1{font-family:var(--display);font-size:clamp(27px,4.4vw,40px);line-height:1.06;margin:8px 0 0;color:var(--ink)}
        .lt-dia{text-align:right;flex:none}
        .lt-dia b{font-family:var(--display);font-size:30px;color:var(--base);display:block;line-height:1}
        .lt-dia span{font-size:11.5px;color:var(--muted)}
        .lt-barra{height:7px;border-radius:99px;background:var(--line);overflow:hidden;margin:18px 0 22px}
        .lt-barra i{display:block;height:100%;border-radius:99px;background:linear-gradient(90deg,#C9A85C,#6A7A42);transition:width .9s cubic-bezier(.16,1,.3,1)}

        .lt-texto{
          white-space:pre-line;font-family:var(--serif);font-size:17px;line-height:1.78;color:#33291B;
          background:color-mix(in srgb,var(--areia) 15%,var(--paper));
          border-left:3px solid var(--fio);border-radius:0 16px 16px 0;
          padding:22px clamp(18px,3vw,26px);max-height:48vh;overflow-y:auto;
        }
        .lt-vazio{white-space:normal;font-style:italic;color:#6C5C45}

        .lt-acao{position:relative;margin-top:24px}
        .lt-btn{
          position:relative;display:block;width:100%;
          font-family:var(--sans);font-weight:700;font-size:16px;letter-spacing:.2px;
          color:#FCF8EF;background:linear-gradient(140deg,#63703F,#4A5430);
          border:0;border-radius:17px;padding:18px;cursor:pointer;
          box-shadow:0 12px 28px -12px rgba(74,84,48,.8);
          transition:transform .2s cubic-bezier(.34,1.56,.64,1),box-shadow .2s,background .3s;
        }
        .lt-btn:hover:not(:disabled){transform:translateY(-2px);box-shadow:0 18px 34px -14px rgba(74,84,48,.85)}
        .lt-btn:active:not(:disabled){transform:scale(.98)}
        .lt-btn.feito{
          background:color-mix(in srgb,var(--areia) 46%,var(--paper));
          color:var(--ouro);box-shadow:none;cursor:default;
          border:1px solid color-mix(in srgb,var(--ambar) 50%,var(--line));
        }
        .lt-mini{text-align:center;font-size:12.5px;color:var(--muted);margin-top:12px}

        /* ---------- CAMADAS DO DIA ----------
           Três cards com peso visual DIFERENTE de propósito: o comentário é
           voz de gente e ganha o bloco escuro; geografia e curiosidade são
           nota de rodapé boa e ficam em papel. Assim a leitora sabe o que é
           citação e o que é contexto sem precisar ler o rótulo. */
        .camadas{display:flex;flex-direction:column;gap:14px}
        .cd{
          border-radius:22px;padding:clamp(19px,3.2vw,26px);
          animation:cdSobe .7s cubic-bezier(.16,1,.3,1) both;
        }
        .camadas .cd:nth-child(2){animation-delay:.09s}
        .camadas .cd:nth-child(3){animation-delay:.18s}
        @keyframes cdSobe{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:none}}
        .cd-kick{display:inline-flex;align-items:center;gap:8px;font-size:11px;letter-spacing:1.5px;text-transform:uppercase;font-weight:700}

        /* o comentário: bloco escuro, aspas de verdade, crédito colado */
        .cd-com{
          background:linear-gradient(152deg,#3B2F1E 0%,#2C2215 100%);
          color:var(--creme);position:relative;overflow:hidden;
          box-shadow:0 16px 40px -22px rgba(44,34,21,.75);
        }
        .cd-com::before{
          content:"“";position:absolute;top:-26px;right:12px;
          font-family:var(--display);font-size:150px;line-height:1;
          color:rgba(201,168,92,.13);pointer-events:none;
        }
        .cd-com .cd-kick{color:var(--areia)}
        .cd-com blockquote{
          font-family:var(--serif);font-style:italic;
          font-size:clamp(16px,2.1vw,19px);line-height:1.6;
          color:#F1E7D2;margin:14px 0 0;position:relative;
        }
        .cd-com cite{
          display:block;font-style:normal;margin-top:16px;padding-top:14px;
          border-top:1px solid rgba(232,217,174,.22);
          font-size:13px;font-weight:700;color:var(--areia);
        }
        .cd-com cite b{display:block;font-weight:400;font-size:12px;color:#B9A87E;margin-top:3px}

        /* geografia e curiosidade: papel, fio dourado à esquerda */
        .cd-geo,.cd-cur{
          background:var(--paper);border:1px solid var(--line);
          border-left:3px solid var(--ambar);
          border-radius:6px 22px 22px 6px;
          box-shadow:var(--shadow-sm);
        }
        .cd-geo .cd-kick,.cd-cur .cd-kick{color:var(--ouro)}
        .cd-geo h3{font-family:var(--display);font-weight:400;font-size:clamp(19px,2.4vw,23px);color:var(--ink);margin:11px 0 0;line-height:1.15}
        .cd-geo p,.cd-cur p{font-size:15px;line-height:1.66;color:#5D4E39;margin:10px 0 0}
        .cd-cur{border-left-color:var(--coral)}

        /* ---------- PÉROLA ---------- */
        .perola{
          background:linear-gradient(145deg,color-mix(in srgb,var(--areia) 46%,var(--paper)),var(--paper) 70%);
          border:1px solid color-mix(in srgb,var(--ambar) 42%,var(--line));
          border-radius:24px;padding:clamp(20px,3.4vw,28px);
          animation:prAbre .7s cubic-bezier(.16,1,.3,1) both;
          box-shadow:0 14px 40px -20px rgba(143,109,30,.5);
        }
        @keyframes prAbre{from{opacity:0;transform:translateY(14px) scale(.97)}to{opacity:1;transform:none}}
        .pr-kick{display:inline-flex;align-items:center;gap:8px;font-size:11.5px;letter-spacing:1.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .perola blockquote{font-family:var(--serif);font-style:italic;font-size:clamp(17px,2.4vw,21px);line-height:1.55;color:var(--base);margin:14px 0 0}
        .perola cite{display:block;font-style:normal;font-size:12px;letter-spacing:1.4px;text-transform:uppercase;font-weight:700;color:var(--ouro);margin-top:14px}

        /* ---------- O CADERNO ----------
           Papel pautado: a única superfície do produto em que quem escreve é
           ela. Fio à esquerda como margem de caderno, e o campo obrigatório
           ganha a cor da casa para não haver dúvida de qual é qual. */
        .caderno{
          background:var(--paper);border:1px solid var(--line);
          border-left:3px solid var(--fio);
          border-radius:6px 24px 24px 6px;
          padding:clamp(20px,3.4vw,28px);box-shadow:var(--shadow-sm);
        }
        .cad-topo{display:flex;align-items:baseline;justify-content:space-between;gap:12px;flex-wrap:wrap}
        .cad-kick{display:inline-flex;align-items:center;gap:8px;font-size:11.5px;letter-spacing:1.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .cad-ref{font-family:var(--serif);font-style:italic;font-size:14px;color:var(--coral)}
        .cad-regra{font-size:13px;line-height:1.6;color:var(--muted);margin:12px 0 18px;max-width:56ch}
        .cad-campos{display:flex;flex-direction:column;gap:14px}
        .cad-campo{display:flex;flex-direction:column;gap:6px}
        .cad-rot{font-size:11.5px;letter-spacing:1.2px;text-transform:uppercase;font-weight:700;color:var(--muted)}
        .cad-campo.obrigatorio .cad-rot{color:var(--coral)}
        .cad-rot b{font-weight:700}
        .cad-campo textarea{
          width:100%;border:1px solid var(--line);border-radius:12px;
          padding:11px 14px;font-family:var(--serif);font-size:15.5px;line-height:1.6;
          color:var(--ink);background:color-mix(in srgb,var(--areia) 12%,var(--paper));
          resize:vertical;outline:none;transition:border-color .18s;
        }
        .cad-campo textarea:focus{border-color:var(--ambar)}
        .cad-campo.obrigatorio textarea:focus{border-color:var(--coral)}
        .cad-campo textarea::placeholder{font-family:var(--sans);font-size:14px;color:#A8967A}
        .cad-erro{font-size:13px;color:#8C3A3A;margin-top:12px}
        .cad-pe{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;margin-top:18px}
        .cad-btn{
          font-family:var(--sans);font-weight:700;font-size:14.5px;
          background:var(--coral);color:#FCF8EF;border:0;border-radius:13px;
          padding:12px 22px;cursor:pointer;transition:.2s;
        }
        .cad-btn:hover:not(:disabled){background:#47512C;transform:translateY(-1px)}
        .cad-btn:disabled{opacity:.6;cursor:default}
        .cad-btn.feito{
          background:color-mix(in srgb,var(--areia) 46%,var(--paper));
          color:var(--ouro);border:1px solid color-mix(in srgb,var(--ambar) 50%,var(--line));
        }
        .cad-btn.feito:hover{background:color-mix(in srgb,var(--areia) 46%,var(--paper));transform:none}
        .cad-link{font-size:12.5px;font-weight:600;color:var(--ouro)}
        .cad-link:hover{text-decoration:underline}

        .proximo{display:block;text-align:center;background:var(--base);color:var(--areia);font-weight:700;font-size:15px;border-radius:16px;padding:16px;transition:.2s}
        .proximo:hover{transform:translateY(-2px);background:#2E2416}

        @media(max-width:620px){
          .candeia-box{flex-wrap:wrap;gap:14px}
          .candeia-lado{margin-left:0;width:100%;justify-content:space-between;padding-top:14px;border-top:1px solid rgba(232,217,174,.18)}
          .cl-item{text-align:left}
          .cad-btn{width:100%}
        }
        @media (prefers-reduced-motion: reduce){
          .cd{animation:none}
          .candeia-luz,.candeia-ico{animation:none}
          .lt-barra i,.lt-btn{transition:none}
          .perola{animation:none}
        }
      `}</style>
    </main>
  );
}
