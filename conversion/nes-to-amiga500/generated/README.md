# generated — salida del transpilador

Código C++23 y tablas producidas por [`../tools/transpiler/`](../tools/transpiler/README.md) a
partir de una ROM. **Regenerable**: no es fuente de verdad y se ignora por git (salvo este
README).

## Contenido esperado

```
generated/
  game_bank0.cpp ... game_bankN.cpp   basic blocks + dispatch
  game.h                              tablas de vectores/despacho
  dispatchers.cpp                     dispatch por dirección/banco
```

Cada fichero generado incluye una cabecera con mapper, tamaño de PRG y vectores.
En NROM puede emitirse un único `generated_game.cpp`. Ver
[`../docs/TRANSPILER.md`](../docs/TRANSPILER.md).
