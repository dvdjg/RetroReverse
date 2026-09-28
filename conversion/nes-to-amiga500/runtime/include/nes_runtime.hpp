#pragma once

/// \file nes_runtime.hpp
/// Runtime mínimo del nodo NES→Amiga 500: memoria de consola (`NESMemory`) y CPU
/// 6502 (`CPU`) que ejecutan el código generado por el transpilador.
///
/// ## Uso
/// El header es autónomo. El cargador —el `game_main()` del fichero generado o el
/// arnés de tests— enlaza la PRG-ROM asignando `NESMemory::prg` y `prg_size`:
/// \code
/// #include "nes_runtime.hpp"
/// mem.prg = rom_prg;        // bytes de la PRG ($8000-$FFFF)
/// mem.prg_size = rom_len;
/// \endcode
///
/// ## Estado y alcance (F1)
/// Implementa solo lo que necesitan los *basic blocks* generados: registros,
/// flags, pila, modos de direccionamiento y las familias de instrucciones
/// (oficiales + ilegales frecuentes). **No** modela todavía PPU, APU ni mappers:
/// eso son las fases F3 (PPU/APU software), F7 (audio) y F9 (mappers) del
/// [`../../docs/ROADMAP.md`](../../docs/ROADMAP.md). La exactitud ciclo a ciclo y
/// la validación con `nestest` son el siguiente paso de F1.
///
/// ## Recursos
/// Sin memoria dinámica ni STL: solo `eng/core` (tipos) y estado en pila/estática.
/// Pensado para compilar igual en host (tests) y en `m68k` (Amiga 500).

#include <eng/core/types/types.hpp>

/// Declara una **suposición** que el compilador puede usar para optimizar:
/// equivale a afirmar que `x` es siempre cierta en ese punto. Si no lo fuera, el
/// comportamiento es indefinido (como `[[assume]]` de C++23).
///
/// Lo emite el transpilador a partir de hechos de valores (fichero `--facts`):
/// p. ej. "esta dirección de RAM solo toma el valor 2" permite a g++ plegar
/// ramas y aritmética. En compiladores sin soporte queda como no-op.
#if defined(_MSC_VER)
#define N2A_ASSUME(x) __assume(x)
#elif defined(__has_builtin)
#if __has_builtin(__builtin_assume)
#define N2A_ASSUME(x) __builtin_assume(x)
#else
#define N2A_ASSUME(x) ((void)0)
#endif
#else
#define N2A_ASSUME(x) ((void)0)
#endif

namespace n2a {

/// Memoria de consola para un programa NROM: RAM interna de 2 KB y lectura de la
/// PRG-ROM de la ROM generada.
///
/// La PRG-ROM y su tamaño (`kPrgSize`) los aporta el fichero generado que incluye
/// este header (ver contrato de inclusión).
struct NESMemory {
	/// RAM interna de la consola: 2 KB en `$0000-$07FF`, espejada hasta `$1FFF`.
	eng::u8 ram[0x800] {};
	/// Registros de la PPU (`$2000-$2007`, espejados hasta `$3FFF`). En F1 solo se
	/// almacenan; la PPU real es F3.
	eng::u8 ppu_regs[8] {};
	/// Registros de APU y E/S (`$4000-$401F`).
	eng::u8 io[0x20] {};
	/// RAM del cartucho (`$6000-$7FFF`); NROM no la usa, pero se conserva.
	eng::u8 prg_ram[0x2000] {};
	/// Puntero a la PRG-ROM mapeada en `$8000-$FFFF` (observador, no propietario).
	const eng::u8* prg = nullptr;
	/// Tamaño de la PRG-ROM en bytes: 16 KB se espeja, 32 KB no.
	eng::u32 prg_size = 0;
	/// **Banco de PRG activo** (espejo del estado del mapper), para el despacho
	/// del código transpilado por banco: el plugin lo lee para elegir la tabla de
	/// bloques de la ventana conmutable. UxROM/MMC1: banco de `$8000-$BFFF`.
	/// MMC3: banco R6 de `$8000-$9FFF`. El sistema lo mantiene al día en cada
	/// conmutación. NROM/CNROM: 0.
	eng::u8 prg_bank = 0;
	/// **Segundo banco** de la ventana conmutable: MMC3 = banco R7 de
	/// `$A000-$BFFF`. Otros mappers: 0.
	eng::u8 prg_bank2 = 0;
	/// **Tercer banco**: FME-7/MMC5 = banco de `$C000-$DFFF`. Otros mappers: 0.
	eng::u8 prg_bank3 = 0;
	/// **Cuarto banco**: MMC5 (modo 3) = banco de `$E000-$FFFF`. Otros mappers: 0.
	eng::u8 prg_bank4 = 0;

	// --- Hooks opcionales del sistema (PPU/APU/mapper/input) ---
	/// Cookie que se pasa a los hooks de E/S.
	void* io_user = nullptr;
	/// Si no es `nullptr`, atiende las lecturas de `$2000-$FFFF` (sistema real).
	eng::u8 (*io_read)(void*, eng::u16) = nullptr;
	/// Si no es `nullptr`, atiende las escrituras de `$2000-$FFFF`.
	void (*io_write)(void*, eng::u16, eng::u8) = nullptr;

	/// Hook opcional de **avance de reloj de bus**: si no es `nullptr`, el
	/// intérprete lo llama con el nº de ciclos antes de cada acceso de bus
	/// (`fetch`/`rd`/`wr`/`push`/`pull`) y con los ciclos internos restantes al
	/// final de la instrucción. Así la PPU se reloja **en el ciclo exacto** de cada
	/// acceso (dot-exacto), no tras terminar la instrucción.
	void (*cycle_tick)(void*, int) = nullptr;
	/// Cookie pasada a `cycle_tick`.
	void* cycle_user = nullptr;

	/// Avanza el reloj de bus `n` ciclos (no hace nada si no hay hook).
	/// \param n Ciclos a avanzar (>= 0; por defecto 1).
	void tick(int n = 1) const {
		if (cycle_tick != nullptr && n > 0) {
			cycle_tick(cycle_user, n);
		}
	}

	/// Lee el byte de la dirección `addr` del espacio de 64 KB, imitando el bus de
	/// la NES:
	/// - `$0000-$1FFF`: RAM interna (espejo de 2 KB);
	/// - `$2000-$3FFF`: registros de PPU (espejo de 8);
	/// - `$4015` y `$4000-$401F`: APU y E/S;
	/// - `$6000-$7FFF`: RAM del cartucho;
	/// - `$8000-$FFFF`: PRG-ROM (espejo de 16 KB si `prg_size == 0x4000`);
	/// - cualquier otra: 0.
	///
	/// \param addr Dirección de 16 bits.
	/// \return El byte leído. No tiene efectos secundarios.
	[[nodiscard]] eng::u8 read(eng::u16 addr) const {
		if (addr < 0x2000u) {
			return ram[addr & 0x7FFu];
		}
		if (io_read != nullptr) {
			return io_read(io_user, addr);
		}
		if (addr < 0x4000u) {
			return ppu_regs[addr & 0x07u];
		}
		if (addr == 0x4015u) {
			return io[0x15u];
		}
		if (addr < 0x4020u) {
			return io[addr - 0x4000u];
		}
		if (addr >= 0x8000u && prg != nullptr && prg_size != 0u) {
			// Los tamaños de PRG de los mappers NES son **potencias de dos**
			// (8/16/32/64 KB), así que el espejo `idx % prg_size` es una máscara.
			// Se evita el `%` porque en 68000 genera la libcall `__umodsi3`, que
			// no existe con `-nostdlib` (ver `m68k-gcc.md` §2).
			const eng::usize idx =
				static_cast<eng::usize>(addr - 0x8000u) &
				(static_cast<eng::usize>(prg_size) - 1u);
			return prg[idx];
		}
		if (addr >= 0x6000u && addr < 0x8000u) {
			return prg_ram[addr - 0x6000u];
		}
		return 0u;
	}

	/// Escribe el byte `value` en `addr` con el mismo reparto que `read`: RAM,
	/// registros de PPU y APU/E/S, y RAM de cartucho. La PRG-ROM es de solo
	/// lectura y se ignora.
	///
	/// \param addr  Dirección destino de 16 bits.
	/// \param value Byte a escribir.
	void write(eng::u16 addr, eng::u8 value) {
		if (addr < 0x2000u) {
			ram[addr & 0x7FFu] = value;
			return;
		}
		if (io_write != nullptr) {
			io_write(io_user, addr, value);
			return;
		}
		if (addr < 0x4000u) {
			ppu_regs[addr & 0x07u] = value;
			return;
		}
		if (addr < 0x4020u) {
			io[addr - 0x4000u] = value;
			return;
		}
		if (addr >= 0x6000u && addr < 0x8000u) {
			prg_ram[addr - 0x6000u] = value;
			return;
		}
	}

	/// Lee una palabra de 16 bits en formato little-endian.
	///
	/// Se usa para operandos absolutos e indirecciones (p. ej. `JMP ($xxyy)`).
	///
	/// \param addr Dirección del byte bajo; el alto se lee en `addr + 1`.
	/// \return `read(addr) | (read(addr + 1) << 8)`.
	[[nodiscard]] eng::u16 read16(eng::u16 addr) const {
		return static_cast<eng::u16>(read(addr) |
			       (static_cast<eng::u16>(read(static_cast<eng::u16>(addr + 1u))) << 8));
	}

	/// Lee un puntero de **página cero** con **envoltura** (`(zp+1) & 0xFF`), como
	/// el 6502 real y el intérprete: lo usan `(zp,X)` y `(zp),Y`. Sin envolver, un
	/// `zp = 0xFF` leería el byte alto en `$0100` (pila) en vez de `$0000`.
	/// \param zp Dirección de página cero del puntero.
	/// \return Puntero little-endian con el byte alto envuelto en la página cero.
	[[nodiscard]] eng::u16 read_zp16(eng::u8 zp) const {
		return static_cast<eng::u16>(
			read(zp) | (static_cast<eng::u16>(read(static_cast<eng::u8>(zp + 1u))) << 8u));
	}
};

/// CPU 6502 (2A03 sin decimal) del runtime.
///
/// Expone un método por **mnemónico + sufijo de modo** (`LDA_abs`, `STA_zp`,
/// `ADC_imm`, `ASL_A`, `JSR_abs`…). El código generado llama a esos métodos, de
/// modo que cada línea se lee como el desensamblador y la capa HLE puede
/// reconocer patrones (`docs/HLE.md`).
///
/// Convenciones:
/// - Los métodos que cargan/transforman un registro actualizan los flags `N`/`Z`.
/// - Los métodos de memoria reciben la **dirección efectiva ya calculada** (el
///   modo de direccionamiento resuelve los índices X/Y y los punteros).
/// - `CMP`/`CPX`/`CPY` y las operaciones ALU actualizan `C`/`V`/`N`/`Z` según el 6502.
struct CPU {
	/// Acumulador (8 bits).
	eng::u8 A = 0;
	/// Registro índice X (8 bits).
	eng::u8 X = 0;
	/// Registro índice Y (8 bits).
	eng::u8 Y = 0;
	/// Puntero de pila: offset dentro de la página `$0100`. Arranca en `$FD`.
	eng::u8 SP = 0xFD;
	/// Contador de programa: dirección 6502 del bloque que se está ejecutando.
	eng::u16 PC = 0;
	/// Flags del 6502: carry, zero, IRQ-disable, decimal, overflow y negativo.
	bool C = false, Z = false, I = false, D = false, V = false, N = false;
	/// Se pone a `true` tras `BRK`; `game_main()` lo usa para terminar el bucle.
	bool halted = false;
	/// Si `true`, `BRK` detiene la ejecución (`halted`, `PC=0`), usado por el
	/// harness standalone. El runtime (`NesSystem`) lo pone a `false` para que
	/// `BRK` siga la semántica del intérprete (salta al vector IRQ), de modo que el
	/// código generado y el intérprete coincidan.
	bool brk_halts = true;
	/// Ciclos de CPU acumulados que el **código generado** incrementa con el coste
	/// exacto de cada instrucción (base + penalización de página/rama). El runtime
	/// lee su delta por bloque para avanzar la PPU con la misma temporalización que
	/// el intérprete. El intérprete/ejecutor rápido no lo usan (calculan sus ciclos
	/// aparte), así que en esos caminos permanece a 0.
	eng::u32 cycles = 0;
	/// **Deadline del `yield` por evento** (docs/TIMING_CODEGEN.md): el código
	/// generado cede (guarda `PC` y retorna) cuando `cycles >= deadline`. El host lo
	/// fija a `cycles + next_event_dots()/3` antes de cada bloque. `0xFFFFFFFF` =
	/// nunca (sin host que lo fije).
	eng::u32 deadline = 0xFFFFFFFFu;
	/// Memoria asociada (observador, no propietario). La enlaza `game_main()`.
	NESMemory* mem = nullptr;
	/// **Cesión al runtime** desde código **encadenado**: un bloque que no puede
	/// progresar (espera de VBlank/NMI) lo pone a `true` antes de `return`. El bucle
	/// de ejecución, tras volver de un bloque/subrutina, comprueba `yield`, resuelve
	/// los eventos (NMI/PPU) y re-despacha en `PC`. Se coloca **al final** del struct
	/// para no alterar los offsets que usa el asm de `n2a_*_run`/`read`/`mem`.
	bool yield = false;

	/// Actualiza `Z` (resultado nulo) y `N` (bit 7) a partir de `v`.
	/// Lo usan todas las operaciones que cargan o transforman A, X o Y.
	/// \param v Resultado de 8 bits recién calculado.
	void set_nz(eng::u8 v) { Z = (v == 0u); N = (v & 0x80u) != 0u; }

	/// Apila `v` en la pila de la página `$0100` y decrementa `SP`.
	/// \param v Byte a apilar.
	void push(eng::u8 v) { mem->ram[0x100u + static_cast<eng::usize>(SP)] = v; --SP; }

	/// Desapila un byte (incrementa `SP`) y lo devuelve.
	/// \return Byte en la cima de la pila.
	eng::u8 pull() { ++SP; return mem->ram[0x100u + static_cast<eng::usize>(SP)]; }

	/// Apila una palabra: primero el byte alto y luego el bajo (como `JSR`/`BRK`).
	/// \param v Palabra a apilar.
	void push16(eng::u16 v) {
		push(static_cast<eng::u8>(v >> 8u));
		push(static_cast<eng::u8>(v & 0xFFu));
	}

	/// Desapila una palabra little-endian (lo primero) y la devuelve.
	/// \return Palabra desapilada.
	eng::u16 pull16() {
		const eng::u8 lo = pull();
		const eng::u8 hi = pull();
		return static_cast<eng::u16>(lo | (static_cast<eng::u16>(hi) << 8));
	}

	// --- Cargas: LDA / LDX / LDY -------------------------------------------
	// Genera, para el registro R indicado, un método por modo de direccionamiento.
	// Todos leen el operando efectivo, lo cargan en R y actualizan N/Z.
	//   NAME_imm / NAME_zp / NAME_zpx / NAME_zpy / NAME_abs / NAME_absx /
	//   NAME_absy / NAME_indx / NAME_indy
	// `a` es la dirección o el inmediato según el sufijo; los modos indexados
	// resuelven X o Y y los indX/indY leen el puntero de página cero.
#define N2A_LOAD(NAME, R) \
	void NAME##_imm(eng::u8 v) { R = v; set_nz(R); } \
	void NAME##_zp(eng::u8 a) { R = mem->read(a); set_nz(R); } \
	void NAME##_zpx(eng::u8 a) { R = mem->read(static_cast<eng::u8>(a + X)); set_nz(R); } \
	void NAME##_zpy(eng::u8 a) { R = mem->read(static_cast<eng::u8>(a + Y)); set_nz(R); } \
	void NAME##_abs(eng::u16 a) { R = mem->read(a); set_nz(R); } \
	void NAME##_absx(eng::u16 a) { R = mem->read(static_cast<eng::u16>(a + X)); set_nz(R); } \
	void NAME##_absy(eng::u16 a) { R = mem->read(static_cast<eng::u16>(a + Y)); set_nz(R); } \
	void NAME##_indx(eng::u8 a) { R = mem->read(mem->read_zp16(static_cast<eng::u8>(a + X))); set_nz(R); } \
	void NAME##_indy(eng::u8 a) { R = mem->read(static_cast<eng::u16>(mem->read_zp16(a) + Y)); set_nz(R); }
	N2A_LOAD(LDA, A)
	N2A_LOAD(LDX, X)
	N2A_LOAD(LDY, Y)
#undef N2A_LOAD

	// --- Almacenes: STA / STX / STY ---------------------------------------
	// Genera, para el registro R, un método por modo que escribe R en la
	// dirección efectiva. No modifican flags.
	//   NAME_zp / NAME_zpx / NAME_zpy / NAME_abs / NAME_absx / NAME_absy /
	//   NAME_indx / NAME_indy
#define N2A_STORE(NAME, R) \
	void NAME##_zp(eng::u8 a) { mem->write(a, R); } \
	void NAME##_zpx(eng::u8 a) { mem->write(static_cast<eng::u8>(a + X), R); } \
	void NAME##_zpy(eng::u8 a) { mem->write(static_cast<eng::u8>(a + Y), R); } \
	void NAME##_abs(eng::u16 a) { mem->write(a, R); } \
	void NAME##_absx(eng::u16 a) { mem->write(static_cast<eng::u16>(a + X), R); } \
	void NAME##_absy(eng::u16 a) { mem->write(static_cast<eng::u16>(a + Y), R); } \
	void NAME##_indx(eng::u8 a) { mem->write(mem->read_zp16(static_cast<eng::u8>(a + X)), R); } \
	void NAME##_indy(eng::u8 a) { mem->write(static_cast<eng::u16>(mem->read_zp16(a) + Y), R); }
	N2A_STORE(STA, A)
	N2A_STORE(STX, X)
	N2A_STORE(STY, Y)
#undef N2A_STORE

	// --- Núcleo de la ALU --------------------------------------------------
	/// Suma con acarreo: `A = A + v + C`. Actualiza `C`, `V`, `N` y `Z`.
	/// \param v Operando de 8 bits.
	void ADC_impl(eng::u8 v) {
		const eng::u16 s = static_cast<eng::u16>(A + v + (C ? 1u : 0u));
		C = (s > 0xFFu);
		const eng::u8 r = static_cast<eng::u8>(s);
		V = (((A ^ r) & (v ^ r) & 0x80u) != 0u);
		A = r;
		set_nz(A);
	}

	/// Resta con préstamo: `A = A - v - (1 - C)`. Actualiza `C`, `V`, `N` y `Z`.
	/// \param v Operando de 8 bits.
	void SBC_impl(eng::u8 v) {
		const eng::u8 nv = static_cast<eng::u8>(~v);
		const eng::u16 s = static_cast<eng::u16>(A + nv + (C ? 1u : 0u));
		C = (s > 0xFFu);
		const eng::u8 r = static_cast<eng::u8>(s);
		V = (((A ^ r) & (nv ^ r) & 0x80u) != 0u);
		A = r;
		set_nz(A);
	}

	/// `A = A & v`; actualiza `N` y `Z`.
	void AND_impl(eng::u8 v) { A = static_cast<eng::u8>(A & v); set_nz(A); }
	/// `A = A | v`; actualiza `N` y `Z`.
	void ORA_impl(eng::u8 v) { A = static_cast<eng::u8>(A | v); set_nz(A); }
	/// `A = A ^ v`; actualiza `N` y `Z`.
	void EOR_impl(eng::u8 v) { A = static_cast<eng::u8>(A ^ v); set_nz(A); }

	/// Compara un registro con `v` (resta descartando el resultado): fija `C`,
	/// `Z` y `N`.
	/// \param reg Valor del registro (A, X o Y).
	/// \param v   Operando a comparar.
	void CMP_impl(eng::u8 reg, eng::u8 v) {
		const eng::u8 r = static_cast<eng::u8>(reg - v);
		C = (reg >= v);
		Z = (r == 0u);
		N = (r & 0x80u) != 0u;
	}

	// Genera un método por modo para una operación ALU cuyo núcleo es `IMPL`
	// (ADC_impl, SBC_impl, AND_impl, ORA_impl o EOR_impl). El sufijo indica el
	// modo de direccionamiento.
#define N2A_ALU(NAME, IMPL) \
	void NAME##_imm(eng::u8 v) { IMPL(v); } \
	void NAME##_zp(eng::u8 a) { IMPL(mem->read(a)); } \
	void NAME##_zpx(eng::u8 a) { IMPL(mem->read(static_cast<eng::u8>(a + X))); } \
	void NAME##_zpy(eng::u8 a) { IMPL(mem->read(static_cast<eng::u8>(a + Y))); } \
	void NAME##_abs(eng::u16 a) { IMPL(mem->read(a)); } \
	void NAME##_absx(eng::u16 a) { IMPL(mem->read(static_cast<eng::u16>(a + X))); } \
	void NAME##_absy(eng::u16 a) { IMPL(mem->read(static_cast<eng::u16>(a + Y))); } \
	void NAME##_indx(eng::u8 a) { IMPL(mem->read(mem->read16(static_cast<eng::u8>(a + X)))); } \
	void NAME##_indy(eng::u8 a) { IMPL(mem->read(static_cast<eng::u16>(mem->read16(a) + Y))); }
	N2A_ALU(ADC, ADC_impl)
	N2A_ALU(SBC, SBC_impl)
	N2A_ALU(AND, AND_impl)
	N2A_ALU(ORA, ORA_impl)
	N2A_ALU(EOR, EOR_impl)
#undef N2A_ALU

	// Genera un método por modo para CMP/CPX/CPY, comparando el registro `R`
	// con el operando efectivo.
#define N2A_CMP(NAME, R) \
	void NAME##_imm(eng::u8 v) { CMP_impl(R, v); } \
	void NAME##_zp(eng::u8 a) { CMP_impl(R, mem->read(a)); } \
	void NAME##_zpx(eng::u8 a) { CMP_impl(R, mem->read(static_cast<eng::u8>(a + X))); } \
	void NAME##_zpy(eng::u8 a) { CMP_impl(R, mem->read(static_cast<eng::u8>(a + Y))); } \
	void NAME##_abs(eng::u16 a) { CMP_impl(R, mem->read(a)); } \
	void NAME##_absx(eng::u16 a) { CMP_impl(R, mem->read(static_cast<eng::u16>(a + X))); } \
	void NAME##_absy(eng::u16 a) { CMP_impl(R, mem->read(static_cast<eng::u16>(a + Y))); } \
	void NAME##_indx(eng::u8 a) { CMP_impl(R, mem->read(mem->read16(static_cast<eng::u8>(a + X)))); } \
	void NAME##_indy(eng::u8 a) { CMP_impl(R, mem->read(static_cast<eng::u16>(mem->read16(a) + Y))); }
	N2A_CMP(CMP, A)
	N2A_CMP(CPX, X)
	N2A_CMP(CPY, Y)
#undef N2A_CMP

	// --- Desplazamientos ---------------------------------------------------
	/// `ASL` del acumulador: `C = bit 7`, `A <<= 1`, actualiza `N`/`Z`.
	void ASL_A() { C = (A & 0x80u) != 0u; A = static_cast<eng::u8>(A << 1u); set_nz(A); }
	/// `LSR` del acumulador: `C = bit 0`, `A >>= 1`, actualiza `N`/`Z`.
	void LSR_A() { C = (A & 1u) != 0u; A = static_cast<eng::u8>(A >> 1u); set_nz(A); }
	/// `ROL` del acumulador usando el carry entrante.
	void ROL_A() { const eng::u8 c = C ? 1u : 0u; C = (A & 0x80u) != 0u; A = static_cast<eng::u8>((A << 1u) | c); set_nz(A); }
	/// `ROR` del acumulador usando el carry entrante.
	void ROR_A() { const eng::u8 c = C ? 1u : 0u; C = (A & 1u) != 0u; A = static_cast<eng::u8>((A >> 1u) | (c << 7u)); set_nz(A); }
	/// `ASL` en memoria (`a` = dirección): lee, desplaza y escribe.
	void ASL_at(eng::u16 a) { eng::u8 v = mem->read(a); C = (v & 0x80u) != 0u; v = static_cast<eng::u8>(v << 1u); mem->write(a, v); set_nz(v); }
	/// `LSR` en memoria.
	void LSR_at(eng::u16 a) { eng::u8 v = mem->read(a); C = (v & 1u) != 0u; v = static_cast<eng::u8>(v >> 1u); mem->write(a, v); set_nz(v); }
	/// `ROL` en memoria.
	void ROL_at(eng::u16 a) { eng::u8 v = mem->read(a); const eng::u8 c = C ? 1u : 0u; C = (v & 0x80u) != 0u; v = static_cast<eng::u8>((v << 1u) | c); mem->write(a, v); set_nz(v); }
	/// `ROR` en memoria.
	void ROR_at(eng::u16 a) { eng::u8 v = mem->read(a); const eng::u8 c = C ? 1u : 0u; C = (v & 1u) != 0u; v = static_cast<eng::u8>((v >> 1u) | (c << 7u)); mem->write(a, v); set_nz(v); }

	// Genera los modos zp / zpx / abs / absx de un desplazamiento a partir de su
	// variante en memoria `NAME_at`.
#define N2A_SHIFT_MODES(NAME) \
	void NAME##_zp(eng::u8 a) { NAME##_at(a); } \
	void NAME##_zpx(eng::u8 a) { NAME##_at(static_cast<eng::u8>(a + X)); } \
	void NAME##_abs(eng::u16 a) { NAME##_at(a); } \
	void NAME##_absx(eng::u16 a) { NAME##_at(static_cast<eng::u16>(a + X)); }
	N2A_SHIFT_MODES(ASL)
	N2A_SHIFT_MODES(LSR)
	N2A_SHIFT_MODES(ROL)
	N2A_SHIFT_MODES(ROR)
#undef N2A_SHIFT_MODES

	// --- Incremento / decremento en memoria --------------------------------
	/// Incrementa el byte en `a` y actualiza `N`/`Z`.
	void INC_at(eng::u16 a) { const eng::u8 v = static_cast<eng::u8>(mem->read(a) + 1u); mem->write(a, v); set_nz(v); }
	/// Decrementa el byte en `a` y actualiza `N`/`Z`.
	void DEC_at(eng::u16 a) { const eng::u8 v = static_cast<eng::u8>(mem->read(a) - 1u); mem->write(a, v); set_nz(v); }

	// Genera los modos zp / zpx / abs / absx de INC/DEC sobre memoria.
#define N2A_MEM_MODES(NAME) \
	void NAME##_zp(eng::u8 a) { NAME##_at(a); } \
	void NAME##_zpx(eng::u8 a) { NAME##_at(static_cast<eng::u8>(a + X)); } \
	void NAME##_abs(eng::u16 a) { NAME##_at(a); } \
	void NAME##_absx(eng::u16 a) { NAME##_at(static_cast<eng::u16>(a + X)); }
	N2A_MEM_MODES(INC)
	N2A_MEM_MODES(DEC)
#undef N2A_MEM_MODES

	/// Incrementa X; actualiza `N`/`Z`.
	void INX() { ++X; set_nz(X); }
	/// Incrementa Y; actualiza `N`/`Z`.
	void INY() { ++Y; set_nz(Y); }
	/// Decrementa X; actualiza `N`/`Z`.
	void DEX() { --X; set_nz(X); }
	/// Decrementa Y; actualiza `N`/`Z`.
	void DEY() { --Y; set_nz(Y); }

	/// Transfiere A → X; actualiza `N`/`Z`.
	void TAX() { X = A; set_nz(X); }
	/// Transfiere A → Y; actualiza `N`/`Z`.
	void TAY() { Y = A; set_nz(Y); }
	/// Transfiere X → A; actualiza `N`/`Z`.
	void TXA() { A = X; set_nz(A); }
	/// Transfiere Y → A; actualiza `N`/`Z`.
	void TYA() { A = Y; set_nz(A); }
	/// Transfiere SP → X; actualiza `N`/`Z`.
	void TSX() { X = SP; set_nz(X); }
	/// Transfiere X → SP (los flags no cambian).
	void TXS() { SP = X; }

	/// Apila el acumulador.
	void PHA() { push(A); }
	/// Desapila el acumulador; actualiza `N`/`Z`.
	void PLA() { A = pull(); set_nz(A); }
	/// Apila el registro de flags (con el bit B y el bit 5 a 1).
	void PHP() { push(static_cast<eng::u8>(0x30u | (N ? 0x80u : 0u) | (V ? 0x40u : 0u) | (D ? 0x08u : 0u) | (I ? 0x04u : 0u) | (Z ? 0x02u : 0u) | (C ? 0x01u : 0u))); }
	/// Desapila el registro de flags y restaura `N`/`V`/`D`/`I`/`Z`/`C`.
	void PLP() { const eng::u8 p = pull(); N = (p & 0x80u) != 0u; V = (p & 0x40u) != 0u; D = (p & 0x08u) != 0u; I = (p & 0x04u) != 0u; Z = (p & 0x02u) != 0u; C = (p & 0x01u) != 0u; }

	/// Limpia el carry (`C = 0`).
	void CLC() { C = false; }
	/// Pone el carry (`C = 1`).
	void SEC() { C = true; }
	/// Habilita interrupciones IRQ (`I = 0`).
	void CLI() { I = false; }
	/// Deshabilita interrupciones IRQ (`I = 1`).
	void SEI() { I = true; }
	/// Limpia el flag de desbordamiento (`V = 0`).
	void CLV() { V = false; }
	/// Desactiva el modo decimal (`D = 0`).
	void CLD() { D = false; }
	/// Activa el modo decimal (`D = 1`).
	void SED() { D = true; }

	/// Salto absoluto: fija `PC` a `t`. El despachador ejecutará el bloque de `t`.
	void JMP_abs(eng::u16 t) { PC = t; }
	/// Salto indirecto `JMP ($xxyy)`. Reproduce el *bug* del 6502: el byte alto se
	/// lee en `(a & 0xFF00) | ((a + 1) & 0x00FF)`, es decir, el puntero **no cruza**
	/// la página (lo verifica `nestest`).
	void JMP_ind(eng::u16 a) {
		const eng::u16 lo = mem->read(a);
		const eng::u16 hi = mem->read(static_cast<eng::u16>((a & 0xFF00u) | ((a + 1u) & 0x00FFu)));
		PC = static_cast<eng::u16>((hi << 8u) | lo);
	}
	/// Llamada a subrutina: apila la dirección de regreso `ret` y salta a `t`.
	void JSR_abs(eng::u16 t, eng::u16 ret) { push16(ret); PC = t; }
	/// Retorno de subrutina: recupera `PC` de la pila y suma 1 (convención del
	/// intérprete: `JSR` apila `PC+2`, el último byte del `JSR`).
	void RTS() { PC = static_cast<eng::u16>(pull16() + 1u); }
	/// Retorno de interrupción: recupera los flags (ignora B y fuerza U) y `PC`,
	/// igual que el intérprete. Restaurarlos es clave para rutinas de NMI/IRQ.
	void RTI() {
		const eng::u8 p = static_cast<eng::u8>((pull() & ~0x10u) | 0x20u);
		N = (p & 0x80u) != 0u;
		V = (p & 0x40u) != 0u;
		D = (p & 0x08u) != 0u;
		I = (p & 0x04u) != 0u;
		Z = (p & 0x02u) != 0u;
		C = (p & 0x01u) != 0u;
		PC = pull16();
	}
	/// Interrupción por software. Si `brk_halts` (harness standalone) detiene la
	/// ejecución (`halted`, `PC = 0`). Si no (runtime), reproduce al intérprete:
	/// apila `PC + 2` (el codegen no adelanta PC) y el estado con B/U a 1, pone
	/// `I = 1` y salta al vector IRQ (`$FFFE`).
	void BRK() {
		if (brk_halts) {
			halted = true;
			PC = 0u;
			return;
		}
		const eng::u16 ret = static_cast<eng::u16>(PC + 2u);
		push16(ret);
		push(static_cast<eng::u8>(0x30u | (N ? 0x80u : 0u) | (V ? 0x40u : 0u) |
					  (D ? 0x08u : 0u) | (I ? 0x04u : 0u) | (Z ? 0x02u : 0u) |
					  (C ? 0x01u : 0u)));
		I = true;
		PC = mem->read16(0xFFFEu);
	}

	/// `BIT` (página cero): `Z = (A & v) == 0`, `N = bit 7`, `V = bit 6` de `v`.
	void BIT_zp(eng::u8 a) { const eng::u8 v = mem->read(a); Z = (A & v) == 0u; N = (v & 0x80u) != 0u; V = (v & 0x40u) != 0u; }
	/// `BIT` (absoluto): igual que `BIT_zp` con dirección de 16 bits.
	void BIT_abs(eng::u16 a) { const eng::u8 v = mem->read(a); Z = (A & v) == 0u; N = (v & 0x80u) != 0u; V = (v & 0x40u) != 0u; }

	/// `NOP` y sus variantes. Los implicados/inmediatos no acceden a memoria; los
	/// ilegales con direccionamiento **sí leen** (como el intérprete) para
	/// conservar los **efectos secundarios** del acceso (p. ej. leer `$2002`
	/// limpia VBlank). Ignorar el read producía divergencia de estado.
	void NOP() {}
	void NOP_imm(eng::u8) {}
	void NOP_zp(eng::u8 a) { (void)mem->read(a); }
	void NOP_zpx(eng::u8 a) { (void)mem->read(static_cast<eng::u8>(a + X)); }
	void NOP_abs(eng::u16 a) { (void)mem->read(a); }
	void NOP_absx(eng::u16 a) { (void)mem->read(static_cast<eng::u16>(a + X)); }

	// --- Opcodes no oficiales (aproximados) --------------------------------
	// `LAX`: carga A y X con el mismo valor leído.
#define N2A_LAX(NAME) \
	void NAME##_zp(eng::u8 a) { A = X = mem->read(a); set_nz(A); } \
	void NAME##_zpy(eng::u8 a) { A = X = mem->read(static_cast<eng::u8>(a + Y)); set_nz(A); } \
	void NAME##_abs(eng::u16 a) { A = X = mem->read(a); set_nz(A); } \
	void NAME##_absy(eng::u16 a) { A = X = mem->read(static_cast<eng::u16>(a + Y)); set_nz(A); } \
	void NAME##_indx(eng::u8 a) { A = X = mem->read(mem->read16(static_cast<eng::u8>(a + X))); set_nz(A); } \
	void NAME##_indy(eng::u8 a) { A = X = mem->read(static_cast<eng::u16>(mem->read16(a) + Y)); set_nz(A); }
	N2A_LAX(LAX)
#undef N2A_LAX

	// `SAX`: guarda `(A & X)` en memoria.
#define N2A_SAX(NAME) \
	void NAME##_zp(eng::u8 a) { mem->write(a, static_cast<eng::u8>(A & X)); } \
	void NAME##_zpy(eng::u8 a) { mem->write(static_cast<eng::u8>(a + Y), static_cast<eng::u8>(A & X)); } \
	void NAME##_abs(eng::u16 a) { mem->write(a, static_cast<eng::u8>(A & X)); } \
	void NAME##_indx(eng::u8 a) { mem->write(mem->read16(static_cast<eng::u8>(a + X)), static_cast<eng::u8>(A & X)); }
	N2A_SAX(SAX)
#undef N2A_SAX

	/// `DCP`: decrementa el byte en `a` y luego compara A con el resultado.
	void DCP_impl(eng::u16 a) { const eng::u8 v = static_cast<eng::u8>(mem->read(a) - 1u); mem->write(a, v); CMP_impl(A, v); }
	/// `ISB`: incrementa el byte en `a` y luego resta con préstamo A - resultado.
	void ISB_impl(eng::u16 a) { const eng::u8 v = static_cast<eng::u8>(mem->read(a) + 1u); mem->write(a, v); SBC_impl(v); }
	/// `SLO`: desplaza a la izquierda el byte en `a` y hace OR con A.
	void SLO_impl(eng::u16 a) { eng::u8 v = mem->read(a); C = (v & 0x80u) != 0u; v = static_cast<eng::u8>(v << 1u); mem->write(a, v); A = static_cast<eng::u8>(A | v); set_nz(A); }
	/// `RLA`: rota a la izquierda el byte en `a` y hace AND con A.
	void RLA_impl(eng::u16 a) { eng::u8 v = mem->read(a); const eng::u8 c = C ? 1u : 0u; C = (v & 0x80u) != 0u; v = static_cast<eng::u8>((v << 1u) | c); mem->write(a, v); A = static_cast<eng::u8>(A & v); set_nz(A); }
	/// `SRE`: desplaza a la derecha el byte en `a` y hace XOR con A.
	void SRE_impl(eng::u16 a) { eng::u8 v = mem->read(a); C = (v & 1u) != 0u; v = static_cast<eng::u8>(v >> 1u); mem->write(a, v); A = static_cast<eng::u8>(A ^ v); set_nz(A); }
	/// `RRA`: rota a la derecha el byte en `a` y suma con acarreo a A.
	void RRA_impl(eng::u16 a) { eng::u8 v = mem->read(a); const eng::u8 c = C ? 1u : 0u; C = (v & 1u) != 0u; v = static_cast<eng::u8>((v >> 1u) | (c << 7u)); mem->write(a, v); ADC_impl(v); }

	// Genera los modos de un RMW no oficial a partir de su núcleo `IMPL(dirección)`.
#define N2A_RMW(NAME, IMPL) \
	void NAME##_zp(eng::u8 a) { IMPL(a); } \
	void NAME##_zpx(eng::u8 a) { IMPL(static_cast<eng::u8>(a + X)); } \
	void NAME##_abs(eng::u16 a) { IMPL(a); } \
	void NAME##_absx(eng::u16 a) { IMPL(static_cast<eng::u16>(a + X)); } \
	void NAME##_absy(eng::u16 a) { IMPL(static_cast<eng::u16>(a + Y)); } \
	void NAME##_indx(eng::u8 a) { IMPL(mem->read16(static_cast<eng::u8>(a + X))); } \
	void NAME##_indy(eng::u8 a) { IMPL(static_cast<eng::u16>(mem->read16(a) + Y)); }
	N2A_RMW(DCP, DCP_impl)
	N2A_RMW(ISB, ISB_impl)
	N2A_RMW(SLO, SLO_impl)
	N2A_RMW(RLA, RLA_impl)
	N2A_RMW(SRE, SRE_impl)
	N2A_RMW(RRA, RRA_impl)
#undef N2A_RMW
};

// --- Desplazamiento multibyte (PRNG/rotaciones en cadena) --------------------
//
// La NES usa mucho `ROR $a; ROR $a+1; ...` como registro de desplazamiento/PRNG (en Donkey Kong
// es el **38 % de las instrucciones**). Expresado instrucción a instrucción, cada `ROR` toca
// memoria y materializa `C/Z/N`, y sale carísimo. Estas rutinas hacen el desplazamiento completo
// de `n` bytes con el **carry vivo en un registro** y solo materializan los flags al final.
//
// En 68000, el carry del 6502 se mapea al flag **X** del 68000: `ROXR.B`/`ROXL.B` son exactamente
// el `ROR`/`ROL` del 6502 (rotación con el bit entrante = carry). Así el bucle queda en
// ~3 instrucciones por byte (`move.b (a0)+,d0; roxr.b #1,d0; move.b d0,-1(a0)`) sin tocar flags en
// memoria. `p` apunta a `ram[a]`; `n` es el número de bytes (en orden creciente de dirección).

/// `ROR` en cadena: rota a la derecha `n` bytes como un único registro a través del carry.
/// Equivale a `ROR p[0]; ROR p[1]; ... ROR p[n-1]` (el carry entra por el byte 0 y sale por el
/// último). Deja `C` = bit0 del último byte original y `Z`/`N` del último resultado.
/// \param cpu CPU cuyo flag `C` es el carry entrante/saliente (y `Z`/`N` de salida).
/// \param p   Primer byte (en RAM emulada). No puede ser `nullptr` si `n > 0`.
/// \param n   Número de bytes a rotar (`n >= 1`).
inline void n2a_ror_run(CPU& cpu, eng::u8* p, eng::u16 n) {
#if defined(__m68k__)
	__asm__ volatile(
	    "move.b 6(%[cpu]),%%d0\n\t"
	    "lsl.b #4,%%d0\n\t"
	    "move.w %%d0,%%ccr\n\t"        // X = C
	    "moveq #0,%%d0\n\t"
	    "subq.w #1,%[n]\n\t"
	    "jmi 2f\n\t"
	    "1:\n\t"
	    "move.b (%[p])+,%%d0\n\t"
	    "roxr.b #1,%%d0\n\t"
	    "move.b %%d0,-1(%[p])\n\t"
	    "dbra %[n],1b\n\t"
	    "2:\n\t"
	    // Capturar Z/N/X **antes** de escribir (los `move.b` a memoria fijan N/Z y
	    // `addx` los toca). `seq`/`smi` no modifican el CCR, así que tras el bucle
	    // conservan los flags del último byte rotado.
	    "seq %%d1\n\t"
	    "smi %%d2\n\t"
	    "moveq #0,%%d3\n\t"
	    "addx.b %%d3,%%d3\n\t"          // d3 = X (carry saliente)
	    "move.b %%d1,7(%[cpu])\n\t"     // Z
	    "move.b %%d2,11(%[cpu])\n\t"    // N
	    "move.b %%d3,6(%[cpu])\n\t"     // C
	    : [p] "+a"(p), [n] "+d"(n)
	    : [cpu] "a"(&cpu)
	    : "d0", "d1", "d2", "d3", "cc", "memory");
#else
	eng::u8 c = cpu.C ? 1u : 0u;
	eng::u8 v = 0;
	for (eng::u16 i = 0; i < n; ++i) {
		const eng::u8 old = p[i];
		v = static_cast<eng::u8>((old >> 1u) | (c << 7u));
		c = static_cast<eng::u8>(old & 1u);
		p[i] = v;
	}
	cpu.C = (c != 0u);
	cpu.Z = (v == 0u);
	cpu.N = (v & 0x80u) != 0u;
#endif
}

/// `ROL` en cadena: análogo a `n2a_ror_run` pero hacia la izquierda (carry entra por el último
/// byte y sale por el 0). `C` = bit7 del primer byte original; `Z`/`N` del último resultado.
inline void n2a_rol_run(CPU& cpu, eng::u8* p, eng::u16 n) {
#if defined(__m68k__)
	__asm__ volatile(
	    "move.b 6(%[cpu]),%%d0\n\t"
	    "lsl.b #4,%%d0\n\t"
	    "move.w %%d0,%%ccr\n\t"        // X = C
	    "moveq #0,%%d0\n\t"
	    "subq.w #1,%[n]\n\t"
	    "jmi 2f\n\t"
	    "1:\n\t"
	    "move.b (%[p])+,%%d0\n\t"
	    "roxl.b #1,%%d0\n\t"
	    "move.b %%d0,-1(%[p])\n\t"
	    "dbra %[n],1b\n\t"
	    "2:\n\t"
	    "seq %%d1\n\t"
	    "smi %%d2\n\t"
	    "moveq #0,%%d3\n\t"
	    "addx.b %%d3,%%d3\n\t"          // d3 = X (carry saliente)
	    "move.b %%d1,7(%[cpu])\n\t"     // Z
	    "move.b %%d2,11(%[cpu])\n\t"    // N
	    "move.b %%d3,6(%[cpu])\n\t"     // C
	    : [p] "+a"(p), [n] "+d"(n)
	    : [cpu] "a"(&cpu)
	    : "d0", "d1", "d2", "d3", "cc", "memory");
#else
	eng::u8 c = cpu.C ? 1u : 0u;
	eng::u8 v = 0;
	for (eng::u16 i = 0; i < n; ++i) {
		const eng::u8 old = p[i];
		v = static_cast<eng::u8>(static_cast<eng::u8>(old << 1u) | c);
		c = static_cast<eng::u8>(old >> 7u);
		p[i] = v;
	}
	cpu.C = (c != 0u);
	cpu.Z = (v == 0u);
	cpu.N = (v & 0x80u) != 0u;
#endif
}

// Los offsets usados por el asm (C=6, Z=7, N=11) forman parte del contrato: si se reordena el
// struct `CPU` o se cambia el tamaño de un campo, el asm dejaría de ser correcto en silencio.
static_assert(__builtin_offsetof(CPU, C) == 6, "n2a_*_run: offset de C cambiado");
static_assert(__builtin_offsetof(CPU, Z) == 7, "n2a_*_run: offset de Z cambiado");
static_assert(__builtin_offsetof(CPU, N) == 11, "n2a_*_run: offset de N cambiado");

} // namespace n2a
