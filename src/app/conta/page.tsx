import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase-server";
import { supabaseAdmin } from "@/lib/supabase-admin";
import { ensurePerfil, temAcesso } from "@/lib/quota";
import SairButton from "./SairButton";

export const metadata = { title: "Minha conta — Constância na Palavra" };
export const dynamic = "force-dynamic";

const NOME_PLANO: Record<string, string> = {
  free: "Grátis",
  mensal: "Mensal",
  vitalicio: "Vitalício",
};

const NOME_STATUS: Record<string, string> = {
  active: "ativa",
  cancelled: "cancelada",
  refunded: "reembolsada",
  overdue: "pagamento pendente",
};

export default async function Conta() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) redirect("/login");

  // e-mail junto: se a ficha ainda não existe, o ensurePerfil cria JÁ sincronizada
  // com a assinatura Hotmart (senão nasceria 'free' mesmo pra quem pagou).
  const perfil = await ensurePerfil(user.id, user.email);
  const { data: perfilDb } = await supabaseAdmin
    .from("perfis")
    .select("assinatura_status")
    .eq("id", user.id)
    .maybeSingle();

  const plano = perfil.plano ?? "free";
  const pago = temAcesso(perfil);
  const status = perfilDb?.assinatura_status ?? null;

  return (
    <main className="conta-wrap">
      <header className="conta-head">
        <a className="conta-logo" href="/">
          <svg width="34" height="34" viewBox="0 0 64 64">
            <rect width="64" height="64" rx="16" fill="#3A2E1D" />
            <rect x="16" y="34" width="9" height="16" rx="4.5" fill="#E8D9AE" />
            <rect x="27.5" y="26" width="9" height="24" rx="4.5" fill="#C9A85C" />
            <rect x="39" y="16" width="9" height="34" rx="4.5" fill="#6A7A42" />
          </svg>
          <b>Constância na Palavra</b>
        </a>
      </header>

      <section className="conta-card">
        <h1>Minha conta</h1>

        <div className="conta-linha">
          <span className="conta-rotulo">E-mail</span>
          <span className="conta-valor">{user.email}</span>
        </div>

        <div className="conta-linha">
          <span className="conta-rotulo">Plano</span>
          <span className="conta-valor">
            <b className={`conta-plano conta-plano-${plano}`}>{NOME_PLANO[plano] ?? plano}</b>
            {pago && status && (
              <span className={`conta-status conta-status-${status}`}>
                {NOME_STATUS[status] ?? status}
              </span>
            )}
          </span>
        </div>

        <div className="conta-linha">
          <span className="conta-rotulo">Acesso</span>
          <span className="conta-valor">{pago ? "Liberado" : "Sem plano ativo"}</span>
        </div>

        <div className="conta-acoes">
          {pago ? (
            <a className="conta-btn-treinar" href="/ler">Ir para a leitura de hoje</a>
          ) : (
            <a className="conta-btn-treinar conta-destaque" href="/pricing">Conhecer os planos</a>
          )}
        </div>

        <SairButton />

        <p className="conta-mini">
          {pago
            ? "Sua assinatura e os pagamentos são processados com segurança pela Hotmart — qualquer alteração chega no seu e-mail. "
            : "Você está no plano gratuito. Assine para acompanhar sua leitura todos os dias. "}
          Precisa de ajuda?{" "}
          <a href="mailto:ola@constancianapalavra.com.br">ola@constancianapalavra.com.br</a>
        </p>
      </section>

      <style>{`
        .conta-wrap{min-height:100vh;background:var(--base);padding:24px 18px 60px}
        .conta-head{max-width:560px;margin:0 auto 26px;display:flex;align-items:center}
        .conta-logo{display:flex;align-items:center;gap:10px;color:var(--ink)}
        .conta-logo b{font-family:var(--serif);font-size:18px}
        .conta-card{max-width:560px;margin:0 auto;background:var(--paper);border:1px solid #E0D5BD;border-radius:18px;padding:clamp(22px,4vw,36px);box-shadow:var(--shadow-sm)}
        .conta-card h1{font-family:var(--serif);font-size:clamp(26px,3vw,32px);margin-bottom:20px}
        .conta-linha{display:flex;justify-content:space-between;align-items:baseline;gap:16px;padding:13px 0;border-bottom:1px solid #eee7da;font-size:15px}
        .conta-rotulo{color:var(--muted);flex-shrink:0}
        .conta-valor{text-align:right;word-break:break-word}
        .conta-plano{font-weight:700}
        .conta-plano-vitalicio{color:var(--coral)}
        .conta-plano-mensal{color:#6A7A42}
        .conta-status{margin-left:8px;font-size:12px;padding:2px 9px;border-radius:99px;background:#eaf5f2;color:#6A7A42;white-space:nowrap}
        .conta-status-cancelled,.conta-status-overdue,.conta-status-refunded{background:#fdeeea;color:var(--coral)}
        .conta-acoes{display:grid;gap:10px;margin-top:24px}
        .conta-btn-treinar{display:block;text-align:center;background:var(--ink);color:#FCF8EF;font-weight:600;border-radius:14px;padding:14px;transition:.2s}
        .conta-btn-treinar:hover{transform:translateY(-2px);box-shadow:var(--shadow-sm)}
        .conta-destaque{background:var(--coral)}
        .conta-btn-sair{width:100%;margin-top:18px;background:none;border:none;color:var(--muted);font-family:var(--sans);font-size:14px;cursor:pointer;text-decoration:underline}
        .conta-btn-sair:disabled{opacity:.6;cursor:default}
        .conta-mini{margin-top:22px;font-size:12.5px;color:var(--muted);line-height:1.55}
        .conta-mini a{color:var(--coral);font-weight:600}
      `}</style>
    </main>
  );
}
