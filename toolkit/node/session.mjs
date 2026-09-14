/**
 * session.mjs — registro de la instancia WinUAE lanzada por Amiga-Reverse.
 *
 * Guarda el PID y los puertos en `.session.json` (raíz de Amiga-Reverse) para poder
 * cerrar SOLO nuestra instancia, sin tocar otras de otros proyectos.
 */
import * as fs from 'node:fs';
import * as path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
export const ROOT = path.resolve(__dirname, '..', '..');
export const SESSION_FILE = path.join(ROOT, '.session.json');

export function saveSession(obj) {
  fs.writeFileSync(SESSION_FILE, JSON.stringify({ ...obj, startedAt: new Date().toISOString() }, null, 2));
}

export function loadSession() {
  try { return JSON.parse(fs.readFileSync(SESSION_FILE, 'utf8')); } catch { return null; }
}

export function clearSession() {
  try { fs.unlinkSync(SESSION_FILE); } catch { /* nada */ }
}

/** ¿Sigue vivo el PID de la sesión? */
export function isAlive(pid) {
  if (!pid) return false;
  try { process.kill(pid, 0); return true; } catch { return false; }
}
