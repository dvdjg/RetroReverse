#pragma once

/// \file services.hpp
/// **Propuesta** de abstracción de servicios del Amiga para el emulador NES.
///
/// No implementa nada: define las **interfaces** que el emulador desea encontrar
/// para usar el hardware Amiga (scroll por HW, tiles, Copper, sprites, Paula) sin
/// tocar registros ni planos a bajo nivel. El backend Amiga las implementará.
///
/// Dos niveles, deliberadamente separados:
/// 1. **`Host`** ([`../host.hpp`](../host.hpp)) — mínimo común (vídeo por
///    framebuffer, audio, entrada, tiempo). Lo usan el intérprete y el camino de
///    *fallback*; el backend lo cumple aunque no ofrezca aceleración.
/// 2. **`AmigaServices`** (este fichero) — superficie **opcional de aceleración**
///    (HLE): scroll/bitplanes/Copper/Blitter/sprites. El emulador la usa si está
///    disponible; si no, cae al `Host`.
///
/// Unidades: píxeles y tiles (nunca palabras de plano); colores en 12 bits
/// (`0x0RGB`); tiempos en líneas/scanlines y frames.

#include <eng/core/types/types.hpp>

namespace n2a::amiga {

// --- Tipos de valor ---------------------------------------------------------

/// Rectángulo en píxeles (origen arriba-izquierda).
struct Rect {
	eng::s16 x = 0;
	eng::s16 y = 0;
	eng::u16 w = 0;
	eng::u16 h = 0;
};

/// Color del Amiga en formato `0x0RGB` (4 bits por canal).
using Color = eng::u16;

/// Referencia a un tile ya cacheado: el emulador no conoce su dirección física.
struct TileRef {
	eng::u16 index = 0; ///< Índice en la caché de patrones.
	eng::u8 palette = 0; ///< Paleta/atributo (0..3 para NES).
	eng::u8 flags = 0;   ///< bit0 flip H, bit1 flip V.
};

/// Identificador opaco de una superficie planar (bitmap). Solo el backend sabe
/// su layout; el emulador lo pasa entre servicios.
struct SurfaceRef {
	eng::u32 id = 0;
};

// --- Memoria Chip -----------------------------------------------------------

/// Asignador de **Chip RAM** (accesible por DMA de Agnus).
/// El emulador pide bloques (bitmaps, copperlists, sprites, audio) y los libera.
struct IChipMem {
	virtual ~IChipMem() = default;
	/// \param bytes Tamaño; \param align Alineación (potencia de dos).
	/// \return Dirección alineada, o `nullptr` si no cabe.
	virtual void* alloc(eng::u32 bytes, eng::u32 align) = 0;
	/// Libera un bloque obtenido con `alloc`.
	virtual void free(void* ptr) = 0;
	/// \return Bytes de Chip RAM libres (para decidir frameskip/calidad).
	virtual eng::u32 free_bytes() const = 0;
};

// --- Blitter ----------------------------------------------------------------

/// Operaciones de **Blitter** en términos de rectángulos y patrones (no de
/// registros `BLTCON*`/`BLTxPT`). El backend elige la configuración.
struct IBlitter {
	virtual ~IBlitter() = default;
	/// Copia **opaca** de un rectángulo de la superficie origen a la destino.
	virtual void copy(const SurfaceRef& src, const Rect& src_rc, const SurfaceRef& dst,
			  const Rect& dst_rc) = 0;
	/// Copia con **transparencia** (color 0 = fondo), p. ej. bobs/bordes.
	virtual void copy_masked(const SurfaceRef& src, const Rect& src_rc, const SurfaceRef& dst,
				 const Rect& dst_rc, eng::u16 transparent_plane0) = 0;
	/// Relleno sólido de un rectángulo con un patrón de plano.
	virtual void fill(const SurfaceRef& dst, const Rect& rc, eng::u16 plane_word) = 0;
	/// Espera a que terminen los blits lanzados.
	virtual void sync() = 0;
	/// Petición de turno. `false` si el Blitter está ocupado por el backend
	/// (el emulador decide posponer/hacer en CPU).
	virtual bool try_acquire() = 0;
};

// --- Superficies planares ---------------------------------------------------

/// Superficie planar gestionada por el backend (bitmap + módulo).
struct ISurface {
	virtual ~ISurface() = default;
	virtual SurfaceRef ref() const = 0;
	virtual eng::u16 width() const = 0;   ///< En píxeles.
	virtual eng::u16 height() const = 0;  ///< En píxeles.
	virtual eng::u8 planes() const = 0;   ///< Nº de bitplanes (1..6).
};

// --- Patrones (CHR → planar) ------------------------------------------------

/// Caché de patrones: convierte tiles NES 2 bpp a formato planar Amiga y los
/// sube a Chip RAM. El emulador solo maneja índices (`TileRef`).
struct IPatternCache {
	virtual ~IPatternCache() = default;
	/// Define/actualiza un tile desde sus 16 bytes NES (plano0|plano1).
	/// \param tile Índice NES (0..511).
	/// \param nes_2bpp 16 bytes del tile.
	/// \param planes Nº de planos de destino (2 o 3).
	virtual void define(eng::u16 tile, const eng::u8* nes_2bpp, eng::u8 planes) = 0;
	/// Define una variante con desplazamiento de paleta (attribute horizontal
	/// pre-aplicado), si el backend usa esa estrategia.
	virtual void define_with_palette(eng::u16 tile, const eng::u8* nes_2bpp, eng::u8 planes,
					 eng::u8 palette) = 0;
};

// --- Capa de fondo con scroll por hardware ----------------------------------

/// Capa de tiles con **scroll por hardware** y actualización incremental.
/// Oculta BPLPT/BPLCON1/BPLMOD y el buffer circular: el emulador solo dice
/// "muévete a (x,y)" y "este tile cambió".
struct IScrollingLayer {
	virtual ~IScrollingLayer() = default;
	/// Configura la capa: caché de patrones, tamaño del buffer en tiles y playfield.
	/// \param layer 0 = Playfield 1 (fondo), 1 = Playfield 2 (segunda capa).
	virtual void configure(IPatternCache& patterns, eng::u16 tiles_x, eng::u16 tiles_y,
			       eng::u8 layer) = 0;
	/// Mueve el scroll (píxeles). El backend ajusta punteros finos/gruesos.
	virtual void set_scroll(int x, int y) = 0;
	/// Marca un tile del mapa lógico (índices enteros) para redibujado.
	virtual void set_tile(int tile_x, int tile_y, TileRef tile) = 0;
	/// Marca la attribute table (paleta por bloques 16×16) de una celda.
	virtual void set_attribute(int attr_x, int attr_y, eng::u8 palette) = 0;
	/// Blittea lo pendiente (columnas/filas sucias). Llamar una vez por frame.
	virtual void flush(IBlitter& blitter) = 0;
	/// Activa/desactiva la capa; asigna prioridad relativa (mayor = delante).
	virtual void set_enabled(bool on) = 0;
	virtual void set_priority(eng::u8 priority) = 0;
	/// Color de fondo (color 0) de la capa.
	virtual void set_backdrop(Color color) = 0;
};

// --- Paleta -----------------------------------------------------------------

/// Paleta de 32 entradas (índices 0..31). Los cambios por franjas se hacen vía
/// `ICopper`; aquí se fija la paleta base.
struct IPalette {
	virtual ~IPalette() = default;
	/// Fija la entrada `index` (0..31) al color `color`.
	virtual void set(eng::u8 index, Color color) = 0;
	/// \return Color de la entrada `index`.
	virtual Color get(eng::u8 index) const = 0;
};

// --- Copper -----------------------------------------------------------------

/// Constructor de **Copperlist** de alto nivel. El emulador describe *qué* cambia
/// y *cuándo* (por línea); el backend genera las instrucciones y la activa.
struct ICopper {
	virtual ~ICopper() = default;
	/// Comienza la lista del frame en el búfer de trabajo (doble buffer).
	virtual void begin() = 0;
	/// Espera a la línea de pantalla `line` (WAIT).
	virtual void wait_line(eng::u16 line) = 0;
	/// Cambia una entrada de color a partir de aquí (efectos/attribute vertical).
	virtual void set_color(eng::u8 index, Color color) = 0;
	/// Cambia el scroll a partir de aquí (splits mid-frame).
	virtual void set_scroll(int x, int y) = 0;
	/// Ajusta el puntero de una capa (p. ej. tras el scroll).
	virtual void set_layer(IScrollingLayer& layer, eng::u8 target_layer) = 0;
	/// Marca un split: a partir de `line`, activa/desactiva una capa o cambia su
	/// prioridad (status bar, efectos).
	virtual void split(eng::u16 line, IScrollingLayer* layer, bool enabled, eng::u8 priority) = 0;
	/// Cierra la lista y la deja lista para activarse en el VBlank.
	virtual void commit() = 0;
	/// \return Palabras de Copperlist aún disponibles (presupuesto del frame).
	virtual eng::u16 free_words() const = 0;
};

// --- Sprites ----------------------------------------------------------------

/// Slots de sprite hardware. El backend multiplexa y, si hace falta, usa bobs.
struct SpriteSlot {
	eng::s16 x = 0;      ///< X en píxeles (coordenada de pantalla).
	eng::s16 y = 0;      ///< Y en líneas.
	eng::u16 data = 0;   ///< Índice de gráfico de sprite cacheado.
	eng::u8 height = 8;  ///< 8 o 16.
	eng::u8 palette = 0; ///< 0..3.
	bool behind = false; ///< Detrás del playfield.
	bool active = false;
};

struct ISpriteEngine {
	virtual ~ISpriteEngine() = default;
	/// Sube/actualiza el gráfico de un sprite NES (16 bytes → formato Amiga), con
	/// flips y modo 8×16 resueltos por el backend.
	virtual void define(eng::u16 index, const eng::u8* nes_2bpp, bool flip_h, bool flip_v,
			    bool is_8x16) = 0;
	/// Asigna un sprite a un slot (el backend decide HW vs bob y multiplexa).
	/// \return `false` si no cabe (el emulador puede descartarlo, como la NES).
	virtual bool place(const SpriteSlot& slot) = 0;
	/// Blittea los bobs de respaldo (los que no caben en HW). Lo llama el frame.
	virtual void draw_bobs(IBlitter& blitter) = 0;
	/// Genera la parte de Copperlist para los sprites HW multiplexados.
	virtual void add_to_copper(ICopper& copper) = 0;
	/// Limpia la lista de sprites del frame.
	virtual void begin_frame() = 0;
};

// --- Audio (Paula) ----------------------------------------------------------

/// Canales de audio de Paula. El backend gestiona DMA, periodos y mezcla.
struct IAudio {
	virtual ~IAudio() = default;
	/// Reproduce un bloque de samples mono en un canal (0..3).
	/// \param channel 0..3; \param samples s16 mono; \param count muestras; \param rate Hz.
	virtual void play(eng::u8 channel, const eng::s16* samples, eng::u32 count,
			  eng::u32 rate) = 0;
	/// Ajusta periodo y volumen de un canal (modo "voz" tipo chiptune).
	virtual void set_period(eng::u8 channel, eng::u16 period, eng::u16 volume) = 0;
};

// --- Entrada ----------------------------------------------------------------

/// Estado de los mandos del Amiga.
struct IInput {
	virtual ~IInput() = default;
	/// \param pad 0/1.
	/// \return Byte en formato NES (A,B,Select,Start,Up,Down,Left,Right).
	virtual eng::u8 read_pad(eng::u8 pad) = 0;
};

// --- Presentación / sincronía -----------------------------------------------

/// Salida de vídeo y sincronía con el frame del Amiga.
struct IDisplay {
	virtual ~IDisplay() = default;
	/// Presenta el framebuffer del *fallback* (índices NES) en pantalla.
	/// El backend hace chunky→planar y lo coloca en los bitplanes activos.
	/// \param indices `width*height` índices de color NES.
	virtual void present_indices(const eng::u8* indices) = 0;
	/// Espera al VBlank (sincronización de frame). \return número de frame.
	virtual eng::u64 wait_vblank() = 0;
	/// \return Resolución visible (256×240 o la configurada).
	virtual Rect viewport() const = 0;
};

// --- Agregado y capacidades -------------------------------------------------

/// Qué servicios ofrece el backend (para elegir camino HLE o fallback).
enum class Capability : eng::u8 {
	Scroll,      ///< IScrollingLayer + IPatternCache.
	Copper,      ///< ICopper.
	Sprites,     ///< ISpriteEngine.
	Blitter,     ///< IBlitter.
	AudioPaula,  ///< IAudio.
};

/// Conjunto de servicios del backend Amiga. Los punteros pueden ser `nullptr`
/// si el servicio no está disponible (el emulador usa entonces el `Host`).
struct AmigaServices {
	IChipMem* chip = nullptr;
	IBlitter* blitter = nullptr;
	ISurface* work_surface = nullptr;
	IPatternCache* patterns = nullptr;
	IScrollingLayer* bg = nullptr;
	IScrollingLayer* fg = nullptr;
	IPalette* palette = nullptr;
	ICopper* copper = nullptr;
	ISpriteEngine* sprites = nullptr;
	IAudio* audio = nullptr;
	IInput* input = nullptr;
	IDisplay* display = nullptr;

	/// \return `true` si el servicio `cap` está disponible.
	[[nodiscard]] bool has(Capability cap) const {
		switch (cap) {
		case Capability::Scroll: return bg != nullptr && patterns != nullptr;
		case Capability::Copper: return copper != nullptr;
		case Capability::Sprites: return sprites != nullptr;
		case Capability::Blitter: return blitter != nullptr;
		case Capability::AudioPaula: return audio != nullptr;
		}
		return false;
	}
};

} // namespace n2a::amiga
