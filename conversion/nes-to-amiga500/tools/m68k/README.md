# Benchmark m68k (sin el engine)

Compila el motor de CPU del nodo (intérprete y ejecutor rápido) para **`m68k-amiga`** usando el
toolchain de `vscode-amiga-debug` (GCC 15.1.0, `-m68000`) **sin depender del engine `Amiga-Cpp`**
(en desarrollo). Para ello se aporta un **shim** mínimo de `eng/core`.

## Contenido

| Fichero | Qué es |
|---|---|
| `shim/eng/core/types/types.hpp` | Alias de enteros (`u8…usize`) vía tipos del compilador |
| `shim/eng/core/util/array.hpp` | `Array<T,N>` fijo (tabla de opcodes) |
| `shim/eng/core/util/string_view.hpp` | `StringView` mínimo (decodificador del ejecutor) |
| `bench_m68k.cpp` | ROM de cálculo + bucle intérprete/ejecutor (`-DN2A_USE_FAST`) |
| `run.ps1` | Compila a `.o` m68k (sin libc) y valida en host |

El shim solo cubre lo que usan `nes_runtime.hpp`, `nes_interpreter.hpp`, `fastcpu.hpp` y
`opcodes.hpp`; **no** sustituye al engine para el resto del runtime (PPU/APU/plataforma).

## Uso

```powershell
powershell -File run.ps1          # (opcional) $env:M68K_CXX / $env:M68K_OBJDUMP
```

## Resultado (GCC 15.1.0, `-m68000 -O2`, sin libc)

| Motor | `.text` |
|---|---:|
| Intérprete | 47 782 B |
| Ejecutor rápido | 45 638 B |

El ejecutor rápido **no es más grande** que el intérprete (mismo orden) y ambos compilan sin cambios
para 68000 (sin `long long` en rutas calientes, sin alineación problemática). En host, los dos
motores dan el **mismo estado final** (`steps=294657 A=9E [$10]=C4 [$11]=3C`), coherente con el
benchmark de codegen (`tools/transpiler/tests/bench_codegen.sh`).

**Pendiente**: medir **ciclos reales en A500**. El benchmark es *bare-metal* (solo objeto); para
ejecutarlo hace falta enlazarlo con un arranque AmigaDOS y lanzarlo bajo **WinUAE** (presente en el
entorno, p. ej. `WinUAE-DBG`). Alternativas: contar instrucciones m68k del bucle caliente con
`objdump -d` o instrumentar con `mcp-winuae-emu`.
