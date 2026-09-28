# Juegos difíciles — inventario (oráculo vs transpilador)

Inventario de los juegos que ponen a prueba el pipeline NES→Amiga. **Fuente de verdad de cifras:
[`COMPATIBILITY.md`](COMPATIBILITY.md)**; estado de mappers: [`MAPPERS.md`](MAPPERS.md).

> Este documento nació como inventario para un **backend Mega Drive**, hoy **descartado**
> (el 68000/OCS del A500 con Copper/Blitter encaja mejor vía transpilación + HLE). Se conserva
> reenfocado a lo que realmente importa: dónde se atasca el **oráculo** y dónde el **transpilador**.

## 1. Oráculo — estado por juego (60 frames vs `mesen`)

El **oráculo** (CPU 6502 + PPU/APU software) soporta los mappers NROM/UxROM/CNROM/MMC1/MMC3, y un
subconjunto de **MMC5** y **VRC6**, más AxROM y FME‑7. La mayoría de la matriz está a **0.0 %**.

| Juego | mapper | estructura vs mesen | Nota |
|---|---:|---:|---|
| Gemfire, Mr. Gimmick, Batman RotJ, Batman TV, dk, dkjr, metroid, megaman3/5/6, … | varios | **0.0 %** | sin divergencia |
| Nobunaga's Ambition II | 5 (MMC5) | 0.6 % | |
| Contra, galaga | 2 / 0 | 0.9 % | |
| Battletoads | 7 (AxROM) | 1.9 % | CHR‑RAM |
| Castlevania III / Akumajou Densetsu / Crystalis | 5 / 24 / 4 | 2.7 % | |
| smb | 0 | 3.1 % | límite de timing `$2002` |
| metalstorm | 4 | 14.2 % | límite de timing `$2002` |
| gradius | 3 | 3.3 % | límite de timing `$2002` |
| **Uncharted Waters** | 5 (MMC5) | **45.8 %** | **bug abierto** (ver §3) |
| **ic** | 0 | **92.2 %** | límite de timing `$2002` |
| Esper Dream 2 / Mouryou Senki Madara | 26 (VRC6b) | "100 %" | **inconcluyente**: pantalla en blanco sin *input* |

## 2. Qué falta de verdad (por prioridad)

| # | Falta | Dónde | Impacto |
|---:|---|---|---|
| 1 | **Banking en el transpilador** (sigue NROM-only) | `tools/transpiler/` | **techo real de conversión**: casi todo el catálogo comercial usa MMC1/MMC3/… |
| 2 | **Input-injection** en el harness de validación | `runtime/test/` | hace medibles RPG/intros y splits; quita los "100 %" falsos |
| 3 | **Uncharted Waters (MMC5) 45.8 %** | PPU/MMC5 | 1 juego, pero valida el mapper más duro |
| 4 | **Timing `$2002`/NMI** (ic, metalstorm, gradius, smb) | oráculo | fidelidad de **estado**; **no bloquea** el port (el Amiga usa Copper/Blitter) |
| 5 | **MMC5 audio de expansión** + banco CHR del split | runtime | solo audio |

El trabajo nº 1 se abre y detalla en
[`TRANSPILER_BANKING.md`](TRANSPILER_BANKING.md). El nº 4 tiene su plan acotado en
[`TIMING_ROADMAP.md`](TIMING_ROADMAP.md).

## 3. Detalle de los casos difíciles

### MMC5 — `Uncharted Waters` 45.8 % (bug abierto)
`mesen` pinta casi todo negro + un logo rojo; nosotros pintamos ~41 000 px no negros repartidos.
Hipótesis **descartadas** (medidas): modo atributo extendido de ExRAM, reloj de bus cycle-exact,
selector `chrA` (no aplica: `$2000` bit5=0). Falta una comparación **pixel a pixel** con `mesen`
(dump de nametable/CHR; el volcado `RRS1` no está en el `.so`). Gemfire/Laser/Nobunaga's/CV3 no
regresan (0.0–3.1 %).

### VRC6b (26) — Esper Dream 2 / Mouryou Senki Madara ("100 %")
**NO es un bug de mapper**: a 60/200/400 frames ambos frames son de **un solo color** (pantallas en
blanco esperando *input*). El "100 %" es la métrica contando la **diferencia de color de fondo** en
pantalla plana. Requiere **input-injection** para ser verificable.

### Timing `$2002`/NMI (ic 92.2 %, metalstorm 14.2 %, gradius 3.3 %, smb 3.1 %)
Una **sola raíz**: la sincronización PPU/NMI **sub‑instrucción** (no cycle-exact). El oráculo
sincroniza la PPU por instrucción, `mesen` por ciclo → el bucle `LDA $2002/BPL` sale una iteración
antes/después y el NMI cae en otra frontera. No es bloqueante para el Amiga. Plan y alternativas
descartadas: [`TIMING_ROADMAP.md`](TIMING_ROADMAP.md), [`RISKS.md`](RISKS.md).

### Juegos que exigen precisión de PPU fina
Battletoads (AxROM, CHR‑RAM), Jurassic Park, Metal Storm, Shatterhand, Mr. Gimmick → ya renderizan
(0.0–1.9 %) gracias al PPU por frontera de bloque + dot; lo que queda es el timing de arriba.

## 4. Transpilador — techo de compatibilidad

El **oráculo** soporta mappers y el **transpilador** ya traduce **NROM/CNROM** y **UxROM (2)** con
**bloques por banco** (F9/B1b + B2): p. ej. Castlevania/Contra (UxROM) se transpilan y, dentro
de `NesSystem`, dan el **mismo framebuffer** que el intérprete. Los mappers con **banking más complejo**
(MMC1/MMC3/MMC5/VRC6/FME‑7) todavía no se transpilan, aunque el oráculo los ejecute. Ese trabajo está
abierto en [`TRANSPILER_BANKING.md`](TRANSPILER_BANKING.md) (siguiente: B3).
