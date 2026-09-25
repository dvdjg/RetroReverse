# ADR 0004 — Repositorio único (sin repo separado)

- **Estado**: aceptado
- **Fecha**: 2026

## Contexto

Se barajó crear un repo hermano `RetroReverse` para el marco y mantener `Amiga-Reverse` aparte.
Se prefiere **un único proyecto** donde los commits se acumulen juntos (no dos repos separados).

## Decisión

**Un solo repositorio** (el actual, hoy `Amiga-Reverse` en GitHub; renombrable a `RetroReverse`)
que contiene **marco + subproyecto Amiga**:

```
<raíz del repo>/
  README.md                      README del marco (RetroReverse)
  STRUCTURE.md · LECCIONES_APRENDIDAS.md · PORTING.md · AGENTS.md   (metodología)
  docs/                          documentación del marco (arquitectura, pipeline, HIGS, roadmap, adr)
  toolkit/ · _template/          herramientas y plantillas del marco
  sanity-arte/                   subproyecto Amiga (expediente «Arte»)
```

No se usa **subtree ni submódulo**: la reorganización hacia el layout de plataformas es
**interna** al repo (`git mv`), conservando la historia. Ver
[`../MIGRATION_AMIGA_REVERSE.md`](../MIGRATION_AMIGA_REVERSE.md).

## Consecuencias

- ✅ Un solo historial y un solo remote; los commits se acumulan juntos.
- ✅ La migración es `git mv` + reescritura de enlaces (sin fusionar historiales de repos distintos).
- ⚠️ El nombre del repo (`Amiga-Reverse`) ya no describe el conjunto → **renombrar a `RetroReverse`**
  (opcional, vía GitHub) para coherencia.

## Alternativas consideradas

- **Repo hermano + subtree / submódulo**: descartado por la preferencia de repo único.
- **Copia simple entre repos**: descartado (pierde historia y crea dos proyectos).
