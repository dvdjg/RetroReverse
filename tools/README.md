# toolkit — utilidades reutilizables de ripping Amiga

Herramientas genéricas, **independientes del título**, para extraer imágenes, volcar RAM y
enganchar descompresores de cualquier software Amiga 68k. Cada utilidad está documentada aquí
y acepta su configuración por CLI/env, de modo que se reutiliza en cualquier expediente.

> **Split de plataformas**: `tools/` (marco) contiene ahora las utilidades **genéricas**
> (`python/bin_scan.py`, `python/ollama_vision.py`, `ghidra/`). Las **específicas de Amiga**
> (WinUAE/GDB, DMS, planar/copper, `AMIGA_BITMAPS.md`, `capture-live.ps1`, `imp_decrunch.py`,
> `bin/ancient`) viven en
> [`../platforms/computers/amiga500/tools/`](../platforms/computers/amiga500/tools/README.md).
> Las secciones siguientes se mantienen como **referencia** de su uso.

```
tools/
  node/
    winuae-session.mjs      biblioteca (lanzar WinUAE-DBG + GDB, pausar, leer RAM, buscar firmas, breakpoints)
    launch.mjs              CLI: lanzar WinUAE UNA vez (detached, sin GDB) para reutilizarlo
    stop.mjs                CLI: cerrar SOLO la instancia registrada (PID propio), sin tocar otras
    session.mjs             registro del PID/puertos de la instancia propia (`.session.json`)
    side.mjs                CLI: canal lateral (2346) de una instancia EN MARCHA (state/regs/mem/poke/screenshot)
    dump-ram.mjs            CLI: volcar regiones de RAM tras el boot
    hook-trampoline.mjs     CLI: localizar una rutina por firma y volcar lo que descomprime
    probe-breakpoints.mjs   CLI: comprobar que el stub aplica breakpoints (diagnóstico)
    probe-layout.mjs        CLI: descubrir dónde/cuánto escribe una rutina (diff de RAM antes/después)
    dump-display.mjs        CLI: registros custom + Copperlist + bitplanes -> PNG
    decode-bitplanes.mjs    CLI: decodifica bitplanes de un volcado a PNG (offline)
    side-read.mjs           CLI: leer el canal lateral lanzando el emulador (si no está en marcha)
  python/
    dms_unpack.py           DMS -> ADF verificado (todos los modos)
    bin_scan.py             strings + entropía de cualquier binario
    copper_decode.py        decodifica una Copperlist binaria (MOVE/WAIT/SKIP)
  ghidra/
    README.md               Ghidra + extensión Amiga (Hunk/USS/ROM, símbolos NDK, decompilador)
    InfoDump.java           bloques/entry points/funciones/símbolos de un programa importado
    DumpDecomp.java         decompila a C una función (o todas) en headless
    FindSig.java            busca una firma de bytes en toda la memoria
    DumpRange.java          escribe un rango de memoria a fichero (comparar)
```

Las *specs* de enganche son específicas de cada título y viven en el expediente, p. ej.
`../platforms/computers/amiga500/demos/arte/extraction/specs/sanity-arte.json`.

## Requisitos

- **WinUAE-DBG x86** (`winuae-gdb.exe`) con servidor GDB (`:2345`). El x64 tiene un bug de boot.
- **Kickstart** correspondiente a la máquina (p. ej. `C:\Amiga\KICK13.rom`).
- **mcp-winuae-emu** (repo hermano) compilado: `mcp-winuae-emu/dist/winuae-connection.js`.
- **Node.js** ≥ 18 y **Python 3**.
- Variable opcional `WINUAE_MCP_DIST` si el repo hermano no está en la ruta por defecto.

## Aislamiento del emulador (puertos y ratón)

Para no interferir con otros proyectos (vscode-amiga-debug, Amiga-Cpp, ...) ni robar el ratón
del sistema:

- **Puertos propios**: el toolkit usa **GDB 2445** y **canal lateral 2446** (no 2345/2346). Los
  overrides son `AMIGA_REVERSE_GDB_PORT` / `AMIGA_REVERSE_SIDE_PORT` (se ignoran las
  `WINUAE_GDB_PORT`/`WINUAE_SIDE_CHANNEL_PORT` ambientales, que en este equipo valen 2345).
- **WinUAE-DBG**: el canal lateral ya lee `WINUAE_SIDE_CHANNEL_PORT`; el puerto GDB se hardcodeaba
  a 2345. Se añadió (aditivo, **default 2345 intacto**) lectura de `WINUAE_GDB_PORT` en
  `od-win32/barto_gdbserver.cpp`. Recompilar con `build.bat`; el `.uae` por defecto sigue siendo
  2345 para el resto de proyectos.
- **No capturar el ratón**: el lanzador pasa `-s win32.start_not_captured=yes`,
  `-s win32.active_capture_automatically=no`, `-s win32.absolute_mouse=yes`; el `.uae` incluye
  además `win32.nonotificationicon=yes` y `absolute_mouse=none`.
- **Cerrar solo lo propio**: NUNCA `Get-Process winuae-gdb | Stop-Process -Force` (mataría
  instancias de otros proyectos). `launch.mjs` registra el PID en `.session.json` y `stop.mjs`
  termina **solo** ese PID (verificando que es `winuae-gdb`). Cerrar la instancia en cuanto no se
  necesite.

## El emulador debe estar en PRIMER PLANO para correr

`launch.mjs` lanza con `spawn(..., { detached: true })`; en este equipo la instancia puede quedar
**pausada** (PC y `cycles` estáticos, la CPU no avanza) aunque el canal lateral responda. Para que
la CPU **corra** hay que lanzarla con la **ventana en primer plano**. Alternativa que funciona:

```powershell
$env:WINUAE_GDB_PORT="2445"; $env:WINUAE_SIDE_CHANNEL_PORT="2446"
$exe="<...>\WinUAE-DBG\bin\winuae-gdb.exe"
$args=@("-f",$cfg,"-portable","-G","-s","headless=no","-s","debugging_features=gdbserver",
        "-s","win32.start_not_captured=yes","-s","win32.active_capture_automatically=no",
        "-s","win32.absolute_mouse=yes","-s","floppy0=$adf")
$p=Start-Process -FilePath $exe -WorkingDirectory (Split-Path $exe) -ArgumentList $args -PassThru
# luego: node side.mjs state  (pc/cycles deben avanzar)
```

Cerrar esa instancia por **su PID** (`Stop-Process -Id <pid>`), solo el propio.

## Receta: capturar un efecto concreto en vivo (una sola invocación)

Evitar relanzar en bucle: lanzar **una vez** y sondear dentro de esa sesión. Automatizado en
**`platforms/computers/amiga500/tools/capture-live.ps1`** (lanza en primer plano, sondea una firma, vuelca RAM + screenshot y
cierra por PID):

```powershell
./capture-live.ps1 -Config ../platforms/computers/amiga500/demos/arte/out/sanity.uae `
  -Adf ../platforms/computers/amiga500/demos/arte/rom/raw/sanity-arte.adf `
  -ProbeAddr 0x26758 -ProbePattern 0fff0ffc0fd9 -OutDir ./shots
```


1. Lanzar en primer plano (`Start-Process`, ver arriba). Comprobar que `node side.mjs state`
   muestra `pc`/`cycles` **avanzando**.
2. **Sondear** la "señal" del efecto con lecturas pequeñas (`mem` limita a 4096 B), p. ej. que la
   paleta del efecto aparezca en su dirección de RAM:
   `node side.mjs mem 0x26758 0x40 --out probe.bin` y comprobar los bytes.
3. Al detectar la señal, **volcar la RAM** una vez:
   `node side.mjs mem 0x0 0x80000 --out chip.bin` (chip) y `mem 0xC00000 0x40000` (slow).
4. **Screenshot** con **ruta ABSOLUTA** (las relativas a veces no se escriben):
   `node side.mjs screenshot "C:\...\shots\fx.png"`.
5. Cerrar por PID.

Notas: `screenshot` responde `{status,id}` y escribe el PNG de forma asíncrona (esperar ~2-4 s);
`side.mjs` sólo espera si la respuesta trae `action`, así que no bloqueará. La RAM no siempre
contiene el módulo del efecto (se carga bajo demanda): si no está, capturar en el momento correcto
o usar un breakpoint (sólo Z0 disponible).


## Flujo recomendado (evitar relanzar el emulador)

Lanzar WinUAE **una sola vez** y trabajar contra él por el **canal lateral** (sin pausar la CPU,
sin relanzar). Las herramientas `dump-*`/`hook-*`/`probe-*` sí lanzan su propia instancia: usarlas
solo cuando haga falta un estado limpio.

```powershell
# 1) lanzar una vez (queda en marcha; imprime el PID)
node launch.mjs --config out\game.uae --adf out\disk\game.adf

# 2) inspeccionar/modificar en runtime (sin relanzar)
node side.mjs state
node side.mjs regs
node side.mjs mem 0xdff080 0x140
node side.mjs mem 0x0 0x80000 --out out\ram\live-chip.bin
node side.mjs screenshot out\screens\live.png
node side.mjs lock acquire takeover
node side.mjs poke 0x1234 deadbeef parche    # escritura en runtime
node side.mjs lock release
# cerrar SOLO nuestra instancia (no toca las de otros proyectos)
node stop.mjs
```

**Regla de oro de formato**: el canal lateral interpreta los números en **base 10** salvo que
lleven `0x` (o letras hex). Enviar SIEMPRE `0x` (`0x140`, no `140`); de lo contrario pide/lee
otra cosa (p. ej. `1000` = 1000 decimal, no `0x1000`). `mem` limita a 4096 B por llamada.

## `launch.mjs` (CLI)

Lanza WinUAE-DBG `detached` (sin GDB) con la config + ADF y espera a que responda el canal
lateral. Pensado para dejar el emulador corriendo y reutilizarlo.

## `side.mjs` (CLI)

Cliente del canal lateral de una instancia **ya en marcha**: `hello|state|regs|mem|poke|lock|
screenshot|pause|resume|runstatus|raw`. Ver ejemplos arriba.

## `winuae-session.mjs` (biblioteca)

Sesión de alto nivel. Ejemplo de uso:

```js
import { WinUAE, sleep } from './node/winuae-session.mjs';

const uae = new WinUAE({
  configFile: 'expediente/out/game.uae',   // .uae de hardware
  adf:        'expediente/rom/raw/game.adf',
  winuaeDir:  'C:\\...\\WinUAE-DBG\\bin',   // opcional
  gdbPort:    2345,                          // opcional
});
await uae.open();          // lanza y conecta (CPU parada)
await uae.resume();        // arranca el software
await sleep(15000);
await uae.pauseRetry();    // pausa con reintentos (el stub tarda en atender 0x03)
const regs = await uae.regs();
console.log(regs.PC.toString(16));

await uae.dumpRegion(0x000000, 0x80000, 'extraction/ram/chip.bin');  // lectura por bloques, tolerante
await uae.screenshot('extraction/screens/estado.png');               // monitor screenshot

const addr = await uae.findPattern(0xc00000, 0x80000, '2c78c000...');  // firma en RAM
await uae.setBreakpoint(addr);
await uae.resume();
await uae.waitForStop(10000);
await uae.close(true);     // desconecta y cierra el emulador
```

Métodos: `open/attach`, `resume`, `pauseRetry`, `regs`, `monitor`, `screenshot`,
`readExact`, `readTolerant`, `dumpRegion`, `findPattern`, `setBreakpoint`, `clearBreakpoint`,
`waitForStop`, `step`, `close`. Utilidades: `parseRegion("0x0:0x80000")`, `WinUAE.reg(regs,'A1')`.

## `dump-ram.mjs` (CLI)

```powershell
node dump-ram.mjs --config out\game.uae --adf out\disk\game.adf `
  --boot 20 --regions 0x0:0x80000,0xc00000:0x80000 --out out --prefix game --screenshot
```

| Opción | Def | Descripción |
|---|---|---|
| `--config` | — | `.uae` de hardware (obligatorio) |
| `--adf` | — | ADF a insertar en DF0 |
| `--winuae` / `--exe` / `--port` | — | directorio / nombre / puerto GDB |
| `--boot` | 20 | segundos antes de pausar |
| `--regions` | `0x0:0x80000,0xc00000:0x80000` | regiones `0xSTART:SIZE` |
| `--out` / `--prefix` | `out` / `ram` | destino y prefijo |
| `--screenshot` | off | captura a `extraction/screens/<prefix>-boot.png` |

## `hook-trampoline.mjs` (CLI)

Localiza una rutina por **firma de bytes** en RAM y volca lo que descomprime, alternando un
breakpoint en la entrada (donde se leen destino/longitud) y otro en el retorno.

```powershell
node hook-trampoline.mjs --config out\game.uae --adf out\disk\game.adf `
  --spec ..\platforms\computers\amiga500\demos\arte\specs\sanity-arte.json --out out --boot 4
```

Spec JSON (ejemplo real: `../platforms/computers/amiga500/demos/arte/extraction/specs/sanity-arte.json`):

| Campo | Descripción |
|---|---|
| `patternHex` | bytes de la firma a localizar (prologue de la rutina/trampoline) |
| `parseOffset` | offset desde la firma donde destino/longitud son válidos (antes del `jsr`) |
| `retOffset` | offset del retorno (donde el bloque ya está descomprimido) |
| `destReg`, `lenReg` | registros con dirección y longitud del bloque (def `A1`,`D1`) |
| `metaReg` | registro opcional con puntero a la cabecera (metadatos) |
| `searchStart`, `searchSize` | rango de búsqueda de la firma |
| `maxSeconds`, `chunk` | duración y tamaño de lectura |
| `allowed` | rangos válidos de destino `{start,end}` (evita punteros falsos) |

Salida: `extraction/modules/mod_<n>_<addr>_<len>.bin` + `extraction/modules/modules.json` (con `sha1`).

**Extensión**: la forma «trampoline» cubre decrunchers con firma y destino/longitud en
registros. Otras formas (p. ej. destino derivado de una cabecera) requieren ampliar este script
con un modo adicional; mantener la spec como contrato.

## `probe-breakpoints.mjs` (CLI)

Diagnóstico previo a cualquier enganche: comprueba que el stub aplica `Z0`.

```powershell
node probe-breakpoints.mjs --config out\game.uae --adf out\disk\game.adf --boot 15
```

## `probe-layout.mjs` (CLI)

Descubre **dónde y cuánto escribe** una rutina sin conocer su contrato: localiza la rutina por
firma, para en la entrada, captura la cabecera y una foto de la RAM, para en el retorno, hace otra
foto y hace el **diff**. Imprescindible para rutinas que deducen destino/longitud de su cabecera.

```powershell
node probe-layout.mjs --config out\game.uae --adf out\disk\game.adf --spec specs\rutina.json --boot 12
```

Campos de la spec: `entryPatternHex`, `retOffset`, `headerReg`, `headerMagics`, `lenOffsets`,
`searchStart/Size`, `regions`, `minRun`. Ejemplo real: `../platforms/computers/amiga500/demos/arte/extraction/specs/imp-routine.json`.

## `dump-display.mjs` (CLI)

Captura el estado de vídeo: registros custom -> JSON, **Copperlist** (`COP1LC`) -> `.txt`/`.bin`,
paleta -> JSON y bitplanes -> PNG (reutiliza `bitmap-decode` de `mcp-winuae-emu`).

```powershell
node dump-display.mjs --config out\game.uae --adf out\disk\game.adf --boot 20 --out out --prefix game
```

Opciones: `--width --height --depth --rowbytes --layout` (si no, se deducen de BPLCON0/DIW/DDF).

**Limitación conocida**: las lecturas *en vivo* de registros custom (GDB y canal lateral) reflejan
la **zona instantánea** del Copper y son incoherentes entre capturas (`BPLCON0`, `COP1LC`,
`BPLxPT` varían). La Copperlist capturada puede ser la activa o un **buffer reutilizado**; tratarla
como candidata a validar. La referencia fiable del aspecto es `screenshot`. Ver
`../LECCIONES_APRENDIDAS.md` §6bis.

## `decode-bitplanes.mjs` (CLI)

Decodifica bitplanes de un **volcado de RAM** a PNG, sin relanzar el emulador. Útil para
experimentar con direcciones/tamaños/planos offline.

```powershell
node decode-bitplanes.mjs --file out\ram\chip000000.bin --base 0x0 --addr 0x3a600 `
  --width 320 --height 256 --depth 5 --rowbytes 40 --layout interleaved `
  --palette out\display\pics-palette.json --out out\display\try.png
```

## `side-read.mjs` (CLI)

Lee el **canal lateral** de WinUAE-DBG (puerto 2346, independiente de GDB). Fiable para
`state`/`regs` (PC, ciclos, registros de CPU) y `mem` de RAM.

```powershell
node side-read.mjs --config out\game.uae --adf out\disk\game.adf --boot 20 --state --regs
node side-read.mjs --config out\game.uae --adf out\disk\game.adf --boot 20 --mem 0xdff080:0x140
```

La biblioteca expone `uae.side(command)` con los comandos `hello|state|regs|mem <addr> <len>|
runstatus <addr>`. Requiere `WINUAE_GDB_PERSIST_LISTENER=1` (la biblioteca lo activa sola).

## `dms_unpack.py`

```powershell
python python\dms_unpack.py entrada.dms salida.adf --verbose
```

Todos los modos (NOCOMP/SIMPLE/QUICK/MEDIUM/DEEP/HEAVY1-2). **Verifica** CRC de cabecera, CRC
del bloque comprimido y checksum del bloque descomprimido por pista. Portado de xDMS
(`WinUAE-DBG/archivers/dms`).

## `bin_scan.py`

```powershell
python python\bin_scan.py out\ram\slowc00000.bin --base 0xc00000
```

Strings (offset + dirección) y entropía por bloque. Sirve para ADF y volcados de RAM.

## `copper_decode.py`

```powershell
python python\copper_decode.py out\modules\mod_003.bin --base 0x26614 > copper.txt
```

Decodifica una Copperlist binaria a texto (`MOVE`/`WAIT`/`SKIP`). `--json` para estructura.

## Ghidra + extensión Amiga (`ghidra/`)

Análisis con **Ghidra** y la extensión `BartmanAbyss/ghidra-amiga` (loaders **Hunk**, **WinUAE
`.uss`** y **Kickstart ROM**, analyzer de llamadas a librería + símbolos **NDK 3.9**, y el
**decompilador a C**). Scripts headless: `InfoDump`, `DumpDecomp`, `FindSig`, `DumpRange`.
Instalación, comandos y limitaciones: [`ghidra/README.md`](ghidra/README.md). Evaluación completa:
[`../platforms/computers/amiga500/demos/arte/docs/GHIDRA_AMIGA_EVAL.md`](../platforms/computers/amiga500/demos/arte/docs/GHIDRA_AMIGA_EVAL.md).

Rizin/radare2 es la alternativa ligera para disasm + xrefs/CFG (sin decompilador en el build base).
Ver `../LECCIONES_APRENDIDAS.md` §7bis.

## Añadir soporte a un rip nuevo

1. Copiar una spec existente (p. ej. `../platforms/computers/amiga500/demos/arte/extraction/specs/sanity-arte.json`) al `specs/` del
   expediente y adaptar `patternHex`/offsets/registros a la rutina hallada (usar
   `winuae-session.findPattern` o `bin_scan.py` para localizar la firma).
2. Ejecutar `dump-ram.mjs` para el volcado inicial y `hook-trampoline.mjs` para los módulos.
3. Documentar en el expediente qué comando y qué spec se usaron.

## Herramientas multi-plataforma (arcade/consola)

Además del toolkit Amiga, `tools/` incluye utilidades agnósticas para el resto de plataformas:

| Herramienta | Qué hace |
|---|---|
| `python/retro_img.py` | Escritura de PNG (sin dependencias) y tilesheets |
| `python/nes_assets.py` | iNES → tiles CHR (8×8, 2bpp) + paleta + PRG |
| `python/pacman_assets.py` | Romset Pascal/MAME Pac-Man → tiles 8×8 + PROMs de color + programa Z80 |
| `python/capstone_disasm.py` | Desensamblado Capstone (`m6502`, `m68k`) → `.asm` + `.ranges.json`/`.ranges.txt` |
| `python/ppm_diff.py` | Diff de framebuffers PPM (validación diferencial) |
| `python/re_functions_to_ranges.py` | Salida de libRetroReversing (`functions.json`) → rangos para `ApplyRanges` |
| `python/re_trace_to_ranges.py` | Trace de ejecución de libRetroReversing (`trace_log.txt`) → rangos (PCs únicos) |
| `ghidra/ApplyRanges.java` | Puente trazas/cobertura → Ghidra: crea funciones en los rangos |

`Z80` **no** está en Capstone 5 (llegó en la rama `next`); para Z80 usar **Rizin**. Atajo reproducible:
`scripts/extract-assets.sh` (salidas en `tools/out/assets/`, ignorado por git).

### Loaders de Ghidra (consolas)

`external/ghidra-extensions/` + instalados en Ghidra 12.0.1 (`Ghidra/Extensions/`):
**GhidraNes** (build para 12.0.1), y para 11.1.2 (incompatibles con 12) `GhidraBoy`,
`ghidra_sega_ldr`, `SMSLoader`. Ver [`../docs/REFERENCES.md`](../docs/REFERENCES.md).
