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

## Estado

- [ ] Doc de diseño (este).
- [ ] Emisión del *yield* + `cpu.deadline` en runtime (`--event-yield`).
- [ ] Medición NROM/UxROM/MMC1.
- [ ] Medición `.text`/coste 68000 y decisión ON/OFF.
- [ ] Si funciona: retomar B3 (MMC1/MMC3).
