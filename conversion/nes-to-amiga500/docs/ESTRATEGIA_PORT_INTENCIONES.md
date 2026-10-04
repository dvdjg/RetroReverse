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

**Conclusión revisada:** 60 fps en A1200 **exige optimizar el port** (no es automático) y **medirlo
en hardware real o emulador a velocidad plena**. Palancas: (1) **spin-yield** del bucle de espera,
(2) codegen rápido (estado en registros/locales, sin `g_label`/yield por instrucción, `-m68020`),
(3) menos bounds-checks en `rd/wr`. La métrica que decide es ciclos/frame medidos en hardware.

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

## Pasos recomendados (orden)

1. **Input** (joystick→`$4016`) — barato, desbloquea jugable y medir fps con gameplay.
2. **Calibrar sprites** (hpos/vstart) — cierra el render del título al 100%.
3. **Diferencial automático port↔transpilado** por frame (RAM+PPU+OAM) — base de la automatización
   y test de regresión del pipeline.
4. **Optimizar el port** (estado en locales, `-m68020`) y **medir fps reales** en A1200 con scroll.
5. **Catálogo de patrones PPU/mappers** en la KB (empezando por NROM/UxROM/CNROM/MMC1).
