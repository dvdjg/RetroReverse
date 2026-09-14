# sos_cruncher — crunchers de SOS (notas)

- Origen: `out/ram/slowc00000.bin` (Slow RAM 0xC00000; sha1 en `SOURCE`).
- Ventana desensamblada: `0xC02380`–`0xC026E0` -> `sos-crunchers.asm`.

## Rutinas identificadas

| Símbolo | Dirección | Firma / prologue | Descripción |
|---|---|---|---|
| `imp_decrunch` | `0xC02426` | `movem.l d2-d5/a2-a4,-(sp); movea.l a0,a3; movea.l a0,a4; cmpi.l #'IMP!',(a0)+` | **Cruncher `IMP!`** (LZ+Huffman). Es el que se usa durante la carga de módulos. |
| `imp_decrunch_ret` | `0xC02476` | `movem.l (sp)+,d2-d5/a2-a4; tst.l d0; rts` | Retorno de `IMP!` (D0=0 ok, -1 error). |
| `crm_trampoline` | `0xC02584` | `movem.l d0-a6,-(sp); move.l (a0)+,d0; …cmpi.l #'CrM!'…` | Trampoline de `CrM!`/`CrM2`; salta al de-cruncher según firma. |
| `crm_decrunch1` | `0xC025B2` | `movea.l a1,a5; adda.l d1,a1; adda.l d2,a2; …` | De-cruncher `CrM!`. |
| `crm_decrunch2` | `0xC026AA` | — | De-cruncher `CrM2`. |

## Formato `IMP!` (parcial)

- Cabecera: `'IMP!'` (0x494D5021) + **dos longs big-endian** = probables tamaños
  (descomprimido / comprimido). Ejemplos en Chip RAM: `0x1690` -> `0x97C`/`0x1E0`,
  `0x1AA0` -> `0x6834`/`0x2C62`.
- El bucle descomprime **hacia abajo** (`move.b -(a3),-(a4)`), con tabla Huffman inicial de
  28 bytes copiada a pila (`lea -28(sp),sp`).
- **Pendiente**: determinar exactamente dónde escribe (destino) para volcar cada módulo. Plan:
  sondear RAM antes/después de una llamada y diferenciar.

## Formato `CrM!`/`CrM2` (parcial)

- Trampoline `0xC02584`: `move.l (a0)+,d0` compara con `'CrM!'`/`'CrM2'`; si coincide hace
  `tst.w (a0)+; move.l (a0)+,d1; move.l (a0)+,d2; movea.l a0,a2; jsr (a5)`.
- Contrato: al entrar, **`A1` = destino** (lo fija el llamador).
