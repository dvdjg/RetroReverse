# Amiga-Reverse

Expedientes de **ingeniería inversa de software Amiga 68k** (demos, juegos, módulos). El objetivo
no es copiar el original, sino **recuperar las técnicas** (sobre todo las **gráficas**),
**comprender el ensamblador 68k**, **inferir el C++ equivalente** y **reconstruir la pieza desde
fuente** en un engine propio. Las rutinas optimizadas del ensamblador (p. ej. la aritmética Q15 con
`muls.w`/`swap` del motor 3D) son la **referencia canónica** que se porta.

> **Aviso legal**: repositorio **privado** de estudio personal. Se analiza **para aprender** y se
> documentan **técnicas y algoritmos** (ideas). El contenido **propio** va bajo **MIT**; el
> material de terceros que pueda conservarse en `recovered/` (binarios del original,
> gráficos/paletas decodificados, textos) **no** está cubierto por esa licencia y sigue siendo ©
> de sus autores — solo referencia de estudio. Ver
> [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md) §8.

---

## Índice de expedientes

| Título | Año | Plataforma | Estado | Carpeta |
|---|---|---|---|---|
| **Arte** (Sanity) | 1993 | A500 OCS/ECS | En curso | [`sanity-arte/`](sanity-arte/README.md) |

Cada título vive en su propia carpeta y sigue la **estructura canónica** de
[`STRUCTURE.md`](STRUCTURE.md). Para abrir uno nuevo se copia [`_template/`](_template/) y se sigue
su roadmap.

## Cómo está organizado

```
Amiga-Reverse/
  README.md                 este documento (índice + convenciones)
  STRUCTURE.md              estructura canónica de un expediente y reglas
  LECCIONES_APRENDIDAS.md   método transversal (sirve para todos los títulos)
  AGENTS.md                 directrices de trabajo del agente
  toolkit/                  utilidades reutilizables (no atadas a un título)
    node/  python/  ghidra/
  _template/                esqueleto para un título nuevo
  <titulo>/                 un expediente por título o pieza
    docs/  specs/  tools/  out/  recovered/  reimpl/
```

- **`out/`** es **desechable**: volcados, módulos, capturas y salidas de Ghidra. Se regenera con
  `tools/`/`toolkit/`; nunca es fuente de verdad.
- **`recovered/`** es **curado**: solo lo revisado (código `.asm`, media decodificada, mapas,
  símbolos), con trazabilidad (`SOURCE` + `sha1`).
- **`reimpl/`** es el **destino**: cada técnica recuperada reescrita como C++ propio.
- **`out/ghidra/`** (regla 8 de `STRUCTURE.md`): salida de Ghidra, **no curada** (los nombres
  `FUN_xxxx` cambian entre versiones).

## Metodología (flujo de trabajo)

```
imagen (.dms/.adf/.ipf)
  -> descomprimir (si .dms) y VERIFICAR
  -> identificar formato (¿AmigaDOS o trackloader?)
  -> arrancar en WinUAE-DBG y volcar RAM en caliente
  -> localizar el decruncher del loader y engancharlo -> out/modules/*.bin
  -> desensamblar (objdump/capstone)            -> recovered/code/*.asm (canónico)
  -> analizar con Ghidra (CFG/xrefs/decompilador) -> out/ghidra/*.decomp.c
  -> extraer media (bitplanes, paletas, copper)   -> recovered/media/
  -> reimplementar en C++                          -> reimpl/
```

**Regla de oro**: si el disco no es AmigaDOS, el código **no está en el fichero** (está en RAM tras
el decrunch). Y **la demo en marcha no es fiable** para reconstruir un frame (el Copper hace splits):
la captura de pantalla es la referencia visual y el **código es la verdad**.

El método completo, trampas y recetas (DMS, loaders propios, WinUAE-DBG + GDB, enganche de
decrunchers, canal lateral, desensamblado, Ghidra/Rizin) está en
[`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md).

## Toolkit reutilizable

Utilidades **parametrizables** (no atadas a un título), documentadas en
[`toolkit/README.md`](toolkit/README.md):

| Área | Herramientas |
|---|---|
| **DMS / binarios** | `python/dms_unpack.py` (DMS→ADF verificado), `python/bin_scan.py` (strings/entropía) |
| **Emulador (WinUAE-DBG + GDB)** | `node/winuae-session.mjs`, `node/dump-ram.mjs`, `node/hook-trampoline.mjs`, `node/probe-breakpoints.mjs`, `node/probe-layout.mjs`, `node/launch.mjs`, `node/side.mjs`, `node/stop.mjs`, `capture-live.ps1` |
| **Vídeo / assets** | `node/dump-display.mjs`, `node/decode-bitplanes.mjs`, `python/copper_decode.py`, `python/planar_decode.py`, `python/ollama_vision.py` |
| **Desensamblado / decompilado** | `ghidra/` (scripts headless + pipeline), ver [`toolkit/ghidra/README.md`](toolkit/ghidra/README.md) |

Guía de bitmaps OCS/ECS: [`toolkit/python/AMIGA_BITMAPS.md`](toolkit/python/AMIGA_BITMAPS.md).

## Entorno / toolchain

- **WinUAE-DBG x86** (`WinUAE-DBG/bin/winuae-gdb.exe`) — emulador + servidor **GDB** (`:2345`) +
  **canal lateral** (`:2346`). El x64 tiene un bug de boot con GDB.
- **mcp-winuae-emu** (repo hermano) — módulo Node (`WinUAEConnection`, `GdbProtocol`).
- **`m68k-amiga-elf-objdump.exe`** (extensión Bartman) — **desensamblado canónico**.
- **Ghidra 12.0.1 + extensión [`BartmanAbyss/ghidra-amiga`](https://github.com/BartmanAbyss/ghidra-amiga)**
  — loaders **Hunk/WinUAE `.uss`/Kickstart ROM**, analyzer de llamadas + **símbolos NDK 3.9** y
  **decompilador a C**. Ver [`toolkit/ghidra/README.md`](toolkit/ghidra/README.md).
- **Rizin 0.9.1** — disasm/xrefs ligero (sin decompilador en el build base; `rz-ghidra` compilado
  en WSL como segundo decompilador, ver `toolkit/ghidra/wsl/`).
- **Kickstart 1.3** (`C:\Amiga\KICK13.rom`), **Node.js** ≥ 18, **Python 3**, **JDK 21** (Ghidra).

## Documentación interna

### Transversal (todo el repo)

| Documento | Contenido |
|---|---|
| [`STRUCTURE.md`](STRUCTURE.md) | Estructura canónica de un expediente, reglas y convenciones |
| [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md) | Método reutilizable y trampas (§7bis: Ghidra/Rizin) |
| [`PORTING.md`](PORTING.md) | **Del código recuperado al engine Amiga**: contrato de técnica (C/C++ ref + ASM canónico), ABI y checklist |
| [`AGENTS.md`](AGENTS.md) | Directrices de trabajo (objetivos, reglas de documentación, uso de Ollama) |
| [`toolkit/README.md`](toolkit/README.md) | Todas las utilidades, opciones y ejemplos |
| [`toolkit/ghidra/README.md`](toolkit/ghidra/README.md) | Ghidra + extensión Amiga: instalación, scripts, pipeline, rz-ghidra |
| [`toolkit/python/AMIGA_BITMAPS.md`](toolkit/python/AMIGA_BITMAPS.md) | Guía de reconstrucción de bitmaps OCS/ECS |

### Expediente «Arte» (`sanity-arte/`)

| Documento | Contenido |
|---|---|
| [`sanity-arte/README.md`](sanity-arte/README.md) | Estado, inventario y cómo reproducir |
| [`docs/ROADMAP.md`](sanity-arte/docs/ROADMAP.md) | Fases, criterios de cierre, riesgos, estado de efectos |
| [`docs/HALLAZGOS.md`](sanity-arte/docs/HALLAZGOS.md) | Datos concretos con evidencia (direcciones, firmas, formatos) |
| [`docs/TECNICAS.md`](sanity-arte/docs/TECNICAS.md) | Efecto a efecto + receta de reimplementación |
| [`docs/GHIDRA_AMIGA_EVAL.md`](sanity-arte/docs/GHIDRA_AMIGA_EVAL.md) | Evaluación de Ghidra + extensión (loaders, `.uss`, decompilador) |
| [`docs/GHIDRA_DECOMP_VS_REIMPL.md`](sanity-arte/docs/GHIDRA_DECOMP_VS_REIMPL.md) | Decompilado vs. reimpl (motor 3D, zoom, túnel) y cross-check con rz-ghidra |
| [`docs/PORT_ENGINE_ZOOM_Y_TUNEL.md`](sanity-arte/docs/PORT_ENGINE_ZOOM_Y_TUNEL.md) | Guía de port a un engine A500 50 Hz (zoom y túnel) |
| [`tools/README.md`](sanity-arte/tools/README.md) | Comandos exactos para reproducir el expediente |
| [`recovered/code/ALGORITMOS_ZOOM_Y_TUNEL.md`](sanity-arte/recovered/code/ALGORITMOS_ZOOM_Y_TUNEL.md) | Análisis de los algoritmos de zoom (`0x07E42C`) y túnel (`0x03AFFC`) |
| [`recovered/maps/modules.md`](sanity-arte/recovered/maps/modules.md) | Tabla de módulos, direcciones, tamaños, sha1 |
| [`recovered/maps/memory_map.md`](sanity-arte/recovered/maps/memory_map.md) | Regiones de memoria y su contenido |
| [`recovered/maps/effects.md`](sanity-arte/recovered/maps/effects.md) | Tabla de efectos → rutina/estado |
| [`recovered/media/palettes/tunnel-VALIDACION.md`](sanity-arte/recovered/media/palettes/tunnel-VALIDACION.md) | Validación del túnel y límite (mapa original no recuperado) |

## Técnicas recuperadas y portadas

Recreaciones en C++ en [`sanity-arte/reimpl/`](sanity-arte/reimpl/README.md); índice y estado en
[`ROADMAP.md`](sanity-arte/docs/ROADMAP.md):

| Técnica | Módulo | Reimpl |
|---|---|---|
| Seno Q1.14 | `SINE.soslibrary` | [`sine_table`](sanity-arte/reimpl/sine_table/README.md) |
| Motor 3D Q15 (matriz + transform + ortonormalización) | `0x0B0C2C` | [`motor_3d`](sanity-arte/reimpl/motor_3d/README.md) |
| Blobs con lookup tables | `0x0B0C2C` | [`blob_render`](sanity-arte/reimpl/blob_render/README.md) |
| Distorsión SINE (8 osciladores) | `0x096A28` | [`sine_wobble`](sanity-arte/reimpl/sine_wobble/README.md) |
| Scrolltext (fuente 3 planos) | `0x02162C` | [`scrolltext`](sanity-arte/reimpl/scrolltext/README.md) |
| Fade de paleta por nibbles | `0x0B0C2C` | [`palette_fade`](sanity-arte/reimpl/palette_fade/README.md) |
| Esfera texturizada 16 col. | (Chaos) | [`sphere`](sanity-arte/reimpl/sphere/README.md) |
| Túnel / corridor (raycast por filas) | `0x03AFFC` | [`tunnel`](sanity-arte/reimpl/tunnel/README.md) |
| Zoom/créditos (núcleo: Q16, trayectoria, bandas) | `0x07E42C` | [`zoom`](sanity-arte/reimpl/zoom/README.md) |

Pendientes: el **blit/copper del zoom** y la **rutina de render del túnel** (init localizado, render
por dispatch indirecto).

## Cómo empezar

```powershell
# 1) Extraer el disco (verificado por pista)
python toolkit\python\dms_unpack.py Sanity-Arte.dms sanity-arte\out\disk\sanity-arte.adf --verbose

# 2) Arrancar en WinUAE-DBG y volcar RAM + módulos
node toolkit\node\dump-ram.mjs --config sanity-arte\out\sanity.uae --adf sanity-arte\out\disk\sanity-arte.adf --boot 20 --prefix sanity --screenshot
node toolkit\node\hook-trampoline.mjs --config sanity-arte\out\sanity.uae --adf sanity-arte\out\disk\sanity-arte.adf --spec sanity-arte\specs\imp-dump.json --out sanity-arte\out --boot 5

# 3) Desensamblar / decompilar
#    (objdump/capstone para el .asm canónico; Ghidra para CFG/xrefs/decompilado)
..\toolkit\ghidra\decompile-modules.ps1 -ModulesJson sanity-arte\out\modules\modules.json -OutDir sanity-arte\out\ghidra
```

Comandos completos por título: [`sanity-arte/tools/README.md`](sanity-arte/tools/README.md).

## Añadir un título nuevo

1. Copiar [`_template/`](_template/) a `Amiga-Reverse/<titulo>/`.
2. Rellenar `README.md` y `docs/ROADMAP.md` (fase 0 = extraer la imagen).
3. Añadir la spec en `specs/` y documentar los comandos del toolkit en `tools/README.md`
   (reutilizar `toolkit/`, no crear scripts salvo necesidad real).
4. Ir volcando: `out/` → revisar → promover a `recovered/` → reimplementar en `reimpl/`.
5. Añadir cada técnica a `docs/TECNICAS.md` con su receta de port.

Detalle y reglas en [`STRUCTURE.md`](STRUCTURE.md) §«Abrir un título nuevo».

## Licencia

- **Contenido propio** (análisis, documentación, reimplementaciones C++ y toolkit):
  **MIT** — ver [`LICENSE`](LICENSE).
- **Material de terceros** (`sanity-arte/recovered/`: binarios del original, gráficos/paletas
  decodificados, textos): **no** está cubierto por la MIT; © de sus autores (p. ej. Dierk
  Ohlerich / Chaos of Sanity, Moby, Ra). Es **referencia de estudio** para la ingeniería inversa,
  no se licencia aquí. Ver [`sanity-arte/recovered/README.md`](sanity-arte/recovered/README.md).

Este repositorio es **privado** y de uso personal; la licencia no cambia el estatus del material
de terceros.
