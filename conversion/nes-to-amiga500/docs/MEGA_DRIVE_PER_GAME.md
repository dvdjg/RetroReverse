# Qué rompe el VDP de Mega Drive, juego por juego

Análisis pedido: para cada juego "difícil", **qué elemento exacto** del hardware NES usa y por qué el
VDP de Mega Drive no lo puede replicar sin reescribir el motor. Base: [`HARD_GAMES.md`](HARD_GAMES.md).

## Límites duros del VDP de MD (recordatorio)

| NES | Mega Drive | Consecuencia |
|---|---|---|
| IRQ por scanline (MMC3/MMC5/VRC/fme7) | **sin IRQ de raster programable** | no se puede partir la pantalla por línea arbitraria |
| Cambio de CHR a mitad de frame | tiles en **VRAM rígida**, sin "bank switch" por fetch | no hay parallax/animación de tiles por raster |
| Paleta cambiable por scanline | paleta global + cambios por CRAM dots (no por línea) | no hay fundidos/color-cycling por línea |
| PPU lee CHR en cada píxel (render en vivo) | VDP lee tiles ya en VRAM | "efectos de PPU" no tienen equivalente |

## Por juego

| Juego | mapper | Efecto que lo hace difícil | Impacto en MD |
|---|---:|---|---|
| **Castlevania III (JP, VRC6)** | 24 | 3 canales de sonido extra + IRQ + CHR granular | sonido irreproducible sin reescribir música; IRQ no existe |
| **Castlevania III (US, MMC5)** | 5 | MMC5: multiplicador, RAM extra, split por IRQ, modos híbridos | motor gráfico entero a reimplementar |
| **Super Mario Bros. 3** | 4 | IRQ MMC3 para barra de estado + parallax falso + CHR banking por escena | HUD/split por raster imposible directo |
| **Kirby's Adventure** | 4 | IRQ MMC3 + CHR enorme (256K) + parallax | igual que SMB3, agravado por CHR |
| **Mega Man 3–6** | 4 | IRQ MMC3 para HUD + CHR banking + animación de fondo | HUD por raster |
| **Battletoads** | **7 (AxROM)** | **CHR-RAM** + raster extremo (efectos de scroll/ventana) | el efecto de "ventana" necesita render por línea |
| **Metal Storm** | 4 | scroll y cambio de personaje/tiles dependientes del raster | divisiones de pantalla por línea |
| **Gimmick! (Mr. Gimmick)** | 69 (FME-7) | IRQ FME-7 + sonido Sunsoft 5B + sprites/PPU finos | IRQ + sonido inexistentes |
| **Jurassic Park** | 4 | IRQ MMC3 para ventanas/parallax | ídem |
| **Ninja Gaiden II/III, Batman, Contra, Super C** | 4 / 2 | **streaming de CHR** (cambian bancos de tiles muy seguido) | VRAM más rígida; Contra (mapper 2) sí es viable |
| **Shatterhand, Tiny Toon, Adventure Island 3, Crystalis** | 4 | IRQ + CHR banking | ídem |
| **MMC5 (Uncharted Waters, Gemfire, Laser Invasion, Nobunaga II)** | 5 | multiplicador HW, RAM grande, modos gráficos | se usaría el multiplicador del 68000 (fácil) pero el modo gráfico no |

## Estrategia por dificultad

1. **Triviales en MD**: Contra, Super C (mapper 2). Solo requieren el flujo normal.
2. **Portables con trabajo**: juegos MMC1/UxROM sin raster (Metroid, Mega Man 1/2) → **tilemaps
   precalculados** + Blitter; se renuncia a efectos por línea.
3. **Necesitan técnicas MD nuevas**: MMC3/MMC5 con IRQ de raster → **bandas precalculadas** (como en
   Amiga) o reescritura del motor; el Blitter hace el scroll por bandas, pero sin IRQ por línea hay
   que reorganizar en ventanas fijas.
4. **Casi no-go**: VRC6 (sonido), Battletoads/Metal Storm/Gimmick (raster fino) → reescritura completa
   o port nativo.

## Conclusión práctica

Para MD, la **IRQ por scanline** del MMC3/MMC5/VRC es el muro principal; la solución real en MD es
**precalcular las divisiones en bandas fijas** (sin IRQ arbitraria) y usar el Blitter, lo que cambia
el "motor" respecto a un port directo. Por eso el **Amiga (Copper)** es un objetivo mucho más natural
para este pipeline: el Copper hace el trabajo por-línea **en hardware y en paralelo**.
