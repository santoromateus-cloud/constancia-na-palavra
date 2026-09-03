import Link from "next/link";
import { getRaioX } from "@/lib/raiox";
import { getResumoCaderno } from "@/lib/caderno";
import { ativarPlano } from "../actions";
import {
  IconeBiblia,
  IconeCandeia,
  IconeEspiga,
  IconeGraca,
  IconeMeta,
} from "../Icones";

export const metadata = { title: "O seu raio-x — Constância na Palavra" };
export const dynamic = "force-dynamic";

/* ============================================================
   O RAIO-X DA CAMINHADA
   A tela que responde "onde eu parei?" antes de qualquer outra coisa.

   Ordem de leitura, de cima pra baixo, e ela é a tese da tela:
     1. ONDE VOCÊ PAROU — o caminho ativo, o dia exato, o botão de continuar.
        Vem primeiro porque é o motivo de ela ter aberto esta página.
     2. A SUA CONSTÂNCIA — os números e o calendário dos últimos três meses.
        É o "raio-x" propriamente dito: ela vê a própria história em pontos.
     3. O SEU CADERNO — o que ELA escreveu. Presença vira obra.
     4. OS SEUS CAMINHOS — todos os que ela já tocou, com o dia guardado e o
        botão de retomar. Nenhum caminho recomeça do zero, nunca.
     5. A SUA BÍBLIA — o marcador dos 1.189 capítulos, a meta e o ritmo.

   Regra de tom (a mesma do resto do produto): honra, crescimento e companhia,
   nunca culpa. Nada nesta tela diz "você falhou", nem quando o calendário está
   cheio de buraco. O vazio convida; o cheio celebra.
   ============================================================ */

const SEMANAS = 13; // 91 dias — três meses, que é o horizonte que ela enxerga
const MES_CURTO = ["jan", "fev", "mar", "abr", "mai", "jun", "jul", "ago", "set", "out", "nov", "dez"];

function iso(d: Date): string {
  return d.toISOString().slice(0, 10);
}

/** Data por extenso, curta: "14 de agosto de 2026". */
function porExtenso(data: string): string {
  const [a, m, d] = data.split("-");
  const meses = [
    "janeiro", "fevereiro", "março", "abril", "maio", "junho",
    "julho", "agosto", "setembro", "outubro", "novembro", "dezembro",
  ];
  return `${Number(d)} de ${meses[Number(m) - 1]} de ${a}`;
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

export default async function RaioXPage() {
  const [rx, caderno] = await Promise.all([getRaioX(), getResumoCaderno()]);
  if (!rx) return null;

  // ── o calendário: 13 colunas de 7 dias, terminando hoje ──
  const marcados = new Map(rx.dias.map((d) => [d.data, d.caminho]));
  const hoje = new Date();
  const fim = new Date(Date.UTC(hoje.getUTCFullYear(), hoje.getUTCMonth(), hoje.getUTCDate()));
  // recua até fechar SEMANAS × 7 dias, com o último dia sendo hoje
  const totalDias = SEMANAS * 7;
  const celulas = Array.from({ length: totalDias }, (_, i) => {
    const d = new Date(fim);
    d.setUTCDate(d.getUTCDate() - (totalDias - 1 - i));
    return d;
  });
  const colunas = Array.from({ length: SEMANAS }, (_, c) => celulas.slice(c * 7, c * 7 + 7));
  // rótulo de mês: aparece na coluna em que o mês vira
  const rotulos = colunas.map((col, i) => {
    const m = col[0].getUTCMonth();
    if (i === 0) return MES_CURTO[m];
    const anterior = colunas[i - 1][0].getUTCMonth();
    return m !== anterior ? MES_CURTO[m] : "";
  });
  const noPeriodo = celulas.filter((d) => marcados.has(iso(d))).length;

  const b = rx.biblia;
  const outros = rx.caminhos.filter((c) => !c.ativo);

  return (
    <main className="rx">
      {/* ── 1 · ONDE VOCÊ PAROU ── */}
      {rx.atual ? (
        <section className="rx-parou">
          <span className="rx-kick claro">Onde você parou</span>
          <h1>{rx.atual.titulo}</h1>
          <p className="rx-parou-ref">
            {rx.atual.referencia
              ? <>A sua próxima leitura é <b>{rx.atual.referencia}</b>.</>
              : <>A sua próxima leitura é o <b>dia {rx.atual.diaAtual}</b>.</>}
          </p>

          <div className="rx-parou-barra">
            <i style={{ width: `${Math.max(3, rx.atual.pct)}%` }} />
          </div>
          <div className="rx-parou-nums">
            <span>
              dia <b className="tnum">{rx.atual.diaAtual}</b> de {rx.atual.totalDias}
            </span>
            <span>{rx.atual.pct}% do caminho</span>
          </div>

          <Link href="/ler" className="rx-btn">Continuar de onde parei →</Link>
          <p className="rx-parou-nota">
            O seu lugar fica guardado. Você não precisa recomeçar nada, nem hoje nem depois de
            um mês parada.
          </p>
        </section>
      ) : (
        <section className="rx-parou vazio">
          <span className="rx-kick claro">Onde você parou</span>
          <h1>O seu primeiro caminho ainda não começou.</h1>
          <p className="rx-parou-ref">
            Escolha um e a leitura de amanhã já vai estar esperando por você aqui, com o dia
            guardado.
          </p>
          <Link href="/planos" className="rx-btn">Ver os caminhos →</Link>
        </section>
      )}

      {/* ── 2 · A SUA CONSTÂNCIA ── */}
      <section className="rx-card">
        <header className="rx-head">
          <span className="rx-kick"><IconeCandeia size={15} /> A sua constância</span>
          {rx.primeiraData && <span className="rx-desde">desde {porExtenso(rx.primeiraData)}</span>}
        </header>

        <div className="rx-nums">
          <div><b className="tnum">{rx.streak}</b><span>{rx.streak === 1 ? "dia seguido" : "dias seguidos"}</span></div>
          <div><b className="tnum">{rx.recorde}</b><span>seu recorde</span></div>
          <div><b className="tnum">{rx.espigas}</b><span>dias na Palavra</span></div>
        </div>

        <div className="rx-cal">
          <div className="rx-cal-meses" aria-hidden>
            {rotulos.map((r, i) => <span key={i}>{r}</span>)}
          </div>
          <div className="rx-cal-grade" role="img" aria-label={`Você leu em ${noPeriodo} dos últimos ${totalDias} dias.`}>
            {colunas.map((col, c) => (
              <div className="rx-cal-col" key={c}>
                {col.map((d) => {
                  const chave = iso(d);
                  const tem = marcados.has(chave);
                  const deCaminho = marcados.get(chave) === true;
                  const futuro = d > fim;
                  return (
                    <span
                      key={chave}
                      className={
                        "rx-dia" +
                        (tem ? (deCaminho ? " on" : " leve") : "") +
                        (futuro ? " fora" : "")
                      }
                      title={porExtenso(chave)}
                    />
                  );
                })}
              </div>
            ))}
          </div>
          <div className="rx-cal-pe">
            <span className="rx-leg"><i className="rx-dia on" /> dia de caminho</span>
            <span className="rx-leg"><i className="rx-dia leve" /> capítulo marcado na Bíblia</span>
            <span className="rx-cal-conta">
              {noPeriodo === 0
                ? "Os últimos três meses estão em branco. O próximo ponto pode ser hoje."
                : `${noPeriodo} ${noPeriodo === 1 ? "dia" : "dias"} nos últimos três meses`}
            </span>
          </div>
        </div>
      </section>

      {/* ── 3 · O SEU CADERNO ──
          O único bloco desta tela feito do que ELA escreveu. Vem logo depois
          da constância de propósito: os números de cima medem presença, este
          mede obra. Em três meses ela tem um livro tirado da própria leitura,
          e é isso que faz voltar. */}
      <section className="rx-card">
        <header className="rx-head">
          <span className="rx-kick"><IconeCaderno size={15} /> O seu caderno</span>
          <Link href="/caderno" className="rx-link">abrir o caderno →</Link>
        </header>

        {caderno.total === 0 ? (
          <p className="rx-vazio">
            Depois de cada leitura você pode guardar uma promessa, uma ordem, um princípio e
            um passo. O que você escrever fica aqui, só seu, e vira o seu próprio livro.
          </p>
        ) : (
          <>
            <div className="rx-nums">
              <div><b className="tnum">{caderno.promessas}</b><span>{caderno.promessas === 1 ? "promessa" : "promessas"}</span></div>
              <div><b className="tnum">{caderno.ordens}</b><span>{caderno.ordens === 1 ? "ordem" : "ordens"}</span></div>
              <div><b className="tnum">{caderno.total}</b><span>{caderno.total === 1 ? "passo escrito" : "passos escritos"}</span></div>
            </div>
            <p className="rx-cams-nota">
              {caderno.total === 1
                ? "Uma leitura já está escrita por você."
                : `${caderno.total} leituras já estão escritas por você`}
              {caderno.total > 1 && caderno.primeiraData ? `, desde ${porExtenso(caderno.primeiraData)}.` : "."}
            </p>
          </>
        )}
      </section>

      {/* ── 4 · OS SEUS CAMINHOS ── */}
      <section className="rx-card">
        <header className="rx-head">
          <span className="rx-kick"><IconeEspiga size={15} /> Os seus caminhos</span>
          <Link href="/planos" className="rx-link">ver todos →</Link>
        </header>

        {rx.caminhos.length === 0 ? (
          <p className="rx-vazio">
            Você ainda não começou nenhum caminho. Quando começar, cada um deles aparece aqui com
            o dia exato em que você parou.
          </p>
        ) : (
          <ul className="rx-cams">
            {rx.caminhos.map((c) => (
              <li key={c.id} className={c.concluido ? "feito" : c.ativo ? "on" : ""}>
                <div className="rx-cam-topo">
                  <h3>{c.titulo}</h3>
                  <span className="rx-cam-sel">
                    {c.concluido ? "concluído" : c.ativo ? "em andamento" : "guardado"}
                  </span>
                </div>
                <div className="rx-cam-barra"><i style={{ width: `${Math.max(2, c.pct)}%` }} /></div>
                <div className="rx-cam-pe">
                  <span>
                    <b className="tnum">{c.diasLidos}</b> de {c.totalDias} dias · {c.pct}%
                  </span>
                  {!c.concluido && !c.ativo && (
                    <form action={ativarPlano.bind(null, c.id)}>
                      <button type="submit" className="rx-retomar">
                        Retomar no dia {c.diaAtual} →
                      </button>
                    </form>
                  )}
                  {c.ativo && !c.concluido && <Link href="/ler" className="rx-retomar">Continuar →</Link>}
                </div>
              </li>
            ))}
          </ul>
        )}

        {outros.length > 0 && (
          <p className="rx-cams-nota">
            Trocar de caminho não apaga nada. Cada um guarda o dia em que você parou e espera
            você voltar.
          </p>
        )}
      </section>

      {/* ── 5 · A SUA BÍBLIA ── */}
      <section className="rx-card">
        <header className="rx-head">
          <span className="rx-kick"><IconeBiblia size={15} /> A sua Bíblia</span>
          <Link href="/biblia" className="rx-link">abrir o marcador →</Link>
        </header>

        <div className="rx-biblia">
          <div className="rx-anel">
            <svg viewBox="0 0 120 120" aria-hidden>
              <circle cx="60" cy="60" r="52" fill="none" stroke="var(--line)" strokeWidth="9" />
              <circle
                cx="60" cy="60" r="52" fill="none"
                stroke="var(--ouro)" strokeWidth="9" strokeLinecap="round"
                strokeDasharray={`${(b.pctTotal / 100) * 327} 327`}
                transform="rotate(-90 60 60)"
              />
            </svg>
            <div className="rx-anel-txt">
              <b className="tnum">{b.pctTotal}%</b>
              <span>da Bíblia</span>
            </div>
          </div>

          <div className="rx-biblia-nums">
            <div><span>Antigo Testamento</span><b className="tnum">{b.lidosAT}<small>/929</small></b><i><em style={{ width: `${b.pctAT}%` }} /></i></div>
            <div><span>Novo Testamento</span><b className="tnum">{b.lidosNT}<small>/260</small></b><i><em style={{ width: `${b.pctNT}%` }} /></i></div>
            <div><span>Livros inteiros</span><b className="tnum">{b.livrosCompletos}<small>/66</small></b><i><em style={{ width: `${Math.round((b.livrosCompletos / 66) * 100)}%` }} /></i></div>
          </div>
        </div>

        {b.emAndamento.length > 0 && (
          <div className="rx-andamento">
            <span className="rx-sub">Livros que você começou</span>
            <ul>
              {b.emAndamento.map((l) => (
                <li key={l.nome}>
                  <b>{l.nome}</b>
                  <span>{l.lidos} de {l.capitulos}</span>
                  <i><em style={{ width: `${l.pct}%` }} /></i>
                </li>
              ))}
            </ul>
          </div>
        )}

        <div className="rx-meta">
          <span className="rx-kick"><IconeMeta size={14} /> A sua meta</span>
          {b.meta ? (
            b.diasRestantes !== null && b.diasRestantes > 0 ? (
              <p>
                Faltam <b>{b.diasRestantes} dias</b> para {porExtenso(b.meta.data_fim)}. No ritmo de{" "}
                <b>{b.ritmoNecessario} capítulos por dia</b>, você chega.
              </p>
            ) : (
              <p>
                A data que você marcou já passou. Faltam <b>{b.ritmoNecessario} capítulos</b> — dá
                pra escolher uma data nova no marcador e seguir de onde você está.
              </p>
            )
          ) : (
            <p>
              Você ainda não escolheu uma data de chegada. No marcador dá pra escolher uma, e o
              ritmo diário sai calculado sozinho.
            </p>
          )}
        </div>
      </section>

      <p className="rx-fecho">
        <IconeGraca size={16} /> Nada aqui se perde. O que você leu está contado, e o lugar onde
        você parou continua seu.
      </p>

      <style>{`
        .rx{max-width:760px;margin:0 auto;padding:clamp(18px,3.4vw,30px) clamp(14px,4vw,20px) 90px;display:flex;flex-direction:column;gap:16px}

        .rx-kick{display:inline-flex;align-items:center;gap:7px;font-size:11.5px;letter-spacing:1.5px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .rx-kick.claro{color:var(--areia)}
        .rx-sub{font-size:11.5px;letter-spacing:1.3px;text-transform:uppercase;font-weight:700;color:var(--muted)}
        .rx-link{font-size:12.5px;font-weight:600;color:var(--ouro)}
        .rx-link:hover{text-decoration:underline}

        /* ---------- 1 · onde você parou ---------- */
        .rx-parou{
          position:relative;overflow:hidden;
          background:linear-gradient(150deg,#3B2F1E 0%,#2C2215 100%);
          color:var(--creme);border-radius:26px;
          padding:clamp(22px,3.6vw,32px);
          box-shadow:0 20px 50px -24px rgba(44,34,21,.7);
        }
        .rx-parou h1{font-family:var(--display);font-weight:400;font-size:clamp(26px,4.2vw,38px);line-height:1.08;margin:10px 0 0;color:#FCF8EF}
        .rx-parou-ref{font-family:var(--serif);font-size:15.5px;line-height:1.6;color:#D9CBAB;margin:12px 0 0}
        .rx-parou-ref b{color:var(--areia);font-weight:600}
        .rx-parou-barra{height:7px;border-radius:99px;background:rgba(232,217,174,.18);overflow:hidden;margin:20px 0 10px}
        .rx-parou-barra i{display:block;height:100%;border-radius:99px;background:linear-gradient(90deg,#C9A85C,#8FA05A)}
        .rx-parou-nums{display:flex;justify-content:space-between;gap:12px;font-size:12.5px;color:#B9A87E}
        .rx-parou-nums b{color:var(--areia);font-size:15px}
        .rx-btn{
          display:block;text-align:center;margin-top:22px;
          background:linear-gradient(140deg,#63703F,#4A5430);color:#FCF8EF;
          font-weight:700;font-size:15.5px;border-radius:16px;padding:16px;
          box-shadow:0 12px 28px -12px rgba(0,0,0,.6);transition:transform .2s;
        }
        .rx-btn:hover{transform:translateY(-2px)}
        .rx-parou-nota{font-size:12.5px;line-height:1.55;color:rgba(232,217,174,.62);margin-top:14px;text-align:center}
        .rx-parou.vazio .rx-parou-ref{margin-bottom:4px}

        /* ---------- cartão padrão ---------- */
        .rx-card{background:var(--paper);border:1px solid var(--line);border-radius:24px;padding:clamp(20px,3.4vw,28px);box-shadow:var(--shadow-sm)}
        .rx-head{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;margin-bottom:18px}
        .rx-desde{font-size:12px;color:var(--muted)}
        .rx-vazio{font-family:var(--serif);font-size:14.5px;line-height:1.6;color:var(--muted)}

        /* ---------- 2 · constância ---------- */
        .rx-nums{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin-bottom:22px}
        .rx-nums div{text-align:center;background:color-mix(in srgb,var(--areia) 20%,var(--paper));border-radius:16px;padding:14px 6px}
        .rx-nums b{display:block;font-family:var(--display);font-size:clamp(22px,3.6vw,28px);color:var(--base);line-height:1}
        .rx-nums span{display:block;font-size:10.5px;color:var(--muted);margin-top:5px;line-height:1.25}

        .rx-cal-meses{display:grid;grid-template-columns:repeat(${SEMANAS},1fr);gap:3px;margin-bottom:5px;font-size:9.5px;color:var(--muted);letter-spacing:.4px}
        .rx-cal-grade{display:grid;grid-template-columns:repeat(${SEMANAS},1fr);gap:3px}
        .rx-cal-col{display:flex;flex-direction:column;gap:3px}
        .rx-dia{display:block;aspect-ratio:1;border-radius:3px;background:color-mix(in srgb,var(--areia) 30%,var(--paper));border:1px solid transparent}
        .rx-dia.leve{background:color-mix(in srgb,var(--ambar) 34%,var(--paper));border-color:color-mix(in srgb,var(--ambar) 46%,transparent)}
        .rx-dia.on{background:linear-gradient(150deg,#C9A85C,#8F6D1E)}
        .rx-dia.fora{opacity:0}
        .rx-cal-pe{display:flex;align-items:center;gap:14px;flex-wrap:wrap;margin-top:12px;font-size:11.5px;color:var(--muted)}
        .rx-leg{display:inline-flex;align-items:center;gap:6px}
        .rx-leg i{width:11px;height:11px;flex:none;aspect-ratio:auto}
        .rx-cal-conta{margin-left:auto}

        /* ---------- 4 · caminhos ---------- */
        .rx-cams{display:flex;flex-direction:column;gap:12px}
        .rx-cams li{border:1px solid var(--line);border-radius:18px;padding:16px 18px;background:var(--paper)}
        .rx-cams li.on{border-color:color-mix(in srgb,var(--ambar) 55%,var(--line));background:color-mix(in srgb,var(--areia) 16%,var(--paper))}
        .rx-cams li.feito{background:color-mix(in srgb,#6A7A42 8%,var(--paper))}
        .rx-cam-topo{display:flex;align-items:baseline;justify-content:space-between;gap:12px}
        .rx-cam-topo h3{font-family:var(--display);font-weight:400;font-size:17.5px;color:var(--ink);line-height:1.2}
        .rx-cam-sel{flex:none;font-size:10px;letter-spacing:1px;text-transform:uppercase;font-weight:700;color:var(--muted)}
        .rx-cams li.on .rx-cam-sel{color:var(--ouro)}
        .rx-cams li.feito .rx-cam-sel{color:#5E6B37}
        .rx-cam-barra{height:5px;border-radius:99px;background:var(--line);overflow:hidden;margin:12px 0 10px}
        .rx-cam-barra i{display:block;height:100%;border-radius:99px;background:linear-gradient(90deg,#C9A85C,#6A7A42)}
        .rx-cam-pe{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap;font-size:12.5px;color:var(--muted)}
        .rx-cam-pe b{color:var(--base);font-size:14px}
        .rx-retomar{
          display:inline-block;background:none;border:0;padding:0;cursor:pointer;
          font-family:var(--sans);font-size:12.5px;font-weight:700;color:var(--ouro);
        }
        .rx-retomar:hover{text-decoration:underline}
        .rx-cams-nota{font-family:var(--serif);font-size:13.5px;line-height:1.6;color:var(--muted);margin-top:14px}

        /* ---------- 5 · bíblia ---------- */
        .rx-biblia{display:flex;align-items:center;gap:clamp(16px,3vw,28px)}
        .rx-anel{position:relative;flex:none;width:clamp(104px,16vw,124px)}
        .rx-anel svg{display:block;width:100%;height:auto}
        .rx-anel-txt{position:absolute;inset:0;display:flex;flex-direction:column;align-items:center;justify-content:center}
        .rx-anel-txt b{font-family:var(--display);font-size:26px;color:var(--base);line-height:1}
        .rx-anel-txt span{font-size:10px;color:var(--muted);margin-top:2px}
        .rx-biblia-nums{flex:1;display:flex;flex-direction:column;gap:13px;min-width:0}
        .rx-biblia-nums div{display:flex;flex-direction:column;gap:3px}
        .rx-biblia-nums span{font-size:11px;letter-spacing:.8px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
        .rx-biblia-nums b{display:block;font-family:var(--display);font-size:22px;color:var(--base);line-height:1.1;margin-top:3px}
        .rx-biblia-nums small{font-size:12px;color:var(--muted);font-family:var(--sans)}
        .rx-biblia-nums i{display:block;height:4px;border-radius:99px;background:var(--line);overflow:hidden;margin-top:3px}
        .rx-biblia-nums em{display:block;height:100%;border-radius:99px;background:linear-gradient(90deg,#C9A85C,#6A7A42)}

        .rx-andamento{margin-top:22px;padding-top:18px;border-top:1px solid var(--line)}
        .rx-andamento ul{display:flex;flex-direction:column;gap:9px;margin-top:11px}
        .rx-andamento li{display:grid;grid-template-columns:1fr auto;gap:2px 12px;align-items:baseline}
        .rx-andamento b{font-size:14.5px;color:var(--ink);font-weight:600}
        .rx-andamento li>span{font-size:12px;color:var(--muted)}
        .rx-andamento i{grid-column:1/-1;display:block;height:4px;border-radius:99px;background:var(--line);overflow:hidden;margin-top:3px}
        .rx-andamento em{display:block;height:100%;border-radius:99px;background:linear-gradient(90deg,#C9A85C,#6A7A42)}

        .rx-meta{margin-top:22px;padding-top:18px;border-top:1px solid var(--line)}
        .rx-meta p{font-family:var(--serif);font-size:14.5px;line-height:1.65;color:#5D4E39;margin-top:9px}
        .rx-meta b{color:var(--base);font-weight:600}

        .rx-fecho{display:flex;align-items:center;justify-content:center;gap:9px;text-align:center;font-family:var(--serif);font-style:italic;font-size:13.5px;color:var(--muted);padding:4px 10px}

        @media(max-width:560px){
          .rx-nums{grid-template-columns:repeat(2,1fr)}
          .rx-biblia{flex-direction:column;align-items:stretch}
          .rx-anel{align-self:center}
          .rx-cal-conta{margin-left:0;width:100%}
        }
      `}</style>
    </main>
  );
}
