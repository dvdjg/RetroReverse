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

	// --- Hooks opcionales del sistema (PPU/APU/mapper/input) ---
	/// Cookie que se pasa a los hooks de E/S.
	void* io_user = nullptr;
	/// Si no es `nullptr`, atiende las lecturas de `$2000-$FFFF` (sistema real).
	eng::u8 (*io_read)(void*, eng::u16) = nullptr;
	/// Si no es `nullptr`, atiende las escrituras de `$2000-$FFFF`.
	void (*io_write)(void*, eng::u16, eng::u8) = nullptr;

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
			eng::usize idx = static_cast<eng::usize>(addr - 0x8000u);
			if (prg_size == 0x4000u) {
				idx &= 0x3FFFu;
			}
			return prg[idx % prg_size];
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
	/// Memoria asociada (observador, no propietario). La enlaza `game_main()`.
	NESMemory* mem = nullptr;

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
	void NAME##_indx(eng::u8 a) { R = mem->read(mem->read16(static_cast<eng::u8>(a + X))); set_nz(R); } \
	void NAME##_indy(eng::u8 a) { R = mem->read(static_cast<eng::u16>(mem->read16(a) + Y)); set_nz(R); }
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
	void NAME##_indx(eng::u8 a) { mem->write(mem->read16(static_cast<eng::u8>(a + X)), R); } \
	void NAME##_indy(eng::u8 a) { mem->write(static_cast<eng::u16>(mem->read16(a) + Y), R); }
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
	/// Retorno de subrutina: recupera `PC` de la pila.
	void RTS() { PC = pull16(); }
	/// Retorno de interrupción: descarta el byte de flags y recupera `PC`.
	void RTI() { (void)pull(); PC = pull16(); }
	/// Interrupción por software: detiene la ejecución y deja `PC = 0` (fin del bucle).
	void BRK() { halted = true; PC = 0u; }

	/// `BIT` (página cero): `Z = (A & v) == 0`, `N = bit 7`, `V = bit 6` de `v`.
	void BIT_zp(eng::u8 a) { const eng::u8 v = mem->read(a); Z = (A & v) == 0u; N = (v & 0x80u) != 0u; V = (v & 0x40u) != 0u; }
	/// `BIT` (absoluto): igual que `BIT_zp` con dirección de 16 bits.
	void BIT_abs(eng::u16 a) { const eng::u8 v = mem->read(a); Z = (A & v) == 0u; N = (v & 0x80u) != 0u; V = (v & 0x40u) != 0u; }

	/// `NOP` y sus variantes: no hacen nada (el operando se ignora).
	void NOP() {}
	void NOP_imm(eng::u8) {}
	void NOP_zp(eng::u8) {}
	void NOP_zpx(eng::u8) {}
	void NOP_abs(eng::u16) {}
	void NOP_absx(eng::u16) {}

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

} // namespace n2a
