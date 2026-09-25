# tools — herramientas específicas de Amiga (A500)

Utilidades de la plataforma **Amiga** (WinUAE-DBG + GDB, DMS, decodificación planar/copper). Las
**genéricas** (multi-plataforma) viven en el marco: [`tools/`](../../../../tools/README.md).

## Contenido

| Herramienta | Uso |
|---|---|
| `node/winuae-session.mjs` | Sesión WinUAE-DBG + GDB (biblioteca): lanzar/conectar, pausar, leer RAM, breakpoints |
| `node/launch.mjs` / `node/stop.mjs` / `node/session.mjs` | Lanzar **una vez** / cerrar solo lo propio / registro del PID y puertos |
| `node/side.mjs` / `node/side-read.mjs` | Canal lateral (2346): `state`/`regs`/`mem`/`poke`/`screenshot` sin pausar |
| `node/dump-ram.mjs` | Volcar regiones de RAM tras el boot |
| `node/hook-trampoline.mjs` | Localizar un decruncher por firma y volcar lo que descomprime |
| `node/probe-breakpoints.mjs` / `node/probe-layout.mjs` | Diagnóstico de breakpoints / descubrir dónde escribe una rutina |
| `node/dump-display.mjs` | Registros custom + Copperlist + bitplanes → PNG |
| `node/decode-bitplanes.mjs` | Decodifica bitplanes de un volcado a PNG (offline) |
| `node/grab-frame.mjs` | Captura de un frame del emulador |
| `python/dms_unpack.py` | DMS → ADF **verificado** (CRC/checksum por pista) |
| `python/copper_decode.py` | Decodifica una Copperlist binaria (MOVE/WAIT/SKIP) |
| `python/planar_decode.py` | Bitplanes planares → imagen |
| `python/imp_decrunch.py` | Decruncher Imploder (`IMP!`) |
| `python/AMIGA_BITMAPS.md` | Guía de reconstrucción de bitmaps OCS/ECS |
| `bin/ancient/` | `ancient` (descompresores Amiga: Imploder, etc.) |
| `capture-live.ps1` | Capturar un efecto en vivo en una sola invocación (WinUAE primer plano) |

## Requisitos

- **WinUAE-DBG x86** (`winuae-gdb.exe`) con GDB (`:2345`) + canal lateral (`:2346`).
- **mcp-winuae-emu** (repo hermano) compilado.
- **Kickstart** de la máquina (p. ej. `C:\Amiga\KICK13.rom`).
- **Node.js** ≥ 18 y **Python 3**.

## Notas de aislamiento

- Puertos propios del toolkit (**GDB 2445** / lado **2446**) para no interferir con otros proyectos.
- Cerrar **solo** la instancia propia (`stop.mjs` por PID), nunca matar todas.

Detalle, opciones y ejemplos completos: [`../../../tools/README.md`](../../../../tools/README.md)
y el guion de reproducción del nodo `arte`: [`../demos/arte/tools/README.md`](../demos/arte/tools/README.md).
