# Validación del oráculo (v2.1)

> Snapshot del estado **`oracle-v2.1`** (kOracleVersion 4) tras la corrección de la matriz de 2026
> (`nes_frame` sin soporte de mappers nuevos → cifras de mappers nuevos eran basura; ver
> [`VERSIONS.md`](VERSIONS.md)). El record histórico de v1 está en
> [`VALIDATION_ORACLE_V1.md`](VALIDATION_ORACLE_V1.md).
>
> **Nota de determinismo**: `pacman` y `galaga` **varían entre ejecuciones** (son los juegos
> sensibles al límite de timing `$2002`); su diff pequeño fluctúa. `diff_mesen` marca como
> **`INCONCLUYENTE(pantalla-plan)`** los frames **monocromos** de pantalla de espera/intro (p. ej.
> Esper Dream 2 a 60 frames), que `port_matrix` muestra como **`flat`**.

## Suite (`test/run.sh`)
```
frames       : 120
direcciones  : 5220 decodificadas
interprete   : 56.7 ms  (2115.0 fps)
rapido       : 56.3 ms  (2132.9 fps)
aceleracion  : 1.01x
equivalencia : OK (ram_diff=0 fb_diff=0 regs=ok)
cpu (sin render): interp 54.8 Mips | rapido 60.4 Mips | 1.10x
[extra] telemetria de valores (--facts)
facts_from_run: 74 direcciones con valores -> /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/conversion/nes-to-amiga500/runtime/build/facts_nestest.txt
[extra] validacion diferencial con mesen
diff_mesen: ROM=Balloon Fight (USA).nes frames=60
diff_mesen: color=23.7%  estructura(lum)=0.0% (umbral 25.0%) colores=2/2
[extra] consistencia de mappers: nes_frame == frame_probe (por mapper)
OK: mapper 0 (bf.nes): nes_frame == frame_probe, interp == fast
OK: mapper 1 (metroid.nes): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)
OK: mapper 2 (castlevania.nes): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)
OK: mapper 3 (gradius.nes): nes_frame == frame_probe, interp == fast
OK: mapper 4 (megaman3.nes): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)
OK: mapper 5 (Gemfire (USA).nes): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)
OK: mapper 7 (Battletoads (USA).nes): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)
OK: mapper 24 (Akumajou Densetsu (Japan).nes): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)
OK: mapper 26 (Esper Dream 2 - Aratanaru Tatakai (Japan).nes): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)
OK: mapper 69 (Mr. Gimmick (Europe).nes): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)
mapper_consistency: OK (10 mappers)
[extra] matriz de compatibilidad (subset, puerta de regresion)
| ROM | mapper | hash (oráculo) | estructura vs mesen |
|---|---:|---|---:|
| Jurassic Park (USA).nes | 4 | b4f6ffdae7208829 | 0.0% |
| Mr. Gimmick (Europe).nes | 69 | 51632f4f913e6af1 | 0.0% |
| bf.nes | 0 | 04c3132d97e3672d | 0.0% |
| bioniccommando.nes | 1 | c01d2139c3342edd | 0.0% |
| dk.nes | 0 | 7328b6a9584db4fd | 0.0% |
| dkjr.nes | 0 | 34f01ab01fd0d11f | 0.0% |
| galaga.nes | 0 | 68b77106eb6725b1 | 1.9% |
| ic.nes | 0 | a55551d254978383 | 92.2% |
| jurassicpark.nes | 4 | b4f6ffdae7208829 | 0.0% |
| smb.nes | 0 | 698b602b6fb8f86f | 3.1% |
| smb3.nes | 4 | a950ee1dc1d5b483 | 0.4% |
| xevious.nes | 0 | f0ed5946ce96b963 | 0.0% |
RUNTIME OK
```

## Matriz de compatibilidad
| ROM | mapper | hash (oráculo) | estructura vs mesen |
|---|---:|---|---:|
| Adventure Island 3 (USA).nes | 4 | 5d038b0a606c8533 | 0.0% |
| Akumajou Densetsu (Japan).nes | 24 | 1f5d4d66f39313c3 | 2.7% |
| Batman - Return of the Joker (USA).nes | 69 | 5262cb44d08ec383 | 0.0% |
| Batman - The Video Game (USA).nes | 4 | fb3e71ebad8fa8f7 | 0.0% |
| Battletoads (USA).nes | 7 | 6d4f936f0bd88d81 | 1.9% |
| Castlevania III - Dracula's Curse (USA).nes | 5 | a174b99e10200e83 | 2.7% |
| Contra (USA).nes | 2 | b43e93ee563b00f1 | 0.9% |
| Crystalis (USA).nes | 4 | 8a8236eec0306f33 | 2.7% |
| Esper Dream 2 - Aratanaru Tatakai (Japan).nes | 26 | a55551d254978383 | flat |
| Gemfire (USA).nes | 5 | 5262cb44d08ec383 | 0.0% |
| Jurassic Park (USA).nes | 4 | b4f6ffdae7208829 | 0.0% |
| Kirby's Adventure (USA) (Rev A).nes | 4 | 328eec9c90919d81 | 0.4% |
| Laser Invasion (USA).nes | 5 | 063ba318cad1f5e3 | 3.1% |
| Mega Man 3 (USA).nes | 4 | 4eb841b0583bbb83 | 0.0% |
| Mega Man 4 (USA) (Rev A).nes | 4 | 729624b8d3285f43 | 2.6% |
| Mega Man 5 (USA).nes | 4 | 335d4236a41e1cbd | 0.0% |
| Mega Man 6 (USA).nes | 4 | 3843a7520e54c17d | 0.0% |
| Metal Storm (USA).nes | 4 | 82679d2512b7c06b | 14.2% |
| Mouryou Senki Madara (Japan).nes | 26 | a55551d254978383 | 99.9% |
| Mr. Gimmick (Europe).nes | 69 | 51632f4f913e6af1 | 0.0% |
| Ninja Gaiden II - The Dark Sword of Chaos (USA).nes | 4 | 5262cb44d08ec383 | 0.0% |
| Ninja Gaiden III - The Ancient Ship of Doom (USA).nes | 4 | 5262cb44d08ec383 | 0.0% |
| Nobunaga's Ambition II (USA).nes | 5 | ed6298a164ed5c6f | 0.0% |
| Shatterhand (USA).nes | 4 | 5012b52846c85bbd | 0.0% |
| Super C (USA).nes | 4 | d203d72fc6ccdcfd | 0.1% |
| Super Mario Bros. 3 (USA) (Rev A).nes | 4 | a950ee1dc1d5b483 | 0.4% |
| Tiny Toon Adventures (USA).nes | 4 | 4b838964cfde9dfd | 0.0% |
| Uncharted Waters (USA).nes | 5 | f6d6ea0a8e8edc9d | 45.8% |
| adventureisland3.nes | 4 | 5d038b0a606c8533 | 0.0% |
| bf.nes | 0 | 04c3132d97e3672d | 0.0% |
| bioniccommando.nes | 1 | c01d2139c3342edd | 0.0% |
| blastermaster.nes | 1 | 3c76ee3c6ee38c0f | 0.0% |
| castlevania.nes | 2 | d1b769801057969b | 0.0% |
| contra.nes | 2 | b43e93ee563b00f1 | 0.9% |
| crystalis.nes | 4 | 8a8236eec0306f33 | 2.7% |
| dk.nes | 0 | 7328b6a9584db4fd | 0.0% |
| dkjr.nes | 0 | 34f01ab01fd0d11f | 0.0% |
| ducktales.nes | 2 | 2322b9db55bbffe9 | 0.0% |
| exb.nes | 0 | 875ff9a0bca77295 | 0.0% |
| galaga.nes | 0 | 68b77106eb6725b1 | 1.9% |
| gradius.nes | 3 | d469bd3c363f13cb | 3.3% |
| ic.nes | 0 | a55551d254978383 | 92.2% |
| jurassicpark.nes | 4 | b4f6ffdae7208829 | 0.0% |
| kungfu.nes | 0 | c9be5cc53c87d813 | 0.0% |
| legendofzeldathe.nes | 1 | 93a5fe82e6c7355d | 0.0% |
| mariobros.nes | 0 | bede7c8b020a9bdb | 0.0% |
| megaman.nes | 2 | 267c824a48dbae2f | 0.0% |
| megaman2.nes | 1 | 7c173727e77aa95d | 0.0% |
| megaman3.nes | 4 | 4eb841b0583bbb83 | 0.0% |
| megaman4.nes | 4 | 729624b8d3285f43 | 2.6% |
| megaman5.nes | 4 | 335d4236a41e1cbd | 0.0% |
| megaman6.nes | 4 | 3843a7520e54c17d | 0.0% |
| metalstorm.nes | 4 | 82679d2512b7c06b | 14.2% |
| metroid.nes | 1 | 6d60cfca28c2626b | 0.0% |
| mspacman.nes | 0 | d9883df6de0f2047 | 0.0% |
| ninjagaiden.nes | 1 | 715560d48b6fd58b | 1.2% |
| ninjagaideniiitheancientshipofdoom.nes | 4 | 5262cb44d08ec383 | 0.0% |
| ninjagaideniithedarkswordofchaos.nes | 4 | 5262cb44d08ec383 | 0.0% |
| pacman.nes | 0 | 17bc5aca31367421 | 9.4% |
| popeye.nes | 0 | 41e76abab6c7fee7 | 0.0% |
| shatterhand.nes | 4 | 5012b52846c85bbd | 0.0% |
| smb.nes | 0 | 698b602b6fb8f86f | 3.1% |
| smb3.nes | 4 | a950ee1dc1d5b483 | 0.4% |
| superc.nes | 4 | d203d72fc6ccdcfd | 0.1% |
| tinytoonadventures.nes | 4 | 4b838964cfde9dfd | 0.0% |
| xevious.nes | 0 | f0ed5946ce96b963 | 0.0% |
