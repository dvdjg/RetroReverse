# Banking en el transpilador (F9) — diseño y plan

Apertura del trabajo de **bankswitching de PRG** en el transpilador estático
([`../tools/transpiler/`](../tools/transpiler/README.md)). Hoy el transpilador solo traduce **PRG
fija** (NROM/CNROM); los juegos con PRG bancada **no se pueden transpilar** aunque el oráculo los
ejecute bien ([`HARD_GAMES.md`](HARD_GAMES.md) §4). Este documento fija el diseño antes de tocar el
codegen.

## Problema

El transpilador hace **desensamblado recursivo** sobre direcciones de CPU (`$8000-$FFFF`) y emite un
`bb_XXXX` por *basic block*, con **despacho disperso** indexado por `cpu.PC` (tabla ordenada +
búsqueda binaria; ver [`TRANSPILER.md`](TRANSPILER.md)). Con PRG
bancada, **la misma dirección `$8000-$BFFF` es código distinto según el banco activo**, así que un
único bloque por dirección es ambiguo.

## Hechos del sistema actual (a reutilizar)

- El **runtime ya sabe** de bancos: [`nes_mapper.hpp`](../runtime/include/nes_mapper.hpp) tiene
  `Mapper` con `prg_bank`, `cpu_read()` por mapper (UxROM/MMC1/MMC3/VRC6/MMC5/FME‑7), y
  [`nes_system.hpp`](../runtime/include/nes_system.hpp) ya expone un hook
  **`on_prg_bank_change`** (se llama al escribir el registro del mapper) que hoy invalida `FastCpu`.
- El **plugin `.n2x`** (ABI en [`n2a_plugin.h`](../runtime/plugin/n2a_plugin.h)) ya corre en
  **68000** (`N2A_ARCH_M68K`) y su `n2a_block` despacha por `cpu.PC`; el host aporta
  intérprete/PPU/APU/mapper y usa el **fallback** para direcciones sin bloque.
- El transpilador ya modela `mapper_`, `prg_size_`, `chr_size_` y rechaza mappers con PRG no fija
  (`parse_header`, `prg_fixed = mapper==0 || mapper==3`).

## Modelo propuesto

### 1. `PrgLayout` (ventanas y bancos)

Por mapper, calcular:

| Campo | NROM/CNROM | UxROM (2) | MMC1 (1) | MMC3 (4) |
|---|---|---|---|---|
| `bank_size` | — | 0x4000 | 0x4000 | 0x2000 |
| `nbanks` | 1 | `prg_size/0x4000` | `prg_size/0x4000` | `prg_size/0x2000` |
| ventana conmutable | — | `$8000-$BFFF` | `$8000/$C000` (modos) | 4×`$2000` |
| ventana fija | `$8000-$FFFF` | `$C000-$FFFF` = **último banco** | `$C000-$FFFF` | 2 fijas |

Empezar por **UxROM** (una ventana conmutable de 16 KB + una fija) por ser el caso real más simple.

### 2. Bloques por banco

- Ventana **fija** → bloques `bb_<addr>` (como hoy).
- Ventana **conmutable** → bloques `bbB<banco>_<addr>`, decodificados **independientemente por
  banco** (los puntos de entrada de un banco no son válidos en otro).
- La lectura durante el análisis (`read_byte/read_word`) pasa a ser **consciente del banco**
  (`prg_offset(addr, banco)`), en vez de lineal.

### 3. Despacho (clave: **disperso**, no 64K×N)

Un `dispatch_bank[nbank][0x10000]` es inviable en A500 (256 KB × bancos). Se usa **despacho
disperso**:

- Tabla **ordenada** de `{addr_u16, fn}` por ventana/banco + **búsqueda binaria**, o bitmap de
  páginas + tabla (2 niveles).
- `n2a_block`:
  ```
  if (cpu.PC >= 0xC000) fn = fixed_lookup(cpu.PC);        // ventana fija
  else                 fn = bank_lookup(active_bank, cpu.PC);  // ventana conmutable
  if (fn) fn(cpu); else interpret_one_instruction(cpu);    // fallback
  ```

### 4. Contrato con el host (bank switch)

- Añadir a la ABI del plugin `void n2a_set_prg_bank(unsigned bank);` (opcional).
- El host lo llama desde el hook **`on_prg_bank_change`** ya existente (o el plugin lo lee del
  mapper si se expone en `NESMemory`). El plugin solo **cambia el puntero de banco activo**; los
  bloques ya están compilados (no hay recompilación en caliente).
- **Fallback**: direcciones de la ventana conmutable sin bloque (p. ej. banco detectado solo
  dinámicamente) se ejecutan con el intérprete, que ya lee a través del mapper.

## Fases (cada una es un commit con `gate` verde)

| Fase | Entregable | Verificación |
|---|---|---|
| **B0 (esta apertura)** | Este diseño + modelo `PrgLayout` en `parse_header` + diagnóstico de mapper/bancos en la CLI | el transpilador reporta `mapper`, `nbanks`, ventana fija; NROM/CNROM **sin cambios** |
| **B1a (hecho)** | `read_byte`/`prg_offset` **conscientes del mapper**: ventana fija de UxROM (`$C000-$FFFF`=último banco) transpilada; conmutable por **fallback** del runtime | transpila UxROM; el C++ generado **compila** (NROM/CNROM sin cambios) |
| **B1b (hecho)** | Decodificación **por banco** + bloques `bbB…` (ventana conmutable estática) desde las entradas descubiertas en la ventana fija | bloques `bbB0..bbB7` en `$8000-$BFFF`; el C++ compila |
| **B2 (hecho)** | Despacho por banco + espejo `NESMemory::prg_bank` (el sistema lo actualiza en cada conmutación) + `n2a_banked_block` con **búsqueda binaria**; fallback al intérprete si no hay bloque | Castlevania y Contra (UxROM) dentro de `NesSystem`: **0.0 %** de píxeles distintos al intérprete (RAM 6 y 4 de 2048); DK (NROM) intacto |
| **B3** | MMC1 (modos 2/3) y MMC3 (4×8 KB): **modelo general de ventanas** (ver abajo) | 1 juego MMC1 y 1 MMC3 equivalen al intérprete |
| **B4** | Descubrimiento dinámico de bancos (trazas host) para MMC1/MMC3 | cobertura de bancos "alcanzados" medida |

## Invariantes y criterio de aborto

- **Sin regresión** en NROM/CNROM (mismos ficheros generados para esas ROMs).
- **Equivalencia intérprete ↔ transpilado** en UxROM (mismo estado al mismo frame).
- **Presupuesto A500**: el despacho disperso no debe acercarse a la tabla plana de 256 KB; si el
  codegen por banco dispara el tamaño (`.text` y tablas), se recorta a **ventana fija + fallback**
  (la estrategia válida de [`MAPPERS.md`](MAPPERS.md) §4) y se documenta.
- **Abortar** una fase que no mueva la aguja sin regresar NROM/CNROM (como ya se hizo con Fase 1 de
  timing).

## Riesgos

| Riesgo | Mitigación |
|---|---|
| **Tamaño** (bloques × bancos + tablas) | despacho disperso; decodificar solo bancos alcanzables; ventana fija primero |
| **Bancos alcanzados dinámicamente** (MMC1/MMC3) | análisis dinámico con trazas host (B4); fallback para el resto |
| **Código automodificable** entre bancos | fallback intérprete (ya mapper-aware) |
| **Equivalencia** intérprete↔codegen | verificar con el mismo motor y traza (invariante del nodo) |

## Estado

- [x] **B0**: detección de layout (mapper/bancos) + diagnóstico; UxROM/MMC3 reconocidos.
- [x] **B0**: detección de layout (mapper/bancos) + diagnóstico; UxROM/MMC3 reconocidos.
- [x] **B1a**: `prg_offset` consciente del mapper → **UxROM transpilable** (ventana fija; la
  conmutable `$8000-$BFFF` la ejecuta el **intérprete del runtime**, que ya lee por el mapper).
- [x] **B1b**: análisis **por banco** de la ventana conmutable (bloques `bbB0..bbB7`) desde las
  entradas descubiertas en la ventana fija; el C++ generado **compila**.
- [x] **B2**: despacho por banco en el plugin (`n2a_banked_block`, **búsqueda binaria**) + espejo
  **`NESMemory::prg_bank`** (el sistema lo actualiza en cada conmutación; **ABI v2**); fallback al
  intérprete si una dirección no tiene bloque. **Verificado** en `gen_frame` (dentro de `NesSystem`):
  Castlevania (UxROM) **0.0 %** píxeles / RAM 6/2048; **Contra** (UxROM) **0.0 %** / RAM 4/2048; DK
  (NROM) intacto.
- [~] **B3**: MMC1/MMC3. **Intento MMC1 modo 16K fallido por el TIMING**, no por el banking: el
  diagnóstico `fallback` (0 %) vs `fixed` (20.1 %) vs `banked` (20.1 %) demuestra que cualquier bloque
  transpilado diverge en juegos *cycle-sensitive* (CHR banking + `$2002`). **Prerrequisito**: el
  scheduler de [`TIMING_ROADMAP.md`](TIMING_ROADMAP.md); sin él, MMC1/MMC3 no son seguros. Revertido a
  "reconocido, no transpilado".
- [ ] **B4**: descubrimiento dinámico de bancos.

### Medidas de tamaño (paso 4)

| ROM | bloques fijos | bloques de banco | bancos con bloques | tabla `BankBlock` |
|---|---:|---:|---:|---:|
| Castlevania | 758 | 778 (reparto 341/11/10/12/55/66/165/118) | 8/8 | ≈6.2 KB (778 × 8 B) |
| Contra | 214 | 348 (0 en bancos 2 y 3) | 6/8 | ≈2.8 KB |

- **Bancos no alcanzables = 0 bloques** (Contra: bancos 2/3 sin entradas descubiertas) → no se
  decodifican y los cubre el fallback. Es ya el comportamiento "solo bancos alcanzables".
- El despacho **fijo** también es ahora **disperso** (antes `dispatch_table[0x10000]` = 256 KB en 68000,
  casi todo a cero): `.bss = 0` y tablas de unos pocos KB. Guardado por
  [`../tools/transpiler/tests/static_size_test.sh`](../tools/transpiler/tests/static_size_test.sh).

### B3 — modelo general de ventanas (diseño, aún NO implementado)

UxROM cabe en "1 ventana conmutable + 1 fija". MMC1/MMC3 **no**:

| Mapper | Ventanas de `$8000-$FFFF` |
|---|---|
| MMC1 (1) | **depende del modo** (runtime): 0/1 = 32 KB conmutable; 2 = 16 KB conm. + 16 KB fija; **3 = 16 KB fija + 16 KB conm.** |
| MMC3 (4) | 2×8 KB conmutables + 2×8 KB fijas (o conmutables, según bit 6) |

Refactor necesario: sustituir el `bank_`/`switch_targets_` de **una** ventana por una **lista de
ventanas** `{base, tamaño, fijo|conmutable, índice-de-banco}`; analizar cada ventana conmutables por
banco, y emitir despacho por `(ventana, banco)`. **Riesgo clave**: MMC1 cambia de modo en runtime; si
un juego usa modo 0/1/3, las ventanas "fijas" que asumamos serían **incorrectas**. Mitigación
obligatoria: el runtime debe **validar el modo** (p. ej. `Mapper::mmc1_ctrl`) y, si no coincide con el
asumido, **bypassar** los bloques por banco y usar el intérprete. Por eso B3 no es un simple `switch`
de mapper: hay que tocar el modelo de análisis **y** añadir validación en runtime.

**Intento 2026 (MMC1 modo 16K, banco en `$8000`): FALLA — y NO es el banking.** Se implementó el
modelo (verificado línea a línea contra mesen `MMC1.h`: 16K/slot8000 → `$8000`=reg, `$C000`=último) +
validación de modo en runtime (sentinel `prg_bank=0xFF` → fallback). Diagnóstico con
`N2A_MODE=fallback|fixed|banked` (`gen_frame.cpp`, ROM Metroid, 60 frames):

| modo | qué ejecuta | píxeles distintos | RAM |
|---|---|---:|---:|
| `fallback` | todo el **intérprete** (referencia) | **0.0 %** | 0/2048 |
| `fixed` | solo bloques de `$C000+`; ventana `$8000-$BFFF` al intérprete | **20.1 %** | 102/2048 |
| `banked` | despacho por banco completo | **20.1 %** | 102/2048 |

**Conclusión**: con el banco conmutable **fuera** (todo a intérprete) la divergencia es **idéntica**;
añadir el despacho por banco **no cambia nada**. Por tanto el fallo **no es el modelo de ventanas ni
el banking**, sino que **cualquier bloque transpilado** (también los de la ventana fija) diverge en
estos juegos: es el **timing por bloque** (MMC1 es *cycle-sensitive*: banking de **CHR** a mitad de
frame y sondeos de `$2002`), el mismo límite conocido de [`TIMING_ROADMAP.md`](TIMING_ROADMAP.md).

**B3 — MMC1 (modo 16K): HECHO (2026).** Con la traza *codegen↔intérprete*
([`TIMING_CODEGEN.md`](TIMING_CODEGEN.md)) se localizó la causa: `io_write` fijaba
`mapper.cpu_cycle = interp.cycles`, pero en el codegen `interp.cycles` no avanza → el **filtro de 2
ciclos** del MMC1 **descartaba escrituras** de registro (ctrl/CHR). Arreglado usando el contador
**global** `cpu.cycles`. Resultado: **Metroid y Mega Man 2 byte-exact a 60 frames (0.0 %)**;
`NROM/CNROM/UxROM/MMC1` transpilables.

### B3b — MMC3 (4×8 KB) — **HECHO** (2026)

Implementado el modelo de **dos ventanas conmutables de 8 KB** (`$8000-$9FFF`=R6, `$A000-$BFFF`=R7)
+ dos fijas (`$C000-$DFFF`=n8-2, `$E000-$FFFF`=n8-1). Como las direcciones son únicas por ventana,
basta con que `n2a_banked_block(pc, b0, b1)` **elija el banco por el rango del PC** (`pc < $A000` →
R6, si no → R7); la tabla por banco ya sirve. Runtime: `NESMemory::prg_bank2` (R7) y espejo del mapper
(`prg_bank=R6`, `prg_bank2=R7`; sentinela si el **bit de modo** R0.6 cambia → fallback). **ABI v3**.

**Verificado** (`banks_test.sh`, 12 ROMs, framebuffer idéntico): MMC3 con **Mega Man 3/4, SMB3,
Crystalis, Tiny Toon, Metal Storm** además de UxROM (Contra/Castlevania) y MMC1 (Metroid/MM2/Blaster
Master).

### B3c — FME-7 (3×8 KB) — **HECHO** (2026)

Extensión directa de MMC3: **tres** ventanas conmutables de 8 KB (`$8000/$A000/$C000` =
`fme7_prg[0..2]`) + `$E000` fija. `prg_offset`/`collect_switch_targets`/`generate` con 3 ventanas;
`NESMemory::prg_bank3` (ABI **v4**); `n2a_banked_block(pc, b0, b1, b2)` elige banco por rango de PC.
**Mr. Gimmick byte-exact** (RAM 0/2048). *Batman Return of the Joker*: framebuffer 0.0 % pero RAM
224/2048 (su **IRQ de FME-7 es por ciclo de CPU** → conviene incluirla en el scheduler, paso 3).

<details><summary>Plan original (referencia)</summary>

MMC3 tiene **dos ventanas conmutables de 8 KB** (`$8000-$9FFF`=R6, `$A000-$BFFF`=R7) + **dos fijas**
(`$C000-$DFFF`=n8-2, `$E000-$FFFF`=n8-1), y un **bit de modo** (R0 bit6) que las intercambia. El
modelo actual (1 conmutable + 1 fija) no basta. Cambios:

1. **Transpiler**: generalizar a **lista de ventanas** `{base, tamaño, fijo|conmutable}`; `prg_offset`
   con `(ventana, banco)`; `collect_switch_targets` por ventana; `generate()` itera `ventana × banco`;
   bloques `bbB<banco>_<addr>` (la dirección distingue la ventana).
2. **Runtime**: espejo de **dos** bancos (`prg_bank`=R6, `prg_bank2`=R7); el plugin elige tabla por
   rango de PC; **sentinela de modo** (R0 bit6) → fallback. **IRQ de raster A12** (ya modelada en el
   mapper) para el timing.
3. **Verificación**: `banks_test.sh` con `megaman3`/`smb3`/`kirby`.

Infraestructura ya lista: bancos, despacho disperso, `--trace`/`dbg_trace`, ticks, `fast_ticks`.

</details>

Auditando el código (métodos de `CPU` del codegen vs intérprete) se encontraron y **arreglaron 3
divergencias de fidelidad reales** (verificadas sin regresión: `CPU metodos OK`, `gen_frame NROM
codegen == interprete`, `RUNTIME OK`):

1. **`CPU::BRK`**: empujaba `PC+2`, pero el bloque **no mantiene el PC por instrucción** → dirección de
   retorno incorrecta si `BRK` no es la 1ª instrucción del bloque. Ahora el generado fija el PC real.
2. **NOP ilegales** (`0x0C`, `0x1C`, `0x04`…): el codegen no leía memoria; el intérprete **sí** (efecto
   de direccionamiento, p. ej. leer `$2002` limpia VBlank). Ahora leen.
3. **`(zp,X)`/`(zp),Y`**: el codegen no **envolvía** el puntero de página cero (`0xFF → 0x100`); el
   intérprete usa `& 0xFF`. Nuevo `NESMemory::read_zp16`.

Ninguno resolvió MMC1 → la causa está en otra parte (probable **decodificación del banco fijo** o
cobertura). **Revertido** MMC1 a "reconocido, no transpilado". Siguiente: un **trace
codegen↔intérprete** para localizar la primera divergencia de estado.

> Diagnóstico conservado: `N2A_MODE` en `tools/transpiler/tests/gen_frame.cpp` permite reproducir el
> análisis (fallback/fixed/banked) en cualquier ROM.

> **Ciclos**: los bloques por banco se emiten con la misma contabilidad de ciclos base; en el arnés
> `gen_frame` la diferencia de ciclos UxROM (≈41 500 en 60 frames) no afecta al **framebuffer**
> (0.0 %), que es la verificación fuerte. La equivalencia exacta de ciclos llegará con el scheduler
> (timing) fuera del alcance de F9.
