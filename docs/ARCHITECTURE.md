# Arquitectura

Cinco componentes desacoplados, unidos por el **orquestador** y dos contratos estables: la
**spec intermedia (HIGS)** y el **protocolo de instrumentación** de los emuladores.

## 1. Entorno de emulación instrumentado (headless)

**Propósito**: ejecutar el juego de forma **determinista** y **observable**, sin GUI.

- **Frontend/core**: libretro (RetroArch o frontend mínimo propio) sobre cores con código fuente:
  MAME (arcade), mesen/nestopia/fceumm (NES), FS-UAE/WinUAE (Amiga), Genesis-Plus-GX, etc.
  Ver [`EMULATORS.md`](EMULATORS.md).
- **Control de estado (savestates en memoria)**: extraer/inyectar RAM, VRAM, paletas, OAM y
  registros de CPU; guardar y restaurar estados en O(1) para **ramificar la exploración**.
- **Control de input programático**: inyectar secuencias de botones (para cubrir mecánicas),
  fuzzing guiado por cobertura, playback de grabaciones.
- **Captura**: framebuffers por frame, audio, y **trazas** (instrucciones ejecutadas, lecturas/
  escrituras de memoria, writes a registros de hardware).
- **Base de instrumentación**: [libRetroReversing](https://github.com/RetroReversing/libRetroReversing)
  (logging de instrucciones/memoria, input recording/playback, inspección web) como submódulo del core.

**Contrato de salida** (lo que consumen los demás): `execution_traces/`, `memory_dumps/`,
`savestates/`, `screenshots/`.

## 2. Análisis estático y desensamblado

**Propósito**: convertir la ROM en un **CFG anotado** y separar código de datos.

- **Desensamblador multi-arquitectura**: **Capstone** (Z80, M68k, 6502, x86) para desensamblado
  rápido y marcas de datos; **Ghidra headless** para análisis profundo (CFG, xrefs, decompilador).
- **Plugins**: Amiga `BartmanAbyss/ghidra-amiga` + `lab313ru/ghidra_amiga_ldr`; NES `GhidraNes`;
  Z80/68000 genéricos ya en Ghidra.
- **Mapeo de I/O**: direcciones ligadas a hardware (custom chips Amiga, PPU/NES, PPIs/arcade) según
  el **mapa de memoria** de la placa (`rom/layout.json`).
- **Anotación guiada por trazas**: los puntos de entrada y rangos ejecutados del emulador
  (componente 1) priorizan y etiquetan funciones.

**Contrato de salida**: `extraction/disassembly/{code_blocks.asm, control_flow_graph.json, symbols.map}`.

## 3. Agente de análisis dinámico e inferencial (IA)

**Propósito**: correlacionar **memoria ↔ comportamiento ↔ imagen** e **inferir** mecánicas.

- **Trazador de cobertura**: direcciones ejecutadas → bucles de juego, handlers de VBLANK,
  subrutinas de entidades.
- **Extractor de assets**: decodifica bitplanes/tiles/sprites/paletas y chips de sonido a PNG/WAV/JSON.
- **Inferencia de máquinas de estados**: detecta variables con incrementos/decrementos
  correlacionados con movimiento, IDs de nivel, contadores de animación, tablas de colisión.
- **Bucle iterativo**: ejecuta escenarios controlados, compara estados antes/después, formula y
  **verifica hipótesis** contra la documentación y contra el emulador. Ver [`PIPELINE.md`](PIPELINE.md).

**Contrato de salida**: propuestas de HIGS + referencias a assets.

## 4. Generador de especificación intermedia — HIGS

*Hardware-Independent Game Spec*: esquema estructurado (JSON/YAML) **agnóstico del hardware** que es
la **única** entrada de la reimplementación. Ver [`HIGS.md`](HIGS.md).

Cubre: mecánicas, mapas/tilemaps y reglas, entidades (FSM, hitboxes, velocidades, animación),
**temporizaciones exactas** (ciclos relativos y **ticks fijos 50/60 Hz**), asset refs y audio.

## 5. Entorno de validación diferencial

**Propósito**: certificar paridad *pixel-perfect*.

- Ejecución **dual** (emulador instrumentado ↔ reimplementación SDL3) con **mismo input**.
- Comparación **frame a frame**: framebuffer (diff de imagen / hash), audio (vectores de muestras),
  y opcionalmente memoria/estado lógico.
- Reporte de desviaciones con el frame mínimo reproducible (savestate + input) para depurar.

---

## Flujo de datos

```
 ROM (propia)                    doc de la comunidad (ground truth)
     │                                        │
     ▼                                        ▼
┌───────────┐   trazas/savestates   ┌──────────────────┐
│ EMULACIÓN │ ───────────────────▶  │ ANÁLISIS ESTÁTICO│
│ headless  │ ◀─── input/estados ── │ Ghidra/Capstone  │
└────┬──────┘                       └────────┬─────────┘
     │ dumps VRAM/registros                  │ CFG/símbolos
     ▼                                       ▼
┌──────────────────────┐   hipótesis   ┌───────────────┐
│ AGENTE IA (inferencia)│ ────────────▶ │  HIGS (spec)  │
└──────────┬───────────┘               └───────┬───────┘
           │ assets → PNG/WAV/JSON             │
           ▼                                   ▼
      assets/                        reimplementation/ (C++23+SDL3)
                                               │
                                     ┌─────────▼──────────┐
                                     │ VALIDACIÓN DIFERENCIAL │
                                     │ (vs emulador)          │
                                     └────────────────────────┘
```

## Decisiones transversales

- **Lenguaje**: orquestador y runtime en **C++23**; scripting de glue en **Python**; build **CMake**.
- **Serialización**: JSON (nlohmann/nlohmann-json o cbor) para HIGS y layouts.
- **Imagen**: OpenCV/SIMD para diffing.
- **Reproducibilidad**: toda observación relevante va acompañada de *(savestate + input + frame)*.
- **ADR**: las decisiones de arquitectura se registran en [`adr/`](adr/).
