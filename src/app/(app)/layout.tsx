import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase-server";
import { ensurePerfil, temAcesso } from "@/lib/quota";
import Paywall from "./Paywall";
import AppNav from "./AppNav";

// Layout da ÁREA LOGADA (route group (app) → /ler, /planos, /mural).
// Gate SERVER-SIDE feito uma vez pra todas as telas:
//   sem sessão      → /login
//   sem plano ativo → <Paywall/> (assinatura)
//   com plano       → nav + conteúdo
export const dynamic = "force-dynamic";

export default async function AppLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const perfil = await ensurePerfil(user.id, user.email);
  if (!temAcesso(perfil)) return <Paywall />;

  return (
    <>
      <AppNav />
      {children}
    </>
  );
}
