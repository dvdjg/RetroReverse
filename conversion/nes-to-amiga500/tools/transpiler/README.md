# tools/transpiler — ROM NES → C++23

Programa de **host** (C++23) que implementa la **fase 1**: parser iNES/NES 2.0, desensamblado
recursivo, CFG, basic blocks y generación de C++23. Diseño completo en
[`../../docs/TRANSPILER.md`](../../docs/TRANSPILER.md) y
[`../../docs/HLE.md`](../../docs/HLE.md) (fase 2).

> Estado: **esqueleto** (F0). La implementación es la tarea de **F2** del
> [`ROADMAP`](../../docs/ROADMAP.md).

## Layout previsto

```
transpiler/
  src/
    opcodes.hpp        tabla de opcodes (oficiales + ilegales frecuentes)
    rom_ines.hpp/.cpp  parseo iNES / NES 2.0 + vectores + PRG
    disasm.hpp/.cpp    desensamblado recursivo (worklist)
    cfg.hpp/.cpp       basic blocks / leaders
    codegen.hpp/.cpp   emisión de C++23 (goto + etiquetas, dispatch)
    hle_recognizer.*   (fase 2) patrones → hle_*()
    main.cpp           CLI
  Makefile             host: g++/clang; MSVC documentado
```

## Build (host)

```bash
g++     -std=c++23 -O2 -o nes_transpiler src/*.cpp
clang++ -std=c++23 -O2 -o nes_transpiler src/*.cpp
```

## Uso

```bash
nes_transpiler juego.nes -o ../../generated/game.cpp
```

## Salida

Código en [`../../generated/`](../../generated/README.md) (regenerable, ignorado por git). El
código generado se compila luego con el runtime de [`../../runtime/`](../../runtime/README.md).
