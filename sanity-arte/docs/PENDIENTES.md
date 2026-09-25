# Pendientes — «Arte» (inventario vivo)

Lista de trabajo abierto del expediente, con dependencias y valor. Complementa a
[`ROADMAP.md`](ROADMAP.md) (fases) y [`GHIDRA_DECOMP_VS_REIMPL.md`](GHIDRA_DECOMP_VS_REIMPL.md).
Este documento es el **estado de partida** para la reestructuración del proyecto (que pasará a ser
subproyecto de un marco mayor de conversión de juegos clásicos a PC).

## A. Cierre de técnicas (efectos)

| # | Pendiente | Depende de | Valor | Verificable |
|---|---|---|---|---|
| A1 | **Render del túnel**: aislar la rutina por-frame (init `0xC0424A` localizado; render por dispatch SOS) | tabla de dispatch SOS | alto (único efecto sin validar) | sí (emulador) |
| A2 | **Zoom**: portar blit/copper (`FUN_0000193e`) + extraer tablas reales (`$3EE2/$3944/$38AA/$3A78`) | `reimpl/zoom` (núcleo hecho) | medio | host + emulador |
| A3 | **Plasma** (`0x09A940`) | — | medio | host |
| A4 | **Rubber-rotator** (¿`0x078A2C`?) | identificación | medio | host |
| A5 | **ASM canónico** restante (zoom, esfera, túnel) | A1/A2 | alto (uso directo) | — |
| A6 | **Coste/ciclos** por técnica para decidir C vs ASM | — | medio | emulador |

## B. Contrato de técnica (PORTING.md)

| # | Pendiente | Depende de | Valor |
|---|---|---|---|
| B1 | Rellenar la sección **Contrato** (registros, Q15/Q16, preservación) en cada `reimpl/*/README.md` | — | alto |
| B2 | **Test cruzado host ↔ Amiga**: compilar el C++/ASM con `m68k-amiga-elf-g++`, correr en WinUAE y comparar | B1 | alto |
| B3 | **Empaquetado para el engine**: header de interfaz + integración de build (vbcc/gcc) | B1/B2 | alto |

## C. Orquestación (el mayor gap)

| # | Pendiente | Depende de | Valor |
|---|---|---|---|
| C1 | Mapa del **dispatch de módulos/efectos** de SOS (tabla de *jobs*) | — | alto |
| C2 | **Bucle de frame** + VBlank + doble buffer | C1 | alto |
| C3 | **Copper** (splits, bandas) y **Blitter** en la capa de vídeo | — | alto |
| C4 | Carga de **assets** (bitplanes, paletas, samples, MOD) desde el formato SOS | — | medio-alto |
| C5 | Reconstruir la **demo completa** en el engine | C1–C4 + A* | objetivo final |

## D. Pipeline de análisis (Ghidra / tooling)

| # | Pendiente | Depende de | Valor |
|---|---|---|---|
| D1 | Pipeline headless Ghidra → `out/ghidra` (hecho) y **cross-check automático** con rz-ghidra | — | medio |
| D2 | Extracción de **datos por xref** sistematizada para alimentar decoders | — | medio |
| D3 | `DumpDecomp` con **re-tipado** (estructuras) para C más limpio | — | bajo |

## E. Documentación y método

| # | Pendiente | Valor |
|---|---|---|
| E1 | Re-baseline de `ROADMAP.md`/`TECNICAS.md` tras cada avance | medio |
| E2 | Consolidar `TECNICAS.md` con la **receta de port** por técnica (C++ + ASM + contrato) | alto |
| E3 | Documentar el **formato SOS** (loader, dispatch, assets) como spec del expediente | alto |

## F. Integración con el marco RetroReverse (mismo repo)

Ver [`../../docs/MIGRATION_AMIGA_REVERSE.md`](../../docs/MIGRATION_AMIGA_REVERSE.md) y
[`../../docs/ROADMAP.md`](../../docs/ROADMAP.md) (fase P2).

| # | Pendiente | Valor |
|---|---|---|
| F1 | Migrar el expediente al **layout del marco** (`platforms/computers/amiga500/games/arte/`) | alto |
| F2 | Adaptar los artefactos al **HIGS** (spec agnóstica de hardware) | alto |
| F3 | Convertir `reimpl/` en **reimplementación SDL** validada diferencialmente vs emulador | alto |
| F4 | Empaquetar el **toolkit** como biblioteca reutilizable del marco (crates/módulos) | medio |

## Orden propuesto

1. **A1** (túnel) → cierra el último efecto sin validar.
2. **B1 + B2** (contrato + test cruzado) → hace el port "directo" y verificable.
3. **C1 + C2** (dispatch + bucle de frame) → desbloquea correr efectos en el engine.
4. **A2/A3/A4 + A5** (cierre de efectos y ASM).
5. **C3–C5** (vídeo/assets/demo completa).
6. **F1–F4** (integración en el marco mayor).

> Nota: los pendientes **A/B/C** son del expediente actual; **F** depende de la reestructuración
> (documentación del marco en [`../../docs/`](../../docs/)).
