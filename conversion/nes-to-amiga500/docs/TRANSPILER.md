# Transpilador estático 6502 → C++23 (Fase 1)

Programa de **host** (C++23, multiplataforma: g++/clang/MSVC) que recibe una ROM iNES/NES 2.0 y
genera C++23 **legible y depurable**, pensado para que un compilador moderno (g++ 15.x, clang,
`m68k-amiga-elf-g++`) lo optimice a código casi nativo 68000. Evita el coste por instrucción de un
intérprete.

> Salida esperada en [`../generated/`](../generated/README.md). Código del programa en
> [`../tools/transpiler/`](../tools/transpiler/README.md).

## Pipeline

```
ROM (.nes)
  ↓
Parser iNES / NES 2.0        → header + PRG banks + CHR + mapper
  ↓
Extracción de PRG-ROM        → bytes + información de banking
  ↓
Análisis estático
  ├── vectores (Reset, NMI, IRQ)
  ├── desensamblado recursivo → CFG
  ├── basic blocks (leaders)
  ├── saltos indirectos / código automodificable (lo que se pueda)
  └── liveness de flags y registros
  ↓
Generación de C++
  ├── un .cpp por banco (o uno grande por secciones)
  ├── tablas de despacho por dirección / banco
  ├── código de arranque e interrupciones
  └── ganchos HLE (fase 2)
```

## Estructuras internas

```cpp
enum class AddrMode {
    Imp, Imm, Zp, ZpX, ZpY, Abs, AbsX, AbsY, Ind, IndX, IndY, Rel
};

struct OpcodeInfo { std::string_view mnemonic; AddrMode mode; int size; };

struct Instruction {
    uint16_t addr; uint8_t opcode;
    std::string_view mnemonic; AddrMode mode; int size;
    std::optional<uint16_t> operand;
    std::optional<uint16_t> target;   // branches y JMP/JSR absolutos
};

struct BasicBlock { uint16_t start; std::vector<Instruction> instructions; };
```

La tabla de opcodes cubre **todos los oficiales** + los **ilegales frecuentes** (NOP de varios
tamaños, `LAX`, `SAX`, `DCP`, `ISB`, `SLO`, `RLA`, `SRE`, `RRA`). Formato: `{opcode, {mnemónico, modo, tamaño}}`.

## Diseño de la clase `CPU`

El transpilador emite llamadas con **el nombre del mnemónico** y sufijo de modo, para que el C++
se lea casi como el listado del desensamblador y sea fácil de reconocer en la fase HLE:

```cpp
class CPU {
public:
    uint8_t  A = 0, X = 0, Y = 0, SP = 0xFD;
    uint16_t PC = 0;
    bool C = false, Z = false, I = false, D = false, V = false, N = false;

    uint8_t read(uint16_t addr);            // punto de enganche HLE/fallback
    void    write(uint16_t addr, uint8_t v);

    // Un método por mnemónico+modo (los usa el código generado)
    void LDA_imm(uint8_t v);  void LDA_zp(uint8_t a);  void LDA_zpx(uint8_t a);
    void LDA_abs(uint16_t a); void LDA_absx(uint16_t a); void LDA_absy(uint16_t a);
    void STA_abs(uint16_t a); void INX(); void BNE(int8_t rel);
    // ... resto del ISA oficial + ilegales
};
```

Recomendación (seguida): **métodos de instancia** (`cpu.LDA(...)`) en lugar de funciones libres:
mejor encapsulación, permite hooks (ciclos, tracing, HLE) dentro de cada instrucción, y el
compilador los inlinea.

Ejemplo de implementación interna (los flags se actualizan donde toca, no por separado):

```cpp
void CPU::LDA(uint8_t v) { A = v; Z = (A == 0); N = (A & 0x80) != 0; }
void CPU::STA_abs(uint16_t a) { write(a, A); }
void CPU::INX() { ++X; Z = (X == 0); N = (X & 0x80) != 0; }
void CPU::BNE(int8_t rel) { if (!Z) PC += rel; }
```

## Forma del código generado

Por defecto: **una función por basic block + `goto` a etiquetas locales**, y salto directo a otro
bloque conocido cuando el destino es estático:

```cpp
static constexpr std::array<uint8_t, /*N*/> PRG_ROM = { /* … */ };

static void bb_C000(CPU& cpu) {
L_C000:
    cpu.LDA_imm(0x23);        // $C000: LDA #$23
    cpu.STA_abs(0x2005);      // $C002: STA $2005  (scroll)
    cpu.INX();                // $C005: INX
    if (!cpu.Z) goto L_C000;  // $C006: BNE $C000
    cpu.RTS();                // $C007
    return;
}
```

Despacho por dirección (para saltos indirectos, interrupciones y entrada desde fuera de un bloque).
Es **disperso** (no una tabla densa de 64K punteros): una entrada `{dirección, ciclos, fn}` por bloque,
**ordenada** + **búsqueda binaria** (barato en RAM: `.bss = 0`):

```cpp
using BlockFn = void (*)(CPU&);
struct Block { eng::u16 start; eng::u16 cycles; BlockFn fn; };
static const Block kFixedBlocks[] = { { 0xC000, 7, bb_C000 }, /* … */ };
static const eng::u16 kFixedCount = /* nº de bloques */;

static BlockFn n2a_fixed_block(eng::u16 pc) {   // búsqueda binaria
    eng::u16 lo = 0, hi = kFixedCount;
    while (lo < hi) {
        const eng::u16 mid = lo + (hi - lo) / 2;
        if (kFixedBlocks[mid].start == pc) return kFixedBlocks[mid].fn;
        if (kFixedBlocks[mid].start < pc) lo = mid + 1; else hi = mid;
    }
    return nullptr;
}

void game_reset(CPU& cpu) {
    cpu.PC = cpu.read16(0xFFFC);
    while (true) {
        auto fn = n2a_fixed_block(cpu.PC);
        if (fn) fn(cpu);
        else    interpret_one_instruction(cpu);   // fallback
    }
}
```

## Estrategias de salto (configurables)

| Modo | Cuándo | Ventaja | Riesgo |
|---|---|---|---|
| **Funciones + `[[gnu::musttail]]`** | por defecto en saltos hacia atrás/cruzados | legible; sin crecer la pila | depende del soporte de *tail calls* |
| **Función única + etiquetas + `goto`** | opción de máximo rendimiento | el compilador ve el CFG completo (LCTM, unroll) | una función gigante |
| **Computed goto** (`&&label`) | muchos saltos indirectos / `PC` vivo | lo más rápido | extensión GCC/Clang |

Regla práctica:
- destino **estático conocido** → `goto`/llamada directa;
- destino **indirecto o desconocido** → `cpu.PC = destino; return;` al *dispatcher*;
- `JMP ($00xx)` y código automodificable → siempre al *dispatcher* (o intérprete).

## Optimizaciones que habilita el diseño

| Acceso | Optimizable | Técnica |
|---|---|---|
| Lectura de PRG-ROM | sí, mucho | `constexpr` + constant propagation/folding, tablas en `.rodata` |
| Zero Page / RAM | parcial | promoción a registro/constante si el flujo lo permite |
| Registros PPU/APU (`$200x`) | poco | efecto secundario; pasa por `read`/`write` (y por HLE) |
| Registros de mapper | depende | si el reconocedor/análisis dinámico los captura |
| **Flags** | sí | *liveness*: calcular `Z`/`N`/`V` solo si se usan |

Los `Expression Templates` **no** se usan para control de flujo (empeoran la legibilidad sin
ganancia); si acaso, para el cálculo de flags/ALU. El cuello de botella está en memoria y saltos.

## Salida

- `game_bank0.cpp … game_bankN.cpp` (o un único `generated_game.cpp` en NROM).
- Tablas de despacho por banco/dirección y de vectores (`reset`/`nmi`/`irq`).
- Código de arranque que inicializa `CPU`/`NESMemory` y salta al vector de reset.
- Los handlers de interrupción son *basic blocks* normales o trampolines que actualizan `cpu.PC`.

## Compilación

```bash
# Host (Linux/MinGW)
g++     -std=c++23 -O2 -o nes_transpiler src/*.cpp
clang++ -std=c++23 -O2 -o nes_transpiler src/*.cpp
# Visual Studio (Developer Command Prompt)
cl /std:c++latest /EHsc /O2 src\*.cpp

# Uso
nes_transpiler juego.nes -o generated/game.cpp
```

## Limitaciones del prototipo (a cerrar en F2/F9)

- Mappers: NROM (0), CNROM (3), **UxROM (2)**, **MMC1 (1, modo 16K)** y **MMC3 (4)**. Se transpila por
  **banco** (bloques `bbB<b>_<addr>`) con despacho por banco (`NESMemory::prg_bank`/`prg_bank2`); si
  una dirección no tiene bloque, cae al **intérprete**. Verificado **byte-exact** (`banks_test.sh`, 11
  ROMs): Contra/Castlevania (UxROM), Metroid/MM2/Blaster Master (MMC1), Mega Man 3/4/SMB3/Crystalis/
  Tiny Toon/Metal Storm (MMC3). MMC5/VRC6/FME-7 **se reconocen** pero aún no se transpilan. Diseño:
  [`TRANSPILER_BANKING.md`](TRANSPILER_BANKING.md) (B0–B2 + B3a MMC1 + B3b MMC3 hechos).
- No detecta todavía **código automodificable** complejo ni todos los saltos indirectos → fallback.
- `JSR/RTS` requieren un modelo de pila real en el runtime (push/pop de retorno).
- Los ciclos se cuentan por bloque (aproximado) para alimentar PPU/APU.

Reconocimiento de intenciones (fase 2) en [`HLE.md`](HLE.md); mappers en [`MAPPERS.md`](MAPPERS.md).
