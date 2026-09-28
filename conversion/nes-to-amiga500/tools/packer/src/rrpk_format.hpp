// ============================================================
// rrpk_format.hpp — Contenedor comprimido por segmentos RRPK v1.
// ============================================================
//
// QUÉ ES
//   Definición del contenedor RRPK (magic "RRPK"), su cabecera y su tabla de
//   segmentos, más utilidades de serialización big-endian (el destino es 68000).
//
// QUIÉN LO USA
//   - `packer` (proyecto A): escribe el contenedor y lo lee para --list/--unpack/--verify.
//   - `codec_bench` (proyecto B): usa los enums Codec/Filter/SegType.
//
// RECURSOS
//   Solo memoria host (std::vector). Sin dependencias de eng/core.
//
// Especificación completa: ../docs/FORMAT.md

#pragma once

#include <cstdint>
#include <cstring>
#include <string>
#include <vector>

namespace rrpk {

/// Códecs soportados en la v1 del contenedor.
enum class Codec : uint8_t {
	Store = 0,   ///< Sin compresión (copia).
	Zx0 = 1,     ///< ZX0 (BSD-3, Einar Saukas): decruncher 68k muy pequeño y rápido.
	Aplib = 2,   ///< aPLib (formato; compresor apultra Zlib+CC0): clásico en 68k.
	Deflate = 3, ///< DEFLATE (RFC 1951) sin envoltorio; comprime miniz (MIT).
};

/// Filtros reversibles aplicados antes de comprimir y deshechos tras descomprimir.
enum class Filter : uint8_t {
	None = 0,
	Delta8 = 1,
	Delta16Be = 2,
	Xor8 = 3,
	EvenOdd = 4,
	Delta16BeEvenOdd = 5,
	Delta8EvenOdd = 6,
	Tile16 = 7,
	Tile16Delta = 8,
};

/// Tipo semántico del segmento (guía la elección de códec/filtro).
enum class SegType : uint8_t {
	Code = 0,  ///< Código máquina 68000.
	Data = 1,  ///< rodata/tablas constantes.
	Prg = 2,   ///< PRG-ROM 6502 (NES).
	Chr = 3,   ///< CHR-ROM (tiles NES).
	Other = 4, ///< Otro/genérico.
};

/// Entrada de la tabla de segmentos (24 bytes serializados).
struct Segment {
	uint32_t offset = 0;    ///< Offset del payload comprimido desde el inicio del fichero.
	uint32_t comp_size = 0; ///< Tamaño comprimido en bytes.
	uint32_t orig_size = 0; ///< Tamaño original en bytes.
	uint32_t dest_hint = 0; ///< Dirección/desplazamiento destino sugerido (0 = contiguo).
	Codec codec = Codec::Store;
	Filter filter = Filter::None;
	SegType type = SegType::Other;
	uint8_t align = 0;       ///< log2 de la alineación requerida del destino.
	uint32_t orig_crc32 = 0; ///< CRC32 del contenido original.
};

static constexpr char kMagic[4] = {'R', 'R', 'P', 'K'};
static constexpr uint8_t kVersion = 1;
static constexpr size_t kHeaderSize = 20;
static constexpr size_t kSegmentSize = 24;

// --- CRC32 (IEEE 802.3, polinomio 0xEDB88320) --------------------------------

/// Tabla CRC32 precalculada (inicialización perezosa).
inline const uint32_t* crc32_table() {
	static uint32_t table[256];
	static bool ready = false;
	if (!ready) {
		for (uint32_t i = 0; i < 256; ++i) {
			uint32_t c = i;
			for (int k = 0; k < 8; ++k) c = (c & 1) ? (0xEDB88320u ^ (c >> 1)) : (c >> 1);
			table[i] = c;
		}
		ready = true;
	}
	return table;
}

/// \return CRC32 del bloque `data[0..n)`.
inline uint32_t crc32(const uint8_t* data, size_t n) {
	const uint32_t* t = crc32_table();
	uint32_t c = 0xFFFFFFFFu;
	for (size_t i = 0; i < n; ++i) c = t[(c ^ data[i]) & 0xFF] ^ (c >> 8);
	return c ^ 0xFFFFFFFFu;
}

// --- Serialización BE --------------------------------------------------------

inline void put_u8(std::vector<uint8_t>& b, uint8_t v) { b.push_back(v); }
inline void put_u16(std::vector<uint8_t>& b, uint16_t v) { b.push_back(v >> 8); b.push_back(v & 0xFF); }
inline void put_u32(std::vector<uint8_t>& b, uint32_t v) {
	b.push_back((v >> 24) & 0xFF); b.push_back((v >> 16) & 0xFF);
	b.push_back((v >> 8) & 0xFF); b.push_back(v & 0xFF);
}
inline uint8_t get_u8(const uint8_t* p) { return p[0]; }
inline uint16_t get_u16(const uint8_t* p) { return (uint16_t(p[0]) << 8) | p[1]; }
inline uint32_t get_u32(const uint8_t* p) {
	return (uint32_t(p[0]) << 24) | (uint32_t(p[1]) << 16) | (uint32_t(p[2]) << 8) | p[3];
}

/// Serializa la cabecera + tabla (sin payloads) en `out`.
inline void write_header(std::vector<uint8_t>& out, uint16_t seg_count,
                         uint32_t total_orig, uint32_t total_comp, uint32_t entry_off) {
	out.clear();
	out.insert(out.end(), kMagic, kMagic + 4);
	put_u8(out, kVersion);
	put_u8(out, 0); // flags
	put_u16(out, seg_count);
	put_u32(out, total_orig);
	put_u32(out, total_comp);
	put_u32(out, entry_off);
}

/// Añade una entrada de segmento serializada.
inline void write_segment(std::vector<uint8_t>& out, const Segment& s) {
	put_u32(out, s.offset);
	put_u32(out, s.comp_size);
	put_u32(out, s.orig_size);
	put_u32(out, s.dest_hint);
	put_u8(out, static_cast<uint8_t>(s.codec));
	put_u8(out, static_cast<uint8_t>(s.filter));
	put_u8(out, static_cast<uint8_t>(s.type));
	put_u8(out, s.align);
	put_u32(out, s.orig_crc32);
}

/// \return nombre legible del códec.
inline const char* codec_name(Codec c) {
	switch (c) {
	case Codec::Store: return "store";
	case Codec::Zx0: return "zx0";
	case Codec::Aplib: return "aplib";
	case Codec::Deflate: return "deflate";
	}
	return "?";
}

/// \return nombre legible del filtro.
inline const char* filter_name(Filter f) {
	switch (f) {
	case Filter::None: return "none";
	case Filter::Delta8: return "delta8";
	case Filter::Delta16Be: return "delta16be";
	case Filter::Xor8: return "xor8";
	case Filter::EvenOdd: return "evenodd";
	case Filter::Delta16BeEvenOdd: return "delta16be+evenodd";
	case Filter::Delta8EvenOdd: return "delta8+evenodd";
	case Filter::Tile16: return "tile16";
	case Filter::Tile16Delta: return "tile16_delta";
	}
	return "?";
}

/// \return nombre legible del tipo de segmento.
inline const char* type_name(SegType t) {
	switch (t) {
	case SegType::Code: return "code";
	case SegType::Data: return "data";
	case SegType::Prg: return "prg";
	case SegType::Chr: return "chr";
	case SegType::Other: return "other";
	}
	return "?";
}

} // namespace rrpk
