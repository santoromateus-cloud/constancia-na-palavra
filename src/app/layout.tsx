import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Constância na Palavra — sua leitura da Bíblia, um dia de cada vez",
  description:
    "Constância acompanhada na leitura da Bíblia. Uma passagem por dia, sua sequência que cresce e a companhia das irmãs — pra você não parar mais no mês 2.",
  openGraph: {
    title: "Constância na Palavra",
    description: "Sua leitura da Bíblia, um dia de cada vez — com as irmãs.",
    type: "website",
  },
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="pt-BR">
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link
          href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;500;600;700;900&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet"
        />
      </head>
      <body>{children}</body>
    </html>
  );
}
