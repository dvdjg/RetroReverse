#!/usr/bin/env python3
"""Selecciona ROMs propias desde una colección externa y las copia/extrae a roms/.

- Arcade (MAME): se copia el `*.zip` tal cual (los cores MAME leen zip).
- Consolas/ordenador: se extrae el ROM del zip (nuestro frontend headless aún no lee zip).
- Genera `docs/ROM_SELECTION.md` (curado, versionado) con la tabla de lo elegido.
- El contenido va a `roms/<sistema>/` (ignorado por git; ver .gitignore).

Uso: scripts/select-roms.py [SRC]      (SRC por defecto: /mnt/f/roms)
"""
import hashlib
import re
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("/mnt/f/roms")
DST = ROOT / "roms"
DOC = ROOT / "docs" / "ROM_SELECTION.md"

# --- Arcade: nombre de romset (= nombre del .zip), pre-1991 y clásicos ---
ARCADE = [
    "pacman", "mspacman", "defender", "phoenix", "atetris", "gng", "ghouls",
    "goldnaxe", "altbeast", "rtype", "buggyboy", "ddragon", "ddragon2",
    "shinobi", "gauntlet", "gauntlet2p", "vigilant",
    # Ampliación (2026): clásicos y serie Capcom/Strikers
    "robocop", "1943", "1944", "s1945", "rastan", "sf2", "sfiii", "sfiii3", "blktiger",
]

# --- Consolas: sistema -> [(patrón de zip, extensión preferida)] ---
CONSOLES = {
    "nes": [
        ("Super Mario Bros. (World)", (".nes", ".unf")),
        ("Donkey Kong (World) (Rev A)", (".nes",)),
        ("Donkey Kong Jr. (World) (Rev A)", (".nes",)),
        ("Mario Bros. (World)", (".nes",)),
        ("Pac-Man (USA) (Namco)", (".nes",)),
        ("Ms. Pac-Man (USA)", (".nes",)),
        ("Galaga - Demons of Death (USA)", (".nes",)),
        ("Excitebike (Japan, USA)", (".nes",)),
        ("Balloon Fight (USA)", (".nes",)),
        ("Ice Climber (USA, Europe)", (".nes",)),
        ("Kung Fu (Japan, USA)", (".nes",)),
        ("Popeye (World) (Rev A)", (".nes",)),
        ("Xevious - The Avenger (USA)", (".nes",)),
    ],
    "megadrive": [
        ("Altered Beast (USA, Europe)", (".bin", ".md", ".gen")),
        ("Golden Axe (World).zip", (".bin", ".md", ".gen")),
        ("Ghouls'n Ghosts (USA, Europe)", (".bin", ".md", ".gen")),
        ("Space Harrier II (World)", (".bin", ".md", ".gen")),
        ("Super Thunder Blade (World)", (".bin", ".md", ".gen")),
        ("Last Battle (USA, Europe)", (".bin", ".md", ".gen")),
        ("Revenge of Shinobi, The (USA, Europe)", (".bin", ".md", ".gen")),
        ("Pac-Mania (USA, Europe)", (".bin", ".md", ".gen")),
    ],
    "atari2600": [
        ("Adventure (1978) (Atari)", (".a26", ".bin")),
        ("Combat (1977) (Atari)", (".a26", ".bin")),
        ("Pitfall II - Lost Caverns (1984) (Activision)", (".a26", ".bin")),
        ("River Raid (1982) (Activision)", (".a26", ".bin")),
    ],
    "mastersystem": [
        ("Alex Kidd in Miracle World (USA, Europe) (Rev 1)", (".sms", ".bin")),
        ("Wonder Boy (USA, Europe)", (".sms", ".bin")),
        ("Sonic The Hedgehog (USA, Europe)", (".sms", ".bin")),
    ],
    "gamegear": [
        ("Columns (USA, Europe)", (".gg", ".bin")),
        ("Sonic Chaos (USA, Europe)", (".gg", ".bin")),
    ],
    "gb": [
        ("Tetris (World) (Rev A)", (".gb",)),
        ("Super Mario Land (World)", (".gb",)),
        ("Alleyway (World)", (".gb",)),
        ("Dr. Mario (World) (Rev A)", (".gb",)),
    ],
    "gbc": [
        ("Tetris DX (World) (SGB Enhanced) (GB Compatible)", (".gbc",)),
        ("Wario Land II (USA, Europe) (SGB Enhanced) (GB Compatible)", (".gbc",)),
        ("Metal Gear Solid (USA)", (".gbc",)),
    ],
}

# --- Amiga 500 (bajo subcarpetas por letra) ---
AMIGA = [
    "Wizball", "Buggy Boy", "Pac-Mania", "Bubble Bobble",
    # Ampliación (2026)
    "Jim Power in Mutant Planet", "James Pond - Underwater Agent",
    "James Pond 2 - Codename RoboCod", "James Pond 3 - Operation Starfish",
    "Mega Typhoon", "Xenon 2 - Megablast",
    "Black Tiger",
    # Discos adicionales (multi-disco)
    "Jim Power in Mutant Planet_Disk2", "Xenon 2 - Megablast_Disk2",
    "James Pond 3 - Operation Starfish (AGA)_Disk2",
    "James Pond 3 - Operation Starfish (AGA)_Disk3",
]

# --- FBNeo: mismos títulos para la ruta FBNeo (sets propios) ---
FBNEO = ["robocop", "1943", "1944", "s1945", "rastan", "sf2", "sfiii", "sfiii3", "blktiger", "mslug", "mslug3"]
FBNEO_BIOS = ["cps3", "neogeo"]  # BIOS compartidas (si existen en la colección)

# Algunos sistemas están repartidos en varias carpetas de la colección.
CONSOLE_DIRS = {"megadrive": ["megadrive", "genesis"]}

# Kickstarts necesarios por puae (desde F:\bios)
KICKSTARTS = ["kick34005.A500", "kick33180.A500", "kick39106.A1200"]


def sha1(path: Path) -> str:
    h = hashlib.sha1()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def find_zip(directory: Path, pattern: str, recursive: bool = False):
    if not directory.is_dir():
        return None
    it = directory.rglob("*.zip") if recursive else directory.glob("*.zip")
    matches = [p for p in it if pattern.lower() in p.name.lower()]
    if not matches:
        return None
    exact = [p for p in matches if p.name.lower() == f"{pattern.lower()}.zip"]
    return sorted(exact or matches, key=lambda p: p.name.lower())[0]


def extract(zpath: Path, dest_dir: Path, prefer_exts, friendly: str):
    dest_dir.mkdir(parents=True, exist_ok=True)
    skip = {".txt", ".xml", ".nfo", ".md", ".dat", ".sfv"}
    with zipfile.ZipFile(zpath) as z:
        names = [n for n in z.namelist() if not n.endswith("/")]
        exts = tuple(e.lower() for e in prefer_exts)
        chosen = [n for n in names if Path(n).suffix.lower() in exts]
        if not chosen:
            chosen = [n for n in names if Path(n).suffix.lower() not in skip]
        member = sorted(chosen or names)[0]
        base = Path(member).name
        if Path(base).suffix.lower() not in exts:
            base = re.sub(r"[^\w.\-]+", "_", friendly) + exts[0]
        out = dest_dir / base
        out.write_bytes(z.read(member))
    return out, member


def main():
    rows = []  # (sistema, salida, origen, miembro, bytes, sha1)
    missing = []

    # Arcade (copia tal cual)
    for name in ARCADE:
        src = SRC / "arcade" / f"{name}.zip"
        if not src.is_file():
            missing.append(f"arcade/{name}.zip"); continue
        (DST / "arcade").mkdir(parents=True, exist_ok=True)
        out = DST / "arcade" / src.name
        out.write_bytes(src.read_bytes())
        rows.append(("arcade", out.relative_to(ROOT), src.relative_to(SRC.parent),
                     "-", out.stat().st_size, sha1(out)))

    # FBNeo (mismos títulos; sets propios para la ruta FBNeo)
    for name in FBNEO:
        src = SRC / "fbneo" / f"{name}.zip"
        if not src.is_file():
            missing.append(f"fbneo/{name}.zip"); continue
        (DST / "fbneo").mkdir(parents=True, exist_ok=True)
        out = DST / "fbneo" / src.name
        out.write_bytes(src.read_bytes())
        rows.append(("fbneo", out.relative_to(ROOT), src.relative_to(SRC.parent),
                     "-", out.stat().st_size, sha1(out)))

    # BIOS FBNeo (CPS3); se busca en varias carpetas de la colección.
    for name in FBNEO_BIOS:
        found = None
        for base in (SRC / "fbneo", SRC / "bios" / "fbneo", SRC / "bios"):
            cand = base / f"{name}.zip"
            if cand.is_file():
                found = cand
                break
        if found is None:
            missing.append(f"fbneo bios {name}.zip"); continue
        (DST / "fbneo").mkdir(parents=True, exist_ok=True)
        out = DST / "fbneo" / found.name
        out.write_bytes(found.read_bytes())
        rows.append(("fbneo(bios)", out.relative_to(ROOT), found.relative_to(SRC.parent),
                     "-", out.stat().st_size, sha1(out)))

    # Consolas
    for system, items in CONSOLES.items():
        dirs = CONSOLE_DIRS.get(system, [system])
        for pattern, exts in items:
            z = None
            for d in dirs:
                z = find_zip(SRC / d, pattern)
                if z is not None:
                    break
            if z is None:
                missing.append(f"{system}: {pattern}"); continue
            out, member = extract(z, DST / system, exts, pattern)
            rows.append((system, out.relative_to(ROOT), z.relative_to(SRC.parent),
                         member, out.stat().st_size, sha1(out)))

    # Amiga
    for pattern in AMIGA:
        z = find_zip(SRC / "amiga500", pattern, recursive=True)
        if z is None:
            missing.append(f"amiga500: {pattern}"); continue
        out, member = extract(z, DST / "amiga", (".adf", ".ipf", ".adz"), pattern)
        rows.append(("amiga", out.relative_to(ROOT), z.relative_to(SRC.parent),
                     member, out.stat().st_size, sha1(out)))
    for ks in KICKSTARTS:
        src = SRC.parent / "bios" / ks
        if src.is_file():
            (DST / "amiga").mkdir(parents=True, exist_ok=True)
            out = DST / "amiga" / ks
            out.write_bytes(src.read_bytes())
            rows.append(("amiga(bios)", out.relative_to(ROOT), src.relative_to(SRC.parent),
                         "-", out.stat().st_size, sha1(out)))
        else:
            missing.append(f"bios/{ks}")

    # Informe
    DOC.parent.mkdir(parents=True, exist_ok=True)
    lines = ["# Selección de ROMs (recepción local)", "",
             "Generado por [`scripts/select-roms.py`](../scripts/select-roms.py). "
             "El contenido binario **no** se versiona (vive en `roms/`, ignorado por git); "
             "esta tabla sí, para trazabilidad de la selección.", "",
             "| Sistema | Fichero en `roms/` | Origen | Miembro | Bytes | sha1 |",
             "|---|---|---|---|---:|---|"]
    for system, out, origin, member, size, digest in rows:
        o = str(origin).replace("\\", "/")
        lines.append(f"| {system} | `{out.as_posix()}` | `{o}` | `{member}` | {size} | `{digest[:12]}` |")
    if missing:
        lines += ["", "## No encontrados", ""] + [f"- {m}" for m in missing]
    DOC.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"Seleccionadas {len(rows)} ROMs -> {DST}")
    if missing:
        print(f"NO encontradas ({len(missing)}):")
        for m in missing:
            print("  -", m)


if __name__ == "__main__":
    main()
