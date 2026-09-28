# Catálogo de optimizaciones propuestas (codegen + runtime Amiga)

Ideas para seguir acelerando el código transpilado, ordenadas por relación valor/riesgo. Complementa
[`CODEGEN_AMIGA_CHAIN_ROM.md`](CODEGEN_AMIGA_CHAIN_ROM.md) (lo ya implementado) y
[`OPTIMIZATION.md`](OPTIMIZATION.md) (VSA/hechos).

## 1. Reconocimiento de patrones e sustitución por equivalentes optimizados

Es la palanca natural de un transpilador: **detectar una secuencia 6502 y sustituirla por la mejor
expresión para 68000/Amiga**. El patrón de implementación es siempre el mismo: *detectar en el
grafo de bloques → emitir/llamar a una rutina equivalente*. Candidatos:

| # | Patrón 6502 | Sustitución | Estado |
|---|---|---|---|
| 1 | `ROR/ROL zp` sobre direcciones consecutivas (PRNG) | `n2a_ror_run`/`n2a_rol_run` (asm `roxr/roxl`) | **hecho** |
| 2 | `LDX #n; DEX; BNE` / `DEY; BNE` (retardo) | retardo *baked* / espera a `VHPOSR` | reconocido (`raster_idioms`), sin sustituir |
| 3 | Relleno/copia `STA (zp),Y; DEY; BNE` | `memset`/`memcpy` en asm o **Blitter** | propuesto |
| 4 | Suma/resta multibyte (`CLC; LDA a; ADC b; STA c; LDA a+1; ADC #0; STA c+1; …`) | `ADDX`/`SUBX` multibyte, o suma de 16/32 bits | parcial (ver §9) |
| 5 | Comparación de 16 bits (`LDA a; CMP #lo; LDA a+1; SBC #hi`) | comparación de 32 bits | propuesto |
| 6 | Multiplicación/división por constante | `lsl`/`lea` / recíproco (g++ ya lo hace) | g++ |
| 7 | LCG/PRNG y su tabla derivada | **memoizar la secuencia** / precalcular | propuesto |
| 8 | `STA $4014` (OAM DMA, 256 B) | Blitter / lista de sprites HW | HLE (F6) |
| 9 | Bucle `STA $2007` (subida de VRAM) | Blitter a VRAM / dirty tiles | HLE (F5) |
| 10 | Lectura de `$2002` (VBlank/sprite-0) | flag sombra + `WAIT` del Copper | HLE (F8) |
| 11 | Escrituras `$2005`/`$2006` (scroll/dir) | `BPLCON1`/punteros + Copper | HLE (F5/F8) |
| 12 | Escrituras de paleta `$3F00` | `COLORxx` (Copper) | HLE (F5) |
| 13 | `JMP (ind)` sobre tabla fija | *jump table* pequeña + `computed goto` | propuesto |
| 14 | Bucle con contador constante (VSA) | desenrollar + `dbra` | parcial (hechos) |

**Nota de método:** cada sustitución debe ir con **prueba de equivalencia** (exhaustiva si el dominio
es pequeño; *differential testing* masivo si no) y con un **criterio de aborto**. Los *bugs* visibles
del original **se reproducen**, no se "arreglan" (`OPTIMIZATION.md` §4).

## 2. Estado del 6502 y estructura del código (item 1)

El cuello actual es que `A/X/Y/P/flags` viven en el `struct CPU` y **cada bloque es una función**:
GCC no los mantiene en registros entre bloques y materializa flags a bytes. La **liveness de `Z/N`**
ya recorta parte; falta el paso estructural.

### 2.1 *Flattening* por región con tabla de retorno

- **Particionar el CFG en regiones**: componentes maximales conectados por aristas **estáticas**
  (caída/rama/`JMP`). Entradas de región: `reset`/`NMI`/`IRQ` y **destinos de `JSR`**. Si un bloque
  es alcanzable desde varias entradas, **duplicarlo** (crece el código) o elegir dueño.
- Emitir **una función C por región** con etiquetas + `goto` para el flujo estático. Dentro de una
  región (miles de instrucciones) GCC puede asignar `A/X/Y/flags` a registros y plegar flags.
- **`JSR`/`RTS`**: un `JSR` a otra región es una llamada C. Para el `RTS` hace falta un retorno
  **dinámico**: como la dirección de regreso del 6502 puede ser modificada por el juego (trampolines
  `RTS`-como-salto, `PLA/PLA/RTS`), la opción robusta es **duplicar/hacer explícito** el retorno
  cuando el análisis lo permita y **caer al despacho** cuando no.
- **Tabla de retorno con `computed goto`**: en vez de la tabla de 256 KB (por eso se descartó
  `--flat`), empujar un **índice** a una tabla de etiquetas (una por sitio de `JSR`; 402 en DK →
  ~1,6 KB) y `RTS` hace `goto *ret_table[idx]`. Mantener en paralelo la pila 6502 para fidelidad.
- **Criterio de aborto**: si un juego usa `RTS`-como-salto o modifica la dirección de regreso, la
  región cae al despacho por bloque (o al intérprete) para esos bucles.
- **Riesgo**: alto (transformación global de control de flujo). Hacerlo **opt-in** (`--regions`) y
  validar con el arnés de equivalencia host de `run.sh`.

### 2.2 Otras vías de estado

- **Runtime de CPU en asm con registros fijados** (el engine ya lo hace para *hot kernels*,
  `OPTIMIZACION_GPP_68000.md` §9): escribir el bucle caliente (p. ej. el PRNG) en `.s` con
  `A/X/Y/flags/RAM/PRG` en registros fijos (~30–50 ciclos/iteración frente a ~1 100).
- **Superbloques / trace scheduling**: agrupar el camino caliente (traza) en una función lineal con
  saltos, reduciendo fronteras de función.

## 3. Compilador y toolchain

- **PGO cruzado**: perfilar la compilación **host** del mismo fuente (`-fprofile-generate`) y usar el
  perfil en el cross (`-fprofile-use`); da probabilidades de rama y *value profiling* gratis.
- **`-mshort` / tipos de 16 bits** donde el rango lo permita (el 68000 es más eficiente en palabra;
  `MULU.W`/`DIVU.W` nativos).
- **LTO + `--gc-sections`**: elimina código muerto (las tablas de despacho de bloques no usados).
- **Alineación/orden de `struct CPU`**: mantener los offsets que usa el asm (`C=6,Z=7,N=11`, `mem=22`)
  y agrupar los campos más usados.

## 4. HLE (hardware Amiga) — el mayor multiplicador

Ver [`HLE.md`](HLE.md), [`PPU_AMIGA.md`](PPU_AMIGA.md), [`COPPER.md`](COPPER.md),
[`SPRITES_AMIGA.md`](SPRITES_AMIGA.md), [`AUDIO_AMIGA.md`](AUDIO_AMIGA.md). En resumen: **sacar del
68000 todo lo que Blitter/Copper/Paula pueden hacer** (tiles, sprites, splits, paletas, audio). El
objetivo es que el 68000 solo ejecute **lógica**, y que el HLE **elimine rutinas completas** (esperas,
retardos, copias, render), no solo escrituras.

## 5. Medición

- **Simulador de ciclos 68000** de instrucciones (sin hardware): dado el `.o` y un perfil de bloques,
  estimar ciclos/frame (el `cyc.ps1` usado para las medidas es un primer paso; formalizarlo en
  `tools/`).
- **WinUAE-DBG** (contador de ciclos del periférico) para el dato real.

---

## 6. Backend nativo estilo descompilador (`--native`) — prototipo medido

> **Reproducir:** `tools/transpiler/tests/gen_amiga_exp.sh [rom.nes]` transpila con `--amiga`,
> `--native` y `--best`, compila a 68000 y ejecuta el arnés de frames; deja las salidas en
> `transpiled/amiga-exp/` (gitignored). Ver su `README.md`.

Motivación: las **micro-optimizaciones** del codegen por bloques compiten con el optimizador global
de g++. Se probó el enfoque contrario: generar **C++ como un descompilador** para que sea g++ quien
optimice.

**Qué emite `--native`** (solo PRG fija y sin opcodes indirectos/ilegales):

- **Una función C++ por REGIÓN** (entrada = `reset`/NMI/IRQ/`JSR`), con BFS por aristas estáticas y
  control de flujo con `goto`. Los `JSR` son llamadas C; los `RTS`, retornos.
- **Estado del 6502 en variables locales** (`a/x/y/sp`, `c/z/n/v/d/i`), no en un `struct` compartido
  con métodos opacos.
- **ROM como literales/array `constexpr`**: `LDA $C1EB` → `0x07`; `LDA $tabla,X` → `PRG_ROM[(0x… + x)
  & (kPrgSize-1)]`. Sin `read` ni `%`.
- Memoria por `n2a_read`/`n2a_write` (stats `inline`, con hooks de E/S); g++ los inlinea y pliega el
  rango para direcciones constantes.
- Entradas exportadas `game_main`/`n2a_nmi`/`n2a_irq` (`[[gnu::used]]`).

**Resultados (DK, GCC 15.1.0, `-m68000 -O3 -nostdlib`):**

| Backend | `.text` |
|---|---:|
| Por bloques (`--amiga`) | ~299 KB |
| **Nativo `--native`** | **76 KB** |

g++ **inlinea toda la región** en sus llamadores y elimina redundancia; el código sale **~4× más
pequeño** y sin el doble tráfico de estado. **Equivalencia host verificada** en `mini`/`branch`/`vsa`
(loops, `JSR`/`RTS`, `ADC`, ramas) con el mismo estado final que el codegen por bloques.

**Ronda 2 (implementado en el nativo):**

- **Cesión por evento**: `N2A_State::yield`; los bucles de espera (`LDA $2002…BEQ self`, `JMP self`)
  ceden al runtime, y `game_main` itera llamando al hook `g_native_yield` (que resuelve
  VBlank/NMI). Entradas `game_main`/`n2a_nmi`/`n2a_irq` exportadas (`[[gnu::used]]`).
- **Arnés de frames** (`tests/native_frame.cpp`): modelo mínimo de VBlank (`$2002` devuelve y
  limpia el bit 7) + NMI por cesión. DK: **60 frames en host, determinista** (`ram_sum=4D999D33`,
  igual en ejecuciones repetidas), ~0,1 ms.
- **Patrón nativo**: tiradas de `ROR/ROL zp` consecutivas → **un bucle** con el carry en una local.
- **Selección de backend `--best`**: usa el nativo si `native_ok()` y, si no, el perfil Amiga
  encadenado. Verificado: DK → nativo; `misc` (con `JMP (ind)`) → bloques.

**Medida estática (DK, `-O3`):**

| Backend | `.text` | instrucciones m68k |
|---|---:|---:|
| Por bloques (`--amiga`) | 298 868 B | 77 901 |
| **Nativo (`--native`)** | **76 404 B** | **16 393** |

**Caveats (lo que falta):**

- El arnés de frames es un **modelo aproximado** (un VBlank por cesión, sin PPU real): valida
  control de flujo, determinismo y RAM, no fidelidad visual. La equivalencia exacta frente al
  intérprete requiere integrar la PPU/runtime.
- Los mappers **bancados** y los **ilegales/`JMP (ind)`** caen al codegen por bloques (`native_ok()`).
- **Medición de ciclos 68000** pendiente: el estimador mapea `bb_*`, no etiquetas nativas. Con el
  nativo inlinado, hay que medir con un **simulador de ciclos** o `-fno-inline` por región.

**Conclusión:** el enfoque descompilador **es viable y prometedor** (deja el trabajo global a g++),
y ya ejecuta frames con cesión por evento y selección automática de backend. La vía de
micro-optimizaciones (`--amiga` + helpers asm) queda como la alternativa de bajo riesgo.

---

## 7. ¿Hasta dónde optimiza g++? (evidencia)

Prueba `probe_const.cpp` (`-m68000 -O3`):

| Caso | g++ 15.1.0 genera | ¿Óptimo? |
|---|---|---|
| `constexpr ROM[índice constante]` en aritmética | `move.b ROM+17575,%d0` (carga de `.rodata`) | **No pliega** a inmediato |
| `constexpr ROM[índice runtime]` | `move.b (%a0,%d0.l),%d0` (indexado directo) | Bien (1 acceso) |
| `(u16)a + (u16)b` | `add.w` | **Limpio** |

**Conclusión:** g++ **no deduce la intención** del 6502; hay que **decirle** qué es:

- **Constantes de ROM:** el backend **nativo ya emite literales** para direcciones absolutas de PRG
  fija, así que ahí sí hay plegado real (mejor que dejar el `.rodata`). Las lecturas **indexadas** no
  pueden ser literales (índice de runtime): quedan como acceso directo al array `constexpr`.
- **Registros grandes:** g++ **no** reconoce que `CLC; LDA lo; ADC #k; STA lo; LDA hi; ADC #0; STA hi`
  es una suma de 16 bits; emite byte a byte. Para usar `add.w/add.l` hay que **reconocer el patrón en
  el transpilador** y emitir la operación en 16/32 bits (ver §1, candidato 4). Regla: *si el
  transpilador expresa la operación en ancho natural, g++ la optimiza; si la expresa byte a byte,
  la respeta byte a byte*.
- **Pila:** el nativo usa `m->ram[0x100+sp]`; g++ no puede mapearlo a la pila del 68000. Se puede
  hacer **solo si el análisis demuestra LIFO puro** (el juego no inspecciona/muta la página `$0100`);
  entonces `PHA/PLA/PHP/PLP` pueden usar registros/la pila C. Si no, mantener la RAM emulada.

## 8. Estado de las validaciones (ronda 3)

- **(1) Nativo vs intérprete:** `tests/native_diff.cpp` (en `gen_amiga_exp.sh [5/5]`) compara RAM a N
  frames. DK 60 frames → **`ram_diff=114/2048`**. La divergencia es de **modelo**: el stub cede un
  VBlank por cesión (no por PPU real), así que el *interleaving* NMI↔bucle no coincide. En las ROMs
  de prueba del transpilador el nativo **sí** da el mismo estado final que el codegen por bloques
  (validez del codegen); la equivalencia exacta de DK exige **conectar la PPU real** al nativo.
- **(2) Ciclos 68000:** pendiente de un **simulador de ciclos** o de compilar con `-fno-inline` para
  atribuir el calor dinámico a las funciones de región. De momento: `.text` e instrucciones estáticas
  (76 KB / 16 393 vs 299 KB / 77 901) y tiempo de host (nativo determinista).
- **(4) Mappers bancados:** verificado que `--best` **cae al codegen por bloques** en MMC1 (Metroid),
  UxROM (Contra) y MMC3 (Mega Man 3) y compila a 68000. El nativo bancado exige ventana conmutable +
  despacho dinámico (trabajo futuro).

---

## 9. Idioms multibyte en el nativo (hecho)

El backend nativo reconoce idioms del 6502 y los emite como operaciones de **16 bits**, para que g++
use `move.w`/`add.w` en vez de byte a byte:

| Idioma 6502 | Emisión nativa | 68000 |
|---|---|---|
| `LDA #k0; STA c; LDA #k1; STA c+1` | dos bytes (g++ los combina) | `move.w #imm,(a)` |
| `LDA zp a; STA zp c; LDA zp a+1; STA zp c+1` | copia 16 bits (`memcpy`, orden de bytes preservado) | `move.w` + **const-propagation** |
| `INC zp lo; BNE skip; INC zp lo+1` (**cruza el `BNE`**) | `++(u16)lo` con flags del 6502 | `addq.w` (o `move.w #imm` si se pliega) |
| `LDA zp a; CMP #k0; LDA zp a+1; SBC #k1` | comparación de 16 bits | `C` = `a>=b`, `A/Z/N` del byte alto |
| `LDX #c; LDA tabla,X` (índice constante, VSA) | **literal** `tabla[c]` | carga inmediata |

- El idiom con rama (`INC lo; BNE; INC hi`) se reconoce **al emitir el bloque** y **absorbe** el
  bloque intermedio (`INC hi`) solo si tiene **un único predecesor** (no se rompe ningún otro camino);
  luego `goto` al `skip`.
- **Endianness (importante):** una palabra 6502 es **little-endian** y el 68000 es **big-endian**. Los
  helpers `n2a_ld16`/`n2a_st16` cargan/guardan la palabra con `__builtin_bswap16` **solo en
  big-endian** (portables: el host little-endian valida la misma semántica). La **copia** usa
  `memcpy` (preserva bytes, sin problema de orden). Sin esto, `INC`/comparación eran incorrectos en
  68000 (lo cazó la inspección del asm; el host x86 no lo detecta).
- **Medido (DK, `--native`, `-O3`):** `.text` 76 404 B; se aplican `copia16=3`, `const16=32`,
  `compare16=1`. El asm sale como `move.w`/`addq.w` en `g_bus+…` y a menudo con **plegado de
  constantes** (`move.w #13330` sin cargar).

**Pendiente:** `DEC` de 16 bits y la suma/resta `ADC/SBC` en cadena (multibyte).

---

## Orden recomendado

1. **Runtime/kernel en asm** del bucle caliente (PRNG) — máximo retorno inmediato, riesgo contenido.
2. **Blitter** para rellenos/copias y **HLE** de esperas (patrones 2,3,8,9,10).
3. **`--regions`** (*flattening* + tabla de retorno) — el gran salto hacia 1:1, con validación host.
4. Sustituciones de patrones multibyte (4,5) y memoización de PRNG (7).
5. PGO cruzado y limpieza de tablas (LTO/gc-sections).
