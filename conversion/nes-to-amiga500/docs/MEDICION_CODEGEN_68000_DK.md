# Medición real del codegen 6502 → 68000 (Donkey Kong, toolchain de Amiga-Cpp)

Este documento **mide** (no estima) qué hace el compilador cruzado real del engine (`m68k-amiga-elf-g++`
de `vscode-amiga-debug`) con el C++ que emite **nuestro transpilador** para una ROM NES, y compara el
**coste funcionalmente equivalente** de submódulos 6502 frente al 68000. Complementa
[`ANALISIS_VIABILIDAD_1A1.md`](ANALISIS_VIABILIDAD_1A1.md) (que era un modelo analítico): aquí hay
**ensamblador real de los dos lados**.

> **Actualización.** Las técnicas propuestas en §7 ya están **implementadas y medidas** en
> [`CODEGEN_AMIGA_CHAIN_ROM.md`](CODEGEN_AMIGA_CHAIN_ROM.md): encadenado de bloques, lectura directa
> de ROM y zero-page ampliada llevan DK de **~1,9 a ~7,5 fps (×3,9)** y dejan los bloques calientes
> sin llamadas ni despacho.

> **Conclusión adelantada.** El código que generaba el transpilador (antes de los cambios), compilado
> con el toolchain del engine, corría a **~2–3 fps** en un A500 para Donkey Kong. El cuello no es la ALU del 68000 (que
> compila bien las operaciones) sino la **estructura del código generado**: **despacho por búsqueda
> binaria en cada bloque** (~1 500 ciclos/bloque, ~4,4 instrucciones/bloque → ~360 ms/frame solo
> despachando), **llamadas no inlineadas a `NESMemory::read/write`** en el camino caliente y **estado
> del 6502 en memoria** (no en registros). Pasar de ~2 fps a 1:1 exige cambiar la forma de emitir el
> código, no afinar flags.

---

## 1. Entorno y reproducibilidad

| Elemento | Valor |
|---|---|
| Toolchain destino | `vscode-amiga-debug/bin/win32/opt/bin/m68k-amiga-elf-g++` — **GCC 15.1.0** |
| Flags de compilación | los de `Amiga-Cpp/tools/build/build-demo.sh`: `-std=gnu++23 -m68000 -O2 -nostdlib -fomit-frame-pointer -fno-exceptions -fno-rtti -fno-threadsafe-statics -fno-use-cxa-atexit -ffunction-sections -fdata-sections` |
| Transpilador | `tools/transpiler/src/main.cpp`, compilado en host con MinGW **g++ 16.2.0** (el `.exe` del repo no arrancaba: `STATUS_DLL_NOT_FOUND`) |
| ROM | `roms/nes/Donkey Kong (World) (Rev A).nes` (NROM) |
| Salida | `dk_amiga.cpp` — **6014 instrucciones, 2117 bloques** |

Comandos reproducibles:

```bash
# 1. Transpilar (host)
g++ -std=gnu++23 -O2 -static -I<Amiga-Cpp>/engine/include -Itools/transpiler/src \
    tools/transpiler/src/main.cpp -o /tmp/nes_transpiler_host
/tmp/nes_transpiler_host "roms/nes/Donkey Kong (World) (Rev A).nes" --release -o dk_amiga.cpp

# 2. Compilar a ensamblador 68000 con el toolchain real del engine
m68k-amiga-elf-g++ -std=gnu++23 -m68000 -O2 -nostdlib -fomit-frame-pointer \
  -fno-exceptions -fno-rtti -fno-threadsafe-statics -fno-use-cxa-atexit \
  -ffunction-sections -fdata-sections \
  -Itools/m68k/shim -Iruntime/include -S dk_amiga.cpp -o dk_amiga_O2.s
# (cambiar -O2 por -O3 / -Os; añadir --facts dk.hot.txt al transpilar para el modo heat)
```

**Tamaño y aviso de enlazado (evidencia):**

```
$ m68k-amiga-elf-size dk_amiga.o
   text    data     bss     dec     hex
 194412   10338       0  204750   31fce     # -O2
 180898   10338       0  191236   2eb04     # -O2 + --facts dk.hot.txt (heat)

$ m68k-amiga-elf-nm dk_amiga.o | grep ' U '
         U __umodsi3
```

- `.text` ≈ **190–194 KB** (el `.bss` es 0, el despacho disperso funciona).
- **`__umodsi3` indefinido**: el `NESMemory::read` emitido usa `idx % prg_size` (runtime), que en 68000
  es una *libcall*; con `-nostdlib` **el enlazado falla**. Es exactamente el defecto documentado en
  `Amiga-Cpp/docs/reference/toolchain/m68k-gcc.md` §2. Hay que sustituir el módulo por máscara
  (potencia de dos) en el camino de PRG.

---

## 2. Perfil dinámico de la ROM (medido, 60 frames)

`opcode_hist.exe dk.nes 60`:

| Opcode | Veces | % |
|---|---:|---:|
| `66 ROR` | 172 353 | **37,9 %** |
| `29 AND` | 46 583 | 10,2 % |
| `A5 LDA` | 44 121 | 9,7 % |
| `F0 BEQ` | 25 572 | 5,6 % |
| `85 STA` | 23 053 | 5,1 % |
| `20 JSR` | 22 034 | 4,8 % |
| `60 RTS` | 22 033 | 4,8 % |
| `4C JMP` | 21 665 | 4,8 % |
| `18 CLC` | 21 570 | 4,7 % |
| `45 EOR` | 21 545 | 4,7 % |

- **455 359 instrucciones / 60 frames = 7 589 instrucciones/frame**.
- El bucle caliente es un desplazamiento/PRNG de 64 bits: `F4ED: LDA $18; AND #$02; STA $00; …` →
  `F4FD: ROR $18 … ROR $1F` (9 `ROR zp`), ~110 989 ejecuciones.

`dk.hot.txt` (telemetría por instrucción) cruzado con los inicios de bloque del C++ generado
(2117 bloques, todos con calor):

| Métrica | Valor |
|---|---:|
| Instrucciones dinámicas (suma) | 2 289 769 |
| Despachos dinámicos (suma en inicios de bloque) | **523 337** |
| Instrucciones por bloque (dinámico) | **4,38** |
| Despachos por frame NES | **~1 733** |

---

## 3. El despachador: el coste dominante (ensamblador real)

`game_main` (extracto de `dk_amiga_O3.s`), búsqueda binaria **repetida en cada bloque**:

```asm
_Z9game_mainv:
	movem.l #14368,-(%sp)
	...
.L6807:                       ; <-- se recarga en CADA bloque devuelto
	move.w #2117,%d1
	clr.w %d2
.L6812:
	moveq #0,%d0
	move.w %d1,%d0
	sub.l %d4,%d0
	lsr.l #1,%d0
	move.w %d2,%a0
	add.w %d0,%a0
	moveq #0,%d0
	move.w %a0,%d0
	lsl.l #3,%d0              ; índice * 8 (sizeof(BankBlock))
	move.w (%a2,%d0.l),%a1
	cmp.w %a1,%d3
	jeq .L6821
	jhi .L6822
	move.w %a0,%d1
	cmp.w %d1,%d2
	jcs .L6812
...
.L6821:
	move.l 4(%a2,%d0.l),%a0
	pea _ZL7g_state
	jsr (%a0)                ; llama al bloque bb_* (con push de g_state)
```

**Coste por iteración** (~20 instrucciones, tabla MC68000): ≈ **120 ciclos**. Con 2117 entradas,
`log2(2117) ≈ 12` iteraciones → **≈ 1 440 ciclos** de búsqueda + ~100 del `jsr`/`pea` →
**≈ 1 500 ciclos por bloque despachado**.

**Impacto por frame:** `1 733 × 1 500 ≈ 2,6 M ciclos/frame ≈ 366 ms → ~2,7 fps solo despachando**
(presupuesto real-time ≈ 141 k ciclos PAL / ~119 k NTSC). Es **~18× el frame entero**.

> Esto **corrige** la estimación del documento anterior (escenario A: 600 k–1,3 M): el caso real es
> peor porque el tamaño de bloque **dinámico** es 4,38 (no 2,29 estático) y la búsqueda tiene 12 pasos.

**Arreglo necesario:** encadenar los bloques de destino estático (salto/llamada directa, sin volver al
despachador) y reservar la búsqueda para saltos indirectos/NMI. En host se devolvía para el *yield* de
la PPU; en Amiga ese motivo no existe (el timing lo da el hardware).

---

## 4. Comparación lado a lado (6502 | C++ generado | 68000 real)

Leyenda de ciclos: los del 6502 son reales; los del 68000 se cuentan sobre el ensamblador mostrado con
la tabla del MC68000 (≈ ±15 %). «Presupuesto» = `ciclos6502 × (7,09/1,79) ≈ ×3,96` (los ciclos Amiga
disponibles si el 68000 rindiera como el 6502). Ratio = coste / presupuesto **sin contar despacho**.

### 4.1 Espera de VBlank — `bb_C7A8` (3 instrucciones)

| 6502 | C++ generado | 68000 (`-O3`) |
|---|---|---|
| ```C7A8: LDA $2002```<br>```C7AB: AND #$80```<br>```C7AD: BEQ $C7A8``` | `cpu.LDA_abs(0x2002);`<br>`cpu.AND_imm(0x80);`<br>`if (cpu.Z) { cpu.PC=0xC7A8; return; }`<br>`cpu.PC=0xC7AF; return;` | ver abajo |

```asm
_ZL7bb_C7A8RN3n2a3CPUE:
	subq.l #4,%sp
	move.l %d3,-(%sp)          ; prólogo (salva registros)
	move.l %d2,-(%sp)
	move.l 16(%sp),%a0
	move.l 22(%a0),%a1         ; a1 = cpu.mem
	move.l 10296(%a1),%d0      ; io_read
	jeq .L4154
	pea 8194.w                 ; $2002
	move.l 10292(%a1),-(%sp)
	jsr (%a1)                  ; <-- LLAMADA al handler de E/S (no inlineada)
	...
.L4154:                        ; camino standalone (io_read==NULL)
	move.b 2050(%a1),%d0       ; lee el registro sombra de PPU
	jra .L4155
.L4155:
	move.b %d0,%d2
	and.b #-128,%d2            ; resultado del AND
	move.b %d0,%d1
	not.b %d1
	lsr.b #7,%d1               ; Z = !(bit7)
	move.b %d0,%d3
	lsr.b #7,%d3               ; N = bit7
	move.w %d3,%a1
	tst.b %d0
	jge .L4157
	move.w #-14417,%d0         ; PC = $C7AF
	move.b %d2,(%a0)           ; A
	move.b %d1,7(%a0)          ; Z (byte)
	move.b %d1,11(%a0)         ; N (byte)
	move.w %d0,4(%a0)          ; PC
	move.l (%sp)+,%d2
	move.l (%sp)+,%d3
	addq.l #4,%sp
	rts
```

| | 6502 | Presupuesto | 68000 sin despacho | Ratio |
|---|---:|---:|---:|---:|
| 1 iteración | 9 | 36 | **≈ 280** | **7,8×** |
| con despacho | 9 | 36 | ≈ 1 780 | **49×** |

**Observaciones de g++:** pliega la dirección `$2002` como inmediato; mantiene N/Z en registros y los
materializa como **bytes** al salir; duplica el epílogo por camino (aceptable). **No** inlinea el
`read` de PPU (lo hace llamada). En el runtime real de Amiga `io_read` sería el handler HLE → coste aún
mayor. Este bucle debe **desaparecer** con HLE (`n2a_wait_vblank`), no optimizarse.

### 4.2 Carga indexada de tabla ROM — `bb_C807` (5 instrucciones)

| 6502 | C++ | 68000 (`-O3`) |
|---|---|---|
| ```C807: TAX```<br>```C808: LDA $C4A7,X```<br>```C80B: STA $00```<br>```C80D: LDA $C4A8,X```<br>```C810: STA $01```<br>```C812: JMP $F228``` | `cpu.TAX();`<br>`cpu.LDA_absx(0xC4A7);`<br>`cpu.STA_zp(0x00);`<br>`cpu.LDA_absx(0xC4A8);`<br>`cpu.STA_zp(0x01);`<br>`cpu.PC=0xF228; return;` | ver abajo |

```asm
_ZL7bb_C807RN3n2a3CPUE:
	move.l %a3,-(%sp)
	move.l %a2,-(%sp)
	move.l 12(%sp),%a2
	move.b (%a2),%d0           ; A
	move.b %d0,1(%a2)          ; X = A   (TAX en línea, sin llamada)
	seq %d1                    ; Z/N de TAX
	neg.b %d1
	move.b %d1,7(%a2)
	move.b %d0,%d1
	lsr.b #7,%d1
	move.b %d1,11(%a2)
	and.w #255,%d0
	add.w #-15193,%d0          ; $C4A7 + X
	move.w %d0,-(%sp)
	clr.w -(%sp)
	move.l 22(%a2),-(%sp)
	lea _ZNK3n2a9NESMemory4readEt,%a3
	jsr (%a3)                  ; <-- LLAMADA; NO se pliega el byte de ROM
	move.b %d0,(%a2)           ; A
	seq %d1 ; neg.b %d1 ; move.b %d1,7(%a2)
	move.b %d0,%d1 ; lsr.b #7,%d1 ; move.b %d1,11(%a2)
	move.l 22(%a2),%a0
	move.b %d0,(%a0)           ; STA $00  (RAM directa, inlineado)
	...                        ; (repite para $C4A8 -> STA $01)
	move.w #-3544,4(%a2)       ; PC = $F228
	rts
```

| | 6502 | Presupuesto | 68000 sin despacho | Ratio |
|---|---:|---:|---:|---:|
| bloque | 19–21 | 79 | **≈ 500** | **6,3×** |

**Observaciones de g++:**
- **Bien:** `TAX` inlineado; los `STA zp` a RAM (`$00`,`$01`) se compilan a `move.b Dn,(mem+off)` directo.
- **Mal (clave):** `LDA $C4A7,X` es una **llamada** a `read` porque la ROM se lee a través del puntero
  `mem->prg` (runtime). Como `PRG_ROM` es `constexpr`, **g++ podría plegar el byte**, pero el código
  nunca le enseña el valor: `LDA_absx` → `mem->read()` → `prg[idx % prg_size]`. **La mayor optimización
  posible con “datos de ROM fijos” no se aprovecha.** Emitir `PRG_ROM[addr]` directo (o pasar las
  lecturas de ROM como constantes/`N2A_ASSUME`) permitiría a g++ plegar tablas enteras.

### 4.3 Almacén indirecto en bucle — `bb_C7B9` (3 instrucciones)

| 6502 | C++ | 68000 (`-O2`) |
|---|---|---|
| ```C7B9: STA ($00),Y```<br>```C7BB: DEY```<br>```C7BC: BNE $C7B9``` | `cpu.STA_indy(0x00);`<br>`cpu.DEY();`<br>`if (!cpu.Z) { cpu.PC=0xC7B9; return; }` | ver abajo |

```asm
_ZL7bb_C7B9RN3n2a3CPUE:
	move.l %a2,-(%sp)
	move.l 8(%sp),%a2
	move.l 22(%a2),%a0
	moveq #0,%d0
	move.b (%a2),%d0           ; A
	move.l %d0,-(%sp)          ; ¡A por PILA!
	move.w (%a0),%d0           ; puntero zp $00
	ror.w #8,%d0
	clr.w %d1
	move.b 2(%a2),%d1          ; Y
	add.w %d1,%d0
	move.w %d0,-(%sp)
	clr.w -(%sp)
	move.l %a0,-(%sp)
	jsr _ZN3n2a9NESMemory5writeEth   ; <-- LLAMADA (write no inlineado)
	move.b 2(%a2),%d0
	subq.b #1,%d0              ; DEY
	seq %d1 ; move.w %d1,%a1
	move.b %d0,%d1 ; lsr.b #7,%d1
	move.w %d1,%a0
	tst.b %d0
	jne .L5689
	...                        ; guarda Z, N, PC = $C7BE y rts
```

| | 6502 | Presupuesto | 68000 sin despacho | Ratio |
|---|---:|---:|---:|---:|
| iteración | 11 | 44 | **≈ 450** | **10,2×** |
| con despacho | 11 | 44 | ≈ 1 950 | **44×** |

**Observaciones:** el `write` a RAM sale como **llamada con 3 argumentos por pila** a pesar de ser un
camino trivial. El propio `write` (172 bytes de asm) resuelve `< $2000` con `and #2047` + `move.b`.
Este bucle de relleno debería ser **un Blitter** (HLE), no código.

### 4.4 Setup de registros PPU + `JSR` — `bb_C7E7` (12 instrucciones)

C++ generado: ver §`dk_amiga.cpp`. En el 68000 (`-O3`) el bloque contiene **15 `jsr`**: la mayoría de
`STA_abs(0x200x)` llaman a `NESMemory::write` (no inlineado) con 3 argumentos por pila.

| | 6502 | Presupuesto | 68000 sin despacho | Ratio |
|---|---:|---:|---:|---:|
| bloque | 40 | 158 | **≈ 1 500–2 000** | **~10–13×** |

**Observaciones:** las constantes (`#$10`, `#$06`, `#$00`) se pliegan bien, pero **cada escritura a PPU
cuesta una llamada + decodificación completa del bus**. El HLE (convertir `$2000/$2001/$2005` en
parches de Copper list / punteros de plano) es aquí lo que decide.

### 4.5 NMI con OAM DMA — `bb_C85F` (14 instrucciones)

Incluye `STA $4014` (OAM DMA de 256 bytes). En 68000 el coste real sería la llamada al handler que
copia los 256 bytes (~2 000–3 000 ciclos si es byte a byte) o el Blitter (HLE).

| | 6502 | Presupuesto | 68000 sin despacho | Ratio |
|---|---:|---:|---:|---:|
| bloque | 43 | 170 | **≈ 1 800–3 400** | **~11–20×** |

### 4.6 El bucle caliente real — `bb_F4FD` (9× `ROR zp`, 38 % de la ROM)

```asm
_ZL7bb_F4FDRN3n2a3CPUE:
	movem.l #8248,-(%sp)
	move.l 20(%sp),%a2
	pea 24.w
	move.l 22(%a2),-(%sp)
	lea _ZNK3n2a9NESMemory4readEt,%a4
	jsr (%a4)                  ; ---- ROR $18 : READ ----
	move.b 6(%a2),%d1          ; C actual
	move.b %d0,%d2
	and.b #1,%d2
	move.b %d2,6(%a2)          ; nuevo C
	lsr.b #1,%d0
	lsl.b #7,%d1
	or.b %d1,%d2
	moveq #0,%d0
	move.b %d2,%d0
	move.l %d0,-(%sp)
	pea 24.w
	move.l 22(%a2),-(%sp)
	lea _ZN3n2a9NESMemory5writeEth,%a3
	jsr (%a3)                  ; ---- ROR $18 : WRITE ----
	...                        ; y así 9 veces (ROR $18..$1F)
```

**Cada `ROR zp` = 1 llamada a `read` + 1 llamada a `write` + ~10 instrucciones de rotación/flags.**
El bloque (9 ROR) tiene **~16–18 `jsr`**.

| | 6502 | Presupuesto | 68000 sin despacho | Ratio |
|---|---:|---:|---:|---:|
| bloque (9 ROR) | 45 | 178 | **≈ 2 800** | **~15,7×** |

**Observaciones:** aunque el 68000 tiene `ror`/`roxr` nativos, el código **no los usa a nivel de
registro**: cada `ROR zp` está expresado como *leer de RAM + rotar + escribir a RAM + set_nz*, con dos
llamadas de por medio. Es el ejemplo más claro de que el problema es **la representación** (memoria y
funciones), no la arquitectura. Un `ror.b` sobre registro, o el desplazamiento de 64 bits completo
en registros, costaría una fracción.

---

## 5. Resumen cuantitativo (sin despacho)

| Bloque | instrucciones | ciclos 6502 | presupuesto | 68000 real | ratio |
|---|---:|---:|---:|---:|---:|
| `bb_C7A8` VBlank wait | 3 | 9 | 36 | ~280 | 7,8× |
| `bb_C807` tabla ROM | 5 | 20 | 79 | ~500 | 6,3× |
| `bb_C7B9` store indirecto | 3 | 11 | 44 | ~450 | 10,2× |
| `bb_C7C5` init mixto | 13 | 40 | 158 | ~1 100 | 7,0× |
| `bb_C7E7` PPU setup + JSR | 12 | 40 | 158 | ~1 500–2 000 | ~11× |
| `bb_C85F` NMI + OAM DMA | 14 | 43 | 170 | ~1 800–3 400 | ~15× |
| `bb_F4FD` 9× ROR zp | 9 | 45 | 178 | ~2 800 | 15,7× |

**Media ponderada (por el mix de DK): ≈ 10–15× por encima del presupuesto**, y **~30–45× con el
despachador**. Traducido a fps: **~2–3 fps** (dominado por despacho) y **~20–25 fps** incluso si el
despacho fuera gratis. Muy lejos de 1:1.

---

## 6. Cómo optimiza g++ este código (evaluación)

### 6.1 Lo que hace bien

1. **Plegado de direcciones constantes**: `$2000`, `$0511`, `$18`, `$C4A7`… se convierten en
   inmediatos/desplazamientos.
2. **Accesos a RAM inlineados**: cuando el destino es `< $2000` y g++ decide inlinear `write`, genera
   `move.b Dn,(mem+off)` directo (p. ej. `move.b #127,1297(%a0)`), sin llamada.
3. **Plegado de inmediatos y flags**: `LDA #1` → `move.b #1,(%a2); clr.b Z; clr.b N`; las ramas usan
   el CCR (`tst.b`/`subq.b`/`seq`) sin recalcular.
4. **Inlining parcial de métodos de CPU a `-O3`** (`TAX`, `LDA_absx` y algún `STA zp`).
5. **Reacción al calor** (`--facts`): marca `hot`/`cold` y con `-ffunction-sections` separa
   `.text.hot.<fn>` / `.text.unlikely.<fn>`; `.text` baja **194 412 → 180 898 B (−7 %)**.
6. **Cold/hot splitting y `-O3`** producen asm limpio a nivel de bloque.

### 6.2 Lo que no puede (y por qué)

1. **No inlinea `NESMemory::read`/`write` de forma consistente**: son grandes (88/54 líneas) y se usan
   en 2117 funciones → g++ prioriza tamaño y emite **llamadas indirectas** (`lea _sym,%aN; jsr (%aN)`),
   con ABI de **argumentos por pila** (3 `push` + limpieza). Coste por acceso: **~130–190 ciclos**.
2. **Estado del 6502 en memoria**: `A/X/Y/flags/PC` viven en el `struct CPU`; entre bloques no hay
   asignación a registros. `set_nz` se materializa como **bytes** en offsets fijos.
3. **No hay asignación global de registros**: dentro de un bloque sí, entre bloques no. Y el propio
   GCC 15.1 **ignora los *register pins*** (`register T* p asm("a0")`), como documenta
   `Amiga-Cpp/.../OPTIMIZACION_GPP_68000.md` §9 → la vía de “fijar estado 6502 a registros” desde C++
   **no es fiable**; hay que ir a **asm** (o a un runtime escrito en `.s`).
4. **No pliega la ROM pese a ser `constexpr`**: la lectura pasa por `mem->prg` (puntero runtime) y
   `idx % prg_size`. Se pierde el plegado de tablas, que es *la* optimización natural con datos fijos.
5. **`__umodsi3`**: el módulo por `prg_size` genera libcall prohibida en `-nostdlib`.
6. **Sin encadenado de bloques**: cada bloque vuelve al despachador (búsqueda binaria de 12 pasos).

### 6.3 Veredicto

g++ hace un buen trabajo **local** (bloque a bloque: plegado, flags, RAM directa) pero **no puede
recuperar la estructura global** que este *workload* necesita. La abstracción elegida
(métodos de instancia + estado en `struct` + despacho por PC) **bloquea activamente** las tres
optimizaciones que más importan: **estado en registros**, **ROM como constantes** y **control de flujo
encadenado**. Coincide con la experiencia del propio engine: los bucles calientes acaban en `.s`.

---

## 7. Qué cambiar para acercarse a 1:1

Ordenado por impacto (todo medible con el arnés de §1):

1. **Encadenar bloques** (destino estático → salto/llamada directa; despacho solo para indirectos/NMI).
   Elimina ~2,6 M ciclos/frame. **Es el mayor factor, con diferencia.**
2. **Runtime de CPU en asm con registros fijados** (`A/X/Y/SP/flags` + punteros `RAM`/`PRG`), estado
   `constexpr`/pinned, y `read`/`write` como rutinas cortas inlineadas. GCC-15 no respeta pins → `.s`.
3. **Exponer la ROM como constantes al compilador** (indexación directa de `PRG_ROM` o `N2A_ASSUME`
   por dirección) para plegar tablas. Sustituir `% prg_size` por máscara.
4. **HLE de rutina completa**: esperas de VBlank/retardos, bucles de relleno/copia (Blitter) y el
   bucle `ROR` (38 % de DK) reconocido y sustituido.
5. **Fusionar operaciones de 16/32 bits** donde el analista reconoce el patrón (contadores/PRNG):
   donde el 68000 gana 6–18× (ver `ANALISIS_VIABILIDAD_1A1.md` §3 G).

Con 1–4, el objetivo de la estimación previa (escenario C: 55–95 k ciclos/frame para juegos ligeros)
es alcanzable; juegos densos seguirán pidiendo frameskip. **Medir cada paso en WinUAE-DBG** (contador
de ciclos del periférico, como en `Amiga-Cpp/.../OPTIMIZACION_GPP_68000.md` §9.1).

---

## Anexo — Muestra de asm (evidencia cruda)

- `bb_C7A8`, `bb_C7B9`, `bb_C7C5`, `bb_C7E7`, `bb_C85F`, `bb_C807`, `bb_F4FD`, `read`, `write`,
  `game_main`: extraídos de `dk_amiga_O3.s` / `dk_amiga_O2.s` (regenerables con los comandos de §1).
- Los artefactos intermedios (`.cpp`, `.s`, `.o`) se generan en un directorio temporal de trabajo; no
  se versionan por tamaño. La ROM de origen no se versiona (`roms/` es de uso local).
