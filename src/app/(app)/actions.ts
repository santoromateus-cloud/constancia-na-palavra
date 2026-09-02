"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { registrarCheckin, escolherPlano } from "@/lib/leitura";
import { publicarPost, alternarReacao, type ReacaoTipo } from "@/lib/mural";
import { salvarEntrada, apagarEntrada, type EntradaInput } from "@/lib/caderno";

// Registra a leitura de hoje e atualiza a tela /ler (streak/progresso).
export async function liHoje(): Promise<void> {
  await registrarCheckin();
  revalidatePath("/ler");
}

// Ativa um plano de leitura e leva pra tela de leitura.
export async function ativarPlano(planId: string): Promise<void> {
  await escolherPlano(planId);
  revalidatePath("/ler");
  redirect("/ler");
}

// Publica um recado no mural.
export async function publicarMural(formData: FormData): Promise<void> {
  const texto = String(formData.get("texto") ?? "");
  const referencia = String(formData.get("referencia") ?? "");
  await publicarPost(texto, referencia);
  revalidatePath("/mural");
}

// Alterna (amém / orando) a reação da usuária num post.
export async function reagirMural(postId: string, tipo: ReacaoTipo): Promise<void> {
  await alternarReacao(postId, tipo);
  revalidatePath("/mural");
}

// Guarda a entrada do caderno do dia.
//
// De propósito NÃO revalida /ler: a leitora está com a tela aberta e o texto
// dela no formulário. Revalidar a rota em que ela está digitando é a receita
// para o rascunho sumir na frente dela. As telas que leem o caderno (/caderno
// e /raio-x) revalidam, e é lá que o número precisa estar certo.
export async function salvarCaderno(entrada: EntradaInput): Promise<{ ok: boolean; erro?: string }> {
  const r = await salvarEntrada(entrada);
  if (r.ok) {
    revalidatePath("/caderno");
    revalidatePath("/raio-x");
  }
  return r;
}

// Apaga uma entrada do caderno (só a própria — a RLS confere de novo).
export async function apagarDoCaderno(id: string): Promise<void> {
  await apagarEntrada(id);
  revalidatePath("/caderno");
  revalidatePath("/raio-x");
}
