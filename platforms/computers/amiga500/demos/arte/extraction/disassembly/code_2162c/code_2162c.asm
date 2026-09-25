; code_2162c desensamblado
; origen extraction/modules_all/blk_02162C
; len 45924 B
000000  jmp    $10.l
000006  jmp    $9a.l
00000C  ; data: 0x73, 0x6f
00000E  ; data: 0x73, 0x00
000010  movea.l $4.w, a6
000014  movea.l $114(a6), a4
000018  tst.l  $ac(a4)
00001C  bne.b  $38
00001E  lea.l  $5c(a4), a0
000022  jsr    -$180(a6)
000026  lea.l  $5c(a4), a0
00002A  jsr    -$174(a6)
00002E  move.l d0, $7a.l
000034  lea.l  $7e(pc), a2
000038  lea.l  $8e(pc), a1
00003C  moveq  #$0, d0
00003E  movea.l $4.w, a6
000042  jsr    -$228(a6)
000046  tst.l  d0
000048  beq.b  $62
00004A  movea.l d0, a6
00004C  move.l a6, -(a7)
00004E  lea.l  $9a.l, a0
000054  jsr    -$1e(a6)
000058  movea.l (a7)+, a1
00005A  movea.l $4.w, a6
00005E  jsr    -$19e(a6)
000062  move.l $7a(pc), d2
000066  beq.b  $76
000068  movea.l $4.w, a6
00006C  jsr    -$84(a6)
000070  movea.l d2, a1
000072  jsr    -$17a(a6)
000076  moveq  #$0, d0
000078  rts    
00007A  ori.b  #$0, d0
00007E  ori.b  #$0, d0
000082  ori.b  #$0, d0
000086  ori.b  #$0, d0
00008A  ori.b  #$0, d0
00008E  ; data: 0x73, 0x6f
000090  ; data: 0x73, 0x2e
000092  bge.b  $fd
000094  bhi.b  $108
000096  bsr.b  $10a
000098  ; data: 0x79, 0x00
00009A  moveq  #$8, d0
00009C  suba.l a0, a0
00009E  jsr    -$ba(a6)
0000A2  lea.l  $0.l, a5
0000A8  move.l a6, $0(a5)
0000AC  move.l a2, -(a7)
0000AE  jsr    -$11a(a6)
0000B2  movea.l a0, a2
0000B4  movea.l $26(a2), a0
0000B8  move.l a0, d0
0000BA  bne.b  $d2
0000BC  moveq  #$1c, d0
0000BE  moveq  #$0, d1
0000C0  jsr    -$2a(a6)
0000C4  movea.l d0, a0
0000C6  moveq  #$6, d1
0000C8  clr.l  (a0)+
0000CA  dbra   d1, $c8
0000CE  move.l d0, $26(a2)
0000D2  movea.l d0, a2
0000D4  move.l a2, $8(a5)
0000D8  tst.w  $e(a2)
0000DC  bne.b  $e4
0000DE  move.w #$f000, $e(a2)
0000E4  tst.l  $4(a2)
0000E8  bne.b  $104
0000EA  move.l #$44425547, d0
0000F0  jsr    -$138(a6)
0000F4  movea.l $8(a5), a1
0000F8  move.l a0, $18(a1)
0000FC  move.l #$114, $4(a2)
000104  tst.l  $8(a2)
000108  bne.b  $154
00010A  move.l #$12c, $8(a2)
000112  bra.b  $154
000114  move.l a5, -(a7)
000116  lea.l  $0.l, a5
00011C  movea.l $8(a5), a4
000120  movea.l $18(a4), a4
000124  jsr    -$c(a4)
000128  movea.l (a7)+, a5
00012A  rts    
00012C  move.l a5, -(a7)
00012E  lea.l  $0.l, a5
000134  movea.l $8(a5), a0
000138  btst.b #$2, $dff016.l
000140  bne.b  $14c
000142  move.w $e(a0), $c(a0)
000148  movea.l (a7)+, a5
00014A  rts    
00014C  movea.l (a7)+, a5
00014E  addq.w #$1, $c(a0)
000152  rts    
000154  movea.l (a7)+, a2
000156  bsr.w  $caa
00015A  movea.l $8(a5), a0
00015E  movea.l $4(a0), a0
000162  jsr    (a0)
000164  movea.l $8(a5), a0
000168  move.w $c(a0), d0
00016C  cmp.w  $10(a0), d0
000170  bcs.b  $15a
000172  bsr.w  $c50
000176  lea.l  $0.l, a0
00017C  lea.l  $204(pc), a1
000180  moveq  #$20, d0
000182  jsr    -$54(a6)
000186  lea.l  $dff002.l, a4
00018C  cmpi.w #$1, $276.l
000194  bne.b  $1ae
000196  bsr.w  $1abe
00019A  move.l #$198, $dff080.l
0001A4  move.w #$2, $276.l
0001AC  bra.b  $1b8
0001AE  cmpi.w #$32, $2e6.l
0001B6  blt.b  $18c
0001B8  jsr    -$11a(a6)
0001BC  movea.l $26(a0), a1
0001C0  cmpi.w #$13, $1c(a1)
0001C6  bne.b  $1d2
0001C8  cmpi.w #$2, $276.l
0001D0  bge.b  $1c8
0001D2  bsr.w  $278
0001D6  jsr    -$11a(a6)
0001DA  movea.l $26(a0), a1
0001DE  cmpi.w #$13, $1c(a1)
0001E4  beq.b  $200
0001E6  movea.l $8(a5), a0
0001EA  movea.l $4(a0), a0
0001EE  jsr    (a0)
0001F0  movea.l $8(a5), a0
0001F4  move.w $c(a0), d0
0001F8  cmp.w  $e(a0), d0
0001FC  bcs.w  $1d2
000200  moveq  #$0, d0
000202  rts    
000204  movem.l d0-d7/a0-a6, -(a7)
000208  lea.l  $0.l, a5
00020E  movea.l $0(a5), a6
000212  cmpi.w #$1, $276.l
00021A  bge.b  $23e
00021C  cmpi.w #$32, $2e6.l
000224  bgt.b  $23e
000226  move.b $bfec01.l, d0
00022C  not.b  d0
00022E  ror.b  #$1, d0
000230  cmp.b  #$1, d0
000234  bne.b  $23e
000236  move.w #$1, $276.l
00023E  movea.l $8(a5), a0
000242  movea.l $8(a0), a0
000246  jsr    (a0)
000248  cmpi.w #$2, $276.l
000250  bne.b  $258
000252  bsr.w  $196e
000256  bra.b  $266
000258  cmpi.w #$1, $276.l
000260  beq.b  $266
000262  bsr.w  $27a
000266  movem.l (a7)+, d0-d7/a0-a6
00026A  move.w #$30, $dff09c.l
000272  nop    
000274  rte    
000276  ori.b  #$75, d0
00027A  addq.w #$1, $2e6.l
000280  tst.w  $1b48.l
000286  bne.b  $2e4
000288  lea.l  $dff002.l, a5
00028E  bsr.w  $18d6
000292  bsr.w  $192e
000296  bsr.w  $7d4
00029A  lea.l  $dff002.l, a5
0002A0  bsr.w  $928
0002A4  bsr.w  $75e
0002A8  bsr.w  $b2a
0002AC  move.w #$2000, $dff09a.l
0002B4  lea.l  $1b56.l, a3
0002BA  move.l #$3ec03ec4, $384.l
0002C4  bsr.w  $2ea
0002C8  lea.l  $1c32.l, a3
0002CE  move.l #$4e714e71, $384.l
0002D8  bsr.w  $2ea
0002DC  move.w #$a000, $dff09a.l
0002E4  rts    
0002E6  ori.b  #$0, d0
0002EA  clr.l  $4e2.l
0002F0  move.l $d94.l, $4de.l
0002FA  lea.l  $dbc.l, a4
000300  movea.l $4de.l, a6
000306  move.l a7, $4da.l
00030C  lea.l  $8be.l, a7
000312  movem.l (a3)+, d0-d4
000316  subi.w #$fc00, d2
00031A  divs.w d2, d0
00031C  divs.w d2, d1
00031E  addi.w #$80, d1
000322  divs.w d2, d4
000324  cmpi.w #$4e71, $384.l
00032C  beq.b  $332
00032E  move.w d0, (a7)+
000330  move.w d4, (a7)+
000332  addi.w #$80, d4
000336  move.w d0, $4d4.l
00033C  move.w d1, $4d6.l
000342  move.w d4, $4d8.l
000348  btst.b #$e, (a5)
00034C  bne.b  $348
00034E  move.l #$ffffffff, $42(a5)
000356  move.l #$2, $62(a5)
00035E  move.l #$9f00000, $3e(a5)
000366  tst.l  d3
000368  bge.b  $370
00036A  moveq  #$ff, d7
00036C  bra.w  $4e6
000370  moveq  #$8, d7
000372  movem.l (a3)+, d0-d4
000376  subi.w #$fc00, d2
00037A  divs.w d2, d0
00037C  divs.w d2, d1
00037E  addi.w #$80, d1
000382  divs.w d2, d4
000384  move.w d0, (a7)+
000386  move.w d4, (a7)+
000388  addi.w #$80, d4
00038C  andi.l #$ffff, d4
000392  tst.l  d3
000394  bge.b  $39a
000396  bra.w  $4e6
00039A  movea.l $4de.l, a6
0003A0  adda.l d3, a6
0003A2  move.l d4, d2
0003A4  moveq  #$0, d5
0003A6  move.w $4d8(pc), d5
0003AA  sub.l  d5, d4
0003AC  move.w d2, $4d8.l
0003B2  swap   d2
0003B4  move.w $4d6(pc), d6
0003B8  sub.w  d1, d6
0003BA  moveq  #$0, d5
0003BC  move.w $4d4(pc), d5
0003C0  sub.w  d0, d5
0003C2  move.w d0, $4d4.l
0003C8  move.w d1, $4d6.l
0003CE  tst.w  d6
0003D0  beq.w  $4a8
0003D4  bgt.b  $3e2
0003D6  neg.w  d6
0003D8  move.w #$ffac, $492.l
0003E0  bra.b  $3ea
0003E2  move.w #$54, $492.l
0003EA  lsl.w  #$8, d5
0003EC  divu.w d6, d5
0003EE  move.w d5, $496.l
0003F4  move.l #$f000, d5
0003FA  divu.w d6, d5
0003FC  andi.l #$ffff, d5
000402  lsl.l  #$4, d5
000404  move.l d5, $49a.l
00040A  move.l d4, d5
00040C  asl.l  #$8, d5
00040E  asl.l  #$4, d5
000410  divs.w d6, d5
000412  andi.l #$ffff, d5
000418  tst.w  d5
00041A  bge.b  $422
00041C  ori.l  #$ffff0000, d5
000422  asl.l  #$4, d5
000424  move.l d5, $4a0.l
00042A  lsl.w  #$8, d0
00042C  mulu.w #$54, d1
000430  movea.l $191c.l, a1
000436  lea.l  $1a(a1, d1.w), a1
00043A  moveq  #$0, d5
00043C  moveq  #$40, d4
00043E  bra.b  $4a4
000440  tst.w  (a1)
000442  bne.b  $4a8
000444  move.w d0, d3
000446  clr.b  d3
000448  move.l d2, d1
00044A  swap   d1
00044C  add.w  d1, d1
00044E  add.w  d1, d1
000450  move.l (a4, d1.w), d1
000454  move.w d1, -$14(a1)
000458  swap   d1
00045A  add.w  d1, d3
00045C  move.l d5, d1
00045E  swap   d1
000460  lsl.w  #$5, d1
000462  lea.l  (a6, d1.w), a2
000466  move.w d3, -$10(a1)
00046A  add.w  d4, d3
00046C  move.w d3, -$c(a1)
000470  add.w  d4, d3
000472  move.w d3, -$8(a1)
000476  add.w  d4, d3
000478  move.w d3, -$4(a1)
00047C  btst.b #$e, (a5)
000480  bne.b  $47c
000482  move.l a2, $4e(a5)
000486  move.l a1, $52(a5)
00048A  move.w #$3c1, $56(a5)
000490  lea.l  $54(a1), a1
000494  addi.w #$0, d0
000498  addi.l #$0, d5
00049E  subi.l #$0, d2
0004A4  dbra   d6, $440
0004A8  cmp.w  #$8, d7
0004AC  beq.b  $4c2
0004AE  addi.l #$1e0, $4de.l
0004B8  addi.l #$3c0, $4e2.l
0004C2  dbra   d7, $372
0004C6  btst.b #$e, (a5)
0004CA  bne.b  $4c6
0004CC  movea.l $4da.l, a7
0004D2  rts    
0004D4  ori.b  #$0, d0
0004D8  ori.b  #$0, d0
0004DC  ori.b  #$0, d0
0004E0  ori.b  #$0, d0
0004E4  ori.b  #$7c, d0
0004E8  ; data: 0x00, 0xff
0004EA  bgt.w  $5f4
0004EE  cmp.l  #$ffffe000, d3
0004F4  blt.w  $602
0004F8  move.l d3, d5
0004FA  move.l -$10(a3), d3
0004FE  subi.l #$ffff6000, d3
000504  divs.w d2, d3
000506  addi.w #$80, d3
00050A  move.l d4, $75a.l
000510  move.w d1, d4
000512  sub.w  d3, d4
000514  neg.w  d4
000516  subq.w #$1, d4
000518  tst.w  d4
00051A  blt.w  $5ee
00051E  move.l a1, $752.l
000524  move.l a6, $756.l
00052A  movea.l $d94.l, a6
000530  neg.l  d5
000532  adda.l d5, a6
000534  mulu.w #$54, d3
000538  movea.l $191c.l, a1
00053E  lea.l  $1a(a1, d3.w), a1
000542  move.w d0, d5
000544  lsl.w  #$8, d5
000546  subi.w #$10, d5
00054A  move.l $75a.l, d3
000550  move.w d3, d6
000552  lsr.w  #$4, d3
000554  add.w  d3, d3
000556  add.w  d3, d5
000558  not.w  d6
00055A  andi.w #$f, d6
00055E  move.w d6, d3
000560  lsl.w  #$4, d3
000562  add.w  d6, d3
000564  move.w d5, $590.l
00056A  move.w d3, $5b0.l
000570  move.l #$1e000, d3
000576  divu.w d4, d3
000578  andi.l #$ffff, d3
00057E  lsl.l  #$4, d3
000580  move.l d3, $5d8.l
000586  moveq  #$0, d3
000588  bra.b  $5dc
00058A  tst.w  (a1)
00058C  bne.b  $5e0
00058E  move.w #$0, d5
000592  move.w d5, -$10(a1)
000596  addi.w #$40, d5
00059A  move.w d5, -$c(a1)
00059E  addi.w #$40, d5
0005A2  move.w d5, -$8(a1)
0005A6  addi.w #$40, d5
0005AA  move.w d5, -$4(a1)
0005AE  move.w #$0, -$14(a1)
0005B4  move.l d3, d6
0005B6  swap   d6
0005B8  lsl.w  #$5, d6
0005BA  lea.l  (a6, d6.w), a2
0005BE  btst.b #$e, (a5)
0005C2  bne.b  $5be
0005C4  move.l a2, $4e(a5)
0005C8  move.l a1, $52(a5)
0005CC  move.w #$3c1, $56(a5)
0005D2  lea.l  -$54(a1), a1
0005D6  addi.l #$10000, d3
0005DC  dbra   d4, $58a
0005E0  movea.l $752.l, a1
0005E6  movea.l $756.l, a6
0005EC  moveq  #$0, d3
0005EE  move.l $75a.l, d4
0005F4  move.l -$1c(a3), d3
0005F8  tst.w  d7
0005FA  bge.w  $39a
0005FE  bra.w  $370
000602  move.l d3, d5
000604  move.l -$10(a3), d3
000608  cmpi.w #$4e71, $384.l
000610  bne.b  $632
000612  addi.l #$ffff1000, d3
000618  divs.w d2, d3
00061A  addi.w #$80, d3
00061E  move.l d4, $75a.l
000624  move.w d3, d4
000626  sub.w  d1, d4
000628  move.w #$54, $71a.l
000630  bra.b  $650
000632  subi.l #$ffff1000, d3
000638  divs.w d2, d3
00063A  addi.w #$80, d3
00063E  move.l d4, $75a.l
000644  move.w d1, d4
000646  sub.w  d3, d4
000648  move.w #$ffac, $71a.l
000650  neg.w  d4
000652  subq.w #$1, d4
000654  tst.w  d4
000656  blt.w  $732
00065A  move.l a1, $752.l
000660  move.l a6, $756.l
000666  movea.l $d94.l, a6
00066C  adda.l $4e2.l, a6
000672  neg.l  d5
000674  adda.l d5, a6
000676  mulu.w #$54, d3
00067A  movea.l $191c.l, a1
000680  lea.l  $1a(a1, d3.w), a1
000684  move.w d0, d5
000686  lsl.w  #$8, d5
000688  subi.w #$10, d5
00068C  move.l $75a.l, d3
000692  move.w d3, d6
000694  lsr.w  #$4, d3
000696  add.w  d3, d3
000698  add.w  d3, d5
00069A  not.w  d6
00069C  andi.w #$f, d6
0006A0  move.w d6, d3
0006A2  lsl.w  #$4, d3
0006A4  add.w  d6, d3
0006A6  move.w d5, $6d6.l
0006AC  move.w d3, $6f6.l
0006B2  move.l #$1e000, d3
0006B8  divu.w d4, d3
0006BA  andi.l #$ffff, d3
0006C0  lsl.l  #$4, d3
0006C2  move.l d3, $71e.l
0006C8  moveq  #$0, d3
0006CA  bra.b  $722
0006CC  cmpi.w #$182, -$2(a1)
0006D2  bne.b  $726
0006D4  move.w #$0, d5
0006D8  move.w d5, -$10(a1)
0006DC  addi.w #$40, d5
0006E0  move.w d5, -$c(a1)
0006E4  addi.w #$40, d5
0006E8  move.w d5, -$8(a1)
0006EC  addi.w #$40, d5
0006F0  move.w d5, -$4(a1)
0006F4  move.w #$0, -$14(a1)
0006FA  move.l d3, d6
0006FC  swap   d6
0006FE  lsl.w  #$5, d6
000700  lea.l  (a6, d6.w), a2
000704  btst.b #$e, (a5)
000708  bne.b  $704
00070A  move.l a2, $4e(a5)
00070E  move.l a1, $52(a5)
000712  move.w #$3c1, $56(a5)
000718  lea.l  $54(a1), a1
00071C  addi.l #$10000, d3
000722  dbra   d4, $6cc
000726  movea.l $752.l, a1
00072C  movea.l $756.l, a6
000732  move.l $75a.l, d4
000738  move.l $c(a3), d3
00073C  cmp.l  #$ffffffff, d3
000742  bne.b  $748
000744  move.l -$1c(a3), d3
000748  tst.w  d7
00074A  bge.w  $39a
00074E  bra.w  $370
000752  ori.b  #$0, d0
000756  ori.b  #$0, d0
00075A  ori.b  #$0, d0
00075E  lea.l  $86a2.l, a0
000764  lea.l  $894e.l, a3
00076A  adda.w $7d2.l, a0
000770  adda.w $7d2.l, a3
000776  lea.l  $1b56.l, a1
00077C  lea.l  $1c32.l, a2
000782  move.w #$9, d7
000786  move.l $8(a1), d1
00078A  subi.l #$fffffe62, d1
000790  asr.l  #$3, d1
000792  moveq  #$0, d0
000794  move.w (a0), d0
000796  muls.w d1, d0
000798  asr.l  #$6, d0
00079A  addi.l #$ffff1000, d0
0007A0  move.l d0, $4(a1)
0007A4  subi.l #$fffe2000, d0
0007AA  move.l d0, $4(a2)
0007AE  move.w (a3), d0
0007B0  muls.w d1, d0
0007B2  asr.l  #$7, d0
0007B4  move.l d0, $10(a1)
0007B8  move.l d0, $10(a2)
0007BC  lea.l  $14(a1), a1
0007C0  lea.l  $14(a2), a2
0007C4  lea.l  $2(a0), a0
0007C8  lea.l  $2(a3), a3
0007CC  dbra   d7, $786
0007D0  rts    
0007D2  ori.b  #$f9, d0
0007D6  ori.b  #$2a, d0
0007DA  lea.l  $b0e2.l, a1
0007E0  lea.l  $11e.l, a2
0007E6  lea.l  $8e6.l, a4
0007EC  move.l #$10000, d2
0007F2  moveq  #$1, d6
0007F4  lea.l  $1c52.l, a5
0007FA  lea.l  $8be.l, a3
000800  tst.w  $8bc.l
000806  beq.b  $810
000808  lea.l  $4(a3), a3
00080C  lea.l  $14(a5), a5
000810  moveq  #$3, d7
000812  move.w $4(a3), d0
000816  moveq  #$0, d1
000818  move.w (a3), d1
00081A  tst.w  d6
00081C  beq.b  $830
00081E  sub.w  $6(a3), d0
000822  neg.w  d0
000824  sub.w  $2(a3), d1
000828  neg.w  d1
00082A  sub.w  d0, d1
00082C  neg.w  d1
00082E  bra.b  $83a
000830  add.w  $6(a3), d0
000834  add.w  $2(a3), d1
000838  sub.w  d0, d1
00083A  neg.w  d0
00083C  asr.w  #$2, d1
00083E  subq.w #$1, d1
000840  cmp.w  #$f, d1
000844  ble.b  $848
000846  moveq  #$f, d1
000848  tst.w  d1
00084A  bge.b  $84e
00084C  moveq  #$0, d1
00084E  add.w  d1, d1
000850  cmp.l  (a5), d2
000852  beq.b  $870
000854  tst.w  d6
000856  bne.b  $864
000858  move.w (a4, d1.w), $8(a0)
00085E  clr.w  $c(a0)
000862  bra.b  $86e
000864  clr.w  $8(a0)
000868  move.w (a4, d1.w), $c(a0)
00086E  bra.b  $878
000870  clr.w  $8(a0)
000874  clr.w  $c(a0)
000878  moveq  #$3, d3
00087A  sub.w  d7, d3
00087C  lsl.w  #$4, d3
00087E  move.w (a1, d1.w), (a2, d3.w)
000884  addi.w #$118, d0
000888  move.w #$e02, d1
00088C  btst.b #$0, d0
000890  beq.b  $896
000892  bset.b #$0, d1
000896  lsr.w  #$1, d0
000898  move.w d0, (a0)
00089A  move.w d1, $4(a0)
00089E  lea.l  $20(a0), a0
0008A2  lea.l  $8(a3), a3
0008A6  lea.l  $28(a5), a5
0008AA  dbra   d7, $812
0008AE  lea.l  -$70(a0), a0
0008B2  lea.l  $4(a2), a2
0008B6  dbra   d6, $7f4
0008BA  rts    
0008BC  ori.b  #$0, d0
0008C0  ori.b  #$0, d0
0008C4  ori.b  #$0, d0
0008C8  ori.b  #$0, d0
0008CC  ori.b  #$0, d0
0008D0  ori.b  #$0, d0
0008D4  ori.b  #$0, d0
0008D8  ori.b  #$0, d0
0008DC  ori.b  #$0, d0
0008E0  ori.b  #$0, d0
0008E4  ori.b  #$0, d0
0008E8  bclr.b d0, d0
0008EA  bclr.b d1, d0
0008EC  bset.b d1, d0
0008EE  bset.b d3, d0
0008F0  bset.b d3, -(a0)
0008F2  bset.b d7, -(a0)
0008F4  bset.b d7, $1ff83ff8(invalid.w)
0008FC  ; data: 0x3f, 0xfc
0008FE  ; data: 0x7f, 0xfc
000900  ; data: 0x7f, 0xfe
000902  ; data: 0xff, 0xfe
000904  ; data: 0xff, 0xff
000906  lea.l  $1b56.l, a1
00090C  lea.l  $1e28.l, a2
000912  bsr.w  $b00
000916  lea.l  $1c32.l, a1
00091C  lea.l  $1e30.l, a2
000922  bsr.w  $b00
000926  rts    
000928  lea.l  $1b5e.l, a0
00092E  cmpi.l #$fffffd92, (a0)
000934  bgt.w  $aaa
000938  lea.l  $1b56.l, a0
00093E  lea.l  $1c32.l, a1
000944  lea.l  $1e28.l, a2
00094A  adda.w $1e26(pc), a2
00094E  move.l $8(a0), d0
000952  addi.w #$d0, d0
000956  move.l #$100, d1
00095C  move.l (a2)+, (a0)
00095E  move.l d0, $8(a0)
000962  move.l (a2)+, $c(a0)
000966  move.l (a2)+, $0(a1)
00096A  move.l d0, $8(a1)
00096E  move.l (a2)+, $c(a1)
000972  add.l  d1, d0
000974  move.l (a2)+, $14(a0)
000978  move.l d0, $1c(a0)
00097C  move.l (a2)+, $20(a0)
000980  move.l (a2)+, $14(a1)
000984  move.l d0, $1c(a1)
000988  move.l (a2)+, $20(a1)
00098C  add.l  d1, d0
00098E  move.l (a2)+, $28(a0)
000992  move.l d0, $30(a0)
000996  move.l (a2)+, $34(a0)
00099A  move.l (a2)+, $28(a1)
00099E  move.l d0, $30(a1)
0009A2  move.l (a2)+, $34(a1)
0009A6  add.l  d1, d0
0009A8  move.l (a2)+, $3c(a0)
0009AC  move.l d0, $44(a0)
0009B0  move.l (a2)+, $48(a0)
0009B4  move.l (a2)+, $3c(a1)
0009B8  move.l d0, $44(a1)
0009BC  move.l (a2)+, $48(a1)
0009C0  add.l  d1, d0
0009C2  move.l (a2)+, $50(a0)
0009C6  move.l d0, $58(a0)
0009CA  move.l (a2)+, $5c(a0)
0009CE  move.l (a2)+, $50(a1)
0009D2  move.l d0, $58(a1)
0009D6  move.l (a2)+, $5c(a1)
0009DA  add.l  d1, d0
0009DC  move.l (a2)+, $64(a0)
0009E0  move.l d0, $6c(a0)
0009E4  move.l (a2)+, $70(a0)
0009E8  move.l (a2)+, $64(a1)
0009EC  move.l d0, $6c(a1)
0009F0  move.l (a2)+, $70(a1)
0009F4  add.l  d1, d0
0009F6  move.l (a2)+, $78(a0)
0009FA  move.l d0, $80(a0)
0009FE  move.l (a2)+, $84(a0)
000A02  move.l (a2)+, $78(a1)
000A06  move.l d0, $80(a1)
000A0A  move.l (a2)+, $84(a1)
000A0E  add.l  d1, d0
000A10  move.l (a2)+, $8c(a0)
000A14  move.l d0, $94(a0)
000A18  move.l (a2)+, $98(a0)
000A1C  move.l (a2)+, $8c(a1)
000A20  move.l d0, $94(a1)
000A24  move.l (a2)+, $98(a1)
000A28  add.l  d1, d0
000A2A  move.l (a2)+, $a0(a0)
000A2E  move.l d0, $a8(a0)
000A32  move.l (a2)+, $ac(a0)
000A36  move.l (a2)+, $a0(a1)
000A3A  move.l d0, $a8(a1)
000A3E  move.l (a2)+, $ac(a1)
000A42  add.l  d1, d0
000A44  move.l (a2)+, $b4(a0)
000A48  move.l d0, $bc(a0)
000A4C  move.l (a2)+, $c0(a0)
000A50  move.l (a2)+, $b4(a1)
000A54  move.l d0, $bc(a1)
000A58  move.l (a2)+, $c0(a1)
000A5C  bchg.b #$0, $8bc.l
000A64  addi.w #$10, $1e26.l
000A6C  cmpi.l #$ffffffff, (a2)
000A72  bne.b  $a88
000A74  clr.w  $1e26.l
000A7A  clr.w  $7d2.l
000A80  move.w #$1, $1b48.l
000A88  addq.w #$2, $7d2.l
000A8E  lea.l  $86a2.l, a3
000A94  adda.w $7d2.l, a3
000A9A  cmpi.l #$ffffffff, (a3)
000AA0  bne.b  $aa8
000AA2  clr.w  $7d2.l
000AA8  rts    
000AAA  lea.l  $1c3a.l, a1
000AB0  moveq  #$30, d0
000AB2  sub.l  d0, (a0)
000AB4  sub.l  d0, $14(a0)
000AB8  sub.l  d0, $28(a0)
000ABC  sub.l  d0, $3c(a0)
000AC0  sub.l  d0, $50(a0)
000AC4  sub.l  d0, $64(a0)
000AC8  sub.l  d0, $78(a0)
000ACC  sub.l  d0, $8c(a0)
000AD0  sub.l  d0, $a0(a0)
000AD4  sub.l  d0, $b4(a0)
000AD8  sub.l  d0, (a1)
000ADA  sub.l  d0, $14(a1)
000ADE  sub.l  d0, $28(a1)
000AE2  sub.l  d0, $3c(a1)
000AE6  sub.l  d0, $50(a1)
000AEA  sub.l  d0, $64(a1)
000AEE  sub.l  d0, $78(a1)
000AF2  sub.l  d0, $8c(a1)
000AF6  sub.l  d0, $a0(a1)
000AFA  sub.l  d0, $b4(a1)
000AFE  rts    
000B00  move.l #$fffffe62, d0
000B06  move.w #$9, d6
000B0A  move.l (a2), (a1)
000B0C  move.l d0, $8(a1)
000B10  move.l $4(a2), $c(a1)
000B16  lea.l  $14(a1), a1
000B1A  lea.l  $10(a2), a2
000B1E  addi.l #$100, d0
000B24  dbra   d6, $b0a
000B28  rts    
000B2A  addq.w #$1, $c4e.l
000B30  cmpi.w #$2, $c4e.l
000B38  bgt.b  $b3c
000B3A  rts    
000B3C  clr.w  $c4e.l
000B42  lea.l  $1c3e.l, a0
000B48  move.l #$6000, d0
000B4E  move.l #$a000, d1
000B54  cmp.l  (a0), d0
000B56  bgt.b  $b6c
000B58  cmp.l  (a0), d1
000B5A  ble.b  $b6c
000B5C  addi.l #$1000, (a0)
000B62  cmpi.l #$a000, (a0)
000B68  blt.b  $b6c
000B6A  move.l d0, (a0)
000B6C  lea.l  $14(a0), a0
000B70  cmp.l  (a0), d0
000B72  bgt.b  $b88
000B74  cmp.l  (a0), d1
000B76  ble.b  $b88
000B78  addi.l #$1000, (a0)
000B7E  cmpi.l #$a000, (a0)
000B84  blt.b  $b88
000B86  move.l d0, (a0)
000B88  lea.l  $14(a0), a0
000B8C  cmp.l  (a0), d0
000B8E  bgt.b  $ba4
000B90  cmp.l  (a0), d1
000B92  ble.b  $ba4
000B94  addi.l #$1000, (a0)
000B9A  cmpi.l #$a000, (a0)
000BA0  blt.b  $ba4
000BA2  move.l d0, (a0)
000BA4  lea.l  $14(a0), a0
000BA8  cmp.l  (a0), d0
000BAA  bgt.b  $bc0
000BAC  cmp.l  (a0), d1
000BAE  ble.b  $bc0
000BB0  addi.l #$1000, (a0)
000BB6  cmpi.l #$a000, (a0)
000BBC  blt.b  $bc0
000BBE  move.l d0, (a0)
000BC0  lea.l  $14(a0), a0
000BC4  cmp.l  (a0), d0
000BC6  bgt.b  $bdc
000BC8  cmp.l  (a0), d1
000BCA  ble.b  $bdc
000BCC  addi.l #$1000, (a0)
000BD2  cmpi.l #$a000, (a0)
000BD8  blt.b  $bdc
000BDA  move.l d0, (a0)
000BDC  lea.l  $14(a0), a0
000BE0  cmp.l  (a0), d0
000BE2  bgt.b  $bf8
000BE4  cmp.l  (a0), d1
000BE6  ble.b  $bf8
000BE8  addi.l #$1000, (a0)
000BEE  cmpi.l #$a000, (a0)
000BF4  blt.b  $bf8
000BF6  move.l d0, (a0)
000BF8  lea.l  $14(a0), a0
000BFC  cmp.l  (a0), d0
000BFE  bgt.b  $c14
000C00  cmp.l  (a0), d1
000C02  ble.b  $c14
000C04  addi.l #$1000, (a0)
000C0A  cmpi.l #$a000, (a0)
000C10  blt.b  $c14
000C12  move.l d0, (a0)
000C14  lea.l  $14(a0), a0
000C18  cmp.l  (a0), d0
000C1A  bgt.b  $c30
000C1C  cmp.l  (a0), d1
000C1E  ble.b  $c30
000C20  addi.l #$1000, (a0)
000C26  cmpi.l #$a000, (a0)
000C2C  blt.b  $c30
000C2E  move.l d0, (a0)
000C30  lea.l  $14(a0), a0
000C34  cmp.l  (a0), d0
000C36  bgt.b  $c4c
000C38  cmp.l  (a0), d1
000C3A  ble.b  $c4c
000C3C  addi.l #$1000, (a0)
000C42  cmpi.l #$a000, (a0)
000C48  blt.b  $c4c
000C4A  move.l d0, (a0)
000C4C  rts    
000C4E  ori.b  #$e7, d0
000C52  ; data: 0x00, 0x0e
000C54  moveq  #$9, d0
000C56  trap   #$d
000C58  move.l #$1a000, d0
000C5E  move.l #$1, d1
000C64  jsr    -$2a(a6)
000C68  movea.l $d94.l, a0
000C6E  move.l d0, $d94.l
000C74  movea.l $d94.l, a1
000C7A  move.l #$67f, d7
000C80  move.l (a0)+, (a1)+
000C82  move.l (a0)+, (a1)+
000C84  move.l (a0)+, (a1)+
000C86  move.l (a0)+, (a1)+
000C88  move.l (a0)+, (a1)+
000C8A  move.l (a0)+, (a1)+
000C8C  move.l (a0)+, (a1)+
000C8E  move.l (a0)+, (a1)+
000C90  move.l (a0)+, (a1)+
000C92  move.l (a0)+, (a1)+
000C94  move.l (a0)+, (a1)+
000C96  move.l (a0)+, (a1)+
000C98  move.l (a0)+, (a1)+
000C9A  move.l (a0)+, (a1)+
000C9C  move.l (a0)+, (a1)+
000C9E  move.l (a0)+, (a1)+
000CA0  dbra   d7, $c80
000CA4  movem.l (a7)+, a4-a6
000CA8  rts    
000CAA  jsr    -$11a(a6)
000CAE  move.w $1c(a0), d0
000CB2  or.w   d0, $16.l
000CB8  movem.l a4-a6, -(a7)
000CBC  lea.l  $dff002.l, a4
000CC2  move.l #$5400, d0
000CC8  move.l #$1, d1
000CCE  jsr    -$2a(a6)
000CD2  lea.l  $1922.l, a0
000CD8  move.l d0, (a0)
000CDA  move.l d0, $8(a0)
000CDE  move.l #$10000, d0
000CE4  move.l #$41, d1
000CEA  jsr    -$30(a6)
000CEE  move.l d0, $d90.l
000CF4  move.l #$5400, d0
000CFA  move.l #$1, d1
000D00  jsr    -$2a(a6)
000D04  lea.l  $1922.l, a0
000D0A  move.l d0, $4(a0)
000D0E  move.l #$1a000, d0
000D14  move.l #$0, d1
000D1A  jsr    -$2a(a6)
000D1E  move.l d0, $d94.l
000D24  clr.w  $1e26.l
000D2A  clr.w  $1b48.l
000D30  clr.w  $2e6.l
000D36  clr.w  $7d2.l
000D3C  clr.w  $2e8.l
000D42  clr.w  $276.l
000D48  lea.l  $8bfa.l, a0
000D4E  lea.l  $da.l, a1
000D54  moveq  #$1f, d7
000D56  move.w (a0)+, (a1)
000D58  addq.w #$4, a1
000D5A  dbra   d7, $d56
000D5E  move.l #$180, d0
000D64  move.w d0, $1b50.l
000D6A  swap   d0
000D6C  move.w d0, $1b4c.l
000D72  bsr.w  $11bc
000D76  bsr.w  $1268
000D7A  bsr.w  $17f2
000D7E  bsr.w  $906
000D82  bsr.w  $d98
000D86  bsr.w  $18d6
000D8A  movem.l (a7)+, a4-a6
000D8E  rts    
000D90  ori.b  #$0, d0
000D94  ori.b  #$0, d0
000D98  lea.l  $dbc.l, a0
000D9E  moveq  #$f0, d1
000DA0  moveq  #$f, d7
000DA2  move.w #$ff, d0
000DA6  moveq  #$f, d6
000DA8  move.w d1, (a0)+
000DAA  move.w d0, (a0)+
000DAC  subi.w #$11, d0
000DB0  dbra   d6, $da8
000DB4  addq.w #$2, d1
000DB6  dbra   d7, $da2
000DBA  rts    
000DBC  ori.b  #$0, d0
000DC0  ori.b  #$0, d0
000DC4  ori.b  #$0, d0
000DC8  ori.b  #$0, d0
000DCC  ori.b  #$0, d0
000DD0  ori.b  #$0, d0
000DD4  ori.b  #$0, d0
000DD8  ori.b  #$0, d0
000DDC  ori.b  #$0, d0
000DE0  ori.b  #$0, d0
000DE4  ori.b  #$0, d0
000DE8  ori.b  #$0, d0
000DEC  ori.b  #$0, d0
000DF0  ori.b  #$0, d0
000DF4  ori.b  #$0, d0
000DF8  ori.b  #$0, d0
000DFC  ori.b  #$0, d0
000E00  ori.b  #$0, d0
000E04  ori.b  #$0, d0
000E08  ori.b  #$0, d0
000E0C  ori.b  #$0, d0
000E10  ori.b  #$0, d0
000E14  ori.b  #$0, d0
000E18  ori.b  #$0, d0
000E1C  ori.b  #$0, d0
000E20  ori.b  #$0, d0
000E24  ori.b  #$0, d0
000E28  ori.b  #$0, d0
000E2C  ori.b  #$0, d0
000E30  ori.b  #$0, d0
000E34  ori.b  #$0, d0
000E38  ori.b  #$0, d0
000E3C  ori.b  #$0, d0
000E40  ori.b  #$0, d0
000E44  ori.b  #$0, d0
000E48  ori.b  #$0, d0
000E4C  ori.b  #$0, d0
000E50  ori.b  #$0, d0
000E54  ori.b  #$0, d0
000E58  ori.b  #$0, d0
000E5C  ori.b  #$0, d0
000E60  ori.b  #$0, d0
000E64  ori.b  #$0, d0
000E68  ori.b  #$0, d0
000E6C  ori.b  #$0, d0
000E70  ori.b  #$0, d0
000E74  ori.b  #$0, d0
000E78  ori.b  #$0, d0
000E7C  ori.b  #$0, d0
000E80  ori.b  #$0, d0
000E84  ori.b  #$0, d0
000E88  ori.b  #$0, d0
000E8C  ori.b  #$0, d0
000E90  ori.b  #$0, d0
000E94  ori.b  #$0, d0
000E98  ori.b  #$0, d0
000E9C  ori.b  #$0, d0
000EA0  ori.b  #$0, d0
000EA4  ori.b  #$0, d0
000EA8  ori.b  #$0, d0
000EAC  ori.b  #$0, d0
000EB0  ori.b  #$0, d0
000EB4  ori.b  #$0, d0
000EB8  ori.b  #$0, d0
000EBC  ori.b  #$0, d0
000EC0  ori.b  #$0, d0
000EC4  ori.b  #$0, d0
000EC8  ori.b  #$0, d0
000ECC  ori.b  #$0, d0
000ED0  ori.b  #$0, d0
000ED4  ori.b  #$0, d0
000ED8  ori.b  #$0, d0
000EDC  ori.b  #$0, d0
000EE0  ori.b  #$0, d0
000EE4  ori.b  #$0, d0
000EE8  ori.b  #$0, d0
000EEC  ori.b  #$0, d0
000EF0  ori.b  #$0, d0
000EF4  ori.b  #$0, d0
000EF8  ori.b  #$0, d0
000EFC  ori.b  #$0, d0
000F00  ori.b  #$0, d0
000F04  ori.b  #$0, d0
000F08  ori.b  #$0, d0
000F0C  ori.b  #$0, d0
000F10  ori.b  #$0, d0
000F14  ori.b  #$0, d0
000F18  ori.b  #$0, d0
000F1C  ori.b  #$0, d0
000F20  ori.b  #$0, d0
000F24  ori.b  #$0, d0
000F28  ori.b  #$0, d0
000F2C  ori.b  #$0, d0
000F30  ori.b  #$0, d0
000F34  ori.b  #$0, d0
000F38  ori.b  #$0, d0
000F3C  ori.b  #$0, d0
000F40  ori.b  #$0, d0
000F44  ori.b  #$0, d0
000F48  ori.b  #$0, d0
000F4C  ori.b  #$0, d0
000F50  ori.b  #$0, d0
000F54  ori.b  #$0, d0
000F58  ori.b  #$0, d0
000F5C  ori.b  #$0, d0
000F60  ori.b  #$0, d0
000F64  ori.b  #$0, d0
000F68  ori.b  #$0, d0
000F6C  ori.b  #$0, d0
000F70  ori.b  #$0, d0
000F74  ori.b  #$0, d0
000F78  ori.b  #$0, d0
000F7C  ori.b  #$0, d0
000F80  ori.b  #$0, d0
000F84  ori.b  #$0, d0
000F88  ori.b  #$0, d0
000F8C  ori.b  #$0, d0
000F90  ori.b  #$0, d0
000F94  ori.b  #$0, d0
000F98  ori.b  #$0, d0
000F9C  ori.b  #$0, d0
000FA0  ori.b  #$0, d0
000FA4  ori.b  #$0, d0
000FA8  ori.b  #$0, d0
000FAC  ori.b  #$0, d0
000FB0  ori.b  #$0, d0
000FB4  ori.b  #$0, d0
000FB8  ori.b  #$0, d0
000FBC  ori.b  #$0, d0
000FC0  ori.b  #$0, d0
000FC4  ori.b  #$0, d0
000FC8  ori.b  #$0, d0
000FCC  ori.b  #$0, d0
000FD0  ori.b  #$0, d0
000FD4  ori.b  #$0, d0
000FD8  ori.b  #$0, d0
000FDC  ori.b  #$0, d0
000FE0  ori.b  #$0, d0
000FE4  ori.b  #$0, d0
000FE8  ori.b  #$0, d0
000FEC  ori.b  #$0, d0
000FF0  ori.b  #$0, d0
000FF4  ori.b  #$0, d0
000FF8  ori.b  #$0, d0
000FFC  ori.b  #$0, d0
001000  ori.b  #$0, d0
001004  ori.b  #$0, d0
001008  ori.b  #$0, d0
00100C  ori.b  #$0, d0
001010  ori.b  #$0, d0
001014  ori.b  #$0, d0
001018  ori.b  #$0, d0
00101C  ori.b  #$0, d0
001020  ori.b  #$0, d0
001024  ori.b  #$0, d0
001028  ori.b  #$0, d0
00102C  ori.b  #$0, d0
001030  ori.b  #$0, d0
001034  ori.b  #$0, d0
001038  ori.b  #$0, d0
00103C  ori.b  #$0, d0
001040  ori.b  #$0, d0
001044  ori.b  #$0, d0
001048  ori.b  #$0, d0
00104C  ori.b  #$0, d0
001050  ori.b  #$0, d0
001054  ori.b  #$0, d0
001058  ori.b  #$0, d0
00105C  ori.b  #$0, d0
001060  ori.b  #$0, d0
001064  ori.b  #$0, d0
001068  ori.b  #$0, d0
00106C  ori.b  #$0, d0
001070  ori.b  #$0, d0
001074  ori.b  #$0, d0
001078  ori.b  #$0, d0
00107C  ori.b  #$0, d0
001080  ori.b  #$0, d0
001084  ori.b  #$0, d0
001088  ori.b  #$0, d0
00108C  ori.b  #$0, d0
001090  ori.b  #$0, d0
001094  ori.b  #$0, d0
001098  ori.b  #$0, d0
00109C  ori.b  #$0, d0
0010A0  ori.b  #$0, d0
0010A4  ori.b  #$0, d0
0010A8  ori.b  #$0, d0
0010AC  ori.b  #$0, d0
0010B0  ori.b  #$0, d0
0010B4  ori.b  #$0, d0
0010B8  ori.b  #$0, d0
0010BC  ori.b  #$0, d0
0010C0  ori.b  #$0, d0
0010C4  ori.b  #$0, d0
0010C8  ori.b  #$0, d0
0010CC  ori.b  #$0, d0
0010D0  ori.b  #$0, d0
0010D4  ori.b  #$0, d0
0010D8  ori.b  #$0, d0
0010DC  ori.b  #$0, d0
0010E0  ori.b  #$0, d0
0010E4  ori.b  #$0, d0
0010E8  ori.b  #$0, d0
0010EC  ori.b  #$0, d0
0010F0  ori.b  #$0, d0
0010F4  ori.b  #$0, d0
0010F8  ori.b  #$0, d0
0010FC  ori.b  #$0, d0
001100  ori.b  #$0, d0
001104  ori.b  #$0, d0
001108  ori.b  #$0, d0
00110C  ori.b  #$0, d0
001110  ori.b  #$0, d0
001114  ori.b  #$0, d0
001118  ori.b  #$0, d0
00111C  ori.b  #$0, d0
001120  ori.b  #$0, d0
001124  ori.b  #$0, d0
001128  ori.b  #$0, d0
00112C  ori.b  #$0, d0
001130  ori.b  #$0, d0
001134  ori.b  #$0, d0
001138  ori.b  #$0, d0
00113C  ori.b  #$0, d0
001140  ori.b  #$0, d0
001144  ori.b  #$0, d0
001148  ori.b  #$0, d0
00114C  ori.b  #$0, d0
001150  ori.b  #$0, d0
001154  ori.b  #$0, d0
001158  ori.b  #$0, d0
00115C  ori.b  #$0, d0
001160  ori.b  #$0, d0
001164  ori.b  #$0, d0
001168  ori.b  #$0, d0
00116C  ori.b  #$0, d0
001170  ori.b  #$0, d0
001174  ori.b  #$0, d0
001178  ori.b  #$0, d0
00117C  ori.b  #$0, d0
001180  ori.b  #$0, d0
001184  ori.b  #$0, d0
001188  ori.b  #$0, d0
00118C  ori.b  #$0, d0
001190  ori.b  #$0, d0
001194  ori.b  #$0, d0
001198  ori.b  #$0, d0
00119C  ori.b  #$0, d0
0011A0  ori.b  #$0, d0
0011A4  ori.b  #$0, d0
0011A8  ori.b  #$0, d0
0011AC  ori.b  #$0, d0
0011B0  ori.b  #$0, d0
0011B4  ori.b  #$0, d0
0011B8  ori.b  #$0, d0
0011BC  movea.l $d90.l, a1
0011C2  lea.l  $74(a1), a2
0011C6  lea.l  -$c(a1), a1
0011CA  moveq  #$0, d0
0011CC  move.l #$ff0000, d4
0011D2  move.w #$fe, d7
0011D6  lea.l  $8c3a.l, a0
0011DC  move.l d4, d1
0011DE  move.w #$ffff, $1266.l
0011E6  move.w #$3f, d6
0011EA  move.w #$7, d5
0011EE  move.l d1, d2
0011F0  add.l  d0, d1
0011F2  swap   d2
0011F4  cmp.w  $1266.l, d2
0011FA  beq.b  $1230
0011FC  move.w d2, $1266.l
001202  move.w d2, d3
001204  lsr.w  #$3, d2
001206  not.w  d3
001208  btst.l d5, $0(a0)
00120C  beq.b  $1212
00120E  bset.b d3, (a1, d2.w)
001212  btst.l d5, $40(a0)
001216  beq.b  $121c
001218  bset.b d3, $40(a1, d2.w)
00121C  btst.l d5, $80(a0)
001220  beq.b  $1226
001222  bset.b d3, (a2, d2.w)
001226  btst.l d5, $c0(a0)
00122A  beq.b  $1230
00122C  bset.b d3, $40(a2, d2.w)
001230  dbra   d5, $11ee
001234  lea.l  $1(a0), a0
001238  dbra   d6, $11ea
00123C  lea.l  $100(a1), a1
001240  lea.l  $100(a2), a2
001244  addi.w #$101, d0
001248  subi.l #$10000, d4
00124E  dbra   d7, $11d6
001252  movea.l $d90.l, a0
001258  move.w #$1f, d7
00125C  clr.l  (a0)+
00125E  clr.l  (a0)+
001260  dbra   d7, $125c
001264  rts    
001266  ori.b  #$f9, d0
00126A  ori.b  #$e, d0
00126E  movea.l $d94.l, a5
001274  movea.l (a4)+, a0
001276  movea.l (a4)+, a2
001278  movea.l (a4)+, a6
00127A  bsr.w  $1288
00127E  cmpi.l #$ffffffff, (a4)
001284  bne.b  $1274
001286  rts    
001288  moveq  #$e, d7
00128A  cmpa.w #$0, a6
00128E  beq.b  $1292
001290  moveq  #$1d, d7
001292  movea.l a5, a1
001294  move.b $0(a0), d0
001298  move.b $28(a0), d1
00129C  move.b $50(a0), d2
0012A0  move.b $78(a0), d3
0012A4  move.b $a0(a0), d4
0012A8  lea.l  $1(a0), a0
0012AC  move.w d7, $17f0.l
0012B2  moveq  #$7, d6
0012B4  moveq  #$0, d7
0012B6  move.w d6, d5
0012B8  btst.l d5, d0
0012BA  beq.b  $12be
0012BC  moveq  #$2, d7
0012BE  btst.l d5, d1
0012C0  beq.b  $12c4
0012C2  addq.w #$4, d7
0012C4  btst.l d5, d2
0012C6  beq.b  $12ca
0012C8  addq.w #$8, d7
0012CA  btst.l d5, d3
0012CC  beq.b  $12d2
0012CE  addi.w #$10, d7
0012D2  btst.l d5, d4
0012D4  beq.b  $12da
0012D6  addi.w #$20, d7
0012DA  move.w (a2, d7.w), (a1)+
0012DE  dbra   d6, $12b4
0012E2  move.b $0(a0), d0
0012E6  move.b $28(a0), d1
0012EA  move.b $50(a0), d2
0012EE  move.b $78(a0), d3
0012F2  move.b $a0(a0), d4
0012F6  lea.l  $c7(a0), a0
0012FA  moveq  #$6, d6
0012FC  moveq  #$0, d7
0012FE  move.w d6, d5
001300  addq.w #$1, d5
001302  btst.l d5, d0
001304  beq.b  $1308
001306  moveq  #$2, d7
001308  btst.l d5, d1
00130A  beq.b  $130e
00130C  addq.w #$4, d7
00130E  btst.l d5, d2
001310  beq.b  $1314
001312  addq.w #$8, d7
001314  btst.l d5, d3
001316  beq.b  $131c
001318  addi.w #$10, d7
00131C  btst.l d5, d4
00131E  beq.b  $1324
001320  addi.w #$20, d7
001324  move.w (a2, d7.w), (a1)+
001328  dbra   d6, $12fc
00132C  clr.w  (a1)+
00132E  move.w $17f0.l, d7
001334  dbra   d7, $1294
001338  move.l a5, $1424.l
00133E  move.l #$1430, $1428.l
001348  move.b #$7, $142c.l
001350  move.w #$f0, $142e.l
001358  cmpa.w #$0, a6
00135C  beq.b  $1366
00135E  move.w #$1e0, $142e.l
001366  movea.l $1424.l, a0
00136C  movea.l a0, a1
00136E  moveq  #$0, d0
001370  move.w $142e.l, d0
001376  add.l  d0, d0
001378  adda.l d0, a1
00137A  move.l a1, $1424.l
001380  move.w $142e.l, d7
001386  subq.w #$1, d7
001388  move.w (a0)+, (a1)+
00138A  dbra   d7, $1388
00138E  bsr.w  $13aa
001392  tst.b  $142c.l
001398  bne.b  $1366
00139A  lea.l  $1000(a5), a5
00139E  cmpa.w #$0, a6
0013A2  beq.b  $13a8
0013A4  lea.l  $1000(a5), a5
0013A8  rts    
0013AA  subq.b #$1, $142c.l
0013B0  movea.l $1424(pc), a0
0013B4  movea.l $1428(pc), a1
0013B8  move.w $142e(pc), d6
0013BC  bra.b  $141e
0013BE  move.w (a1)+, d0
0013C0  move.w (a0), d1
0013C2  move.w d0, d2
0013C4  move.w d1, d3
0013C6  andi.w #$f, d2
0013CA  andi.w #$f, d3
0013CE  cmp.w  d2, d3
0013D0  beq.b  $13da
0013D2  blt.b  $13d8
0013D4  subq.w #$1, (a0)
0013D6  bra.b  $13da
0013D8  addq.w #$1, (a0)
0013DA  move.w d0, d2
0013DC  move.w d1, d3
0013DE  ror.w  #$4, d2
0013E0  ror.w  #$4, d3
0013E2  andi.w #$f, d2
0013E6  andi.w #$f, d3
0013EA  cmp.w  d2, d3
0013EC  beq.b  $13fa
0013EE  blt.b  $13f6
0013F0  subi.w #$10, (a0)
0013F4  bra.b  $13fa
0013F6  addi.w #$10, (a0)
0013FA  move.w d0, d2
0013FC  move.w d1, d3
0013FE  ror.w  #$8, d2
001400  ror.w  #$8, d3
001402  andi.w #$f, d2
001406  andi.w #$f, d3
00140A  cmp.w  d2, d3
00140C  beq.b  $141a
00140E  blt.b  $1416
001410  subi.w #$100, (a0)
001414  bra.b  $141a
001416  addi.w #$100, (a0)
00141A  lea.l  $2(a0), a0
00141E  dbra   d6, $13be
001422  rts    
001424  ori.b  #$0, d0
001428  ori.b  #$0, d0
00142C  ori.b  #$0, d0
001430  ori.b  #$0, d0
001434  ori.b  #$0, d0
001438  ori.b  #$0, d0
00143C  ori.b  #$0, d0
001440  ori.b  #$0, d0
001444  ori.b  #$0, d0
001448  ori.b  #$0, d0
00144C  ori.b  #$0, d0
001450  ori.b  #$0, d0
001454  ori.b  #$0, d0
001458  ori.b  #$0, d0
00145C  ori.b  #$0, d0
001460  ori.b  #$0, d0
001464  ori.b  #$0, d0
001468  ori.b  #$0, d0
00146C  ori.b  #$0, d0
001470  ori.b  #$0, d0
001474  ori.b  #$0, d0
001478  ori.b  #$0, d0
00147C  ori.b  #$0, d0
001480  ori.b  #$0, d0
001484  ori.b  #$0, d0
001488  ori.b  #$0, d0
00148C  ori.b  #$0, d0
001490  ori.b  #$0, d0
001494  ori.b  #$0, d0
001498  ori.b  #$0, d0
00149C  ori.b  #$0, d0
0014A0  ori.b  #$0, d0
0014A4  ori.b  #$0, d0
0014A8  ori.b  #$0, d0
0014AC  ori.b  #$0, d0
0014B0  ori.b  #$0, d0
0014B4  ori.b  #$0, d0
0014B8  ori.b  #$0, d0
0014BC  ori.b  #$0, d0
0014C0  ori.b  #$0, d0
0014C4  ori.b  #$0, d0
0014C8  ori.b  #$0, d0
0014CC  ori.b  #$0, d0
0014D0  ori.b  #$0, d0
0014D4  ori.b  #$0, d0
0014D8  ori.b  #$0, d0
0014DC  ori.b  #$0, d0
0014E0  ori.b  #$0, d0
0014E4  ori.b  #$0, d0
0014E8  ori.b  #$0, d0
0014EC  ori.b  #$0, d0
0014F0  ori.b  #$0, d0
0014F4  ori.b  #$0, d0
0014F8  ori.b  #$0, d0
0014FC  ori.b  #$0, d0
001500  ori.b  #$0, d0
001504  ori.b  #$0, d0
001508  ori.b  #$0, d0
00150C  ori.b  #$0, d0
001510  ori.b  #$0, d0
001514  ori.b  #$0, d0
001518  ori.b  #$0, d0
00151C  ori.b  #$0, d0
001520  ori.b  #$0, d0
001524  ori.b  #$0, d0
001528  ori.b  #$0, d0
00152C  ori.b  #$0, d0
001530  ori.b  #$0, d0
001534  ori.b  #$0, d0
001538  ori.b  #$0, d0
00153C  ori.b  #$0, d0
001540  ori.b  #$0, d0
001544  ori.b  #$0, d0
001548  ori.b  #$0, d0
00154C  ori.b  #$0, d0
001550  ori.b  #$0, d0
001554  ori.b  #$0, d0
001558  ori.b  #$0, d0
00155C  ori.b  #$0, d0
001560  ori.b  #$0, d0
001564  ori.b  #$0, d0
001568  ori.b  #$0, d0
00156C  ori.b  #$0, d0
001570  ori.b  #$0, d0
001574  ori.b  #$0, d0
001578  ori.b  #$0, d0
00157C  ori.b  #$0, d0
001580  ori.b  #$0, d0
001584  ori.b  #$0, d0
001588  ori.b  #$0, d0
00158C  ori.b  #$0, d0
001590  ori.b  #$0, d0
001594  ori.b  #$0, d0
001598  ori.b  #$0, d0
00159C  ori.b  #$0, d0
0015A0  ori.b  #$0, d0
0015A4  ori.b  #$0, d0
0015A8  ori.b  #$0, d0
0015AC  ori.b  #$0, d0
0015B0  ori.b  #$0, d0
0015B4  ori.b  #$0, d0
0015B8  ori.b  #$0, d0
0015BC  ori.b  #$0, d0
0015C0  ori.b  #$0, d0
0015C4  ori.b  #$0, d0
0015C8  ori.b  #$0, d0
0015CC  ori.b  #$0, d0
0015D0  ori.b  #$0, d0
0015D4  ori.b  #$0, d0
0015D8  ori.b  #$0, d0
0015DC  ori.b  #$0, d0
0015E0  ori.b  #$0, d0
0015E4  ori.b  #$0, d0
0015E8  ori.b  #$0, d0
0015EC  ori.b  #$0, d0
0015F0  ori.b  #$0, d0
0015F4  ori.b  #$0, d0
0015F8  ori.b  #$0, d0
0015FC  ori.b  #$0, d0
001600  ori.b  #$0, d0
001604  ori.b  #$0, d0
001608  ori.b  #$0, d0
00160C  ori.b  #$0, d0
001610  ori.b  #$0, d0
001614  ori.b  #$0, d0
001618  ori.b  #$0, d0
00161C  ori.b  #$0, d0
001620  ori.b  #$0, d0
001624  ori.b  #$0, d0
001628  ori.b  #$0, d0
00162C  ori.b  #$0, d0
001630  ori.b  #$0, d0
001634  ori.b  #$0, d0
001638  ori.b  #$0, d0
00163C  ori.b  #$0, d0
001640  ori.b  #$0, d0
001644  ori.b  #$0, d0
001648  ori.b  #$0, d0
00164C  ori.b  #$0, d0
001650  ori.b  #$0, d0
001654  ori.b  #$0, d0
001658  ori.b  #$0, d0
00165C  ori.b  #$0, d0
001660  ori.b  #$0, d0
001664  ori.b  #$0, d0
001668  ori.b  #$0, d0
00166C  ori.b  #$0, d0
001670  ori.b  #$0, d0
001674  ori.b  #$0, d0
001678  ori.b  #$0, d0
00167C  ori.b  #$0, d0
001680  ori.b  #$0, d0
001684  ori.b  #$0, d0
001688  ori.b  #$0, d0
00168C  ori.b  #$0, d0
001690  ori.b  #$0, d0
001694  ori.b  #$0, d0
001698  ori.b  #$0, d0
00169C  ori.b  #$0, d0
0016A0  ori.b  #$0, d0
0016A4  ori.b  #$0, d0
0016A8  ori.b  #$0, d0
0016AC  ori.b  #$0, d0
0016B0  ori.b  #$0, d0
0016B4  ori.b  #$0, d0
0016B8  ori.b  #$0, d0
0016BC  ori.b  #$0, d0
0016C0  ori.b  #$0, d0
0016C4  ori.b  #$0, d0
0016C8  ori.b  #$0, d0
0016CC  ori.b  #$0, d0
0016D0  ori.b  #$0, d0
0016D4  ori.b  #$0, d0
0016D8  ori.b  #$0, d0
0016DC  ori.b  #$0, d0
0016E0  ori.b  #$0, d0
0016E4  ori.b  #$0, d0
0016E8  ori.b  #$0, d0
0016EC  ori.b  #$0, d0
0016F0  ori.b  #$0, d0
0016F4  ori.b  #$0, d0
0016F8  ori.b  #$0, d0
0016FC  ori.b  #$0, d0
001700  ori.b  #$0, d0
001704  ori.b  #$0, d0
001708  ori.b  #$0, d0
00170C  ori.b  #$0, d0
001710  ori.b  #$0, d0
001714  ori.b  #$0, d0
001718  ori.b  #$0, d0
00171C  ori.b  #$0, d0
001720  ori.b  #$0, d0
001724  ori.b  #$0, d0
001728  ori.b  #$0, d0
00172C  ori.b  #$0, d0
001730  ori.b  #$0, d0
001734  ori.b  #$0, d0
001738  ori.b  #$0, d0
00173C  ori.b  #$0, d0
001740  ori.b  #$0, d0
001744  ori.b  #$0, d0
001748  ori.b  #$0, d0
00174C  ori.b  #$0, d0
001750  ori.b  #$0, d0
001754  ori.b  #$0, d0
001758  ori.b  #$0, d0
00175C  ori.b  #$0, d0
001760  ori.b  #$0, d0
001764  ori.b  #$0, d0
001768  ori.b  #$0, d0
00176C  ori.b  #$0, d0
001770  ori.b  #$0, d0
001774  ori.b  #$0, d0
001778  ori.b  #$0, d0
00177C  ori.b  #$0, d0
001780  ori.b  #$0, d0
001784  ori.b  #$0, d0
001788  ori.b  #$0, d0
00178C  ori.b  #$0, d0
001790  ori.b  #$0, d0
001794  ori.b  #$0, d0
001798  ori.b  #$0, d0
00179C  ori.b  #$0, d0
0017A0  ori.b  #$0, d0
0017A4  ori.b  #$0, d0
0017A8  ori.b  #$0, d0
0017AC  ori.b  #$0, d0
0017B0  ori.b  #$0, d0
0017B4  ori.b  #$0, d0
0017B8  ori.b  #$0, d0
0017BC  ori.b  #$0, d0
0017C0  ori.b  #$0, d0
0017C4  ori.b  #$0, d0
0017C8  ori.b  #$0, d0
0017CC  ori.b  #$0, d0
0017D0  ori.b  #$0, d0
0017D4  ori.b  #$0, d0
0017D8  ori.b  #$0, d0
0017DC  ori.b  #$0, d0
0017E0  ori.b  #$0, d0
0017E4  ori.b  #$0, d0
0017E8  ori.b  #$0, d0
0017EC  ori.b  #$0, d0
0017F0  ori.b  #$f9, d0
0017F4  ori.b  #$22, d0
0017F8  moveq  #$1, d6
0017FA  movea.l (a1)+, a0
0017FC  move.w #$28df, d0
001800  move.w #$ff, d7
001804  move.w d0, (a0)+
001806  addi.w #$100, d0
00180A  move.w #$fffe, (a0)+
00180E  move.w #$102, (a0)+
001812  move.w #$0, (a0)+
001816  move.w #$e2, (a0)+
00181A  move.w #$0, (a0)+
00181E  move.w #$e6, (a0)+
001822  move.w #$0, (a0)+
001826  move.w #$ea, (a0)+
00182A  move.w #$0, (a0)+
00182E  move.w #$ee, (a0)+
001832  move.w #$0, (a0)+
001836  move.w #$180, (a0)+
00183A  move.w #$1, (a0)+
00183E  move.w #$184, (a0)+
001842  move.w #$0, (a0)+
001846  move.w #$186, (a0)+
00184A  move.w #$0, (a0)+
00184E  move.w #$188, (a0)+
001852  move.w #$0, (a0)+
001856  move.w #$18a, (a0)+
00185A  move.w #$0, (a0)+
00185E  move.w #$18c, (a0)+
001862  move.w #$0, (a0)+
001866  move.w #$18e, (a0)+
00186A  move.w #$0, (a0)+
00186E  move.w #$190, (a0)+
001872  move.w #$0, (a0)+
001876  move.w #$192, (a0)+
00187A  move.w #$0, (a0)+
00187E  move.w #$194, (a0)+
001882  move.w #$0, (a0)+
001886  move.w #$196, (a0)+
00188A  move.w #$0, (a0)+
00188E  move.w #$198, (a0)+
001892  move.w #$0, (a0)+
001896  move.w #$19a, (a0)+
00189A  move.w #$0, (a0)+
00189E  move.w #$19c, (a0)+
0018A2  move.w #$0, (a0)+
0018A6  move.w #$19e, (a0)+
0018AA  move.w #$0, (a0)+
0018AE  dbra   d7, $1804
0018B2  dbra   d6, $17fa
0018B6  move.l $d90.l, d0
0018BC  swap   d0
0018BE  lea.l  $a8.l, a0
0018C4  move.w d0, $2(a0)
0018C8  move.w d0, $a(a0)
0018CC  move.w d0, $12(a0)
0018D0  move.w d0, $1a(a0)
0018D4  rts    
0018D6  bchg.b #$2, $1921.l
0018DE  lea.l  $1922.l, a0
0018E4  adda.w $1920.l, a0
0018EA  move.l (a0)+, d0
0018EC  move.l (a0), $191c.l
0018F2  movea.l d0, a0
0018F4  addi.l #$930, d0
0018FA  move.w d0, $17a.l
001900  swap   d0
001902  move.w d0, $176.l
001908  lea.l  $1b4a.l, a1
00190E  move.l (a1)+, $4b24(a0)
001912  move.l (a1)+, $4b28(a0)
001916  move.w (a1), $4b2c(a0)
00191A  rts    
00191C  ori.b  #$0, d0
001920  ori.b  #$0, d0
001924  ori.b  #$0, d0
001928  ori.b  #$0, d0
00192C  ori.b  #$79, d0
001930  ori.b  #$1c, d0
001934  lea.l  $93a(a0), a0
001938  btst.b #$e, (a5)
00193C  bne.b  $1938
00193E  move.l #$ffffffff, $42(a5)
001946  move.w #$ffee, $62(a5)
00194C  move.w #$42, $64(a5)
001952  move.l #$9f00000, $3e(a5)
00195A  move.l #$2e4, $4e(a5)
001962  move.l a0, $52(a5)
001966  move.w #$3249, $56(a5)
00196C  rts    
00196E  tst.w  $1a7e.l
001974  beq.b  $1988
001976  btst.b #$6, $bfe001.l
00197E  bne.b  $1986
001980  clr.w  $1a7e.l
001986  rts    
001988  lea.l  $352a.l, a0
00198E  adda.l $1a72.l, a0
001994  addq.l #$1, $1a72.l
00199A  move.b (a0)+, d0
00199C  cmpi.b #$1, (a0)
0019A0  bne.b  $19b2
0019A2  subq.l #$1, $1a72.l
0019A8  move.w #$3, $276.l
0019B0  rts    
0019B2  tst.b  (a0)
0019B4  bne.b  $19c0
0019B6  moveq  #$0, d1
0019B8  subq.l #$1, $1a72.l
0019BE  bra.b  $19d8
0019C0  lea.l  $1a80(pc), a1
0019C4  move.l #$2b, d1
0019CA  cmp.b  (a1)+, d0
0019CC  dbeq   d1, $19ca
0019D0  neg.w  d1
0019D2  addi.l #$2b, d1
0019D8  lea.l  $30e9(pc), a2
0019DC  adda.w d1, a2
0019DE  lea.l  $60000.l, a3
0019E4  adda.l $1a76.l, a3
0019EA  adda.l $1a7a.l, a3
0019F0  addq.l #$1, $1a7a.l
0019F6  moveq  #$2, d7
0019F8  move.b $0(a2), $0(a3)
0019FE  move.b $2c(a2), $50(a3)
001A04  move.b $58(a2), $a0(a3)
001A0A  move.b $84(a2), $f0(a3)
001A10  move.b $b0(a2), $140(a3)
001A16  move.b $dc(a2), $190(a3)
001A1C  move.b $108(a2), $1e0(a3)
001A22  move.b $134(a2), $230(a3)
001A28  lea.l  $160(a2), a2
001A2C  lea.l  $5000(a3), a3
001A30  dbra   d7, $19f8
001A34  cmpi.l #$50, $1a7a.l
001A3E  bne.b  $1a70
001A40  addq.l #$1, $1a72.l
001A46  clr.l  $1a7a.l
001A4C  addi.l #$320, $1a76.l
001A56  cmpi.l #$4e20, $1a76.l
001A60  bne.b  $1a70
001A62  clr.l  $1a76.l
001A68  move.w #$1, $1a7e.l
001A70  rts    
001A72  ori.b  #$0, d0
001A76  ori.b  #$0, d0
001A7A  ori.b  #$0, d0
001A7E  ori.b  #$61, d0
001A82  bhi.b  $1ae7
001A84  bcc.b  $1aeb
001A86  bne.b  $1aef
001A88  bvc.b  $1af3
001A8A  bpl.b  $1af7
001A8C  bge.b  $1afb
001A8E  bgt.b  $1aff
001A90  moveq  #$71, d0
001A92  moveq  #$73, d1
001A94  moveq  #$75, d2
001A96  moveq  #$77, d3
001A98  moveq  #$79, d4
001A9A  moveq  #$30, d5
001A9C  move.w $35363738(a2, d3.w * 2), -(a0)
001AA4  move.w $2c21(a6), -(a4)
001AA8  move.w $47aa(pc), -(a7)
001AAC  lea.l  $60000.l, a0
001AB2  move.w #$3bff, d7
001AB6  clr.l  (a0)+
001AB8  dbra   d7, $1ab6
001ABC  rts    
001ABE  lea.l  $1c0.l, a0
001AC4  move.l #$2c4, d0
001ACA  moveq  #$0, d1
001ACC  moveq  #$8, d2
001ACE  move.w #$120, d3
001AD2  jsr    -$72(a6)
001AD6  jsr    -$11a(a6)
001ADA  move.w $1c(a0), d0
001ADE  or.w   d0, $1ae.l
001AE4  movem.l a4-a6, -(a7)
001AE8  lea.l  $dff002.l, a4
001AEE  bsr.w  $1aac
001AF2  lea.l  $30d8.l, a0
001AF8  lea.l  $29a.l, a1
001AFE  moveq  #$7, d7
001B00  move.w (a0)+, (a1)
001B02  lea.l  $4(a1), a1
001B06  dbra   d7, $1b00
001B0A  move.l #$60000, d0
001B10  lea.l  $282.l, a0
001B16  moveq  #$2, d7
001B18  move.w d0, $4(a0)
001B1C  swap   d0
001B1E  move.w d0, (a0)
001B20  swap   d0
001B22  addi.l #$5000, d0
001B28  lea.l  $8(a0), a0
001B2C  dbra   d7, $1b18
001B30  clr.l  $1a72.l
001B36  clr.l  $1a76.l
001B3C  clr.l  $1a7a.l
001B42  movem.l (a7)+, a4-a6
001B46  rts    
001B48  ori.b  #$84, d0
001B4C  ori.b  #$86, d0
001B50  ori.b  #$8a, d0
001B54  ori.b  #$0, d0
001B58  ori.b  #$0, d0
001B5C  ori.b  #$0, d0
001B60  ori.b  #$0, d0
001B64  ori.b  #$0, d0
001B68  ori.b  #$0, d0
001B6C  ori.b  #$0, d0
001B70  ori.b  #$0, d0
001B74  ori.b  #$0, d0
001B78  ori.b  #$0, d0
001B7C  ori.b  #$0, d0
001B80  ori.b  #$0, d0
001B84  ori.b  #$0, d0
001B88  ori.b  #$0, d0
001B8C  ori.b  #$0, d0
001B90  ori.b  #$0, d0
001B94  ori.b  #$0, d0
001B98  ori.b  #$0, d0
001B9C  ori.b  #$0, d0
001BA0  ori.b  #$0, d0
001BA4  ori.b  #$0, d0
001BA8  ori.b  #$0, d0
001BAC  ori.b  #$0, d0
001BB0  ori.b  #$0, d0
001BB4  ori.b  #$0, d0
001BB8  ori.b  #$0, d0
001BBC  ori.b  #$0, d0
001BC0  ori.b  #$0, d0
001BC4  ori.b  #$0, d0
001BC8  ori.b  #$0, d0
001BCC  ori.b  #$0, d0
001BD0  ori.b  #$0, d0
001BD4  ori.b  #$0, d0
001BD8  ori.b  #$0, d0
001BDC  ori.b  #$0, d0
001BE0  ori.b  #$0, d0
001BE4  ori.b  #$0, d0
001BE8  ori.b  #$0, d0
001BEC  ori.b  #$0, d0
001BF0  ori.b  #$0, d0
001BF4  ori.b  #$0, d0
001BF8  ori.b  #$0, d0
001BFC  ori.b  #$0, d0
001C00  ori.b  #$0, d0
001C04  ori.b  #$0, d0
001C08  ori.b  #$0, d0
001C0C  ori.b  #$0, d0
001C10  ori.b  #$0, d0
001C14  ori.b  #$0, d0
001C18  ori.b  #$0, d0
001C1C  ori.b  #$ff, d0
001C20  ; data: 0xff, 0xff
001C22  ; data: 0xff, 0xff
001C24  ; data: 0xff, 0xff
001C26  ; data: 0xff, 0xff
001C28  ; data: 0xff, 0xff
001C2A  ; data: 0xff, 0xff
001C2C  ; data: 0xff, 0xff
001C2E  ; data: 0xff, 0xff
001C30  ; data: 0xff, 0xff
001C32  ori.b  #$0, d0
001C36  ori.b  #$0, d0
001C3A  ori.b  #$0, d0
001C3E  ori.b  #$0, d0
001C42  ori.b  #$0, d0
001C46  ori.b  #$0, d0
001C4A  ori.b  #$0, d0
001C4E  ori.b  #$0, d0
001C52  ori.b  #$0, d0
001C56  ori.b  #$0, d0
001C5A  ori.b  #$0, d0
001C5E  ori.b  #$0, d0
001C62  ori.b  #$0, d0
001C66  ori.b  #$0, d0
001C6A  ori.b  #$0, d0
001C6E  ori.b  #$0, d0
001C72  ori.b  #$0, d0
001C76  ori.b  #$0, d0
001C7A  ori.b  #$0, d0
001C7E  ori.b  #$0, d0
001C82  ori.b  #$0, d0
001C86  ori.b  #$0, d0
001C8A  ori.b  #$0, d0
001C8E  ori.b  #$0, d0
001C92  ori.b  #$0, d0
001C96  ori.b  #$0, d0
001C9A  ori.b  #$0, d0
001C9E  ori.b  #$0, d0
001CA2  ori.b  #$0, d0
001CA6  ori.b  #$0, d0
001CAA  ori.b  #$0, d0
001CAE  ori.b  #$0, d0
001CB2  ori.b  #$0, d0
001CB6  ori.b  #$0, d0
001CBA  ori.b  #$0, d0
001CBE  ori.b  #$0, d0
001CC2  ori.b  #$0, d0
001CC6  ori.b  #$0, d0
001CCA  ori.b  #$0, d0
001CCE  ori.b  #$0, d0
001CD2  ori.b  #$0, d0
001CD6  ori.b  #$0, d0
001CDA  ori.b  #$0, d0
001CDE  ori.b  #$0, d0
001CE2  ori.b  #$0, d0
001CE6  ori.b  #$0, d0
001CEA  ori.b  #$0, d0
001CEE  ori.b  #$0, d0
001CF2  ori.b  #$0, d0
001CF6  ori.b  #$0, d0
001CFA  ; data: 0xff, 0xff
001CFC  ; data: 0xff, 0xff
001CFE  ; data: 0xff, 0xff
001D00  ; data: 0xff, 0xff
001D02  ; data: 0xff, 0xff
001D04  ; data: 0xff, 0xff
001D06  ; data: 0xff, 0xff
001D08  ; data: 0xff, 0xff
001D0A  ; data: 0xff, 0xff
001D0C  ; data: 0xff, 0xff
001D0E  ori.b  #$3a, d0
001D12  ori.b  #$62, d0
001D16  ori.b  #$0, d0
001D1A  ori.b  #$3c, d0
001D1E  ori.b  #$a2, d0
001D22  ori.b  #$0, d0
001D26  ori.b  #$f2, d0
001D2A  ori.b  #$22, d0
001D2E  ori.b  #$1, d0
001D32  ori.b  #$3e, d0
001D36  ori.b  #$22, d0
001D3A  ori.b  #$0, d0
001D3E  ori.b  #$40, d0
001D42  ori.b  #$62, d0
001D46  ori.b  #$0, d0
001D4A  ori.b  #$42, d0
001D4E  ori.b  #$2, d0
001D52  ori.b  #$0, d0
001D56  ori.b  #$44, d0
001D5A  ori.b  #$2, d0
001D5E  ori.b  #$0, d0
001D62  ori.b  #$46, d0
001D66  ori.b  #$2, d0
001D6A  ori.b  #$0, d0
001D6E  ori.b  #$48, d0
001D72  ori.b  #$2, d0
001D76  ori.b  #$0, d0
001D7A  ori.b  #$f4, d0
001D7E  ori.b  #$e2, d0
001D82  ori.b  #$1, d0
001D86  ori.b  #$4a, d0
001D8A  ori.b  #$a2, d0
001D8E  ori.b  #$0, d0
001D92  ori.b  #$4c, d0
001D96  ori.b  #$a2, d0
001D9A  ori.b  #$0, d0
001D9E  ori.b  #$4e, d0
001DA2  ori.b  #$a2, d0
001DA6  ori.b  #$0, d0
001DAA  ori.b  #$50, d0
001DAE  ori.b  #$e2, d0
001DB2  ori.b  #$0, d0
001DB6  ori.b  #$52, d0
001DBA  ori.b  #$62, d0
001DBE  ori.b  #$0, d0
001DC2  ori.b  #$54, d0
001DC6  ori.b  #$a2, d0
001DCA  ori.b  #$0, d0
001DCE  ori.b  #$56, d0
001DD2  ori.b  #$a2, d0
001DD6  ori.b  #$0, d0
001DDA  ori.b  #$58, d0
001DDE  ori.b  #$a2, d0
001DE2  ori.b  #$0, d0
001DE6  ori.b  #$5a, d0
001DEA  ori.b  #$a2, d0
001DEE  ori.b  #$0, d0
001DF2  ori.b  #$5c, d0
001DF6  ori.b  #$a2, d0
001DFA  ori.b  #$0, d0
001DFE  ori.b  #$5e, d0
001E02  ori.b  #$a2, d0
001E06  ori.b  #$0, d0
001E0A  ori.b  #$60, d0
001E0E  ori.b  #$a2, d0
001E12  ori.b  #$0, d0
001E16  ori.b  #$f6, d0
001E1A  ori.b  #$e2, d0
001E1E  ori.b  #$1, d0
001E22  ; data: 0xff, 0xff
001E24  ; data: 0xff, 0xff
001E26  ori.b  #$1, d0
001E2A  sub.b  d0, d0
001E2C  ori.b  #$0, d1
001E30  ori.b  #$0, d1
001E34  ori.b  #$0, d1
001E38  ori.b  #$0, d1
001E3C  ori.b  #$0, d1
001E40  ori.b  #$0, d1
001E44  ori.b  #$0, d1
001E48  ori.b  #$0, d1
001E4C  ori.b  #$0, d1
001E50  ori.b  #$0, d1
001E54  ori.b  #$0, d1
001E58  ori.b  #$0, d1
001E5C  ori.b  #$0, d1
001E60  ori.b  #$0, d1
001E64  ori.b  #$0, d1
001E68  ori.b  #$0, d1
001E6C  ori.b  #$0, d1
001E70  ori.b  #$0, d1
001E74  ori.b  #$0, d1
001E78  ori.b  #$0, d1
001E7C  ori.b  #$0, d1
001E80  ori.b  #$0, d1
001E84  ori.b  #$0, d1
001E88  ori.b  #$0, d1
001E8C  ori.b  #$0, d1
001E90  ori.b  #$0, d1
001E94  ori.b  #$0, d1
001E98  ori.b  #$0, d1
001E9C  ori.b  #$0, d1
001EA0  ori.b  #$0, d1
001EA4  ori.b  #$0, d1
001EA8  ori.b  #$0, d1
001EAC  ori.b  #$0, d1
001EB0  ori.b  #$0, d1
001EB4  ori.b  #$0, d1
001EB8  ori.b  #$0, d1
001EBC  ori.b  #$0, d1
001EC0  ori.b  #$0, d1
001EC4  ori.b  #$0, d1
001EC8  ori.b  #$0, d1
001ECC  ori.b  #$0, d1
001ED0  ori.b  #$0, d1
001ED4  ori.b  #$0, d1
001ED8  ori.b  #$0, d1
001EDC  ori.b  #$0, d1
001EE0  ori.b  #$0, d1
001EE4  ori.b  #$0, d1
001EE8  ori.b  #$0, d1
001EEC  ori.b  #$0, d1
001EF0  ori.b  #$0, d1
001EF4  ori.b  #$0, d1
001EF8  ori.b  #$0, d1
001EFC  ori.b  #$0, d1
001F00  ori.b  #$0, d1
001F04  ori.b  #$0, d1
001F08  ori.b  #$0, d1
001F0C  ori.b  #$0, d1
001F10  ori.b  #$0, d1
001F14  ori.b  #$0, d1
001F18  ori.b  #$0, d1
001F1C  ori.b  #$0, d1
001F20  ori.b  #$0, d1
001F24  ori.b  #$0, d1
001F28  ori.b  #$0, d1
001F2C  ori.b  #$0, d1
001F30  ori.b  #$0, d1
001F34  ori.b  #$0, d1
001F38  ori.b  #$0, d1
001F3C  ori.b  #$0, d1
001F40  ori.b  #$0, d1
001F44  ori.b  #$0, d1
001F48  ori.b  #$0, d1
001F4C  ori.b  #$0, d1
001F50  ori.b  #$0, d1
001F54  ori.b  #$0, d1
001F58  ori.b  #$0, d1
001F5C  ori.b  #$0, d1
001F60  ori.b  #$0, d1
001F64  ori.b  #$0, d1
001F68  ori.b  #$0, d1
001F6C  ori.b  #$0, d1
001F70  ori.b  #$0, d1
001F74  ori.b  #$0, d1
001F78  ori.b  #$0, d1
001F7C  ori.b  #$0, d1
001F80  ori.b  #$0, d1
001F84  ori.b  #$0, d1
001F88  ori.b  #$0, d1
001F8C  ori.b  #$0, d1
001F90  ori.b  #$0, d1
001F94  ori.b  #$0, d1
001F98  ori.b  #$0, d1
001F9C  ori.b  #$0, d1
001FA0  ori.b  #$0, d1
001FA4  ori.b  #$0, d1
001FA8  ori.b  #$0, d1
001FAC  ori.b  #$0, d1
001FB0  ori.b  #$0, d1
001FB4  ori.b  #$0, d1
001FB8  ori.b  #$0, d1
001FBC  ori.b  #$0, d1
001FC0  ori.b  #$0, d1
001FC4  ori.b  #$0, d1
001FC8  ori.b  #$0, d1
001FCC  ori.b  #$0, d1
001FD0  ori.b  #$0, d1
001FD4  ori.b  #$0, d1
001FD8  ori.b  #$0, d1
001FDC  ori.b  #$0, d1
001FE0  ori.b  #$0, d1
001FE4  ori.b  #$0, d1
001FE8  ori.b  #$0, d1
001FEC  ori.b  #$0, d1
001FF0  ori.b  #$0, d1
001FF4  ori.b  #$0, d1
001FF8  ori.b  #$0, d1
001FFC  ori.b  #$0, d1
002000  ori.b  #$0, d1
002004  ori.b  #$0, d1
002008  ori.b  #$0, d1
00200C  ori.b  #$0, d1
002010  ori.b  #$0, d1
002014  ori.b  #$0, d1
002018  ori.b  #$0, d1
00201C  ori.b  #$0, d1
002020  ori.b  #$0, d1
002024  ori.b  #$0, d1
002028  ori.b  #$0, d1
00202C  ori.b  #$0, d1
002030  ori.b  #$0, d1
002034  ori.b  #$0, d1
002038  ori.b  #$0, d1
00203C  ori.b  #$0, d1
002040  ori.b  #$0, d1
002044  ori.b  #$0, d1
002048  ori.b  #$0, d1
00204C  ori.b  #$0, d1
002050  ori.b  #$0, d1
002054  ori.b  #$0, d1
002058  ori.b  #$0, d1
00205C  ori.b  #$0, d1
002060  ori.b  #$0, d1
002064  ori.b  #$0, d1
002068  ori.b  #$0, d1
00206C  ori.b  #$0, d1
002070  ori.b  #$0, d1
002074  ori.b  #$0, d1
002078  ori.b  #$0, d1
00207C  ori.b  #$0, d1
002080  ori.b  #$0, d1
002084  ori.b  #$0, d1
002088  ori.b  #$0, d1
00208C  ori.b  #$0, d1
002090  ori.b  #$0, d1
002094  ori.b  #$0, d1
002098  ori.b  #$0, d1
00209C  ori.b  #$0, d1
0020A0  ori.b  #$0, d1
0020A4  ori.b  #$0, d1
0020A8  ori.b  #$0, d1
0020AC  ori.b  #$0, d1
0020B0  ori.b  #$0, d1
0020B4  ori.b  #$0, d1
0020B8  ori.b  #$0, d1
0020BC  ori.b  #$0, d1
0020C0  ori.b  #$0, d1
0020C4  ori.b  #$0, d1
0020C8  ori.b  #$0, d1
0020CC  ori.b  #$0, d1
0020D0  ori.b  #$0, d1
0020D4  ori.b  #$0, d1
0020D8  ori.b  #$0, d1
0020DC  ori.b  #$0, d1
0020E0  ori.b  #$0, d1
0020E4  ori.b  #$0, d1
0020E8  ori.b  #$0, d1
0020EC  ori.b  #$0, d1
0020F0  ori.b  #$0, d1
0020F4  ori.b  #$0, d1
0020F8  ori.b  #$0, d1
0020FC  ori.b  #$0, d1
002100  ori.b  #$0, d1
002104  ori.b  #$0, d1
002108  ori.b  #$0, d1
00210C  ori.b  #$0, d1
002110  ori.b  #$0, d1
002114  ori.b  #$0, d1
002118  ori.b  #$0, d1
00211C  ori.b  #$0, d1
002120  ori.b  #$0, d1
002124  ori.b  #$0, d1
002128  ori.b  #$0, d1
00212C  ori.b  #$0, d1
002130  ori.b  #$0, d1
002134  ori.b  #$0, d1
002138  ori.b  #$0, d1
00213C  ori.b  #$0, d1
002140  ori.b  #$0, d1
002144  ori.b  #$0, d1
002148  ori.b  #$0, d1
00214C  ori.b  #$0, d1
002150  ori.b  #$0, d1
002154  ori.b  #$0, d1
002158  ori.b  #$0, d1
00215C  ori.b  #$0, d1
002160  ori.b  #$0, d1
002164  ori.b  #$0, d1
002168  ori.b  #$0, d1
00216C  ori.b  #$0, d1
002170  ori.b  #$0, d1
002174  ori.b  #$0, d1
002178  ori.b  #$0, d1
00217C  ori.b  #$0, d1
002180  ori.b  #$0, d1
002184  ori.b  #$0, d1
002188  ori.b  #$0, d1
00218C  ori.b  #$0, d1
002190  ori.b  #$0, d1
002194  ori.b  #$0, d1
002198  ori.b  #$0, d1
00219C  ori.b  #$0, d1
0021A0  ori.b  #$0, d1
0021A4  ori.b  #$0, d1
0021A8  ori.b  #$0, d1
0021AC  ori.b  #$0, d1
0021B0  ori.b  #$0, d1
0021B4  ori.b  #$0, d1
0021B8  ori.b  #$0, d1
0021BC  ori.b  #$0, d1
0021C0  ori.b  #$0, d1
0021C4  ori.b  #$0, d1
0021C8  ori.b  #$0, d1
0021CC  ori.b  #$0, d1
0021D0  ori.b  #$0, d1
0021D4  ori.b  #$0, d1
0021D8  ori.b  #$0, d1
0021DC  ori.b  #$0, d1
0021E0  ori.b  #$0, d1
0021E4  ori.b  #$0, d1
0021E8  ori.b  #$0, d1
0021EC  ori.b  #$0, d1
0021F0  ori.b  #$0, d1
0021F4  ori.b  #$0, d1
0021F8  ori.b  #$0, d1
0021FC  ori.b  #$0, d1
002200  ori.b  #$0, d1
002204  ori.b  #$0, d1
002208  ori.b  #$0, d1
00220C  ori.b  #$0, d1
002210  ori.b  #$0, d1
002214  ori.b  #$0, d1
002218  ori.b  #$0, d1
00221C  ori.b  #$0, d1
002220  ori.b  #$0, d1
002224  ori.b  #$0, d1
002228  ori.b  #$0, d1
00222C  ori.b  #$0, d1
002230  ori.b  #$0, d1
002234  ori.b  #$0, d1
002238  ori.b  #$0, d1
00223C  ori.b  #$0, d1
002240  ori.b  #$0, d1
002244  ori.b  #$0, d1
002248  ori.b  #$0, d1
00224C  ori.b  #$0, d1
002250  ori.b  #$0, d1
002254  ori.b  #$0, d1
002258  ori.b  #$0, d1
00225C  ori.b  #$0, d1
002260  ori.b  #$0, d1
002264  ori.b  #$0, d1
002268  ori.b  #$0, d1
00226C  ori.b  #$0, d1
002270  ori.b  #$0, d1
002274  ori.b  #$0, d1
002278  ori.b  #$0, d1
00227C  ori.b  #$0, d1
002280  ori.b  #$0, d1
002284  ori.b  #$0, d1
002288  ori.b  #$0, d1
00228C  ori.b  #$0, d1
002290  ori.b  #$0, d1
002294  ori.b  #$0, d1
002298  ori.b  #$0, d1
00229C  ori.b  #$0, d1
0022A0  ori.b  #$0, d1
0022A4  ori.b  #$0, d1
0022A8  ori.b  #$0, d1
0022AC  ori.b  #$0, d1
0022B0  ori.b  #$0, d1
0022B4  ori.b  #$0, d1
0022B8  ori.b  #$0, d1
0022BC  ori.b  #$0, d1
0022C0  ori.b  #$0, d1
0022C4  ori.b  #$0, d1
0022C8  ori.b  #$0, d1
0022CC  ori.b  #$0, d1
0022D0  ori.b  #$0, d1
0022D4  ori.b  #$0, d1
0022D8  ori.b  #$0, d1
0022DC  ori.b  #$0, d1
0022E0  ori.b  #$0, d1
0022E4  ori.b  #$0, d1
0022E8  ori.b  #$0, d1
0022EC  ori.b  #$0, d1
0022F0  ori.b  #$0, d1
0022F4  ori.b  #$0, d1
0022F8  ori.b  #$0, d1
0022FC  ori.b  #$0, d1
002300  ori.b  #$0, d1
002304  ori.b  #$0, d1
002308  ori.b  #$0, d1
00230C  ori.b  #$0, d1
002310  ori.b  #$0, d1
002314  ori.b  #$0, d1
002318  ori.b  #$0, d1
00231C  ori.b  #$0, d1
002320  ori.b  #$0, d1
002324  ori.b  #$0, d1
002328  ori.b  #$0, d1
00232C  ori.b  #$0, d1
002330  ori.b  #$0, d1
002334  ori.b  #$0, d1
002338  ori.b  #$0, d1
00233C  ori.b  #$0, d1
002340  ori.b  #$0, d1
002344  ori.b  #$0, d1
002348  ori.b  #$0, d1
00234C  ori.b  #$0, d1
002350  ori.b  #$0, d1
002354  ori.b  #$0, d1
002358  ori.b  #$0, d1
00235C  ori.b  #$0, d1
002360  ori.b  #$0, d1
002364  ori.b  #$0, d1
002368  ori.b  #$0, d1
00236C  ori.b  #$0, d1
002370  ori.b  #$0, d1
002374  ori.b  #$0, d1
002378  ori.b  #$0, d1
00237C  ori.b  #$0, d1
002380  ori.b  #$0, d1
002384  ori.b  #$0, d1
002388  ori.b  #$0, d1
00238C  ori.b  #$0, d1
002390  ori.b  #$0, d1
002394  ori.b  #$0, d1
002398  ori.b  #$0, d1
00239C  ori.b  #$0, d1
0023A0  ori.b  #$0, d1
0023A4  ori.b  #$0, d1
0023A8  ori.b  #$0, d1
0023AC  ori.b  #$0, d1
0023B0  ori.b  #$0, d1
0023B4  ori.b  #$0, d1
0023B8  ori.b  #$0, d1
0023BC  ori.b  #$0, d1
0023C0  ori.b  #$0, d1
0023C4  ori.b  #$0, d1
0023C8  ori.b  #$0, d1
0023CC  ori.b  #$0, d1
0023D0  ori.b  #$0, d1
0023D4  ori.b  #$0, d1
0023D8  ori.b  #$0, d1
0023DC  ori.b  #$0, d1
0023E0  ori.b  #$0, d1
0023E4  ori.b  #$0, d1
0023E8  ori.b  #$0, d1
0023EC  ori.b  #$0, d1
0023F0  ori.b  #$0, d1
0023F4  ori.b  #$0, d1
0023F8  ori.b  #$0, d1
0023FC  ori.b  #$0, d1
002400  ori.b  #$0, d1
002404  ori.b  #$0, d1
002408  ori.b  #$0, d1
00240C  ori.b  #$0, d1
002410  ori.b  #$0, d1
002414  ori.b  #$0, d1
002418  ori.b  #$0, d1
00241C  ori.b  #$0, d1
002420  ori.b  #$0, d1
002424  ori.b  #$0, d1
002428  ori.b  #$0, d1
00242C  ori.b  #$0, d1
002430  ori.b  #$0, d1
002434  ori.b  #$0, d1
002438  ori.b  #$0, d1
00243C  ori.b  #$0, d1
002440  ori.b  #$0, d1
002444  ori.b  #$0, d1
002448  ori.b  #$0, d1
00244C  ori.b  #$0, d1
002450  ori.b  #$0, d1
002454  ori.b  #$0, d1
002458  ori.b  #$0, d1
00245C  ori.b  #$0, d1
002460  ori.b  #$0, d1
002464  ori.b  #$0, d1
002468  ori.b  #$0, d1
00246C  ori.b  #$0, d1
002470  ori.b  #$0, d1
002474  ori.b  #$0, d1
002478  ori.b  #$0, d1
00247C  ori.b  #$0, d1
002480  ori.b  #$0, d1
002484  ori.b  #$0, d1
002488  ori.b  #$0, d1
00248C  ori.b  #$0, d1
002490  ori.b  #$0, d1
002494  ori.b  #$0, d1
002498  ori.b  #$0, d1
00249C  ori.b  #$0, d1
0024A0  ori.b  #$0, d1
0024A4  ori.b  #$0, d1
0024A8  ori.b  #$0, d1
0024AC  ori.b  #$0, d1
0024B0  ori.b  #$0, d1
0024B4  ori.b  #$0, d1
0024B8  ori.b  #$0, d1
0024BC  ori.b  #$0, d1
0024C0  ori.b  #$0, d1
0024C4  ori.b  #$0, d1
0024C8  ori.b  #$0, d1
0024CC  ori.b  #$0, d1
0024D0  ori.b  #$0, d1
0024D4  ori.b  #$0, d1
0024D8  ori.b  #$0, d1
0024DC  ori.b  #$0, d1
0024E0  ori.b  #$0, d1
0024E4  ori.b  #$0, d1
0024E8  ori.b  #$0, d1
0024EC  ori.b  #$0, d1
0024F0  ori.b  #$0, d1
0024F4  ori.b  #$0, d1
0024F8  ori.b  #$0, d1
0024FC  ori.b  #$0, d1
002500  ori.b  #$0, d1
002504  ori.b  #$0, d1
002508  ori.b  #$0, d1
00250C  ori.b  #$0, d1
002510  ori.b  #$0, d1
002514  ori.b  #$0, d1
002518  ori.b  #$0, d1
00251C  ori.b  #$0, d1
002520  ori.b  #$0, d1
002524  ori.b  #$0, d1
002528  ori.b  #$0, d1
00252C  ori.b  #$0, d1
002530  ori.b  #$0, d1
002534  ori.b  #$0, d1
002538  ori.b  #$0, d1
00253C  ori.b  #$0, d1
002540  ori.b  #$0, d1
002544  ori.b  #$0, d1
002548  ori.b  #$0, d1
00254C  ori.b  #$0, d1
002550  ori.b  #$0, d1
002554  ori.b  #$0, d1
002558  ori.b  #$0, d1
00255C  ori.b  #$0, d1
002560  ori.b  #$0, d1
002564  ori.b  #$0, d1
002568  ori.b  #$0, d1
00256C  ori.b  #$0, d1
002570  ori.b  #$0, d1
002574  ori.b  #$0, d1
002578  ori.b  #$0, d1
00257C  ori.b  #$0, d1
002580  ori.b  #$0, d1
002584  ori.b  #$0, d1
002588  ori.b  #$0, d1
00258C  ori.b  #$0, d1
002590  ori.b  #$0, d1
002594  ori.b  #$0, d1
002598  ori.b  #$0, d1
00259C  ori.b  #$0, d1
0025A0  ori.b  #$0, d1
0025A4  ori.b  #$0, d1
0025A8  ori.b  #$0, d1
0025AC  ori.b  #$0, d1
0025B0  ori.b  #$0, d1
0025B4  ori.b  #$0, d1
0025B8  ori.b  #$0, d1
0025BC  ori.b  #$0, d1
0025C0  ori.b  #$0, d1
0025C4  ori.b  #$0, d1
0025C8  ori.b  #$0, d1
0025CC  ori.b  #$0, d1
0025D0  ori.b  #$0, d1
0025D4  ori.b  #$0, d1
0025D8  ori.b  #$0, d1
0025DC  ori.b  #$0, d1
0025E0  ori.b  #$0, d1
0025E4  ori.b  #$0, d1
0025E8  ori.b  #$0, d1
0025EC  ori.b  #$0, d1
0025F0  ori.b  #$0, d1
0025F4  ori.b  #$0, d1
0025F8  ori.b  #$0, d1
0025FC  ori.b  #$0, d1
002600  ori.b  #$0, d1
002604  ori.b  #$0, d1
002608  ori.b  #$0, d1
00260C  ori.b  #$0, d1
002610  ori.b  #$0, d1
002614  ori.b  #$0, d1
002618  ori.b  #$0, d1
00261C  ori.b  #$0, d1
002620  ori.b  #$0, d1
002624  ori.b  #$0, d1
002628  ori.b  #$0, d1
00262C  ori.b  #$0, d1
002630  ori.b  #$0, d1
002634  ori.b  #$0, d1
002638  ori.b  #$0, d1
00263C  ori.b  #$0, d1
002640  ori.b  #$0, d1
002644  ori.b  #$0, d1
002648  ori.b  #$0, d1
00264C  ori.b  #$0, d1
002650  ori.b  #$0, d1
002654  ori.b  #$0, d1
002658  ori.b  #$0, d1
00265C  ori.b  #$0, d1
002660  ori.b  #$0, d1
002664  ori.b  #$0, d1
002668  ori.b  #$0, d1
00266C  ori.b  #$0, d1
002670  ori.b  #$0, d1
002674  ori.b  #$0, d1
002678  ori.b  #$0, d1
00267C  ori.b  #$0, d1
002680  ori.b  #$0, d1
002684  ori.b  #$0, d1
002688  ori.b  #$0, d1
00268C  ori.b  #$0, d1
002690  ori.b  #$0, d1
002694  ori.b  #$0, d1
002698  ori.b  #$0, d1
00269C  ori.b  #$0, d1
0026A0  ori.b  #$0, d1
0026A4  ori.b  #$0, d1
0026A8  ori.b  #$0, d1
0026AC  ori.b  #$0, d1
0026B0  ori.b  #$0, d1
0026B4  ori.b  #$0, d1
0026B8  ori.b  #$0, d1
0026BC  ori.b  #$0, d1
0026C0  ori.b  #$0, d1
0026C4  ori.b  #$0, d1
0026C8  ori.b  #$0, d1
0026CC  ori.b  #$0, d1
0026D0  ori.b  #$0, d1
0026D4  ori.b  #$0, d1
0026D8  ori.b  #$0, d1
0026DC  ori.b  #$0, d1
0026E0  ori.b  #$0, d1
0026E4  ori.b  #$0, d1
0026E8  ori.b  #$0, d1
0026EC  ori.b  #$0, d1
0026F0  ori.b  #$0, d1
0026F4  ori.b  #$0, d1
0026F8  ori.b  #$0, d1
0026FC  ori.b  #$0, d1
002700  ori.b  #$0, d1
002704  ori.b  #$0, d1
002708  ori.b  #$0, d1
00270C  ; data: 0xff, 0xff
00270E  bra.w  $2711
002712  sub.b  d0, d0
002714  ; data: 0xff, 0xfe
002716  or.b   d0, d0
002718  ori.b  #$0, d1
00271C  ori.b  #$0, d1
002720  ori.b  #$0, d1
002724  ori.b  #$0, d1
002728  ori.b  #$0, d1
00272C  ori.b  #$0, d0
002730  ori.b  #$0, d1
002734  ori.b  #$0, d0
002738  ori.b  #$0, d1
00273C  ori.b  #$0, d0
002740  ori.b  #$0, d1
002744  ori.b  #$0, d0
002748  ori.b  #$0, d1
00274C  ori.b  #$0, d0
002750  ori.b  #$0, d1
002754  ori.b  #$0, d0
002758  ori.b  #$0, d1
00275C  ori.b  #$0, d0
002760  ori.b  #$0, d1
002764  ori.b  #$0, d0
002768  ori.b  #$0, d1
00276C  ori.b  #$0, d0
002770  ori.b  #$0, d1
002774  ori.b  #$0, d0
002778  ori.b  #$0, d1
00277C  ori.b  #$0, d0
002780  ori.b  #$0, d1
002784  ori.b  #$0, d0
002788  ori.b  #$0, d1
00278C  ori.b  #$0, d0
002790  ori.b  #$0, d1
002794  ori.b  #$0, d0
002798  ori.b  #$0, d1
00279C  ori.b  #$0, d0
0027A0  ori.b  #$0, d1
0027A4  ori.b  #$0, d0
0027A8  ori.b  #$0, d1
0027AC  ori.b  #$0, d0
0027B0  ori.b  #$0, d1
0027B4  ori.b  #$0, d0
0027B8  ori.b  #$0, d1
0027BC  ori.b  #$0, d0
0027C0  ori.b  #$0, d1
0027C4  ori.b  #$0, d0
0027C8  ori.b  #$0, d1
0027CC  ori.b  #$0, d0
0027D0  ori.b  #$0, d1
0027D4  ori.b  #$0, d0
0027D8  ori.b  #$0, d1
0027DC  ; data: 0xff, 0xff
0027DE  asr.b  #$8, d0
0027E0  ori.b  #$0, d1
0027E4  ori.b  #$0, d0
0027E8  ori.b  #$0, d1
0027EC  ori.b  #$0, d0
0027F0  ori.b  #$0, d1
0027F4  ori.b  #$0, d0
0027F8  ori.b  #$0, d1
0027FC  ori.b  #$0, d0
002800  ori.b  #$0, d1
002804  ori.b  #$0, d0
002808  ori.b  #$0, d1
00280C  ; data: 0xff, 0xff
00280E  asr.b  #$8, d0
002810  ori.b  #$0, d1
002814  ori.b  #$0, d0
002818  ori.b  #$0, d1
00281C  ori.b  #$0, d0
002820  ori.b  #$0, d1
002824  ori.b  #$0, d0
002828  ori.b  #$0, d1
00282C  ori.b  #$0, d0
002830  ori.b  #$0, d1
002834  ori.b  #$0, d0
002838  ori.b  #$0, d1
00283C  ; data: 0xff, 0xff
00283E  asr.b  #$8, d0
002840  ori.b  #$0, d1
002844  ori.b  #$0, d0
002848  ori.b  #$0, d1
00284C  ori.b  #$0, d0
002850  ori.b  #$0, d1
002854  ori.b  #$0, d0
002858  ori.b  #$0, d1
00285C  ori.b  #$0, d0
002860  ori.b  #$0, d1
002864  ori.b  #$0, d0
002868  ori.b  #$0, d1
00286C  ; data: 0xff, 0xff
00286E  asr.b  #$8, d0
002870  ori.b  #$0, d1
002874  ori.b  #$0, d0
002878  ori.b  #$0, d1
00287C  ori.b  #$0, d0
002880  ori.b  #$0, d1
002884  ori.b  #$0, d0
002888  ori.b  #$0, d1
00288C  ori.b  #$0, d0
002890  ori.b  #$0, d1
002894  ori.b  #$0, d0
002898  ori.b  #$0, d1
00289C  ; data: 0xff, 0xff
00289E  asr.b  #$8, d0
0028A0  ori.b  #$0, d1
0028A4  ori.b  #$0, d0
0028A8  ori.b  #$0, d1
0028AC  ori.b  #$0, d0
0028B0  ori.b  #$0, d1
0028B4  ori.b  #$0, d0
0028B8  ori.b  #$0, d1
0028BC  ori.b  #$0, d0
0028C0  ori.b  #$0, d1
0028C4  ori.b  #$0, d0
0028C8  ori.b  #$0, d1
0028CC  ; data: 0xff, 0xff
0028CE  asr.b  #$8, d0
0028D0  ori.b  #$0, d1
0028D4  ori.b  #$0, d0
0028D8  ori.b  #$0, d1
0028DC  ori.b  #$0, d0
0028E0  ori.b  #$0, d1
0028E4  ori.b  #$0, d0
0028E8  ori.b  #$0, d1
0028EC  ori.b  #$0, d0
0028F0  ori.b  #$0, d1
0028F4  ori.b  #$0, d0
0028F8  ori.b  #$0, d1
0028FC  ori.b  #$0, d0
002900  ori.b  #$0, d1
002904  ori.b  #$0, d0
002908  ori.b  #$0, d1
00290C  ori.b  #$0, d0
002910  ori.b  #$0, d1
002914  ori.b  #$0, d0
002918  ori.b  #$0, d1
00291C  ori.b  #$0, d0
002920  ori.b  #$0, d1
002924  ori.b  #$0, d0
002928  ori.b  #$0, d1
00292C  ori.b  #$0, d0
002930  ori.b  #$0, d1
002934  ori.b  #$0, d0
002938  ori.b  #$0, d1
00293C  ori.b  #$0, d0
002940  ori.b  #$0, d1
002944  ori.b  #$0, d0
002948  ori.b  #$0, d1
00294C  ori.b  #$0, d0
002950  ori.b  #$0, d1
002954  ori.b  #$0, d0
002958  ori.b  #$0, d1
00295C  ori.b  #$0, d0
002960  ori.b  #$0, d1
002964  ori.b  #$0, d0
002968  ori.b  #$0, d1
00296C  ori.b  #$0, d0
002970  ori.b  #$0, d1
002974  ori.b  #$0, d0
002978  ori.b  #$0, d1
00297C  ori.b  #$0, d0
002980  ori.b  #$0, d1
002984  ori.b  #$0, d0
002988  ori.b  #$0, d1
00298C  ori.b  #$0, d0
002990  ori.b  #$0, d1
002994  ori.b  #$0, d0
002998  ori.b  #$0, d1
00299C  ori.b  #$0, d0
0029A0  ori.b  #$0, d1
0029A4  ori.b  #$0, d0
0029A8  ori.b  #$0, d1
0029AC  ori.b  #$0, d0
0029B0  ori.b  #$0, d1
0029B4  ori.b  #$0, d0
0029B8  ori.b  #$0, d1
0029BC  ori.b  #$0, d0
0029C0  ori.b  #$0, d1
0029C4  ori.b  #$0, d0
0029C8  ori.b  #$0, d1
0029CC  ori.b  #$0, d0
0029D0  ori.b  #$0, d1
0029D4  ori.b  #$0, d0
0029D8  ori.b  #$0, d1
0029DC  ori.b  #$0, d0
0029E0  ori.b  #$0, d1
0029E4  ori.b  #$0, d0
0029E8  ori.b  #$0, d1
0029EC  ori.b  #$0, d0
0029F0  ori.b  #$0, d1
0029F4  ori.b  #$0, d0
0029F8  ori.b  #$0, d1
0029FC  ori.b  #$0, d0
002A00  ori.b  #$0, d1
002A04  ori.b  #$0, d0
002A08  ori.b  #$0, d1
002A0C  ; data: 0xff, 0xff
002A0E  asr.b  #$8, d0
002A10  ori.b  #$0, d1
002A14  ori.b  #$0, d0
002A18  ori.b  #$0, d1
002A1C  ori.b  #$0, d0
002A20  ori.b  #$0, d1
002A24  ori.b  #$0, d0
002A28  ori.b  #$0, d1
002A2C  ori.b  #$0, d0
002A30  ori.b  #$0, d1
002A34  ori.b  #$0, d0
002A38  ori.b  #$0, d1
002A3C  ; data: 0xff, 0xff
002A3E  asr.b  #$8, d0
002A40  ori.b  #$0, d1
002A44  ori.b  #$0, d0
002A48  ori.b  #$0, d1
002A4C  ori.b  #$0, d0
002A50  ori.b  #$0, d1
002A54  ori.b  #$0, d0
002A58  ori.b  #$0, d1
002A5C  ori.b  #$0, d0
002A60  ori.b  #$0, d1
002A64  ori.b  #$0, d0
002A68  ori.b  #$0, d1
002A6C  ; data: 0xff, 0xff
002A6E  asr.b  #$8, d0
002A70  ori.b  #$0, d1
002A74  ori.b  #$0, d0
002A78  ori.b  #$0, d1
002A7C  ori.b  #$0, d0
002A80  ori.b  #$0, d1
002A84  ori.b  #$0, d0
002A88  ori.b  #$0, d1
002A8C  ori.b  #$0, d0
002A90  ori.b  #$0, d1
002A94  ori.b  #$0, d0
002A98  ori.b  #$0, d1
002A9C  ori.b  #$0, d0
002AA0  ori.b  #$0, d1
002AA4  ori.b  #$0, d0
002AA8  ori.b  #$0, d1
002AAC  ori.b  #$0, d0
002AB0  ori.b  #$0, d1
002AB4  ori.b  #$0, d0
002AB8  ori.b  #$0, d1
002ABC  ori.b  #$0, d0
002AC0  ori.b  #$0, d1
002AC4  ori.b  #$0, d0
002AC8  ori.b  #$0, d1
002ACC  ori.b  #$0, d0
002AD0  ori.b  #$0, d1
002AD4  ori.b  #$0, d0
002AD8  ori.b  #$0, d1
002ADC  ori.b  #$0, d0
002AE0  ori.b  #$0, d1
002AE4  ori.b  #$0, d0
002AE8  ori.b  #$0, d1
002AEC  ori.b  #$0, d0
002AF0  ori.b  #$0, d1
002AF4  ori.b  #$0, d0
002AF8  ori.b  #$0, d1
002AFC  ori.b  #$0, d0
002B00  ori.b  #$0, d1
002B04  ori.b  #$0, d0
002B08  ori.b  #$0, d1
002B0C  ori.b  #$0, d0
002B10  ori.b  #$0, d1
002B14  ori.b  #$0, d0
002B18  ori.b  #$0, d1
002B1C  ori.b  #$0, d0
002B20  ori.b  #$0, d1
002B24  ori.b  #$0, d0
002B28  ori.b  #$0, d1
002B2C  ori.b  #$0, d0
002B30  ori.b  #$0, d1
002B34  ori.b  #$0, d0
002B38  ori.b  #$0, d1
002B3C  ori.b  #$0, d0
002B40  ori.b  #$0, d1
002B44  ori.b  #$0, d0
002B48  ori.b  #$0, d1
002B4C  ori.b  #$0, d0
002B50  ori.b  #$0, d1
002B54  ori.b  #$0, d0
002B58  ori.b  #$0, d1
002B5C  ori.b  #$0, d0
002B60  ori.b  #$0, d1
002B64  ori.b  #$0, d0
002B68  ori.b  #$0, d1
002B6C  ori.b  #$0, d0
002B70  ori.b  #$0, d1
002B74  ori.b  #$0, d0
002B78  ori.b  #$0, d1
002B7C  ori.b  #$0, d0
002B80  ori.b  #$0, d1
002B84  ori.b  #$0, d0
002B88  ori.b  #$0, d1
002B8C  ori.b  #$0, d0
002B90  ori.b  #$0, d1
002B94  ori.b  #$0, d0
002B98  ori.b  #$0, d1
002B9C  ; data: 0xff, 0xff
002B9E  asr.b  #$8, d0
002BA0  ori.b  #$0, d1
002BA4  ori.b  #$0, d0
002BA8  ori.b  #$0, d1
002BAC  ori.b  #$0, d0
002BB0  ori.b  #$0, d1
002BB4  ori.b  #$0, d0
002BB8  ori.b  #$0, d1
002BBC  ori.b  #$0, d0
002BC0  ori.b  #$0, d1
002BC4  ori.b  #$0, d0
002BC8  ori.b  #$0, d1
002BCC  ; data: 0xff, 0xff
002BCE  asr.b  #$8, d0
002BD0  ori.b  #$0, d1
002BD4  ori.b  #$0, d0
002BD8  ori.b  #$0, d1
002BDC  ori.b  #$0, d0
002BE0  ori.b  #$0, d1
002BE4  ori.b  #$0, d0
002BE8  ori.b  #$0, d1
002BEC  ori.b  #$0, d0
002BF0  ori.b  #$0, d1
002BF4  ori.b  #$0, d0
002BF8  ori.b  #$0, d1
002BFC  ; data: 0xff, 0xff
002BFE  asr.b  #$8, d0
002C00  ori.b  #$0, d1
002C04  ori.b  #$0, d0
002C08  ori.b  #$0, d1
002C0C  ori.b  #$0, d0
002C10  ori.b  #$0, d1
002C14  ori.b  #$0, d0
002C18  ori.b  #$0, d1
002C1C  ori.b  #$0, d0
002C20  ori.b  #$0, d1
002C24  ori.b  #$0, d0
002C28  ori.b  #$0, d1
002C2C  ori.b  #$0, d0
002C30  ori.b  #$0, d1
002C34  ori.b  #$0, d0
002C38  ori.b  #$0, d1
002C3C  ori.b  #$0, d0
002C40  ori.b  #$0, d1
002C44  ori.b  #$0, d0
002C48  ori.b  #$0, d1
002C4C  ori.b  #$0, d0
002C50  ori.b  #$0, d1
002C54  ori.b  #$0, d0
002C58  ori.b  #$0, d1
002C5C  ori.b  #$0, d0
002C60  ori.b  #$0, d1
002C64  ori.b  #$0, d0
002C68  ori.b  #$0, d1
002C6C  ori.b  #$0, d0
002C70  ori.b  #$0, d1
002C74  ori.b  #$0, d0
002C78  ori.b  #$0, d1
002C7C  ori.b  #$0, d0
002C80  ori.b  #$0, d1
002C84  ori.b  #$0, d0
002C88  ori.b  #$0, d1
002C8C  ori.b  #$0, d0
002C90  ori.b  #$0, d1
002C94  ori.b  #$0, d0
002C98  ori.b  #$0, d1
002C9C  ori.b  #$0, d0
002CA0  ori.b  #$0, d1
002CA4  ori.b  #$0, d0
002CA8  ori.b  #$0, d1
002CAC  ori.b  #$0, d0
002CB0  ori.b  #$0, d1
002CB4  ori.b  #$0, d0
002CB8  ori.b  #$0, d1
002CBC  ori.b  #$0, d0
002CC0  ori.b  #$0, d1
002CC4  ori.b  #$0, d0
002CC8  ori.b  #$0, d1
002CCC  ori.b  #$0, d0
002CD0  ori.b  #$0, d1
002CD4  ori.b  #$0, d0
002CD8  ori.b  #$0, d1
002CDC  ori.b  #$0, d0
002CE0  ori.b  #$0, d1
002CE4  ori.b  #$0, d0
002CE8  ori.b  #$0, d1
002CEC  ori.b  #$0, d0
002CF0  ori.b  #$0, d1
002CF4  ori.b  #$0, d0
002CF8  ori.b  #$0, d1
002CFC  ori.b  #$0, d0
002D00  ori.b  #$0, d1
002D04  ori.b  #$0, d0
002D08  ori.b  #$0, d1
002D0C  ori.b  #$0, d0
002D10  ori.b  #$0, d1
002D14  ori.b  #$0, d0
002D18  ori.b  #$0, d1
002D1C  ori.b  #$0, d0
002D20  ori.b  #$0, d1
002D24  ori.b  #$0, d0
002D28  ori.b  #$0, d1
002D2C  ori.b  #$0, d0
002D30  ori.b  #$0, d1
002D34  ori.b  #$0, d0
002D38  ori.b  #$0, d1
002D3C  ori.b  #$0, d0
002D40  ori.b  #$0, d1
002D44  ori.b  #$0, d0
002D48  ori.b  #$0, d1
002D4C  ori.b  #$0, d0
002D50  ori.b  #$0, d1
002D54  ori.b  #$0, d0
002D58  ori.b  #$0, d1
002D5C  ; data: 0xff, 0xff
002D5E  asr.b  #$8, d0
002D60  ori.b  #$0, d1
002D64  ori.b  #$0, d0
002D68  ori.b  #$0, d1
002D6C  ori.b  #$0, d0
002D70  ori.b  #$0, d1
002D74  ori.b  #$0, d0
002D78  ori.b  #$0, d1
002D7C  ori.b  #$0, d0
002D80  ori.b  #$0, d1
002D84  ori.b  #$0, d0
002D88  ori.b  #$0, d1
002D8C  ori.b  #$0, d0
002D90  ori.b  #$0, d1
002D94  ori.b  #$0, d0
002D98  ori.b  #$0, d1
002D9C  ori.b  #$0, d0
002DA0  ori.b  #$0, d1
002DA4  ori.b  #$0, d0
002DA8  ori.b  #$0, d1
002DAC  ori.b  #$0, d0
002DB0  ori.b  #$0, d1
002DB4  ori.b  #$0, d0
002DB8  ori.b  #$0, d1
002DBC  ori.b  #$0, d0
002DC0  ori.b  #$0, d1
002DC4  ori.b  #$0, d0
002DC8  ori.b  #$0, d1
002DCC  ori.b  #$0, d0
002DD0  ori.b  #$0, d1
002DD4  ori.b  #$0, d0
002DD8  ori.b  #$0, d1
002DDC  ori.b  #$0, d0
002DE0  ori.b  #$0, d1
002DE4  ori.b  #$0, d0
002DE8  ori.b  #$0, d1
002DEC  ori.b  #$0, d0
002DF0  ori.b  #$0, d1
002DF4  ori.b  #$0, d0
002DF8  ori.b  #$0, d1
002DFC  ori.b  #$0, d0
002E00  ori.b  #$0, d1
002E04  ori.b  #$0, d0
002E08  ori.b  #$0, d1
002E0C  ori.b  #$0, d0
002E10  ori.b  #$0, d1
002E14  ori.b  #$0, d0
002E18  ori.b  #$0, d1
002E1C  ori.b  #$0, d0
002E20  ori.b  #$0, d1
002E24  ori.b  #$0, d0
002E28  ori.b  #$0, d1
002E2C  ori.b  #$0, d0
002E30  ori.b  #$0, d1
002E34  ori.b  #$0, d0
002E38  ori.b  #$0, d1
002E3C  ori.b  #$0, d0
002E40  ori.b  #$0, d1
002E44  ori.b  #$0, d0
002E48  ori.b  #$0, d1
002E4C  ori.b  #$0, d0
002E50  ori.b  #$0, d1
002E54  ori.b  #$0, d0
002E58  ori.b  #$0, d1
002E5C  ori.b  #$0, d0
002E60  ori.b  #$0, d1
002E64  ori.b  #$0, d0
002E68  ori.b  #$0, d1
002E6C  ori.b  #$0, d0
002E70  ori.b  #$0, d1
002E74  ori.b  #$0, d0
002E78  ori.b  #$0, d1
002E7C  ori.b  #$0, d0
002E80  ori.b  #$0, d1
002E84  ori.b  #$0, d0
002E88  ori.b  #$0, d1
002E8C  ; data: 0xff, 0xff
002E8E  asr.b  #$8, d0
002E90  ori.b  #$0, d1
002E94  ori.b  #$0, d0
002E98  ori.b  #$0, d1
002E9C  ori.b  #$0, d0
002EA0  ori.b  #$0, d1
002EA4  ori.b  #$0, d0
002EA8  ori.b  #$0, d1
002EAC  ; data: 0xff, 0xff
002EAE  asr.b  #$8, d0
002EB0  ori.b  #$0, d1
002EB4  ori.b  #$0, d0
002EB8  ori.b  #$0, d1
002EBC  ori.b  #$0, d0
002EC0  ori.b  #$0, d1
002EC4  ori.b  #$0, d0
002EC8  ori.b  #$0, d1
002ECC  ; data: 0xff, 0xff
002ECE  asr.b  #$8, d0
002ED0  ori.b  #$0, d1
002ED4  ori.b  #$0, d0
002ED8  ori.b  #$0, d1
002EDC  ori.b  #$0, d0
002EE0  ori.b  #$0, d1
002EE4  ori.b  #$0, d0
002EE8  ori.b  #$0, d1
002EEC  ori.b  #$0, d0
002EF0  ori.b  #$0, d1
002EF4  ori.b  #$0, d0
002EF8  ori.b  #$0, d1
002EFC  ori.b  #$0, d0
002F00  ori.b  #$0, d1
002F04  ori.b  #$0, d0
002F08  ori.b  #$0, d1
002F0C  ori.b  #$0, d0
002F10  ori.b  #$0, d1
002F14  ori.b  #$0, d0
002F18  ori.b  #$0, d1
002F1C  ori.b  #$0, d0
002F20  ori.b  #$0, d1
002F24  ori.b  #$0, d0
002F28  ori.b  #$0, d1
002F2C  ori.b  #$0, d0
002F30  ori.b  #$0, d1
002F34  ori.b  #$0, d0
002F38  ori.b  #$0, d1
002F3C  ori.b  #$0, d0
002F40  ori.b  #$0, d1
002F44  ori.b  #$0, d0
002F48  ori.b  #$0, d1
002F4C  ori.b  #$0, d0
002F50  ori.b  #$0, d1
002F54  ori.b  #$0, d0
002F58  ori.b  #$0, d1
002F5C  ori.b  #$0, d0
002F60  ori.b  #$0, d1
002F64  ori.b  #$0, d0
002F68  ori.b  #$0, d1
002F6C  ori.b  #$0, d0
002F70  ori.b  #$0, d1
002F74  ori.b  #$0, d0
002F78  ori.b  #$0, d1
002F7C  ori.b  #$0, d0
002F80  ori.b  #$0, d1
002F84  ori.b  #$0, d0
002F88  ori.b  #$0, d1
002F8C  ori.b  #$0, d0
002F90  ori.b  #$0, d1
002F94  ori.b  #$0, d0
002F98  ori.b  #$0, d1
002F9C  ori.b  #$0, d0
002FA0  ori.b  #$0, d1
002FA4  ori.b  #$0, d0
002FA8  ori.b  #$0, d1
002FAC  ori.b  #$0, d0
002FB0  ori.b  #$0, d1
002FB4  ori.b  #$0, d0
002FB8  ori.b  #$0, d1
002FBC  ori.b  #$0, d0
002FC0  ori.b  #$0, d1
002FC4  ori.b  #$0, d0
002FC8  ori.b  #$0, d1
002FCC  ori.b  #$0, d0
002FD0  ori.b  #$0, d1
002FD4  ori.b  #$0, d0
002FD8  ori.b  #$0, d1
002FDC  ori.b  #$0, d0
002FE0  ori.b  #$0, d1
002FE4  ori.b  #$0, d0
002FE8  ori.b  #$0, d1
002FEC  ori.b  #$0, d0
002FF0  ori.b  #$0, d1
002FF4  ori.b  #$0, d0
002FF8  ori.b  #$0, d1
002FFC  ori.b  #$0, d0
003000  ori.b  #$0, d1
003004  ori.b  #$0, d0
003008  ori.b  #$0, d1
00300C  ; data: 0xff, 0xff
00300E  bra.w  $3011
003012  sub.b  d0, d0
003014  ; data: 0xff, 0xfe
003016  or.b   d0, d0
003018  ori.b  #$0, d1
00301C  ori.b  #$0, d0
003020  ori.b  #$0, d1
003024  ori.b  #$0, d0
003028  ori.b  #$0, d1
00302C  ori.b  #$0, d0
003030  ori.b  #$0, d1
003034  ori.b  #$0, d0
003038  ori.b  #$0, d1
00303C  ori.b  #$0, d0
003040  ori.b  #$0, d1
003044  ori.b  #$0, d0
003048  ori.b  #$0, d1
00304C  ori.b  #$0, d0
003050  ori.b  #$0, d1
003054  ori.b  #$0, d0
003058  ori.b  #$0, d1
00305C  ori.b  #$0, d0
003060  ori.b  #$0, d1
003064  ori.b  #$0, d0
003068  ori.b  #$0, d1
00306C  ori.b  #$0, d0
003070  ori.b  #$0, d1
003074  ori.b  #$0, d0
003078  ori.b  #$0, d1
00307C  ori.b  #$0, d0
003080  ori.b  #$0, d1
003084  ori.b  #$0, d0
003088  ori.b  #$0, d1
00308C  ori.b  #$0, d0
003090  ori.b  #$0, d1
003094  ori.b  #$0, d0
003098  ori.b  #$0, d1
00309C  ori.b  #$0, d0
0030A0  ori.b  #$0, d1
0030A4  ori.b  #$0, d0
0030A8  ori.b  #$0, d1
0030AC  ori.b  #$0, d0
0030B0  ori.b  #$0, d1
0030B4  ori.b  #$0, d0
0030B8  ; data: 0xff, 0xff
0030BA  ; data: 0xff, 0xff
0030BC  ; data: 0xff, 0xff
0030BE  ; data: 0xff, 0xff
0030C0  ; data: 0xff, 0xff
0030C2  ; data: 0xff, 0xff
0030C4  ; data: 0xff, 0xff
0030C6  ; data: 0xff, 0xff
0030C8  ; data: 0xff, 0xff
0030CA  ; data: 0xff, 0xff
0030CC  ; data: 0xff, 0xff
0030CE  ; data: 0xff, 0xff
0030D0  ; data: 0xff, 0xff
0030D2  ; data: 0xff, 0xff
0030D4  ; data: 0xff, 0xff
0030D6  ; data: 0xff, 0xff
0030D8  btst.l d0, -(a0)
0030DA  ; data: 0x0e, 0xfc
0030DC  ; data: 0x0c, 0xd9
0030DE  ; data: 0x0a, 0xc7
0030E0  ; data: 0x08, 0xa5
0030E2  bclr.b d2, d3
0030E4  bchg.b d1, -(a1)
0030E6  bchg.b d0, d0
0030E8  ori.b  #$58, d0
0030EC  movea.l -(a4), a5
0030EE  move.l $2ac6(a2), d5
0030F2  bcc.b  $30fa
0030F4  mulu.w d0, d7
0030F6  move.w #$3c24, d6
0030FA  move.w -(a4), d6
0030FC  ; data: 0x48, 0x64
0030FE  mulu.w d6, d3
003100  mulu.w -(a6), d3
003102  roxr.l #$3, d2
003104  move.w (a0)+, d6
003106  move.b -$3968(a0), (a1)
00310A  addq.b #$4, $c(a2, d4.l)
00310E  ori.b  #$32, d0
003112  ori.b  #$0, d0
003116  and.l  (a4), d7
003118  move.w (a6), sr
00311A  not.w  d6
00311C  move.w d6, sr
00311E  bcc.b  $3126
003120  suba.w d0, a2
003122  dc.w   $f6e6
003124  ; data: 0xe6, 0xce
003126  ; data: 0xe6, 0xce
003128  movea.l -(a4), a7
00312A  mulu.w d0, d2
00312C  and.l  -(a4), d3
00312E  ; data: 0xa4, 0x96
003130  asr.b  d7, d0
003132  moveq  #$c4, d2
003134  or.b   $28da(a0), d3
003138  move.l $313a(pc), d5
00313C  move.w (a0, d0.w), (a0)+
003140  ori.b  #$c6, d0
003144  ; data: 0x80, 0xca
003146  or.l   d0, d0
003148  or.l   d0, d0
00314A  move.l d0, d0
00314C  ; data: 0xa8, 0x00
00314E  or.l   d0, d6
003150  divu.w d4, d0
003152  divu.w d4, d0
003154  bra.b  $3176
003156  ori.b  #$92, d2
00315A  sub.b  (a4), d1
00315C  or.w   $602(a0), d4
003160  ; data: 0xa0, 0x60
003162  bra.b  $3170
003164  bhi.b  $3174
003166  ori.b  #$2, d0
00316A  move.w d0, d0
00316C  ori.b  #$d2, d0
003170  divu.w d4, d0
003172  ; data: 0xa0, 0xe8
003174  or.b   (a2)+, d3
003176  movea.w d0, a0
003178  move.l d0, (a6)
00317A  move.b d0, d4
00317C  ; data: 0x00, 0xcc
00317E  ; data: 0x00, 0xcc
003180  dc.w   $f230
003182  or.l   d2, d1
003184  ; data: 0x08, 0x52
003186  addq.b #$1, (a0)+
003188  move.b -(a4), d0
00318A  ; data: 0x4e, 0x0a
00318C  suba.w a2, a5
00318E  ; data: 0x4a, 0x0a
003190  tst.l  d0
003192  ori.b  #$2, d0
003196  ori.b  #$0, d0
00319A  move.b (a4, d4.w), d2
00319E  dc.w   $4808
0031A0  not.w  $e2(a6)
0031A4  trap   #$0
0031A6  clr.w  d2
0031A8  clr.b  (a0)+
0031AA  not.b  (a0)+
0031AC  addq.b #$2, d0
0031AE  mulu.w -(a4), d3
0031B0  addq.b #$1, $410.w
0031B4  moveq  #$0, d1
0031B6  move.l -(a4), d4
0031B8  bgt.b  $3186
0031BA  ; data: 0xa4, 0x0c
0031BC  ; data: 0xa4, 0x58
0031BE  ori.b  #$8, d0
0031C2  ori.l  #$1c46, (a6)
0031C8  ; data: 0x40, 0x0c
0031CA  negx.b d0
0031CC  negx.w d2
0031CE  movea.l (a6)+, a0
0031D0  move.w -(a0), sr
0031D2  adda.w d2, a1
0031D4  move.l a0, d3
0031D6  move.l a0, d7
0031D8  addi.b #$28, -(a0)
0031DC  asr.w  d3, d2
0031DE  move.b -(a0), (a4)
0031E0  ; data: 0x06, 0x08
0031E2  bra.b  $31e8
0031E4  andi.b #$18, d6
0031E8  ; data: 0xa6, 0x06
0031EA  ori.b  #$8, (a0)+
0031EE  ; data: 0x00, 0xe6
0031F0  ori.b  #$90, d0
0031F4  ; data: 0xa6, 0xdc
0031F6  ; data: 0xa6, 0xc0
0031F8  ; data: 0xa2, 0x84
0031FA  neg.b  -$7f86(a2)
0031FE  sub.l  d4, d6
003200  suba.w (a0), a1
003202  suba.w (a4)+, a1
003204  move.b -(a0), d5
003206  adda.w (a0), a7
003208  ; data: 0xe2, 0xc0
00320A  ori.b  #$8, -$36(a2, a5.l)
003210  subi.b #$50, (a2)+
003214  add.l  $20(a0, d3.w), d5
003218  move.w (a0, d3.w), d0
00321C  ori.b  #$e4, d0
003220  ; data: 0xe2, 0xc0
003222  asr.l  #$1, d0
003224  asr.l  #$1, d4
003226  ; data: 0x8c, 0x0e
003228  or.b   -(a6), d2
00322A  or.l   d4, d2
00322C  moveq  #$80, d0
00322E  moveq  #$88, d0
003230  bcc.b  $3262
003232  bcc.b  $3294
003234  moveq  #$84, d4
003236  move.b d6, (a4)
003238  moveq  #$c, d0
00323A  ; data: 0x46, 0x8e
00323C  subi.w #$64a0, -(a4)
003240  bcc.b  $3210
003242  ori.w  #$0, (a0, d0.w)
003248  ori.b  #$64, d0
00324C  cmpi.w #$c0c, $c00.w
003252  moveq  #$0, d4
003254  ori.l  #$38, d0
00325A  ori.b  #$78, $0.w
003260  or.b   -(a0), d2
003262  move.l #$c0c60, d0
003268  ori.w  #$203c, -(a0)
00326C  move.w (a2, d0.w), d0
003270  ; data: 0x00, 0x0c
003272  ori.b  #$0, d0
003276  dc.w   $f0e2
003278  move.b -(a0), (a4)+
00327A  move.b (a0)+, d4
00327C  move.b d0, d4
00327E  or.b   d0, d4
003280  ext.w  d0
003282  ; data: 0x08, 0x10
003284  move.b -$10(a0, d1.w), (a0)+
003288  add.l  a0, d0
00328A  andi.b #$42, d6
00328E  dc.w   $42e0
003290  move.b (a0), d4
003292  eori.b #$d0, -$20(a0, a5.w)
003298  adda.w d0, a0
00329A  ori.b  #$a, d0
00329E  ori.b  #$0, d0
0032A2  ; data: 0x08, 0x02
0032A4  move.l a0, d0
0032A6  move.l -(a0), d0
0032A8  movea.l d6, a0
0032AA  move.l d6, d0
0032AC  st.b   d0
0032AE  addq.w #$5, a2
0032B0  tst.b  d2
0032B2  tst.b  d2
0032B4  and.b  -(a0), d0
0032B6  mulu.w d2, d3
0032B8  add.l  -(a6), d3
0032BA  ; data: 0xa2, 0x08
0032BC  not.b  d0
0032BE  ; data: 0x02, 0x08
0032C0  move.w d0, sr
0032C2  ; data: 0xc0, 0x0e
0032C4  ; data: 0xc6, 0xc8
0032C6  ori.b  #$2, d0
0032CA  ori.b  #$0, d0
0032CE  addi.b #$2, (a6)+
0032D2  movea.w -$6(a0, d0.w), a4
0032D6  move.w d6, d0
0032D8  dc.w   $f840
0032DA  adda.w d6, a7
0032DC  and.b  d6, d3
0032DE  and.b  d4, d3
0032E0  cmp.b  -$3c(a0, a4.w), d5
0032E4  add.w  (a6)+, d3
0032E6  addq.b #$7, $c(a0, a4.l)
0032EA  addq.b #$6, $bafa.w
0032EE  dc.w   $fa04
0032F0  ; data: 0x38, 0xbe
0032F2  ori.b  #$4, d0
0032F6  move.l d0, d0
0032F8  ori.b  #$fa, d0
0032FC  mulu.w d6, d0
0032FE  dc.w   $f0f0
003300  mulu.w $6(a2, d3.w), d4
003304  dc.w   $f4e0
003306  adda.w d6, a7
003308  ; data: 0xc6, 0xcc
00330A  adda.w a0, a5
00330C  bra.b  $333e
00330E  mulu.w -$21a0(a0), d1
003312  movea.l d0, a4
003314  ; data: 0xde, 0x0c
003316  or.b   (a6)+, d2
003318  moveq  #$f0, d1
00331A  sub.b  (a0)+, d4
00331C  sub.w  -(a2), d4
00331E  ; data: 0x00, 0x08
003320  move.l d4, d0
003322  ori.b  #$0, (a0)+
003326  dc.w   $fec2
003328  ; data: 0xc0, 0xc8
00332A  mulu.w d0, d0
00332C  mulu.w d6, d1
00332E  move.b -$3d50(a6), d0
003332  adda.w d6, a7
003334  mulu.w $c6f0.w, d1
003338  andi.b #$b0, (a0)
00333C  spl.b  d6
00333E  ori.l  #$d20cc006, d0
003344  addi.b #$30, d2
003348  ; data: 0xa2, 0x02
00334A  ori.b  #$10, d0
00334E  dc.w   $f8
003350  ori.b  #$9e, d0
003354  ; data: 0xb8, 0xbe
003356  cmpa.w d0, a4
003358  cmp.l  d4, d7
00335A  moveq  #$18, d4
00335C  or.w   (a4)+, d2
00335E  sub.l  d4, d2
003360  cmpa.w (a0), a0
003362  cmpa.w (a0), a0
003364  moveq  #$10, d4
003366  sub.l  d0, d5
003368  cmpa.w d4, a4
00336A  move.b #$c, (a4)
00336E  sub.b  $37e8(pc), d7
003372  cmp.w  d0, d4
003374  ; data: 0xb8, 0x3e
003376  ori.b  #$0, -(a0)
00337A  ori.b  #$0, d0
00337E  suba.w #$fcfc, a2
003382  dc.w   $fc80
003384  dc.w   $fc84
003386  dc.w   $f012
003388  or.b   $8484.w, d2
00338C  ; data: 0x4c, 0x80
00338E  ; data: 0x4c, 0x8e
003390  sub.b  (a0), d6
003392  addq.w #$6, -(a0)
003394  neg.l  d4
003396  move.b $4c0c.w, (a4)+
00339A  moveq  #$7e, d4
00339C  subi.l #$5ce05cf2, (a4)+
0033A2  movea.l (a0), a0
0033A4  move.l -(a0), d0
0033A6  move.l d0, d0
0033A8  ori.b  #$84, d0
0033AC  move.w d4, (a0)
0033AE  move.w -$7c(a0, d3.w), d0
0033B2  or.b   d4, d0
0033B4  or.l   d0, d5
0033B6  negx.w d4
0033B8  move.w d2, ccr
0033BA  move.w d2, ccr
0033BC  neg.l  d0
0033BE  or.l   d4, d2
0033C0  or.l   -(a4), d2
0033C2  ; data: 0xa4, 0xc0
0033C4  neg.b  (a0)
0033C6  move.l (a0)+, d1
0033C8  or.l   d0, d2
0033CA  move.w sr, d0
0033CC  clr.w  d2
0033CE  ori.b  #$42, d0
0033D2  ori.b  #$0, d0
0033D6  dc.w   $fafa
0033D8  moveq  #$fa, d7
0033DA  moveq  #$7e, d7
0033DC  moveq  #$84, d7
0033DE  dc.w   $fc04
0033E0  sub.l  d0, d2
0033E2  cmp.l  $ffffeee0(pc), d2
0033E6  cmpa.w #$bafc, a5
0033EA  or.l   d4, d2
0033EC  or.l   -(a4), d2
0033EE  ; data: 0xa4, 0xfa
0033F0  cmp.b  $5cfc(a4), d1
0033F4  or.l   $b8fc.w, d2
0033F8  cmp.l  #$20bc, d6
0033FE  ori.b  #$0, d0
003402  or.l   d4, d6
003404  lsr.l  #$8, d4
003406  asr.w  -(a0)
003408  asr.l  #$8, d4
00340A  move.w d4, d0
00340C  ; data: 0xa8, 0x80
00340E  sub.l  a4, d2
003410  or.l   d4, d6
003412  or.l   d4, d6
003414  ; data: 0xa0, 0x30
003416  or.l   d4, d2
003418  suba.w (a4), a2
00341A  add.b  (a4), d2
00341C  or.w   (a4)+, d4
00341E  ; data: 0x04, 0x0e
003420  ; data: 0xa4, 0xa0
003422  ; data: 0xa0, 0x08
003424  ; data: 0xa4, 0x8c
003426  ori.b  #$4, d0
00342A  move.l d0, d0
00342C  ori.b  #$a2, d0
003430  and.l  d4, d0
003432  and.l  d0, d0
003434  and.l  d4, d4
003436  movea.l d4, a0
003438  or.l   d0, d2
00343A  sub.l  d4, d2
00343C  ; data: 0x84, 0x8a
00343E  ; data: 0x84, 0x88
003440  and.b  -(a0), d3
003442  ; data: 0x84, 0x8a
003444  sub.w  -(a2), d2
003446  bhi.b  $3470
003448  sub.b  $6206(a0), d2
00344C  and.l  d6, d2
00344E  ; data: 0x86, 0x0a
003450  move.w d0, sr
003452  ori.b  #$a, d0
003456  move.w d0, d0
003458  ori.b  #$bc, d0
00345C  or.l   d4, d0
00345E  cmp.l  $8cbc.w, d4
003462  move.l -(a4), (a0)
003464  cmp.l  -(a0), d5
003466  sub.l  d4, d2
003468  or.l   (a4), d2
00346A  sub.l  (a0), d2
00346C  moveq  #$20, d5
00346E  or.l   $5e(a4, a1.w), d2
003472  movea.w $8(a0, a2.l), a2
003476  add.b  $b176(pc), d6
00347A  dc.w   $fe14
00347C  dc.w   $fe7c
00347E  ; data: 0x00, 0x08
003480  move.w (a4), d0
003482  ; data: 0x00, 0xe0
003484  ori.b  #$84, d0
003488  ; data: 0x80, 0x8e
00348A  or.l   d0, d0
00348C  or.l   d4, d0
00348E  movea.l (a4)+, a0
003490  divu.w (a0), d2
003492  sub.l  d4, d2
003494  ; data: 0xa4, 0xa8
003496  ; data: 0xa8, 0xa8
003498  subi.b #$c8, -(a0)
00349C  cmp.l  -(a4), d2
00349E  move.b -(a0), (a0)+
0034A0  ; data: 0xb4, 0x08
0034A2  ; data: 0xa0, 0x02
0034A4  subi.b #$28, d4
0034A8  asr.b  #$2, d4
0034AA  ori.b  #$18, (a0)
0034AE  ; data: 0x00, 0xfe
0034B0  ori.b  #$e2, d0
0034B4  and.l  d2, d0
0034B6  and.l  d0, d0
0034B8  mulu.w d6, d0
0034BA  or.b   -(a6), d0
0034BC  and.w  -(a0), d3
0034BE  adda.w d6, a7
0034C0  and.l  (a0), d7
0034C2  and.l  (a4), d7
0034C4  or.b   -(a0), d3
0034C6  ror.w  -$7a(a0, a4.w)
0034CA  move.b d0, (a0)+
0034CC  ; data: 0xce, 0x08
0034CE  asr.b  #$8, d6
0034D0  addi.l #$c670c6c2, d6
0034D6  move.l $2020.w, d0
0034DA  move.l d0, d0
0034DC  ori.b  #$fc, d0
0034E0  dc.w   $fefc
0034E2  dc.w   $fec0
0034E4  dc.w   $fec6
0034E6  dc.w   $fc1e
0034E8  ; data: 0xc6, 0x3e
0034EA  mulu.w d6, d3
0034EC  moveq  #$c0, d6
0034EE  moveq  #$ca, d6
0034F0  dc.w   $fc20
0034F2  moveq  #$60, d6
0034F4  moveq  #$c6, d6
0034F6  ; data: 0x10, 0xfe
0034F8  moveq  #$8, d6
0034FA  moveq  #$fe, d7
0034FC  ; data: 0x06, 0xfc
0034FE  moveq  #$e0, d6
003500  moveq  #$fe, d6
003502  movea.w -(a0), a0
003504  move.w (a0, d3.w), d0
003508  ori.b  #$0, d0
00350C  bset.b d1, (a3, d0.w)
003510  ori.b  #$0, d0
003514  ori.b  #$0, d1
003518  ori.b  #$0, d0
00351C  ori.b  #$0, d0
003520  ; data: 0x14, 0x5d
003522  ori.b  #$e9, d0
003526  ori.b  #$5d, d0
00352A  move.l -(a0), d0
00352C  bpl.b  $358f
00352E  movea.l $6120(a2), a0
003532  move.l $2e20(a6), d7
003536  bvs.b  $359b
003538  bvc.b  $355a
00353A  ; data: 0x77, 0x65
00353C  bvs.b  $35b1
00353E  ; data: 0x73, 0x20
003540  move.l $2e20(a6), d7
003544  bcc.b  $35af
003546  bcs.b  $3568
003548  move.w -(a0), -(a0)
00354A  ; data: 0x77, 0x61
00354C  moveq  #$20, d1
00354E  bmi.b  $35b5
003550  bvs.b  $35c0
003552  bcs.b  $3574
003554  bhi.b  $35bb
003556  ; data: 0x73, 0x6f
003558  bgt.b  $35be
00355A  bcs.b  $35ce
00355C  ; data: 0x73, 0x20
00355E  bcs.b  $35c9
003560  bgt.b  $35c8
003562  bsr.b  $35d0
003564  bge.b  $35d9
003566  moveq  #$65, d1
003568  bvs.b  $35cd
00356A  bvc.b  $35d1
00356C  move.l d0, d0
00356E  movea.l $6465(a1), a0
003572  bcs.b  $35a0
003574  movea.l -(a1), a0
003576  bhi.b  $35dd
003578  moveq  #$20, d1
00357A  bvs.b  $35df
00357C  bvc.b  $359e
00357E  ; data: 0x77, 0x61
003580  moveq  #$20, d1
003582  bgt.b  $35f3
003584  bls.b  $35ee
003586  movea.l $6965(a6), a0
00358A  movea.l $7269(a3, d6.l * 8), a0
003590  bls.b  $35fa
003592  moveq  #$69, d2
003594  beq.b  $35b6
003596  bcs.b  $3601
003598  bgt.b  $3600
00359A  bsr.b  $3608
00359C  bge.b  $3611
00359E  moveq  #$65, d1
0035A0  bvs.b  $3605
0035A2  bvc.b  $35d0
0035A4  movea.l ([$6865, a3]), a0
0035AA  movea.l -(a3), a0
0035AC  bvc.b  $3613
0035AE  bsr.b  $3624
0035B0  move.l -(a0), -(a6)
0035B2  ori.b  #$6f, -(a0)
0035B6  bcc.b  $361d
0035B8  movea.l $6e20(a1), a0
0035BC  move.l $6577(a6), $2079(a6)
0035C2  ble.b  $3636
0035C4  bmi.b  $35e6
0035C6  bls.b  $3631
0035C8  moveq  #$79, d2
0035CA  move.l -(a0), -(a6)
0035CC  move.l $2e20(a6), d7
0035D0  ori.b  #$63, -(a0)
0035D4  bvc.b  $3637
0035D6  bcc.b  $363d
0035D8  movea.l $7572(a6), a0
0035DC  move.l -(a0), d6
0035DE  bcc.b  $3641
0035E0  ; data: 0x73, 0x73
0035E2  movea.l -(a4), a0
0035E4  bsr.b  $3659
0035E6  movea.l -(a4), a0
0035E8  bvs.b  $3658
0035EA  beq.b  $360c
0035EC  bgt.b  $3657
0035EE  bcs.b  $3610
0035F0  moveq  #$61, d1
0035F2  ; data: 0x75, 0x73
0035F4  beq.b  $365b
0035F6  bmi.b  $3667
0035F8  blt.b  $3667
0035FA  bcs.b  $366a
0035FC  movea.l $7374(a1), a0
003600  move.l -(a0), d6
003602  bsr.b  $3666
003604  bcs.b  $3678
003606  movea.l ([$2069, a7]), a0
00360C  bgt.b  $3682
00360E  bcs.b  $3682
003610  bcs.b  $3685
003612  ; data: 0x73, 0x69
003614  bcs.b  $3688
003616  moveq  #$20, d2
003618  ori.b  #$61, -(a0)
00361C  ; data: 0x73, 0x20
00361E  ; data: 0x73, 0x63
003620  bvc.b  $3691
003622  bgt.b  $3644
003624  bvc.b  $368b
003626  ; data: 0x75, 0x74
003628  bcs.b  $364a
00362A  ; data: 0x3f, 0x3f
00362C  move.w -(a0), -(a7)
00362E  ori.b  #$0, -(a0)
003632  movea.l $6368(a1), a0
003636  movea.l -(a6), a0
003638  moveq  #$61, d1
00363A  beq.b  $365c
00363C  blt.b  $36a7
00363E  bls.b  $36a8
003640  move.l -(a0), d6
003642  ; data: 0x77, 0x61
003644  moveq  #$75, d1
003646  blt.b  $3668
003648  bvs.b  $36ad
00364A  bvc.b  $366c
00364C  bcc.b  $36b7
00364E  bcs.b  $36c3
003650  bcs.b  $36c0
003652  movea.l ([$74207565, a0], $6265), a0
00365C  moveq  #$68, d1
00365E  bsr.b  $36d5
003660  moveq  #$74, d0
003662  movea.l $7265(a3, invalid.w), a0
003668  bvs.b  $36cc
00366A  bcs.b  $369a
00366C  move.l d0, d0
00366E  movea.l -(a5), a0
003670  ; data: 0x73, 0x20
003672  beq.b  $36dd
003674  bhi.b  $36ea
003676  movea.l -(a5), a0
003678  bvs.b  $36e1
00367A  bcs.b  $36ea
00367C  moveq  #$6c, d2
00367E  bvs.b  $36e3
003680  bvc.b  $36e7
003682  bgt.b  $36a4
003684  bgt.b  $36fb
003686  moveq  #$20, d1
003688  bcs.b  $36f3
00368A  bgt.b  $36f1
00368C  bgt.b  $36ae
00368E  beq.b  $3702
003690  ; data: 0x75, 0x6e
003692  bcc.b  $36c2
003694  movea.l $64(a5, d6.l), a0
003698  movea.l $adfb(pc), a0
00369C  moveq  #$20, d1
00369E  bcs.b  $3709
0036A0  bgt.b  $36c2
0036A2  ; data: 0x73, 0x6f
0036A4  ; data: 0x75, 0x72
0036A6  bls.b  $370d
0036A8  move.l -(a3), $6f64(a6)
0036AC  bcs.b  $36da
0036AE  move.l d0, d0
0036B0  movea.l -(a4), a0
0036B2  bcs.b  $3722
0036B4  movea.l $6368(a1), a0
0036B8  movea.l ([$6f656666, a6], $656e), a0
0036C2  moveq  #$6c, d2
0036C4  bvs.b  $3729
0036C6  bvc.b  $372d
0036C8  bgt.b  $36ea
0036CA  ; data: 0x77, 0x69
0036CC  bge.b  $373a
0036CE  move.l -(a0), d7
0036D0  bvs.b  $3735
0036D2  bvc.b  $36f4
0036D4  ; data: 0x77, 0x65
0036D6  bvs.b  $374b
0036D8  ; data: 0x73, 0x20
0036DA  moveq  #$77, d5
0036DC  bsr.b  $3750
0036DE  movea.l $6f63(a6), a0
0036E2  bvc.b  $3704
0036E4  bgt.b  $374f
0036E6  bls.b  $3750
0036E8  moveq  #$20, d2
0036EA  ; data: 0x77, 0x65
0036EC  bge.b  $3751
0036EE  bvc.b  $3755
0036F0  bgt.b  $371e
0036F2  move.l d0, d0
0036F4  movea.l $6220(a7), a0
0036F8  bcc.b  $375f
0036FA  bgt.b  $371c
0036FC  moveq  #$75, d2
0036FE  bgt.b  $3765
003700  bge.b  $372e
003702  movea.l $6465(a7), a0
003706  moveq  #$20, d1
003708  bcc.b  $3773
00370A  bcs.b  $377f
00370C  bcs.b  $377c
00370E  movea.l $61(a0, d6.l), a0
003712  ; data: 0x73, 0x6d
003714  bsr.b  $3743
003716  bcs.b  $377e
003718  bne.b  $377f
00371A  bmi.b  $3790
00371C  movea.l $6465(a7), a0
003720  moveq  #$20, d1
003722  bgt.b  $3799
003724  moveq  #$20, d1
003726  bcc.b  $3791
003728  bcs.b  $374a
00372A  move.w -(a4), $2d73(a1)
00372E  moveq  #$65, d2
003730  moveq  #$6e, d1
003732  bcs.b  $3760
003734  move.l -(a0), d0
003736  ori.b  #$65, -(a0)
00373A  bvs.b  $37a8
00373C  movea.l -(a4), a0
00373E  bsr.b  $37b3
003740  movea.l -(a4), a0
003742  bvs.b  $37a9
003744  movea.l -(a1), a0
003746  blt.b  $3768
003748  blt.b  $37af
00374A  bvs.b  $37bf
00374C  moveq  #$65, d2
00374E  bgt.b  $3770
003750  ble.b  $37c2
003752  moveq  #$69, d2
003754  blt.b  $37bf
003756  bcs.b  $37ca
003758  moveq  #$65, d2
00375A  movea.l ([$74696e65, a2]), a0
003762  movea.l $7374(a1), a0
003766  move.l -(a0), d7
003768  bsr.b  $37cc
00376A  bcs.b  $37de
00376C  movea.l -(a5), a0
00376E  ; data: 0x73, 0x20
003770  bmi.b  $37e1
003772  blt.b  $37e1
003774  moveq  #$20, d2
003776  bgt.b  $37e7
003778  bls.b  $37e2
00377A  move.l d0, d0
00377C  movea.l -(a4), a0
00377E  bvs.b  $37e5
003780  movea.l $9ceb(pc), a0
003784  moveq  #$2c, d2
003786  movea.l $6963(a7, d6.l * 8), a0
00378C  bvc.b  $37ae
00378E  blt.b  $37f9
003790  bls.b  $37fa
003792  movea.l -(a5), a0
003794  bgt.b  $380a
003796  ; data: 0x73, 0x63
003798  bvc.b  $37ff
00379A  bvs.b  $3800
00379C  bcs.b  $380c
00379E  movea.l ([$64652e20, a7], $766f), a0
0037A8  moveq  #$20, d1
0037AA  bsr.b  $3818
0037AC  bge.b  $3813
0037AE  blt.b  $37dc
0037B0  movea.l ([$6c20, a7]), a0
0037B6  bvs.b  $381b
0037B8  bvc.b  $37da
0037BA  bgt.b  $382b
0037BC  bls.b  $3826
0037BE  move.l d0, d0
0037C0  movea.l $67(a5, d6.l), a0
0037C4  bcs.b  $382c
0037C6  bsr.b  $382d
0037C8  bvc.b  $383c
0037CA  move.l $20(a1, d3.w), d0
0037CE  moveq  #$61, d2
0037D0  beq.b  $3837
0037D2  movea.l -(a2), a0
0037D4  bvs.b  $3849
0037D6  movea.l $acf8(pc), a0
0037DA  bcc.b  $3841
0037DC  moveq  #$20, d1
0037DE  ; data: 0x77, 0x6f
0037E0  bls.b  $380f
0037E2  move.w $68(a3, d2.w), -(a4)
0037E6  bsr.b  $384a
0037E8  bcs.b  $3818
0037EA  movea.l $64(a5, d6.l), a0
0037EE  movea.l -(a5), a0
0037F0  ; data: 0x73, 0x20
0037F2  ; data: 0x77, 0x69
0037F4  moveq  #$64, d1
0037F6  movea.l -(a2), a0
0037F8  bcs.b  $386d
0037FA  moveq  #$69, d2
0037FC  blt.b  $386b
0037FE  moveq  #$20, d2
003800  bge.b  $3877
003802  ; data: 0x73, 0x74
003804  bvs.b  $386d
003806  move.l -(a0), d6
003808  ori.b  #$65, -(a0)
00380C  bgt.b  $387c
00380E  movea.l $6368(a1), a0
003812  movea.l -(a5), a0
003814  ; data: 0x73, 0x20
003816  bgt.b  $3881
003818  bls.b  $3882
00381A  moveq  #$20, d2
00381C  ; data: 0x73, 0x63
00381E  bvc.b  $3881
003820  bne.b  $3888
003822  bcs.b  $3850
003824  movea.l -(a4), a0
003826  bvs.b  $388d
003828  ; data: 0x73, 0x65
00382A  movea.l $6569(a3, invalid.w), a0
003830  ; data: 0x73, 0x73
003832  movea.l -(a4), a0
003834  bcs.b  $38a3
003836  ble.b  $3858
003838  bhi.b  $38a3
00383A  ; data: 0x73, 0x20
00383C  bcc.b  $389f
00383E  bvc.b  $38a9
003840  bgt.b  $3862
003842  bne.b  $38a9
003844  moveq  #$74, d1
003846  bvs.b  $38af
003848  movea.l $ad6a(pc), a0
00384C  ori.b  #$63, -(a0)
003850  bvc.b  $38c4
003852  bcs.b  $38bd
003854  bhi.b  $38bb
003856  bgt.b  $3886
003858  movea.l -(a1), a0
00385A  bls.b  $38c4
00385C  movea.l $6120(a2), a0
003860  bvs.b  $38c5
003862  bvc.b  $3884
003864  ; data: 0x77, 0x65
003866  moveq  #$64, d1
003868  bcs.b  $388a
00386A  bcc.b  $38d1
00386C  bgt.b  $388e
00386E  ; data: 0x73, 0x6f
003870  ; data: 0x75, 0x72
003872  bls.b  $38d9
003874  move.l -(a3), $6f64(a6)
003878  bcs.b  $389a
00387A  bgt.b  $38e5
00387C  bls.b  $38e6
00387E  moveq  #$20, d2
003880  blt.b  $38eb
003882  moveq  #$20, d2
003884  bcc.b  $38ef
003886  bcs.b  $38fb
003888  bcs.b  $38fc
00388A  movea.l $742d2000(a4, invalid.w), a0
003892  movea.l ([$74696e65, a2]), a0
00389A  movea.l -(a1), a0
00389C  ; data: 0x75, 0x73
00389E  beq.b  $3905
0038A0  bhi.b  $3907
0038A2  bgt.b  $38d0
0038A4  movea.l ([$6c20, a7]), a0
0038AA  bhi.b  $3911
0038AC  bvs.b  $38ce
0038AE  bcc.b  $3915
0038B0  blt.b  $38d2
0038B2  bne.b  $3923
0038B4  bgt.b  $392a
0038B6  movea.l ([$6c20, a6]), a0
0038BC  moveq  #$75, d5
0038BE  movea.l ([$6c65, a6]), a0
0038C4  movea.l $9e2f(pc), a0
0038C8  bls.b  $3932
0038CA  bcs.b  $393a
0038CC  movea.l -(a6), a0
0038CE  bcs.b  $3938
0038D0  bge.b  $3937
0038D2  bgt.b  $3902
0038D4  move.l d0, d0
0038D6  movea.l $656e(a3), a0
0038DA  bgt.b  $3941
0038DC  moveq  #$20, d1
0038DE  ; data: 0x77, 0x65
0038E0  moveq  #$64, d1
0038E2  bcs.b  $3952
0038E4  movea.l $686e(a1), a0
0038E8  movea.l $656e(a3), a0
0038EC  bgt.b  $3953
0038EE  bgt.b  $391c
0038F0  movea.l -(a5), a0
0038F2  moveq  #$20, d1
0038F4  bmi.b  $3965
0038F6  blt.b  $3965
0038F8  moveq  #$20, d2
0038FA  moveq  #$6f, d3
0038FC  bgt.b  $391e
0038FE  bcc.b  $3965
003900  blt.b  $3922
003902  bge.b  $3969
003904  moveq  #$7a, d2
003906  moveq  #$65, d2
003908  bgt.b  $392a
00390A  moveq  #$61, d0
00390C  moveq  #$74, d1
00390E  movea.l ([$2064, a6]), a0
003914  bcs.b  $3988
003916  move.l d0, d0
003918  movea.l ([$2d39, a7], $32206465), a0
003922  blt.b  $3993
003924  move.l -(a0), d7
003926  ori.b  #$0, -(a0)
00392A  move.l -(a0), d0
00392C  move.l -(a0), d0
00392E  movea.l $6f65(a3, invalid.w), a0
003934  bgt.b  $399b
003936  movea.l -(a7), a0
003938  moveq  #$75, d1
00393A  bcs.b  $39af
00393C  ; data: 0x73, 0x65
00393E  movea.l -(a1), a0
003940  bgt.b  $3962
003942  bsr.b  $39b6
003944  bgt.b  $39ab
003946  move.l -(a1), d0
003948  move.l -(a1), -(a0)
00394A  move.l $2064(a5), d0
00394E  bsr.b  $39c3
003950  movea.l ([$2d39, a7], $32206d65), a0
00395A  bcs.b  $39d0
00395C  bvs.b  $39cc
00395E  beq.b  $3980
003960  bvs.b  $39d0
003962  movea.l $61(a3, d7.w), a0
003966  bcc.b  $39cd
003968  movea.l ([$20656368, a7], $7420), a0
003972  ori.b  #$20, -(a0)
003976  move.l -(a0), d0
003978  move.l -(a0), d0
00397A  move.l -(a0), d0
00397C  move.l -(a0), d0
00397E  move.l -(a0), d0
003980  move.l -(a0), d0
003982  move.l -(a0), d0
003984  move.l -(a0), d0
003986  move.l -(a0), d0
003988  move.l -(a0), d0
00398A  move.l -(a0), d0
00398C  move.l -(a0), d0
00398E  move.l -(a0), d0
003990  move.l -(a0), d0
003992  move.l -(a0), d0
003994  move.l -(a0), d0
003996  bge.b  $3a0d
003998  ; data: 0x73, 0x74
00399A  bvs.b  $3a03
00399C  move.l $2076(a5), d0
0039A0  bvs.b  $3a07
0039A2  bge.b  $39c4
0039A4  bhi.b  $3a0f
0039A6  bcs.b  $3a1a
0039A8  move.l $2e2e(a6), d0
0039AC  move.l d0, d0
0039AE  move.l -(a0), d0
0039B0  move.l -(a0), d0
0039B2  move.l -(a0), d0
0039B4  move.l -(a0), d0
0039B6  move.l -(a0), d0
0039B8  move.l -(a0), d0
0039BA  move.l -(a0), d0
0039BC  move.l -(a0), d0
0039BE  move.l -(a0), d0
0039C0  move.l -(a0), d0
0039C2  move.l -(a0), d0
0039C4  move.l -(a0), d0
0039C6  move.l -(a0), d0
0039C8  move.l -(a0), d0
0039CA  move.l -(a0), d0
0039CC  move.l -(a0), d0
0039CE  move.l -(a0), d0
0039D0  move.l -(a0), d0
0039D2  move.l -(a0), d0
0039D4  move.l -(a0), d0
0039D6  move.l -(a0), d0
0039D8  move.l -(a0), d0
0039DA  move.l $2e20(a6), d7
0039DE  ; data: 0x75, 0x6e
0039E0  bcc.b  $3a02
0039E2  moveq  #$69, d3
0039E4  bcs.b  $3a52
0039E6  movea.l -(a6), a0
0039E8  bsr.b  $3a4b
0039EA  bsr.b  $3a59
0039EC  move.l $2e2e(a6), d0
0039F0  move.l d0, d0
0039F2  move.l -(a0), d0
0039F4  ori.b  #$68, -(a0)
0039F8  bvs.b  $3a6e
0039FA  move.l $2d2d(a5), d0
0039FE  movea.l -(a2), a0
003A00  bcs.b  $3a78
003A02  ble.b  $3a76
003A04  movea.l $6368(a1), a0
003A08  movea.l -(a5), a0
003A0A  ; data: 0x73, 0x20
003A0C  moveq  #$65, d3
003A0E  moveq  #$67, d1
003A10  bcs.b  $3a85
003A12  ; data: 0x73, 0x65
003A14  move.w -(a0), d5
003A16  moveq  #$75, d5
003A18  blt.b  $3a3a
003A1A  ; data: 0x77, 0x65
003A1C  bvs.b  $3a92
003A1E  bcs.b  $3a92
003A20  blt.b  $3a83
003A22  bls.b  $3a8c
003A24  bcs.b  $3a94
003A26  move.l $6c65(a5), d0
003A2A  ; data: 0x73, 0x65
003A2C  bgt.b  $3a5b
003A2E  move.l -(a0), d6
003A30  bge.b  $3a9b
003A32  bgt.b  $3a9f
003A34  bcs.b  $3a56
003A36  ori.b  #$61, -(a0)
003A3A  ; data: 0x75, 0x73
003A3C  moveq  #$61, d2
003A3E  ; data: 0x73, 0x74
003A40  bcs.b  $3a62
003A42  bcc.b  $3ab6
003A44  ; data: 0x75, 0x65
003A46  bls.b  $3ab3
003A48  bcs.b  $3ab8
003A4A  move.l $2e2e(a6), d0
003A4E  move.l $2e2e(a6), d0
003A52  move.l $2e2e(a6), d0
003A56  movea.l -(a4), a0
003A58  bvs.b  $3abf
003A5A  movea.l -(a1), a0
003A5C  bhi.b  $3ac4
003A5E  moveq  #$61, d1
003A60  beq.b  $3ac7
003A62  movea.l $7374(a1), a0
003A66  movea.l -(a2), a0
003A68  bvs.b  $3add
003A6A  bls.b  $3ad4
003A6C  bcs.b  $3adc
003A6E  movea.l $6f6d(a3), a0
003A72  bvs.b  $3ae7
003A74  bls.b  $3ade
003A76  move.l $2e2e(a6), d0
003A7A  move.l d0, d0
003A7C  movea.l $61(a4, d6.l), a0
003A80  move.l $2e2e(a6), d0
003A84  movea.l $6574(a2), a0
003A88  moveq  #$74, d5
003A8A  movea.l ([$7373, a7]), a0
003A90  movea.l $6368(a1), a0
003A94  movea.l ([$75206469, a7], $6520), a0
003A9E  moveq  #$65, d2
003AA0  moveq  #$74, d4
003AA2  move.l ([$74696e65, a2]), $2064(a6)
003AAC  bsr.b  $3ace
003AAE  bvs.b  $3b23
003AB0  moveq  #$2e, d2
003AB2  movea.l $6368(a1), a0
003AB6  movea.l $6569(a3, invalid.w), a0
003ABC  ; data: 0x73, 0x73
003ABE  bcs.b  $3ae0
003AC0  ori.b  #$75, -(a0)
003AC4  bne.b  $3ae6
003AC6  bvs.b  $3b3a
003AC8  beq.b  $3b2f
003ACA  bgt.b  $3b30
003ACC  movea.l $6569(a3, d6.l * 8), a0
003AD2  bgt.b  $3af4
003AD4  bvc.b  $3b3f
003AD6  bcc.b  $3b3c
003AD8  bcs.b  $3b48
003ADA  move.l ([$742e206e, a0], $7572), $2077(a6)
003AE6  bcs.b  $3b51
003AE8  bge.b  $3b0a
003AEA  bcc.b  $3b4d
003AEC  ; data: 0x73, 0x20
003AEE  bvs.b  $3b5e
003AF0  movea.l $6f64(a5), a0
003AF4  bcs.b  $3b16
003AF6  bvs.b  $3b6b
003AF8  moveq  #$2c, d2
003AFA  movea.l $7573(a5), a0
003AFE  ; data: 0x73, 0x20
003B00  bvs.b  $3b65
003B02  bvc.b  $3b24
003B04  bvs.b  $3b6e
003B06  bgt.b  $3b28
003B08  ori.b  #$6f, -(a0)
003B0C  bls.b  $3b76
003B0E  movea.l $616e(a4), a0
003B12  beq.b  $3b79
003B14  movea.l $6963(a6), a0
003B18  bvc.b  $3b8e
003B1A  movea.l $6163(a5), a0
003B1E  bvc.b  $3b85
003B20  bgt.b  $3b50
003B22  movea.l -(a5), a0
003B24  ; data: 0x73, 0x20
003B26  ; data: 0x77, 0x69
003B28  moveq  #$64, d1
003B2A  movea.l -(a5), a0
003B2C  bvs.b  $3b9c
003B2E  movea.l $6c65(a3), a0
003B32  bvs.b  $3ba2
003B34  bcs.b  $3ba9
003B36  movea.l ([$6562, a4]), a0
003B3C  ; data: 0x75, 0x63
003B3E  bvc.b  $3b60
003B40  ; data: 0x77, 0x65
003B42  moveq  #$64, d1
003B44  bcs.b  $3bb4
003B46  move.l -(a0), d7
003B48  ori.b  #$0, -(a0)
003B4C  movea.l -(a1), a0
003B4E  bge.b  $3bc3
003B50  ble.b  $3b72
003B52  ; data: 0x77, 0x69
003B54  moveq  #$20, d1
003B56  bvc.b  $3bb9
003B58  bhi.b  $3bbf
003B5A  bgt.b  $3b7c
003B5C  bvc.b  $3bc3
003B5E  ; data: 0x75, 0x74
003B60  bcs.b  $3b82
003B62  bhi.b  $3bc9
003B64  ; data: 0x73, 0x69
003B66  blt.b  $3bd5
003B68  moveq  #$20, d2
003B6A  ; data: 0x73, 0x63
003B6C  bvc.b  $3bdd
003B6E  bgt.b  $3b90
003B70  bcc.b  $3bd7
003B72  bgt.b  $3b94
003B74  move.w $31(a6, d2.l), d1
003B78  move.w $3933(a6), d0
003B7C  move.l -(a0), d6
003B7E  bcc.b  $3be5
003B80  ; data: 0x73, 0x77
003B82  bcs.b  $3beb
003B84  bcs.b  $3bf4
003B86  movea.l -(a2), a0
003B88  bcs.b  $3bfd
003B8A  moveq  #$69, d2
003B8C  blt.b  $3bfb
003B8E  moveq  #$2c, d2
003B90  move.l d0, d0
003B92  movea.l ([$6c20, a7]), a0
003B98  bvs.b  $3bfd
003B9A  bvc.b  $3bbc
003B9C  bmi.b  $3c03
003B9E  bvs.b  $3c0e
003BA0  movea.l -(a2), a0
003BA2  ble.b  $3c07
003BA4  bmi.b  $3bc6
003BA6  bvc.b  $3c09
003BA8  bhi.b  $3c0f
003BAA  movea.l $6574(a2), a0
003BAE  moveq  #$74, d5
003BB0  movea.l -(a1), a0
003BB2  ; data: 0x75, 0x66
003BB4  moveq  #$75, d5
003BB6  ; data: 0x73, 0x74
003BB8  bcs.b  $3c22
003BBA  bcs.b  $3c2a
003BBC  move.l -(a0), d6
003BBE  bsr.b  $3c22
003BC0  bcs.b  $3c34
003BC2  movea.l -(a5), a0
003BC4  ; data: 0x73, 0x20
003BC6  ; data: 0x77, 0x69
003BC8  moveq  #$64, d1
003BCA  movea.l $6f6e(a3, invalid.w), a0
003BD0  movea.l ([$6e20, a3]), a0
003BD6  move.l $2e20(a6), d7
003BDA  ori.b  #$69, -(a0)
003BDE  bcs.b  $3c00
003BE0  ; data: 0x77, 0x6f
003BE2  bls.b  $3c04
003BE4  bvs.b  $3c59
003BE6  moveq  #$20, d2
003BE8  bsr.b  $3c57
003BEA  move.l $31(a6, d2.l), d0
003BEE  move.w -(a0), -(a0)
003BF0  move.l -(a0), -(a6)
003BF2  bsr.b  $3c60
003BF4  ; data: 0x73, 0x6f
003BF6  movea.l -(a4), a0
003BF8  ble.b  $3c5d
003BFA  bvc.b  $3c1c
003BFC  bgt.b  $3c6d
003BFE  bls.b  $3c68
003C00  movea.l -(a7), a0
003C02  bcs.b  $3c72
003C04  bsr.b  $3c7b
003C06  move.l $20(a1, d3.w), d0
003C0A  moveq  #$61, d2
003C0C  beq.b  $3c73
003C0E  move.l -(a0), d7
003C10  ; data: 0x75, 0x6e
003C12  bcc.b  $3c34
003C14  bcc.b  $3c7f
003C16  bcs.b  $3c38
003C18  bcc.b  $3c7f
003C1A  blt.b  $3c8b
003C1C  movea.l $7374(a1), a0
003C20  move.l d0, d0
003C22  movea.l $b144(pc), a0
003C26  move.w $70(a0, d2.w), d4
003C2A  moveq  #$6f, d1
003C2C  moveq  #$65, d5
003C2E  bgt.b  $3ca4
003C30  movea.l -(a6), a0
003C32  bcs.b  $3ca6
003C34  moveq  #$69, d2
003C36  beq.b  $3c66
003C38  movea.l $6368(a1), a0
003C3C  movea.l $6569(a5), a0
003C40  bgt.b  $3ca7
003C42  movea.l ([$2063, a6]), a0
003C48  ble.b  $3cae
003C4A  bcs.b  $3c6c
003C4C  bne.b  $3cb3
003C4E  bvc.b  $3cbc
003C50  moveq  #$20, d2
003C52  bcs.b  $3cbd
003C54  beq.b  $3cbb
003C56  bgt.b  $3ccc
003C58  bge.b  $3cc3
003C5A  bls.b  $3cc4
003C5C  movea.l $6963(a6), a0
003C60  bvc.b  $3cd6
003C62  movea.l $6568(a5), a0
003C66  moveq  #$20, d1
003C68  ori.b  #$6f, -(a0)
003C6C  movea.l ([$6c2c, a6]), a0
003C72  movea.l -(a1), a0
003C74  bhi.b  $3cdb
003C76  moveq  #$20, d1
003C78  bcs.b  $3ced
003C7A  movea.l -(a6), a0
003C7C  bcs.b  $3ce6
003C7E  bge.b  $3ce5
003C80  bgt.b  $3ca2
003C82  moveq  #$69, d3
003C84  bcs.b  $3cf2
003C86  bcs.b  $3ca8
003C88  beq.b  $3cfc
003C8A  bsr.b  $3cf2
003C8C  bvs.b  $3cf9
003C8E  bcs.b  $3cfe
003C90  movea.l $64(a5, d6.l), a0
003C94  movea.l -(a2), a0
003C96  bvs.b  $3d0b
003C98  bls.b  $3d02
003C9A  bcs.b  $3d0a
003C9C  movea.l -(a4), a0
003C9E  bcs.b  $3d13
003CA0  bvs.b  $3d09
003CA2  bgt.b  $3cd2
003CA4  movea.l ([$6c20, a7]), a0
003CAA  moveq  #$61, d1
003CAC  movea.l $20(a3, d6.l * 8), a0
003CB2  bcs.b  $3d1d
003CB4  bgt.b  $3cd6
003CB6  ; data: 0x73, 0x61
003CB8  bls.b  $3d25
003CBA  movea.l $7374(a1), a0
003CBE  move.l $2e2e(a6), d0
003CC2  movea.l $616c(a0), a0
003CC6  bge.b  $3d37
003CC8  movea.l $6573(a2), a0
003CCC  moveq  #$65, d2
003CCE  moveq  #$20, d1
003CD0  move.l $2e20(a6), d7
003CD4  bcs.b  $3d48
003CD6  movea.l $6c74(a7, invalid.w), a0
003CDC  bcs.b  $3cfe
003CDE  ; data: 0x75, 0x65
003CE0  bhi.b  $3d47
003CE2  moveq  #$20, d1
003CE4  bcc.b  $3d47
003CE6  ; data: 0x73, 0x20
003CE8  ; data: 0x77, 0x6f
003CEA  bls.b  $3d54
003CEC  bcs.b  $3d5c
003CEE  bcs.b  $3d5e
003CF0  bcc.b  $3d57
003CF2  movea.l ([$6820, a3], $206569), a0
003CFC  bgt.b  $3d1e
003CFE  blt.b  $3d6f
003D00  bcc.b  $3d67
003D02  blt.b  $3d24
003D04  bsr.b  $3d7b
003D06  ; data: 0x73, 0x6c
003D08  bcs.b  $3d73
003D0A  bvc.b  $3d71
003D0C  bgt.b  $3d2e
003D0E  ; data: 0x75, 0x6e
003D10  bcc.b  $3d32
003D12  ; data: 0x77, 0x61
003D14  ; data: 0x73, 0x20
003D16  ; data: 0x77, 0x61
003D18  moveq  #$20, d1
003D1A  move.l $2d2d(a5), -(a6)
003D1E  movea.l -(a7), a0
003D20  movea.l -(a1), a0
003D22  movea.l $20(a2, d2.w), a0
003D26  movea.l $2069(a6), a0
003D2A  movea.l $2021.w, a0
003D2E  move.l -(a1), -(a0)
003D30  movea.l -(a4), a0
003D32  bsr.b  $3da7
003D34  movea.l ([$206d6972, a7], $2000), a0
003D3E  movea.l -(a1), a0
003D40  bhi.b  $3da7
003D42  moveq  #$20, d1
003D44  ; data: 0x73, 0x63
003D46  bvc.b  $3db7
003D48  bgt.b  $3d6a
003D4A  moveq  #$6f, d3
003D4C  moveq  #$68, d1
003D4E  bcs.b  $3dc2
003D50  movea.l $6c61(a3), a0
003D54  moveq  #$2c, d1
003D56  movea.l ([$6c20, a7]), a0
003D5C  bcs.b  $3dd1
003D5E  movea.l -(a2), a0
003D60  bcs.b  $3dcb
003D62  movea.l ([$6974, a3]), a0
003D68  ; data: 0x79, 0x20
003D6A  bgt.b  $3ddb
003D6C  bls.b  $3dd6
003D6E  movea.l $6965(a6), a0
003D72  movea.l $6d69(a3, d6.l * 8), a0
003D78  moveq  #$20, d2
003D7A  bcc.b  $3de1
003D7C  bgt.b  $3d9e
003D7E  blt.b  $3def
003D80  bcc.b  $3de7
003D82  blt.b  $3df7
003D84  move.l d0, d0
003D86  movea.l -(a7), a0
003D88  bcs.b  $3df5
003D8A  bge.b  $3ded
003D8C  moveq  #$70, d0
003D8E  moveq  #$20, d2
003D90  bvc.b  $3df3
003D92  moveq  #$2e, d2
003D94  movea.l $6368(a1), a0
003D98  movea.l ([$20657874, a7], $7261), a0
003DA2  movea.l -(a4), a0
003DA4  bcs.b  $3e19
003DA6  ; data: 0x77, 0x65
003DA8  beq.b  $3e0f
003DAA  bgt.b  $3dcc
003DAC  bsr.b  $3e1b
003DAE  movea.l ([$6865, a7], $6e656e64), a0
003DB8  bcs.b  $3dda
003DBA  bvs.b  $3e2a
003DBC  movea.l $656c(a7, invalid.w), a0
003DC2  movea.l -(a2), a0
003DC4  bcs.b  $3e2f
003DC6  movea.l -(a4), a0
003DC8  bvs.b  $3e2f
003DCA  moveq  #$6b, d1
003DCC  move.l -(a0), d6
003DCE  ori.b  #$62, -(a0)
003DD2  ; data: 0x77, 0x6f
003DD4  bvc.b  $3e42
003DD6  movea.l $6368(a1), a0
003DDA  movea.l -(a5), a0
003DDC  bvs.b  $3e45
003DDE  bcs.b  $3e4e
003DE0  moveq  #$6c, d2
003DE2  bvs.b  $3e47
003DE4  bvc.b  $3e06
003DE6  beq.b  $3e4d
003DE8  bhi.b  $3e5f
003DEA  moveq  #$74, d1
003DEC  ; data: 0x73, 0x74
003DEE  bsr.b  $3e57
003DF0  movea.l $6174(a0), a0
003DF4  moveq  #$65, d2
003DF6  move.l -(a0), d7
003DF8  move.l $2e(a2, d3.w), -(a6)
003DFC  move.w $756e(a0, d2.l * 4), -(a0)
003E02  bcc.b  $3e24
003E04  ; data: 0x73, 0x63
003E06  bvc.b  $3e6d
003E08  bvs.b  $3e7d
003E0A  ; data: 0x73, 0x65
003E0C  bcs.b  $3e73
003E0E  bcs.b  $3e30
003E10  move.l $2e20(a6), d7
003E14  ori.b  #$0, -(a0)
003E18  move.l $2e2e(a6), d0
003E1C  move.l $2e2e(a6), d7
003E20  move.l $2075(a6), d7
003E24  bgt.b  $3e8a
003E26  movea.l -(a4), a0
003E28  bcs.b  $3e9d
003E2A  ; data: 0x77, 0x65
003E2C  beq.b  $3e93
003E2E  bgt.b  $3e50
003E30  bhi.b  $3e9b
003E32  bgt.b  $3e54
003E34  bvs.b  $3e99
003E36  bvc.b  $3e58
003E38  bsr.b  $3eaf
003E3A  bls.b  $3ea4
003E3C  movea.l ([$6420, a3]), a0
003E42  beq.b  $3ea9
003E44  ; data: 0x73, 0x74
003E46  bcs.b  $3eba
003E48  bgt.b  $3e6a
003E4A  bmi.b  $3ebe
003E4C  bsr.b  $3ebc
003E4E  bmi.b  $3e70
003E50  move.l $2e2e(a6), d7
003E54  move.l -(a0), d7
003E56  ori.b  #$2e, -(a0)
003E5A  move.l $2e20(a6), d7
003E5E  ori.b  #$2e, -(a0)
003E62  move.l $2e2e(a6), d7
003E66  move.l -(a0), d7
003E68  bgt.b  $3ecb
003E6A  bpl.b  $3ecd
003E6C  move.l $2e2e(a6), d0
003E70  move.l -(a0), d7
003E72  beq.b  $3ed9
003E74  bge.b  $3ee5
003E76  beq.b  $3edd
003E78  bgt.b  $3e9a
003E7A  move.l $2e20(a6), d7
003E7E  bvs.b  $3ee3
003E80  bvc.b  $3ea2
003E82  bvc.b  $3ee5
003E84  moveq  #$74, d2
003E86  bcs.b  $3ea8
003E88  bmi.b  $3eef
003E8A  bvs.b  $3efa
003E8C  movea.l -(a2), a0
003E8E  ble.b  $3ef3
003E90  bmi.b  $3eb2
003E92  bsr.b  $3f09
003E94  bne.b  $3eb6
003E96  beq.b  $3f05
003E98  bmi.b  $3eba
003E9A  blt.b  $3f0b
003E9C  bgt.b  $3f12
003E9E  bsr.b  $3f07
003EA0  ; data: 0x73, 0x20
003EA2  ; data: 0x75, 0x6e
003EA4  bcc.b  $3ec6
003EA6  ori.b  #$63, -(a0)
003EAA  bvc.b  $3ecc
003EAC  bvc.b  $3f0f
003EAE  moveq  #$74, d2
003EB0  bcs.b  $3ed2
003EB2  moveq  #$6f, d3
003EB4  bgt.b  $3ed6
003EB6  ; data: 0x73, 0x61
003EB8  blt.b  $3f2d
003EBA  moveq  #$61, d2
003EBC  beq.b  $3ede
003EBE  bsr.b  $3f35
003EC0  bne.b  $3ee2
003EC2  ; data: 0x73, 0x6f
003EC4  bgt.b  $3f3a
003EC6  bsr.b  $3f2f
003EC8  movea.l -(a4), a0
003ECA  ; data: 0x75, 0x72
003ECC  bls.b  $3f36
003ECE  beq.b  $3f35
003ED0  blt.b  $3f33
003ED2  bls.b  $3f3c
003ED4  moveq  #$20, d2
003ED6  ; data: 0x75, 0x6e
003ED8  bcc.b  $3efa
003EDA  beq.b  $3f41
003EDC  bsr.b  $3f50
003EDE  bhi.b  $3f45
003EE0  bvs.b  $3f56
003EE2  bcs.b  $3f58
003EE4  movea.l $64(a5, d6.l), a0
003EE8  move.l -(a0), d0
003EEA  ori.b  #$69, -(a0)
003EEE  beq.b  $3f55
003EF0  bgt.b  $3f66
003EF2  bge.b  $3f5d
003EF4  bls.b  $3f5e
003EF6  movea.l $7565(a4), a0
003EFA  beq.b  $3f70
003EFC  movea.l $616e(a5), a0
003F00  movea.l $6e20(a1), a0
003F04  bcs.b  $3f6f
003F06  bgt.b  $3f6d
003F08  blt.b  $3f2a
003F0A  moveq  #$61, d2
003F0C  beq.b  $3f73
003F0E  bhi.b  $3f85
003F10  bls.b  $3f7a
003F12  movea.l $6120(a2), a0
003F16  bgt.b  $3f81
003F18  bls.b  $3f82
003F1A  moveq  #$20, d2
003F1C  move.l $2e2e(a6), d7
003F20  movea.l $6920(a0), a0
003F24  bvc.b  $3f8f
003F26  move.l -(a0), d0
003F28  ori.b  #$2e, -(a0)
003F2C  move.l -(a0), d7
003F2E  bvs.b  $3f93
003F30  bvc.b  $3f52
003F32  bmi.b  $3fa3
003F34  blt.b  $3fa3
003F36  movea.l $6972(a5), a0
003F3A  move.l -(a0), d6
003F3C  ; data: 0x77, 0x69
003F3E  bcs.b  $3f60
003F40  bcs.b  $3fab
003F42  bgt.b  $3f64
003F44  bmi.b  $3faf
003F46  bgt.b  $3fac
003F48  movea.l ([$2c206461, a6], $7320), a0
003F52  bgt.b  $3fc3
003F54  bls.b  $3fbe
003F56  movea.l $6e20(a1), a0
003F5A  bcc.b  $3fc1
003F5C  moveq  #$20, d1
003F5E  moveq  #$68, d0
003F60  bsr.b  $3fce
003F62  bvs.b  $3fc7
003F64  bvc.b  $3fcb
003F66  bgt.b  $3f95
003F68  moveq  #$68, d0
003F6A  bsr.b  $3fdf
003F6C  bcs.b  $3f8e
003F6E  ori.b  #$69, -(a0)
003F72  moveq  #$7a, d2
003F74  moveq  #$20, d2
003F76  move.l $2e20(a6), d7
003F7A  ; data: 0x75, 0x6e
003F7C  bcc.b  $3f9e
003F7E  bcc.b  $3fe9
003F80  bcs.b  $3fa2
003F82  blt.b  $3ff9
003F84  moveq  #$74, d2
003F86  bcs.b  $3ffa
003F88  movea.l -(a6), a0
003F8A  bvs.b  $3fef
003F8C  bmi.b  $3ff3
003F8E  bgt.b  $3fb0
003F90  ; data: 0x77, 0x69
003F92  bge.b  $4000
003F94  move.l $2e2e(a6), d0
003F98  move.l $2e2e(a6), d7
003F9C  move.l $2000(a6), d7
003FA0  move.l -(a0), d0
003FA2  ori.b  #$61, -(a0)
003FA6  movea.l $6120(a0), a0
003FAA  blt.b  $4021
003FAC  ; data: 0x73, 0x73
003FAE  movea.l $6368(a1), a0
003FB2  movea.l $6163(a4), a0
003FB6  bvc.b  $401d
003FB8  bgt.b  $3fe6
003FBA  movea.l $6569(a5), a0
003FBE  bgt.b  $4025
003FC0  movea.l $696e(a3), a0
003FC4  bcc.b  $402b
003FC6  moveq  #$20, d1
003FC8  ; data: 0x77, 0x65
003FCA  moveq  #$64, d1
003FCC  bcs.b  $403c
003FCE  movea.l $6f(a3, d7.w), a0
003FD2  bge.b  $404e
003FD4  movea.l -(a1), a0
003FD6  ; data: 0x75, 0x66
003FD8  movea.l $6963(a5), a0
003FDC  bvc.b  $3ffe
003FDE  ; data: 0x73, 0x65
003FE0  bvs.b  $4050
003FE2  move.l $2e2e(a6), d0
003FE6  move.l d0, d0
003FE8  move.l $2e2e(a6), d0
003FEC  movea.l $6920(a0), a0
003FF0  bvc.b  $405b
003FF2  move.l $2e2e(a6), d0
003FF6  ori.b  #$65, -(a0)
003FFA  ; data: 0x75, 0x74
003FFC  bcs.b  $401e
003FFE  bvc.b  $4061
004000  moveq  #$74, d2
004002  bcs.b  $4024
004004  bvs.b  $4069
004006  bvc.b  $4028
004008  moveq  #$6f, d3
00400A  moveq  #$2c, d1
00400C  move.l $73(a4, d2.w), d0
004010  bsr.b  $4075
004012  bvc.b  $4079
004014  bgt.b  $4036
004016  moveq  #$75, d5
004018  movea.l $6163(a5), a0
00401C  bvc.b  $4083
00401E  bgt.b  $4040
004020  move.w -(a0), d5
004022  ori.b  #$31, -(a0)
004026  move.l -(a0), d7
004028  bvs.b  $408d
00402A  bvc.b  $404c
00402C  bvc.b  $408f
00402E  bhi.b  $4095
004030  movea.l -(a5), a0
004032  ; data: 0x73, 0x20
004034  blt.b  $409f
004036  moveq  #$20, d1
004038  bvs.b  $40ac
00403A  beq.b  $40a1
00403C  bgt.b  $40a2
00403E  ; data: 0x77, 0x6f
004040  movea.l -(a1), a0
004042  ; data: 0x75, 0x66
004044  beq.b  $40ab
004046  ; data: 0x73, 0x63
004048  bvc.b  $40bc
00404A  bvs.b  $40b1
00404C  bhi.b  $40b3
00404E  bgt.b  $4070
004050  move.l $2e20(a6), d7
004054  ori.b  #$20, -(a0)
004058  move.l -(a0), d0
00405A  bsr.b  $40c4
00405C  movea.l $6120(a2), a0
004060  move.l $2e20(a6), d7
004064  bcc.b  $40cf
004066  bcs.b  $4088
004068  move.w -(a4), $2d73(a1)
00406C  moveq  #$65, d2
00406E  moveq  #$6e, d1
004070  bcs.b  $409e
004072  movea.l ([$2072, a3]), a0
004078  ; data: 0x75, 0x63
00407A  bmi.b  $40e1
00407C  bge.b  $40ec
00407E  movea.l $6f63(a6), a0
004082  bvc.b  $40a4
004084  bsr.b  $40fb
004086  bne.b  $40a8
004088  bcc.b  $40ef
00408A  blt.b  $40ac
00408C  move.w $65(a0, d3.w), -(a2)
004090  moveq  #$20, d1
004092  ; data: 0x75, 0x6e
004094  bcc.b  $40b6
004096  ori.b  #$20, -(a0)
00409A  move.l -(a0), d0
00409C  bcc.b  $4107
00409E  bcs.b  $40c0
0040A0  bne.b  $4103
0040A2  moveq  #$62, d1
0040A4  bcs.b  $4114
0040A6  movea.l $6c74(a7, invalid.w), a0
0040AC  bcs.b  $40ce
0040AE  bvs.b  $4113
0040B0  bvc.b  $40d2
0040B2  bsr.b  $4129
0040B4  bls.b  $411e
0040B6  movea.l $6f63(a6), a0
0040BA  bvc.b  $40dc
0040BC  move.l $2e20(a6), d7
0040C0  ori.b  #$32, -(a0)
0040C4  move.l -(a0), d7
0040C6  bcc.b  $4131
0040C8  bcs.b  $413d
0040CA  bcs.b  $413a
0040CC  movea.l $6f6d(a3), a0
0040D0  bvs.b  $4145
0040D2  bls.b  $413c
0040D4  bcs.b  $4144
0040D6  movea.l -(a1), a0
0040D8  ; data: 0x75, 0x64
0040DA  bvs.b  $414b
0040DC  move.l $656f(a6, invalid.w), $2d65(a6)
0040E4  bne.b  $414c
0040E6  bcs.b  $4153
0040E8  moveq  #$20, d2
0040EA  bcc.b  $4151
0040EC  moveq  #$20, d1
0040EE  bge.b  $4151
0040F0  bcs.b  $4167
0040F2  bne.b  $4168
0040F4  movea.l -(a1), a0
0040F6  ; data: 0x75, 0x63
0040F8  bvc.b  $411a
0040FA  bgt.b  $416b
0040FC  bls.b  $4166
0040FE  movea.l $6e20(a1), a0
004102  ori.b  #$20, -(a0)
004106  move.l -(a0), d0
004108  move.w -(a0), d1
00410A  bne.b  $417e
00410C  bsr.b  $417b
00410E  bcs.b  $4183
004110  movea.l -(a1), a0
004112  ; data: 0x75, 0x66
004114  movea.l -(a4), a0
004116  bcs.b  $4185
004118  move.l $30(a5, d3.w), d0
00411C  bcs.b  $4190
00411E  movea.l ([$7374, a3]), a0
004124  movea.l $6165(a4), a0
004128  ; data: 0x75, 0x66
00412A  moveq  #$20, d2
00412C  bsr.b  $419a
00412E  bge.b  $4195
004130  ; data: 0x73, 0x20
004132  bvs.b  $41a2
004134  move.l $66(a1, d2.w), d0
004138  moveq  #$61, d1
00413A  blt.b  $41a1
00413C  move.l -(a0), d6
00413E  bsr.b  $41a2
004140  beq.b  $41a7
004142  ; data: 0x73, 0x65
004144  bvc.b  $41ab
004146  bgt.b  $4168
004148  ori.b  #$20, -(a0)
00414C  move.l -(a0), d0
00414E  moveq  #$6f, d3
004150  bgt.b  $4172
004152  bls.b  $41bc
004154  bsr.b  $41c5
004156  ; data: 0x73, 0x20
004158  ; data: 0x73, 0x20
00415A  ; data: 0x73, 0x20
00415C  moveq  #$6f, d1
00415E  ; data: 0x75, 0x74
004160  bvs.b  $41d0
004162  bcs.b  $41d2
004164  move.l -(a0), d7
004166  ori.b  #$33, -(a0)
00416A  move.l -(a0), d7
00416C  move.w $2035(a6), d2
004170  move.l -(a0), d7
004172  bgt.b  $41e3
004174  bls.b  $41de
004176  movea.l ([$7220, a0]), a0
00417C  bcc.b  $41e3
00417E  ; data: 0x73, 0x69
004180  beq.b  $41f0
004182  move.l ([$6865, a3], $6e207a2e), $622e(a6)
00418E  movea.l -(a2), a0
004190  bcs.b  $41fb
004192  movea.l -(a4), a0
004194  bcs.b  $4203
004196  movea.l $756d(a2), a0
00419A  moveq  #$2d, d0
00419C  bhi.b  $41ff
00419E  bge.b  $420c
0041A0  movea.l $64(a5, d6.l), a0
0041A4  movea.l -(a4), a0
0041A6  bcs.b  $4216
0041A8  move.l d0, d0
0041AA  move.l -(a0), d0
0041AC  move.l -(a0), d0
0041AE  move.l -(a0), d0
0041B0  move.l -(a0), d0
0041B2  move.l -(a0), d0
0041B4  movea.l $b125(pc), a0
0041B8  blt.b  $4223
0041BA  bgt.b  $4223
0041BC  move.l ([$7475, a0], $7265732e), $2000(a6)
0041C8  move.l -(a0), d0
0041CA  ori.b  #$63, -(a0)
0041CE  bvc.b  $41f0
0041D0  bhi.b  $423b
0041D2  bgt.b  $41f4
0041D4  bcs.b  $4239
0041D6  bvc.b  $424c
0041D8  movea.l -(a7), a0
0041DA  bcs.b  $424f
0041DC  moveq  #$61, d0
0041DE  bgt.b  $424e
0041E0  moveq  #$20, d2
0041E2  ble.b  $4246
0041E4  movea.l ([$20657320, a7], $7363), a0
0041EE  bvc.b  $4251
0041F0  bne.b  $4258
0041F2  bcs.b  $4262
0041F4  movea.l $64(a5, d6.l), a0
0041F8  movea.l $2e2e(a3, d6.l * 8), a0
0041FE  move.l -(a0), d7
004200  ori.b  #$6e, -(a0)
004204  bcc.b  $4226
004206  ble.b  $426a
004208  movea.l -(a5), a0
00420A  ; data: 0x73, 0x20
00420C  beq.b  $4273
00420E  bge.b  $4274
004210  movea.l $6465(a7), a0
004214  moveq  #$20, d1
004216  bvc.b  $4279
004218  bcc.b  $4291
00421A  bsr.b  $428e
00421C  bcs.b  $423e
00421E  ble.b  $4284
004220  bcs.b  $4294
004222  movea.l -(a5), a0
004224  bvs.b  $4294
004226  movea.l -(a1), a0
004228  ; data: 0x75, 0x74
00422A  ble.b  $424c
00422C  beq.b  $4297
00422E  bhi.b  $42a4
004230  move.l -(a0), d6
004232  ; data: 0x77, 0x61
004234  ; data: 0x73, 0x20
004236  ; data: 0x77, 0x69
004238  moveq  #$20, d1
00423A  bgt.b  $42a5
00423C  bls.b  $42a6
00423E  moveq  #$20, d2
004240  ori.b  #$65, -(a0)
004244  ; data: 0x77, 0x69
004246  bgt.b  $42b6
004248  bcs.b  $42b8
00424A  move.l $2e2e(a6), d0
00424E  move.l d0, d0
004250  movea.l $64(a5, d6.l), a0
004254  movea.l -(a5), a0
004256  bvs.b  $42bf
004258  bcs.b  $42c8
00425A  moveq  #$6c, d2
00425C  bvs.b  $42c1
00425E  bvc.b  $4280
004260  bhi.b  $42cb
004262  bgt.b  $4284
004264  bvs.b  $42c9
004266  bvc.b  $4288
004268  moveq  #$69, d3
00426A  bcs.b  $42d8
00426C  movea.l $6568(a5), a0
004270  moveq  #$20, d1
004272  bsr.b  $42e9
004274  bne.b  $4296
004276  bcc.b  $42e1
004278  bcs.b  $429a
00427A  moveq  #$65, d5
00427C  bvs.b  $42f2
00427E  movea.l $6163(a6), a0
004282  bvc.b  $42a4
004284  bcc.b  $42eb
004286  moveq  #$20, d1
004288  ; data: 0x77, 0x6f
00428A  bls.b  $42ac
00428C  beq.b  $42f3
00428E  ; data: 0x73, 0x70
004290  bsr.b  $4300
004292  bgt.b  $4308
004294  move.l -(a0), d6
004296  ori.b  #$65, -(a0)
00429A  bvs.b  $4308
00429C  movea.l $6368(a1), a0
0042A0  movea.l $6972(a5), a0
0042A4  movea.l ([$67656e6f, a6], $6d6d), a0
0042AE  bcs.b  $431e
0042B0  movea.l $6162(a0), a0
0042B4  bcs.b  $42d6
0042B6  bgt.b  $4319
0042B8  bls.b  $4322
0042BA  movea.l -(a4), a0
0042BC  bcs.b  $4330
0042BE  movea.l ([$2065, a7], $696e2061), a0
0042C8  bvs.b  $432e
0042CA  ; data: 0x73, 0x2d
0042CC  moveq  #$65, d2
0042CE  ; data: 0x73, 0x74
0042D0  movea.l $b7f2(pc), a0
0042D4  blt.b  $4337
0042D6  bls.b  $4340
0042D8  bcs.b  $4348
0042DA  move.l d0, d0
0042DC  movea.l $64(a5, d6.l), a0
0042E0  movea.l -(a5), a0
0042E2  ; data: 0x73, 0x20
0042E4  ; data: 0x73, 0x69
0042E6  bcs.b  $4350
0042E8  moveq  #$20, d2
0042EA  bvs.b  $435e
0042EC  beq.b  $4353
0042EE  bgt.b  $4354
0042F0  ; data: 0x77, 0x69
0042F2  bcs.b  $4314
0042F4  ; data: 0x73, 0x63
0042F6  bvc.b  $435d
0042F8  bvs.b  $436d
0042FA  ; data: 0x73, 0x65
0042FC  movea.l -(a1), a0
0042FE  ; data: 0x75, 0x73
004300  move.l $2e2e(a6), d0
004304  movea.l ([$6c20, a7]), a0
00430A  bvs.b  $436f
00430C  bvc.b  $432e
00430E  beq.b  $437c
004310  bsr.b  $4387
004312  bhi.b  $4379
004314  move.l -(a0), d6
004316  bcc.b  $4379
004318  ; data: 0x73, 0x73
00431A  move.l d0, d0
00431C  movea.l $6368(a1), a0
004320  movea.l -(a1), a0
004322  bgt.b  $438b
004324  ; data: 0x73, 0x74
004326  movea.l $6162(a0), a0
00432A  bcs.b  $434c
00432C  ; data: 0x75, 0x6e
00432E  bcc.b  $4350
004330  bcc.b  $4393
004332  ; data: 0x73, 0x20
004334  bvs.b  $43a9
004336  moveq  #$20, d2
004338  bvs.b  $43a7
00433A  blt.b  $43a1
00433C  moveq  #$20, d1
00433E  ; data: 0x73, 0x63
004340  bvc.b  $43a7
004342  bvs.b  $43b7
004344  ; data: 0x73, 0x65
004346  move.l $2e2e(a6), d0
00434A  move.l -(a0), d0
00434C  move.l -(a0), d0
00434E  move.l -(a0), d0
004350  move.l -(a0), d0
004352  bvs.b  $43b7
004354  bvc.b  $4376
004356  bvc.b  $43b9
004358  bhi.b  $43bf
00435A  movea.l -(a1), a0
00435C  ; data: 0x75, 0x63
00435E  bvc.b  $4380
004360  ori.b  #$69, -(a0)
004364  bls.b  $43ce
004366  moveq  #$20, d2
004368  moveq  #$6f, d3
00436A  moveq  #$2c, d1
00436C  movea.l $656d(a2), a0
004370  bsr.b  $43e0
004372  bcc.b  $4394
004374  moveq  #$6f, d3
004376  bgt.b  $4398
004378  bcc.b  $43df
00437A  bgt.b  $439c
00437C  bcs.b  $43f0
00437E  beq.b  $43e5
004380  bhi.b  $43f0
004382  bvs.b  $43f7
004384  ; data: 0x73, 0x65
004386  bgt.b  $43a8
004388  moveq  #$75, d5
00438A  movea.l -(a5), a0
00438C  moveq  #$7a, d1
00438E  bsr.b  $43f5
004390  bvc.b  $43fe
004392  bcs.b  $4402
004394  move.l -(a0), d7
004396  bsr.b  $440d
004398  bls.b  $4402
00439A  movea.l ([$6e20, a7]), a0
0043A0  bvs.b  $4405
0043A2  bvc.b  $43c4
0043A4  ori.b  #$6f, -(a0)
0043A8  ; data: 0x73, 0x69
0043AA  moveq  #$69, d2
0043AC  moveq  #$20, d3
0043AE  bhi.b  $4419
0043B0  bgt.b  $43e0
0043B2  movea.l -(a5), a0
0043B4  ; data: 0x73, 0x20
0043B6  bvs.b  $442b
0043B8  moveq  #$20, d2
0043BA  bgt.b  $4425
0043BC  bls.b  $4426
0043BE  moveq  #$20, d2
0043C0  ; data: 0x73, 0x6f
0043C2  move.l -(a0), d6
0043C4  bcc.b  $4427
0043C6  ; data: 0x73, 0x73
0043C8  movea.l $6368(a1), a0
0043CC  movea.l -(a6), a0
0043CE  bcs.b  $4439
0043D0  beq.b  $4437
0043D2  movea.l -(a2), a0
0043D4  bvs.b  $4444
0043D6  move.l -(a0), d6
0043D8  ble.b  $443e
0043DA  bcs.b  $444e
0043DC  movea.l -(a1), a0
0043DE  bgt.b  $4447
0043E0  ; data: 0x73, 0x74
0043E2  movea.l $6162(a0), a0
0043E6  bcs.b  $4408
0043E8  ori.b  #$65, -(a0)
0043EC  bvs.b  $445c
0043EE  bcs.b  $4410
0043F0  bne.b  $4464
0043F2  bcs.b  $4469
0043F4  bgt.b  $445a
0043F6  bcs.b  $4418
0043F8  moveq  #$75, d5
0043FA  movea.l ([$6c696572, a6], $656e), a0
004404  move.l -(a0), d6
004406  bsr.b  $446a
004408  bcs.b  $447c
00440A  movea.l -(a5), a0
00440C  ; data: 0x73, 0x20
00440E  bvs.b  $4483
004410  moveq  #$20, d2
004412  bsr.b  $4489
004414  bls.b  $447e
004416  movea.l $2064(a3, d6.l * 8), a0
00441C  bsr.b  $4491
00441E  ; data: 0x73, 0x20
004420  bvs.b  $4485
004422  bvc.b  $4444
004424  move.l $2e20(a6), d7
004428  bsr.b  $448d
00442A  bvc.b  $444c
00442C  bvs.b  $4491
00442E  bvc.b  $4450
004430  ori.b  #$65, -(a0)
004434  bvs.b  $44a9
004436  ; data: 0x73, 0x20
004438  bgt.b  $44a3
00443A  bls.b  $44a4
00443C  moveq  #$20, d2
00443E  move.l $2e20(a6), d7
004442  bvs.b  $44a7
004444  bvc.b  $4466
004446  ; data: 0x77, 0x65
004448  bvs.b  $44bd
00444A  ; data: 0x73, 0x20
00444C  bgt.b  $44bd
00444E  bls.b  $44b8
004450  movea.l $6963(a6), a0
004454  bvc.b  $44ca
004456  movea.l -(a7), a0
004458  bcs.b  $44c8
00445A  bsr.b  $44d1
00445C  move.l -(a0), d6
00445E  ; data: 0x77, 0x61
004460  ; data: 0x73, 0x20
004462  bvs.b  $44c7
004464  bvc.b  $4486
004466  bcc.b  $44cd
004468  bgt.b  $44d5
00446A  bcs.b  $448c
00446C  bsr.b  $44d0
00446E  bcs.b  $44e2
004470  movea.l -(a5), a0
004472  ; data: 0x73, 0x20
004474  ori.b  #$6f, -(a0)
004478  blt.b  $44e7
00447A  moveq  #$20, d2
00447C  bgt.b  $44ed
00447E  bls.b  $44e8
004480  move.l $2e2e(a6), d0
004484  move.l $2e2e(a6), d7
004488  move.l $2e20(a6), d7
00448C  ori.b  #$0, -(a0)
004490  movea.l $6575(a0), a0
004494  moveq  #$65, d2
004496  movea.l $7374(a1), a0
00449A  movea.l -(a4), a0
00449C  bcs.b  $4510
00449E  move.l $2e(a2, d3.l), d0
0044A2  move.w $75(a0, d2.w), -(a0)
0044A6  bgt.b  $450c
0044A8  movea.l -(a4), a0
0044AA  bvs.b  $4511
0044AC  movea.l ([$7465, a3]), a0
0044B2  movea.l $7573(a5), a0
0044B6  ; data: 0x73, 0x20
0044B8  moveq  #$6f, d3
0044BA  bge.b  $4528
0044BC  movea.l ([$64656e20, a7], $2e2e), a0
0044C6  move.l -(a0), d7
0044C8  ori.b  #$2e, -(a0)
0044CC  move.l -(a0), d7
0044CE  bcc.b  $4531
0044D0  ; data: 0x73, 0x20
0044D2  blt.b  $453d
0044D4  moveq  #$20, d2
0044D6  bcc.b  $453d
0044D8  blt.b  $44fa
0044DA  bsr.b  $4545
0044DC  bcc.b  $4551
0044DE  movea.l $7374(a1), a0
0044E2  movea.l -(a7), a0
0044E4  bge.b  $4547
0044E6  ; data: 0x75, 0x62
0044E8  bcs.b  $450a
0044EA  bvs.b  $454f
0044EC  bvc.b  $450e
0044EE  bsr.b  $455c
0044F0  bge.b  $4557
0044F2  ; data: 0x73, 0x20
0044F4  ; data: 0x71, 0x75
0044F6  bsr.b  $456c
0044F8  ; data: 0x73, 0x63
0044FA  bvc.b  $451c
0044FC  move.l $2e2e(a6), d7
004500  move.l $2e2e(a6), d7
004504  move.l $2e2e(a6), d7
004508  move.l $2e00(a6), d7
00450C  movea.l -(a4), a0
00450E  bsr.b  $4583
004510  movea.l $65(a4, d6.l), a0
004514  blt.b  $4577
004516  movea.l $7374(a1), a0
00451A  movea.l ([$6965736f, a3]), a0
004522  movea.l $6569(a3, invalid.w), a0
004528  ; data: 0x73, 0x73
00452A  bcs.b  $454c
00452C  ; data: 0x75, 0x6e
00452E  bcc.b  $4550
004530  bvc.b  $4597
004532  ; data: 0x75, 0x74
004534  bcs.b  $4556
004536  bvc.b  $4599
004538  bhi.b  $459f
00453A  movea.l $6368(a1), a0
00453E  movea.l ([$6572, a5], $6861), a0
004546  ; data: 0x75, 0x70
004548  moveq  #$20, d2
00454A  bmi.b  $45b1
00454C  bvs.b  $45bc
00454E  move.l d0, d0
004550  movea.l -(a2), a0
004552  ble.b  $45b7
004554  bmi.b  $4576
004556  bcc.b  $45b9
004558  moveq  #$75, d1
00455A  bcs.b  $45be
00455C  bcs.b  $45d0
00455E  movea.l $ba80(pc), a0
004562  ; data: 0x73, 0x63
004564  bvc.b  $45d8
004566  bcs.b  $45d1
004568  bhi.b  $45cf
00456A  bgt.b  $459a
00456C  movea.l $64(a5, d6.l), a0
004570  movea.l -(a5), a0
004572  bvs.b  $45db
004574  bcs.b  $45e4
004576  moveq  #$6c, d2
004578  bvs.b  $45dd
00457A  bvc.b  $459c
00457C  bvc.b  $45df
00457E  bhi.b  $45e5
004580  movea.l $6368(a1), a0
004584  movea.l -(a1), a0
004586  ; data: 0x75, 0x63
004588  bvc.b  $45aa
00458A  bmi.b  $45f1
00458C  bvs.b  $45fc
00458E  movea.l -(a2), a0
004590  ble.b  $45f5
004592  bmi.b  $45b4
004594  ori.b  #$72, -(a0)
004598  beq.b  $45ff
00459A  bgt.b  $4600
00459C  bcs.b  $4612
00459E  ; data: 0x77, 0x61
0045A0  ; data: 0x73, 0x20
0045A2  moveq  #$75, d5
0045A4  movea.l $7265(a3, invalid.w), a0
0045AA  bvs.b  $460e
0045AC  bcs.b  $461c
0045AE  move.l -(a0), d6
0045B0  ; data: 0x77, 0x65
0045B2  bvs.b  $4620
0045B4  movea.l -(a5), a0
0045B6  ; data: 0x73, 0x20
0045B8  ; data: 0x73, 0x63
0045BA  bvc.b  $462b
0045BC  bgt.b  $45de
0045BE  move.w $33(a2, d3.l), d1
0045C2  move.w -(a0), -(a0)
0045C4  bvs.b  $4639
0045C6  moveq  #$20, d2
0045C8  ; data: 0x75, 0x6e
0045CA  bcc.b  $45ec
0045CC  bvs.b  $4631
0045CE  bvc.b  $45f0
0045D0  blt.b  $4641
0045D2  moveq  #$67, d1
0045D4  bcs.b  $4644
0045D6  move.l d0, d0
0045D8  movea.l $6e20(a1), a0
0045DC  bcc.b  $4643
0045DE  moveq  #$20, d1
0045E0  bne.b  $4654
0045E2  ; data: 0x75, 0x65
0045E4  bvc.b  $4659
0045E6  moveq  #$75, d2
0045E8  bgt.b  $464e
0045EA  bcs.b  $460c
0045EC  bcc.b  $4657
0045EE  bcs.b  $4610
0045F0  bvs.b  $4660
0045F2  bne.b  $4663
0045F4  moveq  #$6d, d1
0045F6  bsr.b  $466c
0045F8  bvs.b  $4665
0045FA  move.l $6c61(a3), $7573(a6)
004600  ; data: 0x75, 0x72
004602  movea.l $7265(a3, invalid.w), a0
004608  bvs.b  $466c
00460A  bcs.b  $467a
00460C  movea.l ([$64652e20, a7], $20), a0
004616  bmi.b  $468a
004618  bsr.b  $4688
00461A  bmi.b  $463c
00461C  bhi.b  $4687
00461E  bgt.b  $4640
004620  bvs.b  $4685
004622  bvc.b  $4644
004624  bvs.b  $4693
004626  blt.b  $468d
004628  moveq  #$20, d1
00462A  bgt.b  $469b
00462C  bls.b  $4696
00462E  move.l -(a0), d7
004630  bvc.b  $46a7
004632  ; data: 0x73, 0x74
004634  bcs.b  $4656
004636  bpl.b  $469d
004638  bcc.b  $469f
00463A  move.l $20(a1, d3.w), d0
00463E  ; data: 0x73, 0x65
004640  bmi.b  $46b7
004642  bgt.b  $46a8
004644  bcs.b  $46b4
004646  movea.l $64(a5, d6.l), a0
00464A  movea.l $6174(a0), a0
00464E  moveq  #$65, d2
004650  movea.l -(a4), a0
004652  bvs.b  $46b9
004654  move.l d0, d0
004656  movea.l $69(a0, d6.l), a0
00465A  bge.b  $46cb
00465C  movea.l $6c61(a3), a0
004660  ; data: 0x75, 0x73
004662  ; data: 0x75, 0x72
004664  movea.l $6575(a0), a0
004668  moveq  #$65, d2
00466A  movea.l $6963(a6), a0
00466E  bvc.b  $46e4
004670  movea.l $6974(a5), a0
004674  beq.b  $46db
004676  ; data: 0x73, 0x63
004678  bvc.b  $46ec
00467A  bvs.b  $46e1
00467C  bhi.b  $46e3
00467E  bgt.b  $46a0
004680  move.l -(a0), -(a6)
004682  ; data: 0x77, 0x65
004684  bvs.b  $46f2
004686  movea.l $7261(a3), a0
00468A  bgt.b  $46f7
00468C  move.l -(a1), d0
00468E  move.l -(a1), -(a0)
004690  move.l d0, d0
004692  movea.l -(a4), a0
004694  bsr.b  $46fc
004696  ; data: 0x75, 0x65
004698  moveq  #$20, d1
00469A  bvc.b  $46fd
00469C  bhi.b  $4703
00469E  movea.l $6368(a1), a0
0046A2  movea.l -(a1), a0
0046A4  bge.b  $4712
0046A6  bcs.b  $46c8
0046A8  moveq  #$75, d0
0046AA  bgt.b  $4717
0046AC  moveq  #$65, d2
0046AE  movea.l -(a7), a0
0046B0  bcs.b  $4725
0046B2  bls.b  $471c
0046B4  bsr.b  $471c
0046B6  bne.b  $472c
0046B8  move.l -(a0), d6
0046BA  ; data: 0x77, 0x61
0046BC  ; data: 0x73, 0x20
0046BE  bsr.b  $4732
0046C0  moveq  #$65, d2
0046C2  movea.l -(a1), a0
0046C4  bgt.b  $472d
0046C6  bcs.b  $4730
0046C8  moveq  #$2c, d2
0046CA  movea.l $6574(a2), a0
0046CE  moveq  #$74, d5
0046D0  movea.l ([$74652000, a7], $2069), a0
0046DA  bls.b  $4744
0046DC  movea.l ([$6b6c6963, a7], $6820), a0
0046E6  bgt.b  $475d
0046E8  moveq  #$20, d1
0046EA  bgt.b  $475b
0046EC  bls.b  $4756
0046EE  movea.l -(a1), a0
0046F0  ; data: 0x75, 0x66
0046F2  movea.l -(a4), a0
0046F4  bvs.b  $475b
0046F6  movea.l $6575(a6), a0
0046FA  bcs.b  $476a
0046FC  movea.l -(a7), a0
0046FE  moveq  #$61, d1
004700  bne.b  $476b
004702  bmi.b  $4769
004704  bgt.b  $4732
004706  movea.l $64(a5, d6.l), a0
00470A  movea.l -(a5), a0
00470C  ; data: 0x73, 0x20
00470E  ; data: 0x73, 0x69
004710  bcs.b  $477a
004712  moveq  #$20, d2
004714  bvs.b  $4788
004716  beq.b  $477d
004718  bgt.b  $477e
00471A  move.l -(a0), -(a6)
00471C  ori.b  #$69, -(a0)
004720  bcs.b  $4742
004722  ; data: 0x73, 0x63
004724  bvc.b  $4792
004726  bcs.b  $478b
004728  bvc.b  $479e
00472A  movea.l -(a1), a0
00472C  ; data: 0x75, 0x73
00472E  move.l -(a0), d6
004730  ; data: 0x77, 0x65
004732  bvs.b  $47a0
004734  movea.l ([$6820, a3], $72612073), a0
00473E  bls.b  $47a8
004740  ble.b  $47b0
004742  movea.l ([$6420, a3]), a0
004748  move.w -(a0), d1
00474A  moveq  #$61, d2
00474C  beq.b  $47b3
00474E  bgt.b  $4770
004750  bgt.b  $47bb
004752  bls.b  $47bc
004754  moveq  #$20, d2
004756  blt.b  $47bd
004758  bvc.b  $47cc
00475A  movea.l -(a7), a0
00475C  bcs.b  $47cb
00475E  bcs.b  $47cc
004760  bcc.b  $47c7
004762  moveq  #$20, d2
004764  ori.b  #$61, -(a0)
004768  moveq  #$2c, d2
00476A  movea.l $6277(a7), a0
00476E  ble.b  $47d8
004770  bge.b  $4792
004772  bcs.b  $47e6
004774  movea.l $6566(a4, invalid.w), a0
00477A  ble.b  $47ea
00477C  move.l $7265(a3), $6469(a6)
004782  moveq  #$2d, d2
004784  bmi.b  $47e7
004786  moveq  #$74, d1
004788  bcs.b  $47f8
00478A  movea.l $6174(a0), a0
00478E  move.l -(a0), d7
004790  move.l d0, d0
004792  move.l -(a0), d0
004794  ori.b  #$65, -(a0)
004798  moveq  #$7a, d2
00479A  moveq  #$20, d2
00479C  ; data: 0x77, 0x61
00479E  ; data: 0x73, 0x20
0047A0  beq.b  $4803
0047A2  bgt.b  $481e
0047A4  movea.l -(a1), a0
0047A6  bgt.b  $480c
0047A8  bcs.b  $481c
0047AA  bcs.b  $481f
0047AC  move.l -(a0), d7
0047AE  ; data: 0x73, 0x63
0047B0  bvc.b  $4824
0047B2  ble.b  $4819
0047B4  bcc.b  $481b
0047B6  moveq  #$20, d1
0047B8  bvc.b  $481b
0047BA  moveq  #$20, d2
0047BC  ; data: 0x73, 0x69
0047BE  bls.b  $4828
0047C0  movea.l -(a1), a0
0047C2  ; data: 0x75, 0x63
0047C4  bvc.b  $47e6
0047C6  bgt.b  $4831
0047C8  bls.b  $4832
0047CA  moveq  #$20, d2
0047CC  beq.b  $4833
0047CE  blt.b  $4835
0047D0  bge.b  $4836
0047D2  bcs.b  $4848
0047D4  move.l -(a0), d6
0047D6  ori.b  #$65, -(a0)
0047DA  bvs.b  $47fc
0047DC  bvc.b  $4843
0047DE  bgt.b  $4844
0047E0  moveq  #$69, d1
0047E2  bmi.b  $4804
0047E4  bvc.b  $4847
0047E6  bhi.b  $484d
0047E8  movea.l $6368(a1), a0
0047EC  movea.l -(a7), a0
0047EE  bcs.b  $4863
0047F0  moveq  #$65, d2
0047F2  moveq  #$6e, d1
0047F4  movea.l $6d20(a1), a0
0047F8  bvc.b  $4869
0047FA  moveq  #$65, d2
0047FC  bge.b  $481e
0047FE  bsr.b  $486e
004800  beq.b  $4867
004802  moveq  #$75, d1
004804  bne.b  $486b
004806  bgt.b  $4828
004808  ; data: 0x75, 0x6e
00480A  bcc.b  $482c
00480C  bcs.b  $4880
00480E  movea.l $6174(a0), a0
004812  moveq  #$65, d2
004814  movea.l $6569(a3), a0
004818  bgt.b  $487f
00481A  move.l d0, d0
00481C  movea.l $ad87(pc), a0
004820  moveq  #$2e, d2
004822  movea.l $6575(a0), a0
004826  moveq  #$65, d2
004828  movea.l $6162(a0), a0
00482C  bcs.b  $484e
00482E  bvs.b  $4893
004830  bvc.b  $4852
004832  ; data: 0x77, 0x69
004834  bcs.b  $489a
004836  bcs.b  $48aa
004838  movea.l -(a2), a0
00483A  bcs.b  $48a5
00483C  movea.l $686d(a1), a0
004840  movea.l -(a1), a0
004842  bgt.b  $48ab
004844  bcs.b  $48b8
004846  ; data: 0x75, 0x66
004848  bcs.b  $48b8
00484A  move.l $2e2e(a6), d0
00484E  movea.l $6f6d(a3), a0
004852  bvs.b  $48c7
004854  bls.b  $48be
004856  move.l $2e2e(a6), d0
00485A  movea.l $64(a5, d6.l), a0
00485E  move.l d0, d0
004860  movea.l $6368(a1), a0
004864  movea.l -(a4), a0
004866  bsr.b  $48cb
004868  bvc.b  $48de
00486A  bcs.b  $488c
00486C  ; data: 0x73, 0x69
00486E  bcs.b  $4890
004870  bmi.b  $48e1
004872  blt.b  $48e1
004874  bcs.b  $48e4
004876  movea.l $6963(a5), a0
00487A  bvc.b  $489c
00487C  ; data: 0x73, 0x63
00487E  bvc.b  $48ef
004880  bgt.b  $48a2
004882  bhi.b  $48e9
004884  ; data: 0x73, 0x75
004886  bls.b  $48f0
004888  bcs.b  $48f8
00488A  move.l -(a0), d6
00488C  moveq  #$6f, d3
00488E  moveq  #$61, d1
004890  bge.b  $48fe
004892  bcs.b  $4901
004894  move.l -(a0), d6
004896  ; data: 0x77, 0x65
004898  bvs.b  $4906
00489A  movea.l ([$206d, a3]), a0
0048A0  bvs.b  $4914
0048A2  move.l d0, d0
0048A4  movea.l $6f63(a6), a0
0048A8  bvc.b  $48ca
0048AA  ; data: 0x77, 0x61
0048AC  ; data: 0x73, 0x20
0048AE  ; data: 0x73, 0x63
0048B0  bvc.b  $4917
0048B2  bgt.b  $4917
0048B4  bmi.b  $491b
0048B6  bgt.b  $48d8
0048B8  ; data: 0x77, 0x6f
0048BA  bge.b  $4928
0048BC  moveq  #$65, d2
0048BE  bgt.b  $48e0
0048C0  ; data: 0x75, 0x6e
0048C2  bcc.b  $48e4
0048C4  bcs.b  $4939
0048C6  movea.l $6f6e(a5), a0
0048CA  moveq  #$61, d2
0048CC  beq.b  $48fa
0048CE  movea.l -(a1), a0
0048D0  bge.b  $4945
0048D2  movea.l ([$20756e73, a7], $206d), a0
0048DC  bvs.b  $4952
0048DE  movea.l $6972(a3), a0
0048E2  ; data: 0x73, 0x74
0048E4  bcs.b  $4954
0048E6  move.l d0, d0
0048E8  movea.l $64(a5, d6.l), a0
0048EC  movea.l $6573(a2), a0
0048F0  ; data: 0x73, 0x69
0048F2  movea.l -(a6), a0
0048F4  ble.b  $4964
0048F6  bcc.b  $496d
0048F8  bcs.b  $491a
0048FA  beq.b  $4961
0048FC  moveq  #$72, d2
0048FE  ble.b  $4966
004900  bne.b  $4967
004902  bgt.b  $4924
004904  bvc.b  $4967
004906  bhi.b  $496d
004908  bgt.b  $4936
00490A  movea.l ([$67657373, a6], $656e), a0
004914  movea.l $6162(a0), a0
004918  bcs.b  $4988
00491A  move.l -(a0), d7
00491C  bgt.b  $497f
00491E  bpl.b  $4981
004920  movea.l ([$2064, a3]), a0
004926  bcs.b  $4996
004928  bmi.b  $498f
00492A  bgt.b  $494c
00492C  ori.b  #$65, -(a0)
004930  ; data: 0x73, 0x74
004932  bvs.b  $49a1
004934  blt.b  $49aa
004936  movea.l $6963(a6), a0
00493A  bvc.b  $49b0
00493C  movea.l $7769(a3, d6.l * 8), a0
004942  bcs.b  $4964
004944  bvs.b  $49a9
004946  bvc.b  $4968
004948  ; data: 0x75, 0x6e
00494A  bcc.b  $496c
00494C  bvc.b  $49af
00494E  bhi.b  $49b5
004950  bgt.b  $4972
004952  bcs.b  $49c7
004954  movea.l $6963(a6), a0
004958  bvc.b  $49ce
00495A  movea.l -(a5), a0
00495C  bvs.b  $49cc
00495E  blt.b  $49c1
004960  bge.b  $4982
004962  bhi.b  $49c9
004964  blt.b  $49cb
004966  moveq  #$6b, d1
004968  moveq  #$2e, d2
00496A  movea.l ([$61732000, a3]), a0
004972  movea.l $7374(a1), a0
004976  movea.l -(a1), a0
004978  bhi.b  $49df
00497A  moveq  #$20, d1
00497C  bgt.b  $49ed
00497E  moveq  #$6d, d1
004980  bsr.b  $49ee
004982  move.l -(a0), d6
004984  bcc.b  $49eb
004986  bgt.b  $49f6
004988  movea.l $616e(a5), a0
00498C  movea.l ([$6874, a3]), a0
004992  movea.l ([$6820, a3], $696d6d65), a0
00499C  moveq  #$20, d1
00499E  bsr.b  $4a0c
0049A0  ; data: 0x73, 0x20
0049A2  blt.b  $4a0d
0049A4  moveq  #$74, d2
0049A6  bcs.b  $4a14
0049A8  moveq  #$75, d0
0049AA  bgt.b  $4a17
0049AC  moveq  #$20, d2
0049AE  moveq  #$6f, d3
0049B0  blt.b  $49d2
0049B2  ; data: 0x73, 0x79
0049B4  ; data: 0x73, 0x74
0049B6  bcs.b  $4a25
0049B8  move.l d0, d0
0049BA  movea.l $64(a5, d6.l), a0
0049BE  movea.l -(a4), a0
0049C0  bcs.b  $4a35
0049C2  bvc.b  $4a25
0049C4  bge.b  $4a28
0049C6  movea.l -(a6), a0
0049C8  bsr.b  $4a2f
0049CA  bge.b  $4a38
0049CC  moveq  #$20, d2
0049CE  bcs.b  $4a39
0049D0  bgt.b  $4a37
0049D2  blt.b  $49f4
0049D4  ; data: 0x73, 0x65
0049D6  bge.b  $4a3a
0049D8  ; data: 0x73, 0x74
0049DA  move.l -(a0), d6
0049DC  ; data: 0x73, 0x6f
0049DE  movea.l -(a5), a0
0049E0  moveq  #$77, d2
0049E2  bsr.b  $4a57
0049E4  move.l -(a0), d6
0049E6  bsr.b  $4a55
0049E8  movea.l $6e65(a3, invalid.w), a0
0049EE  bge.b  $4a5c
0049F0  ; data: 0x73, 0x74
0049F2  bcs.b  $4a62
0049F4  movea.l -(a1), a0
0049F6  ; data: 0x75, 0x66
0049F8  move.l -(a0), d7
0049FA  ori.b  #$63, -(a0)
0049FE  bvc.b  $4a65
004A00  bvs.b  $4a75
004A02  ; data: 0x73, 0x65
004A04  movea.l $7572(a6), a0
004A08  move.l -(a0), d6
004A0A  bcc.b  $4a6d
004A0C  ; data: 0x73, 0x73
004A0E  movea.l $6972(a3), a0
004A12  ; data: 0x73, 0x74
004A14  bcs.b  $4a84
004A16  movea.l -(a1), a0
004A18  blt.b  $4a3a
004A1A  blt.b  $4a8b
004A1C  bgt.b  $4a92
004A1E  bsr.b  $4a87
004A20  movea.l ([$6465, a7]), a0
004A26  moveq  #$20, d1
004A28  ; data: 0x73, 0x6f
004A2A  movea.l -(a7), a0
004A2C  bcs.b  $4a97
004A2E  bge.b  $4a50
004A30  bsr.b  $4aa7
004A32  bne.b  $4a54
004A34  ; data: 0x73, 0x63
004A36  bvc.b  $4aaa
004A38  ble.b  $4a9f
004A3A  bcc.b  $4aa1
004A3C  moveq  #$20, d1
004A3E  ; data: 0x77, 0x61
004A40  moveq  #$2e, d1
004A42  move.l d0, d0
004A44  movea.l $6368(a1), a0
004A48  movea.l ([$73746568, a6], $6520), a0
004A52  bcc.b  $4ab5
004A54  ; data: 0x73, 0x20
004A56  bgt.b  $4ac1
004A58  bls.b  $4ac2
004A5A  moveq  #$2e, d2
004A5C  movea.l -(a2), a0
004A5E  bvs.b  $4ace
004A60  movea.l $6368(a1), a0
004A64  movea.l ([$6b6c6963, a7], $6820), a0
004A6E  ; data: 0x73, 0x6f
004A70  movea.l $6165(a0), a0
004A74  ; data: 0x73, 0x73
004A76  bge.b  $4ae1
004A78  bls.b  $4ae2
004A7A  movea.l $64(a5, d6.l), a0
004A7E  movea.l $6569(a3, invalid.w), a0
004A84  ; data: 0x73, 0x73
004A86  bcs.b  $4aa8
004A88  ori.b  #$73, -(a0)
004A8C  movea.l -(a1), a0
004A8E  bcs.b  $4b02
004A90  beq.b  $4af7
004A92  moveq  #$74, d1
004A94  movea.l $6963(a5), a0
004A98  bvc.b  $4aba
004A9A  bcc.b  $4b05
004A9C  bcs.b  $4abe
004A9E  beq.b  $4b01
004AA0  bgt.b  $4b1c
004AA2  bcs.b  $4ac4
004AA4  moveq  #$65, d5
004AA6  bvs.b  $4b1c
004AA8  move.l -(a0), d6
004AAA  bgt.b  $4b15
004AAC  bls.b  $4b16
004AAE  moveq  #$20, d2
004AB0  bgt.b  $4b27
004AB2  moveq  #$20, d1
004AB4  ; data: 0x77, 0x65
004AB6  bvs.b  $4b24
004AB8  movea.l ([$206d, a3]), a0
004ABE  bvs.b  $4b32
004AC0  movea.l -(a7), a0
004AC2  bcs.b  $4b2a
004AC4  bsr.b  $4b2b
004AC6  bge.b  $4b34
004AC8  moveq  #$2c, d2
004ACA  movea.l ([$6465, a3]), a0
004AD0  moveq  #$6e, d1
004AD2  move.l d0, d0
004AD4  movea.l ([$6c20, a7]), a0
004ADA  ; data: 0x73, 0x69
004ADC  bcs.b  $4afe
004ADE  bgt.b  $4b49
004AE0  bls.b  $4b4a
004AE2  moveq  #$20, d2
004AE4  bcc.b  $4b4f
004AE6  bcs.b  $4b08
004AE8  bcs.b  $4b5c
004AEA  ; data: 0x73, 0x74
004AEC  bcs.b  $4b0e
004AEE  bvs.b  $4b63
004AF0  moveq  #$2c, d2
004AF2  movea.l -(a4), a0
004AF4  bvs.b  $4b5b
004AF6  movea.l $7572(a6), a0
004AFA  movea.l -(a1), a0
004AFC  ; data: 0x75, 0x66
004AFE  movea.l $726f(a3, invalid.w), a0
004B04  bcs.b  $4b6a
004B06  bcs.b  $4b7a
004B08  movea.l $65(a3, d7.w), a0
004B0C  bvc.b  $4b82
004B0E  movea.l $64(a5, d6.l), a0
004B12  movea.l $6368(a1), a0
004B16  movea.l -(a4), a0
004B18  bcs.b  $4b8d
004B1A  bvc.b  $4b7d
004B1C  bge.b  $4b80
004B1E  move.l d0, d0
004B20  movea.l -(a1), a0
004B22  blt.b  $4b44
004B24  ; data: 0x73, 0x65
004B26  bge.b  $4b8a
004B28  ; data: 0x73, 0x76
004B2A  bcs.b  $4b9e
004B2C  moveq  #$72, d2
004B2E  bsr.b  $4ba5
004B30  bcs.b  $4ba0
004B32  movea.l ([$6c696572, a6], $6520), a0
004B3C  move.l $2e20(a6), d7
004B40  ori.b  #$69, -(a0)
004B44  bgt.b  $4bab
004B46  movea.l ([$6865, a3], $20657266), a0
004B50  moveq  #$65, d1
004B52  ; data: 0x75, 0x74
004B54  movea.l $6963(a5), a0
004B58  bvc.b  $4b7a
004B5A  bsr.b  $4bc8
004B5C  bge.b  $4bc3
004B5E  moveq  #$64, d1
004B60  bvs.b  $4bd0
004B62  beq.b  $4bd7
004B64  movea.l -(a4), a0
004B66  bsr.b  $4bca
004B68  bcs.b  $4bd3
004B6A  move.l -(a0), d6
004B6C  ; data: 0x75, 0x6e
004B6E  bcc.b  $4b90
004B70  beq.b  $4bdb
004B72  bhi.b  $4be8
004B74  movea.l $6972(a5), a0
004B78  movea.l -(a2), a0
004B7A  bvs.b  $4bef
004B7C  bls.b  $4be6
004B7E  bcs.b  $4bee
004B80  movea.l $6f66(a0), a0
004B84  bne.b  $4bf4
004B86  ; data: 0x75, 0x6e
004B88  beq.b  $4bb8
004B8A  move.l d0, d0
004B8C  movea.l -(a1), a0
004B8E  bge.b  $4c03
004B90  movea.l ([$20696e20, a7], $706f), a0
004B9A  bge.b  $4c01
004B9C  bgt.b  $4bbe
004B9E  ; data: 0x77, 0x61
004BA0  moveq  #$65, d1
004BA2  bgt.b  $4bc4
004BA4  move.l $61(a0, d7.w), $672d(a6)
004BAA  moveq  #$72, d2
004BAC  bvs.b  $4c1e
004BAE  move.l -(a0), -(a6)
004BB0  bvc.b  $4c13
004BB2  moveq  #$20, d2
004BB4  bvs.b  $4c28
004BB6  beq.b  $4c1d
004BB8  bgt.b  $4c1e
004BBA  movea.l $656d(a2), a0
004BBE  bsr.b  $4c2e
004BC0  bcc.b  $4bee
004BC2  movea.l $6368(a1), a0
004BC6  movea.l -(a7), a0
004BC8  bge.b  $4c2b
004BCA  ; data: 0x75, 0x62
004BCC  bcs.b  $4bee
004BCE  ; data: 0x73, 0x6f
004BD0  beq.b  $4c33
004BD2  moveq  #$20, d1
004BD4  ori.b  #$73, -(a0)
004BD8  movea.l ([$206b6173, a7], $6961), a0
004BE2  movea.l $6465(a7), a0
004BE6  moveq  #$20, d1
004BE8  blt.b  $4c4f
004BEA  bvs.b  $4c5a
004BEC  bcs.b  $4c0e
004BEE  bhi.b  $4c51
004BF0  moveq  #$6b, d1
004BF2  bcs.b  $4c59
004BF4  moveq  #$65, d0
004BF6  moveq  #$69, d1
004BF8  bgt.b  $4c26
004BFA  movea.l -(a1), a0
004BFC  bge.b  $4c71
004BFE  movea.l $726f(a3, invalid.w), a0
004C04  bcs.b  $4c6a
004C06  bcs.b  $4c7a
004C08  movea.l ([$6820, a3], $65696e20), a0
004C12  bhi.b  $4c75
004C14  bvs.b  $4c82
004C16  bcs.b  $4c91
004C18  ; data: 0x73, 0x20
004C1A  move.l d0, d0
004C1C  movea.l -(a2), a0
004C1E  bcs.b  $4c93
004C20  moveq  #$65, d2
004C22  bge.b  $4c90
004C24  moveq  #$20, d2
004C26  bvc.b  $4c89
004C28  moveq  #$2c, d2
004C2A  movea.l -(a7), a0
004C2C  bcs.b  $4ca1
004C2E  bsr.b  $4c97
004C30  moveq  #$2c, d2
004C32  movea.l ([$20667565, a7], $72206569), a0
004C3E  bgt.b  $4c60
004C40  ; data: 0x77, 0x65
004C42  bvs.b  $4ca7
004C44  bvc.b  $4cb2
004C46  bvs.b  $4cb6
004C48  beq.b  $4c6a
004C4A  ; data: 0x73, 0x63
004C4C  bvc.b  $4cc0
004C4E  ble.b  $4cb5
004C50  bcc.b  $4cb7
004C52  moveq  #$20, d1
004C54  bcc.b  $4cc5
004C56  bls.b  $4cc0
004C58  movea.l ([$7265, a7]), a0
004C5E  move.l -(a0), d6
004C60  ; data: 0x77, 0x65
004C62  bvs.b  $4cd0
004C64  move.l d0, d0
004C66  movea.l -(a5), a0
004C68  moveq  #$20, d1
004C6A  bhi.b  $4ccd
004C6C  bvs.b  $4cda
004C6E  bcs.b  $4ce9
004C70  ; data: 0x73, 0x20
004C72  moveq  #$72, d2
004C74  bvs.b  $4ce4
004C76  bmi.b  $4cdd
004C78  move.l -(a0), d7
004C7A  bvs.b  $4cdf
004C7C  bvc.b  $4c9e
004C7E  blt.b  $4ce5
004C80  bvs.b  $4cf0
004C82  bcs.b  $4cb0
004C84  movea.l -(a5), a0
004C86  ; data: 0x73, 0x20
004C88  bvs.b  $4cfd
004C8A  moveq  #$20, d2
004C8C  beq.b  $4cef
004C8E  bgt.b  $4d0a
004C90  movea.l $6f65(a3, invalid.w), a0
004C96  bgt.b  $4cb8
004C98  ; data: 0x73, 0x63
004C9A  bvc.b  $4d08
004C9C  bcs.b  $4d01
004C9E  bvc.b  $4d14
004CA0  movea.l ([$206d, a6]), a0
004CA6  bvs.b  $4d1a
004CA8  move.l -(a0), d6
004CAA  bcc.b  $4d0d
004CAC  ; data: 0x73, 0x73
004CAE  move.l d0, d0
004CB0  movea.l $6368(a1), a0
004CB4  movea.l $6963(a5), a0
004CB8  bvc.b  $4cda
004CBA  bsr.b  $4d2a
004CBC  movea.l $6368(a3, invalid.w), a0
004CC2  bcs.b  $4d32
004CC4  movea.l $72(a3, d7.w), a0
004CC8  ; data: 0x75, 0x65
004CCA  bls.b  $4d34
004CCC  bcs.b  $4d3c
004CCE  movea.l -(a1), a0
004CD0  ; data: 0x75, 0x66
004CD2  beq.b  $4d39
004CD4  bvs.b  $4d42
004CD6  bcs.b  $4d04
004CD8  movea.l -(a1), a0
004CDA  bhi.b  $4d41
004CDC  moveq  #$20, d1
004CDE  bcc.b  $4d41
004CE0  ; data: 0x73, 0x20
004CE2  beq.b  $4d45
004CE4  bhi.b  $4d06
004CE6  blt.b  $4d51
004CE8  moveq  #$20, d1
004CEA  ; data: 0x77, 0x69
004CEC  bcs.b  $4d52
004CEE  bcs.b  $4d62
004CF0  movea.l -(a4), a0
004CF2  bsr.b  $4d67
004CF4  move.l d0, d0
004CF6  movea.l -(a7), a0
004CF8  bcs.b  $4d60
004CFA  ; data: 0x75, 0x65
004CFC  bvc.b  $4d6a
004CFE  movea.l -(a2), a0
004D00  bcs.b  $4d75
004D02  ; data: 0x73, 0x65
004D04  moveq  #$20, d1
004D06  ; data: 0x75, 0x6e
004D08  bcc.b  $4d2a
004D0A  bsr.b  $4d7a
004D0C  beq.b  $4d73
004D0E  ; data: 0x73, 0x65
004D10  bvc.b  $4d77
004D12  bgt.b  $4d79
004D14  moveq  #$20, d1
004D16  moveq  #$75, d5
004D18  movea.l ([$6e2e, a3]), a0
004D1E  movea.l $6368(a1), a0
004D22  movea.l -(a4), a0
004D24  bcs.b  $4d94
004D26  bmi.b  $4d8d
004D28  movea.l -(a1), a0
004D2A  bgt.b  $4d4c
004D2C  blt.b  $4d93
004D2E  bvs.b  $4d9e
004D30  movea.l $6273(a3, invalid.w), a0
004D36  moveq  #$65, d3
004D38  moveq  #$74, d1
004D3A  moveq  #$61, d1
004D3C  ; data: 0x75, 0x65
004D3E  bgt.b  $4d6e
004D40  move.l d0, d0
004D42  movea.l -(a1), a0
004D44  ; data: 0x75, 0x73
004D46  ; data: 0x73, 0x65
004D48  moveq  #$64, d1
004D4A  bcs.b  $4db9
004D4C  movea.l $616d(a3), a0
004D50  movea.l $6972(a5), a0
004D54  movea.l $6569(a5), a0
004D58  bgt.b  $4d7a
004D5A  bhi.b  $4dc1
004D5C  ; data: 0x73, 0x74
004D5E  bcs.b  $4dd2
004D60  movea.l -(a6), a0
004D62  moveq  #$65, d1
004D64  ; data: 0x75, 0x6e
004D66  bcc.b  $4d88
004D68  ; data: 0x73, 0x63
004D6A  bvc.b  $4dde
004D6C  ble.b  $4dd3
004D6E  bcc.b  $4dd5
004D70  moveq  #$20, d1
004D72  bsr.b  $4de2
004D74  movea.l -(a4), a0
004D76  bvs.b  $4ddd
004D78  ; data: 0x73, 0x65
004D7A  blt.b  $4d9c
004D7C  bsr.b  $4de0
004D7E  bcs.b  $4dee
004D80  bcc.b  $4da2
004D82  ; data: 0x73, 0x6f
004D84  movea.l ([$6c6f7265, a6], $6e20), a0
004D8E  ori.b  #$6f, -(a0)
004D92  moveq  #$2e, d1
004D94  movea.l $6963(a6), a0
004D98  bvc.b  $4e0e
004D9A  movea.l -(a7), a0
004D9C  bcs.b  $4e07
004D9E  ; data: 0x73, 0x74
004DA0  bvs.b  $4e05
004DA2  bvc.b  $4dc4
004DA4  ble.b  $4e0a
004DA6  bcs.b  $4e1a
004DA8  movea.l $6f65(a3), a0
004DAC  moveq  #$70, d1
004DAE  bcs.b  $4e22
004DB0  bge.b  $4e1b
004DB2  bls.b  $4e1c
004DB4  move.l -(a0), d6
004DB6  ; data: 0x73, 0x6f
004DB8  bgt.b  $4e1e
004DBA  bcs.b  $4e2e
004DBC  bgt.b  $4dde
004DBE  bsr.b  $4e2c
004DC0  ; data: 0x73, 0x20
004DC2  ble.b  $4e26
004DC4  movea.l $686e(a1), a0
004DC8  movea.l ([$6e65, a3]), a0
004DCE  movea.l -(a7), a0
004DD0  bsr.b  $4e40
004DD2  moveq  #$65, d5
004DD4  movea.l -(a1), a0
004DD6  ; data: 0x75, 0x72
004DD8  bsr.b  $4dfa
004DDA  ori.b  #$65, -(a0)
004DDE  moveq  #$6c, d1
004DE0  bsr.b  $4e55
004DE2  ; data: 0x73, 0x65
004DE4  bgt.b  $4e06
004DE6  bvc.b  $4e49
004DE8  bcs.b  $4e5e
004DEA  moveq  #$65, d2
004DEC  move.l -(a0), d6
004DEE  bcs.b  $4e62
004DF0  movea.l $207a(a3, invalid.w), a0
004DF6  bcs.b  $4e6a
004DF8  ; data: 0x73, 0x63
004DFA  bvc.b  $4e69
004DFC  bcs.b  $4e72
004DFE  moveq  #$65, d2
004E00  moveq  #$74, d1
004E02  movea.l -(a1), a0
004E04  ; data: 0x75, 0x73
004E06  move.l -(a0), d7
004E08  ; data: 0x75, 0x6e
004E0A  bcc.b  $4e2c
004E0C  blt.b  $4e73
004E0E  bvs.b  $4e7e
004E10  bcs.b  $4e32
004E12  beq.b  $4e75
004E14  bgt.b  $4e90
004E16  bcs.b  $4e38
004E18  bhi.b  $4e7f
004E1A  ; data: 0x77, 0x75
004E1C  bgt.b  $4e82
004E1E  bcs.b  $4e92
004E20  ; data: 0x75, 0x6e
004E22  beq.b  $4e44
004E24  ori.b  #$75, -(a0)
004E28  bcs.b  $4e9c
004E2A  movea.l $686e(a1), a0
004E2E  movea.l $7374(a1), a0
004E32  move.l -(a0), d6
004E34  ; data: 0x77, 0x69
004E36  bcs.b  $4e58
004E38  bsr.b  $4eaf
004E3A  bne.b  $4e5c
004E3C  bcs.b  $4ea7
004E3E  bgt.b  $4e60
004E40  bne.b  $4eab
004E42  bgt.b  $4eab
004E44  bcs.b  $4eb8
004E46  ; data: 0x73, 0x63
004E48  bvc.b  $4eb8
004E4A  bvs.b  $4ebc
004E4C  moveq  #$73, d0
004E4E  move.l -(a0), d6
004E50  moveq  #$65, d3
004E52  moveq  #$66, d1
004E54  bge.b  $4ec5
004E56  beq.b  $4ebd
004E58  bgt.b  $4e88
004E5A  movea.l $616a(a6), a0
004E5E  bsr.b  $4e8c
004E60  movea.l -(a4), a0
004E62  bvs.b  $4ec9
004E64  movea.l -(a2), a0
004E66  bcs.b  $4edf
004E68  ; data: 0x75, 0x6e
004E6A  bcc.b  $4ed1
004E6C  moveq  #$75, d1
004E6E  bgt.b  $4ed7
004E70  move.l d0, d0
004E72  movea.l $6174(a0), a0
004E76  movea.l ([$6820, a3], $73656964), a0
004E80  movea.l $6f6e(a5), a0
004E84  moveq  #$61, d2
004E86  beq.b  $4ea8
004E88  ; data: 0x77, 0x69
004E8A  bcs.b  $4ef0
004E8C  bcs.b  $4f00
004E8E  movea.l -(a1), a0
004E90  ; data: 0x75, 0x66
004E92  beq.b  $4ef9
004E94  bhi.b  $4ef7
004E96  ; data: 0x75, 0x74
004E98  move.l -(a0), d6
004E9A  bsr.b  $4efe
004E9C  bcs.b  $4f10
004E9E  movea.l -(a4), a0
004EA0  bsr.b  $4f15
004EA2  movea.l -(a7), a0
004EA4  bcs.b  $4f0c
004EA6  ; data: 0x75, 0x65
004EA8  bvc.b  $4f16
004EAA  movea.l $64(a5, d6.l), a0
004EAE  movea.l -(a4), a0
004EB0  bvs.b  $4f17
004EB2  movea.l -(a5), a0
004EB4  moveq  #$69, d1
004EB6  bgt.b  $4f26
004EB8  bcs.b  $4f2c
004EBA  ; data: 0x75, 0x6e
004EBC  beq.b  $4eea
004EBE  move.l d0, d0
004EC0  movea.l -(a4), a0
004EC2  bsr.b  $4f37
004EC4  ; data: 0x73, 0x20
004EC6  bcs.b  $4f3b
004EC8  movea.l -(a1), a0
004ECA  ; data: 0x75, 0x63
004ECC  bvc.b  $4eee
004ECE  ; data: 0x75, 0x6d
004ED0  beq.b  $4f37
004ED2  bmi.b  $4f39
004ED4  bvc.b  $4f48
004ED6  moveq  #$20, d2
004ED8  ; data: 0x73, 0x65
004EDA  bvs.b  $4f4a
004EDC  movea.l $616e(a3), a0
004EE0  bgt.b  $4f0e
004EE2  movea.l -(a2), a0
004EE4  bge.b  $4f4b
004EE6  bvs.b  $4f4a
004EE8  moveq  #$2e, d2
004EEA  move.l d0, d0
004EEC  move.l -(a0), d0
004EEE  ori.b  #$2e, -(a0)
004EF2  move.l -(a0), d7
004EF4  bsr.b  $4f59
004EF6  bvc.b  $4f24
004EF8  movea.l ([$7269, a5], $6765), a0
004F00  bgt.b  $4f75
004F02  move.l -(a0), d6
004F04  bcc.b  $4f6f
004F06  bcs.b  $4f28
004F08  moveq  #$75, d2
004F0A  ; data: 0x73, 0x73
004F0C  bvs.b  $4f3a
004F0E  movea.l $6368(a1), a0
004F12  movea.l $6569(a5), a0
004F16  bgt.b  $4f7d
004F18  movea.l -(a4), a0
004F1A  bvs.b  $4f81
004F1C  movea.l -(a2), a0
004F1E  bsr.b  $4f92
004F20  bmi.b  $4f87
004F22  bcs.b  $4f94
004F24  bcs.b  $4f98
004F26  bvs.b  $4f96
004F28  move.l -(a0), d6
004F2A  bcc.b  $4f95
004F2C  bcs.b  $4f4e
004F2E  bmi.b  $4f9f
004F30  bcs.b  $4fa0
004F32  bgt.b  $4fa8
004F34  bcs.b  $4f56
004F36  bcs.b  $4fab
004F38  move.l -(a0), d0
004F3A  ori.b  #$20, -(a0)
004F3E  move.l -(a0), d0
004F40  beq.b  $4fa7
004F42  ; data: 0x77, 0x65
004F44  ; data: 0x73, 0x65
004F46  bgt.b  $4f68
004F48  ; data: 0x73, 0x65
004F4A  bvs.b  $4fba
004F4C  move.l $2e2e(a6), d0
004F50  move.l d0, d0
004F52  move.l -(a0), d0
004F54  ori.b  #$6f, -(a0)
004F58  bvs.b  $4fc8
004F5A  move.l -(a0), -(a0)
004F5C  bvc.b  $4fc3
004F5E  ; data: 0x75, 0x74
004F60  bcs.b  $4f82
004F62  bvs.b  $4fd7
004F64  moveq  #$20, d2
004F66  bcc.b  $4fcd
004F68  moveq  #$20, d1
004F6A  move.w $2e31302c.l, d1
004F70  movea.l -(a1), a0
004F72  bge.b  $4fe7
004F74  ble.b  $4f96
004F76  bgt.b  $4fe7
004F78  bls.b  $4fe2
004F7A  movea.l -(a7), a0
004F7C  bcs.b  $4fec
004F7E  bsr.b  $4ff5
004F80  move.l $74(a7, d2.w), d0
004F84  bsr.b  $4fed
004F86  bcs.b  $4fa8
004F88  ; data: 0x75, 0x6e
004F8A  bcc.b  $4fac
004F8C  beq.b  $4ff3
004F8E  moveq  #$61, d2
004F90  bgt.b  $4fb2
004F92  bvc.b  $4ff5
004F94  moveq  #$20, d2
004F96  ; data: 0x73, 0x69
004F98  bls.b  $5002
004F9A  movea.l ([$6420, a3]), a0
004FA0  ori.b  #$65, -(a0)
004FA4  ; data: 0x73, 0x74
004FA6  bcs.b  $501a
004FA8  bgt.b  $4fca
004FAA  bgt.b  $5015
004FAC  moveq  #$20, d4
004FAE  move.l $2e20(a6), d7
004FB2  beq.b  $5015
004FB4  moveq  #$20, d1
004FB6  bgt.b  $5021
004FB8  moveq  #$20, d4
004FBA  move.l $2e20(a6), d7
004FBE  moveq  #$61, d1
004FC0  movea.l $6174(a0), a0
004FC4  movea.l $6174(a6), a0
004FC8  ; data: 0x75, 0x65
004FCA  moveq  #$6c, d1
004FCC  bvs.b  $5031
004FCE  bvc.b  $4ff0
004FD0  bvs.b  $503f
004FD2  blt.b  $5039
004FD4  moveq  #$20, d1
004FD6  bgt.b  $5047
004FD8  bls.b  $5042
004FDA  movea.l $6963(a6), a0
004FDE  bvc.b  $5054
004FE0  movea.l -(a1), a0
004FE2  bgt.b  $504b
004FE4  bcs.b  $5058
004FE6  ; data: 0x75, 0x66
004FE8  bcs.b  $5058
004FEA  move.l -(a0), d7
004FEC  ori.b  #$63, -(a0)
004FF0  bvc.b  $5012
004FF2  bhi.b  $505d
004FF4  bgt.b  $5016
004FF6  bsr.b  $5064
004FF8  bge.b  $505f
004FFA  moveq  #$64, d1
004FFC  bvs.b  $506c
004FFE  beq.b  $5073
005000  movea.l $6f63(a6), a0
005004  bvc.b  $5026
005006  bmi.b  $507a
005008  bsr.b  $506f
00500A  bgt.b  $5077
00500C  bcs.b  $5080
00500E  movea.l -(a7), a0
005010  bcs.b  $5089
005012  ble.b  $5086
005014  bcc.b  $507b
005016  bgt.b  $5044
005018  movea.l $6368(a1), a0
00501C  movea.l $7573(a0), a0
005020  moveq  #$65, d2
005022  movea.l $6574(a2), a0
005026  moveq  #$74, d5
005028  movea.l $6963(a6), a0
00502C  bvc.b  $50a2
00502E  movea.l $6564(a2), a0
005032  bcs.b  $5054
005034  move.w (a0, d2.w), -(a0)
005038  movea.l ([$6465, a3]), a0
00503E  moveq  #$6e, d1
005040  movea.l $6564(a2), a0
005044  bcs.b  $5066
005046  move.w -(a0), -(a2)
005048  ; data: 0x73, 0x65
00504A  bmi.b  $50c1
00504C  bgt.b  $50b2
00504E  bcs.b  $50be
005050  movea.l -(a1), a0
005052  bhi.b  $5082
005054  movea.l -(a5), a0
005056  ; data: 0x73, 0x20
005058  bvs.b  $50cd
00505A  moveq  #$20, d2
00505C  ; data: 0x73, 0x63
00505E  bvc.b  $50d2
005060  bcs.b  $50c5
005062  bmi.b  $50d0
005064  bvs.b  $50c9
005066  bvc.b  $5094
005068  movea.l ([$616c6c65, a6], $6d2c), a0
005072  movea.l ([$6c20, a7]), a0
005078  bvs.b  $50dd
00507A  bvc.b  $509c
00507C  bvc.b  $50e3
00507E  ; data: 0x75, 0x74
005080  bcs.b  $50a2
005082  ori.b  #$72, -(a0)
005086  bhi.b  $50ed
005088  bvs.b  $50fe
00508A  bcs.b  $50fa
00508C  movea.l $7573(a5), a0
005090  ; data: 0x73, 0x20
005092  move.l $616c(a0), $6c6f(a6)
005098  movea.l $6f(a0, d7.w), a0
00509C  bge.b  $510d
00509E  blt.b  $5115
0050A0  bls.b  $510d
0050A2  bcs.b  $5110
0050A4  move.l $2020(a6), -(a6)
0050A8  ori.b  #$65, -(a0)
0050AC  ; data: 0x79, 0x20
0050AE  bvs.b  $5113
0050B0  bvc.b  $50d2
0050B2  beq.b  $5120
0050B4  bsr.b  $512b
0050B6  bhi.b  $511d
0050B8  movea.l -(a5), a0
0050BA  ; data: 0x73, 0x20
0050BC  bgt.b  $5127
0050BE  bls.b  $5128
0050C0  moveq  #$20, d2
0050C2  moveq  #$61, d1
0050C4  movea.l $6174(a0), a0
0050C8  movea.l -(a1), a0
0050CA  bgt.b  $5133
0050CC  bcs.b  $5140
0050CE  ; data: 0x75, 0x66
0050D0  bcs.b  $5140
0050D2  move.l -(a0), d7
0050D4  beq.b  $513b
0050D6  moveq  #$61, d1
0050D8  bcc.b  $513f
0050DA  movea.l -(a5), a0
0050DC  bhi.b  $5143
0050DE  bgt.b  $510e
0050E0  movea.l $6368(a1), a0
0050E4  movea.l -(a6), a0
0050E6  bsr.b  $515b
0050E8  ; data: 0x73, 0x65
0050EA  movea.l -(a5), a0
0050EC  ; data: 0x73, 0x20
0050EE  bgt.b  $5159
0050F0  bls.b  $515a
0050F2  moveq  #$2e, d2
0050F4  move.l d0, d0
0050F6  movea.l $64(a5, d6.l), a0
0050FA  movea.l -(a5), a0
0050FC  moveq  #$20, d1
0050FE  bvc.b  $5161
005100  moveq  #$20, d2
005102  bgt.b  $516d
005104  bls.b  $516e
005106  moveq  #$73, d2
005108  movea.l -(a7), a0
00510A  bcs.b  $517f
00510C  bls.b  $5176
00510E  bsr.b  $5176
005110  bne.b  $5186
005112  move.l $2e2e(a6), d0
005116  movea.l $6120(a0), a0
00511A  bvc.b  $517d
00511C  move.l $2e2e(a6), d0
005120  movea.l -(a5), a0
005122  moveq  #$20, d1
005124  blt.b  $518b
005126  bvs.b  $5196
005128  moveq  #$65, d2
00512A  movea.l -(a5), a0
00512C  moveq  #$20, d1
00512E  ; data: 0x77, 0x69
005130  moveq  #$64, d1
005132  movea.l -(a4), a0
005134  bvs.b  $519b
005136  movea.l -(a7), a0
005138  bsr.b  $51a8
00513A  moveq  #$65, d5
00513C  movea.l $6163(a6), a0
005140  bvc.b  $51b6
005142  move.l d0, d0
005144  movea.l $616c(a5), a0
005148  bcs.b  $51b8
00514A  move.l -(a0), d6
00514C  bvs.b  $51b1
00514E  bvc.b  $5170
005150  bhi.b  $51bb
005152  bgt.b  $5174
005154  bpl.b  $51bb
005156  moveq  #$7a, d2
005158  moveq  #$20, d2
00515A  ; data: 0x73, 0x63
00515C  bvc.b  $51cd
00515E  bgt.b  $5180
005160  beq.b  $51c7
005162  ; data: 0x73, 0x70
005164  bsr.b  $51d4
005166  bgt.b  $51dc
005168  move.l -(a0), d7
00516A  bcs.b  $51de
00516C  movea.l $6174(a0), a0
005170  movea.l -(a1), a0
005172  ; data: 0x75, 0x63
005174  bvc.b  $5196
005176  moveq  #$65, d3
005178  moveq  #$73, d1
00517A  moveq  #$72, d0
00517C  ble.b  $51e1
00517E  bvc.b  $51e5
005180  bgt.b  $51a2
005182  bcc.b  $51ed
005184  bcs.b  $51a6
005186  beq.b  $51fa
005188  bsr.b  $51f0
00518A  bvs.b  $51f7
00518C  bcs.b  $51fc
00518E  move.l d0, d0
005190  movea.l -(a1), a0
005192  blt.b  $51b4
005194  ; data: 0x73, 0x61
005196  blt.b  $520b
005198  moveq  #$61, d2
00519A  beq.b  $51bc
00519C  moveq  #$65, d0
00519E  moveq  #$20, d1
0051A0  blt.b  $5211
0051A2  bcc.b  $5209
0051A4  blt.b  $51c6
0051A6  moveq  #$75, d5
0051A8  movea.l $6963(a3, invalid.w), a0
0051AE  bmi.b  $5215
0051B0  bgt.b  $51e0
0051B2  movea.l -(a1), a0
0051B4  bhi.b  $521b
0051B6  moveq  #$20, d1
0051B8  bmi.b  $521f
0051BA  bgt.b  $522a
0051BC  bcs.b  $51de
0051BE  bvs.b  $5223
0051C0  bvc.b  $51e2
0051C2  bcc.b  $5225
0051C4  ; data: 0x73, 0x20
0051C6  bgt.b  $5231
0051C8  bls.b  $5232
0051CA  moveq  #$20, d2
0051CC  bvs.b  $5240
0051CE  beq.b  $5235
0051D0  bgt.b  $5236
0051D2  ; data: 0x77, 0x6f
0051D4  bvc.b  $523b
0051D6  moveq  #$20, d1
0051D8  move.l $2e20(a6), d7
0051DC  ori.b  #$73, -(a0)
0051E0  movea.l $7374(a1), a0
0051E4  movea.l $6d6d(a1), a0
0051E8  bcs.b  $525c
0051EA  movea.l -(a4), a0
0051EC  bsr.b  $5261
0051EE  movea.l -(a7), a0
0051F0  bge.b  $5257
0051F2  bvs.b  $5257
0051F4  bvc.b  $525b
0051F6  move.l -(a0), d6
0051F8  bgt.b  $526f
0051FA  moveq  #$20, d1
0051FC  blt.b  $5267
0051FE  moveq  #$20, d2
005200  bcc.b  $5267
005202  blt.b  $5224
005204  ; data: 0x75, 0x6e
005206  moveq  #$65, d2
005208  moveq  #$73, d1
00520A  bls.b  $5274
00520C  bvs.b  $5273
00520E  bcc.b  $523c
005210  movea.l -(a4), a0
005212  bsr.b  $5287
005214  ; data: 0x73, 0x20
005216  bcc.b  $5281
005218  bcs.b  $528d
00521A  blt.b  $527d
00521C  bge.b  $523e
00521E  bcs.b  $528e
005220  bcc.b  $5289
005222  ; data: 0x75, 0x65
005224  bge.b  $529a
005226  bvs.b  $528f
005228  move.l d0, d0
00522A  movea.l -(a4), a0
00522C  bcs.b  $52a0
00522E  movea.l $6574(a4), a0
005232  moveq  #$74, d5
005234  bcs.b  $5256
005236  moveq  #$65, d2
005238  moveq  #$6d, d1
00523A  bvs.b  $52aa
00523C  movea.l $7374(a1), a0
005240  move.l -(a0), d7
005242  ; data: 0x75, 0x6e
005244  bcc.b  $5266
005246  ; data: 0x77, 0x65
005248  bgt.b  $52b8
00524A  movea.l -(a5), a0
00524C  moveq  #$20, d1
00524E  bcs.b  $52c3
005250  movea.l $6963(a6), a0
005254  bvc.b  $52ca
005256  movea.l $6166(a3, invalid.w), a0
00525C  bne.b  $52d2
00525E  move.l $2e2e(a6), d0
005262  movea.l ([$64652069, a7], $6368), a0
00526C  movea.l $686e(a1), a0
005270  move.l d0, d0
005272  movea.l ([$736f656e, a0], $6c69), a0
00527C  bls.b  $52e6
00527E  move.l -(a0), d6
005280  blt.b  $52eb
005282  moveq  #$20, d2
005284  bcs.b  $52ef
005286  beq.b  $52ed
005288  bgt.b  $52ef
00528A  bgt.b  $52ac
00528C  bvc.b  $52ef
00528E  bcs.b  $52fe
005290  bcc.b  $52f7
005292  bgt.b  $52b4
005294  ; data: 0x75, 0x6d
005296  bhi.b  $530a
005298  bvs.b  $5308
00529A  beq.b  $5301
00529C  bgt.b  $52be
00529E  move.l $2e20(a6), d7
0052A2  ; data: 0x77, 0x69
0052A4  bcs.b  $52c6
0052A6  bsr.b  $5315
0052A8  movea.l $6566(a4, invalid.w), a0
0052AE  ble.b  $531e
0052B0  movea.l -(a7), a0
0052B2  bcs.b  $5327
0052B4  bsr.b  $531d
0052B6  moveq  #$2e, d2
0052B8  move.l d0, d0
0052BA  movea.l -(a7), a0
0052BC  bsr.b  $532c
0052BE  moveq  #$20, d5
0052C0  bvs.b  $532f
0052C2  movea.l -(a5), a0
0052C4  moveq  #$6e, d1
0052C6  ; data: 0x73, 0x74
0052C8  move.l -(a0), d6
0052CA  moveq  #$6f, d3
0052CC  bgt.b  $52ee
0052CE  bvs.b  $5338
0052D0  blt.b  $52f2
0052D2  bvc.b  $5335
0052D4  bcs.b  $5344
0052D6  beq.b  $534c
0052D8  movea.l -(a1), a0
0052DA  bhi.b  $5308
0052DC  movea.l $6220(a7), a0
0052E0  ; data: 0x77, 0x69
0052E2  moveq  #$20, d1
0052E4  bcc.b  $534f
0052E6  bcs.b  $5308
0052E8  bcc.b  $534f
0052EA  blt.b  $535b
0052EC  movea.l $6561(a2, invalid.w), a0
0052F2  ; data: 0x73, 0x65
0052F4  bgt.b  $5316
0052F6  ble.b  $535c
0052F8  bcs.b  $536c
0052FA  movea.l $6963(a6), a0
0052FE  bvc.b  $5374
005300  movea.l $64(a5, d6.l), a0
005304  move.l d0, d0
005306  movea.l -(a4), a0
005308  bsr.b  $537d
00530A  movea.l $7374(a1), a0
00530E  movea.l ([$6572, a5], $6861), a0
005316  ; data: 0x75, 0x70
005318  moveq  #$20, d2
00531A  bgt.b  $5385
00531C  bls.b  $5386
00531E  moveq  #$20, d2
005320  bge.b  $5397
005322  ; data: 0x73, 0x74
005324  bvs.b  $538d
005326  move.l -(a0), d7
005328  ori.b  #$0, -(a0)
00532C  movea.l -(a4), a0
00532E  bcs.b  $53a2
005330  move.l $2e(a3, d3.w), d0
005334  move.w $69(a0, d2.w), -(a0)
005338  ; data: 0x73, 0x74
00533A  movea.l -(a5), a0
00533C  bvs.b  $53ac
00533E  movea.l $7565(a3), a0
005342  moveq  #$7a, d1
005344  bcs.b  $53b8
005346  movea.l ([$2c20, a4]), a0
00534C  bcc.b  $53b3
00534E  bgt.b  $53be
005350  movea.l $3620(a5, d6.l * 4), a0
005356  ; data: 0x75, 0x68
005358  moveq  #$20, d1
00535A  bcs.b  $53ce
00535C  ; data: 0x73, 0x74
00535E  movea.l $c880(pc), a0
005362  bvc.b  $53c5
005364  ; data: 0x75, 0x73
005366  bcs.b  $5388
005368  beq.b  $53cf
00536A  ; data: 0x77, 0x65
00536C  ; data: 0x73, 0x65
00536E  bgt.b  $539c
005370  movea.l -(a2), a0
005372  bvs.b  $53e7
005374  move.l d0, d0
005376  move.l $67(a1, d2.w), d0
00537A  bcs.b  $53ef
00537C  bls.b  $53e6
00537E  bge.b  $53e1
005380  bne.b  $53e7
005382  bgt.b  $53a4
005384  ; data: 0x75, 0x6e
005386  bcc.b  $53a8
005388  ; data: 0x75, 0x6d
00538A  move.l $6b(a6, d2.w), d0
00538E  ble.b  $53fd
005390  blt.b  $5406
005392  movea.l $726f(a3, invalid.w), a0
005398  bcs.b  $53fe
00539A  bcs.b  $540e
00539C  movea.l $6963(a5), a0
0053A0  bvc.b  $53c2
0053A2  bsr.b  $5406
0053A4  bvc.b  $5415
0053A6  bge.b  $540d
0053A8  bgt.b  $53d8
0053AA  movea.l -(a4), a0
0053AC  bsr.b  $53ce
0053AE  bmi.b  $5422
0053B0  bvs.b  $5417
0053B2  beq.b  $5428
0053B4  movea.l $616e(a5), a0
0053B8  movea.l ([$2064, a6]), a0
0053BE  bcs.b  $542d
0053C0  move.l d0, d0
0053C2  movea.l ([$6865, a7], $6e656e64), a0
0053CC  bcs.b  $53ee
0053CE  beq.b  $5431
0053D0  moveq  #$20, d1
0053D2  bgt.b  $543d
0053D4  moveq  #$20, d4
0053D6  blt.b  $5441
0053D8  moveq  #$2e, d2
0053DA  movea.l -(a1), a0
0053DC  bhi.b  $5443
0053DE  moveq  #$20, d1
0053E0  bcs.b  $5455
0053E2  movea.l -(a7), a0
0053E4  bvs.b  $5448
0053E6  moveq  #$20, d2
0053E8  bmi.b  $5459
0053EA  bvc.b  $5458
0053EC  bcs.b  $540e
0053EE  ; data: 0x75, 0x6e
0053F0  bcc.b  $5412
0053F2  bmi.b  $5463
0053F4  bvc.b  $5462
0053F6  bcs.b  $5418
0053F8  bvs.b  $546d
0053FA  moveq  #$20, d2
0053FC  bvs.b  $546b
0053FE  blt.b  $5465
005400  moveq  #$20, d1
005402  beq.b  $5479
005404  moveq  #$2e, d2
005406  move.l d0, d0
005408  movea.l -(a4), a0
00540A  bcs.b  $547e
00540C  movea.l ([$2068, a4]), a0
005412  bsr.b  $5488
005414  movea.l -(a1), a0
005416  bhi.b  $547d
005418  moveq  #$20, d1
00541A  moveq  #$75, d5
00541C  movea.l $6569(a5), a0
005420  bgt.b  $5487
005422  blt.b  $5444
005424  bcs.b  $5498
005426  ; data: 0x73, 0x74
005428  bsr.b  $549f
00542A  bgt.b  $5491
00542C  bgt.b  $544e
00542E  bcs.b  $54a2
005430  bne.b  $54a4
005432  bcs.b  $54a9
005434  bge.b  $549f
005436  bls.b  $54a0
005438  movea.l -(a1), a0
00543A  bgt.b  $54a3
00543C  bcs.b  $54a4
00543E  bsr.b  $54ae
005440  beq.b  $54a7
005442  bgt.b  $5472
005444  movea.l $6861(a2, d6.w), a0
00544A  moveq  #$20, d2
00544C  bsr.b  $54bc
00544E  move.l -(a0), -(a6)
005450  ori.b  #$65, -(a0)
005454  moveq  #$75, d1
005456  bne.b  $54bd
005458  bgt.b  $547a
00545A  ; data: 0x75, 0x6e
00545C  bcc.b  $547e
00545E  beq.b  $54c5
005460  ; data: 0x73, 0x61
005462  beq.b  $54d8
005464  move.l -(a0), d6
005466  bcc.b  $54c9
005468  ; data: 0x73, 0x73
00546A  movea.l -(a5), a0
00546C  moveq  #$20, d1
00546E  bne.b  $54d1
005470  ; data: 0x73, 0x74
005472  movea.l -(a1), a0
005474  bge.b  $54e2
005476  bcs.b  $5498
005478  beq.b  $54ec
00547A  bsr.b  $54e2
00547C  bvs.b  $54e9
00547E  bcs.b  $54ee
005480  movea.l -(a6), a0
005482  bcs.b  $54f6
005484  moveq  #$69, d2
005486  beq.b  $54a8
005488  bvc.b  $54eb
00548A  moveq  #$20, d2
00548C  ; data: 0x75, 0x6e
00548E  bcc.b  $54b0
005490  bcc.b  $54f3
005492  ; data: 0x73, 0x73
005494  movea.l -(a5), a0
005496  moveq  #$20, d1
005498  ori.b  #$77, -(a0)
00549C  bvs.b  $5511
00549E  bls.b  $5508
0054A0  bcs.b  $5510
0054A2  move.l $75(a3, d2.w), d0
0054A6  bgt.b  $550c
0054A8  move.l $75(a4, d2.w), d0
0054AC  bvc.b  $5520
0054AE  movea.l ([$206d, a3]), a0
0054B4  bvs.b  $552a
0054B6  movea.l $6f64(a5), a0
0054BA  bcs.b  $5529
0054BC  movea.l $c9de(pc), a0
0054C0  bls.b  $552a
0054C2  bsr.b  $5533
0054C4  ; data: 0x73, 0x20
0054C6  ; data: 0x73, 0x63
0054C8  bvc.b  $5533
0054CA  bls.b  $5537
0054CC  bcs.b  $553c
0054CE  movea.l $6c2e(a7, invalid.w), a0
0054D4  movea.l ([$65697420, a3]), a0
0054DC  bvs.b  $5541
0054DE  bvc.b  $5500
0054E0  ori.b  #$73, -(a0)
0054E4  movea.l $6974(a5), a0
0054E8  beq.b  $554f
0054EA  bmi.b  $555e
0054EC  bvs.b  $5553
0054EE  beq.b  $5564
0054F0  movea.l $6162(a0), a0
0054F4  bcs.b  $5522
0054F6  movea.l -(a6), a0
0054F8  bcs.b  $5562
0054FA  bge.b  $5561
0054FC  bgt.b  $551e
0054FE  bgt.b  $5575
005500  moveq  #$20, d1
005502  bgt.b  $5573
005504  bls.b  $556e
005506  movea.l ([$7220, a0]), a0
00550C  ; data: 0x73, 0x74
00550E  bcs.b  $5579
005510  bgt.b  $5577
005512  movea.l -(a6), a0
005514  ; data: 0x75, 0x65
005516  moveq  #$20, d1
005518  bcc.b  $557f
00551A  bgt.b  $553c
00551C  moveq  #$75, d2
00551E  bgt.b  $5585
005520  bge.b  $5542
005522  ; data: 0x75, 0x6e
005524  bcc.b  $5546
005526  ori.b  #$69, -(a0)
00552A  bcs.b  $554c
00552C  move.w $6661(a5), d4
005530  moveq  #$62, d1
005532  bcs.b  $55a2
005534  movea.l -(a7), a0
005536  moveq  #$61, d1
005538  bne.b  $55a3
00553A  bmi.b  $555c
00553C  bne.b  $55b3
00553E  bcs.b  $55b2
005540  movea.l -(a4), a0
005542  bcs.b  $55b2
005544  movea.l $c4b5(pc), a0
005548  blt.b  $55af
00554A  moveq  #$2e, d1
00554C  movea.l -(a4), a0
00554E  bvs.b  $55b5
005550  movea.l $6574(a4), a0
005554  moveq  #$74, d5
005556  bcs.b  $5578
005558  blt.b  $55cf
00555A  ; data: 0x73, 0x69
00555C  bls.b  $557e
00555E  moveq  #$6f, d3
005560  bgt.b  $5582
005562  blt.b  $55d3
005564  bhi.b  $55df
005566  movea.l $7374(a1), a0
00556A  movea.l -(a1), a0
00556C  ; data: 0x75, 0x63
00556E  bvc.b  $5590
005570  ori.b  #$63, -(a0)
005574  bvc.b  $55e5
005576  bgt.b  $5598
005578  bsr.b  $55e8
00557A  beq.b  $55e1
00557C  bmi.b  $55ed
00557E  blt.b  $55ed
005580  bcs.b  $55f0
005582  move.l -(a0), d6
005584  moveq  #$77, d5
005586  bsr.b  $55fa
005588  movea.l -(a6), a0
00558A  bvs.b  $55fa
00558C  bcc.b  $55f3
00558E  movea.l $6368(a1), a0
005592  movea.l ([$206e, a3]), a0
005598  ; data: 0x75, 0x72
00559A  movea.l $6974(a5), a0
00559E  moveq  #$65, d2
0055A0  bge.b  $55c2
0055A2  bhi.b  $560d
0055A4  ; data: 0x73, 0x20
0055A6  beq.b  $561d
0055A8  moveq  #$20, d2
0055AA  bsr.b  $560e
0055AC  bcs.b  $5620
0055AE  movea.l $6368(a1), a0
0055B2  movea.l $6162(a0), a0
0055B6  bcs.b  $55d8
0055B8  ori.b  #$69, -(a0)
0055BC  bcs.b  $55de
0055BE  bcs.b  $5632
0055C0  ; data: 0x73, 0x74
0055C2  movea.l $7572(a6), a0
0055C6  movea.l ([$2074656c, a0], $6566), a0
0055D0  ble.b  $5640
0055D2  movea.l -(a7), a0
0055D4  bcs.b  $563e
0055D6  ble.b  $563d
0055D8  moveq  #$74, d1
0055DA  move.l -(a0), d7
0055DC  bsr.b  $564b
0055DE  movea.l $6569(a5), a0
0055E2  ; data: 0x73, 0x74
0055E4  bcs.b  $5654
0055E6  movea.l -(a7), a0
0055E8  bcs.b  $5650
0055EA  moveq  #$65, d1
0055EC  ; data: 0x75, 0x74
0055EE  movea.l $6174(a0), a0
0055F2  movea.l $6963(a5), a0
0055F6  bvc.b  $5618
0055F8  bsr.b  $565c
0055FA  bcs.b  $566e
0055FC  movea.l -(a4), a0
0055FE  bcs.b  $5672
005600  move.l d0, d0
005602  movea.l -(a1), a0
005604  bgt.b  $5678
005606  ; data: 0x75, 0x66
005608  movea.l ([$2064, a6]), a0
00560E  bvs.b  $5674
005610  bcc.b  $567e
005612  bcs.b  $5642
005614  movea.l -(a5), a0
005616  moveq  #$20, d1
005618  bne.b  $5683
00561A  bgt.b  $5680
00561C  bcs.b  $5692
00561E  movea.l -(a4), a0
005620  bvs.b  $5687
005622  movea.l -(a4), a0
005624  bcs.b  $5693
005626  ble.b  $5648
005628  bcs.b  $5693
00562A  bgt.b  $5692
00562C  bsr.b  $5691
00562E  bvc.b  $5650
005630  beq.b  $5697
005632  bvs.b  $56a0
005634  movea.l $64(a5, d6.l), a0
005638  movea.l -(a5), a0
00563A  moveq  #$20, d1
00563C  bcs.b  $56b0
00563E  moveq  #$61, d5
005640  bcs.b  $56aa
005642  bge.b  $56b8
005644  bcs.b  $5672
005646  movea.l -(a4), a0
005648  bsr.b  $56bd
00564A  ; data: 0x73, 0x20
00564C  ori.b  #$72, -(a0)
005650  movea.l -(a5), a0
005652  bvs.b  $56c2
005654  bcs.b  $56c4
005656  movea.l $bfbd(pc), a0
00565A  blt.b  $56c8
00565C  bvs.b  $56c1
00565E  bvc.b  $5680
005660  beq.b  $56d7
005662  moveq  #$65, d2
005664  bgt.b  $5686
005666  bne.b  $56da
005668  bcs.b  $56df
00566A  bgt.b  $56d0
00566C  movea.l -(a2), a0
00566E  bcs.b  $56d9
005670  movea.l $7267(a1), a0
005674  bcs.b  $56e4
005676  bcc.b  $5698
005678  bcs.b  $56e3
00567A  bgt.b  $56e1
00567C  blt.b  $569e
00567E  bsr.b  $56ed
005680  bvs.b  $56e9
005682  bsr.b  $56b1
005684  blt.b  $56e7
005686  beq.b  $56e9
005688  moveq  #$69, d5
00568A  bgt.b  $56ac
00568C  bvc.b  $56ef
00568E  moveq  #$2c, d2
005690  movea.l -(a4), a0
005692  bcs.b  $5706
005694  move.l d0, d0
005696  movea.l -(a6), a0
005698  ; data: 0x75, 0x65
00569A  moveq  #$20, d1
00569C  bcc.b  $5707
00569E  bcs.b  $56c0
0056A0  bcc.b  $5707
0056A2  blt.b  $5713
0056A4  movea.l -(a5), a0
0056A6  bls.b  $5713
0056A8  bcs.b  $56ca
0056AA  ; data: 0x73, 0x63
0056AC  bvc.b  $5720
0056AE  bcs.b  $5719
0056B0  bhi.b  $5726
0056B2  movea.l $64(a5, d6.l), a0
0056B6  movea.l -(a5), a0
0056B8  moveq  #$20, d1
0056BA  bcs.b  $5725
0056BC  bgt.b  $56de
0056BE  bhi.b  $5725
0056C0  moveq  #$69, d1
0056C2  bls.b  $572c
0056C4  moveq  #$20, d2
0056C6  ; data: 0x75, 0x65
0056C8  bhi.b  $572f
0056CA  moveq  #$20, d1
0056CC  bcc.b  $5737
0056CE  bcs.b  $56f0
0056D0  bsr.b  $5744
0056D2  moveq  #$65, d2
0056D4  move.l -(a4), $656d(a6)
0056D8  ble.b  $56fa
0056DA  ; data: 0x75, 0x65
0056DC  bhi.b  $5743
0056DE  moveq  #$20, d1
0056E0  ori.b  #$69, -(a0)
0056E4  bgt.b  $574b
0056E6  movea.l -(a7), a0
0056E8  bsr.b  $5758
0056EA  moveq  #$65, d5
0056EC  movea.l ([$7465, a3]), a0
0056F2  move.l -(a0), d6
0056F4  bgt.b  $5757
0056F6  moveq  #$75, d2
0056F8  bcs.b  $576c
0056FA  bge.b  $5765
0056FC  bls.b  $5766
0056FE  movea.l $6974(a5), a0
005702  movea.l -(a6), a0
005704  ble.b  $577a
005706  ble.b  $577b
005708  move.l -(a0), d6
00570A  ble.b  $577e
00570C  beq.b  $576f
00570E  bgt.b  $5779
005710  ; data: 0x73, 0x69
005712  bcs.b  $5786
005714  moveq  #$20, d2
005716  bvc.b  $5779
005718  moveq  #$2e, d2
00571A  movea.l $6368(a1), a0
00571E  movea.l $6c74(a3, invalid.w), a0
005724  bcs.b  $5746
005726  bvs.b  $5790
005728  blt.b  $574a
00572A  ori.b  #$61, -(a0)
00572E  moveq  #$75, d5
005730  movea.l -(a5), a0
005732  bvs.b  $57a2
005734  movea.l ([$7220, a0]), a0
00573A  bvc.b  $57a5
00573C  bgt.b  $57b2
00573E  bcs.b  $57b2
005740  beq.b  $57b4
005742  ; data: 0x75, 0x65
005744  bgt.b  $57aa
005746  bcs.b  $5768
005748  ; data: 0x75, 0x65
00574A  bhi.b  $57b1
00574C  moveq  #$20, d1
00574E  bcc.b  $57b9
005750  bcs.b  $5772
005752  bcs.b  $57c2
005754  moveq  #$73, d2
005756  moveq  #$65, d2
005758  bvc.b  $57cf
00575A  bgt.b  $57c3
00575C  movea.l ([$2061, a6]), a0
005762  moveq  #$74, d1
005764  bcs.b  $5786
005766  ; data: 0x75, 0x6e
005768  bcc.b  $578a
00576A  bsr.b  $57d9
00576C  movea.l -(a2), a0
00576E  bcs.b  $57e3
005770  moveq  #$65, d2
005772  bgt.b  $57a0
005774  move.l d0, d0
005776  movea.l ([$6e20, a7]), a0
00577C  bvs.b  $57e1
00577E  bvc.b  $57a0
005780  ; data: 0x77, 0x69
005782  bge.b  $57f0
005784  move.l -(a0), d6
005786  bcs.b  $57f1
005788  bgt.b  $57aa
00578A  bne.b  $57fb
00578C  moveq  #$6f, d2
00578E  movea.l ([$206d, a6]), a0
005794  bvs.b  $5808
005796  movea.l $cd0b(pc), a0
00579A  bls.b  $5804
00579C  bvs.b  $5801
00579E  bmi.b  $5805
0057A0  bgt.b  $57d0
0057A2  movea.l $61(a4, d6.l), a0
0057A6  move.l -(a0), d6
0057A8  blt.b  $5819
0057AA  bcs.b  $5813
0057AC  bge.b  $5817
0057AE  bls.b  $5818
0057B0  bcs.b  $5824
0057B2  ; data: 0x77, 0x65
0057B4  bvs.b  $5829
0057B6  bcs.b  $57d8
0057B8  ; data: 0x77, 0x65
0057BA  moveq  #$64, d1
0057BC  bcs.b  $57de
0057BE  bvs.b  $5823
0057C0  bvc.b  $57e2
0057C2  ori.b  #$69, -(a0)
0057C6  bgt.b  $57e8
0057C8  ; data: 0x77, 0x65
0057CA  bgt.b  $5835
0057CC  beq.b  $57ee
0057CE  bhi.b  $5835
0057D0  bmi.b  $5833
0057D2  bgt.b  $5842
0057D4  moveq  #$20, d2
0057D6  ; data: 0x75, 0x6e
0057D8  bcc.b  $57fa
0057DA  bcc.b  $583d
0057DC  ; data: 0x73, 0x20
0057DE  bvs.b  $5853
0057E0  moveq  #$20, d2
0057E2  bgt.b  $5859
0057E4  moveq  #$20, d1
0057E6  beq.b  $585d
0057E8  moveq  #$20, d2
0057EA  ; data: 0x73, 0x6f
0057EC  move.l -(a0), d6
0057EE  ; data: 0x77, 0x65
0057F0  bvs.b  $585e
0057F2  movea.l $6368(a1), a0
0057F6  movea.l -(a2), a0
0057F8  bvs.b  $586d
0057FA  bvc.b  $5861
0057FC  moveq  #$20, d1
0057FE  bgt.b  $5875
005800  moveq  #$20, d1
005802  bvs.b  $5871
005804  movea.l $6174(a3, invalid.w), a0
00580A  moveq  #$65, d2
00580C  bgt.b  $582e
00580E  ori.b  #$6f, -(a0)
005812  bgt.b  $5834
005814  bcc.b  $587f
005816  bcs.b  $588a
005818  bmi.b  $583a
00581A  ; data: 0x73, 0x74
00581C  bsr.b  $588c
00581E  bcc.b  $584c
005820  movea.l ([$2064, a6]), a0
005826  bcs.b  $5895
005828  movea.l $616e(a5), a0
00582C  movea.l ([$656e, a3]), a0
005832  movea.l $616e(a3), a0
005836  bgt.b  $5864
005838  movea.l -(a4), a0
00583A  bsr.b  $58af
00583C  ; data: 0x73, 0x20
00583E  bcs.b  $58b2
005840  movea.l -(a4), a0
005842  bcs.b  $58b6
005844  movea.l -(a2), a0
005846  bcs.b  $58b3
005848  bsr.b  $58b8
00584A  bgt.b  $58c0
00584C  bcs.b  $58c1
00584E  moveq  #$65, d2
005850  movea.l -(a1), a0
005852  blt.b  $58bd
005854  beq.b  $58b7
005856  move.l -(a0), -(a6)
005858  ori.b  #$72, -(a0)
00585C  ble.b  $58c5
00585E  moveq  #$61, d1
005860  blt.b  $58cf
005862  bvs.b  $58c9
005864  moveq  #$65, d1
005866  moveq  #$20, d1
005868  bvs.b  $58dd
00586A  moveq  #$2e, d2
00586C  move.l -(a0), d0
00586E  ori.b  #$61, -(a0)
005872  ; data: 0x73, 0x20
005874  bge.b  $58eb
005876  ; data: 0x73, 0x74
005878  bvs.b  $58e1
00587A  ; data: 0x73, 0x74
00587C  bcs.b  $589e
00587E  bsr.b  $58ee
005880  movea.l -(a4), a0
005882  bcs.b  $58f6
005884  movea.l ([$6865, a3], $20697374), a0
00588E  move.l -(a0), d6
005890  bcc.b  $58f3
005892  ; data: 0x73, 0x73
005894  movea.l -(a1), a0
005896  ; data: 0x75, 0x63
005898  bvc.b  $58ba
00589A  bcc.b  $5905
00589C  bcc.b  $5902
00589E  bge.b  $5905
0058A0  movea.l -(a4), a0
0058A2  bcs.b  $5916
0058A4  movea.l $6569(a5), a0
0058A8  bgt.b  $591f
0058AA  bgt.b  $5913
0058AC  movea.l $7374(a1), a0
0058B0  move.l -(a0), d6
0058B2  ; data: 0x73, 0x6f
0058B4  movea.l ([$2d200020, a6], $6d75), a0
0058BE  moveq  #$65, d2
0058C0  movea.l $6368(a1), a0
0058C4  move.l -(a0), d6
0058C6  bcc.b  $5929
0058C8  ; data: 0x73, 0x73
0058CA  movea.l -(a4), a0
0058CC  bvs.b  $5933
0058CE  moveq  #$6b, d1
0058D0  movea.l $cdf2(pc), a0
0058D4  ; data: 0x73, 0x65
0058D6  bvc.b  $594a
0058D8  movea.l $6d20(a1), a0
0058DC  blt.b  $5947
0058DE  moveq  #$74, d2
0058E0  bcs.b  $594e
0058E2  moveq  #$75, d0
0058E4  bgt.b  $5951
0058E6  moveq  #$20, d2
0058E8  ; data: 0x73, 0x74
0058EA  bcs.b  $5954
0058EC  moveq  #$20, d2
0058EE  ; data: 0x75, 0x6e
0058F0  bcc.b  $5912
0058F2  ; data: 0x73, 0x6f
0058F4  movea.l -(a7), a0
0058F6  bge.b  $5959
0058F8  ; data: 0x75, 0x62
0058FA  bcs.b  $591c
0058FC  bvs.b  $5961
0058FE  bvc.b  $592c
005900  movea.l -(a4), a0
005902  bvs.b  $5968
005904  bcc.b  $5972
005906  bcs.b  $5928
005908  ori.b  #$69, -(a0)
00590C  bcs.b  $5980
00590E  bmi.b  $5930
005910  bne.b  $5973
005912  ; data: 0x73, 0x74
005914  movea.l -(a7), a0
005916  bsr.b  $5986
005918  moveq  #$20, d5
00591A  bsr.b  $5991
00591C  ; data: 0x73, 0x20
00591E  bcc.b  $5985
005920  blt.b  $5942
005922  bhi.b  $5989
005924  moveq  #$69, d1
005926  bls.b  $5990
005928  moveq  #$20, d2
00592A  moveq  #$61, d1
00592C  ; data: 0x75, 0x73
00592E  bvc.b  $5991
005930  bge.b  $59a6
005932  bcs.b  $59a2
005934  movea.l $6c20(a7, invalid.w), a0
00593A  move.l $2e20(a6), d7
00593E  ble.b  $59a8
005940  movea.l $6120(a2), a0
005944  ; data: 0x77, 0x61
005946  bcs.b  $59ba
005948  bcs.b  $596a
00594A  bcc.b  $59ad
00594C  ; data: 0x73, 0x20
00594E  beq.b  $59c5
005950  moveq  #$20, d2
005952  move.l $2e20(a6), d7
005956  ori.b  #$63, -(a0)
00595A  bvc.b  $597c
00595C  ; data: 0x77, 0x6f
00595E  bge.b  $59cc
005960  moveq  #$65, d2
005962  movea.l $d0c5(pc), a0
005966  moveq  #$20, d1
005968  bgt.b  $59d9
00596A  bls.b  $59d4
00596C  movea.l $6965(a6), a0
005970  movea.l $7269(a3, d6.l * 8), a0
005976  bls.b  $59e0
005978  moveq  #$69, d2
00597A  beq.b  $599c
00597C  bhi.b  $59e3
00597E  bmi.b  $59e1
005980  bgt.b  $59f0
005982  moveq  #$20, d2
005984  ; data: 0x77, 0x65
005986  moveq  #$64, d1
005988  bcs.b  $59f8
00598A  move.l -(a0), d6
00598C  bsr.b  $59f0
00598E  bcs.b  $5a02
005990  movea.l ([$6e20, a7]), a0
005996  bcs.b  $5a01
005998  bgt.b  $59ff
00599A  blt.b  $59bc
00599C  bcc.b  $5a03
00599E  moveq  #$20, d1
0059A0  ori.b  #$75, -(a0)
0059A4  bvc.b  $5a13
0059A6  movea.l -(a4), a0
0059A8  bvs.b  $5a0f
0059AA  movea.l -(a7), a0
0059AC  bsr.b  $5a1c
0059AE  moveq  #$65, d5
0059B0  movea.l $bf1b(pc), a0
0059B4  moveq  #$20, d2
0059B6  moveq  #$6f, d3
0059B8  moveq  #$65, d1
0059BA  bgt.b  $5a30
0059BC  bvc.b  $5a1f
0059BE  bge.b  $5a34
0059C0  bcs.b  $5a30
0059C2  movea.l ([$642c2064, a7], $616e), a0
0059CC  bgt.b  $59ee
0059CE  blt.b  $5a31
0059D0  bls.b  $5a3a
0059D2  moveq  #$20, d2
0059D4  bcc.b  $5a3f
0059D6  bcs.b  $59f8
0059D8  bsr.b  $5a4c
0059DA  bhi.b  $5a41
0059DC  bvs.b  $5a52
0059DE  movea.l -(a1), a0
0059E0  ; data: 0x75, 0x66
0059E2  movea.l -(a4), a0
0059E4  bvs.b  $5a4b
0059E6  movea.l -(a4), a0
0059E8  bsr.b  $5a5f
0059EA  bcs.b  $5a5e
0059EC  move.l d0, d0
0059EE  movea.l ([$6572, a5], $6861), a0
0059F6  ; data: 0x75, 0x70
0059F8  moveq  #$20, d2
0059FA  bmi.b  $5a61
0059FC  bvs.b  $5a6c
0059FE  bcs.b  $5a6e
005A00  movea.l $61(a3, d7.w), a0
005A04  ; data: 0x73, 0x73
005A06  move.l -(a0), d7
005A08  bcc.b  $5a6f
005A0A  ; data: 0x73, 0x77
005A0C  bcs.b  $5a75
005A0E  bcs.b  $5a7e
005A10  movea.l $6162(a0), a0
005A14  bcs.b  $5a36
005A16  bvs.b  $5a7b
005A18  bvc.b  $5a46
005A1A  movea.l -(a1), a0
005A1C  bge.b  $5a91
005A1E  movea.l $6368(a1), a0
005A22  movea.l $6575(a0), a0
005A26  moveq  #$65, d2
005A28  movea.l $6974(a5), a0
005A2C  movea.l -(a4), a0
005A2E  bvs.b  $5a95
005A30  moveq  #$6b, d1
005A32  movea.l $6566(a4, invalid.w), a0
005A38  ble.b  $5a67
005A3A  move.l d0, d0
005A3C  movea.l $6965(a6), a0
005A40  moveq  #$74, d1
005A42  movea.l $6162(a0), a0
005A46  bcs.b  $5a74
005A48  movea.l ([$6572, a5], $2064), a0
005A50  bcs.b  $5ac0
005A52  movea.l -(a2), a0
005A54  bcs.b  $5ac8
005A56  bvs.b  $5abb
005A58  bvc.b  $5ace
005A5A  movea.l $6569(a3), a0
005A5E  bgt.b  $5a80
005A60  ; data: 0x77, 0x6f
005A62  moveq  #$74, d1
005A64  movea.l ([$6c6f7265, a6], $6e2e), a0
005A6E  movea.l $6368(a1), a0
005A72  movea.l -(a7), a0
005A74  bge.b  $5ad7
005A76  ; data: 0x75, 0x62
005A78  bcs.b  $5a9a
005A7A  bsr.b  $5ade
005A7C  bcs.b  $5af0
005A7E  move.l -(a0), d6
005A80  bcc.b  $5ae3
005A82  ; data: 0x73, 0x73
005A84  move.l d0, d0
005A86  movea.l -(a5), a0
005A88  moveq  #$20, d1
005A8A  ; data: 0x73, 0x65
005A8C  bvs.b  $5afc
005A8E  movea.l $616d(a6), a0
005A92  bcs.b  $5b02
005A94  movea.l -(a4), a0
005A96  bcs.b  $5b0d
005A98  moveq  #$6c, d2
005A9A  bvs.b  $5aff
005A9C  bvc.b  $5abe
005A9E  beq.b  $5b05
005AA0  bgt.b  $5b17
005AA2  beq.b  $5ac4
005AA4  bvs.b  $5b13
005AA6  movea.l $6574(a4), a0
005AAA  moveq  #$74, d5
005AAC  bcs.b  $5b1b
005AAE  movea.l ([$7420756e, a0], $7465), a0
005AB8  moveq  #$73, d1
005ABA  moveq  #$72, d2
005ABC  bcs.b  $5b27
005ABE  bls.b  $5b28
005AC0  bcs.b  $5b30
005AC2  movea.l ([$642c2064, a7], $616d), a0
005ACC  bvs.b  $5b42
005ACE  move.l d0, d0
005AD0  movea.l -(a2), a0
005AD2  bge.b  $5b43
005AD4  ; data: 0x73, 0x73
005AD6  movea.l $6569(a3), a0
005ADA  bgt.b  $5b41
005ADC  moveq  #$20, d1
005ADE  ; data: 0x75, 0x65
005AE0  bhi.b  $5b47
005AE2  moveq  #$73, d1
005AE4  bvs.b  $5b4b
005AE6  bvc.b  $5b5c
005AE8  move.l -(a0), d6
005AEA  bcc.b  $5b4d
005AEC  ; data: 0x73, 0x73
005AEE  movea.l -(a5), a0
005AF0  moveq  #$20, d1
005AF2  bsr.b  $5b69
005AF4  bls.b  $5b5e
005AF6  movea.l -(a5), a0
005AF8  bvs.b  $5b68
005AFA  movea.l -(a7), a0
005AFC  moveq  #$6f, d1
005AFE  ; data: 0x73, 0x73
005B00  bcs.b  $5b75
005B02  movea.l ([$6c20, a4]), a0
005B08  bcc.b  $5b6f
005B0A  moveq  #$20, d1
005B0C  bsr.b  $5b80
005B0E  bhi.b  $5b75
005B10  bvs.b  $5b86
005B12  movea.l -(a7), a0
005B14  bcs.b  $5b43
005B16  move.l d0, d0
005B18  movea.l $6569(a4), a0
005B1C  ; data: 0x73, 0x74
005B1E  bcs.b  $5b94
005B20  movea.l $6174(a0), a0
005B24  move.l -(a0), d7
005B26  ; data: 0x73, 0x63
005B28  bvc.b  $5b9c
005B2A  bcs.b  $5b95
005B2C  bhi.b  $5ba2
005B2E  movea.l -(a5), a0
005B30  moveq  #$20, d1
005B32  bcs.b  $5b9d
005B34  beq.b  $5b9b
005B36  bgt.b  $5bac
005B38  bge.b  $5ba3
005B3A  bls.b  $5ba4
005B3C  movea.l -(a4), a0
005B3E  bvs.b  $5ba5
005B40  movea.l -(a5), a0
005B42  bgt.b  $5ba8
005B44  move.l -(a3), $7265(a6)
005B48  bcc.b  $5bb3
005B4A  moveq  #$73, d2
005B4C  ; data: 0x20, 0x3f
005B4E  ; data: 0x3f, 0x3f
005B50  move.l $2e2e(a6), d7
005B54  move.l d0, d0
005B56  movea.l $64(a5, d6.l), a0
005B5A  movea.l $6c65(a7, invalid.w), a0
005B60  bgt.b  $5b82
005B62  ; data: 0x77, 0x69
005B64  moveq  #$20, d1
005B66  ; data: 0x77, 0x65
005B68  moveq  #$74, d2
005B6A  bcs.b  $5bda
005B6C  move.l -(a0), d6
005B6E  bcc.b  $5bd1
005B70  ; data: 0x73, 0x73
005B72  movea.l $6368(a1), a0
005B76  movea.l $6569(a3), a0
005B7A  bgt.b  $5be1
005B7C  movea.l $6f65(a5), a0
005B80  beq.b  $5bee
005B82  bvs.b  $5be7
005B84  bvc.b  $5bf1
005B86  bcs.b  $5bf1
005B88  moveq  #$20, d2
005B8A  bvc.b  $5bed
005B8C  bhi.b  $5bf3
005B8E  bgt.b  $5bb0
005B90  ; data: 0x77, 0x65
005B92  moveq  #$64, d1
005B94  bcs.b  $5bb6
005B96  bcc.b  $5c01
005B98  bcs.b  $5bba
005B9A  bls.b  $5c0e
005B9C  bcs.b  $5c02
005B9E  bvs.b  $5c14
005BA0  ; data: 0x73, 0x20
005BA2  ori.b  #$75, -(a0)
005BA6  movea.l -(a1), a0
005BA8  bcs.b  $5c18
005BAA  bcc.b  $5c11
005BAC  moveq  #$6e, d1
005BAE  move.l $2e2e(a6), d0
005BB2  movea.l $6368(a1), a0
005BB6  movea.l $6520(a3, invalid.w), a0
005BBC  ; data: 0x73, 0x63
005BBE  bvc.b  $5c2f
005BC0  bgt.b  $5be2
005BC2  ; data: 0x77, 0x69
005BC4  bcs.b  $5be6
005BC6  bcs.b  $5c3b
005BC8  movea.l $6f6d(a3), a0
005BCC  blt.b  $5c33
005BCE  bgt.b  $5bf0
005BD0  ; data: 0x77, 0x69
005BD2  moveq  #$64, d1
005BD4  move.l $2e2e(a6), d0
005BD8  movea.l -(a4), a0
005BDA  bvs.b  $5c41
005BDC  moveq  #$6b, d1
005BDE  ; data: 0x73, 0x20
005BE0  bsr.b  $5c46
005BE2  moveq  #$65, d1
005BE4  ; data: 0x73, 0x73
005BE6  bcs.b  $5c08
005BE8  ori.b  #$6e, -(a0)
005BEC  movea.l -(a5), a0
005BEE  moveq  #$73, d1
005BF0  moveq  #$65, d2
005BF2  moveq  #$20, d1
005BF4  ; data: 0x73, 0x74
005BF6  bcs.b  $5c64
005BF8  bge.b  $5c5f
005BFA  movea.l $64(a5, d6.l), a0
005BFE  movea.l $6569(a5), a0
005C02  bgt.b  $5c69
005C04  move.l -(a0), d6
005C06  ; data: 0x77, 0x65
005C08  bgt.b  $5c78
005C0A  movea.l ([$6572, a5], $6861), a0
005C12  ; data: 0x75, 0x70
005C14  moveq  #$2c, d2
005C16  movea.l -(a1), a0
005C18  bge.b  $5c8d
005C1A  movea.l -(a1), a0
005C1C  bgt.b  $5c86
005C1E  bsr.b  $5c8e
005C20  beq.b  $5c42
005C22  bcc.b  $5c85
005C24  blt.b  $5c8f
005C26  moveq  #$20, d2
005C28  bcc.b  $5c93
005C2A  bcs.b  $5c4c
005C2C  moveq  #$65, d5
005C2E  bvs.b  $5ca4
005C30  move.l d0, d0
005C32  movea.l ([$6b6f, a2]), a0
005C38  blt.b  $5ca7
005C3A  moveq  #$20, d2
005C3C  move.l $2e20(a6), d7
005C40  ; data: 0x73, 0x69
005C42  bcs.b  $5cac
005C44  bcs.b  $5c66
005C46  ; data: 0x77, 0x6f
005C48  bls.b  $5c77
005C4A  move.w $656d(a2, invalid.w), -(a4)
005C50  ble.b  $5c72
005C52  move.l -(a1), -(a0)
005C54  move.l -(a0), -(a0)
005C56  blt.b  $5cc1
005C58  moveq  #$20, d2
005C5A  bcc.b  $5cc1
005C5C  moveq  #$20, d1
005C5E  bhi.b  $5cc5
005C60  blt.b  $5cc7
005C62  moveq  #$6b, d1
005C64  ; data: 0x75, 0x6e
005C66  beq.b  $5ca2
005C68  movea.l -(a1), a0
005C6A  bls.b  $5cd4
005C6C  movea.l $612c(a2), a0
005C70  movea.l -(a4), a0
005C72  bcs.b  $5ce6
005C74  movea.l $6562(a4), a0
005C78  moveq  #$20, d2
005C7A  ori.b  #$75, -(a0)
005C7E  bls.b  $5ce8
005C80  movea.l $6f63(a6), a0
005C84  bvc.b  $5ca6
005C86  move.l $2e2e(a6), d7
005C8A  move.l $2e2e(a6), d7
005C8E  move.l $2000(a6), d7
005C92  move.l -(a0), d0
005C94  ori.b  #$2e, -(a0)
005C98  move.l $2e2e(a6), d7
005C9C  move.l $2e2e(a6), d7
005CA0  movea.l $6175(a0), a0
005CA4  moveq  #$74, d0
005CA6  ; data: 0x73, 0x61
005CA8  bls.b  $5d12
005CAA  bcs.b  $5ccc
005CAC  bvs.b  $5d11
005CAE  bvc.b  $5cd0
005CB0  bvc.b  $5d13
005CB2  bhi.b  $5d19
005CB4  movea.l $6569(a5), a0
005CB8  bgt.b  $5d1f
005CBA  move.l $20(a4, d3.w), d0
005CBE  moveq  #$65, d0
005CC0  moveq  #$20, d1
005CC2  bls.b  $5d29
005CC4  bgt.b  $5d3a
005CC6  movea.l -(a1), a0
005CC8  bgt.b  $5cea
005CCA  bcc.b  $5d31
005CCC  blt.b  $5cee
005CCE  beq.b  $5d35
005CD0  ; data: 0x77, 0x69
005CD2  bgt.b  $5d42
005CD4  move.l -(a1), d0
005CD6  move.l -(a1), -(a0)
005CD8  move.l d0, d0
005CDA  move.l -(a0), d0
005CDC  ori.b  #$65, -(a0)
005CE0  ; data: 0x73, 0x74
005CE2  bcs.b  $5d56
005CE4  bgt.b  $5d06
005CE6  bvs.b  $5d55
005CE8  movea.l $6f(a0, d7.w), a0
005CEC  bge.b  $5d5d
005CEE  blt.b  $5d65
005CF0  bls.b  $5d5d
005CF2  bcs.b  $5d60
005CF4  move.l -(a0), -(a0)
005CF6  bvs.b  $5d6b
005CF8  moveq  #$20, d2
005CFA  bcc.b  $5d65
005CFC  bcs.b  $5d1e
005CFE  ; data: 0x75, 0x65
005D00  bhi.b  $5d67
005D02  moveq  #$73, d1
005D04  bls.b  $5d6e
005D06  moveq  #$69, d1
005D08  bne.b  $5d7e
005D0A  move.l -(a0), d7
005D0C  bsr.b  $5d70
005D0E  bcs.b  $5d82
005D10  movea.l $62(a5, d6.l), a0
005D14  bcs.b  $5d7a
005D16  bvs.b  $5d86
005D18  beq.b  $5d8e
005D1A  movea.l -(a2), a0
005D1C  ble.b  $5d81
005D1E  bmi.b  $5d40
005D20  ori.b  #$72, -(a0)
005D24  ; data: 0x75, 0x65
005D26  bhi.b  $5d8d
005D28  moveq  #$20, d1
005D2A  moveq  #$75, d5
005D2C  movea.l $7265(a3, invalid.w), a0
005D32  bvs.b  $5d96
005D34  bcs.b  $5da4
005D36  movea.l $6162(a0), a0
005D3A  bcs.b  $5d5c
005D3C  bvs.b  $5da1
005D3E  bvc.b  $5d60
005D40  bgt.b  $5dab
005D42  bls.b  $5dac
005D44  moveq  #$2e, d2
005D46  movea.l -(a1), a0
005D48  ; data: 0x75, 0x66
005D4A  movea.l $6564(a2), a0
005D4E  bcs.b  $5dbe
005D50  bcs.b  $5d72
005D52  bne.b  $5db5
005D54  bge.b  $5dc2
005D56  movea.l ([$20657320, a7], $6e69), a0
005D60  bls.b  $5dca
005D62  moveq  #$20, d2
005D64  ; data: 0x73, 0x6f
005D66  move.l d0, d0
005D68  movea.l -(a7), a0
005D6A  bge.b  $5ddb
005D6C  moveq  #$65, d1
005D6E  bvs.b  $5dd3
005D70  bvc.b  $5d92
005D72  beq.b  $5dd9
005D74  ; data: 0x77, 0x65
005D76  ; data: 0x73, 0x65
005D78  bgt.b  $5da6
005D7A  movea.l ([$2069, a7]), a0
005D80  bls.b  $5dea
005D82  movea.l -(a5), a0
005D84  ; data: 0x73, 0x20
005D86  bvc.b  $5ded
005D88  bgt.b  $5dee
005D8A  moveq  #$69, d1
005D8C  bmi.b  $5dae
005D8E  bsr.b  $5dfd
005D90  movea.l $6566(a4, invalid.w), a0
005D96  ble.b  $5e06
005D98  movea.l -(a7), a0
005D9A  bcs.b  $5e0f
005D9C  bls.b  $5e06
005D9E  bvs.b  $5e0c
005DA0  bcc.b  $5e07
005DA2  moveq  #$74, d1
005DA4  movea.l $6162(a0), a0
005DA8  bcs.b  $5dd8
005DAA  movea.l -(a5), a0
005DAC  ; data: 0x73, 0x20
005DAE  ; data: 0x77, 0x61
005DB0  moveq  #$20, d1
005DB2  ori.b  #$77, -(a0)
005DB6  bsr.b  $5e2a
005DB8  movea.l $7573(a4), a0
005DBC  moveq  #$69, d2
005DBE  beq.b  $5dec
005DC0  movea.l -(a1), a0
005DC2  bhi.b  $5e29
005DC4  moveq  #$20, d1
005DC6  ; data: 0x77, 0x65
005DC8  bgt.b  $5e38
005DCA  movea.l $6972(a3), a0
005DCE  ; data: 0x73, 0x74
005DD0  bcs.b  $5e40
005DD2  movea.l -(a4), a0
005DD4  bvs.b  $5e3b
005DD6  movea.l -(a7), a0
005DD8  bsr.b  $5e48
005DDA  moveq  #$65, d5
005DDC  movea.l $c347(pc), a0
005DE0  moveq  #$20, d2
005DE2  bsr.b  $5e59
005DE4  bne.b  $5e06
005DE6  ; data: 0x73, 0x63
005DE8  bvc.b  $5e5c
005DEA  ble.b  $5e51
005DEC  bcc.b  $5e53
005DEE  moveq  #$20, d1
005DF0  bne.b  $5e5b
005DF2  moveq  #$69, d4
005DF4  bcs.b  $5e68
005DF6  moveq  #$20, d2
005DF8  bvs.b  $5e6d
005DFA  moveq  #$20, d2
005DFC  ori.b  #$6e, -(a0)
005E00  bcc.b  $5e22
005E02  bcc.b  $5e6d
005E04  bcs.b  $5e26
005E06  bsr.b  $5e76
005E08  bcc.b  $5e6f
005E0A  moveq  #$65, d1
005E0C  move.l $2e2e(a6), d0
005E10  movea.l $6368(a1), a0
005E14  movea.l -(a7), a0
005E16  bge.b  $5e79
005E18  ; data: 0x75, 0x62
005E1A  bcs.b  $5e3c
005E1C  ; data: 0x73, 0x69
005E1E  bcs.b  $5e40
005E20  bvc.b  $5e8b
005E22  bcs.b  $5e97
005E24  ; data: 0x73, 0x20
005E26  move.l $6172(a5), $7465(a6)
005E2C  move.l $206f(a4), -(a6)
005E30  bcc.b  $5e97
005E32  moveq  #$20, d1
005E34  ; data: 0x73, 0x6f
005E36  move.l $2e2e(a6), d0
005E3A  movea.l ([$6c6e, a4]), a0
005E40  bsr.b  $5eaa
005E42  blt.b  $5ea9
005E44  bge.b  $5eb5
005E46  ; data: 0x73, 0x20
005E48  ori.b  #$75, -(a0)
005E4C  moveq  #$63, d1
005E4E  bvc.b  $5e70
005E50  bcc.b  $5ebb
005E52  bcs.b  $5e74
005E54  beq.b  $5ebb
005E56  beq.b  $5ebd
005E58  bgt.b  $5ebe
005E5A  movea.l ([$6574, a6]), a0
005E60  bvs.b  $5ec7
005E62  moveq  #$74, d1
005E64  move.l -(a0), d6
005E66  blt.b  $5ec9
005E68  bls.b  $5ed2
005E6A  moveq  #$20, d2
005E6C  bcc.b  $5ecf
005E6E  ; data: 0x73, 0x2c
005E70  movea.l -(a1), a0
005E72  ; data: 0x75, 0x66
005E74  movea.l -(a4), a0
005E76  bvs.b  $5edd
005E78  movea.l -(a4), a0
005E7A  bsr.b  $5ef1
005E7C  bcs.b  $5ef0
005E7E  move.l -(a0), d6
005E80  bgt.b  $5eeb
005E82  bls.b  $5eec
005E84  moveq  #$20, d2
005E86  ; data: 0x73, 0x6f
005E88  movea.l $7573(a4), a0
005E8C  moveq  #$69, d2
005E8E  beq.b  $5ebe
005E90  ori.b  #$65, -(a0)
005E94  bgt.b  $5f04
005E96  movea.l -(a4), a0
005E98  bvs.b  $5eff
005E9A  movea.l -(a1), a0
005E9C  bgt.b  $5f02
005E9E  bcs.b  $5f12
005EA0  bcs.b  $5ece
005EA2  movea.l $6277(a7), a0
005EA6  ble.b  $5f10
005EA8  bge.b  $5eca
005EAA  bvs.b  $5f0f
005EAC  bvc.b  $5ece
005EAE  ; data: 0x73, 0x69
005EB0  bcs.b  $5ed2
005EB2  ; data: 0x73, 0x63
005EB4  bvc.b  $5f22
005EB6  bcs.b  $5f1b
005EB8  bvc.b  $5f2e
005EBA  bcs.b  $5f2e
005EBC  movea.l -(a1), a0
005EBE  bge.b  $5f33
005EC0  movea.l $6972(a3), a0
005EC4  ; data: 0x73, 0x74
005EC6  bcs.b  $5f36
005EC8  movea.l -(a6), a0
005ECA  bvs.b  $5f3a
005ECC  bcc.b  $5f33
005ECE  move.l -(a0), d6
005ED0  bhi.b  $5f3b
005ED2  ; data: 0x73, 0x63
005ED4  bvc.b  $5f3b
005ED6  bgt.b  $5ef8
005ED8  ori.b  #$75, -(a0)
005EDC  bne.b  $5f45
005EDE  bcs.b  $5f53
005EE0  bls.b  $5f4a
005EE2  bge.b  $5f53
005EE4  ; data: 0x73, 0x73
005EE6  bcs.b  $5f56
005EE8  bcs.b  $5f5c
005EEA  movea.l ([$7265, a7]), a0
005EF0  move.l -(a0), d6
005EF2  bcc.b  $5f55
005EF4  bgt.b  $5f64
005EF6  move.l $2e2e(a6), d0
005EFA  move.l $2e2e(a6), d7
005EFE  movea.l -(a6), a0
005F00  bsr.b  $5f6f
005F02  movea.l $686e(a7), a0
005F06  bcs.b  $5f28
005F08  bcs.b  $5f78
005F0A  bcc.b  $5f71
005F0C  move.l $2e2e(a6), d0
005F10  movea.l -(a1), a0
005F12  bhi.b  $5f79
005F14  moveq  #$20, d1
005F16  ; data: 0x73, 0x6f
005F18  ble.b  $5f89
005F1A  move.l $2e20(a6), d7
005F1E  ori.b  #$6a, -(a0)
005F22  bsr.b  $5f44
005F24  ; data: 0x73, 0x63
005F26  bvc.b  $5f9a
005F28  ble.b  $5f8f
005F2A  bcc.b  $5f91
005F2C  moveq  #$20, d1
005F2E  bvs.b  $5fa3
005F30  moveq  #$20, d2
005F32  bgt.b  $5fa9
005F34  movea.l $616c(a5), a0
005F38  movea.l -(a4), a0
005F3A  ble.b  $5fab
005F3C  bne.b  $5f6c
005F3E  movea.l -(a4), a0
005F40  bsr.b  $5f62
005F42  bmi.b  $5fa5
005F44  bgt.b  $5fb4
005F46  movea.l $6569(a3), a0
005F4A  bgt.b  $5fb1
005F4C  moveq  #$20, d1
005F4E  ; data: 0x77, 0x61
005F50  ; data: 0x73, 0x20
005F52  bne.b  $5fc9
005F54  bcs.b  $5fc8
005F56  move.l -(a0), d7
005F58  bsr.b  $5fbc
005F5A  bcs.b  $5fce
005F5C  movea.l $656e(a0), a0
005F60  bcc.b  $5fd4
005F62  bvs.b  $5fcf
005F64  move.l d0, d0
005F66  movea.l $7374(a1), a0
005F6A  movea.l $6f63(a6), a0
005F6E  bvc.b  $5f90
005F70  ; data: 0x73, 0x63
005F72  bvc.b  $5fe0
005F74  bcs.b  $5fd9
005F76  bvc.b  $5fec
005F78  bcs.b  $5fec
005F7A  move.l -(a0), d7
005F7C  bcs.b  $5ff0
005F7E  movea.l -(a7), a0
005F80  bge.b  $5fe3
005F82  ; data: 0x75, 0x62
005F84  moveq  #$20, d2
005F86  bcc.b  $5ff7
005F88  bls.b  $5ff2
005F8A  movea.l $6963(a6), a0
005F8E  bvc.b  $6004
005F90  movea.l ([$6b6c6963, a7], $682c), a0
005F9A  movea.l -(a4), a0
005F9C  bsr.b  $6011
005F9E  ; data: 0x73, 0x20
005FA0  bmi.b  $600b
005FA2  moveq  #$73, d1
005FA4  moveq  #$65, d2
005FA6  bgt.b  $5fc8
005FA8  blt.b  $6013
005FAA  moveq  #$20, d2
005FAC  ori.b  #$68, -(a0)
005FB0  blt.b  $5fd2
005FB2  bvc.b  $6019
005FB4  ; data: 0x75, 0x74
005FB6  bcs.b  $5fd8
005FB8  moveq  #$75, d5
005FBA  movea.l $6473(a7, invalid.w), a0
005FC0  bls.b  $602a
005FC2  bvs.b  $6029
005FC4  ; data: 0x73, 0x73
005FC6  move.l -(a7), $6562(a6)
005FCA  ; data: 0x75, 0x72
005FCC  moveq  #$73, d2
005FCE  moveq  #$61, d2
005FD0  beq.b  $5ff2
005FD2  bmi.b  $6043
005FD4  blt.b  $6043
005FD6  moveq  #$2e, d2
005FD8  movea.l $6368(a1), a0
005FDC  movea.l $74652075(a7, invalid.w), a0
005FE4  blt.b  $6006
005FE6  bsr.b  $6054
005FE8  bge.b  $604f
005FEA  ; data: 0x73, 0x2c
005FEC  movea.l -(a4), a0
005FEE  bsr.b  $6063
005FF0  ; data: 0x73, 0x20
005FF2  ori.b  #$72, -(a0)
005FF6  movea.l -(a5), a0
005FF8  bvs.b  $6068
005FFA  bcs.b  $601c
005FFC  bgt.b  $6063
005FFE  moveq  #$74, d2
006000  bcs.b  $6022
006002  bsr.b  $6066
006004  bne.b  $607b
006006  bvc.b  $607a
006008  movea.l $7269(a3), a0
00600C  bcs.b  $6075
00600E  moveq  #$20, d2
006010  move.l $2e20(a6), d7
006014  bsr.b  $6078
006016  bcs.b  $608a
006018  movea.l ([$6e20, a7]), a0
00601E  bcs.b  $6092
006020  movea.l $6569(a5), a0
006024  bgt.b  $609a
006026  movea.l -(a5), a0
006028  moveq  #$20, d1
00602A  blt.b  $60a1
00602C  ; data: 0x73, 0x73
00602E  movea.l -(a5), a0
006030  ; data: 0x73, 0x20
006032  bvc.b  $6095
006034  bhi.b  $609b
006036  bgt.b  $6064
006038  move.l d0, d0
00603A  movea.l -(a4), a0
00603C  bsr.b  $60ac
00603E  bgt.b  $6060
006040  bhi.b  $60ab
006042  moveq  #$74, d2
006044  bcs.b  $6066
006046  move.l $2e20(a6), d7
00604A  bvs.b  $60af
00604C  bvc.b  $606e
00604E  blt.b  $60b1
006050  bls.b  $60ba
006052  movea.l $6963(a5), a0
006056  bvc.b  $6078
006058  bpl.b  $60bb
00605A  movea.l $6963(a6), a0
00605E  bvc.b  $60d4
006060  movea.l $6165(a4), a0
006064  bls.b  $60ce
006066  bcs.b  $60da
006068  bge.b  $60d3
00606A  bls.b  $60d4
00606C  move.l -(a0), d7
00606E  ori.b  #$61, -(a0)
006072  blt.b  $60dd
006074  moveq  #$20, d2
006076  ; data: 0x77, 0x69
006078  bge.b  $60e6
00607A  movea.l $6368(a1), a0
00607E  movea.l -(a4), a0
006080  bsr.b  $60f5
006082  movea.l $65(a4, d6.l), a0
006086  blt.b  $60e9
006088  move.l $7072(a5), d0
00608C  ble.b  $60fa
00608E  ble.b  $60fd
006090  ; data: 0x75, 0x63
006092  bmi.b  $60f9
006094  bge.b  $60c3
006096  movea.l -(a5), a0
006098  bvs.b  $6101
00609A  bcs.b  $610a
00609C  moveq  #$6c, d2
00609E  bvs.b  $6103
0060A0  bvc.b  $60c2
0060A2  bsr.b  $6106
0060A4  ; data: 0x73, 0x63
0060A6  bvc.b  $6114
0060A8  bvs.b  $610f
0060AA  ; data: 0x73, 0x73
0060AC  bcs.b  $611c
0060AE  move.l -(a0), d6
0060B0  ; data: 0x77, 0x65
0060B2  bvs.b  $6120
0060B4  move.l d0, d0
0060B6  movea.l $6368(a1), a0
0060BA  movea.l $6974(a5), a0
0060BE  movea.l -(a4), a0
0060C0  bcs.b  $612f
0060C2  movea.l $6164(a4), a0
0060C6  bcs.b  $6136
0060C8  movea.l $6f6e(a3, invalid.w), a0
0060CE  movea.l $616e(a4), a0
0060D2  beq.b  $6147
0060D4  bsr.b  $6143
0060D6  movea.l $6f74(a3), a0
0060DA  moveq  #$65, d5
0060DC  move.l $2e2e(a6), d0
0060E0  move.l d0, d0
0060E2  move.l -(a0), d0
0060E4  ori.b  #$63, -(a0)
0060E8  bvc.b  $610a
0060EA  ; data: 0x73, 0x63
0060EC  bvc.b  $6153
0060EE  bvs.b  $6163
0060F0  ; data: 0x73, 0x65
0060F2  move.l -(a0), d6
0060F4  bvs.b  $6159
0060F6  bvc.b  $6118
0060F8  ; data: 0x77, 0x6f
0060FA  bge.b  $6168
0060FC  moveq  #$65, d2
0060FE  movea.l $6575(a0), a0
006102  moveq  #$65, d2
006104  movea.l -(a6), a0
006106  ; data: 0x75, 0x65
006108  moveq  #$20, d1
00610A  blt.b  $6175
00610C  moveq  #$6b, d1
00610E  ble.b  $6130
006110  moveq  #$61, d0
006112  bsr.b  $6186
006114  movea.l $6575(a4), a0
006118  moveq  #$65, d2
00611A  movea.l -(a1), a0
00611C  bgt.b  $6190
00611E  ; data: 0x75, 0x66
006120  bcs.b  $6190
006122  move.l -(a0), d6
006124  ble.b  $6188
006126  movea.l ([$2000, a3]), a0
00612C  movea.l $6963(a6), a0
006130  bvc.b  $61a6
006132  movea.l $6e74(a1), a0
006136  bcs.b  $61aa
006138  bcs.b  $61ad
00613A  ; data: 0x73, 0x65
00613C  movea.l -(a1), a0
00613E  bgt.b  $6160
006140  bge.b  $61a3
006142  moveq  #$2d, d0
006144  moveq  #$6f, d2
006146  moveq  #$73, d0
006148  move.l $2d20(a5), d0
00614C  ; data: 0x77, 0x69
00614E  bcs.b  $6170
006150  ; data: 0x73, 0x63
006152  bvc.b  $61c6
006154  bcs.b  $61bf
006156  bhi.b  $6178
006158  blt.b  $61bb
00615A  bgt.b  $617c
00615C  bcs.b  $61c7
00615E  beq.b  $61c5
006160  bgt.b  $61d6
006162  bge.b  $61cd
006164  bls.b  $61ce
006166  movea.l $6570(a4), a0
00616A  move.l $202d2d20(a4, invalid.w), $20(a6)
006174  bvc.b  $61d7
006176  bcs.b  $61ec
006178  moveq  #$65, d2
00617A  bgt.b  $619c
00617C  move.l $6174(a6), $7565(a6)
006182  moveq  #$6c, d1
006184  bvs.b  $61e9
006186  bvc.b  $61a8
006188  moveq  #$75, d5
00618A  blt.b  $61ac
00618C  bvc.b  $61ef
00618E  bge.b  $61f2
006190  bcs.b  $6200
006192  movea.l $65(a0, d7.w), a0
006196  bvs.b  $620b
006198  move.l -(a0), -(a6)
00619A  bsr.b  $61fe
00619C  bcs.b  $6210
00619E  movea.l $7374(a1), a0
0061A2  movea.l $6f6e(a3, invalid.w), a0
0061A8  movea.l ([$6965736f, a3]), a0
0061B0  movea.l $d6d2(pc), a0
0061B4  ; data: 0x73, 0x70
0061B6  bsr.b  $621d
0061B8  moveq  #$3a, d2
0061BA  move.l d0, d0
0061BC  move.l ([$31382069, a1, d3.w * 8], $6368), d0
0061C6  movea.l $6c74(a3, invalid.w), a0
0061CC  bcs.b  $61ee
0061CE  bge.b  $6231
0061D0  bgt.b  $6239
0061D2  ; data: 0x73, 0x61
0061D4  blt.b  $61f6
0061D6  bvs.b  $6246
0061D8  movea.l -(a4), a0
0061DA  bvs.b  $6241
0061DC  movea.l -(a2), a0
0061DE  bsr.b  $6244
0061E0  bcs.b  $6259
0061E2  bsr.b  $6252
0061E4  bgt.b  $624b
0061E6  movea.l $65(a3, d7.w), a0
0061EA  bvs.b  $6253
0061EC  bcs.b  $625c
0061EE  move.l -(a0), d7
0061F0  blt.b  $6257
0061F2  bvs.b  $6262
0061F4  movea.l -(a7), a0
0061F6  bge.b  $6261
0061F8  bcs.b  $625e
0061FA  move.l -(a0), d6
0061FC  bvs.b  $6261
0061FE  bvc.b  $6220
006200  blt.b  $6267
006202  bvs.b  $6272
006204  bcs.b  $6226
006206  ori.b  #$65, -(a0)
00620A  bvs.b  $627a
00620C  bcs.b  $622e
00620E  beq.b  $627c
006210  bvs.b  $6277
006212  bcc.b  $6279
006214  moveq  #$20, d1
006216  bcs.b  $6286
006218  moveq  #$73, d2
00621A  moveq  #$61, d0
00621C  bgt.b  $628c
00621E  bcs.b  $628e
006220  move.l -(a0), d6
006222  bvc.b  $6293
006224  movea.l $6f2c(a0), a0
006228  movea.l -(a7), a0
00622A  ; data: 0x75, 0x74
00622C  bcs.b  $62a0
00622E  movea.l $7a2c2077(a7, invalid.w), a0
006236  bsr.b  $6258
006238  ; data: 0x3f, 0x3f
00623A  move.w -(a0), -(a7)
00623C  ori.b  #$69, -(a0)
006240  moveq  #$6b, d1
006242  ble.b  $6264
006244  bvs.b  $62b9
006246  moveq  #$20, d2
006248  bsr.b  $62ac
00624A  bcs.b  $62be
00624C  movea.l -(a1), a0
00624E  ; data: 0x75, 0x63
006250  bvc.b  $6272
006252  bcs.b  $62bd
006254  bgt.b  $6276
006256  bmi.b  $62c7
006258  blt.b  $62c3
00625A  ; data: 0x73, 0x63
00625C  bvc.b  $62c3
00625E  moveq  #$2c, d1
006260  movea.l $6368(a1), a0
006264  movea.l ([$7373, a7]), a0
00626A  movea.l $6963(a6), a0
00626E  bvc.b  $62e4
006270  movea.l ([$20696368, a7], $20766f6e), a0
00627C  movea.l $686d(a1), a0
006280  movea.l $616c(a0), a0
006284  moveq  #$65, d2
006286  bgt.b  $62a8
006288  ori.b  #$6f, -(a0)
00628C  bge.b  $62fa
00628E  move.l -(a0), d6
006290  bvs.b  $6305
006292  moveq  #$20, d2
006294  bcs.b  $6308
006296  movea.l $6574(a2), a0
00629A  moveq  #$74, d5
00629C  movea.l $7572(a6), a0
0062A0  movea.l $6574(a6), a0
0062A4  moveq  #$20, d2
0062A6  moveq  #$75, d5
0062A8  movea.l $6972(a5), a0
0062AC  move.l -(a0), d6
0062AE  ; data: 0x77, 0x65
0062B0  bvs.b  $631e
0062B2  movea.l -(a5), a0
0062B4  moveq  #$20, d1
0062B6  bcc.b  $632d
0062B8  moveq  #$63, d1
0062BA  bvc.b  $62dc
0062BC  blt.b  $6327
0062BE  bls.b  $6328
0062C0  movea.l $d7e2(pc), a0
0062C4  bmi.b  $6335
0062C6  bvc.b  $6334
0062C8  bcs.b  $62ea
0062CA  bmi.b  $633b
0062CC  blt.b  $633b
0062CE  bcs.b  $633e
0062D0  movea.l $616e(a3), a0
0062D4  bgt.b  $6302
0062D6  move.l d0, d0
0062D8  movea.l $6465(a7), a0
0062DC  moveq  #$20, d1
0062DE  ; data: 0x77, 0x61
0062E0  moveq  #$20, d1
0062E2  bcs.b  $6356
0062E4  movea.l $6d6d(a1), a0
0062E8  bcs.b  $635c
0062EA  movea.l $6f6e(a3, invalid.w), a0
0062F0  movea.l $6574(a6), a0
0062F4  moveq  #$2c, d2
0062F6  movea.l $7572(a6), a0
0062FA  movea.l -(a5), a0
0062FC  ; data: 0x73, 0x20
0062FE  beq.b  $6361
006300  bhi.b  $6322
006302  bmi.b  $6369
006304  bvs.b  $6374
006306  bcs.b  $6328
006308  beq.b  $636f
00630A  bge.b  $6371
00630C  beq.b  $6373
00630E  bgt.b  $6378
006310  bcs.b  $637b
006312  moveq  #$20, d2
006314  ; data: 0x75, 0x6d
006316  movea.l -(a5), a0
006318  ; data: 0x73, 0x20
00631A  moveq  #$75, d5
00631C  movea.l $c887(pc), a0
006320  beq.b  $6387
006322  bgt.b  $6352
006324  move.l d0, d0
006326  movea.l -(a1), a0
006328  ; data: 0x75, 0x66
00632A  movea.l $6564(a2), a0
00632E  bcs.b  $639e
006330  movea.l -(a6), a0
006332  bsr.b  $63a0
006334  bge.b  $6356
006336  bvs.b  $63ab
006338  moveq  #$20, d2
00633A  blt.b  $63a5
00633C  moveq  #$6b, d1
00633E  ble.b  $6360
006340  bcs.b  $63ab
006342  bgt.b  $63a9
006344  moveq  #$20, d1
006346  moveq  #$6f, d3
006348  bgt.b  $636a
00634A  bcc.b  $63b1
00634C  bgt.b  $636e
00634E  ; data: 0x77, 0x65
006350  bgt.b  $63bb
006352  beq.b  $63b9
006354  bgt.b  $6382
006356  movea.l ([$2064, a6]), a0
00635C  bcs.b  $63cc
00635E  bcs.b  $63ce
006360  movea.l $6368(a1), a0
006364  movea.l ([$6572, a5], $6861), a0
00636C  ; data: 0x75, 0x70
00636E  moveq  #$20, d2
006370  ori.b  #$74, -(a0)
006374  ; data: 0x77, 0x61
006376  ; data: 0x73, 0x20
006378  bvc.b  $63db
00637A  bge.b  $63f0
00637C  bcs.b  $63ac
00637E  movea.l $6368(a1), a0
006382  movea.l -(a7), a0
006384  bge.b  $63e7
006386  ; data: 0x75, 0x62
006388  bcs.b  $63aa
00638A  ; data: 0x73, 0x6f
00638C  movea.l $6f65(a3), a0
006390  bgt.b  $6400
006392  moveq  #$65, d2
006394  movea.l $6368(a1), a0
006398  movea.l $6965(a6), a0
00639C  movea.l ([$6e2c, a3]), a0
0063A2  movea.l -(a4), a0
0063A4  bcs.b  $6414
0063A6  bgt.b  $63c8
0063A8  bvs.b  $640d
0063AA  bvc.b  $63cc
0063AC  bhi.b  $6417
0063AE  bgt.b  $63d0
0063B0  moveq  #$69, d3
0063B2  bcs.b  $6420
0063B4  movea.l $d8d6(pc), a0
0063B8  ; data: 0x73, 0x65
0063BA  bvc.b  $642e
0063BC  move.l d0, d0
0063BE  movea.l -(a4), a0
0063C0  bsr.b  $6426
0063C2  moveq  #$61, d1
0063C4  ; data: 0x75, 0x66
0063C6  movea.l -(a6), a0
0063C8  bvs.b  $6442
0063CA  bvs.b  $6431
0063CC  moveq  #$74, d1
0063CE  movea.l -(a5), a0
0063D0  moveq  #$77, d2
0063D2  bsr.b  $6447
0063D4  movea.l $d8f6(pc), a0
0063D8  bcs.b  $644c
0063DA  moveq  #$65, d1
0063DC  bvs.b  $6441
0063DE  bvc.b  $6445
0063E0  bgt.b  $6402
0063E2  ; data: 0x75, 0x6e
0063E4  bcc.b  $6406
0063E6  moveq  #$69, d3
0063E8  bcs.b  $6456
0063EA  bge.b  $6451
0063EC  bvs.b  $6451
0063EE  bvc.b  $6464
0063F0  movea.l $6c61(a3), a0
0063F4  moveq  #$70, d0
0063F6  moveq  #$20, d2
0063F8  bcc.b  $645f
0063FA  ; data: 0x73, 0x77
0063FC  bcs.b  $6465
0063FE  bcs.b  $646e
006400  movea.l $7669(a3, d6.l * 8), a0
006406  bcs.b  $6474
006408  bcs.b  $647d
00640A  move.l d0, d0
00640C  movea.l $6963(a6), a0
006410  bvc.b  $6486
006412  move.l -(a0), d6
006414  bvs.b  $6479
006416  bvc.b  $6438
006418  blt.b  $647f
00641A  bvs.b  $648a
00641C  bcs.b  $643e
00641E  moveq  #$6f, d3
006420  moveq  #$61, d1
006422  bge.b  $6490
006424  bcs.b  $6493
006426  movea.l $756c(a3, invalid.w), a0
00642C  bvs.b  $64a1
00642E  bls.b  $6498
006430  bcs.b  $64a5
006432  move.l -(a0), d6
006434  bcc.b  $649b
006436  bgt.b  $64a6
006438  movea.l $6368(a1), a0
00643C  movea.l $6162(a0), a0
006440  bcs.b  $6462
006442  ; data: 0x73, 0x63
006444  bvc.b  $64b5
006446  bgt.b  $6468
006448  ; data: 0x73, 0x65
00644A  bvc.b  $64be
00644C  movea.l $6674(a7), a0
006450  movea.l -(a6), a0
006452  bcs.b  $64c7
006454  moveq  #$2d, d2
006456  move.l d0, d0
006458  movea.l -(a7), a0
00645A  bcs.b  $64cf
00645C  moveq  #$65, d2
00645E  bge.b  $64cc
006460  moveq  #$2c, d2
006462  movea.l -(a4), a0
006464  bsr.b  $64d9
006466  ; data: 0x73, 0x20
006468  ; data: 0x77, 0x65
00646A  bgt.b  $64da
00646C  movea.l $616e(a5), a0
006470  movea.l -(a4), a0
006472  bcs.b  $64e1
006474  movea.l -(a7), a0
006476  bcs.b  $64e1
006478  ; data: 0x73, 0x74
00647A  movea.l -(a5), a0
00647C  bvs.b  $64ec
00647E  bne.b  $64e1
006480  bls.b  $64ea
006482  movea.l -(a6), a0
006484  moveq  #$65, d1
006486  bvs.b  $64ed
006488  bgt.b  $64aa
00648A  bge.b  $64ed
00648C  ; data: 0x75, 0x66
00648E  movea.l -(a7), a0
006490  bvs.b  $64f4
006492  moveq  #$2c, d2
006494  movea.l $6f6d(a3), a0
006498  blt.b  $650e
00649A  movea.l $616e(a5), a0
00649E  movea.l -(a1), a0
0064A0  ; data: 0x75, 0x66
0064A2  move.l d0, d0
0064A4  movea.l -(a2), a0
0064A6  bcs.b  $651b
0064A8  ; data: 0x73, 0x65
0064AA  moveq  #$65, d1
0064AC  movea.l -(a5), a0
0064AE  moveq  #$67, d1
0064B0  bcs.b  $6514
0064B2  bgt.b  $651d
0064B4  ; data: 0x73, 0x73
0064B6  bcs.b  $64e4
0064B8  movea.l -(a1), a0
0064BA  bge.b  $652f
0064BC  movea.l ([$6e20, a7]), a0
0064C2  blt.b  $6525
0064C4  bgt.b  $64e6
0064C6  ; data: 0x73, 0x69
0064C8  bls.b  $6532
0064CA  movea.l $61(a3, d7.w), a0
0064CE  bcs.b  $653e
0064D0  bcc.b  $653b
0064D2  beq.b  $64f4
0064D4  bcs.b  $653f
0064D6  bgt.b  $654a
0064D8  bcs.b  $653e
0064DA  bcs.b  $6550
0064DC  move.l -(a0), d6
0064DE  bcc.b  $6541
0064E0  ; data: 0x73, 0x73
0064E2  movea.l $616e(a5), a0
0064E6  movea.l -(a5), a0
0064E8  bvs.b  $6551
0064EA  bcs.b  $655a
0064EC  moveq  #$6c, d2
0064EE  bvs.b  $6553
0064F0  bvc.b  $6512
0064F2  ori.b  #$6c, -(a0)
0064F6  bge.b  $655d
0064F8  ; data: 0x73, 0x20
0064FA  bmi.b  $655d
0064FC  bgt.b  $656c
0064FE  movea.l $64(a5, d6.l), a0
006502  movea.l -(a1), a0
006504  bge.b  $6572
006506  bcs.b  $657b
006508  movea.l $6166(a3, invalid.w), a0
00650E  bne.b  $6575
006510  bgt.b  $6532
006512  ; data: 0x77, 0x69
006514  bge.b  $6582
006516  move.l -(a0), d7
006518  blt.b  $6583
00651A  moveq  #$6b, d1
00651C  ble.b  $653e
00651E  bvs.b  $6593
006520  moveq  #$20, d2
006522  bgt.b  $658d
006524  bls.b  $658e
006526  moveq  #$20, d2
006528  bsr.b  $659f
00652A  bne.b  $654c
00652C  ; data: 0x73, 0x65
00652E  bvs.b  $659e
006530  movea.l $ce97(pc), a0
006534  bge.b  $6556
006536  bne.b  $65a1
006538  moveq  #$69, d4
00653A  bcs.b  $65ae
00653C  moveq  #$2c, d2
00653E  move.l d0, d0
006540  movea.l $6465(a7), a0
006544  moveq  #$20, d1
006546  bcc.b  $65b7
006548  bls.b  $65b2
00654A  move.l -(a0), d6
00654C  bsr.b  $65b0
00654E  bcs.b  $65c2
006550  movea.l ([$6e20, a3]), a0
006556  moveq  #$69, d5
006558  bcs.b  $65c6
00655A  movea.l $7374(a1), a0
00655E  movea.l $6963(a6), a0
006562  bvc.b  $65d8
006564  movea.l $6569(a5), a0
006568  bgt.b  $658a
00656A  moveq  #$69, d5
00656C  bcs.b  $65da
00656E  move.l -(a0), d6
006570  ble.b  $65d6
006572  bcs.b  $65e6
006574  movea.l ([$6c20, a6]), a0
00657A  bhi.b  $65e1
00657C  ; data: 0x73, 0x73
00657E  bcs.b  $65f2
006580  move.l -(a0), d6
006582  ; data: 0x77, 0x69
006584  bcs.b  $65a6
006586  ori.b  #$63, -(a0)
00658A  bvc.b  $65fe
00658C  ble.b  $65f3
00658E  bcc.b  $65f5
006590  moveq  #$20, d1
006592  ; data: 0x73, 0x63
006594  bvc.b  $6605
006596  bgt.b  $65b8
006598  moveq  #$69, d3
00659A  bcs.b  $6608
00659C  movea.l -(a6), a0
00659E  moveq  #$75, d1
0065A0  bcs.b  $660a
0065A2  bcs.b  $6616
0065A4  movea.l -(a5), a0
0065A6  moveq  #$6b, d1
0065A8  bsr.b  $6618
0065AA  bgt.b  $6620
0065AC  movea.l $6174(a0), a0
0065B0  move.l -(a0), d6
0065B2  ; data: 0x73, 0x65
0065B4  bvs.b  $6624
0065B6  movea.l $cf1d(pc), a0
0065BA  bge.b  $65dc
0065BC  bvs.b  $6631
0065BE  moveq  #$20, d2
0065C0  ; data: 0x73, 0x65
0065C2  bvs.b  $6632
0065C4  movea.l ([$2c20, a7]), a0
0065CA  ble.b  $6630
0065CC  bcs.b  $6640
0065CE  move.l d0, d0
0065D0  movea.l $6269(a3, d6.l * 8), a0
0065D6  ; data: 0x73, 0x63
0065D8  bvc.b  $663f
0065DA  bgt.b  $65fc
0065DC  bgt.b  $663f
0065DE  bls.b  $6648
0065E0  movea.l -(a4), a0
0065E2  bcs.b  $6651
0065E4  movea.l $6f74(a5), a0
0065E8  moveq  #$6f, d2
0065EA  move.l -(a0), d6
0065EC  moveq  #$6f, d3
0065EE  bgt.b  $6610
0065F0  bcc.b  $6657
0065F2  bgt.b  $6614
0065F4  bne.b  $6657
0065F6  bgt.b  $666c
0065F8  bsr.b  $666d
0065FA  moveq  #$69, d2
0065FC  ; data: 0x73, 0x63
0065FE  bvc.b  $6665
006600  bgt.b  $6622
006602  move.w $8668(pc), d2
006606  bvs.b  $666d
006608  movea.l -(a2), a0
00660A  bvs.b  $667f
00660C  moveq  #$20, d2
00660E  bcc.b  $6679
006610  bcs.b  $6632
006612  bvc.b  $6675
006614  ; data: 0x75, 0x70
006616  moveq  #$66, d2
006618  bvs.b  $6681
00661A  ; data: 0x75, 0x72
00661C  move.l d0, d0
00661E  movea.l $6d20(a1), a0
006622  bcc.b  $6689
006624  blt.b  $6646
006626  bne.b  $6691
006628  bge.b  $6697
00662A  move.l -(a0), d6
00662C  bcc.b  $6693
00662E  ; data: 0x73, 0x73
006630  bcs.b  $66a0
006632  movea.l $616d(a6), a0
006636  bcs.b  $6658
006638  move.l $6569(a5), $6e20(a6)
00663E  bge.b  $66a5
006640  bhi.b  $66a7
006642  bgt.b  $6671
006644  movea.l $6175(a4), a0
006648  moveq  #$65, d2
00664A  moveq  #$2e, d2
00664C  movea.l -(a5), a0
00664E  bvs.b  $66be
006650  movea.l -(a2), a0
006652  bcs.b  $66bd
006654  ; data: 0x73, 0x70
006656  bvs.b  $66bd
006658  bge.b  $6694
00665A  movea.l $6368(a1), a0
00665E  movea.l $656c(a5), a0
006662  bcc.b  $66c9
006664  movea.l $6963(a5), a0
006668  bvc.b  $668a
00666A  ori.b  #$6d, -(a0)
00666E  movea.l $74(a5, d6.l), a0
006672  bcs.b  $66e6
006674  bvs.b  $66d9
006676  bvc.b  $66ec
006678  move.l -(a0), d6
00667A  ; data: 0x77, 0x65
00667C  bvs.b  $66ea
00667E  movea.l $6368(a1), a0
006682  movea.l -(a5), a0
006684  bvs.b  $66f4
006686  bcs.b  $66a8
006688  beq.b  $66ff
00668A  moveq  #$65, d2
00668C  movea.l $7565(a5), a0
006690  bgt.b  $66f6
006692  bge.b  $66fd
006694  bls.b  $66fe
006696  bcs.b  $66b8
006698  bgt.b  $6709
00669A  moveq  #$65, d2
00669C  movea.l $6162(a0), a0
0066A0  bcs.b  $6710
0066A2  movea.l $6c20(a7, invalid.w), a0
0066A8  ; data: 0x75, 0x6e
0066AA  bcc.b  $66cc
0066AC  blt.b  $6717
0066AE  moveq  #$6b, d1
0066B0  ble.b  $66d2
0066B2  ori.b  #$65, -(a0)
0066B6  bge.b  $671c
0066B8  bcs.b  $672e
0066BA  movea.l ([$6820, a3], $7765696c), a0
0066C4  movea.l -(a5), a0
0066C6  moveq  #$20, d1
0066C8  ; data: 0x77, 0x61
0066CA  ; data: 0x73, 0x20
0066CC  moveq  #$75, d5
0066CE  movea.l ([$656e, a3]), a0
0066D4  movea.l $6174(a0), a0
0066D8  move.l -(a0), d7
0066DA  bgt.b  $673d
0066DC  moveq  #$75, d2
0066DE  bcs.b  $6752
0066E0  bge.b  $674b
0066E2  bls.b  $674c
0066E4  movea.l $616e(a3), a0
0066E8  bgt.b  $670a
0066EA  bcc.b  $674d
0066EC  ; data: 0x73, 0x20
0066EE  bsr.b  $675c
0066F0  bge.b  $6757
0066F2  ; data: 0x73, 0x20
0066F4  bcs.b  $675f
0066F6  bgt.b  $675a
0066F8  bvs.b  $6766
0066FA  bcc.b  $6771
0066FC  bgt.b  $6765
0066FE  move.l d0, d0
006700  movea.l ([$6e2c, a3]), a0
006706  movea.l -(a1), a0
006708  bhi.b  $676f
00670A  moveq  #$20, d1
00670C  bcc.b  $676f
00670E  ; data: 0x73, 0x20
006710  bvs.b  $6785
006712  moveq  #$20, d2
006714  bgt.b  $678b
006716  bgt.b  $6738
006718  blt.b  $677f
00671A  bvs.b  $678a
00671C  movea.l -(a5), a0
00671E  bvs.b  $678e
006720  bcc.b  $6794
006722  ; data: 0x75, 0x63
006724  bmi.b  $6746
006726  ; data: 0x75, 0x6e
006728  bcc.b  $674a
00672A  bvs.b  $678f
00672C  bvc.b  $674e
00672E  ; data: 0x77, 0x65
006730  bvs.b  $67a5
006732  ; data: 0x73, 0x2c
006734  movea.l -(a4), a0
006736  bsr.b  $67ab
006738  ; data: 0x73, 0x20
00673A  bcc.b  $679d
00673C  ; data: 0x73, 0x20
00673E  move.w -(a0), d1
006740  bsr.b  $67b7
006742  bne.b  $6764
006744  bpl.b  $67ab
006746  bcc.b  $67ad
006748  bgt.b  $676a
00674A  ori.b  #$61, -(a0)
00674E  bge.b  $67bc
006750  movea.l ([$6874, a2], $69676572), a0
00675A  movea.l $7374(a1), a0
00675E  move.l -(a0), d6
006760  bsr.b  $67d7
006762  bls.b  $67cc
006764  movea.l ([$6e20, a7]), a0
00676A  blt.b  $67d5
00676C  moveq  #$6b, d1
00676E  ble.b  $6790
006770  bgt.b  $67db
006772  bls.b  $67dc
006774  moveq  #$20, d2
006776  ; data: 0x73, 0x6f
006778  movea.l -(a4), a0
00677A  bcs.b  $67ea
00677C  bmi.b  $67f2
00677E  move.l -(a0), d7
006780  ; data: 0x75, 0x6e
006782  bcc.b  $67a4
006784  bcc.b  $67e7
006786  ; data: 0x73, 0x20
006788  blt.b  $67ef
00678A  bvs.b  $67fa
00678C  bcs.b  $67ae
00678E  bvs.b  $67f3
006790  bvc.b  $67b2
006792  blt.b  $67fd
006794  moveq  #$3a, d2
006796  move.l d0, d0
006798  movea.l -(a4), a0
00679A  bcs.b  $6809
00679C  movea.l -(a7), a0
00679E  bcs.b  $6809
0067A0  ; data: 0x73, 0x74
0067A2  movea.l -(a6), a0
0067A4  moveq  #$65, d1
0067A6  bvs.b  $680d
0067A8  bgt.b  $67ca
0067AA  bge.b  $680d
0067AC  ; data: 0x75, 0x66
0067AE  movea.l -(a7), a0
0067B0  bcs.b  $6814
0067B2  bcs.b  $6822
0067B4  move.l -(a0), d7
0067B6  ; data: 0x73, 0x69
0067B8  bls.b  $6822
0067BA  movea.l $7572(a6), a0
0067BE  movea.l -(a1), a0
0067C0  ; data: 0x75, 0x66
0067C2  movea.l ([$6820, a3], $73656c62), a0
0067CC  ; data: 0x73, 0x74
0067CE  movea.l $6f6e(a3), a0
0067D2  moveq  #$65, d5
0067D4  bgt.b  $684a
0067D6  moveq  #$69, d1
0067D8  bcs.b  $684c
0067DA  bcs.b  $684a
0067DC  move.l -(a0), d7
0067DE  ori.b  #$6e, -(a0)
0067E2  movea.l ([$6c65, a6]), a0
0067E8  bgt.b  $680a
0067EA  bne.b  $684d
0067EC  bcs.b  $685a
0067EE  bge.b  $6855
0067F0  bgt.b  $6812
0067F2  ; data: 0x75, 0x65
0067F4  bhi.b  $685b
0067F6  moveq  #$65, d1
0067F8  bvs.b  $6868
0067FA  ; data: 0x73, 0x74
0067FC  bvs.b  $686b
0067FE  blt.b  $6874
006800  movea.l -(a4), a0
006802  bsr.b  $6877
006804  movea.l -(a4), a0
006806  bcs.b  $6876
006808  bmi.b  $686f
00680A  bgt.b  $682c
00680C  bgt.b  $6877
00680E  bls.b  $6878
006810  moveq  #$20, d2
006812  blt.b  $687d
006814  moveq  #$20, d2
006816  blt.b  $687d
006818  bvs.b  $6888
00681A  bcs.b  $6889
00681C  movea.l $d183(pc), a0
006820  bge.b  $684e
006822  movea.l -(a4), a0
006824  movea.l $2e20(a0), a7
006828  ori.b  #$65, -(a0)
00682C  moveq  #$20, d1
00682E  moveq  #$75, d5
006830  bmi.b  $68a7
006832  bgt.b  $689a
006834  moveq  #$2c, d2
006836  movea.l ([$6c20, a7]), a0
00683C  blt.b  $68a3
00683E  bvs.b  $68ae
006840  movea.l $d1a7(pc), a0
006844  bge.b  $6866
006846  bcc.b  $68b1
006848  bcs.b  $686a
00684A  moveq  #$75, d5
00684C  bmi.b  $68c3
00684E  bgt.b  $68b6
006850  moveq  #$20, d2
006852  ; data: 0x75, 0x6e
006854  bcc.b  $6876
006856  bgt.b  $68c1
006858  bls.b  $68c2
00685A  moveq  #$20, d2
00685C  bcc.b  $68c7
00685E  bcs.b  $6880
006860  beq.b  $68c7
006862  beq.b  $68c9
006864  bgt.b  $68dd
006866  bsr.b  $68da
006868  moveq  #$20, d2
00686A  bvs.b  $68df
00686C  moveq  #$2c, d2
00686E  move.l d0, d0
006870  movea.l -(a4), a0
006872  bcs.b  $68e7
006874  ; data: 0x77, 0x65
006876  beq.b  $68dd
006878  bgt.b  $689a
00687A  beq.b  $68e1
00687C  bvc.b  $68e3
00687E  movea.l $6368(a1), a0
006882  movea.l -(a5), a0
006884  bvs.b  $68ed
006886  bcs.b  $68f6
006888  moveq  #$6c, d2
00688A  bvs.b  $68ef
00688C  bvc.b  $68ae
00688E  bcc.b  $68f5
006890  bgt.b  $68b2
006892  bne.b  $68f5
006894  bge.b  $6909
006896  bls.b  $6900
006898  bcs.b  $6908
00689A  movea.l ([$2c20, a7]), a0
0068A0  bvs.b  $6905
0068A2  bvc.b  $68c4
0068A4  bhi.b  $690b
0068A6  bne.b  $6911
0068A8  bgt.b  $690e
0068AA  bcs.b  $68cc
0068AC  blt.b  $6917
0068AE  bls.b  $6918
0068B0  movea.l $6d6d(a1), a0
0068B4  bcs.b  $6928
0068B6  movea.l $6e20(a1), a0
0068BA  ori.b  #$69, -(a0)
0068BE  bgt.b  $6925
0068C0  blt.b  $68e2
0068C2  moveq  #$77, d5
0068C4  bvs.b  $692b
0068C6  ; data: 0x73, 0x70
0068C8  bsr.b  $6936
0068CA  moveq  #$2e, d2
0068CC  movea.l $6368(a1), a0
0068D0  movea.l -(a5), a0
0068D2  moveq  #$6b, d1
0068D4  bcs.b  $6944
0068D6  bgt.b  $693d
0068D8  movea.l -(a4), a0
0068DA  bvs.b  $6941
0068DC  movea.l $6f(a0, d7.w), a0
0068E0  bhi.b  $694e
0068E2  bcs.b  $6951
0068E4  bsr.b  $695a
0068E6  bvs.b  $6953
0068E8  move.l -(a0), d6
0068EA  bcc.b  $691a
0068EC  bvc.b  $691c
0068EE  movea.l $6569(a5), a0
0068F2  bgt.b  $6959
0068F4  movea.l -(a6), a0
0068F6  bcs.b  $6960
0068F8  bge.b  $695f
0068FA  moveq  #$2c, d1
0068FC  movea.l -(a1), a0
0068FE  bhi.b  $6965
006900  moveq  #$20, d1
006902  ori.b  #$63, -(a0)
006906  bvc.b  $6928
006908  ; data: 0x77, 0x69
00690A  bge.b  $6978
00690C  movea.l ([$206e, a3]), a0
006912  bvs.b  $6977
006914  bvc.b  $698a
006916  movea.l ([$62657373, a6], $6572), a0
006920  bgt.b  $6950
006922  movea.l -(a4), a0
006924  bcs.b  $6999
006926  ; data: 0x77, 0x65
006928  beq.b  $698f
00692A  bgt.b  $694c
00692C  bmi.b  $698f
00692E  bgt.b  $699e
006930  movea.l $6368(a1), a0
006934  movea.l $6972(a5), a0
006938  movea.l ([$7374656c, a6], $6c65), a0
006942  bgt.b  $6970
006944  movea.l -(a4), a0
006946  bsr.b  $69bb
006948  ; data: 0x73, 0x20
00694A  move.l d0, d0
00694C  movea.l $6368(a1), a0
006950  movea.l $6e20(a1), a0
006954  blt.b  $69bf
006956  moveq  #$6b, d1
006958  ble.b  $69cd
00695A  movea.l -(a1), a0
00695C  ; data: 0x75, 0x67
00695E  bcs.b  $69ce
006960  movea.l -(a5), a0
006962  bvs.b  $69d2
006964  movea.l $6c65(a3, invalid.w), a0
00696A  bls.b  $69d4
00696C  moveq  #$65, d2
00696E  moveq  #$20, d1
006970  bhi.b  $69db
006972  bgt.b  $69a2
006974  move.l d0, d0
006976  move.l -(a0), d0
006978  ori.b  #$33, -(a0)
00697C  move.l ([$206b6972, a1, d3.w], $7374), d7
006986  bcs.b  $69f6
006988  movea.l $7374(a1), a0
00698C  movea.l $6974(a5), a0
006990  movea.l $726f(a3, invalid.w), a0
006996  bcs.b  $69fc
006998  bcs.b  $6a0c
00699A  movea.l $df0f(pc), a0
00699E  bsr.b  $6a0d
0069A0  blt.b  $6a07
0069A2  bgt.b  $69d0
0069A4  movea.l -(a1), a0
0069A6  moveq  #$74, d1
0069A8  bcs.b  $69ca
0069AA  bvs.b  $6a1f
0069AC  moveq  #$20, d2
0069AE  bvs.b  $6a1d
0069B0  blt.b  $6a17
0069B2  moveq  #$20, d1
0069B4  bgt.b  $6a25
0069B6  bls.b  $6a20
0069B8  movea.l $6963(a6), a0
0069BC  bvc.b  $6a32
0069BE  move.l d0, d0
0069C0  movea.l -(a6), a0
0069C2  bcs.b  $6a36
0069C4  moveq  #$69, d2
0069C6  beq.b  $69e8
0069C8  ; data: 0x75, 0x6e
0069CA  bcc.b  $69ec
0069CC  bcc.b  $6a37
0069CE  bcs.b  $69f0
0069D0  ; data: 0x77, 0x6f
0069D2  bls.b  $6a01
0069D4  moveq  #$61, d0
0069D6  moveq  #$74, d1
0069D8  ; data: 0x79, 0x20
0069DA  bvs.b  $6a4f
0069DC  moveq  #$20, d2
0069DE  beq.b  $6a45
0069E0  moveq  #$6c, d0
0069E2  bsr.b  $6a58
0069E4  moveq  #$74, d5
0069E6  move.l -(a1), d0
0069E8  move.l -(a1), -(a0)
0069EA  move.l d0, d0
0069EC  move.l -(a0), d0
0069EE  ori.b  #$65, -(a0)
0069F2  bgt.b  $6a62
0069F4  ble.b  $6a59
0069F6  bvc.b  $6a18
0069F8  beq.b  $6a66
0069FA  bsr.b  $6a71
0069FC  bhi.b  $6a63
0069FE  movea.l $6368(a1), a0
006A02  movea.l -(a7), a0
006A04  bge.b  $6a7b
006A06  bcs.b  $6a6b
006A08  bmi.b  $6a76
006A0A  bvs.b  $6a6f
006A0C  bvc.b  $6a2e
006A0E  moveq  #$75, d5
006A10  movea.l ([$6e2e, a3]), a0
006A16  movea.l $6368(a1), a0
006A1A  movea.l ([$7373, a7]), a0
006A20  movea.l $e183(pc), a0
006A24  moveq  #$20, d1
006A26  bgt.b  $6a91
006A28  bls.b  $6a92
006A2A  moveq  #$20, d2
006A2C  ; data: 0x77, 0x61
006A2E  moveq  #$75, d1
006A30  blt.b  $6a5e
006A32  movea.l -(a1), a0
006A34  bhi.b  $6a9b
006A36  moveq  #$20, d1
006A38  ori.b  #$63, -(a0)
006A3C  bvc.b  $6a5e
006A3E  bne.b  $6ab2
006A40  bcs.b  $6ab7
006A42  bcs.b  $6a64
006A44  blt.b  $6aaf
006A46  bls.b  $6ab0
006A48  movea.l -(a6), a0
006A4A  ; data: 0x75, 0x65
006A4C  moveq  #$20, d1
006A4E  ; data: 0x73, 0x63
006A50  bvc.b  $6ac4
006A52  ble.b  $6ab9
006A54  bcc.b  $6abb
006A56  moveq  #$20, d1
006A58  ; data: 0x75, 0x6e
006A5A  bcc.b  $6a7c
006A5C  ; data: 0x73, 0x65
006A5E  bvs.b  $6ace
006A60  movea.l -(a7), a0
006A62  bge.b  $6ad9
006A64  bcs.b  $6ac9
006A66  bmi.b  $6a88
006A68  bvs.b  $6add
006A6A  moveq  #$20, d2
006A6C  blt.b  $6ad3
006A6E  bvs.b  $6ade
006A70  movea.l -(a7), a0
006A72  bge.b  $6ae9
006A74  bcs.b  $6ad9
006A76  bmi.b  $6aa6
006A78  movea.l -(a1), a0
006A7A  bls.b  $6ae4
006A7C  movea.l $612c(a2), a0
006A80  move.l d0, d0
006A82  movea.l $6368(a1), a0
006A86  movea.l -(a2), a0
006A88  bvs.b  $6af8
006A8A  movea.l $6d6d(a1), a0
006A8E  bcs.b  $6b02
006A90  movea.l $6f63(a6), a0
006A94  bvc.b  $6ab6
006A96  bmi.b  $6b0a
006A98  bsr.b  $6b08
006A9A  bmi.b  $6abc
006A9C  ; data: 0x75, 0x6e
006A9E  bcc.b  $6ac0
006AA0  ; data: 0x77, 0x61
006AA2  moveq  #$20, d1
006AA4  bgt.b  $6b0f
006AA6  bls.b  $6b10
006AA8  moveq  #$20, d2
006AAA  blt.b  $6b11
006AAC  bvc.b  $6b20
006AAE  movea.l $6575(a0), a0
006AB2  moveq  #$65, d2
006AB4  move.l -(a0), d6
006AB6  ; data: 0x77, 0x65
006AB8  bvs.b  $6b26
006ABA  movea.l $6f6e(a3, invalid.w), a0
006AC0  move.l $3a(a0, d3.w), d0
006AC4  move.w $20(a1, d2.l), d0
006AC8  ori.b  #$65, -(a0)
006ACC  bvs.b  $6b3b
006ACE  movea.l -(a1), a0
006AD0  moveq  #$7a, d1
006AD2  moveq  #$20, d2
006AD4  ; data: 0x75, 0x6e
006AD6  bcc.b  $6af8
006AD8  bvc.b  $6b3b
006ADA  bhi.b  $6b41
006ADC  movea.l -(a2), a0
006ADE  bvs.b  $6b53
006AE0  movea.l -(a6), a0
006AE2  moveq  #$65, d1
006AE4  bvs.b  $6b5a
006AE6  bsr.b  $6b4f
006AE8  movea.l -(a6), a0
006AEA  moveq  #$65, d1
006AEC  bvs.b  $6b1c
006AEE  movea.l -(a6), a0
006AF0  ble.b  $6b5e
006AF2  beq.b  $6b59
006AF4  move.w -(a0), d5
006AF6  bcs.b  $6b6a
006AF8  bcc.b  $6b65
006AFA  ; data: 0x75, 0x6e
006AFC  bcc.b  $6b63
006AFE  movea.l $6963(a6), a0
006B02  bvc.b  $6b78
006B04  movea.l $6974(a5), a0
006B08  beq.b  $6b6f
006B0A  ; data: 0x73, 0x63
006B0C  bvc.b  $6b80
006B0E  bvs.b  $6b75
006B10  bhi.b  $6b77
006B12  bgt.b  $6b42
006B14  move.l d0, d0
006B16  movea.l -(a4), a0
006B18  bsr.b  $6b8d
006B1A  movea.l $7374(a1), a0
006B1E  movea.l $6f6e(a3, invalid.w), a0
006B24  movea.l -(a4), a0
006B26  bvs.b  $6b8d
006B28  move.l $61(a2, d2.w), d0
006B2C  moveq  #$62, d1
006B2E  bcs.b  $6b99
006B30  moveq  #$2c, d2
006B32  movea.l -(a4), a0
006B34  bvs.b  $6b9b
006B36  movea.l $6368(a1), a0
006B3A  movea.l $6963(a6), a0
006B3E  bvc.b  $6bb4
006B40  movea.l $6974(a5), a0
006B44  ; data: 0x73, 0x63
006B46  bvc.b  $6bba
006B48  bcs.b  $6bb3
006B4A  bhi.b  $6bb1
006B4C  move.l -(a0), d7
006B4E  ; data: 0x77, 0x61
006B50  ; data: 0x73, 0x20
006B52  ; data: 0x73, 0x6f
006B54  bge.b  $6bc2
006B56  ; data: 0x73, 0x2e
006B58  movea.l $6368(a1), a0
006B5C  move.l d0, d0
006B5E  movea.l $6569(a3, invalid.w), a0
006B64  ; data: 0x73, 0x73
006B66  movea.l -(a1), a0
006B68  ; data: 0x75, 0x66
006B6A  movea.l -(a4), a0
006B6C  bvs.b  $6bd3
006B6E  movea.l $756c(a3, invalid.w), a0
006B74  bcs.b  $6b96
006B76  move.l $2e20(a6), d7
006B7A  bvs.b  $6bdf
006B7C  bvc.b  $6b9e
006B7E  bvc.b  $6be1
006B80  bhi.b  $6be7
006B82  movea.l $6120(a2), a0
006B86  ; data: 0x73, 0x63
006B88  bvc.b  $6bf9
006B8A  bgt.b  $6bac
006B8C  move.w $3620(a6), -(a0)
006B90  bcc.b  $6c07
006B92  moveq  #$63, d1
006B94  bvc.b  $6c09
006B96  bls.b  $6c00
006B98  bgt.b  $6c03
006B9A  moveq  #$74, d2
006B9C  move.l $2e2e(a6), d0
006BA0  move.l d0, d0
006BA2  movea.l ([$206b, a7]), a0
006BA8  ble.b  $6c17
006BAA  blt.b  $6c20
006BAC  movea.l -(a4), a0
006BAE  bsr.b  $6c23
006BB0  move.l -(a0), d6
006BB2  bcc.b  $6c15
006BB4  ; data: 0x73, 0x73
006BB6  movea.l $6368(a1), a0
006BBA  movea.l $6f6e(a3, invalid.w), a0
006BC0  movea.l $6c61(a3, d6.l * 8), a0
006BC6  bgt.b  $6c2f
006BC8  bcs.b  $6bea
006BCA  bgt.b  $6c35
006BCC  bls.b  $6c36
006BCE  moveq  #$20, d2
006BD0  blt.b  $6c37
006BD2  bvc.b  $6c46
006BD4  movea.l -(a7), a0
006BD6  bcs.b  $6c4b
006BD8  bls.b  $6c42
006BDA  moveq  #$69, d1
006BDC  bcs.b  $6c40
006BDE  bcs.b  $6c4e
006BE0  movea.l $6162(a0), a0
006BE4  bcs.b  $6c06
006BE6  ; data: 0x3f, 0x3f
006BE8  move.w -(a0), -(a7)
006BEA  ori.b  #$6f, -(a0)
006BEE  bgt.b  $6c64
006BF0  bsr.b  $6c59
006BF2  move.l -(a0), d6
006BF4  ; data: 0x73, 0x63
006BF6  bvc.b  $6c6d
006BF8  bge.b  $6c5f
006BFA  move.l -(a0), d6
006BFC  bcc.b  $6c67
006BFE  bcs.b  $6c6e
006C00  ; data: 0x73, 0x74
006C02  bsr.b  $6c6b
006C04  move.l -(a0), d6
006C06  ; data: 0x73, 0x63
006C08  bvc.b  $6c7f
006C0A  bge.b  $6c71
006C0C  movea.l $64(a5, d6.l), a0
006C10  movea.l $e37b(pc), a0
006C14  ; data: 0x73, 0x63
006C16  bvc.b  $6c7d
006C18  bgt.b  $6c7e
006C1A  ; data: 0x75, 0x72
006C1C  bls.b  $6c86
006C1E  movea.l -(a1), a0
006C20  moveq  #$74, d1
006C22  bcs.b  $6c44
006C24  move.l -(a0), -(a6)
006C26  bcc.b  $6c89
006C28  ; data: 0x73, 0x20
006C2A  bvs.b  $6c9f
006C2C  moveq  #$20, d2
006C2E  bcs.b  $6c99
006C30  bgt.b  $6c97
006C32  move.l d0, d0
006C34  movea.l $61(a3, d7.w), a0
006C38  moveq  #$6b, d1
006C3A  bcs.b  $6c5c
006C3C  blt.b  $6ca7
006C3E  ; data: 0x73, 0x63
006C40  bvc.b  $6cb7
006C42  bgt.b  $6cab
006C44  move.l -(a0), d6
006C46  bcc.b  $6cb1
006C48  bcs.b  $6c6a
006C4A  bgt.b  $6cb5
006C4C  bls.b  $6cb6
006C4E  moveq  #$20, d2
006C50  bpl.b  $6cb7
006C52  bcc.b  $6cb9
006C54  moveq  #$20, d1
006C56  moveq  #$65, d3
006C58  moveq  #$74, d1
006C5A  moveq  #$61, d1
006C5C  bcs.b  $6cc5
006C5E  moveq  #$2e, d2
006C60  movea.l $6368(a1), a0
006C64  movea.l $9ac8(pc), a0
006C68  move.l -(a0), d7
006C6A  bgt.b  $6cd5
006C6C  bls.b  $6cd6
006C6E  moveq  #$2e, d2
006C70  move.l d0, d0
006C72  move.l -(a0), d0
006C74  ori.b  #$6d, -(a0)
006C78  movea.l $6f6e(a5), a0
006C7C  moveq  #$61, d2
006C7E  beq.b  $6ca0
006C80  ; data: 0x77, 0x61
006C82  moveq  #$20, d1
006C84  bcc.b  $6ceb
006C86  moveq  #$20, d1
006C88  beq.b  $6cfc
006C8A  ble.b  $6cff
006C8C  ; data: 0x73, 0x65
006C8E  movea.l ([$3a20, a4]), a0
006C94  bcc.b  $6cff
006C96  bcs.b  $6cb8
006C98  beq.b  $6cff
006C9A  ; data: 0x73, 0x63
006C9C  bvc.b  $6d03
006C9E  bgt.b  $6d0b
006CA0  bcs.b  $6ccf
006CA2  ; data: 0x75, 0x65
006CA4  bhi.b  $6d0b
006CA6  moveq  #$72, d1
006CA8  bcs.b  $6d13
006CAA  bls.b  $6d14
006CAC  ; data: 0x75, 0x6e
006CAE  beq.b  $6cd0
006CB0  move.l -(a1), -(a0)
006CB2  move.l -(a0), -(a0)
006CB4  ori.b  #$63, -(a0)
006CB8  bvc.b  $6cda
006CBA  bvc.b  $6d1d
006CBC  bhi.b  $6d23
006CBE  movea.l -(a5), a0
006CC0  bvs.b  $6d30
006CC2  move.l $6469(a5), d0
006CC6  bgt.b  $6d2f
006CC8  move.l -(a0), -(a6)
006CCA  bsr.b  $6d41
006CCC  ; data: 0x73, 0x20
006CCE  bcs.b  $6d39
006CD0  ; data: 0x73, 0x65
006CD2  bgt.b  $6cf4
006CD4  ; data: 0x75, 0x6e
006CD6  bcc.b  $6cf8
006CD8  bcs.b  $6d43
006CDA  bgt.b  $6cfc
006CDC  moveq  #$69, d1
006CDE  bcs.b  $6d53
006CE0  bcs.b  $6d50
006CE2  bne.b  $6d53
006CE4  moveq  #$6f, d2
006CE6  movea.l -(a7), a0
006CE8  bcs.b  $6d55
006CEA  moveq  #$69, d1
006CEC  bcs.b  $6d55
006CEE  moveq  #$2e, d2
006CF0  move.l d0, d0
006CF2  movea.l -(a5), a0
006CF4  bls.b  $6d5e
006CF6  moveq  #$20, d2
006CF8  bge.b  $6d6f
006CFA  ; data: 0x73, 0x74
006CFC  bvs.b  $6d65
006CFE  move.l -(a0), d7
006D00  ori.b  #$0, -(a0)
006D04  move.l -(a0), d0
006D06  move.l -(a0), d0
006D08  move.l -(a0), d0
006D0A  move.l -(a0), d0
006D0C  move.l -(a0), d0
006D0E  move.l -(a0), d0
006D10  move.l -(a0), d0
006D12  move.l -(a0), d0
006D14  move.l -(a0), d0
006D16  move.l -(a0), d0
006D18  move.l -(a0), d0
006D1A  move.l -(a0), d0
006D1C  move.l -(a0), d0
006D1E  move.l -(a0), d0
006D20  move.l $30(a0, d3.w), d0
006D24  move.w $20(a0, d2.w), d0
006D28  move.l -(a0), d0
006D2A  move.l -(a0), d0
006D2C  move.l -(a0), d0
006D2E  move.l -(a0), d0
006D30  move.l -(a0), d0
006D32  move.l -(a0), d0
006D34  ori.b  #$20, -(a0)
006D38  move.l -(a0), d0
006D3A  move.l -(a0), d0
006D3C  move.l -(a0), d0
006D3E  move.l -(a0), d0
006D40  move.l -(a0), d0
006D42  move.l -(a0), d0
006D44  move.l -(a0), d0
006D46  move.l -(a0), d0
006D48  move.l -(a0), d0
006D4A  move.l -(a0), d0
006D4C  move.l -(a0), d0
006D4E  move.l -(a0), d0
006D50  move.l $20(a0, d2.w), d0
006D54  move.w -(a0), -(a7)
006D56  move.l $20(a0, d2.w), d0
006D5A  move.l -(a0), d0
006D5C  move.l -(a0), d0
006D5E  move.l -(a0), d0
006D60  move.l -(a0), d0
006D62  move.l -(a0), d0
006D64  move.l d0, d0
006D66  move.l -(a0), d0
006D68  move.l -(a0), d0
006D6A  move.l -(a0), d0
006D6C  move.l -(a0), d0
006D6E  move.l -(a0), d0
006D70  move.l -(a0), d0
006D72  move.l -(a0), d0
006D74  move.l -(a0), d0
006D76  move.l -(a0), d0
006D78  move.l -(a0), d0
006D7A  move.l -(a0), d0
006D7C  move.l -(a0), d0
006D7E  move.l -(a0), d0
006D80  move.l $20(a0, d2.w), d0
006D84  move.l -(a0), d0
006D86  move.l -(a0), d0
006D88  move.l $20(a0, d2.w), d0
006D8C  move.l -(a0), d0
006D8E  move.l -(a0), d0
006D90  move.l -(a0), d0
006D92  move.l -(a0), d0
006D94  move.l -(a0), d0
006D96  move.l d0, d0
006D98  move.l -(a0), d0
006D9A  move.l -(a0), d0
006D9C  move.l -(a0), d0
006D9E  move.l -(a0), d0
006DA0  move.l -(a0), d0
006DA2  move.l -(a0), d0
006DA4  move.l -(a0), d0
006DA6  move.l -(a0), d0
006DA8  move.l -(a0), d0
006DAA  move.l -(a0), d0
006DAC  move.l -(a0), d0
006DAE  move.l -(a0), d0
006DB0  move.l -(a0), d0
006DB2  move.w $20(a0, d2.w), d0
006DB6  move.l -(a0), d0
006DB8  move.l -(a0), d0
006DBA  move.w $20(a0, d3.w), d0
006DBE  move.l -(a0), d0
006DC0  move.l -(a0), d0
006DC2  move.l -(a0), d0
006DC4  move.l -(a0), d0
006DC6  move.l -(a0), d0
006DC8  move.l -(a0), d0
006DCA  ori.b  #$20, -(a0)
006DCE  move.l -(a0), d0
006DD0  move.l -(a0), d0
006DD2  move.l -(a0), d0
006DD4  move.l -(a0), d0
006DD6  move.l -(a0), d0
006DD8  move.l -(a0), d0
006DDA  move.l -(a0), d0
006DDC  move.l -(a0), d0
006DDE  move.l -(a0), d0
006DE0  move.l -(a0), d0
006DE2  move.l -(a0), d0
006DE4  move.l $30(a0, d2.w), d0
006DE8  move.w $30(a0, d3.w), d0
006DEC  move.w $30(a0, d2.w), d0
006DF0  move.l -(a0), d0
006DF2  move.l -(a0), d0
006DF4  move.l -(a0), d0
006DF6  move.l -(a0), d0
006DF8  move.l -(a0), d0
006DFA  move.l -(a0), d0
006DFC  ori.b  #$20, -(a0)
006E00  move.l -(a0), d0
006E02  move.l -(a0), d0
006E04  move.l -(a0), d0
006E06  move.l -(a0), d0
006E08  move.l -(a0), d0
006E0A  move.l -(a0), d0
006E0C  move.l -(a0), d0
006E0E  move.l -(a0), d0
006E10  move.l -(a0), d0
006E12  move.l -(a0), d0
006E14  move.l -(a0), d0
006E16  move.l -(a0), d0
006E18  move.w -(a0), d0
006E1A  move.l -(a1), d0
006E1C  move.l -(a0), d0
006E1E  move.l -(a0), d0
006E20  move.w -(a0), d0
006E22  move.l -(a0), d0
006E24  move.l -(a0), d0
006E26  move.l -(a0), d0
006E28  move.l -(a0), d0
006E2A  move.l -(a0), d0
006E2C  move.l d0, d0
006E2E  move.l -(a0), d0
006E30  move.l -(a0), d0
006E32  move.l -(a0), d0
006E34  move.l -(a0), d0
006E36  move.l -(a0), d0
006E38  move.l -(a0), d0
006E3A  move.l -(a0), d0
006E3C  move.l -(a0), d0
006E3E  move.l -(a0), d0
006E40  move.l -(a0), d0
006E42  move.l -(a0), d0
006E44  move.l -(a0), d0
006E46  move.l -(a0), d0
006E48  move.l -(a0), d0
006E4A  move.w -(a0), d0
006E4C  move.l -(a0), d0
006E4E  move.l -(a0), d0
006E50  move.l $20(a0, d2.w), d0
006E54  move.l -(a0), d0
006E56  move.l -(a0), d0
006E58  move.l -(a0), d0
006E5A  move.l -(a0), d0
006E5C  move.l -(a0), d0
006E5E  move.l d0, d0
006E60  move.l -(a0), d0
006E62  move.l -(a0), d0
006E64  move.l -(a0), d0
006E66  move.l -(a0), d0
006E68  move.l -(a0), d0
006E6A  move.l -(a0), d0
006E6C  move.l -(a0), d0
006E6E  move.l -(a0), d0
006E70  move.l -(a0), d0
006E72  move.l -(a0), d0
006E74  move.l -(a0), d0
006E76  move.l -(a0), d0
006E78  move.l -(a0), d0
006E7A  move.l $20(a0, d2.w), d0
006E7E  move.l -(a0), d0
006E80  move.l -(a0), d0
006E82  move.l $20(a0, d2.w), d0
006E86  move.l -(a0), d0
006E88  move.l -(a0), d0
006E8A  move.l -(a0), d0
006E8C  move.l -(a0), d0
006E8E  move.l -(a0), d0
006E90  move.l d0, d0
006E92  move.l -(a0), d0
006E94  move.l -(a0), d0
006E96  move.l -(a0), d0
006E98  move.l -(a0), d0
006E9A  move.l -(a0), d0
006E9C  move.l -(a0), d0
006E9E  move.l -(a0), d0
006EA0  move.l -(a0), d0
006EA2  move.l -(a0), d0
006EA4  move.l -(a0), d0
006EA6  move.l -(a0), d0
006EA8  move.l -(a0), d0
006EAA  move.l -(a0), d0
006EAC  move.l -(a0), d0
006EAE  move.w $2020(a6), d0
006EB2  move.l -(a0), d0
006EB4  move.l -(a0), d0
006EB6  move.w -(a0), d0
006EB8  move.l -(a0), d0
006EBA  move.l -(a0), d0
006EBC  move.l -(a0), d0
006EBE  move.l -(a0), d0
006EC0  move.l -(a0), d0
006EC2  move.l d0, d0
006EC4  move.l -(a0), d0
006EC6  move.l -(a0), d0
006EC8  move.l -(a0), d0
006ECA  move.l -(a0), d0
006ECC  move.l -(a0), d0
006ECE  move.l -(a0), d0
006ED0  move.l -(a0), d0
006ED2  move.l -(a0), d0
006ED4  move.l -(a0), d0
006ED6  move.l -(a0), d0
006ED8  move.l -(a0), d0
006EDA  move.l -(a0), d0
006EDC  move.l -(a0), d0
006EDE  move.l -(a0), d0
006EE0  move.w -(a0), d0
006EE2  move.l -(a0), d0
006EE4  move.l -(a0), d0
006EE6  move.l $20(a0, d2.w), d7
006EEA  move.l -(a0), d0
006EEC  move.l -(a0), d0
006EEE  move.l -(a0), d0
006EF0  move.l -(a0), d0
006EF2  move.l -(a0), d0
006EF4  move.l d0, d0
006EF6  move.l -(a0), d0
006EF8  move.l -(a0), d0
006EFA  move.l -(a0), d0
006EFC  move.l -(a0), d0
006EFE  move.l -(a0), d0
006F00  move.l -(a0), d0
006F02  move.l -(a0), d0
006F04  move.l -(a0), d0
006F06  move.l -(a0), d0
006F08  move.l -(a0), d0
006F0A  move.l -(a0), d0
006F0C  move.w $30(a0, d3.w), d0
006F10  move.l -(a0), d0
006F12  move.w -(a0), d0
006F14  move.l -(a0), d0
006F16  move.l -(a0), d0
006F18  move.l $20(a0, d2.w), d0
006F1C  move.w $30(a0, d3.w), d0
006F20  move.l -(a0), d0
006F22  move.l -(a0), d0
006F24  move.l -(a0), d0
006F26  move.l -(a0), d0
006F28  ori.b  #$20, -(a0)
006F2C  move.l -(a0), d0
006F2E  move.l -(a0), d0
006F30  move.l -(a0), d0
006F32  move.l -(a0), d0
006F34  move.l -(a0), d0
006F36  move.l -(a0), d0
006F38  move.l -(a0), d0
006F3A  move.l -(a0), d0
006F3C  move.l $20(a0, d3.w), d0
006F40  move.l -(a0), d7
006F42  move.l $30(a0, d3.w), d0
006F46  move.l -(a0), d0
006F48  move.l -(a0), d0
006F4A  move.l -(a0), d0
006F4C  move.w $20(a0, d3.w), d0
006F50  move.l -(a0), d7
006F52  move.l $20(a0, d2.w), d7
006F56  move.l -(a0), d0
006F58  move.l -(a0), d0
006F5A  move.l d0, d0
006F5C  move.l -(a0), d0
006F5E  move.l -(a0), d0
006F60  move.l -(a0), d0
006F62  move.l -(a0), d0
006F64  move.l -(a0), d0
006F66  move.l -(a0), d0
006F68  move.l -(a0), d0
006F6A  move.l -(a0), d0
006F6C  move.l -(a0), d0
006F6E  move.l $2e(a0, d2.w), d0
006F72  move.l $2020(a6), d0
006F76  move.l $2030(a6), d0
006F7A  move.w -(a0), d0
006F7C  move.l $2e(a0, d3.w), d0
006F80  move.l -(a0), d0
006F82  move.l -(a0), d7
006F84  move.l -(a0), d0
006F86  move.l $20(a0, d2.w), d7
006F8A  move.l -(a0), d0
006F8C  move.l -(a0), d0
006F8E  move.l d0, d0
006F90  move.l -(a0), d0
006F92  move.l -(a0), d0
006F94  move.l -(a0), d0
006F96  move.l -(a0), d0
006F98  move.l -(a0), d0
006F9A  move.l -(a0), d0
006F9C  move.l -(a0), d0
006F9E  move.l -(a0), d0
006FA0  move.l -(a0), d0
006FA2  move.l $20(a0, d2.l), d0
006FA6  move.l -(a0), d0
006FA8  move.l -(a0), d0
006FAA  move.l -(a0), d0
006FAC  move.l -(a0), d0
006FAE  move.l $20(a0, d3.w), d0
006FB2  move.l -(a0), d0
006FB4  move.l -(a0), d0
006FB6  move.l $202e(a6), d0
006FBA  move.l $20(a0, d2.w), d0
006FBE  move.l -(a0), d0
006FC0  move.l -(a0), d0
006FC2  ori.b  #$20, -(a0)
006FC6  move.l -(a0), d0
006FC8  move.l -(a0), d0
006FCA  move.l -(a0), d0
006FCC  move.l -(a0), d0
006FCE  move.l -(a0), d0
006FD0  move.l -(a0), d0
006FD2  move.l -(a0), d0
006FD4  move.l -(a0), d0
006FD6  move.l $2e(a0, d3.w), d0
006FDA  move.l -(a0), d0
006FDC  move.l -(a0), d7
006FDE  move.l -(a0), d0
006FE0  move.l -(a0), d0
006FE2  move.l -(a0), d0
006FE4  move.l -(a0), d0
006FE6  move.l $202e(a6), d0
006FEA  move.l -(a0), d0
006FEC  move.w $20(a0, d2.w), d0
006FF0  move.l -(a0), d0
006FF2  move.l -(a0), d0
006FF4  ori.b  #$20, -(a0)
006FF8  move.l -(a0), d0
006FFA  move.l -(a0), d0
006FFC  move.l -(a0), d0
006FFE  move.l -(a0), d0
007000  move.l -(a0), d0
007002  move.l -(a0), d0
007004  move.l -(a0), d0
007006  move.l -(a0), d0
007008  move.l -(a0), d0
00700A  move.l $30(a0, d3.w), d0
00700E  move.l -(a0), d0
007010  move.l $2020(a6), d0
007014  move.l -(a0), d0
007016  move.l -(a0), d0
007018  move.l -(a0), d0
00701A  move.l $30(a0, d3.w), d0
00701E  move.l -(a0), d0
007020  move.l -(a0), d0
007022  move.l -(a0), d0
007024  move.l -(a0), d0
007026  move.l -(a0), d0
007028  move.l -(a0), d0
00702A  bcc.b  $7095
00702C  bcs.b  $70a1
00702E  movea.l $7374(a1), a0
007032  move.l -(a0), d0
007034  ori.b  #$20, -(a0)
007038  move.l -(a0), d0
00703A  move.l -(a0), d0
00703C  move.l -(a0), d0
00703E  move.l -(a0), d0
007040  move.l -(a0), d0
007042  move.l -(a0), d0
007044  move.l -(a0), d0
007046  move.l -(a0), d0
007048  move.l -(a0), d0
00704A  move.l -(a0), d0
00704C  move.l -(a0), d0
00704E  move.w $30(a0, d3.w), d0
007052  move.w $30(a0, d3.w), d0
007056  move.w $30(a0, d3.w), d0
00705A  move.w -(a0), d0
00705C  move.l -(a0), d0
00705E  move.l -(a0), d0
007060  move.l -(a0), d0
007062  move.l -(a0), d0
007064  move.l -(a0), d0
007066  move.l -(a0), d0
007068  move.l -(a0), d0
00706A  bcc.b  $70d5
00706C  bcs.b  $708e
00706E  beq.b  $70d5
007070  bgt.b  $70d3
007072  ; data: 0x75, 0x65
007074  movea.l -(a1), a0
007076  bhi.b  $70da
007078  bvs.b  $70e6
00707A  bcc.b  $70f1
00707C  bgt.b  $70e5
00707E  move.l -(a0), -(a0)
007080  ori.b  #$65, -(a0)
007084  moveq  #$61, d1
007086  bcc.b  $70ed
007088  movea.l -(a5), a0
00708A  bhi.b  $70f1
00708C  bgt.b  $70ae
00708E  bvc.b  $70f1
007090  moveq  #$20, d2
007092  bcs.b  $70fd
007094  bgt.b  $70b6
007096  bcs.b  $70fb
007098  bvc.b  $710e
00709A  bcs.b  $710e
00709C  movea.l $69(a3, d7.w), a0
0070A0  bgt.b  $7110
0070A2  bcs.b  $7116
0070A4  movea.l -(a1), a0
0070A6  bgt.b  $710f
0070A8  bcs.b  $711c
0070AA  ; data: 0x75, 0x66
0070AC  bcs.b  $711c
0070AE  move.w -(a0), d5
0070B0  bcs.b  $711b
0070B2  bgt.b  $70d4
0070B4  ; data: 0x73, 0x63
0070B6  bvc.b  $7126
0070B8  bsr.b  $711d
0070BA  bmi.b  $7121
0070BC  moveq  #$20, d1
0070BE  move.l -(a1), -(a0)
0070C0  move.l -(a0), -(a0)
0070C2  ori.b  #$63, -(a0)
0070C6  bvc.b  $70e8
0070C8  ; data: 0x77, 0x75
0070CA  ; data: 0x73, 0x73
0070CC  moveq  #$65, d2
0070CE  movea.l $6963(a6), a0
0070D2  bvc.b  $7148
0070D4  move.l -(a0), d6
0070D6  ; data: 0x77, 0x61
0070D8  ; data: 0x73, 0x20
0070DA  bcs.b  $714e
0070DC  movea.l ([$206d, a6]), a0
0070E2  bvs.b  $7156
0070E4  movea.l $6c74(a7, invalid.w), a0
0070EA  bcs.b  $7118
0070EC  movea.l -(a1), a0
0070EE  bhi.b  $7155
0070F0  moveq  #$20, d1
0070F2  bcs.b  $7167
0070F4  movea.l ([$206e6f63, a7], $6820), a0
0070FE  ; data: 0x73, 0x63
007100  bvc.b  $716e
007102  bvs.b  $7171
007104  blt.b  $716b
007106  moveq  #$20, d1
007108  move.w -(a0), d5
00710A  ori.b  #$72, -(a0)
00710E  movea.l $6273(a3, invalid.w), a0
007114  moveq  #$20, d2
007116  ; data: 0x77, 0x75
007118  ; data: 0x73, 0x73
00711A  moveq  #$65, d2
00711C  movea.l $6963(a6), a0
007120  bvc.b  $7196
007122  move.l -(a0), d6
007124  ; data: 0x77, 0x61
007126  ; data: 0x73, 0x20
007128  bcs.b  $719c
00712A  movea.l ([$206d, a6]), a0
007130  bvs.b  $71a4
007132  movea.l $6c74(a7, invalid.w), a0
007138  bcs.b  $7168
00713A  movea.l $6974(a5), a0
00713E  movea.l -(a5), a0
007140  bvs.b  $71b0
007142  bcs.b  $71b6
007144  movea.l -(a3), a0
007146  ble.b  $71b7
007148  bge.b  $71af
00714A  bgt.b  $716c
00714C  ; data: 0x73, 0x74
00714E  bvs.b  $71bd
007150  blt.b  $71b7
007152  move.l d0, d0
007154  movea.l $6569(a5), a0
007158  bgt.b  $71ce
00715A  bcs.b  $717c
00715C  bcs.b  $71d0
00715E  movea.l $e680(pc), a0
007162  blt.b  $71cd
007164  moveq  #$3a, d1
007166  movea.l $6368(a1), a0
00716A  movea.l -(a2), a0
00716C  bvs.b  $71dc
00716E  movea.l ([$202d, a6]), a0
007174  bsr.b  $71e8
007176  bvs.b  $71db
007178  bcs.b  $71a7
00717A  move.l -(a0), d6
00717C  bvc.b  $71e3
00717E  movea.l $652e(a0), a0
007182  move.l -(a0), d7
007184  ; data: 0x75, 0x6e
007186  bcc.b  $71a8
007188  bvs.b  $71ed
00718A  bvc.b  $71ac
00718C  bvc.b  $71ef
00718E  bhi.b  $71f5
007190  movea.l $686e(a1), a0
007194  movea.l -(a1), a0
007196  ; data: 0x75, 0x73
007198  beq.b  $71ff
00719A  move.l -(a0), -(a6)
00719C  ori.b  #$61, -(a0)
0071A0  bls.b  $720a
0071A2  moveq  #$2c, d2
0071A4  movea.l $6120(a0), a0
0071A8  bvc.b  $720b
0071AA  move.l $2e20(a6), d7
0071AE  bsr.b  $7222
0071B0  bvs.b  $7215
0071B2  bcs.b  $71ee
0071B4  movea.l -(a4), a0
0071B6  bcs.b  $722a
0071B8  movea.l $616d(a6), a0
0071BC  bcs.b  $71de
0071BE  bvs.b  $7233
0071C0  moveq  #$20, d2
0071C2  ; data: 0x73, 0x6f
0071C4  movea.l $62(a5, d6.l), a0
0071C8  bcs.b  $7235
0071CA  bsr.b  $723a
0071CC  bgt.b  $7242
0071CE  move.l -(a0), d6
0071D0  bcc.b  $7233
0071D2  ; data: 0x73, 0x73
0071D4  movea.l $6368(a1), a0
0071D8  movea.l $6963(a6), a0
0071DC  bvc.b  $7252
0071DE  movea.l $616c(a5), a0
0071E2  ori.b  #$65, -(a0)
0071E6  bvs.b  $725b
0071E8  ; data: 0x73, 0x2c
0071EA  movea.l ([$2065, a7]), a0
0071F0  moveq  #$20, d1
0071F2  beq.b  $7259
0071F4  ; data: 0x73, 0x63
0071F6  bvc.b  $726a
0071F8  bvs.b  $725f
0071FA  bhi.b  $7261
0071FC  bgt.b  $721e
0071FE  ; data: 0x77, 0x69
007200  moveq  #$64, d1
007202  move.l $2e2e(a6), d0
007206  movea.l -(a4), a0
007208  ; data: 0x75, 0x2c
00720A  movea.l $6368(a1), a0
00720E  movea.l -(a2), a0
007210  bvs.b  $7280
007212  movea.l $6f6e(a3, invalid.w), a0
007218  movea.l ([$6420, a3]), a0
00721E  move.w -(a0), d2
007220  bpl.b  $7283
007222  bvc.b  $7296
007224  bcs.b  $7294
007226  movea.l -(a4), a0
007228  bsr.b  $728c
00722A  bcs.b  $7295
00722C  move.l d0, d6
00722E  movea.l -(a4), a0
007230  ; data: 0x75, 0x20
007232  ; data: 0x77, 0x65
007234  bvs.b  $72a9
007236  ; data: 0x73, 0x74
007238  move.l -(a0), d6
00723A  bne.b  $72ae
00723C  ; data: 0x75, 0x65
00723E  bvc.b  $72a5
007240  moveq  #$2c, d1
007242  movea.l $6520(a0), a0
007246  bvc.b  $72ad
007248  move.l -(a0), d6
00724A  moveq  #$65, d1
00724C  bcc.b  $726e
00724E  ; data: 0x73, 0x65
007250  bls.b  $72c6
007252  ble.b  $72c6
007254  move.l -(a0), d6
007256  bvc.b  $72bd
007258  movea.l $652c(a0), a0
00725C  movea.l $69(a4, d7.w), a0
007260  ; data: 0x73, 0x74
007262  bcs.b  $72d6
007264  movea.l -(a1), a0
007266  bhi.b  $72cd
007268  moveq  #$20, d1
00726A  bpl.b  $72d1
00726C  moveq  #$7a, d2
00726E  moveq  #$20, d2
007270  bcc.b  $72e7
007272  move.l -(a0), d6
007274  bcc.b  $72d7
007276  move.l d0, d0
007278  movea.l $6520(a3, invalid.w), a0
00727E  bvs.b  $72e3
007280  bvc.b  $72a2
007282  bcc.b  $72ed
007284  bcs.b  $72a6
007286  bgt.b  $72ed
007288  ; data: 0x75, 0x65
00728A  movea.l $6f(a0, d7.w), a0
00728E  bcc.b  $7305
007290  bls.b  $7306
007292  bvs.b  $7303
007294  bgt.b  $72b6
007296  moveq  #$6f, d3
007298  bgt.b  $72ba
00729A  ; data: 0x73, 0x61
00729C  bgt.b  $7307
00729E  moveq  #$79, d2
0072A0  move.l $7475(a5), d0
0072A4  moveq  #$6d, d1
0072A6  ble.b  $7311
0072A8  bge.b  $72d7
0072AA  movea.l $64(a5, d6.l), a0
0072AE  movea.l -(a4), a0
0072B0  bcs.b  $7320
0072B2  bmi.b  $7319
0072B4  movea.l $6972(a5), a0
0072B8  move.l -(a0), d6
0072BA  bvc.b  $7321
0072BC  movea.l $652c(a0), a0
0072C0  movea.l $6368(a1), a0
0072C4  move.l d0, d0
0072C6  movea.l $6f6e(a3), a0
0072CA  moveq  #$61, d2
0072CC  bls.b  $7342
0072CE  bcs.b  $72f0
0072D0  bcc.b  $733b
0072D2  bls.b  $733c
0072D4  movea.l $6d61(a3, d6.l * 8), a0
0072DA  bge.b  $7308
0072DC  movea.l $6965(a0), a0
0072E0  moveq  #$2c, d1
0072E2  movea.l -(a2), a0
0072E4  bvs.b  $7359
0072E6  moveq  #$20, d2
0072E8  bcc.b  $7359
0072EA  bls.b  $7354
0072EC  movea.l -(a5), a0
0072EE  bvs.b  $735e
0072F0  movea.l -(a3), a0
0072F2  ble.b  $7358
0072F4  bcs.b  $7368
0072F6  move.l -(a0), d6
0072F8  ; data: 0x77, 0x61
0072FA  ; data: 0x20, 0x3f
0072FC  ; data: 0x3f, 0x3f
0072FE  movea.l $6520(a0), a0
007302  bvc.b  $7369
007304  move.l -(a0), d6
007306  move.l $2e2e(a6), d7
00730A  movea.l ([$2e002020, a5]), a0
007312  ori.b  #$63, -(a0)
007316  bvc.b  $738c
007318  movea.l $7573(a4), a0
00731C  moveq  #$69, d2
00731E  beq.b  $7340
007320  move.l $2e20(a6), d7
007324  ori.b  #$0, -(a0)
007328  movea.l $6368(a1), a0
00732C  movea.l -(a7), a0
00732E  bge.b  $7391
007330  ; data: 0x75, 0x62
007332  bcs.b  $7354
007334  bge.b  $7397
007336  bgt.b  $739f
007338  ; data: 0x73, 0x61
00733A  blt.b  $735c
00733C  bhi.b  $73a7
00733E  bgt.b  $7360
007340  bvs.b  $73a5
007342  bvc.b  $7364
007344  blt.b  $73bb
007346  bcs.b  $73ac
007348  bcs.b  $736a
00734A  move.l $2e20(a6), d7
00734E  bcs.b  $73b9
007350  bgt.b  $73b7
007352  movea.l ([$6865, a3], $206e6f63), a0
00735C  bvc.b  $737e
00735E  move.l $2e20(a6), d7
007362  bmi.b  $73cd
007364  moveq  #$73, d1
007366  moveq  #$65, d2
007368  bgt.b  $738a
00736A  blt.b  $73d1
00736C  bvs.b  $73dc
00736E  moveq  #$65, d2
007370  move.l d0, d0
007372  movea.l -(a7), a0
007374  bcs.b  $73e9
007376  moveq  #$65, d2
007378  moveq  #$6e, d1
00737A  move.l -(a0), d6
00737C  bcc.b  $73df
00737E  ; data: 0x73, 0x73
007380  movea.l ([$2061, a3]), a0
007386  ; data: 0x75, 0x63
007388  bvc.b  $73aa
00738A  bsr.b  $73ee
00738C  move.l $64(a5, d6.l), $2d7a(a6)
007392  ; data: 0x75, 0x20
007394  bcc.b  $740b
007396  blt.b  $7405
007398  bcs.b  $740d
00739A  movea.l $d911(pc), a0
00739E  beq.b  $73c0
0073A0  ; data: 0x73, 0x63
0073A2  bvc.b  $7416
0073A4  bcs.b  $740f
0073A6  bhi.b  $741c
0073A8  move.l -(a0), d7
0073AA  bge.b  $7411
0073AC  moveq  #$7a, d2
0073AE  moveq  #$65, d2
0073B0  bgt.b  $7425
0073B2  movea.l $6174(a0), a0
0073B6  movea.l ([$2000, a3]), a0
0073BC  movea.l ([$73756368, a6], $7420), a0
0073C6  bvs.b  $7430
0073C8  moveq  #$65, d1
0073CA  movea.l $6574(a2), a0
0073CE  moveq  #$69, d5
0073D0  beq.b  $7437
0073D2  movea.l -(a4), a0
0073D4  bcs.b  $743c
0073D6  bvs.b  $7446
0073D8  bvs.b  $744e
0073DA  bvs.b  $744b
0073DC  bgt.b  $73fe
0073DE  moveq  #$6f, d3
0073E0  bgt.b  $7402
0073E2  beq.b  $7450
0073E4  ; data: 0x75, 0x65
0073E6  bls.b  $7453
0073E8  movea.l -(a1), a0
0073EA  ; data: 0x75, 0x66
0073EC  moveq  #$75, d5
0073EE  ; data: 0x73, 0x63
0073F0  bvc.b  $7464
0073F2  bcs.b  $745d
0073F4  bhi.b  $745b
0073F6  bgt.b  $7426
0073F8  movea.l $6368(a1), a0
0073FC  movea.l $6c74(a7, invalid.w), a0
007402  bcs.b  $7424
007404  ori.b  #$63, -(a0)
007408  bvc.b  $7479
00740A  bgt.b  $742c
00740C  bmi.b  $7480
00740E  bsr.b  $7475
007410  bne.b  $7486
007412  bvs.b  $747b
007414  movea.l $6163(a4), a0
007418  bvc.b  $747f
00741A  bgt.b  $7448
00741C  movea.l -(a1), a0
00741E  bhi.b  $7485
007420  moveq  #$20, d1
007422  bcc.b  $7485
007424  bgt.b  $7494
007426  movea.l -(a6), a0
007428  bsr.b  $7498
00742A  bcc.b  $744c
00742C  bvs.b  $7491
00742E  bvc.b  $7450
007430  bcc.b  $749b
007432  bcs.b  $7454
007434  bvs.b  $749a
007436  bcs.b  $749d
007438  movea.l -(a7), a0
00743A  bsr.b  $74ae
00743C  movea.l $6963(a6), a0
007440  bvc.b  $74b6
007442  movea.l $616c(a5), a0
007446  movea.l $6475(a3, d6.l * 8), a0
00744C  blt.b  $74bb
00744E  move.l -(a0), d7
007450  ori.b  #$61, -(a0)
007454  ; data: 0x73, 0x20
007456  ; data: 0x77, 0x75
007458  bcs.b  $74cc
00745A  bcc.b  $74c1
00745C  movea.l $6963(a5), a0
007460  bvc.b  $7482
007462  bcs.b  $74cd
007464  beq.b  $74cb
007466  bgt.b  $74dc
007468  bge.b  $74d3
00746A  bls.b  $74d4
00746C  movea.l -(a7), a0
00746E  bge.b  $74e5
007470  bcs.b  $74d5
007472  bmi.b  $74e0
007474  bvs.b  $74d9
007476  bvc.b  $7498
007478  blt.b  $74db
00747A  bls.b  $74e4
00747C  bcs.b  $74ec
00747E  ; data: 0x20, 0x3f
007480  ; data: 0x3f, 0x3f
007482  movea.l -(a2), a0
007484  bvs.b  $74f4
007486  movea.l $6368(a1), a0
00748A  movea.l -(a7), a0
00748C  bge.b  $7503
00748E  bcs.b  $74f3
007490  bmi.b  $74fe
007492  bvs.b  $74f7
007494  bvc.b  $74b6
007496  ; data: 0x3f, 0x3f
007498  move.w $2e2e(a6), -(a7)
00749C  move.l d0, d0
00749E  move.l -(a0), d0
0074A0  ori.b  #$61, -(a0)
0074A4  movea.l $6c61(a3), a0
0074A8  moveq  #$20, d1
0074AA  move.l -(a0), -(a6)
0074AC  bsr.b  $7510
0074AE  bcs.b  $7522
0074B0  movea.l -(a4), a0
0074B2  bvs.b  $7519
0074B4  movea.l -(a6), a0
0074B6  moveq  #$61, d1
0074B8  beq.b  $751f
0074BA  movea.l $7374(a1), a0
0074BE  movea.l $6963(a6), a0
0074C2  bvc.b  $7538
0074C4  movea.l $6475(a3, d6.l * 8), a0
0074CA  blt.b  $7539
0074CC  move.l -(a0), d6
0074CE  ; data: 0x77, 0x69
0074D0  bcs.b  $74f2
0074D2  ; data: 0x73, 0x69
0074D4  bcs.b  $74f6
0074D6  bsr.b  $7545
0074D8  movea.l -(a1), a0
0074DA  bgt.b  $7542
0074DC  bsr.b  $754c
0074DE  beq.b  $7500
0074E0  bmi.b  $754e
0074E2  bvs.b  $7552
0074E4  beq.b  $755a
0074E6  move.l $2e20(a6), d7
0074EA  ori.b  #$0, -(a0)
0074EE  movea.l $73(a0, d2.l), a0
0074F2  move.l -(a0), d7
0074F4  move.l -(a0), d0
0074F6  moveq  #$2e, d0
0074F8  ; data: 0x73, 0x2e
0074FA  movea.l $6368(a1), a0
0074FE  movea.l $6162(a0), a0
007502  bcs.b  $7524
007504  blt.b  $756f
007506  moveq  #$20, d1
007508  bgt.b  $7579
00750A  bls.b  $7574
00750C  movea.l $ea7b(pc), a0
007510  movea.l -(a1), a0
007512  bhi.b  $7587
007514  bls.b  $757e
007516  bge.b  $758d
007518  ; data: 0x73, 0x73
00751A  movea.l -(a2), a0
00751C  bvs.b  $7591
00751E  bls.b  $7588
007520  bcs.b  $7590
007522  movea.l $7420766f(a4, invalid.w), a0
00752A  blt.b  $754c
00752C  bge.b  $7593
00752E  moveq  #$7a, d2
007530  moveq  #$65, d2
007532  blt.b  $7554
007534  blt.b  $7597
007536  bge.b  $7558
007538  ori.b  #$65, -(a0)
00753C  bvs.b  $75ac
00753E  beq.b  $75a5
007540  moveq  #$6f, d5
007542  beq.b  $75a9
007544  bgt.b  $7574
007546  movea.l $6368(a1), a0
00754A  movea.l $6162(a0), a0
00754E  bcs.b  $7570
007550  bne.b  $75b7
007552  ; data: 0x73, 0x74
007554  beq.b  $75bb
007556  ; data: 0x73, 0x74
007558  bcs.b  $75c6
00755A  bge.b  $75d0
00755C  move.l -(a0), d6
00755E  bcc.b  $75c1
007560  ; data: 0x73, 0x73
007562  movea.l $6368(a1), a0
007566  movea.l -(a5), a0
007568  bvs.b  $75d8
00756A  movea.l -(a1), a0
00756C  moveq  #$73, d1
00756E  bls.b  $75d8
007570  bge.b  $75e1
007572  bls.b  $75dc
007574  movea.l -(a2), a0
007576  bvs.b  $75e6
007578  move.l -(a0), d7
00757A  bcs.b  $75e5
00757C  bgt.b  $759e
00757E  move.l $2d2d(a5), -(a6)
007582  move.l d0, d0
007584  movea.l ([$73616765, a6], $7221), a0
00758E  move.l -(a1), -(a0)
007590  movea.l $6972(a3), a0
007594  ; data: 0x73, 0x74
007596  bcs.b  $7606
007598  movea.l $7374(a1), a0
00759C  movea.l -(a4), a0
00759E  ble.b  $7603
0075A0  bvc.b  $75c2
0075A2  blt.b  $760d
0075A4  moveq  #$20, d2
0075A6  bvc.b  $760d
0075A8  bgt.b  $760e
0075AA  moveq  #$69, d1
0075AC  bmi.b  $75ce
0075AE  bsr.b  $7625
0075B0  bne.b  $75d2
0075B2  bcc.b  $761d
0075B4  bcs.b  $75d6
0075B6  moveq  #$61, d0
0075B8  moveq  #$74, d1
0075BA  ; data: 0x79, 0x20
0075BC  beq.b  $7623
0075BE  beq.b  $7621
0075C0  bgt.b  $7629
0075C2  bcs.b  $7632
0075C4  move.l -(a0), d7
0075C6  ; data: 0x77, 0x61
0075C8  moveq  #$20, d1
0075CA  bsr.b  $7641
0075CC  bls.b  $7636
0075CE  move.l d0, d0
0075D0  movea.l $6c61(a3), a0
0075D4  moveq  #$2c, d1
0075D6  movea.l $7572(a6), a0
0075DA  movea.l $6368(a1), a0
0075DE  movea.l ([$20736f20, a7], $6475), a0
0075E8  blt.b  $7657
0075EA  movea.l $64(a5, d6.l), a0
0075EE  movea.l $6162(a0), a0
0075F2  movea.l ([$2075, a3]), a0
0075F8  bgt.b  $766e
0075FA  bcs.b  $766e
0075FC  ; data: 0x73, 0x63
0075FE  bvc.b  $7661
007600  bcs.b  $7676
007602  moveq  #$74, d5
007604  move.l -(a0), d7
007606  bvs.b  $766b
007608  bvc.b  $762a
00760A  bcc.b  $766d
00760C  bls.b  $7676
00760E  moveq  #$65, d2
007610  move.w -(a0), d5
007612  ; data: 0x77, 0x65
007614  bgt.b  $7684
007616  move.l d0, d0
007618  movea.l $656e(a0), a0
00761C  bcc.b  $7690
00761E  bvs.b  $768b
007620  movea.l -(a2), a0
007622  bcs.b  $768d
007624  movea.l $6872(a1), a0
007628  movea.l -(a1), a0
00762A  bgt.b  $769e
00762C  ; data: 0x75, 0x66
00762E  moveq  #$2c, d2
007630  movea.l $6761(a3, d6.l * 8), a0
007636  bgt.b  $76b2
007638  movea.l $6f(a3, d7.w), a0
00763C  bgt.b  $76b2
00763E  bsr.b  $76ae
007640  move.l -(a0), d6
007642  ; data: 0x75, 0x6e
007644  bcc.b  $7666
007646  ; data: 0x73, 0x69
007648  bcs.b  $766a
00764A  bsr.b  $76c1
00764C  bne.b  $766e
00764E  bcc.b  $76b9
007650  bcs.b  $7672
007652  moveq  #$61, d0
007654  moveq  #$74, d1
007656  ; data: 0x79, 0x20
007658  bcs.b  $76c3
00765A  bgt.b  $76c8
00765C  bsr.b  $76c3
00765E  bcc.b  $76d4
007660  move.l -(a0), d6
007662  ori.b  #$69, -(a0)
007666  moveq  #$64, d1
007668  movea.l ([$2075, a3]), a0
00766E  bcs.b  $76d2
007670  bcs.b  $76e4
007672  moveq  #$61, d1
007674  ; data: 0x73, 0x63
007676  bvc.b  $76ec
007678  movea.l ([$6e20, a3]), a0
00767E  ; data: 0x75, 0x6e
007680  bcc.b  $76a2
007682  ; data: 0x77, 0x69
007684  moveq  #$64, d1
007686  movea.l -(a1), a0
007688  ; data: 0x75, 0x66
00768A  movea.l -(a4), a0
00768C  bvs.b  $76f3
00768E  movea.l $6e65(a3, invalid.w), a0
007694  bge.b  $7702
007696  bcs.b  $76b8
007698  bgt.b  $770f
00769A  moveq  #$20, d1
00769C  bcc.b  $7703
00769E  bgt.b  $770b
0076A0  bcs.b  $7710
0076A2  move.w -(a0), d5
0076A4  bvs.b  $7709
0076A6  bvc.b  $76c8
0076A8  blt.b  $7713
0076AA  moveq  #$20, d2
0076AC  ori.b  #$65, -(a0)
0076B0  bgt.b  $7716
0076B2  moveq  #$69, d1
0076B4  bmi.b  $76e2
0076B6  movea.l $7374(a1), a0
0076BA  movea.l $6963(a6), a0
0076BE  bvc.b  $7734
0076C0  movea.l -(a7), a0
0076C2  ; data: 0x75, 0x74
0076C4  move.l -(a0), d6
0076C6  bcc.b  $772d
0076C8  bgt.b  $7738
0076CA  movea.l $6368(a1), a0
0076CE  movea.l $6c20(a7, invalid.w), a0
0076D4  ; data: 0x77, 0x61
0076D6  ; data: 0x73, 0x20
0076D8  moveq  #$6f, d3
0076DA  bgt.b  $76fc
0076DC  ; data: 0x73, 0x63
0076DE  bvc.b  $7752
0076E0  ble.b  $7747
0076E2  bcc.b  $7749
0076E4  moveq  #$2e, d1
0076E6  movea.l $6520(a6), a0
0076EA  bgt.b  $7751
0076EC  move.l $2e2e(a6), d0
0076F0  move.l d0, d0
0076F2  movea.l -(a1), a0
0076F4  bhi.b  $775b
0076F6  moveq  #$20, d1
0076F8  bgt.b  $775f
0076FA  bvs.b  $776a
0076FC  movea.l ([$2077, a3]), a0
007702  bsr.b  $7776
007704  movea.l $6c61(a3, invalid.w), a0
00770A  ; data: 0x75, 0x2c
00770C  movea.l ([$2064, a3]), a0
007712  bsr.b  $7777
007714  bvc.b  $778a
007716  bcs.b  $7752
007718  movea.l ([$6e20, a7]), a0
00771E  bvs.b  $7783
007720  bvc.b  $7742
007722  blt.b  $778d
007724  moveq  #$20, d2
007726  bvc.b  $778d
007728  bgt.b  $778e
00772A  moveq  #$69, d1
00772C  bmi.b  $774e
00772E  blt.b  $7799
007730  moveq  #$6b, d2
007732  ble.b  $77a1
007734  blt.b  $779b
007736  move.l -(a0), d6
007738  bcc.b  $779b
00773A  bgt.b  $77aa
00773C  move.l d0, d0
00773E  movea.l $6e61(a3, invalid.w), a0
007744  bls.b  $77b1
007746  moveq  #$20, d2
007748  bcs.b  $77bc
00774A  movea.l $6963(a5), a0
00774E  bvc.b  $7770
007750  moveq  #$6f, d3
007752  bge.b  $77c0
007754  move.l -(a0), d6
007756  bsr.b  $77ba
007758  bcs.b  $77cc
00775A  movea.l -(a4), a0
00775C  bsr.b  $77cc
00775E  bgt.b  $7780
007760  ; data: 0x73, 0x63
007762  bvc.b  $77d2
007764  bsr.b  $77c9
007766  bmi.b  $77cd
007768  movea.l $6368(a1), a0
00776C  movea.l $686e(a1), a0
007770  movea.l $6c20(a6, invalid.w), a0
007776  ; data: 0x75, 0x6e
007778  bcc.b  $779a
00777A  bcs.b  $77ee
00777C  movea.l ([$64207769, a7], $7373), a0
007786  bcs.b  $77f6
007788  move.l d0, d0
00778A  movea.l ([$20676573, a7], $7069656c), a0
007796  moveq  #$20, d2
007798  ; data: 0x77, 0x69
00779A  moveq  #$64, d1
00779C  movea.l $64(a5, d6.l), a0
0077A0  movea.l $726f(a3, invalid.w), a0
0077A6  bcs.b  $780c
0077A8  bcs.b  $781c
0077AA  movea.l ([$64207769, a7], $7373), a0
0077B4  bcs.b  $7824
0077B6  movea.l ([$207a7520, a7], $74756e20), a0
0077C2  ble.b  $7828
0077C4  bcs.b  $7838
0077C6  movea.l $6963(a6), a0
0077CA  bvc.b  $7840
0077CC  movea.l $ecee(pc), a0
0077D0  moveq  #$75, d2
0077D2  bgt.b  $77f4
0077D4  move.l d0, d0
0077D6  movea.l $7374(a1), a0
0077DA  move.l -(a0), d7
0077DC  move.l -(a0), d0
0077DE  move.l -(a0), d0
0077E0  move.l -(a0), d0
0077E2  ori.b  #$20, -(a0)
0077E6  move.l -(a0), d0
0077E8  move.l -(a0), d0
0077EA  move.l -(a0), d0
0077EC  movea.l $61(a4, d6.l), a0
0077F0  move.l -(a0), d6
0077F2  ; data: 0x75, 0x6e
0077F4  bcc.b  $7816
0077F6  bvs.b  $785b
0077F8  bvc.b  $781a
0077FA  bvc.b  $785d
0077FC  bhi.b  $7863
0077FE  movea.l ([$6c6f7265, a6], $6e2e), a0
007808  move.l $2000(a6), d7
00780C  move.l -(a0), d0
00780E  move.l -(a0), d0
007810  ori.b  #$20, -(a0)
007814  move.l -(a0), d0
007816  move.l -(a0), d0
007818  move.l -(a0), d0
00781A  move.l -(a0), d0
00781C  move.l -(a0), d0
00781E  move.l -(a0), d0
007820  move.l -(a0), d0
007822  move.l -(a0), d0
007824  move.l -(a0), d0
007826  move.l -(a0), d0
007828  move.l -(a0), d0
00782A  move.l -(a0), d0
00782C  move.l -(a0), d0
00782E  move.l -(a0), d0
007830  move.l -(a0), d0
007832  move.l -(a0), d0
007834  move.l -(a0), d0
007836  move.l -(a0), d0
007838  move.l -(a0), d0
00783A  move.l $2e2e(a6), d0
00783E  movea.l ([$6e67, a0]), a0
007844  move.l -(a1), d0
007846  move.l -(a1), -(a0)
007848  movea.l $64(a5, d6.l), a0
00784C  movea.l $202e2e2e(a4, invalid.w), a0
007854  move.l $2e20(a6), d7
007858  ori.b  #$0, -(a0)
00785C  movea.l -(a4), a0
00785E  bcs.b  $78d2
007860  move.l $31(a5, d2.l), d0
007864  move.w $202e(a6), -(a0)
007868  move.l $2061(a6), d7
00786C  moveq  #$74, d1
00786E  bcs.b  $7890
007870  ; data: 0x73, 0x6f
007872  bge.b  $78e0
007874  moveq  #$65, d2
007876  movea.l $6f72(a5), a0
00787A  beq.b  $78e1
00787C  bgt.b  $789e
00787E  moveq  #$61, d1
007880  ; data: 0x75, 0x73
007882  bmi.b  $78f3
007884  blt.b  $78f3
007886  bcs.b  $78f6
007888  move.l -(a0), d7
00788A  ; data: 0x77, 0x6f
00788C  bvc.b  $78fa
00788E  movea.l -(a7), a0
007890  bcs.b  $78ff
007892  bcs.b  $7906
007894  bmi.b  $790a
007896  move.l $6d6f(a5), d0
00789A  moveq  #$67, d1
00789C  bcs.b  $790c
00789E  move.l $2061(a6), -(a6)
0078A2  bhi.b  $7909
0078A4  moveq  #$20, d1
0078A6  ori.b  #$2e, -(a0)
0078AA  movea.l $7374(a1), a0
0078AE  movea.l -(a4), a0
0078B0  bvs.b  $7917
0078B2  movea.l ([$74792069, a0], $6e20), a0
0078BC  bmi.b  $792d
0078BE  bcs.b  $792c
0078C0  bgt.b  $78e2
0078C2  beq.b  $7929
0078C4  moveq  #$6c, d0
0078C6  bsr.b  $793c
0078C8  moveq  #$74, d5
0078CA  move.l -(a0), d6
0078CC  move.w $2068(a6), d1
0078D0  bsr.b  $7934
0078D2  bcs.b  $78f4
0078D4  bvs.b  $7939
0078D6  bvc.b  $78f8
0078D8  bcc.b  $7943
0078DA  bcs.b  $78fc
0078DC  bge.b  $7943
0078DE  moveq  #$7a, d2
0078E0  moveq  #$65, d2
0078E2  bgt.b  $7904
0078E4  beq.b  $7958
0078E6  bsr.b  $794e
0078E8  bvs.b  $7955
0078EA  bcs.b  $795a
0078EC  movea.l $64(a5, d6.l), a0
0078F0  move.l d0, d0
0078F2  movea.l -(a4), a0
0078F4  bvs.b  $795b
0078F6  movea.l ([$746f, a6], $72726f75), a0
007900  moveq  #$69, d2
007902  bgt.b  $7976
007904  movea.l $6d6d(a1), a0
007908  bcs.b  $797c
00790A  movea.l $6f63(a6), a0
00790E  bvc.b  $7930
007910  bgt.b  $797b
007912  bls.b  $797c
007914  moveq  #$20, d2
007916  ; data: 0x75, 0x6e
007918  bcc.b  $793a
00791A  move.w $2068(a6), -(a1)
00791E  bsr.b  $7982
007920  bcs.b  $7942
007922  bvs.b  $7987
007924  bvc.b  $7946
007926  bmi.b  $798d
007928  bvs.b  $7998
00792A  movea.l -(a2), a0
00792C  ble.b  $7991
00792E  bmi.b  $795e
007930  movea.l $6963(a6), a0
007934  bvc.b  $79aa
007936  movea.l $616c(a5), a0
00793A  move.l d0, d0
00793C  movea.l -(a2), a0
00793E  bvs.b  $79b3
007940  bls.b  $79aa
007942  bcs.b  $79b2
007944  move.l -(a0), d7
007946  bvs.b  $79ab
007948  bvc.b  $796a
00794A  beq.b  $79b8
00794C  bsr.b  $79c3
00794E  bhi.b  $79b5
007950  movea.l $6368(a1), a0
007954  movea.l ([$64652064, a7], $6965), a0
00795E  movea.l -(a4), a0
007960  bcs.b  $79cf
007962  ble.b  $7984
007964  bcs.b  $79d8
007966  ; data: 0x73, 0x74
007968  movea.l -(a1), a0
00796A  ; data: 0x75, 0x66
00796C  movea.l -(a4), a0
00796E  bcs.b  $79e2
007970  movea.l $2d6d.w, a0
007974  bsr.b  $79e9
007976  movea.l ([$74792072, a0], $6175), a0
007980  ; data: 0x73, 0x2d
007982  move.l d0, d0
007984  movea.l -(a2), a0
007986  moveq  #$69, d1
007988  bgt.b  $79f1
00798A  bcs.b  $79fa
00798C  move.l -(a0), d7
00798E  bsr.b  $7a05
007990  bne.b  $79fc
007992  bcs.b  $79f8
007994  bcs.b  $7a04
007996  bne.b  $79f9
007998  bge.b  $7a06
00799A  movea.l ([$64652069, a7], $6368), a0
0079A4  movea.l $6963(a6), a0
0079A8  bvc.b  $7a1e
0079AA  ; data: 0x73, 0x20
0079AC  moveq  #$61, d1
0079AE  ; data: 0x75, 0x73
0079B0  bhi.b  $7a24
0079B2  bvs.b  $7a22
0079B4  beq.b  $7a1b
0079B6  bgt.b  $79e4
0079B8  movea.l $686e(a7), a0
0079BC  bcs.b  $79de
0079BE  bcs.b  $7a29
0079C0  bgt.b  $7a27
0079C2  movea.l -(a3), a0
0079C4  bvc.b  $7a27
0079C6  bgt.b  $7a2b
0079C8  bcs.b  $79ea
0079CA  bsr.b  $7a41
0079CC  bne.b  $79ee
0079CE  ori.b  #$69, -(a0)
0079D2  bgt.b  $79f4
0079D4  beq.b  $7a3b
0079D6  ; data: 0x77, 0x69
0079D8  bgt.b  $7a48
0079DA  movea.l $eefc(pc), a0
0079DE  bvc.b  $7a41
0079E0  bhi.b  $7a47
0079E2  bgt.b  $7a10
0079E4  movea.l -(a4), a0
0079E6  bcs.b  $7a56
0079E8  bgt.b  $7a0a
0079EA  bgt.b  $7a61
0079EC  moveq  #$20, d1
0079EE  beq.b  $7a55
0079F0  bge.b  $7a56
0079F2  movea.l ([$6965, a2]), a0
0079F8  moveq  #$74, d1
0079FA  movea.l -(a4), a0
0079FC  bvs.b  $7a63
0079FE  movea.l $742e(a7, invalid.w), a0
007A04  move.l d0, d0
007A06  move.l -(a0), d0
007A08  ori.b  #$69, -(a0)
007A0C  bcc.b  $7a72
007A0E  bge.b  $7a75
007A10  movea.l $7374(a1), a0
007A14  movea.l -(a5), a0
007A16  bvs.b  $7a86
007A18  movea.l $6174(a3, invalid.w), a0
007A1E  moveq  #$2e, d5
007A20  movea.l $6368(a1), a0
007A24  movea.l -(a4), a0
007A26  bsr.b  $7a9a
007A28  bne.b  $7a4a
007A2A  moveq  #$69, d5
007A2C  moveq  #$69, d2
007A2E  bcs.b  $7aa2
007A30  bcs.b  $7aa0
007A32  move.w -(a0), d5
007A34  move.l $2e2e(a6), -(a6)
007A38  move.l -(a0), d6
007A3A  bsr.b  $7aa8
007A3C  ; data: 0x73, 0x6f
007A3E  movea.l $6b65(a6, invalid.w), a0
007A44  moveq  #$20, d1
007A46  ; data: 0x75, 0x6e
007A48  bcc.b  $7a6a
007A4A  bvs.b  $7aaf
007A4C  bvc.b  $7a6e
007A4E  ; data: 0x73, 0x69
007A50  bgt.b  $7ab6
007A52  move.l d0, d0
007A54  movea.l $73(a5, d6.l), a0
007A58  movea.l -(a5), a0
007A5A  bvs.b  $7aca
007A5C  bvs.b  $7ac5
007A5E  move.l -(a0), d6
007A60  bcc.b  $7ac3
007A62  ; data: 0x73, 0x73
007A64  movea.l -(a4), a0
007A66  bvs.b  $7acd
007A68  movea.l -(a4), a0
007A6A  bcs.b  $7ad9
007A6C  ble.b  $7a8e
007A6E  blt.b  $7ad9
007A70  moveq  #$20, d2
007A72  ; data: 0x73, 0x69
007A74  bls.b  $7ade
007A76  bcs.b  $7aea
007A78  bvc.b  $7adf
007A7A  bvs.b  $7af0
007A7C  movea.l -(a5), a0
007A7E  bvs.b  $7aee
007A80  bcs.b  $7af4
007A82  movea.l -(a4), a0
007A84  bcs.b  $7af8
007A86  movea.l -(a2), a0
007A88  bcs.b  $7afd
007A8A  moveq  #$65, d2
007A8C  bgt.b  $7aae
007A8E  bcc.b  $7af5
007A90  blt.b  $7b01
007A92  ; data: 0x73, 0x20
007A94  ; data: 0x77, 0x69
007A96  moveq  #$64, d1
007A98  move.l $2000(a5), d7
007A9C  movea.l -(a2), a0
007A9E  moveq  #$69, d1
007AA0  bcs.b  $7b08
007AA2  movea.l ([$2030, a6]), a0
007AA8  move.w $3131(a6), d1
007AAC  move.l -(a0), d7
007AAE  moveq  #$6a, d2
007AB0  bsr.b  $7ade
007AB2  movea.l -(a4), a0
007AB4  bsr.b  $7b29
007AB6  movea.l $6163(a5), a0
007ABA  bvc.b  $7b30
007ABC  movea.l $7573(a4), a0
007AC0  moveq  #$69, d2
007AC2  beq.b  $7af2
007AC4  movea.l $7572(a6), a0
007AC8  movea.l $6162(a0), a0
007ACC  bcs.b  $7aee
007ACE  bvs.b  $7b33
007AD0  bvc.b  $7af2
007AD2  bcc.b  $7b35
007AD4  movea.l ([$7220, a0]), a0
007ADA  bhi.b  $7b41
007ADC  bcc.b  $7b43
007ADE  bgt.b  $7b4b
007AE0  bcs.b  $7b50
007AE2  move.l -(a0), d7
007AE4  ori.b  #$6f, -(a0)
007AE8  bge.b  $7b55
007AEA  bcs.b  $7b5e
007AEC  movea.l $64(a5, d6.l), a0
007AF0  movea.l $6172(a5), a0
007AF4  bls.b  $7b16
007AF6  ; data: 0x73, 0x69
007AF8  bgt.b  $7b5e
007AFA  movea.l $f01c(pc), a0
007AFE  beq.b  $7b65
007B00  bhi.b  $7b6b
007B02  bge.b  $7b68
007B04  bcs.b  $7b7a
007B06  move.l -(a0), d6
007B08  bvs.b  $7b6d
007B0A  bvc.b  $7b2c
007B0C  blt.b  $7b73
007B0E  bvs.b  $7b7e
007B10  bcs.b  $7b32
007B12  bcc.b  $7b7d
007B14  bcs.b  $7b36
007B16  ; data: 0x73, 0x7a
007B18  bcs.b  $7b88
007B1A  bcs.b  $7b3c
007B1C  moveq  #$65, d3
007B1E  moveq  #$73, d1
007B20  moveq  #$65, d2
007B22  bvc.b  $7b98
007B24  movea.l -(a4), a0
007B26  bvs.b  $7b8d
007B28  movea.l $6569(a5), a0
007B2C  ; data: 0x73, 0x74
007B2E  bcs.b  $7b9e
007B30  move.l d0, d0
007B32  movea.l -(a1), a0
007B34  bgt.b  $7ba9
007B36  moveq  #$69, d0
007B38  bcs.b  $7ba6
007B3A  ; data: 0x75, 0x6e
007B3C  beq.b  $7b5e
007B3E  ; data: 0x75, 0x6e
007B40  bcc.b  $7b62
007B42  moveq  #$75, d5
007B44  ; data: 0x73, 0x61
007B46  blt.b  $7bb5
007B48  bcs.b  $7bb8
007B4A  ; data: 0x73, 0x74
007B4C  bcs.b  $7bba
007B4E  bge.b  $7bc5
007B50  bgt.b  $7bb9
007B52  movea.l ([$6572, a5], $6861), a0
007B5A  ; data: 0x75, 0x70
007B5C  moveq  #$20, d2
007B5E  bgt.b  $7bc9
007B60  bls.b  $7bca
007B62  moveq  #$2c, d2
007B64  movea.l $7a2e(a3, d6.l * 8), a0
007B6A  bhi.b  $7b9a
007B6C  movea.l -(a5), a0
007B6E  moveq  #$6b, d1
007B70  bcs.b  $7be0
007B72  bgt.b  $7be8
007B74  bgt.b  $7bdf
007B76  ; data: 0x73, 0x73
007B78  bcs.b  $7b9a
007B7A  ; data: 0x77, 0x69
007B7C  bcs.b  $7bb8
007B7E  move.l d0, d0
007B80  move.l $6569(a5), d0
007B84  bgt.b  $7ba6
007B86  bge.b  $7bed
007B88  bvs.b  $7bed
007B8A  bvc.b  $7c00
007B8C  bcs.b  $7c00
007B8E  movea.l $6175(a0), a0
007B92  bls.b  $7bfc
007B94  move.l $65(a7, d3.w), d0
007B98  moveq  #$2c, d1
007B9A  movea.l -(a1), a0
007B9C  bgt.b  $7bff
007B9E  moveq  #$63, d1
007BA0  bvc.b  $7c0b
007BA2  ; data: 0x73, 0x74
007BA4  bvs.b  $7c19
007BA6  bls.b  $7c10
007BA8  move.l -(a0), d6
007BAA  bcs.b  $7c20
007BAC  bls.b  $7bdc
007BAE  move.l -(a0), -(a6)
007BB0  ; data: 0x73, 0x69
007BB2  bgt.b  $7c18
007BB4  movea.l -(a6), a0
007BB6  ; data: 0x75, 0x65
007BB8  moveq  #$20, d1
007BBA  bcc.b  $7c25
007BBC  bcs.b  $7bde
007BBE  blt.b  $7c25
007BC0  bvs.b  $7c35
007BC2  moveq  #$65, d2
007BC4  bgt.b  $7be6
007BC6  ; data: 0x75, 0x6e
007BC8  move.l d0, -(a6)
007BCA  movea.l -(a5), a0
007BCC  moveq  #$72, d1
007BCE  bcs.b  $7c39
007BD0  bls.b  $7c3a
007BD2  moveq  #$62, d2
007BD4  bsr.b  $7c48
007BD6  move.l -(a0), d7
007BD8  ; data: 0x73, 0x6f
007BDA  movea.l $616e(a3), a0
007BDE  bgt.b  $7c00
007BE0  bvs.b  $7c45
007BE2  bvc.b  $7c04
007BE4  blt.b  $7c4f
007BE6  moveq  #$20, d1
007BE8  moveq  #$6f, d3
007BEA  moveq  #$73, d1
007BEC  moveq  #$65, d2
007BEE  bge.b  $7c5c
007BF0  bcs.b  $7c60
007BF2  move.l -(a0), d6
007BF4  bcc.b  $7c57
007BF6  ; data: 0x73, 0x73
007BF8  movea.l ([$6c65, a6]), a0
007BFE  movea.l -(a4), a0
007C00  bvs.b  $7c67
007C02  movea.l -(a4), a0
007C04  bcs.b  $7c73
007C06  ble.b  $7c28
007C08  ; data: 0x73, 0x63
007C0A  bvc.b  $7c78
007C0C  bcs.b  $7c71
007C0E  bvc.b  $7c84
007C10  move.l d0, d0
007C12  movea.l -(a6), a0
007C14  bvs.b  $7c84
007C16  bcc.b  $7c7d
007C18  bgt.b  $7c46
007C1A  movea.l ([$6c20, a7]), a0
007C20  ; data: 0x73, 0x69
007C22  bcs.b  $7c44
007C24  ; data: 0x73, 0x69
007C26  bcs.b  $7c48
007C28  bgt.b  $7c93
007C2A  bls.b  $7c94
007C2C  moveq  #$20, d2
007C2E  moveq  #$65, d3
007C30  moveq  #$73, d1
007C32  moveq  #$65, d2
007C34  bvc.b  $7c9b
007C36  bgt.b  $7c66
007C38  move.l d0, d0
007C3A  movea.l $6e20(a1), a0
007C3E  bcc.b  $7ca9
007C40  bcs.b  $7cb5
007C42  bcs.b  $7cb6
007C44  movea.l -(a2), a0
007C46  bcs.b  $7cc2
007C48  bvs.b  $7caf
007C4A  bvc.b  $7cc1
007C4C  bgt.b  $7cb5
007C4E  movea.l $6174(a0), a0
007C52  movea.l $6963(a5), a0
007C56  bvc.b  $7c78
007C58  bvc.b  $7cbf
007C5A  bgt.b  $7cc0
007C5C  moveq  #$69, d1
007C5E  bmi.b  $7c80
007C60  bge.b  $7cc7
007C62  moveq  #$7a, d2
007C64  moveq  #$65, d2
007C66  bgt.b  $7cdb
007C68  movea.l ([$6572, a5], $7261), a0
007C70  ; data: 0x73, 0x63
007C72  bvc.b  $7ce8
007C74  move.l -(a0), d7
007C76  bcs.b  $7cea
007C78  movea.l $6569(a5), a0
007C7C  bgt.b  $7cf2
007C7E  bcs.b  $7ca0
007C80  ori.b  #$61, -(a0)
007C84  bcs.b  $7cee
007C86  blt.b  $7cf4
007C88  bvs.b  $7ced
007C8A  bvc.b  $7cac
007C8C  bsr.b  $7d03
007C8E  bls.b  $7cf8
007C90  move.l -(a0), d6
007C92  bcc.b  $7cf5
007C94  ; data: 0x73, 0x73
007C96  movea.l -(a1), a0
007C98  moveq  #$74, d1
007C9A  bcs.b  $7cbc
007C9C  bcs.b  $7d07
007C9E  bgt.b  $7cc0
007CA0  moveq  #$61, d0
007CA2  bsr.b  $7d16
007CA4  movea.l $75(a3, d7.w), a0
007CA8  bne.b  $7d10
007CAA  bcs.b  $7d1a
007CAC  movea.l ([$6572, a5], $2061), a0
007CB4  bge.b  $7d22
007CB6  bcs.b  $7d26
007CB8  movea.l -(a1), a0
007CBA  bgt.b  $7d20
007CBC  bcs.b  $7d30
007CBE  bcs.b  $7d2e
007CC0  movea.l -(a4), a0
007CC2  bcs.b  $7d31
007CC4  ble.b  $7d39
007CC6  move.l d0, d0
007CC8  movea.l $65(a3, d7.w), a0
007CCC  bvc.b  $7d42
007CCE  move.l -(a0), d7
007CD0  bsr.b  $7d34
007CD2  bcs.b  $7d46
007CD4  movea.l -(a5), a0
007CD6  moveq  #$20, d1
007CD8  bvs.b  $7d4d
007CDA  moveq  #$20, d2
007CDC  bsr.b  $7d53
007CDE  bls.b  $7d48
007CE0  movea.l -(a5), a0
007CE2  bvs.b  $7d52
007CE4  bcs.b  $7d58
007CE6  movea.l ([$2064, a6]), a0
007CEC  bcs.b  $7d5c
007CEE  bcs.b  $7d5e
007CF0  move.l -(a0), d6
007CF2  bcc.b  $7d5d
007CF4  bcs.b  $7d16
007CF6  bhi.b  $7d61
007CF8  ; data: 0x73, 0x63
007CFA  bvc.b  $7d61
007CFC  bgt.b  $7d1e
007CFE  blt.b  $7d65
007D00  bvc.b  $7d74
007D02  movea.l ([$73746568, a6], $656e), a0
007D0C  move.l -(a0), d7
007D0E  bvs.b  $7d73
007D10  bvc.b  $7d32
007D12  ori.b  #$69, -(a0)
007D16  bgt.b  $7d38
007D18  bcs.b  $7d7d
007D1A  bvc.b  $7d90
007D1C  movea.l -(a7), a0
007D1E  bcs.b  $7d93
007D20  moveq  #$61, d0
007D22  bgt.b  $7d92
007D24  moveq  #$20, d2
007D26  ; data: 0x77, 0x69
007D28  bcs.b  $7d4a
007D2A  bsr.b  $7d9e
007D2C  moveq  #$65, d2
007D2E  movea.l -(a1), a0
007D30  bgt.b  $7d9d
007D32  ble.b  $7da1
007D34  blt.b  $7daa
007D36  move.l -(a0), d7
007D38  move.l ([$6e20, a7]), $6573(a6)
007D40  movea.l ([$65697420, a3]), a0
007D48  bvs.b  $7dbd
007D4A  moveq  #$2d, d2
007D4C  move.l d0, d0
007D4E  move.l -(a0), d0
007D50  ori.b  #$65, -(a0)
007D54  ; data: 0x75, 0x74
007D56  bcs.b  $7d78
007D58  move.l -(a1), $6267(a6)
007D5C  bcs.b  $7dd1
007D5E  bcs.b  $7dc8
007D60  bcs.b  $7dd0
007D62  movea.l -(a4), a0
007D64  bsr.b  $7ddc
007D66  ble.b  $7dd6
007D68  move.l -(a0), d6
007D6A  bcc.b  $7dcd
007D6C  ; data: 0x73, 0x73
007D6E  movea.l $6569(a5), a0
007D72  bgt.b  $7dd9
007D74  movea.l $7574(a5), a0
007D78  moveq  #$65, d2
007D7A  moveq  #$20, d1
007D7C  ; data: 0x77, 0x69
007D7E  bcs.b  $7de4
007D80  bcs.b  $7df4
007D82  movea.l -(a1), a0
007D84  ; data: 0x75, 0x73
007D86  beq.b  $7ded
007D88  bne.b  $7df6
007D8A  bvs.b  $7dfc
007D8C  moveq  #$74, d0
007D8E  movea.l $7374(a1), a0
007D92  move.l -(a0), -(a6)
007D94  bvs.b  $7e09
007D96  moveq  #$20, d2
007D98  ori.b  #$69, -(a0)
007D9C  bgt.b  $7dbe
007D9E  bge.b  $7e15
007DA0  ; data: 0x73, 0x74
007DA2  bvs.b  $7e0b
007DA4  bcs.b  $7e18
007DA6  movea.l ([$2e20, a4]), a0
007DAC  bsr.b  $7e10
007DAE  bcs.b  $7e1e
007DB0  bcc.b  $7e25
007DB2  movea.l $6163(a5), a0
007DB6  bvc.b  $7e1d
007DB8  bgt.b  $7dda
007DBA  ; data: 0x77, 0x69
007DBC  moveq  #$20, d1
007DBE  bcs.b  $7e29
007DC0  bgt.b  $7e27
007DC2  movea.l $6c65(a3), a0
007DC6  bvs.b  $7e36
007DC8  bcs.b  $7dea
007DCA  moveq  #$65, d5
007DCC  ; data: 0x73, 0x63
007DCE  bvc.b  $7e39
007DD0  bgt.b  $7df2
007DD2  blt.b  $7e3d
007DD4  moveq  #$20, d2
007DD6  ; data: 0x73, 0x63
007DD8  bvc.b  $7e4c
007DDA  ble.b  $7e41
007DDC  bcc.b  $7e43
007DDE  moveq  #$2c, d1
007DE0  move.l d0, d0
007DE2  movea.l $6972(a3), a0
007DE6  ; data: 0x73, 0x74
007DE8  bcs.b  $7e58
007DEA  movea.l $64(a5, d6.l), a0
007DEE  movea.l $656e(a0), a0
007DF2  bcc.b  $7e66
007DF4  bvs.b  $7e61
007DF6  move.l -(a0), d7
007DF8  blt.b  $7e5b
007DFA  moveq  #$74, d1
007DFC  bcs.b  $7e1e
007DFE  bmi.b  $7e6f
007E00  bgt.b  $7e70
007E02  moveq  #$65, d2
007E04  movea.l $6963(a6), a0
007E08  bvc.b  $7e7e
007E0A  move.l -(a0), d7
007E0C  ; data: 0x73, 0x63
007E0E  bvc.b  $7e71
007E10  bcc.b  $7e77
007E12  move.l $2e20(a6), d7
007E16  ; data: 0x77, 0x69
007E18  moveq  #$20, d1
007E1A  ; data: 0x77, 0x65
007E1C  moveq  #$64, d1
007E1E  bcs.b  $7e8d
007E20  movea.l -(a2), a0
007E22  bvs.b  $7e97
007E24  bls.b  $7e8e
007E26  bcs.b  $7e96
007E28  move.l d0, d0
007E2A  movea.l ([$20726175, a7], $6368656e), a0
007E36  move.l $6e61(a5), d0
007E3A  moveq  #$75, d2
007E3C  bcs.b  $7eb0
007E3E  bge.b  $7ea9
007E40  bls.b  $7eaa
007E42  movea.l ([$2062, a6]), a0
007E48  bcs.b  $7ebd
007E4A  moveq  #$65, d2
007E4C  bgt.b  $7e7b
007E4E  movea.l $64(a5, d6.l), a0
007E52  movea.l $69(a0, d6.l), a0
007E56  bge.b  $7ec7
007E58  ; data: 0x73, 0x6f
007E5A  bne.b  $7ec5
007E5C  bcs.b  $7ed0
007E5E  bcs.b  $7ece
007E60  move.l -(a0), d6
007E62  ; data: 0x77, 0x69
007E64  bcs.b  $7e86
007E66  ; data: 0x73, 0x69
007E68  bls.b  $7ed2
007E6A  movea.l -(a4), a0
007E6C  bsr.b  $7ee1
007E6E  movea.l -(a7), a0
007E70  bcs.b  $7e9f
007E72  move.l d0, d0
007E74  movea.l $6f65(a0), a0
007E78  moveq  #$74, d1
007E7A  move.l -(a0), d7
007E7C  bcc.b  $7edf
007E7E  bgt.b  $7ee1
007E80  bls.b  $7eea
007E82  movea.l $7374(a1), a0
007E86  movea.l $7267(a1), a0
007E8A  bcs.b  $7efa
007E8C  bcc.b  $7eae
007E8E  bcs.b  $7ef9
007E90  bgt.b  $7ef7
007E92  movea.l $6e65(a3), a0
007E96  bvs.b  $7f08
007E98  bcs.b  $7eba
007E9A  bsr.b  $7f0a
007E9C  beq.b  $7f03
007E9E  ; data: 0x73, 0x61
007EA0  beq.b  $7f16
007EA2  move.l -(a0), d6
007EA4  bcc.b  $7f0b
007EA6  bgt.b  $7f16
007EA8  movea.l $6368(a1), a0
007EAC  movea.l -(a7), a0
007EAE  bcs.b  $7f12
007EB0  bcs.b  $7ed2
007EB2  bcs.b  $7f1d
007EB4  bgt.b  $7ed6
007EB6  bsr.b  $7f2d
007EB8  ; data: 0x73, 0x2e
007EBA  move.l d0, d0
007EBC  movea.l $6368(a1), a0
007EC0  movea.l -(a2), a0
007EC2  bvs.b  $7f32
007EC4  movea.l -(a7), a0
007EC6  bcs.b  $7f3b
007EC8  moveq  #$61, d0
007ECA  bgt.b  $7f3a
007ECC  moveq  #$20, d2
007ECE  ble.b  $7f32
007ED0  movea.l $726f(a3, invalid.w), a0
007ED6  bcs.b  $7f3c
007ED8  bcs.b  $7f4c
007EDA  movea.l $6575(a0), a0
007EDE  moveq  #$65, d2
007EE0  movea.l $6c61(a3), a0
007EE4  moveq  #$20, d1
007EE6  bhi.b  $7f54
007EE8  bcs.b  $7f53
007EEA  bhi.b  $7f60
007EEC  move.l -(a0), d7
007EEE  bvs.b  $7f53
007EF0  bvc.b  $7f12
007EF2  blt.b  $7f59
007EF4  bvs.b  $7f64
007EF6  bcs.b  $7f18
007EF8  bgt.b  $7f63
007EFA  bls.b  $7f64
007EFC  moveq  #$20, d2
007EFE  moveq  #$6f, d3
007F00  blt.b  $7f22
007F02  ori.b  #$61, -(a0)
007F06  ; data: 0x75, 0x63
007F08  bvc.b  $7f6f
007F0A  bgt.b  $7f38
007F0C  movea.l -(a4), a0
007F0E  bcs.b  $7f7e
007F10  bgt.b  $7f32
007F12  bcc.b  $7f75
007F14  ; data: 0x73, 0x20
007F16  moveq  #$61, d1
007F18  ; data: 0x75, 0x63
007F1A  bvc.b  $7f81
007F1C  bgt.b  $7f3e
007F1E  bvs.b  $7f93
007F20  moveq  #$20, d2
007F22  bvs.b  $7f91
007F24  blt.b  $7f8b
007F26  moveq  #$20, d1
007F28  bgt.b  $7f93
007F2A  bcs.b  $7f4c
007F2C  moveq  #$65, d3
007F2E  moveq  #$6b, d1
007F30  bcs.b  $7f9a
007F32  moveq  #$74, d1
007F34  move.l -(a0), d6
007F36  bsr.b  $7f9a
007F38  bcs.b  $7fac
007F3A  movea.l $6220(a7), a0
007F3E  bcs.b  $7fb2
007F40  movea.l ([$6820, a3], $65696e20), a0
007F4A  ori.b  #$72, -(a0)
007F4E  bvs.b  $7fc0
007F50  movea.l $6d65(a3, invalid.w), a0
007F56  bvs.b  $7fcb
007F58  moveq  #$20, d2
007F5A  ble.b  $7fc0
007F5C  bcs.b  $7fd0
007F5E  movea.l $6963(a6), a0
007F62  bvc.b  $7fd8
007F64  move.w -(a0), -(a7)
007F66  bcs.b  $7fda
007F68  movea.l ([$7373, a7]), a0
007F6E  moveq  #$2c, d2
007F70  movea.l -(a4), a0
007F72  bsr.b  $7fe7
007F74  ; data: 0x73, 0x20
007F76  ; data: 0x77, 0x69
007F78  moveq  #$20, d1
007F7A  bcs.b  $7fef
007F7C  movea.l -(a1), a0
007F7E  bge.b  $7fec
007F80  bcs.b  $7fa2
007F82  ; data: 0x73, 0x63
007F84  bvc.b  $7ff2
007F86  bcs.b  $7feb
007F88  bvc.b  $7ffe
007F8A  movea.l -(a6), a0
007F8C  bvs.b  $7ffc
007F8E  bcc.b  $7ff5
007F90  bgt.b  $7fbe
007F92  move.l d0, d0
007F94  movea.l ([$616c6c65, a6], $6d2c), a0
007F9E  movea.l ([$6c20, a7]), a0
007FA4  bcc.b  $8007
007FA6  ; data: 0x73, 0x20
007FA8  bgt.b  $8013
007FAA  bls.b  $8014
007FAC  moveq  #$20, d2
007FAE  ; data: 0x73, 0x65
007FB0  bvs.b  $8020
007FB2  movea.l -(a5), a0
007FB4  moveq  #$73, d1
007FB6  moveq  #$65, d2
007FB8  moveq  #$20, d1
007FBA  bvs.b  $802f
007FBC  moveq  #$2e, d2
007FBE  movea.l ([$7265, a7]), a0
007FC4  movea.l $6164(a3, invalid.w), a0
007FCA  bcs.b  $7fec
007FCC  ; data: 0x77, 0x65
007FCE  bgt.b  $803e
007FD0  movea.l -(a5), a0
007FD2  moveq  #$20, d1
007FD4  ; data: 0x73, 0x69
007FD6  bls.b  $8040
007FD8  movea.l $6963(a6), a0
007FDC  bvc.b  $8052
007FDE  move.l d0, d0
007FE0  movea.l -(a2), a0
007FE2  moveq  #$65, d1
007FE4  blt.b  $8059
007FE6  bcs.b  $8056
007FE8  movea.l $616e(a3), a0
007FEC  bgt.b  $801c
007FEE  movea.l $61(a4, d6.l), a0
007FF2  movea.l $6368(a1), a0
007FF6  movea.l $6162(a0), a0
007FFA  bcs.b  $801c
007FFC  bsr.b  $8073
007FFE  bls.b  $8068
008000  movea.l -(a7), a0
008002  bcs.b  $806c
008004  ble.b  $806b
008006  moveq  #$74, d1
008008  move.l -(a0), d6
00800A  bcc.b  $806d
00800C  ; data: 0x73, 0x73
00800E  movea.l $6972(a3), a0
008012  ; data: 0x73, 0x74
008014  bcs.b  $8084
008016  movea.l $7261(a3), a0
00801A  bgt.b  $8087
00801C  movea.l $7374(a1), a0
008020  move.l -(a0), d6
008022  ble.b  $808c
008024  movea.l $7374(a1), a0
008028  move.l d0, d0
00802A  movea.l -(a4), a0
00802C  bsr.b  $80a1
00802E  movea.l $6963(a6), a0
008032  bvc.b  $80a8
008034  movea.l $7573(a4), a0
008038  moveq  #$69, d2
00803A  beq.b  $805c
00803C  ; data: 0x3f, 0x3f
00803E  move.w $2e2e(a6), -(a7)
008042  move.l d0, d0
008044  move.l -(a0), d0
008046  ori.b  #$0, -(a0)
00804A  movea.l $6368(a1), a0
00804E  movea.l $616e(a3), a0
008052  bgt.b  $8074
008054  bcs.b  $80c9
008056  movea.l $6963(a6), a0
00805A  bvc.b  $80d0
00805C  movea.l -(a7), a0
00805E  bge.b  $80c1
008060  ; data: 0x75, 0x62
008062  bcs.b  $80d2
008064  move.l -(a0), d7
008066  bvc.b  $80cd
008068  ; data: 0x75, 0x74
00806A  bcs.b  $808c
00806C  bvs.b  $80e1
00806E  moveq  #$20, d2
008070  bcc.b  $80d7
008072  moveq  #$20, d1
008074  move.w $31(a6, d2.l), -(a0)
008078  move.w $2069(a6), d1
00807C  bls.b  $80e6
00807E  movea.l ([$73746520, a7], $67617220), a0
00808A  bgt.b  $80f5
00808C  bls.b  $80f6
00808E  moveq  #$2c, d2
008090  movea.l -(a4), a0
008092  bsr.b  $8107
008094  ; data: 0x73, 0x20
008096  ori.b  #$63, -(a0)
00809A  bvc.b  $80bc
00809C  ; data: 0x73, 0x63
00809E  bvc.b  $810f
0080A0  bgt.b  $80c2
0080A2  ; data: 0x73, 0x6f
0080A4  movea.l $616e(a4), a0
0080A8  beq.b  $810f
0080AA  movea.l $6963(a6), a0
0080AE  bvc.b  $8124
0080B0  movea.l $6568(a5), a0
0080B4  moveq  #$20, d1
0080B6  beq.b  $811d
0080B8  ; data: 0x73, 0x63
0080BA  bvc.b  $812e
0080BC  bvs.b  $8123
0080BE  bhi.b  $8125
0080C0  bgt.b  $80e2
0080C2  bvc.b  $8125
0080C4  bhi.b  $812b
0080C6  move.l $2e20(a6), d7
0080CA  bcs.b  $813f
0080CC  movea.l $7374(a1), a0
0080D0  movea.l ([$6c20, a6]), a0
0080D6  moveq  #$61, d0
0080D8  ; data: 0x73, 0x73
0080DA  bvs.b  $8141
0080DC  moveq  #$74, d1
0080DE  move.l d0, d0
0080E0  movea.l $64(a5, d6.l), a0
0080E4  movea.l -(a4), a0
0080E6  bsr.b  $815b
0080E8  movea.l $f60a(pc), a0
0080EC  bhi.b  $8153
0080EE  ; data: 0x73, 0x63
0080F0  bvc.b  $8164
0080F2  bcs.b  $815d
0080F4  bhi.b  $815b
0080F6  bgt.b  $8118
0080F8  ; data: 0x77, 0x61
0080FA  bcs.b  $816e
0080FC  bcs.b  $811e
0080FE  bgt.b  $8169
008100  bls.b  $816a
008102  moveq  #$20, d2
008104  bhi.b  $816b
008106  ; data: 0x73, 0x6f
008108  bgt.b  $816e
00810A  bcs.b  $817e
00810C  ; data: 0x73, 0x20
00810E  ; data: 0x73, 0x69
008110  bgt.b  $8180
008112  moveq  #$6f, d3
008114  bge.b  $8182
008116  move.l -(a0), d6
008118  bcc.b  $817f
00811A  bgt.b  $818a
00811C  movea.l $616e(a5), a0
008120  movea.l -(a2), a0
008122  moveq  #$61, d1
008124  bcs.b  $819b
008126  bls.b  $8190
008128  moveq  #$20, d2
00812A  ori.b  #$65, -(a0)
00812E  bvc.b  $81a2
008130  bcs.b  $81a4
008132  bcs.b  $8154
008134  bcc.b  $819f
008136  ; data: 0x73, 0x6b
008138  bcs.b  $81ae
00813A  moveq  #$65, d2
00813C  bgt.b  $815e
00813E  ; data: 0x75, 0x6d
008140  movea.l -(a7), a0
008142  bcs.b  $81b2
008144  ; data: 0x75, 0x65
008146  beq.b  $81ad
008148  bgt.b  $81ae
00814A  movea.l $61(a0, d6.l), a0
00814E  moveq  #$7a, d2
008150  movea.l $f672(pc), a0
008154  bvc.b  $81b7
008156  bhi.b  $81bd
008158  bgt.b  $8188
00815A  movea.l $6972(a3), a0
00815E  ; data: 0x73, 0x74
008160  bcs.b  $81d0
008162  movea.l $7374(a1), a0
008166  movea.l $6974(a5), a0
00816A  movea.l $726f(a3, invalid.w), a0
008170  bcs.b  $81d6
008172  bcs.b  $81e6
008174  move.l d0, d0
008176  movea.l $f6eb(pc), a0
00817A  bsr.b  $81e9
00817C  blt.b  $81e3
00817E  bgt.b  $81ae
008180  move.l $2073(a6), d7
008184  bvs.b  $81eb
008186  movea.l $7374(a1), a0
00818A  movea.l $7573(a4), a0
00818E  moveq  #$69, d2
008190  beq.b  $81c0
008192  move.l $2075(a6), d7
008196  bgt.b  $81fc
008198  movea.l $6368(a1), a0
00819C  movea.l $7573(a5), a0
0081A0  ; data: 0x73, 0x20
0081A2  bcc.b  $820d
0081A4  bcs.b  $81c6
0081A6  beq.b  $8209
0081A8  bgt.b  $8224
0081AA  bcs.b  $81cc
0081AC  moveq  #$65, d5
0081AE  bvs.b  $8224
0081B0  movea.l ([$7265, a7]), a0
0081B6  bgt.b  $821c
0081B8  movea.l $6368(a1), a0
0081BC  move.l d0, d0
0081BE  movea.l -(a4), a0
0081C0  bsr.b  $8235
0081C2  movea.l $6965(a0), a0
0081C6  moveq  #$20, d1
0081C8  ; data: 0x73, 0x63
0081CA  bvc.b  $823e
0081CC  bcs.b  $8237
0081CE  bhi.b  $8235
0081D0  movea.l -(a7), a0
0081D2  moveq  #$69, d1
0081D4  bgt.b  $8249
0081D6  bcs.b  $8246
0081D8  move.l -(a0), d7
0081DA  bcs.b  $824f
0081DC  movea.l $7374(a1), a0
0081E0  movea.l $6c75(a3, d6.l * 8), a0
0081E6  ; data: 0x73, 0x74
0081E8  bvs.b  $8251
0081EA  move.l $2e20(a6), d7
0081EE  ori.b  #$0, -(a0)
0081F2  movea.l -(a5), a0
0081F4  bvs.b  $8264
0081F6  bcs.b  $8218
0081F8  ; data: 0x73, 0x61
0081FA  bls.b  $8264
0081FC  bcs.b  $821e
0081FE  blt.b  $8275
008200  ; data: 0x73, 0x73
008202  movea.l $6368(a1), a0
008206  movea.l -(a1), a0
008208  bhi.b  $826f
00820A  moveq  #$20, d1
00820C  bge.b  $827d
00820E  ; data: 0x73, 0x77
008210  bcs.b  $8284
008212  bcc.b  $8279
008214  bgt.b  $8242
008216  movea.l -(a4), a0
008218  bcs.b  $8288
00821A  bgt.b  $823c
00821C  ; data: 0x73, 0x69
00821E  bcs.b  $8240
008220  ; data: 0x77, 0x69
008222  moveq  #$64, d1
008224  movea.l -(a1), a0
008226  ; data: 0x75, 0x66
008228  movea.l -(a4), a0
00822A  bvs.b  $8291
00822C  ; data: 0x73, 0x65
00822E  moveq  #$20, d1
008230  bcc.b  $829b
008232  ; data: 0x73, 0x6b
008234  bcs.b  $82aa
008236  moveq  #$65, d2
008238  movea.l -(a6), a0
00823A  ; data: 0x75, 0x65
00823C  moveq  #$20, d1
00823E  ori.b  #$6d, -(a0)
008242  blt.b  $82a9
008244  moveq  #$20, d1
008246  moveq  #$65, d3
008248  moveq  #$65, d1
00824A  ; data: 0x77, 0x69
00824C  beq.b  $82c2
00824E  movea.l -(a2), a0
008250  bge.b  $82b7
008252  bvs.b  $82b6
008254  bcs.b  $82c4
008256  move.w -(a0), d5
008258  ori.b  #$0, -(a0)
00825C  move.l -(a0), d0
00825E  move.l -(a0), d0
008260  move.l -(a0), d0
008262  move.l -(a0), d0
008264  move.l -(a0), d0
008266  move.l -(a0), d0
008268  move.l -(a0), d0
00826A  move.w $3131(a6), -(a2)
00826E  move.l $30(a2, d3.w), d7
008272  move.w $2073(a4), -(a1)
008276  bsr.b  $82a6
008278  move.l -(a0), d6
00827A  bmi.b  $82e8
00827C  bvs.b  $82eb
00827E  moveq  #$65, d0
008280  moveq  #$6b, d1
008282  bvs.b  $82f7
008284  moveq  #$65, d2
008286  move.l -(a0), d6
008288  move.w $75(a2, d2.w), d1
00828C  bvc.b  $8300
00828E  move.l d0, d0
008290  move.l -(a0), d0
008292  ori.b  #$20, -(a0)
008296  move.l -(a0), d0
008298  move.l -(a0), d0
00829A  move.l -(a0), d0
00829C  move.l -(a0), d0
00829E  movea.l $74(a5, d6.l), a0
0082A2  move.l -(a0), d7
0082A4  move.l -(a0), d0
0082A6  bpl.b  $82d6
0082A8  bvc.b  $82d8
0082AA  ble.b  $8314
0082AC  bge.b  $82ce
0082AE  move.l -(a0), d0
0082B0  move.l -(a0), d0
0082B2  bls.b  $8329
0082B4  bmi.b  $831f
0082B6  bcs.b  $832a
0082B8  ; data: 0x73, 0x6b
0082BA  bvs.b  $82dc
0082BC  move.l -(a0), d0
0082BE  movea.l $726f(a3, invalid.w), a0
0082C4  bcs.b  $832a
0082C6  bcs.b  $833a
0082C8  move.l d0, d0
0082CA  move.l -(a0), d0
0082CC  ori.b  #$63, -(a0)
0082D0  bvc.b  $82f2
0082D2  bhi.b  $833d
0082D4  bgt.b  $82f6
0082D6  beq.b  $833d
0082D8  ; data: 0x73, 0x70
0082DA  bsr.b  $834a
0082DC  bgt.b  $8352
0082DE  movea.l ([$20766f6e, a7], $2075), a0
0082E8  bgt.b  $835d
0082EA  movea.l -(a4), a0
0082EC  moveq  #$65, d1
0082EE  bvs.b  $8310
0082F0  bcc.b  $8353
0082F2  movea.l ([$6e20, a3]), a0
0082F8  ; data: 0x77, 0x69
0082FA  moveq  #$64, d1
0082FC  move.l -(a0), d7
0082FE  bcs.b  $8373
008300  movea.l ([$64206465, a7], $7220), a0
00830A  bsr.b  $836e
00830C  bcs.b  $837c
00830E  bcc.b  $8330
008310  ; data: 0x75, 0x65
008312  bhi.b  $8379
008314  moveq  #$2d, d1
008316  move.l d0, d0
008318  movea.l $6175(a0), a0
00831C  moveq  #$74, d0
00831E  movea.l ([$6e2e, a3]), a0
008324  movea.l -(a1), a0
008326  bls.b  $8390
008328  movea.l $612c(a2), a0
00832C  movea.l $616e(a3), a0
008330  bgt.b  $8352
008332  bcc.b  $8395
008334  ; data: 0x73, 0x20
008336  bcs.b  $83a1
008338  bgt.b  $835a
00833A  moveq  #$75, d5
00833C  bne.b  $839f
00833E  bge.b  $83ac
008340  movea.l ([$6e3f, a3]), a0
008346  movea.l $6368(a1), a0
00834A  movea.l $6162(a0), a0
00834E  bcs.b  $8370
008350  blt.b  $83bb
008352  moveq  #$20, d1
008354  moveq  #$6f, d3
008356  moveq  #$68, d1
008358  bvs.b  $83c8
00835A  movea.l -(a4), a0
00835C  bcs.b  $83cc
00835E  move.l -(a0), d0
008360  ori.b  #$65, -(a0)
008364  moveq  #$7a, d2
008366  moveq  #$65, d2
008368  bgt.b  $838a
00836A  bsr.b  $83ce
00836C  ; data: 0x73, 0x61
00836E  moveq  #$7a, d2
008370  movea.l -(a4), a0
008372  ; data: 0x75, 0x72
008374  bls.b  $83de
008376  beq.b  $83dd
008378  bge.b  $83df
00837A  ; data: 0x73, 0x65
00837C  bgt.b  $83ac
00837E  movea.l -(a4), a0
008380  bsr.b  $83a2
008382  ; data: 0x73, 0x74
008384  bcs.b  $83ee
008386  moveq  #$2e, d2
008388  move.l $202d(a6), d7
00838C  bcc.b  $83ef
00838E  bgt.b  $83f1
008390  bls.b  $83fa
008392  movea.l $7374(a1), a0
008396  movea.l $7267(a1), a0
00839A  bcs.b  $840a
00839C  bcc.b  $83be
00839E  bcs.b  $8409
0083A0  bgt.b  $8407
0083A2  movea.l $6e65(a3), a0
0083A6  bvs.b  $8418
0083A8  bcs.b  $83ca
0083AA  ori.b  #$6e, -(a0)
0083AE  beq.b  $8415
0083B0  ; data: 0x73, 0x61
0083B2  beq.b  $8428
0083B4  move.l $2e2d(a6), d7
0083B8  movea.l $64(a5, d6.l), a0
0083BC  movea.l -(a5), a0
0083BE  ; data: 0x73, 0x20
0083C0  ; data: 0x77, 0x61
0083C2  moveq  #$20, d1
0083C4  bsr.b  $8433
0083C6  move.l $31(a5, d2.l), d0
0083CA  move.w $3933(a6), -(a0)
0083CE  movea.l $6e20(a1), a0
0083D2  bcc.b  $8439
0083D4  moveq  #$20, d1
0083D6  bmi.b  $8444
0083D8  bvs.b  $8447
0083DA  moveq  #$65, d0
0083DC  moveq  #$6b, d1
0083DE  bvs.b  $8453
0083E0  moveq  #$65, d2
0083E2  move.l -(a0), d7
0083E4  bcs.b  $8459
0083E6  movea.l ([$2065696e, a7], $2073), a0
0083F0  bls.b  $845a
0083F2  ble.b  $8459
0083F4  bgt.b  $845b
0083F6  moveq  #$20, d1
0083F8  ori.b  #$62, -(a0)
0083FC  bcs.b  $846c
0083FE  bcc.b  $8420
008400  beq.b  $8467
008402  ; data: 0x77, 0x65
008404  ; data: 0x73, 0x65
008406  bgt.b  $8434
008408  movea.l $6368(a1), a0
00840C  movea.l $6162(a0), a0
008410  bcs.b  $8432
008412  bcc.b  $8475
008414  movea.l -(a6), a0
008416  bsr.b  $848b
008418  moveq  #$20, d2
00841A  bsr.b  $848a
00841C  beq.b  $8483
00841E  bne.b  $8481
008420  bgt.b  $8489
008422  bcs.b  $8492
008424  movea.l $f946(pc), a0
008428  bvc.b  $848f
00842A  ; data: 0x75, 0x6c
00842C  bcs.b  $849c
00842E  move.l -(a0), d6
008430  bcc.b  $8497
008432  bgt.b  $84a2
008434  movea.l ([$20686162, a7], $656e), a0
00843E  movea.l $73(a5, d6.l), a0
008442  move.l d0, d0
008444  movea.l ([$67657374, a6], $656c), a0
00844E  bge.b  $84c4
008450  movea.l ([$20776165, a7], $72652c20), a0
00845C  ; data: 0x77, 0x65
00845E  bgt.b  $84ce
008460  movea.l -(a5), a0
008462  bvs.b  $84d2
008464  bcs.b  $84d8
008466  movea.l ([$2075, a6]), a0
00846C  bgt.b  $84e1
00846E  movea.l $6963(a6), a0
008472  bvc.b  $84e8
008474  movea.l $f996(pc), a0
008478  bcc.b  $84e3
00847A  bcs.b  $84ef
00847C  bcs.b  $84eb
00847E  movea.l $65(a4, d7.w), a0
008482  bne.b  $84ea
008484  bcs.b  $84f4
008486  movea.l $6f6d(a3), a0
00848A  blt.b  $84f1
00848C  bgt.b  $84ae
00848E  ori.b  #$75, -(a0)
008492  bcs.b  $8506
008494  bcc.b  $84fb
008496  move.l -(a0), d7
008498  bcs.b  $850d
00849A  movea.l ([$7264, a7]), a0
0084A0  bcs.b  $84c2
0084A2  bne.b  $8519
0084A4  bcs.b  $8518
0084A6  movea.l -(a4), a0
0084A8  bvs.b  $850f
0084AA  movea.l -(a1), a0
0084AC  bgt.b  $8512
0084AE  bcs.b  $8522
0084B0  bcs.b  $8520
0084B2  movea.l $7765(a3, invalid.w), a0
0084B8  moveq  #$20, d1
0084BA  ; data: 0x77, 0x65
0084BC  moveq  #$64, d1
0084BE  bcs.b  $852e
0084C0  movea.l -(a5), a0
0084C2  ; data: 0x73, 0x20
0084C4  moveq  #$75, d5
0084C6  movea.l ([$6b726166, a6], $7465), a0
0084D0  bgt.b  $8500
0084D2  movea.l -(a4), a0
0084D4  bsr.b  $8549
0084D6  move.l d0, d0
0084D8  movea.l $6572(a5), a0
0084DC  bmi.b  $8555
0084DE  ; data: 0x75, 0x65
0084E0  moveq  #$64, d1
0084E2  bvs.b  $854b
0084E4  ; data: 0x73, 0x74
0084E6  bcs.b  $8508
0084E8  ; data: 0x77, 0x61
0084EA  moveq  #$20, d1
0084EC  bsr.b  $8550
0084EE  bcs.b  $8562
0084F0  move.l -(a0), d6
0084F2  bcc.b  $8555
0084F4  ; data: 0x73, 0x73
0084F6  movea.l $6368(a1), a0
0084FA  movea.l $6963(a5), a0
0084FE  bvc.b  $8520
008500  bcc.b  $8563
008502  bgt.b  $8572
008504  movea.l $6f63(a6), a0
008508  bvc.b  $852a
00850A  moveq  #$65, d3
00850C  moveq  #$73, d1
00850E  moveq  #$72, d0
008510  ble.b  $8575
008512  bvc.b  $8579
008514  bgt.b  $8536
008516  bvc.b  $8579
008518  bhi.b  $857f
00851A  movea.l $64(a5, d6.l), a0
00851E  movea.l -(a7), a0
008520  bcs.b  $8595
008522  bsr.b  $858b
008524  moveq  #$20, d2
008526  ori.b  #$61, -(a0)
00852A  bhi.b  $8591
00852C  move.w -(a0), d5
00852E  ; data: 0x77, 0x69
008530  moveq  #$20, d1
008532  ; data: 0x77, 0x65
008534  moveq  #$64, d1
008536  bcs.b  $85a6
008538  movea.l -(a4), a0
00853A  bsr.b  $85aa
00853C  bgt.b  $855e
00853E  bsr.b  $85ac
008540  bge.b  $85a7
008542  movea.l -(a2), a0
008544  bvs.b  $85ab
008546  moveq  #$20, d1
008548  bhi.b  $85af
00854A  ; data: 0x73, 0x74
00854C  bcs.b  $85ba
00854E  bge.b  $85b5
008550  bgt.b  $8572
008552  ; data: 0x75, 0x6e
008554  bcc.b  $8576
008556  moveq  #$72, d2
008558  bvs.b  $85c8
00855A  bmi.b  $85c1
00855C  bgt.b  $858a
00855E  movea.l -(a1), a0
008560  bhi.b  $85c7
008562  moveq  #$20, d1
008564  bvs.b  $85c9
008566  bvc.b  $8588
008568  bvc.b  $85cb
00856A  bhi.b  $85d1
00856C  movea.l $62(a5, d6.l), a0
008570  bcs.b  $859f
008572  move.l d0, d0
008574  movea.l ([$7374206d, a7], $69742064), a0
008580  bcs.b  $85f0
008582  movea.l -(a6), a0
008584  bvs.b  $85f4
008586  beq.b  $85ed
008588  moveq  #$6e, d1
00858A  movea.l $7572(a6), a0
00858E  movea.l $fcf5(pc), a0
008592  bvs.b  $85b4
008594  bhi.b  $85ff
008596  bcs.b  $860a
008598  movea.l -(a7), a0
00859A  bcs.b  $8616
00859C  bcs.b  $8607
00859E  beq.b  $8614
0085A0  movea.l $64(a5, d6.l), a0
0085A4  movea.l -(a4), a0
0085A6  bsr.b  $861b
0085A8  movea.l $6165(a0), a0
0085AC  moveq  #$74, d2
0085AE  bcs.b  $85d0
0085B0  bgt.b  $861b
0085B2  bls.b  $861c
0085B4  moveq  #$20, d2
0085B6  ; data: 0x73, 0x65
0085B8  bvs.b  $8628
0085BA  move.l d0, d0
0085BC  movea.l -(a4), a0
0085BE  ; data: 0x75, 0x65
0085C0  moveq  #$66, d1
0085C2  bcs.b  $8632
0085C4  move.l $2e20(a6), d7
0085C8  ori.b  #$0, -(a0)
0085CC  move.l -(a0), d0
0085CE  ori.b  #$0, -(a0)
0085D2  move.l -(a0), d0
0085D4  move.l -(a0), d0
0085D6  move.l -(a0), d0
0085D8  move.l -(a0), d0
0085DA  move.l -(a0), d0
0085DC  move.l -(a0), d0
0085DE  move.l -(a0), d0
0085E0  move.l -(a0), d0
0085E2  move.l -(a0), d0
0085E4  move.l -(a0), d0
0085E6  move.l -(a0), d0
0085E8  move.l -(a0), d0
0085EA  move.l -(a0), d0
0085EC  move.l -(a0), d0
0085EE  move.l -(a0), d0
0085F0  move.l -(a0), d0
0085F2  bcs.b  $8662
0085F4  bcc.b  $865b
0085F6  move.l $2e2e(a6), d0
0085FA  move.l $2000(a6), d7
0085FE  move.l -(a0), d0
008600  ori.b  #$0, -(a0)
008604  move.l -(a0), d0
008606  move.l -(a0), d0
008608  move.l -(a0), d0
00860A  move.l -(a0), d0
00860C  move.l -(a0), d0
00860E  move.l -(a0), d0
008610  move.l -(a0), d0
008612  move.l -(a0), d0
008614  move.l -(a0), d0
008616  move.l -(a0), d0
008618  move.l -(a0), d0
00861A  move.l -(a0), d0
00861C  move.l -(a0), d0
00861E  move.l -(a0), d0
008620  move.l -(a0), d0
008622  move.l -(a0), d0
008624  move.l -(a0), d0
008626  move.l -(a0), d0
008628  move.l -(a0), d0
00862A  move.l -(a0), d0
00862C  move.l -(a0), d0
00862E  move.l -(a0), d0
008630  move.l -(a0), d0
008632  move.l -(a0), d0
008634  move.l -(a0), d0
008636  move.l -(a0), d0
008638  move.l -(a0), d0
00863A  move.l -(a0), d0
00863C  movea.l $65722063(a0, invalid.w), a0
008644  ; data: 0x75, 0x6b
008646  bvs.b  $86ad
008648  moveq  #$73, d1
00864A  bmi.b  $86b5
00864C  move.l d0, d0
00864E  btst.l d0, -(a0)
008650  move.l d0, d0
008652  move.l -(a0), d0
008654  ori.b  #$0, -(a0)
008658  move.l -(a0), d0
00865A  ori.b  #$0, -(a0)
00865E  move.l -(a0), d0
008660  ori.b  #$0, -(a0)
008664  move.l -(a0), d0
008666  ori.b  #$0, -(a0)
00866A  move.l -(a0), d0
00866C  ori.b  #$0, -(a0)
008670  move.l -(a0), d0
008672  ori.b  #$0, -(a0)
008676  move.l -(a0), d0
008678  ori.b  #$0, -(a0)
00867C  move.l -(a0), d0
00867E  ori.b  #$0, -(a0)
008682  move.l -(a0), d0
008684  ori.b  #$0, -(a0)
008688  move.l -(a0), d0
00868A  ori.b  #$0, -(a0)
00868E  move.l -(a0), d0
008690  ori.b  #$0, -(a0)
008694  move.l -(a0), d0
008696  ori.b  #$0, -(a0)
00869A  btst.l d0, d0
00869C  ori.b  #$0, d0
0086A0  bset.b d1, (a2, d0.w)
0086A4  ori.b  #$0, d0
0086A8  ori.b  #$0, d0
0086AC  ori.b  #$0, d0
0086B0  ori.b  #$0, d0
0086B4  ori.b  #$0, d0
0086B8  ori.b  #$0, d0
0086BC  ori.b  #$0, d0
0086C0  ori.b  #$0, d0
0086C4  ori.b  #$0, d0
0086C8  ori.b  #$0, d0
0086CC  ori.b  #$0, d0
0086D0  ori.b  #$0, d0
0086D4  ori.b  #$0, d0
0086D8  ori.b  #$0, d0
0086DC  ori.b  #$0, d0
0086E0  ori.b  #$0, d0
0086E4  ori.b  #$0, d0
0086E8  ori.b  #$0, d0
0086EC  ori.b  #$0, d0
0086F0  ori.b  #$0, d0
0086F4  ori.b  #$0, d0
0086F8  ori.b  #$0, d0
0086FC  ori.b  #$0, d0
008700  ori.b  #$0, d0
008704  ori.b  #$0, d0
008708  ori.b  #$0, d0
00870C  ori.b  #$0, d0
008710  dc.w   $fc24
008712  ; data: 0xf1, 0x08
008714  asr.b  #$8, d2
008716  and.b  d5, (a6)+
008718  cmpa.w -(a6), a2
00871A  ; data: 0xa0, 0x02
00871C  divu.w #$83de, d7
008720  or.b   d1, d0
008722  or.b   d1, d0
008724  or.b   d1, d0
008726  or.b   d1, d0
008728  or.b   d1, d0
00872A  or.b   d1, d0
00872C  or.b   d1, d0
00872E  or.b   d1, d0
008730  or.b   d1, d0
008732  or.b   d1, d0
008734  or.b   d1, d0
008736  or.b   d1, d0
008738  or.b   d1, d0
00873A  or.b   d1, d0
00873C  or.b   d1, d0
00873E  or.b   d1, d0
008740  or.b   d1, d0
008742  or.b   d1, d0
008744  or.b   d1, d0
008746  or.b   d1, d0
008748  or.b   d1, d0
00874A  or.b   d1, d0
00874C  or.b   d1, d0
00874E  or.b   d1, d0
008750  or.b   d1, d0
008752  or.b   d1, d0
008754  or.b   d1, d0
008756  or.b   d1, d0
008758  or.b   d1, d0
00875A  or.b   d1, d0
00875C  or.b   d1, d0
00875E  or.b   d1, d0
008760  or.b   d1, d0
008762  or.b   d1, d0
008764  or.b   d1, d0
008766  or.b   d1, d0
008768  or.b   d1, d0
00876A  or.b   d1, d0
00876C  or.b   d1, d0
00876E  or.b   d1, d0
008770  or.b   d1, d0
008772  or.b   d1, d0
008774  or.b   d1, d0
008776  or.b   d1, d0
008778  or.b   d1, d0
00877A  or.b   d0, d0
00877C  divs.w (a4)+, d1
00877E  divu.w $9ffe.w, d7
008782  cmpa.w -(a0), a2
008784  and.b  d5, (a2)+
008786  ; data: 0xdf, 0xfe
008788  ; data: 0xf1, 0x04
00878A  dc.w   $fc22
00878C  ori.b  #$0, d0
008790  ori.b  #$0, d0
008794  ori.b  #$0, d0
008798  ori.b  #$0, d0
00879C  ori.b  #$0, d0
0087A0  ori.b  #$0, d0
0087A4  ori.b  #$0, d0
0087A8  ori.b  #$0, d0
0087AC  ori.b  #$0, d0
0087B0  ori.b  #$0, d0
0087B4  ori.b  #$0, d0
0087B8  ori.b  #$0, d0
0087BC  ori.b  #$0, d0
0087C0  ori.b  #$0, d0
0087C4  ori.b  #$0, d0
0087C8  ori.b  #$0, d0
0087CC  ori.b  #$0, d0
0087D0  ori.b  #$0, d0
0087D4  ori.b  #$dc, d0
0087D8  ; data: 0x0e, 0xf8
0087DA  ; data: 0x1f, 0xfe
0087DC  move.w -(a0), (a2)+
0087DE  dc.w   $4b1a
0087E0  dc.w   $5ffc
0087E2  ; data: 0x71, 0x04
0087E4  moveq  #$22, d6
0087E6  ; data: 0x7f, 0xff
0087E8  ; data: 0x7f, 0xff
0087EA  ; data: 0x7f, 0xff
0087EC  ; data: 0x7f, 0xff
0087EE  ; data: 0x7f, 0xff
0087F0  ; data: 0x7f, 0xff
0087F2  ; data: 0x7f, 0xff
0087F4  ; data: 0x7f, 0xff
0087F6  ; data: 0x7f, 0xff
0087F8  ; data: 0x7f, 0xff
0087FA  moveq  #$d, d7
0087FC  moveq  #$48, d4
0087FE  bgt.b  $87da
008800  bhi.b  $8810
008802  addq.w #$1, a0
008804  negx.b d2
008806  ; data: 0x2b, 0xca
008808  ; data: 0x16, 0x3d
00880A  ori.b  #$c9, d3
00880E  add.b  #$4, d2
008812  ; data: 0xad, 0xbd
008814  suba.l ([$87bb, a6, a1.w]), a6
00881A  divs.w (a4, a0.w), d0
00881E  divs.w (a4)+, d1
008820  divu.w $9ffe.w, d7
008824  cmpa.w -(a0), a2
008826  and.b  d5, (a2)+
008828  ; data: 0xdf, 0xfe
00882A  ; data: 0xf1, 0x04
00882C  dc.w   $fc22
00882E  ori.b  #$0, d0
008832  ori.b  #$0, d0
008836  ori.b  #$0, d0
00883A  ori.b  #$0, d0
00883E  ori.b  #$0, d0
008842  dc.w   $fc24
008844  ; data: 0xf1, 0x08
008846  asr.b  #$8, d2
008848  and.b  d5, (a6)+
00884A  cmpa.w -(a6), a2
00884C  ; data: 0xa0, 0x02
00884E  divu.w #$83de, d7
008852  or.b   d1, d0
008854  or.b   d1, d0
008856  or.b   d1, d0
008858  or.b   d1, d0
00885A  or.b   d1, d0
00885C  or.b   d1, d0
00885E  or.b   d1, d0
008860  or.b   d1, d0
008862  or.b   d1, d0
008864  or.b   d1, d0
008866  divs.w ([$91249df0], a0.w * 8, $adb6bffc), d0
008872  add.b  (invalid.w), d2
008876  ori.b  #$3a, d0
00887A  ; data: 0x2b, 0xc7
00887C  ; data: 0x3f, 0xff
00887E  addq.w #$1, d6
008880  bhi.b  $888e
008882  bgt.b  $885d
008884  moveq  #$47, d4
008886  moveq  #$d, d7
008888  ; data: 0x7f, 0xff
00888A  ; data: 0x7f, 0xff
00888C  ; data: 0x7f, 0xff
00888E  ; data: 0x7f, 0xff
008890  ; data: 0x7f, 0xff
008892  ; data: 0x7f, 0xff
008894  ; data: 0x7f, 0xff
008896  ; data: 0x7f, 0xff
008898  ; data: 0x7f, 0xff
00889A  ; data: 0x7f, 0xff
00889C  ; data: 0x7f, 0xff
00889E  ; data: 0x7f, 0xff
0088A0  ; data: 0x7f, 0xff
0088A2  ; data: 0x7f, 0xff
0088A4  ; data: 0x7f, 0xff
0088A6  ; data: 0x7f, 0xff
0088A8  ; data: 0x7f, 0xff
0088AA  ; data: 0x7f, 0xff
0088AC  ; data: 0x7f, 0xff
0088AE  moveq  #$24, d6
0088B0  ; data: 0x71, 0x06
0088B2  bra.w  $d3d2
0088B6  move.w -(a4), (a2)+
0088B8  move.l d2, d0
0088BA  ; data: 0x0e, 0xfa
0088BC  bset.b d1, (a4)+
0088BE  ori.b  #$0, d0
0088C2  ori.b  #$0, d0
0088C6  ori.b  #$0, d0
0088CA  ori.b  #$0, d0
0088CE  ori.b  #$0, d0
0088D2  ori.b  #$0, d0
0088D6  ori.b  #$0, d0
0088DA  ori.b  #$0, d0
0088DE  ori.b  #$0, d0
0088E2  ori.b  #$0, d0
0088E6  ori.b  #$0, d0
0088EA  ori.b  #$0, d0
0088EE  ori.b  #$0, d0
0088F2  ori.b  #$0, d0
0088F6  ori.b  #$0, d0
0088FA  ori.b  #$0, d0
0088FE  ori.b  #$0, d0
008902  ori.b  #$0, d0
008906  ori.b  #$0, d0
00890A  ori.b  #$0, d0
00890E  ori.b  #$0, d0
008912  ori.b  #$0, d0
008916  ori.b  #$0, d0
00891A  ori.b  #$0, d0
00891E  ori.b  #$0, d0
008922  ori.b  #$0, d0
008926  ori.b  #$0, d0
00892A  ori.b  #$0, d0
00892E  ori.b  #$0, d0
008932  ori.b  #$0, d0
008936  ori.b  #$0, d0
00893A  ori.b  #$0, d0
00893E  ori.b  #$0, d0
008942  ori.b  #$0, d0
008946  ori.b  #$0, d0
00894A  ; data: 0xff, 0xff
00894C  ; data: 0xff, 0xff
00894E  ori.b  #$0, d0
008952  ori.b  #$0, d0
008956  ori.b  #$0, d0
00895A  ori.b  #$0, d0
00895E  ori.b  #$0, d0
008962  ori.b  #$0, d0
008966  ori.b  #$0, d0
00896A  ori.b  #$0, d0
00896E  ori.b  #$0, d0
008972  ori.b  #$0, d0
008976  ori.b  #$0, d0
00897A  ori.b  #$0, d0
00897E  ori.b  #$0, d0
008982  ori.b  #$0, d0
008986  ori.b  #$0, d0
00898A  ori.b  #$0, d0
00898E  ori.b  #$0, d0
008992  ori.b  #$0, d0
008996  ori.b  #$0, d0
00899A  ori.b  #$0, d0
00899E  ori.b  #$0, d0
0089A2  ori.b  #$0, d0
0089A6  ori.b  #$0, d0
0089AA  ori.b  #$0, d0
0089AE  ori.b  #$0, d0
0089B2  ori.b  #$0, d0
0089B6  ori.b  #$0, d0
0089BA  ori.b  #$0, d0
0089BE  ori.b  #$0, d0
0089C2  ori.b  #$0, d0
0089C6  ori.b  #$0, d0
0089CA  ori.b  #$0, d0
0089CE  ori.b  #$0, d0
0089D2  ori.b  #$0, d0
0089D6  ori.b  #$0, d0
0089DA  ori.b  #$0, d0
0089DE  ori.b  #$0, d0
0089E2  ori.b  #$0, d0
0089E6  ori.b  #$0, d0
0089EA  ori.b  #$0, d0
0089EE  ori.b  #$0, d0
0089F2  bset.b d1, (a4)+
0089F4  ; data: 0x0e, 0xf8
0089F6  ; data: 0x1f, 0xfe
0089F8  move.w -(a0), (a2)+
0089FA  dc.w   $4b1a
0089FC  dc.w   $5ffc
0089FE  ; data: 0x71, 0x04
008A00  moveq  #$22, d6
008A02  ; data: 0x7f, 0xff
008A04  ; data: 0x7f, 0xff
008A06  ; data: 0x7f, 0xff
008A08  ; data: 0x7f, 0xff
008A0A  ; data: 0x7f, 0xff
008A0C  ; data: 0x7f, 0xff
008A0E  ; data: 0x7f, 0xff
008A10  ; data: 0x7f, 0xff
008A12  ; data: 0x7f, 0xff
008A14  ; data: 0x7f, 0xff
008A16  ; data: 0x7f, 0xff
008A18  ; data: 0x7f, 0xff
008A1A  ; data: 0x7f, 0xff
008A1C  ; data: 0x7f, 0xff
008A1E  ; data: 0x7f, 0xff
008A20  ; data: 0x7f, 0xff
008A22  ; data: 0x7f, 0xff
008A24  ; data: 0x7f, 0xff
008A26  ; data: 0x7f, 0xff
008A28  ; data: 0x7f, 0xff
008A2A  ; data: 0x7f, 0xff
008A2C  ; data: 0x7f, 0xff
008A2E  ; data: 0x7f, 0xff
008A30  ; data: 0x7f, 0xff
008A32  ; data: 0x7f, 0xff
008A34  ; data: 0x7f, 0xff
008A36  ; data: 0x7f, 0xff
008A38  ; data: 0x7f, 0xff
008A3A  moveq  #$24, d6
008A3C  ; data: 0x71, 0x06
008A3E  bra.w  $d55e
008A42  move.w -(a4), (a2)+
008A44  move.l d2, d0
008A46  ; data: 0x0e, 0xfa
008A48  bset.b d1, (a4)+
008A4A  ori.b  #$0, d0
008A4E  ori.b  #$0, d0
008A52  ori.b  #$0, d0
008A56  ori.b  #$0, d0
008A5A  ori.b  #$0, d0
008A5E  ori.b  #$0, d0
008A62  ori.b  #$0, d0
008A66  ori.b  #$0, d0
008A6A  ori.b  #$0, d0
008A6E  ori.b  #$0, d0
008A72  ori.b  #$0, d0
008A76  ori.b  #$0, d0
008A7A  ori.b  #$0, d0
008A7E  ori.b  #$0, d0
008A82  ori.b  #$0, d0
008A86  ori.b  #$0, d0
008A8A  ori.b  #$0, d0
008A8E  ori.b  #$0, d0
008A92  ori.b  #$24, d0
008A96  ; data: 0xf1, 0x08
008A98  asr.b  #$8, d2
008A9A  and.b  d5, (a6)+
008A9C  cmpa.w -(a6), a2
008A9E  ; data: 0xa0, 0x02
008AA0  divu.w #$83de, d7
008AA4  or.b   d1, d0
008AA6  or.b   d1, d0
008AA8  or.b   d1, d0
008AAA  or.b   d1, d0
008AAC  or.b   d1, d0
008AAE  or.b   d1, d0
008AB0  or.b   d1, d0
008AB2  or.b   d1, d0
008AB4  or.b   d1, d0
008AB6  or.b   d1, d0
008AB8  divs.w ([$91249df0], a0.w * 8, $adb6bffc), d0
008AC4  add.b  (invalid.w), d2
008AC8  ori.b  #$3a, d0
008ACC  ; data: 0x2b, 0xc7
008ACE  ; data: 0x3f, 0xff
008AD0  addq.w #$1, d6
008AD2  bhi.b  $8ae0
008AD4  bgt.b  $8aaf
008AD6  moveq  #$47, d4
008AD8  moveq  #$d, d7
008ADA  ; data: 0x7f, 0xff
008ADC  moveq  #$d, d7
008ADE  moveq  #$48, d4
008AE0  bgt.b  $8abc
008AE2  bhi.b  $8af2
008AE4  addq.w #$1, a0
008AE6  negx.b d2
008AE8  ; data: 0x2b, 0xca
008AEA  ; data: 0x16, 0x3d
008AEC  ori.b  #$c9, d3
008AF0  add.b  #$4, d2
008AF4  ; data: 0xad, 0xbd
008AF6  suba.l ([$87bb, a6, a1.w]), a6
008AFC  divs.w $1(a4, a0.w), d0
008B00  or.b   d1, d0
008B02  or.b   d1, d0
008B04  or.b   d1, d0
008B06  or.b   d1, d0
008B08  or.b   d1, d0
008B0A  or.b   d1, d0
008B0C  or.b   d1, d0
008B0E  or.b   d1, d0
008B10  or.b   d1, d0
008B12  or.b   d1, d0
008B14  or.b   d1, d0
008B16  or.b   d1, d0
008B18  or.b   d1, d0
008B1A  or.b   d1, d0
008B1C  or.b   d1, d0
008B1E  or.b   d1, d0
008B20  or.b   d1, d0
008B22  or.b   d0, d0
008B24  divs.w (a4)+, d1
008B26  divu.w $9ffe.w, d7
008B2A  cmpa.w -(a0), a2
008B2C  and.b  d5, (a2)+
008B2E  ; data: 0xdf, 0xfe
008B30  ; data: 0xf1, 0x04
008B32  dc.w   $fc22
008B34  ori.b  #$0, d0
008B38  ori.b  #$0, d0
008B3C  ori.b  #$0, d0
008B40  ori.b  #$0, d0
008B44  ori.b  #$0, d0
008B48  bset.b d1, (a4)+
008B4A  ; data: 0x0e, 0xf8
008B4C  ; data: 0x1f, 0xfe
008B4E  move.w -(a0), (a2)+
008B50  dc.w   $4b1a
008B52  dc.w   $5ffc
008B54  ; data: 0x71, 0x04
008B56  moveq  #$22, d6
008B58  ; data: 0x7f, 0xff
008B5A  ; data: 0x7f, 0xff
008B5C  ; data: 0x7f, 0xff
008B5E  ; data: 0x7f, 0xff
008B60  ; data: 0x7f, 0xff
008B62  ; data: 0x7f, 0xff
008B64  ; data: 0x7f, 0xff
008B66  ; data: 0x7f, 0xff
008B68  ; data: 0x7f, 0xff
008B6A  ; data: 0x7f, 0xff
008B6C  moveq  #$24, d6
008B6E  ; data: 0x71, 0x06
008B70  bra.w  $d690
008B74  move.w -(a4), (a2)+
008B76  move.l d2, d0
008B78  ; data: 0x0e, 0xfa
008B7A  bset.b d1, (a4)+
008B7C  ori.b  #$0, d0
008B80  ori.b  #$0, d0
008B84  ori.b  #$0, d0
008B88  ori.b  #$0, d0
008B8C  ori.b  #$0, d0
008B90  ori.b  #$0, d0
008B94  ori.b  #$0, d0
008B98  ori.b  #$0, d0
008B9C  ori.b  #$0, d0
008BA0  ori.b  #$0, d0
008BA4  ori.b  #$0, d0
008BA8  ori.b  #$0, d0
008BAC  ori.b  #$0, d0
008BB0  ori.b  #$0, d0
008BB4  ori.b  #$0, d0
008BB8  ori.b  #$0, d0
008BBC  ori.b  #$0, d0
008BC0  ori.b  #$0, d0
008BC4  ori.b  #$0, d0
008BC8  ori.b  #$0, d0
008BCC  ori.b  #$0, d0
008BD0  ori.b  #$0, d0
008BD4  ori.b  #$0, d0
008BD8  ori.b  #$0, d0
008BDC  ori.b  #$0, d0
008BE0  ori.b  #$0, d0
008BE4  ori.b  #$0, d0
008BE8  ori.b  #$0, d0
008BEC  ori.b  #$0, d0
008BF0  ori.b  #$0, d0
008BF4  ori.b  #$ff, d0
008BF8  ; data: 0xff, 0xff
008BFA  btst.l d1, d0
008BFC  ori.b  #$0, d0
008C00  ori.b  #$0, d0
008C04  ori.b  #$0, d0
008C08  ori.b  #$0, d0
008C0C  ori.b  #$0, d0
008C10  ori.b  #$0, d0
008C14  ori.b  #$0, d0
008C18  ori.b  #$0, d0
008C1C  ori.b  #$0, d0
008C20  ori.b  #$0, d0
008C24  ori.b  #$0, d0
008C28  ori.b  #$0, d0
008C2C  ori.b  #$0, d0
008C30  ori.b  #$0, d0
008C34  ori.b  #$0, d0
008C38  ori.b  #$78, d0
008C3C  moveq  #$3c, d4
008C3E  move.w (a6)+, d6
008C40  ; data: 0x1e, 0x0f
008C42  dc.w   $f078
008C44  moveq  #$3c, d4
008C46  move.w (a6)+, d6
008C48  ; data: 0x1e, 0x0f
008C4A  dc.w   $f078
008C4C  moveq  #$3c, d4
008C4E  move.w (a6)+, d6
008C50  ; data: 0x1e, 0x0f
008C52  dc.w   $f078
008C54  moveq  #$3c, d4
008C56  move.w (a6)+, d6
008C58  ; data: 0x1e, 0x0f
008C5A  dc.w   $f078
008C5C  moveq  #$3c, d4
008C5E  move.w (a6)+, d6
008C60  ; data: 0x1e, 0x0f
008C62  dc.w   $f078
008C64  moveq  #$3c, d4
008C66  move.w (a6)+, d6
008C68  ; data: 0x1e, 0x0f
008C6A  dc.w   $f078
008C6C  moveq  #$3c, d4
008C6E  move.w (a6)+, d6
008C70  ; data: 0x1e, 0x0f
008C72  dc.w   $f078
008C74  moveq  #$3c, d4
008C76  move.w (a6)+, d6
008C78  ; data: 0x1e, 0x0f
008C7A  bset.b d7, $7fc.w
008C7E  ; data: 0x03, 0xfe
008C80  ; data: 0x01, 0xff
008C82  bset.b d7, $7fc.w
008C86  ; data: 0x03, 0xfe
008C88  ; data: 0x01, 0xff
008C8A  bset.b d7, $7fc.w
008C8E  ; data: 0x03, 0xfe
008C90  ; data: 0x01, 0xff
008C92  bset.b d7, $7fc.w
008C96  ; data: 0x03, 0xfe
008C98  ; data: 0x01, 0xff
008C9A  bset.b d7, $7fc.w
008C9E  ; data: 0x03, 0xfe
008CA0  ; data: 0x01, 0xff
008CA2  bset.b d7, $7fc.w
008CA6  ; data: 0x03, 0xfe
008CA8  ; data: 0x01, 0xff
008CAA  bset.b d7, $7fc.w
008CAE  ; data: 0x03, 0xfe
008CB0  ; data: 0x01, 0xff
008CB2  bset.b d7, $7fc.w
008CB6  ; data: 0x03, 0xfe
008CB8  ; data: 0x01, 0xff
008CBA  ori.b  #$fc, d7
008CBE  ori.b  #$ff, d1
008CC2  ori.b  #$fc, d7
008CC6  ori.b  #$ff, d1
008CCA  ori.b  #$fc, d7
008CCE  ori.b  #$ff, d1
008CD2  ori.b  #$fc, d7
008CD6  ori.b  #$ff, d1
008CDA  ori.b  #$fc, d7
008CDE  ori.b  #$ff, d1
008CE2  ori.b  #$fc, d7
008CE6  ori.b  #$ff, d1
008CEA  ori.b  #$fc, d7
008CEE  ori.b  #$ff, d1
008CF2  ori.b  #$fc, d7
008CF6  ori.b  #$ff, d1
008CFA  ori.b  #$3, d0
008CFE  ; data: 0xff, 0xff
008D00  ; data: 0xff, 0xff
008D02  ori.b  #$3, d0
008D06  ; data: 0xff, 0xff
008D08  ; data: 0xff, 0xff
008D0A  ori.b  #$3, d0
008D0E  ; data: 0xff, 0xff
008D10  ; data: 0xff, 0xff
008D12  ori.b  #$3, d0
008D16  ; data: 0xff, 0xff
008D18  ; data: 0xff, 0xff
008D1A  ori.b  #$3, d0
008D1E  ; data: 0xff, 0xff
008D20  ; data: 0xff, 0xff
008D22  ori.b  #$3, d0
008D26  ; data: 0xff, 0xff
008D28  ; data: 0xff, 0xff
008D2A  ori.b  #$3, d0
008D2E  ; data: 0xff, 0xff
008D30  ; data: 0xff, 0xff
008D32  ori.b  #$3, d0
008D36  ; data: 0xff, 0xff
008D38  ; data: 0xff, 0xff
008D3A  bhi.b  $8cfc
008D3C  ; data: 0xb9, 0xfe
008D3E  move.b d4, (a7)+
008D40  ; data: 0x82, 0x4e
008D42  move.b $30(a0, d1.l), d4
008D46  move.b #$fc, $3090(a4)
008D4C  ; data: 0x2f, 0xf8
008D4E  move.w $8512.w, (a2)+
008D52  ori.b  #$d8, d0
008D56  move.b d0, (a6)
008D58  move.b d0, (a6)
008D5A  ; data: 0x00, 0xbc
008D5C  ; data: 0x00, 0xbc
008D5E  and.l  #$b88e6dce, d0
008D64  dc.w   $f61e
008D6A  ; data: 0x9f, 0x7e
008D6C  ; data: 0x9f, 0x7e
008D6E  sub.w  d7, (a2)
008D70  sub.b  d7, (a2)
008D72  bchg.b d1, -(a4)
008D74  bclr.b d7, d0
008D76  move.l (a0), $16(a3, a0.w)
008D7A  ori.b  #$20, d0
008D7E  exg.l  d1, d6
008D80  exg.l  d1, d6
008D82  ; data: 0xff, 0x86
008D84  ; data: 0xff, 0x86
008D86  move.w d6, -$80(a7, a4.w)
008D8A  sub.l  d3, $fe0(a6)
008D8E  ; data: 0xe1, 0xfa
008D90  movep.l d3, $1920(a6)
008D94  move.b -(a0), -(a4)
008D96  move.b $1fec(a4), -(a4)
008D9A  ; data: 0x3d, 0xfc
008D9C  ; data: 0xf3, 0x7e
008D9E  and.b  d3, (a6)+
008DA0  ; data: 0xbb, 0x7e
008DA2  ori.b  #$de, d0
008DA6  ; data: 0xff, 0xfe
008DA8  ; data: 0xff, 0xfe
008DAA  ; data: 0xff, 0xbe
008DAC  ; data: 0xff, 0xbe
008DAE  ; data: 0xff, 0xbe
008DB0  ; data: 0x80, 0xfe
008DB2  ori.b  #$0, (a0)
008DB6  ori.b  #$4e, d0
008DBA  ; data: 0xe0, 0xfe
008DBC  ; data: 0xe0, 0xfe
008DBE  ; data: 0xe0, 0xfe
008DC0  ; data: 0xe0, 0xfe
008DC2  and.b  d2, d6
008DC4  add.b  d4, d0
008DC6  ; data: 0x18, 0x60
008DC8  negx.l d0
008DCA  ori.b  #$fe, d0
008DCE  ; data: 0xff, 0xfe
008DD0  ; data: 0xff, 0xfe
008DD2  bset.b d3, $7f8.w
008DD6  bset.b d3, $7f00.w
008DDA  cmp.w  -(a0), d4
008DDC  ; data: 0xff, 0xfe
008DDE  ori.b  #$b0, d0
008DE2  ori.b  #$0, d0
008DE6  ori.b  #$0, d0
008DEA  andi.b #$0, d0
008DEE  lsl.l  #$8, d6
008DF0  move.w $0(a0), $0(a7)
008DF6  ori.b  #$0, d0
008DFA  btst.l d3, d0
008DFC  btst.l d3, d0
008DFE  btst.l d3, d0
008E00  ori.l  #$7b4e30fe, d0
008E06  bset.b d4, d2
008E08  ; data: 0xf1, 0xcc
008E0A  and.b  d1, (a6)
008E0C  or.b   (a6), d1
008E0E  or.b   d0, d1
008E10  or.w   d0, -$6a(a0, a7.w)
008E14  move.l #$1f643808, (a3, d0.w)
008E1C  move.b #$88, $3d88(a7)
008E22  add.w  $70(a0, a5.w), d2
008E26  add.w  (a0, d1.l * 4), d2
008E2A  ; data: 0xf1, 0xce
008E2C  addx.b -(a6), -(a3)
008E2E  ; data: 0xe8, 0xf8
008E30  sub.b  -(a0), d7
008E32  ; data: 0xfd, 0xb6
008E34  dc.w   $f2b6
008E36  dc.w   $f2b2
008E38  ; data: 0xf3, 0x82
008E3A  addq.b #$2, d0
008E3C  ori.w  #$31fc, d0
008E40  add.b  (a2), d0
008E42  ori.b  #$80, d0
008E46  and.w  -(a6), d0
008E48  and.w  -(a6), d1
008E4A  ; data: 0x27, 0xf6
008E4C  ; data: 0x27, 0xf6
008E4E  ; data: 0x27, 0xf6
008E50  bsr.w  $cce0
008E54  bset.b d7, ([$41def086])
008E5C  ; data: 0xfd, 0x86
008E5E  ; data: 0xfd, 0x80
008E60  dc.w   $ff70
008E62  ble.b  $8e54
008E64  ; data: 0xf8, 0x7e
008E66  dc.w   $f2fe
008E68  subi.w #$0, ([$fffefffe, a0])
008E72  ; data: 0xff, 0xf6
008E74  ; data: 0xff, 0xf6
008E76  ; data: 0xff, 0xf6
008E78  ; data: 0x81, 0xfe
008E7A  move.b (a0, d0.w), d0
008E7E  ori.b  #$de, d0
008E82  ori.w  #$78, $7e.w
008E88  ; data: 0x00, 0xfe
008E8A  dc.w   $8d4e
008E8C  addx.l d0, d3
008E8E  cmpi.b #$8e, d0
008E92  ori.b  #$fe, d0
008E96  ; data: 0xff, 0xfe
008E98  ; data: 0xff, 0xfe
008E9A  bset.b d1, $3e8(a0)
008E9E  bset.b d1, $7e00(a0)
008EA2  exg.l  d0, d0
008EA4  ; data: 0xff, 0xfe
008EA6  ori.b  #$20, d0
008EAA  ori.b  #$0, d0
008EAE  ori.b  #$0, d0
008EB2  move.b d0, d0
008EB4  ori.b  #$86, d0
008EB8  ; data: 0x1c, 0x60
008EBA  ori.b  #$0, d0
008EBE  ori.b  #$0, d0
008EC2  btst.l d1, d0
008EC4  btst.l d1, d0
008EC6  btst.l d1, d0
008EC8  btst.l d0, d0
008ECA  moveq  #$86, d7
008ECC  moveq  #$e6, d2
008ECE  ; data: 0xa1, 0x86
008ED0  moveq  #$c8, d6
008ED2  ; data: 0x04, 0xf0
008ED4  bra.b  $8ec6
008ED6  bsr.b  $8ec8
008ED8  bvs.b  $8e62
008EDA  sub.l  $8e0e(pc), d2
008EDE  ; data: 0xac, 0x46
008EE0  movem.w #$0, (a2, invalid.w)
008EE6  bchg.b d3, d0
008EE8  move.b d0, d4
008EEA  dc.w   $f416
008EEC  dc.w   $f416
008EEE  dc.w   $f416
008EF0  bcc.b  $8efe
008EF2  eor.b  d5, -(a2)
008EF4  or.b   d1, (a4)+
008EF6  move.w sr, $3f08.w
008EFA  rol.w  d7, d6
008EFC  ; data: 0x8f, 0x7e
008EFE  ; data: 0x9e, 0x7e
008F00  sub.l  $2118(a6), d6
008F04  ; data: 0x08, 0x40
008F06  ; data: 0xa7, 0xce
008F08  ; data: 0x04, 0x8e
008F0A  ori.b  #$b0, d0
008F0E  dc.w   $f8be
008F10  ; data: 0xe7, 0xfe
008F12  bset.b d1, $3f49802(invalid.w)
008F1A  moveq  #$a2, d4
008F1C  bset.b d7, -(a0)
008F1E  ; data: 0xff, 0xfe
008F20  mulu.w -$2(a6, a1.l), d0
008F24  dc.w   $fefe
008F26  ; data: 0xff, 0xfe
008F28  ; data: 0xf9, 0x8e
008F2A  ; data: 0x7f, 0xb8
008F2C  dc.w   $f876
008F2E  bls.b  $8eba
008F30  move.b d0, $0(a1)
008F34  ; data: 0xf9, 0x4e
008F36  rol.w  d3, d6
008F38  ; data: 0xff, 0xfe
008F3A  ; data: 0xff, 0xf6
008F3C  ; data: 0xff, 0xf6
008F3E  ; data: 0xff, 0xf6
008F40  ; data: 0xff, 0xfe
008F42  move.w #$0, d4
008F46  ori.b  #$f6, d0
008F4A  ori.b  #$0, d0
008F4E  ori.b  #$70, d0
008F52  or.b   d6, d0
008F54  move.l d0, $30(a3, d1.l)
008F58  ror.b  d6, d6
008F5A  ori.b  #$fe, d0
008F5E  ; data: 0xff, 0xfe
008F60  ; data: 0xff, 0xfe
008F62  move.b $13f8.w, $3f80000.l
008F6A  dc.w   $8140
008F6C  ; data: 0xff, 0xfe
008F6E  ori.b  #$8, d0
008F72  ori.b  #$0, d0
008F76  ori.b  #$0, d0
008F7A  eori.w #$8, d0
008F7E  ; data: 0xe4, 0xc6
008F80  move.b d0, $0.w
008F84  move.b d0, d0
008F86  ori.b  #$0, d0
008F8A  move.l d0, d1
008F8C  move.l d0, d1
008F8E  andi.b #$0, d0
008F92  ; data: 0x77, 0xa8
008F94  divs.w $105c(pc), d5
008F98  ; data: 0xa8, 0xc2
008F9A  dc.w   $fe16
008F9C  dc.w   $f806
008F9E  mulu.w d6, d1
008FA0  ; data: 0xee, 0xf6
008FA2  or.b   d1, (a4)
008FA4  or.l   (a6)+, d7
008FA6  and.l  d5, $c27c.w
008FAA  ori.b  #$1c, d0
008FAE  bne.b  $8fae
008FB0  btst.l d1, d0
008FB2  move.w a2, d1
008FB4  move.w a2, d1
008FB6  dc.w   $f20a
008FB8  move.l $30(a0, d7.l), d2
008FBC  ; data: 0x08, 0x26
008FBE  negx.b $4820.w
008FC2  ; data: 0xff, 0xf6
008FC4  ; data: 0xfd, 0xfe
008FC6  ; data: 0xc0, 0x3e
008FC8  ror.l  d1, d6
008FCA  ; data: 0xce, 0x0c
008FCC  move.b d0, -$20fe(a1)
008FD0  chk.w  -(a0), d7
008FD2  ori.b  #$a0, d0
008FD6  subx.b d0, d4
008FD8  ; data: 0xfd, 0xbe
008FDA  and.w  d0, d1
008FDC  and.w  d0, d1
008FDE  andi.w #$c43e, d0
008FE2  sub.l  d2, $fffe(invalid.w)
008FE8  cmpa.l (a6)+, a3
008FEA  dc.w   $ff36
008FEC  ; data: 0xf9, 0x3e
008FEE  ; data: 0xc2, 0xfe
008FF0  ; data: 0xec, 0xfe
008FF2  ; data: 0x7d, 0x9c
008FF4  ; data: 0xdf, 0xfe
008FF6  ; data: 0x37, 0xc6
008FF8  bra.b  $903a
008FFA  ori.b  #$1e, d0
008FFE  ; data: 0xe6, 0xfe
009000  ; data: 0xff, 0xbe
009002  dc.w   $fe42
009004  dc.w   $fe42
009006  dc.w   $fe42
009008  ; data: 0xff, 0xde
00900A  ; data: 0x00, 0x3e
00900C  ; data: 0x08, 0x20
00900E  btst.l d4, d0
009010  cmpa.l (a6)+, a7
009012  ; data: 0x06, 0x08
009014  addi.b #$0, d0
009018  move.b d0, -(a7)
00901A  move.l d2, d4
00901C  nbcd.b d0
00901E  ori.b  #$be, $0.w
009024  ; data: 0xff, 0xfe
009026  ; data: 0xff, 0xfe
009028  dc.w   $febe
00902A  ; data: 0xf1, 0xcc
00902C  ; data: 0xf1, 0xcc
00902E  movep.l d0, $400(a4)
009032  asr.w  #$4, d0
009034  ; data: 0xf7, 0xde
009036  btst.l d4, d0
009038  negx.b -(a0)
00903A  ori.b  #$0, d0
00903E  ori.b  #$0, d0
009042  move.b -(a0), (a3)+
009044  move.w d0, (a0)+
009046  dc.w   $f800
009048  move.l d0, d1
00904A  ori.b  #$0, d0
00904E  ori.b  #$40, d0
009052  ori.b  #$30, $30(a0, d0.w)
009058  subi.b #$14, d0
00905C  move.l -(a2), (a4)+
00905E  ; data: 0xa3, 0x68
009060  ; data: 0xc3, 0xce
009062  move.l (a6)+, $276e(a3)
009066  ; data: 0x3f, 0x7e
009068  ; data: 0x3f, 0x7e
00906A  divu.w d0, d5
00906C  subq.w #$5, (a4)+
00906E  cmpa.l a0, a0
009070  ; data: 0xc0, 0x4c
009072  ori.b  #$12, d0
009076  ; data: 0x7b, 0xfe
009078  ; data: 0x17, 0xc0
00907A  sub.b  d0, d4
00907C  sub.w  $70(a0, a1.l), d4
009080  suba.l ([$228c2310, a0], d4.w * 2, $21c), a5
00908A  ; data: 0xff, 0x60
00908C  dc.w   $ff50
00908E  ; data: 0xdf, 0x7c
009090  rol.w  d3, d4
009092  move.w d0, $38e8(a7)
009096  move.w (a6), (a6)
009098  move.w sr, (a4, d0.w)
00909C  ; data: 0x47, 0xe0
00909E  or.b   d0, d2
0090A0  lsr.w  d4, d4
0090A2  ; data: 0xe1, 0xfe
0090A4  asr.b  #$8, d6
0090A6  roxr.b #$2, d6
0090A8  ; data: 0x50, 0xfe
0090AA  dc.w   $fcfe
0090AC  ; data: 0xa1, 0x40
0090AE  ; data: 0xdc, 0xfe
0090B0  ; data: 0xfd, 0xf2
0090B2  move.l (a6)+, $217e(a0)
0090B6  ; data: 0x21, 0x7e
0090B8  ; data: 0x19, 0x7e
0090BA  ; data: 0xf9, 0xbe
0090BC  move.w -$3302(a6), -(a1)
0090C0  bcs.b  $910e
0090C2  ori.b  #$1e, d0
0090C6  ; data: 0xfb, 0xfe
0090C8  ; data: 0xff, 0xec
0090CA  ; data: 0xfb, 0xfe
0090CC  dc.w   $fb16
0090CE  dc.w   $ff16
0090D0  rol.b  d7, d6
0090D2  ori.b  #$42, (a0)+
0090D6  move.b d0, d4
0090D8  ; data: 0xcf, 0xfe
0090DA  ; data: 0xff, 0x80
0090DC  ; data: 0xff, 0x80
0090DE  ; data: 0xff, 0x80
0090E0  ; data: 0xff, 0x80
0090E2  negx.b d0
0090E4  ori.l  #$43009bb2, (a2)
0090EA  ori.b  #$fe, d0
0090EE  ; data: 0xff, 0xfe
0090F0  ; data: 0xff, 0xac
0090F2  ; data: 0x79, 0xf8
0090F4  moveq  #$8, d4
0090F6  ori.b  #$0, (a0)+
0090FA  btst.l d1, d0
0090FC  ; data: 0xdf, 0xbc
0090FE  move.b d0, d4
009100  move.w d0, d0
009102  ori.b  #$0, d0
009106  ori.b  #$0, d0
00910A  bset.b d4, d0
00910C  ; data: 0xc7, 0x80
00910E  move.w d0, d0
009110  ori.b  #$0, d0
009114  ori.b  #$0, d0
009118  ori.b  #$0, (a2)
00911C  bset.b d3, -(a0)
00911E  bset.b d1, -$80(a0, d0.w)
009122  moveq  #$20, d0
009124  ; data: 0xa7, 0xae
009126  lsl.w  d1, d2
009128  ; data: 0x0e, 0x04
00912A  addq.l #$6, a6
00912C  addq.l #$6, (a6)+
00912E  moveq  #$86, d2
009130  move.w a6, (a2)
009132  tst.w  -(a2)
009134  add.w  d3, $8ae4.w
009138  ; data: 0x7d, 0x3e
00913A  ori.b  #$0, d0
00913E  dc.w   $f4f2
009140  adda.w (a4, a6.l), a2
009144  ; data: 0xe9, 0xe0
009146  dc.w   $fe60
009148  ; data: 0xa0, 0x42
00914A  add.w  d2, (a6)+
00914C  moveq  #$c0, d0
00914E  ; data: 0xf3, 0xd2
009150  or.w   (a6)+, d7
009152  ; data: 0x7f, 0xce
009154  ; data: 0x7f, 0x9e
009156  subq.l #$3, d6
009158  chk.w  d2, d3
00915A  move.w d0, (a3)+
00915C  move.w d0, $2(a7, d0.l)
009160  ; data: 0x77, 0xac
009162  ori.b  #$c2, d0
009166  ; data: 0x00, 0x0c
009168  bra.b  $91e0
00916A  suba.l $6e(a6, a1.w), a2
00916E  ; data: 0xc3, 0xfe
009170  ; data: 0x50, 0xbc
009172  ; data: 0xfb, 0xee
009174  ; data: 0x10, 0x08
009176  move.b #$b8, d6
00917A  ; data: 0x7f, 0x8e
00917C  ; data: 0x7f, 0x9e
00917E  beq.b  $9106
009180  move.w a6, -$62(a3, a6.l)
009184  ; data: 0x73, 0x4c
009186  ; data: 0xf6, 0x7e
009188  moveq  #$6c, d2
00918A  ori.b  #$3e, d0
00918E  ; data: 0xff, 0xf2
009190  ; data: 0xff, 0xfe
009192  ; data: 0xff, 0xf6
009194  ; data: 0xff, 0xfe
009196  dc.w   $fc3e
009198  ; data: 0xff, 0x7e
00919A  ori.b  #$6, d0
00919E  ori.b  #$fe, d0
0091A2  divu.w -$20(a0, a0.w), d0
0091A6  cmpa.w $f8fc.w, a4
0091AA  sbcd.b d0, d0
0091AC  ori.l  #$41808b92, (a4, d0.w)
0091B4  ; data: 0xff, 0xfe
0091B6  ; data: 0xff, 0xfe
0091B8  eor.l  d7, d0
0091BA  ; data: 0x7d, 0xf0
0091BC  moveq  #$60, d6
0091BE  ori.b  #$0, -(a0)
0091C2  addi.b #$f8, d0
0091C6  ori.b  #$0, d0
0091CA  ori.b  #$0, d0
0091CE  ori.b  #$0, d0
0091D2  ; data: 0x08, 0x60
0091D4  dc.w   $8382
0091D6  btst.b #$0, d0
0091DA  ori.b  #$0, d0
0091DE  ori.b  #$0, d0
0091E2  ; data: 0x02, 0x08
0091E4  andi.w #$3e0, -(a0)
0091E8  move.b d0, ([$c332, a7], a3.w, $fe1c)
0091F0  move.w d0, $46(a7, d4.w)
0091F4  addq.w #$3, d6
0091F6  bgt.b  $923e
0091F8  bvc.b  $923c
0091FA  movea.l $668e8dcc(a7.l * 4), a3
009202  ori.b  #$1c, d0
009206  dc.w   $f0e2
009208  dc.w   $f0fc
00920A  dc.w   $f802
00920C  ; data: 0xfb, 0xc2
00920E  muls.w d2, d1
009210  ; data: 0x3f, 0xca
009212  ; data: 0x7f, 0x84
009214  move.l a4, -$36c2(a5)
009218  muls.w $2be6(pc), d1
00921C  suba.l a4, a4
00921E  suba.l a4, a4
009220  suba.l (a2)+, a7
009222  moveq  #$80, d0
009224  ; data: 0x7b, 0x70
009226  bls.b  $9286
009228  ; data: 0x0e, 0xca
00922A  ori.b  #$c2, d0
00922E  ori.b  #$1e, (a4)+
009232  ; data: 0x06, 0xe8
009234  ; data: 0x04, 0x7c
009236  ; data: 0x01, 0xfc
009238  asl.w  $7e(a4, a7.w)
00923C  move.b (a0), d4
00923E  move.w d0, (a3)+
009240  move.w #$67c6, d6
009244  beq.b  $920c
009246  ble.b  $920e
009248  ble.b  $920c
00924A  add.w  -$6808(a6), d0
00924E  divs.w (a0), d7
009250  ; data: 0x1c, 0xcc
009252  ori.b  #$3e, d0
009256  ; data: 0xff, 0xe2
009258  ; data: 0xff, 0xfe
00925A  dc.w   $feea
00925C  ; data: 0xff, 0xfe
00925E  ; data: 0xfc, 0x7e
009260  ; data: 0xff, 0x7e
009262  ori.b  #$8e, d0
009266  ori.b  #$fa, d0
00926A  or.b   $8038.w, d0
00926E  dc.w   $f038
009270  dc.w   $f03c
009272  abcd.b d2, d7
009274  or.l   d0, d2
009276  ori.b  #$32, -(a0)
00927A  ori.b  #$fe, d0
00927E  ; data: 0xff, 0xfe
009280  ; data: 0xff, 0xe0
009282  dc.w   $fee8
009284  dc.w   $fc40
009286  ori.w  #$2100, d0
00928A  bclr.b d6, d0
00928C  ; data: 0x17, 0xf0
00928E  ori.b  #$4, d0
009292  ori.b  #$0, d0
009296  ori.b  #$0, d0
00929A  ori.l  #$73061000, (a0)
0092A0  ori.b  #$0, d0
0092A4  ori.b  #$0, d0
0092A8  ori.b  #$14, d0
0092AC  ori.w  #$3fc0, d0
0092B0  move.w d0, $34(a7, d2.w)
0092B4  ; data: 0x39, 0xf4
0092B6  ; data: 0x8f, 0x3e
0092B8  move.l d2, d0
0092BA  dc.w   $4100
0092BC  movep.w $3308(a0), d0
0092C0  move.l $984a(pc), -(a1)
0092C4  roxl.l #$1, d0
0092C6  ; data: 0xab, 0x48
0092C8  bclr.b d0, (a4, d0.w)
0092CC  ; data: 0xc4, 0x3e
0092CE  dc.w   $f836
0092D0  ; data: 0x58, 0x3e
0092D2  dc.w   $f002
0092D4  dc.w   $f716
0092D6  asl.l  #$8, d2
0092D8  ; data: 0x1f, 0xf8
0092DA  ; data: 0x7b, 0xc6
0092DC  ; data: 0xcc, 0x0e
0092DE  ; data: 0x90, 0xbe
0092E0  rol.l  #$8, d4
0092E2  ; data: 0xbf, 0xbe
0092E4  eor.l  d7, ([$a3fee9d8, a3.l * 4], $4670)
0092EE  addx.b d4, d0
0092F0  add.w  d2, d7
0092F2  ori.b  #$c0, d0
0092F6  ; data: 0x00, 0x08
0092F8  ; data: 0x80, 0x0e
0092FA  bclr.b d7, $828.w
0092FE  move.l #$ffc6a0b6, (a1, d0.l * 8)
009306  ble.b  $9348
009308  ; data: 0x1e, 0x7c
00930A  mulu.w $c0fc.w, d0
00930E  cmpa.w #$a3fe, a7
009312  asl.w  -(a6)
009314  suba.w $6f4a(a4), a7
009318  move.b d0, d4
00931A  ori.b  #$3e, d0
00931E  ; data: 0xff, 0xf6
009320  ; data: 0xff, 0xfe
009322  ; data: 0xff, 0xb2
009324  ; data: 0xff, 0xf6
009326  ; data: 0xfc, 0x7e
009328  dc.w   $fefe
00932A  ; data: 0x00, 0x08
00932C  dc.w   $ff5e
00932E  ori.b  #$fe, d0
009332  ori.b  #$0, d0
009336  negx.b d0
009338  addq.b #$6, d0
00933A  dc.w   $fe00
00933C  or.b   d0, d0
00933E  ori.l  #$e7fe0000, ([$fffe7ff0])
00934A  ; data: 0xff, 0xb2
00934C  dc.w   $f806
00934E  ori.b  #$0, d0
009352  move.b d0, $3e0(a7)
009356  ori.b  #$2, d0
00935A  ori.b  #$0, d0
00935E  ori.b  #$0, d0
009362  ori.b  #$2, d0
009366  ori.b  #$0, d0
00936A  ori.b  #$0, d0
00936E  ori.b  #$0, d0
009372  ; data: 0x00, 0x4c
009374  ; data: 0x00, 0x08
009376  move.b d0, (a7, d0.w)
00937A  moveq  #$7e, d4
00937C  movea.w (a0)+, a1
00937E  rol.l  d7, d4
009380  ; data: 0xf1, 0x02
009382  ; data: 0x08, 0x00
009384  move.b (a0), d0
009386  move.l a0, d2
009388  ; data: 0x9f, 0x7a
00938A  move.l $e016(invalid.w), $3de0(a5)
009392  ori.b  #$6, d0
009396  dc.w   $f81e
009398  addq.b #$4, (a0)+
00939A  add.b  (a6), d4
00939C  add.b  d5, (a6)+
00939E  asr.b  #$3, d2
0093A0  bset.b d2, (a6)+
0093A2  moveq  #$8a, d6
0093A4  exg.l  a5, a0
0093A6  ror.l  d0, d4
0093A8  ; data: 0x0c, 0x8c
0093AA  rol.b  #$1, d6
0093AC  dc.w   $f12e
0093AE  and.w  d3, $7e(a6, a3.l)
0093B2  ; data: 0x13, 0x3e
0093B4  btst.l d3, -(a0)
0093B6  divs.w $ff3a.w, d4
0093BA  ori.b  #$f8, d0
0093BE  ori.b  #$2, d0
0093C2  ; data: 0x1b, 0xc0
0093C4  move.b -(a0), $267c(a4)
0093C8  dc.w   $fea6
0093CA  cmpm.w (a0)+, (a1)+
0093CC  ori.b  #$42, d6
0093D0  move.w -$7a(a0, d1.l), $eb626fe.l
0093D8  ; data: 0x87, 0x7e
0093DA  sub.b  d1, -(a2)
0093DC  cmpa.w (a2)+, a6
0093DE  ; data: 0x16, 0x3e
0093E0  move.w d0, (a0)
0093E2  ori.b  #$6, d0
0093E6  ; data: 0xff, 0xfe
0093E8  ; data: 0xff, 0xfa
0093EA  ; data: 0xfb, 0xc6
0093EC  ; data: 0xff, 0xfe
0093EE  ; data: 0xf9, 0xfe
0093F0  ; data: 0xff, 0xbe
0093F2  ori.b  #$5e, (a4, d0.w)
0093F8  ; data: 0xcc, 0xfe
0093FA  ori.w  #$40, -(a0)
0093FE  move.b d0, d4
009400  ; data: 0x7f, 0x80
009402  ; data: 0x0c, 0xc2
009404  ; data: 0x80, 0x88
009406  bsr.b  $93c8
009408  ; data: 0xce, 0x7e
00940A  ori.b  #$fe, d0
00940E  ; data: 0xff, 0xfe
009410  ; data: 0x3f, 0xfc
009412  bset.b d1, d6
009414  movep.w $0(a6), d0
009418  ori.w  #$1c80, d0
00941C  bset.b d7, -(a0)
00941E  ori.b  #$e, d0
009422  ori.b  #$0, d0
009426  ori.b  #$0, d0
00942A  bra.w  $11030
00942E  ori.b  #$80, d0
009432  ori.b  #$0, d0
009436  ori.b  #$0, d0
00943A  subi.b #$0, $1f00.w
009440  ori.b  #$2a, d0
009444  rol.l  #$3, d0
009446  move.l #$7906215a, $19a(a7)
00944E  bsr.b  $93d2
009450  ; data: 0x7b, 0xba
009452  ; data: 0x18, 0x6a
009454  ror.w  d3, d2
009456  ; data: 0xa5, 0x14
009458  ; data: 0xf7, 0xe2
00945A  ori.b  #$26, d0
00945E  dc.w   $f82e
009460  and.b  d2, d4
009462  ; data: 0xbc, 0x0e
009464  cmp.l  a6, d6
009466  ; data: 0xa0, 0x8e
009468  ; data: 0x2f, 0xc6
00946A  ; data: 0x75, 0xe8
00946C  adda.w (a0)+, a4
00946E  move.l #$6fa7dda, (a4)+
009474  ; data: 0x7d, 0x9a
009476  ; data: 0x79, 0x82
009478  or.w   (a2), d6
00947A  bclr.b d3, d4
00947C  ; data: 0x15, 0xe0
00947E  mulu.w d2, d0
009480  dc.w   $edfa
009482  ori.b  #$d8, d0
009486  ori.b  #$2, (a0)
00948A  moveq  #$d0, d7
00948C  ; data: 0x7d, 0xb0
00948E  chk.w  #$ffbe, d4
009492  dc.w   $fe2a
009494  subi.b #$2, d6
009498  ; data: 0x00, 0xc2
00949A  ; data: 0x3d, 0xda
00949C  move.w (a2)+, ([, d6.w], $73aa)
0094A2  or.l   d7, (a2)+
0094A4  add.b  (a6)+, d7
0094A6  move.b (a2), -(a7)
0094A8  bset.b d0, d4
0094AA  ori.b  #$26, d0
0094AE  ; data: 0xff, 0xee
0094B0  ; data: 0xff, 0xe2
0094B2  dc.w   $fede
0094B4  ; data: 0xff, 0xfe
0094B6  ; data: 0xd7, 0xfe
0094B8  ; data: 0xff, 0xbe
0094BA  ori.b  #$ce, (a4)
0094BE  ; data: 0x08, 0x00
0094C0  ; data: 0xff, 0xfc
0094C2  and.b  d1, $74(a4, a4.w)
0094C6  sub.w  #$fffc, d7
0094CA  or.w   -(a0), d0
0094CC  and.b  (a2)+, d0
0094CE  move.l -$1c2(a4), (a0)+
0094D2  ori.b  #$fe, d0
0094D6  ; data: 0xff, 0xfe
0094D8  ; data: 0x3f, 0xec
0094DA  ; data: 0x02, 0xde
0094DC  ; data: 0x00, 0x0e
0094DE  move.l d0, d0
0094E0  ori.w  #$9c0, d0
0094E4  bset.b d5, (a0, d0.l)
0094E8  ; data: 0xf9, 0x06
0094EA  ori.b  #$0, d0
0094EE  ori.b  #$0, d0
0094F2  moveq  #$4, d0
0094F4  move.w d0, d4
0094F6  negx.b d0
0094F8  ori.b  #$0, d0
0094FC  ori.b  #$0, d0
009500  ori.b  #$20, (a0)
009504  ori.b  #$0, d0
009508  ori.b  #$60, d0
00950C  muls.w $3ffe(a2), d5
009510  sub.l  $6adc(a2), d6
009514  bpl.b  $94f2
009516  moveq  #$fc, d5
009518  blt.b  $9516
00951A  or.l   #$cede8fde, d2
009520  adda.l -(a6), a5
009522  ori.b  #$7a, d0
009526  moveq  #$3e, d6
009528  ; data: 0x0c, 0x0a
00952A  move.w (a6)+, $3f5e(a7)
00952E  move.l a4, $3dc4(a3)
009532  add.l  $10676(pc), d6
009536  ; data: 0x3e, 0xfe
009538  bchg.b d1, $f7fce7bc(invalid.w)
009540  sbcd.b d4, d6
009542  ; data: 0x02, 0xec
009544  move.l d0, $e822df16.l
00954A  ori.b  #$84, d0
00954E  or.b   d0, d0
009550  dc.w   $f038
009552  add.w  d7, -$2098(a0)
009556  ; data: 0xc7, 0x7e
009558  ror.b  d2, d6
00955A  dc.w   $ff5e
00955C  or.l   d4, d1
00955E  and.b  d0, d0
009560  or.w   d2, d0
009562  moveq  #$cc, d7
009564  moveq  #$cc, d7
009566  moveq  #$c8, d7
009568  bge.b  $9562
00956A  dc.w   $fefc
00956C  dc.w   $fc3e
00956E  ; data: 0x19, 0xf2
009570  move.l $0(a0), (a0)+
009574  ; data: 0x83, 0x7a
009576  ; data: 0xff, 0xfe
009578  ; data: 0xff, 0xfa
00957A  ; data: 0xdf, 0xfe
00957C  ; data: 0xdf, 0xfe
00957E  ; data: 0xdf, 0xfe
009580  ; data: 0xfd, 0xbe
009582  ori.b  #$c6, d0
009586  ; data: 0x0e, 0x00
009588  ; data: 0xff, 0xfe
00958A  ; data: 0xc1, 0xfe
00958C  ; data: 0xc1, 0xfe
00958E  ; data: 0xd1, 0xfe
009590  ; data: 0xf3, 0xfe
009592  dc.w   $4102
009594  or.b   $60c(a6), d0
009598  ; data: 0xff, 0x1e
00959A  ori.b  #$fe, d0
00959E  ; data: 0xff, 0xfe
0095A0  ; data: 0xef, 0xfe
0095A2  move.l (a6), d0
0095A4  move.l (a6), d0
0095A6  move.l d0, d0
0095A8  ; data: 0x1b, 0xc0
0095AA  andi.b #$f8, -(a0)
0095AE  ; data: 0x0e, 0x00
0095B0  moveq  #$80, d6
0095B2  ori.b  #$0, d0
0095B6  ori.b  #$0, d0
0095BA  ori.b  #$0, d0
0095BE  ori.b  #$a0, d0
0095C2  ori.b  #$0, d0
0095C6  ori.b  #$30, d0
0095CA  ori.b  #$0, d0
0095CE  move.b d0, d4
0095D0  ori.b  #$e8, d0
0095D4  ; data: 0xae, 0xa2
0095D6  ; data: 0x5b, 0x3c
0095D8  ; data: 0x00, 0x0e
0095DA  sub.b  $34(a4, a1.w), d3
0095DE  sub.b  #$3c, d1
0095E2  ; data: 0x1c, 0x8c
0095E4  add.l  d3, ([$172e0000, a6])
0095EC  bset.b d0, (a4)
0095EE  moveq  #$de, d0
0095F0  move.b d6, (a0)+
0095F2  ; data: 0x3b, 0xde
0095F4  ; data: 0x3b, 0xde
0095F6  ; data: 0x3b, 0xc4
0095F8  moveq  #$0, d5
0095FA  dc.w   $4d00
0095FC  dc.w   $f402
0095FE  ; data: 0xdb, 0xfe
009600  ; data: 0x00, 0xf8
009602  ror.b  d1, d6
009604  ror.b  d1, d6
009606  roxr.l #$1, d6
009608  dc.w   $fe32
00960A  ; data: 0x85, 0x7c
00960C  bcs.b  $9596
00960E  dc.w   $f0a2
009610  dc.w   $f36e
009612  ori.b  #$20, d0
009616  or.w   -(a0), d0
009618  ror.w  d0, d6
00961A  adda.l -(a0), a5
00961C  adda.l -(a0), a5
00961E  ; data: 0xdb, 0xfe
009620  ; data: 0xc3, 0xfe
009622  ; data: 0xf6, 0x7e
009624  ori.b  #$0, d0
009628  dc.w   $fe10
00962A  dc.w   $fa20
00962C  dc.w   $fe20
00962E  dc.w   $fe28
009630  dc.w   $fe0c
009632  dc.w   $f75c
009634  ; data: 0xfa, 0x7e
009636  sub.w  $890(a2), d0
00963A  ori.b  #$de, d0
00963E  ; data: 0xff, 0xfe
009640  ; data: 0xff, 0xfe
009642  ; data: 0xdb, 0xfe
009644  ; data: 0xdb, 0xfe
009646  ; data: 0xdb, 0xfe
009648  ; data: 0xfb, 0xfe
00964A  ori.b  #$82, d0
00964E  subi.b #$fe, d0
009652  ; data: 0x81, 0xfe
009654  ; data: 0x81, 0xfe
009656  ; data: 0x81, 0xfe
009658  ; data: 0x81, 0xfe
00965A  ; data: 0x08, 0x82
00965C  or.b   d2, d0
00965E  btst.l d7, (a4)
009660  ; data: 0xff, 0xfe
009662  ori.b  #$fe, d0
009666  ; data: 0xff, 0xbe
009668  ; data: 0xdf, 0xbe
00966A  move.l (a6)+, d2
00966C  move.l (a6)+, d2
00966E  move.l d0, d2
009670  ; data: 0x3f, 0xc0
009672  btst.l d5, d0
009674  ; data: 0x3f, 0xfc
009676  subi.b #$20, d0
00967A  ori.b  #$0, d0
00967E  ori.b  #$0, d0
009682  ori.b  #$0, -(a0)
009686  ori.b  #$0, d0
00968A  ori.b  #$0, d0
00968E  ori.b  #$30, -(a0)
009692  ori.b  #$0, d0
009696  ori.b  #$c0, d0
00969A  bhi.b  $96bc
00969C  ; data: 0x7b, 0x18
00969E  ; data: 0x7f, 0xfe
0096A0  ; data: 0x50, 0xbe
0096A2  divs.w $1a9e(pc), d1
0096A6  divs.w $229e(pc), d1
0096AA  dc.w   $480e
0096AC  roxr.w (a2)+
0096AE  movea.l $a160(pc), a5
0096B2  ori.b  #$30, d0
0096B6  move.b (a4)+, (a6)+
0096B8  move.b d0, (a6)+
0096BA  move.l $23ec(a4), $23e01c56.l
0096C2  sub.l  (a4)+, d5
0096C4  dc.w   $fa62
0096C6  add.w  #$c0fc, d7
0096CA  adda.l $74c6(pc), a6
0096CE  adda.l $94c4(pc), a6
0096D2  ; data: 0x97, 0x3e
0096D4  eori.b #$a, -(a4)
0096D8  ; data: 0xff, 0xae
0096DA  ori.b  #$c0, d0
0096DE  ; data: 0xa0, 0x22
0096E0  ; data: 0xb0, 0x3e
0096E2  muls.w ([$cbfedfc8], $612e), d5
0096EC  bclr.b d0, -(a0)
0096EE  ori.b  #$18, d0
0096F2  ; data: 0xff, 0xf8
0096F4  ; data: 0xff, 0xf8
0096F6  ; data: 0xff, 0xf8
0096F8  ; data: 0xfb, 0xf2
0096FA  cmpa.w -$f02(a6), a1
0096FE  ; data: 0x73, 0xcc
009700  andi.l #$d13e, d0
009706  ; data: 0xbf, 0xfe
009708  ; data: 0xbf, 0xfe
00970A  ; data: 0xcb, 0xfe
00970C  ; data: 0xcb, 0xfe
00970E  ; data: 0xcb, 0xfe
009710  ; data: 0xdf, 0xfe
009712  ori.b  #$20, d0
009716  ori.b  #$7e, d0
00971A  ori.b  #$6, d6
00971E  ori.b  #$e, d6
009722  ; data: 0x4c, 0x00
009724  btst.l d3, d0
009726  ori.b  #$fe, (a0, d0.w)
00972C  ; data: 0xff, 0xfe
00972E  ; data: 0xff, 0xfe
009730  ; data: 0xff, 0xfe
009732  move.w a4, d7
009734  move.w a4, d7
009736  move.w d0, d7
009738  move.l d0, -$40(a7, d0.w)
00973C  ; data: 0xff, 0xde
00973E  ori.b  #$80, d0
009742  ori.b  #$0, d0
009746  ori.b  #$0, d0
00974A  negx.b (a0)
00974C  move.l d0, d0
00974E  subi.b #$0, d0
009752  ori.b  #$0, d0
009756  ori.b  #$20, -(a0)
00975A  ori.b  #$0, d0
00975E  ori.b  #$80, d0
009762  ; data: 0xa0, 0x2e
009764  cmpa.w -$52(a0, d0.l), a6
009768  ; data: 0x98, 0x3e
00976A  exg.l  d1, d0
00976C  exg.l  d1, d0
00976E  mulu.w d0, d0
009770  ; data: 0xc6, 0x48
009772  move.w ([$4880]), -$6040(a4)
00977A  ori.b  #$c8, d0
00977E  move.b $9d0c(invalid.w), $9d0c9d0c.l
009788  add.w  (a6)+, d0
00978A  moveq  #$7e, d3
00978C  ; data: 0xf3, 0x3e
00978E  addx.l -(a6), -(a7)
009790  dc.w   $f066
009792  move.l a2, ([, d2.w * 2], $248a)
009798  move.w (a2)+, -(a6)
00979A  bsr.b  $97b8
00979C  bclr.b d2, d0
00979E  and.b  d0, d0
0097A0  dbpl   d6, $97a2
0097A4  subi.b #$6, $26(a0, a6.w)
0097AA  move.b ([$1d325f80, a2, d1.l * 4], $e87e), -(a6)
0097B4  bset.b d3, (a0)
0097B6  roxr.w d0, d0
0097B8  bclr.b d3, (a4)+
0097BA  muls.w $c3f8.w, d1
0097BE  mulu.w $c278.w, d0
0097C2  suba.w -(a2), a0
0097C4  ; data: 0xfd, 0xfe
0097C6  ; data: 0xcf, 0xbe
0097C8  bset.b d3, d0
0097CA  ori.b  #$ce, d0
0097CE  ; data: 0xff, 0xf6
0097D0  ; data: 0xff, 0xe6
0097D2  ; data: 0xfd, 0x3e
0097D4  ; data: 0xfd, 0x3e
0097D6  ; data: 0xfd, 0x3e
0097D8  ; data: 0xdf, 0xfe
0097DA  ori.b  #$10, (a0, d0.w)
0097E0  ; data: 0xf7, 0x3e
0097E2  move.w d6, d6
0097E4  move.w d6, d6
0097E6  move.w d6, -(a7)
0097E8  move.w d6, ([$2003878])
0097F0  ; data: 0xe2, 0xfe
0097F2  ori.b  #$fe, d0
0097F6  ; data: 0xff, 0xfe
0097F8  ; data: 0xff, 0xde
0097FA  bset.b d0, d0
0097FC  bset.b d0, d0
0097FE  bset.b d0, d0
009800  move.w d0, (d0.w * 2)
009804  ; data: 0xff, 0xee
009806  ori.b  #$c0, d0
00980A  ori.b  #$0, d0
00980E  ori.b  #$0, d0
009812  ; data: 0xbf, 0xfe
009814  negx.b d0
009816  ori.b  #$0, d0
00981A  ori.b  #$0, d0
00981E  ori.b  #$0, d0
009822  andi.b #$0, d0
009826  andi.b #$80, d0
00982A  addq.w #$2, d0
00982C  dc.w   $f008
00982E  move.b $86e(a4), (a6)+
009832  ; data: 0x00, 0xf8
009834  ; data: 0x00, 0xf8
009836  move.b $1fb8.w, -(a4)
00983A  eori.w #$f0b2, $180.w
009840  ; data: 0x7f, 0xca
009842  ori.b  #$f8, d0
009846  bset.b d0, -(a0)
009848  bclr.b d0, d0
00984A  ; data: 0x96, 0x3e
00984C  ; data: 0x96, 0x3e
00984E  ; data: 0x96, 0x3e
009850  ; data: 0xa0, 0x9e
009852  or.w   d7, -(a4)
009854  ; data: 0xff, 0xf6
009856  ; data: 0xff, 0xfe
009858  dc.w   $f02e
00985A  ; data: 0x3f, 0xfa
00985C  ; data: 0x3f, 0xfa
00985E  move.l $b89a(pc), (a7)
009862  ; data: 0x79, 0xe8
009864  or.w   d7, -(a0)
009866  bsr.w  $45b0
00986A  ori.b  #$0, d0
00986E  and.b  (a6)+, d1
009870  and.b  (a6)+, d1
009872  sub.b  -(a0), d3
009874  sub.b  -(a0), d3
009876  sub.b  -(a0), d3
009878  subi.l #$f3640fe0, d0
00987E  asr.w  ([$f800f8])
009886  move.b $1fb8.w, -(a0)
00988A  or.b   d6, d0
00988C  ; data: 0xff, 0xfe
00988E  dc.w   $fe9e
009890  ; data: 0x02, 0xbc
009892  ori.b  #$fe, d0
009896  ; data: 0xff, 0xfe
009898  ; data: 0xff, 0xbe
00989A  dc.w   $f63e
00989C  dc.w   $f63e
00989E  dc.w   $f63e
0098A0  ; data: 0x84, 0xfe
0098A2  ; data: 0x00, 0x7a
0098A4  ori.b  #$0, d0
0098A8  ; data: 0xfa, 0x7e
0098AA  ; data: 0xff, 0x06
0098AC  ; data: 0xff, 0x06
0098AE  ; data: 0xff, 0xc6
0098B0  ; data: 0xff, 0xc6
0098B2  dc.w   $ff5e
0098B4  ori.b  #$68, d0
0098B8  dc.w   $f002
0098BA  ori.b  #$fe, d0
0098BE  ; data: 0xff, 0xfe
0098C0  ; data: 0xff, 0x9e
0098C2  divu.w d0, d4
0098C4  divu.w d0, d4
0098C6  divu.w d0, d4
0098C8  beq.w  $994a
0098CC  ; data: 0xff, 0xfe
0098CE  ori.b  #$80, d0
0098D2  ori.b  #$0, d0
0098D6  ori.b  #$0, d0
0098DA  dc.w   $ff5e
0098DC  move.l d0, d0
0098DE  ori.b  #$f4, d0
0098E2  ori.b  #$0, d0
0098E6  ori.b  #$60, d0
0098EA  sbcd.b d0, d0
0098EC  sbcd.b d0, d0
0098EE  sbcd.b d0, d0
0098F0  move.b d0, d4
0098F2  bset.b d0, d0
0098F4  move.w (a4)+, (a6)+
0098F6  cmpa.w a6, a6
0098F8  ori.b  #$0, d0
0098FC  ori.b  #$0, d0
009900  ori.b  #$0, d0
009904  ori.b  #$0, d0
009908  ori.b  #$0, d0
00990C  ori.b  #$0, d0
009910  ori.b  #$0, d0
009914  ori.b  #$0, d0
009918  ori.b  #$0, d0
00991C  eor.b  d7, (a0)+
00991E  move.w d0, d6
009920  ori.b  #$0, d0
009924  ori.b  #$0, d0
009928  ori.b  #$0, d0
00992C  ori.b  #$0, d0
009930  ori.b  #$0, d0
009934  ori.b  #$0, d0
009938  ori.b  #$0, d0
00993C  ori.b  #$0, d0
009940  ori.b  #$e0, d0
009944  negx.b (a2)+
009946  ori.b  #$0, d0
00994A  ori.b  #$0, d0
00994E  ori.b  #$0, d0
009952  ori.b  #$0, d0
009956  ori.b  #$0, d0
00995A  ori.b  #$0, d0
00995E  ori.b  #$0, d0
009962  ori.b  #$0, d0
009966  ori.b  #$0, d0
00996A  andi.b #$e6, -(a0)
00996E  ; data: 0xff, 0xfe
009970  ori.b  #$0, d0
009974  ori.b  #$0, d0
009978  ori.b  #$0, d0
00997C  ori.b  #$0, d0
009980  ori.b  #$0, d0
009984  ori.b  #$0, d0
009988  ori.b  #$0, d0
00998C  ori.b  #$0, d0
009990  ori.b  #$c0, d0
009994  ; data: 0xff, 0xfe
009996  ; data: 0xff, 0xfe
009998  ori.b  #$0, d0
00999C  ori.b  #$0, d0
0099A0  ori.b  #$0, d0
0099A4  ori.b  #$0, d0
0099A8  ori.b  #$0, d0
0099AC  ori.b  #$0, d0
0099B0  ori.b  #$0, d0
0099B4  ori.b  #$0, d0
0099B8  ori.b  #$e0, d0
0099BC  move.b #$82, d2
0099C0  ori.b  #$0, d0
0099C4  ori.b  #$0, d0
0099C8  ori.b  #$0, d0
0099CC  ori.b  #$0, d0
0099D0  ori.b  #$0, d0
0099D4  ori.b  #$0, d0
0099D8  ori.b  #$0, d0
0099DC  ori.b  #$0, d0
0099E0  ori.b  #$0, d0
0099E4  move.b $b5e6(pc), (a4, d0.w)
0099EA  ori.b  #$0, d0
0099EE  ori.b  #$0, d0
0099F2  ori.b  #$0, d0
0099F6  ori.b  #$0, d0
0099FA  ori.b  #$0, d0
0099FE  ori.b  #$0, d0
009A02  ori.b  #$0, d0
009A06  ori.b  #$0, d0
009A0A  divs.w $3e(a0, a6.w), d6
009A0E  ori.b  #$0, d0
009A12  ori.b  #$0, d0
009A16  ori.b  #$0, d0
009A1A  ori.b  #$0, d0
009A1E  ori.b  #$0, d0
009A22  ori.b  #$0, d0
009A26  ori.b  #$0, d0
009A2A  ori.b  #$0, d0
009A2E  ori.b  #$0, d0
009A32  or.b   (a0), d4
009A34  ; data: 0xff, 0xc0
009A36  ; data: 0xff, 0xfe
009A38  ori.b  #$0, d0
009A3C  ori.b  #$0, d0
009A40  ori.b  #$0, d0
009A44  ori.b  #$0, d0
009A48  ori.b  #$0, d0
009A4C  ori.b  #$0, d0
009A50  ori.b  #$0, d0
009A54  ori.b  #$0, d0
009A58  ori.b  #$e0, d0
009A5C  ; data: 0xff, 0xfe
009A5E  ; data: 0xff, 0xfe
009A60  ori.b  #$0, d0
009A64  ori.b  #$0, d0
009A68  ori.b  #$0, d0
009A6C  ori.b  #$0, d0
009A70  ori.b  #$0, d0
009A74  ori.b  #$0, d0
009A78  ori.b  #$0, d0
009A7C  ori.b  #$0, d0
009A80  ori.b  #$f0, d0
009A84  move.b $bfae.w, (a4)
009A88  ori.b  #$0, d0
009A8C  ori.b  #$0, d0
009A90  ori.b  #$0, d0
009A94  ori.b  #$0, d0
009A98  ori.b  #$0, d0
009A9C  ori.b  #$0, d0
009AA0  ori.b  #$0, d0
009AA4  ori.b  #$0, d0
009AA8  ori.b  #$80, d0
009AAC  btst.l d0, (d3.l * 2)
009AB0  ori.b  #$0, d0
009AB4  ori.b  #$0, d0
009AB8  ori.b  #$0, d0
009ABC  ori.b  #$0, d0
009AC0  ori.b  #$0, d0
009AC4  ori.b  #$0, d0
009AC8  ori.b  #$0, d0
009ACC  ori.b  #$0, d0
009AD0  ori.b  #$7c, d0
009AD4  ror.b  d0, d6
009AD6  move.l d4, -(a1)
009AD8  ori.b  #$0, d0
009ADC  ori.b  #$0, d0
009AE0  ori.b  #$0, d0
009AE4  ori.b  #$0, d0
009AE8  ori.b  #$0, d0
009AEC  ori.b  #$0, d0
009AF0  ori.b  #$0, d0
009AF4  ori.b  #$0, d0
009AF8  ori.b  #$c, d0
009AFC  ; data: 0xfd, 0xc0
009AFE  adda.w $9b00(pc), a6
009B02  ori.b  #$0, d0
009B06  ori.b  #$0, d0
009B0A  ori.b  #$0, d0
009B0E  ori.b  #$0, d0
009B12  ori.b  #$0, d0
009B16  ori.b  #$0, d0
009B1A  ori.b  #$0, d0
009B1E  ori.b  #$0, d0
009B22  divs.w ([$ff7e0000]), d7
009B2A  ori.b  #$0, d0
009B2E  ori.b  #$0, d0
009B32  ori.b  #$0, d0
009B36  ori.b  #$0, d0
009B3A  ori.b  #$0, d0
009B3E  ori.b  #$0, d0
009B42  ori.b  #$0, d0
009B46  ori.b  #$0, d0
009B4A  suba.l (a6)+, a5
009B4C  move.w ([], a3.l * 8), -(a0)
009B52  ori.b  #$0, d0
009B56  ori.b  #$0, d0
009B5A  ori.b  #$0, d0
009B5E  ori.b  #$0, d0
009B62  ori.b  #$0, d0
009B66  ori.b  #$0, d0
009B6A  ori.b  #$0, d0
009B6E  ori.b  #$0, d0
009B72  dc.w   $8586
009B74  ; data: 0x20, 0x3e
009B76  move.w d6, (a7, d0.w)
009B7A  ori.b  #$0, d0
009B7E  ori.b  #$0, d0
009B82  ori.b  #$0, d0
009B86  ori.b  #$0, d0
009B8A  ori.b  #$0, d0
009B8E  ori.b  #$0, d0
009B92  ori.b  #$0, d0
009B96  ori.b  #$0, d0
009B9A  addq.w #$4, $c03e.w
009B9E  addi.b #$0, d6
009BA2  ori.b  #$0, d0
009BA6  ori.b  #$0, d0
009BAA  ori.b  #$0, d0
009BAE  ori.b  #$0, d0
009BB2  ori.b  #$0, d0
009BB6  ori.b  #$0, d0
009BBA  ori.b  #$0, d0
009BBE  ori.b  #$0, d0
009BC2  ; data: 0xd0, 0x3e
009BC4  ; data: 0xf9, 0xc0
009BC6  ; data: 0xf9, 0xf8
009BC8  ori.b  #$0, d0
009BCC  ori.b  #$0, d0
009BD0  ori.b  #$0, d0
009BD4  ori.b  #$0, d0
009BD8  ori.b  #$0, d0
009BDC  ori.b  #$0, d0
009BE0  ori.b  #$0, d0
009BE4  ori.b  #$0, d0
009BE8  ori.b  #$c0, d0
009BEC  ; data: 0xff, 0xfe
009BEE  ; data: 0xfe, 0x7e
009BF0  ori.b  #$0, d0
009BF4  ori.b  #$0, d0
009BF8  ori.b  #$0, d0
009BFC  ori.b  #$0, d0
009C00  ori.b  #$0, d0
009C04  ori.b  #$0, d0
009C08  ori.b  #$0, d0
009C0C  ori.b  #$0, d0
009C10  ori.b  #$7e, d0
009C14  move.l d2, d0
009C16  ; data: 0x77, 0xa6
009C18  ori.b  #$0, d0
009C1C  ori.b  #$0, d0
009C20  ori.b  #$0, d0
009C24  ori.b  #$0, d0
009C28  ori.b  #$0, d0
009C2C  ori.b  #$0, d0
009C30  ori.b  #$0, d0
009C34  ori.b  #$0, d0
009C38  ori.b  #$82, d0
009C3C  ori.b  #$a6, (a4)+
009C40  ori.b  #$0, d0
009C44  ori.b  #$0, d0
009C48  ori.b  #$0, d0
009C4C  ori.b  #$0, d0
009C50  ori.b  #$0, d0
009C54  ori.b  #$0, d0
009C58  ori.b  #$0, d0
009C5C  ori.b  #$0, d0
009C60  ori.b  #$fc, d0
009C64  and.b  (a4)+, d0
009C66  bclr.b d2, -(a6)
009C68  ori.b  #$0, d0
009C6C  ori.b  #$0, d0
009C70  ori.b  #$0, d0
009C74  ori.b  #$0, d0
009C78  ori.b  #$0, d0
009C7C  ori.b  #$0, d0
009C80  ori.b  #$0, d0
009C84  ori.b  #$0, d0
009C88  ori.b  #$7a, d0
009C8C  dc.w   $f062
009C8E  dc.w   $fa58
009C90  ori.b  #$0, d0
009C94  ori.b  #$0, d0
009C98  ori.b  #$0, d0
009C9C  ori.b  #$0, d0
009CA0  ori.b  #$0, d0
009CA4  ori.b  #$0, d0
009CA8  ori.b  #$0, d0
009CAC  ori.b  #$0, d0
009CB0  ori.b  #$84, d0
009CB4  ; data: 0xff, 0xfe
009CB6  ; data: 0xfd, 0xfe
009CB8  ori.b  #$0, d0
009CBC  ori.b  #$0, d0
009CC0  ori.b  #$0, d0
009CC4  ori.b  #$0, d0
009CC8  ori.b  #$0, d0
009CCC  ori.b  #$0, d0
009CD0  ori.b  #$0, d0
009CD4  ori.b  #$0, d0
009CD8  ori.b  #$98, d0
009CDC  move.w (a0)+, (a3)+
009CDE  move.w d4, $0.w
009CE2  ori.b  #$0, d0
009CE6  ori.b  #$0, d0
009CEA  ori.b  #$0, d0
009CEE  ori.b  #$0, d0
009CF2  ori.b  #$0, d0
009CF6  ori.b  #$0, d0
009CFA  ori.b  #$0, d0
009CFE  ori.b  #$0, d0
009D02  or.b   d0, d0
009D04  addi.l #$77c40000, $0(a0)
009D0C  ori.b  #$0, d0
009D10  ori.b  #$0, d0
009D14  ori.b  #$0, d0
009D18  ori.b  #$0, d0
009D1C  ori.b  #$0, d0
009D20  ori.b  #$0, d0
009D24  ori.b  #$0, d0
009D28  ori.b  #$3e, d0
009D2C  ; data: 0xd8, 0x0a
009D2E  dc.w   $8746
009D30  ori.b  #$0, d0
009D34  ori.b  #$0, d0
009D38  ori.b  #$0, d0
009D3C  ori.b  #$0, d0
009D40  ori.b  #$0, d0
009D44  ori.b  #$0, d0
009D48  ori.b  #$0, d0
009D4C  ori.b  #$0, d0
009D50  ori.b  #$fe, d0
009D54  dc.w   $fef6
009D56  dc.w   $f8ba
009D58  ori.b  #$0, d0
009D5C  ori.b  #$0, d0
009D60  ori.b  #$0, d0
009D64  ori.b  #$0, d0
009D68  ori.b  #$0, d0
009D6C  ori.b  #$0, d0
009D70  ori.b  #$0, d0
009D74  ori.b  #$0, d0
009D78  ori.b  #$c0, d0
009D7C  rol.w  d0, d6
009D7E  ; data: 0xff, 0x7e
009D80  ori.b  #$0, d0
009D84  ori.b  #$0, d0
009D88  ori.b  #$0, d0
009D8C  ori.b  #$0, d0
009D90  ori.b  #$0, d0
009D94  ori.b  #$0, d0
009D98  ori.b  #$0, d0
009D9C  ori.b  #$0, d0
009DA0  ori.b  #$20, d0
009DA4  ; data: 0x17, 0xc8
009DA6  ; data: 0x30, 0xfe
009DA8  ori.b  #$0, d0
009DAC  ori.b  #$0, d0
009DB0  ori.b  #$0, d0
009DB4  ori.b  #$0, d0
009DB8  ori.b  #$0, d0
009DBC  ori.b  #$0, d0
009DC0  ori.b  #$0, d0
009DC4  ori.b  #$0, d0
009DC8  ori.b  #$0, d0
009DCC  move.l $fffe.w, d3
009DD0  ori.b  #$0, d0
009DD4  ori.b  #$0, d0
009DD8  ori.b  #$0, d0
009DDC  ori.b  #$0, d0
009DE0  ori.b  #$0, d0
009DE4  ori.b  #$0, d0
009DE8  ori.b  #$0, d0
009DEC  ori.b  #$0, d0
009DF0  ori.b  #$7e, d0
009DF4  and.b  d6, d5
009DF6  ; data: 0x0d, 0xfc
009DF8  ori.b  #$0, d0
009DFC  ori.b  #$0, d0
009E00  ori.b  #$0, d0
009E04  ori.b  #$0, d0
009E08  ori.b  #$0, d0
009E0C  ori.b  #$0, d0
009E10  ori.b  #$0, d0
009E14  ori.b  #$0, d0
009E18  ori.b  #$fe, d0
009E1C  ; data: 0xfc, 0x7e
009E1E  dc.w   $f002
009E20  ori.b  #$0, d0
009E24  ori.b  #$0, d0
009E28  ori.b  #$0, d0
009E2C  ori.b  #$0, d0
009E30  ori.b  #$0, d0
009E34  ori.b  #$0, d0
009E38  ori.b  #$0, d0
009E3C  ori.b  #$0, d0
009E40  ori.b  #$80, d0
009E44  ; data: 0xf3, 0xfe
009E46  ; data: 0xff, 0xfe
009E48  ori.b  #$0, d0
009E4C  ori.b  #$0, d0
009E50  ori.b  #$0, d0
009E54  ori.b  #$0, d0
009E58  ori.b  #$0, d0
009E5C  ori.b  #$0, d0
009E60  ori.b  #$0, d0
009E64  ori.b  #$0, d0
009E68  ori.b  #$20, d0
009E6C  move.b d0, $4c(a3, d3.w)
009E70  ori.b  #$0, d0
009E74  ori.b  #$0, d0
009E78  ori.b  #$0, d0
009E7C  ori.b  #$0, d0
009E80  ori.b  #$0, d0
009E84  ori.b  #$0, d0
009E88  ori.b  #$0, d0
009E8C  ori.b  #$0, d0
009E90  ori.b  #$20, d0
009E94  btst.l d2, ([])
009E9A  ori.b  #$0, d0
009E9E  ori.b  #$0, d0
009EA2  ori.b  #$0, d0
009EA6  ori.b  #$0, d0
009EAA  ori.b  #$0, d0
009EAE  ori.b  #$0, d0
009EB2  ori.b  #$0, d0
009EB6  ori.b  #$0, d0
009EBA  ; data: 0xff, 0xbe
009EBC  lsr.b  #$8, d6
009EBE  dc.w   $adc
009EC0  ori.b  #$0, d0
009EC4  ori.b  #$0, d0
009EC8  ori.b  #$0, d0
009ECC  ori.b  #$0, d0
009ED0  ori.b  #$0, d0
009ED4  ori.b  #$0, d0
009ED8  ori.b  #$0, d0
009EDC  ori.b  #$0, d0
009EE0  ori.b  #$de, d0
009EE4  ; data: 0xfd, 0x7e
009EE6  dc.w   $f022
009EE8  ori.b  #$0, d0
009EEC  ori.b  #$0, d0
009EF0  ori.b  #$0, d0
009EF4  ori.b  #$0, d0
009EF8  ori.b  #$0, d0
009EFC  ori.b  #$0, d0
009F00  ori.b  #$0, d0
009F04  ori.b  #$0, d0
009F08  ori.b  #$60, d0
009F0C  dc.w   $fafe
009F0E  ; data: 0xff, 0xfe
009F10  ori.b  #$0, d0
009F14  ori.b  #$0, d0
009F18  ori.b  #$0, d0
009F1C  ori.b  #$0, d0
009F20  ori.b  #$0, d0
009F24  ori.b  #$0, d0
009F28  ori.b  #$0, d0
009F2C  ori.b  #$0, d0
009F30  ori.b  #$76, d0
009F34  or.w   d0, d7
009F36  move.l (a6)+, d4
009F38  ori.b  #$0, d0
009F3C  ori.b  #$0, d0
009F40  ori.b  #$0, d0
009F44  ori.b  #$0, d0
009F48  ori.b  #$0, d0
009F4C  ori.b  #$0, d0
009F50  ori.b  #$0, d0
009F54  ori.b  #$0, d0
009F58  ori.b  #$f0, d0
009F5C  suba.l (invalid.w), a2
009F62  ori.b  #$0, d0
009F66  ori.b  #$0, d0
009F6A  ori.b  #$0, d0
009F6E  ori.b  #$0, d0
009F72  ori.b  #$0, d0
009F76  ori.b  #$0, d0
009F7A  ori.b  #$0, d0
009F7E  ori.b  #$0, d0
009F82  dc.w   $f02e
009F84  bcc.b  $9fd4
009F86  ; data: 0x5f, 0xbc
009F88  ori.b  #$0, d0
009F8C  ori.b  #$0, d0
009F90  ori.b  #$0, d0
009F94  ori.b  #$0, d0
009F98  ori.b  #$0, d0
009F9C  ori.b  #$0, d0
009FA0  ori.b  #$0, d0
009FA4  ori.b  #$0, d0
009FA8  ori.b  #$de, d0
009FAC  dc.w   $f83e
009FAE  asr.b  #$8, d2
009FB0  ori.b  #$0, d0
009FB4  ori.b  #$0, d0
009FB8  ori.b  #$0, d0
009FBC  ori.b  #$0, d0
009FC0  ori.b  #$0, d0
009FC4  ori.b  #$0, d0
009FC8  ori.b  #$0, d0
009FCC  ori.b  #$0, d0
009FD0  ori.b  #$20, d0
009FD4  ; data: 0xff, 0xfe
009FD6  ; data: 0xff, 0xfe
009FD8  ori.b  #$0, d0
009FDC  ori.b  #$0, d0
009FE0  ori.b  #$0, d0
009FE4  ori.b  #$0, d0
009FE8  ori.b  #$0, d0
009FEC  ori.b  #$0, d0
009FF0  ori.b  #$0, d0
009FF4  ori.b  #$0, d0
009FF8  ori.b  #$3e, d0
009FFC  ; data: 0x08, 0x44
009FFE  addq.l #$6, (a6)+
00A000  ori.b  #$0, d0
00A004  ori.b  #$0, d0
00A008  ori.b  #$0, d0
00A00C  ori.b  #$0, d0
00A010  ori.b  #$0, d0
00A014  ori.b  #$0, d0
00A018  ori.b  #$0, d0
00A01C  ori.b  #$0, d0
00A020  ori.b  #$b0, d0
00A024  divs.w -(a6), d1
00A026  rol.w  d1, d0
00A028  ori.b  #$0, d0
00A02C  ori.b  #$0, d0
00A030  ori.b  #$0, d0
00A034  ori.b  #$0, d0
00A038  ori.b  #$0, d0
00A03C  ori.b  #$0, d0
00A040  ori.b  #$0, d0
00A044  ori.b  #$0, d0
00A048  ori.b  #$4e, d0
00A04C  moveq  #$58, d1
00A04E  move.w $0(a4), (a7)+
00A052  ori.b  #$0, d0
00A056  ori.b  #$0, d0
00A05A  ori.b  #$0, d0
00A05E  ori.b  #$0, d0
00A062  ori.b  #$0, d0
00A066  ori.b  #$0, d0
00A06A  ori.b  #$0, d0
00A06E  ori.b  #$0, d0
00A072  ; data: 0x2f, 0xbe
00A074  dc.w   $fc3e
00A076  and.b  (a2), d0
00A078  ori.b  #$0, d0
00A07C  ori.b  #$0, d0
00A080  ori.b  #$0, d0
00A084  ori.b  #$0, d0
00A088  ori.b  #$0, d0
00A08C  ori.b  #$0, d0
00A090  ori.b  #$0, d0
00A094  ori.b  #$0, d0
00A098  ori.b  #$0, d0
00A09C  ; data: 0xff, 0xfe
00A09E  ; data: 0xff, 0xfe
00A0A0  ori.b  #$0, d0
00A0A4  ori.b  #$0, d0
00A0A8  ori.b  #$0, d0
00A0AC  ori.b  #$0, d0
00A0B0  ori.b  #$0, d0
00A0B4  ori.b  #$0, d0
00A0B8  ori.b  #$0, d0
00A0BC  ori.b  #$0, d0
00A0C0  ori.b  #$de, d0
00A0C4  neg.b  (a0)+
00A0C6  moveq  #$64, d5
00A0C8  ori.b  #$0, d0
00A0CC  ori.b  #$0, d0
00A0D0  ori.b  #$0, d0
00A0D4  ori.b  #$0, d0
00A0D8  ori.b  #$0, d0
00A0DC  ori.b  #$0, d0
00A0E0  ori.b  #$0, d0
00A0E4  ori.b  #$0, d0
00A0E8  ori.b  #$0, d0
00A0EC  ; data: 0xcb, 0xfe
00A0EE  and.l  d2, (a6)+
00A0F0  ori.b  #$0, d0
00A0F4  ori.b  #$0, d0
00A0F8  ori.b  #$0, d0
00A0FC  ori.b  #$0, d0
00A100  ori.b  #$0, d0
00A104  ori.b  #$0, d0
00A108  ori.b  #$0, d0
00A10C  ori.b  #$0, d0
00A110  ori.b  #$3e, d0
00A114  move.w d0, $3fe4(a1)
00A118  ori.b  #$0, d0
00A11C  ori.b  #$0, d0
00A120  ori.b  #$0, d0
00A124  ori.b  #$0, d0
00A128  ori.b  #$0, d0
00A12C  ori.b  #$0, d0
00A130  ori.b  #$0, d0
00A134  ori.b  #$0, d0
00A138  ori.b  #$5e, d0
00A13C  dc.w   $fc3e
00A13E  and.b  (a2)+, d0
00A140  ori.b  #$0, d0
00A144  ori.b  #$0, d0
00A148  ori.b  #$0, d0
00A14C  ori.b  #$0, d0
00A150  ori.b  #$0, d0
00A154  ori.b  #$0, d0
00A158  ori.b  #$0, d0
00A15C  ori.b  #$0, d0
00A160  ori.b  #$80, d0
00A164  ; data: 0xff, 0xfe
00A166  ; data: 0xff, 0xfe
00A168  ori.b  #$0, d0
00A16C  ori.b  #$0, d0
00A170  ori.b  #$0, d0
00A174  ori.b  #$0, d0
00A178  ori.b  #$0, d0
00A17C  ori.b  #$0, d0
00A180  ori.b  #$0, d0
00A184  ori.b  #$0, d0
00A188  ori.b  #$b8, d0
00A18C  ror.b  #$8, d4
00A18E  ; data: 0x77, 0x60
00A190  ori.b  #$0, d0
00A194  ori.b  #$0, d0
00A198  ori.b  #$0, d0
00A19C  ori.b  #$0, d0
00A1A0  ori.b  #$0, d0
00A1A4  ori.b  #$0, d0
00A1A8  ori.b  #$0, d0
00A1AC  ori.b  #$0, d0
00A1B0  ori.b  #$80, d0
00A1B4  ; data: 0xe7, 0xfe
00A1B6  ror.l  d0, d6
00A1B8  ori.b  #$0, d0
00A1BC  ori.b  #$0, d0
00A1C0  ori.b  #$0, d0
00A1C4  ori.b  #$0, d0
00A1C8  ori.b  #$0, d0
00A1CC  ori.b  #$0, d0
00A1D0  ori.b  #$0, d0
00A1D4  ori.b  #$0, d0
00A1D8  ori.b  #$1e, d0
00A1DC  ; data: 0x1a, 0x40
00A1DE  bset.b d7, -(a0)
00A1E0  ori.b  #$0, d0
00A1E4  ori.b  #$0, d0
00A1E8  ori.b  #$0, d0
00A1EC  ori.b  #$0, d0
00A1F0  ori.b  #$0, d0
00A1F4  ori.b  #$0, d0
00A1F8  ori.b  #$0, d0
00A1FC  ori.b  #$0, d0
00A200  ori.b  #$be, d0
00A204  dc.w   $fc3e
00A206  dc.w   $f81e
00A208  ori.b  #$0, d0
00A20C  ori.b  #$0, d0
00A210  ori.b  #$0, d0
00A214  ori.b  #$0, d0
00A218  ori.b  #$0, d0
00A21C  ori.b  #$0, d0
00A220  ori.b  #$0, d0
00A224  ori.b  #$0, d0
00A228  ori.b  #$c0, d0
00A22C  ; data: 0xff, 0xfe
00A22E  ; data: 0xf7, 0xfe
00A230  ori.b  #$0, d0
00A234  ori.b  #$0, d0
00A238  ori.b  #$0, d0
00A23C  ori.b  #$0, d0
00A240  ori.b  #$0, d0
00A244  ori.b  #$0, d0
00A248  ori.b  #$0, d0
00A24C  ori.b  #$0, d0
00A250  ori.b  #$50, d0
00A254  moveq  #$4e, d6
00A256  moveq  #$0, d6
00A258  ori.b  #$0, d0
00A25C  ori.b  #$0, d0
00A260  ori.b  #$0, d0
00A264  ori.b  #$0, d0
00A268  ori.b  #$0, d0
00A26C  ori.b  #$0, d0
00A270  ori.b  #$0, d0
00A274  ori.b  #$0, d0
00A278  ori.b  #$70, d0
00A27C  ; data: 0xff, 0xce
00A27E  divs.w (a6)+, d0
00A280  ori.b  #$0, d0
00A284  ori.b  #$0, d0
00A288  ori.b  #$0, d0
00A28C  ori.b  #$0, d0
00A290  ori.b  #$0, d0
00A294  ori.b  #$0, d0
00A298  ori.b  #$0, d0
00A29C  ori.b  #$0, d0
00A2A0  ori.b  #$8e, d0
00A2A4  bset.b d1, (a0, invalid.w)
00A2A8  ori.b  #$0, d0
00A2AC  ori.b  #$0, d0
00A2B0  ori.b  #$0, d0
00A2B4  ori.b  #$0, d0
00A2B8  ori.b  #$0, d0
00A2BC  ori.b  #$0, d0
00A2C0  ori.b  #$0, d0
00A2C4  ori.b  #$0, d0
00A2C8  ori.b  #$fe, d0
00A2CC  dc.w   $fc3e
00A2CE  dc.w   $f8be
00A2D0  ori.b  #$0, d0
00A2D4  ori.b  #$0, d0
00A2D8  ori.b  #$0, d0
00A2DC  ori.b  #$0, d0
00A2E0  ori.b  #$0, d0
00A2E4  ori.b  #$0, d0
00A2E8  ori.b  #$0, d0
00A2EC  ori.b  #$0, d0
00A2F0  ori.b  #$e0, d0
00A2F4  ; data: 0xff, 0xfe
00A2F6  ; data: 0xff, 0xfe
00A2F8  ori.b  #$0, d0
00A2FC  ori.b  #$0, d0
00A300  ori.b  #$0, d0
00A304  ori.b  #$0, d0
00A308  ori.b  #$0, d0
00A30C  ori.b  #$0, d0
00A310  ori.b  #$0, d0
00A314  ori.b  #$0, d0
00A318  ori.b  #$ec, d0
00A31C  add.b  d6, d0
00A31E  ; data: 0xf9, 0x60
00A320  ori.b  #$0, d0
00A324  ori.b  #$0, d0
00A328  ori.b  #$0, d0
00A32C  ori.b  #$0, d0
00A330  ori.b  #$0, d0
00A334  ori.b  #$0, d0
00A338  ori.b  #$0, d0
00A33C  ori.b  #$0, d0
00A340  ori.b  #$c, d0
00A344  adda.l d6, a1
00A346  ; data: 0x06, 0xde
00A348  ori.b  #$0, d0
00A34C  ori.b  #$0, d0
00A350  ori.b  #$0, d0
00A354  ori.b  #$0, d0
00A358  ori.b  #$0, d0
00A35C  ori.b  #$0, d0
00A360  ori.b  #$0, d0
00A364  ori.b  #$0, d0
00A368  ori.b  #$12, d0
00A36C  move.l $1600.w, (a7)
00A370  ori.b  #$0, d0
00A374  ori.b  #$0, d0
00A378  ori.b  #$0, d0
00A37C  ori.b  #$0, d0
00A380  ori.b  #$0, d0
00A384  ori.b  #$0, d0
00A388  ori.b  #$0, d0
00A38C  ori.b  #$0, d0
00A390  ori.b  #$8e, d0
00A394  ; data: 0xfe, 0x7e
00A396  ; data: 0xf9, 0xfe
00A398  ori.b  #$0, d0
00A39C  ori.b  #$0, d0
00A3A0  ori.b  #$0, d0
00A3A4  ori.b  #$0, d0
00A3A8  ori.b  #$0, d0
00A3AC  ori.b  #$0, d0
00A3B0  ori.b  #$0, d0
00A3B4  ori.b  #$0, d0
00A3B8  ori.b  #$60, d0
00A3BC  ; data: 0xfd, 0xfe
00A3BE  ; data: 0xef, 0xfe
00A3C0  ori.b  #$0, d0
00A3C4  ori.b  #$0, d0
00A3C8  ori.b  #$0, d0
00A3CC  ori.b  #$0, d0
00A3D0  ori.b  #$0, d0
00A3D4  ori.b  #$0, d0
00A3D8  ori.b  #$0, d0
00A3DC  ori.b  #$0, d0
00A3E0  ori.b  #$8e, d0
00A3E4  dc.w   $f206
00A3E6  ; data: 0x3f, 0xe0
00A3E8  ori.b  #$0, d0
00A3EC  ori.b  #$0, d0
00A3F0  ori.b  #$0, d0
00A3F4  ori.b  #$0, d0
00A3F8  ori.b  #$0, d0
00A3FC  ori.b  #$0, d0
00A400  ori.b  #$0, d0
00A404  ori.b  #$0, d0
00A408  ori.b  #$4c, d0
00A40C  ; data: 0xf1, 0x86
00A40E  ori.b  #$0, (a6)+
00A412  ori.b  #$0, d0
00A416  ori.b  #$0, d0
00A41A  ori.b  #$0, d0
00A41E  ori.b  #$0, d0
00A422  ori.b  #$0, d0
00A426  ori.b  #$0, d0
00A42A  ori.b  #$0, d0
00A42E  ori.b  #$0, d0
00A432  roxr.b #$8, d2
00A434  bset.b d6, $3000.w
00A438  ori.b  #$0, d0
00A43C  ori.b  #$0, d0
00A440  ori.b  #$0, d0
00A444  ori.b  #$0, d0
00A448  ori.b  #$0, d0
00A44C  ori.b  #$0, d0
00A450  ori.b  #$0, d0
00A454  ori.b  #$0, d0
00A458  ori.b  #$e, d0
00A45C  ; data: 0xff, 0xfe
00A45E  ; data: 0xff, 0xfe
00A460  ori.b  #$0, d0
00A464  ori.b  #$0, d0
00A468  ori.b  #$0, d0
00A46C  ori.b  #$0, d0
00A470  ori.b  #$0, d0
00A474  ori.b  #$0, d0
00A478  ori.b  #$0, d0
00A47C  ori.b  #$0, d0
00A480  ori.b  #$e0, d0
00A484  ; data: 0xfe, 0x7e
00A486  ; data: 0xcf, 0xfe
00A488  ori.b  #$0, d0
00A48C  ori.b  #$0, d0
00A490  ori.b  #$0, d0
00A494  ori.b  #$0, d0
00A498  ori.b  #$0, d0
00A49C  ori.b  #$0, d0
00A4A0  ori.b  #$0, d0
00A4A4  ori.b  #$0, d0
00A4A8  ori.b  #$9a, d0
00A4AC  dc.w   $f8b6
00A4AE  ; data: 0x1f, 0xf2
00A4B0  ori.b  #$0, d0
00A4B4  ori.b  #$0, d0
00A4B8  ori.b  #$0, d0
00A4BC  ori.b  #$0, d0
00A4C0  ori.b  #$0, d0
00A4C4  ori.b  #$0, d0
00A4C8  ori.b  #$0, d0
00A4CC  ori.b  #$0, d0
00A4D0  ori.b  #$f8, d0
00A4D4  ; data: 0xff, 0xb6
00A4D6  ; data: 0x00, 0x0c
00A4D8  ori.b  #$0, d0
00A4DC  ori.b  #$0, d0
00A4E0  ori.b  #$0, d0
00A4E4  ori.b  #$0, d0
00A4E8  ori.b  #$0, d0
00A4EC  ori.b  #$0, d0
00A4F0  ori.b  #$0, d0
00A4F4  ori.b  #$0, d0
00A4F8  ori.b  #$86, d0
00A4FC  ; data: 0x00, 0x48
00A4FE  addq.l #$6, d0
00A500  ori.b  #$0, d0
00A504  ori.b  #$0, d0
00A508  ori.b  #$0, d0
00A50C  ori.b  #$0, d0
00A510  ori.b  #$0, d0
00A514  ori.b  #$0, d0
00A518  ori.b  #$0, d0
00A51C  ori.b  #$0, d0
00A520  ori.b  #$9e, d0
00A524  ; data: 0xff, 0xfe
00A526  ; data: 0xff, 0xfe
00A528  ori.b  #$0, d0
00A52C  ori.b  #$0, d0
00A530  ori.b  #$0, d0
00A534  ori.b  #$0, d0
00A538  ori.b  #$0, d0
00A53C  ori.b  #$0, d0
00A540  ori.b  #$0, d0
00A544  ori.b  #$0, d0
00A548  ori.b  #$60, d0
00A54C  ; data: 0xff, 0xfe
00A54E  ; data: 0xa3, 0x7e
00A550  ori.b  #$0, d0
00A554  ori.b  #$0, d0
00A558  ori.b  #$0, d0
00A55C  ori.b  #$0, d0
00A560  ori.b  #$0, d0
00A564  ori.b  #$0, d0
00A568  ori.b  #$0, d0
00A56C  ori.b  #$0, d0
00A570  ori.b  #$e, d0
00A574  dc.w   $f8f6
00A576  bset.b d7, $0.w
00A57A  ori.b  #$0, d0
00A57E  ori.b  #$0, d0
00A582  ori.b  #$0, d0
00A586  ori.b  #$0, d0
00A58A  ori.b  #$0, d0
00A58E  ori.b  #$0, d0
00A592  ori.b  #$0, d0
00A596  ori.b  #$0, d0
00A59A  ; data: 0x16, 0x58
00A59C  ; data: 0xf7, 0xf6
00A59E  ori.b  #$0, d4
00A5A2  ori.b  #$0, d0
00A5A6  ori.b  #$0, d0
00A5AA  ori.b  #$0, d0
00A5AE  ori.b  #$0, d0
00A5B2  ori.b  #$0, d0
00A5B6  ori.b  #$0, d0
00A5BA  ori.b  #$0, d0
00A5BE  ori.b  #$0, d0
00A5C2  asr.b  d4, d6
00A5C4  ; data: 0x00, 0x08
00A5C6  move.l d0, (a2)
00A5C8  ori.b  #$0, d0
00A5CC  ori.b  #$0, d0
00A5D0  ori.b  #$0, d0
00A5D4  ori.b  #$0, d0
00A5D8  ori.b  #$0, d0
00A5DC  ori.b  #$0, d0
00A5E0  ori.b  #$0, d0
00A5E4  ori.b  #$0, d0
00A5E8  ori.b  #$1e, d0
00A5EC  ; data: 0xff, 0xfe
00A5EE  ; data: 0xff, 0xfe
00A5F0  ori.b  #$0, d0
00A5F4  ori.b  #$0, d0
00A5F8  ori.b  #$0, d0
00A5FC  ori.b  #$0, d0
00A600  ori.b  #$0, d0
00A604  ori.b  #$0, d0
00A608  ori.b  #$0, d0
00A60C  ori.b  #$0, d0
00A610  ori.b  #$e0, d0
00A614  ; data: 0xff, 0xfe
00A616  ; data: 0xdb, 0x7e
00A618  ori.b  #$0, d0
00A61C  ori.b  #$0, d0
00A620  ori.b  #$0, d0
00A624  ori.b  #$0, d0
00A628  ori.b  #$0, d0
00A62C  ori.b  #$0, d0
00A630  ori.b  #$0, d0
00A634  ori.b  #$0, d0
00A638  ori.b  #$fe, d0
00A63C  ; data: 0xf9, 0x66
00A63E  bset.b d6, $0.w
00A642  ori.b  #$0, d0
00A646  ori.b  #$0, d0
00A64A  ori.b  #$0, d0
00A64E  ori.b  #$0, d0
00A652  ori.b  #$0, d0
00A656  ori.b  #$0, d0
00A65A  ori.b  #$0, d0
00A65E  ori.b  #$0, d0
00A662  move.l -$181a(a0), $204.w
00A668  ori.b  #$0, d0
00A66C  ori.b  #$0, d0
00A670  ori.b  #$0, d0
00A674  ori.b  #$0, d0
00A678  ori.b  #$0, d0
00A67C  ori.b  #$0, d0
00A680  ori.b  #$0, d0
00A684  ori.b  #$0, d0
00A688  ori.b  #$6, d0
00A68C  ori.b  #$0, (a0)+
00A690  ori.b  #$0, d0
00A694  ori.b  #$0, d0
00A698  ori.b  #$0, d0
00A69C  ori.b  #$0, d0
00A6A0  ori.b  #$0, d0
00A6A4  ori.b  #$0, d0
00A6A8  ori.b  #$0, d0
00A6AC  ori.b  #$0, d0
00A6B0  ori.b  #$9e, d0
00A6B4  ; data: 0xff, 0xfe
00A6B6  ; data: 0xff, 0xfe
00A6B8  ori.b  #$0, d0
00A6BC  ori.b  #$0, d0
00A6C0  ori.b  #$0, d0
00A6C4  ori.b  #$0, d0
00A6C8  ori.b  #$0, d0
00A6CC  ori.b  #$0, d0
00A6D0  ori.b  #$0, d0
00A6D4  ori.b  #$0, d0
00A6D8  ori.b  #$e0, d0
00A6DC  ; data: 0xff, 0xfe
00A6DE  ; data: 0xaf, 0xfe
00A6E0  ori.b  #$0, d0
00A6E4  ori.b  #$0, d0
00A6E8  ori.b  #$0, d0
00A6EC  ori.b  #$0, d0
00A6F0  ori.b  #$0, d0
00A6F4  ori.b  #$0, d0
00A6F8  ori.b  #$0, d0
00A6FC  ori.b  #$0, d0
00A700  ori.b  #$ee, d0
00A704  dc.w   $fe8e
00A706  ; data: 0x0f, 0xfc
00A708  ori.b  #$0, d0
00A70C  ori.b  #$0, d0
00A710  ori.b  #$0, d0
00A714  ori.b  #$0, d0
00A718  ori.b  #$0, d0
00A71C  ori.b  #$0, d0
00A720  ori.b  #$0, d0
00A724  ori.b  #$0, d0
00A728  ori.b  #$f8, d0
00A72C  sbcd   -(a6), -(a0)
00A730  ori.b  #$0, d0
00A734  ori.b  #$0, d0
00A738  ori.b  #$0, d0
00A73C  ori.b  #$0, d0
00A740  ori.b  #$0, d0
00A744  ori.b  #$0, d0
00A748  ori.b  #$0, d0
00A74C  ori.b  #$0, d0
00A750  ori.b  #$6, d0
00A754  ori.w  #$2040, (a0, d0.w)
00A75A  ori.b  #$0, d0
00A75E  ori.b  #$0, d0
00A762  ori.b  #$0, d0
00A766  ori.b  #$0, d0
00A76A  ori.b  #$0, d0
00A76E  ori.b  #$0, d0
00A772  ori.b  #$0, d0
00A776  ori.b  #$0, d0
00A77A  abcd.b -(a6), -(a3)
00A77C  ; data: 0xff, 0xfe
00A77E  ; data: 0xff, 0xfe
00A780  ori.b  #$0, d0
00A784  ori.b  #$0, d0
00A788  ori.b  #$0, d0
00A78C  ori.b  #$0, d0
00A790  ori.b  #$0, d0
00A794  ori.b  #$0, d0
00A798  ori.b  #$0, d0
00A79C  ori.b  #$0, d0
00A7A0  ori.b  #$f0, d0
00A7A4  ; data: 0xff, 0xfe
00A7A6  ; data: 0xdf, 0xbe
00A7A8  ori.b  #$0, d0
00A7AC  ori.b  #$0, d0
00A7B0  ori.b  #$0, d0
00A7B4  ori.b  #$0, d0
00A7B8  ori.b  #$0, d0
00A7BC  ori.b  #$0, d0
00A7C0  ori.b  #$0, d0
00A7C4  ori.b  #$0, d0
00A7C8  ori.b  #$ba, d0
00A7CC  eor.l  d0, $1df8(a6)
00A7D0  ori.b  #$0, d0
00A7D4  ori.b  #$0, d0
00A7D8  ori.b  #$0, d0
00A7DC  ori.b  #$0, d0
00A7E0  ori.b  #$0, d0
00A7E4  ori.b  #$0, d0
00A7E8  ori.b  #$0, d0
00A7EC  ori.b  #$0, d0
00A7F0  ori.b  #$26, d0
00A7F4  and.w  $0(a6), d0
00A7F8  ori.b  #$0, d0
00A7FC  ori.b  #$0, d0
00A800  ori.b  #$0, d0
00A804  ori.b  #$0, d0
00A808  ori.b  #$0, d0
00A80C  ori.b  #$0, d0
00A810  ori.b  #$0, d0
00A814  ori.b  #$0, d0
00A818  ori.b  #$5c, d0
00A81C  ori.b  #$80, (a0)
00A820  ori.b  #$0, d0
00A824  ori.b  #$0, d0
00A828  ori.b  #$0, d0
00A82C  ori.b  #$0, d0
00A830  ori.b  #$0, d0
00A834  ori.b  #$0, d0
00A838  ori.b  #$0, d0
00A83C  ori.b  #$0, d0
00A840  ori.b  #$82, d0
00A844  ; data: 0xff, 0xfe
00A846  ; data: 0xff, 0xfe
00A848  ori.b  #$0, d0
00A84C  ori.b  #$0, d0
00A850  ori.b  #$0, d0
00A854  ori.b  #$0, d0
00A858  ori.b  #$0, d0
00A85C  ori.b  #$0, d0
00A860  ori.b  #$0, d0
00A864  ori.b  #$0, d0
00A868  ori.b  #$fc, d0
00A86C  ; data: 0xff, 0xfe
00A86E  ; data: 0xff, 0x7e
00A870  ori.b  #$0, d0
00A874  ori.b  #$0, d0
00A878  ori.b  #$0, d0
00A87C  ori.b  #$0, d0
00A880  ori.b  #$0, d0
00A884  ori.b  #$0, d0
00A888  ori.b  #$0, d0
00A88C  ori.b  #$0, d0
00A890  ori.b  #$de, d0
00A894  ; data: 0xeb, 0xfe
00A896  ; data: 0xfc, 0x7e
00A898  ori.b  #$0, d0
00A89C  ori.b  #$0, d0
00A8A0  ori.b  #$0, d0
00A8A4  ori.b  #$0, d0
00A8A8  ori.b  #$0, d0
00A8AC  ori.b  #$0, d0
00A8B0  ori.b  #$0, d0
00A8B4  ori.b  #$0, d0
00A8B8  ori.b  #$d2, d0
00A8BC  ; data: 0xc0, 0x3e
00A8BE  ori.b  #$0, d0
00A8C2  ori.b  #$0, d0
00A8C6  ori.b  #$0, d0
00A8CA  ori.b  #$0, d0
00A8CE  ori.b  #$0, d0
00A8D2  ori.b  #$0, d0
00A8D6  ori.b  #$0, d0
00A8DA  ori.b  #$0, d0
00A8DE  ori.b  #$0, d0
00A8E2  moveq  #$2c, d6
00A8E4  ori.b  #$40, d0
00A8E8  ori.b  #$0, d0
00A8EC  ori.b  #$0, d0
00A8F0  ori.b  #$0, d0
00A8F4  ori.b  #$0, d0
00A8F8  ori.b  #$0, d0
00A8FC  ori.b  #$0, d0
00A900  ori.b  #$0, d0
00A904  ori.b  #$0, d0
00A908  ori.b  #$0, d0
00A90C  ; data: 0xff, 0xfe
00A90E  ; data: 0xff, 0xfe
00A910  ori.b  #$0, d0
00A914  ori.b  #$0, d0
00A918  ori.b  #$0, d0
00A91C  ori.b  #$0, d0
00A920  ori.b  #$0, d0
00A924  ori.b  #$0, d0
00A928  ori.b  #$0, d0
00A92C  ori.b  #$0, d0
00A930  ori.b  #$fe, d0
00A934  ; data: 0xff, 0xfe
00A936  dc.w   $febe
00A938  ori.b  #$0, d0
00A93C  ori.b  #$0, d0
00A940  ori.b  #$0, d0
00A944  ori.b  #$0, d0
00A948  ori.b  #$0, d0
00A94C  ori.b  #$0, d0
00A950  ori.b  #$0, d0
00A954  ori.b  #$0, d0
00A958  ori.b  #$8c, d0
00A95C  ; data: 0xf1, 0xfe
00A95E  dc.w   $f43e
00A960  ori.b  #$0, d0
00A964  ori.b  #$0, d0
00A968  ori.b  #$0, d0
00A96C  ori.b  #$0, d0
00A970  ori.b  #$0, d0
00A974  ori.b  #$0, d0
00A978  ori.b  #$0, d0
00A97C  ori.b  #$0, d0
00A980  ori.b  #$8c, d0
00A984  ror.b  d0, d6
00A986  btst.b #$0, d0
00A98A  ori.b  #$0, d0
00A98E  ori.b  #$0, d0
00A992  ori.b  #$0, d0
00A996  ori.b  #$0, d0
00A99A  ori.b  #$0, d0
00A99E  ori.b  #$0, d0
00A9A2  ori.b  #$0, d0
00A9A6  ori.b  #$0, d0
00A9AA  moveq  #$72, d7
00A9AC  ori.b  #$c0, d0
00A9B0  ori.b  #$0, d0
00A9B4  ori.b  #$0, d0
00A9B8  ori.b  #$0, d0
00A9BC  ori.b  #$0, d0
00A9C0  ori.b  #$0, d0
00A9C4  ori.b  #$0, d0
00A9C8  ori.b  #$0, d0
00A9CC  ori.b  #$0, d0
00A9D0  ori.b  #$0, d0
00A9D4  ; data: 0xff, 0xfe
00A9D6  ; data: 0xff, 0xfe
00A9D8  ori.b  #$0, d0
00A9DC  ori.b  #$0, d0
00A9E0  ori.b  #$0, d0
00A9E4  ori.b  #$0, d0
00A9E8  ori.b  #$0, d0
00A9EC  ori.b  #$0, d0
00A9F0  ori.b  #$0, d0
00A9F4  ori.b  #$0, d0
00A9F8  ori.b  #$fe, d0
00A9FC  ; data: 0xff, 0xfe
00A9FE  ; data: 0xff, 0x3e
00AA00  ori.b  #$0, d0
00AA04  ori.b  #$0, d0
00AA08  ori.b  #$0, d0
00AA0C  ori.b  #$0, d0
00AA10  ori.b  #$0, d0
00AA14  ori.b  #$0, d0
00AA18  ori.b  #$0, d0
00AA1C  ori.b  #$0, d0
00AA20  ori.b  #$d8, d0
00AA24  ; data: 0xf7, 0x7e
00AA26  move.l $aa28(pc), d0
00AA2A  ori.b  #$0, d0
00AA2E  ori.b  #$0, d0
00AA32  ori.b  #$0, d0
00AA36  ori.b  #$0, d0
00AA3A  ori.b  #$0, d0
00AA3E  ori.b  #$0, d0
00AA42  ori.b  #$0, d0
00AA46  ori.b  #$0, d0
00AA4A  divs.w d0, d3
00AA4C  dc.w   $f8fe
00AA4E  add.b  d4, d4
00AA50  ori.b  #$0, d0
00AA54  ori.b  #$0, d0
00AA58  ori.b  #$0, d0
00AA5C  ori.b  #$0, d0
00AA60  ori.b  #$0, d0
00AA64  ori.b  #$0, d0
00AA68  ori.b  #$0, d0
00AA6C  ori.b  #$0, d0
00AA70  ori.b  #$3e, d0
00AA74  ori.b  #$0, d0
00AA78  ori.b  #$0, d0
00AA7C  ori.b  #$0, d0
00AA80  ori.b  #$0, d0
00AA84  ori.b  #$0, d0
00AA88  ori.b  #$0, d0
00AA8C  ori.b  #$0, d0
00AA90  ori.b  #$0, d0
00AA94  ori.b  #$0, d0
00AA98  ori.b  #$0, d0
00AA9C  ; data: 0xff, 0xfe
00AA9E  ; data: 0xff, 0xfe
00AAA0  ori.b  #$0, d0
00AAA4  ori.b  #$0, d0
00AAA8  ori.b  #$0, d0
00AAAC  ori.b  #$0, d0
00AAB0  ori.b  #$0, d0
00AAB4  ori.b  #$0, d0
00AAB8  ori.b  #$0, d0
00AABC  ori.b  #$0, d0
00AAC0  ori.b  #$fe, d0
00AAC4  ; data: 0xff, 0xfe
00AAC6  dc.w   $fefe
00AAC8  ori.b  #$0, d0
00AACC  ori.b  #$0, d0
00AAD0  ori.b  #$0, d0
00AAD4  ori.b  #$0, d0
00AAD8  ori.b  #$0, d0
00AADC  ori.b  #$0, d0
00AAE0  ori.b  #$0, d0
00AAE4  ori.b  #$0, d0
00AAE8  ori.b  #$9c, d0
00AAEC  ; data: 0xff, 0xbe
00AAEE  ; data: 0x46, 0x0c
00AAF0  ori.b  #$0, d0
00AAF4  ori.b  #$0, d0
00AAF8  ori.b  #$0, d0
00AAFC  ori.b  #$0, d0
00AB00  ori.b  #$0, d0
00AB04  ori.b  #$0, d0
00AB08  ori.b  #$0, d0
00AB0C  ori.b  #$0, d0
00AB10  ori.b  #$82, d0
00AB14  ; data: 0xff, 0xfe
00AB16  dc.w   $fe02
00AB18  ori.b  #$0, d0
00AB1C  ori.b  #$0, d0
00AB20  ori.b  #$0, d0
00AB24  ori.b  #$0, d0
00AB28  ori.b  #$0, d0
00AB2C  ori.b  #$0, d0
00AB30  ori.b  #$0, d0
00AB34  ori.b  #$0, d0
00AB38  ori.b  #$7e, d0
00AB3C  ori.b  #$80, d0
00AB40  ori.b  #$0, d0
00AB44  ori.b  #$0, d0
00AB48  ori.b  #$0, d0
00AB4C  ori.b  #$0, d0
00AB50  ori.b  #$0, d0
00AB54  ori.b  #$0, d0
00AB58  ori.b  #$0, d0
00AB5C  ori.b  #$0, d0
00AB60  ori.b  #$0, d0
00AB64  ; data: 0xff, 0xfe
00AB66  ; data: 0xf9, 0xfe
00AB68  ori.b  #$0, d0
00AB6C  ori.b  #$0, d0
00AB70  ori.b  #$0, d0
00AB74  ori.b  #$0, d0
00AB78  ori.b  #$0, d0
00AB7C  ori.b  #$0, d0
00AB80  ori.b  #$0, d0
00AB84  ori.b  #$0, d0
00AB88  ori.b  #$fe, d0
00AB8C  ; data: 0xff, 0xfe
00AB8E  ; data: 0xff, 0x7e
00AB90  ori.b  #$0, d0
00AB94  ori.b  #$0, d0
00AB98  ori.b  #$0, d0
00AB9C  ori.b  #$0, d0
00ABA0  ori.b  #$0, d0
00ABA4  ori.b  #$0, d0
00ABA8  ori.b  #$0, d0
00ABAC  ori.b  #$0, d0
00ABB0  ori.b  #$50, d0
00ABB4  ; data: 0xfb, 0x06
00ABB6  move.w d0, -(a1)
00ABB8  ori.b  #$0, d0
00ABBC  ori.b  #$0, d0
00ABC0  ori.b  #$0, d0
00ABC4  ori.b  #$0, d0
00ABC8  ori.b  #$0, d0
00ABCC  ori.b  #$0, d0
00ABD0  ori.b  #$0, d0
00ABD4  ori.b  #$0, d0
00ABD8  ori.b  #$2e, d0
00ABDC  ; data: 0xff, 0xbe
00ABDE  ; data: 0xfb, 0x0e
00ABE0  ori.b  #$0, d0
00ABE4  ori.b  #$0, d0
00ABE8  ori.b  #$0, d0
00ABEC  ori.b  #$0, d0
00ABF0  ori.b  #$0, d0
00ABF4  ori.b  #$0, d0
00ABF8  ori.b  #$0, d0
00ABFC  ori.b  #$0, d0
00AC00  ori.b  #$fe, d0
00AC04  ori.b  #$0, d0
00AC08  ori.b  #$0, d0
00AC0C  ori.b  #$0, d0
00AC10  ori.b  #$0, d0
00AC14  ori.b  #$0, d0
00AC18  ori.b  #$0, d0
00AC1C  ori.b  #$0, d0
00AC20  ori.b  #$0, d0
00AC24  ori.b  #$0, d0
00AC28  ori.b  #$0, d0
00AC2C  ; data: 0xff, 0xfe
00AC2E  ; data: 0xfd, 0xfe
00AC30  ori.b  #$0, d0
00AC34  ori.b  #$0, d0
00AC38  ori.b  #$0, d0
00AC3C  ori.b  #$0, d0
00AC40  ori.b  #$0, d0
00AC44  ori.b  #$0, d0
00AC48  ori.b  #$0, d0
00AC4C  ori.b  #$0, d0
00AC50  ori.b  #$fe, d0
00AC54  ; data: 0xff, 0xfe
00AC56  dc.w   $fafe
00AC58  ori.b  #$0, d0
00AC5C  ori.b  #$0, d0
00AC60  ori.b  #$0, d0
00AC64  ori.b  #$0, d0
00AC68  ori.b  #$0, d0
00AC6C  ori.b  #$0, d0
00AC70  ori.b  #$0, d0
00AC74  ori.b  #$0, d0
00AC78  ori.b  #$86, d0
00AC7C  ror.b  d4, d6
00AC7E  add.l  d6, (a2, d0.w)
00AC82  ori.b  #$0, d0
00AC86  ori.b  #$0, d0
00AC8A  ori.b  #$0, d0
00AC8E  ori.b  #$0, d0
00AC92  ori.b  #$0, d0
00AC96  ori.b  #$0, d0
00AC9A  ori.b  #$0, d0
00AC9E  ori.b  #$0, d0
00ACA2  ror.w  d1, d6
00ACA4  dc.w   $fe06
00ACA6  ; data: 0xf9, 0x8e
00ACA8  ori.b  #$0, d0
00ACAC  ori.b  #$0, d0
00ACB0  ori.b  #$0, d0
00ACB4  ori.b  #$0, d0
00ACB8  ori.b  #$0, d0
00ACBC  ori.b  #$0, d0
00ACC0  ori.b  #$0, d0
00ACC4  ori.b  #$0, d0
00ACC8  ori.b  #$fe, d0
00ACCC  ori.b  #$0, d0
00ACD0  ori.b  #$0, d0
00ACD4  ori.b  #$0, d0
00ACD8  ori.b  #$0, d0
00ACDC  ori.b  #$0, d0
00ACE0  ori.b  #$0, d0
00ACE4  ori.b  #$0, d0
00ACE8  ori.b  #$0, d0
00ACEC  ori.b  #$0, d0
00ACF0  ori.b  #$0, d0
00ACF4  ; data: 0xff, 0xfe
00ACF6  dc.w   $fefe
00ACF8  ori.b  #$0, d0
00ACFC  ori.b  #$0, d0
00AD00  ori.b  #$0, d0
00AD04  ori.b  #$0, d0
00AD08  ori.b  #$0, d0
00AD0C  ori.b  #$0, d0
00AD10  ori.b  #$0, d0
00AD14  ori.b  #$0, d0
00AD18  ori.b  #$fe, d0
00AD1C  ; data: 0xff, 0xfe
00AD1E  ; data: 0xfd, 0x7e
00AD20  ori.b  #$0, d0
00AD24  ori.b  #$0, d0
00AD28  ori.b  #$0, d0
00AD2C  ori.b  #$0, d0
00AD30  ori.b  #$0, d0
00AD34  ori.b  #$0, d0
00AD38  ori.b  #$0, d0
00AD3C  ori.b  #$0, d0
00AD40  ori.b  #$86, d0
00AD44  and.b  (a2)+, d0
00AD46  ; data: 0xf7, 0xb4
00AD48  ori.b  #$0, d0
00AD4C  ori.b  #$0, d0
00AD50  ori.b  #$0, d0
00AD54  ori.b  #$0, d0
00AD58  ori.b  #$0, d0
00AD5C  ori.b  #$0, d0
00AD60  ori.b  #$0, d0
00AD64  ori.b  #$0, d0
00AD68  ori.b  #$7e, d0
00AD6C  dc.w   $fe06
00AD6E  ; data: 0xf9, 0x8e
00AD70  ori.b  #$0, d0
00AD74  ori.b  #$0, d0
00AD78  ori.b  #$0, d0
00AD7C  ori.b  #$0, d0
00AD80  ori.b  #$0, d0
00AD84  ori.b  #$0, d0
00AD88  ori.b  #$0, d0
00AD8C  ori.b  #$0, d0
00AD90  ori.b  #$fe, d0
00AD94  ori.b  #$80, d0
00AD98  ori.b  #$0, d0
00AD9C  ori.b  #$0, d0
00ADA0  ori.b  #$0, d0
00ADA4  ori.b  #$0, d0
00ADA8  ori.b  #$0, d0
00ADAC  ori.b  #$0, d0
00ADB0  ori.b  #$0, d0
00ADB4  ori.b  #$0, d0
00ADB8  ori.b  #$0, d0
00ADBC  ; data: 0xff, 0xfe
00ADBE  ; data: 0xff, 0x7e
00ADC0  ori.b  #$0, d0
00ADC4  ori.b  #$0, d0
00ADC8  ori.b  #$0, d0
00ADCC  ori.b  #$0, d0
00ADD0  ori.b  #$0, d0
00ADD4  ori.b  #$0, d0
00ADD8  ori.b  #$0, d0
00ADDC  ori.b  #$0, d0
00ADE0  ori.b  #$fe, d0
00ADE4  ; data: 0xff, 0xfe
00ADE6  dc.w   $fefe
00ADE8  ori.b  #$0, d0
00ADEC  ori.b  #$0, d0
00ADF0  ori.b  #$0, d0
00ADF4  ori.b  #$0, d0
00ADF8  ori.b  #$0, d0
00ADFC  ori.b  #$0, d0
00AE00  ori.b  #$0, d0
00AE04  ori.b  #$0, d0
00AE08  ori.b  #$82, d0
00AE0C  and.l  d0, (a2)+
00AE0E  ; data: 0xf3, 0xae
00AE10  ori.b  #$0, d0
00AE14  ori.b  #$0, d0
00AE18  ori.b  #$0, d0
00AE1C  ori.b  #$0, d0
00AE20  ori.b  #$0, d0
00AE24  ori.b  #$0, d0
00AE28  ori.b  #$0, d0
00AE2C  ori.b  #$0, d0
00AE30  ori.b  #$7e, d0
00AE34  dc.w   $fe06
00AE36  ; data: 0xfd, 0x9e
00AE38  ori.b  #$0, d0
00AE3C  ori.b  #$0, d0
00AE40  ori.b  #$0, d0
00AE44  ori.b  #$0, d0
00AE48  ori.b  #$0, d0
00AE4C  ori.b  #$0, d0
00AE50  ori.b  #$0, d0
00AE54  ori.b  #$0, d0
00AE58  ori.b  #$fe, d0
00AE5C  ori.b  #$0, d0
00AE60  ori.b  #$0, d0
00AE64  ori.b  #$0, d0
00AE68  ori.b  #$0, d0
00AE6C  ori.b  #$0, d0
00AE70  ori.b  #$0, d0
00AE74  ori.b  #$0, d0
00AE78  ori.b  #$0, d0
00AE7C  ori.b  #$0, d0
00AE80  ori.b  #$0, d0
00AE84  ; data: 0xff, 0xfe
00AE86  dc.w   $fefe
00AE88  ori.b  #$0, d0
00AE8C  ori.b  #$0, d0
00AE90  ori.b  #$0, d0
00AE94  ori.b  #$0, d0
00AE98  ori.b  #$0, d0
00AE9C  ori.b  #$0, d0
00AEA0  ori.b  #$0, d0
00AEA4  ori.b  #$0, d0
00AEA8  ori.b  #$fe, d0
00AEAC  ; data: 0xff, 0xfe
00AEAE  ; data: 0xff, 0x7e
00AEB0  ori.b  #$0, d0
00AEB4  ori.b  #$0, d0
00AEB8  ori.b  #$0, d0
00AEBC  ori.b  #$0, d0
00AEC0  ori.b  #$0, d0
00AEC4  ori.b  #$0, d0
00AEC8  ori.b  #$0, d0
00AECC  ori.b  #$0, d0
00AED0  ori.b  #$48, d0
00AED4  and.l  #$e38e0000, d0
00AEDA  ori.b  #$0, d0
00AEDE  ori.b  #$0, d0
00AEE2  ori.b  #$0, d0
00AEE6  ori.b  #$0, d0
00AEEA  ori.b  #$0, d0
00AEEE  ori.b  #$0, d0
00AEF2  ori.b  #$0, d0
00AEF6  ori.b  #$0, d0
00AEFA  and.l  d0, ([a6, a7.l * 8], $fdbe)
00AF00  ori.b  #$0, d0
00AF04  ori.b  #$0, d0
00AF08  ori.b  #$0, d0
00AF0C  ori.b  #$0, d0
00AF10  ori.b  #$0, d0
00AF14  ori.b  #$0, d0
00AF18  ori.b  #$0, d0
00AF1C  ori.b  #$0, d0
00AF20  ori.b  #$fe, d0
00AF24  ori.b  #$80, d0
00AF28  ori.b  #$0, d0
00AF2C  ori.b  #$0, d0
00AF30  ori.b  #$0, d0
00AF34  ori.b  #$0, d0
00AF38  ori.b  #$0, d0
00AF3C  ori.b  #$0, d0
00AF40  ori.b  #$0, d0
00AF44  ori.b  #$0, d0
00AF48  ori.b  #$0, d0
00AF4C  ; data: 0xff, 0xfe
00AF4E  ; data: 0xff, 0x7e
00AF50  ori.b  #$0, d0
00AF54  ori.b  #$0, d0
00AF58  ori.b  #$0, d0
00AF5C  ori.b  #$0, d0
00AF60  ori.b  #$0, d0
00AF64  ori.b  #$0, d0
00AF68  ori.b  #$0, d0
00AF6C  ori.b  #$0, d0
00AF70  ori.b  #$fe, d0
00AF74  ; data: 0xff, 0xfe
00AF76  dc.w   $fefe
00AF78  ori.b  #$0, d0
00AF7C  ori.b  #$0, d0
00AF80  ori.b  #$0, d0
00AF84  ori.b  #$0, d0
00AF88  ori.b  #$0, d0
00AF8C  ori.b  #$0, d0
00AF90  ori.b  #$0, d0
00AF94  ori.b  #$0, d0
00AF98  ori.b  #$86, d0
00AF9C  cmp.w  #$d39a, d0
00AFA0  ori.b  #$0, d0
00AFA4  ori.b  #$0, d0
00AFA8  ori.b  #$0, d0
00AFAC  ori.b  #$0, d0
00AFB0  ori.b  #$0, d0
00AFB4  ori.b  #$0, d0
00AFB8  ori.b  #$0, d0
00AFBC  ori.b  #$0, d0
00AFC0  ori.b  #$78, d0
00AFC4  ; data: 0xff, 0x82
00AFC6  ; data: 0xfd, 0xbe
00AFC8  ori.b  #$0, d0
00AFCC  ori.b  #$0, d0
00AFD0  ori.b  #$0, d0
00AFD4  ori.b  #$0, d0
00AFD8  ori.b  #$0, d0
00AFDC  ori.b  #$0, d0
00AFE0  ori.b  #$0, d0
00AFE4  ori.b  #$0, d0
00AFE8  ori.b  #$fe, d0
00AFEC  ori.b  #$0, d0
00AFF0  ori.b  #$0, d0
00AFF4  ori.b  #$0, d0
00AFF8  ori.b  #$0, d0
00AFFC  ori.b  #$0, d0
00B000  ori.b  #$0, d0
00B004  ori.b  #$0, d0
00B008  ori.b  #$0, d0
00B00C  ori.b  #$0, d0
00B010  ori.b  #$0, d0
00B014  ; data: 0xff, 0xfe
00B016  dc.w   $fefe
00B018  ori.b  #$0, d0
00B01C  ori.b  #$0, d0
00B020  ori.b  #$0, d0
00B024  ori.b  #$0, d0
00B028  ori.b  #$0, d0
00B02C  ori.b  #$0, d0
00B030  ori.b  #$0, d0
00B034  ori.b  #$0, d0
00B038  ori.b  #$fe, d0
00B03C  ; data: 0xff, 0xfe
00B03E  ; data: 0xff, 0x7e
00B040  ori.b  #$0, d0
00B044  ori.b  #$0, d0
00B048  ori.b  #$0, d0
00B04C  ori.b  #$0, d0
00B050  ori.b  #$0, d0
00B054  ori.b  #$0, d0
00B058  ori.b  #$0, d0
00B05C  ori.b  #$0, d0
00B060  ori.b  #$0, d0
00B064  ; data: 0x0e, 0x99
00B066  movep.w d6, $c77(a0)
00B06A  bchg.b d5, -(a6)
00B06C  eori.w #$844, (a5)
00B070  btst.l d3, $20(a3, d0.w)
00B074  btst.l d2, (a0)
00B076  subi.b #$0, d0
00B07A  subi.b #$12, (a2)
00B07E  addi.b #$14, (a3)
00B082  ; data: 0x08, 0x15
00B084  ; data: 0x0e, 0x52
00B086  eori.w #$852, (a2)
00B08A  bchg.b d3, d1
00B08C  addi.b #$55, -(a6)
00B090  addi.w #$777, (a3)
00B094  ; data: 0x08, 0x88
00B096  bclr.b d4, (a1)+
00B098  cmpi.l #$ccc0ddd, (a7)
00B09E  ; data: 0x0e, 0xee
00B0A0  ; data: 0x0f, 0xff
00B0A2  ori.b  #$57, d0
00B0A6  ; data: 0x0f, 0xfe
00B0A8  bset.b d7, $fdb(a4)
00B0AC  movep.l d7, $fb8(a1)
00B0B0  bclr.b d7, -(a6)
00B0B2  bclr.b d7, (a5)
00B0B4  subi.b #$31, -(a1)
00B0B8  addi.w #$752, d1
00B0BC  cmpi.b #$20, $10(a1, d0.l)
00B0C2  btst.l d4, d0
00B0C4  ; data: 0x08, 0x00
00B0C6  btst.l d3, d0
00B0C8  addi.b #$0, d0
00B0CC  subi.b #$0, d0
00B0D0  andi.b #$2, d0
00B0D4  eori.b #$58, (a3)
00B0D8  eori.w #$888, d6
00B0DC  bchg.b d3, (a4)
00B0DE  cmpi.w #$b67, -(a7)
00B0E2  andi.b #$44, $55(a3, d0.w)
00B0E8  bchg.b d2, -(a6)
00B0EA  bchg.b d2, -(a6)
00B0EC  addi.w #$677, (d0.w * 8)
00B0F2  movep.w d3, $788(a0)
00B0F6  ; data: 0x08, 0x99
00B0F8  ; data: 0x08, 0x99
00B0FA  bclr.b d4, $9aa(a2)
00B0FE  ; data: 0x0a, 0xbb
00B100  ; data: 0x0a, 0xbb
00B102  ori.b  #$df, d0
00B106  movep.l d2, $4ad(a6)
00B10A  subi.l #$38b037a, (a4)+
00B110  andi.w #$248, (a1)+
00B114  btst.l d0, $137.w
00B118  btst.l d0, -(a6)
00B11A  ori.b  #$14, (a5)
00B11E  ori.b  #$2, d3
00B122  ori.b  #$57, d0
00B126  ; data: 0x0f, 0xfe
00B128  bset.b d7, $655(a4)
00B12C  addi.w #$888, d5
00B130  ; data: 0x08, 0x76
00B132  bclr.b d5, (a7)
00B134  andi.b #$33, -(a2)
00B138  subi.w #$555, d4
00B13C  addi.w #$777, -(a6)
00B140  ; data: 0x08, 0x88
00B142  ; data: 0x08, 0x67
00B144  ; data: 0x08, 0x56
00B146  bchg.b d3, d5
00B148  ; data: 0x08, 0x83
00B14A  ; data: 0x08, 0x53
00B14C  addi.w #$300, (a3)
00B150  ; data: 0x08, 0x64
00B152  bchg.b d4, -(a3)
00B154  ; data: 0x08, 0x43
00B156  bchg.b d3, (a0)+
00B158  eori.w #$888, d6
00B15C  bchg.b d3, (a4)
00B15E  cmpi.w #$b67, -(a7)
00B162  ori.b  #$87, d0
00B166  ; data: 0x0f, 0xfe
00B168  bset.b d7, $fdb(a4)
00B16C  movep.l d7, $fb9(a2)
00B170  ; data: 0x0e, 0xa8
00B172  bclr.b d6, (a7)
00B174  bclr.b d5, d6
00B176  eori.w #$864, ([a5], $6420532)
00B180  ; data: 0x0e, 0x9b
00B182  cmpi.l #$d890a77, (a3)+
00B188  ; data: 0x08, 0x76
00B18A  btst.l d1, -$77(a4, d0.l)
00B18E  ; data: 0x08, 0x68
00B190  ; data: 0x0f, 0xbd
00B192  addi.w #$854, d3
00B196  bchg.b d4, $7430632.l
00B19C  addi.b #$22, (a4, d0.w * 2)
00B1A2  ori.b  #$77, d0
00B1A6  ; data: 0x0c, 0x8b
00B1A8  ; data: 0x0b, 0x7a
00B1AA  eori.w #$857, $746(a0)
00B1B0  addi.b #$24, $13(a5, d0.w)
00B1B6  btst.l d1, d2
00B1B8  andi.b #$57, d1
00B1BC  bchg.b d4, $967(a1)
00B1C0  ; data: 0x0c, 0x08
00B1C2  eori.w #$a85, -(a5)
00B1C6  bchg.b d3, d4
00B1C8  ; data: 0x08, 0x58
00B1CA  bchg.b d3, $758(a1)
00B1CE  ; data: 0x08, 0x7a
00B1D0  movep.w d4, $777(a2)
00B1D4  ; data: 0x08, 0x88
00B1D6  bclr.b d4, (a1)+
00B1D8  eori.l #$ccc0ddd, $eee(a2)
00B1E0  ; data: 0x0f, 0xff
00B1E2  ori.b  #$46, d0
00B1E6  ; data: 0x0a, 0xbb
00B1E8  addi.b #$aa, ([, d0.l])
00B1EE  ; data: 0x08, 0x88
00B1F0  bchg.b d3, $66(a7, d0.w)
00B1F4  bchg.b d2, (a5)
00B1F6  subi.w #$333, d4
00B1FA  andi.b #$69, -(a2)
00B1FE  bchg.b d4, -(a7)
00B200  bchg.b d3, d7
00B202  eori.w #$a85, -(a5)
00B206  bchg.b d3, d4
00B208  ; data: 0x08, 0x58
00B20A  bchg.b d3, $758(a1)
00B20E  ; data: 0x08, 0x7a
00B210  movep.w d4, $777(a2)
00B214  ; data: 0x08, 0x88
00B216  bclr.b d4, (a1)+
00B218  eori.l #$ccc0ddd, $eee(a2)
00B220  ; data: 0x0f, 0xff
00B222  ori.b  #$79, d0
00B226  bchg.b d3, $657(a0)
00B22A  bchg.b d2, d6
00B22C  subi.b #$24, $13(a5, d0.w)
00B232  ori.b  #$21, d2
00B236  btst.l d2, $41(a1, d0.w)
00B23A  bchg.b d3, (a2)
00B23C  cmpi.b #$20, $10(a1, d0.l)
00B242  btst.l d4, d0
00B244  ; data: 0x08, 0x00
00B246  btst.l d3, d0
00B248  addi.b #$0, d0
00B24C  subi.b #$0, d0
00B250  andi.b #$2, d0
00B254  eori.b #$58, (a3)
00B258  btst.l d2, ([a5])
00B25C  bchg.b d3, (a4)
00B25E  cmpi.w #$b67, -(a7)
00B262  ori.b  #$57, d0
00B266  ; data: 0x0f, 0xfe
00B268  bset.b d7, $fdb(a4)
00B26C  movep.l d7, $888(a1)
00B270  ; data: 0x08, 0x76
00B272  bclr.b d5, (a7)
00B274  subi.b #$31, -(a1)
00B278  addi.w #$752, d1
00B27C  ; data: 0x08, 0x63
00B27E  bchg.b d4, $65(a4, d0.l)
00B282  ; data: 0x08, 0x67
00B284  ; data: 0x08, 0x78
00B286  bchg.b d3, -$7d(a2, d0.l)
00B28A  bchg.b d3, -(a3)
00B28C  addi.w #$300, (a3)
00B290  bchg.b d4, ([$843, a6], $7580a46)
00B29A  ; data: 0x08, 0x88
00B29C  bchg.b d3, (a4)
00B29E  cmpi.w #$b67, -(a7)
00B2A2  ori.b  #$90, d0
00B2A6  bclr.b d4, d6
00B2A8  ; data: 0x08, 0x75
00B2AA  bchg.b d2, d3
00B2AC  addi.w #$444, d5
00B2B0  btst.l d2, $30(a0, d0.w)
00B2B4  btst.l d2, (a0)
00B2B6  subi.b #$0, d0
00B2BA  subi.b #$12, (a2)
00B2BE  addi.b #$14, $44(a1, d0.w)
00B2C4  btst.l d4, $43(a4, d0.w)
00B2C8  btst.l d2, $46(a2, d0.w)
00B2CC  addi.b #$55, -(a6)
00B2D0  addi.w #$333, (a3)
00B2D4  subi.w #$555, d4
00B2D8  addi.w #$777, -(a6)
00B2DC  ; data: 0x08, 0x88
00B2DE  btst.l d2, (a4, invalid.w)
00B2E4  ; data: 0x0e, 0xca
00B2E6  ; data: 0x0e, 0x00
00B2E8  eori.b #$80, d0
00B2EC  bset.b d7, -(a0)
00B2EE  bset.b #$80, -$4a(a0, d0.w)
00B2F4  ; data: 0x00, 0xdd
00B2F6  ori.l  #$5670678, $789(a7)
00B2FE  bclr.b d3, (a3)+
00B300  ; data: 0x0c, 0x08
00B302  addi.w #$563, $52(a4, d0.w)
00B308  andi.b #$33, -(a2)
00B30C  subi.w #$555, d4
00B310  addi.w #$777, -(a6)
00B314  ; data: 0x08, 0x88
00B316  bclr.b d4, (a1)+
00B318  eori.l #$bbb06f3, $eee(a2)
00B320  ; data: 0x0f, 0xff
00B322  ori.b  #$72, d0
00B326  ; data: 0x08, 0x88
00B328  ; data: 0x08, 0x75
00B32A  bchg.b d2, d3
00B32C  bchg.b d2, d3
00B32E  subi.w #$530, d4
00B332  addi.b #$52, $41(a0, d0.w)
00B338  btst.l d2, $20(a0, d0.w)
00B33C  btst.l d1, (a0)
00B33E  andi.b #$69, d0
00B342  cmpi.w #$a47, (a0)+
00B346  btst.l d4, $25(a6, d0.l)
00B34A  btst.l d3, (a4)
00B34C  addi.b #$2, d3
00B350  subi.b #$0, d1
00B354  btst.l d3, ([a6], $943)
00B35A  eori.w #$c58, d4
00B35E  btst.l d2, (a4, invalid.w)