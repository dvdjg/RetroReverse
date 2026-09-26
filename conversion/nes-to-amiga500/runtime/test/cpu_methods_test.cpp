// cpu_methods_test.cpp — **auditoría semántica** de los métodos de `CPU` que usa
// el código generado (wrappers de direccionamiento, RMW ilegales, RTI/BRK)
// frente al intérprete de referencia.
//
// Para cada caso se ejecuta la misma instrucción de dos formas sobre un estado
// idéntico: con `Interpreter::step()` y llamando al método de `CPU` que emite el
// transpilador; se comparan registros, flags, `SP` y RAM. Caza discrepancias como
// las halladas en RTI (flags) y BRK (vector IRQ).
//
// Nota: no compara `PC` en las instrucciones no de control (el método no adelanta
// el PC; el intérprete sí). Sí lo compara en RTI/BRK.

#include <cstdio>

#include "nes_interpreter.hpp"

namespace {

eng::u8 g_prg[0x4000];

struct Init {
	eng::u8 a = 0;
	eng::u8 x = 0;
	eng::u8 y = 0;
	eng::u8 sp = 0xFD;
	int c = 0;
	int z = 0;
	int i = 0;
	int d = 0;
	int v = 0;
	int n = 0;
};

/// Carga `prog` al inicio de la PRG (dirección $8000) y rellena el resto a 0.
void load_prog(const eng::u8* prog, eng::usize n) {
	for (eng::usize k = 0; k < sizeof g_prg; ++k) {
		g_prg[k] = 0u;
	}
	for (eng::usize k = 0; k < n; ++k) {
		g_prg[k] = prog[k];
	}
}

bool regs_eq(const n2a::CPU& p, const n2a::CPU& q, bool with_pc) {
	if (p.A != q.A || p.X != q.X || p.Y != q.Y || p.SP != q.SP || p.C != q.C || p.Z != q.Z ||
	    p.I != q.I || p.D != q.D || p.V != q.V || p.N != q.N) {
		return false;
	}
	return !with_pc || p.PC == q.PC;
}

/// Ejecuta un caso: compara intérprete vs `method` sobre estado idéntico.
/// \param ram0 RAM inicial (512 B) o `nullptr`.
/// \param with_pc Comparar también `PC` (RTI/BRK).
template <class F>
int run_case(const char* name, const eng::u8* prog, eng::usize n, const Init& in,
	     const eng::u8* ram0, bool with_pc, F method) {
	load_prog(prog, n);
	n2a::NESMemory base {};
	base.prg = g_prg;
	base.prg_size = 0x4000u;
	if (ram0 != nullptr) {
		for (eng::usize k = 0; k < 0x800u; ++k) {
			base.ram[k] = ram0[k];
		}
	}
	n2a::CPU c0 {};
	c0.mem = &base;
	c0.PC = 0x8000u;
	c0.A = in.a;
	c0.X = in.x;
	c0.Y = in.y;
	c0.SP = in.sp;
	c0.C = in.c != 0;
	c0.Z = in.z != 0;
	c0.I = in.i != 0;
	c0.D = in.d != 0;
	c0.V = in.v != 0;
	c0.N = in.n != 0;

	n2a::NESMemory mi = base;
	n2a::CPU ci = c0;
	ci.mem = &mi;
	n2a::Interpreter it(ci, mi);
	it.step();

	n2a::NESMemory mm = base;
	n2a::CPU cm = c0;
	cm.mem = &mm;
	method(cm);

	bool ok = regs_eq(ci, cm, with_pc);
	for (eng::usize k = 0; k < 0x800u && ok; ++k) {
		if (mi.ram[k] != mm.ram[k]) {
			ok = false;
		}
	}
	if (!ok) {
		std::printf("  FALLO %-10s interp(A=%02X X=%02X Y=%02X SP=%02X C%dZ%dI%dD%dV%dN%d) "
			    "metodo(A=%02X X=%02X Y=%02X SP=%02X C%dZ%dI%dD%dV%dN%d)\n",
			    name, ci.A, ci.X, ci.Y, ci.SP, ci.C, ci.Z, ci.I, ci.D, ci.V, ci.N, cm.A,
			    cm.X, cm.Y, cm.SP, cm.C, cm.Z, cm.I, cm.D, cm.V, cm.N);
	}
	return ok ? 0 : 1;
}

} // namespace

int main() {
	int fails = 0;
	eng::u8 ram0[0x800] = {};
	auto set = [&](eng::u16 addr, eng::u8 v) { ram0[addr & 0x7FFu] = v; };

	// LDA abs,X sin cruce y con cruce.
	set(0x0015u, 0x37u);
	set(0x0110u, 0x42u);
	fails += run_case("LDA_absx", (const eng::u8[]){0xBD, 0x10, 0x00}, 3, Init {.x = 0x05}, ram0,
			  false, [](n2a::CPU& c) { c.LDA_absx(0x0010u); });
	fails += run_case("LDA_absx+pg", (const eng::u8[]){0xBD, 0xF0, 0x00}, 3, Init {.x = 0x20}, ram0,
			  false, [](n2a::CPU& c) { c.LDA_absx(0x00F0u); });
	// STA abs,Y con cruce.
	fails += run_case("STA_absy+pg", (const eng::u8[]){0x99, 0xF0, 0x00}, 3,
			  Init {.a = 0xAB, .y = 0x20}, ram0, false,
			  [](n2a::CPU& c) { c.STA_absy(0x00F0u); });
	// LDA (zp),Y con cruce.
	set(0x0020u, 0xF0u);
	set(0x0021u, 0x00u);
	set(0x0110u, 0x99u);
	fails += run_case("LDA_indy+pg", (const eng::u8[]){0xB1, 0x20}, 2, Init {.y = 0x20}, ram0, false,
			  [](n2a::CPU& c) { c.LDA_indy(0x20u); });
	// LDA (zp,X).
	set(0x0025u, 0x10u);
	set(0x0026u, 0x00u);
	set(0x0010u, 0x55u);
	fails += run_case("LDA_indx", (const eng::u8[]){0xA1, 0x20}, 2, Init {.x = 0x05}, ram0, false,
			  [](n2a::CPU& c) { c.LDA_indx(0x20u); });
	// LDA zp,X con vuelta de página cero.
	set(0x0010u, 0x66u);
	fails += run_case("LDA_zpx", (const eng::u8[]){0xB5, 0xF0}, 2, Init {.x = 0x20}, ram0, false,
			  [](n2a::CPU& c) { c.LDA_zpx(0xF0u); });
	// ADC abs,X con acarreo y cruce.
	set(0x0110u, 0x01u);
	fails += run_case("ADC_absx+pg", (const eng::u8[]){0x7D, 0xF0, 0x00}, 3,
			  Init {.a = 0x7F, .x = 0x20, .c = 1}, ram0, false,
			  [](n2a::CPU& c) { c.ADC_absx(0x00F0u); });
	// Ilegales.
	set(0x0110u, 0xC0u);
	fails += run_case("LAX_absy", (const eng::u8[]){0xBF, 0xF0, 0x00}, 3, Init {.y = 0x20}, ram0,
			  false, [](n2a::CPU& c) { c.LAX_absy(0x00F0u); });
	set(0x0200u, 0x00u);
	fails += run_case("SAX_abs", (const eng::u8[]){0x8F, 0x00, 0x02}, 3,
			  Init {.a = 0xAA, .x = 0x0Fu}, ram0, false,
			  [](n2a::CPU& c) { c.SAX_abs(0x0200u); });
	set(0x0010u, 0x05u);
	fails += run_case("DCP_zp", (const eng::u8[]){0xC7, 0x10}, 2, Init {.a = 0x04}, ram0, false,
			  [](n2a::CPU& c) { c.DCP_zp(0x10u); });
	set(0x0015u, 0x02u);
	fails += run_case("ISB_zpx", (const eng::u8[]){0xF7, 0x10}, 2, Init {.a = 0x05, .x = 0x05},
			  ram0, false, [](n2a::CPU& c) { c.ISB_zpx(0x10u); });
	set(0x0025u, 0x81u);
	set(0x0026u, 0x00u);
	set(0x0081u, 0x40u);
	fails += run_case("SLO_izx", (const eng::u8[]){0x03, 0x20}, 2, Init {.a = 0x0F, .x = 0x05},
			  ram0, false, [](n2a::CPU& c) { c.SLO_indx(0x20u); });
	set(0x0200u, 0x81u);
	fails += run_case("RLA_abs", (const eng::u8[]){0x2F, 0x00, 0x02}, 3, Init {.c = 1}, ram0, false,
			  [](n2a::CPU& c) { c.RLA_abs(0x0200u); });
	set(0x0020u, 0x00u);
	set(0x0021u, 0x02u);
	set(0x0200u, 0x81u);
	fails += run_case("SRE_indy", (const eng::u8[]){0x53, 0x20}, 2, Init {.a = 0x0F}, ram0, false,
			  [](n2a::CPU& c) { c.SRE_indy(0x20u); });
	set(0x0010u, 0x81u);
	fails += run_case("RRA_zp", (const eng::u8[]){0x67, 0x10}, 2, Init {.a = 0x10}, ram0, false,
			  [](n2a::CPU& c) { c.RRA_zp(0x10u); });

	// RTI: pila con estado y dirección de retorno.
	{
		eng::u8 ram[0x800] = {};
		ram[0x01FCu] = 0xC3u; // estado (N|Z|C|U|B)
		ram[0x01FDu] = 0x34u; // retorno bajo
		ram[0x01FEu] = 0x12u; // retorno alto
		fails += run_case("RTI", (const eng::u8[]){0x40}, 1, Init {.sp = 0xFB}, ram, true,
				  [](n2a::CPU& c) { c.RTI(); });
	}
	// BRK: vector IRQ ($FFFE) = $C000.
	{
		load_prog((const eng::u8[]){0x00}, 1);
		g_prg[0x3FFEu] = 0x00u;
		g_prg[0x3FFFu] = 0xC0u;
		n2a::NESMemory base {};
		base.prg = g_prg;
		base.prg_size = 0x4000u;
		n2a::CPU c0 {};
		c0.mem = &base;
		c0.PC = 0x8000u;
		c0.SP = 0xFDu;
		n2a::NESMemory mi = base;
		n2a::CPU ci = c0;
		ci.mem = &mi;
		n2a::Interpreter it(ci, mi);
		it.step();
		n2a::NESMemory mm = base;
		n2a::CPU cm = c0;
		cm.mem = &mm;
		cm.brk_halts = false;
		cm.BRK();
		bool ok = regs_eq(ci, cm, true) && ci.PC == 0xC000u;
		for (eng::usize k = 0; k < 0x800u && ok; ++k) {
			if (mi.ram[k] != mm.ram[k]) {
				ok = false;
			}
		}
		if (!ok) {
			std::printf("  FALLO BRK interp(PC=%04X SP=%02X I%d) metodo(PC=%04X SP=%02X I%d)\n",
				    ci.PC, ci.SP, ci.I, cm.PC, cm.SP, cm.I);
			++fails;
		}
	}

	if (fails == 0) {
		std::printf("CPU metodos OK (intérprete == metodos del codegen)\n");
	}
	return fails == 0 ? 0 : 1;
}
