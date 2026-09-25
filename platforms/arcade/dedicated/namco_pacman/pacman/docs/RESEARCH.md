# RESEARCH — Pac-Man (documentación primero)

Aplicación de la **Regla 0** ([`../../../../../../docs/RESEARCH_FIRST.md`](../../../../../../docs/RESEARCH_FIRST.md)):
recopilar el **ground truth** de la comunidad **antes** de instrumentar o desensamblar.

> **Estado**: borrador. Los datos marcados como «verificar» deben confirmarse contra las fuentes
> citadas (no se han reproducido aquí tablas numéricas completas para no introducir errores).

## Objetivo del vertical slice (P0)

Validar el pipeline completo con un juego **muy documentado**: si la IA/automatización **reproduce**
lo que la comunidad ya describió (y el motor diferencial no distingue), el pipeline funciona.

## Fuentes (ground truth)

| Tipo | Fuente | Uso |
|---|---|---|
| Mecánicas/IA (referencia) | **The Pac-Man Dossier** — Jamey Pittman | Modos de fantasmas, tablas de velocidad, timings, split-screen del nivel 256 |
| Desensamblado comentado | **Scott Lawrence / BleuLlama** (umlautllama.com; GitHub *GameDocs*) | Ms. Pac-Man: mapa de memoria, sonido, bugs |
| Guía | **Chris Lomont** — *Pac-Man Emulation Guide* | Hardware + notas de desensamblado |
| Bugs/comportamiento | Artículos de **Don Hodges** | *ghost bug*, split-screen |
| Hardware/mapa | **MAME** `src/mame/pacman/pacman.cpp` (BSD-3-Clause) | Mapa de memoria, I/O, bugs (base del `rom/layout.json`) |
| Historia Ms. Pac-Man | Comentarios del driver MAME (Steve Golson, GCC) | Origen (*Crazy Otto*), protección |

## Ground truth — hardware (confianza alta)

- **CPU** Z80 @ **3.072 MHz**; **sonido** Namco WSG (3 voces); **vídeo** 224×288 @ **60.606 Hz**.
- **Memoria** (ver [`../rom/layout.json`](../rom/layout.json), extraído del driver MAME):
  ROM `0x0000-0x3fff` (mirror `0x8000`), VRAM `0x4000-0x43ff`, Color RAM `0x4400-0x47ff`,
  work RAM `0x4c00-0x4fef`, sprite RAM `0x4ff0-0x4fff`, `spriteram2` `0x5060-0x506f`.
- **I/O**: IN0 `0x5000`, IN1 `0x5040`, DSW1 `0x5080`, DSW2 `0x50c0`; latch `0x5000-0x5007`
  (interrupt/sound enable, flip, start lamps, coin); watchdog `0x50c0`.
- **Interrupción**: VBlank (IRQ), vector fijado por el puerto I/O `$0`.
- **Laberinto**: rejilla **28×36 tiles** (8×8 px).

## Ground truth — mecánicas (confianza alta, verificar números en el Dossier)

- **Objetos**: Pac-Man; 4 fantasmas — **Blinky** (rojo, persigue directo), **Pinky** (rosa, apunta
  4 tiles por delante), **Inky** (cyan, vector desde Blinky), **Clyde** (naranja, persigue si está
  lejos y huye a su esquina si está cerca).
- **Modos**: **Scatter** ↔ **Chase** alternan con **tiempos por nivel**; tras un power pellet,
  **Frightened** (los fantasmas huyen y son comestibles). Esquinas de Scatter: Blinky arriba-dcha,
  Pinky arriba-izq, Inky abajo-dcha, Clyde abajo-izq.
- **Velocidades**: por nivel (base ~80 % Pac-Man / 75 % fantasmas); el **túnel** ralentiza a los
  fantasmas; **Cruise Elroy** (Blinky se acelera al bajar el nº de dots).
- **Puntuación**: dot 10, power pellet 50, fantasmas 200/400/800/1600, frutas por nivel.
- **Progresión**: fruta a los 70 y 170 dots (aprox.); reglas de salida de la casa de fantasmas por
  contadores (global y por nivel).
- **Bugs a reproducir** (si son visibles): animación hacia arriba 1 px abajo; RAM fuera de rango en
  el túnel derecho; **split-screen** del nivel 256.

## Lagunas (a cerrar con las fuentes / con evidencia propia)

- Tablas numéricas exactas (velocidades y tiempos de modo por nivel) → **verificar en el Dossier**.
- Reglas finas de salida de la casa de fantasmas (contadores).
- Algoritmo exacto del RNG (`0x2a23`) y su uso en Frightened.
- Layout/decodificación exacta de los ROMs de gráficos y PROMs de color del romset concreto.

## Cómo se usará

1. **Validación del pipeline**: la HIGS inferida debe **coincidir** con el Dossier (mecánicas/tiempos).
2. **Validación diferencial**: el `reimplementation/` SDL3 no debe distinguirse del emulador.
3. **Ground truth de bugs**: los visibles se modelan en la HIGS (no se copian del asm).

## Próximos pasos

1. Leer Dossier + desensamblado + driver y **anotar** aquí las tablas (sustituyendo «verificar»).
2. Preparar el **core instrumentado** (MAME year-stamped) y el `layout.json` verificado.
3. Extraer assets (tiles/sprites/paletas) y crear `spec/` (HIGS).
