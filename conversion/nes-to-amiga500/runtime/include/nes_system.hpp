#pragma once

/// \file nes_system.hpp
/// Sistema NES mínimo (2A03 + 2C02 + cartucho) que une CPU, PPU, APU y mapper
/// para **ejecutar una ROM** y producir frames. Es la base de la validación
/// diferencial (comparar contra `mesen`) y de la ejecución del fallback.
///
/// Alcance (F3/F9 en curso): NROM/UxROM/CNROM, PPU con fondo + sprites y APU
/// simplificada. La sincronía CPU↔PPU es aproximada (3 dots por ciclo, VBlank en
/// la línea 241) y no modela el timing exacto ni el sprite-0 en el dot preciso.

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

#include "nes_apu.hpp"
#include "nes_hle.hpp"
#include "nes_interpreter.hpp"
#include "nes_mapper.hpp"
#include "nes_palette.hpp"
#include "nes_ppu.hpp"
#include "nes_runtime.hpp"

namespace n2a {

/// Versión del **oráculo** (semántica observable de la emulación: framebuffer, RAM,
/// timing). Queda **congelada** antes de empezar el backend Amiga; cualquier cambio
/// que altere lo observable debe incrementarla (ver `docs/VERSIONS.md`).
inline constexpr int kOracleVersion = 4;

/// Consola NES mínima: memoria con hooks hacia PPU/APU/mapper, CPU intérprete y
/// control de NMI por VBlank.
struct NesSystem {
	static constexpr int kScreenW = 256;
	static constexpr int kScreenH = 240;
	/// Dot de la línea en que A12 sube (fetch de sprites) → flanco del contador IRQ MMC3.
	static constexpr eng::u16 kA12Dot = 257u;

	Mapper mapper;   ///< Cartucho (bancos y CHR).
	NESMemory mem;   ///< Memoria/bus (RAM + hooks).
	Ppu ppu;         ///< PPU (fondo, sprites, registros).
	Apu apu;         ///< APU (pulse/triangle/noise/DMC).
	Hle hle;         ///< Capa HLE (clasificación y contabilidad).
	CPU cpu;         ///< Estado de la CPU.
	Interpreter interp; ///< Intérprete 6502 que ejecuta el código.

	/// Hook del **camino rápido/transpilado**: si devuelve ciclos > 0, la
	/// instrucción la resolvió el ejecutor pre-decodificado; si 0, se cae al
	/// intérprete. Permite cambiar de motor sin tocar `NesSystem`.
	using FastStep = int (*)(void* ctx, CPU& cpu, NESMemory& mem);
	/// Ejecutor rápido **por bloques**: ejecuta varias instrucciones hasta un
	/// salto o hasta que agotaría `budget` ciclos (frontera de scanline), sin
	/// alterar el timing. `out_instrs` recibe cuántas ejecutó.
	using FastRun = int (*)(void* ctx, CPU& cpu, NESMemory& mem, int budget, int* out_instrs);
	void* fast_ctx = nullptr;       ///< Contexto del ejecutor rápido.
	FastStep fast_step = nullptr;   ///< Ejecutor rápido de una instrucción (o `nullptr`).
	FastRun fast_run = nullptr;     ///< Ejecutor rápido por bloques (o `nullptr`).
	/// El ejecutor rápido **ya reloja la PPU por acceso** (`cpu.mem->tick`, código
	/// transpilado): el host no re-reloja el bloque. `FastCpu` lo deja a `false`.
	bool fast_ticks = false;
	/// Hook opcional: se llama cuando el mapper **conmuta bancos de PRG** (escritura a
	/// `$8000-$FFFF`) para que el ejecutor rápido **invalide su decodificación**
	/// (`FastCpu::invalidate`) y la rehaga bajo demanda leyendo a través del mapper.
	/// Sin él, el ejecutor rápido solo es correcto con PRG de mapeo fijo.
	void (*fast_invalidate)(void* ctx) = nullptr;

	eng::u8 pad1 = 0;    ///< Estado del mando 1 (bit por botón).
	eng::u8 pad2 = 0;    ///< Estado del mando 2.
	bool strobe = false; ///< Strobe de `$4016`.
	eng::u8 shift1 = 0;  ///< Desplazamiento del mando 1.
	eng::u8 shift2 = 0;  ///< Desplazamiento del mando 2.
	eng::u32 nmi_count = 0; ///< NMIs tomadas (diagnóstico: ¿llega el VBlank al juego?).
	bool cycle_exact_ = true; ///< Reloj de bus por acceso activo (ver `set_cycle_exact`).

	/// Instala los hooks de E/S y enlaza el intérprete con `cpu`/`mem`.
	NesSystem() : interp(cpu, mem) {
		mem.io_user = this;
		mem.io_read = &NesSystem::io_read_cb;
		mem.io_write = &NesSystem::io_write_cb;
		mem.cycle_user = this;
		mem.cycle_tick = &NesSystem::cycle_tick_cb; // PPU dot-exacta por acceso de bus
		apu.set_reader(&NesSystem::apu_read_cb, this); // DMC: leer samples de la PRG
		hle.ppu = &ppu;
	}

	/// Asigna el cartucho (mapper y CHR) al sistema.
	/// \param m Mapper ya inicializado con PRG/CHR.
	/// Callback de lectura de CHR para el render: aplica la conmutación de bancos del
	/// mapper (`Mapper::ppu_read`). \param ctx El `Mapper`; \param addr Offset PPU.
	/// \return Byte de CHR conmutado.
	static eng::u8 chr_read_cb(void* ctx, eng::u16 addr) {
		return static_cast<Mapper*>(ctx)->ppu_read(addr);
	}

	void load_mapper(const Mapper& m) {
		mapper = m;
		ppu.chr = m.chr;
		ppu.chr_size = m.chr_size;
		ppu.chr_ram = m.chr_ram;
		ppu.chr_read = &NesSystem::chr_read_cb;
		ppu.chr_ctx = &mapper;
		ppu.mirror_h = m.mirror_h;
		ppu.nt_single = m.mirror_single;
		if (mapper.kind == MapperKind::Mmc5) {
			// Estado de power-on de la MMC5 (mesen `MMC5.h::InitMapper`): PRG modo 3 y
			// $5117 = $FF (último banco de 8 KB swapped en $E000-$FFFF, donde vive el
			// vector de reset). Sin esto el reset lee un banco equivocado.
			mapper.mmc5_prg_mode = 3;
			mapper.mmc5_prg_banks[4] = 0xFF;
		}
		mem.prg = m.prg;
		mem.prg_size = m.prg_size;
		mem.prg_bank = 0;
		mem.prg_bank2 = 0;
		mem.prg_bank3 = 0;
		mem.prg_bank4 = 0;
	}

	/// Activa/desactiva el **reloj de bus por acceso** (modelo dot-exacto del
	/// intérprete). Activado por defecto. Desactivarlo acelera el host (la PPU se
	/// reloja al final de la instrucción, modelo anterior) a costa de perder el
	/// orden intra-instrucción. No afecta al Amiga: el codegen no reloja por acceso.
	/// \param on `true` para relojear en cada acceso de bus.
	void set_cycle_exact(bool on) {
		cycle_exact_ = on;
		mem.cycle_tick = on ? &NesSystem::cycle_tick_cb : nullptr;
	}

	/// Reinicia CPU y PPU al estado de arranque (vector de reset).
	void reset() {
		cpu = CPU {};
		cpu.mem = &mem;
		cpu.PC = mem.read16(0xFFFCu);
		cpu.SP = 0xFDu;
		cpu.I = true;
		cpu.brk_halts = false; // el runtime usa la semántica del intérprete en BRK
		ppu = Ppu {};
		ppu.chr = mapper.chr;
		ppu.chr_size = mapper.chr_size;
		ppu.chr_ram = mapper.chr_ram;
		ppu.chr_read = &NesSystem::chr_read_cb; // tras `ppu = Ppu{}` (que lo limpia)
		ppu.chr_ctx = &mapper;
		ppu.mirror_h = mapper.mirror_h;
		ppu.nt_single = mapper.mirror_single;
		ppu.scanline = 0;
		ppu.vblank_suppress = false; // mesen activa el flag en (241,1) desde el frame 0
		interp.jammed = false;
		// La CPU tarda 8 ciclos en empezar a ejecutar tras el reset (mesen CPU.cpp:150:
		// "the CPU takes 8 cycles before it starts executing the ROM's code"); durante
		// ellos el PPU avanza con el master clock. Sin esto, nuestro contador de ciclos va
		// 8 por detrás de mesen y el flag de VBlank cruza instrucciones distintas.
		interp.cycles = 8;
		clock_ppu(8);
	}

	/// Ejecuta un **bloque** (varias instrucciones) si hay ejecutor rápido por
	/// bloques, o una sola instrucción de lo contrario, y avanza PPU/NMI. Es el
	/// ladrillo de `run_frame()`; se expone para pruebas en lockstep.
	/// \param out_instrs Nº de instrucciones ejecutadas (salida); puede ser `nullptr`.
	/// \return Ciclos de CPU consumidos por el bloque.
	int step_block(int* out_instrs) {
		if (fast_run != nullptr) {
			// Presupuesto hasta el próximo evento del PPU (no hasta fin de
			// scanline): el bloque rápido se corta en la frontera del evento para
			// no adelantar VBlank/sprite-0 (scheduler de eventos, Fase 3).
			const int budget = cycles_to_next_event();
			cpu.deadline = cpu.cycles + static_cast<eng::u32>(budget);
			int n = 0;
			int cyc = fast_run(fast_ctx, cpu, mem, budget, &n);
			if (cyc <= 0) {
				// Bloque vacío/no cubierto: una instrucción por el intérprete. Si el
				// reloj de bus está activo, ya reloja por acceso; si no, relojamos aquí.
				cyc = interp.step();
				n = 1;
				if (!cycle_exact_) {
					clock_ppu(cyc);
				}
			} else if (fast_ticks && cycle_exact_) {
				// El bloque ya relojó la PPU por acceso (`cpu.mem->tick`).
			} else {
				clock_ppu(cyc); // el ejecutor rápido no reloja por acceso
			}
			if (ppu.nmi_occurred) {
				ppu.nmi_occurred = false;
				trigger_nmi();
			} else if (!cpu.I && (apu.frame_irq || apu.dmc_irq || mapper.irq_line())) {
				trigger_irq();
			}
			// Código generado **encadenado** (`--amiga`): un bloque puede **ceder**
			// (`cpu.yield`) al llegar a un bucle de espera de VBlank/NMI, en vez de
			// encadenarse infinitamente. El runtime resuelve aquí los eventos (arriba)
			// y limpia la cesión; el siguiente `step_block` reanuda en `cpu.PC`.
			// Es no-op para los motores que no emiten cesiones (intérprete/FastCpu).
			if (cpu.yield) {
				cpu.yield = false;
			}
			if (out_instrs != nullptr) {
				*out_instrs = n;
			}
			return cyc;
		}
		const int cyc = step_instruction();
		if (out_instrs != nullptr) {
			*out_instrs = 1;
		}
		return cyc;
	}

	/// Ejecuta **una** instrucción de CPU y avanza la PPU/NMI en consecuencia.
	/// Se expone para pruebas en lockstep (comparar intérprete vs ejecutor rápido
	/// instrucción a instrucción).
	/// \return Ciclos de CPU consumidos por la instrucción.
	/// Ciclos de PPU a avanzar **antes** del acceso a datos de la instrucción en
	/// `cpu.PC` (dot-exacto para lecturas de registros de PPU). El acceso a datos
	/// del 6502 ocurre en el **último** ciclo de la instrucción, así que se
	/// pre-relojea `base-1` ciclos: una `LDA $2002` (4 ciclos) ve el estado en el
	/// ciclo 4 (el real), no al principio. Es una aproximación de 1 ciclo para
	/// lecturas indexadas con cruce de página. Solo afecta al orden intra-instrucción
	/// (el total no cambia), por lo que es inocuo para el timing global.
	/// \return Ciclos a pre-relojar (>= 0).
	[[nodiscard]] int ppu_pre_cycles() const {
		const eng::u8 op = mem.read(cpu.PC);
		const int b = Interpreter::opcode_cycles(op);
		return b > 0 ? b - 1 : 0;
	}

	/// Ejecuta **una** instrucción de CPU y avanza la PPU/NMI en consecuencia.
	/// Se expone para pruebas en lockstep (comparar intérprete vs ejecutor rápido
	/// instrucción a instrucción).
	/// \return Ciclos de CPU consumidos por la instrucción.
	int step_instruction() {
		int cyc;
		if (fast_step != nullptr) {
			// El ejecutor rápido no reloja por acceso: se pre-reloja al ciclo del
			// acceso a datos y se completa tras la instrucción.
			const int pre = ppu_pre_cycles();
			if (pre > 0) {
				clock_ppu(pre);
			}
			cyc = fast_step(fast_ctx, cpu, mem);
			if (cyc <= 0) {
				cyc = interp.step(); // el intérprete ya reloja por acceso (pre de más)
			} else {
				const int post = cyc - pre;
				if (post > 0) {
					clock_ppu(post);
				}
			}
		} else {
			// El intérprete reloja la PPU en cada acceso de bus y completa los ciclos
			// internos; si el reloj de bus está desactivado, se reloja aquí al final.
			cyc = interp.step();
			if (!cycle_exact_) {
				clock_ppu(cyc);
			}
		}
		// El NMI se toma en **frontera de instrucción** tras la instrucción durante la
		// cual se puso el flag de VBlank (como mesen `CPU::Exec`). LÍMITE (ver
		// docs/RISKS.md): como el flag se pone a granularidad de acceso (no de ciclo),
		// esta frontera puede caer 1 instrucción antes/después que la de mesen y
		// desalinear el *interleaving* NMI↔bucle principal de 6 juegos. La solución es
		// el lockstep PPU/CPU ciclo a ciclo (o subdividir la instrucción en el flag).
		if (ppu.nmi_occurred) {
			ppu.nmi_occurred = false; // el NMI se toma en frontera de instrucción
			trigger_nmi();
		} else if (!cpu.I && (apu.frame_irq || apu.dmc_irq || mapper.irq_line())) {
			trigger_irq(); // IRQ (frame counter del APU / DMC / MMC3), si no enmascarada
		}
		return cyc;
	}

	/// Ejecuta un frame completo: corre la CPU a lo largo de las 262 líneas de la
	/// PPU (incluido VBlank) hasta que la PPU vuelve a la **pre-VBlank (scanline 240)**.
	/// La **fase del PPU es continua** entre frames (no se resetea la scanline ni el dot;
	/// ver `docs/TIMING_ROADMAP.md`, Fase 2). El VBlank no se suprime (mesen lo levanta
	/// desde el frame 0; el antiguo `ppudead=2` de fceumm era un hack para Knight Rider).
	void run_frame() {
		ppu.vblank_suppress = false;
		ppu.mirror_h = mapper.mirror_h; // la MMC3/MMC1 cambian el mirroring en runtime
		ppu.nt_single = mapper.mirror_single;
		// MMC5: mapeo de nametables por cartucho ($5105) hacia CIRAM/ExRAM/fill.
		if (mapper.kind == MapperKind::Mmc5) {
			for (int i = 0; i < 4; ++i) {
				ppu.nt_map[i] = static_cast<eng::u8>((mapper.mmc5_nametable >> (i * 2)) & 0x03u);
			}
			ppu.nt_exram = mapper.mmc5_exram;
			ppu.nt_fill = mapper.mmc5_fill;
			ppu.nt_map_on = true;
			// Modo atributo extendido ($5104 = 1): atributo y banco CHR desde ExRAM.
			ppu.ext_attr_mode = (mapper.mmc5_exram_mode == 1u);
			// Selector chrA de la MMC5: sprites **8×16** ($2000 bit 5) → el fondo usa
			// el juego de bancos CHR B (8-11); con 8×8, el A (0-7). mesen
			// `UpdateChrBanks` (`chrA = !largeSprites`). Modelo lazy: se fija por frame.
			mapper.mmc5_chr_a = (ppu.ctrl & 0x20u) == 0u;
			ppu.ext_attr_ram = mapper.mmc5_exram;
			ppu.ext_attr_upper = mapper.mmc5_chr_upper;
			// Split vertical ($5200-$5202): el render lee la nametable desde ExRAM.
			ppu.split_ctrl = mapper.mmc5_split_ctrl;
			ppu.split_scroll = mapper.mmc5_split_scroll;
			ppu.split_exram = mapper.mmc5_exram;
		} else if (mapper.vrc6_chr_nt_active()) {
			// VRC6 con nametables por **CHR ROM** ($B003 bit 4): los 4 nametables leen
			// páginas del CHR ROM (`nt_chr_page`), con atributos incluidos.
			for (int i = 0; i < 4; ++i) {
				ppu.nt_map[i] = 4u;
				ppu.nt_chr_page[i] = mapper.vrc6_chr_nt_page(i);
			}
			ppu.nt_map_on = true;
			ppu.split_exram = nullptr;
			ppu.ext_attr_mode = false;
			ppu.ext_attr_ram = nullptr;
		} else {
			ppu.nt_map_on = false;
			ppu.split_exram = nullptr;
			ppu.ext_attr_mode = false;
			ppu.ext_attr_ram = nullptr;
		}
		ppu.status = static_cast<eng::u8>(ppu.status & ~0x80u);
		ppu.nmi_occurred = false;
		// LÍMITE (ver docs/RISKS.md): el frame se cierra en la **frontera de instrucción**
		// que cae justo después de volver a la pre-VBlank, así que su largo es un entero
		// (~29782) y no el real 29780.67 (media NTSC; los frames impares cuentan 340 dots
		// en la pre-render, ver `Ppu::tick_dot`). Esa deriva de ~1.3 ciclos/frame no se
		// puede fijar sin una frontera **sub-instrucción** (lockstep PPU/CPU ciclo a ciclo).
		bool seen_vblank = false;
		int guard = 0;
		for (;;) {
			int n = 0;
			step_block(&n);
			guard += (n > 0) ? n : 1;
			if (ppu.scanline == 241u) {
				seen_vblank = true;
			}
			if (seen_vblank && ppu.scanline == 240u) {
				break; // frame completo: la PPU volvió a la pre-VBlank
			}
			if (guard > 120000) {
				break; // salvaguarda anti-cuelgue
			}
		}
		ppu.render_frame();
	}

	/// Copia el framebuffer a RGB de 8 bits (`ancho*alto*3` bytes).
	/// \param out Búfer destino de tamaño al menos `kScreenW*kScreenH*3`.
	void frame_rgb(eng::Span<eng::u8> out) const {
		for (int i = 0; i < kScreenW * kScreenH; ++i) {
			const eng::u8 c = ppu.fb[i];
			eng::u8 r;
			eng::u8 g;
			eng::u8 b;
			if (ppu.ext_palette != nullptr) {
				// Paleta extendida de un pack (0x0RGB): 4 bits por canal × 17.
				const eng::u16 v = ppu.ext_palette[c];
				r = static_cast<eng::u8>(((v >> 8u) & 0x0Fu) * 17u);
				g = static_cast<eng::u8>(((v >> 4u) & 0x0Fu) * 17u);
				b = static_cast<eng::u8>((v & 0x0Fu) * 17u);
			} else {
				const eng::u8 cc = static_cast<eng::u8>(c & 0x3Fu);
				r = kPaletteRgb[cc][0];
				g = kPaletteRgb[cc][1];
				b = kPaletteRgb[cc][2];
			}
			out[static_cast<eng::usize>(i) * 3u + 0u] = r;
			out[static_cast<eng::usize>(i) * 3u + 1u] = g;
			out[static_cast<eng::usize>(i) * 3u + 2u] = b;
		}
	}

private:
	/// Lector de memoria del **DMC**: lee el byte de `a` (PRG) para el canal DMC.
	/// Sin esto el DMC leía silencio y faltaban los samples.
	static eng::u8 apu_read_cb(void* u, eng::u16 a) {
		return static_cast<NesSystem*>(u)->mem.read(a);
	}

	static eng::u8 io_read_cb(void* u, eng::u16 a) {
		return static_cast<NesSystem*>(u)->io_read(a);
	}
	static void io_write_cb(void* u, eng::u16 a, eng::u8 v) {
		static_cast<NesSystem*>(u)->io_write(a, v);
	}

	/// Hook de reloj de bus: avanza la PPU `n` ciclos (3 dots cada uno).
	static void cycle_tick_cb(void* u, int n) { static_cast<NesSystem*>(u)->clock_ppu(n); }

	/// Lee `$2000-$FFFF` (PPU espejada, APU, mandos, cartucho).
	eng::u8 io_read(eng::u16 a) {
		if (a < 0x4000u) {
			return ppu.read_reg(static_cast<eng::u16>(a & 0x07u));
		}
		if (a == 0x4015u) {
			return apu.read_status();
		}
		if (a == 0x4016u) {
			const eng::u8 b = static_cast<eng::u8>(shift1 & 1u);
			if (!strobe) shift1 = static_cast<eng::u8>(shift1 >> 1u);
			return static_cast<eng::u8>(b | 0x40u);
		}
		if (a == 0x4017u) {
			const eng::u8 b = static_cast<eng::u8>(shift2 & 1u);
			if (!strobe) shift2 = static_cast<eng::u8>(shift2 >> 1u);
			return static_cast<eng::u8>(b | 0x40u);
		}
		if (mapper.kind == MapperKind::Mmc5 && a >= 0x5204u && a <= 0x5206u) {
			// Registros de la MMC5: $5204 (in-frame + IRQ pendiente, se limpia al leer),
			// $5205/$5206 (multiplicador, bajo/alto).
			if (a == 0x5204u) {
				const eng::u8 v = static_cast<eng::u8>(
					(mapper.mmc5_in_frame ? 0x40u : 0u) |
					(mapper.mmc5_irq_pending ? 0x80u : 0u));
				mapper.mmc5_irq_pending = false;
				return v;
			}
			const eng::u8 p = static_cast<eng::u8>(mapper.mmc5_mult1 * mapper.mmc5_mult2);
			return (a == 0x5205u) ? p
					      : static_cast<eng::u8>((mapper.mmc5_mult1 *
								      mapper.mmc5_mult2) >> 8);
		}
		if (a >= 0x5C00u && a < 0x6000u && mapper.kind == MapperKind::Mmc5) {
			return mapper.mmc5_exram[(a - 0x5C00u) & 0x3FFu]; // ExRAM de la MMC5
		}
		if (a >= 0x6000u && a < 0x8000u && mapper_ram_at_6000()) {
			if (mapper.kind == MapperKind::Mmc1 && !mapper.mmc1_wram_enabled) {
				return 0u;
			}
			return mem.prg_ram[a - 0x6000u];
		}
		if (a >= 0x4020u) {
			return mapper.cpu_read(a);
		}
		return 0u;
	}

	/// ¿`$6000-$7FFF` es RAM del mapper (MMC3/MMC1/MMC5, o FME-7 con `$A000 cmd 8`
	/// bit 6)? Si no, el mapper lo mapea como PRG-ROM (FME-7) o no existe.
	[[nodiscard]] bool mapper_ram_at_6000() const noexcept {
		switch (mapper.kind) {
		case MapperKind::Mmc1:
		case MapperKind::Mmc3:
		case MapperKind::Mmc5:
			return true;
		case MapperKind::Fme7:
			return (mapper.fme7_workram & 0x40u) != 0u;
		default:
			return false;
		}
	}

	/// Escribe `$2000-$FFFF` (PPU/HLE, OAM DMA, APU, mandos, mapper).
	void io_write(eng::u16 a, eng::u8 v) {
		if (a < 0x4000u) {
			hle.write_ppu(a, v);
			return;
		}
		if (a == 0x4014u) {  // OAM DMA
			hle.oam_dma(v);
			const eng::u16 base = static_cast<eng::u16>(static_cast<eng::u16>(v) << 8u);
			for (int i = 0; i < 256; ++i) {
				ppu.oam[i] = mem.read(static_cast<eng::u16>(base + static_cast<eng::u16>(i)));
			}
			return;
		}
		if (a == 0x4016u) {
			strobe = (v & 1u) != 0u;
			if (strobe) {
				shift1 = pad1;
				shift2 = pad2;
			}
			return;
		}
		if (a >= 0x4000u && a <= 0x4017u) {
			apu.write_reg(a, v);
			return;
		}
		if (a >= 0x6000u && a < 0x8000u && mapper_ram_at_6000()) {
			if (mapper.kind != MapperKind::Mmc1 || mapper.mmc1_wram_enabled) {
				mem.prg_ram[a - 0x6000u] = v;
			}
			return;
		}
		if (a >= 0x4020u) {
			// Contador **global** `cpu.cycles` (lo llevan el intérprete y los
			// bloques): el filtro de 2 ciclos del MMC1 debe usar el mismo reloj en
			// ambos caminos. Con `interp.cycles` el codegen no avanzaba y el MMC1
			// **descartaba escrituras** de registro.
			mapper.cpu_cycle = cpu.cycles;
			mapper.cur_scan = ppu.scanline;
			mapper.cpu_write(a, v);
			// MMC5: `$5105` cambia el **mapeo de nametables** en runtime. Si el juego
			// cambia `$5105` y escribe la nametable en el MISMO frame, hay que
			// aplicarlo ya (antes se fijaba solo en `run_frame`, un frame tarde).
			if (mapper.kind == MapperKind::Mmc5) {
				if (a == 0x5105u) {
					for (int i = 0; i < 4; ++i) {
						ppu.nt_map[i] = static_cast<eng::u8>(
							(mapper.mmc5_nametable >> (i * 2)) & 0x03u);
					}
				} else if (a == 0x5104u) {
					ppu.ext_attr_mode = (mapper.mmc5_exram_mode == 1u);
				} else if (a == 0x5130u) {
					ppu.ext_attr_upper = mapper.mmc5_chr_upper;
				}
			}
			// Conmutación de bancos de PRG ($8000-$FFFF): invalida la decodificación
			// del ejecutor rápido (si lo hay) para que se rehaga a través del mapper
			// y actualiza el espejo `mem.prg_bank` que usa el despacho por banco del
			// código transpilado (F9/B1b).
			if (a >= 0x8000u) {
				if (mapper.kind == MapperKind::Uxrom) {
					mem.prg_bank = mapper.prg_bank;
				} else if (mapper.kind == MapperKind::Mmc3) {
					// Modo 0: $8000-R6/R7; el bit de modo (R0 bit6) las intercambia
					// → invalida el modelo con el sentinel 0xFF (fallback).
					const eng::u32 n8 = mapper.prg_size / 0x2000u;
					if (mapper.mmc3_prg_mode == 0u) {
						mem.prg_bank = static_cast<eng::u8>(mapper.mmc3_regs[6] %
										  (n8 ? n8 : 1u));
						mem.prg_bank2 = static_cast<eng::u8>(mapper.mmc3_regs[7] %
										   (n8 ? n8 : 1u));
					} else {
						mem.prg_bank = static_cast<eng::u8>(0xFFu);
					}
				} else if (mapper.kind == MapperKind::Fme7) {
					// FME-7: 3 ventanas de 8 KB ($8000/$A000/$C000).
					mem.prg_bank = mapper.fme7_prg[0];
					mem.prg_bank2 = mapper.fme7_prg[1];
					mem.prg_bank3 = mapper.fme7_prg[2];
				} else if (mapper.kind == MapperKind::Mmc5) {
					// Modo 3 (por defecto): 4 ventanas de 8 KB ($8000/$A000/$C000/$E000).
					// Otros modos → sentinel (fallback).
					if (mapper.mmc5_prg_mode == 3u) {
						mem.prg_bank = mapper.mmc5_prg_banks[1];
						mem.prg_bank2 = mapper.mmc5_prg_banks[2];
						mem.prg_bank3 = mapper.mmc5_prg_banks[3];
						mem.prg_bank4 = static_cast<eng::u8>(mapper.mmc5_prg_banks[4] & 0x7Fu);
					} else {
						mem.prg_bank = static_cast<eng::u8>(0xFFu);
					}
				} else if (mapper.kind == MapperKind::Vrc6) {
					// VRC6: banco de 16 KB ($8000-$BFFF) y de 8 KB ($C000-$DFFF).
					mem.prg_bank = static_cast<eng::u8>(mapper.vrc6_prg0 & 0x0Fu);
					mem.prg_bank2 = static_cast<eng::u8>(mapper.vrc6_prg1 & 0x1Fu);
				} else if (mapper.kind == MapperKind::Mmc1) {
					// Solo el modo 16K con banco conmutable en $8000 coincide con
					// el modelo del transpilado; en cualquier otro modo se invalida
					// con el sentinel 0xFF (el plugin cae al intérprete).
					const bool mode16 = (mapper.mmc1_ctrl & 0x08u) != 0u;
					const bool slot8000 = (mapper.mmc1_ctrl & 0x04u) != 0u;
					mem.prg_bank = (mode16 && slot8000)
							       ? static_cast<eng::u8>(mapper.mmc1_prg & 0x0Fu)
							       : static_cast<eng::u8>(0xFFu);
				}
				if (fast_invalidate != nullptr) {
					fast_invalidate(fast_ctx);
				}
			}
			return;
		}
	}

	/// Máximo de ciclos de CPU que caben antes de cruzar la frontera de scanline
	/// (341 dots, 3 por ciclo). `ppu.dot` está en `[0, 340]`; devolver 0 fuerza
	/// que el siguiente bloque ejecute una sola instrucción (puede cruzar).
	/// \return Ciclos hasta el próximo límite de scanline.
	[[nodiscard]] int cycles_to_scanline() const {
		const int b = (340 - static_cast<int>(ppu.dot)) / 3;
		return b < 0 ? 0 : b;
	}

	/// Máximo de ciclos de CPU antes del **próximo evento observable** del PPU
	/// (VBlank, pre-render, sprite-0, fin de frame; ver `Ppu::next_event_dots`).
	/// Sustituye a `cycles_to_scanline()` como presupuesto del ejecutor rápido:
	/// así el bloque termina en la frontera del evento (o antes), se resuelve el
	/// NMI/IRQ y la PPU no se adelanta a los eventos. `0` fuerza una sola
	/// instrucción (evento a <1 ciclo), como en `cycles_to_scanline`.
	/// \return Ciclos hasta el próximo evento (>= 0).
	[[nodiscard]] int cycles_to_next_event() const {
		// **Techo**: el bloque debe cortar **en o justo después** del evento, no
		// antes (con `floor` el bloque se quedaba una instrucción corto y el
		// siguiente cruzaba la frontera de frame → deriva).
		const eng::u32 dots = ppu.next_event_dots();
		return static_cast<int>((dots + 2u) / 3u);
	}

	/// Avanza la PPU `cpu_cycles*3` dots (341 dots por línea). Al cambiar de
	/// línea, **captura el scroll actual** para esa línea: así las escrituras a
	/// `$2005` a mitad de frame (splits) afectan solo desde ese punto (scroll
	/// mid-frame real, no el global de fin de frame).
	void clock_ppu(int cpu_cycles) {
		mapper.clock(cpu_cycles); // IRQ de VRC6/FME-7 (por ciclos de CPU)
		// Fase 1 del timing (docs/TIMING_ROADMAP.md): avance de la PPU **dot a dot**
		// (como mesen `PPU::Exec`). Resuelve sprite-0, el flag de VBlank y los cruces de
		// línea en su **dot exacto**; el reloj A12 de la MMC3 se dispara en su dot. El
		// render sigue siendo *lazy* (al final del frame).
		const int dots = cpu_cycles * 3;
		for (int i = 0; i < dots; ++i) {
			const eng::u16 before = ppu.scanline;
			ppu.tick_dot();
			if (ppu.scanline != before) {
				ppu.set_line_scroll(static_cast<int>(ppu.scanline), ppu.scroll_x, ppu.scroll_y);
				if (ppu.scanline == 261u) {
					mapper.reset_mmc5_frame(); // MMC5: reinicia el contador de scanlines
				} else if (ppu.scanline < 240u) {
					mapper.mmc5_on_scanline();
				}
			}
			// MMC3: contador IRQ en el flanco de A12 (fetch de sprites, dot `kA12Dot`).
			if (mapper.kind == MapperKind::Mmc3 && ppu.dot == kA12Dot && ppu.scanline < 240u) {
				const bool spr_on = (ppu.mask & 0x10u) != 0u;
				const bool bg_on = (ppu.mask & 0x08u) != 0u;
				const bool bg_hi = (ppu.ctrl & 0x10u) != 0u;
				if (spr_on || (bg_on && bg_hi)) {
					mapper.on_scanline(ppu.scanline);
				}
			}
		}
	}

	/// Toma una NMI: apila PC y estado y salta al vector `$FFFA`.
	void trigger_nmi() {
		++nmi_count;
		eng::u8 p = 0x20u;
		if (cpu.N) p = static_cast<eng::u8>(p | 0x80u);
		if (cpu.V) p = static_cast<eng::u8>(p | 0x40u);
		if (cpu.D) p = static_cast<eng::u8>(p | 0x08u);
		if (cpu.I) p = static_cast<eng::u8>(p | 0x04u);
		if (cpu.Z) p = static_cast<eng::u8>(p | 0x02u);
		if (cpu.C) p = static_cast<eng::u8>(p | 0x01u);
		cpu.push16(cpu.PC);
		cpu.push(p);
		cpu.I = true;
		cpu.PC = mem.read16(0xFFFAu);
	}

	/// Toma una **IRQ**: apila PC y estado y salta al vector `$FFFE`. La usa el
	/// frame counter del APU (y el DMC). El flag `I` la enmascara.
	void trigger_irq() {
		eng::u8 p = 0x20u;
		if (cpu.N) p = static_cast<eng::u8>(p | 0x80u);
		if (cpu.V) p = static_cast<eng::u8>(p | 0x40u);
		if (cpu.D) p = static_cast<eng::u8>(p | 0x08u);
		if (cpu.I) p = static_cast<eng::u8>(p | 0x04u);
		if (cpu.Z) p = static_cast<eng::u8>(p | 0x02u);
		if (cpu.C) p = static_cast<eng::u8>(p | 0x01u);
		cpu.push16(cpu.PC);
		cpu.push(p);
		cpu.I = true;
		cpu.PC = mem.read16(0xFFFEu);
	}
};

} // namespace n2a
