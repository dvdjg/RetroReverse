#!/usr/bin/env bash
# _corpus.sh — construye el corpus de evaluación a partir de los artefactos ya
# generados por el pipeline NES->Amiga. Produce segmentos crudos por tipo:
#   m68k_text/   código 68000 (secciones .text enlazadas)
#   m68k_rodata/ datos constantes 68000 (.rodata)
#   nes_prg/     PRG-ROM 6502 cruda
#   nes_chr/     CHR-ROM (tiles) cruda
#   dll/         plugins .n2x x64nt (proxy del artefacto final a comprimir)
# No se versiona (external/ gitignored).
set -u
ROOT="$(cd "$(dirname "$0")" && pwd)"
NODE=/mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/conversion/nes-to-amiga500
BIN=/mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/vscode-amiga-debug/bin/win32/opt/bin
M68K="$BIN/m68k-amiga-elf-g++.exe"
OBJCOPY="$BIN/m68k-amiga-elf-objcopy.exe"
OUT="$ROOT/corpus"
rm -rf "$OUT"; mkdir -p "$OUT/m68k_text" "$OUT/m68k_rodata" "$OUT/nes_prg" "$OUT/nes_chr" "$OUT/dll"
WORK="$ROOT/_corpus_work"; mkdir -p "$WORK"

FLAGS=(-std=gnu++23 -O2 -m68000 -ffreestanding -fno-exceptions -fno-rtti
       -fno-threadsafe-statics -w -DN2A_NO_MAIN
       -I "$NODE/tools/m68k/shim" -I "$NODE/runtime/include" -I "$NODE/runtime/host")

echo "== [1/4] compilando C++ transpilado a m68k =="
for cpp in "$NODE"/transpiled/*.cpp; do
  base="$(basename "$cpp" .cpp)"
  case "$base" in n2a_game_impl|nes_transpiled*) continue;; esac
  obj="$WORK/$base.o"
  if ! "$M68K" "${FLAGS[@]}" -c "$cpp" -o "$obj" >"$WORK/$base.cc.log" 2>&1; then
    echo "  SKIP compile $base"; continue
  fi
  if "$M68K" -nostdlib -static -Wl,--entry=0 -Wl,-e,0 -o "$WORK/$base.elf" "$obj" >"$WORK/$base.ld.log" 2>&1; then
    src_elf="$WORK/$base.elf"
  else
    src_elf="$obj"   # sin enlazar: relocs a 0
  fi
  "$OBJCOPY" -O binary --only-section=.text   "$src_elf" "$OUT/m68k_text/$base.bin"   2>/dev/null
  "$OBJCOPY" -O binary --only-section=.rodata "$src_elf" "$OUT/m68k_rodata/$base.bin" 2>/dev/null
  t=$(wc -c <"$OUT/m68k_text/$base.bin" 2>/dev/null || echo 0)
  r=$(wc -c <"$OUT/m68k_rodata/$base.bin" 2>/dev/null || echo 0)
  echo "  $base: text=$t rodata=$r"
done

echo "== [2/4] PRG/CHR crudos desde .nes =="
python3 - "$OUT" "$NODE/runtime/build" <<'PY'
import os, sys, glob
out, build = sys.argv[1], sys.argv[2]
for nes in sorted(glob.glob(os.path.join(build, "*.nes"))):
    name = os.path.splitext(os.path.basename(nes))[0]
    with open(nes, "rb") as f:
        h = f.read(16)
        if len(h) < 16 or h[:4] != b"NES\x1a":
            continue
        prg = h[4] * 16384
        chr_ = h[5] * 8192
        trainer = 512 if (h[6] & 0x04) else 0
        f.seek(16 + trainer)
        if prg:
            open(os.path.join(out, "nes_prg", name + ".bin"), "wb").write(f.read(prg))
        if chr_:
            open(os.path.join(out, "nes_chr", name + ".bin"), "wb").write(f.read(chr_))
    print(f"  {name}: prg={prg} chr={chr_}")
PY

echo "== [3/4] plugins .n2x x64nt =="
for n2x in "$NODE"/transpiled/*.x64nt.n2x; do
  [ -e "$n2x" ] || continue
  b="$(basename "$n2x")"; cp "$n2x" "$OUT/dll/$b"
done
ls -1 "$OUT/dll" | sed 's/^/  /'

echo "== [4/4] resumen de tamaños del corpus =="
du -sb "$OUT"/* | sed 's/^/  /'
echo "FIN"
