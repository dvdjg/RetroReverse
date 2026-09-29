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

**Añadido después:**
- **Suma 16 bits** (`CLC; LDA zp a; ADC k0; STA zp c; LDA zp a+1; ADC k1; STA zp c+1`) → `u16 + u16`
  con `C`/`V`/`Z`/`N` del byte alto. `DEC` 16 bits implementado con el mismo patrón, pero **solo
  cuando el bloque del `DEC lo` es una sola instrucción** (absorber parte de un bloque es inseguro).
- **VSA de A/X/Y**: `#imm`, `INX/DEX/INY/DEY` y `TAX/TAY/TXA/TYA` propagan valores constantes, así
  `LDX #c; DEX; LDA tabla,X` se pliega a literal.
- **Endianness**: helpers `n2a_ld16`/`n2a_st16` (little-endian) con `__builtin_bswap16` en big-endian.
- **Medido (DK, `--native`, `-O3`)**: `.text` 76 404 B; `copia16=3`, `const16=32`, `compare16=1`.

**Añadido después (2):** **resta 16 bits** (`SEC;LDA;SBC;…`), **`DEC` 16 bits general** (con "saltar
la 1ª instrucción" del bloque `skip`, así no exige que sea una sola instrucción) y **opcodes
ilegales frecuentes** (`LAX/SAX/DCP/ISB/SLO/RLA/SRE/RRA`) con la misma semántica que el intérprete.
La ROM de prueba `--emit-multibyte-rom` ahora cubre todo eso (check en `run.sh`).

> **Cobertura nativa (medido):** con los ilegales soportados, **sigue siendo solo DK el nativo** entre
> los NROM del repo: **todos** los demás usan `JMP (ind)`, que no se puede forzar de forma segura (ver
> abajo). `--best` los manda al backend por bloques (perfil Amiga optimizado), que es correcto.

> **Backend por bloques (`--chain`).** Los idioms **sin ramas** (copia/const/compare/ADD/SUB 16 bits) se
aplican también en el backend por bloques (`--amiga`), emitiendo sobre `cpu`/`n2a_ram`, con operando
en **zp o abs** (`< $2000`) o inmediato. `INC/DEC` de 16 bits (cruzan el `BNE`) **solo en el nativo**:
en el backend por bloques cada bloque es una función distinta, así que no se puede "saltar" una
instrucción de otro bloque sin fusionarlos (que es lo que hace el nativo con etiquetas).

> **La cobertura real la fija el CFG, no el patrón.** En SMB el transpilador decodifica solo
> **1075 instrucciones** (de 32 KB) porque los **saltos indirectos cortan el desensamblado**: sin
> ellos, el grafo no llega a la mayoría del código y los idioms no se encuentran. Es decir, el techo
> para la mayoría de juegos es **descodificar más CFG** (saltos indirectos / tablas), no añadir
> patrones.

**Completar el CFG con telemetría de PC (`--pc-trace`) — hecho.** En vez de heurísticas frágiles de
tablas de salto, se ejecuta la ROM (oráculo/`opcode_hist`) y se vuelca el **conjunto de PC
ejecutados** (`hot <addr> <n>`, ya existente). El transpilador los usa como **puntos de entrada** del
desensamblado (`add_entry_point`), de modo que el código alcanzado **solo por saltos indirectos** se
decodifica. Medido en SMB: **1075 → 5622 instrucciones** (395 → 1723 bloques) y `.text` **94 → 296 KB**
(ese código pasaba antes por el intérprete; ahora corre en el backend rápido). Es la vía **robusta y
data-driven** para el techo de cobertura.

**Ampliar la traza con inyección de entrada (`N2A_INPUT=1`) — hecho.** `opcode_hist` e `ind_targets`
inyectan pulsaciones del mando (A/B/Start/cruceta, 8 frames cada una) para que el juego avance de
menús al gameplay y la traza cubra más estados. Medido (300 frames): SMB PCs ejecutados
2245 → **2736**; Pac-Man 512 → **1771**; DK 584 → **678**. En SMB los destinos indirectos suben
27 → **32**. Mejora directa de la cobertura del backend por bloques (menos *fallback* al intérprete).

**Hechos de valor (`--facts`) y `N2A_ASSUME`: dos correcciones + límite medido.** (1) El macro solo
cubría `__builtin_assume` (MSVC/Clang); el **g++ 15.1 de m68k no expone ese builtin**, así que caía a
*no-op*: ni el VSA ni los hechos cambiaban nada en el binario final (el host, que sí lo tiene, lo
ocultaba). Arreglado: usa **`[[assume]]`** (C++23; `__has_cpp_attribute(assume)` = 1 en ese g++; en un
*probe* plegó `x & 0xF0` a 0 con `x <= 0x0F`). Se añadió `-DN2A_NO_ASSUME` para medir A/B. (2) La
suposición se emitía **antes** de la carga y sobre `cpu.mem->read(addr)` —función **no pura** y que con
`--fast-ram` el código ni usa (la carga va por `n2a_ram[]`)—, quedando **desconectada**. Ahora se emite
**tras** la instrucción que lee y sobre la **expresión pura que el código usa**: `cpu.A/X/Y` en cargas
(`LDA/LDX/LDY`) y `n2a_ram[..]`/`cpu.mem->ram[..]` en el resto (RMW `INC/DEC/ASL…`, `CMP`, `BIT`), solo
en modos `Zp`/`Abs`.

> **Límite medido (importante).** Con el estado del 6502 en `struct CPU` **detrás de un puntero**, la
> suposición **no pliega**: un *probe* con `cpu.A = ram[0x20]; [[assume(cpu.A <= 0x0F)]]; return cpu.A & 0xF0;`
> **no** se reduce a 0 (g++ no propaga la cota a través de `cpu.A`, que es memoria y puede estar
> *aliased*). El mismo `[[assume]]` sobre una **variable local** **sí** pliega. Conclusión: los
> hechos/`N2A_ASSUME` solo rinden en el backend **nativo/por regiones** (A/X/Y/flags en **locales**),
> no en el backend por bloques con `cpu.*`. Es decir, la palanca real sigue siendo el paso
> **estructural** (§2), no añadir hechos: primero estado en locales, luego las cotas.

**Tablas ROM → datos precomputados (HLE).** Evaluado: identificar tablas usadas (por acceso
`abs,X`/`(zp),Y` a ROM) y **volcarlas ya transformadas** es un reconocimiento por juego (el transpilador
no conoce la semántica de la tabla) y suele requerir HLE específico; no es un idiom genérico.

**`JMP (ind)` en el nativo — HECHO con telemetría de sitios (`--ind-targets`).** El bloqueo real
(por qué el nativo caía al por bloques en casi todos los NROM) era el `JMP ($zp)` (`$6C`, el único
salto indirecto del 6502; **no** hay `JSR (ind)`). Resuelto así:

1. **Colector** `runtime/tools/ind_targets` ejecuta la ROM y registra, **por sitio**, el par
   `(sitio $6C → destino observado)` en un fichero `ind <sitio> <destino>`.
2. El transpilador (`--ind-targets`) guarda esos pares y, en el backend nativo, **trae los destinos
   observados de cada sitio a la MISMA región** (etiquetas `L_xxxx`) y emite el `JMP (ind)` como
   `switch (destino) { case T: goto L_T; … default: miss }`. Un `JMP` es salto de **cola** y se
   resuelve **intra-región** (`goto`), así que **no crece la pila C** (el modelo por regiones + llamada
   C de `JSR` se mantiene). El *page-wrap* del 6502 (`(ptr&0xFF00)|((ptr+1)&0xFF)`) se reproduce.
   Destino no observado ⇒ hook `g_native_ind_miss` (el runtime puede ceder) o `halted`.
3. Entradas de la traza (`--pc-trace`) y destinos indirectos se marcan como **líderes** (entradas
   reales), lo que también arregla el check "destino de `JSR` decodificado" cuando hay traza.

**Medido:** los **destinos por sitio son pocos** (SMB: 1 sitio→27; Ms. Pac-Man: 1→4; Pac-Man: 1→1),
así que **no hay explosión de regiones**. Resultado: **Ms. Pac-Man ya es nativo** (`.text`
**113 628 B** vs **181 492 B** del por bloques); SMB queda excluido por **código en RAM** (hace
`JSR $0173` a una rutina copiada a RAM, indecodificable estáticamente), limitación legítima.

**Bug preexistente corregido (lo destapó la prueba nativa de `misc`):** los desplazamientos
**acumulador** (`ASL A`/`ROL A`/`LSR A`/`ROR A`, opcodes `$0A`/`$2A`/`$4A`/`$6A`) se emitían como si
fueran de **memoria** (`(n2a_read(0)|n2a_read(1)<<8)+Y`): no existía rama `AddrMode::Acc`. El
`misc` nunca había corrido nativo, por eso no se veía. Ahora operan sobre `r->a`.

**Límite restante:** un `JMP (ind)` con **sitio no observado** (traza corta) rechaza el nativo
(`native_ok`); basta alargar la traza o quedarse en el por bloques. Y el **código en RAM** sigue
excluyendo juegos que copian rutinas (SMB). Ambos quedan como trabajo futuro (tabla resuelta
estáticamente / intérprete de respaldo enlazado).

> **Paso 1 — límite MEDIDO y decisivo: el modelo de frames del nativo no es viable para juegos
> reales.** Al validar Ms. Pac-Man/DK a varios frames (`native_frame`/`native_diff`), el nativo
> **se colgaba**: `game_main` **re-llamaba la región de `reset`** en cada cesión (repitiendo la
> inicialización). Se corrigió la re-entrada (**reanudación por `r->pc`**: cada punto de cesión es
> una entrada de región y `game_main` despacha por `r->pc`) y la detección de espera de VBlank
> (el bucle puede estar **partido en dos bloques**). Con eso los frames avanzan, pero **sigue
> divergiendo** del intérprete y **DK aún se cuelga** (varios patrones de espera: solo 1 de 5
> lecturas de `$2002` se detecta como espera; otros juegos esperan por *flag*/NMI).
> **Conclusión:** el modelo de frames por *detección de patrón de espera* es un **callejón sin
> salida**; el modelo **correcto** es el del backend por bloques: **cesión por *deadline* de ciclos**
> (`cpu.cycles >= deadline`, campo ya presente en `CPU`), del que ya se encarga `NesSystem`. El
> backend nativo (regiones) no puede usar ese modelo porque no cuenta ciclos ni se despacha por `PC`.
> Por eso el nativo queda como prototipo de **cómputo puro**; los juegos reales van por el backend
> por bloques (cadena/ROM/ZP directas) + HLE. Las mejoras del paso 1 (reanudación + espera partida)
> se mantienen: corrigen fallos reales y no rompen los tests (`run.sh`: TEST OK).

> **Paso 2 — la cobertura ampliada destapó un cuelgue REAL del backend por bloques (arreglado).**
> Al decodificar más CFG (traza `--pc-trace`/tablas), SMB incluye **bucles de espera que NO leen
> `$2002`** (esperan un **flag** que cambia el NMI, p. ej. `LDA flag; BNE self`). El codegen
> **encadenado** solo cedía si el bucle leía `$2002`, así que esos bucles quedaban como
> **auto-llamada infinita sin ceder** (`bb_82A9: if (cpu.N) { return bb_82A9(cpu); }` en los que no
> escriben; y en los que copian/calculan, aunque acotados, conviene saberlo). Arreglado con
> `chain_wait`: cede en **cualquier rama de bucle hacia atrás** cuya **cabecera lee memoria sin
> escribirla** (`block_waits_on_flag`: modos `Zp`/`Abs`, excluye escrituras y `JSR`), además del
> caso `$2002`. **Medido** con `gen_frame` (SMB + traza): antes **se colgaba**; ahora completa y a
> **1 frame la RAM es idéntica** (0/2048 diff); a 10/60 frames deriva por el **desajuste de timing
> del arnés** (`--amiga` es `--no-cycles`, y `gen_frame` avanza la PPU por ciclos → 1 dot/bloque),
> no por el codegen. `run.sh`: TEST OK.

> **Límite del arnés de medida (paso 1 pendiente).** Medir **fps** de `--amiga` con `gen_frame` no
> es válido: sin ciclos, el runner avanza 1 dot por bloque. Hace falta un runner **dirigido por
> eventos** (avanzar la PPU al próximo evento al ceder) — el modelo que ya usa el runtime del
> plugin/host (`TranspiledGame` + `NesSystem`), no el harness simplificado.

**IR mínimo + reconocedor flexible (variaciones) — hecho.** Los idioms se casaban por **opcodes
exactos en offsets fijos**, así que no veían variaciones. Se añadió un **IR mínimo** (`IrKind`/
`IrStep`: efecto normalizado —`LoadA`/`StoreA`/`AddA`/`SubA`/`CmpA`/`ClrC`/`SetC`/`Nop`— con su
operando) y un matcher por **predicados** (`try_ir_multibyte`) para copia/constante de 16 bits que
**salta `NOP`** intercalados (el único op realmente neutro; `CLC`/`SEC` **no** se saltan porque
cambian `C`, observable). Subyace a `try_chain_multibyte` (IR flexible → exacto). **Medido**
(`--amiga`): DK 32 → **33** idioms (el IR sube +1 y subsume los 32 exactos); Ms. Pac-Man 9 → 9.
La ganancia inmediata es pequeña (las variaciones con `NOP` son raras), pero el IR es la **base**
del reconocedor **estructural** (comodines, otro registro, reordenaciones) que pediste. Test: ROM
`--emit-multibyte-rom` incluye una **variación con `NOP`** que solo el IR casa (`run.sh`, `--amiga`).
Diagnóstico: `idioms16=N (ir=… exact=…)` en la salida del transpilador.

---

## Orden recomendado

1. **Runtime/kernel en asm** del bucle caliente (PRNG) — máximo retorno inmediato, riesgo contenido.
2. **Blitter** para rellenos/copias y **HLE** de esperas (patrones 2,3,8,9,10).
3. **`--regions`** (*flattening* + tabla de retorno) — el gran salto hacia 1:1, con validación host.
4. Sustituciones de patrones multibyte (4,5) y memoización de PRNG (7).
5. PGO cruzado y limpieza de tablas (LTO/gc-sections).
