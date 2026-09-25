# Capa HLE — reconocimiento de intenciones (Fase 2)

Sobre el IR/C++ de la fase 1 (o sobre el binario 6502) se ejecuta un segundo analizador que busca
**patrones conocidos** y los reemplaza por llamadas a rutinas de alto nivel optimizadas para Amiga.
Cada juego nuevo puede enseñar patrones nuevos: el catálogo **crece de forma incremental**.

## Patrones reconocidos

| Patrón 6502 (simplificado) | Intención | Sustitución HLE |
|---|---|---|
| Escrituras a `$2005` (X,Y) | scroll | `hle_set_scroll(x, y)` → `BPLxPT` + `BPLCON1` + Copper |
| `STA $4014` | OAM DMA | `hle_oam_dma(addr)` → sprites HW + bobs |
| Serie de `STA $2007` tras `$2006` | escritura VRAM/nametable | `hle_vram_write(...)` / dirty tiles |
| Escrituras a registros de mapper | bankswitch | `hle_bankswitch(bank)` → punteros/tablas |
| Espera de sprite 0 hit | split de pantalla | `hle_sprite0_wait()` → Copper `WAIT` + cambio scroll |
| Bucles de copia de tiles | actualizar fondo | llamada directa a rutina Blitter |

## Dos vías de reconocimiento (combinables)

- **Estático** (sobre el IR/C++): secuencias de instrucciones y flujo de datos.
- **Dinámico asistido**: se ejecuta el transpilado en host instrumentado, se registran las
  secuencias reales de escrituras a PPU/mapper y se generan *superbloques* o trampolines.

Ejemplo de sustitución:

```cpp
// Antes (transpilado puro)
write(0x2005, cpu.A);
write(0x2005, cpu.X);

// Después (HLE)
hle_set_scroll(cpu.A, cpu.X);   // BPLxPT + BPLCON1 + Copper
```

## Rutinas `hle_*` (runtime Amiga)

Viven en [`../runtime/hle/`](../runtime/hle/README.md), escritas en C de bajo nivel o ensamblador
68000, usando Blitter, Copper, Dual Playfield y sprites hardware.

```cpp
// Firma común de un handler de registro
void hle_set_scroll(NESMemory&, uint8_t x, uint8_t y);
void hle_oam_dma  (NESMemory&, uint8_t page);
void hle_vram_write(NESMemory&, uint16_t addr, uint8_t value);
void hle_bankswitch(NESMemory&, uint8_t bank);
```

## Enganche

En `NESMemory::write`, un *lookup* por dirección devuelve el handler (o `nullptr` → fallback):

```cpp
void NESMemory::write(uint16_t addr, uint8_t value) {
    if (auto h = hle_lookup(addr, value)) {   // p.ej. $2005
        h(*this, addr, value);
        return;
    }
    // Fallback: PPU/APU software reconocen el registro
    fallback_write(addr, value);
}
```

## Cómo se conecta con los motores

- `$2005` → [`PPU_AMIGA.md`](PPU_AMIGA.md) (scroll) y [`COPPER.md`](COPPER.md).
- `$2007` (nametable/attribute) → `TileEngine::mark_tile_dirty` / `mark_attribute_dirty`.
- `$4014` / `$2004` → [`SPRITES_AMIGA.md`](SPRITES_AMIGA.md).
- `$4000-$4017` → [`AUDIO_AMIGA.md`](AUDIO_AMIGA.md).
- Mapper → [`MAPPERS.md`](MAPPERS.md).

## Reglas de oro

1. **El estado emulado es único** (VRAM, OAM, paletas, scroll, registros): HLE y fallback leen y
   escriben el mismo estado; el hardware Amiga es una *vista*.
2. **Confianza explícita**: un patrón se sustituye solo con suficiente evidencia; si no, fallback.
3. **Depurable**: se puede desactivar un handler concreto para comparar HLE vs fallback
   (validación diferencial, [`VALIDATION.md`](VALIDATION.md)).

## Medición

Se instrumenta el ratio de escrituras resueltas por HLE frente al total por frame; el hito M8 exige
≥80 % en el vertical slice. Cada handler documenta su coste (ciclos) frente al fallback.
