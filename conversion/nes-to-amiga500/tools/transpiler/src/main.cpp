// nes_transpiler (fase 1) — ROM NES (iNES/NROM) → C++23 sobre `eng/core`.
//
// Uso:
//   nes_transpiler <entrada.nes> [-o <salida.cpp>]
//   nes_transpiler --emit-mini-rom   <salida.nes>   ROM mínima propia (LDA/STA/INX/BRK)
//   nes_transpiler --emit-branch-rom <salida.nes>   ROM propia con bucle/ADC/BNE/JSR/RTS
//   nes_transpiler --help
//
// Diseño: docs/TRANSPILER.md y tools/transpiler/README.md.

#include "host_io.hpp"
#include "raster_idioms.hpp"
#include "transpiler.hpp"

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <string>
#include <vector>

#include <eng/core/types/types.hpp>
#include <eng/core/util/dynamic_string.hpp>
#include <eng/core/util/heap_alloc.hpp>
#include <eng/core/util/string_view.hpp>

namespace {

using n2a::ByteBuffer;
using n2a::Dyn;
using eng::util::StringView;

/// Convierte un texto hexadecimal (con o sin `0x`) a 16 bits.
/// \return `false` si el texto no es hexadecimal válido.
bool parse_hex(StringView s, eng::u16& out) {
	if (s.size() >= 2u && s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) {
		s.remove_prefix(2u);
	}
	if (s.empty()) {
		return false;
	}
	eng::u32 v = 0;
	for (eng::usize i = 0; i < s.size(); ++i) {
		const char c = s[i];
		eng::u32 d;
		if (c >= '0' && c <= '9') {
			d = static_cast<eng::u32>(c - '0');
		} else if (c >= 'a' && c <= 'f') {
			d = static_cast<eng::u32>(c - 'a' + 10);
		} else if (c >= 'A' && c <= 'F') {
			d = static_cast<eng::u32>(c - 'A' + 10);
		} else {
			return false;
		}
		v = v * 16u + d;
	}
	out = static_cast<eng::u16>(v);
	return true;
}

/// Igual que `parse_hex` pero para un contador de 32 bits (calor de bloque).
/// \param s Texto hexadecimal (con o sin `0x`).
/// \param out Valor parseado.
/// \return `true` si `s` era un hexadecimal válido.
bool parse_hex32(StringView s, eng::u32& out) {
	if (s.size() >= 2u && s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) {
		s.remove_prefix(2u);
	}
	if (s.empty()) {
		return false;
	}
	eng::u32 v = 0;
	for (eng::usize i = 0; i < s.size(); ++i) {
		const char c = s[i];
		eng::u32 d;
		if (c >= '0' && c <= '9') {
			d = static_cast<eng::u32>(c - '0');
		} else if (c >= 'a' && c <= 'f') {
			d = static_cast<eng::u32>(c - 'a' + 10);
		} else if (c >= 'A' && c <= 'F') {
			d = static_cast<eng::u32>(c - 'A' + 10);
		} else {
			return false;
		}
		v = v * 16u + d;
	}
	out = v;
	return true;
}

/// Consume los espacios iniciales de `s`.
void skip_ws(StringView& s) {
	while (!s.empty() && (s[0] == ' ' || s[0] == '\t' || s[0] == '\r')) {
		s.remove_prefix(1u);
	}
}

/// Extrae el siguiente token (hasta espacio, tabulador o fin) y avanza `s`.
StringView next_token(StringView& s) {
	skip_ws(s);
	eng::usize end = s.size();
	for (eng::usize i = 0; i < s.size(); ++i) {
		const char c = s[i];
		if (c == ' ' || c == '\t' || c == '\r') {
			end = i;
			break;
		}
	}
	const StringView tok = s.substr(0u, end);
	s = s.substr(end);
	return tok;
}

/// Carga un fichero de hechos de valores (`--facts`) y los registra en `tp`.
///
/// Formato, una regla por línea (hexadecimal con o sin `0x`; `#` comenta):
/// ```
/// eq     <addr> <valor>
/// range  <addr> <min> <max>
/// set    <addr> <v1> [v2] [v3] [v4]
/// power2 <addr>
/// hot    <addr> <ejecuciones>   (marca el bloque `hot`/`cold`)
/// ```
/// \return `true` si el fichero se leyó (las líneas inválidas se ignoran).
bool load_facts(const char* path, n2a::Transpiler& tp) {
	ByteBuffer buf;
	if (!n2a::read_whole_file(path, buf)) {
		return false;
	}
	StringView text(reinterpret_cast<const char*>(buf.data()), buf.size());
	while (!text.empty()) {
		const eng::usize nl = text.find('\n');
		StringView line = (nl == StringView::npos) ? text : text.substr(0u, nl);
		text = (nl == StringView::npos) ? StringView {} : text.substr(nl + 1u);
		skip_ws(line);
		if (line.empty() || line[0] == '#') {
			continue;
		}
		const StringView kind = next_token(line);
		eng::u16 addr = 0;
		if (!parse_hex(next_token(line), addr)) {
			continue;
		}
		n2a::Fact f;
		f.addr = addr;
		if (kind == "eq") {
			f.kind = n2a::FactKind::Eq;
			if (!parse_hex(next_token(line), addr)) {
				continue;
			}
			f.values[0] = static_cast<eng::u8>(addr);
		} else if (kind == "range") {
			f.kind = n2a::FactKind::Range;
			eng::u16 lo = 0;
			if (!parse_hex(next_token(line), lo) || !parse_hex(next_token(line), addr)) {
				continue;
			}
			f.values[0] = static_cast<eng::u8>(lo);
			f.values[1] = static_cast<eng::u8>(addr);
		} else if (kind == "set") {
			f.kind = n2a::FactKind::Set;
			while (f.count < 4u) {
				eng::u16 v = 0;
				if (!parse_hex(next_token(line), v)) {
					break;
				}
				f.values[f.count++] = static_cast<eng::u8>(v);
			}
			if (f.count == 0u) {
				continue;
			}
		} else if (kind == "power2") {
			f.kind = n2a::FactKind::Power2;
		} else if (kind == "hot") {
			f.kind = n2a::FactKind::Hot;
			if (!parse_hex32(next_token(line), f.heat)) {
				continue;
			}
		} else {
			continue;
		}
		tp.add_fact(f);
	}
	return true;
}

/// Envuelve `prog` en una ROM iNES NROM (16 KB de PRG) con los tres vectores
/// apuntando a `$8000`. El contenido es **propio** (homebrew mínimo), sin
/// material de terceros, y sirve para probar el pipeline sin ROMs ajenas.
///
/// \param path     Fichero `.nes` de destino.
/// \param prog     Bytes del programa 6502 (se copian al inicio de la PRG).
/// \param prog_len Número de bytes del programa.
/// \return `true` si la ROM se escribió correctamente.
bool write_ines_rom_mapped(const char* path, const eng::u8* prog, eng::usize prog_len,
			   eng::u8 mapper, eng::u8 chr_pages) {
	constexpr eng::u32 kPrg = 16384u;
	const eng::u32 chr_bytes = static_cast<eng::u32>(chr_pages) * 8192u;
	ByteBuffer rom;
	if (!rom.resize(16u + kPrg + chr_bytes, 0u)) {
		return false;
	}
	rom[0] = 'N';
	rom[1] = 'E';
	rom[2] = 'S';
	rom[3] = 0x1Au;
	rom[4] = 1u;           // una página de PRG (16 KB)
	rom[5] = chr_pages;    // páginas de CHR
	rom[6] = static_cast<eng::u8>(mapper << 4u);        // mapper (nibble bajo)
	rom[7] = static_cast<eng::u8>(mapper & 0xF0u);      // mapper (nibble alto)

	for (eng::usize i = 0; i < prog_len; ++i) {
		rom[16u + i] = prog[i];
	}
	// Los tres vectores (NMI, reset, IRQ) apuntan al inicio del programa.
	auto set_vec = [&](eng::usize off, eng::u16 value) {
		rom[16u + off] = static_cast<eng::u8>(value & 0xFFu);
		rom[16u + off + 1u] = static_cast<eng::u8>(value >> 8u);
	};
	set_vec(0x3FFAu, 0x8000u);
	set_vec(0x3FFCu, 0x8000u);
	set_vec(0x3FFEu, 0x8000u);

	return n2a::write_whole_file(
		path, eng::util::StringView(reinterpret_cast<const char*>(rom.data()), rom.size()));
}

/// Envuelve `prog` en una ROM iNES **NROM** (mapper 0, sin CHR).
/// \param path Fichero `.nes` de destino.
/// \param prog Bytes del programa 6502.
/// \param prog_len Nº de bytes del programa.
/// \return `true` si la ROM se escribió.
bool write_ines_rom(const char* path, const eng::u8* prog, eng::usize prog_len) {
	return write_ines_rom_mapped(path, prog, prog_len, 0u, 0u);
}

// Programa de la ROM mínima: A9 23 (LDA #$23) · 85 00 (STA $00) · E8 (INX) · 00 (BRK).
constexpr eng::u8 kMiniProg[] = {0xA9u, 0x23u, 0x85u, 0x00u, 0xE8u, 0x00u};

// Bucle de 5 iteraciones + llamada a subrutina:
//   $8000: LDX #$00         A2 00
//   $8002: LDA #$00         A9 00
//   $8004: CLC              18
//   $8005: ADC #$01         69 01   <- destino del BNE
//   $8007: INX              E8
//   $8008: CPX #$05         E0 05
//   $800A: BNE $8005        D0 F9
//   $800C: JSR $8010        20 10 80
//   $800F: BRK              00
//   $8010: STA $10          85 10
//   $8012: RTS              60
constexpr eng::u8 kBranchProg[] = {
	0xA2u, 0x00u, 0xA9u, 0x00u, 0x18u, 0x69u, 0x01u, 0xE8u, 0xE0u, 0x05u,
	0xD0u, 0xF9u, 0x20u, 0x10u, 0x80u, 0x00u, 0x85u, 0x10u, 0x60u,
};

// Pila, desplazamientos (A y memoria), INC/DEC de memoria y JMP indirecto:
//   $8000: LDA #$81 ; PHA ; LDA #$00 ; PLA        (A = $81)
//   $8006: ASL A ; ROR A ; LSR A                  (A = $40, C = 1)
//   $8009: STA $10                                (ram[$10] = $40)
//   $800B: LDA #$03 ; STA $20 ; INC $20 ; DEC $20 ; ASL $20   (zp[$20] = $06)
//   $8015: LDA #$22 ; STA $30 ; LDA #$80 ; STA $31            (puntero = $8022)
//   $801D: BEQ $8022        (no se toma: Z = 0 tras LDA #$80)
//   $801F: JMP ($0030)      (salto indirecto a $8022)
//   $8022: LDX #$07 ; DEX ; BNE $8024             (X = 0)
//   $8027: LDA #$55 ; STA $40 ; BRK               (ram[$40] = $55)
// El BEQ no tomado existe para que el transpilador decodifique $8022 (destino
// del salto indirecto, que no se puede resolver estáticamente) como bloque.
constexpr eng::u8 kMiscProg[] = {
	0xA9u, 0x81u, 0x48u, 0xA9u, 0x00u, 0x68u, 0x0Au, 0x6Au, 0x4Au, 0x85u,
	0x10u, 0xA9u, 0x03u, 0x85u, 0x20u, 0xE6u, 0x20u, 0xC6u, 0x20u, 0x06u,
	0x20u, 0xA9u, 0x22u, 0x85u, 0x30u, 0xA9u, 0x80u, 0x85u, 0x31u, 0xF0u,
	0x03u, 0x6Cu, 0x30u, 0x00u, 0xA2u, 0x07u, 0xCAu, 0xD0u, 0xFDu, 0xA9u,
	0x55u, 0x85u, 0x40u, 0x00u,
};

// VSA: LDA #$2A ; STA $10 ; LDA $10 ; BRK. El codegen infiere que `$10` vale
// $2A y emite `N2A_ASSUME` sin necesidad de un fichero de hechos.
constexpr eng::u8 kAssumeProg[] = {0xA9u, 0x2Au, 0x85u, 0x10u, 0xA5u, 0x10u, 0x00u};

// ROM de **carga de cálculo** para medir el codegen: bucle doble (128×256
// iteraciones) con CLC/ADC/STA/LDA/EOR/ROL/DEC/BNE y termina en BRK. No depende
// de la PPU, así que sirve para comparar codegen vs intérprete vs ejecutor rápido.
//   $8000: LDX #$00 ; LDA #$00 ; STA $10 ; LDA #$FF ; STA $12
//   $800A: CLC ; ADC #$07 ; STA $10 ; LDA $10 ; EOR #$5A ; STA $11 ; ROL $11
//          DEC $12 ; BNE $800A          (256 iteraciones)
//          INX ; CPX #$80 ; BNE $8002   (128 iteraciones)
//   $8020: BRK
constexpr eng::u8 kBenchProg[] = {
	0xA2u, 0x00u, 0xA9u, 0x00u, 0x85u, 0x10u, 0xA9u, 0xFFu, 0x85u, 0x12u,
	0x18u, 0x69u, 0x07u, 0x85u, 0x10u, 0xA5u, 0x10u, 0x49u, 0x5Au, 0x85u,
	0x11u, 0x26u, 0x11u, 0xC6u, 0x12u, 0xD0u, 0xEFu, 0xE8u, 0xE0u, 0x80u,
	0xD0u, 0xE2u, 0x00u,
};

// ROM que **copia una rutina a RAM ($0200) y la ejecuta** (JSR $0200), para
// validar el código en RAM: el transpilador no la decodifica (está en RAM), así
// que se resuelve por el fallback del runtime.
//   $8000: LDX #$00 ; copia 17 bytes de $8012 a $0200 ; JSR $0200 ; BRK
//   $8012: LDY #$00 ; LDA #$00 ; STA $10 ; bucle: CLC; ADC #$05; STA $10; EOR
//          #$3C; DEY; BNE bucle ; RTS
constexpr eng::u8 kRamProg[] = {
	0xA2u, 0x00u, 0xBDu, 0x12u, 0x80u, 0x9Du, 0x00u, 0x02u, 0xE8u, 0xE0u, 0x11u, 0xD0u,
	0xF5u, 0x20u, 0x00u, 0x02u, 0x00u, 0xEAu, 0xA0u, 0x00u, 0xA9u, 0x00u, 0x85u, 0x10u,
	0x18u, 0x69u, 0x05u, 0x85u, 0x10u, 0x49u, 0x3Cu, 0x88u, 0xD0u, 0xF7u, 0x60u,
};

/// Imprime la ayuda de línea de comandos.
/// \param argv0 Nombre del programa (no se usa; se mantiene por uniformidad).
void print_usage(const char* argv0) {
	(void)argv0;
	n2a::out_line("nes_transpiler (fase 1) — NES (iNES/NROM) → C++23 (eng/core)");
	n2a::out_line("Uso: nes_transpiler <entrada.nes> [-o <salida.cpp>] [--facts <hechos.txt>]");
	n2a::out_line("     --emit-mini-rom   <salida.nes>");
	n2a::out_line("     --emit-branch-rom <salida.nes>");
	n2a::out_line("     --emit-misc-rom   <salida.nes>");
	n2a::out_line("     --emit-vsa-rom    <salida.nes>");
	n2a::out_line("     --emit-bench-rom  <salida.nes>");
	n2a::out_line("     --emit-cnrom-rom  <salida.nes>");
	n2a::out_line("     --emit-ram-rom    <salida.nes>");
	n2a::out_line("Uso (varias ROMs -> plugins <rom>.<plataforma>.n2x):");
	n2a::out_line("     nes_transpiler <rom1.nes> [rom2.nes ...] --emit-lib --outdir <dir> \\");
	n2a::out_line("         --entry <plugin_entry.cpp> --inc <dir> [--inc <dir> ...] \\");
	n2a::out_line("         [--cxx g++] [--target x64nt|x64linux|a500|a1200|wasm]");
	n2a::out_line("         [--7z <7zr.exe>] [--no-7z] [--bundle <nombre>]");
	n2a::out_line("         [--no-cycles] [--fast-ram] [--release]  (rendimiento Amiga)");
	n2a::out_line("   (la entrada tambien admite .7z con varias .nes dentro)");
}

/// Extrae el nombre base (sin directorio ni extensión) de `path` en `out`.
void base_name(const char* path, char* out, eng::usize cap) {
	eng::usize start = 0u;
	for (eng::usize i = 0; path[i] != '\0'; ++i) {
		if (path[i] == '/' || path[i] == '\\') {
			start = i + 1u;
		}
	}
	eng::usize j = 0u;
	for (eng::usize i = start; path[i] != '\0' && path[i] != '.' && j + 1u < cap; ++i) {
		out[j++] = path[i];
	}
	out[j] = '\0';
}

/// Compone `dir/base.ext` en `out` (sin superar `cap`).
void join_path(const eng::util::StringView& dir, const char* base, const char* ext, char* out,
	       eng::usize cap) {
	std::snprintf(out, cap, "%.*s/%s%s", static_cast<int>(dir.size()), dir.data(), base, ext);
}

/// \return `true` si `s` termina con `suf`.
bool str_ends_with(const std::string& s, const char* suf) {
	const std::size_t n = std::strlen(suf);
	return s.size() >= n && s.compare(s.size() - n, n, suf) == 0;
}

/// Empaqueta `files` en el archivo 7z `archive` (crea/reemplaza). \return `true` si ok.
bool pack_7z(const char* sevenzip, const std::string& archive, const std::vector<std::string>& files) {
	auto bs = [](std::string s) {
		for (char& c : s) {
			if (c == '/') {
				c = '\\';
			}
		}
		return s;
	};
	std::string cmd = "call \"" + std::string(sevenzip) + "\" a -t7z -y \"" + bs(archive) + "\"";
	for (std::size_t i = 0; i < files.size(); ++i) {
		cmd += " \"" + bs(files[i]) + "\"";
	}
	n2a::out_line(eng::util::StringView(cmd.c_str()));
	return std::system(cmd.c_str()) == 0;
}

/// Extrae `archive` a `dest` (crea el directorio). \return `true` si ok.
bool extract_7z(const char* sevenzip, const std::string& archive, const std::string& dest) {
	std::error_code ec;
	std::filesystem::create_directories(dest, ec);
	auto bs = [](std::string s) {
		for (char& c : s) {
			if (c == '/') {
				c = '\\';
			}
		}
		return s;
	};
	const std::string cmd = "call \"" + std::string(sevenzip) + "\" x -y -o\"" + bs(dest) +
				"\" \"" + bs(archive) + "\"";
	return std::system(cmd.c_str()) == 0;
}

/// Versión del **codegen/ABI**: subirla invalida la caché de plugins (se escribe
/// en el sidecar como `"gen"`). v2 = +`kMirroring`/`n2a_mirroring`.
constexpr int kCodegenVersion = 2;

/// Opciones de codegen fijadas por los flags (ver `main`).
bool g_no_cycles = false;
bool g_fast_ram = false;
bool g_trace = false;
bool g_chain = false;
bool g_rom_direct = false;
bool g_native = false;
bool g_best = false;

/// Transpila la ROM `rom` al `.cpp` `out_cpp`. \return `true` si fue bien.
bool transpile_rom(const char* rom, const char* out_cpp, const char* facts) {
	ByteBuffer bytes;
	if (!n2a::read_whole_file(rom, bytes)) {
		n2a::err_line("error: no se pudo leer la ROM");
		return false;
	}
	n2a::Transpiler tp;
	if (!tp.load(bytes.data(), bytes.size())) {
		if (tp.prg_banked()) {
			// Mapper con PRG bancada: el oráculo lo ejecuta, pero el codegen por
			// banco es el trabajo pendiente de F9 (docs/TRANSPILER_BANKING.md).
			Dyn e;
			e.append("error: mapper ");
			e.append_s32(tp.mapper());
			e.append(" con PRG bancada (");
			e.append_u32(tp.prg_bank_count());
			e.append(" bancos de ");
			e.append_u32(tp.prg_bank_size());
			e.append(" B); transpilacion por banco pendiente (F9/B1)");
			n2a::err_line(e.view());
		} else {
			n2a::err_line("error: ROM no valida (iNES NROM/CNROM, PRG fija)");
		}
		return false;
	}
	tp.set_no_cycles(g_no_cycles);
	tp.set_fast_ram(g_fast_ram);
	tp.set_trace(g_trace);
	tp.set_chain(g_chain);
	tp.set_rom_direct(g_rom_direct);
	tp.set_native(g_native);
	tp.set_best(g_best);
	tp.disassemble();
	tp.build_basic_blocks();
	if (facts != nullptr && !load_facts(facts, tp)) {
		n2a::err_line("error: no se pudo leer el fichero de hechos (--facts)");
		return false;
	}
	Dyn gen;
	tp.generate(gen);
	if (!n2a::write_whole_file(out_cpp, gen.view())) {
		n2a::err_line("error: no se pudo escribir el .cpp");
		return false;
	}
	Dyn s;
	s.append("OK  instrucciones=");
	s.append_u32(static_cast<eng::u32>(tp.instruction_count()));
	s.append("  bloques=");
	s.append_u32(static_cast<eng::u32>(tp.block_count()));
	s.append("  -> ");
	s.append(out_cpp);
	n2a::out_line(s.view());
	if (tp.prg_banked()) {
		Dyn w;
		w.append("nota: mapper ");
		w.append_s32(tp.mapper());
		w.append(" (");
		w.append_u32(tp.prg_bank_count());
		w.append(" bancos): ventana fija + ventana conmutable por banco (fallback al interprete si no hay bloque)");
		n2a::out_line(w.view());
	}
	return true;
}

/// Escribe en `out` el directorio de `path` (sin el nombre del fichero final).
void dir_name(const char* path, char* out, eng::usize cap) {
	eng::usize cut = 0u;
	for (eng::usize i = 0; path[i] != '\0'; ++i) {
		if (path[i] == '/' || path[i] == '\\') {
			cut = i;
		}
	}
	eng::usize j = 0u;
	for (eng::usize i = 0; i < cut && j + 1u < cap; ++i) {
		out[j++] = path[i];
	}
	out[j] = '\0';
}

/// Datos de cabecera iNES útiles para el sidecar de metadatos.
struct RomInfo {
	int mapper = 0;     ///< Número de mapper iNES.
	eng::u32 prg = 0u;  ///< Tamaño de PRG en bytes.
	eng::u32 chr = 0u;  ///< Tamaño de CHR en bytes.
};

/// Lee la cabecera iNES de `path`. \return `false` si no es válida.
bool rom_info(const char* path, RomInfo& out) {
	ByteBuffer b;
	if (!n2a::read_whole_file(path, b) || b.size() < 16u) {
		return false;
	}
	out.prg = static_cast<eng::u32>(b[4]) * 16384u;
	out.chr = static_cast<eng::u32>(b[5]) * 8192u;
	out.mapper = static_cast<int>((b[6] >> 4u) | (b[7] & 0xF0u));
	return true;
}

/// Escribe el sidecar de metadatos `.n2x.json` (name/arch/abi/mapper/PRG/CHR/CRC).
void write_sidecar(const char* json, const char* base, const char* tag, const char* rom,
		   eng::u32 crc) {
	RomInfo ri;
	(void)rom_info(rom, ri);
	Dyn js;
	js.append("{\n  \"name\": \"");
	js.append(base);
	js.append("\",\n  \"arch\": \"");
	js.append(tag);
	js.append("\",\n  \"abi\": ");
	js.append_s32(1);
	js.append(",\n  \"mapper\": ");
	js.append_s32(ri.mapper);
	js.append(",\n  \"prg_size\": ");
	js.append_u32(ri.prg);
	js.append(",\n  \"chr_size\": ");
	js.append_u32(ri.chr);
	js.append(",\n  \"rom_crc32\": \"0x");
	js.append_hex(crc, 8u, true);
	js.append("\",\n  \"source\": \"");
	js.append(eng::util::StringView(rom));
	js.append("\",\n  \"gen\": ");
	js.append_s32(kCodegenVersion);
	js.append("\n}\n");
	(void)n2a::write_whole_file(json, js.view());
}

/// Lee un campo entero `"key": <n>` del sidecar JSON `path`.
/// \return El valor, o `-1` si no existe.
int read_sidecar_int(const char* path, const char* key) {
	ByteBuffer b;
	if (!n2a::read_whole_file(path, b)) {
		return -1;
	}
	eng::util::StringView t(reinterpret_cast<const char*>(b.data()), b.size());
	const eng::usize k = t.find(eng::util::StringView(key));
	if (k == eng::util::StringView::npos) {
		return -1;
	}
	eng::usize i = t.find(eng::util::StringView(":"), k);
	if (i == eng::util::StringView::npos) {
		return -1;
	}
	++i;
	while (i < t.size() && (t[i] == ' ' || t[i] == '\t' || t[i] == '"')) {
		++i;
	}
	int v = 0;
	bool any = false;
	while (i < t.size() && t[i] >= '0' && t[i] <= '9') {
		v = v * 10 + (t[i] - '0');
		any = true;
		++i;
	}
	return any ? v : -1;
}

/// CRC32 (IEEE) del contenido de `path` (0 si no se pudo leer).
eng::u32 crc32_file(const char* path) {
	ByteBuffer b;
	if (!n2a::read_whole_file(path, b)) {
		return 0u;
	}
	eng::u32 crc = 0xFFFFFFFFu;
	for (eng::usize i = 0; i < b.size(); ++i) {
		crc ^= b[i];
		for (int k = 0; k < 8; ++k) {
			crc = (crc >> 1u) ^ (0xEDB88320u & (0u - (crc & 1u)));
		}
	}
	return ~crc;
}

/// Lee `"rom_crc32":"0x........"` del sidecar JSON `path`.
/// \return El CRC cacheado, o `0xFFFFFFFF` si no existe el fichero o el campo.
eng::u32 read_cached_crc(const char* path) {
	ByteBuffer b;
	if (!n2a::read_whole_file(path, b)) {
		return 0xFFFFFFFFu;
	}
	eng::util::StringView t(reinterpret_cast<const char*>(b.data()), b.size());
	const eng::usize key = t.find(eng::util::StringView("rom_crc32"));
	if (key == eng::util::StringView::npos) {
		return 0xFFFFFFFFu;
	}
	eng::usize i = key;
	for (; i < t.size() && t[i] != '0'; ++i) {
	}
	if (i + 1u >= t.size() || t[i] != '0' || (t[i + 1u] != 'x' && t[i + 1u] != 'X')) {
		return 0xFFFFFFFFu;
	}
	i += 2u;
	eng::u32 v = 0u;
	for (; i < t.size(); ++i) {
		const char c = t[i];
		eng::u32 d;
		if (c >= '0' && c <= '9') {
			d = static_cast<eng::u32>(c - '0');
		} else if (c >= 'a' && c <= 'f') {
			d = static_cast<eng::u32>(c - 'a' + 10);
		} else if (c >= 'A' && c <= 'F') {
			d = static_cast<eng::u32>(c - 'A' + 10);
		} else {
			break;
		}
		v = (v << 4u) | d;
	}
	return v;
}

/// Compila el plugin `.n2x` a partir de `entry` (`plugin_entry.cpp`) y del
/// transpilado `n2a_game_impl.cpp` que debe estar en `outdir`. Autodetecta los
/// `-I` de runtime a partir de la ruta de `entry` (`<runtime>/plugin/...`).
/// \return `true` si el compilador terminó con éxito.
bool build_plugin_lib(const char* cxx, const char* entry, const char* outdir, const char* n2x,
		      const eng::util::Vector<eng::util::StringView, eng::util::HeapAlloc>& incs) {
	char cmd[8192];
	eng::usize o = 0u;
	auto app = [&](const char* s) {
		while (*s != '\0' && o + 2u < sizeof cmd) {
			cmd[o++] = *s++;
		}
	};
	app(cxx);
	app(" -std=gnu++23 -O2 -shared -static-libgcc -static-libstdc++");
#ifndef _WIN32
	app(" -fPIC");
#endif
	app(" -I");
	app(outdir);
	// Autodetección: `<entry_dir>/..` = runtime -> include y plugin.
	char edir[1024];
	dir_name(entry, edir, sizeof edir);
	char rdir[1024];
	dir_name(edir, rdir, sizeof rdir);
	app(" -I");
	app(rdir);
	app("/include");
	app(" -I");
	app(rdir);
	app("/plugin");
	for (eng::usize k = 0; k < incs.size(); ++k) {
		app(" -I");
		app(incs[k].data());
	}
	app(" ");
	app(entry);
	app(" -o ");
	app(n2x);
	cmd[o] = '\0';
	n2a::out_line(eng::util::StringView(cmd));
	return std::system(cmd) == 0;
}

} // namespace

/// Escribe el **mapeo de idiomas de raster** de `roms` a `out_path` (JSON), que
/// consumirá el codegen/backend Amiga para emitir las primitivas HLE (ver
/// `docs/TIMING_AMIGA.md`). \return `true` si se escribió el fichero.
static bool write_raster_json(const std::vector<std::string>& roms, const char* out_path) {
	std::FILE* f = std::fopen(out_path, "wb");
	if (f == nullptr) {
		return false;
	}
	std::fprintf(f, "{\n");
	bool first = true;
	for (const std::string& rom : roms) {
		n2a::ByteBuffer b;
		if (!n2a::read_whole_file(rom.c_str(), b) || b.size() < 16u) {
			continue;
		}
		const eng::u8* h = b.data();
		if (h[0] != 'N' || h[1] != 'E' || h[2] != 'S') {
			continue;
		}
		const eng::usize trainer = (h[6] & 0x04u) ? 512u : 0u;
		const eng::usize prg = static_cast<eng::usize>(h[4]) * 0x4000u;
		if (16u + trainer + prg > b.size()) {
			continue;
		}
		n2a::RasterIdioms r;
		n2a::scan_raster_idioms(b.data() + 16u + trainer, prg, r);
		char base[256];
		base_name(rom.c_str(), base, sizeof base);
		std::fprintf(f, "  %s\"%s\": {\"counts\": [%d,%d,%d]", first ? "" : ",\n", base,
			     r.counts[0], r.counts[1], r.counts[2]);
		const auto emit = [&](const char* key, const unsigned* v, int n) {
			std::fprintf(f, ", \"%s\": [", key);
			for (int i = 0; i < n && i < 4; ++i) {
				std::fprintf(f, "%s\"0x%04X\"", i != 0 ? "," : "", v[i]);
			}
			std::fprintf(f, "]");
		};
		emit("vblank", r.vblank, r.counts[0]);
		emit("sprite0", r.sprite0, r.counts[1]);
		emit("delay", r.delay, r.counts[2]);
		std::fprintf(f, "}");
		first = false;
	}
	std::fprintf(f, "\n}\n");
	std::fclose(f);
	return true;
}

/// Punto de entrada del transpilador. Interpreta los argumentos, y o bien emite
/// una ROM de prueba, o bien transpila la ROM indicada al `.cpp` de salida.
///
/// \param argc Número de argumentos (incluye el nombre del programa).
/// \param argv Vector de argumentos.
/// \return 0 si todo fue bien; 1 ante error de uso, de lectura o de escritura.
int main(int argc, char** argv) {
	if (argc < 2) {
		print_usage(argv[0]);
		return 1;
	}

	eng::util::StringView output("generated_game.cpp");
	eng::util::StringView outdir(".");
	const char* facts_path = nullptr;
	const char* entry = nullptr;
	const char* cxx = "g++";
	const char* target = nullptr; // plataforma destino (etiqueta del nombre del .n2x)
	const char* sevenzip_env = std::getenv("N2A_7Z");
	const char* sevenzip = sevenzip_env != nullptr ? sevenzip_env : "7zr";
	bool use_7z = true;           // empaquetar el .n2x en .7z por defecto
	const char* bundle = nullptr; // nombre del .7z que agrupa varias ROMs
	const char* raster_json = nullptr; // fichero del mapeo de idiomas de raster
	bool emit_lib = false;
	int emit = 0; // 0 = transpilar, 1..7 = ROMs de prueba
	eng::util::Vector<eng::util::StringView, eng::util::HeapAlloc> incs {};
	eng::util::Vector<eng::util::StringView, eng::util::HeapAlloc> inputs {};

	for (int i = 1; i < argc; ++i) {
		const eng::util::StringView arg(argv[i]);
		if (arg == "--help" || arg == "-h") {
			print_usage(argv[0]);
			return 0;
		}
		if ((arg == "--emit-mini-rom" || arg == "--emit-branch-rom" || arg == "--emit-misc-rom" ||
		     arg == "--emit-vsa-rom" || arg == "--emit-bench-rom" || arg == "--emit-cnrom-rom" ||
		     arg == "--emit-ram-rom") &&
		    i + 1 < argc) {
			emit = (arg == "--emit-mini-rom")     ? 1
			       : (arg == "--emit-branch-rom") ? 2
			       : (arg == "--emit-misc-rom")   ? 3
			       : (arg == "--emit-vsa-rom")    ? 4
			       : (arg == "--emit-bench-rom")  ? 5
			       : (arg == "--emit-cnrom-rom")  ? 6
							      : 7;
			(void)inputs.push_back(eng::util::StringView(argv[++i]));
			continue;
		}
		if (arg == "-o" && i + 1 < argc) {
			output = eng::util::StringView(argv[++i]);
			continue;
		}
		if (arg == "--facts" && i + 1 < argc) {
			facts_path = argv[++i];
			continue;
		}
		if (arg == "--emit-lib") {
			emit_lib = true;
			continue;
		}
		if (arg == "--outdir" && i + 1 < argc) {
			outdir = eng::util::StringView(argv[++i]);
			continue;
		}
		if (arg == "--entry" && i + 1 < argc) {
			entry = argv[++i];
			continue;
		}
		if (arg == "--cxx" && i + 1 < argc) {
			cxx = argv[++i];
			continue;
		}
		if (arg == "--inc" && i + 1 < argc) {
			(void)incs.push_back(eng::util::StringView(argv[++i]));
			continue;
		}
		if (arg == "--target" && i + 1 < argc) {
			target = argv[++i];
			continue;
		}
		if (arg == "--7z" && i + 1 < argc) {
			sevenzip = argv[++i];
			continue;
		}
		if (arg == "--no-7z") {
			use_7z = false;
			continue;
		}
		if (arg == "--bundle" && i + 1 < argc) {
			bundle = argv[++i];
			continue;
		}
		if (arg == "--raster-json" && i + 1 < argc) {
			raster_json = argv[++i];
			continue;
		}
		if (arg == "--no-cycles") {
			g_no_cycles = true;
			continue;
		}
		if (arg == "--fast-ram") {
			g_fast_ram = true;
			continue;
		}
		if (arg == "--trace") { // traza por instrucción (comparar con el intérprete)
			g_trace = true;
			continue;
		}
		if (arg == "--chain") { // encadenar bloques (requiere --no-cycles)
			g_chain = true;
			continue;
		}
		if (arg == "--rom-direct") { // lecturas directas de PRG_ROM (datos fijos)
			g_rom_direct = true;
			continue;
		}
		if (arg == "--native") { // backend estilo descompilador (regiones + literales)
			g_native = true;
			continue;
		}
		if (arg == "--best") { // nativo si se puede; si no, perfil Amiga encadenado
			g_best = true;
			g_no_cycles = true;
			g_chain = true;
			g_rom_direct = true;
			g_fast_ram = true;
			continue;
		}
		if (arg == "--amiga") { // perfil Amiga/68000: sin ciclos + encadenado + ROM/ZP directas
			g_no_cycles = true;
			g_chain = true;
			g_rom_direct = true;
			g_fast_ram = true;
			continue;
		}

		if (arg == "--release") { // optimizaciones seguras para Amiga/68000
			g_no_cycles = true; // --fast-ram queda opt-in (ganancia marginal, ver docs)
			continue;
		}
		(void)inputs.push_back(arg);
	}

	if (emit != 0) {
		const char* in0 = inputs.back().data();
		const bool ok = (emit == 1)   ? write_ines_rom(in0, kMiniProg, sizeof(kMiniProg))
				: (emit == 2) ? write_ines_rom(in0, kBranchProg, sizeof(kBranchProg))
				: (emit == 3) ? write_ines_rom(in0, kMiscProg, sizeof(kMiscProg))
				: (emit == 4) ? write_ines_rom(in0, kAssumeProg, sizeof(kAssumeProg))
				: (emit == 5) ? write_ines_rom(in0, kBenchProg, sizeof(kBenchProg))
				: (emit == 6) ? write_ines_rom_mapped(in0, kBenchProg, sizeof(kBenchProg),
								      3u, 1u)
					      : write_ines_rom(in0, kRamProg, sizeof(kRamProg));
		if (!ok) {
			n2a::err_line("error: no se pudo escribir la ROM de prueba");
			return 1;
		}
		n2a::out_line("ROM de prueba escrita.");
		return 0;
	}

	if (inputs.empty()) {
		print_usage(argv[0]);
		return 1;
	}

	// Lista final de ROMs: expande las entradas `.7z` (extrae sus `.nes`).
	std::vector<std::string> in_paths;
	for (eng::usize k = 0; k < inputs.size(); ++k) {
		const std::string s(inputs[k].data(), inputs[k].size());
		if (use_7z && str_ends_with(s, ".7z")) {
			char base[256];
			base_name(s.c_str(), base, sizeof base);
			const std::string dest = std::string(outdir.data(), outdir.size()) + "/_extract_" + base;
			if (!extract_7z(sevenzip, s, dest)) {
				n2a::err_line("error: no se pudo extraer el .7z");
				return 1;
			}
			std::error_code ec;
			for (const auto& e : std::filesystem::directory_iterator(dest, ec)) {
				const std::string p = e.path().string();
				if (str_ends_with(p, ".nes")) {
					in_paths.push_back(p);
				}
			}
		} else {
			in_paths.push_back(s);
		}
	}
	if (in_paths.empty()) {
		n2a::err_line("error: no hay ROMs de entrada");
		return 1;
	}

	// Mapeo de idiomas de raster (para el codegen/backend Amiga): escribe y sale.
	if (raster_json != nullptr) {
		if (!write_raster_json(in_paths, raster_json)) {
			n2a::err_line("error: no se pudo escribir el mapeo de raster");
			return 1;
		}
		n2a::out_line("mapeo de raster escrito.");
		return 0;
	}

	// Modo biblioteca: una o más ROMs -> .cpp (fuente) + .n2x (plugin compilado).
	if (emit_lib) {
		if (entry == nullptr) {
			n2a::err_line("error: --emit-lib requiere --entry <plugin_entry.cpp>");
			return 1;
		}
#if defined(_WIN32)
		const char* tag = target != nullptr ? target : "x64nt";
#else
		const char* tag = target != nullptr ? target : "x64linux";
#endif
		std::vector<std::string> n2x_list; // para --bundle
		int rc = 0;
		for (std::size_t k = 0; k < in_paths.size(); ++k) {
			const char* rom = in_paths[k].c_str();
			char base[256];
			base_name(rom, base, sizeof base);
			char stem[320];
			std::snprintf(stem, sizeof stem, "%s.%s", base, tag);
			char cpp[1024];
			join_path(outdir, base, ".cpp", cpp, sizeof cpp);
			char impl[1024];
			join_path(outdir, "n2a_game_impl", ".cpp", impl, sizeof impl);
			char n2x[1024];
			join_path(outdir, stem, ".n2x", n2x, sizeof n2x);
			char json[1024];
			join_path(outdir, stem, ".n2x.json", json, sizeof json);
			char arc[1024];
			join_path(outdir, stem, ".7z", arc, sizeof arc);

			// Caché: si el plugin existe y el CRC de la ROM no cambió, no se rehace.
			const eng::u32 crc = crc32_file(rom);
			ByteBuffer existing;
			// La caché caduca si cambia la ROM **o** la versión de codegen/ABI.
			const bool cached = n2a::read_whole_file(n2x, existing) &&
					    read_cached_crc(json) == crc &&
					    read_sidecar_int(json, "gen") == kCodegenVersion;
			if (cached) {
				Dyn s;
				s.append("sin cambios, reutilizo ");
				s.append(n2x);
				n2a::out_line(s.view());
				write_sidecar(json, base, tag, rom, crc); // asegura el sidecar
			} else {
				if (!transpile_rom(rom, cpp, facts_path)) {
					rc = 1;
					continue;
				}
				// Copia el transpilado a `n2a_game_impl.cpp` (nombre que incluye el entry).
				ByteBuffer src;
				if (!n2a::read_whole_file(cpp, src) ||
				    !n2a::write_whole_file(impl,
							   eng::util::StringView(
								   reinterpret_cast<const char*>(src.data()),
								   src.size()))) {
					n2a::err_line("error: no se pudo preparar n2a_game_impl.cpp");
					rc = 1;
					continue;
				}
				if (!build_plugin_lib(cxx, entry, outdir.data(), n2x, incs)) {
					n2a::err_line("error: la compilacion del plugin fallo (revisa --cxx/--inc)");
					rc = 1;
					continue;
				}
				// Sidecar de metadatos (título/arch/mapper/CRC) para el gestor.
				write_sidecar(json, base, tag, rom, crc);
				Dyn ok;
				ok.append("plugin -> ");
				ok.append(n2x);
				n2a::out_line(ok.view());
			}
			// Mapeo de **idiomas de raster** de esta ROM (lo consumirá el codegen/buscará
			// el backend Amiga para emitir las primitivas HLE; ver docs/TIMING_AMIGA.md).
			char rjson[1024];
			join_path(outdir, stem, ".raster.json", rjson, sizeof rjson);
			(void)write_raster_json(std::vector<std::string> {std::string(rom)}, rjson);
			n2x_list.push_back(n2x);
			// Empaquetado por defecto: `<rom>.<plataforma>.7z` con el `.n2x` (+ sidecar).
			if (use_7z) {
				(void)pack_7z(sevenzip, arc, std::vector<std::string> {n2x, json, rjson});
			}
		}
		// Un mismo `.7z` puede contener varias ROMs (`--bundle <nombre>`).
		if (bundle != nullptr && use_7z) {
			const std::string barc =
				std::string(outdir.data(), outdir.size()) + "/" + bundle + "." + tag + ".7z";
			(void)pack_7z(sevenzip, barc, n2x_list);
			Dyn s;
			s.append("bundle -> ");
			s.append(eng::util::StringView(barc.c_str()));
			n2a::out_line(s.view());
		}
		return rc;
	}

	// Modo simple: una ROM -> un .cpp.
	if (!transpile_rom(in_paths[0].c_str(), output.data(), facts_path)) {
		return 1;
	}
	return 0;
}
