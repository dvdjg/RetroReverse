#!/usr/bin/env node
/**
 * probe-breakpoints.mjs — verifica que el stub GDB aplica breakpoints software (Z0)
 * en la sesion actual, y opcionalmente comprueba la reanudacion tras un stop.
 *
 * Sirve como diagnostico previo a cualquier enganche por breakpoints.
 *
 * Uso:
 *   node probe-breakpoints.mjs --config <x.uae> --adf <x.adf> [--boot 15] [--addr 0xc0255a]
 *
 * Si no se pasa --addr, usa el PC actual tras el boot.
 * Salida: "BP FUNCIONA" / "BP NO DISPARA".
 */

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
const args = parseArgs(process.argv);
if (!args.config) { console.error('falta --config'); process.exit(2); }
const boot = parseInt(args.boot || '15', 10);
const uae = new WinUAE({ configFile: args.config, adf: args.adf, winuaeDir: args.winuae, exe: args.exe });

try {
  await uae.open();
  await uae.resume();
  console.log(`booteando ${boot}s...`);
  await sleep(boot * 1000);
  await uae.pauseRetry();
  let r = await uae.regs();
  const pc = args.addr !== undefined ? parseInt(args.addr, 16) : (r.PC >>> 0);
  console.log(`PC actual=${r.PC.toString(16)} SR=${r.SR.toString(16)}`);
  console.log(`BP en ${pc.toString(16)}`);
  await uae.setBreakpoint(pc);
  await uae.resume();
  try {
    const stop = await uae.waitForStop(5000);
    r = await uae.regs();
    console.log(`STOP: ${stop} PC=${(r.PC >>> 0).toString(16)}`);
    console.log((r.PC >>> 0) === pc ? 'BP FUNCIONA' : 'stop espurio (otro PC)');
  } catch (e) {
    console.log(`BP NO DISPARA en 5s: ${e.message}`);
  }
  await uae.close(true);
} catch (e) {
  console.error('ERROR:', e.message);
  try { await uae.close(true); } catch {}
  process.exit(1);
}
