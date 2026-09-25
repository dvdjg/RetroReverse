#pragma once

/// \file nes_interpreter.hpp
/// Intérprete del 6502 (2A03, sin modo decimal) del runtime.
///
/// Es la **CPU de referencia** del nodo: se usa para el camino de *fallback* y
/// para validar la implementación con `nestest`. Comparte con `CPU` las
/// operaciones aritméticas (acarreo, comparación, desplazamientos) para no tener
/// dos semánticas distintas; el intérprete solo aporta la decodificación y los
/// modos de direccionamiento.
///
/// Alcance (F1): opcodes oficiales + ilegales frecuentes. No modela todavía:
/// temporalización exacta por instrucción (devuelve ciclos aproximados), modo
/// decimal (el 2A03 lo ignora) ni PPU/APU (F3/F7).

#include <eng/core/types/types.hpp>

#include "nes_runtime.hpp"

namespace n2a {

/// Ejecuta instrucciones 6502 una a una sobre `cpu` y `mem`.
struct Interpreter {
	/// Enlaza el intérprete con el estado y la memoria sobre los que operará.
	/// \param c CPU (registros y flags) que se actualizan.
	/// \param m Memoria/bus de lectura y escritura.
	Interpreter(CPU& c, NESMemory& m) : cpu(c), mem(m) {}

	CPU& cpu;             ///< Estado (registros y flags) que el intérprete actualiza.
	NESMemory& mem;       ///< Memoria/bus sobre el que lee y escribe.
	bool jammed = false;  ///< `true` tras un opcode KIL/JAM o desconocido.
	eng::u32 cycles = 0;  ///< Ciclos de CPU acumulados (conteo por instrucción).

	/// Decodifica y ejecuta **una** instrucción, avanzando `cpu.PC` y actualizando
	/// registros, flags y memoria.
	/// \return Ciclos de CPU que consume la instrucción (tabla base + penalización
	///         por cruce de página en lecturas indexadas y por ramas tomadas).
	int step();

private:
	eng::u8 rd(eng::u16 a) const { return mem.read(a); }
	void wr(eng::u16 a, eng::u8 v) { mem.write(a, v); }
	eng::u8 fetch() { return mem.read(cpu.PC++); }
	void push(eng::u8 v) { mem.write(static_cast<eng::u16>(0x0100u | cpu.SP), v); --cpu.SP; }
	eng::u8 pull() { ++cpu.SP; return mem.read(static_cast<eng::u16>(0x0100u | cpu.SP)); }
	eng::u16 read16(eng::u16 a) const {
		return static_cast<eng::u16>(rd(a) | (static_cast<eng::u16>(rd(static_cast<eng::u16>(a + 1u))) << 8u));
	}

	// Direcciones efectivas: consumen los operandos y resuelven índices/punteros.
	eng::u16 addr_zp() { return fetch(); }
	eng::u16 addr_zpx() { return static_cast<eng::u16>((fetch() + cpu.X) & 0xFFu); }
	eng::u16 addr_zpy() { return static_cast<eng::u16>((fetch() + cpu.Y) & 0xFFu); }
	eng::u16 addr_abs() {
		const eng::u16 lo = fetch();
		const eng::u16 hi = fetch();
		return static_cast<eng::u16>((hi << 8u) | lo);
	}
	eng::u16 addr_abx() {
		const eng::u16 base = addr_abs();
		const eng::u16 a = static_cast<eng::u16>(base + cpu.X);
		if ((base & 0xFF00u) != (a & 0xFF00u)) {
			page_crossed_ = true;
		}
		return a;
	}
	eng::u16 addr_aby() {
		const eng::u16 base = addr_abs();
		const eng::u16 a = static_cast<eng::u16>(base + cpu.Y);
		if ((base & 0xFF00u) != (a & 0xFF00u)) {
			page_crossed_ = true;
		}
		return a;
	}
	eng::u16 addr_izx() {
		const eng::u8 ptr = static_cast<eng::u8>(fetch() + cpu.X);
		const eng::u16 lo = rd(ptr);
		const eng::u16 hi = rd(static_cast<eng::u8>(ptr + 1u));
		return static_cast<eng::u16>((hi << 8u) | lo);
	}
	eng::u16 addr_izy() {
		const eng::u8 ptr = fetch();
		const eng::u16 base = static_cast<eng::u16>(rd(ptr) | (static_cast<eng::u16>(rd(static_cast<eng::u8>(ptr + 1u))) << 8u));
		const eng::u16 a = static_cast<eng::u16>(base + cpu.Y);
		if ((base & 0xFF00u) != (a & 0xFF00u)) {
			page_crossed_ = true;
		}
		return a;
	}

	/// Empaqueta los flags como el registro P del 6502, con B y U a 1 (PHP/BRK).
	eng::u8 status_with_b() const {
		eng::u8 p = 0x30u;
		if (cpu.N) p = static_cast<eng::u8>(p | 0x80u);
		if (cpu.V) p = static_cast<eng::u8>(p | 0x40u);
		if (cpu.D) p = static_cast<eng::u8>(p | 0x08u);
		if (cpu.I) p = static_cast<eng::u8>(p | 0x04u);
		if (cpu.Z) p = static_cast<eng::u8>(p | 0x02u);
		if (cpu.C) p = static_cast<eng::u8>(p | 0x01u);
		return p;
	}
	/// Desempaqueta un registro P (ignora B y U).
	void set_status(eng::u8 p) {
		cpu.N = (p & 0x80u) != 0u;
		cpu.V = (p & 0x40u) != 0u;
		cpu.D = (p & 0x08u) != 0u;
		cpu.I = (p & 0x04u) != 0u;
		cpu.Z = (p & 0x02u) != 0u;
		cpu.C = (p & 0x01u) != 0u;
	}
	/// Aplica una rama relativa: siempre consume el desplazamiento; salta si `taken`
	/// (marcando la penalización de ciclo y el cruce de página si lo hay).
	void branch(bool taken) {
		const eng::s8 off = static_cast<eng::s8>(fetch());
		if (taken) {
			const eng::u16 from = cpu.PC;
			const eng::u16 to = static_cast<eng::u16>(cpu.PC + off);
			if ((from & 0xFF00u) != (to & 0xFF00u)) {
				page_crossed_ = true;
			}
			cpu.PC = to;
			branch_taken_ = true;
		}
	}

	/// Marca de cruce de página para la penalización de ciclos.
	bool page_crossed_ = false;
	/// Marca de rama tomada para la penalización de ciclos.
	bool branch_taken_ = false;

	/// Ciclos base de cada opcode (sin penalizaciones de página/rama). Tabla
	/// estándar del 6502; los opcodes no oficiales usan su valor base conocido.
	/// \param op Byte de opcode.
	/// \return Ciclos base (2..8).
	[[nodiscard]] static eng::u8 base_cycles(eng::u8 op) noexcept {
		static constexpr eng::u8 t[256] = {
			/*00*/ 7, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 4, 4, 6, 6,
			/*10*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
			/*20*/ 6, 6, 2, 8, 3, 3, 5, 5, 4, 2, 2, 2, 4, 4, 6, 6,
			/*30*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
			/*40*/ 6, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 3, 4, 6, 6,
			/*50*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
			/*60*/ 6, 6, 2, 8, 3, 3, 5, 5, 4, 2, 2, 2, 5, 4, 6, 6,
			/*70*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
			/*80*/ 2, 6, 2, 6, 3, 3, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4,
			/*90*/ 2, 6, 2, 6, 4, 4, 4, 4, 2, 5, 2, 5, 5, 5, 5, 5,
			/*A0*/ 2, 6, 2, 6, 3, 3, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4,
			/*B0*/ 2, 5, 2, 5, 4, 4, 4, 4, 2, 4, 2, 4, 4, 4, 4, 4,
			/*C0*/ 2, 6, 2, 8, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6,
			/*D0*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
			/*E0*/ 2, 6, 2, 8, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6,
			/*F0*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
		};
		return t[op];
	}

	/// ¿La lectura `op` usa direccionamiento indexado que penaliza +1 al cruzar de
	/// página? (Las escrituras y los RMW nunca penalizan.)
	/// \param op Byte de opcode.
	/// \return `true` si cruzar página añade un ciclo.
	[[nodiscard]] static bool read_indexed_penalty(eng::u8 op) noexcept {
		switch (op) {
		// absX / absY / (ind),Y de lectura.
		case 0x1D: case 0x19: case 0x11:
		case 0x3D: case 0x39: case 0x31:
		case 0x5D: case 0x59: case 0x51:
		case 0x7D: case 0x79: case 0x71:
		case 0xBD: case 0xB9: case 0xB1:
		case 0xDD: case 0xD9: case 0xD1:
		case 0xFD: case 0xF9: case 0xF1:
		case 0xBC: case 0xBE:
		case 0xBB: case 0xBF: case 0xB3:
		case 0x1C: case 0x3C: case 0x5C: case 0x7C: case 0xDC: case 0xFC:
			return true;
		default:
			return false;
		}
	}
};

/// Implementación de `step()`. Se define fuera del struct por legibilidad; es
/// `inline` para poder estar en cabecera.
inline int Interpreter::step() {
	if (jammed) {
		return 1;
	}
	page_crossed_ = false;
	branch_taken_ = false;
	const eng::u8 op = fetch();
	eng::u8 cyc = base_cycles(op);

	switch (op) {
	// --- LDA ---
	case 0xA9: cpu.A = fetch(); cpu.set_nz(cpu.A); break;
	case 0xA5: cpu.A = rd(addr_zp()); cpu.set_nz(cpu.A); break;
	case 0xB5: cpu.A = rd(addr_zpx()); cpu.set_nz(cpu.A); break;
	case 0xAD: cpu.A = rd(addr_abs()); cpu.set_nz(cpu.A); break;
	case 0xBD: cpu.A = rd(addr_abx()); cpu.set_nz(cpu.A); break;
	case 0xB9: cpu.A = rd(addr_aby()); cpu.set_nz(cpu.A); break;
	case 0xA1: cpu.A = rd(addr_izx()); cpu.set_nz(cpu.A); break;
	case 0xB1: cpu.A = rd(addr_izy()); cpu.set_nz(cpu.A); break;
	// --- LDX ---
	case 0xA2: cpu.X = fetch(); cpu.set_nz(cpu.X); break;
	case 0xA6: cpu.X = rd(addr_zp()); cpu.set_nz(cpu.X); break;
	case 0xB6: cpu.X = rd(addr_zpy()); cpu.set_nz(cpu.X); break;
	case 0xAE: cpu.X = rd(addr_abs()); cpu.set_nz(cpu.X); break;
	case 0xBE: cpu.X = rd(addr_aby()); cpu.set_nz(cpu.X); break;
	// --- LDY ---
	case 0xA0: cpu.Y = fetch(); cpu.set_nz(cpu.Y); break;
	case 0xA4: cpu.Y = rd(addr_zp()); cpu.set_nz(cpu.Y); break;
	case 0xB4: cpu.Y = rd(addr_zpx()); cpu.set_nz(cpu.Y); break;
	case 0xAC: cpu.Y = rd(addr_abs()); cpu.set_nz(cpu.Y); break;
	case 0xBC: cpu.Y = rd(addr_abx()); cpu.set_nz(cpu.Y); break;
	// --- STA / STX / STY ---
	case 0x85: wr(addr_zp(), cpu.A); break;
	case 0x95: wr(addr_zpx(), cpu.A); break;
	case 0x8D: wr(addr_abs(), cpu.A); break;
	case 0x9D: wr(addr_abx(), cpu.A); break;
	case 0x99: wr(addr_aby(), cpu.A); break;
	case 0x81: wr(addr_izx(), cpu.A); break;
	case 0x91: wr(addr_izy(), cpu.A); break;
	case 0x86: wr(addr_zp(), cpu.X); break;
	case 0x96: wr(addr_zpy(), cpu.X); break;
	case 0x8E: wr(addr_abs(), cpu.X); break;
	case 0x84: wr(addr_zp(), cpu.Y); break;
	case 0x94: wr(addr_zpx(), cpu.Y); break;
	case 0x8C: wr(addr_abs(), cpu.Y); break;
	// --- transferencias ---
	case 0xAA: cpu.X = cpu.A; cpu.set_nz(cpu.X); break;
	case 0xA8: cpu.Y = cpu.A; cpu.set_nz(cpu.Y); break;
	case 0x8A: cpu.A = cpu.X; cpu.set_nz(cpu.A); break;
	case 0x98: cpu.A = cpu.Y; cpu.set_nz(cpu.A); break;
	case 0xBA: cpu.X = cpu.SP; cpu.set_nz(cpu.X); break;
	case 0x9A: cpu.SP = cpu.X; break;
	// --- pila ---
	case 0x48: push(cpu.A); break;
	case 0x68: cpu.A = pull(); cpu.set_nz(cpu.A); break;
	case 0x08: push(status_with_b()); break;
	case 0x28: set_status(static_cast<eng::u8>((pull() & ~0x10u) | 0x20u)); break;
	// --- AND / EOR / ORA ---
	case 0x29: cpu.AND_impl(fetch()); break;
	case 0x25: cpu.AND_impl(rd(addr_zp())); break;
	case 0x35: cpu.AND_impl(rd(addr_zpx())); break;
	case 0x2D: cpu.AND_impl(rd(addr_abs())); break;
	case 0x3D: cpu.AND_impl(rd(addr_abx())); break;
	case 0x39: cpu.AND_impl(rd(addr_aby())); break;
	case 0x21: cpu.AND_impl(rd(addr_izx())); break;
	case 0x31: cpu.AND_impl(rd(addr_izy())); break;
	case 0x49: cpu.EOR_impl(fetch()); break;
	case 0x45: cpu.EOR_impl(rd(addr_zp())); break;
	case 0x55: cpu.EOR_impl(rd(addr_zpx())); break;
	case 0x4D: cpu.EOR_impl(rd(addr_abs())); break;
	case 0x5D: cpu.EOR_impl(rd(addr_abx())); break;
	case 0x59: cpu.EOR_impl(rd(addr_aby())); break;
	case 0x41: cpu.EOR_impl(rd(addr_izx())); break;
	case 0x51: cpu.EOR_impl(rd(addr_izy())); break;
	case 0x09: cpu.ORA_impl(fetch()); break;
	case 0x05: cpu.ORA_impl(rd(addr_zp())); break;
	case 0x15: cpu.ORA_impl(rd(addr_zpx())); break;
	case 0x0D: cpu.ORA_impl(rd(addr_abs())); break;
	case 0x1D: cpu.ORA_impl(rd(addr_abx())); break;
	case 0x19: cpu.ORA_impl(rd(addr_aby())); break;
	case 0x01: cpu.ORA_impl(rd(addr_izx())); break;
	case 0x11: cpu.ORA_impl(rd(addr_izy())); break;
	// --- BIT ---
	case 0x24: { const eng::u8 m = rd(addr_zp()); cpu.Z = (cpu.A & m) == 0u; cpu.V = (m & 0x40u) != 0u; cpu.N = (m & 0x80u) != 0u; break; }
	case 0x2C: { const eng::u8 m = rd(addr_abs()); cpu.Z = (cpu.A & m) == 0u; cpu.V = (m & 0x40u) != 0u; cpu.N = (m & 0x80u) != 0u; break; }
	// --- ADC / SBC ---
	case 0x69: cpu.ADC_impl(fetch()); break;
	case 0x65: cpu.ADC_impl(rd(addr_zp())); break;
	case 0x75: cpu.ADC_impl(rd(addr_zpx())); break;
	case 0x6D: cpu.ADC_impl(rd(addr_abs())); break;
	case 0x7D: cpu.ADC_impl(rd(addr_abx())); break;
	case 0x79: cpu.ADC_impl(rd(addr_aby())); break;
	case 0x61: cpu.ADC_impl(rd(addr_izx())); break;
	case 0x71: cpu.ADC_impl(rd(addr_izy())); break;
	case 0xE9: case 0xEB: cpu.SBC_impl(fetch()); break;
	case 0xE5: cpu.SBC_impl(rd(addr_zp())); break;
	case 0xF5: cpu.SBC_impl(rd(addr_zpx())); break;
	case 0xED: cpu.SBC_impl(rd(addr_abs())); break;
	case 0xFD: cpu.SBC_impl(rd(addr_abx())); break;
	case 0xF9: cpu.SBC_impl(rd(addr_aby())); break;
	case 0xE1: cpu.SBC_impl(rd(addr_izx())); break;
	case 0xF1: cpu.SBC_impl(rd(addr_izy())); break;
	// --- CMP / CPX / CPY ---
	case 0xC9: cpu.CMP_impl(cpu.A, fetch()); break;
	case 0xC5: cpu.CMP_impl(cpu.A, rd(addr_zp())); break;
	case 0xD5: cpu.CMP_impl(cpu.A, rd(addr_zpx())); break;
	case 0xCD: cpu.CMP_impl(cpu.A, rd(addr_abs())); break;
	case 0xDD: cpu.CMP_impl(cpu.A, rd(addr_abx())); break;
	case 0xD9: cpu.CMP_impl(cpu.A, rd(addr_aby())); break;
	case 0xC1: cpu.CMP_impl(cpu.A, rd(addr_izx())); break;
	case 0xD1: cpu.CMP_impl(cpu.A, rd(addr_izy())); break;
	case 0xE0: cpu.CMP_impl(cpu.X, fetch()); break;
	case 0xE4: cpu.CMP_impl(cpu.X, rd(addr_zp())); break;
	case 0xEC: cpu.CMP_impl(cpu.X, rd(addr_abs())); break;
	case 0xC0: cpu.CMP_impl(cpu.Y, fetch()); break;
	case 0xC4: cpu.CMP_impl(cpu.Y, rd(addr_zp())); break;
	case 0xCC: cpu.CMP_impl(cpu.Y, rd(addr_abs())); break;
	// --- INC / DEC ---
	case 0xE6: cpu.INC_at(addr_zp()); break;
	case 0xF6: cpu.INC_at(addr_zpx()); break;
	case 0xEE: cpu.INC_at(addr_abs()); break;
	case 0xFE: cpu.INC_at(addr_abx()); break;
	case 0xC6: cpu.DEC_at(addr_zp()); break;
	case 0xD6: cpu.DEC_at(addr_zpx()); break;
	case 0xCE: cpu.DEC_at(addr_abs()); break;
	case 0xDE: cpu.DEC_at(addr_abx()); break;
	case 0xE8: ++cpu.X; cpu.set_nz(cpu.X); break;
	case 0xC8: ++cpu.Y; cpu.set_nz(cpu.Y); break;
	case 0xCA: --cpu.X; cpu.set_nz(cpu.X); break;
	case 0x88: --cpu.Y; cpu.set_nz(cpu.Y); break;
	// --- desplazamientos ---
	case 0x0A: cpu.ASL_A(); break;
	case 0x06: cpu.ASL_at(addr_zp()); break;
	case 0x16: cpu.ASL_at(addr_zpx()); break;
	case 0x0E: cpu.ASL_at(addr_abs()); break;
	case 0x1E: cpu.ASL_at(addr_abx()); break;
	case 0x4A: cpu.LSR_A(); break;
	case 0x46: cpu.LSR_at(addr_zp()); break;
	case 0x56: cpu.LSR_at(addr_zpx()); break;
	case 0x4E: cpu.LSR_at(addr_abs()); break;
	case 0x5E: cpu.LSR_at(addr_abx()); break;
	case 0x2A: cpu.ROL_A(); break;
	case 0x26: cpu.ROL_at(addr_zp()); break;
	case 0x36: cpu.ROL_at(addr_zpx()); break;
	case 0x2E: cpu.ROL_at(addr_abs()); break;
	case 0x3E: cpu.ROL_at(addr_abx()); break;
	case 0x6A: cpu.ROR_A(); break;
	case 0x66: cpu.ROR_at(addr_zp()); break;
	case 0x76: cpu.ROR_at(addr_zpx()); break;
	case 0x6E: cpu.ROR_at(addr_abs()); break;
	case 0x7E: cpu.ROR_at(addr_abx()); break;
	// --- saltos / subrutinas ---
	case 0x4C: cpu.PC = addr_abs(); break;
	case 0x6C: {
		const eng::u16 ptr = addr_abs();
		const eng::u16 lo = rd(ptr);
		const eng::u16 hi = rd(static_cast<eng::u16>((ptr & 0xFF00u) | ((ptr + 1u) & 0x00FFu)));
		cpu.PC = static_cast<eng::u16>((hi << 8u) | lo);
		break;
	}
	case 0x20: {
		const eng::u16 target = addr_abs();
		const eng::u16 ret = static_cast<eng::u16>(cpu.PC - 1u);
		push(static_cast<eng::u8>(ret >> 8u));
		push(static_cast<eng::u8>(ret & 0xFFu));
		cpu.PC = target;
		break;
	}
	case 0x60: {
		const eng::u16 lo = pull();
		const eng::u16 hi = pull();
		cpu.PC = static_cast<eng::u16>(((hi << 8u) | lo) + 1u);
		break;
	}
	case 0x40: {
		set_status(static_cast<eng::u8>((pull() & ~0x10u) | 0x20u));
		const eng::u16 lo = pull();
		const eng::u16 hi = pull();
		cpu.PC = static_cast<eng::u16>((hi << 8u) | lo);
		break;
	}
	case 0x00: {  // BRK
		const eng::u16 ret = static_cast<eng::u16>(cpu.PC + 1u);
		push(static_cast<eng::u8>(ret >> 8u));
		push(static_cast<eng::u8>(ret & 0xFFu));
		push(status_with_b());
		cpu.I = true;
		cpu.PC = read16(0xFFFEu);
		break;
	}
	// --- ramas ---
	case 0x10: branch(!cpu.N); break;
	case 0x30: branch(cpu.N); break;
	case 0x50: branch(!cpu.V); break;
	case 0x70: branch(cpu.V); break;
	case 0x90: branch(!cpu.C); break;
	case 0xB0: branch(cpu.C); break;
	case 0xD0: branch(!cpu.Z); break;
	case 0xF0: branch(cpu.Z); break;
	// --- flags ---
	case 0x18: cpu.C = false; break;
	case 0x38: cpu.C = true; break;
	case 0x58: cpu.I = false; break;
	case 0x78: cpu.I = true; break;
	case 0xB8: cpu.V = false; break;
	case 0xD8: cpu.D = false; break;
	case 0xF8: cpu.D = true; break;
	case 0xEA: break;  // NOP

	// ================= ILEGALES =================
	// SLO: ASL del operando y ORA con A.
	case 0x03: { const eng::u16 ad = addr_izx(); cpu.ASL_at(ad); cpu.ORA_impl(rd(ad)); break; }
	case 0x07: { const eng::u16 ad = addr_zp(); cpu.ASL_at(ad); cpu.ORA_impl(rd(ad)); break; }
	case 0x0F: { const eng::u16 ad = addr_abs(); cpu.ASL_at(ad); cpu.ORA_impl(rd(ad)); break; }
	case 0x13: { const eng::u16 ad = addr_izy(); cpu.ASL_at(ad); cpu.ORA_impl(rd(ad)); break; }
	case 0x17: { const eng::u16 ad = addr_zpx(); cpu.ASL_at(ad); cpu.ORA_impl(rd(ad)); break; }
	case 0x1B: { const eng::u16 ad = addr_aby(); cpu.ASL_at(ad); cpu.ORA_impl(rd(ad)); break; }
	case 0x1F: { const eng::u16 ad = addr_abx(); cpu.ASL_at(ad); cpu.ORA_impl(rd(ad)); break; }
	// RLA: ROL del operando y AND con A.
	case 0x23: { const eng::u16 ad = addr_izx(); cpu.ROL_at(ad); cpu.AND_impl(rd(ad)); break; }
	case 0x27: { const eng::u16 ad = addr_zp(); cpu.ROL_at(ad); cpu.AND_impl(rd(ad)); break; }
	case 0x2F: { const eng::u16 ad = addr_abs(); cpu.ROL_at(ad); cpu.AND_impl(rd(ad)); break; }
	case 0x33: { const eng::u16 ad = addr_izy(); cpu.ROL_at(ad); cpu.AND_impl(rd(ad)); break; }
	case 0x37: { const eng::u16 ad = addr_zpx(); cpu.ROL_at(ad); cpu.AND_impl(rd(ad)); break; }
	case 0x3B: { const eng::u16 ad = addr_aby(); cpu.ROL_at(ad); cpu.AND_impl(rd(ad)); break; }
	case 0x3F: { const eng::u16 ad = addr_abx(); cpu.ROL_at(ad); cpu.AND_impl(rd(ad)); break; }
	// SRE: LSR del operando y EOR con A.
	case 0x43: { const eng::u16 ad = addr_izx(); cpu.LSR_at(ad); cpu.EOR_impl(rd(ad)); break; }
	case 0x47: { const eng::u16 ad = addr_zp(); cpu.LSR_at(ad); cpu.EOR_impl(rd(ad)); break; }
	case 0x4F: { const eng::u16 ad = addr_abs(); cpu.LSR_at(ad); cpu.EOR_impl(rd(ad)); break; }
	case 0x53: { const eng::u16 ad = addr_izy(); cpu.LSR_at(ad); cpu.EOR_impl(rd(ad)); break; }
	case 0x57: { const eng::u16 ad = addr_zpx(); cpu.LSR_at(ad); cpu.EOR_impl(rd(ad)); break; }
	case 0x5B: { const eng::u16 ad = addr_aby(); cpu.LSR_at(ad); cpu.EOR_impl(rd(ad)); break; }
	case 0x5F: { const eng::u16 ad = addr_abx(); cpu.LSR_at(ad); cpu.EOR_impl(rd(ad)); break; }
	// RRA: ROR del operando y ADC con A.
	case 0x63: { const eng::u16 ad = addr_izx(); cpu.ROR_at(ad); cpu.ADC_impl(rd(ad)); break; }
	case 0x67: { const eng::u16 ad = addr_zp(); cpu.ROR_at(ad); cpu.ADC_impl(rd(ad)); break; }
	case 0x6F: { const eng::u16 ad = addr_abs(); cpu.ROR_at(ad); cpu.ADC_impl(rd(ad)); break; }
	case 0x73: { const eng::u16 ad = addr_izy(); cpu.ROR_at(ad); cpu.ADC_impl(rd(ad)); break; }
	case 0x77: { const eng::u16 ad = addr_zpx(); cpu.ROR_at(ad); cpu.ADC_impl(rd(ad)); break; }
	case 0x7B: { const eng::u16 ad = addr_aby(); cpu.ROR_at(ad); cpu.ADC_impl(rd(ad)); break; }
	case 0x7F: { const eng::u16 ad = addr_abx(); cpu.ROR_at(ad); cpu.ADC_impl(rd(ad)); break; }
	// SAX: guarda A & X.
	case 0x83: wr(addr_izx(), static_cast<eng::u8>(cpu.A & cpu.X)); break;
	case 0x87: wr(addr_zp(), static_cast<eng::u8>(cpu.A & cpu.X)); break;
	case 0x8F: wr(addr_abs(), static_cast<eng::u8>(cpu.A & cpu.X)); break;
	case 0x97: wr(addr_zpy(), static_cast<eng::u8>(cpu.A & cpu.X)); break;
	// LAX: carga A y X con el operando.
	case 0xA3: cpu.A = cpu.X = rd(addr_izx()); cpu.set_nz(cpu.A); break;
	case 0xA7: cpu.A = cpu.X = rd(addr_zp()); cpu.set_nz(cpu.A); break;
	case 0xAB: cpu.A = cpu.X = fetch(); cpu.set_nz(cpu.A); break;
	case 0xAF: cpu.A = cpu.X = rd(addr_abs()); cpu.set_nz(cpu.A); break;
	case 0xB3: cpu.A = cpu.X = rd(addr_izy()); cpu.set_nz(cpu.A); break;
	case 0xB7: cpu.A = cpu.X = rd(addr_zpy()); cpu.set_nz(cpu.A); break;
	case 0xBF: cpu.A = cpu.X = rd(addr_aby()); cpu.set_nz(cpu.A); break;
	// DCP: decrementa el operando y compara con A.
	case 0xC3: { const eng::u16 ad = addr_izx(); cpu.DEC_at(ad); cpu.CMP_impl(cpu.A, rd(ad)); break; }
	case 0xC7: { const eng::u16 ad = addr_zp(); cpu.DEC_at(ad); cpu.CMP_impl(cpu.A, rd(ad)); break; }
	case 0xCF: { const eng::u16 ad = addr_abs(); cpu.DEC_at(ad); cpu.CMP_impl(cpu.A, rd(ad)); break; }
	case 0xD3: { const eng::u16 ad = addr_izy(); cpu.DEC_at(ad); cpu.CMP_impl(cpu.A, rd(ad)); break; }
	case 0xD7: { const eng::u16 ad = addr_zpx(); cpu.DEC_at(ad); cpu.CMP_impl(cpu.A, rd(ad)); break; }
	case 0xDB: { const eng::u16 ad = addr_aby(); cpu.DEC_at(ad); cpu.CMP_impl(cpu.A, rd(ad)); break; }
	case 0xDF: { const eng::u16 ad = addr_abx(); cpu.DEC_at(ad); cpu.CMP_impl(cpu.A, rd(ad)); break; }
	// ISC/ISB: incrementa el operando y resta con préstamo de A.
	case 0xE3: { const eng::u16 ad = addr_izx(); cpu.INC_at(ad); cpu.SBC_impl(rd(ad)); break; }
	case 0xE7: { const eng::u16 ad = addr_zp(); cpu.INC_at(ad); cpu.SBC_impl(rd(ad)); break; }
	case 0xEF: { const eng::u16 ad = addr_abs(); cpu.INC_at(ad); cpu.SBC_impl(rd(ad)); break; }
	case 0xF3: { const eng::u16 ad = addr_izy(); cpu.INC_at(ad); cpu.SBC_impl(rd(ad)); break; }
	case 0xF7: { const eng::u16 ad = addr_zpx(); cpu.INC_at(ad); cpu.SBC_impl(rd(ad)); break; }
	case 0xFB: { const eng::u16 ad = addr_aby(); cpu.INC_at(ad); cpu.SBC_impl(rd(ad)); break; }
	case 0xFF: { const eng::u16 ad = addr_abx(); cpu.INC_at(ad); cpu.SBC_impl(rd(ad)); break; }
	// ANC: AND + copia el bit 7 al carry.
	case 0x0B: case 0x2B: cpu.AND_impl(fetch()); cpu.C = (cpu.A & 0x80u) != 0u; break;
	// ALR: AND + LSR.
	case 0x4B: cpu.AND_impl(fetch()); cpu.LSR_A(); break;
	// ARR: AND + ROR (con carga y flags particulares).
	case 0x6B: {
		cpu.AND_impl(fetch());
		const eng::u8 c = cpu.C ? 1u : 0u;
		cpu.A = static_cast<eng::u8>((cpu.A >> 1u) | (c << 7u));
		cpu.set_nz(cpu.A);
		cpu.C = (cpu.A & 0x40u) != 0u;
		cpu.V = (((cpu.A >> 6u) ^ (cpu.A >> 5u)) & 1u) != 0u;
		break;
	}
	// SBX: (A & X) - inmediato -> X.
	case 0xCB: {
		const eng::u8 m = fetch();
		cpu.X = static_cast<eng::u8>((cpu.A & cpu.X) - m);
		cpu.C = (cpu.A & cpu.X) >= m;
		cpu.set_nz(cpu.X);
		break;
	}
	// LAS: A = X = SP = operando & SP.
	case 0xBB: {
		const eng::u8 m = rd(addr_aby());
		const eng::u8 v = static_cast<eng::u8>(m & cpu.SP);
		cpu.A = cpu.X = cpu.SP = v;
		cpu.set_nz(cpu.A);
		break;
	}
	// SHA/SHX/SHY/TAS: formas inestables; se usa el valor determinista del original.
	case 0x93: wr(addr_izy(), static_cast<eng::u8>(cpu.A & cpu.X)); break;
	case 0x9F: wr(addr_aby(), static_cast<eng::u8>(cpu.A & cpu.X)); break;
	case 0x9E: wr(addr_aby(), cpu.X); break;
	case 0x9C: wr(addr_abx(), cpu.Y); break;
	case 0x9B: cpu.SP = static_cast<eng::u8>(cpu.A & cpu.X); wr(addr_aby(), cpu.SP); break;
	// NOP ilegales (implicados / inmediatos).
	case 0x1A: case 0x3A: case 0x5A: case 0x7A: case 0xDA: case 0xFA: break;
	case 0x80: case 0x82: case 0x89: case 0xC2: case 0xE2: (void)fetch(); break;
	// NOP ilegales que leen memoria (efecto de direccionamiento).
	case 0x04: case 0x44: case 0x64: (void)rd(addr_zp()); break;
	case 0x0C: (void)rd(addr_abs()); break;
	case 0x14: case 0x34: case 0x54: case 0x74: case 0xD4: case 0xF4: (void)rd(addr_zpx()); break;
	case 0x1C: case 0x3C: case 0x5C: case 0x7C: case 0xDC: case 0xFC: (void)rd(addr_abx()); break;
	// KIL / JAM: detienen la CPU.
	case 0x02: case 0x12: case 0x22: case 0x32: case 0x42: case 0x52:
	case 0x62: case 0x72: case 0x92: case 0xB2: case 0xD2: case 0xF2:
		jammed = true;
		break;

	default:
		jammed = true;
		break;
	}

	if (branch_taken_) {
		cyc = static_cast<eng::u8>(cyc + 1u);
	}
	if (page_crossed_ && (branch_taken_ || read_indexed_penalty(op))) {
		cyc = static_cast<eng::u8>(cyc + 1u);
	}
	cycles += cyc;
	return cyc;
}

} // namespace n2a
