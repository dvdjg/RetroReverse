; reimpl/motor_3d/reference/orthonormalize_amiga.asm
; ---------------------------------------------------------------------------
; Rutina CANÓNICA: ortonormalización de matriz 3x3 por cross-product ("camera
; system"). Recompone una base ortonormal para evitar el *drift* acumulado.
;
; Origen : out/modules_all/blk_0B0C2C_l1_63064.bin
;          offsets 0x0E1E-0x0F1A (rutina) + 0x0F1C-0x0F60 (raíz entera)
; Base   : 0 (offsets del bloque). Desensamblado capstone (skipdata).
;
; CONTRATO (contrato de llamada):
;   Entrada : a0 = puntero a la matriz 3x3 (9 words, big-endian). SE MODIFICA in situ.
;             a1 = puntero a la matriz de salida (9 words).
;   Salida  : a1[0..2]  = fila0 normalizada
;             a1[3..5]  = fila1 normalizada
;             a1[6..8]  = fila2 = fila0 x fila1
;   Punto fijo: Q15 -> producto = (a*b*2)>>16 ; normalización = (x*32767)/|fila|
;   Preserva: d2-d7, a2   (movem.l d2-d7/a2,-(a7) ... movem.l (a7)+,d2-d7/a2)
;   Usa     : d0-d7, a0, a1, a2
;
; Algoritmo:
;   fila0 = fila1 x fila2 ; fila1 = fila2 x fila0 ; normalizar ambas ; fila2 = fila0' x fila1'
; ---------------------------------------------------------------------------

; --- fila0 = fila1 x fila2 (en a0[0..2]) ---
000E1E  movem.l d2-d7/a2,-(a7)      ; salva registros
000E22  movem.w $6(a0),d0-d5        ; d0,d1,d2=fila1 ; d3,d4,d5=fila2
000E28  lea.l   (a0),a2             ; destino = a0[0]
000E2A  move.w  d1,d6
000E2C  muls.w  d5,d6               ; d1*d5
000E2E  move.w  d2,d7
000E30  muls.w  d4,d7               ; d2*d4
000E32  sub.l   d7,d6               ; d1*d5 - d2*d4
000E34  add.l   d6,d6
000E36  swap    d6
000E38  move.w  d6,(a2)+            ; a0[0] = Q15(f1y*f2z - f1z*f2y)
000E3A  muls.w  d3,d2
000E3C  muls.w  d0,d5
000E3E  sub.l   d5,d2               ; d2*d3 - d0*d5
000E40  add.l   d2,d2
000E42  swap    d2
000E44  move.w  d2,(a2)+            ; a0[1] = Q15(f1z*f2x - f1x*f2z)
000E46  muls.w  d0,d4
000E48  muls.w  d1,d3
000E4A  sub.l   d3,d4               ; d0*d4 - d1*d3
000E4C  add.l   d4,d4
000E4E  swap    d4
000E50  move.w  d4,(a2)             ; a0[2] = Q15(f1x*f2y - f1y*f2x)

; --- fila1 = fila2 x fila0 (en a0[3..5]) ---
000E52  movem.w $c(a0),d0-d2        ; d0,d1,d2 = fila2 (original)
000E58  movem.w (a0),d3-d5          ; d3,d4,d5 = fila0 (recién calculada)
000E5C  lea.l   $6(a0),a2           ; destino = a0[3]
000E60  move.w  d1,d6
000E62  muls.w  d5,d6
000E64  move.w  d2,d7
000E66  muls.w  d4,d7
000E68  sub.l   d7,d6
000E6A  add.l   d6,d6
000E6C  swap    d6
000E6E  move.w  d6,(a2)+            ; a0[3] = Q15(f2y*f0z - f2z*f0y)
000E70  muls.w  d3,d2
000E72  muls.w  d0,d5
000E74  sub.l   d5,d2
000E76  add.l   d2,d2
000E78  swap    d2
000E7A  move.w  d2,(a2)+            ; a0[4] = Q15(f2z*f0x - f2x*f0z)
000E7C  muls.w  d0,d4
000E7E  muls.w  d1,d3
000E80  sub.l   d3,d4
000E82  add.l   d4,d4
000E84  swap    d4
000E86  move.w  d4,(a2)             ; a0[5] = Q15(f2x*f0y - f2y*f0x)

; --- normalizar fila0 -> a1[0..2] ---
000E88  movea.l a1,a2               ; destino = a1
000E8A  movem.w (a0)+,d0-d2         ; d0,d1,d2 = fila0 ; a0 += 6
000E8E  move.w  d0,d3
000E90  swap    d3
000E92  clr.w   d3
000E94  asr.l   #$1,d3
000E96  sub.l   d0,d3               ; d3 = d0*32768 - d0 = d0*32767
000E98  move.w  d1,d4
000E9A  swap    d4
000E9C  clr.w   d4
000E9E  asr.l   #$1,d4
000EA0  sub.l   d1,d4               ; d4 = d1*32767
000EA2  move.w  d2,d5
000EA4  swap    d5
000EA6  clr.w   d5
000EA8  asr.l   #$1,d5
000EAA  sub.l   d2,d5               ; d5 = d2*32767
000EAC  bsr.b   $f1c                ; d0 = |fila0| (raíz de d0^2+d1^2+d2^2)
000EAE  divs.w  d0,d3
000EB0  divs.w  d0,d4
000EB2  divs.w  d0,d5
000EB4  move.w  d3,(a2)+            ; a1[0] = f0x*32767/|fila0|
000EB6  move.w  d4,(a2)+            ; a1[1]
000EB8  move.w  d5,(a2)+            ; a1[2]

; --- normalizar fila1 -> a1[3..5] ---
000EBA  movem.w (a0)+,d0-d2         ; d0,d1,d2 = fila1 ; a0 += 6
000EBE  move.w  d0,d3
000EC0  swap    d3
000EC2  clr.w   d3
000EC4  asr.l   #$1,d3
000EC6  sub.l   d0,d3
000EC8  move.w  d1,d4
000ECA  swap    d4
000ECC  clr.w   d4
000ECE  asr.l   #$1,d4
000ED0  sub.l   d1,d4
000ED2  move.w  d2,d5
000ED4  swap    d5
000ED6  clr.w   d5
000ED8  asr.l   #$1,d5
000EDA  sub.l   d2,d5
000EDC  bsr.b   $f1c
000EDE  divs.w  d0,d3
000EE0  divs.w  d0,d4
000EE2  divs.w  d0,d5
000EE4  move.w  d3,(a2)+            ; a1[3] = f1x*32767/|fila1|
000EE6  move.w  d4,(a2)+            ; a1[4]
000EE8  move.w  d5,(a2)+            ; a1[5]

; --- fila2 = fila0' x fila1' -> a1[6..8] ---
000EEA  movem.w (a1),d0-d5          ; d0..d2 = a1[0..2] ; d3..d5 = a1[3..5]
000EEE  move.w  d1,d6
000EF0  muls.w  d5,d6
000EF2  move.w  d2,d7
000EF4  muls.w  d4,d7
000EF6  sub.l   d7,d6
000EF8  add.l   d6,d6
000EFA  swap    d6
000EFC  move.w  d6,(a2)+            ; a1[6]
000EFE  muls.w  d3,d2
000F00  muls.w  d0,d5
000F02  sub.l   d5,d2
000F04  add.l   d2,d2
000F06  swap    d2
000F08  move.w  d2,(a2)+            ; a1[7]
000F0A  muls.w  d0,d4
000F0C  muls.w  d1,d3
000F0E  sub.l   d3,d4
000F10  add.l   d4,d4
000F12  swap    d4
000F14  move.w  d4,(a2)             ; a1[8]
000F16  movem.l (a7)+,d2-d7/a2
000F1A  rts

; --- raíz entera (floor): d0 = sqrt(d0^2 + d1^2 + d2^2) ---
; (suma de cuadrados 32-bit y algoritmo de raíz "a mano", 16 iteraciones)
000F1C  muls.w  d0,d0
000F1E  muls.w  d1,d1
000F20  muls.w  d2,d2
000F22  add.l   d0,d2               ; d2 = d0^2 + d1^2 + d2^2
000F24  add.l   d1,d2
000F26  moveq   #$f,d7              ; 16 iteraciones
000F28  move.l  #$40000000,d0       ; bit = 1<<30
000F2E  move.l  d2,d1
000F30  clr.w   d1
000F32  swap    d1
000F34  swap    d0
000F36  sub.l   d0,d1
000F38  bcc.b   $f4e
000F3A  add.l   d0,d1
000F3C  swap    d0
000F3E  add.w   d0,d0
000F40  add.w   d2,d2
000F42  addx.l  d1,d1
000F44  add.w   d2,d2
000F46  addx.l  d1,d1
000F48  dbra    d7,$f34
000F4C  rts
000F4E  swap    d0
000F50  add.w   d0,d0
000F52  addq.w  #$1,d0
000F54  add.w   d2,d2
000F56  addx.l  d1,d1
000F58  add.w   d2,d2
000F5A  addx.l  d1,d1
000F5C  dbra    d7,$f34
000F60  rts

; ---------------------------------------------------------------------------
; Reimplementación de referencia en C++: src/transform3d.cpp::orthonormalize()
; + isqrt32(). Ver README.md (sección «Contrato») y docs/GHIDRA_DECOMP_VS_REIMPL.md §3.1.
