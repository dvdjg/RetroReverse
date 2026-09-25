# NES — arquitectura de reimplementación (decisión)

Objetivo: un **emulador NES propio** para instrumentación y validación, en **C++23**, ligero y
controlable (headless + con front-end propio a futuro). Base de decisión tomada comparando las
referencias.

## Comparativa

| Proyecto | Lenguaje | Precisión | Puntos fuertes | Por qué no reusarlo tal cual |
|---|---|---|---|---|
| **Mesen 2** (SourMesen) | C++/C# | cycle-accurate | Referencia de oro; debug (VRAM/OAM/tilemap), trazas | Grande; UI C#/.NET; queremos núcleo mínimo y control total |
| **olcNES** (javidx9) | C++ | didáctica | Arquitectura limpia (bus/CPU/PPU/cart) | Simplificada; sin opcodes ilegales/APU; no cycle-accurate |
| **Nesium** | (moderno) | cycle-accurate | Suite de depuración (OAM, pattern tables, IRQ) | Joven; menos maduro como referencia |
| **FCEUX** | C++ (+Lua) | alta | Tracing, scripting Lua, RE dinámica | Legacy; complejo; licencia/estructura dispersa |
| **mesen-libretro** (ya en `external/`) | C++ | alta | Integrado en el orquestador (cores) | Es la **referencia**, no la reimpl |

## Decisión

Reimplementación **propia** en C++23, modular y table-driven, con estas metas:

1. **CPU 6502** con oficiales **e ilegales** (table-driven), validada con `nestest`.
2. **Bus** de 64 KiB con espejos y mapeo de cartucho; **mappers** 0/1/2/3/4.
3. **PPU** por **scanline** (dot-accurate donde importe: sprites, `$2002/$2007`, OAM quirk).
4. **APU** funcional (5 canales, frame counter) — exactitud de audio iterativa.
5. **Instrumentación**: dump de RAM/VRAM/OAM/paletas y trazas de PC por rango (para el
   orquestador y el análisis), reutilizando el contrato `EmulatorControl`.

Razonamiento: Mesen 2/Nesium/FCEUX se usan como **referencia y contraste**; olcNES como guía de
**estructura**; el código es propio (MIT), sin copiar implementaciones.

## Layout

```
reimplementation/
├── include/  src/     núcleo (bus, cpu6502, ppu, apu, cartridge, mapper, nes)
├── test/              arnés nestest (+ futuros test ROMs)
└── Makefile
```

## Plan por hitos

| Hito | Criterio | Estado |
|---|---|---|
| H1 CPU oficial | `nestest` oficial: `$02 == 0` | **HECHO** |
| H2 CPU + ilegales | `nestest` ilegal: `$03 == 0` | **HECHO** (8991/8991 líneas del log) |
| H3 PPU básica | render de SMB/DK estable (hash por frame) | pendiente |
| H4 APU | audio funcional; contraste con mesen | pendiente |
| H5 Mappers | MMC1/MMC3 (IRQ) → juegos de la selección | pendiente |
| H6 Integración | adaptador `EmulatorControl` + validación diferencial vs `mesen` | pendiente |

## Fuentes

[`../../../../docs/REFERENCES.md`](../../../../docs/REFERENCES.md) §NES.
