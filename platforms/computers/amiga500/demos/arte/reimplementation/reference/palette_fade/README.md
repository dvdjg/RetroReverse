# reimplementation/reference/palette_fade — fade de paleta por nibbles

Recreación en C++ del **fade de paleta** de «Arte»: interpola cada color OCS de 12 bits hacia su
objetivo, **componente a componente** (nibbles R/G/B).

## Origen (ingeniería inversa)

- Bloque `extraction/modules_all/blk_0B0C2C_63064.bin`, rutina **0x031C-0x03E2**.
- Por cada color `(a0)` frente al objetivo `(a1)`: compara nibble a nibble y suma/resta
  `+1` (B), `+0x10` (G), `+0x100` (R); controlado por un contador de frames (`$3f0`).
- Desensamblado: `reference/palette_fade_amiga.asm`.

## Técnica

- Cada paso acerca **un nivel por componente** (no interpola linealmente con float).
- Barato: solo comparaciones e incrementos enteros; sin multiplicaciones.
- Se usa entre partes del demo (fade-in/out de la paleta).

## Contenido

| Fichero | Descripción |
|---|---|
| `src/palette_fade.hpp` | API: `fade_palette_step`, `fade_palette` |
| `src/palette_fade.cpp` | Implementación de referencia |
| `src/test_palette_fade.cpp` | Test host: paso a paso, subida/bajada, componentes, multi-color |
| `reference/palette_fade_amiga.asm` | **Rutina asm** preservada |
| `Makefile` | `make test` |

## Reproducir / validar

```sh
make test
```