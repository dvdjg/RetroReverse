# orchestrator — capa de control de emulación

Orquestador del pipeline: carga ROM → ejecuta emulador instrumentado → genera trazas/savestates →
alimenta el análisis → produce la HIGS. Aquí vive el **contrato** con los emuladores.

## Contrato

- Interfaz C++: [`include/emulator_control.hpp`](include/emulator_control.hpp)
  (`EmulatorControl`, `InputState`, `TraceConfig`).
- Semántica y requisitos: [`../../docs/INSTRUMENTATION.md`](../../docs/INSTRUMENTATION.md).

## Implementaciones

| Adaptador | Plataforma | Vía | Estado |
|---|---|---|---|
| WinUAE-DBG | Amiga 500 | GDB + canal lateral | existe en `platforms/computers/amiga500/tools/` (por adaptar a la interfaz) |
| **libretro** | Arcade / consola / Amiga | core + frontend headless | **HECHO** (`libretro_adapter`) |

## Adaptador libretro

- [`include/libretro_api.hpp`](include/libretro_api.hpp) — subset mínimo de la API libretro.
- [`include/libretro_adapter.hpp`](include/libretro_adapter.hpp) + [`src/libretro_adapter.cpp`](src/libretro_adapter.cpp):
  - carga un core (`.dll`/`.so`), implementa los callbacks (`environment`, `video`, `audio`, `input`),
  - expone `EmulatorControl`: `load_rom`, `reset`, `step_frames` (un `retro_run` por frame),
    `save_state`/`load_state` (`retro_serialize`), `read_mem`/`write_mem` (`RETRO_MEMORY_SYSTEM_RAM`),
    `set_input`, `screenshot` (PPM del último frame),
  - extras para evidencia/determinismo: `frame_hash()` (FNV-1a del framebuffer RGBA),
    `frame_rgba()`, `system_ram_size()`, `read_memory(id, addr, len)`.
- **Orden de callbacks**: `retro_set_environment` → `retro_init` → resto de `retro_set_*`
  (orden canónico del frontend; algunos cores como **mesen** lo exigen).
- **Contrato de entorno**: sin variables de core (`GET_VARIABLE` → `false`), se aceptan e ignoran
  las que publica el core (`SET_VARIABLES/CORE_OPTIONS*`, `SET_CONTROLLER_INFO`, `SET_GEOMETRY`…).
  Así el core usa sus **defaults** (línea base determinista).
- **Limitación**: `set_trace` no es genérico en libretro; requiere API de debug del core
  (p. ej. mesen). Se guarda la config y queda como extensión.

## Compilar cores reales

Se compilan en **WSL/Linux** (los `.so` que carga el adaptador) y se copian a `external/<core>/`:

```powershell
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo && bash scripts/build-cores.sh"
# o uno a uno:
wsl -d Ubuntu -- bash -lc "cd /mnt/c/.../repo && bash scripts/build-libretro-core.sh libretro-mame2003-plus"
# comprobar que el adaptador los carga:
wsl -d Ubuntu -- bash -lc "bash /mnt/c/.../repo/scripts/check-cores.sh"
```

`scripts/build-libretro-core.sh` sincroniza el árbol a `~/rrbuild` (ext4, no DrvFs), compila y copia
el binario de vuelta. `RR_JOBS` limita el paralelismo.

### Cores compilados

| Core | Binario en `external/` | Contenido |
|---|---|---|
| **mame2003-plus** | `libretro-mame2003-plus/mame2003_plus_libretro.so` | Arcade (`pacman.zip`…) |
| **genesis-plus-gx** | `libretro-genesis-plus-gx/genesis_plus_gx_libretro.so` | Mega Drive / Genesis |
| **mesen** | `libretro-mesen/mesen_libretro.so` | NES |
| **libretro-uae** | `libretro-uae/puae_libretro.so` | Amiga (core `PUAE`) |
| **stella** | `libretro-stella/stella2023_libretro.so` | Atari 2600 |
| **gambatte** | `libretro-gambatte/gambatte_libretro.so` | Game Boy / Game Boy Color |
| **smsplus-gx** | `libretro-smsplus/smsplus_libretro.so` | Master System / Game Gear |
| **RetroArch** | `external/RetroArch/retroarch-linux-x86_64` | Frontend de referencia (1.22.2) |

`stella` se compila desde `src/os/libretro` (el `Makefile` raíz es el standalone y pide
`./configure`). El script de build autodetecta ese caso. `libretro-stella`/`libretro-gambatte`/
`libretro-smsplus` se clonan con [`scripts/fetch-cores.sh`](../../scripts/fetch-cores.sh).

## Test

```sh
make test     # construye host_test + test_core.so y ejecuta el smoke test (WSL/Linux)
```

`test/test_core.cpp` es un **core mínimo** (no un emulador) que valida el adaptador: avanza RAM por
frame, refleja el input, serializa estado y emite un frame. Salida esperada: `TODOS LOS TESTS OK`.

## Vertical slice

[`test/vertical_slice.cpp`](test/vertical_slice.cpp) ejecuta un **core real** y vuelca
trazas/savestates/capturas a `extraction/`:

```sh
make vertical_slice
./vertical_slice --core <core.so> --rom <rom> --out <dir> \
    --frames 600 --interval 60 --scenario start --det 30 --dump-ram 0x4c00:0x400,0x4ff0:0x100
```

Genera `traces/manifest.json`, `traces/frames.csv`, `savestates/frame_*.state`,
`screenshots/frame_*.ppm` y `memory_dumps/frame_*_ram_*.bin`, y comprueba **determinismo**
(mismo *state+input* → mismo framebuffer).

Para Pac-Man hay un envoltorio reproducible:

```sh
bash scripts/pacman-slice.sh     # requiere pacman.zip en el nodo (ver más abajo)
```

### Smoke test por plataforma

Con las ROMs de [`docs/ROM_SELECTION.md`](../../docs/ROM_SELECTION.md):

```sh
bash scripts/smoke-cores.sh      # mame, nes, megadrive, mastersystem, gamegear, atari2600, gb, gbc
```

### Notas de determinismo

- La comprobación descarta un **frame de cebado** tras `load_state`: algunos cores emiten ahí un
  frame duplicado (`data==NULL`) y no habría frame nuevo, lo que daría una falsa divergencia. Se
  comparan `det` frames *después* del cebado.
- `mame2003-plus` **no exponía** `RETRO_MEMORY_SYSTEM_RAM`; se ha **parcheado**
  (`src/mame2003/mame2003.c`) para volcar cada frame el espacio Z80 de 64 KB vía `cpu_readmem16`
  → `system_ram_size()==65536` y `memory_dumps/` con VRAM/workram reales.

### Trazas y memoria por región

- El adaptador **copia** las regiones publicadas por el core vía `SET_MEMORY_MAPS` (mesen publica
  su RAM interna) y expone `read_map(addr,len)` / `memory_map_count()`.
- `set_trace(TraceConfig)`:
  - `TraceKind::MemoryWrite` → **trazas de escritura por frame**: muestrea `[addr_start,addr_end)`
    tras cada `retro_run` y registra `(frame, addr, old, new)`. `vertical_slice --trace-writes A:L`
    las vuelca a `traces/writes.csv` (probado con mesen: miles de escrituras en RAM).
  - `TraceKind::Execution` (PC) → **no** es posible de forma genérica por libretro; requiere la API
    de debug del core. Para cobertura de PC se usa el emulador NES propio (`--coverage`, ver
    `platforms/consoles/nes/docs/TESTING.md`), que alimenta `tools/ghidra/ApplyRanges.java`.
- Botones extra `l2`/`r2` en `InputState` (para cores de reversing).

### Core instrumentado (libRetroReversing)

Se compila un **Genesis Plus GX con libRetroReversing** (`external/libretro-gpgx-reversing/`,
fork `RetroReversing/Genesis-Plus-GX`) con `scripts/build-libretro-core.sh libretro-gpgx-reversing`.
Al cargar una ROM de Mega Drive crea `RE_projects/<consola>/<juego>/` (playthroughs, CDL, src) en
el **CWD** (ignorado por git). Requiere dos parches triviales en el submódulo: `#include <cstdint>`
en `cdl/CDL_FileWriting.hpp` y quitar `-lc++` de `Makefile.retroreversing`. El runtime arranca en
`paused` y se conduce por su **interfaz web** (mensajes de estado `libRR_settings`); **conducirlo
headless está pendiente** — por eso la cobertura de ejecución real se obtiene del **emulador NES
propio** (`--coverage`) y se alimenta a `tools/ghidra/ApplyRanges.java`.


## Cores disponibles (`external/`)

Arcade: `libretro-mame`, `libretro-mame2003-plus` · NES: `libretro-mesen`, `libretro-nestopia`,
`libretro-fceumm` · Megadrive: `libretro-genesis-plus-gx` · Amiga: `libretro-uae` (basado en WinUAE),
`libretro-puae` · Soporte: `RetroArch`, `libretro-super`, `libretro-common`, `libretro-database`,
`libRetroReversing`.
