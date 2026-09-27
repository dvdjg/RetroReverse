# runtime — código de destino (host + Amiga 500)

Runtime que ejecuta el código transpilado y traduce el estado de la NES a operaciones nativas del
Amiga. Es la base de las fases F1/F3/F4 del [`ROADMAP`](../docs/ROADMAP.md).

## Núcleo del runtime

| Fichero | Contenido | Estado |
|---|---|---|
| [`include/nes_runtime.hpp`](include/nes_runtime.hpp) | `NESMemory` (RAM, PPU/APU/E/S, PRG-ROM) y `CPU` 6502 de métodos (registros, flags, pila, modos y familias de opcodes) + macro `N2A_ASSUME` | **F1 (base)** |
| [`include/nes_interpreter.hpp`](include/nes_interpreter.hpp) | Intérprete 6502 (oficiales + ilegales) con **conteo de ciclos** | **F1**: validado con `nestest` |
| [`host/fastcpu.hpp`](host/fastcpu.hpp) | **Ejecutor rápido** pre-decodificado por dirección (hook `NesSystem::fast_step`) | camino transpilado, ver [`FAST_EXECUTOR.md`](../docs/FAST_EXECUTOR.md) |
| [`include/nes_mapper.hpp`](include/nes_mapper.hpp) | Cartucho: NROM/UxROM/CNROM y MMC1 parcial (bancos PRG/CHR) | **F9** (en curso) |
| [`include/nes_hle.hpp`](include/nes_hle.hpp) | Clasificador HLE de escrituras PPU + **ratio** | **F8** (en curso) |
| [`include/nes_system.hpp`](include/nes_system.hpp) | Sistema NES (CPU+PPU+APU+mapper), `run_frame` y RGB | **F3/F9** (en curso) |
| [`tools/facts_from_run.cpp`](tools/facts_from_run.cpp) | Extractor de **hechos de valores** por telemetría (`--facts`) | herramienta host |
| [`tools/nes_frame.cpp`](tools/nes_frame.cpp) | Ejecuta una ROM y vuelca un frame PPM + hash | herramienta host |
| [`tools/bench_engine.cpp`](tools/bench_engine.cpp) | **Equivalencia + FPS** intérprete vs ejecutor rápido | herramienta host |
| [`tools/dbg_fast2.cpp`](tools/dbg_fast2.cpp) | Comparación **lockstep** CPU+PPU entre ambos motores | herramienta host |
| [`tools/opcode_hist.cpp`](tools/opcode_hist.cpp) | **Histograma de opcodes** y tasa de cobertura del ejecutor rápido | herramienta host |
| [`test/diff_mesen.sh`](test/diff_mesen.sh) | **Validación diferencial** contra `mesen` | informativa |
| [`fallback/nes_ppu.hpp`](fallback/nes_ppu.hpp) | PPU software: registros, VRAM, OAM, paleta, scroll, VBlank/NMI y render del fondo | **F3** (en curso) |
| [`fallback/nes_apu.hpp`](fallback/nes_apu.hpp) | APU software: registros `$4000-$4017`, frame counter y síntesis pulse/triangle/noise | **F7** (en curso) |

Todo es **header-only** sobre `eng/core`, sin STL, y compila igual en host y en `m68k`. El `.cpp`
generado incluye `nes_runtime.hpp` y enlaza la PRG con `NESMemory::prg`/`prg_size`.

## Plataformas de ejecución

El núcleo es **agnóstico** y corre sobre la interfaz `Host` ([`platform/host.hpp`](platform/host.hpp)):

- **SDL3** (PC y navegador): [`platform/sdl_host.hpp`](platform/sdl_host.hpp) +
  [`host/main.cpp`](host/main.cpp). Build PC con [`host/build-pc.ps1`](host/build-pc.ps1) (MinGW) o
  CMake; **navegador** con [`web/build_web.sh`](web/build_web.sh) (Emscripten, SDL3 como *port*).
  SDL3 está en `external/SDL3/` (**3.4.16**). Teclado: `Z`/`Espacio`=A, `X`=B, `Enter`=Start,
  `Backspace`/`RShift`=Select, flechas=cruceta, `Esc`=salir.
  - **Motor codegen**: `build-pc.ps1 -CodegenRom <rom.nes>` transpila esa ROM y la enlaza en
    `nes_sdl_codegen.exe` (ejecuta el **C++ transpilado**; fallback a `FastCpu`/intérprete para RAM/
    saltos calculados). Es específico por ROM (C++ no se compila en runtime). Ver
    [`../docs/FAST_EXECUTOR.md`](../docs/FAST_EXECUTOR.md).

### Configuración, shaders y ShaderGlass

- **`nes_sdl.cfg`** (junto al ejecutable; `--config <f>`): archivo editable (`clave = valor`) con
  `scale` (escala entera de la ventana; por defecto **4** → cada píxel NES = 4x4 px), `shader`,
  `shader_next`/`shader_prev` (teclas SDL para cambiarlo **en partida**) y los campos de ShaderGlass.
- **Shaders propios** ([`host/n2a_shaders.hpp`](host/n2a_shaders.hpp)): `none`, `scanlines` y
  `crt80s` (TV de los 80: scanlines + **beam** + viñeta + tono cálido). Se eligen en el gestor
  (`S` → menú de shaders) y con `shader_next`/`shader_prev` durante la partida; se guardan en `nes_sdl.cfg`.
- **Ventana reescalable** con **escala entera** (`SDL_LOGICAL_PRESENTATION_INTEGER_SCALE`): el frame
  256x240 se reescala a la ventana manteniendo píxeles nítidos (letterbox al mayor múltiplo entero).
- **ShaderGlass** ([`external/ShaderGlass`](../../../external/ShaderGlass), GPLv3): overlay externo
  que captura la ventana (modo *Window Clone*) y aplica shaders de RetroArch. Configura
  `shaderglass_exe` (y opcionalmente `shaderglass_profile` `.sgp`); el host lo **lanza** al arrancar.
  Shader CRT por defecto en la config: `shaderglass_shader = newpixie-crt` (de la librería del clon).
- **Juegos `.7z`**: el transpilador empaqueta por defecto cada plugin en
  `<rom>.<plataforma>.7z` (y `--bundle <nombre>` agrupa varias ROMs en **un solo** `.7z`); el
  gestor extrae los `.7z` a `.n2x_cache/` y lista su contenido (deduplicado). También se pueden
  **transpilar ROMs dentro de un `.7z`** (entrada comprimida). Requiere `7zr.exe` (`sevenzip_exe`;
  se copia junto al ejecutable).
- **Audio**: al volver al menú se **pausa y vacía** el stream (no sigue sonando).
- **Amiga 500**: [`platform/amiga/README.md`](platform/amiga/README.md) (Copper/Blitter/Paula).
- **RetroArch (libretro)**: core en [`retroarch/`](retroarch/README.md) (`nes_libretro.so`) con
  plugins de vídeo/audio; se carga desde RetroArch y transpila/ejecuta la ROM.

Detalle y contrato: [`platform/README.md`](platform/README.md).

### Tests

`bash test/run.sh` (WSL/Linux o MinGW): valida la CPU con `nestest` ($02=$03=0), el **conteo de
ciclos**, la PPU (fondo + **sprites** + sprite-0 hit + **scroll mid-frame** + registros), la APU
(pulse/triangle/noise/**DMC** + mezcla no lineal), el **sistema NES + HLE** (ratio ~97 %) y la
**telemetría** de valores; comprueba la **equivalencia del ejecutor rápido** + FPS
([`FAST_EXECUTOR.md`](../docs/FAST_EXECUTOR.md)); y ejecuta la **validación diferencial con `mesen`**
(`diff_mesen.sh`, informativa). Pendiente: afinar timing/paleta (F3) y volcado a Paula (F7);
*banking* en el transpilador (F9).

## Capas de destino (a partir de F3)

| Carpeta | Contenido | Doc |
|---|---|---|
| [`fallback/`](fallback/README.md) | PPU/APU software (camino lento, oráculo) | [`ARCHITECTURE.md`](../docs/ARCHITECTURE.md) |
| [`hle/`](hle/README.md) | handlers `hle_*` (scroll, OAM, VRAM, bankswitch) | [`HLE.md`](../docs/HLE.md) |
| [`amiga/`](amiga/README.md) | Copper, Blitter, sprites, Paula, VBlank, pantalla | [`RUNTIME_AMIGA.md`](../docs/RUNTIME_AMIGA.md) |

## Build

- **Host** (iteración rápida y validación): `g++ -std=gnu++23`.
- **Destino**: `m68k-amiga-elf-g++` o `vbcc`; ASM crítico con `vasm`/`vasm-elf`.
  Convenciones y punto fijo en [`../../../PORTING.md`](../../../PORTING.md).
