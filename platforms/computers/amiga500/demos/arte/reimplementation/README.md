# reimplementation — «Arte» en C++23 + SDL3

Reimplementación **agnóstica de hardware** del demo. **Regla (ADR 0003): esta carpeta SOLO lee
`spec/` (HIGS) + `assets/`.** No conoce el hardware original ni el desensamblado.

- HIGS: [`../spec/game.json`](../spec/game.json) · assets: [`../assets/`](../assets/).
- Contrato de port y C/C++ de referencia (Q15 + ASM canónico): [`../reimplementation/reference/`](reference/README.md).

## Estado

| Pieza | Estado |
|---|---|
| Cargador de HIGS (`spec.cpp`) | esqueleto (lectura naive → migrar a JSON lib) |
| Verificación de assets | hecho (`check_assets`) |
| Bucle de juego (`game.cpp`) | esqueleto (`update`/`render` TODO) |
| Render **SDL3** | pendiente |
| Validación diferencial | pendiente |

## Construir / verificar

```sh
make check          # g++ (host): valida la HIGS y que existan los assets
# o
cmake -S . -B build && cmake --build build && ./build/arte ..
```

`arte_check` carga `../spec/game.json`, comprueba los campos y que existan todos los assets;
devuelve 0 si todo cuadra.

## Estructura

```
reimplementation/
  include/arte/{spec.hpp,game.hpp}
  src/{spec.cpp,game.cpp,main.cpp}
  CMakeLists.txt · Makefile
```

## Nota

`reference/` es la **referencia de port** (C/C++ fiel al asm + ASM canónico). `reimplementation/`
es el **destino** (SDL3, desde la HIGS). No mezclar: `reference/` documenta la técnica; aquí se
reconstruye el juego.
