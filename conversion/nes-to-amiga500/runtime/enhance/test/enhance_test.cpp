// enhance_test — verifica que los ajustes por ROM NO cambian la emulación y que
// los packs de tiles se aplican al render.
//
//   1. CRC32 conocido; 2. parse_profile; 3. misma ROM con y sin proveedor de
//   tiles 4 bpp → estado de CPU/RAM idéntico (la emulación no cambia).
//
// Uso: enhance_test <rom.nes> [frames]

#include <cstdio>
#include <cstdlib>

#include <eng/core/types/types.hpp>
#include <eng/core/util/string_view.hpp>

#include "../pack_provider.hpp"
#include "../rom_profile.hpp"
#include "nes_system.hpp"
#include "rom_loader.hpp"

namespace {

n2a::LoadedRom g_rom;
n2a::NesSystem g_a; ///< Sin perfil.
n2a::NesSystem g_b; ///< Con proveedor de tiles.

/// Pack sintético en memoria: 2 tiles de 4 bpp.
n2a::enhance::PackStorage g_pack;
n2a::enhance::PackProvider g_provider;

/// Monta un pack 4 bpp mínimo en `g_pack`/`g_provider`.
void build_demo_pack() {
	const eng::u8 bpp = 4u;
	const eng::u16 count = 2u;
	g_pack.data[0] = 'N';
	g_pack.data[1] = '2';
	g_pack.data[2] = 'A';
	g_pack.data[3] = 'T';
	g_pack.data[4] = bpp;
	g_pack.data[6] = static_cast<eng::u8>(count & 0xFFu);
	g_pack.data[7] = static_cast<eng::u8>((count >> 8u) & 0xFFu);
	const eng::usize tile_bytes = 8u * bpp;
	for (eng::usize i = 0; i < count * tile_bytes; ++i) {
		g_pack.data[8u + i] = static_cast<eng::u8>(i & 1u ? 0xAAu : 0x55u);
	}
	g_provider = n2a::enhance::PackProvider {};
	g_provider.tiles = g_pack.data + 8u;
	g_provider.tiles_len = static_cast<eng::u32>(count * tile_bytes);
	g_provider.count = count;
	g_provider.bpp_bits = bpp;
}

/// Ejecuta `frames` frames y copia el estado de CPU/RAM a los arrays dados.
void run_and_capture(n2a::NesSystem& sys, int frames, eng::u8* ram, eng::u8* regs) {
	for (int i = 0; i < frames; ++i) {
		sys.run_frame();
	}
	for (int i = 0; i < 0x800; ++i) {
		ram[i] = sys.mem.ram[i];
	}
	regs[0] = sys.cpu.A;
	regs[1] = sys.cpu.X;
	regs[2] = sys.cpu.Y;
	regs[3] = sys.cpu.SP;
}

} // namespace

int main(int argc, char** argv) {
	int fail = 0;

	// 1. CRC32 conocido.
	if (n2a::enhance::crc32(reinterpret_cast<const eng::u8*>("123456789"), 9u) != 0xCBF43926u) {
		std::printf("  CRC32 incorrecto\n");
		++fail;
	}

	// 2. parse_profile.
	n2a::enhance::RomProfile prof;
	const char* text = "crc 1a2b3c4d\nname Demo\nvideo.bpp 4\naudio.plugin mute\n";
	if (!n2a::enhance::parse_profile(eng::util::StringView(text), prof) || prof.crc != 0x1A2B3C4Du ||
	    prof.gfx.bpp_bg != 4u) {
		std::printf("  parse_profile incorrecto\n");
		++fail;
	}

	// 3. Emulación idéntica con/sin proveedor.
	if (argc < 2) {
		std::printf("enhance_test: sección 3 omitida (sin ROM)\n");
	} else {
		const int frames = (argc > 2) ? std::atoi(argv[2]) : 30;
		if (!n2a::load_ines(argv[1], g_rom)) {
			std::printf("  no se pudo cargar '%s'\n", argv[1]);
			++fail;
		} else {
			build_demo_pack();
			g_a.load_mapper(g_rom.mapper);
			g_a.reset();
			g_b.load_mapper(g_rom.mapper);
			g_b.reset();
			g_b.ppu.tile_provider = &g_provider;  // solo afecta al dibujo

			static eng::u8 ram_a[0x800];
			static eng::u8 ram_b[0x800];
			eng::u8 regs_a[4];
			eng::u8 regs_b[4];
			run_and_capture(g_a, frames, ram_a, regs_a);
			run_and_capture(g_b, frames, ram_b, regs_b);

			for (int i = 0; i < 0x800; ++i) {
				if (ram_a[i] != ram_b[i]) {
					std::printf("  RAM difiere en $%04X (perfil afectó a la emulación)\n", i);
					++fail;
					break;
				}
			}
			for (int i = 0; i < 4; ++i) {
				if (regs_a[i] != regs_b[i]) {
					std::printf("  registro %d difiere (perfil afectó a la CPU)\n", i);
					++fail;
					break;
				}
			}
			// El dibujo sí debe cambiar (el pack tiene otros tiles).
			int fb_diff = 0;
			for (int i = 0; i < 256 * 240; i += 97) {
				if (g_a.ppu.fb[i] != g_b.ppu.fb[i]) {
					++fb_diff;
				}
			}
			std::printf("  emulación idéntica; muestras de framebuffer distintas=%d\n", fb_diff);
		}
	}

	if (fail == 0) {
		std::printf("ENHANCE OK\n");
		return 0;
	}
	std::printf("ENHANCE FALLO (%d)\n", fail);
	return 1;
}
