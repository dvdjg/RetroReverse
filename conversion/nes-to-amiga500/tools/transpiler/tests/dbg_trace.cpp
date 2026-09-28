// dbg_trace.cpp — Traza **codegen↔intérprete** (PC + registros + hash de RAM +
// estado del PPU) para localizar la primera divergencia. El generado con `--trace`
// llama a `N2A_TRACE(addr, cpu)` antes de cada instrucción; el intérprete usa
// `interp.trace`. Se ejecutan N frames en cada motor y se comparan las secuencias.

#include <cstdio>
#include <cstdlib>
#include <vector>

#include <eng/core/types/types.hpp>

#include "../../runtime/include/nes_runtime.hpp"

namespace {
struct Ev {
	unsigned pc, a, x, y, sp; ///< CPU.
	unsigned ram;             ///< hash FNV de RAM[0..0x800].
	unsigned vaddr, sx, sy, sl; ///< PPU: `v`, scroll x/y, line_scroll.
	unsigned mc, mc0, mc1, cb;  ///< Mapper: mmc1_ctrl/chr0/chr1, chr_bank.
};
std::vector<Ev> g_gen;
std::vector<Ev> g_ref;
std::vector<Ev>* g_cur = &g_ref;
bool g_rec = false;

void n2a_gen_trace(unsigned addr, const n2a::CPU& c); // definido tras los includes
} // namespace

#define N2A_TRACE(addr) n2a_gen_trace((addr), cpu)
#define N2A_NO_HOST_MAIN
#include "../generated/dbg_trace_game.cpp"

#include "../../runtime/fallback/nes_ppu.hpp"
#include "../../runtime/host/fastcpu.hpp"
#include "../../runtime/host/rom_loader.hpp"
#include "../../runtime/include/nes_system.hpp"

namespace {

n2a::LoadedRom g_rom;
n2a::Ppu* g_ppu = nullptr;
n2a::Mapper* g_mapper = nullptr; ///< Mapper del motor activo (estado CHR de MMC1).

/// Hash FNV-1a de la RAM interna.
unsigned ram_hash(const n2a::CPU& c) {
	unsigned h = 2166136261u;
	if (c.mem != nullptr) {
		for (unsigned i = 0; i < 0x800u; ++i) {
			h ^= c.mem->ram[i];
			h *= 16777619u;
		}
	}
	return h;
}

Ev make_ev(unsigned pc, const n2a::CPU& c) {
	Ev e;
	e.pc = pc;
	e.a = c.A;
	e.x = c.X;
	e.y = c.Y;
	e.sp = c.SP;
	e.ram = ram_hash(c);
	e.vaddr = g_ppu != nullptr ? g_ppu->v : 0u;
	e.sx = g_ppu != nullptr ? g_ppu->scroll_x : 0u;
	e.sy = g_ppu != nullptr ? g_ppu->scroll_y : 0u;
	e.sl = (g_ppu != nullptr && g_ppu->line_scroll) ? 1u : 0u;
	e.mc = g_mapper != nullptr ? g_mapper->mmc1_ctrl : 0u;
	e.mc0 = g_mapper != nullptr ? g_mapper->mmc1_chr0 : 0u;
	e.mc1 = g_mapper != nullptr ? g_mapper->mmc1_chr1 : 0u;
	e.cb = g_mapper != nullptr ? g_mapper->chr_bank : 0u;
	return e;
}

void n2a_gen_trace(unsigned addr, const n2a::CPU& c) {
	if (g_rec) {
		g_gen.push_back(make_ev(addr, c));
	}
}

void interp_hook(void* /*u*/, eng::u16 pc, eng::u8 /*op*/, const n2a::CPU& c) {
	if (g_rec) {
		g_cur->push_back(make_ev(pc, c));
	}
}

/// Ejecutor rápido del codegen (mismo despacho que `plugin_entry.cpp`).
int gen_run(void* /*ctx*/, n2a::CPU& cpu, n2a::NESMemory& mem, int /*budget*/, int* n) {
	const eng::u16 pc = cpu.PC;
	const eng::u8 bank = mem.prg_bank;
	if (kPrgModeSensitive && bank == static_cast<eng::u8>(0xFFu)) {
		if (n != nullptr) {
			*n = 0;
		}
		return 0;
	}
	BlockFn fn = nullptr;
	if (kPrgBanked && pc >= 0x8000u && pc < 0xC000u) {
		fn = n2a_banked_block(pc, bank, mem.prg_bank2, mem.prg_bank3);
	} else {
		fn = n2a_fixed_block(pc);
	}
	if (fn == nullptr) {
		if (n != nullptr) {
			*n = 0;
		}
		return 0;
	}
	const eng::u32 before = cpu.cycles;
	fn(cpu);
	if (n != nullptr) {
		*n = 1;
	}
	const eng::u32 d = cpu.cycles - before;
	return d != 0u ? static_cast<int>(d) : 1;
}

bool same(const Ev& a, const Ev& b) {
	return a.pc == b.pc && a.a == b.a && a.x == b.x && a.y == b.y && a.sp == b.sp &&
	       a.ram == b.ram && a.vaddr == b.vaddr && a.sx == b.sx && a.sy == b.sy &&
	       a.sl == b.sl && a.mc == b.mc && a.mc0 == b.mc0 && a.mc1 == b.mc1 && a.cb == b.cb;
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: dbg_trace <rom.nes> [frames]\n");
		return 1;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 1;
	if (!n2a::load_ines(argv[1], g_rom)) {
		std::printf("error: no se pudo cargar '%s'\n", argv[1]);
		return 1;
	}

	n2a::NesSystem ref;
	ref.load_mapper(g_rom.mapper);
	ref.reset();
	g_ppu = &ref.ppu;
	g_mapper = &ref.mapper;
	g_cur = &g_ref;
	ref.interp.trace = &interp_hook;
	g_ref.clear();
	g_rec = true;
	for (int i = 0; i < frames; ++i) {
		ref.run_frame();
	}
	g_rec = false;

	n2a::NesSystem gen;
	gen.load_mapper(g_rom.mapper);
	gen.reset();
	g_ppu = &gen.ppu;
	g_mapper = &gen.mapper;
	gen.fast_run = &gen_run;
	gen.fast_ticks = true; // el codegen reloja la PPU por acceso
	g_cur = &g_gen;
	gen.interp.trace = &interp_hook;
	g_gen.clear();
	g_rec = true;
	for (int i = 0; i < frames; ++i) {
		gen.run_frame();
	}
	g_rec = false;

	std::printf("trazas: ref=%zu gen=%zu instrucciones\n", g_ref.size(), g_gen.size());
	const size_t n = g_ref.size() < g_gen.size() ? g_ref.size() : g_gen.size();
	size_t bad = n;
	for (size_t i = 0; i < n; ++i) {
		if (!same(g_ref[i], g_gen[i])) {
			bad = i;
			break;
		}
	}
	if (bad == n) {
		std::printf("SIN divergencia en %zu instrucciones\n", n);
		return 0;
	}
	std::printf("PRIMERA divergencia en idx %zu:\n", bad);
	const size_t lo = bad > 4u ? bad - 4u : 0u;
	for (size_t i = lo; i < bad + 4u && i < n; ++i) {
		const Ev& a = g_ref[i];
		const Ev& b = g_gen[i];
		std::printf("  [%zu] ref $%04X A=%02X X=%02X Y=%02X S=%02X R=%08X v=%04X sc=%02X/%02X ls=%u mm=%02X c0=%02X c1=%02X cb=%02X\n",
			    i, a.pc, a.a, a.x, a.y, a.sp, a.ram, a.vaddr, a.sx, a.sy, a.sl, a.mc, a.mc0,
			    a.mc1, a.cb);
		std::printf("       gen $%04X A=%02X X=%02X Y=%02X S=%02X R=%08X v=%04X sc=%02X/%02X ls=%u mm=%02X c0=%02X c1=%02X cb=%02X%s\n",
			    b.pc, b.a, b.x, b.y, b.sp, b.ram, b.vaddr, b.sx, b.sy, b.sl, b.mc, b.mc0,
			    b.mc1, b.cb, same(a, b) ? "" : "  <--");
	}
	return 0;
}
