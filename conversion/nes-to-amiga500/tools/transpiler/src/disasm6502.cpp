// disasm6502 — desensamblador minimo para diagnostico (reutiliza kOpcodeTable).
//
// Uso: disasm6502 <rom.nes> <dir_hex> [n_instrucciones]
//   p. ej. disasm6502 build/smb.nes 8720 24

#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "opcodes.hpp"

namespace {
eng::u8 g_prg[0x40000];
eng::usize g_n = 0;

eng::u8 at(eng::usize off) { return off < g_n ? g_prg[off] : 0u; }
} // namespace

int main(int argc, char** argv) {
	if (argc < 3) {
		std::printf("uso: disasm6502 <rom.nes> <dir_hex> [n]\n");
		return 2;
	}
	std::FILE* f = std::fopen(argv[1], "rb");
	if (f == nullptr) {
		std::printf("error: no se pudo abrir\n");
		return 2;
	}
	eng::u8 hdr[16];
	if (std::fread(hdr, 1, 16, f) != 16) {
		std::fclose(f);
		return 2;
	}
	const eng::usize trainer = (hdr[6] & 0x04u) ? 512u : 0u;
	std::fseek(f, static_cast<long>(16u + trainer), SEEK_SET);
	g_n = std::fread(g_prg, 1, sizeof g_prg, f);
	std::fclose(f);

	const unsigned addr = static_cast<unsigned>(std::strtoul(argv[2], nullptr, 16));
	int count = (argc > 3) ? std::atoi(argv[3]) : 24;
	bool last16k = false;
	for (int i = 3; i < argc; ++i) {
		if (std::strcmp(argv[i], "--last16k") == 0) last16k = true;
	}
	eng::usize off = addr - 0x8000u;
	if (last16k && addr >= 0xC000u && g_n >= 0x4000u) {
		off = g_n - 0x4000u + (addr - 0xC000u); // ultimo banco de 16 KB
	}
	unsigned pc = addr;
	for (int k = 0; k < count && off < g_n; ++k) {
		const eng::u8 op = at(off);
		const n2a::OpcodeInfo& info = n2a::kOpcodeTable[op];
		const eng::u8 sz = info.size != 0u ? info.size : 1u;
		std::printf("%04X: %02X", pc, op);
		for (eng::u8 b = 1; b < sz; ++b) {
			std::printf(" %02X", at(off + b));
		}
		for (eng::u8 b = sz; b < 3; ++b) {
			std::printf("   ");
		}
		std::printf("  %-4s", info.mnemonic != nullptr ? info.mnemonic : "???");
		if (sz == 2) {
			std::printf(" $%02X", at(off + 1));
		} else if (sz == 3) {
			std::printf(" $%02X%02X", at(off + 2), at(off + 1));
		}
		std::printf("\n");
		off += sz;
		pc += sz;
	}
	return 0;
}
