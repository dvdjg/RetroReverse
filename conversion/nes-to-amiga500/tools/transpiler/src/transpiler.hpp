#pragma once

/// \file transpiler.hpp
/// NÃºcleo del transpilador NESâ†’Amiga (fase 1): parsea la cabecera iNES, obtiene
/// la PRG-ROM y sus vectores, la desensambla de forma recursiva, agrupa las
/// instrucciones en *basic blocks* y emite un `.cpp` C++23 que usa el runtime del
/// nodo (`runtime/include/nes_runtime.hpp`). Todo sobre `eng/core` (sin STL).
///
/// DiseÃ±o y fases en [`../../docs/TRANSPILER.md`](../../docs/TRANSPILER.md).
/// Alcance actual: NROM (mapper 0), opcodes oficiales + ilegales frecuentes.

#include <eng/core/types/types.hpp>
#include <eng/core/util/dynamic_string.hpp>
#include <eng/core/util/heap_alloc.hpp>
#include <eng/core/util/optional.hpp>
#include <eng/core/util/string_view.hpp>
#include <eng/core/util/vector.hpp>

#include "opcodes.hpp"

namespace n2a {

/// BÃºfer de texto de salida del codegen: cadena que crece en el heap del host.
using Dyn = eng::util::DynamicString<eng::util::HeapAlloc>;

/// Una instrucciÃ³n de 6502 ya decodificada y ubicada en el espacio de la CPU.
///
/// `operand` guarda el operando **tal cual aparece en la ROM** (inmediato de 8
/// bits, direcciÃ³n de pÃ¡gina cero o direcciÃ³n absoluta de 16 bits). `target` es
/// el destino resuelto de ramas y de `JMP`/`JSR` absolutos; para el resto de
/// modos vale 0 y no debe usarse. Los bits `has_operand`/`has_target` de `flags`
/// indican cuÃ¡les de esos campos son vÃ¡lidos.
struct Instruction {
	eng::u16 addr = 0;    ///< DirecciÃ³n 6502 donde empieza la instrucciÃ³n.
	eng::u16 operand = 0; ///< Operando inmediato o direcciÃ³n, segÃºn el modo.
	eng::u16 target = 0;  ///< Destino resuelto de rama/JMP/JSR (si `has_target`).
	eng::u8 opcode = 0;   ///< Byte de opcode (Ã­ndice en `kOpcodeTable`).
	eng::u8 flags = 0;    ///< bit0 = operando vÃ¡lido, bit1 = destino vÃ¡lido.
};

/// El campo `flags` de `Instruction` marca que `operand` es vÃ¡lido.
inline constexpr eng::u8 kHasOperand = 0x01u;
/// El campo `flags` de `Instruction` marca que `target` es vÃ¡lido.
inline constexpr eng::u8 kHasTarget = 0x02u;

/// Ciclos **base** (sin penalizaciÃ³n de pÃ¡gina/rama) de cada opcode 6502, igual
/// que la tabla del intÃ©rprete del runtime. Se usa para estimar los ciclos de un
/// bloque en el cÃ³digo generado (`n2a_block_cycles`), de modo que el runtime pueda
/// avanzar la PPU al ejecutar bloques generados. La estimaciÃ³n omite solo las
/// penalizaciones dependientes de datos (â‰¤ 1 ciclo por instrucciÃ³n).
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

/// Â¿La lectura de `op` usa direccionamiento indexado que penaliza **+1 ciclo** al
/// cruzar de pÃ¡gina? (Las escrituras y los RMW no penalizan.) Debe coincidir con
/// el intÃ©rprete del runtime para que la temporalizaciÃ³n sea idÃ©ntica.
/// \param op Byte de opcode.
/// \return `true` si cruzar pÃ¡gina aÃ±ade un ciclo.
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

/// Clase de hecho de valores sobre una direcciÃ³n (aportado por anÃ¡lisis o
/// telemetrÃ­a; ver [`../../docs/OPTIMIZATION.md`](../../docs/OPTIMIZATION.md)).
enum class FactKind : eng::u8 {
	Eq,     ///< Siempre vale `values[0]`.
	Range,  ///< EstÃ¡ en `[0, values[1]]` (`values[0]` = mÃ­nimo, informativo).
	Set,    ///< Pertenece al conjunto `values[0..count-1]`.
	Power2, ///< Es una potencia de dos (o cero).
	Hot,    ///< `addr` es inicio de bloque y se ejecutÃ³ `count` veces (0 = nunca).
};

/// Hecho sobre una direcciÃ³n que el codegen consume: los de **valor**
/// (`Eq`/`Range`/`Set`/`Power2`) se traducen a `N2A_ASSUME` en los bloques que
/// leen esa direcciÃ³n; los de **calor** (`Hot`) marcan el bloque como
/// `__attribute__((hot))`/`((cold))` para reordenar y ajustar el cÃ³digo (ver
/// [`../../docs/OPTIMIZATION.md`](../../docs/OPTIMIZATION.md)).
struct Fact {
	FactKind kind = FactKind::Eq; ///< InterpretaciÃ³n de `values`/`count`.
	eng::u16 addr = 0;            ///< DirecciÃ³n observada (valor) o inicio de bloque (calor).
	eng::u8 values[4] {};         ///< Valores segÃºn `kind`.
	eng::u8 count = 0;            ///< NÂº de valores usados (para `Set`).
	eng::u32 heat = 0;            ///< Ejecuciones observadas (para `Hot`).
};

/// Transpilador de una ROM NES (NROM) a C++23.
///
/// Ciclo de vida (llamar en este orden):
/// 1. `load()`            â€” valida y descompone la ROM en `rom_`/`prg_`.
/// 2. `disassemble()`     â€” decodifica las instrucciones alcanzables.
/// 3. `build_basic_blocks()` â€” calcula lÃ­deres y metadatos de bloques.
/// 4. `generate()`        â€” escribe el `.cpp` en un `Dyn`.
///
/// El objeto mantiene tablas de 0x10000 entradas indexadas por direcciÃ³n 6502
/// (instrucciÃ³n, marcas); por eso su coste en memoria es de unos pocos cientos
/// de KB, aceptable en la herramienta host (no en el Amiga).
class Transpiler {
public:
	/// Reserva las tablas indexadas por direcciÃ³n (0x0000..0xFFFF). El coste se
	/// paga una vez y evita buscar en mapas durante el anÃ¡lisis.
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

	/// Carga una ROM iNES ya leÃ­da en memoria.
	///
	/// Comprueba la firma `NES\x1A`, copia los bytes a `rom_` y delega en
	/// `parse_header()` y `extract_prg()`. Es el Ãºnico punto de entrada de datos.
	///
	/// \param data Puntero a los bytes de la ROM (no se conserva el puntero).
	/// \param size NÃºmero de bytes.
	/// \return `true` si es una ROM iNES NROM vÃ¡lida y no truncada.
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

	/// Escanea la PRG en busca del idioma de **tabla de salto** y aÃ±ade sus destinos
	/// como puntos de entrada al desensamblado: cobertura de CFG **determinista**, sin
	/// depender de una traza. PatrÃ³n (13 bytes):
	///
	///   `LDA tbl,X` (`$BD lo hi`) ; `STA zp p` (`$85 p`) ; `LDA tbl+1,X` (`$BD lo+1 hi`) ;
	///   `STA zp p+1` (`$85 p+1`) ; `JMP (zp p)` (`$6C p 00`)
	///
	/// Enumera los destinos `tbl[k] | (tbl[1+k] << 8)` mientras caigan en la PRG
	/// (`$8000-$FFFF`), hasta 256. No basta para toda la PRG (el despacho por puntero en
	/// RAM es mÃ¡s comÃºn), pero complementa a `--pc-trace` sin necesitar ejecuciÃ³n.
	/// \return NÂº de tablas encontradas.
	eng::u32 scan_static_jump_tables() {
		if (prg_.size() < 13u || prg_size_ < 13u) {
			return 0u;
		}
		const eng::u32 n = prg_size_;
		eng::u32 found = 0u;
		for (eng::u32 i = 0u; i + 13u <= n; ++i) {
			if (prg_[i] != 0xBDu || prg_[i + 3u] != 0x85u || prg_[i + 5u] != 0xBDu ||
			    prg_[i + 8u] != 0x85u || prg_[i + 10u] != 0x6Cu) {
				continue;
			}
			const eng::u8 lo = prg_[i + 1u];
			const eng::u8 hi = prg_[i + 2u];
			const eng::u8 zp = prg_[i + 4u];
			if (prg_[i + 6u] != static_cast<eng::u8>(lo + 1u) || prg_[i + 7u] != hi ||
			    prg_[i + 9u] != static_cast<eng::u8>(zp + 1u) || prg_[i + 11u] != zp ||
			    prg_[i + 12u] != 0x00u) {
				continue;
			}
			const eng::u16 tbl = static_cast<eng::u16>(lo | (static_cast<eng::u16>(hi) << 8u));
			if (tbl < 0x8000u) {
				continue;
			}
			// Sitio del `JMP ($zp)` â†’ direcciÃ³n CPU (`PRG` se mapea en `$8000`).
			const eng::u16 site = static_cast<eng::u16>(0x8000u + i + 10u);
			const eng::u32 base = static_cast<eng::u32>(tbl - 0x8000u);
			for (eng::u32 k = 0u; k < 256u && base + 1u + k < n; ++k) {
				const eng::u16 tgt = static_cast<eng::u16>(
					prg_[base + k] | (static_cast<eng::u16>(prg_[base + 1u + k]) << 8u));
				if (tgt < 0x8000u) {
					break;
				}
				add_entry_point(tgt);
				// Registra tambiÃ©n el destino como observado para ese sitio, de modo que
				// el backend **nativo** pueda despachar el `JMP (ind)` **sin traza**.
				add_ind_target(site, tgt);
			}
			++found;
		}
		return found;
	}

	/// Desensambla de forma recursiva todas las instrucciones alcanzables.
	///
	/// Usa una pila de trabajo (`worklist_`) con los puntos de entrada: el vector
	/// de reset y, si apuntan a la PRG, los de NMI e IRQ. Desde cada entrada
	/// decodifica en lÃ­nea hasta una instrucciÃ³n de fin de flujo (`JMP`, `JSR`,
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
		// Cobertura **determinista** de saltos por tabla estÃ¡tica (sin traza).
		// `-DN2A_NO_STATIC_TABLES`: desactivar (diagnÃ³stico de regresiones de CFG).
#if !defined(N2A_NO_STATIC_TABLES)
		if (!prg_banked_) {
			(void)scan_static_jump_tables();
		}
#endif
		// Entradas extra de telemetrÃ­a (PC ejecutados): completan el CFG en saltos
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
	/// `bank_` al Ã­ndice del banco.
	void disassemble_bank(const eng::util::Vector<eng::u16, eng::util::HeapAlloc>& entries) {
		for (eng::usize i = 0; i < entries.size(); ++i) {
			push_work(entries[i]);
		}
		run_worklist();
	}

	/// Bucle de desensamblado recursivo comÃºn (usa `worklist_` ya sembrada).
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
				// InstrucciÃ³n truncada al final de la PRG (operandos fuera de la
				// ROM): no es cÃ³digo vÃ¡lido, no se emite (evita llamadas sin
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

	/// Reinicia el estado del anÃ¡lisis para reutilizarlo con otro banco (F9/B1b).
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

	/// Recoge los destinos en `$8000-$BFFF` (JMP/JSR/rama) del anÃ¡lisis actual
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
			// Ventanas conmutables por mapper: MMC3 (2Ã—8 KB), FME-7 (3Ã—8 KB).
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

	/// Calcula los *lÃ­deres* (inicios de basic block) a partir del CFG implÃ­cito.
	///
	/// Un lÃ­der es: el vector de reset/NMI/IRQ, el destino de una rama/`JMP`/`JSR`
	/// y la instrucciÃ³n siguiente a cualquier salto o fin de flujo. DespuÃ©s llama
	/// a `compute_block_metadata()`, que deriva las etiquetas y los destinos que
	/// necesitarÃ¡ el codegen. Debe ejecutarse tras `disassemble()`.
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
		// Puntos de entrada de la **telemetrÃ­a** (`--pc-trace`) y **destinos
		// indirectos observados** (`--ind-targets`) son entradas reales: se marcan
		// como lÃ­deres para que el codegen pueda iniciar ahÃ­ una regiÃ³n (nativo) o un
		// bloque, y para que los checks de entrada (p. ej. destino de `JSR`) los acepten.
		for (eng::usize i = 0; i < extra_entries_.size(); ++i) {
			if (extra_entries_[i] < kSpace && has_instr_[extra_entries_[i]] != 0u) {
				mark_leader(extra_entries_[i]);
			}
		}
		for (eng::usize i = 0; i < ind_target_.size(); ++i) {
			const eng::u16 t = ind_target_[i];
			if (t < kSpace && has_instr_[t] != 0u) {
				mark_leader(t);
			}
		}
		compute_block_metadata();
	}

	/// Deriva los metadatos que usan el codegen y la ficha de cada bloque.
	///
	/// Rellena, para cada direcciÃ³n:
	/// - `labels_`: la etiqueta `L_xxxx` se emite solo si un salto **dentro del
	///   mismo bloque** la usa (auto-bucle). Los saltos entre bloques se resuelven
	///   volviendo al despacho (`cpu.PC = destino; return;`) porque una etiqueta
	///   C++ no es visible desde otra funciÃ³n; asÃ­ se evita `-Wunused-label`.
	/// - `branch_target_`, `jmp_target_`, `jsr_target_`: si la direcciÃ³n es destino
	///   de una rama, de un `JMP` absoluto o de un `JSR` (para la ficha del bloque).
	/// - `fallin_`: si la direcciÃ³n es la continuaciÃ³n natural del bloque anterior.
	///
	/// Se invoca al final de `build_basic_blocks()`; no genera cÃ³digo.
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
	/// \param out BÃºfer de texto donde se acumula la salida (no se vacÃ­a).
	void generate(Dyn& out) {
		if (decompile_) {
			emit_decompile(out);
			return;
		}
		emit_header(out);
		out.append("#include \"nes_runtime.hpp\"\n");
		out.append("using n2a::CPU;\n");
		out.append("using n2a::NESMemory;\n\n");
		emit_rom(out);
		// Backend nativo (estilo descompilador): sustituye todo el codegen por bloques.
		// Con `--best` se elige solo si la ROM lo soporta; si no, cae al codegen por
		// bloques (con el perfil Amiga si el llamador lo activÃ³).
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

	/// Registra un hecho de valores que el codegen emitirÃ¡ como `N2A_ASSUME` en
	/// los bloques que lean esa direcciÃ³n. Llamar antes de `generate()`.
	/// \param f Hecho a aÃ±adir (se copia).
	void add_fact(const Fact& f) { (void)facts_.push_back(f); }

	/// AÃ±ade un **punto de entrada** extra al desensamblado (p. ej. los PC ejecutados
	/// observados por telemetrÃ­a: `opcode_hist ... <hot.txt>`). Completa el CFG cuando
	/// el anÃ¡lisis estÃ¡tico no puede seguir un salto indirecto/tabla. Llamar **antes**
	/// de `disassemble()`; se ignora en PRG bancada (solo ventana fija).
	/// \param a DirecciÃ³n 6502 de inicio de cÃ³digo (`$8000-$FFFF`).
	void add_entry_point(eng::u16 a) { (void)extra_entries_.push_back(a); }

	/// Registra el **destino observado** de un `JMP (ind)` en el sitio `site`
	/// (telemetrÃ­a de `ind_targets <rom> <out>`, consumida por `--ind-targets`).
	/// Permite al backend nativo emitir un **despacho** (`switch`) en lugar de
	/// caer al intÃ©rprete. Deduplica el par. Llamar **antes** de `disassemble()`.
	/// \param site   `PC` del opcode `$6C`.
	/// \param target `PC` destino observado (inicio de instrucciÃ³n).
	void add_ind_target(eng::u16 site, eng::u16 target) {
		for (eng::usize i = 0; i < ind_site_.size(); ++i) {
			if (ind_site_[i] == site && ind_target_[i] == target) {
				return;
			}
		}
		(void)ind_site_.push_back(site);
		(void)ind_target_.push_back(target);
	}

	/// \return NÂº de destinos observados para el sitio `site` (`0` si no hay datos).
	[[nodiscard]] eng::usize ind_targets_count(eng::u16 site) const {
		eng::usize n = 0;
		for (eng::usize i = 0; i < ind_site_.size(); ++i) {
			if (ind_site_[i] == site) {
				++n;
			}
		}
		return n;
	}

	/// Con `true`, **no** se emite la contabilidad de ciclos (`cpu.cycles += N`) ni
	/// las penalizaciones de pÃ¡gina/rama. Para destinos sin PPU ciclo-exacta
	/// (Amiga/`--release`), donde los ciclos solo agobian al 68000.
	/// \param b `true` para desactivar los ciclos.
	void set_no_cycles(bool b) noexcept { no_cycles_ = b; }

	/// Con `true`, emite `N2A_TRACE(0xADDR);` antes de cada instrucciÃ³n, para
	/// trazar el flujo del codegen y compararlo con el intÃ©rprete. Sin definir,
	/// `N2A_TRACE` es un no-op (coste cero). \param b `true` para activar la traza.
	void set_trace(bool b) noexcept { trace_ = b; }

	/// Con `true`, las instrucciones de **zero-page** se emiten con acceso directo a
	/// `cpu.mem->ram[...]` (sin el mÃ©todo/`switch` de regiÃ³n). Ganancia en 68000.
	/// \param b `true` para activar el acceso directo a RAM de pÃ¡gina cero.
	void set_fast_ram(bool b) noexcept { fast_ram_ = b; }

	/// Con `true`, **encadena los bloques** por control de flujo estÃ¡tico: un salto,
	/// caÃ­da o `JMP` con destino conocido se emite como **llamada en cola** al bloque
	/// siguiente (`return bb_XXXX(cpu);`), y `JSR`/`RTS` como **llamada/retorno C**
	/// (`bb_call(cpu); return bb_ret(cpu);` / `cpu.pull16(); return;`). Evita el
	/// despachador por bÃºsqueda binaria en cada bloque (el mayor coste en 68000).
	/// Solo se activa con `--no-cycles`: sin cesiÃ³n por deadline el control se
	/// transfiere directamente y el runtime debe ceder en los puntos de evento.
	/// \param b `true` para encadenar bloques.
	void set_chain(bool b) noexcept { chain_ = b; }
	/// Con `false`, **desactiva** los idioms multibyte (copia/constante/suma/resta 16 bits).
	/// Sirve para medir su efecto (tamaÃ±o/ciclos 68000) frente al byte a byte.
	/// \param b `true` (por defecto) para aplicar idioms.
	void set_idioms(bool b) noexcept { idioms_ = b; }

	/// Con `true`, las lecturas de la ventana fija de ROM (NROM/CNROM, `Abs`/`AbsX`/
	/// `AbsY`) se emiten como **acceso directo a `PRG_ROM[...]`** (constexpr) en vez
	/// de pasar por `NESMemory::read` (que decodifica regiÃ³n y hace `idx % prg_size`,
	/// una libcall de 32 bits en 68000). Permite a g++ ver los datos fijos.
	/// \param b `true` para emitir lecturas directas de ROM.
	void set_rom_direct(bool b) noexcept { rom_direct_ = b; }

	/// Con `true`, emite un **backend "nativo" estilo descompilador**: en vez de bloques
	/// que llaman a mÃ©todos de `CPU` (con el estado en `struct`), genera **una funciÃ³n C++
	/// por REGIÃ“N** (punto de entrada = `reset`/NMI/IRQ/`JSR`) con el estado del 6502 en
	/// **variables locales** (`a/x/y/flags`), lecturas de ROM como **literales** (PRG fija)
	/// y control de flujo C++ normal (`goto`). AsÃ­ el optimizador global de g++ puede
	/// propagar valores, plegar constantes y asignar registros entre bloques.
	/// Solo para **PRG no bancada** y sin opcodes indirectos/ilegales (si no, el llamador
	/// debe usar el codegen por bloques).
	/// \param b `true` para activar el backend nativo.
	void set_native(bool b) noexcept { native_ = b; }
	/// Con `true`, emite el **decompilado** (port nativo en C plano + HAL) en vez del
	/// codegen de emulaciÃ³n. Fase 1 del decompilador (ver `docs/DECOMPILADOR.md`).
	/// \param b `true` para generar el decompilado.
	void set_decompile(bool b) noexcept { decompile_ = b; }
	/// Activa el **frame boundary por VBlank**: `tick(n)` deja de comprobar el limite de frame
	/// (solo acumula ciclos para el modelo hibrido); el NMI lo dispara el busy-wait (spin-yield) y
	/// `hal_wait_vblank`. Mucho mas rapido en A1200; el modelo de ciclos sigue disponible para PC.
	void set_vblank_sync(bool b) noexcept { vblank_sync_ = b; }
	/// Activa el **flatten del grafo a una sola funcion**: los `JSR` se resuelven con `goto` y los
	/// `RTS` con `goto *puntero_de_retorno` (extension GCC). Sin llamadas C, el compilador puede
	/// mantener A/X/Y/flags en REGISTROS (con las globales no puede: `ram[]` puede aliase).
	void set_flat(bool b) noexcept { flat_ = b; }

	/// En modo **flat**, entra al NMI inline si `frame_event` lo marco (`g_nmi_pending`):
	/// apila el puntero de retorno `&&L_nmiret_<n>` y salta al bloque del NMI (`L_<nmi_>`).
	/// El `RTI` del NMI hara `goto *ret_lbl[--ret_sp]` de vuelta a la etiqueta aqui emitida,
	/// de modo que A/X/Y/flags permanecen en registros (sin `call`/`ret` C al NMI).
	/// \param out Buffer de salida. \param b Bloque de origen (solo para etiqueta unica).
	void emit_nmi_enter(Dyn& out, eng::u16 b) {
		const eng::u32 n = nmi_enter_seq_++;
		// Se limpia `g_yield_req` para que el NMI corra HASTA COMPLETARSE: `ret_lbl` es una
		// LOCAL de `n2a_run`; si el NMI cediera a mitad, al reanudar en otra llamada la pila
		// de retorno se habria perdido (underflow). Tras el NMI se rearma el yield de frame.
		out.append("    if (g_nmi_pending) { g_nmi_pending = 0u; g_yield_req = 0u; ret_lbl[ret_sp++] = &&L_nmiret_");
		out.append_u32(n);
		out.append("; ++g_nmi_fires; goto L_");
		out.append_hex(nmi_, 4u, true);
		out.append("; }\nL_nmiret_");
		out.append_u32(n);
		out.append(": if (g_engine_mode) { g_yield_req = 1u; }\n");
	}

	/// Con `true`, elige automÃ¡ticamente el mejor backend: el **nativo** si la ROM lo
	/// soporta (`native_ok()`) y, si no, el codegen por bloques con el perfil Amiga
	/// (`--chain`/`--rom-direct`/`--fast-ram`, que el llamador debe activar). Pensado
	/// para el pipeline por juego.
	/// \param b `true` para selecciÃ³n automÃ¡tica de backend.
	void set_best(bool b) noexcept { best_ = b; }
	/// \return `true` si el backend nativo puede emitir esta ROM (PRG fija y opcodes
	/// soportados). Lo consulta el llamador para elegir el codegen.
	/// \return El **motivo** por el que `native_ok()` rechazÃ³ la ROM (cadena vacÃ­a si
	/// la aceptÃ³). DiagnÃ³stico para el pipeline; no altera el comportamiento.
	[[nodiscard]] const char* native_reject_reason() const noexcept { return native_reject_; }
	/// \return DirecciÃ³n asociada al Ãºltimo rechazo de `native_ok()` (0 si no aplica).
	[[nodiscard]] eng::u16 native_reject_addr() const noexcept { return native_reject_addr_; }

	[[nodiscard]] bool native_ok() const noexcept {
		native_reject_ = "";
		if (prg_banked_) {
			native_reject_ = "PRG bancada";
			return false;
		}
		if (prg_size_ == 0u || (prg_size_ & (prg_size_ - 1u)) != 0u) {
			native_reject_ = "PRG no potencia de 2";
			return false;
		}
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (has_instr_[a] == 0u) {
				continue;
			}
			// `JMP (ind)` (`$6C`): soportado **solo si** hay destinos observados
			// (`--ind-targets`) para ese sitio; entonces se emite un despacho `switch`.
			if (instr_[a].opcode == 0x6Cu) {
				if (ind_targets_count(static_cast<eng::u16>(a)) == 0u) {
					native_reject_ = "JMP (ind) sin destinos (--ind-targets)";
					native_reject_addr_ = static_cast<eng::u16>(a);
					return false; // sin objetivos conocidos: fallback al por bloques
				}
				continue;
			}
			if (!native_supported(kOpcodeTable[instr_[a].opcode])) {
				native_reject_ = "opcode no soportado en nativo";
				return false;
			}
			// Todo destino de `JSR` debe estar **decodificado** (serÃ¡ entrada de regiÃ³n).
			const Instruction& in = instr_[a];
			if (sv_equal(kOpcodeTable[in.opcode].mnemonic, "JSR") && has_operand(in) &&
			    !(in.target < kSpace && has_instr_[in.target] != 0u)) {
				native_reject_ = "destino de JSR no decodificado";
				native_reject_addr_ = static_cast<eng::u16>(a);
				return false;
			}
		}
		return true;
	}

	/// NÃºmero de mapper iNES de la ROM cargada.
	[[nodiscard]] int mapper() const noexcept { return mapper_; }
	/// TamaÃ±o de la PRG-ROM en bytes.
	[[nodiscard]] eng::u32 prg_size() const noexcept { return prg_size_; }
	/// TamaÃ±o de banco de PRG en bytes (NROM/CNROM: la PRG entera).
	[[nodiscard]] eng::u32 prg_bank_size() const noexcept { return prg_bank_size_; }
	/// NÃºmero de bancos de PRG (NROM/CNROM: 1).
	[[nodiscard]] eng::u32 prg_bank_count() const noexcept { return prg_bank_count_; }
	/// `true` si la PRG estÃ¡ **bancada** (UxROM/MMC1/MMC3/MMC5/VRC6/FME-7). El
	/// codegen **por banco** es el trabajo pendiente de F9; hoy el transpilador
	/// solo emite PRG fija (NROM/CNROM). Ver `docs/TRANSPILER_BANKING.md`.
	[[nodiscard]] bool prg_banked() const noexcept { return prg_banked_; }
	/// NÃºmero de instrucciones decodificadas.
	[[nodiscard]] eng::usize instruction_count() const noexcept { return count_; }
	/// NÃºmero de *basic blocks* detectados.
	[[nodiscard]] eng::usize block_count() const noexcept { return block_count_; }
	/// \return NÂº de idioms multibyte aplicados (diagnÃ³stico de mediciÃ³n).
	[[nodiscard]] eng::u32 idiom_hits() const noexcept { return idiom_hits_; }
	/// \return De los idioms, los casados por el **IR flexible** (`try_ir_multibyte`).
	[[nodiscard]] eng::u32 idiom_ir_hits() const noexcept { return ir_hits_; }
	/// \return De los idioms, los casados por el matcher **exacto**.
	[[nodiscard]] eng::u32 idiom_exact_hits() const noexcept { return exact_hits_; }
	/// Vector de reset (`$FFFC`).
	[[nodiscard]] eng::u16 reset_vector() const noexcept { return reset_; }
	/// Vector de NMI (`$FFFA`).
	[[nodiscard]] eng::u16 nmi_vector() const noexcept { return nmi_; }
	/// Vector de IRQ/BRK (`$FFFE`).
	[[nodiscard]] eng::u16 irq_vector() const noexcept { return irq_; }
	/// Opcodes encontrados que no estÃ¡n en la tabla (posible cÃ³digo no alcanzado).
	[[nodiscard]] eng::usize unknown_count() const noexcept { return unknown_; }

private:
	/// TamaÃ±o del espacio de direcciones del 6502: Ã­ndices `0x0000..0xFFFF`.
	static constexpr eng::u32 kSpace = 0x10000u;

	eng::util::Vector<eng::u8, eng::util::HeapAlloc> rom_ {}; ///< ROM iNES completa.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> prg_ {}; ///< Solo la PRG-ROM.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> chr_ {}; ///< Solo la CHR-ROM (si la hay).
	eng::u32 prg_size_ = 0;                                   ///< TamaÃ±o de PRG en bytes.
	eng::u32 chr_size_ = 0;                                   ///< TamaÃ±o de CHR en bytes (0 = CHR RAM).
	int mapper_ = 0;                                          ///< NÃºmero de mapper iNES.
	eng::u32 prg_bank_size_ = 0;                              ///< TamaÃ±o de banco de PRG (layout).
	eng::u32 prg_bank_count_ = 1;                             ///< NÂº de bancos de PRG (layout).
	bool prg_banked_ = false;                                 ///< Â¿PRG bancada? (codegen F9/B1b).

	/// InformaciÃ³n de un bloque para las tablas de despacho.
	struct BlockInfo {
		eng::u8 bank;    ///< 0xFF = ventana fija; 0.. = banco conmutable (UxROM).
		eng::u16 start;  ///< DirecciÃ³n 6502 de inicio del bloque.
		eng::u16 cycles; ///< Ciclos base del bloque (para avanzar la PPU).
	};
	int bank_ = -1; ///< Contexto de anÃ¡lisis: -1 = fijo; >=0 = banco conmutable.
	int win_ = -1;  ///< Ventana MMC3: -1 = fija; 0 = `$8000-$9FFF`; 1 = `$A000-$BFFF`.
	eng::util::Vector<BlockInfo, eng::util::HeapAlloc> fixed_blocks_ {}; ///< Bloques de $C000+ (o NROM).
	eng::util::Vector<BlockInfo, eng::util::HeapAlloc> bank_blocks_ {};  ///< Bloques de la ventana conmutable.
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> switch_targets_ {}; ///< Entradas de $8000-$BFFF (o W0 MMC3).
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> switch_targets2_ {}; ///< Entradas de $A000-$BFFF (W1).
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> switch_targets3_ {}; ///< Entradas de $C000-$DFFF (W2 FME-7).
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> switch_targets4_ {}; ///< Entradas de $E000-$FFFF (W3 MMC5).
	bool mirror_h_ = false;                                   ///< Mirroring horizontal (bit0 flags6).
	bool has_trainer_ = false;                                ///< Â¿Trae trainer de 512 B?
	eng::u16 reset_ = 0;                                      ///< Vector de reset.
	eng::u16 nmi_ = 0;                                        ///< Vector de NMI.
	eng::u16 irq_ = 0;                                        ///< Vector de IRQ.

	eng::util::Vector<Instruction, eng::util::HeapAlloc> instr_ {}; ///< InstrucciÃ³n por direcciÃ³n.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> has_instr_ {}; ///< 1 si la direcciÃ³n tiene instrucciÃ³n.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> leaders_ {};   ///< 1 si la direcciÃ³n inicia bloque.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> labels_ {};    ///< 1 si hay que emitir `L_xxxx`.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> branch_target_ {}; ///< Destino de rama.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> jmp_target_ {};    ///< Destino de `JMP` abs.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> jsr_target_ {};    ///< Destino de `JSR`.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> fallin_ {};        ///< ContinuaciÃ³n del bloque previo.
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> visited_ {};       ///< Direcciones ya desensambladas.
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> worklist_ {};     ///< Pila de puntos de entrada.
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> extra_entries_ {}; ///< Entradas extra (telemetrÃ­a de PC).
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> ind_site_ {};     ///< Sitios de `JMP (ind)` (ver `add_ind_target`).
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> ind_target_ {};   ///< Destino observado paralelo a `ind_site_`.
	eng::util::Vector<Fact, eng::util::HeapAlloc> facts_ {};            ///< Hechos de valores (ver `add_fact`).

	eng::usize count_ = 0;       ///< Instrucciones decodificadas.
	eng::usize unknown_ = 0;     ///< Opcodes desconocidos encontrados.
	eng::usize block_count_ = 0; ///< Bloques detectados.
	bool no_cycles_ = false;     ///< Si `true`, no emitir ciclos (ver `set_no_cycles`).
	bool fast_ram_ = false;      ///< Si `true`, zero-page con acceso directo (ver `set_fast_ram`).
	bool trace_ = false;         ///< Si `true`, emitir `N2A_TRACE` por instrucciÃ³n (ver `set_trace`).
	bool chain_ = false;         ///< Si `true`, encadenar bloques (ver `set_chain`).
	bool idioms_ = true;         ///< Si `true`, aplicar idioms multibyte (ver `set_idioms`).
	bool rom_direct_ = false;    ///< Si `true`, lecturas directas de ROM (ver `set_rom_direct`).
	bool native_ = false;        ///< Si `true`, backend nativo por regiones (ver `set_native`).
	bool decompile_ = false;     ///< Si `true`, emitir el decompilado (ver `set_decompile`).
	/// Flags (ZNCV) que la instruccion actual DEBE fijar (vivacidad): los `setnz`/`Cf`/`Vf` de
	/// flags no vivos se OMITEN (no simular trabajo absurdo). 0xFF = fijar todos (conservador).
	eng::u8 d_keep_flags_ = 0xFFu;
	bool vblank_sync_ = false;   ///< Si `true`, frame boundary por VBlank (sin tick/frame por instruccion; ver `set_vblank_sync`).
	bool flat_ = false;          ///< Si `true`, flatea el grafo a UNA funcion (goto computado para RTS) para A/X/Y en registros.
	eng::u32 nmi_enter_seq_ = 0; ///< Contador de puntos de entrada al NMI inline (flat); etiquetas unicas.
	mutable const char* native_reject_ = ""; ///< Motivo del Ãºltimo rechazo de `native_ok()` (diagnÃ³stico).
	mutable eng::u16 native_reject_addr_ = 0; ///< DirecciÃ³n asociada al rechazo (p. ej. el `JSR`).
	mutable eng::u32 idiom_hits_ = 0;         ///< Idioms multibyte aplicados (diagnÃ³stico).
	mutable eng::u32 ir_hits_ = 0;            ///< De ellos, casados por el IR flexible.
	mutable eng::u32 exact_hits_ = 0;         ///< De ellos, casados por el matcher exacto.
	bool best_ = false;          ///< Si `true`, elige nativo si es posible (ver `set_best`).
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> native_vis_ {}; ///< Scratch de regiones.
	eng::util::Vector<eng::u16, eng::util::HeapAlloc> decomp_region_of_ {}; ///< bloque -> region (decompilado).
	eng::util::Vector<eng::u8, eng::util::HeapAlloc> emitted_ {}; ///< flatten: bloques ya emitidos.
	/// VSA de Ã­ndices del nativo: `LDX/LDY #imm` fija el valor; otra escritura lo invalida.
	/// Permite plegar `LDA tabla,X` a literal cuando `X` es constante en el bloque.
	bool native_x_known_ = false;
	bool native_y_known_ = false;
	bool native_a_known_ = false;
	eng::u8 native_x_val_ = 0;
	eng::u8 native_y_val_ = 0;
	eng::u8 native_a_val_ = 0;
	/// DirecciÃ³n cuya **primera instrucciÃ³n** debe omitirse al emitir su bloque (para
	/// absorberse en un idiom, p. ej. el `DEC lo` de un decremento de 16 bits).
	eng::u16 native_skip_first_ = 0xFFFFu;
	int cur_bank_ = -1;          ///< Banco del bloque en emisiÃ³n (`-1` = ventana fija).
	bool cur_nz_live_ = true;    ///< Â¿`Z`/`N` viven tras la instrucciÃ³n actual? (liveness, ver `nz_dead_after`).

	// --- Utilidades internas ---

	/// Compara un mnemÃ³nico de la tabla con un literal (sin construir `StringView`
	/// en el llamador). \return `true` si son iguales.
	[[nodiscard]] static bool sv_equal(const char* mnemonic, const char* other) noexcept {
		eng::util::StringView a(mnemonic);
		eng::util::StringView b(other);
		return a == b;
	}
	/// \return `true` si `in` tiene operando vÃ¡lido.
	[[nodiscard]] static bool has_operand(const Instruction& in) noexcept {
		return (in.flags & kHasOperand) != 0u;
	}
	/// \return `true` si `in` tiene destino de salto vÃ¡lido.
	[[nodiscard]] static bool has_target(const Instruction& in) noexcept {
		return (in.flags & kHasTarget) != 0u;
	}

	// --- Parseo de la ROM ---

	/// Lee la cabecera iNES (16 bytes) y deriva tamaÃ±o de PRG, mapper y trainer.
	/// \return `true` si la PRG no estÃ¡ vacÃ­a y el mapper tiene **PRG fija**
	///         (NROM 0 o CNROM 3). UxROM (2) y MMC1 (1) conmutan bancos de PRG y
	///         no se pueden decodificar estÃ¡ticamente todavÃ­a.
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
		// Se calcula aunque el mapper no sea aÃºn transpilable, para poder dar un
		// diagnÃ³stico preciso (mapper, nÂº de bancos) y preparar el codegen por
		// banco. El valor de retorno sigue indicando "PRG fija" (NROM/CNROM): solo
		// esas se pueden decodificar estÃ¡ticamente hoy.
		prg_banked_ = false;
		prg_bank_size_ = prg_size_;
		prg_bank_count_ = 1u;
		switch (mapper_) {
		case 2: // UxROM: ventana conmutable de 16 KB + fija (Ãºltimo banco).
			prg_bank_size_ = 0x4000u;
			prg_bank_count_ = prg_size_ / prg_bank_size_;
			prg_banked_ = true;
			break;
		case 24: case 26: // VRC6: ventana de 16 KB ($8000) + 8 KB ($C000); mÃ¡x = bancos de 8 KB.
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
		// 16K con banco en `$8000` (sentinela de modo en runtime â†’ fallback si el
		// juego cambia de modo). Verificado byte-exact en Metroid/Mega Man 2 a 60
		// frames (docs/TIMING_CODEGEN.md).
		const bool codegen_ok = (mapper_ == 0 || mapper_ == 1 || mapper_ == 2 ||
					 mapper_ == 3 || mapper_ == 4 || mapper_ == 5 ||
					 mapper_ == 24 || mapper_ == 26 || mapper_ == 69);
		return prg_size_ != 0u && codegen_ok;
	}

	/// Copia la PRG-ROM a `prg_` y extrae los tres vectores de los Ãºltimos 6 bytes.
	/// \return `false` si el fichero estÃ¡ truncado o no hay vectores.
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

	/// Traduce una direcciÃ³n 6502 a un desplazamiento dentro de `prg_`.
	///
	/// - **NROM/CNROM** (PRG fija): mapeo lineal `$8000`+ con espejo de 16 KB.
	/// - **UxROM (2)** (B1a): `$C000-$FFFF` = **Ãºltimo banco (fijo)**; la ventana
	///   conmutable `$8000-$BFFF` **no** se mapea aquÃ­ (se devuelve vacÃ­o) para que
	///   el anÃ¡lisis estÃ¡tico la omita y la ejecute el **intÃ©rprete del runtime**,
	///   que ya lee a travÃ©s del mapper (`NesSystem::io_read` â†’ `Mapper::cpu_read`).
	///
	/// \return Offset dentro de `prg_`, o vacÃ­o si la direcciÃ³n no es PRG.
	[[nodiscard]] eng::util::Optional<eng::usize> prg_offset(eng::u16 addr) const {
		if (addr < 0x8000u) {
			return {};
		}
		eng::usize off;
		// MMC3 (4): dos ventanas conmutables de 8 KB + dos fijas (modo0).
		//  - W0 `$8000-$9FFF` = R6 Â· W1 `$A000-$BFFF` = R7 (conmutables, `win_`).
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
			// anÃ¡lisis "fijo" (`win_<0`) mapea `$E000-$FFFF` al **Ãºltimo banco** (boot
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
			// `$C000-$DFFF` = 8 KB conmutable (`win_` 1), `$E000-$FFFF` = Ãºltimo 8 KB.
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
			// `fme7_prg[0..2]`, `win_` 0/1/2) + `$E000-$FFFF` fija (Ãºltimo banco).
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
			// forma de ventanas (conmutable $8000-$BFFF + Ãºltimo banco fijo $C000-$FFFF).
			if (bank_ >= 0) {
				// AnÃ¡lisis de un banco conmutable: solo se resuelve $8000-$BFFF.
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

	/// Lee el byte de la PRG-ROM en la direcciÃ³n 6502 `addr` (vacÃ­o si no es PRG).
	[[nodiscard]] eng::util::Optional<eng::u8> read_byte(eng::u16 addr) const {
		const auto off = prg_offset(addr);
		if (!off) {
			return {};
		}
		return prg_[*off];
	}

	/// Lee la palabra little-endian de la PRG-ROM en `addr` (vacÃ­o si falta algÃºn byte).
	[[nodiscard]] eng::util::Optional<eng::u16> read_word(eng::u16 addr) const {
		const auto lo = read_byte(addr);
		const auto hi = read_byte(static_cast<eng::u16>(addr + 1u));
		if (!lo || !hi) {
			return {};
		}
		return static_cast<eng::u16>(*lo | (static_cast<eng::u16>(*hi) << 8));
	}

	/// Apila una direcciÃ³n de entrada si cae en la PRG (`>= $8000`).
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
	/// Marca `addr` como lÃ­der (si tiene instrucciÃ³n y aÃºn no lo era).
	void mark_leader(eng::u16 addr) {
		if (leaders_[addr] == 0u && has_instr_[addr] != 0u) {
			leaders_[addr] = 1u;
			++block_count_;
		}
	}

	// --- Codegen ---

	/// Sufijo del mÃ©todo de `CPU` segÃºn el modo de direccionamiento
	/// (`_imm`, `_zp`, `_absx`, â€¦). \return Cadena estÃ¡tica; `""` para modos sin sufijo.
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

	/// Escribe en `out` el **nombre del mÃ©todo** de `CPU` para `info`:
	/// mnemÃ³nico + sufijo de modo; los desplazamientos implÃ­citos aÃ±aden `_A` y
	/// los `NOP` usan un nombre por modo (`NOP_imm`, `NOP_abs`â€¦).
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

	/// Escribe el **argumento** de la llamada (`0xNN` o `0xNNNN`) segÃºn la anchura
	/// del modo: 2 dÃ­gitos para inmediatos/pÃ¡gina cero/indX/indY y 4 para absolutos.
	static void append_arg(Dyn& out, const Instruction& in, const OpcodeInfo& info) {
		out.append("0x");
		const bool narrow = (info.mode == AddrMode::Imm || info.mode == AddrMode::Zp ||
				     info.mode == AddrMode::ZpX || info.mode == AddrMode::ZpY ||
				     info.mode == AddrMode::IndX || info.mode == AddrMode::IndY);
		out.append_hex(in.operand, narrow ? 2u : 4u, true);
	}

	/// Escribe el comentario `// $ADDR: MNEMONICO $OPERANDO` al final de una lÃ­nea
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

	/// CondiciÃ³n C++ del flag que prueba una rama (`BNE` â†’ `!cpu.Z`, â€¦).
	/// \return Cadena estÃ¡tica con la expresiÃ³n; `"false"` si no es una rama conocida.
	/// Flags del 6502 que **escribe** una instruccion (bit0=Z, bit1=N, bit2=C, bit3=V).
	/// 0 = transparente (STA/STX/STY/JMP/JSR/RTS/BRK/NOP/movimientos de flags del P sin aritmetica).
	[[nodiscard]] static eng::u8 decomp_flags_written(const char* m) noexcept {
		if (sv_equal(m, "LDA") || sv_equal(m, "LDX") || sv_equal(m, "LDY") ||
		    sv_equal(m, "PLA") || sv_equal(m, "PLP") || sv_equal(m, "TAX") ||
		    sv_equal(m, "TAY") || sv_equal(m, "TXA") || sv_equal(m, "TYA") ||
		    sv_equal(m, "TSX") || sv_equal(m, "AND") || sv_equal(m, "ORA") ||
		    sv_equal(m, "EOR") || sv_equal(m, "INC") || sv_equal(m, "DEC") ||
		    sv_equal(m, "INX") || sv_equal(m, "DEX") || sv_equal(m, "INY") ||
		    sv_equal(m, "DEY")) {
			return 1u | 2u; // N,Z
		}
		if (sv_equal(m, "ADC") || sv_equal(m, "SBC")) return 1u | 2u | 4u | 8u; // NZCV
		if (sv_equal(m, "CMP") || sv_equal(m, "CPX") || sv_equal(m, "CPY")) return 1u | 2u | 4u; // NZC
		if (sv_equal(m, "ASL") || sv_equal(m, "LSR") || sv_equal(m, "ROL") || sv_equal(m, "ROR")) {
			return 1u | 2u | 4u; // NZC
		}
		if (sv_equal(m, "BIT")) return 1u | 2u | 8u; // NZV
		if (sv_equal(m, "CLC") || sv_equal(m, "SEC")) return 4u;
		if (sv_equal(m, "CLV")) return 8u;
		return 0u;
	}
	/// Flags del 6502 que **lee** una instruccion (para la vivacidad).
	[[nodiscard]] static eng::u8 decomp_flags_read(const char* m) noexcept {
		if (sv_equal(m, "ADC") || sv_equal(m, "SBC") || sv_equal(m, "ROL") || sv_equal(m, "ROR")) {
			return 4u; // C
		}
		if (sv_equal(m, "BEQ") || sv_equal(m, "BNE")) return 1u; // Z
		if (sv_equal(m, "BMI") || sv_equal(m, "BPL")) return 2u; // N
		if (sv_equal(m, "BCC") || sv_equal(m, "BCS")) return 4u; // C
		if (sv_equal(m, "BVS") || sv_equal(m, "BVC")) return 8u; // V
		if (sv_equal(m, "PLP")) return 1u | 2u | 4u | 8u;
		return 0u;
	}

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

	/// Escribe una referencia a etiqueta (`prefijo` + 4 dÃ­gitos hex).
	static void append_label_ref(Dyn& out, eng::u16 addr, const char* prefix = "L_") {
		out.append(prefix);
		out.append_hex(addr, 4u, true);
	}

	/// Escribe el **nombre de funciÃ³n** de un basic block: `bb_XXXX` para la
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

	/// \return `true` si `a` es un **inicio de bloque** decodificado (destino vÃ¡lido
	/// para encadenar con una llamada directa `bb_XXXX(cpu)`).
	[[nodiscard]] bool is_block(eng::u16 a) const noexcept {
		return a < kSpace && has_instr_[a] != 0u && leaders_[a] != 0u;
	}

	/// \return `true` si el bloque que empieza en `start` **lee el estado del PPU**
	/// (`$2002`), seÃ±al de un bucle de espera de VBlank/sprite-0. Con `--chain` estos
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

	/// \return `true` si `term` es una **rama cuyo bloque destino lee `$2002`** y es un
	/// bucle hacia atrÃ¡s: el patrÃ³n de espera de VBlank/sprite-0. Sirve para que el
	/// backend nativo **ceda** al runtime en vez de girar. El bucle puede estar partido
	/// en dos bloques (el fall-through del `BPL` es lÃ­der), por eso se mira el bloque
	/// **destino** de la rama, no solo el actual.
	/// \param term InstrucciÃ³n terminadora (debe ser de rama relativa).
	[[nodiscard]] bool native_vblank_wait(const Instruction& term) const noexcept {
		if (kOpcodeTable[term.opcode].mode != AddrMode::Rel) {
			return false;
		}
		const eng::u16 t = term.target;
		return t < kSpace && t <= term.addr && block_reads_ppu_status(t);
	}

	/// \return `true` si el mnemÃ³nico **escribe memoria** (store o RMW), para distinguir
	/// bucles de **espera** (leen un flag y no lo escriben) de bucles de **cÃ¡lculo**.
	[[nodiscard]] static bool mnemonic_writes_mem(const char* m) noexcept {
		return sv_equal(m, "STA") || sv_equal(m, "STX") || sv_equal(m, "STY") ||
		       sv_equal(m, "SAX") || sv_equal(m, "INC") || sv_equal(m, "DEC") ||
		       sv_equal(m, "ASL") || sv_equal(m, "LSR") || sv_equal(m, "ROL") ||
		       sv_equal(m, "ROR") || sv_equal(m, "ISB") || sv_equal(m, "DCP") ||
		       sv_equal(m, "SLO") || sv_equal(m, "RLA") || sv_equal(m, "SRE") ||
		       sv_equal(m, "RRA");
	}

	/// \return `true` si el bloque `start` **lee memoria de datos** (algÃºn operando de
	/// modo memoria) y **no escribe** ninguna: patrÃ³n de **espera por flag**
	/// (`LDA flag; BNE ...`), que debe **ceder** al runtime aunque no lea `$2002`
	/// (el flag lo cambia el NMI). Un bucle de cÃ¡lculo (`DEC zp; BNE`) escribe memoria
	/// â†’ no es espera. `JSR` puede escribir â†’ no se considera espera.
	[[nodiscard]] bool block_waits_on_flag(eng::u16 start) const noexcept {
		eng::u16 pc = start;
		bool reads = false;
		for (;;) {
			if (has_instr_[pc] == 0u || (pc != start && leaders_[pc] != 0u)) {
				break;
			}
			const Instruction& in = instr_[pc];
			const OpcodeInfo& info = kOpcodeTable[in.opcode];
			const AddrMode md = info.mode;
			if (sv_equal(info.mnemonic, "JSR")) {
				return false;
			}
			const bool mem = md != AddrMode::Imm && md != AddrMode::Imp &&
					 md != AddrMode::Rel;
			if (mem) {
				if (mnemonic_writes_mem(info.mnemonic)) {
					return false;
				}
				reads = true;
			}
			pc = static_cast<eng::u16>(pc + info.size);
			if (md == AddrMode::Rel || sv_equal(info.mnemonic, "JMP") ||
			    sv_equal(info.mnemonic, "JSR") || sv_equal(info.mnemonic, "RTS") ||
			    sv_equal(info.mnemonic, "RTI") || sv_equal(info.mnemonic, "BRK")) {
				break;
			}
		}
		return reads;
	}

	/// \return `true` si `term` es la rama de un **bucle de espera** (lee `$2002` o un
	/// flag en memoria) que hay que **ceder** al runtime para no encadenarse sin fin.
	/// Cubre el bucle en un solo bloque y el partido en dos (la cabecera es `term.target`).
	[[nodiscard]] bool chain_wait(const Instruction& term, eng::u16 block_start) const noexcept {
		if (kOpcodeTable[term.opcode].mode != AddrMode::Rel || term.target > term.addr) {
			return false; // no es rama de bucle
		}
		const eng::u16 hdr = (term.target == block_start) ? block_start : term.target;
		return block_reads_ppu_status(hdr) || block_waits_on_flag(hdr);
	}

	/// \return `true` si el mnemÃ³nico escribe `Z`/`N` (carga/ALU/comparaciÃ³n/inc-dec/
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
	/// `start`) hasta la primera instrucciÃ³n que **lee** `Z`/`N` (rama/`PHP` â†’ viven) o que
	/// las **escribe** (â†’ la escritura de `pc` es muerta). Atravesar el fin de bloque o un
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

	/// Escribe la cabecera documentada del fichero generado: quÃ© es, quiÃ©n lo
	/// compila/ejecuta, en quÃ© contexto y quÃ© recursos necesita. Termina con el
	/// `#include` de `eng/core` que el resto del fichero presupone.
	/// \param out BÃºfer de salida (se aÃ±ade al final).
	void emit_header(Dyn& out) const {
		out.append("// ============================================================\n");
		out.append("// CÃ³digo C++23 generado por nes_transpiler (fase 1; eng/core, sin STL)\n");
		out.append("// ============================================================\n");
		out.append("//\n");
		out.append("// QUÃ‰ ES\n");
		out.append("//   TraducciÃ³n de la PRG-ROM de una ROM NES (mapper ");
		out.append_s32(mapper_);
		out.append(", ");
		out.append_u32(prg_size_);
		out.append(" bytes de PRG) a basic blocks C++23.\n");
		out.append("//   Cada funciÃ³n bb_XXXX cubre un rango de direcciones 6502 y ejecuta las\n");
		out.append("//   mismas operaciones llamando a los mÃ©todos de CPU.\n");
		out.append("//\n");
		out.append("// QUIÃ‰N LO USA / CONTEXTO\n");
		out.append("//   - Lo compila el runtime del nodo (conversion/nes-to-amiga500/runtime/)\n");
		out.append("//     para Amiga 500, o el host para tests.\n");
		out.append("//   - Punto de entrada: game_main(), bucle de despacho por cpu.PC.\n");
		out.append("//   - Los bloques usan CPU (cpu.LDA_abs(...)), Ãºnico punto de enganche con\n");
		out.append("//     RAM/PPU/APU/mapper (interceptable por la capa HLE).\n");
		out.append("//\n");
		out.append("// RECURSOS\n");
		out.append("//   - Sin memoria dinÃ¡mica; PRG_ROM es constexpr.\n");
		out.append("//   - Despacho disperso: tablas ordenadas (bloque/ciclos) + bÃºsqueda binaria.\n");
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
		// Traza opcional por instrucciÃ³n (`--trace`): el que incluya este fichero
		// puede definir `N2A_TRACE(addr)` antes; si no, es un no-op.
		out.append("#ifndef N2A_TRACE\n#define N2A_TRACE(addr) ((void)0)\n#endif\n\n");
	}

	/// Escribe `kPrgSize` y la tabla `PRG_ROM` con los bytes de la PRG, 16 por lÃ­nea.
	/// El runtime (`NESMemory::read`) las consulta; por eso van antes de su `#include`.
	void emit_rom(Dyn& out) const {
		out.append("static constexpr eng::usize kPrgSize = ");
		out.append_u32(prg_size_);
		out.append(";\n");
		// Â¿El codegen reloja la PPU **por acceso** (`cpu.mem->tick`)? Con ciclos sÃ­; con
		// `--no-cycles` **no** (solo suma los ciclos base por bloque). El runtime debe
		// fijar `fast_ticks = kBlocksTickPpu`; si no, con `--no-cycles` la PPU no avanza.
		out.append("static constexpr bool kBlocksTickPpu = ");
		out.append(no_cycles_ ? "false" : "true");
		out.append(";\n");
		out.append("static constexpr eng::u8 PRG_ROM[kPrgSize] = {\n");
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
		// (lo usa el plugin `.n2x`: PRG para el cÃ³digo, CHR/mapper para la PPU).
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
		// conmutable ($8000-$BFFF) la ejecuta el intÃ©rprete leyendo por el mapper.
		out.append(";\nstatic constexpr eng::u32 kPrgBankCount = ");
		out.append_u32(prg_bank_count_);
		out.append(";\nstatic constexpr eng::u32 kPrgBankSize = ");
		out.append_u32(prg_bank_size_);
		out.append(";\nstatic constexpr bool kPrgBanked = ");
		out.append(prg_banked_ ? "true" : "false");
		// MMC1 (1): el modo de ventanas es runtime; el runtime invalida el modelo
		// con `prg_bank = 0xFF` si el juego cambia a un modo no soportado (el
		// plugin entonces cae al intÃ©rprete).
		out.append(";\nstatic constexpr bool kPrgModeSensitive = ");
		out.append((mapper_ == 1 || mapper_ == 4 || mapper_ == 5) ? "true" : "false");
		// LÃ­mite superior de la ventana conmutable: MMC5 (modo 3) llega a `$FFFF`.
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

	/// Con `--fast-ram`, emite la instrucciÃ³n de **zero-page** con acceso directo a
	/// `cpu.mem->ram[...]` (sin la llamada al mÃ©todo ni el `switch` de regiÃ³n de
	/// `mem->read`), que en 68000 es notablemente mÃ¡s rÃ¡pido. Solo cubre los
	/// opcodes de carga/almacÃ©n/ALU/CMP en modo `Zp` (direcciÃ³n `$00-$FF`).
	/// \param out Salida.
	/// \param in InstrucciÃ³n (modo `Zp`).
	/// \return `true` si se emitiÃ³ en lÃ­nea; `false` para usar el mÃ©todo normal.
	[[nodiscard]] bool emit_zp_inline(Dyn& out, const Instruction& in) const {
		const char* m = kOpcodeTable[in.opcode].mnemonic;
		// CÃ³digo de operaciÃ³n (0 = no soportado).
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
		// RMW/desplazamientos en zero-page: lectura + operaciÃ³n + escritura directas,
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
	/// de regiÃ³n y `idx % prg_size`) por `PRG_ROM[Ã­ndice]` â€” datos `constexpr` que el
	/// compilador puede plegar o indexar directamente.
	///
	/// El Ã­ndice replica el mapeo del bus: `((operando - $8000) + X/Y) & (prg_size-1)`
	/// (potencia de dos). Solo es vÃ¡lido para `prg_size` potencia de dos; en otro caso
	/// cae al mÃ©todo normal.
	///
	/// \param out Salida.
	/// \param in InstrucciÃ³n (modo `Abs`/`AbsX`/`AbsY` con operando en `$8000-$FFFF`).
	/// \return `true` si se emitiÃ³ en lÃ­nea; `false` para usar el mÃ©todo normal.
	[[nodiscard]] bool emit_rom_inline(Dyn& out, const Instruction& in) const {
		if (!rom_direct_ || prg_banked_ || prg_size_ == 0u) {
			return false;
		}
		if ((prg_size_ & (prg_size_ - 1u)) != 0u) {
			return false; // no es potencia de dos: el mÃ³dulo no es mÃ¡scara
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
		// **DirecciÃ³n absoluta** (sin Ã­ndice): el byte es una **constante de compilaciÃ³n**
		// (PRG fija, no bancada). Se emite como **inmediato** para que g++ lo pliegue: la
		// carga puede desaparecer y las operaciones con ella resolverse en compile-time.
		if (info.mode == AddrMode::Abs) {
			const eng::u8 val = prg_[base];
			// Sin Z/N vivas: emisiÃ³n directa (la carga/operaciÃ³n no actualiza flags).
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
		// ExpresiÃ³n del Ã­ndice dentro de PRG_ROM.
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
	/// puntero `n2a_ram`. Mantiene la semÃ¡ntica de flags del 6502.
	/// \return `true` si se emitiÃ³ (y actualizÃ³ `next`).
	[[nodiscard]] bool try_chain_multibyte_impl(Dyn& out, eng::u16 p, eng::u16& next) const {
		const auto at = [&](eng::u16 a) -> const Instruction* {
			return (a < kSpace && has_instr_[a] != 0u) ? &instr_[a] : nullptr;
		};
		const auto mn = [&](const Instruction* in) -> const char* {
			return (in != nullptr) ? kOpcodeTable[in->opcode].mnemonic : "";
		};
		// `true` + offset si `in` es RAM de direcciÃ³n constante (zp, o abs < $2000).
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
		// --- Copia 16 bits: LDA/STA Ã—2 sobre RAM (zp o abs) ---
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
		// --- ComparaciÃ³n 16 bits ---
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

	/// \brief Efecto normalizado de una instrucciÃ³n 6502 (**IR mÃ­nimo** del matcher flexible).
	///
	/// POR QUÃ‰: los reconocedores de idioms comparan **opcodes exactos en offsets fijos**,
	/// asÃ­ que no ven **variaciones** (una instrucciÃ³n neutra en medio, la misma operaciÃ³n
	/// escrita de otra forma). El IR abstrae el **efecto** (def/uso) y permite casar por
	/// **predicados**, saltando lo neutro. Es la base para un reconocedor estructural.
	enum class IrKind : eng::u8 {
		Other,  ///< Cualquier otra cosa (corta el casado).
		Nop,    ///< `NOP`.
		ClrC,   ///< `CLC` (fija `C=0`).
		SetC,   ///< `SEC` (fija `C=1`).
		LoadA,  ///< `LDA x`.
		StoreA, ///< `STA x`.
		LoadX,  ///< `LDX x`.
		StoreX, ///< `STX x`.
		LoadY,  ///< `LDY x`.
		StoreY, ///< `STY x`.
		AddA,   ///< `ADC x`.
		SubA,   ///< `SBC x`.
		CmpA,   ///< `CMP x`.
	};

	/// \return Ãndice de registro (0=A, 1=X, 2=Y) si `k` es carga/almacÃ©n de registro; -1 si no.
	[[nodiscard]] static int ir_reg(IrKind k) noexcept {
		switch (k) {
		case IrKind::LoadA:
		case IrKind::StoreA:
			return 0;
		case IrKind::LoadX:
		case IrKind::StoreX:
			return 1;
		case IrKind::LoadY:
		case IrKind::StoreY:
			return 2;
		default:
			return -1;
		}
	}
	/// \return `true` si `k` es una **carga** de registro (`LDA`/`LDX`/`LDY`).
	[[nodiscard]] static bool ir_is_load(IrKind k) noexcept {
		return k == IrKind::LoadA || k == IrKind::LoadX || k == IrKind::LoadY;
	}
	/// \return `true` si `k` es un **almacÃ©n** de registro (`STA`/`STX`/`STY`).
	[[nodiscard]] static bool ir_is_store(IrKind k) noexcept {
		return k == IrKind::StoreA || k == IrKind::StoreX || k == IrKind::StoreY;
	}

	/// \brief Un paso del IR: la instrucciÃ³n normalizada a un efecto + su operando.
	struct IrStep {
		IrKind kind = IrKind::Other; ///< Efecto normalizado.
		eng::u16 addr = 0;           ///< DirecciÃ³n 6502 original.
		eng::u16 mem = 0;            ///< DirecciÃ³n RAM (si `is_mem`).
		eng::u8 imm = 0;             ///< Inmediato (si `is_imm`).
		eng::u8 size = 1;            ///< Bytes de la instrucciÃ³n.
		bool is_mem = false;         ///< El operando es RAM (zp o abs < `$2000`).
		bool is_imm = false;         ///< El operando es inmediato.
	};

	/// Traduce las instrucciones del bloque desde `start` (hasta `maxn`) a pasos del IR.
	/// \param start DirecciÃ³n de inicio.
	/// \param maxn  MÃ¡ximo de instrucciones a traducir.
	/// \return La lista de pasos (hasta fin de bloque o `maxn`).
	[[nodiscard]] eng::util::Vector<IrStep, eng::util::HeapAlloc>
	build_ir(eng::u16 start, eng::usize maxn) const {
		eng::util::Vector<IrStep, eng::util::HeapAlloc> v {};
		eng::u16 pc = start;
		for (eng::usize k = 0; k < maxn; ++k) {
			if (has_instr_[pc] == 0u || (pc != start && leaders_[pc] != 0u)) {
				break;
			}
			const Instruction& in = instr_[pc];
			const OpcodeInfo& info = kOpcodeTable[in.opcode];
			const char* m = info.mnemonic;
			IrStep s;
			s.addr = pc;
			s.size = info.size;
			const auto set_mem = [&]() -> bool {
				if (info.mode == AddrMode::Zp) {
					s.mem = static_cast<eng::u8>(in.operand);
					return true;
				}
				if (info.mode == AddrMode::Abs && in.operand < 0x2000u) {
					s.mem = static_cast<eng::u16>(in.operand & 0x7FFu);
					return true;
				}
				return false;
			};
			if (sv_equal(m, "NOP")) {
				s.kind = IrKind::Nop;
			} else if (sv_equal(m, "CLC")) {
				s.kind = IrKind::ClrC;
			} else if (sv_equal(m, "SEC")) {
				s.kind = IrKind::SetC;
			} else if (sv_equal(m, "LDA") || sv_equal(m, "LDX") || sv_equal(m, "LDY") ||
				   sv_equal(m, "ADC") || sv_equal(m, "SBC") || sv_equal(m, "CMP")) {
				s.kind = sv_equal(m, "LDA") ? IrKind::LoadA
					 : sv_equal(m, "LDX") ? IrKind::LoadX
					 : sv_equal(m, "LDY") ? IrKind::LoadY
					 : sv_equal(m, "ADC") ? IrKind::AddA
					 : sv_equal(m, "SBC") ? IrKind::SubA : IrKind::CmpA;
				if (info.mode == AddrMode::Imm) {
					s.is_imm = true;
					s.imm = static_cast<eng::u8>(in.operand);
				} else if (set_mem()) {
					s.is_mem = true;
				} else {
					s.kind = IrKind::Other;
				}
			} else if (sv_equal(m, "STA") || sv_equal(m, "STX") || sv_equal(m, "STY")) {
				s.kind = sv_equal(m, "STA") ? IrKind::StoreA
					 : sv_equal(m, "STX") ? IrKind::StoreX : IrKind::StoreY;
				if (set_mem()) {
					s.is_mem = true;
				} else {
					s.kind = IrKind::Other;
				}
			} else {
				s.kind = IrKind::Other;
			}
			(void)v.push_back(s);
			pc = static_cast<eng::u16>(pc + info.size);
			if (info.mode == AddrMode::Rel || sv_equal(m, "JMP") || sv_equal(m, "JSR") ||
			    sv_equal(m, "RTS") || sv_equal(m, "RTI") || sv_equal(m, "BRK")) {
				break;
			}
		}
		return v;
	}

	/// Casado **flexible por IR** de los idioms de 16 bits (copia y constante), tolerando
	/// **`NOP` intercalados** (la Ãºnica instrucciÃ³n realmente neutra: no toca registros ni
	/// flags). Variante mÃ¡s general que el casado exacto (que exige offsets fijos): el mismo
	/// idiom con un `NOP` en medio. \return `true` y `next` tras el idiom (los `NOP`
	/// intercalados quedan consumidos).
	[[nodiscard]] bool try_ir_multibyte(Dyn& out, eng::u16 p, eng::u16& next) const {
		const auto ir = build_ir(p, 24u);
		eng::u16 idx[12];
		int n = 0;
		for (eng::usize i = 0; i < ir.size() && n < 12; ++i) {
			// Solo `NOP` es realmente neutro (no cambia registros ni flags). `CLC`/`SEC`
			// cambian `C` (observable) â†’ **no** se saltan: si aparecen, el patrÃ³n no casa
			// y se cae al matcher exacto / byte a byte (correcto, sin perder el flag).
			if (ir[i].kind == IrKind::Nop) {
				continue;
			}
			idx[n++] = static_cast<eng::u16>(i);
		}
		const auto st = [&](int i) -> const IrStep& { return ir[idx[i]]; };
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
		const auto finish = [&](int i) {
			next = static_cast<eng::u16>(ir[idx[i]].addr + ir[idx[i]].size);
		};
		// Copia 16 bits con **registro consistente** (A/X/Y): `LoadR(a); StoreR(c);
		// LoadR(a+1); StoreR(c+1)`. Cubre `LDX/STX` y `LDY/STY`, no solo `LDA/STA`.
		if (n >= 4) {
			const IrStep& s0 = st(0);
			const IrStep& s1 = st(1);
			const IrStep& s2 = st(2);
			const IrStep& s3 = st(3);
			const int r = ir_reg(s0.kind);
			if (r >= 0 && ir_is_load(s0.kind) && s0.is_mem && ir_is_store(s1.kind) &&
			    ir_reg(s1.kind) == r && s1.is_mem && ir_is_load(s2.kind) &&
			    ir_reg(s2.kind) == r && s2.is_mem && ir_is_store(s3.kind) &&
			    ir_reg(s3.kind) == r && s3.is_mem &&
			    s2.mem == static_cast<eng::u16>(s0.mem + 1u) &&
			    s3.mem == static_cast<eng::u16>(s1.mem + 1u)) {
				const char* reg = (r == 0) ? "cpu.A" : (r == 1) ? "cpu.X" : "cpu.Y";
				out.append("    { eng::u16 n2a_w; __builtin_memcpy(&n2a_w, &");
				ram(s0.mem);
				out.append(", 2u); __builtin_memcpy(&");
				ram(s1.mem);
				out.append(", &n2a_w, 2u); ");
				out.append(reg);
				out.append(" = ");
				ram(s2.mem);
				out.append("; cpu.set_nz(");
				out.append(reg);
				out.append("); }\n");
				finish(3);
				return true;
			}
			// Constante 16 bits con registro consistente: `LoadR(#k0); StoreR(c);
			// LoadR(#k1); StoreR(c+1)`.
			if (r >= 0 && ir_is_load(s0.kind) && s0.is_imm && ir_is_store(s1.kind) &&
			    ir_reg(s1.kind) == r && s1.is_mem && ir_is_load(s2.kind) &&
			    ir_reg(s2.kind) == r && s2.is_imm && ir_is_store(s3.kind) &&
			    ir_reg(s3.kind) == r && s3.is_mem &&
			    s3.mem == static_cast<eng::u16>(s1.mem + 1u)) {
				const char* reg = (r == 0) ? "cpu.A" : (r == 1) ? "cpu.X" : "cpu.Y";
				ram(s1.mem);
				out.append(" = ");
				hx(s0.imm);
				out.append("; ");
				ram(s3.mem);
				out.append(" = ");
				hx(s2.imm);
				out.append("; ");
				out.append(reg);
				out.append(" = ");
				hx(s2.imm);
				out.append("; cpu.set_nz(");
				out.append(reg);
				out.append(");\n");
				finish(3);
				return true;
			}
		}
		// Suma/resta 16 bits: `[CLC|SEC]; LDA a; ADC|SBC b0; STA c; LDA a+1; ADC|SBC b1;
		// STA c+1`. El flag (`CLC`/`SEC`) es **obligatorio** (fija el carry inicial).
		if (n >= 7 && (st(0).kind == IrKind::ClrC || st(0).kind == IrKind::SetC)) {
			const bool add = (st(0).kind == IrKind::ClrC);
			const IrKind aop = add ? IrKind::AddA : IrKind::SubA;
			const auto is_ldA_mem = [&](int i) {
				return ir_is_load(st(i).kind) && ir_reg(st(i).kind) == 0 && st(i).is_mem;
			};
			if (is_ldA_mem(1) && st(2).kind == aop && st(3).kind == IrKind::StoreA &&
			    st(3).is_mem && is_ldA_mem(4) && st(5).kind == aop &&
			    st(6).kind == IrKind::StoreA && st(6).is_mem &&
			    st(4).mem == static_cast<eng::u16>(st(1).mem + 1u) &&
			    st(6).mem == static_cast<eng::u16>(st(3).mem + 1u)) {
				const IrStep& o0 = st(2);
				const IrStep& o1 = st(5);
				const bool imm = o0.is_imm && o1.is_imm;
				const bool rmem =
					o0.is_mem && o1.is_mem && o1.mem == static_cast<eng::u16>(o0.mem + 1u);
				if (imm || rmem) {
					out.append("    { const eng::u16 n2a_x = ");
					ld16(st(1).mem);
					out.append("; const eng::u16 n2a_y = ");
					if (imm) {
						hxo(static_cast<eng::u16>(o0.imm) |
						    (static_cast<eng::u16>(o1.imm) << 8u));
					} else {
						ld16(o0.mem);
					}
					out.append("; const eng::u8 n2a_ah = static_cast<eng::u8>(n2a_x >> 8u), n2a_bh = static_cast<eng::u8>(n2a_y >> 8u);");
					if (add) {
						out.append(" const eng::u32 n2a_s = static_cast<eng::u32>(n2a_x) + n2a_y; const eng::u16 n2a_r = static_cast<eng::u16>(n2a_s); n2a_st16(&");
						ram(st(3).mem);
						out.append(", n2a_r); cpu.C = (n2a_s > 0xFFFFu); const eng::u8 n2a_h = static_cast<eng::u8>(n2a_r >> 8u); cpu.V = (((n2a_ah ^ n2a_h) & (n2a_bh ^ n2a_h) & 0x80u) != 0u); cpu.A = n2a_h; cpu.Z = (n2a_h == 0u); cpu.N = ((n2a_h & 0x80u) != 0u); }\n");
					} else {
						out.append(" const eng::u32 n2a_s = static_cast<eng::u32>(n2a_x) - n2a_y; const eng::u16 n2a_r = static_cast<eng::u16>(n2a_s); n2a_st16(&");
						ram(st(3).mem);
						out.append(", n2a_r); cpu.C = (n2a_x >= n2a_y); const eng::u8 n2a_h = static_cast<eng::u8>(n2a_r >> 8u), n2a_nbh = static_cast<eng::u8>(~n2a_bh); cpu.V = (((n2a_ah ^ n2a_h) & (n2a_nbh ^ n2a_h) & 0x80u) != 0u); cpu.A = n2a_h; cpu.Z = (n2a_h == 0u); cpu.N = ((n2a_h & 0x80u) != 0u); }\n");
					}
					finish(6);
					return true;
				}
			}
		}
		return false;
	}

	/// Reconocedor de idioms multibyte del backend encadenado: primero el **IR flexible**
	/// (`try_ir_multibyte`, tolera neutros) y, si no, el **exacto** (`try_chain_multibyte_impl`).
	/// Cuenta los aciertos en `idiom_hits_` (diagnÃ³stico).
	/// \return `true` si casÃ³ algÃºn idiom (y `next` queda tras Ã©l).
	[[nodiscard]] bool try_chain_multibyte(Dyn& out, eng::u16 p, eng::u16& next) const {
#if !defined(N2A_NO_IR)
		if (try_ir_multibyte(out, p, next)) {
			++idiom_hits_;
			++ir_hits_;
			return true;
		}
#endif
		if (try_chain_multibyte_impl(out, p, next)) {
			++idiom_hits_;
			++exact_hits_;
			return true;
		}
		return false;
	}

	/// Traduce una instrucciÃ³n a una o varias lÃ­neas de C++.
	///
	/// Casos especiales:
	/// - Ramas y `JMP` absoluto con destino **en el mismo bloque** â†’ `goto L_xxxx`.
	/// - Los mismos con destino en **otro bloque** â†’ `cpu.PC = destino; return;`
	///   (vuelve al despachador, porque la etiqueta no cruza funciones).
	/// - `JMP (ind)` â†’ `cpu.JMP_ind(...)`: el destino se conoce en ejecuciÃ³n.
	/// - `JSR` â†’ `cpu.JSR_abs(destino, retorno)`: apila la direcciÃ³n de regreso.
	/// - `RTS`/`RTI`/`BRK` â†’ mÃ©todo de `CPU` seguido de `return`.
	/// - Resto â†’ `cpu.METODO(arg);` con un comentario con la instrucciÃ³n original.
	///
	/// \param in          InstrucciÃ³n a emitir.
	/// \param block_start DirecciÃ³n de inicio del bloque (para decidir `goto`).
	void emit_one_instruction(Dyn& out, const Instruction& in, eng::u16 block_start) const {
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		const char* m = info.mnemonic;

		if (trace_) {
			out.append("    N2A_TRACE(0x");
			out.append_hex(in.addr, 4u, true);
			out.append(");\n");
		}

		// Las ramas y `JMP` **siempre** vuelven al despacho (`cpu.PC = destino;
		// return;`), sin `goto` interno: asÃ­ el runtime puede avanzar la PPU entre
		// bloques y no se cuelga en un bucle de espera de VBlank. `block_start` ya
		// no decide nada aquÃ­ (se conserva el parÃ¡metro por uniformidad).
		(void)block_start;
		// Coste exacto en `cpu.cycles`: base + penalizaciÃ³n de pÃ¡gina/rama, igual
		// que el intÃ©rprete del runtime. El runtime lee el delta por bloque.
		// Con `--no-cycles` (Amiga, sin PPU ciclo-exacta) **no se emite nada**: ahorra
		// una operaciÃ³n por instrucciÃ³n (clave en 68000).
		auto emit_base = [&]() {
			if (no_cycles_) {
				return;
			}
			// Ciclos base **y** avance de PPU por acceso: el acceso a datos (p. ej.
			// leer `$2002`) ve la PPU en el mismo ciclo que el intÃ©rprete. El host
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
				// Cruce de pÃ¡gina de la rama: `pc+2` vs destino (estÃ¡tico).
				if (((in.addr + 2u) & 0xFF00u) != (in.target & 0xFF00u)) {
					out.append(" cpu.cycles += 1u; cpu.mem->tick(1);");
				}
			}
			if (chain_ && !prg_banked_ && chain_wait(in, block_start)) {
				// Bucle de espera (`$2002` o un **flag** que cambia el NMI): cede al
				// runtime en vez de encadenarse consigo mismo sin fin (el runtime
				// avanza el PPU/NMI y re-despacha en `PC`). Reanuda en la **cabecera**
				// del bucle (`in.target`), que es donde se relee el flag.
				out.append(" cpu.yield = true; cpu.PC = 0x");
				out.append_hex(in.target, 4u, true);
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
				// `JMP a sÃ­ mismo`: espera de NMI; cede al runtime.
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
				// Encadenado: llamada C al subbloque y continuaciÃ³n directa en el
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
				// ConvenciÃ³n del intÃ©rprete: se apila `PC+2` (direcciÃ³n del Ãºltimo byte
				// del JSR) y `RTS` suma 1; asÃ­ el retorno es consistente con el fallback.
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
				// instrucciÃ³n**, asÃ­ que hay que fijar el PC real de esta `BRK`
				// antes de llamarla (si no, se apila una direcciÃ³n de retorno
				// incorrecta cuando `BRK` no es la 1Âª instrucciÃ³n del bloque).
				out.append("    cpu.PC = 0x");
				out.append_hex(in.addr, 4u, true);
				out.append(";\n");
			}
			out.append("    cpu.");
			out.append(m);
			out.append("(); return;\n");
			return;
		}
		// InstrucciÃ³n corriente: ciclos (+ penalizaciÃ³n si lectura indexada) y
		// llamada al mÃ©todo de CPU con su comentario.
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
		// Inmediatas con Z/N muertas (liveness): carga/operaciÃ³n directa sin `set_nz`.
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

	/// Emite el **yield por deadline**: si el bloque cruzÃ³ el prÃ³ximo evento del PPU
	/// (`cpu.cycles >= cpu.deadline`), guarda el **PC estÃ¡tico** de la instrucciÃ³n
	/// siguiente y vuelve al despacho (el host resuelve NMI/IRQ y la frontera de
	/// frame en esa instrucciÃ³n exacta). Desactivado con `--no-cycles`.
	void emit_yield(Dyn& out, const Instruction& in, const OpcodeInfo& info) const {
		if (no_cycles_) {
			return;
		}
		out.append("    if (cpu.cycles >= cpu.deadline) { cpu.PC = 0x");
		out.append_hex(static_cast<eng::u16>(in.addr + info.size), 4u, true);
		out.append("; return; }\n");
	}

	/// Escribe en `out` la **ficha** que precede a la funciÃ³n `bb_<start>`.
	///
	/// Recorre el bloque para obtener su longitud y su Ãºltima instrucciÃ³n y de ahÃ­
	/// deduce: el rango de direcciones cubierto, cuÃ¡ntas instrucciones contiene,
	/// cÃ³mo termina el flujo (cae, salta, llama, retorna, se detiene) y desde
	/// dÃ³nde puede entrar la ejecuciÃ³n (reset/NMI/IRQ, rama, `JMP`, `JSR` o
	/// continuaciÃ³n del bloque anterior).
	///
	/// No genera cÃ³digo ni modifica el estado: solo consulta las tablas que dejÃ³
	/// preparadas `compute_block_metadata()`. La invoca `emit_blocks()`, una vez
	/// por cada inicio de bloque.
	///
	/// \param start DirecciÃ³n 6502 de inicio del bloque (debe ser un lÃ­der).
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
		out.append(" â€” bloque 6502 $");
		out.append_hex(start, 4u, true);
		out.append("..$");
		out.append_hex(static_cast<eng::u16>(end - 1u), 4u, true);
		out.append(" (");
		out.append_u32(count);
		out.append(count == 1u ? " instrucciÃ³n)\n// QuÃ© hace: " : " instrucciones)\n// QuÃ© hace: ");

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
			out.append("ejecuta el tramo y retorna de interrupciÃ³n (RTI).\n");
		} else if (sv_equal(last->mnemonic, "BRK")) {
			out.append("ejecuta el tramo y detiene la ejecuciÃ³n (BRK).\n");
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
			out.append("continuaciÃ³n del bloque anterior");
			any = true;
		}
		if (!any) {
			out.append("despacho directo por cpu.PC (sin referencias estÃ¡ticas)");
		}
		out.append(".\n");
		out.append("// Recursos: ninguno propio; usa CPU y su memoria (RAM/PPU/APU/mapper).\n");
	}

	/// Escribe la secciÃ³n de *basic blocks*: primero las declaraciones anticipadas
	/// de todas las funciones `bb_XXXX` y despuÃ©s cada funciÃ³n precedida de su
	/// ficha (`emit_block_doc`). Dentro del bloque, cada instrucciÃ³n se traduce con
	/// `emit_one_instruction`; al final se emite la caÃ­da al bloque siguiente
	/// (`goto` si es el mismo bloque, o `cpu.PC`/`return` si es otro).
	/// \return `true` si el bloque que empieza en `start` lee la direcciÃ³n `addr`
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

	/// Emite, **despuÃ©s** de cargar la direcciÃ³n `addr` en el registro `reg`
	/// (`"cpu.A"`/`"cpu.X"`/`"cpu.Y"`), una suposiciÃ³n `N2A_ASSUME` con el hecho de
	/// valores (`--facts`) de esa direcciÃ³n.
	///
	/// Se emite sobre el **registro** (p. ej. `cpu.A`) porque es la expresiÃ³n que el
	/// optimizador reutiliza despuÃ©s; hacerlo sobre `cpu.mem->read(addr)` **no sirve**:
	/// `read()` no es una funciÃ³n pura y con `--fast-ram` la carga real ni siquiera usa
	/// `read()` (va por `n2a_ram[]`), asÃ­ que la suposiciÃ³n quedarÃ­a desconectada.
	/// Si un hecho no se cumple en ejecuciÃ³n el resultado es indefinido, asÃ­ que los
	/// hechos deben venir validados por anÃ¡lisis/telemetrÃ­a (`facts_from_run`).
	///
	/// \param out Flujo de salida del `.cpp` generado.
	/// \param addr DirecciÃ³n 6502 leÃ­da (se busca un hecho con esa direcciÃ³n).
	/// \param reg  ExpresiÃ³n a la que se aplica el hecho: el registro reciÃ©n cargado
	///             (`"cpu.A"`, `"cpu.X"`, `"cpu.Y"`) o la expresiÃ³n de memoria que el
	///             cÃ³digo usa (`"n2a_ram[0x0020]"` con `--fast-ram`, o
	///             `"cpu.mem->read(0x0020)"`).
	void emit_fact_assume(Dyn& out, eng::u16 addr, eng::util::StringView reg) const {
		for (eng::usize i = 0; i < facts_.size(); ++i) {
			const Fact& f = facts_[i];
			if (f.kind == FactKind::Hot || f.addr != addr) {
				continue;
			}
			out.append("    N2A_ASSUME(");
			out.append(reg);
			switch (f.kind) {
			case FactKind::Eq:
				out.append(" == 0x");
				out.append_hex(f.values[0], 2u, true);
				break;
			case FactKind::Range:
				out.append(" >= 0x");
				out.append_hex(f.values[0], 2u, true);
				out.append(" && ");
				out.append(reg);
				out.append(" <= 0x");
				out.append_hex(f.values[1], 2u, true);
				break;
			case FactKind::Set:
				out.append(" == 0x");
				out.append_hex(f.values[0], 2u, true);
				for (eng::u8 k = 1u; k < f.count; ++k) {
					out.append(" || ");
					out.append(reg);
					out.append(" == 0x");
					out.append_hex(f.values[k], 2u, true);
				}
				break;
			case FactKind::Power2:
				out.append(" != 0u && (");
				out.append(reg);
				out.append(" & (");
				out.append(reg);
				out.append(" - 1u)) == 0u");
				break;
			case FactKind::Hot:
				break; // ya filtrado arriba; evita el aviso de switch
			}
			out.append(");\n");
			return; // un hecho por direcciÃ³n es suficiente
		}
	}

	/// NÂº de ejecuciones observado para el bloque que empieza en `addr` segÃºn un
	/// hecho `Hot` (`--facts`). Permite marcar el bloque `hot`/`cold`.
	/// \param addr DirecciÃ³n de inicio del bloque.
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
	/// \param start DirecciÃ³n de inicio del bloque.
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
		cur_bank_ = bank; // banco del bloque en emisiÃ³n (encadenado de destinos)
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

		// Orden de definiciÃ³n: bloques **calientes primero** (mejor localidad de
		// I-fetch, crÃ­tico en A500 sin cachÃ©). Los frÃ­os (`heat==0`) van al final
		// (ademÃ¡s de llevar `__attribute__((cold))`); sin dato de calor se mantiene
		// el orden por direcciÃ³n. `order`/`heat` van en paralelo.
		eng::util::Vector<eng::u16, eng::util::HeapAlloc> order {};
		eng::util::Vector<int, eng::util::HeapAlloc> heat {};
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (leaders_[a] == 0u) {
				continue;
			}
			(void)order.push_back(static_cast<eng::u16>(a));
			(void)heat.push_back(hot_count(static_cast<eng::u16>(a)));
		}
		// rank: 0 caliente (>0), 1 sin dato (-1), 2 frÃ­o (0). Orden estable con
		// inserciÃ³n: dentro de un rango, mÃ¡s calor primero y, si no, por direcciÃ³n.
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
			// Calor del bloque (telemetrÃ­a `--facts`): `hot`/`cold` guÃ­an al
			// compilador (reordenado y `-Os` en los frÃ­os). Sin dato, sin marca.
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
				// Encadenado: el PC no se mantiene por instrucciÃ³n, pero se fija al
				// entrar en cada bloque para que el fallback a intÃ©rprete, el NMI y
				// el diagnÃ³stico vean la direcciÃ³n real.
				out.append("    cpu.PC = 0x");
				out.append_hex(start, 4u, true);
				out.append(";\n");
			}
			// Punteros cacheados por bloque: `n2a_ram` (RAM emulada, direcciÃ³n fija
			// dentro de `NESMemory`) y `n2a_prg` (`PRG_ROM`, `constexpr`) se quedan en
			// registros de direcciÃ³n durante todo el bloque, en vez de recargar
			// `cpu.mem`/recomputar la base en cada acceso directo.
			if (fast_ram_) {
				out.append("    [[maybe_unused]] eng::u8* const n2a_ram = cpu.mem->ram;\n");
			}
			if (rom_direct_ && !prg_banked_) {
				out.append("    [[maybe_unused]] const eng::u8* const n2a_prg = PRG_ROM;\n");
			}
			// Ciclos del bloque para el runtime cuando el codegen **no cuenta ciclos**
			// (`--no-cycles`): se suman **una vez por bloque** al contador separado
			// `cpu.block_cycles` (constante estÃ¡tica), **no** por instrucciÃ³n. AsÃ­ el
			// codegen **encadenado** reporta los ciclos acumulados de toda la cadena y la
			// PPU avanza con timing correcto sin coste por instrucciÃ³n. Se usa un contador
			// distinto de `cpu.cycles` para **no** interactuar con el `deadline`.
			if (no_cycles_) {
				out.append("    cpu.block_cycles += ");
				out.append_u32(block_base_cycles(start));
				out.append("u;\n");
			}

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
				// ciclos (`--no-cycles`), donde el estado por instrucciÃ³n no se observa.
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

				// Liveness de Z/N: si la instrucciÃ³n las escribe y se reescriben antes
				// de leerse, se suprimen las escrituras (menos accesos al estado).
				// Solo con el perfil Amiga encadenado (`--chain`); sin Ã©l se mantiene
				// el comportamiento exacto anterior (host/tests).
				cur_nz_live_ = !(chain_ && nz_dead_after(start, pc));
				// Idioms multibyte (copia/const/compare/ADD/SUB 16 bits).
				if (chain_ && fast_ram_ && no_cycles_ && idioms_) {
					eng::u16 nmp = pc;
					if (try_chain_multibyte(out, pc, nmp)) {
						pc = nmp;
						a_known = false;
						vsa_n = 0;
						continue;
					}
				}
				emit_one_instruction(out, in, start);

				// Suposiciones de valor **tras** la instrucciÃ³n que lee la direcciÃ³n,
				// aplicadas a la expresiÃ³n que el cÃ³digo usa despuÃ©s:
				//   - cargas (`LDA/LDX/LDY zp/abs`)  -> el registro (`cpu.A/X/Y`);
				//   - el resto (RMW `INC/DEC/ASL...`, `CMP`, `BIT`...) -> la **memoria**
				//     (`n2a_ram[..]` con `--fast-ram`, si no `cpu.mem->read(..)`).
				// Emitirlas antes sobre `cpu.mem->read(addr)` no servÃ­a: `read()` no es
				// pura y con `--fast-ram` la carga real va por `n2a_ram[]`, asÃ­ que la
				// suposiciÃ³n quedaba desconectada del valor. Solo modos `Zp`/`Abs`
				// (en los indexados el efectivo es `operand + X/Y`, no `operand`).
				const bool n2a_store_op =
					in.opcode == 0x85u || in.opcode == 0x8Du || in.opcode == 0x86u ||
					in.opcode == 0x8Eu || in.opcode == 0x84u || in.opcode == 0x8Cu ||
					in.opcode == 0x87u || in.opcode == 0x8Fu;
				if (has_operand(in) && !n2a_store_op &&
				    (info.mode == AddrMode::Zp || info.mode == AddrMode::Abs)) {
					const char* reg = nullptr;
					if (in.opcode == 0xA5u || in.opcode == 0xADu) {
						reg = "cpu.A";
					} else if (in.opcode == 0xA6u || in.opcode == 0xAEu) {
						reg = "cpu.X";
					} else if (in.opcode == 0xA4u || in.opcode == 0xACu) {
						reg = "cpu.Y";
					}
					if (reg != nullptr) {
						emit_fact_assume(out, in.operand, eng::util::StringView(reg));
						if (in.opcode == 0xA5u || in.opcode == 0xADu) {
							// VSA intra-bloque (`LDA #c; STA a; LDA a`).
							for (int k = 0; k < vsa_n; ++k) {
								if (vsa_addr[k] == in.operand) {
									out.append("    N2A_ASSUME(cpu.A == 0x");
									out.append_hex(vsa_val[k], 2u, true);
									out.append(");\n");
									break;
								}
							}
						}
					} else if (in.operand < 0x2000u) {
						// RAM interna: se usa la expresiÃ³n **pura** que el codegen
						// escribe/lee de verdad â€” el alias local `n2a_ram[...]` con
						// `--fast-ram`, o `cpu.mem->ram[...]` si no. **No** se usa
						// `cpu.mem->read(...)`: no es una funciÃ³n pura, asÃ­ que g++ no
						// propaga su valor a los accesos siguientes.
						Dyn expr;
						expr.append(fast_ram_ ? "n2a_ram[0x" : "cpu.mem->ram[0x");
						expr.append_hex(in.operand, 4u, true);
						expr.append(']');
						emit_fact_assume(out, in.operand, expr.view());
					}
				}

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
						// Encadenado: caÃ­da directa al bloque siguiente (llamada en cola).
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
		out.append("static void (*g_native_yield)(N2A_State&, N2A_Bus&) = nullptr;\n");
		out.append("/// Hook para un `JMP (ind)` cuyo destino no estaba entre los observados\n");
		out.append("/// (`--ind-targets`). Si es `nullptr`, el codigo nativo se detiene.\n");
		out.append("static void (*g_native_ind_miss)(N2A_State&, N2A_Bus&, eng::u16) = nullptr;\n\n");

		// --- Entradas de regiÃ³n: reset/NMI/IRQ + destinos de JSR ---
		eng::util::Vector<eng::u16, eng::util::HeapAlloc> entries {};
		const auto add_entry = [&](eng::u16 a) {
			// Una entrada de regiÃ³n solo necesita estar decodificada; puede no ser un
			// lÃ­der estÃ¡tico (p. ej. destino de `JSR` alcanzado por telemetrÃ­a).
			if (a < kSpace && has_instr_[a] != 0u) {
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
		// Puntos de **reanudaciÃ³n** de las cesiones (esperas de VBlank/NMI): cada uno
		// es una entrada de regiÃ³n, para que `game_main` reanude en `r->pc` tras la
		// cesiÃ³n y **no** re-ejecute la inicializaciÃ³n.
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (has_instr_[a] == 0u) {
				continue;
			}
			const Instruction& in = instr_[a];
			const OpcodeInfo& info = kOpcodeTable[in.opcode];
			if (native_vblank_wait(in)) {
				add_entry(static_cast<eng::u16>(a + info.size));
			} else if (sv_equal(info.mnemonic, "JMP") && info.mode == AddrMode::Abs &&
				   has_operand(in) && in.target == static_cast<eng::u16>(a)) {
				add_entry(static_cast<eng::u16>(a)); // `JMP a si mismo`
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

		// --- Despachador de **reanudaciÃ³n**: tras una cesiÃ³n, `game_main` reanuda en
		// `r->pc` (punto guardado por la propia cesiÃ³n) en vez de re-ejecutar `reset`
		// (que repetirÃ­a la inicializaciÃ³n cada frame).
		out.append("static void n2a_resume(N2A_State* r, N2A_Bus* m) {\n    switch (r->pc) {\n");
		for (eng::usize i = 0; i < entries.size(); ++i) {
			out.append("    case 0x");
			out.append_hex(entries[i], 4u, true);
			out.append("u: n2a_r_");
			out.append_hex(entries[i], 4u, true);
			out.append("(r, m); return;\n");
		}
		out.append("    default: r->halted = true; return;\n    }\n}\n");

		// --- Entradas (reset/NMI/IRQ). `[[gnu::used]]` evita que g++ elimine las
		// regiones solo alcanzables desde NMI/IRQ por ser `static` no referenciadas.
		out.append("[[gnu::used]] void game_main() {\n");
		out.append("    g_st.pc = 0x");
		out.append_hex(reset_, 4u, true);
		out.append("u;\n");
		out.append("    for (;;) {\n");
		out.append("        if (g_st.halted) { break; }\n");
		out.append("        n2a_resume(&g_st, &g_bus);\n");
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

	/// Emite la **direcciÃ³n efectiva** de un operando de memoria como expresiÃ³n C (`u16`).
	/// \param out Salida. \param in InstrucciÃ³n (modo de memoria).
	void d_ea(Dyn& out, const Instruction& in) const {
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		const eng::u16 o = in.operand;
		switch (info.mode) {
		case AddrMode::Zp:
			out.append("0x");
			out.append_hex(o, 4u, true);
			out.append("u");
			break;
		case AddrMode::ZpX:
			out.append("(u16)(0x");
			out.append_hex(o, 4u, true);
			out.append("u + X)");
			break;
		case AddrMode::ZpY:
			out.append("(u16)(0x");
			out.append_hex(o, 4u, true);
			out.append("u + Y)");
			break;
		case AddrMode::Abs:
			out.append("0x");
			out.append_hex(o, 4u, true);
			out.append("u");
			break;
		case AddrMode::AbsX:
			out.append("(u16)(0x");
			out.append_hex(o, 4u, true);
			out.append("u + X)");
			break;
		case AddrMode::AbsY:
			out.append("(u16)(0x");
			out.append_hex(o, 4u, true);
			out.append("u + Y)");
			break;
		case AddrMode::IndX:
			out.append("(u16)(rd((u8)(0x");
			out.append_hex(o, 4u, true);
			out.append("u + X)) | ((u16)rd((u8)(0x");
			out.append_hex(o, 4u, true);
			out.append("u + X + 1u)) << 8))");
			break;
		case AddrMode::IndY:
			out.append("(u16)((rd(0x");
			out.append_hex(o, 4u, true);
			out.append("u) | ((u16)rd(0x");
			out.append_hex(static_cast<eng::u16>(o + 1u), 4u, true);
			out.append("u) << 8)) + Y)");
			break;
		default:
			out.append("0u");
			break;
		}
	}

	/// Emite el **valor leÃ­do** de un operando (inmediato o `rd(<direcciÃ³n efectiva>)`).
	void d_val(Dyn& out, const Instruction& in) const {
		if (kOpcodeTable[in.opcode].mode == AddrMode::Imm) {
			out.append("0x");
			out.append_hex(static_cast<eng::u16>(in.operand), 2u, true);
			out.append("u");
			return;
		}
		out.append("rd(");
		d_ea(out, in);
		out.append(")");
	}

	/// Emite el **cuerpo C** de una instrucciÃ³n **no terminadora** del decompilado.
	void emit_decompile_instruction(Dyn& out, const Instruction& in) const {
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		const char* m = info.mnemonic;
		const auto wr = [&]() {
			out.append("wr(");
			d_ea(out, in);
			out.append(", ");
		};
		const auto setnz = [&](const char* reg) {
			// DCE: si ni N ni Z estan vivos tras esta instruccion, no se fijan.
			if ((d_keep_flags_ & 3u) == 0u) { return; }
			if (flat_) {
				// Flatten: flags INLINE. Una funcion `setnz` de fichero resuelve `Zf/Nf`
				// lexicamente a los GLOBALES incluso al inlinearse -> no sincroniza con los
				// locales de `n2a_run` (bucles infinitos). Emitido aqui, usa los locales.
				out.append(" { const u8 _n2az = ");
				out.append(reg);
				out.append("; Zf = (_n2az == 0u); Nf = ((_n2az & 0x80u) != 0u); }");
			} else {
				out.append(" setnz(");
				out.append(reg);
				out.append(");");
			}
		};
		// Ciclos **exactos** (base + penalizaciÃ³n de cruce de pÃ¡gina en lecturas
		// indexadas). El cruce es dinÃ¡mico: `(base & 0xFF) + Ã­ndice > 0xFF`.
		out.append("    tick(");
		out.append_u32(op_base_cycles(in.opcode));
		out.append("u");
		if (op_read_indexed_penalty(in.opcode)) {
			const auto hx = [&](eng::u16 v) {
				out.append_hex(v, 4u, true);
			};
			if (info.mode == AddrMode::AbsX || info.mode == AddrMode::AbsY) {
				out.append(" + ((0x");
				hx(static_cast<eng::u16>(in.operand & 0xFFu));
				out.append("u + ");
				out.append(info.mode == AddrMode::AbsX ? "X" : "Y");
				out.append(") > 0xFFu ? 1u : 0u)");
			} else if (info.mode == AddrMode::IndY) {
				out.append(" + (((rd(0x");
				hx(in.operand);
				out.append("u) | (static_cast<eng::u16>(rd(0x");
				hx(static_cast<eng::u16>(in.operand + 1u));
				out.append("u)) << 8u)) & 0xFFu) + Y > 0xFFu ? 1u : 0u)");
			}
		}
		out.append(");\n    ");
		if (sv_equal(m, "LDA") || sv_equal(m, "LDX") || sv_equal(m, "LDY")) {
			const char* reg = sv_equal(m, "LDA") ? "A" : (sv_equal(m, "LDX") ? "X" : "Y");
			out.append(reg);
			out.append(" = ");
			d_val(out, in);
			out.append(";");
			setnz(reg);
		} else if (sv_equal(m, "STA") || sv_equal(m, "STX") || sv_equal(m, "STY")) {
			const char* reg = sv_equal(m, "STA") ? "A" : (sv_equal(m, "STX") ? "X" : "Y");
			wr();
			out.append(reg);
			out.append(");");
		} else if (sv_equal(m, "TAX") || sv_equal(m, "TAY") || sv_equal(m, "TXA") ||
			   sv_equal(m, "TYA") || sv_equal(m, "TSX")) {
			const char* dst = sv_equal(m, "TAX") ? "X"
					 : sv_equal(m, "TAY") ? "Y"
					 : sv_equal(m, "TXA") ? "A"
					 : sv_equal(m, "TYA") ? "A" : "X";
			const char* src = sv_equal(m, "TAX") ? "A"
					 : sv_equal(m, "TAY") ? "A"
					 : sv_equal(m, "TXA") ? "X"
					 : sv_equal(m, "TYA") ? "Y" : "SP";
			out.append(dst);
			out.append(" = ");
			out.append(src);
			out.append(";");
			setnz(dst);
		} else if (sv_equal(m, "TXS")) {
			out.append("SP = X;");
		} else if (sv_equal(m, "PHA")) {
			out.append("wr(0x100u + SP, A); --SP;");
		} else if (sv_equal(m, "PLA")) {
			out.append("++SP; A = rd(0x100u + SP);");
			setnz("A");
		} else if (sv_equal(m, "PHP")) {
			out.append("wr(0x100u + SP, (u8)(0x30u | (Nf?0x80u:0u) | (Vf?0x40u:0u) | (Df?0x08u:0u) | (If?0x04u:0u) | (Zf?0x02u:0u) | (Cf?0x01u:0u))); --SP;");
		} else if (sv_equal(m, "PLP")) {
			out.append("{ ++SP; const u8 q = rd(0x100u + SP); Nf=(q&0x80u)!=0; Vf=(q&0x40u)!=0; Df=(q&0x08u)!=0; If=(q&0x04u)!=0; Zf=(q&0x02u)!=0; Cf=(q&0x01u)!=0; }");
		} else if (sv_equal(m, "AND") || sv_equal(m, "ORA") || sv_equal(m, "EOR")) {
			out.append("A = (u8)(A ");
			out.append(sv_equal(m, "AND") ? "&" : (sv_equal(m, "ORA") ? "|" : "^"));
			out.append(" ");
			d_val(out, in);
			out.append(");");
			setnz("A");
		} else if (sv_equal(m, "ADC")) {
			out.append("{ const u8 v = ");
			d_val(out, in);
			out.append("; const u16 t = (u16)A + (u16)v + (Cf ? 1u : 0u); Cf = (t > 0xFFu); Vf = (((A ^ (u8)t) & (v ^ (u8)t) & 0x80u) != 0u); A = (u8)t;");
			setnz("A");
			out.append(" }");
		} else if (sv_equal(m, "SBC")) {
			out.append("{ const u8 v = ");
			d_val(out, in);
			out.append("; const u8 nv = (u8)(~v); const u16 t = (u16)A + (u16)nv + (Cf ? 1u : 0u); Cf = (t > 0xFFu); Vf = (((A ^ (u8)t) & (nv ^ (u8)t) & 0x80u) != 0u); A = (u8)t;");
			setnz("A");
			out.append(" }");
		} else if (sv_equal(m, "CMP") || sv_equal(m, "CPX") || sv_equal(m, "CPY")) {
			const char* reg = sv_equal(m, "CMP") ? "A" : (sv_equal(m, "CPX") ? "X" : "Y");
			out.append("{ const u8 v = ");
			d_val(out, in);
			out.append("; const u16 t = (u16)");
			out.append(reg);
			out.append(" - (u16)v; Cf = (t < 0x100u);");
			setnz("(u8)t");
			out.append(" }");
		} else if (sv_equal(m, "BIT")) {
			out.append("{ const u8 v = ");
			d_val(out, in);
			out.append("; Zf = ((A & v) == 0); Nf = ((v & 0x80u) != 0); Vf = ((v & 0x40u) != 0); }");
		} else if (in.opcode == 0xE6u || in.opcode == 0xF6u || in.opcode == 0xEEu ||
			   in.opcode == 0xFEu || in.opcode == 0xC6u || in.opcode == 0xD6u ||
			   in.opcode == 0xCEu || in.opcode == 0xDEu) {
			const bool inc = (in.opcode == 0xE6u || in.opcode == 0xF6u ||
					  in.opcode == 0xEEu || in.opcode == 0xFEu);
			out.append("{ u8 t = (u8)(rd(");
			d_ea(out, in);
			out.append(inc ? ") + 1u); wr(" : ") - 1u); wr(");
			d_ea(out, in);
			out.append(", t);");
			setnz("t");
			out.append(" }");
		} else if (sv_equal(m, "INX") || sv_equal(m, "INY") || sv_equal(m, "DEX") ||
			   sv_equal(m, "DEY")) {
			const char* reg = (sv_equal(m, "INX") || sv_equal(m, "DEX")) ? "X" : "Y";
			const bool inc = sv_equal(m, "INX") || sv_equal(m, "INY");
			out.append(reg);
			out.append(" = (u8)(");
			out.append(reg);
			out.append(inc ? " + 1u);" : " - 1u);");
			setnz(reg);
		} else if (sv_equal(m, "ASL") || sv_equal(m, "LSR") || sv_equal(m, "ROL") ||
			   sv_equal(m, "ROR")) {
			const bool acc = (in.opcode == 0x0Au || in.opcode == 0x2Au ||
					  in.opcode == 0x4Au || in.opcode == 0x6Au);
			out.append(acc ? "{ u8 t = A;" : "{ u8 t = rd(");
			if (!acc) {
				d_ea(out, in);
				out.append(");");
			}
			if (sv_equal(m, "ASL")) {
				out.append(" Cf = ((t & 0x80u) != 0); t = (u8)(t << 1);");
			} else if (sv_equal(m, "LSR")) {
				out.append(" Cf = ((t & 1u) != 0); t = (u8)(t >> 1);");
			} else if (sv_equal(m, "ROL")) {
				out.append(" { const u8 oc = Cf ? 1u : 0u; Cf = ((t & 0x80u) != 0); t = (u8)((t << 1) | oc); }");
			} else {
				out.append(" { const u8 oc = Cf ? 1u : 0u; Cf = ((t & 1u) != 0); t = (u8)((t >> 1) | (oc << 7)); }");
			}
			if (acc) {
				out.append(" A = t;");
			} else {
				out.append(" wr(");
				d_ea(out, in);
				out.append(", t);");
			}
			setnz("t");
			out.append(" }");
		} else if (sv_equal(m, "CLC")) {
			out.append("Cf = false;");
		} else if (sv_equal(m, "SEC")) {
			out.append("Cf = true;");
		} else if (sv_equal(m, "CLI")) {
			out.append("If = false;");
		} else if (sv_equal(m, "SEI")) {
			out.append("If = true;");
		} else if (sv_equal(m, "CLD")) {
			out.append("Df = false;");
		} else if (sv_equal(m, "SED")) {
			out.append("Df = true;");
		} else if (sv_equal(m, "CLV")) {
			out.append("Vf = false;");
		} else if (sv_equal(m, "NOP")) {
			out.append("/* nop */");
		} else {
			out.append("/* TODO ");
			out.append(m);
			out.append(" */");
		}
		out.append('\n');
	}

	/// Emite una **regiÃ³n** (funciÃ³n C `f_XXXX`) del decompilado: BFS de bloques desde
	/// `entry` y emisiÃ³n en C plano con etiquetas/`goto` (fase 1: correcto; la
	/// estructuraciÃ³n a bucles/`if` es una fase posterior, ver `docs/DECOMPILADOR.md`).
	/// Sucesor **incondicional** de un bloque (`fallthrough` o `JMP` directo); `0xFFFF` si el
	/// bloque tiene salida condicional o retorno (su flujo no es determinista).
	eng::u16 decomp_uncond_succ(eng::u16 b) const {
		eng::u16 p = b;
		const Instruction* term = nullptr;
		for (;;) {
			if (has_instr_[p] == 0u || (p != b && leaders_[p] != 0u)) { break; }
			const Instruction& in = instr_[p];
			const OpcodeInfo& inf = kOpcodeTable[in.opcode];
			term = &in;
			p = static_cast<eng::u16>(p + inf.size);
			if (inf.mode == AddrMode::Rel || sv_equal(inf.mnemonic, "JMP") ||
			    sv_equal(inf.mnemonic, "JSR") || sv_equal(inf.mnemonic, "RTS") ||
			    sv_equal(inf.mnemonic, "RTI") || sv_equal(inf.mnemonic, "BRK")) {
				break;
			}
		}
		if (term == nullptr) { return 0xFFFFu; }
		const char* m = kOpcodeTable[term->opcode].mnemonic;
		if (kOpcodeTable[term->opcode].mode == AddrMode::Rel) { return 0xFFFFu; }
		if (sv_equal(m, "JMP")) { return term->target; }
		if (sv_equal(m, "JSR")) { return p; }
		if (sv_equal(m, "RTS") || sv_equal(m, "RTI") || sv_equal(m, "BRK")) { return 0xFFFFu; }
		return p;
	}

	/// \return `true` si el bloque `b` esta en un **bucle incondicional infinito** (solo salible
	/// por NMI): es el busy-wait de la NES (`JSR prng; JMP spin`). Sigue los sucesores
	/// incondicionales; si vuelve a `b`, lo es.
	bool decomp_wait_loop(eng::u16 b) const {
		eng::u16 c = decomp_uncond_succ(b);
		for (int i = 0; i < 16 && c != 0xFFFFu; ++i) {
			if (c == b) { return true; }
			c = decomp_uncond_succ(c);
		}
		return false;
	}

	void emit_decompile_region(Dyn& out, eng::u16 entry) {
		(void)native_vis_.resize(kSpace, 0u);
		for (eng::u32 i = 0; i < kSpace; ++i) {
			native_vis_[i] = 0u;
		}
		eng::util::Vector<eng::u16, eng::util::HeapAlloc> stack {};
		const auto visit = [&](eng::u16 b) {
			if (b < kSpace && has_instr_[b] != 0u && leaders_[b] != 0u &&
			    native_vis_[b] == 0u) {
				native_vis_[b] = 1u;
				(void)stack.push_back(b);
			}
		};
		const auto cond = [](const char* m) -> const char* {
			if (sv_equal(m, "BEQ")) return "Zf";
			if (sv_equal(m, "BNE")) return "!Zf";
			if (sv_equal(m, "BCC")) return "!Cf";
			if (sv_equal(m, "BCS")) return "Cf";
			if (sv_equal(m, "BMI")) return "Nf";
			if (sv_equal(m, "BPL")) return "!Nf";
			if (sv_equal(m, "BVS")) return "Vf";
			if (sv_equal(m, "BVC")) return "!Vf";
			return "false";
		};
		visit(entry);
		for (eng::usize i = 0; i < stack.size(); ++i) {
			const eng::u16 b = stack[i];
			eng::u16 p = b;
			const Instruction* term = nullptr;
			for (;;) {
				if (has_instr_[p] == 0u || (p != b && leaders_[p] != 0u)) break;
				term = &instr_[p];
				const OpcodeInfo& inf = kOpcodeTable[instr_[p].opcode];
				p = static_cast<eng::u16>(p + inf.size);
				if (inf.mode == AddrMode::Rel || sv_equal(inf.mnemonic, "JMP") ||
				    sv_equal(inf.mnemonic, "JSR") || sv_equal(inf.mnemonic, "RTS") ||
				    sv_equal(inf.mnemonic, "RTI") || sv_equal(inf.mnemonic, "BRK")) {
					break;
				}
			}
			const eng::u16 next = p;
			if (term != nullptr) {
				const char* m = kOpcodeTable[term->opcode].mnemonic;
				if (kOpcodeTable[term->opcode].mode == AddrMode::Rel) {
					visit(term->target);
					visit(next);
				} else if (sv_equal(m, "JMP")) {
					visit(term->target);
				} else if (sv_equal(m, "JSR")) {
					visit(next);
				} else if (!sv_equal(m, "RTS") && !sv_equal(m, "RTI") &&
					   !sv_equal(m, "BRK")) {
					visit(next);
				}
			} else {
				visit(next);
			}
		}
		for (eng::usize i = 1; i < stack.size(); ++i) {
			const eng::u16 k = stack[i];
			eng::usize j = i;
			while (j > 0u && stack[j - 1u] > k) {
				stack[j] = stack[j - 1u];
				--j;
			}
			stack[j] = k;
		}
		if (!flat_) {
			out.append("static void f_");
			out.append_hex(entry, 4u, true);
			out.append("(void) {\n");
			// **Reanudacion**: si `g_resume` apunta a un bloque de esta region, salta a su etiqueta.
			out.append("    if (g_resume != 0u) { const u16 n2a_r = g_resume; g_resume = 0u; switch (n2a_r) { ");
			for (eng::usize si = 0; si < stack.size(); ++si) {
				out.append("case 0x");
				out.append_hex(stack[si], 4u, true);
				out.append("u: goto L_");
				out.append_hex(stack[si], 4u, true);
				out.append("; ");
			}
			out.append("} }\n");
		}
		for (eng::usize si = 0; si < stack.size(); ++si) {
			const eng::u16 b = stack[si];
			if (b < decomp_region_of_.size() && decomp_region_of_[b] == 0u) {
				decomp_region_of_[b] = entry; // mapa bloque -> region (para el despachador)
			}
			if (flat_) {
				if (b < emitted_.size() && emitted_[b] != 0u) { continue; }
				if (b < emitted_.size()) { emitted_[b] = 1u; }
			}
			out.append("L_");
			out.append_hex(b, 4u, true);
			out.append(": if (g_yield_req) { g_resume = 0x");
			out.append_hex(b, 4u, true);
			// `g_label` (diagnostico de "ultima etiqueta") se OMITE en builds de velocidad: es un
			// store a global por bloque (~3000/frame) sin valor en produccion. Se recupera con
			// `-DN2A_TRACE_LABEL` (transpilador) para depuracion.
			out.append("u; g_yield_req = 0u; return; } ");
#ifdef N2A_TRACE_LABEL
			out.append("g_label = 0x");
			out.append_hex(b, 4u, true);
			out.append("u;");
#endif
			out.append("\n");
#ifdef N2A_TRACE_BLOCK
			out.append("if (g_step_limit != 0u && ++g_steps > g_step_limit) { g_dbgA = A; g_dbgX = X; g_dbgY = Y; g_dbgZ = (u8)Zf; g_dbgC = (u8)Cf; if (hal_limit_hook) { hal_limit_hook(); } }\n");
#endif
			eng::u16 p = b;
			const Instruction* term = nullptr;
			for (;;) {
				if (has_instr_[p] == 0u || (p != b && leaders_[p] != 0u)) break;
				const Instruction& in = instr_[p];
				const OpcodeInfo& inf = kOpcodeTable[in.opcode];
				term = &in;
				p = static_cast<eng::u16>(p + inf.size);
				if (inf.mode == AddrMode::Rel || sv_equal(inf.mnemonic, "JMP") ||
				    sv_equal(inf.mnemonic, "JSR") || sv_equal(inf.mnemonic, "RTS") ||
				    sv_equal(inf.mnemonic, "RTI") || sv_equal(inf.mnemonic, "BRK")) {
					break;
				}
			}
			// `term` solo se salta si es un **terminador** de control; si el bloque acaba en
			// un lÃ­der (instrucciÃ³n normal), esa Ãºltima instrucciÃ³n **sÃ­** se emite.
			const bool term_ctrl =
				(term != nullptr) &&
				(kOpcodeTable[term->opcode].mode == AddrMode::Rel ||
				 sv_equal(kOpcodeTable[term->opcode].mnemonic, "JMP") ||
				 sv_equal(kOpcodeTable[term->opcode].mnemonic, "JSR") ||
				 sv_equal(kOpcodeTable[term->opcode].mnemonic, "RTS") ||
				 sv_equal(kOpcodeTable[term->opcode].mnemonic, "RTI") ||
				 sv_equal(kOpcodeTable[term->opcode].mnemonic, "BRK"));
			// **Fusion CMP#imm + rama**: si la instruccion inmediatamente anterior al terminador
			// es un `CMP/CPX/CPY` inmediato y el terminador es una rama que lee sus flags, se
			// infiere C directo (`if (A == n)`) y se OMITE el CMP (no se simulan flags). Es la
			// "traduccion de intenciones" del decompilador: evita trabajo absurdo de flags.
			const Instruction* prev = nullptr;
			{
				eng::u16 q = b;
				while (q != p) {
					const Instruction& in = instr_[q];
					if (term != nullptr && q == term->addr && term_ctrl) { break; }
					if (term != nullptr &&
					    static_cast<eng::u16>(q + kOpcodeTable[in.opcode].size) == term->addr) {
						prev = &in;
					}
					q = static_cast<eng::u16>(q + kOpcodeTable[in.opcode].size);
				}
			}
			const Instruction* cmp = nullptr;
			if (prev != nullptr && term != nullptr &&
			    kOpcodeTable[term->opcode].mode == AddrMode::Rel && !native_vblank_wait(*term)) {
				const char* pm = kOpcodeTable[prev->opcode].mnemonic;
				if ((sv_equal(pm, "CMP") || sv_equal(pm, "CPX") || sv_equal(pm, "CPY")) &&
				    kOpcodeTable[prev->opcode].mode == AddrMode::Imm) {
					cmp = prev;
				}
			}
			// Vivacidad de flags (backward) para DCE: `keep[addr]` = flags que esa instruccion
			// DEBE fijar (leidos mas adelante). Los no vivos se omiten en el codegen.
			eng::u16 iaddr = 0u;
			eng::u8 ikeep[256] {};
			{
				eng::u16 qq = b;
				eng::u8 live = 0u;
				// Flags vivos al SALIR del bloque: la rama lee sus flags; una caida a otro bloque
				// (sucesor desconocido) es conservadora (todos vivos); un terminador duro (JMP/RTS/
				// RTI/BRK) o el final de bloque no leen flags.
				if (term != nullptr && kOpcodeTable[term->opcode].mode == AddrMode::Rel) {
					live = decomp_flags_read(kOpcodeTable[term->opcode].mnemonic);
				} else if (term == nullptr ||
					   (!sv_equal(kOpcodeTable[term->opcode].mnemonic, "JMP") &&
					    !sv_equal(kOpcodeTable[term->opcode].mnemonic, "RTS") &&
					    !sv_equal(kOpcodeTable[term->opcode].mnemonic, "RTI") &&
					    !sv_equal(kOpcodeTable[term->opcode].mnemonic, "BRK"))) {
					live = 0xFFu;
				}
				while (qq != p && iaddr < 256u) {
					const Instruction& in = instr_[qq];
					if (term != nullptr && qq == term->addr && term_ctrl) { break; }
					iaddr = static_cast<eng::u16>(iaddr + 1u);
					qq = static_cast<eng::u16>(qq + kOpcodeTable[in.opcode].size);
				}
				const eng::u16 total = iaddr;
				for (eng::u16 idx = total; idx > 0u; --idx) {
					eng::u16 qq2 = b;
					for (eng::u16 s = 1u; s < idx; ++s) {
						qq2 = static_cast<eng::u16>(qq2 + kOpcodeTable[instr_[qq2].opcode].size);
					}
					const char* mm = kOpcodeTable[instr_[qq2].opcode].mnemonic;
					const eng::u8 wr = decomp_flags_written(mm);
					const eng::u8 rd = decomp_flags_read(mm);
					ikeep[idx - 1u] = static_cast<eng::u8>(wr & live);
					live = static_cast<eng::u8>((live & static_cast<eng::u8>(~wr)) | rd);
				}
			}
			eng::u16 q = b;
			eng::u16 ki = 0u;
			while (q != p) {
				const Instruction& in = instr_[q];
				const OpcodeInfo& inf = kOpcodeTable[in.opcode];
				if (term == nullptr || q != term->addr || !term_ctrl) {
					if (cmp == nullptr || q != cmp->addr) {
						d_keep_flags_ = ikeep[ki];
						emit_decompile_instruction(out, in);
					}
					ki = static_cast<eng::u16>(ki + 1u);
				}
				q = static_cast<eng::u16>(q + inf.size);
			}
			const eng::u16 next = p;
			if (term != nullptr) {
				const char* m = kOpcodeTable[term->opcode].mnemonic;
				const AddrMode md = kOpcodeTable[term->opcode].mode;
				if (md == AddrMode::Rel && cmp != nullptr) {
					// Rama fusionada con el CMP: condicion C directa sobre el registro.
					const char* reg = sv_equal(kOpcodeTable[cmp->opcode].mnemonic, "CMP") ? "A"
							  : (sv_equal(kOpcodeTable[cmp->opcode].mnemonic, "CPX") ? "X" : "Y");
					out.append("    if (");
					const eng::u16 n = cmp->operand;
					if (sv_equal(m, "BEQ") || sv_equal(m, "BNE")) {
						out.append(reg);
						out.append(sv_equal(m, "BEQ") ? " == " : " != ");
					} else if (sv_equal(m, "BCC") || sv_equal(m, "BCS")) {
						out.append(reg);
						out.append(sv_equal(m, "BCC") ? " < " : " >= ");
					} else if (sv_equal(m, "BMI") || sv_equal(m, "BPL")) {
						out.append("((u8)(");
						out.append(reg);
						out.append(" - ");
						out.append_u32(n);
						out.append("u) & 0x80u)");
						out.append(sv_equal(m, "BMI") ? " != 0" : " == 0");
						out.append(") { goto L_");
						out.append_hex(term->target, 4u, true);
						out.append("; }\n");
						goto after_term_rel;
					} else {
						out.append("false");
					}
					out.append_u32(n);
					out.append("u) { goto L_");
					out.append_hex(term->target, 4u, true);
					out.append("; }\n");
				after_term_rel: ;
					if (native_vis_[next] != 0u) {
						out.append("    goto L_");
						out.append_hex(next, 4u, true);
						out.append(";\n");
					}
				} else if (md == AddrMode::Rel) {
					// Sondeo de VBlank (`LDA $2002; BPL`) â†’ **evento** del HAL: el
					// port no emula la PPU, espera al VBlank del Amiga.
				if (native_vblank_wait(*term)) {
					// El idiom `LDA $2002; BPL` NO es una espera incondicional: solo espera si el
					// flag de VBlank (bit7 de $2002) esta a 0. Si ya esta puesto, la rama cae
					// (segun BPL/BMI) y el juego continua **sin** esperar (evita retrasar el reset).
					// El flag lo pone `frame_event` (VBlank) y lo limpia la lectura de $2002.
					out.append(sv_equal(m, "BMI")
						? "    if ((ppu_status & 0x80u) != 0u) { hal_wait_vblank(); }\n"
						: "    if ((ppu_status & 0x80u) == 0u) { hal_wait_vblank(); }\n");
					if (flat_) { emit_nmi_enter(out, b); }
				} else {
						// Ciclos exactos: base + 1 si tomada + 1 si cruza pÃ¡gina (rama).
						const bool pc = ((static_cast<eng::u16>(term->addr + 2u)) & 0xFF00u) !=
								(term->target & 0xFF00u);
						out.append("    if (");
						out.append(cond(m));
						out.append(") { tick(");
						out.append_u32(static_cast<eng::u32>(op_base_cycles(term->opcode)) +
								1u + (pc ? 1u : 0u));
						out.append("u); goto L_");
						out.append_hex(term->target, 4u, true);
						out.append("; }\n");
						out.append("    tick(");
						out.append_u32(op_base_cycles(term->opcode));
						out.append("u);\n");
					}
					if (native_vis_[next] != 0u) {
						out.append("    goto L_");
						out.append_hex(next, 4u, true);
						out.append(";\n");
					}
				} else if (sv_equal(m, "JMP")) {
					out.append("    tick(");
					out.append_u32(op_base_cycles(term->opcode));
					out.append("u);\n");
					// Spin-yield: si el bloque es un bucle incondicional infinito (el busy-wait
					// del juego, solo salible por NMI), disparar el NMI directamente y saltar al
					// header del bucle, cuya entrada cede la REGION (evita el bucle de NMIs que
					// causaba el yield a traves de una llamada anidada).
					if (decomp_wait_loop(b)) {
						// VBlank: el busy-wait dispara el NMI directamente (frame boundary);
						// ciclos: ceder al limite de frame por el contador.
						out.append(vblank_sync_
							? "    frame_event();\n"
							: "    if (g_cyc + 2000u < g_frame_deadline) { g_cyc = g_frame_deadline; frame_event(); }\n");
						if (flat_ && vblank_sync_) { emit_nmi_enter(out, b); }
					}
					if (native_vis_[term->target] != 0u) {
						out.append("    goto L_");
						out.append_hex(term->target, 4u, true);
						out.append(";\n");
					}
				} else if (sv_equal(m, "JSR")) {
					out.append("    tick(");
					out.append_u32(op_base_cycles(term->opcode));
					out.append("u);\n");
					// **Pila emulada**: se apila la direcciÃ³n de retorno (addr+2, como el
					// 6502) para que `SP`, `PHA/PLA/PHP/PLP` y la RAM de pila coincidan
					// con el original. El control va por llamada C `f_target()`.
					const eng::u16 ret = static_cast<eng::u16>(term->addr + 2u);
					out.append("    wr(0x100u + SP, 0x");
					out.append_hex(static_cast<eng::u16>((ret >> 8u) & 0xFFu), 2u, true);
					out.append("u); --SP;\n    wr(0x100u + SP, 0x");
					out.append_hex(static_cast<eng::u16>(ret & 0xFFu), 2u, true);
					out.append("u); --SP;\n");
					if (flat_) {
						// Flatten: apilar el PUNTERO DE RETORNO (a la etiqueta de `next`) y `goto`
						// al target; el `RTS` hara `goto *` de la pila. Sin llamadas C -> A/X/Y a
						// registros.
						out.append("    ret_lbl[ret_sp++] = &&L_");
						out.append_hex(next, 4u, true);
						out.append("; goto L_");
						out.append_hex(term->target, 4u, true);
						out.append(";\n");
					} else {
						out.append("    f_");
						out.append_hex(term->target, 4u, true);
						out.append("();\n    SP = (u8)(SP + 2u);\n");
						if (native_vis_[next] != 0u) {
							out.append("    goto L_");
							out.append_hex(next, 4u, true);
							out.append(";\n");
						}
					}
				} else if (sv_equal(m, "RTS") || sv_equal(m, "RTI")) {
					out.append("    tick(");
					out.append_u32(op_base_cycles(term->opcode));
					if (flat_) {
						// Flatten: recuperar la direccion (pila NES) y saltar al retorno guardado.
						// `RTS` ajusta SP (pop de 2); `RTI` NO: el NMI se modela como evento
						// (sin push), igual que el modo no-flat, para que SP quede consistente.
						out.append(sv_equal(m, "RTS")
							? "u); SP = (u8)(SP + 2u); goto *ret_lbl[--ret_sp];\n"
							: "u); goto *ret_lbl[--ret_sp];\n");
					} else {
						out.append("u);\n    return;\n");
					}
				} else if (sv_equal(m, "BRK")) {
					out.append("    tick(");
					out.append_u32(op_base_cycles(term->opcode));
					out.append("u);\n    halted = true; return;\n");
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
		if (!flat_) {
			out.append("}\n\n");
		}
	}

	/// Emite el **decompilado** completo a `out` (fase 1: C plano + HAL + regiones).
	void emit_decompile(Dyn& out) {
		out.append("// ============================================================\n");
		out.append("// Decompilado (port nativo, NO emulacion). nes_transpiler --decompile\n");
		out.append("// Fase 1: C plano (RAM+HAL, sin n2a::CPU) + regiones con etiquetas/goto.\n");
		out.append("// Ver docs/DECOMPILADOR.md (estructuracion, tipos, renderer).\n");
		out.append("// ============================================================\n");
		out.append("#include <eng/core/types/types.hpp>\n");
		out.append("using eng::u8; using eng::u16; using eng::u32;\n\n");
		emit_rom(out);
		out.append("static u8 ram[0x800];\n");
		out.append("static u8 A = 0, X = 0, Y = 0, SP = 0xFD;\n");
		out.append("static bool Cf=false, Zf=false, Nf=false, Vf=false, Df=false, If=false;\n");
		out.append("static bool halted = false;\n");
		// HAL: **modelo fiel del PPU del lado CPU** (registros y VRAM). El render
		// (Blitter/Copper) es otra capa; para la *lÃ³gica* basta con estos registros y
		// `$2002` (VBlank/sprite-0/overflow con *clear-on-read*), OAM y DMA de OAM.
		out.append("// --- HAL: PPU ($2000-$2007, $2002, $4014) + hooks ---\n");
		out.append("static u8 ppu_ctrl=0, ppu_mask=0, ppu_status=0, ppu_oam_addr=0, ppu_latch=0;\n");
		out.append("static u16 ppu_scroll=0, ppu_addr=0;\n");
		out.append("static u8 vram[0x1000]; static u8 palette[0x20]; static u8 oam[0x100];\n");
		// **Inferencia de intenciones**: celdas del nametable/atributo **sucias** (escritas por
		// el juego desde el ultimo frame). El app las traduce a `Layer.set_tile`/`set_attr`.
		out.append("static u8 nt_dirty[0x1000];\n");
		// **Cola de celdas sucias**: evita el escaneo O(0x1000) de `n2a_ppu_dirty_pop` por frame.
		// Al cambiar una celda se encola una vez (marcada en `nt_dirty`); el pop es O(1).
		out.append("static u16 nt_dirty_q[0x1000]; static u16 nt_dirty_n = 0u, nt_dirty_head = 0u;\n");
		// Mando NES ($4016/$4017): `n2a_pad` = botones activos (bit0=A,1=B,2=Select,3=Start,
		// 4=Up,5=Down,6=Left,7=Right); `n2a_pad_shift` = registro de desplazamiento. El app fija
		// los botones con `n2a_set_pad` cada frame.
		out.append("static u8 n2a_pad = 0, n2a_pad_shift = 0;\n");
		out.append("static void n2a_set_pad(u8 v) { n2a_pad = v; }\n");
		out.append("static u8 hanam = 0; // hook del app: 0 = no inferir intenciones\n");
		out.append("static u8 (*hal_ppu_read_hook)(u16) = 0;\n");
		out.append("static void (*hal_vblank_hook)(void) = 0;\n");
		out.append("static __attribute__((always_inline)) inline u8 hal_ppu_read(u16 a) {\n");
		out.append("    if (hal_ppu_read_hook != 0) { return hal_ppu_read_hook(a); }\n");
		out.append("    if ((a & 7u) == 2u) { const u8 r = ppu_status; ppu_status = (u8)(ppu_status & 0x7Fu); ppu_latch = 0; return r; }\n");
		// Mando: devuelve el bit bajo del registro de desplazamiento y lo desplaza (relleno de 1s).
		out.append("    if (a == 0x4016u || a == 0x4017u) { const u8 r = (u8)(n2a_pad_shift & 1u); n2a_pad_shift = (u8)((n2a_pad_shift >> 1) | 0x80u); return r; }\n");
		out.append("    return 0;\n}\n");
		out.append("static __attribute__((always_inline)) inline void hal_ppu_write(u16 a, u8 v) {\n");
		out.append("    switch (a) {\n");
		out.append("    case 0x2000u: ppu_ctrl = v; break;\n");
		out.append("    case 0x2001u: ppu_mask = v; break;\n");
		out.append("    case 0x2003u: ppu_oam_addr = v; break;\n");
		out.append("    case 0x2004u: oam[ppu_oam_addr++] = v; break;\n");
		out.append("    case 0x2005u: if (ppu_latch == 0) { ppu_scroll = v; } else { ppu_scroll = (u16)((v << 8) | (ppu_scroll & 0xFFu)); } ppu_latch ^= 1u; break;\n");
		out.append("    case 0x2006u: if (ppu_latch == 0) { ppu_addr = (u16)(v << 8); } else { ppu_addr = (u16)((ppu_addr & 0xFF00u) | v); } ppu_latch ^= 1u; break;\n");
		// $2007: SOLO $2000-$3EFF (nametables) van a `vram[]`; $3F00+ a paleta. Las escrituras a
		// $0000-$1FFF (CHR) se IGNORAN: en este modelo el CHR es ROM (tablas de patrones de solo
		// lectura) y enrutarlas a `vram[x & 0xFFF]` machacaba la nametable/atributos (DK escribe
		// $03C0-$03FF y borraba la tabla de atributos en `vram[0x3C0]`).
		out.append("    case 0x2007u: { const u16 x = (u16)(ppu_addr & 0x3FFFu); if (x >= 0x2000u && x < 0x3F00u) { const u16 _i = (u16)(x & 0xFFFu); if (vram[_i] != v) { vram[_i] = v; if (!nt_dirty[_i]) { nt_dirty[_i] = 1u; nt_dirty_q[nt_dirty_n++] = _i; } } } else if (x >= 0x3F00u) { palette[(x - 0x3F00u) & 0x1Fu] = v; } ppu_addr = (u16)(ppu_addr + ((ppu_ctrl & 0x04u) ? 32u : 1u)); } break;\n");
		out.append("    case 0x4014u: { const u8* s = ram + ((u16)v << 8); for (int i = 0; i < 256; ++i) { oam[i] = s[i]; } } break;\n");
		out.append("    case 0x4016u: if (v & 1u) { n2a_pad_shift = n2a_pad; } break;\n");
		out.append("    default: break;\n    }\n}\n");
		// --- Intenciones para el app (traducir a motores del engine) ---
		out.append("// Scroll del BG (intencion: Layer.scroll_to).\n");
		out.append("static u16 n2a_ppu_scroll_x(void) { return (u16)(ppu_scroll & 0xFFu); }\n");
		out.append("static u16 n2a_ppu_scroll_y(void) { return (u16)(ppu_scroll >> 8); }\n");
		out.append("static u8 n2a_ppu_ctrl(void) { return ppu_ctrl; }\n");
		out.append("static u8 n2a_ppu_mask(void) { return ppu_mask; }\n");
		out.append("// Celdas de nametable/atributo sucias (intencion: Layer.set_tile/set_attr).\n");
		out.append("static int n2a_ppu_dirty_pop(u16* addr, u8* val) { if (nt_dirty_head >= nt_dirty_n) { nt_dirty_head = 0u; nt_dirty_n = 0u; return 0; } const u16 i = nt_dirty_q[nt_dirty_head++]; *addr = i; *val = vram[i]; nt_dirty[i] = 0u; return 1; }\n");
		out.append("static u8 n2a_ppu_vram(u16 a) { return vram[a & 0xFFFu]; }\n");
		out.append("// Sprites (intencion: SpriteScene) y paleta (intencion: palette.set).\n");
		out.append("static u8 n2a_ppu_oam(u8 i) { return oam[i]; }\n");
		out.append("static u8 n2a_ppu_pal(u8 i) { return palette[i & 0x1Fu]; }\n");
		out.append("static void hal_vblank(void) { ppu_status = (u8)(ppu_status | 0x80u); }\n");
		out.append("static void f_");
		out.append_hex(nmi_, 4u, true);
		out.append("(void); /* handler NMI */\n");
		// **Modelo de timing del port**: un contador de **ciclos emulados** dispara el
		// **evento de frame** (VBlank + NMI) en cada frontera (29780 ciclos NTSC). Es el
		// reloj del port (no hay reloj de pared).
		out.append("static u32 g_cyc = 0, g_frame_deadline = 29780u;\n");
		// **Modo engine (reanudable)**: el app llama `n2a_frame()` una vez por frame; el port
		// corre ~1 frame de ciclos, ejecuta el NMI y **cede** (cooperativo) en la siguiente
		// frontera de bloque, guardando `g_resume` para reanudar. Con `g_engine_mode=0` el port
		// se autogestiona (standalone, tests host).
		out.append("static u8 g_engine_mode = 0, g_yield_req = 0;\n");
		out.append("static u8 g_nmi_pending = 0; /* flat: `frame_event` marca NMI; `n2a_run` lo ejecuta inline */\n");
		out.append("static unsigned g_nmi_fires = 0u; /* diagnostico: NMIs disparados (debe ser 1/frame) */\n");
		out.append("static unsigned n2a_nmi_fires(void) { return g_nmi_fires; }\n");
		out.append("static u16 g_resume = 0;\n");
		out.append("static void (*hal_frame_hook)(void) = 0;\n");
		out.append("static void frame_event(void) { g_frame_deadline += 29780u; hal_vblank(); if (hal_frame_hook) { hal_frame_hook(); } ");
		if (flat_) {
			// Flatten: el NMI NO se llama como funcion (seria un call C que recargaria
			// A/X/Y); se marca y `n2a_run` lo ejecuta inline mediante la pila de retorno.
			// **Gate por `ppu_ctrl` bit 7**: el NES real solo dispara el NMI si esta habilitado;
			// sin esto el reset (que pone $2000 bit7=0) recibia un NMI espurio en su espera de
			// VBlank -> divergencia de RAM desde el frame 1.
			out.append("g_nmi_pending = (u8)((ppu_ctrl & 0x80u) ? 1u : 0u); ");
		} else {
			out.append("if (ppu_ctrl & 0x80u) { ++g_nmi_fires; f_");
			out.append_hex(nmi_, 4u, true);
			out.append("(); } ");
		}
		out.append("if (g_engine_mode) { g_yield_req = 1u; } }\n");
		// Sondeo de VBlank: **espera** al evento (avanza los ciclos a la frontera y lo
		// ejecuta), en vez de disparar el NMI de inmediato.
		if (vblank_sync_) {
			out.append("static void hal_wait_vblank(void) { frame_event(); }\n");
		} else {
			out.append("static void hal_wait_vblank(void) { g_cyc = g_frame_deadline; frame_event(); }\n");
		}
		// VBlank (A1200): `tick` solo acumula ciclos (modelo hibrido); el frame lo marca el
		// busy-wait/`hal_wait_vblank`. Modelo de ciclos completo si no esta activo (PC/fidelidad).
		if (vblank_sync_) {
			// VBlank: `g_cyc` no marca el frame -> `tick` es no-op; el compilador lo DCE (y el
			// acumulador de ciclos) al no leerse en ningun sitio. Ahorra ~10 ciclos/instruccion.
			out.append("static void tick(u32 n) { (void)n; }\n");
		} else {
			out.append("static void tick(u32 n) { g_cyc += n; while (g_cyc >= g_frame_deadline) { frame_event(); } }\n");
		}
		out.append("static unsigned long g_steps = 0, g_step_limit = 0;\n");

		out.append("static unsigned g_label = 0; /* diagnostico: ultima etiqueta ejecutada */\n");
#ifdef N2A_TRACE_BLOCK
		out.append("static u8 g_dbgA=0, g_dbgX=0, g_dbgY=0, g_dbgZ=0, g_dbgC=0; /* diagnostico: estado en el ultimo bloque */\n");
#endif
		out.append("static void (*hal_limit_hook)(void) = 0; /* diagnostico: corta al pasar g_steps */\n");
		out.append("static __attribute__((always_inline)) inline u8 rd(u16 a) {\n");
		// El contador de pasos (diagnostico) era un load+compare+branch por CADA lectura. Solo se
		// emite bajo `N2A_TRACE_STEPS` (transpilador) para no costar en produccion.
#ifdef N2A_TRACE_STEPS
		out.append("    if (g_step_limit != 0 && ++g_steps > g_step_limit) { if (hal_limit_hook) { hal_limit_hook(); } }\n");
#endif
		out.append("    if (a < 0x2000u) { return ram[a & 0x7FFu]; }\n");
		out.append("    if (a >= 0x8000u) { return PRG_ROM[(a - 0x8000u) & (kPrgSize - 1u)]; }\n");
		out.append("    return hal_ppu_read(a);\n}\n");
#ifdef N2A_WTRACE
		out.append("static u16 n2a_wt_a[65536]; static u8 n2a_wt_v[65536]; static unsigned n2a_wt_n = 0u;\n");
		out.append("static void n2a_wt_log(u16 a, u8 v) { if (n2a_wt_n < 65536u) { n2a_wt_a[n2a_wt_n] = a; n2a_wt_v[n2a_wt_n] = v; ++n2a_wt_n; } }\n");
#endif
		out.append("static __attribute__((always_inline)) inline void wr(u16 a, u8 v) {\n");
#ifdef N2A_WTRACE
		out.append("    if (a < 0x2000u) { n2a_wt_log(a, v); ram[a & 0x7FFu] = v; return; }\n");
#else
		out.append("    if (a < 0x2000u) { ram[a & 0x7FFu] = v; return; }\n");
#endif
		out.append("    hal_ppu_write(a, v);\n}\n");
		// `setnz` DEBE ser `always_inline`: en flat, A/X/Y/flags son LOCALES de `n2a_run`;
		// si fuera una funcion de fichero, escribiria los `Zf/Nf` GLOBALES y el codigo leeria
		// los locales (desincronizados -> bucles que nunca terminan, p. ej. el copy a $2007).
		out.append("static __attribute__((always_inline)) inline void setnz(u8 v) { Zf = (v == 0); Nf = ((v & 0x80u) != 0); }\n\n");
		eng::util::Vector<eng::u16, eng::util::HeapAlloc> entries {};
		const auto add_entry = [&](eng::u16 a) {
			if (a < kSpace && has_instr_[a] != 0u) {
				for (eng::usize i = 0; i < entries.size(); ++i) {
					if (entries[i] == a) return;
				}
				(void)entries.push_back(a);
			}
		};
		add_entry(reset_);
		add_entry(nmi_);
		add_entry(irq_);
		for (eng::u32 a = 0; a < kSpace; ++a) {
			if (has_instr_[a] != 0u &&
			    sv_equal(kOpcodeTable[instr_[a].opcode].mnemonic, "JSR") &&
			    has_operand(instr_[a])) {
				add_entry(instr_[a].target);
			}
		}
		for (eng::usize i = 0; i < extra_entries_.size(); ++i) {
			add_entry(extra_entries_[i]);
		}
		for (eng::usize i = 0; i < entries.size(); ++i) {
			out.append("static void f_");
			out.append_hex(entries[i], 4u, true);
			out.append("(void);\n");
		}
		out.append('\n');
		(void)decomp_region_of_.resize(kSpace, 0u);
		for (eng::u32 i = 0; i < kSpace; ++i) {
			decomp_region_of_[i] = 0u;
		}
		(void)emitted_.resize(kSpace, 0u);
		for (eng::u32 i = 0; i < kSpace; ++i) { emitted_[i] = 0u; }
		nmi_enter_seq_ = 0;
		if (flat_) {
			// Flatten: UNA funcion con A/X/Y/flags LOCALES (registros) + pila de retorno.
			out.append("[[gnu::used]] static void n2a_run(void) {\n");
			out.append("    u8 A = 0u, X = 0u, Y = 0u, SP = 0xFD;\n");
			out.append("    bool Cf = false, Zf = false, Nf = false, Vf = false, Df = false, If = false;\n");
			out.append("    void* ret_lbl[64]; u16 ret_sp = 0u;\n");
			// Resume por tabla ordenada + busqueda binaria (un `switch` con miles de casos
			// desborda la tabla de salto m68k) con PUNTEROS de etiqueta (`&&`).
			out.append("    static const struct { u16 a; const void* l; } kRL[] = {\n");
			for (eng::u32 a = 0; a < kSpace; ++a) {
				if (leaders_[a] != 0u && has_instr_[a] != 0u) {
					out.append("        {0x");
					out.append_hex(static_cast<eng::u16>(a), 4u, true);
					out.append("u, &&L_");
					out.append_hex(static_cast<eng::u16>(a), 4u, true);
					out.append("}, ");
				}
			}
			out.append("\n    };\n");
			out.append("    if (g_resume != 0u) { const u16 n2a_r = g_resume; g_resume = 0u; u16 lo = 0u, hi = (u16)(sizeof(kRL)/sizeof(kRL[0]));\n");
			out.append("        while (lo < hi) { const u16 mid = (u16)((lo + hi) / 2u); if (kRL[mid].a < n2a_r) { lo = (u16)(mid + 1u); } else { hi = mid; } }\n");
			out.append("        if (lo < (u16)(sizeof(kRL)/sizeof(kRL[0])) && kRL[lo].a == n2a_r) { goto *kRL[lo].l; } }\n");
			// Arranque: sin resume, entrar por el vector de RESET (el primer bloque emitido no
			// tiene por que serlo; en no-flat el despachador llama a `f_<reset>`).
			out.append("    if (g_resume == 0u) { goto L_");
			out.append_hex(reset_, 4u, true);
			out.append("; }\n");
		}
		for (eng::usize i = 0; i < entries.size(); ++i) {
			emit_decompile_region(out, entries[i]);
		}
		if (flat_) {
			out.append("}\n\n");
		}
		// **`n2a_frame()`**: el app lo llama una vez por frame. La primera vez arranca por
		// `reset`; despues reanuda en el bloque guardado en `g_resume` (corre ~1 frame de
		// ciclos, ejecuta el NMI y cede). `g_engine_mode=1` activa el modo reanudable.
		// Tabla bloque->region (ordenada) + busqueda binaria. Un `switch` con miles de
		// casos DESBORDA la tabla de salto del ensamblador m68k ("switch too large").
		if (flat_) {
			out.append("[[gnu::used]] void n2a_frame(void) { g_engine_mode = 1u; n2a_run(); }\n");
		} else {
			out.append("struct N2A_Res { u16 a; void (*fn)(void); };\n");
			out.append("static const N2A_Res kRes[] = {\n");
			for (eng::u32 a = 0; a < kSpace; ++a) {
				if (decomp_region_of_[a] != 0u) {
					out.append("    {0x");
					out.append_hex(static_cast<eng::u16>(a), 4u, true);
					out.append("u, &f_");
					out.append_hex(decomp_region_of_[a], 4u, true);
					out.append("},\n");
				}
			}
			out.append("};\nstatic const u16 kResN = (u16)(sizeof(kRes) / sizeof(kRes[0]));\n");
			out.append("[[gnu::used]] void n2a_frame(void) {\n    g_engine_mode = 1u;\n    if (g_resume == 0u) { f_");
			out.append_hex(reset_, 4u, true);
			out.append("(); return; }\n    u16 lo = 0u, hi = kResN;\n    while (lo < hi) { const u16 mid = (u16)((lo + hi) / 2u); if (kRes[mid].a < g_resume) { lo = (u16)(mid + 1u); } else { hi = mid; } }\n    if (lo < kResN && kRes[lo].a == g_resume) { kRes[lo].fn(); return; }\n    g_resume = 0u;\n}\n");
		}
		out.append("[[gnu::used]] void game_main(void) {\n    for (;;) { n2a_frame(); if (halted) { return; } }\n}\n");
		out.append("#if !defined(__m68k__) && !defined(N2A_NO_HOST_MAIN)\n");
		out.append("int main() { game_main(); return 0; }\n#endif\n");
	}

	/// Emite el **despacho de un `JMP (ind)`** (`$6C`) con los destinos observados
	/// (`--ind-targets`) del sitio `site`. Reproduce el *page-wrap* del 6502
	/// (`(ptr & 0xFF00) | ((ptr+1) & 0xFF)`), y salta con `goto L_xxxx`
	/// (**intra-regiÃ³n**, porque un `JMP` es salto de cola y no debe crecer la pila C).
	/// Si el destino no estÃ¡ entre los observados, cede al runtime
	/// (`g_native_ind_miss`) o se detiene (`halted`).
	/// \param out  Salida.
	/// \param site `PC` del `JMP ($zp)`.
	void emit_native_ind_dispatch(Dyn& out, eng::u16 site) const {
		const eng::u16 ptr = instr_[site].operand;
		out.append("    { const eng::u16 n2a_p = 0x");
		out.append_hex(ptr, 4u, true);
		out.append("u; const eng::u16 n2a_t = static_cast<eng::u16>(static_cast<eng::u16>(n2a_read(*m, n2a_p)) | (static_cast<eng::u16>(n2a_read(*m, static_cast<eng::u16>((n2a_p & 0xFF00u) | ((n2a_p + 1u) & 0x00FFu)))) << 8u)); switch (n2a_t) {");
		for (eng::usize i = 0; i < ind_site_.size(); ++i) {
			if (ind_site_[i] != site) {
				continue;
			}
			out.append(" case 0x");
			out.append_hex(ind_target_[i], 4u, true);
			out.append("u: goto L_");
			out.append_hex(ind_target_[i], 4u, true);
			out.append(";");
		}
		out.append(" default: if (g_native_ind_miss != nullptr) { g_native_ind_miss(*r, *m, n2a_t); } else { r->pc = n2a_t; r->halted = true; } return; } }\n");
	}

	/// Emite una **regiÃ³n** (funciÃ³n C++) del backend nativo: BFS de bloques desde
	/// `entry` por aristas estÃ¡ticas (caÃ­da/rama/`JMP`; el retorno de `JSR` continÃºa en la
	/// regiÃ³n; el destino de `JSR` es otra regiÃ³n). Etiquetas `L_xxxx` + `goto`.
	void emit_native_region(Dyn& out, eng::u16 entry) {
		(void)native_vis_.resize(kSpace, 0u);
		for (eng::u32 i = 0; i < kSpace; ++i) {
			native_vis_[i] = 0u; // `resize` no reescribe; limpiar para cada regiÃ³n
		}
		eng::util::Vector<eng::u16, eng::util::HeapAlloc> stack {};
		const auto visit = [&](eng::u16 b) {
			if (b < kSpace && has_instr_[b] != 0u && native_vis_[b] == 0u) {
				native_vis_[b] = 1u;
				(void)stack.push_back(b);
			}
		};
		// Visita los **destinos observados** de un `JMP (ind)` (telemetrÃ­a de
		// `ind_targets`). No exigen ser `leader` estÃ¡tico: son inicios de instrucciÃ³n
		// vistos en ejecuciÃ³n, asÃ­ que se emiten como etiquetas `L_xxxx` **en esta misma
		// regiÃ³n** y el `JMP (ind)` se resuelve con un `switch` + `goto` intra-regiÃ³n
		// (un `JMP` es salto de cola: no debe crecer la pila de llamadas C).
		const auto visit_ind = [&](eng::u16 site) {
			for (eng::usize i = 0; i < ind_site_.size(); ++i) {
				if (ind_site_[i] != site) {
					continue;
				}
				const eng::u16 t = ind_target_[i];
				if (t < kSpace && has_instr_[t] != 0u && native_vis_[t] == 0u) {
					native_vis_[t] = 1u;
					(void)stack.push_back(t);
				}
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
					if (md == AddrMode::Ind) {
						visit_ind(term->addr); // destinos observados (--ind-targets)
					} else {
						visit(term->target);
					}
				} else if (sv_equal(m, "JSR")) {
					visit(next); // retorno del JSR (continÃºa en la regiÃ³n)
				} else if (!sv_equal(m, "RTS") && !sv_equal(m, "RTI") &&
					   !sv_equal(m, "BRK")) {
					visit(next); // Ultima corriente: cae al siguiente bloque
				}
			} else {
				visit(next);
			}
		}
		// Orden ascendente para localidad de cÃ³digo.
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
		// NÂº de aristas estÃ¡ticas de la regiÃ³n que entran en `target`: para absorber
		// idioms que cruzan un `BNE` solo si nadie mÃ¡s entra en el bloque intermedio.
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
			native_x_known_ = false; // VSA de Ã­ndices: se reinicia en cada bloque
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
					// El `DEC lo` (1Âª instrucciÃ³n del bloque skip) ya estÃ¡ hecho: se
					// omitirÃ¡ al emitir ese bloque.
					native_skip_first_ = static_cast<eng::u16>(mid + 2u);
					continue;
				}
			}
			eng::u16 p = b;
			if (b == native_skip_first_ && has_instr_[p] != 0u) {
				// 1Âª instrucciÃ³n del bloque ya absorbida por un idiom (p. ej. `DEC lo`).
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
				// PatrÃ³n (idioma PRNG): tirada de `ROR/ROL zp` sobre direcciones
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
					// Bucle de espera de VBlank/sprite-0 (`native_vblank_wait`): cede al
					// runtime en vez de girar. Al ceder se guarda en `r->pc` el punto de
					// **reanudaciÃ³n** (la continuaciÃ³n del bucle) para que `game_main`
					// reanude ahÃ­ y **no** vuelva a ejecutar la inicializaciÃ³n.
					if (native_vblank_wait(*term)) {
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
						out.append(") { r->pc = 0x");
						out.append_hex(next, 4u, true);
						out.append("u; r->yield = true; return; }\n");
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
					if (kOpcodeTable[term->opcode].mode == AddrMode::Ind) {
						// `JMP ($zp)`: despacho por los destinos observados.
						emit_native_ind_dispatch(out, term->addr);
					} else if (term->target == b) {
						// `JMP a si mismo`: espera de NMI; cede al runtime y reanuda en `b`.
						out.append("    r->pc = 0x");
						out.append_hex(b, 4u, true);
						out.append("u; r->yield = true; return;\n");
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
	/// operaciÃ³n de 16 bits, para que g++ use `move.w`/`add.w` en vez de byte a byte:
	///
	///   - **copia 16 bits**: `LDA zp a; STA zp c; LDA zp a+1; STA zp c+1`
	///     -> `*(u16*)&ram[c] = *(u16*)&ram[a]` (el orden de bytes se conserva).
	///   - **constante 16 bits**: `LDA #k0; STA zp c; LDA #k1; STA zp c+1`
	///     -> dos bytes (g++ puede combinarlos) + `A = k1` con flags.
	///
	/// El estado final (A y flags) replica la secuencia byte a byte del 6502.
	/// \param out  Salida.
	/// \param p    DirecciÃ³n de la primera instrucciÃ³n.
	/// \param next [salida] DirecciÃ³n tras el idiom (`p+8`).
	/// \return `true` si se emitiÃ³ el idiom.
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
		// --- ComparaciÃ³n 16 bits: LDA zp a; CMP #k0|zp m0; LDA zp a+1; SBC #k1|zp m1 ---
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

	/// Emite una instrucciÃ³n del backend nativo (salvo transferencias de control, que
	/// resuelve `emit_native_region`). `r` es `N2A_State*`, `m` es `N2A_Bus*`.
	void emit_native_instruction(Dyn& out, const Instruction& in) {
		const OpcodeInfo& info = kOpcodeTable[in.opcode];
		const char* m = info.mnemonic;
		// VSA (const-prop simple de A/X/Y): sigue valores conocidos a travÃ©s de
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
		// ExpresiÃ³n del operando efectivo (rvalue del byte).
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
				// Ãndice de ROM con X/Y **conocido** (VSA): plegar a **literal**.
				const bool known = (info.mode == AddrMode::AbsX) ? native_x_known_ : native_y_known_;
				const eng::u8 iv = (info.mode == AddrMode::AbsX) ? native_x_val_ : native_y_val_;
				if (known) {
					const eng::u32 idx = (static_cast<eng::u32>(in.operand) - 0x8000u + iv) &
							     (prg_size_ - 1u);
					out.append("0x");
					out.append_hex(prg_[idx], 2u, true);
					return;
				}
				// ROM indexada (Ã­ndice de runtime): acceso directo al array constexpr.
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
			// Modo **acumulador** (`ASL A`/`ROL A`/`LSR A`/`ROR A`, opcodes
			// `$0A`/`$2A`/`$4A`/`$6A`): operan sobre `r->a`, no sobre memoria (el
			// modo `Acc` no tiene operando efectivo). El resto opera sobre memoria.
			const bool acc = (in.opcode == 0x0Au || in.opcode == 0x2Au ||
					  in.opcode == 0x4Au || in.opcode == 0x6Au);
			out.append("    { eng::u8 n2a_v = ");
			if (acc) {
				out.append("r->a;");
			} else {
				out.append("n2a_read(*m, ");
				emit_native_ea(out, in);
				out.append(");");
			}
			if (sv_equal(m, "ASL")) {
				out.append(" r->c = ((n2a_v & 0x80u) != 0u); n2a_v = static_cast<eng::u8>(n2a_v << 1u);");
			} else if (sv_equal(m, "LSR")) {
				out.append(" r->c = ((n2a_v & 1u) != 0u); n2a_v = static_cast<eng::u8>(n2a_v >> 1u);");
			} else if (sv_equal(m, "ROL")) {
				out.append(" { const eng::u8 n2a_c = r->c ? 1u : 0u; r->c = ((n2a_v & 0x80u) != 0u); n2a_v = static_cast<eng::u8>((n2a_v << 1u) | n2a_c); }");
			} else {
				out.append(" { const eng::u8 n2a_c = r->c ? 1u : 0u; r->c = ((n2a_v & 1u) != 0u); n2a_v = static_cast<eng::u8>((n2a_v >> 1u) | (n2a_c << 7u)); }");
			}
			if (acc) {
				out.append(" r->a = n2a_v;");
			} else {
				out.append(" n2a_write(*m, ");
				emit_native_ea(out, in);
				out.append(", n2a_v);");
			}
			out.append(" r->z = (n2a_v == 0u); r->n = ((n2a_v & 0x80u) != 0u); }\n");
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
		// --- Opcodes ilegales frecuentes (misma semÃ¡ntica que `CPU::*_impl`) ---
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

	/// ExpresiÃ³n de la **direcciÃ³n efectiva** (u16) de una instrucciÃ³n del backend nativo.
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
	/// tablas **dispersas** (bloques/ciclos + bÃºsqueda binaria) para la ventana
	/// fija y por banco, el estado global `g_state`, `game_main()` y el `main()` de
	/// host (excluido en Amiga o con `N2A_NO_HOST_MAIN`).
	void emit_dispatch(Dyn& out) const {
		out.append("// ---- Despacho y entrada ----\n\n");
		out.append("/// Firma de un basic block: recibe el CPU (y su memoria) y muta el estado.\n");
		out.append("using BlockFn = void (*)(CPU&);\n\n");
		out.append("/// Entrada de despacho **dispersa**: direcciÃ³n de inicio + ciclos base + bloque.\n");
		out.append("/// Sustituye a la tabla densa `[0x10000]` (256 KB en 68000, casi toda a cero).\n");
		out.append("struct BankBlock { eng::u16 start; eng::u16 cycles; BlockFn fn; };\n\n");
		out.append("/// Estado global del juego (CPU + memoria).\n");
		out.append("struct GameState { CPU cpu; NESMemory mem; };\n");
		out.append("static GameState g_state;\n\n");
		// --- Bloques de la ventana fija, ordenados por direcciÃ³n ---
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
			out.append("/// Bloques de la ventana fija ($C000-$FFFF y NROM/CNROM), ordenados por direcciÃ³n.\n");
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
		out.append("/// BÃºsqueda **binaria** de la entrada de bloque fijo para `pc`.\n");
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
			// Copia de los bloques del banco, **ordenada por direcciÃ³n** (el
			// runtime hace bÃºsqueda binaria).
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
		out.append("/// sÃ­mbolo queda excluido (por __m68k__ o por N2A_NO_HOST_MAIN).\n");
		out.append("int main() { game_main(); return 0; }\n");
		out.append("#endif\n");
	}
};

} // namespace n2a

