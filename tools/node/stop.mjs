#!/usr/bin/env node
/**
 * stop.mjs — cierra SOLO instancias lanzadas por Amiga-Reverse (PIDs registrados).
 *
 * Nunca usa kill global. Verifica que cada PID sea winuae-gdb antes de terminarlo.
 *
 * Uso:
 *   node stop.mjs                 # cierra la ultima sesion registrada
 *   node stop.mjs --pid 1234      # cierra ese PID (debe estar registrado o ser winuae-gdb)
 *   node stop.mjs --side-port 2446# cierra la sesion de ese puerto
 *   node stop.mjs --all           # cierra TODAS las sesiones registradas (solo las nuestras)
 */

import { spawnSync } from 'node:child_process';
import { loadSessions, saveSessions, isAlive, removeSession } from './session.mjs';

function parseArgs(argv) {
  const a = {};
  for (let i = 2; i < argv.length; i++) if (argv[i].startsWith('--')) a[argv[i].slice(2)] = argv[i + 1];
  return a;
}
const args = parseArgs(process.argv);

function isWinuae(pid) {
  const tl = spawnSync('tasklist', ['/FI', `PID eq ${pid}`, '/FO', 'CSV', '/NH'], { encoding: 'utf8' });
  return /winuae-gdb/i.test((tl.stdout || '').trim());
}
function kill(pid) {
  if (!isWinuae(pid)) { console.error(`pid ${pid}: no es winuae-gdb (no lo toco)`); return false; }
  const r = spawnSync('taskkill', ['/PID', String(pid), '/F'], { encoding: 'utf8' });
  console.log(`cerrada ${pid}: ${(r.stdout || '').trim() || (r.stderr || '').trim()}`);
  removeSession(pid);
  return true;
}

const sessions = loadSessions().filter((s) => isAlive(s.pid));

if (args.all) {
  if (!sessions.length) { console.log('no hay sesiones vivas registradas'); process.exit(0); }
  for (const s of sessions) kill(s.pid);
  process.exit(0);
}
let target = null;
if (args.pid) target = sessions.find((s) => s.pid === parseInt(args.pid, 10)) || { pid: parseInt(args.pid, 10) };
else if (args['side-port']) target = sessions.find((s) => s.sidePort === parseInt(args['side-port'], 10));
else target = sessions[sessions.length - 1];

if (!target) { console.log('no hay sesion viva registrada'); process.exit(0); }
kill(target.pid);
