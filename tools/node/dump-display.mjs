#!/usr/bin/env node
/**
 * dump-display.mjs — captura el estado de vídeo y lo extrae a fichero.
 *
 * Usa el CANAL LATERAL (puerto 2346) para leer registros custom y la Copperlist,
 * porque la lectura de registros custom por GDB NO es fiable (devuelve valores
 * erroneos p.ej. en BPLCON0). Sondea (en marcha) hasta que el display está activo
 * (BPLCON0 con planos y BPL1 != 0), luego pausa y lee los bitplanes por GDB.
 *
 * Salida en <out>/display/:
 *   <prefix>-custom.json, -copper.txt, -copper.bin, -palette.json,
 *   -bitplanes.bin, -interleaved.png, -planar.png, -screenshot.png
 *
 * Uso:
 *   node dump-display.mjs --config <x.uae> --adf <x.adf> [--boot 20] [--out <dir>]
 *                         [--prefix <name>] [--width 320] [--height 256]
 */

import * as fs from 'node:fs';
import * as path from 'node:path';
import { WinUAE, sleep } from './winuae-session.mjs';

function parseArgs(argv) {
  const a = {};
  for (let i = 2; i < argv.length; i++) {
    const k = argv[i];
    if (k.startsWith('--')) { a[k.slice(2)] = argv[i + 1] && !argv[i + 1].startsWith('--') ? argv[++i] : true; }
  }
  return a;
}
const args = parseArgs(process.argv);
if (!args.config) { console.error('falta --config'); process.exit(2); }
const out = path.resolve(args.out || 'out');
const prefix = args.prefix || 'display';
const boot = parseInt(args.boot || '20', 10);
const uae = new WinUAE({ configFile: args.config, adf: args.adf, winuaeDir: args.winuae, exe: args.exe });

const hexToBuf = (h) => Buffer.from(h, 'hex');
async function sideRegs(base = 0xdff000, len = 0x1c0) {
  const r = await uae.side(`mem ${base.toString(16)} ${len.toString(16)}`);
  return hexToBuf(r.data);
}

function decodeCopper(buf, base) {
  const moves = [];
  const regs = new Map();
  for (let i = 0; i + 4 <= buf.length; i += 4) {
    const w1 = (buf[i] << 8) | buf[i + 1], w2 = (buf[i + 2] << 8) | buf[i + 3];
    if ((w1 & 1) === 0) {
      const reg = w1 & 0x1fe;
      if (!regs.has(reg)) regs.set(reg, w2);
      moves.push(`${(base + i).toString(16)}: move.w #$${w2.toString(16).padStart(4, '0')}, $dff${reg.toString(16).padStart(3, '0')}`);
    } else if (w2 === 0) moves.push(`${(base + i).toString(16)}: WAIT $${(w1 & 0x1fe).toString(16)}`);
    else moves.push(`${(base + i).toString(16)}: SKIP $${(w1 & 0x1fe).toString(16)}`);
  }
  return { moves, regs };
}
const pal16 = (v) => '#' + [((v >> 8) & 0xf) * 17, ((v >> 4) & 0xf) * 17, (v & 0xf) * 17].map((x) => x.toString(16).padStart(2, '0')).join('');

try {
  await uae.open();
  await uae.resume();
  console.log(`booteando ${boot}s...`);
  await sleep(boot * 1000);

  const outDir = path.join(out, 'display');
  fs.mkdirSync(outDir, { recursive: true });

  const REGBASE = 0x80;
  let creg = null, cop = 0, parsed = null, bplcon0 = 0, depth = 0, bpl1 = 0;
  const r = (off) => ((creg[off - REGBASE] << 8) | creg[off - REGBASE + 1]);
  for (let i = 0; i < 60; i++) {
    creg = await sideRegs(0xdff080, 0x140);
    cop = (((r(0x80) & 0xff) << 16) | r(0x82)) >>> 0;
    try {
      const rr = await uae.side(`mem ${cop.toString(16)} 0x800`);
      parsed = decodeCopper(hexToBuf(rr.data), cop);
    } catch { parsed = null; }
    bplcon0 = r(0x100);
    depth = (bplcon0 >> 12) & 7;
    bpl1 = (((r(0xe0) & 0xff) << 16) | r(0xe2)) >>> 0;
    if (depth > 0 && depth <= 6 && bpl1 >= 0x400) break;
    console.log(`  esperando display activo (BPLCON0=${bplcon0.toString(16)} depth=${depth} BPL1=${bpl1.toString(16)} COP1LC=${cop.toString(16)})`);
    await sleep(500);
  }
  console.log(`display: BPLCON0=${bplcon0.toString(16)} depth=${depth} BPL1=${bpl1.toString(16)} COP1LC=${cop.toString(16)}`);

  await uae.pauseRetry();
  const named = {};
  for (let off = 0x80; off < 0x1c0; off += 2) named['0x' + off.toString(16).padStart(3, '0')] = r(off).toString(16).padStart(4, '0');
  fs.writeFileSync(path.join(outDir, `${prefix}-custom.json`), JSON.stringify(named, null, 2));

  if (parsed) {
    fs.writeFileSync(path.join(outDir, `${prefix}-copper.txt`), parsed.moves.join('\n'));
    const r = await uae.side(`mem ${cop.toString(16)} 0x800`);
    fs.writeFileSync(path.join(outDir, `${prefix}-copper.bin`), hexToBuf(r.data));
  }
  const palette = [];
  for (let i = 0; i < 32; i++) palette.push(pal16(r(0x180 + i * 2)));
  fs.writeFileSync(path.join(outDir, `${prefix}-palette.json`), JSON.stringify(palette, null, 2));

  const width = args.width ? parseInt(args.width, 10) : 320;
  const height = args.height ? parseInt(args.height, 10) : 256;
  const rowBytes = Math.ceil(width / 16) * 2;
  const planeSize = rowBytes * height;
  const bplOf = (n) => (((r(0xe0 + (n - 1) * 4) & 0xff) << 16) | r(0xe2 + (n - 1) * 4)) >>> 0;
  const step = bplOf(2) - bplOf(1);
  let layout = 'interleaved';
  if (step >= planeSize - rowBytes) layout = 'planar';
  console.log(`width=${width} height=${height} rowBytes=${rowBytes} planeSize=${planeSize} stepBPL2-BPL1=${step} layout=${layout}`);

  const bd = await import('file:///C:/Users/dvdjg/Documents/programa/AI/Amiga/mcp-winuae-emu/dist/bitmap-decode.js');
  try {
    let bpl;
    if (layout === 'planar') {
      const parts = [];
      for (let n = 1; n <= depth; n++) parts.push(await uae.readExact(bplOf(n), planeSize));
      bpl = Buffer.concat(parts);
    } else {
      bpl = await uae.readExact(bpl1, planeSize * depth);
    }
    fs.writeFileSync(path.join(outDir, `${prefix}-bitplanes.bin`), bpl);
    const req = bd.normalizeBitmapDecodeRequest({ width, height, depth, rowBytes, layout, colorMode: 'direct' });
    const dec = bd.decodePlanarBitmap(bpl, req, undefined, palette);
    fs.writeFileSync(path.join(outDir, `${prefix}.png`), bd.encodePngRgba(dec.width, dec.height, dec.rgba));
    console.log(`PNG -> ${prefix}.png`);
  } catch (e) {
    console.error('decode fallo:', e.message);
  }

  try { await uae.screenshot(path.join(outDir, `${prefix}-screenshot.png`)); console.log('screenshot guardado'); } catch (e) { console.error('screenshot:', e.message); }

  await uae.close(true);
} catch (e) {
  console.error('ERROR:', e.stack || e.message);
  try { await uae.close(true); } catch {}
  process.exit(1);
}
