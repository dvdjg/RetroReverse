# reimpl/sine_wobble — efecto de distorsión/ondas (SINE)

Recreación en C++ del **efecto de distorsión por scanlines** de «Arte»: 8 osciladores de fase
que, sumados, desplazan cada fila de la imagen (ripple/wobble).

## Origen (ingeniería inversa)

- Bloque `out/modules_all/blk_096A28_3260.bin` (efecto que carga `SINE.soslibrary`).
- Rutinas:
  - **0x150-0x2B0**: init (OpenLibrary "SINE", AllocMem, SetInt, SetCopperAdr/Col).
  - **0x400-0x478**: construcción de la tabla de distorsión (`or.l` + `lsl.l #$4`).
  - **0x702-0x764**: parcheo de la copperlist (42 filas × 11 registros, máscara `$FE`).
  - **0x766-0x82E**: bucle por frame — **8 osciladores** en `$38(a5)` con velocidades
    `+10, +4, +0x48, +0x52, +6, +9, +5, +4`.
- Desensamblado canónico: `reference/sine_wobble_amiga.asm` (preservado).

## Técnica

- 8 acumuladores de fase (enteros), cada uno avanzado por su velocidad por frame.
- `offset(row) = Σ sin(phase[i] + row·spread·(i+1))` → desplazamiento horizontal por fila.
- El original aplica el offset parcheando la **copperlist** (por banda), no moviendo píxeles.

## Contenido

| Fichero | Descripción |
|---|---|
| `src/sine_wobble.hpp` | API: `kWobbleSin[256]`, `Wobble` (8 osciladores), `distort_rows` |
| `src/sine_wobble.cpp` | Tabla Q15 + implementación de referencia |
| `src/test_sine_wobble.cpp` | Test host: tabla, velocidades, avance, distorsión |
| `reference/sine_wobble_amiga.asm` | **Rutina asm canónica** preservada |
| `Makefile` | `make test` |

## Coste

Por frame: 8 incrementos + `h` consultas a tabla (8 cada fila) ≈ muy barato. La distorsión
original (parcheo de copperlist) es O(filas), sin tocar píxeles.

## Reproducir / validar

```sh
make test
```