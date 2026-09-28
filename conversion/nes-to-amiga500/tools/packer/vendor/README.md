# vendor/ — terceros vendorizados

Código de terceros **copiado al repo** (no referenciado a `external/`), con su licencia. Solo se
compila lo que usa el packer; el resto queda como referencia.

## `zx0/` — ZX0 (Einar Saukas)

- Licencia: **BSD‑3‑Clause** ([`zx0/LICENSE`](zx0/LICENSE)).
- Compresor (se compila en el packer): `compress.c`, `optimize.c`, `memory.c`, `zx0.h`.
  API usada: `optimize(...)` + `compress(...)` (ver `src/codecs.cpp`).
- Referencia (no se compila): `zx0.c` (CLI), `dzx0.c` (decompresor C de referencia).
- Decruncher **68000** (`asm68000/`): [`emmanuel-marty/unzx0_68000`](https://github.com/emmanuel-marty/unzx0_68000),
  `unzx0_68000.S` (88 bytes, zlib‑style), que es el que usará el cargador del Amiga.

El decodificador del lado PC del packer (`--verify`/`--unpack`) es una implementación propia
(`src/codecs.cpp`) derivada de la lógica de `dzx0.c` (dominio público/BSD‑3), sin depender del CLI.
