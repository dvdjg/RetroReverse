# tools/transpiler — ROM NES → C++23 (fase 1)

Programa de **host** (C++23) que implementa la **fase 1** del nodo: parseo iNES, desensamblado
recursivo, *basic blocks* y generacion de C++23 sobre `eng/core` (**sin STL**). Diseño en
[`../../docs/TRANSPILER.md`](../../docs/TRANSPILER.md); reconocimiento de intenciones (fase 2) en
[`../../docs/HLE.md`](../../docs/HLE.md).

> Estado: **prototipo funcional NROM** (F2/A de [`../../docs/ROADMAP.md`](../../docs/ROADMAP.md)).
> Cubre opcodes oficiales + ilegales frecuentes, ramas, `JMP`/`JSR`/`RTS` y despacho por direccion.
> Mappers != 0 y el runtime real quedan pendientes (F3/F9).

## Dependencia de `eng/core` (repo Amiga-Cpp)

No usa la libreria estandar de C++: se apoya en `eng/core` del repo hermano **Amiga-Cpp** vía
`-I`. Ruta por defecto relativa (se puede sobrescribir):

```
AMIGA_CPP ?= ../../../../../../Amiga-Cpp
```

Para que el transpilador (herramienta host) pueda usar la libreria, se añadieron a `eng/core`
(commit aparte enviado por el usuario):

- `eng/core/util/heap_alloc.hpp` — `HeapAlloc` (heap del anfitrion, solo host).
- `eng/core/util/dynamic_string.hpp` — `DynamicString<A>` (cadena que crece + formateo hex/dec).

Y se hizo `eng/core` portable en host LP64 (Linux/WSL) además de m68k: `eng::u8..u64` usan los
builtins `__UINT*_TYPE__`/`__INT*_TYPE__` (ancho exacto) y `type_traits` gana `uint_of<8>` y
`is_pointer`/`is_function` sin depender de builtins ausentes en GCC < 16.

## Layout

```
transpiler/
  src/
    opcodes.hpp        tabla de opcodes (constexpr, 256 ranuras)
    cpu_stub_text.hpp  runtime provisional emitido en el fichero generado
    host_io.hpp        E/S de fichero/consola del host (<cstdio>, sin STL)
    transpiler.hpp     nucleo: iNES + desasm + CFG/basic blocks + codegen
    main.cpp           CLI
  tests/run.sh         smoke test (WSL/Linux o MinGW g++)
  Makefile
```

## Build

```bash
# WSL / Linux (g++ 13+)
make CXX=g++

# MinGW (g++ 16)
make CXX=/ruta/mingw64/bin/g++
```

Sin `make` (bash):

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

`--emit-mini-rom` / `--emit-branch-rom` generan ROMs iNES **propias** (homebrew minimo) para probar
el pipeline sin ROMs de terceros.

## Forma del codigo generado

- `PRG_ROM` como `static constexpr eng::u8[kPrgSize]` (plegado de lecturas).
- Un **basic block por funcion** (`bb_XXXX`), con `goto` a etiquetas **solo dentro del bloque**
  (auto-bucles). Los saltos entre bloques hacen `cpu.PC = destino; return;` (vuelven al despacho),
  porque una etiqueta C++ no es visible desde otra funcion.
- `JMP` absoluto estatico → `goto` (mismo bloque) o `cpu.PC`/`return`; `JMP (ind)` → `cpu.JMP_ind`.
- `JSR` → `cpu.JSR_abs(destino, retorno); return;`; `RTS`/`RTI` recuperan de la pila.
- Tabla de despacho `dispatch_table[0x10000]` + `game_main()`.
- El **runtime emitido es un stub** (`cpu_stub_text.hpp`); se sustituira por el de
  [`../../runtime/`](../../runtime/README.md) en F3/F4. En host, `int main()` esta tras
  `#if !defined(N2A_NO_HOST_MAIN)` para poder incluirlo en un arnes de test.

## Test

```bash
bash tests/run.sh          # o: make test
```

Compila la herramienta, genera dos ROMs propias, las transpila, compila y **ejecuta** el C++
generado y comprueba el estado final (mini: `X=1,A=$23,ram[0]=$23`; branch: bucle de 5 con `ADC`,
`BNE`, `JSR`/`RTS` → `A=X=5, ram[$10]=5`).

## Verificacion del lado Amiga-Cpp

Los cambios en `eng/core` se validaron con la suite host de Amiga-Cpp
(`tools/run-host-tests.sh`): todas las categorias pasan. La unica modificación pendiente alli es
`tests/host/core/073_basic_type_traits` (ajustada a `sizeof(u32)==4` en vez de `u32 == unsigned long`,
que ya no es cierto en LP64). El chequeo `header-impl` sobre `eng/ai/planning/goap.hpp` es un aviso
preexistente ajeno a estos cambios.
