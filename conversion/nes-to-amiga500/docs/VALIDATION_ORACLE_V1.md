# Validación del oráculo

- commit: `bef109e`
- tag: `oracle-v1-1-gbef109e`
- fecha: 2026-09-27T06:03Z

## Suite (`test/run.sh`)
```
Ciclos OK
[5/5] sistema NES + HLE
system: mapper=0 frames=60 vram_nz=1920 HLE=2703 fb=79 ratio=971/1000
SYSTEM OK
[extra] primitivas HLE de raster (VBlank/sprite-0/retardo)
HLE raster OK (VBlank/sprite-0 + delay_cycles)
[extra] presupuesto y cobertura HLE (puerta: ratio HLE >= 80%)
ROM=/mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/conversion/nes-to-amiga500/runtime/../../../roms/nes/Balloon Fight (USA).nes frames=120
ciclos CPU 6502/frame : 29783   (NTSC 29780 -> 100%, PAL 33247 -> 90%)
HLE PPU               : 95.6% (3003 HLE / 139 fallback)
host                  : 33.9 ms total, 3535 fps (0.28 ms/frame)
[extra] ajustes por ROM (pack 4 bpp sin afectar a la emulacion)
  emulación idéntica; muestras de framebuffer distintas=634
ENHANCE OK
[extra] auditoria semantica: metodos de CPU vs interprete
CPU metodos OK (intérprete == metodos del codegen)
[extra] motor rapido: equivalencia + FPS (interprete vs pre-decodificado)
frames       : 120
direcciones  : 5220 decodificadas
interprete   : 33.9 ms  (3538.9 fps)
rapido       : 28.2 ms  (4258.3 fps)
aceleracion  : 1.20x
equivalencia : OK (ram_diff=0 fb_diff=0 regs=ok)
cpu (sin render): interp 94.8 Mips | rapido 140.0 Mips | 1.48x
[extra] telemetria de valores (--facts)
facts_from_run: 74 direcciones con valores -> /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/conversion/nes-to-amiga500/runtime/build/facts_nestest.txt
[extra] validacion diferencial con mesen
diff_mesen: ROM=Balloon Fight (USA).nes frames=60
diff_mesen: color=23.7%  estructura(lum)=0.0% (umbral 25.0%)
[extra] matriz de compatibilidad (subset, puerta de regresion)
| ROM | mapper | hash (oráculo) | estructura vs mesen |
|---|---:|---|---:|
| bf.nes | 0 | 04c3132d97e3672d | 0.0% |
| dk.nes | 0 | 7328b6a9584db4fd | 0.0% |
| dkjr.nes | 0 | 34f01ab01fd0d11f | 0.0% |
| galaga.nes | 0 | 1bca91d35b077dbb | 36.4% |
| ic.nes | 0 | a55551d254978383 | 92.2% |
| smb.nes | 0 | 698b602b6fb8f86f | 3.1% |
| xevious.nes | 0 | 3d7944c0da3f5263 | 4.4% |
RUNTIME OK
```

## Matriz de compatibilidad
| ROM | mapper | hash (oráculo) | estructura vs mesen |
|---|---:|---|---:|
| bf.nes | 0 | 04c3132d97e3672d | 0.0% |
| dk.nes | 0 | 7328b6a9584db4fd | 0.0% |
| dkjr.nes | 0 | 34f01ab01fd0d11f | 0.0% |
| exb.nes | 0 | 875ff9a0bca77295 | 0.0% |
| galaga.nes | 0 | 1bca91d35b077dbb | 36.4% |
| ic.nes | 0 | a55551d254978383 | 92.2% |
| kungfu.nes | 0 | c9be5cc53c87d813 | 0.0% |
| mariobros.nes | 0 | bede7c8b020a9bdb | 0.0% |
| mspacman.nes | 0 | d9883df6de0f2047 | 0.0% |
| pacman.nes | 0 | 6e9afde6b9ecf94f | 12.9% |
| popeye.nes | 0 | 41e76abab6c7fee7 | 0.0% |
| smb.nes | 0 | 698b602b6fb8f86f | 3.1% |
| xevious.nes | 0 | 3d7944c0da3f5263 | 4.4% |
