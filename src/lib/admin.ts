/* ============================================================
   CONSTÂNCIA NA PALAVRA — Admins
   Quem pode LIBERAR acesso de cortesia (página /admin) e ganha
   acesso vitalício AUTOMÁTICO (sem precisar liberar pra si mesmo).
   A lista de admins vem 100% da env ADMIN_EMAILS (CSV), configurada
   no ambiente (Vercel) — sem e-mails hardcoded (repositório público).
   ============================================================ */

const DEFAULT_ADMINS: string[] = [];

export const ADMIN_EMAILS = (process.env.ADMIN_EMAILS ?? DEFAULT_ADMINS.join(","))
  .split(",")
  .map((e) => e.trim().toLowerCase())
  .filter(Boolean);

/** True se o e-mail está na lista de admins. */
export function ehAdmin(email?: string | null): boolean {
  return !!email && ADMIN_EMAILS.includes(email.toLowerCase());
}
