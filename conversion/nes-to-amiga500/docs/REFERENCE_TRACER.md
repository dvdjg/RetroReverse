# Tracer de referencia (oráculo vs fceumm)

Herramienta para localizar la **primera divergencia** entre nuestro oráculo y un emulador de
referencia, instrucción a instrucción. Es lo que permite cerrar bugs de mapper/timing **con
certeza** en vez de a ciegas.

## Procedimiento

1. **Nuestra traza**: `frame_probe --trace <rom.nes> <frames>` → `frame_probe.cpu`
   (8 B/instrucción: `PClo, PChi, op, A, X, Y, P, SP`).
2. **Referencia (fceumm)**: se le añade una traza a su CPU (`external/libretro-fceumm/src/x6502.c`,
   tras `b1 = RdMem(_PC)`, usando **`pbackus`** — NO `X.PC`, que va una instrucción desfasado) que
   escribe `PClo, PChi, op, A, X, S` a `$FCEUMM_TRACE`:
   ```bash
   scripts/build-libretro-core.sh libretro-fceumm
   FCEUMM_TRACE=/tmp/ref.bin tools/orchestrator/vertical_slice \
       --core external/libretro-fceumm/fceumm_libretro.so --rom <rom.nes> \
       --out /tmp/x --frames 60 --interval 0
   ```
3. **Comparar**: `python3 runtime/test/trace_diff.py frame_probe.cpu ref.bin` → imprime la
   **primera divergencia** (PC/opcode) y el contexto.

> Nota: `external/` está en `.gitignore`, así que el parche a fceumm no se versiona: hay que
> reaplicarlo (2 líneas + incluir un bloque de traza).

## Resultado — bioniccommando (2026)

Coincidimos **7831 instrucciones** y la primera divergencia está en la **espera de VBlank** del
reset:

```
C010: LDA $2002     ; lee estado PPU
C013: BPL $C010     ; espera a que bit7 (VBlank) = 0
C015: LDA $2002
C018: BMI $C015     ; espera a que bit7 (VBlank) = 1
```

- `idx 7830`: nuestro `A=$80` (**VBlank puesto**), fceumm `A=$00` (claro).
- Es decir, **nuestro flag de VBlank (`$2002` bit7) aparece antes** que en la referencia → el juego
  sale de la espera en otra iteración → la fase PPU del código siguiente difiere → cascada →
  desbordamiento de pila (`RTS` con `SP=FF` → `$0001`) → `jam`.

**Conclusión**: la causa raíz de la divergencia (bioniccommando, y por familia SMB/IC/MMC1) es el
**timing del flag VBlank** relativo a los ciclos de CPU. El arreglo es afinar la posición exacta
(scanline/dot) y el consumo de ciclos para que coincida con la referencia.

## Correcciones aplicadas (medidas con `trace_diff`)

| Cambio | Fundamento (fceumm) | Divergencia |
|---|---|---|
| (estado inicial) | — | idx 7830 |
| **Warm-up** `warmup_frames=2` | `ppudead=2` (2 frames sin VBlank) | idx 17055 |
| **Frontera de frame** en scanline 240 (pre-VBlank) | `FCEUPPU_Loop` pone el flag al inicio | idx **69405** |

Es decir, pasamos de coincidir ~0.5 frame a **~8 frames** con la referencia. **Los ciclos de CPU
coinciden EXACTOS** (verificado en la traza): el problema era de **fase del PPU**, no de ciclos.

**Desfase residual**: en idx 69405 fceumm toma el **NMI** (`PC=C058`) ~1–6 ciclos antes que nosotros
(el NMI en fceumm se dispara en `FCEUPPU_Loop` tras `X6502_Run(12)`). Ajustar el instante del NMI
(dot-accurate) es el paso que falta para cerrar el frame completo.

## Referencia actual: **mesen** (cycle-accurate), no fceumm

`trace_diff.py` leía 6/8 B por instrucción cuando las herramientas escriben **10/12 B**: todas las
divergencias anteriores eran **ruido desalineado**. Corregido. Ahora se usa **mesen** (cycle-accurate,
core recompilado con traza de PC en `Core/CPU.cpp`, 10 B: `PC/op/A/X/S/ciclos`) en vez de fceumm
(cuyo `X6502_Run` **redondea a frontera de instrucción** en cada segmento → su frame es más largo y
sus conclusiones de timing inducen a error).

### Hallazgos en fuente (mesen)

- `PPU.cpp:1257`: el flag de VBlank se pone en **`(_scanline==241 && _cycle==1)`**;
  `PPU.cpp:281`: las lecturas de `$2002` en `(241, ciclo<3)` devuelven **bit7=0**.
- `CPU.cpp:150`: la CPU tarda **8 ciclos** tras el reset antes de ejecutar la primera instrucción
  (fceumm **no** los modela → desfase constante de −8 ciclos en la comparación).
- `PPU.cpp:102`: la PPU de mesen arranca en **`_scanline = -1`** (pre-render), no en 0.

### Correcciones aplicadas

| Cambio | Fundamento (mesen) | Efecto |
|---|---|---|
| `trace_diff.py` formatos 12/10 B + ciclos | — | la divergencia pasa a ser real |
| `warmup_frames` 2 → 0 | mesen no suprime VBlank en el frame 0 | bioniccommando deja de colgarse en el reset |
| **+8 ciclos de reset** | `CPU.cpp:150` | offset de ciclos vs mesen −8 → **−1** |
| máscara `$2002` en `(241,<3 dots)` | `PPU.cpp:281` | quirk correcto de hardware |

Los bucles `LDA $2002/BPL` de **IC, SMB y bioniccommando** divergen todos en el mismo punto y por la
misma causa (el instante del VBlank). Residuo actual: **±1 ciclo** (fase de muestreo sub-instrucción).

### Bloqueante conocido: frontera del frame 0

`run_frame` fuerza `ppu.scanline = 240` al empezar **cada** frame → el **primer VBlank se adelanta
~27 000 ciclos** (la PPU arranca en la línea 0 y se salta las 0-239). Dejar que el frame 0 corra desde
la línea 0 (**sin forzar**) alinea los tres juegos miles de instrucciones más (IC: idx 42 → 9132;
SMB: 36 → 7828), **pero rompe la equivalencia intérprete↔ejecutor-rápido**.

Divergencia exacta (`dbg_fast2 bf.nes`): **step 16346**, `cyc_i=57209` vs `cyc_f=57197` (**el rápido
12 ciclos por detrás**), en `scan=241` (NMI). Primer byte distinto: **`$0019`** (interp 0x59 vs fast
0x58). Causa: `FastCpu::run_block` corta el bloque con `total + 7 > budget` (peor caso de 7 ciclos)
y **cruza la frontera de VBlank del frame 0** de forma distinta al intérprete. Es un bug del ejecutor
por bloques que sólo se manifiesta cuando el frame 0 **no** es un frame limpio de 262 líneas.

**Arreglo propuesto**: que `run_block` reciba el presupuesto hasta la frontera del frame (no sólo de
scanline) y/o que use los ciclos reales de la siguiente instrucción en vez del peor caso de 7.

## Estado

- Herramienta corregida (formatos) y referencia cambiada a **mesen**.
- Aplicadas las 4 correcciones de la tabla; `RUNTIME OK`, `equivalencia OK`, `port_matrix --gate` GREEN.
- Pendiente: **frontera del frame 0 + ejecutor por bloques** (arriba) → caerán IC/SMB/bioniccommando
  de golpe; y cerrar el **±1 ciclo** del `LDA $2002`.

## Notas de entorno

- Construir con el **g++ de WSL** para los tests (`run.sh`); los binarios host de Windows de
  `bench_engine`/`dbg_fast2` **desbordan la pila** al ejecutarse (0xC00000FD) por un problema del
  build local, no del código — usar el flujo WSL.
