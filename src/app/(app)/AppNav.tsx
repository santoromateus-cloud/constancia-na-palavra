"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import {
  IconeBiblia,
  IconeCadeado,
  IconeCandeia,
  IconeConta,
  IconeGeografia,
  IconeIrmas,
} from "./Icones";

// Barra de navegação das áreas logadas.
//
// v2 (01/09, tarde): a v1 punha ícone e rótulo lado a lado com gap de 6px. Em
// telas médias o flex quebrava sozinho, o rótulo caía embaixo do ícone e as
// cinco abas ficavam coladas umas nas outras, ilegíveis. Virou tab bar de
// verdade: ícone SOBRE o rótulo, sempre, com área de toque cheia e respiro
// entre as abas. Além de resolver o aperto, é o padrão que a leitora já conhece
// de qualquer app no celular dela.
//
//   Bíblia + Conta    = grátis (sempre clicáveis)
//   Hoje/Caminhos/Irmãs = pago (com cadeado pra quem ainda não assinou — o
//   cadeado VENDE: esconder faria a leitora nem saber que existe mais coisa)

/* Voltar — seta simples pra esquerda. Mora aqui e não no Icones.tsx porque só a
   barra usa. Fica em TODAS as telas: a leitora entra num caminho, abre um livro,
   e precisa de um caminho de volta que não seja o botão do navegador — que no
   celular, com o app aberto pela tela inicial, muitas vezes nem aparece. */
function IconeVoltar({ size = 20 }: { size?: number }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" aria-hidden>
      <path d="M15 5 8 12l7 7" stroke="currentColor" strokeWidth={1.8}
            strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  );
}

const ABAS = [
  { href: "/biblia", label: "Bíblia", Icone: IconeBiblia, pago: false },
  { href: "/ler", label: "Hoje", Icone: IconeCandeia, pago: true },
  { href: "/planos", label: "Caminhos", Icone: IconeGeografia, pago: true },
  { href: "/mural", label: "Irmãs", Icone: IconeIrmas, pago: true },
  { href: "/conta", label: "Conta", Icone: IconeConta, pago: false },
];

export default function AppNav({ pago = true }: { pago?: boolean }) {
  const pathname = usePathname();
  const router = useRouter();
  return (
    <nav className="an-nav">
      <div className="an-in">
        {/* Voltar — em TODAS as telas (pedido do Mateus, 02/09/2026).
            router.back() usa o histórico real: volta pro lugar de onde ela veio,
            não pra uma tela fixa. Se ela abriu o app direto nesta página e não há
            histórico, cai na Bíblia, que é a casa dela. */}
        <button
          type="button"
          className="an-volta"
          aria-label="Voltar"
          onClick={() => {
            if (typeof window !== "undefined" && window.history.length > 1) router.back();
            else router.push("/biblia");
          }}
        >
          <IconeVoltar size={20} />
        </button>

        <Link href={pago ? "/ler" : "/biblia"} className="an-brand">
          <svg width="28" height="28" viewBox="0 0 64 64" aria-hidden>
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
                aria-current={on ? "page" : undefined}
              >
                <span className="an-ico">
                  <a.Icone size={22} />
                  {travada && (
                    <span className="an-cad">
                      <IconeCadeado size={9} strokeWidth={2.6} />
                    </span>
                  )}
                </span>
                <span className="an-lb">{a.label}</span>
                <span className="an-fio" aria-hidden />
              </Link>
            );
          })}
        </div>
      </div>

      <style jsx>{`
        .an-nav{
          position:sticky;top:0;z-index:60;
          backdrop-filter:blur(14px) saturate(1.2);
          background:color-mix(in srgb,var(--creme) 86%,transparent);
          border-bottom:1px solid var(--line);
        }
        .an-in{
          max-width:1040px;margin:0 auto;
          padding:0 clamp(14px,4vw,26px);
          display:flex;align-items:center;justify-content:space-between;gap:20px;
          min-height:66px;
        }
        .an-brand{display:flex;align-items:center;gap:10px;font-family:var(--display);font-weight:400;font-size:18px;color:var(--ink);flex:none}

        /* botão de voltar: alvo de toque cheio (40px), discreto, sempre no
           mesmo lugar — canto superior esquerdo, que é onde a mão procura */
        .an-volta{
          flex:none;display:flex;align-items:center;justify-content:center;
          width:40px;height:40px;margin-right:-4px;border-radius:12px;
          color:#96866D;background:transparent;border:0;cursor:pointer;
          transition:color .2s,background .2s,transform .2s;
        }
        .an-volta:hover{color:var(--base);background:color-mix(in srgb,var(--areia) 26%,transparent);transform:translateX(-2px)}
        .an-volta:active{transform:translateX(-3px) scale(.94)}

        .an-abas{display:flex;align-items:stretch;gap:clamp(2px,1.4vw,10px)}

        /* tab bar: ícone SOBRE o rótulo, área de toque cheia, respiro entre abas */
        .an-aba{
          position:relative;
          display:flex;flex-direction:column;align-items:center;justify-content:center;gap:5px;
          min-width:64px;padding:9px 10px 8px;border-radius:14px;
          color:#96866D;font-size:11.5px;font-weight:600;letter-spacing:.2px;
          transition:color .2s,background .2s;
        }
        .an-aba :global(.an-ico){position:relative;display:flex;color:currentColor;transition:transform .28s cubic-bezier(.34,1.56,.64,1)}
        .an-aba :global(.an-lb){line-height:1;white-space:nowrap}

        .an-aba:hover{color:var(--base);background:color-mix(in srgb,var(--areia) 26%,transparent)}
        .an-aba:hover :global(.an-ico){transform:translateY(-2px)}

        .an-aba.on{color:var(--ouro)}
        .an-aba.on :global(.an-ico){transform:translateY(-1px)}
        /* fio dourado embaixo da aba ativa, no lugar da pílula de fundo:
           é mais discreto e casa com os fios da identidade */
        .an-aba :global(.an-fio){
          position:absolute;left:50%;bottom:-1px;height:2px;width:0;border-radius:2px;
          background:linear-gradient(90deg,var(--ambar),var(--ouro));
          transform:translateX(-50%);transition:width .3s cubic-bezier(.16,1,.3,1);
        }
        .an-aba.on :global(.an-fio){width:calc(100% - 18px)}

        .an-aba.lock{color:#B3A68E}
        .an-aba.lock:hover{color:var(--ouro)}
        .an-aba :global(.an-cad){
          position:absolute;right:-6px;bottom:-3px;
          display:flex;align-items:center;justify-content:center;
          width:14px;height:14px;border-radius:50%;
          background:var(--creme);color:var(--ouro);
          box-shadow:0 0 0 1.5px var(--creme);
        }

        @media(max-width:640px){
          .an-in{gap:8px;padding:0 10px;min-height:62px}
          .an-brand :global(span){display:none}
          .an-volta{width:34px;height:34px;margin-right:-8px}
          .an-abas{flex:1;justify-content:space-between;gap:0}
          .an-aba{min-width:0;flex:1;padding:8px 4px 7px;font-size:10.5px}
        }
        @media (prefers-reduced-motion: reduce){
          .an-aba,.an-aba :global(.an-ico),.an-aba :global(.an-fio),.an-volta{transition:none}
        }
      `}</style>
    </nav>
  );
}
