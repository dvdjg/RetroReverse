# Estudio de compresión NES→Amiga — método, resultados y decisión

Documento de referencia del proyecto **B** ([`../README.md`](../README.md)). Recoge **qué se probó,
cómo, con qué resultados y por qué** se eligió el formato de compresión de los archivos
transpilados para Amiga. Los datos crudos están en
[`../results/bench_3roms.csv`](../results/bench_3roms.csv) y las tablas completas en
[`../results/RATIOS.md`](../results/RATIOS.md).

## 1. Objetivo

Elegir el **códec** (algoritmo de compresión) y el **pre-procesado opcional** (filtro reversible)
para cada tipo de dato del artefacto que se ejecutará en un **Amiga 500 (68000 @7 MHz)**. El Amiga
debe descomprimir en el arranque: el decruncher ha de ser **pequeño y rápido**, así que no vale
7‑zip/Deflate máximo por defecto.

Preguntas a responder:

1. ¿Qué algoritmo comprime más por tipo de dato (código 68000, datos, PRG/CHR de NES)?
2. ¿Ayuda aplicar un filtro reversible antes de comprimir (delta, evenodd, bitplanes…)?
3. ¿Merece la pena mantener varios códecs/rutas o basta con uno?

## 2. Corpus

Se genera desde el pipeline de conversión (las ROMs no se versionan; ver
[`scripts/gen_corpus.sh`](../scripts/gen_corpus.sh) y
[`scripts/gen_corpus_m68k.ps1`](../scripts/gen_corpus_m68k.ps1)).

**3 ROMs**: Donkey Kong (`dk`), Super Mario Bros (`smb`), Galaga (`galaga`).

| tipo | qué es | dk | smb | galaga |
|---|---|---:|---:|---:|
| `nes_prg` | PRG‑ROM 6502 + datos | 16 384 | 32 768 | 32 768 |
| `nes_chr` | CHR‑ROM (tiles 2bpp) | 8 192 | 8 192 | 8 192 |
| `m68k_text` | `.text` del transpilado a `-m68000` | 235 906 | 49 360 | 43 882 |
| `m68k_data` | `.rodata`+`.data` del mismo | 28 376 | 51 290 | 51 292 |

El código 68000 se obtiene **compilando el C++ que emite el transpilador** con el cross **GCC
15.1.0** (`-std=gnu++23 -O2 -m68000 -ffreestanding`, con el shim de `eng/core` de
`tools/m68k/shim`) y enlazándolo con `-Wl,--unresolved-symbols=ignore-all -Wl,-Ttext=0x10000` para
que las **relocaciones internas** (inicialización de la tabla de despacho) apunten a direcciones
reales y no a ceros. Extracción de secciones con `m68k-amiga-elf-objcopy`.

## 3. Método

Se evalúa el producto cartesiano **9 filtros × 10 códecs** sobre cada tipo de segmento, con la media
de las 3 ROMs. Métrica: `ratio = comprimido / original` (menor = mejor).

### Filtros reversibles probados

| id | filtro | qué hace |
|---|---|---|
| 0 | `none` | sin filtrar |
| 1 | `d8` | delta byte: `out[i]=in[i]-in[i-1]` |
| 2 | `d16` | delta por palabra big-endian (ideal 68000) |
| 3 | `x8` | XOR con el byte anterior |
| 4 | `eo` | separación par/impar (parity split) |
| 5 | `d16eo` | `d16` + `eo` |
| 6 | `d8eo` | `d8` + `eo` |
| 7 | `t16` | transpose por bloques de 16 B (tiles CHR) |
| 8 | `t16d` | delta contra el bloque de 16 B anterior |

### Códecs y ajustes

| códec | versión / herramienta | ajuste usado |
|---|---|---|
| `zx0` | ZX0 v2.2 (Einar Saukas) | óptimo por defecto (offset máx 32640) |
| `aplib` | apultra v1.4.8 (Emmanuel Marty) | óptimo por defecto |
| `lzsa1` | LZSA v1.4.1 | `-f 1` |
| `lzsa2` | LZSA v1.4.1 | `-f 2` |
| `deflate` | zopfli | `--deflate --i5` (offline; el A500 descomprime con inflate pequeño) |
| `lz4` | lz4 v1.10.0 | `-12` |
| `shrinkler` | Shrinkler (Blueberry) | `-d -3` (modo datos) |
| `rnc1` / `rnc2` | RNC ProPackED v1.8 | `-m=1` / `-m=2` |
| `pp` | PowerPacker 36.10 | `-c -e=5` |

Ejecución en **WSL Ubuntu**, gcc/g++ 15.2, en paralelo, con timeout por compresión. Reproducción:

```bash
scripts/fetch_build_codecs.sh          # descarga+compila los códecs en external/ (no versionado)
scripts/gen_corpus.sh                  # PRG/CHR desde .nes
powershell -File scripts/gen_corpus_m68k.ps1   # código/datos 68000 desde los .cpp transpilados
python3 scripts/bench_3roms.py         # escribe results/RATIOS.md y el CSV
```

### Limitaciones

- Solo 3 ROMs y un tipo de código 68000 (el que emite el transpilador, aún sin el engine real).
- `deflate` medido con zopfli a 5 iteraciones (el óptimo del A500 no cambia; el ratio sí mejora algo
  con más iteraciones).
- `rnc1`/`rnc2`: el **`.exe` decompilado no es reentrante** en ejecución paralela; se descartan con
  una medición puntual (ver §5).
- Velocidad real de descompresión en **A500 no medida** todavía (pendiente: emulador/hardware); el
  estudio usa ratio + conocimiento del tamaño/velocidad de cada decruncher.

## 4. Resultados

### 4.1. Mejor ratio por códec y tipo (filtro `none`)

| tipo | zx0 | aplib | lzsa1 | lzsa2 | deflate | lz4 | shrinkler | pp |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `nes_prg` | 62.1 | 62.5 | 70.7 | 65.3 | 62.0 | 74.6 | **60.2** | 67.9 |
| `nes_chr` | 54.0 | 53.9 | 61.9 | 56.4 | 51.9 | 67.3 | **50.7** | 57.9 |
| `m68k_text` | 23.4 | 23.2 | 28.3 | 24.3 | 24.1 | 31.3 | **20.3** | 30.5 |
| `m68k_data` | 38.2 | 38.5 | 43.5 | 40.2 | 38.2 | 46.0 | **37.1** | 43.9 |

### 4.2. Efecto de los filtros (con ZX0 y con Shrinkler)

| tipo | zx0 `none` | zx0 mejor filtro | shrinkler `none` | shrinkler mejor filtro |
|---|---:|---|---:|---|
| `nes_prg` | **62.1** | eo 68.6 · d8 72.7 · t16 81.8 | **60.2** | eo 65.7 |
| `nes_chr` | **54.0** | x8 59.5 · t16 62.1 | **50.7** | x8 54.6 |
| `m68k_text` | **23.4** | eo 27.2 · d8 30.8 | **20.3** | eo 25.5 |
| `m68k_data` | **38.2** | eo 42.3 | **37.1** | eo 40.2 |

**Conclusión: `none` gana en los 4 tipos y para todos los códecs.** Ningún filtro mejora el ratio;
`evenodd` es el único cercano y aun así queda por detrás. La tabla completa (9 filtros × 10 códecs ×
4 tipos) está en [`../results/RATIOS.md`](../results/RATIOS.md); la batería amplia (5 tipos, 9
filtros, 10 códecs) en [`../results/bench_summary_wide.md`](../results/bench_summary_wide.md).

## 5. Análisis

- **Los filtros clásicos no ayudan con LZ moderno.** Delta/parity/bitplanes se diseñaron para
  códecs sencillos (RLE, LZ viejos). ZX0/aPLib/Shrinkler ya explotan la redundancia de orden
  superior, y el filtro destruye parte de la localidad que esos match-finders aprovechan. Resultado:
  el filtro encarece, no abarata.
- **Shrinkler comprime más en todo** (range coder + LZ), pero su decruncher es más grande y lento;
  en un A500 eso pesa más que el ~2–4 % de mejora en ROMs o el ~15 % en código.
- **ZX0 ≈ aPLib** y son la mejor opción entre decrunchers pequeños y rápidos. `unzx0_68000` ocupa
  **88 bytes**.
- **Deflate** solo gana ligeramente en CHR/PRG (2–4 %) y su decruncher es mayor y más lento.
- **RNC**: en la muestra medida (galaga `.text`) RNC1 = 28.6 % y RNC2 = 33.2 %, **peores** que
  ZX0 (26.0 %); además el `.exe` decompilado no es reentrante. Descartado.
- **PowerPacker** da resultados anómalos con filtros en PRG (51–55 %) no fiables. Descartado.

## 6. Decisión

**Formato con ZX0 como único códec**, filtro `none`, con `store` de respaldo. Registrado en
[ADR 0006](../../../../../docs/adr/0006-compresion-zx0.md). Resumen del porqué:

| criterio | ZX0 |
|---|---|
| ratio | el mejor entre los de decruncher pequeño; a ≤15 % de Shrinkler |
| velocidad A500 | decruncher de 88 bytes, muy rápido |
| simplicidad | **un** decruncher ASM 68k, **una** ruta que validar |
| licencia | BSD‑3 (limpia para vendorizar) |

**Formato `RRPK`**: cabecera con **tabla de segmentos**, cada uno con `codec`, `filter`, `type`,
`orig_size`, `comp_size`, `offset`, `dest_hint`, `align` y `orig_crc32`. La v1 usa `codec ∈
{store, zx0}` y `filter = none`, pero **el campo `codec` se mantiene** para poder activar Shrinkler
(o cualquier otro) por segmento en el futuro sin rediseñar. Especificación completa y diagrama:
[`../../packer/docs/FORMAT.md`](../../packer/docs/FORMAT.md).

Por qué el contenedor es **por segmentos** y no un único blob: el artefacto final mezcla **código**
(que quiere decruncher rápido) y **datos/ROM** (donde el ratio pesa más); y permite evolucionar el
códec de un rango sin tocar los demás (por eso `code`, `data`, `prg`, `chr` van etiquetados).
