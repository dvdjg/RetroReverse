// nes_frame — ejecuta una ROM con el sistema NES del runtime y vuelca un frame.
//
// Carga una ROM iNES (NROM/UxROM/CNROM), arranca el sistema por su vector de
// reset, avanza N frames y escribe el último frame como PPM (P6) e imprime el
// hash FNV-1a de los píxeles (para comparar con otro emulador, p. ej. mesen).
//
// Uso: nes_frame <rom.nes> <salida.ppm> [frames]

#include <cstdio>
#include <cstdlib>

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

#include "nes_system.hpp"

namespace {

eng::u8 g_rom[0x100000];  ///< ROM iNES (hasta 1 MB; SMB3 = 384 KB).
eng::u8 g_chr_ram[0x2000]; ///< CHR RAM si la ROM no trae CHR-ROM.

eng::usize load_file(const char* path) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return 0u;
	}
	const eng::usize n = static_cast<eng::usize>(std::fread(g_rom, 1, sizeof g_rom, f));
	std::fclose(f);
	return n;
}

eng::u64 fnv1a(const eng::u8* data, eng::usize n) {
	eng::u64 h = 1469598103934665603ull;
	for (eng::usize i = 0; i < n; ++i) {
		h ^= data[i];
		h *= 1099511628211ull;
	}
	return h;
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 3) {
		std::printf("uso: nes_frame <rom.nes> <salida.ppm> [frames]\n");
		return 2;
	}
	const eng::usize n = load_file(argv[1]);
	if (n < 16u || g_rom[0] != 'N' || g_rom[1] != 'E' || g_rom[2] != 'S' || g_rom[3] != 0x1Au) {
		std::printf("ERROR: '%s' no es una ROM iNES válida\n", argv[1]);
		return 2;
	}
	const int frames = (argc > 3) ? std::atoi(argv[3]) : 30;

	const eng::u8 flags6 = g_rom[6];
	const eng::u8 flags7 = g_rom[7];
	unsigned mapper_no = static_cast<unsigned>((flags6 >> 4u) | (flags7 & 0xF0u));
	if ((flags7 & 0x0Cu) == 0x08u && n >= 16u) {
		mapper_no = static_cast<unsigned>(((static_cast<unsigned>(g_rom[8]) & 0x0Fu) << 8u) |
						  (flags7 & 0xF0u) | (flags6 >> 4u));
	}
	const eng::usize trainer = (flags6 & 0x04u) ? 512u : 0u;
	const eng::usize prg_off = 16u + trainer;
	const eng::u32 prg_size = static_cast<eng::u32>(g_rom[4]) * 0x4000u;
	const eng::usize chr_off = prg_off + prg_size;
	const eng::u32 chr_size = static_cast<eng::u32>(g_rom[5]) * 0x2000u;
	if (prg_off + prg_size > n) {
		std::printf("ERROR: PRG truncada\n");
		return 2;
	}

	n2a::Mapper mapper;
	mapper.prg = g_rom + prg_off;
	mapper.prg_size = prg_size;
	switch (mapper_no) {
	case 0u: mapper.kind = n2a::MapperKind::Nrom; break;
	case 1u: mapper.kind = n2a::MapperKind::Mmc1; break;
	case 2u: mapper.kind = n2a::MapperKind::Uxrom; break;
	case 3u: mapper.kind = n2a::MapperKind::Cnrom; break;
	case 4u: mapper.kind = n2a::MapperKind::Mmc3; break;
	default:
		std::printf("ERROR: mapper %u no soportado todavía\n", mapper_no);
		return 2;
	}
	if (chr_size != 0u && chr_off + chr_size <= n) {
		mapper.chr = g_rom + chr_off;
		mapper.chr_size = chr_size;
	} else {
		mapper.chr = nullptr;
		mapper.chr_size = 0;
		mapper.chr_ram = g_chr_ram;
	}

	n2a::NesSystem nes;
	nes.load_mapper(mapper);
	nes.reset();
	for (int i = 0; i < frames; ++i) {
		nes.run_frame();
	}

	eng::u8 rgb[n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH * 3];
	nes.frame_rgb(eng::Span<eng::u8> {rgb, sizeof rgb});

	std::FILE* out = std::fopen(argv[2], "wb");
	if (out == nullptr) {
		std::printf("ERROR: no se pudo escribir '%s'\n", argv[2]);
		return 2;
	}
	std::fprintf(out, "P6\n%d %d\n255\n", n2a::NesSystem::kScreenW, n2a::NesSystem::kScreenH);
	std::fwrite(rgb, 1, sizeof rgb, out);
	std::fclose(out);

	std::printf("nes_frame: mapper=%u PRG=%u CHR=%u frames=%d hash=%016llx -> %s\n",
		    mapper_no, prg_size, chr_size, frames,
		    static_cast<unsigned long long>(fnv1a(rgb, sizeof rgb)), argv[2]);
	return 0;
}
