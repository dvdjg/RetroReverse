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
	void generate(Dyn& out) const {
		emit_header(out);
		out.append("#include \"nes_runtime.hpp\"\n");
		out.append("using n2a::CPU;\n");
		out.append("using n2a::NESMemory;\n\n");
		emit_rom(out);
		emit_blocks(out);
		emit_dispatch(out);
	}

	/// Registra un hecho de valores que el codegen emitirá como `N2A_ASSUME` en
	/// los bloques que lean esa dirección. Llamar antes de `generate()`.
	/// \param f Hecho a añadir (se copia).
	void add_fact(const Fact& f) { (void)facts_.push_back(f); }

	/// Número de mapper iNES de la ROM cargada (siempre 0 en esta versión).
	[[nodiscard]] int mapper() const noexcept { return mapper_; }
	/// Tamaño de la PRG-ROM en bytes.
	[[nodiscard]] eng::u32 prg_size() const noexcept { return prg_size_; }
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
	eng::u32 prg_size_ = 0;                                   ///< Tamaño de PRG en bytes.
	int mapper_ = 0;                                          ///< Número de mapper iNES.
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
	eng::util::Vector<Fact, eng::util::HeapAlloc> facts_ {};            ///< Hechos de valores (ver `add_fact`).

	eng::usize count_ = 0;       ///< Instrucciones decodificadas.
	eng::usize unknown_ = 0;     ///< Opcodes desconocidos encontrados.
	eng::usize block_count_ = 0; ///< Bloques detectados.

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
	/// \return `true` si es NROM con PRG no vacía (único caso soportado hoy).
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
	/// Aplica el espejo de 16 KB de NROM. \return vacío si la dirección no es PRG.
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
		out.append("//   - dispatch_table: 0x10000 punteros a función.\n");
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

		// Las ramas y `JMP` **siempre** vuelven al despacho (`cpu.PC = destino;
		// return;`), sin `goto` interno: así el runtime puede avanzar la PPU entre
		// bloques y no se cuelga en un bucle de espera de VBlank. `block_start` ya
		// no decide nada aquí (se conserva el parámetro por uniformidad).
		(void)block_start;
		// Coste exacto en `cpu.cycles`: base + penalización de página/rama, igual
		// que el intérprete del runtime. El runtime lee el delta por bloque.
		auto emit_base = [&]() {
			out.append("    cpu.cycles += ");
			out.append_u32(op_base_cycles(in.opcode));
			out.append("u;\n");
		};

		if (info.mode == AddrMode::Rel) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			emit_base();
			out.append("    if (");
			out.append(branch_cond(m));
			out.append(") { cpu.cycles += 1u;");
			// Cruce de página de la rama: `pc+2` vs destino (estático).
			if (((in.addr + 2u) & 0xFF00u) != (in.target & 0xFF00u)) {
				out.append(" cpu.cycles += 1u;");
			}
			out.append(" cpu.PC = 0x");
			out.append_hex(in.target, 4u, true);
			out.append("; return; }\n");
			return;
		}
		if (sv_equal(m, "JMP") && info.mode == AddrMode::Abs) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			emit_base();
			out.append("    cpu.PC = 0x");
			out.append_hex(in.target, 4u, true);
			out.append("; return;\n");
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
			out.append("    cpu.JSR_abs(0x");
			out.append_hex(in.target, 4u, true);
			out.append(", 0x");
			out.append_hex(static_cast<eng::u16>(in.addr + 3u), 4u, true);
			out.append("); return;\n");
			return;
		}
		if (sv_equal(m, "RTS") || sv_equal(m, "RTI") || sv_equal(m, "BRK")) {
			out.append("    ");
			append_comment(out, in, info);
			out.append('\n');
			emit_base();
			out.append("    cpu.");
			out.append(m);
			out.append("(); return;\n");
			return;
		}
		// Instrucción corriente: ciclos (+ penalización si lectura indexada) y
		// llamada al método de CPU con su comentario.
		emit_base();
		if (op_read_indexed_penalty(in.opcode)) {
			if (info.mode == AddrMode::AbsX) {
				out.append("    if (((0x");
				out.append_hex(static_cast<eng::u16>(in.operand & 0xFFu), 2u, true);
				out.append("u) + cpu.X) > 0xFFu) { cpu.cycles += 1u; }\n");
			} else if (info.mode == AddrMode::AbsY) {
				out.append("    if (((0x");
				out.append_hex(static_cast<eng::u16>(in.operand & 0xFFu), 2u, true);
				out.append("u) + cpu.Y) > 0xFFu) { cpu.cycles += 1u; }\n");
			} else if (info.mode == AddrMode::IndY) {
				out.append("    { const eng::u16 p = static_cast<eng::u16>(cpu.mem->read(0x");
				out.append_hex(in.operand, 4u, true);
				out.append(") | (static_cast<eng::u16>(cpu.mem->read(0x");
				out.append_hex(static_cast<eng::u16>(in.operand + 1u), 4u, true);
				out.append(")) << 8u)); if (((p & 0xFFu) + cpu.Y) > 0xFFu) { cpu.cycles += 1u; } }\n");
			}
		}
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

	void emit_blocks(Dyn& out) const {
		out.append("// ---- Basic blocks ----\n\n");
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] != 0u) {
				const int heat = hot_count(static_cast<eng::u16>(a));
				out.append("static void ");
				if (heat > 0) {
					out.append("__attribute__((hot)) ");
				} else if (heat == 0) {
					out.append("__attribute__((cold)) ");
				}
				out.append("bb_");
				out.append_hex(static_cast<eng::u16>(a), 4u, true);
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
			emit_block_doc(out, start);
			// Calor del bloque (telemetría `--facts`): `hot`/`cold` guían al
			// compilador (reordenado y `-Os` en los fríos). Sin dato, sin marca.
			const int heat = hot_count(start);
			out.append("static void ");
			if (heat > 0) {
				out.append("__attribute__((hot)) ");
			} else if (heat == 0) {
				out.append("__attribute__((cold)) ");
			}
			out.append("bb_");
			out.append_hex(start, 4u, true);
			out.append("(CPU& cpu) {\n");
			// (Sin etiquetas internas: las ramas vuelven al despacho por `cpu.PC`.)
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

	/// Escribe el despacho y la entrada del programa: la firma `BlockFn`, la tabla
	/// `dispatch_table` indexada por `cpu.PC`, el estado global `g_state`, el
	/// inicializador `init_dispatch_table()`, `game_main()` y el `main()` de host
	/// (excluido en Amiga o con `N2A_NO_HOST_MAIN`).
	void emit_dispatch(Dyn& out) const {
		out.append("// ---- Despacho y entrada ----\n\n");
		out.append("/// Firma de un basic block: recibe el CPU (y su memoria) y muta el estado.\n");
		out.append("using BlockFn = void (*)(CPU&);\n\n");
		out.append("/// Tabla de despacho indexada por cpu.PC (0x0000..0xFFFF);\n");
		out.append("/// nullptr en las direcciones que no son inicio de bloque.\n");
		out.append("static BlockFn dispatch_table[0x10000] = {};\n\n");
		out.append("/// Estado global del juego (CPU + memoria), accesible por el runtime y por\n");
		out.append("/// los tests host (para comprobar el resultado de una ejecución).\n");
		out.append("struct GameState { CPU cpu; NESMemory mem; };\n");
		out.append("static GameState g_state;\n\n");
		out.append("/// Rellena dispatch_table con la dirección de inicio de cada basic block.\n");
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
		out.append("/// Ciclos base estimados del bloque que empieza en `pc` (sin penalización de\n");
		out.append("/// página/rama). Permite al runtime avanzar la PPU al ejecutar bloques\n");
		out.append("/// generados (camino transpilado). `2u` por defecto si `pc` no es un bloque.\n");
		out.append("[[maybe_unused]] static eng::u16 n2a_block_cycles(eng::u16 pc) {\n    switch (pc) {\n");
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] == 0u) {
				continue;
			}
			out.append("    case 0x");
			out.append_hex(static_cast<eng::u16>(a), 4u, true);
			out.append(": return ");
			out.append_u32(block_base_cycles(static_cast<eng::u16>(a)));
			out.append("u;\n");
		}
		out.append("    default: return 2u;\n    }\n}\n\n");
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
		out.append("        BlockFn fn = dispatch_table[cpu.PC];\n");
		out.append("        if (fn == nullptr) { return; }\n");
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
