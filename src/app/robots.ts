import type { MetadataRoute } from "next";

/* Padrão SEO da casa (§39, 23/11/2026). Páginas públicas abertas para
   Google, Bing, ChatGPT e Perplexity; as telas de quem está logada
   (leitura, caderno, mural, planos, conta, painel) ficam fora da busca. */
export default function robots(): MetadataRoute.Robots {
  return {
    rules: [
      {
        userAgent: "*",
        allow: "/",
        disallow: ["/admin", "/api", "/conta", "/biblia", "/ler", "/caderno", "/mural", "/planos", "/raio-x"],
      },
    ],
    sitemap: "https://www.constancianapalavra.com.br/sitemap.xml",
  };
}
