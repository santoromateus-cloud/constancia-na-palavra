"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  IconeBiblia,
  IconeCadeado,
  IconeCandeia,
  IconeConta,
  IconeGeografia,
  IconeIrmas,
} from "./Icones";

// Navegação das áreas logadas. Duas camadas visíveis na MESMA barra:
//   Bíblia + Conta    = grátis (sempre clicáveis)
//   Hoje/Planos/Mural = pago (com cadeado pra quem ainda não assinou — o cadeado
//   VENDE: esconder faria a leitora nem saber que existe mais coisa)
//
// Ícones: desenho próprio (Icones.tsx), não emoji. Emoji quebra a identidade —
// cada sistema operacional desenha do seu jeito e nenhum deles é Luz e Lavra.
const ABAS = [
  { href: "/biblia", label: "Bíblia", Icone: IconeBiblia, pago: false },
  { href: "/ler", label: "Hoje", Icone: IconeCandeia, pago: true },
  { href: "/planos", label: "Caminhos", Icone: IconeGeografia, pago: true },
  { href: "/mural", label: "Irmãs", Icone: IconeIrmas, pago: true },
  { href: "/conta", label: "Conta", Icone: IconeConta, pago: false },
];

export default function AppNav({ pago = true }: { pago?: boolean }) {
  const pathname = usePathname();
  return (
    <nav className="an-nav">
      <div className="an-in">
        <Link href={pago ? "/ler" : "/biblia"} className="an-brand">
          <svg width="26" height="26" viewBox="0 0 64 64" aria-hidden>
            <rect width="64" height="64" rx="15" fill="#3A2E1D" />
            <rect x="16" y="34" width="9" height="16" rx="4.5" fill="#E8D9AE" />
            <rect x="27.5" y="26" width="9" height="24" rx="4.5" fill="#C9A85C" />
            <rect x="39" y="16" width="9" height="34" rx="4.5" fill="#6A7A42" />
          </svg>
          <span>Constância</span>
        </Link>
        <div className="an-abas">
          {ABAS.map((a) => {
            const on = pathname === a.href;
            const travada = a.pago && !pago;
            return (
              <Link
                key={a.href}
                href={travada ? "/pricing" : a.href}
                className={"an-aba" + (on ? " on" : "") + (travada ? " lock" : "")}
                aria-label={travada ? `${a.label} — disponível no plano completo` : a.label}
              >
                <span className="an-em">
                  <a.Icone size={19} />
                </span>
                <span className="an-lb">{a.label}</span>
                {travada && (
                  <span className="an-cad">
                    <IconeCadeado size={11} strokeWidth={2.2} />
                  </span>
                )}
              </Link>
            );
          })}
        </div>
      </div>

      <style jsx>{`
        .an-nav{position:sticky;top:0;z-index:60;backdrop-filter:blur(12px);background:color-mix(in srgb,var(--creme) 88%,transparent);border-bottom:1px solid var(--line)}
        .an-in{max-width:980px;margin:0 auto;height:60px;padding:0 clamp(14px,4vw,22px);display:flex;align-items:center;justify-content:space-between;gap:12px}
        .an-brand{display:flex;align-items:center;gap:9px;font-family:var(--serif);font-weight:700;font-size:17px;color:var(--ink)}
        .an-abas{display:flex;align-items:center;gap:2px}
        .an-aba{display:flex;align-items:center;gap:6px;padding:8px 11px;border-radius:12px;color:#8B7A61;font-size:14px;font-weight:600;transition:.18s}
        .an-aba :global(.an-em){display:flex;color:currentColor;opacity:.72;transition:.18s}
        .an-aba:hover{color:var(--base)}
        .an-aba:hover :global(.an-em){opacity:1}
        .an-aba.on{color:var(--coral);background:color-mix(in srgb,var(--coral) 11%,transparent)}
        .an-aba.on :global(.an-em){opacity:1;color:var(--ouro)}
        .an-aba.lock{opacity:.62}
        .an-aba.lock :global(.an-em){opacity:.45}
        .an-aba.lock:hover{opacity:1;color:var(--ouro)}
        .an-aba :global(.an-cad){display:flex;color:var(--ouro);flex:none}
        @media(max-width:680px){.an-aba .an-lb{display:none}.an-brand span{display:none}.an-aba{padding:8px 9px}}
      `}</style>
    </nav>
  );
}
