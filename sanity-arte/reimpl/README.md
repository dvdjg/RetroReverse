# reimpl — recreación en C++ (Sanity-Arte)

Destino final: reescribir como **algoritmo propio** cada técnica recuperada. Reglas generales en
[`../../_template/reimpl/README.md`](../../_template/reimpl/README.md).

| Técnica | Origen (módulo/rutina) | Estado |
|---|---|---|
| `sine_table` — seno precalculado Q1.14 | `SINE.soslibrary` (idea) | PORTADO (test host OK) |
| `motor_3d` — transformación 3D Q15 (matriz rotación + punto) | bloque 0x0B0C2C (0x0C16-0x0D58) | PORTADO (test host OK) + **asm canónico preservado** |
| (pendiente) scrolltext / blobs / distorsión / zoom | 0x02162C / 0x0B0C2C / 0x096A28 / 0x07E42C | PENDIENTE |

Cuando se recuperen las técnicas (scroll, senos, blitter, copper), cada una tendrá aquí su
carpeta con `README.md` (mapeo desde el código recuperado) y `src/` (host o Amiga).

**Criterio del usuario**: las **rutinas optimizadas** del ensamblador (p. ej. la aritmética Q15
del motor 3D) se conservan como **versión canónica** en `reference/*.asm` y se usan en la
reconstrucción (inline asm / traducción literal) donde el rendimiento es crítico; la versión C++
es la referencia funcional.
