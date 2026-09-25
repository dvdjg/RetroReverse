# Regla 0 — Documentación primero

**Obligatorio**: antes de instrumentar, desensamblar o reimplementar cualquier juego, hacer una
**búsqueda documental exhaustiva**. La comunidad suele haber analizado los clásicos hasta el último
detalle (incluidos los *bugs* de los desarrolladores). Empezar de cero es reinventar la rueda.

## Por qué

- **Eficiencia**: muchísimo trabajo ya hecho (desensamblados comentados, IA de NPCs, mapas de
  memoria, timings).
- **Ground truth**: sirve para **validar** lo que infiera la IA. Si el pipeline reproduce lo ya
  documentado, funciona; donde no, hay un fallo que corregir.
- **Foco**: el valor propio no es redescubrir (p. ej.) la IA de Pinky, sino **automatizar** la
  extracción para **cualquier** ROM y generar HIGS + reimpl validada.

## Qué buscar (checklist por juego)

1. **Mecánicas e IA de alto nivel** — dossiers, wikis, análisis de comportamiento.
2. **Desensamblados comentados** — repos/webs con el asm documentado (instrucción a instrucción).
3. **Hardware y mapas de memoria** — driver del emulador + docs de la época.
4. **Bugs y comportamientos específicos** — artículos que explican rarezas (y que la reimpl debe
   reproducir si son visibles).
5. **Assets y formatos** — cómo se decodifican gráficos/sonido del sistema.
6. **Herramientas existentes** — extractores, editores, visores específicos de la plataforma.

## Cómo registrar el ground truth

- Un `docs/RESEARCH.md` en el nodo del juego con: fuentes, qué está **100 % clarificado** y qué
  **lagunas** quedan.
- Enlazar cada hallazgo de la HIGS con la fuente que lo confirma (o la evidencia propia si no hay
  fuente).
- Marcar **confianza** y **contradicciones** (si la IA difiere de la fuente, investigar cuál falla).

## Ejemplo: Pac-Man / Ms. Pac-Man

| Tipo | Recurso |
|---|---|
| Mecánicas/IA (referencia) | **The Pac-Man Dossier** (Jamey Pittman): fantasmas (Blinky/Pinky/Inky/Clyde), Scatter/Chase/Frightened, tablas de velocidad, timings, split-screen del nivel 256 |
| Desensamblado comentado | **Scott Lawrence / BleuLlama** (umlautllama.com; GitHub *GameDocs*): Ms. Pac-Man, mapas de memoria, sonido |
| Guía | **Chris Lomont**, *Pac-Man Emulation Guide* (hardware + notas de desensamblado) |
| Hardware/driver | **MAME** `src/mame/namco/pacman.cpp` (y relacionados): bugs concretos (túnel derecho, offset de animación) |
| Bugs/comportamiento | Artículos de **Don Hodges** (ghost bug, split-screen), comentarios de MAME |

**Uso**: el pipeline debe **reproducir** casi automáticamente lo que el Dossier y los desensamblados
describen. Ese es el **test de calidad** del sistema.

## Anti-patrón

- Saltar a Ghidra/instrumentar antes de leer lo que ya existe.
- Reimplementar copiando el desensamblado en vez de la **spec** (rompe el objetivo *hardware-agnostic*).
- Dar por buena una inferencia de la IA sin contrastarla con la documentación o con evidencia
  reproducible.
