import { IconeCandeia, IconeEspiga } from "../Icones";

/* ============================================================
   A TRILHA — mecânica 7 do doc de gamificação
   Um nó por dia, serpenteando: os dias lidos acesos com espiga, o de
   hoje com a candeia pulsando, os próximos apagados. É o mapa do
   Duolingo tropicalizado — progresso ESPACIAL, não barra de carga.
   A leitora vê o quanto andou, não uma porcentagem abstrata.

   Componente puro (sem estado, sem "use client"): serve tanto na
   página de servidor quanto na tela de QA.
   ============================================================ */

// Serpentina: o nó anda pra direita e volta, em ondas de 5.
const ONDA = [12, 30, 50, 70, 88];
const ALT_LINHA = 88;

export function posicao(i: number) {
  const linha = Math.floor(i / 5);
  const col = i % 5;
  return { x: linha % 2 === 0 ? ONDA[col] : ONDA[4 - col], linha };
}

function pontoDoNo(i: number): [number, number] {
  const { x, linha } = posicao(i);
  return [x, 30 + linha * ALT_LINHA];
}

/**
 * Fio SUAVE ligando os nós.
 *
 * A v1 ligava ponto a ponto com `L` e o resultado parecia grade de planilha:
 * reta, reta, queda vertical seca. Caminho não anda em ângulo reto. Aqui cada
 * nó vira ponto de controle de uma quadrática e o fio passa pelos MEIOS dos
 * segmentos — a curva flui e o traço vira trilha de verdade.
 */
function caminhoSuave(pts: [number, number][]): string {
  if (pts.length === 0) return "";
  if (pts.length === 1) return `M${pts[0][0]} ${pts[0][1]}`;
  const meio = (a: [number, number], b: [number, number]): [number, number] => [
    (a[0] + b[0]) / 2,
    (a[1] + b[1]) / 2,
  ];
  let d = `M${pts[0][0]} ${pts[0][1]}`;
  for (let i = 1; i < pts.length - 1; i++) {
    const m = meio(pts[i], pts[i + 1]);
    d += ` Q${pts[i][0]} ${pts[i][1]} ${m[0]} ${m[1]}`;
  }
  const ultimo = pts[pts.length - 1];
  d += ` L${ultimo[0]} ${ultimo[1]}`;
  return d;
}

export default function Trilha({ totalDias, lidos }: { totalDias: number; lidos: number }) {
  const nos = Array.from({ length: totalDias }, (_, i) => i + 1);
  const linhas = Math.ceil(totalDias / 5);
  const altura = linhas * ALT_LINHA + 40;

  return (
    <div className="trilha" style={{ height: altura }}>
      {/* o fio pontilhado que liga os nós, desenhado atrás */}
      <svg className="tr-fio" viewBox={`0 0 100 ${altura}`} preserveAspectRatio="none" aria-hidden>
        <path
          d={caminhoSuave(nos.map((_, i) => pontoDoNo(i)))}
          fill="none"
          stroke="var(--line)"
          strokeWidth="1.4"
          strokeLinecap="round"
          strokeDasharray="3 5"
          vectorEffect="non-scaling-stroke"
        />
      </svg>

      {nos.map((dia, i) => {
        const { x, linha } = posicao(i);
        const feito = dia <= lidos;
        const hoje = dia === lidos + 1;
        const marco = dia % 7 === 0; // marco semanal: nunca a mais de 3 dias
        return (
          <span
            key={dia}
            className={"no" + (feito ? " feito" : "") + (hoje ? " hoje" : "") + (marco ? " marco" : "")}
            style={{ left: `${x}%`, top: 30 + linha * ALT_LINHA }}
            title={`Dia ${dia}`}
          >
            {feito ? (
              <IconeEspiga size={marco ? 22 : 18} strokeWidth={1.8} />
            ) : hoje ? (
              <IconeCandeia size={22} strokeWidth={1.8} />
            ) : (
              <i className="tnum">{dia}</i>
            )}
          </span>
        );
      })}
    </div>
  );
}
