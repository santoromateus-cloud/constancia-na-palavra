import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase-server";
import { ensurePerfil, temAcesso } from "@/lib/quota";
import AppNav from "./AppNav";

// Layout da ÁREA PAGA (route group (app) → /ler, /planos, /mural).
// Gate SERVER-SIDE feito uma vez pra todas as telas:
//   sem sessão      → /login
//   sem plano ativo → /biblia (a camada grátis). Desde o freemium de 01/09 não
//                     existe mais beco sem saída: quem não paga tem produto de
//                     verdade, e a oferta aparece DENTRO dele e em /pricing.
//   com plano       → nav + conteúdo
export const dynamic = "force-dynamic";

export default async function AppLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const perfil = await ensurePerfil(user.id, user.email);
  if (!temAcesso(perfil)) redirect("/biblia");

  return (
    <>
      <AppNav pago />
      {children}
    </>
  );
}
