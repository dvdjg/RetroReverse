# PORTING — del código recuperado al engine Amiga

Objetivo: que cada técnica recuperada quede **clara y usable**: **qué hace** (funcionamiento),
una **versión C/C++ de referencia** y, para las rutinas críticas, el **ASM canónico** listo para
usar directamente en el engine. Este documento define el **contrato** que debe cumplir cada
técnica y cómo se integra en el engine Amiga.

Objetivo final (confirmado): reconstruir la demo desde fuente propia en el engine, usando el ASM
solo donde el 68000 marca la diferencia. Ver [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md)
y [`STRUCTURE.md`](STRUCTURE.md).

---

## 1. El «contrato de técnica» (5 piezas)

Cada `reimpl/<tecnica>/` debe contener:

| # | Pieza | Fichero | Para qué |
|---|---|---|---|
| 1 | **Funcionamiento** | `README.md` | Qué hace, algoritmo, y mapeo desde el código recuperado (direcciones, registros, tablas) |
| 2 | **Referencia C/C++** | `src/<tecnica>.hpp` + `.cpp` | Especificación **ejecutable** y portable; compila en **host** |
| 3 | **ASM canónico** | `reference/<rutina>_amiga.asm` | Desensamblado comentado de la rutina optimizada (versión canónica a usar) |
| 4 | **Contrato de llamada** | sección «Contrato» en `README.md` | Entradas/salidas, registros, **convención de punto fijo (Q15/Q16)**, registros que preserva, alineación, coste |
| 5 | **Validación + trazabilidad** | `src/test_*.cpp` + `SOURCE` | Test host (y cruzado con emulador si toca hardware); origen con `sha1` y comando |

Regla: **el C/C++ es la referencia; el ASM es la implementación crítica**. Ambos deben dar el
**mismo resultado** (se valida cruzando host ↔ emulador).

## 2. C/C++ vs ASM: cuándo usar cada uno

- **C/C++ de referencia** — siempre. Es la descripción precisa y testeable; sirve de fallback
  para CPUs/plataformas donde el ASM no aplique, y de oráculo para validar el ASM.
- **ASM canónico** — para las rutinas que lo justifican:
  - bucles por píxel/línea (blobs, zoom, c2p, scroll),
  - aritmética fija masiva (Q15/Q16: motor 3D, trayectorias),
  - sincronía y hardware (copper, blitter, VBlank, doble buffer).
- **Criterio**: medir. Si el C compilado se queda corto en ciclos dentro del presupuesto del
  frame (A500 7 MHz, ~35.000 ciclos/línea, 50 Hz), se usa el ASM. Documentar el coste.

## 3. Integración en el engine Amiga

- **Toolchain**: `m68k-amiga-elf-g++` (bundle de `vscode-amiga-debug`, gcc 14.2) o **vbcc**. Los
  tests de referencia compilan en **host** (`g++`, o WSL) para iterar rápido.
- **Enlace del ASM** (dos vías, elegir por técnica):
  - `.s` con **vasm/vasm-elf** + `extern "C"` (recomendado para rutinas completas),
  - **inline asm** de GCC (para fragmentos pequeños y críticos).
- **Convención de llamada (propuesta, fijar por técnica)**:
  - Entradas en **registros** según contrato (p. ej. `a0`=origen, `a1`=matriz/tabla, `a2`=destino).
  - `d0`,`d1`,`a0`,`a1` = *scratch*; **preservar** `d2–d7` y `a2–a6` (ABI Amiga) si el llamador lo asume.
  - Retorno en `d0` (o por registro indicado).
  - Pila alineada; no tocar `sp` salvo `link/unlk` documentado.
- **Punto fijo**: documentar la escala por rutina. En «Arte»:
  - **Q15** = `muls.w a,b ; add.l d,d ; swap` → `(a*b) >> 15` (motor 3D, matrices).
  - **Q16** = `muls.w #C,d ; swap` → `(v*C) >> 16` (zoom, escalas, trayectorias).
- **Hardware**: registros custom por dirección absoluta (`$DFFxxx`); copper/blitter en la capa de
  vídeo del engine (no dentro de las rutinas de cálculo).

## 4. Checklist «técnica cerrada»

- [ ] `README.md`: funcionamiento + algoritmo + mapeo desde el código recuperado.
- [ ] C/C++ de referencia en `src/` + **test host OK**.
- [ ] **ASM canónico** preservado en `reference/` (si la rutina es crítica).
- [ ] **Contrato**: registros, Q15/Q16, preservación, alineación.
- [ ] **Validación cruzada** (host y/o emulador) documentada.
- [ ] **Coste** estimado (ciclos/frame) para justificar C vs ASM.
- [ ] Enlazada desde `docs/TECNICAS.md` y `reimpl/README.md`.
- [ ] `SOURCE` con `sha1` + comando que regenera.

## 5. Estado actual (expediente «Arte»)

| Técnica | C/C++ ref | ASM canónico | Contrato | Test host | Falta |
|---|---|---|---|---|---|
| `sine_table` | sí | — | parcial | sí | asm (opcional), contrato |
| `motor_3d` | sí | sí (transform) | sí | sí | asm de **ortonormalización** (extraído) |
| `blob_render` | sí | sí | sí | sí | coste |
| `sine_wobble` | sí | sí | sí | sí | — |
| `scrolltext` | sí | sí | sí | sí | — |
| `palette_fade` | sí | sí | sí | sí | — |
| `sphere` | sí | — (assets+técnica) | parcial | sí | asm/contrato |
| `tunnel` | sí (remake) | — | parcial | sí | **render del original** (no localizado) |
| `zoom` | sí (núcleo) | — | parcial | sí | **blit/copper** + asm canónico |

## 6. Plantilla de carpeta

```
reimpl/<tecnica>/
  README.md                  funcionamiento + mapeo + CONTRATO (registros, Q, coste)
  Makefile                   `make test` (host)
  SOURCE                     origen (ruta + sha1) + comando que lo regenera
  src/<tecnica>.hpp/.cpp     referencia C/C++
  src/test_<tecnica>.cpp     test host (+ cruzado con emulador si aplica)
  reference/<rutina>_amiga.asm   ASM canónico (rutina optimizada)
```

## 7. Referencias

- Estructura y reglas: [`STRUCTURE.md`](STRUCTURE.md).
- Método y trampas: [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md).
- Técnica a técnica + receta: `sanity-arte/docs/TECNICAS.md`.
- Estado de efectos: `sanity-arte/docs/ROADMAP.md`.
- Plantilla de título: [`docs/templates/expediente/reimpl/README.md`](docs/templates/expediente/reimpl/README.md).
