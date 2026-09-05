import { CAIXA, LAGOS, RIOS, TERRA } from "@/lib/litoral";
import { comprimentoKm, mapaDoLugar, type MapaDia, type Ponto } from "@/lib/lugares";

/* ─────────────────────────────────────────────────────────────────────────────
   O MAPA do caminho "Onde tudo aconteceu" — feedback do Mateus (03 e 04/09/2026):
   "a aba não ter um mapa visual, daí perde a graça" / "precisa ser visual".

   Server component, sem JavaScript no cliente: SVG inline na paleta Luz e Lavra
   (pergaminho, ouro, oliva), com litoral REAL simplificado (Natural Earth, domínio
   público — Mediterrâneo, mar Vermelho, Nilo, Eufrates, Tigre, Jordão, Galileia,
   mar Morto) e os lugares em latitude e longitude de verdade. Nos dias de trajeto,
   a rota na ordem da história com a distância calculada.

   Por que não um mapa de serviço (Leaflet/Mapbox): mostraria rodovia, fronteira e
   cidade de 2026 sobre texto de 1800 a.C., brigaria com a identidade e pediria
   chave. Assumidamente ilustrado é mais verdadeiro.

   Desenho: as formas (terra, água, rotas) vivem no SVG e escalam com o card; os
   nomes e os marcadores são HTML posicionado em porcentagem, pra letra ter sempre o
   mesmo tamanho no celular e no computador. Sem coordenada pro lugar → null, e o
   card de texto segue igual (fallback silencioso).
   ───────────────────────────────────────────────────────────────────────────── */

const W = 600;
const H_PADRAO = 360;
const KM_LAT = 110.57; // km por grau de latitude
const KM_LON = 111.32; // km por grau de longitude no equador

type Enquadramento = { lonC: number; latC: number; cosc: number; kmPorUnidade: number; H: number };

function enquadrar(m: MapaDia): Enquadramento {
  const H = Math.round(W * (m.proporcao ?? H_PADRAO / W));
  const todos = [
    ...m.pontos,
    ...(m.rota ?? []),
    ...(m.volta ?? []),
    ...(m.contexto ?? []).flatMap((t) => t.pontos),
  ];
  const lats = todos.map((p) => p.lat);
  const lons = todos.map((p) => p.lon);
  const latC = (Math.min(...lats) + Math.max(...lats)) / 2;
  const lonC = (Math.min(...lons) + Math.max(...lons)) / 2;
  const cosc = Math.cos((latC * Math.PI) / 180);
  const spanX = (Math.max(...lons) - Math.min(...lons)) * KM_LON * cosc;
  const spanY = (Math.max(...lats) - Math.min(...lats)) * KM_LAT;
  const raio = m.raioKm ?? 60;
  // ~28% de ar de cada lado (os nomes saem dos pontos), e nunca menos que o raio pedido
  const meioX = Math.max(spanX * 0.72, raio);
  const meioY = Math.max(spanY * 0.72, raio * (H / W));
  const kmPorUnidade = Math.max((2 * meioX) / W, (2 * meioY) / H);
  return { lonC, latC, cosc, kmPorUnidade, H };
}

function projetor(e: Enquadramento) {
  return (lon: number, lat: number): [number, number] => [
    W / 2 + ((lon - e.lonC) * KM_LON * e.cosc) / e.kmPorUnidade,
    e.H / 2 - ((lat - e.latC) * KM_LAT) / e.kmPorUnidade,
  ];
}

/** Retângulo visível em lon/lat, com margem, pra recortar a geografia. */
function janela(e: Enquadramento, margem = 1.15) {
  const meioLon = ((W / 2) * e.kmPorUnidade * margem) / (KM_LON * e.cosc);
  const meioLat = ((e.H / 2) * e.kmPorUnidade * margem) / KM_LAT;
  return { x0: e.lonC - meioLon, x1: e.lonC + meioLon, y0: e.latC - meioLat, y1: e.latC + meioLat };
}

/** Sutherland–Hodgman: recorta um anel [lon,lat] num retângulo. */
function recortar(anel: number[][], r: { x0: number; x1: number; y0: number; y1: number }): number[][] {
  const passo = (
    pts: number[][],
    dentro: (p: number[]) => boolean,
    cruza: (a: number[], b: number[]) => number[],
  ) => {
    const out: number[][] = [];
    if (!pts.length) return out;
    let prev = pts[pts.length - 1];
    for (const cur of pts) {
      if (dentro(cur)) {
        if (!dentro(prev)) out.push(cruza(prev, cur));
        out.push(cur);
      } else if (dentro(prev)) out.push(cruza(prev, cur));
      prev = cur;
    }
    return out;
  };
  const emX = (x: number) => (a: number[], b: number[]) => {
    const t = (x - a[0]) / (b[0] - a[0]);
    return [x, a[1] + t * (b[1] - a[1])];
  };
  const emY = (y: number) => (a: number[], b: number[]) => {
    const t = (y - a[1]) / (b[1] - a[1]);
    return [a[0] + t * (b[0] - a[0]), y];
  };
  let p = anel;
  p = passo(p, (q) => q[0] >= r.x0, emX(r.x0));
  p = passo(p, (q) => q[0] <= r.x1, emX(r.x1));
  p = passo(p, (q) => q[1] >= r.y0, emY(r.y0));
  p = passo(p, (q) => q[1] <= r.y1, emY(r.y1));
  return p;
}

function caixa(anel: number[][]) {
  let x0 = Infinity, x1 = -Infinity, y0 = Infinity, y1 = -Infinity;
  for (const [x, y] of anel) {
    if (x < x0) x0 = x;
    if (x > x1) x1 = x;
    if (y < y0) y0 = y;
    if (y > y1) y1 = y;
  }
  return { x0, x1, y0, y1 };
}

function cruzam(a: { x0: number; x1: number; y0: number; y1: number }, b: typeof a) {
  return a.x0 <= b.x1 && a.x1 >= b.x0 && a.y0 <= b.y1 && a.y1 >= b.y0;
}

/** Só os trechos de costa de verdade: um segmento que corre sobre a borda dos dados
 *  (CAIXA) ou sobre a borda da janela é artificial e não ganha traço. */
function costaDe(
  aneis: number[][][],
  proj: (lon: number, lat: number) => [number, number],
  jan: { x0: number; x1: number; y0: number; y1: number },
) {
  const eps = 1e-6;
  const naBorda = (a: number[], b: number[]) => {
    const linhas = [CAIXA.x0, CAIXA.x1, jan.x0, jan.x1];
    const colunas = [CAIXA.y0, CAIXA.y1, jan.y0, jan.y1];
    return (
      linhas.some((x) => Math.abs(a[0] - x) < eps && Math.abs(b[0] - x) < eps) ||
      colunas.some((y) => Math.abs(a[1] - y) < eps && Math.abs(b[1] - y) < eps)
    );
  };
  const partes: string[] = [];
  for (const anel of aneis) {
    let aberto = false;
    for (let i = 0; i < anel.length; i++) {
      const a = anel[i];
      const b = anel[(i + 1) % anel.length];
      if (naBorda(a, b)) {
        aberto = false;
        continue;
      }
      const [xa, ya] = proj(a[0], a[1]);
      const [xb, yb] = proj(b[0], b[1]);
      if (!aberto) {
        partes.push(`M${xa.toFixed(1)} ${ya.toFixed(1)}`);
        aberto = true;
      }
      partes.push(`L${xb.toFixed(1)} ${yb.toFixed(1)}`);
    }
  }
  return partes.join("");
}

function caminhoDe(aneis: number[][][], proj: (lon: number, lat: number) => [number, number], fechar: boolean) {
  const partes: string[] = [];
  for (const anel of aneis) {
    if (anel.length < 2) continue;
    const d = anel.map(([lon, lat], i) => {
      const [x, y] = proj(lon, lat);
      return `${i === 0 ? "M" : "L"}${x.toFixed(1)} ${y.toFixed(1)}`;
    });
    partes.push(d.join("") + (fechar ? "Z" : ""));
  }
  return partes.join("");
}

/** Ponto a meio caminho de uma polilinha (pela distância real), pro rótulo. */
function meio(pontos: Ponto[]): { lat: number; lon: number } {
  const total = comprimentoKm(pontos);
  let acumulado = 0;
  for (let i = 1; i < pontos.length; i++) {
    const perna = comprimentoKm([pontos[i - 1], pontos[i]]);
    if (acumulado + perna >= total / 2) {
      const t = perna === 0 ? 0 : (total / 2 - acumulado) / perna;
      return {
        lat: pontos[i - 1].lat + t * (pontos[i].lat - pontos[i - 1].lat),
        lon: pontos[i - 1].lon + t * (pontos[i].lon - pontos[i - 1].lon),
      };
    }
    acumulado += perna;
  }
  return pontos[pontos.length - 1];
}

function kmBonito(km: number): string {
  const arred = km >= 1000 ? Math.round(km / 50) * 50 : km >= 100 ? Math.round(km / 5) * 5 : Math.round(km);
  return `≈ ${arred.toLocaleString("pt-BR")} km`;
}

function escalaBonita(kmPorUnidade: number): { km: number; unidades: number } {
  const maxUnidades = W * 0.22;
  const candidatos = [2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000];
  let escolhido = candidatos[0];
  for (const c of candidatos) if (c / kmPorUnidade <= maxUnidades) escolhido = c;
  return { km: escolhido, unidades: escolhido / kmPorUnidade };
}

export default function MapaLugar({ lugar }: { lugar: string | null | undefined }) {
  const m = mapaDoLugar(lugar);
  if (!m) return null;

  const enq = enquadrar(m);
  const proj = projetor(enq);
  const jan = janela(enq);

  // geografia: só o que cruza a janela, recortado — o DOM fica pequeno
  const terra = TERRA.filter((a) => cruzam(caixa(a), jan)).map((a) => recortar(a, jan)).filter((a) => a.length >= 3);
  const lagos = LAGOS.filter((a) => cruzam(caixa(a), jan)).map((a) => recortar(a, jan)).filter((a) => a.length >= 3);
  const rios = RIOS.filter((r) => cruzam(caixa(r.p), jan)).map((r) => r.p);

  const H = enq.H;
  const dTerra = caminhoDe(terra, proj, true);
  const dCosta = costaDe(terra, proj, jan);
  const dLagos = caminhoDe(lagos, proj, true);
  const dRios = caminhoDe(rios, proj, false);

  const linha = (pts: Ponto[]) =>
    pts
      .map((p, i) => {
        const [x, y] = proj(p.lon, p.lat);
        return `${i === 0 ? "M" : "L"}${x.toFixed(1)} ${y.toFixed(1)}`;
      })
      .join("");

  const pct = (lon: number, lat: number) => {
    const [x, y] = proj(lon, lat);
    return { left: `${((x / W) * 100).toFixed(2)}%`, top: `${((y / H) * 100).toFixed(2)}%` };
  };

  const kmRota = m.rota ? comprimentoKm(m.rota) : 0;
  const kmVolta = m.volta ? comprimentoKm(m.volta) : 0;
  const rotuloDistancia = m.rota
    ? m.volta
      ? `${kmBonito(kmRota + kmVolta)} ida e volta`
      : kmBonito(kmRota)
    : null;
  const pontoDistancia = m.rota ? (m.distanciaEm ?? meio(m.rota)) : null;
  const escala = escalaBonita(enq.kmPorUnidade);

  return (
    <figure className="mp" aria-label={`Mapa: ${lugar}`}>
      <div className="mp-quadro" style={{ aspectRatio: `${W} / ${H}` }}>
        <svg viewBox={`0 0 ${W} ${H}`} preserveAspectRatio="none" className="mp-svg" aria-hidden>
          <defs>
            <marker id="mpSeta" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
              <path d="M1 1 L9 5 L1 9 Z" fill="#8F6D1E" />
            </marker>
          </defs>
          <rect x="0" y="0" width={W} height={H} className="mp-mar" />
          {dTerra && <path d={dTerra} className="mp-terra" fillRule="evenodd" />}
          {dCosta && <path d={dCosta} className="mp-costa" />}
          {dLagos && <path d={dLagos} className="mp-lago" />}
          {dRios && <path d={dRios} className="mp-rio" />}

          {(m.contexto ?? []).map((t, i) => (
            <path key={"c" + i} d={linha(t.pontos)} className="mp-contexto" />
          ))}
          {m.volta && <path d={linha(m.volta)} className="mp-volta" pathLength={1} />}
          {m.rota && <path d={linha(m.rota)} className="mp-rota" pathLength={1} markerEnd="url(#mpSeta)" />}

          {/* escala, canto inferior direito */}
          <g className="mp-escala" transform={`translate(${W - 18 - escala.unidades} ${H - 18})`}>
            <path d={`M0 -5 L0 0 L${escala.unidades.toFixed(1)} 0 L${escala.unidades.toFixed(1)} -5`} />
          </g>
          {/* norte, canto superior direito */}
          <g className="mp-norte" transform={`translate(${W - 22} 30)`}>
            <path d="M0 -12 L5 4 L0 0 L-5 4 Z" />
          </g>
        </svg>

        <div className="mp-camada">
          <span className="mp-escala-txt" style={{ right: 12, bottom: 20 }}>
            {escala.km} km
          </span>
          <span className="mp-norte-txt" style={{ right: 12, top: 36 }}>
            N
          </span>

          {(m.contexto ?? [])
            .filter((t) => t.nome)
            .map((t, i) => {
              const mp = t.rotuloEm ?? meio(t.pontos);
              return (
                <span key={"cn" + i} className="mp-nota-traco" style={pct(mp.lon, mp.lat)}>
                  {t.nome}
                </span>
              );
            })}

          {rotuloDistancia && pontoDistancia && (
            <span className="mp-dist" style={pct(pontoDistancia.lon, pontoDistancia.lat)}>
              {rotuloDistancia}
            </span>
          )}

          {m.pontos.map((p, i) => {
            const tipo = p.tipo ?? "apoio";
            const lado = p.lado ?? "dir";
            return (
              <span
                key={p.nome + i}
                className={`mp-pt ${tipo} ${lado}`}
                style={{ ...pct(p.lon, p.lat), animationDelay: `${0.25 + i * 0.12}s` }}
              >
                {tipo !== "rotulo" && <i className="mp-marca" aria-hidden />}
                <b className="mp-nome">{p.nome}</b>
              </span>
            );
          })}
        </div>
      </div>
      {m.nota && <figcaption className="mp-nota">{m.nota}</figcaption>}

      <style>{`
        .mp{margin:14px 0 0}
        .mp-quadro{position:relative;width:100%;border-radius:16px;overflow:hidden;border:1px solid color-mix(in srgb,var(--ambar) 55%,var(--line));box-shadow:inset 0 0 44px rgba(58,46,29,.10),var(--shadow-sm);background:#DDDECA}
        .mp-svg{position:absolute;inset:0;width:100%;height:100%;display:block}
        .mp-mar{fill:#DDDECA}
        .mp-terra{fill:#F5EDDA;stroke:none}
        .mp-costa{fill:none;stroke:#B39B62;stroke-width:1;vector-effect:non-scaling-stroke;stroke-linejoin:round;stroke-linecap:round}
        .mp-lago{fill:#D6D9C4;stroke:#A9A377;stroke-width:.9;vector-effect:non-scaling-stroke}
        .mp-rio{fill:none;stroke:#A2AE8E;stroke-width:1.2;vector-effect:non-scaling-stroke;stroke-linecap:round;stroke-linejoin:round}
        .mp-contexto{fill:none;stroke:#C9A85C;stroke-width:1.4;stroke-dasharray:3 5;vector-effect:non-scaling-stroke;stroke-linecap:round;stroke-linejoin:round}
        .mp-rota{fill:none;stroke:#8F6D1E;stroke-width:2.4;vector-effect:non-scaling-stroke;stroke-linecap:round;stroke-linejoin:round;stroke-dasharray:1;stroke-dashoffset:1;animation:mpTraca 1.7s cubic-bezier(.4,0,.2,1) .35s forwards}
        .mp-volta{fill:none;stroke:#6A7A42;stroke-width:1.8;stroke-dasharray:1;stroke-dashoffset:1;vector-effect:non-scaling-stroke;stroke-linecap:round;stroke-linejoin:round;animation:mpTraca 1.4s cubic-bezier(.4,0,.2,1) 2.05s forwards}
        @keyframes mpTraca{to{stroke-dashoffset:0}}
        .mp-escala path{fill:none;stroke:#5D4E39;stroke-width:1.2;vector-effect:non-scaling-stroke}
        .mp-norte path{fill:#8F6D1E}

        .mp-camada{position:absolute;inset:0;pointer-events:none;font-family:var(--sans)}
        .mp-camada > span{position:absolute}
        .mp-escala-txt,.mp-norte-txt{font-size:10px;font-weight:700;color:#5D4E39;letter-spacing:.3px}
        .mp-norte-txt{font-family:var(--serif);font-size:11px;color:#8F6D1E}

        .mp-pt{transform:translate(-50%,-50%);display:flex;align-items:center;gap:5px;animation:mpPop .55s cubic-bezier(.34,1.56,.64,1) backwards}
        .mp-pt.esq{flex-direction:row-reverse}
        .mp-pt.cima,.mp-pt.baixo{flex-direction:column;gap:3px}
        .mp-pt.cima{flex-direction:column-reverse}
        /* o marcador fica exatamente no ponto; o nome sai pro lado escolhido */
        .mp-pt.dir{transform:translate(0,-50%);margin-left:-6px}
        .mp-pt.esq{transform:translate(-100%,-50%);margin-left:6px}
        .mp-pt.baixo{transform:translate(-50%,0);margin-top:-6px}
        .mp-pt.cima{transform:translate(-50%,-100%);margin-top:6px}
        .mp-pt.rotulo{transform:translate(-50%,-50%);margin:0}
        .mp-marca{flex:none;width:12px;height:12px;border-radius:50%;background:radial-gradient(circle at 35% 30%,#E0C88A,#8F6D1E 70%);box-shadow:0 0 0 2px #FCF8EF,0 0 0 3px rgba(143,109,30,.45);position:relative}
        .mp-pt.principal .mp-marca::after{content:"";position:absolute;inset:-6px;border-radius:50%;border:1.5px solid rgba(143,109,30,.55);animation:mpPulso 2.2s ease-out 1s 3}
        @keyframes mpPulso{0%{transform:scale(.6);opacity:1}100%{transform:scale(1.6);opacity:0}}
        .mp-pt.apoio .mp-marca{width:8px;height:8px;background:#B9A87E;box-shadow:0 0 0 1.5px #FCF8EF}
        .mp-nome{font-weight:700;font-size:11.5px;line-height:1.1;color:var(--ink);white-space:nowrap;text-shadow:0 0 3px #FCF8EF,0 0 5px #FCF8EF,0 1px 0 #FCF8EF,0 -1px 0 #FCF8EF,1px 0 0 #FCF8EF,-1px 0 0 #FCF8EF}
        .mp-pt.apoio .mp-nome{font-size:10.5px;font-weight:600;color:#5D4E39}
        .mp-pt.rotulo .mp-nome{font-family:var(--serif);font-style:italic;font-weight:500;font-size:11px;letter-spacing:.6px;color:#7A6B4F}
        @keyframes mpPop{from{opacity:0;scale:.6}to{opacity:1;scale:1}}

        .mp-dist{transform:translate(-50%,-50%);background:var(--base);color:var(--areia);font-size:10.5px;font-weight:700;letter-spacing:.3px;padding:4px 9px;border-radius:99px;white-space:nowrap;box-shadow:0 6px 14px -6px rgba(44,34,21,.6);animation:mpPop .5s cubic-bezier(.34,1.56,.64,1) 1.6s backwards}
        .mp-nota-traco{transform:translate(-50%,-50%);font-family:var(--serif);font-style:italic;font-size:10.5px;color:#8F6D1E;white-space:nowrap;background:rgba(252,248,239,.82);padding:1px 6px;border-radius:6px}
        .mp-nota{font-family:var(--serif);font-style:italic;font-size:13px;line-height:1.5;color:#6C5C45;margin:9px 2px 0}

        @media(max-width:560px){
          /* no celular a régua sai: o espaço é dos nomes */
          .mp-escala,.mp-escala-txt{display:none}
          .mp-nome{font-size:10.5px}
          .mp-pt.apoio .mp-nome{font-size:9.5px}
          .mp-pt.rotulo .mp-nome{font-size:10px}
          .mp-dist{font-size:9.5px;padding:3px 7px}
          .mp-nota-traco{font-size:9.5px}
        }
        @media (prefers-reduced-motion: reduce){
          .mp-rota,.mp-volta{animation:none;stroke-dashoffset:0}
          .mp-pt,.mp-dist{animation:none}
          .mp-pt.principal .mp-marca::after{animation:none;display:none}
        }
      `}</style>
    </figure>
  );
}
