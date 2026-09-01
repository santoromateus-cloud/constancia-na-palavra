import Link from "next/link";

/* ============================================================
   CONSTÂNCIA NA PALAVRA — Home v3 · "A voz da Elisangela"
   Server component. Identidade Luz e Lavra (marfim/tabaco/dourado/oliva).

   O que mudou em 04/08/2026:
   · A página inteira passa a ser falada em 1ª pessoa pela Elisangela.
     Ela abre a home (retrato em arco na hero), assina o mecanismo,
     conduz os passos e fecha a página. O produto deixa de ser um app
     genérico e passa a ser "o lugar que ela montou".
   · Removida a estatística "8 em 10 mulheres param no mês 2": número
     sem fonte. Substituída pelas frases da própria leitora (linguagem
     nativa levantada no raio-x de persona), atribuídas a ela, não a
     depoimentos fabricados.
   · Checkout ainda não existe. Enquanto as env vars do Hotmart não
     forem preenchidas, os botões de plano NÃO voltam pra própria
     página (loop morto): levam pro cadastro e a página avisa, em
     texto claro, que o pagamento ainda não abriu.

   O que mudou em 01/09/2026 (v4 · FREEMIUM):
   · O produto passa a ter uma porta grátis de verdade: o marcador da
     Bíblia inteira (66 livros, 1.189 capítulos), o progresso AT/NT e a
     meta com data. A página agora VENDE essa porta primeiro.
   · A Bíblia nunca fica atrás do paywall. O que se vende é o caminho
     guiado, o jogo da constância e a companhia — não o texto.
   ============================================================ */

const HOTMART_MENSAL = process.env.NEXT_PUBLIC_HOTMART_MENSAL_URL || "";
const HOTMART_VITALICIO = process.env.NEXT_PUBLIC_HOTMART_VITALICIO_URL || "";
const CHECKOUT_ABERTO = Boolean(HOTMART_MENSAL && HOTMART_VITALICIO);

// Ensaio 2026 — PENDENTE DE UPLOAD. Os 3 arquivos novos (elisangela-hero.jpg,
// elisangela-ritual.jpg, elisangela-medalhao.jpg) estão prontos e recortados, mas
// binário não sobe pela API do GitHub (o proxy de git desta sessão não tem o repo
// autorizado e o /upload do GitHub web exige login). Enquanto não sobem, a página
// usa a foto que JÁ está em produção — melhor do que <img> quebrada no ar.
// Para ativar: subir os 3 arquivos em public/ e trocar as 3 linhas abaixo.
const FOTO = "/elisangela.jpg";
const RITUAL = "";                  // sem foto do ritual ainda: o bloco vira 1 coluna
const MEDALHAO = "/elisangela.jpg";

const ECOS = [
  "Comecei animada e parei no meio do Antigo Testamento.",
  "Já perdi tantos dias que nem sei mais por onde voltar.",
  "Leio, fecho a Bíblia e não lembro do que li.",
  "Queria muito ler com alguém, não sozinha.",
];

const PASSOS = [
  {
    t: "Abra a leitura de hoje",
    p: "A passagem do dia já está escolhida e esperando por você. Você não precisa decidir por onde começar, nem lembrar onde parou.",
  },
  {
    t: "Leia com calma, cinco minutos",
    p: "Um trecho por dia, no seu ritmo. Tempo suficiente pra ser um encontro de verdade e curto o bastante pra caber num dia corrido.",
  },
  {
    t: "Marque que leu",
    p: "Um toque e a sua sequência cresce na tela. Quando você vê preto no branco que não parou, fica muito mais difícil quebrar.",
  },
  {
    t: "Caminhe com as irmãs",
    p: "No mural você lê o que as outras estão vivendo e deixa o seu pedido ou o seu louvor. É a companhia que sustenta a constância.",
  },
];

const CAMINHOS = [
  { d: "31", t: "Provérbios", p: "Um capítulo por dia, do primeiro ao último. Sabedoria prática pra vida de casa, de trabalho e de família." },
  { d: "21", t: "Evangelho de João", p: "O evangelho da intimidade. Pra quem quer conhecer quem Jesus é antes de qualquer outra coisa." },
  { d: "15", t: "Mulheres da Bíblia", p: "Quinze mulheres, quinze histórias. Um retrato por dia de quem também não teve caminho fácil." },
  { d: "16", t: "Evangelho de Marcos", p: "O evangelho mais direto e mais rápido. Ideal pra quem está recomeçando e quer sentir movimento logo." },
];

export default function Home() {
  return (
    <>
      {/* faixa de pré-lançamento */}
      <div className="lp-band">
        <span className="dot" aria-hidden />
        <span>Turma de fundadoras · o preço desta página não volta depois da abertura.</span>
      </div>

      {/* nav */}
      <nav className="lp-nav">
        <div className="in">
          <Link href="/" className="brand">Constância na Palavra</Link>
          <div className="links">
            <a className="nav-hide" href="#mentora">A mentora</a>
            <a className="nav-hide" href="#como">Como funciona</a>
            <a className="nav-hide" href="#planos">Planos</a>
            <Link href="/login" className="nav-hide">Entrar</Link>
            <Link href="/login" className="cta">Começar hoje</Link>
          </div>
        </div>
      </nav>

      {/* ── HERO ── a Elisangela abre a página ── */}
      <header className="cnp-hero">
        <div className="cnp-hero-txt">
          <span className="kick reveal d1">Escola Mulher Sábia</span>
          <h1 className="reveal d2">
            Dessa vez você não vai ler <em>sozinha</em>.
          </h1>
          <p className="cnp-lead reveal d3">
            Sou Elisangela Martins, mentora bíblica e fundadora da Escola Mulher Sábia. A pergunta
            que mais chega até mim é sempre a mesma: <b>por que eu começo a ler a Bíblia e sempre
            paro?</b> Fé não é o que está faltando. Falta um plano que te leve pela mão e alguém do
            seu lado quando o dia aperta. Foi por isso que eu criei o Constância na Palavra.
          </p>
          <div className="cnp-cta reveal d4">
            <Link href="/login" className="btn btn-primary">Começar de graça</Link>
            <Link href="/login" className="btn btn-google">Já sou membro</Link>
          </div>
          <div className="cnp-micro reveal d5">
            <span>Marcar a Bíblia inteira é grátis</span>
            <span>Cinco minutos bastam</span>
            <span>No celular, sem baixar nada</span>
          </div>
        </div>

        <div className="cnp-portrait reveal d2">
          <div className="cnp-frame">
          <figure>
            <img src={FOTO} alt="Elisangela Martins, mentora bíblica e fundadora da Escola Mulher Sábia" width={430} height={573} />
            <figcaption className="cnp-plate">
              <div className="nm">Elisangela Martins</div>
              <div className="rl">Mentora bíblica</div>
            </figcaption>
          </figure>
          </div>
          <p className="cnp-verse">
            Lâmpada para os meus pés é a tua palavra, e luz para o meu caminho.
            <b>Salmos 119:105</b>
          </p>
        </div>
      </header>

      {/* ── as frases dela ── */}
      <section className="cnp-sec">
        <div className="cnp-head-c">
          <span className="kick">Talvez você já tenha dito</span>
          <h2 className="cnp-title center">Se alguma dessas frases já passou pela sua cabeça, essa página é <em>pra você</em>.</h2>
        </div>
        <ul className="cnp-echo cnp-rise">
          {ECOS.map((e) => <li key={e}>{e}</li>)}
        </ul>
        <p className="cnp-echo-foot cnp-rise">
          Nenhuma delas é sinal de fé pequena. Todas são sinal da mesma coisa: você está tentando
          sustentar sozinha uma caminhada que nunca foi feita pra ser sozinha.
        </p>
      </section>

      {/* ── o mecanismo, na voz dela ── */}
      <section className="cnp-sec tight">
        <div className="cnp-dark cnp-rise">
          <span className="kick">Por que a leitura desmorona</span>
          <h2>Você não parou por preguiça. Parou porque estava sem trilho e sem companhia.</h2>
          <p>
            Eu vejo isso toda semana nas minhas alunas. A mulher decide ler a Bíblia inteira, começa
            firme em Gênesis, atravessa Êxodo com esforço e some no meio do Levítico. Aí vem a culpa,
            e a culpa paralisa em vez de mover. O que quebra esse ciclo não é mais um sermão sobre
            disciplina. É ter uma passagem por dia já escolhida, ver a sua sequência crescendo na
            tela e saber que tem outras mulheres lendo junto com você naquele mesmo dia.
          </p>
          <div className="cnp-sign">
            <img src={MEDALHAO} alt="" aria-hidden="true" />
            <div>
              <div className="n">Elisangela Martins</div>
              <div className="r">Escola Mulher Sábia</div>
            </div>
          </div>
        </div>
      </section>

      {/* ── a porta grátis: o marcador da Bíblia inteira ── */}
      <section className="cnp-sec" id="gratis">
        <div className="cnp-free cnp-rise">
          <div className="cnp-free-txt">
            <span className="kick">Comece hoje, sem pagar nada</span>
            <h2>A Bíblia inteira na sua mão, capítulo por capítulo — de graça, para sempre.</h2>
            <p>
              Os 66 livros e os 1.189 capítulos estão aqui em caixinhas para você marcar. Cada
              capítulo que você lê fica registrado, o seu percentual do Antigo e do Novo Testamento
              sobe na tela, e você escolhe uma data de chegada — o app calcula sozinho quantos
              capítulos por dia faltam para você chegar lá.
            </p>
            <ul className="cnp-free-lista">
              <li><b>1.189 capítulos</b> para marcar, do Gênesis ao Apocalipse</li>
              <li><b>Seu progresso</b> do Antigo e do Novo Testamento, sempre à vista</li>
              <li><b>Sua meta</b> com data de início e de fim, e o ritmo diário calculado</li>
            </ul>
            <p className="cnp-free-nota">
              Isso não é um teste de sete dias. É seu, e continua seu — com ou sem assinatura.
              A Palavra não fica atrás de uma cobrança.
            </p>
            <Link href="/login" className="btn btn-primary">Criar minha conta grátis</Link>
          </div>
          {RITUAL && (
            <figure className="cnp-free-img">
              <img
                src={RITUAL}
                alt="Mãos sobre uma Bíblia de couro, com um café e o celular ao lado, no momento da leitura"
                width={900}
                height={1108}
              />
            </figure>
          )}
        </div>
      </section>

      {/* ── como funciona ── */}
      <section className="cnp-sec" id="como">
        <div className="cnp-head-c">
          <span className="kick">Como funciona</span>
          <h2 className="cnp-title center">Quatro passos que cabem no seu dia <em>de verdade</em>.</h2>
          <p className="cnp-desc center">
            Não é um curso pra assistir nem uma meta pra bater. É uma rotina curta que você repete,
            e que fica visível pra você não perder de vista.
          </p>
        </div>
        <ol className="cnp-steps">
          {PASSOS.map((s, i) => (
            <li key={s.t} className="cnp-rise">
              <span className="n" aria-hidden>{String(i + 1).padStart(2, "0")}</span>
              <div>
                <h3>{s.t}</h3>
                <p>{s.p}</p>
              </div>
            </li>
          ))}
        </ol>
      </section>

      {/* ── os caminhos de leitura ── */}
      <section className="cnp-sec tight">
        <div className="cnp-head-c">
          <span className="kick">Os caminhos</span>
          <h2 className="cnp-title center">Quatro planos prontos. Você escolhe <em>por onde começar</em>.</h2>
          <p className="cnp-desc center">
            Cada plano tem começo, meio e fim, com um trecho por dia na ordem certa. Você pode trocar
            de caminho quando quiser, e o seu progresso continua salvo.
          </p>
        </div>
        <div className="cnp-paths">
          {CAMINHOS.map((c) => (
            <article key={c.t} className="cnp-path cnp-rise">
              <div className="d">{c.d}<small>dias</small></div>
              <h3>{c.t}</h3>
              <p>{c.p}</p>
            </article>
          ))}
        </div>
      </section>

      {/* ── a mentora ── */}
      <section className="cnp-sec" id="mentora">
        <div className="cnp-mentor">
          <div className="cnp-cameo cnp-rise">
            <img src={MEDALHAO} alt="Elisangela Martins" width={210} height={210} />
          </div>
          <div className="cnp-rise">
            <span className="kick">Quem caminha com você</span>
            <h2 className="cnp-title">Elisangela Martins</h2>
            <p className="cnp-desc">
              Mentora bíblica e fundadora da Escola Mulher Sábia, onde ensina mulheres a viver a
              Palavra dentro de casa, na vida real, sem linguagem de seminário. O Constância na
              Palavra nasceu da pergunta que ela mais ouve das alunas e existe pra responder a ela
              em forma de rotina: uma leitura por dia, acompanhada, até virar hábito.
            </p>
            <div className="cnp-facts">
              <div className="cnp-fact"><b>Escola Mulher Sábia</b><span>a comunidade que ela fundou</span></div>
              <div className="cnp-fact"><b>+120 mil</b><span>mulheres acompanham o trabalho dela</span></div>
              <div className="cnp-fact"><b>4 caminhos</b><span>de leitura já abertos aqui dentro</span></div>
            </div>
          </div>
        </div>
      </section>

      {/* ── planos ── */}
      <section className="cnp-sec" id="planos">
        <div className="cnp-head-c">
          <span className="kick">Planos</span>
          <h2 className="cnp-title center">O marcador é grátis. O <em>caminho guiado</em> é o plano.</h2>
          <p className="cnp-desc center">
            Você pode marcar a Bíblia inteira sem pagar nada, hoje e sempre. Quem assina ganha os
            caminhos que a Elisangela montou, a Candeia que conta os seus dias seguidos, as Pérolas
            que você coleciona e o mural das irmãs.
          </p>
        </div>

        <div className="lp-plans" style={{ maxWidth: 720, margin: "0 auto" }}>
          <div className="lp-plan cnp-rise">
            <span className="tag">Mensal</span>
            <div className="price">R$39,90<small>/mês</small></div>
            <ul>
              <li>Tudo do grátis, mais:</li>
              <li>Os quatro caminhos de leitura guiados</li>
              <li>A Candeia e os Dias de Graça</li>
              <li>As Pérolas e a Lavra que cresce</li>
              <li>O mural das irmãs</li>
              <li>Cancele quando quiser</li>
            </ul>
            {CHECKOUT_ABERTO ? (
              <a href={HOTMART_MENSAL} target="_blank" rel="noopener noreferrer" className="btn btn-google" style={{ justifyContent: "center" }}>Assinar o mensal →</a>
            ) : (
              <Link href="/login" className="btn btn-google" style={{ justifyContent: "center" }}>Garantir minha vaga →</Link>
            )}
          </div>

          <div className="lp-plan hot cnp-rise">
            <span className="lp-badge-top">Acesso pra sempre</span>
            <span className="tag">Vitalício</span>
            <div className="price">R$397<small> uma vez</small></div>
            <ul>
              <li>Tudo do mensal</li>
              <li>Pago uma única vez, sem mensalidade</li>
              <li>Sua constância sem data pra acabar</li>
            </ul>
            {CHECKOUT_ABERTO ? (
              <a href={HOTMART_VITALICIO} target="_blank" rel="noopener noreferrer" className="btn btn-primary" style={{ justifyContent: "center" }}>Quero o vitalício →</a>
            ) : (
              <Link href="/login" className="btn btn-primary" style={{ justifyContent: "center" }}>Garantir minha vaga →</Link>
            )}
          </div>
        </div>

        {CHECKOUT_ABERTO ? (
          <div style={{ display: "flex", flexWrap: "wrap", justifyContent: "center", gap: "12px 26px", marginTop: 28, fontSize: 13, color: "var(--muted)" }}>
            <span>Pagamento seguro pela Hotmart</span>
            <span>Mensal: cancele quando quiser</span>
          </div>
        ) : (
          <p className="cnp-note">
            <b>O pagamento ainda não abriu.</b> Estamos na turma de fundadoras: você cria sua conta
            agora, entra na lista e é avisada assim que a assinatura for liberada, com o preço desta
            página garantido. Nada é cobrado hoje.
          </p>
        )}
      </section>

      {/* ── faq ── */}
      <section className="cnp-sec tight">
        <div className="cnp-head-c">
          <span className="kick">Perguntas</span>
          <h2 className="cnp-title center">Antes de começar</h2>
        </div>
        <div className="lp-faq">
          <details>
            <summary>Preciso baixar alguma coisa?</summary>
            <div className="ans">Não. Funciona no navegador do celular e do computador. Você abre, lê a passagem do dia e marca que leu.</div>
          </details>
          <details>
            <summary>O que é grátis de verdade?</summary>
            <div className="ans">O marcador da Bíblia inteira: os 66 livros, os 1.189 capítulos para marcar, o seu progresso do Antigo e do Novo Testamento e a sua meta com data. Não é teste de sete dias nem versão que expira — é seu e continua seu. O plano pago abre os caminhos guiados, a Candeia, as Pérolas e o mural.</div>
          </details>
          <details>
            <summary>Já posso pagar?</summary>
            <div className="ans">Ainda não. Estamos abrindo a turma de fundadoras, então a assinatura ainda está fechada. Crie sua conta agora e avisamos assim que o pagamento for liberado, com o preço desta página garantido pra você.</div>
          </details>
          <details>
            <summary>Perdi vários dias. Consigo voltar?</summary>
            <div className="ans">Sempre. A proposta aqui é constância, não perfeição. Você retoma a leitura de hoje e segue de onde está, um dia de cada vez.</div>
          </details>
          <details>
            <summary>E se eu já tenho o hábito de ler pela manhã?</summary>
            <div className="ans">Melhor ainda. Você mantém o seu ritmo, só que com a sequência visível e a companhia das irmãs pra não deixar cair no mês seguinte.</div>
          </details>
          <details>
            <summary>Qual a diferença entre o mensal e o vitalício?</summary>
            <div className="ans">Nenhuma no acesso: os dois abrem tudo. A diferença é só a forma de pagar, todo mês (R$39,90) ou uma vez só (R$397, pra sempre).</div>
          </details>
          <details>
            <summary>Quem está por trás do Constância na Palavra?</summary>
            <div className="ans">A Elisangela Martins, mentora bíblica e fundadora da Escola Mulher Sábia. O conteúdo dos caminhos de leitura é o texto bíblico na tradução João Ferreira de Almeida, em domínio público.</div>
          </details>
        </div>
      </section>

      {/* ── CTA final ── */}
      <section className="cnp-sec tight">
        <div className="lp-final cnp-rise">
          <h2>A sua leitura de hoje já está esperando.</h2>
          <p>
            Crie sua conta em um minuto e comece a marcar. A Bíblia inteira é sua de graça, hoje —
            e quando você quiser companhia no caminho, o plano está aqui.
          </p>
          <Link href="/login" className="btn btn-primary">Começar de graça</Link>
          <div className="lp-assin">Um dia de cada vez · na Palavra</div>
        </div>
      </section>

      {/* footer */}
      <footer className="lp-foot">
        <div className="in">
          <div className="brand">Constância na Palavra</div>
          <div className="meta">
            Uma realização de Elisangela Martins · Escola Mulher Sábia.<br />
            Dúvidas? <a href="mailto:ola@constancianapalavra.com.br">ola@constancianapalavra.com.br</a>
          </div>
        </div>
      </footer>
    </>
  );
}
