# reimpl/motor_3d — motor de transformación 3D (Q15)

Recreación en C++ de la técnica del **motor 3D** de «Arte» (Sanity, 1993): rotación y
transformación de puntos en **aritmética de coma fija Q15**, sin punto flotante.

Es la rutina que el propio autor mencionaba en el scrolltext como *"die am meisten optimierte
routine"* (la rutina más optimizada). **Se conserva la versión asm canónica** como referencia.

## Origen (ingeniería inversa)

- Bloque `out/modules_all/blk_0B0C2C_63064.bin` (descomprimido del ADF 0x0B0C2C).
- Rutinas:
  - **0x0C16-0x0CB8**: construcción de la matriz de rotación `R = Rx(a)·Ry(b)·Rz(c)`, con los
    senos/cosenos de la tabla (SINE.soslibrary) y Q15 (`muls.w` + `add.l d,d` + `swap`).
  - **0x0CBA-0x0D58**: transformación de un punto `p` por la matriz (`R·p`), suma de 3 productos
    en 32 bits y un solo `>>15`.
- Desensamblado canónico: `reference/transform3d_q15_amiga.asm` (preservado).

## Convención de la matriz (column-major, como el demo)

```
m[0]=R00 m[1]=R10 m[2]=R20   (columna 0)
m[3]=R01 m[4]=R11 m[5]=R21   (columna 1)
m[6]=R02 m[7]=R12 m[8]=R22   (columna 2)
```
Transformación: `X' = m[0]*x + m[3]*y + m[6]*z`  (etc.).

## Contenido

| Fichero | Descripción |
|---|---|
| `src/transform3d.hpp` | API: `q15_mul`, `Mat3`, `build_rotation`, `transform` |
| `src/transform3d.cpp` | Implementación de referencia (fiel a las 9 fórmulas del asm) |
| `src/test_transform3d.cpp` | Test host: Q15, identidad, det(R)=1, longitud, ortonormalización |
| `reference/transform3d_q15_amiga.asm` | **ASM canónico**: matriz + transform |
| `reference/orthonormalize_amiga.asm` | **ASM canónico**: ortonormalización (`0x0E1E` + raíz `0x0F1C`) |
| `Makefile` | `make test` |

## Contrato

- **Punto fijo**: Q15 → `producto = (a*b)>>15` (`muls.w` + `add.l d,d` + `swap`).
- **`build_rotation(a0, a1)`**: `a1`=senos/cosenos (6 words); `a0`=matriz salida (9 words).
- **`transform(a0, a1, a2)`**: `a0`=puntos (3 words/punto), `a1`=matriz, `a2`=salida; **3 puntos/llamada**.
- **`orthonormalize(a0, a1)`**: `a0`=matriz (se modifica in situ), `a1`=salida; preserva `d2-d7/a2`.
  Detalle de registros y coste en `reference/orthonormalize_amiga.asm`.
- Convención y uso en el engine: [`../../../PORTING.md`](../../../../../../../PORTING.md).

## Por qué así (criterio 68000)

- **Sin punto flotante ni divisiones** en runtime: cada producto = `muls.w` (32-bit) + `>>15`.
- La matriz se compone de **6 valores** (3 sin + 3 cos) consultados en tabla; coste O(1).
- Un punto se transforma con **9 `muls.w`** (~90-120 ciclos en 68000 a 7 MHz), ideal para
  rotar muchos vértices/estrellas por frame.
- El `>>15` único al final (tras sumar los 3 productos) mantiene la precisión.

## Reproducir / validar

```sh
make test    # compila y ejecuta el test host (g++)
```

## Nota sobre el port

La versión C++ (`transform3d.cpp`) es **de referencia**: reproduce la misma semántica Q15 y la
misma convención de matriz. Para las partes donde el rendimiento en 68000 sea crítico, la
**versión canónica a usar es la asm** (`reference/transform3d_q15_amiga.asm`), que se puede
incluir tal cual (o como inline asm) en la reconstrucción.

## Validación con el decompilador

- El **decompilado de Ghidra** de `0xC16` (matriz) y `0xCBA` (transform) coincide **término a
  término** con `build_rotation()`/`transform()` (ver `../../docs/GHIDRA_DECOMP_VS_REIMPL.md` §3.1).
  Confianza alta.
- **Ortonormalización** (`0x0E1E` + raíz `0xF1C`): **portada** (`orthonormalize()` + `isqrt32()`,
  test OK) y su **ASM canónico** extraído a `reference/orthonormalize_amiga.asm`. Técnica en
  `../../docs/TECNICAS.md` → «Construcción de matriz ortonormal».