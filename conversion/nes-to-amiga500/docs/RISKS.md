# Riesgos y limitaciones reales

Un **A500 stock** (68000 ~7 MHz, OCS, 512 KB Chip) es mucho más ajustado que los emuladores NES
Amiga existentes (A/NES, darkNESs), que piden 68020+ con FastRAM y a menudo AGA. Estas son las
limitaciones honestas y cómo se mitigan.

## Limitaciones del objetivo

| Limitación | Impacto | Mitigación |
|---|---|---|
| **CPU lenta** (7 MHz, sin FastRAM) | no hay margen para interpretar | transpilación estática + HLE + frameskip |
| **Chip RAM escasa** (512 KB) | no caben buffers generosos | DPF 3+3, buffers 272×256, cache de tiles ajustada (≈75 KB) |
| **Sin precisión ciclo a ciclo** | sprite 0 hit, IRQ de mapper, splits | Copper `WAIT` aproximado + fallback; no prometer exactitud total |
| **8 sprites HW** | más de 8/línea | multiplex + bobs (Blitter); la NES ya limita a 8/línea |
| **Paleta OCS** (12-bit, 32 colores) | fidelidad de color | DPF + cambios de paleta por Copper; AGA lo haría trivial |
| **Paula ≠ APU** | timbre | síntesis precisa por software + 1 canal; DMC opcional |

## Riesgos técnicos

| Riesgo | Mitigación |
|---|---|
| **Código automodificable** (común en NES) | detectar estáticamente lo posible; el resto, intérprete/fallback |
| **Saltos indirectos y `JMP ($xxyy)`** | despacho por tabla + fallback; análisis dinámico |
| **Bankswitching** rompe la traducción estática | bloques por banco + recompilación parcial/parches (F9) |
| **Flags 6502** (`V`, `B`) no mapean a `CCR` 68000 | flags explícitos en la clase `CPU`; el compilador los optimiza |
| **Timing PPU/APU** impreciso | contador de ciclos por bloque; ajustar en validación |
| **Chip RAM sin margen** | presupuestar y medir; liberar lo no usado; cachés LRU |
| **Dos caminos HLE/fallback** divergen | estado emulado único; tests diferenciales HLE vs fallback |
| **Deriva a "port mirando captura"** | prohibido: la fuente de verdad es la ROM y el estado emulado |

### Límite real: sincronización PPU/NMI **por instrucción** (no por ciclo) (2026)

**Una sola raíz para los 6 juegos "malos".** Tras arreglar los mappers (MMC1 completo, MMC3) y el
**CHR conmutado en el render**, la matriz queda casi toda a **0%** (32/38). Los 6 restantes —
`ic` 92.2%, `galaga` 36.7%, `metalstorm` 14.2%, `jurassicpark` 13.7%, `pacman` 13.2%,
`blastermaster` 9.1% — **no son 6 bugs distintos**: con el **tracer de re-sync por PC**
(`trace_diff.py`; salta las iteraciones *benignas* del bucle de espera de VBlank) se comprobó que
**todos comparten la misma primera divergencia real**: el **timing del NMI/VBlank**.

**Evidencia (metalstorm).** El bucle principal del juego es `$FCBA: JMP $FCBA` (espera-NMI: el NMI
hace el trabajo de cada frame). En la divergencia (idx 43447) **ambos** están en ese bucle, pero
**nosotros en el bucle** y **mesen dentro del handler NMI** (`$FCBF: PHA; TXA;…`) → el
*interleaving* NMI↔bucle se desalinea. Lo mismo, con el mismo offset `+1`, en `ic` (idx 9132) y
`galaga`/`pacman`. (SMB: el mismo efecto deja el logo del título ~2 filas más bajo → su 3.1%.)

**Causa.** Nuestro CPU sincroniza la PPU **por instrucción** (cada acceso de bus hace `mem.tick()`,
la PPU avanza 3 dots; los ciclos internos se completan al final), mientras que mesen la sincroniza
**por ciclo**. Consecuencias medibles:

- La lectura de `$2002` muestrea el flag de VBlank a **una instrucción de distancia** (~7-9 ciclos)
  de mesen → el bucle de espera de VBlank sale **una iteración** antes o después.
- El **NMI** cae por tanto en una **frontera de instrucción distinta** → se desalinea el interleaving
  NMI↔bucle principal (y de ahí la cascada de estado posterior).
- El **largo de frame** no se puede fijar a **29780.67** ciclos (media NTSC): se redondea a **~29782**
  (~1.3 ciclos más) porque la frontera de frame cae en frontera de instrucción.

**Lo que NO lo arregla (probado y descartado).** Mover el dot del flag (0/1), la máscara de lectura
(`<3`/`<6` dots), los ciclos de reset (7/8/9), el avance de PPU (5–20 dots), un **"lookahead"** de la
ventana del flag (16/24/150 dots), la frontera de frame, y el **skip de 1 dot en frames impares**
(NTSC, `mesen PPU.cpp:1316` — correcto y aplicado, pero **neutro**). Todos **desplazan** la
divergencia pero **no la eliminan**: el problema no es el **valor** del flag, sino la **resolución
temporal** de la sincronización. Un parche por juego sería inviable (6 juegos, cada uno con su punto
interno de divergencia).

**La solución (real, no un remiendo) — arquitectura acordada.** Tras contrastar el análisis con una
segunda opinión independiente, la conclusión es **la misma**: no existe un workaround genérico y
robusto que conserve a la vez (a) granularidad de instrucción, (b) PPU en bloque, (c) frontera de
frame *snapada* a instrucción y (d) equivalencia intérprete↔codegen. La divergencia es **estructural**.

El arreglo correcto y **genérico** (sin tablas por juego) es un **catch-up dirigido por eventos**,
que conserva la equivalencia porque intérprete y codegen comparten el mismo scheduler:

1. **Contador absoluto** de ciclos/dots desde un epoch (fase **continua**, sin snap).
2. Antes de ejecutar una instrucción/bloque, **predecir el ciclo absoluto del próximo evento
   crítico**: flag de VBlank set `(241,1)` y clear `(261,1)`, sprite-0, overflow, IRQ de mapper,
   fin de frame.
3. Si el evento cae **dentro** del intervalo de ciclos de esa instrucción/bloque → **bajar a
   granularidad de ciclo (o de acceso de bus) solo en esa ventana**, o **predecir el ciclo exacto
   del acceso `$2002`** (según el *addressing mode*) y decidir el valor del flag **antes** de
   completar la instrucción.
4. **Arrastrar el residuo de fase entre frames** (la frontera no es un snap duro; el frame dura
   `89342` dots ≈ `29780⅔` ciclos, ± el skip de 1 dot en frames impares). El **codegen debe respetar
   el mismo residuo** (esto es lo que hoy rompe la equivalencia, `ram_diff=5`).
5. **NMI**: muestrear al final de la instrucción, o en la **fase 2 del último ciclo** (modelo de
   *half-cycle*): partir el ciclo de CPU en dos mitades alrededor del dot 1 de la 241 (lo que hacen
   los emuladores que pasan `vbl_nmi_timing`).

**Lockstep mínimo suficiente**: **scheduler de eventos + frontera exacta con residuo**, con el
**render *lazy*** (dibujar el frame al final). **No** hace falta una PPU cycle-accurate pixel a pixel
mientras los *efectos observables* (status flags, NMI, sprite-0, IRQs) estén temporizados al ciclo
correcto desde el contador absoluto. Ese es el punto de equilibrio de los emuladores "buenos pero no
mesen".

**Plan de implementación (bounded, con criterio de aborto):**
1. Convertir el avance de la PPU a un **contador absoluto de dots** (no resetear en la frontera);
   `run_frame` corta en el **dot exacto** (no en frontera de instrucción).
2. **Scheduler de eventos**: exponer `next_event_cycle` (VBlank/NMI/sprite-0/IRQ A12) y usarlo como
   presupuesto del bloque (en vez de `cycles_to_scanline`), cayendo a ciclo/bus en la ventana crítica.
3. Replicar exactamente en el **codegen** (mismo scheduler) y verificar `equivalencia ram_diff=0`.
4. Criterio de aborto: si el paso 3 no cuadra la equivalencia sin romper los **30+ juegos a 0%**,
   revertir y dejar el límite documentado (el oráculo sigue válido para todo lo demás).

Las dos vías "de libro" equivalentes, de menor a mayor alcance:

1. **Muestreo cycle-exacto de `$2002`** (mínimo, localizado). Hoy `Interpreter::rd()` hace
   `mem.tick()` **antes** de `mem.read()`, así que la lectura ve el dot del ciclo **siguiente**; de
   ahí nace el desfase de ~1 ciclo. Arreglo: para la instrucción que **lee `$2002`** (`LDA/AND/… abs`
   con operando `$2002`), calcular el **ciclo exacto** del acceso de datos
   (`cpu_cycle_actual + ciclo_del_acceso`, p. ej. 3 para `LDA abs`) y evaluar el flag de VBlank con
   la PPU avanzada **al dot de ese ciclo** (no al siguiente), y solo entonces completar los ciclos
   internos. Es subdividir la instrucción en su punto de muestreo. Acotado, pero toca el intérprete
   (y hay que replicarlo en el codegen para mantener la equivalencia intérprete↔bloques).

2. **Lockstep PPU/CPU ciclo a ciclo** (general, "correcto"). Sustituir el avance "3 dots por acceso"
   por un lazo que avance **1 ciclo de CPU = 3 dots de PPU** y resuelva los eventos de PPU en su
   **ciclo exacto**: flag de VBlank en `(241,1)`, sprite-0 en su dot, contador A12 de la MMC3, y el
   instante de toma del NMI (al final de la instrucción durante la cual se puso el flag, como mesen
   `CPU::Exec`: `if(_prevRunIrq || _prevNeedNmi) IRQ()`). Elimina de raíz el ±1, el borde del NMI y
   el largo de frame, a cambio de reescribir el bucle de ejecución del intérprete.

> Nota de método: el **tracer de re-sync por PC** (`trace_diff.py`) fue decisivo — sin él, la
> comparación por índice se atasca en el primer bucle de VBlank (benigno) y **oculta** la divergencia
> real. Es la herramienta que convirtió "6 juegos misteriosos" en "**una** limitación localizada".

**Impacto.** No bloquea el Amiga: el port usa timing por **hardware** (Copper/Blitter; ver
[`TIMING_AMIGA.md`](TIMING_AMIGA.md)), no este sincronismo fino. Es una limitación de **fidelidad de
estado** del **oráculo** en esos 6 juegos, documentada como límite **conocido** de `oracle-v2`.

**Impacto en el codegen.** El mismo efecto aparece entre el **plugin** (bloques) y el **intérprete**
(instrucción a instrucción): al verificar los 13 `.n2x`, 5 coinciden (RAM 0/2048) y 8 difieren en
**2–13 bytes de RAM con el framebuffer idéntico** (0/61440 píxeles). El lockstep interno
intérprete↔codegen pasa (`ram_diff=0`) con la ejecución **del mismo motor**; la diferencia plugin vs
intérprete es la granularidad de bloque (vía 2).

## Impacto de los arreglos en la versión Amiga

Estos arreglos viven en el **oráculo/host** (PPU/APU software), no en el renderer Amiga (Copper/
Blitter/Paula). Su impacto en el port es indirecto pero real (y la estrategia para no pedir más
ciclos al 68000 está en [`TIMING_AMIGA.md`](TIMING_AMIGA.md)):

| Arreglo (host) | Impacto en el Amiga |
|---|---|
| `$2007` al espacio de **pattern** (`$0000-$1FFF`) se ignora (CHR-ROM) / se lee de CHR | El HLE/Copper que gestione la VRAM debe **descartar** esas escrituras; antes el oráculo daba un estado irreal y las trazas/savestates de partida eran incorrectos |
| **Espejo de paleta** `$3F10-$3F1C → $3F00-$3F0C` | El HLE que siga los cambios de paleta por Copper debe aplicar el mismo espejo; de lo contrario el fondo sale mal en títulos como SMB |
| **Sprite-0 por scanline + dot** | El `WAIT` del Copper (temporizador de raster) debe usar la misma línea/columna del hit; mejora los juegos que parten la pantalla con sprite-0 |
| **APU sweep + envolvente de noise** | La síntesis a Paula (1 canal por software) debe implementar sweep (incl. el `+1` del pulse1 y el muteo) y la envolvente del noise; el WAV del host es la referencia de validación |
| **Timing por frontera de bloque** (deriva) | Afecta al **codegen**, que es lo que corre en el Amiga: partidas con temporizadores dependientes del raster pueden desviarse unos bytes respecto al intérprete. Se mitiga con el mismo sincronismo fino (pendiente) |
| Nada de esto añade coste al Amiga | El PPU/APU del host no se ejecutan en el Amiga; el clock dot-exacto se optimizó a O(1) (sin coste de host) |

## Riesgos de proyecto

| Riesgo | Mitigación |
|---|---|
| Ámbito demasiado ambicioso | vertical slice primero (NROM, 1 juego); fases con criterio de cierre |
| ROMs no disponibles / legales | usar homebrew propio o ROM mínima de prueba; nunca versionar ROMs |
| Compatibilidad sobre-prometida | matriz de compatibilidad por juego y mapper, publicada |
| Dependencia del toolchain 68000 | compilar también en host para iterar rápido |

## No-objetivos (por ahora)

- Emulación cycle-accurate en A500.
- Soporte de decenas de mappers al inicio.
- Precisión de audio perfecta (DMC completo) desde el día 1.
- A500 acelerado / AGA como requisito (se aprovechará si está, pero no se asume).

## Criterio de "viable"

**Sí** para un subconjunto de juegos (NROM/UNROM/algunos MMC1) con frameskip y optimización
agresiva. **Difícil** compatibilidad alta y full speed sin acelerador. La ventaja del Amiga es que
Blitter y Copper son ideales para imitar tiles/sprites/scroll; el objetivo es **look fiel y
jugable**, no exactitud total.
