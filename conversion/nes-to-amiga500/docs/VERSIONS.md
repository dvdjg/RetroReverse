# Versiones y congelado (oráculo / codegen / ABI)

Antes de empezar el **backend Amiga** se **congela** la referencia contra la que se validará el
port. Regla: si un cambio altera lo **observable** (framebuffer, estado de RAM, timing), hay que
**incrementar la versión** correspondiente y actualizar esta tabla.

| Componente | Constante | Valor | Qué fija |
|---|---|---|---|
| **Oráculo** | `n2a::kOracleVersion` (`runtime/include/nes_system.hpp`) | **1** | Semántica de la emulación del host |
| **ABI de plugin** | `N2A_ABI_VERSION` (`runtime/plugin/n2a_plugin.h`) | **1** | Contrato `.n2x` ↔ gestor |
| **Codegen** | `kCodegenVersion` (`tools/transpiler/src/main.cpp`) | **2** | Invalida la caché de `.n2x` por CRC/gen |

## Oráculo v1 — comportamiento fijado

- **Frame de 262 líneas** (0..261), 341 dots/línea → ~29782 ciclos de CPU/frame (NTSC).
- **PPU**: nametables con mirroring y envoltura de 30 filas; sprites (flips/prioridad/8 por línea +
  overflow); **sprite-0 dot-exacto** (línea + columna del primer píxel); VBlank en la 241; `$2000-$2007`
  con el reparto correcto de VRAM (`$0000-$1FFF` = pattern/CHR-ROM, `$2000-$3EFF` = nametables con
  espejo, `$3F00-$3FFF` = paleta con espejo `$3F10→$3F00`).
- **CPU**: ciclos por instrucción exactos; **reloj de bus por acceso** (dot-exacto, activado por
  defecto, desactivable con `set_cycle_exact(false)`).
- **APU**: pulse ×2 (envelope + sweep), triangle, noise (envelope) y DMC (lectura de PRG), mezcla no
  lineal.

### Límites conocidos de v1 (no son bugs de versión)

- Deriva de **estado** de unos bytes en juegos con temporizadores de raster (SMB: 8 bytes; ver
  `RISKS.md`). No afecta a la mayoría (8 de 13 ROMs a **0.0%** de diff estructural; ver
  `COMPATIBILITY.md`).
- Algunos juegos con **deriva severa** de frames aún por investigar (Ice Climber 92.2%, Galaga
  36.4%).

## Uso del congelado

- El **backend Amiga** se valida contra el **oráculo v1** (mismos `hash`/estructura/RAM; ver
  `PORT_TEST_PLAN.md`).
- Cambiar cualquiera de los tres valores **rompe la referencia**: hay que regenerar la matriz
  (`port_matrix.sh`), la caché de plugins (por `gen`) y re-validar el port.
