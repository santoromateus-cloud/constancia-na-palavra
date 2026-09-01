// ── Ícones do Constância na Palavra ──────────────────────────────────────────
// Desenho próprio, na identidade Luz e Lavra: traço fino, geometria confiante,
// nada de emoji. Todos em viewBox 24×24, stroke currentColor, para herdarem a
// cor do contexto (dourado no claro, marfim no bloco escuro).
//
// Regra de desenho: linha de 1.6, pontas arredondadas, no máximo um preenchimento
// sólido por ícone (o "acento") — é o que dá peso editorial sem virar desenho
// infantil.

type P = { size?: number; className?: string; strokeWidth?: number };

const base = (size: number, className?: string) => ({
  width: size,
  height: size,
  viewBox: "0 0 24 24",
  fill: "none",
  stroke: "currentColor",
  strokeLinecap: "round" as const,
  strokeLinejoin: "round" as const,
  className,
  "aria-hidden": true,
});

/** CANDEIA — a sequência de dias acesa (Sl 119:105).
 *  Vela com chama grande: a chama é o assunto, o corpo só a sustenta. A primeira
 *  versão era uma lamparina de bojo fundo e lia como cálice — trocada. */
export function IconeCandeia({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      {/* chama: o acento sólido, dominante */}
      <path
        d="M12 1.8c2.1 2.5 3.4 4 3.4 5.9a3.4 3.4 0 0 1-6.8 0c0-1.9 1.3-3.4 3.4-5.9Z"
        fill="currentColor"
        stroke="none"
      />
      {/* pavio */}
      <path d="M12 11.1v1.5" />
      {/* corpo da vela */}
      <path d="M8.6 12.6h6.8v6.6a1.8 1.8 0 0 1-1.8 1.8h-3.2a1.8 1.8 0 0 1-1.8-1.8v-6.6Z" />
      {/* base */}
      <path d="M6.6 21h10.8" />
    </svg>
  );
}

/** ESPIGA — a Lavra que cresce, uma espiga por leitura (Gl 6:9). */
export function IconeEspiga({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <path d="M12 21.5V7" />
      {/* três pares de grãos, decrescendo */}
      <path d="M12 8.4c-2.4-.2-3.6-1.7-3.4-4 2.3.3 3.4 1.8 3.4 4Z" fill="currentColor" stroke="none" />
      <path d="M12 8.4c2.4-.2 3.6-1.7 3.4-4-2.3.3-3.4 1.8-3.4 4Z" fill="currentColor" stroke="none" />
      <path d="M12 13c-2.4-.2-3.6-1.7-3.4-4 2.3.3 3.4 1.8 3.4 4Z" />
      <path d="M12 13c2.4-.2 3.6-1.7 3.4-4-2.3.3-3.4 1.8-3.4 4Z" />
      <path d="M12 17.6c-2.4-.2-3.6-1.7-3.4-4 2.3.3 3.4 1.8 3.4 4Z" />
      <path d="M12 17.6c2.4-.2 3.6-1.7 3.4-4-2.3.3-3.4 1.8-3.4 4Z" />
      {/* ponta da espiga */}
      <path d="M12 7c0-1.8.7-3.2 2-4.2" />
    </svg>
  );
}

/** PÉROLA — o versículo-joia guardado no cofre (Mt 13:46). Concha aberta. */
export function IconePerola({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      {/* leque da concha, mais raso e com nervura cheia pra não virar leque/paraquedas */}
      <path d="M4 14.2a8 8 0 0 1 16 0Z" />
      <path d="M12 6.2v8M8.2 6.9 9.9 14.2M15.8 6.9 14.1 14.2M5.6 9.2l2.1 5M18.4 9.2l-2.1 5" />
      {/* charneira */}
      <path d="M10.4 14.2h3.2" />
      {/* pérola: o acento sólido, solta abaixo da concha */}
      <circle cx="12" cy="18.6" r="2.4" fill="currentColor" stroke="none" />
    </svg>
  );
}

/** IRMÃS — o mural e a dupla de constância. Três mulheres lado a lado.
 *  A primeira versão eram três círculos ligados por linhas e lia como molécula. */
export function IconeIrmas({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      {/* as duas de trás */}
      <circle cx="5.2" cy="9.4" r="2.2" />
      <path d="M1.6 18.4a4.2 4.2 0 0 1 3-4" />
      <circle cx="18.8" cy="9.4" r="2.2" />
      <path d="M22.4 18.4a4.2 4.2 0 0 0-3-4" />
      {/* a da frente: acento sólido */}
      <circle cx="12" cy="7.8" r="3.1" fill="currentColor" stroke="none" />
      <path d="M6.6 18.6a5.4 5.4 0 0 1 10.8 0" />
    </svg>
  );
}

/** BÍBLIA — o marcador dos 66 livros. Livro aberto com fita. */
export function IconeBiblia({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <path d="M12 6.4C10.3 5 8.2 4.3 5.4 4.3a1 1 0 0 0-1 1v11.3a1 1 0 0 0 1 1c2.8 0 4.9.7 6.6 2.1" />
      <path d="M12 6.4c1.7-1.4 3.8-2.1 6.6-2.1a1 1 0 0 1 1 1v11.3a1 1 0 0 1-1 1c-2.8 0-4.9.7-6.6 2.1" />
      <path d="M12 6.4v13.3" />
      {/* fita marcadora: o acento */}
      <path d="M15.4 4.6v5l1.7-1.4 1.7 1.4v-5.2" fill="currentColor" stroke="none" opacity=".9" />
    </svg>
  );
}

/** CRONOLOGIA — a Bíblia na ordem em que aconteceu. Ampulheta.
 *  A primeira versão era uma linha do tempo com nós e marcas; ficou suja em
 *  20px e igual a "passos". A ampulheta lê tempo na hora e é única no conjunto. */
export function IconeCronologia({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <path d="M6.4 2.8h11.2M6.4 21.2h11.2" />
      <path d="M7.6 2.8v3.4c0 1.7 1.5 3.1 4.4 5.8 2.9-2.7 4.4-4.1 4.4-5.8V2.8" />
      <path d="M7.6 21.2v-3.4c0-1.7 1.5-3.1 4.4-5.8 2.9 2.7 4.4 4.1 4.4 5.8v3.4" />
      {/* a areia que já caiu: acento sólido */}
      <path d="M9.2 21.2c0-1.6 1.2-2.9 2.8-4.2 1.6 1.3 2.8 2.6 2.8 4.2H9.2Z" fill="currentColor" stroke="none" />
    </svg>
  );
}

/** GEOGRAFIA — onde a história aconteceu. Mapa dobrado com marca de lugar. */
export function IconeGeografia({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <path d="M3 6.6 9 4.3v13.1L3 19.7V6.6Z" />
      <path d="M9 4.3l6 2.3v13.1L9 17.4" />
      <path d="M15 6.6l6-2.3v13.1l-6 2.3" />
      {/* alfinete: o acento */}
      <path d="M17.4 8.2a2.3 2.3 0 0 1 2.3 2.3c0 1.7-2.3 4-2.3 4s-2.3-2.3-2.3-4a2.3 2.3 0 0 1 2.3-2.3Z" fill="currentColor" stroke="none" />
    </svg>
  );
}

/** CURIOSIDADE — o contexto que muda a leitura. Chave (a que abre o texto). */
export function IconeCuriosidade({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <circle cx="8" cy="8" r="4.2" />
      <circle cx="8" cy="8" r="1.4" fill="currentColor" stroke="none" />
      <path d="M11 11l8.4 8.4" />
      <path d="M17 14.6l-2 2M19.4 17l-1.6 1.6" />
    </svg>
  );
}

/** COMENTÁRIO — a voz que explica o texto. Aspas em bloco. */
export function IconeComentario({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <path d="M4 4.6h16a1.6 1.6 0 0 1 1.6 1.6v9a1.6 1.6 0 0 1-1.6 1.6H9.6L5 21v-4.2h-1A1.6 1.6 0 0 1 2.4 15.2v-9A1.6 1.6 0 0 1 4 4.6Z" />
      <path d="M8.4 8.6c-1.5 0-2.4 1-2.4 2.3 0 1 .7 1.7 1.6 1.7.8 0 1.4-.5 1.4-1.3 0-.7-.5-1.2-1.1-1.2h-.3c.1-.5.5-.8 1-.9l-.2-.6ZM13.4 8.6c-1.5 0-2.4 1-2.4 2.3 0 1 .7 1.7 1.6 1.7.8 0 1.4-.5 1.4-1.3 0-.7-.5-1.2-1.1-1.2h-.3c.1-.5.5-.8 1-.9l-.2-.6Z" fill="currentColor" stroke="none" />
    </svg>
  );
}

/** CONTA — a leitora. Presença, não avatar genérico. */
export function IconeConta({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <circle cx="12" cy="8.2" r="3.6" />
      <path d="M4.6 20.4a7.4 7.4 0 0 1 14.8 0" />
    </svg>
  );
}

/** META — a data de chegada. Alvo com a flecha no centro. */
export function IconeMeta({ size = 24, className, strokeWidth = 1.6 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <circle cx="12" cy="12" r="8.4" />
      <circle cx="12" cy="12" r="4.6" />
      <circle cx="12" cy="12" r="1.5" fill="currentColor" stroke="none" />
    </svg>
  );
}

/** CADEADO — o que ainda não abriu. Discreto, sem agressividade. */
export function IconeCadeado({ size = 24, className, strokeWidth = 1.8 }: P) {
  return (
    <svg {...base(size, className)} strokeWidth={strokeWidth}>
      <rect x="4.6" y="10.4" width="14.8" height="10" rx="2.4" />
      <path d="M8.4 10.4V7.6a3.6 3.6 0 0 1 7.2 0v2.8" />
    </svg>
  );
}
