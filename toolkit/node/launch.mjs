#!/usr/bin/env node
/**
 * launch.mjs — lanza una instancia WinUAE-DBG y la registra (PID + puertos).
 *
 * Permite VARIAS instancias en paralelo: si no se indican puertos, elige el
 * primer par libre (2445/2446, 2447/2448, ...). Cierra solo las registradas con
 * `stop.mjs`.
 *
 * Uso:
 *   node launch.mjs --config out\game.uae --adf out\disk\game.adf
 *   node launch.mjs --config out\game.uae --gdb-port 2447 --side-port 2448
 */

import { WinUAE, sleep } from './winuae-session.mjs';
import { addSession, loadSessions, pruneSessions, pickPorts } from './session.mjs';

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

pruneSessions();
let gdbPort = args['gdb-port'] ? parseInt(args['gdb-port'], 10) : null;
let sidePort = args['side-port'] ? parseInt(args['side-port'], 10) : null;
if (!gdbPort || !sidePort) {
  const p = pickPorts(loadSessions());
  gdbPort = gdbPort || p.gdbPort;
  sidePort = sidePort || p.sidePort;
}

const uae = new WinUAE({ configFile: args.config, adf: args.adf, winuaeDir: args.winuae, exe: args.exe, gdbPort, sidePort });
const pid = await uae.launchDetached();
addSession({ pid, gdbPort, sidePort, configFile: args.config, adf: args.adf || null, exe: uae.opts.exe });
console.log(`winuae-dbg lanzado (pid ${pid}); GDB ${gdbPort}, canal lateral ${sidePort}`);
console.log('estado:  node side.mjs state     cerrar:  node stop.mjs --pid ' + pid);
await sleep(200);
