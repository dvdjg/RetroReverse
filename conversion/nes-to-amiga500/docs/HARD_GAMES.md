# Juegos "difíciles" (para el backend Mega Drive) — inventario

ROMs traídas de `F:\roms\nes` a `roms/nes/dificiles/` (contenido **no versionado**; ver `.gitignore`),
para probar el futuro backend **Mega Drive** y, de paso, los límites del **oráculo**. Se listan los
mappers y el estado actual en nuestro emulador (que hoy soporta NROM/UxROM/CNROM/MMC1 básico).

## MMC3 (IRQ por scanline, CHR banking fino) — mapper 4

| Juego | mapper | PRG/CHR | oráculo |
|---|---:|---|---|
| Super Mario Bros. 3 (USA) (Rev A) | 4 | 256K/128K | no soportado |
| Kirby's Adventure (USA) (Rev A) | 4 | 512K/256K | no soportado |
| Mega Man 3/4/5/6 | 4 | 256-512K | no soportado |
| Crystalis (USA) | 4 | 256K/128K | no soportado |
| Adventure Island 3 (USA) | 4 | 128K/128K | no soportado |
| Tiny Toon Adventures (USA) | 4 | 128K/128K | no soportado |
| Batman: Return of the Joker (USA) | **69** (FME-7) | 128K/256K | no soportado |
| Metal Storm (USA) | 4 | 128K/256K | no soportado |
| Shatterhand (USA) | 4 | 128K/128K | no soportado |
| Ninja Gaiden II/III | 4 | 128K/128K | no soportado |
| Super C (USA) | 4 | 128K/128K | no soportado |

## MMC5 (multiplicador, RAM extra, modos gráficos) — mapper 5

Castlevania III (USA), Uncharted Waters (USA), Laser Invasion (USA), Gemfire (USA), Nobunaga's
Ambition II (USA) → **no soportado**.

## VRC6/VRC7 (Konami; sonido extra + CHR granular + IRQ) — mapper 24/26

Akumajou Densetsu (JP, VRC6=24), Esper Dream 2 (JP, 26), Mouryou Senki Madara (JP, 26) →
**no soportado**.

## AxROM (CHR-RAM, 1 pantalla) — mapper 7

Battletoads (USA) → **no soportado** (256K PRG, **0K CHR = CHR-RAM**).

## Sunsoft FME-7 — mapper 69

Mr. Gimmick (Europe) → **no soportado**.

## PPU dependiente del ciclo

Battletoads (7), Jurassic Park (4), Metal Storm (4), Shatterhand (4), Mr. Gimmick (69) → requieren
timing de PPU fino (que el emulador del oráculo ya aproxima) y mappers no soportados.

## Bugs de PPU/temporizado (necesitan los mappers, pero también precisión)

Contra (2), Super C (4), Ninja Gaiden II/III (4), Batman (4) → streaming de CHR.

---

## Conclusión para el backend Mega Drive

La MD **no tiene** IRQ por scanline programable (el MMC3 la usa), **no permite cambiar tiles durante
el render** (la NES sí), y su VRAM es rígida para streaming de CHR. Por eso los MMC3/MMC5/VRC hacen
falta efectos que la MD no puede replicar sin reescribir el motor. La estrategia de este proyecto
(transpilar + HLE + Copper) encaja mucho mejor en **Amiga** (Copper = co-procesador de vídeo) que en
MD; en MD harían falta técnicas distintas (más Blitter, tilemaps precalculados).

## Nota: usarlos en el oráculo PC

Antes de portar nada, conviene que el **oráculo** los ejecute para tener referencia. Hoy eso exige
más mappers en `runtime/include/nes_mapper.hpp`: **MMC3 (4)** es el siguiente (reutiliza el IRQ de
CPU que ya existe); después MMC5/7/69. Varios de estos juegos ya renderizan si el mapper lo permite.
