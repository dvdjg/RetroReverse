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
wait  <addr>                     ; el bloque <addr> es busy-wait (cede sin ejecutar el cuerpo)
note  <texto libre>              ; documenta una decisión (se imprime al generar)
```

## Directivas v1 (implementadas)

| Directiva | Semántica | Por qué existe |
|---|---|---|
| `patch <addr> <byte>...` | Escribe bytes en el PRG (CPU `addr`) **antes** de desensamblar/generar. | "Trampa" genérica: fijar el estado del PRNG, neutralizar un temporizador, habilitar/deshabilitar una rama, cuando reproducir el original cuesta fps o no aporta nada visible. |
| `wait <addr>` | El bloque `addr` es un **busy-wait**: el codegen lo trata como espera (cede la frontera de frame sin ejecutar el cuerpo) **aunque** la detección automática (`decomp_wait_loop`) no lo reconozca. | Forzar el "spin-yield" en bucles de espera que el análisis estático no detecta (p. ej. con `JMP` indirecto o condición). En DK `C7E4` ya se autodetecta, así que `wait C7E4` no cambia la salida (verificado). |
| `note <texto>` | Documenta una decisión (se imprime). | Trazabilidad: el driver es la memoria de por qué el port difiere del original. |

El parcheo se aplica sobre los **bytes de la ROM** (offset `16 + (addr - 0x8000) % prg_size`, que
cubre el espejo de NROM-128), antes de `Transpiler::load()`, por lo que el `PRG_ROM[]` generado ya
lleva el cambio y **toda** la lógica (desensamblado, CFG, codegen) lo ve.

## Directivas planificadas (especificadas, pendientes de implementar)

El objetivo es que las decisiones que hoy son parches de ROM o heurísticas del codegen se expresen
de forma declarativa. Ordenadas por valor para el caso DK:

| Directiva | Semántica | Para qué |
|---|---|---|
| `rng <addr> <base> <len>` | El bucle/rutina en `addr` es un **PRNG** sobre `len` bytes en `base`. El port lo **modela barato** en vez de ejecutarlo. | Reproducir `$18-$1F` sin pagar las 377 iteraciones. |
| `vblank <addr>` | El sondeo `LDA $2002`/`BPL` en `addr` es una espera de VBlank (ya se autodetecta; la directiva lo **fuerza**). | Casos que el idióm no detecta. |
| `skip <addr>` | No emitir la rutina/bloque en `addr` (no-op). | Código muerto o puramente cosmético caro. |
| `ram <addr> <byte>...` | Fija esos bytes de RAM en el arranque (tras el reset). | Desviaciones de init o "semilla" forzada. |
| `speed <addr> <cycles>` | Sobrescribe el coste en ciclos del bloque `addr`. | Cuadrar timing sin tocar el código. |
| `frame_cycles <n>` | Sobrescribe el presupuesto de frame (`g_frame_deadline`). | PAL = 33247; NTSC = 29780. |

### Diseño de `rng` (el caso DK)

`F4ED` es un **LFSR de 64 bits**: rota `$18-$1F` a la derecha con carry-in = bit1(`$18`) XOR
bit1(`$19`). Avanzarlo K pasos es un **mapa lineal sobre GF(2)^64** (multiplicar por la K-ésima
potencia de la matriz de transición). Opciones para "modelarlo barato" (O(1)/frame en vez de O(K)):

1. **Tabla precalculada** de potencias de 2 (K≈377 = 256+64+32+16+8+1 -> 6 rotaciones+composiciones).
2. **Exponenciación de matrices** en runtime (barato: K fijo por frame).
3. Caso degenerado fiel: si el juego no usa el PRNG para nada visible, `skip`/`wait` basta.

**Requisito**: el bug raíz de la máquina de estados (la siembra `L_C9B1` no se alcanza) debe
resolverse **antes**: mientras `$18-$1F` no se siembre, modelar el PRNG no cambia nada.

## Cómo lo consume el generador

1. **Carga** (`load_driver`): parsea el fichero a `DriverSpec` (parcheos + bloques `wait` + notas).
2. **Parcheo de ROM** (`apply_rom_patches`): se aplica a los bytes antes de `load()`.
3. **Codegen**: `wait` se registra en el transpilador (`add_wait_block`) y el punto de emisión del
   busy-wait lo consulta (`decomp_wait_loop(b) || driver_wait(b)`). El resto de directivas de
   semántica (`rng`/`vblank`/`skip`/`speed`/`ram`) se consultarán en sus puntos de emisión.

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
