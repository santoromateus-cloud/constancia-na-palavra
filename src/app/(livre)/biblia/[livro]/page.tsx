import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase-server";
import { getLivro } from "@/lib/biblia";

// /biblia/joao → o primeiro capítulo que ela ainda não leu (ou o 1, se leu tudo).
// É o "continuar de onde parou" dentro de um livro, sem tela própria.
export const dynamic = "force-dynamic";

export default async function LivroPage({ params }: { params: Promise<{ livro: string }> }) {
  const { livro } = await params;
  const meta = getLivro(livro);
  if (!meta) notFound();

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  let destino = 1;
  if (user) {
    const { data } = await supabase
      .from("biblia_progresso")
      .select("capitulo")
      .eq("user_id", user.id)
      .eq("livro", livro);
    const lidos = new Set(((data ?? []) as { capitulo: number }[]).map((r) => r.capitulo));
    for (let c = 1; c <= meta.capitulos; c++) {
      if (!lidos.has(c)) {
        destino = c;
        break;
      }
    }
  }
  redirect(`/biblia/${livro}/${destino}`);
}
