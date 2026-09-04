import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { createClient } from "@/lib/supabase-server";
import { getLivro } from "@/lib/biblia";
import { validarCapitulo, vizinhos } from "@/lib/leitor";
import { carregarLivro } from "@/data/biblia";
import LeitorClient from "./LeitorClient";

/* ─────────────────────────────────────────────────────────────────────────────
   CONSTÂNCIA NA PALAVRA — o leitor da Bíblia (camada GRÁTIS) · /biblia/[livro]/[capitulo]

   Nasceu do feedback da Elisângela (04/09/2026): "quando marca lido, ao clicar não
   abre o livro da Bíblia?". Até aqui a aba Bíblia era só o marcador — tocar no
   número marcava o capítulo e não abria texto nenhum. Um app chamado Constância
   na Palavra que não abre a Palavra obrigava a leitora a ter dois apps.

   Texto: Almeida de DOMÍNIO PÚBLICO, a mesma fonte dos caminhos, gerada no build
   por scripts/gerar-biblia.mjs (um JSON por livro, carregado sob demanda). Não
   passa pelo banco: é dado que não muda nunca, mesma lógica do catálogo em
   src/lib/biblia.ts. O que vem do banco é só o progresso dela.

   Regra da casa que esta tela cumpre: a Bíblia nunca fica atrás do paywall.
   O gate do layout (livre) é só SESSÃO.
   ───────────────────────────────────────────────────────────────────────────── */

type Params = Promise<{ livro: string; capitulo: string }>;

export const dynamic = "force-dynamic";

export async function generateMetadata({ params }: { params: Params }): Promise<Metadata> {
  const { livro, capitulo } = await params;
  const ok = validarCapitulo(livro, capitulo);
  if (!ok) return { title: "Minha Bíblia — Constância na Palavra" };
  const meta = getLivro(ok.slug)!;
  return { title: `${meta.nome} ${ok.capitulo} — Constância na Palavra` };
}

export default async function CapituloPage({ params }: { params: Params }) {
  const { livro, capitulo } = await params;
  const ok = validarCapitulo(livro, capitulo);
  if (!ok) notFound();

  const meta = getLivro(ok.slug)!;
  const texto = await carregarLivro(ok.slug);
  if (!texto) notFound();
  const versiculos = texto.capitulos[ok.capitulo - 1] ?? [];

  // Progresso deste livro (só o dela — RLS). Uma consulta pequena por capítulo aberto.
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  let lidos: number[] = [];
  let lidoEm: string | null = null;
  if (user) {
    const { data } = await supabase
      .from("biblia_progresso")
      .select("capitulo, lido_em")
      .eq("user_id", user.id)
      .eq("livro", ok.slug);
    const linhas = (data ?? []) as { capitulo: number; lido_em: string | null }[];
    lidos = linhas.map((r) => r.capitulo).filter((c) => c >= 1 && c <= meta.capitulos);
    lidoEm = linhas.find((r) => r.capitulo === ok.capitulo)?.lido_em ?? null;
  }

  const { anterior, proximo, fimDoLivro } = vizinhos(ok.slug, ok.capitulo);

  return (
    <LeitorClient
      livro={meta}
      capitulo={ok.capitulo}
      versiculos={versiculos}
      lidoInicial={lidos.includes(ok.capitulo)}
      lidoEm={lidoEm}
      lidosNoLivro={lidos.length}
      anterior={anterior}
      proximo={proximo}
      fimDoLivro={fimDoLivro}
    />
  );
}
