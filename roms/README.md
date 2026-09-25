# `roms/` — recepción de ROMs propias (contenido NO versionado)

Carpeta de **recepción** para las ROMs/imágenes que se van a analizar. El **contenido binario
nunca se versiona** (ver [`../docs/LEGAL.md`](../docs/LEGAL.md)); solo se conserva esta estructura
(`README.md`/`.gitkeep`).

Suelta aquí los ficheros por sistema y luego se promueven al nodo del juego que corresponda
(`platforms/<categoría>/<plataforma>/.../<game_id>/rom/raw/`), que ya está ignorado por git.

| Subcarpeta | Qué va | Formatos habituales | Nodo destino (ejemplo) |
|---|---|---|---|
| `arcade/` | Romsets MAME (=1 `*.zip` por juego) | `*.zip` (`pacman.zip`, …) | `platforms/arcade/dedicated/namco_pacman/pacman/rom/raw/` |
| `nes/` | Juegos NES (extraídos del zip) | `*.nes`, `*.fds` | `platforms/consoles/nes/rom/raw/` |
| `megadrive/` | Mega Drive / Genesis (extraídos) | `*.md`, `*.bin`, `*.gen` | `platforms/consoles/megadrive/rom/raw/` |
| `amiga/` | Discos Amiga + kickstarts | `*.adf`, `*.ipf`, `*.dms`, `*.hdf` | `platforms/computers/amiga500/rom/raw/` |
| `mastersystem/`, `gamegear/` | Master System / Game Gear (extraídos) | `*.sms`, `*.gg` | (nodo a crear) |
| `atari2600/` | Atari 2600 (extraídos) | `*.a26`, `*.bin` | (nodo a crear) |
| `gb/`, `gbc/` | Game Boy / Color (extraídos) | `*.gb`, `*.gbc` | (nodo a crear) |
| `misc/` | Otras plataformas futuras | según core | nodo a crear |

## Selección automática

[`scripts/select-roms.py`](../scripts/select-roms.py) copia/extrae una **selección curada** desde
una colección externa (por defecto `/mnt/f/roms`) a estas carpetas y regenera
[`docs/ROM_SELECTION.md`](../docs/ROM_SELECTION.md) (tabla versionada con sha1):

```powershell
python scripts/select-roms.py            # usa /mnt/f/roms
python scripts/select-roms.py /ruta/roms # otra colección
```

La selección actual: MAME pre-1991 (Pac-Man, Defender, G'n'G, …), NES clásicos, Mega Drive y Amiga.

## Convenciones

- **Un juego = un romset/fichero** (no mezclar sets). Para arcade, el `.zip` debe ser el set
  esperado por el core (p. ej. `mame2003-plus` para Pac-Man: `pacman.zip`).
- Si un sistema necesita **BIOS** (p. ej. `neogeo.zip`, `syscard3.pce`), ponerla también en su
  carpeta de sistema y avisar (el adaptador libretro pasa `system/` al core).
- Anotar **origen/versión** de cada ROM (dumpeo propio, región, revisión) cuando se promueva al
  nodo, en el `README.md` del nodo, **sin** commitear el binario.
- El pipeline de orquestador recibe la ruta al fichero directamente; no importa que esté en
  `roms/` o en el `rom/raw/` del nodo.
