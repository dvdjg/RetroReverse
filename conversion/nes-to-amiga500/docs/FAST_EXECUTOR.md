# Ejecutor rápido (pre-decodificado)

Camino de ejecución **transpilado** del nodo: en vez de decodificar el 6502 en cada instrucción
(`Interpreter::step`), la PRG-ROM se decodifica **una sola vez** al cargar y luego se resuelve por
dirección. Es el primer paso para separar el *motor* del intérprete del *grafo de basic blocks* que
emite el transpilador ([`TRANSPILER.md`](TRANSPILER.md), [`OPTIMIZATION.md`](OPTIMIZATION.md)).

## Idea

`NesSystem` expone un *hook* de motor (`fast_step`) que devuelve los ciclos de la instrucción o `0`
para **caer al intérprete**:

```cpp
using FastStep = int (*)(void* ctx, CPU& cpu, NESMemory& mem);
void* fast_ctx;      // contexto del motor (p. ej. FastCpu)
FastStep fast_step;  // nullptr => siempre intérprete
```

`FastCpu` ([`../runtime/host/fastcpu.hpp`](../runtime/host/fastcpu.hpp)):

1. **`build()`** recorre la PRG desde los vectores de `reset`/`NMI`/`IRQ` siguiendo el flujo de
   control (ramas, `JMP`/`JSR` absolutos, `RTS`/`RTI`/`BRK`) y rellena una tabla por dirección con
   `opcode`, `size`, `operand` y `target`. Los opcodes no oficiales/desconocidos quedan marcados
   como no decodificados.
2. **`step()`** resuelve un subconjunto **caliente** de opcodes sin volver a leer el byte de opcode
   ni el operando de memoria; los modos indexados/indirectos resuelven X/Y y punteros en línea.
3. **Opcodes no cubiertos** (p. ej. `TXS`, rotaciones de memoria, ilegales) devuelven `0` y el
   sistema ejecuta `Interpreter::step()`, de modo que el resultado es **idéntico**.

No es todavía el código C++ generado por el transpilador: es un *dispatcher decodificado por
dirección* que permite medir el coste del motor sin decodificación y sirve de banco de pruebas para
la semántica/ciclos. El paso siguiente es alimentarlo desde el **grafo de basic blocks**.

## Cobertura actual

Casi todos los opcodes oficiales frecuentes (en adelante, el resto cae al intérprete):

- **Cargas**: `LDA`/`LDX`/`LDY` en `imm`/`zp`/`zp,X`/`zp,Y`/`abs`/`abs,X`/`abs,Y`/`(zp,X)`/`(zp),Y`.
- **Almacenes**: `STA`/`STX`/`STY` en `zp`/`zp,X`/`zp,Y`/`abs`/`abs,X`/`abs,Y`/`(zp,X)`/`(zp),Y`.
- **ALU/CMP**: `ADC/SBC/AND/ORA/EOR/CMP` en `imm`/`zp`/`zp,X`/`abs`/`abs,X`/`abs,Y`/`(zp,X)`/`(zp),Y`;
  `CPX`/`CPY` en `imm`/`zp`/`abs`; `BIT` en `zp`/`abs`.
- **RMW**: `ASL`/`LSR`/`ROL`/`ROR` en acumulador/`zp`/`zp,X`/`abs`/`abs,X`.
- **Memoria**: `INC`/`DEC` en `zp`/`zp,X`/`abs`/`abs,X`.
- **Resto**: transferencias (`TAX…TXS/TSX`), `INX/INY/DEX/DEY`, flags (`CLC…SED`), pila
  (`PHA/PLA/PHP/PLP`), `NOP`, `JMP` (`abs`/`ind`), `JSR`/`RTS` y las ocho **ramas**.

También `RTI` y los **ilegales frecuentes** (`SLO`/`RLA`/`SRE`/`RRA`, `SAX`/`LAX`/`DCP`/`ISB`,
`ANC`/`ALR`/`ARR`/`SBX`/`LAS`, `SHA`/`SHX`/`SHY`/`TAS` y los `NOP` ilegales), validados con
`nestest` en lockstep. Los modos indexados de **lectura** aplican la penalización de cruce de página;
las escrituras y los RMW no (igual que el intérprete). Con esto el fallback **por opcode es 0 %**;
lo que queda (0–1 % según el juego) son **direcciones no decodificadas** (saltos indirectos/calculados),
que es el siguiente frente.

## Conteo de ciclos

Cada instrucción cubierta devuelve sus ciclos **exactos** según la tabla del intérprete
(`base_cycles` + penalización por cruce de página en lecturas indexadas y en ramas tomadas). Las
ramas comparan la dirección **posterior** a la instrucción con el destino (no el `PC` inicial). Esto
es lo que mantiene la PPU/NMI sincronizadas entre ambos motores.

## Validación

- **Lockstep CPU+PPU**: [`../runtime/tools/dbg_fast2.cpp`](../runtime/tools/dbg_fast2.cpp) avanza dos
  `NesSystem` (intérprete vs rápido) instrucción a instrucción con `NesSystem::step_instruction` y
  compara CPU, RAM y línea de PPU; además acumula ciclos. Motores 5 000 000 de pasos idénticos en
  las ROMs de prueba (`Donkey Kong`, `Super Mario Bros.`, `Balloon Fight`, `Excitebike`, `Ice
  Climber`).
- **Equivalencia + FPS**: [`../runtime/tools/bench_engine.cpp`](../runtime/tools/bench_engine.cpp)
  ejecuta la ROM N frames con cada motor y compara RAM, framebuffer y registros. Es parte de
  `runtime/test/run.sh` (falla si hay divergencia).

## Medidas (host, `g++ 15/16 -O2`, tras cubrir ~100 %)

| ROM | cobertura | **CPU (sin render)** | **frame completo** |
|---|---:|---:|---:|
| Super Mario Bros. | 99.0 % | **2.02×** | 1.21× |
| Excitebike | 100 % | **2.02×** | 1.10× |
| Balloon Fight | 100 % | 1.80× | 1.19× |
| Donkey Kong | 100 % | 1.57× | 1.10× |
| Ice Climber | 99.4 % | 1.51× | 1.15× |

El *frame* completo lo domina el render de la PPU (`render_frame`, 61 440 píxeles), así que la
ganancia del motor de CPU (~1,5–2×) se diluye a ~1,1–1,2×. La mejora del motor se mide **sin
render**.

## Codegen vs dispatcher (la palanca que supera el techo)

El dispatcher por dirección (intérprete o `FastCpu`) gasta un `switch` por instrucción, así que se
estanca en ~2×. El **código generado** por el transpilador ejecuta cada *basic block* como código
recto (una llamada a `cpu.*` por instrucción, sin *fetch*/*switch*): el compilador ve varias
instrucciones juntas y optimiza. Medido con `tools/transpiler/tests/bench_codegen.sh` sobre una ROM de
cálculo (`--emit-bench-rom`, 294 657 instrucciones), host `g++ -O2`:

| Motor | Mips | vs intérprete |
|---|---:|---:|
| Intérprete | ~173 | 1.00× |
| Ejecutor rápido (`FastCpu`) | ~293 | **1.69×** |
| **Codegen (transpilador)** | ~2239 | **~13×** |

Con equivalencia exacta (mismo estado final los tres). El codegen es, con diferencia, la palanca para
superar el techo del dispatch.

### Codegen para ROMs reales (con PPU)

`tools/transpiler/tests/gen_frame.sh` ejecuta el **código generado dentro del `NesSystem`** (PPU/APU/
mapper reales): el transpilador emite los `bb_*` y `n2a_block_cycles(pc)` (ciclos base por bloque), y
un hook (`gen_run`) despacha los bloques desde `retro_run`/`run_frame`, avanzando la PPU. Para que el
runtime pueda ceder a la PPU **entre bloques**, las ramas y `JMP` generan `cpu.PC = destino; return;`
(sin `goto` interno), de modo que un bucle de espera de VBlank no cuelga.

El codegen emite, por cada instrucción, su **coste exacto en `cpu.cycles`** (base +
penalización de página/rama, idéntica al intérprete); el runtime lee el delta por bloque. La exactitud
se comprueba con [`../runtime/tools/cycles_audit.cpp`](../runtime/tools/cycles_audit.cpp): **0
discrepancias** frente a los ciclos del intérprete en 40 000 pasos.

Resultado sobre **Donkey Kong** (NROM, 60 frames, host):

| Métrica | Intérprete | Codegen |
|---|---:|---:|
| fps (frame completo) | ~3890 | ~4800 (**1.23×**) |
| ciclos acumulados | 1 780 144 | 1 781 021 (99.95 %) |
| RAM distinta | — | **12 / 2048** bytes |
| píxeles distintos | — | **0 / 61440** |

Otros NROM probados con el mismo arnés (`gen_frame.sh`, 60 frames):

| ROM | píxeles distintos | RAM distinta | ciclos |
|---|---:|---:|---:|
| Donkey Kong | 0 / 61440 | 12 | 99.95 % |
| Balloon Fight | 0 / 61440 | 9 | 99.997 % |
| Ice Climber | 0 / 61440 | 729 | 68.9 % |
| Excitebike | 61440 | 35 | motor detenido |
| Super Mario Bros. | 61440 | 143 | motor detenido |

### Correcciones encontradas al ampliar a más ROMs

- **Instrucciones truncadas**: al final de la PRG, un opcode con operandos fuera de la ROM se emitía
  como llamada **sin argumento** (`ISB_absx()`), que no compilaba. Ahora el disassembler lo marca como
  desconocido y no lo emite → **Excitebike e Ice Climber compilan**.
- **`CPU::RTI()` no restauraba los flags** (el intérprete sí); corregido. Importante en rutinas de
  NMI/IRQ.
- **`CPU::BRK()` detenía el motor**; ahora el runtime fija `brk_halts=false` y `BRK` salta al vector IRQ
  como el intérprete (el harness standalone mantiene el halt).

Aun así, las ROMs **sensibles al timing** (Excitebike, SMB) siguen divergiendo: frame 1 es exacto y la
deriva empieza después. La causa de fondo es la **NMI a granularidad de bloque** (la misma del residual
de DK: 12 bytes), amplificada en juegos que dependen del instante exacto del VBlank. Se resolverá con la
**cesión por instrucción** (contador separado), pendiente (dos variantes probadas, ver más abajo).

### Auditoría semántica de los métodos de `CPU`

`runtime/test/cpu_methods_test.cpp` compara, instrucción a instrucción y sobre estado idéntico, el
**intérprete** con el **método de `CPU` que emite el codegen** (wrappers de direccionamiento con/sin
cruce de página, `STA abs,Y`, `LDA (zp),Y`/`(zp,X)`, vuelta de página cero, `ADC abs,X`, y los ilegales
`LAX/SAX/DCP/ISB/SLO/RLA/SRE/RRA`, más `RTI`/`BRK`): compara registros, flags, `SP` y RAM. Resultado:
**0 discrepancias** (los bugs de `RTI`/`BRK` se hallaron antes y quedan cubiertos por el test). Se
ejecuta en `runtime/test/run.sh`.

### Código en RAM, HLE y validación

El transpilador solo decodifica `$8000-$FFFF`; si el programa salta a RAM (`$0000-$1FFF`), el runtime
resuelve esas instrucciones con el **ejecutor rápido** (`FastCpu`), que ahora **decodifica RAM bajo
demanda** leyendo los bytes en el momento (correcto ante automodificación) y solo cae al intérprete si
el opcode tampoco está cubierto. El codegen (C++) no puede compilar RAM en runtime, así que el tramo RAM
va a velocidad de `FastCpu`, no del codegen.

Medición (`opcode_hist` reporta `f` = fracción en RAM y las direcciones RAM calientes):

| ROM | f (código en RAM) |
|---|---:|
| Donkey Kong / Balloon Fight / SMB / Ice Climber / Excitebike | **0 %** |
| Sintética (rutina copiada a `$0200` y bucleada) | **93.6 %** (calientes `$0207..$020E`) |

En los juegos NROM el coste es **despreciable**; la ROM sintética valida el soporte y el modelo:
`S(f) = G / (1 + f·(G-1))` con `G` = ventaja del codegen en PRG (para `G=2`: `f=0 → 2×`, `f=0.5 → 1.33×`),
y como el frame lo domina la PPU el impacto en FPS es menor. Para RAM caliente la palanca es **HLE**:
reconocer la rutina por sus bytes y sustituirla por código nativo (`opcode_hist` ya lista las direcciones
candidatas).

**Bug hallado al mezclar codegen y fallback**: el codegen empujaba `PC+2` pero usaba `CPU::RTS()` sin
`+1`, mientras el fallback (intérprete/`FastCpu`) hacía `+1` → los `RTS` ejecutados en RAM volvían una
posición de más. Se **unificó** a la convención del intérprete (`JSR` apila `PC+2`, `RTS` suma 1); los
tests del transpilador siguen en verde y la ROM de RAM pasa a **equivalencia exacta** (RAM 0, framebuffer
0). (El harness standalone `game_main` sigue deteniéndose en `dispatch == nullptr`.)

### Mappers (CNROM)

El transpilador acepta ahora **NROM (0) y CNROM (3)** (ambos con PRG **fija**; CNROM solo conmuta CHR, que
gestiona el mapper del runtime). `--emit-cnrom-rom` genera una CNROM sintética; validada con `gen_frame`
(píxeles idénticos, RAM 3 B). **UxROM (2)/MMC1 (1)** conmutan bancos de PRG y no se pueden decodificar
estáticamente todavía (pendiente).

El **framebuffer es idéntico**. La diferencia residual (12 bytes de RAM, 0.05 % de ciclos) procede de
que la NMI se inyecta a **granularidad de bloque**: un bloque que cruza la línea 241 retrasa la NMI
hasta su fin, mientras el intérprete la inyecta tras la instrucción exacta. La cesión
instrucción-a-instrucción (`cpu.deadline`) queda **pendiente** (una primera versión regresionaba al
mezclar el fallback). El frame completo lo domina la PPU, así que el 13× de CPU se diluye a ~1,2×.

## m68k (sin el engine)

El intérprete y el ejecutor rápido compilan para **`m68k-amiga`** (`-m68000`, GCC 15.1) con un shim
mínimo de `eng/core`, **sin** el engine ([`../tools/m68k/README.md`](../tools/m68k/README.md)). Tamaño
de `.text`: **47 782 B** (intérprete) vs **45 638 B** (rápido); equivalencia en host intacta.
Pendiente: medir ciclos reales bajo WinUAE.

## Ejecutor por bloques (paso hacia el grafo)

`NesSystem` admite además `fast_run` (`FastCpu::run_block`): ejecuta un **bloque** de instrucciones
seguidas hasta un salto/`JSR`/`RTS`, una **rama tomada**, un opcode no cubierto, o hasta que agotaría
el presupuesto de ciclos hasta la próxima frontera de scanline. Ese presupuesto
(`NesSystem::cycles_to_scanline`) garantiza que el bloque **no cruza de línea de PPU**, de modo que
se puede avanzar la PPU una vez por bloque sin alterar scroll/`set_line_scroll` ni el instante de la
NMI. Los límites del bloque coinciden con los del grafo de *basic blocks* del transpilador.

**Resultado medido (honesto)**: el modo por bloques es **equivalente** (lockstep 3 M pasos × 5 ROMs)
pero **no mejora el rendimiento** frente al dispatch por instrucción (~1,9× vs ~2,0× de CPU; ver
tabla). El cuello de botella es el `switch` de decodificación/ejecución, **no** la llamada indirecta
por instrucción ni el `clock_ppu` (que el compilador ya inlinea). La ganancia real exige **código
generado** —bloques como funciones con asignación de registros y flags vivos—, que es justo lo que
emite el transpilador. El bloque queda como **andamiaje** para cuando el codegen se enganche en
runtime.

## Límites y siguientes pasos

- La decodificación es **lineal por dirección** (marca cada inicio de instrucción): si un destino de
  salto cae en mitad de una instrucción ya decodificada, se detiene esa rama. Igual que el
  transpilador; suficiente para probar el motor.
- El hook es **solo host** (usa `new`); en Amiga/SDL sin `FastCpu` se usa el intérprete. El ejecutor
  definitivo será el **C++ generado** por el transpilador, portable a `m68k`.
- Siguiente: (1) **código generado** desde el grafo de basic blocks (la única palanca que supera el
  techo del dispatch, ver arriba); (2) cubrir los opcodes ilegales frecuentes; (3) medir en el
  *vertical slice* y portar el dispatcher a `m68k`.

## Efecto de la cobertura (medido con `opcode_hist` + `bench_engine`)

[`../runtime/tools/opcode_hist.cpp`](../runtime/tools/opcode_hist.cpp) cuenta, sobre la ejecución
real, qué opcodes caen al intérprete. Una instrucción no cubierta paga **el coste del intérprete
*más* el intento fallido del ejecutor** (lookup `has`/`dec`), así que el fallback es un lastre doble,
no neutro. Por eso la cobertura se prioriza por frecuencia observada, no por opcode "bonito".

Ampliar a `RMW` de desplazamientos + cargas/almacenes `zp` indexados + ALU/CMP indexadas + `BIT` +
`TXS`/`TSX` llevó la cobertura a ~100 % y el motor de CPU al techo del dispatcher:

| ROM | cobertura antes | cobertura ahora | CPU antes | CPU ahora |
|---|---:|---:|---:|---:|
| Donkey Kong | 61.9 % | 100 % | 1.22× | **1.57×** |
| Excitebike | 64.0 % | 100 % | ~1.6× | **2.02×** |
| Ice Climber | 84.5 % | 99.4 % | 1.42× | **1.51×** |
| Balloon Fight | 95.7 % | 100 % | 1.47× | **1.80×** |
| Super Mario Bros. | 99.0 % | 99.0 % | 2.02× | 2.02× |

En DK/Excitebike un solo opcode (`66 ROR zp`, casi seguro un **PRNG/LFSR** en bucle) concentraba el
34–37 % del trabajo; cubrir la familia `RMW` lo elimina y lleva el fallback de ~38 % a ~0 %. SMB y
Balloon Fight ya estaban cubiertos: añadir opcodes no los mejora porque **~2× es el techo del
dispatcher por dirección** (un `switch` por instrucción). Para superarlo hace falta el ejecutor por
**bloques** (menos dispatch, asignación de registros y plegado entre instrucciones), que es el paso
siguiente.

## Intentos fallidos y decisiones (registro)

Se dejan anotados los caminos probados y **descartados**, para no repetirlos.

| Intento | Resultado | Qué pasó / qué se hizo |
|---|---|---|
| **Cesión por instrucción (1ª variante: `cpu.deadline`)** | ❌ FALLO: framebuffer **100 %** distinto, RAM 41 B | La idea es correcta (cortar el bloque justo antes de cruzar la línea de PPU). Se emitió `if (cpu.cycles >= cpu.deadline) { cpu.PC=<addr>; return; }` antes de cada instrucción, con `gen_run` fijando `deadline = cycles + budget`. El contador `cpu.cycles` era **por bloque** (se reiniciaba) y el **fallback al intérprete** no lo tocaba → desincronización. Probado con margen `cycles+7`: igual. **Revertido.** |
| **Cesión por instrucción (2ª variante: `block_start`/`budget`)** | ❌ FALLO: **0,30×** (más lento) y framebuffer 100 % | Para no resetear `cycles`, se midió el consumo por bloque como `(cpu.cycles - cpu.block_start) >= cpu.budget`. Sin cesión (budget=∞) vuelve al baseline bueno (fb idéntico, RAM 12 B); **activarla** hace que los bloques cedan muy a menudo y el motor caiga al intérprete/despacho constante, perdiendo el codegen y divergiendo. **Revertido** (el campo se eliminó). |
| **`n2a_block_cycles` (ciclos base estáticos)** | ⚠️ Aproximado: RAM 11–12 B, ciclos 0.05 % | Sumaba ciclos base por bloque, sin penalización de página/rama ni bucles intra-bloque. Sustituido por coste **por instrucción** exacto (auditado). |
| **`goto` interno en bloques (auto-bucle)** | ❌ Cuelga bajo el runtime | Una espera de VBlank (`LDA $2002; BPL`) quedaba como bucle **dentro** de un bloque y nunca devolvía el control para que avanzara la PPU. Se cambió a `cpu.PC = destino; return;` (las ramas ceden al despacho). |
| **Array fijo para ordenar bloques por calor** | ❌ Desborde con ROMs grandes | Sustituido por `eng::util::Vector` sin tope. |
| **`parse_hex` (u16) para el calor** | ❌ Truncaba >65535 | Añadido `parse_hex32`. |
| **Core codegen como opción de runtime** | ✅ (con matiz) | C++ no se compila en tiempo de ejecución: el motor `codegen` solo existe si el core se **enlaza** con el transpilado de una ROM concreta (`build-codegen-core.sh`). El core genérico cae a `fast` si se pide `codegen`. |

**Lección**: mezclar un contador de ciclos **por bloque** con el **fallback al intérprete** es frágil. La
cesión por instrucción debe usar un contador **separado** (p. ej. `block_cycles`) que reinicie el
runtime y que el intérprete no toque. Queda como siguiente paso.

## Motor codegen en el core libretro

La opción `nes_engine` admite `auto | fast | interpreter | codegen`:

- **`auto`** (por defecto): usa `codegen` si el core trae el motor enlazado, si no `fast`.
- **`codegen`**: requiere un core compilado con el transpilado de la ROM
  ([`../runtime/retroarch/build-codegen-core.sh`](../runtime/retroarch/build-codegen-core.sh),
  `make codegen ROM=...`). El core genérico lo anuncia y **cae a `fast`** (no se puede compilar C++ en
  runtime).
- `fast` / `interpreter`: como antes.

Validado en el orquestador con el core codegen de Donkey Kong (`motor de CPU = codegen`, determinismo OK).

## Activación

- **SDL3**: variable de entorno `NES_ENGINE=fast` (por defecto intérprete).
- **core libretro**: *core option* `nes_engine` = `fast` | `interpreter` (por defecto `fast`).
- Con el motor rápido se usan los dos hooks: `fast_run` (bloques, en `run_frame`) y `fast_step`
  (una instrucción, para herramientas y lockstep).
- **Tests**: `bench_engine <rom.nes> [frames]`, `dbg_fast2 <rom.nes> [steps]`,
  `opcode_hist <rom.nes> [frames] [top]`.
