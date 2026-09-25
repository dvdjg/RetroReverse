# Efecto SINE / distorsión — módulo 0x096A28

- **Origen**: `extraction/modules_all/blk_096A28_3260.bin` (descomprimido del ADF 0x096A28,
  track 54, l1=3260). SHA1 `bd6c26d88a...`.
- **Desensamblado**: `effect_sine_0x150-0x950.asm`.
- **Técnica**: ver `docs/TECNICAS.md` → "Efecto de distorsión/ondas con SINE".
- **Confianza**: alta (init, construcción de tabla y bucle por frame desensamblados).

## Resumen

- Carga la librería **SINE** (tag `"SINE"` = 0x53494E45).
- **8 osciladores de fase** en `$38(a5)` (8 words), cada uno con su velocidad (+10,+4,+0x48,
  +0x52,+6,+9,+5,+4).
- Construye una **tabla de offsets de distorsión** (0x0400) combinando dos patrones con
  `or.l` + `lsl.l #$4`.
- Parchea la **copperlist** por frame (0x0702): 42 filas × 11 registros con máscara AND $FE →
  distorsión por scanlines.
- Es el efecto tipo **ripple/wobble** de la demo (ondas que deforman la imagen).

## Subrutinas

| Addr | Función |
|---|---|
| 0x03D0 | init buffer (patrón $04040404) + parámetros |
| 0x0400 | construcción de tabla de distorsión (128 KB) |
| 0x0702 | parcheo de copperlist (42×11 valores) |
| 0x0766 | bucle por frame (8 osciladores + copperlist) |
| 0x0830 | helper: índice cíclico en tabla |
| 0x0848 | subrutina de dibujo |