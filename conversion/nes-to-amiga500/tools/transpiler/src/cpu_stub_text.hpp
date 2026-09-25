#pragma once

/// \file cpu_stub_text.hpp
/// Texto del **runtime provisional** que el transpilador escribe en el fichero
/// generado: `NESMemory` + `CPU` en C++23 sobre `eng/core` y sin STL.
///
/// Es un *stub*: la semantica de algunas operaciones es simplificada y el estado
/// intencionalmente incompleto (PPU/APU/mappers). Su unico proposito ahora es que
/// el codigo generado **compile y ejecute** en host (y en 68000), y servir de
/// punto de enganche hasta que exista el runtime real del nodo
/// [`runtime/`](../../../runtime/README.md) (fases F3/F4 del roadmap).
///
/// El generador emite antes de este texto `PRG_ROM` y `kPrgSize`.
///
/// Siguiendo la regla de codigo autodocumentado de `AGENTS.md`, **este texto
/// emitido documenta clases, miembros, metodos, argumentos, retornos y macros**.

namespace n2a {

inline constexpr const char* kCpuStubText = R"N2ASTUB(
// ============================================================
//  Runtime provisional (stub) - sustituir por el runtime del nodo
//  Contexto: lo usan los basic blocks generados (bb_XXXX) y game_main().
//  Recursos: solo RAM interna y PRG_ROM; sin heap ni STL.
// ============================================================

/// Memoria de la consola para el stub: RAM interna y lectura de la PRG-ROM.
/// No modela PPU/APU/mapper (llegan con el runtime real).
struct NESMemory {
	/// RAM interna de 2 KB ($0000-$07FF), espejada hasta $1FFF por `read`.
	eng::u8 ram[0x800] {};

	/// Lee un byte del espacio de direcciones de la CPU.
	/// - addr $0000-$1FFF: RAM espejada (`addr & 0x7FF`).
	/// - addr $8000-$FFFF: PRG-ROM (con espejo de 16 KB si `kPrgSize == 16384`).
	/// - resto: 0 (PPU/APU/mapper no modelados).
	/// Retorno: el byte leido. Sin efectos secundarios.
	eng::u8 read(eng::u16 addr) const {
		if (addr < 0x2000u) {
			return ram[addr & 0x7FFu];
		}
		if (addr >= 0x8000u) {
			eng::usize off = static_cast<eng::usize>(addr - 0x8000u);
			if (kPrgSize == 16384u) {
				off &= 0x3FFFu;
			}
			if (off < kPrgSize) {
				return PRG_ROM[off];
			}
		}
		return 0u;
	}

	/// Escribe un byte. Solo persiste en la RAM interna ($0000-$1FFF, espejada);
	/// las demas direcciones se ignoran (PPU/APU/mapper no modelados).
	/// Argumentos: addr destino, value byte a escribir. Sin retorno.
	void write(eng::u16 addr, eng::u8 value) {
		if (addr < 0x2000u) {
			ram[addr & 0x7FFu] = value;
		}
	}

	/// Lee una palabra de 16 bits en formato little-endian (lo/hi).
	/// Uso: operandos absolutos e indirecciones (p. ej. `JMP ($xxyy)`).
	/// Retorno: `read(addr) | (read(addr+1) << 8)`.
	eng::u16 read16(eng::u16 addr) const {
		return static_cast<eng::u16>(read(addr) |
			       (static_cast<eng::u16>(read(static_cast<eng::u16>(addr + 1u))) << 8));
	}
};

/// CPU 6502 del stub. Implementa los registros, flags y metodos usados por el
/// codigo generado. Convencion: los metodos se llaman como el mnemonico + sufijo
/// de modo (`LDA_abs`, `STA_zp`, `ADC_imm`, `ASL_A`...), de forma que el codigo
/// generado se lea como el desensamblador y sea facil de reconocer por la capa HLE.
struct CPU {
	/// Acumulador (8 bits).
	eng::u8 A = 0;
	/// Registro indice X (8 bits).
	eng::u8 X = 0;
	/// Registro indice Y (8 bits).
	eng::u8 Y = 0;
	/// Puntero de pila (offset dentro de la pagina $0100). Arranca en $FD.
	eng::u8 SP = 0xFD;
	/// Contador de programa: direccion 6502 de la instruccion/bloque actual.
	eng::u16 PC = 0;
	/// Flags: carry, zero, irq-disable, decimal, overflow, negativo.
	bool C = false, Z = false, I = false, D = false, V = false, N = false;
	/// `true` tras `BRK`; `game_main()` lo usa para terminar el bucle de despacho.
	bool halted = false;
	/// Memoria asociada (no propietario). La fija `game_main()`.
	NESMemory* mem = nullptr;

	/// Actualiza los flags Z (resultado == 0) y N (bit 7) a partir de `v`.
	/// Usado por todas las operaciones que cargan/transforman A, X o Y.
	void set_nz(eng::u8 v) { Z = (v == 0u); N = (v & 0x80u) != 0u; }
	/// Apila un byte en la pila de la pagina $0100 y decrementa SP.
	void push(eng::u8 v) { mem->ram[0x100u + static_cast<eng::usize>(SP)] = v; --SP; }
	/// Desapila un byte (incrementa SP) y lo devuelve.
	eng::u8 pull() { ++SP; return mem->ram[0x100u + static_cast<eng::usize>(SP)]; }
	/// Apila una palabra (primero el byte alto, luego el bajo), como JSR/BRK.
	void push16(eng::u16 v) { push(static_cast<eng::u8>(v >> 8u)); push(static_cast<eng::u8>(v & 0xFFu)); }
	/// Desapila una palabra little-endian (lo primero) y la devuelve.
	eng::u16 pull16() { const eng::u8 lo = pull(); const eng::u8 hi = pull(); return static_cast<eng::u16>(lo | (static_cast<eng::u16>(hi) << 8)); }

	// --- Cargas: LDA/LDX/LDY ---
	// El macro genera, por cada registro R (A/X/Y), un metodo por modo de
	// direccionamiento. Cada metodo lee el operando efectivo, lo carga en R y
	// actualiza N/Z. Modos: imm, zp, zpx, zpy, abs, absx, absy, indx, indy.
	// (X/Y no usan todos los modos, pero los metodos sobrantes no se emiten si
	//  el opcode no aparece en la ROM.)
#define N2A_LOAD(NAME, R) \
	void NAME##_imm(eng::u8 v) { R = v; set_nz(R); } \
	void NAME##_zp(eng::u8 a) { R = mem->read(a); set_nz(R); } \
	void NAME##_zpx(eng::u8 a) { R = mem->read(static_cast<eng::u8>(a + X)); set_nz(R); } \
	void NAME##_zpy(eng::u8 a) { R = mem->read(static_cast<eng::u8>(a + Y)); set_nz(R); } \
	void NAME##_abs(eng::u16 a) { R = mem->read(a); set_nz(R); } \
	void NAME##_absx(eng::u16 a) { R = mem->read(static_cast<eng::u16>(a + X)); set_nz(R); } \
	void NAME##_absy(eng::u16 a) { R = mem->read(static_cast<eng::u16>(a + Y)); set_nz(R); } \
	void NAME##_indx(eng::u8 a) { R = mem->read(mem->read16(static_cast<eng::u8>(a + X))); set_nz(R); } \
	void NAME##_indy(eng::u8 a) { R = mem->read(static_cast<eng::u16>(mem->read16(a) + Y)); set_nz(R); }
	N2A_LOAD(LDA, A)
	N2A_LOAD(LDX, X)
	N2A_LOAD(LDY, Y)
#undef N2A_LOAD

	// --- Almacenes: STA/STX/STY ---
	// Genera un metodo por registro R y modo: escribe R en la direccion efectiva.
	// No modifican flags. Modos: zp, zpx, zpy, abs, absx, absy, indx, indy.
#define N2A_STORE(NAME, R) \
	void NAME##_zp(eng::u8 a) { mem->write(a, R); } \
	void NAME##_zpx(eng::u8 a) { mem->write(static_cast<eng::u8>(a + X), R); } \
	void NAME##_zpy(eng::u8 a) { mem->write(static_cast<eng::u8>(a + Y), R); } \
	void NAME##_abs(eng::u16 a) { mem->write(a, R); } \
	void NAME##_absx(eng::u16 a) { mem->write(static_cast<eng::u16>(a + X), R); } \
	void NAME##_absy(eng::u16 a) { mem->write(static_cast<eng::u16>(a + Y), R); } \
	void NAME##_indx(eng::u8 a) { mem->write(mem->read16(static_cast<eng::u8>(a + X)), R); } \
	void NAME##_indy(eng::u8 a) { mem->write(static_cast<eng::u16>(mem->read16(a) + Y), R); }
	N2A_STORE(STA, A)
	N2A_STORE(STX, X)
	N2A_STORE(STY, Y)
#undef N2A_STORE

	// --- ALU interna ---
	/// Suma con acarreo: A = A + v + C. Actualiza C, V, N, Z.
	void ADC_impl(eng::u8 v) {
		const eng::u16 s = static_cast<eng::u16>(A + v + (C ? 1u : 0u));
		C = (s > 0xFFu);
		const eng::u8 r = static_cast<eng::u8>(s);
		V = (((A ^ r) & (v ^ r) & 0x80u) != 0u);
		A = r;
		set_nz(A);
	}
	/// Resta con borrow: A = A - v - (1-C). Actualiza C, V, N, Z.
	void SBC_impl(eng::u8 v) {
		const eng::u8 nv = static_cast<eng::u8>(~v);
		const eng::u16 s = static_cast<eng::u16>(A + nv + (C ? 1u : 0u));
		C = (s > 0xFFu);
		const eng::u8 r = static_cast<eng::u8>(s);
		V = (((A ^ r) & (nv ^ r) & 0x80u) != 0u);
		A = r;
		set_nz(A);
	}
	/// AND logico de A con v; actualiza N/Z.
	void AND_impl(eng::u8 v) { A = static_cast<eng::u8>(A & v); set_nz(A); }
	/// OR logico de A con v; actualiza N/Z.
	void ORA_impl(eng::u8 v) { A = static_cast<eng::u8>(A | v); set_nz(A); }
	/// XOR logico de A con v; actualiza N/Z.
	void EOR_impl(eng::u8 v) { A = static_cast<eng::u8>(A ^ v); set_nz(A); }
	/// Compara `reg` con `v` (resta sin guardar) y actualiza C, Z, N.
	/// Argumentos: reg valor del registro (A/X/Y); v operando.
	void CMP_impl(eng::u8 reg, eng::u8 v) {
		const eng::u8 r = static_cast<eng::u8>(reg - v);
		C = (reg >= v);
		Z = (r == 0u);
		N = (r & 0x80u) != 0u;
	}
	// Genera un metodo por modo de direccionamiento para una operacion ALU IMPL.
	// IMPL es un metodo interno (ADC_impl, SBC_impl, AND_impl, ORA_impl, EOR_impl).
#define N2A_ALU(NAME, IMPL) \
	void NAME##_imm(eng::u8 v) { IMPL(v); } \
	void NAME##_zp(eng::u8 a) { IMPL(mem->read(a)); } \
	void NAME##_zpx(eng::u8 a) { IMPL(mem->read(static_cast<eng::u8>(a + X))); } \
	void NAME##_zpy(eng::u8 a) { IMPL(mem->read(static_cast<eng::u8>(a + Y))); } \
	void NAME##_abs(eng::u16 a) { IMPL(mem->read(a)); } \
	void NAME##_absx(eng::u16 a) { IMPL(mem->read(static_cast<eng::u16>(a + X))); } \
	void NAME##_absy(eng::u16 a) { IMPL(mem->read(static_cast<eng::u16>(a + Y))); } \
	void NAME##_indx(eng::u8 a) { IMPL(mem->read(mem->read16(static_cast<eng::u8>(a + X)))); } \
	void NAME##_indy(eng::u8 a) { IMPL(mem->read(static_cast<eng::u16>(mem->read16(a) + Y))); }
	N2A_ALU(ADC, ADC_impl)
	N2A_ALU(SBC, SBC_impl)
	N2A_ALU(AND, AND_impl)
	N2A_ALU(ORA, ORA_impl)
	N2A_ALU(EOR, EOR_impl)
#undef N2A_ALU
	// Comparaciones: un metodo por modo que compara el registro R con el operando.
#define N2A_CMP(NAME, R) \
	void NAME##_imm(eng::u8 v) { CMP_impl(R, v); } \
	void NAME##_zp(eng::u8 a) { CMP_impl(R, mem->read(a)); } \
	void NAME##_zpx(eng::u8 a) { CMP_impl(R, mem->read(static_cast<eng::u8>(a + X))); } \
	void NAME##_zpy(eng::u8 a) { CMP_impl(R, mem->read(static_cast<eng::u8>(a + Y))); } \
	void NAME##_abs(eng::u16 a) { CMP_impl(R, mem->read(a)); } \
	void NAME##_absx(eng::u16 a) { CMP_impl(R, mem->read(static_cast<eng::u16>(a + X))); } \
	void NAME##_absy(eng::u16 a) { CMP_impl(R, mem->read(static_cast<eng::u16>(a + Y))); } \
	void NAME##_indx(eng::u8 a) { CMP_impl(R, mem->read(mem->read16(static_cast<eng::u8>(a + X)))); } \
	void NAME##_indy(eng::u8 a) { CMP_impl(R, mem->read(static_cast<eng::u16>(mem->read16(a) + Y))); }
	N2A_CMP(CMP, A)
	N2A_CMP(CPX, X)
	N2A_CMP(CPY, Y)
#undef N2A_CMP

	// --- Desplazamientos ---
	/// ASL del acumulador: C = bit 7, A <<= 1.
	void ASL_A() { C = (A & 0x80u) != 0u; A = static_cast<eng::u8>(A << 1u); set_nz(A); }
	/// LSR del acumulador: C = bit 0, A >>= 1.
	void LSR_A() { C = (A & 1u) != 0u; A = static_cast<eng::u8>(A >> 1u); set_nz(A); }
	/// ROL del acumulador con el carry entrante.
	void ROL_A() { const eng::u8 c = C ? 1u : 0u; C = (A & 0x80u) != 0u; A = static_cast<eng::u8>((A << 1u) | c); set_nz(A); }
	/// ROR del acumulador con el carry entrante.
	void ROR_A() { const eng::u8 c = C ? 1u : 0u; C = (A & 1u) != 0u; A = static_cast<eng::u8>((A >> 1u) | (c << 7u)); set_nz(A); }
	/// Desplazamientos sobre memoria en la direccion `a` (leer, desplazar, escribir).
	void ASL_at(eng::u16 a) { eng::u8 v = mem->read(a); C = (v & 0x80u) != 0u; v = static_cast<eng::u8>(v << 1u); mem->write(a, v); set_nz(v); }
	void LSR_at(eng::u16 a) { eng::u8 v = mem->read(a); C = (v & 1u) != 0u; v = static_cast<eng::u8>(v >> 1u); mem->write(a, v); set_nz(v); }
	void ROL_at(eng::u16 a) { eng::u8 v = mem->read(a); const eng::u8 c = C ? 1u : 0u; C = (v & 0x80u) != 0u; v = static_cast<eng::u8>((v << 1u) | c); mem->write(a, v); set_nz(v); }
	void ROR_at(eng::u16 a) { eng::u8 v = mem->read(a); const eng::u8 c = C ? 1u : 0u; C = (v & 1u) != 0u; v = static_cast<eng::u8>((v >> 1u) | (c << 7u)); mem->write(a, v); set_nz(v); }
	// Genera, para un desplazamiento NAME, los modos zp/zpx/abs/absx que operan
	// sobre memoria llamando a NAME_at(direccion).
#define N2A_SHIFT_MODES(NAME) \
	void NAME##_zp(eng::u8 a) { NAME##_at(a); } \
	void NAME##_zpx(eng::u8 a) { NAME##_at(static_cast<eng::u8>(a + X)); } \
	void NAME##_abs(eng::u16 a) { NAME##_at(a); } \
	void NAME##_absx(eng::u16 a) { NAME##_at(static_cast<eng::u16>(a + X)); }
	N2A_SHIFT_MODES(ASL)
	N2A_SHIFT_MODES(LSR)
	N2A_SHIFT_MODES(ROL)
	N2A_SHIFT_MODES(ROR)
#undef N2A_SHIFT_MODES

	// --- Inc / Dec en memoria ---
	/// Incrementa el byte en `a` y actualiza N/Z.
	void INC_at(eng::u16 a) { const eng::u8 v = static_cast<eng::u8>(mem->read(a) + 1u); mem->write(a, v); set_nz(v); }
	/// Decrementa el byte en `a` y actualiza N/Z.
	void DEC_at(eng::u16 a) { const eng::u8 v = static_cast<eng::u8>(mem->read(a) - 1u); mem->write(a, v); set_nz(v); }
	// Genera los modos zp/zpx/abs/absx de INC/DEC sobre memoria.
#define N2A_MEM_MODES(NAME) \
	void NAME##_zp(eng::u8 a) { NAME##_at(a); } \
	void NAME##_zpx(eng::u8 a) { NAME##_at(static_cast<eng::u8>(a + X)); } \
	void NAME##_abs(eng::u16 a) { NAME##_at(a); } \
	void NAME##_absx(eng::u16 a) { NAME##_at(static_cast<eng::u16>(a + X)); }
	N2A_MEM_MODES(INC)
	N2A_MEM_MODES(DEC)
#undef N2A_MEM_MODES

	/// Incrementa X y actualiza N/Z.
	void INX() { ++X; set_nz(X); }
	/// Incrementa Y y actualiza N/Z.
	void INY() { ++Y; set_nz(Y); }
	/// Decrementa X y actualiza N/Z.
	void DEX() { --X; set_nz(X); }
	/// Decrementa Y y actualiza N/Z.
	void DEY() { --Y; set_nz(Y); }

	/// Transfiere A a X (actualiza N/Z).
	void TAX() { X = A; set_nz(X); }
	/// Transfiere A a Y (actualiza N/Z).
	void TAY() { Y = A; set_nz(Y); }
	/// Transfiere X a A (actualiza N/Z).
	void TXA() { A = X; set_nz(A); }
	/// Transfiere Y a A (actualiza N/Z).
	void TYA() { A = Y; set_nz(A); }
	/// Transfiere SP a X (actualiza N/Z).
	void TSX() { X = SP; set_nz(X); }
	/// Transfiere X a SP (no modifica flags).
	void TXS() { SP = X; }

	/// Apila A.
	void PHA() { push(A); }
	/// Desapila A (actualiza N/Z).
	void PLA() { A = pull(); set_nz(A); }
	/// Apila el byte de flags (con B y bit 5 a 1).
	void PHP() { push(static_cast<eng::u8>(0x20u | (N ? 0x80u : 0u) | (V ? 0x40u : 0u) | (D ? 0x08u : 0u) | (I ? 0x04u : 0u) | (Z ? 0x02u : 0u) | (C ? 0x01u : 0u))); }
	/// Desapila el byte de flags y restaura N/V/D/I/Z/C.
	void PLP() { const eng::u8 p = pull(); N = (p & 0x80u) != 0u; V = (p & 0x40u) != 0u; D = (p & 0x08u) != 0u; I = (p & 0x04u) != 0u; Z = (p & 0x02u) != 0u; C = (p & 0x01u) != 0u; }

	/// Limpia carry. /// Pone carry. /// Limpia/pone IRQ-disable. /// Limpia overflow. /// Limpia/pone decimal.
	void CLC() { C = false; }
	void SEC() { C = true; }
	void CLI() { I = false; }
	void SEI() { I = true; }
	void CLV() { V = false; }
	void CLD() { D = false; }
	void SED() { D = true; }

	/// JMP absoluto: fija PC a `t`. El dispatcher ejecutara el bloque de `t`.
	void JMP_abs(eng::u16 t) { PC = t; }
	/// JMP indirecto: lee la direccion destino en `a` (little-endian) y la pone en PC.
	void JMP_ind(eng::u16 a) { PC = mem->read16(a); }
	/// Llamada a subrutina: apila la direccion de regreso `ret` y salta a `t`.
	void JSR_abs(eng::u16 t, eng::u16 ret) { push16(ret); PC = t; }
	/// Retorno de subrutina: recupera PC de la pila.
	void RTS() { PC = pull16(); }
	/// Retorno de interrupcion: descarta el byte de flags y recupera PC.
	void RTI() { (void)pull(); PC = pull16(); }
	/// Interrupcion por software: detiene la ejecucion y deja PC=0 (fin del bucle).
	void BRK() { halted = true; PC = 0u; }

	/// BIT (zero page): Z = (A & v)==0; N = bit 7 de v; V = bit 6 de v.
	void BIT_zp(eng::u8 a) { const eng::u8 v = mem->read(a); Z = (A & v) == 0u; N = (v & 0x80u) != 0u; V = (v & 0x40u) != 0u; }
	/// BIT (absoluto): idem con direccion de 16 bits.
	void BIT_abs(eng::u16 a) { const eng::u8 v = mem->read(a); Z = (A & v) == 0u; N = (v & 0x80u) != 0u; V = (v & 0x40u) != 0u; }

	/// NOP y variantes (los modos ignoran el operando).
	void NOP() {}
	void NOP_imm(eng::u8) {}
	void NOP_zp(eng::u8) {}
	void NOP_zpx(eng::u8) {}
	void NOP_abs(eng::u16) {}
	void NOP_absx(eng::u16) {}

	// --- No oficiales (aproximados) ---
	// LAX: carga A y X con el mismo valor leido.
#define N2A_LAX(NAME) \
	void NAME##_zp(eng::u8 a) { A = X = mem->read(a); set_nz(A); } \
	void NAME##_zpy(eng::u8 a) { A = X = mem->read(static_cast<eng::u8>(a + Y)); set_nz(A); } \
	void NAME##_abs(eng::u16 a) { A = X = mem->read(a); set_nz(A); } \
	void NAME##_absy(eng::u16 a) { A = X = mem->read(static_cast<eng::u16>(a + Y)); set_nz(A); } \
	void NAME##_indx(eng::u8 a) { A = X = mem->read(mem->read16(static_cast<eng::u8>(a + X))); set_nz(A); } \
	void NAME##_indy(eng::u8 a) { A = X = mem->read(static_cast<eng::u16>(mem->read16(a) + Y)); set_nz(A); }
	N2A_LAX(LAX)
#undef N2A_LAX
	// SAX: guarda (A & X) en memoria.
#define N2A_SAX(NAME) \
	void NAME##_zp(eng::u8 a) { mem->write(a, static_cast<eng::u8>(A & X)); } \
	void NAME##_zpy(eng::u8 a) { mem->write(static_cast<eng::u8>(a + Y), static_cast<eng::u8>(A & X)); } \
	void NAME##_abs(eng::u16 a) { mem->write(a, static_cast<eng::u8>(A & X)); } \
	void NAME##_indx(eng::u8 a) { mem->write(mem->read16(static_cast<eng::u8>(a + X)), static_cast<eng::u8>(A & X)); }
	N2A_SAX(SAX)
#undef N2A_SAX
	/// DCP: decrementa el byte en `a` y luego CMP A con el resultado.
	void DCP_impl(eng::u16 a) { const eng::u8 v = static_cast<eng::u8>(mem->read(a) - 1u); mem->write(a, v); CMP_impl(A, v); }
	/// ISB: incrementa el byte en `a` y luego SBC A con el resultado.
	void ISB_impl(eng::u16 a) { const eng::u8 v = static_cast<eng::u8>(mem->read(a) + 1u); mem->write(a, v); SBC_impl(v); }
	/// SLO: ASL del byte en `a` y ORA de A con el resultado.
	void SLO_impl(eng::u16 a) { eng::u8 v = mem->read(a); C = (v & 0x80u) != 0u; v = static_cast<eng::u8>(v << 1u); mem->write(a, v); A = static_cast<eng::u8>(A | v); set_nz(A); }
	/// RLA: ROL del byte en `a` y AND de A con el resultado.
	void RLA_impl(eng::u16 a) { eng::u8 v = mem->read(a); const eng::u8 c = C ? 1u : 0u; C = (v & 0x80u) != 0u; v = static_cast<eng::u8>((v << 1u) | c); mem->write(a, v); A = static_cast<eng::u8>(A & v); set_nz(A); }
	/// SRE: LSR del byte en `a` y EOR de A con el resultado.
	void SRE_impl(eng::u16 a) { eng::u8 v = mem->read(a); C = (v & 1u) != 0u; v = static_cast<eng::u8>(v >> 1u); mem->write(a, v); A = static_cast<eng::u8>(A ^ v); set_nz(A); }
	/// RRA: ROR del byte en `a` y ADC de A con el resultado.
	void RRA_impl(eng::u16 a) { eng::u8 v = mem->read(a); const eng::u8 c = C ? 1u : 0u; C = (v & 1u) != 0u; v = static_cast<eng::u8>((v >> 1u) | (c << 7u)); mem->write(a, v); ADC_impl(v); }
	// Genera los modos de un RMW no oficial a partir de su IMPL(direccion).
#define N2A_RMW(NAME, IMPL) \
	void NAME##_zp(eng::u8 a) { IMPL(a); } \
	void NAME##_zpx(eng::u8 a) { IMPL(static_cast<eng::u8>(a + X)); } \
	void NAME##_abs(eng::u16 a) { IMPL(a); } \
	void NAME##_absx(eng::u16 a) { IMPL(static_cast<eng::u16>(a + X)); } \
	void NAME##_absy(eng::u16 a) { IMPL(static_cast<eng::u16>(a + Y)); } \
	void NAME##_indx(eng::u8 a) { IMPL(mem->read16(static_cast<eng::u8>(a + X))); } \
	void NAME##_indy(eng::u8 a) { IMPL(static_cast<eng::u16>(mem->read16(a) + Y)); }
	N2A_RMW(DCP, DCP_impl)
	N2A_RMW(ISB, ISB_impl)
	N2A_RMW(SLO, SLO_impl)
	N2A_RMW(RLA, RLA_impl)
	N2A_RMW(SRE, SRE_impl)
	N2A_RMW(RRA, RRA_impl)
#undef N2A_RMW
};
)N2ASTUB";

} // namespace n2a
