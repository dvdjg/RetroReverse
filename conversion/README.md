# Conversión a plataformas destino

Tercer pilar del marco, tras **emulación/análisis** y **reimplementación** (HIGS + SDL3):
**automatizar la conversión de un juego a otra plataforma** (no necesariamente a PC).

Aquí vive todo lo que lee una ROM/binario de origen y genera **código + datos** ejecutables en la
máquina de destino, con fidelidad creciente y validación diferencial contra el original.

```
entrada (ROM/ejecutable) ──► conversor (host) ──► código+datos destino ──► runtime destino
         │                          │                       │                     │
         └──────── validación diferencial contra emulador de referencia ──────────┘
```

## Nodos

| Nodo | Origen | Destino | Estado | Ruta |
|---|---|---|---|---|
| **NES → Amiga 500** | NES (2A03/2C02) | Amiga 500 OCS/ECS | abierto | [`nes-to-amiga500/`](nes-to-amiga500/README.md) |

## Principios

1. **La ROM de origen es la especificación.** Todo lo que hace el juego (registros, VRAM, OAM,
   mappers, timings) se emula o se transpila; nada se "reinventa mirando una captura".
2. **HLE con fallback.** Se aceleran con el hardware del destino las intenciones reconocidas
   (scroll, tiles, sprites, bankswitch) y se cae a un camino interpretado cuando no se reconoce.
3. **Validación diferencial.** El resultado se compara frame a frame y muestra a muestra contra un
   emulador de referencia (p. ej. `mesen` para NES) y contra el destino real (WinUAE).
4. **Sin código ajeno.** Se portan **ideas y algoritmos**; el código es propio. Ver
   [`../docs/LEGAL.md`](../docs/LEGAL.md) y [ADR 0005](../docs/adr/0005-pilar-conversion-plataformas.md).
5. **Solo ROMs propias**, nunca versionadas. Ver [`../docs/ROM_SELECTION.md`](../docs/ROM_SELECTION.md).

## Relación con el resto del marco

- **Hardware de origen**: [`../platforms/consoles/nes/`](../platforms/consoles/nes/README.md)
  (spec, CPU 6502 validada con `nestest`, cobertura).
- **Herramientas de emulación** (referencia y validación): [`../tools/orchestrator/`](../tools/orchestrator/README.md)
  con el core `mesen`.
- **Destino**: hardware Amiga en
  [`../platforms/computers/amiga500/hardware_spec/`](../platforms/computers/amiga500/hardware_spec/README.md)
  y engine de juegos Amiga (repo hermano `Amiga-Cpp`, **no** se toca desde aquí).

Roadmap del marco: [`../docs/ROADMAP.md`](../docs/ROADMAP.md) §P4.
