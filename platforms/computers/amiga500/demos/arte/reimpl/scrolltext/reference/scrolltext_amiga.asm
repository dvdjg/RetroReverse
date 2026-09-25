; ============================================================================
; scrolltext/reference/scrolltext_amiga.asm
;
; RUTINA ASM del scrolltext de «Arte» (bloque 0x02162C). Desensamblado del binario.
; sha1 del bloque: 198b23f547b7d3bef3c47999aad8177394d78a88
;
; 0x196E-0x1A70: render del scrolltext (mapa de chars en $1a80, glifos en
;                 ~0x2800, bitplanes en $60000, 3 planos, 8 filas).
; 0x1A80: mapa de caracteres (43).
; ============================================================================

; --- mapa de caracteres ---
; 0x1A80: ' abcdefghijklmnopqrstuvwxyz0123456789.,!?:-\x00'

; --- rutina de render (0x196E-0x1A70) ---
0196E  tst.w  $1a7e.l
01974  beq.b  $1988
01976  btst.b #$6, $bfe001.l
0197E  bne.b  $1986
01980  clr.w  $1a7e.l
01986  rts    
01988  lea.l  $352a.l, a0
0198E  adda.l $1a72.l, a0
01994  addq.l #$1, $1a72.l
0199A  move.b (a0)+, d0
0199C  cmpi.b #$1, (a0)
019A0  bne.b  $19b2
019A2  subq.l #$1, $1a72.l
019A8  move.w #$3, $276.l
019B0  rts    
019B2  tst.b  (a0)
019B4  bne.b  $19c0
019B6  moveq  #$0, d1
019B8  subq.l #$1, $1a72.l
019BE  bra.b  $19d8
019C0  lea.l  $1a80(pc), a1
019C4  move.l #$2b, d1
019CA  cmp.b  (a1)+, d0
019CC  dbeq   d1, $19ca
019D0  neg.w  d1
019D2  addi.l #$2b, d1
019D8  lea.l  $30e9(pc), a2
019DC  adda.w d1, a2
019DE  lea.l  $60000.l, a3
019E4  adda.l $1a76.l, a3
019EA  adda.l $1a7a.l, a3
019F0  addq.l #$1, $1a7a.l
019F6  moveq  #$2, d7
019F8  move.b $0(a2), $0(a3)
019FE  move.b $2c(a2), $50(a3)
01A04  move.b $58(a2), $a0(a3)
01A0A  move.b $84(a2), $f0(a3)
01A10  move.b $b0(a2), $140(a3)
01A16  move.b $dc(a2), $190(a3)
01A1C  move.b $108(a2), $1e0(a3)
01A22  move.b $134(a2), $230(a3)
01A28  lea.l  $160(a2), a2
01A2C  lea.l  $5000(a3), a3
01A30  dbra   d7, $19f8
01A34  cmpi.l #$50, $1a7a.l
01A3E  bne.b  $1a70
01A40  addq.l #$1, $1a72.l
01A46  clr.l  $1a7a.l
01A4C  addi.l #$320, $1a76.l
01A56  cmpi.l #$4e20, $1a76.l
01A60  bne.b  $1a70
01A62  clr.l  $1a76.l
01A68  move.w #$1, $1a7e.l