#pragma once

/// \file rom_loader.hpp
/// Carga de ROM iNES / NES 2.0 para las herramientas, el runner de host y el
/// core de RetroArch: monta el `Mapper` (NROM/UxROM/CNROM/MMC1) y expone PRG/CHR.
/// No usa STL; los bytes viven en `LoadedRom`.

#include <cstdio>

#include <eng/core/types/types.hpp>

#include "nes_mapper.hpp"

namespace n2a {

/// ROM cargada: bytes en memoria + mapper listo para `NesSystem::load_mapper`.
struct LoadedRom {
	eng::u8 rom[0x100000] = {};   ///< Fichero iNES completo (hasta 1 MB; SMB3 = 384 KB).
	eng::u8 chr_ram[0x2000] = {}; ///< CHR RAM si la ROM no trae CHR-ROM.
	Mapper mapper;                ///< Cartucho configurado.
	unsigned mapper_no = 0;       ///< Número de mapper detectado.
	eng::u32 prg_size = 0;        ///< Tamaño de PRG en bytes.
	eng::u32 chr_size = 0;        ///< Tamaño de CHR en bytes (0 = CHR RAM).
	eng::usize file_size = 0;     ///< Bytes válidos del fichero iNES (para CRC32).
};

/// Interpreta los bytes de una ROM iNES/NES2.0 ya copiados en `out.rom`.
/// \param size Número de bytes válidos en `out.rom`.
/// \param out  Salida; el mapper apunta dentro de `out.rom`/`out.chr_ram`.
/// \return `true` si la cabecera es válida y el mapper está soportado.
inline bool parse_ines(eng::usize size, LoadedRom& out) {
	if (size < 16u || out.rom[0] != 'N' || out.rom[1] != 'E' || out.rom[2] != 'S' || out.rom[3] != 0x1Au) {
		return false;
	}
	out.file_size = size;
	const eng::u8 flags6 = out.rom[6];
	const eng::u8 flags7 = out.rom[7];
	unsigned mapper_no = static_cast<unsigned>((flags6 >> 4u) | (flags7 & 0xF0u));
	if ((flags7 & 0x0Cu) == 0x08u) {  // NES 2.0
		mapper_no = ((static_cast<unsigned>(out.rom[8]) & 0x0Fu) << 8u) | (flags7 & 0xF0u) |
			    (flags6 >> 4u);
	}
	const eng::usize trainer = (flags6 & 0x04u) ? 512u : 0u;
	// Bit0 del flags6: 0 = horizontal mirroring, 1 = vertical.
	out.mapper.mirror_h = (flags6 & 0x01u) == 0u;
	const eng::usize prg_off = 16u + trainer;
	const eng::u32 prg_size = static_cast<eng::u32>(out.rom[4]) * 0x4000u;
	const eng::usize chr_off = prg_off + prg_size;
	const eng::u32 chr_size = static_cast<eng::u32>(out.rom[5]) * 0x2000u;
	if (prg_off + prg_size > size) {
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
	case 4u: out.mapper.kind = MapperKind::Mmc3; break;
	case 5u: out.mapper.kind = MapperKind::Mmc5; break;
	case 7u: out.mapper.kind = MapperKind::Axrom; break;
	case 24u: out.mapper.kind = MapperKind::Vrc6; out.mapper.vrc6_b = false; break;
	case 26u: out.mapper.kind = MapperKind::Vrc6; out.mapper.vrc6_b = true; break;
	case 69u: out.mapper.kind = MapperKind::Fme7; break;
	default: return false;
	}
	if (chr_size != 0u && chr_off + chr_size <= size) {
		out.mapper.chr = out.rom + chr_off;
		out.mapper.chr_size = chr_size;
	} else {
		out.mapper.chr = nullptr;
		out.mapper.chr_size = 0;
		out.mapper.chr_ram = out.chr_ram;
	}
	return true;
}

/// Carga una ROM desde memoria (p. ej. el búfer que entrega libretro).
/// \param data Bytes de la ROM; \param size Tamaño; \param out Destino.
/// \return `true` si es válida y el mapper está soportado.
inline bool load_ines_mem(const eng::u8* data, eng::usize size, LoadedRom& out) {
	if (data == nullptr || size == 0u || size > sizeof out.rom) {
		return false;
	}
	for (eng::usize i = 0; i < size; ++i) {
		out.rom[i] = data[i];
	}
	return parse_ines(size, out);
}

/// Carga una ROM desde un fichero `.nes`.
/// \param path Ruta; \param out Destino. \return `true` si se pudo cargar.
inline bool load_ines(const char* path, LoadedRom& out) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return false;
	}
	const eng::usize n = static_cast<eng::usize>(std::fread(out.rom, 1, sizeof out.rom, f));
	std::fclose(f);
	return parse_ines(n, out);
}

} // namespace n2a
