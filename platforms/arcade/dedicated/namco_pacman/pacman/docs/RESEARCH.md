# RESEARCH — Pac-Man (documentación primero)

Aplicación de la **Regla 0** ([`../../../../../../docs/RESEARCH_FIRST.md`](../../../../../../docs/RESEARCH_FIRST.md)):
recopilar el **ground truth** de la comunidad **antes** de instrumentar o desensamblar.

> Estado: **cerrado** en lo esencial (mecánicas/timings de alto nivel). Quedan lagunas concretas
> (marcadas al final) que se cerrarán con el driver y con evidencia propia.

## Fuentes (ground truth)

| Tipo | Fuente | Uso |
|---|---|---|
| Mecánicas/IA/timings | **The Pac-Man Dossier** — Jamey Pittman (gamedeveloper.com, 2009) | Scatter/Chase/Frightened, velocidades, dots/frutas, reversión, cornering |
| Desensamblado comentado | **Scott Lawrence / BleuLlama** (umlautllama.com; GitHub *GameDocs*) | Ms. Pac-Man (mapa de memoria, sonido, bugs) |
| Guía | **Chris Lomont** — *Pac-Man Emulation Guide* | Hardware + desensamblado |
| Bugs | **Don Hodges** | *ghost bug*, split-screen |
| Hardware/mapa | **MAME** `src/mame/pacman/pacman.cpp` | Mapa de memoria e I/O (base de [`../rom/layout.json`](../rom/layout.json)) |

## Hardware (confianza alta)

CPU **Z80** @ 3.072 MHz · sonido **Namco WSG** (3 voces) · vídeo **224×288** @ **60.606 Hz**.
Mapa de memoria e I/O: [`../rom/layout.json`](../rom/layout.json).

## Mecánicas y puntuación (Dossier; confianza alta)

- **244 dots**: 240 pequeños (10 pts) + 4 **energizers** (50 pts) → **2.600 pts/tablero**.
- **Frutas**: aparecen bajo la casa a los **70** y **170** dots; valor **100–5.000** según nivel;
  duran ~9–10 s. (Tabla de frutas del Dossier; pendiente transcribirla.)
- **Comer un dot** detiene a Pac-Man **1 frame**; un **energizer**, **3 frames**.
- **Fantasmas comidos** en un mismo energizer: **200/400/800/1600**. A partir del **nivel 19** ya
  no se ponen azules (pero sí invierten).

## Modos y temporización (segundos)

```
Scatter  L1:7  L2-4:7  L5+:5
Chase          20      20       20
Scatter         7       7        5
Chase          20      20       20
Scatter         5       5        5
Chase    L1:20  L2-4:1033  L5+:1037
Scatter  L1:5   L2+:1/60
Chase    indefinido
```

- 4 fases de Scatter por nivel; luego **Chase indefinido**.
- El temporizador **se pausa** durante Frightened y se reinicia al perder vida o completar nivel.
- **Reversión forzada** al cambiar de modo: `chase→scatter`, `chase→frightened`,
  `scatter→chase`, `scatter→frightened`. **No** revierten `frightened→chase/scatter`.
  La inversión ocurre cuando el fantasma entra en el siguiente tile.

## Velocidades (por nivel)

| Nivel | Pac normal | Pac con dots | Pac frightened | Pac fright+dot | Fantasma normal | Fantasma frightened | Fantasma túnel |
|---|---|---|---|---|---|---|---|
| 1 | 80% | 71% | 90% | 79% | 75% | 50% | 40% |
| 2–4 | 90% | 79% | 95% | 83% | 85% | 55% | 45% |
| 5–20 | 100% | 87% | 100% | 87% | 95% | 60% | 50% |
| 21+ | 90% | 79% | — | — | 95% | — | 50% |

- En el **túnel lateral** la velocidad del fantasma cae ~a la mitad.
- **Cruise Elroy** (Blinky se acelera cuando quedan pocos dots): regla específica por nivel.

## Comportamiento Frightened

- Los fantasmas eligen dirección pseudoaleatoria con un **PRNG**; orden de intento si hay muro:
  dirección elegida → **up, left, down, right**.
- El **PRNG se reinicia** con la misma semilla al empezar **nivel** y **vida** → resultados
  **reproducibles** (clave para la validación determinista).
- La duración azul se acorta por nivel; el nº de parpadeos está en la Tabla A.1 del Dossier
  (pendiente transcribir).

## IA de persecución (resumen; detalles por verificar)

- **Blinky**: persigue directo a Pac-Man ("Shadow").
- **Pinky**: apunta **4 tiles** por delante de Pac-Man ("Speedy").
- **Inky**: vector desde Blinky → **2 tiles** por delante de Pac-Man ("Bashful").
- **Clyde**: persigue si está **lejos**; si está **cerca** (<8 tiles), huye a su esquina ("Pokey").
- **Esquinas de Scatter**: Blinky arriba-dcha, Pinky arriba-izq, Inky abajo-dcha, Clyde abajo-izq.

## Correcciones y bugs a reproducir

- Animación de Pac-Man **hacia arriba 1 px abajo**.
- Uso de RAM fuera de rango (`0x4800-0x4bff`) al traducir la posición en el **túnel derecho**.
- **Split-screen** del **nivel 256**.

## Lagunas (cerrar con el driver / evidencia propia)

1. Tabla A.1 completa (frightened s + flashes, valores de fruta y nº de nivel de cada fruta).
2. Reglas finas de salida de la casa (contadores de dots global/por-fantasma).
3. Algoritmo exacto del RNG (`0x2a23`) y su uso.
4. Detalles del split-screen y del "ghost bug".

## Uso

1. **Validación del pipeline**: la HIGS inferida debe **coincidir** con el Dossier.
2. **Validación diferencial**: la reimplantación SDL3 no debe distinguirse del emulador.
3. Los bugs visibles se **modelan** en la HIGS (no se copian del asm).
