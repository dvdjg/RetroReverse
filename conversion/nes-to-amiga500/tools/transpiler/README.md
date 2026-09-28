# tools/transpiler — ROM NES → C++23 (fase 1)

Programa de **host** (C++23) que implementa la **fase 1** del nodo: parseo iNES, desensamblado
recursivo, *basic blocks* y generación de C++23 sobre `eng/core` (**sin STL**). El `.cpp` emitido
incluye el runtime del nodo ([`../../runtime/include/nes_runtime.hpp`](../../runtime/include/)).

Diseño en [`../../docs/TRANSPILER.md`](../../docs/TRANSPILER.md); reconocimiento de intenciones
(fase 2) en [`../../docs/HLE.md`](../../docs/HLE.md).

> Estado: **prototipo funcional NROM**. Cubre opcodes oficiales + ilegales frecuentes, ramas,
> `JMP`/`JSR`/`RTS` y despacho por dirección. Mappers distintos de NROM quedan para F9.

## Dependencia de `eng/core` (repo Amiga-Cpp)

No usa la librería estándar de C++: se apoya en `eng/core` del repo hermano **Amiga-Cpp** vía `-I`.
Ruta por defecto relativa (se puede sobrescribir con `make AMIGA_CPP=…`):

```
AMIGA_CPP ?= ../../../../../../Amiga-Cpp
```

Para poder usarla en host se añadieron a `eng/core` (commits del usuario en Amiga-Cpp):

- `eng/core/util/heap_alloc.hpp` — `HeapAlloc` (heap del anfitrión, solo host).
- `eng/core/util/dynamic_string.hpp` — `DynamicString<A>` (cadena que crece + formateo hex/dec).

Y se hizo `eng/core` portable en host LP64 (Linux/WSL) además de m68k: `eng::u8..u64` usan los
builtins `__UINT*_TYPE__`/`__INT*_TYPE__` (ancho exacto), y `type_traits` gana `uint_of<8>` y
`is_pointer`/`is_function` sin depender de builtins ausentes en GCC < 16.

## Layout

```
transpiler/
  src/
    opcodes.hpp     tabla de opcodes (constexpr, 256 ranuras)
    host_io.hpp     E/S de fichero/consola del host (<cstdio>, sin STL)
    transpiler.hpp  núcleo: iNES + desasm + CFG/basic blocks + codegen
    main.cpp        CLI
  tests/run.sh      smoke test (WSL/Linux o MinGW g++)
  Makefile
```

El runtime **no** vive aquí: lo emite el transpilador como `#include "nes_runtime.hpp"` y reside en
[`../../runtime/include/`](../../runtime/include/).

## Build

```bash
make CXX=g++                              # WSL / Linux (g++ 13+; probado con 15)
make CXX=/ruta/mingw64/bin/g++            # MinGW
```

Sin `make`:

```bash
g++ -std=gnu++23 -O2 -Wall -Wextra -Werror=narrowing \
    -I<Amiga-Cpp>/engine/include -Isrc src/main.cpp -o build/nes_transpiler
```

## Uso

```bash
nes_transpiler juego.nes -o ../../generated/game.cpp
nes_transpiler juego.nes --facts hechos.txt -o ../../generated/game.cpp
nes_transpiler --emit-mini-rom   ../../generated/mini.nes
nes_transpiler --emit-branch-rom ../../generated/branch.nes
nes_transpiler --emit-misc-rom   ../../generated/misc.nes
nes_transpiler --emit-vsa-rom    ../../generated/vsa.nes
nes_transpiler --emit-bench-rom  ../../generated/bench.nes
nes_transpiler --emit-cnrom-rom  ../../generated/cnrom.nes
```

Acepta **NROM (0)**, **CNROM (3)**, **UxROM (2)**, **MMC1 (1, modo 16K)**, **MMC3 (4)**, **FME-7 (69)**,
**VRC6 (24/26)** y **MMC5 (5, modo 3)**. Se transpila **por banco** (bloques `bbB<b>_<addr>` con
despacho por banco `prg_bank`..`prg_bank4`) y se cae al **intérprete** si una dirección no tiene
bloque; si el juego cambia a un modo no soportado (MMC1/MMC3/MMC5), el runtime lo invalida
(sentinel). **Verificado byte-exact** (`banks_test.sh`, 14 ROMs: UxROM, MMC1, MMC3, FME-7, VRC6 y
MMC5). Plan/detalle en [`../../docs/TRANSPILER_BANKING.md`](../../docs/TRANSPILER_BANKING.md).

### 7z (entrada y salida)

- **Salida**: por defecto cada plugin se empaqueta en `<rom>.<plataforma>.7z` (con el `.n2x` y su
  sidecar). `--no-7z` lo desactiva; `--bundle <nombre>` agrupa **varias ROMs en un solo**
  `<nombre>.<plataforma>.7z`; `--7z <7zr.exe>` fija la herramienta (o `N2A_7Z`).
- **Entrada**: se admiten `.7z` que contengan `.nes` (se extraen y se transpilan cada una).

### Bibliotecas `.n2x` (`--emit-lib`, una o varias ROMs)

Genera, por ROM, el `.cpp` **y** (si encuentra compilador) la biblioteca cargable `.n2x`:

```bash
nes_transpiler rom1.nes rom2.nes --emit-lib --outdir generated \
  --entry ../../runtime/plugin/plugin_entry.cpp \
  --inc <Amiga-Cpp/engine/include> --inc ../../runtime/include --inc ../../runtime/plugin \
  --cxx g++
```

El `.n2x` es un **cartucho autocontenido** (código + PRG + CHR + mapper) con ABI C versionada
([`../../runtime/plugin/README.md`](../../runtime/plugin/README.md)); el gestor lo carga en runtime y
aporta el intérprete/PPU/APU.

`--emit-*-rom` generan ROMs iNES **propias** (homebrew mínimo) para probar el pipeline sin ROMs de
terceros.

### Hechos de valores (`--facts`)

El transpilador puede leer un fichero de **hechos** sobre el valor de direcciones de memoria y
emitirlos como `N2A_ASSUME(...)` al principio de los bloques que lean esas direcciones, para que g++
optimice con esa información (ver [`../../docs/OPTIMIZATION.md`](../../docs/OPTIMIZATION.md)):

```
eq     <addr> <valor>
range  <addr> <min> <max>
set    <addr> <v1> [v2] [v3] [v4]
power2 <addr>
hot    <addr> <ejecuciones>   # calor de bloque: >=1 hot, 0 cold
```

Los hechos deben venir **validados** por análisis o telemetría: si no se cumplen en ejecución, el
comportamiento es indefinido (como `[[assume]]`).

El hecho **`hot`** no es una suposición de valor: marca el bloque que empieza en `<addr>` como
`__attribute__((hot))` (ejecutado) o `((cold))` (nunca), para que el compilador reordene y ajuste el
código. Se genera con la telemetría del runtime
([`../../runtime/tools/opcode_hist.cpp`](../../runtime/tools/opcode_hist.cpp), 4.º argumento = fichero).

## Forma del código generado

- Cabecera documentada + `#include <eng/core/types/types.hpp>`.
- `kPrgSize` y `PRG_ROM` (`constexpr`), necesarios por el runtime.
- `#include "nes_runtime.hpp"` y `using n2a::CPU; using n2a::NESMemory;`.
- Un **basic block por función** (`bb_XXXX`), con `goto` a etiquetas **solo dentro del bloque**
  (auto-bucles). Los saltos entre bloques hacen `cpu.PC = destino; return;` (vuelven al despacho),
  porque una etiqueta C++ no es visible desde otra función.
- Ramas y `JMP` absoluto → `cpu.PC = destino; return;` (vuelven al despacho, para que el runtime
  pueda avanzar la PPU entre bloques); `JMP (ind)` → `cpu.JMP_ind`.
- `JSR` → `cpu.JSR_abs(destino, retorno); return;`; `RTS`/`RTI` recuperan de la pila.
- Despacho **disperso** (tablas `{addr, ciclos, fn}` ordenadas + búsqueda binaria; `.bss = 0`),
  `g_state`, `game_main()` y `main()` de host tras
  `#if !defined(__m68k__) && !defined(N2A_NO_HOST_MAIN)`.
- Cada bloque lleva una **ficha** (rango 6502, qué hace, quién lo llama, recursos), según la regla
  de código autodocumentado de [`../../../../AGENTS.md`](../../../../AGENTS.md).
- `N2A_ASSUME(...)` al inicio del bloque para los hechos leídos (`--facts`).
- `__attribute__((hot))`/`((cold))` en la firma del bloque según el calor (`--facts hot`), con los
  bloques calientes emitidos primero.
- `n2a_block_cycles(pc)`: ciclos base por bloque, para que el runtime avance la PPU al ejecutar
  bloques generados (`tests/gen_frame.sh`).

## Test

```bash
bash tests/run.sh          # o: make test
bash tests/uxrom_test.sh   # UxROM (mapper 2): bloques por banco == intérprete (0.0 % píxeles)
```

`uxrom_test.sh` transpila una ROM UxROM (por defecto `runtime/build/castlevania.nes`; o pásale otra,
p. ej. `contra.nes`) y comprueba que el codegen, dentro de `NesSystem`, da el **mismo framebuffer**
que el intérprete. Sin ROM, se salta (CI sin ROMs).

Compila la herramienta, genera **tres** ROMs propias, las transpila, compila el C++ generado **con el
runtime** (`-I ../../runtime/include`) y comprueba el estado final:

- **mini**: `X=1, A=$23, ram[0]=$23`;
- **branch**: bucle de 5 con `ADC`/`BNE`/`JSR`/`RTS` → `A=X=5, ram[$10]=5`;
- **misc**: pila, desplazamientos (A y memoria), `INC`/`DEC` de memoria y `JMP (ind)`; además
  transpila con `--facts` y comprueba que el generado contiene `N2A_ASSUME` y la marca `hot`.
- **bench** (`[6/6]`, `tests/bench_codegen.sh`): mide el **codegen** frente al intérprete y al
  ejecutor rápido sobre una ROM de cálculo (ver [`../../docs/FAST_EXECUTOR.md`](../../docs/FAST_EXECUTOR.md)).

Fuera del smoke test (tarda más) hay dos comprobaciones sobre ROMs reales/rendimiento:

- `tests/gen_frame.sh`: transpila una ROM NROM real (p. ej. Donkey Kong) y la ejecuta con el **código
  generado dentro del `NesSystem`** (PPU real), comparando con el intérprete (ver
  [`../../docs/FAST_EXECUTOR.md`](../../docs/FAST_EXECUTOR.md)).
- `tests/bench_codegen.sh`: mide el codegen frente al intérprete y al ejecutor rápido.

La CPU del runtime se valida aparte con `nestest` en [`../../runtime/test/run.sh`](../../runtime/test/run.sh).
El motor m68k (sin el engine) se comprueba en [`../m68k/run.ps1`](../m68k/run.ps1).

## Codificación

El repo exige **UTF-8 sin BOM** (incluido el código generado). Se comprueba con
`bash scripts/validate-encoding.sh` (ver [`../../../../tools/check/encoding.mjs`](../../../../tools/check/encoding.mjs)).

## Verificación del lado Amiga-Cpp

Los cambios en `eng/core` se validaron con la suite host de Amiga-Cpp (`tools/run-host-tests.sh`):
todas las categorías pasan. El único ajuste fue `tests/host/core/073_basic_type_traits` (ahora
comprueba `sizeof(u32)==4` en vez de la identidad con `unsigned long`, que ya no se cumple en LP64).
El aviso `header-impl` sobre `eng/ai/planning/goap.hpp` es preexistente y ajeno a estos cambios.

## `--release` (build Amiga)

El codegen emite por defecto **avance de PPU por acceso** (`cpu.mem->tick`) y contabilidad de ciclos,
necesarios para la **validación en host** (codegen == intérprete). En el **Amiga** no se usa (el PPU es
hardware/Copper), y ese código **duplica el `.text`**. Medido en m68k (GCC 15.1, `-O2`):

| ROM | `.text` con ticks | `.text` `--release` | `.bss` |
|---|---:|---:|---:|
| Metroid (MMC1) | 451 KB | **228 KB** | 0 |
| Mega Man 3 (MMC3) | 318 KB | **282 KB** | 0 |

→ El build para A500 debe usar **`--release`** (`--no-cycles`, sin ticks). Ver
[`../../docs/TIMING_CODEGEN.md`](../../docs/TIMING_CODEGEN.md).

## Empaquetado para Amiga (RRPK)

Cuando el destino sea **Amiga 500** y exista el build del plugin en 68000, `--emit-lib` debe
empaquetar los rangos con el **packer** ([`../packer/`](../packer/README.md)) en un contenedor
`RRPK` (todo ZX0; ver [ADR 0006](../../../../docs/adr/0006-compresion-zx0.md)), etiquetando cada
segmento por tipo para que el cargador del Amiga lo descomprima y salte a ejecutarlo:

| rango | tipo | códec |
|---|---|---|
| secciones `.text` | `code` | `zx0` |
| `.rodata`/`.data` | `data` | `zx0` |
| PRG de la ROM | `prg` | `zx0` |
| CHR de la ROM | `chr` | `zx0` |

Punto de entrada: [`../packer/pack_amiga.sh`](../packer/pack_amiga.sh)
`code.bin data.bin juego.nes juego.rrpk` (extrae PRG/CHR del `.nes`, empaqueta y verifica el
round-trip). Hoy el build del plugin en 68000 está pendiente del engine de Amiga; este contrato deja
la llamada definida para cuando exista.
