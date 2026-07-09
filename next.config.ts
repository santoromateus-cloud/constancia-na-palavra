import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  reactStrictMode: true,
  // TypeScript volta a barrar o build em erro de tipo (cookiesToSet tipado em 30/06/2026;
  // `tsc --noEmit` e `next build` validados limpos antes de religar).
  typescript: { ignoreBuildErrors: false },
  // ESLint segue ignorado no build: o projeto ainda nao tem ESLint configurado
  // (sem eslint-config-next nem .eslintrc). Religar = tarefa a parte (add deps + config).
  eslint: { ignoreDuringBuilds: true },
};

export default nextConfig;
