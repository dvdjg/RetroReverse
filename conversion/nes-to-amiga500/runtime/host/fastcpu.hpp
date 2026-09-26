#pragma once

/// \file fastcpu.hpp
/// **Ejecutor rápido (pre-decodificado)** del 6502 para el camino "transpilado":
/// decodifica la PRG-ROM una vez al cargar (opcode, modo, tamaño y operando por
/// dirección); al ejecutar, los opcodes cubiertos se resuelven sin volver a leer
/// opcode/operando de memoria. Los no cubiertos devuelven 0 y el `NesSystem` cae
/// al intérprete (`Interp::step`), garantizando corrección.
///
/// Cobertura (ver `covers`): cargas/almacenes en todos los modos, transferencias,
/// pila, flags, ALU/CMP/INC/DEC/BIT (incl. indexados), familia RMW de
/// desplazamientos (ASL/LSR/ROL/ROR), saltos (JMP/JSR/RTS) y ramas. Los modos
/// indexados de **lectura** aplican la penalización de cruce de página.
///
/// Solo host (usa `new` y la tabla de opcodes del transpilador); en Amiga/SDL sin
/// este ejecutor se usa el intérprete.

#include <eng/core/types/types.hpp>
#include <eng/core/util/string_view.hpp>

#include "../../tools/transpiler/src/opcodes.hpp"
#include "nes_runtime.hpp"

namespace n2a {

/// Decodificador + ejecutor rápido por dirección.
struct FastCpu {
	/// Instrucción pre-decodificada en una dirección.
	struct Dec {
		eng::u16 operand = 0; ///< Operando (inmediato o dirección).
		eng::u16 target = 0;  ///< Destino de rama/JMP/JSR.
		eng::u8 opcode = 0;   ///< Byte de opcode.
		eng::u8 size = 1;     ///< Bytes de la instrucción.
	};

	Dec* dec = nullptr;             ///< Tabla por dirección (0x10000 entradas).
	eng::u8* has = nullptr;         ///< 1 si la dirección es inicio de instrucción.
	const eng::u8* prg_ = nullptr;  ///< PRG-ROM (observador) para decodificar bajo demanda.
	eng::u32 prg_size_ = 0;         ///< Tamaño de la PRG en bytes (16 KB se espeja).

	/// ¿El ejecutor rápido resuelve `op` (en vez de caer al intérprete)?
	/// Es la lista autoritativa de cobertura: `step` la usa como puerta y las
	/// herramientas (p. ej. el histograma) para clasificar. Al añadir un opcode,
	/// hay que añadirlo aquí **y** en el `switch` de `step`.
	/// \param op Byte de opcode 6502.
	/// \return `true` si `step` lo maneja sin fallback.
	[[nodiscard]] static constexpr bool covers(eng::u8 op) noexcept {
		switch (op) {
		// LDA
		case 0xA9: case 0xA5: case 0xB5: case 0xAD: case 0xBD: case 0xB9: case 0xA1: case 0xB1:
		// LDX / LDY
		case 0xA2: case 0xA6: case 0xB6: case 0xAE: case 0xBE:
		case 0xA0: case 0xA4: case 0xB4: case 0xAC: case 0xBC:
		// STA / STX / STY
		case 0x85: case 0x95: case 0x8D: case 0x9D: case 0x99: case 0x81: case 0x91:
		case 0x86: case 0x96: case 0x8E: case 0x84: case 0x94: case 0x8C:
		// transferencias
		case 0xAA: case 0xA8: case 0x8A: case 0x98: case 0xBA: case 0x9A:
		// inc/dec de registro
		case 0xE8: case 0xC8: case 0xCA: case 0x88:
		// flags
		case 0x18: case 0x38: case 0x58: case 0x78: case 0xB8: case 0xD8: case 0xF8:
		// pila
		case 0x48: case 0x68: case 0x08: case 0x28:
		// ADC / SBC
		case 0x69: case 0x65: case 0x75: case 0x6D: case 0x7D: case 0x79: case 0x61: case 0x71:
		case 0xE9: case 0xE5: case 0xF5: case 0xED: case 0xFD: case 0xF9: case 0xE1: case 0xF1:
		// AND / ORA / EOR
		case 0x29: case 0x25: case 0x35: case 0x2D: case 0x3D: case 0x39: case 0x21: case 0x31:
		case 0x09: case 0x05: case 0x15: case 0x0D: case 0x1D: case 0x19: case 0x01: case 0x11:
		case 0x49: case 0x45: case 0x55: case 0x4D: case 0x5D: case 0x59: case 0x41: case 0x51:
		// CMP / CPX / CPY / BIT
		case 0xC9: case 0xC5: case 0xD5: case 0xCD: case 0xDD: case 0xD9: case 0xC1: case 0xD1:
		case 0xE0: case 0xE4: case 0xEC:
		case 0xC0: case 0xC4: case 0xCC:
		case 0x24: case 0x2C:
		// INC / DEC de memoria
		case 0xE6: case 0xF6: case 0xEE: case 0xFE:
		case 0xC6: case 0xD6: case 0xCE: case 0xDE:
		// ASL / LSR / ROL / ROR
		case 0x0A: case 0x06: case 0x16: case 0x0E: case 0x1E:
		case 0x4A: case 0x46: case 0x56: case 0x4E: case 0x5E:
		case 0x2A: case 0x26: case 0x36: case 0x2E: case 0x3E:
		case 0x6A: case 0x66: case 0x76: case 0x6E: case 0x7E:
		// NOP
		case 0xEA:
		// saltos
		case 0x4C: case 0x6C: case 0x20: case 0x60:
		// ramas
		case 0x10: case 0x30: case 0x50: case 0x70: case 0x90: case 0xB0: case 0xD0: case 0xF0:
		// RTI
		case 0x40:
		// ilegales: SLO / RLA / SRE / RRA
		case 0x03: case 0x07: case 0x0F: case 0x13: case 0x17: case 0x1B: case 0x1F:
		case 0x23: case 0x27: case 0x2F: case 0x33: case 0x37: case 0x3B: case 0x3F:
		case 0x43: case 0x47: case 0x4F: case 0x53: case 0x57: case 0x5B: case 0x5F:
		case 0x63: case 0x67: case 0x6F: case 0x73: case 0x77: case 0x7B: case 0x7F:
		// ilegales: SAX / LAX / DCP / ISB
		case 0x83: case 0x87: case 0x8F: case 0x97:
		case 0xA3: case 0xA7: case 0xAB: case 0xAF: case 0xB3: case 0xB7: case 0xBF:
		case 0xC3: case 0xC7: case 0xCF: case 0xD3: case 0xD7: case 0xDB: case 0xDF:
		case 0xE3: case 0xE7: case 0xEF: case 0xF3: case 0xF7: case 0xFB: case 0xFF:
		// ilegales: misc (ANC/ALR/ARR/SBX/LAS/SHA/SHX/SHY/TAS) y NOP
		case 0x0B: case 0x2B: case 0x4B: case 0x6B: case 0xCB: case 0xBB:
		case 0x93: case 0x9F: case 0x9E: case 0x9C: case 0x9B:
		case 0x1A: case 0x3A: case 0x5A: case 0x7A: case 0xDA: case 0xFA:
		case 0x80: case 0x82: case 0x89: case 0xC2: case 0xE2:
		case 0x04: case 0x44: case 0x64: case 0x0C:
		case 0x14: case 0x34: case 0x54: case 0x74: case 0xD4: case 0xF4:
		case 0x1C: case 0x3C: case 0x5C: case 0x7C: case 0xDC: case 0xFC:
			return true;
		default:
			return false;
		}
	}

	/// Decodifica la PRG desde los vectores de reset/NMI/IRQ.
	/// \return `true` si se pudo reservar y decodificar algo.
	bool build(const eng::u8* prg, eng::u32 prg_size, eng::u16 reset, eng::u16 nmi, eng::u16 irq) {
		destroy();
		dec = new Dec[0x10000];
		has = new eng::u8[0x10000]();
		if (dec == nullptr || has == nullptr) {
			destroy();
			return false;
		}
		prg_ = prg;
		prg_size_ = prg_size;
		decode_run(reset, nullptr);
		if (nmi >= 0x8000u) {
			decode_run(nmi, nullptr);
		}
		if (irq >= 0x8000u) {
			decode_run(irq, nullptr);
		}
		return true;
	}

	/// Decodifica **una** instrucción en `pc` leyendo de memoria (RAM o PRG). Se usa
	/// para **código en RAM**, que puede automodificarse: se re-decodifica en cada
	/// ejecución (leer 1-3 bytes + tabla, barato) en vez de cachear, garantizando
	/// corrección. Marca `has`/`dec` (0 si el opcode es desconocido).
	/// \param pc Dirección de la instrucción.
	/// \param mem Memoria de la consola.
	void decode_one(eng::u16 pc, const NESMemory& mem) {
		const int opb = mem.read(pc);
		const OpcodeInfo& info = kOpcodeTable[opb];
		if (info.size == 0u) {
			has[pc] = 0u;
			return;
		}
		has[pc] = 1u;
		Dec& d = dec[pc];
		d.opcode = static_cast<eng::u8>(opb);
		d.size = info.size;
		d.operand = 0u;
		d.target = 0u;
		if (info.size >= 2u) {
			const int b1 = mem.read(static_cast<eng::u16>(pc + 1u));
			if (info.mode == AddrMode::Rel) {
				d.operand = static_cast<eng::u16>(b1);
				d.target = static_cast<eng::u16>(pc + 2u + static_cast<eng::s8>(b1));
			} else if (info.size == 2u) {
				d.operand = static_cast<eng::u16>(b1);
			} else {
				const int b2 = mem.read(static_cast<eng::u16>(pc + 2u));
				d.operand = static_cast<eng::u16>(b1 | (b2 << 8));
				if (info.mode == AddrMode::Abs) {
					d.target = d.operand; // JMP/JSR absolutos
				}
			}
		}
	}

	/// Decodifica el flujo de control alcanzable desde `start` (si aún no lo está),
	/// rellenando `dec`/`has`. Se puede llamar en caliente: cuando un salto
	/// calculado cae en una dirección sin decodificar, el ejecutor la decodifica al
	/// primer uso (no hay asignaciones: `dec`/`has` ya están reservados).
	/// \param start Dirección 6502 de la que partir.
	void decode_run(eng::u16 start, const NESMemory* mem) {
		if (prg_ == nullptr || prg_size_ == 0u) {
			return;
		}
		const eng::u8* prg = prg_;
		const eng::u32 prg_size = prg_size_;
		// Con `mem` se decodifica también **código en RAM** ($0000-$1FFF) leyendo
		// la RAM; sin él (build) solo la PRG. El lector evita regiones que no son
		// código (PPU/APU) en el caso de runtime.
		auto rd = [&](eng::u16 a) -> int {
			if (mem != nullptr) {
				return mem->read(a);
			}
			if (a < 0x8000u) {
				return -1;
			}
			eng::u32 off = static_cast<eng::u32>(a - 0x8000u);
			if (prg_size == 0x4000u) {
				off &= 0x3FFFu;
			}
			return off < prg_size ? prg[off] : -1;
		};
		eng::u16 wl[4096];
		int n = 0;
		auto push = [&](eng::u16 a) {
			const bool ok = (mem != nullptr) ? (a >= 0x8000u || a < 0x2000u) : (a >= 0x8000u);
			if (ok && n < 4096) {
				wl[n++] = a;
			}
		};
		push(start);
		while (n > 0) {
			eng::u16 pc = wl[--n];
			for (;;) {
				if (has[pc] != 0u) {
					break;
				}
				const int opb = rd(pc);
				if (opb < 0) {
					break;
				}
				const OpcodeInfo& info = kOpcodeTable[opb];
				if (info.size == 0u) {
					break;
				}
				has[pc] = 1u;
				Dec& d = dec[pc];
				d.opcode = static_cast<eng::u8>(opb);
				d.size = info.size;
				if (info.size >= 2u) {
					const int b1 = rd(static_cast<eng::u16>(pc + 1u));
					if (b1 < 0) {
						break;
					}
					if (info.mode == AddrMode::Rel) {
						d.operand = static_cast<eng::u16>(b1);
						d.target = static_cast<eng::u16>(pc + 2u + static_cast<eng::s8>(b1));
					} else if (info.size == 2u) {
						d.operand = static_cast<eng::u16>(b1);
					} else {
						const int b2 = rd(static_cast<eng::u16>(pc + 2u));
						if (b2 < 0) {
							break;
						}
						d.operand = static_cast<eng::u16>(b1 | (b2 << 8));
					}
				}
				const eng::util::StringView mn(info.mnemonic);
				const eng::u16 nxt = static_cast<eng::u16>(pc + info.size);
				if (info.mode == AddrMode::Rel) {
					push(d.target);
					push(nxt);
					break;
				}
				if (mn == eng::util::StringView("JMP")) {
					if (info.mode == AddrMode::Abs) {
						d.target = d.operand;
						push(d.target);
					}
					break;
				}
				if (mn == eng::util::StringView("JSR")) {
					d.target = d.operand;
					push(d.target);
					push(nxt);
					break;
				}
				if (mn == eng::util::StringView("RTS") || mn == eng::util::StringView("RTI") ||
				    mn == eng::util::StringView("BRK")) {
					break;
				}
				pc = nxt;
				if (mem == nullptr) {
					if (pc < 0x8000u) {
						break;
					}
				} else if (pc >= 0x2000u && pc < 0x8000u) {
					break; // fuera de RAM/PRG: no es código
				}
			}
		}
	}

	/// Libera la tabla decodificada.
	void destroy() {
		delete[] dec;
		delete[] has;
		dec = nullptr;
		has = nullptr;
	}

	/// Ejecuta una instrucción ya decodificada (`d` en la dirección `pc`).
	/// Los opcodes no cubiertos caen por el `default` del `switch` (devuelven 0).
	/// \return Ciclos consumidos (los cubiertos devuelven siempre >= 2).
	static int eval(CPU& cpu, NESMemory& mem, const Dec& d, eng::u16 pc) {
		const eng::u16 next = static_cast<eng::u16>(pc + d.size);

		// Accesos y direcciones efectivas (mismos redondeos que el intérprete).
		auto rd = [&](eng::u16 a) -> eng::u8 { return mem.read(a); };
		auto wr = [&](eng::u16 a, eng::u8 v) { mem.write(a, v); };
		auto zpx = [&](eng::u8 a) -> eng::u16 { return static_cast<eng::u8>(a + cpu.X); };
		auto zpy = [&](eng::u8 a) -> eng::u16 { return static_cast<eng::u8>(a + cpu.Y); };
		auto abx = [&](eng::u16 a) -> eng::u16 { return static_cast<eng::u16>(a + cpu.X); };
		auto aby = [&](eng::u16 a) -> eng::u16 { return static_cast<eng::u16>(a + cpu.Y); };
		auto izx = [&](eng::u8 a) -> eng::u16 {
			const eng::u8 zp = static_cast<eng::u8>(a + cpu.X);
			return static_cast<eng::u16>(rd(zp) |
				(static_cast<eng::u16>(rd(static_cast<eng::u8>(zp + 1u))) << 8u));
		};
		auto izy = [&](eng::u8 a) -> eng::u16 {
			return static_cast<eng::u16>(rd(a) |
				(static_cast<eng::u16>(rd(static_cast<eng::u8>(a + 1u))) << 8u));
		};
		auto px = [&](eng::u16 base, eng::u16 addr) -> int {
			return ((base & 0xFF00u) != (addr & 0xFF00u)) ? 1 : 0;
		};

		switch (d.opcode) {
		// ================= LDA =================
		case 0xA9: cpu.A = static_cast<eng::u8>(d.operand); cpu.set_nz(cpu.A); cpu.PC = next; return 2;
		case 0xA5: cpu.A = rd(d.operand); cpu.set_nz(cpu.A); cpu.PC = next; return 3;
		case 0xB5: cpu.A = rd(zpx(static_cast<eng::u8>(d.operand))); cpu.set_nz(cpu.A); cpu.PC = next; return 4;
		case 0xAD: cpu.A = rd(d.operand); cpu.set_nz(cpu.A); cpu.PC = next; return 4;
		case 0xBD: { const eng::u16 a = abx(d.operand); cpu.A = rd(a); cpu.set_nz(cpu.A); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0xB9: { const eng::u16 a = aby(d.operand); cpu.A = rd(a); cpu.set_nz(cpu.A); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0xA1: cpu.A = rd(izx(static_cast<eng::u8>(d.operand))); cpu.set_nz(cpu.A); cpu.PC = next; return 6;
		case 0xB1: { const eng::u16 p = izy(static_cast<eng::u8>(d.operand)); const eng::u16 a = aby(p); cpu.A = rd(a); cpu.set_nz(cpu.A); cpu.PC = next; return 5 + px(p, a); }
		// ================= LDX =================
		case 0xA2: cpu.X = static_cast<eng::u8>(d.operand); cpu.set_nz(cpu.X); cpu.PC = next; return 2;
		case 0xA6: cpu.X = rd(d.operand); cpu.set_nz(cpu.X); cpu.PC = next; return 3;
		case 0xB6: cpu.X = rd(zpy(static_cast<eng::u8>(d.operand))); cpu.set_nz(cpu.X); cpu.PC = next; return 4;
		case 0xAE: cpu.X = rd(d.operand); cpu.set_nz(cpu.X); cpu.PC = next; return 4;
		case 0xBE: { const eng::u16 a = aby(d.operand); cpu.X = rd(a); cpu.set_nz(cpu.X); cpu.PC = next; return 4 + px(d.operand, a); }
		// ================= LDY =================
		case 0xA0: cpu.Y = static_cast<eng::u8>(d.operand); cpu.set_nz(cpu.Y); cpu.PC = next; return 2;
		case 0xA4: cpu.Y = rd(d.operand); cpu.set_nz(cpu.Y); cpu.PC = next; return 3;
		case 0xB4: cpu.Y = rd(zpx(static_cast<eng::u8>(d.operand))); cpu.set_nz(cpu.Y); cpu.PC = next; return 4;
		case 0xAC: cpu.Y = rd(d.operand); cpu.set_nz(cpu.Y); cpu.PC = next; return 4;
		case 0xBC: { const eng::u16 a = abx(d.operand); cpu.Y = rd(a); cpu.set_nz(cpu.Y); cpu.PC = next; return 4 + px(d.operand, a); }
		// ================= STA / STX / STY =================
		case 0x85: wr(d.operand, cpu.A); cpu.PC = next; return 3;
		case 0x95: wr(zpx(static_cast<eng::u8>(d.operand)), cpu.A); cpu.PC = next; return 4;
		case 0x8D: wr(d.operand, cpu.A); cpu.PC = next; return 4;
		case 0x9D: wr(abx(d.operand), cpu.A); cpu.PC = next; return 5;
		case 0x99: wr(aby(d.operand), cpu.A); cpu.PC = next; return 5;
		case 0x81: wr(izx(static_cast<eng::u8>(d.operand)), cpu.A); cpu.PC = next; return 6;
		case 0x91: wr(aby(izy(static_cast<eng::u8>(d.operand))), cpu.A); cpu.PC = next; return 6;
		case 0x86: wr(d.operand, cpu.X); cpu.PC = next; return 3;
		case 0x96: wr(zpy(static_cast<eng::u8>(d.operand)), cpu.X); cpu.PC = next; return 4;
		case 0x8E: wr(d.operand, cpu.X); cpu.PC = next; return 4;
		case 0x84: wr(d.operand, cpu.Y); cpu.PC = next; return 3;
		case 0x94: wr(zpx(static_cast<eng::u8>(d.operand)), cpu.Y); cpu.PC = next; return 4;
		case 0x8C: wr(d.operand, cpu.Y); cpu.PC = next; return 4;
		// ================= transferencias / inc-dec / flags =================
		case 0xAA: cpu.TAX(); cpu.PC = next; return 2;
		case 0xA8: cpu.TAY(); cpu.PC = next; return 2;
		case 0x8A: cpu.TXA(); cpu.PC = next; return 2;
		case 0x98: cpu.TYA(); cpu.PC = next; return 2;
		case 0xBA: cpu.TSX(); cpu.PC = next; return 2;
		case 0x9A: cpu.SP = cpu.X; cpu.PC = next; return 2;
		case 0xE8: cpu.INX(); cpu.PC = next; return 2;
		case 0xC8: cpu.INY(); cpu.PC = next; return 2;
		case 0xCA: cpu.DEX(); cpu.PC = next; return 2;
		case 0x88: cpu.DEY(); cpu.PC = next; return 2;
		case 0x18: cpu.CLC(); cpu.PC = next; return 2;
		case 0x38: cpu.SEC(); cpu.PC = next; return 2;
		case 0x58: cpu.CLI(); cpu.PC = next; return 2;
		case 0x78: cpu.SEI(); cpu.PC = next; return 2;
		case 0xB8: cpu.CLV(); cpu.PC = next; return 2;
		case 0xD8: cpu.CLD(); cpu.PC = next; return 2;
		case 0xF8: cpu.SED(); cpu.PC = next; return 2;
		// ================= pila =================
		case 0x48: cpu.PHA(); cpu.PC = next; return 3;
		case 0x68: cpu.PLA(); cpu.PC = next; return 4;
		case 0x08: cpu.PHP(); cpu.PC = next; return 3;
		case 0x28: cpu.PLP(); cpu.PC = next; return 4;
		// ================= ADC / SBC =================
		case 0x69: cpu.ADC_impl(static_cast<eng::u8>(d.operand)); cpu.PC = next; return 2;
		case 0x65: cpu.ADC_impl(rd(d.operand)); cpu.PC = next; return 3;
		case 0x75: cpu.ADC_impl(rd(zpx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 4;
		case 0x6D: cpu.ADC_impl(rd(d.operand)); cpu.PC = next; return 4;
		case 0x7D: { const eng::u16 a = abx(d.operand); cpu.ADC_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0x79: { const eng::u16 a = aby(d.operand); cpu.ADC_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0x61: cpu.ADC_impl(rd(izx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 6;
		case 0x71: { const eng::u16 p = izy(static_cast<eng::u8>(d.operand)); const eng::u16 a = aby(p); cpu.ADC_impl(rd(a)); cpu.PC = next; return 5 + px(p, a); }
		case 0xE9: cpu.SBC_impl(static_cast<eng::u8>(d.operand)); cpu.PC = next; return 2;
		case 0xE5: cpu.SBC_impl(rd(d.operand)); cpu.PC = next; return 3;
		case 0xF5: cpu.SBC_impl(rd(zpx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 4;
		case 0xED: cpu.SBC_impl(rd(d.operand)); cpu.PC = next; return 4;
		case 0xFD: { const eng::u16 a = abx(d.operand); cpu.SBC_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0xF9: { const eng::u16 a = aby(d.operand); cpu.SBC_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0xE1: cpu.SBC_impl(rd(izx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 6;
		case 0xF1: { const eng::u16 p = izy(static_cast<eng::u8>(d.operand)); const eng::u16 a = aby(p); cpu.SBC_impl(rd(a)); cpu.PC = next; return 5 + px(p, a); }
		// ================= AND =================
		case 0x29: cpu.AND_impl(static_cast<eng::u8>(d.operand)); cpu.PC = next; return 2;
		case 0x25: cpu.AND_impl(rd(d.operand)); cpu.PC = next; return 3;
		case 0x35: cpu.AND_impl(rd(zpx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 4;
		case 0x2D: cpu.AND_impl(rd(d.operand)); cpu.PC = next; return 4;
		case 0x3D: { const eng::u16 a = abx(d.operand); cpu.AND_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0x39: { const eng::u16 a = aby(d.operand); cpu.AND_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0x21: cpu.AND_impl(rd(izx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 6;
		case 0x31: { const eng::u16 p = izy(static_cast<eng::u8>(d.operand)); const eng::u16 a = aby(p); cpu.AND_impl(rd(a)); cpu.PC = next; return 5 + px(p, a); }
		// ================= ORA =================
		case 0x09: cpu.ORA_impl(static_cast<eng::u8>(d.operand)); cpu.PC = next; return 2;
		case 0x05: cpu.ORA_impl(rd(d.operand)); cpu.PC = next; return 3;
		case 0x15: cpu.ORA_impl(rd(zpx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 4;
		case 0x0D: cpu.ORA_impl(rd(d.operand)); cpu.PC = next; return 4;
		case 0x1D: { const eng::u16 a = abx(d.operand); cpu.ORA_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0x19: { const eng::u16 a = aby(d.operand); cpu.ORA_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0x01: cpu.ORA_impl(rd(izx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 6;
		case 0x11: { const eng::u16 p = izy(static_cast<eng::u8>(d.operand)); const eng::u16 a = aby(p); cpu.ORA_impl(rd(a)); cpu.PC = next; return 5 + px(p, a); }
		// ================= EOR =================
		case 0x49: cpu.EOR_impl(static_cast<eng::u8>(d.operand)); cpu.PC = next; return 2;
		case 0x45: cpu.EOR_impl(rd(d.operand)); cpu.PC = next; return 3;
		case 0x55: cpu.EOR_impl(rd(zpx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 4;
		case 0x4D: cpu.EOR_impl(rd(d.operand)); cpu.PC = next; return 4;
		case 0x5D: { const eng::u16 a = abx(d.operand); cpu.EOR_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0x59: { const eng::u16 a = aby(d.operand); cpu.EOR_impl(rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0x41: cpu.EOR_impl(rd(izx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 6;
		case 0x51: { const eng::u16 p = izy(static_cast<eng::u8>(d.operand)); const eng::u16 a = aby(p); cpu.EOR_impl(rd(a)); cpu.PC = next; return 5 + px(p, a); }
		// ================= CMP / CPX / CPY =================
		case 0xC9: cpu.CMP_impl(cpu.A, static_cast<eng::u8>(d.operand)); cpu.PC = next; return 2;
		case 0xC5: cpu.CMP_impl(cpu.A, rd(d.operand)); cpu.PC = next; return 3;
		case 0xD5: cpu.CMP_impl(cpu.A, rd(zpx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 4;
		case 0xCD: cpu.CMP_impl(cpu.A, rd(d.operand)); cpu.PC = next; return 4;
		case 0xDD: { const eng::u16 a = abx(d.operand); cpu.CMP_impl(cpu.A, rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0xD9: { const eng::u16 a = aby(d.operand); cpu.CMP_impl(cpu.A, rd(a)); cpu.PC = next; return 4 + px(d.operand, a); }
		case 0xC1: cpu.CMP_impl(cpu.A, rd(izx(static_cast<eng::u8>(d.operand)))); cpu.PC = next; return 6;
		case 0xD1: { const eng::u16 p = izy(static_cast<eng::u8>(d.operand)); const eng::u16 a = aby(p); cpu.CMP_impl(cpu.A, rd(a)); cpu.PC = next; return 5 + px(p, a); }
		case 0xE0: cpu.CMP_impl(cpu.X, static_cast<eng::u8>(d.operand)); cpu.PC = next; return 2;
		case 0xE4: cpu.CMP_impl(cpu.X, rd(d.operand)); cpu.PC = next; return 3;
		case 0xEC: cpu.CMP_impl(cpu.X, rd(d.operand)); cpu.PC = next; return 4;
		case 0xC0: cpu.CMP_impl(cpu.Y, static_cast<eng::u8>(d.operand)); cpu.PC = next; return 2;
		case 0xC4: cpu.CMP_impl(cpu.Y, rd(d.operand)); cpu.PC = next; return 3;
		case 0xCC: cpu.CMP_impl(cpu.Y, rd(d.operand)); cpu.PC = next; return 4;
		// ================= BIT =================
		case 0x24: { const eng::u8 m = rd(d.operand); cpu.Z = (cpu.A & m) == 0u; cpu.V = (m & 0x40u) != 0u; cpu.N = (m & 0x80u) != 0u; cpu.PC = next; return 3; }
		case 0x2C: { const eng::u8 m = rd(d.operand); cpu.Z = (cpu.A & m) == 0u; cpu.V = (m & 0x40u) != 0u; cpu.N = (m & 0x80u) != 0u; cpu.PC = next; return 4; }
		// ================= INC / DEC de memoria =================
		case 0xE6: cpu.INC_at(d.operand); cpu.PC = next; return 5;
		case 0xF6: cpu.INC_at(zpx(static_cast<eng::u8>(d.operand))); cpu.PC = next; return 6;
		case 0xEE: cpu.INC_at(d.operand); cpu.PC = next; return 6;
		case 0xFE: cpu.INC_at(abx(d.operand)); cpu.PC = next; return 7;
		case 0xC6: cpu.DEC_at(d.operand); cpu.PC = next; return 5;
		case 0xD6: cpu.DEC_at(zpx(static_cast<eng::u8>(d.operand))); cpu.PC = next; return 6;
		case 0xCE: cpu.DEC_at(d.operand); cpu.PC = next; return 6;
		case 0xDE: cpu.DEC_at(abx(d.operand)); cpu.PC = next; return 7;
		// ================= ASL / LSR / ROL / ROR =================
		case 0x0A: cpu.ASL_A(); cpu.PC = next; return 2;
		case 0x06: cpu.ASL_at(d.operand); cpu.PC = next; return 5;
		case 0x16: cpu.ASL_at(zpx(static_cast<eng::u8>(d.operand))); cpu.PC = next; return 6;
		case 0x0E: cpu.ASL_at(d.operand); cpu.PC = next; return 6;
		case 0x1E: cpu.ASL_at(abx(d.operand)); cpu.PC = next; return 7;
		case 0x4A: cpu.LSR_A(); cpu.PC = next; return 2;
		case 0x46: cpu.LSR_at(d.operand); cpu.PC = next; return 5;
		case 0x56: cpu.LSR_at(zpx(static_cast<eng::u8>(d.operand))); cpu.PC = next; return 6;
		case 0x4E: cpu.LSR_at(d.operand); cpu.PC = next; return 6;
		case 0x5E: cpu.LSR_at(abx(d.operand)); cpu.PC = next; return 7;
		case 0x2A: cpu.ROL_A(); cpu.PC = next; return 2;
		case 0x26: cpu.ROL_at(d.operand); cpu.PC = next; return 5;
		case 0x36: cpu.ROL_at(zpx(static_cast<eng::u8>(d.operand))); cpu.PC = next; return 6;
		case 0x2E: cpu.ROL_at(d.operand); cpu.PC = next; return 6;
		case 0x3E: cpu.ROL_at(abx(d.operand)); cpu.PC = next; return 7;
		case 0x6A: cpu.ROR_A(); cpu.PC = next; return 2;
		case 0x66: cpu.ROR_at(d.operand); cpu.PC = next; return 5;
		case 0x76: cpu.ROR_at(zpx(static_cast<eng::u8>(d.operand))); cpu.PC = next; return 6;
		case 0x6E: cpu.ROR_at(d.operand); cpu.PC = next; return 6;
		case 0x7E: cpu.ROR_at(abx(d.operand)); cpu.PC = next; return 7;
		// ================= NOP =================
		case 0xEA: cpu.PC = next; return 2;
		// ================= saltos =================
		case 0x4C: cpu.PC = d.target; return 3;
		case 0x6C: {
			const eng::u16 lo = rd(d.operand);
			const eng::u16 hi = rd(static_cast<eng::u16>((d.operand & 0xFF00u) |
								      ((d.operand + 1u) & 0x00FFu)));
			cpu.PC = static_cast<eng::u16>((hi << 8u) | lo);
			return 5;
		}
		case 0x20: cpu.push16(static_cast<eng::u16>(next - 1u)); cpu.PC = d.target; return 6;
		case 0x60: cpu.PC = static_cast<eng::u16>(cpu.pull16() + 1u); return 6;
		// ================= RTI =================
		case 0x40: {
			const eng::u8 p = static_cast<eng::u8>((cpu.pull() & ~0x10u) | 0x20u);
			cpu.N = (p & 0x80u) != 0u; cpu.V = (p & 0x40u) != 0u; cpu.D = (p & 0x08u) != 0u;
			cpu.I = (p & 0x04u) != 0u; cpu.Z = (p & 0x02u) != 0u; cpu.C = (p & 0x01u) != 0u;
			cpu.PC = cpu.pull16();
			return 6;
		}
		// ================= ILEGALES: SLO (ASL+ORA) =================
		case 0x03: { const eng::u16 a = izx(static_cast<eng::u8>(d.operand)); cpu.ASL_at(a); cpu.ORA_impl(rd(a)); cpu.PC = next; return 8; }
		case 0x07: { cpu.ASL_at(d.operand); cpu.ORA_impl(rd(d.operand)); cpu.PC = next; return 5; }
		case 0x0F: { cpu.ASL_at(d.operand); cpu.ORA_impl(rd(d.operand)); cpu.PC = next; return 6; }
		case 0x13: { const eng::u16 a = aby(izy(static_cast<eng::u8>(d.operand))); cpu.ASL_at(a); cpu.ORA_impl(rd(a)); cpu.PC = next; return 8; }
		case 0x17: { const eng::u16 a = zpx(static_cast<eng::u8>(d.operand)); cpu.ASL_at(a); cpu.ORA_impl(rd(a)); cpu.PC = next; return 6; }
		case 0x1B: { const eng::u16 a = aby(d.operand); cpu.ASL_at(a); cpu.ORA_impl(rd(a)); cpu.PC = next; return 7; }
		case 0x1F: { const eng::u16 a = abx(d.operand); cpu.ASL_at(a); cpu.ORA_impl(rd(a)); cpu.PC = next; return 7; }
		// ================= ILEGALES: RLA (ROL+AND) =================
		case 0x23: { const eng::u16 a = izx(static_cast<eng::u8>(d.operand)); cpu.ROL_at(a); cpu.AND_impl(rd(a)); cpu.PC = next; return 8; }
		case 0x27: { cpu.ROL_at(d.operand); cpu.AND_impl(rd(d.operand)); cpu.PC = next; return 5; }
		case 0x2F: { cpu.ROL_at(d.operand); cpu.AND_impl(rd(d.operand)); cpu.PC = next; return 6; }
		case 0x33: { const eng::u16 a = aby(izy(static_cast<eng::u8>(d.operand))); cpu.ROL_at(a); cpu.AND_impl(rd(a)); cpu.PC = next; return 8; }
		case 0x37: { const eng::u16 a = zpx(static_cast<eng::u8>(d.operand)); cpu.ROL_at(a); cpu.AND_impl(rd(a)); cpu.PC = next; return 6; }
		case 0x3B: { const eng::u16 a = aby(d.operand); cpu.ROL_at(a); cpu.AND_impl(rd(a)); cpu.PC = next; return 7; }
		case 0x3F: { const eng::u16 a = abx(d.operand); cpu.ROL_at(a); cpu.AND_impl(rd(a)); cpu.PC = next; return 7; }
		// ================= ILEGALES: SRE (LSR+EOR) =================
		case 0x43: { const eng::u16 a = izx(static_cast<eng::u8>(d.operand)); cpu.LSR_at(a); cpu.EOR_impl(rd(a)); cpu.PC = next; return 8; }
		case 0x47: { cpu.LSR_at(d.operand); cpu.EOR_impl(rd(d.operand)); cpu.PC = next; return 5; }
		case 0x4F: { cpu.LSR_at(d.operand); cpu.EOR_impl(rd(d.operand)); cpu.PC = next; return 6; }
		case 0x53: { const eng::u16 a = aby(izy(static_cast<eng::u8>(d.operand))); cpu.LSR_at(a); cpu.EOR_impl(rd(a)); cpu.PC = next; return 8; }
		case 0x57: { const eng::u16 a = zpx(static_cast<eng::u8>(d.operand)); cpu.LSR_at(a); cpu.EOR_impl(rd(a)); cpu.PC = next; return 6; }
		case 0x5B: { const eng::u16 a = aby(d.operand); cpu.LSR_at(a); cpu.EOR_impl(rd(a)); cpu.PC = next; return 7; }
		case 0x5F: { const eng::u16 a = abx(d.operand); cpu.LSR_at(a); cpu.EOR_impl(rd(a)); cpu.PC = next; return 7; }
		// ================= ILEGALES: RRA (ROR+ADC) =================
		case 0x63: { const eng::u16 a = izx(static_cast<eng::u8>(d.operand)); cpu.ROR_at(a); cpu.ADC_impl(rd(a)); cpu.PC = next; return 8; }
		case 0x67: { cpu.ROR_at(d.operand); cpu.ADC_impl(rd(d.operand)); cpu.PC = next; return 5; }
		case 0x6F: { cpu.ROR_at(d.operand); cpu.ADC_impl(rd(d.operand)); cpu.PC = next; return 6; }
		case 0x73: { const eng::u16 a = aby(izy(static_cast<eng::u8>(d.operand))); cpu.ROR_at(a); cpu.ADC_impl(rd(a)); cpu.PC = next; return 8; }
		case 0x77: { const eng::u16 a = zpx(static_cast<eng::u8>(d.operand)); cpu.ROR_at(a); cpu.ADC_impl(rd(a)); cpu.PC = next; return 6; }
		case 0x7B: { const eng::u16 a = aby(d.operand); cpu.ROR_at(a); cpu.ADC_impl(rd(a)); cpu.PC = next; return 7; }
		case 0x7F: { const eng::u16 a = abx(d.operand); cpu.ROR_at(a); cpu.ADC_impl(rd(a)); cpu.PC = next; return 7; }
		// ================= ILEGALES: SAX (A&X) =================
		case 0x83: wr(izx(static_cast<eng::u8>(d.operand)), static_cast<eng::u8>(cpu.A & cpu.X)); cpu.PC = next; return 6;
		case 0x87: wr(d.operand, static_cast<eng::u8>(cpu.A & cpu.X)); cpu.PC = next; return 3;
		case 0x8F: wr(d.operand, static_cast<eng::u8>(cpu.A & cpu.X)); cpu.PC = next; return 4;
		case 0x97: wr(zpy(static_cast<eng::u8>(d.operand)), static_cast<eng::u8>(cpu.A & cpu.X)); cpu.PC = next; return 4;
		// ================= ILEGALES: LAX (A=X=load) =================
		case 0xA3: cpu.A = cpu.X = rd(izx(static_cast<eng::u8>(d.operand))); cpu.set_nz(cpu.A); cpu.PC = next; return 6;
		case 0xA7: cpu.A = cpu.X = rd(d.operand); cpu.set_nz(cpu.A); cpu.PC = next; return 3;
		case 0xAB: cpu.A = cpu.X = static_cast<eng::u8>(d.operand); cpu.set_nz(cpu.A); cpu.PC = next; return 2;
		case 0xAF: cpu.A = cpu.X = rd(d.operand); cpu.set_nz(cpu.A); cpu.PC = next; return 4;
		case 0xB3: { const eng::u16 p = izy(static_cast<eng::u8>(d.operand)); const eng::u16 a = aby(p); cpu.A = cpu.X = rd(a); cpu.set_nz(cpu.A); cpu.PC = next; return 5 + px(p, a); }
		case 0xB7: cpu.A = cpu.X = rd(zpy(static_cast<eng::u8>(d.operand))); cpu.set_nz(cpu.A); cpu.PC = next; return 4;
		case 0xBF: { const eng::u16 a = aby(d.operand); cpu.A = cpu.X = rd(a); cpu.set_nz(cpu.A); cpu.PC = next; return 4 + px(d.operand, a); }
		// ================= ILEGALES: DCP (DEC+CMP) =================
		case 0xC3: { const eng::u16 a = izx(static_cast<eng::u8>(d.operand)); cpu.DEC_at(a); cpu.CMP_impl(cpu.A, rd(a)); cpu.PC = next; return 8; }
		case 0xC7: { cpu.DEC_at(d.operand); cpu.CMP_impl(cpu.A, rd(d.operand)); cpu.PC = next; return 5; }
		case 0xCF: { cpu.DEC_at(d.operand); cpu.CMP_impl(cpu.A, rd(d.operand)); cpu.PC = next; return 6; }
		case 0xD3: { const eng::u16 a = aby(izy(static_cast<eng::u8>(d.operand))); cpu.DEC_at(a); cpu.CMP_impl(cpu.A, rd(a)); cpu.PC = next; return 8; }
		case 0xD7: { const eng::u16 a = zpx(static_cast<eng::u8>(d.operand)); cpu.DEC_at(a); cpu.CMP_impl(cpu.A, rd(a)); cpu.PC = next; return 6; }
		case 0xDB: { const eng::u16 a = aby(d.operand); cpu.DEC_at(a); cpu.CMP_impl(cpu.A, rd(a)); cpu.PC = next; return 7; }
		case 0xDF: { const eng::u16 a = abx(d.operand); cpu.DEC_at(a); cpu.CMP_impl(cpu.A, rd(a)); cpu.PC = next; return 7; }
		// ================= ILEGALES: ISB (INC+SBC) =================
		case 0xE3: { const eng::u16 a = izx(static_cast<eng::u8>(d.operand)); cpu.INC_at(a); cpu.SBC_impl(rd(a)); cpu.PC = next; return 8; }
		case 0xE7: { cpu.INC_at(d.operand); cpu.SBC_impl(rd(d.operand)); cpu.PC = next; return 5; }
		case 0xEF: { cpu.INC_at(d.operand); cpu.SBC_impl(rd(d.operand)); cpu.PC = next; return 6; }
		case 0xF3: { const eng::u16 a = aby(izy(static_cast<eng::u8>(d.operand))); cpu.INC_at(a); cpu.SBC_impl(rd(a)); cpu.PC = next; return 8; }
		case 0xF7: { const eng::u16 a = zpx(static_cast<eng::u8>(d.operand)); cpu.INC_at(a); cpu.SBC_impl(rd(a)); cpu.PC = next; return 6; }
		case 0xFB: { const eng::u16 a = aby(d.operand); cpu.INC_at(a); cpu.SBC_impl(rd(a)); cpu.PC = next; return 7; }
		case 0xFF: { const eng::u16 a = abx(d.operand); cpu.INC_at(a); cpu.SBC_impl(rd(a)); cpu.PC = next; return 7; }
		// ================= ILEGALES: misceláneos =================
		case 0x0B: case 0x2B: cpu.AND_impl(static_cast<eng::u8>(d.operand)); cpu.C = (cpu.A & 0x80u) != 0u; cpu.PC = next; return 2; // ANC
		case 0x4B: cpu.AND_impl(static_cast<eng::u8>(d.operand)); cpu.LSR_A(); cpu.PC = next; return 2;                        // ALR
		case 0x6B: { cpu.AND_impl(static_cast<eng::u8>(d.operand)); const eng::u8 c = cpu.C ? 1u : 0u; cpu.A = static_cast<eng::u8>((cpu.A >> 1u) | (c << 7u)); cpu.set_nz(cpu.A); cpu.C = (cpu.A & 0x40u) != 0u; cpu.V = (((static_cast<unsigned>(cpu.A) >> 6u) ^ (static_cast<unsigned>(cpu.A) >> 5u)) & 1u) != 0u; cpu.PC = next; return 2; } // ARR
		case 0xCB: { const eng::u8 m = static_cast<eng::u8>(d.operand); const eng::u8 ax = static_cast<eng::u8>(cpu.A & cpu.X); cpu.X = static_cast<eng::u8>(ax - m); cpu.C = ax >= m; cpu.set_nz(cpu.X); cpu.PC = next; return 2; } // SBX
		case 0xBB: { const eng::u16 a = aby(d.operand); const eng::u8 v = static_cast<eng::u8>(rd(a) & cpu.SP); cpu.A = cpu.X = cpu.SP = v; cpu.set_nz(cpu.A); cpu.PC = next; return 4 + px(d.operand, a); } // LAS
		case 0x93: wr(aby(izy(static_cast<eng::u8>(d.operand))), static_cast<eng::u8>(cpu.A & cpu.X)); cpu.PC = next; return 6; // SHA (iz),Y
		case 0x9F: wr(aby(d.operand), static_cast<eng::u8>(cpu.A & cpu.X)); cpu.PC = next; return 5;                        // SHA abs,Y
		case 0x9E: wr(aby(d.operand), cpu.X); cpu.PC = next; return 5;                                                      // SHX abs,Y
		case 0x9C: wr(abx(d.operand), cpu.Y); cpu.PC = next; return 5;                                                      // SHY abs,X
		case 0x9B: cpu.SP = static_cast<eng::u8>(cpu.A & cpu.X); wr(aby(d.operand), cpu.SP); cpu.PC = next; return 5;       // TAS abs,Y
		// ================= ILEGALES: NOP =================
		case 0x1A: case 0x3A: case 0x5A: case 0x7A: case 0xDA: case 0xFA: cpu.PC = next; return 2;
		case 0x80: case 0x82: case 0x89: case 0xC2: case 0xE2: cpu.PC = next; return 2;
		case 0x04: case 0x44: case 0x64: (void)rd(d.operand); cpu.PC = next; return 3;
		case 0x0C: (void)rd(d.operand); cpu.PC = next; return 4;
		case 0x14: case 0x34: case 0x54: case 0x74: case 0xD4: case 0xF4: (void)rd(zpx(static_cast<eng::u8>(d.operand))); cpu.PC = next; return 4;
		case 0x1C: case 0x3C: case 0x5C: case 0x7C: case 0xDC: case 0xFC: { const eng::u16 a = abx(d.operand); (void)rd(a); cpu.PC = next; return 4 + px(d.operand, a); }
		// ================= ramas =================
		case 0x10: case 0x30: case 0x50: case 0x70: case 0x90: case 0xB0: case 0xD0: case 0xF0: {
			bool taken = false;
			switch (d.opcode) {
			case 0x10: taken = !cpu.N; break;
			case 0x30: taken = cpu.N; break;
			case 0x50: taken = !cpu.V; break;
			case 0x70: taken = cpu.V; break;
			case 0x90: taken = !cpu.C; break;
			case 0xB0: taken = cpu.C; break;
			case 0xD0: taken = !cpu.Z; break;
			case 0xF0: taken = cpu.Z; break;
			}
			if (taken) {
				cpu.PC = d.target;
				return 3 + (((next & 0xFF00u) != (d.target & 0xFF00u)) ? 1 : 0);
			}
			cpu.PC = next;
			return 2;
		}
		default:
			return 0; // no cubierto: cae al intérprete
		}
	}

	/// Hook compatible con `NesSystem::FastStep`: ejecuta **una** instrucción.
	/// \return Ciclos, o 0 si la dirección/opcode necesita el intérprete.
	static int step(void* ctx, CPU& cpu, NESMemory& mem) {
		FastCpu* self = static_cast<FastCpu*>(ctx);
		if (self->dec == nullptr || self->has == nullptr) {
			return 0;
		}
		const eng::u16 pc = cpu.PC;
		if (pc < 0x8000u) {
			self->decode_one(pc, mem); // código en RAM: re-decodifica (automodificable)
			if (self->has[pc] == 0u) {
				return 0;
			}
		} else if (self->has[pc] == 0u) {
			self->decode_run(pc, &mem); // salto calculado: decodifica al primer uso
			if (self->has[pc] == 0u) {
				return 0;
			}
		}
		const Dec& d = self->dec[pc];
		if (!covers(d.opcode)) {
			return 0;
		}
		return eval(cpu, mem, d, pc);
	}

	/// ¿La instrucción `op` transfiere el control (fin de basic block)?
	/// \param op Byte de opcode.
	/// \return `true` para ramas, `JMP`, `JSR` y `RTS`.
	[[nodiscard]] static constexpr bool is_control(eng::u8 op) noexcept {
		switch (op) {
		case 0x10: case 0x30: case 0x50: case 0x70: case 0x90: case 0xB0: case 0xD0: case 0xF0:
		case 0x4C: case 0x6C: case 0x20: case 0x60:
			return true;
		default:
			return false;
		}
	}

	/// ¿`op` es una rama relativa condicional?
	/// \param op Byte de opcode.
	/// \return `true` para `BPL/BMI/BVC/BVS/BCC/BCS/BNE/BEQ`.
	[[nodiscard]] static constexpr bool is_branch(eng::u8 op) noexcept {
		switch (op) {
		case 0x10: case 0x30: case 0x50: case 0x70: case 0x90: case 0xB0: case 0xD0: case 0xF0:
			return true;
		default:
			return false;
		}
	}

	/// Hook compatible con `NesSystem::FastRun`: ejecuta un **bloque** de
	/// instrucciones hasta que aparece un salto/rama, un opcode no cubierto, o el
	/// bloque agotaría el `budget` (para no cruzar una frontera de scanline dentro
	/// del bloque y no alterar el timing de PPU/NMI).
	/// \param budget Ciclos de CPU hasta el próximo límite de scanline (0 = ninguno).
	/// \param out_instrs Nº de instrucciones ejecutadas (salida).
	/// \return Ciclos totales del bloque; 0 si la primera instrucción necesita el
	///         intérprete (el llamante hace entonces un único `interp.step`).
	static int run_block(void* ctx, CPU& cpu, NESMemory& mem, int budget, int* out_instrs) {
		FastCpu* self = static_cast<FastCpu*>(ctx);
		if (out_instrs != nullptr) {
			*out_instrs = 0;
		}
		if (self->dec == nullptr || self->has == nullptr) {
			return 0;
		}
		int total = 0;
		for (;;) {
			// Garantiza no cruzar la línea salvo la primera instrucción forzosa.
			if (total != 0 && total + 7 > budget) {
				break;
			}
			const eng::u16 pc = cpu.PC;
			if (pc < 0x8000u) {
				self->decode_one(pc, mem); // código en RAM: re-decodifica (automodificable)
				if (self->has[pc] == 0u) {
					break;
				}
			} else if (self->has[pc] == 0u) {
				if (total != 0) {
					break; // deja la decodificación para el siguiente bloque
				}
				self->decode_run(pc, &mem); // salto calculado: decodifica al primer uso
				if (self->has[pc] == 0u) {
					break;
				}
			}
			const Dec& d = self->dec[pc];
			// `eval` devuelve 0 sin efectos para opcodes no cubiertos: se corta
			// aquí y el llamante ejecuta esa instrucción con el intérprete.
			const eng::u8 op = d.opcode;
			const int c = eval(cpu, mem, d, pc);
			if (c == 0) {
				break;
			}
			total += c;
			if (out_instrs != nullptr) {
				++*out_instrs;
			}
			// Fin de bloque en saltos/llamadas/retornos y en ramas **tomadas**;
			// una rama no tomada cae (se sigue en línea dentro del mismo bloque).
			const bool taken_branch =
				is_branch(op) && cpu.PC != static_cast<eng::u16>(pc + d.size);
			if (is_control(op) && !is_branch(op)) {
				break;
			}
			if (taken_branch) {
				break;
			}
		}
		return total;
	}
};

} // namespace n2a
