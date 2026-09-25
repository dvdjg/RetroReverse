# Roadmap — NES → Amiga 500

Plan por **fases** con **criterio de cierre** verificable. Estados: `HECHO` → `EN CURSO` →
`PENDIENTE` → `BLOQUEADO`. La regla transversal del marco es **documentación primero** y
**validación diferencial** ([`../../../docs/RESEARCH_FIRST.md`](../../../docs/RESEARCH_FIRST.md),
[`VALIDATION.md`](VALIDATION.md)).

> Regla de oro: **primero que funcione lento y correcto, luego que funcione rápido**. El fallback
> software es el oráculo; el HLE es la optimización.

## Visión de conjunto

```
F0 estructura ─► F1 CPU 6502 ─► F2 transpilador ─► F3 fallback PC ─► F4 arranque A500
                                                        │                    │
                                                        └──── validación ────┘
                                                                             ▼
     F9 mappers ◄─ F8 HLE ◄─ F7 audio ◄─ F6 sprites ◄─ F5 tiles+scroll ◄─────┘
                     │
                     ▼
               F10 compatibilidad/optimización
```

Dependencias duras: `F1→F2→F3→F4` (cadena crítica) y `F5,F6,F7→F8` (HLE necesita los motores).
`F9` (mappers) y `F8` (HLE) pueden solaparse; `F10` es continua.

---

## F0 — Fundaciones

**Objetivo**: dejar el nodo listo para trabajar sin ambigüedades.

- Estructura `docs/ tools/ runtime/ examples/ generated/` + ADR del pilar.
- Toolchains definidos y verificados:
  - **host** (transpilador y tests): `g++ -std=c++23` / `clang++` / MSVC `/std:c++latest`.
  - **destino**: `m68k-amiga-elf-g++` (gcc del bundle `vscode-amiga-debug`) o `vbcc`; ensamblador
    `vasm`/`vasm-elf`.
  - **referencia**: core `mesen` del orquestador (`external/`, ya compilado).
- Spec de hardware NES congelada (ya existe en `platforms/consoles/nes/`).

**Cierre**: `docs/` completo, build del esqueleto host OK, y una ROM mínima generable.

---

## F1 — CPU 6502 fiel (runtime host)

**Objetivo**: una clase `CPU` 6502 (oficiales **e ilegales**) y un `NESMemory`/bus correctos, en
C++23, que sirvan de sustrato al transpilador y al fallback.

**Estado: HECHO.** El runtime incluye
[`../runtime/include/nes_runtime.hpp`](../runtime/include/nes_runtime.hpp) (memoria + CPU de métodos)
y [`../runtime/include/nes_interpreter.hpp`](../runtime/include/nes_interpreter.hpp) (intérprete 6502,
oficiales + ilegales). Validado con `nestest`: `$02=0` y `$03=0`, y con **conteo de ciclos por
instrucción** (tabla base + penalizaciones de página/rama, `runtime/test/cycles_test.cpp`) — todo en
[`../runtime/test/run.sh`](../runtime/test/run.sh).

- Reutilizar la base ya validada en
  [`../../../platforms/consoles/nes/reimplementation/`](../../../platforms/consoles/nes/reimplementation/)
  (H1/H2: `nestest` OK con ilegales).
- Flags del 6502 exactos (`C Z I D V N`, comportamiento de `B`), stack, modos de direccionamiento.
- `read()`/`write()` como **único punto de enganche** para HLE y análisis dinámico.
- Contador de ciclos por instrucción/bloque (para el timing del PPU/APU).

**Cierre**: `nestest` oficial e ilegal `$00 == $03 == 0` sobre el runtime del nodo (no solo el de
plataforma).

---

## F2 — Transpilador estático 6502 → C++23 (NROM)

**Objetivo**: generar C++23 a partir de la PRG-ROM, con *basic blocks*, control de flujo resuelto y
llamadas `cpu.*` que imitan el ensamblador. Detalle en [`TRANSPILER.md`](TRANSPILER.md).

**Estado: prototipo funcional** en [`../tools/transpiler/`](../tools/transpiler/README.md)
(C++23 sobre `eng/core`, sin STL): iNES → desasm recursivo → basic blocks → codegen NROM, con
ramas/`JMP`/`JSR`/`RTS`, tabla de despacho y *smoke test* que compila y ejecuta el C++ generado
(ROMs propias). Pendiente: runtime real (F3) y mappers (F9).

Pipeline: parseo iNES/NES 2.0 → vectores → desensamblado recursivo → CFG → basic blocks →
codegen (`goto` + etiquetas) → tabla de despacho + arranque.

- Tabla de opcodes completa (oficiales + ilegales frecuentes).
- **Optimización dirigida por dominios de valores** desde el codegen: `ASSUME`/`[[assume]]`, zero-page
  como parámetros (para `IPA-CP`), clonado con guarda, `constexpr`/tablas. Ver
  [`OPTIMIZATION.md`](OPTIMIZATION.md).
- Estrategias de salto: **(a)** bloques como funciones + `musttail`; **(b)** función única con
  etiquetas + `goto` (por defecto); **(c)** *computed goto* (experimental).
- ROM como `constexpr` (constant propagation), flags actualizados solo donde se usan.
- Entrada del dispatcher desde `reset`/`NMI`/`IRQ` y para saltos indirectos no resueltos.

**Cierre**: una ROM mínima (`examples/`) transpilada, compilada en host y ejecutada con resultado
idéntico a un intérprete de referencia (traza de PC + estado final).

---

## F3 — Fallback PPU + APU software (host) y validación vs `mesen`

**Objetivo**: un emulador de la NES **completo pero lento** en host, que sea el *oráculo* del nodo.
Es el "cero" del HLE: todo lo que no se acelere caerá aquí.

**Estado: EN CURSO.** [`../runtime/fallback/nes_ppu.hpp`](../runtime/fallback/nes_ppu.hpp) implementa
registros, VRAM, OAM, paleta, scroll, VBlank/NMI, el **render del fondo** y los **sprites**
(8×8/8×16, flips, 4 paletas, prioridad tras el fondo, límite de 8 por línea y **sprite-0 hit**) a un
framebuffer de índices NES (`runtime/fallback/test/ppu_test.cpp`), con **scroll por línea**
(mid-frame). **Validación diferencial** con `mesen` (vía el orquestador) en
[`../runtime/test/diff_mesen.sh`](../runtime/test/diff_mesen.sh): ~12 % de píxeles distintos en
Donkey Kong y ~24 % en Balloon Fight (la diferencia es en gran parte **paleta y timing**, no
estructura). Pendiente: afinar timing/paleta para reducir la divergencia.

- PPU software: render 256×240 (tiles, attributes, sprites, scroll, sprite-0 hit), VBlank/NMI,
  `$2000-$2007`, OAM, DMA `$4014`.
- Bus/mapeo completo: RAM, espejos, PPU/APU/controles, cartucho.
- APU en C++23 (2 pulse, triangle, noise, DMC, frame counter) → buffer de samples.
- Mappers **NROM** (F3) para el vertical slice.

**Cierre**: para el vertical slice (ROM propia pequeña) el framebuffer y el audio coinciden con
`mesen` en los escenarios cubiertos (ver [`VALIDATION.md`](VALIDATION.md)).

---

## F4 — Runtime Amiga mínimo (arranca y pinta con el fallback)

**Objetivo**: llevar el fallback a un **A500 real/emulado** y ver algo en pantalla, aunque sea lento.

- Reserva de Chip RAM (bitmap, copperlists, sprites, audio) e init de pantalla. Ver
  [`RUNTIME_AMIGA.md`](RUNTIME_AMIGA.md).
- VBlank (nivel 3) + bucle principal + `run_nes_frame`.
- *Blit* del framebuffer del PPU software a **bitplanes** (conversión chunky→planar con el Blitter).
- Input (`$4016/$4017`) desde joystick/teclado.

**Cierre**: el vertical slice arranca en WinUAE (A500 OCS 512 KB) y muestra el frame correcto con
frameskip; sin cuelgues ni corrupción.

---

## F5 — Motor de tiles + scroll por hardware + atributos

**Objetivo**: sustituir el grueso del PPU software por el camino HLE de fondo. Detalle en
[`PPU_AMIGA.md`](PPU_AMIGA.md) y [`COPPER.md`](COPPER.md).

- Cache de patrones CHR → planar Amiga (2/3 planos) con attribute pre-aplicado en horizontal.
- Buffer de nametable con margen y **scroll 8-way** (adaptación tipo **XYUnlimited**): scroll grueso
  moviendo `BPLxPT`, fino con `BPLCON1`; solo se *blittean* columnas/filas que entran.
- Cambios de paleta **verticales** con Copper (WAIT + `COLORxx`), splits (status bar).
- Mapeo de las 4 paletas de fondo + color 0 a Dual Playfield (3+3) o 5 bitplanes.

**Cierre**: un juego de scroll continuo (p. ej. un runner sencillo NROM) se mueve fluido a 50 Hz sin
usar el PPU software para el fondo (contador de "píxeles por fallback" = 0).

---

## F6 — Sprites (hardware + multiplex + bobs)

**Objetivo**: imitar los 64 sprites NES y su límite de **8 por scanline**. Detalle en
[`SPRITES_AMIGA.md`](SPRITES_AMIGA.md).

- OAM (`$2003/$2004`) y OAM DMA (`$4014`) como disparadores de *dirty*.
- Conversión 8×8 / 8×16 → formato sprite Amiga (2 planos, flips, paletas 16-31).
- Asignación: 8 sprites HW + **multiplexado por Copper**; el resto, **bobs** con Blitter.
- Prioridad NES (`behind BG`) ↔ `BPLCON2` + prioridad de bob/sprite.

**Cierre**: escena con >8 sprites por línea (y con flip/paleta) idéntica al fallback; overflow de
línea descartado como en hardware real.

---

## F7 — Audio → Paula

**Objetivo**: alimentar Paula con el APU emulado. Detalle en [`AUDIO_AMIGA.md`](AUDIO_AMIGA.md).

**Estado: EN CURSO.** [`../runtime/fallback/nes_apu.hpp`](../runtime/fallback/nes_apu.hpp) modela los
registros `$4000-$4017`, el frame counter y sintetiza pulse/triangle/noise/**DMC** con **mezcla no
lineal** (tablas NESdev) a muestras de 16 bits (`runtime/fallback/test/apu_test.cpp`). Pendiente:
volcado real a Paula (bloques/DMA) y pulido de envolventes/sweep.

- Generación por bloques (128–256 muestras) a 11/22 kHz; integrar con el mixer de audio del engine
  Amiga (repo `Amiga-Cpp`) en uno o varios canales.
- Mezcla NES (tablas `pulse`/`tnd`), *frame counter*, envolventes, sweep.
- DMC (lee de memoria) opcional al principio.

**Cierre**: un fragmento con música/efectos suena sin *underruns* a 50 Hz y espectralmente
reconocible frente a `mesen` (comparación subjetiva + RMS/FFT básica).

---

## F8 — Capa HLE (reconocimiento de intenciones)

**Objetivo**: acelerar el código sustituyendo patrones por rutinas nativas. Detalle en
[`HLE.md`](HLE.md) y [`ARCHITECTURE.md`](ARCHITECTURE.md).

**Estado: EN CURSO.** [`../runtime/include/nes_hle.hpp`](../runtime/include/nes_hle.hpp) clasifica
las escrituras de PPU (scroll/dirección/datos/OAM DMA) como HLE y mide el **ratio HLE**
(~97 % en el test del sistema, `runtime/test/system_test.cpp`). Pendiente: handlers reales de
Copper/Blitter en el destino y el reconocimiento estático/dinámico de patrones.

- Interceptación de `$2000`, `$2005`, `$2006`, `$2007`, `$4014` y registros de mapper.
- *Handlers*: scroll, escritura de VRAM/nametable (dirty tiles), OAM DMA, bankswitch, sprite-0
  hit/splits.
- Reconocimiento **estático** (sobre IR/C++) y **dinámico asistido** (trazas en host).
- Sincronización de estado entre HLE y fallback al cambiar de camino.

**Cierre**: en el vertical slice ≥80 % de las escrituras PPU del frame se resuelven por handlers
(ratio medido), y el coste de CPU del frame baja del presupuesto de 20 ms.

---

## F9 — Mappers y bankswitching

**Objetivo**: soportar juegos comerciales. Detalle en [`MAPPERS.md`](MAPPERS.md).

**Estado: EN CURSO.** [`../runtime/include/nes_mapper.hpp`](../runtime/include/nes_mapper.hpp)
implementa el cartucho (bancos PRG/CHR) para **NROM (0), UxROM (2), CNROM (3)** y **MMC1 (1)**
parcial, y el runner [`../runtime/tools/nes_frame.cpp`](../runtime/tools/nes_frame.cpp) parsea
iNES/**NES 2.0**. El transpilador sigue siendo **NROM-only**; el *banking* con tablas de despacho
por banco es lo pendiente.

- Orden: **0 (NROM) → 2 (UxROM) → 3 (CNROM) → 1 (MMC1) → 4 (MMC3, con IRQ de scanline)**.
- Interfaz `Mapper` (read/write PRG, CHR, IRQ, `scanline_clock`).
- **Recompilación parcial / parches**: al cambiar de banco no se re-transpila todo; se mantiene una
  tabla de bloques por banco y trampolines.

**Cierre**: 2 juegos por mapper (NROM/UxROM/CNROM) y 1 por MMC1/MMC3 arrancan y son jugables
(frameskip permitido) en A500; IRQ de MMC3 sincronizada.

---

## F10 — Compatibilidad y optimización (continuo)

- Catálogo de **hechos de valores** por juego (`facts.json`) → especialización clonada (`ASSUME`,
  `[[likely]]`, tablas). Ver [`OPTIMIZATION.md`](OPTIMIZATION.md).
- PGO (perfil host → cross-compiler) y superoptimización de secuencias 68000.
- Catálogo de juegos con estado (`funciona / parcial / roto`) y su mapper.
- Perfilado por frame (ciclos por subsistema), *frameskip* adaptativo, caché de bloques calientes.
- Patrones HLE nuevos descubiertos por juego (el catálogo crece con cada título).
- Guía de *porting* de un juego reproducido (nuevo nodo o `examples/`).

**Cierre**: matriz de compatibilidad publicada y reproducible con ROMs propias.

---

## Hitos buscables

| Hito | Evidencia |
|---|---|
| M1 · CPU fiel | `nestest` oficial+ilegal OK en el runtime del nodo |
| M2 · Transpilador | ROM mínima transpilada == intérprete (traza + estado) |
| M3 · Fallback válido | framebuffer/audio iguales a `mesen` en escenarios cubiertos |
| M4 · Arranque A500 | el slice se ve en WinUAE A500 512 KB |
| M5 · Fondo por HW | scroll 8-way sin usar PPU software para el fondo |
| M6 · Sprites por HW | escena >8/línea fiel (HW + bobs) |
| M7 · Audio | música/efectos sin underruns |
| M8 · HLE | ≥80 % de escrituras PPU por handler |
| M9 · Mappers | NROM+UxROM+CNROM+MMC1+MMC3 con juegos jugables |
| M10 · Reproducible | matriz de compatibilidad con ROMs propias |

## Riesgos principales

En [`RISKS.md`](RISKS.md). Los tres que más condicionan el roadmap: **Chip RAM escasa**,
**código automodificable/saltos indirectos** y **precisión de timing** (sprite 0, IRQ de mapper).
