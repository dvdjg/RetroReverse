# Matriz de compatibilidad (oráculo vs `mesen`)

Por cada ROM de `runtime/build/*.nes`: **mapper**, **hash de framebuffer del oráculo** (huella
determinista, `nes_frame`) y diff **estructural** (luminancia, tolerante a la paleta) contra `mesen`
a 60 frames. Regenerar: `bash runtime/test/port_matrix.sh` (o `--subset`, `--gate`, `--update`).

Las ROMs nuevas de mappers ampliados (VRC6/MMC5/AxROM/FME-7) se importan de
`roms/nes/dificiles/*.zip` con `bash runtime/test/import-new-roms.sh` (el contenido de las ROMs no se
versiona; `build/` está en `.gitignore`).

Referencia: **mesen** (cycle-accurate). El detalle de método (trazas de PC, re-sync por PC) está en
[`REFERENCE_TRACER.md`](REFERENCE_TRACER.md); las limitaciones reales, en [`RISKS.md`](RISKS.md).

## Matriz (60 frames)

| ROM | mapper | hash (oráculo) | estructura vs mesen |
|---|---:|---|---:|
| adventureisland3.nes | 4 | 5d038b0a606c8533 | **0.0%** |
| bf.nes | 0 | 04c3132d97e3672d | **0.0%** |
| bioniccommando.nes | 1 | c01d2139c3342edd | **0.0%** |
| blastermaster.nes | 1 | 8a7b8dc3994cd02b | **0.0%** |
| castlevania.nes | 2 | d1b769801057969b | **0.0%** |
| contra.nes | 2 | b43e93ee563b00f1 | 0.9% |
| crystalis.nes | 4 | 8a8236eec0306f33 | 2.7% |
| dk.nes | 0 | 7328b6a9584db4fd | **0.0%** |
| dkjr.nes | 0 | 34f01ab01fd0d11f | **0.0%** |
| ducktales.nes | 2 | 2322b9db55bbffe9 | **0.0%** |
| exb.nes | 0 | 875ff9a0bca77295 | **0.0%** |
| galaga.nes | 0 | b9a1f352e7973f29 | 36.7% |
| gradius.nes | 3 | d469bd3c363f13cb | 3.3% |
| ic.nes | 0 | a55551d254978383 | 92.2% |
| jurassicpark.nes | 4 | 0bf9becd786be2e9 | **0.0%** |
| kungfu.nes | 0 | c9be5cc53c87d813 | **0.0%** |
| legendofzeldathe.nes | 1 | ee3583a5ad9b7d25 | 0.4% |
| mariobros.nes | 0 | bede7c8b020a9bdb | **0.0%** |
| megaman.nes | 2 | 267c824a48dbae2f | **0.0%** |
| megaman2.nes | 1 | 7c173727e77aa95d | **0.0%** |
| megaman3.nes | 4 | 4eb841b0583bbb83 | **0.0%** |
| megaman4.nes | 4 | 729624b8d3285f43 | 2.6% |
| megaman5.nes | 4 | 335d4236a41e1cbd | **0.0%** |
| megaman6.nes | 4 | 3843a7520e54c17d | **0.0%** |
| metalstorm.nes | 4 | 82679d2512b7c06b | 14.2% |
| metroid.nes | 1 | 6d60cfca28c2626b | **0.0%** |
| mspacman.nes | 0 | d9883df6de0f2047 | **0.0%** |
| ninjagaiden.nes | 1 | 715560d48b6fd58b | 1.2% |
| ninjagaideniii….nes | 4 | 5262cb44d08ec383 | **0.0%** |
| ninjagaidenii….nes | 4 | 5262cb44d08ec383 | **0.0%** |
| pacman.nes | 0 | 33fe82bcda272bcf | 13.2% |
| popeye.nes | 0 | 41e76abab6c7fee7 | **0.0%** |
| shatterhand.nes | 4 | 5012b52846c85bbd | **0.0%** |
| smb.nes | 0 | 698b602b6fb8f86f | 3.1% |
| smb3.nes | 4 | a950ee1dc1d5b483 | 0.4% |
| superc.nes | 4 | 5262cb44d08ec383 | **0.0%** |
| tinytoonadventures.nes | 4 | 4b838964cfde9dfd | **0.0%** |
| xevious.nes | 0 | 13048012ca91d263 | 3.6% |

## Juegos nuevos (mappers ampliados: VRC6 / MMC5 / AxROM / FME-7)

Importados con `bash runtime/test/import-dificiles.sh` (de `roms/nes/dificiles/*.zip`).

| Juego | mapper | estructura vs mesen |
|---|---:|---:|
| Kirby's Adventure (Rev A) | 4 (MMC3) | **0.0%** |
| Batman - The Video Game | — | **0.0%** |
| Contra (USA) | 2 (UxROM) | 0.9% |
| Gemfire | 5 (MMC5) | **4.6%** |
| Batman - Return of the Joker | 69 (FME-7) | **4.6%** |
| Esper Dream 2 | 26 (VRC6b) | **4.6%** |
| Nobunaga's Ambition II | 5 (MMC5) | **5.0%** |
| Mr. Gimmick | 69 (FME-7) | **5.0%** |
| Mouryou Senki Madara | 26 (VRC6b) | **5.7%** |
| Battletoads | 7 (AxROM) | **6.2%** |
| Laser Invasion | 5 (MMC5) | **6.5%** |
| Uncharted Waters | 5 (MMC5) | **7.3%** |
| Castlevania III (USA) | 5 (MMC5) | **9.2%** |
| Akumajou Densetsu | 24 (VRC6) | **9.5%** |

## Lectura

- **23 juegos a 0.0%**: geometría/tiles idénticos a `mesen`; lo que queda es solo paleta.
- **9 juegos ≤3.6%** (contra, crystalis, gradius, megaman4, ninjagaiden, smb, smb3, xevious, zelda):
  residual menor de timing (misma raíz que abajo).
- **4 juegos 13–92%** (ic 92.2%, galaga 36.7%, metalstorm 14.2%, pacman 13.2%): **un único límite
  conocido** — la sincronización PPU/NMI **por instrucción** (frames con deriva). Los 6 juegos eran
  la misma causa; **jurassicpark y blastermaster ya están a 0.0%** tras la **Fase 1+2** del timing
  (PPU dot a dot + fase continua; ver [`TIMING_ROADMAP.md`](TIMING_ROADMAP.md)). Lo que queda es la
  **deriva entre frames** (frontera de frame sub-instrucción). Detalle y solución en
  [`RISKS.md`](RISKS.md).

## Mappers soportados

| Mapper | Nombre | Estado |
|---:|---|---|
| 0 | NROM | completo |
| 1 | MMC1 | **completo** (PRG modes 2/3, CHR 4K/8K conmutada, WRAM + disable, 1-pantalla/V/H) |
| 2 | UxROM | completo |
| 3 | CNROM | completo |
| 4 | MMC3 | PRG/CHR por bancos, mirroring, IRQ por flanco de A12 (modelo por línea) |
| 5 | MMC5 | **subconjunto**: PRG (4 modos), CHR (4 modos), WRAM `$6000-$7FFF`, ExRAM `$5C00-$5FFF`, fill-mode. Pendiente: nametables por ExRAM/CHR ROM, split vertical, IRQ, multiplicador, audio |
| 24/26 | VRC6 | PRG/CHR por bancos, mirroring (`$B003`), IRQ por ciclos de CPU; variante VRC6b (26) |
| — | CHR-RAM | soportado (patrones por `$2007`) |

Juegos nuevos que arrancan y renderizan (estructura vs mesen, 60 frames):
**Akumajou Densetsu (VRC6/24) 9.5%**, **Esper Dream 2 (VRC6/26) 4.6%**,
**Castlevania III (MMC5/5) 9.2%**.

Pendientes (para más ROMs "difíciles"; ver [`HARD_GAMES.md`](HARD_GAMES.md)): AxROM (7),
FME-7 (69); y en MMC5, los modos de nametable por ExRAM/CHR y el split vertical.

## Notas de método

- El **tracer de re-sync por PC** (`trace_diff.py`) fue clave: la comparación por índice se atasca
  en el bucle de VBlank (benigno) y **oculta** la divergencia real; re-sincronizando por PC se
  demuestra que los 6 "malos" comparten **una** raíz.
- El render usa la **CHR conmutada** del mapper (no la ROM lineal): sin esto, los juegos con bancos
  de CHR (smb3, megaman3, ninjagaiden…) daban geometría equivocada.
