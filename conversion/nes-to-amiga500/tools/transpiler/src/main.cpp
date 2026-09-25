// nes_transpiler (fase 1) - ROM NES (iNES/NROM) -> C++23 sobre eng/core.
//
// Uso:
//   nes_transpiler <input.nes> [-o <output.cpp>]
//   nes_transpiler --emit-mini-rom   <output.nes>   ROM minima propia (LDA/STA/INX/BRK)
//   nes_transpiler --emit-branch-rom <output.nes>   ROM propia con bucle/ADC/BNE/JSR/RTS
//   nes_transpiler --help
//
// Construccion y diseno: ver docs/TRANSPILER.md y tools/transpiler/README.md.

#include "host_io.hpp"
#include "transpiler.hpp"

#include <eng/core/types/types.hpp>
#include <eng/core/util/dynamic_string.hpp>
#include <eng/core/util/heap_alloc.hpp>
#include <eng/core/util/string_view.hpp>

namespace {

using n2a::ByteBuffer;
using n2a::Dyn;

/// Envuelve `prog` en una ROM iNES NROM (16 KB de PRG) con los tres vectores a
/// $8000. Contenido **propio** (homebrew minimo), sin material de terceros.
bool write_ines_rom(const char* path, const eng::u8* prog, eng::usize prog_len) {
	constexpr eng::u32 kPrg = 16384u;
	ByteBuffer rom;
	if (!rom.resize(16u + kPrg, 0u)) {
		return false;
	}
	rom[0] = 'N';
	rom[1] = 'E';
	rom[2] = 'S';
	rom[3] = 0x1Au;
	rom[4] = 1u; // una pagina de PRG (16 KB)
	rom[5] = 0u; // sin CHR
	rom[6] = 0u; // mapper 0, sin trainer
	rom[7] = 0u;

	for (eng::usize i = 0; i < prog_len; ++i) {
		rom[16u + i] = prog[i];
	}
	auto set_vec = [&](eng::usize off, eng::u16 value) {
		rom[16u + off] = static_cast<eng::u8>(value & 0xFFu);
		rom[16u + off + 1u] = static_cast<eng::u8>(value >> 8u);
	};
	set_vec(0x3FFAu, 0x8000u); // NMI
	set_vec(0x3FFCu, 0x8000u); // Reset
	set_vec(0x3FFEu, 0x8000u); // IRQ

	return n2a::write_whole_file(
		path, eng::util::StringView(reinterpret_cast<const char*>(rom.data()), rom.size()));
}

// 8000: LDA #$23 ; STA $00 ; INX ; BRK
constexpr eng::u8 kMiniProg[] = {0xA9u, 0x23u, 0x85u, 0x00u, 0xE8u, 0x00u};

// Bucle de 5 iteraciones + llamada a subrutina:
//  8000: LDX #$00         A2 00
//  8002: LDA #$00         A9 00
//  8004: CLC              18
//  8005: ADC #$01         69 01   <- destino del BNE
//  8007: INX              E8
//  8008: CPX #$05         E0 05
//  800A: BNE $8005        D0 F9
//  800C: JSR $8010        20 10 80
//  800F: BRK              00
//  8010: STA $10          85 10
//  8012: RTS              60
constexpr eng::u8 kBranchProg[] = {
	0xA2u, 0x00u, 0xA9u, 0x00u, 0x18u, 0x69u, 0x01u, 0xE8u, 0xE0u, 0x05u,
	0xD0u, 0xF9u, 0x20u, 0x10u, 0x80u, 0x00u, 0x85u, 0x10u, 0x60u,
};

void print_usage(const char* argv0) {
	(void)argv0;
	n2a::out_line("nes_transpiler (fase 1) - NES (iNES/NROM) -> C++23 (eng/core)");
	n2a::out_line("Uso: nes_transpiler <input.nes> [-o <output.cpp>]");
	n2a::out_line("     --emit-mini-rom   <output.nes>");
	n2a::out_line("     --emit-branch-rom <output.nes>");
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		print_usage(argv[0]);
		return 1;
	}

	eng::util::StringView input;
	eng::util::StringView output("generated_game.cpp");
	int emit = 0; // 0 = transpilar, 1 = mini, 2 = branch

	for (int i = 1; i < argc; ++i) {
		const eng::util::StringView arg(argv[i]);
		if (arg == "--help" || arg == "-h") {
			print_usage(argv[0]);
			return 0;
		}
		if ((arg == "--emit-mini-rom" || arg == "--emit-branch-rom") && i + 1 < argc) {
			emit = (arg == "--emit-mini-rom") ? 1 : 2;
			input = eng::util::StringView(argv[++i]);
			continue;
		}
		if (arg == "-o" && i + 1 < argc) {
			output = eng::util::StringView(argv[++i]);
			continue;
		}
		input = arg;
	}

	if (emit != 0) {
		const bool ok = (emit == 1) ? write_ines_rom(input.data(), kMiniProg, sizeof(kMiniProg))
					    : write_ines_rom(input.data(), kBranchProg, sizeof(kBranchProg));
		if (!ok) {
			n2a::err_line("error: no se pudo escribir la ROM de prueba");
			return 1;
		}
		n2a::out_line("ROM de prueba escrita.");
		return 0;
	}

	if (input.empty()) {
		print_usage(argv[0]);
		return 1;
	}

	ByteBuffer rom;
	if (!n2a::read_whole_file(input.data(), rom)) {
		n2a::err_line("error: no se pudo leer el fichero de entrada");
		return 1;
	}

	n2a::Transpiler tp;
	if (!tp.load(rom.data(), rom.size())) {
		n2a::err_line("error: ROM no valida (se espera iNES NROM, mapper 0)");
		return 1;
	}
	tp.disassemble();
	tp.build_basic_blocks();

	Dyn generated;
	tp.generate(generated);
	if (!n2a::write_whole_file(output.data(), generated.view())) {
		n2a::err_line("error: no se pudo escribir el fichero de salida");
		return 1;
	}

	Dyn summary;
	summary.append("OK  instrucciones=");
	summary.append_u32(static_cast<eng::u32>(tp.instruction_count()));
	summary.append("  bloques=");
	summary.append_u32(static_cast<eng::u32>(tp.block_count()));
	summary.append("  desconocidos=");
	summary.append_u32(static_cast<eng::u32>(tp.unknown_count()));
	summary.append("  -> ");
	summary.append(output);
	n2a::out_line(summary.view());
	return 0;
}
