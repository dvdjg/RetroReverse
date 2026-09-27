# Versiones y congelado (oráculo / codegen / ABI)

Antes de empezar el **backend Amiga** se **congela** la referencia contra la que se validará el
port. Regla: si un cambio altera lo **observable** (framebuffer, estado de RAM, timing), hay que
**incrementar la versión** correspondiente y actualizar esta tabla.

| Componente | Constante | Valor | Qué fija |
|---|---|---|---|
| **Oráculo** | `n2a::kOracleVersion` (`runtime/include/nes_system.hpp`) | **3** | Semántica de la emulación del host |
| **ABI de plugin** | `N2A_ABI_VERSION` (`runtime/plugin/n2a_plugin.h`) | **1** | Contrato `.n2x`  gestor |
| **Codegen** | `kCodegenVersion` (`tools/transpiler/src/main.cpp`) | **2** | Invalida la caché de `.n2x` por CRC/gen |

Tags: `oracle-v1` (congelado inicial), `oracle-v1.1` (CHR-RAM, MMC3 + PRG-RAM, IRQ de CPU),
**`oracle-v2`** (timing del VBlank alineado con mesen).

## Cambios v2 → v3 (timing del VBlank alineado con mesen)

Referencia cambiada a **mesen** (cycle-accurate) tras corregir el diff de trazas (leía 6/8 B en vez
de 10/12 B). Cambios observables:

- **Sin supresión de VBlank**: `warmup_frames` eliminado (mesen levanta el flag en `(241,1)` desde el
  frame 0; el `ppudead=2` de fceumm era un hack).
- **+8 ciclos de reset** modelados (`mesen CPU.cpp:150`).
- **Frame 0 sin forzar la frontera**: la PPU arranca en la línea 0; el primer VBlank cae en su sitio
  (antes se adelantaba ~27000 ciclos).
- **Ejecutor rápido dot-exacto en `$2002`**: los bloques se cortan antes de acceso a `$2000-$3FFF`.
- Efecto: IC/SMB/bioniccommando pasan de divergir en idx 36-42 a idx ~7800-9100 (el VBlank real).
  Residuo: **±1 ciclo** sub-instrucción en el cruce del VBlank.

## Cambios v1 → v1.1

- **CHR-RAM** (cartuchos con 0K CHR): los patrones se cargan por `$2007`.
- **MMC3 (mapper 4)**: PRG/CHR por bancos, mirroring, IRQ por scanline; + **PRG-RAM** `$6000-$7FFF`.
- **IRQ de CPU** (frame counter del APU / DMC / MMC3).
- Resultado: varios MMC3 a **0.0%** (Ninja Gaiden II/III, Mega Man 6); ver `COMPATIBILITY.md`.

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
