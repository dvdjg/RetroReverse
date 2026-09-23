# tools — comandos del expediente Sanity-Arte

Este expediente **no tiene scripts propios**: usa el toolkit compartido
[`../../toolkit/`](../../toolkit/README.md). Aquí quedan documentados los comandos exactos
usados para este título, para reproducirlo.

## 0. DMS -> ADF (verificado)

```powershell
python ..\..\toolkit\python\dms_unpack.py C:\Users\dvdjg\Downloads\Sanity-Arte.dms out\disk\sanity-arte.adf --verbose
```

Esperado: `80 pistas decodificadas`, ADF de 901120 bytes.

## 1. Volcado de RAM (Chip 512K + Slow 512K) + captura

```powershell
node ..\..\toolkit\node\dump-ram.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf `
  --boot 20 --regions 0x0:0x80000,0xc00000:0x80000 --out out --prefix sanity --screenshot
```

Salida: `out/ram/sanity_000000.bin`, `out/ram/sanity_c00000.bin`, `out/screens/sanity-boot.png`.

> Nota: los volcados iniciales se hicieron antes de unificar el toolkit y están en
> `out/ram/chip000000.bin`, `out/ram/slowc00000.bin` (mismos rangos).

## 2. Diagnóstico de breakpoints

```powershell
node ..\..\toolkit\node\probe-breakpoints.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf --boot 15
```

## 3. Volcado de módulos descomprimidos (de-cruncher SOS `CrM!`/`CrM2`)

```powershell
node ..\..\toolkit\node\hook-trampoline.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf `
  --spec specs\imp-dump.json --out out --boot 5
```

- `specs/sanity-arte.json` describe el trampoline `CrM!` (no era el usado).
- `specs/imp-routine.json` (sondeo del contrato de `IMP!`, con `probe-layout.mjs`).
- `specs/imp-dump.json` (hook del `IMP!` en modo routine): volcó 12 bloques a `out/modules/`.

## 4. Extracción de display (Copperlist + assets)

```powershell
node ..\..\toolkit\node\dump-display.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf `
  --boot 21 --out out --prefix arte-title
```

Salida en `out/display/` (`-custom.json`, `-copper.txt`, `-copper.bin`, `-palette.json`, `-bitplanes.bin`, `-png`).

## Análisis de volcados/ADF

```powershell
python ..\..\toolkit\python\bin_scan.py out\ram\slowc00000.bin --base 0xc00000
python ..\..\toolkit\python\bin_scan.py out\modules\mod_000_c5cbb2_114408.bin
```

## 5. Análisis con Ghidra (CFG/xrefs + decompilador)

Toolkit: `..\..\toolkit\ghidra\` (ver su README). Proyecto Ghidra en `out/ghidra/` (regenerable).
La extensión `ghidra-amiga` resuelve los Hunks y los `.uss` y nombra las llamadas NDK.

```powershell
$g  = "C:\Users\dvdjg\Documents\programa\AI\Amiga\ghidra_12.0.1_PUBLIC"
$sd = "..\..\toolkit\ghidra"; $out = "out\ghidra"; $env:JAVA_HOME = "C:\Program Files\Java\jdk-21"

# (a) Hunk real (p. ej. el runtime SOS del propio demo)
& "$g\support\analyzeHeadless.bat" $out sanity -import "recovered\reference\sanity-os-v26\SOS_RUN" `
  -overwrite -scriptPath $sd -postScript InfoDump.java "$out\SOS_RUN.info.txt"

# (b) .uss con el efecto cargado -> verificar base de mod_2 (0xC05EF2) contra el .asm
& "$g\support\analyzeHeadless.bat" $out sanity `
  -import "..\..\..\vscode-amiga-debug\src\test\suite\data\uss\arte tunnel stars.uss" `
  -overwrite -scriptPath $sd -postScript FindSig.java "$out\ats.sos.txt" "736F7300" `
  -postScript DumpRange.java "$out\ats.bogo.bin" "c00000" "80000"

# (c) Módulo crudo (base 0 = offsets del .asm) -> decompilar la rutina Q15 en 0x0CBA
& "$g\support\analyzeHeadless.bat" $out sanity `
  -import "out\modules_all\blk_0B0C2C_l1_63064.bin" -overwrite `
  -processor "68000:BE:32:default" -loader BinaryLoader -loader-baseAddr 0x0 `
  -scriptPath $sd -postScript DumpDecomp.java "$out\b0c2c.decomp.c" 0xCBA
```

Resultados en `out/ghidra/` (`.info.txt`, `.decomp.c`, `.bogo.bin`, …). Evaluación completa:
[`../docs/GHIDRA_AMIGA_EVAL.md`](../docs/GHIDRA_AMIGA_EVAL.md).

Rizin (triaje rápido de xrefs/CFG, sin decompilador):

```powershell
$rz = "C:\Users\dvdjg\Documents\programa\AI\Amiga\rizin-win-installer-vs2019_static-64\bin\rizin.exe"
& $rz -a m68k -b 32 -E big -m 0x0 -q -e scr.color=0 -c "aaa" -c "pdf @ 0xcba" out\modules_all\blk_0B0C2C_l1_63064.bin
```

### 5bis. Pipeline en lote (todos los módulos)

```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
& ..\..\toolkit\ghidra\decompile-modules.ps1 -ModulesJson out\modules\modules.json -OutDir out\ghidra
& ..\..\toolkit\ghidra\decompile-modules.ps1 -ModulesJson out\modules_all\index.json -OutDir out\ghidra
```

Genera `out/ghidra/<mod>.decomp.c` + `<mod>.info.txt` por módulo (53 en total).

### 5ter. Datos por xref (para los decoders)

```powershell
& "$g\support\analyzeHeadless.bat" out\ghidra sanity -process "blk_0B0C2C_l1_63064.bin" -noanalysis `
  -scriptPath ..\..\toolkit\ghidra -postScript XrefsTo.java "out\ghidra\b0c2c.sinetable.refs.txt" "0x1056" "0x200"
```

### 5quater. Segundo decompilador (rz-ghidra en WSL)

```bash
# una vez: bash toolkit/ghidra/wsl/build-rzghidra.sh
bash /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/Amiga-Reverse/toolkit/ghidra/wsl/pdg-dump.sh \
  /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/Amiga-Reverse/sanity-arte/out/modules_all/blk_0B0C2C_l1_63064.bin \
  /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/Amiga-Reverse/sanity-arte/out/ghidra/blk_0B0C2C.rzghidra.pdg.c \
  0xc16 0xcba 0xe1e
```

Comparación decompilado vs reimpl y cross-check: [`../docs/GHIDRA_DECOMP_VS_REIMPL.md`](../docs/GHIDRA_DECOMP_VS_REIMPL.md).
