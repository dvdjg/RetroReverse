# reimplementation/reference/sine_table — tabla de seno precalculada (Q1.14)

Recreación en C++ de una técnica básica del demo: **precalcular el seno** en una tabla y
consultarlo con aritmética entera, evitando `sin()`/punto flotante en el bucle de frame.

Origen: el demo trae `SINE.soslibrary` (librería de senos de SOS). No se copia código; se
reimplementa la idea.

## Contenido

| Fichero | Descripción |
|---|---|
| `src/sine_table.hpp` | API: `sin_q14(phase)`, `cos_q14(phase)` con fase entera 0..65535 |
| `src/sine_table_data.hpp` | Tabla generada (1024 × `int16`, amplitud 16384 = Q1.14) |
| `src/gen_sine.cpp` | Generador host que emite `sine_table_data.hpp` (reproducible) |
| `src/test_sine.cpp` | Test host: verifica muestras conocidas y monotonía |
| `Makefile` | `make test` y `make regen` |

## Uso

```cpp
#include "sine_table.hpp"
unsigned phase = 0;            // fase 0..65535 (16 bits)
int s = rein::sin_q14(phase);  // valor en [-16384, 16384]
phase += 137;                  // avanza el ángulo por frame (wrap natural a 16 bits)
```

## Por qué así (criterio 68000)

- Sin punto flotante ni divisiones en runtime: solo un desplazamiento y un índice.
- La fase de 16 bits envuelve naturalmente (`uint16_t`), sin `%`.
- `cos` es un índice desplazado 1/4 de tabla: coste O(1) idéntico a `sin`.
- Tabla de 1024 × 2 B = 2 KB (cabe en Chip RAM y se consulta desde la CPU sin penalización).

## Coste

Por consulta: 1 shift + 1 máscara + 1 load (≈ 8-12 ciclos en 68000 a 7 MHz).
Frente a `sin()` software (cientos de ciclos): ideal para mover N objetos por frame.

## Reproducir / validar

```sh
make test    # compila y ejecuta el test host (g++)
make regen   # regenera src/sine_table_data.hpp con gen_sine.cpp
```
