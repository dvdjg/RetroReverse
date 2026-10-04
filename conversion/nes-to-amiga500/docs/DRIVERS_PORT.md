# Drivers de port por juego (`--driver`)

El transpilador convierte una ROM NES en un **port nativo** (no un emulador) que debe ser
**pixel-perfect** y, a la vez, **caber en 50 fps** en A500 (68000 @ 7 MHz). Esas dos metas chocan:
hay decisiones que el generador **no puede inferir** del código (¿este bucle es una espera o
trabajo real? ¿este PRNG importa? ¿esta rutina se puede saltar?) y que son **específicas de cada
juego**. El **driver** es un fichero de texto por juego donde se almacenan esas decisiones, de
modo que el generador las aplique de forma reproducible y documentada.

- **Fichero**: `drivers/<juego>.n2a` (texto, UTF-8 sin BOM, comentarios con `#`).
- **Invocación**: `nes_transpiler <rom.nes> --decompile --flat --vblank --driver drivers/<juego>.n2a -o <port.hpp>`.
- **Relación con `--facts`**: `--facts` son hechos de **valor** inferidos por telemetría (rangos,
  igualdades, calor de bloque) que el codegen traduce a `N2A_ASSUME`/`hot`/`cold`. El **driver**
  son decisiones de **port** (semántica/timing) que no se infieren: son instrucciones del integrador.

## Formato

Una directiva por línea: `<kind> <args...>`. Hex con o sin `0x`. `#` comenta (también a mitad de
línea). Las líneas inválidas se ignoran (no abortan).

```text
# comentario
patch <addr> <byte> [byte ...]   ; escribe bytes en el PRG (CPU >= 0x8000)
note  <texto libre>              ; documenta una decisión (se imprime al generar)
```

## Directivas v1 (implementadas)

| Directiva | Semántica | Por qué existe |
|---|---|---|
| `patch <addr> <byte>...` | Escribe bytes en el PRG (CPU `addr`) **antes** de desensamblar/generar. | "Trampa" genérica: fijar el estado del PRNG, neutralizar un temporizador, y habilitar/deshabilitar una rama, cuando reproducir el original cuesta fps o no aporta nada visible. |
| `note <texto>` | Documenta una decisión (se imprime). | Trazabilidad: el driver es la memoria de por qué el port difiere del original. |

El parcheo se aplica sobre los **bytes de la ROM** (offset `16 + (addr - 0x8000) % prg_size`, que
cubre el espejo de NROM-128), antes de `Transpiler::load()`, por lo que el `PRG_ROM[]` generado ya
lleva el cambio y **toda** la lógica (desensamblado, CFG, codegen) lo ve.

## Directivas planificadas (especificadas, pendientes de implementar)

El objetivo es que las decisiones que hoy son parches de ROM o heurísticas del codegen se expresen
de forma declarativa. Ordenadas por valor para el caso DK:

| Directiva | Semántica | Para qué |
|---|---|---|
| `wait <addr>` | El bloque en `addr` es un **busy-wait**: al port no le interesa ejecutar el cuerpo; cede la frontera de frame y sigue. | El bucle `C7E1 (JSR F4ED)` de DK: 377 iter/frame de puro LFSR. Saltarlo mantiene 50 fps. |
| `rng <addr> <base> <len>` | El bucle/rutina en `addr` es un **PRNG** sobre `len` bytes en `base`. El port lo **modela barato** (avanza K pasos conocidos/frame) en vez de ejecutarlo. | Reproducir `$18-$1F` sin pagar las 377 iteraciones. |
| `vblank <addr>` | El sondeo `LDA $2002`/`BPL` en `addr` es una espera de VBlank (ya se autodetecta; la directiva lo **fuerza**). | Casos que el idióm no detecta. |
| `skip <addr>` | No emitir la rutina/bloque en `addr` (no-op). | Código muerto o puramente cosmético caro. |
| `ram <addr> <byte>...` | Fija esos bytes de RAM en el arranque (tras el reset). | Desviaciones de init o "semilla" forzada. |
| `speed <addr> <cycles>` | Sobrescribe el coste en ciclos del bloque `addr`. | Cuadrar timing sin tocar el código. |
| `frame_cycles <n>` | Sobrescribe el presupuesto de frame (`g_frame_deadline`). | PAL = 33247; NTSC = 29780. |

## Cómo lo consume el generador

1. **Carga** (`load_driver`): parsea el fichero a `DriverSpec`.
2. **Parcheo de ROM** (`apply_rom_patches`): se aplica a los bytes antes de `load()` (v1).
3. **Codegen**: las directivas de semántica (`wait`/`rng`/`vblank`/`skip`/`speed`/`ram`) se
   consultarán en los puntos de emisión (busy-wait, `$2002`, arranque del bloque, `tick`) para
   modular lo que se emite. Se implementarán encima del mismo parser.

## Ejemplo (DK)

Ver `drivers/dk.n2a`. Resumen de decisiones ya conocidas:

- `C7E1` es el **LFSR** (64 bits en `$18-$1F`) usado como PRNG; ~377 iter/frame. → `wait`/`rng`.
- La siembra (`L_C9B1`, `$18=0F/$19=13`) **no se alcanza** en el port (la máquina de estados
  diverge antes de `$0510=$38`): es un **bug del port**, no una decisión de driver.

## Criterio de uso

- Preferir **modelar** (`rng`) sobre **saltar** (`skip`): saltar cambia la semántica.
- Todo `patch` debe ir acompañado de un `note` que explique **qué** y **por qué** (el port debe
  poder reconstruirse mentalmente desde el driver).
- Un driver no debe "esconder" un bug: si el original y el port divergen, primero arreglar el port.
