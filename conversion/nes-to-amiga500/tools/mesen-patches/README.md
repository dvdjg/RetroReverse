# Parche de referencia en mesen (`MESEN_TRACE` / volcado `RRS1`)

El core `external/libretro-mesen/` está **gitignoreado** (`.gitignore:93`), así que estas
modificaciones —que son **nuestras** y sirven para validar el oráculo— no se versionan. Esta nota
las documenta para poder **re-aplicarlas tras un re-descubrimiento del core**.

## Fichero y punto de inserción

`external/libretro-mesen/Core/CPU.cpp`, **dentro de `CPU::Exec()`**, justo **después** de
`uint8_t opCode = GetOPCode();` y **antes** de `_instAddrMode = _addrMode[opCode];`. Son dos bloques
independientes:

1. **Traza de CPU** → `$MESEN_TRACE` (14 B/inst): `PClo,PChi,op,A,X,S,cyc(4 LE),ppu(4 LE)`.
   La consume `runtime/test/trace_diff.py` (formato ref 14 B). Límite 4 000 000 instrucciones.
2. **Volcado de estado `RRS1`** → `$MESEN_STATE` en el primer ciclo de CPU del frame
   `$MESEN_DUMP_FRAME`. Formato: `"RRS1"` + `frameCycle(4)` + `scanline(4)` + `cycle(4)` +
   `cpuCycles(8)` + `flags(4)` + regs(8) + paleta(0x20) + OAM(0x100) + RAM(0x800) + 4×nametable(0x400)
   = **6468 B**.

## Corrección crítica del volcado de nametables (2026)

El volcado original leía las nametables con:

```cpp
nm[o] = ppu->PeekRAM((uint16_t)(0x2000 + nt * 0x400 + o));   // MAL
```

`PPU::PeekRAM` usa `GetRegisterID(addr) = addr & 0x07` (`Core/PPU.h:163`), así que para
`$2000-$3FFF` devuelve **los registros PPU repetidos** (Control/Mask/Status/OAMAddr/SpriteData/
Scroll/VideoMemoryAddr/VideoMemoryData), **no** la nametable. Por eso las 4 salían idénticas (patrón
`90 90 10 90 f8 …`). Sustituido por la **nametable RAM real** del mapper:

```cpp
nm[o] = mp->GetMemoryValue(DebugMemoryType::NametableRam, (uint32_t)(nt * 0x400 + o));
```

donde `BaseMapper *mp = _console->GetMapper();` y `DebugMemoryType` viene de
`Core/DebuggerTypes.h` (incluido transitivamente). Con este cambio, mesen NT0/NT3 coinciden con
nuestra nametable efectiva.

## Compilación

```sh
cd external/libretro-mesen/Libretro && make -j4      # produce mesen_libretro.so
```

(Core Mesen-S libretro; `platform=unix` por defecto en WSL. ~minutos.)

## Uso

```sh
# Traza (¡usar --det 0! la comprobación de determinismo rebobina el core y mezcla pasadas):
MESEN_TRACE=/tmp/ref.trace external/.../vertical_slice \
    --core .../mesen_libretro.so --rom <rom> --out /tmp/o --frames N --interval 0 --det 0
# Volcado de estado:
MESEN_DUMP_FRAME=60 MESEN_STATE=/tmp/state.rrs ... (mismo comando)
```

`--det 0` es **imprescindible**: sin él, `vertical_slice` hace `save_state`/`load_state` y el core
**retrocede** (el `_cycleCount` de la traza reinicia → varias pasadas mezcladas).
