#!/usr/bin/env node
/**
 * launch.mjs — lanza WinUAE-DBG UNA vez y lo deja en marcha (detached, sin GDB).
 *
 * Registra el PID en `.session.json` para poder cerrarlo despues con `stop.mjs`
 * SIN afectar a otras instancias de otros proyectos. No lanza una segunda si ya
 * hay una viva.
 *
 * Uso:
 *   node launch.mjs --config out\game.uae --adf out\disk\game.adf
 */

import { WinUAE, sleep } from './winuae-session.mjs';
import { saveSession, loadSession, isAlive } from './session.mjs';

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

const prev = loadSession();
if (prev && isAlive(prev.pid)) {
  console.log(`ya hay una instancia viva (pid ${prev.pid}, gdb ${prev.gdbPort}, side ${prev.sidePort}).`);
  console.log('usa "node stop.mjs" para cerrarla antes de lanzar otra.');
  process.exit(0);
}

const uae = new WinUAE({ configFile: args.config, adf: args.adf, winuaeDir: args.winuae, exe: args.exe });
const pid = await uae.launchDetached();
saveSession({
  pid,
  gdbPort: uae.opts.gdbPort,
  sidePort: uae.opts.sidePort,
  configFile: args.config,
  adf: args.adf || null,
  exe: uae.opts.exe,
});
console.log(`winuae-dbg lanzado (pid ${pid}); GDB ${uae.opts.gdbPort}, canal lateral ${uae.opts.sidePort}`);
console.log('estado:  node side.mjs state     cerrar:  node stop.mjs');
await sleep(200);
