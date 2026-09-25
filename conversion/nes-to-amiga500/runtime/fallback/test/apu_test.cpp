// apu_test — prueba de humo del APU software: activa un pulse y el ruido,
// genera muestras y comprueba que hay señal y que `$4015` reporta canales vivos.

#include <cstdio>

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

#include "nes_apu.hpp"

namespace {

/// Sample DMC de 1 byte (todos los bits a 1): sube el nivel de salida.
eng::u8 g_sample[1] = {0xFFu};

/// Lector de memoria del DMC sobre `g_sample` (dirección base $C000).
eng::u8 dmc_reader(void* user, eng::u16 addr) {
	const eng::u8* buf = static_cast<const eng::u8*>(user);
	return buf[(addr - 0xC000u) & 0x0Fu];
}

} // namespace

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

	// --- DMC ----------------------------------------------------------------
	apu.set_reader(dmc_reader, g_sample);
	apu.write_reg(0x4010u, 0x0Fu);  // rate índice 15, sin IRQ ni loop
	apu.write_reg(0x4012u, 0x00u);  // dirección de sample = $C000
	apu.write_reg(0x4013u, 0x00u);  // longitud = 1 byte
	apu.write_reg(0x4015u, 0x10u);  // habilita el DMC
	if ((apu.read_status() & 0x10u) == 0u) {
		std::printf("  DMC no activo tras $4015\n");
		++fail;
	}
	eng::s16 dbuf[512] = {};
	apu.generate_samples(eng::Span<eng::s16> {dbuf, 512u});
	if (apu.dmc.output == 0u) {
		std::printf("  DMC sin salida\n");
		++fail;
	}
	// Mezcla no lineal: todas las muestras en rango (siempre lo están por el clamp).
	int nonzero2 = 0;
	for (int i = 0; i < 512; ++i) {
		if (dbuf[i] != 0) {
			++nonzero2;
		}
	}
	if (nonzero2 == 0) {
		std::printf("  mezcla DMC silenciosa\n");
		++fail;
	}

	if (fail == 0) {
		std::printf("APU OK (pulse/noise %d/256; DMC+mezcla %d/512 no nulas)\n", nonzero, nonzero2);
		return 0;
	}
	std::printf("APU FALLO\n");
	return 1;
}
