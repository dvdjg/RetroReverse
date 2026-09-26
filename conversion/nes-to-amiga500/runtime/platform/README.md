# runtime/platform — abstracción de plataforma

El mismo núcleo (`NesSystem`: CPU + PPU + APU + mappers, en `runtime/include/`) corre sobre
**Amiga 500** o sobre **SDL3** (PC y navegador) gracias a una única interfaz: [`Host`](host.hpp).

```
        ┌───────────────────────────────────────────────┐
        │  Núcleo (plataforma-agnóstico, sin STL)        │
        │  CPU · PPU · APU · mappers · HLE · VSA         │
        └───────────────────────┬───────────────────────┘
                                │ Host (host.hpp)
                 ┌──────────────┴──────────────┐
                 ▼                              ▼
        ┌──────────────────┐          ┌──────────────────────┐
        │ SDL3 (PC/web)    │          │ Amiga 500            │
        │ sdl_host.hpp/.cpp│          │ amiga/ (Copper/…)     │
        └──────────────────┘          └──────────────────────┘
```

## Contrato `Host`

Vídeo (`present`), audio (`audio_write`), entrada (`poll` → `InputState`), tiempo (`delay_ms`,
`ticks_ms`) e inicialización. Lo implementa un backend por plataforma; el runner
([`../host/main.cpp`](../host/main.cpp)) solo usa la interfaz.

## Backend SDL3

Archivos: [`sdl_host.hpp`](sdl_host.hpp) + [`../host/sdl_host.cpp`](../host/sdl_host.cpp).
Ventana + textura `RGB24`, stream de audio mono S16, teclado mapeado al mando NES
(Z/Espacio=A, X=B, Enter=Start, RShift=Select, flechas, Esc=salir).

- **SDL3** está en `external/SDL3/` (ignorado por git): `devel/…-mingw/` (PC/Windows) y
  `SDL-release-3.4.16/` (fuentes). Versión: **3.4.16**.
- **PC (Windows/MinGW)**: `runtime/host/build-pc.ps1` → `runtime/host/build/nes_sdl.exe`.
- **PC (Linux/macOS)**: `cmake -S runtime/host -B build && cmake --build build`
  (con SDL3 instalado; `-DAMIGA_CPP=...` para `eng/core`).
- **Navegador (Emscripten)**: `bash runtime/web/build_web.sh` → `nes_sdl.html`
  (SDL3 como *port* `-sUSE_SDL=3`; requiere emsdk).

Ejecución PC: `nes_sdl <rom.nes> [frames]` (sin `frames` = bucle hasta cerrar).

## Backend Amiga

Ver [`amiga/README.md`](amiga/README.md): mapea `present` a **bitplanes + Copper/Blitter**, audio a
**Paula** y `poll` a **joystick/teclado**, con sincronía por **VBlank**.

## Estado

- **HECHO**: interfaz `Host`; backend **SDL3** (PC y navegador); runner; build MinGW + CMake; SDL3
  descargado. Probado en headless (`SDL_VIDEODRIVER=dummy`) 120 frames sin errores.
- **PENDIENTE**: backend **Amiga** (Copper/Blitter/Paula) y *drag & drop* de ROM en la página web.

## Próximos pasos

1. Backend Amiga real (bitplanes/Copper/Paula) sobre esta misma interfaz.
2. Empaquetar la ROM en el build web (Emscripten `--preload-file`) o cargarla por `File`.
3. Sustituir el intérprete (`NesSystem`) por los **bloques transpilados** en el runner.
