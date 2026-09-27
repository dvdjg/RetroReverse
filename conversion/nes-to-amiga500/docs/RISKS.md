# Riesgos y limitaciones reales

Un **A500 stock** (68000 ~7 MHz, OCS, 512 KB Chip) es mucho más ajustado que los emuladores NES
Amiga existentes (A/NES, darkNESs), que piden 68020+ con FastRAM y a menudo AGA. Estas son las
limitaciones honestas y cómo se mitigan.

## Limitaciones del objetivo

| Limitación | Impacto | Mitigación |
|---|---|---|
| **CPU lenta** (7 MHz, sin FastRAM) | no hay margen para interpretar | transpilación estática + HLE + frameskip |
| **Chip RAM escasa** (512 KB) | no caben buffers generosos | DPF 3+3, buffers 272×256, cache de tiles ajustada (≈75 KB) |
| **Sin precisión ciclo a ciclo** | sprite 0 hit, IRQ de mapper, splits | Copper `WAIT` aproximado + fallback; no prometer exactitud total |
| **8 sprites HW** | más de 8/línea | multiplex + bobs (Blitter); la NES ya limita a 8/línea |
| **Paleta OCS** (12-bit, 32 colores) | fidelidad de color | DPF + cambios de paleta por Copper; AGA lo haría trivial |
| **Paula ≠ APU** | timbre | síntesis precisa por software + 1 canal; DMC opcional |

## Riesgos técnicos

| Riesgo | Mitigación |
|---|---|
| **Código automodificable** (común en NES) | detectar estáticamente lo posible; el resto, intérprete/fallback |
| **Saltos indirectos y `JMP ($xxyy)`** | despacho por tabla + fallback; análisis dinámico |
| **Bankswitching** rompe la traducción estática | bloques por banco + recompilación parcial/parches (F9) |
| **Flags 6502** (`V`, `B`) no mapean a `CCR` 68000 | flags explícitos en la clase `CPU`; el compilador los optimiza |
| **Timing PPU/APU** impreciso | contador de ciclos por bloque; ajustar en validación |
| **Chip RAM sin margen** | presupuestar y medir; liberar lo no usado; cachés LRU |
| **Dos caminos HLE/fallback** divergen | estado emulado único; tests diferenciales HLE vs fallback |
| **Deriva a "port mirando captura"** | prohibido: la fuente de verdad es la ROM y el estado emulado |

### Evidencia: deriva de timing y el residual de SMB (2026)

El sprite-0 y el NMI se toman en **frontera de instrucción** (no en el dot exacto), así que el
estado del juego puede divergir del de `mesen` en unos ciclos por frame. Medido en SMB a 60
frames: la RAM del juego difiere en 16 bytes ya desde el frame 10 (incluye `$0000` y la pila
`$01F8`), con el acumulador de scroll `$07A7-$07AD` desplazado un bit (la rutina `SEC;ROR $07A7,X`
de `$8131`). Consecuencia: el logo del título ("SUPER"/recuadro) asienta ~2 filas más bajo que en
`mesen`, lo que explica el 3.1% de diff **estructural** restante (el resto, "MARIO BROS.", menú,
suelo, ya coincide). **No es un bug del renderer**: es precisión de timing CPU/PPU (NMI y
sprite-0) y queda como límite conocido hasta que se aborde el sincronismo dot-exacto.

## Riesgos de proyecto

| Riesgo | Mitigación |
|---|---|
| Ámbito demasiado ambicioso | vertical slice primero (NROM, 1 juego); fases con criterio de cierre |
| ROMs no disponibles / legales | usar homebrew propio o ROM mínima de prueba; nunca versionar ROMs |
| Compatibilidad sobre-prometida | matriz de compatibilidad por juego y mapper, publicada |
| Dependencia del toolchain 68000 | compilar también en host para iterar rápido |

## No-objetivos (por ahora)

- Emulación cycle-accurate en A500.
- Soporte de decenas de mappers al inicio.
- Precisión de audio perfecta (DMC completo) desde el día 1.
- A500 acelerado / AGA como requisito (se aprovechará si está, pero no se asume).

## Criterio de "viable"

**Sí** para un subconjunto de juegos (NROM/UNROM/algunos MMC1) con frameskip y optimización
agresiva. **Difícil** compatibilidad alta y full speed sin acelerador. La ventaja del Amiga es que
Blitter y Copper son ideales para imitar tiles/sprites/scroll; el objetivo es **look fiel y
jugable**, no exactitud total.
