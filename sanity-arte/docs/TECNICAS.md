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

## Seno precalculado (`SINE.soslibrary`)

- Evidencia: módulo `SINE.soslibrary` referenciado por SOS; el demo mueve objetos/ángulos por frame.
- Idea: tabla de seno precalculada y consulta entera (sin `sin()`/punto flotante en runtime).
- Receta para el engine (PORTADO): `reimpl/sine_table/` — tabla Q1.14 de 1024 entradas, fase de 16
  bits con wrap natural, `sin_q14`/`cos_q14` O(1). Test host `make test`.

## Pendiente

- Efectos concretos (3D, scroll, blitter) y su algoritmo.
- Música (`mod.elekfunk`, `mod.livin' insanity`, `mod.mobyle`).
- Gráficos (`drwho96.raw`, `hloadpic.raw.im`).
