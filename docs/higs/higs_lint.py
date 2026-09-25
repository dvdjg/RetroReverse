#!/usr/bin/env python3
"""HIGS lint — validación y coherencia de una spec (ver docs/HIGS.md y ADR 0003).

Uso:
    python higs_lint.py <spec.json> [--schema game.schema.json] [--assets-dir assets/]

Valida la forma (JSON Schema) y aplica reglas de coherencia:
  R1  sin términos de hardware en la spec
  R3  los ids de evidencia citados existen en `evidence[]`
  R4  tick_hz coherente con at_tick
  R7  mapas: filas de igual longitud y legend completa

Salida: informe por regla; código de salida 1 si hay errores.
"""
import argparse
import json
import re
import sys
from pathlib import Path

# Términos que NO deben aparecer en una spec agnóstica de hardware.
HW_BLACKLIST = [
    r"\bZ80\b", r"\b68000\b", r"\bm68k\b", r"\b6502\b", r"\bPPU\b", r"\bAPU\b",
    r"\bDenise\b", r"\bAgnus\b", r"\bPaula\b", r"\bVRAM\b", r"\$DFF[0-9A-Fa-f]+",
    r"\bBPLCON", r"\bCOP1LC\b", r"\bblitter\b", r"\bcopperlist\b",
]
# Campos donde se permite el metadato de plataforma.
ALLOWED_HW_KEYS = {"platform_origin"}


def walk(obj, path=""):
    if isinstance(obj, dict):
        for k, v in obj.items():
            yield from walk(v, f"{path}/{k}")
    elif isinstance(obj, list):
        for i, v in enumerate(obj):
            yield from walk(v, f"{path}/{i}")
    else:
        yield path, obj


def check_schema(spec, schema_path, errors):
    try:
        import jsonschema
    except ImportError:
        print("  (aviso) jsonschema no instalado: se omite validación de esquema")
        return
    schema = json.loads(Path(schema_path).read_text(encoding="utf-8"))
    validator = jsonschema.Draft202012Validator(schema)
    for e in sorted(validator.iter_errors(spec), key=lambda e: list(e.path)):
        loc = "/".join(str(p) for p in e.path) or "<root>"
        errors.append(f"[schema] {loc}: {e.message}")


def check_hw(spec, errors):
    for path, val in walk(spec):
        if not isinstance(val, str):
            continue
        if path.strip("/").split("/")[0] in ALLOWED_HW_KEYS:
            continue
        for pat in HW_BLACKLIST:
            if re.search(pat, val):
                errors.append(f"[R1 hardware] {path}: '{val}' casa con /{pat}/")


def check_evidence(spec, errors):
    ids = {e.get("id") for e in spec.get("evidence", []) if isinstance(e, dict)}
    cited = set()
    for ent in spec.get("entities", []):
        cited.update(ent.get("evidence", []) or [])
    for r in spec.get("mechanics", {}).get("rules", []) or []:
        cited.update(r.get("evidence", []) or [])
    for c in sorted(cited - ids):
        errors.append(f"[R3 evidencia] id citado sin definir en evidence[]: '{c}'")


def check_ticks(spec, errors):
    if "tick_hz" not in spec:
        errors.append("[R4 ticks] falta tick_hz")
    for seq in spec.get("timing_sequences", []):
        for ev in seq.get("events", []):
            if "at_tick" in ev and not isinstance(ev["at_tick"], int):
                errors.append(f"[R4 ticks] {seq.get('id')}: at_tick no entero")


def check_maps(spec, errors):
    for m in spec.get("maps", []):
        grid = m.get("grid", [])
        widths = {len(row) for row in grid}
        if len(widths) > 1:
            errors.append(f"[R7 mapas] {m.get('id')}: filas de longitud distinta {sorted(widths)}")
        legend = set(m.get("legend", {}).keys())
        used = set("".join(grid))
        missing = used - legend
        if missing:
            errors.append(f"[R7 mapas] {m.get('id')}: legend sin caracteres {sorted(missing)}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("spec")
    ap.add_argument("--schema", default=str(Path(__file__).with_name("game.schema.json")))
    ap.add_argument("--assets-dir", default=None)
    args = ap.parse_args()

    spec = json.loads(Path(args.spec).read_text(encoding="utf-8-sig"))
    errors = []
    check_schema(spec, args.schema, errors)
    check_hw(spec, errors)
    check_evidence(spec, errors)
    check_ticks(spec, errors)
    check_maps(spec, errors)

    if errors:
        print(f"HIGS lint: {len(errors)} problema(s) en {args.spec}")
        for e in errors:
            print("  -", e)
        return 1
    print(f"HIGS lint: OK  ({args.spec})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
