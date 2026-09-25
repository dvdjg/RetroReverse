#pragma once

/// \file transpiler.hpp
/// Nucleo del transpilador NES (fase 1): parseo iNES, desensamblado recursivo,
/// basic blocks y generacion de C++23 sobre `eng/core` (sin STL).
///
/// Diseno en [`../../docs/TRANSPILER.md`](../../docs/TRANSPILER.md). Estado:
/// prototipo NROM (F2). El runtime emitido es un *stub* (ver `cpu_stub_text.hpp`).

#include <eng/core/types/types.hpp>
#include <eng/core/util/dynamic_string.hpp>
#include <eng/core/util/heap_alloc.hpp>
#include <eng/core/util/optional.hpp>
#include <eng/core/util/string_view.hpp>
#include <eng/core/util/vector.hpp>

#include "cpu_stub_text.hpp"
#include "opcodes.hpp"

namespace n2a {

using Dyn = eng::util::DynamicString<eng::util::HeapAlloc>;

struct Instruction {
	eng::u16 addr = 0;
	eng::u16 operand = 0;
	eng::u16 target = 0;
	eng::u8 opcode = 0;
	eng::u8 flags = 0; ///< bit0 = tiene operando, bit1 = tiene destino resuelto
};

inline constexpr eng::u8 kHasOperand = 0x01u;
inline constexpr eng::u8 kHasTarget = 0x02u;

/// Transpilador NES (NROM): lee una ROM iNES, desensambla la PRG-ROM de forma
/// recursiva, construye basic blocks y emite C++23 autodocumentado sobre
/// `eng/core` (sin STL). Flujo de uso:
///   `load()` -> `disassemble()` -> `build_basic_blocks()` -> `generate()`.
/// Los contenedores son de `eng/core` con `HeapAlloc` (solo host).
class Transpiler {
public:
	Transpiler() {
		(void)instr_.resize(kSpace, Instruction {});
		(void)has_instr_.resize(kSpace, 0u);
		(void)leaders_.resize(kSpace, 0u);
		(void)labels_.resize(kSpace, 0u);
		(void)branch_target_.resize(kSpace, 0u);
		(void)jmp_target_.resize(kSpace, 0u);
		(void)jsr_target_.resize(kSpace, 0u);
		(void)fallin_.resize(kSpace, 0u);
		(void)visited_.resize(kSpace, 0u);
		(void)worklist_.reserve(4096u);
	}

	/// Carga la ROM ya leida. `false` si no es un iNES valido o esta truncada.
	bool load(const eng::u8* data, eng::usize size) {
		if (size < 16u) {
			return false;
		}
		if (!(data[0] == 'N' && data[1] == 'E' && data[2] == 'S' && data[3] == 0x1Au)) {
			return false;
		}
		rom_.resize(size, 0u);
		for (eng::usize i = 0; i < size; ++i) {
			rom_[i] = data[i];
		}
		return parse_header() && extract_prg();
	}

	void disassemble() {
		push_work(reset_);
		if (nmi_ >= 0x8000u) {
			push_work(nmi_);
		}
		if (irq_ >= 0x8000u) {
			push_work(irq_);
		}

		while (!worklist_.empty()) {
			const eng::u16 addr = worklist_.back();
			worklist_.pop_back();
			if (visited_[addr] != 0u || addr < 0x8000u) {
				continue;
			}
			visited_[addr] = 1u;
			eng::u16 pc = addr;

			for (;;) {
				if (has_instr_[pc] != 0u) {
					break;
				}
				const auto opcode = read_byte(pc);
				if (!opcode) {
					break;
				}
				const OpcodeInfo& info = kOpcodeTable[*opcode];
				if (info.size == 0u) {
					++unknown_;
					break;
				}

				Instruction in;
				in.addr = pc;
				in.opcode = *opcode;

				if (info.size >= 2u) {
					if (info.mode == AddrMode::Rel) {
						const auto rel = read_byte(static_cast<eng::u16>(pc + 1u));
						if (rel) {
							const eng::s8 off = static_cast<eng::s8>(*rel);
							in.target = static_cast<eng::u16>(pc + 2u + off);
							in.operand = *rel;
							in.flags |= static_cast<eng::u8>(kHasOperand | kHasTarget);
						}
					} else if (info.size == 2u) {
						const auto b = read_byte(static_cast<eng::u16>(pc + 1u));
						if (b) {
							in.operand = *b;
							in.flags |= kHasOperand;
						}
					} else {
						const auto w = read_word(static_cast<eng::u16>(pc + 1u));
						if (w) {
							in.operand = *w;
							in.flags |= kHasOperand;
						}
					}
				}
				if ((info.mode == AddrMode::Abs) && has_operand(in) &&
				    (sv_equal(info.mnemonic, "JMP") || sv_equal(info.mnemonic, "JSR"))) {
					in.target = in.operand;
					in.flags |= kHasTarget;
				}

				instr_[pc] = in;
				has_instr_[pc] = 1u;
				++count_;
				const eng::u16 next = static_cast<eng::u16>(pc + info.size);

				if (sv_equal(info.mnemonic, "JMP")) {
					push_target(in);
					break;
				}
				if (sv_equal(info.mnemonic, "JSR")) {
					push_target(in);
					push_work(next);
					break;
				}
				if (sv_equal(info.mnemonic, "RTS") || sv_equal(info.mnemonic, "RTI") ||
				    sv_equal(info.mnemonic, "BRK")) {
					break;
				}
				if (info.mode == AddrMode::Rel) {
					push_target(in);
					push_work(next);
					break;
				}
				pc = next;
				if (pc < 0x8000u) {
					break;
				}
			}
		}
	}

	void build_basic_blocks() {
		mark_leader(reset_);
		if (has_instr_[nmi_] != 0u) {
			mark_leader(nmi_);
		}
		if (has_instr_[irq_] != 0u) {
			mark_leader(irq_);
		}
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (has_instr_[a] == 0u) {
				continue;
			}
			const eng::u16 addr = static_cast<eng::u16>(a);
			const Instruction& in = instr_[a];
			const OpcodeInfo& info = kOpcodeTable[in.opcode];
			const bool flow = (info.mode == AddrMode::Rel) || sv_equal(info.mnemonic, "JMP") ||
					  sv_equal(info.mnemonic, "JSR");
			if (flow) {
				if (has_target(in)) {
					mark_leader(in.target);
				}
				const eng::u16 next = static_cast<eng::u16>(addr + info.size);
				if (has_instr_[next] != 0u) {
					mark_leader(next);
				}
			}
			if (sv_equal(info.mnemonic, "RTS") || sv_equal(info.mnemonic, "RTI") ||
			    sv_equal(info.mnemonic, "BRK")) {
				const eng::u16 next = static_cast<eng::u16>(addr + info.size);
				if (has_instr_[next] != 0u) {
					mark_leader(next);
				}
			}
		}
		compute_block_metadata();
	}

	/// Calcula los metadatos que usan el codegen y la documentacion de bloques:
	/// etiquetas internas (auto-bucles), destinos de rama/`JMP`/`JSR` y caidas
	/// desde el bloque anterior. Se llama al final de `build_basic_blocks`.
	///
	/// Una etiqueta `L_xxxx` solo se emite cuando un salto **dentro del mismo
	/// bloque** la necesita (auto-bucle). Los saltos entre bloques se resuelven
	/// volviendo al despacho (`cpu.PC = destino; return;`), porque una etiqueta no
	/// es visible desde otra funcion. Asi no hay `-Wunused-label`.
	void compute_block_metadata() {
		for (eng::u32 a = 0; a < kSpace; ++a) {
			labels_[a] = 0u;
			branch_target_[a] = 0u;
			jmp_target_[a] = 0u;
			jsr_target_[a] = 0u;
			fallin_[a] = 0u;
		}
		// Destinos de flujo directo (rama, JMP abs, JSR abs).
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (has_instr_[a] == 0u) {
				continue;
			}
			const Instruction& in = instr_[a];
			const OpcodeInfo& info = kOpcodeTable[in.opcode];
			if (!has_target(in)) {
				continue;
			}
			if (info.mode == AddrMode::Rel) {
				branch_target_[in.target] = 1u;
			} else if (sv_equal(info.mnemonic, "JMP")) {
				jmp_target_[in.target] = 1u;
			} else if (sv_equal(info.mnemonic, "JSR")) {
				jsr_target_[in.target] = 1u;
			}
		}
		// Etiquetas de auto-bucle y caidas entre bloques.
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] == 0u) {
				continue;
			}
			const eng::u16 start = static_cast<eng::u16>(a);
			eng::u16 pc = start;
			eng::u16 last_addr = start;
			const OpcodeInfo* last = nullptr;
			for (;;) {
				if (has_instr_[pc] == 0u || (pc != start && leaders_[pc] != 0u)) {
					break;
				}
				const Instruction& in = instr_[pc];
				const OpcodeInfo& info = kOpcodeTable[in.opcode];
				const bool rel = info.mode == AddrMode::Rel;
				const bool jmp_abs = sv_equal(info.mnemonic, "JMP") && info.mode == AddrMode::Abs;
				if ((rel || jmp_abs) && has_target(in) && in.target == start) {
					labels_[start] = 1u;
				}
				last_addr = pc;
				last = &info;
				pc = static_cast<eng::u16>(pc + info.size);
				if (rel || sv_equal(info.mnemonic, "JMP") || sv_equal(info.mnemonic, "JSR") ||
				    sv_equal(info.mnemonic, "RTS") || sv_equal(info.mnemonic, "RTI") ||
				    sv_equal(info.mnemonic, "BRK")) {
					break;
				}
			}
			if (last != nullptr) {
				const bool no_ft = sv_equal(last->mnemonic, "JMP") || sv_equal(last->mnemonic, "JSR") ||
						   sv_equal(last->mnemonic, "RTS") || sv_equal(last->mnemonic, "RTI") ||
						   sv_equal(last->mnemonic, "BRK");
				const eng::u16 next = static_cast<eng::u16>(last_addr + last->size);
				if (!no_ft && next < kSpace && has_instr_[next] != 0u) {
					fallin_[next] = 1u;
				}
			}
		}
	}

	/// Genera el fichero C++ completo en `out`.
	void generate(Dyn& out) const {
		emit_header(out);
		emit_rom(out);
		out.append(kCpuStubText);
		emit_blocks(out);
		emit_dispatch(out);
	}

	[[nodiscard]] int mapper() const noexcept { return mapper_; }
	[[nodiscard]] eng::u32 prg_size() const noexcept { return prg_size_; }
	[[nodiscard]] eng::usize instruction_count() const noexcept { return count_; }
	[[nodiscard]] eng::usize block_count() const noexcept { return block_count_; }
	[[nodiscard]] eng::u16 reset_vector() const noexcept { return reset_; }
	[[nodiscard]] eng::u16 nmi_vector() const noexcept { return nmi_; }
	[[nodiscard]] eng::u16 irq_vector() const noexcept { return irq_; }
	[[nodiscard]] eng::usize unknown_count() const noexcept { return unknown_; }

private:
	static constexpr eng::u32 kSpace = 0x10000u;

	eng::util::Vector<eng::u8, eng::util::HeapAlloc> rom_ {};
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> prg_ {};
	eng::u32 prg_size_ = 0;
	int mapper_ = 0;
	bool has_trainer_ = false;
	eng::u16 reset_ = 0;
	eng::u16 nmi_ = 0;
	eng::u16 irq_ = 0;

	eng::util::Vector<Instruction, eng::util::HeapAlloc> instr_ {};
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> has_instr_ {};
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> leaders_ {};
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> labels_ {};
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> branch_target_ {}; ///< destino de una rama
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> jmp_target_ {};    ///< destino de un JMP abs
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> jsr_target_ {};    ///< destino de un JSR
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> fallin_ {};        ///< continuacion de bloque
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> visited_ {};
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> worklist_ {};

	eng::usize count_ = 0;
	eng::usize unknown_ = 0;
	eng::usize block_count_ = 0;

	// --- Helpers de texto ---
	[[nodiscard]] static bool sv_equal(const char* mnemonic, const char* other) noexcept {
		eng::util::StringView a(mnemonic);
		eng::util::StringView b(other);
		return a == b;
	}
	[[nodiscard]] static bool has_operand(const Instruction& in) noexcept {
		return (in.flags & kHasOperand) != 0u;
	}
	[[nodiscard]] static bool has_target(const Instruction& in) noexcept {
		return (in.flags & kHasTarget) != 0u;
	}

	// --- Parseo iNES ---
	bool parse_header() {
		const eng::u8 prg_pages = rom_[4];
		const eng::u8 chr_pages = rom_[5];
		const eng::u8 flags6 = rom_[6];
		const eng::u8 flags7 = rom_[7];
		(void)chr_pages;
		prg_size_ = static_cast<eng::u32>(prg_pages) * 16384u;
		mapper_ = static_cast<int>((flags6 >> 4u) | (flags7 & 0xF0u));
		has_trainer_ = (flags6 & 0x04u) != 0u;
		return prg_size_ != 0u && mapper_ == 0; // prototipo: solo NROM
	}

	bool extract_prg() {
		eng::usize offset = 16u;
		if (has_trainer_) {
			offset += 512u;
		}
		if (offset + prg_size_ > rom_.size()) {
			return false;
		}
		(void)prg_.resize(prg_size_, 0u);
		for (eng::u32 i = 0; i < prg_size_; ++i) {
			prg_[i] = rom_[offset + i];
		}
		if (prg_.size() < 6u) {
			return false;
		}
		const eng::usize end = prg_.size();
		nmi_ = static_cast<eng::u16>(prg_[end - 6u] | (static_cast<eng::u16>(prg_[end - 5u]) << 8));
		reset_ = static_cast<eng::u16>(prg_[end - 4u] | (static_cast<eng::u16>(prg_[end - 3u]) << 8));
		irq_ = static_cast<eng::u16>(prg_[end - 2u] | (static_cast<eng::u16>(prg_[end - 1u]) << 8));
		return true;
	}

	[[nodiscard]] eng::util::Optional<eng::usize> prg_offset(eng::u16 addr) const {
		if (addr < 0x8000u) {
			return {};
		}
		eng::usize off = static_cast<eng::usize>(addr - 0x8000u);
		if (prg_size_ == 16384u) {
			off &= 0x3FFFu;
		}
		if (off >= prg_.size()) {
			return {};
		}
		return off;
	}

	[[nodiscard]] eng::util::Optional<eng::u8> read_byte(eng::u16 addr) const {
		const auto off = prg_offset(addr);
		if (!off) {
			return {};
		}
		return prg_[*off];
	}

	[[nodiscard]] eng::util::Optional<eng::u16> read_word(eng::u16 addr) const {
		const auto lo = read_byte(addr);
		const auto hi = read_byte(static_cast<eng::u16>(addr + 1u));
		if (!lo || !hi) {
			return {};
		}
		return static_cast<eng::u16>(*lo | (static_cast<eng::u16>(*hi) << 8));
	}

	void push_work(eng::u16 addr) {
		if (addr >= 0x8000u) {
			(void)worklist_.push_back(addr);
		}
	}
	void push_target(const Instruction& in) {
		if (has_target(in)) {
			push_work(in.target);
		}
	}
	void mark_leader(eng::u16 addr) {
		if (leaders_[addr] == 0u && has_instr_[addr] != 0u) {
			leaders_[addr] = 1u;
			++block_count_;
		}
	}

	// --- Codegen ---
	static const char* mode_suffix(AddrMode mode) noexcept {
		switch (mode) {
		case AddrMode::Imm: return "_imm";
		case AddrMode::Zp: return "_zp";
		case AddrMode::ZpX: return "_zpx";
		case AddrMode::ZpY: return "_zpy";
		case AddrMode::Abs: return "_abs";
		case AddrMode::AbsX: return "_absx";
		case AddrMode::AbsY: return "_absy";
		case AddrMode::Ind: return "_ind";
		case AddrMode::IndX: return "_indx";
		case AddrMode::IndY: return "_indy";
		default: return "";
		}
	}

	static void append_method_name(Dyn& out, const OpcodeInfo& info) {
		if (sv_equal(info.mnemonic, "NOP")) {
			switch (info.mode) {
			case AddrMode::Imm: out.append("NOP_imm"); return;
			case AddrMode::Zp: out.append("NOP_zp"); return;
			case AddrMode::ZpX: out.append("NOP_zpx"); return;
			case AddrMode::Abs: out.append("NOP_abs"); return;
			case AddrMode::AbsX: out.append("NOP_absx"); return;
			default: out.append("NOP"); return;
			}
		}
		out.append(info.mnemonic);
		if (info.mode == AddrMode::Imp) {
			if (sv_equal(info.mnemonic, "ASL") || sv_equal(info.mnemonic, "LSR") ||
			    sv_equal(info.mnemonic, "ROL") || sv_equal(info.mnemonic, "ROR")) {
				out.append("_A");
			}
		} else {
			out.append(mode_suffix(info.mode));
		}
	}

	static void append_arg(Dyn& out, const Instruction& in, const OpcodeInfo& info) {
		out.append("0x");
		const bool narrow = (info.mode == AddrMode::Imm || info.mode == AddrMode::Zp ||
				     info.mode == AddrMode::ZpX || info.mode == AddrMode::ZpY ||
				     info.mode == AddrMode::IndX || info.mode == AddrMode::IndY);
		out.append_hex(in.operand, narrow ? 2u : 4u, true);
	}

	static void append_comment(Dyn& out, const Instruction& in, const OpcodeInfo& info) {
		out.append("  // $");
		out.append_hex(in.addr, 4u, true);
		out.append(": ");
		out.append(info.mnemonic);
		if (has_target(in)) {
			out.append(" $");
			out.append_hex(in.target, 4u, true);
		} else if (has_operand(in)) {
			const bool narrow = info.size == 2u;
			out.append(" $");
			out.append_hex(in.operand, narrow ? 2u : 4u, true);
		}
	}

	static const char* branch_cond(const char* mnemonic) noexcept {
		if (sv_equal(mnemonic, "BNE")) return "!cpu.Z";
		if (sv_equal(mnemonic, "BEQ")) return "cpu.Z";
		if (sv_equal(mnemonic, "BCC")) return "!cpu.C";
		if (sv_equal(mnemonic, "BCS")) return "cpu.C";
		if (sv_equal(mnemonic, "BPL")) return "!cpu.N";
		if (sv_equal(mnemonic, "BMI")) return "cpu.N";
		if (sv_equal(mnemonic, "BVC")) return "!cpu.V";
		if (sv_equal(mnemonic, "BVS")) return "cpu.V";
		return "false";
	}

	static void append_label_ref(Dyn& out, eng::u16 addr, const char* prefix = "L_") {
		out.append(prefix);
		out.append_hex(addr, 4u, true);
	}

	/// Emite la cabecera documentada del fichero generado: que es, quien lo usa y
	/// en que contexto, y que recursos necesita (regla de codigo autodocumentado).
	void emit_header(Dyn& out) const {
		out.append("// ============================================================\n");
		out.append("// Codigo C++23 generado por nes_transpiler (fase 1; eng/core, sin STL)\n");
		out.append("// ============================================================\n");
		out.append("//\n");
		out.append("// QUE ES\n");
		out.append("//   Traduccion de la PRG-ROM de una ROM NES (mapper ");
		out.append_s32(mapper_);
		out.append(", ");
		out.append_u32(prg_size_);
		out.append(" bytes de PRG) a basic blocks C++23.\n");
		out.append("//   Cada bb_XXXX corresponde a un rango de direcciones 6502 y ejecuta las\n");
		out.append("//   mismas operaciones mediante metodos de CPU.\n");
		out.append("//\n");
		out.append("// QUIEN LO USA / CONTEXTO\n");
		out.append("//   - Lo compila el runtime del nodo (conversion/nes-to-amiga500/runtime/)\n");
		out.append("//     para Amiga 500, o el host para tests.\n");
		out.append("//   - Punto de entrada: game_main(), bucle de despacho por cpu.PC.\n");
		out.append("//   - Los bloques llaman a CPU (cpu.LDA_abs(...)), unico punto de enganche\n");
		out.append("//     con RAM/PPU/APU/mapper (interceptable por la capa HLE).\n");
		out.append("//\n");
		out.append("// RECURSOS\n");
		out.append("//   - Sin memoria dinamica; PRG_ROM es constexpr.\n");
		out.append("//   - dispatch_table: 0x10000 punteros a funcion.\n");
		out.append("//   - Depende solo de eng/core (tipos) en el runtime.\n");
		out.append("//\n");
		out.append("// VECTORES  Reset=$");
		out.append_hex(reset_, 4u, true);
		out.append("  NMI=$");
		out.append_hex(nmi_, 4u, true);
		out.append("  IRQ=$");
		out.append_hex(irq_, 4u, true);
		out.append("\n// ============================================================\n\n");
		out.append("#include <eng/core/types/types.hpp>\n\n");
	}

	void emit_rom(Dyn& out) const {
		out.append("static constexpr eng::usize kPrgSize = ");
		out.append_u32(prg_size_);
		out.append(";\nstatic constexpr eng::u8 PRG_ROM[kPrgSize] = {\n");
		for (eng::u32 i = 0; i < prg_size_; ++i) {
			if ((i % 16u) == 0u) {
				out.append("    ");
			}
			out.append("0x");
			out.append_hex(prg_[i], 2u, true);
			out.append(',');
			if ((i % 16u) == 15u || i + 1u == prg_size_) {
				out.append('\n');
			} else {
				out.append(' ');
			}
		}
		out.append("};\n\n");
	}

	void emit_one_instruction(Dyn& out, const Instruction& in, eng::u16 block_start) const {
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		const char* m = info.mnemonic;

		if (info.mode == AddrMode::Rel) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			if (in.target == block_start) {
				out.append("    if (");
				out.append(branch_cond(m));
				out.append(") goto ");
				append_label_ref(out, in.target);
				out.append(";\n");
			} else {
				out.append("    if (");
				out.append(branch_cond(m));
				out.append(") { cpu.PC = 0x");
				out.append_hex(in.target, 4u, true);
				out.append("; return; }\n");
			}
			return;
		}
		if (sv_equal(m, "JMP") && info.mode == AddrMode::Abs) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			if (in.target == block_start) {
				out.append("    goto ");
				append_label_ref(out, in.target);
				out.append(";\n");
			} else {
				out.append("    cpu.PC = 0x");
				out.append_hex(in.target, 4u, true);
				out.append("; return;\n");
			}
			return;
		}
		if (sv_equal(m, "JMP") && info.mode == AddrMode::Ind) {
			out.append("    ");
			append_comment(out, in, info);
			out.append("\n    cpu.JMP_ind(0x");
			out.append_hex(in.operand, 4u, true);
			out.append("); return;\n");
			return;
		}
		if (sv_equal(m, "JSR")) {
			out.append("    ");
			append_comment(out, in, info);
			out.append("\n    cpu.JSR_abs(0x");
			out.append_hex(in.target, 4u, true);
			out.append(", 0x");
			out.append_hex(static_cast<eng::u16>(in.addr + 3u), 4u, true);
			out.append("); return;\n");
			return;
		}
		if (sv_equal(m, "RTS") || sv_equal(m, "RTI") || sv_equal(m, "BRK")) {
			out.append("    ");
			append_comment(out, in, info);
			out.append("\n    cpu.");
			out.append(m);
			out.append("(); return;\n");
			return;
		}
		// Generica
		out.append("    cpu.");
		append_method_name(out, info);
		out.append('(');
		if (has_operand(in)) {
			append_arg(out, in, info);
		}
		out.append(')');
		out.append(';');
		append_comment(out, in, info);
		out.append('\n');
	}

	/// Emite el comentario de documentacion de un basic block: rango 6502, numero
	/// de instrucciones, que hace, quien lo llama y que recursos usa (regla de
	/// codigo autodocumentado de `AGENTS.md`, aplicada al codigo generado).
	void emit_block_doc(Dyn& out, eng::u16 start) const {
		eng::u16 pc = start;
		eng::u16 last_addr = start;
		eng::u32 count = 0;
		const OpcodeInfo* last = nullptr;
		for (;;) {
			if (has_instr_[pc] == 0u || (pc != start && leaders_[pc] != 0u)) {
				break;
			}
			const OpcodeInfo& info = kOpcodeTable[instr_[pc].opcode];
			last_addr = pc;
			last = &info;
			++count;
			pc = static_cast<eng::u16>(pc + info.size);
			if (info.mode == AddrMode::Rel || sv_equal(info.mnemonic, "JMP") ||
			    sv_equal(info.mnemonic, "JSR") || sv_equal(info.mnemonic, "RTS") ||
			    sv_equal(info.mnemonic, "RTI") || sv_equal(info.mnemonic, "BRK")) {
				break;
			}
		}
		const eng::u16 end = static_cast<eng::u16>(last_addr + (last != nullptr ? last->size : 1u));

		out.append("//\n// bb_");
		out.append_hex(start, 4u, true);
		out.append(" - bloque 6502 $");
		out.append_hex(start, 4u, true);
		out.append("..$");
		out.append_hex(static_cast<eng::u16>(end - 1u), 4u, true);
		out.append(" (");
		out.append_u32(count);
		out.append(count == 1u ? " instruccion)\n// Que hace: " : " instrucciones)\n// Que hace: ");

		if (last == nullptr) {
			out.append("bloque sin instrucciones.\n");
		} else if (sv_equal(last->mnemonic, "JMP") && last->mode == AddrMode::Abs) {
			out.append("ejecuta el tramo y salta a $");
			out.append_hex(instr_[last_addr].target, 4u, true);
			out.append(" (JMP).\n");
		} else if (sv_equal(last->mnemonic, "JMP") && last->mode == AddrMode::Ind) {
			out.append("ejecuta el tramo y hace JMP ($");
			out.append_hex(instr_[last_addr].operand, 4u, true);
			out.append("), dejando el destino en cpu.PC.\n");
		} else if (sv_equal(last->mnemonic, "JSR")) {
			out.append("ejecuta el tramo y llama a $");
			out.append_hex(instr_[last_addr].target, 4u, true);
			out.append(" (JSR); el regreso llega por cpu.PC.\n");
		} else if (sv_equal(last->mnemonic, "RTS")) {
			out.append("ejecuta el tramo y retorna de subrutina (RTS).\n");
		} else if (sv_equal(last->mnemonic, "RTI")) {
			out.append("ejecuta el tramo y retorna de interrupcion (RTI).\n");
		} else if (sv_equal(last->mnemonic, "BRK")) {
			out.append("ejecuta el tramo y detiene la ejecucion (BRK).\n");
		} else if (last->mode == AddrMode::Rel) {
			out.append("ejecuta el tramo; si ");
			out.append(last->mnemonic);
			out.append(" salta a $");
			out.append_hex(instr_[last_addr].target, 4u, true);
			out.append(", si no cae a $");
			out.append_hex(static_cast<eng::u16>(last_addr + last->size), 4u, true);
			out.append(".\n");
		} else {
			out.append("ejecuta el tramo y cae a $");
			out.append_hex(static_cast<eng::u16>(last_addr + last->size), 4u, true);
			out.append(".\n");
		}

		out.append("// Llamado por: ");
		bool any = false;
		if (start == reset_) {
			out.append("reset (game_main)");
			any = true;
		}
		if (start == nmi_) {
			if (any) out.append(", ");
			out.append("NMI");
			any = true;
		}
		if (start == irq_) {
			if (any) out.append(", ");
			out.append("IRQ");
			any = true;
		}
		if (branch_target_[start] != 0u) {
			if (any) out.append(", ");
			out.append("destino de rama");
			any = true;
		}
		if (jmp_target_[start] != 0u) {
			if (any) out.append(", ");
			out.append("destino de JMP");
			any = true;
		}
		if (jsr_target_[start] != 0u) {
			if (any) out.append(", ");
			out.append("destino de JSR");
			any = true;
		}
		if (fallin_[start] != 0u) {
			if (any) out.append(", ");
			out.append("continuacion del bloque previo");
			any = true;
		}
		if (!any) {
			out.append("despacho directo por cpu.PC (sin referencias estaticas)");
		}
		out.append(".\n");
		out.append("// Recursos: ninguno propio; usa CPU y su memoria (RAM/PPU/APU/mapper).\n");
	}

	void emit_blocks(Dyn& out) const {
		out.append("// ---- Basic blocks ----\n\n");
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] != 0u) {
				out.append("static void bb_");
				out.append_hex(static_cast<eng::u16>(a), 4u, true);
				out.append("(CPU& cpu);\n");
			}
		}
		out.append('\n');

		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] == 0u) {
				continue;
			}
			const eng::u16 start = static_cast<eng::u16>(a);
			emit_block_doc(out, start);
			out.append("static void bb_");
			out.append_hex(start, 4u, true);
			out.append("(CPU& cpu) {\n");
			if (labels_[start] != 0u) {
				append_label_ref(out, start, "L_");
				out.append(":\n");
			}

			eng::u16 pc = start;
			eng::u16 last_addr = start;
			const OpcodeInfo* last = nullptr;
			for (;;) {
				if (has_instr_[pc] == 0u) {
					break;
				}
				if (pc != start && leaders_[pc] != 0u) {
					break;
				}
				const Instruction& in = instr_[pc];
				const OpcodeInfo& info = kOpcodeTable[in.opcode];
				emit_one_instruction(out, in, start);
				last_addr = pc;
				last = &info;
				pc = static_cast<eng::u16>(pc + info.size);
				if (info.mode == AddrMode::Rel || sv_equal(info.mnemonic, "JMP") ||
				    sv_equal(info.mnemonic, "JSR") || sv_equal(info.mnemonic, "RTS") ||
				    sv_equal(info.mnemonic, "RTI") || sv_equal(info.mnemonic, "BRK")) {
					break;
				}
			}
			if (last != nullptr) {
				const bool no_fallthrough = sv_equal(last->mnemonic, "JMP") ||
							    sv_equal(last->mnemonic, "JSR") ||
							    sv_equal(last->mnemonic, "RTS") ||
							    sv_equal(last->mnemonic, "RTI") ||
							    sv_equal(last->mnemonic, "BRK");
				const eng::u16 next = static_cast<eng::u16>(last_addr + last->size);
				if (!no_fallthrough && next < kSpace && has_instr_[next] != 0u) {
					if (next == start) {
						out.append("    goto ");
						append_label_ref(out, next);
						out.append(";\n");
					} else {
						out.append("    cpu.PC = 0x");
						out.append_hex(next, 4u, true);
						out.append("; return;\n");
					}
				}
			}
			out.append("}\n\n");
		}
	}

	void emit_dispatch(Dyn& out) const {
		out.append("// ---- Despacho y entrada ----\n\n");
		out.append("/// Firma de un basic block: recibe el CPU (y su memoria) y muta el estado.\n");
		out.append("using BlockFn = void (*)(CPU&);\n\n");
		out.append("/// Tabla de despacho indexada por cpu.PC (0x0000..0xFFFF);\n");
		out.append("/// nullptr en las direcciones que no son inicio de bloque.\n");
		out.append("static BlockFn dispatch_table[0x10000] = {};\n\n");
		out.append("/// Estado global del juego (CPU + memoria), accesible por el runtime y por\n");
		out.append("/// los tests host (para comprobar el resultado de una ejecucion).\n");
		out.append("struct GameState { CPU cpu; NESMemory mem; };\n");
		out.append("static GameState g_state;\n\n");
		out.append("/// Rellena dispatch_table con la direccion de inicio de cada basic block.\n");
		out.append("/// Se llama una vez al arrancar, antes de entrar en game_main().\n");
		out.append("static void init_dispatch_table() {\n");
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] == 0u) {
				continue;
			}
			out.append("    dispatch_table[0x");
			out.append_hex(static_cast<eng::u16>(a), 4u, true);
			out.append("] = bb_");
			out.append_hex(static_cast<eng::u16>(a), 4u, true);
			out.append(";\n");
		}
		out.append("}\n\n");
		out.append("/// Punto de entrada del juego. Arranca en el vector de reset y ejecuta\n");
		out.append("/// bloques despachados por cpu.PC hasta que el PC no tenga bloque (retorno)\n");
		out.append("/// o la CPU se detenga (BRK). No reserva recursos; usa g_state.\n");
		out.append("void game_main() {\n");
		out.append("    CPU& cpu = g_state.cpu;\n");
		out.append("    cpu.mem = &g_state.mem;\n");
		out.append("    init_dispatch_table();\n");
		out.append("    cpu.PC = 0x");
		out.append_hex(reset_, 4u, true);
		out.append(";\n");
		out.append("    for (;;) {\n");
		out.append("        BlockFn fn = dispatch_table[cpu.PC];\n");
		out.append("        if (fn == nullptr) { return; }\n");
		out.append("        fn(cpu);\n");
		out.append("        if (cpu.halted) { return; }\n");
		out.append("    }\n}\n\n");
		out.append("#if !defined(__m68k__) && !defined(N2A_NO_HOST_MAIN)\n");
		out.append("/// Entrada host para tests. En Amiga el runtime llama a game_main() y este\n");
		out.append("/// simbolo queda excluido (por __m68k__ o por N2A_NO_HOST_MAIN).\n");
		out.append("int main() { game_main(); return 0; }\n");
		out.append("#endif\n");
	}
};

} // namespace n2a
