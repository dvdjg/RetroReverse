# Amiga-Reverse — expedientes de desensamblado Amiga

Colección de expedientes de reverse engineering de software Amiga 68k (demos, juegos, módulos).
Cada título vive en su propia carpeta y sigue la estructura canónica de `STRUCTURE.md`.

El fin último es **recuperar técnicas y media** para **reimplementarlas en C++** en proyectos
propios. No se redistribuye código ni assets originales.

## Índice de expedientes

| Título | Año | Plataforma | Estado | Carpeta |
|---|---|---|---|---|
| Arte (Sanity) | 1993 | A500 OCS/ECS | En curso | [`sanity-arte/`](sanity-arte/README.md) |

## Documentos transversales

- [`STRUCTURE.md`](STRUCTURE.md) — estructura canónica de un expediente y reglas.
- [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md) — método reutilizable (DMS, loaders
  propios, WinUAE-DBG + GDB, enganche de decrunchers, trampas de entorno).

## Toolkit reutilizable

Todas las utilidades viven en [`toolkit/`](toolkit/README.md), documentadas y parametrizables
(no atadas a un título):

| Script | Uso |
|---|---|
| `toolkit/python/dms_unpack.py` | DMS -> ADF verificado (CRC/checksum por pista) |
| `toolkit/python/bin_scan.py` | strings/entropía de un ADF o volcado |
| `toolkit/node/winuae-session.mjs` | biblioteca: sesión WinUAE-DBG + GDB |
| `toolkit/node/dump-ram.mjs` | lanza WinUAE-DBG y vuelca regiones de RAM |
| `toolkit/node/hook-trampoline.mjs` | engancha un decruncher por firma y vuelca bloques |
| `toolkit/node/probe-breakpoints.mjs` | verifica que el stub aplica breakpoints |

## Entorno

- `WinUAE-DBG/bin/winuae-gdb.exe` (x86) — emulador + servidor GDB `:2345` + canal lateral `:2346`.
- `mcp-winuae-emu` — módulo Node (`WinUAEConnection`, `GdbProtocol`) para automatizar el emulador.
- `m68k-amiga-elf-objdump.exe` (extensión Bartman) — desensamblador.
- Kickstart 1.3 (`C:\Amiga\KICK13.rom`).

## Añadir un título

Ver `STRUCTURE.md` §«Abrir un título nuevo». Copiar `_template/` y seguir el roadmap.
