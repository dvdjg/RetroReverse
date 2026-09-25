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
nes_transpiler --emit-mini-rom   ../../generated/mini.nes
nes_transpiler --emit-branch-rom ../../generated/branch.nes
```

`--emit-mini-rom` y `--emit-branch-rom` generan ROMs iNES **propias** (homebrew mínimo) para probar
el pipeline sin ROMs de terceros.

## Forma del código generado

- Cabecera documentada + `#include <eng/core/types/types.hpp>`.
- `kPrgSize` y `PRG_ROM` (`constexpr`), necesarios por el runtime.
- `#include "nes_runtime.hpp"` y `using n2a::CPU; using n2a::NESMemory;`.
- Un **basic block por función** (`bb_XXXX`), con `goto` a etiquetas **solo dentro del bloque**
  (auto-bucles). Los saltos entre bloques hacen `cpu.PC = destino; return;` (vuelven al despacho),
  porque una etiqueta C++ no es visible desde otra función.
- `JMP` absoluto estático → `goto` (mismo bloque) o `cpu.PC`/`return`; `JMP (ind)` → `cpu.JMP_ind`.
- `JSR` → `cpu.JSR_abs(destino, retorno); return;`; `RTS`/`RTI` recuperan de la pila.
- Tabla de despacho `dispatch_table[0x10000]`, `g_state`, `game_main()` y `main()` de host tras
  `#if !defined(__m68k__) && !defined(N2A_NO_HOST_MAIN)`.
- Cada bloque lleva una **ficha** (rango 6502, qué hace, quién lo llama, recursos), según la regla
  de código autodocumentado de [`../../../../AGENTS.md`](../../../../AGENTS.md).

## Test

```bash
bash tests/run.sh          # o: make test
```

Compila la herramienta, genera dos ROMs propias, las transpila, compila el C++ generado **con el
runtime** (`-I ../../runtime/include`) y comprueba el estado final (mini: `X=1, A=$23, ram[0]=$23`;
branch: bucle de 5 con `ADC`/`BNE`/`JSR`/`RTS` → `A=X=5, ram[$10]=5`).

## Codificación

El repo exige **UTF-8 sin BOM** (incluido el código generado). Se comprueba con
`bash scripts/validate-encoding.sh` (ver [`../../../../tools/check/encoding.mjs`](../../../../tools/check/encoding.mjs)).

## Verificación del lado Amiga-Cpp

Los cambios en `eng/core` se validaron con la suite host de Amiga-Cpp (`tools/run-host-tests.sh`):
todas las categorías pasan. El único ajuste fue `tests/host/core/073_basic_type_traits` (ahora
comprueba `sizeof(u32)==4` en vez de la identidad con `unsigned long`, que ya no se cumple en LP64).
El aviso `header-impl` sobre `eng/ai/planning/goap.hpp` es preexistente y ajeno a estos cambios.
