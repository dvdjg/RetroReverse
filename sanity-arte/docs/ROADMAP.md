# Roadmap — desensamblado de «Arte» (Sanity, 1993)

Estados: `HECHO` · `EN CURSO` · `PENDIENTE` · `BLOQUEADO`.
Cada fase indica su **criterio de cierre** (evidencia que la da por terminada) y las
dependencias.

## Objetivo final (visión) — CONFIRMADO
- **Recuperar las técnicas gráficas de la demo** (no solo los datos): comprender el ensamblador
  68k extraído, **inferir los programas C++ más aproximados**, regenerar una versión de alto
  nivel, y **volver a construir la misma demo desde el código fuente**.
- La reimplementación debe ser **código C++ propio** (técnicas y algoritmos, no copia literal del
  68k). El ensamblador es la fuente de conocimiento; se usa solo para las partes críticas si es
  imprescindible.
- El énfasis está en **los efectos gráficos** (título, corridor, etc.) y en cómo la demo los
  orquesta (bucle de frame, Copper, blitter, sincronía).
- **Cierre del objetivo**: una versión reconstruida en C++ que reproduce la demo (o sus efectos
  clave) ejecutable en el engine propio, trazable a los hallazgos de `recovered/`.

## Fase 0 — Extracción del disco — HECHO
- Portar xDMS (`WinUAE-DBG/archivers/dms`) a `tools/dms_unpack.py` (modos NOCOMP/SIMPLE/QUICK/
  MEDIUM/DEEP/HEAVY1-2).
- Producir `out/sanity-arte.adf` (901120 B).
- **Cierre**: 80/80 pistas decodificadas con CRC de cabecera, CRC comprimido y checksum
  descomprimido correctos (salida `--verbose`).

## Fase 1 — Formato de disco y loader — HECHO
- Determinar que el disco no es AmigaDOS (no hay root block) y que usa trackloader propio.
- Identificar el bootblock `SOS1` y sus dependencias (`trackdisk.device`, `graphics.library`).
- Identificar SOS V2.4 y su cruncher `CrM!`/`CrM2`.
- **Cierre**: strings y desensamblado del bootblock + búsqueda de root block fallida (documentado).

## Fase 2 — Arranque y volcado de RAM — HECHO
- Lanzar WinUAE-DBG (A500, KS1.3, 512K chip + 512K slow) con el ADF insertado vía
  `WinUAEConnection` + GDB.
- Dejar bootear y volcar Chip+Slow RAM a fichero con `readMemory` en bloques.
- Capturar screenshot del estado.
- **Cierre**: `out/chip000000.bin`, `out/slowc00000.bin` (512K cada uno) con 0 fallos de lectura,
  más `out/shot-boot.png` mostrando la pantalla de título `arte`.

## Fase 3 — Volcado de módulos descomprimidos — HECHO
- **Resultado**: `probe-layout.mjs` determinó el contrato de `IMP!` (destino = `A0` = cabecera,
  longitud = long en `+4`). `hook-trampoline.mjs` (modo routine) volcó **12 bloques únicos** a
  `out/modules/` + `modules.json` (ver `recovered/maps/modules.md`). Falta identificar módulo↔bloque.
- Enganchar el trampoline de decrunch de SOS (entrada `0xC02584`, patrón
  `48e7fffe20184bfa0026b0bc43724d21`; `jsr` al de-cruncher en `+0x26`, retorno en `+0x28`).
- En cada llamada: capturar `(destino=A1, longitud=D1, header=A0)` al entrar y volcar el rango
  `[A1, A1+D1)` al salir.
- Guardar cada bloque único como `out/modules/mod_<n>_<addr>_<len>.bin` + metadatos.
- **Cierre**: aparece en `out/modules/` el código/datos de los módulos conocidos
  (`SINE.soslibrary`, `drwho96.raw`, `mod.*`, `hloadpic.raw.im`, `txt.Scrolltext`, …) sin
  comprimir y listos para desensamblar.
- **Riesgo**: el stub GDB puede requerir step-over manual de los breakpoints software; si se
  repite el mismo PC, hay que quitar/poner el breakpoint y hacer step.
- **Estado (hito 1)**: el stub **sí aplica breakpoints** (verificado con
  `toolkit/node/probe-breakpoints.mjs`: `T05swbreak` en `0xC0255A`). El PC en caliente está en el
  cruncher **`IMP!`** (`0xC02426`), no en el trampoline `CrM!` (`0xC02584`) enganchado primero:
  por eso no disparaba. Hay que enganchar `IMP!`.
- **Hito 2 (siguiente)**: determinar el layout del bloque `IMP!` (destino/longitud) con un sondeo
  de RAM **antes/después** de una sola llamada (diff), y añadir a `hook-trampoline.mjs` un modo
  «routine» que lo soporte.
- **Plan A (hook)**: breakpoint en la entrada de `IMP!` y en su retorno (`0xC02476`).
- **Plan B (sin hooks)**: muestrear la RAM periódicamente, diferenciar volcados consecutivos y
  extraer las regiones nuevas.
- **Plan C (red de seguridad)**: volcado completo tardío (correr 120 s y volcar toda la RAM).

## Fase 4 — Bucle principal y rutinas de efecto — EN CURSO
- Localizar el dispatch de módulos/efectos (tabla de nombres ya conocida).
- Identificar el bucle por frame y los puntos de sincronía (VBlank, Copper).
- **Cierre**: mapa de direcciones rutina <-> efecto.

## Fase 5 — Extracción de assets — EN CURSO
- Capturar custom registers (`$DFFxxx`) y Copperlist en un efecto activo.
- Decodificar bitplanes/samples a PNG/WAV (`bitmap_decode` del módulo MCP o propio).
- **Cierre**: imágenes y samples por efecto comparables con la captura de pantalla.
- **Estado**: `dump-display.mjs` captura custom regs + Copperlist + paleta (en `out/display/`;
  copiados a `recovered/media/`). La decodificación a PNG queda pendiente: hay que capturar con la
  Copperlist **activa** (no de blanqueo) o usar la lectura fiable de registros.

## Fase 6 — Algoritmos y documentación — EN CURSO
- Desensamblar con `m68k-objdump` las rutinas de efecto y anotarlas.
- Redactar `docs/TECNICAS.md`: descripción + receta de reimplementación en el engine propio.
- **Cierre**: cada efecto documentado tiene pseudocódigo/algoritmo, parámetros y coste.
- **Estado**: primera recreación en `reimpl/sine_table/` (seno Q1.14, test host OK).

## Mejoras de método (transversales, para otros desensamblados)
- HECHO: estructura canónica de expediente + plantilla (`Amiga-Reverse/STRUCTURE.md`, `Amiga-Reverse/_template/`).
- HECHO: lecciones transversales en `Amiga-Reverse/LECCIONES_APRENDIDAS.md`.
- PENDIENTE: generalizar `toolkit/node/hook-trampoline.mjs` con un modo «routine» (destino/longitud desde cabecera) además del modo «trampoline».
- PENDIENTE: script de "hook + volcado" reutilizable (breakpoints configurables + fallback por muestreo).
- PENDIENTE: decodificador de copperlists y bitplanes reutilizable (módulo propio, no depender de MCP).
