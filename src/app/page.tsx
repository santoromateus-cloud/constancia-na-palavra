import Link from "next/link";
import {
  IconeBiblia,
  IconeCandeia,
  IconeComentario,
  IconeCronologia,
  IconeCuriosidade,
  IconeEspiga,
  IconeGeografia,
  IconeGraca,
  IconeIrmas,
  IconePerola,
} from "./(app)/Icones";

/* ============================================================
   CONSTÂNCIA NA PALAVRA — Home v5 · "O Método da Lavra"
   Server component. Identidade Luz e Lavra (marfim/tabaco/dourado/oliva).

   ── A COPY (01/09/2026, reescrita com supervisor-copy + vendas-validadas
      + o método de hook do incrivelhook) ──────────────────────────────────

   Nível de consciência (Schwartz): 2, com um pé no 3. A leitora SABE que tem
   o problema — "eu começo e paro" é frase dela, não diagnóstico nosso. Ela já
   ouviu falar de plano de leitura. O que ela não tem é explicação pro fracasso
   e mecanismo pra sair dele. Por isso a página não gasta uma linha explicando
   que ler a Bíblia é bom: começa na dor, nomeia a causa e entrega o mecanismo.

   Hook (tipo 06 do blueprint, Revelação de Erro — INVERTIDO): em vez de acusar
   ("você tá errando sem perceber"), absolve: "Você não parou de ler a Bíblia
   por falta de fé." Cria a mesma dissonância — "então por quê?" — mas honrando
   a leitora em vez de culpá-la. É o gatilho de Blair Warren que mais funciona
   aqui: justificar o fracasso dela. Culpa é justamente o que já paralisou essa
   mulher no ano passado; a página que cobra mais é a página que ela fecha.

   Condução (vendas-validadas / SPIN): situação → problema (os ecos, na
   linguagem nativa dela) → IMPLICAÇÃO (o custo de mais um ano igual, bloco
   novo, era o que faltava) → mecanismo nomeado → prova → PROJEÇÃO (a tela dela
   em dezembro, bloco novo) → autoridade → oferta/stack → objeções → CTA.

   Mecanismo único (Todd Brown): "O Método da Lavra", em cinco peças — trilho,
   marca, prova, perdão, companhia. Sem nome, isso vira "app com streak" e
   qualquer concorrente diz igual. Com nome, é dela.

   Reciprocidade (Cialdini) antes de qualquer pedido: a Bíblia inteira marcável
   é grátis e continua grátis. A página entrega ANTES de cobrar, e diz isso.

   O que ficou de fora, de propósito:
   · Número inventado. Nada de "8 em 10 mulheres param no mês 2". Se não tem
     fonte, não entra (regra 4 do supervisor-copy).
   · Depoimento fabricado. As frases entre aspas são a linguagem nativa da
     leitora levantada no raio-x de persona, atribuídas a ela mesma — não a
     alunas inventadas com nome e foto.
   · Travessão de IA, "não é X, é Y", "vamos lá", "crucial". Voz da Elisangela:
     professora-guia, calor humano, clareza sem agressão.
   · Promessa que o produto não cumpre. O checkout ainda não abriu e a página
     DIZ isso, em vez de esconder atrás de um botão morto.

   ── O VISUAL ──────────────────────────────────────────────────────────────
   · Vitrine: a home mostra as telas de verdade (candeia acesa, lavra crescendo,
     trilha serpenteando), animadas, em vez de descrever com adjetivo.
   · Reveal por scroll de verdade (animation-timeline: view()), com a animação
     de carregamento como fallback em quem não suporta. Nunca esconde conteúdo.
   ============================================================ */

const HOTMART_MENSAL = process.env.NEXT_PUBLIC_HOTMART_MENSAL_URL || "";
const HOTMART_VITALICIO = process.env.NEXT_PUBLIC_HOTMART_VITALICIO_URL || "";
const CHECKOUT_ABERTO = Boolean(HOTMART_MENSAL && HOTMART_VITALICIO);

// Ensaio 2026 — NO AR desde 02/09/2026.
//
// As fotos NÃO moram neste repositório: JPG é binário e o conector do GitHub
// desta sessão só passa texto — foi o que travou a troca por semanas. Moram no
// cPanel do educaverbum.com.br (conta educaverbumcom), em
// public_html/constancia/, junto com as outras landings do ecossistema
// (/virgula/, /raiox/). É o mesmo lugar de onde a Flávia já serve imagem, e sai
// do bundle da Vercel.
//
// O terceiro arquivo do ensaio, elisangela-ritual.jpg, também está lá e não tem
// slot nesta página ainda — está pronto pra quando tiver.
const CDN = "https://educaverbum.com.br/constancia";
const FOTO = `${CDN}/elisangela-hero.jpg`;
const MEDALHAO = `${CDN}/elisangela-medalhao.jpg`;

const ECOS = [
  "Comecei animada e parei no meio do Antigo Testamento.",
  "Já perdi tantos dias que nem sei mais por onde voltar.",
  "Leio, fecho a Bíblia e não lembro do que li.",
  "Queria muito ler com alguém, não sozinha.",
];

// As cinco peças do Método da Lavra. Cada uma existe de verdade no produto —
// nenhuma é promessa de roadmap.
const PECAS = [
  {
    Icone: IconeBiblia,
    n: "O trilho",
    t: "A leitura de hoje já está escolhida",
    p: "Você abre e lê. Não decide por onde começar, não lembra onde parou, não calcula quanto falta. A passagem do dia está lá esperando, na ordem certa, do primeiro ao último dia do caminho.",
  },
  {
    Icone: IconeCandeia,
    n: "A marca",
    t: "A Candeia acende e conta os seus dias",
    p: "Cada leitura acende a chama e o número sobe. Quando a sua sequência tem um número e ele está na tela, quebrar deixa de ser um esquecimento sem preço e vira uma escolha que você sente.",
  },
  {
    Icone: IconeEspiga,
    n: "A prova",
    t: "A Lavra cresce e as Pérolas ficam guardadas",
    p: "Uma espiga nasce no seu campo a cada dia lido, e um versículo do que você acabou de ler fica guardado no seu cofre. Em um mês você não tem uma porcentagem: tem um campo e um punhado de joias que saíram da sua própria leitura.",
  },
  {
    Icone: IconeGraca,
    n: "O perdão",
    t: "O dia perdido não derruba você",
    p: "A cada sete dias de constância você ganha um Dia de Graça. Faltou um dia, ele cobre por você e a sequência continua. Graça aqui não se compra em nenhum plano: só se recebe de quem já caminhou.",
  },
  {
    Icone: IconeIrmas,
    n: "A companhia",
    t: "Outras mulheres estão no mesmo dia que você",
    p: "No mural você lê o que as suas irmãs estão vivendo naquela mesma passagem e deixa o seu pedido ou o seu louvor. É a peça que sustenta as outras quatro quando a vontade não aparece.",
  },
];

// Oito caminhos. Os quatro primeiros são os novos, montados sobre as práticas
// mais procuradas por quem lê a Bíblia — e as que os apps concorrentes menos
// entregam: cronológica, comentário de autoridade, geografia e curiosidades.
const CAMINHOS = [
  {
    d: "40",
    Icone: IconeCronologia,
    t: "A Bíblia na ordem em que aconteceu",
    p: "Do Éden a Pentecostes na ordem dos fatos, não na ordem dos livros. Jó entra no meio de Gênesis, os salmos entram junto da vida de Davi.",
    q: "Para quem sempre quis entender a história inteira e nunca conseguiu montar o quebra-cabeça.",
    novo: true,
  },
  {
    d: "30",
    Icone: IconeComentario,
    t: "Salmos com Spurgeon",
    p: "Trinta salmos com um trecho do comentário de Charles Spurgeon, o pregador inglês que passou a vida dentro deste livro.",
    q: "Para quem quer ler acompanhada de quem entende, sem que a leitura vire aula.",
    novo: true,
  },
  {
    d: "21",
    Icone: IconeGeografia,
    t: "Onde tudo aconteceu",
    p: "Cada dia uma passagem e o lugar onde ela se passou: a estrada, o monte, o poço, a cidade, a distância que aquela gente andou a pé.",
    q: "Para quem lê e sente que está faltando o mapa.",
    novo: true,
  },
  {
    d: "21",
    Icone: IconeCuriosidade,
    t: "O que você não sabia da Bíblia",
    p: "O costume, a moeda, a medida, o detalhe que ninguém explica e que muda o sentido da passagem inteira quando você enxerga.",
    q: "Para quem gosta de descobrir uma coisa e sair contando pra alguém.",
    novo: true,
  },
  {
    d: "31",
    Icone: IconeBiblia,
    t: "Provérbios",
    p: "Um capítulo por dia, do primeiro ao último, e o mês inteiro cabe certinho.",
    q: "Para quem quer sabedoria que serve na cozinha, no trabalho e na conversa difícil.",
  },
  {
    d: "21",
    Icone: IconeBiblia,
    t: "Evangelho de João",
    p: "O evangelho da intimidade, o que mais mostra Jesus de perto.",
    q: "Para quem quer conhecer quem Ele é antes de qualquer outra coisa.",
  },
  {
    d: "15",
    Icone: IconeIrmas,
    t: "Mulheres da Bíblia",
    p: "Quinze mulheres, quinze histórias, um retrato por dia.",
    q: "Para quem precisa se ver em alguém que também não teve caminho fácil.",
  },
  {
    d: "16",
    Icone: IconeBiblia,
    t: "Evangelho de Marcos",
    p: "O mais direto e mais rápido dos quatro. Jesus em movimento, do começo ao fim.",
    q: "Para quem está recomeçando e precisa sentir que sai do lugar.",
  },
];

/* ── VITRINE ────────────────────────────────────────────────────
   Em vez de escrever "gamificação divertida" e pedir fé, a home MOSTRA as
   telas: a candeia acesa com a chama tremendo, o campo de espigas balançando
   e a trilha serpenteando com o dia de hoje pulsando. Tudo SVG + CSS, sem
   imagem e sem JavaScript — carrega junto com a página. */
function VitrineCandeia() {
  return (
    <div className="vt-candeia">
      <span className="vt-luz" aria-hidden />
      <span className="vt-ico" aria-hidden>
        <IconeCandeia size={34} />
      </span>
      <div className="vt-num">
        <b className="tnum">18</b>
        <span>dias seguidos</span>
      </div>
      <div className="vt-lado">
        <div>
          <b className="tnum">46</b>
          <span>na Palavra</span>
        </div>
        <div>
          <b className="tnum">2</b>
          <span>dias de graça</span>
        </div>
      </div>
    </div>
  );
}

function VitrineLavra() {
  const espigas = Array.from({ length: 22 }, (_, i) => i);
  return (
    <div className="vt-card">
      <span className="vt-kick">
        <IconeEspiga size={14} /> A sua Lavra
      </span>
      <svg viewBox="0 0 300 74" className="vt-lavra" aria-hidden>
        <path d="M0 62 Q75 56 150 60 T300 58 L300 74 L0 74 Z" fill="#B8A57A" fillOpacity=".22" />
        <path d="M0 62 Q75 56 150 60 T300 58" fill="none" stroke="#A8945F" strokeOpacity=".45" strokeWidth="1" />
        {espigas.map((i) => {
          const x = 12 + i * 12.8;
          const alt = 24 + ((i * 13) % 10);
          const base = 61 - (i % 3);
          return (
            <g key={i} className="vt-haste" style={{ animationDelay: `${(i % 7) * 0.22}s`, transformOrigin: `${x}px ${base}px` }}>
              <path d={`M${x} ${base} L${x} ${base - alt}`} stroke="#6A7A42" strokeWidth="1.6" strokeLinecap="round" />
              {[0, 1, 2].map((g) => {
                const y = base - alt + 4 + g * 6;
                return (
                  <g key={g}>
                    <path d={`M${x} ${y} q-4.6 -1 -4.2 -5 4.4 .6 4.2 5Z`} fill="#C9A85C" />
                    <path d={`M${x} ${y} q4.6 -1 4.2 -5 -4.4 .6 -4.2 5Z`} fill="#C9A85C" />
                  </g>
                );
              })}
            </g>
          );
        })}
      </svg>
      <p className="vt-frase">No tempo próprio ceifaremos, se não desfalecermos.</p>
    </div>
  );
}

function VitrineTrilha() {
  // Mesma geometria do Trilha.tsx do produto, em miniatura.
  // Amplitude menor que a do produto de propósito: o card é estreito e alto, e
  // com os 25% do original a senoide virava raio de tempestade em vez de trilha.
  const nos = Array.from({ length: 9 }, (_, i) => i);
  const pos = (i: number) => ({ x: 50 + 17 * Math.sin(i * ((2 * Math.PI) / 5)), y: 24 + i * 33 });
  const lidos = 5;
  // fio suave: cada nó vira ponto de controle e a curva passa pelos meios
  const curva = (ate: number) => {
    const pts = nos.slice(0, ate).map(pos);
    if (pts.length < 2) return "";
    let d = `M${pts[0].x} ${pts[0].y}`;
    for (let i = 1; i < pts.length - 1; i++) {
      const m = { x: (pts[i].x + pts[i + 1].x) / 2, y: (pts[i].y + pts[i + 1].y) / 2 };
      d += ` Q${pts[i].x} ${pts[i].y} ${m.x} ${m.y}`;
    }
    const u = pts[pts.length - 1];
    return d + ` L${u.x} ${u.y}`;
  };
  return (
    <div className="vt-card vt-card-trilha">
      <span className="vt-kick">
        <IconeGeografia size={14} /> O seu caminho
      </span>
      <div className="vt-trilha">
        <svg viewBox="0 0 100 288" preserveAspectRatio="none" className="vt-fio" aria-hidden>
          <path
            d={curva(nos.length)}
            fill="none"
            stroke="#E3D6B4"
            strokeWidth="2"
            strokeDasharray="2 6"
            vectorEffect="non-scaling-stroke"
          />
          <path
            className="vt-fio-ouro"
            d={curva(lidos)}
            fill="none"
            stroke="#A98634"
            strokeWidth="3"
            strokeLinecap="round"
            vectorEffect="non-scaling-stroke"
          />
        </svg>
        {nos.map((i) => {
          const p = pos(i);
          const feito = i < lidos;
          const hoje = i === lidos;
          return (
            <span
              key={i}
              className={"vt-no" + (feito ? " feito" : "") + (hoje ? " hoje" : "")}
              style={{ left: `${p.x}%`, top: p.y }}
              aria-hidden
            >
              {feito ? <IconeEspiga size={14} strokeWidth={1.9} /> : hoje ? <IconeCandeia size={15} strokeWidth={1.9} /> : <i>{i + 1}</i>}
            </span>
          );
        })}
      </div>
    </div>
  );
}

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
          <Link href="/" className="brand">
            Constância<span className="brand-resto"> na Palavra</span>
          </Link>
          <div className="links">
            <a className="nav-hide" href="#metodo">O método</a>
            <a className="nav-hide" href="#caminhos">Os caminhos</a>
            <a className="nav-hide" href="#planos">Planos</a>
            <Link href="/login" className="nav-hide">Entrar</Link>
            <Link href="/login" className="cta">Começar de graça</Link>
          </div>
        </div>
      </nav>

      {/* ── HERO ── o hook: absolve antes de explicar ── */}
      <header className="cnp-hero">
        <div className="cnp-hero-txt">
          <span className="kick reveal d1">Escola Mulher Sábia</span>
          <h1 className="reveal d2">
            Você não parou de ler a Bíblia por <em>falta de fé</em>.
          </h1>
          <p className="cnp-lead reveal d3">
            Sou Elisangela Martins, mentora bíblica e fundadora da Escola Mulher Sábia. A pergunta
            que mais chega até mim é sempre a mesma: <b>por que eu começo a ler e sempre paro?</b>{" "}
            A resposta que eu dou é sempre a mesma também. Ninguém sustenta sozinha uma caminhada
            que nunca foi feita pra ser sozinha. Faltava trilho e faltava companhia. O Constância
            na Palavra é o lugar que eu montei pra isso.
          </p>
          <div className="cnp-cta reveal d4">
            <Link href="/login" className="btn btn-primary">Começar de graça</Link>
            <Link href="/login" className="btn btn-google">Já sou membro</Link>
          </div>
          <div className="cnp-micro reveal d5">
            <span>A Bíblia inteira é grátis</span>
            <span>Cinco minutos por dia</span>
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

      {/* ── A IMPLICAÇÃO: o custo de mais um ano igual ── */}
      <section className="cnp-sec tight">
        <div className="cnp-custo cnp-rise">
          <span className="kick">O que acontece se nada mudar</span>
          <h2>Daqui a um ano, a mesma página.</h2>
          <p>
            Não é dramático, é só como funciona. A Bíblia volta pra cabeceira, o marcador continua
            parado no mesmo capítulo e a próxima vez que você abrir vai ser em janeiro, com a mesma
            promessa e o mesmo começo. Não porque você não queira. Porque nada no seu dia te lembra,
            te espera ou sente a sua falta quando você não aparece.
          </p>
          <p className="cnp-custo-fecho">É exatamente isso que o Constância na Palavra faz.</p>
        </div>
      </section>

      {/* ── o mecanismo, na voz dela ── */}
      <section className="cnp-sec tight" id="metodo">
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

      {/* ── O MÉTODO DA LAVRA: o mecanismo, nomeado e em cinco peças ── */}
      <section className="cnp-sec">
        <div className="cnp-head-c">
          <span className="kick">O mecanismo</span>
          <h2 className="cnp-title center">O Método da Lavra, em <em>cinco peças</em>.</h2>
          <p className="cnp-desc center">
            Você planta um dia de cada vez e vê o campo crescer. Nenhuma das cinco peças é
            promessa de roadmap: todas já estão funcionando lá dentro, e você conhece todas elas
            no primeiro dia.
          </p>
        </div>
        <ol className="cnp-pecas">
          {PECAS.map((peca, i) => (
            <li key={peca.n} className="cnp-rise">
              <span className="pc-ico" aria-hidden><peca.Icone size={26} /></span>
              <div className="pc-txt">
                <span className="pc-n">{String(i + 1).padStart(2, "0")} · {peca.n}</span>
                <h3>{peca.t}</h3>
                <p>{peca.p}</p>
              </div>
            </li>
          ))}
        </ol>
      </section>

      {/* ── VITRINE: as telas de verdade, animadas ── */}
      <section className="cnp-sec tight">
        <div className="cnp-head-c">
          <span className="kick">Por dentro</span>
          <h2 className="cnp-title center">A sua constância vira uma coisa que você <em>vê</em>.</h2>
        </div>
        <div className="cnp-vitrine cnp-rise">
          <div className="vt-col">
            <VitrineCandeia />
            <VitrineLavra />
          </div>
          <VitrineTrilha />
        </div>
      </section>

      {/* ── a porta grátis: o marcador da Bíblia inteira ── */}
      <section className="cnp-sec" id="gratis">
        <div className="cnp-free cnp-rise">
          <div className="cnp-free-txt">
            <span className="kick">Comece hoje, sem pagar nada</span>
            <h2>A Bíblia inteira na sua mão, capítulo por capítulo, de graça, para sempre.</h2>
            <p>
              Os 66 livros e os 1.189 capítulos estão aqui em caixinhas para você marcar. Cada
              capítulo que você lê fica registrado, o seu percentual do Antigo e do Novo Testamento
              sobe na tela, e você escolhe uma data de chegada. O app calcula sozinho quantos
              capítulos por dia faltam para você chegar lá.
            </p>
            <ul className="cnp-free-lista">
              <li><b>1.189 capítulos</b> para marcar, do Gênesis ao Apocalipse</li>
              <li><b>Seu progresso</b> do Antigo e do Novo Testamento, sempre à vista</li>
              <li><b>Sua meta</b> com data de início e de fim, e o ritmo diário calculado</li>
            </ul>
            <p className="cnp-free-nota">
              Isso não é um teste de sete dias. É seu, e continua seu, com ou sem assinatura.
              A Palavra não fica atrás de uma cobrança.
            </p>
            <Link href="/login" className="btn btn-primary">Criar minha conta grátis</Link>
          </div>

          <div className="cnp-anelzao" aria-hidden>
            <svg viewBox="0 0 220 220">
              <circle cx="110" cy="110" r="96" fill="none" stroke="var(--line)" strokeWidth="7" />
              <circle
                className="cnp-anelzao-arco"
                cx="110" cy="110" r="96" fill="none"
                stroke="url(#anelOuro)" strokeWidth="7" strokeLinecap="round"
                transform="rotate(-90 110 110)"
              />
              <defs>
                <linearGradient id="anelOuro" x1="0" y1="0" x2="1" y2="1">
                  <stop offset="0%" stopColor="#E0C88A" />
                  <stop offset="100%" stopColor="#8F6D1E" />
                </linearGradient>
              </defs>
            </svg>
            <div className="cnp-anelzao-txt">
              <b className="tnum">1.189</b>
              <span>capítulos</span>
              <i>66 livros · grátis pra sempre</i>
            </div>
          </div>
        </div>
      </section>

      {/* ── os caminhos de leitura ── */}
      <section className="cnp-sec" id="caminhos">
        <div className="cnp-head-c">
          <span className="kick">Os caminhos</span>
          <h2 className="cnp-title center">Oito caminhos, e nenhum deles te <em>larga no meio</em>.</h2>
          <p className="cnp-desc center">
            Quatro deles são novos e foram montados sobre o que quem lê a Bíblia mais procura e
            quase nenhum aplicativo entrega: a leitura na ordem em que os fatos aconteceram, o
            comentário de um grande pregador, a geografia dos lugares e as curiosidades de contexto.
            Você troca de caminho quando quiser e o seu progresso continua guardado.
          </p>
        </div>
        <div className="cnp-paths">
          {CAMINHOS.map((c) => (
            <article key={c.t} className="cnp-path cnp-rise">
              {c.novo && <span className="cnp-path-novo">novo</span>}
              <div className="cnp-path-anel" aria-hidden>
                <svg viewBox="0 0 96 96" width="96" height="96">
                  <circle cx="48" cy="48" r="43" fill="none" stroke="var(--line)" strokeWidth="1.5" />
                  <circle
                    cx="48" cy="48" r="43" fill="none"
                    stroke="var(--fio)" strokeWidth="2.5" strokeLinecap="round"
                    strokeDasharray="270" strokeDashoffset="78"
                    transform="rotate(-90 48 48)"
                  />
                </svg>
                <span className="cnp-path-num">{c.d}</span>
              </div>
              <span className="cnp-path-dias">dias</span>
              <span className="cnp-path-ico" aria-hidden><c.Icone size={19} /></span>
              <h3>{c.t}</h3>
              <p>{c.p}</p>
              <p className="cnp-path-quem">{c.q}</p>
            </article>
          ))}
        </div>
        <p className="cnp-paths-nota">
          O texto bíblico é a tradução João Ferreira de Almeida em domínio público. Os comentários
          são de Charles Spurgeon (1834–1892), também em domínio público, traduzidos do original em
          inglês, com o autor e a obra creditados em cada trecho.
        </p>
      </section>

      {/* ── A PROJEÇÃO: a tela dela daqui a noventa dias ── */}
      <section className="cnp-sec tight">
        <div className="cnp-proj cnp-rise">
          <span className="kick">Daqui a noventa dias</span>
          <h2>Some noventa dias a partir de hoje.</h2>
          <p>
            Você chega no fim do ano com dois caminhos inteiros atravessados e o terceiro começado.
            Um campo cheio de espigas, cada uma um dia em que você apareceu. Um cofre de versículos
            que saíram da sua própria leitura, não de uma lista pronta que alguém montou. E o nome
            de umas quantas mulheres que leram junto com você o tempo todo.
          </p>
          <p className="cnp-proj-fecho">
            Ou você chega no fim do ano com a mesma promessa de janeiro. As duas coisas custam a
            mesma quantidade de dias.
          </p>
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
              <div className="cnp-fact"><b>8 caminhos</b><span>de leitura já abertos aqui dentro</span></div>
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
            oito caminhos, o Método da Lavra inteiro e o mural das irmãs.
          </p>
        </div>

        <div className="lp-plans" style={{ maxWidth: 720, margin: "0 auto" }}>
          <div className="lp-plan cnp-rise">
            <span className="tag">Mensal</span>
            <div className="price">R$39,90<small>/mês</small></div>
            <ul>
              <li>Tudo do grátis, mais:</li>
              <li>Os oito caminhos guiados, com a trilha do dia</li>
              <li>A Candeia e os Dias de Graça</li>
              <li>As Pérolas e a Lavra que cresce</li>
              <li>Comentário, geografia e curiosidade do dia</li>
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
              <li>Os caminhos que entrarem depois, sem pagar de novo</li>
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
            <div className="ans">O marcador da Bíblia inteira: os 66 livros, os 1.189 capítulos para marcar, o seu progresso do Antigo e do Novo Testamento e a sua meta com data. Não é teste de sete dias nem versão que expira: é seu e continua seu. O plano pago abre os oito caminhos guiados, a Candeia, as Pérolas, os Dias de Graça e o mural.</div>
          </details>
          <details>
            <summary>Já posso pagar?</summary>
            <div className="ans">Ainda não. Estamos abrindo a turma de fundadoras, então a assinatura ainda está fechada. Crie sua conta agora e avisamos assim que o pagamento for liberado, com o preço desta página garantido pra você.</div>
          </details>
          <details>
            <summary>Perdi vários dias. Consigo voltar?</summary>
            <div className="ans">Sempre. A proposta aqui é constância, não perfeição. Você retoma a leitura de hoje e segue de onde está, um dia de cada vez. E a cada sete dias de leitura você ganha um Dia de Graça, que cobre uma falta sem derrubar a sua sequência. Ele nunca é vendido: só se ganha caminhando.</div>
          </details>
          <details>
            <summary>Qual tradução da Bíblia vocês usam?</summary>
            <div className="ans">A João Ferreira de Almeida em domínio público, capítulo por capítulo, sem resumo e sem paráfrase. Usamos só texto de domínio público de propósito: assim a leitura é sua para sempre, sem depender de licença de ninguém.</div>
          </details>
          <details>
            <summary>Quem é Spurgeon e por que o comentário é dele?</summary>
            <div className="ans">Charles Haddon Spurgeon (1834–1892) foi um pregador inglês que passou a vida comentando os Salmos, num trabalho chamado O Tesouro de Davi. A obra dele está em domínio público, o que nos deixa usar o texto com honestidade, creditando autor e obra em cada trecho, traduzido do original em inglês. Autores mais recentes ficaram de fora justamente por isso: crédito não substitui licença.</div>
          </details>
          <details>
            <summary>E se eu já tenho o hábito de ler pela manhã?</summary>
            <div className="ans">Melhor ainda. Você mantém o seu ritmo, só que com a sequência visível, as camadas de contexto no dia e a companhia das irmãs pra não deixar cair no mês seguinte.</div>
          </details>
          <details>
            <summary>Qual a diferença entre o mensal e o vitalício?</summary>
            <div className="ans">Nenhuma no acesso: os dois abrem tudo. A diferença é a forma de pagar, todo mês (R$39,90) ou uma vez só (R$397, pra sempre). O vitalício ainda recebe os caminhos novos que entrarem depois sem pagar de novo.</div>
          </details>
          <details>
            <summary>Quem está por trás do Constância na Palavra?</summary>
            <div className="ans">A Elisangela Martins, mentora bíblica e fundadora da Escola Mulher Sábia.</div>
          </details>
        </div>
      </section>

      {/* ── CTA final ── */}
      <section className="cnp-sec tight">
        <div className="lp-final cnp-rise">
          <h2>A sua leitura de hoje já está esperando.</h2>
          <p>
            Crie sua conta em um minuto e acenda a primeira candeia. A Bíblia inteira é sua de
            graça, hoje. E quando você quiser companhia no caminho, o plano está aqui.
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
