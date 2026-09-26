# Plugins `.n2x` (juego transpilado cargable)

Un **`.n2x`** es la **biblioteca dinámica** (`.dll`/`.so`) que resulta de compilar el **código
transpilado** de una ROM NES, con una extensión propia que identifica "transpilación cargable". El
gestor (host SDL3) las **carga, ejecuta y descarga** en runtime. Cada `.n2x` es un **cartucho
autocontenido**: lleva el código generado + la ROM embebida (PRG y CHR) + el número de mapper.

## Reparto de responsabilidades (decisión)

- **El plugin lleva:** el código generado (los `bb_*`), la ROM (PRG/CHR/mapper) y la tabla de despacho.
- **El gestor (host) lleva:** el **intérprete**, `FastCpu`, la PPU, la APU y el mapper.

Motivo: el intérprete/`FastCpu` es **idéntico para todos** los plugins, así que no se duplica: vive una
sola vez en el gestor. Cuando el plugin no cubre una dirección (RAM o salto calculado), `n2a_block`
devuelve 0 y el gestor resuelve esa instrucción con su propio motor. Así cada `.n2x` es pequeño y hay
una única versión del fallback.

## ABI (`n2a_plugin.h`)

Funciones `extern "C"` (versionadas y con arquitectura):

```
int  n2a_abi_version(void);         // el gestor compara con la suya
int  n2a_abi_arch(void);            // N2A_ARCH_X64_NT / X64_LINUX / M68K
void n2a_init(void);                // rellena la tabla de despacho
const unsigned char* n2a_prg(void); unsigned n2a_prg_size(void);
const unsigned char* n2a_chr(void); unsigned n2a_chr_size(void);
int  n2a_mapper(void);
int  n2a_block(void* cpu, void* mem, int* instrs);  // ciclos o 0 (sin bloque)
```

`cpu`/`mem` son punteros al `n2a::CPU`/`NESMemory` del gestor (mismo layout; por eso se comprueba
`n2a_abi_version`). El plugin **no** incluye `nes_interpreter.hpp` ni `fastcpu.hpp`.

## Generar un `.n2x`

```bash
nes_transpiler <rom1.nes> [rom2.nes ...] --emit-lib \
  --outdir <dir> --entry runtime/plugin/plugin_entry.cpp \
  --inc <Amiga-Cpp/engine/include> [--cxx g++] [--target x64nt|x64linux|a500|a1200|wasm]
```

Por cada ROM: escribe `<rom>.cpp` (fuente) y, si encuentra compilador, **invoca `g++ -shared`** para
producir el plugin. El nombre incluye la **plataforma** en la que se puede ejecutar:
**`<rom>.<plataforma>.n2x`** (p. ej. `smb.x64nt.n2x`, y en el futuro `smb.a500.n2x`,
`smb.a1200.n2x`, `smb.wasm.n2x`). `--target` elige la etiqueta (por defecto la del host).

- **Autodetección de rutas**: de `--entry` (`<runtime>/plugin/...`) se derivan `-I<runtime>/include` y
  `-I<runtime>/plugin`; normalmente solo hay que pasar `--inc` del engine.
- **Sidecar de metadatos**: se escribe `<rom>.<plataforma>.n2x.json` (nombre, arch, abi, mapper,
  tamaños PRG/CHR, **CRC32** de la ROM, origen).
- **Caché por CRC**: si el `.n2x` ya existe y el CRC de la ROM no cambió, **no se recompila**
  (`sin cambios, reutilizo ...`).
- `plugin_entry.cpp` incluye `n2a_game_impl.cpp` (el transpilado) y exporta la ABI.

> Si no hay compilador, se genera igualmente el `.cpp`; el `.n2x` se puede compilar luego a mano.
> La compilación **en paralelo** de varias ROMs queda pendiente (hoy es secuencial).

## Cargar/ejecutar (host)

[`n2a_loader.hpp`](n2a_loader.hpp) (`TranspiledGame`) hace `dlopen`/`LoadLibrary`, valida
versión/arquitectura, obtiene la ROM y expone `fast_run` para `NesSystem`:

```cpp
n2a::TranspiledGame game;
game.load("juego.n2x");
n2a::Mapper cart; game.fill_mapper(cart);
n2a::NesSystem sys; sys.load_mapper(cart); sys.reset();
sys.fast_ctx = &game; sys.fast_run = &n2a::TranspiledGame::fast_run;  // fallback en el host
```

En el host SDL3:

- **Ejecutar**: `nes_sdl juego.x64nt.n2x` lo carga y ejecuta (teclado: `Z`/`Espacio`=A, `X`=B,
  `Enter`=Start, flechas=cruceta, `Esc`=salir).
- **Gestor GUI**: `nes_sdl --manager <dir>` abre el **selector nativo** de `.n2x` de esa carpeta
  (SDL_ShowOpenFileDialog); al elegir uno lo ejecuta; `Esc` vuelve al selector para cargar otro;
  cerrar la ventana sale.
- **Verificar**: `nes_sdl --verify juego.x64nt.n2x [frames]` ejecuta el plugin y el intérprete sobre
  la misma ROM y compara RAM/framebuffer (`IDENTICO`/`DIVERGE`), sin ventana.

## Verificación

`plugin/load_test.cpp` carga un `.n2x`, monta el `NesSystem` con su ROM y compara el **motor codegen
(plugin)** contra el **intérprete** (RAM + framebuffer + FPS):

```bash
g++ -std=gnu++23 -O2 -static -I<eng> -Iruntime/include -Iruntime/host -Iruntime/fallback -Iruntime/plugin \
    runtime/plugin/load_test.cpp -o load_test
./load_test smb.n2x 60
```

Resultado con Super Mario Bros: `ABI v1/1`, `RAM 0/2048`, `pixeles 0/61440`, `~1.26x` vs intérprete.

## Estado

- **HECHO**: ABI + `plugin_entry.cpp`; `--emit-lib` multi-ROM con autodetección de compilador; nombre
  con **plataforma** (`<rom>.<arch>.n2x`); cartucho autocontenido (PRG+CHR+mapper); **sidecar JSON** y
  **caché por CRC**; **autodetección de rutas** de `--entry`; loader `dlopen`/`LoadLibrary` con
  validación; carga directa, **gestor** (`--manager`) y **verificación** (`--verify`) en el host SDL3.
- **PENDIENTE**: gestor con lista/info en pantalla (hoy selector nativo); **compilación en paralelo**;
  aviso explícito de seguridad (código nativo); soporte de `wasm`/`a500` aún sin toolchain integrado
  (la etiqueta y la ABI ya lo contemplan).
