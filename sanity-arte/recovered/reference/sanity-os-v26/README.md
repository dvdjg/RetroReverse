# SOS 2.6 — documentación oficial del autor (referencia externa)

Material de referencia descargado de **Aminet** (`dev/asm/SanityOperationSystem.lha`), publicado
por **Dierk Ohlerich (Chaos/Sanity)** en 1994. Es la **documentación oficial de SOS**, el sistema
operativo para demos que usa «Arte». Sirve para validar y entender la ingeniería inversa del
expediente.

## Qué confirma (cruce con el análisis propio)

| Documento del autor | Hallazgo propio (ingeniería inversa) | Confianza |
|---|---|---|
| SOS usa librerías externas `DBUG.soslibrary`, `SINE.soslibrary`, `TEXT.soslibrary`, `AGAC.soslibrary` | El directorio SOS de Arte lista exactamente esos nombres | alta |
| "A version of **Imploder** that I ripped out of beermon" (SEGCRUNCH) | El formato `IMP!` del disco es **File Imploder** (confirmado con `ancient`) | alta |
| "SLOADHYB main" para probar Arte | El archivo `main` del directorio SOS (bloque 0x078A2C) es el loader principal | media-alta |
| `OpenLib()` carga librerías | La primitiva `-$138(a6)` con tag ("DBUG") resuelve módulos | alta |
| SOS mata Kickstart, memoria en stack (`AllocMem`/`FreeMem`/`SetInt`/`SetDefault`/`ClrDefault`/`AltMemory`) | sos.library usa vectores Exec pero gestiona su propia memoria; los bloques son variantes de la misma lib | media-alta |
| "effect handler with a built in interpreter language" que lee un archivo `script` | Los `.scr` del paquete SOS son scripts de efectos (demo Yesterday) | media |

## Archivos

- `sos.maindoc` — documentación principal (este resumen viene de aquí).
- `sos.autodoc` — autodocs de las funciones SOS (103 KB).
- `sos.includes` — includes de ensamblador.
- `SOS_RUN` / `SOS_HYB` / `SOS_RAM2MB` / `SOS_RAM3MB` — variaciones del sistema.
- `DBUG.soslibrary` / `SINE.soslibrary` / `TEXT.soslibrary` / `AGAC.soslibrary` — librerías
  compiladas (para comparar con las de Arte).

## Fuente

`http://aminet.net/dev/asm/SanityOperationSystem.lha` (v2.6, 1994). Licencia: ver `sos.copyright`
(incluido en el .lha original; no copiado aquí).