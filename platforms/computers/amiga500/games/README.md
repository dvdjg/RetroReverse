# Amiga 500 — juegos (`games/`)

Nodos de **juegos Amiga** (aún sin abrir). Aquí se revisa la **selección de ROMs propias** ya
recibida en `roms/amiga/` y se eligen candidatos para los primeros expedientes.

> Contenido de ROMs **no versionado** (`roms/`, ver [`roms/README.md`](../../../../roms/README.md));
> esta revisión es propia y sí se versiona.

## Selección actual (`docs/ROM_SELECTION.md`)

| Título | Discos | Notas |
|---|---|---|
| Wizball | 1 | 1987, Sensible Software; mecánica original (bola + gatito) |
| Buggy Boy | 1 | 1987, racing pseudo-3D (mismo arcade de la selección) |
| Pac-Mania | 1 | 1988, isométrico (mismo arcade en la selección) |
| Bubble Bobble | 1 | 1987, single-screen (simple de portar) |
| Jim Power in Mutant Planet | Disk1/2 | 1992, acción/plataformas, parallax |
| James Pond - Underwater Agent | 1 | 1990, puzzle/acción |
| James Pond 2 - Codename RoboCod | 1 | 1991, plataformas (muy pulido) |
| James Pond 3 - Operation Starfish (AGA) | Disk1/2/3 | 1993, AGA |
| Mega Typhoon | 1 | 1996, shoot'em'up (Nordlicht PD) |
| Xenon 2 - Megablast | Disk1/2 | 1989, shoot'em'up (Bitmap Brothers) |
| Black Tiger | 1 | 1987/88, acción (mismo arcade `blktiger` en la selección) |

- **Kickstarts** copiados junto a los ADF (`roms/amiga/`): 1.3, 2.0, 3.1 (para `puae`/libretro-uae).
- Varios son **multi-disco** (ADF por disco) → los nodos deberán contemplar cambio de disco.

## Criterios para elegir el primer nodo

1. **Sencillez técnico-artística** (single-screen o scroll simple): Wizball, Bubble Bobble, Buggy Boy.
2. **Documentación de comunidad** disponible: Wizball (Sensible), Xenon 2 (Bitmap Brothers).
3. **Reutilización de arte** ya analizado en «Arte» (bitplanes, copper, sprites): encaja bien
   con **Xenon 2** (parallax + sprites) o **Buggy Boy** (scroll por bandas).

**Recomendado como primer nodo Amiga**: **Xenon 2 - Megablast** (shoot'em'up clásico, bitplanes +
sprites + música; técnicas reutilizables) o **Wizball** (mecánica simple y original).

## Cómo abrir un nodo

Copiar [`docs/templates/expediente/`](../../../../docs/templates/expediente/) a
`platforms/computers/amiga500/games/<game_id>/` y seguir
[`STRUCTURE.md`](../../../../STRUCTURE.md). Emulación: core **`puae`** (libretro) ya compilado;
para instrumentación fina, el stack **WinUAE-DBG + GDB + canal lateral** de
[`../tools/`](../tools/README.md).

## Referencias

- Desensamblados/análisis Amiga (Populous, Driller, guía tetracorp): [`docs/REFERENCES.md`](../../../../docs/REFERENCES.md) §Amiga.
