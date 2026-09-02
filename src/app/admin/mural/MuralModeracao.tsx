"use client";

/* ============================================================
   CURADORIA DO MURAL — a tela da Elisângela
   Uma fila e dois botões. Ela lê, publica ou deixa passar.

   Regras que valem para esta tela:
     - nada é apagado. "Não publicar" guarda o recado e some do mural; o
       recado de uma mulher não vira lixo por decisão de tela.
     - a autora aparece pelo e-mail, para ela reconhecer quem já escreveu.
     - o que já está no ar tem um botão de tirar do ar: se algo passar num
       dia corrido, ela conserta em um toque, sem precisar de ninguém.
   ============================================================ */

import { useCallback, useEffect, useState, type CSSProperties } from "react";

type Post = {
  id: string;
  texto: string;
  referencia: string | null;
  criado_em: string;
  autora: string;
  daCasa: boolean;
  moderadoEm: string | null;
};

type Dados = { fila: Post[]; noAr: Post[]; recusados: Post[] };

const C = {
  ink: "#251C10", base: "#3A2E1D", coral: "#556036", areia: "#E8D9AE",
  creme: "#F5EFE2", verde: "#6A7A42", muted: "#8B7A61", line: "#E5DBC6", paper: "#FCF8EF",
  ouro: "#8F6D1E",
  serif: '"Lora","Georgia",serif', sans: '"Work Sans",system-ui,sans-serif',
};

const card: CSSProperties = {
  background: C.paper, border: `1px solid ${C.line}`, borderRadius: 18,
  padding: "20px 22px", marginBottom: 18, boxShadow: "0 1px 2px rgba(37,28,16,.05)",
};

const btn = (fundo: string, cor: string, borda: string): CSSProperties => ({
  background: fundo, color: cor, border: `1px solid ${borda}`, borderRadius: 999,
  padding: "8px 18px", fontFamily: C.sans, fontSize: 13.5, fontWeight: 700,
  cursor: "pointer", transition: ".18s",
});

function quando(iso: string): string {
  try {
    return new Date(iso).toLocaleString("pt-BR", {
      day: "2-digit", month: "short", hour: "2-digit", minute: "2-digit",
    });
  } catch {
    return "";
  }
}

function Recado({
  p, children,
}: { p: Post; children?: React.ReactNode }) {
  return (
    <article style={{ border: `1px solid ${C.line}`, borderRadius: 14, padding: "14px 16px", background: C.creme }}>
      <div style={{ display: "flex", justifyContent: "space-between", gap: 10, alignItems: "baseline", flexWrap: "wrap" }}>
        <b style={{ fontSize: 13, color: p.daCasa ? C.ouro : C.base }}>
          {p.daCasa ? "Elisângela (recado da casa)" : p.autora}
        </b>
        <span style={{ fontSize: 12, color: C.muted }}>{quando(p.criado_em)}</span>
      </div>
      {p.referencia && (
        <div style={{ fontFamily: C.serif, fontStyle: "italic", fontSize: 14, color: C.coral, marginTop: 6 }}>
          {p.referencia}
        </div>
      )}
      <p style={{ fontSize: 15, color: "#2b3440", lineHeight: 1.6, margin: "8px 0 12px", whiteSpace: "pre-line" }}>
        {p.texto}
      </p>
      {children}
    </article>
  );
}

export default function MuralModeracao() {
  const [dados, setDados] = useState<Dados | null>(null);
  const [erro, setErro] = useState("");
  const [ocupado, setOcupado] = useState<string | null>(null);
  const [verTudo, setVerTudo] = useState(false);

  const carregar = useCallback(() => {
    fetch("/api/admin/mural")
      .then((r) => (r.ok ? r.json() : Promise.reject()))
      .then((d: Dados) => { setDados(d); setErro(""); })
      .catch(() => setErro("Não consegui carregar a fila. Recarregue a página."));
  }, []);

  useEffect(() => { carregar(); }, [carregar]);

  async function agir(id: string, acao: "publicar" | "recusar" | "tirar") {
    setOcupado(id);
    try {
      const r = await fetch("/api/admin/mural", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id, acao }),
      });
      if (!r.ok) throw new Error();
      carregar();
    } catch {
      setErro("Não deu certo. Tente de novo.");
    } finally {
      setOcupado(null);
    }
  }

  const fila = dados?.fila ?? [];
  const noAr = dados?.noAr ?? [];
  const recusados = dados?.recusados ?? [];

  return (
    <main style={{ minHeight: "100vh", background: C.creme, padding: "30px 18px 70px", fontFamily: C.sans, color: C.ink }}>
      <div style={{ maxWidth: 720, margin: "0 auto" }}>
        <a href="/admin" style={{ fontSize: 13.5, color: C.coral, fontWeight: 600, textDecoration: "none" }}>
          ← Voltar para o painel
        </a>

        <h1 style={{ fontFamily: C.serif, fontSize: 30, margin: "16px 0 6px" }}>Curadoria do mural</h1>
        <p style={{ fontSize: 14.5, color: C.muted, lineHeight: 1.6, margin: "0 0 24px", maxWidth: "56ch" }}>
          Nada aparece para as irmãs antes de você ler. Quem escreveu vê o próprio
          recado marcado como “em análise” até você publicar.
        </p>

        {erro && (
          <div style={{ ...card, background: "#FBEFEF", borderColor: "#E7C9C9", color: "#8C3A3A", fontSize: 14 }}>
            {erro}
          </div>
        )}

        {/* ── A FILA ── */}
        <section style={card}>
          <header style={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", gap: 10, marginBottom: 14 }}>
            <h2 style={{ fontFamily: C.serif, fontSize: 20, margin: 0 }}>Esperando você</h2>
            <b style={{ fontSize: 13, color: fila.length > 0 ? C.ouro : C.muted, fontVariantNumeric: "tabular-nums" }}>
              {dados === null ? "…" : fila.length === 1 ? "1 recado" : `${fila.length} recados`}
            </b>
          </header>

          {dados === null ? (
            <p style={{ color: C.muted, fontSize: 14 }}>Carregando…</p>
          ) : fila.length === 0 ? (
            <p style={{ color: C.muted, fontSize: 14.5, lineHeight: 1.6, margin: 0 }}>
              Nenhum recado na fila. Está tudo lido.
            </p>
          ) : (
            <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
              {fila.map((p) => (
                <Recado key={p.id} p={p}>
                  <div style={{ display: "flex", gap: 10, flexWrap: "wrap" }}>
                    <button
                      onClick={() => agir(p.id, "publicar")}
                      disabled={ocupado === p.id}
                      style={btn(C.coral, "#FCF8EF", C.coral)}
                    >
                      {ocupado === p.id ? "…" : "Publicar no mural"}
                    </button>
                    <button
                      onClick={() => agir(p.id, "recusar")}
                      disabled={ocupado === p.id}
                      style={btn("transparent", C.muted, C.line)}
                    >
                      Não publicar
                    </button>
                  </div>
                </Recado>
              ))}
            </div>
          )}
        </section>

        {/* ── O QUE ESTÁ NO AR ── */}
        <section style={card}>
          <header style={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", gap: 10, marginBottom: 14 }}>
            <h2 style={{ fontFamily: C.serif, fontSize: 20, margin: 0 }}>No ar agora</h2>
            <b style={{ fontSize: 13, color: C.muted, fontVariantNumeric: "tabular-nums" }}>
              {dados === null ? "…" : `${noAr.length}`}
            </b>
          </header>

          {noAr.length === 0 ? (
            <p style={{ color: C.muted, fontSize: 14.5, margin: 0 }}>O mural ainda está vazio.</p>
          ) : (
            <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
              {(verTudo ? noAr : noAr.slice(0, 5)).map((p) => (
                <Recado key={p.id} p={p}>
                  <button
                    onClick={() => agir(p.id, "tirar")}
                    disabled={ocupado === p.id}
                    style={btn("transparent", C.muted, C.line)}
                  >
                    {ocupado === p.id ? "…" : "Tirar do ar"}
                  </button>
                </Recado>
              ))}
              {noAr.length > 5 && (
                <button
                  onClick={() => setVerTudo((v) => !v)}
                  style={{ ...btn("transparent", C.coral, C.line), alignSelf: "flex-start" }}
                >
                  {verTudo ? "Mostrar menos" : `Ver os outros ${noAr.length - 5}`}
                </button>
              )}
            </div>
          )}
        </section>

        {/* ── O QUE NÃO FOI PUBLICADO ── */}
        {recusados.length > 0 && (
          <section style={card}>
            <h2 style={{ fontFamily: C.serif, fontSize: 20, margin: "0 0 6px" }}>Não publicados</h2>
            <p style={{ fontSize: 13.5, color: C.muted, lineHeight: 1.6, margin: "0 0 14px" }}>
              Ficam guardados, só entre você e quem escreveu. Se mudar de ideia, pode publicar.
            </p>
            <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
              {recusados.map((p) => (
                <Recado key={p.id} p={p}>
                  <button
                    onClick={() => agir(p.id, "publicar")}
                    disabled={ocupado === p.id}
                    style={btn("transparent", C.coral, C.line)}
                  >
                    {ocupado === p.id ? "…" : "Publicar mesmo assim"}
                  </button>
                </Recado>
              ))}
            </div>
          </section>
        )}
      </div>
    </main>
  );
}
