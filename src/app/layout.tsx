import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  metadataBase: new URL("https://www.constancianapalavra.com.br"),
  title: "Constância na Palavra — sua leitura da Bíblia, um dia de cada vez",
  description:
    "Constância acompanhada na leitura da Bíblia. Uma passagem por dia, sua sequência que cresce e a companhia das irmãs — pra você não parar mais no mês 2.",
  openGraph: {
    title: "Constância na Palavra",
    description: "Sua leitura da Bíblia, um dia de cada vez — com as irmãs.",
    type: "website",
  },
  twitter: { card: "summary_large_image" },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pt-BR">
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link
          href="https://fonts.googleapis.com/css2?family=Gloock&family=Lora:ital,wght@0,400..700;1,400..700&family=Work+Sans:wght@400..800&display=swap"
          rel="stylesheet"
        />
      </head>
      <body>{children}</body>
    </html>
  );
}
