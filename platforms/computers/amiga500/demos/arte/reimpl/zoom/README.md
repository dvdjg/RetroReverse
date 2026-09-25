# reimpl/zoom — efecto de zoom/créditos (0x07E42C)

Recreación en C++ del **núcleo algorítmico** del efecto de zoom de «Arte» (Sanity, 1993),
recuperado del módulo `0x07E42C` (`out/modules_all/blk_07E42C_l1_20268.bin`). Combina el
desensamblado canónico con el **decompilado de Ghidra**
(`out/ghidra/blk_07E42C_l1_20268.decomp.c`).

## La técnica (máquina de estados por frame)

- **Zoom** (`FUN_0000024c`, `0x24C`): una tabla de factores de escala se recorre con un índice
  `$02D0` que avanza **+6 por frame** hasta `$B4`; `$02D2` (0 o `$B4`) elige la mitad de la
  tabla. El centro de escala es `scale = Q16(tabla[$3EE2 + base + idx] * 0xDC) + 0x11D`. Cada
  frame se dibujan **4 bloques** de 16 filas (rutina `FUN_0000193e` + blitter).
- **Trayectoria** (`FUN_000002d4`, `0x2D4`): tres tablas (`$3944`, `$38AA`, `$3A78`) dan la
  posición del objeto con multiplicaciones **Q16** (`muls.w #C ; swap`) y sesgos; `$238` avanza
  +2 (hasta `$9A`) y `$23a` avanza +6 (hasta `$1CE`).
- **Bandas de Copper** (dentro de `FUN_000002d4`): a partir de la posición se calculan dos
  límites `a`,`b` y se parchea la copperlist cambiando **`BPLCON0` por bandas** (`0x200` →
  `0x5200` → `0x200`) para el recorte vertical del zoom (5 planos en la banda central). Es un
  detalle que **no estaba documentado** antes del decompilado.

La aritmética Q16 es la de toda la demo: `producto = (v * C) >> 16` (`muls.w` + `swap`).

## Contenido

| Fichero | Descripción |
|---|---|
| `src/zoom.hpp` | API: `q16_mul`, `rd_be16`, `ZoomState`/`zoom_step`, `TrajState`/`traj_step`, `copper_bands` |
| `src/zoom.cpp` | Implementación fiel a las constantes del original |
| `src/test_zoom.cpp` | Test host: Q16, avance/​reinicio del zoom, trayectoria, wrap y bandas |
| `Makefile` | `make test` |

## Alcance y límite

- **Portado**: la **lógica** de zoom (factores, avance, reinicio), la **trayectoria** (tablas y
  sesgos) y el **cálculo de bandas** de `BPLCON0`.
- **NO portado**: el **blit/escalado por hardware** (`FUN_0000193e` y el blitter) y la
  **escritura real** de la copperlist. Se expone el cálculo de las bandas para que el engine lo
  aplique con su propia capa de vídeo.
- Las **tablas** (`$3EE2`, `$3944`, `$38AA`, `$3A78`) viven en el módulo y se pasan como punteros
  `const u8*` (shorts **big-endian** en offsets de byte, como en el asm). El test usa tablas
  sintéticas; para el engine, extraerlas del módulo con `DumpRange`/`XrefsTo` de Ghidra.

## Reproducir / validar

```sh
make test    # g++ (host)
```

## Confianza

Lógica y constantes: **alta** (decompilado + asm coincidentes). Tablas concretas y geometría del
blit: **pendiente** (no portadas).
