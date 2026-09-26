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

`plugins.hpp` define `VideoPlugin` (convierte el framebuffer de **índices NES** a XRGB8888) y
`AudioPlugin` (mono del APU → estéreo S16). Añadir un plugin = implementar la interfaz y
registrarlo en `Plugins`. Ejemplos futuros: *composite*/NTSC, *scanlines*, reescalado, HD packs
(vídeo); paso-bajo o mezclas alternativas (audio).

## Transpilador integrado

La idea es que el core **lleve el transpilador** y, al cargar la ROM, la convierta para ejecutarla:

1. **Análisis en proceso (por defecto)**: el core incluye el analizador del transpilador
   (`tools/transpiler`), construye el **grafo de basic blocks** y lo ejecuta con el motor rápido
   (hoy, `NesSystem` usa el intérprete; el grafo se enganchará como camino HLE).
2. **Wasm/nativo (opcional)**: como RetroArch, el core puede compilarse a **wasm** con Emscripten
   (`emcc -sUSE_SDL=2` no aplica; es un core: `emcc -shared ...`), de modo que "transpilar" y
   ejecutar ocurran en el navegador con el mismo código.
3. **Fase offline**: para el flujo Amiga/SDL se sigue usando el **transpilador a C++** y el
   toolchain; el core no necesita generar C++ en runtime.

> El camino HLE/transpilado en el core se activará vía `services`/capacidades (igual que en Amiga).

## Build

```bash
# Linux/WSL (genera build/nes_libretro.so)
make
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
  screenshot; plugins de vídeo/audio por core options; savestates; RAM expuesta.
- **PENDIENTE**: enganchar el camino transpilado/HLE; core options V2 con etiquetas/idiomas;
  *drag & drop* de ROM en RetroArch; build wasm del core; cores hermanos (Megadrive, …).
