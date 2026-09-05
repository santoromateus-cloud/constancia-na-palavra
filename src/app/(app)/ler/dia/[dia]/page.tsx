import { redirect } from "next/navigation";
import { getDiaAndado } from "@/lib/leitura";
import { getEntradaDoDia } from "@/lib/caderno";
import LerClient from "../../LerClient";
import MapaLugar from "../../MapaLugar";

export const metadata = { title: "Um dia do seu caminho — Constância na Palavra" };
export const dynamic = "force-dynamic";

/* Um dia JÁ ANDADO do caminho, aberto de novo (04/09/2026, pedido do Mateus:
   "precisa ser possível voltar e ver os mapas e textos anteriores").

   É a mesma tela de Hoje daquele dia — texto, mapa, camadas, pérola e o
   caderno dela (que continua editável: o caderno é dela, em qualquer dia) —
   sem candeia, sem seara e sem o botão de marcar, porque esse dia já está
   marcado. Dia à frente, dia em andamento ou endereço inválido: volta para a
   tela de Hoje sem alarde. */
export default async function DiaAndadoPage({ params }: { params: Promise<{ dia: string }> }) {
  const { dia } = await params;
  const n = /^[0-9]{1,3}$/.test(dia) ? Number(dia) : NaN;
  const d = await getDiaAndado(n);
  if (!d.ok) redirect("/ler");

  const entrada = await getEntradaDoDia(d.plano.id, d.dia);

  return (
    /* candeia, seara e recorde não aparecem num dia andado; os zeros abaixo
       nunca chegam à tela — a LerClient esconde essas seções quando `passado`
       está presente. */
    <LerClient
      key={`dia-${d.dia}`}
      planoId={d.plano.id}
      planoTitulo={d.plano.titulo}
      referencia={d.referencia}
      texto={d.texto}
      diaAtual={d.dia}
      totalDias={d.totalDias}
      progressoPct={d.progressoPct}
      jaLeuHoje={true}
      concluido={false}
      streak={0}
      recorde={0}
      espigas={0}
      perola={d.perola}
      camadas={d.camadas}
      diasAndados={d.diasAndados}
      passado={{
        lidoEm: d.lidoEm,
        anterior: d.anterior,
        seguinte: d.seguinte,
        diaEmAndamento: d.diaAtual,
      }}
      mapa={<MapaLugar lugar={d.camadas.geografiaLugar} />}
      entrada={
        entrada
          ? {
              promessa: entrada.promessa,
              ordem: entrada.ordem,
              principio: entrada.principio,
              passo: entrada.passo,
            }
          : null
      }
    />
  );
}
