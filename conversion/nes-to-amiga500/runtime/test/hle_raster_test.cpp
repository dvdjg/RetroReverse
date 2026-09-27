// hle_raster_test — prueba de las primitivas HLE de raster (contrato estable).
// Comprueba que leen el estado correcto de `$2002` y que el retardo por ciclos
// coincide con la tabla del 6502.

#include <cstdio>

#include "nes_hle_raster.hpp"

int main() {
	int fail = 0;
	n2a::Ppu ppu;
	n2a::RasterHle h {&ppu};

	ppu.status = 0x80u; // solo VBlank
	if (!h.vblank_pending()) {
		std::printf("  vblank_pending no detecto el bit 7\n");
		++fail;
	}
	if (h.sprite0_pending()) {
		std::printf("  sprite0_pending falso positivo\n");
		++fail;
	}

	ppu.status = 0x40u; // solo sprite-0
	if (!h.sprite0_pending()) {
		std::printf("  sprite0_pending no detecto el bit 6\n");
		++fail;
	}

	ppu.status = 0x00u;
	if (h.vblank_pending() || h.sprite0_pending()) {
		std::printf("  flags a 0 pero pendientes detectados\n");
		++fail;
	}

	// Retardo `LDX #n / DEX / BNE`: (n-1)*5 + 2 ciclos.
	if (n2a::RasterHle::delay_cycles(1) != 2) {
		std::printf("  delay_cycles(1) esperado 2\n");
		++fail;
	}
	if (n2a::RasterHle::delay_cycles(10) != 47) { // 9*5+2
		std::printf("  delay_cycles(10) esperado 47\n");
		++fail;
	}
	if (n2a::RasterHle::delay_cycles(0) != 0) {
		std::printf("  delay_cycles(0) esperado 0\n");
		++fail;
	}

	if (fail == 0) {
		std::printf("HLE raster OK (VBlank/sprite-0 + delay_cycles)\n");
		return 0;
	}
	std::printf("HLE raster FALLO (%d)\n", fail);
	return 1;
}
