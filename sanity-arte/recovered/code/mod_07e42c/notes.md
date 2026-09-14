# Zoom / render de imagen — módulo 0x07E42C

- **Origen**: `out/modules_all/blk_07E42C_20268.bin` (descomprimido del ADF 0x07E42C,
  track 45, l1=20268). SHA1 `a1f62fba...`.
- **Desensamblado**: `zoom_render_0x1300-0x1700.asm` (zona del render).
- **Técnica**: ver `docs/TECNICAS.md` → "Zoom / render de imagen a 4 planos".
- **Confianza**: media-alta (rutina desensamblada; interpretación de zoom inferida).

## Por qué es candidato a zoom/distorsión

- 107 `jmp` (dispatch grande), 122 `dbra`, 104 `bset.b` (dibujo de píxeles), 51 `muls.w`.
- Rutina 0x146A: render de imagen a **4 planos** con estructura de fila (110 words), tablas de
  4 planos en `$414a` (separados 0x370), actualización de punteros BPL con `swap`+`addi #$1c0`.
- El scrolltext menciona "zooming-pictures" → este bloque es el candidato.

## Pendiente

- Confirmar si 0x146A es zoom (escala) o solo copia; buscar la rutina de escalado (con muls).
- Localizar las otras rutinas de distorsión (wobble/lente) en el mismo bloque o en `main`.