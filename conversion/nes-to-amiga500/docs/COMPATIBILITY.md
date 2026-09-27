# Matriz de compatibilidad (oráculo vs `mesen`)

Por cada ROM de `runtime/build/*.nes`: **mapper**, **hash de framebuffer del oráculo** (huella
determinista, `nes_frame`) y diff **estructural** (luminancia, tolerante a la paleta) contra `mesen`
a 60 frames. Regenerar: `bash runtime/test/port_matrix.sh` (o `--subset` para unos pocos).

| ROM | mapper | hash (oráculo) | estructura vs mesen |
|---|---:|---|---:|
| bf | 0 | 04c3132d97e3672d | **0.0%** |
| dk | 0 | 7328b6a9584db4fd | **0.0%** |
| dkjr | 0 | 34f01ab01fd0d11f | **0.0%** |
| exb | 0 | 875ff9a0bca77295 | **0.0%** |
| kungfu | 0 | c9be5cc53c87d813 | **0.0%** |
| mariobros | 0 | bede7c8b020a9bdb | **0.0%** |
| mspacman | 0 | d9883df6de0f2047 | **0.0%** |
| popeye | 0 | 41e76abab6c7fee7 | **0.0%** |
| smb | 0 | 698b602b6fb8f86f | 3.1% |
| xevious | 0 | 3d7944c0da3f5263 | 4.4% |
| pacman | 0 | 6e9afde6b9ecf94f | 12.9% |
| galaga | 0 | 1bca91d35b077dbb | 36.4% |
| ic | 0 | a55551d254978383 | **92.2%** |

Todas mapper 0 (NROM) por ahora.

## Lectura

- **0.0% (8 juegos)**: geometría/tiles idénticos a `mesen`; lo que queda es solo paleta.
- **smb 3.1% / xevious 4.4%**: residual de timing (SMB, ver `RISKS.md`) y cruce de nametable.
- **pacman 12.9% / galaga 36.4%**: **deriva de frames** (no dot-exactos sub-ciclo a muchos frames).
- **ic 92.2%**: **bug real confirmado** (ver abajo).

## Bug de Ice Climber (ic) — confirmado

El framebuffer sale de **un solo color** (fondo): la **paleta no se carga** (a 60 frames solo
`palette[0x1F]` tiene valor). Evidencia (trazas `$2007`/`$2006` de `frame_probe`):
- El único sitio que fija `v=$3F00` es una **rutina de "warm-up"** en `$80A8`
  (`LDA #$3F;STA $2006;LDA #$00;STA $2006;STA $2006;STA $2006;LDA $2002`), que **termina en
  `v=$0000`** y **no va seguida de ningún `$2007`** con `v` en `$3F00-$3F1F`.
- Un run de relleno de la nametable (`$3D5F+0x20k`) **desborda hacia `$3F00+`** y `$4000+`.
- **El manejo de `$2006`/`$2007` del PPU es correcto** para las direcciones que el juego fija; el
  render es correcto dada una paleta vacía. Conclusión: el **cargador de paleta no se ejecuta/llega**,
  lo que apunta a una **divergencia de estado/CPU en el arranque** (misma familia que SMB), no a un
  bug del PPU. Pendiente: traza de PC comparada para localizar el desvío.

## Set ampliado (mappers MMC1/UxROM/CNROM + CHR-RAM)

Se añadió soporte de **CHR-RAM** (`nes_ppu.hpp`: `chr_ram`; los cartuchos con 0K CHR cargan los
patrones por `$2007`). Resultados a 60 frames (`structura` vs mesen):

| ROM | mapper | CHR | estructura | notas |
|---|---:|---|---:|---|
| contra | 2 | ROM | **0.0%** | OK |
| bioniccommando | 1 | RAM | 1.3% | OK |
| castlevania | 2 | RAM | **0.0%** | OK (color 26.8%) |
| ducktales | 2 | RAM | **0.0%** | OK (color 96.6%) |
| megaman | 2 | RAM | **0.0%** | OK |
| gradius | 3 | ROM | 5.4% | OK |
| megaman2 | 1 | RAM | 10.5% | parcial |
| metroid | 1 | RAM | 12.9% | parcial (deriva) |
| legendofzeldathe | 1 | RAM | 80.9% | **atascado** (render nunca habilitado) |
| blastermaster | 1 | RAM | 100% | **atascado** |
| ninjagaiden | 1 | RAM | 99.2% | **`jam` (opcode ilegal)** |

CHR-RAM desbloquea muchos; los fallos restantes son de **MMC1** (banking parcial) y un **`jam`**.
Diagnóstico añadido: `NesInterpreter::jam_op`/`jam_pc` (frame_probe lo imprime `op=XX@YYYY`).
- **Ninja Gaiden**: el `jam` es un **KIL (`$22`) en `$A4D4`** → el CPU ejecuta **datos** (banking
  MMC1 erróneo), no un opcode desconocido.
- **Referencia encontrada**: las fuentes de los cores que ya tenemos contienen MMC1 real —
  `external/libretro-mame/src/devices/bus/nes/mmc1.cpp` (`nes_sxrom`) y
  `external/libretro-fceumm/src/boards/asic_mmc1.c`. Según MAME, los modos PRG (ctrl bits 2-3) son:
  `0/1`=32 KB; `2`=`$8000` **fijo banco 0** / `$C000` conmutable; `3`=`$8000` conmutable / `$C000`
  **último fijo**. El latch es **compartido** entre los 4 registros y el desplazamiento es
  **LSB-first** (nuestro código ya coincide en esto). MAME filtra además escrituras consecutivas de
  1 ciclo (`m_reg_write_enable`), que **no** implementamos.
- Se implementó el modo 2 correcto y **regresó** Metroid (`m1p=0x10` fuera de rango; jam). Se
  **revirtió**: el comportamiento actual (modo ≥2 = `$8000`=banco conmutable, `$C000`=último) es el
  que hace funcionar Metroid/Mega Man 2. MMC1 sigue **parcial**; falta cotejar con el filtro de
  escritura / CHR mode (no ir a ciegas: dos intentos, dos regresiones).

Siguiente: cerrar MMC1 con la referencia (filtro de 1 ciclo + modo CHR) antes de MMC3.

## MMC3 (mapper 4) — IMPLEMENTADO

Se añadió **MMC3** a `nes_mapper.hpp` (PRG en 4 ventanas de 8 KB, CHR con modos 2/1 KB,
mirroring por `$A000`, IRQ por scanline) + **PRG-RAM** (`$6000-$7FFF`) en `NesSystem` (era la
clave: sin ella SMB3/Crystalis se colgaban) + IRQ de CPU reutilizada. Resultados (estructura vs
mesen, 60 frames):

| ROM | estructura | notas |
|---|---:|---|
| ninjagaiden2 / ninjagaiden3 / megaman6 | **0.0%** | perfecto |
| megaman4 / tinytoon / superc / crystalis | 2–3% | perfecto (paleta/1 frame) |
| shatterhand | 6.6% | |
| adventureisland3 | 17.2% | color 98% (paleta) |
| megaman5 / jurassicpark | 25–28% | usa IRQ por raster |
| megaman3 / metalstorm | 36–38% | usa IRQ por raster |
| smb3 | 53.6% | usa IRQ por raster (status bar) |

Es decir, **el núcleo MMC3 es correcto** (varios a 0.0%); lo que queda alto son juegos que usan el
**IRQ de raster de la MMC3** (nuestro contador es por scanline y aproxima el A12, y hay deriva de
frames), más el PRG/CHR mode en algunos casos.

## Juegos "difíciles" para Mega Drive

Ver [`HARD_GAMES.md`](HARD_GAMES.md): inventario de los 28 juegos traídos de `F:\roms\nes` (MMC3=4,
MMC5=5, AxROM=7, VRC6=24/26, FME-7=69) y por qué la MD los sufre.

## Por qué esta matriz importa para el Amiga

Es la **referencia congelada** (tag `oracle-v1`) contra la que se validará el backend Amiga sin
rehacer nada: el Amiga se compara con el **oráculo** (mismos `hash`/estructura). Ver
[`PORT_TEST_PLAN.md`](PORT_TEST_PLAN.md) y [`VERSIONS.md`](VERSIONS.md).
