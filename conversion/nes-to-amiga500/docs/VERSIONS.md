# Versiones y congelado (oráculo / codegen / ABI)

Antes de empezar el **backend Amiga** se **congela** la referencia contra la que se validará el
port. Regla: si un cambio altera lo **observable** (framebuffer, estado de RAM, timing), hay que
**incrementar la versión** correspondiente y actualizar esta tabla.

| Componente | Constante | Valor | Qué fija |
|---|---|---|---|
| **Oráculo** | `n2a::kOracleVersion` (`runtime/include/nes_system.hpp`) | **3** | Semántica de la emulación del host |
| **ABI de plugin** | `N2A_ABI_VERSION` (`runtime/plugin/n2a_plugin.h`) | **1** | Contrato `.n2x`  gestor |
| **Codegen** | `kCodegenVersion` (`tools/transpiler/src/main.cpp`) | **2** | Invalida la caché de `.n2x` por CRC/gen |

Tags: `oracle-v1` (kOracleVersion 1), `oracle-v1.1` (kOracleVersion 2), `oracle-v2`
(kOracleVersion 3), **`oracle-v2.1`** (kOracleVersion **4**; ver abajo).

## Cambios v3 → v4 (etiqueta `oracle-v2.1`) — timing PPU por dot

Fase 1+2 del [`TIMING_ROADMAP.md`](TIMING_ROADMAP.md):
- **PPU dot a dot** (`clock_ppu` avanza dot a dot, como mesen `PPU::Exec`): sprite-0, flag de
  VBlank y **reloj A12 de la MMC3** se resuelven en su **dot exacto**.
- **Fase continua**: el dot del PPU **no se resetea** al inicio de frame (solo con `kFrameSnap`).
- Efecto observable: **jurassicpark 13.7% → 0.0%** y **blastermaster 9.1% → 0.0%**; el primer bucle
  de VBlank de metalstorm alinea. Sin regresiones (`gate EXIT=0`).

## Cambios v2 → v3 (etiqueta `oracle-v2`)

Referencia cambiada a **mesen** (cycle-accurate) tras corregir el diff de trazas (leía 6/8 B en vez
de 10/12 B). Cambios observables:

- **MMC1 completo**: PRG modes 2/3, CHR 4K/8K **conmutada** (chr0/chr1), WRAM `$6000-$7FFF` + disable
  (`$E000` bit4), filtro de 2 ciclos, mirroring de 1 pantalla (modos 0/1). → megaman2/metroid 0.0%,
  zelda 0.4%, bioniccommando 0.0%.
- **Render con la CHR conmutada del mapper** (no la ROM lineal): era un bug de fondo que daba
  geometría equivocada. → smb3 0.4%, megaman3 0.0%, ninjagaiden 1.2%, megaman5 0.0%, etc.
- **Timing del VBlank alineado con mesen**: sin supresión de VBlank (`warmup_frames` fuera), +8
  ciclos de reset (`mesen CPU.cpp:150`), frame 0 sin forzar la frontera, ejecutor rápido dot-exacto
  en `$2002`, `$2002` limpia el NMI, skip de 1 dot en la pre-render de frames impares (NTSC).
- **Captura de `$2000`/`$2001` por línea** (splits mid-frame tipo HUD de SMB3).
- Resultado: **23 ROMs a 0.0%**, 9 ≤3.6%, y **6 con un único límite conocido** (sincronización
  PPU/NMI por instrucción; detalle y **solución** en [`RISKS.md`](RISKS.md)). No es congelado "final":
  el límite está documentado y acotado.

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
