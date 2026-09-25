# sos.library — análisis del runtime SOS (mod_2)

- **Origen**: `extraction/modules/mod_002_c05ef2_26676.bin`
- **SHA1**: `9068130f600b107388827be820d3a7b79fa3877d`
- **Base**: `0xC05EF2` (Slow RAM), **longitud**: 26676 B (0x6834)
- **Volcado**: hook `IMP!` (`extraction/specs/imp-dump.json`, bloque idx 2)
- **Desensamblado**: `mod_2_soslibrary.asm` (capstone, m68k, skipdata; 8160 insns)

## Variantes de sos.library (mod_0/2/4/6/8/10)

Los 6 bloques "sos.library" son **la misma librería recargada en destinos distintos**, no módulos
diferentes. Evidencia: los primeros 64 B son **byte-idénticos** (2 `jmp` + `"sos\0"` + arranque
Exec), y todos usan el mismo conjunto de vectores `jsr -$xx(a6)` (incluida la carga de `DBUG` vía
`-$138`). Confianza **alta**.

| bloque | dest | len | notas |
|---|---|---|---|
| mod_0 | 0xC5CBB2 | 114408 | versión más grande (runtime completo) |
| mod_2 | 0xC05EF2 | 26676 | la analizada aquí |
| mod_4 | 0xC70212 | 34956 | versión extendida |
| mod_6 | 0xC05EF2 | 1152 | fragmento/re-carga corta |
| mod_8 | 0xC706A2 | 33784 | — |
| mod_10 | 0xC05EF2 | 21100 | versión compacta |

Implicación: los bloques pares NO contienen las rutinas de efecto por separado; están dentro de
estas librerías o en los bloques de datos (1,3,5,7,9,11). sos.library solo toca el chipset en
`$DFF002` (VPOSR) y `$DFF09C` (reset inten) — es el **OS**, no el render.

## Confirmación: sos.library es un OS por vectores (mod_004)

- mod_004 (34956 B, 12220 insns) usa **0 llamadas `bsr`/`jsr` directas a subrutinas locales**:
  toda la lógica se invoca por vectores indirectos (`jsr (a6)`, `jsr (a5)`, `jsr (a0)`). Confianza
  **alta** (análisis de targets de salto).
- Mismos vectores que mod_2. **CORRECCIÓN (con `sos.includes`)**: los `jsr -$XX(a6)` son la
  **API de SOS**, no de Exec. Ver `rom/reference/sanity-os-v26/LVO_MAP.md`. En particular
  `-$138(a6)` = **OpenLibrary** (carga librería por nombre; `move.l #$44425547 ("DBUG")`), NO una
  "resolución de módulos por tag".
- Conclusión: los bloques de código son **variantes de sos.library** con un efecto embebido cada
  uno (ver `extraction/maps/effects.md`).

## Estructura

```
0xC05EF2  jmp $10.l          ; vector de arranque (Open de la librería)
0xC05EF8  jmp $9a.l          ; vector 2
0xC05EFE  "sos\0"            ; firma de librería SOS (también visto en mod_0/4/6/8/10)
0xC05F02  movea.l $4.w, a6   ; → ExecBase
          ...
```

## Vectores SOS usados (jsr -$XX(a6), A6 = base de sos.library)

Mapa completo en `rom/reference/sanity-os-v26/LVO_MAP.md`. Los más usados:

| Offset | Función SOS | Ejemplo |
|---|---|---|
| `-$180` | PutScreen | 0xC05F14 |
| `-$174` | OpenScreen | 0xC05F1C |
| `-$228` | Save | 0xC05F34 |
| `-$1E` | StartIt | 0xC05F46 |
| `-$19E` | — (CloseLibrary/compat) | 0xC05F50 |
| `-$84` | SetInt (IRQ+copper) | 0xC05F5E |
| `-$2A` | AllocMem | 0xC05FB2 |
| `-$54` | SetInt | 0xC06070 |
| `-$11A` | GetPISS | 0xC05FA0 |
| `-$138` | **OpenLibrary** (por nombre) | 0xC05FE2 |
| `-$72` | SetCopperAdr | 0xC046xx |
| `-$9C` | SetCopperCol | 0xC046xx |
| `-$A2` | Fade | — |

Base por registro: `jsr (a6)` (SOS), `jsr (a5)` (variables), `jsr (a0)` (job/replay).

## Corrección de interpretaciones previas

- `-$138(a6)` = **OpenLibrary** (no "resolución de módulos por tag"). El tag `"DBUG"`/`"SINE"` es
  el nombre de la librería a abrir (4 letras).
- `-$11A(a6)` = **GetPISS** (no "primitiva interna").
- `-$54(a6)` = **SetInt** (no FindTask); `-$72` = SetCopperAdr; `-$9C` = SetCopperCol.
- `-$228(a6)` = **Save** (no MakeLibrary); `-$180` = PutScreen; `-$174` = OpenScreen.
- `-$c(a4)` en contexto DBUG = **CheckDBUG**.

El nombre `DBUG` = `0x44425547` es una etiqueta ASCII de 4 letras (nombre de la librería a abrir
con OpenLibrary). Los demás nombres (`SINE`, `AGAC`, …) siguen el mismo patrón.

## Constantes de configuración de la demo (presentes en sos.library)

- `0x2900 → $25cc.l`, `0xa4 → $25c8.l`: variables globales del demo (Slow RAM baja).
- Modos/pantalla: `$26`, `$62`, `$114`, `$12c`, `0x9f00000`, `0x30a0000`, `0x10affd8`,
  `0x108ffd8`, `0x17700`, `0x23280`, `0xa200`, `0x17bc`, `0xfed8`.
  (`0x9f00000` ≈ bitplane base; `0x17700`/`0x23280` ≈ offsets de buffer/copia.)

## Observaciones para el port a C++

- La librería SOS carga sus librerías por **nombre de 4 letras** (OpenLibrary): al portar, basta
  con un mapa `nombre → módulo`.
- El arranque es una librería tipo Amiga, pero usa **la API propia de SOS** (no Exec). El
  equivalente host ignora Exec y construye el objeto directamente.
- `jsr (a5)` = llamadas con A5 = variables; `jsr (a0)` = job/replay (punteros resueltos).