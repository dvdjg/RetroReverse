#!/usr/bin/env node
/**
 * stop.mjs — cierra SOLO la instancia WinUAE lanzada por Amiga-Reverse (PID registrado).
 *
 * NO usa `Get-Process winuae-gdb | Stop-Process` (eso mataria instancias de otros
 * proyectos). Solo termina el PID de `.session.json`, verificando antes que sea un
 * proceso winuae-gdb.
 *
 * Uso:
 *   node stop.mjs            # cierra la sesion registrada
 *   node stop.mjs --pid 1234 # cierra un PID concreto (comprobando que sea winuae-gdb)
 */

import { spawnSync } from 'node:child_process';
import { loadSession, clearSession, isAlive } from './session.mjs';

function parseArgs(argv) {
  const a = {};
  for (let i = 2; i < argv.length; i++) if (argv[i].startsWith('--')) a[argv[i].slice(2)] = argv[i + 1];
  return a;
}
const args = parseArgs(process.argv);

const session = loadSession();
const pid = args.pid ? parseInt(args.pid, 10) : (session && session.pid);

if (!pid) { console.log('no hay instancia registrada'); process.exit(0); }
if (!isAlive(pid)) {
  console.log(`pid ${pid} ya no existe; limpio sesion`);
  clearSession();
  process.exit(0);
}

// Verificar que el PID es un winuae-gdb (no reutilizar un PID ajeno).
const tl = spawnSync('tasklist', ['/FI', `PID eq ${pid}`, '/FO', 'CSV', '/NH'], { encoding: 'utf8' });
const line = (tl.stdout || '').trim().split(/\r?\n/)[0] || '';
if (!/winuae-gdb/i.test(line)) {
  console.error(`el pid ${pid} no es winuae-gdb (o no existe): ${line || '(vacio)'}`);
  process.exit(1);
}

const r = spawnSync('taskkill', ['/PID', String(pid), '/F'], { encoding: 'utf8' });
console.log(`cerrada instancia ${pid}: ${(r.stdout || '').trim() || (r.stderr || '').trim()}`);
clearSession();
