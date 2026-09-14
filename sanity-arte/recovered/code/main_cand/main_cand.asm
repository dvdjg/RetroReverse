; main_cand desensamblado
; origen out/modules_all/blk_078A2C
; len 73048 B
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
0000DE  move.w #$3d3, $e(a2)
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
000156  bsr.w  $3a4
00015A  movea.l $8(a5), a0
00015E  movea.l $4(a0), a0
000162  jsr    (a0)
000164  movea.l $8(a5), a0
000168  move.w $c(a0), d0
00016C  cmp.w  $10(a0), d0
000170  bcs.b  $15a
000172  moveq  #$9, d0
000174  trap   #$d
000176  lea.l  $0.l, a0
00017C  lea.l  $1f4(pc), a1
000180  moveq  #$20, d0
000182  jsr    -$54(a6)
000186  bsr.w  $220
00018A  jsr    -$11a(a6)
00018E  movea.l $26(a0), a1
000192  cmpi.w #$13, $1c(a1)
000198  beq.b  $1b4
00019A  movea.l $8(a5), a0
00019E  movea.l $4(a0), a0
0001A2  jsr    (a0)
0001A4  movea.l $8(a5), a0
0001A8  move.w $c(a0), d0
0001AC  cmp.w  $e(a0), d0
0001B0  bcs.w  $186
0001B4  jsr    -$11a(a6)
0001B8  movea.l $26(a0), a1
0001BC  cmpi.w #$13, $1c(a1)
0001C2  beq.b  $1f0
0001C4  move.l #$fffffffe, $d0.l
0001CE  move.l $dff004.l, d0
0001D4  andi.l #$fff80, d0
0001DA  cmp.l  #$13000, d0
0001E0  bne.b  $1ce
0001E2  lea.l  $dff000.l, a4
0001E8  btst.b #$6, $2(a4)
0001EE  bne.b  $1e8
0001F0  moveq  #$0, d0
0001F2  rts    
0001F4  movem.l d0-d7/a0-a6, -(a7)
0001F8  lea.l  $0.l, a5
0001FE  movea.l $0(a5), a6
000202  movea.l $8(a5), a0
000206  movea.l $8(a0), a0
00020A  jsr    (a0)
00020C  bsr.w  $222
000210  movem.l (a7)+, d0-d7/a0-a6
000214  move.w #$30, $dff09c.l
00021C  nop    
00021E  rte    
000220  rts    
000222  addq.w #$1, $2a8.l
000228  cmpi.w #$3, $2a8.l
000230  ble.b  $2a6
000232  bsr.w  $2aa
000236  lea.l  $dff000.l, a4
00023C  bsr.w  $cce
000240  bsr.w  $aea
000244  cmpi.w #$3c7, $2a8.l
00024C  bgt.b  $252
00024E  bsr.w  $318
000252  cmpi.w #$3a7, $2a8.l
00025A  bne.b  $278
00025C  neg.w  $2e0.l
000262  move.w #$1, $312.l
00026A  clr.w  $310.l
000270  move.w #$11, $316.l
000278  cmpi.w #$3c9, $2a8.l
000280  blt.b  $28e
000282  move.l #$fffffffe, $d0.l
00028C  bra.b  $298
00028E  move.l $668.l, $d0.l
000298  lea.l  $dff000.l, a4
00029E  btst.b #$6, $2(a4)
0002A4  bne.b  $29e
0002A6  rts    
0002A8  ori.b  #$79, d0
0002AC  ori.b  #$16, d0
0002B0  beq.b  $30e
0002B2  tst.w  $310.l
0002B8  beq.b  $2c2
0002BA  subq.w #$1, $310.l
0002C0  rts    
0002C2  subq.w #$1, $316.l
0002C8  move.w $312.l, $310.l
0002D2  lea.l  $230e.l, a0
0002D8  adda.w $314.l, a0
0002DE  addi.w #$10, $314.l
0002E6  lea.l  $8a.l, a1
0002EC  movem.w (a0)+, d0-d7
0002F0  move.w d0, (a1)
0002F2  move.w d1, $4(a1)
0002F6  move.w d2, $8(a1)
0002FA  move.w d3, $c(a1)
0002FE  move.w d4, $10(a1)
000302  move.w d5, $14(a1)
000306  move.w d6, $18(a1)
00030A  move.w d7, $1c(a1)
00030E  rts    
000310  ori.b  #$0, d0
000314  ori.b  #$0, d0
000318  movea.l $d48.l, a1
00031E  lea.l  $13ba.l, a0
000324  adda.w $3a0.l, a0
00032A  cmpi.w #$30, $2a8.l
000332  blt.b  $33a
000334  addq.w #$2, $3a0.l
00033A  moveq  #$0, d0
00033C  move.w (a0)+, d0
00033E  cmpi.w #$ffff, (a0)
000342  bne.b  $34a
000344  clr.w  $3a0.l
00034A  muls.w #$190, d0
00034E  swap   d0
000350  andi.l #$ffff, d0
000356  tst.w  d0
000358  bge.b  $360
00035A  ori.l  #$ffff0000, d0
000360  addi.l #$c8, d0
000366  mulu.w #$c8, d0
00036A  adda.l d0, a1
00036C  lea.l  $241e.l, a2
000372  adda.w $3a2.l, a2
000378  addq.w #$2, $3a2.l
00037E  movea.l $d4c.l, a0
000384  moveq  #$1, d7
000386  moveq  #$2, d6
000388  moveq  #$4, d5
00038A  moveq  #$8, d4
00038C  moveq  #$10, d3
00038E  moveq  #$20, d2
000390  moveq  #$40, d1
000392  move.w #$80, d0
000396  movea.l $caa.l, a3
00039C  jmp    (a3)
00039E  rts    
0003A0  ori.b  #$0, d0
0003A4  lea.l  $28.l, a0
0003AA  move.l #$74c, d0
0003B0  moveq  #$0, d1
0003B2  moveq  #$8, d2
0003B4  move.w #$120, d3
0003B8  jsr    -$72(a6)
0003BC  jsr    -$11a(a6)
0003C0  move.w $1c(a0), d0
0003C4  or.w   d0, $16.l
0003CA  movem.l d0-d7/a0-a6, -(a7)
0003CE  move.l #$9f64, d0
0003D4  move.l #$1, d1
0003DA  jsr    -$2a(a6)
0003DE  lea.l  $cb0.l, a0
0003E4  move.l d0, $0(a0)
0003E8  move.l d0, $8(a0)
0003EC  addi.l #$4fb2, d0
0003F2  move.l d0, $4(a0)
0003F6  move.l d0, $c(a0)
0003FA  move.l #$249f0, d0
000400  move.l #$1, d1
000406  jsr    -$2a(a6)
00040A  move.l d0, $660.l
000410  move.l #$10b30, d0
000416  move.l #$1, d1
00041C  jsr    -$2a(a6)
000420  lea.l  $d52.l, a0
000426  move.l d0, $0(a0)
00042A  move.l d0, $c(a0)
00042E  addi.l #$5910, d0
000434  move.l d0, $4(a0)
000438  move.l d0, $10(a0)
00043C  addi.l #$5910, d0
000442  move.l d0, $8(a0)
000446  move.l d0, $14(a0)
00044A  move.l #$57e40, d0
000450  move.l #$0, d1
000456  jsr    -$2a(a6)
00045A  move.l d0, $664.l
000460  lea.l  $d6a.l, a0
000466  move.l $664.l, d0
00046C  move.l d0, $0(a0)
000470  move.l d0, $c(a0)
000474  addi.l #$1d4c0, d0
00047A  move.l d0, $4(a0)
00047E  move.l d0, $10(a0)
000482  addi.l #$1d4c0, d0
000488  move.l d0, $8(a0)
00048C  move.l d0, $14(a0)
000490  lea.l  $241e.l, a0
000496  movea.l $664.l, a1
00049C  adda.l #$1d4c0, a1
0004A2  move.w #$bb7, d7
0004A6  move.l (a0)+, (a1)+
0004A8  move.l (a0)+, (a1)+
0004AA  move.l (a0)+, (a1)+
0004AC  move.l (a0)+, (a1)+
0004AE  move.l (a0)+, (a1)+
0004B0  dbra   d7, $4a6
0004B4  lea.l  $11d0a.l, a0
0004BA  lea.l  $241e.l, a1
0004C0  move.w #$fe70, d1
0004C4  move.w #$1db0, d2
0004C8  move.w #$31, d5
0004CC  move.w #$4a, d7
0004D0  move.b (a0)+, d0
0004D2  moveq  #$7, d6
0004D4  btst.l d6, d0
0004D6  beq.b  $4dc
0004D8  move.w d1, (a1)+
0004DA  bra.b  $4de
0004DC  move.w d2, (a1)+
0004DE  dbra   d6, $4d4
0004E2  dbra   d7, $4d0
0004E6  lea.l  -$97(a0), a0
0004EA  dbra   d5, $4cc
0004EE  move.w #$257, d7
0004F2  move.w d2, (a1)+
0004F4  dbra   d7, $4f2
0004F8  lea.l  $d52.l, a0
0004FE  move.l (a0), d1
000500  movea.l $664.l, a0
000506  adda.l #$1d4c0, a0
00050C  movea.l $664.l, a1
000512  move.w #$3a97, d7
000516  movem.w (a0)+, d0
00051A  add.l  d1, d0
00051C  move.l d0, (a1)+
00051E  movem.w (a0)+, d0
000522  add.l  d1, d0
000524  move.l d0, (a1)+
000526  dbra   d7, $516
00052A  movea.l $664.l, a0
000530  movea.l $664.l, a1
000536  adda.l #$1d4c0, a1
00053C  move.l #$5910, d1
000542  move.w #$3a97, d7
000546  move.l (a0)+, d0
000548  add.l  d1, d0
00054A  move.l d0, (a1)+
00054C  move.l (a0)+, d0
00054E  add.l  d1, d0
000550  move.l d0, (a1)+
000552  dbra   d7, $546
000556  movea.l $664.l, a0
00055C  adda.l #$1d4c0, a0
000562  movea.l $664.l, a1
000568  adda.l #$3a980, a1
00056E  move.l #$5910, d1
000574  move.w #$3a97, d7
000578  move.l (a0)+, d0
00057A  add.l  d1, d0
00057C  move.l d0, (a1)+
00057E  move.l (a0)+, d0
000580  add.l  d1, d0
000582  move.l d0, (a1)+
000584  dbra   d7, $578
000588  clr.w  $d50.l
00058E  clr.w  $cae.l
000594  bsr.w  $cce
000598  bsr.w  $66c
00059C  bsr.w  $aea
0005A0  bsr.w  $aea
0005A4  move.w #$438, $3a0.l
0005AC  clr.w  $3a2.l
0005B2  move.l #$ea60, $ca4.l
0005BC  move.w #$3, $ca8.l
0005C4  move.w #$160, $cc0.l
0005CC  clr.w  $cc2.l
0005D2  clr.w  $cc4.l
0005D8  clr.w  $2a8.l
0005DE  move.l #$fffffffe, $d0.l
0005E8  move.b #$10, $e12.l
0005F0  move.l #$22fe, $e0e.l
0005FA  move.w #$8, $e18.l
000602  lea.l  $230e.l, a2
000608  move.l a2, $e0a.l
00060E  bsr.w  $d82
000612  movea.l $e0a.l, a2
000618  lea.l  $10(a2), a3
00061C  move.w #$7, d7
000620  move.w (a2)+, (a3)+
000622  dbra   d7, $620
000626  tst.b  $e12.l
00062C  bne.b  $608
00062E  move.w #$10, $2e0.l
000636  move.w #$3, $312.l
00063E  clr.w  $310.l
000644  clr.w  $314.l
00064A  move.w #$10, $316.l
000652  move.w #$ffff, $dff02e.l
00065A  movem.l (a7)+, d0-d7/a0-a6
00065E  rts    
000660  ori.b  #$0, d0
000664  ori.b  #$0, d0
000668  ori.w  #$ffff, d4
00066C  lea.l  $108.l, a1
000672  move.w #$31, d7
000676  lea.l  $22be.l, a0
00067C  move.w #$7, d6
000680  move.l (a0)+, (a1)+
000682  dbra   d6, $680
000686  dbra   d7, $676
00068A  lea.l  $cb0.l, a0
000690  movea.l (a0)+, a1
000692  movea.l (a0)+, a2
000694  move.w #$31, d7
000698  move.w #$31, d6
00069C  move.l $7b6.l, (a1)+
0006A2  move.l $7ba.l, (a1)+
0006A8  move.l $7b6.l, (a2)+
0006AE  move.l $7ba.l, (a2)+
0006B4  dbra   d6, $69c
0006B8  move.l $7c0.l, (a1)+
0006BE  move.l $7c4.l, (a1)+
0006C4  move.l $7c0.l, (a2)+
0006CA  move.l $7c4.l, (a2)+
0006D0  dbra   d7, $698
0006D4  move.w $7be.l, (a1)+
0006DA  move.w $7be.l, (a2)+
0006E0  lea.l  $8ea.l, a0
0006E6  moveq  #$0, d0
0006E8  move.w #$ff, d7
0006EC  move.w d0, (a0)+
0006EE  addi.w #$28, d0
0006F2  dbra   d7, $6ec
0006F6  clr.l  $7e8.l
0006FC  clr.w  $7ec.l
000702  lea.l  $8ea.l, a4
000708  bsr.w  $7ee
00070C  lea.l  $7c8.l, a0
000712  movea.l $660.l, a1
000718  adda.l $7e8.l, a1
00071E  addi.l #$2710, $7e8.l
000728  addi.w #$c, $7ec.l
000730  move.w #$31, d7
000734  move.w #$31, d6
000738  move.w d7, d0
00073A  subi.w #$19, d0
00073E  move.w d6, d1
000740  subi.w #$19, d1
000744  move.w #$64, d2
000748  lea.l  $8d4(pc), a3
00074C  move.w d0, d3
00074E  muls.w (a3)+, d3
000750  move.w d1, d4
000752  muls.w (a3)+, d4
000754  move.w d2, d5
000756  muls.w (a3)+, d5
000758  add.l  d4, d3
00075A  add.l  d5, d3
00075C  asr.l  #$8, d3
00075E  asr.l  #$1, d3
000760  muls.w (a3)+, d0
000762  muls.w (a3)+, d1
000764  muls.w (a3)+, d2
000766  add.l  d0, d1
000768  add.l  d2, d1
00076A  addi.l #$1d10, d3
000770  divs.w d3, d1
000772  move.l #$120000, d0
000778  divs.w d3, d0
00077A  exg.l  d0, d1
00077C  addi.w #$a0, d0
000780  subi.w #$28, d1
000784  add.w  d1, d1
000786  move.w (a4, d1.w), d1
00078A  move.w d0, d2
00078C  lsr.w  #$3, d0
00078E  andi.w #$7, d2
000792  add.w  d2, d2
000794  add.w  d2, d2
000796  move.w (a0, d2.w), (a1)+
00079A  add.w  d1, d0
00079C  move.w d0, (a1)+
00079E  dbra   d6, $738
0007A2  dbra   d7, $734
0007A6  cmpi.l #$249f0, $7e8.l
0007B0  bne.w  $708
0007B4  rts    
0007B6  movea.l (a1)+, a3
0007B8  adda.w (a2)+, a3
0007BA  nop    
0007BC  nop    
0007BE  rts    
0007C0  lea.l  $258(a1), a1
0007C4  lea.l  $44c(a2), a2
0007C8  or.b   d0, $0(a3)
0007CC  or.b   d1, $0(a3)
0007D0  or.b   d2, $0(a3)
0007D4  or.b   d3, $0(a3)
0007D8  or.b   d4, $0(a3)
0007DC  or.b   d5, $0(a3)
0007E0  or.b   d6, $0(a3)
0007E4  or.b   d7, $0(a3)
0007E8  ori.b  #$0, d0
0007EC  ori.b  #$fa, d0
0007F0  addi.l #$70003233, d4
0007F6  ori.l  #$3433005a, -(a6)
0007FC  moveq  #$0, d0
0007FE  move.w -$5a(a3, d0.w), d3
000802  move.w $5a(a3, d0.w), d4
000806  move.w $7ec.l, d0
00080C  move.w -$5a(a3, d0.w), d5
000810  move.w $5a(a3, d0.w), d6
000814  move.w d4, d7
000816  muls.w d6, d7
000818  add.l  d7, d7
00081A  swap   d7
00081C  move.w d7, $8d4.l
000822  move.w d4, d7
000824  muls.w d5, d7
000826  add.l  d7, d7
000828  swap   d7
00082A  move.w d7, $8d6.l
000830  move.w d3, d7
000832  neg.w  d7
000834  move.w d7, $8d8.l
00083A  move.w d1, d7
00083C  muls.w d3, d7
00083E  add.l  d7, d7
000840  swap   d7
000842  move.w d7, $862.l
000848  muls.w d6, d7
00084A  add.l  d7, d7
00084C  swap   d7
00084E  move.w d2, d0
000850  muls.w d5, d0
000852  add.l  d0, d0
000854  swap   d0
000856  sub.w  d0, d7
000858  move.w d7, $8da.l
00085E  move.w d5, d7
000860  muls.w #$0, d7
000864  add.l  d7, d7
000866  swap   d7
000868  move.w d2, d0
00086A  muls.w d6, d0
00086C  add.l  d0, d0
00086E  swap   d0
000870  add.w  d0, d7
000872  move.w d7, $8dc.l
000878  move.w d1, d7
00087A  muls.w d4, d7
00087C  add.l  d7, d7
00087E  swap   d7
000880  move.w d7, $8de.l
000886  move.w d2, d7
000888  muls.w d3, d7
00088A  add.l  d7, d7
00088C  swap   d7
00088E  move.w d7, $8ae.l
000894  muls.w d6, d7
000896  add.l  d7, d7
000898  swap   d7
00089A  move.w d1, d0
00089C  muls.w d5, d0
00089E  add.l  d0, d0
0008A0  swap   d0
0008A2  add.w  d0, d7
0008A4  move.w d7, $8e0.l
0008AA  move.w d5, d7
0008AC  muls.w #$0, d7
0008B0  add.l  d7, d7
0008B2  swap   d7
0008B4  move.w d1, d0
0008B6  muls.w d6, d0
0008B8  add.l  d0, d0
0008BA  swap   d0
0008BC  sub.w  d0, d7
0008BE  move.w d7, $8e2.l
0008C4  move.w d2, d7
0008C6  muls.w d4, d7
0008C8  add.l  d7, d7
0008CA  swap   d7
0008CC  move.w d7, $8e4.l
0008D2  rts    
0008D4  ori.b  #$0, d0
0008D8  ori.b  #$0, d0
0008DC  ori.b  #$0, d0
0008E0  ori.b  #$0, d0
0008E4  ori.b  #$0, d0
0008E8  ori.b  #$0, d0
0008EC  ori.b  #$0, d0
0008F0  ori.b  #$0, d0
0008F4  ori.b  #$0, d0
0008F8  ori.b  #$0, d0
0008FC  ori.b  #$0, d0
000900  ori.b  #$0, d0
000904  ori.b  #$0, d0
000908  ori.b  #$0, d0
00090C  ori.b  #$0, d0
000910  ori.b  #$0, d0
000914  ori.b  #$0, d0
000918  ori.b  #$0, d0
00091C  ori.b  #$0, d0
000920  ori.b  #$0, d0
000924  ori.b  #$0, d0
000928  ori.b  #$0, d0
00092C  ori.b  #$0, d0
000930  ori.b  #$0, d0
000934  ori.b  #$0, d0
000938  ori.b  #$0, d0
00093C  ori.b  #$0, d0
000940  ori.b  #$0, d0
000944  ori.b  #$0, d0
000948  ori.b  #$0, d0
00094C  ori.b  #$0, d0
000950  ori.b  #$0, d0
000954  ori.b  #$0, d0
000958  ori.b  #$0, d0
00095C  ori.b  #$0, d0
000960  ori.b  #$0, d0
000964  ori.b  #$0, d0
000968  ori.b  #$0, d0
00096C  ori.b  #$0, d0
000970  ori.b  #$0, d0
000974  ori.b  #$0, d0
000978  ori.b  #$0, d0
00097C  ori.b  #$0, d0
000980  ori.b  #$0, d0
000984  ori.b  #$0, d0
000988  ori.b  #$0, d0
00098C  ori.b  #$0, d0
000990  ori.b  #$0, d0
000994  ori.b  #$0, d0
000998  ori.b  #$0, d0
00099C  ori.b  #$0, d0
0009A0  ori.b  #$0, d0
0009A4  ori.b  #$0, d0
0009A8  ori.b  #$0, d0
0009AC  ori.b  #$0, d0
0009B0  ori.b  #$0, d0
0009B4  ori.b  #$0, d0
0009B8  ori.b  #$0, d0
0009BC  ori.b  #$0, d0
0009C0  ori.b  #$0, d0
0009C4  ori.b  #$0, d0
0009C8  ori.b  #$0, d0
0009CC  ori.b  #$0, d0
0009D0  ori.b  #$0, d0
0009D4  ori.b  #$0, d0
0009D8  ori.b  #$0, d0
0009DC  ori.b  #$0, d0
0009E0  ori.b  #$0, d0
0009E4  ori.b  #$0, d0
0009E8  ori.b  #$0, d0
0009EC  ori.b  #$0, d0
0009F0  ori.b  #$0, d0
0009F4  ori.b  #$0, d0
0009F8  ori.b  #$0, d0
0009FC  ori.b  #$0, d0
000A00  ori.b  #$0, d0
000A04  ori.b  #$0, d0
000A08  ori.b  #$0, d0
000A0C  ori.b  #$0, d0
000A10  ori.b  #$0, d0
000A14  ori.b  #$0, d0
000A18  ori.b  #$0, d0
000A1C  ori.b  #$0, d0
000A20  ori.b  #$0, d0
000A24  ori.b  #$0, d0
000A28  ori.b  #$0, d0
000A2C  ori.b  #$0, d0
000A30  ori.b  #$0, d0
000A34  ori.b  #$0, d0
000A38  ori.b  #$0, d0
000A3C  ori.b  #$0, d0
000A40  ori.b  #$0, d0
000A44  ori.b  #$0, d0
000A48  ori.b  #$0, d0
000A4C  ori.b  #$0, d0
000A50  ori.b  #$0, d0
000A54  ori.b  #$0, d0
000A58  ori.b  #$0, d0
000A5C  ori.b  #$0, d0
000A60  ori.b  #$0, d0
000A64  ori.b  #$0, d0
000A68  ori.b  #$0, d0
000A6C  ori.b  #$0, d0
000A70  ori.b  #$0, d0
000A74  ori.b  #$0, d0
000A78  ori.b  #$0, d0
000A7C  ori.b  #$0, d0
000A80  ori.b  #$0, d0
000A84  ori.b  #$0, d0
000A88  ori.b  #$0, d0
000A8C  ori.b  #$0, d0
000A90  ori.b  #$0, d0
000A94  ori.b  #$0, d0
000A98  ori.b  #$0, d0
000A9C  ori.b  #$0, d0
000AA0  ori.b  #$0, d0
000AA4  ori.b  #$0, d0
000AA8  ori.b  #$0, d0
000AAC  ori.b  #$0, d0
000AB0  ori.b  #$0, d0
000AB4  ori.b  #$0, d0
000AB8  ori.b  #$0, d0
000ABC  ori.b  #$0, d0
000AC0  ori.b  #$0, d0
000AC4  ori.b  #$0, d0
000AC8  ori.b  #$0, d0
000ACC  ori.b  #$0, d0
000AD0  ori.b  #$0, d0
000AD4  ori.b  #$0, d0
000AD8  ori.b  #$0, d0
000ADC  ori.b  #$0, d0
000AE0  ori.b  #$0, d0
000AE4  ori.b  #$0, d0
000AE8  ori.b  #$79, d0
000AEC  ori.b  #$ae, d0
000AF0  cmpi.w #$8, $cae.l
000AF8  bne.b  $b00
000AFA  clr.w  $cae.l
000B00  lea.l  $cb0(pc), a0
000B04  adda.w $cae(pc), a0
000B08  move.l (a0)+, $caa.l
000B0E  move.l (a0)+, d1
000B10  addq.l #$4, d1
000B12  tst.w  $cc0.l
000B18  bne.b  $b44
000B1A  lea.l  $cc6.l, a0
000B20  adda.w $cc2.l, a0
000B26  addq.w #$2, $cc2.l
000B2C  move.w (a0)+, $cc0.l
000B32  move.w #$3c, $cc4.l
000B3A  tst.w  (a0)
000B3C  bne.b  $b44
000B3E  clr.w  $cc2.l
000B44  subq.w #$1, $cc0.l
000B4A  move.l $660.l, d0
000B50  add.l  $ca4.l, d0
000B56  tst.w  $cc4.l
000B5C  ble.b  $b68
000B5E  addi.l #$2710, $ca4.l
000B68  subq.w #$1, $cc4.l
000B6E  cmpi.l #$249f0, $ca4.l
000B78  bne.b  $b80
000B7A  clr.l  $ca4.l
000B80  cmpi.l #$2710, $ca4.l
000B8A  bne.b  $b92
000B8C  addq.w #$1, $ca8.l
000B92  btst.b #$1, $ca9.l
000B9A  bne.b  $bcc
000B9C  btst.b #$0, $ca9.l
000BA4  beq.b  $bb6
000BA6  move.w #$4, $106.l
000BAE  move.l #$198, d2
000BB4  bra.b  $bca
000BB6  move.w #$194, $106.l
000BBE  addi.l #$188, d1
000BC4  move.l #$fffffff8, d2
000BCA  bra.b  $c00
000BCC  btst.b #$0, $ca9.l
000BD4  beq.b  $bec
000BD6  move.w #$fff4, $106.l
000BDE  addi.l #$4fa0, d1
000BE4  move.l #$fffffe68, d2
000BEA  bra.b  $c00
000BEC  move.w #$fe64, $106.l
000BF4  addi.l #$4e18, d1
000BFA  move.l #$8, d2
000C00  lea.l  $10a.l, a0
000C06  move.l #$c8, d3
000C0C  move.w #$9, d7
000C10  swap   d0
000C12  move.w d0, (a0)
000C14  swap   d0
000C16  move.w d0, $4(a0)
000C1A  swap   d1
000C1C  move.w d1, $8(a0)
000C20  swap   d1
000C22  move.w d1, $c(a0)
000C26  add.l  d3, d0
000C28  add.l  d2, d1
000C2A  swap   d0
000C2C  move.w d0, $20(a0)
000C30  swap   d0
000C32  move.w d0, $24(a0)
000C36  swap   d1
000C38  move.w d1, $28(a0)
000C3C  swap   d1
000C3E  move.w d1, $2c(a0)
000C42  add.l  d3, d0
000C44  add.l  d2, d1
000C46  swap   d0
000C48  move.w d0, $40(a0)
000C4C  swap   d0
000C4E  move.w d0, $44(a0)
000C52  swap   d1
000C54  move.w d1, $48(a0)
000C58  swap   d1
000C5A  move.w d1, $4c(a0)
000C5E  add.l  d3, d0
000C60  add.l  d2, d1
000C62  swap   d0
000C64  move.w d0, $60(a0)
000C68  swap   d0
000C6A  move.w d0, $64(a0)
000C6E  swap   d1
000C70  move.w d1, $68(a0)
000C74  swap   d1
000C76  move.w d1, $6c(a0)
000C7A  add.l  d3, d0
000C7C  add.l  d2, d1
000C7E  swap   d0
000C80  move.w d0, $80(a0)
000C84  swap   d0
000C86  move.w d0, $84(a0)
000C8A  swap   d1
000C8C  move.w d1, $88(a0)
000C90  swap   d1
000C92  move.w d1, $8c(a0)
000C96  add.l  d3, d0
000C98  add.l  d2, d1
000C9A  lea.l  $a0(a0), a0
000C9E  dbra   d7, $c10
000CA2  rts    
000CA4  ori.b  #$0, d0
000CA8  ori.b  #$0, d0
000CAC  ori.b  #$0, d0
000CB0  ori.b  #$0, d0
000CB4  ori.b  #$0, d0
000CB8  ori.b  #$0, d0
000CBC  ori.b  #$0, d0
000CC0  ori.b  #$0, d0
000CC4  ori.b  #$b0, d0
000CC8  ori.l  #$2c00000, $79(a0, d5.l)
000CD0  ori.b  #$50, d0
000CD4  cmpi.w #$c, $d50.l
000CDC  bne.b  $ce4
000CDE  clr.w  $d50.l
000CE4  lea.l  $d6a(pc), a0
000CE8  adda.w $d50(pc), a0
000CEC  move.l $4(a0), $d48.l
000CF4  lea.l  $d52(pc), a0
000CF8  adda.w $d50(pc), a0
000CFC  move.l (a0)+, d0
000CFE  move.l (a0)+, $d4c.l
000D04  move.l (a0)+, d1
000D06  lea.l  $6a.l, a0
000D0C  move.w d0, $4(a0)
000D10  swap   d0
000D12  move.w d0, (a0)
000D14  swap   d0
000D16  addi.l #$1db0, d0
000D1C  move.w d0, $c(a0)
000D20  swap   d0
000D22  move.w d0, $8(a0)
000D26  swap   d0
000D28  addi.l #$1db0, d0
000D2E  move.w d0, $14(a0)
000D32  swap   d0
000D34  move.w d0, $10(a0)
000D38  move.w d1, $ea.l
000D3E  swap   d1
000D40  move.w d1, $e6.l
000D46  rts    
000D48  ori.b  #$0, d0
000D4C  ori.b  #$0, d0
000D50  ori.b  #$0, d0
000D54  ori.b  #$0, d0
000D58  ori.b  #$0, d0
000D5C  ori.b  #$0, d0
000D60  ori.b  #$0, d0
000D64  ori.b  #$0, d0
000D68  ori.b  #$0, d0
000D6C  ori.b  #$0, d0
000D70  ori.b  #$0, d0
000D74  ori.b  #$0, d0
000D78  ori.b  #$0, d0
000D7C  ori.b  #$0, d0
000D80  ori.b  #$39, d0
000D84  ori.b  #$12, d0
000D88  bne.b  $d8e
000D8A  bra.w  $e08
000D8E  subq.b #$1, $e12.l
000D94  movea.l $e0e(pc), a1
000D98  movea.l $e0a(pc), a0
000D9C  move.w $e18.l, d4
000DA2  subq.w #$1, d4
000DA4  move.w (a0), d0
000DA6  move.w (a1)+, d2
000DA8  move.w d0, d1
000DAA  move.w d2, d3
000DAC  andi.w #$f, d1
000DB0  andi.w #$f, d3
000DB4  cmp.w  d1, d3
000DB6  beq.b  $dc0
000DB8  blt.b  $dbe
000DBA  addq.w #$1, (a0)
000DBC  bra.b  $dc0
000DBE  subq.w #$1, (a0)
000DC0  move.w d0, d1
000DC2  move.w d2, d3
000DC4  lsr.w  #$4, d1
000DC6  lsr.w  #$4, d3
000DC8  andi.w #$f, d1
000DCC  andi.w #$f, d3
000DD0  cmp.w  d1, d3
000DD2  beq.b  $de0
000DD4  blt.b  $ddc
000DD6  addi.w #$10, (a0)
000DDA  bra.b  $de0
000DDC  subi.w #$10, (a0)
000DE0  move.w d0, d1
000DE2  move.w d2, d3
000DE4  lsr.w  #$8, d1
000DE6  lsr.w  #$8, d3
000DE8  andi.w #$f, d1
000DEC  andi.w #$f, d3
000DF0  cmp.w  d1, d3
000DF2  beq.b  $e00
000DF4  blt.b  $dfc
000DF6  addi.w #$100, (a0)
000DFA  bra.b  $e00
000DFC  subi.w #$100, (a0)
000E00  lea.l  $2(a0), a0
000E04  dbra   d4, $da4
000E08  rts    
000E0A  ori.b  #$0, d0
000E0E  ori.b  #$0, d0
000E12  ori.b  #$0, d0
000E16  ori.b  #$0, d0
000E1A  ori.b  #$3c, d0
000E1E  subi.w #$6b3, $8ee.w
000E24  btst.l d5, $d61(a0)
000E28  bclr.b d7, (a1)+
000E2A  move.b (a0), $1406.w
000E2E  move.b $269c(pc), d3
000E32  move.b (a4)+, (a5)
000E34  ; data: 0x1c, 0xcb
000E36  move.b $2348(a7, d2.w), (a7)+
000E3C  move.l $278d(a4), $29ac(a2)
000E42  ; data: 0x2b, 0xc7
000E44  ; data: 0x2d, 0xde
000E46  ; data: 0x2f, 0xf2
000E48  move.w d3, d1
000E4A  move.w a7, d2
000E4C  move.w (a0)+, d3
000E4E  move.w (a4)+, d4
000E50  move.w (a4)+, d5
000E52  move.w (a7), d6
000E54  move.w a5, d7
000E56  ; data: 0x3f, 0xff
000E58  lea.l  $43d3(a4), a0
000E5C  chk.w  ([, d4.w * 8], $496a4b3b), d2
000E64  dc.w   $4d07
000E66  ; data: 0x4e, 0xcd
000E68  addq.l #$8, a4
000E6A  addq.w #$1, d6
000E6C  sls.b  $55a5574b.l
000E72  svc.b  $5a81(a1)
000E76  addq.b #$6, (a2)
000E78  subq.l #$6, (a4)+
000E7A  subq.b #$7, (a6)+
000E7C  bra.b  $e17
000E7E  bhi.b  $e8c
000E80  bls.b  $efa
000E82  bcc.b  $e60
000E84  bne.b  $ebe
000E86  beq.b  $e15
000E88  bvc.b  $e63
000E8A  bpl.b  $ea9
000E8C  bmi.b  $ee6
000E8E  bge.b  $e1b
000E90  blt.b  $e48
000E92  bgt.b  $e6d
000E94  ble.b  $e88
000E96  ; data: 0x71, 0x03
000E98  moveq  #$b, d1
000E9A  ; data: 0x73, 0x0a
000E9C  moveq  #$1, d2
000E9E  moveq  #$ee, d2
000EA0  ; data: 0x75, 0xd2
000EA2  moveq  #$ad, d3
000EA4  ; data: 0x77, 0x7e
000EA6  moveq  #$47, d4
000EA8  ; data: 0x79, 0x05
000EAA  ; data: 0x79, 0xbb
000EAC  moveq  #$67, d5
000EAE  ; data: 0x7b, 0x09
000EB0  ; data: 0x7b, 0xa2
000EB2  moveq  #$31, d6
000EB4  moveq  #$b7, d6
000EB6  ; data: 0x7d, 0x33
000EB8  ; data: 0x7d, 0xa5
000EBA  moveq  #$d, d7
000EBC  moveq  #$6b, d7
000EBE  moveq  #$c0, d7
000EC0  ; data: 0x7f, 0x0b
000EC2  ; data: 0x7f, 0x4b
000EC4  ; data: 0x7f, 0x82
000EC6  ; data: 0x7f, 0xaf
000EC8  ; data: 0x7f, 0xd2
000ECA  ; data: 0x7f, 0xeb
000ECC  ; data: 0x7f, 0xfa
000ECE  ; data: 0x7f, 0xff
000ED0  ; data: 0x7f, 0xfa
000ED2  ; data: 0x7f, 0xeb
000ED4  ; data: 0x7f, 0xd2
000ED6  ; data: 0x7f, 0xaf
000ED8  ; data: 0x7f, 0x82
000EDA  ; data: 0x7f, 0x4c
000EDC  ; data: 0x7f, 0x0b
000EDE  moveq  #$c0, d7
000EE0  moveq  #$6c, d7
000EE2  moveq  #$d, d7
000EE4  ; data: 0x7d, 0xa5
000EE6  ; data: 0x7d, 0x33
000EE8  moveq  #$b8, d6
000EEA  moveq  #$32, d6
000EEC  ; data: 0x7b, 0xa3
000EEE  ; data: 0x7b, 0x0a
000EF0  moveq  #$68, d5
000EF2  ; data: 0x79, 0xbc
000EF4  ; data: 0x79, 0x06
000EF6  moveq  #$48, d4
000EF8  ; data: 0x77, 0x7f
000EFA  moveq  #$ae, d3
000EFC  ; data: 0x75, 0xd3
000EFE  moveq  #$ef, d2
000F00  moveq  #$2, d2
000F02  ; data: 0x73, 0x0c
000F04  moveq  #$d, d1
000F06  ; data: 0x71, 0x04
000F08  ble.b  $efe
000F0A  bgt.b  $ee6
000F0C  blt.b  $ec6
000F0E  bge.b  $e9d
000F10  bmi.b  $f6c
000F12  bpl.b  $f32
000F14  bvc.b  $ef0
000F16  beq.b  $ea6
000F18  bne.b  $f54
000F1A  bcc.b  $efa
000F1C  bls.b  $f98
000F1E  bhi.b  $f2e
000F20  bra.b  $ebd
000F22  subq.b #$7, -(a0)
000F24  subq.l #$6, (a6)+
000F26  addq.b #$6, (a4)
000F28  addq.l #$5, d3
000F2A  svc.b  $574d(a4)
000F2E  subq.l #$2, -(a7)
000F30  dc.w   $53fb
000F32  addq.w #$1, a0
000F34  addq.l #$8, a7
000F36  ; data: 0x4e, 0xcf
000F38  ; data: 0x4d, 0x0a
000F3A  ; data: 0x4b, 0x3e
000F3C  ; data: 0x49, 0x6c
000F3E  chk.w  (a5), d3
000F40  chk.w  $43d6.w, d2
000F44  lea.l  $4002(a6), a0
000F48  move.w (a0), d7
000F4A  move.w (a1)+, d6
000F4C  move.w (a6)+, d5
000F4E  move.w (a6)+, d4
000F50  move.w (a2)+, d3
000F52  move.w (a2), d2
000F54  move.w d6, d1
000F56  ; data: 0x2f, 0xf5
000F58  ; data: 0x2d, 0xe1
000F5A  ; data: 0x2b, 0xca
000F5C  move.l $2790(a6), ([$234a, a4])
000F64  move.l -(a3), -(a0)
000F66  move.b $2c36(pc), (a7)+
000F6A  move.b (a7)+, (a5)
000F6C  ; data: 0x18, 0x6f
000F6E  ; data: 0x16, 0x3d
000F70  ; data: 0x14, 0x09
000F72  move.b (a3), $f9c.w
000F76  bchg.b d6, -(a4)
000F78  btst.l d5, $8f1(a3)
000F7C  addi.l #$47b023f, $3(a6, d0.w)
000F84  ; data: 0xfd, 0xc7
000F86  ; data: 0xfb, 0x8c
000F88  dc.w   $f950
000F8A  dc.w   $f715
000F8C  dc.w   $f4db
000F8E  dc.w   $f2a2
000F90  dc.w   $f06a
000F92  roxr.l #$7, d3
000F94  ; data: 0xeb, 0xfd
000F96  ; data: 0xe9, 0xc9
000F98  roxl.l #$3, d7
000F9A  asl.w  d2, d7
000F9C  rol.b  d1, d0
000F9E  lsl.b  #$8, d4
000FA0  adda.w -(a2), a7
000FA2  add.l  $f3b(pc, a5.l), d6
000FA6  add.w  $57(a6, a5.w), d4
000FAA  add.b  #$25, d2
000FAE  add.b  (a0), d0
000FB0  and.b  d0, d7
000FB2  muls.w ([$c7e7], $c5e7c3ec), d5
000FBC  muls.w $4(a5, a4.w), d0
000FC0  cmp.b  (a7), d7
000FC2  cmp.b  -$45b3(a7), d6
000FC6  cmp.w  -$67(a0, a3.w), d4
000FCA  cmpa.w d7, a2
000FCC  cmpa.w ([$af76bd8b, pc], a3.w, $ac0a), a1
000FD6  ; data: 0xaa, 0x5d
000FD8  ; data: 0xa8, 0xb8
000FDA  ; data: 0xa7, 0x19
000FDC  ; data: 0xa5, 0x81
000FDE  ; data: 0xa3, 0xf0
000FE0  ; data: 0xa2, 0x66
000FE2  ; data: 0xa0, 0xe4
000FE4  sub.w  d7, -$620a(a1)
000FE8  sub.l  a2, d6
000FEA  sub.b  d5, -(a6)
000FEC  suba.l a1, a4
000FEE  sub.w  ([$95e5, a5, a1.w * 8]), d4
000FF4  sub.l  -$6c8a(a1), d2
000FF8  sub.w  a3, d1
000FFA  sub.b  d0, -$6ff1(a1)
000FFE  ; data: 0x8e, 0xfe
001000  divs.w -$9(a6, a0.l), d6
001004  or.b   d1, d6
001006  or.b   d5, (a4)
001008  or.b   -$76ab(a7), d5
00100C  or.l   d3, d4
00100E  ; data: 0x87, 0xbb
001010  divu.w #$8646, d3
001014  or.l   d2, (a2)+
001016  divu.w $845f.w, d2
00101A  ; data: 0x83, 0xcf
00101C  dc.w   $834a
00101E  ; data: 0x82, 0xce
001020  or.w   (a4)+, d1
001022  divs.w ([], a0.w), d0
001026  dc.w   $8141
001028  divu.w -$4b(a6, a0.w), d0
00102C  ; data: 0x80, 0x7e
00102E  or.w   (a1), d0
001030  or.b   -$7feb(a6), d0
001034  or.b   d6, d0
001036  or.b   d1, d0
001038  or.b   d6, d0
00103A  or.b   (a5), d0
00103C  or.b   -$7fb0(a6), d0
001040  ; data: 0x80, 0x7d
001042  or.l   -$b(a4, a0.w), d0
001046  ; data: 0x81, 0x3f
001048  or.l   d0, (a4)
00104A  divs.w $5a(a2, a0.w), d0
00104E  ; data: 0x82, 0xcc
001050  dc.w   $8348
001052  ; data: 0x83, 0xcd
001054  or.w   (a4)+, d2
001056  divu.w ([], a0.w * 4, $864386f9), d2
00105E  or.l   d3, -$80(a7, a0.l)
001062  or.w   d4, (a1)
001064  or.b   -$74f0(a4), d5
001068  ; data: 0x8b, 0xfd
00106A  divu.w ([$8efa900b], $9124), d6
001074  sub.w  d7, d1
001076  sub.w  d1, -$5c(a1, a1.w)
00107A  suba.l -(a0), a2
00107C  sub.b  d3, -(a4)
00107E  sub.w  (invalid.w), d4
001082  sub.b  d5, -(a0)
001084  sub.l  d4, d6
001086  suba.l ([$a0de, a0], $a260a3ea), a6
001090  ; data: 0xa5, 0x7a
001092  ; data: 0xa7, 0x12
001094  ; data: 0xa8, 0xb1
001096  ; data: 0xaa, 0x57
001098  ; data: 0xac, 0x03
00109A  ; data: 0xad, 0xb6
00109C  ; data: 0xaf, 0x6f
00109E  eor.b  d0, -$4d0c(a6)
0010A2  cmpa.w d0, a2
0010A4  cmp.l  (a1), d3
0010A6  cmp.w  -$45bb(a0), d4
0010AA  cmp.b  -(a7), d6
0010AC  ; data: 0xbe, 0x0f
0010AE  cmpa.l #$c1edc3e4, a7
0010B4  muls.w (a7)+, d2
0010B6  muls.w (a7)+, d3
0010B8  muls.w -(a3), d4
0010BA  muls.w -$3208(a3), d5
0010BE  ; data: 0xd0, 0x08
0010C0  add.b  (a4)+, d1
0010C2  add.b  $4f(a4, a5.w), d2
0010C6  add.w  -$2572(a5), d4
0010CA  add.l  -$26(a3, a5.l), d6
0010CE  asl.b  #$8, d3
0010D0  lsl.b  d1, d7
0010D2  rol.w  #$2, d6
0010D4  lsl.l  #$3, d6
0010D6  ; data: 0xe9, 0xc0
0010D8  ; data: 0xeb, 0xf4
0010DA  lsr.b  d7, d2
0010DC  dc.w   $f061
0010DE  dc.w   $f299
0010E0  dc.w   $f4d2
0010E2  ; data: 0xf7, 0x0c
0010E4  ; data: 0xf9, 0x47
0010E6  ; data: 0xfb, 0x82
0010E8  ; data: 0xfd, 0xbe
0010EA  ori.b  #$3c, d0
0010EE  subi.w #$6b3, $8ee.w
0010F4  btst.l d5, $d61(a0)
0010F8  bclr.b d7, (a1)+
0010FA  move.b (a0), $1406.w
0010FE  move.b $296c(pc), d3
001102  move.b (a4)+, (a5)
001104  ; data: 0x1c, 0xcb
001106  move.b $2348(a7, d2.w), (a7)+
00110C  move.l $278d(a4), $29ac(a2)
001112  ; data: 0x2b, 0xc7
001114  ; data: 0x2d, 0xde
001116  ; data: 0x2f, 0xf2
001118  move.w d3, d1
00111A  move.w a7, d2
00111C  move.w (a0)+, d3
00111E  move.w (a4)+, d4
001120  move.w (a4)+, d5
001122  move.w (a7), d6
001124  move.w a5, d7
001126  ; data: 0x3f, 0xff
001128  lea.l  $43d3(a4), a0
00112C  chk.w  ([, d4.w * 8], $496a4b3b), d2
001134  dc.w   $4d07
001136  ; data: 0x4e, 0xcd
001138  addq.l #$8, a4
00113A  addq.w #$1, d6
00113C  sls.b  $55a5574b.l
001142  svc.b  $5a81(a1)
001146  addq.b #$6, (a2)
001148  subq.l #$6, (a4)+
00114A  subq.b #$7, (a6)+
00114C  bra.b  $10e7
00114E  bhi.b  $115c
001150  bls.b  $11ca
001152  bcc.b  $1130
001154  bne.b  $118e
001156  beq.b  $10e5
001158  bvc.b  $1133
00115A  bpl.b  $1179
00115C  bmi.b  $11b6
00115E  bge.b  $10eb
001160  blt.b  $1118
001162  bgt.b  $113d
001164  ble.b  $1158
001166  ; data: 0x71, 0x03
001168  moveq  #$b, d1
00116A  ; data: 0x73, 0x0a
00116C  moveq  #$1, d2
00116E  moveq  #$ee, d2
001170  ; data: 0x75, 0xd2
001172  moveq  #$ad, d3
001174  ; data: 0x77, 0x7e
001176  moveq  #$47, d4
001178  ; data: 0x79, 0x05
00117A  ; data: 0x79, 0xbb
00117C  moveq  #$67, d5
00117E  ; data: 0x7b, 0x09
001180  ; data: 0x7b, 0xa2
001182  moveq  #$31, d6
001184  moveq  #$b7, d6
001186  ; data: 0x7d, 0x33
001188  ; data: 0x7d, 0xa5
00118A  moveq  #$d, d7
00118C  moveq  #$6b, d7
00118E  moveq  #$c0, d7
001190  ; data: 0x7f, 0x0b
001192  ; data: 0x7f, 0x4b
001194  ; data: 0x7f, 0x82
001196  ; data: 0x7f, 0xaf
001198  ; data: 0x7f, 0xd2
00119A  ; data: 0x7f, 0xeb
00119C  ; data: 0x7f, 0xfa
00119E  ; data: 0x7f, 0xff
0011A0  ; data: 0x7f, 0xfa
0011A2  ; data: 0x7f, 0xeb
0011A4  ; data: 0x7f, 0xd2
0011A6  ; data: 0x7f, 0xaf
0011A8  ; data: 0x7f, 0x82
0011AA  ; data: 0x7f, 0x4c
0011AC  ; data: 0x7f, 0x0b
0011AE  moveq  #$c0, d7
0011B0  moveq  #$6c, d7
0011B2  moveq  #$d, d7
0011B4  ; data: 0x7d, 0xa5
0011B6  ; data: 0x7d, 0x33
0011B8  moveq  #$b8, d6
0011BA  moveq  #$32, d6
0011BC  ; data: 0x7b, 0xa3
0011BE  ; data: 0x7b, 0x0a
0011C0  moveq  #$68, d5
0011C2  ; data: 0x79, 0xbc
0011C4  ; data: 0x79, 0x06
0011C6  moveq  #$48, d4
0011C8  ; data: 0x77, 0x7f
0011CA  moveq  #$ae, d3
0011CC  ; data: 0x75, 0xd3
0011CE  moveq  #$ef, d2
0011D0  moveq  #$2, d2
0011D2  ; data: 0x73, 0x0c
0011D4  moveq  #$d, d1
0011D6  ; data: 0x71, 0x04
0011D8  ble.b  $11ce
0011DA  bgt.b  $11b6
0011DC  blt.b  $1196
0011DE  bge.b  $116d
0011E0  bmi.b  $123c
0011E2  bpl.b  $1202
0011E4  bvc.b  $11c0
0011E6  beq.b  $1176
0011E8  bne.b  $1224
0011EA  bcc.b  $11ca
0011EC  bls.b  $1268
0011EE  bhi.b  $11fe
0011F0  bra.b  $118d
0011F2  subq.b #$7, -(a0)
0011F4  subq.l #$6, (a6)+
0011F6  addq.b #$6, (a4)
0011F8  addq.l #$5, d3
0011FA  svc.b  $574d(a4)
0011FE  subq.l #$2, -(a7)
001200  dc.w   $53fb
001202  addq.w #$1, a0
001204  addq.l #$8, a7
001206  ; data: 0x4e, 0xcf
001208  ; data: 0x4d, 0x0a
00120A  ; data: 0x4b, 0x3e
00120C  ; data: 0x49, 0x6c
00120E  chk.w  (a5), d3
001210  chk.w  $43d6.w, d2
001214  lea.l  $4002(a6), a0
001218  move.w (a0), d7
00121A  move.w (a1)+, d6
00121C  move.w (a6)+, d5
00121E  move.w (a6)+, d4
001220  move.w (a2)+, d3
001222  move.w (a2), d2
001224  move.w d6, d1
001226  ; data: 0x2f, 0xf5
001228  ; data: 0x2d, 0xe1
00122A  ; data: 0x2b, 0xca
00122C  move.l $2790(a6), ([$234a, a4])
001234  move.l -(a3), -(a0)
001236  move.b $2f06(pc), (a7)+
00123A  move.b (a7)+, (a5)
00123C  ; data: 0x18, 0x6f
00123E  ; data: 0x16, 0x3d
001240  ; data: 0x14, 0x09
001242  move.b (a3), $f9c.w
001246  bchg.b d6, -(a4)
001248  btst.l d5, $8f1(a3)
00124C  addi.l #$47b023f, $3(a6, d0.w)
001254  ; data: 0xfd, 0xc7
001256  ; data: 0xfb, 0x8c
001258  dc.w   $f950
00125A  dc.w   $f715
00125C  dc.w   $f4db
00125E  dc.w   $f2a2
001260  dc.w   $f06a
001262  roxr.l #$7, d3
001264  ; data: 0xeb, 0xfd
001266  ; data: 0xe9, 0xc9
001268  roxl.l #$3, d7
00126A  asl.w  d2, d7
00126C  rol.b  d1, d0
00126E  lsl.b  #$8, d4
001270  adda.w -(a2), a7
001272  add.l  $120b(pc, a5.l), d6
001276  add.w  $57(a6, a5.w), d4
00127A  add.b  #$25, d2
00127E  add.b  (a0), d0
001280  and.b  d0, d7
001282  muls.w ([$c7e7], $c5e7c3ec), d5
00128C  muls.w $4(a5, a4.w), d0
001290  cmp.b  (a7), d7
001292  cmp.b  -$45b3(a7), d6
001296  cmp.w  -$67(a0, a3.w), d4
00129A  cmpa.w d7, a2
00129C  cmpa.w ([$af76c05b, pc], a3.w, $ac0a), a1
0012A6  ; data: 0xaa, 0x5d
0012A8  ; data: 0xa8, 0xb8
0012AA  ; data: 0xa7, 0x19
0012AC  ; data: 0xa5, 0x81
0012AE  ; data: 0xa3, 0xf0
0012B0  ; data: 0xa2, 0x66
0012B2  ; data: 0xa0, 0xe4
0012B4  sub.w  d7, -$620a(a1)
0012B8  sub.l  a2, d6
0012BA  sub.b  d5, -(a6)
0012BC  suba.l a1, a4
0012BE  sub.w  ([$95e5, a5, a1.w * 8]), d4
0012C4  sub.l  -$6c8a(a1), d2
0012C8  sub.w  a3, d1
0012CA  sub.b  d0, -$6ff1(a1)
0012CE  ; data: 0x8e, 0xfe
0012D0  divs.w -$9(a6, a0.l), d6
0012D4  or.b   d1, d6
0012D6  or.b   d5, (a4)
0012D8  or.b   -$76ab(a7), d5
0012DC  or.l   d3, d4
0012DE  ; data: 0x87, 0xbb
0012E0  divu.w #$8646, d3
0012E4  or.l   d2, (a2)+
0012E6  divu.w $845f.w, d2
0012EA  ; data: 0x83, 0xcf
0012EC  dc.w   $834a
0012EE  ; data: 0x82, 0xce
0012F0  or.w   (a4)+, d1
0012F2  divs.w ([], a0.w), d0
0012F6  dc.w   $8141
0012F8  divu.w -$4b(a6, a0.w), d0
0012FC  ; data: 0x80, 0x7e
0012FE  or.w   (a1), d0
001300  or.b   -$7feb(a6), d0
001304  or.b   d6, d0
001306  or.b   d1, d0
001308  or.b   d6, d0
00130A  or.b   (a5), d0
00130C  or.b   -$7fb0(a6), d0
001310  ; data: 0x80, 0x7d
001312  or.l   -$b(a4, a0.w), d0
001316  ; data: 0x81, 0x3f
001318  or.l   d0, (a4)
00131A  divs.w $5a(a2, a0.w), d0
00131E  ; data: 0x82, 0xcc
001320  dc.w   $8348
001322  ; data: 0x83, 0xcd
001324  or.w   (a4)+, d2
001326  divu.w ([], a0.w * 4, $864386f9), d2
00132E  or.l   d3, -$80(a7, a0.l)
001332  or.w   d4, (a1)
001334  or.b   -$74f0(a4), d5
001338  ; data: 0x8b, 0xfd
00133A  divu.w ([$8efa900b], $9124), d6
001344  sub.w  d7, d1
001346  sub.w  d1, -$5c(a1, a1.w)
00134A  suba.l -(a0), a2
00134C  sub.b  d3, -(a4)
00134E  sub.w  (invalid.w), d4
001352  sub.b  d5, -(a0)
001354  sub.l  d4, d6
001356  suba.l ([$a0de, a0], $a260a3ea), a6
001360  ; data: 0xa5, 0x7a
001362  ; data: 0xa7, 0x12
001364  ; data: 0xa8, 0xb1
001366  ; data: 0xaa, 0x57
001368  ; data: 0xac, 0x03
00136A  ; data: 0xad, 0xb6
00136C  ; data: 0xaf, 0x6f
00136E  eor.b  d0, -$4d0c(a6)
001372  cmpa.w d0, a2
001374  cmp.l  (a1), d3
001376  cmp.w  -$45bb(a0), d4
00137A  cmp.b  -(a7), d6
00137C  ; data: 0xbe, 0x0f
00137E  cmpa.l #$c1edc3e4, a7
001384  muls.w (a7)+, d2
001386  muls.w (a7)+, d3
001388  muls.w -(a3), d4
00138A  muls.w -$3208(a3), d5
00138E  ; data: 0xd0, 0x08
001390  add.b  (a4)+, d1
001392  add.b  $4f(a4, a5.w), d2
001396  add.w  -$2572(a5), d4
00139A  add.l  -$26(a3, a5.l), d6
00139E  asl.b  #$8, d3
0013A0  lsl.b  d1, d7
0013A2  rol.w  #$2, d6
0013A4  lsl.l  #$3, d6
0013A6  ; data: 0xe9, 0xc0
0013A8  ; data: 0xeb, 0xf4
0013AA  lsr.b  d7, d2
0013AC  dc.w   $f061
0013AE  dc.w   $f299
0013B0  dc.w   $f4d2
0013B2  ; data: 0xf7, 0x0c
0013B4  ; data: 0xf9, 0x47
0013B6  ; data: 0xfb, 0x82
0013B8  ; data: 0xfd, 0xbe
0013BA  ori.b  #$1e, d0
0013BE  ; data: 0x02, 0x3c
0013C0  bchg.b d1, (a2)+
0013C2  subi.w #$595, $6b3.w
0013C8  bset.b d3, (a0)
0013CA  ; data: 0x08, 0xee
0013CC  ; data: 0x0a, 0x0b
0013CE  btst.l d5, $c44(a0)
0013D2  bchg.b d6, -(a1)
0013D4  ; data: 0x0e, 0x7d
0013D6  bclr.b d7, (a1)+
0013D8  move.b (invalid.w), (a0)
0013DC  move.b $1406(a3), (a1)+
0013E0  move.b -(a0), -(a2)
0013E2  move.b $2b37(pc), d3
0013E6  ; data: 0x18, 0x6c
0013E8  move.b d4, -$64(a4, d1.l)
0013EC  move.b -$35(a4, d1.l), ([$1ef7])
0013F4  move.l a4, d0
0013F6  move.l -(a0), -(a0)
0013F8  move.l (a4, invalid.w), d1
0013FC  movea.l (a2)+, a2
0013FE  move.l $267d(a4), $278d(a2)
001404  move.l (a5)+, (a4)
001406  move.l $2aba(a4), ([])
00140C  move.l (a3), (a6)+
00140E  ; data: 0x2d, 0xde
001410  move.l $2ff2(a1), (a7)+
001414  move.w $1419(pc, d3.w), (a0)+
001418  move.w a1, -(a1)
00141A  move.w a7, d2
00141C  move.w (a4), -(a2)
00141E  move.w (a0)+, d3
001420  move.w (a2)+, -(a3)
001422  move.w (a4)+, d4
001424  move.w (a4)+, -(a4)
001426  move.w (a4)+, d5
001428  move.w (a2)+, -(a5)
00142A  move.w (a7), d6
00142C  move.w (a3), -(a6)
00142E  move.w a5, d7
001430  move.w d7, -(a7)
001432  ; data: 0x3f, 0xff
001434  move.w sr, $42e0(invalid.w)
00143A  lea.l  (a3), a1
00143C  move.w d5, ccr
00143E  chk.w  -$5b(a6, d4.w), d2
001442  chk.w  (a3), d3
001444  ; data: 0x48, 0x7f
001446  ; data: 0x49, 0x6a
001448  tst.w  (a3)
00144A  dc.w   $4b3b
00144C  ; data: 0x4c, 0x22
00144E  dc.w   $4d07
001450  lea.l  $4ecd(a3), a6
001454  chk.w  $508c(a5), d7
001458  subq.w #$8, $5246(a2)
00145C  subq.b #$1, -(a0)
00145E  sls.b  $54d055a5.l
001464  addq.w #$3, $574b581b.l
00146A  svc.b  $59b6(a1)
00146E  addq.l #$5, d1
001470  subq.w #$5, a3
001472  addq.b #$6, (a2)
001474  sge.b  (a0)+
001476  subq.l #$6, (a4)+
001478  addq.w #$7, (a6)+
00147A  subq.b #$7, (a6)+
00147C  sle.b  (a4)+
00147E  bra.b  $1419
001480  bsr.b  $14d6
001482  bhi.b  $1490
001484  bhi.b  $1449
001486  bls.b  $1500
001488  bcc.b  $14b5
00148A  bcc.b  $1468
00148C  bcs.b  $1419
00148E  bne.b  $14c8
001490  bne.b  $1475
001492  beq.b  $1421
001494  bvc.b  $14ca
001496  bvc.b  $1471
001498  bvs.b  $1516
00149A  bpl.b  $14b9
00149C  bpl.b  $1459
00149E  bmi.b  $14f8
0014A0  bmi.b  $1495
0014A2  bge.b  $142f
0014A4  blt.b  $14c8
0014A6  blt.b  $145e
0014A8  bgt.b  $14f2
0014AA  bgt.b  $1485
0014AC  ble.b  $1514
0014AE  ble.b  $14a2
0014B0  moveq  #$7c, d0
0014B2  ; data: 0x71, 0x03
0014B4  ; data: 0x71, 0x88
0014B6  moveq  #$b, d1
0014B8  moveq  #$8c, d1
0014BA  ; data: 0x73, 0x0a
0014BC  ; data: 0x73, 0x87
0014BE  moveq  #$1, d2
0014C0  moveq  #$78, d2
0014C2  moveq  #$ee, d2
0014C4  ; data: 0x75, 0x61
0014C6  ; data: 0x75, 0xd2
0014C8  moveq  #$40, d3
0014CA  moveq  #$ad, d3
0014CC  ; data: 0x77, 0x17
0014CE  ; data: 0x77, 0x7e
0014D0  ; data: 0x77, 0xe4
0014D2  moveq  #$47, d4
0014D4  moveq  #$a7, d4
0014D6  ; data: 0x79, 0x05
0014D8  ; data: 0x79, 0x61
0014DA  ; data: 0x79, 0xbb
0014DC  moveq  #$12, d5
0014DE  moveq  #$67, d5
0014E0  moveq  #$b9, d5
0014E2  ; data: 0x7b, 0x09
0014E4  ; data: 0x7b, 0x57
0014E6  ; data: 0x7b, 0xa2
0014E8  ; data: 0x7b, 0xeb
0014EA  moveq  #$31, d6
0014EC  moveq  #$75, d6
0014EE  moveq  #$b7, d6
0014F0  moveq  #$f6, d6
0014F2  ; data: 0x7d, 0x33
0014F4  ; data: 0x7d, 0x6d
0014F6  ; data: 0x7d, 0xa5
0014F8  ; data: 0x7d, 0xda
0014FA  moveq  #$d, d7
0014FC  moveq  #$3d, d7
0014FE  moveq  #$6b, d7
001500  moveq  #$97, d7
001502  moveq  #$c0, d7
001504  moveq  #$e6, d7
001506  ; data: 0x7f, 0x0b
001508  ; data: 0x7f, 0x2c
00150A  ; data: 0x7f, 0x4b
00150C  ; data: 0x7f, 0x68
00150E  ; data: 0x7f, 0x82
001510  ; data: 0x7f, 0x9a
001512  ; data: 0x7f, 0xaf
001514  ; data: 0x7f, 0xc2
001516  ; data: 0x7f, 0xd2
001518  ; data: 0x7f, 0xe0
00151A  ; data: 0x7f, 0xeb
00151C  ; data: 0x7f, 0xf4
00151E  ; data: 0x7f, 0xfa
001520  ; data: 0x7f, 0xfe
001522  ; data: 0x7f, 0xff
001524  ; data: 0x7f, 0xfe
001526  ; data: 0x7f, 0xfa
001528  ; data: 0x7f, 0xf4
00152A  ; data: 0x7f, 0xeb
00152C  ; data: 0x7f, 0xe0
00152E  ; data: 0x7f, 0xd2
001530  ; data: 0x7f, 0xc2
001532  ; data: 0x7f, 0xaf
001534  ; data: 0x7f, 0x9a
001536  ; data: 0x7f, 0x82
001538  ; data: 0x7f, 0x68
00153A  ; data: 0x7f, 0x4c
00153C  ; data: 0x7f, 0x2d
00153E  ; data: 0x7f, 0x0b
001540  moveq  #$e7, d7
001542  moveq  #$c0, d7
001544  moveq  #$97, d7
001546  moveq  #$6c, d7
001548  moveq  #$3e, d7
00154A  moveq  #$d, d7
00154C  ; data: 0x7d, 0xdb
00154E  ; data: 0x7d, 0xa5
001550  ; data: 0x7d, 0x6e
001552  ; data: 0x7d, 0x33
001554  moveq  #$f7, d6
001556  moveq  #$b8, d6
001558  moveq  #$76, d6
00155A  moveq  #$32, d6
00155C  ; data: 0x7b, 0xec
00155E  ; data: 0x7b, 0xa3
001560  ; data: 0x7b, 0x58
001562  ; data: 0x7b, 0x0a
001564  moveq  #$ba, d5
001566  moveq  #$68, d5
001568  moveq  #$13, d5
00156A  ; data: 0x79, 0xbc
00156C  ; data: 0x79, 0x62
00156E  ; data: 0x79, 0x06
001570  moveq  #$a8, d4
001572  moveq  #$48, d4
001574  ; data: 0x77, 0xe5
001576  ; data: 0x77, 0x7f
001578  ; data: 0x77, 0x18
00157A  moveq  #$ae, d3
00157C  moveq  #$41, d3
00157E  ; data: 0x75, 0xd3
001580  ; data: 0x75, 0x62
001582  moveq  #$ef, d2
001584  moveq  #$7a, d2
001586  moveq  #$2, d2
001588  ; data: 0x73, 0x88
00158A  ; data: 0x73, 0x0c
00158C  moveq  #$8d, d1
00158E  moveq  #$d, d1
001590  ; data: 0x71, 0x8a
001592  ; data: 0x71, 0x04
001594  moveq  #$7d, d0
001596  ble.b  $158c
001598  ble.b  $1602
00159A  bgt.b  $1576
00159C  bgt.b  $15e8
00159E  blt.b  $1558
0015A0  blt.b  $15c6
0015A2  bge.b  $1531
0015A4  bmi.b  $159b
0015A6  bmi.b  $1602
0015A8  bpl.b  $1567
0015AA  bpl.b  $15ca
0015AC  bvs.b  $162b
0015AE  bvc.b  $158a
0015B0  bvc.b  $15e7
0015B2  beq.b  $1542
0015B4  bne.b  $159b
0015B6  bne.b  $15f2
0015B8  bcs.b  $1547
0015BA  bcc.b  $159a
0015BC  bcc.b  $15eb
0015BE  bls.b  $163a
0015C0  bhi.b  $1587
0015C2  bhi.b  $15d2
0015C4  bsr.b  $161c
0015C6  bra.b  $1563
0015C8  sle.b  (a7)+
0015CA  subq.b #$7, -(a0)
0015CC  addq.w #$7, -(a0)
0015CE  subq.l #$6, (a6)+
0015D0  sge.b  (a2)+
0015D2  addq.b #$6, (a4)
0015D4  subq.w #$5, a5
0015D6  addq.l #$5, d3
0015D8  subq.l #$4, $58ec.w
0015DC  addq.b #$4, (a5)+
0015DE  subq.w #$3, a5
0015E0  ; data: 0x56, 0x7b
0015E2  subq.l #$2, -(a7)
0015E4  scc.b  (a2)
0015E6  dc.w   $53fb
0015E8  subq.b #$1, -(a2)
0015EA  addq.w #$1, a0
0015EC  subq.w #$8, $508f(a4)
0015F0  chk.w  -$31(a0, d4.l), d7
0015F4  lea.l  $4d0a(a5), a6
0015F8  ; data: 0x4c, 0x25
0015FA  ; data: 0x4b, 0x3e
0015FC  tst.w  (a6)
0015FE  ; data: 0x49, 0x6c
001600  ext.w  d1
001602  chk.w  (a5), d3
001604  not.l  -(a7)
001606  chk.w  $44c8.w, d2
00160A  lea.l  (a6), a1
00160C  dc.w   $42e3
00160E  lea.l  $40f9(a6), a0
001612  negx.b d2
001614  move.w a1, -(a7)
001616  move.w (a0), d7
001618  move.w (a5), -(a6)
00161A  move.w (a1)+, d6
00161C  move.w (a4)+, -(a5)
00161E  move.w (a6)+, d5
001620  move.w (a7)+, -(a4)
001622  move.w (a6)+, d4
001624  move.w (a5)+, -(a3)
001626  move.w (a2)+, d3
001628  move.w (a7), -(a2)
00162A  move.w (a2), d2
00162C  move.w a4, -(a1)
00162E  move.w d6, d1
001630  ; data: 0x30, 0xfe
001632  ; data: 0x2f, 0xf5
001634  move.l $2de1(a4), (a7)+
001638  move.l (a6), (a6)+
00163A  ; data: 0x2b, 0xca
00163C  move.l #$29ae28a0, (a5)
001642  move.l (a0), -$80(a3, d2.w)
001646  move.l $245d(a7), $234a(a2)
00164C  move.l ([$200f, a7, d2.w], $1efa1de4), d1
001656  ; data: 0x1c, 0xce
001658  move.b -$61(a7, d1.l), ([], d1.l, $186f1756)
001662  ; data: 0x16, 0x3d
001664  move.b -(a3), -(a2)
001666  ; data: 0x14, 0x09
001668  move.b $11d3(a6), (a1)+
00166C  move.b $f9c.w, (a0)
001670  ; data: 0x0e, 0x80
001672  bchg.b d6, -(a4)
001674  ; data: 0x0c, 0x48
001676  btst.l d5, $a0e(a3)
00167A  ; data: 0x08, 0xf1
00167C  bset.b d3, (a3)
00167E  addi.l #$598047b, ([a6])
001686  ; data: 0x02, 0x3f
001688  btst.l d0, -(a1)
00168A  ori.b  #$e5, d3
00168E  ; data: 0xfd, 0xc7
001690  dc.w   $fca9
001692  ; data: 0xfb, 0x8c
001694  dc.w   $fa6e
001696  dc.w   $f950
001698  dc.w   $f833
00169A  dc.w   $f715
00169C  ; data: 0xf5, 0xf8
00169E  dc.w   $f4db
0016A0  ; data: 0xf3, 0xbf
0016A2  dc.w   $f2a2
0016A4  ; data: 0xf1, 0x86
0016A6  dc.w   $f06a
0016A8  lsl.w  #$7, d6
0016AA  roxr.l #$7, d3
0016AC  rol.b  #$6, d0
0016AE  ; data: 0xeb, 0xfd
0016B0  ; data: 0xea, 0xe3
0016B2  ; data: 0xe9, 0xc9
0016B4  roxr.l d4, d0
0016B6  roxl.l #$3, d7
0016B8  ror.w  d3, d6
0016BA  asl.w  d2, d7
0016BC  lsr.w  #$2, d7
0016BE  rol.b  d1, d0
0016C0  asr.b  d1, d2
0016C2  lsl.b  #$8, d4
0016C4  adda.l -$1e(a7, a5.l), a7
0016C8  adda.l a7, a6
0016CA  add.l  ([$f163, a5.l * 2]), d6
0016D0  addx.l d6, d4
0016D2  add.w  ([$d657, a6]), d4
0016D8  addx.w -(a1), -(a2)
0016DA  add.b  #$30, d2
0016DE  add.b  -(a5), d1
0016E0  add.b  d0, (a2)+
0016E2  add.b  (a0), d0
0016E4  abcd.b -(a0), -(a7)
0016E6  and.b  d0, d7
0016E8  mulu.w $cbf4caef.l, d6
0016EE  muls.w -$3717(a3), d4
0016F2  muls.w -(a7), d3
0016F4  mulu.w -(a7), d3
0016F6  muls.w -(a7), d2
0016F8  mulu.w -$3c14(a1), d2
0016FC  mulu.w ([$c0fcc004]), d1
001704  cmpm.b (a5)+, (a7)+
001706  cmp.b  (a7), d7
001708  eor.b  d6, -(a2)
00170A  cmp.b  -$44c3(a7), d6
00170E  cmp.w  a5, d5
001710  eor.w  d4, (a6)+
001712  cmp.w  (a3.w * 8), d4
001716  cmp.l  (a1)+, d3
001718  eor.l  d2, -$4b39(a7)
00171C  cmpa.l -(a0), a1
00171E  cmpa.w $1738(pc, a3.w), a1
001722  eor.b  d0, $55(a6, a3.w)
001726  ; data: 0xaf, 0x76
001728  ; data: 0xae, 0x98
00172A  ; data: 0xad, 0xbd
00172C  ; data: 0xac, 0xe2
00172E  ; data: 0xac, 0x0a
001730  ; data: 0xab, 0x33
001732  ; data: 0xaa, 0x5d
001734  ; data: 0xa9, 0x8a
001736  ; data: 0xa8, 0xb8
001738  ; data: 0xa7, 0xe7
00173A  ; data: 0xa7, 0x19
00173C  ; data: 0xa6, 0x4c
00173E  ; data: 0xa5, 0x81
001740  ; data: 0xa4, 0xb8
001742  ; data: 0xa3, 0xf0
001744  ; data: 0xa3, 0x2a
001746  ; data: 0xa2, 0x66
001748  ; data: 0xa1, 0xa4
00174A  ; data: 0xa0, 0xe4
00174C  ; data: 0xa0, 0x26
00174E  sub.w  d7, -$6152(a1)
001752  suba.l ([$9c8a9bd7, a6], a1.l * 4, $9b269a77), a6
00175E  suba.l a1, a4
001760  sub.b  d4, (a6)+
001762  sub.w  ([]), d4
001766  sub.b  d3, -$697a(a1)
00176A  suba.l -(a5), a2
00176C  subx.w d6, d2
00176E  sub.l  -$6bf1(a1), d2
001772  sub.w  d1, -$20(a6, a1.w)
001776  sub.w  a3, d1
001778  sub.l  d0, $9129909b.l
00177E  ; data: 0x90, 0x0f
001780  dc.w   $8f86
001782  ; data: 0x8e, 0xfe
001784  or.w   $8df68d76.l, d7
00178A  divu.w $7b(a7, a0.l), d6
00178E  or.b   d1, d6
001790  dc.w   $8b89
001792  or.b   d5, (a4)
001794  or.l   -(a0), d5
001796  or.b   -$763f(a7), d5
00179A  or.w   d4, (a5)
00179C  divu.w -$777d(a3), d4
0017A0  or.b   (a6)+, d4
0017A2  ; data: 0x87, 0xbb
0017A4  or.w   d3, (a2)+
0017A6  divu.w #$86a0, d3
0017AA  or.w   d6, d3
0017AC  divs.w -$7a66(a7), d2
0017B0  dc.w   $8548
0017B2  divu.w $84aa.w, d2
0017B6  or.w   (a7)+, d2
0017B8  or.b   (a6), d2
0017BA  ; data: 0x83, 0xcf
0017BC  dc.w   $838b
0017BE  dc.w   $834a
0017C0  sbcd   -(a3), -(a1), #$82ce
0017C4  or.l   (a4), d1
0017C6  or.w   (a4)+, d1
0017C8  or.b   -(a6), d1
0017CA  divs.w ([], $8195816a), d0
0017D2  dc.w   $8141
0017D4  or.b   d0, (a2)+
0017D6  divu.w -$2c(a6, a0.w), d0
0017DA  or.l   -$68(a5, a0.w), d0
0017DE  ; data: 0x80, 0x7e
0017E0  or.w   -(a6), d0
0017E2  or.w   (a1), d0
0017E4  ; data: 0x80, 0x3e
0017E6  or.b   -$7fe0(a6), d0
0017EA  or.b   (a5), d0
0017EC  ; data: 0x80, 0x0c
0017EE  or.b   d6, d0
0017F0  or.b   d2, d0
0017F2  or.b   d1, d0
0017F4  or.b   d2, d0
0017F6  or.b   d6, d0
0017F8  ; data: 0x80, 0x0c
0017FA  or.b   (a5), d0
0017FC  or.b   -(a0), d0
0017FE  or.b   -$7fc2(a6), d0
001802  or.w   (a0), d0
001804  or.w   -(a6), d0
001806  ; data: 0x80, 0x7d
001808  or.l   (a7), d0
00180A  or.l   -$2d(a4, a0.w), d0
00180E  divu.w ([a5, a0.w]), d0
001812  ; data: 0x81, 0x3f
001814  or.w   d0, -$7e6c(a0)
001818  divs.w d2, d0
00181A  divs.w $25(a2, a0.w), d0
00181E  or.w   (a2)+, d1
001820  or.l   (a2), d1
001822  ; data: 0x82, 0xcc
001824  sbcd   -(a1), -(a1), #$8348
001828  dc.w   $8389
00182A  ; data: 0x83, 0xcd
00182C  or.b   (a4), d2
00182E  or.w   (a4)+, d2
001830  or.l   -(a7), d2
001832  divu.w ([a5]), d2
001836  or.l   d2, (a7)
001838  divs.w -$79bd(a4), d2
00183C  or.l   (a5)+, d3
00183E  divu.w $875787b7.l, d3
001844  or.b   (a2)+, d4
001846  or.l   d0, d4
001848  divu.w -(a7), d4
00184A  or.w   d4, (a1)
00184C  ; data: 0x89, 0xbd
00184E  or.b   -$7563(a4), d5
001852  or.b   d5, (a0)
001854  dc.w   $8b85
001856  ; data: 0x8b, 0xfd
001858  or.w   -$d(a7, a0.l), d6
00185C  or.w   d6, ([$8e758efa], $8f81)
001866  ; data: 0x90, 0x0b
001868  sub.l  (a7), d0
00186A  sub.b  d0, -(a4)
00186C  sub.l  d0, $47(a4, a1.w)
001870  suba.w (a3)+, a1
001872  sub.w  d1, $a(a1, a1.w)
001876  sub.l  -(a4), d2
001878  subx.w d1, d2
00187A  suba.l -(a0), a2
00187C  sub.l  d1, d3
00187E  sub.b  d3, -(a4)
001880  suba.l a1, a3
001882  sub.w  ([a0, a1.l]), d4
001886  suba.l d4, a4
001888  sub.w  $9bd1(a1, a1.l * 2), d5
00188E  sub.l  d4, d6
001890  sub.b  d6, $9df09ea8.l
001896  sub.w  d7, -(a3)
001898  ; data: 0xa0, 0x1f
00189A  ; data: 0xa0, 0xde
00189C  ; data: 0xa1, 0x9e
00189E  ; data: 0xa2, 0x60
0018A0  ; data: 0xa3, 0x24
0018A2  ; data: 0xa3, 0xea
0018A4  ; data: 0xa4, 0xb1
0018A6  ; data: 0xa5, 0x7a
0018A8  ; data: 0xa6, 0x46
0018AA  ; data: 0xa7, 0x12
0018AC  ; data: 0xa7, 0xe1
0018AE  ; data: 0xa8, 0xb1
0018B0  ; data: 0xa9, 0x83
0018B2  ; data: 0xaa, 0x57
0018B4  ; data: 0xab, 0x2c
0018B6  ; data: 0xac, 0x03
0018B8  ; data: 0xac, 0xdb
0018BA  ; data: 0xad, 0xb6
0018BC  ; data: 0xae, 0x91
0018BE  ; data: 0xaf, 0x6f
0018C0  cmp.w  a6, d0
0018C2  eor.b  d0, -$4df0(a6)
0018C6  cmpa.w ([]), a1
0018CA  cmpa.w d0, a2
0018CC  eor.l  d2, -$496f(a0)
0018D0  ; data: 0xb7, 0x7c
0018D2  cmp.w  -$46aa(a0), d4
0018D6  cmp.w  d5, d5
0018D8  eor.b  d5, $27(a6, a3.l)
0018DC  eor.b  d6, (a3)+
0018DE  ; data: 0xbe, 0x0f
0018E0  eor.b  d7, d5
0018E2  cmpa.l #$c0f4c1ed, a7
0018E8  mulu.w -$3c1c(a0), d1
0018EC  mulu.w -(a1), d2
0018EE  muls.w (a7)+, d2
0018F0  mulu.w (a6)+, d3
0018F2  muls.w (a7)+, d3
0018F4  mulu.w -(a0), d4
0018F6  muls.w -(a3), d4
0018F8  mulu.w -(a7), d5
0018FA  muls.w -$330f(a3), d5
0018FE  muls.w $ceff.w, d6
001902  ; data: 0xd0, 0x08
001904  add.b  d0, (a2)
001906  add.b  (a4)+, d1
001908  add.b  d1, -(a7)
00190A  add.b  ([a4]), d2
00190E  add.w  a7, d3
001910  add.w  d3, (a5)+
001912  add.w  -$2683(a5), d4
001916  add.l  a6, d5
001918  add.l  d5, -(a0)
00191A  add.l  ([]), d6
00191E  adda.w (a2)+, a7
001920  adda.l -$1efd(a6), a7
001924  ror.b  #$1, d1
001926  lsl.b  d1, d7
001928  asr.w  #$2, d6
00192A  rol.w  #$2, d6
00192C  roxr.w d3, d6
00192E  lsl.l  #$3, d6
001930  asr.l  d4, d7
001932  ; data: 0xe9, 0xc0
001934  ; data: 0xea, 0xda
001936  ; data: 0xeb, 0xf4
001938  lsl.b  #$6, d7
00193A  lsr.b  d7, d2
00193C  asl.w  #$7, d5
00193E  dc.w   $f061
001940  ; data: 0xf1, 0x7d
001942  dc.w   $f299
001944  ; data: 0xf3, 0xb5
001946  dc.w   $f4d2
001948  ; data: 0xf5, 0xef
00194A  ; data: 0xf7, 0x0c
00194C  dc.w   $f82a
00194E  ; data: 0xf9, 0x47
001950  dc.w   $fa65
001952  ; data: 0xfb, 0x82
001954  dc.w   $fca0
001956  ; data: 0xfd, 0xbe
001958  dc.w   $fedc
00195A  ; data: 0xff, 0xff
00195C  ori.b  #$ac, d0
001960  bchg.b d0, (a7)
001962  andi.b #$ae, d3
001966  bchg.b d1, (a2)+
001968  subi.b #$b1, d5
00196C  bchg.b d2, (a4)+
00196E  addi.b #$b3, d7
001972  bchg.b d3, (a6)+
001974  ; data: 0x08, 0x09
001976  ; data: 0x08, 0xb5
001978  bchg.b d4, -(a0)
00197A  ; data: 0x0a, 0x0b
00197C  eori.l #$b610c0c, -$4a(a6, d0.l)
001984  bchg.b d6, -(a1)
001986  ; data: 0x0e, 0x0c
001988  ; data: 0x0e, 0xb6
00198A  bchg.b d7, -(a0)
00198C  ; data: 0x10, 0x0b
00198E  move.b ([a5]), (a0)
001992  ; data: 0x12, 0x09
001994  move.b (a3, invalid.w), (a1)
001998  move.b d6, d2
00199A  move.b $1558(a7), (a2)
00199E  move.b d1, d3
0019A0  move.b $1753(a2), (a3)
0019A4  ; data: 0x17, 0xfc
0019A6  move.b -(a4), (a4)
0019A8  ; data: 0x19, 0x4c
0019AA  ; data: 0x19, 0xf5
0019AC  move.b (a4)+, (a5)
0019AE  move.b d4, $1bec(a5)
0019B2  move.b (a3), (a6)
0019B4  move.b $3797(pc), -(a6)
0019B8  ; data: 0x1e, 0x88
0019BA  move.b $1fd5(a6), -(a7)
0019BE  movea.l $21c6(a16, d2.w), a0
0019C4  movea.l $2311(a3), a1
0019C8  move.l $5a(a5, d2.w), -$2(a1, d2.w)
0019CE  move.l -(a3), $46(a2, d2.w)
0019D2  move.l $278d(a2), (a3)+
0019D6  move.l -$2d(a0, d2.l), d4
0019DA  move.l $18(a6, d2.l), $2aba(a4)
0019E0  move.l (a3)+, $2bfc(a5)
0019E4  move.l (a5)+, (a6)
0019E6  ; data: 0x2d, 0x3e
0019E8  ; data: 0x2d, 0xde
0019EA  ; data: 0x2e, 0x7e
0019EC  move.l (a6)+, -(a7)
0019EE  ; data: 0x2f, 0xbd
0019F0  movea.w (a4)+, a0
0019F2  move.w ([$19f4, d3.w]), (a0)+
0019F6  move.w -$2b(a7, d3.w), d1
0019FA  move.w $f(a2, d3.w), $34ac(a1)
001A00  move.w a0, $35e4(a2)
001A04  ; data: 0x36, 0x7f
001A06  move.w (a2)+, -(a3)
001A08  move.w $4f(a5, d3.l), -$17(a3, d3.l)
001A0E  move.w d2, $1b(a4, d3.l)
001A12  move.w (a4, invalid.w), (a5)
001A16  ; data: 0x3b, 0xe4
001A18  movea.w #$3d13, a6
001A1C  move.w $3e3f(a1), -$2b(a6, d3.l)
001A22  move.w $3fff(a2), $4093(a7)
001A28  dc.w   $4127
001A2A  chk.w  $1a7a(pc, d4.w), d0
001A2E  dc.w   $42e0
001A30  ; data: 0x43, 0x72
001A32  neg.b  d4
001A34  neg.l  (a5)
001A36  dc.w   $4526
001A38  chk.w  $45(a6, d4.w), d2
001A3C  move.w (a4), sr
001A3E  ; data: 0x47, 0x63
001A40  lea.l  $7f(a1, d4.l), a3
001A44  ; data: 0x49, 0x0c
001A46  chk.w  (a1)+, d4
001A48  tst.b  -(a5)
001A4A  tst.l  ([$4bc64c50, a0, d4.l * 2], $4cd94d62)
001A56  lea.l  $4e73(a3), a6
001A5A  jmp    $69dd(pc)
001A5E  addq.b #$8, d7
001A60  addq.l #$8, a4
001A62  subq.b #$8, (a1)
001A64  subq.l #$8, (a6)
001A66  addq.b #$1, (a2)+
001A68  addq.l #$1, (a5)+
001A6A  subq.b #$1, -(a0)
001A6C  subq.l #$1, -(a2)
001A6E  addq.b #$2, -(a4)
001A70  addq.l #$2, -(a5)
001A72  subq.b #$2, -(a5)
001A74  subq.l #$2, -(a5)
001A76  addq.b #$3, -(a4)
001A78  addq.l #$3, -(a3)
001A7A  subq.b #$3, -(a1)
001A7C  subq.l #$3, (a6)+
001A7E  addq.b #$4, (a3)+
001A80  addq.l #$4, (a7)
001A82  subq.b #$4, (a2)
001A84  subq.l #$4, a5
001A86  ; data: 0x5a, 0x08
001A88  addq.l #$5, d1
001A8A  dc.w   $5afa
001A8C  subq.w #$5, ([$5c61], $5cd8)
001A94  subq.w #$6, a6
001A96  slt.b  d3
001A98  addq.b #$7, -$55(a7, d5.l)
001A9C  subq.b #$7, (a6)+
001A9E  subq.l #$7, (a1)
001AA0  bra.b  $1aa4
001AA2  bra.b  $1b17
001AA4  bra.b  $1a8a
001AA6  bsr.b  $1afc
001AA8  bsr.b  $1a6d
001AAA  bhi.b  $1add
001AAC  bhi.b  $1a4d
001AAE  bls.b  $1abc
001AB0  bls.b  $1b2a
001AB2  bls.b  $1a98
001AB4  bcc.b  $1b05
001AB6  bcc.b  $1a71
001AB8  bcs.b  $1adc
001ABA  bcs.b  $1a47
001ABC  bcs.b  $1ab1
001ABE  bne.b  $1b1b
001AC0  bne.b  $1a83
001AC2  beq.b  $1aeb
001AC4  beq.b  $1a52
001AC6  beq.b  $1ab9
001AC8  bvc.b  $1b1f
001ACA  bvc.b  $1a84
001ACC  bvs.b  $1ae8
001ACE  bvs.b  $1b4c
001AD0  bvs.b  $1aae
001AD2  bpl.b  $1b10
001AD4  bpl.b  $1a72
001AD6  bpl.b  $1ad2
001AD8  bmi.b  $1b32
001ADA  bmi.b  $1a91
001ADC  bge.b  $1af0
001ADE  bge.b  $1b4d
001AE0  bge.b  $1aaa
001AE2  blt.b  $1b06
001AE4  blt.b  $1b61
001AE6  blt.b  $1abc
001AE8  bgt.b  $1b15
001AEA  bgt.b  $1a6e
001AEC  bgt.b  $1ac7
001AEE  ble.b  $1b1e
001AF0  ble.b  $1a75
001AF2  ble.b  $1aca
001AF4  moveq  #$29, d0
001AF6  moveq  #$7c, d0
001AF8  moveq  #$cd, d0
001AFA  ; data: 0x71, 0x1e
001AFC  ; data: 0x71, 0x6e
001AFE  ; data: 0x71, 0xbd
001B00  moveq  #$b, d1
001B02  moveq  #$59, d1
001B04  moveq  #$a5, d1
001B06  moveq  #$f1, d1
001B08  ; data: 0x73, 0x3c
001B0A  ; data: 0x73, 0x87
001B0C  ; data: 0x73, 0xd0
001B0E  moveq  #$19, d2
001B10  moveq  #$60, d2
001B12  moveq  #$a7, d2
001B14  moveq  #$ee, d2
001B16  ; data: 0x75, 0x33
001B18  ; data: 0x75, 0x78
001B1A  ; data: 0x75, 0xbb
001B1C  ; data: 0x75, 0xfe
001B1E  moveq  #$40, d3
001B20  moveq  #$82, d3
001B22  moveq  #$c2, d3
001B24  ; data: 0x77, 0x02
001B26  ; data: 0x77, 0x40
001B28  ; data: 0x77, 0x7e
001B2A  ; data: 0x77, 0xbb
001B2C  ; data: 0x77, 0xf8
001B2E  moveq  #$33, d4
001B30  moveq  #$6d, d4
001B32  moveq  #$a7, d4
001B34  moveq  #$e0, d4
001B36  ; data: 0x79, 0x18
001B38  ; data: 0x79, 0x4f
001B3A  ; data: 0x79, 0x85
001B3C  ; data: 0x79, 0xbb
001B3E  ; data: 0x79, 0xef
001B40  moveq  #$23, d5
001B42  moveq  #$56, d5
001B44  moveq  #$88, d5
001B46  moveq  #$b9, d5
001B48  moveq  #$ea, d5
001B4A  ; data: 0x7b, 0x19
001B4C  ; data: 0x7b, 0x48
001B4E  ; data: 0x7b, 0x75
001B50  ; data: 0x7b, 0xa2
001B52  ; data: 0x7b, 0xce
001B54  ; data: 0x7b, 0xf9
001B56  moveq  #$23, d6
001B58  moveq  #$4d, d6
001B5A  moveq  #$75, d6
001B5C  moveq  #$9d, d6
001B5E  moveq  #$c4, d6
001B60  moveq  #$ea, d6
001B62  ; data: 0x7d, 0x0f
001B64  ; data: 0x7d, 0x33
001B66  ; data: 0x7d, 0x56
001B68  ; data: 0x7d, 0x78
001B6A  ; data: 0x7d, 0x9a
001B6C  ; data: 0x7d, 0xba
001B6E  ; data: 0x7d, 0xda
001B70  ; data: 0x7d, 0xf9
001B72  moveq  #$17, d7
001B74  moveq  #$34, d7
001B76  moveq  #$50, d7
001B78  moveq  #$6b, d7
001B7A  moveq  #$86, d7
001B7C  moveq  #$9f, d7
001B7E  moveq  #$b8, d7
001B80  moveq  #$d0, d7
001B82  moveq  #$e6, d7
001B84  moveq  #$fc, d7
001B86  ; data: 0x7f, 0x12
001B88  ; data: 0x7f, 0x26
001B8A  ; data: 0x7f, 0x39
001B8C  ; data: 0x7f, 0x4b
001B8E  ; data: 0x7f, 0x5d
001B90  ; data: 0x7f, 0x6d
001B92  ; data: 0x7f, 0x7d
001B94  ; data: 0x7f, 0x8c
001B96  ; data: 0x7f, 0x9a
001B98  ; data: 0x7f, 0xa7
001B9A  ; data: 0x7f, 0xb3
001B9C  ; data: 0x7f, 0xbe
001B9E  ; data: 0x7f, 0xc9
001BA0  ; data: 0x7f, 0xd2
001BA2  ; data: 0x7f, 0xdb
001BA4  ; data: 0x7f, 0xe2
001BA6  ; data: 0x7f, 0xe9
001BA8  ; data: 0x7f, 0xef
001BAA  ; data: 0x7f, 0xf4
001BAC  ; data: 0x7f, 0xf8
001BAE  ; data: 0x7f, 0xfb
001BB0  ; data: 0x7f, 0xfd
001BB2  ; data: 0x7f, 0xff
001BB4  ; data: 0x7f, 0xff
001BB6  ; data: 0x7f, 0xff
001BB8  ; data: 0x7f, 0xfd
001BBA  ; data: 0x7f, 0xfb
001BBC  ; data: 0x7f, 0xf8
001BBE  ; data: 0x7f, 0xf4
001BC0  ; data: 0x7f, 0xef
001BC2  ; data: 0x7f, 0xe9
001BC4  ; data: 0x7f, 0xe2
001BC6  ; data: 0x7f, 0xdb
001BC8  ; data: 0x7f, 0xd2
001BCA  ; data: 0x7f, 0xc9
001BCC  ; data: 0x7f, 0xbe
001BCE  ; data: 0x7f, 0xb3
001BD0  ; data: 0x7f, 0xa7
001BD2  ; data: 0x7f, 0x9a
001BD4  ; data: 0x7f, 0x8c
001BD6  ; data: 0x7f, 0x7d
001BD8  ; data: 0x7f, 0x6e
001BDA  ; data: 0x7f, 0x5d
001BDC  ; data: 0x7f, 0x4c
001BDE  ; data: 0x7f, 0x39
001BE0  ; data: 0x7f, 0x26
001BE2  ; data: 0x7f, 0x12
001BE4  moveq  #$fd, d7
001BE6  moveq  #$e7, d7
001BE8  moveq  #$d0, d7
001BEA  moveq  #$b8, d7
001BEC  moveq  #$a0, d7
001BEE  moveq  #$86, d7
001BF0  moveq  #$6c, d7
001BF2  moveq  #$51, d7
001BF4  moveq  #$34, d7
001BF6  moveq  #$17, d7
001BF8  ; data: 0x7d, 0xf9
001BFA  ; data: 0x7d, 0xdb
001BFC  ; data: 0x7d, 0xbb
001BFE  ; data: 0x7d, 0x9a
001C00  ; data: 0x7d, 0x79
001C02  ; data: 0x7d, 0x57
001C04  ; data: 0x7d, 0x33
001C06  ; data: 0x7d, 0x0f
001C08  moveq  #$ea, d6
001C0A  moveq  #$c4, d6
001C0C  moveq  #$9e, d6
001C0E  moveq  #$76, d6
001C10  moveq  #$4e, d6
001C12  moveq  #$24, d6
001C14  ; data: 0x7b, 0xfa
001C16  ; data: 0x7b, 0xcf
001C18  ; data: 0x7b, 0xa3
001C1A  ; data: 0x7b, 0x76
001C1C  ; data: 0x7b, 0x48
001C1E  ; data: 0x7b, 0x1a
001C20  moveq  #$ea, d5
001C22  moveq  #$ba, d5
001C24  moveq  #$89, d5
001C26  moveq  #$57, d5
001C28  moveq  #$24, d5
001C2A  ; data: 0x79, 0xf0
001C2C  ; data: 0x79, 0xbc
001C2E  ; data: 0x79, 0x86
001C30  ; data: 0x79, 0x50
001C32  ; data: 0x79, 0x19
001C34  moveq  #$e1, d4
001C36  moveq  #$a8, d4
001C38  moveq  #$6e, d4
001C3A  moveq  #$34, d4
001C3C  ; data: 0x77, 0xf8
001C3E  ; data: 0x77, 0xbc
001C40  ; data: 0x77, 0x7f
001C42  ; data: 0x77, 0x41
001C44  ; data: 0x77, 0x03
001C46  moveq  #$c3, d3
001C48  moveq  #$83, d3
001C4A  moveq  #$41, d3
001C4C  ; data: 0x75, 0xff
001C4E  ; data: 0x75, 0xbc
001C50  ; data: 0x75, 0x79
001C52  ; data: 0x75, 0x34
001C54  moveq  #$ef, d2
001C56  moveq  #$a9, d2
001C58  moveq  #$62, d2
001C5A  moveq  #$1a, d2
001C5C  ; data: 0x73, 0xd1
001C5E  ; data: 0x73, 0x88
001C60  ; data: 0x73, 0x3d
001C62  moveq  #$f2, d1
001C64  moveq  #$a7, d1
001C66  moveq  #$5a, d1
001C68  moveq  #$c, d1
001C6A  ; data: 0x71, 0xbe
001C6C  ; data: 0x71, 0x6f
001C6E  ; data: 0x71, 0x1f
001C70  moveq  #$ce, d0
001C72  moveq  #$7d, d0
001C74  moveq  #$2b, d0
001C76  ble.b  $1c50
001C78  ble.b  $1bfe
001C7A  ble.b  $1cab
001C7C  bgt.b  $1c58
001C7E  bgt.b  $1c04
001C80  bgt.b  $1caf
001C82  blt.b  $1c59
001C84  blt.b  $1d03
001C86  blt.b  $1cab
001C88  bge.b  $1c53
001C8A  bge.b  $1cfb
001C8C  bge.b  $1ca1
001C8E  bmi.b  $1c47
001C90  bmi.b  $1cec
001C92  bpl.b  $1c90
001C94  bpl.b  $1c33
001C96  bpl.b  $1cd6
001C98  bvs.b  $1c78
001C9A  bvs.b  $1d19
001C9C  bvs.b  $1cba
001C9E  bvc.b  $1c59
001CA0  bvc.b  $1cf8
001CA2  beq.b  $1c97
001CA4  beq.b  $1c34
001CA6  beq.b  $1cd1
001CA8  bne.b  $1c6d
001CAA  bne.b  $1d08
001CAC  bcs.b  $1ca3
001CAE  bcs.b  $1c3d
001CB0  bcs.b  $1cd6
001CB2  bcc.b  $1c6f
001CB4  bcc.b  $1d06
001CB6  bls.b  $1c9e
001CB8  bls.b  $1d34
001CBA  bls.b  $1cca
001CBC  bhi.b  $1c5f
001CBE  bhi.b  $1cf3
001CC0  bsr.b  $1c87
001CC2  bsr.b  $1d19
001CC4  bra.b  $1cac
001CC6  bra.b  $1d3d
001CC8  bra.b  $1cce
001CCA  subq.l #$7, (a2)
001CCC  subq.b #$7, -(a0)
001CCE  addq.l #$7, $5e39(a5)
001CD2  slt.b  d5
001CD4  subq.w #$6, a7
001CD6  sge.b  (a2)+
001CD8  addq.w #$6, -(a3)
001CDA  smi.b  $5b74(a4)
001CDE  dc.w   $5afc
001CE0  addq.l #$5, d3
001CE2  ; data: 0x5a, 0x0a
001CE4  subq.l #$4, a7
001CE6  subq.b #$4, (a4)
001CE8  addq.l #$4, (a1)+
001CEA  addq.b #$4, (a5)+
001CEC  subq.l #$3, -(a0)
001CEE  subq.b #$3, -(a3)
001CF0  addq.l #$3, -(a5)
001CF2  addq.b #$3, -(a6)
001CF4  subq.l #$2, -(a7)
001CF6  subq.b #$2, -(a7)
001CF8  addq.l #$2, -(a7)
001CFA  addq.b #$2, -(a6)
001CFC  subq.l #$1, -(a4)
001CFE  subq.b #$1, -(a2)
001D00  addq.l #$1, (a7)+
001D02  addq.b #$1, (a4)+
001D04  subq.l #$8, (a0)+
001D06  subq.b #$8, (a4)
001D08  addq.l #$8, a6
001D0A  ; data: 0x50, 0x09
001D0C  chk.w  d3, d7
001D0E  ; data: 0x4e, 0xfc
001D10  rts    
001D12  lea.l  $4d65(a5), a6
001D16  movem.l (a4)+, d1/d4/d6/a2-a3/a6
001D1A  ; data: 0x4b, 0xc8
001D1C  ; data: 0x4b, 0x3e
001D1E  tst.l  $27(a3, d4.l)
001D22  chk.w  (a3)+, d4
001D24  ; data: 0x49, 0x0e
001D26  ext.w  d1
001D28  lea.l  ([$46d7, a3]), a3
001D2E  ; data: 0x46, 0x48
001D30  chk.w  $4528.w, d2
001D34  neg.l  (a7)
001D36  neg.b  d6
001D38  ; data: 0x43, 0x75
001D3A  dc.w   $42e2
001D3C  clr.w  (a0)
001D3E  ; data: 0x41, 0xbd
001D40  dc.w   $412a
001D42  negx.l (a6)
001D44  negx.b d1
001D46  move.w $3ed7(a5), $3e42(a7)
001D4C  move.w $3d15(a3), $7e(a6, d3.l)
001D52  ; data: 0x3b, 0xe7
001D54  move.w a7, $3ab6(a5)
001D58  move.w (a6)+, d5
001D5A  move.w d5, -$15(a4, d3.l)
001D5E  movea.w (a1), a4
001D60  move.w (a7, d3.w * 8), -$7f(a3, d3.w)
001D66  ; data: 0x35, 0xe6
001D68  move.w a2, $34ae(a2)
001D6C  move.w (a2), d2
001D6E  move.w -$29(a5, d3.w), $323a(a1)
001D74  move.w (a4)+, -$3(a0, d3.w)
001D78  movea.w (a7)+, a0
001D7A  ; data: 0x2f, 0xc0
001D7C  move.l -(a0), -(a7)
001D7E  move.l d1, (a7)
001D80  ; data: 0x2d, 0xe1
001D82  move.l d0, $2ca0(a6)
001D86  ; data: 0x2b, 0xff
001D88  move.l (a6)+, $2abc(a5)
001D8C  move.l (a2)+, d5
001D8E  move.l $28d5.w, $2833(a4)
001D94  move.l (a0), -$14(a3, d2.w)
001D98  movea.l a1, a3
001D9A  move.l -(a5), ([a2, d2.w * 4])
001D9E  movea.l (a4)+, a2
001DA0  move.l $2313.w, $6e(a1, d2.w)
001DA6  move.l a1, $2123.w
001DAA  ; data: 0x20, 0x7d
001DAC  ; data: 0x1f, 0xd7
001DAE  move.b -$76(a1, d1.l), -(a7)
001DB2  ; data: 0x1d, 0xe4
001DB4  ; data: 0x1d, 0x3d
001DB6  move.b (a5), (a6)
001DB8  ; data: 0x1b, 0xee
001DBA  move.b d7, $1a9f(a5)
001DBE  ; data: 0x19, 0xf7
001DC0  ; data: 0x19, 0x4f
001DC2  move.b -(a7), (a4)
001DC4  ; data: 0x17, 0xfe
001DC6  move.b (a6), $16ad(a3)
001DCA  move.b d4, d3
001DCC  move.b (a3)+, $14b2(a2)
001DD0  ; data: 0x14, 0x08
001DD2  move.b (a7)+, $12b5(a1)
001DD6  ; data: 0x12, 0x0b
001DD8  move.b -(a1), $10b7(a0)
001DDC  ; data: 0x10, 0x0d
001DDE  bchg.b d7, -(a3)
001DE0  ; data: 0x0e, 0xb8
001DE2  ; data: 0x0e, 0x0e
001DE4  bchg.b d6, -(a3)
001DE6  cmpi.l #$c0e0b63, $ab80a0d.l
001DF0  bchg.b d4, -(a2)
001DF2  ; data: 0x08, 0xb7
001DF4  ; data: 0x08, 0x0c
001DF6  bchg.b d3, -(a1)
001DF8  addi.l #$60a055f, -$4d(a5, d0.w)
001E00  ; data: 0x04, 0x08
001E02  bchg.b d1, (a4)+
001E04  andi.l #$205015a, -$52(a1, d0.w)
001E0C  ori.b  #$57, d2
001E10  dc.w   $feab
001E12  dc.w   $fe00
001E14  dc.w   $fd54
001E16  dc.w   $fca9
001E18  ; data: 0xfb, 0xfd
001E1A  dc.w   $fb52
001E1C  dc.w   $faa6
001E1E  ; data: 0xf9, 0xfb
001E20  dc.w   $f950
001E22  dc.w   $f8a4
001E24  ; data: 0xf7, 0xf9
001E26  ; data: 0xf7, 0x4e
001E28  dc.w   $f6a3
001E2A  ; data: 0xf5, 0xf8
001E2C  ; data: 0xf5, 0x4d
001E2E  dc.w   $f4a2
001E30  ; data: 0xf3, 0xf7
001E32  ; data: 0xf3, 0x4c
001E34  dc.w   $f2a1
001E36  ; data: 0xf1, 0xf7
001E38  ; data: 0xf1, 0x4c
001E3A  dc.w   $f0a2
001E3C  ; data: 0xef, 0xf8
001E3E  lsl.w  #$7, d6
001E40  asr.l  d7, d4
001E42  ; data: 0xed, 0xfa
001E44  roxl.w #$6, d0
001E46  asr.l  d6, d6
001E48  ; data: 0xeb, 0xfd
001E4A  roxl.w #$5, d3
001E4C  lsr.l  d5, d2
001E4E  asr.b  #$5, d1
001E50  rol.w  #$4, d0
001E52  lsr.l  d4, d7
001E54  asr.b  #$4, d7
001E56  rol.w  #$3, d6
001E58  roxr.l d3, d6
001E5A  lsr.b  #$3, d6
001E5C  asl.w  d2, d6
001E5E  ror.l  d2, d6
001E60  roxr.b #$2, d7
001E62  lsl.w  d1, d7
001E64  ; data: 0xe2, 0xc8
001E66  asr.b  d1, d1
001E68  rol.w  d0, d2
001E6A  asr.w  (a4)
001E6C  lsr.b  d0, d6
001E6E  addx.l -(a0), -(a7)
001E70  adda.w -(a2), a7
001E72  add.b  #$97, d7
001E76  adda.w $4d(a2, a5.l), a6
001E7A  add.l  d5, -$24fc(a0)
001E7E  add.w  -(a0), d5
001E80  ; data: 0xd9, 0xbc
001E82  add.b  d4, (a0)+
001E84  add.w  ([], $d72f), d4
001E8A  add.l  a5, d3
001E8C  adda.l -$2ab7(a3), a2
001E90  add.l  -(a7), d2
001E92  add.b  d6, d2
001E94  add.w  d1, -(a5)
001E96  adda.w d4, a1
001E98  add.b  -(a4), d1
001E9A  addx.l d4, d0
001E9C  adda.w -(a4), a0
001E9E  add.w  d5, d0
001EA0  and.l  d7, -(a6)
001EA2  abcd.b d7, d7
001EA4  and.w  -$3235(a1), d7
001EA8  and.b  d6, -$3370(a5)
001EAC  muls.w ([a3]), d5
001EB0  and.l  $ffffe8d0(pc), d5
001EB4  ; data: 0xc9, 0x83
001EB6  mulu.w -$37b3(a0), d4
001EBA  and.l  d3, ([a3, a4.w * 8])
001EBE  and.l  d0, d3
001EC0  muls.w -(a7), d2
001EC2  exg.l  a2, a6
001EC4  and.l  $1e(a6, a4.w), d2
001EC8  ; data: 0xc3, 0x86
001ECA  mulu.w -$3da7(a7), d1
001ECE  muls.w d3, d0
001ED0  and.b  d0, -$3f68(a5)
001ED4  and.b  d3, d0
001ED6  eor.w  d7, -$4125(a7)
001EDA  cmp.w  d7, d7
001EDC  eor.l  d6, ([$bc90, a4, a3.l * 4], $bbfe)
001EE4  eor.w  d5, -$4524(a5)
001EE8  cmp.w  a4, d5
001EEA  ; data: 0xb9, 0xbd
001EEC  eor.b  d4, -$4761(a5)
001EF0  cmp.b  (a1), d4
001EF2  eor.l  d3, d3
001EF4  cmpa.w $69(a6, a3.w), a3
001EF8  cmpa.l (a5)+, a2
001EFA  eor.w  d2, (a1)
001EFC  cmpa.w d6, a2
001EFE  cmp.b  #$b2, d2
001F02  eor.b  d1, -$4d61(a0)
001F06  cmp.b  (a7), d1
001F08  cmpm.l (a7)+, (a0)+
001F0A  cmpm.b (a0)+, (a0)+
001F0C  cmp.l  d1, d0
001F0E  ; data: 0xaf, 0xfb
001F10  ; data: 0xaf, 0x75
001F12  ; data: 0xae, 0xf0
001F14  ; data: 0xae, 0x6c
001F16  ; data: 0xad, 0xe8
001F18  ; data: 0xad, 0x64
001F1A  ; data: 0xac, 0xe2
001F1C  ; data: 0xac, 0x60
001F1E  ; data: 0xab, 0xde
001F20  ; data: 0xab, 0x5d
001F22  ; data: 0xaa, 0xdd
001F24  ; data: 0xaa, 0x5d
001F26  ; data: 0xa9, 0xde
001F28  ; data: 0xa9, 0x5f
001F2A  ; data: 0xa8, 0xe1
001F2C  ; data: 0xa8, 0x64
001F2E  ; data: 0xa7, 0xe7
001F30  ; data: 0xa7, 0x6b
001F32  ; data: 0xa6, 0xef
001F34  ; data: 0xa6, 0x74
001F36  ; data: 0xa5, 0xfa
001F38  ; data: 0xa5, 0x80
001F3A  ; data: 0xa5, 0x07
001F3C  ; data: 0xa4, 0x8f
001F3E  ; data: 0xa4, 0x17
001F40  ; data: 0xa3, 0xa0
001F42  ; data: 0xa3, 0x2a
001F44  ; data: 0xa2, 0xb4
001F46  ; data: 0xa2, 0x3f
001F48  ; data: 0xa1, 0xca
001F4A  ; data: 0xa1, 0x56
001F4C  ; data: 0xa0, 0xe3
001F4E  ; data: 0xa0, 0x71
001F50  ; data: 0x9f, 0xff
001F52  subx.l -(a6), -(a7)
001F54  sub.b  d7, (a5)+
001F56  sub.l  -$61c1(a6), d7
001F5A  suba.l (a0), a6
001F5C  sub.w  d6, -(a2)
001F5E  suba.w -$77(a5, a1.l), a6
001F62  sub.b  (a6)+, d6
001F64  sub.l  d5, (a3, invalid.w)
001F68  suba.w (a7)+, a5
001F6A  sub.w  $e(a6, a1.l), d5
001F6E  sub.l  d4, -(a7)
001F70  subx.w d0, d4
001F72  suba.w (a2)+, a4
001F74  sub.w  $10(a5, a1.l), d4
001F78  sub.l  d3, -$68b7(a4)
001F7C  suba.w -(a7), a3
001F7E  sub.l  d6, d3
001F80  sub.b  -(a5), d3
001F82  suba.l d5, a2
001F84  sub.w  d2, -(a5)
001F86  subx.b d7, d2
001F88  sub.l  -$6bb4(a1), d2
001F8C  suba.l (a1.w * 2), a1
001F90  sub.b  d1, $92df9286.l
001F96  sub.b  -$6e2a(a5), d1
001F9A  ; data: 0x91, 0x7f
001F9C  sub.b  d0, -$6f2d(a0)
001FA0  ; data: 0x90, 0x7e
001FA2  sub.b  -$7028(a3), d0
001FA6  dc.w   $8f85
001FA8  or.b   d7, -$1d(a4, a0.l)
001FAC  or.l   (a3), d7
001FAE  or.w   d4, d7
001FB0  divs.w $8d5c(a0.l * 4), d6
001FB6  or.b   d6, (a0)
001FB8  divu.w d5, d6
001FBA  or.w   $ffffabed(pc), d6
001FBE  divs.w -$7460(a0), d5
001FC2  or.w   d5, (a1)+
001FC4  or.b   d5, (a3)
001FC6  ; data: 0x8a, 0xce
001FC8  ; data: 0x8a, 0x89
001FCA  or.w   d5, d5
001FCC  or.b   d3, d5
001FCE  divs.w d0, d4
001FD0  ; data: 0x89, 0x7f
001FD2  ; data: 0x89, 0x3f
001FD4  ; data: 0x88, 0xff
001FD6  divu.w d0, d4
001FD8  or.l   d3, d4
001FDA  or.w   d5, d4
001FDC  ; data: 0x88, 0x09
001FDE  ; data: 0x87, 0xce
001FE0  or.l   d3, (a3)
001FE2  or.w   d3, (a2)+
001FE4  or.b   d3, -(a1)
001FE6  divu.w -$794f(a1), d3
001FEA  or.w   $2032(pc, a0.w), d3
001FEE  or.b   (a1), d3
001FF0  divs.w (a5)+, d2
001FF2  or.l   d2, -$7a88(a2)
001FF6  dc.w   $8547
001FF8  or.b   d2, (a7)
001FFA  divu.w -$7b47(a0), d2
001FFE  ; data: 0x84, 0x8b
002000  or.w   (a6)+, d2
002002  or.b   $7(a2, a0.w), d2
002006  divs.w (a5)+, d1
002008  or.l   d1, ([, a0.w * 2], $8363833d)
002010  or.b   d1, (a7)
002012  divu.w -$32(a2, a0.w), d1
002016  or.l   -$7d78(a2), d1
00201A  or.w   -(a7), d1
00201C  or.w   d6, d1
00201E  or.b   -(a6), d1
002020  or.b   d7, d1
002022  divs.w -$7e34(a2), d0
002026  or.l   d0, ([], a0.w)
00202A  ; data: 0x81, 0x7b
00202C  or.w   d0, -(a1)
00202E  dc.w   $8148
002030  or.b   d0, ([a1, a0.w], $8104)
002036  divu.w -$7f25(a7), d0
00203A  divu.w d7, d0
00203C  or.l   -$5d(a5, a0.w), d0
002040  or.l   (a3), d0
002042  or.l   d3, d0
002044  or.w   $66(a4, a0.w), d0
002048  or.w   (a1)+, d0
00204A  ; data: 0x80, 0x4d
00204C  or.w   d2, d0
00204E  or.b   $802e.w, d0
002052  or.b   -(a6), d0
002054  or.b   (a6)+, d0
002056  or.b   (a7), d0
002058  or.b   (a1), d0
00205A  ; data: 0x80, 0x0c
00205C  ; data: 0x80, 0x08
00205E  or.b   d5, d0
002060  or.b   d3, d0
002062  or.b   d1, d0
002064  or.b   d1, d0
002066  or.b   d1, d0
002068  or.b   d3, d0
00206A  or.b   d5, d0
00206C  ; data: 0x80, 0x08
00206E  ; data: 0x80, 0x0c
002070  or.b   (a1), d0
002072  or.b   (a7), d0
002074  or.b   (a6)+, d0
002076  or.b   -(a5), d0
002078  or.b   -$7fc9(a6), d0
00207C  or.w   d1, d0
00207E  ; data: 0x80, 0x4d
002080  or.w   (a1)+, d0
002082  or.w   -(a6), d0
002084  or.w   -$7e(a4, a0.w), d0
002088  or.l   (a2), d0
00208A  or.l   -(a3), d0
00208C  or.l   -$3a(a4, a0.w), d0
002090  divu.w (a2)+, d0
002092  divu.w -$7efd(a6), d0
002096  or.b   d0, (a1)+
002098  or.b   d0, ([a0])
00209C  or.w   d0, -(a0)
00209E  or.w   d0, $819481af.l
0020A4  ; data: 0x81, 0xcb
0020A6  divs.w -$7dfa(a0), d0
0020AA  or.b   -(a5), d1
0020AC  or.w   d5, d1
0020AE  or.w   -(a5), d1
0020B0  or.l   d7, d1
0020B2  or.l   -$7d34(a1), d1
0020B6  divu.w ([a0], a0.w * 2), d1
0020BA  ; data: 0x83, 0x3b
0020BC  or.w   d1, -(a2)
0020BE  dc.w   $8389
0020C0  or.l   d1, ([], $84058430)
0020C8  or.w   (a4)+, d2
0020CA  ; data: 0x84, 0x89
0020CC  or.l   -$1b(a7, a0.w), d2
0020D0  or.b   d2, (a5)
0020D2  dc.w   $8545
0020D4  or.w   d2, $85db(a0.w * 4)
0020DA  ; data: 0x86, 0x0f
0020DC  or.w   d3, d3
0020DE  or.w   $86af86e6.l, d3
0020E4  or.b   d3, (a6)+
0020E6  or.w   d3, (a7)
0020E8  or.l   d3, (a1)
0020EA  ; data: 0x87, 0xcb
0020EC  or.b   d6, d4
0020EE  or.w   d3, d4
0020F0  or.l   d0, d4
0020F2  ; data: 0x88, 0xbe
0020F4  divu.w #$893c, d4
0020F8  ; data: 0x89, 0x7c
0020FA  ; data: 0x89, 0xbd
0020FC  ; data: 0x89, 0xff
0020FE  or.w   d2, d5
002100  or.l   d6, d5
002102  ; data: 0x8a, 0xcb
002104  or.b   d5, (a0)
002106  or.w   d5, (a6)
002108  or.l   d5, (a5)+
00210A  divs.w -(a5), d5
00210C  or.b   -$7389(a5), d6
002110  divu.w d1, d6
002112  sbcd   -(a4), -(a6), #$8d58
002116  or.l   d6, -(a5)
002118  divs.w $40(a2, a0.l), d6
00211C  ; data: 0x8e, 0x8f
00211E  divu.w (a7)+, d7
002120  or.b   d7, ([, a0.l * 8])
002124  divs.w (a4), d7
002126  sub.b  -(a7), d0
002128  sub.w  $ffffb1f9(pc), d0
00212C  sub.b  d0, -(a4)
00212E  ; data: 0x91, 0x7b
002130  suba.l (a1), a0
002132  sub.b  -$6d7e(a1), d1
002136  suba.w (a3)+, a1
002138  sub.b  d1, (a1.w * 2)
00213C  suba.l -$6bb9(a3), a1
002140  sub.l  -(a4), d2
002142  subx.b d2, d2
002144  sub.w  d2, -(a1)
002146  suba.l d0, a2
002148  sub.b  -(a0), d3
00214A  sub.l  d1, d3
00214C  suba.w -(a2), a3
00214E  subx.w d5, d3
002150  sub.l  d3, -$67f5(a0)
002154  sub.w  -$2b(a0, a1.l), d4
002158  ; data: 0x99, 0x3b
00215A  sub.l  d4, -(a2)
00215C  ; data: 0x9a, 0x09
00215E  sub.w  -$26(a1, a1.l), d5
002162  subx.w d3, d5
002164  sub.l  d5, -$63e8(a5)
002168  sub.l  d4, d6
00216A  suba.w ([a0]), a6
00216E  suba.l a3, a6
002170  sub.b  $9ea89f18.l, d7
002176  subx.l -(a0), -(a7)
002178  suba.l $a06ba0de.l, a7
00217E  ; data: 0xa1, 0x51
002180  ; data: 0xa1, 0xc5
002182  ; data: 0xa2, 0x39
002184  ; data: 0xa2, 0xae
002186  ; data: 0xa3, 0x24
002188  ; data: 0xa3, 0x9a
00218A  ; data: 0xa4, 0x11
00218C  ; data: 0xa4, 0x89
00218E  ; data: 0xa5, 0x01
002190  ; data: 0xa5, 0x7a
002192  ; data: 0xa5, 0xf4
002194  ; data: 0xa6, 0x6e
002196  ; data: 0xa6, 0xe9
002198  ; data: 0xa7, 0x64
00219A  ; data: 0xa7, 0xe1
00219C  ; data: 0xa8, 0x5d
00219E  ; data: 0xa8, 0xdb
0021A0  ; data: 0xa9, 0x59
0021A2  ; data: 0xa9, 0xd7
0021A4  ; data: 0xaa, 0x56
0021A6  ; data: 0xaa, 0xd6
0021A8  ; data: 0xab, 0x56
0021AA  ; data: 0xab, 0xd7
0021AC  ; data: 0xac, 0x59
0021AE  ; data: 0xac, 0xdb
0021B0  ; data: 0xad, 0x5e
0021B2  ; data: 0xad, 0xe1
0021B4  ; data: 0xae, 0x65
0021B6  ; data: 0xae, 0xe9
0021B8  ; data: 0xaf, 0x6e
0021BA  ; data: 0xaf, 0xf4
0021BC  cmp.w  $ffffd2bf(pc), d0
0021C0  cmpm.l (a0)+, (a0)+
0021C2  cmp.b  (a0), d1
0021C4  cmp.l  (a0)+, d1
0021C6  eor.b  d1, -(a1)
0021C8  eor.l  d1, -$4bcb(a3)
0021CC  ; data: 0xb4, 0xbf
0021CE  cmpm.w (a2)+, (a2)+
0021D0  cmpa.l (a6), a2
0021D2  cmp.w  -(a2), d3
0021D4  cmpa.w -$4884(a6), a3
0021D8  ; data: 0xb8, 0x09
0021DA  cmp.l  (a7), d4
0021DC  eor.b  d4, -(a6)
0021DE  eor.l  d4, $45(a5, a3.l)
0021E2  cmpa.w (a5), a5
0021E4  eor.w  d5, -(a5)
0021E6  cmpa.l -$78(a6, a3.l), a5
0021EA  eor.b  d6, (a2)+
0021EC  eor.l  d6, -$41c1(a5)
0021F0  cmpa.w (a3), a7
0021F2  eor.w  d7, -(a7)
0021F4  cmpa.l $2186(pc, a4.w), a7
0021F8  and.b  d0, -(a5)
0021FA  ; data: 0xc1, 0xbb
0021FC  and.w  (a1), d1
0021FE  mulu.w -(a7), d1
002200  ; data: 0xc3, 0x7e
002202  and.b  (a6), d2
002204  and.l  -$3aba(a6), d2
002208  muls.w (a6)+, d2
00220A  and.w  ([a7, a4.w * 8]), d3
00220E  and.l  d3, -$37bb(a3)
002212  mulu.w -(a0), d4
002214  ; data: 0xc9, 0x7b
002216  and.b  (a6), d5
002218  and.l  ([a2]), d5
00221C  muls.w -$3379(a3), d5
002220  and.b  d6, -(a5)
002222  muls.w d2, d6
002224  and.w  -(a0), d7
002226  ; data: 0xce, 0xff
002228  and.l  d7, (a5)+
00222A  add.b  #$dc, d0
00222E  ; data: 0xd1, 0x7b
002230  add.b  (a3)+, d1
002232  add.l  #$d35cd3fd, d1
002238  add.l  (a6)+, d2
00223A  addx.w d0, d2
00223C  adda.l -(a2), a2
00223E  add.l  d4, d3
002240  add.b  d3, -(a6)
002242  adda.l a1, a3
002244  add.w  -$26f1(a4), d4
002248  add.l  d4, $57(a3, a5.l)
00224C  adda.w ([$224e], a5.l * 2, $dc44dce9), a5
002254  addx.l -(a6), -(a6)
002256  add.b  -$27(a3, a5.l), d7
00225A  ; data: 0xdf, 0x7f
00225C  asr.b  d0, d5
00225E  ; data: 0xe0, 0xcb
002260  roxl.w d0, d1
002262  ror.b  #$1, d0
002264  ror.l  d1, d7
002266  asl.w  d1, d6
002268  lsr.b  #$2, d5
00226A  roxr.l d2, d5
00226C  rol.w  #$2, d5
00226E  asr.b  #$3, d4
002270  lsr.l  d3, d5
002272  roxl.w #$3, d5
002274  ; data: 0xe7, 0xfd
002276  asr.l  d4, d6
002278  lsl.w  #$4, d7
00227A  ; data: 0xe9, 0xf7
00227C  asr.l  d5, d1
00227E  lsl.w  #$5, d2
002280  ; data: 0xeb, 0xf3
002282  ror.l  #$6, d5
002284  asl.w  #$6, d6
002286  ; data: 0xed, 0xf0
002288  ror.l  #$7, d2
00228A  asl.w  #$7, d4
00228C  ; data: 0xef, 0xee
00228E  dc.w   $f098
002290  ; data: 0xf1, 0x43
002292  ; data: 0xf1, 0xed
002294  dc.w   $f298
002296  ; data: 0xf3, 0x42
002298  ; data: 0xf3, 0xed
00229A  dc.w   $f498
00229C  ; data: 0xf5, 0x43
00229E  ; data: 0xf5, 0xee
0022A0  dc.w   $f699
0022A2  ; data: 0xf7, 0x44
0022A4  ; data: 0xf7, 0xef
0022A6  dc.w   $f89b
0022A8  ; data: 0xf9, 0x46
0022AA  ; data: 0xf9, 0xf1
0022AC  dc.w   $fa9d
0022AE  ; data: 0xfb, 0x48
0022B0  ; data: 0xfb, 0xf3
0022B2  dc.w   $fc9f
0022B4  ; data: 0xfd, 0x4a
0022B6  ; data: 0xfd, 0xf6
0022B8  dc.w   $fea1
0022BA  ; data: 0xff, 0x4d
0022BC  ; data: 0xff, 0xff
0022BE  ori.w  #$0, (a0)
0022C2  ori.w  #$0, (a2)
0022C6  ori.w  #$0, (a4)
0022CA  ori.w  #$0, (a6)
0022CE  ori.w  #$c82, (a0)+
0022D2  ori.b  #$0, d1
0022D6  ori.b  #$0, d1
0022DA  ori.b  #$0, d1
0022DE  ori.b  #$0, d0
0022E2  ori.b  #$0, d0
0022E6  ori.b  #$0, d0
0022EA  ori.b  #$0, d0
0022EE  ori.b  #$0, d0
0022F2  ori.b  #$0, d0
0022F6  ori.b  #$0, d0
0022FA  ori.b  #$0, d0
0022FE  btst.l d0, d0
002300  bchg.b d7, -(a6)
002302  eori.b #$11, (a1)
002306  ; data: 0x04, 0x4f
002308  ; data: 0x04, 0x4f
00230A  ; data: 0x04, 0x4f
00230C  ; data: 0x04, 0x4f
00230E  ori.b  #$0, d0
002312  ori.b  #$0, d0
002316  ori.b  #$0, d0
00231A  ori.b  #$0, d0
00231E  ori.b  #$0, d0
002322  ori.b  #$0, d0
002326  ori.b  #$0, d0
00232A  ori.b  #$0, d0
00232E  ori.b  #$0, d0
002332  ori.b  #$0, d0
002336  ori.b  #$0, d0
00233A  ori.b  #$0, d0
00233E  ori.b  #$0, d0
002342  ori.b  #$0, d0
002346  ori.b  #$0, d0
00234A  ori.b  #$0, d0
00234E  ori.b  #$0, d0
002352  ori.b  #$0, d0
002356  ori.b  #$0, d0
00235A  ori.b  #$0, d0
00235E  ori.b  #$0, d0
002362  ori.b  #$0, d0
002366  ori.b  #$0, d0
00236A  ori.b  #$0, d0
00236E  ori.b  #$0, d0
002372  ori.b  #$0, d0
002376  ori.b  #$0, d0
00237A  ori.b  #$0, d0
00237E  ori.b  #$0, d0
002382  ori.b  #$0, d0
002386  ori.b  #$0, d0
00238A  ori.b  #$0, d0
00238E  ori.b  #$0, d0
002392  ori.b  #$0, d0
002396  ori.b  #$0, d0
00239A  ori.b  #$0, d0
00239E  ori.b  #$0, d0
0023A2  ori.b  #$0, d0
0023A6  ori.b  #$0, d0
0023AA  ori.b  #$0, d0
0023AE  ori.b  #$0, d0
0023B2  ori.b  #$0, d0
0023B6  ori.b  #$0, d0
0023BA  ori.b  #$0, d0
0023BE  ori.b  #$0, d0
0023C2  ori.b  #$0, d0
0023C6  ori.b  #$0, d0
0023CA  ori.b  #$0, d0
0023CE  ori.b  #$0, d0
0023D2  ori.b  #$0, d0
0023D6  ori.b  #$0, d0
0023DA  ori.b  #$0, d0
0023DE  ori.b  #$0, d0
0023E2  ori.b  #$0, d0
0023E6  ori.b  #$0, d0
0023EA  ori.b  #$0, d0
0023EE  ori.b  #$0, d0
0023F2  ori.b  #$0, d0
0023F6  ori.b  #$0, d0
0023FA  ori.b  #$0, d0
0023FE  ori.b  #$0, d0
002402  ori.b  #$0, d0
002406  ori.b  #$0, d0
00240A  ori.b  #$0, d0
00240E  ori.b  #$0, d0
002412  ori.b  #$0, d0
002416  ori.b  #$0, d0
00241A  ori.b  #$0, d0
00241E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00242C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00243A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002448  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002456  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002464  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002472  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002480  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00248E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00249C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0024AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0024B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0024C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0024D4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0024E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0024F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0024FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00250C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00251A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002528  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002536  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002544  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002552  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002560  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00256E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00257C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00258A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002598  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0025A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0025B4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0025C2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0025D0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0025DE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0025EC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0025FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002608  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002616  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002624  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002632  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002640  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00264E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00265C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00266A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002678  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002686  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002694  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0026A2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0026B0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0026BE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0026CC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0026DA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0026E8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0026F6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002704  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002712  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002720  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00272E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00273C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00274A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002758  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002766  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002774  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002782  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002790  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00279E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0027AC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0027BA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0027C8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0027D6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0027E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0027F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002800  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00280E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00281C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00282A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002838  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002846  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002854  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002862  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002870  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00287E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00288C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00289A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0028A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0028B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0028C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0028D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0028E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0028EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0028FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00290A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002918  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002926  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002934  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002942  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002950  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00295E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00296C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00297A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002988  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002996  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0029A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0029B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0029C0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0029CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0029DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0029EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0029F8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A06  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A14  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A22  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A30  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A3E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A4C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A5A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A68  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A76  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A84  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002A92  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002AA0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002AAE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002ABC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002ACA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002AD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002AE6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002AF4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B02  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B1E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B2C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B3A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B48  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B56  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B64  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B80  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B8E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002B9C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002BAA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002BB8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002BC6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002BD4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002BE2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002BF0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002BFE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C0C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C1A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C28  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C36  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C44  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C52  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C60  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C6E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C7C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C8A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002C98  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002CA6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002CB4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002CC2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002CD0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002CDE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002CEC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002CFA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D08  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D16  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D24  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D32  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D40  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D4E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D5C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D6A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D78  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D86  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002D94  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002DA2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002DB0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002DBE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002DCC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002DDA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002DE8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002DF6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E04  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E12  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E20  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E2E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E3C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E4A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E58  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E66  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E82  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E90  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002E9E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002EAC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002EBA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002EC8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002ED6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002EE4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002EF2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F00  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F2A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F38  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F46  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F54  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F62  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F70  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F7E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F8C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002F9A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002FA8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002FB6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002FC4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002FD2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002FE0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002FEE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
002FFC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00300A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003018  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003026  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003034  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003042  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003050  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00305E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00306C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00307A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003088  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003096  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0030A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0030B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0030C0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0030CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0030DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0030EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0030F8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003106  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003114  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003122  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003130  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00313E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00314C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00315A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003168  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003176  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003184  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003192  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
0031A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0031AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0031BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0031CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0031D8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0031E6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0031F4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003202  ; data: 0x1d, 0x88
003204  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003212  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003220  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00322E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00323C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00324A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003258  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003266  ; data: 0x1d, 0x88
003268  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003276  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003284  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003292  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0032A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0032AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0032BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0032CA  move.b -(a0), $1db0(a6)
0032CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0032DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0032EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0032F8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003306  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003314  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003322  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
003330  ; data: 0x1d, 0x88
003332  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003340  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00334E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00335C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00336A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003378  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003386  move.b $1db01db0(d1.l * 4), $1db0ffb0(d1.l * 4)
003394  ; data: 0x1d, 0x88
003396  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0033A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0033B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0033C0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0033CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0033DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0033EA  move.b $1db01db0(d1.l * 4), $1db0ffb0(d1.l * 4)
0033F8  ; data: 0x1d, 0x88
0033FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003408  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003416  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003424  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003432  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003440  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00344E  move.b $1db01db0(d1.l * 4), $1d88ffb0(d1.l * 4)
00345C  ; data: 0x1d, 0x88
00345E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00346C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00347A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003488  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003496  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0034A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0034B2  move.b $1db01db0(d1.l * 4), $1d88ffb0(d1.l * 4)
0034C0  move.b -(a0), $1db0(a6)
0034C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0034D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0034E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0034EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0034FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00350A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003518  move.b $1db01db0(d1.l * 4), (d1.l * 4)
003522  ; data: 0xff, 0xb0
003524  move.b -(a0), $1db0(a6)
003528  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003536  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003544  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003552  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003560  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00356E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00357C  move.b $1db01db0(d1.l * 4), (d1.l * 4)
003586  ; data: 0xff, 0xb0
003588  move.b -(a0), $1db0(a6)
00358C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00359A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0035A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0035B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0035C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0035D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0035E0  move.b $1db01db0(d1.l * 4), (d1.l * 4)
0035EA  ; data: 0xff, 0xb0
0035EC  move.b -(a0), $1db0(a6)
0035F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0035FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00360C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00361A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003628  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003636  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003644  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00364E  ; data: 0xff, 0xb0
003650  ; data: 0xff, 0xb0
003652  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003660  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00366E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00367C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00368A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003698  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0036A6  move.b $1db01db0(d1.l * 4), $1d88ffb0(d1.l * 4)
0036B4  ; data: 0xff, 0xb0
0036B6  ; data: 0x1d, 0x88
0036B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0036C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0036D4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0036E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0036F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0036FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00370C  move.b $1db01db0(d1.l * 4), (d1.l * 4)
003716  ; data: 0xff, 0xb0
003718  ; data: 0xff, 0x88
00371A  ; data: 0x1d, 0x88
00371C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00372A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003738  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003746  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003754  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003762  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003770  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00377A  ; data: 0xff, 0x88
00377C  ; data: 0xff, 0x88
00377E  move.b -(a0), $1db0(a6)
003782  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003790  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00379E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0037AC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0037BA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0037C8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0037D6  move.b $1db01d60(d1.l * 4), (a7.l * 8)
0037E0  ; data: 0xff, 0x88
0037E2  ; data: 0xff, 0xb0
0037E4  ; data: 0x1d, 0x88
0037E6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0037F4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003802  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003810  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00381E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00382C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00383A  move.b $1db01d60(d1.l * 4), (a7.l * 8)
003844  ; data: 0xff, 0x88
003846  ; data: 0xff, 0x88
003848  ; data: 0x1d, 0x88
00384A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003858  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003866  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003874  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003882  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003890  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00389E  move.b $1db0ffb0(d1.l * 4), $ff60(a6, invalid.w)
0038AA  ; data: 0xff, 0x88
0038AC  ; data: 0xff, 0xb0
0038AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0038BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0038CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0038D8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0038E6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0038F4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003902  move.b $1d88ff88(d1.l * 4), $ff60(a6, invalid.w)
00390E  ; data: 0xff, 0x60
003910  ; data: 0xff, 0x88
003912  ; data: 0x1d, 0x88
003914  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003922  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003930  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00393E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00394C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00395A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003968  move.b (d1.l * 4), (a7.l * 8)
00396E  dc.w   $ff38
003970  dc.w   $ff38
003972  dc.w   $ff38
003974  ; data: 0xff, 0x60
003976  ; data: 0xff, 0xb0
003978  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003986  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003994  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0039A2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0039B0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0039BE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0039CC  move.b $ff60ff38(a7.l * 8), (a6, a7.l * 8)
0039D6  dc.w   $ff38
0039D8  dc.w   $ff38
0039DA  ; data: 0xff, 0x88
0039DC  ; data: 0x1d, 0x88
0039DE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0039EC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0039FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A08  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A16  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A24  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A32  ; data: 0xff, 0x88
003A34  dc.w   $ff38
003A36  dc.w   $ff10
003A38  dc.w   $ff10
003A3A  dc.w   $ff10
003A3C  dc.w   $ff38
003A3E  ; data: 0xff, 0x60
003A40  move.b -(a0), $1db0(a6)
003A44  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A52  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A60  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A6E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A7C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003A8A  move.b $1db01db0(d1.l * 4), $1d88ff60(d1.l * 4)
003A98  dc.w   $ff38
003A9A  dc.w   $fee8
003A9C  dc.w   $fee8
003A9E  dc.w   $fee8
003AA0  dc.w   $ff10
003AA2  dc.w   $ff38
003AA4  ; data: 0xff, 0x88
003AA6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003AB4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003AC2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003AD0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003ADE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003AEC  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
003AFA  ; data: 0xff, 0x60
003AFC  dc.w   $ff10
003AFE  dc.w   $fec0
003B00  dc.w   $fec0
003B02  dc.w   $fec0
003B04  dc.w   $fee8
003B06  dc.w   $ff38
003B08  ; data: 0xff, 0x88
003B0A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003B18  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003B26  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003B34  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003B42  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003B50  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
003B5E  dc.w   $ff38
003B60  dc.w   $fee8
003B62  dc.w   $fe98
003B64  dc.w   $fe98
003B66  dc.w   $fe98
003B68  dc.w   $fec0
003B6A  dc.w   $ff10
003B6C  ; data: 0xff, 0x60
003B6E  ; data: 0x1d, 0x88
003B70  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003B7E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003B8C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003B9A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003BA8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003BB6  move.b $1db01db0(d1.l * 4), $ff88ff10(d1.l * 4)
003BC4  dc.w   $fec0
003BC6  dc.w   $fe70
003BC8  dc.w   $fe70
003BCA  dc.w   $fe70
003BCC  dc.w   $fe98
003BCE  dc.w   $fee8
003BD0  ; data: 0xff, 0x60
003BD2  ; data: 0x1d, 0x88
003BD4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003BE2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003BF0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003BFE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003C0C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003C1A  move.b $1db01db0(d1.l * 4), $ff60fee8(d1.l * 4)
003C28  dc.w   $fe70
003C2A  dc.w   $fe48
003C2C  dc.w   $fe48
003C2E  dc.w   $fe48
003C30  dc.w   $fe98
003C32  dc.w   $fee8
003C34  ; data: 0xff, 0x60
003C36  ; data: 0x1d, 0x88
003C38  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003C46  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003C54  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003C62  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003C70  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003C7E  move.b $1db01db0(d1.l * 4), (d1.l * 4)
003C88  dc.w   $ff38
003C8A  dc.w   $fec0
003C8C  dc.w   $fe48
003C8E  dc.w   $fe20
003C90  dc.w   $fe20
003C92  dc.w   $fe20
003C94  dc.w   $fe70
003C96  dc.w   $fec0
003C98  dc.w   $ff38
003C9A  ; data: 0x1d, 0x88
003C9C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003CAA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003CB8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003CC6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003CD4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003CE2  move.b $1db01db0(d1.l * 4), (d1.l * 4)
003CEC  dc.w   $ff10
003CEE  dc.w   $fe98
003CF0  dc.w   $fe20
003CF2  ; data: 0xfd, 0xf8
003CF4  ; data: 0xfd, 0xd0
003CF6  ; data: 0xfd, 0xf8
003CF8  dc.w   $fe48
003CFA  dc.w   $fec0
003CFC  dc.w   $ff38
003CFE  ; data: 0x1d, 0x88
003D00  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D2A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D38  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D46  move.b $1db01db0(d1.l * 4), $fee8(a6, invalid.w)
003D52  dc.w   $fe70
003D54  ; data: 0xfd, 0xf8
003D56  ; data: 0xfd, 0xa8
003D58  ; data: 0xfd, 0xa8
003D5A  ; data: 0xfd, 0xd0
003D5C  dc.w   $fe20
003D5E  dc.w   $fe98
003D60  dc.w   $ff38
003D62  ; data: 0x1d, 0x88
003D64  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D80  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D8E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003D9C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003DAA  move.b $1db01db0(d1.l * 4), $fee8fe20(a7.l * 8)
003DB8  ; data: 0xfd, 0xa8
003DBA  ; data: 0xfd, 0x80
003DBC  ; data: 0xfd, 0x80
003DBE  ; data: 0xfd, 0xa8
003DC0  dc.w   $fe20
003DC2  dc.w   $fe98
003DC4  dc.w   $ff38
003DC6  ; data: 0x1d, 0x88
003DC8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003DD6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003DE4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003DF2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003E00  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003E0E  move.b $1db01db0(d1.l * 4), (a7.l * 8)
003E18  dc.w   $fec0
003E1A  ; data: 0xfd, 0xf8
003E1C  ; data: 0xfd, 0x80
003E1E  dc.w   $fd30
003E20  dc.w   $fd30
003E22  ; data: 0xfd, 0x80
003E24  ; data: 0xfd, 0xf8
003E26  dc.w   $fe98
003E28  dc.w   $ff38
003E2A  ; data: 0x1d, 0x88
003E2C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003E3A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003E48  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003E56  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003E64  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003E72  move.b $1db01db0(d1.l * 4), (a7.l * 8)
003E7C  dc.w   $fe98
003E7E  ; data: 0xfd, 0xd0
003E80  dc.w   $fd58
003E82  ; data: 0xfd, 0x08
003E84  ; data: 0xfd, 0x08
003E86  dc.w   $fd58
003E88  ; data: 0xfd, 0xd0
003E8A  dc.w   $fe70
003E8C  dc.w   $ff38
003E8E  ; data: 0x1d, 0x88
003E90  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003E9E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003EAC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003EBA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003EC8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003ED6  move.b $1db01db0(d1.l * 4), (a7.l * 8)
003EE0  dc.w   $fe70
003EE2  ; data: 0xfd, 0xa8
003EE4  ; data: 0xfd, 0x08
003EE6  dc.w   $fcb8
003EE8  dc.w   $fce0
003EEA  dc.w   $fd30
003EEC  ; data: 0xfd, 0xd0
003EEE  dc.w   $fe70
003EF0  dc.w   $ff38
003EF2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F00  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F2A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F38  move.b $1db01db0(d1.l * 4), $ff60fe70(d1.l * 4)
003F46  ; data: 0xfd, 0x80
003F48  dc.w   $fce0
003F4A  dc.w   $fc90
003F4C  dc.w   $fc90
003F4E  ; data: 0xfd, 0x08
003F50  ; data: 0xfd, 0xa8
003F52  dc.w   $fe70
003F54  dc.w   $ff38
003F56  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F64  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F80  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F8E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003F9C  move.b $1db01db0(d1.l * 4), $ff60fe48(d1.l * 4)
003FAA  dc.w   $fd58
003FAC  dc.w   $fc90
003FAE  dc.w   $fc40
003FB0  dc.w   $fc68
003FB2  dc.w   $fce0
003FB4  ; data: 0xfd, 0x80
003FB6  dc.w   $fe70
003FB8  dc.w   $ff38
003FBA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003FC8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003FD6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003FE4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
003FF2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004000  move.b $1db01db0(d1.l * 4), $ff60fe20(d1.l * 4)
00400E  dc.w   $fd30
004010  dc.w   $fc68
004012  dc.w   $fc18
004014  dc.w   $fc40
004016  dc.w   $fcb8
004018  ; data: 0xfd, 0x80
00401A  dc.w   $fe70
00401C  ; data: 0xff, 0x60
00401E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00402C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00403A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004048  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004056  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004064  move.b $1db01db0(d1.l * 4), $ff38fdf8(d1.l * 4)
004072  dc.w   $fce0
004074  dc.w   $fc40
004076  ; data: 0xfb, 0xc8
004078  ; data: 0xfb, 0xf0
00407A  dc.w   $fc90
00407C  dc.w   $fd58
00407E  dc.w   $fe48
004080  ; data: 0xff, 0x60
004082  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004090  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00409E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0040AC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0040BA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0040C8  move.b $1db01db0(d1.l * 4), $ff38fdf8(d1.l * 4)
0040D6  dc.w   $fcb8
0040D8  ; data: 0xfb, 0xf0
0040DA  ; data: 0xfb, 0xa0
0040DC  ; data: 0xfb, 0xc8
0040DE  dc.w   $fc68
0040E0  dc.w   $fd30
0040E2  dc.w   $fe48
0040E4  ; data: 0xff, 0x60
0040E6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0040F4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004102  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004110  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00411E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00412C  move.b $1db01db0(d1.l * 4), $ff38fdd0(d1.l * 4)
00413A  dc.w   $fc90
00413C  ; data: 0xfb, 0xc8
00413E  dc.w   $fb78
004140  ; data: 0xfb, 0xa0
004142  dc.w   $fc40
004144  dc.w   $fd30
004146  dc.w   $fe48
004148  ; data: 0xff, 0x60
00414A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004158  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004166  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004174  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004182  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004190  move.b $1db01db0(d1.l * 4), $ff38fda8(d1.l * 4)
00419E  dc.w   $fc68
0041A0  ; data: 0xfb, 0xa0
0041A2  dc.w   $fb50
0041A4  dc.w   $fb78
0041A6  dc.w   $fc18
0041A8  ; data: 0xfd, 0x08
0041AA  dc.w   $fe48
0041AC  ; data: 0xff, 0x60
0041AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0041BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0041CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0041D8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0041E6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0041F4  move.b $1db01db0(d1.l * 4), $ff38fda8(d1.l * 4)
004202  dc.w   $fc68
004204  dc.w   $fb78
004206  ; data: 0xfb, 0x00
004208  dc.w   $fb50
00420A  ; data: 0xfb, 0xf0
00420C  ; data: 0xfd, 0x08
00420E  dc.w   $fe48
004210  ; data: 0xff, 0x88
004212  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004220  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00422E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00423C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00424A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004258  move.b $1db01db0(d1.l * 4), $ff10fd80(d1.l * 4)
004266  dc.w   $fc40
004268  dc.w   $fb50
00426A  dc.w   $fad8
00426C  dc.w   $fb28
00426E  ; data: 0xfb, 0xc8
004270  dc.w   $fce0
004272  dc.w   $fe48
004274  ; data: 0xff, 0x88
004276  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004284  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004292  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0042A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0042AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0042BC  move.b $1db01db0(d1.l * 4), $ff10fd80(d1.l * 4)
0042CA  dc.w   $fc18
0042CC  dc.w   $fb28
0042CE  dc.w   $fab0
0042D0  ; data: 0xfb, 0x00
0042D2  ; data: 0xfb, 0xc8
0042D4  dc.w   $fce0
0042D6  dc.w   $fe48
0042D8  ; data: 0xff, 0x88
0042DA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0042E8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0042F6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004304  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004312  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004320  move.b $1db01db0(d1.l * 4), $ff10fd58(d1.l * 4)
00432E  ; data: 0xfb, 0xf0
004330  ; data: 0xfb, 0x00
004332  dc.w   $fa88
004334  dc.w   $fad8
004336  ; data: 0xfb, 0xa0
004338  dc.w   $fce0
00433A  dc.w   $fe20
00433C  ; data: 0xff, 0x88
00433E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00434C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00435A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004368  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004376  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004384  move.b $1db01db0(d1.l * 4), $ff10fd58(d1.l * 4)
004392  ; data: 0xfb, 0xf0
004394  dc.w   $fad8
004396  dc.w   $fa88
004398  dc.w   $fab0
00439A  dc.w   $fb78
00439C  dc.w   $fcb8
00439E  dc.w   $fe20
0043A0  ; data: 0xff, 0x88
0043A2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0043B0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0043BE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0043CC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0043DA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0043E8  move.b $1db01db0(d1.l * 4), $fee8fd30(d1.l * 4)
0043F6  ; data: 0xfb, 0xc8
0043F8  dc.w   $fad8
0043FA  dc.w   $fa60
0043FC  dc.w   $fab0
0043FE  dc.w   $fb78
004400  dc.w   $fcb8
004402  dc.w   $fe20
004404  ; data: 0xff, 0x88
004406  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004414  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004422  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004430  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00443E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00444C  move.b $1db01db0(d1.l * 4), $fee8fd30(d1.l * 4)
00445A  ; data: 0xfb, 0xc8
00445C  dc.w   $fab0
00445E  dc.w   $fa60
004460  dc.w   $fa88
004462  dc.w   $fb78
004464  dc.w   $fcb8
004466  dc.w   $fe20
004468  ; data: 0xff, 0x88
00446A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004478  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004486  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004494  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0044A2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0044B0  move.b $1db01db0(d1.l * 4), $fee8fd30(d1.l * 4)
0044BE  ; data: 0xfb, 0xa0
0044C0  dc.w   $fab0
0044C2  dc.w   $fa38
0044C4  dc.w   $fa88
0044C6  dc.w   $fb50
0044C8  dc.w   $fc90
0044CA  dc.w   $fe20
0044CC  ; data: 0xff, 0x88
0044CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0044DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0044EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0044F8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004506  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004514  move.b $1db01db0(d1.l * 4), $fec0fd30(d1.l * 4)
004522  ; data: 0xfb, 0xa0
004524  dc.w   $fab0
004526  dc.w   $fa38
004528  dc.w   $fa88
00452A  dc.w   $fb50
00452C  dc.w   $fc90
00452E  ; data: 0xfd, 0xf8
004530  ; data: 0xff, 0x60
004532  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004540  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00454E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00455C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00456A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004578  move.b $1db01db0(d1.l * 4), $fec0fd08(d1.l * 4)
004586  ; data: 0xfb, 0xa0
004588  dc.w   $fab0
00458A  dc.w   $fa38
00458C  dc.w   $fa88
00458E  dc.w   $fb50
004590  dc.w   $fc90
004592  ; data: 0xfd, 0xf8
004594  ; data: 0xff, 0x60
004596  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0045A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0045B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0045C0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0045CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0045DC  move.b $1db01db0(d1.l * 4), $fec0fd08(d1.l * 4)
0045EA  ; data: 0xfb, 0xa0
0045EC  dc.w   $fab0
0045EE  dc.w   $fa38
0045F0  dc.w   $fa88
0045F2  dc.w   $fb50
0045F4  dc.w   $fc90
0045F6  ; data: 0xfd, 0xf8
0045F8  ; data: 0xff, 0x60
0045FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004608  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004616  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004624  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004632  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004640  move.b $1db01db0(d1.l * 4), $fec0fd08(d1.l * 4)
00464E  ; data: 0xfb, 0xa0
004650  dc.w   $fab0
004652  dc.w   $fa38
004654  dc.w   $fa88
004656  dc.w   $fb50
004658  dc.w   $fc90
00465A  ; data: 0xfd, 0xf8
00465C  dc.w   $ff38
00465E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00466C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00467A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004688  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004696  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0046A4  move.b $1db01db0(d1.l * 4), $fe98fd08(d1.l * 4)
0046B2  ; data: 0xfb, 0xa0
0046B4  dc.w   $fab0
0046B6  dc.w   $fa38
0046B8  dc.w   $fa88
0046BA  dc.w   $fb50
0046BC  dc.w   $fc90
0046BE  ; data: 0xfd, 0xd0
0046C0  dc.w   $ff38
0046C2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0046D0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0046DE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0046EC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0046FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004708  move.b $1db01db0(d1.l * 4), $fe98fd08(d1.l * 4)
004716  ; data: 0xfb, 0xa0
004718  dc.w   $fab0
00471A  dc.w   $fa60
00471C  dc.w   $fa88
00471E  dc.w   $fb50
004720  dc.w   $fc90
004722  ; data: 0xfd, 0xd0
004724  dc.w   $ff10
004726  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004734  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004742  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004750  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00475E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00476C  move.b $1db01db0(d1.l * 4), $fe98fd08(d1.l * 4)
00477A  ; data: 0xfb, 0xa0
00477C  dc.w   $fad8
00477E  dc.w   $fa60
004780  dc.w   $fab0
004782  dc.w   $fb50
004784  dc.w   $fc90
004786  ; data: 0xfd, 0xd0
004788  dc.w   $ff10
00478A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004798  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0047A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0047B4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0047C2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0047D0  move.b $1db01db0(d1.l * 4), $fe70fd08(d1.l * 4)
0047DE  ; data: 0xfb, 0xc8
0047E0  dc.w   $fad8
0047E2  dc.w   $fa88
0047E4  dc.w   $fab0
0047E6  dc.w   $fb78
0047E8  dc.w   $fc90
0047EA  ; data: 0xfd, 0xd0
0047EC  dc.w   $fee8
0047EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0047FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00480A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004818  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004826  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004834  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00483E  dc.w   $fe70
004840  ; data: 0xfd, 0x08
004842  ; data: 0xfb, 0xc8
004844  ; data: 0xfb, 0x00
004846  dc.w   $fab0
004848  dc.w   $fad8
00484A  dc.w   $fb78
00484C  dc.w   $fc90
00484E  ; data: 0xfd, 0xa8
004850  dc.w   $fee8
004852  ; data: 0x1d, 0x88
004854  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004862  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004870  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00487E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00488C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00489A  move.b $1db01d88(d1.l * 4), $70(a6, a7.l)
0048A4  ; data: 0xfd, 0x08
0048A6  ; data: 0xfb, 0xf0
0048A8  dc.w   $fb28
0048AA  dc.w   $fab0
0048AC  dc.w   $fad8
0048AE  ; data: 0xfb, 0xa0
0048B0  dc.w   $fc90
0048B2  ; data: 0xfd, 0xa8
0048B4  dc.w   $fec0
0048B6  move.b -(a0), $1db0(a6)
0048BA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0048C8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0048D6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0048E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0048F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004900  move.b $1d60fe70(d1.l * 4), (a6, a7.l * 4)
00490A  ; data: 0xfb, 0xf0
00490C  dc.w   $fb28
00490E  dc.w   $fad8
004910  ; data: 0xfb, 0x00
004912  ; data: 0xfb, 0xa0
004914  dc.w   $fc90
004916  ; data: 0xfd, 0xa8
004918  dc.w   $fec0
00491A  ; data: 0xff, 0x88
00491C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00492A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004938  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004946  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004954  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004962  move.b $1db0ff88(d1.l * 4), $48(a6, a7.l)
00496C  ; data: 0xfd, 0x08
00496E  dc.w   $fc18
004970  dc.w   $fb50
004972  ; data: 0xfb, 0x00
004974  dc.w   $fb28
004976  ; data: 0xfb, 0xc8
004978  dc.w   $fc90
00497A  ; data: 0xfd, 0x80
00497C  dc.w   $fe98
00497E  ; data: 0xff, 0x88
004980  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00498E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00499C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0049AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0049B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0049C6  move.b $1db0ff88(d1.l * 4), $48(a6, a7.l)
0049D0  dc.w   $fd30
0049D2  dc.w   $fc18
0049D4  dc.w   $fb78
0049D6  dc.w   $fb28
0049D8  dc.w   $fb50
0049DA  ; data: 0xfb, 0xc8
0049DC  dc.w   $fc90
0049DE  ; data: 0xfd, 0x80
0049E0  dc.w   $fe70
0049E2  ; data: 0xff, 0x60
0049E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0049F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A00  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A2A  move.b $1db0ff60(d1.l * 4), $48(a6, a7.l)
004A34  dc.w   $fd30
004A36  dc.w   $fc40
004A38  ; data: 0xfb, 0xa0
004A3A  dc.w   $fb50
004A3C  dc.w   $fb78
004A3E  ; data: 0xfb, 0xf0
004A40  dc.w   $fc90
004A42  ; data: 0xfd, 0x80
004A44  dc.w   $fe70
004A46  dc.w   $ff38
004A48  ; data: 0x1d, 0x88
004A4A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A58  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A66  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A82  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004A90  move.b $ff38fe48(d1.l * 4), $fc68fbc8(a6, a7.l * 4)
004A9E  dc.w   $fb78
004AA0  ; data: 0xfb, 0xa0
004AA2  ; data: 0xfb, 0xf0
004AA4  dc.w   $fcb8
004AA6  ; data: 0xfd, 0x80
004AA8  dc.w   $fe48
004AAA  dc.w   $ff10
004AAC  move.b -(a0), $1db0(a6)
004AB0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004ABE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004ACC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004ADA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004AE8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004AF6  move.b $fe20fd30(a0, a7.l * 8), $68(a6, a7.l)
004B00  ; data: 0xfb, 0xf0
004B02  ; data: 0xfb, 0xa0
004B04  ; data: 0xfb, 0xc8
004B06  dc.w   $fc18
004B08  dc.w   $fcb8
004B0A  dc.w   $fd58
004B0C  dc.w   $fe48
004B0E  dc.w   $fee8
004B10  ; data: 0xff, 0xb0
004B12  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004B20  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004B2E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004B3C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004B4A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004B58  move.b $ff10fe20(d1.l * 4), (a6, invalid.w)
004B62  dc.w   $fc90
004B64  dc.w   $fc18
004B66  ; data: 0xfb, 0xc8
004B68  ; data: 0xfb, 0xc8
004B6A  dc.w   $fc40
004B6C  dc.w   $fcb8
004B6E  dc.w   $fd58
004B70  dc.w   $fe20
004B72  dc.w   $fee8
004B74  ; data: 0xff, 0x88
004B76  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004B84  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004B92  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004BA0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004BAE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004BBC  move.b (d1.l * 4), (a6, a7.l * 8)
004BC2  dc.w   $fe20
004BC4  dc.w   $fd58
004BC6  dc.w   $fcb8
004BC8  dc.w   $fc40
004BCA  ; data: 0xfb, 0xf0
004BCC  ; data: 0xfb, 0xf0
004BCE  dc.w   $fc40
004BD0  dc.w   $fcb8
004BD2  dc.w   $fd58
004BD4  dc.w   $fe20
004BD6  dc.w   $fec0
004BD8  ; data: 0xff, 0x60
004BDA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004BE8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004BF6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004C04  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004C12  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004C20  move.b $fee8(a0, invalid.w), $20(a6, a7.l)
004C28  dc.w   $fd58
004C2A  dc.w   $fcb8
004C2C  dc.w   $fc40
004C2E  dc.w   $fc18
004C30  dc.w   $fc18
004C32  dc.w   $fc68
004C34  dc.w   $fce0
004C36  dc.w   $fd58
004C38  ; data: 0xfd, 0xf8
004C3A  dc.w   $fe98
004C3C  dc.w   $ff38
004C3E  ; data: 0x1d, 0x88
004C40  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004C4E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004C5C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004C6A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004C78  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004C86  ; data: 0xff, 0xb0
004C88  dc.w   $fee8
004C8A  dc.w   $fe20
004C8C  dc.w   $fd58
004C8E  dc.w   $fce0
004C90  dc.w   $fc68
004C92  dc.w   $fc40
004C94  dc.w   $fc40
004C96  dc.w   $fc68
004C98  dc.w   $fce0
004C9A  dc.w   $fd58
004C9C  ; data: 0xfd, 0xf8
004C9E  dc.w   $fe98
004CA0  dc.w   $ff38
004CA2  ; data: 0x1d, 0x88
004CA4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004CB2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004CC0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004CCE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004CDC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004CEA  ; data: 0xff, 0x88
004CEC  dc.w   $fec0
004CEE  dc.w   $fe20
004CF0  ; data: 0xfd, 0x80
004CF2  dc.w   $fce0
004CF4  dc.w   $fc90
004CF6  dc.w   $fc68
004CF8  dc.w   $fc68
004CFA  dc.w   $fc90
004CFC  dc.w   $fce0
004CFE  dc.w   $fd58
004D00  ; data: 0xfd, 0xf8
004D02  dc.w   $fe70
004D04  dc.w   $ff10
004D06  ; data: 0x1d, 0x88
004D08  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004D16  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004D24  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004D32  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004D40  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004D4E  ; data: 0xff, 0x60
004D50  dc.w   $fec0
004D52  dc.w   $fe20
004D54  ; data: 0xfd, 0x80
004D56  ; data: 0xfd, 0x08
004D58  dc.w   $fcb8
004D5A  dc.w   $fc90
004D5C  dc.w   $fc90
004D5E  dc.w   $fcb8
004D60  dc.w   $fce0
004D62  dc.w   $fd58
004D64  ; data: 0xfd, 0xd0
004D66  dc.w   $fe70
004D68  dc.w   $ff10
004D6A  move.b -(a0), $1db0(a6)
004D6E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004D7C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004D8A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004D98  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004DA6  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
004DB4  dc.w   $fec0
004DB6  dc.w   $fe20
004DB8  ; data: 0xfd, 0x80
004DBA  ; data: 0xfd, 0x08
004DBC  dc.w   $fcb8
004DBE  dc.w   $fc90
004DC0  dc.w   $fc90
004DC2  dc.w   $fcb8
004DC4  ; data: 0xfd, 0x08
004DC6  dc.w   $fd58
004DC8  ; data: 0xfd, 0xd0
004DCA  dc.w   $fe70
004DCC  dc.w   $ff10
004DCE  ; data: 0xff, 0xb0
004DD0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004DDE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004DEC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004DFA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004E08  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004E16  ; data: 0xff, 0x60
004E18  dc.w   $fe98
004E1A  dc.w   $fe20
004E1C  ; data: 0xfd, 0x80
004E1E  dc.w   $fd30
004E20  dc.w   $fce0
004E22  dc.w   $fcb8
004E24  dc.w   $fcb8
004E26  dc.w   $fce0
004E28  ; data: 0xfd, 0x08
004E2A  dc.w   $fd58
004E2C  ; data: 0xfd, 0xd0
004E2E  dc.w   $fe70
004E30  dc.w   $fee8
004E32  ; data: 0xff, 0xb0
004E34  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004E42  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004E50  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004E5E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004E6C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004E7A  dc.w   $ff38
004E7C  dc.w   $fe98
004E7E  dc.w   $fe20
004E80  ; data: 0xfd, 0xa8
004E82  dc.w   $fd30
004E84  ; data: 0xfd, 0x08
004E86  dc.w   $fce0
004E88  dc.w   $fcb8
004E8A  dc.w   $fce0
004E8C  ; data: 0xfd, 0x08
004E8E  dc.w   $fd58
004E90  ; data: 0xfd, 0xd0
004E92  dc.w   $fe70
004E94  dc.w   $fee8
004E96  ; data: 0xff, 0xb0
004E98  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004EA6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004EB4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004EC2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004ED0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004EDE  dc.w   $ff38
004EE0  dc.w   $fe98
004EE2  dc.w   $fe20
004EE4  ; data: 0xfd, 0xa8
004EE6  dc.w   $fd58
004EE8  ; data: 0xfd, 0x08
004EEA  dc.w   $fce0
004EEC  dc.w   $fce0
004EEE  dc.w   $fce0
004EF0  dc.w   $fd30
004EF2  ; data: 0xfd, 0x80
004EF4  ; data: 0xfd, 0xd0
004EF6  dc.w   $fe70
004EF8  dc.w   $fee8
004EFA  ; data: 0xff, 0xb0
004EFC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F0A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F18  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F26  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F34  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F42  dc.w   $ff38
004F44  dc.w   $fe98
004F46  dc.w   $fe20
004F48  ; data: 0xfd, 0xa8
004F4A  dc.w   $fd58
004F4C  ; data: 0xfd, 0x08
004F4E  ; data: 0xfd, 0x08
004F50  dc.w   $fce0
004F52  ; data: 0xfd, 0x08
004F54  dc.w   $fd30
004F56  ; data: 0xfd, 0x80
004F58  ; data: 0xfd, 0xf8
004F5A  dc.w   $fe70
004F5C  dc.w   $ff10
004F5E  ; data: 0xff, 0xb0
004F60  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F6E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F7C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F8A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004F98  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004FA6  dc.w   $ff38
004FA8  dc.w   $fe98
004FAA  dc.w   $fe20
004FAC  ; data: 0xfd, 0xa8
004FAE  dc.w   $fd58
004FB0  dc.w   $fd30
004FB2  ; data: 0xfd, 0x08
004FB4  ; data: 0xfd, 0x08
004FB6  ; data: 0xfd, 0x08
004FB8  dc.w   $fd30
004FBA  ; data: 0xfd, 0x80
004FBC  ; data: 0xfd, 0xf8
004FBE  dc.w   $fe70
004FC0  dc.w   $ff10
004FC2  move.b -(a0), $1db0(a6)
004FC6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004FD4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004FE2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004FF0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
004FFE  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00500C  dc.w   $fec0
00500E  dc.w   $fe20
005010  ; data: 0xfd, 0xd0
005012  dc.w   $fd58
005014  dc.w   $fd30
005016  ; data: 0xfd, 0x08
005018  ; data: 0xfd, 0x08
00501A  dc.w   $fd30
00501C  dc.w   $fd58
00501E  ; data: 0xfd, 0xa8
005020  ; data: 0xfd, 0xf8
005022  dc.w   $fe98
005024  dc.w   $ff10
005026  move.b -(a0), $1db0(a6)
00502A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005038  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005046  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005054  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005062  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
005070  dc.w   $fec0
005072  dc.w   $fe48
005074  ; data: 0xfd, 0xd0
005076  ; data: 0xfd, 0x80
005078  dc.w   $fd30
00507A  ; data: 0xfd, 0x08
00507C  ; data: 0xfd, 0x08
00507E  dc.w   $fd30
005080  dc.w   $fd58
005082  ; data: 0xfd, 0xa8
005084  dc.w   $fe20
005086  dc.w   $fe98
005088  dc.w   $ff38
00508A  ; data: 0x1d, 0x88
00508C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00509A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0050A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0050B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0050C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0050D2  ; data: 0xff, 0x60
0050D4  dc.w   $fec0
0050D6  dc.w   $fe48
0050D8  ; data: 0xfd, 0xd0
0050DA  ; data: 0xfd, 0x80
0050DC  dc.w   $fd30
0050DE  ; data: 0xfd, 0x08
0050E0  ; data: 0xfd, 0x08
0050E2  dc.w   $fd30
0050E4  ; data: 0xfd, 0x80
0050E6  ; data: 0xfd, 0xd0
0050E8  dc.w   $fe20
0050EA  dc.w   $fec0
0050EC  dc.w   $ff38
0050EE  ; data: 0x1d, 0x88
0050F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0050FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00510C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00511A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005128  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005136  ; data: 0xff, 0x88
005138  dc.w   $fee8
00513A  dc.w   $fe48
00513C  ; data: 0xfd, 0xd0
00513E  ; data: 0xfd, 0x80
005140  dc.w   $fd30
005142  ; data: 0xfd, 0x08
005144  ; data: 0xfd, 0x08
005146  dc.w   $fd30
005148  ; data: 0xfd, 0x80
00514A  ; data: 0xfd, 0xd0
00514C  dc.w   $fe48
00514E  dc.w   $fec0
005150  ; data: 0xff, 0x60
005152  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005160  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00516E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00517C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00518A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005198  move.b (a7.l * 8), -$18(a6, a7.l)
00519E  dc.w   $fe70
0051A0  ; data: 0xfd, 0xd0
0051A2  ; data: 0xfd, 0x80
0051A4  dc.w   $fd30
0051A6  ; data: 0xfd, 0x08
0051A8  ; data: 0xfd, 0x08
0051AA  dc.w   $fd30
0051AC  ; data: 0xfd, 0x80
0051AE  ; data: 0xfd, 0xf8
0051B0  dc.w   $fe70
0051B2  dc.w   $fee8
0051B4  ; data: 0xff, 0x88
0051B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0051C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0051D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0051E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0051EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0051FC  move.b $ff10fe70(a7.l * 8), (invalid.w)
005206  ; data: 0xfd, 0x80
005208  dc.w   $fd30
00520A  ; data: 0xfd, 0x08
00520C  ; data: 0xfd, 0x08
00520E  dc.w   $fd30
005210  ; data: 0xfd, 0xa8
005212  ; data: 0xfd, 0xf8
005214  dc.w   $fe98
005216  dc.w   $ff10
005218  ; data: 0xff, 0xb0
00521A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005228  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005236  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005244  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005252  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005260  move.b (d1.l * 4), (a6, a7.l * 8)
005266  dc.w   $fe70
005268  ; data: 0xfd, 0xf8
00526A  ; data: 0xfd, 0x80
00526C  dc.w   $fd30
00526E  ; data: 0xfd, 0x08
005270  ; data: 0xfd, 0x08
005272  dc.w   $fd30
005274  ; data: 0xfd, 0xa8
005276  dc.w   $fe20
005278  dc.w   $fec0
00527A  dc.w   $ff38
00527C  ; data: 0x1d, 0x88
00527E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00528C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00529A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0052A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0052B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0052C4  move.b (d1.l * 4), $fe98fdf8(a6, a7.l * 8)
0052CE  dc.w   $fd58
0052D0  ; data: 0xfd, 0x08
0052D2  dc.w   $fce0
0052D4  ; data: 0xfd, 0x08
0052D6  dc.w   $fd58
0052D8  ; data: 0xfd, 0xa8
0052DA  dc.w   $fe48
0052DC  dc.w   $fee8
0052DE  ; data: 0xff, 0x60
0052E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0052EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0052FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00530A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005318  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005326  move.b $1db0ff60(d1.l * 4), -$68(a6, a7.l)
005330  ; data: 0xfd, 0xf8
005332  dc.w   $fd58
005334  ; data: 0xfd, 0x08
005336  dc.w   $fce0
005338  ; data: 0xfd, 0x08
00533A  dc.w   $fd58
00533C  ; data: 0xfd, 0xd0
00533E  dc.w   $fe70
005340  dc.w   $ff10
005342  ; data: 0xff, 0xb0
005344  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005352  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005360  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00536E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00537C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00538A  move.b $1db0ff88(d1.l * 4), -$40(a6, a7.l)
005394  ; data: 0xfd, 0xf8
005396  dc.w   $fd58
005398  ; data: 0xfd, 0x08
00539A  dc.w   $fce0
00539C  dc.w   $fce0
00539E  dc.w   $fd58
0053A0  ; data: 0xfd, 0xd0
0053A2  dc.w   $fe70
0053A4  dc.w   $ff38
0053A6  ; data: 0x1d, 0x88
0053A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0053B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0053C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0053D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0053E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0053EE  move.b $1db0ff88(d1.l * 4), -$40(a6, a7.l)
0053F8  ; data: 0xfd, 0xf8
0053FA  dc.w   $fd58
0053FC  dc.w   $fce0
0053FE  dc.w   $fcb8
005400  dc.w   $fce0
005402  dc.w   $fd58
005404  ; data: 0xfd, 0xd0
005406  dc.w   $fe98
005408  ; data: 0xff, 0x60
00540A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005418  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005426  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005434  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005442  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005450  move.b $1db01db0(d1.l * 4), $fee8(a6, invalid.w)
00545C  ; data: 0xfd, 0xf8
00545E  dc.w   $fd58
005460  dc.w   $fce0
005462  dc.w   $fcb8
005464  dc.w   $fce0
005466  dc.w   $fd58
005468  ; data: 0xfd, 0xf8
00546A  dc.w   $fec0
00546C  ; data: 0xff, 0x88
00546E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00547C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00548A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005498  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0054A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0054B4  move.b $1db01db0(d1.l * 4), (d1.l * 4)
0054BE  dc.w   $fee8
0054C0  ; data: 0xfd, 0xf8
0054C2  dc.w   $fd58
0054C4  dc.w   $fcb8
0054C6  dc.w   $fc90
0054C8  dc.w   $fcb8
0054CA  dc.w   $fd58
0054CC  ; data: 0xfd, 0xf8
0054CE  dc.w   $fee8
0054D0  move.b -(a0), $1db0(a6)
0054D4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0054E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0054F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0054FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00550C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00551A  move.b $1db01db0(d1.l * 4), (a6, a7.l * 8)
005524  dc.w   $fe20
005526  dc.w   $fd30
005528  dc.w   $fcb8
00552A  dc.w   $fc90
00552C  dc.w   $fcb8
00552E  dc.w   $fd58
005530  dc.w   $fe20
005532  dc.w   $fee8
005534  ; data: 0x1d, 0x88
005536  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005544  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005552  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005560  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00556E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00557C  move.b $1db01db0(d1.l * 4), $ff10fe20(d1.l * 4)
00558A  dc.w   $fd30
00558C  dc.w   $fcb8
00558E  dc.w   $fc68
005590  dc.w   $fcb8
005592  dc.w   $fd58
005594  dc.w   $fe20
005596  dc.w   $ff10
005598  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0055A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0055B4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0055C2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0055D0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0055DE  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
0055EC  dc.w   $fe20
0055EE  dc.w   $fd30
0055F0  dc.w   $fc90
0055F2  dc.w   $fc68
0055F4  dc.w   $fcb8
0055F6  dc.w   $fd58
0055F8  dc.w   $fe20
0055FA  dc.w   $ff38
0055FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00560A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005618  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005626  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005634  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005642  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
005650  dc.w   $fe20
005652  dc.w   $fd30
005654  dc.w   $fc90
005656  dc.w   $fc68
005658  dc.w   $fc90
00565A  dc.w   $fd58
00565C  dc.w   $fe48
00565E  ; data: 0xff, 0x60
005660  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00566E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00567C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00568A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005698  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0056A6  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
0056B4  dc.w   $fe20
0056B6  dc.w   $fd30
0056B8  dc.w   $fc90
0056BA  dc.w   $fc40
0056BC  dc.w   $fc90
0056BE  dc.w   $fd58
0056C0  dc.w   $fe48
0056C2  ; data: 0xff, 0x88
0056C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0056D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0056E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0056EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0056FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00570A  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
005718  dc.w   $fe48
00571A  dc.w   $fd30
00571C  dc.w   $fc68
00571E  dc.w   $fc40
005720  dc.w   $fc90
005722  dc.w   $fd58
005724  dc.w   $fe70
005726  ; data: 0xff, 0x88
005728  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005736  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005744  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005752  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005760  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00576E  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
00577C  dc.w   $fe48
00577E  dc.w   $fd30
005780  dc.w   $fc68
005782  dc.w   $fc40
005784  dc.w   $fc90
005786  dc.w   $fd58
005788  dc.w   $fe70
00578A  move.b -(a0), $1db0(a6)
00578E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00579C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0057AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0057B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0057C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0057D4  move.b $1db01db0(d1.l * 4), $ff88fe48(d1.l * 4)
0057E2  dc.w   $fd30
0057E4  dc.w   $fc68
0057E6  dc.w   $fc40
0057E8  dc.w   $fc90
0057EA  dc.w   $fd58
0057EC  dc.w   $fe98
0057EE  ; data: 0x1d, 0x88
0057F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0057FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00580C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00581A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005828  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005836  move.b $1db01db0(d1.l * 4), $1db0ffb0(d1.l * 4)
005844  dc.w   $fe48
005846  dc.w   $fd30
005848  dc.w   $fc68
00584A  dc.w   $fc40
00584C  dc.w   $fc90
00584E  ; data: 0xfd, 0x80
005850  dc.w   $fe98
005852  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005860  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00586E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00587C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00588A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005898  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0058A6  move.b -(a0), -$190(a6)
0058AA  dc.w   $fd30
0058AC  dc.w   $fc68
0058AE  dc.w   $fc40
0058B0  dc.w   $fc90
0058B2  ; data: 0xfd, 0x80
0058B4  dc.w   $fec0
0058B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0058C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0058D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0058E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0058EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0058FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00590A  ; data: 0x1d, 0x88
00590C  dc.w   $fe70
00590E  dc.w   $fd58
005910  dc.w   $fc90
005912  dc.w   $fc40
005914  dc.w   $fcb8
005916  ; data: 0xfd, 0x80
005918  dc.w   $fec0
00591A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005928  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005936  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005944  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005952  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005960  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00596E  ; data: 0x1d, 0x88
005970  dc.w   $fe70
005972  dc.w   $fd58
005974  dc.w   $fc90
005976  dc.w   $fc68
005978  dc.w   $fcb8
00597A  ; data: 0xfd, 0xa8
00597C  dc.w   $fee8
00597E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00598C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00599A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0059A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0059B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0059C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0059D2  ; data: 0x1d, 0x88
0059D4  dc.w   $fe98
0059D6  dc.w   $fd58
0059D8  dc.w   $fc90
0059DA  dc.w   $fc68
0059DC  dc.w   $fcb8
0059DE  ; data: 0xfd, 0xa8
0059E0  dc.w   $fee8
0059E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0059F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0059FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A0C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A1A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A28  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A36  move.b -$68(a0, a7.l), (a7.l * 4)
005A3C  dc.w   $fcb8
005A3E  dc.w   $fc90
005A40  dc.w   $fce0
005A42  ; data: 0xfd, 0xd0
005A44  dc.w   $ff10
005A46  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A54  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A62  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A70  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A7E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A8C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005A9A  move.b -$68(a0, a7.l), (a7.l * 4)
005AA0  dc.w   $fcb8
005AA2  dc.w   $fc90
005AA4  ; data: 0xfd, 0x08
005AA6  ; data: 0xfd, 0xd0
005AA8  dc.w   $ff10
005AAA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005AB8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005AC6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005AD4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005AE2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005AF0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005AFE  move.b -$40(a0, a7.l), $fce0(a7.l * 4)
005B06  dc.w   $fcb8
005B08  ; data: 0xfd, 0x08
005B0A  ; data: 0xfd, 0xf8
005B0C  dc.w   $ff38
005B0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B2A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B38  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B46  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B54  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B62  move.b -$40(a0, a7.l), $fd08(a7.l * 4)
005B6A  dc.w   $fce0
005B6C  dc.w   $fd30
005B6E  dc.w   $fe20
005B70  dc.w   $ff38
005B72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B80  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B8E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005B9C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005BAA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005BB8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005BC6  move.b -$18(a0, a7.l), (invalid.w)
005BCC  dc.w   $fd30
005BCE  ; data: 0xfd, 0x08
005BD0  dc.w   $fd58
005BD2  dc.w   $fe48
005BD4  ; data: 0xff, 0x60
005BD6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005BE4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005BF2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C00  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C2A  move.b -$18(a0, a7.l), $fd58fd30(invalid.w)
005C34  ; data: 0xfd, 0x80
005C36  dc.w   $fe48
005C38  ; data: 0xff, 0x88
005C3A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C48  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C56  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C64  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C80  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005C8E  move.b (a0, a7.l * 8), $20(a6, a7.l)
005C94  ; data: 0xfd, 0x80
005C96  dc.w   $fd58
005C98  ; data: 0xfd, 0xa8
005C9A  dc.w   $fe70
005C9C  ; data: 0xff, 0x88
005C9E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005CAC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005CBA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005CC8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005CD6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005CE4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005CF2  move.b (a0, a7.l * 8), $48(a6, a7.l)
005CF8  ; data: 0xfd, 0xa8
005CFA  ; data: 0xfd, 0x80
005CFC  ; data: 0xfd, 0xd0
005CFE  dc.w   $fe98
005D00  ; data: 0xff, 0xb0
005D02  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D1E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D2C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D3A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D48  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D56  move.b $fe48fdd0(a0, a7.l * 8), $fdf8(a7.l * 4)
005D62  dc.w   $fec0
005D64  move.b -(a0), $1db0(a6)
005D68  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D76  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D84  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005D92  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005DA0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005DAE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005DBC  dc.w   $ff38
005DBE  dc.w   $fe70
005DC0  ; data: 0xfd, 0xf8
005DC2  ; data: 0xfd, 0xd0
005DC4  dc.w   $fe20
005DC6  dc.w   $fee8
005DC8  ; data: 0x1d, 0x88
005DCA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005DD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005DE6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005DF4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E02  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E1E  move.b $fe98(a0, invalid.w), $20(a6, a7.l)
005E26  dc.w   $fe20
005E28  dc.w   $fe70
005E2A  dc.w   $ff10
005E2C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E3A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E48  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E56  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E64  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E80  move.b $ff60fec0(d1.l * 4), $70(a6, a7.l)
005E8A  dc.w   $fe48
005E8C  dc.w   $fe98
005E8E  dc.w   $ff38
005E90  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005E9E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005EAC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005EBA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005EC8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005ED6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005EE4  move.b $ff88fee8(d1.l * 4), -$68(a6, a7.l)
005EEE  dc.w   $fe70
005EF0  dc.w   $fec0
005EF2  ; data: 0xff, 0x60
005EF4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F02  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F1E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F2C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F3A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F48  move.b $ffb0ff10(d1.l * 4), -$40(a6, a7.l)
005F52  dc.w   $fec0
005F54  dc.w   $fee8
005F56  ; data: 0xff, 0x88
005F58  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F66  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F82  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F90  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005F9E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005FAC  move.b $1d60ff38(d1.l * 4), -$18(a6, a7.l)
005FB6  dc.w   $fee8
005FB8  dc.w   $ff38
005FBA  ; data: 0xff, 0xb0
005FBC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005FCA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005FD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005FE6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
005FF4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006002  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006010  move.b $1d88ff60(d1.l * 4), $ff10ff60(a6, a7.l * 8)
00601E  ; data: 0x1d, 0x88
006020  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00602E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00603C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00604A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006058  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006066  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006074  move.b $1d88ff88(d1.l * 4), $ff60(a6, invalid.w)
006080  ; data: 0xff, 0x88
006082  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006090  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00609E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0060AC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0060BA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0060C8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0060D6  move.b $1db01db0(d1.l * 4), $ff88ff88(a7.l * 8)
0060E4  move.b -(a0), $1db0(a6)
0060E8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0060F6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006104  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006112  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006120  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00612E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00613C  move.b $1db01d88(d1.l * 4), $1d601d88(a7.l * 8)
00614A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006158  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006166  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006174  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006182  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006190  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00619E  move.b $1db01db0(d1.l * 4), (d1.l * 4)
0061A8  ; data: 0x1d, 0x88
0061AA  ; data: 0x1d, 0x88
0061AC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0061BA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0061C8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0061D6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0061E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0061F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006200  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00620E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00621C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00622A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006238  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006246  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006254  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006262  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006270  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00627E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00628C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00629A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0062A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0062B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0062C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0062D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0062E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0062EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0062FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00630A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006318  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006326  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006334  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006342  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006350  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00635E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00636C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00637A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006388  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006396  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0063A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0063B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0063C0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0063CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0063DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0063EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0063F8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006406  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006414  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006422  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006430  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00643E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00644C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00645A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006468  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006476  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006484  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006492  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0064A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0064AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0064BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0064CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0064D8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0064E6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0064F4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006502  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006510  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00651E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00652C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00653A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006548  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006556  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006564  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006572  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006580  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00658E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00659C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0065AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0065B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0065C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0065D4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0065E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0065F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0065FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00660C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00661A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006628  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006636  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006644  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006652  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006660  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00666E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00667C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00668A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006698  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0066A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0066B4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0066C2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0066D0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0066DE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0066EC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0066FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006708  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006716  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006724  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006732  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006740  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00674E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00675C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00676A  ; data: 0x1d, 0x88
00676C  ; data: 0x1d, 0x88
00676E  ; data: 0x1d, 0x88
006770  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00677E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00678C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00679A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0067A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0067B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0067C4  move.b $1db01db0(d1.l * 4), (d1.l * 4)
0067CE  ; data: 0xff, 0xb0
0067D0  ; data: 0xff, 0x88
0067D2  move.b -(a0), $1d88(a6)
0067D6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0067E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0067F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006800  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00680E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00681C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00682A  move.b $1db0ffb0(d1.l * 4), $ff60(a6, invalid.w)
006836  ; data: 0xff, 0x88
006838  ; data: 0x1d, 0x88
00683A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006848  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006856  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006864  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006872  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006880  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00688E  move.b $1d88ff88(d1.l * 4), $ff38ff60(a6, a7.l * 8)
00689C  move.b -(a0), $1db0(a6)
0068A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0068AE  move.b (d1.l * 4), $1db01db0(d1.l * 4)
0068B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0068C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0068D4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0068E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0068F0  move.b $1db0ffb0(d1.l * 4), $ff10ff10(a6, a7.l * 8)
0068FE  dc.w   $ff38
006900  ; data: 0xff, 0xb0
006902  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006910  move.b (d1.l * 4), $1d88(a6, invalid.w)
006918  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006926  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006934  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006942  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006950  move.b $1db01db0(d1.l * 4), $ff88ff10(d1.l * 4)
00695E  dc.w   $fee8
006960  dc.w   $fee8
006962  dc.w   $ff10
006964  ; data: 0xff, 0x88
006966  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006974  move.b (d1.l * 4), (a7.l * 8)
00697A  ; data: 0xff, 0xb0
00697C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00698A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006998  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0069A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0069B4  move.b $1db01db0(d1.l * 4), $ff60fee8(d1.l * 4)
0069C2  dc.w   $fec0
0069C4  dc.w   $fec0
0069C6  dc.w   $fee8
0069C8  ; data: 0xff, 0x88
0069CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0069D8  move.b $ff60ff88(a7.l * 8), (d1.l * 4)
0069E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0069F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0069FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006A0C  move.b -(a0), $1d88(a6)
006A10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006A1E  move.b $ff60fec0(d1.l * 4), $70(a6, a7.l)
006A28  dc.w   $fe70
006A2A  dc.w   $fec0
006A2C  ; data: 0xff, 0x60
006A2E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006A3C  move.b (a7.l * 8), $ff60ffb0(a6, a7.l * 8)
006A46  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006A54  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006A62  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
006A70  ; data: 0xff, 0x88
006A72  ; data: 0xff, 0xb0
006A74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006A82  move.b $ff38fe98(d1.l * 4), $48(a6, a7.l)
006A8C  dc.w   $fe48
006A8E  dc.w   $fec0
006A90  dc.w   $ff38
006A92  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006AA0  move.b $ff38(a0, invalid.w), $ff881db0(a6, a7.l * 8)
006AAC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006ABA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006AC8  move.b $1db01db0(d1.l * 4), $ffb0ff60(d1.l * 4)
006AD6  ; data: 0xff, 0x60
006AD8  ; data: 0x1d, 0x88
006ADA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006AE8  ; data: 0x1d, 0x88
006AEA  dc.w   $ff10
006AEC  dc.w   $fe70
006AEE  dc.w   $fe20
006AF0  dc.w   $fe20
006AF2  dc.w   $fe98
006AF4  dc.w   $ff38
006AF6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006B04  ; data: 0x1d, 0x88
006B06  ; data: 0xff, 0x60
006B08  dc.w   $ff10
006B0A  dc.w   $ff10
006B0C  ; data: 0xff, 0x60
006B0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006B1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006B2A  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
006B38  dc.w   $ff38
006B3A  dc.w   $ff38
006B3C  move.b -(a0), $1db0(a6)
006B40  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
006B4E  dc.w   $fee8
006B50  dc.w   $fe48
006B52  ; data: 0xfd, 0xf8
006B54  ; data: 0xfd, 0xf8
006B56  dc.w   $fe70
006B58  dc.w   $ff10
006B5A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006B68  ; data: 0x1d, 0x88
006B6A  dc.w   $ff38
006B6C  dc.w   $fee8
006B6E  dc.w   $fee8
006B70  dc.w   $ff38
006B72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006B80  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006B8E  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
006B9C  dc.w   $ff10
006B9E  dc.w   $ff38
006BA0  ; data: 0xff, 0x88
006BA2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006BB0  ; data: 0x1d, 0x88
006BB2  dc.w   $fee8
006BB4  dc.w   $fe20
006BB6  ; data: 0xfd, 0xd0
006BB8  ; data: 0xfd, 0xd0
006BBA  dc.w   $fe48
006BBC  dc.w   $ff10
006BBE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006BCC  ; data: 0x1d, 0x88
006BCE  dc.w   $ff10
006BD0  dc.w   $fec0
006BD2  dc.w   $fec0
006BD4  dc.w   $ff10
006BD6  ; data: 0x1d, 0x88
006BD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006BE6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006BF4  move.b $1db01db0(d1.l * 4), $ff38fee8(d1.l * 4)
006C02  dc.w   $ff10
006C04  ; data: 0xff, 0x88
006C06  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006C14  move.b -(a0), -$140(a6)
006C18  ; data: 0xfd, 0xf8
006C1A  ; data: 0xfd, 0xa8
006C1C  ; data: 0xfd, 0xa8
006C1E  dc.w   $fe20
006C20  dc.w   $fee8
006C22  ; data: 0x1d, 0x88
006C24  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
006C32  dc.w   $ff10
006C34  dc.w   $fe98
006C36  dc.w   $fe98
006C38  dc.w   $fee8
006C3A  ; data: 0x1d, 0x88
006C3C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006C4A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006C58  move.b $1db01db0(d1.l * 4), $ff10fec0(d1.l * 4)
006C66  dc.w   $fee8
006C68  ; data: 0xff, 0x60
006C6A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006C78  move.b -(a0), -$140(a6)
006C7C  ; data: 0xfd, 0xd0
006C7E  ; data: 0xfd, 0x80
006C80  ; data: 0xfd, 0x80
006C82  ; data: 0xfd, 0xf8
006C84  dc.w   $fee8
006C86  ; data: 0x1d, 0x88
006C88  move.b $1db01db0(d1.l * 4), $1db0ffb0(d1.l * 4)
006C96  dc.w   $fee8
006C98  dc.w   $fe70
006C9A  dc.w   $fe70
006C9C  dc.w   $fec0
006C9E  ; data: 0xff, 0xb0
006CA0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006CAE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006CBC  move.b $1db01db0(d1.l * 4), $ff10fe98(d1.l * 4)
006CCA  dc.w   $fec0
006CCC  ; data: 0xff, 0x60
006CCE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006CDC  ; data: 0xff, 0xb0
006CDE  dc.w   $fe98
006CE0  ; data: 0xfd, 0xd0
006CE2  dc.w   $fd58
006CE4  dc.w   $fd58
006CE6  ; data: 0xfd, 0xf8
006CE8  dc.w   $fec0
006CEA  ; data: 0x1d, 0x88
006CEC  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
006CFA  dc.w   $fec0
006CFC  dc.w   $fe48
006CFE  dc.w   $fe48
006D00  dc.w   $fec0
006D02  ; data: 0xff, 0x88
006D04  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006D12  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006D20  move.b $1db01db0(d1.l * 4), $fee8fe98(d1.l * 4)
006D2E  dc.w   $fec0
006D30  dc.w   $ff38
006D32  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006D40  ; data: 0xff, 0xb0
006D42  dc.w   $fe98
006D44  ; data: 0xfd, 0xa8
006D46  dc.w   $fd30
006D48  dc.w   $fd58
006D4A  ; data: 0xfd, 0xd0
006D4C  dc.w   $fec0
006D4E  ; data: 0x1d, 0x88
006D50  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
006D5E  dc.w   $fec0
006D60  dc.w   $fe20
006D62  dc.w   $fe20
006D64  dc.w   $fe98
006D66  ; data: 0xff, 0x88
006D68  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006D76  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006D84  move.b $1db01db0(d1.l * 4), $fec0fe70(d1.l * 4)
006D92  dc.w   $fe98
006D94  dc.w   $ff38
006D96  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006DA4  ; data: 0xff, 0xb0
006DA6  dc.w   $fe70
006DA8  ; data: 0xfd, 0xa8
006DAA  dc.w   $fd30
006DAC  dc.w   $fd30
006DAE  ; data: 0xfd, 0xa8
006DB0  dc.w   $fe98
006DB2  ; data: 0x1d, 0x88
006DB4  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
006DC2  dc.w   $fe98
006DC4  dc.w   $fe20
006DC6  ; data: 0xfd, 0xf8
006DC8  dc.w   $fe70
006DCA  ; data: 0xff, 0x60
006DCC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006DDA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006DE8  move.b $1db01db0(d1.l * 4), $fec0fe70(d1.l * 4)
006DF6  dc.w   $fe98
006DF8  dc.w   $ff38
006DFA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006E08  ; data: 0xff, 0x88
006E0A  dc.w   $fe70
006E0C  ; data: 0xfd, 0x80
006E0E  ; data: 0xfd, 0x08
006E10  ; data: 0xfd, 0x08
006E12  ; data: 0xfd, 0xa8
006E14  dc.w   $fe98
006E16  move.b -(a0), $1db0(a6)
006E1A  move.b $1db01db0(d1.l * 4), $ff60fe70(d1.l * 4)
006E28  ; data: 0xfd, 0xf8
006E2A  ; data: 0xfd, 0xf8
006E2C  dc.w   $fe70
006E2E  ; data: 0xff, 0x60
006E30  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006E3E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006E4C  move.b $1db01db0(d1.l * 4), $fec0fe48(d1.l * 4)
006E5A  dc.w   $fe70
006E5C  dc.w   $ff38
006E5E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006E6C  ; data: 0xff, 0x88
006E6E  dc.w   $fe70
006E70  ; data: 0xfd, 0x80
006E72  ; data: 0xfd, 0x08
006E74  ; data: 0xfd, 0x08
006E76  ; data: 0xfd, 0xa8
006E78  dc.w   $fe98
006E7A  move.b -(a0), $1db0(a6)
006E7E  move.b $1db01db0(d1.l * 4), $ff60fe70(d1.l * 4)
006E8C  ; data: 0xfd, 0xd0
006E8E  ; data: 0xfd, 0xd0
006E90  dc.w   $fe48
006E92  dc.w   $ff38
006E94  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006EA2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006EB0  move.b $1db01db0(d1.l * 4), $fec0fe48(d1.l * 4)
006EBE  dc.w   $fe70
006EC0  dc.w   $ff10
006EC2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006ED0  ; data: 0xff, 0x88
006ED2  dc.w   $fe70
006ED4  ; data: 0xfd, 0x80
006ED6  dc.w   $fce0
006ED8  ; data: 0xfd, 0x08
006EDA  ; data: 0xfd, 0x80
006EDC  dc.w   $fe70
006EDE  ; data: 0xff, 0xb0
006EE0  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
006EEE  dc.w   $fe70
006EF0  ; data: 0xfd, 0xd0
006EF2  ; data: 0xfd, 0xd0
006EF4  dc.w   $fe48
006EF6  dc.w   $ff38
006EF8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006F06  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006F14  move.b $1db01db0(d1.l * 4), $fec0fe48(d1.l * 4)
006F22  dc.w   $fe70
006F24  dc.w   $ff10
006F26  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006F34  ; data: 0xff, 0x88
006F36  dc.w   $fe48
006F38  dc.w   $fd58
006F3A  dc.w   $fce0
006F3C  dc.w   $fce0
006F3E  ; data: 0xfd, 0x80
006F40  dc.w   $fe70
006F42  ; data: 0xff, 0xb0
006F44  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
006F52  dc.w   $fe48
006F54  ; data: 0xfd, 0xd0
006F56  ; data: 0xfd, 0xa8
006F58  dc.w   $fe20
006F5A  dc.w   $ff10
006F5C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006F6A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006F78  move.b $1db01db0(d1.l * 4), $fec0fe48(d1.l * 4)
006F86  dc.w   $fe70
006F88  dc.w   $ff10
006F8A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006F98  ; data: 0xff, 0x88
006F9A  dc.w   $fe48
006F9C  dc.w   $fd58
006F9E  dc.w   $fce0
006FA0  dc.w   $fce0
006FA2  ; data: 0xfd, 0x80
006FA4  dc.w   $fe70
006FA6  ; data: 0xff, 0x88
006FA8  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
006FB6  dc.w   $fe48
006FB8  ; data: 0xfd, 0xa8
006FBA  ; data: 0xfd, 0xa8
006FBC  dc.w   $fe20
006FBE  dc.w   $ff10
006FC0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006FCE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006FDC  move.b $1db01db0(d1.l * 4), $fec0fe70(d1.l * 4)
006FEA  dc.w   $fe98
006FEC  dc.w   $ff38
006FEE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
006FFC  ; data: 0xff, 0x88
006FFE  dc.w   $fe48
007000  dc.w   $fd58
007002  dc.w   $fce0
007004  dc.w   $fce0
007006  ; data: 0xfd, 0x80
007008  dc.w   $fe70
00700A  ; data: 0xff, 0x88
00700C  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00701A  dc.w   $fe20
00701C  ; data: 0xfd, 0xa8
00701E  ; data: 0xfd, 0xa8
007020  dc.w   $fe20
007022  dc.w   $ff10
007024  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007032  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007040  move.b $1db01db0(d1.l * 4), $fec0fe70(d1.l * 4)
00704E  dc.w   $fe98
007050  dc.w   $ff38
007052  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007060  ; data: 0xff, 0x88
007062  dc.w   $fe48
007064  ; data: 0xfd, 0x80
007066  dc.w   $fce0
007068  ; data: 0xfd, 0x08
00706A  ; data: 0xfd, 0x80
00706C  dc.w   $fe70
00706E  ; data: 0xff, 0x88
007070  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00707E  dc.w   $fe20
007080  ; data: 0xfd, 0xa8
007082  ; data: 0xfd, 0xa8
007084  dc.w   $fe20
007086  dc.w   $ff10
007088  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007096  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0070A4  move.b $1db01db0(d1.l * 4), $fee8fe70(d1.l * 4)
0070B2  dc.w   $fe98
0070B4  dc.w   $ff38
0070B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0070C4  ; data: 0xff, 0x88
0070C6  dc.w   $fe70
0070C8  ; data: 0xfd, 0x80
0070CA  ; data: 0xfd, 0x08
0070CC  ; data: 0xfd, 0x08
0070CE  ; data: 0xfd, 0x80
0070D0  dc.w   $fe70
0070D2  ; data: 0xff, 0x60
0070D4  move.b $1db01db0(d1.l * 4), $1db0fee8(d1.l * 4)
0070E2  dc.w   $fe20
0070E4  ; data: 0xfd, 0xa8
0070E6  ; data: 0xfd, 0x80
0070E8  ; data: 0xfd, 0xf8
0070EA  dc.w   $fee8
0070EC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0070FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007108  move.b $1db01db0(d1.l * 4), $fee8fe98(d1.l * 4)
007116  dc.w   $fec0
007118  ; data: 0xff, 0x60
00711A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007128  ; data: 0xff, 0x88
00712A  dc.w   $fe70
00712C  ; data: 0xfd, 0x80
00712E  ; data: 0xfd, 0x08
007130  ; data: 0xfd, 0x08
007132  ; data: 0xfd, 0x80
007134  dc.w   $fe70
007136  ; data: 0xff, 0x60
007138  move.b $1db01db0(d1.l * 4), $1d88fee8(d1.l * 4)
007146  dc.w   $fe20
007148  ; data: 0xfd, 0xa8
00714A  ; data: 0xfd, 0x80
00714C  ; data: 0xfd, 0xf8
00714E  dc.w   $fee8
007150  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00715E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00716C  move.b $1db01db0(d1.l * 4), $ff10fec0(d1.l * 4)
00717A  dc.w   $fee8
00717C  ; data: 0xff, 0x60
00717E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00718C  ; data: 0xff, 0x88
00718E  dc.w   $fe70
007190  ; data: 0xfd, 0xa8
007192  dc.w   $fd30
007194  dc.w   $fd30
007196  ; data: 0xfd, 0x80
007198  dc.w   $fe48
00719A  ; data: 0xff, 0x60
00719C  move.b $1db01db0(d1.l * 4), $1d60fee8(d1.l * 4)
0071AA  dc.w   $fe20
0071AC  ; data: 0xfd, 0xa8
0071AE  ; data: 0xfd, 0xa8
0071B0  ; data: 0xfd, 0xf8
0071B2  dc.w   $fee8
0071B4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0071C2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0071D0  move.b $1db01db0(d1.l * 4), $ff38fee8(d1.l * 4)
0071DE  dc.w   $fee8
0071E0  ; data: 0xff, 0x88
0071E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0071F0  ; data: 0xff, 0x88
0071F2  dc.w   $fe70
0071F4  ; data: 0xfd, 0xa8
0071F6  dc.w   $fd30
0071F8  dc.w   $fd30
0071FA  ; data: 0xfd, 0xa8
0071FC  dc.w   $fe48
0071FE  dc.w   $ff38
007200  move.b $1db01db0(d1.l * 4), $ffb0fec0(d1.l * 4)
00720E  dc.w   $fe20
007210  ; data: 0xfd, 0xa8
007212  ; data: 0xfd, 0xa8
007214  ; data: 0xfd, 0xf8
007216  dc.w   $fee8
007218  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007226  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007234  move.b $1db01db0(d1.l * 4), $ff38fee8(d1.l * 4)
007242  dc.w   $ff10
007244  ; data: 0xff, 0x88
007246  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007254  ; data: 0xff, 0x88
007256  dc.w   $fe98
007258  ; data: 0xfd, 0xd0
00725A  dc.w   $fd58
00725C  dc.w   $fd58
00725E  ; data: 0xfd, 0xa8
007260  dc.w   $fe70
007262  dc.w   $ff38
007264  move.b $1db01db0(d1.l * 4), $ff88fec0(d1.l * 4)
007272  dc.w   $fe20
007274  ; data: 0xfd, 0xa8
007276  ; data: 0xfd, 0xa8
007278  ; data: 0xfd, 0xf8
00727A  dc.w   $fee8
00727C  ; data: 0x1d, 0x88
00727E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00728C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00729A  move.b $1db01db0(d1.l * 4), $ff10(a6, invalid.w)
0072A6  dc.w   $ff38
0072A8  ; data: 0xff, 0xb0
0072AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0072B8  ; data: 0xff, 0x88
0072BA  dc.w   $fe98
0072BC  ; data: 0xfd, 0xd0
0072BE  dc.w   $fd58
0072C0  dc.w   $fd58
0072C2  ; data: 0xfd, 0xa8
0072C4  dc.w   $fe70
0072C6  dc.w   $ff38
0072C8  ; data: 0x1d, 0x88
0072CA  move.b $1db01db0(d1.l * 4), $fec0(a6, invalid.w)
0072D6  dc.w   $fe20
0072D8  ; data: 0xfd, 0xa8
0072DA  ; data: 0xfd, 0xa8
0072DC  dc.w   $fe20
0072DE  dc.w   $fec0
0072E0  ; data: 0x1d, 0x88
0072E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0072F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0072FE  move.b $1db01db0(d1.l * 4), (a7.l * 8)
007308  ; data: 0xff, 0x60
00730A  ; data: 0xff, 0x60
00730C  move.b -(a0), $1db0(a6)
007310  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
00731E  dc.w   $fe98
007320  ; data: 0xfd, 0xf8
007322  ; data: 0xfd, 0x80
007324  ; data: 0xfd, 0x80
007326  ; data: 0xfd, 0xd0
007328  dc.w   $fe70
00732A  dc.w   $ff10
00732C  ; data: 0x1d, 0x88
00732E  move.b $1db01db0(d1.l * 4), $fe98(a6, invalid.w)
00733A  ; data: 0xfd, 0xf8
00733C  ; data: 0xfd, 0xa8
00733E  ; data: 0xfd, 0xa8
007340  dc.w   $fe20
007342  dc.w   $fec0
007344  move.b -(a0), $1db0(a6)
007348  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007356  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007364  move.b $1db01d60(d1.l * 4), (a7.l * 8)
00736E  ; data: 0xff, 0x88
007370  ; data: 0x1d, 0x88
007372  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007380  ; data: 0xff, 0x88
007382  dc.w   $fec0
007384  dc.w   $fe20
007386  ; data: 0xfd, 0xa8
007388  ; data: 0xfd, 0xa8
00738A  ; data: 0xfd, 0xd0
00738C  dc.w   $fe70
00738E  dc.w   $ff10
007390  ; data: 0xff, 0xb0
007392  move.b $1db01d88(d1.l * 4), $fe98fdf8(a6, a7.l * 8)
0073A0  ; data: 0xfd, 0xa8
0073A2  ; data: 0xfd, 0xd0
0073A4  dc.w   $fe20
0073A6  dc.w   $fec0
0073A8  ; data: 0xff, 0xb0
0073AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0073B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0073C6  move.b $1db01db0(d1.l * 4), (d1.l * 4)
0073D0  ; data: 0xff, 0xb0
0073D2  move.b -(a0), $1db0(a6)
0073D6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0073E4  ; data: 0xff, 0x88
0073E6  dc.w   $fec0
0073E8  dc.w   $fe20
0073EA  ; data: 0xfd, 0xd0
0073EC  ; data: 0xfd, 0xa8
0073EE  ; data: 0xfd, 0xf8
0073F0  dc.w   $fe70
0073F2  dc.w   $fee8
0073F4  ; data: 0xff, 0x88
0073F6  ; data: 0x1d, 0x88
0073F8  move.b $ffb0ff10(d1.l * 4), $70(a6, a7.l)
007402  ; data: 0xfd, 0xf8
007404  ; data: 0xfd, 0xd0
007406  ; data: 0xfd, 0xd0
007408  dc.w   $fe20
00740A  dc.w   $fec0
00740C  ; data: 0xff, 0x88
00740E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00741C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00742A  move.b $1db01db0(d1.l * 4), $1d881d88(d1.l * 4)
007438  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007446  move.b (a7.l * 8), -$18(a6, a7.l)
00744C  dc.w   $fe48
00744E  ; data: 0xfd, 0xf8
007450  ; data: 0xfd, 0xd0
007452  ; data: 0xfd, 0xf8
007454  dc.w   $fe70
007456  dc.w   $fee8
007458  ; data: 0xff, 0x60
00745A  move.b -(a0), $1d88(a6)
00745E  move.b -(a0), -$a0(a6)
007462  dc.w   $fee8
007464  dc.w   $fe70
007466  ; data: 0xfd, 0xf8
007468  ; data: 0xfd, 0xd0
00746A  ; data: 0xfd, 0xd0
00746C  dc.w   $fe20
00746E  dc.w   $fec0
007470  ; data: 0xff, 0x88
007472  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007480  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00748E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00749C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0074AA  move.b (a7.l * 8), -$18(a6, a7.l)
0074B0  dc.w   $fe70
0074B2  dc.w   $fe20
0074B4  ; data: 0xfd, 0xf8
0074B6  dc.w   $fe20
0074B8  dc.w   $fe70
0074BA  dc.w   $fee8
0074BC  dc.w   $ff38
0074BE  ; data: 0xff, 0x88
0074C0  ; data: 0xff, 0xb0
0074C2  ; data: 0xff, 0x88
0074C4  dc.w   $ff38
0074C6  dc.w   $fee8
0074C8  dc.w   $fe70
0074CA  ; data: 0xfd, 0xf8
0074CC  ; data: 0xfd, 0xd0
0074CE  ; data: 0xfd, 0xd0
0074D0  dc.w   $fe20
0074D2  dc.w   $fec0
0074D4  ; data: 0xff, 0x60
0074D6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0074E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0074F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007500  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00750E  move.b (a7.l * 8), (a6, a7.l * 8)
007514  dc.w   $fe98
007516  dc.w   $fe48
007518  dc.w   $fe20
00751A  dc.w   $fe20
00751C  dc.w   $fe70
00751E  dc.w   $fec0
007520  dc.w   $ff10
007522  ; data: 0xff, 0x60
007524  ; data: 0xff, 0x60
007526  ; data: 0xff, 0x60
007528  dc.w   $ff10
00752A  dc.w   $fec0
00752C  dc.w   $fe48
00752E  ; data: 0xfd, 0xf8
007530  ; data: 0xfd, 0xd0
007532  ; data: 0xfd, 0xf8
007534  dc.w   $fe20
007536  dc.w   $fe98
007538  dc.w   $ff38
00753A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007548  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007556  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007564  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007572  move.b $ff10fe98(a7.l * 8), $48(a6, a7.l)
00757C  dc.w   $fe48
00757E  dc.w   $fe48
007580  dc.w   $fe70
007582  dc.w   $fec0
007584  dc.w   $fee8
007586  dc.w   $ff38
007588  dc.w   $ff38
00758A  dc.w   $ff10
00758C  dc.w   $fee8
00758E  dc.w   $fe98
007590  dc.w   $fe48
007592  ; data: 0xfd, 0xf8
007594  ; data: 0xfd, 0xd0
007596  ; data: 0xfd, 0xf8
007598  dc.w   $fe20
00759A  dc.w   $fe98
00759C  dc.w   $ff38
00759E  ; data: 0x1d, 0x88
0075A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0075AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0075BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0075CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0075D8  ; data: 0xff, 0xb0
0075DA  dc.w   $ff38
0075DC  dc.w   $fec0
0075DE  dc.w   $fe70
0075E0  dc.w   $fe48
0075E2  dc.w   $fe48
0075E4  dc.w   $fe70
0075E6  dc.w   $fe98
0075E8  dc.w   $fee8
0075EA  dc.w   $ff10
0075EC  dc.w   $ff10
0075EE  dc.w   $fee8
0075F0  dc.w   $fec0
0075F2  dc.w   $fe70
0075F4  dc.w   $fe20
0075F6  ; data: 0xfd, 0xf8
0075F8  ; data: 0xfd, 0xd0
0075FA  ; data: 0xfd, 0xf8
0075FC  dc.w   $fe20
0075FE  dc.w   $fe98
007600  dc.w   $ff10
007602  ; data: 0xff, 0xb0
007604  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007612  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007620  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00762E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00763C  move.b -(a0), -$c8(a6)
007640  dc.w   $fee8
007642  dc.w   $fe98
007644  dc.w   $fe70
007646  dc.w   $fe70
007648  dc.w   $fe70
00764A  dc.w   $fe98
00764C  dc.w   $fec0
00764E  dc.w   $fec0
007650  dc.w   $fec0
007652  dc.w   $fec0
007654  dc.w   $fe98
007656  dc.w   $fe48
007658  dc.w   $fe20
00765A  ; data: 0xfd, 0xf8
00765C  ; data: 0xfd, 0xd0
00765E  ; data: 0xfd, 0xf8
007660  dc.w   $fe20
007662  dc.w   $fe98
007664  dc.w   $fee8
007666  ; data: 0xff, 0x88
007668  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007676  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007684  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007692  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0076A0  move.b -(a0), -$a0(a6)
0076A4  dc.w   $fee8
0076A6  dc.w   $fec0
0076A8  dc.w   $fe98
0076AA  dc.w   $fe70
0076AC  dc.w   $fe70
0076AE  dc.w   $fe98
0076B0  dc.w   $fe98
0076B2  dc.w   $fe98
0076B4  dc.w   $fe98
0076B6  dc.w   $fe98
0076B8  dc.w   $fe70
0076BA  dc.w   $fe20
0076BC  ; data: 0xfd, 0xf8
0076BE  ; data: 0xfd, 0xd0
0076C0  ; data: 0xfd, 0xd0
0076C2  ; data: 0xfd, 0xf8
0076C4  dc.w   $fe20
0076C6  dc.w   $fe70
0076C8  dc.w   $fee8
0076CA  ; data: 0xff, 0x60
0076CC  ; data: 0x1d, 0x88
0076CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0076DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0076EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0076F8  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
007706  ; data: 0xff, 0x60
007708  dc.w   $ff10
00770A  dc.w   $fec0
00770C  dc.w   $fe98
00770E  dc.w   $fe98
007710  dc.w   $fe70
007712  dc.w   $fe70
007714  dc.w   $fe70
007716  dc.w   $fe70
007718  dc.w   $fe70
00771A  dc.w   $fe48
00771C  dc.w   $fe48
00771E  dc.w   $fe20
007720  ; data: 0xfd, 0xf8
007722  ; data: 0xfd, 0xd0
007724  ; data: 0xfd, 0xd0
007726  ; data: 0xfd, 0xf8
007728  dc.w   $fe20
00772A  dc.w   $fe70
00772C  dc.w   $fec0
00772E  dc.w   $ff38
007730  ; data: 0xff, 0x88
007732  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007740  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00774E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00775C  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
00776A  ; data: 0xff, 0x88
00776C  dc.w   $ff38
00776E  dc.w   $fee8
007770  dc.w   $fec0
007772  dc.w   $fe98
007774  dc.w   $fe70
007776  dc.w   $fe70
007778  dc.w   $fe70
00777A  dc.w   $fe48
00777C  dc.w   $fe48
00777E  dc.w   $fe20
007780  dc.w   $fe20
007782  ; data: 0xfd, 0xf8
007784  ; data: 0xfd, 0xd0
007786  ; data: 0xfd, 0xd0
007788  ; data: 0xfd, 0xd0
00778A  ; data: 0xfd, 0xd0
00778C  dc.w   $fe20
00778E  dc.w   $fe48
007790  dc.w   $fe98
007792  dc.w   $ff10
007794  ; data: 0xff, 0x60
007796  ; data: 0x1d, 0x88
007798  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0077A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0077B4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0077C2  move.b $1db01db0(d1.l * 4), $1d88ff88(d1.l * 4)
0077D0  dc.w   $ff38
0077D2  dc.w   $ff10
0077D4  dc.w   $fec0
0077D6  dc.w   $fe98
0077D8  dc.w   $fe70
0077DA  dc.w   $fe70
0077DC  dc.w   $fe48
0077DE  dc.w   $fe20
0077E0  dc.w   $fe20
0077E2  ; data: 0xfd, 0xf8
0077E4  ; data: 0xfd, 0xf8
0077E6  ; data: 0xfd, 0xd0
0077E8  ; data: 0xfd, 0xd0
0077EA  ; data: 0xfd, 0xa8
0077EC  ; data: 0xfd, 0xd0
0077EE  ; data: 0xfd, 0xd0
0077F0  ; data: 0xfd, 0xf8
0077F2  dc.w   $fe48
0077F4  dc.w   $fe98
0077F6  dc.w   $fee8
0077F8  dc.w   $ff38
0077FA  ; data: 0xff, 0x88
0077FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00780A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007818  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007826  move.b $1db01db0(d1.l * 4), $1d88ff88(d1.l * 4)
007834  ; data: 0xff, 0x60
007836  dc.w   $ff10
007838  dc.w   $fee8
00783A  dc.w   $fe98
00783C  dc.w   $fe70
00783E  dc.w   $fe48
007840  dc.w   $fe20
007842  dc.w   $fe20
007844  ; data: 0xfd, 0xf8
007846  ; data: 0xfd, 0xd0
007848  ; data: 0xfd, 0xd0
00784A  ; data: 0xfd, 0xa8
00784C  ; data: 0xfd, 0xa8
00784E  ; data: 0xfd, 0xa8
007850  ; data: 0xfd, 0xa8
007852  ; data: 0xfd, 0xd0
007854  ; data: 0xfd, 0xf8
007856  dc.w   $fe20
007858  dc.w   $fe70
00785A  dc.w   $fec0
00785C  dc.w   $ff10
00785E  ; data: 0xff, 0x60
007860  ; data: 0x1d, 0x88
007862  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007870  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00787E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00788C  move.b $1db01db0(d1.l * 4), (d1.l * 4)
007896  ; data: 0xff, 0xb0
007898  ; data: 0xff, 0x60
00789A  dc.w   $ff10
00789C  dc.w   $fee8
00789E  dc.w   $fe98
0078A0  dc.w   $fe70
0078A2  dc.w   $fe48
0078A4  dc.w   $fe20
0078A6  ; data: 0xfd, 0xf8
0078A8  ; data: 0xfd, 0xd0
0078AA  ; data: 0xfd, 0xa8
0078AC  ; data: 0xfd, 0xa8
0078AE  ; data: 0xfd, 0x80
0078B0  ; data: 0xfd, 0x80
0078B2  ; data: 0xfd, 0x80
0078B4  ; data: 0xfd, 0xa8
0078B6  ; data: 0xfd, 0xa8
0078B8  ; data: 0xfd, 0xd0
0078BA  dc.w   $fe20
0078BC  dc.w   $fe48
0078BE  dc.w   $fe98
0078C0  dc.w   $fee8
0078C2  dc.w   $ff38
0078C4  ; data: 0xff, 0xb0
0078C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0078D4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0078E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0078F0  move.b $1db01db0(d1.l * 4), $1d60ff60(d1.l * 4)
0078FE  dc.w   $ff38
007900  dc.w   $fee8
007902  dc.w   $fec0
007904  dc.w   $fe70
007906  dc.w   $fe48
007908  ; data: 0xfd, 0xf8
00790A  ; data: 0xfd, 0xd0
00790C  ; data: 0xfd, 0xa8
00790E  ; data: 0xfd, 0xa8
007910  ; data: 0xfd, 0x80
007912  ; data: 0xfd, 0x80
007914  dc.w   $fd58
007916  ; data: 0xfd, 0x80
007918  ; data: 0xfd, 0x80
00791A  ; data: 0xfd, 0xa8
00791C  ; data: 0xfd, 0xd0
00791E  ; data: 0xfd, 0xf8
007920  dc.w   $fe20
007922  dc.w   $fe70
007924  dc.w   $fec0
007926  dc.w   $ff10
007928  ; data: 0xff, 0x88
00792A  ; data: 0x1d, 0x88
00792C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00793A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007948  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007956  move.b $1db01db0(d1.l * 4), $ff88(a6, invalid.w)
007962  dc.w   $ff38
007964  dc.w   $fee8
007966  dc.w   $fe98
007968  dc.w   $fe70
00796A  dc.w   $fe20
00796C  ; data: 0xfd, 0xf8
00796E  ; data: 0xfd, 0xd0
007970  ; data: 0xfd, 0xa8
007972  ; data: 0xfd, 0x80
007974  dc.w   $fd58
007976  dc.w   $fd58
007978  dc.w   $fd58
00797A  dc.w   $fd58
00797C  dc.w   $fd58
00797E  ; data: 0xfd, 0x80
007980  ; data: 0xfd, 0xa8
007982  ; data: 0xfd, 0xd0
007984  ; data: 0xfd, 0xf8
007986  dc.w   $fe48
007988  dc.w   $fe98
00798A  dc.w   $fee8
00798C  ; data: 0xff, 0x60
00798E  ; data: 0x1d, 0x88
007990  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00799E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0079AC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0079BA  move.b $1db01db0(d1.l * 4), (d1.l * 4)
0079C4  ; data: 0xff, 0x88
0079C6  dc.w   $ff38
0079C8  dc.w   $fee8
0079CA  dc.w   $fe98
0079CC  dc.w   $fe70
0079CE  dc.w   $fe20
0079D0  ; data: 0xfd, 0xf8
0079D2  ; data: 0xfd, 0xa8
0079D4  ; data: 0xfd, 0x80
0079D6  dc.w   $fd58
0079D8  dc.w   $fd58
0079DA  dc.w   $fd30
0079DC  dc.w   $fd30
0079DE  dc.w   $fd30
0079E0  dc.w   $fd30
0079E2  dc.w   $fd58
0079E4  ; data: 0xfd, 0x80
0079E6  ; data: 0xfd, 0xa8
0079E8  ; data: 0xfd, 0xf8
0079EA  dc.w   $fe20
0079EC  dc.w   $fe70
0079EE  dc.w   $fee8
0079F0  dc.w   $ff38
0079F2  ; data: 0xff, 0xb0
0079F4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007A02  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007A10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007A1E  move.b $1db01db0(d1.l * 4), (d1.l * 4)
007A28  ; data: 0xff, 0x88
007A2A  dc.w   $ff38
007A2C  dc.w   $fee8
007A2E  dc.w   $fe98
007A30  dc.w   $fe48
007A32  dc.w   $fe20
007A34  ; data: 0xfd, 0xd0
007A36  ; data: 0xfd, 0xa8
007A38  ; data: 0xfd, 0x80
007A3A  dc.w   $fd58
007A3C  dc.w   $fd30
007A3E  ; data: 0xfd, 0x08
007A40  ; data: 0xfd, 0x08
007A42  ; data: 0xfd, 0x08
007A44  ; data: 0xfd, 0x08
007A46  dc.w   $fd30
007A48  dc.w   $fd58
007A4A  ; data: 0xfd, 0x80
007A4C  ; data: 0xfd, 0xd0
007A4E  dc.w   $fe20
007A50  dc.w   $fe70
007A52  dc.w   $fec0
007A54  dc.w   $ff38
007A56  ; data: 0xff, 0x88
007A58  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007A66  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007A74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007A82  move.b $1db01db0(d1.l * 4), (d1.l * 4)
007A8C  ; data: 0xff, 0x88
007A8E  dc.w   $ff38
007A90  dc.w   $fee8
007A92  dc.w   $fe98
007A94  dc.w   $fe48
007A96  dc.w   $fe20
007A98  ; data: 0xfd, 0xd0
007A9A  ; data: 0xfd, 0xa8
007A9C  ; data: 0xfd, 0x80
007A9E  dc.w   $fd30
007AA0  ; data: 0xfd, 0x08
007AA2  ; data: 0xfd, 0x08
007AA4  dc.w   $fce0
007AA6  dc.w   $fce0
007AA8  dc.w   $fce0
007AAA  ; data: 0xfd, 0x08
007AAC  dc.w   $fd30
007AAE  dc.w   $fd58
007AB0  ; data: 0xfd, 0xa8
007AB2  ; data: 0xfd, 0xf8
007AB4  dc.w   $fe48
007AB6  dc.w   $fec0
007AB8  dc.w   $ff10
007ABA  ; data: 0xff, 0x88
007ABC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007ACA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007AD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007AE6  move.b $1db01db0(d1.l * 4), (d1.l * 4)
007AF0  ; data: 0xff, 0x88
007AF2  dc.w   $ff38
007AF4  dc.w   $fec0
007AF6  dc.w   $fe98
007AF8  dc.w   $fe48
007AFA  ; data: 0xfd, 0xf8
007AFC  ; data: 0xfd, 0xd0
007AFE  ; data: 0xfd, 0xa8
007B00  dc.w   $fd58
007B02  dc.w   $fd30
007B04  ; data: 0xfd, 0x08
007B06  dc.w   $fce0
007B08  dc.w   $fcb8
007B0A  dc.w   $fcb8
007B0C  dc.w   $fcb8
007B0E  dc.w   $fce0
007B10  ; data: 0xfd, 0x08
007B12  dc.w   $fd30
007B14  ; data: 0xfd, 0x80
007B16  ; data: 0xfd, 0xd0
007B18  dc.w   $fe20
007B1A  dc.w   $fe98
007B1C  dc.w   $ff10
007B1E  ; data: 0xff, 0x88
007B20  ; data: 0x1d, 0x88
007B22  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007B30  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007B3E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007B4C  move.b $1db01d88(d1.l * 4), (a7.l * 8)
007B56  dc.w   $ff10
007B58  dc.w   $fec0
007B5A  dc.w   $fe70
007B5C  dc.w   $fe48
007B5E  ; data: 0xfd, 0xf8
007B60  ; data: 0xfd, 0xd0
007B62  ; data: 0xfd, 0xa8
007B64  dc.w   $fd58
007B66  dc.w   $fd30
007B68  ; data: 0xfd, 0x08
007B6A  dc.w   $fcb8
007B6C  dc.w   $fcb8
007B6E  dc.w   $fc90
007B70  dc.w   $fc90
007B72  dc.w   $fc90
007B74  dc.w   $fcb8
007B76  ; data: 0xfd, 0x08
007B78  dc.w   $fd58
007B7A  ; data: 0xfd, 0xa8
007B7C  dc.w   $fe20
007B7E  dc.w   $fe98
007B80  dc.w   $fee8
007B82  ; data: 0xff, 0x60
007B84  ; data: 0x1d, 0x88
007B86  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007B94  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007BA2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007BB0  move.b $1db01d88(d1.l * 4), $ff10(a6, invalid.w)
007BBC  dc.w   $fec0
007BBE  dc.w   $fe70
007BC0  dc.w   $fe20
007BC2  ; data: 0xfd, 0xf8
007BC4  ; data: 0xfd, 0xd0
007BC6  ; data: 0xfd, 0xa8
007BC8  dc.w   $fd58
007BCA  dc.w   $fd30
007BCC  dc.w   $fce0
007BCE  dc.w   $fcb8
007BD0  dc.w   $fc90
007BD2  dc.w   $fc68
007BD4  dc.w   $fc68
007BD6  dc.w   $fc68
007BD8  dc.w   $fc90
007BDA  dc.w   $fce0
007BDC  dc.w   $fd30
007BDE  ; data: 0xfd, 0xa8
007BE0  dc.w   $fe20
007BE2  dc.w   $fe70
007BE4  dc.w   $fee8
007BE6  ; data: 0xff, 0x60
007BE8  ; data: 0x1d, 0x88
007BEA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007BF8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007C06  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007C14  move.b $1db01d88(d1.l * 4), $fee8(a6, invalid.w)
007C20  dc.w   $fe98
007C22  dc.w   $fe48
007C24  dc.w   $fe20
007C26  ; data: 0xfd, 0xf8
007C28  ; data: 0xfd, 0xd0
007C2A  ; data: 0xfd, 0xa8
007C2C  dc.w   $fd58
007C2E  dc.w   $fd30
007C30  dc.w   $fce0
007C32  dc.w   $fc90
007C34  dc.w   $fc68
007C36  dc.w   $fc40
007C38  dc.w   $fc18
007C3A  dc.w   $fc18
007C3C  dc.w   $fc68
007C3E  dc.w   $fcb8
007C40  ; data: 0xfd, 0x08
007C42  ; data: 0xfd, 0x80
007C44  ; data: 0xfd, 0xf8
007C46  dc.w   $fe70
007C48  dc.w   $fee8
007C4A  ; data: 0xff, 0x60
007C4C  move.b -(a0), $1db0(a6)
007C50  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007C5E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007C6C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007C7A  move.b $1d88ff60(d1.l * 4), -$18(a6, a7.l)
007C84  dc.w   $fe70
007C86  dc.w   $fe48
007C88  ; data: 0xfd, 0xf8
007C8A  ; data: 0xfd, 0xf8
007C8C  ; data: 0xfd, 0xd0
007C8E  ; data: 0xfd, 0xa8
007C90  dc.w   $fd58
007C92  dc.w   $fd30
007C94  dc.w   $fce0
007C96  dc.w   $fc90
007C98  dc.w   $fc40
007C9A  ; data: 0xfb, 0xf0
007C9C  ; data: 0xfb, 0xf0
007C9E  ; data: 0xfb, 0xf0
007CA0  dc.w   $fc18
007CA2  dc.w   $fc68
007CA4  dc.w   $fce0
007CA6  dc.w   $fd58
007CA8  ; data: 0xfd, 0xf8
007CAA  dc.w   $fe70
007CAC  dc.w   $fee8
007CAE  ; data: 0xff, 0x60
007CB0  move.b -(a0), $1db0(a6)
007CB4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007CC2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007CD0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007CDE  move.b $1d88ff38(d1.l * 4), -$40(a6, a7.l)
007CE8  dc.w   $fe70
007CEA  dc.w   $fe20
007CEC  ; data: 0xfd, 0xf8
007CEE  ; data: 0xfd, 0xd0
007CF0  ; data: 0xfd, 0xd0
007CF2  ; data: 0xfd, 0xa8
007CF4  ; data: 0xfd, 0x80
007CF6  dc.w   $fd30
007CF8  dc.w   $fcb8
007CFA  dc.w   $fc68
007CFC  dc.w   $fc18
007CFE  ; data: 0xfb, 0xc8
007D00  ; data: 0xfb, 0xa0
007D02  ; data: 0xfb, 0xa0
007D04  ; data: 0xfb, 0xc8
007D06  dc.w   $fc40
007D08  dc.w   $fcb8
007D0A  dc.w   $fd58
007D0C  ; data: 0xfd, 0xd0
007D0E  dc.w   $fe70
007D10  dc.w   $fee8
007D12  ; data: 0xff, 0x60
007D14  ; data: 0xff, 0xb0
007D16  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007D24  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007D32  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007D40  move.b $1db01d88(d1.l * 4), $fec0fe48(a6, a7.l * 8)
007D4E  ; data: 0xfd, 0xf8
007D50  ; data: 0xfd, 0xf8
007D52  ; data: 0xfd, 0xd0
007D54  ; data: 0xfd, 0xd0
007D56  ; data: 0xfd, 0xa8
007D58  ; data: 0xfd, 0x80
007D5A  dc.w   $fd30
007D5C  dc.w   $fcb8
007D5E  dc.w   $fc40
007D60  ; data: 0xfb, 0xf0
007D62  ; data: 0xfb, 0xa0
007D64  dc.w   $fb50
007D66  dc.w   $fb50
007D68  ; data: 0xfb, 0xa0
007D6A  dc.w   $fc18
007D6C  dc.w   $fc90
007D6E  dc.w   $fd30
007D70  ; data: 0xfd, 0xd0
007D72  dc.w   $fe70
007D74  dc.w   $fee8
007D76  ; data: 0xff, 0x60
007D78  ; data: 0xff, 0xb0
007D7A  ; data: 0x1d, 0x88
007D7C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007D8A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007D98  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007DA6  move.b $1d88ff10(d1.l * 4), -$68(a6, a7.l)
007DB0  dc.w   $fe20
007DB2  ; data: 0xfd, 0xf8
007DB4  ; data: 0xfd, 0xd0
007DB6  ; data: 0xfd, 0xd0
007DB8  ; data: 0xfd, 0xd0
007DBA  ; data: 0xfd, 0xa8
007DBC  ; data: 0xfd, 0x80
007DBE  dc.w   $fd30
007DC0  dc.w   $fcb8
007DC2  dc.w   $fc40
007DC4  ; data: 0xfb, 0xc8
007DC6  dc.w   $fb50
007DC8  dc.w   $fb28
007DCA  dc.w   $fb28
007DCC  dc.w   $fb50
007DCE  ; data: 0xfb, 0xc8
007DD0  dc.w   $fc68
007DD2  ; data: 0xfd, 0x08
007DD4  ; data: 0xfd, 0xd0
007DD6  dc.w   $fe70
007DD8  dc.w   $fee8
007DDA  ; data: 0xff, 0x60
007DDC  ; data: 0xff, 0x88
007DDE  ; data: 0x1d, 0x88
007DE0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007DEE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007DFC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007E0A  move.b $1d88ff10(d1.l * 4), $70(a6, a7.l)
007E14  ; data: 0xfd, 0xf8
007E16  ; data: 0xfd, 0xd0
007E18  ; data: 0xfd, 0xd0
007E1A  ; data: 0xfd, 0xd0
007E1C  ; data: 0xfd, 0xd0
007E1E  ; data: 0xfd, 0xd0
007E20  ; data: 0xfd, 0xa8
007E22  dc.w   $fd30
007E24  dc.w   $fcb8
007E26  dc.w   $fc18
007E28  ; data: 0xfb, 0xa0
007E2A  dc.w   $fb28
007E2C  dc.w   $fad8
007E2E  dc.w   $fad8
007E30  ; data: 0xfb, 0x00
007E32  ; data: 0xfb, 0xa0
007E34  dc.w   $fc40
007E36  ; data: 0xfd, 0x08
007E38  ; data: 0xfd, 0xd0
007E3A  dc.w   $fe70
007E3C  dc.w   $fee8
007E3E  ; data: 0xff, 0x60
007E40  ; data: 0xff, 0x88
007E42  move.b -(a0), $1db0(a6)
007E46  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007E54  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007E62  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007E70  move.b (d1.l * 4), -$18(a6, a7.l)
007E76  dc.w   $fe48
007E78  ; data: 0xfd, 0xf8
007E7A  ; data: 0xfd, 0xa8
007E7C  ; data: 0xfd, 0xa8
007E7E  ; data: 0xfd, 0xd0
007E80  ; data: 0xfd, 0xd0
007E82  ; data: 0xfd, 0xd0
007E84  ; data: 0xfd, 0xa8
007E86  dc.w   $fd30
007E88  dc.w   $fcb8
007E8A  dc.w   $fc18
007E8C  dc.w   $fb78
007E8E  dc.w   $fad8
007E90  dc.w   $fa88
007E92  dc.w   $fa88
007E94  dc.w   $fad8
007E96  dc.w   $fb50
007E98  dc.w   $fc18
007E9A  dc.w   $fce0
007E9C  ; data: 0xfd, 0xd0
007E9E  dc.w   $fe70
007EA0  dc.w   $fee8
007EA2  ; data: 0xff, 0x60
007EA4  ; data: 0xff, 0x88
007EA6  ; data: 0xff, 0xb0
007EA8  ; data: 0x1d, 0x88
007EAA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007EB8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007EC6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007ED4  move.b (d1.l * 4), -$18(a6, a7.l)
007EDA  dc.w   $fe48
007EDC  ; data: 0xfd, 0xd0
007EDE  ; data: 0xfd, 0xa8
007EE0  ; data: 0xfd, 0xa8
007EE2  ; data: 0xfd, 0xd0
007EE4  ; data: 0xfd, 0xd0
007EE6  ; data: 0xfd, 0xd0
007EE8  ; data: 0xfd, 0xa8
007EEA  dc.w   $fd58
007EEC  dc.w   $fcb8
007EEE  ; data: 0xfb, 0xf0
007EF0  dc.w   $fb50
007EF2  dc.w   $fab0
007EF4  dc.w   $fa38
007EF6  dc.w   $fa38
007EF8  dc.w   $fa88
007EFA  dc.w   $fb28
007EFC  ; data: 0xfb, 0xf0
007EFE  dc.w   $fce0
007F00  ; data: 0xfd, 0xa8
007F02  dc.w   $fe70
007F04  dc.w   $ff10
007F06  ; data: 0xff, 0x60
007F08  ; data: 0xff, 0x88
007F0A  ; data: 0xff, 0x88
007F0C  move.b -(a0), $1db0(a6)
007F10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007F1E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007F2C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007F3A  ; data: 0x1d, 0x88
007F3C  dc.w   $fec0
007F3E  dc.w   $fe20
007F40  ; data: 0xfd, 0xa8
007F42  ; data: 0xfd, 0x80
007F44  ; data: 0xfd, 0x80
007F46  ; data: 0xfd, 0xa8
007F48  ; data: 0xfd, 0xf8
007F4A  ; data: 0xfd, 0xf8
007F4C  ; data: 0xfd, 0xd0
007F4E  dc.w   $fd58
007F50  dc.w   $fcb8
007F52  ; data: 0xfb, 0xf0
007F54  dc.w   $fb28
007F56  dc.w   $fa60
007F58  dc.w   $fa10
007F5A  ; data: 0xf9, 0xe8
007F5C  dc.w   $fa38
007F5E  dc.w   $fad8
007F60  ; data: 0xfb, 0xc8
007F62  dc.w   $fcb8
007F64  ; data: 0xfd, 0xa8
007F66  dc.w   $fe70
007F68  dc.w   $ff10
007F6A  ; data: 0xff, 0x60
007F6C  ; data: 0xff, 0x88
007F6E  ; data: 0xff, 0x88
007F70  ; data: 0xff, 0x88
007F72  ; data: 0x1d, 0x88
007F74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007F82  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007F90  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007F9E  ; data: 0x1d, 0x88
007FA0  dc.w   $fec0
007FA2  ; data: 0xfd, 0xf8
007FA4  ; data: 0xfd, 0x80
007FA6  dc.w   $fd58
007FA8  ; data: 0xfd, 0x80
007FAA  ; data: 0xfd, 0xa8
007FAC  ; data: 0xfd, 0xf8
007FAE  ; data: 0xfd, 0xf8
007FB0  ; data: 0xfd, 0xd0
007FB2  dc.w   $fd58
007FB4  dc.w   $fcb8
007FB6  ; data: 0xfb, 0xc8
007FB8  ; data: 0xfb, 0x00
007FBA  dc.w   $fa38
007FBC  ; data: 0xf9, 0xc0
007FBE  ; data: 0xf9, 0x98
007FC0  dc.w   $fa10
007FC2  dc.w   $fab0
007FC4  ; data: 0xfb, 0xa0
007FC6  dc.w   $fcb8
007FC8  ; data: 0xfd, 0xa8
007FCA  dc.w   $fe70
007FCC  dc.w   $ff10
007FCE  ; data: 0xff, 0x60
007FD0  ; data: 0xff, 0x88
007FD2  ; data: 0xff, 0x60
007FD4  ; data: 0xff, 0x88
007FD6  ; data: 0xff, 0xb0
007FD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007FE6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
007FF4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008002  move.b -(a0), -$140(a6)
008006  ; data: 0xfd, 0xd0
008008  dc.w   $fd58
00800A  dc.w   $fd58
00800C  dc.w   $fd58
00800E  ; data: 0xfd, 0xa8
008010  ; data: 0xfd, 0xf8
008012  dc.w   $fe20
008014  ; data: 0xfd, 0xd0
008016  dc.w   $fd58
008018  dc.w   $fc90
00801A  ; data: 0xfb, 0xc8
00801C  dc.w   $fab0
00801E  ; data: 0xf9, 0xe8
008020  dc.w   $f970
008022  dc.w   $f970
008024  ; data: 0xf9, 0xc0
008026  dc.w   $fa60
008028  dc.w   $fb78
00802A  dc.w   $fc90
00802C  ; data: 0xfd, 0xa8
00802E  dc.w   $fe70
008030  dc.w   $ff10
008032  ; data: 0xff, 0x60
008034  ; data: 0xff, 0x60
008036  ; data: 0xff, 0x60
008038  ; data: 0xff, 0x60
00803A  ; data: 0xff, 0x88
00803C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00804A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008058  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008066  move.b -(a0), -$168(a6)
00806A  ; data: 0xfd, 0xd0
00806C  dc.w   $fd58
00806E  dc.w   $fd30
008070  dc.w   $fd58
008072  ; data: 0xfd, 0xa8
008074  ; data: 0xfd, 0xf8
008076  dc.w   $fe20
008078  ; data: 0xfd, 0xf8
00807A  dc.w   $fd58
00807C  dc.w   $fc90
00807E  ; data: 0xfb, 0xa0
008080  dc.w   $fa88
008082  ; data: 0xf9, 0xc0
008084  ; data: 0xf9, 0x48
008086  dc.w   $f920
008088  dc.w   $f970
00808A  dc.w   $fa38
00808C  dc.w   $fb50
00808E  dc.w   $fc68
008090  ; data: 0xfd, 0xa8
008092  dc.w   $fe70
008094  dc.w   $ff10
008096  ; data: 0xff, 0x60
008098  ; data: 0xff, 0x60
00809A  dc.w   $ff38
00809C  dc.w   $ff38
00809E  ; data: 0xff, 0x60
0080A0  ; data: 0x1d, 0x88
0080A2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0080B0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0080BE  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
0080CC  dc.w   $fe98
0080CE  ; data: 0xfd, 0xa8
0080D0  dc.w   $fd30
0080D2  ; data: 0xfd, 0x08
0080D4  dc.w   $fd58
0080D6  ; data: 0xfd, 0xa8
0080D8  ; data: 0xfd, 0xf8
0080DA  dc.w   $fe20
0080DC  ; data: 0xfd, 0xf8
0080DE  ; data: 0xfd, 0x80
0080E0  dc.w   $fc90
0080E2  dc.w   $fb78
0080E4  dc.w   $fa60
0080E6  ; data: 0xf9, 0x98
0080E8  dc.w   $f8f8
0080EA  dc.w   $f8d0
0080EC  ; data: 0xf9, 0x48
0080EE  dc.w   $fa10
0080F0  dc.w   $fb28
0080F2  dc.w   $fc68
0080F4  ; data: 0xfd, 0x80
0080F6  dc.w   $fe70
0080F8  dc.w   $ff10
0080FA  ; data: 0xff, 0x60
0080FC  ; data: 0xff, 0x60
0080FE  dc.w   $ff38
008100  dc.w   $ff10
008102  dc.w   $ff38
008104  ; data: 0xff, 0xb0
008106  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008114  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008122  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
008130  dc.w   $fe70
008132  ; data: 0xfd, 0x80
008134  ; data: 0xfd, 0x08
008136  ; data: 0xfd, 0x08
008138  dc.w   $fd30
00813A  ; data: 0xfd, 0xa8
00813C  ; data: 0xfd, 0xf8
00813E  dc.w   $fe20
008140  ; data: 0xfd, 0xf8
008142  ; data: 0xfd, 0x80
008144  dc.w   $fc90
008146  dc.w   $fb78
008148  dc.w   $fa38
00814A  ; data: 0xf9, 0x48
00814C  dc.w   $f8a8
00814E  dc.w   $f880
008150  dc.w   $f8f8
008152  ; data: 0xf9, 0xc0
008154  ; data: 0xfb, 0x00
008156  dc.w   $fc40
008158  ; data: 0xfd, 0x80
00815A  dc.w   $fe70
00815C  dc.w   $ff10
00815E  ; data: 0xff, 0x60
008160  ; data: 0xff, 0x60
008162  dc.w   $ff10
008164  dc.w   $fee8
008166  dc.w   $ff10
008168  ; data: 0xff, 0x88
00816A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008178  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008186  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
008194  dc.w   $fe70
008196  ; data: 0xfd, 0x80
008198  ; data: 0xfd, 0x08
00819A  dc.w   $fce0
00819C  dc.w   $fd30
00819E  ; data: 0xfd, 0xa8
0081A0  ; data: 0xfd, 0xf8
0081A2  dc.w   $fe20
0081A4  ; data: 0xfd, 0xf8
0081A6  ; data: 0xfd, 0x80
0081A8  dc.w   $fc90
0081AA  dc.w   $fb50
0081AC  dc.w   $fa38
0081AE  dc.w   $f920
0081B0  dc.w   $f880
0081B2  dc.w   $f858
0081B4  dc.w   $f8a8
0081B6  ; data: 0xf9, 0x98
0081B8  dc.w   $fad8
0081BA  dc.w   $fc18
0081BC  ; data: 0xfd, 0x80
0081BE  dc.w   $fe70
0081C0  dc.w   $ff10
0081C2  ; data: 0xff, 0x60
0081C4  dc.w   $ff38
0081C6  dc.w   $ff10
0081C8  dc.w   $fee8
0081CA  dc.w   $fee8
0081CC  ; data: 0xff, 0x60
0081CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0081DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0081EA  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
0081F8  dc.w   $fe70
0081FA  ; data: 0xfd, 0x80
0081FC  dc.w   $fce0
0081FE  dc.w   $fce0
008200  dc.w   $fd30
008202  ; data: 0xfd, 0x80
008204  ; data: 0xfd, 0xf8
008206  dc.w   $fe48
008208  ; data: 0xfd, 0xf8
00820A  ; data: 0xfd, 0x80
00820C  dc.w   $fc68
00820E  dc.w   $fb50
008210  dc.w   $fa10
008212  dc.w   $f8f8
008214  dc.w   $f830
008216  dc.w   $f808
008218  dc.w   $f880
00821A  dc.w   $f970
00821C  dc.w   $fab0
00821E  dc.w   $fc18
008220  dc.w   $fd58
008222  dc.w   $fe70
008224  dc.w   $ff10
008226  ; data: 0xff, 0x60
008228  dc.w   $ff38
00822A  dc.w   $fee8
00822C  dc.w   $fec0
00822E  dc.w   $fec0
008230  dc.w   $ff38
008232  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008240  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00824E  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
00825C  dc.w   $fe70
00825E  dc.w   $fd58
008260  dc.w   $fce0
008262  dc.w   $fcb8
008264  ; data: 0xfd, 0x08
008266  ; data: 0xfd, 0x80
008268  ; data: 0xfd, 0xf8
00826A  dc.w   $fe48
00826C  ; data: 0xfd, 0xf8
00826E  ; data: 0xfd, 0x80
008270  dc.w   $fc68
008272  dc.w   $fb28
008274  ; data: 0xf9, 0xe8
008276  dc.w   $f8d0
008278  dc.w   $f808
00827A  ; data: 0xf7, 0xe0
00827C  dc.w   $f858
00827E  ; data: 0xf9, 0x48
008280  dc.w   $fa88
008282  ; data: 0xfb, 0xf0
008284  dc.w   $fd58
008286  dc.w   $fe70
008288  dc.w   $ff10
00828A  dc.w   $ff38
00828C  dc.w   $ff38
00828E  dc.w   $fee8
008290  dc.w   $fe98
008292  dc.w   $fe98
008294  dc.w   $ff10
008296  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0082A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0082B2  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
0082C0  dc.w   $fe70
0082C2  dc.w   $fd58
0082C4  dc.w   $fcb8
0082C6  dc.w   $fcb8
0082C8  ; data: 0xfd, 0x08
0082CA  ; data: 0xfd, 0x80
0082CC  ; data: 0xfd, 0xf8
0082CE  dc.w   $fe48
0082D0  ; data: 0xfd, 0xf8
0082D2  dc.w   $fd58
0082D4  dc.w   $fc68
0082D6  ; data: 0xfb, 0x00
0082D8  ; data: 0xf9, 0xc0
0082DA  dc.w   $f8a8
0082DC  ; data: 0xf7, 0xe0
0082DE  ; data: 0xf7, 0xb8
0082E0  dc.w   $f808
0082E2  dc.w   $f920
0082E4  dc.w   $fa60
0082E6  ; data: 0xfb, 0xc8
0082E8  dc.w   $fd30
0082EA  dc.w   $fe48
0082EC  dc.w   $fee8
0082EE  dc.w   $ff38
0082F0  dc.w   $ff10
0082F2  dc.w   $fec0
0082F4  dc.w   $fe98
0082F6  dc.w   $fe98
0082F8  dc.w   $ff10
0082FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008308  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008316  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
008324  dc.w   $fe70
008326  dc.w   $fd58
008328  dc.w   $fcb8
00832A  dc.w   $fcb8
00832C  ; data: 0xfd, 0x08
00832E  ; data: 0xfd, 0x80
008330  ; data: 0xfd, 0xf8
008332  dc.w   $fe20
008334  ; data: 0xfd, 0xf8
008336  dc.w   $fd58
008338  dc.w   $fc40
00833A  ; data: 0xfb, 0x00
00833C  ; data: 0xf9, 0x98
00833E  dc.w   $f858
008340  ; data: 0xf7, 0xb8
008342  ; data: 0xf7, 0x90
008344  ; data: 0xf7, 0xe0
008346  dc.w   $f8d0
008348  dc.w   $fa38
00834A  ; data: 0xfb, 0xc8
00834C  dc.w   $fd30
00834E  dc.w   $fe48
008350  dc.w   $fee8
008352  dc.w   $ff38
008354  dc.w   $ff10
008356  dc.w   $fec0
008358  dc.w   $fe70
00835A  dc.w   $fe70
00835C  dc.w   $fee8
00835E  ; data: 0x1d, 0x88
008360  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00836E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00837C  move.b $1db01db0(d1.l * 4), $1d88fe70(d1.l * 4)
00838A  dc.w   $fd58
00838C  dc.w   $fcb8
00838E  dc.w   $fcb8
008390  ; data: 0xfd, 0x08
008392  ; data: 0xfd, 0x80
008394  ; data: 0xfd, 0xf8
008396  dc.w   $fe20
008398  ; data: 0xfd, 0xf8
00839A  dc.w   $fd58
00839C  dc.w   $fc40
00839E  dc.w   $fad8
0083A0  dc.w   $f970
0083A2  dc.w   $f858
0083A4  ; data: 0xf7, 0x90
0083A6  ; data: 0xf7, 0x40
0083A8  ; data: 0xf7, 0xb8
0083AA  dc.w   $f8a8
0083AC  dc.w   $fa10
0083AE  ; data: 0xfb, 0xa0
0083B0  ; data: 0xfd, 0x08
0083B2  dc.w   $fe20
0083B4  dc.w   $fee8
0083B6  dc.w   $ff10
0083B8  dc.w   $fee8
0083BA  dc.w   $fe98
0083BC  dc.w   $fe70
0083BE  dc.w   $fe70
0083C0  dc.w   $fee8
0083C2  ; data: 0x1d, 0x88
0083C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0083D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0083E0  move.b $1db01db0(d1.l * 4), $1db0fe70(d1.l * 4)
0083EE  dc.w   $fd58
0083F0  dc.w   $fcb8
0083F2  dc.w   $fc90
0083F4  dc.w   $fce0
0083F6  ; data: 0xfd, 0x80
0083F8  ; data: 0xfd, 0xf8
0083FA  dc.w   $fe20
0083FC  ; data: 0xfd, 0xf8
0083FE  dc.w   $fd30
008400  dc.w   $fc18
008402  dc.w   $fab0
008404  ; data: 0xf9, 0x48
008406  dc.w   $f830
008408  dc.w   $f768
00840A  ; data: 0xf7, 0x18
00840C  ; data: 0xf7, 0x90
00840E  dc.w   $f8a8
008410  ; data: 0xf9, 0xe8
008412  dc.w   $fb78
008414  dc.w   $fce0
008416  ; data: 0xfd, 0xf8
008418  dc.w   $fec0
00841A  dc.w   $ff10
00841C  dc.w   $fee8
00841E  dc.w   $fe98
008420  dc.w   $fe48
008422  dc.w   $fe48
008424  dc.w   $fec0
008426  ; data: 0x1d, 0x88
008428  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008436  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008444  move.b $1db01db0(d1.l * 4), $1db0fe70(d1.l * 4)
008452  dc.w   $fd58
008454  dc.w   $fcb8
008456  dc.w   $fc90
008458  dc.w   $fce0
00845A  dc.w   $fd58
00845C  ; data: 0xfd, 0xd0
00845E  ; data: 0xfd, 0xf8
008460  ; data: 0xfd, 0xd0
008462  dc.w   $fd30
008464  dc.w   $fc18
008466  dc.w   $fab0
008468  ; data: 0xf9, 0x48
00846A  dc.w   $f808
00846C  ; data: 0xf7, 0x40
00846E  ; data: 0xf7, 0x18
008470  dc.w   $f768
008472  dc.w   $f880
008474  ; data: 0xf9, 0xc0
008476  dc.w   $fb50
008478  dc.w   $fcb8
00847A  ; data: 0xfd, 0xf8
00847C  dc.w   $fe98
00847E  dc.w   $fee8
008480  dc.w   $fec0
008482  dc.w   $fe70
008484  dc.w   $fe48
008486  dc.w   $fe48
008488  dc.w   $fec0
00848A  ; data: 0x1d, 0x88
00848C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00849A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0084A8  move.b $1db01db0(d1.l * 4), $1db0fe98(d1.l * 4)
0084B6  dc.w   $fd58
0084B8  dc.w   $fcb8
0084BA  dc.w   $fcb8
0084BC  dc.w   $fce0
0084BE  dc.w   $fd58
0084C0  ; data: 0xfd, 0xd0
0084C2  ; data: 0xfd, 0xf8
0084C4  ; data: 0xfd, 0xd0
0084C6  ; data: 0xfd, 0x08
0084C8  ; data: 0xfb, 0xf0
0084CA  dc.w   $fa88
0084CC  dc.w   $f920
0084CE  ; data: 0xf7, 0xe0
0084D0  ; data: 0xf7, 0x18
0084D2  dc.w   $f6f0
0084D4  dc.w   $f768
0084D6  dc.w   $f858
0084D8  ; data: 0xf9, 0xc0
0084DA  dc.w   $fb28
0084DC  dc.w   $fcb8
0084DE  ; data: 0xfd, 0xd0
0084E0  dc.w   $fe70
0084E2  dc.w   $fec0
0084E4  dc.w   $fec0
0084E6  dc.w   $fe70
0084E8  dc.w   $fe48
0084EA  dc.w   $fe48
0084EC  dc.w   $fec0
0084EE  ; data: 0x1d, 0x88
0084F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0084FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00850C  move.b $1db01db0(d1.l * 4), $1db0fe98(d1.l * 4)
00851A  ; data: 0xfd, 0x80
00851C  dc.w   $fce0
00851E  dc.w   $fcb8
008520  dc.w   $fce0
008522  dc.w   $fd58
008524  ; data: 0xfd, 0xa8
008526  ; data: 0xfd, 0xd0
008528  ; data: 0xfd, 0xa8
00852A  dc.w   $fce0
00852C  ; data: 0xfb, 0xc8
00852E  dc.w   $fa60
008530  dc.w   $f8f8
008532  ; data: 0xf7, 0xe0
008534  ; data: 0xf7, 0x18
008536  dc.w   $f6c8
008538  ; data: 0xf7, 0x40
00853A  dc.w   $f830
00853C  ; data: 0xf9, 0x98
00853E  dc.w   $fb28
008540  dc.w   $fc90
008542  ; data: 0xfd, 0xa8
008544  dc.w   $fe70
008546  dc.w   $fe98
008548  dc.w   $fe98
00854A  dc.w   $fe70
00854C  dc.w   $fe20
00854E  dc.w   $fe48
008550  dc.w   $fec0
008552  ; data: 0x1d, 0x88
008554  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008562  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008570  move.b $1db01db0(d1.l * 4), $1db0fe98(d1.l * 4)
00857E  ; data: 0xfd, 0x80
008580  dc.w   $fce0
008582  dc.w   $fcb8
008584  dc.w   $fce0
008586  dc.w   $fd58
008588  ; data: 0xfd, 0xa8
00858A  ; data: 0xfd, 0xd0
00858C  ; data: 0xfd, 0x80
00858E  dc.w   $fcb8
008590  ; data: 0xfb, 0xa0
008592  dc.w   $fa60
008594  dc.w   $f8f8
008596  ; data: 0xf7, 0xb8
008598  dc.w   $f6f0
00859A  dc.w   $f6c8
00859C  ; data: 0xf7, 0x18
00859E  dc.w   $f830
0085A0  dc.w   $f970
0085A2  ; data: 0xfb, 0x00
0085A4  dc.w   $fc68
0085A6  ; data: 0xfd, 0x80
0085A8  dc.w   $fe48
0085AA  dc.w   $fe98
0085AC  dc.w   $fe70
0085AE  dc.w   $fe48
0085B0  dc.w   $fe20
0085B2  dc.w   $fe48
0085B4  dc.w   $fec0
0085B6  ; data: 0x1d, 0x88
0085B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0085C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0085D4  move.b $1db01db0(d1.l * 4), $1db0fec0(d1.l * 4)
0085E2  ; data: 0xfd, 0xa8
0085E4  dc.w   $fce0
0085E6  dc.w   $fcb8
0085E8  dc.w   $fce0
0085EA  dc.w   $fd30
0085EC  ; data: 0xfd, 0xa8
0085EE  ; data: 0xfd, 0xa8
0085F0  dc.w   $fd58
0085F2  dc.w   $fcb8
0085F4  dc.w   $fb78
0085F6  dc.w   $fa38
0085F8  dc.w   $f8d0
0085FA  ; data: 0xf7, 0xb8
0085FC  dc.w   $f6f0
0085FE  dc.w   $f6a0
008600  ; data: 0xf7, 0x18
008602  dc.w   $f808
008604  ; data: 0xf9, 0x48
008606  dc.w   $fad8
008608  dc.w   $fc40
00860A  dc.w   $fd58
00860C  dc.w   $fe20
00860E  dc.w   $fe70
008610  dc.w   $fe70
008612  dc.w   $fe48
008614  dc.w   $fe20
008616  dc.w   $fe48
008618  dc.w   $fec0
00861A  ; data: 0x1d, 0x88
00861C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00862A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008638  move.b $1db01db0(d1.l * 4), $1db0fee8(d1.l * 4)
008646  ; data: 0xfd, 0xa8
008648  ; data: 0xfd, 0x08
00864A  dc.w   $fce0
00864C  dc.w   $fce0
00864E  dc.w   $fd30
008650  ; data: 0xfd, 0x80
008652  ; data: 0xfd, 0x80
008654  dc.w   $fd30
008656  dc.w   $fc90
008658  dc.w   $fb78
00865A  dc.w   $fa10
00865C  dc.w   $f8a8
00865E  ; data: 0xf7, 0x90
008660  dc.w   $f6c8
008662  dc.w   $f6a0
008664  ; data: 0xf7, 0x18
008666  ; data: 0xf7, 0xe0
008668  ; data: 0xf9, 0x48
00866A  dc.w   $fab0
00866C  ; data: 0xfb, 0xf0
00866E  dc.w   $fd30
008670  ; data: 0xfd, 0xd0
008672  dc.w   $fe48
008674  dc.w   $fe48
008676  dc.w   $fe20
008678  dc.w   $fe20
00867A  dc.w   $fe48
00867C  dc.w   $fee8
00867E  ; data: 0x1d, 0x88
008680  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00868E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00869C  move.b $1db01db0(d1.l * 4), $1db0fee8(d1.l * 4)
0086AA  ; data: 0xfd, 0xd0
0086AC  dc.w   $fd30
0086AE  dc.w   $fce0
0086B0  dc.w   $fce0
0086B2  dc.w   $fd30
0086B4  dc.w   $fd58
0086B6  dc.w   $fd58
0086B8  ; data: 0xfd, 0x08
0086BA  dc.w   $fc68
0086BC  dc.w   $fb50
0086BE  ; data: 0xf9, 0xe8
0086C0  dc.w   $f8a8
0086C2  ; data: 0xf7, 0x90
0086C4  dc.w   $f6c8
0086C6  dc.w   $f6a0
0086C8  dc.w   $f6f0
0086CA  ; data: 0xf7, 0xe0
0086CC  dc.w   $f920
0086CE  dc.w   $fa88
0086D0  ; data: 0xfb, 0xc8
0086D2  dc.w   $fce0
0086D4  ; data: 0xfd, 0xa8
0086D6  dc.w   $fe20
0086D8  dc.w   $fe20
0086DA  dc.w   $fe20
0086DC  dc.w   $fe20
0086DE  dc.w   $fe48
0086E0  dc.w   $fee8
0086E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0086F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0086FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00870C  dc.w   $ff10
00870E  ; data: 0xfd, 0xf8
008710  dc.w   $fd30
008712  dc.w   $fce0
008714  ; data: 0xfd, 0x08
008716  dc.w   $fd30
008718  dc.w   $fd58
00871A  dc.w   $fd30
00871C  dc.w   $fce0
00871E  dc.w   $fc18
008720  dc.w   $fb28
008722  ; data: 0xf9, 0xe8
008724  dc.w   $f880
008726  ; data: 0xf7, 0x90
008728  dc.w   $f6c8
00872A  dc.w   $f6a0
00872C  dc.w   $f6f0
00872E  ; data: 0xf7, 0xe0
008730  dc.w   $f8f8
008732  dc.w   $fa60
008734  ; data: 0xfb, 0xa0
008736  dc.w   $fcb8
008738  ; data: 0xfd, 0x80
00873A  ; data: 0xfd, 0xd0
00873C  ; data: 0xfd, 0xf8
00873E  ; data: 0xfd, 0xf8
008740  dc.w   $fe20
008742  dc.w   $fe48
008744  dc.w   $fee8
008746  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008754  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008762  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008770  dc.w   $ff38
008772  dc.w   $fe20
008774  dc.w   $fd58
008776  ; data: 0xfd, 0x08
008778  ; data: 0xfd, 0x08
00877A  ; data: 0xfd, 0x08
00877C  dc.w   $fd30
00877E  dc.w   $fd30
008780  dc.w   $fcb8
008782  ; data: 0xfb, 0xf0
008784  ; data: 0xfb, 0x00
008786  ; data: 0xf9, 0xc0
008788  dc.w   $f880
00878A  dc.w   $f768
00878C  dc.w   $f6c8
00878E  dc.w   $f6a0
008790  dc.w   $f6f0
008792  ; data: 0xf7, 0xb8
008794  dc.w   $f8f8
008796  dc.w   $fa38
008798  dc.w   $fb78
00879A  dc.w   $fc90
00879C  dc.w   $fd58
00879E  ; data: 0xfd, 0xa8
0087A0  ; data: 0xfd, 0xd0
0087A2  ; data: 0xfd, 0xf8
0087A4  dc.w   $fe20
0087A6  dc.w   $fe70
0087A8  dc.w   $ff10
0087AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0087B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0087C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0087D4  ; data: 0xff, 0x60
0087D6  dc.w   $fe48
0087D8  ; data: 0xfd, 0x80
0087DA  dc.w   $fd30
0087DC  ; data: 0xfd, 0x08
0087DE  ; data: 0xfd, 0x08
0087E0  ; data: 0xfd, 0x08
0087E2  dc.w   $fce0
0087E4  dc.w   $fc90
0087E6  ; data: 0xfb, 0xc8
0087E8  dc.w   $fad8
0087EA  ; data: 0xf9, 0x98
0087EC  dc.w   $f858
0087EE  dc.w   $f768
0087F0  dc.w   $f6c8
0087F2  dc.w   $f6a0
0087F4  dc.w   $f6f0
0087F6  ; data: 0xf7, 0xb8
0087F8  dc.w   $f8d0
0087FA  dc.w   $fa10
0087FC  dc.w   $fb50
0087FE  dc.w   $fc40
008800  ; data: 0xfd, 0x08
008802  ; data: 0xfd, 0x80
008804  ; data: 0xfd, 0xd0
008806  ; data: 0xfd, 0xd0
008808  dc.w   $fe20
00880A  dc.w   $fe70
00880C  dc.w   $ff38
00880E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00881C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00882A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008838  ; data: 0xff, 0x88
00883A  dc.w   $fe70
00883C  ; data: 0xfd, 0xa8
00883E  dc.w   $fd30
008840  ; data: 0xfd, 0x08
008842  ; data: 0xfd, 0x08
008844  ; data: 0xfd, 0x08
008846  dc.w   $fcb8
008848  dc.w   $fc68
00884A  ; data: 0xfb, 0xa0
00884C  dc.w   $fa88
00884E  dc.w   $f970
008850  dc.w   $f858
008852  dc.w   $f768
008854  dc.w   $f6c8
008856  dc.w   $f6a0
008858  dc.w   $f6f0
00885A  ; data: 0xf7, 0xb8
00885C  dc.w   $f8a8
00885E  ; data: 0xf9, 0xe8
008860  ; data: 0xfb, 0x00
008862  dc.w   $fc18
008864  dc.w   $fce0
008866  dc.w   $fd58
008868  ; data: 0xfd, 0xa8
00886A  ; data: 0xfd, 0xd0
00886C  dc.w   $fe20
00886E  dc.w   $fe70
008870  dc.w   $ff38
008872  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008880  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00888E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00889C  ; data: 0xff, 0xb0
00889E  dc.w   $fe98
0088A0  ; data: 0xfd, 0xd0
0088A2  dc.w   $fd58
0088A4  ; data: 0xfd, 0x08
0088A6  ; data: 0xfd, 0x08
0088A8  dc.w   $fce0
0088AA  dc.w   $fc90
0088AC  dc.w   $fc18
0088AE  dc.w   $fb78
0088B0  dc.w   $fa60
0088B2  ; data: 0xf9, 0x48
0088B4  dc.w   $f858
0088B6  dc.w   $f768
0088B8  dc.w   $f6c8
0088BA  dc.w   $f6a0
0088BC  dc.w   $f6f0
0088BE  ; data: 0xf7, 0x90
0088C0  dc.w   $f8a8
0088C2  ; data: 0xf9, 0xc0
0088C4  dc.w   $fad8
0088C6  ; data: 0xfb, 0xc8
0088C8  dc.w   $fc90
0088CA  dc.w   $fd30
0088CC  ; data: 0xfd, 0x80
0088CE  ; data: 0xfd, 0xd0
0088D0  dc.w   $fe20
0088D2  dc.w   $fe98
0088D4  ; data: 0xff, 0x60
0088D6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0088E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0088F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008900  ; data: 0x1d, 0x88
008902  dc.w   $fec0
008904  ; data: 0xfd, 0xf8
008906  ; data: 0xfd, 0x80
008908  dc.w   $fd30
00890A  dc.w   $fce0
00890C  dc.w   $fcb8
00890E  dc.w   $fc68
008910  ; data: 0xfb, 0xf0
008912  dc.w   $fb28
008914  dc.w   $fa38
008916  ; data: 0xf9, 0x48
008918  dc.w   $f830
00891A  dc.w   $f768
00891C  dc.w   $f6f0
00891E  dc.w   $f6c8
008920  dc.w   $f6f0
008922  ; data: 0xf7, 0x90
008924  dc.w   $f880
008926  ; data: 0xf9, 0x98
008928  dc.w   $fab0
00892A  ; data: 0xfb, 0xa0
00892C  dc.w   $fc68
00892E  dc.w   $fce0
008930  dc.w   $fd58
008932  ; data: 0xfd, 0xa8
008934  dc.w   $fe20
008936  dc.w   $fe98
008938  ; data: 0xff, 0x88
00893A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008948  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008956  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008964  move.b -$18(a0, a7.l), $20(a6, a7.l)
00896A  ; data: 0xfd, 0x80
00896C  dc.w   $fd30
00896E  dc.w   $fce0
008970  dc.w   $fcb8
008972  dc.w   $fc40
008974  ; data: 0xfb, 0xc8
008976  ; data: 0xfb, 0x00
008978  dc.w   $fa10
00897A  dc.w   $f920
00897C  dc.w   $f830
00897E  dc.w   $f768
008980  dc.w   $f6f0
008982  dc.w   $f6c8
008984  dc.w   $f6f0
008986  ; data: 0xf7, 0x90
008988  dc.w   $f880
00898A  dc.w   $f970
00898C  dc.w   $fa60
00898E  dc.w   $fb50
008990  dc.w   $fc18
008992  dc.w   $fcb8
008994  dc.w   $fd30
008996  ; data: 0xfd, 0xa8
008998  dc.w   $fe20
00899A  dc.w   $fec0
00899C  ; data: 0xff, 0x88
00899E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0089AC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0089BA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0089C8  move.b (a0, a7.l * 8), $48(a6, a7.l)
0089CE  ; data: 0xfd, 0xa8
0089D0  dc.w   $fd30
0089D2  dc.w   $fce0
0089D4  dc.w   $fc90
0089D6  dc.w   $fc18
0089D8  dc.w   $fb78
0089DA  dc.w   $fad8
0089DC  ; data: 0xf9, 0xe8
0089DE  dc.w   $f8f8
0089E0  dc.w   $f830
0089E2  dc.w   $f768
0089E4  dc.w   $f6f0
0089E6  dc.w   $f6c8
0089E8  ; data: 0xf7, 0x18
0089EA  ; data: 0xf7, 0x90
0089EC  dc.w   $f858
0089EE  ; data: 0xf9, 0x48
0089F0  dc.w   $fa38
0089F2  dc.w   $fb28
0089F4  ; data: 0xfb, 0xf0
0089F6  dc.w   $fc90
0089F8  ; data: 0xfd, 0x08
0089FA  ; data: 0xfd, 0x80
0089FC  dc.w   $fe20
0089FE  dc.w   $fec0
008A00  move.b -(a0), $1db0(a6)
008A04  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008A12  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008A20  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008A2E  dc.w   $ff38
008A30  dc.w   $fe70
008A32  ; data: 0xfd, 0xd0
008A34  dc.w   $fd30
008A36  dc.w   $fce0
008A38  dc.w   $fc68
008A3A  ; data: 0xfb, 0xf0
008A3C  dc.w   $fb50
008A3E  dc.w   $fab0
008A40  ; data: 0xf9, 0xc0
008A42  dc.w   $f8f8
008A44  dc.w   $f808
008A46  dc.w   $f768
008A48  dc.w   $f6f0
008A4A  dc.w   $f6c8
008A4C  ; data: 0xf7, 0x18
008A4E  ; data: 0xf7, 0x90
008A50  dc.w   $f858
008A52  dc.w   $f920
008A54  dc.w   $fa10
008A56  ; data: 0xfb, 0x00
008A58  ; data: 0xfb, 0xa0
008A5A  dc.w   $fc68
008A5C  dc.w   $fce0
008A5E  ; data: 0xfd, 0x80
008A60  dc.w   $fe20
008A62  dc.w   $fee8
008A64  ; data: 0x1d, 0x88
008A66  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008A74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008A82  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008A90  move.b $fe98(a0, invalid.w), (invalid.w)
008A98  dc.w   $fd58
008A9A  dc.w   $fce0
008A9C  dc.w   $fc40
008A9E  ; data: 0xfb, 0xc8
008AA0  dc.w   $fb28
008AA2  dc.w   $fa60
008AA4  ; data: 0xf9, 0x98
008AA6  dc.w   $f8d0
008AA8  dc.w   $f808
008AAA  dc.w   $f768
008AAC  dc.w   $f6f0
008AAE  dc.w   $f6f0
008AB0  ; data: 0xf7, 0x18
008AB2  ; data: 0xf7, 0x90
008AB4  dc.w   $f830
008AB6  dc.w   $f8f8
008AB8  ; data: 0xf9, 0xe8
008ABA  dc.w   $fab0
008ABC  dc.w   $fb78
008ABE  dc.w   $fc40
008AC0  dc.w   $fce0
008AC2  ; data: 0xfd, 0x80
008AC4  dc.w   $fe20
008AC6  dc.w   $fee8
008AC8  ; data: 0x1d, 0x88
008ACA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008AD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008AE6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008AF4  move.b (a7.l * 8), -$40(a6, a7.l)
008AFA  ; data: 0xfd, 0xf8
008AFC  dc.w   $fd58
008AFE  dc.w   $fcb8
008B00  dc.w   $fc40
008B02  ; data: 0xfb, 0xa0
008B04  ; data: 0xfb, 0x00
008B06  dc.w   $fa38
008B08  dc.w   $f970
008B0A  dc.w   $f8a8
008B0C  dc.w   $f808
008B0E  dc.w   $f768
008B10  ; data: 0xf7, 0x18
008B12  dc.w   $f6f0
008B14  ; data: 0xf7, 0x18
008B16  ; data: 0xf7, 0x90
008B18  dc.w   $f830
008B1A  dc.w   $f8d0
008B1C  ; data: 0xf9, 0xc0
008B1E  dc.w   $fa88
008B20  dc.w   $fb50
008B22  ; data: 0xfb, 0xf0
008B24  dc.w   $fcb8
008B26  dc.w   $fd58
008B28  dc.w   $fe20
008B2A  dc.w   $ff10
008B2C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008B3A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008B48  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008B56  move.b $1d60fec0(d1.l * 4), $fd58fcb8(invalid.w)
008B64  dc.w   $fc18
008B66  dc.w   $fb78
008B68  dc.w   $fad8
008B6A  dc.w   $fa10
008B6C  ; data: 0xf9, 0x48
008B6E  dc.w   $f8a8
008B70  ; data: 0xf7, 0xe0
008B72  dc.w   $f768
008B74  ; data: 0xf7, 0x18
008B76  dc.w   $f6f0
008B78  ; data: 0xf7, 0x18
008B7A  ; data: 0xf7, 0x90
008B7C  dc.w   $f808
008B7E  dc.w   $f8d0
008B80  dc.w   $f970
008B82  dc.w   $fa60
008B84  dc.w   $fb28
008B86  ; data: 0xfb, 0xc8
008B88  dc.w   $fc90
008B8A  dc.w   $fd58
008B8C  dc.w   $fe20
008B8E  dc.w   $ff10
008B90  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008B9E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008BAC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008BBA  move.b $1d88fee8(d1.l * 4), $20(a6, a7.l)
008BC4  dc.w   $fd58
008BC6  dc.w   $fcb8
008BC8  dc.w   $fc18
008BCA  dc.w   $fb50
008BCC  dc.w   $fab0
008BCE  ; data: 0xf9, 0xe8
008BD0  dc.w   $f920
008BD2  dc.w   $f880
008BD4  ; data: 0xf7, 0xe0
008BD6  dc.w   $f768
008BD8  ; data: 0xf7, 0x18
008BDA  dc.w   $f6f0
008BDC  ; data: 0xf7, 0x18
008BDE  dc.w   $f768
008BE0  dc.w   $f808
008BE2  dc.w   $f8a8
008BE4  ; data: 0xf9, 0x48
008BE6  dc.w   $fa10
008BE8  dc.w   $fad8
008BEA  ; data: 0xfb, 0xa0
008BEC  dc.w   $fc68
008BEE  dc.w   $fd58
008BF0  dc.w   $fe20
008BF2  dc.w   $ff10
008BF4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008C02  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008C10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008C1E  move.b $1db0ff10(d1.l * 4), $48(a6, a7.l)
008C28  dc.w   $fd58
008C2A  dc.w   $fcb8
008C2C  ; data: 0xfb, 0xf0
008C2E  dc.w   $fb28
008C30  dc.w   $fa88
008C32  ; data: 0xf9, 0xc0
008C34  dc.w   $f920
008C36  dc.w   $f858
008C38  ; data: 0xf7, 0xe0
008C3A  dc.w   $f768
008C3C  ; data: 0xf7, 0x18
008C3E  ; data: 0xf7, 0x18
008C40  ; data: 0xf7, 0x18
008C42  dc.w   $f768
008C44  ; data: 0xf7, 0xe0
008C46  dc.w   $f880
008C48  dc.w   $f920
008C4A  ; data: 0xf9, 0xe8
008C4C  dc.w   $fab0
008C4E  dc.w   $fb78
008C50  dc.w   $fc68
008C52  dc.w   $fd30
008C54  dc.w   $fe20
008C56  dc.w   $ff38
008C58  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008C66  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008C74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008C82  move.b $1db0ff38(d1.l * 4), $48(a6, a7.l)
008C8C  ; data: 0xfd, 0x80
008C8E  dc.w   $fcb8
008C90  ; data: 0xfb, 0xf0
008C92  dc.w   $fb28
008C94  dc.w   $fa60
008C96  ; data: 0xf9, 0x98
008C98  dc.w   $f8f8
008C9A  dc.w   $f858
008C9C  ; data: 0xf7, 0xe0
008C9E  dc.w   $f768
008CA0  ; data: 0xf7, 0x18
008CA2  ; data: 0xf7, 0x18
008CA4  ; data: 0xf7, 0x18
008CA6  dc.w   $f768
008CA8  ; data: 0xf7, 0xe0
008CAA  dc.w   $f858
008CAC  dc.w   $f920
008CAE  ; data: 0xf9, 0xc0
008CB0  dc.w   $fa88
008CB2  dc.w   $fb78
008CB4  dc.w   $fc40
008CB6  dc.w   $fd30
008CB8  dc.w   $fe20
008CBA  dc.w   $ff38
008CBC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008CCA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008CD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008CE6  move.b $1db0ff38(d1.l * 4), $48(a6, a7.l)
008CF0  ; data: 0xfd, 0x80
008CF2  dc.w   $fc90
008CF4  ; data: 0xfb, 0xc8
008CF6  ; data: 0xfb, 0x00
008CF8  dc.w   $fa38
008CFA  ; data: 0xf9, 0x98
008CFC  dc.w   $f8d0
008CFE  dc.w   $f830
008D00  ; data: 0xf7, 0xb8
008D02  dc.w   $f768
008D04  ; data: 0xf7, 0x18
008D06  ; data: 0xf7, 0x18
008D08  ; data: 0xf7, 0x18
008D0A  dc.w   $f768
008D0C  ; data: 0xf7, 0xb8
008D0E  dc.w   $f858
008D10  dc.w   $f8f8
008D12  ; data: 0xf9, 0x98
008D14  dc.w   $fa60
008D16  dc.w   $fb50
008D18  dc.w   $fc40
008D1A  dc.w   $fd30
008D1C  dc.w   $fe20
008D1E  dc.w   $ff38
008D20  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008D2E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008D3C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008D4A  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
008D54  ; data: 0xfd, 0x80
008D56  dc.w   $fc90
008D58  ; data: 0xfb, 0xc8
008D5A  ; data: 0xfb, 0x00
008D5C  dc.w   $fa38
008D5E  dc.w   $f970
008D60  dc.w   $f8d0
008D62  dc.w   $f830
008D64  ; data: 0xf7, 0xb8
008D66  dc.w   $f768
008D68  ; data: 0xf7, 0x18
008D6A  ; data: 0xf7, 0x18
008D6C  ; data: 0xf7, 0x18
008D6E  dc.w   $f768
008D70  ; data: 0xf7, 0xb8
008D72  dc.w   $f830
008D74  dc.w   $f8d0
008D76  ; data: 0xf9, 0x98
008D78  dc.w   $fa60
008D7A  dc.w   $fb28
008D7C  dc.w   $fc18
008D7E  ; data: 0xfd, 0x08
008D80  dc.w   $fe20
008D82  dc.w   $ff38
008D84  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008D92  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008DA0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008DAE  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
008DB8  ; data: 0xfd, 0x80
008DBA  dc.w   $fc90
008DBC  ; data: 0xfb, 0xc8
008DBE  dc.w   $fad8
008DC0  dc.w   $fa10
008DC2  ; data: 0xf9, 0x48
008DC4  dc.w   $f8a8
008DC6  dc.w   $f830
008DC8  ; data: 0xf7, 0xb8
008DCA  dc.w   $f768
008DCC  ; data: 0xf7, 0x18
008DCE  ; data: 0xf7, 0x18
008DD0  ; data: 0xf7, 0x18
008DD2  ; data: 0xf7, 0x40
008DD4  ; data: 0xf7, 0xb8
008DD6  dc.w   $f830
008DD8  dc.w   $f8a8
008DDA  dc.w   $f970
008DDC  dc.w   $fa38
008DDE  dc.w   $fb28
008DE0  dc.w   $fc18
008DE2  ; data: 0xfd, 0x08
008DE4  dc.w   $fe20
008DE6  dc.w   $ff38
008DE8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008DF6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008E04  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008E12  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
008E1C  ; data: 0xfd, 0x80
008E1E  dc.w   $fc90
008E20  ; data: 0xfb, 0xa0
008E22  dc.w   $fad8
008E24  dc.w   $fa10
008E26  ; data: 0xf9, 0x48
008E28  dc.w   $f8a8
008E2A  dc.w   $f808
008E2C  ; data: 0xf7, 0x90
008E2E  ; data: 0xf7, 0x40
008E30  ; data: 0xf7, 0x18
008E32  ; data: 0xf7, 0x18
008E34  ; data: 0xf7, 0x18
008E36  ; data: 0xf7, 0x40
008E38  ; data: 0xf7, 0x90
008E3A  dc.w   $f808
008E3C  dc.w   $f8a8
008E3E  ; data: 0xf9, 0x48
008E40  dc.w   $fa10
008E42  ; data: 0xfb, 0x00
008E44  ; data: 0xfb, 0xf0
008E46  ; data: 0xfd, 0x08
008E48  dc.w   $fe20
008E4A  dc.w   $ff38
008E4C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008E5A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008E68  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008E76  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
008E80  ; data: 0xfd, 0x80
008E82  dc.w   $fc90
008E84  ; data: 0xfb, 0xa0
008E86  dc.w   $fad8
008E88  ; data: 0xf9, 0xe8
008E8A  ; data: 0xf9, 0x48
008E8C  dc.w   $f8a8
008E8E  dc.w   $f808
008E90  ; data: 0xf7, 0x90
008E92  ; data: 0xf7, 0x40
008E94  ; data: 0xf7, 0x18
008E96  dc.w   $f6f0
008E98  ; data: 0xf7, 0x18
008E9A  ; data: 0xf7, 0x40
008E9C  ; data: 0xf7, 0x90
008E9E  dc.w   $f808
008EA0  dc.w   $f880
008EA2  ; data: 0xf9, 0x48
008EA4  dc.w   $fa10
008EA6  ; data: 0xfb, 0x00
008EA8  ; data: 0xfb, 0xf0
008EAA  ; data: 0xfd, 0x08
008EAC  dc.w   $fe20
008EAE  dc.w   $ff38
008EB0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008EBE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008ECC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008EDA  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
008EE4  ; data: 0xfd, 0x80
008EE6  dc.w   $fc90
008EE8  ; data: 0xfb, 0xa0
008EEA  dc.w   $fab0
008EEC  ; data: 0xf9, 0xe8
008EEE  dc.w   $f920
008EF0  dc.w   $f880
008EF2  dc.w   $f808
008EF4  ; data: 0xf7, 0x90
008EF6  ; data: 0xf7, 0x40
008EF8  dc.w   $f6f0
008EFA  dc.w   $f6f0
008EFC  dc.w   $f6f0
008EFE  ; data: 0xf7, 0x40
008F00  ; data: 0xf7, 0x90
008F02  ; data: 0xf7, 0xe0
008F04  dc.w   $f880
008F06  dc.w   $f920
008F08  dc.w   $fa10
008F0A  dc.w   $fad8
008F0C  ; data: 0xfb, 0xf0
008F0E  dc.w   $fce0
008F10  dc.w   $fe20
008F12  dc.w   $ff38
008F14  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008F22  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008F30  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008F3E  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
008F48  ; data: 0xfd, 0x80
008F4A  dc.w   $fc90
008F4C  ; data: 0xfb, 0xa0
008F4E  dc.w   $fab0
008F50  ; data: 0xf9, 0xe8
008F52  dc.w   $f920
008F54  dc.w   $f880
008F56  dc.w   $f808
008F58  ; data: 0xf7, 0x90
008F5A  ; data: 0xf7, 0x18
008F5C  dc.w   $f6f0
008F5E  dc.w   $f6f0
008F60  dc.w   $f6f0
008F62  ; data: 0xf7, 0x18
008F64  dc.w   $f768
008F66  ; data: 0xf7, 0xe0
008F68  dc.w   $f880
008F6A  dc.w   $f920
008F6C  ; data: 0xf9, 0xe8
008F6E  dc.w   $fad8
008F70  ; data: 0xfb, 0xc8
008F72  dc.w   $fce0
008F74  ; data: 0xfd, 0xf8
008F76  dc.w   $ff38
008F78  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008F86  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008F94  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008FA2  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
008FAC  ; data: 0xfd, 0x80
008FAE  dc.w   $fc90
008FB0  ; data: 0xfb, 0xa0
008FB2  dc.w   $fab0
008FB4  ; data: 0xf9, 0xe8
008FB6  dc.w   $f920
008FB8  dc.w   $f880
008FBA  ; data: 0xf7, 0xe0
008FBC  dc.w   $f768
008FBE  ; data: 0xf7, 0x18
008FC0  dc.w   $f6f0
008FC2  dc.w   $f6c8
008FC4  dc.w   $f6c8
008FC6  ; data: 0xf7, 0x18
008FC8  dc.w   $f768
008FCA  ; data: 0xf7, 0xe0
008FCC  dc.w   $f880
008FCE  dc.w   $f920
008FD0  ; data: 0xf9, 0xe8
008FD2  dc.w   $fad8
008FD4  ; data: 0xfb, 0xc8
008FD6  dc.w   $fce0
008FD8  ; data: 0xfd, 0xf8
008FDA  dc.w   $ff10
008FDC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008FEA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
008FF8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009006  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
009010  ; data: 0xfd, 0x80
009012  dc.w   $fc90
009014  ; data: 0xfb, 0xa0
009016  dc.w   $fad8
009018  ; data: 0xf9, 0xe8
00901A  ; data: 0xf9, 0x48
00901C  dc.w   $f880
00901E  ; data: 0xf7, 0xe0
009020  dc.w   $f768
009022  ; data: 0xf7, 0x18
009024  dc.w   $f6c8
009026  dc.w   $f6a0
009028  dc.w   $f6c8
00902A  dc.w   $f6f0
00902C  dc.w   $f768
00902E  ; data: 0xf7, 0xe0
009030  dc.w   $f880
009032  dc.w   $f920
009034  ; data: 0xf9, 0xe8
009036  dc.w   $fad8
009038  ; data: 0xfb, 0xc8
00903A  dc.w   $fce0
00903C  ; data: 0xfd, 0xf8
00903E  dc.w   $ff10
009040  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00904E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00905C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00906A  move.b $1db0ff60(d1.l * 4), $48(a6, a7.l)
009074  ; data: 0xfd, 0x80
009076  dc.w   $fc90
009078  ; data: 0xfb, 0xa0
00907A  dc.w   $fad8
00907C  dc.w   $fa10
00907E  ; data: 0xf9, 0x48
009080  dc.w   $f880
009082  ; data: 0xf7, 0xe0
009084  dc.w   $f768
009086  dc.w   $f6f0
009088  dc.w   $f6a0
00908A  dc.w   $f6a0
00908C  dc.w   $f6a0
00908E  dc.w   $f6f0
009090  ; data: 0xf7, 0x40
009092  ; data: 0xf7, 0xe0
009094  dc.w   $f880
009096  dc.w   $f920
009098  dc.w   $fa10
00909A  dc.w   $fad8
00909C  ; data: 0xfb, 0xc8
00909E  dc.w   $fce0
0090A0  ; data: 0xfd, 0xd0
0090A2  dc.w   $ff10
0090A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0090B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0090C0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0090CE  move.b $1db0ff38(d1.l * 4), $48(a6, a7.l)
0090D8  dc.w   $fd58
0090DA  dc.w   $fc90
0090DC  ; data: 0xfb, 0xc8
0090DE  dc.w   $fad8
0090E0  dc.w   $fa10
0090E2  ; data: 0xf9, 0x48
0090E4  dc.w   $f880
0090E6  ; data: 0xf7, 0xe0
0090E8  ; data: 0xf7, 0x40
0090EA  dc.w   $f6f0
0090EC  dc.w   $f6a0
0090EE  dc.w   $f678
0090F0  dc.w   $f6a0
0090F2  dc.w   $f6c8
0090F4  ; data: 0xf7, 0x40
0090F6  ; data: 0xf7, 0xe0
0090F8  dc.w   $f880
0090FA  ; data: 0xf9, 0x48
0090FC  dc.w   $fa10
0090FE  dc.w   $fad8
009100  ; data: 0xfb, 0xc8
009102  dc.w   $fcb8
009104  ; data: 0xfd, 0xd0
009106  dc.w   $fee8
009108  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009116  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009124  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009132  move.b $1db0ff38(d1.l * 4), $48(a6, a7.l)
00913C  dc.w   $fd58
00913E  dc.w   $fc90
009140  ; data: 0xfb, 0xc8
009142  ; data: 0xfb, 0x00
009144  dc.w   $fa38
009146  dc.w   $f970
009148  dc.w   $f8a8
00914A  ; data: 0xf7, 0xe0
00914C  ; data: 0xf7, 0x40
00914E  dc.w   $f6c8
009150  dc.w   $f678
009152  dc.w   $f650
009154  dc.w   $f678
009156  dc.w   $f6c8
009158  ; data: 0xf7, 0x40
00915A  ; data: 0xf7, 0xe0
00915C  dc.w   $f880
00915E  ; data: 0xf9, 0x48
009160  dc.w   $fa10
009162  ; data: 0xfb, 0x00
009164  ; data: 0xfb, 0xc8
009166  dc.w   $fcb8
009168  ; data: 0xfd, 0xd0
00916A  dc.w   $fec0
00916C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00917A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009188  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009196  move.b $1db0ff10(d1.l * 4), $20(a6, a7.l)
0091A0  dc.w   $fd58
0091A2  dc.w   $fc90
0091A4  ; data: 0xfb, 0xc8
0091A6  ; data: 0xfb, 0x00
0091A8  dc.w   $fa38
0091AA  dc.w   $f970
0091AC  dc.w   $f8a8
0091AE  ; data: 0xf7, 0xe0
0091B0  ; data: 0xf7, 0x40
0091B2  dc.w   $f6a0
0091B4  dc.w   $f650
0091B6  dc.w   $f628
0091B8  dc.w   $f650
0091BA  dc.w   $f6a0
0091BC  ; data: 0xf7, 0x18
0091BE  ; data: 0xf7, 0xe0
0091C0  dc.w   $f880
0091C2  dc.w   $f970
0091C4  dc.w   $fa38
0091C6  ; data: 0xfb, 0x00
0091C8  ; data: 0xfb, 0xf0
0091CA  dc.w   $fcb8
0091CC  ; data: 0xfd, 0xa8
0091CE  dc.w   $fec0
0091D0  ; data: 0x1d, 0x88
0091D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0091E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0091EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0091FC  move.b (d1.l * 4), -$18(a6, a7.l)
009202  dc.w   $fe20
009204  dc.w   $fd58
009206  dc.w   $fc90
009208  ; data: 0xfb, 0xf0
00920A  dc.w   $fb28
00920C  dc.w   $fa60
00920E  ; data: 0xf9, 0x98
009210  dc.w   $f8a8
009212  ; data: 0xf7, 0xe0
009214  ; data: 0xf7, 0x40
009216  dc.w   $f6a0
009218  dc.w   $f628
00921A  dc.w   $f628
00921C  dc.w   $f628
00921E  dc.w   $f6a0
009220  ; data: 0xf7, 0x18
009222  ; data: 0xf7, 0xe0
009224  dc.w   $f8a8
009226  dc.w   $f970
009228  dc.w   $fa38
00922A  dc.w   $fb28
00922C  ; data: 0xfb, 0xf0
00922E  dc.w   $fcb8
009230  ; data: 0xfd, 0xa8
009232  dc.w   $fe98
009234  move.b -(a0), $1db0(a6)
009238  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009246  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009254  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009262  ; data: 0x1d, 0x88
009264  dc.w   $fee8
009266  ; data: 0xfd, 0xf8
009268  dc.w   $fd30
00926A  dc.w   $fc90
00926C  ; data: 0xfb, 0xf0
00926E  dc.w   $fb50
009270  dc.w   $fa88
009272  ; data: 0xf9, 0x98
009274  dc.w   $f8d0
009276  ; data: 0xf7, 0xe0
009278  ; data: 0xf7, 0x18
00927A  dc.w   $f678
00927C  dc.w   $f628
00927E  dc.w   $f600
009284  ; data: 0xf7, 0x18
009286  ; data: 0xf7, 0xe0
009288  dc.w   $f8a8
00928A  ; data: 0xf9, 0x98
00928C  dc.w   $fa60
00928E  dc.w   $fb28
009290  ; data: 0xfb, 0xf0
009292  dc.w   $fcb8
009294  ; data: 0xfd, 0x80
009296  dc.w   $fe70
009298  ; data: 0xff, 0x88
00929A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0092A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0092B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0092C4  move.b $fec0fdf8(a7.l * 8), $fc90fbf0(a6, a7.l * 4)
0092D2  dc.w   $fb50
0092D4  dc.w   $fab0
0092D6  ; data: 0xf9, 0xc0
0092D8  dc.w   $f8d0
0092DA  dc.w   $f808
0092DC  ; data: 0xf7, 0x18
0092DE  dc.w   $f678
0092E0  dc.w   $f600
0092E6  dc.w   $f678
0092E8  ; data: 0xf7, 0x18
0092EA  ; data: 0xf7, 0xe0
0092EC  dc.w   $f8d0
0092EE  ; data: 0xf9, 0x98
0092F0  dc.w   $fa88
0092F2  dc.w   $fb50
0092F4  ; data: 0xfb, 0xf0
0092F6  dc.w   $fcb8
0092F8  ; data: 0xfd, 0x80
0092FA  dc.w   $fe48
0092FC  ; data: 0xff, 0x60
0092FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00930C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00931A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009328  move.b (a7.l * 8), -$68(a6, a7.l)
00932E  ; data: 0xfd, 0xd0
009330  dc.w   $fd30
009332  dc.w   $fc90
009334  dc.w   $fc18
009336  dc.w   $fb78
009338  dc.w   $fab0
00933A  ; data: 0xf9, 0xe8
00933C  dc.w   $f8f8
00933E  dc.w   $f808
009340  ; data: 0xf7, 0x18
009342  dc.w   $f650
009344  ; data: 0xf5, 0xd8
009346  ; data: 0xf5, 0xb0
009348  ; data: 0xf5, 0xd8
00934A  dc.w   $f650
00934C  ; data: 0xf7, 0x18
00934E  ; data: 0xf7, 0xe0
009350  dc.w   $f8d0
009352  ; data: 0xf9, 0xc0
009354  dc.w   $fab0
009356  dc.w   $fb50
009358  dc.w   $fc18
00935A  dc.w   $fcb8
00935C  dc.w   $fd58
00935E  dc.w   $fe48
009360  dc.w   $ff38
009362  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009370  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00937E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00938C  move.b $fe70(a0, invalid.w), $fd30(a7.l * 4)
009396  dc.w   $fc90
009398  dc.w   $fc18
00939A  ; data: 0xfb, 0xa0
00939C  dc.w   $fad8
00939E  dc.w   $fa10
0093A0  dc.w   $f920
0093A2  dc.w   $f808
0093A4  ; data: 0xf7, 0x18
0093A6  dc.w   $f628
0093A8  ; data: 0xf5, 0xb0
0093AA  ; data: 0xf5, 0x88
0093AC  ; data: 0xf5, 0xb0
0093AE  dc.w   $f628
0093B0  ; data: 0xf7, 0x18
0093B2  dc.w   $f808
0093B4  dc.w   $f8f8
0093B6  ; data: 0xf9, 0xe8
0093B8  dc.w   $fab0
0093BA  dc.w   $fb78
0093BC  dc.w   $fc18
0093BE  dc.w   $fcb8
0093C0  dc.w   $fd58
0093C2  dc.w   $fe20
0093C4  dc.w   $ff10
0093C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0093D4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0093E2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0093F0  move.b $fe48fda8(a0, a7.l * 8), (a6, a7.l * 4)
0093FA  dc.w   $fcb8
0093FC  dc.w   $fc40
0093FE  ; data: 0xfb, 0xc8
009400  ; data: 0xfb, 0x00
009402  dc.w   $fa38
009404  dc.w   $f920
009406  dc.w   $f808
009408  dc.w   $f6f0
00940A  dc.w   $f628
00940C  ; data: 0xf5, 0x88
00940E  ; data: 0xf5, 0x60
009410  ; data: 0xf5, 0x88
009412  dc.w   $f628
009414  dc.w   $f6f0
009416  dc.w   $f808
009418  dc.w   $f920
00941A  dc.w   $fa10
00941C  dc.w   $fad8
00941E  ; data: 0xfb, 0xa0
009420  dc.w   $fc18
009422  dc.w   $fc90
009424  dc.w   $fd30
009426  ; data: 0xfd, 0xf8
009428  dc.w   $fee8
00942A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009438  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009446  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009454  move.b (a0, a7.l * 8), $20(a6, a7.l)
00945A  ; data: 0xfd, 0x80
00945C  ; data: 0xfd, 0x08
00945E  dc.w   $fcb8
009460  dc.w   $fc68
009462  ; data: 0xfb, 0xf0
009464  dc.w   $fb28
009466  dc.w   $fa60
009468  ; data: 0xf9, 0x48
00946A  dc.w   $f808
00946C  dc.w   $f6f0
00946E  dc.w   $f600
009474  ; data: 0xf5, 0x88
009476  dc.w   $f600
00947C  dc.w   $f920
00947E  dc.w   $fa38
009480  ; data: 0xfb, 0x00
009482  ; data: 0xfb, 0xa0
009484  dc.w   $fc40
009486  dc.w   $fc90
009488  dc.w   $fd30
00948A  ; data: 0xfd, 0xd0
00948C  dc.w   $fec0
00948E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00949C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0094AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0094B8  move.b -$18(a0, a7.l), $fd58fd08(invalid.w)
0094C2  dc.w   $fcb8
0094C4  dc.w   $fc68
0094C6  ; data: 0xfb, 0xf0
0094C8  dc.w   $fb50
0094CA  dc.w   $fa88
0094CC  ; data: 0xf9, 0x48
0094CE  dc.w   $f830
0094D0  dc.w   $f6f0
0094D2  dc.w   $f600
0094D8  ; data: 0xf5, 0x60
0094DA  dc.w   $f600
0094E0  ; data: 0xf9, 0x48
0094E2  dc.w   $fa60
0094E4  dc.w   $fb28
0094E6  ; data: 0xfb, 0xc8
0094E8  dc.w   $fc40
0094EA  dc.w   $fc90
0094EC  ; data: 0xfd, 0x08
0094EE  ; data: 0xfd, 0xa8
0094F0  dc.w   $fe98
0094F2  ; data: 0x1d, 0x88
0094F4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009502  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009510  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00951E  dc.w   $fee8
009520  ; data: 0xfd, 0xf8
009522  dc.w   $fd58
009524  dc.w   $fce0
009526  dc.w   $fcb8
009528  dc.w   $fc90
00952A  dc.w   $fc18
00952C  dc.w   $fb78
00952E  dc.w   $fa88
009530  dc.w   $f970
009532  dc.w   $f830
009534  dc.w   $f6f0
009536  ; data: 0xf5, 0xd8
009538  dc.w   $f538
00953A  dc.w   $f4e8
00953C  dc.w   $f538
00953E  dc.w   $f600
009544  dc.w   $f970
009546  dc.w   $fa88
009548  dc.w   $fb50
00954A  ; data: 0xfb, 0xf0
00954C  dc.w   $fc40
00954E  dc.w   $fc90
009550  ; data: 0xfd, 0x08
009552  ; data: 0xfd, 0x80
009554  dc.w   $fe70
009556  move.b -(a0), $1db0(a6)
00955A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009568  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009576  move.b $1db01db0(d1.l * 4), $1db0fec0(d1.l * 4)
009584  ; data: 0xfd, 0xd0
009586  dc.w   $fd30
009588  dc.w   $fce0
00958A  dc.w   $fcb8
00958C  dc.w   $fc90
00958E  dc.w   $fc40
009590  ; data: 0xfb, 0xa0
009592  dc.w   $fab0
009594  ; data: 0xf9, 0x98
009596  dc.w   $f830
009598  dc.w   $f6f0
00959A  ; data: 0xf5, 0xd8
00959C  dc.w   $f510
00959E  dc.w   $f4e8
0095A0  dc.w   $f510
0095A2  ; data: 0xf5, 0xd8
0095A4  dc.w   $f6f0
0095A6  dc.w   $f830
0095A8  dc.w   $f970
0095AA  dc.w   $fa88
0095AC  dc.w   $fb78
0095AE  ; data: 0xfb, 0xf0
0095B0  dc.w   $fc68
0095B2  dc.w   $fc90
0095B4  dc.w   $fce0
0095B6  ; data: 0xfd, 0x80
0095B8  dc.w   $fe48
0095BA  ; data: 0xff, 0x88
0095BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0095CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0095D8  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
0095E6  dc.w   $fe98
0095E8  ; data: 0xfd, 0xa8
0095EA  ; data: 0xfd, 0x08
0095EC  dc.w   $fce0
0095EE  dc.w   $fcb8
0095F0  dc.w   $fcb8
0095F2  dc.w   $fc68
0095F4  ; data: 0xfb, 0xc8
0095F6  dc.w   $fad8
0095F8  ; data: 0xf9, 0x98
0095FA  dc.w   $f858
0095FC  dc.w   $f6f0
0095FE  ; data: 0xf5, 0xd8
009600  dc.w   $f510
009602  dc.w   $f4c0
009604  dc.w   $f510
009606  ; data: 0xf5, 0xd8
009608  dc.w   $f6f0
00960A  dc.w   $f858
00960C  ; data: 0xf9, 0x98
00960E  dc.w   $fab0
009610  ; data: 0xfb, 0xa0
009612  dc.w   $fc18
009614  dc.w   $fc68
009616  dc.w   $fc90
009618  dc.w   $fce0
00961A  dc.w   $fd58
00961C  dc.w   $fe20
00961E  ; data: 0xff, 0x88
009620  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00962E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00963C  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
00964A  dc.w   $fe70
00964C  ; data: 0xfd, 0x80
00964E  ; data: 0xfd, 0x08
009650  dc.w   $fce0
009652  dc.w   $fcb8
009654  dc.w   $fcb8
009656  dc.w   $fc90
009658  ; data: 0xfb, 0xf0
00965A  ; data: 0xfb, 0x00
00965C  ; data: 0xf9, 0xc0
00965E  dc.w   $f858
009660  dc.w   $f6f0
009662  ; data: 0xf5, 0xb0
009664  dc.w   $f4e8
009666  dc.w   $f498
009668  dc.w   $f4e8
00966A  ; data: 0xf5, 0xd8
00966C  dc.w   $f6f0
00966E  dc.w   $f858
009670  ; data: 0xf9, 0xc0
009672  dc.w   $fad8
009674  ; data: 0xfb, 0xc8
009676  dc.w   $fc40
009678  dc.w   $fc68
00967A  dc.w   $fc90
00967C  dc.w   $fce0
00967E  dc.w   $fd30
009680  dc.w   $fe20
009682  ; data: 0xff, 0x60
009684  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009692  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0096A0  move.b $1db01db0(d1.l * 4), $1db0ffb0(d1.l * 4)
0096AE  dc.w   $fe48
0096B0  ; data: 0xfd, 0x80
0096B2  dc.w   $fce0
0096B4  dc.w   $fcb8
0096B6  dc.w   $fce0
0096B8  dc.w   $fce0
0096BA  dc.w   $fc90
0096BC  dc.w   $fc18
0096BE  dc.w   $fb28
0096C0  ; data: 0xf9, 0xe8
0096C2  dc.w   $f858
0096C4  dc.w   $f6f0
0096C6  ; data: 0xf5, 0xb0
0096C8  dc.w   $f4e8
0096CA  dc.w   $f498
0096CC  dc.w   $f4e8
0096CE  ; data: 0xf5, 0xb0
0096D0  dc.w   $f6f0
0096D2  dc.w   $f858
0096D4  ; data: 0xf9, 0xc0
0096D6  ; data: 0xfb, 0x00
0096D8  ; data: 0xfb, 0xc8
0096DA  dc.w   $fc40
0096DC  dc.w   $fc90
0096DE  dc.w   $fc90
0096E0  dc.w   $fcb8
0096E2  dc.w   $fd30
0096E4  ; data: 0xfd, 0xf8
0096E6  dc.w   $ff38
0096E8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0096F6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009704  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
009712  dc.w   $fe48
009714  dc.w   $fd58
009716  dc.w   $fce0
009718  dc.w   $fcb8
00971A  dc.w   $fce0
00971C  dc.w   $fce0
00971E  dc.w   $fcb8
009720  dc.w   $fc18
009722  dc.w   $fb28
009724  ; data: 0xf9, 0xe8
009726  dc.w   $f880
009728  dc.w   $f6f0
00972A  ; data: 0xf5, 0xb0
00972C  dc.w   $f4c0
00972E  dc.w   $f498
009730  dc.w   $f4e8
009732  ; data: 0xf5, 0xb0
009734  ; data: 0xf7, 0x18
009736  dc.w   $f880
009738  ; data: 0xf9, 0xe8
00973A  dc.w   $fb28
00973C  ; data: 0xfb, 0xf0
00973E  dc.w   $fc68
009740  dc.w   $fc90
009742  dc.w   $fc90
009744  dc.w   $fcb8
009746  ; data: 0xfd, 0x08
009748  ; data: 0xfd, 0xd0
00974A  dc.w   $ff10
00974C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00975A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009768  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
009776  dc.w   $fe20
009778  dc.w   $fd30
00977A  dc.w   $fce0
00977C  dc.w   $fcb8
00977E  dc.w   $fce0
009780  dc.w   $fce0
009782  dc.w   $fcb8
009784  dc.w   $fc40
009786  dc.w   $fb50
009788  dc.w   $fa10
00978A  dc.w   $f880
00978C  dc.w   $f6f0
00978E  ; data: 0xf5, 0xb0
009790  dc.w   $f4c0
009792  dc.w   $f470
009794  dc.w   $f4e8
009796  ; data: 0xf5, 0xb0
009798  ; data: 0xf7, 0x18
00979A  dc.w   $f880
00979C  dc.w   $fa10
00979E  dc.w   $fb28
0097A0  dc.w   $fc18
0097A2  dc.w   $fc90
0097A4  dc.w   $fc90
0097A6  dc.w   $fc90
0097A8  dc.w   $fcb8
0097AA  ; data: 0xfd, 0x08
0097AC  ; data: 0xfd, 0xd0
0097AE  dc.w   $ff10
0097B0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0097BE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0097CC  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
0097DA  dc.w   $fe20
0097DC  dc.w   $fd30
0097DE  dc.w   $fcb8
0097E0  dc.w   $fcb8
0097E2  dc.w   $fce0
0097E4  ; data: 0xfd, 0x08
0097E6  dc.w   $fce0
0097E8  dc.w   $fc68
0097EA  dc.w   $fb78
0097EC  dc.w   $fa10
0097EE  dc.w   $f880
0097F0  dc.w   $f6f0
0097F2  ; data: 0xf5, 0xb0
0097F4  dc.w   $f4c0
0097F6  dc.w   $f470
0097F8  dc.w   $f4c0
0097FA  ; data: 0xf5, 0xb0
0097FC  ; data: 0xf7, 0x18
0097FE  dc.w   $f8a8
009800  dc.w   $fa10
009802  dc.w   $fb50
009804  dc.w   $fc18
009806  dc.w   $fc90
009808  dc.w   $fcb8
00980A  dc.w   $fc90
00980C  dc.w   $fcb8
00980E  dc.w   $fce0
009810  ; data: 0xfd, 0xa8
009812  dc.w   $fee8
009814  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009822  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009830  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
00983E  ; data: 0xfd, 0xf8
009840  dc.w   $fd30
009842  dc.w   $fcb8
009844  dc.w   $fcb8
009846  dc.w   $fce0
009848  ; data: 0xfd, 0x08
00984A  dc.w   $fce0
00984C  dc.w   $fc68
00984E  dc.w   $fb78
009850  dc.w   $fa38
009852  dc.w   $f8a8
009854  dc.w   $f6f0
009856  ; data: 0xf5, 0xb0
009858  dc.w   $f4c0
00985A  dc.w   $f470
00985C  dc.w   $f4c0
00985E  ; data: 0xf5, 0xb0
009860  ; data: 0xf7, 0x18
009862  dc.w   $f8a8
009864  dc.w   $fa10
009866  dc.w   $fb50
009868  dc.w   $fc40
00986A  dc.w   $fc90
00986C  dc.w   $fcb8
00986E  dc.w   $fc90
009870  dc.w   $fc90
009872  dc.w   $fce0
009874  ; data: 0xfd, 0xa8
009876  dc.w   $fee8
009878  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009886  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009894  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
0098A2  ; data: 0xfd, 0xf8
0098A4  ; data: 0xfd, 0x08
0098A6  dc.w   $fcb8
0098A8  dc.w   $fcb8
0098AA  dc.w   $fce0
0098AC  ; data: 0xfd, 0x08
0098AE  ; data: 0xfd, 0x08
0098B0  dc.w   $fc90
0098B2  ; data: 0xfb, 0xa0
0098B4  dc.w   $fa38
0098B6  dc.w   $f8a8
0098B8  ; data: 0xf7, 0x18
0098BA  ; data: 0xf5, 0xb0
0098BC  dc.w   $f4c0
0098BE  dc.w   $f470
0098C0  dc.w   $f4e8
0098C2  ; data: 0xf5, 0xd8
0098C4  ; data: 0xf7, 0x18
0098C6  dc.w   $f8a8
0098C8  dc.w   $fa38
0098CA  dc.w   $fb78
0098CC  dc.w   $fc40
0098CE  dc.w   $fcb8
0098D0  dc.w   $fcb8
0098D2  dc.w   $fcb8
0098D4  dc.w   $fc90
0098D6  dc.w   $fce0
0098D8  ; data: 0xfd, 0x80
0098DA  dc.w   $fec0
0098DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0098EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0098F8  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
009906  ; data: 0xfd, 0xf8
009908  ; data: 0xfd, 0x08
00990A  dc.w   $fcb8
00990C  dc.w   $fcb8
00990E  dc.w   $fce0
009910  ; data: 0xfd, 0x08
009912  ; data: 0xfd, 0x08
009914  dc.w   $fc90
009916  ; data: 0xfb, 0xa0
009918  dc.w   $fa38
00991A  dc.w   $f8a8
00991C  ; data: 0xf7, 0x18
00991E  ; data: 0xf5, 0xb0
009920  dc.w   $f4c0
009922  dc.w   $f470
009924  dc.w   $f4e8
009926  ; data: 0xf5, 0xd8
009928  ; data: 0xf7, 0x40
00992A  dc.w   $f8d0
00992C  dc.w   $fa38
00992E  dc.w   $fb78
009930  dc.w   $fc40
009932  dc.w   $fcb8
009934  dc.w   $fcb8
009936  dc.w   $fcb8
009938  dc.w   $fc90
00993A  dc.w   $fce0
00993C  ; data: 0xfd, 0x80
00993E  dc.w   $fec0
009940  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00994E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00995C  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00996A  ; data: 0xfd, 0xf8
00996C  ; data: 0xfd, 0x08
00996E  dc.w   $fcb8
009970  dc.w   $fcb8
009972  dc.w   $fce0
009974  dc.w   $fd30
009976  ; data: 0xfd, 0x08
009978  dc.w   $fc90
00997A  ; data: 0xfb, 0xa0
00997C  dc.w   $fa60
00997E  dc.w   $f8d0
009980  ; data: 0xf7, 0x18
009982  ; data: 0xf5, 0xd8
009984  dc.w   $f4e8
009986  dc.w   $f498
009988  dc.w   $f4e8
00998A  ; data: 0xf5, 0xd8
00998C  ; data: 0xf7, 0x40
00998E  dc.w   $f8d0
009990  dc.w   $fa60
009992  dc.w   $fb78
009994  dc.w   $fc68
009996  dc.w   $fcb8
009998  dc.w   $fcb8
00999A  dc.w   $fcb8
00999C  dc.w   $fc90
00999E  dc.w   $fce0
0099A0  ; data: 0xfd, 0x80
0099A2  dc.w   $fec0
0099A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0099B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
0099C0  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
0099CE  ; data: 0xfd, 0xf8
0099D0  ; data: 0xfd, 0x08
0099D2  dc.w   $fcb8
0099D4  dc.w   $fcb8
0099D6  ; data: 0xfd, 0x08
0099D8  dc.w   $fd30
0099DA  ; data: 0xfd, 0x08
0099DC  dc.w   $fc90
0099DE  ; data: 0xfb, 0xa0
0099E0  dc.w   $fa60
0099E2  dc.w   $f8d0
0099E4  ; data: 0xf7, 0x40
0099E6  ; data: 0xf5, 0xd8
0099E8  dc.w   $f4e8
0099EA  dc.w   $f498
0099EC  dc.w   $f510
0099EE  dc.w   $f600
0099F4  dc.w   $fa60
0099F6  ; data: 0xfb, 0xa0
0099F8  dc.w   $fc68
0099FA  dc.w   $fcb8
0099FC  dc.w   $fce0
0099FE  dc.w   $fcb8
009A00  dc.w   $fc90
009A02  dc.w   $fce0
009A04  ; data: 0xfd, 0x80
009A06  dc.w   $fec0
009A08  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009A16  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009A24  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
009A32  ; data: 0xfd, 0xf8
009A34  ; data: 0xfd, 0x08
009A36  dc.w   $fcb8
009A38  dc.w   $fcb8
009A3A  ; data: 0xfd, 0x08
009A3C  dc.w   $fd30
009A3E  ; data: 0xfd, 0x08
009A40  dc.w   $fc90
009A42  ; data: 0xfb, 0xa0
009A44  dc.w   $fa60
009A46  dc.w   $f8d0
009A48  ; data: 0xf7, 0x40
009A4A  dc.w   $f600
009A50  dc.w   $f510
009A52  dc.w   $f600
009A58  dc.w   $fa60
009A5A  ; data: 0xfb, 0xa0
009A5C  dc.w   $fc68
009A5E  dc.w   $fcb8
009A60  dc.w   $fce0
009A62  dc.w   $fcb8
009A64  dc.w   $fcb8
009A66  dc.w   $fce0
009A68  ; data: 0xfd, 0x80
009A6A  dc.w   $fec0
009A6C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009A7A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009A88  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
009A96  ; data: 0xfd, 0xf8
009A98  dc.w   $fd30
009A9A  dc.w   $fcb8
009A9C  dc.w   $fcb8
009A9E  ; data: 0xfd, 0x08
009AA0  dc.w   $fd30
009AA2  ; data: 0xfd, 0x08
009AA4  dc.w   $fc90
009AA6  ; data: 0xfb, 0xa0
009AA8  dc.w   $fa60
009AAA  dc.w   $f8d0
009AAC  dc.w   $f768
009AAE  dc.w   $f600
009AB4  dc.w   $f538
009AB6  dc.w   $f628
009AB8  dc.w   $f768
009ABA  dc.w   $f8f8
009ABC  dc.w   $fa60
009ABE  ; data: 0xfb, 0xa0
009AC0  dc.w   $fc68
009AC2  dc.w   $fcb8
009AC4  dc.w   $fce0
009AC6  dc.w   $fcb8
009AC8  dc.w   $fcb8
009ACA  dc.w   $fce0
009ACC  ; data: 0xfd, 0xa8
009ACE  dc.w   $fec0
009AD0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009ADE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009AEC  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
009AFA  ; data: 0xfd, 0xf8
009AFC  dc.w   $fd30
009AFE  dc.w   $fce0
009B00  dc.w   $fce0
009B02  ; data: 0xfd, 0x08
009B04  dc.w   $fd30
009B06  ; data: 0xfd, 0x08
009B08  dc.w   $fc90
009B0A  ; data: 0xfb, 0xa0
009B0C  dc.w   $fa60
009B0E  dc.w   $f8f8
009B10  dc.w   $f768
009B12  dc.w   $f628
009B14  dc.w   $f538
009B16  dc.w   $f510
009B18  ; data: 0xf5, 0x60
009B1A  dc.w   $f628
009B1C  ; data: 0xf7, 0x90
009B1E  dc.w   $f8f8
009B20  dc.w   $fa60
009B22  ; data: 0xfb, 0xa0
009B24  dc.w   $fc68
009B26  dc.w   $fcb8
009B28  dc.w   $fce0
009B2A  dc.w   $fcb8
009B2C  dc.w   $fcb8
009B2E  ; data: 0xfd, 0x08
009B30  ; data: 0xfd, 0xa8
009B32  dc.w   $fec0
009B34  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009B42  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009B50  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
009B5E  dc.w   $fe20
009B60  dc.w   $fd58
009B62  dc.w   $fce0
009B64  dc.w   $fce0
009B66  ; data: 0xfd, 0x08
009B68  dc.w   $fd30
009B6A  ; data: 0xfd, 0x08
009B6C  dc.w   $fc90
009B6E  ; data: 0xfb, 0xa0
009B70  dc.w   $fa60
009B72  dc.w   $f8f8
009B74  ; data: 0xf7, 0x90
009B76  dc.w   $f650
009B78  ; data: 0xf5, 0x60
009B7A  dc.w   $f538
009B7C  ; data: 0xf5, 0x88
009B7E  dc.w   $f650
009B80  ; data: 0xf7, 0x90
009B82  dc.w   $f8f8
009B84  dc.w   $fa60
009B86  dc.w   $fb78
009B88  dc.w   $fc40
009B8A  dc.w   $fcb8
009B8C  dc.w   $fce0
009B8E  dc.w   $fcb8
009B90  dc.w   $fcb8
009B92  ; data: 0xfd, 0x08
009B94  ; data: 0xfd, 0xa8
009B96  dc.w   $fee8
009B98  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009BA6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009BB4  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
009BC2  dc.w   $fe20
009BC4  dc.w   $fd58
009BC6  ; data: 0xfd, 0x08
009BC8  dc.w   $fce0
009BCA  ; data: 0xfd, 0x08
009BCC  ; data: 0xfd, 0x08
009BCE  ; data: 0xfd, 0x08
009BD0  dc.w   $fc90
009BD2  ; data: 0xfb, 0xa0
009BD4  dc.w   $fa60
009BD6  dc.w   $f8f8
009BD8  ; data: 0xf7, 0x90
009BDA  dc.w   $f650
009BDC  ; data: 0xf5, 0x88
009BDE  ; data: 0xf5, 0x60
009BE0  ; data: 0xf5, 0xb0
009BE2  dc.w   $f678
009BE4  ; data: 0xf7, 0xb8
009BE6  dc.w   $f920
009BE8  dc.w   $fa60
009BEA  dc.w   $fb78
009BEC  dc.w   $fc40
009BEE  dc.w   $fcb8
009BF0  dc.w   $fce0
009BF2  dc.w   $fce0
009BF4  dc.w   $fce0
009BF6  dc.w   $fd30
009BF8  ; data: 0xfd, 0xd0
009BFA  dc.w   $fee8
009BFC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009C0A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009C18  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
009C26  dc.w   $fe48
009C28  ; data: 0xfd, 0x80
009C2A  ; data: 0xfd, 0x08
009C2C  dc.w   $fce0
009C2E  ; data: 0xfd, 0x08
009C30  ; data: 0xfd, 0x08
009C32  dc.w   $fce0
009C34  dc.w   $fc68
009C36  ; data: 0xfb, 0xa0
009C38  dc.w   $fa60
009C3A  dc.w   $f920
009C3C  ; data: 0xf7, 0xb8
009C3E  dc.w   $f678
009C40  ; data: 0xf5, 0xb0
009C42  ; data: 0xf5, 0x88
009C44  ; data: 0xf5, 0xd8
009C46  dc.w   $f6a0
009C48  ; data: 0xf7, 0xb8
009C4A  dc.w   $f920
009C4C  dc.w   $fa60
009C4E  dc.w   $fb78
009C50  dc.w   $fc40
009C52  dc.w   $fcb8
009C54  dc.w   $fce0
009C56  dc.w   $fce0
009C58  dc.w   $fce0
009C5A  dc.w   $fd30
009C5C  ; data: 0xfd, 0xf8
009C5E  dc.w   $ff10
009C60  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009C6E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009C7C  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
009C8A  dc.w   $fe48
009C8C  ; data: 0xfd, 0x80
009C8E  dc.w   $fd30
009C90  ; data: 0xfd, 0x08
009C92  ; data: 0xfd, 0x08
009C94  ; data: 0xfd, 0x08
009C96  dc.w   $fce0
009C98  dc.w   $fc68
009C9A  dc.w   $fb78
009C9C  dc.w   $fa60
009C9E  dc.w   $f920
009CA0  ; data: 0xf7, 0xb8
009CA2  dc.w   $f6a0
009CA4  dc.w   $f600
009CAA  dc.w   $f6c8
009CAC  ; data: 0xf7, 0xe0
009CAE  dc.w   $f920
009CB0  dc.w   $fa60
009CB2  dc.w   $fb78
009CB4  dc.w   $fc40
009CB6  dc.w   $fc90
009CB8  dc.w   $fcb8
009CBA  dc.w   $fce0
009CBC  ; data: 0xfd, 0x08
009CBE  dc.w   $fd58
009CC0  ; data: 0xfd, 0xf8
009CC2  dc.w   $ff10
009CC4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009CD2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009CE0  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
009CEE  dc.w   $fe70
009CF0  ; data: 0xfd, 0xa8
009CF2  dc.w   $fd30
009CF4  ; data: 0xfd, 0x08
009CF6  ; data: 0xfd, 0x08
009CF8  ; data: 0xfd, 0x08
009CFA  dc.w   $fcb8
009CFC  dc.w   $fc40
009CFE  dc.w   $fb78
009D00  dc.w   $fa60
009D02  dc.w   $f920
009D04  ; data: 0xf7, 0xe0
009D06  dc.w   $f6c8
009D08  dc.w   $f628
009D0A  dc.w   $f600
009D10  dc.w   $f808
009D12  dc.w   $f920
009D14  dc.w   $fa60
009D16  dc.w   $fb50
009D18  dc.w   $fc18
009D1A  dc.w   $fc90
009D1C  dc.w   $fcb8
009D1E  dc.w   $fce0
009D20  ; data: 0xfd, 0x08
009D22  dc.w   $fd58
009D24  dc.w   $fe20
009D26  dc.w   $ff38
009D28  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009D36  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009D44  move.b $1db01db0(d1.l * 4), $1db0ffb0(d1.l * 4)
009D52  dc.w   $fe98
009D54  ; data: 0xfd, 0xd0
009D56  dc.w   $fd58
009D58  ; data: 0xfd, 0x08
009D5A  ; data: 0xfd, 0x08
009D5C  dc.w   $fce0
009D5E  dc.w   $fcb8
009D60  dc.w   $fc40
009D62  dc.w   $fb78
009D64  dc.w   $fa60
009D66  dc.w   $f920
009D68  dc.w   $f808
009D6A  ; data: 0xf7, 0x18
009D6C  dc.w   $f650
009D6E  dc.w   $f628
009D70  dc.w   $f678
009D72  ; data: 0xf7, 0x18
009D74  dc.w   $f808
009D76  ; data: 0xf9, 0x48
009D78  dc.w   $fa60
009D7A  dc.w   $fb50
009D7C  dc.w   $fc18
009D7E  dc.w   $fc90
009D80  dc.w   $fcb8
009D82  dc.w   $fce0
009D84  dc.w   $fd30
009D86  ; data: 0xfd, 0x80
009D88  dc.w   $fe48
009D8A  ; data: 0xff, 0x60
009D8C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009D9A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009DA8  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
009DB6  dc.w   $fec0
009DB8  ; data: 0xfd, 0xf8
009DBA  dc.w   $fd58
009DBC  dc.w   $fd30
009DBE  ; data: 0xfd, 0x08
009DC0  dc.w   $fce0
009DC2  dc.w   $fc90
009DC4  dc.w   $fc18
009DC6  dc.w   $fb50
009DC8  dc.w   $fa60
009DCA  ; data: 0xf9, 0x48
009DCC  dc.w   $f830
009DCE  ; data: 0xf7, 0x40
009DD0  dc.w   $f6a0
009DD2  dc.w   $f650
009DD4  dc.w   $f6a0
009DD6  ; data: 0xf7, 0x40
009DD8  dc.w   $f830
009DDA  ; data: 0xf9, 0x48
009DDC  dc.w   $fa60
009DDE  dc.w   $fb50
009DE0  ; data: 0xfb, 0xf0
009DE2  dc.w   $fc68
009DE4  dc.w   $fcb8
009DE6  dc.w   $fce0
009DE8  dc.w   $fd30
009DEA  ; data: 0xfd, 0xa8
009DEC  dc.w   $fe70
009DEE  ; data: 0xff, 0x60
009DF0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009DFE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009E0C  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
009E1A  dc.w   $fec0
009E1C  ; data: 0xfd, 0xf8
009E1E  ; data: 0xfd, 0x80
009E20  dc.w   $fd30
009E22  ; data: 0xfd, 0x08
009E24  dc.w   $fce0
009E26  dc.w   $fc90
009E28  dc.w   $fc18
009E2A  dc.w   $fb50
009E2C  dc.w   $fa60
009E2E  ; data: 0xf9, 0x48
009E30  dc.w   $f830
009E32  dc.w   $f768
009E34  dc.w   $f6c8
009E36  dc.w   $f6a0
009E38  dc.w   $f6c8
009E3A  dc.w   $f768
009E3C  dc.w   $f858
009E3E  ; data: 0xf9, 0x48
009E40  dc.w   $fa38
009E42  dc.w   $fb28
009E44  ; data: 0xfb, 0xf0
009E46  dc.w   $fc68
009E48  dc.w   $fcb8
009E4A  ; data: 0xfd, 0x08
009E4C  dc.w   $fd58
009E4E  ; data: 0xfd, 0xd0
009E50  dc.w   $fe70
009E52  ; data: 0xff, 0x88
009E54  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009E62  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009E70  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
009E7E  dc.w   $fee8
009E80  dc.w   $fe20
009E82  ; data: 0xfd, 0xa8
009E84  dc.w   $fd58
009E86  ; data: 0xfd, 0x08
009E88  dc.w   $fce0
009E8A  dc.w   $fc68
009E8C  ; data: 0xfb, 0xf0
009E8E  dc.w   $fb28
009E90  dc.w   $fa60
009E92  ; data: 0xf9, 0x48
009E94  dc.w   $f858
009E96  ; data: 0xf7, 0x90
009E98  ; data: 0xf7, 0x18
009E9A  dc.w   $f6f0
009E9C  ; data: 0xf7, 0x18
009E9E  ; data: 0xf7, 0x90
009EA0  dc.w   $f858
009EA2  ; data: 0xf9, 0x48
009EA4  dc.w   $fa38
009EA6  dc.w   $fb28
009EA8  ; data: 0xfb, 0xc8
009EAA  dc.w   $fc40
009EAC  dc.w   $fcb8
009EAE  ; data: 0xfd, 0x08
009EB0  dc.w   $fd58
009EB2  ; data: 0xfd, 0xd0
009EB4  dc.w   $fe98
009EB6  ; data: 0xff, 0xb0
009EB8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009EC6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009ED4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009EE2  dc.w   $ff10
009EE4  dc.w   $fe48
009EE6  ; data: 0xfd, 0xa8
009EE8  dc.w   $fd58
009EEA  ; data: 0xfd, 0x08
009EEC  dc.w   $fcb8
009EEE  dc.w   $fc68
009EF0  ; data: 0xfb, 0xf0
009EF2  dc.w   $fb28
009EF4  dc.w   $fa60
009EF6  dc.w   $f970
009EF8  dc.w   $f880
009EFA  ; data: 0xf7, 0xb8
009EFC  ; data: 0xf7, 0x40
009EFE  ; data: 0xf7, 0x18
009F00  ; data: 0xf7, 0x40
009F02  ; data: 0xf7, 0xb8
009F04  dc.w   $f880
009F06  dc.w   $f970
009F08  dc.w   $fa38
009F0A  ; data: 0xfb, 0x00
009F0C  ; data: 0xfb, 0xc8
009F0E  dc.w   $fc40
009F10  dc.w   $fcb8
009F12  ; data: 0xfd, 0x08
009F14  ; data: 0xfd, 0x80
009F16  ; data: 0xfd, 0xf8
009F18  dc.w   $fec0
009F1A  ; data: 0x1d, 0x88
009F1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009F2A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009F38  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009F46  dc.w   $ff38
009F48  dc.w   $fe70
009F4A  ; data: 0xfd, 0xd0
009F4C  dc.w   $fd58
009F4E  ; data: 0xfd, 0x08
009F50  dc.w   $fcb8
009F52  dc.w   $fc40
009F54  ; data: 0xfb, 0xc8
009F56  dc.w   $fb28
009F58  dc.w   $fa38
009F5A  dc.w   $f970
009F5C  dc.w   $f8a8
009F5E  ; data: 0xf7, 0xe0
009F60  ; data: 0xf7, 0x90
009F62  dc.w   $f768
009F64  ; data: 0xf7, 0x90
009F66  dc.w   $f808
009F68  dc.w   $f8a8
009F6A  dc.w   $f970
009F6C  dc.w   $fa38
009F6E  ; data: 0xfb, 0x00
009F70  ; data: 0xfb, 0xa0
009F72  dc.w   $fc40
009F74  dc.w   $fcb8
009F76  ; data: 0xfd, 0x08
009F78  ; data: 0xfd, 0x80
009F7A  dc.w   $fe20
009F7C  dc.w   $fee8
009F7E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009F8C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009F9A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009FA8  move.b $fe70fdf8(a0, a7.l * 8), (a7.l * 4)
009FB2  ; data: 0xfd, 0x08
009FB4  dc.w   $fcb8
009FB6  dc.w   $fc40
009FB8  ; data: 0xfb, 0xa0
009FBA  ; data: 0xfb, 0x00
009FBC  dc.w   $fa38
009FBE  dc.w   $f970
009FC0  dc.w   $f8d0
009FC2  dc.w   $f830
009FC4  ; data: 0xf7, 0xb8
009FC6  ; data: 0xf7, 0x90
009FC8  ; data: 0xf7, 0xb8
009FCA  dc.w   $f830
009FCC  dc.w   $f8d0
009FCE  dc.w   $f970
009FD0  dc.w   $fa38
009FD2  ; data: 0xfb, 0x00
009FD4  ; data: 0xfb, 0xa0
009FD6  dc.w   $fc18
009FD8  dc.w   $fcb8
009FDA  dc.w   $fd30
009FDC  ; data: 0xfd, 0xa8
009FDE  dc.w   $fe48
009FE0  dc.w   $ff10
009FE2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009FF0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
009FFE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A00C  move.b $fe98(a0, invalid.w), $fd80fd08(invalid.w)
00A018  dc.w   $fcb8
00A01A  dc.w   $fc40
00A01C  ; data: 0xfb, 0xa0
00A01E  ; data: 0xfb, 0x00
00A020  dc.w   $fa38
00A022  ; data: 0xf9, 0x98
00A024  dc.w   $f8d0
00A026  dc.w   $f858
00A028  dc.w   $f808
00A02A  ; data: 0xf7, 0xe0
00A02C  dc.w   $f808
00A02E  dc.w   $f858
00A030  dc.w   $f8d0
00A032  ; data: 0xf9, 0x98
00A034  dc.w   $fa38
00A036  dc.w   $fad8
00A038  ; data: 0xfb, 0xa0
00A03A  dc.w   $fc18
00A03C  dc.w   $fc90
00A03E  dc.w   $fd30
00A040  ; data: 0xfd, 0xa8
00A042  dc.w   $fe70
00A044  dc.w   $ff38
00A046  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A054  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A062  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A070  move.b (a7.l * 8), -$40(a6, a7.l)
00A076  dc.w   $fe20
00A078  ; data: 0xfd, 0xa8
00A07A  ; data: 0xfd, 0x08
00A07C  dc.w   $fc90
00A07E  dc.w   $fc18
00A080  ; data: 0xfb, 0xa0
00A082  ; data: 0xfb, 0x00
00A084  dc.w   $fa38
00A086  ; data: 0xf9, 0x98
00A088  dc.w   $f8f8
00A08A  dc.w   $f880
00A08C  dc.w   $f830
00A08E  dc.w   $f808
00A090  dc.w   $f830
00A092  dc.w   $f880
00A094  dc.w   $f8f8
00A096  ; data: 0xf9, 0x98
00A098  dc.w   $fa38
00A09A  dc.w   $fad8
00A09C  dc.w   $fb78
00A09E  dc.w   $fc18
00A0A0  dc.w   $fc90
00A0A2  dc.w   $fd30
00A0A4  ; data: 0xfd, 0xd0
00A0A6  dc.w   $fe70
00A0A8  ; data: 0xff, 0x60
00A0AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A0B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A0C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A0D4  move.b (a7.l * 8), -$18(a6, a7.l)
00A0DA  dc.w   $fe20
00A0DC  ; data: 0xfd, 0xa8
00A0DE  dc.w   $fd30
00A0E0  dc.w   $fc90
00A0E2  dc.w   $fc18
00A0E4  dc.w   $fb78
00A0E6  dc.w   $fad8
00A0E8  dc.w   $fa38
00A0EA  ; data: 0xf9, 0xc0
00A0EC  dc.w   $f920
00A0EE  dc.w   $f8a8
00A0F0  dc.w   $f858
00A0F2  dc.w   $f858
00A0F4  dc.w   $f858
00A0F6  dc.w   $f8a8
00A0F8  dc.w   $f920
00A0FA  ; data: 0xf9, 0x98
00A0FC  dc.w   $fa38
00A0FE  dc.w   $fad8
00A100  dc.w   $fb78
00A102  dc.w   $fc18
00A104  dc.w   $fc90
00A106  dc.w   $fd30
00A108  ; data: 0xfd, 0xd0
00A10A  dc.w   $fe98
00A10C  ; data: 0xff, 0x60
00A10E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A11C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A12A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A138  move.b $fee8fe48(a7.l * 8), $fd30(a7.l * 4)
00A144  dc.w   $fc90
00A146  dc.w   $fc18
00A148  dc.w   $fb78
00A14A  dc.w   $fad8
00A14C  dc.w   $fa60
00A14E  ; data: 0xf9, 0xc0
00A150  ; data: 0xf9, 0x48
00A152  dc.w   $f8d0
00A154  dc.w   $f8a8
00A156  dc.w   $f880
00A158  dc.w   $f8a8
00A15A  dc.w   $f8d0
00A15C  ; data: 0xf9, 0x48
00A15E  ; data: 0xf9, 0xc0
00A160  dc.w   $fa38
00A162  dc.w   $fad8
00A164  dc.w   $fb78
00A166  dc.w   $fc18
00A168  dc.w   $fcb8
00A16A  dc.w   $fd58
00A16C  ; data: 0xfd, 0xf8
00A16E  dc.w   $fec0
00A170  ; data: 0xff, 0x88
00A172  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A180  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A18E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A19C  move.b $ff10fe48(a7.l * 8), $fd30(a7.l * 4)
00A1A8  dc.w   $fc90
00A1AA  ; data: 0xfb, 0xf0
00A1AC  dc.w   $fb78
00A1AE  dc.w   $fad8
00A1B0  dc.w   $fa60
00A1B2  ; data: 0xf9, 0xe8
00A1B4  dc.w   $f970
00A1B6  dc.w   $f8f8
00A1B8  dc.w   $f8d0
00A1BA  dc.w   $f8d0
00A1BC  dc.w   $f8d0
00A1BE  dc.w   $f8f8
00A1C0  ; data: 0xf9, 0x48
00A1C2  ; data: 0xf9, 0xc0
00A1C4  dc.w   $fa38
00A1C6  dc.w   $fad8
00A1C8  dc.w   $fb78
00A1CA  dc.w   $fc18
00A1CC  dc.w   $fcb8
00A1CE  dc.w   $fd58
00A1D0  ; data: 0xfd, 0xf8
00A1D2  dc.w   $fec0
00A1D4  ; data: 0xff, 0x88
00A1D6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A1E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A1F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A200  move.b $ff10(a0, invalid.w), $70(a6, a7.l)
00A208  ; data: 0xfd, 0xd0
00A20A  dc.w   $fd30
00A20C  dc.w   $fc90
00A20E  ; data: 0xfb, 0xf0
00A210  dc.w   $fb78
00A212  dc.w   $fad8
00A214  dc.w   $fa60
00A216  ; data: 0xf9, 0xe8
00A218  dc.w   $f970
00A21A  ; data: 0xf9, 0x48
00A21C  dc.w   $f8f8
00A21E  dc.w   $f8f8
00A220  dc.w   $f8f8
00A222  dc.w   $f920
00A224  dc.w   $f970
00A226  ; data: 0xf9, 0xe8
00A228  dc.w   $fa60
00A22A  dc.w   $fad8
00A22C  dc.w   $fb78
00A22E  dc.w   $fc18
00A230  dc.w   $fcb8
00A232  dc.w   $fd58
00A234  dc.w   $fe20
00A236  dc.w   $fee8
00A238  ; data: 0xff, 0xb0
00A23A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A248  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A256  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A264  move.b (d1.l * 4), (a6, a7.l * 8)
00A26A  dc.w   $fe70
00A26C  ; data: 0xfd, 0xd0
00A26E  dc.w   $fd30
00A270  dc.w   $fc90
00A272  ; data: 0xfb, 0xf0
00A274  dc.w   $fb78
00A276  dc.w   $fad8
00A278  dc.w   $fa60
00A27A  dc.w   $fa10
00A27C  ; data: 0xf9, 0x98
00A27E  ; data: 0xf9, 0x48
00A280  dc.w   $f920
00A282  dc.w   $f920
00A284  dc.w   $f920
00A286  ; data: 0xf9, 0x48
00A288  ; data: 0xf9, 0x98
00A28A  ; data: 0xf9, 0xe8
00A28C  dc.w   $fa60
00A28E  dc.w   $fad8
00A290  dc.w   $fb78
00A292  dc.w   $fc18
00A294  dc.w   $fcb8
00A296  dc.w   $fd58
00A298  dc.w   $fe20
00A29A  dc.w   $fee8
00A29C  move.b -(a0), $1db0(a6)
00A2A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A2AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A2BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A2CA  ; data: 0x1d, 0x88
00A2CC  dc.w   $ff10
00A2CE  dc.w   $fe70
00A2D0  ; data: 0xfd, 0xd0
00A2D2  dc.w   $fd30
00A2D4  dc.w   $fc90
00A2D6  ; data: 0xfb, 0xf0
00A2D8  dc.w   $fb78
00A2DA  ; data: 0xfb, 0x00
00A2DC  dc.w   $fa88
00A2DE  dc.w   $fa10
00A2E0  ; data: 0xf9, 0xc0
00A2E2  dc.w   $f970
00A2E4  ; data: 0xf9, 0x48
00A2E6  ; data: 0xf9, 0x48
00A2E8  ; data: 0xf9, 0x48
00A2EA  dc.w   $f970
00A2EC  ; data: 0xf9, 0xc0
00A2EE  dc.w   $fa10
00A2F0  dc.w   $fa88
00A2F2  ; data: 0xfb, 0x00
00A2F4  dc.w   $fb78
00A2F6  dc.w   $fc18
00A2F8  dc.w   $fcb8
00A2FA  ; data: 0xfd, 0x80
00A2FC  dc.w   $fe20
00A2FE  dc.w   $fee8
00A300  ; data: 0x1d, 0x88
00A302  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A310  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A31E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A32C  move.b (d1.l * 4), $fe70fdd0(a6, a7.l * 8)
00A336  dc.w   $fd30
00A338  dc.w   $fc90
00A33A  dc.w   $fc18
00A33C  dc.w   $fb78
00A33E  ; data: 0xfb, 0x00
00A340  dc.w   $fa88
00A342  dc.w   $fa38
00A344  ; data: 0xf9, 0xe8
00A346  ; data: 0xf9, 0x98
00A348  dc.w   $f970
00A34A  dc.w   $f970
00A34C  dc.w   $f970
00A34E  ; data: 0xf9, 0x98
00A350  ; data: 0xf9, 0xe8
00A352  dc.w   $fa38
00A354  dc.w   $fa88
00A356  ; data: 0xfb, 0x00
00A358  dc.w   $fb78
00A35A  dc.w   $fc18
00A35C  dc.w   $fcb8
00A35E  ; data: 0xfd, 0x80
00A360  dc.w   $fe48
00A362  dc.w   $ff10
00A364  ; data: 0x1d, 0x88
00A366  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A374  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A382  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A390  move.b (d1.l * 4), $fe98fdd0(a6, a7.l * 8)
00A39A  dc.w   $fd30
00A39C  dc.w   $fcb8
00A39E  dc.w   $fc18
00A3A0  ; data: 0xfb, 0xa0
00A3A2  ; data: 0xfb, 0x00
00A3A4  dc.w   $fab0
00A3A6  dc.w   $fa38
00A3A8  dc.w   $fa10
00A3AA  ; data: 0xf9, 0xc0
00A3AC  ; data: 0xf9, 0x98
00A3AE  ; data: 0xf9, 0x98
00A3B0  ; data: 0xf9, 0x98
00A3B2  ; data: 0xf9, 0xc0
00A3B4  ; data: 0xf9, 0xe8
00A3B6  dc.w   $fa38
00A3B8  dc.w   $fab0
00A3BA  dc.w   $fb28
00A3BC  ; data: 0xfb, 0xa0
00A3BE  dc.w   $fc40
00A3C0  dc.w   $fce0
00A3C2  ; data: 0xfd, 0x80
00A3C4  dc.w   $fe48
00A3C6  dc.w   $ff10
00A3C8  ; data: 0x1d, 0x88
00A3CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A3D8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A3E6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A3F4  move.b $ff10(a0, invalid.w), -$68(a6, a7.l)
00A3FC  ; data: 0xfd, 0xf8
00A3FE  dc.w   $fd58
00A400  dc.w   $fcb8
00A402  dc.w   $fc18
00A404  ; data: 0xfb, 0xa0
00A406  dc.w   $fb28
00A408  dc.w   $fab0
00A40A  dc.w   $fa60
00A40C  dc.w   $fa10
00A40E  ; data: 0xf9, 0xe8
00A410  ; data: 0xf9, 0xc0
00A412  ; data: 0xf9, 0xc0
00A414  ; data: 0xf9, 0xc0
00A416  ; data: 0xf9, 0xe8
00A418  dc.w   $fa10
00A41A  dc.w   $fa60
00A41C  dc.w   $fab0
00A41E  dc.w   $fb28
00A420  ; data: 0xfb, 0xa0
00A422  dc.w   $fc40
00A424  dc.w   $fce0
00A426  ; data: 0xfd, 0xa8
00A428  dc.w   $fe48
00A42A  dc.w   $ff10
00A42C  ; data: 0x1d, 0x88
00A42E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A43C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A44A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A458  move.b $ff10(a0, invalid.w), $70(a6, a7.l)
00A460  ; data: 0xfd, 0xf8
00A462  dc.w   $fd58
00A464  dc.w   $fcb8
00A466  dc.w   $fc40
00A468  ; data: 0xfb, 0xc8
00A46A  dc.w   $fb50
00A46C  dc.w   $fad8
00A46E  dc.w   $fa88
00A470  dc.w   $fa38
00A472  dc.w   $fa10
00A474  ; data: 0xf9, 0xe8
00A476  ; data: 0xf9, 0xc0
00A478  ; data: 0xf9, 0xe8
00A47A  dc.w   $fa10
00A47C  dc.w   $fa38
00A47E  dc.w   $fa88
00A480  dc.w   $fad8
00A482  dc.w   $fb50
00A484  ; data: 0xfb, 0xc8
00A486  dc.w   $fc68
00A488  ; data: 0xfd, 0x08
00A48A  ; data: 0xfd, 0xa8
00A48C  dc.w   $fe48
00A48E  dc.w   $ff10
00A490  ; data: 0x1d, 0x88
00A492  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A4A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A4AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A4BC  move.b $ff10fe70(a7.l * 8), $fd58fce0(invalid.w)
00A4CA  dc.w   $fc40
00A4CC  ; data: 0xfb, 0xc8
00A4CE  dc.w   $fb50
00A4D0  ; data: 0xfb, 0x00
00A4D2  dc.w   $fa88
00A4D4  dc.w   $fa60
00A4D6  dc.w   $fa10
00A4D8  ; data: 0xf9, 0xe8
00A4DA  ; data: 0xf9, 0xe8
00A4DC  ; data: 0xf9, 0xe8
00A4DE  dc.w   $fa10
00A4E0  dc.w   $fa60
00A4E2  dc.w   $fab0
00A4E4  ; data: 0xfb, 0x00
00A4E6  dc.w   $fb78
00A4E8  ; data: 0xfb, 0xf0
00A4EA  dc.w   $fc68
00A4EC  ; data: 0xfd, 0x08
00A4EE  ; data: 0xfd, 0xa8
00A4F0  dc.w   $fe48
00A4F2  dc.w   $ff10
00A4F4  ; data: 0x1d, 0x88
00A4F6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A504  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A512  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A520  move.b (a7.l * 8), (a6, a7.l * 8)
00A526  dc.w   $fe70
00A528  ; data: 0xfd, 0xf8
00A52A  dc.w   $fd58
00A52C  dc.w   $fce0
00A52E  dc.w   $fc68
00A530  ; data: 0xfb, 0xf0
00A532  dc.w   $fb78
00A534  dc.w   $fb28
00A536  dc.w   $fab0
00A538  dc.w   $fa60
00A53A  dc.w   $fa38
00A53C  dc.w   $fa10
00A53E  dc.w   $fa10
00A540  dc.w   $fa10
00A542  dc.w   $fa38
00A544  dc.w   $fa60
00A546  dc.w   $fab0
00A548  dc.w   $fb28
00A54A  ; data: 0xfb, 0xa0
00A54C  dc.w   $fc18
00A54E  dc.w   $fc90
00A550  dc.w   $fd30
00A552  ; data: 0xfd, 0xa8
00A554  dc.w   $fe48
00A556  dc.w   $ff10
00A558  move.b -(a0), $1db0(a6)
00A55C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A56A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A578  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A586  ; data: 0xff, 0x88
00A588  dc.w   $fee8
00A58A  dc.w   $fe70
00A58C  ; data: 0xfd, 0xf8
00A58E  ; data: 0xfd, 0x80
00A590  ; data: 0xfd, 0x08
00A592  dc.w   $fc90
00A594  dc.w   $fc18
00A596  ; data: 0xfb, 0xa0
00A598  dc.w   $fb28
00A59A  dc.w   $fad8
00A59C  dc.w   $fa88
00A59E  dc.w   $fa38
00A5A0  dc.w   $fa10
00A5A2  dc.w   $fa10
00A5A4  dc.w   $fa10
00A5A6  dc.w   $fa38
00A5A8  dc.w   $fa88
00A5AA  dc.w   $fad8
00A5AC  dc.w   $fb50
00A5AE  ; data: 0xfb, 0xc8
00A5B0  dc.w   $fc40
00A5B2  dc.w   $fcb8
00A5B4  dc.w   $fd30
00A5B6  ; data: 0xfd, 0xd0
00A5B8  dc.w   $fe48
00A5BA  dc.w   $fee8
00A5BC  ; data: 0xff, 0xb0
00A5BE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A5CC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A5DA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A5E8  ; data: 0x1d, 0x88
00A5EA  ; data: 0xff, 0x60
00A5EC  dc.w   $fec0
00A5EE  dc.w   $fe48
00A5F0  ; data: 0xfd, 0xd0
00A5F2  ; data: 0xfd, 0x80
00A5F4  ; data: 0xfd, 0x08
00A5F6  dc.w   $fcb8
00A5F8  dc.w   $fc40
00A5FA  ; data: 0xfb, 0xc8
00A5FC  dc.w   $fb50
00A5FE  ; data: 0xfb, 0x00
00A600  dc.w   $fab0
00A602  dc.w   $fa60
00A604  dc.w   $fa38
00A606  dc.w   $fa10
00A608  dc.w   $fa38
00A60A  dc.w   $fa60
00A60C  dc.w   $fab0
00A60E  ; data: 0xfb, 0x00
00A610  dc.w   $fb78
00A612  ; data: 0xfb, 0xf0
00A614  dc.w   $fc68
00A616  dc.w   $fce0
00A618  dc.w   $fd58
00A61A  ; data: 0xfd, 0xd0
00A61C  dc.w   $fe48
00A61E  dc.w   $fee8
00A620  ; data: 0xff, 0x88
00A622  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A630  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A63E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A64C  ; data: 0x1d, 0x88
00A64E  dc.w   $ff38
00A650  dc.w   $fec0
00A652  dc.w   $fe48
00A654  ; data: 0xfd, 0xd0
00A656  ; data: 0xfd, 0x80
00A658  dc.w   $fd30
00A65A  dc.w   $fcb8
00A65C  dc.w   $fc68
00A65E  ; data: 0xfb, 0xf0
00A660  dc.w   $fb78
00A662  dc.w   $fb28
00A664  dc.w   $fab0
00A666  dc.w   $fa60
00A668  dc.w   $fa38
00A66A  dc.w   $fa38
00A66C  dc.w   $fa38
00A66E  dc.w   $fa60
00A670  dc.w   $fad8
00A672  dc.w   $fb28
00A674  ; data: 0xfb, 0xa0
00A676  dc.w   $fc18
00A678  dc.w   $fc90
00A67A  ; data: 0xfd, 0x08
00A67C  ; data: 0xfd, 0x80
00A67E  ; data: 0xfd, 0xd0
00A680  dc.w   $fe48
00A682  dc.w   $fee8
00A684  ; data: 0xff, 0x88
00A686  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A694  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A6A2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A6B0  ; data: 0xff, 0xb0
00A6B2  dc.w   $ff10
00A6B4  dc.w   $fe98
00A6B6  dc.w   $fe20
00A6B8  ; data: 0xfd, 0xd0
00A6BA  ; data: 0xfd, 0x80
00A6BC  dc.w   $fd30
00A6BE  dc.w   $fce0
00A6C0  dc.w   $fc90
00A6C2  dc.w   $fc18
00A6C4  ; data: 0xfb, 0xa0
00A6C6  dc.w   $fb28
00A6C8  dc.w   $fad8
00A6CA  dc.w   $fa60
00A6CC  dc.w   $fa38
00A6CE  dc.w   $fa38
00A6D0  dc.w   $fa38
00A6D2  dc.w   $fa88
00A6D4  dc.w   $fad8
00A6D6  dc.w   $fb50
00A6D8  ; data: 0xfb, 0xc8
00A6DA  dc.w   $fc40
00A6DC  dc.w   $fcb8
00A6DE  dc.w   $fd30
00A6E0  ; data: 0xfd, 0x80
00A6E2  ; data: 0xfd, 0xf8
00A6E4  dc.w   $fe48
00A6E6  dc.w   $fec0
00A6E8  ; data: 0xff, 0x60
00A6EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A6F8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A706  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A714  ; data: 0xff, 0x88
00A716  dc.w   $fee8
00A718  dc.w   $fe70
00A71A  dc.w   $fe20
00A71C  ; data: 0xfd, 0xd0
00A71E  ; data: 0xfd, 0xa8
00A720  dc.w   $fd58
00A722  ; data: 0xfd, 0x08
00A724  dc.w   $fcb8
00A726  dc.w   $fc68
00A728  ; data: 0xfb, 0xf0
00A72A  dc.w   $fb50
00A72C  dc.w   $fad8
00A72E  dc.w   $fa88
00A730  dc.w   $fa38
00A732  dc.w   $fa38
00A734  dc.w   $fa38
00A736  dc.w   $fa88
00A738  ; data: 0xfb, 0x00
00A73A  dc.w   $fb78
00A73C  dc.w   $fc18
00A73E  dc.w   $fc90
00A740  ; data: 0xfd, 0x08
00A742  dc.w   $fd58
00A744  ; data: 0xfd, 0xa8
00A746  ; data: 0xfd, 0xf8
00A748  dc.w   $fe48
00A74A  dc.w   $fec0
00A74C  dc.w   $ff38
00A74E  ; data: 0x1d, 0x88
00A750  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A75E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A76C  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
00A77A  dc.w   $fec0
00A77C  dc.w   $fe48
00A77E  ; data: 0xfd, 0xf8
00A780  ; data: 0xfd, 0xd0
00A782  ; data: 0xfd, 0xa8
00A784  ; data: 0xfd, 0x80
00A786  dc.w   $fd58
00A788  ; data: 0xfd, 0x08
00A78A  dc.w   $fc90
00A78C  dc.w   $fc18
00A78E  dc.w   $fb78
00A790  ; data: 0xfb, 0x00
00A792  dc.w   $fa88
00A794  dc.w   $fa38
00A796  dc.w   $fa38
00A798  dc.w   $fa60
00A79A  dc.w   $fab0
00A79C  dc.w   $fb28
00A79E  ; data: 0xfb, 0xa0
00A7A0  dc.w   $fc40
00A7A2  dc.w   $fcb8
00A7A4  dc.w   $fd30
00A7A6  ; data: 0xfd, 0x80
00A7A8  ; data: 0xfd, 0xd0
00A7AA  ; data: 0xfd, 0xf8
00A7AC  dc.w   $fe48
00A7AE  dc.w   $fe98
00A7B0  dc.w   $ff10
00A7B2  ; data: 0x1d, 0x88
00A7B4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A7C2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A7D0  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00A7DE  dc.w   $fe98
00A7E0  dc.w   $fe20
00A7E2  ; data: 0xfd, 0xf8
00A7E4  ; data: 0xfd, 0xd0
00A7E6  ; data: 0xfd, 0xa8
00A7E8  ; data: 0xfd, 0xa8
00A7EA  ; data: 0xfd, 0x80
00A7EC  dc.w   $fd30
00A7EE  dc.w   $fcb8
00A7F0  dc.w   $fc40
00A7F2  ; data: 0xfb, 0xa0
00A7F4  ; data: 0xfb, 0x00
00A7F6  dc.w   $fa88
00A7F8  dc.w   $fa38
00A7FA  dc.w   $fa38
00A7FC  dc.w   $fa60
00A7FE  dc.w   $fab0
00A800  dc.w   $fb28
00A802  ; data: 0xfb, 0xc8
00A804  dc.w   $fc68
00A806  ; data: 0xfd, 0x08
00A808  dc.w   $fd58
00A80A  ; data: 0xfd, 0xa8
00A80C  ; data: 0xfd, 0xf8
00A80E  dc.w   $fe20
00A810  dc.w   $fe48
00A812  dc.w   $fe98
00A814  dc.w   $ff10
00A816  ; data: 0xff, 0xb0
00A818  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A826  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A834  move.b $1db01db0(d1.l * 4), $1d88ff10(d1.l * 4)
00A842  dc.w   $fe70
00A844  ; data: 0xfd, 0xf8
00A846  ; data: 0xfd, 0xd0
00A848  ; data: 0xfd, 0xd0
00A84A  ; data: 0xfd, 0xd0
00A84C  ; data: 0xfd, 0xa8
00A84E  ; data: 0xfd, 0xa8
00A850  dc.w   $fd58
00A852  ; data: 0xfd, 0x08
00A854  dc.w   $fc68
00A856  ; data: 0xfb, 0xc8
00A858  dc.w   $fb28
00A85A  dc.w   $fab0
00A85C  dc.w   $fa38
00A85E  dc.w   $fa38
00A860  dc.w   $fa60
00A862  dc.w   $fab0
00A864  dc.w   $fb50
00A866  ; data: 0xfb, 0xf0
00A868  dc.w   $fcb8
00A86A  dc.w   $fd30
00A86C  ; data: 0xfd, 0xa8
00A86E  ; data: 0xfd, 0xd0
00A870  ; data: 0xfd, 0xf8
00A872  dc.w   $fe20
00A874  dc.w   $fe48
00A876  dc.w   $fe70
00A878  dc.w   $fee8
00A87A  ; data: 0xff, 0x88
00A87C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A88A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A898  move.b $1db01db0(d1.l * 4), $1d60fee8(d1.l * 4)
00A8A6  dc.w   $fe48
00A8A8  ; data: 0xfd, 0xf8
00A8AA  ; data: 0xfd, 0xa8
00A8AC  ; data: 0xfd, 0xa8
00A8AE  ; data: 0xfd, 0xd0
00A8B0  ; data: 0xfd, 0xd0
00A8B2  ; data: 0xfd, 0xd0
00A8B4  ; data: 0xfd, 0xa8
00A8B6  dc.w   $fd30
00A8B8  dc.w   $fc90
00A8BA  ; data: 0xfb, 0xf0
00A8BC  dc.w   $fb28
00A8BE  dc.w   $fab0
00A8C0  dc.w   $fa38
00A8C2  dc.w   $fa38
00A8C4  dc.w   $fa60
00A8C6  dc.w   $fad8
00A8C8  dc.w   $fb78
00A8CA  dc.w   $fc18
00A8CC  dc.w   $fce0
00A8CE  ; data: 0xfd, 0x80
00A8D0  ; data: 0xfd, 0xd0
00A8D2  dc.w   $fe20
00A8D4  dc.w   $fe20
00A8D6  dc.w   $fe20
00A8D8  dc.w   $fe20
00A8DA  dc.w   $fe70
00A8DC  dc.w   $fec0
00A8DE  ; data: 0xff, 0x60
00A8E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A8EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A8FC  move.b $1db01db0(d1.l * 4), $ff88fec0(d1.l * 4)
00A90A  dc.w   $fe20
00A90C  ; data: 0xfd, 0xd0
00A90E  ; data: 0xfd, 0xa8
00A910  ; data: 0xfd, 0xa8
00A912  ; data: 0xfd, 0xd0
00A914  ; data: 0xfd, 0xf8
00A916  ; data: 0xfd, 0xf8
00A918  ; data: 0xfd, 0xd0
00A91A  dc.w   $fd58
00A91C  dc.w   $fce0
00A91E  dc.w   $fc18
00A920  dc.w   $fb50
00A922  dc.w   $fab0
00A924  dc.w   $fa38
00A926  dc.w   $fa10
00A928  dc.w   $fa60
00A92A  dc.w   $fad8
00A92C  dc.w   $fb78
00A92E  dc.w   $fc40
00A930  ; data: 0xfd, 0x08
00A932  ; data: 0xfd, 0xa8
00A934  dc.w   $fe20
00A936  dc.w   $fe48
00A938  dc.w   $fe48
00A93A  dc.w   $fe48
00A93C  dc.w   $fe20
00A93E  dc.w   $fe48
00A940  dc.w   $fe98
00A942  dc.w   $ff38
00A944  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A952  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A960  move.b $1db01db0(d1.l * 4), $ff60fe98(d1.l * 4)
00A96E  ; data: 0xfd, 0xf8
00A970  ; data: 0xfd, 0xa8
00A972  ; data: 0xfd, 0x80
00A974  ; data: 0xfd, 0xa8
00A976  ; data: 0xfd, 0xd0
00A978  dc.w   $fe20
00A97A  dc.w   $fe20
00A97C  ; data: 0xfd, 0xf8
00A97E  ; data: 0xfd, 0xa8
00A980  ; data: 0xfd, 0x08
00A982  dc.w   $fc40
00A984  dc.w   $fb50
00A986  dc.w   $fab0
00A988  dc.w   $fa38
00A98A  dc.w   $fa10
00A98C  dc.w   $fa60
00A98E  dc.w   $fad8
00A990  ; data: 0xfb, 0xa0
00A992  dc.w   $fc90
00A994  dc.w   $fd58
00A996  ; data: 0xfd, 0xf8
00A998  dc.w   $fe48
00A99A  dc.w   $fe70
00A99C  dc.w   $fe70
00A99E  dc.w   $fe48
00A9A0  dc.w   $fe20
00A9A2  dc.w   $fe20
00A9A4  dc.w   $fe70
00A9A6  dc.w   $ff10
00A9A8  ; data: 0x1d, 0x88
00A9AA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A9B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00A9C6  move.b $1db01db0(d1.l * 4), $fe70(a6, invalid.w)
00A9D2  ; data: 0xfd, 0xd0
00A9D4  ; data: 0xfd, 0x80
00A9D6  dc.w   $fd58
00A9D8  ; data: 0xfd, 0xa8
00A9DA  ; data: 0xfd, 0xf8
00A9DC  dc.w   $fe48
00A9DE  dc.w   $fe70
00A9E0  dc.w   $fe48
00A9E2  ; data: 0xfd, 0xd0
00A9E4  dc.w   $fd30
00A9E6  dc.w   $fc68
00A9E8  dc.w   $fb78
00A9EA  dc.w   $fab0
00A9EC  dc.w   $fa38
00A9EE  dc.w   $fa10
00A9F0  dc.w   $fa60
00A9F2  ; data: 0xfb, 0x00
00A9F4  ; data: 0xfb, 0xc8
00A9F6  dc.w   $fcb8
00A9F8  ; data: 0xfd, 0x80
00A9FA  dc.w   $fe20
00A9FC  dc.w   $fe98
00A9FE  dc.w   $fe98
00AA00  dc.w   $fe98
00AA02  dc.w   $fe48
00AA04  dc.w   $fe20
00AA06  dc.w   $fe20
00AA08  dc.w   $fe48
00AA0A  dc.w   $fee8
00AA0C  move.b -(a0), $1db0(a6)
00AA10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AA1E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AA2C  move.b $1db0ff38(d1.l * 4), $48(a6, a7.l)
00AA36  ; data: 0xfd, 0xa8
00AA38  dc.w   $fd58
00AA3A  dc.w   $fd58
00AA3C  ; data: 0xfd, 0x80
00AA3E  ; data: 0xfd, 0xf8
00AA40  dc.w   $fe48
00AA42  dc.w   $fe98
00AA44  dc.w   $fe70
00AA46  dc.w   $fe20
00AA48  dc.w   $fd58
00AA4A  dc.w   $fc68
00AA4C  ; data: 0xfb, 0xa0
00AA4E  dc.w   $fab0
00AA50  dc.w   $fa38
00AA52  dc.w   $fa10
00AA54  dc.w   $fa60
00AA56  ; data: 0xfb, 0x00
00AA58  ; data: 0xfb, 0xc8
00AA5A  dc.w   $fce0
00AA5C  ; data: 0xfd, 0xa8
00AA5E  dc.w   $fe70
00AA60  dc.w   $fec0
00AA62  dc.w   $fee8
00AA64  dc.w   $fe98
00AA66  dc.w   $fe70
00AA68  dc.w   $fe20
00AA6A  ; data: 0xfd, 0xf8
00AA6C  dc.w   $fe20
00AA6E  dc.w   $fec0
00AA70  ; data: 0xff, 0x88
00AA72  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
00AA80  ; data: 0x1d, 0x88
00AA82  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AA90  move.b $1db0ff10(d1.l * 4), $20(a6, a7.l)
00AA9A  ; data: 0xfd, 0x80
00AA9C  dc.w   $fd30
00AA9E  dc.w   $fd30
00AAA0  ; data: 0xfd, 0x80
00AAA2  ; data: 0xfd, 0xf8
00AAA4  dc.w   $fe70
00AAA6  dc.w   $fec0
00AAA8  dc.w   $fec0
00AAAA  dc.w   $fe48
00AAAC  ; data: 0xfd, 0x80
00AAAE  dc.w   $fc90
00AAB0  ; data: 0xfb, 0xa0
00AAB2  dc.w   $fad8
00AAB4  dc.w   $fa38
00AAB6  dc.w   $fa10
00AAB8  dc.w   $fa60
00AABA  ; data: 0xfb, 0x00
00AABC  ; data: 0xfb, 0xf0
00AABE  ; data: 0xfd, 0x08
00AAC0  ; data: 0xfd, 0xf8
00AAC2  dc.w   $fe98
00AAC4  dc.w   $ff10
00AAC6  dc.w   $ff10
00AAC8  dc.w   $fec0
00AACA  dc.w   $fe70
00AACC  ; data: 0xfd, 0xf8
00AACE  ; data: 0xfd, 0xd0
00AAD0  ; data: 0xfd, 0xf8
00AAD2  dc.w   $fe98
00AAD4  ; data: 0xff, 0x60
00AAD6  move.b $1db01db0(d1.l * 4), $1db0ffb0(d1.l * 4)
00AAE4  ; data: 0xff, 0x88
00AAE6  ; data: 0x1d, 0x88
00AAE8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AAF6  move.b $fee8fdf8(d1.l * 4), (a6, invalid.w)
00AB00  ; data: 0xfd, 0x08
00AB02  ; data: 0xfd, 0x08
00AB04  ; data: 0xfd, 0x80
00AB06  dc.w   $fe20
00AB08  dc.w   $fe98
00AB0A  dc.w   $fee8
00AB0C  dc.w   $fee8
00AB0E  dc.w   $fe70
00AB10  ; data: 0xfd, 0xa8
00AB12  dc.w   $fcb8
00AB14  ; data: 0xfb, 0xc8
00AB16  dc.w   $fad8
00AB18  dc.w   $fa38
00AB1A  dc.w   $fa10
00AB1C  dc.w   $fa60
00AB1E  dc.w   $fb28
00AB20  dc.w   $fc18
00AB22  dc.w   $fd30
00AB24  dc.w   $fe20
00AB26  dc.w   $fee8
00AB28  dc.w   $ff38
00AB2A  dc.w   $ff38
00AB2C  dc.w   $fee8
00AB2E  dc.w   $fe70
00AB30  ; data: 0xfd, 0xf8
00AB32  ; data: 0xfd, 0xd0
00AB34  ; data: 0xfd, 0xd0
00AB36  dc.w   $fe70
00AB38  ; data: 0xff, 0x60
00AB3A  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
00AB48  ; data: 0xff, 0x60
00AB4A  ; data: 0xff, 0xb0
00AB4C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AB5A  move.b $fee8fdd0(d1.l * 4), $fce0fd08(a6, a7.l * 4)
00AB68  ; data: 0xfd, 0x80
00AB6A  dc.w   $fe20
00AB6C  dc.w   $fec0
00AB6E  dc.w   $ff10
00AB70  dc.w   $ff10
00AB72  dc.w   $fe98
00AB74  ; data: 0xfd, 0xd0
00AB76  dc.w   $fce0
00AB78  ; data: 0xfb, 0xc8
00AB7A  dc.w   $fad8
00AB7C  dc.w   $fa38
00AB7E  dc.w   $fa10
00AB80  dc.w   $fa60
00AB82  dc.w   $fb28
00AB84  dc.w   $fc18
00AB86  dc.w   $fd58
00AB88  dc.w   $fe48
00AB8A  dc.w   $ff10
00AB8C  ; data: 0xff, 0x60
00AB8E  ; data: 0xff, 0x60
00AB90  dc.w   $ff10
00AB92  dc.w   $fe70
00AB94  ; data: 0xfd, 0xf8
00AB96  ; data: 0xfd, 0xa8
00AB98  ; data: 0xfd, 0xd0
00AB9A  dc.w   $fe48
00AB9C  dc.w   $ff38
00AB9E  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00ABAC  dc.w   $ff10
00ABAE  ; data: 0xff, 0x60
00ABB0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00ABBE  move.b $fec0fda8(d1.l * 4), (a6, a7.l * 4)
00ABC8  dc.w   $fcb8
00ABCA  dc.w   $fce0
00ABCC  ; data: 0xfd, 0x80
00ABCE  dc.w   $fe20
00ABD0  dc.w   $fec0
00ABD2  dc.w   $ff38
00ABD4  dc.w   $ff38
00ABD6  dc.w   $fee8
00ABD8  dc.w   $fe20
00ABDA  ; data: 0xfd, 0x08
00ABDC  ; data: 0xfb, 0xf0
00ABDE  dc.w   $fad8
00ABE0  dc.w   $fa38
00ABE2  dc.w   $fa10
00ABE4  dc.w   $fa60
00ABE6  dc.w   $fb28
00ABE8  dc.w   $fc40
00ABEA  ; data: 0xfd, 0x80
00ABEC  dc.w   $fe70
00ABEE  dc.w   $ff38
00ABF0  ; data: 0xff, 0x88
00ABF2  ; data: 0xff, 0x88
00ABF4  dc.w   $ff10
00ABF6  dc.w   $fe98
00ABF8  ; data: 0xfd, 0xf8
00ABFA  ; data: 0xfd, 0xa8
00ABFC  ; data: 0xfd, 0xa8
00ABFE  dc.w   $fe20
00AC00  dc.w   $ff10
00AC02  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00AC10  dc.w   $fee8
00AC12  dc.w   $ff38
00AC14  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AC22  move.b $fe98fda8(d1.l * 4), -$20(a6, a7.l)
00AC2C  dc.w   $fcb8
00AC2E  dc.w   $fce0
00AC30  ; data: 0xfd, 0x80
00AC32  dc.w   $fe20
00AC34  dc.w   $fee8
00AC36  ; data: 0xff, 0x60
00AC38  ; data: 0xff, 0x60
00AC3A  dc.w   $ff10
00AC3C  dc.w   $fe20
00AC3E  dc.w   $fd30
00AC40  ; data: 0xfb, 0xf0
00AC42  ; data: 0xfb, 0x00
00AC44  dc.w   $fa60
00AC46  dc.w   $fa10
00AC48  dc.w   $fa88
00AC4A  dc.w   $fb50
00AC4C  dc.w   $fc68
00AC4E  ; data: 0xfd, 0x80
00AC50  dc.w   $fe98
00AC52  ; data: 0xff, 0x60
00AC54  ; data: 0x1d, 0x88
00AC56  ; data: 0xff, 0xb0
00AC58  dc.w   $ff38
00AC5A  dc.w   $fe98
00AC5C  ; data: 0xfd, 0xf8
00AC5E  ; data: 0xfd, 0x80
00AC60  ; data: 0xfd, 0x80
00AC62  ; data: 0xfd, 0xf8
00AC64  dc.w   $fee8
00AC66  move.b $1db01db0(d1.l * 4), $1db0fee8(d1.l * 4)
00AC74  dc.w   $fec0
00AC76  dc.w   $ff10
00AC78  ; data: 0x1d, 0x88
00AC7A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AC88  ; data: 0x1d, 0x88
00AC8A  dc.w   $fe98
00AC8C  ; data: 0xfd, 0x80
00AC8E  dc.w   $fcb8
00AC90  dc.w   $fc90
00AC92  dc.w   $fce0
00AC94  ; data: 0xfd, 0x80
00AC96  dc.w   $fe48
00AC98  dc.w   $fee8
00AC9A  ; data: 0xff, 0x88
00AC9C  ; data: 0xff, 0x88
00AC9E  dc.w   $ff38
00ACA0  dc.w   $fe48
00ACA2  dc.w   $fd30
00ACA4  dc.w   $fc18
00ACA6  ; data: 0xfb, 0x00
00ACA8  dc.w   $fa60
00ACAA  dc.w   $fa38
00ACAC  dc.w   $fa88
00ACAE  dc.w   $fb50
00ACB0  dc.w   $fc68
00ACB2  ; data: 0xfd, 0xa8
00ACB4  dc.w   $fec0
00ACB6  ; data: 0xff, 0x88
00ACB8  move.b (d1.l * 4), $fe98(a6, invalid.w)
00ACC0  ; data: 0xfd, 0xf8
00ACC2  ; data: 0xfd, 0x80
00ACC4  ; data: 0xfd, 0x80
00ACC6  ; data: 0xfd, 0xf8
00ACC8  dc.w   $fee8
00ACCA  move.b $1db01db0(d1.l * 4), $1db0fec0(d1.l * 4)
00ACD8  dc.w   $fe98
00ACDA  dc.w   $fee8
00ACDC  ; data: 0xff, 0xb0
00ACDE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00ACEC  ; data: 0x1d, 0x88
00ACEE  dc.w   $fe70
00ACF0  dc.w   $fd58
00ACF2  dc.w   $fcb8
00ACF4  dc.w   $fc90
00ACF6  dc.w   $fcb8
00ACF8  ; data: 0xfd, 0x80
00ACFA  dc.w   $fe48
00ACFC  dc.w   $ff10
00ACFE  ; data: 0xff, 0x88
00AD00  ; data: 0xff, 0xb0
00AD02  dc.w   $ff38
00AD04  dc.w   $fe70
00AD06  dc.w   $fd58
00AD08  dc.w   $fc18
00AD0A  dc.w   $fb28
00AD0C  dc.w   $fa60
00AD0E  dc.w   $fa38
00AD10  dc.w   $fa88
00AD12  dc.w   $fb78
00AD14  dc.w   $fc90
00AD16  ; data: 0xfd, 0xd0
00AD18  dc.w   $fee8
00AD1A  move.b -(a0), $1db0(a6)
00AD1E  move.b $fec0(a0, invalid.w), $fd80fd58(invalid.w)
00AD2A  ; data: 0xfd, 0xd0
00AD2C  dc.w   $fec0
00AD2E  move.b $1db01db0(d1.l * 4), $1db0fe98(d1.l * 4)
00AD3C  dc.w   $fe70
00AD3E  dc.w   $fec0
00AD40  ; data: 0xff, 0x88
00AD42  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AD50  move.b -(a0), -$190(a6)
00AD54  dc.w   $fd58
00AD56  dc.w   $fc90
00AD58  dc.w   $fc68
00AD5A  dc.w   $fcb8
00AD5C  ; data: 0xfd, 0x80
00AD5E  dc.w   $fe48
00AD60  dc.w   $ff10
00AD62  ; data: 0xff, 0xb0
00AD64  ; data: 0x1d, 0x88
00AD66  ; data: 0xff, 0x60
00AD68  dc.w   $fe98
00AD6A  ; data: 0xfd, 0x80
00AD6C  dc.w   $fc40
00AD6E  dc.w   $fb28
00AD70  dc.w   $fa88
00AD72  dc.w   $fa38
00AD74  dc.w   $fab0
00AD76  dc.w   $fb78
00AD78  dc.w   $fcb8
00AD7A  ; data: 0xfd, 0xf8
00AD7C  dc.w   $ff10
00AD7E  ; data: 0x1d, 0x88
00AD80  move.b $ff88fec0(d1.l * 4), $fd80fd58(invalid.w)
00AD8E  ; data: 0xfd, 0xd0
00AD90  dc.w   $fec0
00AD92  move.b $1db01db0(d1.l * 4), $1db0fe70(d1.l * 4)
00ADA0  dc.w   $fe48
00ADA2  dc.w   $fe98
00ADA4  ; data: 0xff, 0x60
00ADA6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00ADB4  ; data: 0xff, 0xb0
00ADB6  dc.w   $fe48
00ADB8  dc.w   $fd30
00ADBA  dc.w   $fc90
00ADBC  dc.w   $fc68
00ADBE  dc.w   $fcb8
00ADC0  ; data: 0xfd, 0x80
00ADC2  dc.w   $fe48
00ADC4  dc.w   $ff38
00ADC6  move.b -(a0), $1d88(a6)
00ADCA  ; data: 0xff, 0x88
00ADCC  dc.w   $fec0
00ADCE  ; data: 0xfd, 0x80
00ADD0  dc.w   $fc68
00ADD2  dc.w   $fb50
00ADD4  dc.w   $fa88
00ADD6  dc.w   $fa60
00ADD8  dc.w   $fab0
00ADDA  ; data: 0xfb, 0xa0
00ADDC  dc.w   $fcb8
00ADDE  dc.w   $fe20
00ADE0  dc.w   $ff38
00ADE2  move.b $1db0ff88(d1.l * 4), -$40(a6, a7.l)
00ADEC  ; data: 0xfd, 0xf8
00ADEE  ; data: 0xfd, 0x80
00ADF0  dc.w   $fd58
00ADF2  ; data: 0xfd, 0xd0
00ADF4  dc.w   $fe98
00ADF6  move.b $1db01db0(d1.l * 4), $1db0fe48(d1.l * 4)
00AE04  dc.w   $fe20
00AE06  dc.w   $fe70
00AE08  dc.w   $ff38
00AE0A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AE18  ; data: 0xff, 0xb0
00AE1A  dc.w   $fe48
00AE1C  dc.w   $fd30
00AE1E  dc.w   $fc90
00AE20  dc.w   $fc68
00AE22  dc.w   $fcb8
00AE24  ; data: 0xfd, 0x80
00AE26  dc.w   $fe70
00AE28  dc.w   $ff38
00AE2A  ; data: 0x1d, 0x88
00AE2C  move.b $fec0fda8(a7.l * 8), $68(a6, a7.l)
00AE36  dc.w   $fb50
00AE38  dc.w   $fab0
00AE3A  dc.w   $fa60
00AE3C  dc.w   $fad8
00AE3E  ; data: 0xfb, 0xa0
00AE40  dc.w   $fce0
00AE42  dc.w   $fe20
00AE44  ; data: 0xff, 0x60
00AE46  move.b $1db0ffb0(d1.l * 4), -$40(a6, a7.l)
00AE50  ; data: 0xfd, 0xf8
00AE52  ; data: 0xfd, 0x80
00AE54  dc.w   $fd58
00AE56  ; data: 0xfd, 0xa8
00AE58  dc.w   $fe98
00AE5A  ; data: 0x1d, 0x88
00AE5C  move.b $1db01db0(d1.l * 4), $fe48fe20(d1.l * 4)
00AE6A  dc.w   $fe70
00AE6C  dc.w   $ff38
00AE6E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AE7C  ; data: 0xff, 0x88
00AE7E  dc.w   $fe48
00AE80  dc.w   $fd30
00AE82  dc.w   $fc90
00AE84  dc.w   $fc68
00AE86  dc.w   $fcb8
00AE88  ; data: 0xfd, 0x80
00AE8A  dc.w   $fe70
00AE8C  dc.w   $ff38
00AE8E  ; data: 0x1d, 0x88
00AE90  move.b $fee8(a0, invalid.w), (invalid.w)
00AE98  dc.w   $fc90
00AE9A  dc.w   $fb78
00AE9C  dc.w   $fab0
00AE9E  dc.w   $fa88
00AEA0  ; data: 0xfb, 0x00
00AEA2  ; data: 0xfb, 0xc8
00AEA4  ; data: 0xfd, 0x08
00AEA6  dc.w   $fe48
00AEA8  ; data: 0xff, 0x60
00AEAA  move.b $1db0ffb0(d1.l * 4), -$18(a6, a7.l)
00AEB4  ; data: 0xfd, 0xf8
00AEB6  ; data: 0xfd, 0x80
00AEB8  dc.w   $fd58
00AEBA  ; data: 0xfd, 0xa8
00AEBC  dc.w   $fe98
00AEBE  ; data: 0x1d, 0x88
00AEC0  move.b $1db01db0(d1.l * 4), $fe20fdf8(d1.l * 4)
00AECE  dc.w   $fe48
00AED0  dc.w   $ff10
00AED2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AEE0  ; data: 0xff, 0x88
00AEE2  dc.w   $fe48
00AEE4  dc.w   $fd30
00AEE6  dc.w   $fc68
00AEE8  dc.w   $fc68
00AEEA  dc.w   $fcb8
00AEEC  ; data: 0xfd, 0x80
00AEEE  dc.w   $fe70
00AEF0  ; data: 0xff, 0x60
00AEF2  ; data: 0x1d, 0x88
00AEF4  move.b $fee8(a0, invalid.w), (invalid.w)
00AEFC  dc.w   $fc90
00AEFE  ; data: 0xfb, 0xa0
00AF00  dc.w   $fad8
00AF02  dc.w   $fab0
00AF04  ; data: 0xfb, 0x00
00AF06  ; data: 0xfb, 0xf0
00AF08  ; data: 0xfd, 0x08
00AF0A  dc.w   $fe70
00AF0C  ; data: 0xff, 0x88
00AF0E  move.b $1db01d60(d1.l * 4), -$18(a6, a7.l)
00AF18  ; data: 0xfd, 0xf8
00AF1A  ; data: 0xfd, 0x80
00AF1C  dc.w   $fd58
00AF1E  ; data: 0xfd, 0xa8
00AF20  dc.w   $fe98
00AF22  ; data: 0x1d, 0x88
00AF24  move.b $1db01db0(d1.l * 4), $fe20fdf8(d1.l * 4)
00AF32  dc.w   $fe48
00AF34  dc.w   $ff10
00AF36  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AF44  ; data: 0xff, 0x60
00AF46  dc.w   $fe20
00AF48  dc.w   $fd30
00AF4A  dc.w   $fc90
00AF4C  dc.w   $fc68
00AF4E  dc.w   $fcb8
00AF50  ; data: 0xfd, 0x80
00AF52  dc.w   $fe70
00AF54  ; data: 0xff, 0x60
00AF56  move.b $1d88ff10(d1.l * 4), $fcb8fba0(invalid.w)
00AF64  ; data: 0xfb, 0x00
00AF66  dc.w   $fad8
00AF68  dc.w   $fb28
00AF6A  dc.w   $fc18
00AF6C  dc.w   $fd30
00AF6E  dc.w   $fe70
00AF70  ; data: 0xff, 0x88
00AF72  move.b $1db01d60(d1.l * 4), -$18(a6, a7.l)
00AF7C  dc.w   $fe20
00AF7E  ; data: 0xfd, 0x80
00AF80  dc.w   $fd58
00AF82  ; data: 0xfd, 0xa8
00AF84  dc.w   $fe98
00AF86  ; data: 0x1d, 0x88
00AF88  move.b $1db01db0(d1.l * 4), $fe20fdf8(d1.l * 4)
00AF96  dc.w   $fe48
00AF98  dc.w   $fee8
00AF9A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00AFA8  ; data: 0xff, 0x60
00AFAA  dc.w   $fe20
00AFAC  dc.w   $fd30
00AFAE  dc.w   $fc90
00AFB0  dc.w   $fc68
00AFB2  dc.w   $fcb8
00AFB4  ; data: 0xfd, 0x80
00AFB6  dc.w   $fe70
00AFB8  ; data: 0xff, 0x60
00AFBA  move.b $1d88ff10(d1.l * 4), $fce0fbc8(invalid.w)
00AFC8  dc.w   $fb28
00AFCA  ; data: 0xfb, 0x00
00AFCC  dc.w   $fb50
00AFCE  dc.w   $fc18
00AFD0  dc.w   $fd58
00AFD2  dc.w   $fe98
00AFD4  ; data: 0xff, 0x88
00AFD6  move.b $1db01d88(d1.l * 4), -$18(a6, a7.l)
00AFE0  dc.w   $fe20
00AFE2  ; data: 0xfd, 0x80
00AFE4  dc.w   $fd58
00AFE6  ; data: 0xfd, 0xa8
00AFE8  dc.w   $fe98
00AFEA  move.b -(a0), $1db0(a6)
00AFEE  move.b $1db01db0(d1.l * 4), $20(a6, a7.l)
00AFF8  ; data: 0xfd, 0xd0
00AFFA  dc.w   $fe20
00AFFC  dc.w   $fee8
00AFFE  ; data: 0x1d, 0x88
00B000  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
00B00E  dc.w   $fe20
00B010  dc.w   $fd30
00B012  dc.w   $fc90
00B014  dc.w   $fc68
00B016  dc.w   $fce0
00B018  ; data: 0xfd, 0x80
00B01A  dc.w   $fe70
00B01C  ; data: 0xff, 0x60
00B01E  move.b $1d88ff10(d1.l * 4), $20(a6, a7.l)
00B028  dc.w   $fce0
00B02A  ; data: 0xfb, 0xf0
00B02C  dc.w   $fb50
00B02E  dc.w   $fb28
00B030  dc.w   $fb78
00B032  dc.w   $fc40
00B034  dc.w   $fd58
00B036  dc.w   $fe98
00B038  ; data: 0xff, 0xb0
00B03A  move.b $1db01d88(d1.l * 4), -$18(a6, a7.l)
00B044  dc.w   $fe20
00B046  ; data: 0xfd, 0xa8
00B048  ; data: 0xfd, 0x80
00B04A  ; data: 0xfd, 0xd0
00B04C  dc.w   $fe98
00B04E  move.b -(a0), $1db0(a6)
00B052  move.b $1db01db0(d1.l * 4), $20(a6, a7.l)
00B05C  ; data: 0xfd, 0xd0
00B05E  dc.w   $fe20
00B060  dc.w   $fee8
00B062  ; data: 0x1d, 0x88
00B064  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00B072  dc.w   $fe20
00B074  dc.w   $fd30
00B076  dc.w   $fc90
00B078  dc.w   $fc90
00B07A  dc.w   $fce0
00B07C  ; data: 0xfd, 0xa8
00B07E  dc.w   $fe70
00B080  ; data: 0xff, 0x60
00B082  ; data: 0x1d, 0x88
00B084  move.b (d1.l * 4), (a6, a7.l * 8)
00B08A  dc.w   $fe20
00B08C  ; data: 0xfd, 0x08
00B08E  dc.w   $fc18
00B090  dc.w   $fb78
00B092  dc.w   $fb50
00B094  ; data: 0xfb, 0xa0
00B096  dc.w   $fc68
00B098  ; data: 0xfd, 0x80
00B09A  dc.w   $fe98
00B09C  ; data: 0xff, 0xb0
00B09E  move.b $1db01d88(d1.l * 4), (a6, a7.l * 8)
00B0A8  dc.w   $fe48
00B0AA  ; data: 0xfd, 0xa8
00B0AC  ; data: 0xfd, 0x80
00B0AE  ; data: 0xfd, 0xd0
00B0B0  dc.w   $fe98
00B0B2  move.b -(a0), $1db0(a6)
00B0B6  move.b $1db01db0(d1.l * 4), $20(a6, a7.l)
00B0C0  ; data: 0xfd, 0xd0
00B0C2  dc.w   $fe20
00B0C4  dc.w   $fec0
00B0C6  move.b -(a0), $1db0(a6)
00B0CA  move.b $1db01db0(d1.l * 4), $ff38fe20(d1.l * 4)
00B0D8  dc.w   $fd30
00B0DA  dc.w   $fcb8
00B0DC  dc.w   $fc90
00B0DE  ; data: 0xfd, 0x08
00B0E0  ; data: 0xfd, 0xa8
00B0E2  dc.w   $fe70
00B0E4  ; data: 0xff, 0x60
00B0E6  ; data: 0x1d, 0x88
00B0E8  move.b (d1.l * 4), (a6, a7.l * 8)
00B0EE  dc.w   $fe20
00B0F0  dc.w   $fd30
00B0F2  dc.w   $fc40
00B0F4  ; data: 0xfb, 0xa0
00B0F6  dc.w   $fb78
00B0F8  ; data: 0xfb, 0xc8
00B0FA  dc.w   $fc90
00B0FC  ; data: 0xfd, 0xa8
00B0FE  dc.w   $fec0
00B100  ; data: 0xff, 0xb0
00B102  move.b $1db01d88(d1.l * 4), (a6, a7.l * 8)
00B10C  dc.w   $fe48
00B10E  ; data: 0xfd, 0xd0
00B110  ; data: 0xfd, 0xa8
00B112  ; data: 0xfd, 0xd0
00B114  dc.w   $fe98
00B116  ; data: 0xff, 0xb0
00B118  move.b $1db01db0(d1.l * 4), $fe20fdf8(d1.l * 4)
00B126  dc.w   $fe20
00B128  dc.w   $fec0
00B12A  ; data: 0xff, 0xb0
00B12C  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00B13A  dc.w   $fe20
00B13C  dc.w   $fd58
00B13E  dc.w   $fcb8
00B140  dc.w   $fcb8
00B142  ; data: 0xfd, 0x08
00B144  ; data: 0xfd, 0xa8
00B146  dc.w   $fe98
00B148  dc.w   $ff38
00B14A  ; data: 0x1d, 0x88
00B14C  move.b $ff10(a0, invalid.w), $48(a6, a7.l)
00B154  dc.w   $fd30
00B156  dc.w   $fc68
00B158  ; data: 0xfb, 0xc8
00B15A  ; data: 0xfb, 0xa0
00B15C  ; data: 0xfb, 0xf0
00B15E  dc.w   $fcb8
00B160  ; data: 0xfd, 0xa8
00B162  dc.w   $fec0
00B164  ; data: 0xff, 0xb0
00B166  move.b $1db01d88(d1.l * 4), (a6, a7.l * 8)
00B170  dc.w   $fe48
00B172  ; data: 0xfd, 0xd0
00B174  ; data: 0xfd, 0xa8
00B176  ; data: 0xfd, 0xf8
00B178  dc.w   $fe98
00B17A  ; data: 0xff, 0xb0
00B17C  move.b $1db01db0(d1.l * 4), $fe20fdf8(d1.l * 4)
00B18A  dc.w   $fe20
00B18C  dc.w   $fec0
00B18E  ; data: 0xff, 0x88
00B190  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00B19E  dc.w   $fe20
00B1A0  dc.w   $fd58
00B1A2  dc.w   $fce0
00B1A4  dc.w   $fce0
00B1A6  dc.w   $fd30
00B1A8  ; data: 0xfd, 0xd0
00B1AA  dc.w   $fe98
00B1AC  dc.w   $ff38
00B1AE  ; data: 0x1d, 0x88
00B1B0  move.b $ff10(a0, invalid.w), $48(a6, a7.l)
00B1B8  dc.w   $fd58
00B1BA  dc.w   $fc90
00B1BC  dc.w   $fc18
00B1BE  ; data: 0xfb, 0xf0
00B1C0  dc.w   $fc40
00B1C2  dc.w   $fce0
00B1C4  ; data: 0xfd, 0xd0
00B1C6  dc.w   $fec0
00B1C8  ; data: 0xff, 0xb0
00B1CA  move.b $1db01d88(d1.l * 4), (a6, a7.l * 8)
00B1D4  dc.w   $fe70
00B1D6  ; data: 0xfd, 0xf8
00B1D8  ; data: 0xfd, 0xd0
00B1DA  dc.w   $fe20
00B1DC  dc.w   $fec0
00B1DE  ; data: 0xff, 0xb0
00B1E0  move.b $1db01db0(d1.l * 4), $fe20fdf8(d1.l * 4)
00B1EE  dc.w   $fe48
00B1F0  dc.w   $fec0
00B1F2  ; data: 0xff, 0x88
00B1F4  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00B202  dc.w   $fe20
00B204  dc.w   $fd58
00B206  ; data: 0xfd, 0x08
00B208  dc.w   $fce0
00B20A  dc.w   $fd30
00B20C  ; data: 0xfd, 0xd0
00B20E  dc.w   $fe98
00B210  dc.w   $ff38
00B212  move.b -(a0), $1d88(a6)
00B216  ; data: 0xff, 0xb0
00B218  dc.w   $ff10
00B21A  dc.w   $fe48
00B21C  ; data: 0xfd, 0x80
00B21E  dc.w   $fcb8
00B220  dc.w   $fc40
00B222  dc.w   $fc18
00B224  dc.w   $fc68
00B226  ; data: 0xfd, 0x08
00B228  ; data: 0xfd, 0xf8
00B22A  dc.w   $fec0
00B22C  ; data: 0xff, 0xb0
00B22E  move.b $1db01d60(d1.l * 4), (a6, a7.l * 8)
00B238  dc.w   $fe70
00B23A  dc.w   $fe20
00B23C  ; data: 0xfd, 0xf8
00B23E  dc.w   $fe20
00B240  dc.w   $fec0
00B242  ; data: 0xff, 0xb0
00B244  move.b $1db01db0(d1.l * 4), $fe48fe20(d1.l * 4)
00B252  dc.w   $fe48
00B254  dc.w   $fec0
00B256  ; data: 0xff, 0x60
00B258  move.b $1db01db0(d1.l * 4), $1d88ff10(d1.l * 4)
00B266  dc.w   $fe20
00B268  ; data: 0xfd, 0x80
00B26A  ; data: 0xfd, 0x08
00B26C  ; data: 0xfd, 0x08
00B26E  dc.w   $fd58
00B270  ; data: 0xfd, 0xd0
00B272  dc.w   $fe98
00B274  dc.w   $ff38
00B276  ; data: 0xff, 0xb0
00B278  ; data: 0x1d, 0x88
00B27A  ; data: 0xff, 0x88
00B27C  dc.w   $ff10
00B27E  dc.w   $fe48
00B280  ; data: 0xfd, 0x80
00B282  dc.w   $fce0
00B284  dc.w   $fc68
00B286  dc.w   $fc40
00B288  dc.w   $fc90
00B28A  dc.w   $fd30
00B28C  ; data: 0xfd, 0xf8
00B28E  dc.w   $fee8
00B290  ; data: 0xff, 0xb0
00B292  move.b $1db01d60(d1.l * 4), $fe98fe20(a6, a7.l * 8)
00B2A0  ; data: 0xfd, 0xf8
00B2A2  dc.w   $fe48
00B2A4  dc.w   $fee8
00B2A6  ; data: 0xff, 0xb0
00B2A8  move.b $1db01db0(d1.l * 4), $fe48fe20(d1.l * 4)
00B2B6  dc.w   $fe48
00B2B8  dc.w   $fec0
00B2BA  ; data: 0xff, 0x60
00B2BC  move.b $1db01db0(d1.l * 4), $1d88ff10(d1.l * 4)
00B2CA  dc.w   $fe48
00B2CC  ; data: 0xfd, 0xa8
00B2CE  dc.w   $fd30
00B2D0  dc.w   $fd30
00B2D2  dc.w   $fd58
00B2D4  ; data: 0xfd, 0xf8
00B2D6  dc.w   $fe98
00B2D8  dc.w   $ff10
00B2DA  ; data: 0xff, 0x88
00B2DC  move.b -(a0), -$78(a6)
00B2E0  dc.w   $ff10
00B2E2  dc.w   $fe70
00B2E4  ; data: 0xfd, 0xa8
00B2E6  ; data: 0xfd, 0x08
00B2E8  dc.w   $fc90
00B2EA  dc.w   $fc90
00B2EC  dc.w   $fcb8
00B2EE  dc.w   $fd58
00B2F0  dc.w   $fe20
00B2F2  dc.w   $fee8
00B2F4  ; data: 0xff, 0x88
00B2F6  move.b $1db01d60(d1.l * 4), $fe98fe48(a6, a7.l * 8)
00B304  dc.w   $fe20
00B306  dc.w   $fe70
00B308  dc.w   $fee8
00B30A  ; data: 0xff, 0xb0
00B30C  move.b $1db01db0(d1.l * 4), $fe48fe20(d1.l * 4)
00B31A  dc.w   $fe70
00B31C  dc.w   $fec0
00B31E  ; data: 0xff, 0x60
00B320  ; data: 0x1d, 0x88
00B322  move.b $1db01db0(d1.l * 4), $fee8(a6, invalid.w)
00B32E  dc.w   $fe48
00B330  ; data: 0xfd, 0xa8
00B332  dc.w   $fd58
00B334  dc.w   $fd58
00B336  ; data: 0xfd, 0x80
00B338  ; data: 0xfd, 0xf8
00B33A  dc.w   $fe98
00B33C  dc.w   $ff10
00B33E  ; data: 0xff, 0x88
00B340  ; data: 0xff, 0x88
00B342  ; data: 0xff, 0x60
00B344  dc.w   $ff10
00B346  dc.w   $fe70
00B348  ; data: 0xfd, 0xd0
00B34A  dc.w   $fd30
00B34C  dc.w   $fce0
00B34E  dc.w   $fcb8
00B350  ; data: 0xfd, 0x08
00B352  ; data: 0xfd, 0x80
00B354  dc.w   $fe20
00B356  dc.w   $fee8
00B358  ; data: 0xff, 0x88
00B35A  move.b $1db0ffb0(d1.l * 4), $fec0fe70(a6, a7.l * 8)
00B368  dc.w   $fe48
00B36A  dc.w   $fe70
00B36C  dc.w   $ff10
00B36E  move.b -(a0), $1db0(a6)
00B372  move.b $1db01db0(d1.l * 4), $70(a6, a7.l)
00B37C  dc.w   $fe48
00B37E  dc.w   $fe70
00B380  dc.w   $fec0
00B382  dc.w   $ff38
00B384  ; data: 0x1d, 0x88
00B386  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00B390  dc.w   $fee8
00B392  dc.w   $fe48
00B394  ; data: 0xfd, 0xd0
00B396  ; data: 0xfd, 0x80
00B398  ; data: 0xfd, 0x80
00B39A  ; data: 0xfd, 0xa8
00B39C  dc.w   $fe20
00B39E  dc.w   $fe98
00B3A0  dc.w   $ff10
00B3A2  ; data: 0xff, 0x60
00B3A4  ; data: 0xff, 0x88
00B3A6  ; data: 0xff, 0x60
00B3A8  dc.w   $fee8
00B3AA  dc.w   $fe70
00B3AC  ; data: 0xfd, 0xd0
00B3AE  dc.w   $fd58
00B3B0  ; data: 0xfd, 0x08
00B3B2  ; data: 0xfd, 0x08
00B3B4  dc.w   $fd30
00B3B6  ; data: 0xfd, 0xa8
00B3B8  dc.w   $fe48
00B3BA  dc.w   $fee8
00B3BC  ; data: 0xff, 0x88
00B3BE  ; data: 0x1d, 0x88
00B3C0  move.b $ffb0ff38(d1.l * 4), -$40(a6, a7.l)
00B3CA  dc.w   $fe70
00B3CC  dc.w   $fe70
00B3CE  dc.w   $fe98
00B3D0  dc.w   $ff10
00B3D2  move.b -(a0), $1db0(a6)
00B3D6  move.b $1db01db0(d1.l * 4), $70(a6, a7.l)
00B3E0  dc.w   $fe70
00B3E2  dc.w   $fe70
00B3E4  dc.w   $fec0
00B3E6  dc.w   $ff38
00B3E8  move.b -(a0), $1db0(a6)
00B3EC  move.b $1db0ff88(d1.l * 4), -$18(a6, a7.l)
00B3F6  dc.w   $fe48
00B3F8  ; data: 0xfd, 0xd0
00B3FA  ; data: 0xfd, 0xa8
00B3FC  ; data: 0xfd, 0x80
00B3FE  ; data: 0xfd, 0xd0
00B400  dc.w   $fe20
00B402  dc.w   $fe98
00B404  dc.w   $fee8
00B406  dc.w   $ff38
00B408  ; data: 0xff, 0x60
00B40A  dc.w   $ff38
00B40C  dc.w   $fee8
00B40E  dc.w   $fe70
00B410  ; data: 0xfd, 0xf8
00B412  ; data: 0xfd, 0x80
00B414  dc.w   $fd30
00B416  dc.w   $fd30
00B418  dc.w   $fd58
00B41A  ; data: 0xfd, 0xd0
00B41C  dc.w   $fe48
00B41E  dc.w   $fee8
00B420  ; data: 0xff, 0x60
00B422  ; data: 0x1d, 0x88
00B424  move.b (d1.l * 4), (a7.l * 8)
00B42A  dc.w   $ff38
00B42C  dc.w   $fee8
00B42E  dc.w   $fe98
00B430  dc.w   $fe98
00B432  dc.w   $fec0
00B434  dc.w   $ff38
00B436  move.b -(a0), $1db0(a6)
00B43A  move.b $1db01db0(d1.l * 4), -$68(a6, a7.l)
00B444  dc.w   $fe70
00B446  dc.w   $fe98
00B448  dc.w   $fec0
00B44A  dc.w   $ff38
00B44C  ; data: 0xff, 0x88
00B44E  ; data: 0x1d, 0x88
00B450  move.b $1d88ff60(d1.l * 4), -$18(a6, a7.l)
00B45A  dc.w   $fe70
00B45C  ; data: 0xfd, 0xf8
00B45E  ; data: 0xfd, 0xa8
00B460  ; data: 0xfd, 0xa8
00B462  ; data: 0xfd, 0xd0
00B464  dc.w   $fe20
00B466  dc.w   $fe98
00B468  dc.w   $fee8
00B46A  dc.w   $ff38
00B46C  dc.w   $ff38
00B46E  dc.w   $ff38
00B470  dc.w   $fee8
00B472  dc.w   $fe70
00B474  dc.w   $fe20
00B476  ; data: 0xfd, 0xa8
00B478  ; data: 0xfd, 0x80
00B47A  dc.w   $fd58
00B47C  ; data: 0xfd, 0x80
00B47E  ; data: 0xfd, 0xf8
00B480  dc.w   $fe70
00B482  dc.w   $fee8
00B484  ; data: 0xff, 0x60
00B486  move.b -(a0), $1d88(a6)
00B48A  ; data: 0x1d, 0x88
00B48C  ; data: 0xff, 0x88
00B48E  dc.w   $ff38
00B490  dc.w   $fee8
00B492  dc.w   $fec0
00B494  dc.w   $fec0
00B496  dc.w   $fee8
00B498  dc.w   $ff38
00B49A  move.b -(a0), $1db0(a6)
00B49E  move.b $1db01db0(d1.l * 4), -$68(a6, a7.l)
00B4A8  dc.w   $fe98
00B4AA  dc.w   $fe98
00B4AC  dc.w   $fee8
00B4AE  dc.w   $ff38
00B4B0  ; data: 0xff, 0x88
00B4B2  move.b -(a0), $1d88(a6)
00B4B6  ; data: 0x1d, 0x88
00B4B8  ; data: 0xff, 0xb0
00B4BA  dc.w   $ff38
00B4BC  dc.w   $fee8
00B4BE  dc.w   $fe70
00B4C0  dc.w   $fe20
00B4C2  ; data: 0xfd, 0xd0
00B4C4  ; data: 0xfd, 0xd0
00B4C6  ; data: 0xfd, 0xf8
00B4C8  dc.w   $fe48
00B4CA  dc.w   $fe98
00B4CC  dc.w   $fee8
00B4CE  dc.w   $ff10
00B4D0  dc.w   $ff38
00B4D2  dc.w   $ff10
00B4D4  dc.w   $fee8
00B4D6  dc.w   $fe70
00B4D8  dc.w   $fe20
00B4DA  ; data: 0xfd, 0xd0
00B4DC  ; data: 0xfd, 0xa8
00B4DE  ; data: 0xfd, 0xa8
00B4E0  ; data: 0xfd, 0xd0
00B4E2  dc.w   $fe20
00B4E4  dc.w   $fe70
00B4E6  dc.w   $fee8
00B4E8  ; data: 0xff, 0x60
00B4EA  ; data: 0xff, 0xb0
00B4EC  move.b -(a0), $1d60(a6)
00B4F0  ; data: 0xff, 0x88
00B4F2  dc.w   $ff38
00B4F4  dc.w   $ff10
00B4F6  dc.w   $fee8
00B4F8  dc.w   $fec0
00B4FA  dc.w   $fee8
00B4FC  dc.w   $ff38
00B4FE  move.b -(a0), $1db0(a6)
00B502  move.b $1db01db0(d1.l * 4), -$40(a6, a7.l)
00B50C  dc.w   $fe98
00B50E  dc.w   $fec0
00B510  dc.w   $fee8
00B512  dc.w   $ff10
00B514  ; data: 0xff, 0x60
00B516  ; data: 0xff, 0x88
00B518  move.b -(a0), -$50(a6)
00B51C  ; data: 0xff, 0x88
00B51E  dc.w   $ff38
00B520  dc.w   $fec0
00B522  dc.w   $fe70
00B524  dc.w   $fe20
00B526  ; data: 0xfd, 0xf8
00B528  ; data: 0xfd, 0xf8
00B52A  dc.w   $fe20
00B52C  dc.w   $fe48
00B52E  dc.w   $fe98
00B530  dc.w   $fee8
00B532  dc.w   $ff10
00B534  dc.w   $ff10
00B536  dc.w   $ff10
00B538  dc.w   $fec0
00B53A  dc.w   $fe98
00B53C  dc.w   $fe48
00B53E  ; data: 0xfd, 0xf8
00B540  ; data: 0xfd, 0xd0
00B542  ; data: 0xfd, 0xd0
00B544  ; data: 0xfd, 0xf8
00B546  dc.w   $fe20
00B548  dc.w   $fe98
00B54A  dc.w   $fee8
00B54C  dc.w   $ff38
00B54E  ; data: 0xff, 0x88
00B550  ; data: 0xff, 0xb0
00B552  ; data: 0xff, 0xb0
00B554  ; data: 0xff, 0x88
00B556  dc.w   $ff38
00B558  dc.w   $ff10
00B55A  dc.w   $fee8
00B55C  dc.w   $fee8
00B55E  dc.w   $ff10
00B560  ; data: 0xff, 0x60
00B562  move.b -(a0), $1db0(a6)
00B566  move.b $1db01db0(d1.l * 4), -$40(a6, a7.l)
00B570  dc.w   $fec0
00B572  dc.w   $fec0
00B574  dc.w   $fee8
00B576  dc.w   $ff10
00B578  dc.w   $ff38
00B57A  ; data: 0xff, 0x88
00B57C  ; data: 0xff, 0x88
00B57E  ; data: 0xff, 0x88
00B580  ; data: 0xff, 0x60
00B582  dc.w   $ff10
00B584  dc.w   $fec0
00B586  dc.w   $fe70
00B588  dc.w   $fe48
00B58A  dc.w   $fe20
00B58C  dc.w   $fe20
00B58E  dc.w   $fe20
00B590  dc.w   $fe48
00B592  dc.w   $fe98
00B594  dc.w   $fec0
00B596  dc.w   $fee8
00B598  dc.w   $ff10
00B59A  dc.w   $fee8
00B59C  dc.w   $fec0
00B59E  dc.w   $fe98
00B5A0  dc.w   $fe48
00B5A2  dc.w   $fe20
00B5A4  ; data: 0xfd, 0xf8
00B5A6  ; data: 0xfd, 0xf8
00B5A8  dc.w   $fe20
00B5AA  dc.w   $fe48
00B5AC  dc.w   $fe98
00B5AE  dc.w   $fee8
00B5B0  dc.w   $ff38
00B5B2  ; data: 0xff, 0x60
00B5B4  ; data: 0xff, 0x88
00B5B6  ; data: 0xff, 0x88
00B5B8  ; data: 0xff, 0x60
00B5BA  dc.w   $ff38
00B5BC  dc.w   $ff38
00B5BE  dc.w   $ff10
00B5C0  dc.w   $ff10
00B5C2  dc.w   $ff38
00B5C4  ; data: 0xff, 0x60
00B5C6  move.b -(a0), $1db0(a6)
00B5CA  move.b $1db01db0(d1.l * 4), -$18(a6, a7.l)
00B5D4  dc.w   $fec0
00B5D6  dc.w   $fec0
00B5D8  dc.w   $fee8
00B5DA  dc.w   $ff10
00B5DC  dc.w   $ff38
00B5DE  ; data: 0xff, 0x60
00B5E0  ; data: 0xff, 0x60
00B5E2  ; data: 0xff, 0x60
00B5E4  dc.w   $ff38
00B5E6  dc.w   $ff10
00B5E8  dc.w   $fec0
00B5EA  dc.w   $fe98
00B5EC  dc.w   $fe48
00B5EE  dc.w   $fe20
00B5F0  dc.w   $fe20
00B5F2  dc.w   $fe48
00B5F4  dc.w   $fe70
00B5F6  dc.w   $fe98
00B5F8  dc.w   $fec0
00B5FA  dc.w   $fee8
00B5FC  dc.w   $fee8
00B5FE  dc.w   $fee8
00B600  dc.w   $fec0
00B602  dc.w   $fe98
00B604  dc.w   $fe70
00B606  dc.w   $fe48
00B608  dc.w   $fe20
00B60A  dc.w   $fe20
00B60C  dc.w   $fe48
00B60E  dc.w   $fe70
00B610  dc.w   $fe98
00B612  dc.w   $fee8
00B614  dc.w   $ff38
00B616  ; data: 0xff, 0x60
00B618  ; data: 0xff, 0x88
00B61A  ; data: 0xff, 0x88
00B61C  ; data: 0xff, 0x60
00B61E  ; data: 0xff, 0x60
00B620  dc.w   $ff38
00B622  dc.w   $ff10
00B624  dc.w   $ff38
00B626  dc.w   $ff38
00B628  ; data: 0xff, 0x88
00B62A  move.b -(a0), $1db0(a6)
00B62E  move.b $1db01db0(d1.l * 4), -$18(a6, a7.l)
00B638  dc.w   $fee8
00B63A  dc.w   $fee8
00B63C  dc.w   $fee8
00B63E  dc.w   $ff10
00B640  dc.w   $ff10
00B642  dc.w   $ff38
00B644  dc.w   $ff38
00B646  dc.w   $ff38
00B648  dc.w   $ff10
00B64A  dc.w   $fee8
00B64C  dc.w   $fec0
00B64E  dc.w   $fe98
00B650  dc.w   $fe70
00B652  dc.w   $fe48
00B654  dc.w   $fe48
00B656  dc.w   $fe48
00B658  dc.w   $fe70
00B65A  dc.w   $fe98
00B65C  dc.w   $fec0
00B65E  dc.w   $fec0
00B660  dc.w   $fee8
00B662  dc.w   $fec0
00B664  dc.w   $fec0
00B666  dc.w   $fe98
00B668  dc.w   $fe70
00B66A  dc.w   $fe48
00B66C  dc.w   $fe48
00B66E  dc.w   $fe48
00B670  dc.w   $fe48
00B672  dc.w   $fe70
00B674  dc.w   $fec0
00B676  dc.w   $fee8
00B678  dc.w   $ff38
00B67A  ; data: 0xff, 0x60
00B67C  ; data: 0xff, 0x60
00B67E  ; data: 0xff, 0x60
00B680  ; data: 0xff, 0x60
00B682  ; data: 0xff, 0x60
00B684  dc.w   $ff38
00B686  dc.w   $ff38
00B688  dc.w   $ff38
00B68A  ; data: 0xff, 0x60
00B68C  ; data: 0xff, 0x88
00B68E  move.b -(a0), $1db0(a6)
00B692  move.b $1db01db0(d1.l * 4), -$18(a6, a7.l)
00B69C  dc.w   $fee8
00B69E  dc.w   $fee8
00B6A0  dc.w   $fee8
00B6A2  dc.w   $ff10
00B6A4  dc.w   $ff10
00B6A6  dc.w   $ff10
00B6A8  dc.w   $ff10
00B6AA  dc.w   $ff10
00B6AC  dc.w   $ff10
00B6AE  dc.w   $fee8
00B6B0  dc.w   $fec0
00B6B2  dc.w   $fe98
00B6B4  dc.w   $fe70
00B6B6  dc.w   $fe70
00B6B8  dc.w   $fe70
00B6BA  dc.w   $fe70
00B6BC  dc.w   $fe70
00B6BE  dc.w   $fe98
00B6C0  dc.w   $fe98
00B6C2  dc.w   $fec0
00B6C4  dc.w   $fec0
00B6C6  dc.w   $fec0
00B6C8  dc.w   $fec0
00B6CA  dc.w   $fe98
00B6CC  dc.w   $fe70
00B6CE  dc.w   $fe70
00B6D0  dc.w   $fe70
00B6D2  dc.w   $fe70
00B6D4  dc.w   $fe70
00B6D6  dc.w   $fe98
00B6D8  dc.w   $fec0
00B6DA  dc.w   $fee8
00B6DC  dc.w   $ff10
00B6DE  dc.w   $ff38
00B6E0  ; data: 0xff, 0x60
00B6E2  ; data: 0xff, 0x60
00B6E4  ; data: 0xff, 0x60
00B6E6  ; data: 0xff, 0x60
00B6E8  dc.w   $ff38
00B6EA  dc.w   $ff38
00B6EC  ; data: 0xff, 0x60
00B6EE  ; data: 0xff, 0x60
00B6F0  ; data: 0xff, 0x88
00B6F2  move.b -(a0), $1db0(a6)
00B6F6  move.b $1db01db0(d1.l * 4), (a6, a7.l * 8)
00B700  dc.w   $fee8
00B702  dc.w   $fee8
00B704  dc.w   $fee8
00B706  dc.w   $fee8
00B708  dc.w   $ff10
00B70A  dc.w   $ff10
00B70C  dc.w   $ff10
00B70E  dc.w   $ff10
00B710  dc.w   $fee8
00B712  dc.w   $fec0
00B714  dc.w   $fec0
00B716  dc.w   $fe98
00B718  dc.w   $fe98
00B71A  dc.w   $fe70
00B71C  dc.w   $fe70
00B71E  dc.w   $fe70
00B720  dc.w   $fe70
00B722  dc.w   $fe98
00B724  dc.w   $fe98
00B726  dc.w   $fec0
00B728  dc.w   $fec0
00B72A  dc.w   $fec0
00B72C  dc.w   $fe98
00B72E  dc.w   $fe98
00B730  dc.w   $fe98
00B732  dc.w   $fe70
00B734  dc.w   $fe70
00B736  dc.w   $fe98
00B738  dc.w   $fe98
00B73A  dc.w   $fec0
00B73C  dc.w   $fec0
00B73E  dc.w   $fee8
00B740  dc.w   $ff10
00B742  dc.w   $ff38
00B744  dc.w   $ff38
00B746  ; data: 0xff, 0x60
00B748  ; data: 0xff, 0x60
00B74A  ; data: 0xff, 0x60
00B74C  ; data: 0xff, 0x60
00B74E  ; data: 0xff, 0x60
00B750  ; data: 0xff, 0x60
00B752  ; data: 0xff, 0x88
00B754  ; data: 0xff, 0xb0
00B756  move.b -(a0), $1db0(a6)
00B75A  move.b $1db01db0(d1.l * 4), (a6, a7.l * 8)
00B764  dc.w   $fee8
00B766  dc.w   $fee8
00B768  dc.w   $fee8
00B76A  dc.w   $fee8
00B76C  dc.w   $fee8
00B76E  dc.w   $fee8
00B770  dc.w   $fee8
00B772  dc.w   $fee8
00B774  dc.w   $fee8
00B776  dc.w   $fec0
00B778  dc.w   $fec0
00B77A  dc.w   $fe98
00B77C  dc.w   $fe98
00B77E  dc.w   $fe98
00B780  dc.w   $fe70
00B782  dc.w   $fe70
00B784  dc.w   $fe98
00B786  dc.w   $fe98
00B788  dc.w   $fe98
00B78A  dc.w   $fe98
00B78C  dc.w   $fec0
00B78E  dc.w   $fec0
00B790  dc.w   $fe98
00B792  dc.w   $fe98
00B794  dc.w   $fe98
00B796  dc.w   $fe98
00B798  dc.w   $fe98
00B79A  dc.w   $fe98
00B79C  dc.w   $fec0
00B79E  dc.w   $fec0
00B7A0  dc.w   $fee8
00B7A2  dc.w   $fee8
00B7A4  dc.w   $ff10
00B7A6  dc.w   $ff38
00B7A8  dc.w   $ff38
00B7AA  dc.w   $ff38
00B7AC  dc.w   $ff38
00B7AE  ; data: 0xff, 0x60
00B7B0  ; data: 0xff, 0x60
00B7B2  ; data: 0xff, 0x60
00B7B4  ; data: 0xff, 0x60
00B7B6  ; data: 0xff, 0x88
00B7B8  ; data: 0xff, 0xb0
00B7BA  move.b -(a0), $1d88(a6)
00B7BE  move.b $1db01db0(d1.l * 4), (a6, a7.l * 8)
00B7C8  dc.w   $ff10
00B7CA  dc.w   $fee8
00B7CC  dc.w   $fee8
00B7CE  dc.w   $fee8
00B7D0  dc.w   $fee8
00B7D2  dc.w   $fee8
00B7D4  dc.w   $fee8
00B7D6  dc.w   $fee8
00B7D8  dc.w   $fec0
00B7DA  dc.w   $fec0
00B7DC  dc.w   $fec0
00B7DE  dc.w   $fe98
00B7E0  dc.w   $fe98
00B7E2  dc.w   $fe98
00B7E4  dc.w   $fe98
00B7E6  dc.w   $fe98
00B7E8  dc.w   $fe98
00B7EA  dc.w   $fe98
00B7EC  dc.w   $fe98
00B7EE  dc.w   $fe98
00B7F0  dc.w   $fe98
00B7F2  dc.w   $fe98
00B7F4  dc.w   $fe98
00B7F6  dc.w   $fe98
00B7F8  dc.w   $fe98
00B7FA  dc.w   $fe98
00B7FC  dc.w   $fe98
00B7FE  dc.w   $fec0
00B800  dc.w   $fec0
00B802  dc.w   $fec0
00B804  dc.w   $fee8
00B806  dc.w   $fee8
00B808  dc.w   $ff10
00B80A  dc.w   $ff10
00B80C  dc.w   $ff38
00B80E  dc.w   $ff38
00B810  dc.w   $ff38
00B812  ; data: 0xff, 0x60
00B814  ; data: 0xff, 0x60
00B816  ; data: 0xff, 0x60
00B818  ; data: 0xff, 0x88
00B81A  ; data: 0xff, 0x88
00B81C  ; data: 0xff, 0xb0
00B81E  move.b -(a0), $1d88(a6)
00B822  move.b $1db01db0(d1.l * 4), (a6, a7.l * 8)
00B82C  dc.w   $ff10
00B82E  dc.w   $fee8
00B830  dc.w   $fee8
00B832  dc.w   $fee8
00B834  dc.w   $fee8
00B836  dc.w   $fee8
00B838  dc.w   $fec0
00B83A  dc.w   $fec0
00B83C  dc.w   $fec0
00B83E  dc.w   $fec0
00B840  dc.w   $fec0
00B842  dc.w   $fe98
00B844  dc.w   $fe98
00B846  dc.w   $fe98
00B848  dc.w   $fe98
00B84A  dc.w   $fe98
00B84C  dc.w   $fe98
00B84E  dc.w   $fe98
00B850  dc.w   $fe98
00B852  dc.w   $fe98
00B854  dc.w   $fe98
00B856  dc.w   $fe98
00B858  dc.w   $fe98
00B85A  dc.w   $fe98
00B85C  dc.w   $fec0
00B85E  dc.w   $fec0
00B860  dc.w   $fec0
00B862  dc.w   $fec0
00B864  dc.w   $fec0
00B866  dc.w   $fee8
00B868  dc.w   $fee8
00B86A  dc.w   $fee8
00B86C  dc.w   $ff10
00B86E  dc.w   $ff10
00B870  dc.w   $ff38
00B872  dc.w   $ff38
00B874  dc.w   $ff38
00B876  ; data: 0xff, 0x60
00B878  ; data: 0xff, 0x60
00B87A  ; data: 0xff, 0x60
00B87C  ; data: 0xff, 0x88
00B87E  ; data: 0xff, 0x88
00B880  ; data: 0xff, 0xb0
00B882  move.b -(a0), $1d88(a6)
00B886  ; data: 0x1d, 0x88
00B888  move.b $1db0ff10(d1.l * 4), (a6, a7.l * 8)
00B892  dc.w   $fee8
00B894  dc.w   $fee8
00B896  dc.w   $fee8
00B898  dc.w   $fee8
00B89A  dc.w   $fec0
00B89C  dc.w   $fec0
00B89E  dc.w   $fec0
00B8A0  dc.w   $fec0
00B8A2  dc.w   $fec0
00B8A4  dc.w   $fe98
00B8A6  dc.w   $fe98
00B8A8  dc.w   $fe98
00B8AA  dc.w   $fe98
00B8AC  dc.w   $fe98
00B8AE  dc.w   $fe98
00B8B0  dc.w   $fe98
00B8B2  dc.w   $fe98
00B8B4  dc.w   $fe98
00B8B6  dc.w   $fe98
00B8B8  dc.w   $fe98
00B8BA  dc.w   $fe98
00B8BC  dc.w   $fe98
00B8BE  dc.w   $fec0
00B8C0  dc.w   $fec0
00B8C2  dc.w   $fec0
00B8C4  dc.w   $fec0
00B8C6  dc.w   $fec0
00B8C8  dc.w   $fee8
00B8CA  dc.w   $fee8
00B8CC  dc.w   $fee8
00B8CE  dc.w   $fee8
00B8D0  dc.w   $ff10
00B8D2  dc.w   $ff10
00B8D4  dc.w   $ff38
00B8D6  dc.w   $ff38
00B8D8  dc.w   $ff38
00B8DA  ; data: 0xff, 0x60
00B8DC  ; data: 0xff, 0x60
00B8DE  ; data: 0xff, 0x60
00B8E0  ; data: 0xff, 0x88
00B8E2  ; data: 0xff, 0x88
00B8E4  ; data: 0xff, 0xb0
00B8E6  move.b -(a0), $1d88(a6)
00B8EA  ; data: 0x1d, 0x88
00B8EC  ; data: 0x1d, 0x88
00B8EE  move.b $ff10fee8(d1.l * 4), -$18(a6, a7.l)
00B8F8  dc.w   $fee8
00B8FA  dc.w   $fee8
00B8FC  dc.w   $fec0
00B8FE  dc.w   $fec0
00B900  dc.w   $fec0
00B902  dc.w   $fec0
00B904  dc.w   $fec0
00B906  dc.w   $fec0
00B908  dc.w   $fe98
00B90A  dc.w   $fe98
00B90C  dc.w   $fe98
00B90E  dc.w   $fe98
00B910  dc.w   $fe98
00B912  dc.w   $fe98
00B914  dc.w   $fe98
00B916  dc.w   $fe98
00B918  dc.w   $fe98
00B91A  dc.w   $fe98
00B91C  dc.w   $fe98
00B91E  dc.w   $fe98
00B920  dc.w   $fec0
00B922  dc.w   $fec0
00B924  dc.w   $fec0
00B926  dc.w   $fec0
00B928  dc.w   $fec0
00B92A  dc.w   $fec0
00B92C  dc.w   $fee8
00B92E  dc.w   $fee8
00B930  dc.w   $fee8
00B932  dc.w   $ff10
00B934  dc.w   $ff10
00B936  dc.w   $ff10
00B938  dc.w   $ff38
00B93A  dc.w   $ff38
00B93C  dc.w   $ff38
00B93E  ; data: 0xff, 0x60
00B940  ; data: 0xff, 0x60
00B942  ; data: 0xff, 0x60
00B944  ; data: 0xff, 0x88
00B946  ; data: 0xff, 0x88
00B948  ; data: 0xff, 0xb0
00B94A  ; data: 0xff, 0xb0
00B94C  move.b -(a0), $1d88(a6)
00B950  ; data: 0x1d, 0x88
00B952  ; data: 0x1d, 0x88
00B954  move.b (a0, a7.l * 8), -$18(a6, a7.l)
00B95A  dc.w   $fee8
00B95C  dc.w   $fee8
00B95E  dc.w   $fee8
00B960  dc.w   $fec0
00B962  dc.w   $fec0
00B964  dc.w   $fec0
00B966  dc.w   $fec0
00B968  dc.w   $fec0
00B96A  dc.w   $fec0
00B96C  dc.w   $fe98
00B96E  dc.w   $fe98
00B970  dc.w   $fe98
00B972  dc.w   $fe98
00B974  dc.w   $fe98
00B976  dc.w   $fe98
00B978  dc.w   $fe98
00B97A  dc.w   $fe98
00B97C  dc.w   $fe98
00B97E  dc.w   $fe98
00B980  dc.w   $fe98
00B982  dc.w   $fec0
00B984  dc.w   $fec0
00B986  dc.w   $fec0
00B988  dc.w   $fec0
00B98A  dc.w   $fec0
00B98C  dc.w   $fec0
00B98E  dc.w   $fec0
00B990  dc.w   $fee8
00B992  dc.w   $fee8
00B994  dc.w   $fee8
00B996  dc.w   $ff10
00B998  dc.w   $ff10
00B99A  dc.w   $ff10
00B99C  dc.w   $ff38
00B99E  dc.w   $ff38
00B9A0  dc.w   $ff38
00B9A2  ; data: 0xff, 0x60
00B9A4  ; data: 0xff, 0x60
00B9A6  ; data: 0xff, 0x60
00B9A8  ; data: 0xff, 0x88
00B9AA  ; data: 0xff, 0x88
00B9AC  ; data: 0xff, 0x88
00B9AE  ; data: 0xff, 0xb0
00B9B0  move.b -(a0), $1d88(a6)
00B9B4  ; data: 0x1d, 0x88
00B9B6  ; data: 0x1d, 0x88
00B9B8  move.b -$18(a0, a7.l), -$18(a6, a7.l)
00B9BE  dc.w   $fee8
00B9C0  dc.w   $fee8
00B9C2  dc.w   $fee8
00B9C4  dc.w   $fec0
00B9C6  dc.w   $fec0
00B9C8  dc.w   $fec0
00B9CA  dc.w   $fec0
00B9CC  dc.w   $fec0
00B9CE  dc.w   $fec0
00B9D0  dc.w   $fe98
00B9D2  dc.w   $fe98
00B9D4  dc.w   $fe98
00B9D6  dc.w   $fe98
00B9D8  dc.w   $fe98
00B9DA  dc.w   $fe98
00B9DC  dc.w   $fe98
00B9DE  dc.w   $fe98
00B9E0  dc.w   $fe98
00B9E2  dc.w   $fec0
00B9E4  dc.w   $fec0
00B9E6  dc.w   $fec0
00B9E8  dc.w   $fec0
00B9EA  dc.w   $fec0
00B9EC  dc.w   $fec0
00B9EE  dc.w   $fec0
00B9F0  dc.w   $fec0
00B9F2  dc.w   $fec0
00B9F4  dc.w   $fee8
00B9F6  dc.w   $fee8
00B9F8  dc.w   $fee8
00B9FA  dc.w   $ff10
00B9FC  dc.w   $ff10
00B9FE  dc.w   $ff38
00BA00  dc.w   $ff38
00BA02  dc.w   $ff38
00BA04  dc.w   $ff38
00BA06  ; data: 0xff, 0x60
00BA08  ; data: 0xff, 0x60
00BA0A  ; data: 0xff, 0x60
00BA0C  ; data: 0xff, 0x60
00BA0E  ; data: 0xff, 0x88
00BA10  ; data: 0xff, 0x88
00BA12  ; data: 0xff, 0xb0
00BA14  ; data: 0xff, 0xb0
00BA16  move.b -(a0), $1d88(a6)
00BA1A  ; data: 0x1d, 0x88
00BA1C  move.b -$18(a0, a7.l), -$18(a6, a7.l)
00BA22  dc.w   $fec0
00BA24  dc.w   $fec0
00BA26  dc.w   $fec0
00BA28  dc.w   $fee8
00BA2A  dc.w   $fee8
00BA2C  dc.w   $fee8
00BA2E  dc.w   $fec0
00BA30  dc.w   $fec0
00BA32  dc.w   $fec0
00BA34  dc.w   $fe98
00BA36  dc.w   $fe98
00BA38  dc.w   $fe98
00BA3A  dc.w   $fe98
00BA3C  dc.w   $fe98
00BA3E  dc.w   $fe98
00BA40  dc.w   $fe98
00BA42  dc.w   $fe98
00BA44  dc.w   $fec0
00BA46  dc.w   $fec0
00BA48  dc.w   $fec0
00BA4A  dc.w   $fec0
00BA4C  dc.w   $fec0
00BA4E  dc.w   $fec0
00BA50  dc.w   $fec0
00BA52  dc.w   $fec0
00BA54  dc.w   $fec0
00BA56  dc.w   $fec0
00BA58  dc.w   $fec0
00BA5A  dc.w   $fee8
00BA5C  dc.w   $fee8
00BA5E  dc.w   $ff10
00BA60  dc.w   $ff10
00BA62  dc.w   $ff38
00BA64  dc.w   $ff38
00BA66  dc.w   $ff38
00BA68  dc.w   $ff38
00BA6A  dc.w   $ff38
00BA6C  ; data: 0xff, 0x60
00BA6E  ; data: 0xff, 0x60
00BA70  ; data: 0xff, 0x60
00BA72  ; data: 0xff, 0x60
00BA74  ; data: 0xff, 0x88
00BA76  ; data: 0xff, 0x88
00BA78  ; data: 0xff, 0xb0
00BA7A  move.b -(a0), $1d88(a6)
00BA7E  ; data: 0x1d, 0x88
00BA80  move.b -$18(a0, a7.l), -$40(a6, a7.l)
00BA86  dc.w   $fec0
00BA88  dc.w   $fec0
00BA8A  dc.w   $fec0
00BA8C  dc.w   $fee8
00BA8E  dc.w   $fee8
00BA90  dc.w   $fee8
00BA92  dc.w   $fee8
00BA94  dc.w   $fee8
00BA96  dc.w   $fec0
00BA98  dc.w   $fe98
00BA9A  dc.w   $fe98
00BA9C  dc.w   $fe70
00BA9E  dc.w   $fe70
00BAA0  dc.w   $fe70
00BAA2  dc.w   $fe98
00BAA4  dc.w   $fe98
00BAA6  dc.w   $fe98
00BAA8  dc.w   $fec0
00BAAA  dc.w   $fec0
00BAAC  dc.w   $fee8
00BAAE  dc.w   $fee8
00BAB0  dc.w   $fec0
00BAB2  dc.w   $fec0
00BAB4  dc.w   $fec0
00BAB6  dc.w   $fec0
00BAB8  dc.w   $fe98
00BABA  dc.w   $fec0
00BABC  dc.w   $fec0
00BABE  dc.w   $fee8
00BAC0  dc.w   $fee8
00BAC2  dc.w   $ff10
00BAC4  dc.w   $ff38
00BAC6  dc.w   $ff38
00BAC8  dc.w   $ff38
00BACA  ; data: 0xff, 0x60
00BACC  ; data: 0xff, 0x60
00BACE  dc.w   $ff38
00BAD0  dc.w   $ff38
00BAD2  dc.w   $ff38
00BAD4  dc.w   $ff38
00BAD6  ; data: 0xff, 0x60
00BAD8  ; data: 0xff, 0x60
00BADA  ; data: 0xff, 0x88
00BADC  ; data: 0xff, 0xb0
00BADE  ; data: 0x1d, 0x88
00BAE0  ; data: 0x1d, 0x88
00BAE2  move.b $fec0fec0(d1.l * 4), -$40(a6, a7.l)
00BAEC  dc.w   $fec0
00BAEE  dc.w   $fec0
00BAF0  dc.w   $fee8
00BAF2  dc.w   $fee8
00BAF4  dc.w   $ff10
00BAF6  dc.w   $fee8
00BAF8  dc.w   $fee8
00BAFA  dc.w   $fec0
00BAFC  dc.w   $fec0
00BAFE  dc.w   $fe98
00BB00  dc.w   $fe70
00BB02  dc.w   $fe70
00BB04  dc.w   $fe70
00BB06  dc.w   $fe70
00BB08  dc.w   $fe98
00BB0A  dc.w   $fec0
00BB0C  dc.w   $fec0
00BB0E  dc.w   $fee8
00BB10  dc.w   $fee8
00BB12  dc.w   $fee8
00BB14  dc.w   $fee8
00BB16  dc.w   $fec0
00BB18  dc.w   $fec0
00BB1A  dc.w   $fe98
00BB1C  dc.w   $fe98
00BB1E  dc.w   $fe98
00BB20  dc.w   $fec0
00BB22  dc.w   $fec0
00BB24  dc.w   $fee8
00BB26  dc.w   $ff10
00BB28  dc.w   $ff38
00BB2A  ; data: 0xff, 0x60
00BB2C  ; data: 0xff, 0x60
00BB2E  ; data: 0xff, 0x60
00BB30  ; data: 0xff, 0x60
00BB32  dc.w   $ff38
00BB34  dc.w   $ff38
00BB36  dc.w   $ff38
00BB38  dc.w   $ff38
00BB3A  dc.w   $ff38
00BB3C  ; data: 0xff, 0x60
00BB3E  ; data: 0xff, 0x88
00BB40  ; data: 0xff, 0xb0
00BB42  ; data: 0x1d, 0x88
00BB44  ; data: 0x1d, 0x88
00BB46  move.b $fec0fe98(d1.l * 4), -$68(a6, a7.l)
00BB50  dc.w   $fec0
00BB52  dc.w   $fec0
00BB54  dc.w   $fee8
00BB56  dc.w   $ff10
00BB58  dc.w   $ff10
00BB5A  dc.w   $ff10
00BB5C  dc.w   $ff10
00BB5E  dc.w   $fee8
00BB60  dc.w   $fec0
00BB62  dc.w   $fe98
00BB64  dc.w   $fe70
00BB66  dc.w   $fe48
00BB68  dc.w   $fe48
00BB6A  dc.w   $fe70
00BB6C  dc.w   $fe98
00BB6E  dc.w   $fec0
00BB70  dc.w   $fee8
00BB72  dc.w   $fee8
00BB74  dc.w   $ff10
00BB76  dc.w   $ff10
00BB78  dc.w   $fee8
00BB7A  dc.w   $fec0
00BB7C  dc.w   $fec0
00BB7E  dc.w   $fe98
00BB80  dc.w   $fe70
00BB82  dc.w   $fe70
00BB84  dc.w   $fe98
00BB86  dc.w   $fec0
00BB88  dc.w   $fee8
00BB8A  dc.w   $ff10
00BB8C  dc.w   $ff38
00BB8E  ; data: 0xff, 0x60
00BB90  ; data: 0xff, 0x60
00BB92  ; data: 0xff, 0x60
00BB94  ; data: 0xff, 0x60
00BB96  dc.w   $ff38
00BB98  dc.w   $ff38
00BB9A  dc.w   $ff10
00BB9C  dc.w   $ff10
00BB9E  dc.w   $ff10
00BBA0  dc.w   $ff38
00BBA2  ; data: 0xff, 0x60
00BBA4  ; data: 0xff, 0xb0
00BBA6  ; data: 0x1d, 0x88
00BBA8  move.b $1db0fe98(d1.l * 4), $70(a6, a7.l)
00BBB2  dc.w   $fe98
00BBB4  dc.w   $fe98
00BBB6  dc.w   $fec0
00BBB8  dc.w   $fee8
00BBBA  dc.w   $ff10
00BBBC  dc.w   $ff38
00BBBE  dc.w   $ff38
00BBC0  dc.w   $ff10
00BBC2  dc.w   $fee8
00BBC4  dc.w   $fec0
00BBC6  dc.w   $fe70
00BBC8  dc.w   $fe48
00BBCA  dc.w   $fe48
00BBCC  dc.w   $fe48
00BBCE  dc.w   $fe48
00BBD0  dc.w   $fe70
00BBD2  dc.w   $fec0
00BBD4  dc.w   $fee8
00BBD6  dc.w   $ff10
00BBD8  dc.w   $ff10
00BBDA  dc.w   $ff10
00BBDC  dc.w   $ff10
00BBDE  dc.w   $fee8
00BBE0  dc.w   $fe98
00BBE2  dc.w   $fe70
00BBE4  dc.w   $fe70
00BBE6  dc.w   $fe70
00BBE8  dc.w   $fe70
00BBEA  dc.w   $fe98
00BBEC  dc.w   $fee8
00BBEE  dc.w   $ff10
00BBF0  ; data: 0xff, 0x60
00BBF2  ; data: 0xff, 0x88
00BBF4  ; data: 0xff, 0x88
00BBF6  ; data: 0xff, 0x88
00BBF8  ; data: 0xff, 0x60
00BBFA  dc.w   $ff38
00BBFC  dc.w   $ff10
00BBFE  dc.w   $fee8
00BC00  dc.w   $fee8
00BC02  dc.w   $ff10
00BC04  dc.w   $ff38
00BC06  ; data: 0xff, 0x60
00BC08  ; data: 0xff, 0xb0
00BC0A  ; data: 0x1d, 0x88
00BC0C  move.b $1db0fe70(d1.l * 4), $70(a6, a7.l)
00BC16  dc.w   $fe70
00BC18  dc.w   $fe98
00BC1A  dc.w   $fec0
00BC1C  dc.w   $ff10
00BC1E  dc.w   $ff38
00BC20  ; data: 0xff, 0x60
00BC22  ; data: 0xff, 0x60
00BC24  dc.w   $ff38
00BC26  dc.w   $fee8
00BC28  dc.w   $fec0
00BC2A  dc.w   $fe70
00BC2C  dc.w   $fe48
00BC2E  dc.w   $fe20
00BC30  dc.w   $fe20
00BC32  dc.w   $fe48
00BC34  dc.w   $fe70
00BC36  dc.w   $fec0
00BC38  dc.w   $fee8
00BC3A  dc.w   $ff38
00BC3C  dc.w   $ff38
00BC3E  dc.w   $ff38
00BC40  dc.w   $ff10
00BC42  dc.w   $fee8
00BC44  dc.w   $fe98
00BC46  dc.w   $fe70
00BC48  dc.w   $fe48
00BC4A  dc.w   $fe48
00BC4C  dc.w   $fe70
00BC4E  dc.w   $fe98
00BC50  dc.w   $fee8
00BC52  dc.w   $ff38
00BC54  ; data: 0xff, 0x60
00BC56  ; data: 0xff, 0x88
00BC58  ; data: 0xff, 0xb0
00BC5A  ; data: 0xff, 0x88
00BC5C  ; data: 0xff, 0x60
00BC5E  dc.w   $ff38
00BC60  dc.w   $ff10
00BC62  dc.w   $fee8
00BC64  dc.w   $fec0
00BC66  dc.w   $fee8
00BC68  dc.w   $ff10
00BC6A  ; data: 0xff, 0x60
00BC6C  ; data: 0xff, 0xb0
00BC6E  ; data: 0x1d, 0x88
00BC70  move.b $1db0fe70(d1.l * 4), $48(a6, a7.l)
00BC7A  dc.w   $fe48
00BC7C  dc.w   $fe98
00BC7E  dc.w   $fec0
00BC80  dc.w   $ff10
00BC82  ; data: 0xff, 0x60
00BC84  ; data: 0xff, 0x88
00BC86  ; data: 0xff, 0x88
00BC88  ; data: 0xff, 0x60
00BC8A  dc.w   $ff10
00BC8C  dc.w   $fec0
00BC8E  dc.w   $fe70
00BC90  dc.w   $fe20
00BC92  ; data: 0xfd, 0xf8
00BC94  ; data: 0xfd, 0xf8
00BC96  dc.w   $fe20
00BC98  dc.w   $fe70
00BC9A  dc.w   $fec0
00BC9C  dc.w   $ff10
00BC9E  dc.w   $ff38
00BCA0  ; data: 0xff, 0x60
00BCA2  ; data: 0xff, 0x60
00BCA4  dc.w   $ff10
00BCA6  dc.w   $fee8
00BCA8  dc.w   $fe98
00BCAA  dc.w   $fe48
00BCAC  dc.w   $fe20
00BCAE  dc.w   $fe20
00BCB0  dc.w   $fe48
00BCB2  dc.w   $fe70
00BCB4  dc.w   $fec0
00BCB6  dc.w   $ff38
00BCB8  ; data: 0xff, 0x88
00BCBA  ; data: 0xff, 0xb0
00BCBC  move.b -(a0), -$50(a6)
00BCC0  ; data: 0xff, 0x60
00BCC2  dc.w   $ff38
00BCC4  dc.w   $fee8
00BCC6  dc.w   $fec0
00BCC8  dc.w   $fe98
00BCCA  dc.w   $fec0
00BCCC  dc.w   $fee8
00BCCE  dc.w   $ff38
00BCD0  ; data: 0xff, 0x88
00BCD2  move.b $1db01db0(d1.l * 4), $48(a6, a7.l)
00BCDC  dc.w   $fe20
00BCDE  dc.w   $fe48
00BCE0  dc.w   $fe70
00BCE2  dc.w   $fec0
00BCE4  dc.w   $ff38
00BCE6  ; data: 0xff, 0x60
00BCE8  ; data: 0xff, 0xb0
00BCEA  ; data: 0xff, 0x88
00BCEC  ; data: 0xff, 0x60
00BCEE  dc.w   $ff10
00BCF0  dc.w   $fec0
00BCF2  dc.w   $fe48
00BCF4  dc.w   $fe20
00BCF6  ; data: 0xfd, 0xf8
00BCF8  ; data: 0xfd, 0xf8
00BCFA  dc.w   $fe20
00BCFC  dc.w   $fe70
00BCFE  dc.w   $fec0
00BD00  dc.w   $ff10
00BD02  ; data: 0xff, 0x60
00BD04  ; data: 0xff, 0x88
00BD06  ; data: 0xff, 0x60
00BD08  dc.w   $ff38
00BD0A  dc.w   $fee8
00BD0C  dc.w   $fe98
00BD0E  dc.w   $fe48
00BD10  ; data: 0xfd, 0xf8
00BD12  ; data: 0xfd, 0xf8
00BD14  dc.w   $fe20
00BD16  dc.w   $fe70
00BD18  dc.w   $fec0
00BD1A  dc.w   $ff38
00BD1C  ; data: 0xff, 0x88
00BD1E  move.b -(a0), $1d88(a6)
00BD22  move.b -(a0), -$78(a6)
00BD26  dc.w   $ff38
00BD28  dc.w   $fee8
00BD2A  dc.w   $fe98
00BD2C  dc.w   $fe70
00BD2E  dc.w   $fe98
00BD30  dc.w   $fec0
00BD32  dc.w   $ff38
00BD34  ; data: 0xff, 0x88
00BD36  move.b $1db01db0(d1.l * 4), $20(a6, a7.l)
00BD40  dc.w   $fe20
00BD42  dc.w   $fe20
00BD44  dc.w   $fe70
00BD46  dc.w   $fec0
00BD48  dc.w   $ff38
00BD4A  ; data: 0xff, 0x88
00BD4C  ; data: 0x1d, 0x88
00BD4E  ; data: 0x1d, 0x88
00BD50  ; data: 0xff, 0x88
00BD52  dc.w   $ff38
00BD54  dc.w   $fec0
00BD56  dc.w   $fe48
00BD58  ; data: 0xfd, 0xf8
00BD5A  ; data: 0xfd, 0xd0
00BD5C  ; data: 0xfd, 0xd0
00BD5E  ; data: 0xfd, 0xf8
00BD60  dc.w   $fe48
00BD62  dc.w   $fec0
00BD64  dc.w   $ff38
00BD66  ; data: 0xff, 0x88
00BD68  ; data: 0xff, 0x88
00BD6A  ; data: 0xff, 0x88
00BD6C  dc.w   $ff38
00BD6E  dc.w   $fee8
00BD70  dc.w   $fe70
00BD72  dc.w   $fe20
00BD74  ; data: 0xfd, 0xd0
00BD76  ; data: 0xfd, 0xd0
00BD78  ; data: 0xfd, 0xf8
00BD7A  dc.w   $fe48
00BD7C  dc.w   $fec0
00BD7E  dc.w   $ff38
00BD80  ; data: 0xff, 0x88
00BD82  ; data: 0x1d, 0x88
00BD84  move.b (d1.l * 4), (a7.l * 8)
00BD8A  dc.w   $ff38
00BD8C  dc.w   $fec0
00BD8E  dc.w   $fe70
00BD90  dc.w   $fe48
00BD92  dc.w   $fe70
00BD94  dc.w   $fec0
00BD96  dc.w   $ff10
00BD98  ; data: 0xff, 0x88
00BD9A  move.b $1db01db0(d1.l * 4), $fdf8fe20(invalid.w)
00BDA8  dc.w   $fe70
00BDAA  dc.w   $fee8
00BDAC  ; data: 0xff, 0x60
00BDAE  move.b -(a0), $1db0(a6)
00BDB2  move.b $ff60(a0, invalid.w), -$40(a6, a7.l)
00BDBA  dc.w   $fe48
00BDBC  ; data: 0xfd, 0xd0
00BDBE  ; data: 0xfd, 0xa8
00BDC0  ; data: 0xfd, 0xa8
00BDC2  ; data: 0xfd, 0xf8
00BDC4  dc.w   $fe48
00BDC6  dc.w   $fec0
00BDC8  dc.w   $ff38
00BDCA  ; data: 0xff, 0x88
00BDCC  move.b -(a0), -$50(a6)
00BDD0  ; data: 0xff, 0x60
00BDD2  dc.w   $fee8
00BDD4  dc.w   $fe70
00BDD6  ; data: 0xfd, 0xf8
00BDD8  ; data: 0xfd, 0xa8
00BDDA  ; data: 0xfd, 0xa8
00BDDC  ; data: 0xfd, 0xd0
00BDDE  dc.w   $fe20
00BDE0  dc.w   $fec0
00BDE2  dc.w   $ff38
00BDE4  ; data: 0xff, 0xb0
00BDE6  move.b $1d88ff88(d1.l * 4), (a6, a7.l * 8)
00BDF0  dc.w   $fec0
00BDF2  dc.w   $fe48
00BDF4  dc.w   $fe20
00BDF6  dc.w   $fe48
00BDF8  dc.w   $fe98
00BDFA  dc.w   $ff10
00BDFC  ; data: 0xff, 0xb0
00BDFE  move.b $1db01db0(d1.l * 4), $fdd0fdf8(invalid.w)
00BE0C  dc.w   $fe48
00BE0E  dc.w   $fee8
00BE10  ; data: 0xff, 0x60
00BE12  ; data: 0x1d, 0x88
00BE14  move.b $1d88ff60(d1.l * 4), -$40(a6, a7.l)
00BE1E  dc.w   $fe48
00BE20  ; data: 0xfd, 0xd0
00BE22  ; data: 0xfd, 0x80
00BE24  ; data: 0xfd, 0x80
00BE26  ; data: 0xfd, 0xd0
00BE28  dc.w   $fe48
00BE2A  dc.w   $fec0
00BE2C  ; data: 0xff, 0x60
00BE2E  move.b -(a0), $1d88(a6)
00BE32  move.b -(a0), -$a0(a6)
00BE36  dc.w   $fee8
00BE38  dc.w   $fe48
00BE3A  ; data: 0xfd, 0xd0
00BE3C  ; data: 0xfd, 0x80
00BE3E  ; data: 0xfd, 0x80
00BE40  ; data: 0xfd, 0xa8
00BE42  dc.w   $fe20
00BE44  dc.w   $fe98
00BE46  dc.w   $ff38
00BE48  move.b -(a0), $1db0(a6)
00BE4C  move.b $ff88ff10(d1.l * 4), -$68(a6, a7.l)
00BE56  dc.w   $fe20
00BE58  ; data: 0xfd, 0xf8
00BE5A  dc.w   $fe20
00BE5C  dc.w   $fe70
00BE5E  dc.w   $ff10
00BE60  ; data: 0xff, 0xb0
00BE62  move.b $1db01db0(d1.l * 4), (invalid.w)
00BE6C  ; data: 0xfd, 0xa8
00BE6E  ; data: 0xfd, 0xd0
00BE70  dc.w   $fe48
00BE72  dc.w   $fee8
00BE74  ; data: 0xff, 0x88
00BE76  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00BE80  dc.w   $fee8
00BE82  dc.w   $fe20
00BE84  ; data: 0xfd, 0xa8
00BE86  dc.w   $fd58
00BE88  dc.w   $fd58
00BE8A  ; data: 0xfd, 0xa8
00BE8C  dc.w   $fe48
00BE8E  dc.w   $fec0
00BE90  ; data: 0xff, 0x60
00BE92  ; data: 0x1d, 0x88
00BE94  move.b (d1.l * 4), (a7.l * 8)
00BE9A  dc.w   $fee8
00BE9C  dc.w   $fe48
00BE9E  ; data: 0xfd, 0xa8
00BEA0  dc.w   $fd58
00BEA2  dc.w   $fd30
00BEA4  ; data: 0xfd, 0x80
00BEA6  ; data: 0xfd, 0xf8
00BEA8  dc.w   $fe98
00BEAA  dc.w   $ff38
00BEAC  ; data: 0x1d, 0x88
00BEAE  move.b $1db0ffb0(d1.l * 4), (a6, a7.l * 8)
00BEB8  dc.w   $fe70
00BEBA  dc.w   $fe20
00BEBC  ; data: 0xfd, 0xd0
00BEBE  ; data: 0xfd, 0xf8
00BEC0  dc.w   $fe48
00BEC2  dc.w   $fee8
00BEC4  ; data: 0xff, 0xb0
00BEC6  move.b $1db01db0(d1.l * 4), $fda8(a7.l * 4)
00BED2  ; data: 0xfd, 0xd0
00BED4  dc.w   $fe48
00BED6  dc.w   $fee8
00BED8  ; data: 0xff, 0x88
00BEDA  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00BEE4  dc.w   $fee8
00BEE6  dc.w   $fe20
00BEE8  ; data: 0xfd, 0x80
00BEEA  dc.w   $fd30
00BEEC  dc.w   $fd58
00BEEE  ; data: 0xfd, 0xa8
00BEF0  dc.w   $fe20
00BEF2  dc.w   $fee8
00BEF4  ; data: 0xff, 0x88
00BEF6  move.b $1db0ff88(d1.l * 4), -$18(a6, a7.l)
00BF00  dc.w   $fe48
00BF02  ; data: 0xfd, 0xa8
00BF04  dc.w   $fd30
00BF06  ; data: 0xfd, 0x08
00BF08  dc.w   $fd58
00BF0A  ; data: 0xfd, 0xd0
00BF0C  dc.w   $fe70
00BF0E  dc.w   $ff38
00BF10  ; data: 0x1d, 0x88
00BF12  move.b $1db0ffb0(d1.l * 4), (a6, a7.l * 8)
00BF1C  dc.w   $fe70
00BF1E  ; data: 0xfd, 0xf8
00BF20  ; data: 0xfd, 0xa8
00BF22  ; data: 0xfd, 0xd0
00BF24  dc.w   $fe48
00BF26  dc.w   $fee8
00BF28  ; data: 0xff, 0xb0
00BF2A  move.b $1db01db0(d1.l * 4), $fd80(a7.l * 4)
00BF36  ; data: 0xfd, 0xa8
00BF38  dc.w   $fe48
00BF3A  dc.w   $fee8
00BF3C  ; data: 0xff, 0xb0
00BF3E  move.b $1db01db0(d1.l * 4), $fee8fe20(a7.l * 8)
00BF4C  ; data: 0xfd, 0x80
00BF4E  dc.w   $fd30
00BF50  dc.w   $fd30
00BF52  ; data: 0xfd, 0x80
00BF54  dc.w   $fe20
00BF56  dc.w   $fee8
00BF58  ; data: 0xff, 0x88
00BF5A  move.b $1db0ffb0(d1.l * 4), -$18(a6, a7.l)
00BF64  dc.w   $fe20
00BF66  ; data: 0xfd, 0x80
00BF68  ; data: 0xfd, 0x08
00BF6A  dc.w   $fce0
00BF6C  dc.w   $fd30
00BF6E  ; data: 0xfd, 0xa8
00BF70  dc.w   $fe70
00BF72  dc.w   $ff38
00BF74  ; data: 0x1d, 0x88
00BF76  move.b $1db0ffb0(d1.l * 4), (a6, a7.l * 8)
00BF80  dc.w   $fe48
00BF82  ; data: 0xfd, 0xd0
00BF84  ; data: 0xfd, 0x80
00BF86  ; data: 0xfd, 0xa8
00BF88  dc.w   $fe20
00BF8A  dc.w   $fec0
00BF8C  ; data: 0xff, 0xb0
00BF8E  move.b $1db01db0(d1.l * 4), (a7.l * 4)
00BF98  dc.w   $fd58
00BF9A  ; data: 0xfd, 0xa8
00BF9C  dc.w   $fe20
00BF9E  dc.w   $fee8
00BFA0  move.b -(a0), $1db0(a6)
00BFA4  move.b $1db01d88(d1.l * 4), -$18(a6, a7.l)
00BFAE  dc.w   $fe20
00BFB0  dc.w   $fd58
00BFB2  ; data: 0xfd, 0x08
00BFB4  ; data: 0xfd, 0x08
00BFB6  dc.w   $fd58
00BFB8  dc.w   $fe20
00BFBA  dc.w   $fee8
00BFBC  ; data: 0xff, 0x88
00BFBE  move.b $1db0ffb0(d1.l * 4), -$18(a6, a7.l)
00BFC8  dc.w   $fe20
00BFCA  dc.w   $fd58
00BFCC  dc.w   $fce0
00BFCE  dc.w   $fcb8
00BFD0  ; data: 0xfd, 0x08
00BFD2  ; data: 0xfd, 0x80
00BFD4  dc.w   $fe70
00BFD6  dc.w   $ff38
00BFD8  move.b $1db01db0(d1.l * 4), $fee8(a6, invalid.w)
00BFE4  dc.w   $fe48
00BFE6  ; data: 0xfd, 0xa8
00BFE8  dc.w   $fd58
00BFEA  ; data: 0xfd, 0x80
00BFEC  ; data: 0xfd, 0xf8
00BFEE  dc.w   $fec0
00BFF0  ; data: 0xff, 0xb0
00BFF2  move.b $1db01db0(d1.l * 4), (a7.l * 4)
00BFFC  dc.w   $fd58
00BFFE  ; data: 0xfd, 0x80
00C000  dc.w   $fe20
00C002  dc.w   $ff10
00C004  ; data: 0x1d, 0x88
00C006  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00C010  dc.w   $fee8
00C012  dc.w   $fe20
00C014  dc.w   $fd58
00C016  dc.w   $fce0
00C018  dc.w   $fce0
00C01A  dc.w   $fd58
00C01C  ; data: 0xfd, 0xf8
00C01E  dc.w   $fee8
00C020  ; data: 0xff, 0xb0
00C022  move.b $1db01d60(d1.l * 4), -$18(a6, a7.l)
00C02C  ; data: 0xfd, 0xf8
00C02E  dc.w   $fd30
00C030  dc.w   $fcb8
00C032  dc.w   $fc90
00C034  dc.w   $fcb8
00C036  dc.w   $fd58
00C038  dc.w   $fe48
00C03A  dc.w   $ff38
00C03C  move.b $1db01db0(d1.l * 4), $fee8(a6, invalid.w)
00C048  dc.w   $fe20
00C04A  ; data: 0xfd, 0x80
00C04C  dc.w   $fd30
00C04E  dc.w   $fd58
00C050  ; data: 0xfd, 0xd0
00C052  dc.w   $fec0
00C054  ; data: 0xff, 0xb0
00C056  move.b $1db01db0(d1.l * 4), (a6, invalid.w)
00C060  dc.w   $fd30
00C062  ; data: 0xfd, 0x80
00C064  dc.w   $fe20
00C066  dc.w   $ff10
00C068  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00C076  ; data: 0xfd, 0xf8
00C078  dc.w   $fd30
00C07A  dc.w   $fce0
00C07C  dc.w   $fce0
00C07E  dc.w   $fd30
00C080  ; data: 0xfd, 0xf8
00C082  dc.w   $fee8
00C084  move.b -(a0), $1db0(a6)
00C088  move.b $1d60fee8(d1.l * 4), $fd08fc90(invalid.w)
00C096  dc.w   $fc68
00C098  dc.w   $fc90
00C09A  dc.w   $fd58
00C09C  dc.w   $fe48
00C09E  dc.w   $ff38
00C0A0  move.b $1db01db0(d1.l * 4), $fee8(a6, invalid.w)
00C0AC  ; data: 0xfd, 0xf8
00C0AE  dc.w   $fd58
00C0B0  ; data: 0xfd, 0x08
00C0B2  dc.w   $fd30
00C0B4  ; data: 0xfd, 0xd0
00C0B6  dc.w   $fe98
00C0B8  ; data: 0xff, 0xb0
00C0BA  move.b $1db01db0(d1.l * 4), (a6, invalid.w)
00C0C4  dc.w   $fd30
00C0C6  ; data: 0xfd, 0x80
00C0C8  dc.w   $fe20
00C0CA  dc.w   $ff10
00C0CC  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00C0DA  ; data: 0xfd, 0xf8
00C0DC  dc.w   $fd30
00C0DE  dc.w   $fcb8
00C0E0  dc.w   $fcb8
00C0E2  dc.w   $fd30
00C0E4  ; data: 0xfd, 0xf8
00C0E6  dc.w   $fee8
00C0E8  move.b -(a0), $1db0(a6)
00C0EC  move.b $1d88fee8(d1.l * 4), (invalid.w)
00C0F6  dc.w   $fce0
00C0F8  dc.w   $fc68
00C0FA  dc.w   $fc40
00C0FC  dc.w   $fc68
00C0FE  dc.w   $fd30
00C100  dc.w   $fe20
00C102  dc.w   $ff38
00C104  move.b $1db01db0(d1.l * 4), $fee8(a6, invalid.w)
00C110  ; data: 0xfd, 0xf8
00C112  dc.w   $fd58
00C114  ; data: 0xfd, 0x08
00C116  dc.w   $fd30
00C118  ; data: 0xfd, 0xa8
00C11A  dc.w   $fe98
00C11C  ; data: 0xff, 0xb0
00C11E  move.b $1db01db0(d1.l * 4), (a6, invalid.w)
00C128  dc.w   $fd30
00C12A  ; data: 0xfd, 0x80
00C12C  dc.w   $fe20
00C12E  dc.w   $ff10
00C130  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00C13E  ; data: 0xfd, 0xf8
00C140  dc.w   $fd30
00C142  dc.w   $fcb8
00C144  dc.w   $fcb8
00C146  dc.w   $fd30
00C148  ; data: 0xfd, 0xf8
00C14A  dc.w   $fee8
00C14C  ; data: 0x1d, 0x88
00C14E  move.b $1db01d88(d1.l * 4), -$40(a6, a7.l)
00C158  ; data: 0xfd, 0xd0
00C15A  dc.w   $fce0
00C15C  dc.w   $fc40
00C15E  ; data: 0xfb, 0xf0
00C160  dc.w   $fc40
00C162  ; data: 0xfd, 0x08
00C164  dc.w   $fe20
00C166  dc.w   $ff10
00C168  move.b $1db01db0(d1.l * 4), $fec0(a6, invalid.w)
00C174  ; data: 0xfd, 0xd0
00C176  dc.w   $fd30
00C178  dc.w   $fce0
00C17A  ; data: 0xfd, 0x08
00C17C  ; data: 0xfd, 0xa8
00C17E  dc.w   $fe98
00C180  move.b -(a0), $1db0(a6)
00C184  move.b $1db0fd58(d1.l * 4), $fd80fe20(a6, a7.l * 4)
00C192  dc.w   $ff38
00C194  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00C1A2  ; data: 0xfd, 0xf8
00C1A4  dc.w   $fd30
00C1A6  dc.w   $fc90
00C1A8  dc.w   $fc90
00C1AA  ; data: 0xfd, 0x08
00C1AC  ; data: 0xfd, 0xf8
00C1AE  dc.w   $fee8
00C1B0  ; data: 0x1d, 0x88
00C1B2  move.b $1db01d88(d1.l * 4), -$40(a6, a7.l)
00C1BC  ; data: 0xfd, 0xa8
00C1BE  dc.w   $fcb8
00C1C0  dc.w   $fc18
00C1C2  ; data: 0xfb, 0xf0
00C1C4  dc.w   $fc40
00C1C6  dc.w   $fce0
00C1C8  ; data: 0xfd, 0xf8
00C1CA  dc.w   $ff10
00C1CC  move.b $1db01db0(d1.l * 4), $fec0(a6, invalid.w)
00C1D8  ; data: 0xfd, 0xd0
00C1DA  ; data: 0xfd, 0x08
00C1DC  dc.w   $fcb8
00C1DE  dc.w   $fce0
00C1E0  ; data: 0xfd, 0x80
00C1E2  dc.w   $fe98
00C1E4  move.b -(a0), $1db0(a6)
00C1E8  move.b $1db0fd58(d1.l * 4), (a6, a7.l * 4)
00C1F2  ; data: 0xfd, 0x80
00C1F4  dc.w   $fe20
00C1F6  dc.w   $ff38
00C1F8  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00C206  ; data: 0xfd, 0xf8
00C208  ; data: 0xfd, 0x08
00C20A  dc.w   $fc90
00C20C  dc.w   $fc90
00C20E  ; data: 0xfd, 0x08
00C210  ; data: 0xfd, 0xd0
00C212  dc.w   $fee8
00C214  ; data: 0x1d, 0x88
00C216  move.b $1db01d88(d1.l * 4), -$40(a6, a7.l)
00C220  ; data: 0xfd, 0xa8
00C222  dc.w   $fc90
00C224  ; data: 0xfb, 0xf0
00C226  ; data: 0xfb, 0xc8
00C228  dc.w   $fc18
00C22A  dc.w   $fce0
00C22C  ; data: 0xfd, 0xd0
00C22E  dc.w   $ff10
00C230  move.b $1db01db0(d1.l * 4), $fec0fda8(a7.l * 8)
00C23E  ; data: 0xfd, 0x08
00C240  dc.w   $fcb8
00C242  dc.w   $fce0
00C244  ; data: 0xfd, 0x80
00C246  dc.w   $fe70
00C248  move.b -(a0), $1db0(a6)
00C24C  move.b $1db0fd58(d1.l * 4), $fd80fe48(a6, a7.l * 4)
00C25A  dc.w   $ff38
00C25C  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00C26A  ; data: 0xfd, 0xf8
00C26C  ; data: 0xfd, 0x08
00C26E  dc.w   $fc90
00C270  dc.w   $fc90
00C272  ; data: 0xfd, 0x08
00C274  ; data: 0xfd, 0xd0
00C276  dc.w   $fee8
00C278  ; data: 0x1d, 0x88
00C27A  move.b $1db01d60(d1.l * 4), -$40(a6, a7.l)
00C284  ; data: 0xfd, 0x80
00C286  dc.w   $fc90
00C288  ; data: 0xfb, 0xc8
00C28A  ; data: 0xfb, 0xa0
00C28C  ; data: 0xfb, 0xf0
00C28E  dc.w   $fcb8
00C290  ; data: 0xfd, 0xd0
00C292  dc.w   $fee8
00C294  move.b $1db01db0(d1.l * 4), $fe98fda8(a7.l * 8)
00C2A2  dc.w   $fce0
00C2A4  dc.w   $fc90
00C2A6  dc.w   $fcb8
00C2A8  ; data: 0xfd, 0x80
00C2AA  dc.w   $fe70
00C2AC  move.b -(a0), $1db0(a6)
00C2B0  move.b $1db0fd58(d1.l * 4), $fd80fe48(a6, a7.l * 4)
00C2BE  ; data: 0xff, 0x60
00C2C0  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00C2CE  dc.w   $fe20
00C2D0  ; data: 0xfd, 0x08
00C2D2  dc.w   $fc90
00C2D4  dc.w   $fc90
00C2D6  ; data: 0xfd, 0x08
00C2D8  ; data: 0xfd, 0xd0
00C2DA  dc.w   $fee8
00C2DC  ; data: 0x1d, 0x88
00C2DE  move.b $1db01d60(d1.l * 4), -$68(a6, a7.l)
00C2E8  ; data: 0xfd, 0x80
00C2EA  dc.w   $fc68
00C2EC  ; data: 0xfb, 0xa0
00C2EE  dc.w   $fb78
00C2F0  ; data: 0xfb, 0xc8
00C2F2  dc.w   $fc90
00C2F4  ; data: 0xfd, 0xa8
00C2F6  dc.w   $fee8
00C2F8  ; data: 0x1d, 0x88
00C2FA  move.b $1db0ff88(d1.l * 4), -$68(a6, a7.l)
00C304  ; data: 0xfd, 0xa8
00C306  dc.w   $fce0
00C308  dc.w   $fc90
00C30A  dc.w   $fcb8
00C30C  dc.w   $fd58
00C30E  dc.w   $fe70
00C310  move.b -(a0), $1db0(a6)
00C314  move.b $1db0fd58(d1.l * 4), $fd80fe48(a6, a7.l * 4)
00C322  ; data: 0xff, 0x60
00C324  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
00C332  dc.w   $fe20
00C334  dc.w   $fd30
00C336  dc.w   $fc90
00C338  dc.w   $fc90
00C33A  ; data: 0xfd, 0x08
00C33C  ; data: 0xfd, 0xd0
00C33E  dc.w   $fee8
00C340  ; data: 0x1d, 0x88
00C342  move.b $1db0ffb0(d1.l * 4), -$68(a6, a7.l)
00C34C  dc.w   $fd58
00C34E  dc.w   $fc40
00C350  ; data: 0xfb, 0xa0
00C352  dc.w   $fb50
00C354  ; data: 0xfb, 0xc8
00C356  dc.w   $fc90
00C358  ; data: 0xfd, 0xa8
00C35A  dc.w   $fec0
00C35C  ; data: 0x1d, 0x88
00C35E  move.b $1db0ff88(d1.l * 4), -$68(a6, a7.l)
00C368  ; data: 0xfd, 0x80
00C36A  dc.w   $fcb8
00C36C  dc.w   $fc68
00C36E  dc.w   $fcb8
00C370  dc.w   $fd58
00C372  dc.w   $fe70
00C374  move.b -(a0), $1db0(a6)
00C378  move.b $1db0fd58(d1.l * 4), $fda8fe70(a6, a7.l * 4)
00C386  ; data: 0xff, 0x88
00C388  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
00C396  dc.w   $fe20
00C398  dc.w   $fd30
00C39A  dc.w   $fc90
00C39C  dc.w   $fc90
00C39E  ; data: 0xfd, 0x08
00C3A0  ; data: 0xfd, 0xd0
00C3A2  dc.w   $fee8
00C3A4  ; data: 0x1d, 0x88
00C3A6  move.b $1db0ffb0(d1.l * 4), -$68(a6, a7.l)
00C3B0  dc.w   $fd58
00C3B2  dc.w   $fc40
00C3B4  dc.w   $fb78
00C3B6  dc.w   $fb50
00C3B8  ; data: 0xfb, 0xa0
00C3BA  dc.w   $fc68
00C3BC  ; data: 0xfd, 0x80
00C3BE  dc.w   $fec0
00C3C0  move.b -(a0), $1db0(a6)
00C3C4  move.b $ff88fe70(d1.l * 4), (a7.l * 4)
00C3CE  dc.w   $fcb8
00C3D0  dc.w   $fc68
00C3D2  dc.w   $fcb8
00C3D4  dc.w   $fd58
00C3D6  dc.w   $fe70
00C3D8  move.b -(a0), $1db0(a6)
00C3DC  move.b $1db0fd80(d1.l * 4), (a6, invalid.w)
00C3E6  ; data: 0xfd, 0xa8
00C3E8  dc.w   $fe70
00C3EA  ; data: 0xff, 0x88
00C3EC  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
00C3FA  dc.w   $fe20
00C3FC  dc.w   $fd30
00C3FE  dc.w   $fc90
00C400  dc.w   $fc90
00C402  ; data: 0xfd, 0x08
00C404  ; data: 0xfd, 0xd0
00C406  dc.w   $fec0
00C408  ; data: 0x1d, 0x88
00C40A  move.b $1db0ff88(d1.l * 4), $70(a6, a7.l)
00C414  dc.w   $fd30
00C416  dc.w   $fc18
00C418  dc.w   $fb78
00C41A  dc.w   $fb28
00C41C  dc.w   $fb78
00C41E  dc.w   $fc68
00C420  ; data: 0xfd, 0x80
00C422  dc.w   $fe98
00C424  ; data: 0xff, 0xb0
00C426  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
00C430  ; data: 0xfd, 0x80
00C432  dc.w   $fcb8
00C434  dc.w   $fc68
00C436  dc.w   $fcb8
00C438  dc.w   $fd58
00C43A  dc.w   $fe70
00C43C  move.b -(a0), $1db0(a6)
00C440  move.b $1db0fda8(d1.l * 4), (a7.l * 4)
00C44A  ; data: 0xfd, 0xd0
00C44C  dc.w   $fe98
00C44E  ; data: 0xff, 0xb0
00C450  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
00C45E  dc.w   $fe48
00C460  dc.w   $fd30
00C462  dc.w   $fcb8
00C464  dc.w   $fc90
00C466  ; data: 0xfd, 0x08
00C468  ; data: 0xfd, 0xd0
00C46A  dc.w   $fec0
00C46C  move.b -(a0), $1db0(a6)
00C470  move.b $ff88fe70(d1.l * 4), $fc18fb50(a6, a7.l * 4)
00C47E  dc.w   $fb28
00C480  dc.w   $fb78
00C482  dc.w   $fc40
00C484  dc.w   $fd58
00C486  dc.w   $fe98
00C488  ; data: 0xff, 0x88
00C48A  move.b $1db0ff60(d1.l * 4), $70(a6, a7.l)
00C494  ; data: 0xfd, 0x80
00C496  dc.w   $fcb8
00C498  dc.w   $fc68
00C49A  dc.w   $fcb8
00C49C  dc.w   $fd58
00C49E  dc.w   $fe70
00C4A0  ; data: 0x1d, 0x88
00C4A2  move.b $1db01db0(d1.l * 4), $fd80(a7.l * 4)
00C4AE  ; data: 0xfd, 0xf8
00C4B0  dc.w   $fec0
00C4B2  ; data: 0x1d, 0x88
00C4B4  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
00C4C2  dc.w   $fe48
00C4C4  dc.w   $fd58
00C4C6  dc.w   $fcb8
00C4C8  dc.w   $fcb8
00C4CA  ; data: 0xfd, 0x08
00C4CC  ; data: 0xfd, 0xd0
00C4CE  dc.w   $fec0
00C4D0  ; data: 0xff, 0xb0
00C4D2  move.b $1db0ff60(d1.l * 4), $48(a6, a7.l)
00C4DC  ; data: 0xfd, 0x08
00C4DE  dc.w   $fc18
00C4E0  dc.w   $fb50
00C4E2  dc.w   $fb28
00C4E4  dc.w   $fb78
00C4E6  dc.w   $fc40
00C4E8  dc.w   $fd58
00C4EA  dc.w   $fe70
00C4EC  ; data: 0xff, 0x60
00C4EE  move.b $1db0ff38(d1.l * 4), $48(a6, a7.l)
00C4F8  dc.w   $fd58
00C4FA  dc.w   $fcb8
00C4FC  dc.w   $fc68
00C4FE  dc.w   $fcb8
00C500  dc.w   $fd58
00C502  dc.w   $fe70
00C504  ; data: 0x1d, 0x88
00C506  move.b $1db01db0(d1.l * 4), (invalid.w)
00C510  ; data: 0xfd, 0xa8
00C512  dc.w   $fe20
00C514  dc.w   $fee8
00C516  ; data: 0x1d, 0x88
00C518  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
00C526  dc.w   $fe70
00C528  ; data: 0xfd, 0x80
00C52A  dc.w   $fce0
00C52C  dc.w   $fcb8
00C52E  dc.w   $fd30
00C530  ; data: 0xfd, 0xd0
00C532  dc.w   $fec0
00C534  ; data: 0xff, 0x88
00C536  move.b $1db0ff38(d1.l * 4), $20(a6, a7.l)
00C540  ; data: 0xfd, 0x08
00C542  ; data: 0xfb, 0xf0
00C544  dc.w   $fb50
00C546  ; data: 0xfb, 0x00
00C548  dc.w   $fb50
00C54A  dc.w   $fc18
00C54C  dc.w   $fd30
00C54E  dc.w   $fe48
00C550  dc.w   $ff38
00C552  move.b $1d88ff38(d1.l * 4), $48(a6, a7.l)
00C55C  dc.w   $fd58
00C55E  dc.w   $fcb8
00C560  dc.w   $fc68
00C562  dc.w   $fcb8
00C564  ; data: 0xfd, 0x80
00C566  dc.w   $fe98
00C568  ; data: 0x1d, 0x88
00C56A  move.b $1db01db0(d1.l * 4), $fdd0fe48(invalid.w)
00C578  dc.w   $fee8
00C57A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C588  ; data: 0xff, 0xb0
00C58A  dc.w   $fe70
00C58C  ; data: 0xfd, 0x80
00C58E  ; data: 0xfd, 0x08
00C590  dc.w   $fce0
00C592  dc.w   $fd30
00C594  ; data: 0xfd, 0xd0
00C596  dc.w   $fec0
00C598  ; data: 0xff, 0x88
00C59A  move.b $1d88ff10(d1.l * 4), $20(a6, a7.l)
00C5A4  dc.w   $fce0
00C5A6  ; data: 0xfb, 0xf0
00C5A8  dc.w   $fb50
00C5AA  ; data: 0xfb, 0x00
00C5AC  dc.w   $fb50
00C5AE  dc.w   $fc18
00C5B0  ; data: 0xfd, 0x08
00C5B2  dc.w   $fe20
00C5B4  dc.w   $ff10
00C5B6  move.b -(a0), $1db0(a6)
00C5BA  ; data: 0xff, 0xb0
00C5BC  dc.w   $ff10
00C5BE  dc.w   $fe20
00C5C0  dc.w   $fd58
00C5C2  dc.w   $fcb8
00C5C4  dc.w   $fc90
00C5C6  dc.w   $fcb8
00C5C8  ; data: 0xfd, 0x80
00C5CA  dc.w   $fe98
00C5CC  ; data: 0x1d, 0x88
00C5CE  move.b $1db01db0(d1.l * 4), $20(a6, a7.l)
00C5D8  ; data: 0xfd, 0xf8
00C5DA  dc.w   $fe70
00C5DC  dc.w   $ff10
00C5DE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C5EC  move.b -(a0), -$168(a6)
00C5F0  ; data: 0xfd, 0xa8
00C5F2  ; data: 0xfd, 0x08
00C5F4  dc.w   $fce0
00C5F6  dc.w   $fd30
00C5F8  ; data: 0xfd, 0xf8
00C5FA  dc.w   $fec0
00C5FC  ; data: 0xff, 0x60
00C5FE  move.b $1d60ff10(d1.l * 4), $fce0fbf0(invalid.w)
00C60C  dc.w   $fb50
00C60E  ; data: 0xfb, 0x00
00C610  dc.w   $fb50
00C612  ; data: 0xfb, 0xf0
00C614  ; data: 0xfd, 0x08
00C616  ; data: 0xfd, 0xf8
00C618  dc.w   $fee8
00C61A  ; data: 0xff, 0x88
00C61C  move.b -(a0), -$78(a6)
00C620  dc.w   $fee8
00C622  dc.w   $fe20
00C624  dc.w   $fd58
00C626  dc.w   $fcb8
00C628  dc.w   $fc90
00C62A  dc.w   $fce0
00C62C  ; data: 0xfd, 0x80
00C62E  dc.w   $fe98
00C630  ; data: 0x1d, 0x88
00C632  move.b $1db01db0(d1.l * 4), $48(a6, a7.l)
00C63C  dc.w   $fe48
00C63E  dc.w   $fe98
00C640  dc.w   $ff38
00C642  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C650  ; data: 0x1d, 0x88
00C652  dc.w   $fec0
00C654  ; data: 0xfd, 0xd0
00C656  dc.w   $fd30
00C658  ; data: 0xfd, 0x08
00C65A  dc.w   $fd58
00C65C  ; data: 0xfd, 0xf8
00C65E  dc.w   $fe98
00C660  ; data: 0xff, 0x60
00C662  ; data: 0x1d, 0x88
00C664  ; data: 0x1d, 0x88
00C666  ; data: 0xff, 0x88
00C668  dc.w   $fee8
00C66A  ; data: 0xfd, 0xd0
00C66C  dc.w   $fce0
00C66E  ; data: 0xfb, 0xf0
00C670  dc.w   $fb50
00C672  ; data: 0xfb, 0x00
00C674  dc.w   $fb50
00C676  ; data: 0xfb, 0xf0
00C678  dc.w   $fce0
00C67A  ; data: 0xfd, 0xf8
00C67C  dc.w   $fec0
00C67E  ; data: 0xff, 0x60
00C680  ; data: 0xff, 0x88
00C682  ; data: 0xff, 0x60
00C684  dc.w   $fec0
00C686  dc.w   $fe20
00C688  dc.w   $fd58
00C68A  dc.w   $fce0
00C68C  dc.w   $fcb8
00C68E  dc.w   $fce0
00C690  ; data: 0xfd, 0xa8
00C692  dc.w   $fe98
00C694  ; data: 0x1d, 0x88
00C696  move.b $1db01db0(d1.l * 4), $70(a6, a7.l)
00C6A0  dc.w   $fe70
00C6A2  dc.w   $fec0
00C6A4  ; data: 0xff, 0x60
00C6A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C6B4  ; data: 0x1d, 0x88
00C6B6  dc.w   $fec0
00C6B8  ; data: 0xfd, 0xf8
00C6BA  dc.w   $fd58
00C6BC  dc.w   $fd30
00C6BE  ; data: 0xfd, 0x80
00C6C0  ; data: 0xfd, 0xf8
00C6C2  dc.w   $fe98
00C6C4  dc.w   $ff38
00C6C6  ; data: 0xff, 0xb0
00C6C8  move.b -(a0), -$a0(a6)
00C6CC  dc.w   $fec0
00C6CE  ; data: 0xfd, 0xd0
00C6D0  dc.w   $fcb8
00C6D2  ; data: 0xfb, 0xc8
00C6D4  dc.w   $fb50
00C6D6  ; data: 0xfb, 0x00
00C6D8  dc.w   $fb50
00C6DA  ; data: 0xfb, 0xf0
00C6DC  dc.w   $fcb8
00C6DE  ; data: 0xfd, 0xd0
00C6E0  dc.w   $fe98
00C6E2  dc.w   $ff38
00C6E4  ; data: 0xff, 0x60
00C6E6  dc.w   $ff38
00C6E8  dc.w   $fec0
00C6EA  ; data: 0xfd, 0xf8
00C6EC  dc.w   $fd58
00C6EE  dc.w   $fce0
00C6F0  dc.w   $fcb8
00C6F2  ; data: 0xfd, 0x08
00C6F4  ; data: 0xfd, 0xa8
00C6F6  dc.w   $fec0
00C6F8  ; data: 0x1d, 0x88
00C6FA  move.b $1db01db0(d1.l * 4), -$40(a6, a7.l)
00C704  dc.w   $fe98
00C706  dc.w   $fee8
00C708  ; data: 0xff, 0x88
00C70A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C718  ; data: 0x1d, 0x88
00C71A  dc.w   $fee8
00C71C  dc.w   $fe20
00C71E  ; data: 0xfd, 0x80
00C720  dc.w   $fd58
00C722  ; data: 0xfd, 0x80
00C724  ; data: 0xfd, 0xf8
00C726  dc.w   $fe98
00C728  dc.w   $ff38
00C72A  ; data: 0xff, 0x88
00C72C  ; data: 0xff, 0x88
00C72E  dc.w   $ff38
00C730  dc.w   $fe98
00C732  ; data: 0xfd, 0xa8
00C734  dc.w   $fcb8
00C736  ; data: 0xfb, 0xc8
00C738  dc.w   $fb50
00C73A  ; data: 0xfb, 0x00
00C73C  dc.w   $fb50
00C73E  ; data: 0xfb, 0xc8
00C740  dc.w   $fcb8
00C742  ; data: 0xfd, 0xa8
00C744  dc.w   $fe70
00C746  dc.w   $fee8
00C748  dc.w   $ff38
00C74A  dc.w   $ff10
00C74C  dc.w   $fe98
00C74E  ; data: 0xfd, 0xf8
00C750  dc.w   $fd58
00C752  dc.w   $fce0
00C754  dc.w   $fce0
00C756  dc.w   $fd30
00C758  ; data: 0xfd, 0xd0
00C75A  dc.w   $fec0
00C75C  ; data: 0x1d, 0x88
00C75E  move.b $1db01db0(d1.l * 4), -$18(a6, a7.l)
00C768  dc.w   $fee8
00C76A  dc.w   $ff38
00C76C  move.b -(a0), $1db0(a6)
00C770  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C77E  dc.w   $ff10
00C780  dc.w   $fe48
00C782  ; data: 0xfd, 0xa8
00C784  ; data: 0xfd, 0x80
00C786  ; data: 0xfd, 0xa8
00C788  ; data: 0xfd, 0xf8
00C78A  dc.w   $fe98
00C78C  dc.w   $ff10
00C78E  ; data: 0xff, 0x60
00C790  ; data: 0xff, 0x60
00C792  dc.w   $ff10
00C794  dc.w   $fe70
00C796  ; data: 0xfd, 0x80
00C798  dc.w   $fc90
00C79A  ; data: 0xfb, 0xc8
00C79C  dc.w   $fb50
00C79E  ; data: 0xfb, 0x00
00C7A0  dc.w   $fb50
00C7A2  ; data: 0xfb, 0xc8
00C7A4  dc.w   $fc90
00C7A6  ; data: 0xfd, 0x80
00C7A8  dc.w   $fe20
00C7AA  dc.w   $fec0
00C7AC  dc.w   $fee8
00C7AE  dc.w   $fec0
00C7B0  dc.w   $fe70
00C7B2  ; data: 0xfd, 0xd0
00C7B4  dc.w   $fd58
00C7B6  ; data: 0xfd, 0x08
00C7B8  dc.w   $fce0
00C7BA  dc.w   $fd30
00C7BC  ; data: 0xfd, 0xd0
00C7BE  dc.w   $fec0
00C7C0  ; data: 0x1d, 0x88
00C7C2  move.b $1db01db0(d1.l * 4), (a6, a7.l * 8)
00C7CC  dc.w   $ff10
00C7CE  ; data: 0xff, 0x60
00C7D0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C7DE  move.b $ff10fe70(d1.l * 4), (invalid.w)
00C7E8  ; data: 0xfd, 0xa8
00C7EA  ; data: 0xfd, 0xd0
00C7EC  dc.w   $fe20
00C7EE  dc.w   $fe98
00C7F0  dc.w   $fee8
00C7F2  dc.w   $ff38
00C7F4  dc.w   $ff38
00C7F6  dc.w   $fec0
00C7F8  dc.w   $fe20
00C7FA  dc.w   $fd58
00C7FC  dc.w   $fc90
00C7FE  ; data: 0xfb, 0xc8
00C800  dc.w   $fb50
00C802  dc.w   $fb28
00C804  dc.w   $fb50
00C806  ; data: 0xfb, 0xc8
00C808  dc.w   $fc68
00C80A  dc.w   $fd58
00C80C  ; data: 0xfd, 0xf8
00C80E  dc.w   $fe70
00C810  dc.w   $fec0
00C812  dc.w   $fe98
00C814  dc.w   $fe48
00C816  ; data: 0xfd, 0xd0
00C818  dc.w   $fd58
00C81A  ; data: 0xfd, 0x08
00C81C  ; data: 0xfd, 0x08
00C81E  dc.w   $fd58
00C820  ; data: 0xfd, 0xf8
00C822  dc.w   $fee8
00C824  ; data: 0x1d, 0x88
00C826  move.b $1db01db0(d1.l * 4), $ff60(a6, invalid.w)
00C832  ; data: 0xff, 0x88
00C834  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C842  move.b $ff38fe98(d1.l * 4), $fdd0fdd0(invalid.w)
00C850  dc.w   $fe20
00C852  dc.w   $fe70
00C854  dc.w   $fec0
00C856  dc.w   $ff10
00C858  dc.w   $fee8
00C85A  dc.w   $fe98
00C85C  ; data: 0xfd, 0xf8
00C85E  dc.w   $fd30
00C860  dc.w   $fc68
00C862  ; data: 0xfb, 0xc8
00C864  dc.w   $fb50
00C866  dc.w   $fb28
00C868  dc.w   $fb50
00C86A  ; data: 0xfb, 0xc8
00C86C  dc.w   $fc68
00C86E  ; data: 0xfd, 0x08
00C870  ; data: 0xfd, 0xd0
00C872  dc.w   $fe48
00C874  dc.w   $fe70
00C876  dc.w   $fe70
00C878  dc.w   $fe20
00C87A  ; data: 0xfd, 0xa8
00C87C  dc.w   $fd58
00C87E  dc.w   $fd30
00C880  dc.w   $fd30
00C882  ; data: 0xfd, 0x80
00C884  dc.w   $fe20
00C886  dc.w   $fee8
00C888  ; data: 0x1d, 0x88
00C88A  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00C894  ; data: 0xff, 0x88
00C896  ; data: 0x1d, 0x88
00C898  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C8A6  move.b $ff60fec0(d1.l * 4), $20(a6, a7.l)
00C8B0  ; data: 0xfd, 0xf8
00C8B2  ; data: 0xfd, 0xf8
00C8B4  dc.w   $fe20
00C8B6  dc.w   $fe70
00C8B8  dc.w   $fec0
00C8BA  dc.w   $fee8
00C8BC  dc.w   $fec0
00C8BE  dc.w   $fe70
00C8C0  ; data: 0xfd, 0xd0
00C8C2  dc.w   $fd30
00C8C4  dc.w   $fc68
00C8C6  ; data: 0xfb, 0xc8
00C8C8  dc.w   $fb50
00C8CA  dc.w   $fb28
00C8CC  dc.w   $fb50
00C8CE  ; data: 0xfb, 0xa0
00C8D0  dc.w   $fc40
00C8D2  dc.w   $fce0
00C8D4  ; data: 0xfd, 0x80
00C8D6  ; data: 0xfd, 0xf8
00C8D8  dc.w   $fe20
00C8DA  dc.w   $fe20
00C8DC  ; data: 0xfd, 0xf8
00C8DE  ; data: 0xfd, 0xa8
00C8E0  dc.w   $fd58
00C8E2  dc.w   $fd30
00C8E4  dc.w   $fd30
00C8E6  ; data: 0xfd, 0xa8
00C8E8  dc.w   $fe20
00C8EA  dc.w   $fee8
00C8EC  ; data: 0x1d, 0x88
00C8EE  move.b $1db01db0(d1.l * 4), $1d88(a6, invalid.w)
00C8FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C908  move.b $1db0ff88(d1.l * 4), -$18(a6, a7.l)
00C912  dc.w   $fe70
00C914  dc.w   $fe20
00C916  dc.w   $fe20
00C918  dc.w   $fe20
00C91A  dc.w   $fe70
00C91C  dc.w   $fe98
00C91E  dc.w   $fe98
00C920  dc.w   $fe98
00C922  dc.w   $fe20
00C924  ; data: 0xfd, 0xa8
00C926  ; data: 0xfd, 0x08
00C928  dc.w   $fc40
00C92A  ; data: 0xfb, 0xc8
00C92C  dc.w   $fb50
00C92E  dc.w   $fb28
00C930  dc.w   $fb50
00C932  ; data: 0xfb, 0xa0
00C934  dc.w   $fc18
00C936  dc.w   $fcb8
00C938  dc.w   $fd58
00C93A  ; data: 0xfd, 0xa8
00C93C  ; data: 0xfd, 0xf8
00C93E  ; data: 0xfd, 0xf8
00C940  ; data: 0xfd, 0xd0
00C942  ; data: 0xfd, 0xa8
00C944  dc.w   $fd58
00C946  dc.w   $fd58
00C948  dc.w   $fd58
00C94A  ; data: 0xfd, 0xa8
00C94C  dc.w   $fe48
00C94E  dc.w   $ff10
00C950  ; data: 0x1d, 0x88
00C952  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C960  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C96E  move.b $ffb0ff10(d1.l * 4), -$68(a6, a7.l)
00C978  dc.w   $fe48
00C97A  dc.w   $fe20
00C97C  dc.w   $fe48
00C97E  dc.w   $fe70
00C980  dc.w   $fe70
00C982  dc.w   $fe70
00C984  dc.w   $fe48
00C986  ; data: 0xfd, 0xf8
00C988  ; data: 0xfd, 0x80
00C98A  dc.w   $fce0
00C98C  dc.w   $fc40
00C98E  ; data: 0xfb, 0xa0
00C990  dc.w   $fb50
00C992  dc.w   $fb28
00C994  dc.w   $fb50
00C996  ; data: 0xfb, 0xa0
00C998  dc.w   $fc18
00C99A  dc.w   $fc90
00C99C  ; data: 0xfd, 0x08
00C99E  ; data: 0xfd, 0x80
00C9A0  ; data: 0xfd, 0xa8
00C9A2  ; data: 0xfd, 0xd0
00C9A4  ; data: 0xfd, 0xa8
00C9A6  ; data: 0xfd, 0x80
00C9A8  dc.w   $fd58
00C9AA  dc.w   $fd58
00C9AC  ; data: 0xfd, 0x80
00C9AE  ; data: 0xfd, 0xd0
00C9B0  dc.w   $fe70
00C9B2  dc.w   $ff10
00C9B4  ; data: 0x1d, 0x88
00C9B6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C9C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00C9D2  move.b $1d60ff38(d1.l * 4), -$40(a6, a7.l)
00C9DC  dc.w   $fe70
00C9DE  dc.w   $fe48
00C9E0  dc.w   $fe48
00C9E2  dc.w   $fe48
00C9E4  dc.w   $fe48
00C9E6  dc.w   $fe48
00C9E8  dc.w   $fe20
00C9EA  ; data: 0xfd, 0xd0
00C9EC  dc.w   $fd58
00C9EE  dc.w   $fcb8
00C9F0  dc.w   $fc18
00C9F2  ; data: 0xfb, 0xa0
00C9F4  dc.w   $fb50
00C9F6  dc.w   $fb28
00C9F8  dc.w   $fb50
00C9FA  dc.w   $fb78
00C9FC  ; data: 0xfb, 0xf0
00C9FE  dc.w   $fc68
00CA00  dc.w   $fce0
00CA02  dc.w   $fd30
00CA04  ; data: 0xfd, 0x80
00CA06  ; data: 0xfd, 0x80
00CA08  ; data: 0xfd, 0x80
00CA0A  ; data: 0xfd, 0x80
00CA0C  dc.w   $fd58
00CA0E  dc.w   $fd58
00CA10  ; data: 0xfd, 0xa8
00CA12  ; data: 0xfd, 0xf8
00CA14  dc.w   $fe70
00CA16  dc.w   $ff10
00CA18  ; data: 0x1d, 0x88
00CA1A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CA28  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CA36  move.b $1d88ff60(d1.l * 4), -$18(a6, a7.l)
00CA40  dc.w   $fe98
00CA42  dc.w   $fe70
00CA44  dc.w   $fe48
00CA46  dc.w   $fe48
00CA48  dc.w   $fe48
00CA4A  dc.w   $fe20
00CA4C  ; data: 0xfd, 0xf8
00CA4E  ; data: 0xfd, 0x80
00CA50  dc.w   $fd30
00CA52  dc.w   $fc90
00CA54  dc.w   $fc18
00CA56  ; data: 0xfb, 0xa0
00CA58  dc.w   $fb50
00CA5A  dc.w   $fb28
00CA5C  dc.w   $fb50
00CA5E  dc.w   $fb78
00CA60  ; data: 0xfb, 0xc8
00CA62  dc.w   $fc40
00CA64  dc.w   $fcb8
00CA66  ; data: 0xfd, 0x08
00CA68  dc.w   $fd30
00CA6A  dc.w   $fd58
00CA6C  dc.w   $fd58
00CA6E  dc.w   $fd58
00CA70  dc.w   $fd58
00CA72  ; data: 0xfd, 0x80
00CA74  ; data: 0xfd, 0xa8
00CA76  dc.w   $fe20
00CA78  dc.w   $fe98
00CA7A  dc.w   $ff38
00CA7C  ; data: 0x1d, 0x88
00CA7E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CA8C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CA9A  move.b $1db0ff88(d1.l * 4), (a6, a7.l * 8)
00CAA4  dc.w   $fec0
00CAA6  dc.w   $fe70
00CAA8  dc.w   $fe48
00CAAA  dc.w   $fe48
00CAAC  dc.w   $fe20
00CAAE  ; data: 0xfd, 0xf8
00CAB0  ; data: 0xfd, 0xa8
00CAB2  dc.w   $fd58
00CAB4  dc.w   $fce0
00CAB6  dc.w   $fc68
00CAB8  ; data: 0xfb, 0xf0
00CABA  ; data: 0xfb, 0xa0
00CABC  dc.w   $fb50
00CABE  dc.w   $fb28
00CAC0  dc.w   $fb28
00CAC2  dc.w   $fb78
00CAC4  ; data: 0xfb, 0xc8
00CAC6  dc.w   $fc18
00CAC8  dc.w   $fc68
00CACA  dc.w   $fcb8
00CACC  ; data: 0xfd, 0x08
00CACE  dc.w   $fd30
00CAD0  dc.w   $fd30
00CAD2  dc.w   $fd58
00CAD4  dc.w   $fd58
00CAD6  ; data: 0xfd, 0x80
00CAD8  ; data: 0xfd, 0xd0
00CADA  dc.w   $fe20
00CADC  dc.w   $fe98
00CADE  dc.w   $ff38
00CAE0  ; data: 0x1d, 0x88
00CAE2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CAF0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CAFE  move.b $1db0ffb0(d1.l * 4), $fee8fe98(a6, a7.l * 8)
00CB0C  dc.w   $fe70
00CB0E  dc.w   $fe20
00CB10  ; data: 0xfd, 0xf8
00CB12  ; data: 0xfd, 0xd0
00CB14  ; data: 0xfd, 0x80
00CB16  dc.w   $fd30
00CB18  dc.w   $fcb8
00CB1A  dc.w   $fc40
00CB1C  ; data: 0xfb, 0xf0
00CB1E  dc.w   $fb78
00CB20  dc.w   $fb50
00CB22  dc.w   $fb28
00CB24  dc.w   $fb28
00CB26  dc.w   $fb50
00CB28  ; data: 0xfb, 0xa0
00CB2A  ; data: 0xfb, 0xf0
00CB2C  dc.w   $fc40
00CB2E  dc.w   $fc90
00CB30  dc.w   $fcb8
00CB32  ; data: 0xfd, 0x08
00CB34  ; data: 0xfd, 0x08
00CB36  dc.w   $fd30
00CB38  dc.w   $fd58
00CB3A  ; data: 0xfd, 0x80
00CB3C  ; data: 0xfd, 0xd0
00CB3E  dc.w   $fe48
00CB40  dc.w   $fec0
00CB42  dc.w   $ff38
00CB44  ; data: 0x1d, 0x88
00CB46  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CB54  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CB62  move.b $1db01d60(d1.l * 4), $fee8(a6, invalid.w)
00CB6E  dc.w   $fe98
00CB70  dc.w   $fe70
00CB72  dc.w   $fe20
00CB74  ; data: 0xfd, 0xf8
00CB76  ; data: 0xfd, 0xa8
00CB78  dc.w   $fd58
00CB7A  ; data: 0xfd, 0x08
00CB7C  dc.w   $fc90
00CB7E  dc.w   $fc40
00CB80  ; data: 0xfb, 0xc8
00CB82  dc.w   $fb78
00CB84  dc.w   $fb50
00CB86  dc.w   $fb28
00CB88  dc.w   $fb28
00CB8A  dc.w   $fb50
00CB8C  dc.w   $fb78
00CB8E  ; data: 0xfb, 0xc8
00CB90  dc.w   $fc18
00CB92  dc.w   $fc40
00CB94  dc.w   $fc90
00CB96  dc.w   $fcb8
00CB98  ; data: 0xfd, 0x08
00CB9A  dc.w   $fd30
00CB9C  dc.w   $fd58
00CB9E  ; data: 0xfd, 0xa8
00CBA0  ; data: 0xfd, 0xf8
00CBA2  dc.w   $fe48
00CBA4  dc.w   $fec0
00CBA6  ; data: 0xff, 0x60
00CBA8  ; data: 0x1d, 0x88
00CBAA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CBB8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CBC6  move.b $1db01d88(d1.l * 4), $ff10(a6, invalid.w)
00CBD2  dc.w   $fec0
00CBD4  dc.w   $fe70
00CBD6  dc.w   $fe20
00CBD8  ; data: 0xfd, 0xd0
00CBDA  ; data: 0xfd, 0x80
00CBDC  dc.w   $fd30
00CBDE  dc.w   $fce0
00CBE0  dc.w   $fc68
00CBE2  dc.w   $fc18
00CBE4  ; data: 0xfb, 0xc8
00CBE6  dc.w   $fb78
00CBE8  dc.w   $fb28
00CBEA  dc.w   $fb28
00CBEC  dc.w   $fb28
00CBEE  dc.w   $fb28
00CBF0  dc.w   $fb50
00CBF2  ; data: 0xfb, 0xa0
00CBF4  ; data: 0xfb, 0xc8
00CBF6  dc.w   $fc18
00CBF8  dc.w   $fc68
00CBFA  dc.w   $fc90
00CBFC  dc.w   $fce0
00CBFE  ; data: 0xfd, 0x08
00CC00  dc.w   $fd58
00CC02  ; data: 0xfd, 0xa8
00CC04  ; data: 0xfd, 0xf8
00CC06  dc.w   $fe70
00CC08  dc.w   $fee8
00CC0A  ; data: 0xff, 0x60
00CC0C  ; data: 0x1d, 0x88
00CC0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CC1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CC2A  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00CC34  dc.w   $ff38
00CC36  dc.w   $fec0
00CC38  dc.w   $fe70
00CC3A  dc.w   $fe20
00CC3C  ; data: 0xfd, 0xa8
00CC3E  dc.w   $fd58
00CC40  ; data: 0xfd, 0x08
00CC42  dc.w   $fcb8
00CC44  dc.w   $fc40
00CC46  ; data: 0xfb, 0xf0
00CC48  ; data: 0xfb, 0xa0
00CC4A  dc.w   $fb50
00CC4C  dc.w   $fb28
00CC4E  ; data: 0xfb, 0x00
00CC50  ; data: 0xfb, 0x00
00CC52  dc.w   $fb28
00CC54  dc.w   $fb28
00CC56  dc.w   $fb78
00CC58  ; data: 0xfb, 0xa0
00CC5A  ; data: 0xfb, 0xf0
00CC5C  dc.w   $fc18
00CC5E  dc.w   $fc68
00CC60  dc.w   $fcb8
00CC62  ; data: 0xfd, 0x08
00CC64  dc.w   $fd58
00CC66  ; data: 0xfd, 0xa8
00CC68  ; data: 0xfd, 0xf8
00CC6A  dc.w   $fe70
00CC6C  dc.w   $fee8
00CC6E  ; data: 0xff, 0x60
00CC70  ; data: 0x1d, 0x88
00CC72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CC80  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CC8E  move.b $1db01db0(d1.l * 4), $ff38fec0(a7.l * 8)
00CC9C  dc.w   $fe70
00CC9E  ; data: 0xfd, 0xf8
00CCA0  ; data: 0xfd, 0xa8
00CCA2  dc.w   $fd58
00CCA4  dc.w   $fce0
00CCA6  dc.w   $fc90
00CCA8  dc.w   $fc18
00CCAA  ; data: 0xfb, 0xc8
00CCAC  dc.w   $fb78
00CCAE  dc.w   $fb50
00CCB0  dc.w   $fb28
00CCB2  ; data: 0xfb, 0x00
00CCB4  ; data: 0xfb, 0x00
00CCB6  ; data: 0xfb, 0x00
00CCB8  dc.w   $fb28
00CCBA  dc.w   $fb50
00CCBC  dc.w   $fb78
00CCBE  ; data: 0xfb, 0xc8
00CCC0  ; data: 0xfb, 0xf0
00CCC2  dc.w   $fc40
00CCC4  dc.w   $fc90
00CCC6  dc.w   $fce0
00CCC8  dc.w   $fd30
00CCCA  ; data: 0xfd, 0xa8
00CCCC  dc.w   $fe20
00CCCE  dc.w   $fe70
00CCD0  dc.w   $fee8
00CCD2  ; data: 0xff, 0x88
00CCD4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CCE2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CCF0  move.b $1db01db0(d1.l * 4), $1d60ff60(d1.l * 4)
00CCFE  dc.w   $fee8
00CD00  dc.w   $fe70
00CD02  ; data: 0xfd, 0xf8
00CD04  ; data: 0xfd, 0x80
00CD06  dc.w   $fd30
00CD08  dc.w   $fcb8
00CD0A  dc.w   $fc68
00CD0C  dc.w   $fc18
00CD0E  ; data: 0xfb, 0xa0
00CD10  dc.w   $fb78
00CD12  dc.w   $fb28
00CD14  ; data: 0xfb, 0x00
00CD16  dc.w   $fad8
00CD18  dc.w   $fad8
00CD1A  dc.w   $fad8
00CD1C  ; data: 0xfb, 0x00
00CD1E  dc.w   $fb28
00CD20  dc.w   $fb50
00CD22  dc.w   $fb78
00CD24  ; data: 0xfb, 0xc8
00CD26  dc.w   $fc18
00CD28  dc.w   $fc68
00CD2A  dc.w   $fce0
00CD2C  dc.w   $fd30
00CD2E  ; data: 0xfd, 0xa8
00CD30  dc.w   $fe20
00CD32  dc.w   $fe98
00CD34  dc.w   $ff10
00CD36  ; data: 0xff, 0x88
00CD38  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CD46  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CD54  move.b $1db01db0(d1.l * 4), $1d88ff60(d1.l * 4)
00CD62  dc.w   $fee8
00CD64  dc.w   $fe70
00CD66  ; data: 0xfd, 0xf8
00CD68  ; data: 0xfd, 0x80
00CD6A  ; data: 0xfd, 0x08
00CD6C  dc.w   $fcb8
00CD6E  dc.w   $fc40
00CD70  ; data: 0xfb, 0xf0
00CD72  ; data: 0xfb, 0xa0
00CD74  dc.w   $fb50
00CD76  ; data: 0xfb, 0x00
00CD78  dc.w   $fad8
00CD7A  dc.w   $fad8
00CD7C  dc.w   $fab0
00CD7E  dc.w   $fab0
00CD80  dc.w   $fad8
00CD82  ; data: 0xfb, 0x00
00CD84  dc.w   $fb28
00CD86  dc.w   $fb50
00CD88  ; data: 0xfb, 0xa0
00CD8A  ; data: 0xfb, 0xf0
00CD8C  dc.w   $fc68
00CD8E  dc.w   $fcb8
00CD90  dc.w   $fd30
00CD92  ; data: 0xfd, 0xa8
00CD94  dc.w   $fe20
00CD96  dc.w   $fe98
00CD98  dc.w   $ff10
00CD9A  ; data: 0xff, 0x88
00CD9C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CDAA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CDB8  move.b $1db01db0(d1.l * 4), $1d88ff60(d1.l * 4)
00CDC6  dc.w   $fee8
00CDC8  dc.w   $fe70
00CDCA  ; data: 0xfd, 0xf8
00CDCC  ; data: 0xfd, 0x80
00CDCE  ; data: 0xfd, 0x08
00CDD0  dc.w   $fc90
00CDD2  dc.w   $fc18
00CDD4  ; data: 0xfb, 0xc8
00CDD6  dc.w   $fb78
00CDD8  dc.w   $fb28
00CDDA  ; data: 0xfb, 0x00
00CDDC  dc.w   $fad8
00CDDE  dc.w   $fab0
00CDE0  dc.w   $fa88
00CDE2  dc.w   $fab0
00CDE4  dc.w   $fab0
00CDE6  dc.w   $fad8
00CDE8  ; data: 0xfb, 0x00
00CDEA  dc.w   $fb50
00CDEC  dc.w   $fb78
00CDEE  ; data: 0xfb, 0xf0
00CDF0  dc.w   $fc40
00CDF2  dc.w   $fcb8
00CDF4  dc.w   $fd30
00CDF6  ; data: 0xfd, 0xa8
00CDF8  dc.w   $fe20
00CDFA  dc.w   $fe98
00CDFC  dc.w   $ff10
00CDFE  ; data: 0xff, 0x88
00CE00  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CE0E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CE1C  move.b $1db01db0(d1.l * 4), $1d88ff60(d1.l * 4)
00CE2A  dc.w   $fee8
00CE2C  dc.w   $fe70
00CE2E  ; data: 0xfd, 0xf8
00CE30  dc.w   $fd58
00CE32  dc.w   $fce0
00CE34  dc.w   $fc68
00CE36  dc.w   $fc18
00CE38  ; data: 0xfb, 0xa0
00CE3A  dc.w   $fb50
00CE3C  ; data: 0xfb, 0x00
00CE3E  dc.w   $fad8
00CE40  dc.w   $fab0
00CE42  dc.w   $fa88
00CE44  dc.w   $fa88
00CE46  dc.w   $fa88
00CE48  dc.w   $fa88
00CE4A  dc.w   $fab0
00CE4C  dc.w   $fad8
00CE4E  dc.w   $fb28
00CE50  dc.w   $fb78
00CE52  ; data: 0xfb, 0xc8
00CE54  dc.w   $fc18
00CE56  dc.w   $fc90
00CE58  ; data: 0xfd, 0x08
00CE5A  ; data: 0xfd, 0x80
00CE5C  ; data: 0xfd, 0xf8
00CE5E  dc.w   $fe98
00CE60  dc.w   $ff10
00CE62  ; data: 0xff, 0x88
00CE64  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CE72  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CE80  move.b $1db01db0(d1.l * 4), $1d88ff60(d1.l * 4)
00CE8E  dc.w   $fee8
00CE90  dc.w   $fe70
00CE92  ; data: 0xfd, 0xd0
00CE94  dc.w   $fd58
00CE96  dc.w   $fce0
00CE98  dc.w   $fc68
00CE9A  ; data: 0xfb, 0xf0
00CE9C  ; data: 0xfb, 0xa0
00CE9E  dc.w   $fb28
00CEA0  dc.w   $fad8
00CEA2  dc.w   $fab0
00CEA4  dc.w   $fa88
00CEA6  dc.w   $fa60
00CEA8  dc.w   $fa60
00CEAA  dc.w   $fa60
00CEAC  dc.w   $fa60
00CEAE  dc.w   $fa88
00CEB0  dc.w   $fab0
00CEB2  ; data: 0xfb, 0x00
00CEB4  dc.w   $fb50
00CEB6  ; data: 0xfb, 0xa0
00CEB8  dc.w   $fc18
00CEBA  dc.w   $fc90
00CEBC  ; data: 0xfd, 0x08
00CEBE  ; data: 0xfd, 0x80
00CEC0  ; data: 0xfd, 0xf8
00CEC2  dc.w   $fe70
00CEC4  dc.w   $ff10
00CEC6  ; data: 0xff, 0x88
00CEC8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CED6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CEE4  move.b $1db01db0(d1.l * 4), $1d88ff60(d1.l * 4)
00CEF2  dc.w   $fee8
00CEF4  dc.w   $fe48
00CEF6  ; data: 0xfd, 0xd0
00CEF8  dc.w   $fd58
00CEFA  dc.w   $fce0
00CEFC  dc.w   $fc68
00CEFE  ; data: 0xfb, 0xf0
00CF00  dc.w   $fb78
00CF02  dc.w   $fb28
00CF04  dc.w   $fad8
00CF06  dc.w   $fa88
00CF08  dc.w   $fa60
00CF0A  dc.w   $fa38
00CF0C  dc.w   $fa10
00CF0E  dc.w   $fa38
00CF10  dc.w   $fa38
00CF12  dc.w   $fa60
00CF14  dc.w   $fab0
00CF16  dc.w   $fad8
00CF18  dc.w   $fb50
00CF1A  ; data: 0xfb, 0xa0
00CF1C  ; data: 0xfb, 0xf0
00CF1E  dc.w   $fc68
00CF20  dc.w   $fce0
00CF22  dc.w   $fd58
00CF24  ; data: 0xfd, 0xf8
00CF26  dc.w   $fe70
00CF28  dc.w   $ff10
00CF2A  ; data: 0xff, 0x88
00CF2C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CF3A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CF48  move.b $1db01db0(d1.l * 4), $1d88ff60(d1.l * 4)
00CF56  dc.w   $fee8
00CF58  dc.w   $fe48
00CF5A  ; data: 0xfd, 0xd0
00CF5C  dc.w   $fd58
00CF5E  dc.w   $fce0
00CF60  dc.w   $fc68
00CF62  ; data: 0xfb, 0xf0
00CF64  dc.w   $fb78
00CF66  ; data: 0xfb, 0x00
00CF68  dc.w   $fab0
00CF6A  dc.w   $fa60
00CF6C  dc.w   $fa10
00CF6E  dc.w   $fa10
00CF70  ; data: 0xf9, 0xe8
00CF72  dc.w   $fa10
00CF74  dc.w   $fa10
00CF76  dc.w   $fa60
00CF78  dc.w   $fa88
00CF7A  dc.w   $fad8
00CF7C  dc.w   $fb28
00CF7E  dc.w   $fb78
00CF80  ; data: 0xfb, 0xf0
00CF82  dc.w   $fc68
00CF84  dc.w   $fce0
00CF86  dc.w   $fd58
00CF88  ; data: 0xfd, 0xd0
00CF8A  dc.w   $fe70
00CF8C  dc.w   $fee8
00CF8E  ; data: 0xff, 0x88
00CF90  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CF9E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00CFAC  move.b $1db01db0(d1.l * 4), $1d88ff60(d1.l * 4)
00CFBA  dc.w   $fec0
00CFBC  dc.w   $fe48
00CFBE  ; data: 0xfd, 0xd0
00CFC0  dc.w   $fd58
00CFC2  dc.w   $fce0
00CFC4  dc.w   $fc40
00CFC6  ; data: 0xfb, 0xc8
00CFC8  dc.w   $fb50
00CFCA  dc.w   $fad8
00CFCC  dc.w   $fa88
00CFCE  dc.w   $fa38
00CFD0  ; data: 0xf9, 0xe8
00CFD2  ; data: 0xf9, 0xc0
00CFD4  ; data: 0xf9, 0xc0
00CFD6  ; data: 0xf9, 0xc0
00CFD8  ; data: 0xf9, 0xe8
00CFDA  dc.w   $fa38
00CFDC  dc.w   $fa88
00CFDE  dc.w   $fad8
00CFE0  dc.w   $fb28
00CFE2  dc.w   $fb78
00CFE4  ; data: 0xfb, 0xf0
00CFE6  dc.w   $fc40
00CFE8  dc.w   $fcb8
00CFEA  dc.w   $fd30
00CFEC  ; data: 0xfd, 0xd0
00CFEE  dc.w   $fe48
00CFF0  dc.w   $fee8
00CFF2  ; data: 0xff, 0x88
00CFF4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D002  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D010  move.b $1db01db0(d1.l * 4), $1d88ff38(d1.l * 4)
00D01E  dc.w   $fec0
00D020  dc.w   $fe48
00D022  ; data: 0xfd, 0xd0
00D024  dc.w   $fd58
00D026  dc.w   $fce0
00D028  dc.w   $fc68
00D02A  ; data: 0xfb, 0xc8
00D02C  dc.w   $fb50
00D02E  dc.w   $fad8
00D030  dc.w   $fa60
00D032  dc.w   $fa10
00D034  ; data: 0xf9, 0xc0
00D036  ; data: 0xf9, 0x98
00D038  ; data: 0xf9, 0x98
00D03A  ; data: 0xf9, 0x98
00D03C  ; data: 0xf9, 0xc0
00D03E  dc.w   $fa10
00D040  dc.w   $fa60
00D042  dc.w   $fab0
00D044  dc.w   $fb28
00D046  dc.w   $fb78
00D048  ; data: 0xfb, 0xc8
00D04A  dc.w   $fc40
00D04C  dc.w   $fcb8
00D04E  dc.w   $fd30
00D050  ; data: 0xfd, 0xa8
00D052  dc.w   $fe48
00D054  dc.w   $fee8
00D056  ; data: 0xff, 0x88
00D058  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D066  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D074  move.b $1db01db0(d1.l * 4), $1d60ff38(d1.l * 4)
00D082  dc.w   $fec0
00D084  dc.w   $fe48
00D086  ; data: 0xfd, 0xd0
00D088  dc.w   $fd58
00D08A  dc.w   $fce0
00D08C  dc.w   $fc68
00D08E  ; data: 0xfb, 0xc8
00D090  dc.w   $fb50
00D092  dc.w   $fab0
00D094  dc.w   $fa38
00D096  ; data: 0xf9, 0xe8
00D098  ; data: 0xf9, 0x98
00D09A  dc.w   $f970
00D09C  ; data: 0xf9, 0x48
00D09E  dc.w   $f970
00D0A0  ; data: 0xf9, 0xc0
00D0A2  dc.w   $fa10
00D0A4  dc.w   $fa60
00D0A6  dc.w   $fab0
00D0A8  dc.w   $fb28
00D0AA  dc.w   $fb78
00D0AC  ; data: 0xfb, 0xc8
00D0AE  dc.w   $fc18
00D0B0  dc.w   $fc90
00D0B2  ; data: 0xfd, 0x08
00D0B4  ; data: 0xfd, 0x80
00D0B6  dc.w   $fe20
00D0B8  dc.w   $fec0
00D0BA  ; data: 0xff, 0x88
00D0BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D0CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D0D8  move.b $1db01db0(d1.l * 4), $1d60ff10(d1.l * 4)
00D0E6  dc.w   $fe98
00D0E8  dc.w   $fe20
00D0EA  ; data: 0xfd, 0xd0
00D0EC  dc.w   $fd58
00D0EE  dc.w   $fce0
00D0F0  dc.w   $fc68
00D0F2  ; data: 0xfb, 0xf0
00D0F4  dc.w   $fb50
00D0F6  dc.w   $fab0
00D0F8  dc.w   $fa10
00D0FA  ; data: 0xf9, 0x98
00D0FC  ; data: 0xf9, 0x48
00D0FE  dc.w   $f920
00D100  dc.w   $f920
00D102  ; data: 0xf9, 0x48
00D104  ; data: 0xf9, 0x98
00D106  ; data: 0xf9, 0xe8
00D108  dc.w   $fa60
00D10A  dc.w   $fab0
00D10C  dc.w   $fb28
00D10E  dc.w   $fb78
00D110  ; data: 0xfb, 0xc8
00D112  dc.w   $fc18
00D114  dc.w   $fc68
00D116  dc.w   $fce0
00D118  ; data: 0xfd, 0x80
00D11A  dc.w   $fe20
00D11C  dc.w   $fec0
00D11E  ; data: 0xff, 0x88
00D120  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D12E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D13C  move.b $1db01db0(d1.l * 4), $ffb0ff10(d1.l * 4)
00D14A  dc.w   $fe98
00D14C  dc.w   $fe20
00D14E  ; data: 0xfd, 0xd0
00D150  dc.w   $fd58
00D152  ; data: 0xfd, 0x08
00D154  dc.w   $fc68
00D156  ; data: 0xfb, 0xf0
00D158  dc.w   $fb50
00D15A  dc.w   $fab0
00D15C  dc.w   $fa10
00D15E  dc.w   $f970
00D160  dc.w   $f920
00D162  dc.w   $f8f8
00D164  dc.w   $f8f8
00D166  dc.w   $f920
00D168  dc.w   $f970
00D16A  ; data: 0xf9, 0xe8
00D16C  dc.w   $fa60
00D16E  dc.w   $fab0
00D170  dc.w   $fb28
00D172  dc.w   $fb78
00D174  ; data: 0xfb, 0xc8
00D176  dc.w   $fc18
00D178  dc.w   $fc68
00D17A  dc.w   $fcb8
00D17C  dc.w   $fd58
00D17E  ; data: 0xfd, 0xf8
00D180  dc.w   $fec0
00D182  ; data: 0xff, 0x88
00D184  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D192  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D1A0  move.b $1db01db0(d1.l * 4), $ff88fee8(d1.l * 4)
00D1AE  dc.w   $fe70
00D1B0  dc.w   $fe20
00D1B2  ; data: 0xfd, 0xd0
00D1B4  dc.w   $fd58
00D1B6  ; data: 0xfd, 0x08
00D1B8  dc.w   $fc90
00D1BA  ; data: 0xfb, 0xf0
00D1BC  dc.w   $fb50
00D1BE  dc.w   $fa88
00D1C0  ; data: 0xf9, 0xe8
00D1C2  ; data: 0xf9, 0x48
00D1C4  dc.w   $f8d0
00D1C6  dc.w   $f8a8
00D1C8  dc.w   $f8a8
00D1CA  dc.w   $f8f8
00D1CC  ; data: 0xf9, 0x48
00D1CE  ; data: 0xf9, 0xc0
00D1D0  dc.w   $fa38
00D1D2  dc.w   $fab0
00D1D4  dc.w   $fb28
00D1D6  dc.w   $fb78
00D1D8  ; data: 0xfb, 0xc8
00D1DA  ; data: 0xfb, 0xf0
00D1DC  dc.w   $fc40
00D1DE  dc.w   $fcb8
00D1E0  dc.w   $fd30
00D1E2  ; data: 0xfd, 0xd0
00D1E4  dc.w   $fe98
00D1E6  ; data: 0xff, 0x88
00D1E8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D1F6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D204  move.b $1db01db0(d1.l * 4), $ff88fee8(d1.l * 4)
00D212  dc.w   $fe70
00D214  ; data: 0xfd, 0xf8
00D216  ; data: 0xfd, 0xd0
00D218  ; data: 0xfd, 0x80
00D21A  ; data: 0xfd, 0x08
00D21C  dc.w   $fc90
00D21E  ; data: 0xfb, 0xf0
00D220  dc.w   $fb50
00D222  dc.w   $fa88
00D224  ; data: 0xf9, 0xc0
00D226  dc.w   $f920
00D228  dc.w   $f8a8
00D22A  dc.w   $f880
00D22C  dc.w   $f880
00D22E  dc.w   $f8a8
00D230  dc.w   $f920
00D232  ; data: 0xf9, 0xc0
00D234  dc.w   $fa38
00D236  dc.w   $fad8
00D238  dc.w   $fb28
00D23A  dc.w   $fb78
00D23C  ; data: 0xfb, 0xc8
00D23E  ; data: 0xfb, 0xf0
00D240  dc.w   $fc18
00D242  dc.w   $fc90
00D244  ; data: 0xfd, 0x08
00D246  ; data: 0xfd, 0xa8
00D248  dc.w   $fe98
00D24A  ; data: 0xff, 0x88
00D24C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D25A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D268  move.b $1db01db0(d1.l * 4), $ff60fec0(d1.l * 4)
00D276  dc.w   $fe48
00D278  ; data: 0xfd, 0xf8
00D27A  ; data: 0xfd, 0xd0
00D27C  ; data: 0xfd, 0x80
00D27E  dc.w   $fd30
00D280  dc.w   $fcb8
00D282  dc.w   $fc18
00D284  dc.w   $fb50
00D286  dc.w   $fa60
00D288  ; data: 0xf9, 0x98
00D28A  dc.w   $f8f8
00D28C  dc.w   $f858
00D28E  dc.w   $f830
00D290  dc.w   $f830
00D292  dc.w   $f880
00D294  dc.w   $f8f8
00D296  ; data: 0xf9, 0x98
00D298  dc.w   $fa38
00D29A  dc.w   $fad8
00D29C  dc.w   $fb50
00D29E  dc.w   $fb78
00D2A0  ; data: 0xfb, 0xc8
00D2A2  ; data: 0xfb, 0xf0
00D2A4  dc.w   $fc18
00D2A6  dc.w   $fc68
00D2A8  dc.w   $fce0
00D2AA  ; data: 0xfd, 0x80
00D2AC  dc.w   $fe70
00D2AE  ; data: 0xff, 0x88
00D2B0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D2BE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D2CC  move.b $1db01db0(d1.l * 4), $ff38fe98(d1.l * 4)
00D2DA  dc.w   $fe48
00D2DC  ; data: 0xfd, 0xf8
00D2DE  ; data: 0xfd, 0xd0
00D2E0  ; data: 0xfd, 0x80
00D2E2  dc.w   $fd30
00D2E4  dc.w   $fcb8
00D2E6  dc.w   $fc18
00D2E8  dc.w   $fb50
00D2EA  dc.w   $fa60
00D2EC  dc.w   $f970
00D2EE  dc.w   $f8a8
00D2F0  dc.w   $f830
00D2F2  ; data: 0xf7, 0xe0
00D2F4  dc.w   $f808
00D2F6  dc.w   $f858
00D2F8  dc.w   $f8f8
00D2FA  ; data: 0xf9, 0x98
00D2FC  dc.w   $fa38
00D2FE  dc.w   $fad8
00D300  dc.w   $fb50
00D302  ; data: 0xfb, 0xa0
00D304  ; data: 0xfb, 0xc8
00D306  ; data: 0xfb, 0xc8
00D308  ; data: 0xfb, 0xf0
00D30A  dc.w   $fc40
00D30C  dc.w   $fcb8
00D30E  ; data: 0xfd, 0x80
00D310  dc.w   $fe70
00D312  ; data: 0xff, 0x88
00D314  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D322  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D330  move.b $1db01db0(d1.l * 4), $ff38fe98(d1.l * 4)
00D33E  dc.w   $fe20
00D340  ; data: 0xfd, 0xf8
00D342  ; data: 0xfd, 0xd0
00D344  ; data: 0xfd, 0xa8
00D346  dc.w   $fd58
00D348  dc.w   $fce0
00D34A  dc.w   $fc18
00D34C  dc.w   $fb50
00D34E  dc.w   $fa60
00D350  ; data: 0xf9, 0x48
00D352  dc.w   $f880
00D354  ; data: 0xf7, 0xe0
00D356  ; data: 0xf7, 0xb8
00D358  ; data: 0xf7, 0xb8
00D35A  dc.w   $f830
00D35C  dc.w   $f8d0
00D35E  dc.w   $f970
00D360  dc.w   $fa38
00D362  dc.w   $fad8
00D364  dc.w   $fb50
00D366  ; data: 0xfb, 0xa0
00D368  ; data: 0xfb, 0xc8
00D36A  ; data: 0xfb, 0xc8
00D36C  ; data: 0xfb, 0xc8
00D36E  dc.w   $fc18
00D370  dc.w   $fc90
00D372  dc.w   $fd58
00D374  dc.w   $fe48
00D376  ; data: 0xff, 0x60
00D378  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D386  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D394  move.b $1db01db0(d1.l * 4), $ff10fe70(d1.l * 4)
00D3A2  ; data: 0xfd, 0xf8
00D3A4  ; data: 0xfd, 0xd0
00D3A6  ; data: 0xfd, 0xd0
00D3A8  ; data: 0xfd, 0xa8
00D3AA  dc.w   $fd58
00D3AC  dc.w   $fce0
00D3AE  dc.w   $fc40
00D3B0  dc.w   $fb50
00D3B2  dc.w   $fa38
00D3B4  ; data: 0xf9, 0x48
00D3B6  dc.w   $f858
00D3B8  ; data: 0xf7, 0xb8
00D3BA  dc.w   $f768
00D3BC  ; data: 0xf7, 0x90
00D3BE  ; data: 0xf7, 0xe0
00D3C0  dc.w   $f8a8
00D3C2  dc.w   $f970
00D3C4  dc.w   $fa38
00D3C6  ; data: 0xfb, 0x00
00D3C8  dc.w   $fb78
00D3CA  ; data: 0xfb, 0xa0
00D3CC  ; data: 0xfb, 0xc8
00D3CE  ; data: 0xfb, 0xc8
00D3D0  ; data: 0xfb, 0xc8
00D3D2  ; data: 0xfb, 0xf0
00D3D4  dc.w   $fc68
00D3D6  dc.w   $fd30
00D3D8  dc.w   $fe20
00D3DA  ; data: 0xff, 0x60
00D3DC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D3EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D3F8  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00D402  dc.w   $fee8
00D404  dc.w   $fe48
00D406  ; data: 0xfd, 0xf8
00D408  ; data: 0xfd, 0xd0
00D40A  ; data: 0xfd, 0xd0
00D40C  ; data: 0xfd, 0xa8
00D40E  ; data: 0xfd, 0x80
00D410  ; data: 0xfd, 0x08
00D412  dc.w   $fc40
00D414  dc.w   $fb50
00D416  dc.w   $fa38
00D418  dc.w   $f920
00D41A  dc.w   $f808
00D41C  dc.w   $f768
00D41E  ; data: 0xf7, 0x18
00D420  ; data: 0xf7, 0x40
00D422  ; data: 0xf7, 0xb8
00D424  dc.w   $f880
00D426  dc.w   $f970
00D428  dc.w   $fa38
00D42A  ; data: 0xfb, 0x00
00D42C  dc.w   $fb78
00D42E  ; data: 0xfb, 0xa0
00D430  ; data: 0xfb, 0xc8
00D432  ; data: 0xfb, 0xa0
00D434  ; data: 0xfb, 0xa0
00D436  ; data: 0xfb, 0xc8
00D438  dc.w   $fc40
00D43A  ; data: 0xfd, 0x08
00D43C  dc.w   $fe20
00D43E  ; data: 0xff, 0x60
00D440  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D44E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D45C  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00D466  dc.w   $fee8
00D468  dc.w   $fe20
00D46A  ; data: 0xfd, 0xd0
00D46C  ; data: 0xfd, 0xd0
00D46E  ; data: 0xfd, 0xd0
00D470  ; data: 0xfd, 0xd0
00D472  ; data: 0xfd, 0x80
00D474  dc.w   $fd30
00D476  dc.w   $fc68
00D478  dc.w   $fb50
00D47A  dc.w   $fa10
00D47C  dc.w   $f8f8
00D47E  ; data: 0xf7, 0xe0
00D480  ; data: 0xf7, 0x40
00D482  dc.w   $f6f0
00D484  dc.w   $f6f0
00D486  ; data: 0xf7, 0x90
00D488  dc.w   $f858
00D48A  ; data: 0xf9, 0x48
00D48C  dc.w   $fa38
00D48E  ; data: 0xfb, 0x00
00D490  dc.w   $fb78
00D492  ; data: 0xfb, 0xc8
00D494  ; data: 0xfb, 0xc8
00D496  ; data: 0xfb, 0xa0
00D498  dc.w   $fb78
00D49A  ; data: 0xfb, 0xa0
00D49C  dc.w   $fc18
00D49E  dc.w   $fce0
00D4A0  ; data: 0xfd, 0xf8
00D4A2  ; data: 0xff, 0x60
00D4A4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D4B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D4C0  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00D4CA  dc.w   $fec0
00D4CC  dc.w   $fe20
00D4CE  ; data: 0xfd, 0xd0
00D4D0  ; data: 0xfd, 0xa8
00D4D2  ; data: 0xfd, 0xd0
00D4D4  ; data: 0xfd, 0xd0
00D4D6  ; data: 0xfd, 0xa8
00D4D8  dc.w   $fd30
00D4DA  dc.w   $fc68
00D4DC  dc.w   $fb50
00D4DE  dc.w   $fa10
00D4E0  dc.w   $f8d0
00D4E2  ; data: 0xf7, 0xb8
00D4E4  dc.w   $f6f0
00D4E6  dc.w   $f6a0
00D4E8  dc.w   $f6c8
00D4EA  dc.w   $f768
00D4EC  dc.w   $f830
00D4EE  ; data: 0xf9, 0x48
00D4F0  dc.w   $fa38
00D4F2  ; data: 0xfb, 0x00
00D4F4  ; data: 0xfb, 0xa0
00D4F6  ; data: 0xfb, 0xc8
00D4F8  ; data: 0xfb, 0xc8
00D4FA  ; data: 0xfb, 0xa0
00D4FC  dc.w   $fb78
00D4FE  dc.w   $fb78
00D500  ; data: 0xfb, 0xf0
00D502  dc.w   $fcb8
00D504  ; data: 0xfd, 0xf8
00D506  ; data: 0xff, 0x60
00D508  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D516  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D524  move.b $1db01db0(d1.l * 4), $fec0(a6, invalid.w)
00D530  ; data: 0xfd, 0xf8
00D532  ; data: 0xfd, 0xa8
00D534  ; data: 0xfd, 0xa8
00D536  ; data: 0xfd, 0xd0
00D538  ; data: 0xfd, 0xd0
00D53A  ; data: 0xfd, 0xa8
00D53C  dc.w   $fd30
00D53E  dc.w   $fc68
00D540  dc.w   $fb50
00D542  dc.w   $fa10
00D544  dc.w   $f8a8
00D546  ; data: 0xf7, 0x90
00D548  dc.w   $f6c8
00D54A  dc.w   $f678
00D54C  dc.w   $f6a0
00D54E  ; data: 0xf7, 0x40
00D550  dc.w   $f830
00D552  ; data: 0xf9, 0x48
00D554  dc.w   $fa38
00D556  ; data: 0xfb, 0x00
00D558  ; data: 0xfb, 0xa0
00D55A  ; data: 0xfb, 0xc8
00D55C  ; data: 0xfb, 0xc8
00D55E  dc.w   $fb78
00D560  dc.w   $fb50
00D562  dc.w   $fb78
00D564  ; data: 0xfb, 0xc8
00D566  dc.w   $fc90
00D568  ; data: 0xfd, 0xd0
00D56A  ; data: 0xff, 0x60
00D56C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D57A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D588  move.b $1db01db0(d1.l * 4), $fe98(a6, invalid.w)
00D594  ; data: 0xfd, 0xf8
00D596  ; data: 0xfd, 0xa8
00D598  ; data: 0xfd, 0xa8
00D59A  ; data: 0xfd, 0xd0
00D59C  ; data: 0xfd, 0xd0
00D59E  ; data: 0xfd, 0xd0
00D5A0  dc.w   $fd58
00D5A2  dc.w   $fc90
00D5A4  dc.w   $fb50
00D5A6  ; data: 0xf9, 0xe8
00D5A8  dc.w   $f880
00D5AA  dc.w   $f768
00D5AC  dc.w   $f678
00D5AE  dc.w   $f628
00D5B0  dc.w   $f650
00D5B2  dc.w   $f6f0
00D5B4  dc.w   $f808
00D5B6  dc.w   $f920
00D5B8  dc.w   $fa38
00D5BA  dc.w   $fb28
00D5BC  ; data: 0xfb, 0xa0
00D5BE  ; data: 0xfb, 0xc8
00D5C0  ; data: 0xfb, 0xa0
00D5C2  dc.w   $fb78
00D5C4  dc.w   $fb50
00D5C6  dc.w   $fb50
00D5C8  ; data: 0xfb, 0xa0
00D5CA  dc.w   $fc90
00D5CC  ; data: 0xfd, 0xd0
00D5CE  ; data: 0xff, 0x60
00D5D0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D5DE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D5EC  move.b $1db01db0(d1.l * 4), $fe98fdd0(a7.l * 8)
00D5FA  ; data: 0xfd, 0x80
00D5FC  ; data: 0xfd, 0x80
00D5FE  ; data: 0xfd, 0xd0
00D600  ; data: 0xfd, 0xd0
00D602  ; data: 0xfd, 0xd0
00D604  dc.w   $fd58
00D606  dc.w   $fc90
00D608  dc.w   $fb50
00D60A  ; data: 0xf9, 0xe8
00D60C  dc.w   $f880
00D60E  ; data: 0xf7, 0x40
00D610  dc.w   $f650
00D612  dc.w   $f600
00D618  ; data: 0xf7, 0xe0
00D61A  dc.w   $f920
00D61C  dc.w   $fa38
00D61E  dc.w   $fb28
00D620  ; data: 0xfb, 0xa0
00D622  ; data: 0xfb, 0xc8
00D624  ; data: 0xfb, 0xa0
00D626  dc.w   $fb78
00D628  dc.w   $fb28
00D62A  dc.w   $fb28
00D62C  ; data: 0xfb, 0xa0
00D62E  dc.w   $fc68
00D630  ; data: 0xfd, 0xa8
00D632  ; data: 0xff, 0x60
00D634  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D642  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D650  move.b $1db01db0(d1.l * 4), $fe70fdd0(a7.l * 8)
00D65E  ; data: 0xfd, 0x80
00D660  ; data: 0xfd, 0x80
00D662  ; data: 0xfd, 0xa8
00D664  ; data: 0xfd, 0xf8
00D666  ; data: 0xfd, 0xd0
00D668  dc.w   $fd58
00D66A  dc.w   $fc90
00D66C  dc.w   $fb50
00D66E  ; data: 0xf9, 0xe8
00D670  dc.w   $f858
00D672  ; data: 0xf7, 0x18
00D674  dc.w   $f628
00D676  ; data: 0xf5, 0xb0
00D678  dc.w   $f600
00D67E  dc.w   $f8f8
00D680  dc.w   $fa38
00D682  dc.w   $fb28
00D684  ; data: 0xfb, 0xa0
00D686  ; data: 0xfb, 0xc8
00D688  ; data: 0xfb, 0xa0
00D68A  dc.w   $fb50
00D68C  dc.w   $fb28
00D68E  ; data: 0xfb, 0x00
00D690  dc.w   $fb78
00D692  dc.w   $fc40
00D694  ; data: 0xfd, 0xa8
00D696  ; data: 0xff, 0x60
00D698  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D6A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D6B4  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00D6BE  dc.w   $fe70
00D6C0  ; data: 0xfd, 0xa8
00D6C2  dc.w   $fd58
00D6C4  ; data: 0xfd, 0x80
00D6C6  ; data: 0xfd, 0xa8
00D6C8  ; data: 0xfd, 0xf8
00D6CA  ; data: 0xfd, 0xd0
00D6CC  ; data: 0xfd, 0x80
00D6CE  dc.w   $fc90
00D6D0  dc.w   $fb50
00D6D2  ; data: 0xf9, 0xc0
00D6D4  dc.w   $f830
00D6D6  dc.w   $f6f0
00D6D8  dc.w   $f600
00D6DE  dc.w   $f678
00D6E0  ; data: 0xf7, 0xb8
00D6E2  dc.w   $f8f8
00D6E4  dc.w   $fa38
00D6E6  dc.w   $fb28
00D6E8  ; data: 0xfb, 0xa0
00D6EA  ; data: 0xfb, 0xc8
00D6EC  ; data: 0xfb, 0xa0
00D6EE  dc.w   $fb50
00D6F0  ; data: 0xfb, 0x00
00D6F2  ; data: 0xfb, 0x00
00D6F4  dc.w   $fb50
00D6F6  dc.w   $fc40
00D6F8  ; data: 0xfd, 0xa8
00D6FA  ; data: 0xff, 0x60
00D6FC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D70A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D718  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00D722  dc.w   $fe70
00D724  ; data: 0xfd, 0xa8
00D726  dc.w   $fd58
00D728  ; data: 0xfd, 0x80
00D72A  ; data: 0xfd, 0xa8
00D72C  ; data: 0xfd, 0xf8
00D72E  ; data: 0xfd, 0xd0
00D730  ; data: 0xfd, 0x80
00D732  dc.w   $fc90
00D734  dc.w   $fb50
00D736  ; data: 0xf9, 0xc0
00D738  dc.w   $f830
00D73A  dc.w   $f6c8
00D73C  ; data: 0xf5, 0xd8
00D73E  ; data: 0xf5, 0x60
00D740  ; data: 0xf5, 0xb0
00D742  dc.w   $f678
00D744  ; data: 0xf7, 0x90
00D746  dc.w   $f8d0
00D748  dc.w   $fa10
00D74A  dc.w   $fb28
00D74C  ; data: 0xfb, 0xa0
00D74E  ; data: 0xfb, 0xc8
00D750  ; data: 0xfb, 0xa0
00D752  dc.w   $fb50
00D754  ; data: 0xfb, 0x00
00D756  dc.w   $fad8
00D758  dc.w   $fb50
00D75A  dc.w   $fc40
00D75C  ; data: 0xfd, 0x80
00D75E  ; data: 0xff, 0x60
00D760  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D76E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D77C  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00D786  dc.w   $fe48
00D788  ; data: 0xfd, 0xa8
00D78A  dc.w   $fd58
00D78C  ; data: 0xfd, 0x80
00D78E  ; data: 0xfd, 0xa8
00D790  ; data: 0xfd, 0xf8
00D792  ; data: 0xfd, 0xd0
00D794  ; data: 0xfd, 0x80
00D796  dc.w   $fc90
00D798  dc.w   $fb28
00D79A  ; data: 0xf9, 0x98
00D79C  dc.w   $f808
00D79E  dc.w   $f6a0
00D7A0  ; data: 0xf5, 0xb0
00D7A2  dc.w   $f538
00D7A4  ; data: 0xf5, 0x88
00D7A6  dc.w   $f650
00D7A8  dc.w   $f768
00D7AA  dc.w   $f8d0
00D7AC  dc.w   $fa10
00D7AE  ; data: 0xfb, 0x00
00D7B0  ; data: 0xfb, 0xa0
00D7B2  ; data: 0xfb, 0xc8
00D7B4  ; data: 0xfb, 0xa0
00D7B6  dc.w   $fb28
00D7B8  dc.w   $fad8
00D7BA  dc.w   $fad8
00D7BC  dc.w   $fb28
00D7BE  dc.w   $fc18
00D7C0  ; data: 0xfd, 0x80
00D7C2  ; data: 0xff, 0x60
00D7C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D7D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D7E0  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00D7EA  dc.w   $fe48
00D7EC  ; data: 0xfd, 0xa8
00D7EE  dc.w   $fd58
00D7F0  dc.w   $fd58
00D7F2  ; data: 0xfd, 0xa8
00D7F4  ; data: 0xfd, 0xf8
00D7F6  ; data: 0xfd, 0xd0
00D7F8  ; data: 0xfd, 0x80
00D7FA  dc.w   $fc90
00D7FC  dc.w   $fb28
00D7FE  ; data: 0xf9, 0x98
00D800  ; data: 0xf7, 0xe0
00D802  dc.w   $f678
00D804  ; data: 0xf5, 0x88
00D806  dc.w   $f510
00D808  ; data: 0xf5, 0x60
00D80A  dc.w   $f628
00D80C  dc.w   $f768
00D80E  dc.w   $f8a8
00D810  dc.w   $fa10
00D812  ; data: 0xfb, 0x00
00D814  ; data: 0xfb, 0xa0
00D816  ; data: 0xfb, 0xc8
00D818  dc.w   $fb78
00D81A  dc.w   $fb28
00D81C  dc.w   $fad8
00D81E  dc.w   $fad8
00D820  dc.w   $fb28
00D822  dc.w   $fc18
00D824  ; data: 0xfd, 0x80
00D826  ; data: 0xff, 0x60
00D828  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D836  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D844  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00D84E  dc.w   $fe48
00D850  ; data: 0xfd, 0xa8
00D852  dc.w   $fd58
00D854  dc.w   $fd58
00D856  ; data: 0xfd, 0xa8
00D858  ; data: 0xfd, 0xf8
00D85A  ; data: 0xfd, 0xd0
00D85C  dc.w   $fd58
00D85E  dc.w   $fc68
00D860  dc.w   $fb28
00D862  dc.w   $f970
00D864  ; data: 0xf7, 0xe0
00D866  dc.w   $f678
00D868  ; data: 0xf5, 0x60
00D86A  dc.w   $f510
00D86C  dc.w   $f538
00D86E  dc.w   $f600
00D874  ; data: 0xf9, 0xe8
00D876  ; data: 0xfb, 0x00
00D878  dc.w   $fb78
00D87A  ; data: 0xfb, 0xa0
00D87C  dc.w   $fb78
00D87E  dc.w   $fb28
00D880  dc.w   $fad8
00D882  dc.w   $fab0
00D884  dc.w   $fb28
00D886  dc.w   $fc18
00D888  ; data: 0xfd, 0x80
00D88A  ; data: 0xff, 0x60
00D88C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D89A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D8A8  move.b $1db01db0(d1.l * 4), $fe70fda8(a7.l * 8)
00D8B6  dc.w   $fd58
00D8B8  dc.w   $fd58
00D8BA  ; data: 0xfd, 0xa8
00D8BC  ; data: 0xfd, 0xd0
00D8BE  ; data: 0xfd, 0xd0
00D8C0  dc.w   $fd58
00D8C2  dc.w   $fc68
00D8C4  ; data: 0xfb, 0x00
00D8C6  dc.w   $f970
00D8C8  ; data: 0xf7, 0xb8
00D8CA  dc.w   $f650
00D8CC  ; data: 0xf5, 0x60
00D8CE  dc.w   $f4e8
00D8D0  dc.w   $f538
00D8D2  dc.w   $f600
00D8D8  ; data: 0xf9, 0xe8
00D8DA  dc.w   $fad8
00D8DC  dc.w   $fb78
00D8DE  ; data: 0xfb, 0xa0
00D8E0  dc.w   $fb78
00D8E2  dc.w   $fb28
00D8E4  dc.w   $fab0
00D8E6  dc.w   $fab0
00D8E8  dc.w   $fb28
00D8EA  dc.w   $fc18
00D8EC  ; data: 0xfd, 0x80
00D8EE  ; data: 0xff, 0x60
00D8F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D8FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D90C  move.b $1db01db0(d1.l * 4), $fe70fda8(a7.l * 8)
00D91A  dc.w   $fd58
00D91C  dc.w   $fd58
00D91E  ; data: 0xfd, 0xa8
00D920  ; data: 0xfd, 0xd0
00D922  ; data: 0xfd, 0xd0
00D924  dc.w   $fd58
00D926  dc.w   $fc68
00D928  ; data: 0xfb, 0x00
00D92A  dc.w   $f970
00D92C  ; data: 0xf7, 0xb8
00D92E  dc.w   $f650
00D930  dc.w   $f538
00D932  dc.w   $f4e8
00D934  dc.w   $f510
00D936  ; data: 0xf5, 0xd8
00D938  ; data: 0xf7, 0x18
00D93A  dc.w   $f880
00D93C  ; data: 0xf9, 0xc0
00D93E  dc.w   $fad8
00D940  dc.w   $fb78
00D942  ; data: 0xfb, 0xa0
00D944  dc.w   $fb50
00D946  ; data: 0xfb, 0x00
00D948  dc.w   $fab0
00D94A  dc.w   $fab0
00D94C  dc.w   $fb28
00D94E  dc.w   $fc18
00D950  ; data: 0xfd, 0x80
00D952  ; data: 0xff, 0x60
00D954  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D962  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D970  move.b $1db01db0(d1.l * 4), $fe70(a6, invalid.w)
00D97C  ; data: 0xfd, 0xa8
00D97E  dc.w   $fd58
00D980  dc.w   $fd58
00D982  ; data: 0xfd, 0xa8
00D984  ; data: 0xfd, 0xd0
00D986  ; data: 0xfd, 0xa8
00D988  dc.w   $fd30
00D98A  dc.w   $fc40
00D98C  dc.w   $fad8
00D98E  ; data: 0xf9, 0x48
00D990  ; data: 0xf7, 0x90
00D992  dc.w   $f628
00D994  dc.w   $f538
00D996  dc.w   $f4c0
00D998  dc.w   $f510
00D99A  ; data: 0xf5, 0xd8
00D99C  dc.w   $f6f0
00D99E  dc.w   $f858
00D9A0  ; data: 0xf9, 0x98
00D9A2  dc.w   $fab0
00D9A4  dc.w   $fb50
00D9A6  dc.w   $fb78
00D9A8  dc.w   $fb50
00D9AA  ; data: 0xfb, 0x00
00D9AC  dc.w   $fab0
00D9AE  dc.w   $fab0
00D9B0  dc.w   $fb28
00D9B2  dc.w   $fc18
00D9B4  ; data: 0xfd, 0xa8
00D9B6  ; data: 0xff, 0x60
00D9B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D9C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00D9D4  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00D9DE  dc.w   $fe98
00D9E0  ; data: 0xfd, 0xa8
00D9E2  dc.w   $fd58
00D9E4  dc.w   $fd58
00D9E6  ; data: 0xfd, 0x80
00D9E8  ; data: 0xfd, 0xa8
00D9EA  ; data: 0xfd, 0xa8
00D9EC  dc.w   $fd30
00D9EE  dc.w   $fc18
00D9F0  dc.w   $fad8
00D9F2  ; data: 0xf9, 0x48
00D9F4  ; data: 0xf7, 0x90
00D9F6  dc.w   $f628
00D9F8  dc.w   $f538
00D9FA  dc.w   $f4c0
00D9FC  dc.w   $f510
00D9FE  ; data: 0xf5, 0xd8
00DA00  dc.w   $f6f0
00DA02  dc.w   $f858
00DA04  ; data: 0xf9, 0x98
00DA06  dc.w   $fa88
00DA08  dc.w   $fb28
00DA0A  dc.w   $fb50
00DA0C  dc.w   $fb50
00DA0E  ; data: 0xfb, 0x00
00DA10  dc.w   $fab0
00DA12  dc.w   $fab0
00DA14  dc.w   $fb28
00DA16  dc.w   $fc40
00DA18  ; data: 0xfd, 0xa8
00DA1A  ; data: 0xff, 0x88
00DA1C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DA2A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DA38  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00DA42  dc.w   $fe98
00DA44  ; data: 0xfd, 0xd0
00DA46  dc.w   $fd58
00DA48  dc.w   $fd58
00DA4A  ; data: 0xfd, 0x80
00DA4C  ; data: 0xfd, 0xa8
00DA4E  ; data: 0xfd, 0x80
00DA50  ; data: 0xfd, 0x08
00DA52  dc.w   $fc18
00DA54  dc.w   $fab0
00DA56  dc.w   $f920
00DA58  ; data: 0xf7, 0x90
00DA5A  dc.w   $f628
00DA5C  dc.w   $f538
00DA5E  dc.w   $f4c0
00DA60  dc.w   $f4e8
00DA62  ; data: 0xf5, 0xb0
00DA64  dc.w   $f6f0
00DA66  dc.w   $f830
00DA68  dc.w   $f970
00DA6A  dc.w   $fa60
00DA6C  ; data: 0xfb, 0x00
00DA6E  dc.w   $fb50
00DA70  dc.w   $fb28
00DA72  dc.w   $fad8
00DA74  dc.w   $fab0
00DA76  dc.w   $fad8
00DA78  dc.w   $fb50
00DA7A  dc.w   $fc40
00DA7C  ; data: 0xfd, 0xa8
00DA7E  ; data: 0xff, 0x88
00DA80  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DA8E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DA9C  move.b $1db01db0(d1.l * 4), $fec0fdd0(d1.l * 4)
00DAAA  ; data: 0xfd, 0x80
00DAAC  dc.w   $fd58
00DAAE  ; data: 0xfd, 0x80
00DAB0  ; data: 0xfd, 0xa8
00DAB2  ; data: 0xfd, 0x80
00DAB4  dc.w   $fce0
00DAB6  ; data: 0xfb, 0xf0
00DAB8  dc.w   $fa88
00DABA  dc.w   $f8f8
00DABC  dc.w   $f768
00DABE  dc.w   $f628
00DAC0  dc.w   $f538
00DAC2  dc.w   $f4c0
00DAC4  dc.w   $f4e8
00DAC6  ; data: 0xf5, 0xb0
00DAC8  dc.w   $f6c8
00DACA  dc.w   $f808
00DACC  ; data: 0xf9, 0x48
00DACE  dc.w   $fa60
00DAD0  ; data: 0xfb, 0x00
00DAD2  dc.w   $fb28
00DAD4  dc.w   $fb28
00DAD6  dc.w   $fad8
00DAD8  dc.w   $fab0
00DADA  dc.w   $fad8
00DADC  dc.w   $fb50
00DADE  dc.w   $fc40
00DAE0  ; data: 0xfd, 0xd0
00DAE2  ; data: 0xff, 0x88
00DAE4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DAF2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DB00  move.b $1db01db0(d1.l * 4), $fec0fdf8(d1.l * 4)
00DB0E  ; data: 0xfd, 0x80
00DB10  ; data: 0xfd, 0x80
00DB12  ; data: 0xfd, 0x80
00DB14  ; data: 0xfd, 0x80
00DB16  dc.w   $fd58
00DB18  dc.w   $fcb8
00DB1A  ; data: 0xfb, 0xc8
00DB1C  dc.w   $fa88
00DB1E  dc.w   $f8f8
00DB20  dc.w   $f768
00DB22  dc.w   $f628
00DB24  dc.w   $f538
00DB26  dc.w   $f4c0
00DB28  dc.w   $f4e8
00DB2A  ; data: 0xf5, 0xb0
00DB2C  dc.w   $f6c8
00DB2E  dc.w   $f808
00DB30  dc.w   $f920
00DB32  dc.w   $fa38
00DB34  dc.w   $fad8
00DB36  ; data: 0xfb, 0x00
00DB38  ; data: 0xfb, 0x00
00DB3A  dc.w   $fad8
00DB3C  dc.w   $fab0
00DB3E  dc.w   $fad8
00DB40  dc.w   $fb78
00DB42  dc.w   $fc68
00DB44  ; data: 0xfd, 0xd0
00DB46  ; data: 0xff, 0x88
00DB48  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DB56  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DB64  move.b $1db01db0(d1.l * 4), $fee8fe20(d1.l * 4)
00DB72  ; data: 0xfd, 0xa8
00DB74  ; data: 0xfd, 0x80
00DB76  ; data: 0xfd, 0x80
00DB78  ; data: 0xfd, 0x80
00DB7A  dc.w   $fd30
00DB7C  dc.w   $fc90
00DB7E  ; data: 0xfb, 0xa0
00DB80  dc.w   $fa60
00DB82  dc.w   $f8d0
00DB84  dc.w   $f768
00DB86  dc.w   $f628
00DB88  dc.w   $f538
00DB8A  dc.w   $f4c0
00DB8C  dc.w   $f4e8
00DB8E  ; data: 0xf5, 0xb0
00DB90  dc.w   $f6a0
00DB92  ; data: 0xf7, 0xe0
00DB94  dc.w   $f8f8
00DB96  dc.w   $fa10
00DB98  dc.w   $fab0
00DB9A  dc.w   $fad8
00DB9C  ; data: 0xfb, 0x00
00DB9E  dc.w   $fad8
00DBA0  dc.w   $fab0
00DBA2  ; data: 0xfb, 0x00
00DBA4  dc.w   $fb78
00DBA6  dc.w   $fc90
00DBA8  ; data: 0xfd, 0xf8
00DBAA  ; data: 0xff, 0xb0
00DBAC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DBBA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DBC8  move.b $1db01db0(d1.l * 4), $ff10fe20(d1.l * 4)
00DBD6  ; data: 0xfd, 0xa8
00DBD8  ; data: 0xfd, 0x80
00DBDA  ; data: 0xfd, 0x80
00DBDC  dc.w   $fd58
00DBDE  ; data: 0xfd, 0x08
00DBE0  dc.w   $fc68
00DBE2  dc.w   $fb78
00DBE4  dc.w   $fa38
00DBE6  dc.w   $f8d0
00DBE8  dc.w   $f768
00DBEA  dc.w   $f628
00DBEC  dc.w   $f538
00DBEE  dc.w   $f4e8
00DBF0  dc.w   $f510
00DBF2  ; data: 0xf5, 0xb0
00DBF4  dc.w   $f6a0
00DBF6  ; data: 0xf7, 0xb8
00DBF8  dc.w   $f8f8
00DBFA  ; data: 0xf9, 0xe8
00DBFC  dc.w   $fa88
00DBFE  dc.w   $fad8
00DC00  dc.w   $fad8
00DC02  dc.w   $fad8
00DC04  dc.w   $fad8
00DC06  ; data: 0xfb, 0x00
00DC08  ; data: 0xfb, 0xa0
00DC0A  dc.w   $fc90
00DC0C  ; data: 0xfd, 0xf8
00DC0E  move.b -(a0), $1db0(a6)
00DC12  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DC20  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DC2E  move.b $1db01db0(d1.l * 4), $fe48fdd0(a6, a7.l * 8)
00DC3C  ; data: 0xfd, 0x80
00DC3E  dc.w   $fd58
00DC40  dc.w   $fd30
00DC42  dc.w   $fce0
00DC44  dc.w   $fc40
00DC46  dc.w   $fb50
00DC48  dc.w   $fa10
00DC4A  dc.w   $f8a8
00DC4C  ; data: 0xf7, 0x40
00DC4E  dc.w   $f628
00DC50  dc.w   $f538
00DC52  dc.w   $f4e8
00DC54  dc.w   $f510
00DC56  ; data: 0xf5, 0xb0
00DC58  dc.w   $f6a0
00DC5A  ; data: 0xf7, 0xb8
00DC5C  dc.w   $f8d0
00DC5E  ; data: 0xf9, 0x98
00DC60  dc.w   $fa38
00DC62  dc.w   $fab0
00DC64  dc.w   $fab0
00DC66  dc.w   $fab0
00DC68  dc.w   $fad8
00DC6A  dc.w   $fb28
00DC6C  ; data: 0xfb, 0xc8
00DC6E  dc.w   $fcb8
00DC70  dc.w   $fe20
00DC72  ; data: 0x1d, 0x88
00DC74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DC82  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DC90  move.b $1db01db0(d1.l * 4), $ff60fe70(d1.l * 4)
00DC9E  ; data: 0xfd, 0xd0
00DCA0  ; data: 0xfd, 0x80
00DCA2  dc.w   $fd58
00DCA4  dc.w   $fd30
00DCA6  dc.w   $fcb8
00DCA8  dc.w   $fc18
00DCAA  dc.w   $fb28
00DCAC  ; data: 0xf9, 0xe8
00DCAE  dc.w   $f8a8
00DCB0  ; data: 0xf7, 0x40
00DCB2  dc.w   $f628
00DCB4  ; data: 0xf5, 0x60
00DCB6  dc.w   $f510
00DCB8  dc.w   $f510
00DCBA  ; data: 0xf5, 0xb0
00DCBC  dc.w   $f678
00DCBE  ; data: 0xf7, 0x90
00DCC0  dc.w   $f8a8
00DCC2  dc.w   $f970
00DCC4  dc.w   $fa10
00DCC6  dc.w   $fa88
00DCC8  dc.w   $fab0
00DCCA  dc.w   $fab0
00DCCC  dc.w   $fad8
00DCCE  dc.w   $fb28
00DCD0  ; data: 0xfb, 0xc8
00DCD2  dc.w   $fce0
00DCD4  dc.w   $fe48
00DCD6  ; data: 0x1d, 0x88
00DCD8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DCE6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DCF4  move.b $1db01db0(d1.l * 4), $ff88fe98(d1.l * 4)
00DD02  ; data: 0xfd, 0xf8
00DD04  ; data: 0xfd, 0xa8
00DD06  dc.w   $fd58
00DD08  ; data: 0xfd, 0x08
00DD0A  dc.w   $fc90
00DD0C  ; data: 0xfb, 0xf0
00DD0E  ; data: 0xfb, 0x00
00DD10  ; data: 0xf9, 0xe8
00DD12  dc.w   $f880
00DD14  ; data: 0xf7, 0x40
00DD16  dc.w   $f628
00DD18  ; data: 0xf5, 0x60
00DD1A  dc.w   $f510
00DD1C  dc.w   $f538
00DD1E  ; data: 0xf5, 0xb0
00DD20  dc.w   $f678
00DD22  dc.w   $f768
00DD24  dc.w   $f880
00DD26  ; data: 0xf9, 0x48
00DD28  ; data: 0xf9, 0xe8
00DD2A  dc.w   $fa60
00DD2C  dc.w   $fa88
00DD2E  dc.w   $fab0
00DD30  dc.w   $fad8
00DD32  dc.w   $fb50
00DD34  ; data: 0xfb, 0xf0
00DD36  ; data: 0xfd, 0x08
00DD38  dc.w   $fe48
00DD3A  ; data: 0x1d, 0x88
00DD3C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DD4A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DD58  move.b $1db01db0(d1.l * 4), $ff88fec0(d1.l * 4)
00DD66  dc.w   $fe20
00DD68  ; data: 0xfd, 0xa8
00DD6A  dc.w   $fd58
00DD6C  dc.w   $fce0
00DD6E  dc.w   $fc68
00DD70  ; data: 0xfb, 0xc8
00DD72  dc.w   $fad8
00DD74  ; data: 0xf9, 0xc0
00DD76  dc.w   $f880
00DD78  ; data: 0xf7, 0x40
00DD7A  dc.w   $f628
00DD7C  ; data: 0xf5, 0x88
00DD7E  dc.w   $f538
00DD80  dc.w   $f538
00DD82  ; data: 0xf5, 0xb0
00DD84  dc.w   $f678
00DD86  dc.w   $f768
00DD88  dc.w   $f858
00DD8A  dc.w   $f920
00DD8C  ; data: 0xf9, 0xc0
00DD8E  dc.w   $fa38
00DD90  dc.w   $fa88
00DD92  dc.w   $fab0
00DD94  ; data: 0xfb, 0x00
00DD96  dc.w   $fb50
00DD98  dc.w   $fc18
00DD9A  dc.w   $fd30
00DD9C  dc.w   $fe70
00DD9E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DDAC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DDBA  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
00DDC8  dc.w   $fee8
00DDCA  dc.w   $fe20
00DDCC  ; data: 0xfd, 0xa8
00DDCE  dc.w   $fd30
00DDD0  dc.w   $fce0
00DDD2  dc.w   $fc40
00DDD4  ; data: 0xfb, 0xa0
00DDD6  dc.w   $fab0
00DDD8  ; data: 0xf9, 0x98
00DDDA  dc.w   $f858
00DDDC  ; data: 0xf7, 0x40
00DDDE  dc.w   $f650
00DDE0  ; data: 0xf5, 0x88
00DDE2  dc.w   $f538
00DDE4  ; data: 0xf5, 0x60
00DDE6  ; data: 0xf5, 0xb0
00DDE8  dc.w   $f678
00DDEA  ; data: 0xf7, 0x40
00DDEC  dc.w   $f830
00DDEE  dc.w   $f8f8
00DDF0  ; data: 0xf9, 0x98
00DDF2  dc.w   $fa10
00DDF4  dc.w   $fa60
00DDF6  dc.w   $fab0
00DDF8  ; data: 0xfb, 0x00
00DDFA  dc.w   $fb78
00DDFC  dc.w   $fc40
00DDFE  dc.w   $fd30
00DE00  dc.w   $fe98
00DE02  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DE10  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DE1E  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
00DE2C  dc.w   $fee8
00DE2E  dc.w   $fe48
00DE30  ; data: 0xfd, 0xa8
00DE32  dc.w   $fd30
00DE34  dc.w   $fcb8
00DE36  dc.w   $fc18
00DE38  dc.w   $fb78
00DE3A  dc.w   $fa88
00DE3C  dc.w   $f970
00DE3E  dc.w   $f858
00DE40  ; data: 0xf7, 0x40
00DE42  dc.w   $f650
00DE44  ; data: 0xf5, 0xb0
00DE46  ; data: 0xf5, 0x60
00DE48  ; data: 0xf5, 0x60
00DE4A  ; data: 0xf5, 0xd8
00DE4C  dc.w   $f678
00DE4E  ; data: 0xf7, 0x40
00DE50  dc.w   $f808
00DE52  dc.w   $f8d0
00DE54  dc.w   $f970
00DE56  ; data: 0xf9, 0xe8
00DE58  dc.w   $fa38
00DE5A  dc.w   $fab0
00DE5C  ; data: 0xfb, 0x00
00DE5E  ; data: 0xfb, 0xa0
00DE60  dc.w   $fc68
00DE62  dc.w   $fd58
00DE64  dc.w   $fe98
00DE66  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DE74  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DE82  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DE90  dc.w   $ff10
00DE92  dc.w   $fe48
00DE94  ; data: 0xfd, 0xa8
00DE96  dc.w   $fd30
00DE98  dc.w   $fc90
00DE9A  ; data: 0xfb, 0xf0
00DE9C  dc.w   $fb50
00DE9E  dc.w   $fa60
00DEA0  ; data: 0xf9, 0x48
00DEA2  dc.w   $f830
00DEA4  ; data: 0xf7, 0x40
00DEA6  dc.w   $f650
00DEA8  ; data: 0xf5, 0xb0
00DEAA  ; data: 0xf5, 0x60
00DEAC  ; data: 0xf5, 0x88
00DEAE  ; data: 0xf5, 0xd8
00DEB0  dc.w   $f650
00DEB2  ; data: 0xf7, 0x18
00DEB4  ; data: 0xf7, 0xe0
00DEB6  dc.w   $f8a8
00DEB8  ; data: 0xf9, 0x48
00DEBA  ; data: 0xf9, 0xc0
00DEBC  dc.w   $fa38
00DEBE  dc.w   $fa88
00DEC0  dc.w   $fb28
00DEC2  ; data: 0xfb, 0xa0
00DEC4  dc.w   $fc90
00DEC6  ; data: 0xfd, 0x80
00DEC8  dc.w   $fec0
00DECA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DED8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DEE6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DEF4  dc.w   $ff38
00DEF6  dc.w   $fe70
00DEF8  ; data: 0xfd, 0xd0
00DEFA  dc.w   $fd30
00DEFC  dc.w   $fc90
00DEFE  ; data: 0xfb, 0xc8
00DF00  ; data: 0xfb, 0x00
00DF02  dc.w   $fa38
00DF04  dc.w   $f920
00DF06  dc.w   $f830
00DF08  ; data: 0xf7, 0x40
00DF0A  dc.w   $f678
00DF0C  ; data: 0xf5, 0xd8
00DF0E  ; data: 0xf5, 0x88
00DF10  ; data: 0xf5, 0x88
00DF12  ; data: 0xf5, 0xd8
00DF14  dc.w   $f650
00DF16  dc.w   $f6f0
00DF18  ; data: 0xf7, 0xb8
00DF1A  dc.w   $f880
00DF1C  dc.w   $f920
00DF1E  ; data: 0xf9, 0x98
00DF20  dc.w   $fa10
00DF22  dc.w   $fa88
00DF24  dc.w   $fb28
00DF26  ; data: 0xfb, 0xc8
00DF28  dc.w   $fcb8
00DF2A  ; data: 0xfd, 0xa8
00DF2C  dc.w   $fee8
00DF2E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DF3C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DF4A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DF58  ; data: 0xff, 0x60
00DF5A  dc.w   $fe98
00DF5C  ; data: 0xfd, 0xd0
00DF5E  dc.w   $fd30
00DF60  dc.w   $fc68
00DF62  ; data: 0xfb, 0xc8
00DF64  dc.w   $fad8
00DF66  dc.w   $fa10
00DF68  dc.w   $f920
00DF6A  dc.w   $f830
00DF6C  ; data: 0xf7, 0x40
00DF6E  dc.w   $f678
00DF70  dc.w   $f600
00DF76  ; data: 0xf5, 0xd8
00DF78  dc.w   $f650
00DF7A  dc.w   $f6f0
00DF7C  ; data: 0xf7, 0x90
00DF7E  dc.w   $f830
00DF80  dc.w   $f8f8
00DF82  dc.w   $f970
00DF84  dc.w   $fa10
00DF86  dc.w   $fa88
00DF88  dc.w   $fb28
00DF8A  ; data: 0xfb, 0xf0
00DF8C  dc.w   $fcb8
00DF8E  ; data: 0xfd, 0xd0
00DF90  dc.w   $fee8
00DF92  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DFA0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DFAE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00DFBC  ; data: 0xff, 0x88
00DFBE  dc.w   $fe98
00DFC0  ; data: 0xfd, 0xd0
00DFC2  ; data: 0xfd, 0x08
00DFC4  dc.w   $fc68
00DFC6  ; data: 0xfb, 0xa0
00DFC8  dc.w   $fab0
00DFCA  ; data: 0xf9, 0xe8
00DFCC  dc.w   $f8f8
00DFCE  dc.w   $f808
00DFD0  ; data: 0xf7, 0x40
00DFD2  dc.w   $f678
00DFD4  dc.w   $f600
00DFDA  ; data: 0xf5, 0xd8
00DFDC  dc.w   $f650
00DFDE  dc.w   $f6c8
00DFE0  dc.w   $f768
00DFE2  dc.w   $f830
00DFE4  dc.w   $f8d0
00DFE6  ; data: 0xf9, 0x48
00DFE8  ; data: 0xf9, 0xe8
00DFEA  dc.w   $fa88
00DFEC  dc.w   $fb28
00DFEE  ; data: 0xfb, 0xf0
00DFF0  dc.w   $fce0
00DFF2  ; data: 0xfd, 0xf8
00DFF4  dc.w   $ff10
00DFF6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E004  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E012  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E020  ; data: 0xff, 0x88
00E022  dc.w   $fec0
00E024  ; data: 0xfd, 0xd0
00E026  ; data: 0xfd, 0x08
00E028  dc.w   $fc40
00E02A  dc.w   $fb78
00E02C  dc.w   $fab0
00E02E  ; data: 0xf9, 0xc0
00E030  dc.w   $f8d0
00E032  dc.w   $f808
00E034  ; data: 0xf7, 0x40
00E036  dc.w   $f6a0
00E038  dc.w   $f628
00E03A  ; data: 0xf5, 0xd8
00E03C  ; data: 0xf5, 0xd8
00E03E  dc.w   $f600
00E044  dc.w   $f768
00E046  dc.w   $f808
00E048  dc.w   $f8a8
00E04A  ; data: 0xf9, 0x48
00E04C  ; data: 0xf9, 0xe8
00E04E  dc.w   $fa88
00E050  dc.w   $fb50
00E052  dc.w   $fc18
00E054  ; data: 0xfd, 0x08
00E056  ; data: 0xfd, 0xf8
00E058  dc.w   $ff38
00E05A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E068  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E076  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E084  ; data: 0xff, 0xb0
00E086  dc.w   $fec0
00E088  ; data: 0xfd, 0xd0
00E08A  ; data: 0xfd, 0x08
00E08C  dc.w   $fc40
00E08E  dc.w   $fb50
00E090  dc.w   $fa88
00E092  ; data: 0xf9, 0x98
00E094  dc.w   $f8d0
00E096  ; data: 0xf7, 0xe0
00E098  ; data: 0xf7, 0x40
00E09A  dc.w   $f6a0
00E09C  dc.w   $f628
00E09E  ; data: 0xf5, 0xd8
00E0A0  ; data: 0xf5, 0xd8
00E0A2  dc.w   $f600
00E0A8  ; data: 0xf7, 0x40
00E0AA  ; data: 0xf7, 0xe0
00E0AC  dc.w   $f880
00E0AE  dc.w   $f920
00E0B0  ; data: 0xf9, 0xc0
00E0B2  dc.w   $fa88
00E0B4  dc.w   $fb50
00E0B6  dc.w   $fc18
00E0B8  ; data: 0xfd, 0x08
00E0BA  dc.w   $fe20
00E0BC  dc.w   $ff38
00E0BE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E0CC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E0DA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E0E8  move.b -(a0), -$140(a6)
00E0EC  ; data: 0xfd, 0xd0
00E0EE  ; data: 0xfd, 0x08
00E0F0  dc.w   $fc18
00E0F2  dc.w   $fb50
00E0F4  dc.w   $fa60
00E0F6  dc.w   $f970
00E0F8  dc.w   $f8a8
00E0FA  ; data: 0xf7, 0xe0
00E0FC  ; data: 0xf7, 0x40
00E0FE  dc.w   $f6a0
00E100  dc.w   $f628
00E102  dc.w   $f600
00E108  dc.w   $f650
00E10A  dc.w   $f6a0
00E10C  ; data: 0xf7, 0x40
00E10E  ; data: 0xf7, 0xb8
00E110  dc.w   $f858
00E112  dc.w   $f8f8
00E114  ; data: 0xf9, 0xc0
00E116  dc.w   $fa88
00E118  dc.w   $fb50
00E11A  dc.w   $fc40
00E11C  dc.w   $fd30
00E11E  dc.w   $fe48
00E120  ; data: 0xff, 0x60
00E122  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E130  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E13E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E14C  ; data: 0x1d, 0x88
00E14E  dc.w   $fee8
00E150  ; data: 0xfd, 0xf8
00E152  ; data: 0xfd, 0x08
00E154  dc.w   $fc18
00E156  dc.w   $fb28
00E158  dc.w   $fa38
00E15A  dc.w   $f970
00E15C  dc.w   $f8a8
00E15E  ; data: 0xf7, 0xe0
00E160  ; data: 0xf7, 0x40
00E162  dc.w   $f6a0
00E164  dc.w   $f650
00E166  dc.w   $f600
00E16C  dc.w   $f650
00E16E  dc.w   $f6a0
00E170  ; data: 0xf7, 0x18
00E172  ; data: 0xf7, 0xb8
00E174  dc.w   $f858
00E176  dc.w   $f8f8
00E178  ; data: 0xf9, 0xc0
00E17A  dc.w   $fa88
00E17C  dc.w   $fb50
00E17E  dc.w   $fc40
00E180  dc.w   $fd58
00E182  dc.w   $fe48
00E184  ; data: 0xff, 0x60
00E186  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E194  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E1A2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E1B0  ; data: 0x1d, 0x88
00E1B2  dc.w   $fee8
00E1B4  ; data: 0xfd, 0xf8
00E1B6  dc.w   $fce0
00E1B8  ; data: 0xfb, 0xf0
00E1BA  dc.w   $fb28
00E1BC  dc.w   $fa38
00E1BE  ; data: 0xf9, 0x48
00E1C0  dc.w   $f880
00E1C2  ; data: 0xf7, 0xe0
00E1C4  ; data: 0xf7, 0x40
00E1C6  dc.w   $f6a0
00E1C8  dc.w   $f650
00E1CA  dc.w   $f628
00E1CC  dc.w   $f600
00E1D2  dc.w   $f6a0
00E1D4  ; data: 0xf7, 0x18
00E1D6  ; data: 0xf7, 0x90
00E1D8  dc.w   $f830
00E1DA  dc.w   $f8f8
00E1DC  ; data: 0xf9, 0xc0
00E1DE  dc.w   $fa88
00E1E0  dc.w   $fb78
00E1E2  dc.w   $fc68
00E1E4  dc.w   $fd58
00E1E6  dc.w   $fe70
00E1E8  ; data: 0xff, 0x60
00E1EA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E1F8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E206  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E214  ; data: 0x1d, 0x88
00E216  dc.w   $fee8
00E218  ; data: 0xfd, 0xf8
00E21A  dc.w   $fce0
00E21C  ; data: 0xfb, 0xf0
00E21E  ; data: 0xfb, 0x00
00E220  dc.w   $fa10
00E222  ; data: 0xf9, 0x48
00E224  dc.w   $f880
00E226  ; data: 0xf7, 0xe0
00E228  ; data: 0xf7, 0x40
00E22A  dc.w   $f6c8
00E22C  dc.w   $f650
00E22E  dc.w   $f628
00E230  dc.w   $f600
00E236  dc.w   $f6a0
00E238  dc.w   $f6f0
00E23A  ; data: 0xf7, 0x90
00E23C  dc.w   $f830
00E23E  dc.w   $f8d0
00E240  ; data: 0xf9, 0x98
00E242  dc.w   $fa88
00E244  dc.w   $fb78
00E246  dc.w   $fc68
00E248  dc.w   $fd58
00E24A  dc.w   $fe70
00E24C  ; data: 0xff, 0x88
00E24E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E25C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E26A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E278  ; data: 0x1d, 0x88
00E27A  dc.w   $fee8
00E27C  ; data: 0xfd, 0xf8
00E27E  dc.w   $fce0
00E280  ; data: 0xfb, 0xf0
00E282  ; data: 0xfb, 0x00
00E284  dc.w   $fa10
00E286  ; data: 0xf9, 0x48
00E288  dc.w   $f880
00E28A  ; data: 0xf7, 0xb8
00E28C  ; data: 0xf7, 0x40
00E28E  dc.w   $f6c8
00E290  dc.w   $f650
00E292  dc.w   $f628
00E294  dc.w   $f600
00E29A  dc.w   $f6a0
00E29C  dc.w   $f6f0
00E29E  ; data: 0xf7, 0x90
00E2A0  dc.w   $f830
00E2A2  dc.w   $f8d0
00E2A4  ; data: 0xf9, 0x98
00E2A6  dc.w   $fa88
00E2A8  dc.w   $fb78
00E2AA  dc.w   $fc68
00E2AC  ; data: 0xfd, 0x80
00E2AE  dc.w   $fe70
00E2B0  ; data: 0xff, 0x88
00E2B2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E2C0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E2CE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E2DC  ; data: 0x1d, 0x88
00E2DE  dc.w   $fee8
00E2E0  ; data: 0xfd, 0xd0
00E2E2  dc.w   $fce0
00E2E4  ; data: 0xfb, 0xf0
00E2E6  ; data: 0xfb, 0x00
00E2E8  dc.w   $fa10
00E2EA  ; data: 0xf9, 0x48
00E2EC  dc.w   $f880
00E2EE  ; data: 0xf7, 0xb8
00E2F0  ; data: 0xf7, 0x40
00E2F2  dc.w   $f6c8
00E2F4  dc.w   $f650
00E2F6  dc.w   $f628
00E2F8  dc.w   $f600
00E2FE  dc.w   $f678
00E300  dc.w   $f6f0
00E302  dc.w   $f768
00E304  dc.w   $f808
00E306  dc.w   $f8d0
00E308  ; data: 0xf9, 0x98
00E30A  dc.w   $fa88
00E30C  dc.w   $fb78
00E30E  dc.w   $fc68
00E310  ; data: 0xfd, 0x80
00E312  dc.w   $fe70
00E314  ; data: 0xff, 0x88
00E316  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E324  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E332  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E340  ; data: 0x1d, 0x88
00E342  dc.w   $fee8
00E344  ; data: 0xfd, 0xd0
00E346  dc.w   $fce0
00E348  ; data: 0xfb, 0xf0
00E34A  ; data: 0xfb, 0x00
00E34C  dc.w   $fa10
00E34E  dc.w   $f920
00E350  dc.w   $f880
00E352  ; data: 0xf7, 0xb8
00E354  ; data: 0xf7, 0x40
00E356  dc.w   $f6c8
00E358  dc.w   $f650
00E35A  dc.w   $f628
00E35C  dc.w   $f600
00E362  dc.w   $f678
00E364  dc.w   $f6f0
00E366  dc.w   $f768
00E368  dc.w   $f808
00E36A  dc.w   $f8d0
00E36C  ; data: 0xf9, 0x98
00E36E  dc.w   $fa88
00E370  dc.w   $fb78
00E372  dc.w   $fc68
00E374  ; data: 0xfd, 0x80
00E376  dc.w   $fe70
00E378  ; data: 0xff, 0x88
00E37A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E388  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E396  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E3A4  ; data: 0x1d, 0x88
00E3A6  dc.w   $fee8
00E3A8  ; data: 0xfd, 0xd0
00E3AA  dc.w   $fce0
00E3AC  ; data: 0xfb, 0xf0
00E3AE  ; data: 0xfb, 0x00
00E3B0  dc.w   $fa10
00E3B2  dc.w   $f920
00E3B4  dc.w   $f880
00E3B6  ; data: 0xf7, 0xb8
00E3B8  ; data: 0xf7, 0x40
00E3BA  dc.w   $f6c8
00E3BC  dc.w   $f650
00E3BE  dc.w   $f628
00E3C0  dc.w   $f600
00E3C6  dc.w   $f6a0
00E3C8  dc.w   $f6f0
00E3CA  ; data: 0xf7, 0x90
00E3CC  dc.w   $f808
00E3CE  dc.w   $f8d0
00E3D0  ; data: 0xf9, 0x98
00E3D2  dc.w   $fa88
00E3D4  dc.w   $fb78
00E3D6  dc.w   $fc68
00E3D8  ; data: 0xfd, 0x80
00E3DA  dc.w   $fe70
00E3DC  ; data: 0xff, 0x88
00E3DE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E3EC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E3FA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E408  ; data: 0x1d, 0x88
00E40A  dc.w   $fec0
00E40C  ; data: 0xfd, 0xd0
00E40E  dc.w   $fce0
00E410  ; data: 0xfb, 0xf0
00E412  ; data: 0xfb, 0x00
00E414  dc.w   $fa10
00E416  ; data: 0xf9, 0x48
00E418  dc.w   $f880
00E41A  ; data: 0xf7, 0xb8
00E41C  ; data: 0xf7, 0x40
00E41E  dc.w   $f6c8
00E420  dc.w   $f650
00E422  dc.w   $f628
00E424  dc.w   $f600
00E42A  dc.w   $f6a0
00E42C  dc.w   $f6f0
00E42E  ; data: 0xf7, 0x90
00E430  dc.w   $f830
00E432  dc.w   $f8d0
00E434  ; data: 0xf9, 0x98
00E436  dc.w   $fa88
00E438  dc.w   $fb78
00E43A  dc.w   $fc68
00E43C  dc.w   $fd58
00E43E  dc.w   $fe70
00E440  ; data: 0xff, 0x88
00E442  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E450  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E45E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E46C  move.b -(a0), -$140(a6)
00E470  ; data: 0xfd, 0xd0
00E472  dc.w   $fce0
00E474  ; data: 0xfb, 0xf0
00E476  ; data: 0xfb, 0x00
00E478  dc.w   $fa10
00E47A  ; data: 0xf9, 0x48
00E47C  dc.w   $f880
00E47E  ; data: 0xf7, 0xb8
00E480  ; data: 0xf7, 0x40
00E482  dc.w   $f6a0
00E484  dc.w   $f650
00E486  dc.w   $f628
00E488  dc.w   $f600
00E48E  dc.w   $f6a0
00E490  ; data: 0xf7, 0x18
00E492  ; data: 0xf7, 0x90
00E494  dc.w   $f830
00E496  dc.w   $f8f8
00E498  ; data: 0xf9, 0xc0
00E49A  dc.w   $fa88
00E49C  dc.w   $fb78
00E49E  dc.w   $fc68
00E4A0  dc.w   $fd58
00E4A2  dc.w   $fe70
00E4A4  ; data: 0xff, 0x60
00E4A6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E4B4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E4C2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E4D0  ; data: 0xff, 0xb0
00E4D2  dc.w   $fec0
00E4D4  ; data: 0xfd, 0xd0
00E4D6  dc.w   $fce0
00E4D8  ; data: 0xfb, 0xf0
00E4DA  ; data: 0xfb, 0x00
00E4DC  dc.w   $fa38
00E4DE  ; data: 0xf9, 0x48
00E4E0  dc.w   $f880
00E4E2  ; data: 0xf7, 0xe0
00E4E4  ; data: 0xf7, 0x18
00E4E6  dc.w   $f6a0
00E4E8  dc.w   $f650
00E4EA  dc.w   $f600
00E4F0  dc.w   $f650
00E4F2  dc.w   $f6a0
00E4F4  ; data: 0xf7, 0x18
00E4F6  ; data: 0xf7, 0xb8
00E4F8  dc.w   $f858
00E4FA  dc.w   $f8f8
00E4FC  ; data: 0xf9, 0xc0
00E4FE  dc.w   $fa88
00E500  dc.w   $fb50
00E502  dc.w   $fc40
00E504  dc.w   $fd58
00E506  dc.w   $fe48
00E508  ; data: 0xff, 0x60
00E50A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E518  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E526  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E534  ; data: 0xff, 0x88
00E536  dc.w   $fe98
00E538  ; data: 0xfd, 0xa8
00E53A  dc.w   $fce0
00E53C  ; data: 0xfb, 0xf0
00E53E  dc.w   $fb28
00E540  dc.w   $fa38
00E542  dc.w   $f970
00E544  dc.w   $f8a8
00E546  ; data: 0xf7, 0xe0
00E548  ; data: 0xf7, 0x18
00E54A  dc.w   $f6a0
00E54C  dc.w   $f628
00E54E  dc.w   $f600
00E554  dc.w   $f650
00E556  dc.w   $f6a0
00E558  ; data: 0xf7, 0x40
00E55A  ; data: 0xf7, 0xb8
00E55C  dc.w   $f858
00E55E  dc.w   $f8f8
00E560  ; data: 0xf9, 0xc0
00E562  dc.w   $fa88
00E564  dc.w   $fb50
00E566  dc.w   $fc40
00E568  dc.w   $fd30
00E56A  dc.w   $fe48
00E56C  ; data: 0xff, 0x60
00E56E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E57C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E58A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E598  ; data: 0xff, 0x60
00E59A  dc.w   $fe70
00E59C  ; data: 0xfd, 0xa8
00E59E  dc.w   $fce0
00E5A0  ; data: 0xfb, 0xf0
00E5A2  dc.w   $fb28
00E5A4  dc.w   $fa60
00E5A6  dc.w   $f970
00E5A8  dc.w   $f8a8
00E5AA  ; data: 0xf7, 0xe0
00E5AC  ; data: 0xf7, 0x18
00E5AE  dc.w   $f6a0
00E5B0  dc.w   $f628
00E5B2  ; data: 0xf5, 0xd8
00E5B4  ; data: 0xf5, 0xd8
00E5B6  dc.w   $f600
00E5BC  ; data: 0xf7, 0x40
00E5BE  ; data: 0xf7, 0xe0
00E5C0  dc.w   $f880
00E5C2  dc.w   $f920
00E5C4  ; data: 0xf9, 0xc0
00E5C6  dc.w   $fa88
00E5C8  dc.w   $fb50
00E5CA  dc.w   $fc40
00E5CC  dc.w   $fd30
00E5CE  dc.w   $fe20
00E5D0  dc.w   $ff38
00E5D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E5E0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E5EE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E5FC  dc.w   $ff38
00E5FE  dc.w   $fe70
00E600  ; data: 0xfd, 0xa8
00E602  dc.w   $fce0
00E604  dc.w   $fc18
00E606  dc.w   $fb50
00E608  dc.w   $fa60
00E60A  ; data: 0xf9, 0x98
00E60C  dc.w   $f8a8
00E60E  ; data: 0xf7, 0xe0
00E610  ; data: 0xf7, 0x18
00E612  dc.w   $f678
00E614  dc.w   $f600
00E61A  dc.w   $f600
00E620  dc.w   $f768
00E622  dc.w   $f808
00E624  dc.w   $f8a8
00E626  ; data: 0xf9, 0x48
00E628  ; data: 0xf9, 0xe8
00E62A  dc.w   $fa88
00E62C  dc.w   $fb50
00E62E  dc.w   $fc18
00E630  ; data: 0xfd, 0x08
00E632  dc.w   $fe20
00E634  dc.w   $ff38
00E636  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E644  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E652  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E660  dc.w   $ff38
00E662  dc.w   $fe48
00E664  ; data: 0xfd, 0x80
00E666  dc.w   $fce0
00E668  dc.w   $fc18
00E66A  dc.w   $fb50
00E66C  dc.w   $fa88
00E66E  ; data: 0xf9, 0xc0
00E670  dc.w   $f8d0
00E672  ; data: 0xf7, 0xe0
00E674  ; data: 0xf7, 0x18
00E676  dc.w   $f678
00E678  dc.w   $f600
00E67E  dc.w   $f600
00E684  dc.w   $f768
00E686  dc.w   $f830
00E688  dc.w   $f8d0
00E68A  ; data: 0xf9, 0x48
00E68C  ; data: 0xf9, 0xe8
00E68E  dc.w   $fa88
00E690  dc.w   $fb50
00E692  dc.w   $fc18
00E694  dc.w   $fce0
00E696  ; data: 0xfd, 0xf8
00E698  dc.w   $ff10
00E69A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E6A8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E6B6  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
00E6C4  dc.w   $ff10
00E6C6  dc.w   $fe20
00E6C8  ; data: 0xfd, 0x80
00E6CA  dc.w   $fce0
00E6CC  dc.w   $fc18
00E6CE  dc.w   $fb78
00E6D0  dc.w   $fab0
00E6D2  ; data: 0xf9, 0xc0
00E6D4  dc.w   $f8f8
00E6D6  dc.w   $f808
00E6D8  ; data: 0xf7, 0x18
00E6DA  dc.w   $f678
00E6DC  ; data: 0xf5, 0xd8
00E6DE  ; data: 0xf5, 0xb0
00E6E0  ; data: 0xf5, 0xb0
00E6E2  ; data: 0xf5, 0xd8
00E6E4  dc.w   $f650
00E6E6  dc.w   $f6f0
00E6E8  ; data: 0xf7, 0x90
00E6EA  dc.w   $f830
00E6EC  dc.w   $f8f8
00E6EE  dc.w   $f970
00E6F0  dc.w   $fa10
00E6F2  dc.w   $fa88
00E6F4  dc.w   $fb28
00E6F6  ; data: 0xfb, 0xf0
00E6F8  dc.w   $fce0
00E6FA  ; data: 0xfd, 0xd0
00E6FC  dc.w   $ff10
00E6FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E70C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E71A  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
00E728  dc.w   $fee8
00E72A  dc.w   $fe20
00E72C  dc.w   $fd58
00E72E  dc.w   $fce0
00E730  dc.w   $fc40
00E732  ; data: 0xfb, 0xa0
00E734  dc.w   $fad8
00E736  ; data: 0xf9, 0xe8
00E738  dc.w   $f8f8
00E73A  dc.w   $f808
00E73C  ; data: 0xf7, 0x18
00E73E  dc.w   $f650
00E740  ; data: 0xf5, 0xd8
00E742  ; data: 0xf5, 0x88
00E744  ; data: 0xf5, 0x88
00E746  ; data: 0xf5, 0xd8
00E748  dc.w   $f650
00E74A  ; data: 0xf7, 0x18
00E74C  ; data: 0xf7, 0xb8
00E74E  dc.w   $f858
00E750  dc.w   $f920
00E752  ; data: 0xf9, 0x98
00E754  dc.w   $fa10
00E756  dc.w   $fa88
00E758  dc.w   $fb28
00E75A  ; data: 0xfb, 0xc8
00E75C  dc.w   $fcb8
00E75E  ; data: 0xfd, 0xa8
00E760  dc.w   $fee8
00E762  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E770  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E77E  move.b $1db01db0(d1.l * 4), $1db0ff88(d1.l * 4)
00E78C  dc.w   $fe98
00E78E  ; data: 0xfd, 0xf8
00E790  dc.w   $fd58
00E792  dc.w   $fce0
00E794  dc.w   $fc40
00E796  ; data: 0xfb, 0xa0
00E798  ; data: 0xfb, 0x00
00E79A  dc.w   $fa10
00E79C  dc.w   $f920
00E79E  dc.w   $f808
00E7A0  ; data: 0xf7, 0x18
00E7A2  dc.w   $f650
00E7A4  ; data: 0xf5, 0xb0
00E7A6  ; data: 0xf5, 0x60
00E7A8  ; data: 0xf5, 0x88
00E7AA  ; data: 0xf5, 0xd8
00E7AC  dc.w   $f678
00E7AE  ; data: 0xf7, 0x18
00E7B0  ; data: 0xf7, 0xe0
00E7B2  dc.w   $f8a8
00E7B4  ; data: 0xf9, 0x48
00E7B6  ; data: 0xf9, 0xc0
00E7B8  dc.w   $fa38
00E7BA  dc.w   $fab0
00E7BC  dc.w   $fb28
00E7BE  ; data: 0xfb, 0xc8
00E7C0  dc.w   $fc90
00E7C2  ; data: 0xfd, 0x80
00E7C4  dc.w   $fec0
00E7C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E7D4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E7E2  move.b $1db01db0(d1.l * 4), $1db0ff60(d1.l * 4)
00E7F0  dc.w   $fe70
00E7F2  ; data: 0xfd, 0xd0
00E7F4  dc.w   $fd30
00E7F6  dc.w   $fce0
00E7F8  dc.w   $fc68
00E7FA  ; data: 0xfb, 0xc8
00E7FC  dc.w   $fb28
00E7FE  dc.w   $fa38
00E800  ; data: 0xf9, 0x48
00E802  dc.w   $f830
00E804  ; data: 0xf7, 0x18
00E806  dc.w   $f650
00E808  ; data: 0xf5, 0xb0
00E80A  ; data: 0xf5, 0x60
00E80C  ; data: 0xf5, 0x60
00E80E  ; data: 0xf5, 0xd8
00E810  dc.w   $f678
00E812  ; data: 0xf7, 0x40
00E814  dc.w   $f808
00E816  dc.w   $f8d0
00E818  dc.w   $f970
00E81A  ; data: 0xf9, 0xe8
00E81C  dc.w   $fa38
00E81E  dc.w   $fab0
00E820  ; data: 0xfb, 0x00
00E822  ; data: 0xfb, 0xa0
00E824  dc.w   $fc68
00E826  ; data: 0xfd, 0x80
00E828  dc.w   $fe98
00E82A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E838  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E846  move.b $1db01db0(d1.l * 4), $1db0ff38(d1.l * 4)
00E854  dc.w   $fe48
00E856  ; data: 0xfd, 0xa8
00E858  dc.w   $fd30
00E85A  dc.w   $fce0
00E85C  dc.w   $fc68
00E85E  ; data: 0xfb, 0xf0
00E860  dc.w   $fb50
00E862  dc.w   $fa60
00E864  ; data: 0xf9, 0x48
00E866  dc.w   $f830
00E868  ; data: 0xf7, 0x18
00E86A  dc.w   $f628
00E86C  ; data: 0xf5, 0x88
00E86E  dc.w   $f538
00E870  ; data: 0xf5, 0x60
00E872  ; data: 0xf5, 0xb0
00E874  dc.w   $f678
00E876  ; data: 0xf7, 0x40
00E878  dc.w   $f830
00E87A  dc.w   $f8f8
00E87C  ; data: 0xf9, 0x98
00E87E  dc.w   $fa10
00E880  dc.w   $fa60
00E882  dc.w   $fab0
00E884  ; data: 0xfb, 0x00
00E886  dc.w   $fb78
00E888  dc.w   $fc40
00E88A  dc.w   $fd58
00E88C  dc.w   $fe98
00E88E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E89C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E8AA  move.b $1db01db0(d1.l * 4), $1db0ff10(d1.l * 4)
00E8B8  dc.w   $fe20
00E8BA  ; data: 0xfd, 0x80
00E8BC  dc.w   $fd30
00E8BE  dc.w   $fce0
00E8C0  dc.w   $fc90
00E8C2  dc.w   $fc18
00E8C4  dc.w   $fb78
00E8C6  dc.w   $fa88
00E8C8  dc.w   $f970
00E8CA  dc.w   $f858
00E8CC  ; data: 0xf7, 0x18
00E8CE  dc.w   $f628
00E8D0  ; data: 0xf5, 0x60
00E8D2  dc.w   $f510
00E8D4  dc.w   $f538
00E8D6  ; data: 0xf5, 0xb0
00E8D8  dc.w   $f678
00E8DA  dc.w   $f768
00E8DC  dc.w   $f858
00E8DE  dc.w   $f920
00E8E0  ; data: 0xf9, 0xc0
00E8E2  dc.w   $fa38
00E8E4  dc.w   $fa88
00E8E6  dc.w   $fab0
00E8E8  ; data: 0xfb, 0x00
00E8EA  dc.w   $fb78
00E8EC  dc.w   $fc18
00E8EE  dc.w   $fd30
00E8F0  dc.w   $fe70
00E8F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E900  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E90E  move.b $1db01db0(d1.l * 4), $1db0fec0(d1.l * 4)
00E91C  ; data: 0xfd, 0xf8
00E91E  dc.w   $fd58
00E920  ; data: 0xfd, 0x08
00E922  dc.w   $fce0
00E924  dc.w   $fc90
00E926  dc.w   $fc40
00E928  ; data: 0xfb, 0xa0
00E92A  dc.w   $fab0
00E92C  ; data: 0xf9, 0x98
00E92E  dc.w   $f858
00E930  ; data: 0xf7, 0x18
00E932  dc.w   $f628
00E934  ; data: 0xf5, 0x60
00E936  dc.w   $f510
00E938  dc.w   $f538
00E93A  ; data: 0xf5, 0xb0
00E93C  dc.w   $f678
00E93E  dc.w   $f768
00E940  dc.w   $f880
00E942  ; data: 0xf9, 0x48
00E944  ; data: 0xf9, 0xe8
00E946  dc.w   $fa60
00E948  dc.w   $fa88
00E94A  dc.w   $fab0
00E94C  ; data: 0xfb, 0x00
00E94E  dc.w   $fb50
00E950  ; data: 0xfb, 0xf0
00E952  ; data: 0xfd, 0x08
00E954  dc.w   $fe48
00E956  ; data: 0x1d, 0x88
00E958  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E966  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E974  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00E97E  dc.w   $fe98
00E980  ; data: 0xfd, 0xd0
00E982  dc.w   $fd30
00E984  ; data: 0xfd, 0x08
00E986  dc.w   $fce0
00E988  dc.w   $fcb8
00E98A  dc.w   $fc40
00E98C  ; data: 0xfb, 0xc8
00E98E  dc.w   $fad8
00E990  ; data: 0xf9, 0xc0
00E992  dc.w   $f858
00E994  ; data: 0xf7, 0x18
00E996  dc.w   $f600
00E99C  dc.w   $f510
00E99E  ; data: 0xf5, 0xb0
00E9A0  dc.w   $f6a0
00E9A2  ; data: 0xf7, 0x90
00E9A4  dc.w   $f8a8
00E9A6  dc.w   $f970
00E9A8  dc.w   $fa10
00E9AA  dc.w   $fa88
00E9AC  dc.w   $fab0
00E9AE  dc.w   $fab0
00E9B0  dc.w   $fad8
00E9B2  dc.w   $fb28
00E9B4  ; data: 0xfb, 0xf0
00E9B6  dc.w   $fce0
00E9B8  dc.w   $fe48
00E9BA  ; data: 0x1d, 0x88
00E9BC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E9CA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00E9D8  move.b $1db01db0(d1.l * 4), $fe70fda8(a7.l * 8)
00E9E6  dc.w   $fd30
00E9E8  dc.w   $fce0
00E9EA  dc.w   $fce0
00E9EC  dc.w   $fcb8
00E9EE  dc.w   $fc68
00E9F0  ; data: 0xfb, 0xf0
00E9F2  ; data: 0xfb, 0x00
00E9F4  ; data: 0xf9, 0xc0
00E9F6  dc.w   $f880
00E9F8  ; data: 0xf7, 0x18
00E9FA  dc.w   $f600
00EA00  dc.w   $f510
00EA02  ; data: 0xf5, 0xb0
00EA04  dc.w   $f6a0
00EA06  ; data: 0xf7, 0xb8
00EA08  dc.w   $f8d0
00EA0A  ; data: 0xf9, 0x98
00EA0C  dc.w   $fa60
00EA0E  dc.w   $fab0
00EA10  dc.w   $fad8
00EA12  dc.w   $fad8
00EA14  dc.w   $fad8
00EA16  dc.w   $fb28
00EA18  ; data: 0xfb, 0xc8
00EA1A  dc.w   $fcb8
00EA1C  dc.w   $fe20
00EA1E  move.b -(a0), $1db0(a6)
00EA22  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EA30  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EA3E  move.b $1db0ff88(d1.l * 4), $48(a6, a7.l)
00EA48  ; data: 0xfd, 0x80
00EA4A  ; data: 0xfd, 0x08
00EA4C  dc.w   $fce0
00EA4E  dc.w   $fce0
00EA50  dc.w   $fcb8
00EA52  dc.w   $fc90
00EA54  ; data: 0xfb, 0xf0
00EA56  dc.w   $fb28
00EA58  ; data: 0xf9, 0xe8
00EA5A  dc.w   $f880
00EA5C  ; data: 0xf7, 0x18
00EA5E  dc.w   $f600
00EA64  dc.w   $f510
00EA66  ; data: 0xf5, 0xb0
00EA68  dc.w   $f6a0
00EA6A  ; data: 0xf7, 0xb8
00EA6C  dc.w   $f8f8
00EA6E  ; data: 0xf9, 0xe8
00EA70  dc.w   $fa88
00EA72  dc.w   $fad8
00EA74  dc.w   $fad8
00EA76  dc.w   $fad8
00EA78  dc.w   $fad8
00EA7A  ; data: 0xfb, 0x00
00EA7C  ; data: 0xfb, 0xa0
00EA7E  dc.w   $fc90
00EA80  ; data: 0xfd, 0xf8
00EA82  ; data: 0xff, 0xb0
00EA84  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EA92  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EAA0  move.b $1db01db0(d1.l * 4), $fe20(a6, invalid.w)
00EAAC  dc.w   $fd58
00EAAE  dc.w   $fce0
00EAB0  dc.w   $fcb8
00EAB2  dc.w   $fce0
00EAB4  dc.w   $fce0
00EAB6  dc.w   $fcb8
00EAB8  dc.w   $fc18
00EABA  dc.w   $fb50
00EABC  dc.w   $fa10
00EABE  dc.w   $f8a8
00EAC0  ; data: 0xf7, 0x40
00EAC2  dc.w   $f600
00EAC8  dc.w   $f4e8
00EACA  ; data: 0xf5, 0xb0
00EACC  dc.w   $f6a0
00EACE  ; data: 0xf7, 0xe0
00EAD0  dc.w   $f920
00EAD2  dc.w   $fa10
00EAD4  dc.w   $fab0
00EAD6  ; data: 0xfb, 0x00
00EAD8  ; data: 0xfb, 0x00
00EADA  dc.w   $fad8
00EADC  dc.w   $fad8
00EADE  ; data: 0xfb, 0x00
00EAE0  dc.w   $fb78
00EAE2  dc.w   $fc90
00EAE4  ; data: 0xfd, 0xf8
00EAE6  ; data: 0xff, 0xb0
00EAE8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EAF6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EB04  move.b $1db01db0(d1.l * 4), $fdf8fd30(a6, a7.l * 8)
00EB12  dc.w   $fcb8
00EB14  dc.w   $fcb8
00EB16  dc.w   $fce0
00EB18  dc.w   $fce0
00EB1A  dc.w   $fcb8
00EB1C  dc.w   $fc40
00EB1E  dc.w   $fb50
00EB20  dc.w   $fa10
00EB22  dc.w   $f8a8
00EB24  ; data: 0xf7, 0x40
00EB26  dc.w   $f600
00EB2C  dc.w   $f4e8
00EB2E  ; data: 0xf5, 0xb0
00EB30  dc.w   $f6c8
00EB32  dc.w   $f808
00EB34  dc.w   $f920
00EB36  dc.w   $fa38
00EB38  dc.w   $fad8
00EB3A  ; data: 0xfb, 0x00
00EB3C  ; data: 0xfb, 0x00
00EB3E  dc.w   $fad8
00EB40  dc.w   $fad8
00EB42  dc.w   $fad8
00EB44  dc.w   $fb78
00EB46  dc.w   $fc68
00EB48  ; data: 0xfd, 0xd0
00EB4A  ; data: 0xff, 0x88
00EB4C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EB5A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EB68  move.b $1db01db0(d1.l * 4), (a6, a7.l * 8)
00EB72  ; data: 0xfd, 0xd0
00EB74  ; data: 0xfd, 0x08
00EB76  dc.w   $fcb8
00EB78  dc.w   $fcb8
00EB7A  dc.w   $fce0
00EB7C  ; data: 0xfd, 0x08
00EB7E  dc.w   $fce0
00EB80  dc.w   $fc68
00EB82  dc.w   $fb78
00EB84  dc.w   $fa38
00EB86  dc.w   $f8d0
00EB88  ; data: 0xf7, 0x40
00EB8A  dc.w   $f600
00EB90  dc.w   $f4e8
00EB92  ; data: 0xf5, 0xb0
00EB94  dc.w   $f6c8
00EB96  dc.w   $f808
00EB98  ; data: 0xf9, 0x48
00EB9A  dc.w   $fa60
00EB9C  ; data: 0xfb, 0x00
00EB9E  dc.w   $fb28
00EBA0  dc.w   $fb28
00EBA2  dc.w   $fad8
00EBA4  dc.w   $fab0
00EBA6  dc.w   $fad8
00EBA8  dc.w   $fb50
00EBAA  dc.w   $fc40
00EBAC  ; data: 0xfd, 0xd0
00EBAE  ; data: 0xff, 0x88
00EBB0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EBBE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EBCC  move.b $1db01db0(d1.l * 4), -$18(a6, a7.l)
00EBD6  ; data: 0xfd, 0xa8
00EBD8  dc.w   $fce0
00EBDA  dc.w   $fc90
00EBDC  dc.w   $fc90
00EBDE  dc.w   $fce0
00EBE0  ; data: 0xfd, 0x08
00EBE2  dc.w   $fce0
00EBE4  dc.w   $fc68
00EBE6  ; data: 0xfb, 0xa0
00EBE8  dc.w   $fa60
00EBEA  dc.w   $f8d0
00EBEC  ; data: 0xf7, 0x40
00EBEE  dc.w   $f600
00EBF4  dc.w   $f4e8
00EBF6  ; data: 0xf5, 0xb0
00EBF8  dc.w   $f6f0
00EBFA  dc.w   $f830
00EBFC  dc.w   $f970
00EBFE  dc.w   $fa88
00EC00  dc.w   $fb28
00EC02  dc.w   $fb50
00EC04  dc.w   $fb28
00EC06  ; data: 0xfb, 0x00
00EC08  dc.w   $fab0
00EC0A  dc.w   $fad8
00EC0C  dc.w   $fb50
00EC0E  dc.w   $fc40
00EC10  ; data: 0xfd, 0xa8
00EC12  ; data: 0xff, 0x88
00EC14  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EC22  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EC30  move.b $1db01db0(d1.l * 4), -$40(a6, a7.l)
00EC3A  ; data: 0xfd, 0x80
00EC3C  dc.w   $fcb8
00EC3E  dc.w   $fc90
00EC40  dc.w   $fc90
00EC42  dc.w   $fce0
00EC44  ; data: 0xfd, 0x08
00EC46  ; data: 0xfd, 0x08
00EC48  dc.w   $fc90
00EC4A  ; data: 0xfb, 0xa0
00EC4C  dc.w   $fa60
00EC4E  dc.w   $f8d0
00EC50  ; data: 0xf7, 0x40
00EC52  dc.w   $f600
00EC58  dc.w   $f4e8
00EC5A  ; data: 0xf5, 0xb0
00EC5C  dc.w   $f6f0
00EC5E  dc.w   $f858
00EC60  ; data: 0xf9, 0x98
00EC62  dc.w   $fa88
00EC64  dc.w   $fb28
00EC66  dc.w   $fb78
00EC68  dc.w   $fb50
00EC6A  ; data: 0xfb, 0x00
00EC6C  dc.w   $fab0
00EC6E  dc.w   $fab0
00EC70  dc.w   $fb28
00EC72  dc.w   $fc18
00EC74  ; data: 0xfd, 0xa8
00EC76  ; data: 0xff, 0x60
00EC78  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EC86  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EC94  move.b $1db01db0(d1.l * 4), -$68(a6, a7.l)
00EC9E  ; data: 0xfd, 0x80
00ECA0  dc.w   $fcb8
00ECA2  dc.w   $fc68
00ECA4  dc.w   $fc90
00ECA6  dc.w   $fce0
00ECA8  ; data: 0xfd, 0x08
00ECAA  ; data: 0xfd, 0x08
00ECAC  dc.w   $fcb8
00ECAE  ; data: 0xfb, 0xc8
00ECB0  dc.w   $fa88
00ECB2  dc.w   $f8f8
00ECB4  dc.w   $f768
00ECB6  dc.w   $f600
00ECBC  dc.w   $f4e8
00ECBE  ; data: 0xf5, 0xd8
00ECC0  dc.w   $f6f0
00ECC2  dc.w   $f858
00ECC4  ; data: 0xf9, 0xc0
00ECC6  dc.w   $fab0
00ECC8  dc.w   $fb50
00ECCA  dc.w   $fb78
00ECCC  dc.w   $fb50
00ECCE  ; data: 0xfb, 0x00
00ECD0  dc.w   $fab0
00ECD2  dc.w   $fab0
00ECD4  dc.w   $fb28
00ECD6  dc.w   $fc18
00ECD8  ; data: 0xfd, 0x80
00ECDA  ; data: 0xff, 0x60
00ECDC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00ECEA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00ECF8  move.b $1db01db0(d1.l * 4), -$68(a6, a7.l)
00ED02  dc.w   $fd58
00ED04  dc.w   $fc90
00ED06  dc.w   $fc68
00ED08  dc.w   $fc90
00ED0A  dc.w   $fce0
00ED0C  ; data: 0xfd, 0x08
00ED0E  ; data: 0xfd, 0x08
00ED10  dc.w   $fcb8
00ED12  ; data: 0xfb, 0xc8
00ED14  dc.w   $fa88
00ED16  dc.w   $f8f8
00ED18  dc.w   $f768
00ED1A  dc.w   $f600
00ED20  dc.w   $f510
00ED22  ; data: 0xf5, 0xd8
00ED24  ; data: 0xf7, 0x18
00ED26  dc.w   $f880
00ED28  ; data: 0xf9, 0xc0
00ED2A  dc.w   $fad8
00ED2C  dc.w   $fb78
00ED2E  ; data: 0xfb, 0xa0
00ED30  dc.w   $fb78
00ED32  ; data: 0xfb, 0x00
00ED34  dc.w   $fab0
00ED36  dc.w   $fab0
00ED38  dc.w   $fb28
00ED3A  dc.w   $fc18
00ED3C  ; data: 0xfd, 0x80
00ED3E  ; data: 0xff, 0x60
00ED40  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00ED4E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00ED5C  move.b $1db01db0(d1.l * 4), $70(a6, a7.l)
00ED66  dc.w   $fd30
00ED68  dc.w   $fc90
00ED6A  dc.w   $fc40
00ED6C  dc.w   $fc68
00ED6E  dc.w   $fce0
00ED70  ; data: 0xfd, 0x08
00ED72  dc.w   $fd30
00ED74  dc.w   $fcb8
00ED76  ; data: 0xfb, 0xf0
00ED78  dc.w   $fa88
00ED7A  dc.w   $f920
00ED7C  dc.w   $f768
00ED7E  dc.w   $f628
00ED80  dc.w   $f538
00ED82  dc.w   $f4c0
00ED84  dc.w   $f510
00ED86  ; data: 0xf5, 0xd8
00ED88  ; data: 0xf7, 0x18
00ED8A  dc.w   $f880
00ED8C  ; data: 0xf9, 0xe8
00ED8E  dc.w   $fad8
00ED90  dc.w   $fb78
00ED92  ; data: 0xfb, 0xa0
00ED94  dc.w   $fb78
00ED96  dc.w   $fb28
00ED98  dc.w   $fad8
00ED9A  dc.w   $fab0
00ED9C  dc.w   $fb28
00ED9E  dc.w   $fc18
00EDA0  ; data: 0xfd, 0x80
00EDA2  ; data: 0xff, 0x60
00EDA4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EDB2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EDC0  move.b $1db01db0(d1.l * 4), $70(a6, a7.l)
00EDCA  dc.w   $fd30
00EDCC  dc.w   $fc68
00EDCE  dc.w   $fc40
00EDD0  dc.w   $fc68
00EDD2  dc.w   $fcb8
00EDD4  ; data: 0xfd, 0x08
00EDD6  dc.w   $fd30
00EDD8  dc.w   $fcb8
00EDDA  ; data: 0xfb, 0xf0
00EDDC  dc.w   $fab0
00EDDE  dc.w   $f920
00EDE0  ; data: 0xf7, 0x90
00EDE2  dc.w   $f628
00EDE4  dc.w   $f538
00EDE6  dc.w   $f4e8
00EDE8  dc.w   $f538
00EDEA  dc.w   $f600
00EDF0  ; data: 0xf9, 0xe8
00EDF2  ; data: 0xfb, 0x00
00EDF4  ; data: 0xfb, 0xa0
00EDF6  ; data: 0xfb, 0xc8
00EDF8  dc.w   $fb78
00EDFA  dc.w   $fb28
00EDFC  dc.w   $fad8
00EDFE  dc.w   $fab0
00EE00  dc.w   $fb28
00EE02  dc.w   $fc18
00EE04  ; data: 0xfd, 0x80
00EE06  dc.w   $ff38
00EE08  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EE16  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EE24  move.b $1db01d88(d1.l * 4), $48(a6, a7.l)
00EE2E  dc.w   $fd30
00EE30  dc.w   $fc68
00EE32  dc.w   $fc40
00EE34  dc.w   $fc68
00EE36  dc.w   $fcb8
00EE38  ; data: 0xfd, 0x08
00EE3A  dc.w   $fd30
00EE3C  dc.w   $fcb8
00EE3E  ; data: 0xfb, 0xf0
00EE40  dc.w   $fab0
00EE42  dc.w   $f920
00EE44  ; data: 0xf7, 0x90
00EE46  dc.w   $f650
00EE48  ; data: 0xf5, 0x60
00EE4A  dc.w   $f4e8
00EE4C  dc.w   $f538
00EE4E  dc.w   $f628
00EE50  ; data: 0xf7, 0x40
00EE52  dc.w   $f8a8
00EE54  dc.w   $fa10
00EE56  ; data: 0xfb, 0x00
00EE58  ; data: 0xfb, 0xa0
00EE5A  ; data: 0xfb, 0xc8
00EE5C  ; data: 0xfb, 0xa0
00EE5E  dc.w   $fb28
00EE60  dc.w   $fad8
00EE62  dc.w   $fad8
00EE64  dc.w   $fb28
00EE66  dc.w   $fc18
00EE68  ; data: 0xfd, 0x80
00EE6A  dc.w   $ff38
00EE6C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EE7A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EE88  move.b $1db01d88(d1.l * 4), $48(a6, a7.l)
00EE92  ; data: 0xfd, 0x08
00EE94  dc.w   $fc68
00EE96  dc.w   $fc40
00EE98  dc.w   $fc68
00EE9A  dc.w   $fcb8
00EE9C  ; data: 0xfd, 0x08
00EE9E  dc.w   $fd30
00EEA0  dc.w   $fcb8
00EEA2  ; data: 0xfb, 0xf0
00EEA4  dc.w   $fab0
00EEA6  ; data: 0xf9, 0x48
00EEA8  ; data: 0xf7, 0xb8
00EEAA  dc.w   $f650
00EEAC  ; data: 0xf5, 0x60
00EEAE  dc.w   $f510
00EEB0  ; data: 0xf5, 0x60
00EEB2  dc.w   $f628
00EEB4  dc.w   $f768
00EEB6  dc.w   $f8d0
00EEB8  dc.w   $fa10
00EEBA  dc.w   $fb28
00EEBC  ; data: 0xfb, 0xa0
00EEBE  ; data: 0xfb, 0xc8
00EEC0  ; data: 0xfb, 0xa0
00EEC2  dc.w   $fb50
00EEC4  dc.w   $fad8
00EEC6  dc.w   $fad8
00EEC8  dc.w   $fb28
00EECA  dc.w   $fc18
00EECC  ; data: 0xfd, 0x80
00EECE  dc.w   $ff38
00EED0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EEDE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EEEC  move.b $1db01d60(d1.l * 4), $48(a6, a7.l)
00EEF6  ; data: 0xfd, 0x08
00EEF8  dc.w   $fc68
00EEFA  dc.w   $fc40
00EEFC  dc.w   $fc68
00EEFE  dc.w   $fcb8
00EF00  ; data: 0xfd, 0x08
00EF02  ; data: 0xfd, 0x08
00EF04  dc.w   $fcb8
00EF06  ; data: 0xfb, 0xf0
00EF08  dc.w   $fab0
00EF0A  ; data: 0xf9, 0x48
00EF0C  ; data: 0xf7, 0xb8
00EF0E  dc.w   $f678
00EF10  ; data: 0xf5, 0x88
00EF12  dc.w   $f538
00EF14  ; data: 0xf5, 0x88
00EF16  dc.w   $f650
00EF18  ; data: 0xf7, 0x90
00EF1A  dc.w   $f8d0
00EF1C  dc.w   $fa10
00EF1E  dc.w   $fb28
00EF20  ; data: 0xfb, 0xa0
00EF22  ; data: 0xfb, 0xc8
00EF24  ; data: 0xfb, 0xa0
00EF26  dc.w   $fb50
00EF28  ; data: 0xfb, 0x00
00EF2A  dc.w   $fad8
00EF2C  dc.w   $fb50
00EF2E  dc.w   $fc18
00EF30  ; data: 0xfd, 0x80
00EF32  dc.w   $ff38
00EF34  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EF42  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EF50  move.b $1db0ffb0(d1.l * 4), $20(a6, a7.l)
00EF5A  ; data: 0xfd, 0x08
00EF5C  dc.w   $fc68
00EF5E  dc.w   $fc40
00EF60  dc.w   $fc68
00EF62  dc.w   $fcb8
00EF64  ; data: 0xfd, 0x08
00EF66  ; data: 0xfd, 0x08
00EF68  dc.w   $fcb8
00EF6A  ; data: 0xfb, 0xf0
00EF6C  dc.w   $fab0
00EF6E  ; data: 0xf9, 0x48
00EF70  ; data: 0xf7, 0xe0
00EF72  dc.w   $f6a0
00EF74  ; data: 0xf5, 0xb0
00EF76  ; data: 0xf5, 0x60
00EF78  ; data: 0xf5, 0xb0
00EF7A  dc.w   $f678
00EF7C  ; data: 0xf7, 0x90
00EF7E  dc.w   $f8f8
00EF80  dc.w   $fa38
00EF82  dc.w   $fb28
00EF84  ; data: 0xfb, 0xc8
00EF86  ; data: 0xfb, 0xf0
00EF88  ; data: 0xfb, 0xa0
00EF8A  dc.w   $fb50
00EF8C  ; data: 0xfb, 0x00
00EF8E  ; data: 0xfb, 0x00
00EF90  dc.w   $fb50
00EF92  dc.w   $fc40
00EF94  ; data: 0xfd, 0x80
00EF96  dc.w   $ff38
00EF98  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EFA6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00EFB4  move.b $1db0ffb0(d1.l * 4), $20(a6, a7.l)
00EFBE  ; data: 0xfd, 0x08
00EFC0  dc.w   $fc68
00EFC2  dc.w   $fc40
00EFC4  dc.w   $fc68
00EFC6  dc.w   $fcb8
00EFC8  ; data: 0xfd, 0x08
00EFCA  ; data: 0xfd, 0x08
00EFCC  dc.w   $fcb8
00EFCE  ; data: 0xfb, 0xf0
00EFD0  dc.w   $fab0
00EFD2  dc.w   $f970
00EFD4  ; data: 0xf7, 0xe0
00EFD6  dc.w   $f6a0
00EFD8  ; data: 0xf5, 0xd8
00EFDA  ; data: 0xf5, 0x88
00EFDC  ; data: 0xf5, 0xd8
00EFDE  dc.w   $f6a0
00EFE0  ; data: 0xf7, 0xb8
00EFE2  dc.w   $f8f8
00EFE4  dc.w   $fa38
00EFE6  dc.w   $fb28
00EFE8  ; data: 0xfb, 0xc8
00EFEA  ; data: 0xfb, 0xf0
00EFEC  ; data: 0xfb, 0xc8
00EFEE  dc.w   $fb50
00EFF0  dc.w   $fb28
00EFF2  ; data: 0xfb, 0x00
00EFF4  dc.w   $fb78
00EFF6  dc.w   $fc40
00EFF8  ; data: 0xfd, 0xa8
00EFFA  dc.w   $ff38
00EFFC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F00A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F018  move.b $1db0ff88(d1.l * 4), $20(a6, a7.l)
00F022  dc.w   $fd30
00F024  dc.w   $fc68
00F026  dc.w   $fc40
00F028  dc.w   $fc68
00F02A  dc.w   $fcb8
00F02C  dc.w   $fce0
00F02E  ; data: 0xfd, 0x08
00F030  dc.w   $fc90
00F032  ; data: 0xfb, 0xf0
00F034  dc.w   $fab0
00F036  dc.w   $f970
00F038  dc.w   $f808
00F03A  dc.w   $f6c8
00F03C  dc.w   $f600
00F042  dc.w   $f6c8
00F044  ; data: 0xf7, 0xe0
00F046  dc.w   $f920
00F048  dc.w   $fa38
00F04A  dc.w   $fb28
00F04C  ; data: 0xfb, 0xa0
00F04E  ; data: 0xfb, 0xf0
00F050  ; data: 0xfb, 0xc8
00F052  dc.w   $fb78
00F054  dc.w   $fb28
00F056  dc.w   $fb28
00F058  dc.w   $fb78
00F05A  dc.w   $fc68
00F05C  ; data: 0xfd, 0xa8
00F05E  dc.w   $ff38
00F060  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F06E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F07C  move.b $1db0ff88(d1.l * 4), $20(a6, a7.l)
00F086  dc.w   $fd30
00F088  dc.w   $fc90
00F08A  dc.w   $fc40
00F08C  dc.w   $fc68
00F08E  dc.w   $fcb8
00F090  dc.w   $fce0
00F092  dc.w   $fce0
00F094  dc.w   $fc90
00F096  ; data: 0xfb, 0xc8
00F098  dc.w   $fab0
00F09A  dc.w   $f970
00F09C  dc.w   $f830
00F09E  dc.w   $f6f0
00F0A0  dc.w   $f628
00F0A2  ; data: 0xf5, 0xd8
00F0A4  dc.w   $f628
00F0A6  dc.w   $f6f0
00F0A8  ; data: 0xf7, 0xe0
00F0AA  dc.w   $f920
00F0AC  dc.w   $fa38
00F0AE  dc.w   $fb28
00F0B0  ; data: 0xfb, 0xa0
00F0B2  ; data: 0xfb, 0xc8
00F0B4  ; data: 0xfb, 0xc8
00F0B6  dc.w   $fb78
00F0B8  dc.w   $fb50
00F0BA  dc.w   $fb50
00F0BC  ; data: 0xfb, 0xa0
00F0BE  dc.w   $fc68
00F0C0  ; data: 0xfd, 0xa8
00F0C2  dc.w   $ff38
00F0C4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F0D2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F0E0  move.b $1db0ff88(d1.l * 4), $20(a6, a7.l)
00F0EA  dc.w   $fd30
00F0EC  dc.w   $fc90
00F0EE  dc.w   $fc68
00F0F0  dc.w   $fc68
00F0F2  dc.w   $fc90
00F0F4  dc.w   $fce0
00F0F6  dc.w   $fce0
00F0F8  dc.w   $fc68
00F0FA  ; data: 0xfb, 0xc8
00F0FC  dc.w   $fab0
00F0FE  dc.w   $f970
00F100  dc.w   $f830
00F102  ; data: 0xf7, 0x18
00F104  dc.w   $f678
00F106  dc.w   $f628
00F108  dc.w   $f650
00F10A  ; data: 0xf7, 0x18
00F10C  dc.w   $f808
00F10E  dc.w   $f920
00F110  dc.w   $fa38
00F112  dc.w   $fb28
00F114  ; data: 0xfb, 0xa0
00F116  ; data: 0xfb, 0xc8
00F118  ; data: 0xfb, 0xc8
00F11A  dc.w   $fb78
00F11C  dc.w   $fb50
00F11E  dc.w   $fb50
00F120  ; data: 0xfb, 0xc8
00F122  dc.w   $fc90
00F124  ; data: 0xfd, 0xd0
00F126  dc.w   $ff38
00F128  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F136  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F144  move.b $1db0ff60(d1.l * 4), $20(a6, a7.l)
00F14E  dc.w   $fd30
00F150  dc.w   $fcb8
00F152  dc.w   $fc68
00F154  dc.w   $fc68
00F156  dc.w   $fc90
00F158  dc.w   $fcb8
00F15A  dc.w   $fcb8
00F15C  dc.w   $fc68
00F15E  ; data: 0xfb, 0xa0
00F160  dc.w   $fab0
00F162  ; data: 0xf9, 0x98
00F164  dc.w   $f858
00F166  ; data: 0xf7, 0x40
00F168  dc.w   $f6a0
00F16A  dc.w   $f650
00F16C  dc.w   $f6a0
00F16E  ; data: 0xf7, 0x40
00F170  dc.w   $f830
00F172  ; data: 0xf9, 0x48
00F174  dc.w   $fa38
00F176  ; data: 0xfb, 0x00
00F178  ; data: 0xfb, 0xa0
00F17A  ; data: 0xfb, 0xc8
00F17C  ; data: 0xfb, 0xc8
00F17E  ; data: 0xfb, 0xa0
00F180  dc.w   $fb78
00F182  dc.w   $fb78
00F184  ; data: 0xfb, 0xf0
00F186  dc.w   $fcb8
00F188  ; data: 0xfd, 0xd0
00F18A  dc.w   $ff38
00F18C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F19A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F1A8  move.b $1db0ff60(d1.l * 4), $48(a6, a7.l)
00F1B2  dc.w   $fd58
00F1B4  dc.w   $fcb8
00F1B6  dc.w   $fc68
00F1B8  dc.w   $fc68
00F1BA  dc.w   $fc90
00F1BC  dc.w   $fcb8
00F1BE  dc.w   $fc90
00F1C0  dc.w   $fc40
00F1C2  ; data: 0xfb, 0xa0
00F1C4  dc.w   $fab0
00F1C6  ; data: 0xf9, 0x98
00F1C8  dc.w   $f880
00F1CA  dc.w   $f768
00F1CC  dc.w   $f6c8
00F1CE  dc.w   $f6a0
00F1D0  dc.w   $f6c8
00F1D2  dc.w   $f768
00F1D4  dc.w   $f858
00F1D6  ; data: 0xf9, 0x48
00F1D8  dc.w   $fa38
00F1DA  ; data: 0xfb, 0x00
00F1DC  dc.w   $fb78
00F1DE  ; data: 0xfb, 0xc8
00F1E0  ; data: 0xfb, 0xc8
00F1E2  ; data: 0xfb, 0xa0
00F1E4  dc.w   $fb78
00F1E6  ; data: 0xfb, 0xa0
00F1E8  dc.w   $fc18
00F1EA  dc.w   $fce0
00F1EC  ; data: 0xfd, 0xf8
00F1EE  ; data: 0xff, 0x60
00F1F0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F1FE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F20C  move.b $1db0ff60(d1.l * 4), $48(a6, a7.l)
00F216  dc.w   $fd58
00F218  dc.w   $fcb8
00F21A  dc.w   $fc90
00F21C  dc.w   $fc68
00F21E  dc.w   $fc90
00F220  dc.w   $fc90
00F222  dc.w   $fc90
00F224  dc.w   $fc18
00F226  dc.w   $fb78
00F228  dc.w   $fab0
00F22A  ; data: 0xf9, 0x98
00F22C  dc.w   $f880
00F22E  ; data: 0xf7, 0xb8
00F230  ; data: 0xf7, 0x18
00F232  dc.w   $f6c8
00F234  dc.w   $f6f0
00F236  ; data: 0xf7, 0x90
00F238  dc.w   $f858
00F23A  ; data: 0xf9, 0x48
00F23C  dc.w   $fa38
00F23E  ; data: 0xfb, 0x00
00F240  dc.w   $fb78
00F242  ; data: 0xfb, 0xc8
00F244  ; data: 0xfb, 0xc8
00F246  ; data: 0xfb, 0xa0
00F248  ; data: 0xfb, 0xa0
00F24A  ; data: 0xfb, 0xc8
00F24C  dc.w   $fc40
00F24E  dc.w   $fce0
00F250  ; data: 0xfd, 0xf8
00F252  ; data: 0xff, 0x60
00F254  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F262  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F270  move.b $1db0ff60(d1.l * 4), $48(a6, a7.l)
00F27A  ; data: 0xfd, 0x80
00F27C  dc.w   $fce0
00F27E  dc.w   $fc90
00F280  dc.w   $fc90
00F282  dc.w   $fc90
00F284  dc.w   $fc90
00F286  dc.w   $fc68
00F288  dc.w   $fc18
00F28A  dc.w   $fb78
00F28C  dc.w   $fa88
00F28E  ; data: 0xf9, 0x98
00F290  dc.w   $f8a8
00F292  ; data: 0xf7, 0xe0
00F294  ; data: 0xf7, 0x40
00F296  ; data: 0xf7, 0x18
00F298  ; data: 0xf7, 0x40
00F29A  ; data: 0xf7, 0xb8
00F29C  dc.w   $f880
00F29E  dc.w   $f970
00F2A0  dc.w   $fa38
00F2A2  ; data: 0xfb, 0x00
00F2A4  dc.w   $fb78
00F2A6  ; data: 0xfb, 0xa0
00F2A8  ; data: 0xfb, 0xc8
00F2AA  ; data: 0xfb, 0xc8
00F2AC  ; data: 0xfb, 0xc8
00F2AE  ; data: 0xfb, 0xf0
00F2B0  dc.w   $fc68
00F2B2  ; data: 0xfd, 0x08
00F2B4  dc.w   $fe20
00F2B6  ; data: 0xff, 0x60
00F2B8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F2C6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F2D4  move.b $1db0ff38(d1.l * 4), $48(a6, a7.l)
00F2DE  ; data: 0xfd, 0x80
00F2E0  dc.w   $fce0
00F2E2  dc.w   $fc90
00F2E4  dc.w   $fc90
00F2E6  dc.w   $fc90
00F2E8  dc.w   $fc68
00F2EA  dc.w   $fc40
00F2EC  ; data: 0xfb, 0xf0
00F2EE  dc.w   $fb50
00F2F0  dc.w   $fa88
00F2F2  ; data: 0xf9, 0xc0
00F2F4  dc.w   $f8d0
00F2F6  dc.w   $f808
00F2F8  ; data: 0xf7, 0x90
00F2FA  ; data: 0xf7, 0x40
00F2FC  dc.w   $f768
00F2FE  ; data: 0xf7, 0xe0
00F300  dc.w   $f8a8
00F302  dc.w   $f970
00F304  dc.w   $fa38
00F306  dc.w   $fad8
00F308  dc.w   $fb50
00F30A  ; data: 0xfb, 0xa0
00F30C  ; data: 0xfb, 0xc8
00F30E  ; data: 0xfb, 0xc8
00F310  ; data: 0xfb, 0xc8
00F312  dc.w   $fc18
00F314  dc.w   $fc90
00F316  dc.w   $fd30
00F318  dc.w   $fe48
00F31A  ; data: 0xff, 0x60
00F31C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F32A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F338  move.b $1db0ff38(d1.l * 4), $48(a6, a7.l)
00F342  ; data: 0xfd, 0x80
00F344  ; data: 0xfd, 0x08
00F346  dc.w   $fcb8
00F348  dc.w   $fc90
00F34A  dc.w   $fc68
00F34C  dc.w   $fc68
00F34E  dc.w   $fc40
00F350  ; data: 0xfb, 0xc8
00F352  dc.w   $fb50
00F354  dc.w   $fa88
00F356  ; data: 0xf9, 0xc0
00F358  dc.w   $f8f8
00F35A  dc.w   $f830
00F35C  ; data: 0xf7, 0xb8
00F35E  ; data: 0xf7, 0x90
00F360  ; data: 0xf7, 0xb8
00F362  dc.w   $f808
00F364  dc.w   $f8d0
00F366  dc.w   $f970
00F368  dc.w   $fa38
00F36A  dc.w   $fad8
00F36C  dc.w   $fb50
00F36E  ; data: 0xfb, 0xa0
00F370  ; data: 0xfb, 0xc8
00F372  ; data: 0xfb, 0xc8
00F374  ; data: 0xfb, 0xf0
00F376  dc.w   $fc40
00F378  dc.w   $fcb8
00F37A  dc.w   $fd58
00F37C  dc.w   $fe48
00F37E  ; data: 0xff, 0x60
00F380  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F38E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F39C  move.b $1db0ff38(d1.l * 4), $70(a6, a7.l)
00F3A6  ; data: 0xfd, 0xa8
00F3A8  ; data: 0xfd, 0x08
00F3AA  dc.w   $fcb8
00F3AC  dc.w   $fc90
00F3AE  dc.w   $fc68
00F3B0  dc.w   $fc40
00F3B2  dc.w   $fc18
00F3B4  ; data: 0xfb, 0xc8
00F3B6  dc.w   $fb28
00F3B8  dc.w   $fa88
00F3BA  ; data: 0xf9, 0xc0
00F3BC  dc.w   $f8f8
00F3BE  dc.w   $f858
00F3C0  ; data: 0xf7, 0xe0
00F3C2  ; data: 0xf7, 0xb8
00F3C4  ; data: 0xf7, 0xe0
00F3C6  dc.w   $f858
00F3C8  dc.w   $f8d0
00F3CA  ; data: 0xf9, 0x98
00F3CC  dc.w   $fa38
00F3CE  dc.w   $fad8
00F3D0  dc.w   $fb50
00F3D2  ; data: 0xfb, 0xa0
00F3D4  ; data: 0xfb, 0xc8
00F3D6  ; data: 0xfb, 0xf0
00F3D8  dc.w   $fc18
00F3DA  dc.w   $fc68
00F3DC  dc.w   $fce0
00F3DE  ; data: 0xfd, 0x80
00F3E0  dc.w   $fe70
00F3E2  ; data: 0xff, 0x60
00F3E4  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F3F2  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F400  move.b $1db0ff38(d1.l * 4), $70(a6, a7.l)
00F40A  ; data: 0xfd, 0xa8
00F40C  dc.w   $fd30
00F40E  dc.w   $fce0
00F410  dc.w   $fc90
00F412  dc.w   $fc68
00F414  dc.w   $fc40
00F416  ; data: 0xfb, 0xf0
00F418  ; data: 0xfb, 0xa0
00F41A  dc.w   $fb28
00F41C  dc.w   $fa88
00F41E  ; data: 0xf9, 0xc0
00F420  dc.w   $f920
00F422  dc.w   $f880
00F424  dc.w   $f830
00F426  dc.w   $f808
00F428  dc.w   $f830
00F42A  dc.w   $f880
00F42C  dc.w   $f8f8
00F42E  ; data: 0xf9, 0x98
00F430  dc.w   $fa38
00F432  dc.w   $fab0
00F434  dc.w   $fb28
00F436  dc.w   $fb78
00F438  ; data: 0xfb, 0xc8
00F43A  ; data: 0xfb, 0xf0
00F43C  dc.w   $fc18
00F43E  dc.w   $fc68
00F440  ; data: 0xfd, 0x08
00F442  ; data: 0xfd, 0xa8
00F444  dc.w   $fe70
00F446  ; data: 0xff, 0x60
00F448  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F456  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F464  move.b $1d88ff38(d1.l * 4), $70(a6, a7.l)
00F46E  ; data: 0xfd, 0xd0
00F470  dc.w   $fd30
00F472  dc.w   $fce0
00F474  dc.w   $fc90
00F476  dc.w   $fc68
00F478  dc.w   $fc18
00F47A  ; data: 0xfb, 0xf0
00F47C  dc.w   $fb78
00F47E  ; data: 0xfb, 0x00
00F480  dc.w   $fa60
00F482  ; data: 0xf9, 0xe8
00F484  ; data: 0xf9, 0x48
00F486  dc.w   $f8a8
00F488  dc.w   $f858
00F48A  dc.w   $f830
00F48C  dc.w   $f858
00F48E  dc.w   $f8a8
00F490  dc.w   $f920
00F492  ; data: 0xf9, 0x98
00F494  dc.w   $fa38
00F496  dc.w   $fab0
00F498  dc.w   $fb28
00F49A  dc.w   $fb78
00F49C  ; data: 0xfb, 0xc8
00F49E  ; data: 0xfb, 0xf0
00F4A0  dc.w   $fc40
00F4A2  dc.w   $fc90
00F4A4  ; data: 0xfd, 0x08
00F4A6  ; data: 0xfd, 0xd0
00F4A8  dc.w   $fe98
00F4AA  ; data: 0xff, 0x88
00F4AC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F4BA  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F4C8  move.b $1d88ff10(d1.l * 4), $70(a6, a7.l)
00F4D2  ; data: 0xfd, 0xd0
00F4D4  dc.w   $fd58
00F4D6  dc.w   $fce0
00F4D8  dc.w   $fc90
00F4DA  dc.w   $fc68
00F4DC  dc.w   $fc18
00F4DE  ; data: 0xfb, 0xc8
00F4E0  dc.w   $fb78
00F4E2  ; data: 0xfb, 0x00
00F4E4  dc.w   $fa60
00F4E6  ; data: 0xf9, 0xe8
00F4E8  ; data: 0xf9, 0x48
00F4EA  dc.w   $f8f8
00F4EC  dc.w   $f8a8
00F4EE  dc.w   $f880
00F4F0  dc.w   $f880
00F4F2  dc.w   $f8d0
00F4F4  ; data: 0xf9, 0x48
00F4F6  ; data: 0xf9, 0xc0
00F4F8  dc.w   $fa38
00F4FA  dc.w   $fab0
00F4FC  dc.w   $fb28
00F4FE  dc.w   $fb78
00F500  ; data: 0xfb, 0xc8
00F502  dc.w   $fc18
00F504  dc.w   $fc68
00F506  dc.w   $fcb8
00F508  dc.w   $fd30
00F50A  ; data: 0xfd, 0xd0
00F50C  dc.w   $fe98
00F50E  ; data: 0xff, 0x88
00F510  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F51E  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F52C  move.b $1d60ff10(d1.l * 4), $70(a6, a7.l)
00F536  ; data: 0xfd, 0xd0
00F538  dc.w   $fd58
00F53A  ; data: 0xfd, 0x08
00F53C  dc.w   $fc90
00F53E  dc.w   $fc68
00F540  dc.w   $fc18
00F542  ; data: 0xfb, 0xc8
00F544  dc.w   $fb50
00F546  dc.w   $fad8
00F548  dc.w   $fa60
00F54A  ; data: 0xf9, 0xe8
00F54C  dc.w   $f970
00F54E  dc.w   $f920
00F550  dc.w   $f8d0
00F552  dc.w   $f8a8
00F554  dc.w   $f8d0
00F556  dc.w   $f8f8
00F558  ; data: 0xf9, 0x48
00F55A  ; data: 0xf9, 0xc0
00F55C  dc.w   $fa38
00F55E  dc.w   $fab0
00F560  ; data: 0xfb, 0x00
00F562  dc.w   $fb78
00F564  ; data: 0xfb, 0xc8
00F566  dc.w   $fc18
00F568  dc.w   $fc68
00F56A  dc.w   $fce0
00F56C  dc.w   $fd58
00F56E  ; data: 0xfd, 0xf8
00F570  dc.w   $fec0
00F572  ; data: 0xff, 0x88
00F574  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F582  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F590  move.b $ff88ff10(d1.l * 4), $70(a6, a7.l)
00F59A  ; data: 0xfd, 0xf8
00F59C  dc.w   $fd58
00F59E  ; data: 0xfd, 0x08
00F5A0  dc.w   $fc90
00F5A2  dc.w   $fc40
00F5A4  ; data: 0xfb, 0xf0
00F5A6  ; data: 0xfb, 0xa0
00F5A8  dc.w   $fb50
00F5AA  dc.w   $fad8
00F5AC  dc.w   $fa60
00F5AE  ; data: 0xf9, 0xe8
00F5B0  ; data: 0xf9, 0x98
00F5B2  ; data: 0xf9, 0x48
00F5B4  dc.w   $f8f8
00F5B6  dc.w   $f8f8
00F5B8  dc.w   $f8f8
00F5BA  dc.w   $f920
00F5BC  dc.w   $f970
00F5BE  ; data: 0xf9, 0xe8
00F5C0  dc.w   $fa38
00F5C2  dc.w   $fab0
00F5C4  ; data: 0xfb, 0x00
00F5C6  dc.w   $fb78
00F5C8  ; data: 0xfb, 0xc8
00F5CA  dc.w   $fc18
00F5CC  dc.w   $fc90
00F5CE  ; data: 0xfd, 0x08
00F5D0  ; data: 0xfd, 0x80
00F5D2  dc.w   $fe20
00F5D4  dc.w   $fec0
00F5D6  ; data: 0xff, 0x88
00F5D8  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F5E6  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F5F4  move.b $ff88fee8(d1.l * 4), $70(a6, a7.l)
00F5FE  ; data: 0xfd, 0xf8
00F600  ; data: 0xfd, 0x80
00F602  ; data: 0xfd, 0x08
00F604  dc.w   $fcb8
00F606  dc.w   $fc40
00F608  ; data: 0xfb, 0xf0
00F60A  ; data: 0xfb, 0xa0
00F60C  dc.w   $fb28
00F60E  dc.w   $fad8
00F610  dc.w   $fa60
00F612  dc.w   $fa10
00F614  ; data: 0xf9, 0x98
00F616  dc.w   $f970
00F618  dc.w   $f920
00F61A  dc.w   $f920
00F61C  dc.w   $f920
00F61E  ; data: 0xf9, 0x48
00F620  ; data: 0xf9, 0x98
00F622  ; data: 0xf9, 0xe8
00F624  dc.w   $fa38
00F626  dc.w   $fab0
00F628  ; data: 0xfb, 0x00
00F62A  dc.w   $fb78
00F62C  ; data: 0xfb, 0xc8
00F62E  dc.w   $fc40
00F630  dc.w   $fc90
00F632  ; data: 0xfd, 0x08
00F634  ; data: 0xfd, 0xa8
00F636  dc.w   $fe20
00F638  dc.w   $fec0
00F63A  ; data: 0xff, 0x88
00F63C  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F64A  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F658  move.b (d1.l * 4), $fee8(a6, invalid.w)
00F660  dc.w   $fe70
00F662  ; data: 0xfd, 0xf8
00F664  ; data: 0xfd, 0x80
00F666  ; data: 0xfd, 0x08
00F668  dc.w   $fcb8
00F66A  dc.w   $fc40
00F66C  ; data: 0xfb, 0xf0
00F66E  dc.w   $fb78
00F670  dc.w   $fb28
00F672  dc.w   $fad8
00F674  dc.w   $fa60
00F676  dc.w   $fa10
00F678  ; data: 0xf9, 0xc0
00F67A  ; data: 0xf9, 0x98
00F67C  dc.w   $f970
00F67E  ; data: 0xf9, 0x48
00F680  ; data: 0xf9, 0x48
00F682  dc.w   $f970
00F684  ; data: 0xf9, 0xc0
00F686  ; data: 0xf9, 0xe8
00F688  dc.w   $fa60
00F68A  dc.w   $fab0
00F68C  ; data: 0xfb, 0x00
00F68E  dc.w   $fb78
00F690  ; data: 0xfb, 0xc8
00F692  dc.w   $fc40
00F694  dc.w   $fcb8
00F696  dc.w   $fd30
00F698  ; data: 0xfd, 0xa8
00F69A  dc.w   $fe48
00F69C  dc.w   $fee8
00F69E  ; data: 0xff, 0x88
00F6A0  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F6AE  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F6BC  move.b $ff38fec0(a7.l * 8), $48(a6, a7.l)
00F6C6  ; data: 0xfd, 0xf8
00F6C8  ; data: 0xfd, 0x80
00F6CA  ; data: 0xfd, 0x08
00F6CC  dc.w   $fc90
00F6CE  dc.w   $fc40
00F6D0  ; data: 0xfb, 0xf0
00F6D2  dc.w   $fb78
00F6D4  dc.w   $fb28
00F6D6  dc.w   $fad8
00F6D8  dc.w   $fa60
00F6DA  dc.w   $fa10
00F6DC  ; data: 0xf9, 0xe8
00F6DE  ; data: 0xf9, 0x98
00F6E0  ; data: 0xf9, 0x98
00F6E2  dc.w   $f970
00F6E4  dc.w   $f970
00F6E6  ; data: 0xf9, 0x98
00F6E8  ; data: 0xf9, 0xc0
00F6EA  dc.w   $fa10
00F6EC  dc.w   $fa60
00F6EE  dc.w   $fab0
00F6F0  ; data: 0xfb, 0x00
00F6F2  dc.w   $fb78
00F6F4  ; data: 0xfb, 0xc8
00F6F6  dc.w   $fc40
00F6F8  dc.w   $fcb8
00F6FA  dc.w   $fd30
00F6FC  ; data: 0xfd, 0xd0
00F6FE  dc.w   $fe48
00F700  dc.w   $fee8
00F702  ; data: 0xff, 0x88
00F704  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F712  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F720  ; data: 0x1d, 0x88
00F722  ; data: 0xff, 0x88
00F724  dc.w   $ff10
00F726  dc.w   $fec0
00F728  dc.w   $fe48
00F72A  ; data: 0xfd, 0xd0
00F72C  ; data: 0xfd, 0x80
00F72E  ; data: 0xfd, 0x08
00F730  dc.w   $fc90
00F732  dc.w   $fc40
00F734  ; data: 0xfb, 0xc8
00F736  dc.w   $fb78
00F738  dc.w   $fb28
00F73A  dc.w   $fad8
00F73C  dc.w   $fa88
00F73E  dc.w   $fa38
00F740  ; data: 0xf9, 0xe8
00F742  ; data: 0xf9, 0xc0
00F744  ; data: 0xf9, 0x98
00F746  ; data: 0xf9, 0x98
00F748  ; data: 0xf9, 0x98
00F74A  ; data: 0xf9, 0xc0
00F74C  ; data: 0xf9, 0xe8
00F74E  dc.w   $fa10
00F750  dc.w   $fa60
00F752  dc.w   $fab0
00F754  dc.w   $fb28
00F756  dc.w   $fb78
00F758  ; data: 0xfb, 0xf0
00F75A  dc.w   $fc68
00F75C  dc.w   $fce0
00F75E  dc.w   $fd58
00F760  ; data: 0xfd, 0xd0
00F762  dc.w   $fe70
00F764  dc.w   $fee8
00F766  ; data: 0xff, 0x88
00F768  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F776  move.b $1db01db0(d1.l * 4), $1db01d88(d1.l * 4)
00F784  ; data: 0xff, 0xb0
00F786  ; data: 0xff, 0x60
00F788  dc.w   $ff10
00F78A  dc.w   $fe98
00F78C  dc.w   $fe48
00F78E  ; data: 0xfd, 0xd0
00F790  ; data: 0xfd, 0x80
00F792  ; data: 0xfd, 0x08
00F794  dc.w   $fc90
00F796  dc.w   $fc40
00F798  ; data: 0xfb, 0xc8
00F79A  dc.w   $fb78
00F79C  dc.w   $fb28
00F79E  dc.w   $fad8
00F7A0  dc.w   $fa88
00F7A2  dc.w   $fa38
00F7A4  dc.w   $fa10
00F7A6  ; data: 0xf9, 0xe8
00F7A8  ; data: 0xf9, 0xc0
00F7AA  ; data: 0xf9, 0xc0
00F7AC  ; data: 0xf9, 0xc0
00F7AE  ; data: 0xf9, 0xe8
00F7B0  dc.w   $fa10
00F7B2  dc.w   $fa38
00F7B4  dc.w   $fa88
00F7B6  dc.w   $fad8
00F7B8  dc.w   $fb28
00F7BA  dc.w   $fb78
00F7BC  ; data: 0xfb, 0xf0
00F7BE  dc.w   $fc68
00F7C0  dc.w   $fce0
00F7C2  dc.w   $fd58
00F7C4  ; data: 0xfd, 0xd0
00F7C6  dc.w   $fe70
00F7C8  dc.w   $fee8
00F7CA  ; data: 0xff, 0x88
00F7CC  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F7DA  move.b $1db01db0(d1.l * 4), $1db01d60(d1.l * 4)
00F7E8  ; data: 0xff, 0x88
00F7EA  dc.w   $ff38
00F7EC  dc.w   $fee8
00F7EE  dc.w   $fe98
00F7F0  dc.w   $fe20
00F7F2  ; data: 0xfd, 0xd0
00F7F4  dc.w   $fd58
00F7F6  ; data: 0xfd, 0x08
00F7F8  dc.w   $fc90
00F7FA  dc.w   $fc40
00F7FC  ; data: 0xfb, 0xc8
00F7FE  dc.w   $fb78
00F800  dc.w   $fb28
00F802  dc.w   $fad8
00F804  dc.w   $fa88
00F806  dc.w   $fa60
00F808  dc.w   $fa10
00F80A  dc.w   $fa10
00F80C  ; data: 0xf9, 0xe8
00F80E  ; data: 0xf9, 0xe8
00F810  ; data: 0xf9, 0xe8
00F812  dc.w   $fa10
00F814  dc.w   $fa10
00F816  dc.w   $fa60
00F818  dc.w   $fa88
00F81A  dc.w   $fad8
00F81C  dc.w   $fb28
00F81E  ; data: 0xfb, 0xa0
00F820  ; data: 0xfb, 0xf0
00F822  dc.w   $fc68
00F824  dc.w   $fce0
00F826  dc.w   $fd58
00F828  ; data: 0xfd, 0xf8
00F82A  dc.w   $fe70
00F82C  dc.w   $fee8
00F82E  ; data: 0xff, 0x60
00F830  move.b $1db01db0(d1.l * 4), $1db01db0(d1.l * 4)
00F83E  move.b $1db01db0(d1.l * 4), $1d88ffb0(d1.l * 4)
00F84C  ; data: 0xff, 0x60
00F84E  dc.w   $ff10
00F850  dc.w   $fec0
00F852  dc.w   $fe70
00F854  dc.w   $fe20
00F856  ; data: 0xfd, 0xa8
00F858  dc.w   $fd58
00F85A  dc.w   $fce0
00F85C  dc.w   $fc90
00F85E  dc.w   $fc40
00F860  ; data: 0xfb, 0xc8
00F862  dc.w   $fb78
00F864  dc.w   $fb28
00F866  dc.w   $fad8
00F868  dc.w   $fa88
00F86A  dc.w   $fa60
00F86C  dc.w   $fa38
00F86E  dc.w   $fa10
00F870  dc.w   $fa10
00F872  ; data: 0xf9, 0xe8
00F874  dc.w   $fa10
00F876  dc.w   $fa10
00F878  dc.w   $fa38
00F87A  dc.w   $fa60
00F87C  dc.w   $fab0
00F87E  ; data: 0xfb, 0x00
00F880  dc.w   $fb50
00F882  ; data: 0xfb, 0xa0
00F884  dc.w   $fc18
00F886  dc.w   $fc90
00F888  dc.w   $fce0
00F88A  ; data: 0xfd, 0x80
00F88C  ; data: 0xfd, 0xf8
00F88E  dc.w   $fe70
00F890  dc.w   $fee8
00F892  ; data: 0xff, 0x60
00F894  ; data: 0x1d, 0x88
00F896  move.b $1db01db0(d1.l * 4), (d1.l * 4)
00F8A0  move.b $1db01db0(d1.l * 4), $1d88ffb0(d1.l * 4)
00F8AE  ; data: 0xff, 0x88
00F8B0  dc.w   $ff38
00F8B2  dc.w   $fee8
00F8B4  dc.w   $fe98
00F8B6  dc.w   $fe48
00F8B8  ; data: 0xfd, 0xf8
00F8BA  ; data: 0xfd, 0xa8
00F8BC  dc.w   $fd30
00F8BE  dc.w   $fce0
00F8C0  dc.w   $fc90
00F8C2  dc.w   $fc18
00F8C4  ; data: 0xfb, 0xc8
00F8C6  dc.w   $fb78
00F8C8  dc.w   $fb28
00F8CA  dc.w   $fad8
00F8CC  dc.w   $fab0
00F8CE  dc.w   $fa60
00F8D0  dc.w   $fa38
00F8D2  dc.w   $fa38
00F8D4  dc.w   $fa10
00F8D6  dc.w   $fa10
00F8D8  dc.w   $fa10
00F8DA  dc.w   $fa38
00F8DC  dc.w   $fa60
00F8DE  dc.w   $fa88
00F8E0  dc.w   $fab0
00F8E2  ; data: 0xfb, 0x00
00F8E4  dc.w   $fb50
00F8E6  ; data: 0xfb, 0xc8
00F8E8  dc.w   $fc18
00F8EA  dc.w   $fc90
00F8EC  ; data: 0xfd, 0x08
00F8EE  ; data: 0xfd, 0x80
00F8F0  ; data: 0xfd, 0xf8
00F8F2  dc.w   $fe70
00F8F4  dc.w   $fee8
00F8F6  ; data: 0xff, 0x60
00F8F8  ; data: 0x1d, 0x88
00F8FA  move.b $1db01db0(d1.l * 4), $1d88(a6, invalid.w)
00F906  ; data: 0x1d, 0x88
00F908  ; data: 0x1d, 0x88
00F90A  ; data: 0x1d, 0x88
00F90C  ; data: 0x1d, 0x88
00F90E  move.b -(a0), -$78(a6)
00F912  ; data: 0xff, 0x60
00F914  dc.w   $ff38
00F916  dc.w   $fee8
00F918  dc.w   $fe98
00F91A  dc.w   $fe48
00F91C  ; data: 0xfd, 0xd0
00F91E  ; data: 0xfd, 0x80
00F920  dc.w   $fd30
00F922  dc.w   $fce0
00F924  dc.w   $fc90
00F926  dc.w   $fc18
00F928  ; data: 0xfb, 0xc8
00F92A  dc.w   $fb78
00F92C  dc.w   $fb50
00F92E  ; data: 0xfb, 0x00
00F930  dc.w   $fab0
00F932  dc.w   $fa88
00F934  dc.w   $fa60
00F936  dc.w   $fa38
00F938  dc.w   $fa38
00F93A  dc.w   $fa10
00F93C  dc.w   $fa38
00F93E  dc.w   $fa38
00F940  dc.w   $fa60
00F942  dc.w   $fab0
00F944  dc.w   $fad8
00F946  dc.w   $fb28
00F948  dc.w   $fb78
00F94A  ; data: 0xfb, 0xc8
00F94C  dc.w   $fc40
00F94E  dc.w   $fc90
00F950  ; data: 0xfd, 0x08
00F952  ; data: 0xfd, 0x80
00F954  ; data: 0xfd, 0xf8
00F956  dc.w   $fe70
00F958  dc.w   $fee8
00F95A  ; data: 0xff, 0x60
00F95C  ; data: 0x1d, 0x88
00F95E  move.b $1db01db0(d1.l * 4), (a7.l * 8)
00F968  ; data: 0xff, 0xb0
00F96A  move.b -(a0), $1d60(a6)
00F96E  move.b -(a0), $1d60(a6)
00F972  ; data: 0xff, 0xb0
00F974  ; data: 0xff, 0x88
00F976  dc.w   $ff38
00F978  dc.w   $ff10
00F97A  dc.w   $fec0
00F97C  dc.w   $fe70
00F97E  dc.w   $fe20
00F980  ; data: 0xfd, 0xd0
00F982  dc.w   $fd58
00F984  ; data: 0xfd, 0x08
00F986  dc.w   $fcb8
00F988  dc.w   $fc68
00F98A  dc.w   $fc18
00F98C  ; data: 0xfb, 0xf0
00F98E  ; data: 0xfb, 0xa0
00F990  dc.w   $fb50
00F992  ; data: 0xfb, 0x00
00F994  dc.w   $fad8
00F996  dc.w   $fa88
00F998  dc.w   $fa60
00F99A  dc.w   $fa38
00F99C  dc.w   $fa38
00F99E  dc.w   $fa38
00F9A0  dc.w   $fa38
00F9A2  dc.w   $fa60
00F9A4  dc.w   $fa88
00F9A6  dc.w   $fab0
00F9A8  ; data: 0xfb, 0x00
00F9AA  dc.w   $fb50
00F9AC  ; data: 0xfb, 0xa0
00F9AE  ; data: 0xfb, 0xf0
00F9B0  dc.w   $fc40
00F9B2  dc.w   $fc90
00F9B4  ; data: 0xfd, 0x08
00F9B6  ; data: 0xfd, 0x80
00F9B8  ; data: 0xfd, 0xd0
00F9BA  dc.w   $fe48
00F9BC  dc.w   $fec0
00F9BE  ; data: 0xff, 0x60
00F9C0  ; data: 0x1d, 0x88
00F9C2  move.b $1db01db0(d1.l * 4), $ff88(a6, invalid.w)
00F9CE  ; data: 0xff, 0x88
00F9D0  ; data: 0xff, 0x88
00F9D2  ; data: 0xff, 0x88
00F9D4  ; data: 0xff, 0x88
00F9D6  ; data: 0xff, 0x88
00F9D8  ; data: 0xff, 0x60
00F9DA  dc.w   $ff38
00F9DC  dc.w   $fee8
00F9DE  dc.w   $fec0
00F9E0  dc.w   $fe48
00F9E2  ; data: 0xfd, 0xf8
00F9E4  ; data: 0xfd, 0xa8
00F9E6  dc.w   $fd58
00F9E8  dc.w   $fce0
00F9EA  dc.w   $fcb8
00F9EC  dc.w   $fc68
00F9EE  dc.w   $fc18
00F9F0  ; data: 0xfb, 0xf0
00F9F2  ; data: 0xfb, 0xa0
00F9F4  dc.w   $fb78
00F9F6  dc.w   $fb28
00F9F8  dc.w   $fad8
00F9FA  dc.w   $fab0
00F9FC  dc.w   $fa88
00F9FE  dc.w   $fa60
00FA00  dc.w   $fa38
00FA02  dc.w   $fa38
00FA04  dc.w   $fa38
00FA06  dc.w   $fa60
00FA08  dc.w   $fab0
00FA0A  dc.w   $fad8
00FA0C  dc.w   $fb28
00FA0E  dc.w   $fb78
00FA10  ; data: 0xfb, 0xc8
00FA12  dc.w   $fc18
00FA14  dc.w   $fc68
00FA16  dc.w   $fcb8
00FA18  ; data: 0xfd, 0x08
00FA1A  dc.w   $fd58
00FA1C  ; data: 0xfd, 0xd0
00FA1E  dc.w   $fe48
00FA20  dc.w   $fec0
00FA22  dc.w   $ff38
00FA24  move.b -(a0), $1db0(a6)
00FA28  move.b $1db0ff38(d1.l * 4), $ff60ff60(a6, a7.l * 8)
00FA36  ; data: 0xff, 0x60
00FA38  ; data: 0xff, 0x60
00FA3A  ; data: 0xff, 0x60
00FA3C  ; data: 0xff, 0x60
00FA3E  dc.w   $ff38
00FA40  dc.w   $fee8
00FA42  dc.w   $fe98
00FA44  dc.w   $fe48
00FA46  ; data: 0xfd, 0xd0
00FA48  ; data: 0xfd, 0x80
00FA4A  dc.w   $fd30
00FA4C  dc.w   $fce0
00FA4E  dc.w   $fc90
00FA50  dc.w   $fc68
00FA52  dc.w   $fc18
00FA54  ; data: 0xfb, 0xf0
00FA56  ; data: 0xfb, 0xc8
00FA58  dc.w   $fb78
00FA5A  dc.w   $fb50
00FA5C  ; data: 0xfb, 0x00
00FA5E  dc.w   $fab0
00FA60  dc.w   $fa88
00FA62  dc.w   $fa60
00FA64  dc.w   $fa38
00FA66  dc.w   $fa38
00FA68  dc.w   $fa60
00FA6A  dc.w   $fa88
00FA6C  dc.w   $fab0
00FA6E  ; data: 0xfb, 0x00
00FA70  dc.w   $fb50
00FA72  ; data: 0xfb, 0xa0
00FA74  ; data: 0xfb, 0xf0
00FA76  dc.w   $fc40
00FA78  dc.w   $fc68
00FA7A  dc.w   $fcb8
00FA7C  ; data: 0xfd, 0x08
00FA7E  dc.w   $fd58
00FA80  ; data: 0xfd, 0xd0
00FA82  dc.w   $fe20
00FA84  dc.w   $fec0
00FA86  dc.w   $ff38
00FA88  move.b -(a0), $1db0(a6)
00FA8C  move.b $1db0ff10(d1.l * 4), (a6, a7.l * 8)
00FA96  dc.w   $ff10
00FA98  dc.w   $ff38
00FA9A  dc.w   $ff38
00FA9C  ; data: 0xff, 0x60
00FA9E  ; data: 0xff, 0x60
00FAA0  dc.w   $ff38
00FAA2  dc.w   $ff10
00FAA4  dc.w   $fee8
00FAA6  dc.w   $fe70
00FAA8  dc.w   $fe20
00FAAA  ; data: 0xfd, 0xa8
00FAAC  dc.w   $fd58
00FAAE  ; data: 0xfd, 0x08
00FAB0  dc.w   $fcb8
00FAB2  dc.w   $fc68
00FAB4  dc.w   $fc40
00FAB6  dc.w   $fc18
00FAB8  ; data: 0xfb, 0xf0
00FABA  ; data: 0xfb, 0xc8
00FABC  ; data: 0xfb, 0xa0
00FABE  dc.w   $fb78
00FAC0  dc.w   $fb28
00FAC2  dc.w   $fad8
00FAC4  dc.w   $fa88
00FAC6  dc.w   $fa60
00FAC8  dc.w   $fa38
00FACA  dc.w   $fa38
00FACC  dc.w   $fa60
00FACE  dc.w   $fa88
00FAD0  dc.w   $fad8
00FAD2  dc.w   $fb28
00FAD4  dc.w   $fb78
00FAD6  ; data: 0xfb, 0xc8
00FAD8  dc.w   $fc18
00FADA  dc.w   $fc40
00FADC  dc.w   $fc90
00FADE  dc.w   $fcb8
00FAE0  ; data: 0xfd, 0x08
00FAE2  dc.w   $fd58
00FAE4  ; data: 0xfd, 0xa8
00FAE6  dc.w   $fe20
00FAE8  dc.w   $fe98
00FAEA  dc.w   $ff10
00FAEC  move.b -(a0), $1db0(a6)
00FAF0  move.b $1db0fec0(d1.l * 4), -$40(a6, a7.l)
00FAFA  dc.w   $fee8
00FAFC  dc.w   $ff10
00FAFE  dc.w   $ff10
00FB00  dc.w   $ff38
00FB02  dc.w   $ff38
00FB04  dc.w   $ff38
00FB06  dc.w   $ff10
00FB08  dc.w   $fec0
00FB0A  dc.w   $fe70
00FB0C  ; data: 0xfd, 0xf8
00FB0E  ; data: 0xfd, 0x80
00FB10  dc.w   $fd30
00FB12  dc.w   $fcb8
00FB14  dc.w   $fc90
00FB16  dc.w   $fc40
00FB18  dc.w   $fc40
00FB1A  dc.w   $fc18
00FB1C  dc.w   $fc18
00FB1E  ; data: 0xfb, 0xf0
00FB20  ; data: 0xfb, 0xc8
00FB22  dc.w   $fb78
00FB24  dc.w   $fb50
00FB26  ; data: 0xfb, 0x00
00FB28  dc.w   $fab0
00FB2A  dc.w   $fa60
00FB2C  dc.w   $fa38
00FB2E  dc.w   $fa38
00FB30  dc.w   $fa60
00FB32  dc.w   $fa88
00FB34  dc.w   $fad8
00FB36  dc.w   $fb28
00FB38  ; data: 0xfb, 0xa0
00FB3A  ; data: 0xfb, 0xf0
00FB3C  dc.w   $fc40
00FB3E  dc.w   $fc68
00FB40  dc.w   $fcb8
00FB42  dc.w   $fce0
00FB44  ; data: 0xfd, 0x08
00FB46  dc.w   $fd30
00FB48  ; data: 0xfd, 0xa8
00FB4A  ; data: 0xfd, 0xf8
00FB4C  dc.w   $fe70
00FB4E  dc.w   $ff10
00FB50  ; data: 0xff, 0xb0
00FB52  move.b $1db01db0(d1.l * 4), -$68(a6, a7.l)
00FB5C  dc.w   $fe98
00FB5E  dc.w   $fe98
00FB60  dc.w   $fec0
00FB62  dc.w   $fee8
00FB64  dc.w   $ff10
00FB66  dc.w   $ff38
00FB68  dc.w   $ff38
00FB6A  dc.w   $ff10
00FB6C  dc.w   $fec0
00FB6E  dc.w   $fe70
00FB70  ; data: 0xfd, 0xf8
00FB72  dc.w   $fd58
00FB74  ; data: 0xfd, 0x08
00FB76  dc.w   $fc90
00FB78  dc.w   $fc68
00FB7A  dc.w   $fc40
00FB7C  dc.w   $fc18
00FB7E  dc.w   $fc18
00FB80  dc.w   $fc18
00FB82  dc.w   $fc18
00FB84  ; data: 0xfb, 0xf0
00FB86  ; data: 0xfb, 0xa0
00FB88  dc.w   $fb50
00FB8A  ; data: 0xfb, 0x00
00FB8C  dc.w   $fab0
00FB8E  dc.w   $fa60
00FB90  dc.w   $fa38
00FB92  dc.w   $fa38
00FB94  dc.w   $fa60
00FB96  dc.w   $fa88
00FB98  ; data: 0xfb, 0x00
00FB9A  dc.w   $fb50
00FB9C  ; data: 0xfb, 0xc8
00FB9E  dc.w   $fc18
00FBA0  dc.w   $fc68
00FBA2  dc.w   $fc90
00FBA4  dc.w   $fcb8
00FBA6  dc.w   $fce0
00FBA8  ; data: 0xfd, 0x08
00FBAA  dc.w   $fd30
00FBAC  ; data: 0xfd, 0x80
00FBAE  ; data: 0xfd, 0xf8
00FBB0  dc.w   $fe70
00FBB2  dc.w   $ff10
00FBB4  ; data: 0xff, 0xb0
00FBB6  move.b $1db01db0(d1.l * 4), $48(a6, a7.l)
00FBC0  dc.w   $fe48
00FBC2  dc.w   $fe70
00FBC4  dc.w   $fe98
00FBC6  dc.w   $fec0
00FBC8  dc.w   $ff10
00FBCA  dc.w   $ff38
00FBCC  dc.w   $ff38
00FBCE  dc.w   $ff10
00FBD0  dc.w   $fec0
00FBD2  dc.w   $fe48
00FBD4  ; data: 0xfd, 0xd0
00FBD6  dc.w   $fd30
00FBD8  dc.w   $fcb8
00FBDA  dc.w   $fc68
00FBDC  dc.w   $fc18
00FBDE  dc.w   $fc18
00FBE0  dc.w   $fc18
00FBE2  dc.w   $fc18
00FBE4  dc.w   $fc40
00FBE6  dc.w   $fc40
00FBE8  dc.w   $fc18
00FBEA  ; data: 0xfb, 0xc8
00FBEC  dc.w   $fb78
00FBEE  dc.w   $fb28
00FBF0  dc.w   $fab0
00FBF2  dc.w   $fa60
00FBF4  dc.w   $fa38
00FBF6  dc.w   $fa38
00FBF8  dc.w   $fa38
00FBFA  dc.w   $fa88
00FBFC  ; data: 0xfb, 0x00
00FBFE  dc.w   $fb78
00FC00  ; data: 0xfb, 0xf0
00FC02  dc.w   $fc68
00FC04  dc.w   $fc90
00FC06  dc.w   $fce0
00FC08  dc.w   $fce0
00FC0A  dc.w   $fce0
00FC0C  ; data: 0xfd, 0x08
00FC0E  dc.w   $fd30
00FC10  dc.w   $fd58
00FC12  ; data: 0xfd, 0xd0
00FC14  dc.w   $fe48
00FC16  dc.w   $fee8
00FC18  ; data: 0xff, 0xb0
00FC1A  move.b $1db01db0(d1.l * 4), $20(a6, a7.l)
00FC24  dc.w   $fe20
00FC26  dc.w   $fe20
00FC28  dc.w   $fe70
00FC2A  dc.w   $fe98
00FC2C  dc.w   $fee8
00FC2E  dc.w   $ff38
00FC30  dc.w   $ff38
00FC32  dc.w   $ff10
00FC34  dc.w   $fec0
00FC36  dc.w   $fe48
00FC38  ; data: 0xfd, 0xa8
00FC3A  dc.w   $fd30
00FC3C  dc.w   $fc90
00FC3E  dc.w   $fc40
00FC40  ; data: 0xfb, 0xf0
00FC42  ; data: 0xfb, 0xf0
00FC44  ; data: 0xfb, 0xf0
00FC46  dc.w   $fc18
00FC48  dc.w   $fc40
00FC4A  dc.w   $fc40
00FC4C  dc.w   $fc40
00FC4E  ; data: 0xfb, 0xf0
00FC50  ; data: 0xfb, 0xa0
00FC52  dc.w   $fb28
00FC54  dc.w   $fab0
00FC56  dc.w   $fa60
00FC58  dc.w   $fa38
00FC5A  dc.w   $fa10
00FC5C  dc.w   $fa38
00FC5E  dc.w   $fab0
00FC60  dc.w   $fb28
00FC62  ; data: 0xfb, 0xa0
00FC64  dc.w   $fc18
00FC66  dc.w   $fc90
00FC68  dc.w   $fce0
00FC6A  ; data: 0xfd, 0x08
00FC6C  ; data: 0xfd, 0x08
00FC6E  ; data: 0xfd, 0x08
00FC70  ; data: 0xfd, 0x08
00FC72  ; data: 0xfd, 0x08
00FC74  dc.w   $fd30
00FC76  ; data: 0xfd, 0xa8
00FC78  dc.w   $fe20
00FC7A  dc.w   $fee8
00FC7C  ; data: 0xff, 0x88
00FC7E  move.b $1db01db0(d1.l * 4), (invalid.w)
00FC88  ; data: 0xfd, 0xd0
00FC8A  ; data: 0xfd, 0xf8
00FC8C  dc.w   $fe20
00FC8E  dc.w   $fe98
00FC90  dc.w   $fee8
00FC92  dc.w   $ff10
00FC94  dc.w   $ff38
00FC96  dc.w   $ff10
00FC98  dc.w   $fec0
00FC9A  dc.w   $fe48
00FC9C  ; data: 0xfd, 0xa8
00FC9E  ; data: 0xfd, 0x08
00FCA0  dc.w   $fc68
00FCA2  ; data: 0xfb, 0xf0
00FCA4  ; data: 0xfb, 0xc8
00FCA6  ; data: 0xfb, 0xc8
00FCA8  ; data: 0xfb, 0xf0
00FCAA  dc.w   $fc18
00FCAC  dc.w   $fc68
00FCAE  dc.w   $fc68
00FCB0  dc.w   $fc68
00FCB2  dc.w   $fc18
00FCB4  ; data: 0xfb, 0xc8
00FCB6  dc.w   $fb50
00FCB8  dc.w   $fad8
00FCBA  dc.w   $fa60
00FCBC  dc.w   $fa10
00FCBE  dc.w   $fa10
00FCC0  dc.w   $fa38
00FCC2  dc.w   $fab0
00FCC4  dc.w   $fb28
00FCC6  ; data: 0xfb, 0xc8
00FCC8  dc.w   $fc40
00FCCA  dc.w   $fcb8
00FCCC  ; data: 0xfd, 0x08
00FCCE  dc.w   $fd30
00FCD0  dc.w   $fd30
00FCD2  ; data: 0xfd, 0x08
00FCD4  dc.w   $fce0
00FCD6  dc.w   $fce0
00FCD8  dc.w   $fd30
00FCDA  ; data: 0xfd, 0x80
00FCDC  dc.w   $fe20
00FCDE  dc.w   $fec0
00FCE0  ; data: 0xff, 0x88
00FCE2  move.b $1db01db0(d1.l * 4), $fd80(a7.l * 4)
00FCEE  ; data: 0xfd, 0xa8
00FCF0  ; data: 0xfd, 0xf8
00FCF2  dc.w   $fe70
00FCF4  dc.w   $fec0
00FCF6  dc.w   $ff10
00FCF8  dc.w   $ff38
00FCFA  dc.w   $ff10
00FCFC  dc.w   $fec0
00FCFE  dc.w   $fe20
00FD00  ; data: 0xfd, 0x80
00FD02  dc.w   $fce0
00FD04  dc.w   $fc40
00FD06  ; data: 0xfb, 0xc8
00FD08  ; data: 0xfb, 0xa0
00FD0A  ; data: 0xfb, 0xa0
00FD0C  ; data: 0xfb, 0xc8
00FD0E  dc.w   $fc18
00FD10  dc.w   $fc68
00FD12  dc.w   $fc90
00FD14  dc.w   $fc90
00FD16  dc.w   $fc40
00FD18  ; data: 0xfb, 0xf0
00FD1A  dc.w   $fb50
00FD1C  dc.w   $fad8
00FD1E  dc.w   $fa60
00FD20  dc.w   $fa10
00FD22  ; data: 0xf9, 0xe8
00FD24  dc.w   $fa38
00FD26  dc.w   $fab0
00FD28  dc.w   $fb28
00FD2A  ; data: 0xfb, 0xf0
00FD2C  dc.w   $fc90
00FD2E  ; data: 0xfd, 0x08
00FD30  dc.w   $fd30
00FD32  dc.w   $fd58
00FD34  dc.w   $fd30
00FD36  ; data: 0xfd, 0x08
00FD38  dc.w   $fce0
00FD3A  dc.w   $fce0
00FD3C  ; data: 0xfd, 0x08
00FD3E  dc.w   $fd58
00FD40  ; data: 0xfd, 0xf8
00FD42  dc.w   $fec0
00FD44  ; data: 0xff, 0x88
00FD46  move.b $1db01db0(d1.l * 4), (a6, invalid.w)
00FD50  dc.w   $fd58
00FD52  dc.w   $fd58
00FD54  ; data: 0xfd, 0xd0
00FD56  dc.w   $fe48
00FD58  dc.w   $fec0
00FD5A  dc.w   $ff10
00FD5C  dc.w   $ff38
00FD5E  dc.w   $ff10
00FD60  dc.w   $fec0
00FD62  dc.w   $fe20
00FD64  dc.w   $fd58
00FD66  dc.w   $fcb8
00FD68  ; data: 0xfb, 0xf0
00FD6A  ; data: 0xfb, 0xa0
00FD6C  dc.w   $fb78
00FD6E  dc.w   $fb78
00FD70  ; data: 0xfb, 0xc8
00FD72  dc.w   $fc18
00FD74  dc.w   $fc68
00FD76  dc.w   $fcb8
00FD78  dc.w   $fcb8
00FD7A  dc.w   $fc90
00FD7C  dc.w   $fc18
00FD7E  dc.w   $fb78
00FD80  dc.w   $fad8
00FD82  dc.w   $fa60
00FD84  ; data: 0xf9, 0xe8
00FD86  ; data: 0xf9, 0xe8
00FD88  dc.w   $fa38
00FD8A  dc.w   $fab0
00FD8C  dc.w   $fb50
00FD8E  ; data: 0xfb, 0xf0
00FD90  dc.w   $fcb8
00FD92  dc.w   $fd30
00FD94  ; data: 0xfd, 0x80
00FD96  ; data: 0xfd, 0x80
00FD98  dc.w   $fd58
00FD9A  ; data: 0xfd, 0x08
00FD9C  dc.w   $fce0
00FD9E  dc.w   $fcb8
00FDA0  dc.w   $fce0
00FDA2  dc.w   $fd30
00FDA4  ; data: 0xfd, 0xd0
00FDA6  dc.w   $fe98
00FDA8  ; data: 0xff, 0x88
00FDAA  move.b $1db01db0(d1.l * 4), $fd08fd30(a6, a7.l * 4)
00FDB8  ; data: 0xfd, 0x80
00FDBA  dc.w   $fe20
00FDBC  dc.w   $fe98
00FDBE  dc.w   $ff10
00FDC0  dc.w   $ff38
00FDC2  dc.w   $ff10
00FDC4  dc.w   $fec0
00FDC6  dc.w   $fe20
00FDC8  dc.w   $fd58
00FDCA  dc.w   $fc90
00FDCC  ; data: 0xfb, 0xc8
00FDCE  dc.w   $fb50
00FDD0  dc.w   $fb28
00FDD2  dc.w   $fb50
00FDD4  ; data: 0xfb, 0xa0
00FDD6  dc.w   $fc18
00FDD8  dc.w   $fc90
00FDDA  dc.w   $fce0
00FDDC  dc.w   $fce0
00FDDE  dc.w   $fcb8
00FDE0  dc.w   $fc40
00FDE2  dc.w   $fb78
00FDE4  dc.w   $fad8
00FDE6  dc.w   $fa38
00FDE8  ; data: 0xf9, 0xe8
00FDEA  ; data: 0xf9, 0xe8
00FDEC  dc.w   $fa10
00FDEE  dc.w   $fab0
00FDF0  dc.w   $fb50
00FDF2  dc.w   $fc18
00FDF4  dc.w   $fce0
00FDF6  dc.w   $fd58
00FDF8  ; data: 0xfd, 0xa8
00FDFA  ; data: 0xfd, 0xa8
00FDFC  ; data: 0xfd, 0x80
00FDFE  dc.w   $fd30
00FE00  dc.w   $fce0
00FE02  dc.w   $fcb8
00FE04  dc.w   $fcb8
00FE06  ; data: 0xfd, 0x08
00FE08  ; data: 0xfd, 0xa8
00FE0A  dc.w   $fe98
00FE0C  ; data: 0xff, 0x88
00FE0E  move.b $1db01db0(d1.l * 4), -$20(a6, a7.l)
00FE18  dc.w   $fcb8
00FE1A  dc.w   $fce0
00FE1C  dc.w   $fd58
00FE1E  ; data: 0xfd, 0xf8
00FE20  dc.w   $fe98
00FE22  dc.w   $ff10
00FE24  dc.w   $ff38
00FE26  dc.w   $ff38
00FE28  dc.w   $fec0
00FE2A  ; data: 0xfd, 0xf8
00FE2C  dc.w   $fd30
00FE2E  dc.w   $fc68
00FE30  ; data: 0xfb, 0xa0
00FE32  dc.w   $fb28
00FE34  ; data: 0xfb, 0x00
00FE36  dc.w   $fb28
00FE38  ; data: 0xfb, 0xa0
00FE3A  dc.w   $fc18
00FE3C  dc.w   $fc90
00FE3E  ; data: 0xfd, 0x08
00FE40  ; data: 0xfd, 0x08
00FE42  dc.w   $fce0
00FE44  dc.w   $fc40
00FE46  ; data: 0xfb, 0xa0
00FE48  dc.w   $fad8
00FE4A  dc.w   $fa38
00FE4C  ; data: 0xf9, 0xe8
00FE4E  ; data: 0xf9, 0xc0
00FE50  dc.w   $fa10
00FE52  dc.w   $fab0
00FE54  dc.w   $fb78
00FE56  dc.w   $fc40
00FE58  ; data: 0xfd, 0x08
00FE5A  ; data: 0xfd, 0xa8
00FE5C  ; data: 0xfd, 0xd0
00FE5E  ; data: 0xfd, 0xd0
00FE60  ; data: 0xfd, 0x80
00FE62  dc.w   $fd30
00FE64  dc.w   $fcb8
00FE66  dc.w   $fc90
00FE68  dc.w   $fc90
00FE6A  dc.w   $fce0
00FE6C  ; data: 0xfd, 0xa8
00FE6E  dc.w   $fe70
00FE70  ; data: 0xff, 0x88
00FE72  move.b $1db01db0(d1.l * 4), -$48(a6, a7.l)
00FE7C  dc.w   $fc90
00FE7E  dc.w   $fcb8
00FE80  dc.w   $fd30
00FE82  ; data: 0xfd, 0xd0
00FE84  dc.w   $fe70
00FE86  dc.w   $ff10
00FE88  dc.w   $ff38
00FE8A  dc.w   $ff38
00FE8C  dc.w   $fec0
00FE8E  ; data: 0xfd, 0xf8
00FE90  ; data: 0xfd, 0x08
00FE92  dc.w   $fc40
00FE94  dc.w   $fb78
00FE96  ; data: 0xfb, 0x00
00FE98  dc.w   $fad8
00FE9A  ; data: 0xfb, 0x00
00FE9C  dc.w   $fb78
00FE9E  dc.w   $fc18
00FEA0  dc.w   $fcb8
00FEA2  ; data: 0xfd, 0x08
00FEA4  dc.w   $fd30
00FEA6  ; data: 0xfd, 0x08
00FEA8  dc.w   $fc68
00FEAA  ; data: 0xfb, 0xc8
00FEAC  dc.w   $fad8
00FEAE  dc.w   $fa38
00FEB0  ; data: 0xf9, 0xc0
00FEB2  ; data: 0xf9, 0xc0
00FEB4  dc.w   $fa10
00FEB6  dc.w   $fab0
00FEB8  dc.w   $fb78
00FEBA  dc.w   $fc68
00FEBC  dc.w   $fd30
00FEBE  ; data: 0xfd, 0xd0
00FEC0  dc.w   $fe20
00FEC2  ; data: 0xfd, 0xf8
00FEC4  ; data: 0xfd, 0xa8
00FEC6  dc.w   $fd30
00FEC8  dc.w   $fcb8
00FECA  dc.w   $fc68
00FECC  dc.w   $fc68
00FECE  dc.w   $fce0
00FED0  ; data: 0xfd, 0x80
00FED2  dc.w   $fe70
00FED4  ; data: 0xff, 0x88
00FED6  move.b $1db01db0(d1.l * 4), $68(a6, a7.l)
00FEE0  dc.w   $fc40
00FEE2  dc.w   $fc68
00FEE4  ; data: 0xfd, 0x08
00FEE6  ; data: 0xfd, 0xa8
00FEE8  dc.w   $fe70
00FEEA  dc.w   $ff10
00FEEC  dc.w   $ff38
00FEEE  dc.w   $ff38
00FEF0  dc.w   $fec0
00FEF2  ; data: 0xfd, 0xf8
00FEF4  ; data: 0xfd, 0x08
00FEF6  dc.w   $fc18
00FEF8  dc.w   $fb50
00FEFA  dc.w   $fab0
00FEFC  dc.w   $fab0
00FEFE  dc.w   $fad8
00FF00  dc.w   $fb78
00FF02  dc.w   $fc18
00FF04  dc.w   $fcb8
00FF06  dc.w   $fd30
00FF08  dc.w   $fd58
00FF0A  dc.w   $fd30
00FF0C  dc.w   $fc90
00FF0E  ; data: 0xfb, 0xc8
00FF10  ; data: 0xfb, 0x00
00FF12  dc.w   $fa38
00FF14  ; data: 0xf9, 0xc0
00FF16  ; data: 0xf9, 0x98
00FF18  ; data: 0xf9, 0xe8
00FF1A  dc.w   $fab0
00FF1C  dc.w   $fb78
00FF1E  dc.w   $fc90
00FF20  dc.w   $fd58
00FF22  ; data: 0xfd, 0xf8
00FF24  dc.w   $fe48
00FF26  dc.w   $fe20
00FF28  ; data: 0xfd, 0xd0
00FF2A  dc.w   $fd30
00FF2C  dc.w   $fcb8
00FF2E  dc.w   $fc68
00FF30  dc.w   $fc68
00FF32  dc.w   $fcb8
00FF34  dc.w   $fd58
00FF36  dc.w   $fe70
00FF38  ; data: 0xff, 0x88
00FF3A  move.b $1db01db0(d1.l * 4), $40(a6, a7.l)
00FF44  dc.w   $fc18
00FF46  dc.w   $fc40
00FF48  dc.w   $fcb8
00FF4A  ; data: 0xfd, 0x80
00FF4C  dc.w   $fe48
00FF4E  dc.w   $fee8
00FF50  dc.w   $ff38
00FF52  dc.w   $ff38
00FF54  dc.w   $fec0
00FF56  ; data: 0xfd, 0xf8
00FF58  dc.w   $fce0
00FF5A  ; data: 0xfb, 0xf0
00FF5C  ; data: 0xfb, 0x00
00FF5E  dc.w   $fa88
00FF60  dc.w   $fa88
00FF62  dc.w   $fad8
00FF64  dc.w   $fb50
00FF66  dc.w   $fc18
00FF68  dc.w   $fce0
00FF6A  dc.w   $fd58
00FF6C  ; data: 0xfd, 0x80
00FF6E  dc.w   $fd30
00FF70  dc.w   $fcb8
00FF72  ; data: 0xfb, 0xc8
00FF74  ; data: 0xfb, 0x00
00FF76  dc.w   $fa38
00FF78  ; data: 0xf9, 0xc0
00FF7A  ; data: 0xf9, 0x98
00FF7C  ; data: 0xf9, 0xe8
00FF7E  dc.w   $fab0
00FF80  ; data: 0xfb, 0xa0
00FF82  dc.w   $fc90
00FF84  ; data: 0xfd, 0x80
00FF86  dc.w   $fe20
00FF88  dc.w   $fe70
00FF8A  dc.w   $fe48
00FF8C  ; data: 0xfd, 0xd0
00FF8E  dc.w   $fd58
00FF90  dc.w   $fcb8
00FF92  dc.w   $fc40
00FF94  dc.w   $fc40
00FF96  dc.w   $fc90
00FF98  dc.w   $fd58
00FF9A  dc.w   $fe48
00FF9C  ; data: 0xff, 0x88
00FF9E  move.b $1db01db0(d1.l * 4), $18(a6, a7.l)
00FFA8  ; data: 0xfb, 0xc8
00FFAA  dc.w   $fc18
00FFAC  dc.w   $fc90
00FFAE  ; data: 0xfd, 0x80
00FFB0  dc.w   $fe48
00FFB2  dc.w   $fee8
00FFB4  ; data: 0xff, 0x60
00FFB6  dc.w   $ff38
00FFB8  dc.w   $fec0
00FFBA  ; data: 0xfd, 0xd0
00FFBC  dc.w   $fce0
00FFBE  ; data: 0xfb, 0xc8
00FFC0  dc.w   $fad8
00FFC2  dc.w   $fa60
00FFC4  dc.w   $fa60
00FFC6  dc.w   $fab0
00FFC8  dc.w   $fb50
00FFCA  dc.w   $fc18
00FFCC  dc.w   $fce0
00FFCE  ; data: 0xfd, 0x80
00FFD0  ; data: 0xfd, 0xa8
00FFD2  dc.w   $fd58
00FFD4  dc.w   $fcb8
00FFD6  ; data: 0xfb, 0xf0
00FFD8  ; data: 0xfb, 0x00
00FFDA  dc.w   $fa38
00FFDC  ; data: 0xf9, 0x98
00FFDE  ; data: 0xf9, 0x98
00FFE0  ; data: 0xf9, 0xe8
00FFE2  dc.w   $fab0
00FFE4  ; data: 0xfb, 0xa0
00FFE6  dc.w   $fcb8
00FFE8  ; data: 0xfd, 0xa8
00FFEA  dc.w   $fe48
00FFEC  dc.w   $fe98
00FFEE  dc.w   $fe70
00FFF0  ; data: 0xfd, 0xf8
00FFF2  dc.w   $fd58
00FFF4  dc.w   $fcb8
00FFF6  dc.w   $fc40
00FFF8  dc.w   $fc18
00FFFA  dc.w   $fc68
00FFFC  dc.w   $fd30
00FFFE  dc.w   $fe48
010000  ; data: 0xff, 0x60
010002  move.b $1db01db0(d1.l * 4), (invalid.w)
01000C  ; data: 0xfb, 0xa0
01000E  ; data: 0xfb, 0xc8
010010  dc.w   $fc68
010012  dc.w   $fd58
010014  dc.w   $fe20
010016  dc.w   $fee8
010018  dc.w   $ff38
01001A  dc.w   $ff38
01001C  dc.w   $fec0
01001E  ; data: 0xfd, 0xd0
010020  dc.w   $fcb8
010022  ; data: 0xfb, 0xa0
010024  dc.w   $fab0
010026  dc.w   $fa38
010028  dc.w   $fa38
01002A  dc.w   $fa88
01002C  dc.w   $fb50
01002E  dc.w   $fc18
010030  dc.w   $fce0
010032  ; data: 0xfd, 0x80
010034  ; data: 0xfd, 0xd0
010036  ; data: 0xfd, 0x80
010038  dc.w   $fce0
01003A  ; data: 0xfb, 0xf0
01003C  ; data: 0xfb, 0x00
01003E  dc.w   $fa10
010040  ; data: 0xf9, 0x98
010042  dc.w   $f970
010044  ; data: 0xf9, 0xe8
010046  dc.w   $fab0
010048  ; data: 0xfb, 0xa0
01004A  dc.w   $fce0
01004C  ; data: 0xfd, 0xd0
01004E  dc.w   $fe70
010050  dc.w   $fec0
010052  dc.w   $fe98
010054  dc.w   $fe20
010056  dc.w   $fd58
010058  dc.w   $fcb8
01005A  dc.w   $fc18
01005C  dc.w   $fc18
01005E  dc.w   $fc68
010060  ; data: 0xfd, 0x08
010062  dc.w   $fe20
010064  ; data: 0xff, 0x60
010066  move.b $1db01db0(d1.l * 4), $fb78(a7.l * 2)
010072  ; data: 0xfb, 0xa0
010074  dc.w   $fc40
010076  dc.w   $fd30
010078  dc.w   $fe20
01007A  dc.w   $fee8
01007C  dc.w   $ff38
01007E  dc.w   $ff38
010080  dc.w   $fec0
010082  ; data: 0xfd, 0xd0
010084  dc.w   $fcb8
010086  dc.w   $fb78
010088  dc.w   $fa88
01008A  dc.w   $fa10
01008C  dc.w   $fa10
01008E  dc.w   $fa60
010090  dc.w   $fb28
010092  dc.w   $fc18
010094  ; data: 0xfd, 0x08
010096  ; data: 0xfd, 0xa8
010098  ; data: 0xfd, 0xd0
01009A  ; data: 0xfd, 0xa8
01009C  ; data: 0xfd, 0x08
01009E  dc.w   $fc18
0100A0  ; data: 0xfb, 0x00
0100A2  dc.w   $fa10
0100A4  ; data: 0xf9, 0x98
0100A6  dc.w   $f970
0100A8  ; data: 0xf9, 0xc0
0100AA  dc.w   $fab0
0100AC  ; data: 0xfb, 0xc8
0100AE  dc.w   $fce0
0100B0  ; data: 0xfd, 0xf8
0100B2  dc.w   $fe98
0100B4  dc.w   $fee8
0100B6  dc.w   $fec0
0100B8  dc.w   $fe20
0100BA  dc.w   $fd58
0100BC  dc.w   $fc90
0100BE  dc.w   $fc18
0100C0  ; data: 0xfb, 0xf0
0100C2  dc.w   $fc40
0100C4  ; data: 0xfd, 0x08
0100C6  dc.w   $fe20
0100C8  ; data: 0xff, 0x60
0100CA  move.b $1db01db0(d1.l * 4), $fb50fb78(a6, invalid.w)
0100D8  dc.w   $fc18
0100DA  ; data: 0xfd, 0x08
0100DC  ; data: 0xfd, 0xf8
0100DE  dc.w   $fee8
0100E0  dc.w   $ff38
0100E2  dc.w   $ff38
0100E4  dc.w   $fe98
0100E6  ; data: 0xfd, 0xa8
0100E8  dc.w   $fc90
0100EA  dc.w   $fb78
0100EC  dc.w   $fa88
0100EE  ; data: 0xf9, 0xe8
0100F0  ; data: 0xf9, 0xe8
0100F2  dc.w   $fa60
0100F4  dc.w   $fb28
0100F6  dc.w   $fc18
0100F8  ; data: 0xfd, 0x08
0100FA  ; data: 0xfd, 0xa8
0100FC  ; data: 0xfd, 0xf8
0100FE  ; data: 0xfd, 0xa8
010100  ; data: 0xfd, 0x08
010102  dc.w   $fc18
010104  ; data: 0xfb, 0x00
010106  dc.w   $fa10
010108  ; data: 0xf9, 0x98
01010A  dc.w   $f970
01010C  ; data: 0xf9, 0xc0
01010E  dc.w   $fab0
010110  ; data: 0xfb, 0xc8
010112  ; data: 0xfd, 0x08
010114  dc.w   $fe20
010116  dc.w   $fec0
010118  dc.w   $ff10
01011A  dc.w   $fec0
01011C  dc.w   $fe48
01011E  dc.w   $fd58
010120  dc.w   $fc90
010122  dc.w   $fc18
010124  ; data: 0xfb, 0xf0
010126  dc.w   $fc40
010128  ; data: 0xfd, 0x08
01012A  dc.w   $fe20
01012C  ; data: 0xff, 0x60
01012E  move.b $1db01db0(d1.l * 4), (a6, invalid.w)
010138  dc.w   $fb28
01013A  dc.w   $fb50
01013C  dc.w   $fc18
01013E  ; data: 0xfd, 0x08
010140  ; data: 0xfd, 0xf8
010142  dc.w   $fec0
010144  dc.w   $ff38
010146  dc.w   $ff38
010148  dc.w   $fe98
01014A  ; data: 0xfd, 0xa8
01014C  dc.w   $fc68
01014E  dc.w   $fb50
010150  dc.w   $fa60
010152  ; data: 0xf9, 0xc0
010154  ; data: 0xf9, 0xc0
010156  dc.w   $fa38
010158  ; data: 0xfb, 0x00
01015A  dc.w   $fc18
01015C  ; data: 0xfd, 0x08
01015E  ; data: 0xfd, 0xd0
010160  ; data: 0xfd, 0xf8
010162  ; data: 0xfd, 0xd0
010164  dc.w   $fd30
010166  dc.w   $fc18
010168  ; data: 0xfb, 0x00
01016A  dc.w   $fa10
01016C  dc.w   $f970
01016E  dc.w   $f970
010170  ; data: 0xf9, 0xc0
010172  dc.w   $fab0
010174  ; data: 0xfb, 0xc8
010176  ; data: 0xfd, 0x08
010178  dc.w   $fe20
01017A  dc.w   $fee8
01017C  dc.w   $ff10
01017E  dc.w   $fee8
010180  dc.w   $fe48
010182  ; data: 0xfd, 0x80
010184  dc.w   $fc90
010186  ; data: 0xfb, 0xf0
010188  ; data: 0xfb, 0xc8
01018A  dc.w   $fc18
01018C  dc.w   $fce0
01018E  dc.w   $fe20
010190  ; data: 0xff, 0x60
010192  move.b $1db01db0(d1.l * 4), $fb00(a6, a7.l * 2)
01019E  dc.w   $fb28
0101A0  ; data: 0xfb, 0xf0
0101A2  dc.w   $fce0
0101A4  ; data: 0xfd, 0xd0
0101A6  dc.w   $fec0
0101A8  dc.w   $ff38
0101AA  dc.w   $ff10
0101AC  dc.w   $fe98
0101AE  ; data: 0xfd, 0xa8
0101B0  dc.w   $fc68
0101B2  dc.w   $fb28
0101B4  dc.w   $fa38
0101B6  ; data: 0xf9, 0xc0
0101B8  ; data: 0xf9, 0xc0
0101BA  dc.w   $fa38
0101BC  ; data: 0xfb, 0x00
0101BE  dc.w   $fc18
0101C0  ; data: 0xfd, 0x08
0101C2  ; data: 0xfd, 0xd0
0101C4  dc.w   $fe20
0101C6  ; data: 0xfd, 0xd0
0101C8  dc.w   $fd30
0101CA  dc.w   $fc40
0101CC  dc.w   $fb28
0101CE  dc.w   $fa10
0101D0  dc.w   $f970
0101D2  dc.w   $f970
0101D4  ; data: 0xf9, 0xc0
0101D6  dc.w   $fab0
0101D8  ; data: 0xfb, 0xf0
0101DA  dc.w   $fd30
0101DC  dc.w   $fe48
0101DE  dc.w   $fee8
0101E0  dc.w   $ff38
0101E2  dc.w   $ff10
0101E4  dc.w   $fe48
0101E6  ; data: 0xfd, 0x80
0101E8  dc.w   $fc90
0101EA  ; data: 0xfb, 0xf0
0101EC  ; data: 0xfb, 0xc8
0101EE  dc.w   $fc18
0101F0  dc.w   $fce0
0101F2  ; data: 0xfd, 0xf8
0101F4  ; data: 0xff, 0x60
0101F6  move.b $1db01db0(d1.l * 4), $fad8(a6, a7.l * 2)
010202  dc.w   $fb28
010204  ; data: 0xfb, 0xc8
010206  dc.w   $fcb8
010208  ; data: 0xfd, 0xd0
01020A  dc.w   $fe98
01020C  dc.w   $ff10
01020E  dc.w   $ff10
010210  dc.w   $fe98
010212  ; data: 0xfd, 0x80
010214  dc.w   $fc40
010216  dc.w   $fb28
010218  dc.w   $fa38
01021A  ; data: 0xf9, 0x98
01021C  ; data: 0xf9, 0x98
01021E  dc.w   $fa10
010220  ; data: 0xfb, 0x00
010222  dc.w   $fc18
010224  ; data: 0xfd, 0x08
010226  ; data: 0xfd, 0xd0
010228  dc.w   $fe20
01022A  ; data: 0xfd, 0xf8
01022C  dc.w   $fd30
01022E  dc.w   $fc40
010230  dc.w   $fb28
010232  dc.w   $fa10
010234  ; data: 0xf9, 0x98
010236  dc.w   $f970
010238  ; data: 0xf9, 0xc0
01023A  dc.w   $fab0
01023C  ; data: 0xfb, 0xf0
01023E  dc.w   $fd30
010240  dc.w   $fe48
010242  dc.w   $ff10
010244  ; data: 0xff, 0x60
010246  dc.w   $ff10
010248  dc.w   $fe70
01024A  ; data: 0xfd, 0x80
01024C  dc.w   $fc90
01024E  ; data: 0xfb, 0xf0
010250  ; data: 0xfb, 0xc8
010252  dc.w   $fc18
010254  dc.w   $fce0
010256  ; data: 0xfd, 0xf8
010258  ; data: 0xff, 0x60
01025A  move.b $1db01db0(d1.l * 4), (a6, a7.l * 2)
010264  dc.w   $fab0
010266  ; data: 0xfb, 0x00
010268  ; data: 0xfb, 0xa0
01026A  dc.w   $fcb8
01026C  ; data: 0xfd, 0xa8
01026E  dc.w   $fe98
010270  dc.w   $ff10
010272  dc.w   $ff10
010274  dc.w   $fe70
010276  ; data: 0xfd, 0x80
010278  dc.w   $fc40
01027A  ; data: 0xfb, 0x00
01027C  dc.w   $fa10
01027E  ; data: 0xf9, 0x98
010280  ; data: 0xf9, 0x98
010282  dc.w   $fa10
010284  ; data: 0xfb, 0x00
010286  dc.w   $fc18
010288  ; data: 0xfd, 0x08
01028A  ; data: 0xfd, 0xd0
01028C  dc.w   $fe20
01028E  ; data: 0xfd, 0xf8
010290  dc.w   $fd30
010292  dc.w   $fc40
010294  dc.w   $fb28
010296  dc.w   $fa38
010298  ; data: 0xf9, 0x98
01029A  dc.w   $f970
01029C  ; data: 0xf9, 0xe8
01029E  dc.w   $fab0
0102A0  ; data: 0xfb, 0xf0
0102A2  dc.w   $fd30
0102A4  dc.w   $fe70
0102A6  dc.w   $ff10
0102A8  ; data: 0xff, 0x60
0102AA  dc.w   $ff10
0102AC  dc.w   $fe70
0102AE  ; data: 0xfd, 0x80
0102B0  dc.w   $fc90
0102B2  ; data: 0xfb, 0xf0
0102B4  ; data: 0xfb, 0xc8
0102B6  ; data: 0xfb, 0xf0
0102B8  dc.w   $fcb8
0102BA  ; data: 0xfd, 0xf8
0102BC  ; data: 0xff, 0x60
0102BE  move.b $1db01db0(d1.l * 4), (a6, a7.l * 2)
0102C8  dc.w   $fab0
0102CA  dc.w   $fad8
0102CC  ; data: 0xfb, 0xa0
0102CE  dc.w   $fc90
0102D0  ; data: 0xfd, 0xa8
0102D2  dc.w   $fe70
0102D4  dc.w   $fee8
0102D6  dc.w   $fee8
0102D8  dc.w   $fe70
0102DA  dc.w   $fd58
0102DC  dc.w   $fc40
0102DE  ; data: 0xfb, 0x00
0102E0  dc.w   $fa10
0102E2  dc.w   $f970
0102E4  dc.w   $f970
0102E6  dc.w   $fa10
0102E8  dc.w   $fad8
0102EA  ; data: 0xfb, 0xf0
0102EC  ; data: 0xfd, 0x08
0102EE  ; data: 0xfd, 0xd0
0102F0  dc.w   $fe20
0102F2  ; data: 0xfd, 0xf8
0102F4  dc.w   $fd58
0102F6  dc.w   $fc40
0102F8  dc.w   $fb28
0102FA  dc.w   $fa38
0102FC  ; data: 0xf9, 0x98
0102FE  dc.w   $f970
010300  ; data: 0xf9, 0xe8
010302  dc.w   $fad8
010304  ; data: 0xfb, 0xf0
010306  dc.w   $fd58
010308  dc.w   $fe70
01030A  dc.w   $ff38
01030C  ; data: 0xff, 0x60
01030E  dc.w   $ff10
010310  dc.w   $fe70
010312  ; data: 0xfd, 0x80
010314  dc.w   $fc90
010316  ; data: 0xfb, 0xf0
010318  ; data: 0xfb, 0xc8
01031A  ; data: 0xfb, 0xf0
01031C  dc.w   $fcb8
01031E  ; data: 0xfd, 0xf8
010320  ; data: 0xff, 0x60
010322  move.b $1db01db0(d1.l * 4), -$28(a6, a7.l)
01032C  dc.w   $fa88
01032E  dc.w   $fad8
010330  dc.w   $fb78
010332  dc.w   $fc90
010334  ; data: 0xfd, 0x80
010336  dc.w   $fe70
010338  dc.w   $fee8
01033A  dc.w   $fee8
01033C  dc.w   $fe48
01033E  dc.w   $fd58
010340  dc.w   $fc18
010342  dc.w   $fad8
010344  ; data: 0xf9, 0xe8
010346  dc.w   $f970
010348  dc.w   $f970
01034A  ; data: 0xf9, 0xe8
01034C  dc.w   $fad8
01034E  ; data: 0xfb, 0xf0
010350  ; data: 0xfd, 0x08
010352  ; data: 0xfd, 0xd0
010354  dc.w   $fe20
010356  ; data: 0xfd, 0xf8
010358  dc.w   $fd58
01035A  dc.w   $fc40
01035C  dc.w   $fb28
01035E  dc.w   $fa38
010360  ; data: 0xf9, 0x98
010362  dc.w   $f970
010364  ; data: 0xf9, 0xe8
010366  dc.w   $fad8
010368  dc.w   $fc18
01036A  dc.w   $fd58
01036C  dc.w   $fe70
01036E  dc.w   $ff38
010370  ; data: 0xff, 0x60
010372  dc.w   $ff38
010374  dc.w   $fe70
010376  ; data: 0xfd, 0x80
010378  dc.w   $fcb8
01037A  ; data: 0xfb, 0xf0
01037C  ; data: 0xfb, 0xc8
01037E  ; data: 0xfb, 0xf0
010380  dc.w   $fcb8
010382  ; data: 0xfd, 0xf8
010384  ; data: 0xff, 0x60
010386  move.b $1db01db0(d1.l * 4), -$28(a6, a7.l)
010390  dc.w   $fa88
010392  dc.w   $fad8
010394  dc.w   $fb78
010396  dc.w   $fc68
010398  ; data: 0xfd, 0x80
01039A  dc.w   $fe48
01039C  dc.w   $fec0
01039E  dc.w   $fec0
0103A0  dc.w   $fe20
0103A2  dc.w   $fd30
0103A4  dc.w   $fc18
0103A6  dc.w   $fad8
0103A8  ; data: 0xf9, 0xe8
0103AA  dc.w   $f970
0103AC  dc.w   $f970
0103AE  ; data: 0xf9, 0xe8
0103B0  dc.w   $fad8
0103B2  ; data: 0xfb, 0xf0
0103B4  ; data: 0xfd, 0x08
0103B6  ; data: 0xfd, 0xd0
0103B8  dc.w   $fe20
0103BA  ; data: 0xfd, 0xf8
0103BC  dc.w   $fd30
0103BE  dc.w   $fc40
0103C0  dc.w   $fb28
0103C2  dc.w   $fa38
0103C4  ; data: 0xf9, 0xc0
0103C6  ; data: 0xf9, 0x98
0103C8  dc.w   $fa10
0103CA  dc.w   $fad8
0103CC  dc.w   $fc18
0103CE  dc.w   $fd58
0103D0  dc.w   $fe70
0103D2  dc.w   $ff38
0103D4  ; data: 0xff, 0x60
0103D6  dc.w   $ff38
0103D8  dc.w   $fe70
0103DA  ; data: 0xfd, 0xa8
0103DC  dc.w   $fcb8
0103DE  ; data: 0xfb, 0xf0
0103E0  ; data: 0xfb, 0xc8
0103E2  dc.w   $fc18
0103E4  dc.w   $fce0
0103E6  ; data: 0xfd, 0xf8
0103E8  dc.w   $ff38
0103EA  move.b $1db01db0(d1.l * 4), -$28(a6, a7.l)
0103F4  dc.w   $fa88
0103F6  dc.w   $fab0
0103F8  dc.w   $fb78
0103FA  dc.w   $fc68
0103FC  dc.w   $fd58
0103FE  dc.w   $fe20
010400  dc.w   $fe98
010402  dc.w   $fe98
010404  dc.w   $fe20
010406  dc.w   $fd30
010408  ; data: 0xfb, 0xf0
01040A  dc.w   $fad8
01040C  ; data: 0xf9, 0xe8
01040E  dc.w   $f970
010410  dc.w   $f970
010412  ; data: 0xf9, 0xe8
010414  dc.w   $fad8
010416  ; data: 0xfb, 0xf0
010418  ; data: 0xfd, 0x08
01041A  ; data: 0xfd, 0xa8
01041C  ; data: 0xfd, 0xf8
01041E  ; data: 0xfd, 0xd0
010420  dc.w   $fd30
010422  dc.w   $fc40
010424  dc.w   $fb50
010426  dc.w   $fa60
010428  ; data: 0xf9, 0xc0
01042A  ; data: 0xf9, 0x98
01042C  dc.w   $fa10
01042E  ; data: 0xfb, 0x00
010430  dc.w   $fc18
010432  dc.w   $fd58
010434  dc.w   $fe70
010436  dc.w   $ff38
010438  ; data: 0xff, 0x60
01043A  dc.w   $ff38
01043C  dc.w   $fe70
01043E  ; data: 0xfd, 0xa8
010440  dc.w   $fcb8
010442  dc.w   $fc18
010444  ; data: 0xfb, 0xc8
010446  dc.w   $fc18
010448  dc.w   $fce0
01044A  ; data: 0xfd, 0xf8
01044C  dc.w   $ff38
01044E  move.b $1db01db0(d1.l * 4), -$28(a6, a7.l)
010458  dc.w   $fa88
01045A  dc.w   $fab0
01045C  dc.w   $fb50
01045E  dc.w   $fc40
010460  dc.w   $fd30
010462  dc.w   $fe20
010464  dc.w   $fe70
010466  dc.w   $fe70
010468  ; data: 0xfd, 0xf8
01046A  ; data: 0xfd, 0x08
01046C  ; data: 0xfb, 0xf0
01046E  dc.w   $fad8
010470  ; data: 0xf9, 0xe8
010472  dc.w   $f970
010474  dc.w   $f970
010476  ; data: 0xf9, 0xe8
010478  dc.w   $fad8
01047A  ; data: 0xfb, 0xf0
01047C  dc.w   $fce0
01047E  ; data: 0xfd, 0xa8
010480  ; data: 0xfd, 0xf8
010482  ; data: 0xfd, 0xd0
010484  dc.w   $fd30
010486  dc.w   $fc40
010488  dc.w   $fb50
01048A  dc.w   $fa60
01048C  ; data: 0xf9, 0xc0
01048E  ; data: 0xf9, 0xc0
010490  dc.w   $fa38
010492  ; data: 0xfb, 0x00
010494  dc.w   $fc18
010496  dc.w   $fd58
010498  dc.w   $fe70
01049A  dc.w   $ff10
01049C  ; data: 0xff, 0x60
01049E  dc.w   $ff10
0104A0  dc.w   $fe70
0104A2  ; data: 0xfd, 0xa8
0104A4  dc.w   $fcb8
0104A6  dc.w   $fc18
0104A8  ; data: 0xfb, 0xf0
0104AA  dc.w   $fc18
0104AC  dc.w   $fce0
0104AE  ; data: 0xfd, 0xf8
0104B0  dc.w   $ff38
0104B2  move.b $1db01db0(d1.l * 4), -$28(a6, a7.l)
0104BC  dc.w   $fa88
0104BE  dc.w   $fab0
0104C0  dc.w   $fb50
0104C2  dc.w   $fc40
0104C4  dc.w   $fd30
0104C6  ; data: 0xfd, 0xf8
0104C8  dc.w   $fe70
0104CA  dc.w   $fe48
0104CC  ; data: 0xfd, 0xd0
0104CE  dc.w   $fce0
0104D0  ; data: 0xfb, 0xc8
0104D2  dc.w   $fad8
0104D4  ; data: 0xf9, 0xe8
0104D6  dc.w   $f970
0104D8  dc.w   $f970
0104DA  dc.w   $fa10
0104DC  dc.w   $fad8
0104DE  ; data: 0xfb, 0xf0
0104E0  dc.w   $fce0
0104E2  ; data: 0xfd, 0x80
0104E4  ; data: 0xfd, 0xf8
0104E6  ; data: 0xfd, 0xd0
0104E8  dc.w   $fd30
0104EA  dc.w   $fc40
0104EC  dc.w   $fb50
0104EE  dc.w   $fa60
0104F0  ; data: 0xf9, 0xe8
0104F2  ; data: 0xf9, 0xc0
0104F4  dc.w   $fa38
0104F6  ; data: 0xfb, 0x00
0104F8  dc.w   $fc40
0104FA  dc.w   $fd58
0104FC  dc.w   $fe70
0104FE  dc.w   $ff10
010500  ; data: 0xff, 0x60
010502  dc.w   $ff10
010504  dc.w   $fe70
010506  ; data: 0xfd, 0xa8
010508  dc.w   $fcb8
01050A  dc.w   $fc40
01050C  ; data: 0xfb, 0xf0
01050E  dc.w   $fc40
010510  dc.w   $fce0
010512  ; data: 0xfd, 0xf8
010514  dc.w   $ff38
010516  move.b $1db01db0(d1.l * 4), -$28(a6, a7.l)
010520  dc.w   $fa88
010522  dc.w   $fab0
010524  dc.w   $fb50
010526  dc.w   $fc40
010528  ; data: 0xfd, 0x08
01052A  ; data: 0xfd, 0xd0
01052C  dc.w   $fe48
01052E  dc.w   $fe20
010530  ; data: 0xfd, 0xa8
010532  dc.w   $fce0
010534  ; data: 0xfb, 0xc8
010536  dc.w   $fad8
010538  ; data: 0xf9, 0xe8
01053A  dc.w   $f970
01053C  ; data: 0xf9, 0x98
01053E  dc.w   $fa10
010540  dc.w   $fad8
010542  ; data: 0xfb, 0xc8
010544  dc.w   $fcb8
010546  ; data: 0xfd, 0x80
010548  ; data: 0xfd, 0xd0
01054A  ; data: 0xfd, 0xa8
01054C  ; data: 0xfd, 0x08
01054E  dc.w   $fc40
010550  dc.w   $fb50
010552  dc.w   $fa88
010554  dc.w   $fa10
010556  ; data: 0xf9, 0xe8
010558  dc.w   $fa60
01055A  dc.w   $fb28
01055C  dc.w   $fc40
01055E  dc.w   $fd58
010560  dc.w   $fe48
010562  dc.w   $ff10
010564  dc.w   $ff38
010566  dc.w   $ff10
010568  dc.w   $fe70
01056A  ; data: 0xfd, 0xa8
01056C  dc.w   $fce0
01056E  dc.w   $fc40
010570  dc.w   $fc18
010572  dc.w   $fc40
010574  ; data: 0xfd, 0x08
010576  ; data: 0xfd, 0xf8
010578  dc.w   $ff38
01057A  move.b $1db01db0(d1.l * 4), -$28(a6, a7.l)
010584  dc.w   $fab0
010586  dc.w   $fad8
010588  dc.w   $fb50
01058A  dc.w   $fc18
01058C  ; data: 0xfd, 0x08
01058E  ; data: 0xfd, 0xa8
010590  dc.w   $fe20
010592  ; data: 0xfd, 0xf8
010594  ; data: 0xfd, 0x80
010596  dc.w   $fcb8
010598  ; data: 0xfb, 0xc8
01059A  dc.w   $fab0
01059C  ; data: 0xf9, 0xe8
01059E  ; data: 0xf9, 0x98
0105A0  ; data: 0xf9, 0x98
0105A2  dc.w   $fa10
0105A4  dc.w   $fad8
0105A6  ; data: 0xfb, 0xc8
0105A8  dc.w   $fcb8
0105AA  dc.w   $fd58
0105AC  ; data: 0xfd, 0xa8
0105AE  ; data: 0xfd, 0x80
0105B0  ; data: 0xfd, 0x08
0105B2  dc.w   $fc40
0105B4  dc.w   $fb50
0105B6  dc.w   $fa88
0105B8  dc.w   $fa10
0105BA  dc.w   $fa10
0105BC  dc.w   $fa60
0105BE  dc.w   $fb28
0105C0  dc.w   $fc40
0105C2  dc.w   $fd58
0105C4  dc.w   $fe48
0105C6  dc.w   $fee8
0105C8  dc.w   $ff38
0105CA  dc.w   $fee8
0105CC  dc.w   $fe70
0105CE  ; data: 0xfd, 0xa8
0105D0  dc.w   $fce0
0105D2  dc.w   $fc68
0105D4  dc.w   $fc18
0105D6  dc.w   $fc68
0105D8  ; data: 0xfd, 0x08
0105DA  ; data: 0xfd, 0xf8
0105DC  dc.w   $ff38
0105DE  move.b $1db01db0(d1.l * 4), (a6, a7.l * 2)
0105E8  dc.w   $fab0
0105EA  dc.w   $fad8
0105EC  dc.w   $fb50
0105EE  dc.w   $fc18
0105F0  dc.w   $fce0
0105F2  ; data: 0xfd, 0x80
0105F4  ; data: 0xfd, 0xd0
0105F6  ; data: 0xfd, 0xd0
0105F8  dc.w   $fd58
0105FA  dc.w   $fc90
0105FC  ; data: 0xfb, 0xa0
0105FE  dc.w   $fab0
010600  dc.w   $fa10
010602  ; data: 0xf9, 0x98
010604  ; data: 0xf9, 0x98
010606  dc.w   $fa10
010608  dc.w   $fad8
01060A  ; data: 0xfb, 0xc8
01060C  dc.w   $fc90
01060E  dc.w   $fd30
010610  ; data: 0xfd, 0x80
010612  ; data: 0xfd, 0x80
010614  ; data: 0xfd, 0x08
010616  dc.w   $fc40
010618  dc.w   $fb50
01061A  dc.w   $fab0
01061C  dc.w   $fa38
01061E  dc.w   $fa38
010620  dc.w   $fa88
010622  dc.w   $fb50
010624  dc.w   $fc40
010626  dc.w   $fd58
010628  dc.w   $fe48
01062A  dc.w   $fee8
01062C  dc.w   $ff10
01062E  dc.w   $fee8
010630  dc.w   $fe48
010632  ; data: 0xfd, 0xa8
010634  ; data: 0xfd, 0x08
010636  dc.w   $fc68
010638  dc.w   $fc40
01063A  dc.w   $fc90
01063C  dc.w   $fd30
01063E  dc.w   $fe20
010640  dc.w   $ff38
010642  move.b $1db01db0(d1.l * 4), (a6, a7.l * 2)
01064C  dc.w   $fad8
01064E  dc.w   $fad8
010650  dc.w   $fb50
010652  dc.w   $fc18
010654  dc.w   $fcb8
010656  dc.w   $fd58
010658  ; data: 0xfd, 0xa8
01065A  ; data: 0xfd, 0xa8
01065C  dc.w   $fd30
01065E  dc.w   $fc90
010660  ; data: 0xfb, 0xa0
010662  dc.w   $fad8
010664  dc.w   $fa10
010666  ; data: 0xf9, 0xc0
010668  ; data: 0xf9, 0xc0
01066A  dc.w   $fa38
01066C  dc.w   $fad8
01066E  ; data: 0xfb, 0xc8
010670  dc.w   $fc90
010672  dc.w   $fd30
010674  dc.w   $fd58
010676  dc.w   $fd58
010678  dc.w   $fce0
01067A  dc.w   $fc40
01067C  dc.w   $fb78
01067E  dc.w   $fab0
010680  dc.w   $fa60
010682  dc.w   $fa60
010684  dc.w   $fab0
010686  dc.w   $fb50
010688  dc.w   $fc40
01068A  dc.w   $fd58
01068C  dc.w   $fe20
01068E  dc.w   $fec0
010690  dc.w   $fee8
010692  dc.w   $fec0
010694  dc.w   $fe48
010696  ; data: 0xfd, 0xa8
010698  ; data: 0xfd, 0x08
01069A  dc.w   $fc90
01069C  dc.w   $fc68
01069E  dc.w   $fc90
0106A0  dc.w   $fd30
0106A2  dc.w   $fe20
0106A4  dc.w   $ff38
0106A6  move.b $1db01db0(d1.l * 4), $fad8(a6, a7.l * 2)
0106B2  ; data: 0xfb, 0x00
0106B4  dc.w   $fb50
0106B6  ; data: 0xfb, 0xf0
0106B8  dc.w   $fcb8
0106BA  dc.w   $fd30
0106BC  ; data: 0xfd, 0x80
0106BE  ; data: 0xfd, 0x80
0106C0  ; data: 0xfd, 0x08
0106C2  dc.w   $fc68
0106C4  ; data: 0xfb, 0xa0
0106C6  dc.w   $fad8
0106C8  dc.w   $fa38
0106CA  ; data: 0xf9, 0xc0
0106CC  ; data: 0xf9, 0xe8
0106CE  dc.w   $fa38
0106D0  dc.w   $fad8
0106D2  ; data: 0xfb, 0xa0
0106D4  dc.w   $fc68
0106D6  ; data: 0xfd, 0x08
0106D8  dc.w   $fd58
0106DA  dc.w   $fd30
0106DC  dc.w   $fcb8
0106DE  dc.w   $fc18
0106E0  dc.w   $fb78
0106E2  dc.w   $fad8
0106E4  dc.w   $fa88
0106E6  dc.w   $fa60
0106E8  dc.w   $fad8
0106EA  dc.w   $fb78
0106EC  dc.w   $fc40
0106EE  dc.w   $fd30
0106F0  dc.w   $fe20
0106F2  dc.w   $fe98
0106F4  dc.w   $fec0
0106F6  dc.w   $fec0
0106F8  dc.w   $fe48
0106FA  ; data: 0xfd, 0xa8
0106FC  ; data: 0xfd, 0x08
0106FE  dc.w   $fcb8
010700  dc.w   $fc90
010702  dc.w   $fcb8
010704  dc.w   $fd58
010706  dc.w   $fe20
010708  dc.w   $ff10
01070A  move.b $1db01db0(d1.l * 4), $fb00(a6, a7.l * 2)
010716  ; data: 0xfb, 0x00
010718  dc.w   $fb78
01071A  ; data: 0xfb, 0xf0
01071C  dc.w   $fc90
01071E  ; data: 0xfd, 0x08
010720  dc.w   $fd58
010722  dc.w   $fd58
010724  dc.w   $fce0
010726  dc.w   $fc40
010728  ; data: 0xfb, 0xa0
01072A  dc.w   $fad8
01072C  dc.w   $fa38
01072E  ; data: 0xf9, 0xe8
010730  ; data: 0xf9, 0xe8
010732  dc.w   $fa38
010734  dc.w   $fad8
010736  ; data: 0xfb, 0xa0
010738  dc.w   $fc68
01073A  dc.w   $fce0
01073C  dc.w   $fd30
01073E  ; data: 0xfd, 0x08
010740  dc.w   $fcb8
010742  dc.w   $fc18
010744  dc.w   $fb78
010746  dc.w   $fad8
010748  dc.w   $fa88
01074A  dc.w   $fa88
01074C  dc.w   $fad8
01074E  dc.w   $fb78
010750  dc.w   $fc68
010752  dc.w   $fd30
010754  ; data: 0xfd, 0xf8
010756  dc.w   $fe70
010758  dc.w   $fec0
01075A  dc.w   $fe98
01075C  dc.w   $fe20
01075E  ; data: 0xfd, 0xa8
010760  dc.w   $fd30
010762  dc.w   $fcb8
010764  dc.w   $fcb8
010766  dc.w   $fce0
010768  ; data: 0xfd, 0x80
01076A  dc.w   $fe48
01076C  dc.w   $ff10
01076E  move.b $1db01db0(d1.l * 4), (a6, invalid.w)
010778  ; data: 0xfb, 0x00
01077A  dc.w   $fb28
01077C  dc.w   $fb78
01077E  ; data: 0xfb, 0xf0
010780  dc.w   $fc90
010782  dc.w   $fce0
010784  dc.w   $fd30
010786  dc.w   $fd30
010788  dc.w   $fcb8
01078A  dc.w   $fc40
01078C  dc.w   $fb78
01078E  dc.w   $fad8
010790  dc.w   $fa60
010792  dc.w   $fa10
010794  dc.w   $fa10
010796  dc.w   $fa60
010798  dc.w   $fad8
01079A  ; data: 0xfb, 0xa0
01079C  dc.w   $fc40
01079E  dc.w   $fcb8
0107A0  dc.w   $fce0
0107A2  dc.w   $fce0
0107A4  dc.w   $fc90
0107A6  dc.w   $fc18
0107A8  dc.w   $fb78
0107AA  ; data: 0xfb, 0x00
0107AC  dc.w   $fab0
0107AE  dc.w   $fab0
0107B0  ; data: 0xfb, 0x00
0107B2  ; data: 0xfb, 0xa0
0107B4  dc.w   $fc68
0107B6  dc.w   $fd30
0107B8  ; data: 0xfd, 0xd0
0107BA  dc.w   $fe48
0107BC  dc.w   $fe98
0107BE  dc.w   $fe70
0107C0  dc.w   $fe20
0107C2  ; data: 0xfd, 0xa8
0107C4  dc.w   $fd30
0107C6  dc.w   $fce0
0107C8  dc.w   $fce0
0107CA  ; data: 0xfd, 0x08
0107CC  ; data: 0xfd, 0x80
0107CE  dc.w   $fe48
0107D0  dc.w   $ff10
0107D2  ; data: 0x1d, 0x88
0107D4  move.b $1db0fb78(d1.l * 4), $fb28(a6, a7.l * 2)
0107E0  dc.w   $fb78
0107E2  ; data: 0xfb, 0xf0
0107E4  dc.w   $fc68
0107E6  dc.w   $fcb8
0107E8  ; data: 0xfd, 0x08
0107EA  dc.w   $fce0
0107EC  dc.w   $fc90
0107EE  dc.w   $fc18
0107F0  dc.w   $fb78
0107F2  dc.w   $fad8
0107F4  dc.w   $fa60
0107F6  dc.w   $fa10
0107F8  dc.w   $fa38
0107FA  dc.w   $fa60
0107FC  ; data: 0xfb, 0x00
0107FE  dc.w   $fb78
010800  dc.w   $fc18
010802  dc.w   $fc90
010804  dc.w   $fcb8
010806  dc.w   $fcb8
010808  dc.w   $fc68
01080A  ; data: 0xfb, 0xf0
01080C  dc.w   $fb78
01080E  dc.w   $fb28
010810  dc.w   $fad8
010812  dc.w   $fad8
010814  dc.w   $fb28
010816  ; data: 0xfb, 0xa0
010818  dc.w   $fc68
01081A  ; data: 0xfd, 0x08
01081C  ; data: 0xfd, 0xd0
01081E  dc.w   $fe20
010820  dc.w   $fe70
010822  dc.w   $fe48
010824  dc.w   $fe20
010826  ; data: 0xfd, 0xa8
010828  dc.w   $fd58
01082A  ; data: 0xfd, 0x08
01082C  dc.w   $fce0
01082E  dc.w   $fd30
010830  ; data: 0xfd, 0xa8
010832  dc.w   $fe48
010834  dc.w   $ff10
010836  ; data: 0x1d, 0x88
010838  move.b $1db0fb78(d1.l * 4), (a6, invalid.w)
010842  dc.w   $fb50
010844  dc.w   $fb78
010846  ; data: 0xfb, 0xf0
010848  dc.w   $fc40
01084A  dc.w   $fcb8
01084C  dc.w   $fce0
01084E  dc.w   $fcb8
010850  dc.w   $fc68
010852  ; data: 0xfb, 0xf0
010854  dc.w   $fb78
010856  dc.w   $fad8
010858  dc.w   $fa88
01085A  dc.w   $fa38
01085C  dc.w   $fa38
01085E  dc.w   $fa88
010860  ; data: 0xfb, 0x00
010862  dc.w   $fb78
010864  dc.w   $fc18
010866  dc.w   $fc68
010868  dc.w   $fc90
01086A  dc.w   $fc90
01086C  dc.w   $fc68
01086E  ; data: 0xfb, 0xf0
010870  dc.w   $fb78
010872  dc.w   $fb28
010874  ; data: 0xfb, 0x00
010876  ; data: 0xfb, 0x00
010878  dc.w   $fb50
01087A  ; data: 0xfb, 0xc8
01087C  dc.w   $fc68
01087E  ; data: 0xfd, 0x08
010880  ; data: 0xfd, 0xa8
010882  dc.w   $fe20
010884  dc.w   $fe48
010886  dc.w   $fe48
010888  ; data: 0xfd, 0xf8
01088A  ; data: 0xfd, 0xa8
01088C  dc.w   $fd58
01088E  dc.w   $fd30
010890  ; data: 0xfd, 0x08
010892  dc.w   $fd58
010894  ; data: 0xfd, 0xd0
010896  dc.w   $fe48
010898  dc.w   $ff10
01089A  move.b -(a0), $1db0(a6)
01089E  move.b $fba0fb78(d1.l * 4), $fba0fbf0(a6, invalid.w)
0108AC  dc.w   $fc40
0108AE  dc.w   $fc90
0108B0  dc.w   $fcb8
0108B2  dc.w   $fc90
0108B4  dc.w   $fc68
0108B6  ; data: 0xfb, 0xf0
0108B8  dc.w   $fb78
0108BA  ; data: 0xfb, 0x00
0108BC  dc.w   $fa88
0108BE  dc.w   $fa60
0108C0  dc.w   $fa60
0108C2  dc.w   $fa88
0108C4  ; data: 0xfb, 0x00
0108C6  dc.w   $fb78
0108C8  ; data: 0xfb, 0xf0
0108CA  dc.w   $fc40
0108CC  dc.w   $fc68
0108CE  dc.w   $fc68
0108D0  dc.w   $fc40
0108D2  ; data: 0xfb, 0xf0
0108D4  dc.w   $fb78
0108D6  dc.w   $fb50
0108D8  ; data: 0xfb, 0x00
0108DA  dc.w   $fb28
0108DC  dc.w   $fb50
0108DE  ; data: 0xfb, 0xc8
0108E0  dc.w   $fc68
0108E2  ; data: 0xfd, 0x08
0108E4  ; data: 0xfd, 0x80
0108E6  ; data: 0xfd, 0xf8
0108E8  dc.w   $fe20
0108EA  dc.w   $fe20
0108EC  ; data: 0xfd, 0xf8
0108EE  ; data: 0xfd, 0xa8
0108F0  dc.w   $fd58
0108F2  dc.w   $fd30
0108F4  dc.w   $fd30
0108F6  ; data: 0xfd, 0x80
0108F8  ; data: 0xfd, 0xd0
0108FA  dc.w   $fe70
0108FC  dc.w   $ff10
0108FE  ; data: 0xff, 0xb0
010900  move.b $1db0fbc8(d1.l * 4), $fb78fba0(a6, invalid.w)
01090E  ; data: 0xfb, 0xf0
010910  dc.w   $fc18
010912  dc.w   $fc68
010914  dc.w   $fc90
010916  dc.w   $fc68
010918  dc.w   $fc40
01091A  ; data: 0xfb, 0xc8
01091C  dc.w   $fb50
01091E  ; data: 0xfb, 0x00
010920  dc.w   $fab0
010922  dc.w   $fa88
010924  dc.w   $fa88
010926  dc.w   $fab0
010928  ; data: 0xfb, 0x00
01092A  dc.w   $fb78
01092C  ; data: 0xfb, 0xc8
01092E  dc.w   $fc18
010930  dc.w   $fc40
010932  dc.w   $fc40
010934  dc.w   $fc18
010936  ; data: 0xfb, 0xc8
010938  ; data: 0xfb, 0xa0
01093A  dc.w   $fb50
01093C  dc.w   $fb28
01093E  dc.w   $fb50
010940  dc.w   $fb78
010942  ; data: 0xfb, 0xf0
010944  dc.w   $fc68
010946  dc.w   $fce0
010948  dc.w   $fd58
01094A  ; data: 0xfd, 0xd0
01094C  ; data: 0xfd, 0xf8
01094E  ; data: 0xfd, 0xf8
010950  ; data: 0xfd, 0xd0
010952  ; data: 0xfd, 0xa8
010954  ; data: 0xfd, 0x80
010956  dc.w   $fd58
010958  dc.w   $fd58
01095A  ; data: 0xfd, 0x80
01095C  ; data: 0xfd, 0xf8
01095E  dc.w   $fe70
010960  dc.w   $ff10
010962  ; data: 0xff, 0x88
010964  move.b $1db0fbc8(d1.l * 4), $fba0(a7.l * 2)
010970  ; data: 0xfb, 0xa0
010972  ; data: 0xfb, 0xf0
010974  dc.w   $fc18
010976  dc.w   $fc40
010978  dc.w   $fc68
01097A  dc.w   $fc40
01097C  dc.w   $fc18
01097E  ; data: 0xfb, 0xc8
010980  dc.w   $fb50
010982  ; data: 0xfb, 0x00
010984  dc.w   $fab0
010986  dc.w   $fa88
010988  dc.w   $fa88
01098A  dc.w   $fab0
01098C  ; data: 0xfb, 0x00
01098E  dc.w   $fb50
010990  ; data: 0xfb, 0xc8
010992  ; data: 0xfb, 0xf0
010994  dc.w   $fc18
010996  dc.w   $fc18
010998  ; data: 0xfb, 0xf0
01099A  ; data: 0xfb, 0xc8
01099C  ; data: 0xfb, 0xa0
01099E  dc.w   $fb50
0109A0  dc.w   $fb50
0109A2  dc.w   $fb50
0109A4  ; data: 0xfb, 0xa0
0109A6  ; data: 0xfb, 0xf0
0109A8  dc.w   $fc68
0109AA  dc.w   $fce0
0109AC  dc.w   $fd58
0109AE  ; data: 0xfd, 0xa8
0109B0  ; data: 0xfd, 0xd0
0109B2  ; data: 0xfd, 0xd0
0109B4  ; data: 0xfd, 0xd0
0109B6  ; data: 0xfd, 0xa8
0109B8  ; data: 0xfd, 0x80
0109BA  ; data: 0xfd, 0x80
0109BC  ; data: 0xfd, 0x80
0109BE  ; data: 0xfd, 0xa8
0109C0  ; data: 0xfd, 0xf8
0109C2  dc.w   $fe70
0109C4  dc.w   $ff10
0109C6  ; data: 0xff, 0x88
0109C8  move.b $1db0fbf0(d1.l * 4), (invalid.w)
0109D2  ; data: 0xfb, 0xa0
0109D4  ; data: 0xfb, 0xc8
0109D6  ; data: 0xfb, 0xf0
0109D8  dc.w   $fc18
0109DA  dc.w   $fc18
0109DC  dc.w   $fc40
0109DE  dc.w   $fc18
0109E0  ; data: 0xfb, 0xf0
0109E2  ; data: 0xfb, 0xa0
0109E4  dc.w   $fb50
0109E6  ; data: 0xfb, 0x00
0109E8  dc.w   $fad8
0109EA  dc.w   $fab0
0109EC  dc.w   $fab0
0109EE  dc.w   $fad8
0109F0  ; data: 0xfb, 0x00
0109F2  dc.w   $fb50
0109F4  ; data: 0xfb, 0xa0
0109F6  ; data: 0xfb, 0xc8
0109F8  ; data: 0xfb, 0xf0
0109FA  ; data: 0xfb, 0xf0
0109FC  ; data: 0xfb, 0xf0
0109FE  ; data: 0xfb, 0xc8
010A00  ; data: 0xfb, 0xa0
010A02  dc.w   $fb78
010A04  dc.w   $fb50
010A06  dc.w   $fb78
010A08  ; data: 0xfb, 0xa0
010A0A  ; data: 0xfb, 0xf0
010A0C  dc.w   $fc68
010A0E  dc.w   $fcb8
010A10  dc.w   $fd30
010A12  ; data: 0xfd, 0x80
010A14  ; data: 0xfd, 0xa8
010A16  ; data: 0xfd, 0xd0
010A18  ; data: 0xfd, 0xa8
010A1A  ; data: 0xfd, 0xa8
010A1C  ; data: 0xfd, 0x80
010A1E  ; data: 0xfd, 0x80
010A20  ; data: 0xfd, 0xa8
010A22  ; data: 0xfd, 0xd0
010A24  dc.w   $fe20
010A26  dc.w   $fe98
010A28  dc.w   $ff10
010A2A  ; data: 0xff, 0x88
010A2C  ; data: 0x1d, 0x88
010A2E  move.b $fc18fbf0(d1.l * 4), (invalid.w)
010A38  ; data: 0xfb, 0xc8
010A3A  ; data: 0xfb, 0xf0
010A3C  ; data: 0xfb, 0xf0
010A3E  dc.w   $fc18
010A40  dc.w   $fc18
010A42  ; data: 0xfb, 0xf0
010A44  ; data: 0xfb, 0xc8
010A46  ; data: 0xfb, 0xa0
010A48  dc.w   $fb50
010A4A  ; data: 0xfb, 0x00
010A4C  dc.w   $fad8
010A4E  dc.w   $fab0
010A50  dc.w   $fab0
010A52  dc.w   $fad8
010A54  ; data: 0xfb, 0x00
010A56  dc.w   $fb50
010A58  dc.w   $fb78
010A5A  ; data: 0xfb, 0xa0
010A5C  ; data: 0xfb, 0xc8
010A5E  ; data: 0xfb, 0xc8
010A60  ; data: 0xfb, 0xc8
010A62  ; data: 0xfb, 0xa0
010A64  ; data: 0xfb, 0xa0
010A66  dc.w   $fb78
010A68  dc.w   $fb78
010A6A  dc.w   $fb78
010A6C  ; data: 0xfb, 0xc8
010A6E  ; data: 0xfb, 0xf0
010A70  dc.w   $fc68
010A72  dc.w   $fcb8
010A74  ; data: 0xfd, 0x08
010A76  dc.w   $fd58
010A78  ; data: 0xfd, 0x80
010A7A  ; data: 0xfd, 0xa8
010A7C  ; data: 0xfd, 0xa8
010A7E  ; data: 0xfd, 0xa8
010A80  ; data: 0xfd, 0xa8
010A82  ; data: 0xfd, 0xa8
010A84  ; data: 0xfd, 0xa8
010A86  ; data: 0xfd, 0xf8
010A88  dc.w   $fe48
010A8A  dc.w   $fe98
010A8C  dc.w   $ff10
010A8E  ; data: 0xff, 0x60
010A90  move.b -(a0), $1db0(a6)
010A94  move.b $18(a0, a7.l), $fbf0fbc8(invalid.w)
010A9E  ; data: 0xfb, 0xf0
010AA0  ; data: 0xfb, 0xf0
010AA2  ; data: 0xfb, 0xf0
010AA4  ; data: 0xfb, 0xf0
010AA6  ; data: 0xfb, 0xf0
010AA8  ; data: 0xfb, 0xc8
010AAA  dc.w   $fb78
010AAC  dc.w   $fb50
010AAE  dc.w   $fb28
010AB0  ; data: 0xfb, 0x00
010AB2  dc.w   $fad8
010AB4  dc.w   $fad8
010AB6  dc.w   $fad8
010AB8  ; data: 0xfb, 0x00
010ABA  dc.w   $fb28
010ABC  dc.w   $fb78
010ABE  ; data: 0xfb, 0xa0
010AC0  ; data: 0xfb, 0xa0
010AC2  ; data: 0xfb, 0xc8
010AC4  ; data: 0xfb, 0xa0
010AC6  ; data: 0xfb, 0xa0
010AC8  dc.w   $fb78
010ACA  dc.w   $fb78
010ACC  dc.w   $fb78
010ACE  ; data: 0xfb, 0xa0
010AD0  ; data: 0xfb, 0xc8
010AD2  dc.w   $fc18
010AD4  dc.w   $fc68
010AD6  dc.w   $fcb8
010AD8  ; data: 0xfd, 0x08
010ADA  dc.w   $fd30
010ADC  dc.w   $fd58
010ADE  ; data: 0xfd, 0x80
010AE0  ; data: 0xfd, 0x80
010AE2  ; data: 0xfd, 0xa8
010AE4  ; data: 0xfd, 0xa8
010AE6  ; data: 0xfd, 0xa8
010AE8  ; data: 0xfd, 0xd0
010AEA  ; data: 0xfd, 0xf8
010AEC  dc.w   $fe48
010AEE  dc.w   $fe98
010AF0  dc.w   $ff10
010AF2  ; data: 0xff, 0x60
010AF4  ; data: 0xff, 0xb0
010AF6  ; data: 0x1d, 0x88
010AF8  move.b $40(a0, a7.l), $18(a6, a7.l)
010AFE  ; data: 0xfb, 0xf0
010B00  ; data: 0xfb, 0xf0
010B02  ; data: 0xfb, 0xf0
010B04  ; data: 0xfb, 0xf0
010B06  ; data: 0xfb, 0xf0
010B08  ; data: 0xfb, 0xc8
010B0A  ; data: 0xfb, 0xc8
010B0C  ; data: 0xfb, 0xa0
010B0E  dc.w   $fb78
010B10  dc.w   $fb50
010B12  dc.w   $fb28
010B14  ; data: 0xfb, 0x00
010B16  dc.w   $fad8
010B18  dc.w   $fad8
010B1A  ; data: 0xfb, 0x00
010B1C  ; data: 0xfb, 0x00
010B1E  dc.w   $fb28
010B20  dc.w   $fb50
010B22  dc.w   $fb78
010B24  dc.w   $fb78
010B26  ; data: 0xfb, 0xa0
010B28  ; data: 0xfb, 0xa0
010B2A  ; data: 0xfb, 0xa0
010B2C  dc.w   $fb78
010B2E  dc.w   $fb78
010B30  ; data: 0xfb, 0xa0
010B32  ; data: 0xfb, 0xa0
010B34  ; data: 0xfb, 0xc8
010B36  dc.w   $fc18
010B38  dc.w   $fc40
010B3A  dc.w   $fc90
010B3C  dc.w   $fce0
010B3E  ; data: 0xfd, 0x08
010B40  dc.w   $fd58
010B42  dc.w   $fd58
010B44  ; data: 0xfd, 0x80
010B46  ; data: 0xfd, 0xa8
010B48  ; data: 0xfd, 0xa8
010B4A  ; data: 0xfd, 0xd0
010B4C  ; data: 0xfd, 0xf8
010B4E  dc.w   $fe20
010B50  dc.w   $fe70
010B52  dc.w   $fec0
010B54  dc.w   $ff10
010B56  ; data: 0xff, 0x60
010B58  ; data: 0xff, 0x88
010B5A  ; data: 0x1d, 0x88
010B5C  move.b $40(a0, a7.l), $18(a6, a7.l)
010B62  dc.w   $fc18
010B64  ; data: 0xfb, 0xf0
010B66  ; data: 0xfb, 0xf0
010B68  ; data: 0xfb, 0xf0
010B6A  ; data: 0xfb, 0xc8
010B6C  ; data: 0xfb, 0xc8
010B6E  ; data: 0xfb, 0xa0
010B70  ; data: 0xfb, 0xa0
010B72  dc.w   $fb78
010B74  dc.w   $fb50
010B76  dc.w   $fb28
010B78  ; data: 0xfb, 0x00
010B7A  ; data: 0xfb, 0x00
010B7C  ; data: 0xfb, 0x00
010B7E  ; data: 0xfb, 0x00
010B80  ; data: 0xfb, 0x00
010B82  dc.w   $fb28
010B84  dc.w   $fb50
010B86  dc.w   $fb50
010B88  dc.w   $fb78
010B8A  dc.w   $fb78
010B8C  dc.w   $fb78
010B8E  dc.w   $fb78
010B90  dc.w   $fb78
010B92  dc.w   $fb78
010B94  ; data: 0xfb, 0xa0
010B96  ; data: 0xfb, 0xc8
010B98  ; data: 0xfb, 0xf0
010B9A  dc.w   $fc18
010B9C  dc.w   $fc40
010B9E  dc.w   $fc90
010BA0  dc.w   $fcb8
010BA2  ; data: 0xfd, 0x08
010BA4  dc.w   $fd30
010BA6  dc.w   $fd58
010BA8  ; data: 0xfd, 0x80
010BAA  ; data: 0xfd, 0x80
010BAC  ; data: 0xfd, 0xa8
010BAE  ; data: 0xfd, 0xd0
010BB0  ; data: 0xfd, 0xf8
010BB2  dc.w   $fe48
010BB4  dc.w   $fe70
010BB6  dc.w   $fec0
010BB8  dc.w   $ff10
010BBA  dc.w   $ff38
010BBC  ; data: 0xff, 0x88
010BBE  move.b -(a0), $1db0(a6)
010BC2  dc.w   $fc68
010BC4  dc.w   $fc40
010BC6  dc.w   $fc18
010BC8  ; data: 0xfb, 0xf0
010BCA  ; data: 0xfb, 0xf0
010BCC  ; data: 0xfb, 0xc8
010BCE  ; data: 0xfb, 0xc8
010BD0  ; data: 0xfb, 0xa0
010BD2  ; data: 0xfb, 0xa0
010BD4  dc.w   $fb78
010BD6  dc.w   $fb50
010BD8  dc.w   $fb50
010BDA  dc.w   $fb28
010BDC  ; data: 0xfb, 0x00
010BDE  ; data: 0xfb, 0x00
010BE0  ; data: 0xfb, 0x00
010BE2  ; data: 0xfb, 0x00
010BE4  ; data: 0xfb, 0x00
010BE6  dc.w   $fb28
010BE8  dc.w   $fb28
010BEA  dc.w   $fb50
010BEC  dc.w   $fb50
010BEE  dc.w   $fb50
010BF0  dc.w   $fb78
010BF2  dc.w   $fb78
010BF4  dc.w   $fb78
010BF6  dc.w   $fb78
010BF8  ; data: 0xfb, 0xa0
010BFA  ; data: 0xfb, 0xc8
010BFC  ; data: 0xfb, 0xf0
010BFE  dc.w   $fc18
010C00  dc.w   $fc40
010C02  dc.w   $fc68
010C04  dc.w   $fcb8
010C06  dc.w   $fce0
010C08  ; data: 0xfd, 0x08
010C0A  dc.w   $fd30
010C0C  dc.w   $fd58
010C0E  ; data: 0xfd, 0x80
010C10  ; data: 0xfd, 0xa8
010C12  ; data: 0xfd, 0xd0
010C14  dc.w   $fe20
010C16  dc.w   $fe48
010C18  dc.w   $fe70
010C1A  dc.w   $fec0
010C1C  dc.w   $ff10
010C1E  dc.w   $ff38
010C20  ; data: 0xff, 0x88
010C22  move.b -(a0), $1d88(a6)
010C26  dc.w   $fc68
010C28  dc.w   $fc40
010C2A  dc.w   $fc18
010C2C  dc.w   $fc18
010C2E  ; data: 0xfb, 0xf0
010C30  ; data: 0xfb, 0xc8
010C32  ; data: 0xfb, 0xc8
010C34  ; data: 0xfb, 0xa0
010C36  ; data: 0xfb, 0xa0
010C38  dc.w   $fb78
010C3A  dc.w   $fb50
010C3C  dc.w   $fb50
010C3E  dc.w   $fb28
010C40  dc.w   $fb28
010C42  ; data: 0xfb, 0x00
010C44  ; data: 0xfb, 0x00
010C46  ; data: 0xfb, 0x00
010C48  ; data: 0xfb, 0x00
010C4A  ; data: 0xfb, 0x00
010C4C  dc.w   $fb28
010C4E  dc.w   $fb28
010C50  dc.w   $fb28
010C52  dc.w   $fb50
010C54  dc.w   $fb50
010C56  dc.w   $fb50
010C58  dc.w   $fb78
010C5A  dc.w   $fb78
010C5C  ; data: 0xfb, 0xa0
010C5E  ; data: 0xfb, 0xc8
010C60  ; data: 0xfb, 0xf0
010C62  dc.w   $fc18
010C64  dc.w   $fc40
010C66  dc.w   $fc68
010C68  dc.w   $fc90
010C6A  dc.w   $fce0
010C6C  ; data: 0xfd, 0x08
010C6E  dc.w   $fd30
010C70  dc.w   $fd58
010C72  ; data: 0xfd, 0x80
010C74  ; data: 0xfd, 0xa8
010C76  ; data: 0xfd, 0xf8
010C78  dc.w   $fe20
010C7A  dc.w   $fe48
010C7C  dc.w   $fe98
010C7E  dc.w   $fec0
010C80  dc.w   $ff10
010C82  dc.w   $ff38
010C84  ; data: 0xff, 0x88
010C86  move.b -(a0), $1d88(a6)
010C8A  dc.w   $fc68
010C8C  dc.w   $fc68
010C8E  dc.w   $fc40
010C90  dc.w   $fc18
010C92  ; data: 0xfb, 0xf0
010C94  ; data: 0xfb, 0xc8
010C96  ; data: 0xfb, 0xc8
010C98  ; data: 0xfb, 0xa0
010C9A  dc.w   $fb78
010C9C  dc.w   $fb78
010C9E  dc.w   $fb50
010CA0  dc.w   $fb50
010CA2  dc.w   $fb28
010CA4  dc.w   $fb28
010CA6  ; data: 0xfb, 0x00
010CA8  ; data: 0xfb, 0x00
010CAA  ; data: 0xfb, 0x00
010CAC  ; data: 0xfb, 0x00
010CAE  ; data: 0xfb, 0x00
010CB0  ; data: 0xfb, 0x00
010CB2  dc.w   $fb28
010CB4  dc.w   $fb28
010CB6  dc.w   $fb28
010CB8  dc.w   $fb50
010CBA  dc.w   $fb50
010CBC  dc.w   $fb78
010CBE  dc.w   $fb78
010CC0  ; data: 0xfb, 0xa0
010CC2  ; data: 0xfb, 0xc8
010CC4  ; data: 0xfb, 0xc8
010CC6  ; data: 0xfb, 0xf0
010CC8  dc.w   $fc40
010CCA  dc.w   $fc68
010CCC  dc.w   $fc90
010CCE  dc.w   $fcb8
010CD0  dc.w   $fce0
010CD2  dc.w   $fd30
010CD4  dc.w   $fd58
010CD6  ; data: 0xfd, 0x80
010CD8  ; data: 0xfd, 0xa8
010CDA  ; data: 0xfd, 0xf8
010CDC  dc.w   $fe20
010CDE  dc.w   $fe48
010CE0  dc.w   $fe98
010CE2  dc.w   $fec0
010CE4  dc.w   $ff10
010CE6  dc.w   $ff38
010CE8  ; data: 0xff, 0x88
010CEA  move.b -(a0), $1d88(a6)
010CEE  dc.w   $fc90
010CF0  dc.w   $fc68
010CF2  dc.w   $fc40
010CF4  dc.w   $fc18
010CF6  ; data: 0xfb, 0xf0
010CF8  ; data: 0xfb, 0xc8
010CFA  ; data: 0xfb, 0xc8
010CFC  ; data: 0xfb, 0xa0
010CFE  dc.w   $fb78
010D00  dc.w   $fb78
010D02  dc.w   $fb50
010D04  dc.w   $fb50
010D06  dc.w   $fb28
010D08  dc.w   $fb28
010D0A  dc.w   $fb28
010D0C  ; data: 0xfb, 0x00
010D0E  ; data: 0xfb, 0x00
010D10  ; data: 0xfb, 0x00
010D12  ; data: 0xfb, 0x00
010D14  ; data: 0xfb, 0x00
010D16  ; data: 0xfb, 0x00
010D18  dc.w   $fb28
010D1A  dc.w   $fb28
010D1C  dc.w   $fb28
010D1E  dc.w   $fb50
010D20  dc.w   $fb50
010D22  dc.w   $fb78
010D24  ; data: 0xfb, 0xa0
010D26  ; data: 0xfb, 0xa0
010D28  ; data: 0xfb, 0xc8
010D2A  ; data: 0xfb, 0xf0
010D2C  dc.w   $fc18
010D2E  dc.w   $fc40
010D30  dc.w   $fc68
010D32  dc.w   $fcb8
010D34  dc.w   $fce0
010D36  ; data: 0xfd, 0x08
010D38  dc.w   $fd58
010D3A  ; data: 0xfd, 0x80
010D3C  ; data: 0xfd, 0xa8
010D3E  ; data: 0xfd, 0xf8
010D40  dc.w   $fe20
010D42  dc.w   $fe70
010D44  dc.w   $fe98
010D46  dc.w   $fee8
010D48  dc.w   $ff10
010D4A  dc.w   $ff38
010D4C  ; data: 0xff, 0x88
010D4E  move.b -(a0), $1d88(a6)
010D52  dc.w   $fc90
010D54  dc.w   $fc68
010D56  dc.w   $fc40
010D58  dc.w   $fc18
010D5A  ; data: 0xfb, 0xf0
010D5C  ; data: 0xfb, 0xf0
010D5E  ; data: 0xfb, 0xc8
010D60  ; data: 0xfb, 0xa0
010D62  dc.w   $fb78
010D64  dc.w   $fb78
010D66  dc.w   $fb50
010D68  dc.w   $fb50
010D6A  dc.w   $fb28
010D6C  dc.w   $fb28
010D6E  ; data: 0xfb, 0x00
010D70  ; data: 0xfb, 0x00
010D72  ; data: 0xfb, 0x00
010D74  ; data: 0xfb, 0x00
010D76  ; data: 0xfb, 0x00
010D78  ; data: 0xfb, 0x00
010D7A  ; data: 0xfb, 0x00
010D7C  ; data: 0xfb, 0x00
010D7E  ; data: 0xfb, 0x00
010D80  dc.w   $fb28
010D82  dc.w   $fb28
010D84  dc.w   $fb50
010D86  dc.w   $fb50
010D88  dc.w   $fb78
010D8A  ; data: 0xfb, 0xa0
010D8C  ; data: 0xfb, 0xc8
010D8E  ; data: 0xfb, 0xf0
010D90  dc.w   $fc18
010D92  dc.w   $fc40
010D94  dc.w   $fc68
010D96  dc.w   $fc90
010D98  dc.w   $fce0
010D9A  ; data: 0xfd, 0x08
010D9C  dc.w   $fd30
010D9E  ; data: 0xfd, 0x80
010DA0  ; data: 0xfd, 0xa8
010DA2  ; data: 0xfd, 0xf8
010DA4  dc.w   $fe20
010DA6  dc.w   $fe70
010DA8  dc.w   $fe98
010DAA  dc.w   $fee8
010DAC  dc.w   $ff10
010DAE  ; data: 0xff, 0x60
010DB0  ; data: 0xff, 0x88
010DB2  move.b -(a0), $1db0(a6)
010DB6  dc.w   $fc90
010DB8  dc.w   $fc68
010DBA  dc.w   $fc40
010DBC  dc.w   $fc18
010DBE  ; data: 0xfb, 0xf0
010DC0  ; data: 0xfb, 0xf0
010DC2  ; data: 0xfb, 0xc8
010DC4  ; data: 0xfb, 0xa0
010DC6  ; data: 0xfb, 0xa0
010DC8  dc.w   $fb78
010DCA  dc.w   $fb50
010DCC  dc.w   $fb50
010DCE  dc.w   $fb28
010DD0  dc.w   $fb28
010DD2  ; data: 0xfb, 0x00
010DD4  ; data: 0xfb, 0x00
010DD6  ; data: 0xfb, 0x00
010DD8  ; data: 0xfb, 0x00
010DDA  ; data: 0xfb, 0x00
010DDC  ; data: 0xfb, 0x00
010DDE  ; data: 0xfb, 0x00
010DE0  ; data: 0xfb, 0x00
010DE2  ; data: 0xfb, 0x00
010DE4  dc.w   $fb28
010DE6  dc.w   $fb28
010DE8  dc.w   $fb28
010DEA  dc.w   $fb50
010DEC  dc.w   $fb78
010DEE  dc.w   $fb78
010DF0  ; data: 0xfb, 0xa0
010DF2  ; data: 0xfb, 0xc8
010DF4  ; data: 0xfb, 0xf0
010DF6  dc.w   $fc40
010DF8  dc.w   $fc68
010DFA  dc.w   $fc90
010DFC  dc.w   $fcb8
010DFE  ; data: 0xfd, 0x08
010E00  dc.w   $fd30
010E02  ; data: 0xfd, 0x80
010E04  ; data: 0xfd, 0xa8
010E06  ; data: 0xfd, 0xd0
010E08  dc.w   $fe20
010E0A  dc.w   $fe70
010E0C  dc.w   $fe98
010E0E  dc.w   $fee8
010E10  dc.w   $ff10
010E12  ; data: 0xff, 0x60
010E14  ; data: 0xff, 0x88
010E16  ; data: 0x1d, 0x88
010E18  move.b -$70(a0, a7.l), $68(a6, a7.l)
010E1E  dc.w   $fc40
010E20  dc.w   $fc18
010E22  dc.w   $fc18
010E24  ; data: 0xfb, 0xf0
010E26  ; data: 0xfb, 0xc8
010E28  ; data: 0xfb, 0xc8
010E2A  ; data: 0xfb, 0xa0
010E2C  dc.w   $fb78
010E2E  dc.w   $fb50
010E30  dc.w   $fb50
010E32  dc.w   $fb28
010E34  dc.w   $fb28
010E36  ; data: 0xfb, 0x00
010E38  ; data: 0xfb, 0x00
010E3A  ; data: 0xfb, 0x00
010E3C  dc.w   $fad8
010E3E  dc.w   $fad8
010E40  ; data: 0xfb, 0x00
010E42  ; data: 0xfb, 0x00
010E44  ; data: 0xfb, 0x00
010E46  ; data: 0xfb, 0x00
010E48  ; data: 0xfb, 0x00
010E4A  dc.w   $fb28
010E4C  dc.w   $fb28
010E4E  dc.w   $fb28
010E50  dc.w   $fb50
010E52  dc.w   $fb78
010E54  ; data: 0xfb, 0xa0
010E56  ; data: 0xfb, 0xc8
010E58  ; data: 0xfb, 0xf0
010E5A  dc.w   $fc18
010E5C  dc.w   $fc68
010E5E  dc.w   $fc90
010E60  dc.w   $fcb8
010E62  ; data: 0xfd, 0x08
010E64  dc.w   $fd30
010E66  dc.w   $fd58
010E68  ; data: 0xfd, 0xa8
010E6A  ; data: 0xfd, 0xd0
010E6C  dc.w   $fe20
010E6E  dc.w   $fe48
010E70  dc.w   $fe98
010E72  dc.w   $fee8
010E74  dc.w   $ff10
010E76  ; data: 0xff, 0x60
010E78  ; data: 0xff, 0xb0
010E7A  ; data: 0x1d, 0x88
010E7C  move.b (a0, d0.w), (a6, d0.w)
010E82  ori.b  #$0, d0
010E86  ori.b  #$0, d0
010E8A  ori.b  #$0, d0
010E8E  ori.b  #$0, d0
010E92  ori.b  #$0, d0
010E96  ori.b  #$0, d0
010E9A  ori.b  #$0, d0
010E9E  ori.b  #$0, d0
010EA2  ori.b  #$0, d0
010EA6  ori.b  #$0, d0
010EAA  ori.b  #$0, d0
010EAE  ori.b  #$0, d0
010EB2  ori.b  #$0, d0
010EB6  ori.b  #$0, d0
010EBA  ori.b  #$0, d0
010EBE  ori.b  #$0, d0
010EC2  ori.b  #$0, d0
010EC6  ori.b  #$0, d0
010ECA  ori.b  #$0, d0
010ECE  ori.b  #$0, d0
010ED2  ori.b  #$0, d0
010ED6  ori.b  #$0, d0
010EDA  ori.b  #$0, d0
010EDE  ori.b  #$0, d0
010EE2  ori.b  #$0, d0
010EE6  ori.b  #$0, d0
010EEA  ori.b  #$0, d0
010EEE  ori.b  #$0, d0
010EF2  ori.b  #$0, d0
010EF6  ori.b  #$0, d0
010EFA  ori.b  #$0, d0
010EFE  ori.b  #$0, d0
010F02  ori.b  #$0, d0
010F06  ori.b  #$0, d0
010F0A  ori.b  #$0, d0
010F0E  ori.b  #$0, d0
010F12  ori.b  #$0, d0
010F16  ori.b  #$0, d0
010F1A  ori.b  #$0, d0
010F1E  ori.b  #$0, d0
010F22  ori.b  #$0, d0
010F26  ori.b  #$0, d0
010F2A  ori.b  #$0, d0
010F2E  ori.b  #$0, d0
010F32  ori.b  #$0, d0
010F36  ori.b  #$0, d0
010F3A  ori.b  #$0, d0
010F3E  ori.b  #$0, d0
010F42  ori.b  #$0, d0
010F46  ori.b  #$0, d0
010F4A  ori.b  #$0, d0
010F4E  ori.b  #$0, d0
010F52  ori.b  #$0, d0
010F56  ori.b  #$0, d0
010F5A  ori.b  #$0, d0
010F5E  ori.b  #$0, d0
010F62  ori.b  #$0, d0
010F66  ori.b  #$0, d0
010F6A  ori.b  #$0, d0
010F6E  ori.b  #$0, d0
010F72  ori.b  #$0, d0
010F76  ori.b  #$0, d0
010F7A  ori.b  #$0, d0
010F7E  ori.b  #$0, d0
010F82  ori.b  #$0, d0
010F86  ori.b  #$0, d0
010F8A  ori.b  #$0, d0
010F8E  ori.b  #$0, d0
010F92  ori.b  #$0, d0
010F96  ori.b  #$0, d0
010F9A  ori.b  #$0, d0
010F9E  ori.b  #$0, d0
010FA2  ori.b  #$0, d0
010FA6  ori.b  #$0, d0
010FAA  ori.b  #$0, d0
010FAE  ori.b  #$0, d0
010FB2  ori.b  #$0, d0
010FB6  ori.b  #$0, d0
010FBA  ori.b  #$0, d0
010FBE  ori.b  #$0, d0
010FC2  ori.b  #$0, d0
010FC6  ori.b  #$0, d0
010FCA  ori.b  #$0, d0
010FCE  ori.b  #$0, d0
010FD2  ori.b  #$0, d0
010FD6  ori.b  #$0, d0
010FDA  ori.b  #$0, d0
010FDE  ori.b  #$0, d0
010FE2  ori.b  #$0, d0
010FE6  ori.b  #$0, d0
010FEA  ori.b  #$0, d0
010FEE  ori.b  #$0, d0
010FF2  ori.b  #$0, d0
010FF6  ori.b  #$0, d0
010FFA  ori.b  #$0, d0
010FFE  ori.b  #$0, d0
011002  ori.b  #$0, d0
011006  ori.b  #$0, d0
01100A  ori.b  #$0, d0
01100E  ori.b  #$0, d0
011012  ori.b  #$0, d0
011016  ori.b  #$0, d0
01101A  ori.b  #$0, d0
01101E  ori.b  #$0, d0
011022  ori.b  #$0, d0
011026  ori.b  #$0, d0
01102A  ori.b  #$0, d0
01102E  ori.b  #$0, d0
011032  ori.b  #$0, d0
011036  ori.b  #$0, d0
01103A  ori.b  #$0, d0
01103E  ori.b  #$0, d0
011042  ori.b  #$0, d0
011046  ori.b  #$0, d0
01104A  ori.b  #$0, d0
01104E  ori.b  #$0, d0
011052  ori.b  #$0, d0
011056  ori.b  #$0, d0
01105A  ori.b  #$0, d0
01105E  ori.b  #$0, d0
011062  ori.b  #$0, d0
011066  ori.b  #$0, d0
01106A  ori.b  #$0, d0
01106E  ori.b  #$0, d0
011072  ori.b  #$0, d0
011076  ori.b  #$0, d0
01107A  ori.b  #$0, d0
01107E  ori.b  #$0, d0
011082  ori.b  #$0, d0
011086  ori.b  #$0, d0
01108A  ori.b  #$0, d0
01108E  ori.b  #$0, d0
011092  ori.b  #$c0, d1
011096  ori.b  #$0, d0
01109A  ori.b  #$0, d0
01109E  ori.b  #$0, d0
0110A2  ori.b  #$0, d0
0110A6  ori.b  #$0, d0
0110AA  ori.b  #$0, d0
0110AE  ori.b  #$0, d0
0110B2  ori.b  #$0, d0
0110B6  ori.b  #$0, d0
0110BA  ori.b  #$0, d0
0110BE  ori.b  #$0, d0
0110C2  ori.b  #$0, d0
0110C6  ori.b  #$0, d0
0110CA  ori.b  #$0, d0
0110CE  ori.b  #$0, d0
0110D2  ori.b  #$0, d0
0110D6  ori.b  #$0, d0
0110DA  ori.b  #$0, d0
0110DE  ; data: 0x00, 0x0f
0110E0  ; data: 0xff, 0xf8
0110E2  ori.b  #$f0, d3
0110E6  ; data: 0x00, 0x7f
0110E8  dc.w   $f800
0110EA  ; data: 0x7f, 0xf8
0110EC  ; data: 0xff, 0xf9
0110EE  ; data: 0xff, 0xff
0110F0  ; data: 0xff, 0xef
0110F2  ; data: 0xff, 0xc0
0110F4  ; data: 0x1f, 0xff
0110F6  or.b   d0, d0
0110F8  ori.b  #$0, d0
0110FC  ori.b  #$0, d0
011100  ori.b  #$0, d0
011104  ori.b  #$0, d0
011108  ori.b  #$0, d0
01110C  ori.b  #$0, d0
011110  ori.b  #$0, d0
011114  ori.b  #$0, d0
011118  ori.b  #$0, d0
01111C  ori.b  #$0, d0
011120  ori.b  #$0, d0
011124  ori.b  #$0, d0
011128  ori.b  #$3f, d0
01112C  ; data: 0xff, 0xfe
01112E  ori.b  #$f0, d3
011132  ; data: 0x00, 0x7f
011134  dc.w   $fc00
011136  ; data: 0x7f, 0xf8
011138  ; data: 0xff, 0xf9
01113A  ; data: 0xff, 0xff
01113C  ; data: 0xff, 0xe7
01113E  ; data: 0xff, 0xc0
011140  ; data: 0x1f, 0xff
011142  ori.b  #$0, d0
011146  ori.b  #$0, d0
01114A  ori.b  #$0, d0
01114E  ori.b  #$0, d0
011152  ori.b  #$0, d0
011156  ori.b  #$0, d0
01115A  ori.b  #$0, d0
01115E  ori.b  #$0, d0
011162  ori.b  #$0, d0
011166  ori.b  #$0, d0
01116A  ori.b  #$0, d0
01116E  ori.b  #$0, d0
011172  ori.b  #$0, d0
011176  ; data: 0x00, 0x7f
011178  ; data: 0xff, 0xff
01117A  or.b   d7, d0
01117C  ; data: 0xff, 0xf8
01117E  ; data: 0x00, 0x7f
011180  dc.w   $fc00
011182  ; data: 0x7f, 0xf8
011184  ; data: 0xff, 0xf9
011186  ; data: 0xff, 0xff
011188  ; data: 0xff, 0xe3
01118A  ; data: 0xff, 0xe0
01118C  ; data: 0x3f, 0xfe
01118E  ori.b  #$0, d0
011192  ori.b  #$0, d0
011196  ori.b  #$0, d0
01119A  ori.b  #$0, d0
01119E  ori.b  #$0, d0
0111A2  ori.b  #$0, d0
0111A6  ori.b  #$0, d0
0111AA  ori.b  #$0, d0
0111AE  ori.b  #$0, d0
0111B2  ori.b  #$0, d0
0111B6  ori.b  #$0, d0
0111BA  ori.b  #$0, d0
0111BE  ori.b  #$0, d0
0111C2  ; data: 0x00, 0xff
0111C4  ; data: 0xff, 0xff
0111C6  or.b   d7, d0
0111C8  ; data: 0xff, 0xf8
0111CA  ; data: 0x00, 0x7f
0111CC  dc.w   $fe00
0111CE  ; data: 0x7f, 0xf8
0111D0  ; data: 0xff, 0xf9
0111D2  ; data: 0xff, 0xff
0111D4  ; data: 0xff, 0xe3
0111D6  ; data: 0xff, 0xe0
0111D8  ; data: 0x3f, 0xfe
0111DA  ori.b  #$0, d0
0111DE  ori.b  #$0, d0
0111E2  ori.b  #$0, d0
0111E6  ori.b  #$0, d0
0111EA  ori.b  #$0, d0
0111EE  ori.b  #$0, d0
0111F2  ori.b  #$0, d0
0111F6  ori.b  #$0, d0
0111FA  ori.b  #$0, d0
0111FE  ori.b  #$0, d0
011202  ori.b  #$0, d0
011206  ori.b  #$0, d0
01120A  ori.b  #$0, d0
01120E  ; data: 0x00, 0xff
011210  ; data: 0xff, 0xff
011212  ori.b  #$f8, d7
011216  ; data: 0x00, 0x7f
011218  ; data: 0xff, 0x00
01121A  ; data: 0x7f, 0xf8
01121C  ; data: 0xff, 0xf9
01121E  ; data: 0xff, 0xff
011220  ; data: 0xff, 0xe1
011222  ; data: 0xff, 0xf0
011224  ; data: 0x7f, 0xfc
011226  ori.b  #$0, d0
01122A  ori.b  #$0, d0
01122E  ori.b  #$0, d0
011232  ori.b  #$0, d0
011236  ori.b  #$0, d0
01123A  ori.b  #$0, d0
01123E  ori.b  #$0, d0
011242  ori.b  #$0, d0
011246  ori.b  #$0, d0
01124A  ori.b  #$0, d0
01124E  ori.b  #$0, d0
011252  ori.b  #$0, d0
011256  ori.b  #$0, d0
01125A  ; data: 0x01, 0xff
01125C  ; data: 0xff, 0xff
01125E  ; data: 0x00, 0x0f
011260  ; data: 0xff, 0xfc
011262  ; data: 0x00, 0x7f
011264  ; data: 0xff, 0x00
011266  ; data: 0x7f, 0xf8
011268  ; data: 0xff, 0xf9
01126A  ; data: 0xff, 0xff
01126C  ; data: 0xff, 0xe0
01126E  ; data: 0xff, 0xf0
011270  ; data: 0x7f, 0xf8
011272  ori.b  #$0, d0
011276  ori.b  #$0, d0
01127A  ori.b  #$0, d0
01127E  ori.b  #$0, d0
011282  ori.b  #$0, d0
011286  ori.b  #$0, d0
01128A  ori.b  #$0, d0
01128E  ori.b  #$0, d0
011292  ori.b  #$0, d0
011296  ori.b  #$0, d0
01129A  ori.b  #$0, d0
01129E  ori.b  #$0, d0
0112A2  ori.b  #$0, d0
0112A6  ; data: 0x01, 0xff
0112A8  ; data: 0xff, 0xff
0112AA  ; data: 0x00, 0x0f
0112AC  ; data: 0xff, 0xfc
0112AE  ; data: 0x00, 0x7f
0112B0  ; data: 0xff, 0x80
0112B2  ; data: 0x7f, 0xf8
0112B4  ; data: 0xff, 0xf9
0112B6  ; data: 0xff, 0xff
0112B8  ; data: 0xff, 0xe0
0112BA  ; data: 0xff, 0xf8
0112BC  ; data: 0xff, 0xf8
0112BE  ori.b  #$0, d0
0112C2  ori.b  #$c, d1
0112C6  ori.b  #$0, d1
0112CA  bset.b d1, $0.w
0112CE  ori.b  #$0, d0
0112D2  ori.b  #$0, d0
0112D6  ori.b  #$0, d0
0112DA  ori.b  #$0, d0
0112DE  ori.b  #$0, d0
0112E2  ori.b  #$0, d0
0112E6  ori.b  #$0, d0
0112EA  ori.b  #$0, d0
0112EE  ori.b  #$0, d0
0112F2  ; data: 0x03, 0xff
0112F4  ; data: 0xff, 0xfe
0112F6  ; data: 0x00, 0x0f
0112F8  ; data: 0xff, 0xfc
0112FA  ; data: 0x00, 0x7f
0112FC  ; data: 0xff, 0xc0
0112FE  ; data: 0x7f, 0xf8
011300  ; data: 0xff, 0xf9
011302  ; data: 0xff, 0xff
011304  ; data: 0xff, 0xe0
011306  ; data: 0x7f, 0xf8
011308  ; data: 0xff, 0xf0
01130A  ori.b  #$0, d0
01130E  ori.b  #$c, d1
011312  ori.b  #$0, d1
011316  movep.w $0(a4), d1
01131A  ori.b  #$0, d0
01131E  ori.b  #$0, d0
011322  ori.b  #$0, d0
011326  ori.b  #$0, d0
01132A  ori.b  #$0, d0
01132E  ori.b  #$0, d0
011332  ori.b  #$0, d0
011336  ori.b  #$0, d0
01133A  ori.b  #$0, d0
01133E  ; data: 0x03, 0xff
011340  ; data: 0xff, 0xfe
011342  ori.b  #$fe, (a7)+
011346  ; data: 0x00, 0x7f
011348  ; data: 0xff, 0xe0
01134A  ; data: 0x7f, 0xf8
01134C  ; data: 0xff, 0xf8
01134E  ; data: 0x03, 0xff
011350  asr.b  #$8, d0
011352  ; data: 0x7f, 0xfd
011354  ; data: 0xff, 0xf0
011356  ori.b  #$0, d0
01135A  ori.b  #$c, d1
01135E  ori.b  #$0, d7
011362  movep.w $0(a4), d1
011366  ori.b  #$0, d0
01136A  ori.b  #$0, d0
01136E  ; data: 0x01, 0xff
011370  dc.w   $f800
011372  ori.b  #$0, d0
011376  ori.b  #$0, d0
01137A  ori.b  #$0, d0
01137E  ori.b  #$80, d0
011382  ori.b  #$0, d0
011386  ori.b  #$0, d0
01138A  ; data: 0x03, 0xff
01138C  dc.w   $f0fe
01138E  ori.b  #$fe, (a7)+
011392  ; data: 0x00, 0x7f
011394  ; data: 0xff, 0xe0
011396  ; data: 0x7f, 0xf8
011398  ; data: 0xff, 0xf8
01139A  ; data: 0x03, 0xff
01139C  asr.b  #$8, d0
01139E  ; data: 0x3f, 0xfd
0113A0  ; data: 0xff, 0xe0
0113A2  ori.b  #$0, d0
0113A6  ori.b  #$f, d1
0113AA  muls.w d1, d3
0113AC  divs.w -(a0), d1
0113AE  movep.w -$800(a4), d1
0113B2  ori.b  #$0, d0
0113B6  ori.b  #$0, d0
0113BA  ; data: 0x01, 0xff
0113BC  dc.w   $fe00
0113BE  ori.b  #$0, d0
0113C2  ori.b  #$0, d0
0113C6  ori.b  #$0, d0
0113CA  ori.b  #$80, d0
0113CE  ori.b  #$0, d0
0113D2  ori.b  #$0, d0
0113D6  ; data: 0x03, 0xff
0113D8  ror.b  d0, d4
0113DA  ori.b  #$fe, (a7)+
0113DE  ; data: 0x00, 0x7f
0113E0  ; data: 0xff, 0xf0
0113E2  ; data: 0x7f, 0xf8
0113E4  ; data: 0xff, 0xf8
0113E6  ; data: 0x03, 0xff
0113E8  asr.b  #$8, d0
0113EA  ; data: 0x1f, 0xff
0113EC  ; data: 0xff, 0xc0
0113EE  ori.b  #$0, d0
0113F2  ori.b  #$c, d1
0113F6  bra.b  $11459
0113F8  or.b   $c000000(invalid.w), d3
011400  ori.b  #$0, d0
011404  ori.b  #$e0, d0
011408  move.b d0, -(a7)
01140A  ori.b  #$0, d0
01140E  ori.b  #$0, d0
011412  ori.b  #$0, d0
011416  ori.b  #$80, d0
01141A  ori.b  #$0, d0
01141E  ori.b  #$0, d0
011422  ; data: 0x03, 0xff
011424  dc.w   $f00c
011426  ; data: 0x00, 0x3f
011428  ; data: 0xff, 0xff
01142A  ; data: 0x00, 0x7f
01142C  ; data: 0xff, 0xf8
01142E  ; data: 0x7f, 0xf8
011430  ; data: 0xff, 0xf8
011432  ; data: 0x03, 0xff
011434  asr.b  #$8, d0
011436  ; data: 0x1f, 0xff
011438  ; data: 0xff, 0xc0
01143A  ori.b  #$0, d0
01143E  ori.b  #$c, d1
011442  beq.b  $11425
011444  divs.w (a0, d0.w * 2), d3
011448  dc.w   $fc00
01144A  ori.b  #$0, d0
01144E  ori.b  #$0, d0
011452  bset.b d0, -(a0)
011454  btst.l d7, d0
011456  ori.b  #$0, d0
01145A  ori.b  #$0, d0
01145E  ori.b  #$0, d0
011462  ori.b  #$80, d0
011466  ori.b  #$0, d0
01146A  ori.b  #$0, d0
01146E  ; data: 0x03, 0xff
011470  dc.w   $f800
011472  ; data: 0x00, 0x3f
011474  ; data: 0xff, 0xff
011476  ; data: 0x00, 0x7f
011478  ; data: 0xff, 0xf8
01147A  ; data: 0x7f, 0xf8
01147C  ; data: 0xff, 0xf8
01147E  ; data: 0x03, 0xff
011480  asr.b  #$8, d0
011482  ; data: 0x0f, 0xff
011484  ; data: 0xff, 0x80
011486  ori.b  #$0, d0
01148A  ori.b  #$c, d1
01148E  bge.b  $114f1
011490  or.b   d0, d3
011492  movep.w -$7400(a5), d1
011496  ori.b  #$0, d0
01149A  ori.b  #$0, d0
01149E  bset.b d0, -(a0)
0114A0  bclr.b d3, d0
0114A2  ori.b  #$0, d0
0114A6  ori.b  #$0, d0
0114AA  ori.b  #$0, d0
0114AE  ori.b  #$0, d0
0114B2  ori.b  #$0, d0
0114B6  ori.b  #$0, d0
0114BA  ; data: 0x03, 0xff
0114BC  ; data: 0xff, 0x00
0114BE  ; data: 0x00, 0x3f
0114C0  ; data: 0xff, 0xff
0114C2  ; data: 0x00, 0x7f
0114C4  ; data: 0xff, 0xfc
0114C6  ; data: 0x7f, 0xf8
0114C8  ; data: 0xff, 0xf8
0114CA  ; data: 0x03, 0xff
0114CC  asr.b  #$8, d0
0114CE  ; data: 0x0f, 0xff
0114D0  ; data: 0xff, 0x80
0114D2  ori.b  #$0, d0
0114D6  ori.b  #$c, d1
0114DA  bge.b  $1153d
0114DC  or.b   ([a0], d0.w * 2), d3
0114E0  divu.w d6, d6
0114E2  move.w d0, d0
0114E4  ori.b  #$0, d0
0114E8  ori.b  #$e0, d0
0114EC  bclr.b d3, d0
0114EE  ori.b  #$0, d0
0114F2  ori.b  #$0, d0
0114F6  ori.b  #$0, d0
0114FA  ori.b  #$0, d0
0114FE  ori.b  #$0, d0
011502  ori.b  #$0, d0
011506  ; data: 0x01, 0xff
011508  ; data: 0xff, 0xc0
01150A  ; data: 0x00, 0x7f
01150C  ; data: 0xff, 0xff
01150E  ; data: 0x80, 0x7f
011510  ; data: 0xff, 0xfe
011512  ; data: 0x7f, 0xf8
011514  ; data: 0xff, 0xf8
011516  ; data: 0x03, 0xff
011518  asr.b  #$8, d0
01151A  ; data: 0x07, 0xff
01151C  ; data: 0xff, 0x00
01151E  ori.b  #$0, d0
011522  ori.b  #$c, d1
011526  beq.b  $11508
011528  muls.w -(a0), d1
01152A  movep.w -$33a(a4), d1
01152E  move.w d0, d0
011530  ori.b  #$0, d0
011534  ori.b  #$e0, d0
011538  bclr.b d3, d0
01153A  ori.b  #$0, d0
01153E  ori.b  #$0, d0
011542  ori.b  #$0, d0
011546  ori.b  #$0, d0
01154A  ori.b  #$0, d0
01154E  ori.b  #$0, d0
011552  ; data: 0x01, 0xff
011554  ; data: 0xff, 0xf0
011556  ; data: 0x00, 0x7f
011558  ; data: 0xff, 0xff
01155A  ; data: 0x80, 0x7f
01155C  ; data: 0xff, 0xfe
01155E  ; data: 0x7f, 0xf8
011560  ; data: 0xff, 0xf8
011562  ; data: 0x03, 0xff
011564  asr.b  #$8, d0
011566  ; data: 0x03, 0xff
011568  dc.w   $fe00
01156A  ori.b  #$0, d0
01156E  ori.b  #$0, d0
011572  ori.b  #$0, d0
011576  ori.b  #$0, d0
01157A  ori.b  #$0, d0
01157E  ori.b  #$0, d0
011582  bset.b d0, -(a0)
011584  bclr.b d3, d0
011586  ori.b  #$0, d0
01158A  ori.b  #$0, d0
01158E  ori.b  #$0, d0
011592  ori.b  #$0, d0
011596  ori.b  #$0, d0
01159A  ori.b  #$0, d0
01159E  ; data: 0x00, 0xff
0115A0  ; data: 0xff, 0xfc
0115A2  ; data: 0x00, 0x7f
0115A4  ; data: 0xf3, 0xff
0115A6  ; data: 0x80, 0x7f
0115A8  ; data: 0xff, 0xff
0115AA  ; data: 0x7f, 0xf8
0115AC  ; data: 0xff, 0xf8
0115AE  ; data: 0x03, 0xff
0115B0  asr.b  #$8, d0
0115B2  ; data: 0x03, 0xff
0115B4  dc.w   $fe00
0115B6  ori.b  #$0, d0
0115BA  ori.b  #$0, d0
0115BE  ori.b  #$0, d0
0115C2  ori.b  #$0, d0
0115C6  ori.b  #$0, d0
0115CA  ori.b  #$0, d0
0115CE  bset.b d0, -(a0)
0115D0  bclr.b d3, d0
0115D2  ori.b  #$0, d0
0115D6  ori.b  #$0, d0
0115DA  ori.b  #$0, d0
0115DE  ori.b  #$0, d0
0115E2  ori.b  #$0, d0
0115E6  ori.b  #$0, d0
0115EA  ; data: 0x00, 0x7f
0115EC  ; data: 0xff, 0xfe
0115EE  ; data: 0x00, 0xff
0115F0  ; data: 0xf3, 0xff
0115F2  ; data: 0xc0, 0x7f
0115F4  ; data: 0xff, 0xff
0115F6  ; data: 0x7f, 0xf8
0115F8  ; data: 0xff, 0xf8
0115FA  ; data: 0x03, 0xff
0115FC  asr.b  #$8, d0
0115FE  ; data: 0x01, 0xff
011600  dc.w   $fc00
011602  ori.b  #$0, d0
011606  ori.b  #$0, d1
01160A  ori.b  #$0, d0
01160E  ori.b  #$0, d0
011612  ori.b  #$0, d0
011616  ori.b  #$0, d0
01161A  bset.b d0, -(a0)
01161C  bclr.b d3, d0
01161E  ori.b  #$0, d0
011622  ori.b  #$0, d0
011626  ori.b  #$0, d0
01162A  ori.b  #$0, d0
01162E  ori.b  #$0, d0
011632  ori.b  #$0, d0
011636  ; data: 0x00, 0x3f
011638  ; data: 0xff, 0xff
01163A  ; data: 0x00, 0xff
01163C  ; data: 0xf3, 0xff
01163E  ; data: 0xc0, 0x7f
011640  ; data: 0xfb, 0xff
011642  ; data: 0xff, 0xf8
011644  ; data: 0xff, 0xf8
011646  ; data: 0x03, 0xff
011648  asr.b  #$8, d0
01164A  ; data: 0x00, 0xff
01164C  dc.w   $f800
01164E  ori.b  #$0, d0
011652  ori.b  #$0, d3
011656  bset.b d0, (a4)+
011658  ; data: 0x00, 0x3b
01165A  or.b   d0, d0
01165C  bset.b d0, (a4)+
01165E  ori.b  #$0, d0
011662  ori.b  #$0, d0
011666  bset.b d0, -(a0)
011668  bclr.b d3, d0
01166A  ori.b  #$0, d0
01166E  ori.b  #$0, d0
011672  ori.b  #$0, d0
011676  ori.b  #$0, d0
01167A  ori.b  #$0, d0
01167E  ori.b  #$0, d0
011682  ori.b  #$ff, (a7)+
011686  ; data: 0x80, 0xff
011688  ; data: 0xf3, 0xff
01168A  ; data: 0xc0, 0x7f
01168C  ; data: 0xfb, 0xff
01168E  ; data: 0xff, 0xf8
011690  ; data: 0xff, 0xf8
011692  ; data: 0x03, 0xff
011694  asr.b  #$8, d0
011696  ; data: 0x00, 0xff
011698  dc.w   $f800
01169A  ori.b  #$0, d0
01169E  ori.b  #$0, d3
0116A2  ; data: 0x03, 0xfe
0116A4  ; data: 0x00, 0x7f
0116A6  and.b  d0, d0
0116A8  ; data: 0x03, 0xfe
0116AA  ori.b  #$0, d0
0116AE  ori.b  #$0, d0
0116B2  bset.b d0, -(a0)
0116B4  bclr.b d3, d3
0116B6  ; data: 0xf0, 0x7f
0116B8  ; data: 0xff, 0xfe
0116BA  bset.b d0, (a0, d0.w)
0116BE  dc.w   $f80f
0116C0  moveq  #$0, d7
0116C2  ; data: 0x00, 0x3f
0116C4  ; data: 0xf7, 0x83
0116C6  dc.w   $f000
0116C8  ori.b  #$0, d0
0116CC  ori.b  #$7, d0
0116D0  ; data: 0xff, 0xff
0116D2  ; data: 0x81, 0xff
0116D4  ; data: 0xe1, 0xff
0116D6  ror.w  d0, d7
0116D8  ; data: 0xf9, 0xff
0116DA  ; data: 0xff, 0xf8
0116DC  ; data: 0xff, 0xf8
0116DE  ; data: 0x03, 0xff
0116E0  asr.b  #$8, d0
0116E2  ; data: 0x00, 0xff
0116E4  dc.w   $f800
0116E6  ori.b  #$0, d0
0116EA  ori.b  #$0, d1
0116EE  ; data: 0x03, 0xfe
0116F0  ; data: 0x00, 0x7f
0116F2  and.b  d0, d0
0116F4  ; data: 0x03, 0xfe
0116F6  ori.b  #$0, d0
0116FA  ori.b  #$0, d0
0116FE  bset.b d0, -(a0)
011700  movep.w d3, -$381(a7)
011704  ; data: 0xff, 0xff
011706  divs.w #$3, d3
01170A  dc.w   $fe0f
01170C  ; data: 0xff, 0x80
01170E  ; data: 0x00, 0xff
011710  ; data: 0xf7, 0x8f
011712  dc.w   $fc00
011714  ori.b  #$0, d0
011718  ori.b  #$1, d0
01171C  ; data: 0xff, 0xff
01171E  ; data: 0xc1, 0xff
011720  ; data: 0xe1, 0xff
011722  ror.w  d0, d7
011724  ; data: 0xf9, 0xff
011726  ; data: 0xff, 0xf8
011728  ; data: 0xff, 0xf8
01172A  ; data: 0x03, 0xff
01172C  asr.b  #$8, d0
01172E  ; data: 0x00, 0xff
011730  dc.w   $f800
011732  ori.b  #$0, d0
011736  ori.b  #$0, d0
01173A  ; data: 0x01, 0xfc
01173C  ; data: 0x00, 0x3f
01173E  or.b   d0, d0
011740  ; data: 0x01, 0xfc
011742  ori.b  #$0, d0
011746  ori.b  #$0, d0
01174A  bset.b d0, -(a0)
01174C  bclr.b d3, (a6)+
01174E  ; data: 0x1e, 0x78
011750  move.b d7, d7
011752  or.b   d7, (a6)+
011754  ori.b  #$f, d7
011758  muls.w d0, d1
01175A  bset.b d0, ([], a7.w * 8, $1e00)
011760  ori.b  #$0, d0
011764  ori.b  #$0, d0
011768  ; data: 0x7f, 0xff
01176A  ; data: 0xc1, 0xff
01176C  ; data: 0xff, 0xff
01176E  ror.w  d0, d7
011770  dc.w   $f8ff
011772  ; data: 0xff, 0xf8
011774  ; data: 0xff, 0xf8
011776  ; data: 0x03, 0xff
011778  asr.b  #$8, d0
01177A  ; data: 0x00, 0xff
01177C  dc.w   $f800
01177E  ori.b  #$0, d0
011782  ori.b  #$0, d0
011786  ori.w  #$e, (a0, d0.w)
01178C  ori.w  #$0, (a0, d0.w)
011792  ori.b  #$0, d0
011796  bset.b d0, -(a0)
011798  bclr.b d3, (a4)+
01179A  ; data: 0x0e, 0x78
01179C  move.b d7, d7
01179E  ; data: 0x9e, 0x0f
0117A0  ; data: 0x00, 0x0f
0117A2  movep.w d3, -$7c40(a7)
0117A6  bset.b d0, -(a0)
0117A8  ; data: 0xf7, 0x9c
0117AA  ; data: 0x0e, 0x00
0117AC  ori.b  #$0, d0
0117B0  ori.b  #$c0, d0
0117B4  ; data: 0x1f, 0xff
0117B6  ; data: 0xc3, 0xff
0117B8  ; data: 0xff, 0xff
0117BA  ; data: 0xf0, 0x7f
0117BC  ; data: 0xf8, 0x7f
0117BE  ; data: 0xff, 0xf8
0117C0  ; data: 0xff, 0xf8
0117C2  ; data: 0x03, 0xff
0117C4  asr.b  #$8, d0
0117C6  ; data: 0x00, 0xff
0117C8  dc.w   $f800
0117CA  ori.b  #$0, d0
0117CE  ori.b  #$1d, d0
0117D2  and.b  -(a0), d0
0117D4  ori.b  #$0, d4
0117D8  ori.b  #$0, -(a0)
0117DC  ori.b  #$0, d0
0117E0  ori.b  #$e0, d0
0117E4  ; data: 0x07, 0xbc
0117E6  bchg.b d7, $1e07.w
0117EA  sub.b  d7, d6
0117EC  ; data: 0x00, 0x0e
0117EE  movep.w d1, -$8000(a7)
0117F2  bset.b d1, d0
0117F4  ; data: 0xf7, 0xbc
0117F6  btst.l d7, d0
0117F8  ori.b  #$0, d0
0117FC  ori.b  #$f0, d0
011800  ; data: 0x0f, 0xff
011802  ; data: 0xc3, 0xff
011804  ; data: 0xff, 0xff
011806  ; data: 0xf0, 0x7f
011808  dc.w   $f83f
01180A  ; data: 0xff, 0xf8
01180C  ; data: 0xff, 0xf8
01180E  ; data: 0x03, 0xff
011810  asr.b  #$8, d0
011812  ; data: 0x00, 0xff
011814  dc.w   $f800
011816  ori.b  #$0, d0
01181A  ori.b  #$3f, d0
01181E  asr.b  #$8, d0
011820  ori.b  #$3, d0
011824  cmp.b  d0, d4
011826  ori.b  #$0, d0
01182A  ori.b  #$0, d0
01182E  bset.b d0, -(a0)
011830  ; data: 0x07, 0xbc
011832  bchg.b d7, $1e07.w
011836  cmp.b  d7, d6
011838  or.b   (a6)+, d0
01183A  movep.l d1, $0(a7)
01183E  bset.b d1, d0
011840  ; data: 0xf7, 0xbc
011842  btst.l d7, d0
011844  ori.b  #$0, d0
011848  ori.b  #$fe, d0
01184C  ; data: 0x1f, 0xff
01184E  ; data: 0xc3, 0xff
011850  ; data: 0xff, 0xff
011852  ; data: 0xf0, 0x7f
011854  dc.w   $f83f
011856  ; data: 0xff, 0xf8
011858  ; data: 0xff, 0xf8
01185A  ; data: 0x03, 0xff
01185C  asr.b  #$8, d0
01185E  ; data: 0x00, 0xff
011860  dc.w   $f800
011862  ori.b  #$0, d0
011866  ori.b  #$3f, d0
01186A  asr.b  #$8, d0
01186C  ori.b  #$7, d0
011870  dc.w   $fc00
011872  ori.b  #$0, d0
011876  ori.b  #$0, d0
01187A  bset.b d0, -(a0)
01187C  ; data: 0x07, 0xbf
01187E  dc.w   $ff78
011880  move.b d7, d7
011882  cmp.b  d7, d6
011884  or.b   (a6)+, d0
011886  movep.l d1, $0(a7)
01188A  bset.b d1, d0
01188C  ; data: 0xf7, 0xbf
01188E  ; data: 0xff, 0x00
011890  ori.b  #$0, d0
011894  ori.b  #$ff, d0
011898  ; data: 0xff, 0xff
01189A  ; data: 0xc7, 0xff
01189C  ; data: 0xff, 0xff
01189E  ; data: 0xf8, 0x7f
0118A0  dc.w   $f81f
0118A2  ; data: 0xff, 0xf8
0118A4  ; data: 0xff, 0xf8
0118A6  ; data: 0x03, 0xff
0118A8  asr.b  #$8, d0
0118AA  ; data: 0x00, 0xff
0118AC  dc.w   $f800
0118AE  ori.b  #$0, d0
0118B2  ori.b  #$1f, d3
0118B6  ; data: 0xc0, 0x0e
0118B8  asr.b  #$8, d0
0118BA  ori.b  #$0, d7
0118BE  ori.b  #$0, d0
0118C2  ori.b  #$0, d0
0118C6  bset.b d0, -(a0)
0118C8  ; data: 0x07, 0xbf
0118CA  dc.w   $ff78
0118CC  move.b d7, d7
0118CE  cmp.b  d7, d6
0118D0  or.b   (a6)+, d0
0118D2  movep.l d1, $0(a7)
0118D6  bset.b d1, d0
0118D8  ; data: 0xf7, 0xbf
0118DA  ; data: 0xff, 0x00
0118DC  ori.b  #$0, d0
0118E0  ori.b  #$ff, d0
0118E4  ; data: 0xff, 0xff
0118E6  ; data: 0xc7, 0xff
0118E8  ; data: 0xff, 0xff
0118EA  ; data: 0xf8, 0x7f
0118EC  dc.w   $f80f
0118EE  ; data: 0xff, 0xf8
0118F0  ; data: 0xff, 0xf8
0118F2  ; data: 0x03, 0xff
0118F4  asr.b  #$8, d0
0118F6  ; data: 0x00, 0xff
0118F8  dc.w   $f800
0118FA  ori.b  #$0, d0
0118FE  ori.b  #$7, d7
011902  ori.b  #$0, (a7)+
011906  ori.b  #$0, d3
01190A  ori.b  #$0, d0
01190E  ori.b  #$0, d0
011912  bset.b d0, -(a0)
011914  ; data: 0x07, 0xbc
011916  ori.w  #$1e07, $bc07.w
01191C  or.b   (a6)+, d0
01191E  movep.l d1, $0(a7)
011922  bset.b d1, d0
011924  ; data: 0xf7, 0xbc
011926  ori.b  #$0, d0
01192A  ori.b  #$0, d0
01192E  ; data: 0x03, 0xff
011930  ; data: 0xff, 0xff
011932  ; data: 0x87, 0xff
011934  ; data: 0xff, 0xff
011936  ; data: 0xf8, 0x7f
011938  dc.w   $f807
01193A  ; data: 0xff, 0xf8
01193C  ; data: 0xff, 0xf8
01193E  ; data: 0x03, 0xff
011940  asr.b  #$8, d0
011942  ; data: 0x00, 0xff
011944  dc.w   $f800
011946  ori.b  #$0, d0
01194A  ori.b  #$2, d7
01194E  ori.b  #$0, (a7)+
011952  ori.b  #$0, d0
011956  ori.b  #$0, d0
01195A  ori.b  #$0, d0
01195E  bset.b d0, -(a0)
011960  ; data: 0x07, 0xbc
011962  ori.w  #$1e07, $bc07.w
011968  or.b   (a6)+, d0
01196A  movep.l d1, $0(a7)
01196E  bset.b d1, d0
011970  ; data: 0xf7, 0xbc
011972  ori.b  #$0, d0
011976  ori.b  #$0, d0
01197A  ; data: 0x03, 0xff
01197C  ; data: 0xff, 0xff
01197E  ; data: 0x8f, 0xff
011980  ; data: 0xff, 0xff
011982  ; data: 0xfc, 0x7f
011984  dc.w   $f807
011986  ; data: 0xff, 0xf8
011988  ; data: 0xff, 0xf8
01198A  ; data: 0x03, 0xff
01198C  asr.b  #$8, d0
01198E  ; data: 0x00, 0xff
011990  dc.w   $f800
011992  ori.b  #$0, d0
011996  ori.b  #$0, d3
01199A  ; data: 0x00, 0x0f
01199C  asr.b  #$8, d0
01199E  ori.b  #$1, d0
0119A2  add.b  d0, d6
0119A4  ori.b  #$0, d0
0119A8  ori.b  #$e0, d0
0119AC  ; data: 0x07, 0xbc
0119AE  ori.w  #$1e07, $9c07.w
0119B4  ; data: 0x00, 0x0e
0119B6  movep.w d1, $0(a7)
0119BA  bset.b d1, d0
0119BC  ; data: 0xf7, 0xbc
0119BE  ori.b  #$0, d0
0119C2  ori.b  #$0, d0
0119C6  ; data: 0x03, 0xff
0119C8  ; data: 0xff, 0xff
0119CA  ; data: 0x0f, 0xff
0119CC  ; data: 0x80, 0x7f
0119CE  ; data: 0xfc, 0x7f
0119D0  dc.w   $f803
0119D2  ; data: 0xff, 0xf8
0119D4  ; data: 0xff, 0xf8
0119D6  ; data: 0x03, 0xff
0119D8  asr.b  #$8, d0
0119DA  ; data: 0x00, 0xff
0119DC  dc.w   $f800
0119DE  ori.b  #$0, d0
0119E2  ori.b  #$0, d0
0119E6  ori.b  #$0, d3
0119EA  ori.b  #$3, d0
0119EE  dc.w   $fe00
0119F0  ori.b  #$7, d0
0119F4  cmpa.l $79e0(a7), a6
0119F8  bclr.b d7, (a4)+
0119FA  bchg.b d7, $1e07.w
0119FE  ; data: 0x9e, 0x0f
011A00  ; data: 0x00, 0x0f
011A02  movep.w d3, $0(a7)
011A06  bset.b d0, -(a0)
011A08  ; data: 0xf7, 0x9c
011A0A  ; data: 0x0f, 0x7b
011A0C  adda.w (a7, a0.w), a7
011A10  ori.b  #$ff, d0
011A14  ; data: 0xff, 0xff
011A16  ; data: 0x0f, 0xff
011A18  ; data: 0x80, 0x7f
011A1A  ; data: 0xfc, 0x7f
011A1C  dc.w   $f801
011A1E  ; data: 0xff, 0xf8
011A20  ; data: 0xff, 0xf8
011A22  ; data: 0x03, 0xff
011A24  asr.b  #$8, d0
011A26  ; data: 0x00, 0xff
011A28  dc.w   $f800
011A2A  ori.b  #$0, d0
011A2E  ori.b  #$0, d0
011A32  ori.b  #$0, d1
011A36  ori.b  #$3, d0
011A3A  dc.w   $fe00
011A3C  ori.b  #$7, d0
011A40  cmpa.l $79e0(a7), a6
011A44  move.b (a6)+, -(a7)
011A46  move.b $1e07.w, -$70e2(a7)
011A4C  ori.b  #$f, d7
011A50  ori.b  #$f0, d0
011A54  ; data: 0xf7, 0x9e
011A56  move.b $11a4f(pc, a5.l), -$8000(a7)
011A5C  ori.b  #$ff, d0
011A60  ; data: 0xff, 0xfe
011A62  ; data: 0x1f, 0xff
011A64  ; data: 0x00, 0x3f
011A66  ; data: 0xfe, 0x7f
011A68  dc.w   $f800
011A6A  ; data: 0xff, 0xf8
011A6C  ; data: 0xff, 0xf8
011A6E  ; data: 0x03, 0xff
011A70  asr.b  #$8, d0
011A72  ; data: 0x00, 0xff
011A74  dc.w   $f800
011A76  ori.b  #$0, d0
011A7A  ori.b  #$0, d0
011A7E  ori.b  #$0, d0
011A82  ori.b  #$1, d0
011A86  dc.w   $fc00
011A88  ori.b  #$7, d0
011A8C  cmpa.l $79ff(a7), a6
011A90  dc.w   $fe0f
011A92  dc.w   $fe78
011A94  move.b d7, d7
011A96  divs.w #$3, d3
011A9A  dc.w   $fe0f
011A9C  ori.b  #$ff, d0
011AA0  ; data: 0xf7, 0x8f
011AA2  dc.w   $fe7b
011AA4  adda.w (a7, a0.w), a7
011AA8  ori.b  #$ff, d0
011AAC  ; data: 0xff, 0xfc
011AAE  ; data: 0x1f, 0xff
011AB0  ; data: 0x00, 0x3f
011AB2  ; data: 0xfe, 0x7f
011AB4  dc.w   $f800
011AB6  ; data: 0xff, 0xf8
011AB8  ; data: 0xff, 0xf8
011ABA  ; data: 0x03, 0xff
011ABC  asr.b  #$8, d0
011ABE  ; data: 0x00, 0xff
011AC0  dc.w   $f800
011AC2  ori.b  #$0, d0
011AC6  ori.b  #$0, d0
011ACA  ori.b  #$0, d0
011ACE  ori.b  #$0, d0
011AD2  moveq  #$0, d0
011AD4  ori.b  #$7, d0
011AD8  cmpa.l $79ff(a7), a6
011ADC  dc.w   $f803
011ADE  dc.w   $f878
011AE0  move.b d7, d7
011AE2  divs.w (a0, d0.w), d0
011AE6  dc.w   $f80f
011AE8  ori.b  #$3f, d0
011AEC  ; data: 0xf7, 0x83
011AEE  dc.w   $f87b
011AF0  adda.w (a7, a0.w), a7
011AF4  ori.b  #$7f, d0
011AF8  ; data: 0xff, 0xf0
011AFA  ; data: 0x1f, 0xff
011AFC  ; data: 0x00, 0x3f
011AFE  ; data: 0xfe, 0x7f
011B00  dc.w   $f800
011B02  ; data: 0x7f, 0xf8
011B04  ; data: 0xff, 0xf8
011B06  ; data: 0x03, 0xff
011B08  asr.b  #$8, d0
011B0A  ; data: 0x00, 0xff
011B0C  dc.w   $f800
011B0E  ori.b  #$0, d0
011B12  ori.b  #$0, d0
011B16  ori.b  #$0, d0
011B1A  ori.b  #$0, d0
011B1E  move.l d0, d0
011B20  ori.b  #$0, d0
011B24  ori.b  #$0, d0
011B28  ori.b  #$0, d0
011B2C  ori.b  #$0, d0
011B30  ori.b  #$0, d0
011B34  ori.b  #$0, d0
011B38  ori.b  #$0, d0
011B3C  ori.b  #$0, d0
011B40  ori.b  #$f, d0
011B44  ; data: 0xff, 0x80
011B46  ori.b  #$0, d0
011B4A  ori.b  #$0, d0
011B4E  ori.b  #$0, d0
011B52  ori.b  #$0, d0
011B56  ori.b  #$0, d0
011B5A  ori.b  #$0, d0
011B5E  ori.b  #$0, d0
011B62  ori.b  #$0, d0
011B66  ori.b  #$0, d0
011B6A  ori.b  #$0, d0
011B6E  ori.b  #$0, d0
011B72  ori.b  #$0, d0
011B76  ori.b  #$0, d0
011B7A  ori.b  #$0, d0
011B7E  ori.b  #$0, d0
011B82  ori.b  #$0, d0
011B86  ori.b  #$0, d0
011B8A  ori.b  #$0, d0
011B8E  ori.b  #$0, d0
011B92  ori.b  #$0, d0
011B96  ori.b  #$0, d0
011B9A  ori.b  #$0, d0
011B9E  ori.b  #$0, d0
011BA2  ori.b  #$0, d0
011BA6  ori.b  #$0, d0
011BAA  ori.b  #$0, d0
011BAE  ori.b  #$0, d0
011BB2  ori.b  #$0, d0
011BB6  ori.b  #$0, d0
011BBA  ori.b  #$0, d0
011BBE  ori.b  #$0, d0
011BC2  ori.b  #$0, d0
011BC6  ori.b  #$0, d0
011BCA  ori.b  #$0, d0
011BCE  ori.b  #$0, d0
011BD2  ori.b  #$0, d0
011BD6  ori.b  #$0, d0
011BDA  ori.b  #$0, d0
011BDE  ori.b  #$0, d0
011BE2  ori.b  #$0, d0
011BE6  ori.b  #$0, d0
011BEA  ori.b  #$0, d0
011BEE  ori.b  #$0, d0
011BF2  ori.b  #$0, d0
011BF6  ori.b  #$0, d0
011BFA  ori.b  #$0, d0
011BFE  ori.b  #$0, d0
011C02  ori.b  #$0, d0
011C06  ori.b  #$0, d0
011C0A  ori.b  #$0, d0
011C0E  ori.b  #$0, d0
011C12  ori.b  #$0, d0
011C16  ori.b  #$0, d0
011C1A  ori.b  #$0, d0
011C1E  ori.b  #$0, d0
011C22  ori.b  #$0, d0
011C26  ori.b  #$0, d0
011C2A  ori.b  #$0, d0
011C2E  ori.b  #$0, d0
011C32  ori.b  #$0, d0
011C36  ori.b  #$0, d0
011C3A  ori.b  #$0, d0
011C3E  ori.b  #$0, d0
011C42  ori.b  #$0, d0
011C46  ori.b  #$0, d0
011C4A  ori.b  #$0, d0
011C4E  ori.b  #$0, d0
011C52  ori.b  #$0, d0
011C56  ori.b  #$0, d0
011C5A  ori.b  #$0, d0
011C5E  ori.b  #$0, d0
011C62  ori.b  #$0, d0
011C66  ori.b  #$0, d0
011C6A  ori.b  #$0, d0
011C6E  ori.b  #$0, d0
011C72  ori.b  #$0, d0
011C76  ori.b  #$0, d0
011C7A  ori.b  #$0, d0
011C7E  ori.b  #$0, d0
011C82  ori.b  #$0, d0
011C86  ori.b  #$0, d0
011C8A  ori.b  #$0, d0
011C8E  ori.b  #$0, d0
011C92  ori.b  #$0, d0
011C96  ori.b  #$0, d0
011C9A  ori.b  #$0, d0
011C9E  ori.b  #$0, d0
011CA2  ori.b  #$0, d0
011CA6  ori.b  #$0, d0
011CAA  ori.b  #$0, d0
011CAE  ori.b  #$0, d0
011CB2  ori.b  #$0, d0
011CB6  ori.b  #$0, d0
011CBA  ori.b  #$0, d0
011CBE  ori.b  #$0, d0
011CC2  ori.b  #$0, d0
011CC6  ori.b  #$0, d0
011CCA  ori.b  #$0, d0
011CCE  ori.b  #$0, d0
011CD2  ori.b  #$0, d0
011CD6  ori.b  #$0, d0
011CDA  ori.b  #$0, d0
011CDE  ori.b  #$0, d0
011CE2  ori.b  #$0, d0
011CE6  ori.b  #$0, d0
011CEA  ori.b  #$0, d0
011CEE  ori.b  #$0, d0
011CF2  ori.b  #$0, d0
011CF6  ori.b  #$0, d0
011CFA  ori.b  #$0, d0
011CFE  ori.b  #$0, d0
011D02  ori.b  #$0, d0
011D06  ori.b  #$0, d0
011D0A  ori.b  #$0, d0
011D0E  ori.b  #$0, d0
011D12  ori.b  #$0, d0
011D16  ori.b  #$0, d0
011D1A  ori.b  #$0, d0
011D1E  ori.b  #$0, d0
011D22  ori.b  #$0, d0
011D26  ori.b  #$0, d0
011D2A  ori.b  #$0, d0
011D2E  ori.b  #$0, d0
011D32  ori.b  #$0, d0
011D36  ori.b  #$0, d0
011D3A  ori.b  #$0, d0
011D3E  ori.b  #$0, d0
011D42  ori.b  #$0, d0
011D46  ori.b  #$0, d0
011D4A  ori.b  #$0, d0
011D4E  ori.b  #$0, d0
011D52  ori.b  #$0, d0
011D56  ori.b  #$aa, d0