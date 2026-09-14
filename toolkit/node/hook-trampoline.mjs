#!/usr/bin/env node
/**
 * hook-trampoline.mjs — engancha un descompresor localizado por firma y volca
 * cada bloque descomprimido, autodescubriendo su direccion y longitud.
 *
 * Soporta dos formas de contrato (spec JSON, ver specs/*.json):
 *
 *  A) "trampoline": en `parseOffset` (antes de llamar al de-cruncher) los
 *     registros `destReg`/`lenReg` ya contienen destino y longitud.
 *
 *  B) "routine": la entrada es la propia rutina (parseOffset=0) y la cabecera
 *     (en `destReg`, p. ej. A0) lleva la longitud en `lenHeaderOffset` (long
 *     big-endian). `destMagicHex` valida la firma de cabecera y descarta otras
 *     llamadas.
 *
 * {
 *   "patternHex": "48e7...",
 *   "parseOffset": "0x26",          // 0 en modo routine
 *   "retOffset":   "0x28",
 *   "destReg": "A1",                // registro con el destino (o con la cabecera)
 *   "destOffset": "0x0",            // suma al registro para obtener el destino
 *   "destMagicHex": "494d5021",     // opcional: firma que debe haber en el destino
 *   "lenReg":  "D1",                // longitud en registro (modo trampoline)
 *   "lenHeaderReg": "A0",           // o leer la longitud de [reg+lenHeaderOffset]
 *   "lenHeaderOffset": "0x4",
 *   "metaReg": "A0",
 *   "searchStart": "0xc00000",
 *   "searchSize":  "0x80000",
 *   "maxSeconds": 90,
 *   "chunk": 4096,
 *   "allowed": [ {"start":"0x400","end":"0x80000"},
 *                {"start":"0xc00000","end":"0xe00000"} ]
 * }
 *
 * Uso:
 *   node hook-trampoline.mjs --config <x.uae> --adf <x.adf> --spec <spec.json> --out <dir> [--boot 4]
 */

import * as fs from 'node:fs';
import * as path from 'node:path';
import * as crypto from 'node:crypto';
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
  console.error('uso: node hook-trampoline.mjs --config <x.uae> --adf <x.adf> --spec <spec.json> --out <dir>');
  process.exit(2);
}
const spec = JSON.parse(fs.readFileSync(args.spec, 'utf8'));
const out = path.resolve(args.out || 'out');
const modDir = path.join(out, 'modules');
fs.mkdirSync(modDir, { recursive: true });

const bootMs = num(args.boot, 4) * 1000;
const maxMs = num(spec.maxSeconds, 90) * 1000;
const chunk = num(spec.chunk, 4096);
const parseOff = num(spec.parseOffset, 0x26);
const retOff = num(spec.retOffset, 0x28);
const destReg = spec.destReg || 'A1';
const destOffset = num(spec.destOffset, 0);
const destMagic = spec.destMagicHex ? Buffer.from(spec.destMagicHex, 'hex') : null;
const lenReg = spec.lenReg || 'D1';
const lenHeaderReg = spec.lenHeaderReg || null;
const lenHeaderOffset = num(spec.lenHeaderOffset, 0);
const metaReg = spec.metaReg || null;
const allowed = (spec.allowed || [{ start: 0x400, end: 0x80000 }, { start: 0xc00000, end: 0xe00000 }])
  .map((r) => ({ start: num(r.start, 0), end: num(r.end, 0) }));

const uae = new WinUAE({ configFile: args.config, adf: args.adf, winuaeDir: args.winuae, exe: args.exe });

function inAllowed(dest, len) {
  return allowed.some((r) => dest >= r.start && dest + len <= r.end);
}

const saved = [];
const seen = new Set();

async function dumpBlock(dest, len, meta) {
  if (!len || len < 16 || len > 0x100000) return;
  if (!inAllowed(dest, len)) return;
  let data;
  try { data = await uae.readExact(dest, len, chunk); } catch (e) {
    console.error(`  fallo volcado ${dest.toString(16)} len=${len}: ${e.message}`);
    return;
  }
  const sha1 = crypto.createHash('sha1').update(data).digest('hex');
  if (seen.has(sha1)) return;
  seen.add(sha1);
  const idx = saved.length;
  const file = `mod_${String(idx).padStart(3, '0')}_${dest.toString(16)}_${len}.bin`;
  fs.writeFileSync(path.join(modDir, file), data);
  saved.push({ idx, file, dest: dest.toString(16), len, ...meta, sha1 });
  console.log(`  [${idx}] dest=${dest.toString(16)} len=${len} -> ${file}`);
}

let pending = null;

try {
  await uae.open();
  console.log('booteando...');
  await uae.resume();
  await sleep(bootMs);

  const pattern = Buffer.from(spec.patternHex, 'hex');
  const searchStart = num(spec.searchStart, 0xc00000);
  const searchSize = num(spec.searchSize, 0x80000);
  let base = -1;
  for (let attempt = 0; attempt < 20 && base < 0; attempt++) {
    await uae.pauseRetry();
    base = await uae.findPattern(searchStart, searchSize, pattern);
    if (base < 0) { console.log(`  intento ${attempt + 1}: firma no hallada`); await uae.resume(); await sleep(1000); }
  }
  if (base < 0) throw new Error('no se localizo la firma del trampoline');
  const bpParse = base + parseOff;
  const bpRet = base + retOff;
  console.log(`base=${base.toString(16)} bpParse=${bpParse.toString(16)} bpRet=${bpRet.toString(16)}`);

  await uae.setBreakpoint(bpParse);
  await uae.resume();

  const t0 = Date.now();
  let phase = 'parse';
  while (Date.now() - t0 < maxMs) {
    try { await uae.waitForStop(20000); } catch (e) { console.log(`stop: ${e.message}`); break; }
    const regs = await uae.regs();
    if (phase === 'parse') {
      if (regs.PC !== bpParse) { await uae.resume(); continue; }
      const dest = (((regs[destReg] >>> 0) + destOffset) >>> 0);
      if (destMagic) {
        let magic = null;
        try { magic = await uae.readExact(dest, destMagic.length); } catch { magic = null; }
        if (!magic || !magic.equals(destMagic)) { await uae.resume(); continue; }
      }
      let len;
      if (lenHeaderReg) {
        try {
          const at = (((regs[lenHeaderReg] >>> 0) + lenHeaderOffset) >>> 0);
          len = (await uae.readExact(at, 4)).readUInt32BE(0);
        } catch { await uae.resume(); continue; }
      } else {
        len = regs[lenReg] >>> 0;
      }
      pending = { dest, len, meta: metaReg ? (regs[metaReg] >>> 0).toString(16) : undefined };
      await uae.clearBreakpoint(bpParse);
      await uae.setBreakpoint(bpRet);
      phase = 'ret';
      await uae.resume();
    } else {
      if (regs.PC !== bpRet) { await uae.resume(); continue; }
      if (pending) await dumpBlock(pending.dest, pending.len, { metaReg: pending.meta });
      pending = null;
      await uae.clearBreakpoint(bpRet);
      await uae.setBreakpoint(bpParse);
      phase = 'parse';
      await uae.resume();
    }
  }

  fs.writeFileSync(path.join(modDir, 'modules.json'), JSON.stringify(saved, null, 2));
  console.log(`bloques unicos volcados: ${saved.length} -> ${modDir}`);
  await uae.close(true);
} catch (e) {
  console.error('ERROR:', e.stack || e.message);
  try { await uae.close(true); } catch {}
  process.exit(1);
}
