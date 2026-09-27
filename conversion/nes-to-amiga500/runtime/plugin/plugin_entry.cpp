// plugin_entry.cpp — plantilla del plugin `.n2x`: incluye el transpilado de una
// ROM (`n2a_game_impl.cpp`, generado por el transpilador) y exporta la ABI de
// `n2a_plugin.h`. Se compila junto con ese fichero generado:
//
//   g++ -O2 -shared -fPIC -I<build> -I<runtime/include> -I<runtime/host> \
//       plugin_entry.cpp -o juego.n2x
//
// El plugin solo lleva el **código generado** + la ROM; el intérprete/PPU/APU/
// mapper los aporta el gestor.

#include "n2a_plugin.h"

#define N2A_NO_HOST_MAIN
#include "n2a_game_impl.cpp" // -I <dir> con el fichero generado por nes_transpiler

#if defined(__wasm__)
#define N2A_ARCH N2A_ARCH_WASM
#elif defined(__m68k__)
#define N2A_ARCH N2A_ARCH_M68K
#elif defined(_WIN32)
#define N2A_ARCH N2A_ARCH_X64_NT
#else
#define N2A_ARCH N2A_ARCH_X64_LINUX
#endif

extern "C" {

int n2a_abi_version(void) { return N2A_ABI_VERSION; }
int n2a_abi_arch(void) { return N2A_ARCH; }

void n2a_init(void) { init_dispatch_table(); }

const unsigned char* n2a_prg(void) { return PRG_ROM; }
unsigned n2a_prg_size(void) { return static_cast<unsigned>(kPrgSize); }
const unsigned char* n2a_chr(void) { return CHR_ROM; }
unsigned n2a_chr_size(void) { return static_cast<unsigned>(kChrSize); }
int n2a_mapper(void) { return kMapper; }
int n2a_mirroring(void) { return kMirroring; }

int n2a_block(void* cpu_p, void* mem_p, int* instrs) {
	(void)mem_p;
	n2a::CPU& cpu = *static_cast<n2a::CPU*>(cpu_p);
	const eng::u16 pc = cpu.PC;
	if (dispatch_table[pc] == nullptr) {
		if (instrs != nullptr) {
			*instrs = 0;
		}
		return 0; // sin bloque (RAM/salto calculado): lo resuelve el gestor
	}
	const eng::u32 before = cpu.cycles;
	dispatch_table[pc](cpu);
	if (instrs != nullptr) {
		*instrs = 1;
	}
	const eng::u32 d = cpu.cycles - before;
	return d != 0u ? static_cast<int>(d) : 1;
}

} // extern "C"
