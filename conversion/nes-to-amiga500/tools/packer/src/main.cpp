// ============================================================
// main.cpp — packer RRPK (proyecto A).
// ============================================================
//
// QUÉ ES
//   Empaqueta ficheros transpilados para Amiga (código 68000, datos, PRG/CHR de
//   la ROM) en un contenedor comprimido por segmentos `RRPK`, probando los
//   códecs disponibles por segmento (decisión: ZX0 con respaldo `store`; ver
//   ../../../../docs/adr/0006-compresion-zx0.md) y registrando en la cabecera
//   códec/filtro/tipo/offsets.
//
// USO
//   packer [opciones] <fichero[:tipo]>... -o <salida.rrpk>
//   packer --list   <archivo.rrpk>
//   packer --unpack <archivo.rrpk> <dir_salida>
//   packer --verify <archivo.rrpk>
//
//   tipo ∈ {code,data,prg,chr,other}  (por defecto: other)
//
// QUIÉN LO USA
//   - La emisión del artefacto Amiga (ver ../pack_amiga.sh y el ADR 0006).
//
// RECURSOS
//   Memoria host; lee/escribe ficheros.

#include "codecs.hpp"
#include "filters.hpp"
#include "rrpk_format.hpp"

#include <cstdint>
#include <cstdio>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <string>
#include <vector>

using namespace rrpk;

namespace {

const char* kUsage =
    "packer — empaquetador RRPK (ZX0 + store)\n"
    "\n"
    "  packer [opciones] <fichero[:tipo]>... -o <salida.rrpk>\n"
    "  packer --list   <archivo.rrpk>\n"
    "  packer --unpack <archivo.rrpk> <dir_salida>\n"
    "  packer --verify <archivo.rrpk>\n"
    "\n"
    "  tipo: code | data | prg | chr | other   (por defecto: other)\n"
    "  -o <f>        fichero RRPK de salida (modo empaquetar)\n"
    "  --help        esta ayuda\n";

/// Lee un fichero completo. \return `true` si se pudo leer (aunque sea vacío).
bool read_file(const std::string& path, std::vector<uint8_t>& out) {
	std::ifstream f(path, std::ios::binary);
	if (!f) {
		return false;
	}
	f.seekg(0, std::ios::end);
	const std::streamoff n = f.tellg();
	f.seekg(0, std::ios::beg);
	if (n < 0) {
		return false;
	}
	out.resize(static_cast<size_t>(n));
	if (n > 0) {
		f.read(reinterpret_cast<char*>(out.data()), n);
	}
	return true;
}

/// Escribe un fichero completo. \return `true` si ok.
bool write_file(const std::string& path, const std::vector<uint8_t>& data) {
	std::ofstream f(path, std::ios::binary);
	if (!f) {
		return false;
	}
	if (!data.empty()) {
		f.write(reinterpret_cast<const char*>(data.data()), static_cast<std::streamsize>(data.size()));
	}
	return static_cast<bool>(f);
}

/// Convierte un nombre de tipo (`code`, `prg`, …) a `SegType`.
SegType parse_type(const std::string& s) {
	if (s == "code") return SegType::Code;
	if (s == "data") return SegType::Data;
	if (s == "prg") return SegType::Prg;
	if (s == "chr") return SegType::Chr;
	return SegType::Other;
}

/// Separa `ruta:tipo` por el último ':'. Si no hay tipo, devuelve `Other`.
void split_spec(const std::string& spec, std::string& path, SegType& type) {
	const size_t p = spec.rfind(':');
	if (p == std::string::npos) {
		path = spec;
		type = SegType::Other;
		return;
	}
	path = spec.substr(0, p);
	type = parse_type(spec.substr(p + 1));
}

/// Lee cabecera + tabla. \return `true` si el contenedor es válido.
bool parse_container(const std::vector<uint8_t>& raw, uint16_t& seg_count, uint32_t& total_orig,
		     uint32_t& total_comp, uint32_t& entry_off, std::vector<Segment>& table) {
	if (raw.size() < kHeaderSize || std::memcmp(raw.data(), kMagic, 4) != 0 ||
	    raw[4] != kVersion) {
		return false;
	}
	seg_count = get_u16(raw.data() + 6);
	total_orig = get_u32(raw.data() + 8);
	total_comp = get_u32(raw.data() + 12);
	entry_off = get_u32(raw.data() + 16);
	if (raw.size() < kHeaderSize + static_cast<size_t>(seg_count) * kSegmentSize) {
		return false;
	}
	table.clear();
	for (uint16_t i = 0; i < seg_count; ++i) {
		const uint8_t* p = raw.data() + kHeaderSize + static_cast<size_t>(i) * kSegmentSize;
		Segment s;
		s.offset = get_u32(p + 0);
		s.comp_size = get_u32(p + 4);
		s.orig_size = get_u32(p + 8);
		s.dest_hint = get_u32(p + 12);
		s.codec = static_cast<Codec>(p[16]);
		s.filter = static_cast<Filter>(p[17]);
		s.type = static_cast<SegType>(p[18]);
		s.align = p[19];
		s.orig_crc32 = get_u32(p + 20);
		table.push_back(s);
	}
	return true;
}

// --- Subcomandos -------------------------------------------------------------

int cmd_list(const std::vector<uint8_t>& raw) {
	uint16_t n;
	uint32_t to, tc, eo;
	std::vector<Segment> table;
	if (!parse_container(raw, n, to, tc, eo, table)) {
		std::fprintf(stderr, "error: no es un contenedor RRPK v1\n");
		return 2;
	}
	std::printf("RRPK v1: %u segmentos, orig=%u comp=%u (%.1f%%), entry=%u\n", n, to, tc,
		    to ? 100.0 * tc / to : 0.0, eo);
	std::printf("  #  offset   comp    orig  ratio  codec    filter  type   crc32\n");
	for (uint16_t i = 0; i < n; ++i) {
		const Segment& s = table[i];
		std::printf(" %2u  %7u  %6u  %6u  %5.1f%%  %-8s %-7s %-6s %08X\n", i, s.offset,
			    s.comp_size, s.orig_size, s.orig_size ? 100.0 * s.comp_size / s.orig_size : 0.0,
			    codec_name(s.codec), filter_name(s.filter), type_name(s.type), s.orig_crc32);
	}
	return 0;
}

int cmd_unpack(const std::vector<uint8_t>& raw, const std::string& outdir) {
	uint16_t n;
	uint32_t to, tc, eo;
	std::vector<Segment> table;
	if (!parse_container(raw, n, to, tc, eo, table)) {
		std::fprintf(stderr, "error: no es un contenedor RRPK v1\n");
		return 2;
	}
	std::error_code ec;
	std::filesystem::create_directories(outdir, ec);
	for (uint16_t i = 0; i < n; ++i) {
		const Segment& s = table[i];
		if (static_cast<size_t>(s.offset) + s.comp_size > raw.size()) {
			std::fprintf(stderr, "error: segmento %u fuera de rango\n", i);
			return 3;
		}
		std::vector<uint8_t> out;
		if (!decompress_segment(s.codec, raw.data() + s.offset, s.comp_size, s.orig_size, out)) {
			std::fprintf(stderr, "error: fallo al descomprimir segmento %u\n", i);
			return 3;
		}
		if (!filter_inverse(s.filter, out)) {
			std::fprintf(stderr, "error: filtro %u no soportado en segmento %u\n",
				     static_cast<unsigned>(s.filter), i);
			return 3;
		}
		char name[64];
		std::snprintf(name, sizeof name, "seg%03u.bin", i);
		const std::string path = (std::filesystem::path(outdir) / name).string();
		if (!write_file(path, out)) {
			std::fprintf(stderr, "error: no se pudo escribir %s\n", path.c_str());
			return 3;
		}
		std::printf("  %s  %u -> %u bytes (%s/%s/%s)\n", name, s.comp_size, s.orig_size,
			    codec_name(s.codec), filter_name(s.filter), type_name(s.type));
	}
	return 0;
}

int cmd_verify(const std::vector<uint8_t>& raw) {
	uint16_t n;
	uint32_t to, tc, eo;
	std::vector<Segment> table;
	if (!parse_container(raw, n, to, tc, eo, table)) {
		std::fprintf(stderr, "error: no es un contenedor RRPK v1\n");
		return 2;
	}
	for (uint16_t i = 0; i < n; ++i) {
		const Segment& s = table[i];
		if (static_cast<size_t>(s.offset) + s.comp_size > raw.size()) {
			std::fprintf(stderr, "FALLA segmento %u: fuera de rango\n", i);
			return 3;
		}
		std::vector<uint8_t> out;
		if (!decompress_segment(s.codec, raw.data() + s.offset, s.comp_size, s.orig_size, out) ||
		    !filter_inverse(s.filter, out) || out.size() != s.orig_size) {
			std::fprintf(stderr, "FALLA segmento %u (%s/%s)\n", i, codec_name(s.codec),
				     filter_name(s.filter));
			return 3;
		}
		const uint32_t crc = crc32(out.data(), out.size());
		if (crc != s.orig_crc32) {
			std::fprintf(stderr, "FALLA segmento %u: CRC %08X != %08X\n", i, crc,
				     s.orig_crc32);
			return 3;
		}
	}
	std::printf("OK: %u segmentos verificados (round-trip)\n", n);
	return 0;
}

int cmd_pack(const std::vector<std::string>& specs, const std::string& out_path) {
	struct Item {
		SegType type;
		uint32_t dest_hint;
		std::vector<uint8_t> orig;
		Codec codec;
		std::vector<uint8_t> payload;
	};
	std::vector<Item> items;
	uint32_t total_orig = 0;
	uint32_t total_comp = 0;

	for (const std::string& spec : specs) {
		std::string path;
		SegType type;
		split_spec(spec, path, type);
		std::vector<uint8_t> data;
		if (!read_file(path, data)) {
			std::fprintf(stderr, "error: no se pudo leer '%s'\n", path.c_str());
			return 2;
		}
		// Filtro: none (ADR 0006). Candidato store y zx0; gana el más pequeño.
		std::vector<uint8_t> zx0 = compress_segment(Codec::Zx0, data);
		Codec chosen = Codec::Store;
		std::vector<uint8_t> payload = data;
		if (!zx0.empty() && zx0.size() < data.size()) {
			chosen = Codec::Zx0;
			payload = std::move(zx0);
		}
		total_orig += static_cast<uint32_t>(data.size());
		total_comp += static_cast<uint32_t>(payload.size());
		std::printf("  %-9s %-9s %7zu -> %7zu  %.1f%%\n", path.c_str(), type_name(type),
			    data.size(), payload.size(),
			    data.empty() ? 0.0 : 100.0 * payload.size() / data.size());
		items.push_back({type, 0, std::move(data), chosen, std::move(payload)});
	}

	std::vector<uint8_t> file;
	write_header(file, static_cast<uint16_t>(items.size()), total_orig, total_comp, 0);
	// Reserva hueco para la tabla y calcula offsets alineados a 4.
	size_t off = kHeaderSize + items.size() * kSegmentSize;
	size_t table_pos = file.size();
	file.resize(off, 0);
	std::vector<Segment> table;
	for (Item& it : items) {
		off = (off + 3) & ~static_cast<size_t>(3);
		file.resize(off, 0);
		Segment s;
		s.offset = static_cast<uint32_t>(off);
		s.comp_size = static_cast<uint32_t>(it.payload.size());
		s.orig_size = static_cast<uint32_t>(it.orig.size());
		s.dest_hint = it.dest_hint;
		s.codec = it.codec;
		s.filter = Filter::None;
		s.type = it.type;
		s.align = 2; // 4 bytes
		s.orig_crc32 = crc32(it.orig.data(), it.orig.size());
		table.push_back(s);
		file.insert(file.end(), it.payload.begin(), it.payload.end());
		off += it.payload.size();
	}
	// Serializa la tabla en el hueco reservado.
	std::vector<uint8_t> tbl;
	for (const Segment& s : table) {
		write_segment(tbl, s);
	}
	std::memcpy(file.data() + table_pos, tbl.data(), tbl.size());

	if (!write_file(out_path, file)) {
		std::fprintf(stderr, "error: no se pudo escribir '%s'\n", out_path.c_str());
		return 2;
	}
	std::printf("RRPK '%s': %u segmentos, %u -> %u bytes (%.1f%%)\n", out_path.c_str(),
		    static_cast<unsigned>(items.size()), total_orig, total_comp,
		    total_orig ? 100.0 * total_comp / total_orig : 0.0);
	return 0;
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::fputs(kUsage, stderr);
		return 2;
	}
	const std::string mode = argv[1];
	if (mode == "--help" || mode == "-h") {
		std::fputs(kUsage, stdout);
		return 0;
	}
	if (mode == "--list" && argc == 3) {
		std::vector<uint8_t> raw;
		if (!read_file(argv[2], raw)) {
			std::fprintf(stderr, "error: no se pudo leer '%s'\n", argv[2]);
			return 2;
		}
		return cmd_list(raw);
	}
	if (mode == "--verify" && argc == 3) {
		std::vector<uint8_t> raw;
		if (!read_file(argv[2], raw)) {
			std::fprintf(stderr, "error: no se pudo leer '%s'\n", argv[2]);
			return 2;
		}
		return cmd_verify(raw);
	}
	if (mode == "--unpack" && argc == 4) {
		std::vector<uint8_t> raw;
		if (!read_file(argv[2], raw)) {
			std::fprintf(stderr, "error: no se pudo leer '%s'\n", argv[2]);
			return 2;
		}
		return cmd_unpack(raw, argv[3]);
	}

	// Modo empaquetar.
	std::vector<std::string> specs;
	std::string out_path;
	for (int i = 1; i < argc; ++i) {
		const std::string a = argv[i];
		if (a == "-o" && i + 1 < argc) {
			out_path = argv[++i];
		} else {
			specs.push_back(a);
		}
	}
	if (specs.empty() || out_path.empty()) {
		std::fputs(kUsage, stderr);
		return 2;
	}
	return cmd_pack(specs, out_path);
}
