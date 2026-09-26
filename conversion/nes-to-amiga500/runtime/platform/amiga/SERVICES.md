# Servicios del Amiga que necesita el emulador NES

Lista de **servicios** que el emulador desea del backend Amiga y la **estructura de clases y
abstracciones** que preferiría encontrar, para no lidiar a bajo nivel con planos, Copper ni
Blitter. La propuesta de interfaces está en [`services.hpp`](services.hpp).

> Principio: el emulador expresa **intenciones NES** ("mueve el fondo a (x,y)", "cambia el color 5
> desde la línea 120", "coloca 64 sprites respetando 8 por línea"); el backend decide el *cómo*
> Amiga (punteros de bitplanes, `BPLCON1`, Copper, Blitter, Paula).

## 1. Dos niveles de acceso

| Nivel | Interfaz | Para quién | Obligatorio |
|---|---|---|---|
| **Genérico** | [`Host`](../host.hpp) | intérprete y *fallback* (presenta un framebuffer de índices NES, audio, entrada, VBlank) | sí |
| **Aceleración (HLE)** | [`AmigaServices`](services.hpp) | camino rápido: scroll/tiles/Copper/sprites/Paula | opcional |

El emulador pregunta `services.has(Capability::…)` y, si no hay servicio, cae al `Host`. Así el
mismo núcleo funciona en Amiga con o sin aceleración, y en SDL3 (que implementa `Host`).

## 2. Catálogo de servicios (qué pide el emulador NES)

| Necesidad NES | Servicio ideal | Oculta (bajo nivel) |
|---|---|---|
| Reservar bitmap/copperlist/sprites/audio | **`IChipMem`** | `AllocMem`, `MEMF_CHIP`, alineación de 8/16 |
| Componer tiles y bobs | **`IBlitter`** | `BLTCON0/1`, `BLTxPT`, `BLTxMOD`, A/B/C/D, espera |
| Tiles CHR 2 bpp → planos | **`IPatternCache`** | conversión 2bpp→planar, intercalado, alineación |
| Fondo con scroll 8-way | **`IScrollingLayer`** | `BPLxPT`, `BPLCON1`, `BPLxMOD`, buffer circular, `DDFSTRT/STOP` |
| Segunda capa / status bar | **`IScrollingLayer`** (fg) | Dual Playfield, `BPLCON2` (prioridades) |
| Cambios de color por franja/split | **`ICopper`** | `WAIT`/`MOVE`, `COLORxx`, `COP1LC`, doble buffer |
| Paleta base (4 BG + 4 sprites + fondo) | **`IPalette`** | registros `COLOR00..31`, 12 bits `0x0RGB` |
| 64 sprites NES, 8/línea | **`ISpriteEngine`** | `SPRxPOS/CTL/PT`, multiplexado, attach, bobs |
| APU → Paula | **`IAudio`** | DMA de canales, periodos, volúmenes, mezcla |
| Mandos | **`IInput`** | `JOYxDAT`, teclado, protocolo serie de `$4016` |
| Framebuffer de *fallback* y VBlank | **`IDisplay`** | chunky→planar, `COP1LC`, interrupción de VBlank, PAL/NTSC |

## 3. Estructura ideal de clases (resumen)

Ver definiciones y documentación en [`services.hpp`](services.hpp):

```
AmigaServices                // agregado; punteros pueden ser nullptr
  IChipMem       chip        // alloc/free/free_bytes
  IBlitter       blitter     // copy/copy_masked/fill/sync/try_acquire
  ISurface       work_surface// superficie planar de trabajo (bitmap)
  IPatternCache  patterns    // define/define_with_palette
  IScrollingLayer bg, fg     // configure/set_scroll/set_tile/set_attribute/flush/…
  IPalette       palette     // set/get
  ICopper        copper      // begin/wait_line/set_color/set_scroll/splits/commit
  ISpriteEngine  sprites     // define/place/draw_bobs/add_to_copper/begin_frame
  IAudio         audio       // play/set_period
  IInput         input       // read_pad
  IDisplay       display     // present_indices/wait_vblank/viewport
```

Propiedades deseadas de estas abstracciones:

- **Orientadas a intención, no a registro.** Nada de `BPLCON*`/`COP*`: nombres como
  `set_scroll`, `set_color`, `wait_line`, `place`, `flush`.
- **Coordenadas en píxeles y tiles**, colores en `0x0RGB`, tiempos en líneas/frames.
- **Handles opacos** para superficies y tiles (`SurfaceRef`, `TileRef`): el emulador nunca ve
  direcciones físicas ni el layout planar/intercalado.
- **No bloqueantes cuando importa**: `try_acquire` (Blitter), `free_words` (Copper), `free_bytes`
  (Chip RAM) devuelven presupuesto para que el emulador decida posponer o caer al fallback.
- **Doble buffer interno** (Copper y, si aplica, superficies): el emulador llama `begin()`/`commit()`
  una vez por frame.
- **Sin STL y con tipos `eng`**: compilable con `m68k-amiga-elf-g++`/`vbcc`; el backend puede
  implementar métodos en **asm/Copper/Blitter** detrás de la interfaz.

### ¿Interfaz C++ o ABI C?

Se propone **clases abstractas C++** (virtuales) por comodidad y porque el m68k las soporta. Si
prefieres un backend en ensamblador puro o evitar vtables, es trivial ofrecer la variante **ABI C**:
cada interfaz pasa a un `struct` de **punteros a función** + `void* self`, con los mismos tipos POD.
Conviene decidirlo contigo; el resto del diseño no cambia.

## 4. Cómo lo usaría el emulador (intenciones → llamadas)

**Scroll del fondo** (escritura a `$2005`):
```
bg.set_scroll(scroll_x, scroll_y);          // el backend mueve BPLPT + BPLCON1
copper.set_scroll(scroll_x, scroll_y);      // para splits mid-frame
```

**Actualización de nametable** (`$2007`):
```
patterns.define(tile, chr + tile*16, planes);
bg.set_tile(tx, ty, {tile, palette, flips});
// el frame hace: bg.flush(blitter);   // solo columnas/filas sucias
```

**Attribute table** (paleta por bloques 16×16):
```
bg.set_attribute(ax, ay, palette);          // estrategia A: pre-aplicada
// o, estrategia B: copper.wait_line(line); copper.set_color(1..3, …);
```

**Sprites** (OAM DMA `$4014`):
```
sprites.begin_frame();
for (cada sprite activo ordenado por Y) {
	if (!sprites.place({x, y, data, height, palette, behind, true}))
		/* overflow: descartar, como la NES */;
}
sprites.draw_bobs(blitter);
sprites.add_to_copper(copper);
```

**Split / sprite-0 hit**:
```
copper.begin();
copper.set_palette(*palette);
copper.wait_line(split_line);
copper.set_scroll(0, new_scroll_y);   // status bar fija
copper.split(status_line, &fg, true, priority);
copper.commit();
```

**Audio**:
```
audio.play(0, samples, count, 22050);       // APU → Paula
```

**Frame**:
```
display.wait_vblank();
// ejecutar CPU/PPU, actualizar servicios…
display.present_indices(fallback_fb);       // solo si no hay camino HLE completo
```

## 5. Lo que **no** queremos exponer

- Direcciones/registros (`$DFFxxx`), bits de `BPLCON0`, cálculo de módulos/punteros.
- Layout planar ni chunky→planar: eso es del backend.
- Detalles de `WAIT/MOVE` del Copper: el emulador da línea + acción.
- Multiplexado de sprites: lo resuelve `ISpriteEngine`.
- Gestión de doble buffer: dentro de `ICopper`/`IDisplay`.

## 6. Presupuesto y *fallback*

El emulador consultará `chip.free_bytes()`, `copper.free_words()`, `blitter.try_acquire()` y
`display.wait_vblank()` para decidir:
- cuántas capas/splits permite el frame,
- si conviene usar sprites HW o bobs,
- si debe **saltarse frames** (frameskip) cuando no llega.

Si falta un servicio (`services.has(...) == false`), esa parte cae al **fallback** (PPU software +
`present_indices`), garantizando que el juego siga funcionando aunque sea más lento.

## 7. Encaje en el roadmap

- **F0/F4**: `Host` (ya definido) para el *fallback*.
- **F5/F6/F8**: `AmigaServices` (tiles/scroll/sprites/Copper) es la superficie HLE.
- Tu API de recursos Amiga puede implementar total o parcialmente `AmigaServices`; el emulador se
  adapta por capacidades.
