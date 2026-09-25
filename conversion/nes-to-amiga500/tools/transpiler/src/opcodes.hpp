#pragma once

/// \file opcodes.hpp
/// Tabla de opcodes del 6502 (oficiales + ilegales frecuentes) para el
/// transpilador NES -> C++23. Se guarda como lista de entradas y se expande a una
/// tabla de 256 ranuras en tiempo de compilacion (`constexpr`), sin `std::map`.

#include <eng/core/types/types.hpp>
#include <eng/core/util/array.hpp>

namespace n2a {

enum class AddrMode : eng::u8 {
	Imp,
	Imm,
	Zp,
	ZpX,
	ZpY,
	Abs,
	AbsX,
	AbsY,
	Ind,
	IndX,
	IndY,
	Rel,
	None, ///< opcode no reconocido
};

struct OpcodeInfo {
	const char* mnemonic = nullptr;
	AddrMode mode = AddrMode::None;
	eng::u8 size = 0u; ///< bytes totales (opcode + operandos)
};

struct OpEntry {
	eng::u8 code;
	const char* mnemonic;
	AddrMode mode;
	eng::u8 size;
};

inline constexpr OpEntry kOpEntries[] = {
	// --- Loads ---------------------------------------------------------------
	{0xA9, "LDA", AddrMode::Imm, 2},  {0xA5, "LDA", AddrMode::Zp, 2},
	{0xB5, "LDA", AddrMode::ZpX, 2},  {0xAD, "LDA", AddrMode::Abs, 3},
	{0xBD, "LDA", AddrMode::AbsX, 3}, {0xB9, "LDA", AddrMode::AbsY, 3},
	{0xA1, "LDA", AddrMode::IndX, 2}, {0xB1, "LDA", AddrMode::IndY, 2},

	{0xA2, "LDX", AddrMode::Imm, 2},  {0xA6, "LDX", AddrMode::Zp, 2},
	{0xB6, "LDX", AddrMode::ZpY, 2},  {0xAE, "LDX", AddrMode::Abs, 3},
	{0xBE, "LDX", AddrMode::AbsY, 3},

	{0xA0, "LDY", AddrMode::Imm, 2},  {0xA4, "LDY", AddrMode::Zp, 2},
	{0xB4, "LDY", AddrMode::ZpX, 2},  {0xAC, "LDY", AddrMode::Abs, 3},
	{0xBC, "LDY", AddrMode::AbsX, 3},

	// --- Stores --------------------------------------------------------------
	{0x85, "STA", AddrMode::Zp, 2},   {0x95, "STA", AddrMode::ZpX, 2},
	{0x8D, "STA", AddrMode::Abs, 3},  {0x9D, "STA", AddrMode::AbsX, 3},
	{0x99, "STA", AddrMode::AbsY, 3}, {0x81, "STA", AddrMode::IndX, 2},
	{0x91, "STA", AddrMode::IndY, 2},

	{0x86, "STX", AddrMode::Zp, 2},   {0x96, "STX", AddrMode::ZpY, 2},
	{0x8E, "STX", AddrMode::Abs, 3},

	{0x84, "STY", AddrMode::Zp, 2},   {0x94, "STY", AddrMode::ZpX, 2},
	{0x8C, "STY", AddrMode::Abs, 3},

	// --- Transferencias / pila ----------------------------------------------
	{0xAA, "TAX", AddrMode::Imp, 1},  {0xA8, "TAY", AddrMode::Imp, 1},
	{0x8A, "TXA", AddrMode::Imp, 1},  {0x98, "TYA", AddrMode::Imp, 1},
	{0xBA, "TSX", AddrMode::Imp, 1},  {0x9A, "TXS", AddrMode::Imp, 1},
	{0x48, "PHA", AddrMode::Imp, 1},  {0x68, "PLA", AddrMode::Imp, 1},
	{0x08, "PHP", AddrMode::Imp, 1},  {0x28, "PLP", AddrMode::Imp, 1},

	// --- Inc / Dec -----------------------------------------------------------
	{0xE8, "INX", AddrMode::Imp, 1},  {0xC8, "INY", AddrMode::Imp, 1},
	{0xCA, "DEX", AddrMode::Imp, 1},  {0x88, "DEY", AddrMode::Imp, 1},
	{0xE6, "INC", AddrMode::Zp, 2},   {0xF6, "INC", AddrMode::ZpX, 2},
	{0xEE, "INC", AddrMode::Abs, 3},  {0xFE, "INC", AddrMode::AbsX, 3},
	{0xC6, "DEC", AddrMode::Zp, 2},   {0xD6, "DEC", AddrMode::ZpX, 2},
	{0xCE, "DEC", AddrMode::Abs, 3},  {0xDE, "DEC", AddrMode::AbsX, 3},

	// --- ALU -----------------------------------------------------------------
	{0x69, "ADC", AddrMode::Imm, 2},  {0x65, "ADC", AddrMode::Zp, 2},
	{0x75, "ADC", AddrMode::ZpX, 2},  {0x6D, "ADC", AddrMode::Abs, 3},
	{0x7D, "ADC", AddrMode::AbsX, 3}, {0x79, "ADC", AddrMode::AbsY, 3},
	{0x61, "ADC", AddrMode::IndX, 2}, {0x71, "ADC", AddrMode::IndY, 2},

	{0xE9, "SBC", AddrMode::Imm, 2},  {0xE5, "SBC", AddrMode::Zp, 2},
	{0xF5, "SBC", AddrMode::ZpX, 2},  {0xED, "SBC", AddrMode::Abs, 3},
	{0xFD, "SBC", AddrMode::AbsX, 3}, {0xF9, "SBC", AddrMode::AbsY, 3},
	{0xE1, "SBC", AddrMode::IndX, 2}, {0xF1, "SBC", AddrMode::IndY, 2},

	{0x29, "AND", AddrMode::Imm, 2},  {0x25, "AND", AddrMode::Zp, 2},
	{0x35, "AND", AddrMode::ZpX, 2},  {0x2D, "AND", AddrMode::Abs, 3},
	{0x3D, "AND", AddrMode::AbsX, 3}, {0x39, "AND", AddrMode::AbsY, 3},
	{0x21, "AND", AddrMode::IndX, 2}, {0x31, "AND", AddrMode::IndY, 2},

	{0x09, "ORA", AddrMode::Imm, 2},  {0x05, "ORA", AddrMode::Zp, 2},
	{0x15, "ORA", AddrMode::ZpX, 2},  {0x0D, "ORA", AddrMode::Abs, 3},
	{0x1D, "ORA", AddrMode::AbsX, 3}, {0x19, "ORA", AddrMode::AbsY, 3},
	{0x01, "ORA", AddrMode::IndX, 2}, {0x11, "ORA", AddrMode::IndY, 2},

	{0x49, "EOR", AddrMode::Imm, 2},  {0x45, "EOR", AddrMode::Zp, 2},
	{0x55, "EOR", AddrMode::ZpX, 2},  {0x4D, "EOR", AddrMode::Abs, 3},
	{0x5D, "EOR", AddrMode::AbsX, 3}, {0x59, "EOR", AddrMode::AbsY, 3},
	{0x41, "EOR", AddrMode::IndX, 2}, {0x51, "EOR", AddrMode::IndY, 2},

	{0xC9, "CMP", AddrMode::Imm, 2},  {0xC5, "CMP", AddrMode::Zp, 2},
	{0xD5, "CMP", AddrMode::ZpX, 2},  {0xCD, "CMP", AddrMode::Abs, 3},
	{0xDD, "CMP", AddrMode::AbsX, 3}, {0xD9, "CMP", AddrMode::AbsY, 3},
	{0xC1, "CMP", AddrMode::IndX, 2}, {0xD1, "CMP", AddrMode::IndY, 2},

	{0xE0, "CPX", AddrMode::Imm, 2},  {0xE4, "CPX", AddrMode::Zp, 2},
	{0xEC, "CPX", AddrMode::Abs, 3},  {0xC0, "CPY", AddrMode::Imm, 2},
	{0xC4, "CPY", AddrMode::Zp, 2},   {0xCC, "CPY", AddrMode::Abs, 3},

	// --- Shifts --------------------------------------------------------------
	{0x0A, "ASL", AddrMode::Imp, 1},  {0x06, "ASL", AddrMode::Zp, 2},
	{0x16, "ASL", AddrMode::ZpX, 2},  {0x0E, "ASL", AddrMode::Abs, 3},
	{0x1E, "ASL", AddrMode::AbsX, 3},

	{0x4A, "LSR", AddrMode::Imp, 1},  {0x46, "LSR", AddrMode::Zp, 2},
	{0x56, "LSR", AddrMode::ZpX, 2},  {0x4E, "LSR", AddrMode::Abs, 3},
	{0x5E, "LSR", AddrMode::AbsX, 3},

	{0x2A, "ROL", AddrMode::Imp, 1},  {0x26, "ROL", AddrMode::Zp, 2},
	{0x36, "ROL", AddrMode::ZpX, 2},  {0x2E, "ROL", AddrMode::Abs, 3},
	{0x3E, "ROL", AddrMode::AbsX, 3},

	{0x6A, "ROR", AddrMode::Imp, 1},  {0x66, "ROR", AddrMode::Zp, 2},
	{0x76, "ROR", AddrMode::ZpX, 2},  {0x6E, "ROR", AddrMode::Abs, 3},
	{0x7E, "ROR", AddrMode::AbsX, 3},

	// --- Flags ---------------------------------------------------------------
	{0x18, "CLC", AddrMode::Imp, 1},  {0x38, "SEC", AddrMode::Imp, 1},
	{0x58, "CLI", AddrMode::Imp, 1},  {0x78, "SEI", AddrMode::Imp, 1},
	{0xB8, "CLV", AddrMode::Imp, 1},  {0xD8, "CLD", AddrMode::Imp, 1},
	{0xF8, "SED", AddrMode::Imp, 1},

	// --- Branches ------------------------------------------------------------
	{0x10, "BPL", AddrMode::Rel, 2},  {0x30, "BMI", AddrMode::Rel, 2},
	{0x50, "BVC", AddrMode::Rel, 2},  {0x70, "BVS", AddrMode::Rel, 2},
	{0x90, "BCC", AddrMode::Rel, 2},  {0xB0, "BCS", AddrMode::Rel, 2},
	{0xD0, "BNE", AddrMode::Rel, 2},  {0xF0, "BEQ", AddrMode::Rel, 2},

	// --- Saltos / subrutinas -------------------------------------------------
	{0x4C, "JMP", AddrMode::Abs, 3},  {0x6C, "JMP", AddrMode::Ind, 3},
	{0x20, "JSR", AddrMode::Abs, 3},  {0x60, "RTS", AddrMode::Imp, 1},
	{0x40, "RTI", AddrMode::Imp, 1},

	// --- Miscelaneo ----------------------------------------------------------
	{0x24, "BIT", AddrMode::Zp, 2},   {0x2C, "BIT", AddrMode::Abs, 3},
	{0xEA, "NOP", AddrMode::Imp, 1},  {0x00, "BRK", AddrMode::Imp, 1},

	// --- No oficiales frecuentes --------------------------------------------
	{0x1A, "NOP", AddrMode::Imp, 1},  {0x3A, "NOP", AddrMode::Imp, 1},
	{0x5A, "NOP", AddrMode::Imp, 1},  {0x7A, "NOP", AddrMode::Imp, 1},
	{0xDA, "NOP", AddrMode::Imp, 1},  {0xFA, "NOP", AddrMode::Imp, 1},

	{0x80, "NOP", AddrMode::Imm, 2},  {0x82, "NOP", AddrMode::Imm, 2},
	{0x89, "NOP", AddrMode::Imm, 2},  {0xC2, "NOP", AddrMode::Imm, 2},
	{0xE2, "NOP", AddrMode::Imm, 2},

	{0x04, "NOP", AddrMode::Zp, 2},   {0x44, "NOP", AddrMode::Zp, 2},
	{0x64, "NOP", AddrMode::Zp, 2},

	{0x14, "NOP", AddrMode::ZpX, 2},  {0x34, "NOP", AddrMode::ZpX, 2},
	{0x54, "NOP", AddrMode::ZpX, 2},  {0x74, "NOP", AddrMode::ZpX, 2},
	{0xD4, "NOP", AddrMode::ZpX, 2},  {0xF4, "NOP", AddrMode::ZpX, 2},

	{0x0C, "NOP", AddrMode::Abs, 3},  {0x1C, "NOP", AddrMode::AbsX, 3},
	{0x3C, "NOP", AddrMode::AbsX, 3}, {0x5C, "NOP", AddrMode::AbsX, 3},
	{0x7C, "NOP", AddrMode::AbsX, 3}, {0xDC, "NOP", AddrMode::AbsX, 3},
	{0xFC, "NOP", AddrMode::AbsX, 3},

	{0xA7, "LAX", AddrMode::Zp, 2},   {0xB7, "LAX", AddrMode::ZpY, 2},
	{0xAF, "LAX", AddrMode::Abs, 3},  {0xBF, "LAX", AddrMode::AbsY, 3},
	{0xA3, "LAX", AddrMode::IndX, 2}, {0xB3, "LAX", AddrMode::IndY, 2},

	{0x87, "SAX", AddrMode::Zp, 2},   {0x97, "SAX", AddrMode::ZpY, 2},
	{0x8F, "SAX", AddrMode::Abs, 3},  {0x83, "SAX", AddrMode::IndX, 2},

	{0xC7, "DCP", AddrMode::Zp, 2},   {0xD7, "DCP", AddrMode::ZpX, 2},
	{0xCF, "DCP", AddrMode::Abs, 3},  {0xDF, "DCP", AddrMode::AbsX, 3},
	{0xDB, "DCP", AddrMode::AbsY, 3}, {0xC3, "DCP", AddrMode::IndX, 2},
	{0xD3, "DCP", AddrMode::IndY, 2},

	{0xE7, "ISB", AddrMode::Zp, 2},   {0xF7, "ISB", AddrMode::ZpX, 2},
	{0xEF, "ISB", AddrMode::Abs, 3},  {0xFF, "ISB", AddrMode::AbsX, 3},
	{0xFB, "ISB", AddrMode::AbsY, 3}, {0xE3, "ISB", AddrMode::IndX, 2},
	{0xF3, "ISB", AddrMode::IndY, 2},

	{0x07, "SLO", AddrMode::Zp, 2},   {0x17, "SLO", AddrMode::ZpX, 2},
	{0x0F, "SLO", AddrMode::Abs, 3},  {0x1F, "SLO", AddrMode::AbsX, 3},
	{0x1B, "SLO", AddrMode::AbsY, 3}, {0x03, "SLO", AddrMode::IndX, 2},
	{0x13, "SLO", AddrMode::IndY, 2},

	{0x27, "RLA", AddrMode::Zp, 2},   {0x37, "RLA", AddrMode::ZpX, 2},
	{0x2F, "RLA", AddrMode::Abs, 3},  {0x3F, "RLA", AddrMode::AbsX, 3},
	{0x3B, "RLA", AddrMode::AbsY, 3}, {0x23, "RLA", AddrMode::IndX, 2},
	{0x33, "RLA", AddrMode::IndY, 2},

	{0x47, "SRE", AddrMode::Zp, 2},   {0x57, "SRE", AddrMode::ZpX, 2},
	{0x4F, "SRE", AddrMode::Abs, 3},  {0x5F, "SRE", AddrMode::AbsX, 3},
	{0x5B, "SRE", AddrMode::AbsY, 3}, {0x43, "SRE", AddrMode::IndX, 2},
	{0x53, "SRE", AddrMode::IndY, 2},

	{0x67, "RRA", AddrMode::Zp, 2},   {0x77, "RRA", AddrMode::ZpX, 2},
	{0x6F, "RRA", AddrMode::Abs, 3},  {0x7F, "RRA", AddrMode::AbsX, 3},
	{0x7B, "RRA", AddrMode::AbsY, 3}, {0x63, "RRA", AddrMode::IndX, 2},
	{0x73, "RRA", AddrMode::IndY, 2},
};

/// Expande las entradas a una tabla de 256 ranuras (las no listadas quedan
/// `None`). `constexpr`: el compilador la pliega y no hay coste en runtime.
[[nodiscard]] constexpr eng::util::Array<OpcodeInfo, 256> build_opcode_table() noexcept {
	eng::util::Array<OpcodeInfo, 256> table {};
	for (const OpEntry& e : kOpEntries) {
		table[e.code] = OpcodeInfo {e.mnemonic, e.mode, e.size};
	}
	return table;
}

inline constexpr auto kOpcodeTable = build_opcode_table();

} // namespace n2a
