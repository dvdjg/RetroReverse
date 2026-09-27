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

CHR-RAM desbloquea muchos; los fallos restantes son de **MMC1** (banking parcial: Zelda/Blaster
Master/Ninja Gaiden se quedan en un bucle antes de habilitar render) y un **opcode** no cubierto
(Ninja Gaiden `jam=1`). Siguiente: completar MMC1 (PRG banking 16/32 KB y CHR mode) y luego MMC3.

## Juegos "difíciles" para Mega Drive

Ver [`HARD_GAMES.md`](HARD_GAMES.md): inventario de los 28 juegos traídos de `F:\roms\nes` (MMC3=4,
MMC5=5, AxROM=7, VRC6=24/26, FME-7=69) y por qué la MD los sufre.

## Por qué esta matriz importa para el Amiga

Es la **referencia congelada** (tag `oracle-v1`) contra la que se validará el backend Amiga sin
rehacer nada: el Amiga se compara con el **oráculo** (mismos `hash`/estructura). Ver
[`PORT_TEST_PLAN.md`](PORT_TEST_PLAN.md) y [`VERSIONS.md`](VERSIONS.md).
