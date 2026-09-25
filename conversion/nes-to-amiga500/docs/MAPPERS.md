# Mappers y bankswitching

La mayoría de juegos comerciales usan un **mapper**. El transpilador no puede traducir el PRG "de
una vez": hay que soportar **cambio de banco** en tiempo de ejecución (parches / recompilación
parcial). Se empieza por los mappers más simples.

## Orden de soporte

| Mapper | Nombre | Uso típico | Complejidad |
|---|---|---|---|
| 0 | NROM | Super Mario Bros. | muy baja |
| 2 | UxROM | Mega Man, Castlevania | baja |
| 3 | CNROM | CHR bank switch | baja |
| 1 | MMC1 | muchos mid/late | media |
| 4 | MMC3 | SMB3, etc. (+ IRQ scanline) | alta |

## Interfaz

```cpp
class Mapper {
public:
    virtual ~Mapper() = default;
    virtual uint8_t read(uint16_t addr) = 0;               // $4020-$FFFF
    virtual void    write(uint16_t addr, uint8_t value) = 0;
    virtual uint8_t chr_read(uint16_t addr) = 0;           // para el PPU (CHR)
    virtual void    chr_write(uint16_t, uint8_t) {}
    virtual bool    irq_pending() const { return false; }
    virtual void    clear_irq() {}
    virtual void    scanline_clock() {}                    // MMC3
};
```

### NROM (0)

```cpp
class Mapper0 : public Mapper {
    uint8_t read(uint16_t a) override {
        if (a >= 0x8000) return prg_[(a - 0x8000) % prg_.size()];
        return 0;
    }
    void write(uint16_t, uint8_t) override {}              // sin registros
    uint8_t chr_read(uint16_t a) override { return chr_[a % chr_.size()]; }
    std::span<const uint8_t> prg_, chr_;
};
```

### UxROM (2)

```cpp
class Mapper2 : public Mapper {
    uint8_t read(uint16_t a) override {
        if (a >= 0xC000) return prg_[(a - 0xC000) + (prg_.size() - 0x4000)];  // fijo (último)
        if (a >= 0x8000) return prg_[(a - 0x8000) + bank_ * 0x4000];          // conmutable
        return 0;
    }
    void write(uint16_t a, uint8_t v) override { if (a >= 0x8000) bank_ = v & 0x0F; }
    uint8_t chr_read(uint16_t a) override { return chr_[a]; }
    int bank_ = 0;
};
```

## Bankswitching con código transpilado

Traducir el PRG entero en la dirección de CPU correcta **no es posible** si el mismo rango
`$8000-$BFFF` cambia de contenido. Estrategias:

1. **Bloques por banco**: el transpilador emite `bb_<banco>_<addr>` y una tabla de despacho
   `dispatch[banco][addr]`. Al escribir el registro del mapper se cambia el banco activo y con él
   la tabla usada por el *dispatcher*.
2. **Bancos fijos** (p. ej. `$C000-$FFFF`): un solo conjunto de bloques.
3. **Recompilación parcial / parches**: si un patrón HLE cubre una rutina de otro banco, se parchea
   el punto de entrada en la tabla sin recompilar todo.
4. **Fallback**: bloques no resueltos o direcciones que dependen del banco se ejecutan con el
   intérprete leyendo a través del mapper.

```cpp
using BasicBlockFn = void(*)(CPU&);
extern BasicBlockFn dispatch_bank0[MAX_PRG];
extern BasicBlockFn dispatch_bank1[MAX_PRG];
BasicBlockFn* active_dispatch = dispatch_bank0;

void hle_bankswitch(NESMemory& mem, uint8_t bank) {
    mem.mapper->write(0x8000, bank);
    active_dispatch = tables_for(mem.mapper->current_bank());
}
```

## IRQ de mapper (MMC3)

MMC3 genera una IRQ de scanline que muchos juegos usan para splits. El runtime debe:
- relojear el contador A12 (`scanline_clock()`) desde el PPU/scanline;
- exponer `irq_pending()`/`clear_irq()` para que la CPU 6502 las atienda;
- o, mejor, reconocer el patrón y sustituirlo por un `hle_sprite0_wait`/Copper (ver
  [`HLE.md`](HLE.md) y [`COPPER.md`](COPPER.md)).

## Detección de banco en el análisis

El desensamblado recursivo se hace **por banco** (los puntos de entrada de un banco pueden no ser
válidos en otro). Para NROM/UxROM/CNROM se puede hacer casi todo estático; MMC1/MMC3 requieren
análisis dinámico (trazas en host) para descubrir qué bancos se ejecutan.

## Cierre (F9)

- 2 juegos por mapper NROM/UxROM/CNROM y 1 por MMC1/MMC3 arrancan y son jugables.
- IRQ de MMC3 sincronizada con el render.
- Documentado el coste de cada bankswitch (trampolín vs intérprete).
