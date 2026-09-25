// apu_test — prueba de humo del APU software: activa un pulse y el ruido,
// genera muestras y comprueba que hay señal y que `$4015` reporta canales vivos.

#include <cstdio>

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

#include "nes_apu.hpp"

int main() {
	n2a::Apu apu;
	apu.sample_rate = 22050u;

	apu.write_reg(0x4015u, 0x09u);  // habilita pulse1 (bit 0) y noise (bit 3)
	apu.write_reg(0x4000u, 0x9Fu);  // duty 2 (50%), volumen constante 15
	apu.write_reg(0x4002u, 0xFFu);  // periodo bajo
	apu.write_reg(0x4003u, 0x00u);  // periodo alto + longitud (kLength[0] = 10)
	apu.write_reg(0x400Cu, 0x1Fu);  // ruido: volumen constante 15
	apu.write_reg(0x400Eu, 0x04u);  // periodo de ruido
	apu.write_reg(0x400Fu, 0x00u);  // longitud de ruido

	int fail = 0;
	const eng::u8 st = apu.read_status();
	if ((st & 0x01u) == 0u) {
		std::printf("  pulse1 no activo (status=%02X)\n", st);
		++fail;
	}

	eng::s16 buf[256] = {};
	apu.generate_samples(eng::Span<eng::s16> {buf, 256u});
	int nonzero = 0;
	for (int i = 0; i < 256; ++i) {
		if (buf[i] != 0) {
			++nonzero;
		}
	}
	if (nonzero == 0) {
		std::printf("  salida silenciosa\n");
		++fail;
	}

	if (fail == 0) {
		std::printf("APU OK (%d/256 muestras no nulas)\n", nonzero);
		return 0;
	}
	std::printf("APU FALLO\n");
	return 1;
}
