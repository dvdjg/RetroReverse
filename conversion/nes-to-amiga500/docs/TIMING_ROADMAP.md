# Roadmap: sincronismo PPU/CPU por ciclo (event-driven)

> **ESTADO (2026): óptimo alcanzado con Fase 1+2.**
> - **Fase 1 (PPU dot a dot) + Fase 2 (fase continua)** implementadas: **jurassicpark y
>   blastermaster 13.7%/9.1% → 0.0%**; el primer bucle de VBlank alinea; sin regresiones.
> - Tras ello la **fase del PPU es CONSTANTE** (no deriva); el residuo es un **offset sub-dot**
>   (~+4 dots) del **modelo exacto de sincronización de mesen** (`_masterClock - _ppuOffset`,
>   `StartCpuCycle`/`EndCpuCycle`). Ningún ajuste global de fase mejora **sin** regresar un juego
>   ya a 0.0% → el dot natural de Fase 1+2 es el **óptimo**.
> - **4 juegos** (`ic` 92.2%, `galaga` 36.7%, `metalstorm` 14.2%, `pacman` 12.9%) quedan como
>   **límite de fidelidad de estado** (no bloqueante; el render es correcto).
> - **Segunda referencia (paso 2)**: nestopia usa `SCANLINE_VBLANK = 240` y mesen `241` →
>   **las referencias discrepan** en el instante del VBlank; el ±1 dot es **modelo-dependiente**,
>   no un bug nuestro claro. (Coincide con la observación de que nuestro `(241,0)` compensa.)
> - El andamiaje experimental (`kFrameSnap`) se **retiró**; Fase 2 es el comportamiento por defecto.

> **Alternativa en diagnóstico (2026)**: la **inyección de estado** (*state-injection*) como entrega
> replicable en A500 — capturar el estado de `mesen` y embeberlo como datos, en vez de cerrar el
> lockstep. Hipótesis, herramienta y criterio de decisión en
> [`RISKS.md`](RISKS.md#estrategia-considerada-state-injection-test-a-2026--en-diagnóstico).

**Objetivo.** Que los **efectos observables** de la PPU (flag de VBlank en `$2002`, NMI, sprite-0,
overflow, IRQ de mapper A12/por-ciclo, fin de frame) ocurran en el **ciclo exacto** respecto a la
CPU, con **fase continua** entre frames, para que el oráculo coincida con mesen también en los
juegos sensibles al timing (los 6 del límite en [`RISKS.md`](RISKS.md)). **El render puede seguir
siendo *lazy*** (dibujar el frame al final): no hace falta una PPU pixel a pixel.

**Principio rector.** *Seguir la estructura de los emuladores que ya funcionan* (mesen, nestopia):
avance de PPU por ciclo/dot con resolución de eventos por dot, y un contador absoluto de ciclos.
mesen procesa la PPU **dot a dot** (`PPU::Exec`, `_cycle++`) y engancha los eventos ahí; nosotros
hoy avanzamos **en bloque** y resolvemos por rangos + un *snap* de frame. Este roadmap cierra esa
diferencia por fases, **verificando contra mesen en cada una**.

## Invariantes a conservar en TODO el roadmap

- **Equivalencia intérprete ↔ codegen** (`ram_diff=0` en `bench_engine`): ambos caminos deben usar
  el **mismo** modelo temporal. Es el invariante más frágil → se comprueba en cada fase.
- **Sin regresiones** en los **30+ juegos a 0%** (`port_matrix --gate`).
- **Determinismo** del oráculo.
- **Sin datos por juego** (nada de tablas): todo genérico.

## Fases

### Fase 0 — Diagnóstico del *snap* (por qué rompe la equivalencia)
Quitar el `ppu.scanline=240; ppu.dot=0` de `run_frame` rompe `equivalencia` (`ram_diff=5`). Antes de
tocar nada hay que **entender exactamente por qué**: hipótesis = el ejecutor por bloques no corta en
la frontera de frame (su `budget` es a fin de *scanline*), así que intérprete y codegen ejecutan un
número de instrucciones distinto en el frame. **Entregable**: informe de la causa con `dbg_fast2`.
*Criterio de avance*: causa confirmada (no especulada).

### Fase 0bis — Tracer de **fase del PPU** (hecho)
Se añadió la **posición del PPU** a ambas trazas (`frame_probe` = `scanline*341+dot`, mesen =
`GetFrameCycle()`), y `trace_diff` la muestra como columna **dPPU** (referencia − nuestra).
Hallazgo (metalstorm):
- En el **mismo ciclo de CPU**, la posición del PPU difiere en un offset **constante** dentro de un
  frame (**369 dots raw ≈ 28 dots alineados** por la base de una línea; mesen va por delante).
- El **flag** de mesen está a ~1 dot del nuestro, pero la **lectura** de `$2002` cae ~27 dots antes
  del flag en nosotros y ~16 después en mesen → **nuestra lectura sale antes del flag**.
- Entre frames el offset **deriva ~1 línea/frame** (las fronteras de frame no coinciden), lo que
  apunta a la Fase 2 (residuo de fase).
Conclusión: el desfase no es "1 ciclo" arbitrario; es una **relación lectura↔flag** (fase
CPU↔PPU) que solo se corrige prediciendo el **ciclo exacto del acceso** (Fase 3/4), no moviendo el
flag (adelantarlo "a lo bruto" rompe el arranque: lo probamos).

### Fase 2 — hallazgo 2026 (desbloqueada)
El *snap* de la frontera de frame **ya no es necesario para la equivalencia**:
- Antes, quitarlo rompía `equivalencia` (`ram_diff=5`).
- **Ahora es `ram_diff=0`** con `kFrameSnap=false` — el **corte del ejecutor rápido en accesos a
  `$2000-$3FFF`** (`touches_ppu`, añadido para el bug de `$2002`) **fue lo que lo arregló**: sin el
  snap, intérprete y codegen siguen coincidiendo.
- Pero quitar el snap **no mueve la primera divergencia** (que está en **frame 0**, y el frame 0
  nunca hacía snap): es un problema de **frame N>0** (deriva de fase). El primer desfase (frame 0) es
  otra cosa: la relación lectura↔flag (ver Fase 0bis / Fase 4).
**Conclusión**: Fase 2 es ahora **equivalencia-safe** (gran avance) y ataca la **deriva entre frames**;
se puede abordar sin el riesgo que tenía.

> **Implementada PARCIALMENTE (2026).** `kFrameSnap=false` por **defecto** (el *snap* del *scanline*
> se desactiva; `#ifdef N2A_FRAME_SNAP` lo reactiva). Suite verde y gate EXIT=0.

> **Fase 2 COMPLETA: bloqueada por el IRQ de la MMC3 (2026).** El commit anterior dejaba
> **`ppu.dot = 0u` incondicional** al inicio de cada frame → la fase del PPU se **reseteaba cada
> frame** y **cualquier ajuste de fase era inerte** (lo confirmó el probe: los gdots de la lectura de
> `$2002` eran **idénticos** con fase 0 y 9). Al hacer el dot **condicional** (fase continua de
> verdad):
> - La **fase sí importa**: la lectura de `$2002` se mueve, y la salida del bucle de VBlank **se
>   invierte** (fase ≥4 → salimos 1 iteración **antes**; fase ≤3 → **después**) → la alineación fina
>   es **sub-ciclo** (entre 3 y 4 ciclos).
> - **Pero regresiona `jurassicpark`** (13.7% → 16.6%): usa el **IRQ de raster de la MMC3**, sensible
>   a la fase. → **Revertido** hasta que el IRQ (A12) sea exacto (Fase 3).
> **Conclusión**: Fase 2 completa es la correcta, pero **requiere Fase 3** (IRQ MMC3 por ciclo) para
> no regresionar; hacerlas **juntas**.

### Fase 1 — PPU **dot a dot**
Sustituir el avance en bloque (`ppu.dot = end; while (dot>=341)`) por un lazo que llame
`tick_dot()` **una vez por dot** (3 por ciclo de CPU), resolviendo en ese punto: VBlank en `(241,1)`
(no al entrar en la línea), sprite-0 en su dot, clear en `(261,1)`, y —vía callback del sistema—
`set_line_scroll` y el reloj A12/scanline del mapper. **Ya no hay rangos**. Contador
`total_dots` absoluto.
*Verificación*: `RUNTIME OK`, `equivalencia OK`, `gate OK`; y `trace_diff` de metalstorm debe
**mover** la primera divergencia (objetivo: idx 7828 → más adelante).

> **Experimento 2026 (hecho y revertido).** Se implementó Fase 1 (avance dot a dot). Resultado:
> **equivalencia OK** (`ram_diff=0`) pero **neutra en corrección** (la divergencia de metalstorm
> sigue en idx 7828) y **con coste**: el ejecutor rápido pasó de ~4353 a ~2422 fps (**aceleración
> 1.00×** — el bucle por-dot se come la ventaja del codegen). **Conclusión**: Fase 1 **por sí sola
> es un net negativo** (más lenta, sin ganancia); debe hacerse **junto con Fase 3** (scheduler), que
> baja a dot **solo** cerca de un evento y preserva el rendimiento. Se revirtió.

*Coste*: hacerla sin el scheduler multiplica por ~3 el coste del PPU (≈90k `tick_dot`/frame).
*Criterio de aborto*: si no mueve la divergencia **y** cuesta rendimiento, revertir (lo que se hizo).

### Fase 2 — Frontera de frame **exacta** (residuo de fase)
`run_frame` deja de hacer *snap* a `(240,0)` en frontera de instrucción: corta en el **dot exacto**
(`89342` dots ≈ `29780⅔` ciclos, ± el skip de 1 dot en frames impares) y **arrastra el residuo** al
frame siguiente (contador absoluto). El ejecutor por bloques debe **respetar el mismo residuo**
(Fase 0). 
*Verificación*: `equivalencia ram_diff=0` **con el snap fuera**; la deriva de frame desaparece
(`cyc`/frame ≈ alternando 29780/29781).

### Fase 3 — Scheduler de eventos (presupuesto de bloque)
Exponer `next_event_cycle` = mínimo de: VBlank set/clear, sprite-0, overflow, IRQ de mapper, fin de
frame. El `budget` del ejecutor rápido pasa de "hasta fin de scanline" a "hasta el próximo evento"
(0 si el evento cae dentro del bloque → cae a intérprete/instrucción y este a **ciclo/bus**).
*Verificación*: equivalencia + `gate`; `trace_diff` de los 6 juegos.

> **Paso 1 (hecho, 2026): primitivo `Ppu::next_event_dots()`.** Devuelve la distancia en **dots**
> hasta el próximo evento observable (set VBlank 241, pre-render/clear 261, sprite-0 en su dot, fin
> de frame 262→0), con la paridad NTSC (línea 261 = 340 dots en frames impares). Es **aditivo** (no
> toca el bucle → cero regresión) y está cubierto por
> [`../runtime/fallback/test/ppu_events_test.cpp`](../runtime/fallback/test/ppu_events_test.cpp)
> (`PPU_EVENTS OK`). Falta incluir **IRQ de mapper** (MMC3 A12) en el mínimo.
>
> **Paso 2a (hecho, 2026): cablear el ejecutor rápido.** `NesSystem::step_block` usa ahora
> `budget = cycles_to_next_event()` (= `next_event_dots()/3`) en vez de `cycles_to_scanline()`; el
> bloque rápido termina en la frontera del evento y se resuelve el NMI/IRQ. **Sin regresión**:
> `RUNTIME OK`, `interp == fast` OK (bf/gradius), matriz de compatibilidad intacta.
> ⚠️ **No mueve la puerta por sí solo**: la compatibilidad se mide con el **intérprete/oráculo**, y
> los 4 juegos del límite son divergencia **sub-dot** del oráculo vs mesen (Fases 4/5). Tampoco toca
> MMC1/MMC3 (su ejecutor rápido es N/A y el camino transpilado **ignora** el budget).
>
> **Paso 2b (el núcleo duro): probado y revertido — el fallo NO es el orden de acceso.**
> Se emitió avance de PPU **por acceso** en el código generado (`cpu.mem->tick(base)` antes de cada
> instrucción + penalizaciones), con un flag `NesSystem::fast_ticks` para que el host no re-relojee.
> Resultado: **NROM sigue exacto** (`codegen == interprete`, `ram_diff=0`) — los ticks son correctos —
> pero **MMC1 no cambia en absoluto** (Metroid 20.1 % con `fixed` y `banked`, idéntico a sin ticks).
> Conclusión: la divergencia **no es el orden de acceso a la PPU**.
>
> **El bloqueo real**: el **NMI/evento se resuelve a granularidad de bloque** (el host comprueba
> `nmi_occurred` tras el bloque), y un bloque **no puede ceder a mitad** porque el **código generado
> no mantiene `cpu.PC` por instrucción** (solo en los saltos; ver [`OPTIMIZATION.md`](OPTIMIZATION.md)
> §"¿Hace falta mantener el PC?"). Sin PC por instrucción no hay punto de reanudación tras el evento.
> Fraccionar el bloque exige **mantener/actualizar el PC por instrucción** (o un mecanismo de
> reanudación) → cambio de fondo del codegen. Por eso MMC1/MMC3 quedan bloqueados hasta abordarlo
> (ver [`TRANSPILER_BANKING.md`](TRANSPILER_BANKING.md) §B3). **Revertido**: el camino limpio se
> recupera (`RUNTIME OK`).

### Fase 4 — Lectura cycle-exacta de `$2002`

> **Resultado negativo 2026 (muestreo temprano, medido).** Se probó muestrear `$2002`
> **antes** de relojear la PPU el ciclo del acceso de datos (`N2A_VBL_SAMPLE_EARLY` en
> `Interpreter::rd`) — acercando el instante de muestreo al ciclo real. Medido contra `mesen`
> (estructura de luminancia) en 6 ROMs: **neutro total** (metalstorm 14.2%, gemfire 34.2%,
> smb 3.1%, bf/dk 0.0%, ic 92.2%, idénticos al baseline). Confirma que el problema **no es
> el valor/instante del flag**, sino la **resolución temporal** (fase CPU↔PPU sub-dot), como
> ya concluía el análisis previo. Revertido; sin regresiones.
>
> **Resultado negativo 2026 (acotado por traza).** Con `trace_diff` sobre las ROMs de mappers
> nuevos: **VRC6** (Akumajou: divergimos en el bucle y mesen ya en el NMI), **AxROM**
> (Battletoads: `LDA/BPL` de espera), **FME-7** (Mr. Gimmick: `LDA/BPL` de espera) → **los tres
> divergen por la misma causa** (timing de VBlank/NMI), no por bugs de mapper. Igual que MMC5.
> Es decir: **un solo límite** transversal a todos los mappers nuevos.
>
> **Resultado negativo 2026 (quirk `_preventVblFlag`).** Se intentó alinear la semántica con
> mesen: levantar VBlank en **`(241, dot 1)`** (en vez de al entrar en la 241) y sustituir la
> máscara `(241, dot<3)` por el quirk real `_preventVblFlag` (leer `$2002` en `(241, dot 0)`
> impide el flag ese frame). Mejoró la **traza** (desapareció el re-sync `O+7944` de Uncharted: el
> bucle `$F506-$F50F` deja de perder un frame) pero **regresó** `blastermaster` (0.0→9.1%) y
> `jurassicpark` (0.0→13.7%) al mover `nmi_occurred` 1 dot → cambia el *interleaving* del NMI.
> Uncharted **no mejoró** (sigue 45.8%; su divergencia de frame es de **render/CHR**, no de timing,
> ver `COMPATIBILITY.md`). **Revertido**; confirma que el fix exige subdivisión **ciclo a ciclo**.
>
> **Resultados negativos previos 2026 (acotan el problema).**
> 1. **La fase es neutra.** Con Fase 2 activa (no-snap), adelantar la **fase del PPU en el reset**
>    (`-DN2A_PPU_PHASE=0/5/7/9/10/12`) es **neutro total** (idx 43447): la lectura y el flag son
>    función de la fase → cualquier desplazamiento mueve los dos por igual → la relación
>    lectura↔flag es **invariante a la fase**.
> 2. **Leer `$2002` antes del tick** (`-DN2A_VBL_READ_BEFORE_TICK`, muestrea 3 dots antes) también es
>    **neutro**: el cambio es de −3 dots y la lectura está **~11 dots antes del flag** (línea 240
>    dot ~330 vs flag en 241 dot 0).
> 3. El **adelanto del flag** (lookahead 3/6/16) es neutro o **rompe el arranque**.
> **Conclusión**: el fix exige desplazar la **lectura respecto al flag** (+~11 dots), no la fase ni
> el flag; y debe hacerse de forma que **no rompa el arranque** (los bucles de espera del reset).
> El mecanismo exacto (por qué el hardware/mesen muestrea ahí) requiere modelar el **instante del
> acceso de datos** con precisión — es el núcleo de Fase 3+4.

En el intérprete, para la instrucción que **lee `$2002`** (según su *addressing mode*), calcular el
**ciclo exacto del acceso de datos** y evaluar el flag con la PPU en **ese** dot (no en el
siguiente). Es el punto que hoy desplaza el bucle `LDA $2002; BPL`.
*Verificación*: `trace_diff` de los 6 juegos → la primera divergencia debe desaparecer del bucle de
VBlank; `gate` sin regresiones.

### Fase 5 — NMI con modelo *half-cycle*
Muestrear el NMI en la **fase 2 del último ciclo** de la instrucción que cruza el dot 1 de la 241
(modelo que usan los emuladores que pasan `vbl_nmi_timing`), en vez de "al final de instrucción".
*Verificación*: los 6 juegos bajan de % (idealmente a ~0) en `port_matrix`.

### Fase 6 — Cierre
Re-tag `oracle-v2.1`, regenerar `port_matrix.baseline` + `COMPATIBILITY.md` + snapshot, y retirar de
`RISKS.md` el límite (pasa a "resuelto", con enlace a este roadmap).

## Valoración del esfuerzo (2026)

**El timing es lo ÚNICO que queda.** Verificado con trazas: los 6 juegos no-0 del oráculo
(`ic` 92.2%, `galaga` 36.7%, `metalstorm` 14.2%, `jurassicpark` 13.7%, `pacman` 13.2%,
`blastermaster` 9.1%) **todos** divergen en el **mismo bucle `LDA $2002/BPL` del arranque**
(p. ej. blastermaster, `$F250`, idx 7828). El resto de la matriz (65/71) está a **0–3.6%**.

- **Coste hasta ahora**: alto (~8 turnos) y **0 puntos de % ganados** (todo neutro o revertido).
  El timing es genuinamente difícil: requiere el **lockstep completo** (frontera de frame
  **sub-instrucción** + fase continua + IRQ MMC3 por ciclo), no un ajuste de fase/flag/dot.
- **Lo ganado (indirecto pero real)**: el **tracer de fase** (permanente), el hallazgo de que la
  **Fase 2 estaba incompleta** (`ppu.dot=0` incondicional), la **unificación** de los 6 juegos de
  VBlank con los de raster MMC3 en **una sola causa**, y que el **no-snap es equivalencia-safe**.
- **Perspectiva**: como **no queda nada más** en el oráculo, **sí merece la pena** perseguirlo —
  pero como **tarea dedicada** (Fase 3), no mezclado con el trabajo de mappers (donde el % por
  turno era muy superior: 38→71 ROMs en pocos turnos).

### Fase 3 (2026): la fase es CONSTANTE (+4 dots) — no hay deriva

Tras Fase 1+2, medido con el tracer de fase: el **dPPU es CONSTANTE** (`+345` raw ≈ **+4 dots**
alineados) a lo largo de miles de instrucciones hasta la divergencia. Es decir, **la fase del PPU
NO deriva** — es un **offset fijo pequeño**. Afinar el **dot del reset** (`N2A_RESET_DOT=26/28/30`)
mueve la primera divergencia de metalstorm de idx **16336 → 43443** (mejor) pero **no la elimina**.
→ El "largo de frame variable" (29778-29783) es del lado **CPU** (instrucciones por `run_frame`),
no del PPU (que es continuo). El residuo real es un **offset de ~+4 dots** entre nuestra fase y la
de mesen (probablemente su `_ppuOffset`/`StartCpuCycle`). **No es el lockstep**: es un ajuste fino.

**Intentos de cerrar el offset (2026), con resultado:**
- **Flag de VBlank en `(241,1)`** (como mesen `PPU.cpp:1257`) → **REGRESIONA** jurassicpark
  (0.0→13.7%) y **rompe el `ppu_test`**. Nuestro flag en `(241,0)` es el **correcto** (con nuestro
  modelo de avance). Revertido.
- **Reset-dot** (`N2A_RESET_DOT` = 25..30, +1..+6 dots) → mueve la primera divergencia de metalstorm
  de idx **16336 → 43443** (mejor) pero **no la elimina**. Es un ajuste parcial, no el cierre.
- **Compensación +4 dots** (reset en dot 28, `_masterClock - _ppuOffset` de mesen) → **REGRESA
  blastermaster** (0.0→9.1%); el dot **natural (24)** es el mejor. Revertido.
→ Ningún ajuste de fase mejora **sin** regresar un juego ya a 0.0%. El dot natural (Fase 1+2) es el
**óptimo actual**; el residuo es del **modelo exacto de sincronización** de mesen (sub-dot, no un
offset global). Los 4 juegos (ic/galaga/metalstorm/pacman) quedan como límite de **fidelidad de
estado**, no bloqueante.
→ El offset exacto requiere **replicar el modelo de reset/ciclo de mesen con precisión de sub-dot**
(`_ppuOffset`/`StartCpuCycle`/`EndCpuCycle`), no un ajuste ciego. **No** se ha logrado cerrar del todo;
los 4 juegos (ic/galaga/metalstorm/pacman) siguen.

### ✅ Fase 1+2 JUNTAS — WIN (2026)

Implementadas **Fase 1 (PPU dot a dot)** **y Fase 2 (fase continua, dot sin resetear)**:
- **jurassicpark 13.7% → 0.0%** (el raster MMC3). Antes el dot-continuo *solo* regresionaba
  jurassicpark; **con el dot a dot** el IRQ A12 se dispara en su dot exacto y **se arregla**.
- **El primer bucle de VBlank de metalstorm ALINEA** (desaparece el `resync #0`; la primera
  divergencia pasa de idx 7828 a **16336**, el *segundo* bucle).
- Sin regresiones: `gate EXIT=0`; bf/dk/megaman3 a 0.0%; contra 0.9%; smb3 0.4%.

**Lo que queda**: la **deriva entre frames**. El largo de frame **varía** (29778–29783 ciclos,
media 29780.6 correcta) porque la **frontera de frame se cierra en frontera de instrucción**, no
en el dot exacto. Esa varianza hace que el *segundo* bucle de VBlank (y siguientes) diverjan.

### Diagnóstico de Fase 3 (2026): el dot-continuo acerca pero regresa por el IRQ

Con **dot-continuo** (Fase 2 completa) y `trace_diff` de **jurassicpark** vs mesen: el bucle de
VBlank `$E509` deja de estar "1 iteración tarde" y pasa a **alternar** (`O+0 R+2` / `O+2 R+0`) —
es decir, la fase queda **casi alineada**. **Pero** el **%** de jurassicpark regresa (13.7→16.6%):
el **IRQ de raster de la MMC3** (que se pide en el dot `kA12Dot` de cada línea) se desplaza con la
fase y su reparto de pantalla se desalinea. → Confirma que **Fase 2 completa y Fase 3 (IRQ MMC3 por
ciclo) deben hacerse juntas**: el dot-continuo por sí solo alinea el VBlank pero **rompe** el raster.

## Orden de valor / riesgo

| Fase | Valor | Riesgo | Toca |
|---|---|---|---|
| 0 (diag) | alto (desbloquea) | nulo | `dbg_fast2` |
| 1 (dot a dot) | alto | medio | `nes_ppu.hpp`, `clock_ppu` |
| 2 (frontera+residuo) | alto | **alto** | `run_frame`, fast executor |
| 3 (scheduler) | alto | alto | `step_block`, fast executor |
| 4 (`$2002` exacto) | **muy alto** (los 6 juegos) | medio | `nes_interpreter.hpp` |
| 5 (NMI half-cycle) | medio | bajo | `nes_system.hpp` |

**Estrategia sugerida (revisada tras el experimento de Fase 1)**: 0 → **4** (mayor valor directo:
los 6 juegos) → **1+3 juntas** (dot a dot **con** el scheduler, para no perder rendimiento) → 2 → 5 →
6. Cada fase es un commit con `gate` verde; si una fase no mueve la aguja sin regresiones, se revierte
y se anota (como con Fase 1 sola).

## Relación con el port Amiga

El runtime Amiga usa **hardware** (Copper/Blitter/Paula), no este sincronismo. El roadmap mejora la
**fidelidad del oráculo** (referencia fiable para validar el port), no el runtime Amiga en sí. Es la
condición para poder validar juegos sensibles al timing contra el port.

### Caso concreto: siembra del RNG de Donkey Kong (2026) — manifestación del mismo límite

El port de DK (piloto) topa con este mismo límite, no con un bug propio:

- El LFSR de DK (`$F4ED`, llamado con `JSR $F4ED` desde el spin `$87E1`) computa
  `feedback = bit1($18) XOR bit1($19)` en el temporal **`$00`**, y rota `$18..$1F`.
- **La semilla no-cero del oráculo nace de un *race* NMI↔LFSR**: el NMI interrumpe `F4ED` entre
  `$F4F1` y `$F4F3`; el handler NMI ejecuta `C8E0: STA $00` con `A=0x1A`, **machacando `$00`**. Al
  reanudar en `F4F3`, `$00=0x1A` entra en el `EOR` → `feedback=1` → `$18: 00→80` (semilla). Trazas:
  `_scratch/host/oracle_seed6.cpp` (PCs `C8F2=RTI, F4F3…`, `$00=1A`), `oracle_f4f9*.cpp`.
- **El port ejecuta el NMI inline** en la frontera (no asíncrono) → `F4ED` **nunca** se corta a
  mitad → `$00=0` → el LFSR **se queda en 0**. Reproducirlo exige modelar el **aterrizaje exacto del
  NMI dentro de la rutina** (sub-instrucción), igual que los 4 juegos del límite.
- **Decisión**: no falsear el RNG. La directiva `rng` (LFSR O(log K)) es **determinista** y no
  captura el *race*; se mantiene como infraestructura para juegos cuyo RNG **sí** sea determinista.
  Para DK, validar el render en tramos sin divergencia del RNG o con el RNG congelado.


