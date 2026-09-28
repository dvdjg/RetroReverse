# Codegen Amiga: encadenado de bloques + ROM/ZP directas (implementado y medido)

Este documento registra **cambios reales en el transpilador** para que el C++ generado sea
optimizable por el `m68k-amiga-elf-g++` del engine, con **medida antes/después** sobre Donkey Kong.
Continúa [`MEDICION_CODEGEN_68000_DK.md`](MEDICION_CODEGEN_68000_DK.md) (que diagnosticó el problema).

> **Resumen.** Se añaden seis técnicas: **(1) encadenado de bloques** por llamada en cola
> (`return bb_destino(cpu);`) con `JSR`/`RTS` como llamada/retorno C; **(2) datos de ROM como
> constantes** (absolutas → inmediato; indexadas → acceso directo a `PRG_ROM`); **(3) acceso directo
> a zero-page también para RMW/desplazamientos** con punteros `ram`/`prg` cacheados por bloque;
> **(4) helper de desplazamiento multibyte** (`n2a_ror_run`/`n2a_rol_run`) con **asm m68k** que
> mantiene el carry en un registro (`roxr`/`roxl`) para las cadenas `ROR/ROL zp` (el 38 % de DK);
> **(5) liveness de flags** (sustituye escrituras muertas de `Z`/`N`, atacando el estado en memoria);
> y **(6) cesión por evento** (`cpu.yield`) en los bucles de espera de VBlank/NMI, que permite
> ejecutar frames reales con el control encadenado.
> Medido en DK (perfil de 302 frames): **3,68 M → 0,62 M ciclos/frame (~1,9 → ~11,4 fps, ×6)**;
> los bloques calientes pasan de **11–16 `jsr` a 0**, el `__umodsi3` que impedía enlazar con
> `-nostdlib` desaparece, y el bloque `ROR` más caliente pasa de **2 150 a ~430 ciclos**.

---

## 1. Por qué g++ no podía hacerlo solo

El codegen anterior emitía, al final de cada bloque, `cpu.PC = destino; return;`, y un
`game_main` que resolvía el bloque con **búsqueda binaria sobre una tabla** de 2117 entradas. Para
g++ eso es:

- `return;` sin valor → **no es una llamada**; no hay *sibling call* que optimizar.
- `cpu.PC` es un valor de **runtime**; el mapa dirección→función vive en una **tabla de datos**
  (`kFixedBlocks`), no en el flujo de control. El compilador no puede demostrar qué bloque toca.
- La búsqueda binaria es un bucle con `lsl.l`/`sub.l`/ramas: ~120 ciclos × 12 pasos = **~1440
  ciclos por bloque**, invisibles desde el C++ de los bloques.

Es una transformación **global** (todo el grafo), no local; por eso la tiene que hacer el
**transpilador**, no el backend. La clave técnica es que GCC m68k **sí hace optimización de
llamada en cola** (verificado con una sonda: `return f(x);` → `jra f`), así que basta con que el
codegen **exprese** la sucesión como una llamada en cola.

---

## 2. Técnica 1 — Encadenado de bloques (`--chain`)

Emitir el control de flujo estático como **llamada en cola** al bloque destino:

| 6502 | Antes (despacho) | Ahora (`--chain`) |
|---|---|---|
| rama tomada | `if (cond) { cpu.PC=0xT; return; }` | `if (cond) return bb_T(cpu);` |
| caída | `cpu.PC = 0xN; return;` | `return bb_N(cpu);` |
| `JMP abs` | `cpu.PC = 0xT; return;` | `return bb_T(cpu);` |
| `JSR abs` | `cpu.JSR_abs(0xT, 0xR); return;` | `cpu.push16(0xR); bb_T(cpu); return bb_R3(cpu);` |
| `RTS` | `cpu.RTS(); return;` | `cpu.pull16(); return;` |

- `JSR` se convierte en **llamada C normal** al subbloque y, al volver (su `RTS` hace `return`),
  se encadena al bloque de retorno `R3 = JSR+3`. La pila C refleja la profundidad de llamadas del
  6502 (sin crecimiento por iteración).
- `RTS` descarta el valor apilado y devuelve por la pila C (`return`).
- Se fija `cpu.PC = inicio;` al entrar en cada bloque (para fallback/NMI/diagnóstico).
- **Requisito**: solo se activa con `--no-cycles` (sin cesión por *deadline*), y solo con PRG no
  bancada cuando los destinos son bloques conocidos. Si un destino no es bloque, se mantiene el
  despacho (red de seguridad).

> **Nota de diseño pendiente.** Sin cesión por deadline, un bucle de espera de VBlank
> (`bb_C7A8`) se convierte en un bucle en cola infinito y no cede al runtime. Para el **A500 real**
> hay que integrar el *scheduler* de eventos (VBlank/NMI/sprite-0) en los puntos de bloque, como
> describe [`TIMING_CODEGEN.md`](TIMING_CODEGEN.md). El encadenado no lo impide: basta insertar la
> comprobación `if (cpu.cycles >= cpu.deadline) { cpu.PC = NEXT; return; }` antes de las aristas.

---

## 3. Técnica 2 — Datos de ROM fijos (`--rom-direct`)

El código leía ROM por `cpu.LDA_absx(0xC4A7)` → `NESMemory::read()` → `prg[idx % prg_size]`, con
`prg` un **puntero de runtime** y `%` una **libcall**. Aunque `PRG_ROM` sea `constexpr`, g++ nunca
ve los datos.

**Formato propuesto (e implementado):** para cargas/ALU/CMP con operando en la ventana fija de ROM
y PRG no bancada, emitir el **acceso directo al array `constexpr`**:

```cpp
// Antes
cpu.LDA_absx(0xC4A7);            // -> call NESMemory::read -> % (libcall)
// Ahora
cpu.A = n2a_prg[1191 + cpu.X]; cpu.set_nz(cpu.A);   // acceso indexado a .rodata
```

Y para **dirección absoluta sin índice** (`LDA $C1EB`) el byte es una **constante de compilación**
(PRG fija): se emite como **inmediato**, de modo que g++ lo pliega e incluso puede resolver la
operación entera en compile-time:

```cpp
cpu.LDA_abs(0xC1EB);   // antes: call read
cpu.LDA_imm(0x07);     // ahora: el byte de ROM; g++ lo propaga
```

El índice de las indexadas replica el mapeo del bus: `((operand - $8000) + X/Y) & (prg_size - 1)`.
Con esto:

- desaparece la llamada a `read` y el `%` en las lecturas de ROM;
- las **absolutas** se convierten en constantes (plegado total);
- las **indexadas** quedan como acceso directo a `.rodata` (`n2a_prg[base + X]`), sin decodificar
  región ni módulo.

`--rom-direct` cubre `LDA/LDX/LDY`, `ADC/SBC/AND/ORA/EOR`, `CMP/CPX/CPY` en `Abs/AbsX/AbsY`. Las
lecturas indirectas `(zp),Y` / `(zp),X` no se especializan (el puntero es de runtime).

> **Nota de paginación.** Emitir constantes asume **PRG fija** (NROM/CNROM). En mappers bancados
> (UxROM/MMC1/MMC3…) un mismo `$C1EB` puede resolver a bytes distintos según el banco: por eso
> `--rom-direct` **se desactiva** cuando `prg_banked_` es cierto. Para bancados, la vía correcta es
> emitir el acceso por la **bank window** (array por banco) o dejar el `read`; queda como trabajo
> futuro de F9.

---

## 4. Técnica 3 — Zero-page directa ampliada y punteros cacheados (`--fast-ram`)

- Se extiende el acceso directo a zero-page a **RMW/desplazamientos** (`ASL/LSR/ROL/ROR/INC/DEC`),
  que antes iban por `read`+`write` (2 llamadas). El bucle caliente de DK (`ROR $18..$1F`, **38 %
  de las instrucciones**) ahora se emite como lectura+rotación+escritura **en línea**.
- Se declaran por bloque `eng::u8* const n2a_ram = cpu.mem->ram;` y
  `const eng::u8* const n2a_prg = PRG_ROM;`: g++ los mantiene en registros de dirección y **no
  recarga `cpu.mem`** en cada acceso.

---

## 4 bis. Técnica 4 — Desplazamiento multibyte con asm m68k (`n2a_ror_run`/`n2a_rol_run`)

El idiom de PRNG de la NES es una **cadena de `ROR zp` (o `ROL`) sobre bytes consecutivos**
(`ROR $18; ROR $19; … ROR $1F`), que en DK concentra el **38 %** de las instrucciones. Expresado
instrucción a instrucción, cada `ROR` toca memoria y materializa `C/Z/N`; el bloque más caliente
costaba ~2 150 ciclos.

**Detección (transpilador):** dentro de un bloque se busca una tirada maximal de `ROR zp`/`ROL zp`
con operandos consecutivos; si `run ≥ 3` se emite **una** llamada:

```cpp
n2a_ror_run(cpu, n2a_ram + 0x18, 8);   // ROR $18..$1F en una sola pasada
```

**Runtime (asm m68k):** el carry del 6502 se mapea al flag **X** del 68000, y `ROXR.B`/`ROXL.B` son
exactamente el `ROR`/`ROL` del 6502. El bucle queda en **~3 instrucciones por byte** con el carry
vivo en el CCR y **solo materializa flags al final**:

```asm
	move.b 6(%a0),%d0
	lsl.b  #4,%d0
	move.w %d0,%ccr          ; X = C
1:	move.b (%a1)+,%d0
	roxr.b #1,%d0
	move.b %d0,-1(%a1)
	dbra   %d4,1b
2:	seq %d1 / smi %d2 / addx ... ; C,Z,N una sola vez
```

- Hay variante **portable** (si no `__m68k__`) para host/tests.
- `static_assert` sobre `offsetof(CPU,C/Z/N)` **blinda** el contrato de offsets del asm.
- **Equivalencia verificada en host**: `n2a_ror_run`/`n2a_rol_run` (fallback) contra la secuencia
  instrucción a instrucción, **71 982 casos** (n=1..9, bytes y carry aleatorios) → **0 discrepancias**.
- Solo se activa con `--fast-ram` **y** `--no-cycles` (donde el estado por instrucción no se
  observa). El bloque `bb_F4FD` pasa de ~1 100 a **~430 ciclos** (33 líneas de asm).

---

## 5. Arreglo del runtime: `__umodsi3`

`NESMemory::read` hacía `prg[idx % prg_size]`; en 68000 eso genera `__umodsi3`, **inexistente con
`-nostdlib`** (enlazado roto). Como los tamaños de PRG NES son potencias de dos, se sustituye por
una **máscara**:

```cpp
const eng::usize idx = (addr - 0x8000u) & (static_cast<eng::usize>(prg_size) - 1u);
return prg[idx];
```

Verificado: `nm dk_amiga.o | grep ' U '` → **vacío** (antes salía `__umodsi3`).

---

## 5 bis. Liveness de flags: menos estado en memoria (`--chain`)

El mayor coste restante era **materializar `Z`/`N` como bytes en cada instrucción** (`A/X/Y/flags`
viven en el `struct CPU`). Muchas de esas escrituras son **muertas**: p. ej. `LDA $18; AND #$02`
—el `LDA` fija `Z/N` y el `AND` inmediatamente las reescribe sin que nadie las lea—.

**Detección (transpilador):** para cada instrucción que escribe `Z`/`N`, se recorre el bloque hacia
delante hasta la primera que las **lee** (rama/`PHP` → viven) o las **escribe** (→ la escritura es
muerta). Si es muerta, se emite la operación **sin actualizar flags**:

```cpp
cpu.LDA_zp(0x18);          // antes: A = ram[18]; set_nz(A)
cpu.A = n2a_ram[0x18];     // ahora (Z/N muertas): sin set_nz
```

Se aplica a `LDA/LDX/LDY/AND/ORA/EOR` en zero-page, ROM y modo inmediato. Es **semánticamente
seguro** (elimina solo escrituras no observadas) y **solo con `--chain`** (el camino host/tests
permanece byte-idéntico). Efecto medido: cuerpo por frame **579 k → 536 k**; `bb_F4ED` 622 → 538;
`bb_C7A8` (espera VBlank) 578 → 362.

---

## 5 ter. Cesión por evento (`cpu.yield`) — ejecutar frames con encadenado

Un bucle de espera de VBlank (`LDA $2002; AND #$80; BEQ self`) o de NMI (`JMP self`), con
encadenado, se convertía en un bucle en cola **infinito**: el runtime nunca recuperaba el control y
no podía avanzar PPU/NMI. Solución:

- Se detecta el bloque de espera (lee `$2002`, o `JMP` a sí mismo) y, en vez de encadenarse, **cede**:
  `cpu.yield = true; cpu.PC = inicio; return;`.
- El retorno de un `JSR` encadenado **propaga** la cesión: `bb_T(cpu); if (cpu.yield) return; …`, de
  modo que una cesión dentro de una subrutina sube por la pila C hasta el bucle de ejecución.
- El runtime limpia `yield`, resuelve los eventos (VBlank/NMI/sprite-0) y re-despacha en `PC`.

Así el código encadenado **es ejecutable** con el modelo de frame del Amiga (el timing fino lo da el
hardware, ver [`TIMING_AMIGA.md`](TIMING_AMIGA.md)). Coste: +~2 % de `.text` y ~1 % de ciclos
(comprobación de `yield` en los 402 `JSR`).

---

## 6. Medidas (Donkey Kong, GCC 15.1.0, `-m68000 -O3 -nostdlib`)

### 6.1 Tamaño y llamadas

| Versión | `.text` (-O2) | `.text` (-O3) | `jsr` estáticos |
|---|---:|---:|---:|
| base (`--release`) | 194 412 B | 203 220 B | 1 035 |
| `--amiga` (chain+rom+rmw) | 258 470 B | 299 088 B | 1 329 |
| `--amiga` (+ helper asm) | — | 298 646 B | ~1 300 |

El encadenado **agranda** el código (+~45 %): g++ inlinea/duplica bloques vecinos. En A500 (sin
caché de instrucciones) conviene vigilar el I-fetch; el asm caliente queda compacto (6.2).

### 6.2 Bloques calientes, antes vs después (asm real)

| Bloque | `jsr` base → `--amiga` | ciclos base → `--amiga` (+asm) |
|---|---|---:|
| `bb_F4FD` (`ROR $18..$1F` + RTS, 38 % de DK) | 11–16 → **0** | 2 150 → **~430** |
| `bb_C807` (`TAX; LDA abs,X; STA zp; JMP`) | 2 → **0** | — |
| `bb_C7A8` (espera VBlank) | 7 → **1** (solo `read $2002`) | 448 → 578 |
| `bb_C7B9` (relleno `STA (zp),Y`) | 1 → 1 (`write` a RAM) | — |

**`bb_C807` con `--amiga`**: `TAX` en línea, `LDA $C4A7,X` → `n2a_prg[1191+X]`, `STA $00` →
`move.b d0,(a1)`, `JMP` → `jra bb_F228`. **Cero llamadas y cero despacho.**

**`bb_F4FD`** (33 líneas de asm): el bloque se reduce a fijar PC, `a1 = ram + 0x18`, y el bucle asm
de `roxr` (8 bytes, ~3 instrucciones/byte) + materialización de flags. De ~2 150 a **~430 ciclos**.

### 6.3 Coste dinámico por frame (perfil `dk.hot.txt`, 302 frames)

Modelo: ciclos estáticos por bloque (estimador sobre `objdump`, tabla MC68000) × ejecuciones
dinámicas, sumado y dividido por frames. **Consistente entre versiones** (mismo estimador).

| Componente | base | `--amiga` + asm + liveness + yield |
|---|---:|---:|
| Cuerpos de bloque | 1 188 986 | **536 190** |
| Despachador (base: 1 733 despachos × ~1 440; amiga: ~60 entradas) | 2 495 520 | ~86 000 |
| **Total ciclos/frame** | **≈ 3 684 500** | **≈ 622 000** |
| **fps a 7,09 MHz** | **~1,9** | **~11,4** |

**Mejora ≈ ×6** (de ~1,9 a ~11,4 fps). El despachador deja de ser el cuello, el bucle de PRNG baja
~5× y la liveness recorta el estado en memoria. Lo que queda (~536 k ciclos/frame) sigue dominado
por el **estado del 6502 en memoria** (A/X/Y/flags como campos del `struct`) y las **fronteras de
función** (prólogo/PC/aliases por bloque): para llegar a 1:1 hace falta el paso 1 de §8
(estado en registros / *flattening*).

---

## 7. Uso

```bash
# Perfil Amiga/68000 recomendado (sin ciclos + encadenado + ROM/ZP directas)
nes_transpiler juego.nes --amiga -o juego_amiga.cpp
# o granular:
nes_transpiler juego.nes --no-cycles --chain --rom-direct --fast-ram -o juego_amiga.cpp
```

- `--rom-direct` / `--chain` / `--fast-ram` son **opt-in**; **sin flags la salida es byte-idéntica**
  a la anterior (verificado), así que el camino host y los tests no cambian.
- `--amiga` agrupa los cuatro (`--no-cycles`, `--chain`, `--rom-direct`, `--fast-ram`).

---

## 8. Qué queda (por orden de impacto)

1. **Estado del 6502 en registros** (A/X/Y/flags) en vez de `struct` en memoria: es el cuello
   principal. La **liveness de flags** (§5 bis) ya recorta parte; lo que falta es mantener el estado
   en registros **entre** bloques. GCC-15 **ignora los *register pins*** → exige un **runtime en asm**
   o ***flattening* por región** con `goto` (y una **tabla de retorno** para `RTS` con *computed
   goto*, evitando la tabla de 256 KB que descartó `--flat`). Es el siguiente gran paso.
2. **Generalizar el helper asm a más idioms**: el PRNG (38 % de DK) ya está (técnica 4); quedan
   candidatos de otros juegos (copias `(zp),Y`, sumas multibyte). El patrón (detección + rutina asm)
   es reutilizable pero no hay más idioms calientes en *este* título.
3. **`--rom-direct` para mappers bancados**: emitir el acceso por la *bank window* (array por banco)
   en vez del `read` genérico, manteniendo el plegado donde el banco sea estático.
4. **HLE de rutina completa** (VBlank, retardos, rellenos→Blitter) y **vídeo/audio a Copper/Blitter/
   Paula**.

> **Hecho en esta ronda:** (1) liveness de `Z/N` (§5 bis) y (2) cesión por evento con `cpu.yield`
> (§5 ter), que desbloquea ejecutar frames con el control encadenado.

---

## Anexo — Evidencia

- Cambios: `tools/transpiler/src/transpiler.hpp` (`set_chain`, `set_rom_direct`, `emit_rom_inline`,
  constantes para `Abs`, extensión de `emit_zp_inline`, coalescencia de `ROR/ROL zp`, aliases
  `n2a_ram`/`n2a_prg`), `tools/transpiler/src/main.cpp` (`--chain`, `--rom-direct`, `--amiga`),
  `runtime/include/nes_runtime.hpp` (`n2a_ror_run`/`n2a_rol_run` con asm m68k + máscara de PRG).
- Comandos de build/medida en [`MEDICION_CODEGEN_68000_DK.md`](MEDICION_CODEGEN_68000_DK.md) §1
  (sustituyendo `--release` por `--amiga`).
- Verificado: salida por defecto byte-idéntica; `--amiga` compila a `.o` m68k **sin símbolos
  indefinidos**; equivalencia del helper (71 982 casos) en host; toolchain `-Wall -Wextra` limpio.
