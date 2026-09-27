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

## Estado

- La herramienta funciona y localiza la divergencia en segundos.
- Pendiente: cerrar el timing del VBlank con esta referencia y re-validar con `port_matrix --gate`.
