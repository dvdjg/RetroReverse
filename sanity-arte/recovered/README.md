# recovered — material curado

Zona **curada** del expediente: solo lo revisado y decidido conservar. Frente a `out/`
(regenerable), aquí vive lo que sirve para reimplementar y para trazar el origen.

```
recovered/
  code/<unidad>/     .asm (objdump), .symbols, notes.md, SOURCE (ruta+sha1 del binario origen)
  media/             gfx/ (PNG/ILBM+paleta), audio/ (WAV/MOD), copper/, palettes/, reference/
  maps/              memory_map.md, modules.md, dispatch.md, symbols.json
```

Reglas:
- Toda unidad indica su origen en `SOURCE` (ruta + `sha1`) y el comando que la regenera.
- No duplicar binarios grandes de `out/`; referenciarlos por `sha1`.
- La media se conserva para comparación; **no se redistribuye** (derechos del autor original).

Índice:
- `code/bootblock` — bootblock SOS1.
- `code/sos_cruncher` — crunchers `IMP!` y `CrM!`/`CrM2`.
- `maps/memory_map.md`, `maps/modules.md`, `maps/symbols.json`.
