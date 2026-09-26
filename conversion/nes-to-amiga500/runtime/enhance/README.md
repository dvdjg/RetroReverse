# runtime/enhance — ajustes por ROM (gráficos/sonido)

Ajustes que afectan **solo a una ROM** (otro grupo de tiles, tiles con más colores,
p. ej. **4 bpp** en vez de 2, paletas alternativas, plugin de audio) **sin cambiar la
emulación** (CPU, PPU de tiles/atributos, mappers y timing siguen igual). La emulación
sigue siendo la fuente de verdad; la capa de mejora es una **sustitución** en la salida
gráfica/sonora.

## Idea

```
CPU/mapper/timing ──(sin cambios)──► PPU (tiles 8×8, attributes, sprites)
                                          │  pide "dibuja el tile T con paleta P"
                                          ▼
                              ITileProvider  (default = CHR 2 bpp NES)
                                          │  o un pack por ROM: otro tileset / 4 bpp
                                          ▼
                              framebuffer de índices  ──► palette (NES o extendida)
```

- **Por defecto** no hay proveedor (`tile_provider == nullptr`) y la PPU lee la CHR 2 bpp
  exactamente como siempre → **comportamiento idéntico** (lo cubre `ppu_test`, incluida la
  ruta del proveedor).
- **Con perfil**, la PPU consulta [`ITileProvider`](tile_provider.hpp): hasta 4 planos por
  fila y un `color()` que mapea a un índice extendido; el vídeo usa la **paleta extendida**
  (`Ppu::ext_palette`).

## Servicios / interfaces

| Interfaz | Fichero | Para qué |
|---|---|---|
| `ITileProvider` | [`tile_provider.hpp`](tile_provider.hpp) | Fuente de tiles: `bpp()`, `fetch_row()`, `color()` |
| `NesTileProvider` | idem | Proveedor por defecto (CHR 2 bpp + paleta NES) |
| `RomProfile` | [`rom_profile.hpp`](rom_profile.hpp) | Perfil por ROM (CRC32) con overrides |
| `ProfileStore` | idem | Búsqueda de perfil por CRC32 |
| `parse_profile` | idem | Carga un perfil desde texto |

`GraphicsOverride` incluye: `bpp_bg`/`bpp_sprite` (2..4), `provider` (proveedor de tiles),
`palette` (paleta extendida `0x0RGB`), y rutas `tiles_path`/`palette_path`. `AudioOverride`
permite elegir un plugin de audio distinto por ROM.

## Formato de perfil

Se identifica la ROM por su **CRC32** y se describe en texto (ver
[`rom_profile.hpp`](rom_profile.hpp)). El frontend lo localiza (p. ej. `<rom>.n2a` junto a la
ROM o en una carpeta de packs) y lo aplica al cargar:

```
crc 1a2b3c4d
name Mi Juego
video.bpp 4
video.palette packs/mi.pal
video.tiles   packs/mi.gfx
audio.plugin  linear
```

## Integración

- **Núcleo**: [`Ppu::tile_provider`](../fallback/nes_ppu.hpp) y `Ppu::ext_palette`. `NesSystem`
  aplica el perfil al cargar (`ppu.tile_provider = profile->gfx.provider`, etc.).
- **SDL3 / host**: al cargar la ROM se busca el perfil (por CRC) y se aplica; la paleta
  extendida la usa `NesSystem::frame_rgb`.
- **RetroArch**: los plugins son **core options**; además, RetroArch permite **opciones por
  juego** (`*.opt`). Se puede usar el perfil por CRC cuando no haya core option explícita.
- **Amiga**: `IPatternCache`/`IScrollingLayer` aceptan `bpp` (3/4) y la paleta extendida se
  aplica por Copper/Dual Playfield (ver [`../platform/amiga/services.hpp`](../platform/amiga/services.hpp)).

## Garantías

1. **La emulación no cambia**: CPU, mapper, conteo de ciclos, attributes y lógica de tiles
   siguen idénticos; solo se sustituye *qué píxeles* produce cada tile y *qué color* se mapea.
2. **Opt-in y por ROM**: sin perfil, nada cambia (probado).
3. **Determinismo**: los packs son datos; la validación diferencial sigue aplicando.

## Estado y siguientes pasos

- **HECHO**: interfaces (`ITileProvider`, `NesTileProvider`), perfiles (`RomProfile`,
  `parse_profile`), hook en la PPU con **proveedor 4 bpp probado**, paleta extendida en la
  conversión a RGB y en el plugin de vídeo.
- **PENDIENTE**: cargador real de packs (tileset 4 bpp + paleta desde fichero), búsqueda por
  CRC en los frontends y core options por juego en RetroArch.
