# Copperlist recuperada — estado y advertencia

`arte-title-copper.txt` / `.bin` y `../palettes/arte-title-palette.json` provienen de la **primera**
captura de `dump-display.mjs`, cuando la lectura de `COP1LC` devolvió `0x26614` y el contenido era
una Copperlist *coherente* (`DIWSTRT=$5981`, `BPLCON0=$5600` = 5 planos, `COLOR00..`).

**No verificado**: en capturas posteriores `COP1LC` volvió a apuntar a `0x26614` pero con contenido
de código (los registros custom en vivo son inconsistentes; ver
`../../docs/HALLAZGOS.md` y `../../../../LECCIONES_APRENDIDAS.md`). Considerar estos ficheros como
**muestra candidata a validar**, no como verdad canónica.

La referencia visual fiable es `../reference/arte-title-screenshot.png` (captura de pantalla del
emulador).
