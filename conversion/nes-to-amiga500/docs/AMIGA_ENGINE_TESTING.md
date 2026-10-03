# Pruebas del port en Amiga (A500 / A1200 / A4000) sobre el engine Amiga-Cpp

Notas locales para **compilar, lanzar, depurar y ver** el port/emulador NES sobre el engine
`Amiga-Cpp`. Todo desde **Windows nativo + Git Bash** (nunca WSL: mangla rutas y rompe `cc1plus`/WinUAE).
Referencias: `Amiga-Cpp/docs/engine/NES_CONSUMER_GUIDE.md` y `Amiga-Cpp/docs/build/BUILD_AND_RUN.md`.

## 0. Setup

```powershell
$env:AMIGA_BIN_PATH = "$env:USERPROFILE/Documents/programa/AI/Amiga/vscode-amiga-debug/bin/win32"
$BASH = 'C:\Program Files\Git\bin\bash.exe'
$ENG  = '/c/Users/dvdjg/Documents/programa/AI/Amiga/Amiga-Cpp'
```

- Toolchain `m68k-amiga-elf` de la extensión Bartman; **Kickstart A500** en `c:/Amiga/KICK13.rom`.
- **Sin Fast RAM por defecto** (máquinas stock). Los demos piden solo Chip/Slow
  (`configure_memory({chip, slow, frame})`). La config base es `quickstart=a500,1` (512K chip + 512K
  slow). **No** añadir Fast salvo que no quede otra; si hiciera falta, editando la config `.uae`.

## 1. Compilar

```powershell
# A500 (68000, por defecto)
& $BASH -lc "cd $ENG && ./tools/build/build-demo.sh demos/features/engine/amiga/062_sprite_scene --debug --clean"
# A1200 (68020)
& $BASH -lc "cd $ENG && TARGET_MACHINE=A1200 ./tools/build/build-demo.sh demos/... --debug --clean"
```

- `TARGET_MACHINE` = `A500` (def.) | `A1200` | `AtariST` | `Megadrive` | `NeoGeo`. Salida en
  `Amiga-Cpp/out/demos/<app_id>/<CONFIG_ID>/` (`.exe`, `.elf` con DWARF, `.map`, `.s`).
- `--release`/`--debug`; `--clean` fuerza rebuild. Ajustes por app en `src/build.args`
  (`DEMO_OPT=-O2`, `FAST_STACK=1`, `EXTRA_DEFINES=...`).
- **68000 puro**: `node tools/analyze/asm-audit.mjs <app>.elf` (falla si aparece `muls.l`, `fmove`, …).

## 2. Lanzar el emulador (WinUAE) + captura

```powershell
& $BASH -lc "cd $ENG && WINUAE_GDB_PORT=2355 WINUAE_SIDE_CHANNEL_PORT=2421 ./tools/run/run-demo.sh demos/features/engine/amiga/062_sprite_scene --warp"
```

- Lanza `winuae-gdb.exe`, conecta **GDB**, espera `READY` por el **canal lateral** y guarda
  `out/run/<app_id>/<CONFIG_ID>/`: `screenshot.png`, `sequence/frame_*.png`, `run-report.json`.
- Opciones: `--warp` (acelera VBlanks; solo throughput/diagnóstico) · `--keep-running` (**bloquea**: deja
  WinUAE abierto y no retorna → lanzarlo en segundo plano) · `--disk <adf>` · `--cd32`.
- Puertos **propios por hilo** (no matar instancias ajenas): usa un par distinto por sesión.

### 2.1 A1200 / A4000 (⚠️ hallazgo)

El runner **siempre emula A500** (`quickstart=a500,1`, KICK13) aunque el build sea `A1200`. Es decir,
`TARGET_MACHINE` cambia el **código** (p. ej. `-m68020`) pero **no** la máquina emulada. Para probar de
verdad A1200/A4000 hay que **editar `Amiga-Cpp/config/mcp-amiga-c-debug.uae`** (o `-b ootonly`):
`quickstart=a1200,0` / `quickstart=a4000,0` y el `kickstart_rom_file` correspondiente (3.0/3.1). Sin
esto, un binario con instrucciones 68020+ podría fallar en el A500 emulado.

## 3. Depurar (GDB + canal lateral + símbolos)

- El runner conecta **GDB** (`gdbConnected` en `run-report.json`) y expone el **canal lateral**
  (estado/registros/memoria) independiente de GDB.
- Consultar mientras corre (instancia viva):

```powershell
& $BASH -lc "cd $ENG && WINUAE_SIDE_CHANNEL_PORT=2421 node dist/tools/debug/winuae-side-channel.js state"
& $BASH -lc "cd $ENG && WINUAE_SIDE_CHANNEL_PORT=2421 node dist/tools/debug/winuae-side-channel.js regs"
& $BASH -lc "cd $ENG && WINUAE_SIDE_CHANNEL_PORT=2421 node dist/tools/debug/winuae-side-channel.js mem <addr> <len>"
```

- Para **inspección en vivo**, lanzar `run-demo.sh ... --keep-running` **en segundo plano**
  (`Start-Process … -WindowStyle Hidden`), esperar ~40 s, consultar el canal y **matar solo mi instancia**
  (`Get-Process winuae-gdb | Stop-Process`).
- Símbolos: `out/demos/<app>/<CONFIG_ID>/<app>.map` (direcciones runtime) y `.elf` (DWARF).
- **`run-report.json`** ya trae `sideChannel.state` (`pc`, `cycles`, `sections`) y `runStatus`
  (`state: 3 = Ready`). Checkpoints/counters del periférico `0xB70000` vía `monitor debugperiph`.

## 4. "Ver" el resultado (Ollama visión local)

```powershell
& $BASH -lc "cd $ENG && node tools/analyze/ollama-desc.mjs out/run/<app>/<CONFIG_ID>/sequence 0,1,2 '<prompt>'"
```

- Modelo local `qwen3-vl:8b-instruct-q8_0` (arranca `ollama serve` si hace falta).
- Acepta `frame_NNN.png` y `frame_NNN_fXXXX.png` (arreglado). Si no hay `sequence/`, copiar
  `screenshot.png` a `frame_000.png` en un dir temporal.
- Para **dinámica**, analizar **varios** índices (secuencia), no una sola imagen.

## 5. Caminos del consumidor NES (qué usar)

- **BG (nametable + atributos + scroll 8-way)** → capa de tiles: `tilemap::TileMap16`/`TileEditor`/
  `AttributeTable` + `field::StripScrollLayer`/`XlimitedScene`/`ScrollKind`.
- **Sprites (OAM)** → `eng::SpriteScene` (nivel A) → `compose_sprites` (HW + BOB fallback).
- **Vía correcta = tile/sprite** (el PPU NES es motor de tiles, no framebuffer por píxel). El
  `eng::IndexedDisplay`/C2P queda para **efectos/fallback**; el C2P rápido es el **asm de Kalms**.
- **Timing**: `Game::update` corre una vez por frame **tras VBlank** (es el "NMI" del 6502). El port ya
  usa un **contador de ciclos → evento VBlank/NMI**.

## 6. Problemas conocidos del engine (a corregir)

- **Runner siempre A500** (§2.1): `quickstart` fijo; falta selección de máquina por `TARGET_MACHINE`.
- **`ollama-desc.mjs`**: esperaba `frame_NNN.png` (arreglado a `frame_NNN(_fXXXX)?.png`).
- **gcc 15 m68k a `-O1`**: bug de codegen en el camino `run_frames_polling→update→pump` (pasa un `this`
  erróneo); la demo 212 lo evita con `DEMO_OPT=-O2` (documentado en `build.args`).
- **`IndexedDisplay` 5/6 planos**: bug de display abierto (el 4 planos está verificado); el C2P genérico
  de 5/6 planos es lento — el rápido es el asm de Kalms.
