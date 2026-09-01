import { createClient } from "@/lib/supabase-server";
import { ensurePerfil, temAcesso } from "@/lib/quota";
import { getEstadoTracker } from "@/lib/tracker";
import { LIVROS_AT, LIVROS_NT, TOTAL_AT, TOTAL_BIBLIA, TOTAL_NT } from "@/lib/biblia";
import BibliaClient from "./BibliaClient";

export const metadata = { title: "Minha Bíblia — Constância na Palavra" };
export const dynamic = "force-dynamic";

// Tela GRÁTIS: os 66 livros, 1.189 capítulos em caixinhas, progresso e meta.
// É a porta de entrada do produto — funciona sem assinatura, de propósito.
export default async function BibliaPage() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  const perfil = user ? await ensurePerfil(user.id, user.email) : null;
  const estado = await getEstadoTracker();

  return (
    <BibliaClient
      pago={temAcesso(perfil)}
      livrosAT={LIVROS_AT}
      livrosNT={LIVROS_NT}
      totais={{ at: TOTAL_AT, nt: TOTAL_NT, biblia: TOTAL_BIBLIA }}
      inicial={
        estado ?? {
          porLivro: {},
          totalLidos: 0,
          lidosAT: 0,
          lidosNT: 0,
          pctTotal: 0,
          pctAT: 0,
          pctNT: 0,
          meta: null,
          ritmoNecessario: null,
          diasRestantes: null,
          livrosCompletos: 0,
          datasLidas: [],
        }
      }
    />
  );
}
