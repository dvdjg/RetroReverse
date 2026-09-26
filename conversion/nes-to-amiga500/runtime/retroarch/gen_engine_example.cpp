// gen_engine_example.cpp — motor **codegen** para un core libretro: incluye el
// transpilado de UNA ROM concreta y exporta los hooks que libretro_core.cpp usa
// con `nes_engine=codegen` (o `auto`). Se compila/enlaza con
// build-codegen-core.sh, que genera `gen_rom.cpp` a partir de la ROM.
//
// No es un core genérico: C++ no se puede compilar en tiempo de ejecución, así
// que cada ROM transpilada necesita su propio enlazado (core específico).

#define N2A_NO_HOST_MAIN
#include "gen_rom.cpp" // generado por nes_transpiler (build-codegen-core.sh)

/// Inicializa la tabla de despacho del código generado (una vez al cargar).
extern "C" void n2a_codegen_init(void) { init_dispatch_table(); }

/// Ejecuta el `bb_*` de `cpu.PC` y devuelve sus ciclos exactos (delta de
/// `cpu.cycles`). Si la dirección no es un bloque (salto calculado), devuelve 0 y
/// el runtime resuelve esa instrucción con el intérprete.
extern "C" int n2a_codegen_step(n2a::CPU& cpu, n2a::NESMemory& mem, int budget, int* n) {
	(void)mem;
	const eng::u16 pc = cpu.PC;
	if (dispatch_table[pc] == nullptr) {
		if (n != nullptr) {
			*n = 0;
		}
		return 0;
	}
	(void)budget; // cesión por instrucción pendiente (ver docs/FAST_EXECUTOR.md)
	const eng::u32 before = cpu.cycles;
	dispatch_table[pc](cpu);
	if (n != nullptr) {
		*n = 1;
	}
	const eng::u32 d = cpu.cycles - before;
	return d != 0u ? static_cast<int>(d) : 1;
}
