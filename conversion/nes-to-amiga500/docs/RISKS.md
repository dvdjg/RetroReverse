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

**Método.** El orquestador (`vertical_slice --dump-ram`) vuelca la RAM de `mesen`; `frame_probe`
vuelca la nuestra. Comparando frame a frame se localiza la divergencia con precisión.

**SMB.** La RAM difiere de `mesen` desde el frame 4 y **se estabiliza en 8 bytes** a partir del
frame 14: `$0000`, `$0001`, `$0778` y 5 bytes de la base de la pila (`$01F8-$01FC`). El
acumulador de scroll `$07A7-$07AD` (rutina `SEC;ROR $07A7,X` de `$8131`) aparece desplazado un bit
en algunos frames. No es un offset de 1 frame (comparar con `mesen` `f+1` empeora). Consecuencia:
el logo del título ("SUPER"/recuadro) asienta ~2 filas más bajo que en `mesen` → el **3.1%** de
diff **estructural** restante ("MARIO BROS.", menú y suelo ya coinciden).

**Qué se probó (y se descartó).** (a) **sprite-0 dot-exacto** (`sprite0_line`/`sprite0_dot`, flag en
la columna del hit) — no cambió. (b) offset de 1 frame — no. (c) **pre-reloj del acceso a datos**
(`LDA $2002` ve el ciclo real) — no. (d) **intérprete dirigido por ciclo** (reloj de bus por acceso:
`NESMemory::cycle_tick`) — no cambió los 8 bytes ni el diff. (e) **longitud de frame**: teníamos 261
líneas; corregido a **262** (ciclos/frame pasaron de 29668 a **29782**, el real NTSC) — *sigue* sin
cambiar los 8 bytes ni los diffs. (f) SMB **no lee `$4015`** → no es el frame IRQ del APU. (g) Con
los headers previos, `dk`/`galaga` divergen igual → **no es regresión** de estos arreglos.

**Causa.** Todo el timing temporal (eventos de PPU dot-exactos, acceso por ciclo, longitud de frame)
está descartado. La divergencia es de **estado/CPU**: un contador de arranque (`$0001`, que mesen
incrementa cada frame) y unos bytes de pila. Candidatos restantes: una **nuance de un opcode** no
cubierta por nestest, o el **estado de power-up** (RAM/PPU/APU). No rompe el juego (llega al mismo
título) y **no bloquea el Amiga** (timing por hardware; ver [`TIMING_AMIGA.md`](TIMING_AMIGA.md)).

**Impacto en el codegen.** El mismo efecto aparece entre el **plugin** (bloques) y el **intérprete**
(instrucción a instrucción): al verificar los 13 `.n2x`, 5 coinciden (RAM 0/2048) y 8 difieren en
**2–13 bytes de RAM con el framebuffer idéntico** (0/61440 píxeles). Es decir, es una limitación de
*fidelidad de estado*, no de imagen; relevante para el Amiga porque usa el camino **codegen**.

## Impacto de los arreglos en la versión Amiga

Estos arreglos viven en el **oráculo/host** (PPU/APU software), no en el renderer Amiga (Copper/
Blitter/Paula). Su impacto en el port es indirecto pero real (y la estrategia para no pedir más
ciclos al 68000 está en [`TIMING_AMIGA.md`](TIMING_AMIGA.md)):

| Arreglo (host) | Impacto en el Amiga |
|---|---|
| `$2007` al espacio de **pattern** (`$0000-$1FFF`) se ignora (CHR-ROM) / se lee de CHR | El HLE/Copper que gestione la VRAM debe **descartar** esas escrituras; antes el oráculo daba un estado irreal y las trazas/savestates de partida eran incorrectos |
| **Espejo de paleta** `$3F10-$3F1C → $3F00-$3F0C` | El HLE que siga los cambios de paleta por Copper debe aplicar el mismo espejo; de lo contrario el fondo sale mal en títulos como SMB |
| **Sprite-0 por scanline + dot** | El `WAIT` del Copper (temporizador de raster) debe usar la misma línea/columna del hit; mejora los juegos que parten la pantalla con sprite-0 |
| **APU sweep + envolvente de noise** | La síntesis a Paula (1 canal por software) debe implementar sweep (incl. el `+1` del pulse1 y el muteo) y la envolvente del noise; el WAV del host es la referencia de validación |
| **Timing por frontera de bloque** (deriva) | Afecta al **codegen**, que es lo que corre en el Amiga: partidas con temporizadores dependientes del raster pueden desviarse unos bytes respecto al intérprete. Se mitiga con el mismo sincronismo fino (pendiente) |
| Nada de esto añade coste al Amiga | El PPU/APU del host no se ejecutan en el Amiga; el clock dot-exacto se optimizó a O(1) (sin coste de host) |

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
