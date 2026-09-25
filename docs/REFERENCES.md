# Referencias — desensamblados y análisis de juegos clásicos

Índice **curado y propio** de la documentación, desensamblados y proyectos de referencia que se
usan en el análisis. El material de terceros **no se versiona**: se descarga a
[`external/references/`](../external/references/) (ignorado por git) con
[`scripts/fetch-references.sh`](../scripts/fetch-references.sh). Aquí solo se conserva el índice
(URLs, autoría, licencia y ubicación local).

> Uso: material de **estudio**. No se redistribuye ni se copia código en la reimplementación (la
> reimpl consume solo `spec/` + `assets/`, ADR 0003). Ver [`LEGAL.md`](LEGAL.md).

## Pac-Man / Ms. Pac-Man

| Recurso | Autor | Local | Notas |
|---|---|---|---|
| **The Pac-Man Dossier** (PDF v1.0.26) | Jamey Pittman | `external/references/docs/pac-man-dossier.pdf` | Ground truth de mecánicas/AI. Dossier citado en el nodo Pac-Man |
| The Pac-Man Dossier (HTML) | Jamey Pittman / Game Developer | [gamedeveloper.com](https://www.gamedeveloper.com/design/the-pac-man-dossier) | Versión web |
| **Ms. Pac-Man** desensamblado comentado | Scott Lawrence (BleuLlama) | `external/references/repos/GameDocs/disassemble/mspac.asm` | `.asm` comentado (base bootleg). Referencia de estilo |
| **Pac-Man Emulation Guide** (PDF) | Chris Lomont | `external/references/docs/pacman-emulation-lomont.pdf` | Hardware, mapa de memoria, emulación |
| Don Hodges — análisis de bugs/AI | Don Hodges | [donhodges.com](http://www.donhodges.com) · [Pinky](http://donhodges.com/pacman_pinky_explanation.htm) · [nivel 256](http://donhodges.com/how_high_can_you_get2.htm) · [bugs Ms. Pac-Man](http://donhodges.com/ms_pacman_bugs.htm) | Explicaciones de bugs a reproducir |
| MAME driver Pac-Man | mamedev | [src/mame/pacman/pacman.cpp](https://github.com/mamedev/mame/blob/master/src/mame/pacman/pacman.cpp) | Fuente del `rom/layout.json` |
| Emulador Pac-Man (C, referencia) | superzazu | `external/references/repos/pac-superzazu` | [github](https://github.com/superzazu/pac) |
| Emulador Pac-Man (referencia) | frisnit | `external/references/repos/pacman-emulator` | [github](https://github.com/frisnit/pacman-emulator) |
| GameInternals — AI de fantasmas | — | [gameinternals.com](https://gameinternals.com/post/2072558330) | Resumen del Dossier |

## NES

| Recurso | Autor | Local | Notas |
|---|---|---|---|
| Super Mario Bros. → C | Mitchell Sternke | `external/references/repos/SuperMarioBros-C` | [github](https://github.com/MitchellSternke/SuperMarioBros-C) |
| Super Mario Bros. disasm | nathsou | `external/references/repos/smb-nathsou` | [github](https://github.com/nathsou/smb) |
| The Legend of Zelda disasm | aldonunez | `external/references/repos/zelda1-disassembly` | [github](https://github.com/aldonunez/zelda1-disassembly) |
| Colección NES disasm | cyneprepou4uk | [NES-Games-Disassembly](https://github.com/cyneprepou4uk/NES-Games-Disassembly) | Muchos juegos |

### NES — documentación de hardware (para el emulador óptimo)

Base para escribir un emulador NES cycle-accurate propio.

| Recurso | Enlace | Local | Notas |
|---|---|---|---|
| **NESDev Wiki** | [nesdev.org/wiki](https://www.nesdev.org/wiki/) | `external/references/docs/nesdev-wiki.html` | Ricoh 2A03 (6502 sin decimal), PPU 2C02 (render/VBLANK/NMI, `$2000-$2007`), APU, mappers (MMC1/MMC3/VRC6) |
| **NES Emulator Development Guide** | [gist rhysd](https://gist.github.com/rhysd/ec4eec8b70dabc196a21a37c0ba4688e) | `external/references/docs/nes-emulator-dev-guide.md` | PPU, decode 6502, render por bloques de scanlines, sincronía CPU:PPU 1:3 |
| **6502 Instruction Set & Illegal Opcodes** | [masswerk.at](https://www.masswerk.at/6502/6502_instruction_set.html) | `external/references/docs/6502-instruction-set.html` | Modos, ciclos por instrucción y opcodes indocumentados |
| **NES Test ROMs Suite** | [christopherpow/nes-test-roms](https://github.com/christopherpow/nes-test-roms) | `external/references/repos/nes-test-roms` | `nestest` (CPU), timing PPU/APU, MMC3; validación cycle-accurate |
| **Mesen 2** (SourMesen) | [SourMesen/Mesen2](https://github.com/SourMesen/Mesen2) | `external/references/repos/mesen2` | Emulador de referencia cycle-accurate; trazas, VRAM/RAM, tilemap viewer |
| **olcNES** (OneLoneCoder) | [onelonecoder/olcNES](https://github.com/onelonecoder/olcNES) | `external/references/repos/olcNES` | Emulador C++ educativo: bus, 2A03, PPU 2C02, mappers básicos |
| **FCEUX** | [TASEmulators/fceux](https://github.com/TASEmulators/fceux) | `external/references/repos/fceux` | Análisis dinámico, scripts Lua, trazado en tiempo real |
| **Nesium** | [mikai233/nesium](https://github.com/mikai233/nesium) | `external/references/repos/nesium` | Emulador moderno cycle-accurate con depuración (OAM, pattern tables, IRQ) |


## Mega Drive / Genesis

| Recurso | Autor | Local | Notas |
|---|---|---|---|
| Sonic 1 disasm | sonicretro | `external/references/repos/s1disasm` | [github](https://github.com/sonicretro/s1disasm) · s2disasm/skdisasm en [sonicretro](https://github.com/sonicretro) |
| Altered Beast disasm | hansbonini | [smd_alteredbeast](https://github.com/hansbonini/smd_alteredbeast) | Juego en la selección de ROMs |

## Amiga

| Recurso | Autor | Local | Notas |
|---|---|---|---|
| Populous (análisis + doc) | tetracorp | `external/references/repos/populous` | [doc](https://tetracorp.github.io/populous/) |
| Driller | hitchhikr | `external/references/repos/driller` | [github](https://github.com/hitchhikr/driller) |
| Guía RE Amiga | tetracorp | [guide](https://tetracorp.github.io/guide/reverse-engineering-amiga.html) | Metodología |

## Arcade / MAME (general)

| Recurso | Local/URL | Notas |
|---|---|---|
| Árbol de MAME | [github](https://github.com/mamedev/mame) | Hardware, drivers, bugs. Fuente de los `layout.json` |
| Don Hodges (Galaga, Dig Dug, Defender, …) | [donhodges.com](http://www.donhodges.com) | Análisis de bugs por juego |

## Emuladores de referencia (libretro) usados por el orquestador

Los cores se compilan en `external/` (no versionados): ver
[`tools/orchestrator/README.md`](../tools/orchestrator/README.md). Cobertura: `mame2003-plus`
(arcade), `mesen` (NES), `genesis-plus-gx` (MD/SMS/GG), `puae`/libretro-uae (Amiga), `stella`
(Atari 2600), `gambatte` (GB/GBC), `smsplus-gx` (SMS/GG).

## Herramientas de análisis

| Herramienta | Versión | Uso | Local |
|---|---|---|---|
| **Capstone** | 5.0.7 (WSL `pip`) | Desensamblado m6502/m68k (Z80 no en v5) | `tools/python/capstone_disasm.py` |
| **Ghidra** | 12.0.1 | CFG/xrefs/decompilador (Z80/6502/68k) | `external/ghidra_12.0.1_PUBLIC` |
| **GhidraNes** | build 12.0.1 | Loader NES (inicializa bloque PRG/CHR) | `Ghidra/Extensions/GhidraNes` |
| **GhidraRetroReversing** | 11.1.2 | Loaders NES/GB/MD/SMS/GBA… (para Ghidra 11.1.2) | `external/ghidra-extensions/` |
| **libRetroReversing** | submodule | Trazas/CDL/export en cores (NES/GB/MD/SNES) | `external/libRetroReversing`, fork `external/libretro-gpgx-reversing` |
| **Rizin** | 0.9.x | Alternativa ligera (xrefs/CFG); Z80 | `external/rizin-win-installer-clang_cl-64` |
| **gdb-multiarch** | (pendiente) | Símbolos por arreglo para Ghidra | — |

> Nota: las extensiones precompiladas de GhidraRetroReversing son para **11.1.2** y **no cargan**
> en Ghidra 12 (cambios de API: `HashUtilities`, `Loader.load(ImporterSettings)`). Para 12 se usa
> el **build oficial de GhidraNes 12.0.1**; el resto requiere recompilar desde fuente.



## ROMs

La selección de ROMs propias está en [`ROM_SELECTION.md`](ROM_SELECTION.md); el contenido binario
vive en `roms/` (ignorado por git).
