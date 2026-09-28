#pragma once

/// \file transpiler.hpp
/// Núcleo del transpilador NES→Amiga (fase 1): parsea la cabecera iNES, obtiene
/// la PRG-ROM y sus vectores, la desensambla de forma recursiva, agrupa las
/// instrucciones en *basic blocks* y emite un `.cpp` C++23 que usa el runtime del
/// nodo (`runtime/include/nes_runtime.hpp`). Todo sobre `eng/core` (sin STL).
///
/// Diseño y fases en [`../../docs/TRANSPILER.md`](../../docs/TRANSPILER.md).
/// Alcance actual: NROM (mapper 0), opcodes oficiales + ilegales frecuentes.

#include <eng/core/types/types.hpp>
#include <eng/core/util/dynamic_string.hpp>
#include <eng/core/util/heap_alloc.hpp>
#include <eng/core/util/optional.hpp>
#include <eng/core/util/string_view.hpp>
#include <eng/core/util/vector.hpp>

#include "opcodes.hpp"

namespace n2a {

/// Búfer de texto de salida del codegen: cadena que crece en el heap del host.
using Dyn = eng::util::DynamicString<eng::util::HeapAlloc>;

/// Una instrucción de 6502 ya decodificada y ubicada en el espacio de la CPU.
///
/// `operand` guarda el operando **tal cual aparece en la ROM** (inmediato de 8
/// bits, dirección de página cero o dirección absoluta de 16 bits). `target` es
/// el destino resuelto de ramas y de `JMP`/`JSR` absolutos; para el resto de
/// modos vale 0 y no debe usarse. Los bits `has_operand`/`has_target` de `flags`
/// indican cuáles de esos campos son válidos.
struct Instruction {
	eng::u16 addr = 0;    ///< Dirección 6502 donde empieza la instrucción.
	eng::u16 operand = 0; ///< Operando inmediato o dirección, según el modo.
	eng::u16 target = 0;  ///< Destino resuelto de rama/JMP/JSR (si `has_target`).
	eng::u8 opcode = 0;   ///< Byte de opcode (índice en `kOpcodeTable`).
	eng::u8 flags = 0;    ///< bit0 = operando válido, bit1 = destino válido.
};

/// El campo `flags` de `Instruction` marca que `operand` es válido.
inline constexpr eng::u8 kHasOperand = 0x01u;
/// El campo `flags` de `Instruction` marca que `target` es válido.
inline constexpr eng::u8 kHasTarget = 0x02u;

/// Ciclos **base** (sin penalización de página/rama) de cada opcode 6502, igual
/// que la tabla del intérprete del runtime. Se usa para estimar los ciclos de un
/// bloque en el código generado (`n2a_block_cycles`), de modo que el runtime pueda
/// avanzar la PPU al ejecutar bloques generados. La estimación omite solo las
/// penalizaciones dependientes de datos (≤ 1 ciclo por instrucción).
/// \param op Byte de opcode.
/// \return Ciclos base (2..8; 0 si el opcode no tiene entrada).
[[nodiscard]] inline eng::u8 op_base_cycles(eng::u8 op) noexcept {
	static constexpr eng::u8 t[256] = {
		/*00*/ 7, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 4, 4, 6, 6,
		/*10*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
		/*20*/ 6, 6, 2, 8, 3, 3, 5, 5, 4, 2, 2, 2, 4, 4, 6, 6,
		/*30*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
		/*40*/ 6, 6, 2, 8, 3, 3, 5, 5, 3, 2, 2, 2, 3, 4, 6, 6,
		/*50*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
		/*60*/ 6, 6, 2, 8, 3, 3, 5, 5, 4, 2, 2, 2, 5, 4, 6, 6,
		/*70*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
		/*80*/ 2, 6, 2, 6, 3, 3, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4,
		/*90*/ 2, 6, 2, 6, 4, 4, 4, 4, 2, 5, 2, 5, 5, 5, 5, 5,
		/*A0*/ 2, 6, 2, 6, 3, 3, 3, 3, 2, 2, 2, 2, 4, 4, 4, 4,
		/*B0*/ 2, 5, 2, 5, 4, 4, 4, 4, 2, 4, 2, 4, 4, 4, 4, 4,
		/*C0*/ 2, 6, 2, 8, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6,
		/*D0*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
		/*E0*/ 2, 6, 2, 8, 3, 3, 5, 5, 2, 2, 2, 2, 4, 4, 6, 6,
		/*F0*/ 2, 5, 2, 8, 4, 4, 6, 6, 2, 4, 2, 7, 4, 4, 7, 7,
	};
	return t[op];
}

/// ¿La lectura de `op` usa direccionamiento indexado que penaliza **+1 ciclo** al
/// cruzar de página? (Las escrituras y los RMW no penalizan.) Debe coincidir con
/// el intérprete del runtime para que la temporalización sea idéntica.
/// \param op Byte de opcode.
/// \return `true` si cruzar página añade un ciclo.
[[nodiscard]] inline bool op_read_indexed_penalty(eng::u8 op) noexcept {
	switch (op) {
	case 0x1D: case 0x19: case 0x11:
	case 0x3D: case 0x39: case 0x31:
	case 0x5D: case 0x59: case 0x51:
	case 0x7D: case 0x79: case 0x71:
	case 0xBD: case 0xB9: case 0xB1:
	case 0xDD: case 0xD9: case 0xD1:
	case 0xFD: case 0xF9: case 0xF1:
	case 0xBC: case 0xBE:
	case 0xBB: case 0xBF: case 0xB3:
	case 0x1C: case 0x3C: case 0x5C: case 0x7C: case 0xDC: case 0xFC:
		return true;
	default:
		return false;
	}
}

/// Clase de hecho de valores sobre una dirección (aportado por análisis o
/// telemetría; ver [`../../docs/OPTIMIZATION.md`](../../docs/OPTIMIZATION.md)).
enum class FactKind : eng::u8 {
	Eq,     ///< Siempre vale `values[0]`.
	Range,  ///< Está en `[0, values[1]]` (`values[0]` = mínimo, informativo).
	Set,    ///< Pertenece al conjunto `values[0..count-1]`.
	Power2, ///< Es una potencia de dos (o cero).
	Hot,    ///< `addr` es inicio de bloque y se ejecutó `count` veces (0 = nunca).
};

/// Hecho sobre una dirección que el codegen consume: los de **valor**
/// (`Eq`/`Range`/`Set`/`Power2`) se traducen a `N2A_ASSUME` en los bloques que
/// leen esa dirección; los de **calor** (`Hot`) marcan el bloque como
/// `__attribute__((hot))`/`((cold))` para reordenar y ajustar el código (ver
/// [`../../docs/OPTIMIZATION.md`](../../docs/OPTIMIZATION.md)).
struct Fact {
	FactKind kind = FactKind::Eq; ///< Interpretación de `values`/`count`.
	eng::u16 addr = 0;            ///< Dirección observada (valor) o inicio de bloque (calor).
	eng::u8 values[4] {};         ///< Valores según `kind`.
	eng::u8 count = 0;            ///< Nº de valores usados (para `Set`).
	eng::u32 heat = 0;            ///< Ejecuciones observadas (para `Hot`).
};

/// Transpilador de una ROM NES (NROM) a C++23.
///
/// Ciclo de vida (llamar en este orden):
/// 1. `load()`            — valida y descompone la ROM en `rom_`/`prg_`.
/// 2. `disassemble()`     — decodifica las instrucciones alcanzables.
/// 3. `build_basic_blocks()` — calcula líderes y metadatos de bloques.
/// 4. `generate()`        — escribe el `.cpp` en un `Dyn`.
///
/// El objeto mantiene tablas de 0x10000 entradas indexadas por dirección 6502
/// (instrucción, marcas); por eso su coste en memoria es de unos pocos cientos
/// de KB, aceptable en la herramienta host (no en el Amiga).
class Transpiler {
public:
	/// Reserva las tablas indexadas por dirección (0x0000..0xFFFF). El coste se
	/// paga una vez y evita buscar en mapas durante el análisis.
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

	/// Carga una ROM iNES ya leída en memoria.
	///
	/// Comprueba la firma `NES\x1A`, copia los bytes a `rom_` y delega en
	/// `parse_header()` y `extract_prg()`. Es el único punto de entrada de datos.
	///
	/// \param data Puntero a los bytes de la ROM (no se conserva el puntero).
	/// \param size Número de bytes.
	/// \return `true` si es una ROM iNES NROM válida y no truncada.
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

	/// Desensambla de forma recursiva todas las instrucciones alcanzables.
	///
	/// Usa una pila de trabajo (`worklist_`) con los puntos de entrada: el vector
	/// de reset y, si apuntan a la PRG, los de NMI e IRQ. Desde cada entrada
	/// decodifica en línea hasta una instrucción de fin de flujo (`JMP`, `JSR`,
	/// rama, `RTS`/`RTI`/`BRK`), apilando los destinos y las continuaciones. Las
	/// direcciones ya vistas (`visited_`) no se repiten. Rellena `instr_` y
	/// `has_instr_`; los bytes que no se alcanzan no se decodifican.
	void disassemble() {
		push_work(reset_);
		if (nmi_ >= 0x8000u) {
			push_work(nmi_);
		}
		if (irq_ >= 0x8000u) {
			push_work(irq_);
		}
		// Entradas extra de telemetría (PC ejecutados): completan el CFG en saltos
		// indirectos. No aplican a PRG bancada (la ventana conmutable se analiza aparte).
		if (!prg_banked_) {
			for (eng::usize i = 0; i < extra_entries_.size(); ++i) {
				push_work(extra_entries_[i]);
			}
		}
		run_worklist();
	}

	/// Desensambla un **banco conmutable** (UxROM) desde las entradas descubiertas
	/// en `switch_targets_`. Antes hay que llamar a `reset_analysis()` y fijar
	/// `bank_` al índice del banco.
	void disassemble_bank(const eng::util::Vector<eng::u16, eng::util::HeapAlloc>& entries) {
		for (eng::usize i = 0; i < entries.size(); ++i) {
			push_work(entries[i]);
		}
		run_worklist();
	}

	/// Bucle de desensamblado recursivo común (usa `worklist_` ya sembrada).
	void run_worklist() {
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
				// Instrucción truncada al final de la PRG (operandos fuera de la
				// ROM): no es código válido, no se emite (evita llamadas sin
				// argumento, p. ej. `ISB_absx()`).
				if (info.size >= 2u && !has_operand(in)) {
					++unknown_;
					break;
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

	/// Reinicia el estado del análisis para reutilizarlo con otro banco (F9/B1b).
	void reset_analysis() {
		for (eng::u32 a = 0; a < kSpace; ++a) {
			instr_[a] = Instruction {};
			has_instr_[a] = 0u;
			leaders_[a] = 0u;
			labels_[a] = 0u;
			branch_target_[a] = 0u;
			jmp_target_[a] = 0u;
			jsr_target_[a] = 0u;
			fallin_[a] = 0u;
			visited_[a] = 0u;
		}
		worklist_.clear();
		count_ = 0u;
		unknown_ = 0u;
		block_count_ = 0u;
	}

	/// Recoge los destinos en `$8000-$BFFF` (JMP/JSR/rama) del análisis actual
	/// como puntos de entrada candidatos de los bancos conmutables (UxROM).
	void collect_switch_targets() {
		switch_targets_.clear();
		switch_targets2_.clear();
		switch_targets3_.clear();
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (has_instr_[a] == 0u) {
				continue;
			}
			const Instruction& in = instr_[a];
			if (!has_target(in)) {
				continue;
			}
			const eng::u16 t = in.target;
			// Ventanas conmutables por mapper: MMC3 (2×8 KB), FME-7 (3×8 KB).
			eng::util::Vector<eng::u16, eng::util::HeapAlloc>* dst;
			if (mapper_ == 4) {
				if (t >= 0x8000u && t < 0xA000u) {
					dst = &switch_targets_;
				} else if (t >= 0xA000u && t < 0xC000u) {
					dst = &switch_targets2_;
				} else {
					continue;
				}
			} else if (mapper_ == 69) {
				if (t >= 0x8000u && t < 0xA000u) {
					dst = &switch_targets_;
				} else if (t >= 0xA000u && t < 0xC000u) {
					dst = &switch_targets2_;
				} else if (t >= 0xC000u && t < 0xE000u) {
					dst = &switch_targets3_;
				} else {
					continue;
				}
			} else if (mapper_ == 24 || mapper_ == 26) {
				// VRC6: W0 = $8000-$BFFF (16 KB), W1 = $C000-$DFFF (8 KB).
				if (t >= 0x8000u && t < 0xC000u) {
					dst = &switch_targets_;
				} else if (t >= 0xC000u && t < 0xE000u) {
					dst = &switch_targets2_;
				} else {
					continue;
				}
			} else if (mapper_ == 5) {
				// MMC5 (modo 3): cuatro ventanas de 8 KB.
				if (t >= 0x8000u && t < 0xA000u) {
					dst = &switch_targets_;
				} else if (t >= 0xA000u && t < 0xC000u) {
					dst = &switch_targets2_;
				} else if (t >= 0xC000u && t < 0xE000u) {
					dst = &switch_targets3_;
				} else if (t >= 0xE000u) {
					dst = &switch_targets4_;
				} else {
					continue;
				}
			} else {
				if (t < 0x8000u || t >= 0xC000u) {
					continue;
				}
				dst = &switch_targets_;
			}
			bool dup = false;
			for (eng::usize i = 0; i < dst->size(); ++i) {
				if ((*dst)[i] == t) {
					dup = true;
					break;
				}
			}
			if (!dup) {
				(void)dst->push_back(t);
			}
		}
	}

	/// Calcula los *líderes* (inicios de basic block) a partir del CFG implícito.
	///
	/// Un líder es: el vector de reset/NMI/IRQ, el destino de una rama/`JMP`/`JSR`
	/// y la instrucción siguiente a cualquier salto o fin de flujo. Después llama
	/// a `compute_block_metadata()`, que deriva las etiquetas y los destinos que
	/// necesitará el codegen. Debe ejecutarse tras `disassemble()`.
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

	/// Deriva los metadatos que usan el codegen y la ficha de cada bloque.
	///
	/// Rellena, para cada dirección:
	/// - `labels_`: la etiqueta `L_xxxx` se emite solo si un salto **dentro del
	///   mismo bloque** la usa (auto-bucle). Los saltos entre bloques se resuelven
	///   volviendo al despacho (`cpu.PC = destino; return;`) porque una etiqueta
	///   C++ no es visible desde otra función; así se evita `-Wunused-label`.
	/// - `branch_target_`, `jmp_target_`, `jsr_target_`: si la dirección es destino
	///   de una rama, de un `JMP` absoluto o de un `JSR` (para la ficha del bloque).
	/// - `fallin_`: si la dirección es la continuación natural del bloque anterior.
	///
	/// Se invoca al final de `build_basic_blocks()`; no genera código.
	void compute_block_metadata() {
		for (eng::u32 a = 0; a < kSpace; ++a) {
			labels_[a] = 0u;
			branch_target_[a] = 0u;
			jmp_target_[a] = 0u;
			jsr_target_[a] = 0u;
			fallin_[a] = 0u;
		}
		// Destinos de flujo directo: rama, JMP absoluto y JSR absoluto.
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
		// Etiquetas de auto-bucle y continuaciones entre bloques.
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

	/// Escribe el fichero C++ completo en `out`, en este orden:
	/// 1. cabecera documentada e `#include <eng/core/types/types.hpp>`;
	/// 2. `kPrgSize` y `PRG_ROM` (necesarios por el runtime);
	/// 3. `#include "nes_runtime.hpp"` y los `using` de `CPU`/`NESMemory`;
	/// 4. los *basic blocks* (`bb_XXXX`) con su ficha;
	/// 5. la tabla de despacho, `game_main()` y el `main()` de host.
	///
	/// \param out Búfer de texto donde se acumula la salida (no se vacía).
	void generate(Dyn& out) {
		emit_header(out);
		out.append("#include \"nes_runtime.hpp\"\n");
		out.append("using n2a::CPU;\n");
		out.append("using n2a::NESMemory;\n\n");
		emit_rom(out);
		// Backend nativo (estilo descompilador): sustituye todo el codegen por bloques.
		// Con `--best` se elige solo si la ROM lo soporta; si no, cae al codegen por
		// bloques (con el perfil Amiga si el llamador lo activó).
		if ((native_ || best_) && native_ok()) {
			emit_native(out);
			return;
		}
		// Ventana fija (y NROM/CNROM completos): el llamador ya hizo
		// `disassemble()` + `build_basic_blocks()`.
		const eng::usize fixed_instr = count_;
		const eng::usize fixed_blocks = block_count_;
		emit_blocks_for(out, -1);
		// UxROM (2) / MMC1 (1, modo 16K): decodifica la ventana conmutable **por
		// banco** desde las entradas descubiertas en la ventana fija.
		const bool banked = prg_banked_ && (mapper_ == 2 || mapper_ == 1 ||
						    mapper_ == 4 || mapper_ == 5 ||
						    mapper_ == 69 || mapper_ == 24 ||
						    mapper_ == 26);
		if (banked) {
			collect_switch_targets();
			eng::usize bank_instr = 0u;
			eng::usize bank_blocks = 0u;
			// Ventanas conmutables: MMC5 = 4 (8 KB); FME-7 = 3 (8 KB);
			// MMC3 = 2 (8 KB); VRC6 = 2 (16 KB + 8 KB).
			const int windows =
				(mapper_ == 5) ? 4
				: (mapper_ == 69) ? 3
				: (mapper_ == 4 || mapper_ == 24 || mapper_ == 26) ? 2
									 : 1;
			const bool multi_win = (mapper_ == 5 || mapper_ == 4 || mapper_ == 69 ||
						mapper_ == 24 || mapper_ == 26);
			eng::util::Vector<eng::u16, eng::util::HeapAlloc>* wtargets[4] = {
				&switch_targets_, &switch_targets2_, &switch_targets3_,
				&switch_targets4_};
			for (int w = 0; w < windows; ++w) {
				win_ = multi_win ? w : -1;
				eng::u32 nb = prg_bank_count_;
				if (mapper_ == 24 || mapper_ == 26) {
					// W0: bancos de 16 KB; W1: bancos de 8 KB.
					nb = (w == 0) ? (prg_size_ / 0x4000u) : (prg_size_ / 0x2000u);
				}
				for (eng::u32 b = 0; b < nb; ++b) {
					reset_analysis();
					bank_ = static_cast<int>(b);
					disassemble_bank(*wtargets[w]);
					build_basic_blocks();
					bank_instr += count_;
					bank_blocks += block_count_;
					emit_blocks_for(out, static_cast<int>(b));
				}
			}
			bank_ = -1;
			win_ = -1;
			count_ = fixed_instr + bank_instr;
			block_count_ = fixed_blocks + bank_blocks;
		}
		emit_dispatch(out);
	}

	/// Registra un hecho de valores que el codegen emitirá como `N2A_ASSUME` en
	/// los bloques que lean esa dirección. Llamar antes de `generate()`.
	/// \param f Hecho a añadir (se copia).
	void add_fact(const Fact& f) { (void)facts_.push_back(f); }

	/// Añade un **punto de entrada** extra al desensamblado (p. ej. los PC ejecutados
	/// observados por telemetría: `opcode_hist ... <hot.txt>`). Completa el CFG cuando
	/// el análisis estático no puede seguir un salto indirecto/tabla. Llamar **antes**
	/// de `disassemble()`; se ignora en PRG bancada (solo ventana fija).
	/// \param a Dirección 6502 de inicio de código (`$8000-$FFFF`).
	void add_entry_point(eng::u16 a) { (void)extra_entries_.push_back(a); }

	/// Con `true`, **no** se emite la contabilidad de ciclos (`cpu.cycles += N`) ni
	/// las penalizaciones de página/rama. Para destinos sin PPU ciclo-exacta
	/// (Amiga/`--release`), donde los ciclos solo agobian al 68000.
	/// \param b `true` para desactivar los ciclos.
	void set_no_cycles(bool b) noexcept { no_cycles_ = b; }

	/// Con `true`, emite `N2A_TRACE(0xADDR);` antes de cada instrucción, para
	/// trazar el flujo del codegen y compararlo con el intérprete. Sin definir,
	/// `N2A_TRACE` es un no-op (coste cero). \param b `true` para activar la traza.
	void set_trace(bool b) noexcept { trace_ = b; }

	/// Con `true`, las instrucciones de **zero-page** se emiten con acceso directo a
	/// `cpu.mem->ram[...]` (sin el método/`switch` de región). Ganancia en 68000.
	/// \param b `true` para activar el acceso directo a RAM de página cero.
	void set_fast_ram(bool b) noexcept { fast_ram_ = b; }

	/// Con `true`, **encadena los bloques** por control de flujo estático: un salto,
	/// caída o `JMP` con destino conocido se emite como **llamada en cola** al bloque
	/// siguiente (`return bb_XXXX(cpu);`), y `JSR`/`RTS` como **llamada/retorno C**
	/// (`bb_call(cpu); return bb_ret(cpu);` / `cpu.pull16(); return;`). Evita el
	/// despachador por búsqueda binaria en cada bloque (el mayor coste en 68000).
	/// Solo se activa con `--no-cycles`: sin cesión por deadline el control se
	/// transfiere directamente y el runtime debe ceder en los puntos de evento.
	/// \param b `true` para encadenar bloques.
	void set_chain(bool b) noexcept { chain_ = b; }

	/// Con `true`, las lecturas de la ventana fija de ROM (NROM/CNROM, `Abs`/`AbsX`/
	/// `AbsY`) se emiten como **acceso directo a `PRG_ROM[...]`** (constexpr) en vez
	/// de pasar por `NESMemory::read` (que decodifica región y hace `idx % prg_size`,
	/// una libcall de 32 bits en 68000). Permite a g++ ver los datos fijos.
	/// \param b `true` para emitir lecturas directas de ROM.
	void set_rom_direct(bool b) noexcept { rom_direct_ = b; }

	/// Con `true`, emite un **backend "nativo" estilo descompilador**: en vez de bloques
	/// que llaman a métodos de `CPU` (con el estado en `struct`), genera **una función C++
	/// por REGIÓN** (punto de entrada = `reset`/NMI/IRQ/`JSR`) con el estado del 6502 en
	/// **variables locales** (`a/x/y/flags`), lecturas de ROM como **literales** (PRG fija)
	/// y control de flujo C++ normal (`goto`). Así el optimizador global de g++ puede
	/// propagar valores, plegar constantes y asignar registros entre bloques.
	/// Solo para **PRG no bancada** y sin opcodes indirectos/ilegales (si no, el llamador
	/// debe usar el codegen por bloques).
	/// \param b `true` para activar el backend nativo.
	void set_native(bool b) noexcept { native_ = b; }

	/// Con `true`, elige automáticamente el mejor backend: el **nativo** si la ROM lo
	/// soporta (`native_ok()`) y, si no, el codegen por bloques con el perfil Amiga
	/// (`--chain`/`--rom-direct`/`--fast-ram`, que el llamador debe activar). Pensado
	/// para el pipeline por juego.
	/// \param b `true` para selección automática de backend.
	void set_best(bool b) noexcept { best_ = b; }
	/// \return `true` si el backend nativo puede emitir esta ROM (PRG fija y opcodes
	/// soportados). Lo consulta el llamador para elegir el codegen.
	[[nodiscard]] bool native_ok() const noexcept {
		if (prg_banked_ || prg_size_ == 0u || (prg_size_ & (prg_size_ - 1u)) != 0u) {
			return false;
		}
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (has_instr_[a] == 0u) {
				continue;
			}
			if (!native_supported(kOpcodeTable[instr_[a].opcode])) {
				return false;
			}
			// Todo destino de `JSR` debe ser inicio de bloque (entrada de región).
			const Instruction& in = instr_[a];
			if (sv_equal(kOpcodeTable[in.opcode].mnemonic, "JSR") && has_operand(in) &&
			    !(in.target < kSpace && has_instr_[in.target] != 0u &&
			      leaders_[in.target] != 0u)) {
				return false;
			}
		}
		return true;
	}

	/// Número de mapper iNES de la ROM cargada.
	[[nodiscard]] int mapper() const noexcept { return mapper_; }
	/// Tamaño de la PRG-ROM en bytes.
	[[nodiscard]] eng::u32 prg_size() const noexcept { return prg_size_; }
	/// Tamaño de banco de PRG en bytes (NROM/CNROM: la PRG entera).
	[[nodiscard]] eng::u32 prg_bank_size() const noexcept { return prg_bank_size_; }
	/// Número de bancos de PRG (NROM/CNROM: 1).
	[[nodiscard]] eng::u32 prg_bank_count() const noexcept { return prg_bank_count_; }
	/// `true` si la PRG está **bancada** (UxROM/MMC1/MMC3/MMC5/VRC6/FME-7). El
	/// codegen **por banco** es el trabajo pendiente de F9; hoy el transpilador
	/// solo emite PRG fija (NROM/CNROM). Ver `docs/TRANSPILER_BANKING.md`.
	[[nodiscard]] bool prg_banked() const noexcept { return prg_banked_; }
	/// Número de instrucciones decodificadas.
	[[nodiscard]] eng::usize instruction_count() const noexcept { return count_; }
	/// Número de *basic blocks* detectados.
	[[nodiscard]] eng::usize block_count() const noexcept { return block_count_; }
	/// Vector de reset (`$FFFC`).
	[[nodiscard]] eng::u16 reset_vector() const noexcept { return reset_; }
	/// Vector de NMI (`$FFFA`).
	[[nodiscard]] eng::u16 nmi_vector() const noexcept { return nmi_; }
	/// Vector de IRQ/BRK (`$FFFE`).
	[[nodiscard]] eng::u16 irq_vector() const noexcept { return irq_; }
	/// Opcodes encontrados que no están en la tabla (posible código no alcanzado).
	[[nodiscard]] eng::usize unknown_count() const noexcept { return unknown_; }

private:
	/// Tamaño del espacio de direcciones del 6502: índices `0x0000..0xFFFF`.
	static constexpr eng::u32 kSpace = 0x10000u;

	eng::util::Vector<eng::u8, eng::util::HeapAlloc> rom_ {}; ///< ROM iNES completa.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> prg_ {}; ///< Solo la PRG-ROM.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> chr_ {}; ///< Solo la CHR-ROM (si la hay).
	eng::u32 prg_size_ = 0;                                   ///< Tamaño de PRG en bytes.
	eng::u32 chr_size_ = 0;                                   ///< Tamaño de CHR en bytes (0 = CHR RAM).
	int mapper_ = 0;                                          ///< Número de mapper iNES.
	eng::u32 prg_bank_size_ = 0;                              ///< Tamaño de banco de PRG (layout).
	eng::u32 prg_bank_count_ = 1;                             ///< Nº de bancos de PRG (layout).
	bool prg_banked_ = false;                                 ///< ¿PRG bancada? (codegen F9/B1b).

	/// Información de un bloque para las tablas de despacho.
	struct BlockInfo {
		eng::u8 bank;    ///< 0xFF = ventana fija; 0.. = banco conmutable (UxROM).
		eng::u16 start;  ///< Dirección 6502 de inicio del bloque.
		eng::u16 cycles; ///< Ciclos base del bloque (para avanzar la PPU).
	};
	int bank_ = -1; ///< Contexto de análisis: -1 = fijo; >=0 = banco conmutable.
	int win_ = -1;  ///< Ventana MMC3: -1 = fija; 0 = `$8000-$9FFF`; 1 = `$A000-$BFFF`.
	eng::util::Vector<BlockInfo, eng::util::HeapAlloc> fixed_blocks_ {}; ///< Bloques de $C000+ (o NROM).
	eng::util::Vector<BlockInfo, eng::util::HeapAlloc> bank_blocks_ {};  ///< Bloques de la ventana conmutable.
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> switch_targets_ {}; ///< Entradas de $8000-$BFFF (o W0 MMC3).
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> switch_targets2_ {}; ///< Entradas de $A000-$BFFF (W1).
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> switch_targets3_ {}; ///< Entradas de $C000-$DFFF (W2 FME-7).
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> switch_targets4_ {}; ///< Entradas de $E000-$FFFF (W3 MMC5).
	bool mirror_h_ = false;                                   ///< Mirroring horizontal (bit0 flags6).
	bool has_trainer_ = false;                                ///< ¿Trae trainer de 512 B?
	eng::u16 reset_ = 0;                                      ///< Vector de reset.
	eng::u16 nmi_ = 0;                                        ///< Vector de NMI.
	eng::u16 irq_ = 0;                                        ///< Vector de IRQ.

	eng::util::Vector<Instruction, eng::util::HeapAlloc> instr_ {}; ///< Instrucción por dirección.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> has_instr_ {}; ///< 1 si la dirección tiene instrucción.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> leaders_ {};   ///< 1 si la dirección inicia bloque.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> labels_ {};    ///< 1 si hay que emitir `L_xxxx`.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> branch_target_ {}; ///< Destino de rama.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> jmp_target_ {};    ///< Destino de `JMP` abs.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> jsr_target_ {};    ///< Destino de `JSR`.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> fallin_ {};        ///< Continuación del bloque previo.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> visited_ {};       ///< Direcciones ya desensambladas.
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> worklist_ {};     ///< Pila de puntos de entrada.
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> extra_entries_ {}; ///< Entradas extra (telemetría de PC).
	eng::util::Vector<Fact, eng::util::HeapAlloc> facts_ {};            ///< Hechos de valores (ver `add_fact`).

	eng::usize count_ = 0;       ///< Instrucciones decodificadas.
	eng::usize unknown_ = 0;     ///< Opcodes desconocidos encontrados.
	eng::usize block_count_ = 0; ///< Bloques detectados.
	bool no_cycles_ = false;     ///< Si `true`, no emitir ciclos (ver `set_no_cycles`).
	bool fast_ram_ = false;      ///< Si `true`, zero-page con acceso directo (ver `set_fast_ram`).
	bool trace_ = false;         ///< Si `true`, emitir `N2A_TRACE` por instrucción (ver `set_trace`).
	bool chain_ = false;         ///< Si `true`, encadenar bloques (ver `set_chain`).
	bool rom_direct_ = false;    ///< Si `true`, lecturas directas de ROM (ver `set_rom_direct`).
	bool native_ = false;        ///< Si `true`, backend nativo por regiones (ver `set_native`).
	bool best_ = false;          ///< Si `true`, elige nativo si es posible (ver `set_best`).
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> native_vis_ {}; ///< Scratch de regiones.
	/// VSA de índices del nativo: `LDX/LDY #imm` fija el valor; otra escritura lo invalida.
	/// Permite plegar `LDA tabla,X` a literal cuando `X` es constante en el bloque.
	bool native_x_known_ = false;
	bool native_y_known_ = false;
	bool native_a_known_ = false;
	eng::u8 native_x_val_ = 0;
	eng::u8 native_y_val_ = 0;
	eng::u8 native_a_val_ = 0;
	/// Dirección cuya **primera instrucción** debe omitirse al emitir su bloque (para
	/// absorberse en un idiom, p. ej. el `DEC lo` de un decremento de 16 bits).
	eng::u16 native_skip_first_ = 0xFFFFu;
	int cur_bank_ = -1;          ///< Banco del bloque en emisión (`-1` = ventana fija).
	bool cur_nz_live_ = true;    ///< ¿`Z`/`N` viven tras la instrucción actual? (liveness, ver `nz_dead_after`).

	// --- Utilidades internas ---

	/// Compara un mnemónico de la tabla con un literal (sin construir `StringView`
	/// en el llamador). \return `true` si son iguales.
	[[nodiscard]] static bool sv_equal(const char* mnemonic, const char* other) noexcept {
		eng::util::StringView a(mnemonic);
		eng::util::StringView b(other);
		return a == b;
	}
	/// \return `true` si `in` tiene operando válido.
	[[nodiscard]] static bool has_operand(const Instruction& in) noexcept {
		return (in.flags & kHasOperand) != 0u;
	}
	/// \return `true` si `in` tiene destino de salto válido.
	[[nodiscard]] static bool has_target(const Instruction& in) noexcept {
		return (in.flags & kHasTarget) != 0u;
	}

	// --- Parseo de la ROM ---

	/// Lee la cabecera iNES (16 bytes) y deriva tamaño de PRG, mapper y trainer.
	/// \return `true` si la PRG no está vacía y el mapper tiene **PRG fija**
	///         (NROM 0 o CNROM 3). UxROM (2) y MMC1 (1) conmutan bancos de PRG y
	///         no se pueden decodificar estáticamente todavía.
	bool parse_header() {
		const eng::u8 prg_pages = rom_[4];
		const eng::u8 chr_pages = rom_[5];
		const eng::u8 flags6 = rom_[6];
		const eng::u8 flags7 = rom_[7];
		prg_size_ = static_cast<eng::u32>(prg_pages) * 16384u;
		chr_size_ = static_cast<eng::u32>(chr_pages) * 8192u;
		mapper_ = static_cast<int>((flags6 >> 4u) | (flags7 & 0xF0u));
		has_trainer_ = (flags6 & 0x04u) != 0u;
		// Bit0 de flags6: 0 = mirroring horizontal, 1 = vertical.
		mirror_h_ = (flags6 & 0x01u) == 0u;
		// --- Layout de PRG (F9/B0) ---
		// Se calcula aunque el mapper no sea aún transpilable, para poder dar un
		// diagnóstico preciso (mapper, nº de bancos) y preparar el codegen por
		// banco. El valor de retorno sigue indicando "PRG fija" (NROM/CNROM): solo
		// esas se pueden decodificar estáticamente hoy.
		prg_banked_ = false;
		prg_bank_size_ = prg_size_;
		prg_bank_count_ = 1u;
		switch (mapper_) {
		case 2: // UxROM: ventana conmutable de 16 KB + fija (último banco).
			prg_bank_size_ = 0x4000u;
			prg_bank_count_ = prg_size_ / prg_bank_size_;
			prg_banked_ = true;
			break;
		case 24: case 26: // VRC6: ventana de 16 KB ($8000) + 8 KB ($C000); máx = bancos de 8 KB.
			prg_bank_size_ = 0x2000u;
			prg_bank_count_ = prg_size_ / 0x2000u;
			prg_banked_ = true;
			break;
		case 4: case 5: // 8 KB por banco (MMC3, MMC5).
			prg_bank_size_ = 0x2000u;
			prg_bank_count_ = prg_size_ / prg_bank_size_;
			prg_banked_ = true;
			break;
		case 1: case 7: case 69: // 16 KB por banco.
			prg_bank_size_ = 0x4000u;
			prg_bank_count_ = prg_size_ / prg_bank_size_;
			prg_banked_ = true;
			break;
		default:
			break;
		}
		// "codegen-ready": NROM/CNROM (PRG fija), UxROM (2) y **MMC1 (1)** en modo
		// 16K con banco en `$8000` (sentinela de modo en runtime → fallback si el
		// juego cambia de modo). Verificado byte-exact en Metroid/Mega Man 2 a 60
		// frames (docs/TIMING_CODEGEN.md).
		const bool codegen_ok = (mapper_ == 0 || mapper_ == 1 || mapper_ == 2 ||
					 mapper_ == 3 || mapper_ == 4 || mapper_ == 5 ||
					 mapper_ == 24 || mapper_ == 26 || mapper_ == 69);
		return prg_size_ != 0u && codegen_ok;
	}

	/// Copia la PRG-ROM a `prg_` y extrae los tres vectores de los últimos 6 bytes.
	/// \return `false` si el fichero está truncado o no hay vectores.
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
		// CHR-ROM (tras la PRG), para que el transpilado sea un cartucho completo.
		const eng::usize chr_off = offset + prg_size_;
		if (chr_size_ != 0u && chr_off + chr_size_ <= rom_.size()) {
			(void)chr_.resize(chr_size_, 0u);
			for (eng::u32 i = 0; i < chr_size_; ++i) {
				chr_[i] = rom_[chr_off + i];
			}
		} else {
			chr_size_ = 0u; // CHR truncada o ausente: se trata como CHR RAM
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

	/// Traduce una dirección 6502 a un desplazamiento dentro de `prg_`.
	///
	/// - **NROM/CNROM** (PRG fija): mapeo lineal `$8000`+ con espejo de 16 KB.
	/// - **UxROM (2)** (B1a): `$C000-$FFFF` = **último banco (fijo)**; la ventana
	///   conmutable `$8000-$BFFF` **no** se mapea aquí (se devuelve vacío) para que
	///   el análisis estático la omita y la ejecute el **intérprete del runtime**,
	///   que ya lee a través del mapper (`NesSystem::io_read` → `Mapper::cpu_read`).
	///
	/// \return Offset dentro de `prg_`, o vacío si la dirección no es PRG.
	[[nodiscard]] eng::util::Optional<eng::usize> prg_offset(eng::u16 addr) const {
		if (addr < 0x8000u) {
			return {};
		}
		eng::usize off;
		// MMC3 (4): dos ventanas conmutables de 8 KB + dos fijas (modo0).
		//  - W0 `$8000-$9FFF` = R6 · W1 `$A000-$BFFF` = R7 (conmutables, `win_`).
		//  - `$C000-$DFFF` = n8-2 y `$E000-$FFFF` = n8-1 (fijas, `win_ < 0`).
		if (mapper_ == 4) {
			const eng::usize n8 = prg_size_ / 0x2000u;
			if (win_ < 0) {
				if (addr >= 0xC000u && addr < 0xE000u) {
					off = (n8 >= 2u ? n8 - 2u : 0u) * 0x2000u + (addr - 0xC000u);
				} else if (addr >= 0xE000u) {
					off = (n8 >= 1u ? n8 - 1u : 0u) * 0x2000u + (addr - 0xE000u);
				} else {
					return {};
				}
			} else if (win_ == 0) {
				if (addr < 0x8000u || addr >= 0xA000u) {
					return {};
				}
				off = static_cast<eng::usize>(bank_) * 0x2000u + (addr - 0x8000u);
			} else {
				if (addr < 0xA000u || addr >= 0xC000u) {
					return {};
				}
				off = static_cast<eng::usize>(bank_) * 0x2000u + (addr - 0xA000u);
			}
		} else if (mapper_ == 5) {
			// MMC5 (modo 3, por defecto): cuatro ventanas de 8 KB
			// ($8000/$A000/$C000/$E000 = `mmc5_prg_banks[1..4]`, `win_` 0..3). El
			// análisis "fijo" (`win_<0`) mapea `$E000-$FFFF` al **último banco** (boot
			// y vectores); la ventana 3 lo cubre igual en el despacho.
			const eng::usize n8 = prg_size_ / 0x2000u;
			if (win_ >= 0 && win_ <= 3) {
				const eng::u16 base = static_cast<eng::u16>(0x8000u + win_ * 0x2000u);
				if (addr < base || addr >= static_cast<eng::u16>(base + 0x2000u)) {
					return {};
				}
				off = static_cast<eng::usize>(bank_) * 0x2000u + (addr - base);
			} else {
				if (addr < 0xE000u) return {};
				off = (n8 >= 1u ? n8 - 1u : 0u) * 0x2000u + (addr - 0xE000u);
			}
		} else if (mapper_ == 24 || mapper_ == 26) {
			// VRC6 (24/26): `$8000-$BFFF` = 16 KB conmutable (`win_` 0, banco 16 KB),
			// `$C000-$DFFF` = 8 KB conmutable (`win_` 1), `$E000-$FFFF` = último 8 KB.
			const eng::usize n8 = prg_size_ / 0x2000u;
			if (win_ == 0) {
				if (addr < 0x8000u || addr >= 0xC000u) return {};
				off = static_cast<eng::usize>(bank_) * 0x4000u + (addr - 0x8000u);
			} else if (win_ == 1) {
				if (addr < 0xC000u || addr >= 0xE000u) return {};
				off = static_cast<eng::usize>(bank_) * 0x2000u + (addr - 0xC000u);
			} else {
				if (addr < 0xE000u) return {};
				off = (n8 >= 1u ? n8 - 1u : 0u) * 0x2000u + (addr - 0xE000u);
			}
		} else if (mapper_ == 69) {
			// FME-7 (69): tres ventanas conmutables de 8 KB (`$8000/$A000/$C000` =
			// `fme7_prg[0..2]`, `win_` 0/1/2) + `$E000-$FFFF` fija (último banco).
			const eng::usize n8 = prg_size_ / 0x2000u;
			if (win_ == 0) {
				if (addr < 0x8000u || addr >= 0xA000u) return {};
				off = static_cast<eng::usize>(bank_) * 0x2000u + (addr - 0x8000u);
			} else if (win_ == 1) {
				if (addr < 0xA000u || addr >= 0xC000u) return {};
				off = static_cast<eng::usize>(bank_) * 0x2000u + (addr - 0xA000u);
			} else if (win_ == 2) {
				if (addr < 0xC000u || addr >= 0xE000u) return {};
				off = static_cast<eng::usize>(bank_) * 0x2000u + (addr - 0xC000u);
			} else {
				if (addr < 0xE000u) return {};
				off = (n8 >= 1u ? n8 - 1u : 0u) * 0x2000u + (addr - 0xE000u);
			}
		} else if (mapper_ == 2 || mapper_ == 1) {
			// UxROM (2) y MMC1 (1) en modo 16K con banco conmutable en $8000: misma
			// forma de ventanas (conmutable $8000-$BFFF + último banco fijo $C000-$FFFF).
			if (bank_ >= 0) {
				// Análisis de un banco conmutable: solo se resuelve $8000-$BFFF.
				if (addr < 0x8000u || addr >= 0xC000u) {
					return {};
				}
				off = static_cast<eng::usize>(bank_) * 0x4000u +
				      static_cast<eng::usize>(addr - 0x8000u);
			} else if (addr < 0xC000u) {
				return {}; // ventana conmutable: la cubre el fallback del runtime (B1a)
			} else {
				const eng::usize last = prg_size_ >= 0x4000u ? prg_size_ - 0x4000u : 0u;
				off = last + static_cast<eng::usize>(addr - 0xC000u);
			}
		} else {
			off = static_cast<eng::usize>(addr - 0x8000u);
			if (prg_size_ == 16384u) {
				off &= 0x3FFFu;
			}
		}
		if (off >= prg_.size()) {
			return {};
		}
		return off;
	}

	/// Lee el byte de la PRG-ROM en la dirección 6502 `addr` (vacío si no es PRG).
	[[nodiscard]] eng::util::Optional<eng::u8> read_byte(eng::u16 addr) const {
		const auto off = prg_offset(addr);
		if (!off) {
			return {};
		}
		return prg_[*off];
	}

	/// Lee la palabra little-endian de la PRG-ROM en `addr` (vacío si falta algún byte).
	[[nodiscard]] eng::util::Optional<eng::u16> read_word(eng::u16 addr) const {
		const auto lo = read_byte(addr);
		const auto hi = read_byte(static_cast<eng::u16>(addr + 1u));
		if (!lo || !hi) {
			return {};
		}
		return static_cast<eng::u16>(*lo | (static_cast<eng::u16>(*hi) << 8));
	}

	/// Apila una dirección de entrada si cae en la PRG (`>= $8000`).
	void push_work(eng::u16 addr) {
		if (addr >= 0x8000u) {
			(void)worklist_.push_back(addr);
		}
	}
	/// Apila el destino resuelto de `in`, si lo tiene.
	void push_target(const Instruction& in) {
		if (has_target(in)) {
			push_work(in.target);
		}
	}
	/// Marca `addr` como líder (si tiene instrucción y aún no lo era).
	void mark_leader(eng::u16 addr) {
		if (leaders_[addr] == 0u && has_instr_[addr] != 0u) {
			leaders_[addr] = 1u;
			++block_count_;
		}
	}

	// --- Codegen ---

	/// Sufijo del método de `CPU` según el modo de direccionamiento
	/// (`_imm`, `_zp`, `_absx`, …). \return Cadena estática; `""` para modos sin sufijo.
	[[nodiscard]] static const char* mode_suffix(AddrMode mode) noexcept {
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

	/// Escribe en `out` el **nombre del método** de `CPU` para `info`:
	/// mnemónico + sufijo de modo; los desplazamientos implícitos añaden `_A` y
	/// los `NOP` usan un nombre por modo (`NOP_imm`, `NOP_abs`…).
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

	/// Escribe el **argumento** de la llamada (`0xNN` o `0xNNNN`) según la anchura
	/// del modo: 2 dígitos para inmediatos/página cero/indX/indY y 4 para absolutos.
	static void append_arg(Dyn& out, const Instruction& in, const OpcodeInfo& info) {
		out.append("0x");
		const bool narrow = (info.mode == AddrMode::Imm || info.mode == AddrMode::Zp ||
				     info.mode == AddrMode::ZpX || info.mode == AddrMode::ZpY ||
				     info.mode == AddrMode::IndX || info.mode == AddrMode::IndY);
		out.append_hex(in.operand, narrow ? 2u : 4u, true);
	}

	/// Escribe el comentario `// $ADDR: MNEMONICO $OPERANDO` al final de una línea
	/// generada, para que el `.cpp` se lea como el desensamblador.
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

	/// Condición C++ del flag que prueba una rama (`BNE` → `!cpu.Z`, …).
	/// \return Cadena estática con la expresión; `"false"` si no es una rama conocida.
	[[nodiscard]] static const char* branch_cond(const char* mnemonic) noexcept {
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

	/// Escribe una referencia a etiqueta (`prefijo` + 4 dígitos hex).
	static void append_label_ref(Dyn& out, eng::u16 addr, const char* prefix = "L_") {
		out.append(prefix);
		out.append_hex(addr, 4u, true);
	}

	/// Escribe el **nombre de función** de un basic block: `bb_XXXX` para la
	/// ventana fija (`bank < 0`) o `bbB<banco>_XXXX` para un banco conmutable.
	static void append_block_name(Dyn& out, int bank, eng::u16 addr) {
		out.append("bb");
		if (bank >= 0) {
			out.append('B');
			out.append_s32(bank);
			out.append('_');
		} else {
			out.append('_');
		}
		out.append_hex(addr, 4u, true);
	}

	/// \return `true` si `a` es un **inicio de bloque** decodificado (destino válido
	/// para encadenar con una llamada directa `bb_XXXX(cpu)`).
	[[nodiscard]] bool is_block(eng::u16 a) const noexcept {
		return a < kSpace && has_instr_[a] != 0u && leaders_[a] != 0u;
	}

	/// \return `true` si el bloque que empieza en `start` **lee el estado del PPU**
	/// (`$2002`), señal de un bucle de espera de VBlank/sprite-0. Con `--chain` estos
	/// bucles **ceden** al runtime (`cpu.yield = true; return;`) en vez de encadenarse
	/// consigo mismos, para que el runtime pueda avanzar el PPU/NMI.
	[[nodiscard]] bool block_reads_ppu_status(eng::u16 start) const noexcept {
		eng::u16 pc = start;
		for (;;) {
			if (has_instr_[pc] == 0u || (pc != start && leaders_[pc] != 0u)) {
				break;
			}
			const Instruction& in = instr_[pc];
			const OpcodeInfo& info = kOpcodeTable[in.opcode];
			if (info.mode == AddrMode::Abs && has_operand(in) && in.operand == 0x2002u) {
				return true;
			}
			pc = static_cast<eng::u16>(pc + info.size);
			if (info.mode == AddrMode::Rel || sv_equal(info.mnemonic, "JMP") ||
			    sv_equal(info.mnemonic, "JSR") || sv_equal(info.mnemonic, "RTS") ||
			    sv_equal(info.mnemonic, "RTI") || sv_equal(info.mnemonic, "BRK")) {
				break;
			}
		}
		return false;
	}

	/// \return `true` si el mnemónico escribe `Z`/`N` (carga/ALU/comparación/inc-dec/
	/// desplazamiento/transferencia/PLA/BIT/PLP/RTI). Se usa para el **liveness** local
	/// que suprime escrituras muertas de flags.
	[[nodiscard]] static bool mnemonic_writes_nz(const char* m) noexcept {
		return sv_equal(m, "LDA") || sv_equal(m, "LDX") || sv_equal(m, "LDY") || sv_equal(m, "LAX") ||
		       sv_equal(m, "TAX") || sv_equal(m, "TAY") || sv_equal(m, "TXA") || sv_equal(m, "TYA") ||
		       sv_equal(m, "TSX") || sv_equal(m, "PLA") || sv_equal(m, "AND") || sv_equal(m, "ORA") ||
		       sv_equal(m, "EOR") || sv_equal(m, "ADC") || sv_equal(m, "SBC") || sv_equal(m, "CMP") ||
		       sv_equal(m, "CPX") || sv_equal(m, "CPY") || sv_equal(m, "BIT") || sv_equal(m, "INC") ||
		       sv_equal(m, "DEC") || sv_equal(m, "INX") || sv_equal(m, "INY") || sv_equal(m, "DEX") ||
		       sv_equal(m, "DEY") || sv_equal(m, "ASL") || sv_equal(m, "LSR") || sv_equal(m, "ROL") ||
		       sv_equal(m, "ROR") || sv_equal(m, "DCP") || sv_equal(m, "ISB") || sv_equal(m, "SLO") ||
		       sv_equal(m, "RLA") || sv_equal(m, "SRE") || sv_equal(m, "RRA") || sv_equal(m, "PLP") ||
		       sv_equal(m, "RTI");
	}

	/// **Liveness local** de `Z`/`N`: recorre hacia delante desde `pc` (dentro del bloque
	/// `start`) hasta la primera instrucción que **lee** `Z`/`N` (rama/`PHP` → viven) o que
	/// las **escribe** (→ la escritura de `pc` es muerta). Atravesar el fin de bloque o un
	/// terminador devuelve `false` (conservador: el sucesor puede leerlas).
	/// \return `true` si las dos (`Z` y `N`) escritas por `pc` son **muertas**.
	[[nodiscard]] bool nz_dead_after(eng::u16 start, eng::u16 pc) const {
		eng::u16 p = static_cast<eng::u16>(pc + kOpcodeTable[instr_[pc].opcode].size);
		for (;;) {
			if (p >= kSpace || has_instr_[p] == 0u || (p != start && leaders_[p] != 0u)) {
				return false;
			}
			const OpcodeInfo& info = kOpcodeTable[instr_[p].opcode];
			const char* m = info.mnemonic;
			if (sv_equal(m, "BEQ") || sv_equal(m, "BNE") || sv_equal(m, "BPL") ||
			    sv_equal(m, "BMI") || sv_equal(m, "PHP")) {
				return false; // lectura de Z/N
			}
			if (mnemonic_writes_nz(m)) {
				return true; // escritura de Z/N antes de leerlas
			}
			p = static_cast<eng::u16>(p + info.size);
			if (info.mode == AddrMode::Rel || sv_equal(m, "JMP") || sv_equal(m, "JSR") ||
			    sv_equal(m, "RTS") || sv_equal(m, "RTI") || sv_equal(m, "BRK")) {
				return false;
			}
		}
	}

	/// Escribe la cabecera documentada del fichero generado: qué es, quién lo
	/// compila/ejecuta, en qué contexto y qué recursos necesita. Termina con el
	/// `#include` de `eng/core` que el resto del fichero presupone.
	/// \param out Búfer de salida (se añade al final).
	void emit_header(Dyn& out) const {
		out.append("// ============================================================\n");
		out.append("// Código C++23 generado por nes_transpiler (fase 1; eng/core, sin STL)\n");
		out.append("// ============================================================\n");
		out.append("//\n");
		out.append("// QUÉ ES\n");
		out.append("//   Traducción de la PRG-ROM de una ROM NES (mapper ");
		out.append_s32(mapper_);
		out.append(", ");
		out.append_u32(prg_size_);
		out.append(" bytes de PRG) a basic blocks C++23.\n");
		out.append("//   Cada función bb_XXXX cubre un rango de direcciones 6502 y ejecuta las\n");
		out.append("//   mismas operaciones llamando a los métodos de CPU.\n");
		out.append("//\n");
		out.append("// QUIÉN LO USA / CONTEXTO\n");
		out.append("//   - Lo compila el runtime del nodo (conversion/nes-to-amiga500/runtime/)\n");
		out.append("//     para Amiga 500, o el host para tests.\n");
		out.append("//   - Punto de entrada: game_main(), bucle de despacho por cpu.PC.\n");
		out.append("//   - Los bloques usan CPU (cpu.LDA_abs(...)), único punto de enganche con\n");
		out.append("//     RAM/PPU/APU/mapper (interceptable por la capa HLE).\n");
		out.append("//\n");
		out.append("// RECURSOS\n");
		out.append("//   - Sin memoria dinámica; PRG_ROM es constexpr.\n");
		out.append("//   - Despacho disperso: tablas ordenadas (bloque/ciclos) + búsqueda binaria.\n");
		out.append("//   - Requiere el header del runtime: nes_runtime.hpp.\n");
		out.append("//\n");
		out.append("// VECTORES  Reset=$");
		out.append_hex(reset_, 4u, true);
		out.append("  NMI=$");
		out.append_hex(nmi_, 4u, true);
		out.append("  IRQ=$");
		out.append_hex(irq_, 4u, true);
		out.append("\n// ============================================================\n\n");
		out.append("#include <eng/core/types/types.hpp>\n\n");
		// Traza opcional por instrucción (`--trace`): el que incluya este fichero
		// puede definir `N2A_TRACE(addr)` antes; si no, es un no-op.
		out.append("#ifndef N2A_TRACE\n#define N2A_TRACE(addr) ((void)0)\n#endif\n\n");
	}

	/// Escribe `kPrgSize` y la tabla `PRG_ROM` con los bytes de la PRG, 16 por línea.
	/// El runtime (`NESMemory::read`) las consulta; por eso van antes de su `#include`.
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
		// CHR-ROM y mapper, para que el transpilado sea un **cartucho autocontenido**
		// (lo usa el plugin `.n2x`: PRG para el código, CHR/mapper para la PPU).
		out.append("static constexpr eng::usize kChrSize = ");
		out.append_u32(chr_size_);
		out.append(";\nstatic constexpr eng::u8 CHR_ROM[kChrSize > 0u ? kChrSize : 1u] = {\n");
		const eng::u32 chr_n = chr_size_ != 0u ? chr_size_ : 1u;
		for (eng::u32 i = 0; i < chr_n; ++i) {
			if ((i % 16u) == 0u) {
				out.append("    ");
			}
			out.append("0x");
			out.append_hex(i < chr_size_ ? chr_[i] : 0u, 2u, true);
			out.append(',');
			if ((i % 16u) == 15u || i + 1u == chr_n) {
				out.append('\n');
			} else {
				out.append(' ');
			}
		}
		out.append("};\nstatic constexpr int kMapper = ");
		out.append_s32(mapper_);
		out.append(";\nstatic constexpr int kMirroring = ");
		out.append_s32(mirror_h_ ? 0 : 1); // 0 = horizontal, 1 = vertical
		// Layout de PRG (F9): permite al runtime/plugin saber si hay bancos. En
		// UxROM (B1a) solo se transpila la ventana fija ($C000-$FFFF); la
		// conmutable ($8000-$BFFF) la ejecuta el intérprete leyendo por el mapper.
		out.append(";\nstatic constexpr eng::u32 kPrgBankCount = ");
		out.append_u32(prg_bank_count_);
		out.append(";\nstatic constexpr eng::u32 kPrgBankSize = ");
		out.append_u32(prg_bank_size_);
		out.append(";\nstatic constexpr bool kPrgBanked = ");
		out.append(prg_banked_ ? "true" : "false");
		// MMC1 (1): el modo de ventanas es runtime; el runtime invalida el modelo
		// con `prg_bank = 0xFF` si el juego cambia a un modo no soportado (el
		// plugin entonces cae al intérprete).
		out.append(";\nstatic constexpr bool kPrgModeSensitive = ");
		out.append((mapper_ == 1 || mapper_ == 4 || mapper_ == 5) ? "true" : "false");
		// Límite superior de la ventana conmutable: MMC5 (modo 3) llega a `$FFFF`.
		out.append(";\nstatic constexpr eng::u16 kBankedTop = ");
		out.append(mapper_ == 5 ? "0x10000" : "0xC000");
		out.append(";\nstatic constexpr eng::u8 kMapperKind = ");
		out.append_s32(mapper_);
		out.append(";\n\n");
		// Palabra little-endian (como el 6502) usando palabra del 68000; en big-endian se
		// intercambian los bytes (`ror.w #8`). Compartido por ambos backends.
		out.append("[[nodiscard]] static inline eng::u16 n2a_ld16(const eng::u8* p) {\n");
		out.append("    eng::u16 w; __builtin_memcpy(&w, p, 2u);\n");
		out.append("#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)\n");
		out.append("    w = __builtin_bswap16(w);\n#endif\n    return w;\n}\n");
		out.append("static inline void n2a_st16(eng::u8* p, eng::u16 w) {\n");
		out.append("#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)\n");
		out.append("    w = __builtin_bswap16(w);\n#endif\n    __builtin_memcpy(p, &w, 2u);\n}\n\n");
	}

	/// Con `--fast-ram`, emite la instrucción de **zero-page** con acceso directo a
	/// `cpu.mem->ram[...]` (sin la llamada al método ni el `switch` de región de
	/// `mem->read`), que en 68000 es notablemente más rápido. Solo cubre los
	/// opcodes de carga/almacén/ALU/CMP en modo `Zp` (dirección `$00-$FF`).
	/// \param out Salida.
	/// \param in Instrucción (modo `Zp`).
	/// \return `true` si se emitió en línea; `false` para usar el método normal.
	[[nodiscard]] bool emit_zp_inline(Dyn& out, const Instruction& in) const {
		const char* m = kOpcodeTable[in.opcode].mnemonic;
		// Código de operación (0 = no soportado).
		int op = -1;
		if (sv_equal(m, "LDA")) op = 0;
		else if (sv_equal(m, "LDX")) op = 1;
		else if (sv_equal(m, "LDY")) op = 2;
		else if (sv_equal(m, "STA")) op = 3;
		else if (sv_equal(m, "STX")) op = 4;
		else if (sv_equal(m, "STY")) op = 5;
		else if (sv_equal(m, "ADC")) op = 6;
		else if (sv_equal(m, "SBC")) op = 7;
		else if (sv_equal(m, "AND")) op = 8;
		else if (sv_equal(m, "ORA")) op = 9;
		else if (sv_equal(m, "EOR")) op = 10;
		else if (sv_equal(m, "CMP")) op = 11;
		else if (sv_equal(m, "CPX")) op = 12;
		else if (sv_equal(m, "CPY")) op = 13;
		else if (sv_equal(m, "ASL")) op = 14;
		else if (sv_equal(m, "LSR")) op = 15;
		else if (sv_equal(m, "ROL")) op = 16;
		else if (sv_equal(m, "ROR")) op = 17;
		else if (sv_equal(m, "INC")) op = 18;
		else if (sv_equal(m, "DEC")) op = 19;
		if (op < 0) {
			return false;
		}
		const eng::u8 a = static_cast<eng::u8>(in.operand);
		// Acceso directo a la RAM emulada por el puntero cacheado `n2a_ram`
		// (declarado al entrar en el bloque): evita recargar `cpu.mem` en cada acceso.
		auto ram = [&]() {
			out.append("n2a_ram[0x");
			out.append_hex(a, 2u, true);
			out.append(']');
		};
		out.append("    ");
		switch (op) {
		case 0: out.append("cpu.A = "); ram(); if (cur_nz_live_) out.append("; cpu.set_nz(cpu.A)"); out.append(";"); break;
		case 1: out.append("cpu.X = "); ram(); if (cur_nz_live_) out.append("; cpu.set_nz(cpu.X)"); out.append(";"); break;
		case 2: out.append("cpu.Y = "); ram(); if (cur_nz_live_) out.append("; cpu.set_nz(cpu.Y)"); out.append(";"); break;
		case 3: ram(); out.append(" = cpu.A;"); break;
		case 4: ram(); out.append(" = cpu.X;"); break;
		case 5: ram(); out.append(" = cpu.Y;"); break;
		case 6: out.append("cpu.ADC_impl("); ram(); out.append(");"); break;
		case 7: out.append("cpu.SBC_impl("); ram(); out.append(");"); break;
		case 8: if (cur_nz_live_) { out.append("cpu.AND_impl("); ram(); out.append(");"); }
			else { out.append("cpu.A = static_cast<eng::u8>(cpu.A & "); ram(); out.append(");"); } break;
		case 9: if (cur_nz_live_) { out.append("cpu.ORA_impl("); ram(); out.append(");"); }
			else { out.append("cpu.A = static_cast<eng::u8>(cpu.A | "); ram(); out.append(");"); } break;
		case 10: if (cur_nz_live_) { out.append("cpu.EOR_impl("); ram(); out.append(");"); }
			else { out.append("cpu.A = static_cast<eng::u8>(cpu.A ^ "); ram(); out.append(");"); } break;
		case 11: out.append("cpu.CMP_impl(cpu.A, "); ram(); out.append(");"); break;
		case 12: out.append("cpu.CMP_impl(cpu.X, "); ram(); out.append(");"); break;
		case 13: out.append("cpu.CMP_impl(cpu.Y, "); ram(); out.append(");"); break;
		// RMW/desplazamientos en zero-page: lectura + operación + escritura directas,
		// sin las dos llamadas a `read`/`write` (caliente en PRNG/bucles de la NES).
		case 14: out.append("{ eng::u8 n2a_v = "); ram();
			out.append("; cpu.C = (n2a_v & 0x80u) != 0u; n2a_v = static_cast<eng::u8>(n2a_v << 1u); ");
			ram(); out.append(" = n2a_v; cpu.set_nz(n2a_v); }"); break;
		case 15: out.append("{ eng::u8 n2a_v = "); ram();
			out.append("; cpu.C = (n2a_v & 1u) != 0u; n2a_v = static_cast<eng::u8>(n2a_v >> 1u); ");
			ram(); out.append(" = n2a_v; cpu.set_nz(n2a_v); }"); break;
		case 16: out.append("{ eng::u8 n2a_v = "); ram();
			out.append("; const eng::u8 n2a_c = cpu.C ? 1u : 0u; cpu.C = (n2a_v & 0x80u) != 0u; ");
			out.append("n2a_v = static_cast<eng::u8>((n2a_v << 1u) | n2a_c); ");
			ram(); out.append(" = n2a_v; cpu.set_nz(n2a_v); }"); break;
		case 17: out.append("{ eng::u8 n2a_v = "); ram();
			out.append("; const eng::u8 n2a_c = cpu.C ? 1u : 0u; cpu.C = (n2a_v & 1u) != 0u; ");
			out.append("n2a_v = static_cast<eng::u8>((n2a_v >> 1u) | (n2a_c << 7u)); ");
			ram(); out.append(" = n2a_v; cpu.set_nz(n2a_v); }"); break;
		case 18: out.append("{ eng::u8 n2a_v = static_cast<eng::u8>("); ram();
			out.append(" + 1u); "); ram(); out.append(" = n2a_v; cpu.set_nz(n2a_v); }"); break;
		default: out.append("{ eng::u8 n2a_v = static_cast<eng::u8>("); ram();
			out.append(" - 1u); "); ram(); out.append(" = n2a_v; cpu.set_nz(n2a_v); }"); break;
		}
		return true;
	}

	/// Con `--rom-direct`, emite una **lectura directa de `PRG_ROM`** para las
	/// instrucciones de **carga/ALU/CMP** cuyo operando efectivo (modo `Abs`/`AbsX`/
	/// `AbsY`) cae en la ventana fija de ROM y el mapper tiene la PRG **fija**
	/// (NROM/CNROM). Sustituye `cpu.METODO(dir)` (que en el runtime hace el `switch`
	/// de región y `idx % prg_size`) por `PRG_ROM[índice]` — datos `constexpr` que el
	/// compilador puede plegar o indexar directamente.
	///
	/// El índice replica el mapeo del bus: `((operando - $8000) + X/Y) & (prg_size-1)`
	/// (potencia de dos). Solo es válido para `prg_size` potencia de dos; en otro caso
	/// cae al método normal.
	///
	/// \param out Salida.
	/// \param in Instrucción (modo `Abs`/`AbsX`/`AbsY` con operando en `$8000-$FFFF`).
	/// \return `true` si se emitió en línea; `false` para usar el método normal.
	[[nodiscard]] bool emit_rom_inline(Dyn& out, const Instruction& in) const {
		if (!rom_direct_ || prg_banked_ || prg_size_ == 0u) {
			return false;
		}
		if ((prg_size_ & (prg_size_ - 1u)) != 0u) {
			return false; // no es potencia de dos: el módulo no es máscara
		}
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		if (info.mode != AddrMode::Abs && info.mode != AddrMode::AbsX && info.mode != AddrMode::AbsY) {
			return false;
		}
		if (!has_operand(in) || in.operand < 0x8000u) {
			return false;
		}
		const char* m = info.mnemonic;
		int op = -1;
		if (sv_equal(m, "LDA")) op = 0;
		else if (sv_equal(m, "LDX")) op = 1;
		else if (sv_equal(m, "LDY")) op = 2;
		else if (sv_equal(m, "ADC")) op = 3;
		else if (sv_equal(m, "SBC")) op = 4;
		else if (sv_equal(m, "AND")) op = 5;
		else if (sv_equal(m, "ORA")) op = 6;
		else if (sv_equal(m, "EOR")) op = 7;
		else if (sv_equal(m, "CMP")) op = 8;
		else if (sv_equal(m, "CPX")) op = 9;
		else if (sv_equal(m, "CPY")) op = 10;
		if (op < 0) {
			return false;
		}
		const eng::u32 mask = prg_size_ - 1u;
		const eng::u32 base = (static_cast<eng::u32>(in.operand) - 0x8000u) & mask;
		// **Dirección absoluta** (sin índice): el byte es una **constante de compilación**
		// (PRG fija, no bancada). Se emite como **inmediato** para que g++ lo pliegue: la
		// carga puede desaparecer y las operaciones con ella resolverse en compile-time.
		if (info.mode == AddrMode::Abs) {
			const eng::u8 val = prg_[base];
			// Sin Z/N vivas: emisión directa (la carga/operación no actualiza flags).
			if (!cur_nz_live_ && (op == 0 || op == 1 || op == 2 || op == 5 || op == 6 || op == 7)) {
				out.append("    cpu.");
				if (op == 0 || op == 5 || op == 6 || op == 7) {
					out.append("A = ");
					if (op >= 5) {
						out.append("static_cast<eng::u8>(cpu.A ");
						out.append(op == 5 ? "&" : op == 6 ? "|" : "^");
						out.append(" 0x");
					} else {
						out.append("0x");
					}
					out.append_hex(val, 2u, true);
					out.append(op >= 5 ? ");" : ";");
				} else {
					out.append(op == 1 ? "X = 0x" : "Y = 0x");
					out.append_hex(val, 2u, true);
					out.append(";");
				}
				return true;
			}
			out.append("    cpu.");
			switch (op) {
			case 0: out.append("LDA_imm"); break;
			case 1: out.append("LDX_imm"); break;
			case 2: out.append("LDY_imm"); break;
			case 3: out.append("ADC_imm"); break;
			case 4: out.append("SBC_imm"); break;
			case 5: out.append("AND_imm"); break;
			case 6: out.append("ORA_imm"); break;
			case 7: out.append("EOR_imm"); break;
			case 8: out.append("CMP_imm"); break;
			case 9: out.append("CPX_imm"); break;
			default: out.append("CPY_imm"); break;
			}
			out.append("(0x");
			out.append_hex(val, 2u, true);
			out.append(");");
			return true;
		}
		// Expresión del índice dentro de PRG_ROM.
		auto rom = [&]() {
			out.append("n2a_prg[");
			if (info.mode == AddrMode::Abs) {
				out.append("0x");
				out.append_hex(base, 4u, true);
				out.append("u");
			} else {
				out.append("(0x");
				out.append_hex(base, 4u, true);
				out.append("u + cpu.");
				out.append(info.mode == AddrMode::AbsX ? "X" : "Y");
				out.append(") & 0x");
				out.append_hex(mask, 4u, true);
				out.append("u");
			}
			out.append(']');
		};
		out.append("    ");
		switch (op) {
		case 0: out.append("cpu.A = "); rom(); out.append("; cpu.set_nz(cpu.A);"); break;
		case 1: out.append("cpu.X = "); rom(); out.append("; cpu.set_nz(cpu.X);"); break;
		case 2: out.append("cpu.Y = "); rom(); out.append("; cpu.set_nz(cpu.Y);"); break;
		case 3: out.append("cpu.ADC_impl("); rom(); out.append(");"); break;
		case 4: out.append("cpu.SBC_impl("); rom(); out.append(");"); break;
		case 5: out.append("cpu.AND_impl("); rom(); out.append(");"); break;
		case 6: out.append("cpu.ORA_impl("); rom(); out.append(");"); break;
		case 7: out.append("cpu.EOR_impl("); rom(); out.append(");"); break;
		case 8: out.append("cpu.CMP_impl(cpu.A, "); rom(); out.append(");"); break;
		case 9: out.append("cpu.CMP_impl(cpu.X, "); rom(); out.append(");"); break;
		default: out.append("cpu.CMP_impl(cpu.Y, "); rom(); out.append(");"); break;
		}
		return true;
	}

	/// Idioms multibyte **del backend por bloques** (`--chain` + `--fast-ram` +
	/// `--no-cycles`): mismos patrones que el nativo pero emitiendo sobre `cpu` y el
	/// puntero `n2a_ram`. Mantiene la semántica de flags del 6502.
	/// \return `true` si se emitió (y actualizó `next`).
	[[nodiscard]] bool try_chain_multibyte(Dyn& out, eng::u16 p, eng::u16& next) const {
		const auto at = [&](eng::u16 a) -> const Instruction* {
			return (a < kSpace && has_instr_[a] != 0u) ? &instr_[a] : nullptr;
		};
		const auto mn = [&](const Instruction* in) -> const char* {
			return (in != nullptr) ? kOpcodeTable[in->opcode].mnemonic : "";
		};
		// `true` + offset si `in` es RAM de dirección constante (zp, o abs < $2000).
		const auto ramoff = [&](const Instruction* in, eng::u16& off) -> bool {
			if (in == nullptr) {
				return false;
			}
			const OpcodeInfo& fi = kOpcodeTable[in->opcode];
			if (fi.mode == AddrMode::Zp) {
				off = static_cast<eng::u8>(in->operand);
				return true;
			}
			if (fi.mode == AddrMode::Abs && in->operand < 0x2000u) {
				off = static_cast<eng::u16>(in->operand & 0x7FFu);
				return true;
			}
			return false;
		};
		const auto immv = [&](const Instruction* in, eng::u8& v) -> bool {
			if (in == nullptr || kOpcodeTable[in->opcode].mode != AddrMode::Imm) {
				return false;
			}
			v = static_cast<eng::u8>(in->operand);
			return true;
		};
		const auto hx = [&](eng::u8 v) {
			out.append("0x");
			out.append_hex(v, 2u, true);
			out.append("u");
		};
		const auto hxo = [&](eng::u16 v) {
			out.append("0x");
			out.append_hex(v, 4u, true);
			out.append("u");
		};
		const auto ram = [&](eng::u16 off) {
			out.append("n2a_ram[");
			hxo(off);
			out.append("]");
		};
		const auto ld16 = [&](eng::u16 off) {
			out.append("n2a_ld16(&n2a_ram[");
			hxo(off);
			out.append("])");
		};
		const Instruction* i0 = at(p);
		if (i0 == nullptr) {
			return false;
		}
		const Instruction* i1 = at(static_cast<eng::u16>(p + 2u));
		const Instruction* i2 = at(static_cast<eng::u16>(p + 4u));
		const Instruction* i3 = at(static_cast<eng::u16>(p + 6u));
		// --- Copia 16 bits: LDA/STA ×2 sobre RAM (zp o abs) ---
		{
			eng::u16 a = 0, c = 0, a1 = 0, c1 = 0;
			if (sv_equal(mn(i0), "LDA") && sv_equal(mn(i1), "STA") &&
			    sv_equal(mn(i2), "LDA") && sv_equal(mn(i3), "STA") && ramoff(i0, a) &&
			    ramoff(i1, c) && ramoff(i2, a1) && ramoff(i3, c1) &&
			    a1 == static_cast<eng::u16>(a + 1u) && c1 == static_cast<eng::u16>(c + 1u)) {
				out.append("    { eng::u16 n2a_w; __builtin_memcpy(&n2a_w, &");
				ram(a);
				out.append(", 2u); __builtin_memcpy(&");
				ram(c);
				out.append(", &n2a_w, 2u); cpu.A = ");
				ram(a1);
				out.append("; cpu.set_nz(cpu.A); }\n");
				next = static_cast<eng::u16>(p + 8u);
				return true;
			}
		}
		// --- Constante 16 bits ---
		{
			eng::u8 k0 = 0, k1 = 0;
			eng::u16 c = 0, c1 = 0;
			if (sv_equal(mn(i0), "LDA") && immv(i0, k0) && sv_equal(mn(i2), "LDA") &&
			    immv(i2, k1) && sv_equal(mn(i1), "STA") && ramoff(i1, c) &&
			    sv_equal(mn(i3), "STA") && ramoff(i3, c1) &&
			    c1 == static_cast<eng::u16>(c + 1u)) {
				ram(c);
				out.append(" = ");
				hx(k0);
				out.append("; ");
				ram(c1);
				out.append(" = ");
				hx(k1);
				out.append("; cpu.A = ");
				hx(k1);
				out.append("; cpu.set_nz(cpu.A);\n");
				next = static_cast<eng::u16>(p + 8u);
				return true;
			}
		}
		// --- Comparación 16 bits ---
		{
			eng::u16 a = 0, a1 = 0;
			if (sv_equal(mn(i0), "LDA") && ramoff(i0, a) && sv_equal(mn(i2), "LDA") &&
			    ramoff(i2, a1) && a1 == static_cast<eng::u16>(a + 1u) &&
			    sv_equal(mn(i1), "CMP") && sv_equal(mn(i3), "SBC")) {
				eng::u8 k0 = 0, k1 = 0;
				eng::u16 m0 = 0, m1 = 0;
				const bool cimm = immv(i1, k0);
				const bool simm = immv(i3, k1);
				const bool cram = !cimm && ramoff(i1, m0);
				const bool sram = !simm && ramoff(i3, m1);
				if ((cimm && simm) || (cram && sram && m1 == static_cast<eng::u16>(m0 + 1u))) {
					out.append("    { const eng::u16 n2a_a = ");
					ld16(a);
					out.append("; const eng::u16 n2a_b = ");
					if (cimm) {
						hxo(static_cast<eng::u16>(k0) |
						    (static_cast<eng::u16>(k1) << 8u));
					} else {
						ld16(m0);
					}
					out.append("; const eng::u16 n2a_d = static_cast<eng::u16>(n2a_a - n2a_b); cpu.A = static_cast<eng::u8>(n2a_d >> 8u); cpu.C = (n2a_a >= n2a_b); cpu.Z = (cpu.A == 0u); cpu.N = ((cpu.A & 0x80u) != 0u); }\n");
					next = static_cast<eng::u16>(p + 8u);
					return true;
				}
			}
		}
		// --- Suma/resta 16 bits (SEC/CLC + 6 instrucciones) ---
		if (sv_equal(mn(i0), "CLC") || sv_equal(mn(i0), "SEC")) {
			const auto nx = [&](eng::u16 a) {
				return static_cast<eng::u16>(a + kOpcodeTable[instr_[a].opcode].size);
			};
			const bool add = sv_equal(mn(i0), "CLC");
			const eng::u16 p1 = nx(p);
			const Instruction* j1 = at(p1);
			eng::u16 a = 0;
			if (sv_equal(mn(j1), "LDA") && ramoff(j1, a)) {
				const eng::u16 p2 = nx(p1);
				const eng::u16 p3 = nx(p2);
				const eng::u16 p4 = nx(p3);
				const eng::u16 p5 = nx(p4);
				const eng::u16 p6 = nx(p5);
				const Instruction* j2 = at(p2);
				const Instruction* j3 = at(p3);
				const Instruction* j4 = at(p4);
				const Instruction* j5 = at(p5);
				const Instruction* j6 = at(p6);
				eng::u16 a1 = 0, c = 0, c1 = 0;
				if (sv_equal(mn(j2), add ? "ADC" : "SBC") && sv_equal(mn(j3), "STA") &&
				    ramoff(j3, c) && sv_equal(mn(j4), "LDA") && ramoff(j4, a1) &&
				    a1 == static_cast<eng::u16>(a + 1u) &&
				    sv_equal(mn(j5), add ? "ADC" : "SBC") && sv_equal(mn(j6), "STA") &&
				    ramoff(j6, c1) && c1 == static_cast<eng::u16>(c + 1u)) {
					eng::u8 k0 = 0, k1 = 0;
					eng::u16 m0 = 0, m1 = 0;
					const bool imm0 = immv(j2, k0);
					const bool imm1 = immv(j5, k1);
					const bool r0 = !imm0 && ramoff(j2, m0);
					const bool r1 = !imm1 && ramoff(j5, m1);
					if ((imm0 && imm1) || (r0 && r1 && m1 == static_cast<eng::u16>(m0 + 1u))) {
						out.append("    { const eng::u16 n2a_x = ");
						ld16(a);
						out.append("; const eng::u16 n2a_y = ");
						if (imm0) {
							hxo(static_cast<eng::u16>(k0) |
							    (static_cast<eng::u16>(k1) << 8u));
						} else {
							ld16(m0);
						}
						out.append("; const eng::u8 n2a_ah = static_cast<eng::u8>(n2a_x >> 8u), n2a_bh = static_cast<eng::u8>(n2a_y >> 8u);");
						if (add) {
							out.append(" const eng::u32 n2a_s = static_cast<eng::u32>(n2a_x) + n2a_y; const eng::u16 n2a_r = static_cast<eng::u16>(n2a_s); n2a_st16(&");
							ram(c);
							out.append(", n2a_r); cpu.C = (n2a_s > 0xFFFFu); const eng::u8 n2a_h = static_cast<eng::u8>(n2a_r >> 8u); cpu.V = (((n2a_ah ^ n2a_h) & (n2a_bh ^ n2a_h) & 0x80u) != 0u); cpu.A = n2a_h; cpu.Z = (n2a_h == 0u); cpu.N = ((n2a_h & 0x80u) != 0u); }\n");
						} else {
							out.append(" const eng::u32 n2a_s = static_cast<eng::u32>(n2a_x) - n2a_y; const eng::u16 n2a_r = static_cast<eng::u16>(n2a_s); n2a_st16(&");
							ram(c);
							out.append(", n2a_r); cpu.C = (n2a_x >= n2a_y); const eng::u8 n2a_h = static_cast<eng::u8>(n2a_r >> 8u), n2a_nbh = static_cast<eng::u8>(~n2a_bh); cpu.V = (((n2a_ah ^ n2a_h) & (n2a_nbh ^ n2a_h) & 0x80u) != 0u); cpu.A = n2a_h; cpu.Z = (n2a_h == 0u); cpu.N = ((n2a_h & 0x80u) != 0u); }\n");
						}
						next = nx(p6);
						return true;
					}
				}
			}
		}
		return false;
	}

	/// Traduce una instrucción a una o varias líneas de C++.
	///
	/// Casos especiales:
	/// - Ramas y `JMP` absoluto con destino **en el mismo bloque** → `goto L_xxxx`.
	/// - Los mismos con destino en **otro bloque** → `cpu.PC = destino; return;`
	///   (vuelve al despachador, porque la etiqueta no cruza funciones).
	/// - `JMP (ind)` → `cpu.JMP_ind(...)`: el destino se conoce en ejecución.
	/// - `JSR` → `cpu.JSR_abs(destino, retorno)`: apila la dirección de regreso.
	/// - `RTS`/`RTI`/`BRK` → método de `CPU` seguido de `return`.
	/// - Resto → `cpu.METODO(arg);` con un comentario con la instrucción original.
	///
	/// \param in          Instrucción a emitir.
	/// \param block_start Dirección de inicio del bloque (para decidir `goto`).
	void emit_one_instruction(Dyn& out, const Instruction& in, eng::u16 block_start) const {
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		const char* m = info.mnemonic;

		if (trace_) {
			out.append("    N2A_TRACE(0x");
			out.append_hex(in.addr, 4u, true);
			out.append(");\n");
		}

		// Las ramas y `JMP` **siempre** vuelven al despacho (`cpu.PC = destino;
		// return;`), sin `goto` interno: así el runtime puede avanzar la PPU entre
		// bloques y no se cuelga en un bucle de espera de VBlank. `block_start` ya
		// no decide nada aquí (se conserva el parámetro por uniformidad).
		(void)block_start;
		// Coste exacto en `cpu.cycles`: base + penalización de página/rama, igual
		// que el intérprete del runtime. El runtime lee el delta por bloque.
		// Con `--no-cycles` (Amiga, sin PPU ciclo-exacta) **no se emite nada**: ahorra
		// una operación por instrucción (clave en 68000).
		auto emit_base = [&]() {
			if (no_cycles_) {
				return;
			}
			// Ciclos base **y** avance de PPU por acceso: el acceso a datos (p. ej.
			// leer `$2002`) ve la PPU en el mismo ciclo que el intérprete. El host
			// no re-reloja el bloque (`NesSystem::fast_ticks`).
			out.append("    cpu.cycles += ");
			out.append_u32(op_base_cycles(in.opcode));
			out.append("u; cpu.mem->tick(");
			out.append_u32(op_base_cycles(in.opcode));
			out.append(");\n");
		};

		if (info.mode == AddrMode::Rel) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			emit_base();
			out.append("    if (");
			out.append(branch_cond(m));
			out.append(") {");
			if (!no_cycles_) {
				out.append(" cpu.cycles += 1u; cpu.mem->tick(1);");
				// Cruce de página de la rama: `pc+2` vs destino (estático).
				if (((in.addr + 2u) & 0xFF00u) != (in.target & 0xFF00u)) {
					out.append(" cpu.cycles += 1u; cpu.mem->tick(1);");
				}
			}
			if (chain_ && !prg_banked_ && in.target == block_start &&
			    block_reads_ppu_status(block_start)) {
				// Bucle de espera de VBlank/sprite-0: cede al runtime en vez de
				// encadenarse consigo mismo (el runtime avanza el PPU/NMI y
				// re-despacha en `PC`).
				out.append(" cpu.yield = true; cpu.PC = 0x");
				out.append_hex(block_start, 4u, true);
				out.append("; return; }\n");
			} else if (chain_ && !prg_banked_ && is_block(in.target)) {
				// Encadenado: la rama tomada llama en cola al bloque destino.
				out.append(" return ");
				append_block_name(out, cur_bank_, in.target);
				out.append("(cpu); }\n");
			} else {
				out.append(" cpu.PC = 0x");
				out.append_hex(in.target, 4u, true);
				out.append("; return; }\n");
			}
			emit_yield(out, in, info); // fall-through (rama no tomada)
			return;
		}
		if (sv_equal(m, "JMP") && info.mode == AddrMode::Abs) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			emit_base();
			if (chain_ && !prg_banked_ && in.target == block_start) {
				// `JMP a sí mismo`: espera de NMI; cede al runtime.
				out.append("    cpu.yield = true; cpu.PC = 0x");
				out.append_hex(block_start, 4u, true);
				out.append("; return;\n");
			} else if (chain_ && !prg_banked_ && is_block(in.target)) {
				out.append("    return ");
				append_block_name(out, cur_bank_, in.target);
				out.append("(cpu);\n");
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
			out.append('\n');
			emit_base();
			out.append("    cpu.JMP_ind(0x");
			out.append_hex(in.operand, 4u, true);
			out.append("); return;\n");
			return;
		}
		if (sv_equal(m, "JSR")) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			emit_base();
			const eng::u16 ret3 = static_cast<eng::u16>(in.addr + 3u); // primer byte tras el JSR
			if (chain_ && !prg_banked_ && is_block(in.target) && is_block(ret3)) {
				// Encadenado: llamada C al subbloque y continuación directa en el
				// retorno. Se apila `PC+2` (fidelidad de pila); el `RTS` encadenado
				// solo descarta el valor y devuelve por la pila C.
				out.append("    cpu.push16(0x");
				out.append_hex(static_cast<eng::u16>(in.addr + 2u), 4u, true);
				out.append("u); ");
				append_block_name(out, cur_bank_, in.target);
				out.append("(cpu); if (cpu.yield) return; return ");
				append_block_name(out, cur_bank_, ret3);
				out.append("(cpu);\n");
			} else {
				out.append("    cpu.JSR_abs(0x");
				out.append_hex(in.target, 4u, true);
				// Convención del intérprete: se apila `PC+2` (dirección del último byte
				// del JSR) y `RTS` suma 1; así el retorno es consistente con el fallback.
				out.append(", 0x");
				out.append_hex(static_cast<eng::u16>(in.addr + 2u), 4u, true);
				out.append("); return;\n");
			}
			return;
		}
		if (sv_equal(m, "RTS") || sv_equal(m, "RTI") || sv_equal(m, "BRK")) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			emit_base();
			if (sv_equal(m, "RTS") && chain_ && !prg_banked_) {
				// Encadenado: `RTS` descarta el valor apilado y devuelve al sitio de
				// la llamada C (el bloque `JSR` encadena al retorno).
				out.append("    cpu.pull16(); return;\n");
				return;
			}
			if (sv_equal(m, "BRK")) {
				// `CPU::BRK` empuja `PC+2`; el bloque **no mantiene el PC por
				// instrucción**, así que hay que fijar el PC real de esta `BRK`
				// antes de llamarla (si no, se apila una dirección de retorno
				// incorrecta cuando `BRK` no es la 1ª instrucción del bloque).
				out.append("    cpu.PC = 0x");
				out.append_hex(in.addr, 4u, true);
				out.append(";\n");
			}
			out.append("    cpu.");
			out.append(m);
			out.append("(); return;\n");
			return;
		}
		// Instrucción corriente: ciclos (+ penalización si lectura indexada) y
		// llamada al método de CPU con su comentario.
		emit_base();
		if (!no_cycles_ && op_read_indexed_penalty(in.opcode)) {
			if (info.mode == AddrMode::AbsX) {
				out.append("    if (((0x");
				out.append_hex(static_cast<eng::u16>(in.operand & 0xFFu), 2u, true);
				out.append("u) + cpu.X) > 0xFFu) { cpu.cycles += 1u; cpu.mem->tick(1); }\n");
			} else if (info.mode == AddrMode::AbsY) {
				out.append("    if (((0x");
				out.append_hex(static_cast<eng::u16>(in.operand & 0xFFu), 2u, true);
				out.append("u) + cpu.Y) > 0xFFu) { cpu.cycles += 1u; cpu.mem->tick(1); }\n");
			} else if (info.mode == AddrMode::IndY) {
				out.append("    { const eng::u16 p = static_cast<eng::u16>(cpu.mem->read(0x");
				out.append_hex(in.operand, 4u, true);
				out.append(") | (static_cast<eng::u16>(cpu.mem->read(0x");
				out.append_hex(static_cast<eng::u16>(in.operand + 1u), 4u, true);
				out.append(")) << 8u)); if (((p & 0xFFu) + cpu.Y) > 0xFFu) { cpu.cycles += 1u; cpu.mem->tick(1); } }\n");
			}
		}
		bool handled = false;
		if (rom_direct_) {
			handled = emit_rom_inline(out, in); // lectura directa de PRG_ROM (datos fijos)
		}
		if (!handled && fast_ram_ && info.mode == AddrMode::Zp && has_operand(in)) {
			handled = emit_zp_inline(out, in); // acceso directo a zero-page
		}
		// Inmediatas con Z/N muertas (liveness): carga/operación directa sin `set_nz`.
		if (!handled && !cur_nz_live_ && info.mode == AddrMode::Imm && has_operand(in)) {
			const eng::u8 v = static_cast<eng::u8>(in.operand);
			if (sv_equal(m, "LDA")) {
				out.append("    cpu.A = 0x"); out.append_hex(v, 2u, true); out.append(";"); handled = true;
			} else if (sv_equal(m, "LDX")) {
				out.append("    cpu.X = 0x"); out.append_hex(v, 2u, true); out.append(";"); handled = true;
			} else if (sv_equal(m, "LDY")) {
				out.append("    cpu.Y = 0x"); out.append_hex(v, 2u, true); out.append(";"); handled = true;
			} else if (sv_equal(m, "AND") || sv_equal(m, "ORA") || sv_equal(m, "EOR")) {
				out.append("    cpu.A = static_cast<eng::u8>(cpu.A ");
				out.append(sv_equal(m, "AND") ? "&" : sv_equal(m, "ORA") ? "|" : "^");
				out.append(" 0x"); out.append_hex(v, 2u, true); out.append(");"); handled = true;
			}
		}
		if (!handled) {
			out.append("    cpu.");
			append_method_name(out, info);
			out.append('(');
			if (has_operand(in)) {
				append_arg(out, in, info);
			}
			out.append(')');
			out.append(';');
		}
		append_comment(out, in, info);
		out.append('\n');
		emit_yield(out, in, info);
	}

	/// Emite el **yield por deadline**: si el bloque cruzó el próximo evento del PPU
	/// (`cpu.cycles >= cpu.deadline`), guarda el **PC estático** de la instrucción
	/// siguiente y vuelve al despacho (el host resuelve NMI/IRQ y la frontera de
	/// frame en esa instrucción exacta). Desactivado con `--no-cycles`.
	void emit_yield(Dyn& out, const Instruction& in, const OpcodeInfo& info) const {
		if (no_cycles_) {
			return;
		}
		out.append("    if (cpu.cycles >= cpu.deadline) { cpu.PC = 0x");
		out.append_hex(static_cast<eng::u16>(in.addr + info.size), 4u, true);
		out.append("; return; }\n");
	}

	/// Escribe en `out` la **ficha** que precede a la función `bb_<start>`.
	///
	/// Recorre el bloque para obtener su longitud y su última instrucción y de ahí
	/// deduce: el rango de direcciones cubierto, cuántas instrucciones contiene,
	/// cómo termina el flujo (cae, salta, llama, retorna, se detiene) y desde
	/// dónde puede entrar la ejecución (reset/NMI/IRQ, rama, `JMP`, `JSR` o
	/// continuación del bloque anterior).
	///
	/// No genera código ni modifica el estado: solo consulta las tablas que dejó
	/// preparadas `compute_block_metadata()`. La invoca `emit_blocks()`, una vez
	/// por cada inicio de bloque.
	///
	/// \param start Dirección 6502 de inicio del bloque (debe ser un líder).
	void emit_block_doc(Dyn& out, eng::u16 start, int bank) const {
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

		out.append("//\n// ");
		append_block_name(out, bank, start);
		out.append(" — bloque 6502 $");
		out.append_hex(start, 4u, true);
		out.append("..$");
		out.append_hex(static_cast<eng::u16>(end - 1u), 4u, true);
		out.append(" (");
		out.append_u32(count);
		out.append(count == 1u ? " instrucción)\n// Qué hace: " : " instrucciones)\n// Qué hace: ");

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
			out.append("ejecuta el tramo y retorna de interrupción (RTI).\n");
		} else if (sv_equal(last->mnemonic, "BRK")) {
			out.append("ejecuta el tramo y detiene la ejecución (BRK).\n");
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
			out.append("continuación del bloque anterior");
			any = true;
		}
		if (!any) {
			out.append("despacho directo por cpu.PC (sin referencias estáticas)");
		}
		out.append(".\n");
		out.append("// Recursos: ninguno propio; usa CPU y su memoria (RAM/PPU/APU/mapper).\n");
	}

	/// Escribe la sección de *basic blocks*: primero las declaraciones anticipadas
	/// de todas las funciones `bb_XXXX` y después cada función precedida de su
	/// ficha (`emit_block_doc`). Dentro del bloque, cada instrucción se traduce con
	/// `emit_one_instruction`; al final se emite la caída al bloque siguiente
	/// (`goto` si es el mismo bloque, o `cpu.PC`/`return` si es otro).
	/// \return `true` si el bloque que empieza en `start` lee la dirección `addr`
	/// como operando de memoria (modos zp/abs y sus indexados).
	[[nodiscard]] bool block_reads(eng::u16 start, eng::u16 addr) const {
		eng::u16 pc = start;
		for (;;) {
			if (has_instr_[pc] == 0u || (pc != start && leaders_[pc] != 0u)) {
				break;
			}
			const Instruction& in = instr_[pc];
			const OpcodeInfo& info = kOpcodeTable[in.opcode];
			const bool mem_mode = info.mode == AddrMode::Zp || info.mode == AddrMode::ZpX ||
					      info.mode == AddrMode::ZpY || info.mode == AddrMode::Abs ||
					      info.mode == AddrMode::AbsX || info.mode == AddrMode::AbsY;
			if (mem_mode && has_operand(in) && in.operand == addr) {
				return true;
			}
			pc = static_cast<eng::u16>(pc + info.size);
			if (info.mode == AddrMode::Rel || sv_equal(info.mnemonic, "JMP") ||
			    sv_equal(info.mnemonic, "JSR") || sv_equal(info.mnemonic, "RTS") ||
			    sv_equal(info.mnemonic, "RTI") || sv_equal(info.mnemonic, "BRK")) {
				break;
			}
		}
		return false;
	}

	/// Emite las suposiciones `N2A_ASSUME(...)` de los hechos (`facts_`) que
	/// afectan al bloque `start`, al principio del cuerpo de la función. Son
	/// pistas para g++: si un hecho no se cumpliera en ejecución, el resultado es
	/// indefinido, así que los hechos deben venir validados por análisis/telemetría.
	void emit_assumptions(Dyn& out, eng::u16 start) const {
		for (eng::usize i = 0; i < facts_.size(); ++i) {
			const Fact& f = facts_[i];
			if (f.kind == FactKind::Hot) {
				continue; // el calor de bloque no es una suposición de valor
			}
			if (!block_reads(start, f.addr)) {
				continue;
			}
			out.append("    N2A_ASSUME(cpu.mem->read(0x");
			out.append_hex(f.addr, 4u, true);
			out.append(')');
			switch (f.kind) {
			case FactKind::Eq:
				out.append(" == 0x");
				out.append_hex(f.values[0], 2u, true);
				break;
			case FactKind::Range:
				out.append(" <= 0x");
				out.append_hex(f.values[1], 2u, true);
				break;
			case FactKind::Set:
				out.append(" == 0x");
				out.append_hex(f.values[0], 2u, true);
				for (eng::u8 k = 1u; k < f.count; ++k) {
					out.append(" || cpu.mem->read(0x");
					out.append_hex(f.addr, 4u, true);
					out.append(") == 0x");
					out.append_hex(f.values[k], 2u, true);
				}
				break;
			case FactKind::Power2:
				out.append(" != 0u && (cpu.mem->read(0x");
				out.append_hex(f.addr, 4u, true);
				out.append(") & (cpu.mem->read(0x");
				out.append_hex(f.addr, 4u, true);
				out.append(") - 1u)) == 0u");
				break;
			case FactKind::Hot:
				break; // ya filtrado arriba; evita el aviso de switch
			}
			out.append(");\n");
		}
	}

	/// Nº de ejecuciones observado para el bloque que empieza en `addr` según un
	/// hecho `Hot` (`--facts`). Permite marcar el bloque `hot`/`cold`.
	/// \param addr Dirección de inicio del bloque.
	/// \return Ejecuciones, o `-1` si no hay dato de calor para ese bloque.
	[[nodiscard]] int hot_count(eng::u16 addr) const {
		for (eng::usize i = 0; i < facts_.size(); ++i) {
			if (facts_[i].kind == FactKind::Hot && facts_[i].addr == addr) {
				return static_cast<int>(facts_[i].heat);
			}
		}
		return -1;
	}

	/// Ciclos **base** estimados de un bloque (suma de `op_base_cycles`, sin
	/// penalizaciones dependientes de datos). Se emite como `n2a_block_cycles`
	/// para que el runtime pueda avanzar la PPU al ejecutar bloques generados.
	/// \param start Dirección de inicio del bloque.
	/// \return Ciclos base, saturado a 65535.
	[[nodiscard]] eng::u16 block_base_cycles(eng::u16 start) const {
		eng::u16 pc = start;
		eng::u32 sum = 0u;
		for (;;) {
			if (has_instr_[pc] == 0u || (pc != start && leaders_[pc] != 0u)) {
				break;
			}
			const OpcodeInfo& info = kOpcodeTable[instr_[pc].opcode];
			sum += op_base_cycles(instr_[pc].opcode);
			pc = static_cast<eng::u16>(pc + info.size);
			if (info.mode == AddrMode::Rel || sv_equal(info.mnemonic, "JMP") ||
			    sv_equal(info.mnemonic, "JSR") || sv_equal(info.mnemonic, "RTS") ||
			    sv_equal(info.mnemonic, "RTI") || sv_equal(info.mnemonic, "BRK")) {
				break;
			}
		}
		return sum > 0xFFFFu ? static_cast<eng::u16>(0xFFFFu) : static_cast<eng::u16>(sum);
	}

	void emit_blocks_for(Dyn& out, int bank) {
		cur_bank_ = bank; // banco del bloque en emisión (encadenado de destinos)
		out.append(bank < 0 ? "// ---- Basic blocks (ventana fija) ----\n\n"
				    : "// ---- Basic blocks (banco conmutable) ----\n\n");
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] != 0u) {
				const int heat = hot_count(static_cast<eng::u16>(a));
				out.append("static void ");
				if (heat > 0) {
					out.append("__attribute__((hot)) ");
				} else if (heat == 0) {
					out.append("__attribute__((cold)) ");
				}
				append_block_name(out, bank, static_cast<eng::u16>(a));
				out.append("(CPU& cpu);\n");
			}
		}
		out.append('\n');

		// Orden de definición: bloques **calientes primero** (mejor localidad de
		// I-fetch, crítico en A500 sin caché). Los fríos (`heat==0`) van al final
		// (además de llevar `__attribute__((cold))`); sin dato de calor se mantiene
		// el orden por dirección. `order`/`heat` van en paralelo.
		eng::util::Vector<eng::u16, eng::util::HeapAlloc> order {};
		eng::util::Vector<int, eng::util::HeapAlloc> heat {};
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] == 0u) {
				continue;
			}
			(void)order.push_back(static_cast<eng::u16>(a));
			(void)heat.push_back(hot_count(static_cast<eng::u16>(a)));
		}
		// rank: 0 caliente (>0), 1 sin dato (-1), 2 frío (0). Orden estable con
		// inserción: dentro de un rango, más calor primero y, si no, por dirección.
		const auto rank = [](int h) { return h > 0 ? 0 : (h == 0 ? 2 : 1); };
		for (eng::usize i = 1u; i < order.size(); ++i) {
			const eng::u16 ka = order[i];
			const int ha = heat[i];
			const int ra = rank(ha);
			eng::usize j = i;
			while (j > 0u) {
				const int rb = rank(heat[j - 1u]);
				const bool move = (ra != rb) ? (ra < rb)
							     : (ra == 0) ? (ha > heat[j - 1u])
									 : (ka < order[j - 1u]);
				if (!move) {
					break;
				}
				order[j] = order[j - 1u];
				heat[j] = heat[j - 1u];
				--j;
			}
			order[j] = ka;
			heat[j] = ha;
		}

		for (eng::usize oi = 0; oi < order.size(); ++oi) {
			const eng::u16 start = order[oi];
			emit_block_doc(out, start, bank);
			// Registra el bloque para las tablas de despacho.
			{
				BlockInfo bi;
				bi.bank = (bank < 0) ? static_cast<eng::u8>(0xFF)
						     : static_cast<eng::u8>(bank);
				bi.start = start;
				bi.cycles = block_base_cycles(start);
				if (bank < 0) {
					(void)fixed_blocks_.push_back(bi);
				} else {
					(void)bank_blocks_.push_back(bi);
				}
			}
			// Calor del bloque (telemetría `--facts`): `hot`/`cold` guían al
			// compilador (reordenado y `-Os` en los fríos). Sin dato, sin marca.
			const int heat = hot_count(start);
			out.append("static void ");
			if (heat > 0) {
				out.append("__attribute__((hot)) ");
			} else if (heat == 0) {
				out.append("__attribute__((cold)) ");
			}
			append_block_name(out, bank, start);
			out.append("(CPU& cpu) {\n");
			// (Sin etiquetas internas: las ramas vuelven al despacho por `cpu.PC`.)
			if (chain_ && !prg_banked_) {
				// Encadenado: el PC no se mantiene por instrucción, pero se fija al
				// entrar en cada bloque para que el fallback a intérprete, el NMI y
				// el diagnóstico vean la dirección real.
				out.append("    cpu.PC = 0x");
				out.append_hex(start, 4u, true);
				out.append(";\n");
			}
			// Punteros cacheados por bloque: `n2a_ram` (RAM emulada, dirección fija
			// dentro de `NESMemory`) y `n2a_prg` (`PRG_ROM`, `constexpr`) se quedan en
			// registros de dirección durante todo el bloque, en vez de recargar
			// `cpu.mem`/recomputar la base en cada acceso directo.
			if (fast_ram_) {
				out.append("    [[maybe_unused]] eng::u8* const n2a_ram = cpu.mem->ram;\n");
			}
			if (rom_direct_ && !prg_banked_) {
				out.append("    [[maybe_unused]] const eng::u8* const n2a_prg = PRG_ROM;\n");
			}
			emit_assumptions(out, start);

			// VSA intra-bloque: mapa de valores constantes vistos (`LDA #c; STA a`).
			eng::u16 vsa_addr[64];
			eng::u8 vsa_val[64];
			int vsa_n = 0;
			bool a_known = false;
			eng::u8 a_val = 0;

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

				// **Desplazamiento multibyte**: una tirada de `ROR/ROL zp` sobre
				// direcciones consecutivas (idioma PRNG de la NES; en DK el 38 % de
				// las instrucciones) se emite como **una** llamada a `n2a_ror_run`/
				// `n2a_rol_run`, que hace el desplazamiento entero con el carry en un
				// registro (en 68000, `roxr`/`roxl`) y materializa los flags una vez.
				// Solo con acceso directo a RAM (`--fast-ram`) y sin contabilidad de
				// ciclos (`--no-cycles`), donde el estado por instrucción no se observa.
				if ((in.opcode == 0x66u || in.opcode == 0x26u) && fast_ram_ && no_cycles_) {
					const eng::u8 base = static_cast<eng::u8>(in.operand);
					eng::u16 p2 = pc;
					int run = 0;
					while (p2 < kSpace && has_instr_[p2] != 0u && instr_[p2].opcode == in.opcode &&
					       static_cast<eng::u8>(instr_[p2].operand) ==
						       static_cast<eng::u8>(base + run)) {
						++run;
						p2 = static_cast<eng::u16>(p2 + 2u);
						if (p2 < kSpace && has_instr_[p2] != 0u && leaders_[p2] != 0u) {
							break; // no cruzar la frontera del bloque
						}
					}
					if (run >= 3) {
						out.append("    n2a_");
						out.append(in.opcode == 0x66u ? "ror" : "rol");
						out.append("_run(cpu, n2a_ram + 0x");
						out.append_hex(base, 2u, true);
						out.append(", ");
						out.append_u32(static_cast<eng::u32>(run));
						out.append(");\n");
						last_addr = static_cast<eng::u16>(p2 - 2u);
						last = &kOpcodeTable[in.opcode];
						a_known = false;
						pc = p2;
						continue;
					}
				}

				// Si leemos una dirección con valor constante conocido en el bloque,
				// se emite la suposición antes de la carga.
				if ((in.opcode == 0xA5u || in.opcode == 0xADu) && has_operand(in)) {
					for (int k = 0; k < vsa_n; ++k) {
						if (vsa_addr[k] == in.operand) {
							out.append("    N2A_ASSUME(cpu.mem->read(0x");
							out.append_hex(in.operand, 4u, true);
							out.append(") == 0x");
							out.append_hex(vsa_val[k], 2u, true);
							out.append(");\n");
							break;
						}
					}
				}

				// Liveness de Z/N: si la instrucción las escribe y se reescriben antes
				// de leerse, se suprimen las escrituras (menos accesos al estado).
				// Solo con el perfil Amiga encadenado (`--chain`); sin él se mantiene
				// el comportamiento exacto anterior (host/tests).
				cur_nz_live_ = !(chain_ && nz_dead_after(start, pc));
				// Idioms multibyte (copia/const/compare/ADD/SUB 16 bits).
				if (chain_ && fast_ram_ && no_cycles_) {
					eng::u16 nmp = pc;
					if (try_chain_multibyte(out, pc, nmp)) {
						pc = nmp;
						a_known = false;
						vsa_n = 0;
						continue;
					}
				}
				emit_one_instruction(out, in, start);

				// Actualiza el mapa: LDA #imm guarda el valor; STA zp/abs lo fija.
				if (in.opcode == 0xA9u) {
					a_known = true;
					a_val = static_cast<eng::u8>(in.operand);
				} else if ((in.opcode == 0x85u || in.opcode == 0x8Du) && a_known) {
					bool set = false;
					for (int k = 0; k < vsa_n; ++k) {
						if (vsa_addr[k] == in.operand) {
							vsa_val[k] = a_val;
							set = true;
							break;
						}
					}
					if (!set && vsa_n < 64) {
						vsa_addr[vsa_n] = in.operand;
						vsa_val[vsa_n] = a_val;
						++vsa_n;
					}
					a_known = false;
				} else if (in.opcode == 0x20u) {  // JSR: puede tocar memoria
					vsa_n = 0;
					a_known = false;
				} else {
					a_known = false;
				}
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
					if (chain_ && !prg_banked_ && is_block(next)) {
						// Encadenado: caída directa al bloque siguiente (llamada en cola).
						out.append("    return ");
						append_block_name(out, bank, next);
						out.append("(cpu);\n");
					} else if (next == start) {
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

	/// \return `true` si el opcode se puede emitir en el backend nativo.
	[[nodiscard]] static bool native_supported(const OpcodeInfo& info) noexcept {
		const char* m = info.mnemonic;
		if (sv_equal(m, "JMP") || sv_equal(m, "JSR")) {
			return info.mode == AddrMode::Abs; // indirecto: no soportado (fallback)
		}
		if (info.mode == AddrMode::Rel) {
			return true; // BEQ/BNE/BCC/BCS/BMI/BPL/BVS/BVC
		}
		return sv_equal(m, "LAX") || sv_equal(m, "SAX") || sv_equal(m, "DCP") ||
		       sv_equal(m, "ISB") || sv_equal(m, "SLO") || sv_equal(m, "RLA") ||
		       sv_equal(m, "SRE") || sv_equal(m, "RRA") ||
		       sv_equal(m, "LDA") || sv_equal(m, "LDX") || sv_equal(m, "LDY") ||
		       sv_equal(m, "STA") || sv_equal(m, "STX") || sv_equal(m, "STY") ||
		       sv_equal(m, "TAX") || sv_equal(m, "TAY") || sv_equal(m, "TXA") ||
		       sv_equal(m, "TYA") || sv_equal(m, "TSX") || sv_equal(m, "TXS") ||
		       sv_equal(m, "PHA") || sv_equal(m, "PLA") || sv_equal(m, "PHP") ||
		       sv_equal(m, "PLP") || sv_equal(m, "AND") || sv_equal(m, "ORA") ||
		       sv_equal(m, "EOR") || sv_equal(m, "ADC") || sv_equal(m, "SBC") ||
		       sv_equal(m, "CMP") || sv_equal(m, "CPX") || sv_equal(m, "CPY") ||
		       sv_equal(m, "BIT") || sv_equal(m, "INC") || sv_equal(m, "DEC") ||
		       sv_equal(m, "INX") || sv_equal(m, "INY") || sv_equal(m, "DEX") ||
		       sv_equal(m, "DEY") || sv_equal(m, "ASL") || sv_equal(m, "LSR") ||
		       sv_equal(m, "ROL") || sv_equal(m, "ROR") || sv_equal(m, "CLC") ||
		       sv_equal(m, "SEC") || sv_equal(m, "CLI") || sv_equal(m, "SEI") ||
		       sv_equal(m, "CLD") || sv_equal(m, "SED") || sv_equal(m, "CLV") ||
		       sv_equal(m, "RTS") || sv_equal(m, "RTI") || sv_equal(m, "BRK") ||
		       sv_equal(m, "NOP");
	}

	/// Emite el **backend nativo** (estilo descompilador) para PRG fija. Ver `set_native`.
	void emit_native(Dyn& out) {
		// --- Preludio: estado en locales + bus con hooks de E/S ---
		out.append("// ---- Backend nativo (estilo descompilador) ----\n");
		out.append("// Estado del 6502 en variables locales, ROM como literales/array constexpr y\n");
		out.append("// una funcion por REGION (entrada: reset/NMI/IRQ/JSR): el optimizador global\n");
		out.append("// de g++ propaga valores, pliega constantes y asigna registros entre bloques.\n");
		out.append("struct N2A_State {\n");
		out.append("    eng::u8 a = 0, x = 0, y = 0, sp = 0xFD;\n");
		out.append("    eng::u16 pc = 0;\n");
		out.append("    bool c = false, z = false, n = false, v = false, d = false, i = true;\n");
		out.append("    bool halted = false;\n");
		out.append("    bool yield = false; // cesion al runtime (espera de VBlank/NMI)\n};\n");
		out.append("struct N2A_Bus {\n");
		out.append("    eng::u8 ram[0x800] = {};\n");
		out.append("    eng::u8 wram[0x2000] = {};\n");
		out.append("    void (*io_write)(N2A_Bus&, eng::u16, eng::u8) = nullptr;\n");
		out.append("    eng::u8 (*io_read)(N2A_Bus&, eng::u16) = nullptr;\n};\n");
		out.append("[[nodiscard]] static eng::u8 n2a_read(N2A_Bus& m, eng::u16 a) {\n");
		out.append("    if (a < 0x2000u) { return m.ram[a & 0x7FFu]; }\n");
		out.append("    if (a < 0x4020u) { return (m.io_read != nullptr) ? m.io_read(m, a) : 0u; }\n");
		out.append("    if (a >= 0x8000u) { return PRG_ROM[(static_cast<eng::u32>(a) - 0x8000u) & (kPrgSize - 1u)]; }\n");
		out.append("    if (a >= 0x6000u) { return m.wram[a - 0x6000u]; }\n");
		out.append("    return 0u;\n}\n");
		out.append("static void n2a_write(N2A_Bus& m, eng::u16 a, eng::u8 v) {\n");
		out.append("    if (a < 0x2000u) { m.ram[a & 0x7FFu] = v; return; }\n");
		out.append("    if (a < 0x4020u) { if (m.io_write != nullptr) { m.io_write(m, a, v); } return; }\n");
		out.append("    if (a >= 0x6000u && a < 0x8000u) { m.wram[a - 0x6000u] = v; return; }\n}\n");
		out.append("static N2A_State g_st;\nstatic N2A_Bus g_bus;\n");
		out.append("/// Hook que el runtime fija para resolver eventos (VBlank/NMI) al ceder el\n");
		out.append("/// codigo nativo. Si es `nullptr`, `game_main` termina en la primera cesion.\n");
		out.append("static void (*g_native_yield)(N2A_State&, N2A_Bus&) = nullptr;\n\n");

		// --- Entradas de región: reset/NMI/IRQ + destinos de JSR ---
		eng::util::Vector<eng::u16, eng::util::HeapAlloc> entries {};
		const auto add_entry = [&](eng::u16 a) {
			if (a < kSpace && has_instr_[a] != 0u && leaders_[a] != 0u) {
				for (eng::usize i = 0; i < entries.size(); ++i) {
					if (entries[i] == a) {
						return;
					}
				}
				(void)entries.push_back(a);
			}
		};
		add_entry(reset_);
		add_entry(nmi_);
		add_entry(irq_);
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (has_instr_[a] != 0u) {
				const Instruction& in = instr_[a];
				if (sv_equal(kOpcodeTable[in.opcode].mnemonic, "JSR") && has_operand(in)) {
					add_entry(in.target);
				}
			}
		}
		// Declaraciones adelantadas.
		for (eng::usize i = 0; i < entries.size(); ++i) {
			out.append("static void n2a_r_");
			out.append_hex(entries[i], 4u, true);
			out.append("(N2A_State* __restrict r, N2A_Bus* __restrict m);\n");
		}
		out.append('\n');
		for (eng::usize i = 0; i < entries.size(); ++i) {
			emit_native_region(out, entries[i]);
		}

		// --- Entradas (reset/NMI/IRQ). `[[gnu::used]]` evita que g++ elimine las
		// regiones solo alcanzables desde NMI/IRQ por ser `static` no referenciadas.
		out.append("[[gnu::used]] void game_main() {\n");
		out.append("    for (;;) {\n");
		out.append("        if (g_st.halted) { break; }\n");
		out.append("        n2a_r_");
		out.append_hex(reset_, 4u, true);
		out.append("(&g_st, &g_bus);\n");
		out.append("        if (!g_st.yield) { break; }\n");
		out.append("        g_st.yield = false;\n");
		out.append("        if (g_native_yield != nullptr) { g_native_yield(g_st, g_bus); }\n");
		out.append("    }\n}\n");
		out.append("[[gnu::used]] void n2a_nmi() { n2a_r_");
		out.append_hex(nmi_, 4u, true);
		out.append("(&g_st, &g_bus); }\n");
		out.append("[[gnu::used]] void n2a_irq() { n2a_r_");
		out.append_hex(irq_, 4u, true);
		out.append("(&g_st, &g_bus); }\n\n");
		out.append("#if !defined(__m68k__) && !defined(N2A_NO_HOST_MAIN)\n");
		out.append("int main() { game_main(); return 0; }\n");
		out.append("#endif\n");
	}

	/// Emite una **región** (función C++) del backend nativo: BFS de bloques desde
	/// `entry` por aristas estáticas (caída/rama/`JMP`; el retorno de `JSR` continúa en la
	/// región; el destino de `JSR` es otra región). Etiquetas `L_xxxx` + `goto`.
	void emit_native_region(Dyn& out, eng::u16 entry) {
		(void)native_vis_.resize(kSpace, 0u);
		for (eng::u32 i = 0; i < kSpace; ++i) {
			native_vis_[i] = 0u; // `resize` no reescribe; limpiar para cada región
		}
		eng::util::Vector<eng::u16, eng::util::HeapAlloc> stack {};
		const auto visit = [&](eng::u16 b) {
			if (b < kSpace && has_instr_[b] != 0u && leaders_[b] != 0u &&
			    native_vis_[b] == 0u) {
				native_vis_[b] = 1u;
				(void)stack.push_back(b);
			}
		};
		visit(entry);
		for (eng::usize i = 0; i < stack.size(); ++i) {
			const eng::u16 b = stack[i];
			eng::u16 p = b;
			const Instruction* term = nullptr;
			for (;;) {
				if (has_instr_[p] == 0u || (p != b && leaders_[p] != 0u)) {
					break;
				}
				const Instruction& in = instr_[p];
				const OpcodeInfo& info = kOpcodeTable[in.opcode];
				term = &in;
				p = static_cast<eng::u16>(p + info.size);
				if (info.mode == AddrMode::Rel || sv_equal(info.mnemonic, "JMP") ||
				    sv_equal(info.mnemonic, "JSR") || sv_equal(info.mnemonic, "RTS") ||
				    sv_equal(info.mnemonic, "RTI") || sv_equal(info.mnemonic, "BRK")) {
					break;
				}
			}
			const eng::u16 next = p;
			if (term != nullptr) {
				const char* m = kOpcodeTable[term->opcode].mnemonic;
				const AddrMode md = kOpcodeTable[term->opcode].mode;
				if (md == AddrMode::Rel) {
					visit(term->target);
					visit(next);
				} else if (sv_equal(m, "JMP")) {
					visit(term->target);
				} else if (sv_equal(m, "JSR")) {
					visit(next); // retorno del JSR (continúa en la región)
				} else if (!sv_equal(m, "RTS") && !sv_equal(m, "RTI") &&
					   !sv_equal(m, "BRK")) {
					visit(next); // Ultima corriente: cae al siguiente bloque
				}
			} else {
				visit(next);
			}
		}
		// Orden ascendente para localidad de código.
		for (eng::usize i = 1; i < stack.size(); ++i) {
			const eng::u16 k = stack[i];
			eng::usize j = i;
			while (j > 0u && stack[j - 1u] > k) {
				stack[j] = stack[j - 1u];
				--j;
			}
			stack[j] = k;
		}

		out.append("static void n2a_r_");
		out.append_hex(entry, 4u, true);
		out.append("(N2A_State* __restrict r, N2A_Bus* __restrict m) {\n");
		// Nº de aristas estáticas de la región que entran en `target`: para absorber
		// idioms que cruzan un `BNE` solo si nadie más entra en el bloque intermedio.
		const auto predecessors_of = [&](eng::u16 target) -> int {
			int count = 0;
			for (eng::usize k = 0; k < stack.size(); ++k) {
				eng::u16 q = stack[k];
				const Instruction* tm = nullptr;
				for (;;) {
					if (has_instr_[q] == 0u || (q != stack[k] && leaders_[q] != 0u)) {
						break;
					}
					const Instruction& in = instr_[q];
					const OpcodeInfo& inf = kOpcodeTable[in.opcode];
					tm = &in;
					q = static_cast<eng::u16>(q + inf.size);
					if (inf.mode == AddrMode::Rel || sv_equal(inf.mnemonic, "JMP") ||
					    sv_equal(inf.mnemonic, "JSR") || sv_equal(inf.mnemonic, "RTS") ||
					    sv_equal(inf.mnemonic, "RTI") || sv_equal(inf.mnemonic, "BRK")) {
						break;
					}
				}
				if (tm != nullptr) {
					const char* mm = kOpcodeTable[tm->opcode].mnemonic;
					if (kOpcodeTable[tm->opcode].mode == AddrMode::Rel) {
						if (tm->target == target) {
							++count;
						}
						if (q == target) {
							++count;
						}
					} else if (sv_equal(mm, "JMP")) {
						if (tm->target == target) {
							++count;
						}
					} else if (sv_equal(mm, "JSR")) {
						if (q == target) {
							++count;
						}
					} else if (!sv_equal(mm, "RTS") && !sv_equal(mm, "RTI") &&
						   !sv_equal(mm, "BRK")) {
						if (q == target) {
							++count;
						}
					}
				} else if (q == target) {
					++count;
				}
			}
			return count;
		};
		for (eng::usize si = 0; si < stack.size(); ++si) {
			const eng::u16 b = stack[si];
			if (native_vis_[b] == 2u) {
				continue; // bloque absorbido por un idiom
			}
			out.append("L_"); // la etiqueta va ANTES del idiom (que puede `continue`)
			out.append_hex(b, 4u, true);
			out.append(":\n");
			native_x_known_ = false; // VSA de índices: se reinicia en cada bloque
			native_y_known_ = false;
			native_a_known_ = false;
			// Idiom 16 bits que cruza el `BNE`: `INC zp lo; BNE skip; INC zp lo+1`.
			{
				eng::u16 q = b;
				const Instruction* last = nullptr;
				const Instruction* prev = nullptr;
				for (;;) {
					if (has_instr_[q] == 0u || (q != b && leaders_[q] != 0u)) {
						break;
					}
					const Instruction& in = instr_[q];
					const OpcodeInfo& inf = kOpcodeTable[in.opcode];
					prev = last;
					last = &in;
					q = static_cast<eng::u16>(q + inf.size);
					if (inf.mode == AddrMode::Rel || sv_equal(inf.mnemonic, "JMP") ||
					    sv_equal(inf.mnemonic, "JSR") || sv_equal(inf.mnemonic, "RTS") ||
					    sv_equal(inf.mnemonic, "RTI") || sv_equal(inf.mnemonic, "BRK")) {
						break;
					}
				}
				const eng::u16 mid = q;
				if (last != nullptr && prev != nullptr && last->opcode == 0xD0u &&
				    prev->opcode == 0xE6u && native_vis_[mid] == 1u &&
				    has_instr_[mid] != 0u && instr_[mid].opcode == 0xE6u &&
				    static_cast<eng::u8>(instr_[mid].operand) ==
					    static_cast<eng::u8>(static_cast<eng::u8>(prev->operand) + 1u) &&
				    last->target == static_cast<eng::u16>(mid + 2u) &&
				    native_vis_[static_cast<eng::u16>(mid + 2u)] == 1u &&
				    predecessors_of(mid) == 1) {
					eng::u16 r2 = b;
					while (r2 != prev->addr) {
						eng::u16 nmp2 = r2;
						if (try_native_multibyte(out, r2, nmp2)) {
							r2 = nmp2;
							native_x_known_ = native_y_known_ = native_a_known_ = false;
							continue;
						}
						const Instruction& in2 = instr_[r2];
						emit_native_instruction(out, in2);
						r2 = static_cast<eng::u16>(r2 + kOpcodeTable[in2.opcode].size);
					}
					const eng::u8 lo = static_cast<eng::u8>(prev->operand);
					out.append("    { const eng::u16 n2a_w = n2a_ld16(&m->ram[0x");
					out.append_hex(lo, 2u, true);
					out.append("u]); const eng::u16 n2a_r = static_cast<eng::u16>(n2a_w + 1u); n2a_st16(&m->ram[0x");
					out.append_hex(lo, 2u, true);
					out.append("u], n2a_r); const eng::u8 n2a_l = static_cast<eng::u8>(n2a_r & 0xFFu), n2a_h = static_cast<eng::u8>(n2a_r >> 8u); if (n2a_l == 0u) { r->z = (n2a_h == 0u); r->n = ((n2a_h & 0x80u) != 0u); } else { r->z = false; r->n = ((n2a_l & 0x80u) != 0u); } }\n");
					out.append("    goto L_");
					out.append_hex(static_cast<eng::u16>(mid + 2u), 4u, true);
					out.append(";\n");
					native_vis_[mid] = 2u; // absorbido
					continue;
				}
				// Idiom 16 bits: `LDA zp lo; BNE skip; DEC zp lo+1; skip: DEC zp lo`.
				if (last != nullptr && prev != nullptr && last->opcode == 0xD0u &&
				    prev->opcode == 0xA5u && native_vis_[mid] == 1u &&
				    has_instr_[mid] != 0u && instr_[mid].opcode == 0xC6u &&
				    static_cast<eng::u8>(instr_[mid].operand) ==
					    static_cast<eng::u8>(static_cast<eng::u8>(prev->operand) + 1u) &&
				    last->target == static_cast<eng::u16>(mid + 2u) &&
				    has_instr_[static_cast<eng::u16>(mid + 2u)] != 0u &&
				    instr_[static_cast<eng::u16>(mid + 2u)].opcode == 0xC6u &&
				    static_cast<eng::u8>(instr_[static_cast<eng::u16>(mid + 2u)].operand) ==
					    static_cast<eng::u8>(prev->operand) &&
				    native_vis_[static_cast<eng::u16>(mid + 2u)] == 1u &&
				    predecessors_of(mid) == 1) {
					eng::u16 r2 = b;
					while (r2 != prev->addr) {
						eng::u16 nmp2 = r2;
						if (try_native_multibyte(out, r2, nmp2)) {
							r2 = nmp2;
							native_x_known_ = native_y_known_ = native_a_known_ = false;
							continue;
						}
						const Instruction& in2 = instr_[r2];
						emit_native_instruction(out, in2);
						r2 = static_cast<eng::u16>(r2 + kOpcodeTable[in2.opcode].size);
					}
					const eng::u8 lo = static_cast<eng::u8>(prev->operand);
					out.append("    { r->a = m->ram[0x");
					out.append_hex(lo, 2u, true);
					out.append("u]; const eng::u16 n2a_w = n2a_ld16(&m->ram[0x");
					out.append_hex(lo, 2u, true);
					out.append("u]); const eng::u16 n2a_r = static_cast<eng::u16>(n2a_w - 1u); n2a_st16(&m->ram[0x");
					out.append_hex(lo, 2u, true);
					out.append("u], n2a_r); const eng::u8 n2a_l = static_cast<eng::u8>(n2a_r & 0xFFu); r->z = (n2a_l == 0u); r->n = ((n2a_l & 0x80u) != 0u); }\n");
					out.append("    goto L_");
					out.append_hex(static_cast<eng::u16>(mid + 2u), 4u, true);
					out.append(";\n");
					native_vis_[mid] = 2u;
					// El `DEC lo` (1ª instrucción del bloque skip) ya está hecho: se
					// omitirá al emitir ese bloque.
					native_skip_first_ = static_cast<eng::u16>(mid + 2u);
					continue;
				}
			}
			eng::u16 p = b;
			if (b == native_skip_first_ && has_instr_[p] != 0u) {
				// 1ª instrucción del bloque ya absorbida por un idiom (p. ej. `DEC lo`).
				p = static_cast<eng::u16>(p + kOpcodeTable[instr_[p].opcode].size);
				native_skip_first_ = 0xFFFFu;
			}
			const Instruction* term = nullptr;
			for (;;) {
				if (has_instr_[p] == 0u || (p != b && leaders_[p] != 0u)) {
					break;
				}
				const Instruction& in = instr_[p];
				const OpcodeInfo& info = kOpcodeTable[in.opcode];
				term = &in;
				// Idiom multibyte sin ramas (copia 16 bits / constante 16 bits).
				eng::u16 nmp = p;
				if (try_native_multibyte(out, p, nmp)) {
					term = &instr_[static_cast<eng::u16>(nmp - 2u)];
					p = nmp;
					native_x_known_ = native_y_known_ = native_a_known_ = false;
					continue;
				}
				// Patrón (idioma PRNG): tirada de `ROR/ROL zp` sobre direcciones
				// consecutivas -> **un bucle** con el carry en una local, en vez de
				// N rotaciones con acceso a memoria y flags por byte.
				if ((in.opcode == 0x66u || in.opcode == 0x26u) && info.mode == AddrMode::Zp) {
					const eng::u8 base = static_cast<eng::u8>(in.operand);
					eng::u16 p2 = p;
					int run = 0;
					while (p2 < kSpace && has_instr_[p2] != 0u &&
					       instr_[p2].opcode == in.opcode &&
					       static_cast<eng::u8>(instr_[p2].operand) ==
						       static_cast<eng::u8>(base + run)) {
						++run;
						p2 = static_cast<eng::u16>(p2 + 2u);
						if (p2 < kSpace && has_instr_[p2] != 0u && leaders_[p2] != 0u) {
							break;
						}
					}
					if (run >= 3) {
						const bool ror = (in.opcode == 0x66u);
						out.append("    { eng::u8 n2a_c = r->c ? 1u : 0u; eng::u8* n2a_p = &m->ram[0x");
						out.append_hex(base, 2u, true);
						out.append("u];\n      for (int n2a_i = 0; n2a_i < ");
						out.append_u32(static_cast<eng::u32>(run));
						out.append("; ++n2a_i) {\n        const eng::u8 n2a_v = n2a_p[n2a_i];\n");
						if (ror) {
							out.append("        n2a_p[n2a_i] = static_cast<eng::u8>((n2a_v >> 1u) | (n2a_c << 7u)); n2a_c = static_cast<eng::u8>(n2a_v & 1u);\n");
						} else {
							out.append("        n2a_p[n2a_i] = static_cast<eng::u8>(static_cast<eng::u8>(n2a_v << 1u) | n2a_c); n2a_c = static_cast<eng::u8>(n2a_v >> 7u);\n");
						}
						out.append("      }\n      r->c = (n2a_c != 0u); const eng::u8 n2a_l = n2a_p[");
						out.append_u32(static_cast<eng::u32>(run - 1));
						out.append("]; r->z = (n2a_l == 0u); r->n = ((n2a_l & 0x80u) != 0u); }\n");
						p = p2;
						term = &instr_[static_cast<eng::u16>(p2 - 2u)];
						native_x_known_ = native_y_known_ = native_a_known_ = false;
						continue;
					}
				}
				emit_native_instruction(out, in);
				p = static_cast<eng::u16>(p + info.size);
				if (info.mode == AddrMode::Rel || sv_equal(info.mnemonic, "JMP") ||
				    sv_equal(info.mnemonic, "JSR") || sv_equal(info.mnemonic, "RTS") ||
				    sv_equal(info.mnemonic, "RTI") || sv_equal(info.mnemonic, "BRK")) {
					break;
				}
			}
			const eng::u16 next = p;
			if (term != nullptr) {
				const char* m = kOpcodeTable[term->opcode].mnemonic;
				if (kOpcodeTable[term->opcode].mode == AddrMode::Rel) {
					if (term->target == b && block_reads_ppu_status(b)) {
						// Bucle de espera de VBlank/sprite-0: cede al runtime en vez de
						// girar en la propia region (el runtime resuelve VBlank/NMI).
						out.append("    if (");
						out.append(sv_equal(m, "BEQ") ? "r->z"
							   : sv_equal(m, "BNE") ? "!r->z"
							   : sv_equal(m, "BCC") ? "!r->c"
							   : sv_equal(m, "BCS") ? "r->c"
							   : sv_equal(m, "BMI") ? "r->n"
							   : sv_equal(m, "BPL") ? "!r->n"
							   : sv_equal(m, "BVS") ? "r->v"
							   : sv_equal(m, "BVC") ? "!r->v"
										: "false");
						out.append(") { r->yield = true; return; }\n");
					} else if (native_vis_[term->target] != 0u) {
						out.append("    if (");
						out.append(sv_equal(m, "BEQ") ? "r->z"
							   : sv_equal(m, "BNE") ? "!r->z"
							   : sv_equal(m, "BCC") ? "!r->c"
							   : sv_equal(m, "BCS") ? "r->c"
							   : sv_equal(m, "BMI") ? "r->n"
							   : sv_equal(m, "BPL") ? "!r->n"
							   : sv_equal(m, "BVS") ? "r->v"
							   : sv_equal(m, "BVC") ? "!r->v"
										: "false");
						out.append(") { goto L_");
						out.append_hex(term->target, 4u, true);
						out.append("; }\n");
					}
					if (native_vis_[next] != 0u) {
						out.append("    goto L_");
						out.append_hex(next, 4u, true);
						out.append(";\n");
					}
				} else if (sv_equal(m, "JMP")) {
					if (term->target == b) {
						// `JMP a si mismo`: espera de NMI; cede al runtime.
						out.append("    r->yield = true; return;\n");
					} else if (native_vis_[term->target] != 0u) {
						out.append("    goto L_");
						out.append_hex(term->target, 4u, true);
						out.append(";\n");
					}
				} else if (sv_equal(m, "JSR")) {
					out.append("    n2a_r_");
					out.append_hex(term->target, 4u, true);
					out.append("(r, m);");
					if (native_vis_[next] != 0u) {
						out.append(" goto L_");
						out.append_hex(next, 4u, true);
						out.append(";");
					}
					out.append('\n');
				} else if (sv_equal(m, "RTS") || sv_equal(m, "RTI")) {
					out.append("    return;\n");
				} else if (sv_equal(m, "BRK")) {
					out.append("    r->halted = true; return;\n");
				} else if (native_vis_[next] != 0u) {
					out.append("    goto L_");
					out.append_hex(next, 4u, true);
					out.append(";\n");
				}
			} else if (native_vis_[next] != 0u) {
				out.append("    goto L_");
				out.append_hex(next, 4u, true);
				out.append(";\n");
			}
		}
		out.append("}\n\n");
	}

	/// Reconoce un **idiom multibyte sin ramas** (dentro de un bloque) y lo emite como una
	/// operación de 16 bits, para que g++ use `move.w`/`add.w` en vez de byte a byte:
	///
	///   - **copia 16 bits**: `LDA zp a; STA zp c; LDA zp a+1; STA zp c+1`
	///     -> `*(u16*)&ram[c] = *(u16*)&ram[a]` (el orden de bytes se conserva).
	///   - **constante 16 bits**: `LDA #k0; STA zp c; LDA #k1; STA zp c+1`
	///     -> dos bytes (g++ puede combinarlos) + `A = k1` con flags.
	///
	/// El estado final (A y flags) replica la secuencia byte a byte del 6502.
	/// \param out  Salida.
	/// \param p    Dirección de la primera instrucción.
	/// \param next [salida] Dirección tras el idiom (`p+8`).
	/// \return `true` si se emitió el idiom.
	[[nodiscard]] bool try_native_multibyte(Dyn& out, eng::u16 p, eng::u16& next) const {
		const auto at = [&](eng::u16 a) -> const Instruction* {
			return (a < kSpace && has_instr_[a] != 0u) ? &instr_[a] : nullptr;
		};
		const Instruction* i0 = at(p);
		const Instruction* i1 = at(static_cast<eng::u16>(p + 2u));
		const Instruction* i2 = at(static_cast<eng::u16>(p + 4u));
		const Instruction* i3 = at(static_cast<eng::u16>(p + 6u));
		if (i0 == nullptr) {
			return false;
		}
		const bool have4 = (i1 != nullptr && i2 != nullptr && i3 != nullptr);
		const auto hex2 = [&](eng::u8 v) {
			out.append("0x");
			out.append_hex(v, 2u, true);
			out.append("u");
		};
		// --- Copia 16 bits: LDA zp a; STA zp c; LDA zp a+1; STA zp c+1 ---
		if (have4 && i0->opcode == 0xA5u && i1->opcode == 0x85u && i2->opcode == 0xA5u &&
		    i3->opcode == 0x85u) {
			const eng::u8 a = static_cast<eng::u8>(i0->operand);
			const eng::u8 c = static_cast<eng::u8>(i1->operand);
			if (static_cast<eng::u8>(i2->operand) == static_cast<eng::u8>(a + 1u) &&
			    static_cast<eng::u8>(i3->operand) == static_cast<eng::u8>(c + 1u)) {
				out.append("    { eng::u16 n2a_w; __builtin_memcpy(&n2a_w, &m->ram[");
				hex2(a);
				out.append("], 2u); __builtin_memcpy(&m->ram[");
				hex2(c);
				out.append("], &n2a_w, 2u); r->a = m->ram[");
				hex2(static_cast<eng::u8>(a + 1u));
				out.append("]; r->z = (r->a == 0u); r->n = ((r->a & 0x80u) != 0u); }\n");
				next = static_cast<eng::u16>(p + 8u);
				return true;
			}
		}
		// --- Constante 16 bits: LDA #k0; STA zp c; LDA #k1; STA zp c+1 ---
		if (have4 && i0->opcode == 0xA9u && i1->opcode == 0x85u && i2->opcode == 0xA9u &&
		    i3->opcode == 0x85u) {
			const eng::u8 k0 = static_cast<eng::u8>(i0->operand);
			const eng::u8 c = static_cast<eng::u8>(i1->operand);
			const eng::u8 k1 = static_cast<eng::u8>(i2->operand);
			if (static_cast<eng::u8>(i3->operand) == static_cast<eng::u8>(c + 1u)) {
				out.append("    m->ram[");
				hex2(c);
				out.append("] = ");
				hex2(k0);
				out.append("; m->ram[");
				hex2(static_cast<eng::u8>(c + 1u));
				out.append("] = ");
				hex2(k1);
				out.append("; r->a = ");
				hex2(k1);
				out.append("; r->z = (r->a == 0u); r->n = ((r->a & 0x80u) != 0u);\n");
				next = static_cast<eng::u16>(p + 8u);
				return true;
			}
		}
		// --- Comparación 16 bits: LDA zp a; CMP #k0|zp m0; LDA zp a+1; SBC #k1|zp m1 ---
		// (sin ramas; deja `C` = (a >= b) a 16 bits y `A`/`Z`/`N` del byte alto, como el 6502)
		if (have4 && i0->opcode == 0xA5u && (i1->opcode == 0xC9u || i1->opcode == 0xC5u) &&
		    i2->opcode == 0xA5u && (i3->opcode == 0xE9u || i3->opcode == 0xE5u)) {
			const eng::u8 a = static_cast<eng::u8>(i0->operand);
			const bool imm1 = (i1->opcode == 0xC9u);
			const bool imm2 = (i3->opcode == 0xE9u);
			if (static_cast<eng::u8>(i2->operand) == static_cast<eng::u8>(a + 1u) &&
			    imm1 == imm2) {
				out.append("    { const eng::u16 n2a_a = n2a_ld16(&m->ram[");
				hex2(a);
				out.append("]); const eng::u16 n2a_b = ");
				if (imm1) {
					const eng::u16 k =
						static_cast<eng::u16>(static_cast<eng::u8>(i1->operand)) |
						(static_cast<eng::u16>(static_cast<eng::u8>(i3->operand)) << 8u);
					out.append("0x");
					out.append_hex(k, 4u, true);
					out.append("u");
				} else {
					const eng::u8 m0 = static_cast<eng::u8>(i1->operand);
					out.append("n2a_ld16(&m->ram[");
					hex2(m0);
					out.append("])");
				}
				out.append("; const eng::u16 n2a_d = static_cast<eng::u16>(n2a_a - n2a_b); r->a = static_cast<eng::u8>(n2a_d >> 8u); r->c = (n2a_a >= n2a_b); r->z = (r->a == 0u); r->n = ((r->a & 0x80u) != 0u); }\n");
				next = static_cast<eng::u16>(p + 8u);
				return true;
			}
		}
		// --- Suma 16 bits: CLC; LDA zp a; ADC k0; STA zp c; LDA zp a+1; ADC k1; STA zp c+1 ---
		if (i0->opcode == 0x18u) {
			const auto nx = [&](eng::u16 a) {
				return static_cast<eng::u16>(a + kOpcodeTable[instr_[a].opcode].size);
			};
			const eng::u16 p1 = nx(p);
			const Instruction* j1 = at(p1);
			if (j1 != nullptr && j1->opcode == 0xA5u) {
				const eng::u8 a = static_cast<eng::u8>(j1->operand);
				const eng::u16 p2 = nx(p1);
				const eng::u16 p3 = nx(p2);
				const eng::u16 p4 = nx(p3);
				const eng::u16 p5 = nx(p4);
				const eng::u16 p6 = nx(p5);
				const Instruction* j2 = at(p2);
				const Instruction* j3 = at(p3);
				const Instruction* j4 = at(p4);
				const Instruction* j5 = at(p5);
				const Instruction* j6 = at(p6);
				if (j2 != nullptr && (j2->opcode == 0x69u || j2->opcode == 0x65u) &&
				    j3 != nullptr && j3->opcode == 0x85u && j4 != nullptr &&
				    j4->opcode == 0xA5u &&
				    static_cast<eng::u8>(j4->operand) == static_cast<eng::u8>(a + 1u) &&
				    j5 != nullptr && (j5->opcode == 0x69u || j5->opcode == 0x65u) &&
				    j6 != nullptr && j6->opcode == 0x85u) {
					const eng::u8 c = static_cast<eng::u8>(j3->operand);
					const bool imm0 = (j2->opcode == 0x69u);
					const bool imm1 = (j5->opcode == 0x69u);
					const bool zp_ok = imm0 || (static_cast<eng::u8>(j5->operand) ==
								    static_cast<eng::u8>(static_cast<eng::u8>(j2->operand) + 1u));
					if (imm0 == imm1 && zp_ok &&
					    static_cast<eng::u8>(j6->operand) == static_cast<eng::u8>(c + 1u)) {
						out.append("    { const eng::u16 n2a_x = n2a_ld16(&m->ram[");
						hex2(a);
						out.append("]); const eng::u16 n2a_y = ");
						if (imm0) {
							const eng::u16 k =
								static_cast<eng::u16>(static_cast<eng::u8>(j2->operand)) |
								(static_cast<eng::u16>(static_cast<eng::u8>(j5->operand)) << 8u);
							out.append("0x");
							out.append_hex(k, 4u, true);
							out.append("u");
						} else {
							out.append("n2a_ld16(&m->ram[");
							hex2(static_cast<eng::u8>(j2->operand));
							out.append("])");
						}
						out.append("; const eng::u32 n2a_s = static_cast<eng::u32>(n2a_x) + n2a_y; const eng::u16 n2a_r = static_cast<eng::u16>(n2a_s); n2a_st16(&m->ram[");
						hex2(c);
						out.append("], n2a_r); r->c = (n2a_s > 0xFFFFu); const eng::u8 n2a_h = static_cast<eng::u8>(n2a_r >> 8u), n2a_ah = static_cast<eng::u8>(n2a_x >> 8u), n2a_bh = static_cast<eng::u8>(n2a_y >> 8u); r->v = (((n2a_ah ^ n2a_h) & (n2a_bh ^ n2a_h) & 0x80u) != 0u); r->a = n2a_h; r->z = (n2a_h == 0u); r->n = ((n2a_h & 0x80u) != 0u); }\n");
						next = nx(p6);
						return true;
					}
				}
			}
		}
		// --- Resta 16 bits: SEC; LDA zp a; SBC k0; STA zp c; LDA zp a+1; SBC k1; STA zp c+1 ---
		if (i0->opcode == 0x38u) {
			const auto nx = [&](eng::u16 a) {
				return static_cast<eng::u16>(a + kOpcodeTable[instr_[a].opcode].size);
			};
			const eng::u16 p1 = nx(p);
			const Instruction* j1 = at(p1);
			if (j1 != nullptr && j1->opcode == 0xA5u) {
				const eng::u8 a = static_cast<eng::u8>(j1->operand);
				const eng::u16 p2 = nx(p1);
				const eng::u16 p3 = nx(p2);
				const eng::u16 p4 = nx(p3);
				const eng::u16 p5 = nx(p4);
				const eng::u16 p6 = nx(p5);
				const Instruction* j2 = at(p2);
				const Instruction* j3 = at(p3);
				const Instruction* j4 = at(p4);
				const Instruction* j5 = at(p5);
				const Instruction* j6 = at(p6);
				if (j2 != nullptr && (j2->opcode == 0xE9u || j2->opcode == 0xE5u) &&
				    j3 != nullptr && j3->opcode == 0x85u && j4 != nullptr &&
				    j4->opcode == 0xA5u &&
				    static_cast<eng::u8>(j4->operand) == static_cast<eng::u8>(a + 1u) &&
				    j5 != nullptr && (j5->opcode == 0xE9u || j5->opcode == 0xE5u) &&
				    j6 != nullptr && j6->opcode == 0x85u) {
					const eng::u8 c = static_cast<eng::u8>(j3->operand);
					const bool imm0 = (j2->opcode == 0xE9u);
					const bool imm1 = (j5->opcode == 0xE9u);
					const bool zp_ok = imm0 || (static_cast<eng::u8>(j5->operand) ==
								    static_cast<eng::u8>(static_cast<eng::u8>(j2->operand) + 1u));
					if (imm0 == imm1 && zp_ok &&
					    static_cast<eng::u8>(j6->operand) == static_cast<eng::u8>(c + 1u)) {
						out.append("    { const eng::u16 n2a_x = n2a_ld16(&m->ram[");
						hex2(a);
						out.append("]); const eng::u16 n2a_y = ");
						if (imm0) {
							const eng::u16 k =
								static_cast<eng::u16>(static_cast<eng::u8>(j2->operand)) |
								(static_cast<eng::u16>(static_cast<eng::u8>(j5->operand)) << 8u);
							out.append("0x");
							out.append_hex(k, 4u, true);
							out.append("u");
						} else {
							out.append("n2a_ld16(&m->ram[");
							hex2(static_cast<eng::u8>(j2->operand));
							out.append("])");
						}
						out.append("; const eng::u32 n2a_s = static_cast<eng::u32>(n2a_x) - n2a_y; const eng::u16 n2a_r = static_cast<eng::u16>(n2a_s); n2a_st16(&m->ram[");
						hex2(c);
						out.append("], n2a_r); r->c = (n2a_x >= n2a_y); const eng::u8 n2a_h = static_cast<eng::u8>(n2a_r >> 8u), n2a_ah = static_cast<eng::u8>(n2a_x >> 8u), n2a_nbh = static_cast<eng::u8>(~static_cast<eng::u8>(n2a_y >> 8u)); r->v = (((n2a_ah ^ n2a_h) & (n2a_nbh ^ n2a_h) & 0x80u) != 0u); r->a = n2a_h; r->z = (n2a_h == 0u); r->n = ((n2a_h & 0x80u) != 0u); }\n");
						next = nx(p6);
						return true;
					}
				}
			}
		}
		return false;
	}

	/// Emite una instrucción del backend nativo (salvo transferencias de control, que
	/// resuelve `emit_native_region`). `r` es `N2A_State*`, `m` es `N2A_Bus*`.
	void emit_native_instruction(Dyn& out, const Instruction& in) {
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		const char* m = info.mnemonic;
		// VSA (const-prop simple de A/X/Y): sigue valores conocidos a través de
		// `#imm`, `INX/DEX/INY/DEY` y transferencias; los invalida en cualquier otra
		// escritura (y en `JSR`/saltos, donde el callee puede cambiarlos).
		if (in.opcode == 0xA9u) {
			native_a_known_ = true;
			native_a_val_ = static_cast<eng::u8>(in.operand);
		} else if (sv_equal(m, "TXA") && native_x_known_) {
			native_a_known_ = true;
			native_a_val_ = native_x_val_;
		} else if (sv_equal(m, "TYA") && native_y_known_) {
			native_a_known_ = true;
			native_a_val_ = native_y_val_;
		} else if (sv_equal(m, "LDA") || sv_equal(m, "ADC") || sv_equal(m, "SBC") ||
			   sv_equal(m, "AND") || sv_equal(m, "ORA") || sv_equal(m, "EOR") ||
			   sv_equal(m, "PLA") || sv_equal(m, "TXA") || sv_equal(m, "TYA") ||
			   sv_equal(m, "LAX") || sv_equal(m, "DCP") || sv_equal(m, "ISB") ||
			   sv_equal(m, "SLO") || sv_equal(m, "RLA") || sv_equal(m, "SRE") ||
			   sv_equal(m, "RRA")) {
			native_a_known_ = false;
		}
		if (in.opcode == 0xA2u) {
			native_x_known_ = true;
			native_x_val_ = static_cast<eng::u8>(in.operand);
		} else if (sv_equal(m, "INX") && native_x_known_) {
			native_x_val_ = static_cast<eng::u8>(native_x_val_ + 1u);
		} else if (sv_equal(m, "DEX") && native_x_known_) {
			native_x_val_ = static_cast<eng::u8>(native_x_val_ - 1u);
		} else if (sv_equal(m, "TAX") && native_a_known_) {
			native_x_known_ = true;
			native_x_val_ = native_a_val_;
		} else if (sv_equal(m, "LDX") || sv_equal(m, "TAX") || sv_equal(m, "TSX") ||
			   sv_equal(m, "PLA") || sv_equal(m, "PLP") || sv_equal(m, "RTI") ||
			   sv_equal(m, "LAX")) {
			native_x_known_ = false;
		}
		if (in.opcode == 0xA0u) {
			native_y_known_ = true;
			native_y_val_ = static_cast<eng::u8>(in.operand);
		} else if (sv_equal(m, "INY") && native_y_known_) {
			native_y_val_ = static_cast<eng::u8>(native_y_val_ + 1u);
		} else if (sv_equal(m, "DEY") && native_y_known_) {
			native_y_val_ = static_cast<eng::u8>(native_y_val_ - 1u);
		} else if (sv_equal(m, "TAY") && native_a_known_) {
			native_y_known_ = true;
			native_y_val_ = native_a_val_;
		} else if (sv_equal(m, "LDY") || sv_equal(m, "TAY") || sv_equal(m, "PLA") ||
			   sv_equal(m, "PLP") || sv_equal(m, "RTI")) {
			native_y_known_ = false;
		}
		if (sv_equal(m, "JSR") || sv_equal(m, "JMP") || sv_equal(m, "RTS") ||
		    sv_equal(m, "RTI")) {
			native_x_known_ = false;
			native_y_known_ = false;
			native_a_known_ = false;
		}
		if (sv_equal(m, "RTS") || sv_equal(m, "RTI") || sv_equal(m, "BRK") ||
		    sv_equal(m, "JMP") || sv_equal(m, "JSR") || info.mode == AddrMode::Rel ||
		    sv_equal(m, "NOP")) {
			return; // terminadores / no-op
		}
		// Expresión del operando efectivo (rvalue del byte).
		const auto operand = [&]() {
			if (info.mode == AddrMode::Imm) {
				out.append("0x");
				out.append_hex(static_cast<eng::u16>(in.operand), 2u, true);
				return;
			}
			if (info.mode == AddrMode::Abs && in.operand >= 0x8000u) {
				// ROM absoluta: **literal** (PRG fija).
				out.append("0x");
				out.append_hex(prg_[(static_cast<eng::u32>(in.operand) - 0x8000u) &
						     (prg_size_ - 1u)], 2u, true);
				return;
			}
			if ((info.mode == AddrMode::AbsX || info.mode == AddrMode::AbsY) &&
			    in.operand >= 0x8000u && in.operand <= 0xFF00u) {
				// Índice de ROM con X/Y **conocido** (VSA): plegar a **literal**.
				const bool known = (info.mode == AddrMode::AbsX) ? native_x_known_ : native_y_known_;
				const eng::u8 iv = (info.mode == AddrMode::AbsX) ? native_x_val_ : native_y_val_;
				if (known) {
					const eng::u32 idx = (static_cast<eng::u32>(in.operand) - 0x8000u + iv) &
							     (prg_size_ - 1u);
					out.append("0x");
					out.append_hex(prg_[idx], 2u, true);
					return;
				}
				// ROM indexada (índice de runtime): acceso directo al array constexpr.
				out.append("PRG_ROM[(0x");
				out.append_hex(static_cast<eng::u32>(in.operand) - 0x8000u, 4u, true);
				out.append("u + r->");
				out.append(info.mode == AddrMode::AbsX ? "x" : "y");
				out.append(") & (kPrgSize - 1u)]");
				return;
			}
			out.append("n2a_read(*m, ");
			emit_native_ea(out, in);
			out.append(")");
		};
		const auto setzn = [&](const char* reg) {
			out.append(" r->z = (");
			out.append(reg);
			out.append(" == 0u); r->n = ((");
			out.append(reg);
			out.append(" & 0x80u) != 0u);");
		};
		const auto store = [&](const char* src) {
			out.append("    n2a_write(*m, ");
			emit_native_ea(out, in);
			out.append(", ");
			out.append(src);
			out.append(");\n");
		};

		if (sv_equal(m, "LDA") || sv_equal(m, "LDX") || sv_equal(m, "LDY")) {
			const char* reg = sv_equal(m, "LDA") ? "a" : (sv_equal(m, "LDX") ? "x" : "y");
			out.append("    r->");
			out.append(reg);
			out.append(" = static_cast<eng::u8>(");
			operand();
			out.append(");");
			out.append(" r->z = (r->");
			out.append(reg);
			out.append(" == 0u); r->n = ((r->");
			out.append(reg);
			out.append(" & 0x80u) != 0u);\n");
			return;
		}
		if (sv_equal(m, "STA") || sv_equal(m, "STX") || sv_equal(m, "STY")) {
			store(sv_equal(m, "STA") ? "r->a" : (sv_equal(m, "STX") ? "r->x" : "r->y"));
			return;
		}
		if (sv_equal(m, "AND") || sv_equal(m, "ORA") || sv_equal(m, "EOR")) {
			out.append("    r->a = static_cast<eng::u8>(r->a ");
			out.append(sv_equal(m, "AND") ? "&" : sv_equal(m, "ORA") ? "|" : "^");
			out.append(" static_cast<eng::u8>(");
			operand();
			out.append("));");
			setzn("r->a");
			out.append('\n');
			return;
		}
		if (sv_equal(m, "ADC") || sv_equal(m, "SBC")) {
			out.append("    { const eng::u8 n2a_v = static_cast<eng::u8>(");
			operand();
			out.append(");");
			if (sv_equal(m, "ADC")) {
				out.append(" const eng::u16 n2a_s = static_cast<eng::u16>(r->a) + n2a_v + (r->c ? 1u : 0u);");
				out.append(" r->v = ((((r->a ^ n2a_s) & (n2a_v ^ n2a_s)) & 0x80u) != 0u);");
				out.append(" r->a = static_cast<eng::u8>(n2a_s);");
				out.append(" r->c = (n2a_s > 0xFFu);");
			} else {
				out.append(" const eng::u8 n2a_nv = static_cast<eng::u8>(~n2a_v);");
				out.append(" const eng::u16 n2a_s = static_cast<eng::u16>(r->a) + n2a_nv + (r->c ? 1u : 0u);");
				out.append(" r->v = ((((r->a ^ n2a_s) & (n2a_nv ^ n2a_s)) & 0x80u) != 0u);");
				out.append(" r->a = static_cast<eng::u8>(n2a_s);");
				out.append(" r->c = (n2a_s > 0xFFu);");
			}
			setzn("r->a");
			out.append(" }\n");
			return;
		}
		if (sv_equal(m, "CMP") || sv_equal(m, "CPX") || sv_equal(m, "CPY")) {
			const char* reg = sv_equal(m, "CMP") ? "r->a" : (sv_equal(m, "CPX") ? "r->x" : "r->y");
			out.append("    { const eng::u8 n2a_v = static_cast<eng::u8>(");
			operand();
			out.append(");");
			out.append(" const eng::u8 n2a_d = static_cast<eng::u8>(");
			out.append(reg);
			out.append(" - n2a_v);");
			out.append(" r->c = (");
			out.append(reg);
			out.append(" >= n2a_v); r->z = (n2a_d == 0u); r->n = ((n2a_d & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "BIT")) {
			out.append("    { const eng::u8 n2a_v = static_cast<eng::u8>(");
			operand();
			out.append("); r->z = ((r->a & n2a_v) == 0u); r->v = ((n2a_v & 0x40u) != 0u); r->n = ((n2a_v & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "INC") || sv_equal(m, "DEC")) {
			out.append("    { const eng::u8 n2a_v = static_cast<eng::u8>(n2a_read(*m, ");
			emit_native_ea(out, in);
			out.append(") ");
			out.append(sv_equal(m, "INC") ? "+ 1u" : "- 1u");
			out.append("); n2a_write(*m, ");
			emit_native_ea(out, in);
			out.append(", n2a_v); r->z = (n2a_v == 0u); r->n = ((n2a_v & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "ASL") || sv_equal(m, "LSR") || sv_equal(m, "ROL") || sv_equal(m, "ROR")) {
			out.append("    { eng::u8 n2a_v = n2a_read(*m, ");
			emit_native_ea(out, in);
			out.append(");");
			if (sv_equal(m, "ASL")) {
				out.append(" r->c = ((n2a_v & 0x80u) != 0u); n2a_v = static_cast<eng::u8>(n2a_v << 1u);");
			} else if (sv_equal(m, "LSR")) {
				out.append(" r->c = ((n2a_v & 1u) != 0u); n2a_v = static_cast<eng::u8>(n2a_v >> 1u);");
			} else if (sv_equal(m, "ROL")) {
				out.append(" { const eng::u8 n2a_c = r->c ? 1u : 0u; r->c = ((n2a_v & 0x80u) != 0u); n2a_v = static_cast<eng::u8>((n2a_v << 1u) | n2a_c); }");
			} else {
				out.append(" { const eng::u8 n2a_c = r->c ? 1u : 0u; r->c = ((n2a_v & 1u) != 0u); n2a_v = static_cast<eng::u8>((n2a_v >> 1u) | (n2a_c << 7u)); }");
			}
			out.append(" n2a_write(*m, ");
			emit_native_ea(out, in);
			out.append(", n2a_v); r->z = (n2a_v == 0u); r->n = ((n2a_v & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "INX")) { out.append("    r->x = static_cast<eng::u8>(r->x + 1u);"); setzn("r->x"); out.append('\n'); return; }
		if (sv_equal(m, "INY")) { out.append("    r->y = static_cast<eng::u8>(r->y + 1u);"); setzn("r->y"); out.append('\n'); return; }
		if (sv_equal(m, "DEX")) { out.append("    r->x = static_cast<eng::u8>(r->x - 1u);"); setzn("r->x"); out.append('\n'); return; }
		if (sv_equal(m, "DEY")) { out.append("    r->y = static_cast<eng::u8>(r->y - 1u);"); setzn("r->y"); out.append('\n'); return; }
		if (sv_equal(m, "TAX")) { out.append("    r->x = r->a;"); setzn("r->x"); out.append('\n'); return; }
		if (sv_equal(m, "TAY")) { out.append("    r->y = r->a;"); setzn("r->y"); out.append('\n'); return; }
		if (sv_equal(m, "TXA")) { out.append("    r->a = r->x;"); setzn("r->a"); out.append('\n'); return; }
		if (sv_equal(m, "TYA")) { out.append("    r->a = r->y;"); setzn("r->a"); out.append('\n'); return; }
		if (sv_equal(m, "TSX")) { out.append("    r->x = r->sp;"); setzn("r->x"); out.append('\n'); return; }
		if (sv_equal(m, "TXS")) { out.append("    r->sp = r->x;\n"); return; }
		if (sv_equal(m, "PHA")) { out.append("    m->ram[0x100u + r->sp] = r->a; r->sp = static_cast<eng::u8>(r->sp - 1u);\n"); return; }
		if (sv_equal(m, "PLA")) { out.append("    r->sp = static_cast<eng::u8>(r->sp + 1u); r->a = m->ram[0x100u + r->sp];"); setzn("r->a"); out.append('\n'); return; }
		if (sv_equal(m, "PHP")) {
			out.append("    m->ram[0x100u + r->sp] = static_cast<eng::u8>(0x30u | (r->n ? 0x80u : 0u) | (r->v ? 0x40u : 0u) | (r->d ? 0x08u : 0u) | (r->i ? 0x04u : 0u) | (r->z ? 0x02u : 0u) | (r->c ? 0x01u : 0u)); r->sp = static_cast<eng::u8>(r->sp - 1u);\n");
			return;
		}
		if (sv_equal(m, "PLP")) {
			out.append("    { r->sp = static_cast<eng::u8>(r->sp + 1u); const eng::u8 n2a_p = m->ram[0x100u + r->sp]; r->n = ((n2a_p & 0x80u) != 0u); r->v = ((n2a_p & 0x40u) != 0u); r->d = ((n2a_p & 0x08u) != 0u); r->i = ((n2a_p & 0x04u) != 0u); r->z = ((n2a_p & 0x02u) != 0u); r->c = ((n2a_p & 0x01u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "CLC")) { out.append("    r->c = false;\n"); return; }
		if (sv_equal(m, "SEC")) { out.append("    r->c = true;\n"); return; }
		if (sv_equal(m, "CLI")) { out.append("    r->i = false;\n"); return; }
		if (sv_equal(m, "SEI")) { out.append("    r->i = true;\n"); return; }
		if (sv_equal(m, "CLD")) { out.append("    r->d = false;\n"); return; }
		if (sv_equal(m, "SED")) { out.append("    r->d = true;\n"); return; }
		if (sv_equal(m, "CLV")) { out.append("    r->v = false;\n"); return; }
		// --- Opcodes ilegales frecuentes (misma semántica que `CPU::*_impl`) ---
		const auto ea = [&]() { emit_native_ea(out, in); };
		if (sv_equal(m, "LAX")) {
			out.append("    { const eng::u8 n2a_v = static_cast<eng::u8>(");
			operand();
			out.append("); r->a = n2a_v; r->x = n2a_v; r->z = (n2a_v == 0u); r->n = ((n2a_v & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "SAX")) {
			out.append("    n2a_write(*m, ");
			ea();
			out.append(", static_cast<eng::u8>(r->a & r->x));\n");
			return;
		}
		if (sv_equal(m, "DCP")) {
			out.append("    { const eng::u8 n2a_v = static_cast<eng::u8>(n2a_read(*m, ");
			ea();
			out.append(") - 1u); n2a_write(*m, ");
			ea();
			out.append(", n2a_v); const eng::u8 n2a_d = static_cast<eng::u8>(r->a - n2a_v); r->c = (r->a >= n2a_v); r->z = (n2a_d == 0u); r->n = ((n2a_d & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "ISB")) {
			out.append("    { const eng::u8 n2a_v = static_cast<eng::u8>(n2a_read(*m, ");
			ea();
			out.append(") + 1u); n2a_write(*m, ");
			ea();
			out.append(", n2a_v); const eng::u8 n2a_nv = static_cast<eng::u8>(~n2a_v); const eng::u16 n2a_s = static_cast<eng::u16>(r->a) + n2a_nv + (r->c ? 1u : 0u); r->v = ((((r->a ^ n2a_s) & (n2a_nv ^ n2a_s)) & 0x80u) != 0u); r->a = static_cast<eng::u8>(n2a_s); r->c = (n2a_s > 0xFFu); r->z = (r->a == 0u); r->n = ((r->a & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "SLO")) {
			out.append("    { eng::u8 n2a_v = n2a_read(*m, ");
			ea();
			out.append("); r->c = ((n2a_v & 0x80u) != 0u); n2a_v = static_cast<eng::u8>(n2a_v << 1u); n2a_write(*m, ");
			ea();
			out.append(", n2a_v); r->a = static_cast<eng::u8>(r->a | n2a_v); r->z = (r->a == 0u); r->n = ((r->a & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "RLA")) {
			out.append("    { eng::u8 n2a_v = n2a_read(*m, ");
			ea();
			out.append("); const eng::u8 n2a_c = r->c ? 1u : 0u; r->c = ((n2a_v & 0x80u) != 0u); n2a_v = static_cast<eng::u8>((n2a_v << 1u) | n2a_c); n2a_write(*m, ");
			ea();
			out.append(", n2a_v); r->a = static_cast<eng::u8>(r->a & n2a_v); r->z = (r->a == 0u); r->n = ((r->a & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "SRE")) {
			out.append("    { eng::u8 n2a_v = n2a_read(*m, ");
			ea();
			out.append("); r->c = ((n2a_v & 1u) != 0u); n2a_v = static_cast<eng::u8>(n2a_v >> 1u); n2a_write(*m, ");
			ea();
			out.append(", n2a_v); r->a = static_cast<eng::u8>(r->a ^ n2a_v); r->z = (r->a == 0u); r->n = ((r->a & 0x80u) != 0u); }\n");
			return;
		}
		if (sv_equal(m, "RRA")) {
			out.append("    { eng::u8 n2a_v = n2a_read(*m, ");
			ea();
			out.append("); const eng::u8 n2a_c = r->c ? 1u : 0u; r->c = ((n2a_v & 1u) != 0u); n2a_v = static_cast<eng::u8>((n2a_v >> 1u) | (n2a_c << 7u)); n2a_write(*m, ");
			ea();
			out.append(", n2a_v); const eng::u16 n2a_s = static_cast<eng::u16>(r->a) + n2a_v + (r->c ? 1u : 0u); r->v = ((((r->a ^ n2a_s) & (n2a_v ^ n2a_s)) & 0x80u) != 0u); r->a = static_cast<eng::u8>(n2a_s); r->c = (n2a_s > 0xFFu); r->z = (r->a == 0u); r->n = ((r->a & 0x80u) != 0u); }\n");
			return;
		}
		// No alcanzable: `native_supported` filtra el resto.
	}

	/// Expresión de la **dirección efectiva** (u16) de una instrucción del backend nativo.
	void emit_native_ea(Dyn& out, const Instruction& in) const {
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		switch (info.mode) {
		case AddrMode::Zp:
			out.append("0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u");
			break;
		case AddrMode::ZpX:
			out.append("static_cast<eng::u16>(static_cast<eng::u8>(0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u + r->x))");
			break;
		case AddrMode::ZpY:
			out.append("static_cast<eng::u16>(static_cast<eng::u8>(0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u + r->y))");
			break;
		case AddrMode::Abs:
			out.append("0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u");
			break;
		case AddrMode::AbsX:
			out.append("static_cast<eng::u16>(0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u + r->x)");
			break;
		case AddrMode::AbsY:
			out.append("static_cast<eng::u16>(0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u + r->y)");
			break;
		case AddrMode::IndX:
			out.append("static_cast<eng::u16>(static_cast<eng::u16>(n2a_read(*m, static_cast<eng::u8>(0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u + r->x))) | (static_cast<eng::u16>(n2a_read(*m, static_cast<eng::u8>(0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u + r->x + 1u))) << 8u))");
			break;
		default: // IndY
			out.append("static_cast<eng::u16>(static_cast<eng::u16>(n2a_read(*m, 0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 4u, true);
			out.append("u)) | (static_cast<eng::u16>(n2a_read(*m, 0x");
			out.append_hex(static_cast<eng::u16>(in.operand + 1u), 4u, true);
			out.append("u)) << 8u)) + r->y");
			break;
		}
	}

	/// Escribe el despacho y la entrada del programa: la firma `BlockFn`, las
	/// tablas **dispersas** (bloques/ciclos + búsqueda binaria) para la ventana
	/// fija y por banco, el estado global `g_state`, `game_main()` y el `main()` de
	/// host (excluido en Amiga o con `N2A_NO_HOST_MAIN`).
	void emit_dispatch(Dyn& out) const {
		out.append("// ---- Despacho y entrada ----\n\n");
		out.append("/// Firma de un basic block: recibe el CPU (y su memoria) y muta el estado.\n");
		out.append("using BlockFn = void (*)(CPU&);\n\n");
		out.append("/// Entrada de despacho **dispersa**: dirección de inicio + ciclos base + bloque.\n");
		out.append("/// Sustituye a la tabla densa `[0x10000]` (256 KB en 68000, casi toda a cero).\n");
		out.append("struct BankBlock { eng::u16 start; eng::u16 cycles; BlockFn fn; };\n\n");
		out.append("/// Estado global del juego (CPU + memoria).\n");
		out.append("struct GameState { CPU cpu; NESMemory mem; };\n");
		out.append("static GameState g_state;\n\n");
		// --- Bloques de la ventana fija, ordenados por dirección ---
		{
			eng::util::Vector<BlockInfo, eng::util::HeapAlloc> fs {};
			for (eng::usize i = 0; i < fixed_blocks_.size(); ++i) {
				(void)fs.push_back(fixed_blocks_[i]);
			}
			for (eng::usize i = 1u; i < fs.size(); ++i) {
				const BlockInfo key = fs[i];
				eng::usize j = i;
				while (j > 0u && fs[j - 1u].start > key.start) {
					fs[j] = fs[j - 1u];
					--j;
				}
				fs[j] = key;
			}
			out.append("/// Bloques de la ventana fija ($C000-$FFFF y NROM/CNROM), ordenados por dirección.\n");
			out.append("[[maybe_unused]] static const BankBlock kFixedBlocks");
			out.append(fs.size() != 0u ? "[] = {\n" : "[1] = {};\n");
			for (eng::usize i = 0; i < fs.size(); ++i) {
				out.append("    { 0x");
				out.append_hex(fs[i].start, 4u, true);
				out.append(", ");
				out.append_u32(fs[i].cycles);
				out.append("u, ");
				append_block_name(out, -1, fs[i].start);
				out.append(" },\n");
			}
			if (fs.size() != 0u) {
				out.append("};\n");
			}
			out.append("[[maybe_unused]] static const eng::u16 kFixedCount = ");
			out.append_u32(static_cast<eng::u32>(fs.size()));
			out.append("u;\n\n");
		}
		out.append("/// Búsqueda **binaria** de la entrada de bloque fijo para `pc`.\n");
		out.append("[[maybe_unused]] static const BankBlock* n2a_fixed_entry(eng::u16 pc) {\n");
		out.append("    eng::u16 lo = 0u;\n");
		out.append("    eng::u16 hi = kFixedCount;\n");
		out.append("    while (lo < hi) {\n");
		out.append("        const eng::u16 mid = static_cast<eng::u16>(lo + (hi - lo) / 2u);\n");
		out.append("        const eng::u16 s = kFixedBlocks[mid].start;\n");
		out.append("        if (s == pc) { return &kFixedBlocks[mid]; }\n");
		out.append("        if (s < pc) { lo = static_cast<eng::u16>(mid + 1u); } else { hi = mid; }\n");
		out.append("    }\n");
		out.append("    return nullptr;\n}\n\n");
		out.append("/// Bloque fijo para `pc` (nullptr si no hay); usado por plugin/host.\n");
		out.append("[[maybe_unused]] static BlockFn n2a_fixed_block(eng::u16 pc) {\n");
		out.append("    const BankBlock* e = n2a_fixed_entry(pc);\n");
		out.append("    return (e != nullptr) ? e->fn : nullptr;\n}\n\n");
		out.append("/// Ciclos base del bloque fijo que empieza en `pc` (2u si no es bloque).\n");
		out.append("[[maybe_unused]] static eng::u16 n2a_block_cycles(eng::u16 pc) {\n");
		out.append("    const BankBlock* e = n2a_fixed_entry(pc);\n");
		out.append("    return (e != nullptr) ? e->cycles : 2u;\n}\n\n");
		out.append("/// Sin tabla que rellenar (despacho disperso); se conserva por la ABI.\n");
		out.append("static void init_dispatch_table() {}\n\n");
		// --- Despacho por banco (ventana conmutable $8000-$BFFF, F9/B1b) ---
		out.append("// Despacho por banco de la ventana conmutable $8000-$BFFF (F9/B1b).\n");
		for (eng::u32 b = 0; b < prg_bank_count_; ++b) {
			// Copia de los bloques del banco, **ordenada por dirección** (el
			// runtime hace búsqueda binaria).
			eng::util::Vector<BlockInfo, eng::util::HeapAlloc> sb {};
			for (eng::usize i = 0; i < bank_blocks_.size(); ++i) {
				if (bank_blocks_[i].bank == static_cast<eng::u8>(b)) {
					(void)sb.push_back(bank_blocks_[i]);
				}
			}
			for (eng::usize i = 1u; i < sb.size(); ++i) {
				const BlockInfo key = sb[i];
				eng::usize j = i;
				while (j > 0u && sb[j - 1u].start > key.start) {
					sb[j] = sb[j - 1u];
					--j;
				}
				sb[j] = key;
			}
			out.append("static const BankBlock kBankBB");
			out.append_u32(b);
			out.append(sb.size() != 0u ? "[] = {\n" : "[1] = {};\n");
			for (eng::usize i = 0; i < sb.size(); ++i) {
				out.append("    { 0x");
				out.append_hex(sb[i].start, 4u, true);
				out.append(", ");
				out.append_u32(sb[i].cycles);
				out.append("u, ");
				append_block_name(out, static_cast<int>(b), sb[i].start);
				out.append(" },\n");
			}
			if (sb.size() != 0u) {
				out.append("};\n");
			}
		}
		out.append("[[maybe_unused]] static const BankBlock* const kBankTables[kPrgBankCount] = {");
		for (eng::u32 b = 0; b < prg_bank_count_; ++b) {
			out.append(b == 0u ? " kBankBB" : ", kBankBB");
			out.append_u32(b);
		}
		out.append(" };\n");
		out.append("[[maybe_unused]] static const eng::u16 kBankCounts[kPrgBankCount] = {");
		for (eng::u32 b = 0; b < prg_bank_count_; ++b) {
			eng::usize n = 0u;
			for (eng::usize i = 0; i < bank_blocks_.size(); ++i) {
				if (bank_blocks_[i].bank == static_cast<eng::u8>(b)) {
					++n;
				}
			}
			out.append(b == 0u ? " " : ", ");
			out.append_u32(static_cast<eng::u32>(n));
		}
		out.append(" };\n\n");
		out.append("/// Devuelve el bloque de la(s) ventana(s) conmutable(s) para (pc, b0..b3).\n");
		out.append("/// MMC1/UxROM: `b0`. MMC3: `b0`=R6, `b1`=R7. FME-7: `b0`/`b1`/`b2`.\n");
		out.append("/// VRC6: `b0` ($8000) / `b1` ($C000). MMC5: `b0..b3` ($8000..$E000).\n");
		out.append("[[maybe_unused]] static BlockFn n2a_banked_block(eng::u16 pc, eng::u8 b0, eng::u8 b1, eng::u8 b2, eng::u8 b3) {\n");
		if (mapper_ == 5) {
			out.append("    const eng::u8 bank = (pc < 0xA000u) ? b0 : ((pc < 0xC000u) ? b1 : ((pc < 0xE000u) ? b2 : b3));\n");
		} else if (mapper_ == 4) {
			out.append("    (void)b2;\n    (void)b3;\n    const eng::u8 bank = (pc < 0xA000u) ? b0 : b1;\n");
		} else if (mapper_ == 69) {
			out.append("    (void)b3;\n    const eng::u8 bank = (pc < 0xA000u) ? b0 : ((pc < 0xC000u) ? b1 : b2);\n");
		} else if (mapper_ == 24 || mapper_ == 26) {
			out.append("    (void)b2;\n    (void)b3;\n    const eng::u8 bank = (pc < 0xC000u) ? b0 : b1;\n");
		} else {
			out.append("    (void)b1;\n    (void)b2;\n    (void)b3;\n    const eng::u8 bank = b0;\n");
		}
		out.append("    if (bank >= kPrgBankCount) { return nullptr; }\n");
		out.append("    const BankBlock* t = kBankTables[bank];\n");
		out.append("    eng::u16 lo = 0u;\n");
		out.append("    eng::u16 hi = kBankCounts[bank];\n");
		out.append("    while (lo < hi) {\n");
		out.append("        const eng::u16 mid = static_cast<eng::u16>(lo + (hi - lo) / 2u);\n");
		out.append("        const eng::u16 s = t[mid].start;\n");
		out.append("        if (s == pc) { return t[mid].fn; }\n");
		out.append("        if (s < pc) { lo = static_cast<eng::u16>(mid + 1u); } else { hi = mid; }\n");
		out.append("    }\n");
		out.append("    return nullptr;\n}\n\n");
		out.append("/// Punto de entrada del juego. Arranca en el vector de reset y ejecuta\n");
		out.append("/// bloques despachados por cpu.PC hasta que el PC no tenga bloque (retorno)\n");
		out.append("/// o la CPU se detenga (BRK). No reserva recursos; usa g_state.\n");
		out.append("void game_main() {\n");
		out.append("    CPU& cpu = g_state.cpu;\n");
		out.append("    cpu.mem = &g_state.mem;\n");
		out.append("    g_state.mem.prg = PRG_ROM;\n");
		out.append("    g_state.mem.prg_size = static_cast<eng::u32>(kPrgSize);\n");
		out.append("    init_dispatch_table();\n");
		out.append("    cpu.PC = 0x");
		out.append_hex(reset_, 4u, true);
		out.append(";\n");
		out.append("    for (;;) {\n");
		out.append("        BlockFn fn = n2a_fixed_block(cpu.PC);\n");
		out.append("        if (fn == nullptr) { return; }\n");
		// Encadenado: el bloque puede ceder (`yield`) para que el runtime resuelva
		// eventos (NMI/PPU). Se limpia antes de cada despacho; `PC` ya apunta a donde
		// continuar (el propio bloque de espera re-evaluado, o el retorno de subrutina).
		out.append("        cpu.yield = false;\n");
		out.append("        fn(cpu);\n");
		out.append("        if (cpu.halted) { return; }\n");
		out.append("    }\n}\n\n");
		out.append("#if !defined(__m68k__) && !defined(N2A_NO_HOST_MAIN)\n");
		out.append("/// Entrada host para tests. En Amiga el runtime llama a game_main() y este\n");
		out.append("/// símbolo queda excluido (por __m68k__ o por N2A_NO_HOST_MAIN).\n");
		out.append("int main() { game_main(); return 0; }\n");
		out.append("#endif\n");
	}
};

} // namespace n2a

