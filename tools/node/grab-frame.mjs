#!/usr/bin/env node
/**
 * grab-frame.mjs — captura un frame COHERENTE de la instancia EN MARCHA (sin relanzar),
 * congelando la CPU por canal lateral (lock takeover) para leer registros y bitplanes
 * de forma consistente, y decodifica a PNG.
 *
 * Uso:
 *   node grab-frame.mjs --config out\game.uae --out out\display\frame.png [--prefix frame]
 *
 * Nota: NO lanza el emulador; usa el que esté corriendo en el puerto del canal lateral.
 */

import * as fs from 'node:fs';
import * as path from 'node:path';
import { WinUAE, sleep } from './winuae-session.mjs';

function parseArgs(argv) {
  const a = {};
  for (let i = 2; i < argv.length; i++) {
    if (argv[i].startsWith('--')) a[argv[i].slice(2)] = argv[i + 1];
  }
  return a;
}
const args = parseArgs(process.argv);
const outDir = path.resolve(args.out || 'out/display');
const prefix = args.prefix || 'frame';
const uae = new WinUAE({ configFile: args.config || 'unused.uae', adf: undefined });

try {
  const creg = await (async () => {
    await uae.sideLock('acquire', 'takeover');
    await uae.sidePause();
    await sleep(350);
    const c = await uae.sideMem(0xdff080, 0x140); // COP1LC..COLOR31
    return c;
  })();

  const base = 0x80;
  const r = (o) => (creg[o - base] << 8) | creg[o - base + 1];
  const cop = (((r(0x80) & 0xff) << 16) | r(0x82)) >>> 0;
  const bplcon0 = r(0x100);
  const depth = Math.max(1, (bplcon0 >> 12) & 7);
  const bpl = (n) => (((r(0xe0 + (n - 1) * 4) & 0xff) << 16) | r(0xe2 + (n - 1) * 4)) >>> 0;
  const bpl1 = bpl(1);
  const step = depth >= 2 ? bpl(2) - bpl1 : 0;
  let rowBytes, layout;
  if (step > 0 && step <= 128 && (step & 1) === 0) { rowBytes = step; layout = 'interleaved'; }
  else { rowBytes = Math.ceil(320 / 16) * 2; layout = 'planar'; }
  const width = rowBytes * 8;
  const height = 256;

  console.log(`COP1LC=${cop.toString(16)} BPLCON0=${bplcon0.toString(16)} depth=${depth}`);
  console.log(`BPL1=${bpl1.toString(16)} step=${step} -> rowBytes=${rowBytes} width=${width} layout=${layout} height=${height}`);

  const bytes = rowBytes * height * depth;
  let data;
  if (layout === 'planar') {
    const parts = [];
    for (let n = 1; n <= depth; n++) parts.push(await uae.sideMem(bpl(n), rowBytes * height));
    data = Buffer.concat(parts);
  } else {
    data = await uae.sideMem(bpl1, bytes);
  }

  const palette = [];
  for (let i = 0; i < 32; i++) {
    const v = r(0x180 + i * 2);
    palette.push('#' + [((v >> 8) & 0xf) * 17, ((v >> 4) & 0xf) * 17, (v & 0xf) * 17].map((x) => x.toString(16).padStart(2, '0')).join(''));
  }

  await uae.sideScreenshot(path.join(outDir, `${prefix}-screenshot.png`)).catch(() => {});
  await uae.sideResume();
  await uae.sideLock('release');

  fs.mkdirSync(outDir, { recursive: true });
  fs.writeFileSync(path.join(outDir, `${prefix}-bitplanes.bin`), data);
  fs.writeFileSync(path.join(outDir, `${prefix}-palette.json`), JSON.stringify(palette, null, 2));
  const bd = await import('file:///C:/Users/dvdjg/Documents/programa/AI/Amiga/mcp-winuae-emu/dist/bitmap-decode.js');
  const req = bd.normalizeBitmapDecodeRequest({ width, height, depth, rowBytes, layout, colorMode: 'direct' });
  const dec = bd.decodePlanarBitmap(data, req, undefined, palette);
  fs.writeFileSync(path.join(outDir, `${prefix}.png`), bd.encodePngRgba(dec.width, dec.height, dec.rgba));
  console.log(`PNG -> ${path.join(outDir, `${prefix}.png`)}`);
} catch (e) {
  console.error('ERROR:', e.message);
  try { await uae.sideResume(); await uae.sideLock('release'); } catch {}
  process.exit(1);
}
