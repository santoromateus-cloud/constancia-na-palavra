import { IconeCandeia, IconeEspiga } from "../Icones";

/* ============================================================
   A TRILHA — mecânica 7 do doc de gamificação
   Um nó por dia, serpenteando de cima pra baixo: os dias lidos acesos com
   espiga, o de hoje com a candeia pulsando, os próximos apagados. É o mapa
   do Duolingo tropicalizado — progresso ESPACIAL, não barra de carga. A
   leitora vê o quanto andou, não uma porcentagem abstrata.

   v3 (01/09, noite) — a v2 posicionava os nós em ONDA = [12,30,50,70,88]
   com uma linha nova a cada 5. Resultado visto em produção: cinco nós no
   MESMO y, ligados por um traço reto. Continuava lendo como grade de
   planilha, só que com curva na virada. Caminho não tem fileira.
   Agora a posição é uma senoide contínua: cada nó desce um passo fixo e
   oscila no eixo x. Não existe mais "linha" — existe curva. E a trilha
   ganhou largura máxima (uma coluna estreita, como qualquer trilha de
   verdade) em vez de esticar até a borda da tela.

   O fio também virou duas camadas: o trecho já caminhado sai sólido e
   dourado, o que falta continua pontilhado. A leitora vê a distância
   percorrida sem precisar contar nó.

   Componente puro (sem estado, sem "use client"): serve tanto na página de
   servidor quanto na tela de QA.
   ============================================================ */

const AMPLITUDE = 25; // oscilação lateral, em % da largura da trilha
// Volta completa a cada 5 dias. Com passo de 6 (π/3) o seno cai duas vezes no
// mesmo ponto do ciclo e saíam pares de nós EMPILHADOS, com um trecho reto
// vertical entre eles — visto no primeiro render. Com 5, nenhum par de dias
// vizinhos divide o mesmo x e a curva anda o tempo todo.
const PASSO_ONDA = (2 * Math.PI) / 5;
const PASSO_Y = 70; // descida por dia, em px
const TOPO = 36;

export function posicao(i: number) {
  return { x: 50 + AMPLITUDE * Math.sin(i * PASSO_ONDA), y: TOPO + i * PASSO_Y };
}

function pontoDoNo(i: number): [number, number] {
  const { x, y } = posicao(i);
  return [x, y];
}

/**
 * Fio SUAVE ligando os nós: cada nó vira ponto de controle de uma quadrática
 * e a curva passa pelos MEIOS dos segmentos. Com a senoide por trás, o traço
 * sai contínuo de ponta a ponta, sem canto nenhum.
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
  const altura = TOPO + (totalDias - 1) * PASSO_Y + TOPO;

  const todos = nos.map((_, i) => pontoDoNo(i));
  // trecho já caminhado: do primeiro nó até o último dia lido
  const andados = todos.slice(0, Math.max(0, Math.min(lidos, totalDias)));

  return (
    <div className="trilha" style={{ height: altura }}>
      <svg className="tr-fio" viewBox={`0 0 100 ${altura}`} preserveAspectRatio="none" aria-hidden>
        {/* o caminho inteiro, apagado */}
        <path
          d={caminhoSuave(todos)}
          fill="none"
          stroke="var(--line)"
          strokeWidth="2"
          strokeLinecap="round"
          strokeDasharray="2 7"
          vectorEffect="non-scaling-stroke"
        />
        {/* o trecho já caminhado, aceso */}
        {andados.length > 1 && (
          <path
            className="tr-andado"
            d={caminhoSuave(andados)}
            fill="none"
            stroke="url(#trilhaOuro)"
            strokeWidth="3"
            strokeLinecap="round"
            vectorEffect="non-scaling-stroke"
          />
        )}
        <defs>
          <linearGradient id="trilhaOuro" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stopColor="#E0C88A" />
            <stop offset="100%" stopColor="#8F6D1E" />
          </linearGradient>
        </defs>
      </svg>

      {nos.map((dia, i) => {
        const { x, y } = posicao(i);
        const feito = dia <= lidos;
        const hoje = dia === lidos + 1;
        const marco = dia % 7 === 0; // marco semanal: nunca a mais de 3 dias
        return (
          <span
            key={dia}
            className={"no" + (feito ? " feito" : "") + (hoje ? " hoje" : "") + (marco ? " marco" : "")}
            style={{
              left: `${x}%`,
              top: y,
              // entrada em cascata: os nós brotam de cima pra baixo ao abrir a tela
              animationDelay: `${Math.min(i * 45, 900)}ms`,
            }}
            title={marco ? `Dia ${dia} — marco da semana` : `Dia ${dia}`}
          >
            {feito ? (
              <IconeEspiga size={marco ? 22 : 18} strokeWidth={1.8} />
            ) : hoje ? (
              <IconeCandeia size={22} strokeWidth={1.8} />
            ) : (
              <i className="tnum">{dia}</i>
            )}
            {marco && !feito && !hoje && <b className="no-marco-fio" aria-hidden />}
          </span>
        );
      })}
    </div>
  );
}
