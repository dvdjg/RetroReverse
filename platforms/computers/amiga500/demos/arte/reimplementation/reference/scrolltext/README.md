# reimplementation/reference/scrolltext — scrolltext con fuente de 3 planos

Recreación en C++ del **scrolltext** de «Arte»: fuente bitmap de 3 planos, mapa de caracteres,
render a bitplanes y desplazamiento horizontal por frame.

## Origen (ingeniería inversa)

- Bloque `extraction/modules_all/blk_02162C_45924.bin`.
- Rutina **0x196E-0x1A70** (render): busca el char en el mapa (`0x1A80`, 43 símbolos),
  localiza su glifo (~`0x2800`), copia 8 filas × 3 planos a los bitplanes en `$60000`
  (stride `0x5000`); el scroll avanza un offset por carácter.
- Desensamblado: `reference/scrolltext_amiga.asm`. Texto real: `assets/text/`.

## Técnica

1. **Mapa de chars** (43): `" abcdefghijklmnopqrstuvwxyz0123456789.,!?:-"`.
2. **Glifo**: 8 filas × 1 byte × 3 planos.
3. **Render**: por carácter, copiar las 8 filas a los 3 bitplanes; avanzar el `pen` 8 px.
4. **Scroll**: `pen = x0 - scroll_px` (desplazamiento horizontal).

## Contenido

| Fichero | Descripción |
|---|---|
| `src/scrolltext.hpp` | API: `Font`, `PlanarFb`, `render_text`, `make_default_font` |
| `src/scrolltext.cpp` | Implementación de referencia |
| `src/test_scrolltext.cpp` | Test host: mapa, glifos, render, scroll |
| `reference/scrolltext_amiga.asm` | **Rutina asm** preservada |
| `Makefile` | `make test` |

## Reproducir / validar

```sh
make test
```

## Nota

El mapa de 43 caracteres es el **real** del demo (extraído). Los glifos del reimpl son
sintéticos (marcos); la fuente real está en el módulo `0x02162C` (~`0x2800`), pendiente de un
decodificador fiel del layout exacto.