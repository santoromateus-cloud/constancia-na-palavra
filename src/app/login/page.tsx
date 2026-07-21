"use client";

import { useState, type FormEvent } from "react";
import { createClient } from "@/lib/supabase";

// Google OAuth ainda nao esta configurado no Supabase (provider desligado).
// Religar na fase da venda: configurar o provider e trocar para true.
const GOOGLE_LOGIN = false;

export default function Login() {
  const [loading, setLoading] = useState(false);
  const [mode, setMode] = useState<"entrar" | "criar">("entrar");
  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [erro, setErro] = useState("");
  const [msg, setMsg] = useState("");
  const [carregando, setCarregando] = useState(false);

  function traduzErro(m: string): string {
    const s = (m || "").toLowerCase();
    if (s.includes("invalid login")) return "E-mail ou senha incorretos.";
    if (s.includes("already registered") || s.includes("already been registered")) return "Esse e-mail já tem conta. É só entrar.";
    if (s.includes("at least 6") || s.includes("password should")) return "A senha precisa ter pelo menos 6 caracteres.";
    if (s.includes("email not confirmed")) return "Confirme seu e-mail antes de entrar (veja a caixa de entrada).";
    if (s.includes("invalid email") || s.includes("unable to validate")) return "E-mail inválido.";
    return "Não deu pra concluir. Confira os dados e tente de novo.";
  }

  async function entrarEmail(e: FormEvent) {
    e.preventDefault();
    setErro(""); setMsg("");
    if (senha.length < 6) { setErro("A senha precisa ter pelo menos 6 caracteres."); return; }
    setCarregando(true);
    const supabase = createClient();
    try {
      if (mode === "criar") {
        const { data, error } = await supabase.auth.signUp({ email: email.trim(), password: senha });
        if (error) { setErro(traduzErro(error.message)); return; }
        if (data.session) { window.location.href = "/ler"; return; }
        setMsg("Conta criada! Se pedirmos confirmação por e-mail, confirme e volte aqui pra entrar.");
        setMode("entrar"); setSenha("");
      } else {
        const { error } = await supabase.auth.signInWithPassword({ email: email.trim(), password: senha });
        if (error) { setErro(traduzErro(error.message)); return; }
        window.location.href = "/ler";
      }
    } catch {
      setErro("Algo deu errado. Tenta de novo.");
    } finally {
      setCarregando(false);
    }
  }

  async function entrarComGoogle() {
    setLoading(true);
    const supabase = createClient();
    await supabase.auth.signInWithOAuth({
      provider: "google",
      options: { redirectTo: `${window.location.origin}/api/auth/callback?next=/ler` },
    });
  }

  return (
    <main className="login-split">
      <div className="login-photo">
        <div className="lp-quote">
          <p>“Lâmpada para os meus pés é a tua palavra, e luz para o meu caminho.”</p>
          <span>Salmos 119:105</span>
        </div>
      </div>

      <div className="login-card-wrap">
        <div className="login-card">
          <a href="/" className="lc-logo">
            <svg width="40" height="40" viewBox="0 0 64 64"><rect width="64" height="64" rx="16" fill="#3A2E1D" /><rect x="16" y="34" width="9" height="16" rx="4.5" fill="#E8D9AE" /><rect x="27.5" y="26" width="9" height="24" rx="4.5" fill="#C9A85C" /><rect x="39" y="16" width="9" height="34" rx="4.5" fill="#6A7A42" /></svg>
            <b>Constância na Palavra</b>
          </a>
          <h1>{mode === "criar" ? "Criar sua conta." : "Bem-vinda de volta."}</h1>
          <p className="lc-sub">Entre pra continuar sua leitura da Bíblia, um dia de cada vez.</p>

          <form className="em-form" onSubmit={entrarEmail}>
            <input
              type="email" className="em-input" placeholder="Seu e-mail" value={email}
              onChange={(e) => setEmail(e.target.value)} autoComplete="email" required
            />
            <input
              type="password" className="em-input" placeholder="Sua senha (mín. 6 caracteres)" value={senha}
              onChange={(e) => setSenha(e.target.value)}
              autoComplete={mode === "criar" ? "new-password" : "current-password"} required
            />
            {erro && <p className="em-err">{erro}</p>}
            {msg && <p className="em-msg">{msg}</p>}
            <button type="submit" className="em-btn" disabled={carregando || !email.trim() || !senha}>
              {carregando ? "Aguarde…" : mode === "criar" ? "Criar conta e entrar" : "Entrar"}
            </button>
          </form>

          <button type="button" className="em-toggle" onClick={() => { setErro(""); setMsg(""); setMode(mode === "criar" ? "entrar" : "criar"); }}>
            {mode === "criar" ? "Já tenho conta — entrar" : "Ainda não tenho conta — criar agora"}
          </button>

          {GOOGLE_LOGIN && (<>
          <div className="em-ou"><span>ou</span></div>

          <button className="g-btn" onClick={entrarComGoogle} disabled={loading}>
            <svg width="20" height="20" viewBox="0 0 48 48" aria-hidden="true">
              <path fill="#FFC107" d="M43.6 20.5H42V20H24v8h11.3c-1.6 4.7-6.1 8-11.3 8-6.6 0-12-5.4-12-12s5.4-12 12-12c3.1 0 5.9 1.2 8 3.1l5.7-5.7C34.6 4.1 29.6 2 24 2 11.8 2 2 11.8 2 24s9.8 22 22 22 22-9.8 22-22c0-1.3-.1-2.3-.4-3.5z" />
              <path fill="#FF3D00" d="M6.3 14.7l6.6 4.8C14.7 16 19 13 24 13c3.1 0 5.9 1.2 8 3.1l5.7-5.7C34.6 4.1 29.6 2 24 2 15.4 2 7.9 6.9 6.3 14.7z" />
              <path fill="#4CAF50" d="M24 46c5.5 0 10.4-2.1 14.1-5.5l-6.5-5.5C29.6 36.7 26.9 38 24 38c-5.2 0-9.6-3.3-11.3-7.9l-6.5 5C7.7 41 15.2 46 24 46z" />
              <path fill="#1976D2" d="M43.6 20.5H42V20H24v8h11.3c-.8 2.2-2.2 4.2-4.1 5.6l6.5 5.5C40.9 36.3 46 30.9 46 24c0-1.3-.1-2.3-.4-3.5z" />
            </svg>
            {loading ? "Redirecionando…" : "Entrar com Google"}
          </button>
          </>)}

          <p className="lc-mini">Sua caminhada na Palavra começa aqui. Um dia de cada vez.</p>
          <a href="/" className="lc-skip">← Voltar ao início</a>
        </div>
      </div>

      <style jsx>{`
        .login-split{display:grid;grid-template-columns:1fr 1fr;min-height:100vh}
        .login-photo{position:relative;overflow:hidden;background:linear-gradient(160deg,#3A2E1D 0%,#2E2416 60%,#251C10 100%)}
        .login-photo::after{content:"";position:absolute;inset:0;background:radial-gradient(120% 90% at 20% 0%, rgba(201,168,92,.20), transparent 55%)}
        .lp-quote{position:absolute;left:36px;bottom:36px;right:36px;z-index:2;color:#FCF8EF}
        .lp-quote p{font-family:var(--serif);font-size:clamp(20px,2vw,28px);font-style:italic;line-height:1.35;max-width:26ch}
        .lp-quote span{display:block;margin-top:12px;font-size:13px;font-weight:700;letter-spacing:.5px;color:var(--areia)}
        .login-card-wrap{display:flex;align-items:center;justify-content:center;padding:clamp(24px,5vw,60px)}
        .login-card{width:100%;max-width:380px}
        .lc-logo{display:flex;align-items:center;gap:11px;margin-bottom:28px}
        .lc-logo b{font-family:var(--serif);font-size:20px}
        .login-card h1{font-size:clamp(28px,3.4vw,38px);line-height:1.05}
        .lc-sub{color:#6C5C45;font-size:15px;margin-top:12px;line-height:1.5}
        .em-form{display:flex;flex-direction:column;gap:10px;margin-top:24px}
        .em-input{width:100%;border:1px solid #E0D5BD;border-radius:14px;padding:14px;font-family:var(--sans);font-size:15px;color:var(--ink);background:var(--paper)}
        .em-input:focus{outline:none;border-color:var(--coral)}
        .em-btn{width:100%;background:var(--coral);color:#FCF8EF;border:none;border-radius:14px;padding:15px;font-family:var(--sans);font-weight:700;font-size:15px;cursor:pointer;transition:.2s;margin-top:4px}
        .em-btn:hover:not(:disabled){background:#47512C;transform:translateY(-1px)}
        .em-btn:disabled{opacity:.5;cursor:not-allowed}
        .em-err{font-size:13px;color:#a83c2c;background:#F9EBE3;border:1px solid #E9CDB9;border-radius:10px;padding:9px 12px;line-height:1.4;margin:0}
        .em-msg{font-size:13px;color:#4E5A2E;background:#F1F0E0;border:1px solid #D8D6B4;border-radius:10px;padding:9px 12px;line-height:1.4;margin:0}
        .em-toggle{background:none;border:none;color:var(--coral);font-family:var(--sans);font-weight:600;font-size:14px;cursor:pointer;margin-top:14px;padding:0}
        .em-toggle:hover{text-decoration:underline}
        .em-ou{display:flex;align-items:center;text-align:center;margin:22px 0 4px;color:var(--muted)}
        .em-ou::before,.em-ou::after{content:"";flex:1;height:1px;background:#E0D5BD}
        .em-ou span{padding:0 12px;font-size:12px}
        .g-btn{width:100%;margin-top:14px;display:flex;align-items:center;justify-content:center;gap:12px;background:var(--paper);border:1px solid #E0D5BD;color:var(--ink);font-family:var(--sans);font-weight:600;font-size:15px;border-radius:14px;padding:15px;cursor:pointer;box-shadow:var(--shadow-sm);transition:.2s}
        .g-btn:hover:not(:disabled){transform:translateY(-2px);box-shadow:var(--shadow)}
        .g-btn:disabled{opacity:.6;cursor:default}
        .lc-mini{font-size:12px;color:var(--muted);margin-top:16px;line-height:1.5}
        .lc-skip{display:inline-block;margin-top:20px;font-size:14px;color:var(--coral);font-weight:600}
        .lc-skip:hover{text-decoration:underline}
        @media(max-width:760px){.login-split{grid-template-columns:1fr}.login-photo{min-height:30vh}}
      `}</style>
    </main>
  );
}
