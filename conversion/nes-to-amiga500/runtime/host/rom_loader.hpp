#pragma once

/// \file rom_loader.hpp
/// Carga de ROM iNES / NES 2.0 para las herramientas y el runner de host:
/// lee la cabecera, monta el `Mapper` correspondiente (NROM/UxROM/CNROM/MMC1) y
/// expone PRG/CHR. No usa STL; el búfer de la ROM lo posee `LoadedRom`.

#include <cstdio>

#include <eng/core/types/types.hpp>

#include "nes_mapper.hpp"

namespace n2a {

/// ROM cargada: bytes en memoria + mapper listo para `NesSystem::load_mapper`.
struct LoadedRom {
	eng::u8 rom[0x40000] = {};  ///< Fichero iNES completo (hasta 256 KB).
	eng::u8 chr_ram[0x2000] = {}; ///< CHR RAM si la ROM no trae CHR-ROM.
	Mapper mapper;              ///< Cartucho configurado.
	unsigned mapper_no = 0;     ///< Número de mapper detectado.
	eng::u32 prg_size = 0;      ///< Tamaño de PRG en bytes.
	eng::u32 chr_size = 0;      ///< Tamaño de CHR en bytes (0 = CHR RAM).
};

/// Carga `path` en `out` y configura el mapper.
/// \param path Fichero `.nes`.
/// \param out  Salida (debe vivir tanto como la ROM).
/// \return `true` si la cabecera es válida y el mapper está soportado.
inline bool load_ines(const char* path, LoadedRom& out) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return false;
	}
	const eng::usize n = static_cast<eng::usize>(std::fread(out.rom, 1, sizeof out.rom, f));
	std::fclose(f);
	if (n < 16u || out.rom[0] != 'N' || out.rom[1] != 'E' || out.rom[2] != 'S' || out.rom[3] != 0x1Au) {
		return false;
	}
	const eng::u8 flags6 = out.rom[6];
	const eng::u8 flags7 = out.rom[7];
	unsigned mapper_no = static_cast<unsigned>((flags6 >> 4u) | (flags7 & 0xF0u));
	if ((flags7 & 0x0Cu) == 0x08u) {  // NES 2.0
		mapper_no = ((static_cast<unsigned>(out.rom[8]) & 0x0Fu) << 8u) | (flags7 & 0xF0u) |
			    (flags6 >> 4u);
	}
	const eng::usize trainer = (flags6 & 0x04u) ? 512u : 0u;
	const eng::usize prg_off = 16u + trainer;
	const eng::u32 prg_size = static_cast<eng::u32>(out.rom[4]) * 0x4000u;
	const eng::usize chr_off = prg_off + prg_size;
	const eng::u32 chr_size = static_cast<eng::u32>(out.rom[5]) * 0x2000u;
	if (prg_off + prg_size > n) {
		return false;
	}
	out.mapper_no = mapper_no;
	out.prg_size = prg_size;
	out.chr_size = chr_size;
	out.mapper.prg = out.rom + prg_off;
	out.mapper.prg_size = prg_size;
	switch (mapper_no) {
	case 0u: out.mapper.kind = MapperKind::Nrom; break;
	case 1u: out.mapper.kind = MapperKind::Mmc1; break;
	case 2u: out.mapper.kind = MapperKind::Uxrom; break;
	case 3u: out.mapper.kind = MapperKind::Cnrom; break;
	default: return false;
	}
	if (chr_size != 0u && chr_off + chr_size <= n) {
		out.mapper.chr = out.rom + chr_off;
		out.mapper.chr_size = chr_size;
	} else {
		out.mapper.chr = nullptr;
		out.mapper.chr_size = 0;
		out.mapper.chr_ram = out.chr_ram;
	}
	return true;
}

} // namespace n2a
