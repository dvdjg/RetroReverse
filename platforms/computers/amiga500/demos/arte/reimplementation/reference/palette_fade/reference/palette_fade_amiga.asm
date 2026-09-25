; ============================================================================
; palette_fade/reference/palette_fade_amiga.asm
;
; RUTINA ASM del fade de paleta por nibbles de «Arte» (bloque 0x0B0C2C).
; sha1 del bloque: b37f140c327309db4e8f2894ad100b9018144302
;
; 0x031C-0x03E2: por cada color, acerca nibble a nibble R/G/B hacia el objetivo
;   (+1 = B, +0x10 = G, +0x100 = R), controlado por contador de frames ($3f0).
; ============================================================================

00310  bsr.b  $31c
00312  tst.b  $3ec.l
00318  bne.b  $2dc
0031A  rts    
0031C  tst.w  $3f0.l
00322  beq.b  $32e
00324  subq.w #$1, $3f0.l
0032A  bra.w  $3e2
0032E  move.w $3ee(pc), $3f0.l
00336  tst.b  $3ec.l
0033C  bne.b  $342
0033E  bra.w  $3e2
00342  subq.b #$1, $3ec.l
00348  movea.l $3e8(pc), a1
0034C  movea.l $3e4(pc), a0
00350  addq.w #$2, a0
00352  cmpi.w #$180, -$2(a0)
00358  blt.b  $3be
0035A  cmpi.w #$1c0, -$2(a0)
00360  bge.b  $3be
00362  move.w (a0), d0
00364  move.w (a1)+, d2
00366  move.w d0, d1
00368  move.w d2, d3
0036A  and.w  #$f, d1
0036E  and.w  #$f, d3
00372  cmp.w  d1, d3
00374  beq.b  $37e
00376  blt.b  $37c
00378  addq.w #$1, (a0)
0037A  bra.b  $37e
0037C  subq.w #$1, (a0)
0037E  move.w d0, d1
00380  move.w d2, d3
00382  lsr.w  #$4, d1
00384  lsr.w  #$4, d3
00386  and.w  #$f, d1
0038A  and.w  #$f, d3
0038E  cmp.w  d1, d3
00390  beq.b  $39e
00392  blt.b  $39a
00394  addi.w #$10, (a0)
00398  bra.b  $39e
0039A  subi.w #$10, (a0)
0039E  move.w d0, d1
003A0  move.w d2, d3
003A2  lsr.w  #$8, d1
003A4  lsr.w  #$8, d3
003A6  and.w  #$f, d1
003AA  and.w  #$f, d3
003AE  cmp.w  d1, d3
003B0  beq.b  $3be
003B2  blt.b  $3ba
003B4  addi.w #$100, (a0)
003B8  bra.b  $3be
003BA  subi.w #$100, (a0)
003BE  lea.l  $4(a0), a0
003C2  cmpi.w #$84, -$2(a0)
003C8  bne.b  $3d6
003CA  move.w (a0), d0
003CC  swap   d0
003CE  move.w $4(a0), d0
003D2  addq.w #$2, d0
003D4  movea.l d0, a0
003D6  cmpi.l #$fffffffe, -$2(a0)
003DE  bne.w  $352
003E2  rts    