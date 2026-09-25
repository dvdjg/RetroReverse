# reimplementation/reference/blob_render — motor de blobs/sprites planares

Recreación en C++ del **motor de dibujo de blobs/sprites** de «Arte»: dibuja sprites planares a
3 bitplanes usando una **tabla de lookup de expansión de bits** (evita iterar píxel a píxel).

## Origen (ingeniería inversa)

- Bloque `extraction/modules_all/blk_0B0C2C_63064.bin`.
- Rutinas:
  - **0x3318-0x3360**: construye la LUT de expansión en `$318dc` (RAM) a partir de dos tablas
    auxiliares (`0x336E` máscaras de N bits, `0x338E` patrones con bits altos).
  - **0x34A0-0x3560**: render — por cada byte del sprite hace 2 lookups (píxel + máscara) y
    escribe a 3 bitplanes (`a3/a4/a1`, separados `0x20`), con dispatch por ancho.
- Desensamblado canónico: `reference/blob_render_amiga.asm` (preservado).

## Técnica

1. **LUT de expansión**: precalcular la expansión de bits (nibble → patrón de 8 bits; el
   original además duplica bits para escalado 2x). Coste: 1 lookup por byte.
2. **Render con máscara**: por cada byte, borrar el fondo donde la máscara es 1 y escribir el
   patrón del sprite (`dest = (dest & ~mask) | (sprite & mask)`).

## Contenido

| Fichero | Descripción |
|---|---|
| `src/blob_render.hpp` | API: `expand4`, `ExpandLut`, `PlanarBuffer`, `draw_planar_sprite` |
| `src/blob_render.cpp` | Implementación de referencia |
| `src/test_blob_render.cpp` | Test host: expansión, LUT, dibujo planar con/sin máscara |
| `reference/blob_render_amiga.asm` | **Rutina asm canónica** (optimizada) preservada |
| `Makefile` | `make test` |

## Por qué así (criterio 68000)

- El truco "byte → LUT → patrón" evita procesar bit a bit: ~8× más rápido.
- Sin divisiones ni bucles por píxel; ~2 lookups + 3 writes por byte de blob.

## Reproducir / validar

```sh
make test
```

## Nota sobre el port

La implementación C++ es **de referencia** (dibujo planar equivalente). Para las partes críticas
en 68000, la **versión canónica a usar es la asm** (`reference/blob_render_amiga.asm`), con la
LUT de expansión precalculada.