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

**Aviso de licencia (material de terceros)**:
- Lo que hay aquí de terceros — binarios del sistema SOS (`SOS_*`, `*.soslibrary`), gráficos y
  paletas decodificados, textos (scrolltext), capturas — **NO** está cubierto por la GPLv3 del
  repositorio. Los derechos son de sus autores (p. ej. Dierk Ohlerich / Chaos of Sanity, Moby, Ra).
- Se conserva **solo como referencia de estudio** para la ingeniería inversa (uso educacional).
- El contenido **propio** (análisis, `notes.md`, mapas, `.asm` de análisis, reimpl) sí es GPLv3.
- **Coherencia**: en un repositorio **público** este material queda redistribuido. Si no es la
  intención, excluirlo del control de versiones (p. ej. añadir a `.gitignore`) y conservar solo el
  análisis. Ver `../../LECCIONES_APRENDIDAS.md` §8.

Índice:
- `code/bootblock` — bootblock SOS1.
- `code/sos_cruncher` — crunchers `IMP!` y `CrM!`/`CrM2`.
- `maps/memory_map.md`, `maps/modules.md`, `maps/symbols.json`.
