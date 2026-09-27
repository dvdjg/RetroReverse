#pragma once

/// \file nes_hle_raster.hpp
/// **Primitivas HLE de sincronización de raster** (contrato **estable**).
///
/// Son los puntos donde un juego NES "mira al PPU" (sondeo de VBlank, de sprite-0
/// y bucles de retardo) y que, en el Amiga, se resolverán con el haz (`VHPOSR`) o
/// el Copper **en vez de** emular la PPU (ver [`../../docs/TIMING_AMIGA.md`] y
/// [`../../docs/HLE.md`]). En el host se resuelven contra la PPU software, para
/// validar el reconocedor y como referencia.
///
/// Estas funciones **no cambian la emulación**: solo fijan la interfaz para que el
/// reconocedor ([`../../tools/transpiler/src/raster_idioms.cpp`]) y el codegen la
/// usen. La implementación Amiga está pendiente.

#include <eng/core/types/types.hpp>

#include "nes_ppu.hpp"

namespace n2a {

/// Fachada de las primitivas de timing. No es propietaria de la PPU.
struct RasterHle {
	Ppu* ppu = nullptr; ///< PPU software sobre la que se consulta el estado (host).

	/// ¿Está activo el flag de **VBlank** (`$2002` bit 7)? En el Amiga lo pondría
	/// el IRQ de VBL / un registro sombra.
	/// \return `true` si el bit 7 de `$2002` está puesto.
	[[nodiscard]] bool vblank_pending() const noexcept {
		return ppu != nullptr && (ppu->status & 0x80u) != 0u;
	}

	/// ¿Está activo el flag de **sprite-0 hit** (`$2002` bit 6)? En el Amiga lo
	/// pondría un `WAIT` del Copper en la línea del bob.
	/// \return `true` si el bit 6 de `$2002` está puesto.
	[[nodiscard]] bool sprite0_pending() const noexcept {
		return ppu != nullptr && (ppu->status & 0x40u) != 0u;
	}

	/// Ciclos de CPU de un bucle de retardo `LDX #n / DEX / BNE` (5 ciclos por
	/// iteración, la última 2). Permite **precalcular** en compilación cuánto dura
	/// un retardo en vez de ejecutarlo.
	/// \param iterations Nº de iteraciones (n); <= 0 devuelve 0.
	/// \return Ciclos de CPU del bucle.
	[[nodiscard]] static int delay_cycles(int iterations) noexcept {
		return iterations > 0 ? (iterations - 1) * 5 + 2 : 0;
	}
};

} // namespace n2a
