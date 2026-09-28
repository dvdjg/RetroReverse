// Test de equivalencia de los helpers rápidos del runtime (`n2a_ror_run`/`n2a_rol_run`).
//
// Comprueba que el desplazamiento multibyte (que el codegen `--amiga` emite para las
// tiradas de `ROR/ROL zp` consecutivas) da **exactamente** el mismo resultado que la
// secuencia instrucción a instrucción del 6502: bytes rotados, carry saliente y flags
// Z/N. En host usa la variante portable; en m68k la variante asm (`roxr`/`roxl`), y este
// mismo test fija la semántica que el asm debe cumplir.
//
// Uso: fastops_test   (exit 0 = OK)

#include "nes_runtime.hpp"

#include <cstdio>

namespace {

using n2a::CPU;

/// `ROR` 6502 de un byte (referencia): `C` entra y sale por referencia.
eng::u8 ror_ref_byte(eng::u8 v, bool& C) {
	const eng::u8 c = C ? 1u : 0u;
	C = (v & 1u) != 0u;
	return static_cast<eng::u8>((v >> 1u) | (c << 7u));
}

/// `ROL` 6502 de un byte (referencia).
eng::u8 rol_ref_byte(eng::u8 v, bool& C) {
	const eng::u8 c = C ? 1u : 0u;
	C = (v & 0x80u) != 0u;
	return static_cast<eng::u8>(static_cast<eng::u8>(v << 1u) | c);
}

/// Aplica la secuencia de referencia sobre `n` bytes; deja `C`/`Z`/`N` finales.
void ror_ref(eng::u8* p, eng::u16 n, bool& C, bool& Z, bool& N) {
	eng::u8 last = 0;
	for (eng::u16 i = 0; i < n; ++i) {
		last = p[i] = ror_ref_byte(p[i], C);
	}
	Z = (last == 0u);
	N = (last & 0x80u) != 0u;
}

void rol_ref(eng::u8* p, eng::u16 n, bool& C, bool& Z, bool& N) {
	eng::u8 last = 0;
	for (eng::u16 i = 0; i < n; ++i) {
		last = p[i] = rol_ref_byte(p[i], C);
	}
	Z = (last == 0u);
	N = (last & 0x80u) != 0u;
}

} // namespace

int main() {
	unsigned bad = 0u;
	unsigned cases = 0u;
	// Barrido determinista de semillas, longitudes 1..9 y ambas rotaciones.
	for (unsigned seed = 1u; seed < 4000u; ++seed) {
		for (unsigned n = 1u; n <= 9u; ++n) {
			for (int which = 0; which < 2; ++which) {
				eng::u8 a[16];
				eng::u8 b[16];
				unsigned s = seed * 2654435761u + n;
				for (unsigned i = 0; i < n; ++i) {
					s = s * 1103515245u + 12345u;
					a[i] = b[i] = static_cast<eng::u8>(s >> 16);
				}
				const bool cin = ((seed + n) & 1u) != 0u;
				bool ref_c = cin, ref_z = false, ref_n = false;
				if (which == 0) {
					ror_ref(a, static_cast<eng::u16>(n), ref_c, ref_z, ref_n);
				} else {
					rol_ref(a, static_cast<eng::u16>(n), ref_c, ref_z, ref_n);
				}
				CPU cpu;
				cpu.C = cin;
				if (which == 0) {
					n2a::n2a_ror_run(cpu, b, static_cast<eng::u16>(n));
				} else {
					n2a::n2a_rol_run(cpu, b, static_cast<eng::u16>(n));
				}
				bool eq = (ref_c == cpu.C) && (ref_z == cpu.Z) && (ref_n == cpu.N);
				for (unsigned i = 0; i < n && eq; ++i) {
					eq = (a[i] == b[i]);
				}
				if (!eq) {
					if (bad < 3u) {
						std::printf(
						    "MISMATCH seed=%u n=%u %s: ref(C=%d,Z=%d,N=%d) got(C=%d,Z=%d,N=%d)\n",
						    seed, n, which != 0 ? "ROL" : "ROR", ref_c ? 1 : 0, ref_z ? 1 : 0,
						    ref_n ? 1 : 0, cpu.C ? 1 : 0, cpu.Z ? 1 : 0, cpu.N ? 1 : 0);
					}
					++bad;
				}
				++cases;
			}
		}
	}
	std::printf("fastops_test: cases=%u mismatches=%u -> %s\n", cases, bad,
		    bad == 0u ? "OK" : "FALLO");
	return bad == 0u ? 0 : 1;
}
