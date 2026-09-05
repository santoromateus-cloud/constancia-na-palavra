// ─────────────────────────────────────────────────────────────────────────────
//  CONSTÂNCIA NA PALAVRA — gera o litoral do mapa "Onde tudo aconteceu"
//
//  Baixa três arquivos do Natural Earth 10m (domínio público): terra, lagos e rios.
//  Recorta na caixa lon -12..50 / lat 20..48 (Espanha a Mesopotâmia, Egito a Grécia),
//  simplifica (Douglas–Peucker), tira ilhota, escolhe só os lagos e rios que a
//  história pede (Galileia, mar Morto, lago Amargo; Nilo, Eufrates, Tigre, Jordão)
//  e escreve src/lib/litoral.ts — que NÃO vai pro git: são 56 KB de coordenadas que
//  não mudam, e o conector do GitHub não passa arquivo desse tamanho com segurança.
//  Mesma regra do texto da Bíblia (scripts/gerar-biblia.mjs): o repo guarda a receita.
//
//  Fonte fixada por commit + SHA-256: mudou o upstream, o build para em vez de subir
//  um mapa diferente calado. Cache em node_modules/.cache (sobrevive entre builds).
//
//  Uso:  node scripts/gerar-litoral.mjs          (baixa se precisar, gera)
//        node scripts/gerar-litoral.mjs --forcar  (ignora o cache)
// ─────────────────────────────────────────────────────────────────────────────
import { createHash } from "node:crypto";
import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const RAIZ = join(dirname(fileURLToPath(import.meta.url)), "..");
const COMMIT = "ace5fed0eaf3c6c03c951e75b439ba8fffbc218e"; // nvkelso/natural-earth-vector
const FONTES = {
  terra: { arquivo: "ne_10m_land.geojson", sha256: "1ac90796408bc6ad6911d69448485d3c4dbf2190370080368a09976e1c9f7416" },
  lagos: { arquivo: "ne_10m_lakes.geojson", sha256: "2d036f53dedec578001c5c30c2959ee7d4eebc1306900fa4367c49929ec8f2d9" },
  rios: { arquivo: "ne_10m_rivers_lake_centerlines.geojson", sha256: "bb854a900ecbd3b408df46d5e16e3e0f974ba55993f9d8b5c26e855273c0905a" },
};
const CACHE = join(RAIZ, "node_modules", ".cache", "litoral");
const SAIDA = join(RAIZ, "src", "lib", "litoral.ts");

const LON0 = -12.0, LON1 = 50.0, LAT0 = 20.0, LAT1 = 48.0;

const sha256 = (s) => createHash("sha256").update(s).digest("hex");

async function obter(chave, forcar) {
  const { arquivo, sha256: esperado } = FONTES[chave];
  const local = join(CACHE, `${COMMIT.slice(0, 10)}-${arquivo}`);
  if (!forcar && existsSync(local)) {
    const buf = readFileSync(local);
    if (sha256(buf) === esperado) return JSON.parse(buf.toString("utf8"));
    console.log(`litoral: cache de ${arquivo} com hash diferente — baixando de novo`);
  }
  const url = `https://raw.githubusercontent.com/nvkelso/natural-earth-vector/${COMMIT}/geojson/${arquivo}`;
  console.log(`litoral: baixando ${arquivo}`);
  const resp = await fetch(url);
  if (!resp.ok) throw new Error(`litoral: download de ${arquivo} falhou (${resp.status})`);
  const buf = Buffer.from(await resp.arrayBuffer());
  const hash = sha256(buf);
  if (hash !== esperado) {
    throw new Error(`litoral: ${arquivo} não é o esperado.\n  esperado ${esperado}\n  recebido ${hash}`);
  }
  mkdirSync(CACHE, { recursive: true });
  writeFileSync(local, buf);
  return JSON.parse(buf.toString("utf8"));
}

// ── geometria ──
function recortar(anel, x0, y0, x1, y1) {
  const passo = (pts, dentro, cruza) => {
    const out = [];
    if (!pts.length) return out;
    let prev = pts[pts.length - 1];
    for (const cur of pts) {
      if (dentro(cur)) {
        if (!dentro(prev)) out.push(cruza(prev, cur));
        out.push(cur);
      } else if (dentro(prev)) out.push(cruza(prev, cur));
      prev = cur;
    }
    return out;
  };
  const ix = (x) => (a, b) => { const t = (x - a[0]) / (b[0] - a[0]); return [x, a[1] + t * (b[1] - a[1])]; };
  const iy = (y) => (a, b) => { const t = (y - a[1]) / (b[1] - a[1]); return [a[0] + t * (b[0] - a[0]), y]; };
  let p = anel;
  p = passo(p, (q) => q[0] >= x0, ix(x0));
  p = passo(p, (q) => q[0] <= x1, ix(x1));
  p = passo(p, (q) => q[1] >= y0, iy(y0));
  p = passo(p, (q) => q[1] <= y1, iy(y1));
  return p;
}

function dp(pts, tol) {
  if (pts.length < 3) return pts;
  const d = (p, a, b) => {
    const [x, y] = p, [x1, y1] = a, [x2, y2] = b;
    const dx = x2 - x1, dy = y2 - y1;
    if (dx === 0 && dy === 0) return Math.hypot(x - x1, y - y1);
    const t = Math.max(0, Math.min(1, ((x - x1) * dx + (y - y1) * dy) / (dx * dx + dy * dy)));
    return Math.hypot(x - (x1 + t * dx), y - (y1 + t * dy));
  };
  const keep = new Array(pts.length).fill(false);
  keep[0] = keep[pts.length - 1] = true;
  const stack = [[0, pts.length - 1]];
  while (stack.length) {
    const [i, j] = stack.pop();
    if (j <= i + 1) continue;
    let m = -1, md = -1;
    for (let k = i + 1; k < j; k++) {
      const dd = d(pts[k], pts[i], pts[j]);
      if (dd > md) { md = dd; m = k; }
    }
    if (md > tol) { keep[m] = true; stack.push([i, m]); stack.push([m, j]); }
  }
  return pts.filter((_, k) => keep[k]);
}

const aneisDe = (g) => g.type === "Polygon" ? g.coordinates : g.type === "MultiPolygon" ? g.coordinates.flat() : [];
const linhasDe = (g) => g.type === "LineString" ? [g.coordinates] : g.type === "MultiLineString" ? g.coordinates : [];
// Arredonda como o Python: round() em número já com poucas casas; toFixed e Number tiram o zero à direita
const arred = (pts, nd) => pts.map((p) => [Number(p[0].toFixed(nd)), Number(p[1].toFixed(nd))]);
function semRepetido(pts) {
  const out = [];
  for (const p of pts) if (!out.length || out[out.length - 1][0] !== p[0] || out[out.length - 1][1] !== p[1]) out.push(p);
  return out;
}

function gerar(land, lakes, rivers) {
  const terra = [];
  for (const f of land.features) {
    for (const anel of aneisDe(f.geometry)) {
      const xs = anel.map((p) => p[0]), ys = anel.map((p) => p[1]);
      if (Math.max(...xs) < LON0 || Math.min(...xs) > LON1 || Math.max(...ys) < LAT0 || Math.min(...ys) > LAT1) continue;
      const c = recortar(anel.map((p) => [p[0], p[1]]), LON0, LAT0, LON1, LAT1);
      if (c.length < 4) continue;
      const s = semRepetido(arred(dp(c, 0.025), 2));
      const sx = s.map((p) => p[0]), sy = s.map((p) => p[1]);
      if (s.length >= 4 && (Math.max(...sx) - Math.min(...sx) >= 0.15 || Math.max(...sy) - Math.min(...sy) >= 0.15)) terra.push(s);
    }
  }
  const QUERO = new Set(["Sea of Galilee", "Dead Sea", "Great Bitter Lake"]);
  const lagos = [];
  for (const f of lakes.features) {
    if (!QUERO.has(f.properties?.name)) continue;
    for (const anel of aneisDe(f.geometry)) {
      const s = semRepetido(arred(dp(anel.map((p) => [p[0], p[1]]), 0.003), 3));
      if (s.length >= 4) lagos.push(s);
    }
  }
  const rios = [];
  for (const f of rivers.features) {
    const n = f.properties?.name ?? "";
    if (f.properties?.featurecla !== "River") continue;
    let tol, nd;
    if (n === "Nile" || n === "Euphrates" || n === "Tigris") { tol = 0.03; nd = 2; }
    else if (n === "Jordan") { tol = 0.003; nd = 3; }
    else continue;
    for (const ln of linhasDe(f.geometry)) {
      const pts = ln.filter((p) => LON0 <= p[0] && p[0] <= LON1 && LAT0 <= p[1] && p[1] <= LAT1).map((p) => [p[0], p[1]]);
      if (pts.length < 2) continue;
      const s = semRepetido(arred(dp(pts, tol), nd));
      if (s.length >= 2) rios.push({ n, p: s });
    }
  }
  return { terra, lagos, rios };
}

const fmt = (aneis) => "[" + aneis.map((a) => "[" + a.map((p) => `[${p[0]},${p[1]}]`).join(",") + "]").join(",") + "]";

const forcar = process.argv.includes("--forcar");
const [land, lakes, rivers] = await Promise.all([obter("terra", forcar), obter("lagos", forcar), obter("rios", forcar)]);
const { terra, lagos, rios } = gerar(land, lakes, rivers);
if (terra.length < 40 || lagos.length < 3 || rios.length < 8) {
  throw new Error(`litoral: saída magra demais (terra ${terra.length}, lagos ${lagos.length}, rios ${rios.length})`);
}
let ts = "// GERADO por scripts/gerar-litoral.mjs a partir de Natural Earth 10m (domínio público),\n";
ts += `// recortado em lon ${LON0.toFixed(1)}..${LON1.toFixed(1)}, lat ${LAT0.toFixed(1)}..${LAT1.toFixed(1)} e simplificado (Douglas–Peucker).\n`;
ts += "// Coordenadas [lon, lat]. Terra: anéis de polígono. Lagos: anéis. Rios: polilinhas.\n";
ts += `/** Caixa do recorte dos dados — as bordas artificiais dos anéis ficam nela. */\nexport const CAIXA = { x0: ${LON0.toFixed(1)}, x1: ${LON1.toFixed(1)}, y0: ${LAT0.toFixed(1)}, y1: ${LAT1.toFixed(1)} };\n`;
ts += "export const TERRA: number[][][] = " + fmt(terra) + ";\n";
ts += "export const LAGOS: number[][][] = " + fmt(lagos) + ";\n";
ts += "export const RIOS: { n: string; p: number[][] }[] = [" + rios.map((r) => `{n:"${r.n}",p:[${r.p.map((p) => `[${p[0]},${p[1]}]`).join(",")}]}`).join(",") + "];\n";
writeFileSync(SAIDA, ts);
console.log(`litoral: ${terra.length} anéis de terra · ${lagos.length} lagos · ${rios.length} rios · ${(Buffer.byteLength(ts) / 1024).toFixed(0)} KB em ${SAIDA}`);
