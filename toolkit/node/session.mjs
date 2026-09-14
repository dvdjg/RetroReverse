/**
 * session.mjs — registro de las instancias WinUAE lanzadas por Amiga-Reverse.
 *
 * Permite VARIAS sesiones en paralelo (cada una con su par de puertos y su PID),
 * guardadas en `.session.json`. Solo se cierran los PIDs registrados aquí.
 */
import * as fs from 'node:fs';
import * as path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
export const ROOT = path.resolve(__dirname, '..', '..');
export const SESSION_FILE = path.join(ROOT, '.session.json');

export function loadSessions() {
  try {
    const data = JSON.parse(fs.readFileSync(SESSION_FILE, 'utf8'));
    return Array.isArray(data) ? data : (data && Array.isArray(data.sessions) ? data.sessions : []);
  } catch { return []; }
}

export function saveSessions(list) {
  fs.writeFileSync(SESSION_FILE, JSON.stringify({ sessions: list }, null, 2));
}

export function addSession(obj) {
  const list = loadSessions().filter((s) => isAlive(s.pid));
  list.push({ ...obj, startedAt: new Date().toISOString() });
  saveSessions(list);
}

export function removeSession(pid) {
  saveSessions(loadSessions().filter((s) => s.pid !== pid));
}

export function isAlive(pid) {
  if (!pid) return false;
  try { process.kill(pid, 0); return true; } catch { return false; }
}

/** Elige el primer par de puertos libre a partir de 2445/2446 (paso 2). */
export function pickPorts(existing = loadSessions()) {
  const used = new Set();
  for (const s of existing) { used.add(s.gdbPort); used.add(s.sidePort); }
  for (let base = 2445; base < 2600; base += 2) {
    if (!used.has(base) && !used.has(base + 1)) return { gdbPort: base, sidePort: base + 1 };
  }
  throw new Error('sin puertos libres en el rango');
}

/** limpieza de sesiones ya muertas */
export function pruneSessions() {
  const live = loadSessions().filter((s) => isAlive(s.pid));
  saveSessions(live);
  return live;
}
