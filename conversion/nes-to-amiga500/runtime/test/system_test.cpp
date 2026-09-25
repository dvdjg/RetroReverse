// system_test — prueba del sistema NES (CPU+PPU+APU+mapper) y de la capa HLE.
//
// Carga una ROM iNES y ejecuta unos frames; comprueba que la CPU no se detiene,
// que la PPU recibe datos (VRAM/paleta) y que la capa HLE clasifica escrituras
// (ratio > 0). Uso: system_test <rom.nes> [frames]

#include <cstdio>
#include <cstdlib>

#include <eng/core/types/types.hpp>

#include "nes_system.hpp"

namespace {

eng::u8 g_rom[0x40000];
eng::u8 g_chr_ram[0x2000];

bool load_ines(const char* path, n2a::Mapper& mapper, unsigned& mapper_no) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return false;
	}
	const eng::usize n = static_cast<eng::usize>(std::fread(g_rom, 1, sizeof g_rom, f));
	std::fclose(f);
	if (n < 16u || g_rom[0] != 'N' || g_rom[1] != 'E' || g_rom[2] != 'S' || g_rom[3] != 0x1Au) {
		return false;
	}
	const eng::u8 flags6 = g_rom[6];
	const eng::u8 flags7 = g_rom[7];
	mapper_no = static_cast<unsigned>((flags6 >> 4u) | (flags7 & 0xF0u));
	const eng::usize trainer = (flags6 & 0x04u) ? 512u : 0u;
	const eng::usize prg_off = 16u + trainer;
	const eng::u32 prg_size = static_cast<eng::u32>(g_rom[4]) * 0x4000u;
	const eng::usize chr_off = prg_off + prg_size;
	const eng::u32 chr_size = static_cast<eng::u32>(g_rom[5]) * 0x2000u;
	if (prg_off + prg_size > n) {
		return false;
	}
	mapper.prg = g_rom + prg_off;
	mapper.prg_size = prg_size;
	switch (mapper_no) {
	case 0u: mapper.kind = n2a::MapperKind::Nrom; break;
	case 1u: mapper.kind = n2a::MapperKind::Mmc1; break;
	case 2u: mapper.kind = n2a::MapperKind::Uxrom; break;
	case 3u: mapper.kind = n2a::MapperKind::Cnrom; break;
	default: return false;
	}
	if (chr_size != 0u && chr_off + chr_size <= n) {
		mapper.chr = g_rom + chr_off;
		mapper.chr_size = chr_size;
	} else {
		mapper.chr_ram = g_chr_ram;
	}
	return true;
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: system_test <rom.nes> [frames]\n");
		return 2;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 30;
	n2a::Mapper mapper;
	unsigned mapper_no = 0;
	if (!load_ines(argv[1], mapper, mapper_no)) {
		std::printf("ERROR: no se pudo cargar '%s'\n", argv[1]);
		return 2;
	}
	n2a::NesSystem nes;
	nes.load_mapper(mapper);
	nes.reset();
	for (int i = 0; i < frames; ++i) {
		nes.run_frame();
	}

	int vram_nz = 0;
	for (int i = 0; i < 0x800; ++i) {
		if (nes.ppu.vram[i] != 0u) ++vram_nz;
	}
	int fail = 0;
	if (nes.interp.jammed) {
		std::printf("  CPU detenida (opcode no soportado)\n");
		++fail;
	}
	if (vram_nz == 0) {
		std::printf("  la PPU no recibió datos de VRAM\n");
		++fail;
	}
	if (nes.hle.hle_writes == 0u) {
		std::printf("  HLE no clasificó ninguna escritura\n");
		++fail;
	}
	std::printf("system: mapper=%u frames=%d vram_nz=%d HLE=%u fb=%u ratio=%u/1000\n", mapper_no,
		    frames, vram_nz, nes.hle.hle_writes, nes.hle.fb_writes, nes.hle.ratio_permille());
	if (fail == 0) {
		std::printf("SYSTEM OK\n");
		return 0;
	}
	std::printf("SYSTEM FALLO (%d)\n", fail);
	return 1;
}
