# Ghidra: decompilado vs. reimpl, y cross-check con rz-ghidra

Segunda fase de la evaluación de Ghidra (ver `GHIDRA_AMIGA_EVAL.md`). Aquí: (3) contraste del
**pseudo‑C decompilado** contra las reimplementaciones de efectos ya portados, (4) extracción de
**datos por xref** para alimentar los decoders, y (5) **rz-ghidra** como segundo decompilador.

Todo lo generado está en `out/ghidra/` (regenerable). Comandos en `tools/README.md` y
`toolkit/ghidra/README.md`.

---

## 3. Decompilado vs. reimpl

### 3.1 Motor 3D (`blk_0B0C2C`, base 0) — coincide

`out/ghidra/blk_0B0C2C_l1_63064.decomp.c`:

| Función | Offset | Reimpl | Veredicto |
|---|---|---|---|
| construcción de matriz de rotación | `0xC16` | `build_rotation()` (`reimpl/motor_3d/src/transform3d.cpp`) | **idéntico** |
| transformación de punto (×3) | `0xCBA` | `transform()` | **idéntico** |
| proyección (producto punto por fila) | `0xDAC`/`0xDE4` | — (implícito en `transform`) | consistente |
| matriz ortonormal por cross‑product | `0xE1E` (+ `0xF1C`) | **no portado** | hallazgo |

La matriz se construye desde dos tablas Q15 (`0x1056` y `0x1256`, 256 words cada una, indexadas
por `ángulo & 0x7fe`) y cada elemento usa el patrón Q15 `(suma*2)>>16`. Mapeo decompilado ↔ reimpl
(sea `s5,s6,s7` = senos y `c5,c6,c7` = cosenos de los 3 ejes, en `transform3d.cpp` `sa..cc`):

```
m[0] = Q15(c6*c7)              m[1] = Q15(s5*Q15(s6*c7) + s7*c5)
m[2] = Q15(s7*s5 - c5*Q15(s6*c7))   m[3] = Q15(-c6*s7)
m[4] = Q15(c5*c7 - s5*Q15(s6*s7))   m[5] = Q15(c5*Q15(s6*s7) + s7*s5)
m[6] = s6                      m[7] = Q15(-c6*s5)     m[8] = Q15(c5*c6)
```

Coincide término a término con `build_rotation()` (p. ej. decompilado
`in_A0[8] = Q15(sVar3*sVar4)` ↔ reimpl `M.m[8] = q15_mul(cb, ca)`). **Confianza alta.**

> **Hallazgo**: `0xE1E` (matriz ortonormal por cross‑product + normalización `(x*32767)/|v|`)
> **no está en `reimpl/motor_3d`**. Es la técnica del *camera system* que evita el *drift* de la
> matriz; merece portarse (ver `TECNICAS.md` → «Construcción de matriz ortonormal»).

### 3.2 Zoom (`blk_07E42C`, base 0) — confirma el doc y añade detalle

`out/ghidra/blk_07E42C_l1_20268.decomp.c`:

- `FUN_0000024c` (`0x24C`): `$2d0 += 6` hasta `$b5`; `$2ce = Q16(tabla[$3ee2+$2d2+$2d0] * 0xdc)
  + 0x11d`; 4 iteraciones de `FUN_0000193e`. **Coincide** con
  `recovered/code/ALGORITMOS_ZOOM_Y_TUNEL.md` §1 (rutina `$24C`).
- `FUN_000002d4` (`0x2D4`): trayectoria con tablas `$3944` (×0x190), `$38aa` (×0x384),
  `$3a78` (×0x12c) y sesgos; índice `$238 += 2`, reset a `-1` en `0x9a`. **Coincide** con §1.
- **Detalle nuevo (no documentado)**: `FUN_000002d4` **parchea una Copperlist** por bandas
  (`*(u16*)(base+0x12) = 0x200 / 0x5200` con stride 20 B): cambia `BPLCON0` (nº de planos) por
  línea para el recorte vertical del zoom. La reimpl debería reflejarlo.

La reimpl del zoom sigue **pendiente** (`ALGORITMOS…` §1: «reimpl pendiente»); el decompilado da
la base directa para portarlo.

### 3.3 Túnel / corridor (`blk_03AFFC`) — sin código

`out/ghidra/blk_03AFFC_l1_102852.decomp.c` → **0 funciones**. Confirma lo ya sabido: el bloque
`0x03AFFC` es **datos** (Copperlist + paleta `@0x146` + datos), no el render del corridor.
La reimpl (`reimpl/tunnel/`) reproduce la geometría del **remake público** (`artsy`), no código
recuperado. **Conclusión**: no se puede validar el render del original por decompilado porque la
rutina **no está localizada**. Confianza alta en el negativo (0 funciones).

> **Lead concreto**: usar `XrefsTo.java` (paso 4) sobre la base del buffer del corridor
> (`0x26614`) en un `.uss` con el efecto cargado, para localizar la rutina que lo lee/escribe.

---

## 4. Extracción de datos por xref (para los decoders)

`toolkit/ghidra/XrefsTo.java <out.txt> <hexAddr> [hexLen]` lista las referencias a una dirección y
(opcional) vuelca los bytes para alimentar `planar_decode`/`copper_decode`/`bin_scan`.

Ejemplo real — tabla de senos de `blk_0B0C2C`:

```
XrefsTo.java out/b0c2c.sinetable.refs.txt 0x1056 0x200
  from 00000c20 [DATA]   from 00000c26 [DATA]
  from 00000c2a [DATA]   from 00000c2e [DATA]
  -> dumped 0x200 bytes -> out/b0c2c.sinetable.refs.txt.bin
```

Las 4 referencias caen dentro de `FUN_00000c16` (construcción de matriz) y el volcado son 256
words Q15 (`0, 201, 402, 603, …`, compatible con un **cuarto de seno**). Confianza alta.

---

## 5. rz-ghidra como segundo decompilador (cross-check)

**Resultado**: **funciona** y su salida coincide con la de Ghidra. Se construyó en **WSL/Ubuntu**
desde fuente (ver `toolkit/ghidra/wsl/build-rzghidra.sh`), porque en Windows nativo no es viable
(sin binarios precompilados; el Rizin precompilado no trae `RizinConfig.cmake`).

Mismo input (`blk_0B0C2C`, base 0, m68k BE), `pdg @ 0xcba` →
`out/ghidra/blk_0B0C2C.rzghidra.pdg.c`:

```c
// Ghidra
*unaff_A2 = (int16_t)((uint32_t)(((int32_t)*in_A1 * (int32_t)iVar1 + ... ) * 2) >> 0x10);
// rz-ghidra  (idéntico salvo el cast/uint16_t)
*unaff_A2 = (int16_t)((uint32_t)(((int32_t)*in_A1 * (int32_t)iVar1 + ... ) * 2) >> 0x10);
```

Salida **equivalente** en `0xC16`, `0xCBA` y `0xE1E` (mismos `iVarN`, mismas tablas `0x1056`/
`0x1256`, misma semántica Q15). Único aviso: `Matching calling convention m68k … failed`
(esperado; no hay ABI m68k en Rizin). Confianza alta.

**Valor**: doble verificación barata **una vez montado** (el montaje no es barato: compilar Rizin
+ el decompilador de Ghidra en C++). Se recomienda como comprobación puntual, no como flujo diario.

---

## Resumen de decisiones

| Pregunta | Resultado |
|---|---|
| ¿El decompilado valida la reimpl? | Sí, motor 3D byte‑semántico; zoom confirma doc + añade copper por bandas |
| ¿Aporta técnicas no portadas? | Sí: matriz ortonormal `0xE1E` (camera system) |
| ¿Sirve para sacar datos? | Sí, por xref (`XrefsTo` → `out/*.bin`) → decoders |
| ¿rz-ghidra como 2º decompilador? | Sí, pero requiere build en WSL/Linux; salida equivalente a Ghidra |
| ¿Puede validar el túnel original? | No: el bloque es datos; falta localizar la rutina de render |
