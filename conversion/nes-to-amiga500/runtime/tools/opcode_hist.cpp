// opcode_hist.cpp — histograma de opcodes sobre la ejecución real y tasa de
// cobertura del ejecutor rápido (`FastCpu`). Engancha un hook que envuelve
// `FastCpu::step`: lee el opcode en `cpu.PC`, lo cuenta y registra si el ejecutor
// lo resolvió (ciclos > 0) o cayó al intérprete (0).
//
// Sirve para decidir qué opcodes añadir a continuación, priorizando por
// frecuencia observada en el juego.
//
// Uso: opcode_hist <rom.nes> [frames=300] [top=25]

#include <cstdio>
#include <cstdlib>

#include "../include/nes_system.hpp"
#include "../host/fastcpu.hpp"
#include "../host/rom_loader.hpp"

namespace {

n2a::LoadedRom g_rom;
n2a::FastCpu* g_fc = nullptr;    ///< Ejecutor (para consultar `has[]`).
unsigned long g_hist[256];       ///< Veces que aparece cada opcode.
unsigned long g_addr[0x10000];   ///< Ejecuciones por dirección (calor de bloque).
unsigned long g_covered = 0;     ///< Instrucciones resueltas por FastCpu.
unsigned long g_fallback = 0;    ///< Instrucciones que caen al intérprete.
unsigned long g_undecoded = 0;   ///< Caídas por dirección no decodificada (no por opcode).
unsigned long g_ram = 0;         ///< Instrucciones ejecutadas en RAM (`$0000-$7FFF`).

/// Hook que envuelve `FastCpu::step` para contar cobertura por opcode.
int counting_step(void* ctx, n2a::CPU& cpu, n2a::NESMemory& mem) {
	const eng::u16 pc = cpu.PC;
	const eng::u8 op = mem.read(pc);
	++g_hist[op];
	++g_addr[pc];
	if (pc < 0x8000u) {
		++g_ram; // código en RAM (no decodificable estáticamente)
	}
	if (g_fc->has[pc] == 0u) {
		++g_undecoded; // la causa del fallback es la *dirección*, no el opcode
	}
	const int cyc = n2a::FastCpu::step(ctx, cpu, mem);
	if (cyc > 0) {
		++g_covered;
	} else {
		++g_fallback;
	}
	return cyc;
}

} // namespace

/// Escribe un fichero de hechos `hot <addr> <n>` para cada dirección decodificada
/// (incluidas las de calor 0 = bloques fríos), consumible por `--facts` del
/// transpilador. Devuelve `false` si no se pudo abrir.
bool write_hot_facts(const char* path, const n2a::FastCpu& fc) {
	std::FILE* fp = std::fopen(path, "wb");
	if (fp == nullptr) {
		return false;
	}
	for (unsigned a = 0; a < 0x10000u; ++a) {
		if (fc.has[a] != 0u) {
			std::fprintf(fp, "hot %04X %lX\n", a, g_addr[a]);
		}
	}
	std::fclose(fp);
	return true;
}

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: opcode_hist <rom.nes> [frames] [top] [hot-facts.txt]\n");
		return 1;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 300;
	const int top = (argc > 3) ? std::atoi(argv[3]) : 25;

	n2a::NesSystem sys;
	if (!n2a::load_ines(argv[1], g_rom)) {
		std::printf("error: no se pudo cargar '%s'\n", argv[1]);
		return 1;
	}
	sys.load_mapper(g_rom.mapper);
	sys.reset();

	n2a::FastCpu fast;
	fast.build(g_rom.mapper.prg, g_rom.mapper.prg_size, sys.mem.read16(0xFFFCu),
		   sys.mem.read16(0xFFFAu), sys.mem.read16(0xFFFEu));
	g_fc = &fast;
	sys.fast_ctx = &fast;
	sys.fast_step = &counting_step;

	for (int i = 0; i < frames; ++i) {
		sys.run_frame();
	}

	const unsigned long total = g_covered + g_fallback;
	std::printf("rom          : %s\n", argv[1]);
	std::printf("frames       : %d\n", frames);
	std::printf("instrucciones: %lu  cubiertas: %lu (%.1f%%)  fallback: %lu (%.1f%%)\n", total,
			g_covered, total ? 100.0 * g_covered / total : 0.0, g_fallback,
			total ? 100.0 * g_fallback / total : 0.0);
	std::printf("  decodificaciones al vuelo (has==0 antes del step): %lu (%.2f%%)\n",
			g_undecoded, total ? 100.0 * g_undecoded / total : 0.0);
	std::printf("  codigo en RAM (f): %lu (%.3f%%)\n", g_ram,
			total ? 100.0 * g_ram / total : 0.0);

	// Ranking de opcodes que caen al intérprete (los candidatos a cubrir),
	// ordenados por frecuencia.
	int order[256];
	for (int i = 0; i < 256; ++i) {
		order[i] = i;
	}
	for (int i = 0; i < 256; ++i) {
		for (int j = i + 1; j < 256; ++j) {
			if (g_hist[order[j]] > g_hist[order[i]]) {
				const int t = order[i];
				order[i] = order[j];
				order[j] = t;
			}
		}
	}

	std::printf("\n--- opcodes mas frecuentes (todos) ---\n");
	int shown = 0;
	for (int k = 0; k < 256 && shown < top; ++k) {
		const int op = order[k];
		if (g_hist[op] == 0) {
			break;
		}
		++shown;
		std::printf("  %02X %-3s  %8lu\n", op, n2a::kOpcodeTable[op].mnemonic, g_hist[op]);
	}

	// Fallback real: se recalcula marcando los opcodes que devolvieron 0 en la
	// primera pasada; aquí basta con listar los que el ejecutor no cubre.
	std::printf("\n--- fallback (opcodes no cubiertos por FastCpu) mas frecuentes ---\n");
	shown = 0;
	for (int k = 0; k < 256 && shown < top; ++k) {
		const int op = order[k];
		if (g_hist[op] == 0) {
			break;
		}
		if (n2a::FastCpu::covers(static_cast<eng::u8>(op))) {
			continue;
		}
		++shown;
		std::printf("  %02X %-3s  %8lu\n", op, n2a::kOpcodeTable[op].mnemonic, g_hist[op]);
	}
	if (shown == 0) {
		std::printf("  (ninguno)\n");
	}

	// Direcciones de RAM más ejecutadas: candidatas a HLE (rutinas copiadas a RAM).
	std::printf("\n--- direcciones RAM mas calientes (candidatas a HLE) ---\n");
	eng::u16 ram_order[512];
	eng::u32 ram_n = 0;
	for (eng::u32 a = 0; a < 0x8000u && ram_n < 512u; ++a) {
		if (g_addr[a] != 0u) {
			ram_order[ram_n++] = static_cast<eng::u16>(a);
		}
	}
	for (eng::u32 i = 1u; i < ram_n; ++i) {
		const eng::u16 ka = ram_order[i];
		eng::u32 j = i;
		while (j > 0u && g_addr[ka] > g_addr[ram_order[j - 1u]]) {
			ram_order[j] = ram_order[j - 1u];
			--j;
		}
		ram_order[j] = ka;
	}
	shown = 0;
	for (eng::u32 i = 0; i < ram_n && shown < top; ++i) {
		std::printf("  %04X  %8lu\n", ram_order[i], g_addr[ram_order[i]]);
		++shown;
	}
	if (shown == 0) {
		std::printf("  (ninguna: sin codigo en RAM)\n");
	}

	if (argc > 4) {
		if (write_hot_facts(argv[4], fast)) {
			std::printf("\nhechos de calor -> %s (--facts del transpilador)\n", argv[4]);
		} else {
			std::printf("\nerror: no se pudo escribir '%s'\n", argv[4]);
		}
	}

	fast.destroy();
	return 0;
}
