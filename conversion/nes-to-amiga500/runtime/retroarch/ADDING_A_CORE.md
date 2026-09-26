# Añadir un core (otra consola) a RetroArch

Objetivo: que RetroArch pueda seleccionar **cualquiera de nuestros emuladores** (hoy NES; después
Megadrive, GB, …). Cada consola es **un core libretro** que reutiliza la misma estructura: la
interfaz `Host`, el sistema de **perfiles por ROM**, los **plugins** y el esqueleto de core.

## Qué se reutiliza tal cual

| Pieza | Fichero | Notas |
|---|---|---|
| Interfaz de plataforma | [`../platform/host.hpp`](../platform/host.hpp) | común a SDL3/Amiga |
| Perfil por ROM | [`../enhance/rom_profile.hpp`](../enhance/rom_profile.hpp), [`profile_io.hpp`](../enhance/profile_io.hpp), [`pack_provider.hpp`](../enhance/pack_provider.hpp) | identifica por CRC y aplica packs |
| Plugins vídeo/audio | [`plugins.hpp`](plugins.hpp) | interfaz genérica; cada consola aporta los suyos |
| Esqueleto de core | [`libretro_core.cpp`](libretro_core.cpp) | copiar y cambiar `retro_get_system_info`/`av_info` y el "sistema" |

## Qué hay que aportar por consola

1. **Núcleo del sistema** (equivalente a `NesSystem`): CPU + vídeo + audio + mappers, con
   - un buffer de vídeo de **índices o RGB** y su paleta,
   - `run_frame()` (sincronía con el frame de la consola),
   - lectura de **entrada** y **savestate** POD.
   Ubicación sugerida: `runtime/include/<consola>_system.hpp` (+ `runtime/fallback/<consola>_*.hpp`).
2. **Core libretro**: copiar `libretro_core.cpp` y ajustar:
   - `retro_get_system_info` (nombre, `valid_extensions`),
   - `retro_get_system_av_info` (resolución, `fps`, `sample_rate`),
   - `retro_load_game` (parsear la ROM; opcional: análisis y perfil por CRC),
   - `retro_run` (1 frame: entrada → `run_frame()` → vídeo/audio),
   - `retro_serialize/_unserialize/_size`, `retro_get_memory_data/size`.
3. **Plugins** de vídeo/audio si aplican (mismo `VideoPlugin`/`AudioPlugin`).
4. **Perfil por ROM** (opcional): formato y carga ya están en `enhance/`; la consola puede definir
   sus propios overrides (p. ej. tiles/colores) con el mismo mecanismo.

## Convención de directorios

```
runtime/
  include/<consola>_system.hpp     núcleo de la consola
  fallback/<consola>_*.hpp         CPU/PPU/APU software de esa consola
  retroarch/                       cores libretro
    libretro_core.cpp              (NES; plantilla)
    <consola>_libretro.cpp         nuevo core
    Makefile                       añadir un objetivo por core
  platforms/                       (opcional) capa Amiga/SDL por consola
```

## Core options y "por juego"

- **Core Options V2** ([`libretro_core.cpp`](libretro_core.cpp) `set_core_options`): declara las
  opciones de la consola (vídeo/audio/ROM). RetroArch las ofrece **por juego**.
- **Perfil `<rom>.n2a`** y `system_dir/nes_packs/<crc>.n2a`: ajustes sin tocar la emulación.

## Transpilador

El transpilador actual es **NES → C++**. Para una consola nueva hay dos caminos:
1. **Intérprete** (lo que hace el core NES hoy) y, opcionalmente, un **analizador** que construya el
   grafo de bloques al cargar (igual que el core NES con `nes_analyze`).
2. **Traducción específica** de su CPU (p. ej. 68000 del Megadrive) si se quiere acelerar; sería un
   `tools/transpiler-<consola>/` análogo.

## Checklist del core nuevo

- [ ] Carga ROM y arranca (log de mapper/versión).
- [ ] `retro_run` produce frame y audio.
- [ ] Savestate round-trip (mismo frame tras `serialize`/`unserialize`).
- [ ] RAM expuesta (`RETRO_MEMORY_SYSTEM_RAM`).
- [ ] Core Options V2 (vídeo/audio) + una por juego.
- [ ] Perfil por ROM (opcional) sin alterar la emulación (test).
- [ ] Validado en el orquestador (`vertical_slice --core <core.so> --rom <rom>`: determinismo OK).
- [ ] Añadido a `scripts/smoke-cores.sh`/docs de la plataforma (si procede).
