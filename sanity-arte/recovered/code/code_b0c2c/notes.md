# Motor 3D de «Arte» — módulo 0x0B0C2C

- **Origen**: `out/modules_all/blk_0B0C2C_63064.bin` (descomprimido del ADF 0x0B0C2C,
  track 64, l1=63064). SHA1 `b37f140c32...`.
- **Desensamblado**: `code_b0c2c/code_b0c2c.asm`.
- **Técnica**: ver `docs/TECNICAS.md` → "Motor 3D ... transformación de puntos con matriz Q15".
- **Confianza**: alta (rutinas de transformación, construcción de matriz y fade desensambladas).

## Contenido

| Offset | Qué es | Confianza |
|---|---|---|
| `0x0C46-0x0CB8` | construcción de matriz de rotación 3×3 (Q15) | alta |
| `0x0CBA-0x0D58` | transformación de punto (x,y,z → x',y',z') ×3 | alta |
| `0x0E1E-0x0E86` | matriz ortonormal por cross-product (camera system) | alta |
| `0x0E88+` | proyección/uso de la matriz | media |
| `0x31C-0x3E2` | **fade de paleta por nibbles** (B,G,R por separado) | alta |
| `0x34C6-0x5342` | otra rutina con muchos swap (7804 B) | media (sin analizar) |
| `0x2DC-0x31A` | bucle principal con sincronía VBL (`$dff004` vs `$12900/$13000`) | media |

## Notas

- Es el motor de las **estrellas 3D** / vectorización que el autor menciona en el scrolltext
  ("die am meisten optimierte routine").
- Aritmética Q15 fija: `mul.w` → `add.l d,d` → `swap` = producto de punto fijo de 16 bits.
- Los `muls.w` con d0-d5 indican uso intensivo de senos/cosenos (tabla `SINE.soslibrary`).
- El bloque es una de las "variantes de sos.library" (empieza con los jmp + "sos") pero su cuerpo
  es el motor 3D + fade + render — a diferencia de mod_002 (OS puro).