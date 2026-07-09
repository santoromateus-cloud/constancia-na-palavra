import Link from "next/link";

/* ============================================================
   CONSTÂNCIA NA PALAVRA — Landing de conversão
   Server component. Reusa os tokens/classes do globals.css.
   Voz devocional e acolhedora (público feminino cristão).
   Sem IA. CTA principal → /pricing. Design é placeholder — o
   capricho visual vem numa fase posterior.
   ============================================================ */

export default function Home() {
  return (
    <>
      {/* faixa de pré-lançamento */}
      <div className="lp-band">
        <span className="dot" aria-hidden />
        <span>Pré-lançamento — preço de fundadoras. Vai subir em breve.</span>
      </div>

      {/* nav */}
      <nav className="lp-nav">
        <div className="in">
          <Link href="/" className="brand">Constância na Palavra</Link>
          <div className="links">
            <a className="nav-hide" href="#como">Como funciona</a>
            <a className="nav-hide" href="#planos">Planos</a>
            <Link href="/login" className="nav-hide">Entrar</Link>
            <Link href="/pricing" className="cta">Começar hoje</Link>
          </div>
        </div>
      </nav>

      {/* hero */}
      <main className="hero">
        <div className="hero-left">
          <span className="kick reveal d1">Sua leitura da Bíblia · um dia de cada vez</span>
          <h1 className="reveal d2">
            Não é falta de fé.<br />É que você lê <span className="tw">sozinha</span>.
          </h1>
          <p className="lead reveal d3">
            Constância na Palavra é a caminhada diária na Bíblia com acompanhamento e a
            companhia das irmãs. Uma passagem por dia, a sua sequência que cresce e um
            lugar pra não desistir — pra você não parar mais no mês 2.
          </p>
          <div className="cta-row reveal d4">
            <Link href="/pricing" className="btn btn-primary">Quero começar minha constância</Link>
            <Link href="/login" className="btn btn-google">Já sou membro</Link>
          </div>
          <div className="minfoot reveal d6" style={{ position: "static", marginTop: 26, flexWrap: "wrap", gap: "8px 18px" }}>
            <span>📖 5 minutos por dia bastam.</span>
            <span>📱 Funciona no celular e no PC, sem baixar nada.</span>
          </div>
        </div>
        <div className="hero-right reveal d2" style={{ display: "flex", alignItems: "center", justifyContent: "center", padding: "40px 28px" }}>
          <div className="hero-badge" style={{ position: "static", maxWidth: 340 }}>
            <div className="q">
              “Lâmpada para os meus pés é a tua palavra, e luz para o meu caminho.”
            </div>
            <div className="a"><span className="dot" /> Salmos 119:105</div>
          </div>
        </div>
      </main>

      {/* dor — a estatística do abandono */}
      <section className="lp-wrap">
        <div className="lp-head">
          <span className="kick lp-eyebrow">Talvez você se reconheça</span>
          <h2 className="lp-h2">
            8 em 10 mulheres que começam a ler a Bíblia <span className="lp-em">param no mês 2</span> — no Levítico.
          </h2>
          <p className="lp-sub">
            Não é preguiça e não é falta de amor pela Palavra. É que a leitura vira solitária,
            sem plano e sem ninguém do lado. Aí a genealogia chega, o dia aperta, e o
            marcador fica parado na mesma página por semanas.
          </p>
        </div>
        <div style={{ maxWidth: 720, margin: "0 auto", display: "flex", flexDirection: "column", gap: 12 }}>
          {[
            "“Amanhã eu retomo do ponto que parei.”",
            "“Já perdi tantos dias que nem sei por onde voltar.”",
            "“Começo animada e some no meio do Antigo Testamento.”",
            "“Queria ler com alguém, não sozinha.”",
          ].map((t) => (
            <div key={t} style={{ background: "var(--paper)", border: "1px solid var(--line)", borderRadius: 14, padding: "14px 18px", fontFamily: "var(--serif)", fontStyle: "italic", fontSize: "clamp(16px,2.2vw,20px)", color: "var(--base)", boxShadow: "var(--shadow-sm)" }}>
              {t}
            </div>
          ))}
        </div>
      </section>

      {/* faixa de números */}
      <section className="lp-wrap tight">
        <div className="lp-stats">
          <div className="lp-stat"><b>1</b><span>passagem por dia — nada de maratona</span></div>
          <div className="lp-stat"><b>5 min</b><span>é o que a leitura de hoje leva</span></div>
          <div className="lp-stat"><b>🔥</b><span>sua sequência que cresce a cada dia</span></div>
          <div className="lp-stat"><b>+ irmãs</b><span>você não caminha sozinha</span></div>
        </div>
      </section>

      {/* como funciona */}
      <section className="lp-wrap" id="como">
        <div className="lp-head">
          <span className="kick lp-eyebrow">Como funciona</span>
          <h2 className="lp-h2">Constância <span className="lp-em">acompanhada</span>. Um dia de cada vez.</h2>
          <p className="lp-sub">
            O segredo não é ler mais rápido. É voltar amanhã. E depois de amanhã. A gente
            transforma isso em algo leve, visível e com companhia.
          </p>
        </div>
        <div className="lp-steps">
          <div className="lp-step reveal d1">
            <div className="num">1</div>
            <h3>Abra a leitura do dia</h3>
            <p>Uma passagem escolhida pra você, com um fio que faz sentido. Sem escolher por onde começar.</p>
          </div>
          <div className="lp-step reveal d2">
            <div className="num">2</div>
            <h3>Leia com calma</h3>
            <p>Cinco minutos. Um versículo pra guardar. Um instante só seu com a Palavra.</p>
          </div>
          <div className="lp-step reveal d3">
            <div className="num">3</div>
            <h3>Marque “li hoje”</h3>
            <p>Um toque, e a sua sequência cresce. O que tem marca dá vontade de não quebrar.</p>
          </div>
          <div className="lp-step reveal d4">
            <div className="num">4</div>
            <h3>Caminhe com as irmãs</h3>
            <p>No mural da comunidade você vê que não está sozinha. É a companhia que segura a constância.</p>
          </div>
        </div>
      </section>

      {/* mecanismo — bloco escuro */}
      <section className="lp-wrap tight">
        <div className="lp-dark">
          <span className="kick lp-eyebrow">Por que funciona</span>
          <h2 className="lp-h2" style={{ marginTop: 14 }}>A força de vontade sozinha não segura. A companhia segura.</h2>
          <p className="lp-quote" style={{ marginTop: 18 }}>
            “Você já sabe que deveria ler todo dia. O que faltava não era mais um sermão —
            era um lugar simples que te lembra, te mostra o próximo passo e caminha ao seu lado.”
          </p>
        </div>
      </section>

      {/* planos */}
      <section className="lp-wrap" id="planos">
        <div className="lp-head">
          <span className="kick lp-eyebrow">Planos</span>
          <h2 className="lp-h2">Escolha como <span className="lp-em">começar</span>. Os dois abrem tudo.</h2>
          <p className="lp-sub">Mensal ou vitalício, o acesso é o mesmo: sua leitura diária, sua sequência e o mural das irmãs.</p>
        </div>
        <div className="lp-plans" style={{ maxWidth: 720, margin: "0 auto" }}>
          <div className="lp-plan reveal d1">
            <span className="tag">Mensal</span>
            <div className="price">R$39,90<small>/mês</small></div>
            <ul>
              <li>Sua leitura da Bíblia todos os dias</li>
              <li>A sequência que segura sua constância</li>
              <li>O mural da comunidade</li>
              <li>Cancele quando quiser</li>
            </ul>
            <Link href="/pricing" className="btn btn-google" style={{ justifyContent: "center" }}>Assinar o mensal →</Link>
          </div>
          <div className="lp-plan hot reveal d2">
            <span className="lp-badge-top">Acesso pra sempre</span>
            <span className="tag">Vitalício</span>
            <div className="price">R$397<small> uma vez</small></div>
            <ul>
              <li>Tudo do mensal</li>
              <li>Pago uma única vez, sem mensalidade</li>
              <li>Sua constância sem data pra acabar</li>
            </ul>
            <Link href="/pricing" className="btn btn-primary" style={{ justifyContent: "center" }}>Quero o vitalício →</Link>
          </div>
        </div>
        <div style={{ display: "flex", flexWrap: "wrap", justifyContent: "center", gap: "12px 26px", marginTop: 28, fontSize: 13, color: "var(--muted)" }}>
          <span>🔒 Pagamento seguro pela Hotmart</span>
          <span>↩️ Mensal: cancele quando quiser</span>
        </div>
      </section>

      {/* faq */}
      <section className="lp-wrap">
        <div className="lp-head">
          <span className="kick lp-eyebrow">Perguntas</span>
          <h2 className="lp-h2">Antes de começar</h2>
        </div>
        <div className="lp-faq">
          <details><summary>Preciso baixar alguma coisa?</summary><div className="ans">Não. Funciona no navegador do celular e do PC. Você abre, lê a passagem do dia e marca que leu.</div></details>
          <details><summary>E se eu já tenho o hábito de ler pela manhã?</summary><div className="ans">Melhor ainda. Aqui você mantém o seu ritmo, só que com a sua sequência visível e a companhia das irmãs pra não deixar cair.</div></details>
          <details><summary>Perdi vários dias. Consigo voltar?</summary><div className="ans">Sempre. A proposta é constância, não perfeição. Você retoma a leitura de hoje e segue de onde está — um dia de cada vez.</div></details>
          <details><summary>Qual a diferença entre o mensal e o vitalício?</summary><div className="ans">Nenhuma no acesso: os dois abrem tudo. A diferença é só a forma de pagar — mensal (R$39,90/mês) ou uma vez só (R$397, pra sempre).</div></details>
          <details><summary>Como funciona a cobrança?</summary><div className="ans">Pela Hotmart, com segurança. No mensal você cancela quando quiser; no vitalício é um pagamento único.</div></details>
        </div>
      </section>

      {/* CTA final */}
      <section className="lp-wrap tight">
        <div className="lp-final">
          <h2>Sua próxima leitura pode começar hoje.</h2>
          <p>Um dia de cada vez, com acompanhamento e as irmãs do seu lado. Comece a sua constância agora.</p>
          <Link href="/pricing" className="btn btn-primary">Começar minha constância</Link>
          <div className="lp-assin">Um dia de cada vez · na Palavra</div>
        </div>
      </section>

      {/* footer */}
      <footer className="lp-foot">
        <div className="in">
          <div className="brand">Constância na Palavra</div>
          <div className="meta">
            Sua leitura da Bíblia, um dia de cada vez — com as irmãs.<br />
            Dúvidas? <a href="mailto:ola@constancianapalavra.com.br">ola@constancianapalavra.com.br</a>
          </div>
        </div>
      </footer>
    </>
  );
}
