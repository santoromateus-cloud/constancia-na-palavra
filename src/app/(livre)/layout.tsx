import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase-server";
import { ensurePerfil, temAcesso } from "@/lib/quota";
import AppNav from "../(app)/AppNav";

// Layout da CAMADA GRÁTIS (route group (livre) → /biblia).
// Diferença crucial pro (app): aqui o gate é só SESSÃO. Quem tem conta entra,
// pagando ou não. A Bíblia e o progresso dela nunca ficam atrás do paywall.
export const dynamic = "force-dynamic";

export default async function LivreLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  const perfil = await ensurePerfil(user.id, user.email);

  return (
    <>
      <AppNav pago={temAcesso(perfil)} />
      {children}
    </>
  );
}
