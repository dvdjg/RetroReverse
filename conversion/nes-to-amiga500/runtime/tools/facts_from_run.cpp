// facts_from_run — extrae hechos de valores por **telemetría** para `--facts`.
//
// Ejecuta la ROM con el intérprete del runtime durante N pasos, observa qué
// valores toma cada dirección de RAM ($0000-$07FF) y escribe un fichero de hechos
// consumible por el transpilador (`range` o `set`). Es una primera aproximación:
// observa los valores **escritos** (diffs de RAM por paso).
//
// Uso: facts_from_run <rom.nes> <salida.txt> [pasos] [entrada_hex]
//
// `entrada_hex` permite arrancar en una dirección concreta (p. ej. C000 para el
// test automático de nestest) en lugar del vector de reset.

#include <cstdio>
#include <cstdlib>

#include <eng/core/types/types.hpp>

#include "nes_interpreter.hpp"
#include "nes_runtime.hpp"

namespace {

eng::u8 g_rom[0x10000]; ///< ROM iNES (NROM no supera 64 KB).
eng::u8 g_prev[0x800];  ///< Copia de la RAM del paso anterior.
/// Valores vistos por dirección y valor: `g_seen[a][v]`.
eng::u8 g_seen[0x800][256];
/// 1 si la dirección `a` tomó algún valor observado.
eng::u8 g_has[0x800];

eng::usize load_rom(const char* path) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return 0u;
	}
	const eng::usize n = static_cast<eng::usize>(std::fread(g_rom, 1, sizeof g_rom, f));
	std::fclose(f);
	return n;
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 3) {
		std::printf("uso: facts_from_run <rom.nes> <salida.txt> [pasos]\n");
		return 2;
	}
	const eng::usize n = load_rom(argv[1]);
	if (n < 16u || g_rom[0] != 'N' || g_rom[1] != 'E' || g_rom[2] != 'S' || g_rom[3] != 0x1Au) {
		std::printf("ERROR: '%s' no es una ROM iNES válida\n", argv[1]);
		return 2;
	}
	const eng::usize trainer = (g_rom[6] & 0x04u) ? 512u : 0u;
	const eng::usize off = 16u + trainer;
	const eng::u32 prg_size = static_cast<eng::u32>(g_rom[4]) * 0x4000u;
	if (off + prg_size > n) {
		std::printf("ERROR: PRG truncada\n");
		return 2;
	}
	const int steps = (argc > 3) ? std::atoi(argv[3]) : 20000;

	n2a::NESMemory mem;
	mem.prg = g_rom + off;
	mem.prg_size = prg_size;

	eng::u16 entry = 0;
	bool have_entry = false;
	if (argc > 4) {
		for (const char* p = argv[4]; *p != '\0'; ++p) {
			const char c = *p;
			eng::u16 d;
			if (c >= '0' && c <= '9') d = static_cast<eng::u16>(c - '0');
			else if (c >= 'a' && c <= 'f') d = static_cast<eng::u16>(c - 'a' + 10);
			else if (c >= 'A' && c <= 'F') d = static_cast<eng::u16>(c - 'A' + 10);
			else continue;
			entry = static_cast<eng::u16>(entry * 16u + d);
		}
		have_entry = true;
	}

	n2a::CPU cpu;
	cpu.mem = &mem;
	cpu.PC = have_entry ? entry : mem.read16(0xFFFCu);
	cpu.SP = 0xFDu;

	n2a::Interpreter interp {cpu, mem};

	// Estado inicial.
	for (eng::u16 a = 0; a < 0x800u; ++a) {
		g_prev[a] = mem.ram[a];
	}

	for (int s = 0; s < steps; ++s) {
		interp.step();
		if (interp.jammed) {
			break;
		}
		for (eng::u16 a = 0; a < 0x800u; ++a) {
			const eng::u8 v = mem.ram[a];
			if (v != g_prev[a]) {
				g_seen[a][v] = 1u;
				g_has[a] = 1u;
				g_prev[a] = v;
			}
		}
	}

	std::FILE* out = std::fopen(argv[2], "wb");
	if (out == nullptr) {
		std::printf("ERROR: no se pudo escribir '%s'\n", argv[2]);
		return 2;
	}
	std::fprintf(out, "# Hechos extraidos por telemetria (%d pasos) de %s\n", steps, argv[1]);
	unsigned lines = 0;
	for (eng::u16 a = 0; a < 0x800u; ++a) {
		if (g_has[a] == 0u) {
			continue;
		}
		unsigned count = 0;
		int minv = 256;
		int maxv = -1;
		for (int v = 0; v < 256; ++v) {
			if (g_seen[a][v] != 0u) {
				++count;
				if (v < minv) minv = v;
				if (v > maxv) maxv = v;
			}
		}
		if (count == 0u) {
			continue;
		}
		if (count <= 8u) {
			std::fprintf(out, "set %04x", a);
			for (int v = 0; v < 256; ++v) {
				if (g_seen[a][v] != 0u) {
					std::fprintf(out, " %02x", v);
				}
			}
			std::fprintf(out, "\n");
		} else {
			std::fprintf(out, "range %04x %02x %02x\n", a, minv, maxv);
		}
		++lines;
	}
	std::fclose(out);
	std::printf("facts_from_run: %u direcciones con valores -> %s\n", lines, argv[2]);
	return 0;
}
