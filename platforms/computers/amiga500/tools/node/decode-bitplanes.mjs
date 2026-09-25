#!/usr/bin/env node
/**
 * decode-bitplanes.mjs — decodifica bitplanes Amiga de un volcado de RAM a PNG, OFFLINE.
 *
 * Útil para experimentar con direcciones/tamaños sin relanzar el emulador: se lee el
 * bloque de un fichero de volcado (con su dirección base) y se decodifica con
 * bitmap-decode de mcp-winuae-emu.
 *
 * Uso:
 *   node decode-bitplanes.mjs --file extraction/ram/chip000000.bin --base 0x0 \
 *     --addr 0x3a600 --width 320 --height 256 --depth 5 --rowbytes 40 \
 *     --layout interleaved --palette extraction/display/arte-title-palette.json --out extraction/display/try.png
 */

import * as fs from 'node:fs';
import * as path from 'node:path';

function parseArgs(argv) {
  const a = {};
  for (let i = 2; i < argv.length; i++) {
    if (argv[i].startsWith('--')) { a[argv[i].slice(2)] = argv[++i]; }
  }
  return a;
}
const n = (v, d) => (v === undefined ? d : (typeof v === 'string' && v.startsWith('0x') ? parseInt(v, 16) : parseInt(v, 10)));
const args = parseArgs(process.argv);
if (!args.file || !args.addr) { console.error('faltan --file y --addr'); process.exit(2); }

const base = n(args.base, 0);
const addr = n(args.addr, 0);
const width = n(args.width, 320);
const height = n(args.height, 256);
const depth = n(args.depth, 5);
const rowBytes = n(args.rowbytes, Math.ceil(width / 16) * 2);
const layout = args.layout || 'interleaved';
const data = fs.readFileSync(args.file);
const off = addr - base;
const bytes = rowBytes * height * depth;
if (off < 0 || off + bytes > data.length) {
  console.error(`fuera de rango: off=${off} bytes=${bytes} file=${data.length}`);
  process.exit(1);
}
const bpl = data.subarray(off, off + bytes);

let palette = null;
if (args.palette) {
  const p = JSON.parse(fs.readFileSync(args.palette, 'utf8'));
  palette = Array.isArray(p) ? p : (p.palette || null);
}

const bd = await import('file:///C:/Users/dvdjg/Documents/programa/AI/Amiga/mcp-winuae-emu/dist/bitmap-decode.js');
const req = bd.normalizeBitmapDecodeRequest({ width, height, depth, rowBytes, layout, colorMode: 'direct' });
const dec = bd.decodePlanarBitmap(bpl, req, undefined, palette);
const out = args.out || 'decode.png';
fs.mkdirSync(path.dirname(path.resolve(out)), { recursive: true });
fs.writeFileSync(out, bd.encodePngRgba(dec.width, dec.height, dec.rgba));
console.log(`decodificado ${addr.toString(16)} (${width}x${height}x${depth}, ${layout}, rowBytes=${rowBytes}) -> ${out}`);
