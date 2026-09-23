# toolkit/ghidra — Ghidra + extensión Amiga (loaders Hunk/USS, símbolos NDK)

Análisis de software Amiga 68k con **Ghidra** y la extensión
[`BartmanAbyss/ghidra-amiga`](https://github.com/BartmanAbyss/ghidra-amiga). Aporta lo que
`objdump`/capstone no dan: **análisis automático (CFG, xrefs, funciones)** y **decompilador a C**,
con loaders nativos de Amiga.

## Qué aporta la extensión

| Capacidad | Detalle | Confianza |
|---|---|---|
| Loader **Amiga Hunk Executable** | parsea HUNK_HEADER/CODE/DATA/BSS + relocs; crea bloques `CODE_nn`/`DATA_nn`/`BSS_nn` y stubs de librería | alta |
| Loader **Amiga WinUAE State File (.uss)** | lee savestates de WinUAE; crea CHIP/BOGO/FRAM/ZRAM/A3K/ROM/Custom en sus direcciones reales, `ExceptionVectors` y PC de entrada | alta |
| Loader **Amiga Kickstart ROM** | carga ROMs de Kickstart | alta |
| Analyzer **Amiga Library Calls** + NDK 3.9 | resuelve `jsr -$xx(a6)` a `dos_library_Open`, `graphics_library_*`, … y nombra `Custom` (`$DFF000`) | alta |
| Estructuras | `CustomChipRegisters`, `M68KVectors`, `CopperInst`, `InitTable` | media |
| **Decompilador** | pseudo-C de Ghidra (no es específico de Amiga) | alta |

Limitaciones: `.uss` no incluye los bytes de ROM (bloque `ROM` queda sin inicializar, `init=false`);
los bloques de librería son stubs (no contienen código real). El fork no tiene *releases*: hay que
compilarlo. `3rdparty/NDK_3.9` tiene copyright (solo para análisis, no redistribuir).

## Instalación (una vez)

Requisitos: **JDK 21**, **Ghidra 12.0.1** (la versión que apunta el fork), **Gradle 9.x**.

```powershell
# 1) Clonar el repo (junto al resto de repos Amiga)
git clone --depth 1 https://github.com/BartmanAbyss/ghidra-amiga.git C:\...\Amiga\ghidra-amiga

# 2) Descargar Ghidra 12.0.1 y Gradle (p.ej. 9.2.1) y extraerlos en C:\...\Amiga\

# 3) Compilar la extensión (el wrapper propio de Ghidra NO sirve para un repo suelto; usar gradle)
$env:JAVA_HOME          = "C:\Program Files\Java\jdk-21"
$env:GHIDRA_INSTALL_DIR = "C:\...\Amiga\ghidra_12.0.1_PUBLIC"
& "C:\...\Amiga\gradle-9.2.1\bin\gradle.bat" buildExtension --no-daemon
# -> dist\ghidra_12.0.1_PUBLIC_<fecha>_ghidra-amiga.zip

# 4) Instalar en Ghidra
tar -xf "ghidra-amiga\dist\ghidra_12.0.1_PUBLIC_<fecha>_ghidra-amiga.zip" -C "$env:GHIDRA_INSTALL_DIR\Ghidra\Extensions"
```

Notas: el repo ya incluye `data/amiga_ndk39.gdt` (archivo de tipos NDK 3.9 precompilado), así que
**no** hay que regenerar el *parse profile*. `gradlew` de Ghidra asume que se ejecuta desde
`<GHIDRA>/support/gradle`; para un repo suelto hay que usar Gradle directamente.

## Scripts de este directorio (headless)

| Script | Uso |
|---|---|
| `InfoDump.java` | imprime bloques de memoria, entry points, nº de funciones/símbolos y símbolos de librería |
| `DumpDecomp.java <out.c> [hexAddr]` | decompila la función en `hexAddr` (o todas) a C |
| `FindSig.java <out.txt> <hexbytes>` | busca una firma de bytes en toda la memoria y lista las direcciones |
| `DumpRange.java <out.bin> <hexStart> <hexLength>` | escribe un rango de memoria a fichero (para comparar) |
| `XrefsTo.java <out.txt> <hexAddr> [hexLen]` | lista referencias a una dirección y (opcional) vuelca los datos → decoders |
| `decompile-modules.ps1` | **pipeline en lote**: decompila todos los módulos de un `modules.json`/`index.json` |

Uso típico (importar + analizar + script):

```powershell
$g  = "C:\...\Amiga\ghidra_12.0.1_PUBLIC"
$sd = "C:\...\Amiga-Reverse\toolkit\ghidra"
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"

# Hunk o .uss: el loader se autodetecta por el magic
& "$g\support\analyzeHeadless.bat" out\ghidra sanity `
  -import <archivo> -overwrite -scriptPath $sd `
  -postScript InfoDump.java out\ghidra\info.txt

# Binario crudo (volcado de módulo sin cabecera Hunk): base y procesador explícitos
& "$g\support\analyzeHeadless.bat" out\ghidra sanity `
  -import mod.bin -overwrite -processor "68000:BE:32:default" `
  -loader BinaryLoader -loader-baseAddr 0x0 `
  -scriptPath $sd -postScript DumpDecomp.java out\ghidra\decomp.c 0xCBA

# Reejecutar scripts sobre un programa ya importado (sin re-analizar)
& "$g\support\analyzeHeadless.bat" out\ghidra sanity -process "mod.bin" -noanalysis `
  -scriptPath $sd -postScript DumpDecomp.java out\ghidra\decomp.c 0xCBA
```

## Pipeline en lote: `decompile-modules.ps1`

Decompila **todos** los módulos de un `modules.json` (o `index.json`) a `out/ghidra/`, importando
cada binario como Raw Binary en su dirección de carga (`dest` del JSON; si falta, base 0).

```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
./decompile-modules.ps1 `
  -ModulesJson ..\..\sanity-arte\out\modules\modules.json `
  -OutDir      ..\..\sanity-arte\out\ghidra `
  [-Only 'mod_00'] [-BaseField dest]
```

Salida por módulo: `<mod>.decomp.c` (pseudo‑C de todas sus funciones) + `<mod>.info.txt`.
`out/modules_all/index.json` usa `offset` (offset en el ADF, **no** dirección de carga) → base 0.
Resultado en `sanity-arte`: 53 módulos (12 de `modules/` + 41 de `modules_all/`).

## Extraer datos por xref (para los decoders)

`XrefsTo.java <out.txt> <hexAddr> [hexLen]`: encuentra quién referencia una tabla/paleta y, si se
indica longitud, vuelca los bytes a `<out.txt>.bin` para `planar_decode`/`copper_decode`/`bin_scan`.

```powershell
& "$g\support\analyzeHeadless.bat" $out sanity -process "blk_0B0C2C_l1_63064.bin" -noanalysis `
  -scriptPath $sd -postScript XrefsTo.java "$out\b0c2c.sinetable.refs.txt" "0x1056" "0x200"
```

## Segundo decompilador: rz-ghidra (WSL/Linux)

`rz-ghidra` es el decompilador de Ghidra empaquetado como plugin de Rizin (`pdg`). Sirve para
**contrastar** el C de Ghidra. En Windows nativo **no es viable**: los releases solo traen código
fuente y el Rizin precompilado no incluye `RizinConfig.cmake`. Se construye desde fuente en
**WSL/Ubuntu** con `wsl/build-rzghidra.sh` (pip para cmake/ninja/meson, Rizin 0.9.0 + rz-ghidra
0.9.0, zlib del sistema). Luego:

```bash
# en WSL:
bash /mnt/c/.../toolkit/ghidra/wsl/pdg-dump.sh \
  /mnt/c/.../sanity-arte/out/modules_all/blk_0B0C2C_l1_63064.bin \
  /mnt/c/.../sanity-arte/out/ghidra/blk_0B0C2C.rzghidra.pdg.c 0xc16 0xcba 0xe1e
```

Su salida coincide con la de Ghidra (misma semántica Q15). Detalle y resultados en
`../../sanity-arte/docs/GHIDRA_DECOMP_VS_REIMPL.md` §5.

## Relación con el resto del toolkit

- `objdump`/capstone (Bartman) siguen siendo el **desensamblado canónico** (rápido, ligero,
  `--adjust-vma`); Ghidra es para **CFG/xrefs/decompilado** y sesiones largas.
- Rizin/radare2 es la alternativa ligera (disasm + xrefs) pero **sin decompilador** en el build
  base (necesita el plugin `rz-ghidra`). Ver `LECCIONES_APRENDIDAS.md` §7bis.

Ver la evaluación completa (pasos 1–4) en `../../sanity-arte/docs/GHIDRA_AMIGA_EVAL.md`.
