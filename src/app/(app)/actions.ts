"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { registrarCheckin, escolherPlano } from "@/lib/leitura";
import { publicarPost, alternarReacao, type ReacaoTipo } from "@/lib/mural";

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
