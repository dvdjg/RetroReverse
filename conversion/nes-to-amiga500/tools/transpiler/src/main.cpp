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
#include "transpiler.hpp"

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
}

} // namespace

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

	eng::util::StringView input;
	eng::util::StringView output("generated_game.cpp");
	eng::util::StringView facts_path;
	int emit = 0; // 0 = transpilar, 1 = mini, 2 = branch, 3 = misc

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
			input = eng::util::StringView(argv[++i]);
			continue;
		}
		if (arg == "-o" && i + 1 < argc) {
			output = eng::util::StringView(argv[++i]);
			continue;
		}
		if (arg == "--facts" && i + 1 < argc) {
			facts_path = eng::util::StringView(argv[++i]);
			continue;
		}
		input = arg;
	}

	if (emit != 0) {
		const bool ok = (emit == 1)   ? write_ines_rom(input.data(), kMiniProg, sizeof(kMiniProg))
				: (emit == 2) ? write_ines_rom(input.data(), kBranchProg, sizeof(kBranchProg))
				: (emit == 3) ? write_ines_rom(input.data(), kMiscProg, sizeof(kMiscProg))
				: (emit == 4) ? write_ines_rom(input.data(), kAssumeProg, sizeof(kAssumeProg))
				: (emit == 5) ? write_ines_rom(input.data(), kBenchProg, sizeof(kBenchProg))
				: (emit == 6) ? write_ines_rom_mapped(input.data(), kBenchProg,
								      sizeof(kBenchProg), 3u, 1u)
					      : write_ines_rom(input.data(), kRamProg, sizeof(kRamProg));
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
		n2a::err_line("error: ROM no válida (se espera iNES NROM, mapper 0)");
		return 1;
	}
	tp.disassemble();
	tp.build_basic_blocks();

	if (!facts_path.empty() && !load_facts(facts_path.data(), tp)) {
		n2a::err_line("error: no se pudo leer el fichero de hechos (--facts)");
		return 1;
	}

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
