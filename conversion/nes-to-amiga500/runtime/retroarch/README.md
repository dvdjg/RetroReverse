# core libretro (RetroArch) — NES

El emulador del nodo se empaqueta como **core libretro** para que **RetroArch** pueda seleccionarlo
y ejecutar ROMs NES. Se siguen las directrices de libretro (API `retro_*`, `libretro.h`, formato de
vídeo/audio/entrada, savestates). Cada plataforma soportada será **un core** (`nes_libretro`,
`megadrive_libretro`, …) que comparte el runtime y la capa de plataforma `Host`
([`../platform/README.md`](../platform/README.md)).

## Ficheros

| Fichero | Contenido |
|---|---|
| [`libretro_core.cpp`](libretro_core.cpp) | Implementación de la API libretro sobre `NesSystem` |
| [`plugins.hpp`](plugins.hpp) | Plugins de **vídeo** y **audio** (seleccionables por core option) |
| [`Makefile`](Makefile) | Compila `build/nes_libretro.so` (usa `external/libretro-common/include/libretro.h`) |

`libretro.h` ya está en el repo: `external/libretro-common/include/libretro.h`.

## Mapeo de la API libretro

| Función libretro | Qué hace el core |
|---|---|
| `retro_get_system_info` | Nombre, versión, extensión `nes`, `need_fullpath=false` |
| `retro_get_system_av_info` | 256×240, `fps=60.0988`, `sample_rate=44100` |
| `retro_init` | `SET_PIXEL_FORMAT=XRGB8888` + core options (plugins) |
| `retro_load_game` | **Transpila/analiza** la ROM (iNES/NES2.0) y monta `NesSystem` |
| `retro_run` | 1 frame: entrada → `run_frame()` → vídeo (plugin) → audio (plugin) |
| `retro_serialize/_unserialize/_size` | Savestate (CPU+RAM+PPU+APU) |
| `retro_get_memory_data/size` | Expone `RETRO_MEMORY_SYSTEM_RAM` (2 KB de RAM NES) |
| `retro_get_region` | NTSC |
| `retro_reset` | Reinicia CPU/PPU al vector de reset |

Entrada: `RETRO_DEVICE_ID_JOYPAD_*` → byte de `$4016` (A,B,Select,Start,flechas).

## Plugins (gráficos/sonido)

El usuario los cambia en RetroArch → **Core Options**:

- `nes_video_plugin` = `raw` | `gray` (paleta 2C02G, escala de grises)
- `nes_audio_plugin` = `linear` | `mute`
- `nes_engine` = `auto` | `fast` | `interpreter` | `codegen`: motor de CPU. `auto` usa `codegen` si el
  core lo trae enlazado y, si no, `fast`; `fast` es el ejecutor **pre-decodificado**; `codegen`
  requiere un core con el transpilado de la ROM (ver abajo). Ver
  [`../docs/FAST_EXECUTOR.md`](../docs/FAST_EXECUTOR.md).

`plugins.hpp` define `VideoPlugin` (convierte el framebuffer de **índices NES** a XRGB8888) y
`AudioPlugin` (mono del APU → estéreo S16). Añadir un plugin = implementar la interfaz y
registrarlo en `Plugins`. Ejemplos futuros: *composite*/NTSC, *scanlines*, reescalado, HD packs
(vídeo); paso-bajo o mezclas alternativas (audio).

### Ajustes por ROM

Además de las opciones globales, el core admite **ajustes por ROM** (otro grupo de tiles, tiles
de **4 bpp**, paletas/plugin de audio alternativos) **sin afectar a la emulación**: ver
[`../enhance/README.md`](../enhance/README.md). Mecanismo:

- **Core options por juego** de RetroArch (`*.opt`): los plugins ya son opciones; pueden fijarse
  por título.
- **Perfil por CRC32** ([`../enhance/rom_profile.hpp`](../enhance/rom_profile.hpp)): al cargar, el
  core busca el perfil de la ROM y aplica `Ppu::tile_provider` / `Ppu::ext_palette`.
- El camino HLE/Amiga no cambia: `IPatternCache`/`IScrollingLayer` aceptarán el `bpp` y la paleta.

## Transpilador integrado

La idea es que el core **lleve el transpilador** y, al cargar la ROM, la convierta para ejecutarla:

1. **Análisis en proceso (por defecto)**: el core incluye el analizador del transpilador
   (`tools/transpiler`), construye el **grafo de basic blocks** y lo ejecuta con el motor rápido
   (hoy el **ejecutor pre-decodificado** `FastCpu` alimenta `retro_run` vía `nes_engine`; el grafo
   se enganchará como camino HLE).
2. **Wasm/nativo (opcional)**: como RetroArch, el core puede compilarse a **wasm** con Emscripten
   (`emcc -sUSE_SDL=2` no aplica; es un core: `emcc -shared ...`), de modo que "transpilar" y
   ejecutar ocurran en el navegador con el mismo código.
3. **Fase offline**: para el flujo Amiga/SDL se sigue usando el **transpilador a C++** y el
   toolchain; el core no necesita generar C++ en runtime.

> El camino HLE/transpilado en el core se activará vía `services`/capacidades (igual que en Amiga).

## Motor codegen (core específico por ROM)

El motor `codegen` ejecuta el C++ **transpilado** de una ROM (más rápido en CPU, ver
[`../docs/FAST_EXECUTOR.md`](../docs/FAST_EXECUTOR.md)). C++ no se compila en tiempo de ejecución, así
que el core debe **enlazarse** con el transpilado de esa ROM: se genera un core específico.

```bash
# Genera build/nes_libretro_codegen.so a partir de una ROM NROM
bash build-codegen-core.sh <rom.nes>          # o: make codegen ROM=<rom.nes>
```

`gen_engine_example.cpp` incluye el `gen_rom.cpp` generado y exporta `n2a_codegen_init` /
`n2a_codegen_step`; `libretro_core.cpp` los referencia como **símbolos débiles**: el core genérico no
los tiene y cae a `fast`. Si un bloque no está decodificado (salto calculado), devuelve 0 y el runtime
resuelve esa instrucción con el intérprete (equivalencia). Probado en el orquestador con Donkey Kong
(`motor de CPU = codegen`, determinismo OK).

## Build

```bash
# Linux/WSL (genera build/nes_libretro.so)
make
# Core codegen para una ROM:
make codegen ROM=../../roms/nes/'Donkey Kong (World) (Rev A).nes'
# Windows/MinGW
make CXX=g++ TARGET=build/nes_libretro.dll
```

Cargar en **RetroArch**: *Load Core → Load Core* y seleccionar `nes_libretro.so`, luego *Load
Content* con la ROM `.nes` (o copiar el `.so` a la carpeta de cores).

Validación rápida con el **orquestador** (`tools/orchestrator/vertical_slice`), que usa el mismo
contrato libretro:

```bash
./vertical_slice --core .../retroarch/build/nes_libretro.so \
    --rom ../../../roms/nes/'Donkey Kong (World) (Rev A).nes' --out /tmp/rr_nes --frames 30
```

## Estado

- **HECHO**: core que compila, se carga en el orquestador, ejecuta frames con determinismo y genera
  screenshot; plugins de vídeo/audio por **Core Options V2** (con fallback V1); **perfil por ROM** en
  varias ubicaciones (`<rom>.n2a`, `<dir>/packs/…`, `<system_dir>/nes_packs/<crc>.n2a`); opciones
  **`nes_use_pack`**, **`nes_analyze`** y **`nes_engine`**; **análisis/transpilación al cargar**
  (grafo de bloques); **motor seleccionable** `nes_engine = auto | fast | interpreter | codegen`
  (ejecutor rápido y, con un core específico, **código transpilado**); savestates; RAM expuesta.
- **PENDIENTE**: ampliar cobertura del codegen (opcodes ilegales, depurar SMB), cesión por instrucción
  para NMI exacta, *drag & drop* de ROM, build wasm del core; cores hermanos (ver
  [`ADDING_A_CORE.md`](ADDING_A_CORE.md)).
