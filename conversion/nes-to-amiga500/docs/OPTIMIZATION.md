# Optimización dirigida por dominios de valores

Cómo sacar partido del optimizador (g++ 15.x / clang / MSVC y, sobre todo, del **cross-compiler
m68k**): en vez de portar el algoritmo del juego "tal cual", se **extraen hechos** sobre los valores
que circulan por RAM, ROM y puertos, y se le dan al compilador para que genere código mucho más
rápido. Complementa a [`TRANSPILER.md`](TRANSPILER.md) y [`HLE.md`](HLE.md).

## Principio

Todo código generado tiene **dos capas**:

1. **Genérica** (siempre correcta): replica la semántica 6502 exacta. Es el *oráculo*.
2. **Especializada** (rápida): versión clonada que asume un **hecho** sobre los valores. Se entra a
   ella solo si una **guarda** barata confirma el hecho; si no, se ejecuta la genérica.

```
              ┌───────────────────────────────┐
   entrada ─► │ guarda (barata, runtime)       │
              └───────┬───────────────┬────────┘
                cumple│               │no cumple
                      ▼               ▼
              ┌───────────────┐  ┌───────────────┐
              │ versión rápida│  │ versión genérica│
              │ (asume hecho) │  │ (correcta)      │
              └───────────────┘  └───────────────┘
```

Los hechos provienen de: **análisis estático** (interpretación abstracta sobre el IR), **telemetría**
(ejecución instrumentada en host) o **conocimiento del hardware** (p. ej. `PPUSTATUS` sólo tiene 8
bits). Cada hecho lleva **confianza** y, si no es demostrable, **guarda de validez** (nunca romper la
corrección).

## Dominios abstractos (el "lattice" de hechos)

| Dominio | Ejemplo | Valor para el optimizador |
|---|---|---|
| constante | `$10 == 2` siempre | plegado total |
| conjunto finito | `$10 ∈ {0,1,2,4}` | `switch`/tabla/clonado |
| rango | `0 ≤ $10 ≤ 15` | tipos estrechos, quitar ramas, no desborda |
| congruencia | `$10 ≡ 0 (mod 8)` | máscaras, alineación |
| bits conocidos | `$10 & 0x80 == 0x80` | elimina comparaciones |
| potencia de 2 | `$10 ∈ {1,2,4,8,…}` | división→shift, `ctz` |
| stride / afín | `idx = 2*i + 1` | fuerza tablas indexadas |
| no-cero / signo | `$10 != 0` | elimina comprobaciones |
| frecuencia | `$10 == 0` el 96 % de frames | rama caliente + memo |

Combinables (p. ej. rango + congruencia + bits conocidos). Se almacenan por **dirección de memoria**
(zero page, RAM, registros mapeados) y por **registro** (A/X/Y), con validez por **punto de programa**
o por **bloque**.

## Cómo se expresan a un compilador C++

Macros portables (GCC/Clang/MSVC):

```cpp
#if defined(__clang__)
#  define ASSUME(x)  __builtin_assume(x)
#elif defined(__GNUC__) && __cplusplus >= 202302L
#  define ASSUME(x)  [[assume(x)]]           // C++23 (GCC 13+/Clang 19+)
#elif defined(_MSC_VER)
#  define ASSUME(x)  __assume(x)
#else
#  define ASSUME(x)  ((void)0)
#endif
```

Y las tres formas de explotar un hecho:

```cpp
// 1. Conjunto finito → switch especializado
ASSUME(v <= 3);
switch (v) { case 0: ...; case 1: ...; case 2: ...; case 3: ...; default: __builtin_unreachable(); }

// 2. Rango/congruencia → el compilador estrecha y simplifica
ASSUME(idx < 256);
ASSUME((base & 7) == 0);
out = table[base + idx];

// 3. Clonado con guarda (hechos no demostrables: telemetría)
if (__builtin_expect(zp[0x10] < 4u, 1)) bb_fast(cpu);   // asume {0,1,2,3}
else                                     bb_generic(cpu);
```

### El truco más potente: `IPA-CP` y constantes como argumentos

Si el transpilador pasa las **lecturas de memoria calientes como parámetros** de las funciones de
bloque, GCC aplica *interprocedural constant propagation* (clonado por argumento constante) sin que
nosotros escribamos la especialización:

```cpp
static void bb_E000(CPU& cpu, uint8_t v10, uint8_t v20);   // v10, v20 = zp[$10], zp[$20]
// Llamada caliente con constantes conocidas → GCC clona y pliega:
bb_E000(cpu, 2, 0);
```

Esto convierte RAM/registros en **registros 68000** (asignación a través de bloques) y elimina
lecturas repetidas. Es, probablemente, la mayor ganancia posible en 68000.

## Los tres escenarios concretos

### 1. Una lectura solo toma un conjunto pequeño de valores

- **Qué sabemos**: `zp[$10] ∈ {0,1,2,4}` (estático o ≥99 % de las trazas).
- **Qué emitimos**: `ASSUME(v<=4)` + `switch` sobre los 4 casos, o **tabla precalculada**
  `constexpr` indexada por el valor, o **clonado** de la continuación.
- **Ganancia**: ramas eliminadas, aritmética con operandos constantes, resultados parcial o
  totalmente precalculados. Si además el valor multiplica/divide, se generan las 4 variantes
  constantes.

### 2. Una lectura siempre es potencia de 2

- **Qué sabemos**: `v & (v-1) == 0`, `v != 0`.
- **División**: `a / v` no tiene por qué seguir un patrón general; se especializa
  `shift = LOG2[v]` (tabla de 256 bytes) y `a >> shift`; o `switch (v)` con `>> 0,1,2,3,4…`.
- **Multiplicación/índices**: `v` como máscara se convierte en `& (v-1)` o filtro de bits.
- **Por qué importa**: en 68000 `DIVU/DIVS` cuesta ~140 ciclos; un `LSR` variable ~6-10. La diferencia
  es abismal en bucles calientes.

### 3. Variables que casi siempre valen lo mismo

- **Qué sabemos**: distribución de frecuencias (telemetría).
- **Qué emitimos**: rama caliente `[[likely]]`/`__builtin_expect` + **resultado memoizado** para el
  valor común; el camino raro cae a la versión genérica.
- **Extra**: *hot/cold splitting* (`-freorder-blocks-and-partition`) para que el caso raro no ocupe
  el camino de instrucciones del bucle.

### 4. Recuperar el algoritmo y sustituirlo (sin replicarlo)

En vez de transcribir el cómo, se identifica el **qué** y se sustituye por una versión exacta más
rápida para el dominio observado:

| Idioma detectado | Sustitución | Validación |
|---|---|---|
| multiplicación por constante (bucles de suma) | `lsl`/`add` encadenados (g++ ya lo hace) | exhaustiva |
| división/módulo por constante | recíproco + `mulhi` o tabla | exhaustiva en el rango |
| división general (restoring/non-restoring) | tabla de recíprocos si el divisor ∈ dominio | exhaustiva del dominio |
| raíz cuadrada entera | tabla / aproximación + corrección | exhaustiva |
| seno/coseno/tabla de ROM | `constexpr` en `.rodata` | comparar con ROM |
| LCG/PRNG y tablas derivadas | precomputar la secuencia | comparar N valores |
| conversión binario↔decimal, `itoa` | tabla de potencias / par de dígitos | comparar cadenas |

Regla **inequívoca**: la sustitución solo se acepta si es **equivalente en el dominio** (prueba
exhaustiva si es pequeño, simbólica si es lineal, o *differential testing* masivo). Los **bugs
visibles** del original se reproducen, no se "arreglan".

## Específico del 68000 / Amiga

- **Memoria es el cuello de botella**, no la ALU: reducir *loads/stores* (promover zero-page a
  registros) suele ganar más que reducir operaciones.
- **Sin caché en 68000**: instrucciones más cortas y bucles ajustados ganan; el *unrolling* puede
  empeorar el fetch → medir (`-Os` vs `-O2`).
- **Tipos estrechos**: `-mshort` (int de 16 bits en m68k), `uint8_t`/`uint16_t`, `-fshort-enums`.
- **Direccionamiento**: `-mpcrel` (PC-relativo, código más compacto) cuando el binario lo permita.
- **Baseline**: `-m68000 -msoft-float -ffreestanding -fno-exceptions -fno-rtti -fno-threadsafe-statics
  -fno-stack-protector -fno-common -fomit-frame-pointer -flto`.
- **Duplicar código por banco**: con mappers, tratar cada banco como ROM `const` separada permite
  plegar lecturas dentro del banco (rompe la constancia el *bank switching* global).
- **Chip vs Fast RAM**: los buffers DMA van en Chip; código/pila a Fast si existe (A500 con
  expansión). En A500 stock todo compite con el bus de DMA → menos ciclos de CPU y de Blitter.

## PGO y telemetría

- **PGO cruzado**: instrumentar la compilación **host** del mismo fuente/versión de GCC
  (`-fprofile-generate`), ejecutar el *vertical slice* y usar el perfil con el cross-compiler
  (`-fprofile-use`). Da probabilidades de rama y *value profiling* gratis.
- **Hechos propios (sidecar)**: cuando el cross-PGO no sea fiable, el análisis emite un JSON de
  hechos y el transpilador genera guardas + `ASSUME` + clonado. Formato propuesto:

```json
{
  "facts": [
    { "kind": "set",       "addr": "0x10", "values": [0,1,2,4], "source": "static", "confidence": 1.00 },
    { "kind": "power_of_2","addr": "0x22", "domain": [1,2,4,8], "source": "trace",  "confidence": 0.997 },
    { "kind": "freq",      "addr": "0x30", "mode": 0, "p": 0.96,     "source": "trace",  "confidence": 0.99 },
    { "kind": "known_bits","addr": "0x41", "mask": 128, "eq": 128,   "source": "static", "confidence": 1.00 }
  ]
}
```

- **Gestor de suposiciones**: en runtime, la guarda puede ser explícita y auditable; si un hecho deja
  de cumplirse, se cae a la genérica y se puede **invalidar el hecho** para no pagar la guarda en
  frames siguientes (auto-desactivación).

## Memoización por estado

- Si un bloque depende solo de un número pequeño de entradas, precomputar una **tabla de resultados**
  (`constexpr` o generada al cargar) y sustituir el cálculo por un índice.
- En bucles de render/scroll, cachear el resultado mientras las entradas no cambien (dirty flags):
  el HLE ya lo hace para tiles; se puede aplicar a cálculo puro.

## Riesgos y control

| Riesgo | Control |
|---|---|
| Suposición falsa rompe el juego | guarda + fallback; validación diferencial ([`VALIDATION.md`](VALIDATION.md)) |
| Crecimiento de código (I-fetch) | medir tamaño; clonar solo bloques calientes; *cold split* |
| Coste de la guarda > ganancia | umbral por bloque; el perfil decide |
| Automodificación invalida hechos | hechos ligados a regiones; re-análisis tras escrituras raras |
| Derivar a "port mirando el asm" | los hechos son **datos**, no copia de código; sustitución validada |

## Encaje en el roadmap

- **[`TRANSPILER.md`](TRANSPILER.md) F2**: emitir `ASSUME`, clonado y paso de zero-page como
  parámetros desde el principio (barato de añadir al codegen).
- **F8 (HLE)**: los mismos hechos alimentan los *handlers* y el reconocimiento de algoritmos.
- **F10**: catálogo de hechos por juego (`facts.json`), PGO y superoptimización de secuencias 68000.

## Estado de implementación

- **`N2A_ASSUME`** (macro portable) en
  [`../runtime/include/nes_runtime.hpp`](../runtime/include/nes_runtime.hpp).
- **Transpilador**: opción `--facts <fichero>` que emite `N2A_ASSUME` al inicio de los bloques que
  leen direcciones con hechos (`eq`/`range`/`set`/`power2`). Los hechos los aporta el análisis o la
  telemetría (ver [`../tools/transpiler/README.md`](../tools/transpiler/README.md)).
- **Telemetría**: [`../runtime/tools/facts_from_run.cpp`](../runtime/tools/facts_from_run.cpp)
  ejecuta la ROM con el intérprete y escribe un fichero de hechos (`set`/`range`) consumible por
  `--facts`.
- **VSA estática (intra-bloque)**: el codegen propaga `LDA #c; STA a` y emite `N2A_ASSUME` al leer
  `a` **sin** fichero de hechos (caso `--emit-vsa-rom`).
- **Pendiente**: interpretación abstracta de valores sobre el IR, clonado con guarda (fast path +
  genérico), PGO cruzado y extracción dirigida por trazas de qué direcciones se leen.

## Referencias

- C++23 `[[assume]]` (P1774) · GCC `__attribute__((assume))` · Clang `__builtin_assume` · MSVC `__assume`.
- *Value-range / known-bits* de GCC (`-fstrict-aliasing`, `-ftree-vrp`) y PGO (`-fprofile-generate/use`).
- Interpretación abstracta de valores (VSA) y *thin slicing* para inferir rangos.
