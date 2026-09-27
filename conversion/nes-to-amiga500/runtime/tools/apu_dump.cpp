// apu_dump — genera un WAV de referencia del APU software para escuchar/validar
// los canales. Ejercita, en orden: (1) un pulse con **sweep** (subida de tono,
// tipo salto), (2) un pulse con envolvente que decae (tipo disparo) y (3) un
// **noise** con envolvente (tipo explosión). Sirve para comprobar de oído que el
// sweep y la envolvente del noise funcionan; el A/B numérico contra `mesen` no es
// posible desde el orquestador (descarta el audio).
//
// Uso: apu_dump [salida.wav] [segundos]

#include <cstdio>
#include <cstdlib>
#include <cstring>

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

#include "nes_apu.hpp"

namespace {

/// Escribe una cabecera WAV (RIFF/PCM 16 bits mono) con `frames` muestras.
void write_wav_header(std::FILE* f, eng::u32 rate, eng::u32 frames) {
	const eng::u32 data = frames * 2u;
	const eng::u32 riff = 36u + data;
	auto u32le = [&](eng::u32 v) {
		const unsigned char b[4] = {static_cast<unsigned char>(v & 0xFFu),
					    static_cast<unsigned char>((v >> 8u) & 0xFFu),
					    static_cast<unsigned char>((v >> 16u) & 0xFFu),
					    static_cast<unsigned char>((v >> 24u) & 0xFFu)};
		std::fwrite(b, 1, 4, f);
	};
	auto tag = [&](const char* s) { std::fwrite(s, 1, 4, f); };
	tag("RIFF");
	u32le(riff);
	tag("WAVE");
	tag("fmt ");
	u32le(16u);
	const unsigned char pcm[2] = {1, 0};
	std::fwrite(pcm, 1, 2, f);   // PCM
	const unsigned char ch[2] = {1, 0};
	std::fwrite(ch, 1, 2, f);    // mono
	u32le(rate);
	u32le(rate * 2u);            // byte rate
	const unsigned char ba[2] = {2, 0};
	std::fwrite(ba, 1, 2, f);    // block align
	const unsigned char bps[2] = {16, 0};
	std::fwrite(bps, 1, 2, f);   // bits/sample
	tag("data");
	u32le(data);
}

} // namespace

int main(int argc, char** argv) {
	const char* out = (argc > 1) ? argv[1] : "apu_dump.wav";
	const eng::u32 rate = 44100u;

	n2a::Apu apu;
	apu.sample_rate = rate;
	apu.write_reg(0x4015u, 0x0Fu); // pulse1 + pulse2 + triangle + noise

	std::FILE* f = std::fopen(out, "wb");
	if (f == nullptr) {
		std::printf("error: no se pudo escribir '%s'\n", out);
		return 1;
	}
	write_wav_header(f, rate, 0u); // el tamaño se recalcula al final; ver abajo
	eng::u32 total = 0u;

	eng::s16 buf[1024];
	auto play_seconds = [&](double sec, auto&& on_tick) {
		const eng::u32 n = static_cast<eng::u32>(sec * static_cast<double>(rate));
		eng::u32 done = 0u;
		while (done < n) {
			const eng::u32 chunk = (n - done < 1024u) ? (n - done) : 1024u;
			on_tick();
			apu.generate_samples(eng::Span<eng::s16> {buf, chunk});
			std::fwrite(buf, 2, chunk, f);
			done += chunk;
			total += chunk;
		}
	};

	// (1) Pulse con sweep **negate** (periodo decrece → tono ASCENDENTE, tipo salto).
	// Divisor P=7 para que el cambio sea gradual y audible ~1 s.
	apu.write_reg(0x4000u, 0xBFu); // duty 2, halt, volumen constante 15
	apu.write_reg(0x4002u, 0x00u);
	apu.write_reg(0x4003u, 0x02u); // periodo = $200 (512)
	play_seconds(0.05, [&] { apu.write_reg(0x4001u, 0xFBu); }); // E=1,P=7,N=1,S=3
	play_seconds(1.0, [&] {});

	// (2) Pulse con envolvente que decae: "disparo". ~0.4 s.
	apu.write_reg(0x4001u, 0x08u);  // desactiva sweep
	apu.write_reg(0x4000u, 0xB8u);  // duty 2, halt, envelope, periodo 8
	apu.write_reg(0x4002u, 0x08u);
	apu.write_reg(0x4003u, 0x08u);  // arranca la envolvente
	play_seconds(0.4, [&] {});

	// (3) Noise con envolvente: "explosión". ~0.5 s.
	apu.write_reg(0x4000u, 0x30u);  // silencia pulse1 (volumen 0)
	apu.write_reg(0x400Cu, 0x08u);  // noise: envelope, periodo 8
	apu.write_reg(0x400Eu, 0x06u);  // periodo del ruido
	apu.write_reg(0x400Fu, 0x08u);  // arranca la envolvente del noise
	play_seconds(0.5, [&] {});

	// Reescribe la cabecera con el tamaño real y cierra.
	std::fseek(f, 0, SEEK_SET);
	write_wav_header(f, rate, total);
	std::fclose(f);
	std::printf("apu_dump: %u frames (%.2f s) -> %s\n", total,
		    static_cast<double>(total) / static_cast<double>(rate), out);
	return 0;
}
