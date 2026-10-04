# Estrategia: port NES→Amiga por **intenciones** (rumbo del desarrollo)

> Documento de rumbo. Recoge el análisis estratégico (2026) sobre viabilidad, alcance y
> automatización del port nativo por intenciones, frente a la versión **transpilada** (emulador)
> que es pixel-perfect en PC pero pesada en Amiga.

## Contexto

- **Versión transpilada (emulador):** corre en PC, es **pixel-perfect** y entiende **todo** el HW
  de la NES y los mappers. En Amiga va mal: emula 6502 por instrucción y PPU por píxel, muy caro.
- **Versión nueva (port por intenciones):** 6502 → C de alto nivel (decompilador) + traducción de
  las **intenciones** del PPU/APU a los motores del engine (tiles/sprites/Copper/Blitter).
  Objetivo: port nativo indistinguible, corriendo a velocidad nativa del Amiga.

## 1. ¿Llega a 60 fps en A1200?

**Sí es plausible para juegos sencillos (NROM: DK, Pac-Man…), pero NO con el port actual sin
optimizar.** Números:

- A1200 = 68EC020 @ **14,32 MHz**. Presupuesto 60 fps ≈ **238.000 ciclos/frame**.
- **El render ya está fuera del 68000:** el BG lo mueve el **Blitter** (metatiles), el **Copper**
  (scroll/paleta/splits) y los **sprites HW** por DMA, en paralelo a la CPU. A la CPU le queda la
  **lógica del juego + orquestación** (recomponer los pocos metatiles que cambian, subir la OAM…).
- DK ejecuta ~**29.800 ciclos 6502/frame**. La versión decompilada elimina el coste de emulación;
  si la lógica nativa cuesta ~5–10 ciclos 68000/op y hay ~10–20k op/frame → **50–200k ciclos**,
  justo en presupuesto. Optimizada (estado en locales/registros, `-m68020`) → **60 fps**.
- **A500 (7 MHz):** 60 fps improbable; 25–30 fps realistas (jugable). A1200 es el objetivo de 60.
- **Juegos complejos** (MMC1, mucho estado): A1200 probablemente **30–50 fps** sin HLE de rutinas
  calientes.

**Veredicto:** 60 fps en A1200 para NROM simple **es alcanzable**; depende de **optimizar el port**
(hoy el `.exe` es ~1,1 MB y el estado vive en memoria), no del modelo de intenciones.

## 2. ¿Cuánto falta para algo funcional?

Hecho: lógica del port correcta (== oráculo), BG por tiles (Blitter y X-limited), scroll por
Copper, atributos/paletas, rebuild dinámico de pantalla. Falta, por impacto:

1. **Sprites HW** — cableados; calibrar **posición/paleta** (título: asterisco; gameplay:
   Mario/barras/fuego).
2. **Input** — joystick/teclado → inyectar en la RAM del port (`$4016`). Barato; desbloquea
   “jugable”.
3. **Sincronía del bucle** — la “divergencia resumible”: para un port nativo basta **equivalencia
   por frame** (NMI/frame, spin del main), no ciclo-exacto. Resolver para gameplay largo.
4. **APU → Paula** — opcional para MVP.
5. **Optimización** (60 fps) + compactar código para A500.

**Estimación:** el **título** está resuelto; un **gameplay NROM simple** (DK: correr/saltar/barras)
con sprites+input es lo siguiente y abordable en pocos turnos enfocados. La **generalización** a
muchos juegos es el grueso.

## 3. ¿Juego por juego o base de conocimiento?

**Híbrido, muy a favor de la automatización en el núcleo.**

| Capa | ¿Automática? |
|---|---|
| 6502 → C (decompilado) | **Sí**, genérica. |
| Mappers (NROM/UxROM/CNROM/MMC1/…) | **Sí** (conjunto acotado, se implementan una vez). |
| **Intenciones PPU** (nametable→tiles, OAM→sprites, scroll, paleta) | **Sí para el caso común.** |
| **Efectos especiales** (raster mid-frame, CHR banking, MMC5, framebuffer en PPU) | Casos, pero **patrones reconocibles** → KB. |
| APU → Paula | Genérico + casos (envelopes/DMC). |

**Ventaja clave:** la versión **transpilada es el oráculo perfecto** → validar automáticamente cada
port decompilado contra ella (diferencial por frame de RAM+PPU+OAM). Pipeline ideal:

1. Decompilar (automático) → 2. Inferir intenciones PPU/APU (reconocedores + catálogo) → 3.
**Diferencial contra el transpilado** → 4. si diverge, marcar patrón desconocido y añadirlo a la
**KB**.

Cada juego nuevo automatiza el 80–90%; solo aporta “patrones raros”. No es “juego a juego desde
cero”, sino **KB creciente + casos**.

## Estado del hilo (progreso)

- **Input: HECHO.** El HAL del port modela el mando NES (`$4016/$4017` strobe+shift) con accessor
  `n2a_set_pad`; los demos leen el joystick Amiga (`eng::amiga::poll_input`) y lo mapean.
  Verificado en host: con **Start** el juego avanza del título al gameplay; sin input se queda.
- **Diferencial port↔oráculo: HECHO** (ctrl+nametable+atributos+RAM+OAM, `_scratch/cmp_state.sh`).
  Nametable/atributos **idénticos**. La **RAM diverge en ~12–14 líneas** (de 128) de forma
  **acotada y estable** (no crece): consistente con el **PRNG / nº de iteraciones del bucle
  principal** (timing del frame), no con un bug de render. Para el título es cosmético; para
  fidelidad de gameplay hay que alinear el modelo de frame.
- **Sprites HW: cableados** (OAM→8 canales, subpaleta, DATA de la pattern table de sprites,
  COLOR16-31). **Posición/paleta pendientes de calibrar** (se ve un sprite desplazado); queda tras
  `kSpritesOn=false` en el demo XL.

## Medición real en A1200 (sin warp) — 2026

Secuencia en tiempo real (emulador `cpu_cycle_exact`, 68EC020 @14,32 MHz): el motor avanzó
**0 → 26 frames en ~8 s ≈ 3,3 fps**. Es decir, el port actual está **~15–18× por encima del
presupuesto de 60 fps** (238k ciclos/frame → usa ~4M).

**Diagnóstico:** el cuello **NO es el render** (BG por Blitter/Copper, sprites HW, todo DMA). Es la
**lógica del port**, y el principal culpable es el **busy-wait del bucle principal**: DK hace
`JSR F4ED; JMP C7E1` (spin) hasta que llega el NMI. En el port, ese spin ejecuta **miles de
iteraciones por frame** (avanzando `tick` hasta el deadline). La NES "espera" así porque no tiene
HALT; un port nativo **no debe** re-ejecutar el spin.

**Optimización clave (prioritaria):** detectar el **bucle de espera** (spin sin I/O cuyo único
efecto es esperar el NMI) y **ceder directamente al límite de frame** (`g_cyc = g_frame_deadline`),
en vez de iterar. Coste: cambia el estado del PRNG que el spin actualiza (divergencia cósmética
ya medida). Es la palanca #1 para acercarse a 60 fps. Otras: estado en locales/registros,
`-m68020`, eliminar bounds-checks en `rd/wr` del HAL.

**Dato clave del port:** el host mide **~8.000 lecturas de bus/frame** (~8k instrucciones 6502).
A ~30 ciclos 68000 por lectura eso cabría en el presupuesto de 60 fps (238k). La brecha real
(~18×) es, o bien **coste por instrucción muy alto** en el codegen actual (estado en memoria,
checks, `g_label`/yield por bloque), o que el **emulador cycle-exact** del host no alcanza la
velocidad real (a confirmar). Ambos demos de port (Blitter y XL) dan el **mismo** ~3,3 fps → el
cuello es la **lógica del port**, no el render.

**Actualización tras el spin-yield:** el trabajo del port bajó de **8071 a 1435 lecturas de
bus/frame** (5,6× menos) — el busy-wait era el 82%. Los **~14,6 fps** medidos (wall-clock, sin
warp) son casi seguro el **techo del emulador cycle-exact**.

**Modelo VBlank-driven (`--vblank`) — HECHO.** El `tick(n)` **deja de comprobar el frame**
(solo acumula ciclos para un modelo hibrido futuro); el NMI lo dispara el **busy-wait** (spin-yield)
y `hal_wait_vblank`. Es la sincronizacion "asistida por hardware" esperada: el frame boundary no
cuesta por instruccion. **Medido (sequence sin warp): ~14,6 → ~22,5 fps** (0→182 frames en ~8 s).
Nametable/atributos == oraculo. El **modelo de ciclos completo sigue disponible** (sin `--vblank`)
para PC/fidelidad/mid-frame; la **hibridacion fina** (contar ciclos solo donde el juego lee
registros dependientes del ciclo) queda como refinamiento.

**Progreso total de fps (A1200 emulado, sin warp): 3,3 → 14,6 (spin-yield) → 22,5 (VBlank).**

Palancas restantes (menores ya): bounds-checks en `rd/wr`, `-m68020` (arreglando el startup),
hibridacion fina. La metrica que decide es **ciclos/frame en hardware real**.

## Optimización: intentos y lecciones (2026)

- **Spin-yield: HECHO y FUNCIONA (~4,4× en A1200).** Detección `decomp_wait_loop` (sigue los
  sucesores incondicionales; un ciclo sin salida condicional = bucle infinito solo salible por
  NMI). En el back-edge del busy-wait se emite: `if (g_cyc + 2000u < g_frame_deadline) { g_cyc =
  g_frame_deadline; frame_event(); }` y se salta al header del bucle, cuya entrada cede la REGIÓN.
  Llamar a `frame_event` **directamente** (no vía una llamada anidada) evita que el yield se
  consuma en el anidado. **Resultado medido (sequence sin warp): de ~3,3 a ~14,6 fps** (0→120
  frames en ~8 s); nametable/atributos del port siguen **== oráculo**.
- **`-m68020` para A1200: NO arranca** (el runtime/startup del engine no es 68020-limpio). El build
  vuelve a `-m68000`. Pendiente: limpiar el startup/shim para 68020 y reactivar (mejor codegen).
- **Medición no-warp puede estar limitada por el emulador cycle-exact** (host); conviene medir en
  hardware real o afinar el emulador antes de concluir cifras finas.

## Objetivo de fps: **50 (PAL)** (no 60)

La NES es 60 Hz (NTSC) pero el objetivo es **PAL = 50 fps**. El bucle del engine
(`run_frames_polling`: `update → wait_vblank → render`) queda **sincronizado al VBlank de la PAL
(50 Hz)**: 60 fps sincronizados son **imposibles en PAL**. Objetivo realista y correcto: **50 fps**.

## Aislamiento de costes (A1200 + Kickstart 3.1, sin warp)

Pruebas con flags de test (`kRunPort`, `kDoCompose`, `kScrollTest`):

| Configuración | fps |
|---|---|
| Port ON, render normal (scroll) | ~22 |
| Port ON, **scroll OFF** | ~21 |
| Port ON, **compose/install SALTADO** | ~22 |
| **Port OFF** (solo render) | ~45–50 |

**Hallazgos (medidos):**
1. **El render X-limited es DESPRECIABLE**: saltar `compose`/`install` no cambia el fps (~22). El
   compositor reemite ~40 MOVEs/frame (<1 ms). **No es el cuello.**
2. **El scroll es despreciable**: activarlo o no da lo mismo (~21 vs ~22).
3. **El PORT es el cuello real**: apagarlo sube a ~45–50. El port añade **~22 ms/frame**
   (~320k ciclos) ≈ 100 ciclos por instrucción 6502 (codegen ingenuo: estado en memoria, checks,
   dispatch por bloque).
4. **Descartado el techo del emulador**: relajando el modo `cycle_exact`+`cpu_memory_cycle_exact`+
   `blitter_cycle_exact` (`WINUAE_NO_CYCLE_EXACT=1`) la medición da **el MISMO ~22 fps** → el
   emulador NO es el límite; el **port sí** (su trabajo, ~23 ms, supera el frame PAL de 20 ms).
   Es decir: **el port queda justo por encima de 50 fps**; una mejora de codegen de **~1,5×** lo
   metería dentro del frame.

**Conclusión:** optimizar el render no ayuda; el trabajo está en **la lógica del port** (codegen).
Meta: bajar el port de ~22 ms a ~<8 ms para que junto al render (~20 ms de VBlank) quede holgado en
el frame de 50 fps.

**Inferencia de intenciones (codegen), hecha:**
- **Fusión `CMP #imm` + rama**: si el `CMP/CPX/CPY` inmediato precede a una rama que lee sus flags,
  se emite **C directo** (`if (A == n)`, `if (A < n)`, `if (((u8)(A-n))&0x80)!=0`…) y se **omite
  el CMP** (no se simulan flags). Aplicada a **429 ramas** en DK; nametable == oráculo. **Efecto
  medido ~0** (el emulador tiene ±2 fps de ruido y la ganancia es de pocos %).
- **DCE de flags por VIVACIDAD** (el punto clave: no generar `setnz` que no se va a leer): analisis
  backward por bloque (con la rama del terminador); `setnz` de flags no vivos se OMITE. Resultado en
  DK: `setnz` **3853 → 1411 (−63%)**; nametable == oraculo; **fps 21,2 → 22,9 (~+8%)**.
- **`flatten` (inlinar el grafo para A/X/Y en registros): DESCARTADO** — build 14m42s y el binario
  **no arranca**. Buscar otra vía para los registros.

**Micro-optimizaciones probadas (poco/nulo efecto medido — el emulador domina el ruido):**
- Quitar el `g_step_limit` de `rd`: ~0%.
- En modo VBlank, `tick` → no-op (y `hal_wait_vblank` sin `g_cyc`): deja `g_cyc` sin leer → el
  compilador lo DCE; ~0% medido. El coste del port está repartido entre `rd`/`wr` (accesos de bus),
  la operación + flags por instrucción y el dispatch por bloque (~100 ciclos/instrucción) — no en
  un único sitio. **Atacarlo de verdad requiere A/X/Y en registros locales y menos checks por
  instrucción** (cambio amplio del codegen).

## Setup de máquinas (Kickstarts) para probar A1200/A4000/CD32

Descargados desde `archive.org/download/commodore-amiga-firmware` a `C:\Amiga` (512 KB c/u):
`KICK_A1200.rom` (v3.1 r40.068), `KICK_A4000.rom` (r40.068), `KICK_A500_31.rom` (r40.063, A500/A600/A2000),
`KICK_CD32.rom` (r40.060) + `CD32_EXT.rom` (Extended-ROM). A500 1.3 ya estaba (`KICK13.rom`).

Ejecución:
```
WINUAE_QUICKSTART=a1200,0 WINUAE_KICKSTART=c:/Amiga/KICK_A1200.rom \
  ./tools/run/run-demo.sh demos/nes/dk_port_xl --config A500_release
```
- `patchConfig` (run-demo.ts) fija `cpu_model=68020` + `fpu_model=none` para quickstarts a1200/a4000
  (con un Kickstart 1.3 el quickstart podía no fijar la CPU).
- **Verificado**: el build A500 (68000) arranca en A1200 real (3.1) → READY y render correcto.
- **Pendiente**: el build `TARGET_MACHINE=A1200` con **`-m68020` NO arranca** (state=1, cuelga en
  init) aunque el mismo config con el build 68000 sí. Es un problema del **código generado con
  `-m68020`** (o del startup/shim del engine en 68020), a depurar. Mientras, A1200 usa el build
  68000 (compatible con el 68020).

## Pasos recomendados (orden)

1. **Input** (joystick→`$4016`) — barato, desbloquea jugable y medir fps con gameplay.
2. **Calibrar sprites** (hpos/vstart) — cierra el render del título al 100%.
3. **Diferencial automático port↔transpilado** por frame (RAM+PPU+OAM) — base de la automatización
   y test de regresión del pipeline.
4. **Optimizar el port** (estado en locales, `-m68020`) y **medir fps reales** en A1200 con scroll.
5. **Catálogo de patrones PPU/mappers** en la KB (empezando por NROM/UxROM/CNROM/MMC1).

## FLAT: A/X/Y/flags en REGISTROS (`--flat`) — IMPLEMENTADO y MEDIDO (~2x)

**Qué es.** `--flat` colapsa el grafo a **una sola función** `n2a_run()` con A/X/Y/flags como
**locales** (candidatos a registro): los `JSR` apilan `&&L_<retorno>` en una pila de punteros y
hacen `goto` al target; los `RTS` hacen `goto *pila[--sp]` (goto computado de GCC). Sin llamadas C,
el compilador ya puede cachear el estado 6502 en registros (con globales no puede: `ram[]` puede
aliase bajo `-fno-strict-aliasing`).

**Por qué era necesario.** El port no-flat cuesta ~7-10 instrucciones 68000 por instrucción 6502
(~120 ciclos) porque A/X/Y/flags son globales y se recargan tras cada acceso a RAM. La causa raíz
de la lentitud del port.

**Escollos resueltos (todos reales, el port colgaba sin ellos):**
- **`setnz` como función de fichero NO sirve en flat**: el nombre `Zf`/`Nf` se resuelve
  **léxicamente al global** aunque la función se inline (`always_inline` no cambia el binding) → el
  código dentro de `n2a_run` leía los Zf/Nf **locales** mientras `setnz` escribía los **globales**.
  Síntoma: el bucle de copia a `$2007` (`$F211-$F214`) **nunca terminaba** (X se decrementaba pero
  la salida Zf estaba desincronizada). Fix: emitir las flags **inline en el punto de uso**; cubrir
  las 3 emisiones directas (`CMP/CPX/CPY`, `INC/DEC mem`, `ASL/LSR/ROL/ROR`).
- **NMI**: `frame_event` (HAL) llamaba al NMI como **función** `f_C85F`, que en flat no existe (es
  un bloque). Fix: `frame_event` marca `g_nmi_pending` y `n2a_run` entra al NMI **inline** por la
  pila de retorno (`&&L_nmiret`). Se limpia `g_yield_req` antes de entrar para que el NMI corra
  **hasta completarse** (la pila es local: ceder a mitad la perdería) y se **rearma** al volver.
- **Arranque**: el primer bloque emitido NO es el reset → `if (g_resume==0) goto L_<reset>`.
- **Labels duplicados**: un mismo bloque pertenece a varias regiones → emitir cada uno UNA vez.
- **Resume**: la tabla `kRL` de `&&label` + **búsqueda binaria** (un `switch` de miles de casos
  desborda la tabla de salto m68k: "switch too large").
- **`RTS` ajusta SP; `RTI` no** (el NMI se modela como evento, sin push), igual que en no-flat.
- **Ruta `N2A_TRACE_LABEL`**: faltaba el terminador `u;` (código generado no compilaba).

**Validación.** Nametable + tabla de atributos + **OAM idénticos** al no-flat (dump de 120 frames,
`_scratch/host/port_dump.cpp`); solo divergen ~6 líneas de cero-página (el PRNG/timing ya conocido).

**Medición (decisiva).** `dk_port_xl`, A1200 (68020, 14 MHz, `cycle_exact=false`), mismo emulador y
misma métrica (`tools/debug/measure-fps.mjs`), A/B limpio:

| Build | fps emulados | ciclos/frame | campos/frame |
|---|---|---|---|
| No-flat | 6.98 | 1 018 398 | 7.18 |
| **Flat** | **13.59** | **521 988** | **3.68** |

→ **×1.95** (los ciclos por frame casi se parten por la mitad). El flatten **funciona**.

**Lo que falta para 50 fps.** El presupuesto de un frame es `CPU_HZ/50` = 141 875 ciclos (base 7 MHz)
o 283 751 (base 14 MHz); el flat usa 521 988 → falta **~1.8-3.7×** más. La palanca clara es el
**bucle de upload a `$2007`** (≈87 % del coste del port, `$F211-$F214`: `LDA (zp),Y; STA $2007;
DEY/DEX; BNE`): reconocerlo como **copia a VRAM por vector** (no byte a byte) reduciría ese 87 % en
~un orden de magnitud → el objetivo 50 fps pasaría a ser alcanzable. Es el step 3 (codegen idiomático).

**Nota de calibración.** `measure-fps.mjs` fija `CPU_HZ=7 093 790` (A500). En A1200 (14 MHz) el
contador marca 2× → el fps **real** podría ser 2× el de la tabla (~27 fps flat). La **relación**
flat/no-flat (×1.95) es robusta en cualquier caso.

## HALLAZGO (descomposición del coste): el cuello NO es el port, es el REBUILD del demo

Medido con `measure-fps.mjs` en A1200, aislando capas (port OFF/ON, rebuild ON/OFF):

| Escenario (dk_port_xl, flat) | fps emulados | fps reales (×2) | ms/frame |
|---|---|---|---|
| Port OFF (solo render + VBlank) | 24.96 | 50.0 | 20.0 |
| **Port ON + rebuild OFF** | **22.70** | **45.4** | **22.2** |
| Port ON + rebuild COMPLETO (real) | 13.59 | 27.2 | 36.8 |
| No-flat + rebuild COMPLETO | 6.98 | 14.0 | 71.5 |

**Conclusiones:**
1. **El port flat cuesta solo ~2.2 ms/frame** (50→45.4). Está, de sobra, dentro del presupuesto de
   de 20 ms. El codegen **ya no es el cuello**.
2. **El `rebuild_world_from_port()` COMPLETO (demo) cuesta ~15 ms** y se dispara CADA frame en que el
   port ensucia alguna celda del nametable (marcador/animación). Es **el cuello real**.
3. `scene.compose`, el scroll (`kScrollTest`) y `scene.fill` son **despreciables** (port ON, rebuild
   OFF y scroll ON vs OFF: 22.52 vs 22.70 — idénticos).

**La vía a 50 fps NO es más optimización del codegen, sino hacer el rebuild INCREMENTAL en el demo**
(re-blitear solo los metatiles cuyas celdas cambiaron, en vez de reconstruir los 16×15 + dedupe O(n²)
+ `fill_bank` + `scene.fill` completos). Ese cambio recupera ~15 ms → ~45 fps; el ~10 % restante
(port+timer) lo cubre el paso 4 (fusión/DCE) o el ajuste del bucle del engine. El profiler de
bloques del host (253 bloques/frame, `_scratch/host/port_histo.cpp`) confirma que el port ejecuta poco.

## AFINADO: el port es ~GRATIS; el coste es el re-blit del demo, y el scroll era artificial

Medido A1200 (real = ×2 emu), `dk_port_xl`, tras `--flat`:

| Escenario | emu fps | **real fps** |
|---|---|---|
| Port ON + update/re-blit DESACTIVADO | 24.77-24.96 | **~49.5-50** |
| Port ON + rebuild incremental + re-blit | ~17.5 | ~35 |

**Hallazgos:**
1. **El port (flat) es esencialmente GRATIS**: con el re-blit desactivado el demo da ~50 fps reales,
   **idéntico al port apagado**. Su trabajo cabe entero en el VBlank → **hay muchísimo margen**.
2. El coste (~30 %) es el **re-blit del demo** (`fill_bank` + `scene.fill` del anillo completo) cuando
   la pantalla cambia; `update_world_from_dirty()` en sí (drenar la cola) es gratis.
3. **`dirty-on-change`**: el HAL `$2007` ahora solo marca sucia una celda si el valor CAMBIA (antes
   cada escritura marcaba dirty → el port re-subía 256 bytes/frame de una pantalla estática →
   rebuild completo cada frame). Recuperó ~30 %.
4. **Cola de dirty** (`nt_dirty_q`): pop O(1) en vez del escaneo O(0x1000) por frame del modelo
   bitmap.
5. **El port ensucia el nametable ~1 vez cada 120 frames** (dibujado inicial de 1024 celdas;
   `_scratch/host/port_dirty.cpp`). El título de DK **no scrollea** (`scroll_x=0`).

**Corrección de intención (importante):** el demo tenía `kScrollTest` con un **paso artificial** de
2 px/frame (benchmark de rendimiento). Eso producía un scroll horizontal **sin sentido**. Ahora el
scroll sigue los **registros del PPU de la ROM** (`n2a_ppu_scroll_x/y`, de `$2005/$2006`): con la
intención en 0, la pantalla es estática. El scroll hardware XYlimited solo debe engancharse cuando
la ROM lo pide (principio de diseño: la intención manda).

**Conclusión de viabilidad:** el codegen **no** limita; el port tiene margen de sobra. El trabajo
restante es hacer el **re-blit incremental** en el demo (re-blitear solo los metatiles cambiados por
su posición visible, sin `fill_bank`/`scene.fill` completos).

## RESUELTO: re-blit SELECTIVO → 50 fps reales con el port encendido

Método elegido (mejor rendimiento, reutilizando el motor): en vez de `fill_bank`(512) +
`scene.fill`(anillo completo), por cada metatile cambiado se emite **un solo `TileBlockCopy`
interleaved** con `XLimitedPlayfield::add_draw(plan, tx*tileW, ty*block_planes_lines, tx, ty)`
(el mismo contrato que usa `fill`), y se rellena el banco **solo de los metatiles NUEVOS**
(`fill_bank_one`). El mapa (`g_cells`) es indexado por slot del anillo, así que la celda cambiada
`(tx,ty)` coincide con su slot (para el título estático; con scroll se aplica el mapeo de `mapposx`).

- **Herramientas**: CPU = mapa (ya se hacía); **Blitter** = 1 blit 16×16×4 planos por celda
  cambiada (correcto y baratísimo); **Copper NO hace falta** (el compositor solo mueve punteros;
  el engine no usa blits por Copper en el ciclo de escena).
- **Medición (A1200, real = ×2)**: port ON + re-blit selectivo = **24.96 emu = ~49.9 fps**
  (idéntico al port OFF = coste ~0). Antes (rebuild completo): 13.59 emu = 27 fps; incremental
  parcial: ~17.5 emu = 35 fps.
- **Validación visual** (regla de oro): captura del título con el re-blit selectivo = DONKEY KONG
  azul + menú naranja + `©1981 NINTENDO CO.,LTD.` correctos (`_scratch/out/dk_inc.png`).

**Resultado:** el port DK corre a **50 fps (PAL) en A1200 con el port encendido y margen**, sin
optimizar más el codegen. El cuello era el andamiaje de re-blit completo del demo, no la traducción.

## GAMEPLAY: referencia del original + comparación + ajustes

**Método de captura de referencia** (`_scratch/host/`): `oracle_script.cpp` ejecuta el **juego real**
(interprete `n2a::NesSystem`) con **input scripteado** (Start en el frame 90) y vuelca BMP de puntos
singulares; `port_script.cpp` hace lo mismo con el port (host) para comparar el estado PPU. Capturas
en `_scratch/ref/gameplay/oracle_*.bmp` (convertibles con ffmpeg a PNG).

**Comparación oráculo vs port** (hashes de nametable/atributos/paleta/OAM):
- Frames 60–320 (título/select): **idénticos** (nt/at/pl/oa).
- Frame 400 (transición): el port **va unos frames por detrás** (divergencia de timing conocida).
- Frame 500 (gameplay): nt/at/oa **idénticos**; solo difiere el **mirror de la paleta de sprites**
  (`$3F10` etc., que el NES espeja a `$3F00`; el oráculo no lo espeja). La paleta del BG (0–15) coincide.

**Bugs de render encontrados y corregidos en el demo** (`dk_port_xl`):
1. **El demo fallaba al arrancar la partida**: el dirty inicial (1024 celdas del warmup) generaba
   >128 jobs en el re-blit selectivo → desbordaba `kMaxBlitJobs` → el demo se detenía en el título
   (`detail=0xE012`). Fix: drenar las sucias tras el `scene.fill` de init **y** fallback a fill
   completo si hay >56 celdas cambiadas en un frame.
2. **Paleta estática**: el demo horneaba `g_palette` solo en el init (paleta del título) → en gameplay
   las plataformas salían **cian** en vez de magenta. Fix: re-hornear cuando cambia la paleta NES
   (`$3F00-1F`).

**Verificación visual** (`_scratch/out/dk_pal.png`): la partida se renderiza correcta (plataformas
magenta, escaleras, marcador `000000`/`TOP-000000`, bonus `25⇔600`, DK, Mario), coincidiendo con
`oracle_500`. Pendiente: sprites HW (`kSpritesOn=false`, DK/Mario son sprites NES) y los tiles del
borde derecho (columnas extra del anillo).

**fps en GAMEPLAY** (caso pesado): **23.98 emu = real ~48 fps** (295835 ciclos/frame = +0.8 ms sobre
el port apagado). El juego añade poco; queda **justo por debajo de 50** (el trabajo del frame supera
ligeramente el presupuesto del VBlank). Con el título era 49.9. Margen real: pequeño.
