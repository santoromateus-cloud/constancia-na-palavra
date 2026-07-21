"use client";

/* ============================================================
   FALA SEM TRAVA — /admin
   Só admin vê (flag `admin` do /api/perfil; APIs re-checam no servidor).
   Duas seções: (1) Liberar acesso em massa (cola e-mails, escolhe plano);
   (2) Usuários — lista todo mundo e troca/cancela o plano por pessoa.
   Estilo inline + classes globais .btn (garante render).
   ============================================================ */

import { useCallback, useEffect, useMemo, useState, type ReactNode, type CSSProperties } from "react";

type Perfil = { logado: boolean; admin?: boolean; email?: string | null } | null;
type PlanoId = "mensal" | "vitalicio";
type Res = { liberados: string[]; invalidos: string[]; falhas: string[]; plano?: string } | null;
type Usuario = { email: string; plano: string; status: string | null; origem: string };

const C = {
  ink: "#251C10", base: "#3A2E1D", coral: "#556036", areia: "#E8D9AE",
  creme: "#F5EFE2", verde: "#6A7A42", muted: "#8B7A61", line: "#E5DBC6", paper: "#FCF8EF",
  serif: '"Lora","Georgia",serif', sans: '"Work Sans",system-ui,sans-serif',
};

const PLANOS: { id: PlanoId; nome: string; desc: string }[] = [
  { id: "vitalicio", nome: "Vitalício", desc: "acesso pra sempre" },
  { id: "mensal", nome: "Mensal", desc: "acesso mensal" },
];
const PLANO_INFO: Record<string, { nome: string; cor: string; bg: string }> = {
  free: { nome: "Grátis", cor: "#8B7A61", bg: "#f0efea" },
  mensal: { nome: "Mensal", cor: "#4E5A2E", bg: "#e8f5f1" },
  vitalicio: { nome: "Vitalício", cor: "#b8562f", bg: "#fdeee6" },
};
const info = (p: string) => PLANO_INFO[p] ?? PLANO_INFO.free;
const nomePlano = (id?: string) => info(id ?? "free").nome;

const ACOES: { id: string; rot: string }[] = [
  { id: "mensal", rot: "Mensal" },
  { id: "vitalicio", rot: "Vitalício" },
  { id: "free", rot: "Cancelar" },
];

const RX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

function Logo() {
  return (
    <a href="/" style={{ display: "inline-flex", alignItems: "center", gap: 11, marginBottom: 22 }}>
      <svg width="34" height="34" viewBox="0 0 64 64"><rect width="64" height="64" rx="16" fill="#3A2E1D" /><rect x="16" y="34" width="9" height="16" rx="4.5" fill="#E8D9AE" /><rect x="27.5" y="26" width="9" height="24" rx="4.5" fill="#C9A85C" /><rect x="39" y="16" width="9" height="34" rx="4.5" fill="#6A7A42" /></svg>
      <b style={{ fontFamily: C.serif, fontSize: 18, color: C.ink }}>Constância na Palavra</b>
    </a>
  );
}

function Callout({ cor, fundo, borda, children }: { cor: string; fundo: string; borda: string; children: ReactNode }) {
  return (
    <div style={{ fontSize: 14, color: cor, background: fundo, border: `1px solid ${borda}`, borderRadius: 14, padding: "12px 15px", lineHeight: 1.5 }}>
      {children}
    </div>
  );
}

function Badge({ plano }: { plano: string }) {
  const i = info(plano);
  return <span style={{ fontSize: 12, fontWeight: 700, color: i.cor, background: i.bg, borderRadius: 999, padding: "3px 10px", whiteSpace: "nowrap" }}>{i.nome}</span>;
}

export default function Admin() {
  const [perfil, setPerfil] = useState<Perfil>(null);
  const [emails, setEmails] = useState("");
  const [plano, setPlano] = useState<PlanoId>("vitalicio");
  const [foco, setFoco] = useState(false);
  const [enviando, setEnviando] = useState(false);
  const [res, setRes] = useState<Res>(null);
  const [erro, setErro] = useState("");

  const [usuarios, setUsuarios] = useState<Usuario[]>([]);
  const [carregandoU, setCarregandoU] = useState(false);
  const [busca, setBusca] = useState("");
  const [acaoEm, setAcaoEm] = useState<string | null>(null);

  useEffect(() => {
    fetch("/api/perfil").then((r) => r.json()).then(setPerfil).catch(() => setPerfil({ logado: false }));
  }, []);

  const carregarUsuarios = useCallback(() => {
    setCarregandoU(true);
    fetch("/api/admin/usuarios")
      .then((r) => (r.ok ? r.json() : { usuarios: [] }))
      .then((d) => setUsuarios(d.usuarios ?? []))
      .catch(() => setUsuarios([]))
      .finally(() => setCarregandoU(false));
  }, []);

  useEffect(() => {
    if (perfil?.admin) carregarUsuarios();
  }, [perfil?.admin, carregarUsuarios]);

  const validos = useMemo(
    () => [...new Set(emails.split(/[\s,;]+/).map((e) => e.trim().toLowerCase()).filter((e) => RX.test(e)))],
    [emails],
  );

  const filtrados = useMemo(() => {
    const q = busca.trim().toLowerCase();
    return q ? usuarios.filter((u) => u.email.includes(q)) : usuarios;
  }, [usuarios, busca]);

  async function liberar() {
    setErro(""); setRes(null); setEnviando(true);
    try {
      const r = await fetch("/api/admin/liberar", {
        method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ emails, plano }),
      });
      if (r.status === 403) { setErro("Você não tem permissão de admin."); return; }
      const d = await r.json();
      setRes({ liberados: d.liberados ?? [], invalidos: d.invalidos ?? [], falhas: d.falhas ?? [], plano: d.plano });
      if ((d.liberados ?? []).length) { setEmails(""); carregarUsuarios(); }
    } catch { setErro("Falha ao liberar. Tenta de novo."); }
    finally { setEnviando(false); }
  }

  async function mudarPlano(email: string, novo: string) {
    setAcaoEm(email);
    try {
      const r = await fetch("/api/admin/liberar", {
        method: "POST", headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ emails: email, plano: novo }),
      });
      if (r.ok) setUsuarios((us) => us.map((u) => (u.email === email ? { ...u, plano: novo } : u)));
    } catch { /* silencioso — o estado não muda se falhar */ }
    finally { setAcaoEm(null); }
  }

  const card: CSSProperties = {
    background: C.paper, border: `1px solid ${C.line}`, borderRadius: 22,
    padding: "clamp(22px,4vw,34px)", boxShadow: "0 14px 44px -16px rgba(54,42,28,.14)",
  };

  let corpo: ReactNode;

  if (perfil === null) {
    corpo = <section style={card}><p style={{ color: C.muted }}>Carregando…</p></section>;
  } else if (!perfil.logado) {
    corpo = (
      <section style={card}>
        <h1 style={{ fontFamily: C.serif, fontSize: 26, color: C.base, margin: "0 0 8px" }}>Entre primeiro</h1>
        <p style={{ color: "#6C5C45", fontSize: 15, lineHeight: 1.55, marginBottom: 18 }}>Esta área é só pra administradores logados.</p>
        <a className="btn btn-primary" href="/login" style={{ width: "100%", justifyContent: "center" }}>Fazer login</a>
      </section>
    );
  } else if (!perfil.admin) {
    corpo = (
      <section style={card}>
        <h1 style={{ fontFamily: C.serif, fontSize: 26, color: C.base, margin: "0 0 8px" }}>Acesso restrito</h1>
        <p style={{ color: "#6C5C45", fontSize: 15, lineHeight: 1.55, marginBottom: 18 }}>Esta área é só pra administradores.</p>
        <a className="btn btn-ghost" href="/ler">← voltar à leitura</a>
      </section>
    );
  } else {
    corpo = (
      <div style={{ display: "flex", flexDirection: "column", gap: 20 }}>
        {/* ---- 1. Liberar acesso em massa ---- */}
        <section style={card}>
          <span className="kick">Acesso</span>
          <h1 style={{ fontFamily: C.serif, fontSize: "clamp(25px,4.2vw,32px)", color: C.base, margin: "10px 0 8px", letterSpacing: "-.02em" }}>
            Liberar acesso
          </h1>
          <p style={{ color: "#6C5C45", fontSize: 15, lineHeight: 1.55, margin: "0 0 18px" }}>
            Escolha o plano, cole os e-mails (um por linha ou por vírgula) e libere de cortesia.
          </p>

          <div style={{ fontSize: 13, fontWeight: 700, color: C.base, marginBottom: 9 }}>Qual plano liberar?</div>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10, marginBottom: 16 }}>
            {PLANOS.map((p) => {
              const on = plano === p.id;
              return (
                <button
                  key={p.id} type="button" onClick={() => setPlano(p.id)}
                  style={{
                    textAlign: "left", cursor: "pointer", borderRadius: 14, padding: "12px 14px",
                    border: `1.5px solid ${on ? C.coral : C.line}`,
                    background: on ? "rgba(85,96,54,.08)" : C.paper, transition: ".16s", font: "inherit",
                  }}
                >
                  <div style={{ display: "flex", alignItems: "center", gap: 8, fontWeight: 700, fontSize: 15, color: on ? C.coral : C.ink }}>
                    <span style={{ width: 16, height: 16, borderRadius: "50%", border: `2px solid ${on ? C.coral : C.line}`, display: "inline-flex", alignItems: "center", justifyContent: "center", flex: "0 0 auto" }}>
                      {on && <span style={{ width: 7, height: 7, borderRadius: "50%", background: C.coral }} />}
                    </span>
                    {p.nome}
                  </div>
                  <div style={{ fontSize: 12.5, color: C.muted, marginTop: 5, marginLeft: 24 }}>{p.desc}</div>
                </button>
              );
            })}
          </div>

          <textarea
            value={emails}
            onChange={(e) => setEmails(e.target.value)}
            onFocus={() => setFoco(true)}
            onBlur={() => setFoco(false)}
            placeholder={"aluno@exemplo.com\nprofessora@exemplo.com"}
            rows={4}
            style={{
              width: "100%", borderRadius: 16, border: `1.5px solid ${foco ? C.coral : C.line}`,
              padding: "13px 15px", fontFamily: C.sans, fontSize: 15, color: C.ink,
              background: C.creme, resize: "vertical", minHeight: 96, lineHeight: 1.6,
              outline: "none", transition: "border-color .18s",
            }}
          />
          <button
            className="btn btn-primary"
            onClick={liberar}
            disabled={enviando || validos.length === 0}
            style={{ width: "100%", justifyContent: "center", marginTop: 12, opacity: enviando || validos.length === 0 ? 0.5 : 1, cursor: enviando || validos.length === 0 ? "not-allowed" : "pointer" }}
          >
            {enviando ? "Liberando…" : `Liberar ${validos.length > 1 ? `${validos.length} acessos` : "acesso"} · ${nomePlano(plano)}`}
          </button>

          {(erro || res) && (
            <div style={{ marginTop: 16, display: "flex", flexDirection: "column", gap: 10 }}>
              {erro && <Callout cor="#a83c2c" fundo="#F9EBE3" borda="#E9CDB9">{erro}</Callout>}
              {res && res.liberados.length > 0 && (
                <Callout cor="#4E5A2E" fundo="#F1F0E0" borda="#D8D6B4">
                  <b>✓ {res.liberados.length} acesso{res.liberados.length > 1 ? "s" : ""} {nomePlano(res.plano)} liberado{res.liberados.length > 1 ? "s" : ""}</b>
                </Callout>
              )}
              {res && res.invalidos.length > 0 && (
                <Callout cor="#8a6d3b" fundo="#fff8ec" borda="#f0e0c0">Ignorados (formato inválido): {res.invalidos.join(", ")}</Callout>
              )}
            </div>
          )}
        </section>

        {/* ---- 2. Usuários ---- */}
        <section style={card}>
          <div style={{ display: "flex", alignItems: "baseline", justifyContent: "space-between", gap: 10, flexWrap: "wrap" }}>
            <h2 style={{ fontFamily: C.serif, fontSize: "clamp(21px,3.4vw,26px)", color: C.base, margin: 0 }}>Usuários</h2>
            <span style={{ fontSize: 13, color: C.muted }}>{usuarios.length} no total</span>
          </div>
          <p style={{ color: "#6C5C45", fontSize: 14, lineHeight: 1.5, margin: "6px 0 14px" }}>
            Veja todo mundo e troque ou cancele o plano de cada um. Muda na hora.
          </p>

          <input
            value={busca}
            onChange={(e) => setBusca(e.target.value)}
            placeholder="Buscar por e-mail…"
            style={{ width: "100%", borderRadius: 12, border: `1.5px solid ${C.line}`, padding: "11px 14px", fontFamily: C.sans, fontSize: 14, color: C.ink, background: C.creme, outline: "none", marginBottom: 12 }}
          />

          {carregandoU ? (
            <p style={{ color: C.muted, fontSize: 14 }}>Carregando usuários…</p>
          ) : filtrados.length === 0 ? (
            <p style={{ color: C.muted, fontSize: 14 }}>{usuarios.length === 0 ? "Ninguém por aqui ainda." : "Nenhum e-mail com esse trecho."}</p>
          ) : (
            <div style={{ display: "flex", flexDirection: "column", gap: 8, maxHeight: 420, overflowY: "auto", margin: "0 -4px", padding: "0 4px" }}>
              {filtrados.map((u) => (
                <div key={u.email} style={{ border: `1px solid ${C.line}`, borderRadius: 14, padding: "12px 14px", background: C.paper }}>
                  <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", gap: 10, flexWrap: "wrap" }}>
                    <span style={{ fontSize: 14, color: C.ink, fontWeight: 600, wordBreak: "break-all" }}>{u.email}</span>
                    <Badge plano={u.plano} />
                  </div>
                  <div style={{ display: "flex", gap: 6, flexWrap: "wrap", marginTop: 10 }}>
                    {ACOES.map((a) => {
                      const atual = u.plano === a.id || (a.id === "free" && (u.plano === "free" || !u.plano));
                      const cancelar = a.id === "free";
                      return (
                        <button
                          key={a.id}
                          type="button"
                          onClick={() => !atual && mudarPlano(u.email, a.id)}
                          disabled={atual || acaoEm === u.email}
                          style={{
                            font: "inherit", fontSize: 12.5, fontWeight: 600, borderRadius: 9, padding: "6px 11px",
                            cursor: atual || acaoEm === u.email ? "default" : "pointer",
                            border: `1px solid ${atual ? C.coral : cancelar ? "#e6cfca" : C.line}`,
                            background: atual ? "rgba(85,96,54,.10)" : "transparent",
                            color: atual ? C.coral : cancelar ? "#a83c2c" : C.base,
                            opacity: acaoEm === u.email && !atual ? 0.5 : 1,
                          }}
                        >
                          {atual ? `✓ ${a.rot}` : a.rot}
                        </button>
                      );
                    })}
                  </div>
                </div>
              ))}
            </div>
          )}
        </section>
      </div>
    );
  }

  return (
    <main style={{ minHeight: "100vh", display: "flex", flexDirection: "column", alignItems: "center", padding: "clamp(30px,7vw,64px) 20px 60px" }}>
      <div style={{ width: "100%", maxWidth: 560 }}>
        <Logo />
        {corpo}
        {perfil?.admin && (
          <div style={{ marginTop: 18 }}>
            <a className="btn btn-ghost" href="/ler">← voltar à leitura</a>
          </div>
        )}
      </div>
    </main>
  );
}
