// ind_targets — colector de **destinos de salto indirecto por sitio**.
//
// POR QUÉ EXISTE
//   El backend nativo (estado del 6502 en variables locales) necesita saber **a
//   dónde puede saltar** un `JMP ($zp)` para poder emitir un despacho (`switch`)
//   en vez de caer al intérprete. El análisis estático no puede resolverlo (el
//   destino está en RAM, calculado en ejecución), así que se **observa**.
//
// QUÉ HACE
//   Ejecuta la ROM unos frames y, en cada `JMP ($zp)` (opcode `$6C`, el único
//   salto indirecto del 6502 estándar), registra el par `(sitio, destino)`:
//   el `PC` del `JMP` y el `PC` al que saltó. Escribe un fichero `ind <sitio>
//   <destino>` consumible por el transpilador (`--ind-targets`).
//
//   Nota: el 6502 **no** tiene `JSR (ind)`; todas las llamadas son absolutas.
//   Por eso este colector solo trata `$6C`.
//
// USO
//   ind_targets <rom.nes> <salida.txt> [frames=300] [max_pares=8192]
//
// SALIDA (fichero)
//   `ind <sitio> <destino>` por cada par observado (hex de 4 dígitos, sin `0x`).
//   También imprime un resumen por consola (sitios, destinos, cobertura).

#include <cstdio>
#include <cstdlib>

#include "../include/nes_system.hpp"
#include "../host/fastcpu.hpp"
#include "../host/rom_loader.hpp"

namespace {

/// Un par (sitio del `JMP (ind)`, destino observado). `site`/`target` son `PC`s 6502.
struct IndPair {
	eng::u16 site;   ///< Dirección del opcode `$6C`.
	eng::u16 target; ///< `PC` al que saltó.
};

IndPair g_pairs[16384]; ///< Pares únicos observados.
unsigned g_n = 0;       ///< Nº de pares únicos.
unsigned g_max = 8192;  ///< Límite de pares (argumento opcional).
unsigned long g_sites_seen = 0; ///< `JMP ($zp)` ejecutados en total.
bool g_overflow = false;        ///< Se alcanzó `g_max` y no se guardaron más.

/// Registra un par `(site, target)` si no estaba ya. No hace nada si se llegó al límite.
void record(eng::u16 site, eng::u16 target) {
	if (target == 0u) {
		return;
	}
	for (unsigned i = 0; i < g_n; ++i) {
		if (g_pairs[i].site == site && g_pairs[i].target == target) {
			return;
		}
	}
	if (g_n >= g_max) {
		g_overflow = true;
		return;
	}
	g_pairs[g_n].site = site;
	g_pairs[g_n].target = target;
	++g_n;
}

/// Hook que envuelve `FastCpu::step`: detecta `JMP ($zp)` y registra su destino.
int hook_step(void* ctx, n2a::CPU& cpu, n2a::NESMemory& mem) {
	const eng::u16 pc = cpu.PC;
	const eng::u8 op = mem.read(pc);
	const bool is_ind_jmp = (op == 0x6Cu);
	if (is_ind_jmp) {
		++g_sites_seen;
	}
	const int cyc = n2a::FastCpu::step(ctx, cpu, mem);
	if (is_ind_jmp) {
		// Tras el paso, `cpu.PC` es el destino al que saltó el `JMP ($zp)`.
		record(pc, cpu.PC);
	}
	return cyc;
}

/// Escribe el fichero de pares `ind <sitio> <destino>`. \return `false` si no se pudo abrir.
bool write_ind(const char* path) {
	std::FILE* fp = std::fopen(path, "wb");
	if (fp == nullptr) {
		return false;
	}
	std::fprintf(fp, "# destinos de JMP ($zp) observados: <sitio> -> <destino> (hex)\n");
	for (unsigned i = 0; i < g_n; ++i) {
		std::fprintf(fp, "ind %04X %04X\n", g_pairs[i].site, g_pairs[i].target);
	}
	std::fclose(fp);
	return true;
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 3) {
		std::printf("uso: ind_targets <rom.nes> <salida.txt> [frames=300] [max_pares=8192]\n");
		return 2;
	}
	const int frames = (argc > 3) ? std::atoi(argv[3]) : 300;
	if (argc > 4) {
		const int m = std::atoi(argv[4]);
		if (m > 0) {
			g_max = static_cast<unsigned>(m);
		}
	}

	n2a::LoadedRom rom;
	n2a::NesSystem sys;
	if (!n2a::load_ines(argv[1], rom)) {
		std::printf("error: no se pudo cargar '%s'\n", argv[1]);
		return 1;
	}
	sys.load_mapper(rom.mapper);
	sys.reset();

	n2a::FastCpu fast;
	fast.build(rom.mapper.prg, rom.mapper.prg_size, sys.mem.read16(0xFFFCu),
		   sys.mem.read16(0xFFFAu), sys.mem.read16(0xFFFEu));
	sys.fast_ctx = &fast;
	sys.fast_step = &hook_step;

	for (int i = 0; i < frames; ++i) {
		sys.run_frame();
	}

	// Estadística: nº de sitios distintos y media de destinos por sitio.
	unsigned sites = 0;
	for (unsigned i = 0; i < g_n; ++i) {
		bool first = true;
		for (unsigned j = 0; j < i; ++j) {
			if (g_pairs[j].site == g_pairs[i].site) {
				first = false;
				break;
			}
		}
		if (first) {
			++sites;
		}
	}
	std::printf("rom        : %s\n", argv[1]);
	std::printf("frames     : %d\n", frames);
	std::printf("JMP (ind)  : %lu ejecutados; sitios distintos: %u; pares unicos: %u\n",
			g_sites_seen, sites, g_n);
	std::printf("             destinos por sitio (media): %.2f\n",
			sites ? static_cast<double>(g_n) / static_cast<double>(sites) : 0.0);
	if (g_overflow) {
		std::printf("aviso      : limite de %u pares alcanzado; sube max_pares\n", g_max);
	}

	if (write_ind(argv[2])) {
		std::printf("destinos   -> %s (--ind-targets del transpilador)\n", argv[2]);
	} else {
		std::printf("error: no se pudo escribir '%s'\n", argv[2]);
		fast.destroy();
		return 1;
	}
	fast.destroy();
	return 0;
}
