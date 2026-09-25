// cycles_test — comprueba el conteo de ciclos por instrucción del intérprete.
//
// Coloca pequeñas secuencias en la RAM (la CPU puede ejecutar desde $0000-$07FF),
// ejecuta una instrucción y compara el número de ciclos con la tabla del 6502,
// incluyendo las penalizaciones por cruce de página en lecturas indexadas y por
// rama tomada.

#include <cstdio>

#include <eng/core/types/types.hpp>

#include "nes_interpreter.hpp"

namespace {

n2a::NESMemory g_mem;

/// Escribe `bytes` en `addr`.
void put(eng::u16 addr, eng::u8 value) { g_mem.write(addr, value); }

} // namespace

/// Ejecuta una instrucción en `pc` con una CPU nueva y devuelve sus ciclos.
template <class Setup>
int run_one(eng::u16 pc, Setup setup) {
	n2a::CPU cpu;
	cpu.mem = &g_mem;
	cpu.PC = pc;
	setup(cpu);
	n2a::Interpreter interp {cpu, g_mem};
	return interp.step();
}

int main() {
	int fail = 0;
	auto check = [&](const char* name, int got, int want) {
		if (got != want) {
			std::printf("  %s: %d ciclos (esperado %d)\n", name, got, want);
			++fail;
		}
	};

	// --- Cargas ---
	put(0x0400, 0xA9u); put(0x0401, 0x01u);              // LDA #$01
	check("LDA #", run_one(0x0400, [](n2a::CPU&) {}), 2);
	put(0x0402, 0xA5u); put(0x0403, 0x10u);              // LDA $10
	check("LDA zp", run_one(0x0402, [](n2a::CPU&) {}), 3);
	put(0x0404, 0xADu); put(0x0405, 0x34u); put(0x0406, 0x12u); // LDA $1234
	check("LDA abs", run_one(0x0404, [](n2a::CPU&) {}), 4);

	// LDA $02FF,X: sin cruce (X=0) → 4; con cruce (X=1) → 5.
	put(0x0407, 0xBDu); put(0x0408, 0xFFu); put(0x0409, 0x02u);
	check("LDA absX (sin cruce)", run_one(0x0407, [](n2a::CPU& c) { c.X = 0u; }), 4);
	check("LDA absX (cruce)", run_one(0x0407, [](n2a::CPU& c) { c.X = 1u; }), 5);

	// STA $02FF,X: las escrituras no penalizan cruce → 5.
	put(0x040A, 0x9Du); put(0x040B, 0xFFu); put(0x040C, 0x02u);
	check("STA absX (cruce)", run_one(0x040A, [](n2a::CPU& c) { c.X = 1u; }), 5);

	// --- RMW ---
	put(0x040D, 0xE6u); put(0x040E, 0x10u);              // INC $10
	check("INC zp", run_one(0x040D, [](n2a::CPU&) {}), 5);

	// --- Ramas ---
	put(0x040F, 0xD0u); put(0x0410, 0x00u);              // BNE +0
	check("BNE tomada", run_one(0x040F, [](n2a::CPU& c) { c.Z = false; }), 3);
	check("BNE no tomada", run_one(0x040F, [](n2a::CPU& c) { c.Z = true; }), 2);

	// --- Saltos / subrutinas ---
	put(0x0411, 0x4Cu); put(0x0412, 0x00u); put(0x0413, 0x04u); // JMP $0400
	check("JMP abs", run_one(0x0411, [](n2a::CPU&) {}), 3);
	put(0x0414, 0x20u); put(0x0415, 0x00u); put(0x0416, 0x04u); // JSR $0400
	check("JSR abs", run_one(0x0414, [](n2a::CPU&) {}), 6);
	put(0x0417, 0x60u);                                  // RTS
	check("RTS", run_one(0x0417, [](n2a::CPU&) {}), 6);
	put(0x0418, 0x00u);                                  // BRK
	check("BRK", run_one(0x0418, [](n2a::CPU&) {}), 7);

	// --- Pila ---
	put(0x0419, 0x48u);                                  // PHA
	check("PHA", run_one(0x0419, [](n2a::CPU&) {}), 3);
	put(0x041A, 0x68u);                                  // PLA
	check("PLA", run_one(0x041A, [](n2a::CPU&) {}), 4);

	if (fail == 0) {
		std::printf("Ciclos OK\n");
		return 0;
	}
	std::printf("Ciclos FALLO (%d)\n", fail);
	return 1;
}
