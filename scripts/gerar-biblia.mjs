// ─────────────────────────────────────────────────────────────────────────────
//  CONSTÂNCIA NA PALAVRA — gera o texto da Bíblia inteira para o leitor (/biblia/[livro]/[capitulo])
//
//  O que faz: baixa a Almeida de DOMÍNIO PÚBLICO (João Ferreira de Almeida), a mesma fonte
//  dos caminhos (seed 006/007), e escreve um JSON por livro em src/data/biblia/ mais o
//  index.ts que o leitor importa. Roda sozinho antes de todo build ("prebuild" no
//  package.json), então o repositório NÃO guarda os 4,7 MB de texto — guarda a receita.
//
//  Fonte fixada por commit (não por branch): se o upstream mudar, o texto do app não muda
//  sem alguém trocar a linha abaixo de propósito. E o arquivo baixado é conferido por
//  SHA-256: texto diferente do esperado derruba o build em vez de subir calado.
//
//  Ortografia: a fonte está na grafia anterior ao Acordo de 2009 ("Galiléia", "jóia",
//  "eqüidade", "vêem"). Aplicamos as regras do Acordo de forma mecânica e conservadora —
//  só onde a regra não tem exceção. O catálogo do app já escreve "Oseias" e "Miqueias";
//  o texto passa a bater com ele.
//
//  Uso:  node scripts/gerar-biblia.mjs          (baixa se precisar, gera tudo)
//        node scripts/gerar-biblia.mjs --forcar  (ignora o cache e baixa de novo)
// ─────────────────────────────────────────────────────────────────────────────
import { createHash } from "node:crypto";
import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const RAIZ = join(dirname(fileURLToPath(import.meta.url)), "..");

// Fonte: seven1m/open-bibles, arquivo por-almeida.usfx.xml, commit fixado.
const COMMIT = "5885a568bd74c5819f3121c3c02939e445a36c73";
const URL_FONTE = `https://raw.githubusercontent.com/seven1m/open-bibles/${COMMIT}/por-almeida.usfx.xml`;
const SHA256_ESPERADO = "4990d0d1909e2bd57aa6ecc2a2ce9a565b154aac8575b0242dc943ad796e643e";

// Cache do XML baixado. node_modules/.cache sobrevive entre builds na Vercel.
const CACHE = join(RAIZ, "node_modules", ".cache", "biblia", `por-almeida-${COMMIT.slice(0, 10)}.usfx.xml`);
const SAIDA = join(RAIZ, "src", "data", "biblia");

// USFX id → slug do catálogo (src/lib/biblia.ts). A ordem é a canônica.
const SLUGS = {
  GEN: "genesis", EXO: "exodo", LEV: "levitico", NUM: "numeros", DEU: "deuteronomio",
  JOS: "josue", JDG: "juizes", RUT: "rute", "1SA": "1samuel", "2SA": "2samuel",
  "1KI": "1reis", "2KI": "2reis", "1CH": "1cronicas", "2CH": "2cronicas", EZR: "esdras",
  NEH: "neemias", EST: "ester", JOB: "jo", PSA: "salmos", PRO: "proverbios",
  ECC: "eclesiastes", SNG: "cantares", ISA: "isaias", JER: "jeremias", LAM: "lamentacoes",
  EZK: "ezequiel", DAN: "daniel", HOS: "oseias", JOL: "joel", AMO: "amos", OBA: "obadias",
  JON: "jonas", MIC: "miqueias", NAM: "naum", HAB: "habacuque", ZEP: "sofonias", HAG: "ageu",
  ZEC: "zacarias", MAL: "malaquias",
  MAT: "mateus", MRK: "marcos", LUK: "lucas", JHN: "joao", ACT: "atos", ROM: "romanos",
  "1CO": "1corintios", "2CO": "2corintios", GAL: "galatas", EPH: "efesios", PHP: "filipenses",
  COL: "colossenses", "1TH": "1tessalonicenses", "2TH": "2tessalonicenses", "1TI": "1timoteo",
  "2TI": "2timoteo", TIT: "tito", PHM: "filemom", HEB: "hebreus", JAS: "tiago", "1PE": "1pedro",
  "2PE": "2pedro", "1JN": "1joao", "2JN": "2joao", "3JN": "3joao", JUD: "judas", REV: "apocalipse",
};

// ── 1. Baixar (ou reaproveitar o cache) e conferir o hash ────────────────────
async function obterXml(forcar) {
  if (!forcar && existsSync(CACHE)) {
    const xml = readFileSync(CACHE, "utf8");
    if (sha256(xml) === SHA256_ESPERADO) {
      console.log(`biblia: usando o cache (${CACHE})`);
      return xml;
    }
    console.log("biblia: cache com hash diferente — baixando de novo");
  }
  console.log(`biblia: baixando ${URL_FONTE}`);
  const resp = await fetch(URL_FONTE);
  if (!resp.ok) throw new Error(`biblia: download falhou (${resp.status} ${resp.statusText})`);
  const xml = await resp.text();
  const hash = sha256(xml);
  if (hash !== SHA256_ESPERADO) {
    throw new Error(
      `biblia: o texto baixado não é o esperado.\n  esperado ${SHA256_ESPERADO}\n  recebido ${hash}\n` +
        "  Se a mudança foi de propósito, atualize COMMIT e SHA256_ESPERADO em scripts/gerar-biblia.mjs.",
    );
  }
  mkdirSync(dirname(CACHE), { recursive: true });
  writeFileSync(CACHE, xml);
  return xml;
}

function sha256(s) {
  return createHash("sha256").update(s, "utf8").digest("hex");
}

// ── 2. Ortografia (Acordo de 2009), só regras sem exceção ────────────────────
const REGRAS = [
  // trema deixou de existir: eqüidade → equidade, freqüente → frequente
  [/ü/g, "u"], [/Ü/g, "U"],
  // ditongos abertos "éi"/"ói" perdem o acento nas paroxítonas. Seguido de vogal, o
  // ditongo está sempre na penúltima sílaba (Galiléia, assembléia, jóia, estóicos).
  // Oxítonas (papéis, herói, destrói, anzóis) têm consoante ou fim de palavra depois
  // e por isso não casam com a regra — e continuam acentuadas, como manda o Acordo.
  [/éi(?=[aeo])/g, "ei"], [/Éi(?=[aeo])/g, "Ei"],
  [/ói(?=[aeo])/g, "oi"], [/Ói(?=[aeo])/g, "Oi"],
  // vêem/dêem/crêem/lêem → veem/deem/creem/leem ("vêm" e "têm" são outra coisa e ficam)
  [/êem\b/g, "eem"],
  // acentos diferenciais que caíram
  [/\bpêlo(s?)\b/g, "pelo$1"], [/\bPêlo(s?)\b/g, "Pelo$1"],
  [/\bpára\b/g, "para"], [/\bPára\b/g, "Para"],
  [/\bpólo(s?)\b/g, "polo$1"], [/\bpêra(s?)\b/g, "pera$1"],
  // prefixo "co-" perdeu o hífen: coerdeiro, coparticipante
  [/\bco-herdeir/g, "coerdeir"], [/\bCo-herdeir/g, "Coerdeir"],
  [/\bco-participante/g, "coparticipante"], [/\bco-eleita\b/g, "coeleita"],
];

const contagem = new Map();
function ortografia(texto) {
  let t = texto;
  for (const [re, sub] of REGRAS) {
    const antes = t;
    t = t.replace(re, sub);
    if (t !== antes) contagem.set(re.source, (contagem.get(re.source) ?? 0) + (antes.match(re)?.length ?? 0));
  }
  return t;
}

// ── 3. Entidades XML e espaços ────────────────────────────────────────────────
function decodificar(s) {
  return s
    .replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">")
    .replace(/&quot;/g, '"').replace(/&apos;/g, "'")
    .replace(/&#(\d+);/g, (_, n) => String.fromCodePoint(+n))
    .replace(/&#x([0-9a-f]+);/gi, (_, n) => String.fromCodePoint(parseInt(n, 16)));
}
function limpar(s) {
  return decodificar(s).replace(/<[^>]+>/g, "").replace(/\s+/g, " ").trim();
}

// ── 4. Catálogo do app: o gerador confere contra ele e se recusa a divergir ──
function catalogo() {
  const ts = readFileSync(join(RAIZ, "src", "lib", "biblia.ts"), "utf8");
  const mapa = new Map();
  for (const m of ts.matchAll(/slug:\s*'([^']+)',\s*nome:\s*'([^']+)',\s*capitulos:\s*(\d+)/g)) {
    mapa.set(m[1], { nome: m[2], capitulos: +m[3] });
  }
  if (mapa.size !== 66) throw new Error(`biblia: catálogo com ${mapa.size} livros (esperava 66)`);
  return mapa;
}

// ── 5. Parse do USFX (só <book>, <h>, <c>, <v>...<ve/> — a fonte não usa mais nada) ──
function gerar(xml) {
  const cat = catalogo();
  const livros = [];
  let totalCaps = 0;
  let totalVers = 0;

  for (const m of xml.matchAll(/<book id="([A-Z0-9]+)">([\s\S]*?)<\/book>/g)) {
    const [, id, corpo] = m;
    const slug = SLUGS[id];
    if (!slug) throw new Error(`biblia: livro ${id} sem slug`);
    const meta = cat.get(slug);
    if (!meta) throw new Error(`biblia: slug ${slug} não está no catálogo`);

    const capitulos = [];
    let atual = null;
    let esperado = 1;
    for (const t of corpo.matchAll(/<c id="(\d+)"\/>|<v id="(\d+)"\/>([\s\S]*?)<ve\/>/g)) {
      if (t[1]) {
        if (+t[1] !== capitulos.length + 1) throw new Error(`biblia: ${slug} capítulo ${t[1]} fora de ordem`);
        atual = [];
        capitulos.push(atual);
        esperado = 1;
        continue;
      }
      if (!atual) throw new Error(`biblia: ${slug} versículo antes do primeiro capítulo`);
      if (+t[2] !== esperado) throw new Error(`biblia: ${slug} ${capitulos.length}:${t[2]} fora de sequência`);
      esperado++;
      const texto = ortografia(limpar(t[3]));
      if (!texto) throw new Error(`biblia: ${slug} ${capitulos.length}:${t[2]} vazio`);
      atual.push(texto);
      totalVers++;
    }
    if (capitulos.length !== meta.capitulos) {
      throw new Error(`biblia: ${slug} tem ${capitulos.length} capítulos na fonte e ${meta.capitulos} no catálogo`);
    }
    totalCaps += capitulos.length;
    livros.push({ slug, nome: meta.nome, capitulos });
  }

  if (livros.length !== 66 || totalCaps !== 1189) {
    throw new Error(`biblia: saíram ${livros.length} livros e ${totalCaps} capítulos (esperava 66 e 1189)`);
  }
  return { livros, totalVers };
}

// ── 6. Escrever src/data/biblia/*.json + index.ts ────────────────────────────────
function escrever(livros) {
  mkdirSync(SAIDA, { recursive: true });
  let bytes = 0;
  for (const l of livros) {
    const json = JSON.stringify(l);
    bytes += Buffer.byteLength(json);
    writeFileSync(join(SAIDA, `${l.slug}.json`), json);
  }

  const linhas = livros.map((l) => `  ${JSON.stringify(l.slug)}: () => import("./${l.slug}.json"),`).join("\n");
  const index = `// GERADO por scripts/gerar-biblia.mjs — não edite à mão. Não está no git de propósito:
// roda antes de todo build ("prebuild"). Fonte: Almeida (domínio público), commit ${COMMIT.slice(0, 10)}.
export type LivroTexto = { slug: string; nome: string; capitulos: string[][] };

const CARREGAR: Record<string, () => Promise<{ default: LivroTexto }>> = {
${linhas}
};

/** Texto de um livro inteiro, carregado sob demanda (um chunk por livro). */
export async function carregarLivro(slug: string): Promise<LivroTexto | null> {
  const f = CARREGAR[slug];
  if (!f) return null;
  return (await f()).default;
}
`;
  writeFileSync(join(SAIDA, "index.ts"), index);
  return bytes;
}

// ── main ─────────────────────────────────────────────────────────────────────────
const forcar = process.argv.includes("--forcar");
const xml = await obterXml(forcar);
const { livros, totalVers } = gerar(xml);
const bytes = escrever(livros);
const ajustes = [...contagem.entries()].map(([k, v]) => `${v}× ${k}`).join(", ");
console.log(
  `biblia: ${livros.length} livros · 1189 capítulos · ${totalVers} versículos · ${(bytes / 1024 / 1024).toFixed(1)} MB em ${SAIDA}`,
);
console.log(`biblia: ortografia 2009 — ${ajustes || "nenhum ajuste"}`);
