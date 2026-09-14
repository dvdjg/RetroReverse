# sos.library — análisis del runtime SOS (mod_2)

- **Origen**: `out/modules/mod_002_c05ef2_26676.bin`
- **SHA1**: `9068130f600b107388827be820d3a7b79fa3877d`
- **Base**: `0xC05EF2` (Slow RAM), **longitud**: 26676 B (0x6834)
- **Volcado**: hook `IMP!` (`specs/imp-dump.json`, bloque idx 2)
- **Desensamblado**: `mod_2_soslibrary.asm` (capstone, m68k, skipdata; 8160 insns)

## Estructura

```
0xC05EF2  jmp $10.l          ; vector de arranque (Open de la librería)
0xC05EF8  jmp $9a.l          ; vector 2
0xC05EFE  "sos\0"            ; firma de librería SOS (también visto en mod_0/4/6/8/10)
0xC05F02  movea.l $4.w, a6   ; → ExecBase
          ...
```

## Vectores Exec usados (jsr -$xx(a6), A6 = ExecBase)

| Offset | Función | Frec. | Ejemplo |
|---|---|---|---|
| `-$180` | AllocMem | 1 | 0xC05F14 |
| `-$174` | FreeMem | 1 | 0xC05F1C |
| `-$228` | MakeLibrary | 1 | 0xC05F34 |
| `-$1E` | OpenLibrary | 1 | 0xC05F46 |
| `-$19E` | CloseLibrary | 1 | 0xC05F50 |
| `-$84` | Forbid | 1 | 0xC05F5E |
| `-$17A` | Permit | 1 | 0xC05F64 |
| `-$BA` | FindLibrary | 1 | 0xC05F90 |
| `-$2A` | AllocVec | 6 | 0xC05FB2 |
| `-$54` | FindTask | 1 | 0xC06070 |

Base por registro: `jsr (a6)` x20, `jsr (a5)` x5, `jsr (a0)` x3, `jsr (a4)` x1.

## Primitivas internas (offsets negativos no-Exec)

- `-$138(a6)` (1 uso, 0xC05FE2): resuelve/carga un módulo SOS por **tag de 32 bits** en D0.
  P. ej. `move.l #$44425547 ("DBUG"), d0; jsr -$138(a6)` abre `DBUG.soslibrary`.
- `-$11A(a6)` (3 usos, ej 0xC05FA0): primitiva interna (probablemente alloc/init de estructura de librería).
- `-$72(a6)` (1 uso, 0xC06ECE): primitiva interna.

El tag `DBUG` = `0x44425547` es la única etiqueta ASCII cargada como inmediato en todo el bloque;
los módulos se referencian por **tag de 32 bits** (4 primeros chars del nombre en mayúsculas).

## Constantes de configuración de la demo (presentes en sos.library)

- `0x2900 → $25cc.l`, `0xa4 → $25c8.l`: variables globales del demo (Slow RAM baja).
- Modos/pantalla: `$26`, `$62`, `$114`, `$12c`, `0x9f00000`, `0x30a0000`, `0x10affd8`,
  `0x108ffd8`, `0x17700`, `0x23280`, `0xa200`, `0x17bc`, `0xfed8`.
  (`0x9f00000` ≈ bitplane base; `0x17700`/`0x23280` ≈ offsets de buffer/copia.)

## Observaciones para el port a C++

- La librería SOS gestiona módulos por **tags de 32 bits**, no por strings: al portar, basta
  con un mapa `tag → módulo`.
- El arranque es una librería clásica Amiga (MakeLibrary + dependencias vía OpenLibrary /
  FindLibrary de `sos.library`). El equivalente host puede ignorar Exec y sustituirlo por
  construcción directa del objeto.
- `jsr (a5)` x5 sugiere un **segundo puntero de base** (quizá la librería SOS abierta en A5),
  y `jsr (a0)` son jump-through de vectores ya resueltos.