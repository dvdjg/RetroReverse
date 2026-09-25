; mod_004_c70212_34956.bin desensamblado
; base 0x4 len 34956
; sha1 758592b2509f6d7adbf3d9e5a9b6ec49aa0200de

00000004  jmp    $10.l
0000000A  jmp    $9a.l
00000010  ; data: 0x73, 0x6f
00000012  ; data: 0x73, 0x00
00000014  movea.l $4.w, a6
00000018  movea.l $114(a6), a4
0000001C  tst.l  $ac(a4)
00000020  bne.b  $3c
00000022  lea.l  $5c(a4), a0
00000026  jsr    -$180(a6)
0000002A  lea.l  $5c(a4), a0
0000002E  jsr    -$174(a6)
00000032  move.l d0, $7a.l
00000038  lea.l  $82(pc), a2
0000003C  lea.l  $92(pc), a1
00000040  moveq  #$0, d0
00000042  movea.l $4.w, a6
00000046  jsr    -$228(a6)
0000004A  tst.l  d0
0000004C  beq.b  $66
0000004E  movea.l d0, a6
00000050  move.l a6, -(a7)
00000052  lea.l  $9a.l, a0
00000058  jsr    -$1e(a6)
0000005C  movea.l (a7)+, a1
0000005E  movea.l $4.w, a6
00000062  jsr    -$19e(a6)
00000066  move.l $7e(pc), d2
0000006A  beq.b  $7a
0000006C  movea.l $4.w, a6
00000070  jsr    -$84(a6)
00000074  movea.l d2, a1
00000076  jsr    -$17a(a6)
0000007A  moveq  #$0, d0
0000007C  rts    
0000007E  ori.b  #$0, d0
00000082  ori.b  #$0, d0
00000086  ori.b  #$0, d0
0000008A  ori.b  #$0, d0
0000008E  ori.b  #$0, d0
00000092  ; data: 0x73, 0x6f
00000094  ; data: 0x73, 0x2e
00000096  bge.b  $101
00000098  bhi.b  $10c
0000009A  bsr.b  $10e
0000009C  ; data: 0x79, 0x00
0000009E  moveq  #$8, d0
000000A0  suba.l a0, a0
000000A2  jsr    -$ba(a6)
000000A6  lea.l  $0.l, a5
000000AC  move.l a6, $0(a5)
000000B0  move.l a2, -(a7)
000000B2  jsr    -$11a(a6)
000000B6  movea.l a0, a2
000000B8  movea.l $26(a2), a0
000000BC  move.l a0, d0
000000BE  bne.b  $d6
000000C0  moveq  #$1c, d0
000000C2  moveq  #$0, d1
000000C4  jsr    -$2a(a6)
000000C8  movea.l d0, a0
000000CA  moveq  #$6, d1
000000CC  clr.l  (a0)+
000000CE  dbra   d1, $cc
000000D2  move.l d0, $26(a2)
000000D6  movea.l d0, a2
000000D8  move.l a2, $8(a5)
000000DC  tst.w  $e(a2)
000000E0  bne.b  $e8
000000E2  move.w #$3c0, $e(a2)
000000E8  tst.l  $4(a2)
000000EC  bne.b  $108
000000EE  move.l #$44425547, d0
000000F4  jsr    -$138(a6)
000000F8  movea.l $8(a5), a1
000000FC  move.l a0, $18(a1)
00000100  move.l #$114, $4(a2)
00000108  tst.l  $8(a2)
0000010C  bne.b  $158
0000010E  move.l #$12c, $8(a2)
00000116  bra.b  $158
00000118  move.l a5, -(a7)
0000011A  lea.l  $0.l, a5
00000120  movea.l $8(a5), a4
00000124  movea.l $18(a4), a4
00000128  jsr    -$c(a4)
0000012C  movea.l (a7)+, a5
0000012E  rts    
00000130  move.l a5, -(a7)
00000132  lea.l  $0.l, a5
00000138  movea.l $8(a5), a0
0000013C  btst.b #$2, $dff016.l
00000144  bne.b  $150
00000146  move.w $e(a0), $c(a0)
0000014C  movea.l (a7)+, a5
0000014E  rts    
00000150  movea.l (a7)+, a5
00000152  addq.w #$1, $c(a0)
00000156  rts    
00000158  movea.l (a7)+, a2
0000015A  bsr.w  $5ea
0000015E  movea.l $8(a5), a0
00000162  movea.l $4(a0), a0
00000166  jsr    (a0)
00000168  movea.l $8(a5), a0
0000016C  move.w $c(a0), d0
00000170  cmp.w  $10(a0), d0
00000174  bcs.b  $15e
00000176  lea.l  $0.l, a0
0000017C  lea.l  $1bc(pc), a1
00000180  moveq  #$20, d0
00000182  jsr    -$54(a6)
00000186  bsr.w  $4c6
0000018A  bsr.w  $1e8
0000018E  jsr    -$11a(a6)
00000192  movea.l $26(a0), a1
00000196  cmpi.w #$13, $1c(a1)
0000019C  beq.b  $1b8
0000019E  movea.l $8(a5), a0
000001A2  movea.l $4(a0), a0
000001A6  jsr    (a0)
000001A8  movea.l $8(a5), a0
000001AC  move.w $c(a0), d0
000001B0  cmp.w  $e(a0), d0
000001B4  bcs.w  $18a
000001B8  moveq  #$0, d0
000001BA  rts    
000001BC  movem.l d0-d7/a0-a6, -(a7)
000001C0  lea.l  $0.l, a5
000001C6  movea.l $0(a5), a6
000001CA  movea.l $8(a5), a0
000001CE  movea.l $8(a0), a0
000001D2  jsr    (a0)
000001D4  bsr.w  $1ea
000001D8  movem.l (a7)+, d0-d7/a0-a6
000001DC  move.w #$30, $dff09c.l
000001E4  nop    
000001E6  rte    
000001E8  rts    
000001EA  addq.w #$1, $21e.l
000001F0  cmpi.w #$5, $21e.l
000001F8  ble.b  $220
000001FA  cmpi.w #$380, $21e.l
00000202  bne.b  $20c
00000204  move.b #$10, $f84.l
0000020C  bsr.w  $eda
00000210  bsr.w  $e56
00000214  bsr.w  $224
00000218  bsr.w  $e22
0000021C  bsr.w  $37e
00000220  rts    
00000222  ori.b  #$39, d0
00000226  ori.b  #$72, d0
0000022A  tst.w  d0
0000022C  ble.w  $2f4
00000230  bsr.w  $342
00000234  move.w #$3, d7
00000238  move.w #$100, d6
0000023C  move.w #$5200, d5
00000240  bsr.w  $2f6
00000244  subi.w #$4, $372.l
0000024C  move.w $374.l, d0
00000252  bsr.w  $342
00000256  move.w #$3, d7
0000025A  move.w #$100, d6
0000025E  move.w #$5200, d5
00000262  bsr.w  $31c
00000266  addi.w #$4, $374.l
0000026E  lea.l  $6a.l, a0
00000274  move.l $5e2.l, d0
0000027A  move.w $372.l, d1
00000280  subi.w #$20, d1
00000284  tst.w  d1
00000286  bgt.b  $28a
00000288  moveq  #$0, d1
0000028A  mulu.w #$1c, d1
0000028E  add.l  d1, d0
00000290  move.w #$3, d7
00000294  move.w d0, $4(a0)
00000298  swap   d0
0000029A  move.w d0, (a0)
0000029C  swap   d0
0000029E  addi.l #$1880, d0
000002A4  lea.l  $8(a0), a0
000002A8  dbra   d7, $294
000002AC  move.w $376.l, d0
000002B2  tst.w  d0
000002B4  ble.b  $2f4
000002B6  bsr.w  $342
000002BA  move.w #$3, d7
000002BE  move.w #$411, d6
000002C2  move.w #$200, d5
000002C6  bsr.w  $2f6
000002CA  subi.w #$4, $376.l
000002D2  move.w $378.l, d0
000002D8  bsr.w  $342
000002DC  move.w #$3, d7
000002E0  move.w #$411, d6
000002E4  move.w #$200, d5
000002E8  bsr.w  $31c
000002EC  addi.w #$4, $378.l
000002F4  rts    
000002F6  lea.l  $228.l, a1
000002FC  cmpa.l a1, a0
000002FE  blt.b  $30e
00000300  move.w d5, -$6(a0)
00000304  move.w d6, -$2(a0)
00000308  lea.l  -$10(a0), a0
0000030C  bra.b  $316
0000030E  move.w d6, -$2(a0)
00000312  lea.l  -$8(a0), a0
00000316  dbra   d7, $2f6
0000031A  rts    
0000031C  lea.l  $1010.l, a1
00000322  cmpa.l a1, a0
00000324  bgt.b  $334
00000326  move.w d5, $a(a0)
0000032A  move.w d6, $e(a0)
0000032E  lea.l  $10(a0), a0
00000332  bra.b  $33c
00000334  move.w d6, $6(a0)
00000338  lea.l  $8(a0), a0
0000033C  dbra   d7, $31c
00000340  rts    
00000342  lea.l  $120.l, a0
00000348  cmp.w  #$20, d0
0000034C  bgt.b  $354
0000034E  lsl.w  #$3, d0
00000350  adda.w d0, a0
00000352  bra.b  $374
00000354  cmp.w  #$100, d0
00000358  bgt.b  $368
0000035A  subi.w #$20, d0
0000035E  lsl.w  #$4, d0
00000360  lea.l  $100(a0), a0
00000364  adda.w d0, a0
00000366  bra.b  $374
00000368  subi.w #$100, d0
0000036C  lsl.w  #$3, d0
0000036E  lea.l  $f00(a0), a0
00000372  adda.w d0, a0
00000374  rts    
00000376  ori.b  #$0, d0
0000037A  ori.b  #$0, d0
0000037E  movea.l $6da.l, a1
00000384  adda.w $4ba.l, a1
0000038A  movea.l $6d2.l, a2
00000390  lea.l  $7d6.l, a3
00000396  adda.w $4bc.l, a3
0000039C  move.w #$23, d7
000003A0  movea.l (a3)+, a4
000003A2  jsr    (a4)
000003A4  lea.l  $5a0(a1), a1
000003A8  movea.l (a3)+, a4
000003AA  jsr    (a4)
000003AC  lea.l  $5a0(a1), a1
000003B0  movea.l (a3)+, a4
000003B2  jsr    (a4)
000003B4  lea.l  $5a0(a1), a1
000003B8  movea.l (a3)+, a4
000003BA  jsr    (a4)
000003BC  lea.l  $5a0(a1), a1
000003C0  movea.l (a3)+, a4
000003C2  jsr    (a4)
000003C4  lea.l  $5a0(a1), a1
000003C8  dbra   d7, $3a0
000003CC  move.w $4b8.l, (a2)+
000003D2  bsr.w  $dfa
000003D6  move.w #$3, d0
000003DA  move.w #$c, d1
000003DE  move.w #$30, d2
000003E2  move.w #$c0, d3
000003E6  movea.l $ea0.l, a0
000003EC  movea.l $6d2.l, a2
000003F2  jsr    (a2)
000003F4  bra.w  $42a
000003F8  addi.w #$4, $4ba.l
00000400  cmpi.w #$2d0, $4ba.l
00000408  blt.b  $412
0000040A  subi.w #$2d0, $4ba.l
00000412  subi.w #$8, $4bc.l
0000041A  tst.w  $4bc.l
00000420  bge.b  $42a
00000422  addi.w #$2d0, $4bc.l
0000042A  lea.l  $1040.l, a0
00000430  adda.w $4be.l, a0
00000436  addi.w #$6, $4be.l
0000043E  cmpi.w #$2ca, $4be.l
00000446  blt.b  $450
00000448  subi.w #$2c4, $4be.l
00000450  move.w (a0), d0
00000452  muls.w #$a0, d0
00000456  swap   d0
00000458  addi.w #$50, d0
0000045C  cmp.w  #$b4, d0
00000460  blt.b  $468
00000462  subi.w #$b4, d0
00000466  bra.b  $45c
00000468  add.w  d0, d0
0000046A  add.w  d0, d0
0000046C  move.w d0, $4ba.l
00000472  lea.l  $1040.l, a0
00000478  adda.w $4c0.l, a0
0000047E  addi.w #$2, $4c0.l
00000486  cmpi.w #$2d0, $4c0.l
0000048E  bne.b  $498
00000490  subi.w #$2d0, $4c0.l
00000498  move.w (a0), d0
0000049A  muls.w #$190, d0
0000049E  swap   d0
000004A0  addi.w #$c8, d0
000004A4  cmp.w  #$b4, d0
000004A8  blt.b  $4b0
000004AA  subi.w #$b4, d0
000004AE  bra.b  $4a4
000004B0  add.w  d0, d0
000004B2  add.w  d0, d0
000004B4  move.w d0, $4bc.l
000004BA  rts    
000004BC  rts    
000004BE  ori.b  #$0, d0
000004C2  ori.b  #$0, d0
000004C6  lea.l  $28.l, a0
000004CC  move.l #$1124, d0
000004D2  moveq  #$0, d1
000004D4  moveq  #$8, d2
000004D6  move.w #$120, d3
000004DA  jsr    -$72(a6)
000004DE  jsr    -$11a(a6)
000004E2  move.w $1c(a0), d0
000004E6  or.w   d0, $16.l
000004EC  movem.l a4-a6, -(a7)
000004F0  move.l #$6200, d0
000004F6  move.l #$1, d1
000004FC  jsr    -$2a(a6)
00000500  move.l d0, $5e2.l
00000506  movea.l d0, a1
00000508  lea.l  $268c.l, a0
0000050E  move.w #$30f, d7
00000512  move.l (a0)+, (a1)+
00000514  move.l (a0)+, (a1)+
00000516  move.l (a0)+, (a1)+
00000518  move.l (a0)+, (a1)+
0000051A  move.l (a0)+, (a1)+
0000051C  move.l (a0)+, (a1)+
0000051E  move.l (a0)+, (a1)+
00000520  move.l (a0)+, (a1)+
00000522  dbra   d7, $512
00000526  lea.l  $6a.l, a0
0000052C  move.l $5e2.l, d0
00000532  move.w #$3, d7
00000536  move.w d0, $4(a0)
0000053A  swap   d0
0000053C  move.w d0, (a0)
0000053E  swap   d0
00000540  addi.l #$1880, d0
00000546  lea.l  $8(a0), a0
0000054A  dbra   d7, $536
0000054E  move.l #$49d4, d0
00000554  move.l #$41, d1
0000055A  jsr    -$30(a6)
0000055E  lea.l  $ea6.l, a0
00000564  move.l d0, (a0)
00000566  move.l d0, $18(a0)
0000056A  addi.l #$189c, d0
00000570  move.l d0, $8(a0)
00000574  move.l d0, $20(a0)
00000578  addi.l #$189c, d0
0000057E  move.l d0, $10(a0)
00000582  move.l d0, $28(a0)
00000586  bsr.w  $e56
0000058A  lea.l  $ea6.l, a0
00000590  move.l (a0), d0
00000592  move.l $8(a0), d1
00000596  move.l $10(a0), d2
0000059A  lea.l  $1144.l, a0
000005A0  lea.l  $1304.l, a1
000005A6  lea.l  $14c4.l, a2
000005AC  move.w #$6f, d7
000005B0  move.w d0, (a0)+
000005B2  move.w d1, (a1)+
000005B4  move.w d2, (a2)+
000005B6  move.w d0, (a0)+
000005B8  move.w d1, (a1)+
000005BA  move.w d2, (a2)+
000005BC  addi.l #$1c, d0
000005C2  addi.l #$1c, d1
000005C8  addi.l #$1c, d2
000005CE  dbra   d7, $5b0
000005D2  lea.l  $dff002.l, a4
000005D8  move.l #$ffffffff, $42(a4)
000005E0  movem.l (a7)+, a4-a6
000005E4  rts    
000005E6  ori.b  #$0, d0
000005EA  lea.l  $28.l, a0
000005F0  move.l #$1124, d0
000005F6  moveq  #$0, d1
000005F8  moveq  #$8, d2
000005FA  move.w #$120, d3
000005FE  jsr    -$72(a6)
00000602  jsr    -$11a(a6)
00000606  move.w $1c(a0), d0
0000060A  or.w   d0, $16.l
00000610  movem.l a4-a6, -(a7)
00000614  move.l #$2ee0, d0
0000061A  move.l #$0, d1
00000620  jsr    -$2a(a6)
00000624  move.l d0, $6d2.l
0000062A  move.l #$2ee0, d0
00000630  move.l #$0, d1
00000636  jsr    -$2a(a6)
0000063A  move.l d0, $6d6.l
00000640  move.l #$3f480, d0
00000646  move.l #$0, d1
0000064C  jsr    -$2a(a6)
00000650  move.l d0, $6da.l
00000656  lea.l  $156c.l, a0
0000065C  lea.l  $9a.l, a1
00000662  moveq  #$1f, d7
00000664  move.w (a0)+, (a1)
00000666  addq.w #$4, a1
00000668  dbra   d7, $664
0000066C  bsr.w  $6e2
00000670  bsr.w  $774
00000674  bsr.w  $d7a
00000678  move.w #$90, $372.l
00000680  move.w #$90, $374.l
00000688  move.w #$38, $376.l
00000690  move.w #$e8, $378.l
00000698  clr.w  $21e.l
0000069E  move.l #$152c, $f80.l
000006A8  move.l #$98, $f7c.l
000006B2  clr.w  $f88.l
000006B8  move.w #$3, $f86.l
000006C0  move.b #$0, $f84.l
000006C8  move.w #$20, $f8a.l
000006D0  movem.l (a7)+, a4-a6
000006D4  rts    
000006D6  ori.b  #$0, d0
000006DA  ori.b  #$0, d0
000006DE  ori.b  #$0, d0
000006E2  lea.l  $75e.l, a3
000006E8  movea.l $6da.l, a4
000006EE  lea.l  $11a8.l, a5
000006F4  moveq  #$0, d2
000006F6  move.w #$b3, d6
000006FA  lea.l  $11a8.l, a0
00000700  lea.l  $f8c.l, a1
00000706  move.w #$b3, d7
0000070A  move.w (a0)+, d0
0000070C  muls.w #$70, d0
00000710  swap   d0
00000712  addi.w #$38, d0
00000716  add.w  d0, d0
00000718  move.w (a1)+, d1
0000071A  move.w (a5, d2.w), d3
0000071E  muls.w d3, d1
00000720  swap   d1
00000722  muls.w #$e0, d1
00000726  swap   d1
00000728  addi.w #$38, d1
0000072C  mulu.w #$1c, d1
00000730  move.w d0, d3
00000732  lsr.w  #$3, d0
00000734  add.w  d0, d1
00000736  not.w  d3
00000738  andi.w #$7, d3
0000073C  add.w  d3, d3
0000073E  move.l (a3, d3.w), (a4)+
00000742  move.w d1, -$2(a4)
00000746  dbra   d7, $70a
0000074A  lea.l  -$2d0(a4), a6
0000074E  move.w #$b3, d7
00000752  move.l (a6)+, (a4)+
00000754  dbra   d7, $752
00000758  addi.w #$2, d2
0000075C  dbra   d6, $6fa
00000760  rts    
00000762  nop    
00000764  or.b   d0, $0(a0)
00000768  or.b   d1, $0(a0)
0000076C  or.b   d2, $0(a0)
00000770  or.b   d3, $0(a0)
00000774  lea.l  $15ac.l, a0
0000077A  movea.l $6d6.l, a1
00000780  lea.l  $7d6.l, a2
00000786  move.w #$b3, d6
0000078A  move.l a1, (a2)+
0000078C  moveq  #$0, d0
0000078E  move.w #$b3, d7
00000792  move.w d0, d1
00000794  move.w d0, d2
00000796  lsr.w  #$3, d1
00000798  not.w  d2
0000079A  btst.l d2, (a0, d1.w)
0000079E  beq.b  $7ae
000007A0  move.w d0, d1
000007A2  add.w  d1, d1
000007A4  add.w  d1, d1
000007A6  move.w $7d0.l, (a1)+
000007AC  move.w d1, (a1)+
000007AE  addq.w #$1, d0
000007B0  dbra   d7, $792
000007B4  move.w $7d4.l, (a1)+
000007BA  lea.l  $18(a0), a0
000007BE  dbra   d6, $78a
000007C2  lea.l  $7d6.l, a1
000007C8  move.w #$b3, d7
000007CC  move.l (a1)+, (a2)+
000007CE  dbra   d7, $7cc
000007D2  rts    
000007D4  move.l $0(a1), (a2)+
000007D8  rts    
000007DA  ori.b  #$0, d0
000007DE  ori.b  #$0, d0
000007E2  ori.b  #$0, d0
000007E6  ori.b  #$0, d0
000007EA  ori.b  #$0, d0
000007EE  ori.b  #$0, d0
000007F2  ori.b  #$0, d0
000007F6  ori.b  #$0, d0
000007FA  ori.b  #$0, d0
000007FE  ori.b  #$0, d0
00000802  ori.b  #$0, d0
00000806  ori.b  #$0, d0
0000080A  ori.b  #$0, d0
0000080E  ori.b  #$0, d0
00000812  ori.b  #$0, d0
00000816  ori.b  #$0, d0
0000081A  ori.b  #$0, d0
0000081E  ori.b  #$0, d0
00000822  ori.b  #$0, d0
00000826  ori.b  #$0, d0
0000082A  ori.b  #$0, d0
0000082E  ori.b  #$0, d0
00000832  ori.b  #$0, d0
00000836  ori.b  #$0, d0
0000083A  ori.b  #$0, d0
0000083E  ori.b  #$0, d0
00000842  ori.b  #$0, d0
00000846  ori.b  #$0, d0
0000084A  ori.b  #$0, d0
0000084E  ori.b  #$0, d0
00000852  ori.b  #$0, d0
00000856  ori.b  #$0, d0
0000085A  ori.b  #$0, d0
0000085E  ori.b  #$0, d0
00000862  ori.b  #$0, d0
00000866  ori.b  #$0, d0
0000086A  ori.b  #$0, d0
0000086E  ori.b  #$0, d0
00000872  ori.b  #$0, d0
00000876  ori.b  #$0, d0
0000087A  ori.b  #$0, d0
0000087E  ori.b  #$0, d0
00000882  ori.b  #$0, d0
00000886  ori.b  #$0, d0
0000088A  ori.b  #$0, d0
0000088E  ori.b  #$0, d0
00000892  ori.b  #$0, d0
00000896  ori.b  #$0, d0
0000089A  ori.b  #$0, d0
0000089E  ori.b  #$0, d0
000008A2  ori.b  #$0, d0
000008A6  ori.b  #$0, d0
000008AA  ori.b  #$0, d0
000008AE  ori.b  #$0, d0
000008B2  ori.b  #$0, d0
000008B6  ori.b  #$0, d0
000008BA  ori.b  #$0, d0
000008BE  ori.b  #$0, d0
000008C2  ori.b  #$0, d0
000008C6  ori.b  #$0, d0
000008CA  ori.b  #$0, d0
000008CE  ori.b  #$0, d0
000008D2  ori.b  #$0, d0
000008D6  ori.b  #$0, d0
000008DA  ori.b  #$0, d0
000008DE  ori.b  #$0, d0
000008E2  ori.b  #$0, d0
000008E6  ori.b  #$0, d0
000008EA  ori.b  #$0, d0
000008EE  ori.b  #$0, d0
000008F2  ori.b  #$0, d0
000008F6  ori.b  #$0, d0
000008FA  ori.b  #$0, d0
000008FE  ori.b  #$0, d0
00000902  ori.b  #$0, d0
00000906  ori.b  #$0, d0
0000090A  ori.b  #$0, d0
0000090E  ori.b  #$0, d0
00000912  ori.b  #$0, d0
00000916  ori.b  #$0, d0
0000091A  ori.b  #$0, d0
0000091E  ori.b  #$0, d0
00000922  ori.b  #$0, d0
00000926  ori.b  #$0, d0
0000092A  ori.b  #$0, d0
0000092E  ori.b  #$0, d0
00000932  ori.b  #$0, d0
00000936  ori.b  #$0, d0
0000093A  ori.b  #$0, d0
0000093E  ori.b  #$0, d0
00000942  ori.b  #$0, d0
00000946  ori.b  #$0, d0
0000094A  ori.b  #$0, d0
0000094E  ori.b  #$0, d0
00000952  ori.b  #$0, d0
00000956  ori.b  #$0, d0
0000095A  ori.b  #$0, d0
0000095E  ori.b  #$0, d0
00000962  ori.b  #$0, d0
00000966  ori.b  #$0, d0
0000096A  ori.b  #$0, d0
0000096E  ori.b  #$0, d0
00000972  ori.b  #$0, d0
00000976  ori.b  #$0, d0
0000097A  ori.b  #$0, d0
0000097E  ori.b  #$0, d0
00000982  ori.b  #$0, d0
00000986  ori.b  #$0, d0
0000098A  ori.b  #$0, d0
0000098E  ori.b  #$0, d0
00000992  ori.b  #$0, d0
00000996  ori.b  #$0, d0
0000099A  ori.b  #$0, d0
0000099E  ori.b  #$0, d0
000009A2  ori.b  #$0, d0
000009A6  ori.b  #$0, d0
000009AA  ori.b  #$0, d0
000009AE  ori.b  #$0, d0
000009B2  ori.b  #$0, d0
000009B6  ori.b  #$0, d0
000009BA  ori.b  #$0, d0
000009BE  ori.b  #$0, d0
000009C2  ori.b  #$0, d0
000009C6  ori.b  #$0, d0
000009CA  ori.b  #$0, d0
000009CE  ori.b  #$0, d0
000009D2  ori.b  #$0, d0
000009D6  ori.b  #$0, d0
000009DA  ori.b  #$0, d0
000009DE  ori.b  #$0, d0
000009E2  ori.b  #$0, d0
000009E6  ori.b  #$0, d0
000009EA  ori.b  #$0, d0
000009EE  ori.b  #$0, d0
000009F2  ori.b  #$0, d0
000009F6  ori.b  #$0, d0
000009FA  ori.b  #$0, d0
000009FE  ori.b  #$0, d0
00000A02  ori.b  #$0, d0
00000A06  ori.b  #$0, d0
00000A0A  ori.b  #$0, d0
00000A0E  ori.b  #$0, d0
00000A12  ori.b  #$0, d0
00000A16  ori.b  #$0, d0
00000A1A  ori.b  #$0, d0
00000A1E  ori.b  #$0, d0
00000A22  ori.b  #$0, d0
00000A26  ori.b  #$0, d0
00000A2A  ori.b  #$0, d0
00000A2E  ori.b  #$0, d0
00000A32  ori.b  #$0, d0
00000A36  ori.b  #$0, d0
00000A3A  ori.b  #$0, d0
00000A3E  ori.b  #$0, d0
00000A42  ori.b  #$0, d0
00000A46  ori.b  #$0, d0
00000A4A  ori.b  #$0, d0
00000A4E  ori.b  #$0, d0
00000A52  ori.b  #$0, d0
00000A56  ori.b  #$0, d0
00000A5A  ori.b  #$0, d0
00000A5E  ori.b  #$0, d0
00000A62  ori.b  #$0, d0
00000A66  ori.b  #$0, d0
00000A6A  ori.b  #$0, d0
00000A6E  ori.b  #$0, d0
00000A72  ori.b  #$0, d0
00000A76  ori.b  #$0, d0
00000A7A  ori.b  #$0, d0
00000A7E  ori.b  #$0, d0
00000A82  ori.b  #$0, d0
00000A86  ori.b  #$0, d0
00000A8A  ori.b  #$0, d0
00000A8E  ori.b  #$0, d0
00000A92  ori.b  #$0, d0
00000A96  ori.b  #$0, d0
00000A9A  ori.b  #$0, d0
00000A9E  ori.b  #$0, d0
00000AA2  ori.b  #$0, d0
00000AA6  ori.b  #$0, d0
00000AAA  ori.b  #$0, d0
00000AAE  ori.b  #$0, d0
00000AB2  ori.b  #$0, d0
00000AB6  ori.b  #$0, d0
00000ABA  ori.b  #$0, d0
00000ABE  ori.b  #$0, d0
00000AC2  ori.b  #$0, d0
00000AC6  ori.b  #$0, d0
00000ACA  ori.b  #$0, d0
00000ACE  ori.b  #$0, d0
00000AD2  ori.b  #$0, d0
00000AD6  ori.b  #$0, d0
00000ADA  ori.b  #$0, d0
00000ADE  ori.b  #$0, d0
00000AE2  ori.b  #$0, d0
00000AE6  ori.b  #$0, d0
00000AEA  ori.b  #$0, d0
00000AEE  ori.b  #$0, d0
00000AF2  ori.b  #$0, d0
00000AF6  ori.b  #$0, d0
00000AFA  ori.b  #$0, d0
00000AFE  ori.b  #$0, d0
00000B02  ori.b  #$0, d0
00000B06  ori.b  #$0, d0
00000B0A  ori.b  #$0, d0
00000B0E  ori.b  #$0, d0
00000B12  ori.b  #$0, d0
00000B16  ori.b  #$0, d0
00000B1A  ori.b  #$0, d0
00000B1E  ori.b  #$0, d0
00000B22  ori.b  #$0, d0
00000B26  ori.b  #$0, d0
00000B2A  ori.b  #$0, d0
00000B2E  ori.b  #$0, d0
00000B32  ori.b  #$0, d0
00000B36  ori.b  #$0, d0
00000B3A  ori.b  #$0, d0
00000B3E  ori.b  #$0, d0
00000B42  ori.b  #$0, d0
00000B46  ori.b  #$0, d0
00000B4A  ori.b  #$0, d0
00000B4E  ori.b  #$0, d0
00000B52  ori.b  #$0, d0
00000B56  ori.b  #$0, d0
00000B5A  ori.b  #$0, d0
00000B5E  ori.b  #$0, d0
00000B62  ori.b  #$0, d0
00000B66  ori.b  #$0, d0
00000B6A  ori.b  #$0, d0
00000B6E  ori.b  #$0, d0
00000B72  ori.b  #$0, d0
00000B76  ori.b  #$0, d0
00000B7A  ori.b  #$0, d0
00000B7E  ori.b  #$0, d0
00000B82  ori.b  #$0, d0
00000B86  ori.b  #$0, d0
00000B8A  ori.b  #$0, d0
00000B8E  ori.b  #$0, d0
00000B92  ori.b  #$0, d0
00000B96  ori.b  #$0, d0
00000B9A  ori.b  #$0, d0
00000B9E  ori.b  #$0, d0
00000BA2  ori.b  #$0, d0
00000BA6  ori.b  #$0, d0
00000BAA  ori.b  #$0, d0
00000BAE  ori.b  #$0, d0
00000BB2  ori.b  #$0, d0
00000BB6  ori.b  #$0, d0
00000BBA  ori.b  #$0, d0
00000BBE  ori.b  #$0, d0
00000BC2  ori.b  #$0, d0
00000BC6  ori.b  #$0, d0
00000BCA  ori.b  #$0, d0
00000BCE  ori.b  #$0, d0
00000BD2  ori.b  #$0, d0
00000BD6  ori.b  #$0, d0
00000BDA  ori.b  #$0, d0
00000BDE  ori.b  #$0, d0
00000BE2  ori.b  #$0, d0
00000BE6  ori.b  #$0, d0
00000BEA  ori.b  #$0, d0
00000BEE  ori.b  #$0, d0
00000BF2  ori.b  #$0, d0
00000BF6  ori.b  #$0, d0
00000BFA  ori.b  #$0, d0
00000BFE  ori.b  #$0, d0
00000C02  ori.b  #$0, d0
00000C06  ori.b  #$0, d0
00000C0A  ori.b  #$0, d0
00000C0E  ori.b  #$0, d0
00000C12  ori.b  #$0, d0
00000C16  ori.b  #$0, d0
00000C1A  ori.b  #$0, d0
00000C1E  ori.b  #$0, d0
00000C22  ori.b  #$0, d0
00000C26  ori.b  #$0, d0
00000C2A  ori.b  #$0, d0
00000C2E  ori.b  #$0, d0
00000C32  ori.b  #$0, d0
00000C36  ori.b  #$0, d0
00000C3A  ori.b  #$0, d0
00000C3E  ori.b  #$0, d0
00000C42  ori.b  #$0, d0
00000C46  ori.b  #$0, d0
00000C4A  ori.b  #$0, d0
00000C4E  ori.b  #$0, d0
00000C52  ori.b  #$0, d0
00000C56  ori.b  #$0, d0
00000C5A  ori.b  #$0, d0
00000C5E  ori.b  #$0, d0
00000C62  ori.b  #$0, d0
00000C66  ori.b  #$0, d0
00000C6A  ori.b  #$0, d0
00000C6E  ori.b  #$0, d0
00000C72  ori.b  #$0, d0
00000C76  ori.b  #$0, d0
00000C7A  ori.b  #$0, d0
00000C7E  ori.b  #$0, d0
00000C82  ori.b  #$0, d0
00000C86  ori.b  #$0, d0
00000C8A  ori.b  #$0, d0
00000C8E  ori.b  #$0, d0
00000C92  ori.b  #$0, d0
00000C96  ori.b  #$0, d0
00000C9A  ori.b  #$0, d0
00000C9E  ori.b  #$0, d0
00000CA2  ori.b  #$0, d0
00000CA6  ori.b  #$0, d0
00000CAA  ori.b  #$0, d0
00000CAE  ori.b  #$0, d0
00000CB2  ori.b  #$0, d0
00000CB6  ori.b  #$0, d0
00000CBA  ori.b  #$0, d0
00000CBE  ori.b  #$0, d0
00000CC2  ori.b  #$0, d0
00000CC6  ori.b  #$0, d0
00000CCA  ori.b  #$0, d0
00000CCE  ori.b  #$0, d0
00000CD2  ori.b  #$0, d0
00000CD6  ori.b  #$0, d0
00000CDA  ori.b  #$0, d0
00000CDE  ori.b  #$0, d0
00000CE2  ori.b  #$0, d0
00000CE6  ori.b  #$0, d0
00000CEA  ori.b  #$0, d0
00000CEE  ori.b  #$0, d0
00000CF2  ori.b  #$0, d0
00000CF6  ori.b  #$0, d0
00000CFA  ori.b  #$0, d0
00000CFE  ori.b  #$0, d0
00000D02  ori.b  #$0, d0
00000D06  ori.b  #$0, d0
00000D0A  ori.b  #$0, d0
00000D0E  ori.b  #$0, d0
00000D12  ori.b  #$0, d0
00000D16  ori.b  #$0, d0
00000D1A  ori.b  #$0, d0
00000D1E  ori.b  #$0, d0
00000D22  ori.b  #$0, d0
00000D26  ori.b  #$0, d0
00000D2A  ori.b  #$0, d0
00000D2E  ori.b  #$0, d0
00000D32  ori.b  #$0, d0
00000D36  ori.b  #$0, d0
00000D3A  ori.b  #$0, d0
00000D3E  ori.b  #$0, d0
00000D42  ori.b  #$0, d0
00000D46  ori.b  #$0, d0
00000D4A  ori.b  #$0, d0
00000D4E  ori.b  #$0, d0
00000D52  ori.b  #$0, d0
00000D56  ori.b  #$0, d0
00000D5A  ori.b  #$0, d0
00000D5E  ori.b  #$0, d0
00000D62  ori.b  #$0, d0
00000D66  ori.b  #$0, d0
00000D6A  ori.b  #$0, d0
00000D6E  ori.b  #$0, d0
00000D72  ori.b  #$0, d0
00000D76  ori.b  #$0, d0
00000D7A  lea.l  $120.l, a0
00000D80  move.w #$18df, d0
00000D84  move.w #$1f, d7
00000D88  move.w d0, (a0)+
00000D8A  addi.w #$100, d0
00000D8E  move.w #$fffe, (a0)+
00000D92  move.w #$180, (a0)+
00000D96  move.w #$100, (a0)+
00000D9A  dbra   d7, $d88
00000D9E  move.w #$df, d7
00000DA2  move.w d0, (a0)+
00000DA4  addi.w #$100, d0
00000DA8  move.w #$fffe, (a0)+
00000DAC  move.w #$f2, (a0)+
00000DB0  move.w #$0, (a0)+
00000DB4  move.w #$100, (a0)+
00000DB8  move.w #$200, (a0)+
00000DBC  move.w #$180, (a0)+
00000DC0  move.w #$100, (a0)+
00000DC4  dbra   d7, $da2
00000DC8  move.w #$1f, d7
00000DCC  move.w d0, (a0)+
00000DCE  addi.w #$100, d0
00000DD2  move.w #$fffe, (a0)+
00000DD6  move.w #$180, (a0)+
00000DDA  move.w #$100, (a0)+
00000DDE  dbra   d7, $dcc
00000DE2  lea.l  $38e.l, a0
00000DE8  move.w #$b3, d7
00000DEC  move.w #$411, (a0)
00000DF0  lea.l  $10(a0), a0
00000DF4  dbra   d7, $dec
00000DF8  rts    
00000DFA  lea.l  $dff002.l, a4
00000E00  btst.b #$6, (a4)
00000E04  bne.b  $e00
00000E06  clr.w  $64(a4)
00000E0A  move.l #$1000000, $3e(a4)
00000E12  move.l $e9c.l, $52(a4)
00000E1A  move.w #$1c0e, $56(a4)
00000E20  rts    
00000E22  lea.l  $dff002.l, a4
00000E28  btst.b #$6, (a4)
00000E2C  bne.b  $e28
00000E2E  move.l #$e, $62(a4)
00000E36  move.l #$9f00000, $3e(a4)
00000E3E  move.l $e98.l, $4e(a4)
00000E46  move.l #$226, $52(a4)
00000E4E  move.w #$3801, $56(a4)
00000E54  rts    
00000E56  addq.w #$8, $ea4.l
00000E5C  cmpi.w #$18, $ea4.l
00000E64  bne.b  $e6c
00000E66  clr.w  $ea4.l
00000E6C  lea.l  $ea6.l, a0
00000E72  adda.w $ea8(pc), a0
00000E76  move.l (a0)+, d0
00000E78  move.l (a0)+, $e98.l
00000E7E  move.l (a0), $ea0.l
00000E84  move.l $8(a0), $e9c.l
00000E8C  lea.l  $8a.l, a0
00000E92  move.w d0, $4(a0)
00000E96  swap   d0
00000E98  move.w d0, (a0)
00000E9A  rts    
00000E9C  ori.b  #$0, d0
00000EA0  ori.b  #$0, d0
00000EA4  ori.b  #$0, d0
00000EA8  ori.b  #$0, d0
00000EAC  ori.b  #$0, d0
00000EB0  move.b d4, $0(a0)
00000EB4  ori.b  #$0, d0
00000EB8  move.b d4, -(a1)
00000EBA  ori.b  #$0, d0
00000EBE  ori.b  #$c4, d0
00000EC2  ori.b  #$0, d0
00000EC6  ori.b  #$44, d0
00000ECA  ori.b  #$0, d0
00000ECE  ori.b  #$4, d0
00000ED2  ori.b  #$0, d0
00000ED6  ori.b  #$c4, d0
00000EDA  tst.w  $f88.l
00000EE0  beq.b  $eec
00000EE2  subq.w #$1, $f88.l
00000EE8  bra.w  $f7e
00000EEC  move.w $f8a(pc), $f88.l
00000EF4  tst.b  $f84.l
00000EFA  bne.b  $f00
00000EFC  bra.w  $f7e
00000F00  subq.b #$1, $f84.l
00000F06  movea.l $f84(pc), a1
00000F0A  movea.l $f80(pc), a0
00000F0E  lea.l  $2(a0), a0
00000F12  move.w $f8a.l, d4
00000F18  subq.w #$1, d4
00000F1A  move.w (a0), d0
00000F1C  move.w (a1)+, d2
00000F1E  move.w d0, d1
00000F20  move.w d2, d3
00000F22  andi.w #$f, d1
00000F26  andi.w #$f, d3
00000F2A  cmp.w  d1, d3
00000F2C  beq.b  $f36
00000F2E  blt.b  $f34
00000F30  addq.w #$1, (a0)
00000F32  bra.b  $f36
00000F34  subq.w #$1, (a0)
00000F36  move.w d0, d1
00000F38  move.w d2, d3
00000F3A  lsr.w  #$4, d1
00000F3C  lsr.w  #$4, d3
00000F3E  andi.w #$f, d1
00000F42  andi.w #$f, d3
00000F46  cmp.w  d1, d3
00000F48  beq.b  $f56
00000F4A  blt.b  $f52
00000F4C  addi.w #$10, (a0)
00000F50  bra.b  $f56
00000F52  subi.w #$10, (a0)
00000F56  move.w d0, d1
00000F58  move.w d2, d3
00000F5A  lsr.w  #$8, d1
00000F5C  lsr.w  #$8, d3
00000F5E  andi.w #$f, d1
00000F62  andi.w #$f, d3
00000F66  cmp.w  d1, d3
00000F68  beq.b  $f76
00000F6A  blt.b  $f72
00000F6C  addi.w #$100, (a0)
00000F70  bra.b  $f76
00000F72  subi.w #$100, (a0)
00000F76  lea.l  $4(a0), a0
00000F7A  dbra   d4, $f1a
00000F7E  rts    
00000F80  ori.b  #$0, d0
00000F84  ori.b  #$0, d0
00000F88  ori.b  #$0, d0
00000F8C  ori.b  #$0, d0
00000F90  ori.b  #$3c, d0
00000F94  subi.w #$6b3, $8ee.w
00000F9A  btst.l d5, $d61(a0)
00000F9E  bclr.b d7, (a1)+
00000FA0  move.b (a0), $1406.w
00000FA4  move.b $2812(pc), d3
00000FA8  move.b (a4)+, (a5)
00000FAA  ; data: 0x1c, 0xcb
00000FAC  move.b $2348(a7, d2.w), (a7)+
00000FB2  move.l $278d(a4), $29ac(a2)
00000FB8  ; data: 0x2b, 0xc7
00000FBA  ; data: 0x2d, 0xde
00000FBC  ; data: 0x2f, 0xf2
00000FBE  move.w d3, d1
00000FC0  move.w a7, d2
00000FC2  move.w (a0)+, d3
00000FC4  move.w (a4)+, d4
00000FC6  move.w (a4)+, d5
00000FC8  move.w (a7), d6
00000FCA  move.w a5, d7
00000FCC  ; data: 0x3f, 0xff
00000FCE  lea.l  $43d3(a4), a0
00000FD2  chk.w  ([, d4.w * 8], $496a4b3b), d2
00000FDA  dc.w   $4d07
00000FDC  ; data: 0x4e, 0xcd
00000FDE  addq.l #$8, a4
00000FE0  addq.w #$1, d6
00000FE2  sls.b  $55a5574b.l
00000FE8  svc.b  $5a81(a1)
00000FEC  addq.b #$6, (a2)
00000FEE  subq.l #$6, (a4)+
00000FF0  subq.b #$7, (a6)+
00000FF2  bra.b  $f8d
00000FF4  bhi.b  $1002
00000FF6  bls.b  $1070
00000FF8  bcc.b  $fd6
00000FFA  bne.b  $1034
00000FFC  beq.b  $f8b
00000FFE  bvc.b  $fd9
00001000  bpl.b  $101f
00001002  bmi.b  $105c
00001004  bge.b  $f91
00001006  blt.b  $fbe
00001008  bgt.b  $fe3
0000100A  ble.b  $ffe
0000100C  ; data: 0x71, 0x03
0000100E  moveq  #$b, d1
00001010  ; data: 0x73, 0x0a
00001012  moveq  #$1, d2
00001014  moveq  #$ee, d2
00001016  ; data: 0x75, 0xd2
00001018  moveq  #$ad, d3
0000101A  ; data: 0x77, 0x7e
0000101C  moveq  #$47, d4
0000101E  ; data: 0x79, 0x05
00001020  ; data: 0x79, 0xbb
00001022  moveq  #$67, d5
00001024  ; data: 0x7b, 0x09
00001026  ; data: 0x7b, 0xa2
00001028  moveq  #$31, d6
0000102A  moveq  #$b7, d6
0000102C  ; data: 0x7d, 0x33
0000102E  ; data: 0x7d, 0xa5
00001030  moveq  #$d, d7
00001032  moveq  #$6b, d7
00001034  moveq  #$c0, d7
00001036  ; data: 0x7f, 0x0b
00001038  ; data: 0x7f, 0x4b
0000103A  ; data: 0x7f, 0x82
0000103C  ; data: 0x7f, 0xaf
0000103E  ; data: 0x7f, 0xd2
00001040  ; data: 0x7f, 0xeb
00001042  ; data: 0x7f, 0xfa
00001044  ; data: 0x7f, 0xff
00001046  ; data: 0x7f, 0xfa
00001048  ; data: 0x7f, 0xeb
0000104A  ; data: 0x7f, 0xd2
0000104C  ; data: 0x7f, 0xaf
0000104E  ; data: 0x7f, 0x82
00001050  ; data: 0x7f, 0x4c
00001052  ; data: 0x7f, 0x0b
00001054  moveq  #$c0, d7
00001056  moveq  #$6c, d7
00001058  moveq  #$d, d7
0000105A  ; data: 0x7d, 0xa5
0000105C  ; data: 0x7d, 0x33
0000105E  moveq  #$b8, d6
00001060  moveq  #$32, d6
00001062  ; data: 0x7b, 0xa3
00001064  ; data: 0x7b, 0x0a
00001066  moveq  #$68, d5
00001068  ; data: 0x79, 0xbc
0000106A  ; data: 0x79, 0x06
0000106C  moveq  #$48, d4
0000106E  ; data: 0x77, 0x7f
00001070  moveq  #$ae, d3
00001072  ; data: 0x75, 0xd3
00001074  moveq  #$ef, d2
00001076  moveq  #$2, d2
00001078  ; data: 0x73, 0x0c
0000107A  moveq  #$d, d1
0000107C  ; data: 0x71, 0x04
0000107E  ble.b  $1074
00001080  bgt.b  $105c
00001082  blt.b  $103c
00001084  bge.b  $1013
00001086  bmi.b  $10e2
00001088  bpl.b  $10a8
0000108A  bvc.b  $1066
0000108C  beq.b  $101c
0000108E  bne.b  $10ca
00001090  bcc.b  $1070
00001092  bls.b  $110e
00001094  bhi.b  $10a4
00001096  bra.b  $1033
00001098  subq.b #$7, -(a0)
0000109A  subq.l #$6, (a6)+
0000109C  addq.b #$6, (a4)
0000109E  addq.l #$5, d3
000010A0  svc.b  $574d(a4)
000010A4  subq.l #$2, -(a7)
000010A6  dc.w   $53fb
000010A8  addq.w #$1, a0
000010AA  addq.l #$8, a7
000010AC  ; data: 0x4e, 0xcf
000010AE  ; data: 0x4d, 0x0a
000010B0  ; data: 0x4b, 0x3e
000010B2  ; data: 0x49, 0x6c
000010B4  chk.w  (a5), d3
000010B6  chk.w  $43d6.w, d2
000010BA  lea.l  $4002(a6), a0
000010BE  move.w (a0), d7
000010C0  move.w (a1)+, d6
000010C2  move.w (a6)+, d5
000010C4  move.w (a6)+, d4
000010C6  move.w (a2)+, d3
000010C8  move.w (a2), d2
000010CA  move.w d6, d1
000010CC  ; data: 0x2f, 0xf5
000010CE  ; data: 0x2d, 0xe1
000010D0  ; data: 0x2b, 0xca
000010D2  move.l $2790(a6), ([$234a, a4])
000010DA  move.l -(a3), -(a0)
000010DC  move.b $2dac(pc), (a7)+
000010E0  move.b (a7)+, (a5)
000010E2  ; data: 0x18, 0x6f
000010E4  ; data: 0x16, 0x3d
000010E6  ; data: 0x14, 0x09
000010E8  move.b (a3), $f9c.w
000010EC  bchg.b d6, -(a4)
000010EE  btst.l d5, $8f1(a3)
000010F2  addi.l #$47b023f, $3(a6, d0.w)
000010FA  ; data: 0xfd, 0xc7
000010FC  ; data: 0xfb, 0x8c
000010FE  dc.w   $f950
00001100  dc.w   $f715
00001102  dc.w   $f4db
00001104  dc.w   $f2a2
00001106  dc.w   $f06a
00001108  roxr.l #$7, d3
0000110A  ; data: 0xeb, 0xfd
0000110C  ; data: 0xe9, 0xc9
0000110E  roxl.l #$3, d7
00001110  asl.w  d2, d7
00001112  rol.b  d1, d0
00001114  lsl.b  #$8, d4
00001116  adda.w -(a2), a7
00001118  add.l  $10b1(pc, a5.l), d6
0000111C  add.w  $57(a6, a5.w), d4
00001120  add.b  #$25, d2
00001124  add.b  (a0), d0
00001126  and.b  d0, d7
00001128  muls.w ([$c7e7], $c5e7c3ec), d5
00001132  muls.w $4(a5, a4.w), d0
00001136  cmp.b  (a7), d7
00001138  cmp.b  -$45b3(a7), d6
0000113C  cmp.w  -$67(a0, a3.w), d4
00001140  cmpa.w d7, a2
00001142  cmpa.w ([$af76bf01, pc], a3.w, $ac0a), a1
0000114C  ; data: 0xaa, 0x5d
0000114E  ; data: 0xa8, 0xb8
00001150  ; data: 0xa7, 0x19
00001152  ; data: 0xa5, 0x81
00001154  ; data: 0xa3, 0xf0
00001156  ; data: 0xa2, 0x66
00001158  ; data: 0xa0, 0xe4
0000115A  sub.w  d7, -$620a(a1)
0000115E  sub.l  a2, d6
00001160  sub.b  d5, -(a6)
00001162  suba.l a1, a4
00001164  sub.w  ([$95e5, a5, a1.w * 8]), d4
0000116A  sub.l  -$6c8a(a1), d2
0000116E  sub.w  a3, d1
00001170  sub.b  d0, -$6ff1(a1)
00001174  ; data: 0x8e, 0xfe
00001176  divs.w -$9(a6, a0.l), d6
0000117A  or.b   d1, d6
0000117C  or.b   d5, (a4)
0000117E  or.b   -$76ab(a7), d5
00001182  or.l   d3, d4
00001184  ; data: 0x87, 0xbb
00001186  divu.w #$8646, d3
0000118A  or.l   d2, (a2)+
0000118C  divu.w $845f.w, d2
00001190  ; data: 0x83, 0xcf
00001192  dc.w   $834a
00001194  ; data: 0x82, 0xce
00001196  or.w   (a4)+, d1
00001198  divs.w ([], a0.w), d0
0000119C  dc.w   $8141
0000119E  divu.w -$4b(a6, a0.w), d0
000011A2  ; data: 0x80, 0x7e
000011A4  or.w   (a1), d0
000011A6  or.b   -$7feb(a6), d0
000011AA  or.b   d6, d0
000011AC  or.b   d1, d0
000011AE  or.b   d6, d0
000011B0  or.b   (a5), d0
000011B2  or.b   -$7fb0(a6), d0
000011B6  ; data: 0x80, 0x7d
000011B8  or.l   -$b(a4, a0.w), d0
000011BC  ; data: 0x81, 0x3f
000011BE  or.l   d0, (a4)
000011C0  divs.w $5a(a2, a0.w), d0
000011C4  ; data: 0x82, 0xcc
000011C6  dc.w   $8348
000011C8  ; data: 0x83, 0xcd
000011CA  or.w   (a4)+, d2
000011CC  divu.w ([], a0.w * 4, $864386f9), d2
000011D4  or.l   d3, -$80(a7, a0.l)
000011D8  or.w   d4, (a1)
000011DA  or.b   -$74f0(a4), d5
000011DE  ; data: 0x8b, 0xfd
000011E0  divu.w ([$8efa900b], $9124), d6
000011EA  sub.w  d7, d1
000011EC  sub.w  d1, -$5c(a1, a1.w)
000011F0  suba.l -(a0), a2
000011F2  sub.b  d3, -(a4)
000011F4  sub.w  (invalid.w), d4
000011F8  sub.b  d5, -(a0)
000011FA  sub.l  d4, d6
000011FC  suba.l ([$a0de, a0], $a260a3ea), a6
00001206  ; data: 0xa5, 0x7a
00001208  ; data: 0xa7, 0x12
0000120A  ; data: 0xa8, 0xb1
0000120C  ; data: 0xaa, 0x57
0000120E  ; data: 0xac, 0x03
00001210  ; data: 0xad, 0xb6
00001212  ; data: 0xaf, 0x6f
00001214  eor.b  d0, -$4d0c(a6)
00001218  cmpa.w d0, a2
0000121A  cmp.l  (a1), d3
0000121C  cmp.w  -$45bb(a0), d4
00001220  cmp.b  -(a7), d6
00001222  ; data: 0xbe, 0x0f
00001224  cmpa.l #$c1edc3e4, a7
0000122A  muls.w (a7)+, d2
0000122C  muls.w (a7)+, d3
0000122E  muls.w -(a3), d4
00001230  muls.w -$3208(a3), d5
00001234  ; data: 0xd0, 0x08
00001236  add.b  (a4)+, d1
00001238  add.b  $4f(a4, a5.w), d2
0000123C  add.w  -$2572(a5), d4
00001240  add.l  -$26(a3, a5.l), d6
00001244  asl.b  #$8, d3
00001246  lsl.b  d1, d7
00001248  rol.w  #$2, d6
0000124A  lsl.l  #$3, d6
0000124C  ; data: 0xe9, 0xc0
0000124E  ; data: 0xeb, 0xf4
00001250  lsr.b  d7, d2
00001252  dc.w   $f061
00001254  dc.w   $f299
00001256  dc.w   $f4d2
00001258  ; data: 0xf7, 0x0c
0000125A  ; data: 0xf9, 0x47
0000125C  ; data: 0xfb, 0x82
0000125E  ; data: 0xfd, 0xbe
00001260  ori.b  #$3c, d0
00001264  subi.w #$6b3, $8ee.w
0000126A  btst.l d5, $d61(a0)
0000126E  bclr.b d7, (a1)+
00001270  move.b (a0), $1406.w
00001274  move.b $2ae2(pc), d3
00001278  move.b (a4)+, (a5)
0000127A  ; data: 0x1c, 0xcb
0000127C  move.b $2348(a7, d2.w), (a7)+
00001282  move.l $278d(a4), $29ac(a2)
00001288  ; data: 0x2b, 0xc7
0000128A  ; data: 0x2d, 0xde
0000128C  ; data: 0x2f, 0xf2
0000128E  move.w d3, d1
00001290  move.w a7, d2
00001292  move.w (a0)+, d3
00001294  move.w (a4)+, d4
00001296  move.w (a4)+, d5
00001298  move.w (a7), d6
0000129A  move.w a5, d7
0000129C  ; data: 0x3f, 0xff
0000129E  lea.l  $43d3(a4), a0
000012A2  chk.w  ([, d4.w * 8], $496a4b3b), d2
000012AA  dc.w   $4d07
000012AC  ; data: 0x4e, 0xcd
000012AE  addq.l #$8, a4
000012B0  addq.w #$1, d6
000012B2  sls.b  $55a5574b.l
000012B8  svc.b  $5a81(a1)
000012BC  addq.b #$6, (a2)
000012BE  subq.l #$6, (a4)+
000012C0  subq.b #$7, (a6)+
000012C2  bra.b  $125d
000012C4  bhi.b  $12d2
000012C6  bls.b  $1340
000012C8  bcc.b  $12a6
000012CA  bne.b  $1304
000012CC  beq.b  $125b
000012CE  bvc.b  $12a9
000012D0  bpl.b  $12ef
000012D2  bmi.b  $132c
000012D4  bge.b  $1261
000012D6  blt.b  $128e
000012D8  bgt.b  $12b3
000012DA  ble.b  $12ce
000012DC  ; data: 0x71, 0x03
000012DE  moveq  #$b, d1
000012E0  ; data: 0x73, 0x0a
000012E2  moveq  #$1, d2
000012E4  moveq  #$ee, d2
000012E6  ; data: 0x75, 0xd2
000012E8  moveq  #$ad, d3
000012EA  ; data: 0x77, 0x7e
000012EC  moveq  #$47, d4
000012EE  ; data: 0x79, 0x05
000012F0  ; data: 0x79, 0xbb
000012F2  moveq  #$67, d5
000012F4  ; data: 0x7b, 0x09
000012F6  ; data: 0x7b, 0xa2
000012F8  moveq  #$31, d6
000012FA  moveq  #$b7, d6
000012FC  ; data: 0x7d, 0x33
000012FE  ; data: 0x7d, 0xa5
00001300  moveq  #$d, d7
00001302  moveq  #$6b, d7
00001304  moveq  #$c0, d7
00001306  ; data: 0x7f, 0x0b
00001308  ; data: 0x7f, 0x4b
0000130A  ; data: 0x7f, 0x82
0000130C  ; data: 0x7f, 0xaf
0000130E  ; data: 0x7f, 0xd2
00001310  ; data: 0x7f, 0xeb
00001312  ; data: 0x7f, 0xfa
00001314  ; data: 0x7f, 0xff
00001316  ; data: 0x7f, 0xfa
00001318  ; data: 0x7f, 0xeb
0000131A  ; data: 0x7f, 0xd2
0000131C  ; data: 0x7f, 0xaf
0000131E  ; data: 0x7f, 0x82
00001320  ; data: 0x7f, 0x4c
00001322  ; data: 0x7f, 0x0b
00001324  moveq  #$c0, d7
00001326  moveq  #$6c, d7
00001328  moveq  #$d, d7
0000132A  ; data: 0x7d, 0xa5
0000132C  ; data: 0x7d, 0x33
0000132E  moveq  #$b8, d6
00001330  moveq  #$32, d6
00001332  ; data: 0x7b, 0xa3
00001334  ; data: 0x7b, 0x0a
00001336  moveq  #$68, d5
00001338  ; data: 0x79, 0xbc
0000133A  ; data: 0x79, 0x06
0000133C  moveq  #$48, d4
0000133E  ; data: 0x77, 0x7f
00001340  moveq  #$ae, d3
00001342  ; data: 0x75, 0xd3
00001344  moveq  #$ef, d2
00001346  moveq  #$2, d2
00001348  ; data: 0x73, 0x0c
0000134A  moveq  #$d, d1
0000134C  ; data: 0x71, 0x04
0000134E  ble.b  $1344
00001350  bgt.b  $132c
00001352  blt.b  $130c
00001354  bge.b  $12e3
00001356  bmi.b  $13b2
00001358  bpl.b  $1378
0000135A  bvc.b  $1336
0000135C  beq.b  $12ec
0000135E  bne.b  $139a
00001360  bcc.b  $1340
00001362  bls.b  $13de
00001364  bhi.b  $1374
00001366  bra.b  $1303
00001368  subq.b #$7, -(a0)
0000136A  subq.l #$6, (a6)+
0000136C  addq.b #$6, (a4)
0000136E  addq.l #$5, d3
00001370  svc.b  $574d(a4)
00001374  subq.l #$2, -(a7)
00001376  dc.w   $53fb
00001378  addq.w #$1, a0
0000137A  addq.l #$8, a7
0000137C  ; data: 0x4e, 0xcf
0000137E  ; data: 0x4d, 0x0a
00001380  ; data: 0x4b, 0x3e
00001382  ; data: 0x49, 0x6c
00001384  chk.w  (a5), d3
00001386  chk.w  $43d6.w, d2
0000138A  lea.l  $4002(a6), a0
0000138E  move.w (a0), d7
00001390  move.w (a1)+, d6
00001392  move.w (a6)+, d5
00001394  move.w (a6)+, d4
00001396  move.w (a2)+, d3
00001398  move.w (a2), d2
0000139A  move.w d6, d1
0000139C  ; data: 0x2f, 0xf5
0000139E  ; data: 0x2d, 0xe1
000013A0  ; data: 0x2b, 0xca
000013A2  move.l $2790(a6), ([$234a, a4])
000013AA  move.l -(a3), -(a0)
000013AC  move.b $307c(pc), (a7)+
000013B0  move.b (a7)+, (a5)
000013B2  ; data: 0x18, 0x6f
000013B4  ; data: 0x16, 0x3d
000013B6  ; data: 0x14, 0x09
000013B8  move.b (a3), $f9c.w
000013BC  bchg.b d6, -(a4)
000013BE  btst.l d5, $8f1(a3)
000013C2  addi.l #$47b023f, $3(a6, d0.w)
000013CA  ; data: 0xfd, 0xc7
000013CC  ; data: 0xfb, 0x8c
000013CE  dc.w   $f950
000013D0  dc.w   $f715
000013D2  dc.w   $f4db
000013D4  dc.w   $f2a2
000013D6  dc.w   $f06a
000013D8  roxr.l #$7, d3
000013DA  ; data: 0xeb, 0xfd
000013DC  ; data: 0xe9, 0xc9
000013DE  roxl.l #$3, d7
000013E0  asl.w  d2, d7
000013E2  rol.b  d1, d0
000013E4  lsl.b  #$8, d4
000013E6  adda.w -(a2), a7
000013E8  add.l  $1381(pc, a5.l), d6
000013EC  add.w  $57(a6, a5.w), d4
000013F0  add.b  #$25, d2
000013F4  add.b  (a0), d0
000013F6  and.b  d0, d7
000013F8  muls.w ([$c7e7], $c5e7c3ec), d5
00001402  muls.w $4(a5, a4.w), d0
00001406  cmp.b  (a7), d7
00001408  cmp.b  -$45b3(a7), d6
0000140C  cmp.w  -$67(a0, a3.w), d4
00001410  cmpa.w d7, a2
00001412  cmpa.w ([$af76c1d1, pc], a3.w, $ac0a), a1
0000141C  ; data: 0xaa, 0x5d
0000141E  ; data: 0xa8, 0xb8
00001420  ; data: 0xa7, 0x19
00001422  ; data: 0xa5, 0x81
00001424  ; data: 0xa3, 0xf0
00001426  ; data: 0xa2, 0x66
00001428  ; data: 0xa0, 0xe4
0000142A  sub.w  d7, -$620a(a1)
0000142E  sub.l  a2, d6
00001430  sub.b  d5, -(a6)
00001432  suba.l a1, a4
00001434  sub.w  ([$95e5, a5, a1.w * 8]), d4
0000143A  sub.l  -$6c8a(a1), d2
0000143E  sub.w  a3, d1
00001440  sub.b  d0, -$6ff1(a1)
00001444  ; data: 0x8e, 0xfe
00001446  divs.w -$9(a6, a0.l), d6
0000144A  or.b   d1, d6
0000144C  or.b   d5, (a4)
0000144E  or.b   -$76ab(a7), d5
00001452  or.l   d3, d4
00001454  ; data: 0x87, 0xbb
00001456  divu.w #$8646, d3
0000145A  or.l   d2, (a2)+
0000145C  divu.w $845f.w, d2
00001460  ; data: 0x83, 0xcf
00001462  dc.w   $834a
00001464  ; data: 0x82, 0xce
00001466  or.w   (a4)+, d1
00001468  divs.w ([], a0.w), d0
0000146C  dc.w   $8141
0000146E  divu.w -$4b(a6, a0.w), d0
00001472  ; data: 0x80, 0x7e
00001474  or.w   (a1), d0
00001476  or.b   -$7feb(a6), d0
0000147A  or.b   d6, d0
0000147C  or.b   d1, d0
0000147E  or.b   d6, d0
00001480  or.b   (a5), d0
00001482  or.b   -$7fb0(a6), d0
00001486  ; data: 0x80, 0x7d
00001488  or.l   -$b(a4, a0.w), d0
0000148C  ; data: 0x81, 0x3f
0000148E  or.l   d0, (a4)
00001490  divs.w $5a(a2, a0.w), d0
00001494  ; data: 0x82, 0xcc
00001496  dc.w   $8348
00001498  ; data: 0x83, 0xcd
0000149A  or.w   (a4)+, d2
0000149C  divu.w ([], a0.w * 4, $864386f9), d2
000014A4  or.l   d3, -$80(a7, a0.l)
000014A8  or.w   d4, (a1)
000014AA  or.b   -$74f0(a4), d5
000014AE  ; data: 0x8b, 0xfd
000014B0  divu.w ([$8efa900b], $9124), d6
000014BA  sub.w  d7, d1
000014BC  sub.w  d1, -$5c(a1, a1.w)
000014C0  suba.l -(a0), a2
000014C2  sub.b  d3, -(a4)
000014C4  sub.w  (invalid.w), d4
000014C8  sub.b  d5, -(a0)
000014CA  sub.l  d4, d6
000014CC  suba.l ([$a0de, a0], $a260a3ea), a6
000014D6  ; data: 0xa5, 0x7a
000014D8  ; data: 0xa7, 0x12
000014DA  ; data: 0xa8, 0xb1
000014DC  ; data: 0xaa, 0x57
000014DE  ; data: 0xac, 0x03
000014E0  ; data: 0xad, 0xb6
000014E2  ; data: 0xaf, 0x6f
000014E4  eor.b  d0, -$4d0c(a6)
000014E8  cmpa.w d0, a2
000014EA  cmp.l  (a1), d3
000014EC  cmp.w  -$45bb(a0), d4
000014F0  cmp.b  -(a7), d6
000014F2  ; data: 0xbe, 0x0f
000014F4  cmpa.l #$c1edc3e4, a7
000014FA  muls.w (a7)+, d2
000014FC  muls.w (a7)+, d3
000014FE  muls.w -(a3), d4
00001500  muls.w -$3208(a3), d5
00001504  ; data: 0xd0, 0x08
00001506  add.b  (a4)+, d1
00001508  add.b  $4f(a4, a5.w), d2
0000150C  add.w  -$2572(a5), d4
00001510  add.l  -$26(a3, a5.l), d6
00001514  asl.b  #$8, d3
00001516  lsl.b  d1, d7
00001518  rol.w  #$2, d6
0000151A  lsl.l  #$3, d6
0000151C  ; data: 0xe9, 0xc0
0000151E  ; data: 0xeb, 0xf4
00001520  lsr.b  d7, d2
00001522  dc.w   $f061
00001524  dc.w   $f299
00001526  dc.w   $f4d2
00001528  ; data: 0xf7, 0x0c
0000152A  ; data: 0xf9, 0x47
0000152C  ; data: 0xfb, 0x82
0000152E  ; data: 0xfd, 0xbe
00001530  btst.l d0, d0
00001532  btst.l d0, d0
00001534  btst.l d0, d0
00001536  btst.l d0, d0
00001538  btst.l d0, d0
0000153A  btst.l d0, d0
0000153C  btst.l d0, d0
0000153E  btst.l d0, d0
00001540  btst.l d0, d0
00001542  btst.l d0, d0
00001544  btst.l d0, d0
00001546  btst.l d0, d0
00001548  btst.l d0, d0
0000154A  btst.l d0, d0
0000154C  btst.l d0, d0
0000154E  btst.l d0, d0
00001550  btst.l d0, d0
00001552  btst.l d0, d0
00001554  btst.l d0, d0
00001556  btst.l d0, d0
00001558  btst.l d0, d0
0000155A  btst.l d0, d0
0000155C  btst.l d0, d0
0000155E  btst.l d0, d0
00001560  btst.l d0, d0
00001562  btst.l d0, d0
00001564  btst.l d0, d0
00001566  btst.l d0, d0
00001568  btst.l d0, d0
0000156A  btst.l d0, d0
0000156C  btst.l d0, d0
0000156E  btst.l d0, d0
00001570  btst.l d0, d0
00001572  andi.b #$24, (a4)
00001576  bset.b d7, (a4)+
00001578  ; data: 0x0f, 0xba
0000157A  bclr.b d7, (a2)+
0000157C  movep.w d6, $c78(a1)
00001580  eori.w #$956, -(a7)
00001584  ; data: 0x08, 0x45
00001586  addi.b #$23, $12(a4, d0.w)
0000158C  btst.l d1, d3
0000158E  andi.b #$0, d2
00001592  bchg.b d2, d7
00001594  addi.w #$fff, (a7)
00001598  ; data: 0x0e, 0xee
0000159A  bset.b d6, (a5)+
0000159C  ; data: 0x0c, 0xcc
0000159E  ; data: 0x0b, 0xbb
000015A0  eori.l #$9990888, $777(a2)
000015A8  addi.w #$555, -(a6)
000015AC  subi.w #$333, d4
000015B0  ori.b  #$0, d0
000015B4  ori.b  #$0, d0
000015B8  ; data: 0x0e, 0x0e
000015BA  subi.b #$0, d0
000015BE  asr.b  #$8, d0
000015C0  ori.b  #$0, d0
000015C4  ori.b  #$0, d0
000015C8  ori.b  #$0, d0
000015CC  ori.b  #$0, d0
000015D0  movep.l d0, $1800(a6)
000015D4  btst.l d1, d0
000015D6  bra.w  $15d8
000015DA  ori.b  #$0, d0
000015DE  ori.b  #$0, d0
000015E2  ori.b  #$0, d0
000015E6  move.b d0, -(a7)
000015E8  ; data: 0x00, 0x3e
000015EA  moveq  #$0, d4
000015EC  btst.l d1, d0
000015EE  bra.w  $15f0
000015F2  ori.b  #$0, d0
000015F6  ori.b  #$0, d0
000015FA  ori.b  #$0, d0
000015FE  move.b d0, $3c(a7, d0.w)
00001602  dc.w   $f000
00001604  btst.l d1, d0
00001606  move.w d0, d0
00001608  ori.b  #$0, d0
0000160C  ori.b  #$0, d0
00001610  ori.b  #$0, d0
00001614  ori.b  #$80, d0
00001618  ; data: 0x00, 0x3c
0000161A  moveq  #$0, d0
0000161C  btst.l d1, d0
0000161E  ; data: 0x0e, 0x00
00001620  ori.b  #$0, d0
00001624  ori.b  #$0, d0
00001628  ori.b  #$0, d0
0000162C  ori.b  #$80, d0
00001630  ; data: 0x00, 0x3c
00001632  moveq  #$0, d0
00001634  btst.l d0, d0
00001636  move.w d0, d0
00001638  ori.b  #$0, d0
0000163C  ori.b  #$0, d0
00001640  ori.b  #$0, d0
00001644  ori.b  #$c0, d0
00001648  ; data: 0x00, 0x3c
0000164A  moveq  #$0, d0
0000164C  btst.l d0, d0
0000164E  dc.w   $f000
00001650  ori.b  #$0, d0
00001654  ori.b  #$0, d0
00001658  ori.b  #$0, d0
0000165C  ori.b  #$c0, d0
00001660  ; data: 0x00, 0x3c
00001662  bra.w  $1967
00001666  asr.b  #$8, d1
00001668  and.b  d0, d0
0000166A  ori.b  #$0, d0
0000166E  ori.b  #$0, d0
00001672  ori.b  #$0, d0
00001676  ; data: 0x00, 0xe0
00001678  ori.w  #$6000, sr
0000167C  bclr.b d0, d7
0000167E  dc.w   $fc00
00001680  asr.b  #$8, d0
00001682  ori.b  #$0, d0
00001686  ori.b  #$0, d0
0000168A  ori.b  #$0, d0
0000168E  ori.b  #$cc, $6000.w
00001694  bclr.b d0, d0
00001696  bset.b d7, d0
00001698  asr.b  #$8, d0
0000169A  ori.b  #$0, d0
0000169E  ori.b  #$0, d0
000016A2  ori.b  #$0, d0
000016A6  ori.b  #$0, d7
000016AA  ori.b  #$0, d0
000016AE  ; data: 0x00, 0x3f
000016B0  asr.b  #$8, d0
000016B2  ori.b  #$0, d0
000016B6  ori.b  #$0, d0
000016BA  ori.b  #$0, d0
000016BE  ori.b  #$0, d0
000016C2  ori.b  #$0, d0
000016C6  ori.b  #$0, d1
000016CA  ori.b  #$0, d0
000016CE  ori.b  #$0, d0
000016D2  ori.b  #$0, d0
000016D6  ori.b  #$0, d0
000016DA  ori.b  #$0, d0
000016DE  ori.b  #$0, d0
000016E2  ori.b  #$0, d0
000016E6  ori.b  #$0, d0
000016EA  ori.b  #$0, d0
000016EE  ori.b  #$0, d0
000016F2  ori.b  #$0, d0
000016F6  ori.b  #$0, d0
000016FA  ori.b  #$0, d0
000016FE  ori.b  #$0, d0
00001702  ori.b  #$0, d0
00001706  ori.b  #$0, d0
0000170A  ori.b  #$0, d0
0000170E  ori.b  #$0, d0
00001712  ori.b  #$0, d0
00001716  ori.b  #$0, d0
0000171A  ori.b  #$0, d0
0000171E  ori.b  #$0, d0
00001722  ori.b  #$0, d0
00001726  ori.b  #$0, d0
0000172A  ori.b  #$0, d0
0000172E  ori.b  #$0, d0
00001732  ori.b  #$0, d0
00001736  ori.b  #$0, d0
0000173A  ori.b  #$0, d0
0000173E  ori.b  #$0, d0
00001742  ori.b  #$0, d0
00001746  ori.b  #$0, d0
0000174A  ori.b  #$0, d0
0000174E  ori.b  #$0, d0
00001752  ori.b  #$0, d0
00001756  ori.b  #$0, d0
0000175A  ori.b  #$0, d0
0000175E  ori.b  #$0, d0
00001762  ori.b  #$0, d0
00001766  ori.b  #$0, d0
0000176A  ori.b  #$0, d0
0000176E  ori.b  #$0, d0
00001772  ori.b  #$0, d0
00001776  ori.b  #$0, d0
0000177A  ori.b  #$0, d0
0000177E  ori.b  #$0, d0
00001782  ori.b  #$0, d0
00001786  ori.b  #$0, d0
0000178A  ori.b  #$0, d0
0000178E  ori.b  #$0, d0
00001792  ori.b  #$0, d0
00001796  ori.b  #$0, d0
0000179A  ori.b  #$0, d0
0000179E  ori.b  #$0, d0
000017A2  ori.b  #$0, d0
000017A6  ori.b  #$0, d0
000017AA  ori.b  #$0, d0
000017AE  ori.b  #$0, d0
000017B2  ori.b  #$0, d0
000017B6  ori.b  #$0, d0
000017BA  ori.b  #$0, d0
000017BE  ori.b  #$0, d0
000017C2  ori.b  #$0, d0
000017C6  ori.b  #$0, d0
000017CA  ori.b  #$0, d0
000017CE  ori.b  #$0, d0
000017D2  ori.b  #$0, d0
000017D6  ori.b  #$0, d0
000017DA  ori.b  #$0, d0
000017DE  ori.b  #$0, d0
000017E2  ori.b  #$0, d0
000017E6  ori.b  #$0, d0
000017EA  ori.b  #$0, d0
000017EE  ori.b  #$0, d0
000017F2  ori.b  #$0, d0
000017F6  ori.b  #$0, d0
000017FA  cmpi.b #$0, d0
000017FE  ori.b  #$0, d0
00001802  ori.b  #$0, d0
00001806  ori.b  #$0, d0
0000180A  ori.b  #$0, d0
0000180E  ori.b  #$0, d0
00001812  move.b d0, d6
00001814  ori.b  #$0, d0
00001818  ori.b  #$0, d0
0000181C  ori.b  #$0, d0
00001820  ori.b  #$0, d0
00001824  ori.b  #$0, d0
00001828  ori.b  #$3, d0
0000182C  ori.b  #$0, d0
00001830  ori.b  #$0, d0
00001834  ori.b  #$0, d0
00001838  ori.b  #$0, d0
0000183C  ori.b  #$0, d0
00001840  ori.b  #$3, d0
00001844  ori.b  #$0, d0
00001848  ori.b  #$0, d0
0000184C  ori.b  #$0, d0
00001850  ori.b  #$0, d0
00001854  ori.b  #$0, d0
00001858  ori.b  #$3, d0
0000185C  ori.b  #$0, d0
00001860  ori.b  #$0, d0
00001864  ori.b  #$0, d0
00001868  ori.b  #$0, d0
0000186C  ori.b  #$0, d0
00001870  ori.b  #$7, d3
00001874  ori.b  #$0, d0
00001878  ori.b  #$0, d0
0000187C  ori.b  #$0, d0
00001880  ori.b  #$0, d0
00001884  ori.b  #$0, d0
00001888  ori.b  #$6, d1
0000188C  ori.b  #$0, d0
00001890  ori.b  #$0, d0
00001894  ori.b  #$0, d0
00001898  ori.b  #$0, d0
0000189C  ori.b  #$0, d0
000018A0  ori.b  #$6, d1
000018A4  ori.b  #$0, d0
000018A8  ori.b  #$0, d0
000018AC  ori.b  #$0, d0
000018B0  ori.b  #$0, d0
000018B4  ori.b  #$0, d0
000018B8  ori.b  #$6, d0
000018BC  ori.b  #$0, d0
000018C0  ori.b  #$0, d0
000018C4  ori.b  #$0, d0
000018C8  ori.b  #$0, d0
000018CC  ori.b  #$0, d0
000018D0  ori.b  #$0, d0
000018D4  ori.b  #$0, d0
000018D8  ori.b  #$0, d0
000018DC  ori.b  #$0, d0
000018E0  ori.b  #$0, d0
000018E4  ori.b  #$0, d0
000018E8  ori.b  #$0, d0
000018EC  ori.b  #$0, d0
000018F0  ori.b  #$0, d0
000018F4  ori.b  #$0, d0
000018F8  ori.b  #$0, d0
000018FC  ori.b  #$0, d0
00001900  ori.b  #$0, d0
00001904  ori.b  #$0, d0
00001908  ori.b  #$0, d0
0000190C  ori.b  #$0, d0
00001910  ori.b  #$0, d0
00001914  ori.b  #$0, d0
00001918  ori.b  #$0, d0
0000191C  and.b  (a4)+, d0
0000191E  ori.b  #$0, d0
00001922  ori.b  #$0, d0
00001926  ori.b  #$0, d0
0000192A  ori.b  #$0, d0
0000192E  ori.b  #$0, d0
00001932  move.w d1, d7
00001934  or.w   #$0, d0
00001938  ori.b  #$0, d0
0000193C  ori.b  #$0, d0
00001940  ori.b  #$0, d0
00001944  ori.b  #$0, d0
00001948  bclr.b d3, d0
0000194A  ; data: 0x1f, 0xff
0000194C  divs.w $0.w, d0
00001950  ori.b  #$0, d0
00001954  ori.b  #$0, d0
00001958  ori.b  #$0, d0
0000195C  ori.b  #$0, d0
00001960  bset.b d3, d0
00001962  ; data: 0x00, 0x7f
00001964  bset.b d7, -(a0)
00001966  ori.b  #$0, d0
0000196A  ori.b  #$0, d0
0000196E  ori.b  #$0, d0
00001972  ori.b  #$0, d0
00001976  ori.b  #$e0, d0
0000197A  ori.b  #$0, d7
0000197E  ori.b  #$0, d0
00001982  ori.b  #$0, d0
00001986  ori.b  #$0, d0
0000198A  ori.b  #$0, d0
0000198E  ori.b  #$78, d0
00001992  btst.l d3, d3
00001994  and.b  d0, d0
00001996  ori.b  #$0, d0
0000199A  ori.b  #$0, d0
0000199E  ori.b  #$0, d0
000019A2  ori.b  #$0, d0
000019A6  ori.b  #$1c, d0
000019AA  move.b d0, (a6, a6.w)
000019AE  ori.b  #$0, d0
000019B2  ori.b  #$0, d0
000019B6  ori.b  #$0, d0
000019BA  ori.b  #$0, d0
000019BE  ori.b  #$1e, d0
000019C2  ; data: 0x79, 0x80
000019C4  moveq  #$0, d0
000019C6  ori.b  #$0, d0
000019CA  ori.b  #$0, d0
000019CE  ori.b  #$0, d0
000019D2  ori.b  #$bb, d3
000019D6  or.b   d0, d0
000019D8  ; data: 0x3f, 0xfc
000019DA  ; data: 0xf1, 0xc0
000019DC  moveq  #$0, d0
000019DE  ori.b  #$77, d7
000019E2  ori.b  #$0, d0
000019E6  ori.b  #$0, d0
000019EA  ori.b  #$bb, d3
000019EE  or.b   d0, d0
000019F0  ; data: 0x3f, 0xe0
000019F2  ; data: 0xe1, 0xc0
000019F4  move.w d0, d4
000019F6  ori.b  #$77, d7
000019FA  ori.b  #$0, d0
000019FE  ori.b  #$0, d0
00001A02  ori.b  #$bb, d3
00001A06  or.b   d0, d0
00001A08  ori.b  #$c0, d1
00001A0C  move.b d0, -(a7)
00001A0E  ori.b  #$77, d7
00001A12  ori.b  #$0, d0
00001A16  ori.b  #$0, d0
00001A1A  ori.b  #$bb, d3
00001A1E  or.b   d0, d0
00001A20  ori.b  #$c0, d3
00001A24  move.b d0, d7
00001A26  ori.b  #$77, d7
00001A2A  ori.b  #$0, d0
00001A2E  ori.b  #$0, d0
00001A32  ori.b  #$0, d0
00001A36  ori.b  #$7, d0
00001A3A  bclr.b d0, d0
00001A3C  move.b d0, d4
00001A3E  ori.b  #$0, d0
00001A42  ori.b  #$0, d0
00001A46  ori.b  #$0, d0
00001A4A  ori.b  #$0, d0
00001A4E  ori.b  #$7, d0
00001A52  bclr.b d0, d0
00001A54  move.w d0, d4
00001A56  ori.b  #$0, d0
00001A5A  ori.b  #$0, d0
00001A5E  ori.b  #$0, d0
00001A62  ori.b  #$0, d0
00001A66  ori.b  #$e, d0
00001A6A  bclr.b d1, d0
00001A6C  move.w d0, d4
00001A6E  ori.b  #$0, d0
00001A72  ori.b  #$0, d0
00001A76  ori.b  #$0, d0
00001A7A  ori.b  #$0, d0
00001A7E  ori.b  #$e, d0
00001A82  btst.l d3, d0
00001A84  move.w d0, d0
00001A86  ori.b  #$0, d0
00001A8A  ori.b  #$0, d0
00001A8E  ori.b  #$0, d0
00001A92  ori.b  #$0, d0
00001A96  ori.b  #$1e, d0
00001A9A  btst.l d3, d0
00001A9C  moveq  #$0, d0
00001A9E  ori.b  #$0, d0
00001AA2  ori.b  #$0, d0
00001AA6  ori.b  #$0, d0
00001AAA  ori.b  #$0, d0
00001AAE  ori.b  #$3e, d0
00001AB2  subi.b #$0, d0
00001AB6  ori.b  #$0, d0
00001ABA  ori.b  #$0, d0
00001ABE  ori.b  #$0, d0
00001AC2  ori.b  #$0, d0
00001AC6  ori.b  #$fe, d0
00001ACA  ori.b  #$e0, d0
00001ACE  ori.b  #$0, d0
00001AD2  ori.b  #$0, d0
00001AD6  ori.b  #$0, d0
00001ADA  ori.b  #$0, d0
00001ADE  ori.b  #$ff, d0
00001AE2  ori.b  #$f0, d3
00001AE6  ori.b  #$0, d0
00001AEA  ori.b  #$0, d0
00001AEE  ori.b  #$0, d0
00001AF2  ori.b  #$0, d0
00001AF6  ori.b  #$f, d0
00001AFA  ; data: 0x00, 0x0f
00001AFC  roxr.l #$8, d0
00001AFE  ori.b  #$0, d0
00001B02  ori.b  #$0, d0
00001B06  ori.b  #$0, d0
00001B0A  ori.b  #$0, d0
00001B0E  ori.b  #$f, d0
00001B12  ; data: 0x80, 0x7e
00001B14  moveq  #$0, d0
00001B16  ori.b  #$0, d0
00001B1A  ori.b  #$0, d0
00001B1E  ori.b  #$0, d0
00001B22  ori.b  #$0, d0
00001B26  ori.b  #$7, d0
00001B2A  muls.w $1800.w, d0
00001B2E  ori.b  #$0, d0
00001B32  ori.b  #$0, d0
00001B36  ori.b  #$0, d0
00001B3A  ori.b  #$0, d0
00001B3E  ori.b  #$f, d0
00001B42  ; data: 0xff, 0xe0
00001B44  ori.b  #$0, d0
00001B48  ori.b  #$0, d0
00001B4C  ori.b  #$0, d0
00001B50  ori.b  #$0, d0
00001B54  ori.b  #$0, d0
00001B58  ori.b  #$80, (a0)+
00001B5C  ori.b  #$0, d0
00001B60  ori.b  #$0, d0
00001B64  ori.b  #$0, d0
00001B68  ori.b  #$0, d0
00001B6C  ori.b  #$0, d0
00001B70  ori.b  #$7, d0
00001B74  ori.b  #$0, d0
00001B78  ori.b  #$0, d0
00001B7C  ori.b  #$0, d0
00001B80  ori.b  #$0, d0
00001B84  ori.b  #$0, d0
00001B88  ori.b  #$7, d1
00001B8C  or.b   d0, d0
00001B8E  ori.b  #$0, d0
00001B92  ori.b  #$0, d0
00001B96  ori.b  #$0, d0
00001B9A  ori.b  #$0, d0
00001B9E  ori.b  #$1, d0
00001BA2  sbcd.b d3, d1
00001BA4  or.b   d0, d0
00001BA6  ori.b  #$0, d0
00001BAA  ori.b  #$0, d0
00001BAE  ori.b  #$0, d0
00001BB2  ori.b  #$0, d0
00001BB6  ori.b  #$1, d0
00001BBA  or.b   d1, d0
00001BBC  and.b  d0, d0
00001BBE  ori.b  #$0, d0
00001BC2  ori.b  #$0, d0
00001BC6  ori.b  #$0, d0
00001BCA  ori.b  #$0, d0
00001BCE  ori.b  #$3, d0
00001BD2  or.b   d0, d0
00001BD4  and.b  d0, d0
00001BD6  ori.b  #$0, d0
00001BDA  ori.b  #$0, d0
00001BDE  ori.b  #$0, d0
00001BE2  ori.b  #$0, d0
00001BE6  ori.b  #$7, d0
00001BEA  ori.b  #$0, d0
00001BEE  ori.b  #$0, d0
00001BF2  ori.b  #$0, d0
00001BF6  ori.b  #$0, d0
00001BFA  ori.b  #$0, d0
00001BFE  ori.b  #$6, d0
00001C02  ori.b  #$0, d0
00001C06  ori.b  #$0, d0
00001C0A  ori.b  #$0, d0
00001C0E  ori.b  #$0, d0
00001C12  ori.b  #$0, d0
00001C16  ori.b  #$6, d0
00001C1A  ori.b  #$0, d0
00001C1E  ori.b  #$0, d0
00001C22  ori.b  #$0, d0
00001C26  ori.b  #$0, d0
00001C2A  ori.b  #$0, d0
00001C2E  ori.b  #$0, d0
00001C32  ori.b  #$0, d0
00001C36  ori.b  #$0, d0
00001C3A  ori.b  #$0, d0
00001C3E  ori.b  #$0, d0
00001C42  ori.b  #$0, d0
00001C46  ori.b  #$0, d0
00001C4A  ori.b  #$0, d0
00001C4E  ori.b  #$0, d0
00001C52  ori.b  #$0, d0
00001C56  ori.b  #$0, d0
00001C5A  ori.b  #$0, d0
00001C5E  ori.b  #$0, d0
00001C62  ori.b  #$0, d0
00001C66  ori.b  #$0, d0
00001C6A  ori.b  #$0, d0
00001C6E  ori.b  #$0, d0
00001C72  ori.b  #$0, d0
00001C76  ori.b  #$0, d0
00001C7A  ori.b  #$0, d0
00001C7E  ori.b  #$0, d0
00001C82  ori.b  #$0, d0
00001C86  ori.b  #$0, d0
00001C8A  ori.b  #$0, d0
00001C8E  ori.b  #$0, d0
00001C92  ori.b  #$0, d0
00001C96  ori.b  #$0, d0
00001C9A  ori.b  #$0, d0
00001C9E  ori.b  #$0, d0
00001CA2  ori.b  #$0, d0
00001CA6  ori.b  #$0, d0
00001CAA  ori.b  #$0, d0
00001CAE  ori.b  #$1, d0
00001CB2  ori.b  #$0, d0
00001CB6  ori.b  #$0, d0
00001CBA  ori.b  #$0, d0
00001CBE  ori.b  #$0, d0
00001CC2  ori.b  #$0, d0
00001CC6  ori.b  #$1, d0
00001CCA  or.b   d0, d0
00001CCC  ori.w  #$0, (a0, d0.w)
00001CD2  ori.b  #$0, d0
00001CD6  ori.b  #$0, d0
00001CDA  ori.b  #$0, d0
00001CDE  ori.b  #$1, d0
00001CE2  ori.b  #$fe, d0
00001CE6  ori.b  #$4, d0
00001CEA  ori.b  #$0, d0
00001CEE  ori.b  #$0, d0
00001CF2  ori.b  #$0, d0
00001CF6  ori.b  #$2, d0
00001CFA  ori.b  #$e1, d0
00001CFE  or.b   d0, d0
00001D00  ori.b  #$0, d6
00001D04  ori.w  #$0, $0.w
00001D0A  ori.b  #$0, d0
00001D0E  ori.b  #$e2, d0
00001D12  bra.w  $20d4
00001D16  or.b   d0, d0
00001D18  ori.b  #$0, d3
00001D1C  bset.b d0, (a0, d0.w)
00001D20  ori.b  #$0, d0
00001D24  ori.b  #$0, d0
00001D28  bclr.b d1, (a4)+
00001D2A  sub.b  d0, d0
00001D2C  btst.l d3, d0
00001D2E  and.b  d0, d0
00001D30  ori.b  #$0, d1
00001D34  ; data: 0x06, 0xe0
00001D36  ori.b  #$0, d0
00001D3A  ori.b  #$0, d0
00001D3E  ori.b  #$5, d0
00001D42  move.b d0, d0
00001D44  ; data: 0x0e, 0x00
00001D46  asr.b  #$8, d0
00001D48  ori.b  #$0, d0
00001D4C  ; data: 0x18, 0x40
00001D4E  ori.b  #$0, d0
00001D52  ori.b  #$0, d0
00001D56  ori.b  #$9, d0
00001D5A  ; data: 0x10, 0x08
00001D5C  add.b  d1, d6
00001D5E  dc.w   $f000
00001D60  ori.b  #$0, d0
00001D64  ; data: 0x7d, 0x80
00001D66  ori.b  #$0, d0
00001D6A  ori.b  #$0, d0
00001D6E  ori.b  #$b, d0
00001D72  move.b (a0)+, $1(a0, a3.l)
00001D76  asr.b  #$8, d0
00001D78  ori.b  #$80, d0
00001D7C  move.w (a6)+, d7
00001D7E  ori.b  #$0, d0
00001D82  ori.b  #$0, d0
00001D86  ori.b  #$12, d0
00001D8A  add.b  d1, (a1)
00001D8C  moveq  #$3, d4
00001D8E  and.b  d0, d0
00001D90  ori.b  #$e0, d0
00001D94  ori.l  #$f0f0f0, (a3)+
00001D9A  dc.w   $f0f0
00001D9C  dc.w   $f0f0
00001D9E  dc.w   $f0f0
00001DA0  dc.w   $f0e4
00001DA2  move.w -(a2), -(a3)
00001DA4  moveq  #$7, d0
00001DA6  or.b   d0, d0
00001DA8  ori.b  #$38, d0
00001DAC  bclr.b d0, (a1)+
00001DAE  divu.w -$10(a0, a7.w), d0
00001DB2  dc.w   $f0f0
00001DB4  dc.w   $f0f0
00001DB6  dc.w   $f0f0
00001DB8  dc.w   $f024
00001DBA  ; data: 0x1e, 0x44
00001DBC  lsr.b  #$8, d7
00001DBE  ori.b  #$c0, d0
00001DC2  ; data: 0x14, 0x0e
00001DC4  bclr.b d0, (a1)+
00001DC6  ; data: 0x00, 0xf0
00001DC8  dc.w   $f0f0
00001DCA  dc.w   $f0f0
00001DCC  dc.w   $f0f0
00001DCE  dc.w   $f0f0
00001DD0  dc.w   $f004
00001DD2  move.w a5, (a1)+
00001DD4  and.b  (a6)+, d0
00001DD6  ori.b  #$c0, d0
00001DDA  move.b d3, d2
00001DDC  ; data: 0x81, 0xcc
00001DDE  ; data: 0x00, 0xf0
00001DE0  dc.w   $f0f0
00001DE2  dc.w   $f0f0
00001DE4  dc.w   $f0f0
00001DE6  dc.w   $f0f0
00001DE8  dc.w   $f003
00001DEA  rol.l  #$2, d1
00001DEC  and.b  #$0, d0
00001DF0  ; data: 0x02, 0xc0
00001DF2  ; data: 0x1c, 0x40
00001DF4  asr.w  (a6)+
00001DF6  btst.b #$0, d0
00001DFA  ori.b  #$0, d0
00001DFE  ori.b  #$0, d0
00001E02  ; data: 0x87, 0x3b
00001E04  or.w   $0.w, d0
00001E08  dc.w   $6c0
00001E0A  ; data: 0x0c, 0xc0
00001E0C  moveq  #$d8, d4
00001E0E  move.b d0, d4
00001E10  ori.b  #$0, d0
00001E14  ori.b  #$0, d0
00001E18  ori.b  #$53, d0
00001E1C  dc.w   $f0
00001E1E  ori.b  #$80, d0
00001E22  bset.b d6, d0
00001E24  move.w $1800(a0), (a6)+
00001E28  ori.b  #$0, d0
00001E2C  ori.b  #$0, d0
00001E30  ori.b  #$b3, d0
00001E34  bset.b d0, d0
00001E36  ori.b  #$0, d0
00001E3A  bchg.b d3, d0
00001E3C  cas2.l d0:d0,d0:d0,(d0):(d0)
00001E42  ori.b  #$0, d0
00001E46  ori.b  #$0, d0
00001E4A  btst.l d1, -(a6)
00001E4C  bclr.b d3, d0
00001E4E  ori.b  #$0, d0
00001E52  addi.b #$e6, d0
00001E56  move.l d0, d0
00001E58  ori.b  #$0, d0
00001E5C  ori.b  #$0, d0
00001E60  ori.b  #$66, d0
00001E64  btst.l d7, d0
00001E66  ori.b  #$0, d0
00001E6A  btst.l d1, d0
00001E6C  move.w d3, (a4)
00001E6E  negx.b d0
00001E70  ori.b  #$0, d0
00001E74  ori.b  #$0, d0
00001E78  ori.b  #$4c, d0
00001E7C  move.w d0, d6
00001E7E  ori.b  #$0, d0
00001E82  bset.b d0, d0
00001E84  bra.b  $1e87
00001E86  or.b   d0, d0
00001E88  ori.b  #$0, d0
00001E8C  ori.b  #$0, d0
00001E90  ori.b  #$cc, d0
00001E94  dc.w   $f000
00001E96  ori.b  #$0, d0
00001E9A  ori.w  #$c000, (a0, d0.w)
00001EA0  ori.b  #$0, d0
00001EA4  ori.b  #$0, d0
00001EA8  ori.b  #$9b, d0
00001EAC  and.b  d0, d0
00001EAE  ori.b  #$0, d0
00001EB2  ori.b  #$0, (a7)+
00001EB6  ori.b  #$0, d0
00001EBA  ori.b  #$0, d0
00001EBE  ori.b  #$0, d0
00001EC2  ; data: 0x00, 0xff
00001EC4  ori.b  #$0, d0
00001EC8  moveq  #$0, d1
00001ECA  ori.b  #$0, d4
00001ECE  ori.b  #$0, d0
00001ED2  ori.b  #$0, d0
00001ED6  ori.b  #$0, d0
00001EDA  ori.b  #$1, (a0)
00001EDE  or.b   d0, d0
00001EE0  move.l d0, d0
00001EE2  ori.b  #$0, d0
00001EE6  ori.b  #$0, d0
00001EEA  ori.b  #$0, d0
00001EEE  ori.b  #$0, d0
00001EF2  ori.b  #$2, d0
00001EF6  ori.b  #$0, d0
00001EFA  ori.b  #$0, d0
00001EFE  ori.b  #$0, d0
00001F02  ori.b  #$0, d0
00001F06  ori.b  #$0, d0
00001F0A  ori.b  #$4, d0
00001F0E  ori.b  #$0, d0
00001F12  ori.b  #$0, d0
00001F16  ori.b  #$0, d0
00001F1A  ori.b  #$0, d0
00001F1E  ori.b  #$0, d0
00001F22  ori.b  #$8, d0
00001F26  ori.b  #$0, d0
00001F2A  ori.b  #$0, d0
00001F2E  ori.b  #$0, d0
00001F32  ori.b  #$0, d0
00001F36  ori.b  #$0, d0
00001F3A  ori.b  #$18, d0
00001F3E  move.w d0, d0
00001F40  ori.b  #$0, d0
00001F44  ori.b  #$0, d0
00001F48  ori.b  #$0, d0
00001F4C  ori.b  #$0, d0
00001F50  ori.b  #$0, d0
00001F54  ori.b  #$0, (a4)+
00001F58  ori.b  #$0, d0
00001F5C  ori.b  #$0, d0
00001F60  ori.b  #$0, d0
00001F64  ori.b  #$0, d0
00001F68  ori.b  #$0, d0
00001F6C  ; data: 0x00, 0x3f
00001F6E  ori.b  #$0, d0
00001F72  ori.b  #$0, d0
00001F76  ori.b  #$0, d0
00001F7A  ori.b  #$0, d0
00001F7E  ori.b  #$0, d0
00001F82  ori.b  #$38, d0
00001F86  ori.b  #$0, d0
00001F8A  ori.b  #$0, d0
00001F8E  ori.b  #$0, d0
00001F92  ori.b  #$0, d0
00001F96  ori.b  #$0, d0
00001F9A  ori.b  #$0, d0
00001F9E  ori.b  #$0, d0
00001FA2  ori.b  #$0, d0
00001FA6  ori.b  #$0, d0
00001FAA  ori.b  #$0, d0
00001FAE  ori.b  #$0, d0
00001FB2  ori.b  #$0, d0
00001FB6  ori.b  #$0, d0
00001FBA  ori.b  #$0, d0
00001FBE  ori.b  #$0, d0
00001FC2  ori.b  #$0, d0
00001FC6  ori.b  #$0, d0
00001FCA  ori.b  #$0, d0
00001FCE  ori.b  #$0, d0
00001FD2  ori.b  #$e0, d0
00001FD6  ori.b  #$0, d0
00001FDA  ori.b  #$0, d0
00001FDE  ori.b  #$0, d0
00001FE2  ori.b  #$0, d0
00001FE6  ori.b  #$0, d0
00001FEA  ori.b  #$7f, d0
00001FEE  asr.b  #$8, d0
00001FF0  ori.b  #$0, d0
00001FF4  ori.b  #$0, d0
00001FF8  ori.b  #$0, d0
00001FFC  ori.b  #$0, d0
00002000  ori.b  #$0, d0
00002004  ori.b  #$0, d0
00002008  ori.b  #$0, d0
0000200C  ori.b  #$0, d0
00002010  ori.b  #$0, d0
00002014  ori.b  #$0, d0
00002018  ori.b  #$0, d0
0000201C  ori.b  #$e0, d0
00002020  ori.b  #$0, d0
00002024  ori.b  #$0, d0
00002028  ori.b  #$0, d0
0000202C  ori.b  #$0, d0
00002030  ori.b  #$0, d0
00002034  ori.b  #$7c, d0
00002038  ori.b  #$0, d0
0000203C  ori.b  #$0, d0
00002040  ori.b  #$0, d0
00002044  ori.b  #$0, d0
00002048  ori.b  #$0, d0
0000204C  ori.b  #$1f, d0
00002050  asr.b  #$8, d0
00002052  ori.b  #$0, d0
00002056  ori.b  #$0, d0
0000205A  ori.b  #$0, d0
0000205E  ori.b  #$0, d0
00002062  ori.b  #$0, d0
00002066  ; data: 0x1c, 0x0f
00002068  dc.w   $fe00
0000206A  ori.b  #$0, d0
0000206E  ori.b  #$0, d0
00002072  ori.b  #$0, d0
00002076  ori.b  #$0, d0
0000207A  ori.b  #$0, d0
0000207E  btst.l d7, d7
00002080  dc.w   $fc00
00002082  asr.b  #$8, d0
00002084  ori.b  #$0, d0
00002088  ori.b  #$0, d0
0000208C  ori.b  #$0, d0
00002090  ori.b  #$0, d0
00002094  ori.b  #$e1, d0
00002098  dc.w   $f800
0000209A  asr.b  #$8, d0
0000209C  ori.b  #$0, d0
000020A0  ori.b  #$0, d0
000020A4  ori.b  #$0, d0
000020A8  ori.b  #$0, d0
000020AC  ori.b  #$f0, d0
000020B0  dc.w   $f001
000020B2  or.b   d0, d0
000020B4  ori.b  #$0, -(a0)
000020B8  ori.b  #$0, d0
000020BC  ori.b  #$0, d0
000020C0  ori.b  #$0, d0
000020C4  ori.b  #$0, d0
000020C8  moveq  #$1, d0
000020CA  ori.b  #$e0, d0
000020CE  ori.b  #$0, d0
000020D2  ori.b  #$0, d0
000020D6  ori.b  #$0, d0
000020DA  ori.b  #$0, d0
000020DE  move.w d0, d0
000020E0  move.l d0, d0
000020E2  ori.b  #$e0, d0
000020E6  ori.b  #$0, d0
000020EA  ori.b  #$0, d0
000020EE  ori.b  #$0, d0
000020F2  ori.b  #$0, d0
000020F6  move.b d0, d0
000020F8  ori.b  #$0, d0
000020FC  move.w d0, (a4)+
000020FE  ori.b  #$0, d0
00002102  ori.b  #$0, d0
00002106  ori.b  #$0, d0
0000210A  ori.b  #$0, d0
0000210E  ori.b  #$1, d0
00002112  abcd.b d0, d0
00002114  mulu.w d0, d0
00002116  ori.b  #$0, d0
0000211A  ori.b  #$0, d0
0000211E  ori.b  #$0, d0
00002122  ori.b  #$0, d0
00002126  ori.b  #$3, d0
0000212A  or.l   d1, d0
0000212C  or.l   d0, d0
0000212E  ori.b  #$0, d0
00002132  ori.b  #$0, d0
00002136  ori.b  #$0, d0
0000213A  ori.b  #$0, d7
0000213E  ori.b  #$3, d0
00002142  ori.w  #$8100, d1
00002146  ori.b  #$0, d0
0000214A  ori.b  #$0, d0
0000214E  ori.b  #$0, d0
00002152  ori.b  #$0, (a6)+
00002156  ori.b  #$2, d0
0000215A  ori.b  #$0, -(a0)
0000215E  ori.b  #$0, d0
00002162  ori.b  #$0, d0
00002166  ori.b  #$0, d0
0000216A  ori.b  #$0, (a6, d0.w)
00002170  ori.b  #$20, d4
00002174  move.b d0, d6
00002176  ori.b  #$0, d0
0000217A  ori.b  #$0, d0
0000217E  ori.b  #$0, d0
00002182  ; data: 0x00, 0xe6
00002184  ori.b  #$0, d0
00002188  ori.b  #$30, d4
0000218C  move.w d0, d0
0000218E  ori.b  #$0, d0
00002192  ori.b  #$0, d0
00002196  ori.b  #$0, d0
0000219A  movep.w d0, $0(a4)
0000219E  ori.b  #$4, d0
000021A2  ori.w  #$7c00, $0.w
000021A8  ori.b  #$0, d0
000021AC  ori.b  #$0, d0
000021B0  ori.b  #$8, d0
000021B4  ori.b  #$0, d0
000021B8  ori.b  #$f0, d2
000021BC  bset.b d1, d0
000021BE  ori.b  #$0, d0
000021C2  ori.b  #$0, d0
000021C6  ori.b  #$0, d0
000021CA  ; data: 0x04, 0x08
000021CC  ori.b  #$0, d0
000021D0  ori.b  #$c0, d3
000021D4  ori.w  #$0, $0.w
000021DA  ori.b  #$0, d0
000021DE  ori.b  #$0, d0
000021E2  move.b (a0)+, d4
000021E4  ori.b  #$0, d0
000021E8  ori.b  #$80, d1
000021EC  ; data: 0x00, 0x0e
000021EE  ori.b  #$0, d0
000021F2  ori.l  #$0, d0
000021F8  ori.b  #$18, d0
000021FC  ori.b  #$0, d0
00002200  ori.b  #$0, d0
00002204  ori.b  #$0, (a6)+
00002208  ori.b  #$e0, d0
0000220C  ori.b  #$0, d0
00002210  ori.b  #$38, d0
00002214  ori.b  #$0, d0
00002218  ori.b  #$0, d0
0000221C  ori.b  #$0, (a4)+
00002220  ori.b  #$f0, d3
00002224  ori.b  #$0, d0
00002228  ori.b  #$30, d0
0000222C  ori.b  #$0, d0
00002230  ori.b  #$0, d0
00002234  ori.b  #$0, $7.w
0000223A  ; data: 0xff, 0xf8
0000223C  ori.b  #$0, d0
00002240  ori.b  #$30, d1
00002244  ori.b  #$0, d0
00002248  ori.b  #$0, d0
0000224C  ori.w  #$0, $7(a0, d0.w)
00002252  ; data: 0xff, 0xf8
00002254  ori.b  #$0, d0
00002258  ori.b  #$30, d3
0000225C  ori.b  #$0, d0
00002260  ori.b  #$0, d0
00002264  ; data: 0x00, 0xe0
00002266  ori.b  #$7, d0
0000226A  ; data: 0xff, 0xf8
0000226C  ori.b  #$0, d0
00002270  ori.b  #$30, d7
00002274  ori.b  #$0, d0
00002278  ori.b  #$c, d0
0000227C  ; data: 0x00, 0xc0
0000227E  ori.b  #$7, d0
00002282  ; data: 0xff, 0xf8
00002284  ori.b  #$0, d0
00002288  ori.b  #$30, d7
0000228C  ori.b  #$0, d1
00002290  ori.b  #$1c, d0
00002294  bclr.b d0, d0
00002296  ori.b  #$3, d0
0000229A  ; data: 0xff, 0xf0
0000229C  ori.b  #$0, d0
000022A0  ori.b  #$30, d3
000022A4  ori.b  #$0, d7
000022A8  ori.b  #$14, d0
000022AC  btst.l d1, d0
000022AE  ori.b  #$0, d0
000022B2  ; data: 0xff, 0xe0
000022B4  ori.b  #$0, d0
000022B8  ori.b  #$30, d0
000022BC  ori.w  #$4000, $0.w
000022C2  ori.b  #$0, d4
000022C6  ori.b  #$0, d0
000022CA  ; data: 0x7f, 0xe0
000022CC  ori.b  #$0, d0
000022D0  ori.b  #$0, d0
000022D4  ori.l  #$80000000, d0
000022DA  ori.b  #$0, d4
000022DE  ori.b  #$0, d0
000022E2  ; data: 0x1f, 0xc0
000022E4  ori.b  #$0, d0
000022E8  ori.b  #$0, d0
000022EC  divu.w d1, d0
000022EE  or.b   d0, d0
000022F0  ori.b  #$0, d0
000022F4  btst.b #$0, d0
000022F8  ori.b  #$c0, d0
000022FC  ori.b  #$0, d0
00002300  ori.b  #$1, d0
00002304  or.b   d1, d0
00002306  ori.b  #$0, d0
0000230A  ori.b  #$0, d2
0000230E  ori.b  #$0, d0
00002312  bclr.b d1, d0
00002314  ori.b  #$0, d0
00002318  ori.b  #$6, d0
0000231C  or.b   d2, d0
0000231E  ori.b  #$0, d0
00002322  ori.b  #$0, d2
00002326  ori.b  #$0, d0
0000232A  bclr.b d0, d0
0000232C  ori.b  #$0, d0
00002330  ori.b  #$84, d0
00002334  or.b   d2, d0
00002336  ori.b  #$0, d0
0000233A  ori.b  #$0, d0
0000233E  ori.b  #$4, d0
00002342  and.l  d0, d0
00002344  ori.b  #$0, d0
00002348  ori.b  #$68, d0
0000234C  sub.b  d4, d0
0000234E  ori.b  #$0, d0
00002352  ori.b  #$0, d0
00002356  ori.b  #$f, d0
0000235A  asr.b  #$8, d0
0000235C  ori.b  #$0, d0
00002360  ori.b  #$38, d0
00002364  cmp.b  d5, d6
00002366  cmpi.b #$0, d0
0000236A  ori.b  #$0, d0
0000236E  ori.b  #$f, d0
00002372  asr.b  #$8, d0
00002374  ori.b  #$0, d0
00002378  ori.b  #$7c, d0
0000237C  ; data: 0xb2, 0x0a
0000237E  move.b d0, d4
00002380  ori.b  #$0, d0
00002384  ori.b  #$0, d0
00002388  ; data: 0x00, 0x0f
0000238A  and.b  d0, d0
0000238C  ori.b  #$0, d0
00002390  ori.b  #$d3, d0
00002394  ; data: 0xe2, 0xca
00002396  move.w d0, d0
00002398  ori.b  #$0, d0
0000239C  ori.b  #$0, d0
000023A0  ori.b  #$0, d3
000023A4  ori.b  #$0, d0
000023A8  ori.b  #$1, d0
000023AC  roxr.l #$2, d2
000023AE  moveq  #$0, d0
000023B0  ori.b  #$0, d0
000023B4  ori.b  #$0, d0
000023B8  ori.b  #$0, d0
000023BC  ori.b  #$0, d0
000023C0  ori.b  #$0, d0
000023C4  and.l  d2, (a4)
000023C6  and.b  d0, d0
000023C8  ori.b  #$0, d0
000023CC  ori.b  #$0, d0
000023D0  ori.b  #$0, d0
000023D4  ori.b  #$0, d0
000023D8  ori.b  #$0, d0
000023DC  btst.l d4, (a5, a0.w)
000023E0  ori.b  #$0, d0
000023E4  ori.b  #$0, d0
000023E8  ori.b  #$0, d0
000023EC  ori.b  #$0, d0
000023F0  ori.b  #$0, d0
000023F4  btst.l d4, -(a7)
000023F6  or.b   d0, d0
000023F8  ori.b  #$0, d0
000023FC  ori.b  #$0, d0
00002400  ori.b  #$0, d0
00002404  ori.b  #$0, d0
00002408  ori.b  #$0, d0
0000240C  ori.b  #$0, -(a7)
00002410  ori.b  #$0, d0
00002414  ori.b  #$0, d0
00002418  ori.b  #$0, d0
0000241C  ori.b  #$0, d0
00002420  ori.b  #$0, d0
00002424  ori.b  #$0, d2
00002428  ori.b  #$0, d0
0000242C  ori.b  #$0, d0
00002430  ori.b  #$0, d0
00002434  ori.b  #$0, d0
00002438  ori.b  #$0, d0
0000243C  ori.b  #$0, d6
00002440  ori.b  #$0, d0
00002444  ori.b  #$0, d0
00002448  ori.b  #$0, d0
0000244C  ori.b  #$0, d0
00002450  ori.b  #$0, d0
00002454  ori.b  #$0, d4
00002458  ori.b  #$0, d0
0000245C  ori.b  #$0, d0
00002460  ori.b  #$0, d0
00002464  ori.b  #$0, d0
00002468  ori.b  #$0, d0
0000246C  ; data: 0x00, 0x0c
0000246E  ori.b  #$0, d0
00002472  ori.b  #$0, d0
00002476  ori.b  #$0, d0
0000247A  ori.b  #$0, d0
0000247E  ori.b  #$0, d0
00002482  ori.b  #$8, d0
00002486  ori.b  #$0, d0
0000248A  ori.b  #$0, d0
0000248E  ori.b  #$0, d0
00002492  ori.b  #$0, d0
00002496  ori.b  #$0, d0
0000249A  ori.b  #$8, d0
0000249E  ori.b  #$0, d0
000024A2  ori.b  #$0, d0
000024A6  ori.b  #$0, d0
000024AA  ori.b  #$0, d0
000024AE  ori.b  #$0, d0
000024B2  ori.b  #$10, d0
000024B6  ori.b  #$0, d0
000024BA  ori.b  #$0, d0
000024BE  ori.b  #$0, d0
000024C2  ori.b  #$0, d0
000024C6  ori.b  #$0, d0
000024CA  ori.b  #$10, d0
000024CE  ori.b  #$0, d0
000024D2  ori.b  #$3, d0
000024D6  and.b  d0, d0
000024D8  ori.b  #$0, d0
000024DC  ori.b  #$0, d0
000024E0  ori.b  #$0, d0
000024E4  ori.b  #$0, (a0)
000024E8  ori.b  #$0, d0
000024EC  ; data: 0x00, 0x3f
000024EE  or.l   d0, d0
000024F0  ori.b  #$0, d0
000024F4  ori.b  #$0, d0
000024F8  ori.b  #$0, d0
000024FC  ori.b  #$0, (a0)
00002500  ori.b  #$20, d0
00002504  ; data: 0x01, 0xff
00002506  or.w   d0, -(a0)
00002508  ori.b  #$0, d0
0000250C  ori.b  #$0, d0
00002510  ori.b  #$0, d0
00002514  ori.b  #$0, d0
00002518  ori.b  #$e0, d0
0000251C  ; data: 0x1f, 0xff
0000251E  or.b   (a0), d1
00002520  ori.b  #$0, d0
00002524  ori.b  #$0, d0
00002528  ori.b  #$0, d0
0000252C  ori.b  #$0, d0
00002530  ori.b  #$c0, d0
00002534  ; data: 0xf7, 0xff
00002536  ; data: 0x00, 0x08
00002538  ori.b  #$0, d0
0000253C  ori.b  #$0, d0
00002540  ori.b  #$0, d0
00002544  ori.b  #$0, d0
00002548  ori.b  #$83, d0
0000254C  ; data: 0x87, 0x3f
0000254E  subi.b #$0, d4
00002552  ori.b  #$0, d0
00002556  ori.b  #$0, d0
0000255A  ori.b  #$0, d0
0000255E  ori.b  #$0, d0
00002562  ; data: 0xf7, 0x1e
00002564  btst.l d3, d7
00002566  ori.b  #$0, d6
0000256A  ori.b  #$0, d0
0000256E  ori.b  #$0, d0
00002572  ori.b  #$0, d0
00002576  ori.b  #$7, d0
0000257A  or.b   (a4)+, d3
0000257C  btst.l d3, d3
0000257E  btst.b #$0, d3
00002582  ori.b  #$0, d0
00002586  ori.b  #$0, d0
0000258A  ori.b  #$0, d0
0000258E  ori.b  #$7c, d0
00002592  ; data: 0x0c, 0x0c
00002594  btst.l d3, d0
00002596  move.b d3, d0
00002598  or.b   d0, d0
0000259A  ori.b  #$0, d0
0000259E  ori.b  #$0, d0
000025A2  ori.b  #$0, d0
000025A6  ; data: 0x00, 0x0f
000025A8  ; data: 0xff, 0xc0
000025AA  move.b d0, d4
000025AC  move.l d0, -(a3)
000025AE  move.b d3, d0
000025B0  and.b  d0, d0
000025B2  ori.b  #$0, d0
000025B6  ori.b  #$0, d0
000025BA  ori.b  #$0, d0
000025BE  ori.b  #$0, d7
000025C2  move.w d0, d4
000025C4  ; data: 0xf7, 0x00
000025C6  move.w d1, d0
000025C8  and.b  d0, d0
000025CA  ori.b  #$0, d0
000025CE  ori.b  #$0, d0
000025D2  ori.b  #$0, d0
000025D6  ori.b  #$0, d7
000025DA  moveq  #$1, d0
000025DC  ; data: 0xf7, 0x00
000025DE  move.l d1, d0
000025E0  asr.b  #$8, d0
000025E2  ori.b  #$0, d0
000025E6  ori.b  #$0, d0
000025EA  ori.b  #$0, d0
000025EE  ori.b  #$0, d7
000025F2  bra.b  $25f7
000025F4  ; data: 0xf7, 0x00
000025F6  bra.b  $25f9
000025F8  asr.b  #$8, d0
000025FA  ori.b  #$0, d0
000025FE  ori.b  #$0, d0
00002602  ori.b  #$0, d0
00002606  ori.b  #$0, d3
0000260A  lsr.b  #$8, d5
0000260C  ; data: 0xf7, 0x00
0000260E  bra.b  $2611
00002610  asr.b  #$8, d0
00002612  ori.b  #$0, d0
00002616  ori.b  #$0, d0
0000261A  ori.b  #$0, d0
0000261E  ori.b  #$0, d1
00002622  and.b  (a1), d0
00002624  asl.b  #$3, d0
00002626  bra.b  $262b
00002628  or.b   d0, d0
0000262A  ori.b  #$0, d0
0000262E  ori.b  #$0, d0
00002632  ori.b  #$0, d0
00002636  move.w d0, -(a7)
00002638  moveq  #$1, d0
0000263A  or.b   -(a0), d0
0000263C  asl.b  #$3, d0
0000263E  asr.b  #$8, d0
00002640  ori.b  #$0, d0
00002644  ori.b  #$0, d0
00002648  ori.b  #$0, d0
0000264C  ori.b  #$f0, d0
00002650  ori.b  #$40, d3
00002654  abcd.b d0, d3
00002656  asr.b  #$8, d0
00002658  ori.b  #$0, d0
0000265C  ori.b  #$0, d0
00002660  ori.b  #$0, d0
00002664  ori.b  #$8f, d0
00002668  ori.b  #$80, d3
0000266C  abcd.b d0, d1
0000266E  asr.b  #$8, d0
00002670  ori.b  #$0, d0
00002674  ori.b  #$0, d0
00002678  ori.b  #$0, d0
0000267C  ori.b  #$0, d0
00002680  dc.w   $f007
00002682  btst.l d1, d0
00002684  btst.l d1, d0
00002686  asr.b  #$8, d0
00002688  ori.b  #$0, d0
0000268C  ori.b  #$0, d0
00002690  ori.b  #$0, d0
00002694  ori.b  #$0, d0
00002698  ori.b  #$0, d0
0000269C  addi.w #$660, -(a0)
000026A0  ori.b  #$0, d0
000026A4  ori.b  #$0, d0
000026A8  ori.b  #$0, d0
000026AC  ori.b  #$0, d0
000026B0  ori.b  #$0, d0
000026B4  ori.b  #$5, d0
000026B8  dc.w   $5dfc
000026BA  bra.b  $26cf
000026BC  bra.w  $26be
000026C0  ori.b  #$0, d0
000026C4  ori.b  #$0, d0
000026C8  ori.b  #$0, d0
000026CC  ori.b  #$0, d0
000026D0  ori.b  #$aa, d0
000026D4  ; data: 0xaa, 0xa6
000026D6  move.w $ffffffd8(pc), (a6, d0.w)
000026DC  ori.b  #$0, d0
000026E0  ori.b  #$0, d0
000026E4  ori.b  #$0, d0
000026E8  ori.b  #$0, d0
000026EC  ori.b  #$80, d0
000026F0  ori.w  #$7ff7, (a4)
000026F4  move.l (a0), (a3)+
000026F6  ori.b  #$0, d0
000026FA  ori.b  #$0, d0
000026FE  ori.b  #$0, d0
00002702  ori.b  #$0, d0
00002706  ori.b  #$0, d0
0000270A  ; data: 0xaa, 0x00
0000270C  ; data: 0xa2, 0x8a
0000270E  ; data: 0x25, 0x7e
00002710  dc.w   $f759
00002712  ori.b  #$0, d0
00002716  ori.b  #$0, d0
0000271A  ori.b  #$0, d0
0000271E  ori.b  #$0, d0
00002722  ori.b  #$6, d0
00002726  or.b   d3, d0
00002728  ori.w  #$58e7, (a6)+
0000272C  ; data: 0x01, 0xfe
0000272E  ; data: 0xa0, 0x00
00002730  ori.b  #$0, d0
00002734  ori.b  #$0, d0
00002738  ori.b  #$0, d0
0000273C  ori.b  #$0, d0
00002740  ori.b  #$89, $1a(a4, d4.w)
00002746  dc.w   $8582
00002748  dc.w   $f80d
0000274A  dc.w   $f400
0000274C  ori.b  #$0, d0
00002750  ori.b  #$0, d0
00002754  ori.b  #$0, d0
00002758  ori.b  #$0, d0
0000275C  bset.b d0, d0
0000275E  ; data: 0x19, 0x3e
00002760  move.l $2881(pc), $823(a7)
00002766  dc.w   $f680
00002768  ori.b  #$0, d0
0000276C  ori.b  #$0, d0
00002770  ori.b  #$0, d0
00002774  ori.b  #$0, d0
00002778  subi.w #$7c00, (a5)
0000277C  seq.b  -$65(a2, a0.w)
00002780  move.l a5, d2
00002782  ; data: 0x71, 0x60
00002784  ori.b  #$0, d0
00002788  ori.b  #$0, d0
0000278C  ori.b  #$0, d0
00002790  ori.b  #$0, d0
00002794  move.w -$19fc(a6), d4
00002798  move.b $38(a1), (a7)+
0000279C  ; data: 0xae, 0x00
0000279E  dc.w   $6cc
000027A0  ori.b  #$0, d0
000027A4  ori.b  #$0, d0
000027A8  ori.b  #$0, d0
000027AC  ori.b  #$0, d0
000027B0  roxl.w #$8, d5
000027B2  subq.w #$3, d1
000027B4  bchg.b d7, (a4)
000027B6  andi.b #$ba, d0
000027BA  ; data: 0xa1, 0xe1
000027BC  ori.b  #$0, d0
000027C0  ori.b  #$0, d0
000027C4  ori.b  #$0, d0
000027C8  ori.b  #$2, d0
000027CC  bset.b d5, d0
000027CE  and.b  d7, (a2)
000027D0  suba.l ([a2, d6.w * 4], $663c0bf0), a7
000027D8  negx.b d0
000027DA  ori.b  #$0, d0
000027DE  ori.b  #$0, d0
000027E2  ori.b  #$0, d0
000027E6  ori.b  #$41, d4
000027EA  sub.l  a5, d7
000027EC  ble.b  $27d9
000027EE  addq.l #$5, $1317(a2)
000027F2  ; data: 0x27, 0x7f
000027F4  move.b d0, d0
000027F6  ori.b  #$0, d0
000027FA  ori.b  #$0, d0
000027FE  ori.b  #$0, d0
00002802  ori.b  #$ff, (a3)
00002806  ; data: 0x1f, 0x89
00002808  adda.l a1, a7
0000280A  dc.w   $ff71
0000280C  ; data: 0x00, 0x8f
0000280E  suba.l -(a7), a3
00002810  bcc.w  $2812
00002814  ori.b  #$0, d0
00002818  ori.b  #$0, d0
0000281C  ori.b  #$9d, d0
00002820  or.l   d7, -(a4)
00002822  move.w d0, (a5)
00002824  ; data: 0xab, 0x7b
00002826  ; data: 0xfb, 0xaa
00002828  ; data: 0xa0, 0x54
0000282A  cmpa.w (a3), a6
0000282C  abcd.b d0, d0
0000282E  ori.b  #$0, d0
00002832  ori.b  #$0, d0
00002836  ori.b  #$0, d0
0000283A  bchg.b d0, ([$a427], $57bb)
00002842  ; data: 0xff, 0xfd
00002844  negx.b d3
00002846  ; data: 0xe7, 0xcb
00002848  sub.b  d0, d0
0000284A  ori.b  #$0, d0
0000284E  ori.b  #$0, d0
00002852  ori.b  #$0, d0
00002856  bset.b d2, $52d5(a2)
0000285A  subq.l #$8, $4b(a6, a2.l)
0000285E  dc.w   $fd6a
00002860  ; data: 0xaa, 0x12
00002862  ; data: 0xa4, 0xa1
00002864  adda.w -(a0), a1
00002866  ori.b  #$0, d0
0000286A  ori.b  #$0, d0
0000286E  ori.b  #$0, d0
00002872  addi.w #$adff, d3
00002876  cmp.w  (a7)+, d4
00002878  ori.b  #$ff, d6
0000287C  ; data: 0xf1, 0x0f
0000287E  move.b -(a4), -$750(a7)
00002882  ori.b  #$0, d0
00002886  ori.b  #$0, d0
0000288A  ori.b  #$0, d0
0000288E  move.w (a4), $c6f7e01f.l
00002894  or.l   d3, d0
00002896  rol.w  #$8, d7
00002898  ; data: 0xa8, 0xe7
0000289A  eor.l  d3, $7c(a7, d7.l)
0000289E  ori.b  #$0, d0
000028A2  ori.b  #$0, d0
000028A6  ori.b  #$0, d0
000028AA  and.b  d4, $1e3e(a2)
000028AE  add.w  (a3)+, d0
000028B0  or.b   d3, d0
000028B2  add.b  -$2fa(a7), d6
000028B6  ; data: 0x2b, 0xf7
000028B8  ; data: 0xde, 0xbf
000028BA  ori.b  #$0, d0
000028BE  ori.b  #$0, d0
000028C2  ori.b  #$0, d0
000028C6  sub.w  (a5), d1
000028C8  add.b  d7, -$7fcc(a1)
000028CC  asr.b  #$4, d1
000028CE  dc.w   $8185
000028D0  ; data: 0x46, 0x0d
000028D2  ; data: 0x0d, 0x3f
000028D4  ; data: 0xff, 0xbe
000028D6  or.b   d0, d0
000028D8  ori.b  #$0, d0
000028DC  ori.b  #$0, d0
000028E0  ori.b  #$3e, d0
000028E4  ; data: 0x7f, 0x0a
000028E6  dc.w   $f060
000028E8  sub.b  $2e87cefb(invalid.w), d6
000028F0  lsl.b  #$7, d2
000028F2  negx.b d0
000028F4  ori.b  #$0, d0
000028F8  ori.b  #$0, d0
000028FC  ; data: 0x00, 0x0c
000028FE  lsr.w  d6, d3
00002900  addq.w #$5, (a5)
00002902  bvc.b  $28ec
00002904  bpl.b  $28ff
00002906  ; data: 0x7b, 0x95
00002908  move.l ([a5]), -$80(a3, d5.w)
0000290E  move.b d0, d0
00002910  ori.b  #$0, d0
00002914  ori.b  #$0, d0
00002918  ; data: 0x00, 0x0e
0000291A  move.b d6, (a2)+
0000291C  addi.l #$f8ecc5e9, -$2be(a3)
00002924  or.b   $7e3f(a0), d7
00002928  move.l d2, (a7)+
0000292A  cmpi.b #$0, d0
0000292E  ori.b  #$0, d0
00002932  ori.b  #$3b, d0
00002936  ; data: 0x04, 0x8b
00002938  ; data: 0x71, 0x55
0000293A  addq.b #$5, (a5)+
0000293C  and.l  -(a2), d5
0000293E  ; data: 0xaa, 0x85
00002940  ; data: 0x4c, 0x6a
00002942  ; data: 0x1e, 0x57
00002944  addq.b #$7, $5600(a3)
00002948  ori.b  #$0, d0
0000294C  ori.b  #$0, d0
00002950  ori.b  #$7d, d4
00002954  dc.w   $f6ff
00002956  eor.w  d4, -(a5)
00002958  dc.w   $f41f
0000295A  asl.b  #$8, d0
0000295C  ; data: 0x1f, 0xf8
0000295E  ; data: 0xff, 0x0f
00002960  ; data: 0x7f, 0x17
00002962  move.w d0, -(a3)
00002964  ori.b  #$0, d0
00002968  ori.b  #$0, d0
0000296C  bclr.b d0, d2
0000296E  mulu.w (a2)+, d5
00002970  ; data: 0xaf, 0x7b
00002972  ; data: 0xa1, 0x25
00002974  exg.l  d1, d7
00002976  addq.l #$5, $1522(a2)
0000297A  move.b (a5)+, (invalid.w)
0000297E  move.w d0, (a1, d0.w)
00002982  ori.b  #$0, d0
00002986  ori.b  #$d9, d0
0000298A  or.b   d7, (a5)+
0000298C  ; data: 0x4d, 0xff
0000298E  and.b  d5, (a7)
00002990  or.w   d5, (a7)+
00002992  dc.w   $fd55
00002994  move.l ([$389, a6, d1.l * 8], $71c00000), (a5)+
0000299E  ori.b  #$0, d0
000029A2  ori.b  #$a6, d0
000029A6  eori.w #$94bf, (a6)+
000029AA  and.b  d3, (a3)+
000029AC  muls.w -$2546(a7), d2
000029B0  or.w   d3, d6
000029B2  move.w ([$8ec00000]), d2
000029BA  ori.b  #$0, d0
000029BE  ori.b  #$f0, d0
000029C2  moveq  #$7c, d5
000029C4  cmpa.l (a7)+, a6
000029C6  ; data: 0x7d, 0x45
000029C8  ; data: 0xed, 0xdf
000029CA  ; data: 0xfd, 0xfa
000029CC  beq.b  $2a00
000029CE  asl.l  #$4, d5
000029D0  cmpa.l (d5.l * 8), a1
000029D4  ori.b  #$0, d0
000029D8  ori.b  #$0, d0
000029DC  move.b d3, (a6)+
000029DE  bcs.b  $29d8
000029E0  moveq  #$7d, d7
000029E2  move.l -$5756(a3), (a5)
000029E6  cmp.l  $3f87.w, d6
000029EA  ; data: 0x04, 0xcc
000029EC  bset.b d5, $7fd0(a3)
000029F0  ori.b  #$0, d0
000029F4  ori.b  #$0, d0
000029F8  ; data: 0x3b, 0xf8
000029FA  and.b  d5, ([$c0010657, a0], a7.l * 4, $fcf3afb9)
00002A06  ; data: 0x85, 0xbe
00002A08  ; data: 0x2f, 0xf9
00002A0A  add.b  d7, $0.w
00002A0E  ori.b  #$0, d0
00002A12  ori.b  #$f6, d0
00002A16  eor.w  d2, d0
00002A18  move.w (a5), (a7)
00002A1A  roxr.l #$2, d7
00002A1C  or.l   -$5896(a2), d3
00002A20  add.w  d3, ([], d4.l * 8, $517b)
00002A26  and.l  (a6)+, d5
00002A28  ori.b  #$0, d0
00002A2C  ori.b  #$0, d0
00002A30  adda.w $30(a4, d0.l), a2
00002A34  bmi.b  $2a45
00002A36  ror.b  d1, d7
00002A38  move.w d1, d4
00002A3A  ; data: 0x58, 0xbf
00002A3C  bmi.b  $2a0e
00002A3E  ; data: 0x37, 0xff
00002A40  dc.w   $f097
00002A42  ror.b  #$3, d7
00002A44  ori.b  #$0, d0
00002A48  ori.b  #$1, d0
00002A4C  bvc.b  $29f9
00002A4E  ; data: 0x10, 0x6d
00002A50  add.w  d7, d2
00002A52  cmp.l  (a7), d2
00002A54  ; data: 0x44, 0x8a
00002A56  eor.w  d5, (a1)+
00002A58  bchg.b d3, ([$8a4db31f])
00002A60  or.b   d0, d0
00002A62  ori.b  #$0, d0
00002A66  ori.b  #$ed, d3
00002A6A  dc.w   $f0e0
00002A6C  ; data: 0xa2, 0x23
00002A6E  and.l  d3, d0
00002A70  ori.b  #$a5, d0
00002A74  move.b (a1), (a0)
00002A76  suba.l (a7)+, a7
00002A78  ; data: 0x0c, 0xf2
00002A7A  dc.w   $fe4f
00002A7C  or.b   d0, d0
00002A7E  ori.b  #$0, d0
00002A82  ori.b  #$f6, d3
00002A86  bcs.b  $2a79
00002A88  bchg.b d0, (a5)
00002A8A  add.w  d2, (a5)
00002A8C  subq.b #$2, (a0)
00002A8E  movep.l d3, -$7031(a6)
00002A92  ; data: 0x3d, 0xeb
00002A94  dc.w   $4331
00002A96  ; data: 0x4f, 0x73
00002A98  ori.b  #$0, d0
00002A9C  ori.b  #$d, d0
00002AA0  ror.w  (a0)+
00002AA2  btst.l d1, (a4)+
00002AA4  ori.b  #$ee, -(a0)
00002AA8  ; data: 0xa2, 0x00
00002AAA  or.w   d1, -(a0)
00002AAC  ; data: 0x7f, 0xa1
00002AAE  ; data: 0xff, 0xff
00002AB0  movea.w $d0000000(invalid.w), a0
00002AB8  ori.b  #$13, d0
00002ABC  addq.w #$7, ([a0])
00002AC0  move.b (a5), $5525(a2)
00002AC4  subq.w #$2, (a4)
00002AC6  move.b d2, (a4)
00002AC8  dc.w   $fb6d
00002ACA  ; data: 0x75, 0xda
00002ACC  sub.w  d1, d7
00002ACE  bsr.b  $2a89
00002AD0  cmp.b  d0, d4
00002AD2  ori.b  #$0, d0
00002AD6  ; data: 0x00, 0x3f
00002AD8  divu.w (a4), d0
00002ADA  bset.b d2, -$61(a2, d0.l)
00002ADE  ; data: 0xff, 0x03
00002AE0  dc.w   $faaf
00002AE2  ; data: 0xf3, 0x9f
00002AE4  move.w $7c8044b7(invalid.w), -(a6)
00002AEC  move.b d0, d6
00002AEE  ori.b  #$0, d0
00002AF2  ori.b  #$e6, (a4)
00002AF6  divs.w (a6), d1
00002AF8  sub.w  d2, (a5)
00002AFA  dc.w   $fe0e
00002AFC  move.w (a0)+, -$2e91(a2)
00002B00  moveq  #$db, d5
00002B02  ; data: 0x55, 0x7a
00002B04  or.b   d0, -(a0)
00002B06  ; data: 0x23, 0xfe
00002B08  sub.b  d0, d6
00002B0A  ori.b  #$0, d0
00002B0E  ori.b  #$43, $47e5(a4)
00002B14  ble.b  $2af5
00002B16  moveq  #$36, d7
00002B18  ; data: 0x8f, 0xcd
00002B1A  add.l  $4a(a4, a7.w), d4
00002B1E  ; data: 0x00, 0xff
00002B20  bra.b  $2b48
00002B22  mulu.w $2b24(pc,d4.w), d4
00002B26  ori.b  #$0, d0
00002B2A  ori.w  #$a056, d0
00002B2E  adda.l ([a0, a5.w * 8], $ba33c750), a7
00002B36  bset.b d0, -$17fc(a6)
00002B3A  move.l (a5)+, $31c7(a3)
00002B3E  slt.b  $900(a6)
00002B42  ori.b  #$0, d0
00002B46  ori.b  #$5, (a3)+
00002B4A  ; data: 0x03, 0xff
00002B4C  ; data: 0xff, 0xbf
00002B4E  ; data: 0x3f, 0xc1
00002B50  or.l   d3, (a5)
00002B52  add.w  a7, d5
00002B54  ; data: 0xd2, 0x0c
00002B56  ; data: 0x8b, 0xbf
00002B58  subq.w #$1, -$49(a2, a7.l)
00002B5C  bclr.b d1, d0
00002B5E  ori.b  #$0, d0
00002B62  bchg.b d1, (a6)
00002B64  or.b   d5, -$6139(a2)
00002B68  ; data: 0x7f, 0xab
00002B6A  move.l d0, d5
00002B6C  add.l  (a1), d1
00002B6E  moveq  #$b, d5
00002B70  add.w  d6, d0
00002B72  bchg.b d7, (a7)+
00002B74  cmp.l  a1, d4
00002B76  ; data: 0xf9, 0xf2
00002B78  dc.w   $8540
00002B7A  ori.b  #$0, d0
00002B7E  btst.l d0, d1
00002B80  move.b (a0), (a2)+
00002B82  moveq  #$ef, d3
00002B84  dc.w   $fe61
00002B86  sf.b   d3
00002B88  move.l ([$2b8apc], d7.l * 4, $62f3), (a6)
00002B8E  or.b   (a7)+, d3
00002B90  ; data: 0xfb, 0xd7
00002B92  dc.w   $fc1e
00002B94  ; data: 0xf3, 0xc0
00002B96  ori.b  #$0, d0
00002B9A  addi.l #$66aef557, d4
00002BA0  cmpa.w -$5525(a0), a5
00002BA4  ; data: 0x46, 0x7b
00002BA6  sub.l  d7, d5
00002BA8  and.w  d0, (a5)+
00002BAA  and.b  ([$fbafa5c0, a5], a2.w * 4), d0
00002BB6  cmpi.b #$8, d2
00002BBA  addx.l -(a7), -(a1)
00002BBC  dc.w   $f48a
00002BBE  ori.w  #$d431, (a5)
00002BC2  subq.b #$7, -(a1)
00002BC4  ; data: 0x4a, 0xfa
00002BC6  or.w   d0, -$544(a3)
00002BCA  ; data: 0xff, 0x89
00002BCC  mulu.w d0, d4
00002BCE  ori.b  #$0, d0
00002BD2  move.b (a2), -$4f(a5, a1.w)
00002BD6  ; data: 0x54, 0x3e
00002BD8  ; data: 0xaa, 0x89
00002BDA  move.l d2, d2
00002BDC  move.l -$22e3(a4), d2
00002BE0  ; data: 0x45, 0x5d
00002BE2  and.b  (a5), d4
00002BE4  moveq  #$e8, d6
00002BE6  ; data: 0xfc, 0x7f
00002BE8  and.w  d6, $0(a0)
00002BEC  ori.b  #$83, d0
00002BF0  dc.w   $4521
00002BF2  ; data: 0x2c, 0xff
00002BF4  ; data: 0xd6, 0x0e
00002BF6  bclr.b d4, -(a3)
00002BF8  or.w   d0, (a2)
00002BFA  ; data: 0x5f, 0xba
00002BFC  ; data: 0xc8, 0xfe
00002BFE  asr.b  #$8, d6
00002C00  ; data: 0xff, 0xe8
00002C02  moveq  #$b6, d5
00002C04  moveq  #$e4, d7
00002C06  ori.b  #$0, d0
00002C0A  movea.w a3, a7
00002C0C  dc.w   $f287
00002C0E  seq.b  $1a(a7, a2.w)
00002C12  sub.l  d0, (a3)
00002C14  divs.w (a2)+, d3
00002C16  and.b  -$7aa1(a2), d3
00002C1A  ; data: 0xc5, 0x87
00002C1C  spl.b  (a0)
00002C1E  adda.l a6, a4
00002C20  ; data: 0x79, 0x76
00002C22  ori.b  #$0, d0
00002C26  move.l d1, d6
00002C28  asr.b  #$8, d2
00002C2A  eor.w  d7, (a3)
00002C2C  add.w  ([$576fc1cd, a7, d5.w], $802f9040), d2
00002C38  ; data: 0xff, 0xc0
00002C3A  ; data: 0xbc, 0xff
00002C3C  move.w $2c3e(pc), (a6)
00002C40  ori.b  #$58, d0
00002C44  ; data: 0xaa, 0x15
00002C46  subq.b #$4, (a7)+
00002C48  bcs.b  $2c47
00002C4A  cmpa.w (a0)+, a0
00002C4C  blt.b  $2c07
00002C4E  ; data: 0xfd, 0xf9
00002C50  ; data: 0xa9, 0x57
00002C52  add.l  d2, -(a7)
00002C54  sne.b  -$3b1(a0)
00002C58  roxl.w #$6, d7
00002C5A  ori.b  #$0, d0
00002C5E  ; data: 0x4c, 0x38
00002C60  addq.b #$8, -$1768(a7)
00002C64  ; data: 0xca, 0x7f
00002C66  bclr.b d4, -(a7)
00002C68  ; data: 0x02, 0x3e
00002C6A  ; data: 0x7f, 0xbc
00002C6C  ; data: 0x00, 0x0f
00002C6E  rol.b  d7, d7
00002C70  ; data: 0xaf, 0xb0
00002C72  move.w d3, -(a2)
00002C74  ; data: 0xf3, 0xfb
00002C76  or.b   d0, d0
00002C78  ori.b  #$5c, d0
00002C7C  cmp.w  (a5), d4
00002C7E  bcc.b  $2c23
00002C80  ; data: 0xaf, 0x7f
00002C82  roxl.l #$2, d0
00002C84  chk.w  -(a3), d6
00002C86  chk.w  -(a7), d6
00002C88  ; data: 0xaa, 0x55
00002C8A  ; data: 0x8c, 0xbf
00002C8C  add.l  d3, $2013.w
00002C90  cmpa.l $c0000000.l, a3
00002C96  or.l   $782f.w, d4
00002C9A  add.w  d1, d2
00002C9C  adda.w -$7efd(a0), a2
00002CA0  ; data: 0x5e, 0x0b
00002CA2  muls.w (a3), d1
00002CA4  add.b  d3, d0
00002CA6  sub.l  d4, (a6)+
00002CA8  divs.w (a0)+, d7
00002CAA  ; data: 0x44, 0x4a
00002CAC  dc.w   $f0ec
00002CAE  and.b  d0, d0
00002CB0  ori.b  #$5e, d3
00002CB4  ; data: 0xa9, 0x5b
00002CB6  dc.w   $4112
00002CB8  ; data: 0x43, 0x54
00002CBA  ori.l  #$2941d6b2, (a0)+
00002CC0  ; data: 0xaa, 0x15
00002CC2  asr.b  #$1, d7
00002CC4  lea.l  $4397(a2), a2
00002CC8  addq.b #$2, (a5)+
00002CCA  asr.b  #$8, d0
00002CCC  ori.b  #$78, d2
00002CD0  ; data: 0xb0, 0x0e
00002CD2  asr.l  d5, d1
00002CD4  move.l -(a3), d0
00002CD6  ori.w  #$2c44, (a1)+
00002CDA  bset.b d2, (a7)+
00002CDC  dc.w   $f05c
00002CDE  dc.w   $f4be
00002CE0  ; data: 0x02, 0xfd
00002CE2  ; data: 0xf1, 0x8f
00002CE4  and.b  d6, d1
00002CE6  ; data: 0xa0, 0x00
00002CE8  ori.b  #$55, d3
00002CEC  ; data: 0xa5, 0x54
00002CEE  move.l a1, -$1568(a2)
00002CF2  ; data: 0x80, 0x0a
00002CF4  move.w d3, -(a7)
00002CF6  addq.b #$7, (a5)
00002CF8  ; data: 0xa2, 0x1f
00002CFA  dc.w   $f576
00002CFC  bchg.b d0, $3fcd(a6)
00002D00  move.l d5, -(a2)
00002D02  moveq  #$0, d0
00002D04  ori.b  #$e2, d7
00002D08  ori.l  #$2bdc3b4e, $7.w
00002D10  bset.b d2, d1
00002D12  or.b   d3, $d(a3, a5.w)
00002D16  ; data: 0xae, 0xac
00002D18  ; data: 0x02, 0xfc
00002D1A  adda.l ([a3, d7.w * 8], $a000), a7
00002D20  ; data: 0x00, 0x0e
00002D22  ; data: 0xa5, 0x44
00002D24  ; data: 0xa5, 0x7b
00002D26  lea.l  (a4), a4
00002D28  svs.b  (a4, d0.w)
00002D2C  ; data: 0x02, 0xc5
00002D2E  ; data: 0xa5, 0x0b
00002D30  asr.l  d1, d1
00002D32  or.l   d6, -(a7)
00002D34  ; data: 0x40, 0x7a
00002D36  divs.w $43(a5, d7.l), d7
00002D3A  moveq  #$0, d4
00002D3C  ori.b  #$5d, d7
00002D40  andi.b #$ba, $300e02c5(a2, a2.l * 8)
00002D4A  ; data: 0xa4, 0x30
00002D4C  lea.l  -$e(a4, a1.l), a3
00002D50  bra.b  $2d07
00002D52  rol.w  d7, d1
00002D54  ; data: 0x4e, 0xc3
00002D56  move.w d0, d4
00002D58  ori.b  #$da, (a2)+
00002D5C  or.b   d2, ([$6061])
00002D62  addq.b #$8, d4
00002D64  bchg.b d0, d0
00002D66  ; data: 0xcb, 0xc8
00002D68  cmpa.l d6, a5
00002D6A  lsl.w  -(a6)
00002D6C  moveq  #$5e, d0
00002D6E  mulu.w $ed61.w, d0
00002D72  addq.b #$6, d0
00002D74  ori.b  #$44, (a7)
00002D78  ; data: 0x02, 0xf9
00002D7A  and.b  d5, (a1)+
00002D7C  eor.l  d1, (a1)+
00002D7E  ; data: 0x08, 0x08
00002D80  bchg.b d1, d0
00002D82  add.w  $40ea(a2), d4
00002D86  ; data: 0x2f, 0xf2
00002D88  sub.w  $70(a4, a7.l), d4
00002D8C  cmp.b  -(a0), d7
00002D8E  move.w d0, d6
00002D90  ; data: 0x00, 0x0a
00002D92  suba.w (a4), a2
00002D94  move.b #$31, $10b5(a2)
00002D9A  sbcd.b d5, d0
00002D9C  bclr.b d0, d4
00002D9E  dc.w   $fa0b
00002DA0  ; data: 0xa8, 0x4c
00002DA2  ; data: 0xf7, 0xe5
00002DA4  dc.w   $4100
00002DA6  ; data: 0x7d, 0x61
00002DA8  addq.b #$7, $4e00003d.l
00002DAE  btst.l d1, d5
00002DB0  ; data: 0x02, 0xfb
00002DB2  add.w  -$7f(a7, a5.l), d3
00002DB6  ori.b  #$c1, d1
00002DBA  asl.w  #$4, d7
00002DBC  or.w   (a3), d6
00002DBE  sub.w  d3, $68(a0, a4.w)
00002DC2  mulu.w d0, d0
00002DC4  dc.w   $f09f
00002DC6  ; data: 0xaa, 0x00
00002DC8  ori.w  #$9642, d2
00002DCC  ; data: 0x95, 0x7a
00002DCE  cmp.w  d3, d7
00002DD0  moveq  #$55, d2
00002DD2  btst.l d0, d0
00002DD4  or.l   d1, d0
00002DD6  exg.l  d1, d7
00002DD8  add.w  (a7), d2
00002DDA  sub.l  d1, d4
00002DDC  ; data: 0xa9, 0xae
00002DDE  move.b -(a0), (a4)+
00002DE0  move.w (a4, d2.l * 8), (a0)
00002DE4  ori.b  #$2d, (a4)+
00002DE8  ; data: 0x0b, 0xfe
00002DEA  move.l d6, d7
00002DEC  move.l $2dee(pc), -(a1)
00002DF0  and.b  d3, d0
00002DF2  ; data: 0x5a, 0x0b
00002DF4  ; data: 0x41, 0x7a
00002DF6  and.b  -(a7), d6
00002DF8  adda.l a5, a2
00002DFA  move.w a6, d7
00002DFC  moveq  #$fa, d5
00002DFE  ; data: 0x7f, 0x00
00002E00  ori.b  #$88, $15ef(a2)
00002E06  ; data: 0xa7, 0xed
00002E08  move.w $40(a3, d0.w), (a1)+
00002E0C  negx.b d0
00002E0E  ori.w  #$78cd, -$4d6d(a7)
00002E14  ; data: 0xeb, 0xe4
00002E16  move.l $36(a6, a5.l), (a6)
00002E1A  move.l d0, -(a3)
00002E1C  ori.w  #$e4c, $2ffd(a4)
00002E22  move.b $6b79(a6), (a0)+
00002E26  ; data: 0x00, 0x88
00002E28  bsr.b  $2dad
00002E2A  ; data: 0x24, 0xbf
00002E2C  cmpa.w a7, a5
00002E2E  ; data: 0xa7, 0x9f
00002E30  adda.l ([a2]), a7
00002E34  movea.l (a2)+, a3
00002E36  subx.l d0, d7
00002E38  ; data: 0x00, 0xca
00002E3A  subq.l #$2, d5
00002E3C  subq.l #$3, -$7f04(a3)
00002E40  tst.b  -$78(a0, d0.w)
00002E44  chk.w  -(a0), d1
00002E46  move.b (a7), (a4)+
00002E48  add.w  $3f(a7, d3.w), d4
00002E4C  ; data: 0xe9, 0xe2
00002E4E  ; data: 0xff, 0x4a
00002E50  bpl.b  $2ec6
00002E52  subq.l #$2, d0
00002E54  bclr.b d0, d4
00002E56  movep.w $ff4(a6), d7
00002E5A  ori.b  #$20, d3
00002E5E  ori.b  #$d3, d0
00002E62  ; data: 0x82, 0x4c
00002E64  lea.l  $69(a7, d7.w), a7
00002E68  rol.w  ([a2])
00002E6C  sge.b  (a1)+
00002E6E  move.b d0, $a(a2, d0.w)
00002E72  subq.l #$2, (a1)+
00002E74  subq.l #$2, $5f(a2)
00002E78  ; data: 0xaf, 0xdc
00002E7A  cmp.l  d4, d2
00002E7C  chk.w  (a7)+, d3
00002E7E  ; data: 0xfd, 0x3a
00002E80  bcs.b  $2e44
00002E82  ble.b  $2ee4
00002E84  add.b  (a4)+, d4
00002E86  add.l  (a3)+, d4
00002E88  suba.w a4, a6
00002E8A  dc.w   $8140
00002E8C  ori.l  #$29eb2fd0, d0
00002E92  move.l a1, d6
00002E94  add.l  -$32e8(a3), d5
00002E98  ; data: 0xc7, 0x3b
00002E9A  dc.w   $fc33
00002E9C  move.w (a1), (a4)
00002E9E  ; data: 0x47, 0x48
00002EA0  ; data: 0x7d, 0x1e
00002EA2  movea.l -(a6), a0
00002EA4  add.b  (a1)+, d3
00002EA6  ; data: 0xa8, 0x80
00002EA8  andi.b #$14, d0
00002EAC  subq.l #$3, $7aef(a1)
00002EB0  add.b  d7, -(a4)
00002EB2  subx.l d3, d6
00002EB4  andi.b #$67, (a7)+
00002EB8  asl.w  #$3, d3
00002EBA  sub.b  d2, ([$aa020ed8, a2])
00002EC2  muls.w d0, d3
00002EC4  btst.l d1, (a1)
00002EC6  ; data: 0x08, 0x7c
00002EC8  ; data: 0x3f, 0xf3
00002ECA  dc.w   $f954
00002ECC  bclr.b d1, d5
00002ECE  and.b  d3, d3
00002ED0  or.w   (a7), d1
00002ED2  ; data: 0x5e, 0x7e
00002ED4  moveq  #$97, d0
00002ED6  divs.w -(a5), d1
00002ED8  not.b  (a7)+
00002EDA  dc.w   $f00c
00002EDC  bset.b d2, (a4)+
00002EDE  bne.b  $2e80
00002EE0  movep.w -$28d7(a2), d0
00002EE4  subq.l #$3, -$a39(a3)
00002EE8  dc.w   $f155
00002EEA  or.b   d2, d0
00002EEC  ; data: 0x04, 0xfc
00002EEE  ; data: 0x7f, 0xd2
00002EF0  subq.b #$5, (a0)+
00002EF2  ; data: 0xa3, 0x92
00002EF4  ; data: 0xf9, 0x3f
00002EF6  ; data: 0xaa, 0x18
00002EF8  ble.b  $2ec2
00002EFA  cmpa.w -(a0), a3
00002EFC  btst.l d3, (a3)
00002EFE  ; data: 0xa5, 0x7a
00002F00  ; data: 0x2f, 0xc3
00002F02  adda.l d1, a7
00002F04  dc.w   $f810
00002F06  ; data: 0x80, 0x0e
00002F08  ; data: 0x05, 0xfa
00002F0A  move.w -(a4), (a7)+
00002F0C  ; data: 0xc8, 0x3d
00002F0E  btst.l d0, (a1)
00002F10  ; data: 0xfd, 0x1f
00002F12  dc.w   $f011
00002F14  add.w  a6, d3
00002F16  sub.b  d2, -(a0)
00002F18  bchg.b d0, $54a7(a7)
00002F1C  add.l  d3, $6fba(a3)
00002F20  add.l  $4(a0, d0.w), d0
00002F24  or.w   d3, $3cf1.w
00002F28  ; data: 0xa5, 0xd0
00002F2A  and.l  d2, (a6)+
00002F2C  ; data: 0x79, 0x3f
00002F2E  ; data: 0xaa, 0x2d
00002F30  or.b   -(a6), d6
00002F32  move.b -$49(a0, d0.w), (a4)+
00002F36  ; data: 0x3b, 0xe2
00002F38  eor.l  d7, d0
00002F3A  ; data: 0x7b, 0xf8
00002F3C  moveq  #$1, d1
00002F3E  ori.b  #$8, d2
00002F42  movea.l $4a00(a2), a6
00002F46  movep.w -$14e1(a4), d1
00002F4A  dc.w   $f433
00002F4C  move.l (a3), d2
00002F4E  addi.w #$f6f, -(a0)
00002F52  addq.w #$3, -(a3)
00002F54  add.l  d0, d3
00002F56  move.w -(a5), $1(a3, a1.w)
00002F5A  move.l a0, d0
00002F5C  ; data: 0x00, 0x0c
00002F5E  ori.w  #$6880, ([$6827eab5], a0.l * 8)
00002F68  move.l (a4), d0
00002F6A  or.w   d5, (a0)
00002F6C  bclr.b d0, (a2)
00002F6E  ; data: 0x2f, 0xc0
00002F70  eor.b  d7, d0
00002F72  bclr.b d3, (a0)
00002F74  asr.b  #$8, d0
00002F76  bra.b  $2f84
00002F78  ori.b  #$48, (a0)+
00002F7C  bchg.b d7, d3
00002F7E  bclr.b d2, (a4)
00002F80  addq.l #$3, (a4)
00002F82  cmpm.b (a2)+, (a2)+
00002F84  bne.b  $2fbd
00002F86  sub.w  -(a0), d5
00002F88  bset.b d4, (a0)+
00002F8A  subq.b #$3, $5680(a5)
00002F8E  movep.w d3, $1000(a2)
00002F92  lsr.w  d0, d4
00002F94  ori.b  #$f3, (a2)
00002F98  ror.l  #$4, d7
00002F9A  ; data: 0x0c, 0xd2
00002F9C  bchg.b d6, d3
00002F9E  and.b  (a4), d5
00002FA0  dc.w   $4127
00002FA2  subq.w #$2, (a0)+
00002FA4  bclr.b d1, (a0)+
00002FA6  move.w d0, -$4100(a7)
00002FAA  bclr.b d0, d2
00002FAC  btst.l d0, d0
00002FAE  and.b  (a0)+, d0
00002FB0  ori.b  #$e9, ([a6, a3.w])
00002FB6  divu.w d7, d0
00002FB8  ; data: 0x85, 0xba
00002FBA  ; data: 0x5c, 0x0c
00002FBC  ; data: 0xa3, 0xf3
00002FBE  move.l $1359(a0), $21(a6, d5.l)
00002FC4  addq.b #$7, d0
00002FC6  cmpi.b #$1, d6
00002FCA  or.b   (a0), d0
00002FCC  ori.w  #$3118, d1
00002FD0  moveq  #$a4, d1
00002FD2  dc.w   $8542
00002FD4  move.b d0, (a6)+
00002FD6  and.l  (a3), d1
00002FD8  or.b   d0, -$128(a7)
00002FDC  btst.l d4, (a0, d3.l * 4)
00002FE0  ; data: 0x7f, 0x80
00002FE2  move.b -$4a00(a7), (a6)+
00002FE6  ; data: 0x00, 0x08
00002FE8  ori.w  #$411f, (a0)+
00002FEC  roxr.w d0, d2
00002FEE  adda.w (a0), a1
00002FF0  bgt.b  $2fd4
00002FF2  bra.b  $2ff5
00002FF4  moveq  #$2b, d2
00002FF6  dc.w   $f0c8
00002FF8  bset.b d3, $582d(a1)
00002FFC  addq.l #$1, a0
00002FFE  ori.b  #$2, d6
00003002  negx.b d0
00003004  ; data: 0x00, 0xdc
00003006  bclr.b d1, (a3)+
00003008  dc.w   $f8f4
0000300A  eor.l  d2, -(a1)
0000300C  addq.w #$7, ([a6], a6.l, $4816)
00003012  bcs.b  $3070
00003014  ; data: 0x1b, 0xe0
00003016  cmp.l  d0, d4
00003018  eor.w  d7, d0
0000301A  ; data: 0x1a, 0x8d
0000301C  dc.w   $fea1
0000301E  or.b   d2, d0
00003020  ori.b  #$ff, (a4)
00003024  lsr.w  d4, d6
00003026  add.b  d4, (a3)
00003028  ; data: 0xaa, 0x7b
0000302A  sub.b  d4, d6
0000302C  ; data: 0x75, 0x33
0000302E  ; data: 0x75, 0x7c
00003030  move.l $1101(a1), $28(a2, d5.l)
00003036  move.l d5, d6
00003038  dc.w   $fc37
0000303A  and.b  d0, d0
0000303C  ; data: 0x00, 0xe0
0000303E  cmp.l  $3063(pc, a5.w), d5
00003042  asr.w  d0, d0
00003044  or.w   d5, (a6)
00003046  ; data: 0xa7, 0x8e
00003048  ; data: 0x73, 0xe2
0000304A  bne.b  $3028
0000304C  bset.b d7, (a0)
0000304E  asl.w  #$3, d0
00003050  moveq  #$0, d7
00003052  ; data: 0x18, 0x43
00003054  cmp.b  -$8000(a6), d2
00003058  sub.b  d5, ([], d7.l * 4, $f9fbe954)
00003060  addx.l -(a5), -(a2)
00003062  lsl.w  -$f(a7, a6.w)
00003066  ; data: 0x71, 0xbc
00003068  move.w #$a185, $8(a3, d5.w)
0000306E  ; data: 0x71, 0x9f
00003070  moveq  #$df, d1
00003072  ; data: 0xa0, 0x00
00003074  ; data: 0x12, 0x5a
00003076  ; data: 0xff, 0x0f
00003078  ror.l  d4, d4
0000307A  moveq  #$84, d0
0000307C  ; data: 0xff, 0x44
0000307E  subq.l #$3, (a6)+
00003080  ; data: 0xe2, 0xfb
00003082  move.w (a4)+, $2e55(a0)
00003086  eori.l #$bb407d36, d0
0000308C  move.b (a7)+, (a1)
0000308E  ori.b  #$16, d0
00003092  moveq  #$3f, d6
00003094  ; data: 0xfd, 0xc9
00003096  cmp.w  a6, d0
00003098  svc.b  -$c(a5, d6.w)
0000309C  ; data: 0xc1, 0xcb
0000309E  ; data: 0xa8, 0x28
000030A0  ; data: 0x1e, 0x6d
000030A2  move.l d1, d7
000030A4  subq.l #$3, -(a7)
000030A6  nbcd.b -(a6)
000030A8  ; data: 0xa0, 0x37
000030AA  ori.b  #$bc, d0
000030AE  ; data: 0xf0, 0x7f
000030B0  dc.w   $f837
000030B2  move.b $21f9(a2), ([$9ad097c, d5.w], $602d)
000030BE  ; data: 0x7d, 0x80
000030C0  ; data: 0x7f, 0xdf
000030C2  addq.l #$6, a5
000030C4  ; data: 0x90, 0x0e
000030C6  ori.b  #$17, d0
000030CA  ; data: 0xc0, 0x7f
000030CC  roxl.l d6, d1
000030CE  btst.l d0, -$2a48(a5)
000030D2  and.w  d4, ([$b8de, a3, d0.w * 4], $1857)
000030DA  subi.l #$57b7bd1b, -(a5)
000030E0  move.w -(a1), d0
000030E2  ori.b  #$5f, d0
000030E6  ; data: 0xa0, 0xbf
000030E8  and.b  (a3), d5
000030EA  ; data: 0x1c, 0x7f
000030EC  beq.b  $30e9
000030EE  bset.b d1, (a2)
000030F0  clr.b  (a1)+
000030F2  sub.w  (a6)+, d7
000030F4  bhi.b  $3135
000030F6  move.l d0, -$4021(a6)
000030FA  ror.b  #$1, d6
000030FC  move.w (a2, d0.w), d0
00003100  ori.b  #$bf, -$374b(a6)
00003106  dc.w   $ff73
00003108  movem.w $61ec(a6), d1-d2/d4-d7/a1/a3/a7
0000310E  ; data: 0xb8, 0x3e
00003110  bvc.b  $30fe
00003112  addq.l #$4, -(a1)
00003114  subq.l #$7, $56(a7, d5.w)
00003118  move.l (a0), d0
0000311A  ori.b  #$2, d0
0000311E  or.b   (a7)+, d2
00003120  subx.b d1, d5
00003122  cmpi.b #$df, d2
00003126  move.w $47b2(pc), d0
0000312A  ; data: 0xa8, 0xb6
0000312C  bmi.b  $315d
0000312E  ; data: 0x1d, 0xc0
00003130  ; data: 0x3f, 0xdf
00003132  mulu.w -$8000(a1), d1
00003136  ori.b  #$48, d0
0000313A  move.l a7, d0
0000313C  or.w   d4, -$3c38(a5)
00003140  ; data: 0x3a, 0x3e
00003142  dc.w   $f913
00003144  bsr.b  $30e2
00003146  move.b (a6)+, $7755(a6)
0000314A  ; data: 0x0e, 0xad
0000314C  subq.l #$3, $4932(a7)
00003150  or.b   d0, d0
00003152  ori.b  #$8, d0
00003156  andi.l #$11187dca, d7
0000315C  moveq  #$3f, d0
0000315E  bgt.b  $317f
00003160  ; data: 0x02, 0x88
00003162  add.l  #$2f961340, d0
00003168  ; data: 0x3f, 0xc0
0000316A  dc.w   $fb73
0000316C  negx.b d0
0000316E  ori.b  #$0, d0
00003172  bchg.b d2, d7
00003174  movep.w -$4d86(a0), d2
00003178  ; data: 0x26, 0x7e
0000317A  roxl.b d7, d7
0000317C  lea.l  -$37a2(a4), a3
00003180  ; data: 0x25, 0xe8
00003182  move.w -(a1), $56ab(a5)
00003186  lsl.l  #$3, d2
00003188  ori.b  #$0, d0
0000318C  ori.b  #$2c, d0
00003190  move.b -(a2), (a3)
00003192  ; data: 0xa5, 0xc6
00003194  ; data: 0x0e, 0x6d
00003196  ror.l  d5, d3
00003198  ; data: 0xaa, 0xc6
0000319A  ; data: 0x18, 0x7e
0000319C  cmpa.l -(a4), a7
0000319E  ; data: 0x4c, 0x30
000031A0  ; data: 0x2f, 0xd6
000031A2  adda.w (a4)+, a1
000031A4  cmp.b  d0, d0
000031A6  ori.b  #$0, d0
000031AA  move.b d0, -(a7)
000031AC  btst.l d1, d0
000031AE  ; data: 0xf9, 0x1c
000031B0  sub.b  ([a3], d5.w * 8, $f540), d2
000031B6  dc.w   $453b
000031B8  asl.l  #$3, d6
000031BA  ; data: 0x14, 0x58
000031BC  subq.l #$3, d7
000031BE  and.w  d4, -$4800(a6)
000031C2  ori.b  #$0, d0
000031C6  addq.b #$4, d0
000031C8  ; data: 0x75, 0x47
000031CA  ; data: 0xd9, 0x3c
000031CC  add.b  d7, d0
000031CE  cmp.b  -$7b(a0, d7.w), d5
000031D2  bset.b d0, ([$2303fb8], $f003)
000031DC  cmp.b  d0, d6
000031DE  ori.b  #$5, d0
000031E2  ; data: 0x4c, 0x00
000031E4  cmpa.l -$7d7(a5), a7
000031E8  ; data: 0xc4, 0x8f
000031EA  adda.l -(a2), a4
000031EC  move.w d4, (a4)
000031EE  move.b $55a9(a7), $1759(a0)
000031F4  subq.w #$2, d2
000031F6  moveq  #$55, d4
000031F8  cmp.b  d0, d6
000031FA  ori.b  #$6f, -$4000(a7)
00003200  move.w d7, $6c2e(a6)
00003204  cmpa.l (a7)+, a5
00003206  ; data: 0xff, 0x07
00003208  dc.w   $fc8b
0000320A  cmp.w  -(a7), d4
0000320C  divs.w (a3), d7
0000320E  ; data: 0xac, 0x30
00003210  move.l $2c05(a0), $3800(a7)
00003216  ori.b  #$f7, (a3)+
0000321A  negx.b d0
0000321C  move.b -$6f81(a2), -(a5)
00003220  ; data: 0xf7, 0x8d
00003222  add.b  d7, ([a0, d3.w * 8])
00003226  ; data: 0xa0, 0x27
00003228  add.l  d2, -$2de8(a0)
0000322C  scs.b  (a5)
0000322E  move.l d0, d4
00003230  move.w d0, -(a7)
00003232  ori.w  #$e380, (a7)+
00003236  negx.b d0
00003238  sub.b  d4, d7
0000323A  sub.l  d5, d4
0000323C  ; data: 0xaf, 0x5f
0000323E  move.w (a4), -$6f5(a5)
00003242  sne.b  $bf0(a7)
00003246  dc.w   $4728
00003248  ; data: 0x00, 0x7e
0000324A  cmp.b  d0, d2
0000324C  move.l d0, $1e(a3, d0.w)
00003250  moveq  #$60, d6
00003252  and.b  d0, d0
00003254  ; data: 0x7b, 0x16
00003256  ; data: 0x7b, 0xf7
00003258  add.l  -(a4), d7
0000325A  moveq  #$e8, d6
0000325C  moveq  #$c, d3
0000325E  ; data: 0x7f, 0x2f
00003260  lea.l  -$13aa(a2), a2
00003264  ; data: 0x5c, 0x7f
00003266  addq.b #$8, d0
00003268  bclr.b d3, d0
0000326A  ori.b  #$37, (a6)+
0000326E  or.b   d1, d0
00003270  moveq  #$3f, d6
00003272  suba.l ([$7960bf29, a5]), a7
0000327A  move.w (a7), $15ea(a1)
0000327E  roxr.w #$6, d6
00003280  sge.b  $7800(a3)
00003284  bclr.b d3, d0
00003286  ; data: 0x00, 0x0d
00003288  ; data: 0xce, 0x7d
0000328A  or.b   d1, d0
0000328C  ; data: 0x7d, 0x87
0000328E  divs.w ([]), d7
00003292  ; data: 0x79, 0x50
00003294  add.w  d5, $335743f0.l
0000329A  move.b $22fd(a4), d3
0000329E  move.w d0, d0
000032A0  bclr.b d3, d0
000032A2  ; data: 0x00, 0x0f
000032A4  suba.w (a5, d0.w), a4
000032A8  bset.b d7, -(a0)
000032AA  addx.l -(a7), -(a5)
000032AC  dc.w   $f466
000032AE  dc.w   $f8c0
000032B0  add.l  d7, $425b(a6)
000032B4  move.w -$7294(a2), -(a2)
000032B8  jmp    $ffffb2ba(pc)
000032BC  andi.l #$3b6e6, d0
000032C2  ori.b  #$f0, d5
000032C6  ; data: 0x73, 0xd5
000032C8  eor.w  d3, (a5)
000032CA  ; data: 0x79, 0x63
000032CC  btst.l d2, -$63a1(a5)
000032D0  ; data: 0x1b, 0xf4
000032D2  and.w  d7, ([$18080])
000032DA  ; data: 0x00, 0x08
000032DC  ; data: 0x47, 0xc8
000032DE  ; data: 0xa0, 0x00
000032E0  ; data: 0x2f, 0xf4
000032E2  subq.l #$3, -$fbd(a7)
000032E6  dc.w   $fcd6
000032E8  ; data: 0x00, 0x48
000032EA  dc.w   $ecd3
000032EC  bset.b d4, -$6b9c(a2)
000032F0  move.w $ffffb373(pc), -$1c70(a4)
000032F6  ; data: 0x00, 0x0b
000032F8  sub.w  d6, (a4)
000032FA  and.l  d5, d7
000032FC  cmpa.l $7fd7a43d.l, a2
00003302  asl.b  #$5, d0
00003304  or.l   d1, d5
00003306  ; data: 0xff, 0x97
00003308  sgt.b  $40f.w
0000330C  ; data: 0x12, 0xfd
0000330E  divu.w d0, d0
00003310  bset.b d3, $15.w
00003314  move.l -$1447(a0), $5fde(a5)
0000331A  dc.w   $fcaf
0000331C  and.l  -(a2), d3
0000331E  ; data: 0xff, 0x80
00003320  ; data: 0x4c, 0xcb
00003322  cmp.l  (a3)+, d6
00003324  ; data: 0x79, 0x6a
00003326  adda.l (a5), a3
00003328  ; data: 0x85, 0x7a
0000332A  ; data: 0xa3, 0xe0
0000332C  bset.b d3, $f.w
00003330  bchg.b d3, -(a0)
00003332  negx.w (a6)+
00003334  cmpa.l ([a7]), a6
00003338  ; data: 0xe3, 0xc4
0000333A  ; data: 0xfb, 0x18
0000333C  andi.l #$fb77bbfc, (d3.l * 4)
00003344  ; data: 0x42, 0xff
00003346  ; data: 0x41, 0xc0
00003348  bset.b d1, $1e.w
0000334C  btst.l d3, d0
0000334E  ; data: 0x20, 0xbe
00003350  subx.l -(a1), -(a7)
00003352  ; data: 0xb8, 0xbf
00003354  ; data: 0x39, 0xd1
00003356  ; data: 0x7f, 0x5c
00003358  eor.w  d3, (a1)
0000335A  move.l ([$9d53, a3], $955e), -(a6)
00003362  ; data: 0xac, 0x80
00003364  bset.b d0, $3b(a0, d0.w)
00003368  bclr.b d7, (a0)
0000336A  divu.w $5782(a2), d0
0000336E  move.w (a7), $11f0(a6)
00003372  bmi.b  $33df
00003374  move.w $1695c2fd.l, d7
0000337A  move.b $2ffdc40.l, (a5)+
00003380  ; data: 0x00, 0xe3
00003382  ; data: 0xb9, 0xfd
00003384  addq.w #$8, $5036eaf0.l
0000338A  ; data: 0xb8, 0xfe
0000338C  ror.w  d1, d0
0000338E  moveq  #$f6, d3
00003390  subq.w #$7, d3
00003392  ; data: 0x41, 0x0f
00003394  ; data: 0x45, 0x7a
00003396  ; data: 0x99, 0x7a
00003398  or.w   d2, (a7)
0000339A  ; data: 0xc7, 0x87
0000339C  ori.b  #$de, d7
000033A0  addq.w #$6, (a4)
000033A2  dc.w   $fe1a
000033A4  ; data: 0xf5, 0xa0
000033A6  movep.l d6, $789b(a6)
000033AA  ; data: 0xbd, 0xbc
000033AC  dc.w   $fc7a
000033AE  lsl.l  d0, d7
000033B0  ; data: 0x10, 0xfd
000033B2  ; data: 0x02, 0xff
000033B4  ; data: 0x00, 0xbf
000033B6  exg.l  d1, a7
000033B8  ; data: 0x80, 0x0f
000033BA  move.b (a7)+, d5
000033BC  move.b $7f8c(a6), $70c0(a1)
000033C2  move.b $8079(pc), -(a2)
000033C6  cmpa.w d1, a5
000033C8  bcs.b  $33d8
000033CA  ; data: 0xfb, 0xc7
000033CC  add.w  d4, (a2)+
000033CE  ; data: 0xa5, 0x5a
000033D0  ; data: 0xa1, 0x55
000033D2  rol.b  #$3, d7
000033D4  exg.l  d3, a7
000033D6  adda.w d6, a7
000033D8  ; data: 0x00, 0xe2
000033DA  ; data: 0x7f, 0xed
000033DC  bset.b d4, -(a0)
000033DE  move.l (a0)+, ([$745f, a1, d7.w], $c7e5)
000033E6  ; data: 0x17, 0xdf
000033E8  ; data: 0x98, 0xfd
000033EA  ; data: 0x02, 0xff
000033EC  or.b   -$2e4(a7), d0
000033F0  ; data: 0x47, 0xbf
000033F2  dc.w   $f46c
000033F4  bset.b d4, $49c4(a4)
000033F8  addq.w #$6, $11(a0, d1.w)
000033FC  move.l $f(a1, a7.l), -(a5)
00003400  and.l  $87f7.w, d2
00003404  move.l (a2)+, -$5ab3(a4)
00003408  ; data: 0xa8, 0x57
0000340A  moveq  #$b0, d5
0000340C  bset.b d3, -(a7)
0000340E  dc.w   $f63c
00003410  ; data: 0x04, 0x4a
00003412  roxl.l #$8, d3
00003414  roxr.l d5, d2
00003416  and.l  d3, (a0)
00003418  add.l  -(a2), d4
0000341A  cmp.l  (a7), d4
0000341C  or.l   d1, -(a1)
0000341E  beq.b  $3416
00003420  ; data: 0x40, 0xbf
00003422  ; data: 0x40, 0x8b
00003424  ; data: 0xc0, 0x0b
00003426  move.w d0, $6ff2(a7)
0000342A  ; data: 0xbf, 0x3c
0000342C  andi.l #$f9476f41, (a4)+
00003432  abcd.b d6, d5
00003434  ; data: 0x7b, 0x45
00003436  asr.l  #$5, d3
00003438  subx.l d4, d0
0000343A  ; data: 0xf7, 0xee
0000343C  ; data: 0x79, 0x5e
0000343E  ; data: 0xa1, 0x43
00003440  ; data: 0xa8, 0x14
00003442  move.w -(a1), (a5)
00003444  ; data: 0x2d, 0xfc
00003446  moveq  #$df, d2
00003448  bset.b d1, $7ab4(a0)
0000344C  roxr.l #$5, d7
0000344E  move.b (a6)+, $7631(a3)
00003452  and.l  (a5), d3
00003454  jsr    ([])
00003458  addq.b #$8, -$3fda(a7)
0000345C  and.b  d0, d4
0000345E  ; data: 0x1f, 0xe0
00003460  ; data: 0x4b, 0xbf
00003462  ror.b  #$2, d7
00003464  or.w   #$7803, d0
00003468  ; data: 0x7f, 0x03
0000346A  sub.l  $61cb(pc), d7
0000346E  adda.l a7, a0
00003470  dc.w   $f28c
00003472  ; data: 0xd3, 0xbe
00003474  cmpi.w #$a857, (a7)
00003478  ; data: 0xaa, 0xc0
0000347A  ; data: 0x17, 0xc5
0000347C  move.w ([$c32c7b03]), (a3)+
00003484  move.l a2, (a5)
00003486  ; data: 0xd5, 0xff
00003488  move.w -(a5), d2
0000348A  roxl.b d3, d5
0000348C  sbcd   -(a1), -(a2), #$f01e
00003490  subi.b #$2d, -$c00(a7)
00003496  movep.w -$5609(a0), d5
0000349A  asl.l  d1, d0
0000349C  and.b  d1, (a0)+
0000349E  bhi.b  $3423
000034A0  ; data: 0x7d, 0x5e
000034A2  ; data: 0xab, 0xfb
000034A4  ; data: 0x00, 0xdf
000034A6  and.w  (a3)+, d0
000034A8  sub.w  a6, d7
000034AA  ; data: 0xa8, 0xd6
000034AC  addq.w #$7, (a7)
000034AE  roxr.w #$4, d7
000034B0  asr.l  #$7, d6
000034B2  btst.l d1, ([$d04176bb])
000034BA  movea.l $29dd(a2), a0
000034BE  move.b -$5a82(a7), -$77b3(a2)
000034C4  move.b $708e(a7), -(a7)
000034C8  addq.b #$2, -$9d3(a7)
000034CC  and.b  d6, ([$37def8c9, a4, d0.w * 8], $c23a1a27)
000034D8  moveq  #$b1, d3
000034DA  ; data: 0x2f, 0xf2
000034DC  ; data: 0xc2, 0xff
000034DE  move.w sr, d5
000034E0  andi.l #$b55e2857, (a6)+
000034E6  dc.w   $ff54
000034E8  ; data: 0x06, 0xee
000034EA  bset.b d3, (a1)
000034EC  eor.w  d6, -$28bc(a0)
000034F0  muls.w -(a1), d5
000034F2  move.w ([$95ad, a3]), -$5583(a3)
000034FA  ; data: 0x11, 0x4b
000034FC  ; data: 0x51, 0xfd
000034FE  ; data: 0x4a, 0x0c
00003500  move.w a3, -(a3)
00003502  ; data: 0xff, 0x0b
00003504  ; data: 0x80, 0xfe
00003506  btst.l d5, d0
00003508  subx.b d0, d4
0000350A  bclr.b d3, d7
0000350C  dc.w   $8385
0000350E  add.b  d4, (a4)
00003510  addi.b #$ff, (a1)+
00003514  and.w  d1, $ff95b4ec.l
0000351A  cmpa.l (a4)+, a6
0000351C  btst.l d4, (a5)
0000351E  dc.w   $ff15
00003520  ; data: 0x86, 0x7e
00003522  ; data: 0x15, 0xee
00003524  ; data: 0x71, 0x96
00003526  ; data: 0xaf, 0xaf
00003528  ; data: 0xab, 0x77
0000352A  and.l  -(a1), d0
0000352C  ; data: 0xa5, 0x9e
0000352E  sub.l  d3, $22fc(a1)
00003532  cmp.w  a3, d7
00003534  sub.b  d0, (a6)+
00003536  moveq  #$9c, d4
00003538  move.b d3, d5
0000353A  ; data: 0xff, 0x00
0000353C  ; data: 0x15, 0xff
0000353E  divu.w #$dbd3, d1
00003542  ; data: 0x1f, 0x4f
00003544  ; data: 0xfd, 0xe7
00003546  ; data: 0x00, 0xc7
00003548  ; data: 0xa1, 0x0f
0000354A  ; data: 0x3f, 0xf1
0000354C  mulu.w ([$ec86b63c]), d3
00003554  move.w d5, (a2)
00003556  moveq  #$80, d7
00003558  scc.b  $555f(a7)
0000355C  ; data: 0xf5, 0xf9
0000355E  ; data: 0xab, 0x0d
00003560  cmpa.w -(a5), a3
00003562  move.l -$7c5d(a5), $53a8(a0)
00003568  lea.l  -$41(a0, a2.w), a3
0000356C  cmpm.b (a3)+, (a4)+
0000356E  bge.b  $35ec
00003570  move.b d3, -(a1)
00003572  ; data: 0xfd, 0x03
00003574  addi.b #$4, (a7)+
00003578  dc.w   $f8fc
0000357A  ; data: 0xd6, 0x0f
0000357C  bchg.b d5, (a6)+
0000357E  and.w  d7, d6
00003580  ble.b  $359b
00003582  bclr.b d3, (a1)
00003584  subq.w #$3, $4fff(a3)
00003588  dc.w   $fc2f
0000358A  and.b  $1ea5.w, d2
0000358E  addq.l #$5, -(a1)
00003590  add.l  (a5), d2
00003592  or.b   d2, -(a5)
00003594  dc.w   $f62f
00003596  chk.w  (a7)+, d3
00003598  move.l d7, (a1)+
0000359A  bcs.b  $3579
0000359C  blt.b  $3595
0000359E  addq.l #$3, d1
000035A0  dc.w   $f096
000035A2  cmpa.w d6, a1
000035A4  or.b   d7, d2
000035A6  dc.w   $f0f8
000035A8  btst.l d7, d2
000035AA  dc.w   $fd13
000035AC  move.l -(a3), $3916.w
000035B0  ; data: 0xfc, 0x7f
000035B2  dc.w   $ff2c
000035B4  chk.w  -(a1), d3
000035B6  add.l  d2, (a3)+
000035B8  ; data: 0x4d, 0x4b
000035BA  ; data: 0x7f, 0x43
000035BC  asr.l  #$8, d2
000035BE  move.w -(a7), (a0)+
000035C0  move.l $1da55ab3(a16, invalid.w), (invalid.w)
000035CA  ; data: 0xbf, 0xbd
000035CC  ; data: 0x5b, 0xbb
000035CE  divu.w (a4)+, d3
000035D0  dc.w   $838f
000035D2  ; data: 0xd4, 0x7e
000035D4  or.w   d6, d0
000035D6  moveq  #$a1, d4
000035D8  ; data: 0xab, 0x42
000035DA  scs.b  $60bf(a2)
000035DE  move.b $e40.w, (a5)+
000035E2  cmpa.l ([a7], $bf2), a7
000035E8  ; data: 0xb0, 0x0f
000035EA  or.b   -$5bb1(a5), d5
000035EE  moveq  #$d4, d4
000035F0  or.l   d3, d7
000035F2  mulu.w d0, d7
000035F4  exg.l  d3, a6
000035F6  ; data: 0xa1, 0x9c
000035F8  ; data: 0x40, 0x7d
000035FA  subq.w #$8, -$5f(a0, d0.l)
000035FE  addq.l #$3, -(a0)
00003600  addq.w #$1, -$4e13(a0)
00003604  addq.l #$5, -(a0)
00003606  cmpi.b #$2b, (a4)+
0000360A  adda.w $42d3(a1), a1
0000360E  lsl.b  d1, d0
00003610  cmpa.l -$78f4(a2), a5
00003614  dc.w   $f473
00003616  move.l -$30(a0, d0.w), (a0)
0000361A  ; data: 0x2f, 0xd0
0000361C  ; data: 0xff, 0xe4
0000361E  divs.w d2, d7
00003620  move.l d0, d4
00003622  addi.b #$45, -$560d(a4)
00003628  ; data: 0xaa, 0x5b
0000362A  dc.w   $8580
0000362C  cmpa.l $309(a6), a0
00003630  movea.w $aa857aa(invalid.w), a2
00003638  dc.w   $fef3
0000363A  move.b d5, -$2c(a6, d5.w)
0000363E  or.b   (a4), d7
00003640  dc.w   $f552
00003642  ; data: 0x4c, 0x47
00003644  ; data: 0x7f, 0x03
00003646  cmp.l  -(a4), d3
00003648  scs.b  -(a6)
0000364A  btst.l d0, (a6)+
0000364C  muls.w (a2)+, d1
0000364E  and.b  $ff5e1ed(invalid.w), d1
00003656  ; data: 0xcd, 0x80
00003658  ; data: 0x0a, 0xbc
0000365A  ; data: 0x1b, 0xdd
0000365C  ; data: 0xff, 0xe0
0000365E  ; data: 0xbd, 0x7a
00003660  bge.b  $3663
00003662  ; data: 0xf7, 0x80
00003664  ; data: 0x43, 0x65
00003666  bclr.b d6, (a0)
00003668  lsr.w  -(a5)
0000366A  ; data: 0xf5, 0xa0
0000366C  bchg.b d0, $15ea(a2)
00003670  ; data: 0xf5, 0xe8
00003672  moveq  #$e1, d3
00003674  subq.w #$2, (a4)
00003676  sub.w  d5, (a3)+
00003678  subq.w #$2, (a4)
0000367A  moveq  #$62, d0
0000367C  subq.b #$7, -(a0)
0000367E  ; data: 0xa9, 0x00
00003680  ; data: 0x7f, 0x27
00003682  eori.w #$e660, (a2)
00003686  asl.w  d4, d0
00003688  bclr.b d3, $7fd.w
0000368C  moveq  #$51, d5
0000368E  ; data: 0xac, 0xc0
00003690  andi.b #$f3, -$115d(a6)
00003696  ; data: 0xa2, 0xf4
00003698  move.l (a3, d0.l * 8), $975(a3)
0000369E  or.b   d3, d2
000036A0  not.w  -$420(a4)
000036A4  movep.w -$6a86(a2), d1
000036A8  adda.l (a3)+, a7
000036AA  ; data: 0x1a, 0x68
000036AC  or.w   (a4), d2
000036AE  asr.b  #$5, d4
000036B0  add.w  d2, (a5)
000036B2  eor.l  d4, $73(a0, d5.w)
000036B6  addi.w #$a133, d0
000036BA  or.w   d5, d1
000036BC  or.b   d7, -(a1)
000036BE  asl.w  #$7, d0
000036C0  bclr.b d0, (a4)+
000036C2  ; data: 0x02, 0xff
000036C4  cmp.b  -(a0), d4
000036C6  ; data: 0xfd, 0x00
000036C8  ori.b  #$53, d3
000036CC  ; data: 0xae, 0x00
000036CE  bcc.b  $3671
000036D0  cmpa.l $1d(a3, a4.w), a0
000036D4  cmpa.w (a3), a6
000036D6  move.l d3, d6
000036D8  or.b   (invalid.w), d5
000036DC  ; data: 0x03, 0xba
000036DE  ; data: 0xa5, 0x3f
000036E0  ; data: 0xd4, 0x3e
000036E2  move.w (a2)+, -(a2)
000036E4  ; data: 0xa0, 0x12
000036E6  bls.b  $3691
000036E8  ; data: 0xaa, 0x54
000036EA  chk.w  -(a7), d1
000036EC  asl.w  -(a3)
000036EE  sub.b  d4, (a5)+
000036F0  or.b   (a3), d4
000036F2  addq.b #$3, (a5)
000036F4  move.w -(a1), $e5c0.w
000036F8  ; data: 0x01, 0x3f
000036FA  andi.b #$ea, -$14db(a7)
00003700  ori.b  #$92, d6
00003704  ble.b  $36d6
00003706  moveq  #$3f, d2
00003708  or.w   d4, -(a1)
0000370A  move.w ([, d3.l * 8]), d7
0000370E  move.w a7, -(a3)
00003710  ; data: 0x1a, 0x6c
00003712  ; data: 0xf9, 0x80
00003714  ; data: 0x00, 0xd7
00003716  move.l -(a7), -(a2)
00003718  dc.w   $f568
0000371A  roxr.b #$4, d6
0000371C  ; data: 0xa8, 0x86
0000371E  blt.b  $3797
00003720  bset.b d3, -(a2)
00003722  dc.w   $ff36
00003724  bclr.b d1, -(a1)
00003726  dc.w   $f550
00003728  btst.l d5, ([a2], $60ca)
0000372E  move.l d0, ([$8097, a4], d0.w, $f800)
00003736  adda.w d3, a5
00003738  negx.b d2
0000373A  dc.w   $4f04
0000373C  or.l   $b9830745.l, d2
00003742  cmp.b  ([$ef126e05, d0.l], $7780), d7
0000374C  ; data: 0x00, 0x4f
0000374E  bvs.b  $37a0
00003750  asr.w  #$6, d0
00003752  ; data: 0xac, 0xd6
00003754  add.l  -$4b4c(a3), d5
00003758  andi.w #$fa68, (a5)+
0000375C  ; data: 0x1f, 0xe2
0000375E  ; data: 0x8a, 0xcd
00003760  moveq  #$39, d3
00003762  add.w  d7, -(a1)
00003764  move.w (a2)+, (a3)
00003766  move.l d0, -(a1)
00003768  ; data: 0x00, 0xc4
0000376A  move.b -(a5), d0
0000376C  dc.w   $f211
0000376E  sne.b  d7
00003770  btst.l d2, (a0)
00003772  add.w  d3, (a0)
00003774  ; data: 0x40, 0x7a
00003776  ; data: 0xa2, 0x3e
00003778  dc.w   $8d80
0000377A  ; data: 0x06, 0x8b
0000377C  cmp.b  (a0)+, d6
0000377E  ; data: 0x8e, 0x89
00003780  bmi.b  $3748
00003782  addx.b d0, d7
00003784  ori.w  #$a850, -(a2)
00003788  moveq  #$5e, d4
0000378A  add.w  -$55(a6, a0.w), d6
0000378E  neg.w  -$54(a0, a6.l)
00003792  ; data: 0xa8, 0xdf
00003794  ori.b  #$a3, d2
00003798  ; data: 0x0a, 0x7d
0000379A  subx.w d3, d4
0000379C  ; data: 0xff, 0x0f
0000379E  move.l d0, d3
000037A0  ori.b  #$0, $4b(a7, d1.l)
000037A6  cmp.b  (a7), d2
000037A8  bchg.b d1, (a4)
000037AA  movem.w d0/d2/d4/d6/a4-a7, ([$c0000463])
000037B4  ; data: 0x7f, 0xf8
000037B6  sub.w  (a3)+, d4
000037B8  asr.b  #$7, d1
000037BA  ; data: 0x0e, 0x00
000037BC  ori.w  #$eb95, $3446(a1)
000037C2  sub.l  (a6), d2
000037C4  andi.l #$4d4bfaae, -$4051(a0)
000037CC  or.l   -(a3), d1
000037CE  ; data: 0x56, 0x7d
000037D0  dc.w   $fe3d
000037D2  ; data: 0xfb, 0xbb
000037D4  and.w  d5, (a5, a0.l * 8)
000037D8  ori.b  #$c2, (a7)+
000037DC  roxr.w d4, d7
000037DE  moveq  #$c3, d0
000037E0  divs.w $15(a0, d7.l), d1
000037E4  ; data: 0x75, 0xf1
000037E6  ; data: 0xdf, 0xba
000037E8  btst.l d2, d4
000037EA  bclr.b d7, $9932efb3.l
000037F0  asl.l  d7, d0
000037F2  ; data: 0xac, 0x00
000037F4  ; data: 0x00, 0x3d
000037F6  bls.b  $37dd
000037F8  and.w  -(a3), d0
000037FA  bsr.b  $37f9
000037FC  and.l  d3, ([$aaff, a7.l * 2], $817b001d)
00003806  chk.w  (a5)+, d1
00003808  cmpi.l #$c7e15ff0, -$400(a5)
00003810  ori.b  #$e0, d3
00003814  bra.b  $37d1
00003816  move.l $5e08(pc), $7f3fff9f.l
0000381E  and.l  $3f(a6, d0.w), d1
00003822  or.l   (a7)+, d3
00003824  bne.b  $389f
00003826  dc.w   $4318
00003828  asl.b  d5, d7
0000382A  moveq  #$0, d4
0000382C  ori.b  #$e1, (a2)+
00003830  moveq  #$9f, d0
00003832  btst.l d0, $3e6eeeaf(invalid.w)
0000383A  asr.l  d1, d0
0000383C  move.l (a7), d0
0000383E  ; data: 0x1d, 0x0d
00003840  ; data: 0x4e, 0x78
00003842  add.l  d3, -(a2)
00003844  dbvs   d4, $a046
00003848  ori.b  #$d1, d6
0000384C  clr.w  -(a6)
0000384E  dc.w   $8f88
00003850  ; data: 0xc3, 0xfe
00003852  ; data: 0x04, 0xff
00003854  ; data: 0xff, 0xff
00003856  mulu.w d1, d0
00003858  ; data: 0x08, 0x0b
0000385A  cmpa.w $69(a0, d1.l), a2
0000385E  roxl.l d5, d3
00003860  muls.w -(a3), d1
00003862  cmp.b  d0, d0
00003864  ; data: 0x00, 0x08
00003866  negx.l -$1c6e(a1)
0000386A  move.b d0, ([a3])
0000386E  ; data: 0x84, 0x7f
00003870  ; data: 0xff, 0xf7
00003872  addq.l #$6, -(a2)
00003874  addi.b #$5c, (a7)
00003878  move.w -(a2), $6472(a0)
0000387C  adda.l (a2)+, a3
0000387E  add.b  d0, d0
00003880  ori.b  #$cf, d3
00003884  dc.w   $f088
00003886  move.l (a0), (a2)+
00003888  ; data: 0x25, 0xff
0000388A  ; data: 0xc0, 0xfe
0000388C  dc.w   $fe63
0000388E  ; data: 0xa7, 0x00
00003890  move.l a4, $a3cb6348.l
00003896  dc.w   $50fb
00003898  dc.w   $fe3b
0000389A  asr.b  #$8, d0
0000389C  ori.b  #$87, d7
000038A0  bmi.b  $38fc
000038A2  addq.w #$8, $3b1f(a4)
000038A6  add.w  d4, (a7)+
000038A8  ror.w  d6, d5
000038AA  bhi.b  $3910
000038AC  ; data: 0x19, 0xe1
000038AE  addq.l #$4, d4
000038B0  move.l a1, ([$ff19e000])
000038B8  ori.b  #$46, d0
000038BC  or.b   d2, ([$2455, a7])
000038C2  dc.w   $fc8d
000038C4  adda.l (a2), a7
000038C6  move.l a6, -(a7)
000038C8  bset.b d4, -(a4)
000038CA  movea.l (a7), a6
000038CC  dc.w   $4d38
000038CE  suba.l #$5fba4000, a6
000038D4  ori.b  #$ab, d3
000038D8  and.b  -$541(a7), d3
000038DC  pea.l  $1d01.w
000038E0  ; data: 0xa8, 0x61
000038E2  subq.b #$7, -(a6)
000038E4  add.w  d0, d4
000038E6  move.l -(a6), -(a3)
000038E8  ; data: 0xa2, 0x09
000038EA  move.b (a4)+, (a2)+
000038EC  dc.w   $6dff
000038EE  negx.b d0
000038F0  ori.b  #$3b, d0
000038F4  and.w  (a7)+, d6
000038F6  ; data: 0xff, 0x1f
000038F8  ; data: 0xfd, 0xad
000038FA  or.b   (a3)+, d6
000038FC  suba.l (a4), a5
000038FE  move.b d2, d7
00003900  move.w (a3), d7
00003902  cmp.l  a5, d7
00003904  add.b  -(a6), d2
00003906  ; data: 0xd0, 0x7f
00003908  move.w -(a4), (a5)+
0000390A  or.b   d0, d0
0000390C  ori.b  #$18, d0
00003910  dc.w   $fc4b
00003912  dc.w   $fe82
00003914  ; data: 0x7b, 0xe5
00003916  add.w  d7, -$39(a7, d7.l)
0000391A  subi.b #$be, (a4)
0000391E  dc.w   $faf6
00003920  ; data: 0xac, 0xf6
00003922  or.w   d4, (a5)
00003924  subq.l #$2, (a7, d0.w)
00003928  ori.b  #$3a, d0
0000392C  move.b (a6)+, (a6)+
0000392E  ; data: 0xff, 0xc4
00003930  bls.b  $391b
00003932  ; data: 0x1f, 0xdb
00003934  abcd.b d0, d2
00003936  subi.b #$19, d0
0000393A  ; data: 0x10, 0xcb
0000393C  ; data: 0x56, 0xfd
0000393E  and.w  -$4b(a0, d7.w), d7
00003942  ori.b  #$0, d0
00003946  move.l ([$3ffc1a80]), $74(a6, a7.l)
00003950  dc.w   $838c
00003952  or.w   d0, (a1)
00003954  bvs.b  $3964
00003956  ; data: 0x1a, 0x44
00003958  cmp.b  -(a3), d1
0000395A  ; data: 0xf5, 0x7d
0000395C  muls.w (a0)+, d0
0000395E  ori.b  #$0, d0
00003962  ; data: 0x2f, 0xf0
00003964  move.b #$fc, ([a1, d0.l * 4], $7e43)
0000396C  ; data: 0xc7, 0xbb
0000396E  move.b -$3d7f(a7), d0
00003972  ; data: 0x0c, 0xdd
00003974  move.w -$3021(a4), d0
00003978  ; data: 0xea, 0xfc
0000397A  ori.b  #$0, d0
0000397E  ; data: 0x27, 0xc5
00003980  ; data: 0xb5, 0xfe
00003982  andi.l #$5aba323f, -$18e2(a7)
0000398A  move.w (a3), -(a6)
0000398C  bvs.b  $3991
0000398E  ; data: 0xa8, 0x52
00003990  addq.w #$8, (a2)
00003992  addx.b d7, d6
00003994  bmi.b  $3992
00003996  ori.b  #$0, d0
0000399A  bclr.b d3, d5
0000399C  adda.l ([], d5.w * 2, $fd580465), a1
000039A4  ; data: 0xa7, 0xbc
000039A6  addi.w #$7017, -$7e11(a6)
000039AC  ; data: 0xf6, 0x27
000039AE  ; data: 0x7f, 0x86
000039B0  ; data: 0xf1, 0xf0
000039B2  ori.b  #$0, d0
000039B6  ; data: 0x1f, 0x08
000039B8  ; data: 0x0f, 0xfa
000039BA  move.b (a1), ([$996a], a3.l)
000039C0  moveq  #$54, d7
000039C2  dc.w   $f05a
000039C4  ; data: 0x48, 0xcb
000039C6  roxl.w (a5)
000039C8  dc.w   $fa4f
000039CA  ; data: 0xff, 0x80
000039CC  ; data: 0x43, 0x68
000039CE  ori.b  #$0, d0
000039D2  ; data: 0x0a, 0x4f
000039D4  moveq  #$d4, d2
000039D6  move.b #$57, d2
000039DA  ; data: 0xaa, 0x3c
000039DC  move.w ([$c1f74bbc]), (a7)+
000039E4  ; data: 0xfd, 0x0c
000039E6  cmpm.b (a2)+, (a5)+
000039E8  move.l (a0, d0.w), (a7, d0.w)
000039EE  ori.w  #$5aaa, ([a1], a1.w)
000039F4  or.w   d4, d4
000039F6  ; data: 0xff, 0x82
000039F8  bset.b d2, d2
000039FA  sub.w  -(a2), d7
000039FC  move.w #$884f, (a7)
00003A00  ror.b  #$5, d1
00003A02  ; data: 0x9f, 0x3e
00003A04  ; data: 0x7b, 0xa0
00003A06  ori.b  #$0, d0
00003A0A  btst.l d0, $7d(a1, a3.l)
00003A0E  ori.b  #$a3, -(a1)
00003A12  seq.b  (a1)+
00003A14  sgt.b  $7517(a6, d1.l * 2)
00003A1A  move.w a7, (a6)
00003A1C  dc.w   $f75c
00003A1E  addq.w #$7, (a5)+
00003A20  ; data: 0xff, 0xc0
00003A22  ori.b  #$0, d0
00003A26  ; data: 0x02, 0xed
00003A28  adda.w -$57a9(a2), a4
00003A2C  move.w -(a1), -$65(a5)
00003A30  addq.w #$4, ([])
00003A34  add.b  -(a6), d7
00003A36  add.w  a7, d3
00003A38  ; data: 0xa5, 0x99
00003A3A  ; data: 0xbc, 0x7f
00003A3C  ; data: 0xff, 0x40
00003A3E  ori.b  #$0, d0
00003A42  btst.l d0, d5
00003A44  move.b (a7)+, $48f6.w
00003A48  sub.l  d3, (a1)
00003A4A  ; data: 0x1f, 0xeb
00003A4C  move.l $3d28(a1), -(a6)
00003A50  ; data: 0x94, 0x0a
00003A52  ; data: 0x45, 0xff
00003A54  ; data: 0xa1, 0x83
00003A56  ; data: 0x3e, 0x3f
00003A58  cmp.l  d0, d6
00003A5A  ori.b  #$0, d0
00003A5E  ; data: 0x00, 0x4e
00003A60  ; data: 0xc1, 0x7e
00003A62  sub.b  (a2, a2.l * 4), d5
00003A66  bset.b d6, -(a0)
00003A68  ; data: 0xae, 0xad
00003A6A  ; data: 0x84, 0x09
00003A6C  ; data: 0x27, 0xd4
00003A6E  ; data: 0xc7, 0x7b
00003A70  bclr.b d5, d2
00003A72  ; data: 0x7f, 0x77
00003A74  addx.b d0, d4
00003A76  ori.b  #$0, d0
00003A7A  ori.w  #$4acf, sr
00003A7E  asr.w  #$7, d0
00003A80  asl.l  #$8, d0
00003A82  bset.b d3, d0
00003A84  move.w d7, -(a6)
00003A86  ; data: 0x1e, 0x50
00003A88  sle.b  ([$8532f08e, a1])
00003A90  cmp.b  d0, d4
00003A92  ori.b  #$0, d0
00003A96  ori.b  #$26, -(a2)
00003A9A  cmp.w  $6028(a6), d4
00003A9E  ; data: 0xad, 0x48
00003AA0  move.w (a7), d2
00003AA2  move.b (a2)+, (a6)+
00003AA4  muls.w #$d0ac, d5
00003AA8  moveq  #$be, d4
00003AAA  dc.w   $f525
00003AAC  add.b  d0, d0
00003AAE  ori.b  #$0, d0
00003AB2  ori.b  #$48, $234f(a1)
00003AB8  move.w -$377b(a7), sr
00003ABC  move.b -$5d2c(a4), d5
00003AC0  and.b  d0, (a4)+
00003AC2  cmpa.w ([$f389ac00]), a0
00003ACA  ori.b  #$0, d0
00003ACE  ori.b  #$34, (a6)
00003AD2  move.w -(a5), -(a0)
00003AD4  ; data: 0x79, 0x06
00003AD6  addq.w #$6, a6
00003AD8  ; data: 0xa4, 0x1c
00003ADA  dc.w   $f156
00003ADC  and.l  d0, $48be(a2)
00003AE0  ror.w  d1, d7
00003AE2  muls.w -$800(a7), d2
00003AE6  ori.b  #$0, d0
00003AEA  ori.b  #$80, d3
00003AEE  ; data: 0x1b, 0xde
00003AF0  ; data: 0x79, 0x9f
00003AF2  or.l   d5, -(a4)
00003AF4  add.l  -$12b5(a4), d1
00003AF8  divs.w -$20b1(a7), d0
00003AFC  ; data: 0xcc, 0x8f
00003AFE  ; data: 0xee, 0xef
00003B00  add.b  d0, d0
00003B02  ori.b  #$0, d0
00003B06  ori.b  #$31, d0
00003B0A  bset.b d3, -$2cf6(a0)
00003B0E  muls.w (a6), d0
00003B10  move.l (a1)+, (a4)+
00003B12  ror.l  d5, d1
00003B14  ; data: 0xa1, 0xec
00003B16  move.w (a5), (a5)
00003B18  ; data: 0xab, 0xcf
00003B1A  ; data: 0xe2, 0xff
00003B1C  ; data: 0xa0, 0x00
00003B1E  ori.b  #$0, d0
00003B22  ori.b  #$f6, d1
00003B26  sgt.b  $260b4048.l
00003B2C  dc.w   $f87c
00003B2E  ; data: 0xa8, 0x39
00003B30  addq.b #$2, d4
00003B32  ; data: 0x3d, 0x7f
00003B34  ; data: 0xf3, 0xff
00003B36  ror.l  #$7, d7
00003B38  negx.b d0
00003B3A  ori.b  #$0, d0
00003B3E  ori.b  #$57, d0
00003B42  cmpa.l -(a6), a2
00003B44  addx.l -(a2), -(a0)
00003B46  asr.b  #$3, d3
00003B48  suba.w $796f.w, a7
00003B4C  roxr.w d2, d6
00003B4E  ; data: 0x2a, 0xbd
00003B50  cmpa.l (a7)+, a3
00003B52  ; data: 0x4d, 0x3f
00003B54  or.b   d0, d0
00003B56  ori.b  #$0, d0
00003B5A  ori.b  #$7b, d0
00003B5E  mulu.w $3b53(pc, a4.w), d7
00003B62  dc.w   $4f02
00003B64  move.l ([$9bc770e8], d0.w * 8, $6ffae13e), $0(a1)
00003B72  ori.b  #$0, d0
00003B76  ori.b  #$72, d0
00003B7A  and.l  d2, $8ca668b8.l
00003B80  ; data: 0x1f, 0xef
00003B82  move.w (a1), (a5)
00003B84  ; data: 0xa9, 0xeb
00003B86  dc.w   $4b2a
00003B88  suba.w #$5798, a2
00003B8C  ori.b  #$0, d0
00003B90  ori.b  #$0, d0
00003B94  move.b (a0)+, (a4)+
00003B96  dc.w   $f0b7
00003B98  cmpa.w -(a4), a4
00003B9A  ; data: 0x99, 0x7e
00003B9C  bset.b d5, d1
00003B9E  move.w (a6)+, $26ad457b(invalid.w)
00003BA6  ; data: 0xef, 0xfc
00003BA8  ori.b  #$0, d0
00003BAC  ori.b  #$0, d0
00003BB0  cmpi.w #$bd36, ([$5aba, a4])
00003BB8  moveq  #$ab, d3
00003BBA  ; data: 0x86, 0xcd
00003BBC  and.w  d2, (a4)
00003BBE  nbcd.b (a3)+
00003BC0  ; data: 0xb6, 0x7f
00003BC2  moveq  #$f0, d6
00003BC4  ori.b  #$0, d0
00003BC8  ori.b  #$0, d0
00003BCC  bclr.b d6, d4
00003BCE  addq.b #$2, (a2)+
00003BD0  ; data: 0xf1, 0x49
00003BD2  or.l   -$2021(a6), d2
00003BD6  asl.w  #$8, d3
00003BD8  moveq  #$a0, d0
00003BDA  move.w -$21(a0, a4.l), d0
00003BDE  ; data: 0xff, 0xd0
00003BE0  ori.b  #$0, d0
00003BE4  ori.b  #$0, d0
00003BE8  ; data: 0x02, 0xe6
00003BEA  ; data: 0x14, 0xfd
00003BEC  addq.l #$8, (a5)+
00003BEE  asl.b  #$8, d2
00003BF0  move.w (a3)+, -$5d(a7, a2.l)
00003BF4  move.b d0, (a7)
00003BF6  lsl.b  d6, d1
00003BF8  ; data: 0x87, 0xfd
00003BFA  ; data: 0xee, 0xe0
00003BFC  ori.b  #$0, d0
00003C00  ori.b  #$0, d0
00003C04  andi.w #$b6c0, -(a0)
00003C08  ; data: 0x7f, 0x1f
00003C0A  ; data: 0xa8, 0x23
00003C0C  move.b -$3af2(a3), $6105(a0)
00003C12  move.b d3, (a6)+
00003C14  mulu.w (a4), d0
00003C16  adda.l d0, a3
00003C18  ori.b  #$0, d0
00003C1C  ori.b  #$0, d0
00003C20  bclr.b d0, -(a5)
00003C22  move.w -(a0), ([$12d30a65])
00003C2A  and.b  -(a4), d3
00003C2C  or.b   d1, -$83c(a3)
00003C30  ; data: 0xf5, 0x7d
00003C32  subq.l #$7, d0
00003C34  ori.b  #$0, d0
00003C38  ori.b  #$0, d0
00003C3C  ori.b  #$73, (a0)
00003C40  move.w (a2)+, $ff95b0b.l
00003C46  and.w  $d5ff(a5, d1.w * 4), d0
00003C4C  bvs.b  $3c4a
00003C4E  cmp.b  d0, d7
00003C50  ori.b  #$0, d0
00003C54  ori.b  #$0, d0
00003C58  ; data: 0x00, 0x08
00003C5A  move.l a7, $7b(a3, a3.l)
00003C5E  bchg.b d6, (a4)
00003C60  move.b d1, -(a6)
00003C62  lsr.l  d0, d2
00003C64  roxr.l #$3, d0
00003C66  bvc.b  $3c12
00003C68  moveq  #$ff, d0
00003C6A  dc.w   $fc00
00003C6C  ori.b  #$0, d0
00003C70  ori.b  #$0, d0
00003C74  ori.b  #$5f, (a5)
00003C78  dc.w   $f8ff
00003C7A  add.l  a2, d1
00003C7C  or.b   d0, d4
00003C7E  ; data: 0x47, 0x66
00003C80  moveq  #$20, d0
00003C82  negx.b (a3)+
00003C84  bchg.b d1, (a7, a7.l)
00003C88  ori.b  #$0, d0
00003C8C  ori.b  #$0, d0
00003C90  ; data: 0x00, 0x0b
00003C92  ; data: 0xc6, 0x8a
00003C94  and.w  (a4), d2
00003C96  ; data: 0xa5, 0xbb
00003C98  or.l   d0, d7
00003C9A  svc.b  $20(a2, d3.l)
00003C9E  add.l  $57(a1, d0.l), d1
00003CA2  dc.w   $f000
00003CA4  ori.b  #$0, d0
00003CA8  ori.b  #$0, d0
00003CAC  ori.b  #$70, d1
00003CB0  cmp.b  d2, d7
00003CB2  moveq  #$56, d6
00003CB4  move.l d0, (a7)+
00003CB6  addi.b #$f9, -(a6)
00003CBA  muls.w $f(a4, a0.w), d6
00003CBE  and.b  d0, d0
00003CC0  ori.b  #$0, d0
00003CC4  ori.b  #$0, d0
00003CC8  ori.b  #$c8, d0
00003CCC  ori.w  #$b86a, $12f1(a7)
00003CD2  abcd.b -(a7), -(a1)
00003CD4  move.b $3ff9(a6), -(a5)
00003CD8  sub.w  d6, (a7)
00003CDA  or.b   d0, d0
00003CDC  ori.b  #$0, d0
00003CE0  ori.b  #$0, d0
00003CE4  ori.b  #$3, d0
00003CE8  move.b -$48b1(a4), (a2)
00003CEC  move.b (a7), $f(a3, d0.w)
00003CF0  dc.w   $f4c0
00003CF2  dc.w   $feb7
00003CF4  ror.l  d1, d7
00003CF6  ori.b  #$0, d0
00003CFA  ori.b  #$0, d0
00003CFE  ori.b  #$0, d0
00003D02  move.w -(a0), (a5)
00003D04  move.l $2bb9(pc), $4ce3(a7)
00003D0A  ; data: 0x08, 0x4a
00003D0C  ; data: 0x4b, 0x5d
00003D0E  dc.w   $fd5b
00003D10  eor.w  d3, (a4)
00003D12  ori.b  #$0, d0
00003D16  ori.b  #$0, d0
00003D1A  ori.b  #$0, d0
00003D1E  btst.l d6, (a7)
00003D20  move.b (a5)+, d1
00003D22  add.l  d2, (a7)
00003D24  or.b   d3, $74(a1, d2.w)
00003D28  cmpa.l $3d26(pc, d7.l), a3
00003D2C  bset.b d7, (a0, d0.w)
00003D30  ori.b  #$0, d0
00003D34  ori.b  #$0, d0
00003D38  ori.b  #$e3, d0
00003D3C  exg.l  a4, a7
00003D3E  lsl.w  #$6, d1
00003D40  ; data: 0xa9, 0xda
00003D42  ; data: 0xa5, 0x89
00003D44  ; data: 0x5a, 0xff
00003D46  cmp.b  (a7)+, d1
00003D48  seq.b  -(a0)
00003D4A  ori.b  #$0, d0
00003D4E  ori.b  #$0, d0
00003D52  ori.b  #$0, d0
00003D56  bchg.b d0, ([], $145c5622)
00003D5E  cmpi.w #$c3cf, -$45(a2, a7.l)
00003D64  move.l d0, (a7, d0.w)
00003D68  ori.b  #$0, d0
00003D6C  ori.b  #$0, d0
00003D70  ori.b  #$be, d0
00003D74  add.l  d1, (a1)
00003D76  adda.w -$10eb(a0), a3
00003D7A  bhi.b  $3d0a
00003D7C  move.w (a5), $d97f.w
00003D80  ; data: 0xff, 0x00
00003D82  ori.b  #$0, d0
00003D86  ori.b  #$0, d0
00003D8A  ori.b  #$0, d0
00003D8E  ori.b  #$7, -$5483(a6)
00003D94  moveq  #$40, d7
00003D96  ; data: 0xd0, 0x3e
00003D98  cmpa.l -$7(a2), a1
00003D9C  dc.w   $fc00
00003D9E  ori.b  #$0, d0
00003DA2  ori.b  #$0, d0
00003DA6  ori.b  #$0, d0
00003DAA  ; data: 0x00, 0x0a
00003DAC  ; data: 0x11, 0x4b
00003DAE  dc.w   $f20d
00003DB0  ; data: 0x4c, 0x0a
00003DB2  bhi.b  $3e0f
00003DB4  adda.l (a2)+, a3
00003DB6  ; data: 0xff, 0xe3
00003DB8  dc.w   $f000
00003DBA  ori.b  #$0, d0
00003DBE  ori.b  #$0, d0
00003DC2  ori.b  #$0, d0
00003DC6  ori.b  #$38, d3
00003DCA  moveq  #$7, d0
00003DCC  add.b  -(a6), d2
00003DCE  move.w a7, -$6091(a2)
00003DD2  ; data: 0x1c, 0xcf
00003DD4  and.b  d0, d0
00003DD6  ori.b  #$0, d0
00003DDA  ori.b  #$0, d0
00003DDE  ori.b  #$0, d0
00003DE2  ori.b  #$a4, d0
00003DE6  ; data: 0xa3, 0x83
00003DE8  dc.w   $f0be
00003DEA  rol.l  #$1, d5
00003DEC  ; data: 0x77, 0xf3
00003DEE  ; data: 0xf7, 0xff
00003DF0  ori.b  #$0, d0
00003DF4  ori.b  #$0, d0
00003DF8  ori.b  #$0, d0
00003DFC  ori.b  #$0, d0
00003E00  movea.l (a2), a6
00003E02  lsl.l  d3, d1
00003E04  move.b $e009244e.l, (a4)
00003E0A  ; data: 0xe6, 0xfc
00003E0C  ori.b  #$0, d0
00003E10  ori.b  #$0, d0
00003E14  ori.b  #$0, d0
00003E18  ori.b  #$0, d0
00003E1C  subi.b #$d9, $c79c(a5, invalid.w)
00003E24  cmpa.l (invalid.w), a5
00003E2A  ori.b  #$0, d0
00003E2E  ori.b  #$0, d0
00003E32  ori.b  #$0, d0
00003E36  ori.b  #$1, d0
00003E3A  ; data: 0xa0, 0x4e
00003E3C  ; data: 0xd2, 0xfd
00003E3E  ; data: 0xff, 0xfe
00003E40  bset.b d7, -(a7)
00003E42  ; data: 0xff, 0x80
00003E44  ori.b  #$0, d0
00003E48  ori.b  #$0, d0
00003E4C  ori.b  #$0, d0
00003E50  ori.b  #$0, d0
00003E54  ori.b  #$14, -(a0)
00003E58  asr.l  d2, d7
00003E5A  eor.w  d7, $dfdf5400.l
00003E60  ori.b  #$0, d0
00003E64  ori.b  #$0, d0
00003E68  ori.b  #$0, d0
00003E6C  ori.b  #$0, d0
00003E70  ori.b  #$1, d6
00003E74  lsl.w  $66d6.w
00003E78  ; data: 0x7b, 0xed
00003E7A  asr.b  #$8, d0
00003E7C  ori.b  #$0, d0
00003E80  ori.b  #$0, d0
00003E84  ori.b  #$0, d0
00003E88  ori.b  #$0, d0
00003E8C  ori.b  #$87, d0
00003E90  dc.w   $f8ff
00003E92  ; data: 0x81, 0xfd
00003E94  dc.w   $ff55
00003E96  ori.b  #$0, d0
00003E9A  ori.b  #$0, d0
00003E9E  ori.b  #$0, d0
00003EA2  ori.b  #$0, d0
00003EA6  ori.b  #$0, d0
00003EAA  cmpi.l #$cb1fe37f, (a1)
00003EB0  ; data: 0xfb, 0xf0
00003EB2  ori.b  #$0, d0
00003EB6  ori.b  #$0, d0
00003EBA  ori.b  #$0, d0
00003EBE  ori.b  #$0, d0
00003EC2  ori.b  #$0, d0
00003EC6  ; data: 0x00, 0xdf
00003EC8  ; data: 0xff, 0xaa
00003ECA  ; data: 0xfd, 0x7f
00003ECC  ; data: 0xff, 0x00
00003ECE  ori.b  #$0, d0
00003ED2  ori.b  #$0, d0
00003ED6  ori.b  #$0, d0
00003EDA  ori.b  #$0, d0
00003EDE  ori.b  #$0, d0
00003EE2  ori.b  #$5f, d7
00003EE6  ; data: 0x3a, 0xff
00003EE8  ori.b  #$0, d0
00003EEC  ori.b  #$0, d0
00003EF0  ori.b  #$0, d0
00003EF4  ori.b  #$0, d0
00003EF8  ori.b  #$0, d0
00003EFC  ori.b  #$0, d0
00003F00  bclr.b d3, -$5880(a6)
00003F04  ori.b  #$0, d0
00003F08  ori.b  #$0, d0
00003F0C  ori.b  #$0, d0
00003F10  ori.b  #$0, d0
00003F14  ori.b  #$0, d0
00003F18  ori.b  #$0, d0
00003F1C  bclr.b d3, d0
00003F1E  bset.b d0, -(a0)
00003F20  ori.b  #$0, d0
00003F24  ori.b  #$0, d0
00003F28  ori.b  #$0, d0
00003F2C  ori.b  #$0, d0
00003F30  ori.b  #$0, d0
00003F34  ori.b  #$6, d0
00003F38  ; data: 0x7f, 0xfc
00003F3A  bra.b  $3f4c
00003F3C  asr.b  #$8, d0
00003F3E  ori.b  #$0, d0
00003F42  ori.b  #$0, d0
00003F46  ori.b  #$0, d0
00003F4A  ori.b  #$0, d0
00003F4E  ori.b  #$0, d0
00003F52  ; data: 0x00, 0xcf
00003F54  ; data: 0xff, 0xf4
00003F56  move.w $ffffc658(pc), (a7, d0.w)
00003F5C  ori.b  #$0, d0
00003F60  ori.b  #$0, d0
00003F64  ori.b  #$0, d0
00003F68  ori.b  #$0, d0
00003F6C  ori.b  #$ff, d0
00003F70  ; data: 0xff, 0xfe
00003F72  ; data: 0xff, 0xf7
00003F74  btst.b #$0, (a0, d0.w)
00003F7A  ori.b  #$0, d0
00003F7E  ori.b  #$0, d0
00003F82  ori.b  #$0, d0
00003F86  ori.b  #$0, d0
00003F8A  ; data: 0xcf, 0xff
00003F8C  ; data: 0xff, 0xff
00003F8E  ; data: 0xff, 0xfe
00003F90  or.b   d7, d0
00003F92  ori.b  #$0, d0
00003F96  ori.b  #$0, d0
00003F9A  ori.b  #$0, d0
00003F9E  ori.b  #$0, d0
00003FA2  ori.b  #$4, d0
00003FA6  ; data: 0xff, 0xff
00003FA8  ; data: 0xff, 0x81
00003FAA  ; data: 0xff, 0xe7
00003FAC  ori.w  #$6000, d0
00003FB0  ori.b  #$0, d0
00003FB4  ori.b  #$0, d0
00003FB8  ori.b  #$0, d0
00003FBC  ori.b  #$0, d0
00003FC0  ori.b  #$f9, -(a7)
00003FC4  ; data: 0xfb, 0x81
00003FC6  ; data: 0xff, 0x82
00003FC8  dc.w   $f800
00003FCA  cmpi.b #$0, d0
00003FCE  ori.b  #$0, d0
00003FD2  ori.b  #$0, d0
00003FD6  ori.b  #$0, d0
00003FDA  ori.b  #$7f, d0
00003FDE  ; data: 0xf9, 0xff
00003FE0  add.b  d5, d3
00003FE2  ; data: 0xff, 0x1f
00003FE4  move.b d0, d6
00003FE6  bclr.b d0, d0
00003FE8  ori.b  #$0, d0
00003FEC  ori.b  #$0, d0
00003FF0  ori.b  #$0, d0
00003FF4  ori.b  #$0, d0
00003FF8  bclr.b d2, -$4001(a2)
00003FFC  ; data: 0xa0, 0x0b
00003FFE  ; data: 0xff, 0xfb
00004000  ; data: 0xac, 0x00
00004002  ori.b  #$0, -(a0)
00004006  ori.b  #$0, d0
0000400A  ori.b  #$0, d0
0000400E  ori.b  #$0, d0
00004012  ori.b  #$d1, d0
00004016  ; data: 0x1f, 0xff
00004018  and.b  d0, (a7)
0000401A  ; data: 0xff, 0xff
0000401C  dc.w   $fe00
0000401E  ori.b  #$0, ccr
00004022  ori.b  #$0, d0
00004026  ori.b  #$0, d0
0000402A  ori.b  #$0, d0
0000402E  ori.b  #$aa, d0
00004032  ; data: 0xaf, 0x7e
00004034  dc.w   $f0af
00004036  ; data: 0xfd, 0xff
00004038  ; data: 0xfd, 0xba
0000403A  ; data: 0xa0, 0x1f
0000403C  ori.b  #$0, d0
00004040  ori.b  #$0, d0
00004044  ori.b  #$0, d0
00004048  ori.b  #$2, d0
0000404C  dc.w   $f43f
0000404E  move.w (a5)+, -(a7)
00004050  bra.b  $4061
00004052  ; data: 0xda, 0xff
00004054  dc.w   $f8fc
00004056  ; data: 0x08, 0x0f
00004058  and.b  d0, d0
0000405A  ori.b  #$0, d0
0000405E  ori.b  #$0, d0
00004062  ori.b  #$0, d0
00004066  ; data: 0x00, 0x0f
00004068  ror.l  d5, d6
0000406A  ; data: 0x7f, 0x8a
0000406C  or.b   d7, d0
0000406E  ; data: 0xa5, 0x55
00004070  ; data: 0xfc, 0x7f
00004072  addi.b #$0, d0
00004076  ori.b  #$0, d0
0000407A  ori.b  #$0, d0
0000407E  ori.b  #$0, d0
00004082  ; data: 0x00, 0x3f
00004084  asr.b  #$8, d0
00004086  ; data: 0xff, 0xae
00004088  ori.b  #$8e, (a0)+
0000408C  ; data: 0xff, 0xff
0000408E  or.b   d3, (a0)+
00004090  sub.b  d0, d6
00004092  ori.b  #$0, d0
00004096  ori.b  #$0, d0
0000409A  ori.b  #$0, d0
0000409E  ori.l  #$f00afffe, $7c0455.l
000040A8  ; data: 0x5f, 0xff
000040AA  cmp.l  a4, d7
000040AC  move.w d0, -(a7)
000040AE  ori.b  #$0, d0
000040B2  ori.b  #$0, d0
000040B6  ori.b  #$0, d0
000040BA  ori.w  #$f815, (invalid.w)
000040C0  bclr.b d1, $2.w
000040C4  ; data: 0xbf, 0xff
000040C6  ; data: 0xa9, 0xc4
000040C8  ble.b  $404a
000040CA  ori.b  #$0, d0
000040CE  ori.b  #$0, d0
000040D2  ori.b  #$0, d0
000040D6  bset.b d2, -$57d6(a7)
000040DA  ; data: 0xae, 0x08
000040DC  ; data: 0x00, 0x48
000040DE  ori.b  #$fa, (a5)
000040E2  dc.w   $fea0
000040E4  ; data: 0x2f, 0xe0
000040E6  ori.b  #$0, d0
000040EA  ori.b  #$0, d0
000040EE  ori.b  #$0, d0
000040F2  ; data: 0x0f, 0xbf
000040F4  add.b  d0, d0
000040F6  ori.b  #$1, d0
000040FA  ori.b  #$ff, d0
000040FE  move.l -(a0), $7f0(a7)
00004102  ori.b  #$0, d0
00004106  ori.b  #$0, d0
0000410A  ori.b  #$0, d0
0000410E  move.l -$47f8(a3), (a3, d0.w)
00004114  ori.b  #$0, d0
00004118  subq.b #$3, (a7)+
0000411A  eor.l  d7, (invalid.w)
00004122  ori.b  #$0, d0
00004126  ori.b  #$0, d0
0000412A  divs.w (a5, a6.w), d1
0000412E  ; data: 0xa0, 0x04
00004130  ori.b  #$0, d0
00004134  ; data: 0x02, 0xfe
00004136  ; data: 0x1f, 0xf0
00004138  bset.b d0, $0(a7)
0000413C  ori.b  #$0, d0
00004140  ori.b  #$0, d0
00004144  ori.b  #$aa, d1
00004148  move.l $800b0000.l, d0
0000414E  subq.l #$7, d0
00004150  bset.b d0, $cf8000(d0.l * 8)
00004158  ori.b  #$0, d0
0000415C  ori.b  #$0, d0
00004160  ori.b  #$c0, d2
00004164  ; data: 0x00, 0x0a
00004166  add.b  (a7)+, d0
00004168  negx.b d0
0000416A  ; data: 0x7f, 0xf0
0000416C  move.w $ff8.w, $f7(a3)
00004172  and.b  d0, d0
00004174  ori.b  #$0, d0
00004178  ori.b  #$0, d0
0000417C  ; data: 0x00, 0x08
0000417E  bclr.b d2, d0
00004180  ; data: 0xa0, 0x55
00004182  moveq  #$1f, d4
00004184  or.b   d1, d0
00004186  ; data: 0x7b, 0x80
00004188  move.l (a6)+, ([$13ff000])
00004190  ori.b  #$0, d0
00004194  ori.b  #$0, d0
00004198  ori.b  #$1, (a4)+
0000419C  dc.w   $f0ab
0000419E  dc.w   $f81f
000041A0  ori.b  #$40, (a7)+
000041A4  move.b (a0)+, d7
000041A6  ; data: 0x07, 0xff
000041A8  ; data: 0x01, 0xbd
000041AA  dc.w   $fc00
000041AC  ori.b  #$0, d0
000041B0  ori.b  #$0, d0
000041B4  ori.b  #$0, (a0)+
000041B8  or.w   d4, (a5)
000041BA  ; data: 0x59, 0xfe
000041BC  movea.l a7, a0
000041BE  dc.w   $fa80
000041C0  move.b (a2)+, d7
000041C2  ; data: 0x06, 0xff
000041C4  ; data: 0x41, 0xdc
000041C6  dc.w   $fe00
000041C8  ori.b  #$0, d0
000041CC  ori.b  #$0, d0
000041D0  ori.b  #$0, -$1(a1, d0.w)
000041D6  cmpa.w -(a6), a4
000041D8  ori.b  #$0, (a7)+
000041DC  btst.l d7, (a0)+
000041DE  ; data: 0x07, 0xff
000041E0  move.l -$100(a4), (a0)+
000041E4  ori.b  #$0, d0
000041E8  ori.b  #$0, d0
000041EC  bclr.b d0, (a0)
000041EE  bra.b  $4210
000041F0  ; data: 0x07, 0x7f
000041F2  ; data: 0xa0, 0xe6
000041F4  move.w d7, -$56(a7, d5.l)
000041F8  btst.l d3, -(a1)
000041FA  ; data: 0xe7, 0xff
000041FC  ; data: 0x08, 0x2f
000041FE  ; data: 0xff, 0x80
00004200  ori.b  #$0, d0
00004204  ori.b  #$0, d0
00004208  movep.l d1, -$3f20(a1)
0000420C  ; data: 0x0d, 0xff
0000420E  mulu.w ([a6], d7.l * 4, $fd550381), d2
00004216  roxl.w #$3, d3
00004218  cmpi.w #$bfc0, (a6, d0.w)
0000421E  ori.b  #$0, d0
00004222  ori.b  #$e7, d0
00004226  and.l  d0, -(a0)
00004228  ; data: 0x17, 0xff
0000422A  ; data: 0xc0, 0xfe
0000422C  ; data: 0x39, 0xff
0000422E  ; data: 0xda, 0xbe
00004230  ; data: 0xf1, 0xc4
00004232  and.w  -$3400(a1), d2
00004236  ; data: 0x7f, 0xe0
00004238  ori.b  #$0, d0
0000423C  ori.b  #$0, d0
00004240  bset.b d7, (a7)+
00004242  or.l   d0, d2
00004244  ; data: 0xbf, 0xff
00004246  dc.w   $fcf8
00004248  ; data: 0x11, 0xff
0000424A  ; data: 0xfd, 0xfd
0000424C  dc.w   $f8f1
0000424E  cmpi.b #$0, d1
00004252  cmpa.l (a0, d0.w), a7
00004256  ori.b  #$0, d0
0000425A  ori.b  #$af, d0
0000425E  ; data: 0xcb, 0x80
00004260  ; data: 0x7f, 0x7d
00004262  moveq  #$50, d4
00004264  ; data: 0x01, 0xff
00004266  dc.w   $fcbe
00004268  ; data: 0xb0, 0x7f
0000426A  move.b d1, -(a6)
0000426C  or.b   (a2), d4
0000426E  cmpa.l $0.w, a7
00004272  ori.b  #$0, d0
00004276  ori.b  #$6, d0
0000427A  adda.w d0, a2
0000427C  ; data: 0xff, 0x3f
0000427E  dc.w   $f831
00004280  ; data: 0x07, 0xff
00004282  dc.w   $fcfc
00004284  move.w a1, d0
00004286  dc.w   $fe01
00004288  and.b  d0, d6
0000428A  ; data: 0x3f, 0xfc
0000428C  ori.b  #$0, d0
00004290  ori.b  #$0, d0
00004294  ; data: 0x0a, 0x0b
00004296  asr.b  #$5, d0
00004298  ; data: 0x7f, 0x95
0000429A  dc.w   $fc07
0000429C  ; data: 0x87, 0xff
0000429E  dc.w   $ff6f
000042A0  ror.b  #$8, d0
000042A2  moveq  #$1, d0
000042A4  dc.w   $f80a
000042A6  ; data: 0x3f, 0xfe
000042A8  ori.b  #$0, d0
000042AC  ori.b  #$0, d0
000042B0  ; data: 0x58, 0x08
000042B2  dc.w   $f030
000042B4  ; data: 0x7f, 0x8f
000042B6  dc.w   $fe3f
000042B8  ; data: 0xff, 0xff
000042BA  dc.w   $f8bc
000042BC  or.b   (a0, d2.l), d0
000042C0  dc.w   $f014
000042C2  ; data: 0x19, 0xff
000042C4  ori.b  #$0, d0
000042C8  ori.b  #$0, d0
000042CC  ; data: 0xd8, 0x09
000042CE  bra.b  $434d
000042D0  ; data: 0xff, 0xc7
000042D2  ; data: 0xeb, 0xe7
000042D4  ; data: 0xbb, 0xff
000042D6  ; data: 0xfb, 0xf8
000042D8  ori.b  #$0, (a0)
000042DC  ; data: 0x8a, 0x08
000042DE  ; data: 0x4c, 0xff
000042E0  or.b   d0, d0
000042E2  ori.b  #$0, d0
000042E6  ori.b  #$11, d0
000042EA  mulu.w -(a7), d0
000042EC  ; data: 0xfd, 0xe3
000042EE  dc.w   $ff7b
000042F0  ; data: 0xff, 0xff
000042F2  add.l  d7, -(a0)
000042F4  move.b $20.w, (a0)
000042F8  ; data: 0x8c, 0x08
000042FA  ; data: 0x01, 0xbf
000042FC  and.b  d0, d0
000042FE  ori.b  #$0, d0
00004302  ori.b  #$b, d6
00004306  divs.w -$4f(a2, a7.l), d2
0000430A  ; data: 0xaa, 0xaa
0000430C  ; data: 0xaa, 0xef
0000430E  add.w  (a0)+, d7
00004310  divs.w $4326(pc, a0.w), d6
00004314  ; data: 0xc2, 0x4c
00004316  ori.l  #$e0000000, $0(a7)
0000431E  ; data: 0x00, 0x0f
00004320  ; data: 0x0e, 0x30
00004322  ; data: 0x03, 0xfd
00004324  ; data: 0xff, 0xdf
00004326  move.b (a1), -(a0)
00004328  ; data: 0x5d, 0xff
0000432A  ; data: 0xfd, 0x8c
0000432C  ; data: 0x7d, 0x9e
0000432E  ori.b  #$8e, d0
00004332  ori.b  #$0, (a7)
00004336  ori.b  #$0, d0
0000433A  ori.b  #$e8, (a6)
0000433E  ; data: 0x0a, 0xbf
00004340  lsr.l  d5, d2
00004342  ; data: 0xaa, 0xfa
00004344  ; data: 0xaa, 0xab
00004346  roxl.w d2, d2
00004348  ; data: 0xff, 0xde
0000434A  or.b   -(a5), d0
0000434C  dc.w   $411e
0000434E  movea.l d7, a0
00004350  dc.w   $f800
00004352  ori.b  #$0, d0
00004356  ori.b  #$e0, $41e(a4)
0000435C  ; data: 0xf5, 0x40
0000435E  ; data: 0x00, 0xfc
00004360  bchg.b d2, (a0)
00004362  ; data: 0x0a, 0x4a
00004364  cmp.w  $3(a7), d7
00004368  ; data: 0xa0, 0x3e
0000436A  ; data: 0x40, 0x09
0000436C  dc.w   $fc00
0000436E  ori.b  #$0, d0
00004372  ori.b  #$46, $2e(a0, a0.l)
00004378  bpl.b  $4324
0000437A  ; data: 0x01, 0xff
0000437C  asr.w  d5, d0
0000437E  move.l -(a4), d4
00004380  ; data: 0x79, 0x34
00004382  ori.b  #$5c, d5
00004386  bra.b  $4389
00004388  dc.w   $fc00
0000438A  ori.b  #$0, d0
0000438E  ori.w  #$203, -(a0)
00004392  moveq  #$1d, d0
00004394  move.b -(a0), d0
00004396  bset.b d0, $6b(a6, a7.w)
0000439A  chk.w  -(a4), d5
0000439C  ; data: 0xf7, 0xb8
0000439E  ori.b  #$58, d0
000043A2  cmp.b  d0, d0
000043A4  dc.w   $fe00
000043A6  ori.b  #$0, d0
000043AA  ; data: 0x00, 0x48
000043AC  move.w (a7), $c00e28a1.l
000043B2  bset.b d0, -$53(a3, a3.l)
000043B6  ; data: 0x17, 0xee
000043B8  ; data: 0xef, 0xfc
000043BA  ori.b  #$18, d2
000043BE  moveq  #$5, d0
000043C0  ; data: 0xf7, 0x00
000043C2  ori.b  #$0, d0
000043C6  btst.l d0, d0
000043C8  ; data: 0x10, 0x0f
000043CA  dc.w   $fc00
000043CC  ori.b  #$c1, -(a0)
000043D0  dc.w   $f868
000043D2  ; data: 0xbe, 0xff
000043D4  adda.l #$a00c, a7
000043DA  dc.w   $fc06
000043DC  ; data: 0xff, 0x80
000043DE  ori.b  #$0, d0
000043E2  andi.b #$7f, -(a4)
000043E6  dc.w   $ff38
000043E8  or.w   -(a0), d0
000043EA  ori.l  #$a96845f7, d1
000043F0  ; data: 0xef, 0xfe
000043F2  ori.b  #$f5, d0
000043F6  dc.w   $f802
000043F8  ; data: 0x7f, 0xc0
000043FA  ori.b  #$0, d0
000043FE  andi.b #$ff, d0
00004402  dc.w   $ff10
00004404  ori.l  #$c003d27b, -(a0)
0000440A  bhi.b  $4409
0000440C  ; data: 0x9f, 0xff
0000440E  or.b   d0, d0
00004410  bclr.b d5, -$320(a7)
00004414  bset.b d7, d0
00004416  ori.b  #$0, d0
0000441A  subi.b #$ff, d4
0000441E  dc.w   $f6a8
00004420  bset.b d0, -(a0)
00004422  ori.b  #$3b, $3fff(a2, invalid.w)
0000442A  and.b  d0, d0
0000442C  subq.l #$7, -$5b0(a7)
00004430  sle.b  -(a0)
00004432  ori.b  #$0, d0
00004436  ori.b  #$ff, d2
0000443A  add.w  -$3c(a0, d0.w), d6
0000443E  ori.b  #$f7, d6
00004442  asr.w  -(a4)
00004444  ; data: 0x3f, 0xff
00004446  or.b   d0, d0
00004448  movep.l d3, -$290(a4)
0000444C  ; data: 0x37, 0xf0
0000444E  ori.b  #$0, d0
00004452  move.b (a3), d0
00004454  ; data: 0x17, 0xff
00004456  bmi.b  $4418
00004458  ori.l  #$3c98daa, d6
0000445E  ; data: 0xe2, 0xfb
00004460  ; data: 0xbf, 0xff
00004462  and.b  d0, d0
00004464  btst.l d1, d0
00004466  dc.w   $fc00
00004468  move.w $0.w, $1c07.l
00004470  ; data: 0x87, 0xff
00004472  addx.b d0, d1
00004474  bclr.b d0, (d0.w * 8)
00004478  movep.l -$1f87(a4), d7
0000447C  ; data: 0xbf, 0xff
0000447E  asr.b  #$8, d0
00004480  ; data: 0x00, 0x08
00004482  moveq  #$9, d4
00004484  divs.w #$0, d0
00004488  ori.b  #$4f, d0
0000448C  suba.l $ffffec8e(pc), a3
00004490  ; data: 0x08, 0xb2
00004492  bset.b d7, ([])
00004496  cmp.l  -$1(a0), d4
0000449A  dc.w   $fc00
0000449C  btst.l d2, (a0)
0000449E  dc.w   $f811
000044A0  ; data: 0x87, 0xfe
000044A2  ori.b  #$0, d0
000044A6  move.b (a7)+, d6
000044A8  ; data: 0xcf, 0xfd
000044AA  ; data: 0x40, 0xc8
000044AC  bclr.b d6, d0
000044AE  bchg.b d7, d3
000044B0  or.b   d3, (a0)
000044B2  move.w a4, d6
000044B4  ; data: 0xff, 0xff
000044B6  asl.l  #$3, d0
000044B8  ori.b  #$0, -(a0)
000044BC  ; data: 0xc3, 0xfe
000044BE  ori.b  #$0, d0
000044C2  ; data: 0x12, 0x4f
000044C4  adda.l -$5ce8(a2), a7
000044C8  subx.b d0, d6
000044CA  bchg.b d7, d2
000044CC  suba.l a6, a6
000044CE  ; data: 0x1c, 0x78
000044D0  ; data: 0xd7, 0xff
000044D2  asr.w  #$7, d0
000044D4  btst.l d0, -$3ff0(a0)
000044D8  ; data: 0x13, 0xff
000044DA  ori.b  #$0, d0
000044DE  ; data: 0xa8, 0x27
000044E0  cmpa.l (a0), a7
000044E2  ori.l  #$bf80c742, $71(a7, a5.w)
000044EA  ; data: 0x1c, 0x7c
000044EC  ; data: 0xff, 0xff
000044EE  ; data: 0xff, 0xc0
000044F0  ori.b  #$c, ([$80000000])
000044FA  sub.w  (a3), d4
000044FC  ; data: 0x7f, 0xaa
000044FE  ; data: 0x95, 0xff
00004500  asl.l  #$7, d0
00004502  asl.l  #$1, d2
00004504  bls.b  $44a6
00004506  ; data: 0x0c, 0x7f
00004508  ; data: 0x55, 0xff
0000450A  adda.w d0, a4
0000450C  ori.w  #$8f04, $5fffc000.l
00004514  ori.b  #$b8, d0
00004518  ; data: 0xff, 0xd0
0000451A  ; data: 0x1f, 0xff
0000451C  add.b  d0, d2
0000451E  bra.b  $44fd
00004520  move.l d4, $a41e2fff.l
00004526  and.w  -(a0), d4
00004528  ; data: 0x00, 0x3f
0000452A  exg.l  d1, d0
0000452C  ; data: 0x0f, 0xff
0000452E  and.b  d0, d0
00004530  ori.b  #$5f, d2
00004534  asr.l  d7, d4
00004536  adda.w $410d(a7), a7
0000453A  ori.w  #$11c2, -(a3)
0000453E  or.w   d0, (a5)+
00004540  ; data: 0x55, 0xff
00004542  dc.w   $f978
00004544  ori.b  #$80, (a1)
00004548  ; data: 0xbf, 0xff
0000454A  asr.b  #$8, d0
0000454C  ori.b  #$78, d3
00004550  ; data: 0xff, 0xf1
00004552  dc.w   $f55f
00004554  ; data: 0xa2, 0x20
00004556  ; data: 0x00, 0x3f
00004558  addq.w #$1, d5
0000455A  sub.b  -(a0), d0
0000455C  ; data: 0x0f, 0xff
0000455E  ror.w  d2, d0
00004560  ori.b  #$80, d0
00004564  ; data: 0x7f, 0xff
00004566  asr.b  #$8, d0
00004568  ori.b  #$55, d4
0000456C  dc.w   $faab
0000456E  dc.w   $fa9c
00004570  ror.b  #$6, d2
00004572  ori.b  #$44, d5
00004576  ; data: 0xa0, 0xf8
00004578  ; data: 0x5d, 0xff
0000457A  dc.w   $feff
0000457C  ori.b  #$c0, (a0)
00004580  ; data: 0xff, 0xff
00004582  dc.w   $f000
00004584  ori.b  #$e2, d4
00004588  ; data: 0xff, 0x47
0000458A  add.b  (a5)+, d2
0000458C  dc.w   $f00c
0000458E  ori.b  #$0, d3
00004592  ; data: 0x79, 0x3c
00004594  ; data: 0x2f, 0xfd
00004596  ; data: 0xa9, 0xb0
00004598  or.b   d0, d0
0000459A  ; data: 0xff, 0xf0
0000459C  ; data: 0xff, 0xff
0000459E  dc.w   $f000
000045A0  ori.b  #$45, d0
000045A4  dc.w   $fa86
000045A6  ; data: 0xb6, 0x0b
000045A8  ; data: 0xfd, 0x00
000045AA  ori.b  #$0, d6
000045AE  ; data: 0x7b, 0xe6
000045B0  move.b (a1)+, -$7c57(a6)
000045B4  or.b   d0, d0
000045B6  ; data: 0xff, 0xf0
000045B8  ; data: 0xff, 0xbf
000045BA  dc.w   $f800
000045BC  ; data: 0x00, 0x08
000045BE  ; data: 0x02, 0x7f
000045C0  ; data: 0xfd, 0xcd
000045C2  move.b d5, d2
000045C4  ; data: 0xec, 0xc8
000045C6  ; data: 0x40, 0x0c
000045C8  btst.l d0, d0
000045CA  ; data: 0x7b, 0xa3
000045CC  ; data: 0xb8, 0x0a
000045CE  muls.w -$5fff(a5), d3
000045D2  dc.w   $ff78
000045D4  ; data: 0xff, 0xbf
000045D6  dc.w   $f800
000045D8  ori.b  #$e7, d0
000045DC  dc.w   $fac9
000045DE  ; data: 0x0e, 0x03
000045E0  lsl.w  (a1)
000045E2  move.l d0, d4
000045E4  andi.b #$1b, d1
000045E8  ; data: 0xf7, 0x05
000045EA  muls.w -$6ff9(a1), d7
000045EE  roxr.w $1f9ffc00.l
000045F4  ori.b  #$6b, (a0)
000045F8  ; data: 0xfd, 0x06
000045FA  ; data: 0x00, 0xf7
000045FC  divu.w -$7df1(a4), d1
00004600  ori.b  #$b, d1
00004604  add.l  a6, d0
00004606  ; data: 0x17, 0xf7
00004608  ; data: 0xb8, 0x0c
0000460A  and.w  ([]), d0
0000460E  dc.w   $fc00
00004610  ori.b  #$cb, -$157e(a0)
00004616  bset.b d0, $30(a7, d0.w)
0000461A  sbcd.b d3, d0
0000461C  ori.w  #$2e13, d1
00004620  cmpa.w ([$41080460]), a0
00004628  ; data: 0x1f, 0xc7
0000462A  dc.w   $fe00
0000462C  ori.b  #$1e, $fd04.w
00004632  bset.b d0, $30(a5, a2.l)
00004636  btst.l d0, d0
00004638  btst.l d0, d1
0000463A  move.l d7, -$f08(a0)
0000463E  ; data: 0x75, 0xff
00004640  ori.w  #$30c0, $fe3(a0)
00004646  dc.w   $fe00
00004648  ori.w  #$1653, (a0)
0000464C  asr.l  #$5, d0
0000464E  bchg.b d0, d7
00004650  ; data: 0x9a, 0x0c
00004652  ori.w  #$8001, d0
00004656  andi.w #$e0ec, -(a7)
0000465A  moveq  #$be, d3
0000465C  ; data: 0x00, 0x3e
0000465E  asr.w  -(a0)
00004660  ; data: 0x2f, 0x7f
00004662  dc.w   $fe00
00004664  ori.b  #$2e, (a0, a7.w * 4)
0000466A  btst.l d0, d6
0000466C  ; data: 0x00, 0x0e
0000466E  ori.b  #$1, -(a0)
00004672  move.b (a3)+, -(a5)
00004674  cmpa.l -(a6), a0
00004676  move.w (a0)+, (a2)
00004678  ori.b  #$0, (a4)+
0000467C  dc.w   $4d1f
0000467E  ; data: 0xff, 0x00
00004680  ori.b  #$7f, d0
00004684  asr.b  #$5, d0
00004686  ; data: 0x00, 0xfc
00004688  ; data: 0x02, 0xdf
0000468A  ori.w  #$0, d0
0000468E  ; data: 0x1f, 0x0f
00004690  divs.w d3, d0
00004692  or.w   $41c(a4), d1
00004696  move.l -(a0), d0
00004698  ; data: 0x89, 0xcf
0000469A  ; data: 0xff, 0x00
0000469C  ; data: 0x00, 0xe0
0000469E  ; data: 0x0e, 0x7b
000046A0  add.b  d0, d0
000046A2  ori.b  #$39, (a6)+
000046A6  ; data: 0x00, 0xc0
000046A8  ori.b  #$bf, d1
000046AC  divs.w d2, d3
000046AE  move.l -(a0), $f(a3, d1.l)
000046B2  and.b  d4, (a0)
000046B4  move.b -$80(a7), -$40(a4, d0.w)
000046BA  subq.b #$2, (a2, a2.l)
000046BE  ori.b  #$1e, $8(a2)
000046C4  movea.l d0, a0
000046C6  ; data: 0x19, 0xf7
000046C8  mulu.w (invalid.w), d1
000046CC  ; data: 0x0e, 0x19
000046CE  ; data: 0x82, 0x4a
000046D0  move.b (a7)+, (a7.l * 8)
000046D4  btst.l d0, d0
000046D6  cmpi.w #$f000, -(a1)
000046DA  ori.w  #$210d, (a6)
000046DE  ; data: 0x00, 0xc0
000046E0  ori.b  #$cf, -(a1)
000046E4  muls.w ([], a6.l * 8, $170d), d6
000046EA  sub.w  (a0), d3
000046EC  ; data: 0xbf, 0xbe
000046EE  ; data: 0xff, 0x80
000046F0  bclr.b d0, d0
000046F2  scc.b  -(a6)
000046F4  ; data: 0xaa, 0x00
000046F6  ; data: 0x00, 0x0a
000046F8  neg.b  (a3)
000046FA  ; data: 0x08, 0x00
000046FC  movea.l $e3fde1e9.l, a0
00004702  ; data: 0xff, 0xb0
00004704  or.l   d2, d0
00004706  ; data: 0xa7, 0x18
00004708  ; data: 0x7f, 0xbf
0000470A  ; data: 0x7f, 0xc0
0000470C  ori.b  #$d4, d0
00004710  add.b  d0, d0
00004712  ori.w  #$1c31, $7cf0(a3)
00004718  mulu.w $e3fcf8cf.l, d0
0000471E  eor.l  d3, -(a0)
00004720  move.w d0, $bf90.w
00004724  ; data: 0x3f, 0xfe
00004726  ; data: 0x3f, 0xc0
00004728  btst.l d1, d0
0000472A  addq.w #$8, -$5800(a3)
0000472E  subi.b #$c0, (a5)+
00004732  addx.w d1, d7
00004734  divs.w (a5)+, d0
00004736  rol.l  #$8, d0
00004738  move.b $20c0(invalid.w), ([$7d3f3fc0])
00004746  bchg.b d5, -(a3)
00004748  and.b  d0, d0
0000474A  subi.b #$bd, $1e03(a4)
00004750  bset.b d0, -$1e80(a5)
00004754  bchg.b d7, $3040(invalid.w)
0000475A  ; data: 0x0f, 0xfc
0000475C  ; data: 0x3a, 0x3f
0000475E  cmpa.l -(a0), a7
00004760  ori.b  #$36, d0
00004764  ; data: 0xa8, 0x00
00004766  ; data: 0x08, 0x3f
00004768  roxl.l d1, d5
0000476A  or.b   d3, d0
0000476C  btst.l d0, d5
0000476E  asr.b  #$8, d1
00004770  divs.w $838d.w, d2
00004774  subi.b #$f8, -(a0)
00004778  ; data: 0x00, 0x3f
0000477A  ; data: 0xff, 0xe0
0000477C  addi.b #$75, d0
00004780  add.b  d0, d0
00004782  ; data: 0x00, 0x3d
00004784  ; data: 0xff, 0x9c
00004786  or.b   d4, d0
00004788  andi.b #$0, d5
0000478C  ror.w  $30e(a1)
00004790  btst.l d2, d0
00004792  bset.b d7, ([$ffe00600], d1.w, $54b82800)
0000479E  ori.b  #$0, d1
000047A2  ; data: 0x80, 0x0c
000047A4  ori.b  #$d, d7
000047A8  sub.l  -$3b3f(a6), d1
000047AC  sbcd.b d0, d1
000047AE  scs.b  $bdf(a0)
000047B2  ; data: 0xff, 0xf0
000047B4  ori.w  #$39fd, d0
000047B8  negx.b d0
000047BA  ori.b  #$0, d0
000047BE  move.l (a0), d0
000047C0  ori.b  #$92, d7
000047C4  ; data: 0x43, 0xff
000047C6  divu.w -(a3), d0
000047C8  btst.l d1, d0
000047CA  bset.b d5, ([$fff0])
000047D0  ; data: 0x08, 0x80
000047D2  dc.w   $56fc
000047D4  move.l d0, d4
000047D6  ori.b  #$0, (a4)+
000047DA  ; data: 0x40, 0x0c
000047DC  ori.b  #$80, d3
000047E0  ; data: 0x26, 0xbe
000047E2  or.w   -(a2), d4
000047E4  move.b d0, d4
000047E6  move.b -(a0), $43ff(a2)
000047EA  ; data: 0xff, 0xf0
000047EC  eori.w #$2fff, d0
000047F0  negx.b d0
000047F2  ; data: 0x00, 0x0e
000047F4  ori.b  #$8, d0
000047F8  ori.b  #$b8, d7
000047FC  ; data: 0x03, 0xbc
000047FE  ori.b  #$0, -(a0)
00004802  tas.b  -(a0)
00004804  bset.b d3, -$1010(a3)
00004808  andi.b #$fa, -(a0)
0000480C  ; data: 0xa8, 0x00
0000480E  ori.b  #$0, ccr
00004812  ; data: 0x00, 0x48
00004814  ; data: 0x00, 0x0f
00004816  dc.w   $f00f
00004818  mulu.w d5, d3
0000481A  eori.b #$81, (a2)
0000481E  ; data: 0xf5, 0xf0
00004820  bset.b d1, (a7)+
00004822  ; data: 0xff, 0xf8
00004824  andi.w #$3fff, (a0, d4.w)
0000482A  ori.w  #$1, sr
0000482E  ori.w  #$8, $17(a0, a7.l)
00004834  sbcd.b d7, d7
00004836  sbcd.b d0, d1
00004838  divs.w (a0)+, d2
0000483A  dc.w   $53fc
0000483C  ; data: 0x00, 0x0f
0000483E  ; data: 0xff, 0xf8
00004840  move.b d1, (a1)
00004842  ; data: 0x5f, 0xfe
00004844  ; data: 0xa0, 0x00
00004846  dc.w   $f8
00004848  ori.b  #$10, d0
0000484C  ; data: 0x00, 0x3e
0000484E  move.w -(a7), (a7)+
00004850  or.b   d2, -(a3)
00004852  or.w   d1, d2
00004854  ; data: 0x08, 0xe8
00004856  ; data: 0xcd, 0x7a
00004858  or.b   (a7)+, d0
0000485A  cmpa.l $1a60.w, a7
0000485E  ; data: 0x3f, 0xff
00004860  or.b   d0, d0
00004862  ori.w  #$100, $c(a0, d0.w)
00004868  ori.b  #$e0, d7
0000486C  bclr.b d4, (invalid.w)
00004870  move.l $6ffd(a0), (a0)+
00004874  move.b (a7)+, d2
00004876  suba.l $c21.w, a7
0000487A  dc.w   $5ffa
0000487C  ; data: 0xa8, 0x00
0000487E  ; data: 0x00, 0xf8
00004880  ori.b  #$6, d2
00004884  ori.l  #$ffe41836, (a7)
0000488A  ; data: 0xf1, 0xa1
0000488C  ori.w  #$fffe, -(a1)
00004890  nbcd.b (a7)+
00004892  cmpa.l #$1400bf7f, a7
00004898  negx.b d0
0000489A  bchg.b d0, $21(a0, d0.w)
0000489E  or.b   d2, d0
000048A0  ; data: 0x00, 0x0f
000048A2  addx.l d0, d7
000048A4  ; data: 0x08, 0x29
000048A6  move.b (a1), (a4)
000048A8  or.w   $d50ffffc(invalid.w), d0
000048B0  move.w d1, d5
000048B2  ; data: 0x16, 0xfe
000048B4  ; data: 0xa0, 0x00
000048B6  move.w d4, $37c001.l
000048BC  ; data: 0x01, 0xff
000048BE  dc.w   $4704
000048C0  movea.l $19a4(a4), a0
000048C4  or.b   (a2), d4
000048C6  ; data: 0x83, 0xff
000048C8  ror.b  #$4, d7
000048CA  ; data: 0xff, 0xf4
000048CC  move.w d1, d0
000048CE  ; data: 0x20, 0xbf
000048D0  or.b   d0, d0
000048D2  move.l d2, $2e(a3, d0.w)
000048D6  or.b   d0, d0
000048D8  divs.w -$7e00(a7), d0
000048DC  move.b $8c8.w, $3875(a0)
000048E2  ; data: 0xc1, 0xfe
000048E4  ; data: 0xf3, 0x0e
000048E6  ; data: 0xff, 0xfc
000048E8  ; data: 0x08, 0x02
000048EA  ; data: 0x04, 0x7a
000048EC  ; data: 0xa8, 0x00
000048EE  move.b d0, $df(a0)
000048F2  ; data: 0xa0, 0x00
000048F4  bcs.b  $487b
000048F6  ori.b  #$ba, d0
000048FA  or.l   (a5)+, d0
000048FC  ; data: 0x3c, 0xfe
000048FE  or.l   (a6)+, d3
00004900  addx.l d4, d1
00004902  ; data: 0xff, 0xf4
00004904  move.w d2, ([$44002248, a0])
0000490C  ori.l  #$1109, (a7)+
00004912  or.b   d0, d0
00004914  movep.w d1, -$7f9b(a6)
00004918  ; data: 0xbf, 0xfe
0000491A  ; data: 0x83, 0x7c
0000491C  bls.b  $48be
0000491E  ; data: 0xff, 0xfc
00004920  bclr.b d4, d2
00004922  ; data: 0x0b, 0xfe
00004924  ; data: 0xa8, 0x00
00004926  chk.w  (a0)+, d7
00004928  and.b  (a7, d0.w), d0
0000492C  ori.b  #$0, d3
00004930  subi.b #$a5, d7
00004934  ; data: 0xde, 0xfe
00004936  btst.l d0, d6
00004938  ; data: 0x08, 0x13
0000493A  ; data: 0xff, 0xfc
0000493C  ble.b  $4910
0000493E  ; data: 0xb9, 0xff
00004940  or.b   d0, d0
00004942  and.l  d3, -(a1)
00004944  ; data: 0xd0, 0x0e
00004946  ori.b  #$0, d0
0000494A  ori.b  #$45, d0
0000494E  ; data: 0xff, 0x3a
00004950  eori.w #$8b, sr
00004954  btst.l d2, (a3)
00004956  ; data: 0x7f, 0xf6
00004958  subq.l #$7, -$7e06(a0)
0000495C  ; data: 0xa8, 0x08
0000495E  ; data: 0xa1, 0x1b
00004960  dc.w   $f021
00004962  ori.b  #$0, d0
00004966  ori.w  #$263, d0
0000496A  rol.b  #$8, d0
0000496C  move.w d0, d0
0000496E  ; data: 0x00, 0x0e
00004970  move.b d7, d1
00004972  ; data: 0x7f, 0xfe
00004974  ; data: 0x2d, 0xc0
00004976  ; data: 0x21, 0xff
00004978  negx.b d0
0000497A  lsr.b  #$8, d3
0000497C  cmp.b  (a2, d0.w), d0
00004980  ori.b  #$40, d0
00004984  subi.b #$48, -(a5)
00004988  moveq  #$88, d6
0000498A  ; data: 0x00, 0x0b
0000498C  move.b (a3), -(a4)
0000498E  adda.l $3f00(a2), a7
00004992  ; data: 0x45, 0xfe
00004994  ; data: 0xa0, 0x08
00004996  dc.w   $f243
00004998  move.l (a0), d0
0000499A  ori.b  #$0, d0
0000499E  ; data: 0x00, 0xe0
000049A0  addi.w #$bd2, -(a2)
000049A4  cmp.l  -(a0), d7
000049A6  subi.b #$55, d7
000049AA  ; data: 0xdf, 0x7e
000049AC  move.w (a0), (a2)+
000049AE  ; data: 0x01, 0xff
000049B0  and.b  d0, d0
000049B2  move.w (a2, d0.w), (a6)
000049B6  ori.b  #$0, d0
000049BA  ; data: 0x00, 0xf0
000049BC  btst.l d3, -$3f1d(a7)
000049C0  adda.l d0, a7
000049C2  movep.w -$26dd(a3), d4
000049C6  ; data: 0xee, 0xfa
000049C8  bvc.b  $4973
000049CA  ; data: 0x07, 0xfa
000049CC  ; data: 0xa8, 0x00
000049CE  move.w $49d0(pc,d0.w), $0(a0)
000049D4  ori.b  #$78, d0
000049D8  ; data: 0x07, 0xfb
000049DA  dc.w   $f8eb
000049DC  ; data: 0xff, 0xc0
000049DE  addi.b #$67, d7
000049E2  ; data: 0xaf, 0xfe
000049E4  movea.w d6, a0
000049E6  ; data: 0x03, 0xff
000049E8  and.b  d0, d0
000049EA  btst.l d0, $49ec(pc,a0.w)
000049EE  ori.b  #$0, d0
000049F2  btst.l d2, $2ef.w
000049F6  moveq  #$df, d2
000049F8  ; data: 0xff, 0x80
000049FA  btst.l d7, d7
000049FC  sbcd.b d3, d3
000049FE  cmpa.l $8410(pc), a3
00004A02  ; data: 0x13, 0x7e
00004A04  ; data: 0xa8, 0x00
00004A06  bclr.b d0, (a2, a4.w)
00004A0A  ori.b  #$0, d0
00004A0E  move.l (a0), -(a7)
00004A10  ; data: 0x01, 0x7c
00004A12  bne.b  $4a2d
00004A14  dc.w   $ff10
00004A16  ; data: 0x0a, 0x8b
00004A18  or.l   -(a1), d5
00004A1A  ; data: 0xe7, 0xfe
00004A1C  cmp.b  -(a4), d0
00004A1E  ; data: 0x34, 0x3f
00004A20  add.b  d1, d0
00004A22  ; data: 0xe1, 0xc6
00004A24  and.b  d0, d0
00004A26  ori.b  #$0, d0
00004A2A  move.b d0, -(a7)
00004A2C  ; data: 0x00, 0xff
00004A2E  move.w -(a0), -(a5)
00004A30  beq.w  $fffff940
00004A34  asl.w  #$2, d3
00004A36  ; data: 0xba, 0xff
00004A38  dc.w   $f807
00004A3A  bvc.b  $4a9b
00004A3C  ; data: 0xa8, 0x0f
00004A3E  mulu.w -$4000(a5), d0
00004A42  ori.b  #$0, d0
00004A46  addq.b #$4, d0
00004A48  ; data: 0x00, 0x3a
00004A4A  svs.b  d0
00004A4C  sbcd.b d0, d7
00004A4E  tst.b  -$7d(a1, a7.w)
00004A52  dc.w   $fefd
00004A54  dc.w   $f403
00004A56  dc.w   $fc3f
00004A58  and.b  (a7)+, d0
00004A5A  ror.l  d0, d4
00004A5C  and.b  d0, d0
00004A5E  ori.b  #$0, d0
00004A62  cmpi.b #$16, d0
00004A66  ; data: 0x08, 0x04
00004A68  btst.l d5, d0
00004A6A  move.l -(a1), $f803.w
00004A6E  ; data: 0xee, 0xff
00004A70  asr.b  #$5, d3
00004A72  add.w  d2, (a6)+
00004A74  ; data: 0xaa, 0x1f
00004A76  ror.b  #$2, d0
00004A78  negx.b d0
00004A7A  ori.b  #$0, $0(a4)
00004A80  and.b  $c3a.w, d0
00004A84  move.w d0, d2
00004A86  ; data: 0x00, 0xe1
00004A88  move.w d4, -(a4)
00004A8A  ; data: 0xcf, 0xfd
00004A8C  moveq  #$2, d0
00004A8E  ; data: 0xae, 0x3f
00004A90  add.w  (a7), d0
00004A92  ror.b  #$2, d0
00004A94  negx.b d0
00004A96  ori.b  #$8, (a4)+
00004A9A  or.b   d0, d0
00004A9C  asr.w  (a0)+
00004A9E  ; data: 0x08, 0x5b
00004AA0  dc.w   $f002
00004AA2  ; data: 0x00, 0xf0
00004AA4  ; data: 0xfb, 0x06
00004AA6  ; data: 0x1f, 0xff
00004AA8  bpl.w  $1ec9
00004AAC  ; data: 0xa8, 0x2a
00004AAE  asr.b  #$2, d0
00004AB0  ori.b  #$50, d0
00004AB4  ; data: 0x7f, 0xff
00004AB6  or.b   d0, d0
00004AB8  bsr.b  $4aae
00004ABA  or.l   (a7)+, d4
00004ABC  ; data: 0xa8, 0x00
00004ABE  bset.b d2, $4(a0, d7.l)
00004AC2  ; data: 0x2f, 0x7f
00004AC4  moveq  #$0, d2
00004AC6  and.b  d4, -$1ff(a7)
00004ACA  moveq  #$0, d0
00004ACC  ori.b  #$1, d0
00004AD0  moveq  #$7f, d5
00004AD2  ori.b  #$fe, d0
00004AD6  ; data: 0x4b, 0xc7
00004AD8  dc.w   $fc00
00004ADA  bset.b d1, $3800(a0)
00004ADE  ; data: 0xae, 0xfd
00004AE0  moveq  #$0, d5
00004AE2  movea.w (a7), a4
00004AE4  eor.b  d6, d0
00004AE6  cmp.b  d0, d0
00004AE8  ori.b  #$0, d0
00004AEC  dc.w   $f438
00004AEE  ori.b  #$ff, d0
00004AF2  ; data: 0x8f, 0xff
00004AF4  dc.w   $fc00
00004AF6  bset.b d3, -(a0)
00004AF8  ; data: 0xa0, 0x00
00004AFA  ble.b  $4af9
00004AFC  bpl.w  $8355
00004B00  eor.b  d6, d0
00004B02  sub.b  d0, d0
00004B04  ori.b  #$3, d0
00004B08  roxr.l #$6, d2
00004B0A  ori.b  #$7f, d0
00004B0E  ; data: 0x8f, 0xff
00004B10  dc.w   $fe00
00004B12  bset.b d3, (a0)
00004B14  ; data: 0xa0, 0x00
00004B16  ble.b  $4b15
00004B18  moveq  #$0, d6
00004B1A  moveq  #$2f, d5
00004B1C  asl.b  #$8, d0
00004B1E  ori.b  #$0, d0
00004B22  ori.b  #$1b, d3
00004B26  or.b   d0, d0
00004B28  ori.b  #$ff, (a7)+
00004B2C  dc.w   $fa80
00004B2E  bset.b d3, d1
00004B30  ori.b  #$ff, d0
00004B34  move.w d0, (a5)
00004B36  move.w d7, -$7e00(a4)
00004B3A  ori.b  #$0, d0
00004B3E  ori.b  #$19, d7
00004B42  negx.b d0
00004B44  ; data: 0x00, 0x0f
00004B46  ; data: 0xf3, 0xff
00004B48  eor.b  d4, d0
00004B4A  bset.b d3, -(a2)
00004B4C  ori.b  #$fd, (a0)
00004B50  move.b d0, d6
00004B52  move.w d3, -(a0)
00004B54  and.b  d0, d2
00004B56  ori.b  #$0, d0
00004B5A  ori.b  #$1f, d6
00004B5E  or.b   d0, d0
00004B60  ; data: 0x00, 0x0c
00004B62  ; data: 0x57, 0xff
00004B64  ; data: 0xfd, 0xe0
00004B66  movep.l d1, $40(a0)
00004B6A  ; data: 0x3f, 0xbf
00004B6C  move.b d0, d7
00004B6E  bpl.b  $4b75
00004B70  asr.l  #$5, d0
00004B72  ori.w  #$0, d0
00004B76  ori.b  #$3f, d6
00004B7A  asr.l  #$7, d0
00004B7C  negx.b (a0)+
00004B7E  ; data: 0xff, 0xff
00004B80  ; data: 0xa4, 0x30
00004B82  ; data: 0x15, 0x8f
00004B84  or.l   d0, d1
00004B86  ; data: 0x7f, 0x7f
00004B88  move.b d0, -(a6)
00004B8A  moveq  #$e, d4
00004B8C  ; data: 0xfd, 0x00
00004B8E  bset.b d0, -(a0)
00004B90  ori.b  #$0, d0
00004B94  ; data: 0x00, 0xbf
00004B96  asl.l  #$5, d0
00004B98  ; data: 0xa0, 0x1d
00004B9A  ; data: 0xff, 0xff
00004B9C  dc.w   $f0f4
00004B9E  ; data: 0x00, 0x8f
00004BA0  mulu.w d0, d0
00004BA2  ; data: 0xff, 0xfe
00004BA4  move.w d0, (a7)
00004BA6  move.l (a5), $7a80(a4)
00004BAA  bset.b d0, -(a0)
00004BAC  ori.b  #$7, d0
00004BB0  bclr.b d0, (a7)+
00004BB2  ; data: 0xc0, 0x3d
00004BB4  negx.w ([$a3ff0487])
00004BBC  or.l   $7ffd(a1), d1
00004BC0  move.w d0, d6
00004BC2  movep.w d0, -$300(a0)
00004BC6  bset.b d1, -(a0)
00004BC8  ori.b  #$6, d0
00004BCC  ; data: 0x03, 0xff
00004BCE  ; data: 0xa0, 0x7f
00004BD0  lsr.w  #$8, d7
00004BD2  ; data: 0xff, 0xff
00004BD4  ; data: 0xff, 0xfe
00004BD6  or.w   d3, d0
00004BD8  move.w -$102(a2), $1a80(a3)
00004BDE  bchg.b d0, (a1)
00004BE0  asr.l  d5, d0
00004BE2  bset.b d1, d0
00004BE4  ori.b  #$7, d0
00004BE8  ; data: 0x03, 0xff
00004BEA  move.w sr, -$1781(a0)
00004BEE  ; data: 0xff, 0xff
00004BF0  dc.w   $6fff
00004BF2  sub.w  $3(a4, d3.l), d2
00004BF6  ; data: 0xfd, 0x7f
00004BF8  ; data: 0x7d, 0x00
00004BFA  ; data: 0x02, 0xf9
00004BFC  ; data: 0xfd, 0x00
00004BFE  bclr.b d1, d0
00004C00  ori.b  #$3, d0
00004C04  ; data: 0x1c, 0x7e
00004C06  or.w   (a0), d0
00004C08  lsr.b  #$8, d7
00004C0A  ; data: 0xff, 0xfe
00004C0C  ; data: 0x0e, 0xbf
00004C0E  ; data: 0x88, 0x88
00004C10  move.w -(a1), -$4102(a7)
00004C14  dc.w   $fa80
00004C16  ; data: 0x01, 0x7f
00004C18  dc.w   $faa8
00004C1A  move.w d0, d4
00004C1C  ori.b  #$21, d0
00004C20  or.w   $8c(a7), d2
00004C24  dc.w   $f85f
00004C26  ; data: 0xff, 0xce
00004C28  move.b $4bba(pc, a4.w), $3c01(a4)
00004C2E  ; data: 0x5f, 0x7d
00004C30  eor.b  d7, d0
00004C32  ; data: 0x02, 0xff
00004C34  ; data: 0xff, 0x40
00004C36  move.w d0, d6
00004C38  ori.b  #$f0, d0
00004C3C  movep.w d7, -$7fb2(a7)
00004C40  moveq  #$3f, d7
00004C42  ; data: 0xfd, 0x0e
00004C44  addi.w #$c0b1, $1(a5, a7.w)
00004C4A  ; data: 0xff, 0xbe
00004C4C  add.l  -(a0), d7
00004C4E  bchg.b d2, (a7)+
00004C50  dc.w   $feaa
00004C52  move.b d0, d4
00004C54  ori.b  #$f8, d0
00004C58  btst.l d7, $4cc8(pc, a0.w)
00004C5C  move.b (a7)+, d3
00004C5E  addx.l -(a6), -(a1)
00004C60  addi.l #$3fe003, -$f(a2)
00004C68  sbcd.b d0, d7
00004C6A  ; data: 0x02, 0xfb
00004C6C  ; data: 0xff, 0xd0
00004C6E  ori.b  #$0, d3
00004C72  cmpi.w #$79f, $47(a0, d1.w)
00004C78  ; data: 0xa3, 0x8f
00004C7A  or.b   (a3), d1
00004C7C  or.b   d6, $7f(a0, d0.w)
00004C80  muls.w (a7), d0
00004C82  ; data: 0xff, 0xfd
00004C84  ; data: 0x0e, 0xa0
00004C86  bchg.b d2, d7
00004C88  ; data: 0xff, 0xa8
00004C8A  ; data: 0x80, 0x0f
00004C8C  and.b  (a0)+, d0
00004C8E  ; data: 0x0e, 0x20
00004C90  bchg.b d1, $13e3(a4)
00004C94  subq.w #$2, a5
00004C96  beq.b  $4c3f
00004C98  add.b  -(a1), d6
00004C9A  ; data: 0x40, 0x7f
00004C9C  divs.w (a7)+, d0
00004C9E  ; data: 0xff, 0xfa
00004CA0  bchg.b d7, d0
00004CA2  ori.l  #$fff4c00f, d3
00004CA8  ; data: 0x80, 0x0d
00004CAA  ; data: 0x4e, 0x20
00004CAC  bset.b d0, $1b9.w
00004CB0  ; data: 0x90, 0xbe
00004CB2  ; data: 0x0b, 0x7d
00004CB4  ; data: 0xfb, 0x06
00004CB6  ; data: 0x00, 0x7f
00004CB8  sub.l  -$100a(a3), d1
00004CBC  move.b -(a0), (a7)
00004CBE  bchg.b d0, d3
00004CC0  adda.l -$3ff3(a3), a7
00004CC4  dc.w   $f203
00004CC6  or.w   -(a0), d6
00004CC8  ; data: 0x00, 0xfc
00004CCA  bset.b d2, d5
00004CCC  move.b -$6807(a0), -$804(a2)
00004CD2  ; data: 0x02, 0x7f
00004CD4  abcd.b -(a5), -(a0)
00004CD6  ; data: 0xf7, 0xf8
00004CD8  ; data: 0x1f, 0xd0
00004CDA  ori.b  #$ff, -(a6)
00004CDE  ror.b  #$8, d7
00004CE0  bge.w  $6902
00004CE4  ; data: 0x01, 0xfc
00004CE6  bset.b d2, -$4(a4, a0.w)
00004CEA  sle.b  $ffa003ff.l
00004CF0  asr.b  #$5, d3
00004CF2  dc.w   $efee
00004CF4  subq.l #$7, $54(a0)
00004CF8  ; data: 0x0f, 0xbf
00004CFA  roxr.l #$4, d0
00004CFC  move.l a0, -(a2)
00004CFE  suba.l a6, a7
00004D00  ; data: 0x00, 0xfc
00004D02  ; data: 0x06, 0xfc
00004D04  add.w  d2, $ffd0073f(invalid.w)
00004D0C  sub.b  (a7), d6
00004D0E  sle.b  (invalid.w)
00004D12  ori.b  #$ff, -$b19(a4)
00004D18  move.w a0, d1
00004D1A  ; data: 0x1f, 0xdf
00004D1C  ; data: 0x00, 0xfc
00004D1E  ; data: 0x1c, 0x7c
00004D20  or.b   -(a1), d1
00004D22  ; data: 0x7f, 0xf8
00004D24  dc.w   $ff20
00004D26  ; data: 0x08, 0x5f
00004D28  or.w   -$48(a5), d0
00004D2C  subq.l #$7, $54(a0)
00004D30  ; data: 0x07, 0xff
00004D32  dc.w   $fcf7
00004D34  move.b d2, d5
00004D36  ; data: 0x2f, 0xbf
00004D38  divs.w -(a4), d0
00004D3A  add.b  (a5)+, d4
00004D3C  adda.l -(a2), a3
00004D3E  ; data: 0xff, 0xe8
00004D40  moveq  #$80, d5
00004D42  ; data: 0x08, 0x0f
00004D44  ori.b  #$76, (a7)+
00004D48  lea.l  (a0), a3
00004D4A  ori.b  #$ff, -$779(a4)
00004D50  cmp.b  d0, d6
00004D52  ; data: 0x07, 0x3f
00004D54  divs.w (a3)+, d0
00004D56  moveq  #$78, d2
00004D58  or.b   $fff0.w, d6
00004D5C  ; data: 0x7d, 0x00
00004D5E  negx.b d5
00004D60  ori.b  #$aa, $1a8(a7)
00004D66  ori.w  #$f7ff, (a4)
00004D6A  dc.w   $f8b3
00004D6C  dc.w   $f280
00004D6E  ; data: 0x08, 0xbf
00004D70  or.l   $8e4dc2c.l, d0
00004D76  ; data: 0x7f, 0xa8
00004D78  move.w d0, -$75(a2, d3.l)
00004D7C  ori.b  #$f4, (a7)
00004D80  bset.b d1, $b(a4, d0.w)
00004D84  dc.w   $60ff
00004D86  dc.w   $f4b1
00004D88  seq.b  $7f(a0, d0.w)
00004D8C  or.w   (a6)+, d0
00004D8E  move.w ([$4d90pc], a7.w * 8, $7ffc), sr
00004D94  move.b d0, (a6)
00004D96  and.b  (a5), d6
00004D98  sub.b  d3, d0
00004D9A  and.l  d1, -(a0)
00004D9C  move.l $15(a2), $5bf.w
00004DA2  ; data: 0xea, 0xd6
00004DA4  blt.b  $4d9e
00004DA6  ; data: 0x00, 0xff
00004DA8  or.l   -$2099(a6), d0
00004DAC  eor.w  d1, (a6)+
00004DAE  ; data: 0x7f, 0xa8
00004DB0  move.w d6, -(a3)
00004DB2  ; data: 0xbe, 0x0b
00004DB4  or.b   d5, d4
00004DB6  muls.w -$4(a4, d2.w), d3
00004DBA  ori.b  #$bf, d0
00004DBE  ; data: 0xfd, 0x60
00004DC0  dc.w   $ebf2
00004DC2  ; data: 0x00, 0xff
00004DC4  ; data: 0x00, 0x7f
00004DC6  move.w d7, -(a7)
00004DC8  suba.w $7ff0(a7), a7
00004DCC  beq.b  $4d4e
00004DCE  ; data: 0x47, 0xff
00004DD0  dc.w   $f009
00004DD2  muls.w (a4), d7
00004DD4  ; data: 0x25, 0xfa
00004DD6  or.b   d0, d0
00004DD8  addq.l #$2, a7
00004DDA  roxr.l #$5, d7
00004DDC  divs.w $fe.w, d2
00004DE0  nbcd.b -$153(a1)
00004DE4  ; data: 0xfd, 0xc3
00004DE6  ; data: 0x73, 0xa8
00004DE8  move.l d4, -$41(a3, a2.w)
00004DEC  ; data: 0xa4, 0xc5
00004DEE  suba.l $319ef(invalid.w), a3
00004DF6  ; data: 0xff, 0xff
00004DF8  ; data: 0x08, 0xfc
00004DFA  bset.b d0, $3f(a0, a7.w)
00004DFE  dc.w   $fc90
00004E00  ; data: 0x7f, 0x61
00004E02  chk.w  (a0), d3
00004E04  move.l (a7), ([$c1c03fe0])
00004E0C  ; data: 0x07, 0xfa
00004E0E  ; data: 0xa0, 0x07
00004E10  ; data: 0x1f, 0xe5
00004E12  dc.w   $fafa
00004E14  ; data: 0x0c, 0x7f
00004E16  ; data: 0x4f, 0x60
00004E18  dc.w   $fc25
00004E1A  roxl.l #$1, d2
00004E1C  dblt   d0, $949e
00004E20  movea.l -$4102(a2), a0
00004E24  divs.w d0, d4
00004E26  ; data: 0x3f, 0xd0
00004E28  ; data: 0x13, 0xfd
00004E2A  ; data: 0x00, 0x0e
00004E2C  adda.l $8e27(pc), a1
00004E30  ; data: 0x04, 0x7f
00004E32  adda.l (a3), a7
00004E34  dc.w   $f86b
00004E36  and.l  d5, $5d46.w
00004E3A  subq.w #$7, d0
00004E3C  ; data: 0x01, 0xfd
00004E3E  ; data: 0x3f, 0xff
00004E40  ori.b  #$e8, d0
00004E44  ; data: 0x19, 0xfa
00004E46  ; data: 0xa0, 0x0c
00004E48  ; data: 0xa3, 0xf4
00004E4A  ; data: 0x3f, 0xfa
00004E4C  ; data: 0xaf, 0xff
00004E4E  eor.l  d7, -(a1)
00004E50  dc.w   $fc47
00004E52  add.l  d1, $40(a1, a6.w)
00004E56  moveq  #$a0, d4
00004E58  ; data: 0x4b, 0xfc
00004E5A  ; data: 0x3f, 0xfe
00004E5C  ori.l  #$e5980cff, d0
00004E62  ; data: 0x40, 0x0a
00004E64  ; data: 0x73, 0xca
00004E66  ; data: 0x0b, 0xfd
00004E68  ; data: 0x4f, 0xff
00004E6A  ; data: 0xf7, 0xd1
00004E6C  cmpa.l a7, a5
00004E6E  ; data: 0xf7, 0x3f
00004E70  move.w d3, (a1)
00004E72  and.w  d0, d0
00004E74  ; data: 0x3f, 0xf8
00004E76  ; data: 0xff, 0x9c
00004E78  cmp.l  d2, d1
00004E7A  ; data: 0xae, 0xc0
00004E7C  ; data: 0x0e, 0xfe
00004E7E  ; data: 0xa8, 0x00
00004E80  ; data: 0x29, 0xc8
00004E82  ; data: 0x01, 0xfa
00004E84  ; data: 0xaf, 0xff
00004E86  ; data: 0xf3, 0xe0
00004E88  ; data: 0xbf, 0xbf
00004E8A  add.b  d7, (a7)
00004E8C  dc.w   $f803
00004E8E  and.l  $7bf6(a0), d6
00004E92  ; data: 0x7f, 0x0e
00004E94  bls.b  $4e9a
00004E96  adda.l d0, a7
00004E98  ; data: 0x0e, 0xff
00004E9A  add.b  d0, d0
00004E9C  ; data: 0x00, 0xfc
00004E9E  ; data: 0x73, 0xfd
00004EA0  ; data: 0xd7, 0xff
00004EA2  ; data: 0xf9, 0xd0
00004EA4  ; data: 0x5b, 0xbf
00004EA6  ; data: 0xa3, 0x03
00004EA8  add.b  d3, d0
00004EAA  ; data: 0xfb, 0x00
00004EAC  ; data: 0x71, 0xf8
00004EAE  ; data: 0xff, 0x02
00004EB0  chk.w  (a2)+, d5
00004EB2  move.b (a0), (a7)
00004EB4  ; data: 0x0c, 0xff
00004EB6  ; data: 0xa8, 0x00
00004EB8  ; data: 0x03, 0xfc
00004EBA  ; data: 0xe1, 0xfa
00004EBC  ; data: 0xab, 0xab
00004EBE  ; data: 0xf9, 0xe8
00004EC0  move.w $483(a7), (a7)
00004EC4  ; data: 0xa5, 0x03
00004EC6  ; data: 0xa9, 0x20
00004EC8  ; data: 0x71, 0xe0
00004ECA  dc.w   $f803
00004ECC  cmp.b  d5, d6
00004ECE  ; data: 0x3d, 0xd0
00004ED0  ; data: 0x05, 0xff
00004ED2  dc.w   $f000
00004ED4  ; data: 0x1d, 0xf2
00004ED6  ; data: 0xf1, 0xff
00004ED8  ; data: 0xf5, 0x43
00004EDA  dc.w   $fc20
00004EDC  ori.b  #$f, (a6)+
00004EE0  subx.b d1, d7
00004EE2  dc.w   $f000
00004EE4  bchg.b d1, -(a3)
00004EE6  dc.w   $fc08
00004EE8  ; data: 0x7f, 0x1a
00004EEA  eori.w #$67f, d0
00004EEE  asr.b  #$5, d0
00004EF0  ; data: 0x0a, 0xe7
00004EF2  ; data: 0x88, 0xfe
00004EF4  ; data: 0xaa, 0xab
00004EF6  add.l  -$5555(a6), d7
00004EFA  bvc.b  $4f0b
00004EFC  ; data: 0xa0, 0x20
00004EFE  ; data: 0xa8, 0x00
00004F00  move.l -(a0), d0
00004F02  asr.b  #$5, d2
00004F04  ; data: 0xff, 0x9f
00004F06  move.b d0, (a3)
00004F08  ; data: 0x04, 0x3f
00004F0A  dc.w   $f800
00004F0C  movep.l d2, -$4f01(a6)
00004F10  ; data: 0xfd, 0xd1
00004F12  ; data: 0xff, 0x1f
00004F14  move.b (a5)+, -$41e1(a0)
00004F18  add.w  d0, (a1, a0.w)
00004F1C  bgt.b  $4f92
00004F1E  bcc.b  $4f21
00004F20  ; data: 0xff, 0x92
00004F22  btst.l d3, -(a0)
00004F24  ori.l  #$ea80227f, (a7)+
00004F2A  ror.w  d4, d7
00004F2C  ; data: 0xfb, 0xab
00004F2E  ; data: 0xff, 0xc4
00004F30  ; data: 0xaa, 0xaa
00004F32  add.l  d5, -$1d90(a7)
00004F36  and.b  d0, d0
00004F38  moveq  #$38, d3
00004F3A  bhi.w  $cf18
00004F3E  move.b d0, $1f(a2, d0.w)
00004F42  ; data: 0xfd, 0x00
00004F44  lea.l  -$73c1(a3), a3
00004F48  ; data: 0xff, 0xff
00004F4A  divs.w d2, d7
00004F4C  ; data: 0xd1, 0xff
00004F4E  adda.l (a6)+, a1
00004F50  lea.l  $1(a0, d2.w), a4
00004F54  moveq  #$dc, d6
00004F56  dc.w   $f000
00004F58  ; data: 0x77, 0xc8
00004F5A  ; data: 0x0e, 0x00
00004F5C  andi.b #$80, (a7)+
00004F60  ; data: 0x2b, 0xe7
00004F62  and.b  (a7)+, d3
00004F64  ; data: 0xff, 0xef
00004F66  dc.w   $4701
00004F68  or.l   d3, -$7e4(a3)
00004F6C  ; data: 0x41, 0xe0
00004F6E  bra.b  $4f72
00004F70  or.b   (a4)+, d0
00004F72  dc.w   $f800
00004F74  ; data: 0xff, 0x9e
00004F76  ; data: 0x1a, 0x40
00004F78  ; data: 0x00, 0x3f
00004F7A  dc.w   $fd20
00004F7C  ; data: 0x17, 0x0f
00004F7E  andi.l #$fffe024c, -(a7)
00004F84  ; data: 0x1f, 0xff
00004F86  dc.w   $f400
00004F88  not.w  -(a0)
00004F8A  lsr.b  #$8, d3
00004F8C  ori.b  #$0, (a6)+
00004F90  roxl.l #$3, d3
00004F92  ; data: 0x0e, 0x00
00004F94  bchg.b d0, (a7)
00004F96  moveq  #$80, d5
00004F98  ; data: 0x0a, 0xbb
00004F9A  move.b (a7), ([$596e7fec])
00004FA2  ; data: 0x7f, 0x01
00004FA4  cmpi.b #$8c, -(a0)
00004FA8  dc.w   $f03d
00004FAA  roxl.b #$5, d5
00004FAC  or.l   d7, -$80(a5, a5.w)
00004FB0  btst.l d0, -$40b0(a6)
00004FB4  bset.b d3, (a5)+
00004FB6  btst.l d0, d3
00004FB8  ; data: 0xff, 0xfe
00004FBA  move.w (a6), -(a7)
00004FBC  dc.w   $fc8f
00004FBE  ; data: 0x7d, 0x00
00004FC0  ; data: 0x08, 0x04
00004FC2  ; data: 0x1e, 0x4d
00004FC4  dc.w   $fc3d
00004FC6  lsl.b  d0, d5
00004FC8  suba.l $ffffda4a(pc), a5
00004FCC  ; data: 0x00, 0xc7
00004FCE  moveq  #$ae, d7
00004FD0  ; data: 0x13, 0xff
00004FD2  btst.l d4, (a7)
00004FD4  ; data: 0xdf, 0xff
00004FD6  addq.l #$1, $5c(a7, a7.l)
00004FDA  moveq  #$e0, d2
00004FDC  move.b d2, d0
00004FDE  ; data: 0xb9, 0x3d
00004FE0  ; data: 0x9c, 0x3f
00004FE2  and.b  (a7)+, d0
00004FE4  ; data: 0xff, 0xf7
00004FE6  add.b  d0, d7
00004FE8  ori.l  #$3fde8d8f, (a4)
00004FEE  move.l d7, -(a1)
00004FF0  ; data: 0x07, 0xff
00004FF2  cmpa.w -(a7), a1
00004FF4  ; data: 0xff, 0xf9
00004FF6  eor.l  d5, -(a0)
00004FF8  or.b   d0, d4
00004FFA  move.l $501b(pc, a4.l), $3f(a1, a3.w)
00005000  ; data: 0xff, 0xff
00005002  move.l d0, -(a4)
00005004  ; data: 0x00, 0x0a
00005006  ; data: 0xff, 0xaf
00005008  movep.l d3, $2386(a7)
0000500C  ; data: 0x07, 0xff
0000500E  move.w (a7), -(a1)
00005010  ; data: 0xff, 0xfd
00005012  ; data: 0xaf, 0x20
00005014  negx.b d2
00005016  move.w (a1), -$b81(a0)
0000501A  ; data: 0xa4, 0x3f
0000501C  ; data: 0xff, 0xfe
0000501E  add.b  d0, d4
00005020  ori.w  #$ffff, d3
00005024  bset.b d2, (a5)
00005026  ; data: 0x1f, 0xe6
00005028  ; data: 0x03, 0xfc
0000502A  ; data: 0x3b, 0xff
0000502C  ; data: 0xff, 0xff
0000502E  moveq  #$20, d6
00005030  negx.b d0
00005032  ; data: 0x1e, 0xc8
00005034  ; data: 0x01, 0xff
00005036  ; data: 0xa0, 0xaf
00005038  ; data: 0xff, 0xff
0000503A  cmp.b  d0, d4
0000503C  ori.w  #$ffea, d1
00005040  bset.b d5, d1
00005042  ; data: 0x73, 0xe4
00005044  bset.b d1, $3d7f.w
00005048  ; data: 0xff, 0xf7
0000504A  asr.b  d0, d0
0000504C  andi.l #$17c023f, -(a6)
00005052  and.w  d7, d2
00005054  ; data: 0xff, 0xfb
00005056  moveq  #$0, d1
00005058  ori.b  #$fc, -(a3)
0000505C  adda.l -(a2), a3
0000505E  ; data: 0x77, 0xe4
00005060  divs.w $3f(a0, d0.w), d1
00005064  ; data: 0xff, 0xe5
00005066  and.b  ([a5], a0.w * 4, $17c6037), d0
0000506E  lsr.w  #$8, d7
00005070  ; data: 0xff, 0xff
00005072  addq.b #$8, d0
00005074  ori.b  #$fa, -(a5)
00005078  sle.b  -(a3)
0000507A  ble.b  $5005
0000507C  divs.w $3f(a0, d0.w), d3
00005080  ; data: 0xff, 0xcf
00005082  and.b  $2.w, d0
00005086  ; data: 0x01, 0x7e
00005088  dc.w   $f0af
0000508A  and.b  (a7)+, d0
0000508C  ; data: 0xff, 0xff
0000508E  move.w d0, d2
00005090  ori.b  #$ff, (a2)
00005094  ; data: 0x7f, 0x73
00005096  move.b (a3)+, $5f0(a7)
0000509A  ; data: 0x00, 0x3f
0000509C  ; data: 0xff, 0x87
0000509E  and.b  (a6, d0.w), d0
000050A2  ; data: 0x0b, 0x7e
000050A4  ; data: 0xf8, 0x7f
000050A6  ; data: 0xc0, 0xff
000050A8  ; data: 0xff, 0xfa
000050AA  ; data: 0xa0, 0x00
000050AC  ori.b  #$fe, (a0)
000050B0  move.l $3(a7, d7.l), -(a7)
000050B4  dc.w   $ebf8
000050B6  ; data: 0x00, 0x7f
000050B8  ; data: 0xff, 0x8f
000050BA  and.b  -(a0), d1
000050BC  move.l d0, d0
000050BE  ; data: 0x1c, 0x7e
000050C0  dc.w   $f073
000050C2  muls.w (a5)+, d0
000050C4  ; data: 0xff, 0xf3
000050C6  dc.w   $f800
000050C8  ; data: 0x00, 0x09
000050CA  ; data: 0x01, 0xfe
000050CC  rol.l  #$7, d7
000050CE  ; data: 0x75, 0x1b
000050D0  ; data: 0xe0, 0xfe
000050D2  ; data: 0x00, 0xff
000050D4  ; data: 0xff, 0xfb
000050D6  and.w  d1, d0
000050D8  ; data: 0x08, 0x0c
000050DA  move.w a7, d2
000050DC  ror.w  d0, d1
000050DE  ; data: 0xe5, 0xfc
000050E0  ; data: 0xff, 0xfc
000050E2  and.b  d0, d0
000050E4  ; data: 0x00, 0x09
000050E6  ; data: 0x88, 0xff
000050E8  ; data: 0x1f, 0xed
000050EA  rol.l  #$4, d7
000050EC  divu.w (a7)+, d0
000050EE  ; data: 0x80, 0x7f
000050F0  ; data: 0xff, 0xfb
000050F2  addq.l #$6, -(a2)
000050F4  move.b d0, (a6)
000050F6  addi.b #$62, d3
000050FA  bls.b  $50f9
000050FC  ; data: 0xff, 0xfd
000050FE  dc.w   $f000
00005100  ori.b  #$ce, d4
00005104  bset.b d0, ([$c03fc0f0])
0000510C  dc.w   $fe6b
0000510E  ; data: 0xa7, 0x00
00005110  move.w d3, -$3c39(a1)
00005114  subx.w d0, d5
00005116  ; data: 0x17, 0xff
00005118  ; data: 0xff, 0xfd
0000511A  and.b  d0, d0
0000511C  ori.b  #$84, d4
00005120  suba.w -(a5), a0
00005122  ; data: 0xab, 0xab
00005124  dc.w   $411f
00005126  addx.w d0, d0
00005128  dc.w   $fa5d
0000512A  clr.b  -(a0)
0000512C  move.b -$4d(a7, a6.w), (a5)+
00005130  move.b (a0), ([$ffff2000])
00005138  ori.b  #$45, d3
0000513C  moveq  #$48, d5
0000513E  sub.b  -$1fe1(a5), d0
00005142  asr.l  #$8, d1
00005144  dc.w   $efd2
00005146  move.b d0, d0
00005148  ; data: 0x1c, 0xff
0000514A  movea.w $6100(a0), a0
0000514E  ; data: 0x03, 0xff
00005150  ; data: 0xff, 0xef
00005152  or.b   d0, d0
00005154  ori.b  #$2c, d2
00005158  move.w d0, $7c(a5, d0.w)
0000515C  bra.b  $51dd
0000515E  abcd.b d1, d0
00005160  add.w  d7, -(a1)
00005162  negx.b -(a1)
00005164  bset.b d2, $38(a0, a3.l)
00005168  ; data: 0xa2, 0x04
0000516A  ; data: 0x0b, 0xff
0000516C  ; data: 0xff, 0x9c
0000516E  and.b  d0, d0
00005170  ori.b  #$3a, d1
00005174  move.w d0, (a0)+
00005176  ori.w  #$e02e, sr
0000517A  move.w d3, d0
0000517C  ; data: 0xa4, 0xf4
0000517E  ori.b  #$f4, d0
00005182  ; data: 0x7f, 0x81
00005184  add.b  d0, d2
00005186  ; data: 0xdf, 0xff
00005188  ; data: 0xff, 0x1f
0000518A  ori.b  #$0, d0
0000518E  or.l   (a0)+, d1
00005190  ori.w  #$807d, d0
00005194  asr.b  d0, d2
00005196  ; data: 0xa0, 0x07
00005198  ; data: 0x03, 0x3d
0000519A  ori.b  #$59, d3
0000519E  moveq  #$fe, d5
000051A0  ; data: 0xaa, 0x02
000051A2  ; data: 0xbf, 0xff
000051A4  dc.w   $ff5c
000051A6  ori.b  #$0, d0
000051AA  or.l   d2, $0.w
000051AE  or.b   $51df(pc, a1.w), d0
000051B2  bra.b  $51cf
000051B4  ; data: 0x00, 0x7e
000051B6  ori.b  #$f8, d0
000051BA  moveq  #$b, d0
000051BC  addq.b #$1, d5
000051BE  ; data: 0xbf, 0xff
000051C0  ; data: 0xff, 0xfa
000051C2  ori.b  #$0, d0
000051C6  clr.b  (a0)
000051C8  dc.w   $413b
000051CA  and.b  d3, d0
000051CC  ror.b  #$8, d6
000051CE  movea.l $72(a4, d0.w), a0
000051D2  ; data: 0x00, 0x0c
000051D4  ; data: 0x04, 0xfe
000051D6  dc.w   $fa00
000051D8  cmp.w  (a3), d1
000051DA  ; data: 0x1f, 0xff
000051DC  ; data: 0xff, 0xbe
000051DE  ori.b  #$0, d0
000051E2  ori.b  #$bf, d0
000051E6  and.b  d3, d0
000051E8  dc.w   $f00e
000051EA  ori.w  #$44, d2
000051EE  ; data: 0x00, 0x0e
000051F0  ; data: 0x2d, 0x7e
000051F2  dc.w   $fcf1
000051F4  move.w d4, d0
000051F6  ; data: 0x3f, 0xff
000051F8  ; data: 0xf7, 0xe0
000051FA  ori.b  #$0, d0
000051FE  move.l -(a1), d0
00005200  ; data: 0xb5, 0xff
00005202  lsr.w  $6(a0, a2.w)
00005206  ori.b  #$e0, (a6)+
0000520A  ; data: 0x00, 0x0f
0000520C  move.b #$f4, (a3)+
00005210  dc.w   $f002
00005212  ; data: 0x3f, 0xff
00005214  ; data: 0xf5, 0xb4
00005216  ori.b  #$0, d0
0000521A  ; data: 0x10, 0x79
0000521C  ; data: 0xd3, 0xff
0000521E  roxl.w $186.w
00005222  ; data: 0x14, 0x78
00005224  negx.w d0
00005226  ori.w  #$8fe8, d0
0000522A  ; data: 0x7f, 0xf8
0000522C  dc.w   $f600
00005232  ori.b  #$0, d0
00005236  ; data: 0x12, 0xfe
00005238  ; data: 0x09, 0xff
0000523A  roxl.w $383(a6)
0000523E  sub.w  d4, ([$e005, a6.w], $b734)
00005246  ; data: 0x1f, 0xdc
00005248  dc.w   $fa00
0000524A  ; data: 0x1f, 0xff
0000524C  dc.w   $eff0
0000524E  ori.b  #$0, d0
00005252  ; data: 0x0f, 0xfc
00005254  ; data: 0x04, 0xff
00005256  dc.w   $ebc3
00005258  move.l -$4fc7(a1), (a3)
0000525C  ; data: 0xf1, 0x1c
0000525E  dc.w   $f006
00005260  cmp.w  a0, d7
00005262  sle.b  (a6)+
00005264  ; data: 0xfd, 0x00
00005266  ; data: 0x7f, 0xff
00005268  adda.w d0, a1
0000526A  ori.b  #$0, d0
0000526E  ; data: 0x07, 0xfe
00005270  ; data: 0xa3, 0xff
00005272  ; data: 0xee, 0xdb
00005274  ; data: 0xb7, 0xbb
00005276  asr.b  #$8, d3
00005278  ror.b  d5, d4
0000527A  move.l (a7)+, (a4)
0000527C  add.l  d0, -(a3)
0000527E  ble.b  $520f
00005280  ror.b  #$5, d0
00005282  ; data: 0xff, 0xdf
00005284  asl.w  #$3, d0
00005286  ori.b  #$0, d0
0000528A  ; data: 0x03, 0xff
0000528C  ; data: 0xc0, 0x7f
0000528E  ; data: 0xff, 0xcf
00005290  dc.w   $f05c
00005292  asr.b  #$4, d0
00005294  ; data: 0xf9, 0x09
00005296  rol.l  #$3, d7
00005298  or.b   d4, (a6)+
0000529A  exg.l  d4, a7
0000529C  dc.w   $f735
0000529E  ; data: 0xff, 0xbf
000052A0  asr.b  #$5, d0
000052A2  ori.b  #$0, d0
000052A6  ; data: 0x03, 0xbb
000052A8  ; data: 0xac, 0x3f
000052AA  ; data: 0xff, 0x8f
000052AC  cmpi.l #$c020df81, (a7)+
000052B2  lsl.w  (a6)+
000052B4  addi.b #$cf, -$5084(a7)
000052BA  ; data: 0x7f, 0xff
000052BC  dc.w   $ecc0
000052BE  ori.b  #$0, d0
000052C2  ; data: 0x01, 0xff
000052C4  dc.w   $fe1f
000052C6  ; data: 0xf7, 0xee
000052C8  negx.w -$1fec(a7)
000052CC  ; data: 0xac, 0xca
000052CE  dc.w   $fccf
000052D0  ; data: 0x0c, 0x0a
000052D2  ; data: 0x42, 0xff
000052D4  ; data: 0x8e, 0x7e
000052D6  ; data: 0xff, 0xff
000052D8  asl.l  #$1, d0
000052DA  ori.b  #$0, d0
000052DE  ; data: 0x00, 0xbb
000052E0  dc.w   $fe9f
000052E2  ; data: 0xef, 0xfe
000052E4  ; data: 0x04, 0xef
000052E6  dc.w   $f21f
000052E8  ble.b  $5354
000052EA  add.b  d2, d6
000052EC  move.w a6, d7
000052EE  and.w  $536f(pc, d7.w), d0
000052F2  ; data: 0xff, 0xdf
000052F4  dc.w   $f600
000052FA  ori.b  #$f, (a3)
000052FE  ; data: 0x1e, 0x3e
00005300  ; data: 0x03, 0x7f
00005302  dc.w   $f83f
00005304  add.l  d4, d7
00005306  dc.w   $ff51
00005308  moveq  #$1f, d6
0000530A  ; data: 0xd0, 0x7f
0000530C  moveq  #$ff, d4
0000530E  ; data: 0xff, 0xff
00005310  and.b  d0, d3
00005312  ori.b  #$0, d0
00005316  ori.b  #$86, (a7)+
0000531A  ; data: 0xb8, 0xbf
0000531C  ; data: 0x00, 0xff
0000531E  dc.w   $fabf
00005320  roxl.b #$5, d6
00005322  ; data: 0xe6, 0xfa
00005324  nbcd.b $f0af84ff.l
0000532A  ; data: 0xff, 0xdf
0000532C  dc.w   $fc00
0000532E  ori.b  #$0, d0
00005332  ; data: 0x00, 0x3f
00005334  addx.b -(a0), -(a3)
00005336  dc.w   $63ff
00005338  ; data: 0xc0, 0xff
0000533A  ; data: 0xf3, 0x7f
0000533C  lsl.b  d2, d7
0000533E  sle.b  $19(a0, a4.w)
00005342  cmpa.w -$1(a1, d0.w), a0
00005346  ; data: 0xff, 0xf7
00005348  dc.w   $f000
0000534A  ori.b  #$0, d0
0000534E  ori.b  #$94, (a7)+
00005352  move.w ([a5], d7.l, $2dbffb1f), $f21.w
0000535C  negx.w d4
0000535E  dc.w   $f8a0
00005360  ; data: 0x9d, 0xff
00005362  dc.w   $ff7b
00005364  nbcd.b d0
00005366  ori.b  #$0, d0
0000536A  ; data: 0x00, 0x0f
0000536C  ; data: 0xf1, 0xc0
0000536E  ; data: 0x1a, 0x3e
00005370  move.w (a7)+, d4
00005372  ; data: 0xf9, 0xde
00005374  ; data: 0xfd, 0xaf
00005376  move.b ([]), -(a1)
0000537A  ; data: 0xff, 0x40
0000537C  ; data: 0x33, 0xff
0000537E  ; data: 0xff, 0xfe
00005380  ; data: 0xa0, 0x00
00005382  ori.b  #$0, d0
00005386  ori.b  #$91, d7
0000538A  subi.l #$120ebdeb, $7fde.w
00005392  addi.b #$88, (a6)
00005396  move.w d0, (a5)
00005398  ; data: 0x57, 0xff
0000539A  ; data: 0xff, 0xfc
0000539C  negx.b d0
0000539E  ori.b  #$0, d0
000053A2  ori.b  #$0, d2
000053A6  move.b $220f.w, -$9(a6)
000053AC  ; data: 0xfb, 0xff
000053AE  clr.w  -(a6)
000053B0  bset.b d1, d4
000053B2  move.w d0, $fff(a6)
000053B6  ; data: 0xff, 0xfe
000053B8  or.b   d0, d0
000053BA  ori.b  #$0, d0
000053BE  ori.b  #$a4, d1
000053C2  move.b -(a4), d2
000053C4  subq.l #$8, a7
000053C6  ; data: 0xf7, 0xff
000053C8  ; data: 0x8f, 0xff
000053CA  ; data: 0xa5, 0x10
000053CC  move.l d6, -(a0)
000053CE  move.l -(a3), (a5)
000053D0  ; data: 0x5f, 0xff
000053D2  ; data: 0xff, 0xd5
000053D4  ori.b  #$0, d0
000053D8  ori.b  #$0, d0
000053DC  ; data: 0xff, 0x80
000053DE  ; data: 0x0e, 0xf8
000053E0  ; data: 0x06, 0xff
000053E2  ; data: 0xff, 0xfe
000053E4  bset.b d1, $d940.w
000053E8  move.l -$19(a7, d7.w), d6
000053EC  ; data: 0xbf, 0xff
000053EE  dc.w   $fef9
000053F0  ori.b  #$0, d0
000053F4  ori.b  #$0, d0
000053F8  ; data: 0x7f, 0xa0
000053FA  bchg.b d2, $7cfc07f3(invalid.w)
00005402  ; data: 0xc4, 0x48
00005404  addq.w #$5, (a2)+
00005406  divs.w -(a5), d5
00005408  ; data: 0x7f, 0xff
0000540A  dc.w   $fa6e
0000540C  ori.b  #$0, d0
00005410  ori.b  #$0, d0
00005414  ; data: 0x3f, 0xf4
00005416  ori.w  #$b8f0, (a2)
0000541A  ; data: 0xbb, 0xfe
0000541C  ; data: 0x0b, 0xfa
0000541E  move.l #$7c07c562, d1
00005424  ; data: 0xba, 0xff
00005426  dc.w   $f290
00005428  ori.b  #$0, d0
0000542C  ori.b  #$0, d0
00005430  ; data: 0x1f, 0xeb
00005432  bchg.b d2, ([, d4.l * 8])
00005436  ; data: 0x5f, 0xfe
00005438  ; data: 0x77, 0xfc
0000543A  ; data: 0x00, 0x3e
0000543C  move.w d3, d7
0000543E  divs.w d4, d3
00005440  ; data: 0x41, 0xff
00005442  ; data: 0xeb, 0xc8
00005444  ori.b  #$0, d0
00005448  ori.b  #$0, d0
0000544C  ; data: 0x0f, 0xff
0000544E  or.b   d2, d4
00005450  ; data: 0xf1, 0x3b
00005452  or.w   (a2)+, d0
00005454  adda.l (a0), a7
00005456  ; data: 0x00, 0x3c
00005458  ; data: 0x0e, 0x00
0000545A  ; data: 0x2f, 0xce
0000545C  ; data: 0xf1, 0xff
0000545E  add.l  -(a0), d5
00005460  ori.b  #$0, d0
00005464  ori.b  #$0, d0
00005468  ; data: 0x07, 0xfb
0000546A  roxr.w #$4, d5
0000546C  ; data: 0x50, 0x3b
0000546E  roxr.l #$8, d0
00005470  move.w (a0), $1c(a7, d0.w)
00005474  andi.l #$efd7fdff, d0
0000547A  subx.b d0, d0
0000547C  ori.b  #$0, d0
00005480  ori.b  #$0, d0
00005484  ; data: 0x03, 0xff
00005486  negx.b d0
00005488  ; data: 0x79, 0x37
0000548A  ; data: 0xa0, 0x70
0000548C  move.b d4, -(a7)
0000548E  btst.l d0, d0
00005490  dc.w   $4506
00005492  ; data: 0x8f, 0xff
00005494  ; data: 0xff, 0xff
00005496  asl.b  #$7, d0
00005498  ori.b  #$0, d0
0000549C  ori.b  #$0, d0
000054A0  ; data: 0x01, 0xfb
000054A2  and.b  d0, d7
000054A4  dc.w   $fc45
000054A6  move.b $2(a3, d1.l), (a0)+
000054AA  ori.b  #$ea, -(a0)
000054AE  divs.w ([$f48054b0]), d7
000054B6  ori.b  #$0, d0
000054BA  ori.b  #$6f, d0
000054BE  sbcd.b d0, d1
000054C0  moveq  #$2, d1
000054C2  bset.b d7, $19080075.l
000054C8  ; data: 0x39, 0xff
000054CA  ; data: 0x2f, 0xf0
000054CC  ; data: 0xff, 0xff
000054CE  dc.w   $fc00
000054D0  ori.b  #$0, d0
000054D4  ori.b  #$0, d0
000054D8  ; data: 0x00, 0x3f
000054DA  dc.w   $f860
000054DC  move.w d0, d7
000054DE  bchg.b d2, (a4)
000054E0  ; data: 0xa2, 0x00
000054E2  subi.l #$ba1f97f9, -$1(a2)
000054EA  addq.b #$4, d0
000054EC  ori.b  #$0, d0
000054F0  ori.b  #$0, d0
000054F4  ori.b  #$30, (a7)+
000054F8  subi.b #$a, d0
000054FC  moveq  #$0, d0
000054FE  bchg.b d0, -(a0)
00005500  move.w (a7)+, d0
00005502  cmpa.l #$fffec000, a7
00005508  ori.b  #$0, d0
0000550C  ori.b  #$0, d0
00005510  ; data: 0x00, 0x0f
00005512  ; data: 0xff, 0x3c
00005514  cmpi.b #$10, d0
00005518  move.w d0, (a0)
0000551A  addq.l #$4, a4
0000551C  ori.b  #$ff, (a7)+
00005520  ; data: 0xff, 0xfd
00005522  addq.b #$8, d0
00005524  ori.b  #$0, d0
00005528  ori.b  #$0, d0
0000552C  ori.b  #$8f, d3
00005530  nbcd.b d0
00005532  ori.b  #$60, d1
00005536  ori.w  #$e, (a0)+
0000553A  ; data: 0xff, 0xfb
0000553C  ; data: 0xff, 0xff
0000553E  and.b  d0, d0
00005540  ori.b  #$0, d0
00005544  ori.b  #$0, d0
00005548  ori.b  #$b7, d1
0000554C  dc.w   $ff70
0000554E  ori.w  #$e012, d1
00005552  negx.b d0
00005554  muls.w (a5), d2
00005556  ; data: 0xff, 0xf7
00005558  ; data: 0xff, 0xfd
0000555A  or.b   d0, d0
0000555C  ori.b  #$0, d0
00005560  ori.b  #$0, d0
00005564  ori.b  #$fc, d0
00005568  asl.w  d7, d0
0000556A  ori.w  #$e060, d0
0000556E  ori.b  #$ff, d0
00005572  ; data: 0xff, 0xff
00005574  ; data: 0xff, 0xff
00005576  ori.b  #$0, d0
0000557A  ori.b  #$0, d0
0000557E  ori.b  #$0, d0
00005582  ; data: 0x3f, 0xff
00005584  dc.w   $f0a0
00005586  ; data: 0x00, 0x4c
00005588  cmp.b  d0, d0
0000558A  move.w (a4), -(a3)
0000558C  ; data: 0x15, 0xf7
0000558E  ; data: 0xff, 0xff
00005590  ; data: 0xff, 0xfc
00005592  ori.b  #$0, d0
00005596  ori.b  #$0, d0
0000559A  ori.b  #$0, d0
0000559E  ; data: 0x0f, 0xff
000055A0  ; data: 0xfd, 0xe0
000055A2  bset.b d0, $78c0(a0)
000055A6  ; data: 0x1d, 0x89
000055A8  ; data: 0xcf, 0xff
000055AA  ; data: 0xfb, 0xff
000055AC  dc.w   $feb0
000055AE  ori.b  #$0, d0
000055B2  ori.b  #$0, d0
000055B6  ori.b  #$0, d0
000055BA  ; data: 0x07, 0xff
000055BC  dc.w   $feb0
000055BE  andi.b #$a0, -(a2)
000055C2  bchg.b d1, ([$fdfffd60])
000055CA  ori.b  #$0, d0
000055CE  ori.b  #$0, d0
000055D2  ori.b  #$0, d0
000055D6  ; data: 0x01, 0xff
000055D8  ; data: 0xff, 0xfc
000055DA  asl.l  d1, d1
000055DC  ; data: 0xfd, 0xdd
000055DE  ; data: 0x53, 0xbf
000055E0  ; data: 0x3f, 0xff
000055E2  ; data: 0xff, 0xdf
000055E4  ; data: 0xfd, 0x80
000055E6  ori.b  #$0, d0
000055EA  ori.b  #$0, d0
000055EE  ori.b  #$0, d0
000055F2  ; data: 0x00, 0xff
000055F4  ; data: 0xaf, 0xff
000055F6  ; data: 0xa1, 0x83
000055F8  dc.w   $feeb
000055FA  or.w   d2, ([$f7ffd700])
00005602  ori.b  #$0, d0
00005606  ori.b  #$0, d0
0000560A  ori.b  #$0, d0
0000560E  ; data: 0x00, 0x3f
00005610  ; data: 0xdf, 0xff
00005612  dc.w   $f880
00005614  ; data: 0xfd, 0xff
00005616  ; data: 0xef, 0xc3
00005618  ; data: 0xcf, 0xff
0000561A  ; data: 0xff, 0xff
0000561C  dc.w   $fc00
0000561E  ori.b  #$0, d0
00005622  ori.b  #$0, d0
00005626  ori.b  #$0, d0
0000562A  ; data: 0x00, 0x0f
0000562C  ror.l  d7, d7
0000562E  ; data: 0xf9, 0xff
00005630  ; data: 0xbf, 0xff
00005632  suba.l -(a7), a6
00005634  ; data: 0xef, 0xf5
00005636  ; data: 0xff, 0xff
00005638  add.b  d0, d0
0000563A  ori.b  #$0, d0
0000563E  ori.b  #$0, d0
00005642  ori.b  #$0, d0
00005646  ori.b  #$c7, d3
0000564A  ; data: 0xff, 0xff
0000564C  ; data: 0xef, 0xff
0000564E  ; data: 0xcb, 0xff
00005650  ; data: 0xff, 0xff
00005652  ; data: 0xff, 0xff
00005654  and.b  d0, d0
00005656  ori.b  #$0, d0
0000565A  ori.b  #$0, d0
0000565E  ori.b  #$0, d0
00005662  ori.b  #$fb, d0
00005666  ; data: 0xff, 0xff
00005668  ; data: 0xff, 0xff
0000566A  ; data: 0xff, 0xff
0000566C  ; data: 0xff, 0x7f
0000566E  ; data: 0xff, 0xff
00005670  ori.b  #$0, d0
00005674  ori.b  #$0, d0
00005678  ori.b  #$0, d0
0000567C  ori.b  #$0, d0
00005680  ; data: 0x3f, 0xfd
00005682  adda.l (a7), a7
00005684  ; data: 0xff, 0x7f
00005686  ; data: 0xff, 0xfe
00005688  ; data: 0xff, 0xff
0000568A  ; data: 0xff, 0xfc
0000568C  ori.b  #$0, d0
00005690  ori.b  #$0, d0
00005694  ori.b  #$0, d0
00005698  ori.b  #$0, d0
0000569C  ; data: 0x07, 0xfa
0000569E  cmpa.l -$141(a7), a5
000056A2  ; data: 0xbf, 0xff
000056A4  ; data: 0x5f, 0xff
000056A6  ; data: 0xff, 0xe0
000056A8  ori.b  #$0, d0
000056AC  ori.b  #$0, d0
000056B0  ori.b  #$0, d0
000056B4  ori.b  #$0, d0
000056B8  ; data: 0x01, 0xff
000056BA  ; data: 0xff, 0xf7
000056BC  ; data: 0x7d, 0x77
000056BE  ; data: 0xff, 0xfd
000056C0  ; data: 0xff, 0xff
000056C2  ; data: 0xff, 0x80
000056C4  ori.b  #$0, d0
000056C8  ori.b  #$0, d0
000056CC  ori.b  #$0, d0
000056D0  ori.b  #$0, d0
000056D4  ; data: 0x00, 0x3f
000056D6  ; data: 0xff, 0xeb
000056D8  ; data: 0xfb, 0xfb
000056DA  ; data: 0xff, 0xff
000056DC  ; data: 0xff, 0xff
000056DE  dc.w   $fc00
000056E0  ori.b  #$0, d0
000056E4  ori.b  #$0, d0
000056E8  ori.b  #$0, d0
000056EC  ori.b  #$0, d0
000056F0  ori.b  #$ff, d7
000056F4  ; data: 0xff, 0xff
000056F6  ; data: 0xff, 0xff
000056F8  ; data: 0xff, 0xff
000056FA  asr.b  #$8, d0
000056FC  ori.b  #$0, d0
00005700  ori.b  #$0, d0
00005704  ori.b  #$0, d0
00005708  ori.b  #$0, d0
0000570C  ori.b  #$ff, d0
00005710  ; data: 0xff, 0xff
00005712  ; data: 0xff, 0xff
00005714  ; data: 0xff, 0xff
00005716  ori.b  #$0, d0
0000571A  ori.b  #$0, d0
0000571E  ori.b  #$0, d0
00005722  ori.b  #$0, d0
00005726  ori.b  #$0, d0
0000572A  ; data: 0x0f, 0xff
0000572C  ; data: 0xf7, 0xff
0000572E  ; data: 0xff, 0xff
00005730  ; data: 0xff, 0xf0
00005732  ori.b  #$0, d0
00005736  ori.b  #$0, d0
0000573A  ori.b  #$0, d0
0000573E  ori.b  #$0, d0
00005742  ori.b  #$0, d0
00005746  ; data: 0x00, 0xff
00005748  ; data: 0xff, 0xff
0000574A  ; data: 0xff, 0xff
0000574C  ; data: 0xff, 0x00
0000574E  ori.b  #$0, d0
00005752  ori.b  #$0, d0
00005756  ori.b  #$0, d0
0000575A  ori.b  #$0, d0
0000575E  ori.b  #$0, d0
00005762  ori.b  #$ff, d7
00005766  ; data: 0xff, 0xff
00005768  ori.b  #$0, d0
0000576C  ori.b  #$0, d0
00005770  ori.b  #$0, d0
00005774  ori.b  #$0, d0
00005778  ori.b  #$0, d0
0000577C  ori.b  #$0, d0
00005780  ; data: 0x07, 0xff
00005782  ; data: 0xff, 0x80
00005784  ori.b  #$0, d0
00005788  ori.b  #$0, d0
0000578C  ori.b  #$0, d0
00005790  ori.b  #$0, d0
00005794  ori.b  #$0, d0
00005798  ori.b  #$0, d0
0000579C  ; data: 0x07, 0xff
0000579E  ; data: 0xff, 0xe0
000057A0  ori.b  #$0, d0
000057A4  ori.b  #$0, d0
000057A8  ori.b  #$0, d0
000057AC  ori.b  #$0, d0
000057B0  ori.b  #$0, d0
000057B4  ori.b  #$7, d0
000057B8  or.b   d3, d0
000057BA  suba.l -$2000(a7), a7
000057BE  ori.b  #$0, d0
000057C2  ori.b  #$0, d0
000057C6  ori.b  #$0, d0
000057CA  ori.b  #$0, d0
000057CE  ori.b  #$0, d0
000057D2  ; data: 0x00, 0xf0
000057D4  ; data: 0x00, 0x0b
000057D6  and.w  d5, d0
000057D8  ; data: 0x7f, 0x00
000057DA  ori.b  #$0, d0
000057DE  ori.b  #$0, d0
000057E2  ori.b  #$0, d0
000057E6  ori.b  #$0, d0
000057EA  ori.b  #$0, d0
000057EE  btst.l d7, d0
000057F0  ori.b  #$8, d1
000057F4  ; data: 0xff, 0xf0
000057F6  ori.b  #$0, d0
000057FA  ori.b  #$0, d0
000057FE  ori.b  #$0, d0
00005802  ori.b  #$0, d0
00005806  ori.b  #$0, d0
0000580A  dc.w   $f000
0000580C  ori.b  #$1, d0
00005810  ; data: 0x7f, 0xff
00005812  ori.b  #$0, d0
00005816  ori.b  #$0, d0
0000581A  ori.b  #$0, d0
0000581E  ori.b  #$0, d0
00005822  ori.b  #$7, d0
00005826  ori.b  #$0, d0
0000582A  ori.b  #$bf, (a0)+
0000582E  asr.b  #$8, d0
00005830  ori.b  #$0, d0
00005834  ori.b  #$0, d0
00005838  ori.b  #$0, d0
0000583C  ori.b  #$0, d0
00005840  ori.b  #$6, $0.w
00005846  ; data: 0x00, 0x7d
00005848  ; data: 0x07, 0xff
0000584A  dc.w   $fc00
0000584C  ori.b  #$0, d0
00005850  ori.b  #$0, d0
00005854  ori.b  #$0, d0
00005858  ori.b  #$0, d0
0000585C  bclr.b d0, d0
0000585E  addi.b #$0, d0
00005862  ; data: 0x00, 0xe0
00005864  ; data: 0xe3, 0xff
00005866  ; data: 0xff, 0x80
00005868  ori.b  #$0, d0
0000586C  ori.b  #$0, d0
00005870  ori.b  #$0, d0
00005874  ori.b  #$0, d0
00005878  addi.b #$0, d0
0000587C  ori.b  #$4, d0
00005880  ; data: 0x53, 0xff
00005882  ; data: 0xff, 0xe0
00005884  ori.b  #$0, d0
00005888  ori.b  #$0, d0
0000588C  ori.b  #$0, d0
00005890  ori.b  #$0, d0
00005894  move.w d0, d0
00005896  ori.b  #$0, d0
0000589A  ori.b  #$ff, d0
0000589E  ; data: 0xff, 0xfc
000058A0  ori.b  #$0, d0
000058A4  ori.b  #$0, d0
000058A8  ori.b  #$0, d0
000058AC  ori.b  #$0, d0
000058B0  and.b  d0, d0
000058B2  ori.l  #$0, d0
000058B8  ori.w  #$5fff, d5
000058BC  ori.b  #$0, d0
000058C0  ori.b  #$0, d0
000058C4  ori.b  #$0, d0
000058C8  ori.b  #$3, d0
000058CC  ori.b  #$e0, d0
000058D0  ori.b  #$0, d0
000058D4  ori.b  #$ff, d3
000058D8  and.b  d0, d0
000058DA  ori.b  #$0, d0
000058DE  ori.b  #$0, d0
000058E2  ori.b  #$0, d0
000058E6  ; data: 0x00, 0x08
000058E8  ori.b  #$70, d0
000058EC  ori.b  #$0, d0
000058F0  ori.b  #$ff, d0
000058F4  dc.w   $f000
000058F6  ori.b  #$0, d0
000058FA  ori.b  #$0, d0
000058FE  ori.b  #$0, d0
00005902  ori.b  #$0, -(a0)
00005906  ori.w  #$18, (a0)
0000590A  ori.b  #$0, d0
0000590E  moveq  #$ff, d4
00005910  dc.w   $fc00
00005912  ori.b  #$0, d0
00005916  ori.b  #$0, d0
0000591A  ori.b  #$0, d0
0000591E  ; data: 0x00, 0xc6
00005920  ori.b  #$0, d0
00005924  ori.w  #$0, sr
00005928  ori.b  #$7f, d0
0000592C  ; data: 0xff, 0x00
0000592E  ori.b  #$0, d0
00005932  ori.b  #$0, d0
00005936  ori.b  #$0, d0
0000593A  movep.w d0, $0(a4)
0000593E  ori.b  #$b8, d0
00005942  ori.b  #$0, d0
00005946  ; data: 0x20, 0x3f
00005948  ; data: 0xff, 0x80
0000594A  ori.b  #$0, d0
0000594E  ori.b  #$0, d0
00005952  ori.b  #$0, d0
00005956  addi.b #$0, (a0)
0000595A  ori.b  #$48, d0
0000595E  ori.b  #$5, d0
00005962  move.l (a7)+, -$20(a0)
00005966  ori.b  #$0, d0
0000596A  ori.b  #$0, d0
0000596E  ori.b  #$0, d0
00005972  btst.b #$0, d0
00005976  ori.b  #$0, d0
0000597A  ori.b  #$0, d0
0000597E  and.l  (a7)+, d0
00005980  ; data: 0xff, 0xf0
00005982  ori.b  #$0, d0
00005986  ori.b  #$0, d0
0000598A  ori.b  #$0, d0
0000598E  move.w d0, d4
00005990  ori.b  #$0, d0
00005994  ori.b  #$0, d0
00005998  ori.b  #$4f, d0
0000599C  ; data: 0xff, 0xfc
0000599E  ori.b  #$0, d0
000059A2  ori.b  #$0, d0
000059A6  ori.b  #$0, d0
000059AA  dc.w   $fc00
000059AC  ori.b  #$0, d0
000059B0  ori.b  #$0, d0
000059B4  ori.b  #$f, d1
000059B8  ; data: 0xff, 0xff
000059BA  ori.b  #$0, d0
000059BE  ori.b  #$0, d0
000059C2  ori.b  #$1, d0
000059C6  dc.w   $fc00
000059C8  ori.b  #$0, $1f80.l
000059D0  ori.b  #$47, d3
000059D4  ; data: 0xff, 0xff
000059D6  or.b   d0, d0
000059D8  ori.b  #$0, d0
000059DC  ori.b  #$0, d0
000059E0  ori.b  #$0, d3
000059E4  ; data: 0x00, 0x0a
000059E6  dc.w   $f000
000059E8  ori.b  #$f0, d0
000059EC  move.w d3, d0
000059EE  dc.w   $f007
000059F0  ; data: 0xff, 0xff
000059F2  and.b  d0, d0
000059F4  ori.b  #$0, d0
000059F8  ori.b  #$0, d0
000059FC  ; data: 0x00, 0x0f
000059FE  dc.w   $fa00
00005A00  ori.w  #$7800, (a5)
00005A04  ori.b  #$80, d1
00005A08  move.l d1, d4
00005A0A  dc.w   $f801
00005A0C  ; data: 0xff, 0xff
00005A0E  dc.w   $f000
00005A10  ori.b  #$0, d0
00005A14  ori.b  #$0, d0
00005A18  ori.b  #$0, (a3)
00005A1C  ori.l  #$f800000f, -$2c0(a3)
00005A24  bset.b d0, d7
00005A26  dc.w   $f800
00005A28  ; data: 0xff, 0xff
00005A2A  dc.w   $fc00
00005A2C  ori.b  #$0, d0
00005A30  ori.b  #$0, d0
00005A34  ori.b  #$0, -(a7)
00005A38  bchg.b d0, (a5)
00005A3A  addq.b #$4, d0
00005A3C  ; data: 0x00, 0x0f
00005A3E  dc.w   $fa80
00005A40  bset.b d0, -(a5)
00005A42  ; data: 0xf9, 0x00
00005A44  ; data: 0xbf, 0xff
00005A46  dc.w   $fe00
00005A48  ori.b  #$0, d0
00005A4C  ori.b  #$0, d0
00005A50  ; data: 0x00, 0x4f
00005A52  or.b   d0, d0
00005A54  ; data: 0x06, 0xff
00005A56  cmp.b  (a0)+, d4
00005A58  ori.b  #$0, (a7)+
00005A5C  ; data: 0x00, 0xe7
00005A5E  dc.w   $f800
00005A60  ; data: 0xdf, 0xff
00005A62  ; data: 0xff, 0x00
00005A64  ori.b  #$0, d0
00005A68  ori.b  #$0, d0
00005A6C  bchg.b d0, -$8000(a7)
00005A70  ; data: 0x07, 0x7f
00005A72  ; data: 0xa0, 0x18
00005A74  btst.l d1, d7
00005A76  addq.l #$5, $df(a2)
00005A7A  dc.w   $f800
00005A7C  ; data: 0xff, 0xff
00005A7E  ; data: 0xff, 0x80
00005A80  ori.b  #$0, d0
00005A84  ori.b  #$0, d0
00005A88  andi.b #$0, ([$c008011f])
00005A92  dc.w   $fd55
00005A94  ; data: 0x00, 0x7f
00005A96  dc.w   $f88c
00005A98  ; data: 0xff, 0xff
00005A9A  ; data: 0xff, 0xc0
00005A9C  ori.b  #$0, d0
00005AA0  ori.b  #$0, d0
00005AA4  subi.b #$0, (a0)+
00005AA8  ; data: 0x17, 0xff
00005AAA  and.b  d0, d0
00005AAC  ; data: 0x01, 0xff
00005AAE  ; data: 0xda, 0xbe
00005AB0  ; data: 0x80, 0x3f
00005AB2  ; data: 0xfb, 0xe6
00005AB4  ; data: 0x3f, 0xff
00005AB6  ; data: 0xff, 0xe0
00005AB8  ori.b  #$0, d0
00005ABC  ori.b  #$0, d0
00005AC0  ; data: 0x08, 0x00
00005AC2  btst.l d0, d0
00005AC4  ; data: 0xbf, 0xff
00005AC6  dc.w   $fc00
00005AC8  ; data: 0x01, 0xff
00005ACA  ; data: 0xfd, 0xff
00005ACC  ; data: 0x80, 0x0f
00005ACE  ; data: 0xf3, 0x02
00005AD0  ; data: 0x7f, 0xff
00005AD2  ; data: 0xff, 0xf0
00005AD4  ori.b  #$0, d0
00005AD8  ori.b  #$0, d0
00005ADC  move.b d0, d0
00005ADE  negx.b d0
00005AE0  ; data: 0x7f, 0x7d
00005AE2  moveq  #$0, d4
00005AE4  ; data: 0x01, 0xff
00005AE6  dc.w   $fcbf
00005AE8  negx.b d0
00005AEA  asr.b  #$1, d0
00005AEC  ; data: 0x77, 0xfd
00005AEE  ; data: 0xff, 0xf8
00005AF0  ori.b  #$0, d0
00005AF4  ori.b  #$0, d0
00005AF8  move.l d1, d0
00005AFA  ori.b  #$3f, d0
00005AFE  dc.w   $f801
00005B00  ; data: 0x07, 0xff
00005B02  dc.w   $fcfe
00005B04  and.b  d6, d0
00005B06  ori.b  #$ff, d0
00005B0A  ; data: 0xff, 0xfc
00005B0C  ori.b  #$0, d0
00005B10  ori.b  #$0, d0
00005B14  negx.b d0
00005B16  ori.b  #$95, d0
00005B1A  dc.w   $fc07
00005B1C  ; data: 0x87, 0xff
00005B1E  dc.w   $ff6e
00005B20  ; data: 0x00, 0x0f
00005B22  or.b   d0, d0
00005B24  bset.b d3, ([])
00005B2C  ori.b  #$0, d0
00005B30  and.b  d7, d0
00005B32  ori.b  #$8f, $3f(a0, a7.l)
00005B38  ; data: 0xff, 0xff
00005B3A  dc.w   $f8bc
00005B3C  ; data: 0x00, 0x0f
00005B3E  and.b  d0, d0
00005B40  bset.b d7, -$1(a3)
00005B44  ori.b  #$0, d0
00005B48  ori.b  #$1, d0
00005B4C  and.b  d6, d0
00005B4E  ; data: 0x80, 0x7d
00005B50  ; data: 0xff, 0xc7
00005B52  ; data: 0xff, 0xf7
00005B54  ; data: 0xff, 0xff
00005B56  ; data: 0xfb, 0xf8
00005B58  ; data: 0x00, 0xcf
00005B5A  and.b  d0, d0
00005B5C  ; data: 0x75, 0xf7
00005B5E  ; data: 0xff, 0xff
00005B60  or.b   d0, d0
00005B62  ori.b  #$0, d0
00005B66  ori.b  #$6, d3
00005B6A  ; data: 0x00, 0xe7
00005B6C  ; data: 0xff, 0xe3
00005B6E  ; data: 0xff, 0xfb
00005B70  ; data: 0xff, 0xff
00005B72  add.l  d7, -(a0)
00005B74  move.b d7, -$4000(a0)
00005B78  ; data: 0x73, 0xff
00005B7A  ; data: 0xff, 0xff
00005B7C  and.b  d0, d0
00005B7E  ori.b  #$0, d0
00005B82  ori.b  #$0, d7
00005B86  bset.b d2, ([$ffffffff])
00005B8E  add.b  d7, (a0)+
00005B90  or.b   d0, d6
00005B92  ori.b  #$ff, d0
00005B96  ; data: 0xff, 0xdf
00005B98  asr.b  #$8, d0
00005B9A  ori.b  #$0, d0
00005B9E  ; data: 0x00, 0x0f
00005BA0  ori.b  #$fd, d0
00005BA4  ; data: 0xff, 0xff
00005BA6  ; data: 0xff, 0xff
00005BA8  ; data: 0xff, 0xff
00005BAA  dc.w   $ff68
00005BAC  moveq  #$0, d6
00005BAE  ori.b  #$ff, d0
00005BB2  ; data: 0xff, 0xef
00005BB4  dc.w   $f000
00005BB6  ori.b  #$0, d0
00005BBA  ori.b  #$0, (a6)
00005BBE  ; data: 0x0b, 0xff
00005BC0  ; data: 0xff, 0xff
00005BC2  ; data: 0xff, 0xff
00005BC4  ; data: 0xff, 0xff
00005BC6  dc.w   $fcf2
00005BC8  ; data: 0xff, 0xc0
00005BCA  ori.b  #$ff, d0
00005BCE  ; data: 0xdf, 0xff
00005BD0  dc.w   $f800
00005BD2  ori.b  #$0, d0
00005BD6  ori.b  #$0, $7fe(a4)
00005BDC  ; data: 0xff, 0xff
00005BDE  ; data: 0xff, 0xff
00005BE0  ; data: 0xff, 0xff
00005BE2  dc.w   $f838
00005BE4  ; data: 0x3f, 0xe0
00005BE6  ori.b  #$ff, d0
00005BEA  ; data: 0xbf, 0xff
00005BEC  dc.w   $fc00
00005BEE  ori.b  #$0, d0
00005BF2  ori.b  #$86, (a0)
00005BF6  ; data: 0x8f, 0xfe
00005BF8  ; data: 0xff, 0xff
00005BFA  ; data: 0xbf, 0xff
00005BFC  ; data: 0xff, 0x7f
00005BFE  asr.b  d2, d0
00005C00  ; data: 0x7b, 0xf0
00005C02  ori.b  #$ff, d0
00005C06  ; data: 0x9f, 0xff
00005C08  dc.w   $fc00
00005C0A  ori.b  #$0, d0
00005C0E  ori.b  #$83, -(a0)
00005C12  ; data: 0x7f, 0xfd
00005C14  ; data: 0xff, 0xff
00005C16  ; data: 0x3f, 0xf6
00005C18  ; data: 0xff, 0x8f
00005C1A  move.w -(a4), $1fbf(invalid.w)
00005C22  ; data: 0x0f, 0xff
00005C24  dc.w   $fe00
00005C26  ori.b  #$0, d0
00005C2A  ; data: 0x00, 0xc0
00005C2C  ori.w  #$dfff, (a7)
00005C30  ; data: 0xff, 0xff
00005C32  ; data: 0x3f, 0xf3
00005C34  ; data: 0xff, 0xff
00005C36  rol.w  -$1004(a6)
00005C3A  ori.b  #$ff, d0
00005C3E  divs.w (a16, a7.l * 8), d3
00005C42  ori.b  #$0, d0
00005C46  btst.l d0, d0
00005C48  ; data: 0x00, 0x0f
00005C4A  ; data: 0xff, 0xff
00005C4C  ; data: 0xff, 0x7e
00005C4E  ; data: 0x3f, 0xc1
00005C50  ; data: 0xff, 0x7f
00005C52  ; data: 0xde, 0xff
00005C54  adda.l #$1fff, a7
00005C5A  bset.b d1, $ff800000.l
00005C60  ori.b  #$4, d0
00005C64  ; data: 0x0b, 0x7f
00005C66  ; data: 0xff, 0xff
00005C68  ; data: 0xfe, 0x7d
00005C6A  move.w d1, $9ffffffe(invalid.w)
00005C72  ori.b  #$7e, d0
00005C76  ; data: 0x07, 0xfd
00005C78  ; data: 0xff, 0xc0
00005C7A  ori.b  #$0, d0
00005C7E  ori.b  #$ff, d0
00005C82  ; data: 0xff, 0xff
00005C84  dc.w   $fe31
00005C86  ; data: 0xff, 0xc3
00005C88  ; data: 0xff, 0xdb
00005C8A  ; data: 0xbf, 0xff
00005C8C  ; data: 0xff, 0xff
00005C8E  or.b   d0, d0
00005C90  subi.w #$3ff, $ffc0.w
00005C96  ori.b  #$0, d0
00005C9A  ori.b  #$ff, d4
00005C9E  ; data: 0xf7, 0xff
00005CA0  dc.w   $ff79
00005CA2  ; data: 0xff, 0xf3
00005CA4  ; data: 0xfd, 0xbb
00005CA6  cmpa.l -(a1), a7
00005CA8  ; data: 0xff, 0xff
00005CAA  and.b  d0, d0
00005CAC  ori.w  #$5ff, (a0)
00005CB0  ; data: 0xff, 0xe0
00005CB2  ori.b  #$0, d0
00005CB6  ; data: 0x08, 0x02
00005CB8  ; data: 0x0f, 0xff
00005CBA  ; data: 0xdf, 0xff
00005CBC  dc.w   $ff59
00005CBE  ; data: 0xff, 0xc7
00005CC0  dc.w   $fcf7
00005CC2  cmpa.l -(a2), a7
00005CC4  ; data: 0xff, 0xff
00005CC6  or.b   d0, d0
00005CC8  ori.b  #$ff, d3
00005CCC  ; data: 0xff, 0xf0
00005CCE  ori.b  #$0, d0
00005CD2  move.b (a0), d0
00005CD4  ; data: 0x17, 0xff
00005CD6  ; data: 0x7f, 0xff
00005CD8  dc.w   $ff59
00005CDA  ; data: 0xff, 0xc1
00005CDC  ; data: 0xfd, 0xae
00005CDE  cmpa.l $ffff.w, a7
00005CE2  and.b  d0, d0
00005CE4  ori.b  #$ff, d7
00005CE8  ; data: 0xff, 0xf8
00005CEA  ori.b  #$0, d0
00005CEE  ori.b  #$ff, d0
00005CF2  ; data: 0xff, 0xff
00005CF4  dc.w   $ff79
00005CF6  ; data: 0xff, 0x80
00005CF8  ; data: 0xff, 0x4e
00005CFA  cmpa.l $ffff.w, a7
00005CFE  asr.b  #$8, d0
00005D00  ori.b  #$ff, d7
00005D04  ; data: 0xff, 0xfc
00005D06  ori.b  #$0, d0
00005D0A  movea.l d0, a0
00005D0C  ; data: 0x17, 0xff
00005D0E  ; data: 0xff, 0xff
00005D10  dc.w   $fe7b
00005D12  ; data: 0xff, 0x8c
00005D14  ; data: 0xf7, 0xdf
00005D16  cmpa.l -$1(a0), a7
00005D1A  dc.w   $fc00
00005D1C  ; data: 0x00, 0x0f
00005D1E  ; data: 0x07, 0xff
00005D20  ; data: 0xff, 0xfe
00005D22  ori.b  #$0, d0
00005D26  ori.b  #$ff, d0
00005D2A  ; data: 0xff, 0xcf
00005D2C  ; data: 0xfd, 0xff
00005D2E  ; data: 0xff, 0x3d
00005D30  ; data: 0xff, 0x7f
00005D32  cmpa.l a4, a7
00005D34  ; data: 0xff, 0xff
00005D36  dc.w   $f000
00005D38  ori.b  #$ff, (a7)+
00005D3C  ; data: 0xff, 0xfe
00005D3E  ori.b  #$0, d0
00005D42  swap   d0
00005D44  ; data: 0x1f, 0xff
00005D46  ; data: 0xff, 0x1f
00005D48  ; data: 0xfd, 0xff
00005D4A  ; data: 0xff, 0x3c
00005D4C  ; data: 0xe5, 0xff
00005D4E  cmpa.l $ffff.w, a7
00005D52  asr.b  #$8, d0
00005D54  ori.b  #$ff, (a7)
00005D58  ; data: 0xff, 0xff
00005D5A  ori.b  #$0, d0
00005D5E  sub.b  -(a0), d0
00005D60  ; data: 0x3f, 0xff
00005D62  dc.w   $f8bf
00005D64  ; data: 0xff, 0xff
00005D66  ; data: 0xff, 0x1c
00005D68  ; data: 0xc2, 0x7f
00005D6A  cmpa.l #$ffffe000, a7
00005D70  ; data: 0x00, 0x0f
00005D72  ; data: 0x7f, 0xff
00005D74  ; data: 0xff, 0xff
00005D76  or.b   d0, d0
00005D78  ori.b  #$50, d0
00005D7C  ; data: 0x7f, 0xff
00005D7E  ; data: 0xf5, 0xff
00005D80  ; data: 0xef, 0xff
00005D82  ; data: 0xff, 0x8c
00005D84  ; data: 0x49, 0xbf
00005D86  ; data: 0xaf, 0xff
00005D88  ; data: 0xff, 0xff
00005D8A  abcd.b d0, d3
00005D8C  ori.b  #$ff, d6
00005D90  ; data: 0xff, 0xff
00005D92  and.b  d0, d0
00005D94  ori.b  #$b8, d1
00005D98  ; data: 0xff, 0xff
00005D9A  ; data: 0xdf, 0xff
00005D9C  ; data: 0xd4, 0xff
00005D9E  ; data: 0xff, 0xc1
00005DA0  ; data: 0x18, 0xff
00005DA2  ; data: 0x27, 0xdf
00005DA4  ; data: 0xff, 0xff
00005DA6  ; data: 0xc7, 0x80
00005DA8  ori.b  #$bf, d0
00005DAC  ; data: 0xff, 0xff
00005DAE  and.b  d0, d0
00005DB0  ori.b  #$5f, d2
00005DB4  ; data: 0xef, 0xff
00005DB6  ; data: 0xdf, 0xff
00005DB8  ; data: 0x41, 0xfd
00005DBA  ; data: 0xff, 0xe3
00005DBC  moveq  #$fb, d5
00005DBE  ; data: 0x07, 0xff
00005DC0  ; data: 0xff, 0xff
00005DC2  asl.l  #$3, d0
00005DC4  ori.b  #$7f, d0
00005DC8  ; data: 0xff, 0xff
00005DCA  asr.b  #$8, d0
00005DCC  ori.b  #$78, d0
00005DD0  ; data: 0xff, 0xff
00005DD2  ; data: 0xff, 0xff
00005DD4  ; data: 0xa3, 0xe1
00005DD6  ; data: 0xff, 0xff
00005DD8  ; data: 0xfd, 0xff
00005DDA  ; data: 0x1f, 0xff
00005DDC  ; data: 0xff, 0xff
00005DDE  asl.b  #$5, d0
00005DE0  ori.b  #$7f, d0
00005DE4  ; data: 0xff, 0xff
00005DE6  asr.b  #$8, d0
00005DE8  ori.b  #$55, d4
00005DEC  ; data: 0xff, 0xff
00005DEE  ; data: 0xff, 0xfd
00005DF0  rol.l  #$7, d3
00005DF2  ; data: 0xff, 0xfe
00005DF4  dc.w   $feff
00005DF6  ; data: 0x3f, 0xff
00005DF8  ; data: 0xff, 0xff
00005DFA  dc.w   $f000
00005DFC  ori.b  #$3f, d0
00005E00  ; data: 0xff, 0xff
00005E02  dc.w   $f000
00005E04  ori.b  #$e2, d0
00005E08  ; data: 0xff, 0xff
00005E0A  ; data: 0xff, 0xff
00005E0C  ; data: 0xf7, 0x0f
00005E0E  ; data: 0xff, 0xff
00005E10  ; data: 0xff, 0xff
00005E12  ; data: 0x3f, 0x3f
00005E14  ; data: 0xff, 0xfd
00005E16  ; data: 0xa8, 0x4f
00005E18  ori.b  #$f, d0
00005E1C  ; data: 0xff, 0xff
00005E1E  dc.w   $f000
00005E20  ; data: 0x00, 0x08
00005E22  bchg.b d2, d5
00005E24  ; data: 0xff, 0xff
00005E26  ; data: 0xff, 0xff
00005E28  ; data: 0xff, 0x07
00005E2A  ; data: 0xff, 0xff
00005E2C  ; data: 0xff, 0xff
00005E2E  move.w a7, -(a7)
00005E30  ; data: 0xff, 0xf9
00005E32  or.w   (a6)+, d0
00005E34  ori.b  #$f, d1
00005E38  ; data: 0xff, 0xff
00005E3A  dc.w   $f800
00005E3C  ori.b  #$7f, d0
00005E40  ; data: 0xff, 0xff
00005E42  ; data: 0xff, 0xff
00005E44  lsr.b  #$7, d7
00005E46  ; data: 0xff, 0xff
00005E48  ; data: 0xff, 0xff
00005E4A  move.w d3, -$2(a7)
00005E4E  and.b  (a6)+, d0
00005E50  move.l d2, d0
00005E52  ori.l  #$fffff800, d7
00005E58  ori.b  #$ff, (a0)
00005E5C  ; data: 0xff, 0xff
00005E5E  ; data: 0xff, 0xff
00005E60  ror.b  #$1, d7
00005E62  bset.b d7, ([$1f63fffc])
00005E6A  ori.b  #$0, (a4)+
00005E6E  move.b d7, -(a5)
00005E70  ; data: 0xff, 0xff
00005E72  dc.w   $fc00
00005E74  ori.b  #$7f, d0
00005E78  ; data: 0xff, 0xff
00005E7A  ; data: 0xff, 0xff
00005E7C  or.b   ([$ffff7ab1]), d1
00005E84  adda.w $e0083803.l, a0
00005E8A  move.w a7, ([$fc000028])
00005E92  ; data: 0x14, 0xff
00005E94  ; data: 0xff, 0xff
00005E96  ; data: 0xff, 0xf7
00005E98  moveq  #$3f, d4
00005E9A  ; data: 0xfd, 0xfd
00005E9C  ; data: 0xff, 0xff
00005E9E  move.l d3, d1
00005EA0  ; data: 0xa0, 0xf3
00005EA2  dc.w   $f000
00005EA4  dc.w   $4107
00005EA6  ; data: 0xfb, 0x9f
00005EA8  ; data: 0xff, 0xff
00005EAA  dc.w   $fe00
00005EAC  ori.b  #$1f, (a0)+
00005EB0  ; data: 0xff, 0xff
00005EB2  ; data: 0xff, 0xf7
00005EB4  moveq  #$2f, d0
00005EB6  ; data: 0xfe, 0x7e
00005EB8  ; data: 0xff, 0xff
00005EBA  move.w d7, -$3f09(a7)
00005EBE  dc.w   $fa00
00005EC0  ori.w  #$ff3f, -(a7)
00005EC4  ; data: 0xff, 0xff
00005EC6  dc.w   $fe00
00005EC8  ori.w  #$1613, (a0)
00005ECC  ; data: 0xff, 0xff
00005ECE  ; data: 0xff, 0x47
00005ED0  bra.b  $5ee5
00005ED2  ; data: 0xff, 0xff
00005ED4  ; data: 0xff, 0xff
00005ED6  move.b d7, d6
00005ED8  mulu.w -(a3), d0
00005EDA  ; data: 0xf9, 0x00
00005EDC  ori.b  #$1f, -(a1)
00005EE0  ; data: 0xdf, 0xff
00005EE2  dc.w   $fe00
00005EE4  ori.w  #$b2f, ([$ff0e0019])
00005EEE  ; data: 0xff, 0x7f
00005EF0  ; data: 0xff, 0xff
00005EF2  subi.w #$81e1, -$440(a3)
00005EF8  ori.b  #$ff, d3
00005EFC  ; data: 0xbf, 0xff
00005EFE  ; data: 0xff, 0x00
00005F00  ori.b  #$7f, -(a0)
00005F04  ; data: 0xff, 0xff
00005F06  ; data: 0xff, 0xfc
00005F08  ; data: 0x02, 0xd8
00005F0A  ; data: 0xff, 0x3f
00005F0C  ; data: 0xff, 0xfe
00005F0E  ; data: 0x00, 0x0f
00005F10  divs.w d0, d0
00005F12  ; data: 0x7d, 0xc0
00005F14  ori.b  #$df, d3
00005F18  ; data: 0x7f, 0xff
00005F1A  ; data: 0xff, 0x00
00005F1C  ; data: 0x00, 0xe0
00005F1E  ; data: 0x0e, 0x7f
00005F20  ; data: 0xff, 0xff
00005F22  ; data: 0xff, 0xfe
00005F24  btst.l d1, $5ee5(pc)
00005F28  ; data: 0xff, 0xff
00005F2A  ; data: 0x20, 0xbf
00005F2C  divs.w d1, d1
00005F2E  add.w  d0, d4
00005F30  ori.b  #$ef, d0
00005F34  ; data: 0xff, 0xff
00005F36  ; data: 0xff, 0x80
00005F38  ori.w  #$553f, d0
00005F3C  ; data: 0xff, 0xff
00005F3E  ; data: 0xff, 0xe9
00005F40  dc.w   $fa1d
00005F42  ; data: 0xff, 0xb7
00005F44  ; data: 0xff, 0xfe
00005F46  ; data: 0x19, 0xf7
00005F48  mulu.w (a3, a6.l * 4), d1
00005F4C  move.b d0, d0
00005F4E  moveq  #$35, d6
00005F50  ; data: 0xff, 0xff
00005F52  ; data: 0xff, 0x80
00005F54  btst.l d0, d0
00005F56  ; data: 0x0c, 0x7f
00005F58  ; data: 0xff, 0xff
00005F5A  ; data: 0xff, 0xc1
00005F5C  ; data: 0xdc, 0x0c
00005F5E  ; data: 0xff, 0xbb
00005F60  ; data: 0xdf, 0xff
00005F62  suba.l a7, a7
00005F64  muls.w (a7, a7.w), d6
00005F68  ; data: 0x08, 0x00
00005F6A  dc.w   $f86f
00005F6C  ; data: 0xff, 0xff
00005F6E  ; data: 0xff, 0x80
00005F70  btst.l d0, d0
00005F72  ; data: 0x54, 0xff
00005F74  ; data: 0xff, 0xff
00005F76  ; data: 0xff, 0xc9
00005F78  dc.w   $f81e
00005F7A  roxl.l d3, d7
00005F7C  ; data: 0xbf, 0xff
00005F7E  ; data: 0xff, 0xff
00005F80  asl.w  -(a7)
00005F82  dc.w   $f02f
00005F84  btst.l d3, d1
00005F86  dc.w   $f007
00005F88  ; data: 0xff, 0xff
00005F8A  ; data: 0xff, 0xc0
00005F8C  btst.l d0, d0
00005F8E  ; data: 0x29, 0xff
00005F90  ; data: 0xff, 0xff
00005F92  ; data: 0xff, 0xe8
00005F94  ror.b  d0, d6
00005F96  and.l  d3, (a7)+
00005F98  ; data: 0x7f, 0xfb
00005F9A  ; data: 0xff, 0xff
00005F9C  dc.w   $f8c3
00005F9E  dc.w   $f81f
00005FA0  add.b  d1, d1
00005FA2  ; data: 0xc0, 0x0f
00005FA4  ; data: 0xff, 0xff
00005FA6  ; data: 0xff, 0xc0
00005FA8  andi.b #$7f, d0
00005FAC  ; data: 0xff, 0xff
00005FAE  ; data: 0xff, 0xfc
00005FB0  ; data: 0x20, 0xff
00005FB2  ; data: 0xc3, 0x7e
00005FB4  ; data: 0x7f, 0xdf
00005FB6  ; data: 0xff, 0xff
00005FB8  ; data: 0xff, 0x85
00005FBA  dc.w   $fa1f
00005FBC  dc.w   $f000
00005FBE  ori.b  #$ff, d5
00005FC2  ; data: 0xff, 0xc0
00005FC4  andi.b #$7f, d0
00005FC8  ; data: 0xff, 0xff
00005FCA  ; data: 0xff, 0xfc
00005FCC  ; data: 0x03, 0xbe
00005FCE  moveq  #$fc, d0
00005FD0  ; data: 0xff, 0xff
00005FD2  ; data: 0xff, 0xff
00005FD4  ; data: 0xff, 0x0a
00005FD6  dc.w   $fc1f
00005FD8  dc.w   $f800
00005FDA  ori.b  #$ff, d3
00005FDE  ; data: 0xff, 0xe0
00005FE0  andi.b #$3f, d0
00005FE4  ; data: 0xff, 0xff
00005FE6  ; data: 0xff, 0xff
00005FE8  lsl.w  ([$ffffffff])
00005FF0  ; data: 0xff, 0x07
00005FF2  moveq  #$7f, d6
00005FF4  dc.w   $f820
00005FF6  ori.b  #$ff, d7
00005FFA  ; data: 0xff, 0xe0
00005FFC  subi.b #$7f, d0
00006000  ; data: 0xff, 0xff
00006002  ; data: 0xff, 0xfd
00006004  ; data: 0xff, 0xff
00006006  ; data: 0x3f, 0xf9
00006008  ; data: 0xff, 0xff
0000600A  ; data: 0xff, 0xfc
0000600C  dc.w   $fe06
0000600E  dc.w   $fcff
00006010  ; data: 0xf9, 0x00
00006012  ; data: 0x00, 0x0f
00006014  ; data: 0xef, 0xff
00006016  ; data: 0xff, 0xe0
00006018  subi.b #$bf, d0
0000601C  ; data: 0xff, 0xff
0000601E  ; data: 0xff, 0xff
00006020  ; data: 0xff, 0xff
00006022  ; data: 0x3f, 0xf3
00006024  ; data: 0xff, 0xff
00006026  ; data: 0xff, 0xf9
00006028  sub.b  (a7)+, d7
0000602A  ; data: 0x3b, 0xff
0000602C  ; data: 0xff, 0x00
0000602E  ori.b  #$ff, (a7)
00006032  ; data: 0xff, 0xf0
00006034  subi.b #$ff, d0
00006038  ; data: 0xff, 0xff
0000603A  ; data: 0xff, 0xff
0000603C  ; data: 0xff, 0xfe
0000603E  ; data: 0x3f, 0xfb
00006040  ; data: 0xff, 0xff
00006042  ; data: 0xff, 0xf2
00006044  ; data: 0x4e, 0x3f
00006046  ; data: 0x7f, 0xff
00006048  ; data: 0xff, 0x00
0000604A  ; data: 0x00, 0x0f
0000604C  ; data: 0xff, 0xff
0000604E  ; data: 0xff, 0xf0
00006050  cmpi.b #$ff, d0
00006054  ; data: 0xff, 0xff
00006056  ; data: 0xff, 0xff
00006058  ; data: 0xff, 0xfe
0000605A  ; data: 0x7f, 0xf7
0000605C  ; data: 0xff, 0xff
0000605E  ; data: 0xff, 0xf0
00006060  ; data: 0x2e, 0x7f
00006062  ; data: 0x77, 0xff
00006064  dc.w   $fc00
00006066  ori.b  #$ff, (a7)+
0000606A  ; data: 0xff, 0xf0
0000606C  cmpi.b #$ff, d0
00006070  ; data: 0xff, 0xff
00006072  ; data: 0xff, 0xff
00006074  ; data: 0xff, 0xfe
00006076  ; data: 0xff, 0xf7
00006078  ; data: 0xff, 0xff
0000607A  ; data: 0xff, 0xf8
0000607C  ; data: 0x0f, 0x7e
0000607E  ; data: 0xff, 0xff
00006080  dc.w   $f800
00006082  ori.b  #$ff, (a7)+
00006086  ; data: 0xff, 0xf0
00006088  cmpi.b #$ff, d0
0000608C  ; data: 0xff, 0xff
0000608E  ; data: 0xff, 0xff
00006090  ; data: 0xff, 0xfe
00006092  dc.w   $ff37
00006094  ; data: 0xff, 0xff
00006096  ; data: 0xff, 0xff
00006098  add.l  $f7ed.w, d7
0000609C  dc.w   $f800
0000609E  ; data: 0x00, 0x0f
000060A0  ; data: 0xff, 0xff
000060A2  ; data: 0xff, 0xf8
000060A4  cmpi.b #$ff, d0
000060A8  ; data: 0xff, 0xff
000060AA  ; data: 0xff, 0xff
000060AC  ; data: 0xff, 0xff
000060AE  ; data: 0xff, 0xc7
000060B0  ; data: 0xff, 0xfe
000060B2  ; data: 0xff, 0xff
000060B4  eor.b  d7, d0
000060B6  ; data: 0x7f, 0xff
000060B8  moveq  #$1b, d5
000060BA  ; data: 0xa0, 0x03
000060BC  ; data: 0xff, 0xff
000060BE  ; data: 0xff, 0xf8
000060C0  move.b -(a1), d6
000060C2  ; data: 0x5f, 0xff
000060C4  ; data: 0xff, 0xff
000060C6  ; data: 0xff, 0xff
000060C8  ; data: 0xff, 0xff
000060CA  ; data: 0xff, 0xe7
000060CC  ; data: 0xff, 0xff
000060CE  ; data: 0x3f, 0xff
000060D0  dc.w   $fc20
000060D2  ; data: 0x7b, 0xbf
000060D4  ; data: 0xf7, 0x0f
000060D6  move.w d5, d0
000060D8  ; data: 0x7f, 0xff
000060DA  ; data: 0xff, 0xf8
000060DC  move.b d0, d2
000060DE  ; data: 0x3f, 0xff
000060E0  ; data: 0xff, 0xff
000060E2  ; data: 0xff, 0xff
000060E4  ; data: 0xff, 0xff
000060E6  ; data: 0xff, 0xf7
000060E8  ; data: 0xff, 0xff
000060EA  ; data: 0xcf, 0xff
000060EC  dc.w   $f830
000060EE  move.w -$20f9(a7), d6
000060F2  sub.b  d2, d0
000060F4  ; data: 0xeb, 0xff
000060F6  ; data: 0xff, 0xf8
000060F8  move.b d1, d0
000060FA  ; data: 0x5f, 0xff
000060FC  ; data: 0xff, 0xff
000060FE  ; data: 0xff, 0xff
00006100  ; data: 0xff, 0xfd
00006102  cmpa.l ([$16103, pc]), a7
00006108  dc.w   $f835
0000610A  ; data: 0x0e, 0x5e
0000610C  ; data: 0xff, 0x8f
0000610E  ori.b  #$ff, d1
00006112  ; data: 0xff, 0xfc
00006114  ori.b  #$ff, d0
00006118  ; data: 0xff, 0xff
0000611A  ; data: 0xff, 0xff
0000611C  ; data: 0xff, 0xde
0000611E  ; data: 0x7f, 0xff
00006120  ; data: 0xff, 0xef
00006122  ; data: 0xff, 0xff
00006124  lsr.b  d4, d3
00006126  muls.w $7f8f(a6), d3
0000612A  and.b  d3, d0
0000612C  ; data: 0xea, 0xff
0000612E  ; data: 0xff, 0xfc
00006130  move.l d1, d0
00006132  ; data: 0x17, 0xff
00006134  ; data: 0xff, 0xff
00006136  ; data: 0xff, 0xc7
00006138  ; data: 0xff, 0xc8
0000613A  ; data: 0x3f, 0xff
0000613C  ; data: 0xff, 0x1f
0000613E  ; data: 0xff, 0xff
00006140  lsr.w  d0, d3
00006142  rol.w  (a7)+
00006144  ; data: 0x77, 0xed
00006146  negx.b d1
00006148  ; data: 0xf7, 0xff
0000614A  ; data: 0xff, 0xf4
0000614C  move.l d0, d0
0000614E  ; data: 0x27, 0xff
00006150  ; data: 0xff, 0xff
00006152  ; data: 0xff, 0x83
00006154  ; data: 0xff, 0xd1
00006156  ; data: 0x7f, 0xff
00006158  ; data: 0xff, 0x3f
0000615A  ; data: 0xff, 0xff
0000615C  ; data: 0xf1, 0xfb
0000615E  ; data: 0xf7, 0xbf
00006160  ; data: 0xff, 0xfa
00006162  ori.b  #$ff, d1
00006166  ; data: 0xff, 0xfc
00006168  move.l d0, d0
0000616A  ; data: 0x07, 0xff
0000616C  ; data: 0xff, 0xff
0000616E  ; data: 0xf1, 0x00
00006170  dc.w   $ff20
00006172  ; data: 0x5f, 0xff
00006174  ; data: 0xfc, 0x7f
00006176  ; data: 0xff, 0xff
00006178  ; data: 0xff, 0xb9
0000617A  dc.w   $ff7b
0000617C  ; data: 0xff, 0xfd
0000617E  addi.w #$ffff, -(a1)
00006182  ; data: 0xff, 0xf4
00006184  ori.b  #$ff, d0
00006188  ; data: 0xff, 0xff
0000618A  asr.b  #$8, d0
0000618C  ; data: 0x7f, 0x60
0000618E  ; data: 0xff, 0xff
00006190  ; data: 0xf1, 0xff
00006192  ; data: 0xff, 0xff
00006194  ; data: 0xff, 0x88
00006196  ; data: 0x7f, 0x9b
00006198  ; data: 0xff, 0xfe
0000619A  btst.l d1, d3
0000619C  ; data: 0xff, 0xff
0000619E  ; data: 0xff, 0xfc
000061A0  move.l d0, d0
000061A2  ; data: 0x0b, 0xff
000061A4  ; data: 0xff, 0xff
000061A6  and.b  d0, d0
000061A8  ; data: 0xff, 0xc8
000061AA  ; data: 0xff, 0xff
000061AC  ; data: 0xff, 0xff
000061AE  ; data: 0xff, 0xff
000061B0  dc.w   $fc00
000061B2  ori.w  #$fffe, (a7)+
000061B6  bchg.b d0, $f7fffffc.l
000061BC  addq.b #$8, d0
000061BE  ; data: 0x39, 0xff
000061C0  ; data: 0xff, 0xff
000061C2  and.l  (a1), d0
000061C4  ; data: 0xef, 0xf1
000061C6  ; data: 0xff, 0xff
000061C8  ; data: 0xff, 0xff
000061CA  ; data: 0xff, 0xff
000061CC  ; data: 0xfd, 0x02
000061CE  ; data: 0x00, 0xff
000061D0  ; data: 0xff, 0xfe
000061D2  ; data: 0x00, 0xfc
000061D4  dc.w   $faff
000061D6  ; data: 0xff, 0xf6
000061D8  bra.w  $63d9
000061DC  ; data: 0xff, 0xff
000061DE  ; data: 0xa1, 0x03
000061E0  muls.w (a6)+, d7
000061E2  ; data: 0xff, 0xff
000061E4  ; data: 0xff, 0xff
000061E6  ; data: 0xff, 0xff
000061E8  dc.w   $fa00
000061EA  ; data: 0x00, 0xff
000061EC  muls.w #$1fd, d7
000061F0  ; data: 0xfd, 0xff
000061F2  ; data: 0xff, 0xfe
000061F4  addq.b #$8, d0
000061F6  ; data: 0x21, 0xff
000061F8  ; data: 0xff, 0xff
000061FA  asr.b  #$8, d3
000061FC  ; data: 0xcf, 0xcd
000061FE  ; data: 0xff, 0xff
00006200  ; data: 0xff, 0xff
00006202  ; data: 0xff, 0xff
00006204  dc.w   $fc44
00006206  ; data: 0x03, 0xbf
00006208  or.w   d1, $feffffea(invalid.w)
00006210  negx.b d0
00006212  ; data: 0x41, 0xff
00006214  ; data: 0xff, 0xff
00006216  dc.w   $f243
00006218  adda.l -$1(a7), a7
0000621C  ; data: 0xff, 0xff
0000621E  ; data: 0xff, 0xff
00006220  dc.w   $fe02
00006222  ; data: 0x07, 0xfd
00006224  btst.l d0, d0
00006226  ; data: 0x03, 0xfc
00006228  ; data: 0x7d, 0xff
0000622A  ; data: 0xff, 0xfe
0000622C  negx.b d0
0000622E  ; data: 0x01, 0xff
00006230  ; data: 0xff, 0xff
00006232  dc.w   $fe83
00006234  ; data: 0xff, 0xff
00006236  ; data: 0xff, 0xff
00006238  ; data: 0xff, 0xff
0000623A  ; data: 0xff, 0xff
0000623C  dc.w   $ff2f
0000623E  muls.w #$0, d7
00006242  ; data: 0x0e, 0xfc
00006244  ; data: 0x3e, 0xff
00006246  ; data: 0xff, 0xfa
00006248  ori.b  #$ff, d1
0000624C  ; data: 0xff, 0xff
0000624E  ; data: 0xff, 0x03
00006250  ; data: 0xff, 0xff
00006252  ; data: 0xff, 0xff
00006254  ; data: 0xff, 0xff
00006256  ; data: 0xfd, 0xff
00006258  ; data: 0xff, 0xfb
0000625A  ; data: 0xf7, 0xf4
0000625C  ori.b  #$f8, d0
00006260  ; data: 0x3d, 0xff
00006262  ; data: 0xff, 0xfe
00006264  negx.b d6
00006266  ; data: 0x03, 0xff
00006268  ; data: 0xff, 0xff
0000626A  ; data: 0xff, 0x03
0000626C  ; data: 0xff, 0xff
0000626E  ; data: 0xff, 0xff
00006270  ; data: 0xff, 0xff
00006272  dc.w   $faff
00006274  ; data: 0xff, 0xef
00006276  ; data: 0xf3, 0xe0
00006278  ori.b  #$f8, d0
0000627C  ; data: 0x38, 0xff
0000627E  ; data: 0xff, 0xfa
00006280  negx.b (a0)+
00006282  ; data: 0x03, 0x7f
00006284  ; data: 0xff, 0xff
00006286  ; data: 0xff, 0x82
00006288  ; data: 0xff, 0xff
0000628A  ; data: 0xff, 0xff
0000628C  ; data: 0xff, 0xff
0000628E  ; data: 0xd0, 0xff
00006290  ; data: 0xff, 0xff
00006292  roxl.w -(a0)
00006294  ori.b  #$74, d0
00006298  ; data: 0x75, 0x7f
0000629A  ; data: 0xff, 0xfe
0000629C  and.b  -(a4), d0
0000629E  ; data: 0x04, 0x3f
000062A0  ; data: 0xff, 0xff
000062A2  ; data: 0xff, 0xc6
000062A4  ; data: 0xff, 0xff
000062A6  ; data: 0xff, 0xff
000062A8  ; data: 0xff, 0xff
000062AA  ; data: 0xe0, 0xff
000062AC  ; data: 0xff, 0xff
000062AE  dc.w   $fac0
000062B0  btst.b #$f1, d0
000062B4  dc.w   $fabf
000062B6  ; data: 0xff, 0xff
000062B8  or.b   d7, d0
000062BA  ori.w  #$ffff, (a7)+
000062BE  muls.w -$1(a7), d7
000062C2  ; data: 0xff, 0xff
000062C4  ; data: 0xff, 0xff
000062C6  ; data: 0xa7, 0xff
000062C8  ; data: 0xff, 0xfe
000062CA  ; data: 0x79, 0x00
000062CC  or.b   d0, d0
000062CE  movep.l d6, -$81(a7)
000062D2  ; data: 0xff, 0xfd
000062D4  or.b   d3, d0
000062D6  ; data: 0x00, 0x3f
000062D8  ; data: 0xff, 0xff
000062DA  rol.l  d3, d7
000062DC  ; data: 0xff, 0xff
000062DE  ; data: 0xff, 0xff
000062E0  ; data: 0xff, 0xff
000062E2  ; data: 0xf3, 0xff
000062E4  ; data: 0xff, 0xfc
000062E6  move.b d0, d4
000062E8  ori.b  #$1f, d0
000062EC  ; data: 0xff, 0xff
000062EE  ; data: 0xff, 0xff
000062F0  or.b   d3, d0
000062F2  move.l (a7)+, -$21(a4)
000062F6  rol.w  (a7)+
000062F8  ; data: 0xff, 0xff
000062FA  ; data: 0xff, 0xd3
000062FC  ; data: 0xff, 0xff
000062FE  ; data: 0xff, 0xff
00006300  ; data: 0xff, 0xf8
00006302  cmpi.b #$0, -(a2)
00006306  ori.b  #$ff, (a7)+
0000630A  ; data: 0xff, 0xfd
0000630C  or.b   d2, d0
0000630E  ; data: 0x50, 0x3f
00006310  ; data: 0xff, 0xff
00006312  ; data: 0xe7, 0xff
00006314  ; data: 0xff, 0xff
00006316  ; data: 0xff, 0xe7
00006318  ; data: 0xff, 0xff
0000631A  ; data: 0xff, 0xff
0000631C  ; data: 0xff, 0xf8
0000631E  ; data: 0x08, 0x43
00006320  dc.w   $f000
00006322  ; data: 0x00, 0x0f
00006324  dc.w   $fcff
00006326  ; data: 0xff, 0xff
00006328  or.b   d0, d0
0000632A  move.l (a7)+, d4
0000632C  ; data: 0xff, 0xff
0000632E  ; data: 0xe7, 0xff
00006330  ; data: 0xff, 0xff
00006332  ; data: 0xff, 0xaf
00006334  ; data: 0xff, 0xff
00006336  ; data: 0xff, 0xff
00006338  ; data: 0xff, 0xf4
0000633A  or.l   -(a7), d4
0000633C  ; data: 0xa8, 0x00
0000633E  ; data: 0x00, 0x0f
00006340  ; data: 0xff, 0xff
00006342  ; data: 0xff, 0xff
00006344  or.b   d0, d0
00006346  move.w -$1(a7), -(a0)
0000634A  ; data: 0xf7, 0xff
0000634C  ; data: 0xff, 0xff
0000634E  ; data: 0xff, 0xff
00006350  moveq  #$7f, d4
00006352  ; data: 0xff, 0xff
00006354  ; data: 0xff, 0xfe
00006356  ; data: 0x4b, 0xc7
00006358  dc.w   $fc00
0000635A  ori.b  #$ff, (a7)
0000635E  ; data: 0xff, 0xfd
00006360  or.b   d0, d0
00006362  ori.w  #$fdff, (a7)
00006366  ; data: 0xf7, 0xff
00006368  ; data: 0xff, 0xff
0000636A  ; data: 0xff, 0xfe
0000636C  dc.w   $f83f
0000636E  ; data: 0xff, 0xff
00006370  ; data: 0xff, 0xff
00006372  ; data: 0x8f, 0xff
00006374  dc.w   $fc00
00006376  ori.b  #$ff, (a7)+
0000637A  ; data: 0xff, 0xfd
0000637C  or.b   d0, d0
0000637E  ori.w  #$fdff, (a7)
00006382  ; data: 0xff, 0xff
00006384  ; data: 0xff, 0xff
00006386  ; data: 0xff, 0xff
00006388  dc.w   $f03f
0000638A  ; data: 0xff, 0xff
0000638C  ; data: 0xff, 0xff
0000638E  ; data: 0x8f, 0xff
00006390  dc.w   $fe00
00006392  ori.b  #$ff, -$3(a7)
00006398  or.b   d0, d0
0000639A  andi.b #$ff, -$1(a7)
000063A0  ; data: 0xff, 0xff
000063A2  ; data: 0xff, 0xff
000063A4  ; data: 0xa0, 0x1f
000063A6  ; data: 0xff, 0xff
000063A8  ; data: 0xff, 0xff
000063AA  ; data: 0xdb, 0xff
000063AC  dc.w   $fe00
000063AE  ; data: 0x00, 0x3e
000063B0  ; data: 0xff, 0xff
000063B2  ; data: 0xff, 0xff
000063B4  and.b  d0, d0
000063B6  bchg.b d0, d7
000063B8  ; data: 0xc3, 0xff
000063BA  ; data: 0xff, 0xff
000063BC  ; data: 0xff, 0xff
000063BE  ; data: 0xff, 0xff
000063C0  negx.b (a7)+
000063C2  ; data: 0x7f, 0xff
000063C4  ; data: 0xff, 0xff
000063C6  ; data: 0xf3, 0xff
000063C8  eor.b  d7, d0
000063CA  ori.b  #$ff, (a5)+
000063CE  ; data: 0xff, 0xfd
000063D0  asr.b  #$8, d0
000063D2  btst.l d0, d3
000063D4  ; data: 0xc7, 0xff
000063D6  ; data: 0xff, 0xff
000063D8  ; data: 0xff, 0xff
000063DA  ; data: 0xff, 0xfe
000063DC  ori.b  #$ff, (a7)+
000063E0  ; data: 0xff, 0xfc
000063E2  ; data: 0x57, 0xff
000063E4  dc.w   $fc00
000063E6  ; data: 0x00, 0x3f
000063E8  ; data: 0xff, 0xbf
000063EA  ; data: 0xff, 0xff
000063EC  asr.b  #$8, d0
000063EE  ori.b  #$ff, d5
000063F2  ; data: 0xff, 0xff
000063F4  ; data: 0xff, 0xff
000063F6  ; data: 0xff, 0xfe
000063F8  ; data: 0x00, 0x3f
000063FA  ; data: 0xf1, 0x7f
000063FC  ; data: 0xff, 0xf8
000063FE  ; data: 0xff, 0xff
00006400  ; data: 0xa3, 0xc0
00006402  ; data: 0x00, 0x7f
00006404  ; data: 0x7d, 0x7f
00006406  ; data: 0xff, 0xff
00006408  asr.b  #$8, d0
0000640A  ; data: 0x00, 0x0f
0000640C  ; data: 0xff, 0xff
0000640E  ; data: 0xff, 0xff
00006410  ; data: 0xff, 0xff
00006412  ; data: 0xff, 0xfc
00006414  ; data: 0x00, 0x7f
00006416  dc.w   $f47f
00006418  ; data: 0xff, 0xdd
0000641A  ; data: 0xff, 0xff
0000641C  lsl.b  #$7, d0
0000641E  ; data: 0x00, 0x7f
00006420  ; data: 0xbf, 0x3f
00006422  ; data: 0xff, 0xfe
00006424  and.b  d0, d0
00006426  bchg.b d0, (a5)
00006428  ; data: 0xff, 0xff
0000642A  ; data: 0xff, 0xff
0000642C  ; data: 0xff, 0xff
0000642E  ; data: 0xff, 0xff
00006430  ; data: 0x00, 0xff
00006432  ; data: 0xdf, 0xff
00006434  ; data: 0xff, 0xf3
00006436  ; data: 0xff, 0xff
00006438  add.b  d0, d6
0000643A  ; data: 0x00, 0x7f
0000643C  dc.w   $fd5f
0000643E  ; data: 0xff, 0xfd
00006440  and.b  d0, d0
00006442  movep.w d0, -$1(a0)
00006446  ; data: 0xff, 0xff
00006448  ; data: 0xff, 0xff
0000644A  ; data: 0xff, 0xfe
0000644C  ; data: 0x01, 0xff
0000644E  ; data: 0xbf, 0xff
00006450  ; data: 0xff, 0xcf
00006452  ; data: 0xff, 0xff
00006454  or.b   d0, d0
00006456  ; data: 0x00, 0x3f
00006458  ; data: 0xc8, 0xbf
0000645A  ; data: 0xff, 0xfe
0000645C  asr.b  #$8, d0
0000645E  bchg.b d0, (a1)
00006460  ; data: 0xff, 0xff
00006462  ; data: 0xff, 0xff
00006464  ; data: 0xff, 0xff
00006466  ; data: 0xff, 0xff
00006468  ; data: 0x03, 0xff
0000646A  ; data: 0xff, 0xe8
0000646C  ; data: 0xff, 0xff
0000646E  ; data: 0xff, 0xff
00006470  ori.b  #$5f, d0
00006474  ; data: 0xc1, 0xff
00006476  ; data: 0xff, 0xff
00006478  or.b   d0, d0
0000647A  ; data: 0x02, 0xf9
0000647C  ; data: 0xff, 0xff
0000647E  ; data: 0xff, 0xff
00006480  ; data: 0xff, 0xff
00006482  ; data: 0xff, 0xff
00006484  ; data: 0x1c, 0x7f
00006486  dc.w   $ff10
00006488  ; data: 0xef, 0xff
0000648A  ; data: 0xff, 0xfe
0000648C  btst.l d0, d0
0000648E  ; data: 0x00, 0xdf
00006490  ; data: 0xc0, 0xbf
00006492  ; data: 0xff, 0xfe
00006494  or.b   d0, d0
00006496  ; data: 0x01, 0x7f
00006498  ; data: 0xff, 0xff
0000649A  ; data: 0xff, 0xff
0000649C  ; data: 0xff, 0xff
0000649E  ; data: 0xff, 0xff
000064A0  ; data: 0xfc, 0x7f
000064A2  ; data: 0xff, 0x80
000064A4  ; data: 0xff, 0xff
000064A6  ; data: 0xff, 0xce
000064A8  move.b d4, d3
000064AA  ; data: 0x00, 0x8f
000064AC  ; data: 0x83, 0xff
000064AE  ; data: 0xff, 0xfd
000064B0  and.b  d0, d0
000064B2  ; data: 0x02, 0xff
000064B4  ; data: 0xff, 0xff
000064B6  ; data: 0xff, 0xff
000064B8  ; data: 0xff, 0xff
000064BA  ; data: 0xff, 0xff
000064BC  ; data: 0xff, 0x8f
000064BE  ; data: 0xff, 0xd0
000064C0  ; data: 0x7f, 0xff
000064C2  ; data: 0xfd, 0x0e
000064C4  ; data: 0x18, 0x0a
000064C6  ; data: 0x00, 0x8e
000064C8  ; data: 0x0f, 0xff
000064CA  ; data: 0xff, 0xfe
000064CC  ; data: 0xa0, 0x00
000064CE  bchg.b d2, (a7)+
000064D0  ; data: 0xff, 0xff
000064D2  ; data: 0xff, 0xff
000064D4  ; data: 0xff, 0xff
000064D6  ; data: 0xff, 0xff
000064D8  ; data: 0xff, 0x0b
000064DA  ; data: 0xff, 0xd0
000064DC  ; data: 0x1f, 0xff
000064DE  ; data: 0xf3, 0x8e
000064E0  movea.w (a5), a4
000064E2  or.b   d0, d0
000064E4  ; data: 0x1f, 0xff
000064E6  ; data: 0xff, 0xf9
000064E8  dc.w   $f000
000064EA  ; data: 0x02, 0xff
000064EC  ; data: 0xff, 0xff
000064EE  ; data: 0xff, 0xff
000064F0  ; data: 0xff, 0xff
000064F2  ; data: 0xfc, 0x7f
000064F4  ; data: 0xff, 0x9f
000064F6  ; data: 0x1f, 0xf8
000064F8  ; data: 0x3f, 0xff
000064FA  and.b  (a7)+, d1
000064FC  moveq  #$cf, d0
000064FE  ori.b  #$ef, d0
00006502  ; data: 0xff, 0xfd
00006504  moveq  #$0, d0
00006506  bchg.b d2, d7
00006508  ; data: 0xff, 0xff
0000650A  ; data: 0xff, 0xff
0000650C  ; data: 0xff, 0xff
0000650E  dc.w   $fe3f
00006510  dc.w   $ff6e
00006512  ; data: 0x07, 0xfc
00006514  ; data: 0x7f, 0xff
00006516  ; data: 0xc7, 0xbe
00006518  move.l (a6)+, $7fff.l
0000651E  ; data: 0xff, 0xfa
00006520  moveq  #$0, d0
00006522  ori.l  #$ffffffff, d3
00006528  ; data: 0xff, 0xff
0000652A  dc.w   $fe3f
0000652C  ; data: 0xff, 0xfc
0000652E  bset.b d1, (a6)+
00006530  ; data: 0xff, 0xff
00006532  ; data: 0x8b, 0x7c
00006534  dc.w   $4f8
00006536  ori.b  #$ff, d0
0000653A  ; data: 0xff, 0xf6
0000653C  bra.w  $6681
00006540  ; data: 0xff, 0xff
00006542  ; data: 0xff, 0xfd
00006544  ; data: 0xff, 0xff
00006546  ; data: 0xfc, 0x7f
00006548  ; data: 0xff, 0xfc
0000654A  bset.b d1, -$1(a1)
0000654E  suba.l $800.w, a3
00006552  andi.b #$ff, d0
00006556  ; data: 0xff, 0xf8
00006558  bra.w  $6580
0000655C  ; data: 0x1f, 0xff
0000655E  ; data: 0xff, 0xff
00006560  ; data: 0x0f, 0xff
00006562  dc.w   $fc3f
00006564  ; data: 0xff, 0xfc
00006566  ; data: 0x01, 0xff
00006568  ; data: 0xff, 0xff
0000656A  adda.l $0.w, a7
0000656E  ori.b  #$ff, d0
00006572  ; data: 0xff, 0xee
00006574  bra.w  $65ca
00006578  ; data: 0x0f, 0xff
0000657A  ; data: 0xff, 0xf0
0000657C  ; data: 0xc7, 0xff
0000657E  ; data: 0xff, 0xff
00006580  ; data: 0xff, 0xfc
00006582  ; data: 0x03, 0xff
00006584  ; data: 0xff, 0xff
00006586  ; data: 0xff, 0xf8
00006588  ori.b  #$c0, d0
0000658C  ; data: 0x7b, 0xff
0000658E  ; data: 0xff, 0xf4
00006590  moveq  #$0, d0
00006592  ori.b  #$ff, -$20(a4)
00006598  ; data: 0xc3, 0xff
0000659A  ; data: 0xff, 0xff
0000659C  ; data: 0xff, 0xfc
0000659E  ; data: 0x03, 0xff
000065A0  ; data: 0xff, 0xff
000065A2  ; data: 0xff, 0xf8
000065A4  ori.b  #$a0, d0
000065A8  ; data: 0x7f, 0xbf
000065AA  ; data: 0xff, 0xf8
000065AC  bra.w  $6602
000065B0  ; data: 0x07, 0xff
000065B2  ; data: 0xff, 0xf0
000065B4  ; data: 0xe3, 0xff
000065B6  ; data: 0xff, 0xff
000065B8  ; data: 0xff, 0xe6
000065BA  ; data: 0x03, 0xff
000065BC  ; data: 0xff, 0xff
000065BE  ; data: 0xff, 0xe8
000065C0  ori.b  #$f0, d0
000065C4  ; data: 0xff, 0xff
000065C6  ; data: 0xff, 0xf6
000065C8  moveq  #$0, d4
000065CA  ori.b  #$ff, -$80(a4)
000065D0  ; data: 0x47, 0xff
000065D2  ; data: 0xff, 0xff
000065D4  ; data: 0xff, 0xfb
000065D6  ; data: 0x07, 0xff
000065D8  dc.w   $fc3f
000065DA  ; data: 0xff, 0xf0
000065DC  ori.b  #$fa, d0
000065E0  ; data: 0xff, 0xff
000065E2  ; data: 0xff, 0xea
000065E4  move.w d0, d7
000065E6  ori.w  #$7ff, (a4)
000065EA  ; data: 0xff, 0x8c
000065EC  ; data: 0x07, 0xff
000065EE  ; data: 0xff, 0xff
000065F0  ; data: 0xff, 0xe1
000065F2  ; data: 0x0f, 0xff
000065F4  dc.w   $f82f
000065F6  ; data: 0xff, 0xa8
000065F8  negx.b d0
000065FA  ; data: 0x37, 0xf4
000065FC  ; data: 0xff, 0xff
000065FE  ; data: 0xff, 0xf4
00006600  move.w d0, d6
00006602  ; data: 0x00, 0x0b
00006604  ; data: 0x00, 0xff
00006606  ; data: 0xff, 0x8e
00006608  ; data: 0x1f, 0xff
0000660A  ; data: 0xff, 0xff
0000660C  ; data: 0xff, 0xc0
0000660E  ; data: 0x1f, 0xff
00006610  dc.w   $f01f
00006612  ; data: 0xff, 0xfc
00006614  bra.w  $6a00
00006618  dc.w   $6fff
0000661A  ; data: 0xff, 0xe0
0000661C  move.w d0, d7
0000661E  ori.b  #$3f, (a5)
00006622  ; data: 0xff, 0xc0
00006624  ; data: 0x7d, 0xff
00006626  ; data: 0xff, 0xff
00006628  ; data: 0xff, 0xe0
0000662A  ; data: 0x3f, 0xe7
0000662C  cmp.b  (a6)+, d3
0000662E  ; data: 0xff, 0xa8
00006630  negx.b d5
00006632  lea.l  ([$fff43d00]), a0
0000663A  ori.b  #$3f, d0
0000663E  ; data: 0xff, 0xe0
00006640  ; data: 0xfb, 0xf3
00006642  ; data: 0xff, 0xff
00006644  ; data: 0xff, 0xe0
00006646  ; data: 0x7f, 0xc7
00006648  subx.b -(a7), -(a5)
0000664A  ; data: 0x7f, 0xf0
0000664C  ; data: 0x08, 0x03
0000664E  cmp.b  d0, d4
00006650  ; data: 0x1f, 0xff
00006652  ; data: 0xff, 0xd4
00006654  move.w d0, d5
00006656  ori.b  #$f, d0
0000665A  ; data: 0xff, 0xd7
0000665C  ; data: 0xf5, 0xf8
0000665E  ; data: 0xff, 0xff
00006660  ; data: 0xff, 0xe1
00006662  ; data: 0xff, 0xed
00006664  dc.w   $fc03
00006666  ; data: 0x73, 0xa8
00006668  move.b d3, d4
0000666A  subq.w #$4, d0
0000666C  ; data: 0x5f, 0xff
0000666E  ; data: 0xff, 0xf4
00006670  move.b d0, d6
00006672  ori.b  #$f, d3
00006676  ; data: 0xff, 0xff
00006678  dc.w   $f8fc
0000667A  ; data: 0x7f, 0xff
0000667C  ; data: 0xff, 0xff
0000667E  dc.w   $fe10
00006680  ; data: 0x7f, 0x01
00006682  chk.w  (a0), d3
00006684  move.b d0, d4
00006686  cmp.b  d0, d0
00006688  ; data: 0x3f, 0xff
0000668A  ; data: 0xff, 0xe0
0000668C  move.b d0, d4
0000668E  ori.b  #$5, d1
00006692  ; data: 0xff, 0xff
00006694  ; data: 0xfc, 0x7f
00006696  ; data: 0x7f, 0xff
00006698  ; data: 0xff, 0xe7
0000669A  roxl.w $7dc0(a0)
0000669E  not.l  d0
000066A0  move.b d1, -(a7)
000066A2  dc.w   $4101
000066A4  ; data: 0x7f, 0xff
000066A6  ; data: 0xff, 0xd0
000066A8  move.b d0, d6
000066AA  ori.b  #$2, d0
000066AE  ; data: 0x3f, 0xff
000066B0  ; data: 0xfc, 0x7f
000066B2  ; data: 0xff, 0xff
000066B4  ; data: 0xff, 0xe3
000066B6  muls.w (a0, invalid.w), d5
000066BA  ; data: 0x7f, 0x40
000066BC  move.b d0, d7
000066BE  and.b  d0, d0
000066C0  ; data: 0xff, 0xff
000066C2  ; data: 0xff, 0xe8
000066C4  move.b d0, d7
000066C6  ori.b  #$4, d0
000066CA  ; data: 0x3f, 0xff
000066CC  ; data: 0xff, 0xff
000066CE  ; data: 0xbf, 0xff
000066D0  ; data: 0xff, 0xc7
000066D2  adda.l $b040.w, a3
000066D6  moveq  #$a0, d4
000066D8  subi.b #$1, d0
000066DC  ; data: 0xff, 0x7f
000066DE  ; data: 0xff, 0x98
000066E0  btst.l d7, d0
000066E2  ori.b  #$32, d2
000066E6  ; data: 0x0b, 0xff
000066E8  ; data: 0xff, 0xff
000066EA  ; data: 0xff, 0xff
000066EC  cmpa.l a7, a7
000066EE  ; data: 0xf7, 0xf8
000066F0  moveq  #$83, d5
000066F2  and.w  d0, d0
000066F4  ori.b  #$63, d0
000066F8  ; data: 0xff, 0x7f
000066FA  ; data: 0xff, 0xc0
000066FC  btst.l d7, d0
000066FE  ori.b  #$f0, d0
00006702  ; data: 0x01, 0xff
00006704  ; data: 0xff, 0xff
00006706  ; data: 0xff, 0xff
00006708  ; data: 0xbf, 0xbf
0000670A  adda.l $3c03.w, a3
0000670E  add.b  $401(a0), d0
00006712  ; data: 0x00, 0xf1
00006714  ; data: 0xff, 0xff
00006716  ; data: 0xff, 0xc0
00006718  btst.l d7, d0
0000671A  ori.b  #$f4, d0
0000671E  ; data: 0x03, 0xff
00006720  ; data: 0xff, 0xff
00006722  ; data: 0xff, 0xff
00006724  ; data: 0xdf, 0xff
00006726  ; data: 0xa7, 0xf8
00006728  move.w d3, d6
0000672A  and.b  d0, d0
0000672C  ; data: 0x0e, 0x07
0000672E  ; data: 0x00, 0xfc
00006730  ; data: 0xff, 0xef
00006732  ; data: 0xff, 0x90
00006734  btst.l d7, d0
00006736  ori.b  #$f4, d0
0000673A  ; data: 0x01, 0xff
0000673C  ; data: 0xff, 0xff
0000673E  ; data: 0xff, 0xff
00006740  ; data: 0xff, 0xff
00006742  bset.b d1, $1803.w
00006746  ; data: 0xa0, 0x20
00006748  ; data: 0x0e, 0x1f
0000674A  ; data: 0x07, 0xfc
0000674C  ; data: 0x7f, 0xff
0000674E  ; data: 0xff, 0xd0
00006750  addi.b #$0, d0
00006754  bset.b d1, ([$ffffffff])
0000675C  ; data: 0xff, 0xfe
0000675E  ; data: 0xa6, 0xf0
00006760  ori.b  #$0, d1
00006764  move.w (a6)+, (a6)
00006766  ; data: 0x03, 0xff
00006768  ; data: 0xff, 0xff
0000676A  ; data: 0xff, 0x40
0000676C  bclr.b d3, d0
0000676E  ori.b  #$f0, d0
00006772  ; data: 0x00, 0xff
00006774  ; data: 0xff, 0xff
00006776  ; data: 0xdf, 0xff
00006778  ; data: 0xff, 0xff
0000677A  beq.b  $676c
0000677C  ori.b  #$0, -(a0)
00006780  ; data: 0x1f, 0xde
00006782  ; data: 0x15, 0xfd
00006784  ; data: 0xff, 0xff
00006786  dc.w   $fe80
00006788  bset.b d3, d0
0000678A  ori.b  #$e0, d0
0000678E  ; data: 0x40, 0xff
00006790  ; data: 0xff, 0xff
00006792  ; data: 0xff, 0xff
00006794  ; data: 0xff, 0xff
00006796  ; data: 0xa1, 0xe0
00006798  bchg.b d0, (a0, d0.w)
0000679C  ; data: 0x1f, 0x88
0000679E  ; data: 0x1b, 0xfe
000067A0  ; data: 0xff, 0xff
000067A2  dc.w   $ff20
000067A4  bset.b d1, -(a0)
000067A6  ori.b  #$81, d0
000067AA  ; data: 0xf0, 0x7f
000067AC  ; data: 0xff, 0xff
000067AE  ; data: 0xff, 0xc4
000067B0  ; data: 0xff, 0xff
000067B2  and.w  d0, d0
000067B4  andi.w #$0, (invalid.w)
000067BA  ; data: 0x1d, 0xff
000067BC  ; data: 0xff, 0xff
000067BE  ; data: 0xfd, 0x80
000067C0  bset.b d1, -(a0)
000067C2  ori.b  #$17, d0
000067C6  dc.w   $f03f
000067C8  ; data: 0xff, 0xff
000067CA  divs.w d2, d7
000067CC  ; data: 0xff, 0xff
000067CE  and.b  d0, d4
000067D0  bset.b d0, $1(a0, d0.w)
000067D4  btst.l d1, -(a0)
000067D6  ; data: 0x0f, 0xff
000067D8  ; data: 0xff, 0xff
000067DA  ; data: 0xff, 0x00
000067DC  bset.b d1, -(a0)
000067DE  ori.b  #$f, d0
000067E2  dc.w   $f81f
000067E4  ; data: 0xff, 0xff
000067E6  dc.w   $4701
000067E8  ; data: 0xff, 0xff
000067EA  asr.b  #$8, d0
000067EC  bset.b d0, -(a0)
000067EE  ori.b  #$e0, d2
000067F2  ; data: 0x07, 0xff
000067F4  ; data: 0xff, 0xff
000067F6  dc.w   $fa40
000067F8  bset.b d0, d0
000067FA  ori.b  #$1f, -(a0)
000067FE  dc.w   $fc27
00006800  ; data: 0xff, 0xfe
00006802  andi.b #$ff, d0
00006806  dc.w   $f400
00006808  ori.w  #$1, -(a0)
0000680C  ; data: 0xff, 0xe0
0000680E  ; data: 0x08, 0xff
00006810  ; data: 0xff, 0xff
00006812  dc.w   $fe00
00006814  bclr.b d0, -$8000(a0)
00006818  ori.b  #$17, (a7)+
0000681C  ; data: 0xff, 0xfe
0000681E  negx.l d0
00006820  ; data: 0x7f, 0xef
00006822  ; data: 0xff, 0x00
00006824  ori.b  #$3, -(a0)
00006828  ; data: 0xff, 0xc0
0000682A  ; data: 0x14, 0xff
0000682C  ; data: 0xff, 0xff
0000682E  dc.w   $fe80
00006830  bset.b d0, (a1)
00006832  negx.b (a0)
00006834  ; data: 0x00, 0x3f
00006836  dc.w   $fc03
00006838  ; data: 0xff, 0xfe
0000683A  ; data: 0x00, 0xe4
0000683C  dc.w   $fc8f
0000683E  moveq  #$0, d6
00006840  ori.b  #$83, d4
00006844  ; data: 0xff, 0xc0
00006846  ; data: 0x1e, 0xff
00006848  ; data: 0xff, 0xff
0000684A  dc.w   $fe80
0000684C  ori.l  #$8000003f, $fe17.w
00006854  ; data: 0xdf, 0xff
00006856  bchg.b d7, d7
00006858  dc.w   $fe5c
0000685A  ; data: 0x7b, 0x60
0000685C  move.b d2, d0
0000685E  dc.w   $8783
00006860  ; data: 0xff, 0xc0
00006862  ; data: 0x3f, 0xff
00006864  ; data: 0xff, 0xff
00006866  dc.w   $fe00
00006868  dc.w   $fb
0000686A  and.b  d0, d0
0000686C  ; data: 0x80, 0x7f
0000686E  dc.w   $fc07
00006870  ; data: 0x07, 0xff
00006872  sbcd.b d7, d7
00006874  ; data: 0xff, 0xf8
00006876  cmp.b  -(a0), d2
00006878  or.b   d0, d4
0000687A  move.b d5, -$20(a7)
0000687E  ; data: 0x7f, 0xff
00006880  ; data: 0xff, 0xff
00006882  ; data: 0xf9, 0x00
00006884  ; data: 0x00, 0x7d
00006886  ori.b  #$3f, d0
0000688A  dc.w   $fc06
0000688C  ; data: 0x07, 0xff
0000688E  btst.l d7, (a7)
00006890  ; data: 0xff, 0xfd
00006892  ; data: 0xa0, 0x20
00006894  negx.b d2
00006896  ; data: 0x0e, 0x8e
00006898  ; data: 0xff, 0x80
0000689A  ; data: 0x7f, 0xff
0000689C  ; data: 0xff, 0xff
0000689E  dc.w   $f800
000068A0  ori.w  #$0, sr
000068A4  ; data: 0x00, 0x3f
000068A6  dc.w   $f806
000068A8  ; data: 0x03, 0xfc
000068AA  ; data: 0x06, 0xff
000068AC  ; data: 0xff, 0xff
000068AE  bra.b  $68d0
000068B0  negx.b d0
000068B2  btst.l d0, (a7, a7.l * 8)
000068B6  ; data: 0x7f, 0xff
000068B8  ; data: 0xff, 0xff
000068BA  add.b  d0, d4
000068BC  ; data: 0x00, 0x7e
000068BE  ori.b  #$3f, d0
000068C2  cmp.b  d4, d4
000068C4  bset.b d1, $37f.w
000068C8  ; data: 0xff, 0xff
000068CA  asr.b  d0, d0
000068CC  andi.l #$fbfdc0, -(a0)
000068D2  ; data: 0x3f, 0xff
000068D4  ; data: 0xff, 0xff
000068D6  cmp.b  d0, d1
000068D8  ; data: 0x00, 0x3c
000068DA  ; data: 0x71, 0x00
000068DC  and.b  (a5)+, d0
000068DE  or.b   d0, d0
000068E0  divs.w $3f(a0, d0.w), d1
000068E4  ; data: 0xff, 0xe5
000068E6  and.b  (a0, d0.w * 4), d0
000068EA  ; data: 0x00, 0xff
000068EC  ; data: 0xff, 0xc8
000068EE  ; data: 0x1f, 0xff
000068F0  ; data: 0xff, 0xff
000068F2  add.b  d0, d0
000068F4  ; data: 0x00, 0x3a
000068F6  sub.b  d0, d4
000068F8  negx.b (a4)+
000068FA  or.b   d6, d0
000068FC  bset.b d3, $3f(a0, d0.w)
00006900  ; data: 0xff, 0xc7
00006902  and.b  $0.w, d0
00006906  ; data: 0x00, 0xff
00006908  dc.w   $ff50
0000690A  ; data: 0x3f, 0xff
0000690C  ; data: 0xff, 0xff
0000690E  cmp.b  d0, d2
00006910  ori.b  #$0, (a5)+
00006914  bra.b  $6922
00006916  and.b  -(a4), d0
00006918  muls.w $3f(a0, d0.w), d2
0000691C  ; data: 0xff, 0x87
0000691E  and.b  (a6, d0.w), d0
00006922  ; data: 0x08, 0xff
00006924  ; data: 0xff, 0x80
00006926  ; data: 0x3f, 0xff
00006928  ; data: 0xff, 0xff
0000692A  ; data: 0xa0, 0x00
0000692C  ori.b  #$0, (a7)+
00006930  bra.b  $693a
00006932  divu.w $bf8(a4), d0
00006936  ; data: 0x00, 0x7f
00006938  ; data: 0xff, 0x8f
0000693A  and.b  -(a0), d1
0000693C  move.l d0, d0
0000693E  ; data: 0x13, 0xff
00006940  ; data: 0xff, 0x80
00006942  ; data: 0x3f, 0xff
00006944  ; data: 0xff, 0xff
00006946  asr.b  #$4, d0
00006948  ; data: 0x00, 0x0f
0000694A  dc.w   $fe00
0000694C  ori.b  #$e4, d0
00006950  ; data: 0x00, 0xfe
00006952  ; data: 0x00, 0xff
00006954  ; data: 0xff, 0xfb
00006956  and.w  d1, d0
00006958  ; data: 0x08, 0x00
0000695A  ; data: 0x2b, 0xff
0000695C  ; data: 0xff, 0x86
0000695E  ; data: 0x1f, 0xff
00006960  ; data: 0xff, 0xff
00006962  and.b  d0, d0
00006964  ; data: 0x00, 0x0f
00006966  ; data: 0xff, 0x00
00006968  asr.b  #$8, d0
0000696A  ori.w  #$5f, -(a0)
0000696E  ; data: 0x80, 0x7f
00006970  ; data: 0xff, 0xf3
00006972  addq.l #$6, -(a2)
00006974  move.b d0, (a0)
00006976  ; data: 0x19, 0xff
00006978  ; data: 0xff, 0x9d
0000697A  ; data: 0x9f, 0xff
0000697C  ; data: 0xff, 0xfe
0000697E  add.b  d0, d0
00006980  ori.b  #$31, d7
00006984  dc.w   $fe00
00006986  ori.b  #$3f, d0
0000698A  mulu.w $63(a0, a7.l), d0
0000698E  ; data: 0xa7, 0x00
00006990  move.l -(a0), -(a6)
00006992  ; data: 0x1c, 0x3f
00006994  dc.w   $fcbf
00006996  ; data: 0xef, 0xff
00006998  ; data: 0xff, 0xff
0000699A  and.b  d0, d0
0000699C  ori.b  #$7b, d7
000069A0  ; data: 0xff, 0x00
000069A2  ori.b  #$1f, (a0)
000069A6  addx.w d0, d0
000069A8  ; data: 0xf9, 0x9d
000069AA  clr.b  -(a0)
000069AC  subi.b #$7f, d0
000069B0  ; data: 0xfe, 0x7f
000069B2  ; data: 0xff, 0xff
000069B4  ; data: 0xff, 0xff
000069B6  move.l d0, d0
000069B8  ori.b  #$bb, d3
000069BC  ; data: 0xff, 0x80
000069BE  ori.b  #$1f, (a0)
000069C2  asr.l  #$8, d1
000069C4  asr.b  d0, d2
000069C6  ori.b  #$0, d0
000069CA  ; data: 0xc7, 0xbf
000069CC  ; data: 0x9e, 0xff
000069CE  ; data: 0xff, 0xff
000069D0  ; data: 0xff, 0xef
000069D2  ori.b  #$3, d0
000069D6  ; data: 0xff, 0xd3
000069D8  dc.w   $fc00
000069DA  ori.b  #$7f, d0
000069DE  abcd.b d1, d0
000069E0  and.l  (a1)+, d0
000069E2  negx.b -(a0)
000069E4  ; data: 0x00, 0x0f
000069E6  ; data: 0x41, 0xdf
000069E8  ; data: 0x5d, 0xff
000069EA  ; data: 0xff, 0xff
000069EC  ; data: 0xff, 0x9c
000069EE  negx.b d0
000069F0  ori.b  #$c5, d1
000069F4  ; data: 0xff, 0x40
000069F6  ori.b  #$2f, d0
000069FA  or.b   d3, d0
000069FC  ; data: 0x80, 0x08
000069FE  ori.b  #$f, d0
00006A02  ; data: 0x80, 0x7e
00006A04  ; data: 0x2b, 0xff
00006A06  ; data: 0x3f, 0xff
00006A08  ; data: 0xff, 0x1e
00006A0A  ori.b  #$0, d0
00006A0E  ; data: 0xff, 0xe7
00006A10  ; data: 0xff, 0x80
00006A12  ori.b  #$20, d0
00006A16  or.b   d7, d0
00006A18  ori.b  #$0, d1
00006A1C  ori.b  #$1, d7
00006A20  ; data: 0x55, 0xfd
00006A22  ; data: 0x7f, 0xff
00006A24  ; data: 0xff, 0x1c
00006A26  ori.b  #$0, d0
00006A2A  ; data: 0xff, 0xc7
00006A2C  ; data: 0xff, 0xe1
00006A2E  ori.b  #$20, d0
00006A32  or.b   (a3)+, d0
00006A34  ori.b  #$0, d0
00006A38  ori.b  #$f4, d7
00006A3C  ; data: 0xad, 0xfa
00006A3E  ; data: 0x7f, 0xff
00006A40  ; data: 0xff, 0xb8
00006A42  ori.b  #$0, d0
00006A46  ; data: 0x7f, 0xef
00006A48  cmpa.w d0, a7
00006A4A  ori.b  #$1, d0
00006A4E  and.w  (a4, d0.w), d0
00006A52  ori.b  #$1, d0
00006A56  ; data: 0x05, 0xff
00006A58  ; data: 0x4d, 0xfc
00006A5A  ; data: 0xff, 0xff
00006A5C  ; data: 0xff, 0xb8
00006A5E  ori.b  #$0, d0
00006A62  ; data: 0x3f, 0xff
00006A64  dc.w   $fc40
00006A66  ori.b  #$1, d0
00006A6A  asr.w  #$8, d2
00006A6C  ori.b  #$0, d0
00006A70  move.b d0, d0
00006A72  movep.w -$3005(a6), d1
00006A76  ; data: 0xff, 0xff
00006A78  ; data: 0xff, 0xe0
00006A7A  ori.b  #$0, d0
00006A7E  ; data: 0x3f, 0xfe
00006A80  tst.b  d0
00006A82  andi.b #$1, d0
00006A86  ror.b  #$8, d6
00006A88  ori.b  #$4, d0
00006A8C  ori.b  #$f, d0
00006A90  ; data: 0x0f, 0xfd
00006A92  ; data: 0xff, 0xff
00006A94  ; data: 0xff, 0xb4
00006A96  ori.b  #$0, d0
00006A9A  ; data: 0x1f, 0xfe
00006A9C  move.l d0, d6
00006A9E  subi.b #$1, d0
00006AA2  ror.w  d2, d4
00006AA4  ori.b  #$47, d0
00006AA8  ori.b  #$7, d0
00006AAC  ; data: 0x09, 0xff
00006AAE  ; data: 0xff, 0xff
00006AB0  ; data: 0xff, 0xe0
00006AB2  ori.b  #$0, d0
00006AB6  ; data: 0x1f, 0xff
00006AB8  dc.w   $f600
00006ABE  bvs.b  $6b3c
00006AC0  ori.b  #$3, d0
00006AC4  ori.b  #$23, d0
00006AC8  ; data: 0x05, 0xff
00006ACA  ; data: 0xff, 0xff
00006ACC  ; data: 0xf7, 0xe0
00006ACE  ori.b  #$0, d0
00006AD2  ; data: 0x0f, 0xff
00006AD4  ; data: 0xfb, 0x00
00006AD6  ori.b  #$0, d0
00006ADA  ; data: 0x40, 0x3c
00006ADC  ori.b  #$1, d0
00006AE0  ori.w  #$2021, d0
00006AE4  ; data: 0x02, 0xff
00006AE6  ; data: 0xff, 0xff
00006AE8  ; data: 0xe2, 0xc0
00006AEA  ori.b  #$0, d0
00006AEE  ; data: 0x07, 0xff
00006AF0  dc.w   $fc00
00006AF2  ori.b  #$0, -(a0)
00006AF6  ori.b  #$0, d2
00006AFA  move.l d0, -(a3)
00006AFC  ori.w  #$f070, d0
00006B00  ; data: 0x15, 0xe7
00006B02  ; data: 0xff, 0xff
00006B04  asl.b  #$3, d0
00006B06  ori.b  #$0, d0
00006B0A  ; data: 0x03, 0xff
00006B0C  ; data: 0xff, 0x80
00006B0E  ori.b  #$0, (a0)
00006B12  ori.b  #$0, d0
00006B16  ; data: 0x1f, 0xc0
00006B18  ; data: 0x02, 0xe1
00006B1A  dc.w   $f670
00006B1C  ; data: 0x08, 0xfb
00006B1E  ; data: 0xff, 0xff
00006B20  asr.b  #$5, d0
00006B22  ori.b  #$0, d0
00006B26  ; data: 0x03, 0xff
00006B28  ; data: 0xff, 0xc0
00006B2A  ori.b  #$0, d0
00006B2E  ori.b  #$0, d0
00006B32  ; data: 0x1f, 0xe0
00006B34  bset.b d0, (a1)
00006B36  dc.w   $ff30
00006B38  ; data: 0x50, 0xff
00006B3A  ; data: 0xff, 0xff
00006B3C  asr.w  #$6, d0
00006B3E  ori.b  #$0, d0
00006B42  ; data: 0x01, 0xff
00006B44  ; data: 0xff, 0xe0
00006B46  ori.b  #$0, d1
00006B4A  ori.b  #$8, d0
00006B4E  bset.b d1, ([$bf0071ff])
00006B56  ; data: 0xff, 0xff
00006B58  asr.l  #$8, d0
00006B5A  ori.b  #$0, d0
00006B5E  ; data: 0x00, 0xff
00006B60  ; data: 0xff, 0xe0
00006B62  ori.b  #$0, d1
00006B66  ori.b  #$10, d0
00006B6A  move.l #$21f13f84, $f9ffffff.l
00006B74  dc.w   $f000
00006B76  ori.b  #$0, d0
00006B7A  ; data: 0x00, 0x7f
00006B7C  ; data: 0xff, 0xf0
00006B7E  btst.l d0, d1
00006B80  dc.w   $fc00
00006B82  ori.b  #$78, d0
00006B86  ori.l  #$43e02f80, -$1(a6)
00006B8E  ; data: 0xff, 0xff
00006B90  and.b  d0, d0
00006B92  ori.b  #$0, d0
00006B96  ; data: 0x00, 0x3f
00006B98  ; data: 0xff, 0xf9
00006B9A  btst.l d3, d0
00006B9C  ; data: 0xff, 0x00
00006B9E  ori.b  #$e8, d0
00006BA2  btst.l d0, d5
00006BA4  ; data: 0x37, 0xc0
00006BA6  bchg.b d7, (a0)
00006BA8  ; data: 0xff, 0xff
00006BAA  ; data: 0xff, 0xff
00006BAC  dc.w   $f000
00006BAE  ori.b  #$0, d0
00006BB2  ; data: 0x00, 0x3f
00006BB4  ; data: 0xff, 0xf7
00006BB6  sub.b  d0, d6
00006BB8  move.w d0, -(a7)
00006BBA  subi.b #$d0, d0
00006BBE  ; data: 0x00, 0x0f
00006BC0  ; data: 0x3f, 0xe6
00006BC2  ; data: 0x4f, 0x0e
00006BC4  ; data: 0xff, 0xff
00006BC6  ; data: 0xff, 0xff
00006BC8  asr.b  #$8, d0
00006BCA  ori.b  #$0, d0
00006BCE  ori.b  #$eb, (a7)+
00006BD2  ; data: 0xce, 0x0a
00006BD4  divu.w -(a0), d3
00006BD6  or.b   d0, d1
00006BD8  ; data: 0x00, 0xe0
00006BDA  ; data: 0x00, 0xff
00006BDC  ; data: 0xbf, 0xff
00006BDE  bchg.b d3, (a7)+
00006BE0  ; data: 0x7f, 0xff
00006BE2  ; data: 0xff, 0xfb
00006BE4  nbcd.b d0
00006BE6  ori.b  #$0, d0
00006BEA  ; data: 0x00, 0x0f
00006BEC  ; data: 0xff, 0xff
00006BEE  asr.b  #$2, d1
00006BF0  muls.w -(a0), d3
00006BF2  subi.b #$50, d1
00006BF6  ; data: 0x00, 0xff
00006BF8  ; data: 0xff, 0xfe
00006BFA  ; data: 0x00, 0xbf
00006BFC  ; data: 0xff, 0xff
00006BFE  ; data: 0xff, 0xfe
00006C00  or.b   d0, d0
00006C02  ori.b  #$0, d0
00006C06  ori.b  #$ee, d7
00006C0A  ; data: 0xfb, 0x07
00006C0C  dc.w   $edf1
00006C0E  andi.b #$20, d0
00006C12  ; data: 0x01, 0xff
00006C14  ; data: 0xff, 0xf7
00006C16  ; data: 0xc5, 0x7f
00006C18  ; data: 0xff, 0xff
00006C1A  ; data: 0xff, 0xfc
00006C1C  ori.b  #$0, d0
00006C20  ori.b  #$3, d0
00006C24  ; data: 0xff, 0xff
00006C26  asl.l  #$1, d7
00006C28  adda.l (a0, d0.w), a6
00006C2C  subi.b #$df, d0
00006C30  ; data: 0xff, 0xfb
00006C32  ; data: 0xc2, 0xbf
00006C34  ; data: 0xff, 0xff
00006C36  ; data: 0xff, 0xfe
00006C38  ori.b  #$0, d0
00006C3C  ori.b  #$1, d0
00006C40  ; data: 0xff, 0xfb
00006C42  ; data: 0xeb, 0xdb
00006C44  ; data: 0xae, 0x70
00006C46  ; data: 0x08, 0x00
00006C48  moveq  #$0, d0
00006C4A  ; data: 0x1e, 0xff
00006C4C  adda.l $d55fffff.l, a7
00006C52  ; data: 0xff, 0xd5
00006C54  ori.b  #$0, d0
00006C58  ori.b  #$0, d0
00006C5C  ; data: 0xff, 0xff
00006C5E  ; data: 0xf1, 0x07
00006C60  ; data: 0xf9, 0x00
00006C62  ori.b  #$0, d1
00006C66  ; data: 0x3e, 0xff
00006C68  ; data: 0xf7, 0xf8
00006C6A  or.b   d7, (a7)+
00006C6C  ; data: 0xff, 0xff
00006C6E  ; data: 0xff, 0xf8
00006C70  ori.b  #$0, d0
00006C74  ori.b  #$0, d0
00006C78  ; data: 0x7f, 0xff
00006C7A  dc.w   $fa0f
00006C7C  dc.w   $f20b
00006C7E  sbcd.b d3, d1
00006C80  dc.w   $f800
00006C82  ; data: 0x3f, 0xff
00006C84  ; data: 0xff, 0xf5
00006C86  dc.w   $f41f
00006C88  ; data: 0xff, 0xff
00006C8A  ; data: 0xff, 0xe8
00006C8C  ori.b  #$0, d0
00006C90  ori.b  #$0, d0
00006C94  ; data: 0x3f, 0xff
00006C96  ; data: 0xff, 0x0d
00006C98  ; data: 0x47, 0x0f
00006C9A  neg.b  d1
00006C9C  dc.w   $f407
00006C9E  ; data: 0xdf, 0xff
00006CA0  ; data: 0xff, 0xfb
00006CA2  ; data: 0xfb, 0x9f
00006CA4  ; data: 0xff, 0xff
00006CA6  ; data: 0xff, 0xd0
00006CA8  ori.b  #$0, d0
00006CAC  ori.b  #$0, d0
00006CB0  ; data: 0x1f, 0xff
00006CB2  dc.w   $fa8b
00006CB4  ; data: 0xb0, 0x0e
00006CB6  ; data: 0xa0, 0x01
00006CB8  or.b   d7, d4
00006CBA  ; data: 0xff, 0xff
00006CBC  ; data: 0xff, 0xff
00006CBE  ; data: 0xff, 0xff
00006CC0  ; data: 0xff, 0xff
00006CC2  ; data: 0xff, 0xe0
00006CC4  ori.b  #$0, d0
00006CC8  ori.b  #$0, d0
00006CCC  ; data: 0x0f, 0xff
00006CCE  ; data: 0xff, 0xfd
00006CD0  ; data: 0x0e, 0x84
00006CD2  ; data: 0x7f, 0x05
00006CD4  move.l -$1(a7), d0
00006CD8  ; data: 0xff, 0xff
00006CDA  ; data: 0xdf, 0xff
00006CDC  ; data: 0xff, 0xff
00006CDE  ; data: 0xff, 0xc0
00006CE0  ori.b  #$0, d0
00006CE4  ori.b  #$0, d0
00006CE8  ; data: 0x07, 0xff
00006CEA  ; data: 0xff, 0xaa
00006CEC  ; data: 0xaf, 0xc0
00006CEE  ; data: 0x1f, 0x8f
00006CF0  and.w  -$201(a7), d0
00006CF4  ; data: 0xfd, 0x7f
00006CF6  ; data: 0x1f, 0xff
00006CF8  ; data: 0xff, 0xff
00006CFA  ; data: 0xff, 0x80
00006CFC  ori.b  #$0, d0
00006D00  ori.b  #$0, d0
00006D04  ; data: 0x03, 0xff
00006D06  ; data: 0xff, 0xff
00006D08  divu.w d4, d3
00006D0A  subq.l #$7, a7
00006D0C  ; data: 0xe0, 0xff
00006D0E  dc.w   $feff
00006D10  cmpa.w $7fff.w, a5
00006D14  ; data: 0xff, 0xff
00006D16  ; data: 0xff, 0x00
00006D18  ori.b  #$0, d0
00006D1C  ori.b  #$0, d0
00006D20  ; data: 0x01, 0xff
00006D22  ; data: 0xff, 0xff
00006D24  ; data: 0x03, 0xba
00006D26  lsl.b  #$7, d4
00006D28  ; data: 0xe1, 0xff
00006D2A  ; data: 0xff, 0xdf
00006D2C  moveq  #$14, d6
00006D2E  ; data: 0x7f, 0xff
00006D30  ; data: 0xff, 0xff
00006D32  dc.w   $fc80
00006D34  ori.b  #$0, d0
00006D38  ori.b  #$0, d0
00006D3C  ; data: 0x00, 0x7f
00006D3E  ; data: 0xff, 0xff
00006D40  ; data: 0x8d, 0xfd
00006D42  dc.w   $f006
00006D44  ror.w  ([, a7.l * 8], $fe1f)
00006D4A  ; data: 0xff, 0xff
00006D4C  ; data: 0xff, 0xff
00006D4E  dc.w   $fc00
00006D50  ori.b  #$0, d0
00006D54  ori.b  #$0, d0
00006D58  ; data: 0x00, 0x3f
00006D5A  ; data: 0xff, 0xff
00006D5C  ; data: 0xc1, 0xff
00006D5E  dc.w   $faab
00006D60  ; data: 0xff, 0xff
00006D62  dc.w   $ff55
00006D64  ; data: 0x7d, 0xff
00006D66  ; data: 0xff, 0xff
00006D68  ; data: 0xff, 0xff
00006D6A  addq.b #$4, d0
00006D6C  ori.b  #$0, d0
00006D70  ori.b  #$0, d0
00006D74  ori.b  #$ff, (a7)+
00006D78  ; data: 0xc3, 0xff
00006D7A  ; data: 0xfd, 0xf5
00006D7C  ; data: 0xff, 0xff
00006D7E  dc.w   $fe9f
00006D80  ; data: 0xff, 0xff
00006D82  ; data: 0xff, 0xff
00006D84  ; data: 0xff, 0xfe
00006D86  and.b  d0, d0
00006D88  ori.b  #$0, d0
00006D8C  ori.b  #$0, d0
00006D90  ; data: 0x00, 0x0f
00006D92  ; data: 0xff, 0xff
00006D94  ; data: 0xe3, 0xff
00006D96  dc.w   $faef
00006D98  ; data: 0xff, 0x7f
00006D9A  ; data: 0xa7, 0x7f
00006D9C  ; data: 0xff, 0xff
00006D9E  ; data: 0xff, 0xff
00006DA0  ; data: 0xff, 0xfd
00006DA2  addq.b #$8, d0
00006DA4  ori.b  #$0, d0
00006DA8  ori.b  #$0, d0
00006DAC  ori.b  #$ff, d3
00006DB0  ; data: 0xf7, 0xff
00006DB2  ; data: 0xff, 0xff
00006DB4  ; data: 0xff, 0x9f
00006DB6  ; data: 0xff, 0xff
00006DB8  ; data: 0xff, 0xff
00006DBA  ; data: 0xff, 0xff
00006DBC  ; data: 0xff, 0xff
00006DBE  and.b  d0, d0
00006DC0  ori.b  #$0, d0
00006DC4  ori.b  #$0, d0
00006DC8  ori.b  #$ff, d1
00006DCC  ; data: 0xff, 0x8f
00006DCE  ; data: 0xff, 0xbf
00006DD0  ; data: 0xff, 0xef
00006DD2  ; data: 0xbf, 0xff
00006DD4  ; data: 0xff, 0xff
00006DD6  ; data: 0xff, 0xff
00006DD8  ; data: 0xff, 0xfd
00006DDA  or.b   d0, d0
00006DDC  ori.b  #$0, d0
00006DE0  ori.b  #$0, d0
00006DE4  ori.b  #$ff, d0
00006DE8  ; data: 0xff, 0x9f
00006DEA  ; data: 0xff, 0xbf
00006DEC  ; data: 0xff, 0xff
00006DEE  ; data: 0xff, 0xff
00006DF0  ; data: 0xff, 0xff
00006DF2  ; data: 0xff, 0xff
00006DF4  ; data: 0xff, 0xff
00006DF6  ori.b  #$0, d0
00006DFA  ori.b  #$0, d0
00006DFE  ori.b  #$0, d0
00006E02  ; data: 0x3f, 0xff
00006E04  ; data: 0xff, 0xdf
00006E06  ; data: 0xff, 0xbf
00006E08  ; data: 0xff, 0xff
00006E0A  ; data: 0xff, 0xff
00006E0C  ; data: 0xff, 0xff
00006E0E  ; data: 0xff, 0xff
00006E10  ; data: 0xff, 0xfc
00006E12  ori.b  #$0, d0
00006E16  ori.b  #$0, d0
00006E1A  ori.b  #$0, d0
00006E1E  ; data: 0x0f, 0xff
00006E20  ; data: 0xff, 0xff
00006E22  dc.w   $fe1f
00006E24  ; data: 0xff, 0xff
00006E26  ; data: 0xff, 0xff
00006E28  ; data: 0xff, 0xff
00006E2A  ; data: 0xff, 0xff
00006E2C  dc.w   $feb0
00006E2E  ori.b  #$0, d0
00006E32  ori.b  #$0, d0
00006E36  ori.b  #$0, d0
00006E3A  ; data: 0x07, 0xff
00006E3C  ; data: 0xff, 0xff
00006E3E  ; data: 0xff, 0x9f
00006E40  ; data: 0xff, 0xff
00006E42  ; data: 0xff, 0xff
00006E44  ; data: 0xff, 0xff
00006E46  ; data: 0xff, 0xff
00006E48  ; data: 0xfd, 0x60
00006E4A  ori.b  #$0, d0
00006E4E  ori.b  #$0, d0
00006E52  ori.b  #$0, d0
00006E56  ; data: 0x01, 0xff
00006E58  ; data: 0xff, 0xff
00006E5A  ; data: 0xff, 0xdf
00006E5C  ; data: 0xff, 0xff
00006E5E  ; data: 0xff, 0xff
00006E60  ; data: 0xff, 0xff
00006E62  ; data: 0xff, 0xff
00006E64  ; data: 0xfd, 0x80
00006E66  ori.b  #$0, d0
00006E6A  ori.b  #$0, d0
00006E6E  ori.b  #$0, d0
00006E72  ; data: 0x00, 0xff
00006E74  ; data: 0xff, 0xff
00006E76  ; data: 0xff, 0xff
00006E78  ; data: 0xff, 0xff
00006E7A  ; data: 0xff, 0xff
00006E7C  ; data: 0xff, 0xff
00006E7E  ; data: 0xff, 0xff
00006E80  addx.b d0, d3
00006E82  ori.b  #$0, d0
00006E86  ori.b  #$0, d0
00006E8A  ori.b  #$0, d0
00006E8E  ; data: 0x00, 0x3f
00006E90  ; data: 0xff, 0xff
00006E92  ; data: 0xf7, 0xff
00006E94  ; data: 0xff, 0xff
00006E96  ; data: 0xff, 0xff
00006E98  ; data: 0xff, 0xff
00006E9A  ; data: 0xff, 0xff
00006E9C  dc.w   $fc00
00006E9E  ori.b  #$0, d0
00006EA2  ori.b  #$0, d0
00006EA6  ori.b  #$0, d0
00006EAA  ; data: 0x00, 0x0f
00006EAC  ; data: 0xff, 0xff
00006EAE  ; data: 0xff, 0xff
00006EB0  ; data: 0xff, 0xff
00006EB2  ; data: 0xff, 0xff
00006EB4  ; data: 0xff, 0xff
00006EB6  ; data: 0xff, 0xff
00006EB8  add.b  d0, d0
00006EBA  ori.b  #$0, d0
00006EBE  ori.b  #$0, d0
00006EC2  ori.b  #$0, d0
00006EC6  ori.b  #$ff, d3
00006ECA  ; data: 0xff, 0xff
00006ECC  ; data: 0xff, 0xff
00006ECE  ; data: 0xff, 0xff
00006ED0  ; data: 0xff, 0xff
00006ED2  ; data: 0xff, 0xff
00006ED4  and.b  d0, d0
00006ED6  ori.b  #$0, d0
00006EDA  ori.b  #$0, d0
00006EDE  ori.b  #$0, d0
00006EE2  ori.b  #$ff, d0
00006EE6  ; data: 0xff, 0xff
00006EE8  ; data: 0xff, 0xff
00006EEA  ; data: 0xff, 0xff
00006EEC  ; data: 0xff, 0xff
00006EEE  ; data: 0xff, 0xff
00006EF0  ori.b  #$0, d0
00006EF4  ori.b  #$0, d0
00006EF8  ori.b  #$0, d0
00006EFC  ori.b  #$0, d0
00006F00  ; data: 0x3f, 0xff
00006F02  ; data: 0xff, 0xff
00006F04  ; data: 0xff, 0xff
00006F06  ; data: 0xff, 0xff
00006F08  ; data: 0xff, 0xff
00006F0A  ; data: 0xff, 0xfc
00006F0C  ori.b  #$0, d0
00006F10  ori.b  #$0, d0
00006F14  ori.b  #$0, d0
00006F18  ori.b  #$0, d0
00006F1C  ; data: 0x07, 0xff
00006F1E  ; data: 0xff, 0xff
00006F20  ; data: 0xff, 0xff
00006F22  ; data: 0xff, 0xff
00006F24  ; data: 0xff, 0xff
00006F26  ; data: 0xff, 0xe0
00006F28  ori.b  #$0, d0
00006F2C  ori.b  #$0, d0
00006F30  ori.b  #$0, d0
00006F34  ori.b  #$0, d0
00006F38  ; data: 0x01, 0xff
00006F3A  ; data: 0xff, 0xff
00006F3C  ; data: 0xff, 0xff
00006F3E  ; data: 0xff, 0xff
00006F40  ; data: 0xff, 0xff
00006F42  ; data: 0xff, 0x80
00006F44  ori.b  #$0, d0
00006F48  ori.b  #$0, d0
00006F4C  ori.b  #$0, d0
00006F50  ori.b  #$0, d0
00006F54  ; data: 0x00, 0x3f
00006F56  ; data: 0xff, 0xff
00006F58  ; data: 0xff, 0xff
00006F5A  ; data: 0xff, 0xff
00006F5C  ; data: 0xff, 0xff
00006F5E  dc.w   $fc00
00006F60  ori.b  #$0, d0
00006F64  ori.b  #$0, d0
00006F68  ori.b  #$0, d0
00006F6C  ori.b  #$0, d0
00006F70  ori.b  #$ff, d7
00006F74  ; data: 0xff, 0xff
00006F76  ; data: 0xff, 0xff
00006F78  ; data: 0xff, 0xff
00006F7A  asr.b  #$8, d0
00006F7C  ori.b  #$0, d0
00006F80  ori.b  #$0, d0
00006F84  ori.b  #$0, d0
00006F88  ori.b  #$0, d0
00006F8C  ori.b  #$ff, d0
00006F90  ; data: 0xff, 0xff
00006F92  ; data: 0xff, 0xff
00006F94  ; data: 0xff, 0xff
00006F96  ori.b  #$0, d0
00006F9A  ori.b  #$0, d0
00006F9E  ori.b  #$0, d0
00006FA2  ori.b  #$0, d0
00006FA6  ori.b  #$0, d0
00006FAA  ; data: 0x0f, 0xff
00006FAC  ; data: 0xff, 0xff
00006FAE  ; data: 0xff, 0xff
00006FB0  ; data: 0xff, 0xf0
00006FB2  ori.b  #$0, d0
00006FB6  ori.b  #$0, d0
00006FBA  ori.b  #$0, d0
00006FBE  ori.b  #$0, d0
00006FC2  ori.b  #$0, d0
00006FC6  ; data: 0x00, 0xff
00006FC8  ; data: 0xff, 0xff
00006FCA  ; data: 0xff, 0xff
00006FCC  ; data: 0xff, 0x00
00006FCE  ori.b  #$0, d0
00006FD2  ori.b  #$0, d0
00006FD6  ori.b  #$0, d0
00006FDA  ori.b  #$0, d0
00006FDE  ori.b  #$0, d0
00006FE2  ori.b  #$ff, d7
00006FE6  ; data: 0xff, 0xff
00006FE8  ori.b  #$0, d0
00006FEC  ori.b  #$0, d0
00006FF0  ori.b  #$0, d0
00006FF4  ori.b  #$0, d0
00006FF8  ori.b  #$0, d0
00006FFC  ori.b  #$0, d0
00007000  ; data: 0x07, 0xff
00007002  ; data: 0xff, 0x80
00007004  ori.b  #$0, d0
00007008  ori.b  #$0, d0
0000700C  ori.b  #$0, d0
00007010  ori.b  #$0, d0
00007014  ori.b  #$0, d0
00007018  ori.b  #$0, d0
0000701C  ; data: 0x07, 0xff
0000701E  ; data: 0xff, 0xe0
00007020  ori.b  #$0, d0
00007024  ori.b  #$0, d0
00007028  ori.b  #$0, d0
0000702C  ori.b  #$0, d0
00007030  ori.b  #$0, d0
00007034  ori.b  #$7, d0
00007038  ; data: 0xff, 0xff
0000703A  ; data: 0xff, 0xff
0000703C  asr.b  #$8, d0
0000703E  ori.b  #$0, d0
00007042  ori.b  #$0, d0
00007046  ori.b  #$0, d0
0000704A  ori.b  #$0, d0
0000704E  ori.b  #$0, d0
00007052  ; data: 0x00, 0xff
00007054  ; data: 0xff, 0xff
00007056  ; data: 0xff, 0xff
00007058  ; data: 0xff, 0x00
0000705A  ori.b  #$0, d0
0000705E  ori.b  #$0, d0
00007062  ori.b  #$0, d0
00007066  ori.b  #$0, d0
0000706A  ori.b  #$0, d0
0000706E  ; data: 0x0f, 0xff
00007070  ; data: 0xff, 0xff
00007072  ; data: 0xff, 0xff
00007074  ; data: 0xff, 0xf0
00007076  ori.b  #$0, d0
0000707A  ori.b  #$0, d0
0000707E  ori.b  #$0, d0
00007082  ori.b  #$0, d0
00007086  ori.b  #$0, d0
0000708A  ; data: 0xff, 0xff
0000708C  ; data: 0xff, 0xff
0000708E  ; data: 0xff, 0xff
00007090  ; data: 0xff, 0xff
00007092  ori.b  #$0, d0
00007096  ori.b  #$0, d0
0000709A  ori.b  #$0, d0
0000709E  ori.b  #$0, d0
000070A2  ori.b  #$7, d0
000070A6  ; data: 0xff, 0xff
000070A8  ; data: 0xff, 0xff
000070AA  ; data: 0xff, 0xff
000070AC  ; data: 0xff, 0xff
000070AE  asr.b  #$8, d0
000070B0  ori.b  #$0, d0
000070B4  ori.b  #$0, d0
000070B8  ori.b  #$0, d0
000070BC  ori.b  #$0, d0
000070C0  ; data: 0x00, 0x3f
000070C2  ; data: 0xff, 0xff
000070C4  ; data: 0xff, 0xff
000070C6  ; data: 0xff, 0xff
000070C8  ; data: 0xff, 0xff
000070CA  dc.w   $fc00
000070CC  ori.b  #$0, d0
000070D0  ori.b  #$0, d0
000070D4  ori.b  #$0, d0
000070D8  ori.b  #$0, d0
000070DC  ; data: 0x01, 0xff
000070DE  ; data: 0xff, 0xff
000070E0  ; data: 0xf9, 0xff
000070E2  ; data: 0xff, 0xff
000070E4  ; data: 0xff, 0xff
000070E6  ; data: 0xff, 0x80
000070E8  ori.b  #$0, d0
000070EC  ori.b  #$0, d0
000070F0  ori.b  #$0, d0
000070F4  ori.b  #$0, d0
000070F8  ; data: 0x07, 0xff
000070FA  ; data: 0xff, 0xff
000070FC  ; data: 0xff, 0xff
000070FE  ; data: 0xff, 0xff
00007100  ; data: 0xff, 0xff
00007102  ; data: 0xff, 0xe0
00007104  ori.b  #$0, d0
00007108  ori.b  #$0, d0
0000710C  ori.b  #$0, d0
00007110  ori.b  #$0, d0
00007114  ; data: 0x3f, 0xff
00007116  ; data: 0xff, 0xff
00007118  ; data: 0xff, 0xff
0000711A  ; data: 0xff, 0xff
0000711C  ; data: 0xff, 0xff
0000711E  ; data: 0xff, 0xfc
00007120  ori.b  #$0, d0
00007124  ori.b  #$0, d0
00007128  ori.b  #$0, d0
0000712C  ori.b  #$0, d0
00007130  ; data: 0xff, 0xff
00007132  ; data: 0xff, 0xff
00007134  ; data: 0xff, 0xff
00007136  ; data: 0xff, 0xff
00007138  ; data: 0xff, 0xff
0000713A  ; data: 0xff, 0xff
0000713C  ori.b  #$0, d0
00007140  ori.b  #$0, d0
00007144  ori.b  #$0, d0
00007148  ori.b  #$3, d0
0000714C  ; data: 0xff, 0xff
0000714E  ; data: 0xff, 0xff
00007150  ; data: 0xff, 0xff
00007152  ; data: 0xff, 0xff
00007154  ; data: 0xff, 0xff
00007156  ; data: 0xff, 0xff
00007158  and.b  d0, d0
0000715A  ori.b  #$0, d0
0000715E  ori.b  #$0, d0
00007162  ori.b  #$0, d0
00007166  ; data: 0x00, 0x0f
00007168  ; data: 0xff, 0xff
0000716A  ; data: 0xff, 0xff
0000716C  ; data: 0xff, 0xff
0000716E  ; data: 0xff, 0xff
00007170  ; data: 0xff, 0xff
00007172  ; data: 0xff, 0xff
00007174  dc.w   $f000
00007176  ori.b  #$0, d0
0000717A  ori.b  #$0, d0
0000717E  ori.b  #$0, d0
00007182  ; data: 0x00, 0x3f
00007184  ; data: 0xff, 0xff
00007186  ; data: 0xff, 0xff
00007188  ; data: 0xff, 0xe7
0000718A  ; data: 0xff, 0xff
0000718C  ; data: 0xff, 0xff
0000718E  ; data: 0xff, 0xff
00007190  dc.w   $fc00
00007192  ori.b  #$0, d0
00007196  ori.b  #$0, d0
0000719A  ori.b  #$0, d0
0000719E  ; data: 0x00, 0xff
000071A0  ; data: 0xff, 0xff
000071A2  ; data: 0xff, 0xff
000071A4  ; data: 0xff, 0x83
000071A6  ; data: 0xff, 0xff
000071A8  ; data: 0xff, 0xff
000071AA  ; data: 0xff, 0xff
000071AC  ; data: 0xff, 0x00
000071AE  ori.b  #$0, d0
000071B2  ori.b  #$0, d0
000071B6  ori.b  #$0, d0
000071BA  ; data: 0x01, 0xff
000071BC  ; data: 0xff, 0xff
000071BE  ; data: 0xff, 0xff
000071C0  dc.w   $fc47
000071C2  ; data: 0xff, 0xff
000071C4  ; data: 0xff, 0xff
000071C6  ; data: 0xdf, 0xff
000071C8  ; data: 0xff, 0x80
000071CA  ori.b  #$0, d0
000071CE  ori.b  #$0, d0
000071D2  ori.b  #$0, d0
000071D6  ; data: 0x07, 0xff
000071D8  ; data: 0xff, 0xff
000071DA  ; data: 0xff, 0xff
000071DC  ; data: 0xff, 0xb7
000071DE  ; data: 0xff, 0xff
000071E0  ; data: 0xff, 0xff
000071E2  ; data: 0xdf, 0xff
000071E4  ; data: 0xff, 0xe0
000071E6  ori.b  #$0, d0
000071EA  ori.b  #$0, d0
000071EE  ori.b  #$0, d0
000071F2  ; data: 0x0f, 0xff
000071F4  ; data: 0xff, 0xff
000071F6  ; data: 0xff, 0xff
000071F8  ; data: 0xff, 0xff
000071FA  ; data: 0xff, 0xff
000071FC  ; data: 0xff, 0xff
000071FE  ; data: 0xff, 0xff
00007200  ; data: 0xff, 0xf0
00007202  ori.b  #$0, d0
00007206  ori.b  #$0, d0
0000720A  ori.b  #$0, d0
0000720E  ; data: 0x3f, 0xff
00007210  ; data: 0xff, 0xff
00007212  ; data: 0xff, 0xff
00007214  ; data: 0xff, 0xff
00007216  ; data: 0xff, 0xff
00007218  ; data: 0xff, 0xff
0000721A  ; data: 0xff, 0xff
0000721C  ; data: 0xff, 0xfc
0000721E  ori.b  #$0, d0
00007222  ori.b  #$0, d0
00007226  ori.b  #$0, d0
0000722A  ; data: 0xff, 0xff
0000722C  ; data: 0xff, 0xff
0000722E  ; data: 0x7f, 0xff
00007230  ; data: 0xff, 0xff
00007232  ; data: 0xf3, 0xff
00007234  ; data: 0xff, 0xff
00007236  ; data: 0xff, 0xff
00007238  ; data: 0xff, 0xff
0000723A  ori.b  #$0, d0
0000723E  ori.b  #$0, d0
00007242  ori.b  #$1, d0
00007246  ; data: 0xff, 0xff
00007248  ; data: 0xff, 0xc6
0000724A  ; data: 0x3f, 0xff
0000724C  ; data: 0xff, 0xff
0000724E  ror.w  d0, d7
00007250  ; data: 0xff, 0xff
00007252  ; data: 0xff, 0xff
00007254  ; data: 0xff, 0xff
00007256  or.b   d0, d0
00007258  ori.b  #$0, d0
0000725C  ori.b  #$0, d0
00007260  ori.b  #$ff, d3
00007264  ; data: 0xff, 0xf5
00007266  ; data: 0x0f, 0xff
00007268  ; data: 0xff, 0xff
0000726A  ; data: 0x80, 0x0f
0000726C  ; data: 0xcf, 0xff
0000726E  ; data: 0xff, 0xff
00007270  ; data: 0xff, 0xff
00007272  and.b  d0, d0
00007274  ori.b  #$0, d0
00007278  ori.b  #$0, d0
0000727C  ; data: 0x00, 0x0f
0000727E  ; data: 0xff, 0xff
00007280  ; data: 0xff, 0xaa
00007282  ; data: 0x87, 0xff
00007284  ; data: 0xff, 0xfe
00007286  ; data: 0x84, 0x7f
00007288  ; data: 0xdf, 0xff
0000728A  ; data: 0xff, 0xff
0000728C  ; data: 0xff, 0xff
0000728E  dc.w   $f000
00007290  ori.b  #$0, d0
00007294  ori.b  #$0, d0
00007298  ori.b  #$ff, (a7)+
0000729C  dc.w   $ff54
0000729E  ; data: 0x07, 0xff
000072A0  ; data: 0xff, 0xf0
000072A2  ; data: 0x02, 0xbf
000072A4  ; data: 0xff, 0xff
000072A6  ; data: 0xff, 0xff
000072A8  ; data: 0xff, 0xff
000072AA  dc.w   $fc00
000072AC  ori.b  #$0, d0
000072B0  ori.b  #$0, d0
000072B4  ; data: 0x00, 0x3f
000072B6  ; data: 0xff, 0xff
000072B8  dc.w   $feaa
000072BA  ; data: 0xa7, 0xff
000072BC  ; data: 0xff, 0xf0
000072BE  ; data: 0x05, 0x7f
000072C0  ; data: 0xff, 0xff
000072C2  ; data: 0xff, 0xff
000072C4  ; data: 0xff, 0xff
000072C6  dc.w   $fe00
000072C8  ori.b  #$0, d0
000072CC  ori.b  #$0, d0
000072D0  ; data: 0x00, 0x7f
000072D2  ; data: 0xff, 0xff
000072D4  ; data: 0xf9, 0x00
000072D6  ; data: 0x47, 0xff
000072D8  ; data: 0xff, 0xe0
000072DA  ; data: 0x1e, 0xff
000072DC  ; data: 0xff, 0xff
000072DE  ; data: 0xff, 0xff
000072E0  ; data: 0xff, 0xff
000072E2  ; data: 0xff, 0x00
000072E4  ori.b  #$0, d0
000072E8  ori.b  #$0, d0
000072EC  ; data: 0x01, 0xff
000072EE  ; data: 0xff, 0xff
000072F0  dc.w   $f880
000072F2  ; data: 0x5f, 0xff
000072F4  dc.w   $fcf8
000072F6  ; data: 0xa5, 0x55
000072F8  ; data: 0xff, 0xff
000072FA  ; data: 0xff, 0xff
000072FC  ; data: 0xff, 0xff
000072FE  ; data: 0xff, 0x80
00007300  ori.b  #$0, d0
00007304  ori.b  #$0, d0
00007308  ; data: 0x03, 0xff
0000730A  ; data: 0xff, 0xff
0000730C  dc.w   $f200
0000730E  ; data: 0x3f, 0xff
00007310  dc.w   $fee0
00007312  andi.l #$ffffffff, -$1(a2)
0000731A  ; data: 0xff, 0xc0
0000731C  ori.b  #$0, d0
00007320  ori.b  #$0, d0
00007324  ; data: 0x07, 0xff
00007326  ; data: 0xff, 0xff
00007328  asr.b  #$4, d0
0000732A  ; data: 0x3f, 0xff
0000732C  dc.w   $fe00
0000732E  move.l d1, $7fff(a2)
00007332  ; data: 0xff, 0x9f
00007334  ; data: 0xff, 0xff
00007336  ; data: 0xff, 0xe0
00007338  ori.b  #$0, d0
0000733C  ori.b  #$0, d0
00007340  ; data: 0x0f, 0xff
00007342  ; data: 0xff, 0xff
00007344  negx.b d0
00007346  ; data: 0x03, 0xff
00007348  dc.w   $fe00
0000734A  andi.b #$ff, d0
0000734E  ; data: 0xff, 0xff
00007350  ; data: 0xff, 0xff
00007352  ; data: 0xff, 0xf0
00007354  ori.b  #$0, d0
00007358  ori.b  #$0, d0
0000735C  ; data: 0x1f, 0xff
0000735E  ; data: 0xbf, 0xff
00007360  or.l   d2, d0
00007362  ; data: 0x87, 0xff
00007364  dc.w   $fe00
00007366  bchg.b d1, d0
00007368  ; data: 0xff, 0xff
0000736A  ; data: 0xff, 0xff
0000736C  ; data: 0xff, 0xff
0000736E  ; data: 0xff, 0xf8
00007370  ori.b  #$0, d0
00007374  ori.b  #$0, d0
00007378  ; data: 0x3f, 0xff
0000737A  ; data: 0xff, 0xff
0000737C  ; data: 0x00, 0xc0
0000737E  ; data: 0x07, 0xfe
00007380  dc.w   $f800
00007382  btst.l d1, d1
00007384  ; data: 0xff, 0xff
00007386  ; data: 0xff, 0xff
00007388  ; data: 0xff, 0xff
0000738A  ; data: 0xff, 0xfc
0000738C  ori.b  #$0, d0
00007390  ori.b  #$0, d0
00007394  ; data: 0x7f, 0xff
00007396  ; data: 0xff, 0xff
00007398  or.w   $3f8(a2), d0
0000739C  moveq  #$0, d4
0000739E  ori.l  #$ffffffff, (a1)
000073A4  ; data: 0xff, 0xff
000073A6  ; data: 0xff, 0xfe
000073A8  ori.b  #$0, d0
000073AC  ori.b  #$0, d0
000073B0  ; data: 0xbf, 0xff
000073B2  ; data: 0xff, 0xcf
000073B4  or.w   (invalid.w), d0
000073B8  ori.b  #$43, d0
000073BC  ; data: 0xff, 0xff
000073BE  ; data: 0xff, 0xff
000073C0  ; data: 0xff, 0xff
000073C2  ; data: 0xff, 0xff
000073C4  ori.b  #$0, d0
000073C8  ori.b  #$1, d0
000073CC  ; data: 0x3f, 0xff
000073CE  ; data: 0xff, 0x82
000073D0  ori.b  #$8, $0.w
000073D6  subi.b #$ff, d7
000073DA  ; data: 0xff, 0xff
000073DC  ; data: 0xff, 0xff
000073DE  ; data: 0xff, 0xff
000073E0  or.b   d0, d0
000073E2  ori.b  #$0, d0
000073E6  ori.b  #$ff, d2
000073EA  ; data: 0xff, 0x18
000073EC  ori.b  #$4, (a4)+
000073F0  ori.b  #$5f, d0
000073F4  ; data: 0xef, 0xff
000073F6  ; data: 0xff, 0xff
000073F8  ; data: 0xff, 0xff
000073FA  ; data: 0xff, 0xff
000073FC  and.b  d0, d0
000073FE  ori.b  #$0, d0
00007402  ori.b  #$ff, d4
00007406  dc.w   $fa0c
00007408  ; data: 0x00, 0x0e
0000740A  ori.b  #$0, d0
0000740E  move.l -(a7), (a0)+
00007410  ; data: 0x73, 0xff
00007412  ; data: 0xff, 0xff
00007414  ; data: 0xff, 0xff
00007416  ; data: 0xff, 0xff
00007418  asr.b  #$8, d0
0000741A  ori.b  #$0, d0
0000741E  ; data: 0x00, 0x08
00007420  ; data: 0xff, 0xff
00007422  dc.w   $fc02
00007424  ori.b  #$0, d0
00007428  ori.b  #$f7, d0
0000742C  ; data: 0x83, 0xff
0000742E  ; data: 0xff, 0xff
00007430  ; data: 0xff, 0xff
00007432  ; data: 0xff, 0xff
00007434  dc.w   $f000
00007436  ori.b  #$0, d0
0000743A  ori.b  #$ff, (a1)+
0000743E  dc.w   $f400
00007440  ori.b  #$0, d0
00007444  ori.b  #$fd, d0
00007448  ; data: 0x00, 0x3f
0000744A  ; data: 0xff, 0xff
0000744C  ; data: 0xff, 0xff
0000744E  ; data: 0xff, 0xff
00007450  dc.w   $f800
00007452  ori.b  #$0, d0
00007456  ori.b  #$ff, $1(a3, a7.l)
0000745C  ori.b  #$0, d0
00007460  ori.b  #$ff, d0
00007464  and.b  (a7)+, d0
00007466  ; data: 0xff, 0xff
00007468  ; data: 0xff, 0xff
0000746A  ; data: 0xff, 0xff
0000746C  dc.w   $fc00
0000746E  ori.b  #$0, d0
00007472  ori.b  #$f9, $7001(a7)
00007478  ori.b  #$0, d0
0000747C  ori.l  #$1fdf840f, d0
00007482  ; data: 0xff, 0xff
00007484  ; data: 0xff, 0xff
00007486  ; data: 0xff, 0xff
00007488  dc.w   $fc00
0000748A  ori.b  #$0, d0
0000748E  ori.w  #$fffc, (a7)+
00007492  or.b   d2, d0
00007494  ori.b  #$9, d0
00007498  ori.w  #$fc5b, $7(a0, d0.l)
0000749E  ; data: 0xff, 0xff
000074A0  ; data: 0xff, 0xff
000074A2  ; data: 0xff, 0xff
000074A4  dc.w   $fe00
000074A6  ori.b  #$0, d0
000074AA  ; data: 0x00, 0xbf
000074AC  ; data: 0xff, 0xa8
000074AE  move.l d0, d0
000074B0  ori.b  #$c, d0
000074B4  ; data: 0x00, 0x7f
000074B6  dc.w   $f811
000074B8  move.b d3, d0
000074BA  ; data: 0xff, 0xff
000074BC  ; data: 0xff, 0xff
000074BE  ; data: 0xff, 0xff
000074C0  ; data: 0xff, 0x00
000074C2  ori.b  #$0, d0
000074C6  ; data: 0x01, 0xff
000074C8  ; data: 0xff, 0xf0
000074CA  ori.b  #$81, d0
000074CE  ; data: 0xc0, 0x3e
000074D0  ; data: 0x00, 0xff
000074D2  asl.b  #$8, d0
000074D4  move.l d3, d0
000074D6  ; data: 0xff, 0xff
000074D8  ; data: 0xff, 0xff
000074DA  ; data: 0xff, 0xff
000074DC  ; data: 0xff, 0x80
000074DE  ori.b  #$0, d0
000074E2  ; data: 0x03, 0xfb
000074E4  dc.w   $f480
000074E6  ori.b  #$82, d0
000074EA  ; data: 0xc0, 0x7e
000074EC  ; data: 0x00, 0xff
000074EE  asr.b  #$8, d0
000074F0  ori.b  #$ff, d1
000074F4  ; data: 0xff, 0xff
000074F6  ; data: 0xff, 0xff
000074F8  ; data: 0xff, 0xc0
000074FA  ori.b  #$0, d0
000074FE  ; data: 0x03, 0xff
00007500  asl.b  #$8, d0
00007502  ori.b  #$ce, d0
00007506  ; data: 0x00, 0x3c
00007508  bset.b d0, -(a4)
0000750A  and.b  d0, d0
0000750C  ori.b  #$ff, d0
00007510  ; data: 0xff, 0xff
00007512  ; data: 0xff, 0xff
00007514  ; data: 0xff, 0xc0
00007516  ori.b  #$0, d0
0000751A  ; data: 0x07, 0xfb
0000751C  dc.w   $f000
0000751E  btst.b #$86, d0
00007522  ; data: 0x00, 0x0c
00007524  bset.b d1, d4
00007526  and.b  (a6)+, d0
00007528  ori.b  #$ff, d0
0000752C  ; data: 0xff, 0xff
0000752E  ; data: 0xff, 0xff
00007530  ; data: 0xff, 0xe0
00007532  ori.b  #$0, d0
00007536  ; data: 0x0f, 0xfd
00007538  dc.w   $f000
0000753A  move.l d0, d0
0000753C  ori.l  #$380308, -(a6)
00007542  and.b  (a7)+, d0
00007544  ori.b  #$ff, d0
00007548  ; data: 0xff, 0xff
0000754A  ; data: 0xff, 0xff
0000754C  ; data: 0xff, 0xf0
0000754E  ori.b  #$0, d0
00007552  ; data: 0x1f, 0xef
00007554  asr.b  #$4, d0
00007556  or.b   d0, d0
00007558  ori.l  #$3e0251, -(a6)
0000755E  and.b  d7, d0
00007560  ori.b  #$ff, d0
00007564  ; data: 0xff, 0xff
00007566  ; data: 0xff, 0xff
00007568  ; data: 0xff, 0xf8
0000756A  ori.b  #$0, d0
0000756E  ; data: 0x1f, 0xff
00007570  dc.w   $f800
00007572  ori.b  #$86, d0
00007576  ; data: 0x00, 0x7f
00007578  ori.l  #$c0070000, ([$ffffffff])
00007584  ; data: 0xff, 0xfc
00007586  ori.b  #$0, d0
0000758A  ; data: 0x3f, 0xbf
0000758C  asr.b  #$4, d0
0000758E  ori.b  #$84, d0
00007592  ; data: 0x00, 0x7f
00007594  ; data: 0x08, 0x20
00007596  and.b  (a7), d0
00007598  ori.b  #$ff, d0
0000759C  ; data: 0xff, 0xff
0000759E  ; data: 0xff, 0xff
000075A0  ; data: 0xff, 0xfe
000075A2  ori.b  #$0, d0
000075A6  ; data: 0x3f, 0xff
000075A8  dc.w   $f000
000075AA  ori.b  #$0, -$2(a0, d0.w)
000075B0  ; data: 0x08, 0x80
000075B2  and.b  (a3, d0.w), d0
000075B6  ; data: 0x0f, 0xff
000075B8  ; data: 0xff, 0xff
000075BA  ; data: 0xff, 0xff
000075BC  ; data: 0xff, 0xfe
000075BE  ori.b  #$0, d0
000075C2  ; data: 0x7f, 0xbf
000075C4  asr.b  #$8, d0
000075C6  ; data: 0x00, 0xe0
000075C8  andi.b #$ff, d0
000075CC  move.b d0, d5
000075CE  and.b  d7, d0
000075D0  ori.b  #$ff, d0
000075D4  ; data: 0xff, 0xff
000075D6  ; data: 0xff, 0xff
000075D8  ; data: 0xff, 0xff
000075DA  ori.b  #$0, d0
000075DE  ; data: 0xff, 0xdf
000075E0  and.b  d0, d0
000075E2  bchg.b d3, d0
000075E4  ori.b  #$ff, d0
000075E8  move.w d0, $3(a6, a4.w)
000075EC  ori.b  #$ff, d0
000075F0  ; data: 0xff, 0xff
000075F2  ; data: 0xff, 0xff
000075F4  ; data: 0xff, 0xff
000075F6  or.b   d0, d0
000075F8  ori.b  #$af, d0
000075FC  or.b   d0, d0
000075FE  eori.b #$0, d0
00007602  ; data: 0x00, 0x7f
00007604  cmp.w  d0, d3
00007606  add.b  d0, d0
00007608  ori.b  #$ff, d0
0000760C  ; data: 0xff, 0xff
0000760E  ; data: 0xff, 0xff
00007610  ; data: 0xff, 0xff
00007612  and.b  d0, d0
00007614  ori.b  #$47, d1
00007618  ori.b  #$0, d0
0000761C  move.l d0, -(a5)
0000761E  ; data: 0x00, 0x3e
00007620  asl.b  #$3, d0
00007622  add.b  -(a0), d4
00007624  ori.b  #$ff, d0
00007628  ; data: 0xff, 0xff
0000762A  ; data: 0xff, 0xff
0000762C  ; data: 0xff, 0xff
0000762E  and.b  d0, d0
00007630  ori.b  #$a0, d3
00007634  move.b d0, d0
00007636  move.l d0, d0
00007638  cmp.b  d2, d7
0000763A  ori.b  #$4, (a4)+
0000763E  dc.w   $f800
00007640  ori.b  #$ff, d0
00007644  ; data: 0xff, 0xff
00007646  ; data: 0xff, 0xff
00007648  ; data: 0xff, 0xff
0000764A  asr.b  #$8, d0
0000764C  ori.b  #$87, d3
00007650  ori.b  #$0, d0
00007654  addq.b #$6, (a6)+
00007656  ori.b  #$0, d0
0000765A  asr.b  #$8, d0
0000765C  ori.b  #$ff, d0
00007660  ; data: 0xff, 0xff
00007662  ; data: 0xff, 0xff
00007664  ; data: 0xff, 0xff
00007666  asr.b  #$8, d0
00007668  ori.b  #$aa, d7
0000766C  ori.b  #$2, d0
00007670  ; data: 0x10, 0x64
00007672  ori.b  #$0, d1
00007676  and.b  d0, d0
00007678  ori.b  #$ff, d0
0000767C  ; data: 0xff, 0xff
0000767E  ; data: 0xff, 0xff
00007680  ; data: 0xff, 0xff
00007682  dc.w   $f000
00007684  ori.b  #$1d, d7
00007688  ori.b  #$0, d0
0000768C  bset.b #$0, (a0, d0.w)
00007692  mulu.w d0, d0
00007694  ori.b  #$ff, d2
00007698  ; data: 0xff, 0xff
0000769A  ; data: 0xff, 0xff
0000769C  ; data: 0xff, 0xff
0000769E  dc.w   $f000
000076A0  ; data: 0x00, 0x0f
000076A2  dc.w   $faba
000076A4  ori.b  #$0, d0
000076A8  dc.w   $f8
000076AA  ori.b  #$0, d0
000076AE  mulu.w $6(a0, d0.w), d0
000076B2  ; data: 0x7f, 0xff
000076B4  ; data: 0xff, 0xff
000076B6  ; data: 0xff, 0xff
000076B8  ; data: 0xff, 0xff
000076BA  dc.w   $f800
000076BC  ; data: 0x00, 0x0f
000076BE  ; data: 0xfd, 0x80
000076C0  ori.b  #$0, d0
000076C4  move.b (a0, d0.w), $0.w
000076CA  mulu.w #$1, d0
000076CE  ; data: 0x3f, 0xff
000076D0  ; data: 0xdf, 0xff
000076D2  ; data: 0xff, 0xff
000076D4  ; data: 0xff, 0xff
000076D6  dc.w   $f800
000076D8  ori.b  #$0, (a7)+
000076DC  ori.b  #$0, d0
000076E0  ; data: 0x1d, 0xe0
000076E2  dc.w   $f00e
000076E4  ori.b  #$fc, d0
000076E8  ori.b  #$ff, d3
000076EC  ; data: 0xcf, 0xff
000076EE  ; data: 0xff, 0xff
000076F0  ; data: 0xff, 0xff
000076F2  dc.w   $fc00
000076F4  ori.b  #$80, (a7)+
000076F8  ori.b  #$0, d0
000076FC  ; data: 0x7d, 0xc7
000076FE  or.b   d6, d2
00007700  ori.b  #$fc, d0
00007704  move.l d7, -(a7)
00007706  ; data: 0xff, 0xff
00007708  ; data: 0xc7, 0xff
0000770A  ; data: 0xff, 0xff
0000770C  ; data: 0xff, 0xff
0000770E  dc.w   $fc00
00007710  ori.b  #$0, (a7, d0.w)
00007716  ; data: 0x00, 0x08
00007718  ; data: 0xff, 0xcf
0000771A  andi.b #$0, d2
0000771E  adda.l #$5f0fffff, a6
00007724  ; data: 0xbe, 0xff
00007726  ; data: 0xff, 0xff
00007728  ; data: 0xff, 0xff
0000772A  dc.w   $fe00
0000772C  ori.b  #$e0, -(a7)
00007730  ori.b  #$8, d0
00007734  ; data: 0xff, 0xdf
00007736  bclr.b d0, d1
00007738  ori.b  #$b8, d0
0000773C  move.w a7, -(a7)
0000773E  ; data: 0xff, 0xff
00007740  ; data: 0xff, 0x9f
00007742  ; data: 0xff, 0xff
00007744  ; data: 0xff, 0xff
00007746  dc.w   $fe00
00007748  ori.w  #$e9ec, $0(a7)
0000774E  ori.l  #$ffef0080, $0.w
00007756  ; data: 0xff, 0xf8
00007758  move.w (a7)+, -(a7)
0000775A  ; data: 0xff, 0xff
0000775C  ; data: 0xff, 0xdf
0000775E  ; data: 0xff, 0xff
00007760  ; data: 0xff, 0xff
00007762  dc.w   $fe00
00007764  ; data: 0x00, 0x4f
00007766  dc.w   $f4d0
00007768  ori.b  #$f1, d0
0000776C  ; data: 0xff, 0xe7
0000776E  ; data: 0x00, 0xc0
00007770  ori.b  #$f4, d0
00007774  moveq  #$1f, d7
00007776  ; data: 0xff, 0xff
00007778  ; data: 0xff, 0xff
0000777A  ; data: 0xff, 0xff
0000777C  ; data: 0xff, 0xff
0000777E  ; data: 0xff, 0x00
00007780  ori.w  #$e980, (a7)+
00007784  ori.b  #$3, d0
00007788  dc.w   $fd27
0000778A  ; data: 0x00, 0xe0
0000778C  ori.b  #$f0, d1
00007790  moveq  #$3f, d7
00007792  ; data: 0xff, 0xff
00007794  ; data: 0xff, 0xff
00007796  ; data: 0xff, 0xff
00007798  ; data: 0xff, 0xff
0000779A  ; data: 0xff, 0x00
0000779C  ori.l  #$f1800000, (a7)+
000077A2  ori.b  #$c7, d1
000077A6  ori.w  #$0, (a0, invalid.w)
000077AC  moveq  #$3f, d6
000077AE  ; data: 0xff, 0xff
000077B0  ; data: 0xff, 0xff
000077B2  ; data: 0xff, 0xff
000077B4  ; data: 0xff, 0xff
000077B6  ; data: 0xff, 0x80
000077B8  ; data: 0x00, 0xbf
000077BA  ; data: 0xaa, 0xc0
000077BC  ori.b  #$17, d0
000077C0  ; data: 0xfd, 0xe3
000077C2  ori.w  #$1, $e608.w
000077C8  move.w a7, -(a6)
000077CA  ; data: 0xff, 0xff
000077CC  ; data: 0xff, 0xff
000077CE  ; data: 0xff, 0xff
000077D0  ; data: 0xff, 0xff
000077D2  ; data: 0xff, 0x80
000077D4  ; data: 0x01, 0xff
000077D6  ; data: 0xf3, 0x80
000077D8  ori.b  #$3f, d0
000077DC  ; data: 0xff, 0xf3
000077DE  ori.w  #$2000, sr
000077E2  bra.b  $7814
000077E4  move.w a7, d1
000077E6  ; data: 0xff, 0xff
000077E8  ; data: 0xff, 0xff
000077EA  ; data: 0xff, 0xbf
000077EC  ; data: 0xff, 0xff
000077EE  ; data: 0xff, 0x80
000077F0  ; data: 0x01, 0xff
000077F2  ; data: 0xab, 0x00
000077F4  ori.b  #$37, d0
000077F8  ; data: 0xff, 0xe1
000077FA  ; data: 0x18, 0x78
000077FC  negx.b d0
000077FE  ori.b  #$1f, d0
00007802  ; data: 0xff, 0xdf
00007804  ; data: 0xff, 0xff
00007806  ; data: 0xff, 0xff
00007808  ; data: 0xff, 0xff
0000780A  ; data: 0xff, 0xc0
0000780C  ; data: 0x01, 0xff
0000780E  add.b  d0, d3
00007810  ori.b  #$17, d0
00007814  ; data: 0xff, 0xc1
00007816  movea.w -(a0), a4
00007818  or.b   d4, d0
0000781A  ori.b  #$3f, d0
0000781E  ; data: 0xff, 0xff
00007820  ; data: 0xef, 0xff
00007822  ; data: 0xff, 0xff
00007824  ; data: 0xff, 0xff
00007826  ; data: 0xff, 0xc0
00007828  ; data: 0x03, 0xff
0000782A  ; data: 0xaf, 0x80
0000782C  ori.b  #$3, d0
00007830  ; data: 0xff, 0x01
00007832  move.w d1, (a6)
00007834  or.b   -(a0), d0
00007836  ori.b  #$7f, d0
0000783A  ; data: 0xff, 0xff
0000783C  ; data: 0xff, 0xff
0000783E  ; data: 0xff, 0xff
00007840  ; data: 0xff, 0xff
00007842  ; data: 0xff, 0xc0
00007844  ; data: 0x03, 0xff
00007846  ; data: 0xf7, 0x80
00007848  ori.b  #$3, d0
0000784C  dc.w   $fc41
0000784E  sbcd.b d3, d7
00007850  ori.b  #$0, d0
00007854  ; data: 0x00, 0xff
00007856  ; data: 0xff, 0xff
00007858  ; data: 0xff, 0xff
0000785A  ; data: 0xff, 0xff
0000785C  ; data: 0xff, 0xff
0000785E  ; data: 0xff, 0xe0
00007860  ; data: 0x03, 0xff
00007862  ; data: 0xaf, 0xc0
00007864  ori.b  #$0, d0
00007868  ; data: 0x1c, 0x09
0000786A  or.b   d6, d0
0000786C  ori.b  #$0, d0
00007870  ; data: 0x00, 0xff
00007872  ; data: 0xff, 0xff
00007874  ; data: 0xff, 0xdf
00007876  ; data: 0xff, 0xff
00007878  ; data: 0xff, 0xff
0000787A  ; data: 0xff, 0xe0
0000787C  ; data: 0x07, 0xff
0000787E  addx.l d0, d7
00007880  ori.b  #$2, d0
00007884  ori.b  #$6, d1
00007888  ori.b  #$3, d0
0000788C  ; data: 0x01, 0xff
0000788E  ; data: 0xff, 0xff
00007890  dc.w   $feff
00007892  ; data: 0xff, 0xff
00007894  ; data: 0xff, 0xff
00007896  ; data: 0xff, 0xe0
00007898  ; data: 0x07, 0xff
0000789A  ; data: 0xab, 0x40
0000789C  ori.b  #$0, d0
000078A0  ori.b  #$c, d1
000078A4  ori.b  #$6, d0
000078A8  dc.w   $61ff
000078AA  ; data: 0xff, 0xff
000078AC  dc.w   $fcff
000078AE  ; data: 0xff, 0xff
000078B0  ; data: 0xff, 0xff
000078B2  ; data: 0xff, 0xf0
000078B4  ; data: 0x07, 0xff
000078B6  and.b  d0, d3
000078B8  ori.b  #$0, d0
000078BC  ori.b  #$c, d1
000078C0  ori.b  #$d, d0
000078C4  ; data: 0xb1, 0xff
000078C6  ; data: 0xff, 0xff
000078C8  dc.w   $fcff
000078CA  ; data: 0xff, 0xff
000078CC  ; data: 0xff, 0xff
000078CE  ; data: 0xff, 0xf0
000078D0  ; data: 0x0f, 0xff
000078D2  ; data: 0xa9, 0x00
000078D4  ori.b  #$0, d0
000078D8  ori.b  #$18, d1
000078DC  ori.b  #$f, d0
000078E0  ; data: 0xd1, 0xff
000078E2  ; data: 0xff, 0xff
000078E4  ; data: 0xff, 0xff
000078E6  ; data: 0xff, 0xff
000078E8  ; data: 0xff, 0xff
000078EA  ; data: 0xff, 0xf0
000078EC  ; data: 0x0f, 0xff
000078EE  add.b  d0, d0
000078F0  ori.b  #$0, d0
000078F4  ori.b  #$38, d1
000078F8  ori.b  #$7, d0
000078FC  dc.w   $f0ff
000078FE  ; data: 0xff, 0xff
00007900  ; data: 0xff, 0xff
00007902  ; data: 0xff, 0xff
00007904  ; data: 0xff, 0xff
00007906  ; data: 0xff, 0xf0
00007908  ; data: 0x0f, 0xff
0000790A  ; data: 0xa8, 0x00
0000790C  ori.b  #$0, d0
00007910  ori.b  #$f8, d1
00007914  ori.b  #$0, d0
00007918  ; data: 0x21, 0x7f
0000791A  ; data: 0xff, 0xff
0000791C  ; data: 0xff, 0xff
0000791E  ; data: 0xff, 0xff
00007920  ; data: 0xff, 0xff
00007922  ; data: 0xff, 0xf8
00007924  ; data: 0x0f, 0xff
00007926  and.b  d0, d0
00007928  ori.b  #$0, d0
0000792C  ori.b  #$38, d0
00007930  ori.b  #$0, d1
00007934  ; data: 0x40, 0xff
00007936  ; data: 0xff, 0xff
00007938  ; data: 0xff, 0xe7
0000793A  ; data: 0xff, 0xff
0000793C  ; data: 0xff, 0xff
0000793E  ; data: 0xff, 0xf8
00007940  ; data: 0x1f, 0xfe
00007942  ; data: 0xa0, 0x00
00007944  ori.b  #$0, d0
00007948  ori.b  #$18, d0
0000794C  ori.b  #$0, d0
00007950  bset.b d1, (a7)+
00007952  ; data: 0xff, 0xff
00007954  ; data: 0xff, 0xf7
00007956  ; data: 0xff, 0xff
00007958  ; data: 0xff, 0xff
0000795A  ; data: 0xff, 0xf8
0000795C  ; data: 0x1f, 0xff
0000795E  and.b  d0, d0
00007960  ori.b  #$0, d0
00007964  ori.b  #$8, d0
00007968  ori.b  #$0, d0
0000796C  movep.l d3, -$1(a7)
00007970  ; data: 0xff, 0xff
00007972  ; data: 0xff, 0xff
00007974  ; data: 0xff, 0xff
00007976  ; data: 0xff, 0xf8
00007978  ; data: 0x1f, 0xfe
0000797A  ; data: 0xa0, 0x00
0000797C  ori.b  #$0, d0
00007980  ori.b  #$4, d0
00007984  dc.w   $f0
00007986  ori.b  #$cb, d0
0000798A  ; data: 0xff, 0xff
0000798C  ; data: 0xff, 0xff
0000798E  ; data: 0xff, 0xff
00007990  ; data: 0xff, 0xff
00007992  ; data: 0xff, 0xfc
00007994  ; data: 0x1f, 0xff
00007996  negx.b d0
00007998  ori.b  #$0, d0
0000799C  ori.b  #$0, d0
000079A0  dc.w   $f0
000079A2  ori.b  #$d7, d0
000079A6  ; data: 0xff, 0xff
000079A8  ; data: 0xff, 0xff
000079AA  ; data: 0xff, 0xff
000079AC  ; data: 0xff, 0xff
000079AE  ; data: 0xff, 0xfc
000079B0  ; data: 0x3f, 0xfe
000079B2  asr.b  #$4, d0
000079B4  ori.b  #$38, d0
000079B8  ori.b  #$0, d0
000079BC  ; data: 0x00, 0xe0
000079BE  ori.b  #$97, d0
000079C2  ; data: 0xff, 0xff
000079C4  ; data: 0xff, 0xff
000079C6  ; data: 0xff, 0xff
000079C8  ; data: 0xff, 0xff
000079CA  ; data: 0xff, 0xf4
000079CC  ; data: 0x3f, 0xff
000079CE  add.b  d0, d4
000079D0  ori.b  #$7c, d0
000079D4  ori.b  #$0, d0
000079D8  ; data: 0x00, 0xc0
000079DA  ori.b  #$7, d0
000079DE  ; data: 0xff, 0xff
000079E0  ; data: 0xff, 0xff
000079E2  ; data: 0xff, 0xff
000079E4  ; data: 0xff, 0xff
000079E6  ; data: 0xff, 0xfc
000079E8  ; data: 0x3f, 0xff
000079EA  dc.w   $f800
000079EC  ori.b  #$ff, d0
000079F0  ori.b  #$0, d0
000079F4  bclr.b d1, d0
000079F6  ori.b  #$47, d0
000079FA  ; data: 0xff, 0xff
000079FC  ; data: 0xff, 0xff
000079FE  ; data: 0xf9, 0xff
00007A00  ; data: 0xff, 0xff
00007A02  ; data: 0xff, 0xf4
00007A04  ; data: 0x3f, 0xff
00007A06  dc.w   $f400
00007A08  ori.b  #$ff, d0
00007A0C  or.b   d0, d0
00007A0E  ori.b  #$0, d0
00007A12  ori.b  #$77, d0
00007A16  ; data: 0xff, 0xff
00007A18  ; data: 0xff, 0xff
00007A1A  dc.w   $fcff
00007A1C  ; data: 0xff, 0xff
00007A1E  ; data: 0xff, 0xfc
00007A20  ; data: 0x3f, 0xff
00007A22  dc.w   $f400
00007A24  ori.b  #$ff, d0
00007A28  ori.b  #$0, d0
00007A2C  ori.b  #$0, d0
00007A30  ; data: 0x03, 0xff
00007A32  ; data: 0xff, 0xff
00007A34  ; data: 0xff, 0xff
00007A36  dc.w   $feff
00007A38  ; data: 0xff, 0xff
00007A3A  ; data: 0xff, 0xfc
00007A3C  ; data: 0x7f, 0xff
00007A3E  and.b  d0, d3
00007A40  ori.b  #$7e, d0
00007A44  ori.b  #$0, d0
00007A48  ori.b  #$0, d0
00007A4C  ; data: 0x02, 0xff
00007A4E  ; data: 0xff, 0xff
00007A50  ; data: 0xff, 0xff
00007A52  ; data: 0xff, 0xff
00007A54  ; data: 0xff, 0xff
00007A56  ; data: 0xff, 0xf6
00007A58  ; data: 0x7f, 0xff
00007A5A  dc.w   $fe00
00007A5C  ori.b  #$fc, d0
00007A60  ori.b  #$0, d0
00007A64  ori.b  #$0, d0
00007A68  ; data: 0x05, 0xff
00007A6A  ; data: 0xff, 0xff
00007A6C  ; data: 0xff, 0xff
00007A6E  ; data: 0xff, 0xff
00007A70  ; data: 0xff, 0xff
00007A72  ; data: 0xff, 0xfe
00007A74  ; data: 0x7f, 0xff
00007A76  add.b  d0, d7
00007A78  ori.b  #$fc, d0
00007A7C  ori.b  #$0, d0
00007A80  ori.b  #$0, d0
00007A84  ; data: 0x03, 0xfb
00007A86  ; data: 0xff, 0xff
00007A88  ; data: 0xff, 0xff
00007A8A  ; data: 0xff, 0xff
00007A8C  ; data: 0xff, 0xff
00007A8E  ; data: 0xff, 0xea
00007A90  ; data: 0x7f, 0xff
00007A92  cmp.b  d0, d7
00007A94  ori.b  #$bc, d0
00007A98  ori.b  #$0, d0
00007A9C  ori.b  #$0, d0
00007AA0  ; data: 0x01, 0xfd
00007AA2  ; data: 0xff, 0xff
00007AA4  ; data: 0xff, 0xff
00007AA6  ; data: 0xff, 0xff
00007AA8  ; data: 0xff, 0xff
00007AAA  ; data: 0xff, 0xfe
00007AAC  ; data: 0x7f, 0xff
00007AAE  dc.w   $fe00
00007AB0  ori.b  #$7c, d0
00007AB4  ori.b  #$0, d0
00007AB8  ori.b  #$0, d0
00007ABC  ; data: 0x00, 0xd0
00007ABE  ; data: 0x3f, 0xff
00007AC0  ; data: 0xff, 0xff
00007AC2  ; data: 0xf7, 0xff
00007AC4  ; data: 0xff, 0xff
00007AC6  ; data: 0xff, 0xfa
00007AC8  ; data: 0x7f, 0xfe
00007ACA  dc.w   $f800
00007ACC  ori.b  #$fc, d0
00007AD0  ori.b  #$0, d0
00007AD4  ori.b  #$0, d0
00007AD8  ori.b  #$ff, d4
00007ADC  ; data: 0xff, 0xff
00007ADE  ; data: 0xff, 0xff
00007AE0  ; data: 0xff, 0xff
00007AE2  ; data: 0xff, 0xfe
00007AE4  ; data: 0x7f, 0xf9
00007AE6  dc.w   $fc00
00007AE8  ori.b  #$fc, d0
00007AEC  ori.b  #$0, d0
00007AF0  ori.b  #$0, d0
00007AF4  ori.b  #$ff, (a0)
00007AF8  ; data: 0xff, 0xff
00007AFA  ; data: 0xff, 0xff
00007AFC  ; data: 0xff, 0xff
00007AFE  ; data: 0xff, 0xfa
00007B00  ; data: 0x7f, 0xe7
00007B02  dc.w   $fc80
00007B04  ori.b  #$7d, d0
00007B08  ori.b  #$0, d0
00007B0C  ori.b  #$0, d0
00007B10  ori.b  #$ff, d0
00007B14  ; data: 0xff, 0xff
00007B16  ; data: 0xff, 0xff
00007B18  ; data: 0xff, 0xff
00007B1A  ; data: 0xff, 0xfe
00007B1C  ; data: 0xff, 0xdb
00007B1E  ; data: 0xfb, 0xc0
00007B20  ori.b  #$39, d0
00007B24  ori.b  #$0, d0
00007B28  ori.b  #$0, d0
00007B2C  ori.b  #$ff, d0
00007B30  ; data: 0xff, 0xff
00007B32  ; data: 0xff, 0xff
00007B34  ; data: 0xff, 0xff
00007B36  ; data: 0xff, 0xff
00007B38  ; data: 0xff, 0xf8
00007B3A  ; data: 0xff, 0xa0
00007B3C  ori.b  #$10, d0
00007B40  ori.b  #$0, d0
00007B44  ori.b  #$0, d0
00007B48  ori.b  #$ff, d1
00007B4C  ; data: 0x7f, 0xff
00007B4E  ; data: 0xf7, 0xff
00007B50  ; data: 0xff, 0xff
00007B52  ; data: 0xff, 0xfd
00007B54  ; data: 0xff, 0xfc
00007B56  ; data: 0xff, 0xc0
00007B58  ori.b  #$40, d0
00007B5C  ori.b  #$0, d0
00007B60  ori.b  #$0, d0
00007B64  ori.b  #$ff, d3
00007B68  ; data: 0xff, 0xff
00007B6A  ; data: 0xff, 0xff
00007B6C  ; data: 0xff, 0xff
00007B6E  ; data: 0xff, 0xff
00007B70  ; data: 0xff, 0xfc
00007B72  dc.w   $fea0
00007B74  ori.b  #$20, -(a0)
00007B78  ori.b  #$0, d0
00007B7C  ori.b  #$0, d0
00007B80  ori.b  #$dd, d7
00007B84  ; data: 0xcf, 0xff
00007B86  ; data: 0xff, 0xff
00007B88  ; data: 0xff, 0xff
00007B8A  ; data: 0xff, 0xfd
00007B8C  ; data: 0xff, 0xfd
00007B8E  ; data: 0xff, 0xc0
00007B90  ori.b  #$0, d0
00007B94  ori.b  #$0, d0
00007B98  ori.b  #$0, d0
00007B9C  ori.b  #$bc, d7
00007BA0  ; data: 0x0f, 0xff
00007BA2  ; data: 0xff, 0xff
00007BA4  ; data: 0xff, 0xff
00007BA6  ; data: 0xff, 0xff
00007BA8  ; data: 0xff, 0xff
00007BAA  ; data: 0xff, 0xe0
00007BAC  ori.b  #$0, d0
00007BB0  ori.b  #$0, d0
00007BB4  ori.b  #$0, d0
00007BB8  ; data: 0x00, 0x0b
00007BBA  ; data: 0x77, 0x78
00007BBC  ; data: 0x57, 0xff
00007BBE  ; data: 0xff, 0xff
00007BC0  ; data: 0xff, 0xff
00007BC2  ; data: 0xff, 0xff
00007BC4  ; data: 0xff, 0xff
00007BC6  dc.w   $fed0
00007BC8  ori.b  #$0, d0
00007BCC  ori.b  #$0, d0
00007BD0  dc.w   $8780
00007BD2  ori.b  #$1, d0
00007BD6  cmp.b  $3ff.w, d2
00007BDA  ; data: 0xff, 0xff
00007BDC  ; data: 0xff, 0xff
00007BDE  ; data: 0xff, 0xfd
00007BE0  ; data: 0xff, 0xff
00007BE2  ; data: 0xff, 0xa8
00007BE4  andi.b #$0, d0
00007BE8  ori.b  #$1, d0
00007BEC  bset.b d7, d0
00007BEE  ori.b  #$0, d0
00007BF2  moveq  #$0, d0
00007BF4  ; data: 0x03, 0xff
00007BF6  ; data: 0xff, 0xff
00007BF8  ; data: 0xff, 0xff
00007BFA  ; data: 0xff, 0xfd
00007BFC  ; data: 0xff, 0xff
00007BFE  ; data: 0xff, 0xa8
00007C00  andi.b #$0, d0
00007C04  ori.b  #$0, d0
00007C08  ; data: 0x1f, 0xc0
00007C0A  ori.b  #$0, d0
00007C0E  moveq  #$0, d0
00007C10  ; data: 0x01, 0xff
00007C12  ; data: 0xff, 0xff
00007C14  ; data: 0xff, 0xff
00007C16  ; data: 0xff, 0xfd
00007C18  ; data: 0xff, 0xff
00007C1A  ; data: 0xfd, 0xd0
00007C1C  move.b d0, d7
00007C1E  ori.b  #$0, d0
00007C22  ori.b  #$e0, d0
00007C26  ori.b  #$0, d0
00007C2A  move.l d0, d2
00007C2C  ; data: 0x01, 0xff
00007C2E  ; data: 0xff, 0xff
00007C30  ; data: 0xff, 0xff
00007C32  ; data: 0xff, 0xff
00007C34  ; data: 0xff, 0xff
00007C36  dc.w   $feb8
00007C38  move.w d0, d6
00007C3A  ori.b  #$0, d0
00007C3E  ori.b  #$e0, d0
00007C42  or.b   d0, d0
00007C44  ori.b  #$0, d0
00007C48  ; data: 0x40, 0xff
00007C4A  ; data: 0xff, 0xff
00007C4C  ; data: 0xff, 0xff
00007C4E  ; data: 0xff, 0xfd
00007C50  ; data: 0xff, 0xff
00007C52  dc.w   $fefc
00007C54  move.w d0, d4
00007C56  ori.b  #$0, d0
00007C5A  ori.b  #$e0, d1
00007C5E  negx.b d0
00007C60  ori.b  #$0, d3
00007C64  ; data: 0x03, 0xff
00007C66  ; data: 0xff, 0xff
00007C68  ; data: 0xff, 0xff
00007C6A  ; data: 0xff, 0xff
00007C6C  ; data: 0xff, 0xff
00007C6E  ; data: 0xff, 0xfa
00007C70  move.b d0, d0
00007C72  ori.b  #$0, d0
00007C76  ori.b  #$c0, d1
00007C7A  ori.b  #$7, d0
00007C7E  ori.b  #$ff, d0
00007C82  ; data: 0xff, 0xff
00007C84  ; data: 0xff, 0xff
00007C86  ; data: 0xff, 0xff
00007C88  ; data: 0xff, 0xff
00007C8A  ; data: 0xff, 0xf0
00007C8C  ori.b  #$0, d0
00007C90  ori.b  #$3, d0
00007C94  ; data: 0xff, 0x80
00007C96  ori.b  #$22, d0
00007C9A  ori.b  #$ff, d0
00007C9E  ; data: 0xff, 0xff
00007CA0  ; data: 0xff, 0xff
00007CA2  ; data: 0xff, 0xfe
00007CA4  ; data: 0xff, 0xff
00007CA6  dc.w   $feaa
00007CA8  ori.b  #$0, d0
00007CAC  ori.b  #$0, d0
00007CB0  ; data: 0xff, 0x00
00007CB2  move.l d0, d0
00007CB4  ; data: 0x00, 0x0c
00007CB6  ori.b  #$ff, d0
00007CBA  ; data: 0xff, 0xff
00007CBC  ; data: 0xff, 0xff
00007CBE  ; data: 0xff, 0xfd
00007CC0  ; data: 0xff, 0xff
00007CC2  dc.w   $fe77
00007CC4  ori.b  #$0, d0
00007CC8  ori.b  #$1, d0
00007CCC  dc.w   $fe00
00007CCE  negx.b d0
00007CD0  ori.b  #$0, ([$ffffffff])
00007CDA  ; data: 0xff, 0xfe
00007CDC  ; data: 0xff, 0xff
00007CDE  dc.w   $feae
00007CE0  ori.b  #$0, d0
00007CE4  ori.b  #$0, d0
00007CE8  dc.w   $fc00
00007CEA  ori.b  #$0, (a7)
00007CEE  ori.b  #$ff, d0
00007CF2  ; data: 0xff, 0xbf
00007CF4  ; data: 0xff, 0xff
00007CF6  ; data: 0xff, 0xff
00007CF8  ; data: 0xff, 0xff
00007CFA  ; data: 0xfd, 0x06
00007CFC  ori.b  #$0, d0
00007D00  ori.b  #$0, d0
00007D04  asl.l  #$1, d0
00007D06  dc.w   $ef
00007D08  move.b d0, d0
00007D0A  ori.b  #$ff, d1
00007D0E  ; data: 0xff, 0x3f
00007D10  ; data: 0xff, 0xff
00007D12  ; data: 0xff, 0xfe
00007D14  ; data: 0xff, 0xff
00007D16  dc.w   $fe80
00007D18  ori.b  #$0, d0
00007D1C  ori.b  #$0, d0
00007D20  bclr.b d1, d0
00007D22  ; data: 0x00, 0x7f
00007D24  ori.b  #$31, d0
00007D28  ; data: 0xef, 0xff
00007D2A  ; data: 0xff, 0x7f
00007D2C  ; data: 0xff, 0xff
00007D2E  ; data: 0xff, 0xfd
00007D30  ; data: 0xff, 0xff
00007D32  ; data: 0xfd, 0x00
00007D34  ori.b  #$0, d0
00007D38  ori.b  #$0, d0
00007D3C  ori.w  #$3f, (a0, a0.w)
00007D42  ; data: 0x02, 0xf1
00007D44  ; data: 0xff, 0xff
00007D46  ; data: 0xff, 0x7f
00007D48  ; data: 0xff, 0xff
00007D4A  ; data: 0xff, 0xfe
00007D4C  ; data: 0xff, 0xff
00007D4E  dc.w   $faa0
00007D50  ori.b  #$0, d0
00007D54  ori.b  #$0, d0
00007D58  ; data: 0x00, 0xf4
00007D5A  ; data: 0x00, 0x3f
00007D5C  asr.b  #$8, d0
00007D5E  cmpi.w #$ffff, ([$fffffff9])
00007D68  ; data: 0xff, 0xff
00007D6A  ; data: 0xfd, 0x00
00007D6C  ori.b  #$0, d0
00007D70  ori.b  #$80, d0
00007D74  ori.w  #$e03f, -(a0)
00007D78  and.b  d0, d0
00007D7A  ; data: 0x3d, 0xe0
00007D7C  ; data: 0xff, 0xff
00007D7E  ; data: 0xff, 0xff
00007D80  ; data: 0xff, 0xff
00007D82  ; data: 0xff, 0xfd
00007D84  ; data: 0x7f, 0xff
00007D86  dc.w   $fab8
00007D88  ori.b  #$0, d0
00007D8C  ori.b  #$c0, d0
00007D90  ori.l  #$f83f8000, (a1)
00007D96  movea.w d1, a4
00007D98  ; data: 0xff, 0xff
00007D9A  ; data: 0xff, 0xff
00007D9C  ; data: 0xff, 0xff
00007D9E  ; data: 0xff, 0xfa
00007DA0  ; data: 0x7f, 0xff
00007DA2  dc.w   $ff7c
00007DA4  ori.b  #$0, d0
00007DA8  ori.b  #$c0, d0
00007DAC  ori.b  #$3f, d3
00007DB0  ori.b  #$83, d0
00007DB4  ; data: 0xff, 0xff
00007DB6  ; data: 0xff, 0xff
00007DB8  ; data: 0xff, 0xff
00007DBA  ; data: 0xff, 0xf6
00007DBC  ; data: 0x7f, 0xff
00007DBE  dc.w   $febc
00007DC0  ori.b  #$2, d0
00007DC4  ori.b  #$80, d0
00007DC8  ori.b  #$1e, d3
00007DCC  ori.b  #$7, d0
00007DD0  ; data: 0xff, 0xff
00007DD2  ; data: 0xfd, 0xff
00007DD4  ; data: 0xff, 0xff
00007DD6  ; data: 0xff, 0xf8
00007DD8  ; data: 0x7f, 0xff
00007DDA  ; data: 0xff, 0xd9
00007DDC  asr.b  #$8, d0
00007DDE  ori.b  #$0, d0
00007DE2  bset.b d1, d0
00007DE4  ori.b  #$0, d3
00007DE8  ori.b  #$7, d0
00007DEC  ; data: 0xff, 0xff
00007DEE  ; data: 0xff, 0xff
00007DF0  ; data: 0xff, 0xff
00007DF2  ; data: 0xff, 0xee
00007DF4  ; data: 0x7f, 0xff
00007DF6  ; data: 0xff, 0xab
00007DF8  dc.w   $f000
00007DFA  ; data: 0x00, 0x0f
00007DFC  dc.w   $f800
00007DFE  ori.b  #$3, d0
00007E02  dc.w   $fc00
00007E04  ori.b  #$7, d0
00007E08  ; data: 0xff, 0xff
00007E0A  ; data: 0xff, 0xff
00007E0C  ; data: 0xff, 0xff
00007E0E  ; data: 0xff, 0xf4
00007E10  ; data: 0x7f, 0xff
00007E12  ; data: 0xff, 0xd3
00007E14  dc.w   $f800
00007E16  ori.b  #$0, (a7)+
00007E1A  ori.b  #$3, d0
00007E1E  dc.w   $fc00
00007E20  ori.b  #$7, d0
00007E24  ; data: 0xff, 0xff
00007E26  ; data: 0xff, 0xff
00007E28  ; data: 0xff, 0xff
00007E2A  ; data: 0xff, 0xf8
00007E2C  ; data: 0x7f, 0xff
00007E2E  ; data: 0xff, 0xab
00007E30  dc.w   $f800
00007E32  ; data: 0x00, 0x0f
00007E34  dc.w   $fc00
00007E36  ori.b  #$19, d0
00007E3A  dc.w   $fc00
00007E3C  ori.b  #$17, d0
00007E40  ; data: 0xff, 0xff
00007E42  ; data: 0xff, 0xff
00007E44  ; data: 0xff, 0xff
00007E46  ; data: 0xff, 0xf6
00007E48  ; data: 0x7f, 0xff
00007E4A  ; data: 0xff, 0xd3
00007E4C  dc.w   $f800
00007E4E  ; data: 0x00, 0x7f
00007E50  dc.w   $f800
00007E52  ori.b  #$4, d0
00007E56  dc.w   $f800
00007E58  bset.b d1, d0
00007E5A  ; data: 0x00, 0x0f
00007E5C  ; data: 0xff, 0xff
00007E5E  ; data: 0xbf, 0xff
00007E60  ; data: 0xff, 0xff
00007E62  ; data: 0xff, 0xea
00007E64  ; data: 0x3f, 0xff
00007E66  ; data: 0xff, 0xab
00007E68  dc.w   $f800
00007E6A  ; data: 0x00, 0x7f
00007E6C  dc.w   $f800
00007E6E  ori.b  #$1e, d0
00007E72  dc.w   $f000
00007E74  bset.b d3, (a0)
00007E76  ori.w  #$ffff, (a7)
00007E7A  ; data: 0xcf, 0xff
00007E7C  ; data: 0xff, 0xff
00007E7E  ; data: 0xff, 0xf4
00007E80  ; data: 0x3f, 0xff
00007E82  ; data: 0xff, 0xf4
00007E84  ; data: 0xff, 0x00
00007E86  ; data: 0x00, 0x7f
00007E88  asr.b  #$8, d0
00007E8A  ori.b  #$3f, d0
00007E8E  asr.b  #$8, d0
00007E90  bset.b d7, -(a0)
00007E92  ori.b  #$ff, d3
00007E96  ; data: 0xff, 0xff
00007E98  ; data: 0xff, 0xff
00007E9A  ; data: 0xff, 0xe0
00007E9C  ; data: 0x3f, 0xff
00007E9E  ; data: 0xff, 0xea
00007EA0  ; data: 0xfb, 0xc0
00007EA2  ; data: 0x00, 0x3f
00007EA4  or.b   d0, d1
00007EA6  ori.b  #$1f, d0
00007EAA  and.b  (a0)+, d0
00007EAC  ; data: 0x4f, 0xe1
00007EAE  ori.w  #$fffb, (a7)
00007EB2  ; data: 0xff, 0xff
00007EB4  ; data: 0xff, 0xff
00007EB6  ; data: 0xff, 0xf4
00007EB8  ; data: 0x3f, 0xff
00007EBA  ; data: 0xff, 0xff
00007EBC  ; data: 0xe7, 0xc0
00007EBE  ori.b  #$c, (a7)+
00007EC2  ori.b  #$1f, d0
00007EC6  or.b   $67f0.w, d0
00007ECA  ; data: 0x80, 0x0f
00007ECC  ; data: 0xff, 0xff
00007ECE  ; data: 0xff, 0xff
00007ED0  ; data: 0xff, 0xff
00007ED2  ; data: 0xff, 0xd4
00007ED4  ; data: 0x3f, 0xff
00007ED6  ; data: 0xff, 0xff
00007ED8  ; data: 0xaf, 0xf0
00007EDA  ori.b  #$7, $0(a0)
00007EE0  ori.b  #$12, (a6)+
00007EE4  ; data: 0x03, 0xfc
00007EE6  or.w   (a7), d6
00007EE8  ; data: 0xff, 0xff
00007EEA  ; data: 0xff, 0xff
00007EEC  ; data: 0xff, 0xff
00007EEE  ; data: 0xff, 0xf4
00007EF0  ; data: 0x1f, 0xff
00007EF2  ; data: 0xff, 0xfc
00007EF4  ; data: 0xff, 0xf0
00007EF6  ori.b  #$3, d0
00007EFA  or.b   d0, d0
00007EFC  ori.b  #$ef, d0
00007F00  ; data: 0x80, 0xfe
00007F02  cmp.w  -$1(a7), d4
00007F06  ; data: 0xff, 0xff
00007F08  ; data: 0xff, 0xff
00007F0A  ; data: 0xff, 0xe0
00007F0C  ; data: 0x1f, 0xff
00007F0E  ; data: 0xff, 0xfe
00007F10  ; data: 0xff, 0xfa
00007F12  ori.b  #$80, d0
00007F16  or.b   d0, d0
00007F18  ori.b  #$f7, (a0)+
00007F1C  ; data: 0x82, 0x3f
00007F1E  ; data: 0xb9, 0x7f
00007F20  ; data: 0xff, 0xff
00007F22  ; data: 0xff, 0xff
00007F24  ; data: 0xff, 0xff
00007F26  ; data: 0xff, 0xd0
00007F28  ; data: 0x1f, 0xff
00007F2A  ; data: 0xff, 0xff
00007F2C  ; data: 0xff, 0xfd
00007F2E  and.b  d0, d0
00007F30  bclr.b d1, d0
00007F32  ori.b  #$1c, d0
00007F36  ; data: 0x37, 0xff
00007F38  ; data: 0xa2, 0xbf
00007F3A  ; data: 0x80, 0xbf
00007F3C  ; data: 0xff, 0xff
00007F3E  ; data: 0xff, 0xff
00007F40  ; data: 0xff, 0xff
00007F42  ; data: 0xff, 0xe8
00007F44  ; data: 0x1f, 0xff
00007F46  ; data: 0xff, 0xff
00007F48  ; data: 0xff, 0xfb
00007F4A  and.b  d0, d0
00007F4C  ori.b  #$0, d0
00007F50  ori.b  #$ff, $7fbf.w
00007F56  or.w   d3, (a7)+
00007F58  ; data: 0xff, 0xff
00007F5A  ; data: 0xff, 0xff
00007F5C  ; data: 0xff, 0xff
00007F5E  ; data: 0xff, 0x98
00007F60  ; data: 0x0f, 0xff
00007F62  ; data: 0xff, 0xfd
00007F64  ; data: 0xff, 0xfd
00007F66  dc.w   $f400
00007F68  ori.b  #$0, d0
00007F6C  negx.b ([$fd7c3fbf])
00007F74  ; data: 0xff, 0xff
00007F76  ; data: 0x7f, 0xff
00007F78  ; data: 0xff, 0xff
00007F7A  ; data: 0xff, 0xc0
00007F7C  ; data: 0x0f, 0xff
00007F7E  ; data: 0xff, 0xff
00007F80  ; data: 0xff, 0xff
00007F82  dc.w   $fe00
00007F84  ori.b  #$0, d0
00007F88  negx.w d0
00007F8A  ; data: 0x2f, 0xff
00007F8C  ; data: 0xff, 0xfc
00007F8E  ; data: 0x3f, 0xd7
00007F90  ; data: 0xff, 0xff
00007F92  ; data: 0xff, 0xff
00007F94  ; data: 0xff, 0xff
00007F96  ; data: 0xff, 0xc0
00007F98  ; data: 0x0f, 0xff
00007F9A  ; data: 0xff, 0xff
00007F9C  ; data: 0xff, 0xfb
00007F9E  dc.w   $fc00
00007FA0  ori.b  #$0, d0
00007FA4  move.l d0, d0
00007FA6  ; data: 0x5f, 0xff
00007FA8  ; data: 0xff, 0xfc
00007FAA  ; data: 0x3f, 0xff
00007FAC  ; data: 0xff, 0xff
00007FAE  ; data: 0xff, 0xff
00007FB0  ; data: 0xff, 0xff
00007FB2  ; data: 0xff, 0x90
00007FB4  ; data: 0x0f, 0xff
00007FB6  ; data: 0xff, 0xff
00007FB8  ; data: 0xff, 0xfb
00007FBA  dc.w   $fe00
00007FBC  ori.b  #$0, d0
00007FC0  ori.b  #$ff, d0
00007FC4  ; data: 0xff, 0xfc
00007FC6  sle.b  (a7)+
00007FC8  ; data: 0xff, 0xff
00007FCA  ; data: 0xff, 0xff
00007FCC  ; data: 0xff, 0xff
00007FCE  ; data: 0xff, 0xd0
00007FD0  ; data: 0x07, 0xff
00007FD2  ; data: 0xff, 0xff
00007FD4  ; data: 0xff, 0xff
00007FD6  dc.w   $fe00
00007FD8  ori.b  #$0, d0
00007FDC  ori.b  #$ff, d1
00007FE0  ; data: 0xff, 0xfe
00007FE2  ; data: 0x0f, 0xff
00007FE4  ; data: 0xff, 0xff
00007FE6  ; data: 0xff, 0xff
00007FE8  ; data: 0xff, 0xff
00007FEA  ; data: 0xff, 0x40
00007FEC  ; data: 0x07, 0xff
00007FEE  ; data: 0xff, 0xff
00007FF0  ; data: 0xff, 0xff
00007FF2  ; data: 0xff, 0x00
00007FF4  ori.b  #$0, d0
00007FF8  ori.b  #$ff, d0
00007FFC  ; data: 0xff, 0xdf
00007FFE  ; data: 0x57, 0xff
00008000  ; data: 0xff, 0xff
00008002  ; data: 0xff, 0xff
00008004  ; data: 0xff, 0xff
00008006  dc.w   $fe80
00008008  ; data: 0x07, 0xff
0000800A  ; data: 0xff, 0xff
0000800C  ; data: 0xff, 0xff
0000800E  ; data: 0xff, 0x00
00008010  ori.b  #$0, d0
00008014  ori.b  #$ff, d0
00008018  dc.w   $fe8f
0000801A  ; data: 0xff, 0xff
0000801C  ; data: 0xff, 0xff
0000801E  ; data: 0xff, 0xff
00008020  ; data: 0xff, 0xff
00008022  dc.w   $ff20
00008024  ; data: 0x03, 0xff
00008026  ; data: 0xff, 0xff
00008028  ; data: 0xff, 0xff
0000802A  ; data: 0xff, 0x80
0000802C  ori.b  #$3b, d0
00008030  ori.b  #$ff, d0
00008034  ; data: 0xfd, 0x8f
00008036  ; data: 0xff, 0xff
00008038  ; data: 0xff, 0xff
0000803A  ; data: 0xff, 0xff
0000803C  ; data: 0xff, 0xff
0000803E  ; data: 0xfd, 0x80
00008040  ; data: 0x03, 0xff
00008042  ; data: 0xff, 0xff
00008044  ; data: 0xff, 0xff
00008046  ; data: 0xff, 0xc0
00008048  ori.b  #$3d, d0
0000804C  ori.b  #$ff, d0
00008050  dc.w   $fe0f
00008052  ; data: 0xff, 0xfe
00008054  ; data: 0xff, 0xff
00008056  ; data: 0xff, 0xff
00008058  ; data: 0xff, 0xff
0000805A  ; data: 0xff, 0x00
0000805C  ; data: 0x03, 0xff
0000805E  ; data: 0xff, 0xff
00008060  ; data: 0xff, 0xff
00008062  ; data: 0xff, 0xe0
00008064  ori.b  #$fe, d0
00008068  ori.b  #$ff, d0
0000806C  dc.w   $fe1f
0000806E  ; data: 0xff, 0xfd
00008070  ; data: 0xff, 0xff
00008072  ; data: 0xff, 0xff
00008074  ; data: 0xff, 0xff
00008076  dc.w   $fa40
00008078  ; data: 0x01, 0xff
0000807A  ; data: 0xff, 0xdf
0000807C  ; data: 0xff, 0xff
0000807E  ; data: 0xff, 0xd8
00008080  ori.b  #$ff, d1
00008084  or.b   d0, d0
00008086  ; data: 0x0b, 0xff
00008088  ; data: 0xff, 0x9f
0000808A  ; data: 0xff, 0xff
0000808C  ; data: 0xff, 0xff
0000808E  ; data: 0xff, 0xff
00008090  ; data: 0xff, 0xff
00008092  dc.w   $fe00
00008094  ; data: 0x01, 0xff
00008096  ; data: 0xff, 0xff
00008098  ; data: 0xff, 0xff
0000809A  ; data: 0xff, 0xe8
0000809C  ori.b  #$ff, d1
000080A0  or.b   (a0), d0
000080A2  ; data: 0x00, 0xff
000080A4  ; data: 0xff, 0xdf
000080A6  ; data: 0xff, 0xff
000080A8  ; data: 0xff, 0xff
000080AA  ; data: 0xff, 0xff
000080AC  ; data: 0xff, 0xff
000080AE  dc.w   $fe80
000080B0  ; data: 0x01, 0xff
000080B2  ; data: 0xff, 0xef
000080B4  ; data: 0xff, 0xff
000080B6  ; data: 0xff, 0xfc
000080B8  ori.b  #$fb, d1
000080BC  bchg.b d1, ([$fffbffff])
000080C4  ; data: 0xff, 0xff
000080C6  ; data: 0xff, 0xff
000080C8  ; data: 0xff, 0xff
000080CA  dc.w   $fe80
000080CC  ; data: 0x00, 0xff
000080CE  ; data: 0xff, 0xff
000080D0  ; data: 0xff, 0xff
000080D2  ; data: 0xff, 0xe8
000080D4  move.l d0, d0
000080D6  ; data: 0xff, 0xf8
000080D8  bclr.b d0, -(a3)
000080DA  or.l   d3, (a7)+
000080DC  ; data: 0xef, 0xfd
000080DE  ; data: 0x7f, 0xff
000080E0  ; data: 0xff, 0xff
000080E2  ; data: 0xff, 0xff
000080E4  ; data: 0xff, 0xff
000080E6  dc.w   $fe00
000080E8  ; data: 0x00, 0xff
000080EA  ; data: 0xff, 0xff
000080EC  ; data: 0x7f, 0xff
000080EE  ; data: 0xff, 0xf8
000080F0  dc.w   $f800
000080F2  ; data: 0x7f, 0xf8
000080F4  ori.b  #$df, d7
000080F8  ; data: 0x77, 0xff
000080FA  ; data: 0xff, 0xff
000080FC  ; data: 0xff, 0xff
000080FE  ; data: 0xff, 0xff
00008100  ; data: 0xff, 0xff
00008102  ; data: 0xf9, 0x00
00008104  ; data: 0x00, 0x7f
00008106  ; data: 0xff, 0xff
00008108  ; data: 0xff, 0xff
0000810A  ; data: 0xff, 0xf9
0000810C  dc.w   $f800
0000810E  ; data: 0xff, 0xe8
00008110  ori.b  #$df, d2
00008114  ; data: 0xbf, 0xfd
00008116  ; data: 0xff, 0xff
00008118  ; data: 0xff, 0xff
0000811A  ; data: 0xff, 0xff
0000811C  ; data: 0xff, 0xff
0000811E  dc.w   $f800
00008120  ; data: 0x00, 0x7f
00008122  ; data: 0xff, 0xff
00008124  ; data: 0xff, 0xff
00008126  ; data: 0xff, 0xf9
00008128  dc.w   $fc03
0000812A  ; data: 0xff, 0x00
0000812C  ori.b  #$df, d0
00008130  ; data: 0xbf, 0xff
00008132  ; data: 0xff, 0xff
00008134  ; data: 0xff, 0xff
00008136  ; data: 0xff, 0xff
00008138  ; data: 0xff, 0xff
0000813A  add.b  d0, d4
0000813C  ; data: 0x00, 0x7f
0000813E  ; data: 0xff, 0xff
00008140  ; data: 0xff, 0xff
00008142  ; data: 0xff, 0xfb
00008144  dc.w   $fc07
00008146  dc.w   $fe80
00008148  ori.b  #$df, d0
0000814C  dc.w   $fd5f
0000814E  ; data: 0xff, 0xff
00008150  ; data: 0xff, 0xff
00008152  ; data: 0xff, 0xff
00008154  ; data: 0xff, 0xff
00008156  cmp.b  d0, d1
00008158  ; data: 0x00, 0x3f
0000815A  ; data: 0xff, 0xff
0000815C  ; data: 0x3f, 0xff
0000815E  ; data: 0xff, 0xff
00008160  moveq  #$f, d6
00008162  ; data: 0xff, 0xc0
00008164  ori.b  #$cf, (a2)+
00008168  dc.w   $faff
0000816A  ; data: 0xff, 0xff
0000816C  ; data: 0xff, 0xff
0000816E  ; data: 0xff, 0xff
00008170  ; data: 0xff, 0xff
00008172  add.b  d0, d0
00008174  ; data: 0x00, 0x3f
00008176  ; data: 0xff, 0xff
00008178  ; data: 0xbf, 0xff
0000817A  ; data: 0xff, 0xff
0000817C  dc.w   $f80f
0000817E  ; data: 0xff, 0xc0
00008180  ori.b  #$c7, $ffff.w
00008186  ; data: 0xff, 0xff
00008188  ; data: 0xff, 0xff
0000818A  ; data: 0xff, 0xff
0000818C  ; data: 0xff, 0xff
0000818E  cmp.b  d0, d2
00008190  ori.b  #$ff, (a7)+
00008194  ; data: 0x9f, 0xff
00008196  ; data: 0xff, 0xff
00008198  dc.w   $fa0f
0000819A  ; data: 0xff, 0xc0
0000819C  ori.w  #$3fc9, $ffff.w
000081A2  ; data: 0xf7, 0xff
000081A4  ; data: 0xff, 0xff
000081A6  ; data: 0xff, 0xff
000081A8  ; data: 0xff, 0xff
000081AA  ; data: 0xa0, 0x00
000081AC  ori.b  #$ff, (a7)+
000081B0  ; data: 0x9f, 0xff
000081B2  ; data: 0xff, 0xff
000081B4  dc.w   $f407
000081B6  ; data: 0xff, 0x80
000081B8  ori.w  #$3ddf, ([$efffffff])
000081C2  ; data: 0xff, 0xff
000081C4  ; data: 0xff, 0xff
000081C6  asr.b  #$4, d0
000081C8  ; data: 0x00, 0x0f
000081CA  ; data: 0xff, 0xff
000081CC  ; data: 0xff, 0xff
000081CE  ; data: 0xff, 0xff
000081D0  ; data: 0xff, 0x01
000081D2  ; data: 0xff, 0x00
000081D4  ori.b  #$be, d4
000081D8  ; data: 0xf7, 0xff
000081DA  ; data: 0xdf, 0xff
000081DC  ; data: 0xff, 0xff
000081DE  ; data: 0xff, 0xff
000081E0  ; data: 0xff, 0xff
000081E2  and.b  d0, d0
000081E4  ; data: 0x00, 0x0f
000081E6  ; data: 0xff, 0xff
000081E8  ; data: 0xff, 0xff
000081EA  ; data: 0xff, 0xff
000081EC  ; data: 0xff, 0xa0
000081EE  ; data: 0x7f, 0x80
000081F0  ; data: 0x00, 0x0c
000081F2  ; data: 0xa3, 0x5d
000081F4  rol.w  d7, d7
000081F6  ; data: 0xff, 0xff
000081F8  ; data: 0xff, 0xff
000081FA  ; data: 0xff, 0xff
000081FC  ; data: 0xff, 0xfe
000081FE  add.b  d0, d0
00008200  ori.b  #$ff, d7
00008204  ; data: 0xff, 0xff
00008206  ; data: 0xff, 0xff
00008208  ; data: 0xff, 0xc0
0000820A  move.w a7, -(a7)
0000820C  bclr.b d0, (a4)+
0000820E  ; data: 0x58, 0xff
00008210  ; data: 0xde, 0xff
00008212  ; data: 0xff, 0xff
00008214  ; data: 0xff, 0xff
00008216  ; data: 0xff, 0xff
00008218  ; data: 0xff, 0xff
0000821A  and.b  d0, d0
0000821C  ori.b  #$ff, d7
00008220  ; data: 0xff, 0xff
00008222  ; data: 0xff, 0xff
00008224  dc.w   $fee0
00008226  ; data: 0x2e, 0xbf
00008228  bset.b d3, -(a2)
0000822A  cmpa.l (a7)+, a6
0000822C  ; data: 0xff, 0xff
0000822E  ; data: 0xff, 0xff
00008230  ; data: 0xff, 0xff
00008232  ; data: 0xff, 0xff
00008234  ; data: 0xff, 0xff
00008236  move.l d0, d0
00008238  ori.b  #$ff, d3
0000823C  ; data: 0xff, 0xff
0000823E  ; data: 0xff, 0xff
00008240  ; data: 0xff, 0xe0
00008242  ; data: 0x1f, 0x7e
00008244  ; data: 0x1f, 0xfd
00008246  ; data: 0xff, 0xff
00008248  ; data: 0xff, 0xff
0000824A  ; data: 0xff, 0xff
0000824C  ; data: 0xff, 0xff
0000824E  ; data: 0xff, 0xff
00008250  ; data: 0xff, 0xef
00008252  ori.b  #$3, d0
00008256  ; data: 0xff, 0xff
00008258  ; data: 0xff, 0xff
0000825A  ; data: 0xff, 0xff
0000825C  ; data: 0xff, 0x80
0000825E  ; data: 0x3e, 0xfe
00008260  ; data: 0x3f, 0xfe
00008262  cmpa.l (a7)+, a7
00008264  ; data: 0xff, 0xff
00008266  ; data: 0xff, 0xff
00008268  ; data: 0xff, 0xff
0000826A  ; data: 0xff, 0xff
0000826C  ; data: 0xff, 0x9c
0000826E  negx.b d0
00008270  ori.b  #$ff, d1
00008274  ; data: 0xff, 0xbf
00008276  ; data: 0xff, 0xff
00008278  ; data: 0xff, 0xd0
0000827A  ; data: 0x7f, 0xfc
0000827C  ; data: 0x7f, 0xff
0000827E  ; data: 0xff, 0xff
00008280  ; data: 0xff, 0xff
00008282  ; data: 0xff, 0xff
00008284  ; data: 0xff, 0xff
00008286  ; data: 0xff, 0xff
00008288  ; data: 0xff, 0x1e
0000828A  ori.b  #$0, d0
0000828E  ; data: 0xff, 0xff
00008290  ; data: 0xff, 0xff
00008292  ; data: 0xff, 0xff
00008294  ; data: 0xff, 0xdf
00008296  ; data: 0x7f, 0xf8
00008298  ; data: 0xff, 0xfe
0000829A  ; data: 0xff, 0xff
0000829C  ; data: 0xff, 0xff
0000829E  ; data: 0xff, 0xff
000082A0  ; data: 0xff, 0xff
000082A2  ; data: 0xff, 0xff
000082A4  ; data: 0xff, 0x1c
000082A6  ori.b  #$0, d0
000082AA  ; data: 0xff, 0xff
000082AC  ; data: 0xff, 0xff
000082AE  ; data: 0xff, 0xff
000082B0  ; data: 0xff, 0xdf
000082B2  ; data: 0xff, 0xe4
000082B4  ; data: 0xff, 0xff
000082B6  ; data: 0xff, 0xff
000082B8  ; data: 0xff, 0xff
000082BA  ; data: 0xff, 0xff
000082BC  ; data: 0xff, 0xff
000082BE  ; data: 0xff, 0xff
000082C0  ; data: 0xff, 0xb8
000082C2  ori.b  #$0, d0
000082C6  ; data: 0x7f, 0xff
000082C8  ; data: 0xff, 0xff
000082CA  ; data: 0xff, 0xff
000082CC  ; data: 0xff, 0xff
000082CE  ; data: 0xff, 0x8b
000082D0  ; data: 0xff, 0xff
000082D2  ; data: 0xff, 0xff
000082D4  ; data: 0xff, 0xff
000082D6  ; data: 0xff, 0xff
000082D8  ; data: 0xff, 0xff
000082DA  ; data: 0xff, 0xff
000082DC  ; data: 0xff, 0xb8
000082DE  ori.b  #$0, d0
000082E2  ; data: 0x3f, 0xff
000082E4  ; data: 0xff, 0xff
000082E6  ; data: 0xff, 0xff
000082E8  ; data: 0xff, 0xff
000082EA  ; data: 0xff, 0xbd
000082EC  ; data: 0xff, 0xff
000082EE  ; data: 0xff, 0xff
000082F0  ; data: 0xff, 0xff
000082F2  ; data: 0xff, 0xff
000082F4  ; data: 0xff, 0xff
000082F6  ; data: 0xff, 0xff
000082F8  ; data: 0xff, 0xe0
000082FA  ori.b  #$0, d0
000082FE  ; data: 0x3f, 0xff
00008300  ; data: 0xff, 0xff
00008302  ; data: 0xfd, 0xff
00008304  ; data: 0xff, 0xff
00008306  ; data: 0xff, 0xe1
00008308  ; data: 0xff, 0xff
0000830A  ; data: 0xff, 0xff
0000830C  ; data: 0xff, 0xff
0000830E  ; data: 0xff, 0xff
00008310  ; data: 0xff, 0xff
00008312  ; data: 0xff, 0xff
00008314  ; data: 0xff, 0xb4
00008316  ori.b  #$0, d0
0000831A  ; data: 0x1f, 0xff
0000831C  ; data: 0xff, 0xff
0000831E  ; data: 0xfb, 0xff
00008320  ; data: 0xff, 0xff
00008322  ; data: 0xfb, 0x83
00008324  ; data: 0xff, 0xff
00008326  ; data: 0xff, 0xbf
00008328  ; data: 0xff, 0xff
0000832A  ; data: 0xff, 0xff
0000832C  ; data: 0xff, 0xff
0000832E  ; data: 0xff, 0xff
00008330  ; data: 0xff, 0xe0
00008332  ori.b  #$0, d0
00008336  ; data: 0x1f, 0xff
00008338  ; data: 0xff, 0xff
0000833A  ; data: 0xff, 0xff
0000833C  ; data: 0xff, 0xff
0000833E  dc.w   $f683
00008340  ; data: 0xff, 0xff
00008342  ; data: 0x1f, 0xff
00008344  ; data: 0xff, 0xff
00008346  ; data: 0xff, 0xff
00008348  ; data: 0xff, 0xff
0000834A  ; data: 0xff, 0xff
0000834C  ; data: 0xf7, 0xe0
0000834E  ori.b  #$0, d0
00008352  ; data: 0x0f, 0xff
00008354  ; data: 0xff, 0xff
00008356  ; data: 0xff, 0xff
00008358  ; data: 0xff, 0xff
0000835A  ; data: 0xff, 0xc3
0000835C  ; data: 0xff, 0xff
0000835E  ; data: 0x0f, 0xff
00008360  ; data: 0xff, 0xbf
00008362  ; data: 0xff, 0xff
00008364  ; data: 0xff, 0xff
00008366  ; data: 0xff, 0xff
00008368  ; data: 0xe2, 0xc0
0000836A  ori.b  #$0, d0
0000836E  ; data: 0x07, 0xff
00008370  ; data: 0xff, 0xff
00008372  ; data: 0xff, 0xff
00008374  ; data: 0xff, 0xff
00008376  ; data: 0xff, 0xfd
00008378  ; data: 0xff, 0xff
0000837A  ; data: 0xdf, 0xff
0000837C  ; data: 0xff, 0xff
0000837E  ; data: 0xff, 0xff
00008380  ; data: 0xff, 0xff
00008382  ; data: 0xff, 0xff
00008384  asl.b  #$3, d0
00008386  ori.b  #$0, d0
0000838A  ; data: 0x03, 0xff
0000838C  ; data: 0xff, 0xff
0000838E  ; data: 0xff, 0xff
00008390  ; data: 0xff, 0xff
00008392  ; data: 0xff, 0xff
00008394  ; data: 0xff, 0xff
00008396  ; data: 0xff, 0xff
00008398  ; data: 0xff, 0xff
0000839A  ; data: 0xff, 0xff
0000839C  ; data: 0xff, 0xff
0000839E  ; data: 0xff, 0xff
000083A0  asr.b  #$5, d0
000083A2  ori.b  #$0, d0
000083A6  ; data: 0x03, 0xff
000083A8  ; data: 0xff, 0xff
000083AA  ; data: 0xff, 0xff
000083AC  ; data: 0xff, 0xff
000083AE  ; data: 0xff, 0xff
000083B0  ; data: 0xff, 0xff
000083B2  ; data: 0xff, 0xff
000083B4  ; data: 0xff, 0xff
000083B6  ; data: 0xff, 0xff
000083B8  ; data: 0xff, 0xff
000083BA  ; data: 0xff, 0xff
000083BC  asr.w  #$6, d0
000083BE  ori.b  #$0, d0
000083C2  ; data: 0x01, 0xff
000083C4  ; data: 0xff, 0xff
000083C6  ; data: 0xff, 0xff
000083C8  ; data: 0xff, 0xff
000083CA  ; data: 0xff, 0xff
000083CC  ; data: 0xff, 0xf7
000083CE  ; data: 0xff, 0xff
000083D0  ; data: 0xff, 0xff
000083D2  ; data: 0xff, 0xff
000083D4  ; data: 0xff, 0xff
000083D6  ; data: 0xff, 0xff
000083D8  asr.l  #$8, d0
000083DA  ori.b  #$0, d0
000083DE  ; data: 0x00, 0xff
000083E0  ; data: 0xff, 0xff
000083E2  ; data: 0xff, 0xff
000083E4  ; data: 0xff, 0xff
000083E6  ; data: 0xff, 0xff
000083E8  ; data: 0xff, 0xff
000083EA  ; data: 0xff, 0xff
000083EC  ; data: 0xdf, 0xff
000083EE  ; data: 0xff, 0xff
000083F0  ; data: 0xff, 0xff
000083F2  ; data: 0xff, 0xff
000083F4  dc.w   $f000
000083F6  ori.b  #$0, d0
000083FA  ; data: 0x00, 0x7f
000083FC  ; data: 0xff, 0xff
000083FE  ; data: 0xff, 0xff
00008400  ; data: 0xff, 0xff
00008402  ; data: 0xff, 0xff
00008404  ; data: 0xff, 0xff
00008406  ; data: 0xff, 0xff
00008408  ; data: 0xbf, 0xff
0000840A  ; data: 0xff, 0xff
0000840C  ; data: 0xff, 0xff
0000840E  ; data: 0xff, 0xff
00008410  and.b  d0, d0
00008412  ori.b  #$0, d0
00008416  ; data: 0x00, 0x3f
00008418  ; data: 0xff, 0xff
0000841A  ; data: 0xff, 0xff
0000841C  ; data: 0xff, 0xff
0000841E  ; data: 0xff, 0xff
00008420  ; data: 0xff, 0xff
00008422  ; data: 0xff, 0xff
00008424  ; data: 0xff, 0xff
00008426  ; data: 0xff, 0xff
00008428  ; data: 0xff, 0xff
0000842A  ; data: 0xff, 0xff
0000842C  dc.w   $f000
0000842E  ori.b  #$0, d0
00008432  ; data: 0x00, 0x3f
00008434  ; data: 0xff, 0xff
00008436  ; data: 0xff, 0xff
00008438  ; data: 0xff, 0xff
0000843A  ; data: 0xff, 0xff
0000843C  ; data: 0xff, 0xff
0000843E  ; data: 0xff, 0xff
00008440  ; data: 0xff, 0xff
00008442  ; data: 0xff, 0xff
00008444  ; data: 0xff, 0xff
00008446  ; data: 0xff, 0xff
00008448  asr.b  #$8, d0
0000844A  ori.b  #$0, d0
0000844E  ori.b  #$ff, (a7)+
00008452  ; data: 0xff, 0xff
00008454  ; data: 0xff, 0xff
00008456  ; data: 0xff, 0xff
00008458  ; data: 0xff, 0xff
0000845A  ; data: 0xff, 0xff
0000845C  ; data: 0xff, 0xff
0000845E  ; data: 0xff, 0xff
00008460  ; data: 0xff, 0xff
00008462  ; data: 0xff, 0xfb
00008464  nbcd.b d0
00008466  ori.b  #$0, d0
0000846A  ; data: 0x00, 0x0f
0000846C  ; data: 0xff, 0xff
0000846E  ; data: 0xff, 0xff
00008470  ; data: 0xff, 0xff
00008472  ; data: 0xff, 0xff
00008474  ; data: 0xff, 0xff
00008476  ; data: 0xff, 0xff
00008478  ; data: 0xff, 0xff
0000847A  ; data: 0xff, 0xff
0000847C  ; data: 0xff, 0xff
0000847E  ; data: 0xff, 0xfe
00008480  or.b   d0, d0
00008482  ori.b  #$0, d0
00008486  ori.b  #$ff, d7
0000848A  ; data: 0xff, 0xff
0000848C  ; data: 0xff, 0xff
0000848E  ; data: 0xff, 0xff
00008490  ; data: 0xff, 0xff
00008492  ; data: 0xff, 0xff
00008494  ; data: 0xff, 0xff
00008496  ; data: 0xff, 0xff
00008498  ; data: 0xff, 0xff
0000849A  ; data: 0xff, 0xfc
0000849C  ori.b  #$0, d0
000084A0  ori.b  #$3, d0
000084A4  ; data: 0xff, 0xff
000084A6  ; data: 0xff, 0xff
000084A8  ; data: 0xff, 0xff
000084AA  ; data: 0xff, 0xff
000084AC  ; data: 0xff, 0xff
000084AE  ; data: 0xff, 0xff
000084B0  ; data: 0xff, 0xff
000084B2  ; data: 0xff, 0xff
000084B4  ; data: 0xff, 0xff
000084B6  ; data: 0xff, 0xfe
000084B8  ori.b  #$0, d0
000084BC  ori.b  #$1, d0
000084C0  ; data: 0xff, 0xff
000084C2  ; data: 0xff, 0xff
000084C4  ; data: 0xff, 0xff
000084C6  ; data: 0xff, 0xff
000084C8  ; data: 0xff, 0xff
000084CA  ; data: 0xff, 0xff
000084CC  ; data: 0xff, 0xff
000084CE  ; data: 0xff, 0xff
000084D0  ; data: 0xff, 0xff
000084D2  ; data: 0xff, 0xd5
000084D4  ori.b  #$0, d0
000084D8  ori.b  #$0, d0
000084DC  ; data: 0xff, 0xff
000084DE  ; data: 0xff, 0xff
000084E0  ; data: 0xff, 0xff
000084E2  ; data: 0xff, 0xff
000084E4  ; data: 0xff, 0xff
000084E6  ; data: 0xff, 0xff
000084E8  ; data: 0xff, 0xff
000084EA  ; data: 0xff, 0xff
000084EC  ; data: 0xff, 0xff
000084EE  ; data: 0xff, 0xf8
000084F0  ori.b  #$0, d0
000084F4  ori.b  #$0, d0
000084F8  ; data: 0x7f, 0xff
000084FA  ; data: 0xff, 0xff
000084FC  ; data: 0xff, 0xff
000084FE  ; data: 0xff, 0xff
00008500  ; data: 0xff, 0xff
00008502  ; data: 0xff, 0xff
00008504  ; data: 0xff, 0xff
00008506  ; data: 0xff, 0xff
00008508  ; data: 0xff, 0xff
0000850A  ; data: 0xff, 0xe8
0000850C  ori.b  #$0, d0
00008510  ori.b  #$0, d0
00008514  ; data: 0x3f, 0xff
00008516  ; data: 0xff, 0xff
00008518  ; data: 0xff, 0xff
0000851A  ; data: 0xff, 0xff
0000851C  ; data: 0xff, 0xff
0000851E  ; data: 0xff, 0xff
00008520  ; data: 0xff, 0xff
00008522  ; data: 0xff, 0xff
00008524  ; data: 0xff, 0xff
00008526  ; data: 0xff, 0xd0
00008528  ori.b  #$0, d0
0000852C  ori.b  #$0, d0
00008530  ; data: 0x1f, 0xff
00008532  ; data: 0xff, 0xff
00008534  ; data: 0xff, 0xff
00008536  ; data: 0xff, 0xff
00008538  ; data: 0xff, 0xff
0000853A  ; data: 0xff, 0xff
0000853C  ; data: 0xff, 0xff
0000853E  ; data: 0xff, 0xff
00008540  ; data: 0xff, 0xff
00008542  ; data: 0xff, 0xe0
00008544  ori.b  #$0, d0
00008548  ori.b  #$0, d0
0000854C  ; data: 0x0f, 0xff
0000854E  ; data: 0xff, 0xff
00008550  ; data: 0xff, 0xff
00008552  ; data: 0xff, 0xff
00008554  ; data: 0xff, 0xff
00008556  ; data: 0xff, 0xff
00008558  ; data: 0xff, 0xff
0000855A  ; data: 0xff, 0xff
0000855C  ; data: 0xff, 0xff
0000855E  ; data: 0xff, 0xc0
00008560  ori.b  #$0, d0
00008564  ori.b  #$0, d0
00008568  ; data: 0x07, 0xff
0000856A  ; data: 0xff, 0xff
0000856C  ; data: 0xff, 0xff
0000856E  ; data: 0xff, 0xff
00008570  ; data: 0xff, 0xff
00008572  ; data: 0xff, 0xff
00008574  ; data: 0xff, 0xff
00008576  ; data: 0xff, 0xff
00008578  ; data: 0xff, 0xff
0000857A  ; data: 0xff, 0x80
0000857C  ori.b  #$0, d0
00008580  ori.b  #$0, d0
00008584  ; data: 0x03, 0xff
00008586  ; data: 0xff, 0xff
00008588  ; data: 0xff, 0xfb
0000858A  ; data: 0xff, 0xff
0000858C  ; data: 0xff, 0xff
0000858E  ; data: 0xff, 0xff
00008590  ; data: 0xff, 0xff
00008592  ; data: 0xff, 0xff
00008594  ; data: 0xff, 0xff
00008596  ; data: 0xff, 0x00
00008598  ori.b  #$0, d0
0000859C  ori.b  #$0, d0
000085A0  ; data: 0x01, 0xff
000085A2  ; data: 0xff, 0xff
000085A4  ; data: 0xff, 0xff
000085A6  ; data: 0xff, 0xff
000085A8  ; data: 0xff, 0xff
000085AA  ; data: 0xff, 0xff
000085AC  ; data: 0xff, 0xff
000085AE  ; data: 0xff, 0xff
000085B0  ; data: 0xff, 0xff
000085B2  dc.w   $fc80
000085B4  ori.b  #$0, d0
000085B8  ori.b  #$0, d0
000085BC  ; data: 0x00, 0x7f
000085BE  ; data: 0xff, 0xff
000085C0  ; data: 0xff, 0xff
000085C2  ; data: 0xff, 0xff
000085C4  ; data: 0xff, 0xff
000085C6  ; data: 0xff, 0xff
000085C8  ; data: 0xff, 0xff
000085CA  ; data: 0xff, 0xff
000085CC  ; data: 0xff, 0xff
000085CE  dc.w   $fc00
000085D0  ori.b  #$0, d0
000085D4  ori.b  #$0, d0
000085D8  ; data: 0x00, 0x3f
000085DA  ; data: 0xff, 0xff
000085DC  ; data: 0xff, 0xff
000085DE  ; data: 0xff, 0xff
000085E0  ; data: 0xff, 0xff
000085E2  ; data: 0xff, 0xff
000085E4  ; data: 0xff, 0xff
000085E6  ; data: 0xff, 0xff
000085E8  ; data: 0xff, 0xff
000085EA  addq.b #$4, d0
000085EC  ori.b  #$0, d0
000085F0  ori.b  #$0, d0
000085F4  ori.b  #$ff, (a7)+
000085F8  ; data: 0xff, 0xff
000085FA  ; data: 0xff, 0xff
000085FC  ; data: 0xff, 0xff
000085FE  ; data: 0xff, 0xff
00008600  ; data: 0xff, 0xff
00008602  ; data: 0xff, 0xff
00008604  ; data: 0xff, 0xfe
00008606  and.b  d0, d0
00008608  ori.b  #$0, d0
0000860C  ori.b  #$0, d0
00008610  ; data: 0x00, 0x0f
00008612  ; data: 0xff, 0xff
00008614  ; data: 0xff, 0xff
00008616  ; data: 0xff, 0xff
00008618  ; data: 0xff, 0xff
0000861A  ; data: 0xff, 0xff
0000861C  ; data: 0xff, 0xff
0000861E  ; data: 0xff, 0xff
00008620  ; data: 0xff, 0xfd
00008622  addq.b #$8, d0
00008624  ori.b  #$0, d0
00008628  ori.b  #$0, d0
0000862C  ori.b  #$ff, d3
00008630  ; data: 0xff, 0xff
00008632  ; data: 0xff, 0xff
00008634  ; data: 0xff, 0xff
00008636  ; data: 0xff, 0xff
00008638  ; data: 0xff, 0xff
0000863A  ; data: 0xff, 0xff
0000863C  ; data: 0xff, 0xff
0000863E  and.b  d0, d0
00008640  ori.b  #$0, d0
00008644  ori.b  #$0, d0
00008648  ori.b  #$ff, d1
0000864C  ; data: 0xff, 0xff
0000864E  ; data: 0xff, 0xff
00008650  ; data: 0xff, 0xff
00008652  ; data: 0xff, 0xff
00008654  ; data: 0xff, 0xff
00008656  ; data: 0xff, 0xff
00008658  ; data: 0xff, 0xfd
0000865A  or.b   d0, d0
0000865C  ori.b  #$0, d0
00008660  ori.b  #$0, d0
00008664  ori.b  #$ff, d0
00008668  ; data: 0xff, 0xff
0000866A  ; data: 0xff, 0xff
0000866C  ; data: 0xff, 0xff
0000866E  ; data: 0xff, 0xff
00008670  ; data: 0xff, 0xff
00008672  ; data: 0xff, 0xff
00008674  ; data: 0xff, 0xff
00008676  ori.b  #$0, d0
0000867A  ori.b  #$0, d0
0000867E  ori.b  #$0, d0
00008682  ; data: 0x3f, 0xff
00008684  ; data: 0xff, 0xff
00008686  ; data: 0xff, 0xff
00008688  ; data: 0xff, 0xff
0000868A  ; data: 0xff, 0xff
0000868C  ; data: 0xff, 0xff
0000868E  ; data: 0xff, 0xff
00008690  ; data: 0xff, 0xfc
00008692  ori.b  #$0, d0
00008696  ori.b  #$0, d0
0000869A  ori.b  #$0, d0
0000869E  ; data: 0x0f, 0xff
000086A0  ; data: 0xff, 0xff
000086A2  ; data: 0xff, 0xff
000086A4  ; data: 0xff, 0xff
000086A6  ; data: 0xff, 0xff
000086A8  ; data: 0xff, 0xff
000086AA  ; data: 0xff, 0xff
000086AC  dc.w   $feb0
000086AE  ori.b  #$0, d0
000086B2  ori.b  #$0, d0
000086B6  ori.b  #$0, d0
000086BA  ; data: 0x07, 0xff
000086BC  ; data: 0xff, 0xff
000086BE  ; data: 0xff, 0xff
000086C0  ; data: 0xff, 0xff
000086C2  ; data: 0xff, 0xff
000086C4  ; data: 0xff, 0xff
000086C6  ; data: 0xff, 0xff
000086C8  ; data: 0xfd, 0x60
000086CA  ori.b  #$0, d0
000086CE  ori.b  #$0, d0
000086D2  ori.b  #$0, d0
000086D6  ; data: 0x01, 0xff
000086D8  ; data: 0xff, 0xff
000086DA  ; data: 0xff, 0xff
000086DC  ; data: 0xff, 0xff
000086DE  ; data: 0xff, 0xff
000086E0  ; data: 0xff, 0xff
000086E2  ; data: 0xff, 0xff
000086E4  ; data: 0xfd, 0x80
000086E6  ori.b  #$0, d0
000086EA  ori.b  #$0, d0
000086EE  ori.b  #$0, d0
000086F2  ; data: 0x00, 0xff
000086F4  ; data: 0xff, 0xff
000086F6  ; data: 0xff, 0xff
000086F8  ; data: 0xff, 0xff
000086FA  ; data: 0xff, 0xff
000086FC  ; data: 0xff, 0xff
000086FE  ; data: 0xff, 0xff
00008700  addx.b d0, d3
00008702  ori.b  #$0, d0
00008706  ori.b  #$0, d0
0000870A  ori.b  #$0, d0
0000870E  ; data: 0x00, 0x3f
00008710  ; data: 0xff, 0xff
00008712  ; data: 0xff, 0xff
00008714  ; data: 0xff, 0xff
00008716  ; data: 0xff, 0xff
00008718  ; data: 0xff, 0xff
0000871A  ; data: 0xff, 0xff
0000871C  dc.w   $fc00
0000871E  ori.b  #$0, d0
00008722  ori.b  #$0, d0
00008726  ori.b  #$0, d0
0000872A  ; data: 0x00, 0x0f
0000872C  ; data: 0xff, 0xff
0000872E  ; data: 0xff, 0xff
00008730  ; data: 0xff, 0xff
00008732  ; data: 0xff, 0xff
00008734  ; data: 0xff, 0xff
00008736  ; data: 0xff, 0xff
00008738  add.b  d0, d0
0000873A  ori.b  #$0, d0
0000873E  ori.b  #$0, d0
00008742  ori.b  #$0, d0
00008746  ori.b  #$ff, d3
0000874A  ; data: 0xff, 0xff
0000874C  ; data: 0xff, 0xff
0000874E  ; data: 0xff, 0xff
00008750  ; data: 0xff, 0xff
00008752  ; data: 0xff, 0xff
00008754  and.b  d0, d0
00008756  ori.b  #$0, d0
0000875A  ori.b  #$0, d0
0000875E  ori.b  #$0, d0
00008762  ori.b  #$ff, d0
00008766  ; data: 0xff, 0xff
00008768  ; data: 0xff, 0xff
0000876A  ; data: 0xff, 0xff
0000876C  ; data: 0xff, 0xff
0000876E  ; data: 0xff, 0xff
00008770  ori.b  #$0, d0
00008774  ori.b  #$0, d0
00008778  ori.b  #$0, d0
0000877C  ori.b  #$0, d0
00008780  ; data: 0x3f, 0xff
00008782  ; data: 0xff, 0xff
00008784  ; data: 0xff, 0xff
00008786  ; data: 0xff, 0xff
00008788  ; data: 0xff, 0xff
0000878A  ; data: 0xff, 0xfc
0000878C  ori.b  #$0, d0
00008790  ori.b  #$0, d0
00008794  ori.b  #$0, d0
00008798  ori.b  #$0, d0
0000879C  ; data: 0x07, 0xff
0000879E  ; data: 0xff, 0xff
000087A0  ; data: 0xff, 0xff
000087A2  ; data: 0xff, 0xff
000087A4  ; data: 0xff, 0xff
000087A6  ; data: 0xff, 0xe0
000087A8  ori.b  #$0, d0
000087AC  ori.b  #$0, d0
000087B0  ori.b  #$0, d0
000087B4  ori.b  #$0, d0
000087B8  ; data: 0x01, 0xff
000087BA  ; data: 0xff, 0xff
000087BC  ; data: 0xff, 0xff
000087BE  ; data: 0xff, 0xff
000087C0  ; data: 0xff, 0xff
000087C2  ; data: 0xff, 0x80
000087C4  ori.b  #$0, d0
000087C8  ori.b  #$0, d0
000087CC  ori.b  #$0, d0
000087D0  ori.b  #$0, d0
000087D4  ; data: 0x00, 0x3f
000087D6  ; data: 0xff, 0xff
000087D8  ; data: 0xff, 0xff
000087DA  ; data: 0xff, 0xff
000087DC  ; data: 0xff, 0xff
000087DE  dc.w   $fc00
000087E0  ori.b  #$0, d0
000087E4  ori.b  #$0, d0
000087E8  ori.b  #$0, d0
000087EC  ori.b  #$0, d0
000087F0  ori.b  #$ff, d7
000087F4  ; data: 0xff, 0xff
000087F6  ; data: 0xff, 0xff
000087F8  ; data: 0xff, 0xff
000087FA  asr.b  #$8, d0
000087FC  ori.b  #$0, d0
00008800  ori.b  #$0, d0
00008804  ori.b  #$0, d0
00008808  ori.b  #$0, d0
0000880C  ori.b  #$ff, d0
00008810  ; data: 0xff, 0xff
00008812  ; data: 0xff, 0xff
00008814  ; data: 0xff, 0xff
00008816  ori.b  #$0, d0
0000881A  ori.b  #$0, d0
0000881E  ori.b  #$0, d0
00008822  ori.b  #$0, d0
00008826  ori.b  #$0, d0
0000882A  ; data: 0x0f, 0xff
0000882C  ; data: 0xff, 0xff
0000882E  ; data: 0xff, 0xff
00008830  ; data: 0xff, 0xf0
00008832  ori.b  #$0, d0
00008836  ori.b  #$0, d0
0000883A  ori.b  #$0, d0
0000883E  ori.b  #$0, d0
00008842  ori.b  #$0, d0
00008846  ; data: 0x00, 0xff
00008848  ; data: 0xff, 0xff
0000884A  ; data: 0xff, 0xff
0000884C  ; data: 0xff, 0x00
0000884E  ori.b  #$0, d0
00008852  ori.b  #$0, d0
00008856  ori.b  #$0, d0
0000885A  ori.b  #$0, d0
0000885E  ori.b  #$0, d0
00008862  ori.b  #$ff, d7
00008866  ; data: 0xff, 0xff
00008868  ori.b  #$0, d0
0000886C  ori.b  #$0, d0
00008870  ori.b  #$0, d0
00008874  ori.b  #$0, d0
00008878  ori.b  #$0, d0
0000887C  ori.b  #$0, d0
00008880  ; data: 0x07, 0xff
00008882  ; data: 0xff, 0x80
00008884  ori.b  #$0, d0
00008888  ori.b  #$0, d0
0000888C  ori.b  #$0, d0