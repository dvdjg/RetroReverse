# Técnicas de «Arte» y receta de reimplementación

Un apartado por efecto/técnica. Se irá rellenando a medida que el desensamblado avance.
Cada entrada debe terminar con una **receta reutilizable** (algoritmo + parámetros + coste),
no con volcado de código ajeno.

## Plantilla de entrada

```
### <Nombre del efecto>
- Evidencia: <dirección de la rutina, captura, módulo>
- Qué hace: <descripción>
- Cómo (hardware): <Copper / Blitter / BPLCON1 / sprites / Paula …>
- Algoritmo/idea: <pseudocódigo propio>
- Parámetros: <tablas, velocidades, paleta, etc.>
- Receta para el engine: <cómo portarlo>
- Coste: <ciclos/DMA/CPU por frame>
```

## Empaquetado propio de SOS (`CrM!`/`CrM2` + `IMP!`)

- Evidencia: rutinas en Slow RAM `0xC02426` (`IMP!`), `0xC02584` (trampoline `CrM!`),
  `0xC025B2` (`CrM!`), `0xC026AA` (`CrM2`); desensamblado en
  `recovered/code/sos_cruncher/sos-crunchers.asm`.
- Qué hace: descomprime bloques (módulos, gráficos, música) en runtime; el disco solo lleva datos
  comprimidos.
- Cómo: cabecera con firma ASCII + dos longs big-endian; `IMP!` descomprime **hacia atrás**
  (LZ + Huffman con tabla de 28 B) escribiendo en `[A0, A0+long(A0+4))`.
- Algoritmo/idea (para reimplementar): LZ77 con árbol Huffman dinámico + paso RLE posterior en
  `CrM!`/`CrM2`. En `IMP!` la salida ocupa el propio bloque (in-place).
- Receta para el engine: empaquetar assets con un LZ+Huffman propio en el pipeline de build y
  descomprimir a un buffer destino; no requiere el formato exacto de SOS.
- Coste: descompresión en carga (fuera del hot path por frame).

## Copperlist del título

- Evidencia: `recovered/media/copper/arte-title-copper.txt` (capturada de `COP1LC=0x26614`).
- Qué hace: instala DIW/DDF, `BPLCON0=$5600` (**5 planos**), modulos `-40`, punteros BPL/SPR,
  `DMACON`, y una paleta (`COLOR00..`).
- Nota: la captura correspondía a una lista de **blanqueo** (punteros BPL a 0) durante una
  transición; hay que recapturar con la lista activa.
- Receta para el engine: el patrón es el estándar (Copper instala modo + punteros + paleta); sirve
  como referencia de un display OCS de 5 planos.

## Display OCS de 5 planos (título) — bitplanes decodificados

- Evidencia: `mod_007` (102852 B, dest Chip `0x26614`) contiene los bitplanes del título;
  copperlist `mod_003` (también en `0x26614`) configura el display.
- Parámetros de pantalla (de la copperlist): `DIWSTRT=$5981`, `DIWSTOP=$59C1` (PAL 320×200~256),
  `DDFSTRT=$38`, `DDFSTOP=$D0`, `BPLCON0=$5600` (5 planos lowres), `BPL1MOD=$FFD8` (=-40).
  `BPL1MOD=-40` ⇒ **ancho 320 px** (40 B/línea/plano × 8 = 320 bits); módulo negativo = sin
  relleno entre líneas (bitplanes contiguos).
- Paleta `arte-title-palette.json`: fondo `#330000`, texto `#99aaaa`, rampa `#556666/#334444/
  #223333`. En la captura de referencia dominan `(51,0,0)` y `(170,170,170)` → paleta confirmada.
- Layout planar OCS: 5 planos de 40 B × 200 líneas = 200 B/línea; 102852 B ≈ 514 líneas =
  ~2.5 pantallas apiladas (el buffer se reutiliza para varios estados/efectos del título).
- Imágenes decodificadas: `recovered/media/gfx/mod7_block0_320x200.png` (título lleno, 56%
  datos), `mod7_block1_320x200.png` (28%), `block2` (8%). Bloque 0 = frame principal.
- Receta para el engine: el demo pinta en planares OCS (5 planos) y deja que el Copper parchee los
  punteros BPL1PT..BPL5PT por frame (por eso en la copia almacenada los punteros están a 0).
  Al portar: mantener el bitplane como `uint32_t[5]` por línea o pasar a RGB y reutilizar una
  textura; el módulo negativo es equivalente a un stride exacto de `ancho_bytes*planos`.
- Coste: bitplanes planares = un `memcpy` de `40×planos` por línea; sin coste de Copper por frame
  si los punteros no cambian.

## Seno precalculado (`SINE.soslibrary`)

- Evidencia: módulo `SINE.soslibrary` referenciado por SOS; el demo mueve objetos/ángulos por frame.
- Idea: tabla de seno precalculada y consulta entera (sin `sin()`/punto flotante en runtime).
- Receta para el engine (PORTADO): `reimpl/sine_table/` — tabla Q1.14 de 1024 entradas, fase de 16
  bits con wrap natural, `sin_q14`/`cos_q14` O(1). Test host `make test`.

## Scrolltext con fuente de 3 planos (módulo 0x02162C)

- Evidencia: bloque `out/modules_all/blk_02162C_45924.bin` (descomprimido del ADF),
  desensamblado en `recovered/code/code_2162c/code_2162c.asm`. Confianza **alta** (rutina
  completa desensamblada, fuente y texto extraídos).
- Contenido del módulo:
  - `0x1A80`: **mapa de caracteres** `" abcdefghijklmnopqrstuvwxyz0123456789.,!?:"-` (43 chars).
  - `~0x2800-0x3400`: **glifos** (cada char: 3 planos × 8 filas × 2 bytes = 16 px de ancho).
  - `0x352A`: **texto del scroll** (alemán: "Gefällt, sondern... will sie nicht die erste ist...").
  - `0x1AAC`: rutina de **limpieza de bitplanes** (`lea $60000.l,a0; move.w #$3bff,d7;
    clr.l (a0)+; dbf d7` = limpia 0x3C00 longs = 61440 B).
- Rutina de render (0x196E-0x1A70):
  1. Si no hay texto pendiente (`$1a7e`), lee el siguiente char: `lea $352a.l,a0` +
     offset `$1a72`, busca el char en el mapa (bucle `cmp.b (a1)+,d0; dbeq`).
  2. Índice del char → base de glifos `$30e9(pc)` + índice → puntero al glifo.
  3. Bitplane destino `$60000.l` + offset `$1a76` (scroll horizontal) + `$1a7a` (contador).
  4. **Bucle de 3 planos** (`moveq #$2,d7; dbf`):
     - Copia 8 filas del glifo al bitplane: `move.b $0(a2),$0(a3); $2c→$50; $58→$a0;
       $84→$f0; $b0→$140; $dc→$190; $108→$1e0; $134→$230`.
     - `lea $160(a2),a2` (siguiente plano del glifo), `lea $5000(a3),a3` (siguiente bitplane).
  5. Avance: `$1a7a` llega a `$50` (80) → `$1a72++`, `$1a7a=0`, `$1a76 += $320` (800).
     `$1a76` llega a `$4e20` (20000) → reset scroll (`$1a76=0`, `$1a7e=1`).
- Parámetros: 3 bitplanes en Chip RAM `0x60000` (stride `0x5000` entre planos), fuente de
  16 px de ancho × 8 de alto, glifo por char = 3 × `0x160` bytes.
- Receta para el engine: mantener un **buffer de texto** con el índice de cada char; el scroll
  horizontal se hace moviendo un **offset dentro del buffer** y refrescando la columna de bytes
  que entra; el glifo es un mapa `char → 3 planos de 8 filas`. En C++: tabla de glifos
  `uint8_t glyph[43][3][8][2]`, y un bucle que copia a la textura/bitplane.
- Coste: 3 planos × 8 bytes × nº chars visibles por frame; la limpieza de bitplane es
  `0x3C00` longs (rápida en CPU o Blitter).

## Pendiente

- Efectos concretos (3D, corridor, blitter) y su algoritmo.
- Música (`mod.elekfunk`, `mod.livin' insanity`, `mod.mobyle`).
- Gráficos (`drwho96.raw`, `hloadpic.raw.im`).
