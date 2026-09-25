# Evaluación de Ghidra + extensión Amiga (ghidra-amiga)

Evaluación práctica de `BartmanAbyss/ghidra-amiga` para la labor de este expediente, ejecutada
completa (pasos 1–4). Herramienta documentada en
[`../../tools/ghidra/README.md`](../../../../../../tools/ghidra/README.md).

**Entorno**: Ghidra 12.0.1, extensión compilada con Gradle 9.2.1, JDK 21.
Todo el material regenerable queda en `out/ghidra/`.

---

## Paso 1 — Compilar/instalar y probar con un Hunk real

**Hallazgo previo (importante)**: `out/disk/` **no contiene ningún Hunk** — el disco de «Arte» es
un *trackloader* (bootblock `DOS\0` + firma `SOS1`, sin filesystem). El `00 00 03 F3` que aparece
en el ADF (offset `0x16A2`) y en `mod_004` (offset `0x221B`) es **coincidencia dentro de código/
datos**, no un `HUNK_HEADER` (los campos siguientes no son una tabla de hunks válida). Confianza
**alta** (verificado parseando la cabecera).

Por tanto se probó con **Hunks reales** del propio expediente y del entorno:

| Fichero | Hunks | Resultado |
|---|---|---|
| `recovered/reference/sanity-os-v26/SOS_RUN` | 1 | carga OK |
| `demoscene-repo/effects/empty/empty.exe` | 3 (code/data/bss) | carga OK |

Evidencia (headless log + `out/ghidra/*.info.txt`):

- Loader autodetectado: **`Amiga Hunk Executable`**; lenguaje `68000:BE:32:default`.
- Bloques: `EXEC`, `CODE_00`, `DATA_01`, `BSS_02` (según hunks), **stubs** `dos_library`/
  `exec_library` (`+0x1000`) y `Custom` (`$DFF000`).
- Analyzer **Amiga Library Calls** resuelve el salto indirecto a la tabla de vectores:
  `dos_library_Open/Close/Read/Write/…` (NDK 3.9). `SOS_RUN`: **332 funciones, 865 símbolos**.
- **Conclusión**: el loader Hunk funciona y aporta justo lo que `objdump --adjust-vma` no da
  (base de segmentos, relocs, stubs de librería y nombres NDK). Confianza **alta**.

---

## Paso 2 — Cargar un `.uss` y verificar direcciones contra el `.asm`

**Carga (WinUAE-DBG)**: `WinUAE-DBG/bin/sanity.uss` → loader **`Amiga WinUAE State File (USS)`**,
`Saved with 'UAE 6.0.0'`, ROM `Kickstart 34.5 @ $FC0000`. Bloques:
`CHIP $0+$80000`, `BOGO $C00000+$80000`, `Custom $DFF000`, `ROM $FC0000` (sin bytes, `init=false`),
`ExceptionVectors` en `$0`. Confianza **alta**.

**Verificación de direcciones**: el `sanity.uss` de WinUAE-DBG se capturó en un estado de
*loader/boot* (PC `$00C01A6C` en Slow RAM) y **no** contiene los módulos del demo. Sí los contiene
`vscode-amiga-debug/src/test/suite/data/uss/arte tunnel stars.uss` (del propio test-suite del
emulador). En él se localizaron las firmas `"sos\0"` de los módulos en Slow RAM:

```
hit 00c03b86  BOGO      -> módulo @ 0xC03B7A
hit 00c05efe  BOGO      -> módulo @ 0xC05EF2   (= mod_002, base documentada)
hit 00c73c1e  BOGO      -> módulo @ 0xC73C12
```

Comparando el bloque del `.uss` en `0xC05EF2` con `out/modules/mod_002_c05ef2_26676.bin` (base
documentada `0xC05EF2`): **8670/26676 B idénticos (32.5 %)** y **todas** las diferencias son
**reubicaciones** de referencias absolutas que el loader parchea en runtime:

```
.uss  @0xC05EF2: 4E F9 00 C0 5F 02   ; jmp $C05F02  (reubicado)
disco @0x000000: 4E F9 00 00 00 10   ; jmp $10
.uss  @0xC05F20: 23 C0 00 C0 5F 6C   ; move.l d0,$C05F6C (reubicado)
disco @0x00002E: 23 C0 00 00 00 7A   ; move.l d0,$7A
```

El `.asm` (`recovered/code/sos_library/mod_2_soslibrary.asm`, base `0xC05EF2`) coincide
instrucción a instrucción con el `.uss` (`movea.l $4.w,a6` @ `0xC05F02`, `jsr -$180(a6)` @
`0xC05F14`, …). **Conclusión**: las direcciones del `.uss` corresponden 1:1 con el `.asm`;
la única diferencia es la reubicación. Confianza **alta**.

**Uso práctico**: para analizar un efecto *en su sitio*, exportar el savestate **mientras el efecto
está cargado**; los `.uss` del test-suite (`arte *.uss`) son válidos para esto, el `sanity.uss` de
`WinUAE-DBG/bin` no (está en boot).

---

## Paso 3 — Evaluar el decompilador sobre la rutina Q15 ya entendida

Módulo `out/modules_all/blk_0B0C2C_l1_63064.bin` importado como **Raw Binary** base `0x0`
(los offsets coinciden con `code_b0c2c.asm`, que también es base 0). Función en `0x0CBA`
(transformación Q15), `out/ghidra/b0c2c.decomp.c`:

```c
*unaff_A2 = (short)((uint)(((int)*in_A1 * (int)sVar1 + (int)in_A1[3] * (int)sVar2 +
                           (int)in_A1[6] * (int)sVar3) * 2) >> 0x10);
```

Coincide **exactamente** con la reimplementación `reimpl/motor_3d/src/transform3d.cpp`:

```cpp
o.x = (i16)(((M.m[0]*x + M.m[3]*y + M.m[6]*z) * 2) >> 16);
```

- El decompilador reconoce `MULS.W`+`ADD.L`+`ADD.L d,d`+`SWAP` como **Q15** `(suma*2)>>16` y
  resuelve el *layout* de la matriz `in_A1[0],[3],[6]…` tal cual `TECNICAS.md`.
- **Matiz**: Ghidra muestra que la rutina procesa **3 puntos por llamada** (`MOVEM.W (A0)+,D0-D2`
  ×3 → 9 salidas), no "1 punto con 3 componentes" como decía `TECNICAS.md` §"Transformación de
  punto". El asm tenía razón; la redacción se puede precisar. Confianza **alta**.
- `InfoDump`: **65 funciones, 91 símbolos** en el módulo.

**Conclusión**: el decompilador produce C **directamente utilizable** para el objetivo #3
(inferir C++). Confianza **alta**.

---

## Paso 4 — Comparación con Rizin/radare2

Rizin 0.9.1 (build estático Windows), mismo `blk_0B0C2C_l1_63064.bin`:

```powershell
rizin -a m68k -b 32 -E big -m 0x0 -q -e scr.color=0 -c "aaa" -c "pdf @ 0xcba" blk_0B0C2C_l1_63064.bin
```

| Aspecto | Ghidra + ghidra-amiga | Rizin 0.9.1 |
|---|---|---|
| Desensamblado m68k | correcto (`movem.w (a0)+,d0-d2`, `muls.w`, `swap`…) | correcto (idéntico) |
| Funciones detectadas (módulo) | 65 | **77** |
| Xrefs / CFG | sí | sí (`axt @ 0xcba` → llamada desde `0x2470`, `0x25d0`, `0x2756`) |
| **Decompilador a C** | **sí** (nativo) | **no** (`pdc`/`pdd` no existen; requiere el plugin `rz-ghidra`) |
| Loaders Amiga (Hunk/USS/ROM) | **sí** | no (raw con `-m`) |
| Símbolos NDK / `Custom` | **sí** | no |
| Coste | pesado (JVM, proyecto, ~500 MB) | ligero (binario único) |

**Conclusión**: son complementarios. **Rizin** para *triaje* rápido (disasm, xrefs, búsquedas,
scripts) sobre volcados crudos; **Ghidra** para lo que no da Rizin: decompilado a C, loaders Amiga
nativos y símbolos NDK. No sustituye a `objdump`/capstone como desensamblado canónico del
expediente (que sigue siendo ligero y reproducible). Confianza **alta**.

---

## Recomendación para el flujo del expediente

1. **Desensamblado canónico**: mantener `m68k-amiga-elf-objdump`/capstone (base del `.asm` curado).
2. **Comprensión y C++ aproximado**: Ghidra — importar el **Hunk** (si lo hay) o el **`.uss` con el
   efecto cargado**, o el **volcado crudo** con `BinaryLoader -loader-baseAddr`; usar el decompilador
   sobre las rutinas de interés y volcar a `out/ghidra/`.
3. **Triaje**: Rizin sobre el mismo volcado para xrefs/CFG y localizar llamantes.
4. **Trazabilidad**: los `.asm` curados van a `recovered/` (con `SOURCE` + sha1); las salidas de
   Ghidra/Rizin a `out/` (regenerables), referenciadas desde `TECNICAS.md`.

## Reproducir

```powershell
$g  = "C:\Users\dvdjg\Documents\programa\AI\Amiga\ghidra_12.0.1_PUBLIC"
$sd = "C:\Users\dvdjg\Documents\programa\AI\Amiga\Amiga-Reverse\tools\ghidra"
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
$out = "platforms\computers\amiga500\demos\arte\out\ghidra"

# Paso 1: Hunk
& "$g\support\analyzeHeadless.bat" $out sanity -import "platforms\computers\amiga500\demos\arte\recovered\reference\sanity-os-v26\SOS_RUN" `
  -overwrite -scriptPath $sd -postScript InfoDump.java "$out\SOS_RUN.info.txt"

# Paso 2: .uss + búsqueda de firmas + volcado
& "$g\support\analyzeHeadless.bat" $out sanity -import "..\vscode-amiga-debug\src\test\suite\data\uss\arte tunnel stars.uss" `
  -overwrite -scriptPath $sd -postScript FindSig.java "$out\ats.sos.txt" "736F7300" `
  -postScript DumpRange.java "$out\ats.bogo.bin" "c00000" "80000"

# Paso 3: decompilador
& "$g\support\analyzeHeadless.bat" $out sanity -import "platforms\computers\amiga500\demos\arte\out\modules_all\blk_0B0C2C_l1_63064.bin" `
  -overwrite -processor "68000:BE:32:default" -loader BinaryLoader -loader-baseAddr 0x0 `
  -scriptPath $sd -postScript DumpDecomp.java "$out\b0c2c.decomp.c" 0xCBA
```

(Rutas relativas desde la raíz `Amiga-Reverse/`; ajustar el `..` de `vscode-amiga-debug`.)
