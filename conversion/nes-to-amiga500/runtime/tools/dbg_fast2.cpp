// dbg_fast2.cpp — comparación en lockstep de dos sistemas NES completos:
// uno con el intérprete y otro con el ejecutor rápido (`FastCpu`), avanzando
// instrucción a instrucción con `NesSystem::step_instruction` (incluye PPU/NMI).
// Reporta la primera divergencia (CPU, RAM o PPU) con el opcode culpable.
//
// Uso: dbg_fast2 <rom.nes> [max_steps=3000000]

#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../include/nes_system.hpp"
#include "../host/fastcpu.hpp"
#include "../host/rom_loader.hpp"

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: dbg_fast2 <rom.nes> [max_steps]\n");
		return 1;
	}
	const int max_steps = (argc > 2) ? std::atoi(argv[2]) : 3000000;

	n2a::LoadedRom rom_i;
	n2a::LoadedRom rom_f;
	n2a::NesSystem si;
	n2a::NesSystem sf;
	if (!n2a::load_ines(argv[1], rom_i) || !n2a::load_ines(argv[1], rom_f)) {
		std::printf("error: no se pudo cargar\n");
		return 1;
	}
	si.load_mapper(rom_i.mapper);
	si.reset();
	sf.load_mapper(rom_f.mapper);
	sf.reset();

	n2a::FastCpu fast;
	{
		n2a::NESMemory probe;
		probe.prg = rom_f.mapper.prg;
		probe.prg_size = rom_f.mapper.prg_size;
		fast.build(rom_f.mapper.prg, rom_f.mapper.prg_size, probe.read16(0xFFFCu),
			   probe.read16(0xFFFAu), probe.read16(0xFFFEu));
	}
	sf.fast_ctx = &fast;
	sf.fast_step = &n2a::FastCpu::step;
	sf.fast_run = &n2a::FastCpu::run_block;

	eng::u32 cyc_i = 0;
	eng::u32 cyc_f = 0;
	for (int i = 0; i < max_steps;) {
		const eng::u16 pc = si.cpu.PC;
		const eng::u8 op = si.mem.read(pc);
		// El sistema rápido ejecuta un **bloque** (varias instrucciones); el
		// intérprete avanza exactamente el mismo número, una a una.
		int n = 0;
		const int cf = sf.step_block(&n);
		int ci = 0;
		for (int k = 0; k < n; ++k) {
			ci += si.step_instruction();
		}
		cyc_i += static_cast<eng::u32>(ci);
		cyc_f += static_cast<eng::u32>(cf);
		i += n;

		int ram_diff = 0;
		for (int a = 0; a < 0x800; ++a) {
			if (si.mem.ram[a] != sf.mem.ram[a]) {
				++ram_diff;
			}
		}
		const bool cpu_eq = si.cpu.A == sf.cpu.A && si.cpu.X == sf.cpu.X && si.cpu.Y == sf.cpu.Y &&
				    si.cpu.SP == sf.cpu.SP && si.cpu.PC == sf.cpu.PC &&
				    si.cpu.C == sf.cpu.C && si.cpu.Z == sf.cpu.Z && si.cpu.I == sf.cpu.I &&
				    si.cpu.D == sf.cpu.D && si.cpu.V == sf.cpu.V && si.cpu.N == sf.cpu.N;
		if (!cpu_eq || ram_diff != 0 || si.ppu.scanline != sf.ppu.scanline || cyc_i != cyc_f) {
			std::printf("DIVERGE en step %d: PC=%04X op=%02X cyc_i=%u cyc_f=%u\n", i, pc, op,
				    cyc_i, cyc_f);
			std::printf("  interp: PC=%04X A=%02X X=%02X Y=%02X SP=%02X scan=%u status=%02X\n",
				    si.cpu.PC, si.cpu.A, si.cpu.X, si.cpu.Y, si.cpu.SP, si.ppu.scanline,
				    si.ppu.status);
			std::printf("  rapido: PC=%04X A=%02X X=%02X Y=%02X SP=%02X scan=%u status=%02X ram_diff=%d\n",
				    sf.cpu.PC, sf.cpu.A, sf.cpu.X, sf.cpu.Y, sf.cpu.SP, sf.ppu.scanline,
				    sf.ppu.status, ram_diff);
			fast.destroy();
			return 2;
		}
	}
	std::printf("OK: %d pasos idénticos (incl. PPU)\n", max_steps);
	fast.destroy();
	return 0;
}
