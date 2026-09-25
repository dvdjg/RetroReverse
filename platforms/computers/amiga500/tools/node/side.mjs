#!/usr/bin/env node
/**
 * side.mjs — cliente del canal lateral (puerto 2346) de una instancia WinUAE-DBG YA EN MARCHA.
 *
 * NO lanza el emulador: se conecta al que esté corriendo. Es la vía barata para
 * inspeccionar/modificar la Amiga en runtime (sin pausar la CPU, sin relanzar).
 *
 * Comandos:
 *   node side.mjs hello | state | regs
 *   node side.mjs mem <hex-addr> <len>          (trocea en <=4096)
 *   node side.mjs poke <hex-addr> <hex-bytes> [label]   (requiere lock takeover)
 *   node side.mjs lock acquire|release [mode] [owner]
 *   node side.mjs screenshot <file.png>
 *   node side.mjs pause | resume
 *   node side.mjs runstatus <hex-addr>
 *   node side.mjs raw "<comando>"
 *
 * --port <n>  puerto del canal lateral (def 2346)
 * --out <f>   para `mem`: escribe los bytes leidos en el fichero (binario)
 */

const OUT = (() => {
  const i = process.argv.indexOf('--out');
  return i >= 0 ? process.argv[i + 1] : null;
})();
const PORT = (() => {
  const i = process.argv.indexOf('--port');
  return i >= 0 ? parseInt(process.argv[i + 1], 10) : parseInt(process.env.AMIGA_REVERSE_SIDE_PORT || '2446', 10);
})();
const argv = process.argv.slice(2).filter((a, i, arr) =>
  !(a === '--port' || arr[i - 1] === '--port' || a === '--out' || arr[i - 1] === '--out'));
const [cmd, ...rest] = argv;

const SIDE = 'file:///C:/Users/dvdjg/Documents/programa/AI/Amiga/mcp-winuae-emu/dist/side-channel.js';
const { sideChannelCommand } = await import(SIDE);

async function send(command, timeoutMs = 5000) {
  const r = await sideChannelCommand(command, PORT, timeoutMs);
  if (!r.ok) throw new Error(r.error || 'side error');
  return r.reply ?? r.raw;
}
const show = (v) => console.log(typeof v === 'string' ? v : JSON.stringify(v, null, 2));

try {
  if (!cmd) { console.error('falta comando (hello|state|regs|mem|poke|lock|screenshot|pause|resume|raw)'); process.exit(2); }
  if (cmd === 'raw') { show(await send(rest.join(' '))); process.exit(0); }
  if (cmd === 'mem') {
    const fs = await import('node:fs');
    const path = await import('node:path');
    const addr = parseInt(rest[0], rest[0].startsWith('0x') ? 16 : 10);
    const len = parseInt(rest[1], rest[1].startsWith('0x') ? 16 : 10);
    const parts = [];
    for (let off = 0; off < len; off += 4096) {
      const n = Math.min(4096, len - off);
      const r = await send(`mem 0x${(addr + off).toString(16)} 0x${n.toString(16)}`);
      parts.push(Buffer.from(r.data, 'hex'));
    }
    const buf = Buffer.concat(parts);
    if (OUT) {
      fs.mkdirSync(path.dirname(path.resolve(OUT)), { recursive: true });
      fs.writeFileSync(OUT, buf);
      console.error(`escrito ${buf.length} B -> ${OUT}`);
    } else {
      console.log(buf.toString('hex'));
    }
    process.exit(0);
  }
  if (cmd === 'poke') {
    const label = rest[2] || '';
    show(await send(`poke 0x${rest[0]} ${rest[1]} ${label}`.trim()));
    process.exit(0);
  }
  if (cmd === 'lock') {
    show(await send(`lock ${rest.join(' ')}`.trim()));
    process.exit(0);
  }
  if (cmd === 'runstatus') { show(await send(`runstatus 0x${rest[0]}`)); process.exit(0); }
  if (cmd === 'screenshot') {
    const r = await send(`screenshot ${rest[0]}`, 8000);
    show(r);
    // esperar a que la accion se complete
    if (r && r.action) {
      for (let i = 0; i < 20; i++) {
        await new Promise((res) => setTimeout(res, 250));
        const st = await send(`action status ${r.action}`);
        if (st && st.status && st.status !== 'pending') { show(st); break; }
      }
    }
    process.exit(0);
  }
  show(await send([cmd, ...rest].join(' ')));
} catch (e) {
  console.error('ERROR:', e.message);
  process.exit(1);
}
