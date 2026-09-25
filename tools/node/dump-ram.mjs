#!/usr/bin/env node
/**
 * dump-ram.mjs — lanza WinUAE-DBG, deja bootear y vuelca regiones de RAM a fichero.
 *
 * Reutilizable para cualquier rip: recibe la config, el ADF y las regiones por CLI.
 *
 * Uso:
 *   node dump-ram.mjs --config <x.uae> --adf <x.adf> [opciones]
 *
 * Opciones:
 *   --config <path>      .uae de hardware (obligatorio)
 *   --adf <path>         ADF a insertar en DF0
 *   --winuae <dir>       directorio de winuae-gdb.exe
 *   --exe <name>         ejecutable (def winuae-gdb.exe)
 *   --port <n>           puerto GDB (def 2345)
 *   --boot <segundos>    tiempo de boot antes de pausar (def 20)
 *   --regions <lista>    regiones 0xSTART:SIZE separadas por comas
 *                        (def "0x0:0x80000,0xc00000:0x80000")
 *   --out <dir>          directorio base de salida (def ./out)
 *   --prefix <name>      prefijo de los ficheros (def "ram")
 *   --screenshot         captura la pantalla a <out>/screens/<prefix>-boot.png
 *
 * Ejemplo:
 *   node dump-ram.mjs --config ../platforms/computers/amiga500/demos/arte/out/sanity.uae \
 *     --adf ../platforms/computers/amiga500/demos/arte/rom/raw/sanity-arte.adf --boot 20 \
 *     --regions 0x0:0x80000,0xc00000:0x80000 --out ../platforms/computers/amiga500/demos/arte/out --prefix arte --screenshot
 */

import * as path from 'node:path';
import { WinUAE, sleep, parseRegion } from './winuae-session.mjs';

function parseArgs(argv) {
  const a = {};
  for (let i = 2; i < argv.length; i++) {
    const k = argv[i];
    if (!k.startsWith('--')) continue;
    const key = k.slice(2);
    if (key === 'screenshot') { a.screenshot = true; continue; }
    a[key] = argv[++i];
  }
  return a;
}

const args = parseArgs(process.argv);
if (!args.config) {
  console.error('falta --config <x.uae>. Ejecuta con --help para ver el uso.');
  process.exit(2);
}
const out = path.resolve(args.out || 'out');
const prefix = args.prefix || 'ram';
const boot = parseInt(args.boot || '20', 10);
const regions = (args.regions || '0x0:0x80000,0xc00000:0x80000')
  .split(',')
  .map((s) => parseRegion(s))
  .map((r, i) => ({ ...r, name: `${prefix}_${r.start.toString(16).padStart(6, '0')}` }));

const uae = new WinUAE({
  configFile: args.config,
  adf: args.adf,
  winuaeDir: args.winuae,
  exe: args.exe,
  gdbPort: args.port ? parseInt(args.port, 10) : undefined,
});

try {
  await uae.open();
  await uae.resume();
  console.log(`booteando ${boot}s...`);
  await sleep(boot * 1000);
  await uae.pauseRetry();
  const r = await uae.regs();
  console.log(`PC=${r.PC.toString(16)} SR=${r.SR.toString(16)}`);

  for (const reg of regions) {
    const file = path.join(out, 'ram', `${reg.name}.bin`);
    const res = await uae.dumpRegion(reg.start, reg.size, file);
    console.log(`region ${reg.start.toString(16)}:${reg.size.toString(16)} -> ${res.file} (ok=${res.ok} fail=${res.fail})`);
  }

  if (args.screenshot) {
    const f = await uae.screenshot(path.join(out, 'screens', `${prefix}-boot.png`));
    console.log(`screenshot -> ${f}`);
  }

  await uae.close(true);
} catch (e) {
  console.error('ERROR:', e.stack || e.message);
  try { await uae.close(true); } catch {}
  process.exit(1);
}
