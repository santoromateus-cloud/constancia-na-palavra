// ── Os lugares do caminho "Onde tudo aconteceu" ──────────────────────────────
// Cada dia do caminho tem um `geografia_lugar` no banco (ex.: "Ur, Harã e Siquém").
// Esta tabela casa esse texto, normalizado, com pontos de verdade (latitude e
// longitude) e, nos dias em que o lugar é um TRAJETO, com a rota na ordem da
// história — a distância vem calculada (haversine) e aparece no mapa.
//
// Regras:
// · Coordenadas são dos sítios tradicionais (Jebel Musa para o Sinai, Banias para
//   Cesareia de Filipe, Qubeibeh para Emaús). Aproximações de mapa ilustrado, não
//   de atlas: o que importa é a posição relativa e a escala da caminhada.
// · Dia sem entrada aqui = sem mapa, e o card de texto segue igual (fallback
//   silencioso, mesma disciplina das camadas).
// · `rota` = o trajeto principal (linha cheia, distância no rótulo).
//   `volta` = trajeto de retorno (linha tracejada, soma na distância "ida e volta").
//   `contexto` = traços de apoio (estrada, rota alternativa), sem distância.
//   `rotulo` = só o nome no mapa, sem marcador (mares, regiões).

export type Ponto = {
  nome: string
  lat: number
  lon: number
  /** principal = marcador cheio; apoio = marcador discreto; rotulo = só texto */
  tipo?: 'principal' | 'apoio' | 'rotulo'
  /** de que lado do ponto o nome fica */
  lado?: 'dir' | 'esq' | 'cima' | 'baixo'
}

export type Traco = {
  pontos: Ponto[]
  nome?: string
  /** onde o nome do traço fica (padrão: meio do caminho) */
  rotuloEm?: { lat: number; lon: number }
}

export type MapaDia = {
  pontos: Ponto[]
  rota?: Ponto[]
  volta?: Ponto[]
  contexto?: Traco[]
  /** meia-largura do enquadramento em km (quando só há um ponto, ou para dar ar) */
  raioKm?: number
  /** onde a distância fica (padrão: meio da rota) */
  distanciaEm?: { lat: number; lon: number }
  /** altura/largura do quadro (padrão 0.6); mapas muito largos pedem menos */
  proporcao?: number
  /** linha curta embaixo do mapa */
  nota?: string
}

// ── pontos reutilizados ──
const P = {
  ur: { nome: 'Ur', lat: 30.963, lon: 46.103 },
  hara: { nome: 'Harã', lat: 36.866, lon: 39.032 },
  siquem: { nome: 'Siquém', lat: 32.213, lon: 35.282 },
  betel: { nome: 'Betel', lat: 31.93, lon: 35.222 },
  jerico: { nome: 'Jericó', lat: 31.871, lon: 35.444 },
  jerusalem: { nome: 'Jerusalém', lat: 31.778, lon: 35.235 },
  belem: { nome: 'Belém', lat: 31.705, lon: 35.203 },
  hebrom: { nome: 'Hebrom', lat: 31.532, lon: 35.098 },
  berseba: { nome: 'Berseba', lat: 31.245, lon: 34.792 },
  nazare: { nome: 'Nazaré', lat: 32.702, lon: 35.298 },
  cana: { nome: 'Caná', lat: 32.747, lon: 35.339 },
  betesea: { nome: 'Bete-Seã', lat: 32.503, lon: 35.499 },
  jope: { nome: 'Jope', lat: 32.053, lon: 34.752 },
  gaza: { nome: 'Gaza', lat: 31.501, lon: 34.466 },
  damasco: { nome: 'Damasco', lat: 33.513, lon: 36.292 },
  marMorto: { nome: 'mar Morto', lat: 31.45, lon: 35.49, tipo: 'rotulo' as const },
  galileia: { nome: 'mar da Galileia', lat: 32.79, lon: 35.6, tipo: 'rotulo' as const },
  mediterraneo: { nome: 'Mediterrâneo', lat: 32.9, lon: 34.6, tipo: 'rotulo' as const },
}

const CAMINHO_DA_CORDILHEIRA: Ponto[] = [
  P.berseba, P.hebrom, P.belem, P.jerusalem, P.betel, P.siquem,
  { nome: 'Dotã', lat: 32.41, lon: 35.2 },
]

// ── os 21 dias ──
// A chave é o geografia_lugar do banco, normalizado por `chave()` (minúsculas, sem
// acento, sem pontuação). Mudou o texto no banco sem mudar aqui → o dia perde o mapa,
// não quebra.
const MAPAS: Record<string, MapaDia> = {
  // 1 · Gênesis 12
  'ur hara e siquem': {
    pontos: [
      { ...P.ur, tipo: 'principal', lado: 'esq' },
      { ...P.hara, tipo: 'principal', lado: 'dir' },
      { ...P.siquem, tipo: 'principal', lado: 'dir' },
      { nome: 'Canaã', lat: 31.3, lon: 35.0, tipo: 'rotulo' },
      { nome: 'Mesopotâmia', lat: 33.9, lon: 43.6, tipo: 'rotulo' },
    ],
    rota: [P.ur, P.hara, P.siquem],
    nota: 'O arco do Crescente Fértil: sobe pelo Eufrates, desce por Canaã.',
  },
  // 2 · Gênesis 13
  'betel e o vale do jordao': {
    pontos: [
      { ...P.betel, tipo: 'principal', lado: 'esq' },
      { nome: 'campina do Jordão', lat: 31.86, lon: 35.5, tipo: 'principal', lado: 'dir' },
      { ...P.jerico, tipo: 'apoio', lado: 'baixo' },
      { ...P.marMorto, lat: 31.55 },
    ],
    rota: [P.betel, { nome: 'campina do Jordão', lat: 31.86, lon: 35.5 }],
    distanciaEm: { lat: 31.95, lon: 35.38 },
    raioKm: 32,
    nota: 'De quase 900 m acima do mar para 250 m abaixo dele.',
  },
  // 3 · Gênesis 28
  'betel a estrada do meio': {
    pontos: [
      { ...P.betel, tipo: 'principal', lado: 'dir' },
      { ...P.jerusalem, tipo: 'apoio', lado: 'dir' },
      { ...P.siquem, tipo: 'apoio', lado: 'dir' },
      { ...P.hebrom, tipo: 'apoio', lado: 'dir' },
      { ...P.marMorto },
    ],
    contexto: [{ pontos: CAMINHO_DA_CORDILHEIRA, nome: 'a estrada da cordilheira', rotuloEm: { lat: 31.42, lon: 34.86 } }],
    raioKm: 70,
    nota: 'A estrada da montanha que corta Canaã de norte a sul — e Betel no acostamento.',
  },
  // 4 · Êxodo 14
  'o mar dos juncos': {
    pontos: [
      { nome: 'mar dos Juncos', lat: 30.33, lon: 32.38, tipo: 'principal', lado: 'dir' },
      { nome: 'Ramessés', lat: 30.8, lon: 31.83, tipo: 'apoio', lado: 'cima' },
      { nome: 'delta do Nilo', lat: 31.05, lon: 30.9, tipo: 'rotulo' },
      { nome: 'deserto do Sinai', lat: 30.0, lon: 33.4, tipo: 'rotulo' },
    ],
    contexto: [
      {
        pontos: [
          { nome: 'Ramessés', lat: 30.8, lon: 31.83 },
          { nome: 'Sucote', lat: 30.55, lon: 32.05 },
          { nome: 'mar dos Juncos', lat: 30.33, lon: 32.38 },
        ],
        nome: 'a saída do Egito',
      },
    ],
    raioKm: 110,
    nota: 'Os lagos rasos do istmo, a leste do delta: o Yam Suf.',
  },
  // 5 · Êxodo 19
  'o sinai': {
    pontos: [
      { nome: 'monte Sinai', lat: 28.54, lon: 33.975, tipo: 'principal', lado: 'dir' },
      { nome: 'golfo de Suez', lat: 29.1, lon: 32.95, tipo: 'rotulo' },
      { nome: 'golfo de Ácaba', lat: 29.1, lon: 34.85, tipo: 'rotulo' },
      { nome: 'Egito', lat: 30.15, lon: 31.6, tipo: 'rotulo' },
      { nome: 'Canaã', lat: 31.1, lon: 34.9, tipo: 'rotulo' },
    ],
    raioKm: 240,
    nota: 'Uma península de granito entre os dois braços do mar Vermelho. Terra de ninguém.',
  },
  // 6 · Números 20
  'cades barneia': {
    pontos: [
      { nome: 'Cades-Barneia', lat: 30.645, lon: 34.428, tipo: 'principal', lado: 'baixo' },
      { ...P.berseba, tipo: 'apoio', lado: 'cima' },
      { nome: 'deserto de Zim', lat: 30.72, lon: 34.95, tipo: 'rotulo' },
      { nome: 'Canaã', lat: 31.42, lon: 34.95, tipo: 'rotulo' },
    ],
    contexto: [{ pontos: [{ nome: 'Cades-Barneia', lat: 30.645, lon: 34.428 }, P.berseba], nome: 'poucos dias de marcha' }],
    raioKm: 95,
    nota: 'Um oásis à porta da terra prometida. Perto para ver, longe para não entrar.',
  },
  // 7 · Josué 3
  'o jordao na cheia': {
    pontos: [
      { nome: 'a travessia', lat: 31.837, lon: 35.552, tipo: 'principal', lado: 'dir' },
      { ...P.jerico, tipo: 'apoio', lado: 'esq' },
      { ...P.marMorto, lat: 31.62, lon: 35.5 },
    ],
    raioKm: 30,
    nota: 'O rio que se atravessa a vau o ano inteiro — menos no mês em que eles atravessam.',
  },
  // 8 · Josué 6
  jerico: {
    pontos: [
      { ...P.jerico, tipo: 'principal', lado: 'dir' },
      { ...P.jerusalem, tipo: 'apoio', lado: 'esq' },
      { ...P.marMorto, lat: 31.62, lon: 35.5 },
    ],
    contexto: [{ pontos: [P.jerico, P.jerusalem], nome: 'a subida para as montanhas' }],
    raioKm: 40,
    nota: 'A porta de Canaã vindo do leste, 250 m abaixo do nível do mar.',
  },
  // 9 · Juízes 7
  'a fonte de harode e o vale de jezreel': {
    pontos: [
      { nome: 'fonte de Harode', lat: 32.554, lon: 35.357, tipo: 'principal', lado: 'baixo' },
      { nome: 'monte Gilboa', lat: 32.48, lon: 35.42, tipo: 'apoio', lado: 'baixo' },
      { nome: 'Megido', lat: 32.585, lon: 35.184, tipo: 'apoio', lado: 'esq' },
      { ...P.betesea, tipo: 'apoio', lado: 'dir' },
      { nome: 'vale de Jezreel', lat: 32.64, lon: 35.3, tipo: 'rotulo' },
    ],
    contexto: [{ pontos: [{ nome: 'Megido', lat: 32.585, lon: 35.184 }, { nome: 'Jezreel', lat: 32.559, lon: 35.327 }, P.betesea], nome: 'o corredor dos exércitos', rotuloEm: { lat: 32.5, lon: 35.22 } }],
    raioKm: 40,
    nota: 'A planície mais fértil e mais disputada de Israel: quem dominava Jezreel dominava a estrada.',
  },
  // 10 · 1 Samuel 17
  'o vale de ela': {
    pontos: [
      { nome: 'vale de Elá', lat: 31.692, lon: 34.96, tipo: 'principal', lado: 'baixo' },
      { ...P.belem, tipo: 'apoio', lado: 'dir' },
      { nome: 'planície filisteia', lat: 31.72, lon: 34.68, tipo: 'rotulo' },
      { nome: 'montanhas de Judá', lat: 31.58, lon: 35.13, tipo: 'rotulo' },
    ],
    contexto: [{ pontos: [P.belem, { nome: 'vale de Elá', lat: 31.692, lon: 34.96 }], nome: 'Davi desce de Belém' }],
    raioKm: 38,
    nota: 'Uma garganta entre a planície dos filisteus e as montanhas de Judá.',
  },
  // 11 · 2 Samuel 5
  'jerusalem a cidade de davi': {
    pontos: [
      { ...P.jerusalem, tipo: 'principal', lado: 'dir' },
      { ...P.belem, tipo: 'apoio', lado: 'dir' },
      { ...P.jerico, tipo: 'apoio', lado: 'dir' },
      { ...P.betel, tipo: 'apoio', lado: 'dir' },
      { ...P.marMorto, lat: 31.6, lon: 35.5 },
    ],
    raioKm: 38,
    nota: 'Um esporão de rocha entre dois vales, com uma única fonte — e de tribo nenhuma.',
  },
  // 12 · 1 Reis 18
  'o monte carmelo': {
    pontos: [
      { nome: 'monte Carmelo', lat: 32.673, lon: 35.063, tipo: 'principal', lado: 'baixo' },
      { nome: 'Jezreel', lat: 32.559, lon: 35.327, tipo: 'apoio', lado: 'dir' },
      { ...P.mediterraneo, lat: 32.85, lon: 34.8 },
    ],
    raioKm: 45,
    nota: 'A cordilheira que avança sobre o mar, onde mais chove — o quintal de Baal.',
  },
  // 13 · Jonas 1
  'jope e tarsis': {
    pontos: [
      { ...P.jope, tipo: 'principal', lado: 'baixo' },
      { nome: 'Társis', lat: 37.0, lon: -6.6, tipo: 'principal', lado: 'cima' },
      { nome: 'Nínive', lat: 36.36, lon: 43.15, tipo: 'apoio', lado: 'cima' },
      { nome: 'Mediterrâneo', lat: 33.6, lon: 17.5, tipo: 'rotulo' },
    ],
    rota: [
      P.jope,
      { nome: 'sul de Creta', lat: 34.6, lon: 24.5 },
      { nome: 'sul da Sicília', lat: 36.1, lon: 14.2 },
      { nome: 'norte de Argel', lat: 37.3, lon: 3.0 },
      { nome: 'Gibraltar', lat: 35.95, lon: -5.6 },
      { nome: 'Társis', lat: 37.0, lon: -6.6 },
    ],
    contexto: [{ pontos: [P.jope, { nome: 'Nínive', lat: 36.36, lon: 43.15 }], nome: 'para onde Deus mandou', rotuloEm: { lat: 33.3, lon: 39.6 } }],
    proporcao: 0.46,
    nota: 'Nínive ficava a nordeste. Jonas comprou passagem para o ponto mais a oeste que um navio alcançava.',
  },
  // 14 · Daniel 1
  babilonia: {
    pontos: [
      { ...P.jerusalem, tipo: 'principal', lado: 'dir' },
      { nome: 'Babilônia', lat: 32.542, lon: 44.421, tipo: 'principal', lado: 'baixo' },
      { nome: 'Carquemis', lat: 36.83, lon: 38.01, tipo: 'apoio', lado: 'dir' },
      { nome: 'Eufrates', lat: 34.2, lon: 41.6, tipo: 'rotulo' },
      { nome: 'deserto da Síria', lat: 32.8, lon: 39.5, tipo: 'rotulo' },
    ],
    rota: [
      P.jerusalem,
      { nome: 'Ribla', lat: 34.46, lon: 36.53 },
      { nome: 'Carquemis', lat: 36.83, lon: 38.01 },
      { nome: 'Eufrates', lat: 35.34, lon: 40.15 },
      { nome: 'Babilônia', lat: 32.542, lon: 44.421 },
    ],
    distanciaEm: { lat: 34.6, lon: 40.3 },
    nota: 'Não se cruza o deserto: o caminho contorna pelo norte e desce o Eufrates.',
  },
  // 15 · Lucas 2
  belem: {
    pontos: [
      { ...P.belem, tipo: 'principal', lado: 'baixo' },
      { ...P.nazare, tipo: 'principal', lado: 'dir' },
      { ...P.jerusalem, tipo: 'apoio', lado: 'esq' },
      { ...P.jerico, tipo: 'apoio', lado: 'dir' },
      { ...P.marMorto, lat: 31.5, lon: 35.5 },
      { ...P.galileia, lat: 32.85, lon: 35.62 },
    ],
    rota: [P.nazare, P.betesea, P.jerico, P.jerusalem, P.belem],
    nota: 'De Nazaré a Belém pelo vale do Jordão, o caminho que dava a volta em Samaria.',
  },
  // 16 · Mateus 2
  'egito e nazare': {
    pontos: [
      { ...P.belem, tipo: 'principal', lado: 'esq' },
      { nome: 'Egito', lat: 30.129, lon: 31.307, tipo: 'principal', lado: 'baixo' },
      { ...P.nazare, tipo: 'principal', lado: 'esq' },
      { nome: 'Alexandria', lat: 31.2, lon: 29.92, tipo: 'apoio', lado: 'cima' },
      { ...P.gaza, tipo: 'apoio', lado: 'baixo' },
      { nome: 'deserto do Sinai', lat: 30.3, lon: 33.6, tipo: 'rotulo' },
    ],
    rota: [P.belem, P.gaza, { nome: 'El-Arish', lat: 31.13, lon: 33.8 }, { nome: 'Pelúsio', lat: 31.05, lon: 32.55 }, { nome: 'Egito', lat: 30.129, lon: 31.307 }],
    volta: [{ nome: 'Egito', lat: 30.129, lon: 31.307 }, { nome: 'Pelúsio', lat: 31.05, lon: 32.55 }, { nome: 'El-Arish', lat: 31.13, lon: 33.8 }, P.gaza, P.jope, P.nazare],
    nota: 'A fuga pela estrada da costa, e a volta para um vilarejo que o Antigo Testamento nem menciona.',
  },
  // 17 · Marcos 1
  'cafarnaum e o mar da galileia': {
    pontos: [
      { nome: 'Cafarnaum', lat: 32.881, lon: 35.575, tipo: 'principal', lado: 'cima' },
      { ...P.nazare, tipo: 'apoio', lado: 'baixo' },
      { ...P.galileia, lat: 32.78, lon: 35.6 },
    ],
    contexto: [{ pontos: [P.nazare, { nome: 'Cafarnaum', lat: 32.881, lon: 35.575 }], nome: 'da aldeia para a estrada', rotuloEm: { lat: 32.84, lon: 35.38 } }],
    raioKm: 32,
    nota: 'O lago 200 m abaixo do mar, cercado de morros — o vento desce e a tempestade sobe em minutos.',
  },
  // 18 · João 4
  'sicar e o poco de jaco': {
    pontos: [
      { nome: 'Sicar', lat: 32.215, lon: 35.29, tipo: 'principal', lado: 'esq' },
      { ...P.jerusalem, tipo: 'apoio', lado: 'esq' },
      { ...P.cana, tipo: 'apoio', lado: 'dir' },
      { nome: 'Samaria', lat: 32.0, lon: 34.86, tipo: 'rotulo' },
      { nome: 'Judeia', lat: 31.6, lon: 35.0, tipo: 'rotulo' },
      { nome: 'Galileia', lat: 32.85, lon: 35.25, tipo: 'rotulo' },
    ],
    rota: [P.jerusalem, { nome: 'Sicar', lat: 32.215, lon: 35.29 }, P.cana],
    distanciaEm: { lat: 32.5, lon: 35.14 },
    contexto: [{ pontos: [P.jerusalem, P.jerico, P.betesea, P.cana], nome: 'a volta pelo Jordão', rotuloEm: { lat: 32.08, lon: 35.78 } }],
    nota: 'O caminho curto passa por Samaria; a volta pelo Jordão era o desvio de quem não queria pisar ali.',
  },
  // 19 · Mateus 16
  'cesareia de filipe': {
    pontos: [
      { nome: 'Cesareia de Filipe', lat: 33.248, lon: 35.694, tipo: 'principal', lado: 'dir' },
      { nome: 'monte Hermon', lat: 33.416, lon: 35.857, tipo: 'apoio', lado: 'dir' },
      { nome: 'Cafarnaum', lat: 32.881, lon: 35.575, tipo: 'apoio', lado: 'esq' },
      { ...P.galileia, lat: 32.78, lon: 35.6 },
    ],
    raioKm: 45,
    nota: 'O extremo norte, no sopé do Hermon: o lugar mais pagão que Jesus visita.',
  },
  // 20 · Lucas 24
  'a estrada de emaus': {
    pontos: [
      { ...P.jerusalem, tipo: 'principal', lado: 'dir' },
      { nome: 'Emaús', lat: 31.842, lon: 35.136, tipo: 'principal', lado: 'baixo' },
      { ...P.belem, tipo: 'apoio', lado: 'dir' },
    ],
    rota: [P.jerusalem, { nome: 'Emaús', lat: 31.842, lon: 35.136 }],
    volta: [{ nome: 'Emaús', lat: 31.842, lon: 35.136 }, P.jerusalem],
    raioKm: 14,
    nota: 'Umas três horas de caminhada — e a volta na mesma noite.',
  },
  // 21 · Atos 17
  'atenas e o areopago': {
    pontos: [
      { nome: 'Atenas', lat: 37.976, lon: 23.727, tipo: 'principal', lado: 'dir' },
      { nome: 'Bereia', lat: 40.52, lon: 22.2, tipo: 'apoio', lado: 'dir' },
      { nome: 'Corinto', lat: 37.906, lon: 22.879, tipo: 'apoio', lado: 'esq' },
      { nome: 'mar Egeu', lat: 38.6, lon: 24.9, tipo: 'rotulo' },
    ],
    contexto: [
      { pontos: [{ nome: 'Bereia', lat: 40.52, lon: 22.2 }, { nome: 'Atenas', lat: 37.976, lon: 23.727 }], nome: 'veio de Bereia, por mar' },
      { pontos: [{ nome: 'Atenas', lat: 37.976, lon: 23.727 }, { nome: 'Corinto', lat: 37.906, lon: 22.879 }] },
    ],
    raioKm: 170,
    nota: 'O outeiro ao lado da Acrópole onde a cidade discutia ideias novas em público.',
  },
}

/* A faixa dos acentos combinantes (U+0300 a U+036F), montada com fromCharCode de
   propósito: escrita como escape no código-fonte, ela vira dois caracteres
   invisíveis na passagem pelo conector do GitHub — funciona igual, mas some do
   olho de quem lê. Assim fica legível e sem depender de editor nenhum. */
const ACENTOS = new RegExp(`[${String.fromCharCode(0x300)}-${String.fromCharCode(0x36f)}]`, 'g')

/** Normaliza o geografia_lugar do banco: minúsculas, sem acento, sem pontuação. */
export function chave(lugar: string): string {
  return lugar
    .normalize('NFD')
    .replace(ACENTOS, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, ' ')
    .trim()
}

export function mapaDoLugar(lugar: string | null | undefined): MapaDia | null {
  if (!lugar) return null
  return MAPAS[chave(lugar)] ?? null
}

/** Distância em km entre dois pontos (haversine). */
export function distanciaKm(a: { lat: number; lon: number }, b: { lat: number; lon: number }): number {
  const R = 6371
  const toRad = (d: number) => (d * Math.PI) / 180
  const dLat = toRad(b.lat - a.lat)
  const dLon = toRad(b.lon - a.lon)
  const s =
    Math.sin(dLat / 2) ** 2 + Math.cos(toRad(a.lat)) * Math.cos(toRad(b.lat)) * Math.sin(dLon / 2) ** 2
  return 2 * R * Math.asin(Math.sqrt(s))
}

/** Soma das pernas de um trajeto, em km. */
export function comprimentoKm(pontos: { lat: number; lon: number }[]): number {
  let total = 0
  for (let i = 1; i < pontos.length; i++) total += distanciaKm(pontos[i - 1], pontos[i])
  return total
}
