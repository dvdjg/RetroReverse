# Formato de contenedor `RRPK` v1

Contenedor comprimido por segmentos para artefactos de RetroReverse (plugins `.n2x`, código 68000,
PRG/CHR de NES…). Todos los enteros son **big-endian** (el destino es 68000).

## Objetivo

Permitir que el cargador del Amiga lea una cabecera pequeña, sepa **qué códec y filtro** usa cada
segmento, lo descomprima al destino indicado y salte al punto de entrada. Un mismo fichero puede
mezclar códecs por segmento: en la v1, `zx0` para lo comprimible y `store` para un bloque
incompresible (mismo formato, distintos ids en la tabla).

## Diseño y justificación (por qué así)

- **Por segmentos**: el artefacto mezcla **código** (quiere decruncher rápido) y **datos/ROM**
  (donde el ratio pesa más); con tabla por segmento cada rango lleva su códec y puede evolucionar
  por separado (`code`, `data`, `prg`, `chr`).
- **Cabecera pequeña y big-endian**: la lee el 68000; todo BE para no byte-swapear.
- **`codec` por segmento, extensible**: la v1 usa `store`/`zx0`, pero el campo permite activar otro
  códec (p. ej. Shrinkler) sin cambiar el formato.
- **`orig_crc32`**: permite al cargador (y al `--verify` del PC) comprobar integridad sin guardar el
  original.
- **`align`/`dest_hint`**: pensados para el mapa de memoria del A500 (alineación y carga a
  direcciones concretas).

El **porqué de elegir ZX0** (y no Deflate/Shrinkler/aPLib) y las tablas que lo respaldan están en
[`../../codec-bench/docs/STUDY.md`](../../codec-bench/docs/STUDY.md) y
[ADR 0006](../../../../../docs/adr/0006-compresion-zx0.md).

## Cabecera principal (20 bytes)

| Offset | Tam. | Campo | Descripción |
|---:|---:|---|---|
| 0  | 4 | `magic` | `"RRPK"` (`0x52 0x52 0x50 0x4B`) |
| 4  | 1 | `version` | `1` |
| 5  | 1 | `flags` | reservado (0) |
| 6  | 2 | `segment_count` | nº de entradas de la tabla |
| 8  | 4 | `total_orig_size` | suma de `orig_size` |
| 12 | 4 | `total_comp_size` | suma de `comp_size` |
| 16 | 4 | `entry_offset` | offset del punto de entrada dentro del área descomprimida (0 = inicio del segmento 0) |

## Tabla de segmentos (`segment_count` × 24 bytes)

| Offset | Tam. | Campo | Descripción |
|---:|---:|---|---|
| 0  | 4 | `offset` | offset del payload comprimido desde el inicio del fichero |
| 4  | 4 | `comp_size` | tamaño comprimido (bytes) |
| 8  | 4 | `orig_size` | tamaño original (bytes) |
| 12 | 4 | `dest_hint` | dirección/desplazamiento destino sugerido (0 = contiguo) |
| 16 | 1 | `codec` | ver enum `Codec` |
| 17 | 1 | `filter` | ver enum `Filter` |
| 18 | 1 | `type` | ver enum `SegType` |
| 19 | 1 | `align` | log2 de la alineación requerida del destino |
| 20 | 4 | `orig_crc32` | CRC32 del contenido original (integridad / verificación) |

Tras la tabla vienen los payloads comprimidos, en el mismo orden que la tabla, cada uno alineado a
4 bytes. Los segmentos se descomprimen a memoria **contigua** en el orden de la tabla (si
`dest_hint == 0`), o a `dest_hint` si el cargador lo usa.

## Enumeraciones

### `codec`

| Valor | Nombre | Ratio | Velocidad A500 | Decruncher |
|---:|---|---|---|---|
| 0 | `store` | 1.00 | — | ninguno (copia) |
| 1 | `zx0` | excelente | muy alta | muy pequeño |
| 2 | `aplib` | excelente | alta | pequeño |
| 3 | `deflate` | muy buena | buena | ~640–930 B |

Reservados para ampliación: `4 lzsa2`, `5 shrinkler`.

> **v1 efectiva (ADR 0006): solo `store` y `zx0`.** `aplib`/`deflate` se midieron en el proyecto B y
> se descartaron por ventaja marginal; `shrinkler` queda como reserva de ratio.

### `filter` (reversible, se aplica antes de comprimir; el cargador aplica el inverso)

| Valor | Nombre | Idea |
|---:|---|---|
| 0 | `none` | — |
| 1 | `delta8` | `out[i] = in[i] - in[i-1]` (byte) |
| 2 | `delta16be` | delta por palabra big-endian (ideal 68000) |
| 3 | `xor8` | `out[i] = in[i] ^ in[i-1]` |
| 4 | `evenodd` | bytes pares y luego impares (parity split) |
| 5 | `delta16be+evenodd` | composición |
| 6 | `delta8+evenodd` | composición |
| 7 | `tile16` | transpose por bloques de 16 B (CHR NES: 2 planos) |
| 8 | `tile16_delta` | delta contra el bloque de 16 B anterior |

> **v1 efectiva: solo `filter = 0 (none)`.** El banco de B mostró que ningún filtro mejora el ratio
> con ZX0; los valores 1–8 quedan **reservados** para un corpus futuro que los justifique.

### `type` (segmento)

`0 code` (código máquina 68000) · `1 data` (rodata/tablas) · `2 prg` (PRG 6502) ·
`3 chr` (tiles NES) · `4 other`.

## Algoritmo de empaquetado (proyecto A)

1. Por cada zona de entrada se prueban los códecs habilitados con filtro `none`: `zx0` y `store`.
2. Se guarda el de **menor `comp_size`** (`store` si ZX0 no reduce; así nunca empeora).
3. Se escribe cabecera + tabla + payloads (cada payload alineado a 4 bytes).
4. `--verify` descomprime, aplica el filtro inverso y compara el CRC32 con `orig_crc32`.

La **matriz de qué combinación gana por tipo de dato** se obtiene con el proyecto B y se conserva en
[`../../codec-bench/results/RATIOS.md`](../../codec-bench/results/RATIOS.md).
