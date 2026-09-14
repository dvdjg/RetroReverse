/**
 * winuae-session.mjs — biblioteca reutilizable de sesión WinUAE-DBG + GDB.
 *
 * Encapsula el ciclo completo usado en cualquier rip:
 *   lanzar WinUAE-DBG con un .uae + ADF, conectar por GDB RSP, pausar (con
 *   reintentos), leer memoria por bloques, buscar patrones en RAM, gestionar
 *   breakpoints y volcar regiones a fichero.
 *
 * Depende del módulo Node del repo hermano `mcp-winuae-emu/dist/winuae-connection.js`
 * (clase `WinUAEConnection`), que NO hace falta tener registrado como MCP.
 *
 * Ejemplo:
 *   import { WinUAE, sleep } from './winuae-session.mjs';
 *   const uae = new WinUAE({ configFile: 'out/x.uae', adf: 'out/x.adf' });
 *   await uae.open();
 *   await uae.resume();
 *   await sleep(15000);
 *   await uae.pauseRetry();
 *   await uae.dumpRegion(0x000000, 0x80000, 'out/ram/chip.bin');
 *   await uae.close();
 */

import * as fs from 'node:fs';
import * as path from 'node:path';
import { spawn } from 'node:child_process';

export const DEFAULT_MCP_DIST =
  'file:///C:/Users/dvdjg/Documents/programa/AI/Amiga/mcp-winuae-emu/dist/winuae-connection.js';
export const DEFAULT_WINUAE_DIR =
  'C:\\Users\\dvdjg\\Documents\\programa\\AI\\Amiga\\WinUAE-DBG\\bin';

export const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

/** "0x0:0x80000" o "0x0+0x80000" -> {start, size} */
export function parseRegion(spec) {
  const m = /^\s*(0x[0-9a-fA-F]+|\d+)\s*[:+]\s*(0x[0-9a-fA-F]+|\d+)\s*$/.exec(spec);
  if (!m) throw new Error(`region invalida: "${spec}" (usa 0xSTART:SIZE)`);
  const n = (s) => (s.startsWith('0x') ? parseInt(s, 16) : parseInt(s, 10));
  return { start: n(m[1]), size: n(m[2]) };
}

export class WinUAE {
  /**
   * @param {object} opts
   * @param {string} opts.configFile  .uae de hardware (obligatorio)
   * @param {string} [opts.adf]       ADF a insertar en DF0 (si no lo pone el .uae)
   * @param {string} [opts.winuaeDir] directorio con winuae-gdb.exe
   * @param {string} [opts.exe]       nombre del ejecutable (def winuae-gdb.exe)
   * @param {number} [opts.gdbPort]   puerto GDB (def 2345)
   * @param {string} [opts.mcpDist]   URL file:// del módulo WinUAEConnection
   * @param {function} [opts.log]     logger (def console.error)
   */
  constructor(opts = {}) {
    const clean = Object.fromEntries(Object.entries(opts).filter(([, v]) => v !== undefined));
    this.opts = {
      winuaeDir: DEFAULT_WINUAE_DIR,
      exe: process.env.WINUAE_EXE || 'winuae-gdb.exe',
      // Rango PROPIO de Amiga-Reverse (2445/2446). Se ignoran las variables
      // WINUAE_GDB_PORT/WINUAE_SIDE_CHANNEL_PORT ambientales (el sistema puede
      // tener WINUAE_GDB_PORT=2345 global); para cambiarlas usar AMIGA_REVERSE_*.
      gdbPort: parseInt(process.env.AMIGA_REVERSE_GDB_PORT || '2445', 10),
      sidePort: parseInt(process.env.AMIGA_REVERSE_SIDE_PORT || '2446', 10),
      mcpDist: process.env.WINUAE_MCP_DIST || DEFAULT_MCP_DIST,
      log: (...a) => console.error(...a),
      ...clean,
    };
    if (!this.opts.configFile) throw new Error('WinUAE: falta configFile');
    this.conn = null;
    this.proto = null;
  }

  _env() {
    // El lanzador legacy usa -f <config> -G -s debugging_features=gdbserver.
    process.env.WINUAE_USE_LEGACY_LAUNCH = '1';
    process.env.WINUAE_EXE = this.opts.exe;
    process.env.WINUAE_GDB_MAX_ATTEMPTS = process.env.WINUAE_GDB_MAX_ATTEMPTS || '20';
    process.env.WINUAE_GDB_DELAY_MS = process.env.WINUAE_GDB_DELAY_MS || '500';
    process.env.WINUAE_GDB_PERSIST_LISTENER = process.env.WINUAE_GDB_PERSIST_LISTENER || '1';
    // Puertos propios: se pasan al emulador por entorno (WinUAE-DBG los lee).
    process.env.WINUAE_GDB_PORT = String(this.opts.gdbPort);
    process.env.WINUAE_SIDE_CHANNEL_PORT = String(this.opts.sidePort);
    if (this.opts.adf) process.env.WINUAE_BOOT_ADF = path.resolve(this.opts.adf);
  }

  /**
   * Consulta el canal lateral (puerto 2346), independiente de GDB:
   * `hello`, `state`, `regs`, `mem <hex-addr> <len>`, `runstatus <hex-addr>`.
   * Devuelve el objeto reply del servidor.
   */
  async side(command, timeoutMs = 4000) {
    const url = this.opts.mcpDist.replace('winuae-connection.js', 'side-channel.js');
    const mod = await import(url);
    const r = await mod.sideChannelCommand(command, this.opts.sidePort, timeoutMs);
    if (!r.ok) throw new Error(`side "${command}": ${r.error || r.raw || 'error'}`);
    return r.reply ?? r.raw;
  }

  /** Elige el primer directorio que contenga el ejecutable (o su fallback -x86). */
  _resolveDir() {
    const dirs = [this.opts.winuaeDir, process.env.WINUAE_PATH, DEFAULT_WINUAE_DIR]
      .filter(Boolean)
      .filter((d, i, a) => a.indexOf(d) === i);
    for (const d of dirs) {
      if (fs.existsSync(path.join(d, this.opts.exe)) ||
          fs.existsSync(path.join(d, 'winuae-gdb-x86.exe'))) return d;
    }
    return dirs[0];
  }

  /** Lanza WinUAE y conecta por GDB (deja la CPU parada tras el handshake). */
  async open() {
    this._env();
    const mod = await import(this.opts.mcpDist);
    const { WinUAEConnection } = mod;
    const dir = this._resolveDir();
    this.conn = new WinUAEConnection({
      winuaePath: dir,
      configFile: path.resolve(this.opts.configFile),
      gdbPort: this.opts.gdbPort,
    });
    this.opts.log(`[winuae] lanzando ${this.opts.exe} desde ${dir} ...`);
    await this.conn.connect();
    this.proto = this.conn.getProtocol();
    this.opts.log('[winuae] conectado');
    return this;
  }

  /** Conecta a un WinUAE ya en marcha (sin lanzar proceso). */
  async attach() {
    this._env();
    const mod = await import(this.opts.mcpDist);
    const { WinUAEConnection } = mod;
    const dir = this._resolveDir();
    this.conn = new WinUAEConnection({
      winuaePath: dir,
      configFile: path.resolve(this.opts.configFile),
      gdbPort: this.opts.gdbPort,
    });
    await this.conn.connectExisting({ forceBreak: false, initializeStopped: false });
    this.proto = this.conn.getProtocol();
    return this;
  }

  /**
   * Lanza WinUAE-DBG DETACHED y lo deja en marcha (sin conectar GDB). Tras esto,
   * toda la interaccion se hace por el canal lateral (puerto 2346), que no pausa
   * la CPU. Es la forma de NO relanzar el emulador en cada experimento.
   * Devuelve el PID.
   */
  async launchDetached() {
    this._env();
    const dir = this._resolveDir();
    const exePath = path.join(dir, this.opts.exe);
    const args = ['-f', path.resolve(this.opts.configFile), '-portable', '-G',
      '-s', 'headless=no', '-s', 'debugging_features=gdbserver',
      // No capturar el raton del sistema anfitrion.
      '-s', 'win32.start_not_captured=yes',
      '-s', 'win32.active_capture_automatically=no',
      '-s', 'win32.absolute_mouse=yes'];
    if (this.opts.adf) args.push('-s', `floppy0=${path.resolve(this.opts.adf)}`);
    this.opts.log(`[winuae] launchDetached: ${exePath} ${args.join(' ')}`);
    const child = spawn(exePath, args, { cwd: dir, detached: true, stdio: 'ignore', windowsHide: false });
    child.unref();
    this.detachedPid = child.pid;
    for (let i = 0; i < 60; i++) {
      try {
        const h = await this.side('hello', 1000);
        if (h && h.ok) { this.opts.log(`[winuae] canal lateral listo (pid ${child.pid}, puerto ${this.opts.sidePort})`); return child.pid; }
      } catch { /* aun no escucha */ }
      await sleep(500);
    }
    throw new Error('el canal lateral no respondio');
  }

  /** Adquiere/libera el lock del canal lateral (observe|assist|takeover). */
  async sideLock(action, mode = 'takeover', owner = 're-toolkit') {
    if (action === 'acquire') return this.side(`lock acquire ${owner} ${mode}`);
    if (action === 'release') return this.side(`lock release ${owner}`);
    return this.side('lock status');
  }

  /** Lee memoria EN CALIENTE por el canal lateral (sin pausar). Trocea en <=4096 B. */
  async sideMem(addr, len, chunk = 4096) {
    const parts = [];
    for (let off = 0; off < len; off += chunk) {
      const n = Math.min(chunk, len - off);
      const r = await this.side(`mem 0x${(addr + off).toString(16)} 0x${n.toString(16)}`);
      if (!r || !r.ok) throw new Error(`sideMem fallo en ${(addr + off).toString(16)}: ${r && r.error}`);
      parts.push(Buffer.from(r.data, 'hex'));
    }
    return Buffer.concat(parts);
  }

  /** Escribe memoria EN CALIENTE (requiere lock takeover). Trocea en <=256 B. */
  async sidePoke(addr, data, label = '', chunk = 256) {
    const buf = Buffer.isBuffer(data) ? data : Buffer.from(data, 'hex');
    for (let off = 0; off < buf.length; off += chunk) {
      const slice = buf.subarray(off, off + chunk);
      const r = await this.side(`poke 0x${(addr + off).toString(16)} ${slice.toString('hex')} ${label}`.trim());
      if (!r || !r.ok) throw new Error(`sidePoke fallo en ${(addr + off).toString(16)}: ${r && r.error}`);
    }
    return buf.length;
  }

  async sideScreenshot(file) {
    const abs = path.resolve(file);
    fs.mkdirSync(path.dirname(abs), { recursive: true });
    return this.side(`screenshot ${abs}`);
  }

  async sidePause() { return this.side('pause'); }
  async sideResume() { return this.side('resume'); }

  /** Reanuda la CPU. */
  async resume() {
    await this.proto.continue();
  }

  /** Pausa con reintentos (el stub puede tardar en atender el 0x03). */
  async pauseRetry(tries = 6, delayMs = 400) {
    for (let i = 0; i < tries; i++) {
      try {
        return await this.proto.pause();
      } catch (e) {
        this.opts.log(`[winuae] pause intento ${i + 1}: ${e.message}`);
        await sleep(delayMs);
      }
    }
    throw new Error('pause no respondio tras varios intentos');
  }

  async regs() {
    return this.proto.readRegisters();
  }

  async monitor(cmd, timeoutMs) {
    return this.proto.sendMonitorCommand(cmd, timeoutMs);
  }

  async screenshot(file) {
    const abs = path.resolve(file);
    fs.mkdirSync(path.dirname(abs), { recursive: true });
    await this.proto.sendMonitorCommand(`screenshot ${abs}`);
    return abs;
  }

  /**
   * Lee `size` bytes exactos desde `addr` troceando en bloques (el stub puede
   * resetear con lecturas grandes). Lanza si algun bloque viene corto.
   */
  async readExact(addr, size, chunk = 4096) {
    const buf = Buffer.alloc(size);
    for (let off = 0; off < size; off += chunk) {
      const n = Math.min(chunk, size - off);
      const got = await this.proto.readMemory(addr + off, n);
      if (got.length !== n) throw new Error(`lectura corta en ${(addr + off).toString(16)}`);
      got.copy(buf, off);
    }
    return buf;
  }

  /** Lee sin fallar: devuelve {buf, ok, fail} y registra los bloques que fallan. */
  async readTolerant(addr, size, chunk = 4096) {
    const buf = Buffer.alloc(size);
    let ok = 0, fail = 0;
    for (let off = 0; off < size; off += chunk) {
      const n = Math.min(chunk, size - off);
      try {
        const got = await this.proto.readMemory(addr + off, n);
        if (got.length === n) { got.copy(buf, off); ok += n; }
        else { fail += n; this.opts.log(`[winuae] corto en ${(addr + off).toString(16)}`); }
      } catch (e) {
        fail += n;
        this.opts.log(`[winuae] fallo ${(addr + off).toString(16)}: ${e.message}`);
      }
    }
    return { buf, ok, fail };
  }

  /** Vuelca una region tolerante a fallos en `file`; devuelve {file, ok, fail}. */
  async dumpRegion(addr, size, file, chunk = 4096) {
    const { buf, ok, fail } = await this.readTolerant(addr, size, chunk);
    fs.mkdirSync(path.dirname(path.resolve(file)), { recursive: true });
    fs.writeFileSync(file, buf);
    return { file, ok, fail };
  }

  /**
   * Busca un patron (Buffer o hex) en RAM troceando en bloques grandes.
   * Devuelve la direccion absoluta o -1.
   */
  async findPattern(start, size, pattern, chunk = 0x10000) {
    const pat = Buffer.isBuffer(pattern) ? pattern : Buffer.from(pattern, 'hex');
    const overlap = pat.length - 1;
    let carry = Buffer.alloc(0);
    for (let off = 0; off < size; off += chunk - overlap) {
      const n = Math.min(chunk, size - off);
      let data;
      try { data = await this.readExact(start + off, n); } catch { continue; }
      const hay = Buffer.concat([carry, data]);
      const i = hay.indexOf(pat);
      if (i >= 0) return start + off - carry.length + i;
      carry = data.slice(-overlap);
    }
    return -1;
  }

  async setBreakpoint(addr) { await this.proto.setBreakpoint(addr); }
  async clearBreakpoint(addr) { await this.proto.clearBreakpoint(addr); }
  async waitForStop(ms = 30000) { return this.proto.waitForStop(ms); }
  async step() { return this.proto.step(); }

  /** Interpreta un registro por nombre: D0..D7, A0..A7, SR, PC. */
  static reg(regs, name) {
    return (regs[name] >>> 0);
  }

  async close(stopEmulator = true) {
    if (this.conn) await this.conn.disconnect(stopEmulator);
    this.conn = null;
    this.proto = null;
  }
}
