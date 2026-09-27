# Sincronismo de timing en el Amiga (sin emular la PPU en software)

El oráculo/host puede permitirse un PPU **dot-exacto** (corre en el PC). La pregunta es cómo
conseguir ese **mismo sincronismo en un A500 a 7 MHz sin emular la PPU dot a dot**, que sería
inviable. La respuesta es una idea central:

> **El timing no se calcula en runtime: se *compila* y se *ejecuta en los co-procesadores*.**

El Amiga tiene tres recursos que la NES **no** tiene y que están hechos para esto:

| Recurso Amiga | Coste para el 68000 | Uso aquí |
|---|---|---|
| **Copper** (co-procesador de vídeo) | **0** (corre en paralelo) | Reproduce la línea de tiempo de raster (scroll, splits, paleta, punteros) |
| **Beam counter** `VHPOSR`/`VPOSR` | 1 lectura (~8 ciclos) | Responde a `$2002` (VBlank/sprite-0) comparando con constantes *baked* |
| **Sprite hardware + IRQ VBL (nivel 3)** | 0 (salvo el IRQ que el juego ya usa) | Sustituye sprite-0 y NMI/VBlank |

La clave: **el 68000 nunca "emula el PPU"; lee hardware o ejecuta datos precompilados.**

## 1. Idiomas de raster → reconocidos en compilación

El transpilador analiza el 6502 y sustituye los **bucles de sincronización** por primitivas HLE.
Son los únicos puntos donde el juego "mira al PPU", y son pocos y reconocibles:

| Idiomas 6502 | Se convierte en | Coste 68000 |
|---|---|---|
| `LDA $2002` / `BIT $2002` + `BPL` (esperar VBlank) | `n2a_wait_vblank()`: lee el **flag VBL** que pone el IRQ de VBL del Amiga | 2–4 instrucciones |
| `LDA $2002; AND #$40; BNE` (esperar sprite-0) | `n2a_wait_sprite0()`: `WAIT` del Copper en la línea del bob + leer un flag sombra | ~4 instrucciones |
| `LDX #n; DEX; BNE` (retardo por ciclos) | **Retardo precalculado** en compilación (constante) o espera a `VHPOSR` en la línea objetivo | 0 (baked) |
| Lectura de `$2000/$2001/$2005` | Lectura de **registros sombra** actualizados por el Copper/VBL | 1 lectura |

Esto convierte cada "sondeo del PPU" en una operación **O(1)** sobre hardware, en vez de un bucle que
avanza una PPU emulada. Ejemplo (SMB, `$813D`):

```
; NES: bucle que espera a que se borre sprite-0
813D: LDA $2002
8140: AND #$40
8142: BNE $813D
```
```
; Amiga: el transpilador emite (pseudocódigo)
n2a_wait_sprite0()      ; el Copper ya hizo WAIT en la línea del sprite-0 y bajó el flag;
                        ; la rutina solo lo lee -> NO hay bucle de emulación
```

## 2. "El tiempo es dato": soldar la línea de tiempo en una Copper list

El oráculo **dot-exacto del host** (ver §4) graba, para frames representativos, el **guion de
eventos de raster**: en qué línea/dot se cambia el scroll, la paleta, los punteros de bitplanes…
Ese guion se **compila a una Copper list**, que el Copper reproduce **en paralelo** al 68000. El
68000 no gasta un solo ciclo en el timing de vídeo.

- **Estático** (pantalla de título, HUD): la Copper list se genera una vez.
- **Dinámico** (scroll/efectos que dependen del juego): la **capa HLE** (ver [`HLE.md`](HLE.md))
  traduce las escrituras del juego a `$2000/$2005/$2006` en **parches de la Copper list**, no en
  cálculos por-dot. El Blitter mueve los bitplanes; el Copper mueve los punteros.

## 3. El beam counter como reloj gratis

`VHPOSR` da la posición del haz (línea/píxel) **sin coste**. Las constantes de las líneas de evento
(VBlank ≈ línea 241, la línea del sprite-0, los splits) se **precalculan** y se emiten como datos.
Así `$2002` se responde comparando el haz con una constante: no hay PPU que avanzar.

## 4. El oráculo (host) sí es dot-exacto — y es la referencia

Como el PC no tiene el límite del 68000, el host es donde se paga la precisión, para **generar y
validar** lo que el Amiga reproducirá:

- PPU **dot-exacta**: `dot`/`tick_dot`, sprite-0 en su **columna** exacta, VBlank en la línea 241.
- **Pre-reloj por ciclo del acceso a datos** (`NesSystem::ppu_pre_cycles`): una `LDA $2002` ve el
  estado en su ciclo real (el acceso a datos es el último ciclo de la instrucción), no al inicio.
- Comparación frame a frame con `mesen` (`diff_mesen`) y volcado de RAM (`--dump-ram`) para medir.

De aquí salen (a) la validación del renderer Amiga y (b) las **constantes baked** (líneas de eventos)
y la **Copper list** del punto 2.

> **Pendiente (límite conocido):** el sincronismo del 6502 sigue siendo por instrucción (no
> sub-ciclo). Eso deja una deriva de estado de unos bytes en juegos con temporizadores de raster
> (ver [`RISKS.md`](RISKS.md)). En el Amiga esto **también** se resuelve por hardware (§1–3), no
> pidiendo más ciclos al 68000.

## 5. Garantía de "sin caída de rendimiento"

1. **Nada de PPU en software** en el Amiga: el timing vive en Copper/beam/sprite (hardware) o en
   datos compilados. El coste por frame del 68000 es la lógica del juego + unas pocas lecturas de
   registros sombra.
2. **Modo alternativo por juego**: `hardware` (Copper/beam, por defecto) y `software` (exacto pero
   lento, solo para validar). Si un juego necesita un timing que el mapeo hardware no cubra, cae al
   modo software (raro).
3. **Medición**: se compara el coste del camino HLE (beam/Copper) contra una PPU software de
   referencia; el objetivo es que el HLE **elimine** el trabajo por-dot, no añadirlo.

## 6. Resumen

| Necesidad del juego | Dónde se resuelve | Coste 68000 |
|---|---|---|
| VBlank / NMI | IRQ VBL del Amiga | ~0 (el juego ya lo usaba) |
| sprite-0 (temporizador de raster) | sprite HW + `WAIT` del Copper + flag sombra | O(1) |
| Splits / scroll / paleta por línea | **Copper list** (baked o parcheada por HLE) | 0 |
| Retardos por ciclos | precalculados en compilación | 0 |
| Lecturas de registros PPU | registros sombra | 1 lectura |

## 7. Reconocedor de idiomas (prototipo) y resultados

[`tools/transpiler/src/raster_idioms.cpp`](../tools/transpiler/src/raster_idioms.cpp) escanea la PRG
y localiza los tres idiomas (VBlank / sprite-0 / retardo) con sus direcciones, para **cuantificar**
lo que habrá que mapear a hardware. Escaneo lineal (sin seguir el flujo), así que puede haber algún
falso positivo; sirve como cota.

```
nes_transpiler build ... (compilar raster_idioms)
raster_idioms build/*.nes
```

Resultado con las 13 ROMs de prueba:

| ROM | VBlank | sprite-0 | retardos |
|---|---:|---:|---:|
| smb | 2 | 2 | 8 |
| bf | 4 | 0 | 8 |
| dk / dkjr / popeye / ic | 0 | 0 | 7–11 |
| exb | 0 | 2 | 16 |
| kungfu | 0 | 3 | 10 |
| galaga | 2 | 0 | 8 |
| mariobros | 1 | 0 | 10 |
| mspacman | 2 | 0 | 4 |
| pacman | 4 | 0 | 2 |
| xevious | 1 | 0 | 9 |

**Lectura:** cada juego tiene un **puñado** de idiomas (≈10–20 en total, 0–4 de cada tipo). Es
decir, el mapeo a hardware no necesita un motor genérico: basta con **reconocer ~15 patrones por
juego** en compilación y emitir las primitivas. En SMB, por ejemplo, el sprite-0 de `$813D` (el bucle
que lo colgaba al principio) es uno de los dos detectados. Esto valida que la estrategia es
**acotada y tratable**, no un problema abierto.

### Primitivas objetivo (contrato)

El reconocedor alimenta la emisión de estas primitivas (interfaz; implementación host ya disponible,
Amiga pendiente):

| Primitiva | Host (prototipo) | Amiga (futuro) |
|---|---|---|
| `n2a_wait_vblank()` | lee el flag de VBlank del PPU software | lee flag sombra / IRQ VBL |
| `n2a_wait_sprite0()` | usa `ppu.sprite0_line` | `WAIT` del Copper + flag sombra |
| `n2a_delay(n)` | `n` ciclos emulados | retardo baked (compilación) / `VHPOSR` |

## 8. Presupuesto y cobertura HLE (medido)

[`runtime/tools/bench_hle.cpp`](../runtime/tools/bench_hle.cpp) mide, por frame, los ciclos de CPU
6502 gastados y el ratio HLE (escrituras de PPU resueltas por el clasificador, candidatas a
Copper/Blitter en el Amiga):

| ROM | ciclos 6502/frame | vs NTSC 29780 | vs PAL 33247 | ratio HLE |
|---|---:|---:|---:|---:|
| smb | 29668 | 100% | 89% | **90.0%** |
| bf | 29669 | 100% | 89% | **95.6%** |

**Lectura:** el juego usa prácticamente todo el frame NTSC de CPU (como es de esperar: el 6502 iba
al límite). En el Amiga, ese trabajo se reparte entre el **68000** (la lógica transpilada) y el
**Copper/Blitter** (el ~90–96% de escrituras de PPU que clasifica el HLE) — que corren **en
paralelo**. Es decir, cuanto mayor sea el ratio HLE, más trabajo de vídeo se saca del 68000. El
modo software (PPU en 68000) queda solo como red de seguridad.

La idea audaz, en una frase: **"compila el tiempo y que lo toque el Copper"** — el 68000 solo corre
la lógica del juego.
