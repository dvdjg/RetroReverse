#pragma once

/// \file nes_apu.hpp
/// APU software (2A03) del camino de **fallback** (fase F7): modelo de registros
/// `$4000-$4017`, frame counter y síntesis de los cinco canales (pulse ×2,
/// triangle, noise y DMC) a un flujo de muestras mono, con **mezcla no lineal**
/// (tablas NESdev) y **envelope** de los dos pulse y del noise, además del
/// **sweep** de los pulse.
///
/// Es una implementación **simplificada y documentada** pensada para validación y
/// comparación (contra `mesen`); no busca precisión ciclo a ciclo (el DMC lee sus
/// muestras de la PRG mediante `set_reader`).
///
/// \note En el destino Amiga la generación se hará por bloques y en punto fijo;
/// aquí el acumulador de ciclos es entero para no depender de la FPU.

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>
#include <eng/core/util/array.hpp>

namespace n2a {

namespace apu_detail {

/// Tabla de mezcla no lineal de los dos canales pulse (NESdev):
/// `95.88 / (8128/n + 100)`, `n = pulse1 + pulse2` (0..30).
[[nodiscard]] consteval eng::util::Array<float, 31> make_pulse_table() {
	eng::util::Array<float, 31> t {};
	for (int n = 1; n < 31; ++n) {
		t[static_cast<eng::usize>(n)] = 95.88f / (8128.0f / static_cast<float>(n) + 100.0f);
	}
	return t;
}

/// Tabla de mezcla no lineal de triangle+noise+DMC (NESdev):
/// `163.67 / (24329/n + 100)`, `n = 3*triangle + 2*noise + DMC` (0..202).
[[nodiscard]] consteval eng::util::Array<float, 203> make_tnd_table() {
	eng::util::Array<float, 203> t {};
	for (int n = 1; n < 203; ++n) {
		t[static_cast<eng::usize>(n)] = 163.67f / (24329.0f / static_cast<float>(n) + 100.0f);
	}
	return t;
}

} // namespace apu_detail

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
	static constexpr eng::u16 kDmcRate[16] = {
		428, 380, 340, 320, 286, 254, 226, 214, 190, 160, 142, 128, 106, 84, 72, 54};

	/// Tabla de mezcla no lineal de pulse (construida por `apu_detail`).
	static constexpr eng::util::Array<float, 31> kPulseTable = apu_detail::make_pulse_table();
	/// Tabla de mezcla no lineal de triangle+noise+DMC.
	static constexpr eng::util::Array<float, 203> kTndTable = apu_detail::make_tnd_table();

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

		// --- Sweep ($4001/$4005) ---
		bool sweep_enable = false; ///< E del registro de sweep.
		bool sweep_negate = false; ///< N: decrementa el periodo (vs. incrementa).
		eng::u8 sweep_period = 0;  ///< P: divisor del sweep (0..7).
		eng::u8 sweep_shift = 0;   ///< S: desplazamiento (0..7).
		eng::u8 sweep_div = 0;     ///< Divisor actual del sweep.
		bool sweep_reload = false; ///< Recarga el divisor en el próximo reloj.
		/// Diferencia documentada entre canales: pulse1 resta `+1` al negar, pulse2 no.
		bool quirk_pulse1 = false;

		/// Periodo **destino** del sweep (0..0x7FF, sin clamp) según N/`sweep_shift`.
		/// \return El periodo tras aplicar el desplazamiento (puede salir de rango).
		[[nodiscard]] eng::u16 sweep_target() const {
			const int delta = static_cast<int>(period) >> sweep_shift;
			int t = static_cast<int>(period);
			if (sweep_negate) {
				t -= delta + (quirk_pulse1 ? 1 : 0);
			} else {
				t += delta;
			}
			if (t < 0) {
				t = 0;
			}
			return static_cast<eng::u16>(t);
		}

		/// ¿El sweep silencia el canal? Si el periodo es < 8 o el destino > 0x7FF,
		/// el canal queda mudo (independientemente de E).
		[[nodiscard]] bool sweep_muted() const {
			return period < 8u || sweep_target() > 0x7FFu;
		}

		/// Salida instantánea del canal (0..15). Usa el **envelope** (`env_decay`) si
		/// no es volumen constante (`const_vol`), o `env_period` como volumen fijo.
		/// Silencia si el sweep está fuera de rango.
		[[nodiscard]] eng::u8 output() const {
			if (!enabled || length == 0u || sweep_muted()) {
				return 0u;
			}
			const eng::u8 vol = const_vol ? env_period : env_decay;
			return kDuty[duty][seq] != 0u ? vol : 0u;
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
		eng::u8 volume = 0;   ///< Volumen constante ($400C) o periodo del envelope.
		eng::u8 length = 0;
		bool mode = false;
		bool enabled = false;
		bool length_halt = false;
		bool const_vol = false;

		// --- Envelope ($400C) ---
		eng::u8 env_period = 0; ///< Periodo del envelope.
		eng::u8 env_div = 0;    ///< Divisor del envelope.
		eng::u8 env_decay = 0;  ///< Nivel de decaimiento (0..15).
		bool env_start = false; ///< Reinicio del envelope.

		/// Salida (0..15) según el bit bajo del LFSR y el volumen/envelope.
		[[nodiscard]] eng::u8 output() const {
			if (!enabled || length == 0u || (lfsr & 1u) != 0u) {
				return 0u;
			}
			return const_vol ? volume : env_decay;
		}
	};

	/// Canal DMC (modulación delta). Lee bytes de memoria mediante `reader`
	/// (que fija `set_reader`).
	struct Dmc {
		eng::u16 rate = 0;            ///< Periodo del timer (tabla).
		eng::u16 timer = 0;           ///< Contador del timer.
		eng::u8 output = 0;           ///< Nivel de salida (0..127).
		eng::u16 sample_address = 0;  ///< Dirección inicial del sample.
		eng::u16 sample_length = 0;   ///< Longitud en bytes.
		eng::u16 current_address = 0; ///< Dirección de lectura actual.
		eng::u16 bytes_remaining = 0; ///< Bytes que quedan por leer.
		eng::u8 shift_register = 0;   ///< Registro de desplazamiento (8 bits).
		eng::u8 bits_remaining = 8;   ///< Bits que quedan del registro.
		eng::u8 sample_buffer = 0;    ///< Byte precargado.
		bool silence = true;          ///< Sin bits activos.
		bool buffer_empty = true;     ///< ¿Buffer de sample vacío?
		bool irq_enable = false;      ///< IRQ al terminar el sample.
		bool loop = false;            ///< Repetir el sample.
	};

	/// Callback de lectura de memoria para el DMC.
	using Reader = eng::u8 (*)(void* user, eng::u16 addr);

	Pulse pulse1;   ///< Canal pulse 1 ($4000-$4003).
	Pulse pulse2;   ///< Canal pulse 2 ($4004-$4007).
	Triangle triangle; ///< Canal triangle ($4008-$400B).
	Noise noise;    ///< Canal noise ($400C-$400F).
	Dmc dmc;        ///< Canal DMC ($4010-$4013).
	bool dmc_irq = false; ///< IRQ pendiente del DMC.

	/// Enlaza el lector de memoria del DMC.
	/// \param r Función que devuelve el byte en `addr` (o `nullptr`).
	/// \param user Cookie que se pasa a `r`.
	void set_reader(Reader r, void* user = nullptr) {
		reader = r;
		reader_user = user;
	}

	eng::u32 sample_rate = 22050u; ///< Frecuencia de muestreo de salida.
	eng::u32 acc = 0;              ///< Acumulador de ciclos para el remuestreo.
	eng::u32 cycles = 0;           ///< Ciclos de CPU transcurridos.
	bool odd = false;              ///< Toggle para reloj de pulse/noise (cada 2 ciclos).
	eng::u32 frame_div = 0;        ///< Divisor del frame counter.
	eng::u8 frame_step = 0;        ///< Paso del frame counter (4 o 5).
	bool frame_irq = false;        ///< IRQ pendiente del frame counter.
	bool frame_irq_inhibit = false; ///< IRQ del frame counter inhibida ($4017 bit 6).

	/// Escribe un registro del APU (`$4000-$4017`).
	/// \param addr  Dirección dentro de `$4000-$4017`.
	/// \param value Byte a escribir.
	void write_reg(eng::u16 addr, eng::u8 value) {
		if (addr >= 0x4000u && addr <= 0x4003u) {
			write_pulse(pulse1, static_cast<eng::u8>(addr - 0x4000u), value, true);
		} else if (addr <= 0x4007u) {
			write_pulse(pulse2, static_cast<eng::u8>(addr - 0x4004u), value, false);
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
			noise.env_period = static_cast<eng::u8>(value & 0x0Fu);
		} else if (addr == 0x400Eu) {
			noise.mode = (value & 0x80u) != 0u;
			noise.period = kNoisePeriod[value & 0x0Fu];
		} else if (addr == 0x400Fu) {
			noise.length = kLength[value >> 3];
			noise.env_start = true; // $400F reinicia la envolvente del noise
		} else if (addr == 0x4010u) {
			dmc.irq_enable = (value & 0x80u) != 0u;
			dmc.loop = (value & 0x40u) != 0u;
			dmc.rate = kDmcRate[value & 0x0Fu];
			if (!dmc.irq_enable) {
				dmc_irq = false;
			}
		} else if (addr == 0x4011u) {
			dmc.output = static_cast<eng::u8>(value & 0x7Fu);
		} else if (addr == 0x4012u) {
			dmc.sample_address = static_cast<eng::u16>(0xC000u | (static_cast<eng::u16>(value) << 6u));
		} else if (addr == 0x4013u) {
			dmc.sample_length = static_cast<eng::u16>((static_cast<eng::u16>(value) << 4u) + 1u);
		} else if (addr == 0x4015u) {
			pulse1.enabled = (value & 0x01u) != 0u;
			pulse2.enabled = (value & 0x02u) != 0u;
			triangle.length = (value & 0x04u) != 0u ? triangle.length : 0u;
			noise.enabled = (value & 0x08u) != 0u;
			if ((value & 0x01u) == 0u) pulse1.length = 0u;
			if ((value & 0x02u) == 0u) pulse2.length = 0u;
			if ((value & 0x08u) == 0u) noise.length = 0u;
			if ((value & 0x10u) == 0u) {
				dmc.bytes_remaining = 0u;
			} else if (dmc.bytes_remaining == 0u) {
				start_dmc();
			}
			dmc_irq = false;
			frame_irq = false;
		} else if (addr == 0x4017u) {
			frame_step = 0u;
			frame_div = 0u;
			frame_irq_inhibit = (value & 0x40u) != 0u; // bit 6 = inhibir IRQ
			if (frame_irq_inhibit) {
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
		if (dmc.bytes_remaining != 0u) r = static_cast<eng::u8>(r | 0x10u);
		if (frame_irq) r = static_cast<eng::u8>(r | 0x40u);
		if (dmc_irq) r = static_cast<eng::u8>(r | 0x80u);
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
	Reader reader = nullptr;     ///< Lector de memoria del DMC (o `nullptr`).
	void* reader_user = nullptr; ///< Cookie pasada a `reader`.

	/// Escribe uno de los 4 registros de un pulse (`n` = 0..3).
	/// \param pulse1 `true` para el canal 1 (sweep resta `+1` al negar).
	static void write_pulse(Pulse& p, eng::u8 n, eng::u8 value, bool pulse1) {
		p.quirk_pulse1 = pulse1;
		switch (n) {
		case 0u:
			p.duty = static_cast<eng::u8>((value >> 6) & 0x03u);
			p.length_halt = (value & 0x20u) != 0u;
			p.const_vol = (value & 0x10u) != 0u;
			p.env_period = static_cast<eng::u8>(value & 0x0Fu);
			p.volume = p.const_vol ? p.env_period : p.env_decay;
			break;
		case 1u:  // $4001/$4005: sweep (EPPP NSSS)
			p.sweep_enable = (value & 0x80u) != 0u;
			p.sweep_period = static_cast<eng::u8>((value >> 4) & 0x07u);
			p.sweep_negate = (value & 0x08u) != 0u;
			p.sweep_shift = static_cast<eng::u8>(value & 0x07u);
			p.sweep_reload = true; // el divisor recarga en el próximo reloj
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

		clock_dmc();

		if (++frame_div >= 7458u) {
			frame_div = 0u;
			clock_frame();
		}
		++cycles;
	}

	/// Inicia el sample del DMC: apunta al inicio y recarga el contador de bytes.
	void start_dmc() {
		dmc.current_address = dmc.sample_address;
		dmc.bytes_remaining = dmc.sample_length;
		dmc.bits_remaining = 8u;
	}

	/// Avanza el canal DMC un ciclo: modula el nivel de salida según los bits del
	/// sample y pide bytes nuevos por `reader`.
	void clock_dmc() {
		if (dmc.timer == 0u) {
			dmc.timer = dmc.rate;
			if (!dmc.silence) {
				if ((dmc.shift_register & 1u) != 0u) {
					if (dmc.output <= 125u) dmc.output = static_cast<eng::u8>(dmc.output + 2u);
				} else {
					if (dmc.output >= 2u) dmc.output = static_cast<eng::u8>(dmc.output - 2u);
				}
				dmc.shift_register = static_cast<eng::u8>(dmc.shift_register >> 1u);
			}
			if (--dmc.bits_remaining == 0u) {
				dmc.bits_remaining = 8u;
				if (!dmc.buffer_empty) {
					dmc.silence = false;
					dmc.shift_register = dmc.sample_buffer;
					dmc.buffer_empty = true;
				} else {
					dmc.silence = true;
				}
				// Recarga el buffer con el siguiente byte si hace falta.
				if (dmc.buffer_empty && dmc.bytes_remaining > 0u && reader != nullptr) {
					dmc.sample_buffer = reader(reader_user, dmc.current_address);
					dmc.buffer_empty = false;
					dmc.current_address =
						static_cast<eng::u16>((dmc.current_address + 1u) | 0x8000u);
					if (--dmc.bytes_remaining == 0u) {
						if (dmc.loop) {
							start_dmc();
						} else if (dmc.irq_enable) {
							dmc_irq = true;
						}
					}
				}
			}
		} else {
			--dmc.timer;
		}
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

	/// Reloj del **envelope** de un canal (arranque y decaimiento). Se llama a
	/// ~240 Hz desde `clock_frame`. Sin esto, los canales en modo envelope quedaban
	/// mudos o sin decaer. Vale tanto para `Pulse` como para `Noise` (mismos campos).
	/// \param ch Canal a relojear.
	template <typename Ch>
	static void clock_envelope(Ch& ch) {
		if (ch.env_start) {
			ch.env_start = false;
			ch.env_decay = 15u;
			ch.env_div = ch.env_period;
			return;
		}
		if (ch.env_div == 0u) {
			ch.env_div = ch.env_period;
			if (ch.env_decay > 0u) {
				--ch.env_decay;
			} else if (ch.length_halt) {
				ch.env_decay = 15u; // lazo del envelope
			}
		} else {
			--ch.env_div;
		}
	}

	/// Reloj del **sweep** de un pulse (~120 Hz, medios frames): aplica el
	/// desplazamiento al periodo (si E y S != 0 y no está mudo) y recarga el
	/// divisor. Sin esto, los efectos de frecuencia de los pulse (saltos, disparos)
	/// sonaban mal o planos.
	/// \param p Canal pulse a relojear.
	static void clock_sweep(Pulse& p) {
		if (p.sweep_div == 0u && p.sweep_enable && p.sweep_shift != 0u && !p.sweep_muted()) {
			p.period = p.sweep_target();
		}
		if (p.sweep_div == 0u || p.sweep_reload) {
			p.sweep_div = p.sweep_period;
			p.sweep_reload = false;
		} else {
			--p.sweep_div;
		}
	}

	/// Frame counter (4 pasos): decae los length counters (si no están en halt,
	/// ~120 Hz), relojea el **envelope** de los dos pulses y del noise (~240 Hz) y
	/// el **sweep** de los pulses (~120 Hz). Aproximado; suficiente para la mezcla.
	void clock_frame() {
		if ((frame_step & 1u) == 0u) {
			if (!pulse1.length_halt && pulse1.length > 0u) --pulse1.length;
			if (!pulse2.length_halt && pulse2.length > 0u) --pulse2.length;
			if (!noise.length_halt && noise.length > 0u) --noise.length;
			if (!triangle.length_halt && triangle.length > 0u) --triangle.length;
			clock_sweep(pulse1);
			clock_sweep(pulse2);
		}
		clock_envelope(pulse1);
		clock_envelope(pulse2);
		clock_envelope(noise);
		// IRQ del frame counter: se levanta al cerrar la secuencia (paso 3), salvo
		// que esté inhibida por `$4017` bit 6.
		if (frame_step == 3u && !frame_irq_inhibit) {
			frame_irq = true;
		}
		frame_step = static_cast<eng::u8>((frame_step + 1u) & 3u);
	}

	/// Mezcla **no lineal** de los canales (tablas NESdev) a una muestra de 16 bits.
	[[nodiscard]] eng::s16 mix() const {
		const int n = pulse1.output() + pulse2.output();
		const int t = 3 * triangle.output() + 2 * noise.output() + dmc.output;
		// `n` ∈ [0,30] y `t` ∈ [0,202]: índices dentro de las tablas.
		const float s = (kPulseTable[n] + kTndTable[t]) * 30000.0f;
		int v = static_cast<int>(s);
		if (v > 32767) v = 32767;
		if (v < -32768) v = -32768;
		return static_cast<eng::s16>(v);
	}
};

} // namespace n2a
