#pragma once

/// \file nes_apu.hpp
/// APU software (2A03) del camino de **fallback** (fase F7): modelo de registros
/// `$4000-$4017`, frame counter y síntesis de los canales pulse, triangle y noise
/// a un flujo de muestras mono.
///
/// Es una implementación **simplificada y documentada** pensada para validación y
/// comparación (contra `mesen`); no busca precisión ciclo a ciclo. El canal DMC
/// queda para una iteración posterior. La salida se mezcla de forma lineal (la
/// mezcla no lineal exacta es una optimización).
///
/// \note En el destino Amiga la generación se hará por bloques y en punto fijo;
/// aquí el acumulador de ciclos es entero para no depender de la FPU.

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

namespace n2a {

/// APU 2A03 mínima con los cinco registros de canal relevantes.
struct Apu {
	/// Reloj NTSC de la CPU (2A03) en Hz.
	static constexpr eng::u32 kCpuClock = 1789773u;

	// --- Tablas (NESdev) ---
	static constexpr eng::u8 kDuty[4][8] = {
		{0, 1, 0, 0, 0, 0, 0, 0},
		{0, 1, 1, 0, 0, 0, 0, 0},
		{0, 1, 1, 1, 1, 0, 0, 0},
		{1, 0, 0, 1, 1, 1, 1, 1},
	};
	static constexpr eng::u8 kTriangle[32] = {
		15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0,
		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
	static constexpr eng::u8 kLength[32] = {
		10, 254, 20, 2, 40, 4, 80, 6, 160, 8, 60, 10, 14, 12, 26, 14,
		12, 16, 24, 18, 48, 20, 96, 22, 192, 24, 72, 26, 16, 28, 32, 30};
	static constexpr eng::u16 kNoisePeriod[16] = {
		4, 8, 16, 32, 64, 96, 128, 160, 202, 254, 380, 508, 762, 1016, 2034, 4068};

	/// Canal de onda cuadrada (pulse 1 o 2).
	struct Pulse {
		eng::u16 period = 0;  ///< Periodo del timer (bits 10-0).
		eng::u16 timer = 0;   ///< Contador del timer.
		eng::u8 duty = 0;     ///< Forma de onda (0..3).
		eng::u8 seq = 0;      ///< Posición en la secuencia de duty.
		eng::u8 length = 0;   ///< Contador de longitud (0 = silencio).
		eng::u8 volume = 0;   ///< Volumen (0..15) del envelope/constante.
		eng::u8 env_period = 0; ///< Periodo del envelope.
		eng::u8 env_div = 0;  ///< Divisor del envelope.
		eng::u8 env_decay = 0; ///< Nivel de decaimiento (0..15).
		bool enabled = false; ///< Canal activo ($4015).
		bool length_halt = false; ///< Halt/lazo del length counter.
		bool const_vol = false;   ///< Volumen constante (vs. envelope).
		bool env_start = false;   ///< Reinicio del envelope.

		/// Salida instantánea del canal (0..15).
		[[nodiscard]] eng::u8 output() const {
			if (!enabled || length == 0u) {
				return 0u;
			}
			return kDuty[duty][seq] != 0u ? volume : 0u;
		}
	};

	/// Canal de triángulo.
	struct Triangle {
		eng::u16 period = 0;
		eng::u16 timer = 0;
		eng::u8 seq = 0;
		eng::u8 length = 0;
		eng::u8 linear = 0;
		eng::u8 linear_reload = 0;
		bool linear_control = false;
		bool linear_reload_flag = false;
		bool length_halt = false;

		/// Salida escalonada (0..15) o 0 si está silenciado.
		[[nodiscard]] eng::u8 output() const {
			if (length == 0u || linear == 0u) {
				return 0u;
			}
			return kTriangle[seq];
		}
	};

	/// Canal de ruido.
	struct Noise {
		eng::u16 period = 0;
		eng::u16 timer = 0;
		eng::u16 lfsr = 1;
		eng::u8 volume = 0;
		eng::u8 length = 0;
		bool mode = false;
		bool enabled = false;
		bool length_halt = false;
		bool const_vol = false;

		/// Salida (0..15) según el bit bajo del LFSR.
		[[nodiscard]] eng::u8 output() const {
			if (!enabled || length == 0u || (lfsr & 1u) != 0u) {
				return 0u;
			}
			return volume;
		}
	};

	Pulse pulse1;   ///< Canal pulse 1 ($4000-$4003).
	Pulse pulse2;   ///< Canal pulse 2 ($4004-$4007).
	Triangle triangle; ///< Canal triangle ($4008-$400B).
	Noise noise;    ///< Canal noise ($400C-$400F).

	eng::u32 sample_rate = 22050u; ///< Frecuencia de muestreo de salida.
	eng::u32 acc = 0;              ///< Acumulador de ciclos para el remuestreo.
	eng::u32 cycles = 0;           ///< Ciclos de CPU transcurridos.
	bool odd = false;              ///< Toggle para reloj de pulse/noise (cada 2 ciclos).
	eng::u32 frame_div = 0;        ///< Divisor del frame counter.
	eng::u8 frame_step = 0;        ///< Paso del frame counter (4 o 5).
	bool frame_irq = false;        ///< IRQ pendiente del frame counter.

	/// Escribe un registro del APU (`$4000-$4017`).
	/// \param addr  Dirección dentro de `$4000-$4017`.
	/// \param value Byte a escribir.
	void write_reg(eng::u16 addr, eng::u8 value) {
		if (addr >= 0x4000u && addr <= 0x4003u) {
			write_pulse(pulse1, static_cast<eng::u8>(addr - 0x4000u), value);
		} else if (addr <= 0x4007u) {
			write_pulse(pulse2, static_cast<eng::u8>(addr - 0x4004u), value);
		} else if (addr == 0x4008u) {
			triangle.linear_control = (value & 0x80u) != 0u;
			triangle.length_halt = (value & 0x80u) != 0u;
			triangle.linear_reload = static_cast<eng::u8>(value & 0x7Fu);
		} else if (addr == 0x400Au) {
			triangle.period = static_cast<eng::u16>((triangle.period & 0x700u) | value);
		} else if (addr == 0x400Bu) {
			triangle.period = static_cast<eng::u16>((triangle.period & 0x0FFu) | ((value & 0x07u) << 8u));
			triangle.length = kLength[value >> 3];
			triangle.linear_reload_flag = true;
		} else if (addr == 0x400Cu) {
			noise.length_halt = (value & 0x20u) != 0u;
			noise.const_vol = (value & 0x10u) != 0u;
			noise.volume = static_cast<eng::u8>(value & 0x0Fu);
		} else if (addr == 0x400Eu) {
			noise.mode = (value & 0x80u) != 0u;
			noise.period = kNoisePeriod[value & 0x0Fu];
		} else if (addr == 0x400Fu) {
			noise.length = kLength[value >> 3];
		} else if (addr == 0x4015u) {
			pulse1.enabled = (value & 0x01u) != 0u;
			pulse2.enabled = (value & 0x02u) != 0u;
			triangle.length = (value & 0x04u) != 0u ? triangle.length : 0u;
			noise.enabled = (value & 0x08u) != 0u;
			if ((value & 0x01u) == 0u) pulse1.length = 0u;
			if ((value & 0x02u) == 0u) pulse2.length = 0u;
			if ((value & 0x08u) == 0u) noise.length = 0u;
			frame_irq = false;
		} else if (addr == 0x4017u) {
			frame_step = 0u;
			frame_div = 0u;
			if ((value & 0x40u) != 0u) {
				frame_irq = false;
			}
		}
	}

	/// Lee `$4015`: bits 0..3 por canal activo y bit 6 por IRQ del frame counter.
	/// \return El byte de estado (limpia `frame_irq`).
	[[nodiscard]] eng::u8 read_status() {
		eng::u8 r = 0u;
		if (pulse1.length != 0u) r = static_cast<eng::u8>(r | 0x01u);
		if (pulse2.length != 0u) r = static_cast<eng::u8>(r | 0x02u);
		if (triangle.length != 0u) r = static_cast<eng::u8>(r | 0x04u);
		if (noise.length != 0u) r = static_cast<eng::u8>(r | 0x08u);
		if (frame_irq) r = static_cast<eng::u8>(r | 0x40u);
		frame_irq = false;
		return r;
	}

	/// Genera `out.size()` muestras mono con signo a `sample_rate`.
	/// \param out Búfer destino de 16 bits.
	void generate_samples(eng::Span<eng::s16> out) {
		for (eng::usize i = 0; i < out.size(); ++i) {
			acc += kCpuClock;
			while (acc >= sample_rate) {
				acc -= sample_rate;
				clock();
			}
			out[i] = mix();
		}
	}

private:
	/// Escribe uno de los 4 registros de un pulse (`n` = 0..3).
	static void write_pulse(Pulse& p, eng::u8 n, eng::u8 value) {
		switch (n) {
		case 0u:
			p.duty = static_cast<eng::u8>((value >> 6) & 0x03u);
			p.length_halt = (value & 0x20u) != 0u;
			p.const_vol = (value & 0x10u) != 0u;
			p.env_period = static_cast<eng::u8>(value & 0x0Fu);
			p.volume = p.const_vol ? p.env_period : p.env_decay;
			break;
		case 2u:
			p.period = static_cast<eng::u16>((p.period & 0x700u) | value);
			break;
		case 3u:
			p.period = static_cast<eng::u16>((p.period & 0x0FFu) | ((value & 0x07u) << 8u));
			p.length = kLength[value >> 3];
			p.seq = 0u;
			p.env_start = true;
			break;
		default:
			break;
		}
	}

	/// Avanza el estado del APU un ciclo de CPU.
	void clock() {
		// Triangle avanza cada ciclo; pulse y noise cada dos.
		clock_triangle();
		if (!odd) {
			clock_pulse(pulse1);
			clock_pulse(pulse2);
			clock_noise();
		}
		odd = !odd;

		if (++frame_div >= 7458u) {
			frame_div = 0u;
			clock_frame();
		}
		++cycles;
	}

	static void clock_pulse(Pulse& p) {
		if (p.timer == 0u) {
			p.timer = p.period;
			p.seq = static_cast<eng::u8>((p.seq + 1u) & 7u);
		} else {
			--p.timer;
		}
	}

	void clock_triangle() {
		if (triangle.timer == 0u) {
			triangle.timer = triangle.period;
			if (triangle.length != 0u && triangle.linear != 0u) {
				triangle.seq = static_cast<eng::u8>((triangle.seq + 1u) & 31u);
			}
		} else {
			--triangle.timer;
		}
	}

	void clock_noise() {
		if (noise.timer == 0u) {
			noise.timer = noise.period;
			const eng::u16 feedback =
				static_cast<eng::u16>((noise.lfsr & 1u) ^
						      ((noise.lfsr >> (noise.mode ? 6u : 1u)) & 1u));
			noise.lfsr = static_cast<eng::u16>((noise.lfsr >> 1u) | (feedback << 14u));
		} else {
			--noise.timer;
		}
	}

	/// Frame counter (4 pasos): decae los length counters (si no están en halt) y
	/// reinicia el envelope de pulse. Aproximado; suficiente para la mezcla.
	void clock_frame() {
		if (!pulse1.length_halt && pulse1.length > 0u) --pulse1.length;
		if (!pulse2.length_halt && pulse2.length > 0u) --pulse2.length;
		if (!noise.length_halt && noise.length > 0u) --noise.length;
		if (pulse1.env_start) {
			pulse1.env_start = false;
			pulse1.env_decay = 15u;
			pulse1.env_div = pulse1.env_period;
			if (!pulse1.const_vol) pulse1.volume = pulse1.env_decay;
		}
		frame_step = static_cast<eng::u8>((frame_step + 1u) & 3u);
	}

	/// Mezcla lineal de los canales a una muestra de 16 bits.
	[[nodiscard]] eng::s16 mix() const {
		const int p1 = pulse1.output();
		const int p2 = pulse2.output();
		const int tri = triangle.output();
		const int noi = noise.output();
		int v = (p1 + p2) * 160 + tri * 200 + noi * 120;
		if (v > 32767) v = 32767;
		if (v < -32768) v = -32768;
		return static_cast<eng::s16>(v);
	}
};

} // namespace n2a
