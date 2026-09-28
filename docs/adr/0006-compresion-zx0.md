# ADR 0006 — Compresión de los archivos transpilados para Amiga: ZX0 único

- **Estado**: aceptado
- **Fecha**: 2026
- **Relacionado**: [ADR 0005](0005-pilar-conversion-plataformas.md),
  [`conversion/nes-to-amiga500/tools/packer/`](../../conversion/nes-to-amiga500/tools/packer/README.md),
  [`conversion/nes-to-amiga500/tools/codec-bench/`](../../conversion/nes-to-amiga500/tools/codec-bench/README.md)

## Contexto

Los archivos transpilados para Amiga (plugins/rangos de código 68000 + PRG/CHR de la ROM origen) hay
que **comprimirlos** porque el A500 tiene poca RAM/disco, pero **no** podemos usar 7‑zip/Deflate
máximo: el Amiga 500 (68000 @7 MHz) debe **descomprimir en el arranque**, y su decruncher debe ser
pequeño y rápido.

Se midió una batería (proyecto **B**, 3 ROMs × 10 códecs × 9 filtros reversibles) sobre los tipos de
segmento reales. Estudio completo (método, tablas, análisis):
[`codec-bench/docs/STUDY.md`](../../conversion/nes-to-amiga500/tools/codec-bench/docs/STUDY.md);
tablas crudas: [`codec-bench/results/RATIOS.md`](../../conversion/nes-to-amiga500/tools/codec-bench/results/RATIOS.md).
Resumen de ratio (comprimido/original, menor = mejor, filtro `none`):

| tipo | zx0 | aplib | deflate | shrinkler |
|---|---:|---:|---:|---:|
| `m68k_text` (código 68000) | 23.4 | 23.2 | 24.1 | **20.3** |
| `m68k_data` (.rodata) | 38.2 | 38.5 | 38.2 | **37.1** |
| `nes_prg` (ROM 6502+datos) | 62.1 | 62.5 | **62.0** | **60.2** |
| `nes_chr` (tiles) | 54.0 | 53.9 | **51.9** | **50.7** |

Hallo hallazgo: **ningún filtro de pre-procesado mejora** el ratio con códecs LZ modernos (`none`
gana en los 4 tipos; `evenodd` es el único cercano y aun así peor).

## Decisión

**Oficialmente, todos los archivos transpilados para Amiga se comprimen con ZX0** (un único códec),
**sin filtro** (`none`).

- **`store` se mantiene** como códec 0: si ZX0 no reduce, se guarda sin comprimir (nunca empeora).
- El campo `codec` por segmento de la cabecera `RRPK` **se mantiene**: cambiar un rango a otro
  códec en el futuro es un flag, no un rediseño.
- **Shrinkler queda como "reserva de ratio"**, no activo: gana ~15 % en código 68000 y ~2–4 % en
  ROM, pero su decruncher es más grande y lento en A500; no compensa mantener una segunda ruta.
- **Deflate se descarta** (ventaja marginal ~2–4 % en CHR/PRG y decruncher mayor y más lento).

Códecs por segmento (v1 efectiva):

| rango | códec | filtro |
|---|---|---|
| código 68000 | `zx0` (o `store`) | `none` |
| datos / rodata | `zx0` (o `store`) | `none` |
| PRG/CHR de la ROM | `zx0` (o `store`) | `none` |

## Consecuencias

- ✅ El Amiga necesita **un solo decruncher** en ASM 68k (`unzx0_68000`, 88 bytes) → menos código,
  menos tiempo de validación.
- ✅ Licencia limpia (ZX0 es BSD‑3) y herramientas simples (un códec, un test de round-trip).
- ✅ Coste en tamaño: ~15 % más grande que Shrinkler en código, ~2–4 % en ROM. Aceptado.
- ⚠️ Si en el futuro el tiempo de carga deja de ser crítico, se puede activar Shrinkler por
  segmento sin tocar el formato (campo `codec`).
- ⚠️ El proyecto **A** ([`tools/packer`](../../conversion/nes-to-amiga500/tools/packer/README.md))
  implementa solo `zx0` + `store`; los demás códecs del banco (proyecto B) son solo de análisis.

## Alternativas consideradas

- **Deflate para CHR/PRG**: rechazado; ventaja ~2–4 % y decruncher mayor/lento.
- **Shrinkler para código**: rechazado por ahora; ~15 % mejor pero decruncher pesado en A500.
- **Per‑segmento con varios códecs**: rechazado por simplicidad; el formato lo permite si hiciera
  falta.
- **Filtros de pre-procesado (`delta`, `evenodd`, bitplanes)**: rechazados; empeoran el ratio con
  LZ moderno según la matriz de B.
