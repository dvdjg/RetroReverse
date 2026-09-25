# specs — specs de enganche <Título>

Una spec JSON por rutina a enganchar (ver el contrato en `../../tools/README.md`).
Copiar de un expediente existente (p. ej. `../../platforms/computers/amiga500/demos/arte/extraction/specs/sanity-arte.json`) y adaptar
`patternHex`, offsets y registros.

Campos: `patternHex`, `parseOffset`, `retOffset`, `destReg`, `lenReg`, `metaReg`,
`searchStart`, `searchSize`, `maxSeconds`, `chunk`, `allowed`.
