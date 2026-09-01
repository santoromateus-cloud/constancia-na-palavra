"use server";

import { revalidatePath } from "next/cache";
import { createClient } from "@/lib/supabase-server";
import { getLivro } from "@/lib/biblia";

// ── Ações da camada GRÁTIS ────────────────────────────────────────────────────
// Marcar/desmarcar capítulo e definir a meta. Não exigem assinatura: é a porta de
// entrada. Toda escrita passa pelo client de SESSÃO — a RLS é o gate real, estas
// validações só evitam lixo no banco.

type Resultado = { ok: boolean; erro?: string };

/** Marca (ou desmarca) um capítulo. Desmarcar é DELETE: sem linha = não lido. */
export async function alternarCapitulo(livro: string, capitulo: number, marcar: boolean): Promise<Resultado> {
  const meta = getLivro(livro);
  if (!meta) return { ok: false, erro: "livro_invalido" };
  if (!Number.isInteger(capitulo) || capitulo < 1 || capitulo > meta.capitulos) {
    return { ok: false, erro: "capitulo_invalido" };
  }

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { ok: false, erro: "sem_sessao" };

  if (marcar) {
    const { error } = await supabase
      .from("biblia_progresso")
      .upsert(
        { user_id: user.id, livro, capitulo },
        { onConflict: "user_id,livro,capitulo", ignoreDuplicates: true },
      );
    if (error) return { ok: false, erro: error.message };
  } else {
    const { error } = await supabase
      .from("biblia_progresso")
      .delete()
      .eq("user_id", user.id)
      .eq("livro", livro)
      .eq("capitulo", capitulo);
    if (error) return { ok: false, erro: error.message };
  }

  revalidatePath("/biblia");
  return { ok: true };
}

/** Marca (ou desmarca) o livro inteiro de uma vez — o "check all" do print. */
export async function alternarLivroInteiro(livro: string, marcar: boolean): Promise<Resultado> {
  const meta = getLivro(livro);
  if (!meta) return { ok: false, erro: "livro_invalido" };

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { ok: false, erro: "sem_sessao" };

  if (marcar) {
    const linhas = Array.from({ length: meta.capitulos }, (_, i) => ({
      user_id: user.id,
      livro,
      capitulo: i + 1,
    }));
    const { error } = await supabase
      .from("biblia_progresso")
      .upsert(linhas, { onConflict: "user_id,livro,capitulo", ignoreDuplicates: true });
    if (error) return { ok: false, erro: error.message };
  } else {
    const { error } = await supabase
      .from("biblia_progresso")
      .delete()
      .eq("user_id", user.id)
      .eq("livro", livro);
    if (error) return { ok: false, erro: error.message };
  }

  revalidatePath("/biblia");
  return { ok: true };
}

/** Define a meta de leitura (data de início, data de fim e escopo). */
export async function definirMeta(formData: FormData): Promise<void> {
  const inicio = String(formData.get("data_inicio") ?? "");
  const fim = String(formData.get("data_fim") ?? "");
  const escopoBruto = String(formData.get("escopo") ?? "biblia");
  const escopo = ["biblia", "at", "nt"].includes(escopoBruto) ? escopoBruto : "biblia";

  const dataOk = (s: string) => /^\d{4}-\d{2}-\d{2}$/.test(s);
  if (!dataOk(inicio) || !dataOk(fim)) return;
  // fim antes do início não vira meta impossível — a ação simplesmente não grava
  if (fim <= inicio) return;

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return;

  await supabase.from("meta_leitura").upsert(
    {
      user_id: user.id,
      data_inicio: inicio,
      data_fim: fim,
      escopo,
      atualizado_em: new Date().toISOString(),
    },
    { onConflict: "user_id" },
  );

  revalidatePath("/biblia");
}
