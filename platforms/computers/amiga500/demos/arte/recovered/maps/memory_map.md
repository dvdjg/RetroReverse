# Mapa de memoria — Sanity-Arte (A500, KS1.3, 512K chip + 512K slow)

Direcciones confirmadas por `out/ram/*` y `bin_scan.py`. Las que faltan por confirmar se marcan.

| Rango | Banco | Contenido observado |
|---|---|---|
| `0x000000`–`0x07FFFF` | Chip RAM (512K) | librería `sos.library` (string en `0x1AF9`), bloques `IMP!` en `0x1690` y `0x1AA0`, gráficos/paletas, texto cifrado/mezclado |
| `0x080000`–`0x0FFFFF` | sin mapear (mirror) | volcado de relleno |
| `0xC00000`–`0xC7FFFF` | Slow RAM (512K) | kernel SOS y módulos del demo |
| `0xDFF000`–`0xDFF1FF` | Custom chips | registros de hardware (no volcados aún) |

## Slow RAM — desglose

| Dirección | Contenido |
|---|---|
| `0xC00000`–`0xC01FFF` | zona de trabajo / pila del sistema |
| `0xC022BC`/`0xC02430` | (falsos `IMP!` dentro del código) |
| `0xC02380`–`0xC026E0` | **crunchers** `IMP!` (`0xC02426`), `CrM!` (`0xC025B2`), `CrM2` (`0xC026AA`) |
| `0xC02B55`+ | strings del kernel SOS (`SOS V2.4 Release 11`, errores, `incasm:SINE.soslibrary`) |
| `0xC037xx` | tabla de nombres de módulos (`SINE.soslibrary`, `mod.*`, `drwho96.raw`, …) |
| `0xC0385A`+ | `SOSchaos1/2/3`, `lSOSloadmodule` |
| `0xC5D000`–`0xC61FFF`+ | alta entropía (~7.5): música/samples o gráficos comprimidos |

## A determinar

- Ubicación de los módulos ya descomprimidos (tras el volcado de `IMP!`).
- Punteros de bitplanes y Copperlist en el frame del título (capturar custom registers).
