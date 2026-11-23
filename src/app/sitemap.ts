import type { MetadataRoute } from "next";

/* Padrão SEO da casa (§39, 23/11/2026): só as páginas públicas.
   Página pública nova entra aqui com a data da última mudança. */
const BASE = "https://www.constancianapalavra.com.br";

export default function sitemap(): MetadataRoute.Sitemap {
  const atualizado = new Date("2026-11-23");
  return [
    { url: `${BASE}/`, lastModified: atualizado },
    { url: `${BASE}/pricing`, lastModified: atualizado },
  ];
}
