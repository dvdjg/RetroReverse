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
	n2a::CPU& cpu = *static_cast<n2a::CPU*>(cpu_p);
	const eng::u16 pc = cpu.PC;
	// Ventana conmutable ($8000-$BFFF) en mappers bancados (UxROM, F9/B1b): el
	// bloque depende del banco de PRG activo, que el sistema mantiene en
	// `NESMemory::prg_bank` en cada conmutación.
	const NESMemory* m = (mem_p != nullptr) ? static_cast<const NESMemory*>(mem_p) : cpu.mem;
	const eng::u8 bank = (m != nullptr) ? m->prg_bank : 0u;
	const eng::u8 bank2 = (m != nullptr) ? m->prg_bank2 : 0u;
	const eng::u8 bank3 = (m != nullptr) ? m->prg_bank3 : 0u;
	if (kPrgModeSensitive && bank == static_cast<eng::u8>(0xFFu)) {
		// MMC1 en un modo de ventanas no soportado: no valen ni los bloques por
		// banco ni los de la ventana fija -> fallback total al intérprete.
		if (instrs != nullptr) {
			*instrs = 0;
		}
		return 0;
	}
	BlockFn fn = nullptr;
	if (kPrgBanked && pc >= 0x8000u && pc < 0xC000u) {
		fn = n2a_banked_block(pc, bank, bank2, bank3);
	} else {
		fn = n2a_fixed_block(pc);
	}
	if (fn == nullptr) {
		if (instrs != nullptr) {
			*instrs = 0;
		}
		return 0; // sin bloque (RAM/salto calculado): lo resuelve el gestor
	}
	const eng::u32 before = cpu.cycles;
	fn(cpu);
	if (instrs != nullptr) {
		*instrs = 1;
	}
	const eng::u32 d = cpu.cycles - before;
	return d != 0u ? static_cast<int>(d) : 1;
}

} // extern "C"
