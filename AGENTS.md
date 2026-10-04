# Instrucciones de trabajo para este repositorio

Directrices persistentes para el agente que trabaja en `RetroReverse`. Se aplican a **todos**
los expedientes de desensamblado, no solo a `sanity-arte`.

## Estado vivo del pilar NES → Amiga 500 (punto de entrada para nuevos hilos)

El trabajo activo del hilo actual es la **conversión NES → Amiga 500**, en
[`conversion/nes-to-amiga500/`](conversion/nes-to-amiga500/README.md). **Antes de retomarlo, leer:**

| Necesito… | Documento |
|---|---|
| **Traspaso vivo del hilo** (estado, rutas, próximos pasos) | [`CONTEXT.md`](CONTEXT.md) (local, **ignorado por git**) |
| Plan por fases (F0→F10) y criterios de cierre | [`conversion/nes-to-amiga500/docs/ROADMAP.md`](conversion/nes-to-amiga500/docs/ROADMAP.md) |
| Timing PPU/NMI: estado y límite conocido | [`conversion/nes-to-amiga500/docs/TIMING_ROADMAP.md`](conversion/nes-to-amiga500/docs/TIMING_ROADMAP.md) |
| Matriz de compatibilidad vs `mesen` (67/71 a 0.0%) | [`conversion/nes-to-amiga500/docs/COMPATIBILITY.md`](conversion/nes-to-amiga500/docs/COMPATIBILITY.md) |
| Riesgos y límites reales | [`conversion/nes-to-amiga500/docs/RISKS.md`](conversion/nes-to-amiga500/docs/RISKS.md) |
| Método de validación diferencial vs mesen | [`conversion/nes-to-amiga500/docs/VALIDATION.md`](conversion/nes-to-amiga500/docs/VALIDATION.md), [`REFERENCE_TRACER.md`](conversion/nes-to-amiga500/docs/REFERENCE_TRACER.md) |
| Juegos difíciles (mappers, casos límite) | [`conversion/nes-to-amiga500/docs/HARD_GAMES.md`](conversion/nes-to-amiga500/docs/HARD_GAMES.md) |

**Estado resumido** (fase de desarrollo actual: **F1–F3 en curso; F9 (mappers) avanzado**): runtime
6502 + PPU software (oráculo) en `conversion/nes-to-amiga500/runtime/`, transpilador prototipo, y
validación diferencial contra **mesen** con **67/71 ROMs a 0.0%** de divergencia estructural. Los 4
restantes (`ic`, `galaga`, `metalstorm`, `pacman`) comparten **un único límite conocido**: la
sincronización PPU/NMI sub-instrucción entre frames. **No es cosmético**; se aborda como diagnóstico
de *state-injection* (ver `CONTEXT.md` §Estado para el detalle del hilo). El backend **Mega Drive
está descartado**.

**Regla de oro del pilar**: primero que funcione **lento y correcto** (fallback software = oráculo),
luego rápido (HLE). Toda entrega a **A500 real (68000 @7 MHz)** debe ser replicable en hardware; no
perseguir un modelo *cycle-lockstep* que el Amiga no pueda ejecutar.

## Objetivo principal (confirmado por el usuario)

1. Recuperar las **técnicas** de las demos/juegos Amiga, con énfasis en las **técnicas gráficas**.
2. Extraer y **comprender el ensamblador 68k** de las rutinas.
3. **Inferir los programas C++ más aproximados** (reimplementación de alto nivel).
4. **Volver a construir la misma demo desde el código fuente** en el engine propio, usando el
   ensamblador solo para las partes críticas si es imprescindible.

**Nota del usuario (2026)**: las **rutinas optimizadas** del ensamblador (p. ej. aritmética Q15
con `muls.w`/`swap` del motor 3D) **serán las que se usen en la reconstrucción** — aunque sea
"casi imposible" que C++ genere una optimización equivalente, la versión canónica de esas rutinas
es la referencia a portar. Se guarda la versión canónica (desensamblado + notas) y se usa como
base del port.

El orden de prioridad del trabajo es: **ensamblador → comprensión → documentación → reimpl C++**.
La extracción del framebuffer/bitplanes de una demo en marcha es **poco fiable e inútil** (los
registros y buffers cambian por frame); la clave está en el código.

## Reglas de documentación (obligatorias)

- **Documentar SIEMPRE** cada cosa que se extraiga: cada módulo, rutina, dato, dirección.
- Para cada artefacto, indicar **qué se cree que es con el grado de confianza estimado**
  (p. ej. `alta`/`media`/`baja` + razonamiento). No presentar hipótesis como hechos.
- Si hay incertidumbre, listar las hipótesis alternativas probadas y por qué se descartaron.
- Todo artefacto curado va a `recovered/` con trazabilidad (`SOURCE` + sha1 + comando que lo
  regenera). Ver `STRUCTURE.md`.
- **El conocimiento adquirido y los desarrollos útiles NO deben perderse**: si un análisis no
  termina, guardar el estado como WIP anotado (nunca borrar un avance sin documentarlo).

## Regla de código autodocumentado (obligatoria, también en el código GENERADO)

Todo el código —**incluido el que emite el transpilador**— debe poder entenderse sin salir del
propio fichero. Documentar de forma explícita:

- **Clases / structs**: propósito y responsabilidad.
- **Métodos y funciones**: qué hacen, **argumentos** (unidades, rango, `nullptr`), **valor de
  retorno** (incluido qué significa cada código de error) y **efectos secundarios**.
- **Variables de instancia y de clase**: significado y unidades.
- **Macros, `#define`, plantillas y parámetros de plantilla**: para qué existen y cómo se usan.
- **Constantes, enums y tablas**: qué representan y de dónde salen.

Además, cada bloque de código debe dejar claro:

1. **Qué hace** (resumen en una o dos líneas).
2. **Quién lo llama / en qué contexto** (punto de entrada, callback, dispatcher, IRQ…).
3. **Qué recursos necesita** (memoria, Chip RAM, ficheros, hardware, tipos de `eng/core`…).

### Aplicación al código generado por el transpilador

El codegen debe emitir esta documentación de forma **automática**:

- **Cabecera del fichero**: qué es, ROM de origen, quién lo compila/ejecuta, recursos que usa.
- **Cada basic block** (`bb_XXXX`): rango de direcciones 6502, número de instrucciones, qué hace,
  quién lo llama (reset/NMI/IRQ, `JSR`/`JMP`/rama, continuación de otro bloque) y cómo sale
  (cae, salta, retorna, `BRK`, salto indirecto).
- **Tabla de despacho y `game_main`**: contrato de entrada/salida.
- **Runtime stub** (`cpu_stub_text.hpp`): clases, miembros, métodos y macros documentados.

## Codificación de texto (obligatoria)

Todo el texto del proyecto va en **UTF-8 sin BOM** —sin UTF-16, sin mojibake (UTF-8 doblemente
codificado) y sin carácter de reemplazo—, y se pueden usar con naturalidad `ñ`, tildes y símbolos
Unicode (`→`, `≈`, `±`…). Mismo criterio que `Amiga-Cpp/tools/check/encoding.mjs`.

Aplica a: documentación (`.md`), **código fuente propio y generado** (`.cpp/.hpp`), mensajes de
commit y salida de herramientas. Es decir: **no** se translitera a ASCII (`añade`, no `anade`;
`código`, no `codigo`).

- En **Windows**, para verlo bien en consola:
  `chcp 65001 > $null; [Console]::OutputEncoding = [Text.UTF8Encoding]::new()`, y leer ficheros con
  `Get-Content -Encoding utf8` (o `git`). En VS Code es automático.
- El validador `encoding.mjs` comprueba que todo siga siendo UTF-8 válido y sin BOM: cualquier
  fichero nuevo debe pasar ese check.

## Uso de Ollama local (modelo de visión)

- Para interpretar/validar imágenes (gráficos Amiga decodificados, capturas) usar **Ollama local**,
  no depender del modelo de chat principal (que no ve imágenes).
- Modelo de visión disponible: `qwen3-vl:8b-instruct-q8_0` (también `gemma3:12b`).
- Cliente: `tools/python/ollama_vision.py` (manda la imagen en base64 al endpoint
  `http://localhost:11434/api/generate`).
- **Advertencia**: el modelo de visión de 8B **alucina coherencia** ("pixel art") y puede
  inventar contexto. Usarlo solo como señal débil; validar con métricas objetivas y, para
  confirmar, pedir al usuario que mire la imagen.
- Comando: `python tools/python/ollama_vision.py <imagen.png> [--prompt "..."]`.

## Bitmaps Amiga OCS/ECS (guía de reconstrucción)

Ver `platforms/computers/amiga500/tools/python/AMIGA_BITMAPS.md` (guía completa del usuario): registros custom a leer,
algoritmo de intercalado planar, heurísticas de ancho/altura/stride, detección de tiles/bobs,
lectura desde ADF. Puntos clave:

- **Runtime**: leer `BPLCON0` (bits 14-12 = nº bitplanes, 15 = HIRES, 10 = DPF, 11 = HAM),
  `BPL1MOD/BPL2MOD`, `BPLxPTH/PTL`, `DIWSTRT/STOP`, `DDFSTRT/STOP`, `COLOR00..31`, `BPLCON1/2`.
  Priorizar SIEMPRE la configuración hardware cuando haya registros.
- **Ancho**: lores suele ser 40 B (320 px), hires 80 B (640 px); ajustar con DDFSTRT/STOP.
- **Altura**: con DIWSTRT/STOP, o 200/256/312 según PAL/NTSC.
- **Layout planar**: intercalar bitplanes `índice |= (bit de plano p) << p` por pixel.
- **Sin registros** (disco/dump): probar combinaciones de 1-6 planos, anchos comunes
  (16,32,40,64,80,160 B), alturas (8..256), calcular stride más probable; buscar máscaras
  (plano casi todo 1s/0s); detectar tilesets (bloques de tamaño fijo repetidos) y tilemaps.
- **Importante**: las imágenes fuente de algunos efectos (corridor, texture-floor) pueden NO ser
  rectangulares (trapecio/paralelepípedo con más detalle en la base). Empezar buscando formas
  rectangulares, pero considerar la deformación si no hay coincidencia.
- **Dual playfield**: planos impares = PF1, pares = PF2 (módulos/punteros independientes).
- **Copper**: puede cambiar punteros y colores a mitad de frame → reconstruir por "bandas".

## La demo en marcha NO es fiable

- Capturar el framebuffer/registros de una demo corriendo da datos de **transición** (borrado,
  cambio de efecto, buffers reutilizados). Los valores de custom registers cambian por frame.
- No intentar reconstruir una imagen completa de un frame en vivo. Usar screenshot como
  referencia visual (la captura del emulador es fiel) y el **código** como fuente de verdad.
## Scratch de pruebas y diagnóstico (obligatorio)

Todo artefacto efímero de prueba/diagnóstico vive en **`repo/_scratch/`** (gitignored con
`/_scratch/`). **Nunca** en `%TEMP%`, en el workspace, ni junto al código fuente. Subdirs:

| Subdir | Contenido |
|--------|-----------|
| `_scratch/host/` | probes C++ que corren en el host (x64). |
| `_scratch/out/`  | salidas regenerables (`.bmp/.png`, volcados, trazas). |
| `_scratch/ref/`  | referencias regenerables (frames del oráculo). |
| `_scratch/bin/`  | ejecutables compilados de los probes. |

Herramientas locales: `_scratch/build-probe.sh <name>.cpp [includes…]` (compila
`host/<name>.cpp` → `bin/<name>.exe`) y `_scratch/README.md` (convenciones).

## Lecciones aprendidas (reglas)

### 1. Validar SIEMPRE contra el oráculo, nunca contra uno mismo
Un render del **port decompilado** no valida nada contra el **port decompilado**: si el port
está mal, ambos renders coinciden trivialmente. La referencia correcta es el **oráculo**
(intérprete `n2a::NesSystem`, camino lento y correcto) del propio transpiler. Para lo visual:
`_scratch/host/oracle_frame.cpp` vuelca un frame del intérprete; comparar ese frame (recorte del
playfield) contra la captura del Amiga **a ojo y con métrica** (histograma / diff). Si no hay
oráculo disponible para una ROM, decirlo: no dar por buena una comparación auto-referente.

### 2. El HAL del PPU del port no debe enrutar escrituras CHR a la nametable
En el modelo del port, `vram[0x1000]` es SOLO el espacio de nametables (`$2000-$2FFF`); el CHR
es ROM de solo lectura. `$2007` debe escribir: `$2000-$3EFF → vram`, `$3F00+ → paleta`,
`$0000-$1FFF (CHR) → ignorar`. Enrutar `x < 0x3F00` a `vram[x & 0xFFF]` hace que, p. ej., una
escritura a `$03C0` caiga en `vram[0x3C0]` y **machaque la tabla de atributos** (el nametable
queda bien; las subpaletas se van a 0 → colores equivocados). Ver
`transpiler.hpp` (`emit_decompile`, caso `$2007`). Bug real detectado en DK (Rev A).

### 3. El diagnóstico visual requiere aislar capas
Un pixel equivocado puede venir del BG, de los atributos/subpaletas, de los sprites HW, o del
path de composición (Blitter/X-limited/Copper). Antes de tocar el render, volcar el **estado
observable** del PPU (nametable, atributos, paleta, OAM) del port y compararlo con el oráculo
celda a celda. Sólo cuando el estado coincide, el problema es de render.

### 4. `FramePlan`: vaciar ANTES de llenar (no "cuando falle el add")
`FramePlan::add_*` marca el plan `m_ok = false` al alcanzar `max_blit_jobs` (128) y devuelve
`false`. Pero `execute_frame_plan` **rechaza** un plan no-ok -> si se vacía "cuando el add falla",
el lote ya está marcado no-ok y se **pierde** (en DK: los 128 primeros blits, la mitad superior).
Regla: llevar un contador propio y llamar a `execute_frame_plan` **antes** de llegar al tope
(p. ej. a 64), luego `clear()`. Ver `dk_port/src/main.cpp` (`add_mt_job`/`m_batch`).

### 5. Pattern table base: mirar `$2000` (bits 3 y 4)
El BG y los sprites leen de pattern tables distintas según `$2000`: bit 4 = base del BG
(`$0000`/`$1000`), bit 3 = base de sprites. DK pone el BG en **`$1000`**. Ignorarlo hace que el
render lea los tiles incorrectos (el logo "correcto" del nametable se pinta con los gráficos
de la tabla de sprites). Aplica al port (`hal`) y a cualquier render que decodifique CHR.
