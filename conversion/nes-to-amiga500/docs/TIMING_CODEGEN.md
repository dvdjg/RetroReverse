# Timming del codegen: *yield* por *deadline* (Fase 3/2b)

Diseño del mecanismo para que el **código transpilado** resuelva los eventos del PPU (VBlank, NMI,
IRQ de mapper, sprite-0) en la **misma frontera de instrucción** que el intérprete, sin pagar el coste
de mantener el PC en el camino caliente. Desbloquea MMC1/MMC3
([`TRANSPILER_BANKING.md`](TRANSPILER_BANKING.md) §B3).

## Problema

Un bloque transpilado se ejecuta **atómico** y el host resuelve el NMI/IRQ **tras** el bloque
(`NesSystem::step_block`). Si VBlank cae a mitad de un bloque, el NMI se toma tarde. Fraccionar el
bloque exige un **punto de reanudación**; hoy el código generado **no mantiene `cpu.PC` por
instrucción** (solo en los saltos), así que un bloque no puede ceder.

## Idea: *deadline* + *yield* con PC estático

Por cada instrucción, tras ejecutarla:

```cpp
cpu.cycles += N; cpu.mem->tick(N);                 // ciclos Y avance de PPU por acceso
if (cpu.cycles >= cpu.deadline) { cpu.PC = NEXT; return; }   // NEXT es constante
```

- `cpu.deadline` lo fija el **host** a `cpu.cycles + next_event_dots()/3` antes de cada bloque.
- `NEXT` = dirección de la **instrucción siguiente**, **conocida en compilación** → el *store* de PC
  solo aparece en la **rama de salida** (rara: ~1 vez por evento). El camino caliente paga solo un
  `cmp`+rama adicional.
- Al ceder, `cpu.PC` queda en `NEXT` (que puede no ser inicio de bloque) → el dispatcher ejecuta con
  el **intérprete** hasta el siguiente *leader* (un puñado de instrucciones, solo junto a eventos).

## Contrato host

1. `NesSystem` fija `cpu.deadline = cpu.cycles + cycles_to_next_event()` antes de `fast_run`.
2. El bloque transpilado **ya reloja la PPU por acceso** (`cpu.mem->tick`), así que el host **no**
   re-reloja el bloque (`fast_ticks = true`).
3. Tras el bloque, el host resuelve el evento (`nmi_occurred`/IRQ) **como ya hace**: al ceder en la
   frontera exacta, el flag se puso en el ciclo correcto.

## Propiedades

- **Exacto y predecible**: el *deadline* es el ciclo **real** del próximo evento (`next_event_dots`),
  no una estimación; la cesión cae en la instrucción que lo cruza, igual que el intérprete.
- **Barato en 68000**: sin store de PC por instrucción (a diferencia de "PC por instrucción" puro).
- **Aditivo/opt-in**: se emite tras un flag (`--event-yield`); por defecto, comportamiento actual.

## Coste a medir

- **Tamaño**: `+` (cmp + rama + store) por instrucción; medir `.text` en m68k.
- **Velocidad**: `+1 cmp`/instrucción; medir estimación de ciclos 68000.

## Verificación y criterio de aborto

- NROM/UxROM **sin regresión** (`codegen == interprete`, `ram_diff=0`, puerta verde).
- **MMC1** (Metroid / Mega Man 2) → objetivo **~0 %** de píxeles distintos.
- Si no baja MMC1 **sin** regresar los 30+ juegos a 0 %, **revertir** y documentar.

## Resultado (2026): causa localizada con **traza codegen↔intérprete**

Se construyó la traza (`nes_transpiler --trace` emite `N2A_TRACE(addr)` por instrucción;
[`../tools/transpiler/tests/dbg_trace.cpp`](../tools/transpiler/tests/dbg_trace.cpp) compara PC+registros
del **codegen** (bloques + fallback) contra el **intérprete**). En Metroid, **primera divergencia**:

```
ffba: LDA $2002      ; espera de VBlank
ffbd: BPL $ffba
...
[7826] ref $FFBD A=80 | gen $FFBD A=00   -> el intérprete lee VBlank=1; el codegen, 0
```

**Causa raíz**: el código generado **no avanzaba la PPU por acceso** (el host la avanzaba **tras** el
bloque), así que `LDA $2002` veía un estado de PPU distinto. **Arreglo**: avance de PPU por acceso en
el generado (`cpu.mem->tick(base)` + penalizaciones) y `NesSystem::fast_ticks` (el host no re-reloja).

**Verificado con la traza**: frames 1–2 → **24441 instrucciones idénticas** (mismo PC y estado) entre
codegen e intérprete. NROM/UXROM siguen exactos; `RUNTIME OK`; `STATIC_SIZE OK`.

**Verificado a 60 frames (traza)**: el primer bucle de VBlank (`$FFBA`) queda **alineado**; la primera
divergencia se mueve a **idx 72181** (~6 frames), en un **bucle de subida a VRAM**:

```
C7E7: LDA ($01),Y     ; lee de $2007 (buffer de datos de PPU)
C7E9: STA $2007
...
[72181] ref $C7E7 -> A=7F | gen -> A=07   (RAM idéntica: hash R=27F320E7 en ambos)
```

Ampliando la traza con **hash de RAM + estado del mapper**, la primera divergencia se movió a idx
52750: la escritura al **registro de control MMC1** (`$8000`) se aplicaba en el intérprete
(`mmc1_ctrl=0E`) pero **no** en el codegen (`0C`).

**Causa raíz**: `NesSystem::io_write` fijaba `mapper.cpu_cycle = interp.cycles`, pero en el codegen
`interp.cycles` **no avanza** (los bloques usan `cpu.cycles`). El **filtro de 2 ciclos** del MMC1
(`cpu_write` descarta escrituras demasiado próximas) rechazaba la escritura → CHR/banking/ctrl
incorrectos.

**Arreglo**: `mapper.cpu_cycle = cpu.cycles` (contador **global**, que llevan intérprete y bloques).

**Resultado (byte-exact)**:

| ROM (mapper) | traza 60 frames | píxeles `fixed`/`banked` |
|---|---|---|
| Metroid (MMC1) | **650489/650489, sin divergencia** | **0.0 %** (RAM 0/2048) |
| Mega Man 2 (MMC1) | — | **0.0 %** |
| Contra/Castlevania (UxROM) | — | 0.0 % |

**MMC1 (modo 16K) es ahora transpilable byte-exact.** `fallback/fixed/banked` = 0.0 %. Verificado en
**5 ROMs bancadas** (Contra/Castlevania UxROM; Metroid/Mega Man 2/Blaster Master MMC1).

**Coste en m68k (medido)**: `Metroid` → `.text` **228 KB** con `--release` (sin ticks) vs **451 KB**
con ticks. Los **ticks** (avance de PPU por acceso) son para **validación en host**; el build **Amiga**
debe usar `--release` (sin ellos) → ~228 KB. El `.bss` es 0 en ambos.

## Estado

- [x] Traza codegen↔intérprete (`--trace` + `dbg_trace.cpp`, con hash de RAM y estado de mapper/PPU).
- [x] **Ticks por acceso** (timing de `$2002`), `yield` por deadline (`cpu.deadline`) y
  **contador de ciclos global** (`mapper.cpu_cycle = cpu.cycles`).
- [x] **MMC1 (modo 16K) byte-exact** (Metroid/Mega Man 2, 60 frames, 0.0 %).
- [x] B3 parcial: MMC1 transpilable; **MMC3 pendiente**.
