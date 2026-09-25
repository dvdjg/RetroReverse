# RESEARCH — Pac-Man (documentación primero)

Aplicación de la **Regla 0** ([`../../../../../../docs/RESEARCH_FIRST.md`](../../../../../../docs/RESEARCH_FIRST.md)):
recopilar el **ground truth** de la comunidad **antes** de instrumentar o desensamblar.

> Estado: **cerrado** en mecánicas/IA/timings de alto nivel. Quedan lagunas concretas al final.

## Fuentes (ground truth)

| Tipo | Fuente | Uso |
|---|---|---|
| Mecánicas/IA/timings | **The Pac-Man Dossier** — Jamey Pittman (gamedeveloper.com, 2009) | Modos, targeting, velocidades, dot/frutas, casa, reversión, cornering, split-screen |
| Desensamblado comentado | **Scott Lawrence / BleuLlama** (umlautllama.com; GitHub *GameDocs*) | Ms. Pac-Man |
| Guía | **Chris Lomont** — *Pac-Man Emulation Guide* | Hardware + desensamblado |
| Bugs | **Don Hodges** | *ghost bug*, split-screen |
| Hardware/mapa | **MAME** `src/mame/pacman/pacman.cpp` | Memoria e I/O → [`../rom/layout.json`](../rom/layout.json) |

## Hardware (confianza alta)

Z80 @ 3.072 MHz · Namco WSG (3 voces) · 224×288 @ 60.606 Hz. Mapa: [`../rom/layout.json`](../rom/layout.json).

## Puntuación y dots (Dossier)

- **244 dots**: 240 (10 pts) + 4 energizers (50) → **2.600 pts/tablero**.
- **Frutas** a los **70** y **170** dots; valor **100–5.000** según nivel; duran 9–10 s.
- Comer un dot detiene a Pac-Man **1 frame**; energizer, **3 frames**.
- Fantasmas comidos en un energizer: **200/400/800/1600**.
- Desde el **nivel 19**, los fantasmas ya no se ponen azules (pero sí invierten).

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

- El temporizador **se pausa** en Frightened y se reinicia al perder vida o completar nivel.
- **Reversión forzada** en `chase→scatter`, `chase→frightened`, `scatter→chase`,
  `scatter→frightened`. **No** en `frightened→chase/scatter`. Ocurre al entrar en el siguiente tile.

## Velocidades (por nivel)

| Nivel | Pac norm | Pac +dot | Pac fright | Pac fright+dot | Fant normal | Fant fright | Fant túnel |
|---|---|---|---|---|---|---|---|
| 1 | 80% | 71% | 90% | 79% | 75% | 50% | 40% |
| 2–4 | 90% | 79% | 95% | 83% | 85% | 55% | 45% |
| 5–20 | 100% | 87% | 100% | 87% | 95% | 60% | 50% |
| 21+ | 90% | 79% | — | — | 95% | — | 50% |

- **Cruise Elroy** (Blinky): se acelera al quedar pocos dots (L1: **20** dots → Elroy 1; **10** →
  Elroy 2). En Elroy, su target de scatter pasa a ser **el tile de Pac-Man**. Configuración por
  nivel en Tabla A.1.

## Orientación al objetivo (pathfinding)

En cada intersección, el fantasma mira **un tile** en cada dirección legal, calcula la **distancia
euclídea** del "test tile" al **target tile** y elige la menor. Desempate por orden:
**arriba, izquierda, abajo, derecha**. Sin reversión salvo cambio de modo.

- **Scatter targets**: fijos "fuera de pantalla" — Blinky arriba-dcha, Pinky arriba-izq,
  Inky abajo-dcha, Clyde abajo-izq (el fantasma "orbita" su esquina).
- **Blinky (Shadow)**: target = **tile de Pac-Man**.
- **Pinky (Speedy)**: target = **4 tiles** por delante en la dirección de Pac-Man; **bug**: si va
  hacia **arriba**, el target es **4 arriba y 4 a la izquierda**.
- **Inky (Bashful)**: intermedio = **2 tiles** por delante (con el mismo **bug** al ir arriba:
  2 arriba y 2 a la izquierda); target = **tile de Blinky reflejado** a través del intermedio
  (se dobla el vector Blinky→intermedio).
- **Clyde (Pokey)**: si está a **>8 tiles** de Pac-Man → target = tile de Pac-Man; si está a
  **<8 tiles**, vuelve a su target de **scatter** (su esquina).

## Frightened

- Dirección pseudoaleatoria con **PRNG**; si hay muro, prueba en orden elegida → **up, left, down,
  right**. El **PRNG se reinicia** con la misma semilla al empezar **nivel** y **vida** → resultados
  **reproducibles** (clave para la validación determinista).
- Duración azul y nº de parpadeos por nivel: **Tabla A.1** del Dossier (pendiente transcribir).

## Casa de fantasmas (dot counters)

- Cada fantasma tiene un **dot counter** y un **dot limit** por nivel; solo **uno activo** a la vez
  (preferencia: **Pinky → Inky → Clyde**).
- **Nivel 1**: Pinky limit **0** (sale ya), Inky **30**, Clyde **60**. **Nivel 3+**: todos **0**.
- **Al perder una vida**: se usa un **global dot counter** (reset a 0). **Pinky sale a 7**,
  **Inky a 17**, **Clyde a 32**; se desactiva si Clyde está fuera al llegar a 32 (sino sigue).
- **Timer**: si Pac-Man no come dots, el fantasma preferido sale al llegar el límite —
  **4 s** (nivel 1–4), **3 s** (nivel 5+).
- **Dirección de salida**: izquierda por defecto; **derecha** si el modo cambió mientras dentro.

## Reversión / cornering

- **Cornering** (Pac-Man): puede girar varios píxeles antes/después del centro del tile
  ("pre-turn"/"post-turn"); durante el giro avanza en diagonal y gana distancia.

## Bugs a reproducir

- Animación hacia **arriba 1 px abajo**; RAM fuera de rango en el **túnel derecho**
  (`0x4800-0x4bff`); **bug** del offset de Pinky/Inky al ir hacia arriba.
- **Split-screen (nivel 256)**: al sobrepasar la tabla del símbolo de bonus, se leen posiciones de
  memoria fuera de rango y la **mitad derecha** se llena de basura ("kill screen"). La única forma
  de pasarlo es el "rack test" de algunas ROMs.

## Lagunas (cerrar con el driver / evidencia propia)

1. **Tabla A.1** completa: frutas por nivel (símbolo/valor), frightened (s + flashes), y dot
   counts/velocidades de **Elroy 1/2**.
2. Algoritmo exacto del **RNG** (`0x2a23`): dirección base y orden.
3. Detalles finos del **split-screen** y del "ghost bug".

## Uso

1. **Validación del pipeline**: la HIGS inferida debe **coincidir** con el Dossier.
2. **Validación diferencial**: la reimplantación SDL3 no debe distinguirse del emulador.
3. Los bugs visibles se **modelan** en la HIGS (no se copian del asm).
