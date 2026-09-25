; ============================================================================
; sine_wobble/reference/sine_wobble_amiga.asm
;
; RUTINA ASM CANONICA del efecto de distorsion SINE de «Arte» (bloque 0x096A28).
; Desensamblado del binario (no es fuente del autor).
; sha1 del bloque: 79cdb836cd66e522ae7d034c5ea9add92604a0d5
;
; 0x150-0x2B0: init (carga SINE, AllocMem, SetInt, SetCopperAdr/Col).
; 0x3D0-0x3FE: init buffer + parametros.
; 0x400-0x478: construccion de la tabla de distorsion (or.l + lsl.l #$4).
; 0x702-0x764: parcheo de copperlist (42 filas x 11 registros, mask $FE).
; 0x766-0x82E: bucle por frame (8 osciladores en $38(a5) + copperlist).
; ============================================================================

; --- init ---
0150  .byte  0x00, 0x0c
0152  rts    
0154  movea.l (a7)+, a2
0156  jsr    -$11a(a6)
015A  move.w $1c(a0), d0
015E  or.w   d0, $16.l
0164  move.l #$53494e45, d0
016A  jsr    -$138(a6)
016E  move.l a0, $18(a5)
0172  move.l #$22f0, d0
0178  moveq  #$41, d1
017A  jsr    -$2a(a6)
017E  move.l d0, $54(a5)
0182  move.l d0, $7aa.l
0188  move.l d0, $7b2.l
018E  move.l #$22f0, d0
0194  moveq  #$41, d1
0196  jsr    -$2a(a6)
019A  move.l d0, $58(a5)
019E  move.l d0, $7ae.l
01A4  move.l #$818, d0
01AA  moveq  #$1, d1
01AC  jsr    -$2a(a6)
01B0  move.l d0, $5c(a5)
01B4  move.l #$8000, d0
01BA  moveq  #$1, d1
01BC  jsr    -$2a(a6)
01C0  move.l d0, $6c(a5)
01C4  move.l #$20000, d0
01CA  moveq  #$0, d1
01CC  jsr    -$2a(a6)
01D0  move.l d0, $60(a5)
01D4  move.l #$4000, d0
01DA  moveq  #$1, d1
01DC  jsr    -$2a(a6)
01E0  move.l d0, $64(a5)
01E4  move.l d0, $31e.l
01EA  move.l #$1ccea, d0
01F0  moveq  #$0, d1
01F2  jsr    -$2a(a6)
01F6  move.l d0, $68(a5)
01FA  movea.l $64(a5), a0
01FE  movea.l $18(a5), a4
0202  lea.l  $31a(pc), a0
0206  jsr    -$c(a4)
020A  lea.l  $30.l, a0
0210  move.l #$118, d0
0216  moveq  #$0, d1
0218  moveq  #$8, d2
021A  move.w #$120, d3
021E  jsr    -$72(a6)
0222  lea.l  $30.l, a0
0228  move.l #$138, d0
022E  moveq  #$5c, d1
0230  moveq  #$2, d2
0232  move.w #$120, d3
0236  jsr    -$72(a6)
023A  lea.l  $70.l, a0
0240  move.l $54(a5), d0
0244  moveq  #$0, d1
0246  moveq  #$4, d2
0248  move.w #$e0, d3
024C  jsr    -$72(a6)
0250  lea.l  $90.l, a0
0256  lea.l  $a30.l, a1
025C  moveq  #$1, d0
025E  moveq  #$f, d1
0260  jsr    -$9c(a6)
0264  bsr.w  $4fa
0268  lea.l  $cb0.l, a0
026E  movea.l $60(a5), a1
0272  adda.l #$10000, a3
0278  jsr    -$108(a6)
027C  bsr.w  $702
0280  bsr.w  $3d0
0284  bsr.w  $904
0288  bsr.w  $400
028C  jsr    $766.l
0292  movea.l $20(a5), a0
0296  movea.l $4(a0), a0
029A  jsr    (a0)
029C  movea.l $20(a5), a0
02A0  move.w $c(a0), d0
02A4  cmp.w  $10(a0), d0
02A8  bcs.b  $292
02AA  move.l #$3a8, $aaaa.w

; --- tabla de distorsion ---
03D0  movea.l $60(a5), a0
03D4  move.w #$7fff, d0
03D8  move.l #$4040404, d1
03DE  move.l d1, (a0)+
03E0  dbra   d0, $3de
03E4  move.w #$200, $32(a5)
03EA  move.w #$0, $34(a5)
03F0  move.w #$e000, $36(a5)
03F6  move.l #$2000, $50(a5)
03FE  rts    
0400  move.l #$20000, d0
0406  moveq  #$0, d1
0408  jsr    -$30(a6)
040C  move.l d0, $1c(a5)
0410  movea.l d0, a0
0412  movea.l d0, a3
0414  adda.l #$10000, a3
041A  movea.l a0, a1
041C  movea.l a3, a2
041E  move.l #$aaaaaaaa, d0
0424  move.w #$3fff, d1
0428  move.l d0, (a1)+
042A  move.l d0, (a2)+
042C  dbra   d1, $428
0430  adda.w #$400, a0
0434  adda.w #$400, a3
0438  moveq  #$f, d0
043A  lea.l  $47a(pc), a1
043E  moveq  #$f, d1
0440  lea.l  $47a(pc), a2
0444  move.l $40(a1), d4
0448  move.l (a1)+, d2
044A  add.l  d2, d2
044C  add.l  d2, d2
044E  add.l  d4, d4
0450  add.l  d4, d4
0452  move.l $40(a2), d5
0456  move.l (a2)+, d3
0458  or.l   d2, d3
045A  move.l d3, (a0)+
045C  lsl.l  #$4, d3
045E  move.l d3, (a0)+
0460  or.l   d4, d5
0462  move.l d5, (a3)+
0464  lsl.l  #$4, d5
0466  move.l d5, (a3)+
0468  dbra   d1, $452
046C  lea.l  $780(a0), a0
0470  lea.l  $780(a3), a3
0474  dbra   d0, $43e
0478  rts    
047A  ori.b  #$0, d0
047E  ori.b  #$aa, d0

; --- bucle/frame + copperlist ---
0700  rts    
0702  movea.l $60(a5), a1
0706  lea.l  $3c0(a1), a1
070A  movea.l $68(a5), a0
070E  moveq  #$2a, d0
0710  moveq  #$fe, d2
0712  moveq  #$b, d1
0714  move.w (a1)+, $2(a0)
0718  and.w  d2, $2(a0)
071C  move.w (a1)+, $6(a0)
0720  and.w  d2, $6(a0)
0724  move.w (a1)+, $c(a0)
0728  and.w  d2, $c(a0)
072C  move.w (a1)+, $10(a0)
0730  and.w  d2, $10(a0)
0734  move.w (a1)+, $3a(a0)
0738  and.w  d2, $3a(a0)
073C  move.w (a1)+, $3e(a0)
0740  and.w  d2, $3e(a0)
0744  move.w (a1)+, $44(a0)
0748  and.w  d2, $44(a0)
074C  move.w (a1)+, $48(a0)
0750  and.w  d2, $48(a0)
0754  lea.l  $70(a0), a0
0758  dbra   d1, $714
075C  lea.l  $1c(a0), a0
0760  dbra   d0, $712
0764  rts    
0766  movea.l $5c(a5), a0
076A  moveq  #$55, d0
076C  movem.l $f8.l, d1-d6
0774  move.l #$2000000, d7
077A  movem.l d1-d6, (a0)
077E  lea.l  $18(a0), a0
0782  add.l  d7, d1
0784  add.l  d7, d4
0786  dbra   d0, $77a
078A  movem.l $110.l, d0-d1
0792  movem.l d0-d1, (a0)
0796  lea.l  $e4.l, a0
079C  move.l $5c(a5), d0
07A0  moveq  #$1, d2
07A2  move.w #$84, d3
07A6  jmp    -$72(a6)
07AA  ori.b  #$0, d0
07AE  ori.b  #$0, d0
07B2  ori.b  #$0, d0
07B6  lea.l  $38(a5), a0
07BA  addi.w #$a, (a0)+
07BE  addi.w #$4, (a0)+
07C2  addi.w #$48, (a0)+
07C6  addi.w #$52, (a0)+
07CA  addi.w #$6, (a0)+
07CE  addi.w #$9, (a0)+
07D2  addi.w #$5, (a0)+
07D6  addi.w #$4, (a0)+
07DA  move.w #$200, d0
07DE  add.w  d0, $36(a5)
07E2  tst.b  $2(a5)
07E6  bne.b  $826
07E8  move.b #$1, $2(a5)
07EE  lea.l  $4(a5), a0
07F2  lea.l  $7aa(pc), a1
07F6  moveq  #$2, d0
07F8  movea.l $10(a5), a6
07FC  jsr    -$90(a6)
0800  movem.l (a0), a0-a1
0804  move.l a0, $8(a5)
0808  move.l a1, d0
080A  lea.l  $72.l, a0
0810  lea.l  $70.l, a0
0816  move.l #$8bc, d1
081C  moveq  #$4, d2
081E  move.w #$e0, d3
0822  jsr    -$72(a6)
0826  bsr.w  $848
082A  bsr.w  $848
082E  rts    