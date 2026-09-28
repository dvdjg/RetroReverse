#pragma once

/// \file n2a_plugin.h
/// **ABI C** del plugin de juego transpilado (`.n2x`). El gestor (host SDL3) lo
/// carga con `dlopen`/`LoadLibrary`. El plugin **no** lleva el intérprete, la PPU,
/// la APU ni el mapper: solo el **código generado** y la **ROM** (PRG+CHR+mapper).
/// El host ejecuta los bloques y, cuando el plugin no cubre una dirección
/// (RAM/salto calculado), usa su propio motor rápido/intérprete — así el
/// intérprete vive en el gestor, una sola vez para todos los plugins.
///
/// Versionado: el gestor compara `n2a_abi_version()` y `n2a_abi_arch()` con los
/// suyos y **rechaza** el plugin si no coinciden (no se cargan binarios con un
/// layout de `CPU`/`NESMemory` distinto).

#if defined(_WIN32)
#define N2A_EXPORT __declspec(dllexport)
#else
#define N2A_EXPORT __attribute__((visibility("default")))
#endif

/// Versión de la ABI (subir al cambiar el layout de `CPU`/`NESMemory` o la firma).
/// v2: `NESMemory` gana `prg_bank` (despacho por banco, F9/B1b).
#define N2A_ABI_VERSION 2

/// Arquitecturas que identifica el plugin (el gestor solo carga la suya).
#define N2A_ARCH_X64_NT 1    ///< Windows x86-64 (MinGW/MSVC).
#define N2A_ARCH_X64_LINUX 2 ///< Linux x86-64.
#define N2A_ARCH_M68K 3      ///< Amiga 68000 (A500/A1200...).
#define N2A_ARCH_WASM 4      ///< WebAssembly (navegador/Emscripten).

#ifdef __cplusplus
extern "C" {
#endif

/// \return Versión de la ABI del plugin.
N2A_EXPORT int n2a_abi_version(void);
/// \return Arquitectura del binario (`N2A_ARCH_*`).
N2A_EXPORT int n2a_abi_arch(void);

/// Inicializa la tabla de despacho del código generado (una vez tras cargar).
N2A_EXPORT void n2a_init(void);

// --- Cartucho autocontenido (la ROM va dentro del plugin) ---
N2A_EXPORT const unsigned char* n2a_prg(void); ///< PRG-ROM embebida.
N2A_EXPORT unsigned n2a_prg_size(void);        ///< Tamaño de la PRG en bytes.
N2A_EXPORT const unsigned char* n2a_chr(void); ///< CHR-ROM embebida (puede ser de 1 byte).
N2A_EXPORT unsigned n2a_chr_size(void);        ///< Tamaño de la CHR (0 = CHR RAM).
N2A_EXPORT int n2a_mapper(void);               ///< Número de mapper iNES.
N2A_EXPORT int n2a_mirroring(void);            ///< Mirroring: 0 = horizontal, 1 = vertical.

/// Ejecuta el *basic block* en `((n2a::CPU*)cpu)->PC`.
/// \param cpu Puntero al `n2a::CPU` del host (mismo layout; ver `N2A_ABI_VERSION`).
/// \param mem Puntero al `n2a::NESMemory` del host (no usado por el bloque, que
///            accede vía `cpu.mem`; se pasa por completitud/robustez de la ABI).
/// \param instrs Nº de instrucciones ejecutadas (salida; puede ser `nullptr`).
/// \return Ciclos del bloque, o 0 si no hay bloque (el host lo resuelve).
N2A_EXPORT int n2a_block(void* cpu, void* mem, int* instrs);

#ifdef __cplusplus
}
#endif
