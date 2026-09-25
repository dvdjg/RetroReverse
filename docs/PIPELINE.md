# Pipeline

Flujo de trabajo por juego. El objetivo es pasar de una **ROM** a una **HIGS** completa y una
**reimplementación validada**. Todo el bucle es **reproducible** gracias a savestates + input.

## Fase 0 — Documentación primero (obligatoria)

**Antes** de instrumentar o desensamblar: búsqueda documental exhaustiva. Ver
[`RESEARCH_FIRST.md`](RESEARCH_FIRST.md). Se registra el **ground truth** (lo ya documentado) para:
- no reinventar la rueda,
- **validar** lo que infiera la IA (si coincide con la comunidad, el pipeline funciona),
- centrar el valor propio en la **automatización y generalización**.

## Fase 1 — Setup de hardware y mapa de memoria

1. Identificar plataforma/placa y localizar el **driver del emulador** (p. ej.
   `mame/src/mame/namco/pacman.cpp`) para conocer: CPU(s), bus de memoria, I/O, vídeo y sonido.
2. Escribir `rom/layout.json` (mapa de memoria, EPROMs, puertos I/O) y `rom/checksums.sha256`.
3. Preparar el **core instrumentado** correspondiente (ver [`EMULATORS.md`](EMULATORS.md)).

## Fase 2 — Instrumentación y trazas

Añadir al core (fork) los hooks necesarios:

- **log de ejecución**: rango/PC por instrucción (o por bloque, para no ahogar),
- **hooks de escritura**: VRAM, registros de hardware, paletas,
- **savestates deterministas** en memoria,
- **input recording/playback**,
- **captura de framebuffer** a intervalos fijos.

Base: [libRetroReversing](https://github.com/RetroReversing/libRetroReversing).

**Criterio de cierre**: dado un *(savestate, input)*, el emulador produce **exactamente** las mismas
trazas y frames en dos ejecuciones.

## Fase 3 — Análisis estático

1. Cargar la ROM en **Ghidra** con el mapa correcto (plugin de plataforma si existe).
2. Desensamblado rápido con **Capstone** para separar código/datos.
3. Anotar funciones usando los **puntos de entrada y rangos ejecutados** de las trazas.
4. Exportar `disassembly/{code_blocks.asm, control_flow_graph.json, symbols.map}`.

## Fase 4 — Bucle iterativo dirigido por IA

Repetir hasta cubrir el juego:

1. **Ejecutar un escenario controlado** (mover, colisionar, cambiar de nivel) vía input inyectado.
2. **Comparar estados** antes/después (diff de RAM/VRAM/registros) + diffs de pantalla.
3. **Inferir**: qué variable cambió con qué acción → coordenadas, velocidades, estados, colisiones.
4. **Hipótesis**: proponer regla/máquina de estados; **verificarla** reproduciendo el escenario.
5. **Exploración**: fuzzing guiado por cobertura o RL para descubrir ramas no vistas.
6. **Registrar** cada hallazgo en la HIGS con su evidencia *(savestate + input + frame)*.

**Criterio de cierre**: cobertura ejecutada de las rutinas de juego relevantes (game loop,
entidades, colisión, niveles, puntuación) con HIGS consistente.

## Fase 5 — Extracción de assets

- Gráficos: tiles/sprites/paletas/bitplanes → **PNG** + JSON de layouts/tablas.
- Audio: samples y sonidos de chip → **WAV**/JSON (frecuencias, envolventes, secuencias).
- Se referencian desde la HIGS (`assets refs`), no se embeben en el código.

## Fase 6 — Reimplementación (solo desde HIGS)

- **C++23 + SDL3**, sin conocer la plataforma original: consume **solo** `spec/` + `assets/`.
- Estructura en `entities/`, `logic/`, `render/`; tests en `tests/`.
- Temporizaciones: usar los **ticks fijos 50/60 Hz** de la HIGS (y ciclos para fidelidad interna).

## Fase 7 — Validación diferencial

- Ejecutar **emulador ↔ reimpl** con el **mismo input**.
- **Diff frame a frame** de framebuffer y audio; idealmente también de estado lógico expuesto.
- Reportar desviación con el **frame mínimo reproducible** (savestate + input).
- Iterar hasta **cero desviaciones** en los escenarios cubiertos.

## Ejemplo (Pac-Man)

1. **Fase 0**: leer *The Pac-Man Dossier*, el desensamblado de Scott Lawrence, la guía de Lomont
   y el driver MAME (ver [`RESEARCH_FIRST.md`](RESEARCH_FIRST.md)).
2. **Fase 1**: `pacman.cpp` → mapa Z80, VRAM/Color RAM/SPRITE RAM, Namco WSG.
3. **Fase 2**: MAME instrumentado (mame2003-plus/mame2010 son más ligeros).
4. **Fase 4**: inferir FSM de fantasmas (Scatter/Chase/Frightened), tablas de velocidad por nivel,
   túnel, split-screen del nivel 256 → HIGS.
5. **Fase 6/7**: reimpl SDL3 y validación diferencial.
   **Test de calidad**: el pipeline debe **reproducir** lo que el Dossier ya describe.

## Requisitos de determinismo

- Savestates **en memoria** y restauración en O(1).
- Input **frame-exacto** (no dependiente del wall-clock).
- Core **sin** no-determinismo (fuentes de aleatoriedad del juego emuladas con semilla fija).
- Toda observación se guarda con su contexto reproducible.

## Errores comunes a evitar

- Instrumentar demasiado (traza por instrucción de todo el juego) → usar **rangos y muestreo**.
- Reimplementar mirando el asm → **prohibido**: solo desde la HIGS.
- Confundir **ciclos** con **frames** → documentar ambos y la relación (7,09 MHz / 50–60 Hz).
- Depender de la plataforma en el runtime → rompe el objetivo *hardware-agnostic*.
