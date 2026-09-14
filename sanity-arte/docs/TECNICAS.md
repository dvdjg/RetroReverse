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

## Pendiente

- Efectos concretos (3D, scroll, blitter) y su algoritmo.
- Música (`mod.elekfunk`, `mod.livin' insanity`, `mod.mobyle`).
- Gráficos (`drwho96.raw`, `hloadpic.raw.im`).
