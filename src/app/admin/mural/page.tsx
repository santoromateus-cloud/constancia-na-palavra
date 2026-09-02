import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase-server";
import { ehAdmin } from "@/lib/admin";
import MuralModeracao from "./MuralModeracao";

/* ============================================================
   CURADORIA DO MURAL — o gate (SERVIDOR)
   Mesma blindagem de 3 camadas do /admin: sem login vai pro /login, logado
   sem ser admin recebe 404 (a página não confirma que existe), admin entra.
   A API /api/admin/mural re-checa ehAdmin no servidor.
   ============================================================ */

export const dynamic = "force-dynamic";
export const metadata = { title: "Curadoria do mural — Constância na Palavra" };

export default async function GateMural() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) redirect("/login");
  if (!ehAdmin(user.email)) notFound();

  return <MuralModeracao />;
}
