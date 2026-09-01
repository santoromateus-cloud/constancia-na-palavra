import { notFound, redirect } from "next/navigation";
import { createClient } from "@/lib/supabase-server";
import { ehAdmin } from "@/lib/admin";
import AdminPanel from "./AdminPanel";

/* ============================================================
   CONSTÂNCIA NA PALAVRA — Gate do /admin (SERVIDOR)
   Blindagem de 3 camadas, a mesma que o FST recebeu em 11/07 depois da
   primeira cliente real. A trava acontece ANTES de qualquer coisa
   renderizar:
     - sem login             → manda pro /login (não revela nada);
     - logado sem ser admin  → 404, a página simplesmente "não existe";
     - admin                 → painel.

   Por que 404 e não "acesso restrito": uma tela de acesso restrito
   CONFIRMA que existe um painel naquele endereço. O 404 não confirma
   nada — quem varre a aplicação não descobre que o /admin existe.

   Era exatamente o que faltava aqui: até 01/09/2026 este arquivo era um
   componente de CLIENTE que baixava e renderizava o painel inteiro no
   navegador de qualquer pessoa logada, e só então escondia o conteúdo
   atrás de um "Acesso restrito". O código do painel ia junto no bundle.

   As APIs /api/admin/* seguem re-checando ehAdmin no servidor (403) —
   esta página é a 1ª camada, não a única. Nunca confiar só no cliente.
   ============================================================ */

export const dynamic = "force-dynamic";

export default async function AdminGate() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) redirect("/login");
  if (!ehAdmin(user.email)) notFound();

  return <AdminPanel />;
}
