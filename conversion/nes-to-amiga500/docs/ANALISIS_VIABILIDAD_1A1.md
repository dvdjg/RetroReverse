# Análisis de viabilidad temporal 1:1 (NES 6502 → Amiga 500 68000)

**Pregunta que responde este documento.** *¿Podemos ejecutar la lógica de una ROM NES a velocidad
1:1 (un frame NES por frame Amiga, sin frameskip) en un A500 stock?* Para contestarla contrastamos
secuencias **reales** de 6502, el **C++ que emite hoy nuestro transpilador**, el **68000 que g++
genera** para ese C++ y, sobre todo, el **tiempo** que cada cosa consume, junto con el trabajo que hay
que sacar de la CPU hacia **Copper + Blitter + sprites HW + Paula**.

> **Naturaleza de las cifras.** Los ciclos del 6502 y los `cpu.cycles` del runtime son **medidos**
> (repo). Los ciclos del 68000 y el código que emite g++ son un **modelo analítico** basado en la
> tabla de tiempos del *MC68000 User's Manual* y en cómo g++ `-m68000 -O2` compila este estilo de
> código; **no** se han medido en hardware en este entorno (no hay `m68k-amiga-elf-g++` instalado).
> Cada afirmación lleva su grado de confianza. La validación real (WinUAE-DBG + cronómetro de beam)
> queda listada en §9.

---

## 0. Resumen ejecutivo

| Escenario | Coste CPU Amiga por frame NES (estimado) | Presupuesto ~80 k clocks | ¿1:1? |
|---|---:|---:|---|
| **(A)** Transpilación literal actual (1 función/bloque + despacho por PC + estado en memoria + flags `bool`) | **600 k – 1 300 k** | 7–16× por encima | **No** (5–10 fps) |
| **(B)** Transpilado optimizado: bloques encadenados, estado de CPU en registros, *N/Z* en CCR, `--no-cycles` | **170 k – 280 k** | 2–3,5× por encima | **No** (~25–40 fps) |
| **(C)** HLE fuerte + (B): se eliminan esperas de VBlank, retardos, bucles de copia y render; Blitter/Copper/Paula hacen el vídeo/audio | **55 k – 95 k** | dentro de presupuesto | **Sí en juegos ligeros/medios; no en los pesados** |

> **Corrección medida (ver [`MEDICION_CODEGEN_68000_DK.md`](MEDICION_CODEGEN_68000_DK.md)).** Con el
> toolchain real del engine, Donkey Kong transpilado despacha **~1 733 bloques/frame** con búsqueda
> binaria de 12 pasos (~1 500 ciclos/bloque): **~2,6 M ciclos/frame solo en despacho → ~2,7 fps**. El
> escenario (A) real es por tanto **peor** que la estimación de la tabla (~2–3 fps, no 5–10). No cambia
> el veredicto; refuerza que el encadenado de bloques es la palanca #1.

**Veredicto (confianza media-alta).** Con el diseño **actual** del codegen, **1:1 es imposible** en
un A500 stock. La causa no es el 68000 (es ~1,3–1,5× un 6502 a igualdad de instrucciones), sino el
**coste estructural**: el 68000 efectivo con DMA de planos activo queda **a la par de un 6502 a
1,79 MHz**, y nuestro codegen paga *dos veces* por cada operación (estado de CPU + RAM emulada), más
un **despachador de búsqueda binaria en cada rama** (2117 bloques en Donkey Kong, **2,29
instrucciones por bloque**). 1:1 solo se alcanza si (1) se **registra** el estado del 6502 en
registros fijos del 68000, (2) se **encadenan** los bloques (sin despacho por rama) y (3) se hace
**HLE de rutina completa** (no solo de escrituras de PPU), dejando al 68000 **solo la lógica** y a los
coprocesadores el vídeo/sonido. Aun así, los juegos densos (MMC3 con mucha lógica y sprites) pedirán
**frameskip adaptativo** (~30–40 fps), que es una salida legítima y ya prevista en el roadmap.

---

## 1. Cómo se ha hecho el análisis

1. **Cota superior del original.** Se usan las medidas del propio repo:
   - `docs/TIMING_AMIGA.md` §8: SMB **29 668 ciclos 6502/frame** (99,6 % del frame NTSC).
   - `docs/TIMING_CODEGEN.md`: traza de Metroid **650 489 instrucciones / 60 frames** →
     **10 841 instrucciones 6502 por frame**.
   - Media: **2,74 ciclos/instrucción**.
2. **Código generado real.** Se citan bloques literales de
   `tools/transpiler/generated/dk_nocyc.cpp` (Donkey Kong, `--no-cycles`, el que se compilaría para
   Amiga) y de `tools/transpiler/generated/mini.cpp`.
3. **Mix de instrucciones real** de DK (cuenta estática sobre el `.cpp` generado):
   `LDA_imm` 634, `STA_zp` 594, `JSR_abs` 402, `LDA_zp` 394, `CMP_imm` 340, `RTS` 251, `STA_abs` 147,
   `LDX_zp` 138, `LDA_absx` 121, `STA_zpx`/`LDA_zpx` ~90, `LDA_abs` 82, `TAX` 81, `CLC` 80, `AND_imm` 75,
   `INY` 74, `LSR_A`/`ASL_A` ~58, `ADC_imm` 53, `INC_zp` 53…
4. **Modelo 68000.** Tiempos del MC68000 (§Anexo A) aplicados a lo que g++ `-m68000 -O2` suele
   emitir para acceso a `struct` (campos desplazados), `set_nz`, escrituras a `NESMemory` y llamadas.
5. **Presupuesto de frame Amiga** con contención de bus por DMA (§2).

---

## 2. Presupuestos de tiempo

### 2.1 NES (NTSC)

| Magnitud | Valor |
|---|---:|
| Reloj CPU | 1,789773 MHz |
| Ciclos CPU / frame | **29 780,5** (60,0988 Hz) |
| Instrucciones / frame (medido, Metroid) | **10 841** |
| Ciclos / instrucción (media) | **2,74** |
| Duración del frame | **16,64 ms** |

### 2.2 Amiga 500 (68000 @ 7,09379 MHz PAL / 7,15909 MHz NTSC)

| Magnitud | PAL 50 Hz | NTSC 60 Hz |
|---|---:|---:|
| Clocks CPU / frame (brutos) | **141 876** | **119 116** |
| Duración del frame | 20,00 ms | 16,68 ms |
| Clocks por línea | 454 | 455 |

**Contención de bus (clave).** El 68000 no dispone de todos esos clocks: el DMA de *bitplanes*,
sprites, Copper y refresco le roba *slots* de memoria. En lores con varios planos la CPU queda
típicamente al **60–70 %** del máximo durante las líneas visibles; durante el VBlank (sin DMA de
planos) corre a plena velocidad. Cifra de trabajo: **~65 %** de media → **~92 k clocks usables por
frame PAL**, **~77 k por frame NTSC**.

> **Sanity check por MIPS.** Un 68000 a 7 MHz “puro” rinde ~0,5–0,7 MIPS; con DMA de planos baja a
> ~0,35–0,5 MIPS. Un 6502 a 1,79 MHz rinde ~0,35–0,5 MIPS. Es decir: **con el vídeo activo, el A500
> está aproximadamente a la par de un 6502**. Esto es coherente con A/NES y darkNESs, que exigen
> 68020+FastRAM. La ventaja del A500 no está en “más CPU”, sino en **no hacer el trabajo en la CPU**
> (Copper/Blitter/Paula).

### 2.3 El número que decide: clocks Amiga por instrucción 6502

Para 1:1 hay que producir 60,0988 frames NES/s:

- **NTSC:** 77 000 usables / 10 841 instrucciones = **7,1 clocks/instrucción**.
- **PAL 50 Hz:** como el frame PAL dura 20 ms y solo caben 50 por segundo, hay que ejecutar **1,202
  frames NES por frame PAL** (para no ralentizar) → 92 000 / (10 841 × 1,202) = **7,1 clocks/instrucción**.

**Presupuesto ≈ 7 clocks de 68000 por cada instrucción 6502.** El listón es durísimo: una sola
`move.b (An),Dn` cuesta **8 clocks**. Por tanto, **ejecutar literalmente cada instrucción 6502 es
matemáticamente insuficiente** salvo que:

- muchas instrucciones se **eliminen** (HLE de rutinas completas: esperas de VBlank, retardos,
  copias/rellenos, render), y/o
- varias instrucciones 6502 se **fusionen** en una 68000 de 16/32 bits (reescritura algorítmica).

Este es el eje de todo el análisis.

---

## 3. Contraste 6502 → C++ transpilado → 68000 (ejemplos reales)

### Notas sobre lo que g++ `-m68000 -O2` puede y no puede hacer

- **Dentro de un bloque** (código recto): g++ **sí** propaga y mantiene valores en registros, y
  puede **fusionar `set_nz` con la rama** (usar el CCR tras `move`/`subq`/`eor` sin materializar los
  `bool Z,N`). Esto es lo que hace que un bloque parezca “razonable”.
- **Entre bloques**: el estado vive en `struct CPU` (`.bss`): cada función recarga y reescribe
  `A/X/Y/flags/PC`. Ahí se pierde todo. El `--flat` (función única + `goto`/`computed goto`) se
  descartó en `OPTIMIZATION.md` por la tabla de 256 KB.
- **Direcciones absolutas**: `LDA $C4A7,X` obliga a `LEA` + `move.b (d8,An,Xn)` o PC-relativo.
- **Registros de PPU/APU** (`write(0x2000,…)`): pasan por `NESMemory::write`, que en el peor caso es
  una **llamada indirecta a `io_write`** → 20–40 clocks. Solo el HLE lo abarata.
- **Flags**: los `bool` de 6502 no son el CCR del 68000; g++ materializa bytes salvo liveness local.

### Ejemplo A — Operación zp más común (`LDA zp / EOR # / STA zp`)

Real, de `bb_C7C5` (`dk_nocyc.cpp:3778`):

```asm
C7D8: LDA $10      ; 3 ciclos
C7DA: EOR #$80     ; 2
C7DC: STA $2000    ; 4  (registro PPU)
C7DF: STA $10      ; 3
```
Ciclos 6502 del núcleo `LDA zp; EOR #imm; STA zp` = **8 ciclos** → presupuesto real-time
`8 × 3,96 ≈ 32 clocks` de 68000.

C++ generado (literal):

```cpp
cpu.LDA_zp(0x10);    // A = mem->read(0x10); set_nz(A)
cpu.EOR_imm(0x80);   // A ^= 0x80; set_nz(A)
cpu.STA_zp(0x10);    // mem->write(0x10, A)
```

**68000 “literal” (estado en memoria; `A5 = cpu`, `A6 = mem`)** — modelo:

```asm
move.b  16(a6),d1        ; LDA zp   : A = RAM[$10]              (d16,An)=12
move.b  d1,A(a5)         ; guarda A en el struct               (Dn,(d16,An))=12
tst.b   d1               ; set_nz                              4
seq.b   d2 ; move.b d2,Z(a5)   ; Z = (A==0)                    4+12
smi.b   d3 ; move.b d3,N(a5)   ; N = bit7                      4+12
move.b  A(a5),d1         ; recarga A para EOR                  (d16,An)=12
eor.b   #0x80,d1         ; EOR #$80 (fija N/Z)                 8
… (guarda A + Z/N otra vez:                       ~32)
move.b  A(a5),d1 ; move.b d1,16(a6)   ; STA zp               ~24
; PC = 0xC7E1; return                              ~28 + RTS 16
; despacho (búsqueda binaria, ~12 pasos)          ~150–200
```
**≈ 290–340 clocks por 3 instrucciones.** Presupuesto: 32. **~9–10× por encima.**

**68000 “optimizado” (estado *pinned* en registros: `A=D0`, `X=D1`, `Y=D2`, `mem=A6`, N/Z en CCR;
bloques encadenados, sin despacho):**

```asm
move.b  16(a6),d0        ; LDA zp: A=R[$10], fija N/Z en CCR    12
eor.b   #0x80,d0         ; EOR #$80, fija N/Z                   8
move.b  d0,16(a6)        ; STA zp: R[$10]=A                     12
```
**= 32 clocks.** Exactamente **el presupuesto**. Con esto, el par zp más frecuente **rompe a la par**.
La asignación de registros del 6502 a registros del 68000 es, por sí sola, la diferencia entre 10×
por encima y empatar.

> Nota de corrección: la escritura `LDA;EOR;STA` produce N/Z iguales en 6502 y en 68000 para `move` y
> `eor`, así que N/Z caben en el CCR sin materializarlos. `C`/`V`/`D`/`I` requieren tratamiento
> aparte (byte de flags o `Scc`), pero las ramas más frecuentes (`BNE/BEQ/BPL/BMI`) miran N/Z.

### Ejemplo B — Carga indexada de tabla (`TAX / LDA abs,X / STA zp`)

Real, de `bb_C807` (`dk_nocyc.cpp:3851`) y `bb_C853` (`:3930`):

```asm
C807: TAX
C808: LDA $C4A7,X    ; 4 (+1 si cruza página)
C80B: STA $00
C80D: LDA $C4A8,X    ; 4 (+1)
C810: STA $01
C812: JMP $F228
```
6502: **19–21 ciclos** → presupuesto `≈ 80 clocks`.

C++ generado:

```cpp
cpu.TAX(); cpu.LDA_absx(0xC4A7); cpu.STA_zp(0x00);
cpu.LDA_absx(0xC4A8); cpu.STA_zp(0x01);
cpu.PC = 0xF228; return;
```

**68000 literal:** `TAX` (mover A→X en struct: ~16–24 con flags), `LDA abs,X` = `LEA tabla(PC),A0`
(12) + `move.b (0,A0,D0.w),d1` (`(d8,An,Xn)`=14) + stores a A/X y flags (~24 cada); total
**≈ 130–180 clocks** más despacho (~150) → **~280–330**. Presupuesto 80 → **3,5–4×**.

**68000 optimizado:** con `X` en `D1`, `A` en `D0`, `PRG_ROM` en `A3`:
```asm
move.b  d0,d1                  ; TAX                      4
move.b  (0,a3,d1.w),d0         ; LDA tabla+0,X            14
move.b  d0,0(a6)               ; STA $00                  12
move.b  (1,a3,d1.w),d0         ; LDA tabla+1,X            14
move.b  d0,1(a6)               ; STA $01                  12
bra     L_F228                 ; encadenado               10
```
**= 66 clocks** contra un presupuesto de 80 → **1:1 con margen (~20 %)**. La página cero usada como
*destino* sigue costando 12 por escritura; si el VSA demuestra que `$00/$01` forman un puntero, puede
quedar todo en un registro.

### Ejemplo C — Secuencia de registros PPU + `JSR` (real, `bb_C7E7`)

```asm
C7E7: LDA #$10 ; 2      C7E9: STA $2000 ; 4
C7EC: STA $10  ; 3      C7EE: LDA #$06  ; 2
C7F0: STA $2001; 4      C7F3: STA $11   ; 3
C7F5: LDA #$00 ; 2      C7F7: STA $2005 ; 4
C7FA: STA $12  ; 3      C7FC: STA $2005 ; 4
C7FF: STA $13  ; 3      C801: JSR $CBAE ; 6
```
6502 total = **40 ciclos** → presupuesto `≈ 158 clocks`.

C++ generado: ver `dk_nocyc.cpp:3820`. **68000 literal:** cada `STA $200x` atraviesa `NESMemory::write`
(ramificación de rango + posible `io_write` indirecto): ~30–50 clocks cada uno; los `STA zp` ~24;
los `LDA #` ~16; el `JSR` (push16 + regreso + despacho por PC) ~180–260. **Total ≈ 480–650** →
**3–4× por encima**.

**68000 optimizado + HLE:** las constantes se pliegan; `$2000/$2001` se convierten en **parches de la
Copper list** (escribir 1 palabra en un buffer de chip RAM: ~8–12 clocks, o incluso diferido);
`$2005` → actualización de punteros de plano + `BPLCON1` (2–3 escrituras); los `STA zp` quedan en
registro si el VSA lo permite. Estimación **≈ 90–120 clocks** contra presupuesto 158 → **dentro**.
Aquí el HLE no acelera la CPU: **cambia lo que la escritura *significa*** (de “actualiza PPU software”
a “anota un cambio de hardware”), que es barato.

### Ejemplo D — Handler de NMI con OAM DMA (real, `bb_C85F`, `dk_nocyc.cpp:3945`)

```asm
C85F: PHA          ; 3     C860: LDA $10   ; 3
C862: AND #$7F     ; 2     C864: STA $2000 ; 4
C867: STA $10      ; 3     C869: LDA #$00  ; 2
C86B: STA $2003    ; 4     C86E: LDA #$02  ; 2
C870: STA $4014    ; 4  <-- OAM DMA de 256 bytes
C873: LDA #$31     ; 2     C875: STA $00   ; 3
C877: LDA #$03     ; 2     C879: STA $01   ; 3
C87B: JSR $F228    ; 6
```
6502 ≈ **43 ciclos** → presupuesto `≈ 170 clocks`.

C++ generado: `PHA` (push a la pila emulada: 1 store a `mem->ram[0x100+SP]`), escrituras a PPU/OAM y
`JSR_abs`. **68000 literal:** el `STA $4014` dispara la copia de 256 bytes **byte a byte** en el
handler del runtime (~256 × 8–12 = **2 000–3 000 clocks**), más el resto (~200) más despacho.
**≈ 2 400–3 400 clocks** → **~15–20× por encima**. *(El coste real es el copy, no el despacho.)*

**68000 + HLE:** `$4014` → **una llamada al Blitter** que copia/transforma los 256 bytes de OAM a la
lista de sprites hardware (setup ~110 clocks + `BLTDONE`), o incluso **cero** si los sprites se
reconstruyen de forma perezosa. Y la NMI del Amiga (nivel 3, IRQ de VBlank) **ya existe**; el `PHA` y
los `STA zp` quedan en registro. **≈ 150–300 clocks** contra presupuesto 170 → **al filo**; con el
Blitter es holgado si no se espera `BLTDONE` en el camino crítico.

### Ejemplo E — Espera de VBlank (idioma de raster, real, `bb_C7A8`, `dk_nocyc.cpp:3716`)

```asm
C7A8: LDA $2002    ; 4
C7AB: AND #$80     ; 2
C7AD: BEQ $C7A8    ; 3 (tomada)
```
6502: **9 ciclos/iteración**, y el juego repite hasta el VBlank. Si espera media línea ≈ 113 ciclos
6502 ≈ 500 clocks de presupuesto.

**68000 literal:** cada iteración lee el estado de PPU (`$2002`), `AND`, rama, guarda `PC`, **despacha
(búsqueda binaria ~150)** → **~180–220 clocks por iteración**, y puede iterar decenas de veces →
**miles de clocks** por frame tirados.

**68000 + HLE (`n2a_wait_vblank`)**: el IRQ de VBlank del Amiga pone un flag; la rutina es “dormir
hasta el evento, no sondear”. Coste **~0–20 clocks** (o desaparece: el bucle principal ya sincroniza
con el VBlank). **Ahorro: decenas de miles de clocks/frame** en juegos que esperan VBlank (SMB usa
casi todo el frame en este patrón). El reconocedor ya localiza estos idiomas:
`docs/TIMING_AMIGA.md` §7 (SMB: 2 VBlank, 2 sprite-0, 8 retardos; ~10–20 idiomas por juego).

### Ejemplo F — Bucle de relleno indirecto (real, `bb_C7B9`/`bb_C7BE`)

```asm
C7B9: STA ($00),Y  ; 6
C7BB: DEY          ; 2
C7BC: BNE $C7B9    ; 3
C7BE: DEC $01      ; 5
C7C0: BPL $C7B9    ; 3
```
Este fragmento rellena **0x700 bytes** (7 páginas × 256). Ciclos 6502 ≈ `7 × [(6+2+3)×256 + 5+3]`
≈ **19 700 ciclos** (¡dos tercios de un frame!) — coste de arranque, pero ilustrativo. **68000
literal:** ~25–35 clocks/iteración × 1792 = **~50 000 clocks** + despacho. **HLE:** es un **clear de
memoria** → **Blitter en modo D** (fill) copia 1792 bytes ≈ **~900 clocks de blitter, 0 de CPU**
(paralelo). Elimina ~19 700 ciclos 6502 de golpe.

### Ejemplo G — Donde el 68000 arrasa: aritmética de 16 bits (reescritura algorítmica)

Un contador/posición de 16 bits en 6502:

```asm
CLC             ; 2
LDA lo          ; 3
ADC #$05        ; 2
STA lo          ; 3
LDA hi          ; 3
ADC #$00        ; 2
STA hi          ; 3
```
6502 = **18 ciclos** → presupuesto `≈ 71 clocks`.

**68000 optimizado (un solo valor de 16 bits, idealmente en registro):**
```asm
addq.w  #5,d4        ; 16-bit inc                    4 (registro) / 12 (memoria)
```
**= 4–12 clocks** contra 71 → **6–18× más rápido**. Moraleja: **allí donde el transpilador/analista
reconoce una operación de 16/32 bits y la reescribe, el 68000 gana de forma abrumadora**; eso
compensa los casos donde pierde. Esto es exactamente `OPTIMIZATION.md` §4 (recuperar el algoritmo) y
el paper de `IPA-CP`.

### Tabla resumen por clase de instrucción

| Clase 6502 | Ejemplos | Ciclos NES | C++ (método) | 68000 literal (clocks) | 68000 optimizado/pinned (clocks) | ¿1:1? |
|---|---|---:|---|---:|---:|---|
| Inmediato a registro | `LDA/LDX/LDY #n` | 2 | `LDA_imm` | 16–28 | 4–8 (`moveq`) | Sí |
| Carga zp | `LDA $nn` | 3 | `LDA_zp` | 24–36 | 12 (`move.b d16(An)`) | Sí (justo) |
| Carga absoluta | `LDA $nnnn` | 4 | `LDA_abs` | 28–44 | 12–16 | Sí |
| Carga indexada | `LDA $nnnn,X` | 4–5 | `LDA_absx` | 32–48 | 14 (`(d8,An,Xn)`) | Sí |
| Store zp | `STA $nn` | 3 | `STA_zp` | 24–36 | 12 | Sí (justo) |
| Store absoluto | `STA $nnnn` | 4 | `STA_abs` | 28–44 | 12–16 | Sí |
| ALU inm/zp | `ADC/EOR/AND` | 2–3 | `ADC_imm…` | 24–40 | 8–12 | Sí |
| RMW | `INC/DEC/ASL` zp | 5 | `INC_zp…` | 36–56 | 12–16 | Apretado |
| Comparación+rama | `CMP #; BNE` | 5 | `CMP_imm; if` | 24–40 | 8–10 | Sí |
| Salto/llamada | `JMP/JSR/RTS` | 3–6 | `PC=`/`JSR_abs` | 60–260 | 10–30 encadenado / 40 JSR | Depende |
| Espera raster | `LDA $2002;…` | 9/bucle | — | 180–220/bucle | **0 (HLE)** | Sí |
| Relleno/copia | bucle `(zp),Y` | miles | — | ~25–35/byte | **0 CPU (Blitter)** | Sí |

**Lectura:** con estado *pinned* y encadenado, **casi todas las clases caben**; el problema es el
**despachador** y las **rutinas que deben desaparecer** (esperas, copias). Los dos primeros
escenarios de la tabla §0 lo cuantifican.

---

## 4. El elefante: el despachador de bloques

Medido sobre `dk_nocyc.cpp`:

| Métrica | Valor |
|---|---:|
| Bloques (`bb_*`) definidos | **2 117** |
| Instrucciones `cpu.*` | **4 855** |
| Instrucciones por bloque | **2,29** |
| Salidas con `cpu.PC = …; return;` | 2 282 |

El runtime llama `n2a_fixed_block(cpu.PC)` **en cada bloque**; la búsqueda binaria sobre 2117
entradas son **~12 iteraciones** (≈ 120–180 clocks con `lsl`/`move`/`bcc`/`RTS` de la llamada), más
la llamada indirecta. Con 2,3 instrucciones por bloque:

```
coste de despacho por instrucción ≈ 150 / 2,29 ≈ 65 clocks
```

El presupuesto es **7**. Estamos **~9× por encima solo en despacho**. El host mide el codegen ~13×
más rápido que el intérprete (`FAST_EXECUTOR.md`), pero eso es **x86 con caché y predictor**, con una
ROM de cálculo de **bloques grandes** (294 657 instrucciones); **no es transferible** al 68000 con
código de juego *branch-dense*.

**Requisitos para el backend Amiga:**

1. **Encadenar bloques** con destino estático (llamada directa / salto directo) y **no** devolver al
   despachador por cada rama. En host se devolvía para validar el yield de PPU; en Amiga **no hace
   falta** (el timing lo da el hardware). Reservar el despacho para **saltos indirectos** (raros) y
   el **retorno de JSR/RTS** (o usar `jsr/`rts` nativos del 68000).
2. **Estado 6502 en registros fijos** (`A/X/Y/SP/PC/flags` en `D0..` / `A0..`), `RAM` en `A6`,
   `PRG` en `A3`. Así `LDA zp` es **una** instrucción, no cinco.
3. **N/Z en el CCR**; `C/V/D/I` en un registro/byte solo cuando haga falta.
4. **Superbloques / región caliente**: agrupar el cuerpo de bucles en una función con `goto` interno
   (los idiomas de raster se marcan como puntos de cesión, no como bucles que devuelven).
5. **HLE de rutina**, no de escritura: reconocer bucles de copia/relleno/espera y sustituirlos.

Con (1–5) el coste por instrucción cae a **10–20 clocks**; sigue por encima de 7, de ahí que el HLE
tenga que **borrar** instrucciones (escenario C).

---

## 5. Coste de programar los chips

Aquí está la ventaja real del Amiga. Presupuesto de CPU **solo para la lógica**; todo lo demás en
coprocesadores.

### 5.1 Tiles + scroll (Blitter + Copper + Dual Playfield)

Plan de `PPU_AMIGA.md` adaptado de **XYUnlimited**: buffer 272×256, solo se *blittean* las
columnas/filas que entran (dirty strips).

| Trabajo | Coste |
|---|---|
| Scroll fino | `BPLCON1` + punteros `BPLxPT` → **~2–6 escrituras** de CPU (~30 clocks) |
| Scroll grueso 1 px | marcar 1 columna dirty; **Blitter copia 8×256×N planos** |
| Blit de 1 columna (6 planos) | 1536 B = 768 palabras ≈ **~0,2–0,4 ms** de Blitter (paralelo) |
| Setup de un blit | ~9 registros `BLTCON/PT/MOD/SIZE` ≈ **~110 clocks CPU** + `BLTDONE` opcional |
| Redibujo total 272×256×6 | ~417 KB ≈ **8–12 ms** de Blitter → **prohibido**; por eso dirty strips |
| Recorrer 34 columnas dirty | ~34 × 110 ≈ **3 700 clocks CPU** (peor caso de un frame de scroll rápido) |

**Optimización de ancho de banda:** usar **DPF 2+2 (4 planos)** o **5 planos** en vez de 6 reduce el
DMA de bitplanes ~33 %, lo que **sube el presupuesto de CPU** (§2.2) de forma directa. El attribute
vertical se resuelve con Copper (`WAIT`+`COLORxx`) y el horizontal **pre-aplicado en el patrón**.

**Veredicto (confianza alta).** El fondo es **asequible a 50/60 Hz** con dirty strips. Es el
subsistema mejor resuelto.

### 5.2 Sprites (8 HW + multiplex + bobs)

Plan de `SPRITES_AMIGA.md`: los sprites NES pasan a 8 canales HW (2 planos, 16 px) + multiplexado por
Copper; desborde → bobs con Blitter.

| Trabajo | Coste |
|---|---|
| Conversión CHR→sprite Amiga (2 planos, flips) | **cacheada por `(tile,attr,8x16)`**; 0 por frame si no cambia |
| `$4014` OAM DMA (256 B) | copia/transformación **Blitter** (~110 clocks setup) o **0** perezoso |
| Asignación HW/bob (≤64 sprites, límite 8/línea NES) | bucle ~64 iteraciones ≈ **~1 500–2 500 clocks CPU** |
| Multiplexado | ~4–6 palabras de Copper por sprite reutilizado → casi gratis |
| Bob (sprite sin canal HW) | Blitter *cookie-cut* 8×8×N planos ≈ **~0,05 ms** cada uno; limitar MAX_BOBS |

**Puntos delicados:** (a) el límite NES de **8 por línea** hay que reproducirlo (no “arreglarlo”);
(b) prioridad `behind BG` → `BPLCON2` + orden de dibujo; (c) si hay >8 canales simultáneos, el
multiplex pide el Copper a una precisión de línea que **el oráculo debe respetar**.

**Veredicto (confianza alta para ≤8/línea; media para escenas densas).** Encaja porque la NES ya
limita a 8/línea.

### 5.3 Copper list

Coste **de CPU** = construir la lista en chip RAM (2 escrituras de 16 bits por instrucción de Copper).

| Lista típica | Instrucciones Copper | Coste CPU (≈8 clocks/word) |
|---|---:|---:|
| Fondo (mods, planos, `BPLCON1`) + bands de atributo | 20–120 | 320–1 920 |
| Splits (status bar, sprite-0) | 4–20 | 64–320 |
| Multiplex de sprites (por reutilización) | 6 × nº reutilizados | ~50/reutilizado |
| **Total juego ligero** | **~50–200** | **~800–3 200 clocks** |

El Copper **corre en paralelo** (3 color clocks/instrucción = 1,5 clocks de CPU). Un list de 200
instrucciones consume 600 clocks de bus, irrelevante. **El coste real es escribirlo**, no ejecutarlo.

### 5.4 Audio (Paula)

El plan de `AUDIO_AMIGA.md` (1 canal + mezcla software a 22 kHz) cuesta **~15–40 k clocks/frame**
(367 samples × 40–100) — **hasta la mitad del presupuesto**. Mejor enfoque (estilo **MOD**):

- **Waveforms precomputadas** (ciclo de una onda) en chip RAM: duty 12,5/25/50/75 % (32 pasos),
  triángulo (32), ruido (buffer LFSR largo). Paula las **reproduce en bucle** con `AUDxPER`.
- **Pulse 1 / Pulse 2 / Triangle / Noise → 4 canales Paula independientes** (la NES usa 5; el DMC se
  pospone o comparte). Cada escritura del juego a `$4002/$4003` (frecuencia) → recalcular
  `AUDxPER = 3 546 895 / f`; a `$4000/$4001` (volumen/duty) → `AUDxVOL` / cambiar puntero de waveform.
- **Mezcla en hardware** (Paula suma 4 canales): **0 coste de CPU** por muestra.

| Trabajo | Coste CPU/frame |
|---|---:|
| Actualizar período/volumen de ≤4 canales | **~100–400 clocks** |
| Frame counter de la NES (envolventes/length/sweep) | **~500–2 000 clocks** |
| DMC (si se activa) | stream a Paula; period variable por bloque |

**Veredicto (confianza media-alta).** Con el enfoque MOD, el audio baja de ~30 k a **~1–2 k
clocks/frame**. Es un cambio de estrategia importante respecto a `AUDIO_AMIGA.md`. Calidad: muy buena
en cuadrada/ruido; aceptable en triángulo; el DMC exige cuidado.

### 5.5 Entrada / E-S

`$4016/$4017` serie por *strobe*: leer el joystick vía CIA una vez por frame y volcar el *shift
register*. **< 100 clocks/frame.** Sin riesgo.

---

## 6. Modelo de coste por frame y veredicto por tipo de juego

Hipótesis: 10 841 instrucciones/frame; mix DK; coste/instr según escenario; + subsistemas de vídeo/
audio/IO. Presupuesto real-time ≈ **77–92 k clocks** (NTSC/PAL con DMA).

| Subsistema | (A) Literal | (B) Optimizado | (C) HLE + (B) |
|---|---:|---:|---:|
| Lógica CPU (10 841 instr) | 650–1 250 k | 170–280 k | 50–90 k |
| Tiles/scroll (CPU de setup) | 2–4 k | 2–4 k | 1–4 k |
| Sprites (asignación + OAM) | 3–5 k | 2–4 k | 0,3–2,5 k |
| Copper list (construir) | 1–3 k | 1–3 k | 0,8–3 k |
| Audio | 15–40 k | 15–40 k | 1–2 k |
| IRQ/overhead/input | 2–5 k | 2–5 k | 2–5 k |
| **Total** | **~670 k–1,3 M** | **~192 k–338 k** | **~55 k–107 k** |
| **vs presupuesto ~80 k** | 8–16× | 2,4–4,2× | 0,7–1,3× |

**Veredicto por tipo de juego (confianza media):**

| Tipo | Mapper | Escenario realista |
|---|---|---|
| Puzle/plataformas tempranos, poco scroll, lógica simple (DK, Popeye, Balloon Fight, Excitebike) | NROM/CNROM | **1:1 con (C)**, margen 20–40 % |
| Scroll/acción ligero (SMB, Ice Climber, Kung-Fu) | NROM/UxROM | **1:1 con (C) ajustado**; posible frameskip ocasional |
| Acción densa (Contra, Castlevania) | UxROM | **~40–50 fps** con frameskip 2; 1:1 difícil |
| Lógica + sprites pesados + IRQ (Metroid, Mega Man 2/3, SMB3) | MMC1/MMC3 | **~30–40 fps**; 1:1 solo con HLE de rutina muy agresivo |
| Casos con timing fino (sprite-0 splits, mid-frame) | varios | jugable, **fidelidad de splits** limitada por Copper |

---

## 7. La restricción que nadie evade: 50 Hz (PAL) vs 60 Hz (NTSC)

Un A500 PAL **corre a 50 Hz** (Agnus PAL, 312 líneas). Una ROM NES NTSC corre a **60,0988 Hz**.
Consecuencias:

- Si se sincroniza al VBlank PAL, **la lógica avanza a 50 fps** → el juego va **~17 % lento** y la
  música baja de tono (el clásico “PAL conversion”). El presupuesto por frame sube a 141 k clocks
  **pero el tiempo real no coincide** con el original.
- Para **velocidad 1:1** hay que producir **1,202 frames NES por frame PAL**, lo que devuelve el
  presupuesto efectivo a **~7 clocks/instrucción** (§2.3). Es decir, **la ventaja de “más clocks en
  PAL” se cancela exactamente** con el factor 60/50.
- En **A500 NTSC** (o ECS/AGA con Agnus NTSC) hay 60 Hz reales: presupuesto 119 k brutos → ~77 k
  usables. Mismo orden.
- Trucos habituales: **doble buffer de lógica** (ejecutar 1 o 2 frames NES según margen),
  *frameskip adaptativo*, o **reducir la lógica del juego** (HLE). No hay magia: la física del
  tiempo manda.

> **Recomendación:** fijar el objetivo en **NTSC 60 Hz** para la paridad de juego, y ofrecer un modo
> PAL 50 Hz estable a cambio de ~17 % de ralentización (aceptable y “de época”). Documentar ambos y
> medir.

---

## 8. Qué habría que cambiar en el codegen para la versión Amiga

Priorizado por impacto/coste:

1. **Backend Amiga con estado *pinned*.** Emitir C++ que declare los registros 6502 como variables
   globales *fijadas* a registros (`-ffixed-d0`), o (más robusto) escribir el backend en **68k
   directo** para las rutinas calientes, dejando el C++ para el resto. **El mayor trozo del pastel.**
2. **Encadenar bloques.** No devolver al despachador por rama; destino estático → salto/llamada
   directa. El yield solo en eventos VBlank/IRQ y saltos indirectos. **Elimina el 9× de despacho.**
3. **`--no-cycles` (ya existe)** y **N/Z en CCR** en el runtime Amiga.
4. **HLE de rutina completa** (no de escritura): reconocer esperas de VBlank/retardos, bucles de
   copia/relleno (→ Blitter) y rutinas de render (→ Copper/Blitter). El reconocedor de
   `raster_idioms.cpp` es la base; hay que **extenderlo a copias/rellenos**.
5. **VSA/`IPA-CP`** para plegar zero-page a registros y fusionar operaciones de 16 bits
   (`OPTIMIZATION.md`), incluyendo **eliminar el `--flat` como vía** y centrarse en superbloques.
6. **Audio MOD/Paula** (4 canales HW) en lugar de mezcla software de 1 canal.
7. **DPF 2+2 o 5 planos** según necesidad de color, para reducir DMA y **subir el presupuesto de CPU**.
8. **Presupuesto de RAM**: el código emitido de DK `--no-cycles` es **182 KB de `.text`**
   (`OPTIMIZATION.md`); con estado *pinned* y sin despachador será menor, pero sigue siendo grande
   para 512 KB de chip RAM → comprimir (ZX0, ya previsto) y/o cargar por bancos.

---

## 9. Cómo validar esto (y no quedarse en el modelo)

1. Instalar/validar `m68k-amiga-elf-g++` (bundle `vscode-amiga-debug`), hoy **ausente** en el entorno.
2. Compilar un **vertical slice** (p. ej. DK o la ROM sintética) con los flags de `OPTIMIZATION.md`
   (`-O2 -m68000 -mshort -fomit-frame-pointer -fno-… -flto`) y **contar ciclos** del bucle caliente
   con `objdump -d` (ya previsto en `tools/m68k/README.md`).
3. Enlazar un arranque AmigaDOS y **medir en WinUAE(-DBG)** con `VPOSR`/timers CIA:
   - ciclos por frame por subsistema (lógica, tiles, sprites, audio, copper);
   - comparar con 119 116 (NTSC) / 141 876 (PAL).
4. Comparar el **estado final** con el oráculo (equivalencia, ya en marcha) para no cambiar
   jugabilidad al optimizar.
5. Añadir al orquestador una **tabla de rendimiento por juego** (como `COMPATIBILITY.md`) con
   `fps` y `frameskip` medios.

---

## Anexo A — Tiempos MC68000 usados (byte/word, clocks)

Fuente: *MC68000 User's Manual*, apéndice de tiempos de ejecución (valores ±~10 %).

| Operación | EA | Clocks |
|---|---|---:|
| `MOVE <ea>,Dn` | `(An)` / `(An)+` | 8 |
| `MOVE <ea>,Dn` | `(d16,An)` | 12 |
| `MOVE <ea>,Dn` | `(d8,An,Xn)` | 14 |
| `MOVE <ea>,Dn` | `(xxx).L` | 16 |
| `MOVE Dn,<ea>` | `(An)` | 8 |
| `MOVE Dn,<ea>` | `(d16,An)` | 12 |
| `MOVE Dn,<ea>` | `(xxx).L` | 16 |
| `MOVEQ #imm,Dn` | — | 4 |
| `ADD/SUB/AND/OR/EOR <ea>,Dn` | `(An)` | 8 |
| idem | `(d16,An)` | 12 |
| idem | `(d8,An,Xn)` | 14 |
| idem | `#imm` | 8 |
| `TST <ea>` | `Dn` / `(An)` | 4 |
| `CLR <ea>` | `(An)` | 8 |
| `ADDQ/SUBQ #n,Dn` | — | 4 |
| `ASL/LSR/ROL/ROR Dn #1` | — | 6 |
| `LEA (d16,An),An` | — | 8 |
| `LEA (d8,An,Xn),An` | — | 12 |
| `LEA (xxx).L,An` | — | 12 |
| `Scc Dn` | — | 4 |
| `Bcc` tomada / no tomada | — | 10 / 8 |
| `JSR (An)` | — | 16 |
| `JSR (xxx).L` | — | 20 |
| `RTS` | — | 16 |
| `MULU/MULS` | — | 38–70 |
| `DIVU/DIVS` | — | ~140 |

**Blitter (A500):** ~1 palabra DMA por *slot*; ~3,5 M palabras/s en el mejor caso con DMA de vídeo
activo. Un blit de columna de tile (768 palabras) ≈ 0,2–0,4 ms.

## Anexo B — Artefactos del repo usados

| Artefacto | Uso en este doc |
|---|---|
| `tools/transpiler/generated/dk_nocyc.cpp` | Código C++ real citado (bloques `bb_C7A8`, `bb_C7B9`, `bb_C807`, `bb_C7C5`, `bb_C7E7`, `bb_C85F`); conteo de bloques/instrucciones/mix |
| `tools/transpiler/generated/mini.cpp` | Ejemplo mínimo con `ticks` y `deadline` (`bb_8000`) |
| `runtime/include/nes_runtime.hpp` | Semántica exacta de `CPU`/`NESMemory` (lo que debe costar cada método) |
| `docs/TIMING_AMIGA.md` §7–8 | Idiomas de raster y ciclos 6502/frame medidos (SMB 29 668) |
| `docs/TIMING_CODEGEN.md` | Traza Metroid 650 489 instr/60 frames; ticks; tamaño `.text` |
| `docs/FAST_EXECUTOR.md` | Cobertura, techo del dispatcher, intentos fallidos (cesión, `goto`) |
| `docs/OPTIMIZATION.md` | Flags m68k, `--no-cycles`, VSA, `IPA-CP`, tamaños medidos |
| `docs/PPU_AMIGA.md`, `COPPER.md`, `SPRITES_AMIGA.md`, `AUDIO_AMIGA.md`, `RUNTIME_AMIGA.md` | Plan de coprocesadores y presupuesto de RAM |
| `docs/RISKS.md`, `ROADMAP.md` | Límites conocidos y criterios de cierre |
| `platforms/computers/amiga500/hardware_spec/README.md` | Relojes, chips, registros |

*Documento WIP: las cifras de 68000 son un modelo; sustituir por medidas WinUAE cuando el toolchain
`m68k-amiga-elf-g++` esté disponible.*
