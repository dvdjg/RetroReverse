#!/usr/bin/env node
/**
 * side-read.mjs — lee el canal lateral de WinUAE-DBG (puerto 2346, independiente de GDB).
 *
 * Comandos: `hello`, `state`, `regs`, `mem <hex-addr> <len>`, `runstatus <hex-addr>`.
 * Útil cuando la lectura por GDB no es fiable (p. ej. registros custom).
 *
 * Uso:
 *   node side-read.mjs --config <x.uae> --adf <x.adf> [--boot 20] --state --regs
 *   node side-read.mjs --config <x.uae> --adf <x.adf> --boot 20 --mem 0xdff000:0x200
 *   node side-read.mjs --config <x.uae> --adf <x.adf> --boot 20 --cmd "state"
 */

import { WinUAE, sleep } from './winuae-session.mjs';

function parseArgs(argv) {
  const a = {};
  for (let i = 2; i < argv.length; i++) {
    const k = argv[i];
    if (k.startsWith('--')) {
      const key = k.slice(2);
      if (key === 'state' || key === 'regs' || key === 'hello') { a[key] = true; continue; }
      a[key] = argv[++i];
    }
  }
  return a;
}
const args = parseArgs(process.argv);
if (!args.config) { console.error('falta --config'); process.exit(2); }
const boot = parseInt(args.boot || '20', 10);

const uae = new WinUAE({ configFile: args.config, adf: args.adf, winuaeDir: args.winuae, exe: args.exe });
try {
  await uae.open();
  await uae.resume();
  await sleep(boot * 1000);
  const cmds = [];
  if (args.cmd) cmds.push(args.cmd);
  if (args.hello) cmds.push('hello');
  if (args.state) cmds.push('state');
  if (args.regs) cmds.push('regs');
  if (args.mem) {
    const [addr, len] = args.mem.split(':');
    cmds.push(`mem ${addr} ${len}`);
  }
  if (!cmds.length) cmds.push('state', 'regs');
  for (const c of cmds) {
    try {
      const reply = await uae.side(c, 4000);
      console.log(`--- ${c} ---`);
      console.log(typeof reply === 'string' ? reply : JSON.stringify(reply, null, 2));
    } catch (e) {
      console.log(`--- ${c} --- ERROR ${e.message}`);
    }
  }
  await uae.close(true);
} catch (e) {
  console.error('ERROR:', e.stack || e.message);
  try { await uae.close(true); } catch {}
  process.exit(1);
}
