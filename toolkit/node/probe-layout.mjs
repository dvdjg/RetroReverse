#!/usr/bin/env node
/**
 * probe-layout.mjs — descubre DÓNDE y CUÁNTO escribe una rutina, comparando la
 * RAM antes y después de una sola llamada (diff de regiones).
 *
 * Se usa cuando no se conoce el contrato de una rutina (p. ej. un decruncher que
 * deduce destino/longitud de su cabecera). Localiza la rutina por firma, se para
 * en su entrada, captura la cabecera y una foto de la RAM, se para en su retorno
 * y hace otra foto; el diff revela la region escrita.
 *
 * Spec (ver specs/*.json):
 * {
 *   "entryPatternHex": "48e7...",      // prologue de la rutina
 *   "retOffset": "0x50",               // offset (desde la firma) del retorno
 *   "headerReg": "A0",                 // registro con puntero a cabecera
 *   "headerMagics": ["494d5021"],      // firmas de cabecera válidas (big-endian hex)
 *   "lenOffsets": ["0x4", "0x8"],      // longs big-endian de la cabecera (tamaños)
 *   "searchStart": "0xc00000",         // rango de búsqueda de la firma
 *   "searchSize":  "0x80000",
 *   "regions": [ {"start":"0x0","end":"0x80000"},
 *                {"start":"0xc00000","end":"0xc80000"} ],
 *   "minRun": 16                        // longitud mínima de un tramo cambiado a reportar
 * }
 *
 * Uso:
 *   node probe-layout.mjs --config <x.uae> --adf <x.adf> --spec <spec.json> [--boot 12]
 */

import * as fs from 'node:fs';
import { WinUAE, sleep } from './winuae-session.mjs';

function parseArgs(argv) {
  const a = {};
  for (let i = 2; i < argv.length; i++) {
    const k = argv[i];
    if (!k.startsWith('--')) continue;
    a[k.slice(2)] = argv[++i];
  }
  return a;
}
const num = (v, def) => (v === undefined ? def : (typeof v === 'string' && v.startsWith('0x') ? parseInt(v, 16) : typeof v === 'string' ? parseInt(v, 10) : v));

const args = parseArgs(process.argv);
if (!args.config || !args.spec) {
  console.error('uso: node probe-layout.mjs --config <x.uae> --adf <x.adf> --spec <spec.json> [--boot 12]');
  process.exit(2);
}
const spec = JSON.parse(fs.readFileSync(args.spec, 'utf8'));
const bootMs = num(args.boot, 12) * 1000;
const retOffset = num(spec.retOffset, 0);
const headerReg = spec.headerReg || 'A0';
const magics = (spec.headerMagics || []).map((h) => Buffer.from(h, 'hex'));
const lenOffsets = (spec.lenOffsets || []).map((o) => num(o, 0));
const minRun = num(spec.minRun, 16);
const regions = (spec.regions || [{ start: '0x0', end: '0x80000' }]).map((r) => ({
  start: num(r.start, 0),
  end: num(r.end, 0),
}));

const uae = new WinUAE({ configFile: args.config, adf: args.adf, winuaeDir: args.winuae, exe: args.exe });

async function snapshot() {
  const shot = [];
  for (const r of regions) {
    const size = r.end - r.start;
    shot.push(await uae.readExact(r.start, size));
  }
  return shot;
}

function diffRuns(before, after) {
  const runs = [];
  for (let ri = 0; ri < regions.length; ri++) {
    const a = before[ri], b = after[ri];
    const base = regions[ri].start;
    let i = 0;
    while (i < a.length) {
      if (a[i] !== b[i]) {
        const start = i;
        while (i < a.length && a[i] !== b[i]) i++;
        if (i - start >= minRun) runs.push({ start: base + start, len: i - start });
      } else i++;
    }
  }
  return runs;
}

try {
  await uae.open();
  await uae.resume();
  console.log(`booteando ${bootMs / 1000}s...`);
  await sleep(bootMs);

  const pattern = Buffer.from(spec.entryPatternHex, 'hex');
  const searchStart = num(spec.searchStart, 0xc00000);
  const searchSize = num(spec.searchSize, 0x80000);

  let base = -1;
  for (let attempt = 0; attempt < 20 && base < 0; attempt++) {
    await uae.pauseRetry();
    base = await uae.findPattern(searchStart, searchSize, pattern);
    if (base < 0) { console.log(`  intento ${attempt + 1}: firma no hallada`); await uae.resume(); await sleep(1000); }
  }
  if (base < 0) throw new Error('no se localizo la firma de la rutina');
  const bpEntry = base;
  const bpRet = base + retOffset;
  console.log(`rutina=${base.toString(16)} retBP=${bpRet.toString(16)}`);

  // Buscar una llamada cuya cabecera coincida con alguna firma conocida
  let header = 0, lens = [];
  for (let tries = 0; tries < 40; tries++) {
    await uae.setBreakpoint(bpEntry);
    await uae.resume();
    await uae.waitForStop(30000);
    const regs = await uae.regs();
    await uae.clearBreakpoint(bpEntry);
    if (regs.PC !== bpEntry) continue;
    header = regs[headerReg] >>> 0;
    let hdr;
    try { hdr = await uae.readExact(header, 4 + 4 * lenOffsets.length); } catch { continue; }
    const magic = hdr.subarray(0, 4);
    const match = magics.length === 0 || magics.some((m) => m.equals(magic));
    if (!match) { await uae.resume(); continue; }
    lens = lenOffsets.map((o) => hdr.readUInt32BE(o));
    console.log(`cabecera@${header.toString(16)} magic=${magic.toString('hex')} longs=[${lens.map((l) => l.toString() + '(' + l.toString(16) + ')').join(', ')}]`);
    break;
  }
  if (!lens.length) throw new Error('no se hallo una llamada con cabecera valida');

  console.log('foto RAM antes...');
  const before = await snapshot();
  await uae.setBreakpoint(bpRet);
  await uae.resume();
  await uae.waitForStop(60000);
  let r = await uae.regs();
  console.log(`retorno en ${(r.PC >>> 0).toString(16)} D0=${(r.D0 >>> 0).toString(16)}`);
  await uae.clearBreakpoint(bpRet);
  console.log('foto RAM despues...');
  const after = await snapshot();

  const runs = diffRuns(before, after);
  console.log(`tramos cambiados (>=${minRun} bytes): ${runs.length}`);
  for (const run of runs) {
    const rel = run.start - header;
    console.log(`  ${run.start.toString(16)} len=${run.len} (len=${run.len.toString(16)})  relativo a cabecera: ${rel >= 0 ? '+' : ''}${rel} (${rel.toString(16)})`);
  }

  await uae.close(true);
} catch (e) {
  console.error('ERROR:', e.stack || e.message);
  try { await uae.close(true); } catch {}
  process.exit(1);
}
