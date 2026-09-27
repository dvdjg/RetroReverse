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

| ROM | mapper | estructura vs mesen |
|---|---:|---:|
| adventureisland3.nes | 4 | **0.0%** |
| bf.nes | 0 | **0.0%** |
| bioniccommando.nes | 1 | **0.0%** |
| blastermaster.nes | 1 | **0.0%** |
| castlevania.nes | 2 | **0.0%** |
| contra.nes | 2 | 0.9% |
| crystalis.nes | 4 | 2.7% |
| dk.nes | 0 | **0.0%** |
| dkjr.nes | 0 | **0.0%** |
| ducktales.nes | 2 | **0.0%** |
| exb.nes | 0 | **0.0%** |
| galaga.nes | 0 | 0.9% |
| gradius.nes | 3 | 3.3% |
| ic.nes | 0 | 92.2% |
| jurassicpark.nes | 4 | **0.0%** |
| kungfu.nes | 0 | **0.0%** |
| legendofzeldathe.nes | 1 | **0.0%** |
| mariobros.nes | 0 | **0.0%** |
| megaman.nes | 2 | **0.0%** |
| megaman2.nes | 1 | **0.0%** |
| megaman3.nes | 4 | **0.0%** |
| megaman4.nes | 4 | 2.6% |
| megaman5.nes | 4 | **0.0%** |
| megaman6.nes | 4 | **0.0%** |
| metalstorm.nes | 4 | 14.2% |
| metroid.nes | 1 | **0.0%** |
| mspacman.nes | 0 | **0.0%** |
| ninjagaiden.nes | 1 | 1.2% |
| ninjagaideniii….nes | 4 | **0.0%** |
| ninjagaidenii….nes | 4 | **0.0%** |
| pacman.nes | 0 | 0.3% |
| popeye.nes | 0 | **0.0%** |
| shatterhand.nes | 4 | **0.0%** |
| smb.nes | 0 | 3.1% |
| smb3.nes | 4 | 0.4% |
| superc.nes | 4 | 0.1% |
| tinytoonadventures.nes | 4 | **0.0%** |
| xevious.nes | 0 | **0.0%** |

## Juegos nuevos (mappers ampliados: VRC6 / MMC5 / AxROM / FME-7)

Importados con `bash runtime/test/import-dificiles.sh` (de `roms/nes/dificiles/*.zip`).
**Matriz regenerada 2026** tras arreglar `nes_frame` (antes usaba un switch NROM↔MMC3 propio y
**no cargaba** los mappers nuevos → las cifras previas de esta tabla eran basura; ver §Lectura).

| Juego | mapper | estructura vs mesen |
|---|---:|---:|
| Kirby's Adventure (Rev A) | 4 (MMC3) | 0.4% |
| Batman - The Video Game | 1 (MMC1) | **0.0%** |
| Batman - Return of the Joker | 69 (FME-7) | **0.0%** |
| Mr. Gimmick | 69 (FME-7) | **0.0%** |
| Gemfire | 5 (MMC5) | **0.0%** |
| Battletoads | 7 (AxROM) | 1.9% |
| Contra (USA) | 2 (UxROM) | 0.9% |
| Castlevania III (USA) | 5 (MMC5) | 2.7% |
| Akumajou Densetsu | 24 (VRC6) | 2.7% |
| Crystalis (USA) | 4 (MMC3) | 2.7% |
| Laser Invasion | 5 (MMC5) | 3.1% |
| Nobunaga's Ambition II | 5 (MMC5) | 0.6% |
| Esper Dream 2 | 26 (VRC6b) | **100.0%** |
| Mouryou Senki Madara | 26 (VRC6b) | **99.9%** |
| Uncharted Waters | 5 (MMC5) | **45.8%** |

## Lectura

> **Corrección importante 2026.** Las cifras previas de los **mappers nuevos** (MMC5 4.6–9.2%,
> AxROM 6.2%, VRC6 9.5%, FME-7 4.6%) eran **basura de medición**: `nes_frame` (la herramienta que
> usa `diff_mesen.sh`) tenía su **propio switch de mappers limitado a NROM↔MMC3** y devolvía
> `ERROR: mapper N no soportado` sin escribir frame → se comparaba el frame **vacío**. Arreglado
> (`nes_frame` ahora usa `load_ines`, como `frame_probe`). La matriz se regeneró:

- **0.0% reales en mappers nuevos**: **Gemfire (MMC5)**, **Mr. Gimmick** y **Batman RotJ (FME-7)**,
  **Batman - The Video Game (MMC1)**. Los antes "4.6–5.0%" eran el frame vacío.
- **Mejor de lo documentado antes**: galaga **36.7% → 0.9%**, pacman **13.2% → 0.3%**, xevious
  **3.6% → 0.0%**, Nobunaga's (MMC5) **5.0% → 0.6%**, Akumajou (VRC6) **9.5% → 2.7%**, CV3 (MMC5)
  **9.2% → 2.7%**, Battletoads (AxROM) **6.2% → 1.9%**. Parte de esta mejora acumulaba los fixes de
  timing (Fase 1+2) que el baseline viejo no reflejaba (estaba **desactualizado**).
- **BUGS NUEVOS destapados** (frames completamente distintos a `mesen`):
  - **Esper Dream 2 (VRC6b/26): 100.0%** y **Mouryou Senki Madara (VRC6b/26): 99.9%** → la variante
    **VRC6b** pinta mal (probable bug de detección/mapeo de la variante 26, o CHR/nametable).
  - **Uncharted Waters (MMC5/5): 45.8%** → MMC5 diverge de forma notoria; investigar (¿PRG-RAM de
    512 KB, o CHR de 128 KB, o split?).
- **4 juegos 0.3–92%** (ic 92.2%, metalstorm 14.2%, gradius 3.3%, smb 3.1%): el **límite de timing**
  `$2002`/NMI (ver [`RISKS.md`](RISKS.md), [`TIMING_ROADMAP.md`](TIMING_ROADMAP.md)). Con el baseline
  corregido, **galaga y pacman ya NO están aquí** (0.9% / 0.3%): el límite afecta al **estado de CPU**
  pero **no siempre** al frame renderizado a 60 frames.
- **Conclusión de método**: la validación diferencial mide lo que la **herramienta** puede ejecutar;
  `nes_frame` estaba **stale** y habría enmascarado bugs reales de los mappers nuevos (o inventado
  unos falsos). Toda cifra depende del binario correcto.


## Mappers soportados

| Mapper | Nombre | Estado |
|---:|---|---|
| 0 | NROM | completo |
| 1 | MMC1 | **completo** (PRG modes 2/3, CHR 4K/8K conmutada, WRAM + disable, 1-pantalla/V/H) |
| 2 | UxROM | completo |
| 3 | CNROM | completo |
| 4 | MMC3 | PRG/CHR por bancos, mirroring, IRQ por flanco de A12 (modelo por línea) |
| 5 | MMC5 | **subconjunto**: PRG (4 modos), CHR (4 modos), WRAM `$6000-$7FFF`, ExRAM `$5C00-$5FFF`, fill-mode, nametables por ExRAM, split vertical, IRQ por scanline, multiplicador. **Pendiente: audio de expansión y banco CHR del split** |
| 7 | AxROM | PRG de 32 KB conmutado, mirroring 1-pantalla |
| 24/26 | VRC6 | PRG/CHR por bancos, mirroring (`$B003`), IRQ por ciclos de CPU; variante VRC6b (26) |
| 69 | FME-7 | PRG/CHR por bancos, IRQ por ciclo, mirroring |
| — | CHR-RAM | soportado (patrones por `$2007`) |

Pendientes reales (2026, tras la matriz corregida):

- **VRC6b (26)**: **Esper Dream 2 (100%)** y **Mouryou Senki Madara (99.9%)** pintan mal → bug de la
  variante b (detección/mapping). Prioridad alta (frames totalmente distintos a `mesen`).
- **MMC5 (5)**: **Uncharted Waters 45.8%** divergencia notoria (¿PRG-RAM 512 KB / CHR 128 KB / split?).
  Gemfire, Laser Invasion y Nobunaga's ya están a 0.0–3.1%.
- **MMC5**: audio de expansión (`$5000-$5015`) y banco CHR del split (`$5202`).
- **Transpilador**: *banking* (sigue **NROM-only**).
- **Timing `$2002`**: ic 92.2%, metalstorm 14.2%, gradius 3.3%, smb 3.1% (ver
  [`TIMING_ROADMAP.md`](TIMING_ROADMAP.md)).

## Notas de método

- El **tracer de re-sync por PC** (`trace_diff.py`) fue clave: la comparación por índice se atasca
  en el bucle de VBlank (benigno) y **oculta** la divergencia real; re-sincronizando por PC se
  demuestra que los 6 "malos" comparten **una** raíz.
- El render usa la **CHR conmutada** del mapper (no la ROM lineal): sin esto, los juegos con bancos
  de CHR (smb3, megaman3, ninjagaiden…) daban geometría equivocada.
