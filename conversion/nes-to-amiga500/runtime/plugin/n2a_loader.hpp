#pragma once

/// \file n2a_loader.hpp
/// **Loader de plugins `.n2x`** (host/gestor). Carga el binario con
/// `dlopen`/`LoadLibrary`, resuelve la ABI de `n2a_plugin.h`, comprueba versión y
/// arquitectura, y expone la ROM (PRG/CHR/mapper) y la ejecución por bloques.
///
/// El plugin **no** trae intérprete/PPU/APU: el gestor ejecuta los bloques y, si
/// el plugin no cubre una dirección (RAM/salto calculado), usa su propio motor
/// rápido/intérprete. El hook `fast_run` de `NesSystem` se enlaza a `fast_run`.
///
/// Solo host (usa carga dinámica del sistema).

#include <eng/core/types/types.hpp>

#include "../include/nes_mapper.hpp"
#include "../include/nes_runtime.hpp"
#include "../include/nes_system.hpp"
#include "n2a_plugin.h"

#if defined(_WIN32)
#include <windows.h>
#else
#include <dlfcn.h>
#endif

namespace n2a {

/// Arquitectura del host actual (`N2A_ARCH_*`), para validar el plugin.
[[nodiscard]] inline int n2a_host_arch() noexcept {
#if defined(__wasm__)
	return N2A_ARCH_WASM;
#elif defined(__m68k__)
	return N2A_ARCH_M68K;
#elif defined(_WIN32)
	return N2A_ARCH_X64_NT;
#else
	return N2A_ARCH_X64_LINUX;
#endif
}

/// Plugin transpilado cargado en memoria. No copia la ROM: apunta a la del plugin.
struct TranspiledGame {
	void* handle = nullptr;                        ///< Handle de dlopen/LoadLibrary.
	int (*fn_version)() = nullptr;                 ///< `n2a_abi_version`.
	int (*fn_arch)() = nullptr;                    ///< `n2a_abi_arch`.
	void (*fn_init)() = nullptr;                   ///< `n2a_init`.
	const unsigned char* (*fn_prg)() = nullptr;    ///< `n2a_prg`.
	unsigned (*fn_prg_size)() = nullptr;           ///< `n2a_prg_size`.
	const unsigned char* (*fn_chr)() = nullptr;    ///< `n2a_chr`.
	unsigned (*fn_chr_size)() = nullptr;           ///< `n2a_chr_size`.
	int (*fn_mapper)() = nullptr;                  ///< `n2a_mapper`.
	int (*fn_block)(void*, void*, int*) = nullptr; ///< `n2a_block`.

	/// ¿Hay un plugin cargado y compatible?
	[[nodiscard]] bool valid() const noexcept { return handle != nullptr; }

	/// Carga y valida `path` (versión y arquitectura de la ABI).
	/// \param path Ruta del `.n2x`.
	/// \return `true` si se cargó y es compatible.
	bool load(const char* path) {
		unload();
#if defined(_WIN32)
		handle = static_cast<void*>(LoadLibraryA(path));
		if (handle == nullptr) {
			return false;
		}
		auto sym = [&](const char* n) { return reinterpret_cast<void*>(GetProcAddress(static_cast<HMODULE>(handle), n)); };
#else
		handle = dlopen(path, RTLD_NOW | RTLD_LOCAL);
		if (handle == nullptr) {
			return false;
		}
		auto sym = [&](const char* n) { return dlsym(handle, n); };
#endif
		fn_version = reinterpret_cast<int (*)()>(sym("n2a_abi_version"));
		fn_arch = reinterpret_cast<int (*)()>(sym("n2a_abi_arch"));
		fn_init = reinterpret_cast<void (*)()>(sym("n2a_init"));
		fn_prg = reinterpret_cast<const unsigned char* (*)()>(sym("n2a_prg"));
		fn_prg_size = reinterpret_cast<unsigned (*)()>(sym("n2a_prg_size"));
		fn_chr = reinterpret_cast<const unsigned char* (*)()>(sym("n2a_chr"));
		fn_chr_size = reinterpret_cast<unsigned (*)()>(sym("n2a_chr_size"));
		fn_mapper = reinterpret_cast<int (*)()>(sym("n2a_mapper"));
		fn_block = reinterpret_cast<int (*)(void*, void*, int*)>(sym("n2a_block"));
		if (fn_version == nullptr || fn_arch == nullptr || fn_init == nullptr ||
		    fn_prg == nullptr || fn_prg_size == nullptr || fn_chr == nullptr ||
		    fn_chr_size == nullptr || fn_mapper == nullptr || fn_block == nullptr) {
			unload();
			return false;
		}
		if (fn_version() != N2A_ABI_VERSION || fn_arch() != n2a_host_arch()) {
			unload(); // binario de otra versión/arquitectura
			return false;
		}
		fn_init();
		return true;
	}

	/// Descarga el plugin.
	void unload() {
		if (handle != nullptr) {
#if defined(_WIN32)
			FreeLibrary(static_cast<HMODULE>(handle));
#else
			dlclose(handle);
#endif
		}
		handle = nullptr;
		fn_version = nullptr; fn_arch = nullptr; fn_init = nullptr;
		fn_prg = nullptr; fn_prg_size = nullptr; fn_chr = nullptr; fn_chr_size = nullptr;
		fn_mapper = nullptr; fn_block = nullptr;
	}

	/// Rellena `m` con el cartucho del plugin (mapper, PRG y CHR).
	/// \param m Mapper de destino.
	void fill_mapper(Mapper& m) const {
		switch (fn_mapper()) {
		case 2: m.kind = MapperKind::Uxrom; break;
		case 3: m.kind = MapperKind::Cnrom; break;
		case 1: m.kind = MapperKind::Mmc1; break;
		default: m.kind = MapperKind::Nrom; break;
		}
		m.prg = fn_prg();
		m.prg_size = fn_prg_size();
		m.chr = fn_chr();
		m.chr_size = fn_chr_size();
	}

	/// Ejecuta el bloque de `cpu.PC`. \return Ciclos, o 0 si no hay bloque.
	int run_block(CPU& cpu, NESMemory& mem, int* instrs) {
		return fn_block(&cpu, &mem, instrs);
	}

	/// Hook compatible con `NesSystem::FastRun` (usa `fast_ctx = TranspiledGame*`).
	static int fast_run(void* ctx, CPU& cpu, NESMemory& mem, int /*budget*/, int* instrs) {
		return static_cast<TranspiledGame*>(ctx)->run_block(cpu, mem, instrs);
	}
};

} // namespace n2a
