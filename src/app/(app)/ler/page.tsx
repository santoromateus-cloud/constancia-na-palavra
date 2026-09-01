import Link from "next/link";
import { getEstadoLeitura } from "@/lib/leitura";
import { IconeCandeia, IconeEspiga, IconePerola } from "../Icones";
import LerClient from "./LerClient";

export const metadata = { title: "Minha leitura de hoje — Constância na Palavra" };
export const dynamic = "force-dynamic";

/* Servidor: só busca o estado e entrega pro cliente.
   Toda a gamificação (candeia, lavra, celebração, pérola) vive no LerClient,
   porque depende de interação — o check-in tem que responder no toque. */
export default async function Ler() {
  const estado = await getEstadoLeitura();

  if (!estado.temPlano) {
    return (
      <main className="vazio">
        <section>
          <div className="vz-icones" aria-hidden>
            <IconeCandeia size={30} />
            <IconeEspiga size={30} />
            <IconePerola size={30} />
          </div>
          <span className="vz-kick">Sua leitura</span>
          <h1>Escolha por onde começar.</h1>
          <p>
            Você ainda não tem um caminho ativo. Escolha um e a leitura de hoje já aparece
            aqui, com a sua candeia acesa, a sua Lavra e a pérola do dia.
          </p>
          <Link href="/planos" className="vz-btn">Ver os caminhos →</Link>
        </section>

        <style>{`
          .vazio{min-height:calc(100vh - 66px);display:flex;align-items:center;justify-content:center;padding:30px 18px 70px}
          .vazio section{max-width:520px;width:100%;text-align:center;background:var(--paper);border:1px solid var(--line);border-radius:26px;padding:clamp(28px,5vw,44px);box-shadow:var(--shadow-sm)}
          .vz-icones{display:flex;justify-content:center;gap:16px;color:var(--ambar);margin-bottom:20px}
          .vz-kick{font-size:11.5px;letter-spacing:1.6px;text-transform:uppercase;font-weight:700;color:var(--ouro)}
          .vazio h1{font-family:var(--display);font-size:clamp(26px,4vw,34px);line-height:1.1;margin:12px 0 0}
          .vazio p{font-size:15px;line-height:1.62;color:#6C5C45;margin:14px 0 26px}
          .vz-btn{display:block;background:linear-gradient(140deg,#63703F,#4A5430);color:#FCF8EF;font-weight:700;font-size:15.5px;border-radius:16px;padding:16px;transition:.2s;box-shadow:0 12px 28px -12px rgba(74,84,48,.8)}
          .vz-btn:hover{transform:translateY(-2px)}
        `}</style>
      </main>
    );
  }

  return (
    <LerClient
      planoTitulo={estado.plano.titulo}
      referencia={estado.referencia}
      texto={estado.texto}
      diaAtual={estado.diaAtual}
      totalDias={estado.totalDias}
      progressoPct={estado.progressoPct}
      jaLeuHoje={estado.jaLeuHoje}
      streak={estado.streak}
      recorde={estado.recorde}
      espigas={estado.espigas}
      gracas={estado.gracas}
      perola={estado.perola}
    />
  );
}
