# Roadmap — <Título>

Estados: `HECHO` · `EN CURSO` · `PENDIENTE` · `BLOQUEADO`. Cada fase con **criterio de cierre**.

## Fase 0 — Extracción de la imagen — PENDIENTE
- Extraer `.dms`->`.adf` (o validar `.adf`) y verificar integridad.
- **Cierre**: ADF generado y verificado (CRC/checksum).

## Fase 1 — Formato y loader — PENDIENTE
- ¿AmigaDOS o trackloader propio? Firma del bootblock, root block.
- **Cierre**: formato identificado y documentado en `HALLAZGOS.md`.

## Fase 2 — Arranque y volcado de RAM — PENDIENTE
- Lanzar WinUAE-DBG con la config correcta y volcar RAM + screenshot.
- **Cierre**: volcados en `extraction/ram/` con 0 fallos + captura.

## Fase 3 — Módulos descomprimidos — PENDIENTE
- Identificar y enganchar el decruncher; volcar bloques.
- **Cierre**: `extraction/modules/` con los módulos sin comprimir.

## Fase 4 — Bucle y rutinas de efecto — PENDIENTE
- Localizar dispatch de efectos y bucle por frame.
- **Cierre**: mapa rutina <-> efecto en `extraction/maps/dispatch.md`.

## Fase 5 — Assets — PENDIENTE
- Capturar custom registers + Copperlist; decodificar bitmaps/samples.
- **Cierre**: media en `recovered/media/`.

## Fase 6 — Algoritmos y port — PENDIENTE
- Desensamblar rutinas y reescribir técnicas en `reimpl/`.
- **Cierre**: cada efecto con receta en `TECNICAS.md` y código en `reimpl/`.
