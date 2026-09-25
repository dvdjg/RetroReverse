# NES → Amiga 500 — transpilador/emulador HLE

Nodo de conversión del marco [`conversion/`](../README.md). Objetivo: tomar una **ROM NES** y
producir un programa que corra en un **Amiga 500 stock** (68000 ~7 MHz, OCS, 512 KB Chip), imitando
de cerca el PPU/APU de la NES mediante **Dual Playfield, Copper, Blitter y sprites hardware**, y
ejecutando el 6502 **transpilado a código nativo 68000/C++** en lugar de interpretarlo.

> Es un objetivo **ambicioso y acotado**: no se busca precisión ciclo a ciclo perfecta en A500,
> sino **fidelidad visual/jugable** para un subconjunto de juegos (empezando por mappers simples:
> NROM/UNROM/CNROM, luego MMC1/MMC3), con **frameskip** donde haga falta.

## Estrategia en tres piezas

1. **Transpilador (PC, C++23)** — analiza la ROM y genera C++23 con *basic blocks* y `goto`, más
   tablas de despacho. Se compila con el toolchain 68000 (`m68k-amiga-elf-g++`/`vbcc`) o se valida
   en host con `g++`. Ver [`docs/TRANSPILER.md`](docs/TRANSPILER.md).
2. **Runtime Amiga (68000 + C++)** — ejecuta el código generado y traduce las escrituras a los
   registros de la NES a operaciones nativas del Amiga (scroll por HW, blitter de tiles, sprites +
   Copper, APU → Paula). Ver [`docs/RUNTIME_AMIGA.md`](docs/RUNTIME_AMIGA.md).
3. **Capa HLE + fallback** — intercepta las *intenciones* del juego y las acelera; lo no reconocido
   cae a un PPU/APU software. Ver [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) y
   [`docs/HLE.md`](docs/HLE.md).

## Documentación

| Documento | Contenido |
|---|---|
| [`docs/ROADMAP.md`](docs/ROADMAP.md) | **Fases, hitos y criterios de cierre** (empieza por aquí) |
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | Capas, HLE + fallback, interfaces y flujo por frame |
| [`docs/TRANSPILER.md`](docs/TRANSPILER.md) | Fase 1: 6502 → C++23, IR/CFG, codegen, saltos |
| [`docs/HLE.md`](docs/HLE.md) | Fase 2: reconocimiento de intenciones y rutinas `hle_*` |
| [`docs/PPU_AMIGA.md`](docs/PPU_AMIGA.md) | Motor de tiles, scroll (XYUnlimited), color y buffers |
| [`docs/COPPER.md`](docs/COPPER.md) | Copperlist: atributos verticales, splits, doble buffer |
| [`docs/SPRITES_AMIGA.md`](docs/SPRITES_AMIGA.md) | Conversión de sprites, multiplexado, bobs, OAM |
| [`docs/AUDIO_AMIGA.md`](docs/AUDIO_AMIGA.md) | APU de la NES → Paula (4 canales / mixer) |
| [`docs/MAPPERS.md`](docs/MAPPERS.md) | Bankswitching y recompilación parcial |
| [`docs/RUNTIME_AMIGA.md`](docs/RUNTIME_AMIGA.md) | Chip RAM, pantalla, VBlank, bucle principal, input |
| [`docs/OPTIMIZATION.md`](docs/OPTIMIZATION.md) | Dominios de valores, `ASSUME`, clonado, PGO y 68000 |
| [`docs/VALIDATION.md`](docs/VALIDATION.md) | Validación diferencial y determinismo |
| [`docs/RISKS.md`](docs/RISKS.md) | Limitaciones reales del A500 y riesgos del enfoque |

Hardware de origen: [`../../platforms/consoles/nes/docs/HARDWARE.md`](../../platforms/consoles/nes/docs/HARDWARE.md)
y [`hardware_spec/`](../../platforms/consoles/nes/hardware_spec/README.md).
Hardware destino: [`../../platforms/computers/amiga500/hardware_spec/`](../../platforms/computers/amiga500/hardware_spec/README.md).

## Layout

```
nes-to-amiga500/
  README.md            este documento (estado + índices)
  docs/                documentación de diseño (el "cómo")
  tools/
    transpiler/        programa PC (C++23): ROM NES → C++23
  runtime/             runtime de destino (host + 68000)
    hle/               handlers HLE (scroll, OAM, VRAM, bankswitch…)
    fallback/          PPU/APU software (camino lento)
    amiga/             hardware Amiga (Copper, Blitter, sprites, Paula, VBlank)
  examples/            ROMs mínimas de prueba (propias, NO versionadas; se generan)
  generated/           salida del transpilador (regenerable, ignorada por git)
```

## Estado

| Fase | Descripción | Estado |
|---|---|---|
| F0 | Fundaciones: estructura, docs, ADR, toolchains de build | **EN CURSO** (este scaffolding) |
| F1 | CPU 6502 runtime fiel (host) validada con `nestest` | pendiente (base ya existe en `platforms/consoles/nes/`) |
| F2 | Transpilador estático 6502 → C++23 (NROM) | **prototipo funcional** (`tools/transpiler/`) |
| F3 | Fallback PPU+APU software (host) + validación vs `mesen` | pendiente |
| F4 | Runtime Amiga mínimo (arranca y pinta con fallback) | pendiente |
| F5 | Motor de tiles + scroll HW + atributos | pendiente |
| F6 | Sprites (HW + multiplex + bobs) | pendiente |
| F7 | Audio → Paula | pendiente |
| F8 | Capa HLE (reconocimiento de intenciones) | pendiente |
| F9 | Mappers 2/3/1/4 | pendiente |
| F10 | Compatibilidad y optimización (catálogo de juegos) | pendiente |

Detalle, dependencias y **criterios de cierre** en [`docs/ROADMAP.md`](docs/ROADMAP.md).

## Decisiones clave

- **Híbrido HLE + fallback**, nunca solo HLE (compatibilidad) ni solo interpretación (velocidad).
- **Transpilación estática** como camino por defecto; intérprete solo como *fallback* de bloques no
  resueltos (saltos indirectos, código automodificable).
- **Código generado ilegible para el humano pero óptimo para el compilador**: `goto` + etiquetas,
  ROM como `const`, flags solo cuando se usan.
- **Destino = A500 stock**; toda decisión de rendimiento se mide contra el presupuesto de frame
  (~20 ms a 50 Hz).

## Legal

Análisis de **estudio personal**. Solo ROMs propias; no se versionan binarios ni assets de terceros.
Ver [`../../docs/LEGAL.md`](../../docs/LEGAL.md).
