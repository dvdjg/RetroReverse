// ppu_events_test — valida `Ppu::next_event_dots()`, el primitivo del **scheduler
// de eventos** (timing, Fase 3: docs/TIMING_ROADMAP.md). Comprueba la distancia en
// dots hasta el próximo evento observable (set/clear de VBlank, sprite-0, fin de
// frame) en estados conocidos del PPU. No ejecuta el sistema; solo el cálculo.

#include <cstdio>

#include <eng/core/types/types.hpp>

#include "nes_ppu.hpp"

namespace {

int g_fail = 0;

/// Compara `got` con `want` e informa.
void expect(const char* what, unsigned got, unsigned want) {
	if (got == want) {
		std::printf("  ok    %-26s = %u\n", what, got);
	} else {
		std::printf("  FALLA %-26s = %u (esperado %u)\n", what, got, want);
		++g_fail;
	}
}

} // namespace

int main() {
	n2a::Ppu p;
	p.sprite0_line = 0xFFFFu; // sin sprite-0

	// Reset: el próximo evento es el set de VBlank (línea 241).
	p.scanline = 0u;
	p.dot = 0u;
	p.odd_frame = false;
	expect("reset->set VBlank", p.next_event_dots(), 241u * 341u);

	// Una línea antes de VBlank.
	p.scanline = 240u;
	p.dot = 0u;
	expect("240->set VBlank", p.next_event_dots(), 341u);

	// Ya en VBlank: el próximo evento es la pre-render (línea 261).
	p.scanline = 241u;
	p.dot = 0u;
	expect("241->pre-render", p.next_event_dots(), 20u * 341u);

	// sprite-0 a 10 dots por delante.
	p.scanline = 100u;
	p.dot = 40u;
	p.sprite0_line = 100u;
	p.sprite0_dot = 50u;
	expect("sprite-0 a 10 dots", p.next_event_dots(), 10u);

	// Frame impar en la pre-render: el fin de frame llega en 340 dots.
	p.sprite0_line = 0xFFFFu;
	p.scanline = 261u;
	p.dot = 0u;
	p.odd_frame = true;
	expect("261 impar->fin frame", p.next_event_dots(), 340u);

	// sprite-0 ya disparado (bit 0x40): se ignora; manda el set de VBlank.
	p.scanline = 100u;
	p.dot = 0u;
	p.odd_frame = false;
	p.sprite0_line = 100u;
	p.sprite0_dot = 0u;
	p.status = 0x40u;
	expect("sprite-0 ya hecho", p.next_event_dots(), 141u * 341u);

	if (g_fail == 0) {
		std::printf("PPU_EVENTS OK\n");
		return 0;
	}
	std::printf("PPU_EVENTS FALLA (%d)\n", g_fail);
	return 1;
}
