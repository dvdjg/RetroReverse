// raster_idioms — prototipo del **reconocedor de idiomas de raster**.
//
// Escanea linealmente la PRG de una ROM iNES buscando los patrones con los que un
// juego NES "mira al PPU" y que, en la estrategia Amiga, se sustituyen por
// primitivas HLE sobre el haz/Copper (ver docs/TIMING_AMIGA.md):
//
//   1. Sondeo de **VBlank**:  LDA/BIT $2002  seguido de rama BPL/BMI.
//   2. Sondeo de **sprite-0**: LDA $2002 ; AND #$40 ; BNE/BEQ.
//   3. Bucle de **retardo**:  LDX/LDY #imm ... DEX/DEY ... BNE.
//
// Es un prototipo (escaneo lineal, sin seguir el flujo): sirve para **cuantificar**
// cuántos idiomas hay por juego y dónde, y validar que el mapeo hardware cubre lo
// necesario. No modifica la emulación.
//
// Uso: raster_idioms <rom.nes> [rom2.nes ...]

#include <cstdio>
#include <cstdlib>

#include "opcodes.hpp"

namespace {

/// Salta `n` bytes de operando y avanza una instrucción. \return Nueva posición.
eng::usize skip(eng::usize i, eng::u8 op) {
	const eng::u8 sz = n2a::kOpcodeTable[op].size;
	return i + (sz != 0u ? sz : 1u);
}

/// Analiza la PRG `p` (tamano `n`) y acumula los idiomas encontrados.
/// \param p Inicio de la PRG. \param n Tamano. \param out Contadores [vblank, sprite0, delay].
/// \param addrs Primeras direcciones (CPU) de cada tipo para inspeccion.
void scan(const eng::u8* p, eng::usize n, int out[3], unsigned addrs[3][4]) {
	for (eng::usize i = 0; i + 1 < n;) {
		const eng::u8 op = p[i];
		// 1/2) ¿LDA $2002 (AD) o BIT $2002 (2C)?
		if ((op == 0xADu || op == 0x2Cu) && i + 2 < n && p[i + 1] == 0x02u && p[i + 2] == 0x20u) {
			// sprite-0: ... AND #$40 ; BNE/BEQ
			if (op == 0xADu && i + 5 < n && p[i + 3] == 0x29u && p[i + 4] == 0x40u &&
			    (p[i + 5] == 0xD0u || p[i + 5] == 0xF0u)) {
				if (out[1] < 4) addrs[1][out[1]] = static_cast<unsigned>(0x8000u + i);
				++out[1];
			} else {
				// VBlank: rama BPL/BMI en las siguientes 4 instrucciones
				eng::usize j = skip(i, op);
				for (int k = 0; k < 4 && j < n; ++k) {
					const eng::u8 o2 = p[j];
					if (o2 == 0x10u || o2 == 0x30u) {
						if (out[0] < 4) addrs[0][out[0]] = static_cast<unsigned>(0x8000u + i);
						++out[0];
						break;
					}
					j = skip(j, o2);
				}
			}
		}
		// 3) Bucle de retardo: LDX/LDY #imm ... DEX/DEY ... BNE
		if (op == 0xA2u || op == 0xA0u) {
			eng::usize j = skip(i, op);
			for (int k = 0; k < 6 && j + 1 < n; ++k) {
				const eng::u8 o2 = p[j];
				if (o2 == 0xCAu || o2 == 0x88u) { // DEX / DEY
					if (p[j + 1] == 0xD0u) {      // BNE
						if (out[2] < 4) addrs[2][out[2]] = static_cast<unsigned>(0x8000u + i);
						++out[2];
						break;
					}
				}
				j = skip(j, o2);
			}
		}
		i = skip(i, op);
	}
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: raster_idioms <rom.nes> [rom2.nes ...]\n");
		return 2;
	}
	std::printf("%-16s %7s %8s %7s   direcciones (vblank / sprite0 / retardo)\n", "ROM", "vblank",
		    "sprite0", "retardo");
	for (int a = 1; a < argc; ++a) {
		std::FILE* f = std::fopen(argv[a], "rb");
		if (f == nullptr) {
			std::printf("  error: no se pudo abrir '%s'\n", argv[a]);
			continue;
		}
		eng::u8 hdr[16];
		if (std::fread(hdr, 1, 16, f) != 16 || hdr[0] != 'N' || hdr[1] != 'E' || hdr[2] != 'S') {
			std::printf("  %s: no es iNES\n", argv[a]);
			std::fclose(f);
			continue;
		}
		const eng::usize trainer = (hdr[6] & 0x04u) ? 512u : 0u;
		const eng::usize prg = static_cast<eng::usize>(hdr[4]) * 0x4000u;
		std::fseek(f, static_cast<long>(16u + trainer), SEEK_SET);
		auto* buf = static_cast<eng::u8*>(std::malloc(prg ? prg : 1u));
		const eng::usize got = (buf != nullptr) ? std::fread(buf, 1, prg, f) : 0u;
		std::fclose(f);

		int out[3] = {0, 0, 0};
		unsigned addrs[3][4] = {{0, 0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0, 0}};
		if (buf != nullptr) {
			scan(buf, got, out, addrs);
		}
		const char* base = argv[a];
		for (const char* c = argv[a]; *c != '\0'; ++c) {
			if (*c == '/' || *c == '\\') base = c + 1;
		}
		std::printf("%-16s %7d %8d %7d   %04X %04X %04X / %04X / %04X\n", base, out[0], out[1],
			    out[2], addrs[0][0], addrs[0][1], addrs[1][0], addrs[2][0], addrs[2][1]);
		std::free(buf);
	}
	return 0;
}
