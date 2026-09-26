// cycles_audit.cpp — compara los ciclos que el **intérprete** devuelve por
// instrucción con la fórmula que emite el codegen (base + penalización de
// página/rama) para localizar discrepancias de temporalización.
//
// Uso: cycles_audit <rom.nes> [steps=40000]

#include <cstdio>
#include <cstdlib>

#include "../../tools/transpiler/src/transpiler.hpp" // op_base_cycles / op_read_indexed_penalty
#include "../include/nes_system.hpp"
#include "../host/rom_loader.hpp"

namespace {
n2a::LoadedRom g_rom;
}

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: cycles_audit <rom.nes> [steps]\n");
		return 1;
	}
	const int steps = (argc > 2) ? std::atoi(argv[2]) : 40000;

	n2a::NesSystem sys;
	if (!n2a::load_ines(argv[1], g_rom)) {
		std::printf("error: no se pudo cargar\n");
		return 1;
	}
	sys.load_mapper(g_rom.mapper);
	sys.reset();

	int mismatches = 0;
	for (int i = 0; i < steps; ++i) {
		const eng::u16 pc = sys.cpu.PC;
		const eng::u8 op = sys.mem.read(pc);
		const n2a::OpcodeInfo& info = n2a::kOpcodeTable[op];
		const eng::u8 x = sys.cpu.X;
		const eng::u8 y = sys.cpu.Y;
		const int actual = sys.step_instruction();

		int expect = n2a::op_base_cycles(op);
		if (info.mode == n2a::AddrMode::Rel) {
			const eng::s8 off = static_cast<eng::s8>(sys.mem.read(static_cast<eng::u16>(pc + 1u)));
			const eng::u16 tgt = static_cast<eng::u16>(pc + 2u + off);
			if (sys.cpu.PC == tgt) {
				expect += 1;
				if (((pc + 2u) & 0xFF00u) != (tgt & 0xFF00u)) {
					expect += 1;
				}
			}
		} else if (n2a::op_read_indexed_penalty(op)) {
			if (info.mode == n2a::AddrMode::AbsX) {
				const eng::u16 b = static_cast<eng::u16>(sys.mem.read(static_cast<eng::u16>(pc + 1u)) |
					(static_cast<eng::u16>(sys.mem.read(static_cast<eng::u16>(pc + 2u))) << 8u));
				if (((b & 0xFFu) + x) > 0xFFu) expect += 1;
			} else if (info.mode == n2a::AddrMode::AbsY) {
				const eng::u16 b = static_cast<eng::u16>(sys.mem.read(static_cast<eng::u16>(pc + 1u)) |
					(static_cast<eng::u16>(sys.mem.read(static_cast<eng::u16>(pc + 2u))) << 8u));
				if (((b & 0xFFu) + y) > 0xFFu) expect += 1;
			} else if (info.mode == n2a::AddrMode::IndY) {
				const eng::u8 zp = static_cast<eng::u8>(sys.mem.read(static_cast<eng::u16>(pc + 1u)));
				const eng::u16 p = static_cast<eng::u16>(sys.mem.read(zp) |
					(static_cast<eng::u16>(sys.mem.read(static_cast<eng::u8>(zp + 1u))) << 8u));
				if (((p & 0xFFu) + y) > 0xFFu) expect += 1;
			}
		}
		if (actual != expect) {
			std::printf("pc=%04X op=%02X %-3s actual=%d esperado=%d\n", pc, op, info.mnemonic,
				    actual, expect);
			if (++mismatches >= 20) {
				break;
			}
		}
	}
	std::printf("mismatches=%d (steps=%d)\n", mismatches, steps);
	return 0;
}
