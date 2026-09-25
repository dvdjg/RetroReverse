; code_b0c2c desensamblado
; origen out/modules_all/blk_0B0C2C
; len 63064 B
000000  jmp    $10.l
000006  jmp    $ee.l
00000C  ; data: 0x73, 0x6f
00000E  ; data: 0x73, 0x00
000010  movea.l $4.w, a6
000014  movea.l a0, a3
000016  movea.l $114(a6), a4
00001A  tst.l  $ac(a4)
00001E  bne.b  $38
000020  lea.l  $5c(a4), a0
000024  jsr    -$180(a6)
000028  lea.l  $5c(a4), a0
00002C  jsr    -$174(a6)
000030  move.l d0, $b2.l
000036  bra.b  $5e
000038  lea.l  $b6(pc), a2
00003C  moveq  #$9, d0
00003E  cmpi.b #$20, (a3)+
000042  beq.b  $3e
000044  bcs.b  $5a
000046  subq.l #$1, a3
000048  move.l a3, (a2)+
00004A  cmpi.b #$20, (a3)+
00004E  bcs.b  $5a
000050  bne.b  $4a
000052  clr.b  -$1(a3)
000056  dbra   d0, $3e
00005A  clr.b  -$1(a3)
00005E  lea.l  $e2(pc), a1
000062  moveq  #$0, d0
000064  movea.l $4.w, a6
000068  jsr    -$228(a6)
00006C  tst.l  d0
00006E  beq.b  $88
000070  movea.l d0, a6
000072  move.l a6, -(a7)
000074  lea.l  $a0.l, a0
00007A  jsr    -$1e(a6)
00007E  movea.l (a7)+, a1
000080  movea.l $4.w, a6
000084  jsr    -$19e(a6)
000088  move.l $b2(pc), d2
00008C  beq.b  $9c
00008E  movea.l $4.w, a6
000092  jsr    -$84(a6)
000096  movea.l d2, a1
000098  jsr    -$17a(a6)
00009C  moveq  #$0, d0
00009E  rts    
0000A0  jsr    -$11a(a6)
0000A4  lea.l  $b6(pc), a1
0000A8  move.l a1, $34(a0)
0000AC  jmp    $ee.l
0000B2  ori.b  #$0, d0
0000B6  ori.b  #$0, d0
0000BA  ori.b  #$0, d0
0000BE  ori.b  #$0, d0
0000C2  ori.b  #$0, d0
0000C6  ori.b  #$0, d0
0000CA  ori.b  #$0, d0
0000CE  ori.b  #$0, d0
0000D2  ori.b  #$0, d0
0000D6  ori.b  #$0, d0
0000DA  ori.b  #$0, d0
0000DE  ori.b  #$0, d0
0000E2  ; data: 0x73, 0x6f
0000E4  ; data: 0x73, 0x2e
0000E6  bge.b  $151
0000E8  bhi.b  $15c
0000EA  bsr.b  $15e
0000EC  ; data: 0x79, 0x00
0000EE  moveq  #$8, d0
0000F0  suba.l a0, a0
0000F2  jsr    -$ba(a6)
0000F6  lea.l  $0.l, a5
0000FC  move.l a6, (a5)
0000FE  move.l a2, -(a7)
000100  jsr    -$11a(a6)
000104  movea.l a0, a2
000106  movea.l $26(a2), a0
00010A  move.l a0, d0
00010C  bne.b  $124
00010E  moveq  #$1c, d0
000110  moveq  #$0, d1
000112  jsr    -$2a(a6)
000116  movea.l d0, a0
000118  moveq  #$6, d1
00011A  clr.l  (a0)+
00011C  dbra   d1, $11a
000120  move.l d0, $26(a2)
000124  movea.l d0, a2
000126  move.l a2, $18(a5)
00012A  tst.w  $e(a2)
00012E  bne.b  $136
000130  move.w #$6000, $e(a2)
000136  tst.l  $4(a2)
00013A  bne.b  $156
00013C  move.l #$44425547, d0
000142  jsr    -$138(a6)
000146  movea.l $18(a5), a1
00014A  move.l a0, $18(a1)
00014E  move.l #$166, $4(a2)
000156  tst.l  $8(a2)
00015A  bne.b  $1a6
00015C  move.l #$17e, $8(a2)
000164  bra.b  $1a6
000166  move.l a5, -(a7)
000168  lea.l  $0.l, a5
00016E  movea.l $18(a5), a4
000172  movea.l $18(a4), a4
000176  jsr    -$c(a4)
00017A  movea.l (a7)+, a5
00017C  rts    
00017E  move.l a5, -(a7)
000180  lea.l  $0.l, a5
000186  movea.l $18(a5), a0
00018A  btst.b #$2, $dff016.l
000192  bne.b  $19e
000194  move.w $e(a0), $c(a0)
00019A  movea.l (a7)+, a5
00019C  rts    
00019E  movea.l (a7)+, a5
0001A0  addq.w #$1, $c(a0)
0001A4  rts    
0001A6  movea.l (a7)+, a2
0001A8  bsr.w  $242
0001AC  movea.l $18(a5), a0
0001B0  movea.l $4(a0), a0
0001B4  jsr    (a0)
0001B6  movea.l $18(a5), a0
0001BA  move.w $c(a0), d0
0001BE  cmp.w  $10(a0), d0
0001C2  bcs.b  $1ac
0001C4  lea.l  $0.l, a0
0001CA  lea.l  $1f4(pc), a1
0001CE  moveq  #$10, d0
0001D0  jsr    -$54(a6)
0001D4  bsr.w  $3f2
0001D8  movea.l $18(a5), a0
0001DC  movea.l $4(a0), a0
0001E0  jsr    (a0)
0001E2  movea.l $18(a5), a0
0001E6  move.w $c(a0), d0
0001EA  cmp.w  $e(a0), d0
0001EE  bcs.b  $1d4
0001F0  moveq  #$0, d0
0001F2  rts    
0001F4  movem.l d0-d7/a0-a6, -(a7)
0001F8  lea.l  $0.l, a5
0001FE  movea.l (a5), a6
000200  moveq  #$40, d0
000202  and.w  $dff01e.l, d0
000208  and.w  $dff01c.l, d0
00020E  bne.b  $22e
000210  movea.l $18(a5), a0
000214  movea.l $8(a0), a0
000218  jsr    (a0)
00021A  bsr.w  $5b2
00021E  movem.l (a7)+, d0-d7/a0-a6
000222  move.w #$30, $dff09c.l
00022A  nop    
00022C  rte    
00022E  bsr.w  $698
000232  movem.l (a7)+, d0-d7/a0-a6
000236  move.w #$40, $dff09c.l
00023E  nop    
000240  rte    
000242  lea.l  $8.l, a0
000248  move.w #$fff, d0
00024C  moveq  #$0, d1
00024E  move.l d1, (a0)+
000250  dbra   d0, $24e
000254  lea.l  $30.l, a0
00025A  move.l #$15c, d0
000260  moveq  #$0, d1
000262  moveq  #$8, d2
000264  move.w #$120, d3
000268  jsr    -$72(a6)
00026C  move.l #$8, d0
000272  lea.l  $b8.l, a0
000278  move.l #$0, d1
00027E  moveq  #$3, d2
000280  move.w #$e0, d3
000284  jsr    -$72(a6)
000288  lea.l  $d4.l, a0
00028E  lea.l  $15c.l, a1
000294  moveq  #$1, d0
000296  moveq  #$f, d1
000298  jsr    -$9c(a6)
00029C  jsr    -$11a(a6)
0002A0  move.w $1c(a0), d0
0002A4  or.w   d0, $16.l
0002AA  moveq  #$8, d0
0002AC  trap   #$d
0002AE  move.w #$1, $34(a5)
0002B4  bsr.w  $bee
0002B8  jsr    $32e8.l
0002BE  jsr    $322c.l
0002C4  bsr.w  $7cc
0002C8  bsr.w  $2790
0002CC  jsr    $5be4.l
0002D2  bsr.w  $5360
0002D6  bsr.w  $2dc
0002DA  rts    
0002DC  jsr    -$11a(a6)
0002E0  move.l $18(a0), $3e4.l
0002E8  move.l $dff004.l, d0
0002EE  and.l  #$fff80, d0
0002F4  cmp.l  #$12900, d0
0002FA  bne.b  $2e8
0002FC  move.l $dff004.l, d0
000302  and.l  #$fff80, d0
000308  cmp.l  #$13000, d0
00030E  bne.b  $2fc
000310  bsr.b  $31c
000312  tst.b  $3ec.l
000318  bne.b  $2dc
00031A  rts    
00031C  tst.w  $3f0.l
000322  beq.b  $32e
000324  subq.w #$1, $3f0.l
00032A  bra.w  $3e2
00032E  move.w $3ee(pc), $3f0.l
000336  tst.b  $3ec.l
00033C  bne.b  $342
00033E  bra.w  $3e2
000342  subq.b #$1, $3ec.l
000348  movea.l $3e8(pc), a1
00034C  movea.l $3e4(pc), a0
000350  addq.w #$2, a0
000352  cmpi.w #$180, -$2(a0)
000358  blt.b  $3be
00035A  cmpi.w #$1c0, -$2(a0)
000360  bge.b  $3be
000362  move.w (a0), d0
000364  move.w (a1)+, d2
000366  move.w d0, d1
000368  move.w d2, d3
00036A  and.w  #$f, d1
00036E  and.w  #$f, d3
000372  cmp.w  d1, d3
000374  beq.b  $37e
000376  blt.b  $37c
000378  addq.w #$1, (a0)
00037A  bra.b  $37e
00037C  subq.w #$1, (a0)
00037E  move.w d0, d1
000380  move.w d2, d3
000382  lsr.w  #$4, d1
000384  lsr.w  #$4, d3
000386  and.w  #$f, d1
00038A  and.w  #$f, d3
00038E  cmp.w  d1, d3
000390  beq.b  $39e
000392  blt.b  $39a
000394  addi.w #$10, (a0)
000398  bra.b  $39e
00039A  subi.w #$10, (a0)
00039E  move.w d0, d1
0003A0  move.w d2, d3
0003A2  lsr.w  #$8, d1
0003A4  lsr.w  #$8, d3
0003A6  and.w  #$f, d1
0003AA  and.w  #$f, d3
0003AE  cmp.w  d1, d3
0003B0  beq.b  $3be
0003B2  blt.b  $3ba
0003B4  addi.w #$100, (a0)
0003B8  bra.b  $3be
0003BA  subi.w #$100, (a0)
0003BE  lea.l  $4(a0), a0
0003C2  cmpi.w #$84, -$2(a0)
0003C8  bne.b  $3d6
0003CA  move.w (a0), d0
0003CC  swap   d0
0003CE  move.w $4(a0), d0
0003D2  addq.w #$2, d0
0003D4  movea.l d0, a0
0003D6  cmpi.l #$fffffffe, -$2(a0)
0003DE  bne.w  $352
0003E2  rts    
0003E4  ori.b  #$0, d0
0003E8  ori.b  #$5c, d0
0003EC  move.b d0, d0
0003EE  ori.b  #$0, d4
0003F2  moveq  #$1, d0
0003F4  bsr.w  $43a
0003F8  move.l a0, d0
0003FA  beq.b  $438
0003FC  move.w $32(a5), d0
000400  beq.b  $3fc
000402  move.w d0, $34(a5)
000406  sub.w  d0, $32(a5)
00040A  move.l a0, $c(a5)
00040E  movea.l $24(a5), a1
000412  adda.w $34(a5), a1
000416  move.l a1, -$4(a0)
00041A  bsr.w  $704
00041E  movea.l $20(a5), a0
000422  bsr.w  $21a0
000426  lea.l  $0.l, a5
00042C  movea.l (a5), a6
00042E  movea.l $c(a5), a0
000432  move.b #$2, -$5(a0)
000438  rts    
00043A  lea.l  $8.l, a0
000440  cmp.b  -$5(a0), d0
000444  beq.b  $484
000446  lea.l  $6010.l, a0
00044C  cmp.b  -$5(a0), d0
000450  beq.b  $484
000452  lea.l  $c018.l, a0
000458  cmp.b  -$5(a0), d0
00045C  beq.b  $484
00045E  lea.l  $12020.l, a0
000464  cmp.b  -$5(a0), d0
000468  beq.b  $484
00046A  lea.l  $18028.l, a0
000470  cmp.b  -$5(a0), d0
000474  beq.b  $484
000476  lea.l  $1e030.l, a0
00047C  cmp.b  -$5(a0), d0
000480  beq.b  $484
000482  suba.l a0, a0
000484  rts    
000486  moveq  #$ff, d1
000488  suba.l a0, a0
00048A  moveq  #$2, d0
00048C  lea.l  $8.l, a1
000492  cmp.b  -$5(a1), d0
000496  bne.b  $4bc
000498  move.l $24(a5), d2
00049C  sub.l  -$4(a1), d2
0004A0  bmi.b  $4bc
0004A2  cmp.l  d1, d2
0004A4  bcc.b  $4b6
0004A6  move.l a0, d1
0004A8  beq.b  $4b0
0004AA  move.b #$0, -$5(a0)
0004B0  movea.l a1, a0
0004B2  move.l d2, d1
0004B4  bra.b  $4bc
0004B6  move.b #$0, -$5(a1)
0004BC  lea.l  $6010.l, a1
0004C2  cmp.b  -$5(a1), d0
0004C6  bne.b  $4ec
0004C8  move.l $24(a5), d2
0004CC  sub.l  -$4(a1), d2
0004D0  bmi.b  $4ec
0004D2  cmp.l  d1, d2
0004D4  bcc.b  $4e6
0004D6  move.l a0, d1
0004D8  beq.b  $4e0
0004DA  move.b #$0, -$5(a0)
0004E0  movea.l a1, a0
0004E2  move.l d2, d1
0004E4  bra.b  $4ec
0004E6  move.b #$0, -$5(a1)
0004EC  lea.l  $c018.l, a1
0004F2  cmp.b  -$5(a1), d0
0004F6  bne.b  $51c
0004F8  move.l $24(a5), d2
0004FC  sub.l  -$4(a1), d2
000500  bmi.b  $51c
000502  cmp.l  d1, d2
000504  bcc.b  $516
000506  move.l a0, d1
000508  beq.b  $510
00050A  move.b #$0, -$5(a0)
000510  movea.l a1, a0
000512  move.l d2, d1
000514  bra.b  $51c
000516  move.b #$0, -$5(a1)
00051C  lea.l  $12020.l, a1
000522  cmp.b  -$5(a1), d0
000526  bne.b  $54c
000528  move.l $24(a5), d2
00052C  sub.l  -$4(a1), d2
000530  bmi.b  $54c
000532  cmp.l  d1, d2
000534  bcc.b  $546
000536  move.l a0, d1
000538  beq.b  $540
00053A  move.b #$0, -$5(a0)
000540  movea.l a1, a0
000542  move.l d2, d1
000544  bra.b  $54c
000546  move.b #$0, -$5(a1)
00054C  lea.l  $18028.l, a1
000552  cmp.b  -$5(a1), d0
000556  bne.b  $57c
000558  move.l $24(a5), d2
00055C  sub.l  -$4(a1), d2
000560  bmi.b  $57c
000562  cmp.l  d1, d2
000564  bcc.b  $576
000566  move.l a0, d1
000568  beq.b  $570
00056A  move.b #$0, -$5(a0)
000570  movea.l a1, a0
000572  move.l d2, d1
000574  bra.b  $57c
000576  move.b #$0, -$5(a1)
00057C  lea.l  $1e030.l, a1
000582  cmp.b  -$5(a1), d0
000586  bne.b  $5ac
000588  move.l $24(a5), d2
00058C  sub.l  -$4(a1), d2
000590  bmi.b  $5ac
000592  cmp.l  d1, d2
000594  bcc.b  $5a6
000596  move.l a0, d1
000598  beq.b  $5a0
00059A  move.b #$0, -$5(a0)
0005A0  movea.l a1, a0
0005A2  move.l d2, d1
0005A4  bra.b  $5ac
0005A6  move.b #$0, -$5(a1)
0005AC  cmp.w  #$1, d2
0005B0  rts    
0005B2  jsr    $27da.l
0005B8  jsr    $5400.l
0005BE  move.l $2c(a5), d0
0005C2  beq.b  $5d6
0005C4  addq.l #$2, d0
0005C6  movea.l d0, a1
0005C8  lea.l  $d4.l, a0
0005CE  moveq  #$1, d0
0005D0  moveq  #$f, d1
0005D2  jsr    -$9c(a6)
0005D6  jsr    $73ea.l
0005DC  addq.w #$1, $32(a5)
0005E0  addq.l #$1, $24(a5)
0005E4  move.b #$1, $36(a5)
0005EA  tst.b  $3a(a5)
0005EE  bne.w  $63e
0005F2  tst.l  $10(a5)
0005F6  bne.w  $67a
0005FA  moveq  #$0, d0
0005FC  bsr.w  $43a
000600  move.l a0, d0
000602  beq.b  $63e
000604  lea.l  $dff002.l, a4
00060A  btst.b #$6, (a4)
00060E  bne.b  $60a
000610  move.l a0, $10(a5)
000614  move.l #$1ff0000, $3e(a4)
00061C  move.w #$0, $64(a4)
000622  move.l a0, $52(a4)
000626  move.w #$40, $9a(a4)
00062C  move.w #$8040, $98(a4)
000632  move.b #$ff, $3a(a5)
000638  move.w #$c010, $56(a4)
00063E  moveq  #$2, d0
000640  bsr.w  $486
000644  move.l a0, d0
000646  beq.b  $678
000648  move.l $14(a5), d0
00064C  beq.b  $656
00064E  movea.l d0, a1
000650  move.b #$0, -$5(a1)
000656  move.l a0, $14(a5)
00065A  move.b #$3, -$5(a0)
000660  move.l a0, d0
000662  lea.l  $b8.l, a0
000668  move.l #$20, d1
00066E  moveq  #$3, d2
000670  move.w #$e0, d3
000674  jsr    -$72(a6)
000678  rts    
00067A  illegal #$4afc
00067C  ori.b  #$8, d0
000680  ori.b  #$10, d0
000684  ori.b  #$18, d0
000688  ori.b  #$20, d1
00068C  ori.b  #$8, d0
000690  ori.b  #$10, d0
000694  ori.b  #$18, d0
000698  tst.b  $3a(a5)
00069C  bmi.b  $6dc
00069E  beq.b  $6d8
0006A0  movea.l $10(a5), a0
0006A4  adda.w #$40, a0
0006A8  lea.l  $dff002.l, a4
0006AE  btst.b #$6, (a4)
0006B2  bne.b  $6ae
0006B4  move.l a0, $52(a4)
0006B8  move.w #$40, $64(a4)
0006BE  move.w #$40, $9a(a4)
0006C4  move.w #$8040, $98(a4)
0006CA  move.b #$ff, $3a(a5)
0006D0  move.w #$4010, $56(a4)
0006D6  rts    
0006D8  illegal #$4afc
0006DA  rts    
0006DC  move.b #$0, $3a(a5)
0006E2  lea.l  $dff002.l, a4
0006E8  move.w #$40, $98(a4)
0006EE  movea.l $10(a5), a0
0006F2  move.l a0, d0
0006F4  beq.b  $702
0006F6  move.b #$1, -$5(a0)
0006FC  clr.l  $10(a5)
000700  rts    
000702  illegal #$4afc
000704  jsr    -$11a(a6)
000708  movea.l d0, a2
00070A  jsr    -$c0(a6)
00070E  tst.b  d0
000710  beq.b  $716
000712  move.b d0, $37(a5)
000716  movem.w $30(a2), d3-d4
00071C  moveq  #$0, d1
00071E  moveq  #$0, d2
000720  tst.b  $2c(a2)
000724  bne.b  $72a
000726  exg.l  d1, d3
000728  exg.l  d2, d4
00072A  movea.l $20(a5), a0
00072E  movea.l $14(a0), a0
000732  cmpi.l #$2594, $c(a0)
00073A  bne.b  $756
00073C  movea.l $10(a0), a0
000740  neg.w  d1
000742  neg.w  d2
000744  neg.w  d3
000746  neg.w  d4
000748  move.w d1, $4(a0)
00074C  move.w d2, (a0)
00074E  move.w d3, $2(a0)
000752  add.w  d4, $30(a0)
000756  move.w #$0, $32(a5)
00075C  rts    
00075E  move.b $1(a1), d1
000762  cmp.b  #$ff, d1
000766  beq.b  $792
000768  cmp.b  d0, d1
00076A  bne.b  $78e
00076C  move.w $2(a1), d0
000770  move.l $4(a1), d1
000774  move.b (a1), d2
000776  cmp.b  #$1, d2
00077A  beq.b  $794
00077C  cmp.b  #$2, d2
000780  beq.b  $79e
000782  cmp.b  #$3, d2
000786  beq.b  $7a8
000788  cmp.b  #$4, d2
00078C  beq.b  $7b2
00078E  addq.l #$8, a1
000790  bra.b  $75e
000792  rts    
000794  muls.w $34(a5), d1
000798  add.w  d1, (a0, d0.w)
00079C  rts    
00079E  muls.w $34(a5), d1
0007A2  add.l  d1, (a0, d0.w)
0007A6  rts    
0007A8  muls.w $34(a5), d1
0007AC  move.w d1, (a0, d0.w)
0007B0  rts    
0007B2  muls.w $34(a5), d1
0007B6  move.l d1, (a0, d0.w)
0007BA  rts    
0007BC  ori.b  #$84, d0
0007C0  eori.w #$842, -(a3)
0007C4  ; data: 0x0a, 0x88
0007C6  ; data: 0x08, 0x66
0007C8  bchg.b d0, $3a0(a1)
0007CC  lea.l  $103c.l, a0
0007D2  moveq  #$0, d0
0007D4  moveq  #$7, d1
0007D6  movea.l a0, a1
0007D8  move.w d0, d2
0007DA  move.w $84e.l, d3
0007E0  bsr.w  $846
0007E4  move.w $84c.l, (a0)+
0007EA  move.w d1, d2
0007EC  move.w $850.l, d3
0007F2  bsr.w  $846
0007F6  move.w $852.l, (a0)+
0007FC  lea.l  $12(a1), a0
000800  addq.w #$1, d0
000802  dbra   d1, $7d6
000806  lea.l  $3c.l, a0
00080C  lea.l  $83c.l, a1
000812  moveq  #$0, d0
000814  moveq  #$0, d1
000816  move.w d0, d2
000818  not.w  d2
00081A  bset.b d2, d1
00081C  subq.l #$1, d1
00081E  move.l d1, (a0)+
000820  not.l  d1
000822  move.l d1, (a1)+
000824  move.w d0, d1
000826  lsr.w  #$5, d1
000828  mulu.w #$12, d1
00082C  add.l  #$103c, d1
000832  move.l d1, (a0)+
000834  move.l d1, (a1)+
000836  addq.w #$1, d0
000838  cmp.w  #$100, d0
00083C  bne.b  $814
00083E  moveq  #$5, d0
000840  trap   #$d
000842  rts    
000844  move.w d3, (a0)+
000846  dbra   d2, $844
00084A  rts    
00084C  move.l d5, (a0)+
00084E  move.l d6, (a0)+
000850  move.l d7, (a0)+
000852  rts    
000854  movem.l d2-d7/a2-a6, -(a7)
000858  move.w $6(a0), d1
00085C  move.w $8(a0), d2
000860  move.w $a(a0), d3
000864  ext.l  d1
000866  ext.l  d2
000868  ext.l  d3
00086A  lea.l  $b22(pc), a0
00086E  moveq  #$0, d4
000870  move.l d3, d0
000872  sub.l  d2, d0
000874  sub.l  d1, d0
000876  asr.l  #$8, d0
000878  move.l d0, (a0)+
00087A  add.l  d0, d0
00087C  addx.b d4, d4
00087E  move.l d1, d0
000880  sub.l  d2, d0
000882  add.l  d3, d0
000884  asr.l  #$8, d0
000886  move.l d0, (a0)+
000888  add.l  d0, d0
00088A  addx.b d4, d4
00088C  move.l d1, d0
00088E  add.l  d2, d0
000890  add.l  d3, d0
000892  asr.l  #$8, d0
000894  move.l d0, (a0)+
000896  add.l  d0, d0
000898  addx.b d4, d4
00089A  sub.l  d1, d2
00089C  add.l  d3, d2
00089E  asr.l  #$8, d2
0008A0  move.l d2, (a0)+
0008A2  add.l  d2, d2
0008A4  addx.b d4, d4
0008A6  add.w  d4, d4
0008A8  add.w  d4, d4
0008AA  movea.l $8b6(pc, d4.w), a0
0008AE  jsr    (a0)
0008B0  movem.l (a7)+, d2-d7/a2-a6
0008B4  rts    
0008B6  ori.b  #$f6, d0
0008BA  ori.b  #$4, d0
0008BE  ori.b  #$2e, d0
0008C2  ori.b  #$5a, d0
0008C6  ori.b  #$84, d0
0008CA  ori.b  #$e, d0
0008CE  ori.b  #$ae, d0
0008D2  ori.b  #$d8, d0
0008D6  ori.b  #$2, d0
0008DA  ori.b  #$2a, d0
0008DE  ori.b  #$e, d0
0008E2  ori.b  #$54, d0
0008E6  ori.b  #$80, d0
0008EA  ori.b  #$aa, d0
0008EE  ori.b  #$d6, d0
0008F2  ori.b  #$0, d0
0008F6  movea.l $c(a5), a0
0008FA  moveq  #$ff, d4
0008FC  move.w #$100, d1
000900  bra.w  $bc4
000904  move.l $b2a(pc), d1
000908  move.l $b2e(pc), d0
00090C  sub.l  d0, d1
00090E  muls.w #$ff01, d0
000912  divs.w d1, d0
000914  move.w #$ff, d1
000918  move.l $b2e(pc), d2
00091C  move.l $b22(pc), d3
000920  sub.l  d3, d2
000922  muls.w #$ff01, d3
000926  divs.w d2, d3
000928  moveq  #$0, d2
00092A  bra.w  $b32
00092E  move.l $b2a(pc), d0
000932  move.l $b26(pc), d1
000936  sub.l  d1, d0
000938  muls.w #$ff01, d1
00093C  divs.w d0, d1
00093E  move.w #$ff, d0
000942  move.l $b2a(pc), d3
000946  move.l $b2e(pc), d2
00094A  sub.l  d2, d3
00094C  muls.w #$ff01, d2
000950  divs.w d3, d2
000952  move.w #$ff, d3
000956  bra.w  $b32
00095A  move.l $b2a(pc), d0
00095E  move.l $b26(pc), d1
000962  sub.l  d1, d0
000964  muls.w #$ff01, d1
000968  divs.w d0, d1
00096A  move.w #$ff, d0
00096E  move.l $b2e(pc), d2
000972  move.l $b22(pc), d3
000976  sub.l  d3, d2
000978  muls.w #$ff01, d3
00097C  divs.w d2, d3
00097E  moveq  #$0, d2
000980  bra.w  $b32
000984  move.l $b26(pc), d1
000988  move.l $b22(pc), d0
00098C  sub.l  d0, d1
00098E  muls.w #$ff01, d0
000992  divs.w d1, d0
000994  moveq  #$0, d1
000996  move.l $b2a(pc), d2
00099A  move.l $b26(pc), d3
00099E  sub.l  d3, d2
0009A0  muls.w #$ff01, d3
0009A4  divs.w d2, d3
0009A6  move.w #$ff, d2
0009AA  bra.w  $b32
0009AE  move.l $b26(pc), d1
0009B2  move.l $b22(pc), d0
0009B6  sub.l  d0, d1
0009B8  muls.w #$ff01, d0
0009BC  divs.w d1, d0
0009BE  moveq  #$0, d1
0009C0  move.l $b2a(pc), d3
0009C4  move.l $b2e(pc), d2
0009C8  sub.l  d2, d3
0009CA  muls.w #$ff01, d2
0009CE  divs.w d3, d2
0009D0  move.w #$ff, d3
0009D4  bra.w  $b32
0009D8  move.l $b26(pc), d1
0009DC  move.l $b22(pc), d0
0009E0  sub.l  d0, d1
0009E2  muls.w #$ff01, d0
0009E6  divs.w d1, d0
0009E8  moveq  #$0, d1
0009EA  move.l $b2e(pc), d2
0009EE  move.l $b22(pc), d3
0009F2  sub.l  d3, d2
0009F4  muls.w #$ff01, d3
0009F8  divs.w d2, d3
0009FA  moveq  #$0, d2
0009FC  moveq  #$0, d5
0009FE  bra.w  $b32
000A02  move.l $b26(pc), d1
000A06  move.l $b22(pc), d0
000A0A  sub.l  d0, d1
000A0C  muls.w #$ff01, d0
000A10  divs.w d1, d0
000A12  moveq  #$0, d1
000A14  move.l $b2e(pc), d2
000A18  move.l $b22(pc), d3
000A1C  sub.l  d3, d2
000A1E  muls.w #$ff01, d3
000A22  divs.w d2, d3
000A24  moveq  #$0, d2
000A26  bra.w  $b44
000A2A  move.l $b26(pc), d1
000A2E  move.l $b22(pc), d0
000A32  sub.l  d0, d1
000A34  muls.w #$ff01, d0
000A38  divs.w d1, d0
000A3A  moveq  #$0, d1
000A3C  move.l $b2a(pc), d3
000A40  move.l $b2e(pc), d2
000A44  sub.l  d2, d3
000A46  muls.w #$ff01, d2
000A4A  divs.w d3, d2
000A4C  move.w #$ff, d3
000A50  bra.w  $b44
000A54  move.l $b26(pc), d1
000A58  move.l $b22(pc), d0
000A5C  sub.l  d0, d1
000A5E  muls.w #$ff01, d0
000A62  divs.w d1, d0
000A64  moveq  #$0, d1
000A66  move.l $b2a(pc), d2
000A6A  move.l $b26(pc), d3
000A6E  sub.l  d3, d2
000A70  muls.w #$ff01, d3
000A74  divs.w d2, d3
000A76  move.w #$ff, d2
000A7A  moveq  #$0, d5
000A7C  bra.w  $b44
000A80  move.l $b2a(pc), d0
000A84  move.l $b26(pc), d1
000A88  sub.l  d1, d0
000A8A  muls.w #$ff01, d1
000A8E  divs.w d0, d1
000A90  move.w #$ff, d0
000A94  move.l $b2e(pc), d2
000A98  move.l $b22(pc), d3
000A9C  sub.l  d3, d2
000A9E  muls.w #$ff01, d3
000AA2  divs.w d2, d3
000AA4  moveq  #$0, d2
000AA6  bra.w  $b44
000AAA  move.l $b2a(pc), d0
000AAE  move.l $b26(pc), d1
000AB2  sub.l  d1, d0
000AB4  muls.w #$ff01, d1
000AB8  divs.w d0, d1
000ABA  move.w #$ff, d0
000ABE  move.l $b2a(pc), d3
000AC2  move.l $b2e(pc), d2
000AC6  sub.l  d2, d3
000AC8  muls.w #$ff01, d2
000ACC  divs.w d3, d2
000ACE  move.w #$ff, d3
000AD2  moveq  #$0, d5
000AD4  bra.b  $b44
000AD6  move.l $b2a(pc), d1
000ADA  move.l $b2e(pc), d0
000ADE  sub.l  d0, d1
000AE0  muls.w #$ff01, d0
000AE4  divs.w d1, d0
000AE6  move.w #$ff, d1
000AEA  move.l $b2e(pc), d2
000AEE  move.l $b22(pc), d3
000AF2  sub.l  d3, d2
000AF4  muls.w #$ff01, d3
000AF8  divs.w d2, d3
000AFA  moveq  #$0, d2
000AFC  moveq  #$0, d5
000AFE  bra.b  $b44
000B00  movea.l $c(a5), a0
000B04  moveq  #$0, d4
000B06  move.w #$100, d1
000B0A  bra.w  $bc4
000B0E  move.w #$1000, d7
000B12  move.w $dff006.l, $dff180.l
000B1C  dbra   d7, $b12
000B20  rts    
000B22  ori.b  #$0, d0
000B26  ori.b  #$0, d0
000B2A  ori.b  #$0, d0
000B2E  ori.b  #$0, d0
000B32  lea.l  $83c.l, a1
000B38  lea.l  $3c.l, a2
000B3E  moveq  #$ff, d6
000B40  moveq  #$0, d7
000B42  bra.b  $b54
000B44  lea.l  $3c.l, a1
000B4A  lea.l  $83c.l, a2
000B50  moveq  #$0, d6
000B52  moveq  #$ff, d7
000B54  movea.l $c(a5), a0
000B58  cmp.w  d1, d3
000B5A  bgt.b  $b72
000B5C  bne.b  $b6a
000B5E  cmp.w  d0, d2
000B60  bne.b  $b72
000B62  move.l d5, d4
000B64  move.w #$100, d1
000B68  bra.b  $bc4
000B6A  exg.l  d0, d2
000B6C  exg.l  d1, d3
000B6E  exg.l  d6, d7
000B70  exg.l  a1, a2
000B72  move.l d6, d4
000B74  sub.w  d0, d2
000B76  bmi.b  $b7a
000B78  move.l d7, d4
000B7A  bsr.b  $bc4
000B7C  move.w #$ff, d5
000B80  sub.w  d3, d5
000B82  movem.l d4-d5, -(a7)
000B86  sub.w  d1, d3
000B88  add.w  d2, d2
000B8A  lea.l  $112cc.l, a2
000B90  move.w d3, d1
000B92  add.w  d1, d1
000B94  muls.w (a2, d1.w), d2
000B98  ext.l  d0
000B9A  moveq  #$0, d1
000B9C  move.l d2, d4
000B9E  swap   d2
000BA0  addq.w #$1, d3
000BA2  bra.b  $bb8
000BA4  move.w d0, d5
000BA6  lsl.w  #$3, d5
000BA8  movem.l (a1, d5.w), d5/a2
000BAE  jsr    (a2)
000BB0  lea.l  $40(a0), a0
000BB4  add.w  d4, d1
000BB6  addx.w d2, d0
000BB8  dbra   d3, $ba4
000BBC  movem.l (a7)+, d4-d5
000BC0  move.l d5, d1
000BC2  not.l  d4
000BC4  movem.l d0-d7/a1-a3, -(a7)
000BC8  move.l d4, d0
000BCA  move.l d0, d2
000BCC  move.l d0, d3
000BCE  move.l d0, d5
000BD0  move.l d0, d6
000BD2  move.l d0, d7
000BD4  movea.l d0, a1
000BD6  movea.l d0, a2
000BD8  movea.l d0, a3
000BDA  bra.b  $be4
000BDC  movem.l d0/d2-d7/a1, (a0)
000BE0  lea.l  $60(a0), a0
000BE4  dbra   d1, $bdc
000BE8  movem.l (a7)+, d0-d7/a1-a3
000BEC  rts    
000BEE  bsr.b  $bf2
000BF0  rts    
000BF2  lea.l  $10cc.l, a0
000BF8  move.w #$100, d0
000BFC  adda.w d0, a0
000BFE  adda.w d0, a0
000C00  move.w #$7fff, d2
000C04  mulu.w d0, d2
000C06  move.l d2, d1
000C08  divu.w d0, d1
000C0A  move.w d1, (a0)+
000C0C  addq.w #$1, d0
000C0E  cmp.w  #$4000, d0
000C12  bne.b  $c06
000C14  rts    
000C16  move.w #$7fe, d0
000C1A  and.w  d0, d5
000C1C  and.w  d0, d6
000C1E  and.w  d0, d7
000C20  lea.l  $1056.l, a1
000C26  move.w (a1, d5.w), d0
000C2A  move.w (a1, d6.w), d1
000C2E  move.w (a1, d7.w), d2
000C32  lea.l  $1256.l, a1
000C38  move.w (a1, d5.w), d3
000C3C  move.w (a1, d6.w), d4
000C40  move.w (a1, d7.w), d5
000C44  move.w d4, d6
000C46  muls.w d5, d6
000C48  add.l  d6, d6
000C4A  swap   d6
000C4C  move.w d6, (a0)+
000C4E  move.w d1, d6
000C50  muls.w d5, d6
000C52  add.l  d6, d6
000C54  swap   d6
000C56  movea.w d6, a1
000C58  muls.w d0, d6
000C5A  move.w d2, d7
000C5C  muls.w d3, d7
000C5E  add.l  d6, d7
000C60  add.l  d7, d7
000C62  swap   d7
000C64  move.w d7, (a0)+
000C66  move.w a1, d6
000C68  muls.w d3, d6
000C6A  move.w d2, d7
000C6C  muls.w d0, d7
000C6E  sub.l  d6, d7
000C70  add.l  d7, d7
000C72  swap   d7
000C74  move.w d7, (a0)+
000C76  move.w d2, d6
000C78  neg.w  d6
000C7A  muls.w d4, d6
000C7C  add.l  d6, d6
000C7E  swap   d6
000C80  move.w d6, (a0)+
000C82  muls.w d1, d2
000C84  add.l  d2, d2
000C86  swap   d2
000C88  move.w d2, d7
000C8A  muls.w d0, d2
000C8C  move.w d5, d6
000C8E  muls.w d3, d6
000C90  sub.l  d2, d6
000C92  add.l  d6, d6
000C94  swap   d6
000C96  move.w d6, (a0)+
000C98  muls.w d3, d7
000C9A  muls.w d0, d5
000C9C  add.l  d7, d5
000C9E  add.l  d5, d5
000CA0  swap   d5
000CA2  move.w d5, (a0)+
000CA4  move.w d1, (a0)+
000CA6  neg.w  d0
000CA8  muls.w d4, d0
000CAA  add.l  d0, d0
000CAC  swap   d0
000CAE  move.w d0, (a0)+
000CB0  muls.w d4, d3
000CB2  add.l  d3, d3
000CB4  swap   d3
000CB6  move.w d3, (a0)
000CB8  rts    
000CBA  movem.w (a0)+, d0-d2
000CBE  move.w (a1), d3
000CC0  move.w $6(a1), d4
000CC4  move.w $c(a1), d5
000CC8  muls.w d0, d3
000CCA  muls.w d1, d4
000CCC  muls.w d2, d5
000CCE  add.l  d3, d4
000CD0  add.l  d4, d5
000CD2  add.l  d5, d5
000CD4  swap   d5
000CD6  move.w d5, (a2)+
000CD8  move.w $2(a1), d3
000CDC  move.w $8(a1), d4
000CE0  move.w $e(a1), d5
000CE4  muls.w d0, d3
000CE6  muls.w d1, d4
000CE8  muls.w d2, d5
000CEA  add.l  d3, d4
000CEC  add.l  d4, d5
000CEE  add.l  d5, d5
000CF0  swap   d5
000CF2  move.w d5, (a2)+
000CF4  muls.w $4(a1), d0
000CF8  muls.w $a(a1), d1
000CFC  muls.w $10(a1), d2
000D00  add.l  d1, d0
000D02  add.l  d2, d0
000D04  add.l  d0, d0
000D06  swap   d0
000D08  move.w d0, (a2)+
000D0A  movem.w (a0)+, d0-d2
000D0E  move.w (a1), d3
000D10  move.w $6(a1), d4
000D14  move.w $c(a1), d5
000D18  muls.w d0, d3
000D1A  muls.w d1, d4
000D1C  muls.w d2, d5
000D1E  add.l  d3, d4
000D20  add.l  d4, d5
000D22  add.l  d5, d5
000D24  swap   d5
000D26  move.w d5, (a2)+
000D28  move.w $2(a1), d3
000D2C  move.w $8(a1), d4
000D30  move.w $e(a1), d5
000D34  muls.w d0, d3
000D36  muls.w d1, d4
000D38  muls.w d2, d5
000D3A  add.l  d3, d4
000D3C  add.l  d4, d5
000D3E  add.l  d5, d5
000D40  swap   d5
000D42  move.w d5, (a2)+
000D44  muls.w $4(a1), d0
000D48  muls.w $a(a1), d1
000D4C  muls.w $10(a1), d2
000D50  add.l  d1, d0
000D52  add.l  d2, d0
000D54  add.l  d0, d0
000D56  swap   d0
000D58  move.w d0, (a2)+
000D5A  movem.w (a0)+, d0-d2
000D5E  move.w (a1), d3
000D60  move.w $6(a1), d4
000D64  move.w $c(a1), d5
000D68  muls.w d0, d3
000D6A  muls.w d1, d4
000D6C  muls.w d2, d5
000D6E  add.l  d3, d4
000D70  add.l  d4, d5
000D72  add.l  d5, d5
000D74  swap   d5
000D76  move.w d5, (a2)+
000D78  move.w $2(a1), d3
000D7C  move.w $8(a1), d4
000D80  move.w $e(a1), d5
000D84  muls.w d0, d3
000D86  muls.w d1, d4
000D88  muls.w d2, d5
000D8A  add.l  d3, d4
000D8C  add.l  d4, d5
000D8E  add.l  d5, d5
000D90  swap   d5
000D92  move.w d5, (a2)+
000D94  muls.w $4(a1), d0
000D98  muls.w $a(a1), d1
000D9C  muls.w $10(a1), d2
000DA0  add.l  d1, d0
000DA2  add.l  d2, d0
000DA4  add.l  d0, d0
000DA6  swap   d0
000DA8  move.w d0, (a2)+
000DAA  rts    
000DAC  move.w d0, d3
000DAE  move.w d1, d4
000DB0  move.w d2, d5
000DB2  muls.w (a0)+, d0
000DB4  muls.w (a0)+, d4
000DB6  muls.w (a0)+, d5
000DB8  add.l  d4, d0
000DBA  add.l  d5, d0
000DBC  add.l  d0, d0
000DBE  swap   d0
000DC0  move.w d3, d5
000DC2  move.w d1, d4
000DC4  move.w d2, d6
000DC6  muls.w (a0)+, d5
000DC8  muls.w (a0)+, d1
000DCA  muls.w (a0)+, d6
000DCC  add.l  d5, d1
000DCE  add.l  d6, d1
000DD0  add.l  d1, d1
000DD2  swap   d1
000DD4  muls.w (a0)+, d3
000DD6  muls.w (a0)+, d4
000DD8  muls.w (a0)+, d2
000DDA  add.l  d3, d2
000DDC  add.l  d4, d2
000DDE  add.l  d2, d2
000DE0  swap   d2
000DE2  rts    
000DE4  move.w d0, d3
000DE6  muls.w (a0)+, d0
000DE8  move.w d3, d4
000DEA  muls.w (a0)+, d4
000DEC  move.w d3, d5
000DEE  muls.w (a0)+, d5
000DF0  move.w d1, d6
000DF2  muls.w (a0)+, d6
000DF4  add.l  d6, d0
000DF6  move.w d1, d6
000DF8  muls.w (a0)+, d1
000DFA  add.l  d4, d1
000DFC  muls.w (a0)+, d6
000DFE  add.l  d6, d5
000E00  move.w d2, d6
000E02  muls.w (a0)+, d6
000E04  add.l  d6, d0
000E06  move.w d2, d6
000E08  muls.w (a0)+, d6
000E0A  add.l  d6, d1
000E0C  muls.w (a0)+, d2
000E0E  add.l  d5, d2
000E10  add.l  d0, d0
000E12  swap   d0
000E14  add.l  d1, d1
000E16  swap   d1
000E18  add.l  d2, d2
000E1A  swap   d2
000E1C  rts    
000E1E  movem.l d2-d7/a2, -(a7)
000E22  movem.w $6(a0), d0-d5
000E28  lea.l  (a0), a2
000E2A  move.w d1, d6
000E2C  muls.w d5, d6
000E2E  move.w d2, d7
000E30  muls.w d4, d7
000E32  sub.l  d7, d6
000E34  add.l  d6, d6
000E36  swap   d6
000E38  move.w d6, (a2)+
000E3A  muls.w d3, d2
000E3C  muls.w d0, d5
000E3E  sub.l  d5, d2
000E40  add.l  d2, d2
000E42  swap   d2
000E44  move.w d2, (a2)+
000E46  muls.w d0, d4
000E48  muls.w d1, d3
000E4A  sub.l  d3, d4
000E4C  add.l  d4, d4
000E4E  swap   d4
000E50  move.w d4, (a2)
000E52  movem.w $c(a0), d0-d2
000E58  movem.w (a0), d3-d5
000E5C  lea.l  $6(a0), a2
000E60  move.w d1, d6
000E62  muls.w d5, d6
000E64  move.w d2, d7
000E66  muls.w d4, d7
000E68  sub.l  d7, d6
000E6A  add.l  d6, d6
000E6C  swap   d6
000E6E  move.w d6, (a2)+
000E70  muls.w d3, d2
000E72  muls.w d0, d5
000E74  sub.l  d5, d2
000E76  add.l  d2, d2
000E78  swap   d2
000E7A  move.w d2, (a2)+
000E7C  muls.w d0, d4
000E7E  muls.w d1, d3
000E80  sub.l  d3, d4
000E82  add.l  d4, d4
000E84  swap   d4
000E86  move.w d4, (a2)
000E88  movea.l a1, a2
000E8A  movem.w (a0)+, d0-d2
000E8E  move.w d0, d3
000E90  swap   d3
000E92  clr.w  d3
000E94  asr.l  #$1, d3
000E96  sub.l  d0, d3
000E98  move.w d1, d4
000E9A  swap   d4
000E9C  clr.w  d4
000E9E  asr.l  #$1, d4
000EA0  sub.l  d1, d4
000EA2  move.w d2, d5
000EA4  swap   d5
000EA6  clr.w  d5
000EA8  asr.l  #$1, d5
000EAA  sub.l  d2, d5
000EAC  bsr.b  $f1c
000EAE  divs.w d0, d3
000EB0  divs.w d0, d4
000EB2  divs.w d0, d5
000EB4  move.w d3, (a2)+
000EB6  move.w d4, (a2)+
000EB8  move.w d5, (a2)+
000EBA  movem.w (a0)+, d0-d2
000EBE  move.w d0, d3
000EC0  swap   d3
000EC2  clr.w  d3
000EC4  asr.l  #$1, d3
000EC6  sub.l  d0, d3
000EC8  move.w d1, d4
000ECA  swap   d4
000ECC  clr.w  d4
000ECE  asr.l  #$1, d4
000ED0  sub.l  d1, d4
000ED2  move.w d2, d5
000ED4  swap   d5
000ED6  clr.w  d5
000ED8  asr.l  #$1, d5
000EDA  sub.l  d2, d5
000EDC  bsr.b  $f1c
000EDE  divs.w d0, d3
000EE0  divs.w d0, d4
000EE2  divs.w d0, d5
000EE4  move.w d3, (a2)+
000EE6  move.w d4, (a2)+
000EE8  move.w d5, (a2)+
000EEA  movem.w (a1), d0-d5
000EEE  move.w d1, d6
000EF0  muls.w d5, d6
000EF2  move.w d2, d7
000EF4  muls.w d4, d7
000EF6  sub.l  d7, d6
000EF8  add.l  d6, d6
000EFA  swap   d6
000EFC  move.w d6, (a2)+
000EFE  muls.w d3, d2
000F00  muls.w d0, d5
000F02  sub.l  d5, d2
000F04  add.l  d2, d2
000F06  swap   d2
000F08  move.w d2, (a2)+
000F0A  muls.w d0, d4
000F0C  muls.w d1, d3
000F0E  sub.l  d3, d4
000F10  add.l  d4, d4
000F12  swap   d4
000F14  move.w d4, (a2)
000F16  movem.l (a7)+, d2-d7/a2
000F1A  rts    
000F1C  muls.w d0, d0
000F1E  muls.w d1, d1
000F20  muls.w d2, d2
000F22  add.l  d0, d2
000F24  add.l  d1, d2
000F26  moveq  #$f, d7
000F28  move.l #$40000000, d0
000F2E  move.l d2, d1
000F30  clr.w  d1
000F32  swap   d1
000F34  swap   d0
000F36  sub.l  d0, d1
000F38  bcc.b  $f4e
000F3A  add.l  d0, d1
000F3C  swap   d0
000F3E  add.w  d0, d0
000F40  add.w  d2, d2
000F42  addx.l d1, d1
000F44  add.w  d2, d2
000F46  addx.l d1, d1
000F48  dbra   d7, $f34
000F4C  rts    
000F4E  swap   d0
000F50  add.w  d0, d0
000F52  addq.w #$1, d0
000F54  add.w  d2, d2
000F56  addx.l d1, d1
000F58  add.w  d2, d2
000F5A  addx.l d1, d1
000F5C  dbra   d7, $f34
000F60  rts    
000F62  movem.w $4(a0), a4-a6
000F68  lea.l  $c(a0), a1
000F6C  movea.l $20(a0), a0
000F70  move.w $10(a0), d7
000F74  movea.l (a0), a0
000F76  lea.l  $543ac.l, a3
000F7C  lea.l  $6(a3), a3
000F80  bra.b  $fcc
000F82  movem.w (a0)+, d0-d2
000F86  movea.l a1, a2
000F88  move.w d0, d3
000F8A  move.w d1, d4
000F8C  move.w d2, d5
000F8E  muls.w (a2)+, d0
000F90  muls.w (a2)+, d4
000F92  muls.w (a2)+, d5
000F94  add.l  d4, d0
000F96  add.l  d5, d0
000F98  add.l  d0, d0
000F9A  swap   d0
000F9C  move.w d3, d5
000F9E  move.w d1, d4
000FA0  move.w d2, d6
000FA2  muls.w (a2)+, d5
000FA4  muls.w (a2)+, d1
000FA6  muls.w (a2)+, d6
000FA8  add.l  d5, d1
000FAA  add.l  d6, d1
000FAC  add.l  d1, d1
000FAE  swap   d1
000FB0  muls.w (a2)+, d3
000FB2  muls.w (a2)+, d4
000FB4  muls.w (a2)+, d2
000FB6  add.l  d3, d2
000FB8  add.l  d4, d2
000FBA  add.l  d2, d2
000FBC  swap   d2
000FBE  add.w  a4, d0
000FC0  add.w  a5, d1
000FC2  add.w  a6, d2
000FC4  movem.w d0-d2, (a3)
000FC8  lea.l  $c(a3), a3
000FCC  dbra   d7, $f82
000FD0  rts    
000FD2  movea.l $20(a0), a2
000FD6  move.w $10(a2), d7
000FDA  lea.l  $10cc.l, a1
000FE0  lea.l  $543ac.l, a2
000FE6  move.w #$80, d3
000FEA  move.w #$80, d4
000FEE  move.w #$100, d5
000FF2  move.w #$4000, d6
000FF6  bra.b  $103e
000FF8  movem.w $6(a2), d0-d2
000FFE  cmp.w  d5, d2
001000  blt.b  $1044
001002  cmp.w  d6, d2
001004  bcc.b  $104c
001006  add.w  d2, d2
001008  move.w (a1, d2.w), d2
00100C  muls.w d2, d0
00100E  muls.w d2, d1
001010  add.l  d0, d0
001012  swap   d0
001014  add.l  d1, d1
001016  swap   d1
001018  moveq  #$0, d2
00101A  add.w  d4, d1
00101C  bpl.b  $1020
00101E  addq.w #$8, d2
001020  cmp.w  #$ff, d1
001024  ble.b  $1028
001026  addq.w #$4, d2
001028  add.w  d3, d0
00102A  bpl.b  $102e
00102C  addq.w #$2, d2
00102E  cmp.w  #$ff, d0
001032  ble.b  $1036
001034  addq.w #$1, d2
001036  movem.w d0-d2, (a2)
00103A  lea.l  $c(a2), a2
00103E  dbra   d7, $ff8
001042  rts    
001044  move.w #$ffff, $4(a2)
00104A  bra.b  $103a
00104C  lsl.l  #$8, d0
00104E  lsl.l  #$8, d1
001050  divs.w d2, d0
001052  divs.w d2, d1
001054  bra.b  $1018
001056  ori.b  #$c9, d0
00105A  bclr.b d0, (a2)
00105C  andi.w #$324, (a3)+
001060  bset.b d1, $4b6(a5)
001064  ; data: 0x05, 0x7f
001066  addi.w #$710, d7
00106A  bset.b d3, (a1)+
00106C  ; data: 0x08, 0xa2
00106E  bchg.b d4, $a33(a2)
001072  ; data: 0x0a, 0xfb
001074  bset.b d5, d3
001076  ; data: 0x0c, 0x8b
001078  bchg.b d6, (a3)
00107A  ; data: 0x0e, 0x1b
00107C  ; data: 0x0e, 0xe3
00107E  bclr.b d7, $1072(a3)
001082  move.b $120112c8.l, -(a0)
001088  ; data: 0x13, 0x8e
00108A  ; data: 0x14, 0x55
00108C  move.b (a3)+, -(a2)
00108E  ; data: 0x15, 0xe2
001090  move.b $176d(a0), (a3)
001094  move.b -$8(a3, d1.l), d4
001098  ; data: 0x19, 0xbd
00109A  move.b d2, (a5)
00109C  move.b d7, $1c0b(a5)
0010A0  ; data: 0x1c, 0xcf
0010A2  move.b (a3), $56(a6, d1.l)
0010A6  move.b (a1)+, -(a7)
0010A8  ; data: 0x1f, 0xdc
0010AA  move.l (a7)+, (a0)
0010AC  move.l -(a1), $2223(a0)
0010B0  move.l -(a5), (a1)+
0010B2  move.l -(a6), $67(a1, d2.w)
0010B6  move.l $25e8(a0), -(a2)
0010BA  move.l $2767(a0), (a3)
0010BE  move.l -(a6), d4
0010C0  move.l -(a5), (a4)+
0010C2  move.l -(a3), $61(a4, d2.l)
0010C6  move.l (a7)+, -(a5)
0010C8  ; data: 0x2b, 0xdc
0010CA  move.l (a0)+, (a6)
0010CC  move.l (a5), $2e11(a6)
0010D0  move.l a4, (a7)+
0010D2  move.l d7, $41(a7, d3.w)
0010D6  move.w ([$326e43fe], d3.w), (a0)+
0010DE  move.w (a6)+, $3496354d.l
0010E4  move.w d4, d3
0010E6  move.w $4857(pc), (a3)
0010EA  move.w -(a4), d4
0010EC  move.w (a0)+, (a4)+
0010EE  move.w a4, $40(a4, d3.l)
0010F2  move.w ([$3c56], d3.l * 2), (a5)+
0010F8  move.w d7, -(a6)
0010FA  move.w $3e68.w, ([a6], d3.l * 8, $3fc54073)
001104  dc.w   $4121
001106  ; data: 0x41, 0xce
001108  ; data: 0x42, 0x7a
00110A  dc.w   $4325
00110C  lea.l  (a0), a1
00110E  ; data: 0x44, 0x7a
001110  dc.w   $4524
001112  ; data: 0x45, 0xcd
001114  not.w  (a5, d4.w * 8)
001118  ; data: 0x47, 0xc3
00111A  pea.l  $490f(a1)
00111E  chk.w  $58(a4, d4.l), d4
001122  ; data: 0x4a, 0xfb
001124  chk.w  (a6)+, d5
001126  ; data: 0x4c, 0x3f
001128  ; data: 0x4c, 0xe1
00112A  chk.w  d1, d6
00112C  ; data: 0x4e, 0x21
00112E  ; data: 0x4e, 0xbf
001130  ; data: 0x4f, 0x5e
001132  lea.l  $10cb(pc, d5.w), a7
001136  subq.b #$8, ([])
00113A  addq.w #$1, $5302(a1)
00113E  subq.l #$1, (a3)+
001140  addq.b #$2, -$36(a3, d5.w)
001144  subq.w #$2, -(a0)
001146  scs.b  -$76(a5, d5.w)
00114A  subq.b #$3, (a5)+
00114C  subq.l #$3, $42(a0, d5.l)
001150  svc.b  (a4)
001152  subq.w #$4, -(a4)
001154  svs.b  -$7e(a3, d5.l)
001158  subq.b #$5, (a0)
00115A  subq.l #$5, (a5)+
00115C  addq.b #$6, $5cb4(a1)
001160  ; data: 0x5d, 0x3e
001162  slt.b  d7
001164  addq.w #$7, (a0)
001166  sgt.b  (a7)
001168  subq.w #$7, (a6)+
00116A  sle.b  -(a3)
00116C  bra.b  $11d6
00116E  bra.b  $115c
001170  bsr.b  $11e1
001172  bsr.b  $1165
001174  bhi.b  $11e7
001176  bhi.b  $116a
001178  bls.b  $11eb
00117A  bls.b  $116b
00117C  bcc.b  $11ea
00117E  bcc.b  $1168
001180  bcs.b  $11e5
001182  bcs.b  $1161
001184  bne.b  $11dd
001186  bne.b  $1157
001188  beq.b  $11d0
00118A  beq.b  $1149
00118C  bvc.b  $11c0
00118E  bvc.b  $1136
001190  bvs.b  $11ab
001192  bvs.b  $1120
001194  bvs.b  $1193
001196  bpl.b  $1205
001198  bpl.b  $1176
00119A  bmi.b  $11e6
00119C  bmi.b  $1156
00119E  bge.b  $11c4
0011A0  bge.b  $1131
0011A2  bge.b  $119d
0011A4  blt.b  $1208
0011A6  blt.b  $1172
0011A8  bgt.b  $11da
0011AA  bgt.b  $1142
0011AC  bgt.b  $11a9
0011AE  ble.b  $120f
0011B0  ble.b  $1173
0011B2  moveq  #$23, d0
0011B4  moveq  #$83, d0
0011B6  moveq  #$e2, d0
0011B8  ; data: 0x71, 0x41
0011BA  ; data: 0x71, 0x9e
0011BC  ; data: 0x71, 0xfa
0011BE  moveq  #$55, d1
0011C0  moveq  #$af, d1
0011C2  ; data: 0x73, 0x07
0011C4  ; data: 0x73, 0x5f
0011C6  ; data: 0x73, 0xb5
0011C8  moveq  #$b, d2
0011CA  moveq  #$5f, d2
0011CC  moveq  #$b2, d2
0011CE  ; data: 0x75, 0x04
0011D0  ; data: 0x75, 0x55
0011D2  ; data: 0x75, 0xa5
0011D4  ; data: 0x75, 0xf4
0011D6  moveq  #$41, d3
0011D8  moveq  #$8e, d3
0011DA  moveq  #$d9, d3
0011DC  ; data: 0x77, 0x23
0011DE  ; data: 0x77, 0x6c
0011E0  ; data: 0x77, 0xb4
0011E2  ; data: 0x77, 0xfa
0011E4  moveq  #$40, d4
0011E6  moveq  #$84, d4
0011E8  moveq  #$c7, d4
0011EA  ; data: 0x79, 0x09
0011EC  ; data: 0x79, 0x4a
0011EE  ; data: 0x79, 0x8a
0011F0  ; data: 0x79, 0xc8
0011F2  moveq  #$5, d5
0011F4  moveq  #$42, d5
0011F6  moveq  #$7d, d5
0011F8  moveq  #$b6, d5
0011FA  moveq  #$ef, d5
0011FC  ; data: 0x7b, 0x26
0011FE  ; data: 0x7b, 0x5d
001200  ; data: 0x7b, 0x92
001202  ; data: 0x7b, 0xc5
001204  ; data: 0x7b, 0xf8
001206  moveq  #$29, d6
001208  moveq  #$5a, d6
00120A  moveq  #$89, d6
00120C  moveq  #$b7, d6
00120E  moveq  #$e3, d6
001210  ; data: 0x7d, 0x0f
001212  ; data: 0x7d, 0x39
001214  ; data: 0x7d, 0x62
001216  ; data: 0x7d, 0x8a
001218  ; data: 0x7d, 0xb0
00121A  ; data: 0x7d, 0xd6
00121C  ; data: 0x7d, 0xfa
00121E  moveq  #$1d, d7
001220  moveq  #$3f, d7
001222  moveq  #$5f, d7
001224  moveq  #$7f, d7
001226  moveq  #$9d, d7
001228  moveq  #$ba, d7
00122A  moveq  #$d5, d7
00122C  moveq  #$f0, d7
00122E  ; data: 0x7f, 0x09
001230  ; data: 0x7f, 0x21
001232  ; data: 0x7f, 0x38
001234  ; data: 0x7f, 0x4d
001236  ; data: 0x7f, 0x62
001238  ; data: 0x7f, 0x75
00123A  ; data: 0x7f, 0x87
00123C  ; data: 0x7f, 0x97
00123E  ; data: 0x7f, 0xa7
001240  ; data: 0x7f, 0xb5
001242  ; data: 0x7f, 0xc2
001244  ; data: 0x7f, 0xce
001246  ; data: 0x7f, 0xd8
001248  ; data: 0x7f, 0xe1
00124A  ; data: 0x7f, 0xe9
00124C  ; data: 0x7f, 0xf0
00124E  ; data: 0x7f, 0xf6
001250  ; data: 0x7f, 0xfa
001252  ; data: 0x7f, 0xfd
001254  ; data: 0x7f, 0xfe
001256  ; data: 0x7f, 0xff
001258  ; data: 0x7f, 0xfe
00125A  ; data: 0x7f, 0xfd
00125C  ; data: 0x7f, 0xfa
00125E  ; data: 0x7f, 0xf6
001260  ; data: 0x7f, 0xf0
001262  ; data: 0x7f, 0xe9
001264  ; data: 0x7f, 0xe1
001266  ; data: 0x7f, 0xd8
001268  ; data: 0x7f, 0xce
00126A  ; data: 0x7f, 0xc2
00126C  ; data: 0x7f, 0xb5
00126E  ; data: 0x7f, 0xa7
001270  ; data: 0x7f, 0x97
001272  ; data: 0x7f, 0x87
001274  ; data: 0x7f, 0x75
001276  ; data: 0x7f, 0x62
001278  ; data: 0x7f, 0x4d
00127A  ; data: 0x7f, 0x38
00127C  ; data: 0x7f, 0x21
00127E  ; data: 0x7f, 0x09
001280  moveq  #$f0, d7
001282  moveq  #$d5, d7
001284  moveq  #$ba, d7
001286  moveq  #$9d, d7
001288  moveq  #$7f, d7
00128A  moveq  #$5f, d7
00128C  moveq  #$3f, d7
00128E  moveq  #$1d, d7
001290  ; data: 0x7d, 0xfa
001292  ; data: 0x7d, 0xd6
001294  ; data: 0x7d, 0xb0
001296  ; data: 0x7d, 0x8a
001298  ; data: 0x7d, 0x62
00129A  ; data: 0x7d, 0x39
00129C  ; data: 0x7d, 0x0f
00129E  moveq  #$e3, d6
0012A0  moveq  #$b7, d6
0012A2  moveq  #$89, d6
0012A4  moveq  #$5a, d6
0012A6  moveq  #$29, d6
0012A8  ; data: 0x7b, 0xf8
0012AA  ; data: 0x7b, 0xc5
0012AC  ; data: 0x7b, 0x92
0012AE  ; data: 0x7b, 0x5d
0012B0  ; data: 0x7b, 0x26
0012B2  moveq  #$ef, d5
0012B4  moveq  #$b6, d5
0012B6  moveq  #$7d, d5
0012B8  moveq  #$42, d5
0012BA  moveq  #$5, d5
0012BC  ; data: 0x79, 0xc8
0012BE  ; data: 0x79, 0x8a
0012C0  ; data: 0x79, 0x4a
0012C2  ; data: 0x79, 0x09
0012C4  moveq  #$c7, d4
0012C6  moveq  #$84, d4
0012C8  moveq  #$40, d4
0012CA  ; data: 0x77, 0xfa
0012CC  ; data: 0x77, 0xb4
0012CE  ; data: 0x77, 0x6c
0012D0  ; data: 0x77, 0x23
0012D2  moveq  #$d9, d3
0012D4  moveq  #$8e, d3
0012D6  moveq  #$41, d3
0012D8  ; data: 0x75, 0xf4
0012DA  ; data: 0x75, 0xa5
0012DC  ; data: 0x75, 0x55
0012DE  ; data: 0x75, 0x04
0012E0  moveq  #$b2, d2
0012E2  moveq  #$5f, d2
0012E4  moveq  #$b, d2
0012E6  ; data: 0x73, 0xb5
0012E8  ; data: 0x73, 0x5f
0012EA  ; data: 0x73, 0x07
0012EC  moveq  #$af, d1
0012EE  moveq  #$55, d1
0012F0  ; data: 0x71, 0xfa
0012F2  ; data: 0x71, 0x9e
0012F4  ; data: 0x71, 0x41
0012F6  moveq  #$e2, d0
0012F8  moveq  #$83, d0
0012FA  moveq  #$23, d0
0012FC  ble.b  $12bf
0012FE  ble.b  $135f
001300  bgt.b  $12fd
001302  bgt.b  $129a
001304  bgt.b  $1336
001306  blt.b  $12d2
001308  blt.b  $136c
00130A  bge.b  $1305
00130C  bge.b  $129d
00130E  bge.b  $1334
001310  bmi.b  $12ca
001312  bmi.b  $135e
001314  bpl.b  $12f2
001316  bpl.b  $1385
001318  bvs.b  $1317
00131A  bvs.b  $12a8
00131C  bvs.b  $1337
00131E  bvc.b  $12c6
001320  bvc.b  $1354
001322  beq.b  $12e1
001324  beq.b  $136c
001326  bne.b  $12f7
001328  bne.b  $1381
00132A  bcs.b  $1309
00132C  bcs.b  $1391
00132E  bcc.b  $1318
001330  bcc.b  $139e
001332  bls.b  $1323
001334  bls.b  $13a7
001336  bhi.b  $132a
001338  bhi.b  $13ab
00133A  bsr.b  $132d
00133C  bsr.b  $13ad
00133E  bra.b  $132c
001340  bra.b  $13aa
001342  sle.b  -(a3)
001344  subq.w #$7, (a6)+
001346  sgt.b  (a7)
001348  addq.w #$7, (a0)
00134A  slt.b  d7
00134C  ; data: 0x5d, 0x3e
00134E  addq.l #$6, $29(a4, d5.l)
001352  subq.l #$5, (a5)+
001354  subq.b #$5, (a0)
001356  addq.l #$5, d2
001358  svs.b  $58d4(a3, invalid.w)
00135E  addq.w #$4, d2
001360  subq.l #$3, ([a0], d5.w * 8)
001364  addq.l #$3, a2
001366  scs.b  $54ca(a5, invalid.w)
00136C  addq.b #$2, ([, d5.w * 2], $53025269)
001374  dbra   d6, $64a9
001378  addq.l #$8, (a7)
00137A  lea.l  ([$137cpc]), a7
00137E  ; data: 0x4e, 0xbf
001380  ; data: 0x4e, 0x21
001382  chk.w  d1, d6
001384  ; data: 0x4c, 0xe1
001386  ; data: 0x4c, 0x3f
001388  chk.w  (a6)+, d5
00138A  ; data: 0x4a, 0xfb
00138C  tst.w  (a0)+
00138E  chk.w  ([a4], d4.l, $486947c3), d4
001396  dc.w   $471c
001398  not.w  ([])
00139C  dc.w   $4524
00139E  ; data: 0x44, 0x7a
0013A0  lea.l  (a0), a1
0013A2  dc.w   $4325
0013A4  ; data: 0x42, 0x7a
0013A6  ; data: 0x41, 0xce
0013A8  dc.w   $4121
0013AA  negx.w ([])
0013AE  move.w (a7), -(a7)
0013B0  movea.w $3db8(a0), a7
0013B4  move.w d7, -(a6)
0013B6  movea.w (a6), a6
0013B8  move.w -(a5), -$e(a5, d3.l)
0013BC  movea.w d0, a5
0013BE  move.w a4, -$28(a4, d3.l)
0013C2  move.w -(a4), d4
0013C4  move.w $36ba(a7), $3604(a3)
0013CA  move.w a5, $3496(a2)
0013CE  move.w (a6)+, $3326326e.l
0013D4  move.w -$5(a5, d3.w), $41(a0, d3.w)
0013DA  move.l d7, -$34(a7, d2.l)
0013DE  move.l (a1), d7
0013E0  move.l (a5), $2c98(a6)
0013E4  ; data: 0x2b, 0xdc
0013E6  move.l (a7)+, -(a5)
0013E8  movea.l -(a1), a5
0013EA  move.l -(a3), -$1b(a4, d2.l)
0013EE  move.l -(a6), d4
0013F0  move.l -(a7), $26a8(a3)
0013F4  ; data: 0x25, 0xe8
0013F6  move.l $2467(a0), -(a2)
0013FA  move.l -(a6), -$1b(a1, d2.w)
0013FE  move.l -(a3), d1
001400  move.l -(a1), $209f(a0)
001404  ; data: 0x1f, 0xdc
001406  move.b (a1)+, -(a7)
001408  ; data: 0x1e, 0x56
00140A  move.b (a3), -$31(a6, d1.l)
00140E  ; data: 0x1c, 0x0b
001410  move.b d7, $1a82(a5)
001414  ; data: 0x19, 0xbd
001416  move.b $1833.w, (a4)+
00141A  move.b $16a8(a5), $15e2(a3)
001420  move.b (a3)+, -(a2)
001422  ; data: 0x14, 0x55
001424  ; data: 0x13, 0x8e
001426  ; data: 0x12, 0xc8
001428  move.b d1, d1
00142A  move.b $10720fab.l, -(a0)
001430  ; data: 0x0e, 0xe3
001432  ; data: 0x0e, 0x1b
001434  bchg.b d6, (a3)
001436  ; data: 0x0c, 0x8b
001438  bset.b d5, d3
00143A  ; data: 0x0a, 0xfb
00143C  eori.b #$6a, -$5e(a3, d0.l)
001442  bset.b d3, (a1)+
001444  btst.l d3, (a0)
001446  addi.w #$57f, d7
00144A  subi.l #$3ed0324, $5b(a6, d0.w)
001452  bclr.b d0, (a2)
001454  ; data: 0x00, 0xc9
001456  ori.b  #$37, d0
00145A  dc.w   $fe6e
00145C  ; data: 0xfd, 0xa5
00145E  dc.w   $fcdc
001460  dc.w   $fc13
001462  ; data: 0xfb, 0x4a
001464  dc.w   $fa81
001466  ; data: 0xf9, 0xb9
001468  dc.w   $f8f0
00146A  dc.w   $f827
00146C  dc.w   $f75e
00146E  dc.w   $f696
001470  ; data: 0xf5, 0xcd
001472  ; data: 0xf5, 0x05
001474  dc.w   $f43d
001476  dc.w   $f375
001478  dc.w   $f2ad
00147A  ; data: 0xf1, 0xe5
00147C  ; data: 0xf1, 0x1d
00147E  dc.w   $f055
001480  lsl.l  #$7, d6
001482  ; data: 0xee, 0xc7
001484  ; data: 0xed, 0xff
001486  rol.b  d6, d0
001488  roxr.w d6, d2
00148A  lsl.l  d5, d3
00148C  ; data: 0xea, 0xe5
00148E  ror.b  #$5, d6
001490  rol.w  #$4, d0
001492  roxr.l #$4, d3
001494  ; data: 0xe7, 0xcd
001496  lsl.b  #$3, d0
001498  asr.w  #$3, d3
00149A  rol.w  d2, d6
00149C  ror.l  d2, d1
00149E  lsl.w  ([$e26de1aa, a5, a6.w * 2])
0014A6  asr.w  -(a7)
0014A8  asr.b  d0, d4
0014AA  add.w  d7, -(a1)
0014AC  add.l  (a7)+, d7
0014AE  adda.l (a5)+, a6
0014B0  add.b  d6, (a3)+
0014B2  add.w  (a2)+, d6
0014B4  add.l  d5, (a1)+
0014B6  adda.w (a0)+, a5
0014B8  add.b  (a0)+, d5
0014BA  add.w  d4, (a0)+
0014BC  add.l  (a1)+, d4
0014BE  adda.l (a2)+, a3
0014C0  add.b  d3, (a3)+
0014C2  add.w  (a5)+, d3
0014C4  add.l  d2, (a7)+
0014C6  adda.w -(a1), a2
0014C8  add.b  -(a4), d2
0014CA  add.w  d1, -$2d55(a0)
0014CE  adda.l -$2ecc(a7), a0
0014D2  add.w  $cfbfcf05.l, d0
0014D8  ; data: 0xce, 0x4b
0014DA  and.l  d6, (a2)
0014DC  mulu.w (a2)+, d6
0014DE  and.b  -(a2), d6
0014E0  and.w  d5, -$354d(a2)
0014E4  muls.w #$c946, d4
0014E8  and.l  (a1), d4
0014EA  muls.w (a4)+, d3
0014EC  and.b  d3, -$398c(a0)
0014F0  muls.w d0, d2
0014F2  abcd.b -(a6), -(a2)
0014F4  and.w  (a3)+, d2
0014F6  and.l  d1, -$3d07(a2)
0014FA  ; data: 0xc2, 0x48
0014FC  and.l  d0, (a0)+
0014FE  mulu.w -$3fc5(a1), d0
001502  cmpm.l (a5)+, (a7)+
001504  cmpa.w (a7)+, a7
001506  cmp.b  ([], a3.l * 4, $bcdb), d7
00150C  cmp.b  ([], a3.l * 2, $badc), d6
001512  cmp.b  ([, a3.l], $b8e4b83d), d5
00151A  eor.l  d3, (a7)
00151C  cmpa.w $4c(a1, a3.w), a3
001520  eor.l  d2, -$4afb(a0)
001524  cmp.w  -(a2), d2
001526  cmpa.l d1, a1
001528  eor.b  d1, (a7)+
00152A  ; data: 0xb2, 0x7f
00152C  cmpa.l (a7)+, a0
00152E  eor.w  d0, d1
001530  cmp.l  -(a2), d0
001532  cmp.b  d5, d0
001534  ; data: 0xaf, 0x69
001536  ; data: 0xae, 0xcd
001538  ; data: 0xae, 0x32
00153A  ; data: 0xad, 0x97
00153C  ; data: 0xac, 0xfe
00153E  ; data: 0xac, 0x65
001540  ; data: 0xab, 0xcd
001542  ; data: 0xab, 0x36
001544  ; data: 0xaa, 0xa0
001546  ; data: 0xaa, 0x0b
001548  ; data: 0xa9, 0x76
00154A  ; data: 0xa8, 0xe3
00154C  ; data: 0xa8, 0x50
00154E  ; data: 0xa7, 0xbe
001550  ; data: 0xa7, 0x2c
001552  ; data: 0xa6, 0x9c
001554  ; data: 0xa6, 0x0d
001556  ; data: 0xa5, 0x7e
001558  ; data: 0xa4, 0xf0
00155A  ; data: 0xa4, 0x63
00155C  ; data: 0xa3, 0xd7
00155E  ; data: 0xa3, 0x4c
001560  ; data: 0xa2, 0xc2
001562  ; data: 0xa2, 0x39
001564  ; data: 0xa1, 0xb0
001566  ; data: 0xa1, 0x29
001568  ; data: 0xa0, 0xa2
00156A  ; data: 0xa0, 0x1d
00156C  sub.l  d7, (a0)+
00156E  sub.b  d7, (a4)
001570  sub.l  (a1), d7
001572  ; data: 0x9e, 0x0f
001574  subx.l -(a7), -(a6)
001576  subx.b -(a6), -(a6)
001578  sub.l  a7, d6
00157A  sub.b  (a1), d6
00157C  sub.l  d5, (a4)
00157E  sub.b  d5, (a0)+
001580  sub.l  (a5)+, d5
001582  sub.b  -(a3), d5
001584  sub.l  d4, -$66cf(a1)
001588  sub.l  $ffffadcd(pc), d4
00158C  suba.l a6, a3
00158E  sub.w  d3, (a2)+
001590  suba.w -(a7), a3
001592  sub.w  $3(a4, a1.w), d3
001596  sub.l  d2, (a3)
001598  sub.b  d2, -(a4)
00159A  sub.l  $48(a6, a1.w), d2
00159E  suba.l (a4)+, a1
0015A0  sub.w  d1, ([a1], a1.w * 2, $929e9236)
0015A8  suba.l (a0), a0
0015AA  sub.w  d0, -$6efb(a2)
0015AE  sub.l  -(a1), d0
0015B0  ; data: 0x90, 0x3f
0015B2  divs.w (a5)+, d7
0015B4  ; data: 0x8f, 0x7d
0015B6  or.b   d7, (a6)+
0015B8  ; data: 0x8e, 0xbf
0015BA  or.w   -(a2), d7
0015BC  or.b   d6, d7
0015BE  or.l   d6, -$72af(a3)
0015C2  divu.w $8ca18c4b.l, d6
0015C8  divs.w ([$8b4e, a0.l * 2]), d5
0015CE  divu.w #$8aab, d5
0015D2  or.w   (a3)+, d5
0015D4  ; data: 0x8a, 0x0c
0015D6  ; data: 0x89, 0xbf
0015D8  or.w   d4, ([$88dd, a2], a0.l, $8894884c)
0015E2  or.b   d6, d4
0015E4  divs.w d0, d3
0015E6  ; data: 0x87, 0x7c
0015E8  or.b   d3, $86f786b6.l
0015EE  or.w   $38(a6, a0.w), d3
0015F2  divs.w ([$85839b3e], a0.w * 4, $8511), d2
0015FC  divu.w (a2)+, d2
0015FE  or.l   -(a3), d2
001600  or.w   -$7bc5(a6), d2
001604  ; data: 0x84, 0x08
001606  divs.w (a7), d1
001608  or.l   d1, -(a6)
00160A  or.w   d1, ([a7])
00160E  or.b   d1, (a5)+
001610  divu.w -$39(a1, a0.w), d1
001614  or.l   (a6)+, d1
001616  or.w   $50(a6, a0.w), d1
00161A  or.b   -$7dfa(a2), d1
00161E  divs.w -(a3), d0
001620  divs.w d1, d0
001622  or.l   d0, -(a1)
001624  dc.w   $8181
001626  or.w   d0, -(a3)
001628  dc.w   $8146
00162A  or.b   d0, -$7ef0(a3)
00162E  divu.w -$21(a7, a0.w), d0
001632  ; data: 0x80, 0xc8
001634  or.l   -$62(a3, a0.w), d0
001638  ; data: 0x80, 0x8b
00163A  or.w   $80698059.l, d0
001640  ; data: 0x80, 0x4b
001642  ; data: 0x80, 0x3e
001644  or.b   $28(a2, a0.w), d0
001648  or.b   (a7)+, d0
00164A  or.b   (a7), d0
00164C  or.b   (a0), d0
00164E  ; data: 0x80, 0x0a
001650  or.b   d6, d0
001652  or.b   d3, d0
001654  or.b   d2, d0
001656  or.b   d1, d0
001658  or.b   d2, d0
00165A  or.b   d3, d0
00165C  or.b   d6, d0
00165E  ; data: 0x80, 0x0a
001660  or.b   (a0), d0
001662  or.b   (a7), d0
001664  or.b   (a7)+, d0
001666  or.b   -$7fce(a0), d0
00166A  ; data: 0x80, 0x3e
00166C  ; data: 0x80, 0x4b
00166E  or.w   (a1)+, d0
001670  or.w   -$7f87(a1), d0
001674  ; data: 0x80, 0x8b
001676  or.l   (a6)+, d0
001678  or.l   -$38(a3, a0.w), d0
00167C  divu.w (a7)+, d0
00167E  divu.w (a7, a0.w), d0
001682  or.b   d0, -$7eba(a3)
001686  or.w   d0, -(a3)
001688  dc.w   $8181
00168A  or.l   d0, -(a1)
00168C  divs.w d1, d0
00168E  divs.w -(a3), d0
001690  or.b   d6, d1
001692  or.b   -$7db0(a2), d1
001696  or.w   -$62(a6, a0.w), d1
00169A  divu.w d7, d1
00169C  divu.w ([a1], a0.w * 2), d1
0016A0  dc.w   $8349
0016A2  or.w   d1, ([$83d7], a0.w * 2, $8408)
0016AA  or.b   $171a(pc, a0.w), d2
0016AE  or.l   -(a3), d2
0016B0  divu.w (a2)+, d2
0016B2  or.b   d2, (a1)
0016B4  dc.w   $854a
0016B6  dc.w   $8583
0016B8  ; data: 0x85, 0xbe
0016BA  divs.w $16f4(pc, a0.w), d2
0016BE  or.w   -$4a(a6, a0.w), d3
0016C2  divu.w ([$877c87c0, a7, a0.w * 8]), d3
0016CA  or.b   d6, d4
0016CC  ; data: 0x88, 0x4c
0016CE  or.l   (a4), d4
0016D0  divu.w (a5)+, d4
0016D2  or.b   d4, -(a7)
0016D4  or.w   d4, ([$8a0c8a5b], a0.l, $8aab8afc)
0016E0  dc.w   $8b4e
0016E2  or.l   d5, -(a1)
0016E4  divs.w $4b(a5, a0.l), d5
0016E8  or.l   -(a1), d6
0016EA  divu.w $8d518dab.l, d6
0016F0  or.b   d6, d7
0016F2  or.w   -(a2), d7
0016F4  ; data: 0x8e, 0xbf
0016F6  or.b   d7, (a6)+
0016F8  ; data: 0x8f, 0x7d
0016FA  divs.w (a5)+, d7
0016FC  ; data: 0x90, 0x3f
0016FE  sub.l  -(a1), d0
001700  subx.b d5, d0
001702  sub.w  d0, -$6e30(a2)
001706  sub.b  -$62(a6, a1.w), d1
00170A  subx.b d7, d1
00170C  sub.w  d1, (invalid.w)
001710  sub.w  a0, d2
001712  sub.l  $9593(a6, a1.w * 4), d2
001718  sub.b  d3, d3
00171A  sub.w  -$19(a4, a1.w), d3
00171E  sub.w  d3, (a2)+
001720  suba.l a6, a3
001722  sub.w  d3, d4
001724  sub.l  $ffffb057(pc), d4
001728  sub.l  d4, -$65dd(a1)
00172C  sub.l  (a5)+, d5
00172E  sub.b  d5, (a0)+
001730  sub.l  d5, (a4)
001732  sub.b  (a1), d6
001734  sub.l  a7, d6
001736  subx.b -(a6), -(a6)
001738  subx.l -(a7), -(a6)
00173A  ; data: 0x9e, 0x0f
00173C  sub.l  (a1), d7
00173E  sub.b  d7, (a4)
001740  sub.l  d7, (a0)+
001742  ; data: 0xa0, 0x1d
001744  ; data: 0xa0, 0xa2
001746  ; data: 0xa1, 0x29
001748  ; data: 0xa1, 0xb0
00174A  ; data: 0xa2, 0x39
00174C  ; data: 0xa2, 0xc2
00174E  ; data: 0xa3, 0x4c
001750  ; data: 0xa3, 0xd7
001752  ; data: 0xa4, 0x63
001754  ; data: 0xa4, 0xf0
001756  ; data: 0xa5, 0x7e
001758  ; data: 0xa6, 0x0d
00175A  ; data: 0xa6, 0x9c
00175C  ; data: 0xa7, 0x2c
00175E  ; data: 0xa7, 0xbe
001760  ; data: 0xa8, 0x50
001762  ; data: 0xa8, 0xe3
001764  ; data: 0xa9, 0x76
001766  ; data: 0xaa, 0x0b
001768  ; data: 0xaa, 0xa0
00176A  ; data: 0xab, 0x36
00176C  ; data: 0xab, 0xcd
00176E  ; data: 0xac, 0x65
001770  ; data: 0xac, 0xfe
001772  ; data: 0xad, 0x97
001774  ; data: 0xae, 0x32
001776  ; data: 0xae, 0xcd
001778  ; data: 0xaf, 0x69
00177A  cmp.b  d5, d0
00177C  cmp.l  -(a2), d0
00177E  eor.w  d0, d1
001780  cmpa.l (a7)+, a0
001782  ; data: 0xb2, 0x7f
001784  eor.b  d1, (a7)+
001786  cmpa.l d1, a1
001788  cmp.w  -(a2), d2
00178A  eor.b  d2, d5
00178C  eor.l  d2, -$49b4(a0)
001790  cmpa.w ([], a3.w * 8, $b83db8e4), a3
001798  cmpm.l (a3)+, (a4)+
00179A  cmp.b  -$24(a3, a3.l), d5
00179E  eor.l  d5, d6
0017A0  cmp.b  -$25(a0, a3.l), d6
0017A4  eor.l  d6, d6
0017A6  cmp.b  -$21(a2, a3.l), d7
0017AA  cmpm.l (a5)+, (a7)+
0017AC  and.b  $1797(pc, a4.w), d0
0017B0  and.l  d0, (a0)+
0017B2  ; data: 0xc2, 0x48
0017B4  mulu.w $c3aac45b.l, d1
0017BA  abcd.b -(a6), -(a2)
0017BC  muls.w d0, d2
0017BE  and.w  $c7dc(a4, a4.w * 8), d3
0017C4  and.l  (a1), d4
0017C6  exg.l  d4, d6
0017C8  muls.w #$cab3, d4
0017CC  and.w  d5, -$33de(a2)
0017D0  mulu.w (a2)+, d6
0017D2  and.l  d6, (a2)
0017D4  ; data: 0xce, 0x4b
0017D6  abcd.b d5, d7
0017D8  ; data: 0xcf, 0xbf
0017DA  add.w  $d134d1ef.l, d0
0017E0  add.l  -$2c98(a3), d1
0017E4  add.b  -(a4), d2
0017E6  adda.w -(a1), a2
0017E8  add.l  d2, (a7)+
0017EA  add.w  (a5)+, d3
0017EC  add.b  d3, (a3)+
0017EE  adda.l (a2)+, a3
0017F0  add.l  (a1)+, d4
0017F2  add.w  d4, (a0)+
0017F4  add.b  (a0)+, d5
0017F6  adda.w (a0)+, a5
0017F8  add.l  d5, (a1)+
0017FA  add.w  (a2)+, d6
0017FC  add.b  d6, (a3)+
0017FE  adda.l (a5)+, a6
001800  add.l  (a7)+, d7
001802  add.w  d7, -(a1)
001804  asr.b  d0, d4
001806  asr.w  -(a7)
001808  lsl.l  d0, d2
00180A  lsr.w  d1, d5
00180C  roxl.b d1, d1
00180E  lsl.w  -$47(a5, a6.w)
001812  rol.w  d2, d6
001814  asr.w  #$3, d3
001816  lsl.b  #$3, d0
001818  ; data: 0xe7, 0xcd
00181A  roxr.l #$4, d3
00181C  rol.w  #$4, d0
00181E  ror.b  #$5, d6
001820  ; data: 0xea, 0xe5
001822  lsl.l  d5, d3
001824  roxr.w d6, d2
001826  rol.b  d6, d0
001828  ; data: 0xed, 0xff
00182A  ; data: 0xee, 0xc7
00182C  lsl.l  #$7, d6
00182E  dc.w   $f055
001830  ; data: 0xf1, 0x1d
001832  ; data: 0xf1, 0xe5
001834  dc.w   $f2ad
001836  dc.w   $f375
001838  dc.w   $f43d
00183A  ; data: 0xf5, 0x05
00183C  ; data: 0xf5, 0xcd
00183E  dc.w   $f696
001840  dc.w   $f75e
001842  dc.w   $f827
001844  dc.w   $f8f0
001846  ; data: 0xf9, 0xb9
001848  dc.w   $fa81
00184A  ; data: 0xfb, 0x4a
00184C  dc.w   $fc13
00184E  dc.w   $fcdc
001850  ; data: 0xfd, 0xa5
001852  dc.w   $fe6e
001854  dc.w   $ff37
001856  ori.b  #$c9, d0
00185A  bclr.b d0, (a2)
00185C  andi.w #$324, (a3)+
001860  bset.b d1, $4b6(a5)
001864  ; data: 0x05, 0x7f
001866  addi.w #$710, d7
00186A  bset.b d3, (a1)+
00186C  ; data: 0x08, 0xa2
00186E  bchg.b d4, $a33(a2)
001872  ; data: 0x0a, 0xfb
001874  bset.b d5, d3
001876  ; data: 0x0c, 0x8b
001878  bchg.b d6, (a3)
00187A  ; data: 0x0e, 0x1b
00187C  ; data: 0x0e, 0xe3
00187E  bclr.b d7, $1072(a3)
001882  move.b $120112c8.l, -(a0)
001888  ; data: 0x13, 0x8e
00188A  ; data: 0x14, 0x55
00188C  move.b (a3)+, -(a2)
00188E  ; data: 0x15, 0xe2
001890  move.b $176d(a0), (a3)
001894  move.b -$8(a3, d1.l), d4
001898  ; data: 0x19, 0xbd
00189A  move.b d2, (a5)
00189C  move.b d7, $1c0b(a5)
0018A0  ; data: 0x1c, 0xcf
0018A2  move.b (a3), $56(a6, d1.l)
0018A6  move.b (a1)+, -(a7)
0018A8  ; data: 0x1f, 0xdc
0018AA  move.l (a7)+, (a0)
0018AC  move.l -(a1), $2223(a0)
0018B0  move.l -(a5), (a1)+
0018B2  move.l -(a6), $67(a1, d2.w)
0018B6  move.l $25e8(a0), -(a2)
0018BA  move.l $2767(a0), (a3)
0018BE  move.l -(a6), d4
0018C0  move.l -(a5), (a4)+
0018C2  move.l -(a3), $61(a4, d2.l)
0018C6  move.l (a7)+, -(a5)
0018C8  ; data: 0x2b, 0xdc
0018CA  move.l (a0)+, (a6)
0018CC  move.l (a5), $2e11(a6)
0018D0  move.l a4, (a7)+
0018D2  move.l d7, $41(a7, d3.w)
0018D6  move.w ([$326e4bfe], d3.w), (a0)+
0018DE  move.w (a6)+, $3496354d.l
0018E4  move.w d4, d3
0018E6  move.w $5057(pc), (a3)
0018EA  move.w -(a4), d4
0018EC  move.w (a0)+, (a4)+
0018EE  move.w a4, $40(a4, d3.l)
0018F2  move.w ([$3c56], d3.l * 2), (a5)+
0018F8  move.w d7, -(a6)
0018FA  move.w $3e68.w, ([a6], d3.l * 8, $3fc54073)
001904  dc.w   $4121
001906  ; data: 0x41, 0xce
001908  ; data: 0x42, 0x7a
00190A  dc.w   $4325
00190C  lea.l  (a0), a1
00190E  ; data: 0x44, 0x7a
001910  dc.w   $4524
001912  ; data: 0x45, 0xcd
001914  not.w  (a5, d4.w * 8)
001918  ; data: 0x47, 0xc3
00191A  pea.l  $490f(a1)
00191E  chk.w  $58(a4, d4.l), d4
001922  ; data: 0x4a, 0xfb
001924  chk.w  (a6)+, d5
001926  ; data: 0x4c, 0x3f
001928  ; data: 0x4c, 0xe1
00192A  chk.w  d1, d6
00192C  ; data: 0x4e, 0x21
00192E  ; data: 0x4e, 0xbf
001930  ; data: 0x4f, 0x5e
001932  lea.l  $18cb(pc, d5.w), a7
001936  subq.b #$8, ([])
00193A  addq.w #$1, $5302(a1)
00193E  subq.l #$1, (a3)+
001940  addq.b #$2, -$36(a3, d5.w)
001944  subq.w #$2, -(a0)
001946  scs.b  -$76(a5, d5.w)
00194A  subq.b #$3, (a5)+
00194C  subq.l #$3, $42(a0, d5.l)
001950  svc.b  (a4)
001952  subq.w #$4, -(a4)
001954  svs.b  -$7e(a3, d5.l)
001958  subq.b #$5, (a0)
00195A  subq.l #$5, (a5)+
00195C  addq.b #$6, $5cb4(a1)
001960  ; data: 0x5d, 0x3e
001962  slt.b  d7
001964  addq.w #$7, (a0)
001966  sgt.b  (a7)
001968  subq.w #$7, (a6)+
00196A  sle.b  -(a3)
00196C  bra.b  $19d6
00196E  bra.b  $195c
001970  bsr.b  $19e1
001972  bsr.b  $1965
001974  bhi.b  $19e7
001976  bhi.b  $196a
001978  bls.b  $19eb
00197A  bls.b  $196b
00197C  bcc.b  $19ea
00197E  bcc.b  $1968
001980  bcs.b  $19e5
001982  bcs.b  $1961
001984  bne.b  $19dd
001986  bne.b  $1957
001988  beq.b  $19d0
00198A  beq.b  $1949
00198C  bvc.b  $19c0
00198E  bvc.b  $1936
001990  bvs.b  $19ab
001992  bvs.b  $1920
001994  bvs.b  $1993
001996  bpl.b  $1a05
001998  bpl.b  $1976
00199A  bmi.b  $19e6
00199C  bmi.b  $1956
00199E  bge.b  $19c4
0019A0  bge.b  $1931
0019A2  bge.b  $199d
0019A4  blt.b  $1a08
0019A6  blt.b  $1972
0019A8  bgt.b  $19da
0019AA  bgt.b  $1942
0019AC  bgt.b  $19a9
0019AE  ble.b  $1a0f
0019B0  ble.b  $1973
0019B2  moveq  #$23, d0
0019B4  moveq  #$83, d0
0019B6  moveq  #$e2, d0
0019B8  ; data: 0x71, 0x41
0019BA  ; data: 0x71, 0x9e
0019BC  ; data: 0x71, 0xfa
0019BE  moveq  #$55, d1
0019C0  moveq  #$af, d1
0019C2  ; data: 0x73, 0x07
0019C4  ; data: 0x73, 0x5f
0019C6  ; data: 0x73, 0xb5
0019C8  moveq  #$b, d2
0019CA  moveq  #$5f, d2
0019CC  moveq  #$b2, d2
0019CE  ; data: 0x75, 0x04
0019D0  ; data: 0x75, 0x55
0019D2  ; data: 0x75, 0xa5
0019D4  ; data: 0x75, 0xf4
0019D6  moveq  #$41, d3
0019D8  moveq  #$8e, d3
0019DA  moveq  #$d9, d3
0019DC  ; data: 0x77, 0x23
0019DE  ; data: 0x77, 0x6c
0019E0  ; data: 0x77, 0xb4
0019E2  ; data: 0x77, 0xfa
0019E4  moveq  #$40, d4
0019E6  moveq  #$84, d4
0019E8  moveq  #$c7, d4
0019EA  ; data: 0x79, 0x09
0019EC  ; data: 0x79, 0x4a
0019EE  ; data: 0x79, 0x8a
0019F0  ; data: 0x79, 0xc8
0019F2  moveq  #$5, d5
0019F4  moveq  #$42, d5
0019F6  moveq  #$7d, d5
0019F8  moveq  #$b6, d5
0019FA  moveq  #$ef, d5
0019FC  ; data: 0x7b, 0x26
0019FE  ; data: 0x7b, 0x5d
001A00  ; data: 0x7b, 0x92
001A02  ; data: 0x7b, 0xc5
001A04  ; data: 0x7b, 0xf8
001A06  moveq  #$29, d6
001A08  moveq  #$5a, d6
001A0A  moveq  #$89, d6
001A0C  moveq  #$b7, d6
001A0E  moveq  #$e3, d6
001A10  ; data: 0x7d, 0x0f
001A12  ; data: 0x7d, 0x39
001A14  ; data: 0x7d, 0x62
001A16  ; data: 0x7d, 0x8a
001A18  ; data: 0x7d, 0xb0
001A1A  ; data: 0x7d, 0xd6
001A1C  ; data: 0x7d, 0xfa
001A1E  moveq  #$1d, d7
001A20  moveq  #$3f, d7
001A22  moveq  #$5f, d7
001A24  moveq  #$7f, d7
001A26  moveq  #$9d, d7
001A28  moveq  #$ba, d7
001A2A  moveq  #$d5, d7
001A2C  moveq  #$f0, d7
001A2E  ; data: 0x7f, 0x09
001A30  ; data: 0x7f, 0x21
001A32  ; data: 0x7f, 0x38
001A34  ; data: 0x7f, 0x4d
001A36  ; data: 0x7f, 0x62
001A38  ; data: 0x7f, 0x75
001A3A  ; data: 0x7f, 0x87
001A3C  ; data: 0x7f, 0x97
001A3E  ; data: 0x7f, 0xa7
001A40  ; data: 0x7f, 0xb5
001A42  ; data: 0x7f, 0xc2
001A44  ; data: 0x7f, 0xce
001A46  ; data: 0x7f, 0xd8
001A48  ; data: 0x7f, 0xe1
001A4A  ; data: 0x7f, 0xe9
001A4C  ; data: 0x7f, 0xf0
001A4E  ; data: 0x7f, 0xf6
001A50  ; data: 0x7f, 0xfa
001A52  ; data: 0x7f, 0xfd
001A54  ; data: 0x7f, 0xfe
001A56  move.l #$90cc, $1a6c.l
001A60  move.l #$d0cc, $1a70.l
001A6A  rts    
001A6C  ori.b  #$0, d0
001A70  ori.b  #$0, d0
001A74  movea.l $20(a0), a0
001A78  move.w $12(a0), d7
001A7C  movea.l $4(a0), a0
001A80  bra.b  $1a90
001A82  move.l $4(a0), $8(a0)
001A88  move.w (a0), $2(a0)
001A8C  lea.l  $c(a0), a0
001A90  dbra   d7, $1a82
001A94  rts    
001A96  movea.l $20(a0), a0
001A9A  move.w $12(a0), d7
001A9E  movea.l $4(a0), a0
001AA2  movea.l $1a6c(pc), a3
001AA6  movea.l $1a70(pc), a4
001AAA  bra.w  $1bdc
001AAE  move.w (a0), d6
001AB0  movea.l $4(a0), a1
001AB4  subq.w #$1, d6
001AB6  moveq  #$0, d1
001AB8  moveq  #$ff, d2
001ABA  movea.l (a1)+, a2
001ABC  move.w $4(a2), d3
001AC0  and.w  d3, d2
001AC2  or.w   d3, d1
001AC4  dbra   d6, $1aba
001AC8  bmi.b  $1ae0
001ACA  lea.l  $c(a0), a0
001ACE  dbra   d7, $1aae
001AD2  move.l a3, $1a6c.l
001AD8  move.l a4, $1a70.l
001ADE  rts    
001AE0  tst.w  d2
001AE2  bpl.b  $1ae8
001AE4  clr.b  (a0)
001AE6  bra.b  $1aca
001AE8  move.w (a0), d6
001AEA  move.w d6, d4
001AEC  movea.l a3, a6
001AEE  movea.l $4(a0), a1
001AF2  movea.l (a1)+, a2
001AF4  move.w $a(a2), d2
001AF8  cmp.w  #$100, d2
001AFC  blt.w  $1bc6
001B00  bra.b  $1b66
001B02  movea.l a2, a5
001B04  movea.l (a1)+, a2
001B06  movem.w $6(a2), d0-d2
001B0C  cmp.w  #$100, d2
001B10  blt.b  $1b70
001B12  tst.w  d5
001B14  beq.b  $1b66
001B16  move.l a4, (a6)+
001B18  move.w $a(a5), d5
001B1C  sub.w  d5, d2
001B1E  neg.w  d5
001B20  add.w  #$100, d5
001B24  sub.w  $6(a5), d0
001B28  muls.w d5, d0
001B2A  divs.w d2, d0
001B2C  add.w  $6(a5), d0
001B30  sub.w  $8(a5), d1
001B34  muls.w d5, d1
001B36  divs.w d2, d1
001B38  add.w  $8(a5), d1
001B3C  moveq  #$0, d2
001B3E  add.w  #$80, d1
001B42  bpl.b  $1b46
001B44  addq.w #$8, d2
001B46  cmp.w  #$ff, d1
001B4A  ble.b  $1b4e
001B4C  addq.w #$4, d2
001B4E  add.w  #$80, d0
001B52  bpl.b  $1b56
001B54  addq.w #$2, d2
001B56  cmp.w  #$ff, d0
001B5A  ble.b  $1b5e
001B5C  addq.w #$1, d2
001B5E  move.w d0, (a4)+
001B60  move.w d1, (a4)+
001B62  move.w d2, (a4)+
001B64  addq.w #$1, d4
001B66  move.l a2, (a6)+
001B68  moveq  #$0, d5
001B6A  dbra   d6, $1b02
001B6E  bra.b  $1bce
001B70  tst.w  d5
001B72  bne.b  $1bc4
001B74  move.l a4, (a6)+
001B76  move.w $a(a5), d5
001B7A  sub.w  d5, d2
001B7C  neg.w  d5
001B7E  add.w  #$100, d5
001B82  sub.w  $6(a5), d0
001B86  muls.w d5, d0
001B88  divs.w d2, d0
001B8A  add.w  $6(a5), d0
001B8E  sub.w  $8(a5), d1
001B92  muls.w d5, d1
001B94  divs.w d2, d1
001B96  add.w  $8(a5), d1
001B9A  moveq  #$0, d2
001B9C  add.w  #$80, d1
001BA0  bpl.b  $1ba4
001BA2  addq.w #$8, d2
001BA4  cmp.w  #$ff, d1
001BA8  ble.b  $1bac
001BAA  addq.w #$4, d2
001BAC  add.w  #$80, d0
001BB0  bpl.b  $1bb4
001BB2  addq.w #$2, d2
001BB4  cmp.w  #$ff, d0
001BB8  ble.b  $1bbc
001BBA  addq.w #$1, d2
001BBC  move.w d0, (a4)+
001BBE  move.w d1, (a4)+
001BC0  move.w d2, (a4)+
001BC2  bra.b  $1bc6
001BC4  subq.w #$1, d4
001BC6  moveq  #$1, d5
001BC8  dbra   d6, $1b02
001BCC  move.l (a3), (a6)+
001BCE  move.w d4, $2(a0)
001BD2  move.l a3, $8(a0)
001BD6  movea.l a6, a3
001BD8  lea.l  $c(a0), a0
001BDC  dbra   d7, $1aae
001BE0  move.l a3, $1a6c.l
001BE6  move.l a4, $1a70.l
001BEC  rts    
001BEE  movea.l $20(a0), a0
001BF2  movea.l $c(a0), a1
001BF6  lea.l  $8(a1), a1
001BFA  move.w $16(a0), d0
001BFE  moveq  #$0, d1
001C00  bra.b  $1c08
001C02  move.b d1, (a1)
001C04  lea.l  $14(a1), a1
001C08  dbra   d0, $1c02
001C0C  movea.l $8(a0), a1
001C10  move.w $14(a0), d7
001C14  subq.w #$1, d7
001C16  movea.l (a1), a2
001C18  tst.w  (a2)
001C1A  beq.b  $1c46
001C1C  movea.l $8(a2), a2
001C20  movem.l (a2), a2-a4
001C24  movem.w (a3), d2-d3
001C28  movem.w (a2), d4-d5
001C2C  sub.w  d2, d4
001C2E  sub.w  d3, d5
001C30  sub.w  (a4)+, d2
001C32  sub.w  (a4)+, d3
001C34  muls.w d2, d5
001C36  muls.w d3, d4
001C38  cmp.l  d4, d5
001C3A  blt.b  $1c50
001C3C  movea.l $c(a1), a2
001C40  move.w $6(a1), d0
001C44  bne.b  $1c6a
001C46  lea.l  $10(a1), a1
001C4A  dbra   d7, $1c16
001C4E  rts    
001C50  movea.l $8(a1), a2
001C54  move.w $4(a1), d0
001C58  bne.b  $1c6a
001C5A  lea.l  $10(a1), a1
001C5E  dbra   d7, $1c16
001C62  rts    
001C64  movea.l (a2)+, a3
001C66  addq.b #$1, $8(a3)
001C6A  dbra   d0, $1c64
001C6E  lea.l  $10(a1), a1
001C72  dbra   d7, $1c16
001C76  rts    
001C78  movea.l $4(a1), a0
001C7C  movea.l $8(a0), a2
001C80  move.w $2(a0), d6
001C84  cmp.w  #$3, d6
001C88  bcs.b  $1ce4
001C8A  moveq  #$0, d0
001C8C  moveq  #$ff, d1
001C8E  subq.w #$1, d6
001C90  movea.l (a2)+, a3
001C92  move.w $4(a3), d5
001C96  or.w   d5, d0
001C98  and.w  d5, d1
001C9A  dbra   d6, $1c90
001C9E  tst.w  d1
001CA0  bne.b  $1ce4
001CA2  tst.w  d0
001CA4  beq.b  $1ce2
001CA6  movea.l $1a6c(pc), a3
001CAA  movea.l $1a70(pc), a4
001CAE  move.w d0, d7
001CB0  btst.b #$3, d7
001CB4  beq.b  $1cb8
001CB6  bsr.b  $1cea
001CB8  btst.b #$2, d7
001CBC  beq.b  $1cc2
001CBE  bsr.w  $1d58
001CC2  btst.b #$1, d7
001CC6  beq.b  $1ccc
001CC8  bsr.w  $1de0
001CCC  btst.b #$0, d7
001CD0  beq.b  $1cd6
001CD2  bsr.w  $1e4e
001CD6  move.l a3, $1a6c.l
001CDC  move.l a4, $1a70.l
001CE2  rts    
001CE4  clr.w  $2(a0)
001CE8  rts    
001CEA  movea.l $4(a1), a0
001CEE  move.w $2(a0), d6
001CF2  movea.l a3, a6
001CF4  movea.l $8(a0), a5
001CF8  move.l a3, $8(a0)
001CFC  movea.l (a5)+, a2
001CFE  movem.w (a2), d0-d1
001D02  bra.b  $1d4a
001D04  movea.l (a5)+, a2
001D06  movem.w (a2), d2-d3
001D0A  tst.w  d1
001D0C  bmi.b  $1d28
001D0E  tst.w  d3
001D10  bpl.b  $1d44
001D12  move.w d0, d4
001D14  sub.w  d2, d4
001D16  move.w d3, d5
001D18  sub.w  d1, d5
001D1A  muls.w d3, d4
001D1C  divs.w d5, d4
001D1E  add.w  d2, d4
001D20  move.l a4, (a3)+
001D22  move.w d4, (a4)+
001D24  clr.w  (a4)+
001D26  bra.b  $1d46
001D28  tst.w  d3
001D2A  bmi.b  $1d52
001D2C  move.w d2, d4
001D2E  move.w d1, d5
001D30  sub.w  d0, d4
001D32  sub.w  d3, d5
001D34  muls.w d1, d4
001D36  divs.w d5, d4
001D38  add.w  d0, d4
001D3A  move.l a4, (a3)+
001D3C  move.w d4, (a4)+
001D3E  clr.w  (a4)+
001D40  addq.w #$1, $2(a0)
001D44  move.l a2, (a3)+
001D46  move.w d2, d0
001D48  move.w d3, d1
001D4A  dbra   d6, $1d04
001D4E  move.l (a6), (a3)+
001D50  rts    
001D52  subq.w #$1, $2(a0)
001D56  bra.b  $1d46
001D58  movea.l $4(a1), a0
001D5C  move.w $2(a0), d6
001D60  movea.l a3, a6
001D62  movea.l $8(a0), a5
001D66  move.l a3, $8(a0)
001D6A  movea.l (a5)+, a2
001D6C  movem.w (a2), d0-d1
001D70  bra.b  $1dd2
001D72  movea.l (a5)+, a2
001D74  movem.w (a2), d2-d3
001D78  cmp.w  #$100, d1
001D7C  bcc.b  $1da4
001D7E  cmp.w  #$100, d3
001D82  bcs.b  $1dcc
001D84  move.w d0, d4
001D86  sub.w  d2, d4
001D88  move.w #$100, d5
001D8C  sub.w  d3, d5
001D8E  muls.w d5, d4
001D90  move.w d3, d5
001D92  sub.w  d1, d5
001D94  divs.w d5, d4
001D96  neg.w  d4
001D98  add.w  d2, d4
001D9A  move.l a4, (a3)+
001D9C  move.w d4, (a4)+
001D9E  move.w #$ff, (a4)+
001DA2  bra.b  $1dce
001DA4  cmp.w  #$100, d3
001DA8  bcc.b  $1dda
001DAA  move.w d2, d4
001DAC  sub.w  d0, d4
001DAE  move.w #$100, d5
001DB2  sub.w  d1, d5
001DB4  muls.w d5, d4
001DB6  move.w d1, d5
001DB8  sub.w  d3, d5
001DBA  divs.w d5, d4
001DBC  neg.w  d4
001DBE  add.w  d0, d4
001DC0  move.l a4, (a3)+
001DC2  move.w d4, (a4)+
001DC4  move.w #$ff, (a4)+
001DC8  addq.w #$1, $2(a0)
001DCC  move.l a2, (a3)+
001DCE  move.w d2, d0
001DD0  move.w d3, d1
001DD2  dbra   d6, $1d72
001DD6  move.l (a6), (a3)+
001DD8  rts    
001DDA  subq.w #$1, $2(a0)
001DDE  bra.b  $1dce
001DE0  movea.l $4(a1), a0
001DE4  move.w $2(a0), d6
001DE8  movea.l a3, a6
001DEA  movea.l $8(a0), a5
001DEE  move.l a3, $8(a0)
001DF2  movea.l (a5)+, a2
001DF4  movem.w (a2), d0-d1
001DF8  bra.b  $1e40
001DFA  movea.l (a5)+, a2
001DFC  movem.w (a2), d2-d3
001E00  tst.w  d0
001E02  bmi.b  $1e1e
001E04  tst.w  d2
001E06  bpl.b  $1e3a
001E08  move.w d1, d4
001E0A  sub.w  d3, d4
001E0C  move.w d2, d5
001E0E  sub.w  d0, d5
001E10  muls.w d2, d4
001E12  divs.w d5, d4
001E14  add.w  d3, d4
001E16  move.l a4, (a3)+
001E18  clr.w  (a4)+
001E1A  move.w d4, (a4)+
001E1C  bra.b  $1e3c
001E1E  tst.w  d2
001E20  bmi.b  $1e48
001E22  move.w d3, d4
001E24  move.w d0, d5
001E26  sub.w  d1, d4
001E28  sub.w  d2, d5
001E2A  muls.w d0, d4
001E2C  divs.w d5, d4
001E2E  add.w  d1, d4
001E30  move.l a4, (a3)+
001E32  clr.w  (a4)+
001E34  move.w d4, (a4)+
001E36  addq.w #$1, $2(a0)
001E3A  move.l a2, (a3)+
001E3C  move.w d2, d0
001E3E  move.w d3, d1
001E40  dbra   d6, $1dfa
001E44  move.l (a6), (a3)+
001E46  rts    
001E48  subq.w #$1, $2(a0)
001E4C  bra.b  $1e3c
001E4E  movea.l $4(a1), a0
001E52  move.w $2(a0), d6
001E56  movea.l a3, a6
001E58  movea.l $8(a0), a5
001E5C  move.l a3, $8(a0)
001E60  movea.l (a5)+, a2
001E62  movem.w (a2), d0-d1
001E66  bra.b  $1ec8
001E68  movea.l (a5)+, a2
001E6A  movem.w (a2), d2-d3
001E6E  cmp.w  #$100, d0
001E72  bcc.b  $1e9a
001E74  cmp.w  #$100, d2
001E78  bcs.b  $1ec2
001E7A  move.w d1, d4
001E7C  sub.w  d3, d4
001E7E  move.w #$100, d5
001E82  sub.w  d2, d5
001E84  muls.w d5, d4
001E86  move.w d2, d5
001E88  sub.w  d0, d5
001E8A  divs.w d5, d4
001E8C  neg.w  d4
001E8E  add.w  d3, d4
001E90  move.l a4, (a3)+
001E92  move.w #$ff, (a4)+
001E96  move.w d4, (a4)+
001E98  bra.b  $1ec4
001E9A  cmp.w  #$100, d2
001E9E  bcc.b  $1ed0
001EA0  move.w d3, d4
001EA2  sub.w  d1, d4
001EA4  move.w #$100, d5
001EA8  sub.w  d0, d5
001EAA  muls.w d5, d4
001EAC  move.w d0, d5
001EAE  sub.w  d2, d5
001EB0  divs.w d5, d4
001EB2  neg.w  d4
001EB4  add.w  d1, d4
001EB6  move.l a4, (a3)+
001EB8  move.w #$ff, (a4)+
001EBC  move.w d4, (a4)+
001EBE  addq.w #$1, $2(a0)
001EC2  move.l a2, (a3)+
001EC4  move.w d2, d0
001EC6  move.w d3, d1
001EC8  dbra   d6, $1e68
001ECC  move.l (a6), (a3)+
001ECE  rts    
001ED0  subq.w #$1, $2(a0)
001ED4  bra.b  $1ec4
001ED6  moveq  #$0, d5
001ED8  tst.w  d3
001EDA  bpl.b  $1ede
001EDC  addq.w #$8, d5
001EDE  cmp.w  #$ff, d3
001EE2  ble.b  $1ee6
001EE4  addq.w #$4, d5
001EE6  tst.w  d2
001EE8  bpl.b  $1eec
001EEA  addq.w #$2, d5
001EEC  cmp.w  #$ff, d2
001EF0  ble.b  $1ef4
001EF2  addq.w #$1, d5
001EF4  rts    
001EF6  clr.l  $4(a0)
001EFA  move.l a0, $8(a0)
001EFE  lea.l  $4(a0), a1
001F02  move.l a1, (a0)
001F04  rts    
001F06  move.l a2, d0
001F08  movea.l (a1), a2
001F0A  move.l a2, (a0)
001F0C  move.l a1, $4(a0)
001F10  move.l a0, (a1)
001F12  move.l a0, $4(a2)
001F16  movea.l d0, a2
001F18  rts    
001F1A  move.l a2, d0
001F1C  movea.l $8(a1), a2
001F20  move.l a0, $8(a1)
001F24  lea.l  $4(a1), a1
001F28  move.l a1, (a0)
001F2A  move.l a2, $4(a0)
001F2E  move.l a0, (a2)
001F30  movea.l d0, a2
001F32  rts    
001F34  movea.l (a0), a1
001F36  movea.l $4(a0), a0
001F3A  move.l a1, (a0)
001F3C  move.l a0, $4(a1)
001F40  rts    
001F42  bra.b  $1f46
001F44  move.b (a0)+, (a1)+
001F46  dbra   d0, $1f44
001F4A  rts    
001F4C  movem.l d0-d7, -(a7)
001F50  movem.w (a0), d5-d7
001F54  movea.l a1, a0
001F56  bsr.w  $c16
001F5A  movem.l (a7)+, d0-d7
001F5E  rts    
001F60  movem.l a2-a4, -(a7)
001F64  movea.l a0, a1
001F66  move.l (a1)+, d1
001F68  beq.b  $1f88
001F6A  movea.l d1, a2
001F6C  movea.l a1, a3
001F6E  move.l (a2), d0
001F70  move.l (a1)+, d1
001F72  beq.b  $1f82
001F74  movea.l d1, a4
001F76  cmp.l  (a4), d0
001F78  bcc.b  $1f80
001F7A  movea.l a4, a2
001F7C  movea.l a1, a3
001F7E  move.l (a2), d0
001F80  bra.b  $1f70
001F82  move.l (a0), -(a3)
001F84  move.l a2, (a0)+
001F86  bra.b  $1f64
001F88  movem.l (a7)+, a2-a4
001F8C  rts    
001F8E  lea.l  $1fba.l, a1
001F94  move.w (a0)+, (a1)
001F96  move.w (a0)+, $6(a1)
001F9A  move.w (a0)+, $c(a1)
001F9E  move.w (a0)+, $2(a1)
001FA2  move.w (a0)+, $8(a1)
001FA6  move.w (a0)+, $e(a1)
001FAA  move.w (a0)+, $4(a1)
001FAE  move.w (a0)+, $a(a1)
001FB2  move.w (a0)+, $10(a1)
001FB6  movea.l a1, a0
001FB8  rts    
001FBA  ori.b  #$0, d0
001FBE  ori.b  #$0, d0
001FC2  ori.b  #$0, d0
001FC6  ori.b  #$0, d0
001FCA  ori.b  #$0, d0
001FCE  move.w #$7fff, d1
001FD2  move.w d1, (a0)+
001FD4  move.w d0, (a0)+
001FD6  move.w d0, (a0)+
001FD8  move.w d0, (a0)+
001FDA  move.w d1, (a0)+
001FDC  move.w d0, (a0)+
001FDE  move.w d0, (a0)+
001FE0  move.w d0, (a0)+
001FE2  move.w d1, (a0)+
001FE4  rts    
001FE6  movem.l a2-a3, -(a7)
001FEA  movea.l (a1), a2
001FEC  movea.l $8(a0), a3
001FF0  move.l a3, $4(a2)
001FF4  move.l a2, (a3)
001FF6  movea.l (a0), a2
001FF8  move.l a2, (a1)
001FFA  move.l a1, $4(a2)
001FFE  movem.l (a7)+, a2-a3
002002  rts    
002004  jmp    $204e.l
00200A  jmp    $2040.l
002010  jmp    $203c.l
002016  move.w $34(a5), d0
00201A  sub.w  d0, $2c(a1)
00201E  bpl.b  $2036
002020  movem.l a0-a2, -(a7)
002024  movea.l $c(a0), a2
002028  movea.l $10(a0), a1
00202C  moveq  #$1, d0
00202E  jsr    -$12(a2)
002032  movem.l (a7)+, a0-a2
002036  jmp    $26e6.l
00203C  moveq  #$2e, d0
00203E  rts    
002040  move.w #$64, $2c(a0)
002046  jsr    $26fa.l
00204C  rts    
00204E  jmp    $270a.l
002054  lea.l  $207c.l, a1
00205A  moveq  #$5, d0
00205C  move.w (a0)+, (a1)+
00205E  dbra   d0, $205c
002062  lea.l  $206c(pc), a0
002066  bsr.w  $2314
00206A  rts    
00206C  ori.b  #$9a, d0
002070  ori.b  #$90, d0
002074  ori.b  #$16, d0
002078  ori.b  #$90, d0
00207C  ori.b  #$0, d0
002080  ori.b  #$0, d0
002084  ori.b  #$0, d0
002088  ori.b  #$0, d0
00208C  ori.b  #$0, d0
002090  ori.b  #$98, d0
002094  ori.b  #$0, d0
002098  ori.b  #$b4, d0
00209C  ori.b  #$bc, d0
0020A0  ori.b  #$c8, d0
0020A4  ori.b  #$dc, d0
0020A8  ori.b  #$1, d1
0020AC  ori.b  #$1, d1
0020B0  ; data: 0x00, 0xc8
0020B2  ori.b  #$0, d0
0020B6  ori.b  #$0, d0
0020BA  ori.b  #$3, d0
0020BE  ori.b  #$0, d3
0020C2  move.l (a0, d0.w), (a0)+
0020C6  move.l (a0, d0.w), (a0)+
0020CA  move.l #$10001, (a0)
0020D0  ori.b  #$d8, d0
0020D4  ori.b  #$d8, d0
0020D8  ori.b  #$dc, d0
0020DC  ori.b  #$36, d0
0020E0  ori.b  #$0, d0
0020E4  ori.b  #$1, d0
0020E8  ori.b  #$ac, d5
0020EC  ; data: 0x00, 0xc8
0020EE  ori.b  #$5, d0
0020F2  chk.w  $5(a4), d1
0020F6  chk.w  $5(a4), d1
0020FA  chk.w  $48e7(a4), d1
0020FE  move.l $2448.w, d0
002102  movea.l a1, a3
002104  suba.l a4, a4
002106  moveq  #$0, d2
002108  move.l (a3)+, d0
00210A  add.w  d0, d0
00210C  add.w  d0, d0
00210E  movea.l $2114(pc, d0.w), a0
002112  jmp    (a0)
002114  ori.b  #$2c, d0
002118  ori.b  #$52, d0
00211C  ori.b  #$32, d0
002120  ori.b  #$68, d0
002124  ori.b  #$70, d0
002128  ori.b  #$98, d0
00212C  movem.l (a7)+, d2/a2-a4
002130  rts    
002132  movem.l d2/a2, -(a7)
002136  movea.l (a3)+, a0
002138  bsr.w  $2314
00213C  movea.l d0, a4
00213E  movea.l d0, a0
002140  move.l d2, $8(a0)
002144  move.l a0, d2
002146  movea.l a2, a1
002148  movea.l $18(a0), a2
00214C  bsr.w  $1f1a
002150  bra.b  $2108
002152  movea.l (a3)+, a0
002154  bsr.w  $2314
002158  movea.l d0, a4
00215A  movea.l d0, a0
00215C  move.l d2, $8(a0)
002160  movea.l a2, a1
002162  bsr.w  $1f1a
002166  bra.b  $2108
002168  movem.l (a7)+, d2/a2
00216C  bra.w  $2108
002170  movea.l (a3)+, a0
002172  lea.l  $10(a0), a1
002176  move.l (a3)+, (a1)+
002178  move.l (a3)+, (a1)+
00217A  move.l (a3)+, (a1)+
00217C  move.l (a3)+, (a1)+
00217E  move.w (a3)+, (a1)+
002180  addq.w #$2, a3
002182  bsr.w  $2314
002186  movea.l d0, a4
002188  movea.l d0, a0
00218A  move.l d2, $8(a0)
00218E  movea.l a2, a1
002190  bsr.w  $1f1a
002194  bra.w  $2108
002198  movea.l (a3)+, a0
00219A  move.l a4, (a0)
00219C  bra.w  $2108
0021A0  movem.l a2-a3, -(a7)
0021A4  movea.l a0, a2
0021A6  move.l a0, $28(a5)
0021AA  movea.l $10(a2), a0
0021AE  movea.l $10(a0), a1
0021B2  movea.l $c(a0), a3
0021B6  jsr    (a3)
0021B8  movea.l $10(a2), a0
0021BC  lea.l  $28(a0), a0
0021C0  bsr.w  $854
0021C4  movea.l a2, a0
0021C6  bsr.b  $21dc
0021C8  movea.l $c(a2), a0
0021CC  bsr.w  $1f60
0021D0  movea.l a2, a0
0021D2  bsr.w  $226c
0021D6  movem.l (a7)+, a2-a3
0021DA  rts    
0021DC  movem.l d7/a2-a4/a6, -(a7)
0021E0  movea.l a0, a2
0021E2  move.l $c(a2), d7
0021E6  movea.l (a2), a3
0021E8  movea.l $10(a2), a2
0021EC  lea.l  $1c(a2), a1
0021F0  lea.l  $224c(pc), a0
0021F4  movea.l a0, a2
0021F6  move.l (a1)+, (a0)+
0021F8  move.l (a1)+, (a0)+
0021FA  move.l (a1)+, (a0)+
0021FC  move.w (a1), (a0)+
0021FE  move.w $6(a1), (a0)+
002202  move.w $c(a1), (a0)+
002206  move.w $2(a1), (a0)+
00220A  move.w $8(a1), (a0)+
00220E  move.w $e(a1), (a0)+
002212  move.w $4(a1), (a0)+
002216  move.w $a(a1), (a0)+
00221A  move.w $10(a1), (a0)+
00221E  bra.b  $223e
002220  movea.l $10(a3), a1
002224  movea.l $c(a3), a4
002228  movea.l a3, a0
00222A  jsr    (a4)
00222C  movea.l $18(a3), a1
002230  movea.l $14(a3), a4
002234  movea.l a3, a0
002236  exg.l  d7, a6
002238  jsr    (a4)
00223A  exg.l  d7, a6
00223C  movea.l (a3), a3
00223E  tst.l  (a3)
002240  bne.b  $2220
002242  movea.l d7, a0
002244  clr.l  (a0)
002246  movem.l (a7)+, d7/a2-a4/a6
00224A  rts    
00224C  ori.b  #$0, d0
002250  ori.b  #$0, d0
002254  ori.b  #$0, d0
002258  ori.b  #$0, d0
00225C  ori.b  #$0, d0
002260  ori.b  #$0, d0
002264  ori.b  #$0, d0
002268  ori.b  #$0, d0
00226C  move.l a6, -(a7)
00226E  movea.l $c(a0), a6
002272  bra.b  $227a
002274  movea.l d0, a0
002276  bsr.w  $2282
00227A  move.l (a6)+, d0
00227C  bne.b  $2274
00227E  movea.l (a7)+, a6
002280  rts    
002282  movem.l d2-d7/a2-a6, -(a7)
002286  move.l a0, -(a7)
002288  bsr.w  $f62
00228C  movea.l (a7), a0
00228E  bsr.w  $fd2
002292  bsr.w  $1a56
002296  movea.l (a7), a0
002298  bsr.w  $1a74
00229C  movea.l (a7), a0
00229E  bsr.w  $1a96
0022A2  movea.l (a7), a0
0022A4  bsr.w  $1bee
0022A8  movea.l (a7)+, a0
0022AA  bsr.w  $30f8
0022AE  movem.l (a7)+, d2-d7/a2-a6
0022B2  rts    
0022B4  move.l a2, -(a7)
0022B6  moveq  #$1c, d0
0022B8  moveq  #$0, d1
0022BA  jsr    -$2a(a6)
0022BE  movea.l d0, a2
0022C0  move.l #$190, d0
0022C6  moveq  #$0, d1
0022C8  jsr    -$2a(a6)
0022CC  move.l d0, $c(a2)
0022D0  movea.l a2, a0
0022D2  bsr.w  $1ef6
0022D6  lea.l  $22f2.l, a0
0022DC  bsr.w  $2314
0022E0  move.l d0, $10(a2)
0022E4  move.l d0, $14(a2)
0022E8  move.l d0, $18(a2)
0022EC  move.l a2, d0
0022EE  movea.l (a7)+, a2
0022F0  rts    
0022F2  ori.b  #$94, d0
0022F6  ori.b  #$0, d0
0022FA  ori.b  #$ce, d0
0022FE  ori.b  #$0, d0
002302  ori.b  #$0, d0
002306  ori.b  #$0, d0
00230A  ori.b  #$0, d0
00230E  ori.b  #$0, d0
002312  ori.b  #$e7, d0
002316  move.w $2648.w, d0
00231A  movea.l (a3), a0
00231C  jsr    -$6(a0)
002320  move.l d0, d2
002322  movea.l $8(a3), a0
002326  jsr    -$6(a0)
00232A  move.l d0, d3
00232C  moveq  #$3c, d0
00232E  add.l  d2, d0
002330  add.l  d3, d0
002332  moveq  #$40, d1
002334  jsr    -$2a(a6)
002338  movea.l d0, a2
00233A  add.l  #$3c, d0
002340  move.l d0, $10(a2)
002344  add.l  d2, d0
002346  move.l d0, $18(a2)
00234A  lea.l  $10(a3), a0
00234E  lea.l  $1c(a2), a1
002352  move.l (a0)+, (a1)+
002354  move.l (a0)+, (a1)+
002356  move.l (a0)+, (a1)+
002358  lea.l  $1c(a3), a0
00235C  lea.l  $28(a2), a1
002360  bsr.w  $1f4c
002364  movea.l $10(a2), a0
002368  movea.l $4(a3), a1
00236C  movea.l (a3), a4
00236E  move.l a4, $c(a2)
002372  jsr    -$c(a4)
002376  movea.l $18(a2), a0
00237A  movea.l $c(a3), a1
00237E  movea.l $8(a3), a4
002382  move.l a4, $14(a2)
002386  jsr    -$c(a4)
00238A  movea.l a2, a0
00238C  movea.l $10(a2), a1
002390  movea.l $c(a2), a4
002394  jsr    (a4)
002396  move.l a2, d0
002398  movem.l (a7)+, d2-d3/a2-a4
00239C  rts    
00239E  movem.l a2-a4, -(a7)
0023A2  movea.l a0, a2
0023A4  movea.l a1, a3
0023A6  movea.l $10(a3), a0
0023AA  bsr.w  $1f1a
0023AE  tst.l  (a2)
0023B0  beq.b  $23ba
0023B2  movea.l a2, a0
0023B4  jsr    $1f34(pc)
0023B8  clr.l  (a2)
0023BA  move.l a2, $10(a3)
0023BE  movem.l (a7)+, a2-a4
0023C2  rts    
0023C4  movem.l d2-d7/a2-a4, -(a7)
0023C8  movea.l a0, a3
0023CA  movea.l a1, a4
0023CC  movem.l (a3), d0-d2
0023D0  lea.l  (a2), a0
0023D2  sub.l  (a0)+, d0
0023D4  sub.l  (a0)+, d1
0023D6  sub.l  (a0)+, d2
0023D8  lea.l  $c(a2), a0
0023DC  bsr.w  $dac
0023E0  movem.w d0-d2, $4(a4)
0023E6  move.l $24(a4), d3
0023EA  beq.b  $23fa
0023EC  movea.l d3, a1
0023EE  move.l (a4), d3
0023F0  cmp.l  (a1)+, d3
0023F2  movea.l (a1)+, a0
0023F4  bcs.b  $23f0
0023F6  move.l a0, $20(a4)
0023FA  bmi.w  $247e
0023FE  movea.l $20(a4), a0
002402  move.w $18(a0), d7
002406  move.w #$7fff, d6
00240A  sub.w  d7, d6
00240C  cmp.w  d6, d2
00240E  bge.b  $247e
002410  move.w d7, d6
002412  neg.w  d6
002414  cmp.w  d6, d2
002416  ble.b  $247e
002418  move.w d2, d5
00241A  sub.w  d7, d5
00241C  cmp.w  #$100, d5
002420  bge.b  $2426
002422  move.w #$100, d5
002426  add.w  d7, d7
002428  move.w d0, d4
00242A  bpl.b  $242e
00242C  neg.w  d4
00242E  sub.w  d7, d4
002430  bmi.b  $2440
002432  ext.l  d4
002434  lsl.l  #$8, d4
002436  divu.w d5, d4
002438  bvs.b  $247e
00243A  cmp.w  #$7f, d4
00243E  bcc.b  $247e
002440  move.w d1, d4
002442  bpl.b  $2446
002444  neg.w  d4
002446  sub.w  d7, d4
002448  bmi.b  $2458
00244A  ext.l  d4
00244C  lsl.l  #$8, d4
00244E  divu.w d5, d4
002450  bvs.b  $247e
002452  cmp.w  #$7f, d4
002456  bcc.b  $247e
002458  muls.w d0, d0
00245A  muls.w d1, d1
00245C  muls.w d2, d2
00245E  add.l  d1, d0
002460  add.l  d2, d0
002462  move.l d0, (a4)
002464  lea.l  $c(a2), a0
002468  lea.l  $c(a3), a1
00246C  lea.l  $c(a4), a2
002470  bsr.w  $cba
002474  moveq  #$1, d0
002476  movea.l a4, a1
002478  movem.l (a7)+, d2-d7/a2-a4
00247C  rts    
00247E  moveq  #$0, d0
002480  movea.l a4, a1
002482  movem.l (a7)+, d2-d7/a2-a4
002486  rts    
002488  jmp    $249e.l
00248E  jmp    $250c.l
002494  jmp    $249c.l
00249A  rts    
00249C  moveq  #$0, d0
00249E  movem.l a0-a4, -(a7)
0024A2  cmp.w  #$1, d0
0024A6  beq.b  $24b4
0024A8  cmp.w  #$2, d0
0024AC  beq.b  $24e8
0024AE  movem.l (a7)+, a0-a4
0024B2  rts    
0024B4  movea.l a0, a2
0024B6  movea.l a1, a3
0024B8  movea.l $28(a5), a4
0024BC  cmpa.l $18(a4), a2
0024C0  beq.b  $24e4
0024C2  cmpa.l $10(a4), a2
0024C6  bne.b  $24d2
0024C8  movea.l $18(a4), a0
0024CC  movea.l a2, a1
0024CE  bsr.w  $239e
0024D2  cmpa.l $14(a4), a2
0024D6  bne.b  $24de
0024D8  move.l $18(a4), $14(a4)
0024DE  movea.l a2, a0
0024E0  bsr.w  $1f34
0024E4  bra.w  $24ae
0024E8  movea.l $c(a0), a2
0024EC  move.l a0, -(a7)
0024EE  moveq  #$1, d0
0024F0  jsr    -$12(a2)
0024F4  movea.l (a7)+, a0
0024F6  lea.l  $1c(a0), a0
0024FA  jsr    $2054(pc)
0024FE  movea.l d0, a0
002500  movea.l $28(a5), a1
002504  bsr.w  $1f1a
002508  bra.w  $24ae
00250C  rts    
00250E  jmp    $249e.l
002514  jmp    $2566.l
00251A  jmp    $2562.l
002520  movem.l d2-d3/a2, -(a7)
002524  move.w $34(a5), d3
002528  bra.b  $2548
00252A  movem.l (a1), d0-d2
00252E  lea.l  $1c(a0), a2
002532  add.l  d0, (a2)+
002534  add.l  d1, (a2)+
002536  add.l  d2, (a2)+
002538  movem.w $c(a1), d0-d2
00253E  lea.l  $14(a1), a2
002542  add.w  d0, (a2)+
002544  add.w  d1, (a2)+
002546  add.w  d2, (a2)+
002548  dbra   d3, $252a
00254C  lea.l  $14(a1), a1
002550  lea.l  $28(a0), a0
002554  exg.l  a1, a0
002556  bsr.w  $1f4c
00255A  movem.l (a7)+, d2-d3/a2
00255E  bsr.w  $249a
002562  moveq  #$1c, d0
002564  rts    
002566  move.l (a1)+, (a0)+
002568  move.l (a1)+, (a0)+
00256A  move.l (a1)+, (a0)+
00256C  move.w (a1)+, (a0)+
00256E  move.w (a1)+, (a0)+
002570  move.w (a1)+, (a0)+
002572  addq.w #$2, a0
002574  lea.l  $1c(a3), a1
002578  move.w (a1)+, (a0)+
00257A  move.w (a1)+, (a0)+
00257C  move.w (a1)+, (a0)+
00257E  bra.w  $250c
002582  jmp    $249e.l
002588  jmp    $250c.l
00258E  jmp    $2620.l
002594  movem.l d2-d7/a2-a4, -(a7)
002598  movea.l a0, a3
00259A  movea.l a1, a4
00259C  lea.l  (a4), a0
00259E  move.w $34(a5), d0
0025A2  movem.w (a0), d1-d3
0025A6  moveq  #$0, d4
0025A8  moveq  #$0, d5
0025AA  moveq  #$0, d6
0025AC  bra.b  $25b4
0025AE  add.w  d1, d4
0025B0  add.w  d2, d5
0025B2  add.w  d3, d6
0025B4  dbra   d0, $25ae
0025B8  movem.w d4-d6, (a0)
0025BC  lea.l  $8(a4), a1
0025C0  bsr.w  $1f4c
0025C4  lea.l  $8(a4), a1
0025C8  lea.l  $28(a3), a0
0025CC  lea.l  $1c(a4), a2
0025D0  bsr.w  $cba
0025D4  lea.l  $1c(a4), a0
0025D8  lea.l  $28(a3), a1
0025DC  bsr.w  $e1e
0025E0  move.w $30(a4), d0
0025E4  mulu.w $34(a5), d0
0025E8  move.w d0, d1
0025EA  move.w d0, d2
0025EC  lea.l  $28(a3), a2
0025F0  muls.w $4(a2), d0
0025F4  muls.w $a(a2), d1
0025F8  muls.w $10(a2), d2
0025FC  add.l  d0, d0
0025FE  swap   d0
002600  add.l  d1, d1
002602  swap   d1
002604  add.l  d2, d2
002606  swap   d2
002608  ext.l  d0
00260A  ext.l  d1
00260C  ext.l  d2
00260E  lea.l  $1c(a3), a2
002612  add.l  d0, (a2)+
002614  add.l  d1, (a2)+
002616  add.l  d2, (a2)
002618  movem.l (a7)+, d2-d7/a2-a4
00261C  bra.w  $249a
002620  moveq  #$34, d0
002622  rts    
002624  jmp    $249e.l
00262A  jmp    $250c.l
002630  jmp    $26b8.l
002636  movem.l d2/a2-a3, -(a7)
00263A  movea.l a0, a2
00263C  movea.l a1, a3
00263E  move.w $34(a5), d0
002642  bra.b  $265a
002644  addi.w #$4, (a3)
002648  addi.w #$5, $2(a3)
00264E  addi.w #$2, $4(a3)
002654  addi.w #$4, $8(a3)
00265A  dbra   d0, $2644
00265E  lea.l  (a3), a0
002660  lea.l  $28(a2), a1
002664  bsr.w  $1f4c
002668  move.w $8(a3), d0
00266C  lea.l  $1056(pc), a0
002670  and.w  #$7fe, d0
002674  move.w (a0, d0.w), d0
002678  muls.w #$d8f0, d0
00267C  swap   d0
00267E  add.w  #$ea84, d0
002682  move.w d0, d1
002684  move.w d0, d2
002686  lea.l  $28(a2), a0
00268A  muls.w $4(a0), d0
00268E  muls.w $a(a0), d1
002692  muls.w $10(a0), d2
002696  add.l  d0, d0
002698  swap   d0
00269A  add.l  d1, d1
00269C  swap   d1
00269E  add.l  d2, d2
0026A0  swap   d2
0026A2  ext.l  d0
0026A4  ext.l  d1
0026A6  ext.l  d2
0026A8  lea.l  $1c(a2), a0
0026AC  move.l d0, (a0)+
0026AE  move.l d1, (a0)+
0026B0  move.l d2, (a0)
0026B2  movem.l (a7)+, d2/a2-a3
0026B6  rts    
0026B8  moveq  #$c, d0
0026BA  rts    
0026BC  jmp    $26ce.l
0026C2  jmp    $26d2.l
0026C8  jmp    $26d0.l
0026CE  rts    
0026D0  moveq  #$0, d0
0026D2  rts    
0026D4  jmp    $270a.l
0026DA  jmp    $26fa.l
0026E0  jmp    $26f6.l
0026E6  movea.l (a1), a1
0026E8  lea.l  $1c(a0), a0
0026EC  bsr.w  $23c4
0026F0  beq.b  $26f4
0026F2  move.l a1, (a6)+
0026F4  rts    
0026F6  moveq  #$2c, d0
0026F8  rts    
0026FA  move.l (a1), $24(a0)
0026FE  move.l $4(a1), $28(a0)
002704  lea.l  $4(a0), a1
002708  move.l a1, (a0)
00270A  rts    
00270C  jmp    $278e.l
002712  jmp    $278a.l
002718  jmp    $2786.l
00271E  movem.l d2-d7/a2-a4, -(a7)
002722  movea.l a1, a4
002724  movea.l a2, a3
002726  lea.l  $1c(a0), a2
00272A  movem.l (a3), d0-d2
00272E  lea.l  (a2), a0
002730  sub.l  (a0)+, d0
002732  sub.l  (a0)+, d1
002734  sub.l  (a0)+, d2
002736  lea.l  $c(a2), a0
00273A  bsr.w  $de4
00273E  ext.l  d0
002740  ext.l  d1
002742  ext.l  d2
002744  movem.l d0-d2, $c(a4)
00274A  lea.l  $c(a2), a1
00274E  lea.l  $c(a3), a0
002752  lea.l  $18(a4), a2
002756  bsr.w  $cba
00275A  lea.l  $c(a4), a2
00275E  movea.l (a4), a3
002760  bra.b  $277c
002762  movea.l $10(a3), a1
002766  movea.l $c(a3), a4
00276A  movea.l a3, a0
00276C  jsr    (a4)
00276E  movea.l $18(a3), a1
002772  movea.l $14(a3), a4
002776  movea.l a3, a0
002778  jsr    (a4)
00277A  movea.l (a3), a3
00277C  tst.l  (a3)
00277E  bne.b  $2762
002780  movem.l (a7)+, d2-d7/a2-a4
002784  rts    
002786  moveq  #$2c, d0
002788  rts    
00278A  bra.w  $1ef6
00278E  rts    
002790  movem.l d2-d7/a2-a6, -(a7)
002794  lea.l  $27ce(pc), a0
002798  jsr    -$4e(a6)
00279C  move.l d0, d7
00279E  lea.l  $27ce(pc), a0
0027A2  lea.l  $24030.l, a1
0027A8  jsr    -$42(a6)
0027AC  lea.l  $24030.l, a0
0027B2  lea.l  $24094.l, a1
0027B8  move.l d7, d0
0027BA  jsr    -$96(a6)
0027BE  lea.l  $24094.l, a0
0027C4  bsr.w  $27e8
0027C8  movem.l (a7)+, d2-d7/a2-a6
0027CC  rts    
0027CE  blt.b  $283f
0027D0  bcc.b  $2800
0027D2  blt.b  $2843
0027D4  bhi.b  $284f
0027D6  bge.b  $283d
0027D8  ori.b  #$e7, d0
0027DC  ; data: 0x3f, 0x3e
0027DE  bsr.w  $297e
0027E2  movem.l (a7)+, d2-d7/a2-a6
0027E6  rts    
0027E8  lea.l  $2e78(pc), a6
0027EC  move.l a0, $204(a6)
0027F0  lea.l  $43c(a0), a1
0027F4  lea.l  $3b8(a0), a2
0027F8  lea.l  (a6), a3
0027FA  movea.l a1, a4
0027FC  moveq  #$7f, d0
0027FE  moveq  #$0, d1
002800  move.b (a2)+, d1
002802  lsl.w  #$8, d1
002804  lsl.l  #$2, d1
002806  add.l  a1, d1
002808  move.l d1, (a3)+
00280A  cmp.l  a4, d1
00280C  bcs.b  $2810
00280E  movea.l d1, a4
002810  dbra   d0, $27fe
002814  adda.w #$400, a4
002818  lea.l  $43c(a0), a3
00281C  lea.l  $2a02.l, a1
002822  move.w #$ff, d7
002826  move.w (a3), d0
002828  move.w $2(a3), d1
00282C  move.w #$fff, d2
002830  moveq  #$0, d3
002832  and.w  d0, d2
002834  beq.b  $283e
002836  movea.l a1, a2
002838  addq.w #$2, d3
00283A  cmp.w  (a2)+, d2
00283C  bcs.b  $2838
00283E  move.b d3, d6
002840  move.w d0, d2
002842  move.w d1, d3
002844  rol.w  #$8, d2
002846  rol.w  #$4, d3
002848  and.w  #$f0, d2
00284C  and.w  #$f, d3
002850  or.w   d2, d3
002852  lsl.w  #$3, d3
002854  move.b $2(a3), d0
002858  move.b $3(a3), d1
00285C  and.w  #$f, d0
002860  beq.b  $286c
002862  cmp.w  #$3, d0
002866  bne.b  $286e
002868  moveq  #$0, d0
00286A  bra.b  $286e
00286C  moveq  #$3, d0
00286E  add.w  d0, d0
002870  add.w  d0, d0
002872  move.b d0, (a3)+
002874  move.b d1, (a3)+
002876  move.b d6, (a3)+
002878  move.b d3, (a3)+
00287A  dbra   d7, $2826
00287E  cmpa.l a3, a4
002880  bne.b  $2822
002882  lea.l  $2a(a0), a1
002886  movea.l a0, a2
002888  moveq  #$1e, d0
00288A  movem.w (a1), d1-d4
00288E  move.w d1, d5
002890  movea.l a4, a3
002892  tst.w  d3
002894  beq.b  $289e
002896  adda.w d3, a3
002898  adda.w d3, a3
00289A  move.w d3, d5
00289C  add.w  d4, d5
00289E  move.w d2, (a2)+
0028A0  move.l a4, (a2)+
0028A2  move.w d5, (a2)+
0028A4  move.l a3, (a2)+
0028A6  move.w d4, (a2)+
0028A8  addq.l #$2, a2
0028AA  adda.w d1, a4
0028AC  adda.w d1, a4
0028AE  adda.w #$1e, a1
0028B2  dbra   d0, $288a
0028B6  ori.b  #$2, $bfe001.l
0028BE  move.w #$6, $21a(a6)
0028C4  move.w #$6, $216(a6)
0028CA  move.w #$40, $218(a6)
0028D0  lea.l  (a6), a2
0028D2  lea.l  $43c(a0), a1
0028D6  moveq  #$0, d0
0028D8  move.b $3b7(a0), d0
0028DC  addq.w #$1, d0
0028DE  and.w  #$7f, d0
0028E2  add.w  d0, d0
0028E4  add.w  d0, d0
0028E6  add.l  a2, d0
0028E8  move.l d0, $20a(a6)
0028EC  moveq  #$0, d0
0028EE  move.b $3b6(a0), d0
0028F2  add.w  d0, d0
0028F4  add.w  d0, d0
0028F6  moveq  #$ff, d1
0028F8  move.l d1, (a2, d0.w)
0028FC  move.l (a2)+, $20e(a6)
002900  move.l a2, $212(a6)
002904  lea.l  $21c(a6), a0
002908  move.l a0, $220(a6)
00290C  move.l a0, $238(a6)
002910  move.l a0, $250(a6)
002914  move.l a0, $268(a6)
002918  moveq  #$1, d0
00291A  move.w d0, $224(a6)
00291E  move.w d0, $23c(a6)
002922  move.w d0, $254(a6)
002926  move.w d0, $26c(a6)
00292A  move.w #$1, $234(a6)
002930  move.w #$2, $24c(a6)
002936  move.w #$4, $264(a6)
00293C  move.w #$8, $27c(a6)
002942  lea.l  $2db8(pc), a1
002946  lea.l  -$80(a6), a2
00294A  lea.l  $27e8(pc), a3
00294E  moveq  #$1f, d0
002950  movea.w (a1)+, a4
002952  adda.l a3, a4
002954  move.l a4, (a2)+
002956  dbra   d0, $2950
00295A  rts    
00295C  clr.w  $dff0a8.l
002962  clr.w  $dff0b8.l
002968  clr.w  $dff0c8.l
00296E  clr.w  $dff0d8.l
002974  move.w #$f, $dff096.l
00297C  rts    
00297E  lea.l  $2e78(pc), a6
002982  subq.w #$1, $216(a6)
002986  beq.b  $29e6
002988  tst.w  $208(a6)
00298C  beq.b  $29c4
00298E  sf.b   $208(a6)
002992  lea.l  $dff0a0.l, a5
002998  lea.l  $220(a6), a0
00299C  move.l (a0)+, (a5)+
00299E  move.w (a0)+, (a5)+
0029A0  lea.l  $a(a5), a5
0029A4  lea.l  $12(a0), a0
0029A8  move.l (a0)+, (a5)+
0029AA  move.w (a0)+, (a5)+
0029AC  lea.l  $a(a5), a5
0029B0  lea.l  $12(a0), a0
0029B4  move.l (a0)+, (a5)+
0029B6  move.w (a0)+, (a5)+
0029B8  lea.l  $a(a5), a5
0029BC  lea.l  $12(a0), a0
0029C0  move.l (a0)+, (a5)+
0029C2  move.w (a0)+, (a5)+
0029C4  lea.l  $dff098.l, a5
0029CA  lea.l  $212(a6), a0
0029CE  moveq  #$4, d0
0029D0  subq.w #$1, d0
0029D2  bmi.b  $297c
0029D4  lea.l  $14(a0), a0
0029D8  lea.l  $e(a5), a5
0029DC  move.w (a0)+, d1
0029DE  move.w (a0)+, d2
0029E0  movea.l -$40(a6, d1.w), a1
0029E4  jmp    (a1)
0029E6  movea.l $20e(a6), a5
0029EA  lea.l  $dff0a0.l, a4
0029F0  lea.l  $220(a6), a3
0029F4  movea.l $204(a6), a1
0029F8  moveq  #$0, d2
0029FA  moveq  #$0, d3
0029FC  moveq  #$1, d7
0029FE  moveq  #$3, d6
002A00  bra.b  $2a4e
002A02  bchg.b d1, (a0)+
002A04  btst.l d1, $2fa(a0)
002A08  ; data: 0x02, 0xd0
002A0A  andi.l #$280025c, -(a6)
002A10  ; data: 0x02, 0x3a
002A12  andi.b #$fc, (a2)+
002A16  bset.b d0, -(a0)
002A18  bset.b d0, d5
002A1A  bclr.b d0, $194(a4)
002A1E  ; data: 0x01, 0x7d
002A20  bchg.b d0, $153(a0)
002A24  bchg.b d0, d0
002A26  btst.l d0, $11d(a6)
002A2A  movep.w $fe(a5), d0
002A2E  ; data: 0x00, 0xf0
002A30  ; data: 0x00, 0xe2
002A32  ; data: 0x00, 0xd6
002A34  ; data: 0x00, 0xca
002A36  ; data: 0x00, 0xbe
002A38  ori.l  #$aa00a0, -$69(a4, d0.w)
002A40  ; data: 0x00, 0x8f
002A42  ori.l  #$7f0078, d7
002A48  ori.w  #$0, (a1, d0.w)
002A4E  move.b (a5)+, d2
002A50  move.b (a5)+, d3
002A52  move.w d3, $8(a3)
002A56  move.w d2, $6(a3)
002A5A  beq.b  $2aae
002A5C  cmp.b  #$14, d2
002A60  beq.b  $2aae
002A62  moveq  #$0, d1
002A64  move.b (a5)+, d1
002A66  beq.w  $2af0
002A6A  move.w $2a00(pc, d1.w), d0
002A6E  move.w d0, $e(a3)
002A72  swap   d0
002A74  move.w d7, $dff096.l
002A7A  move.b (a5)+, d1
002A7C  beq.b  $2aa0
002A7E  add.w  d1, d1
002A80  move.w d1, $16(a3)
002A84  lea.l  -$10(a1, d1.w), a2
002A88  move.w (a2)+, d0
002A8A  move.l (a2)+, (a4)+
002A8C  move.w (a2)+, (a4)+
002A8E  move.l (a2)+, (a3)
002A90  move.w (a2)+, $4(a3)
002A94  move.b #$0, $11(a3)
002A9A  movea.l -$80(a6, d2.w), a0
002A9E  jmp    (a0)
002AA0  move.w $16(a3), d1
002AA4  lea.l  -$e(a1, d1.w), a2
002AA8  move.w $c(a3), d0
002AAC  bra.b  $2a8a
002AAE  moveq  #$0, d1
002AB0  move.b (a5)+, d1
002AB2  beq.b  $2b1a
002AB4  lea.l  $2a02(pc), a2
002AB8  move.w -$2(a2, d1.w), $e(a3)
002ABE  move.b (a5)+, d1
002AC0  beq.b  $2ae2
002AC2  add.w  d1, d1
002AC4  move.w d1, $16(a3)
002AC8  lea.l  -$10(a1, d1.w), a2
002ACC  move.w $a(a3), d0
002AD0  swap   d0
002AD2  move.w (a2)+, d0
002AD4  addq.w #$6, a2
002AD6  move.l (a2)+, (a3)
002AD8  move.w (a2)+, $4(a3)
002ADC  addq.l #$6, a4
002ADE  bra.w  $2ba0
002AE2  move.w $16(a3), d1
002AE6  lea.l  -$8(a1, d1.w), a2
002AEA  move.l $a(a3), d0
002AEE  bra.b  $2ad6
002AF0  move.b (a5)+, d1
002AF2  beq.b  $2b14
002AF4  add.w  d1, d1
002AF6  move.w d1, $16(a3)
002AFA  lea.l  -$10(a1, d1.w), a2
002AFE  move.w $a(a3), d0
002B02  swap   d0
002B04  move.w (a2)+, d0
002B06  move.b #$0, $11(a3)
002B0C  addq.w #$6, a4
002B0E  movea.l -$80(a6, d2.w), a0
002B12  jmp    (a0)
002B14  move.l $a(a3), d0
002B18  bra.b  $2b0c
002B1A  move.w $a(a3), d0
002B1E  swap   d0
002B20  move.b (a5)+, d1
002B22  beq.b  $2b36
002B24  add.w  d1, d1
002B26  move.w d1, $16(a3)
002B2A  lea.l  -$10(a1, d1.w), a2
002B2E  move.w (a2)+, d0
002B30  addq.l #$6, a4
002B32  bra.w  $2ba0
002B36  move.w $c(a3), d0
002B3A  bra.b  $2b30
002B3C  move.l d0, (a4)+
002B3E  move.l d0, $a(a3)
002B42  add.w  d3, d3
002B44  add.w  d3, d3
002B46  lea.l  (a6, d3.w), a0
002B4A  moveq  #$0, d3
002B4C  move.l a0, $212(a6)
002B50  moveq  #$f, d2
002B52  and.b  d3, d2
002B54  lsr.b  #$4, d3
002B56  mulu.w #$a, d3
002B5A  add.w  d2, d3
002B5C  not.b  d3
002B5E  move.b d3, $21e(a6)
002B62  bra.b  $2ba0
002B64  move.b d3, $21b(a6)
002B68  subq.b #$1, d3
002B6A  move.b d3, $217(a6)
002B6E  bra.b  $2ba0
002B70  moveq  #$0, d2
002B72  move.b d3, d2
002B74  beq.b  $2b7a
002B76  move.b d2, $13(a3)
002B7A  move.b $13(a3), d2
002B7E  lsl.w  #$7, d2
002B80  move.w -$8(a2), d3
002B84  sub.w  d2, d3
002B86  move.w d3, -$2(a4)
002B8A  add.w  d2, d2
002B8C  move.l -$c(a2), d3
002B90  add.l  d2, d3
002B92  move.l d3, -$6(a4)
002B96  moveq  #$0, d2
002B98  moveq  #$0, d3
002B9A  bra.b  $2ba0
002B9C  bra.b  $2ba0
002B9E  move.b d3, d0
002BA0  move.l d0, (a4)+
002BA2  move.l d0, $a(a3)
002BA6  addq.w #$6, a4
002BA8  lea.l  $18(a3), a3
002BAC  add.w  d7, d7
002BAE  dbra   d6, $2a4e
002BB2  tst.w  $21e(a6)
002BB6  bne.b  $2bc0
002BB8  subq.w #$1, $218(a6)
002BBC  beq.b  $2bec
002BBE  bra.b  $2c06
002BC0  moveq  #$40, d1
002BC2  moveq  #$0, d0
002BC4  move.b $21e(a6), d0
002BC8  not.b  d0
002BCA  sub.b  d0, d1
002BCC  move.w #$0, $21e(a6)
002BD2  move.w d1, $218(a6)
002BD6  movea.l $212(a6), a0
002BDA  move.l (a0)+, d1
002BDC  movea.l d1, a5
002BDE  bpl.b  $2be6
002BE0  movea.l $20a(a6), a0
002BE4  movea.l (a0)+, a5
002BE6  lsl.w  #$4, d0
002BE8  adda.w d0, a5
002BEA  bra.b  $2c02
002BEC  move.w #$40, $218(a6)
002BF2  movea.l $212(a6), a0
002BF6  move.l (a0)+, d0
002BF8  movea.l d0, a5
002BFA  bpl.b  $2c02
002BFC  movea.l $20a(a6), a0
002C00  movea.l (a0)+, a5
002C02  move.l a0, $212(a6)
002C06  move.l a5, $20e(a6)
002C0A  move.w $21a(a6), $216(a6)
002C10  st.b   $208(a6)
002C14  rts    
002C16  move.w $8(a0), d2
002C1A  bra.b  $2c24
002C1C  tst.w  d2
002C1E  beq.b  $2c16
002C20  move.w d2, $8(a0)
002C24  move.w (a0), d3
002C26  move.w $4(a0), d1
002C2A  cmp.w  d3, d1
002C2C  bpl.b  $2c46
002C2E  beq.b  $2c54
002C30  sub.w  d2, d3
002C32  cmp.w  d1, d3
002C34  bhi.b  $2c3e
002C36  move.w d1, (a5)+
002C38  move.w d1, (a0)
002C3A  bra.w  $29d0
002C3E  move.w d3, (a5)+
002C40  move.w d3, (a0)
002C42  bra.w  $29d0
002C46  add.w  d2, d3
002C48  cmp.w  d1, d3
002C4A  bcs.b  $2c3e
002C4C  move.w d1, (a5)+
002C4E  move.w d1, (a0)
002C50  bra.w  $29d0
002C54  addq.w #$2, a5
002C56  bra.w  $29d0
002C5A  sub.w  d2, (a0)
002C5C  move.w (a0), (a5)+
002C5E  bra.w  $29d0
002C62  add.w  d2, (a0)
002C64  move.w (a0), (a5)+
002C66  bra.w  $29d0
002C6A  tst.b  d2
002C6C  bne.b  $2c74
002C6E  move.b $6(a0), d2
002C72  bra.b  $2c78
002C74  move.b d2, $6(a0)
002C78  moveq  #$7f, d3
002C7A  and.b  $7(a0), d3
002C7E  lsr.w  #$2, d3
002C80  move.b $2cac(pc, d3.w), d3
002C84  move.w d2, d1
002C86  and.w  #$f, d1
002C8A  mulu.w d1, d3
002C8C  lsr.w  #$7, d3
002C8E  move.w (a0), d1
002C90  tst.b  $7(a0)
002C94  bmi.b  $2c9a
002C96  add.w  d3, d1
002C98  bra.b  $2c9c
002C9A  sub.w  d3, d1
002C9C  move.w d1, (a5)+
002C9E  lsr.w  #$2, d2
002CA0  and.w  #$3c, d2
002CA4  add.b  d2, $7(a0)
002CA8  bra.w  $29d0
002CAC  ori.b  #$4a, (a0)+
002CB0  bsr.b  $2d2a
002CB2  or.l   d6, -(a1)
002CB4  cmpa.w d5, a2
002CB6  adda.w -(a0), a2
002CB8  ; data: 0xeb, 0xf4
002CBA  dc.w   $fafd
002CBC  ; data: 0xff, 0xfd
002CBE  dc.w   $faf4
002CC0  ; data: 0xeb, 0xe0
002CC2  adda.w d5, a2
002CC4  cmp.l  -(a1), d2
002CC6  or.w   d6, $614a.w
002CCA  move.w (a0)+, -(a0)
002CCC  bsr.b  $2ce4
002CCE  bra.w  $29d0
002CD2  bsr.b  $2ce4
002CD4  subq.w #$2, a5
002CD6  bsr.b  $2c6e
002CD8  bra.w  $29d0
002CDC  bsr.b  $2ce4
002CDE  subq.w #$2, a5
002CE0  bra.w  $2c16
002CE4  move.w d2, d3
002CE6  addq.w #$2, a5
002CE8  asr.b  #$4, d2
002CEA  beq.b  $2d04
002CEC  add.w  $2(a0), d2
002CF0  cmp.w  #$40, d2
002CF4  bmi.b  $2cfa
002CF6  move.w #$40, d2
002CFA  move.w d2, (a5)
002CFC  move.w d2, $2(a0)
002D00  bra.w  $29d0
002D04  and.w  #$f, d3
002D08  neg.b  d3
002D0A  add.b  $3(a0), d3
002D0E  bpl.b  $2d12
002D10  moveq  #$0, d3
002D12  move.b d3, $3(a0)
002D16  move.w d3, (a5)
002D18  rts    
002D1A  moveq  #$f0, d3
002D1C  and.b  d2, d3
002D1E  cmp.b  #$d0, d3
002D22  beq.b  $2d28
002D24  bra.w  $2ba0
002D28  move.l d0, d3
002D2A  clr.b  d3
002D2C  move.l d3, (a4)+
002D2E  bra.w  $2ba2
002D32  moveq  #$f0, d3
002D34  and.b  d2, d3
002D36  cmp.b  #$90, d3
002D3A  beq.b  $2d46
002D3C  cmp.b  #$d0, d3
002D40  beq.b  $2d7c
002D42  bra.w  $2c54
002D46  move.b $21b(a6), d3
002D4A  sub.b  $217(a6), d3
002D4E  and.b  #$f, d2
002D52  cmp.b  d2, d3
002D54  bne.w  $2c54
002D58  move.w $c(a0), d3
002D5C  movea.l $204(a6), a1
002D60  lea.l  -$e(a1, d3.w), a1
002D64  move.l (a1)+, -$6(a5)
002D68  move.w (a1)+, -$2(a5)
002D6C  move.w $a(a0), $dff096.l
002D74  st.b   $208(a6)
002D78  bra.w  $2c54
002D7C  move.b $21b(a6), d3
002D80  sub.b  $217(a6), d3
002D84  and.b  #$f, d2
002D88  cmp.b  d2, d3
002D8A  bne.w  $2c54
002D8E  move.w $c(a0), d3
002D92  movea.l $204(a6), a1
002D96  lea.l  -$e(a1, d3.w), a1
002D9A  move.l (a1)+, -$6(a5)
002D9E  move.w (a1)+, -$2(a5)
002DA2  move.w $a(a0), $dff096.l
002DAA  addq.l #$2, a5
002DAC  move.w $2(a0), (a5)
002DB0  st.b   $208(a6)
002DB4  bra.w  $29d0
002DB8  bclr.b d1, $3b8.w
002DBC  bclr.b d1, $3b8.w
002DC0  bclr.b d1, $3b8.w
002DC4  bclr.b d1, $3b4.w
002DC8  bclr.b d1, (d0.w * 2)
002DCC  bclr.b d1, $354.w
002DD0  bclr.b d1, $532(a6, invalid.w)
002DD6  ; data: 0x03, 0x7c
002DD8  subi.b #$72, $7a(a4, d0.w)
002DDE  subi.w #$482, $4f4(a4)
002DE4  ; data: 0x04, 0xea
002DE6  subi.w #$46c, $46c(a4)
002DEC  ; data: 0x04, 0xe4
002DEE  subi.w #$46c, $46c(a4)
002DF4  movep.l $46c(a2), d2
002DF8  ori.b  #$0, d0
002DFC  ori.b  #$0, d0
002E00  ori.b  #$0, d0
002E04  ori.b  #$0, d0
002E08  ori.b  #$0, d0
002E0C  ori.b  #$0, d0
002E10  ori.b  #$0, d0
002E14  ori.b  #$0, d0
002E18  ori.b  #$0, d0
002E1C  ori.b  #$0, d0
002E20  ori.b  #$0, d0
002E24  ori.b  #$0, d0
002E28  ori.b  #$0, d0
002E2C  ori.b  #$0, d0
002E30  ori.b  #$0, d0
002E34  ori.b  #$0, d0
002E38  ori.b  #$0, d0
002E3C  ori.b  #$0, d0
002E40  ori.b  #$0, d0
002E44  ori.b  #$0, d0
002E48  ori.b  #$0, d0
002E4C  ori.b  #$0, d0
002E50  ori.b  #$0, d0
002E54  ori.b  #$0, d0
002E58  ori.b  #$0, d0
002E5C  ori.b  #$0, d0
002E60  ori.b  #$0, d0
002E64  ori.b  #$0, d0
002E68  ori.b  #$0, d0
002E6C  ori.b  #$0, d0
002E70  ori.b  #$0, d0
002E74  ori.b  #$0, d0
002E78  ori.b  #$0, d0
002E7C  ori.b  #$0, d0
002E80  ori.b  #$0, d0
002E84  ori.b  #$0, d0
002E88  ori.b  #$0, d0
002E8C  ori.b  #$0, d0
002E90  ori.b  #$0, d0
002E94  ori.b  #$0, d0
002E98  ori.b  #$0, d0
002E9C  ori.b  #$0, d0
002EA0  ori.b  #$0, d0
002EA4  ori.b  #$0, d0
002EA8  ori.b  #$0, d0
002EAC  ori.b  #$0, d0
002EB0  ori.b  #$0, d0
002EB4  ori.b  #$0, d0
002EB8  ori.b  #$0, d0
002EBC  ori.b  #$0, d0
002EC0  ori.b  #$0, d0
002EC4  ori.b  #$0, d0
002EC8  ori.b  #$0, d0
002ECC  ori.b  #$0, d0
002ED0  ori.b  #$0, d0
002ED4  ori.b  #$0, d0
002ED8  ori.b  #$0, d0
002EDC  ori.b  #$0, d0
002EE0  ori.b  #$0, d0
002EE4  ori.b  #$0, d0
002EE8  ori.b  #$0, d0
002EEC  ori.b  #$0, d0
002EF0  ori.b  #$0, d0
002EF4  ori.b  #$0, d0
002EF8  ori.b  #$0, d0
002EFC  ori.b  #$0, d0
002F00  ori.b  #$0, d0
002F04  ori.b  #$0, d0
002F08  ori.b  #$0, d0
002F0C  ori.b  #$0, d0
002F10  ori.b  #$0, d0
002F14  ori.b  #$0, d0
002F18  ori.b  #$0, d0
002F1C  ori.b  #$0, d0
002F20  ori.b  #$0, d0
002F24  ori.b  #$0, d0
002F28  ori.b  #$0, d0
002F2C  ori.b  #$0, d0
002F30  ori.b  #$0, d0
002F34  ori.b  #$0, d0
002F38  ori.b  #$0, d0
002F3C  ori.b  #$0, d0
002F40  ori.b  #$0, d0
002F44  ori.b  #$0, d0
002F48  ori.b  #$0, d0
002F4C  ori.b  #$0, d0
002F50  ori.b  #$0, d0
002F54  ori.b  #$0, d0
002F58  ori.b  #$0, d0
002F5C  ori.b  #$0, d0
002F60  ori.b  #$0, d0
002F64  ori.b  #$0, d0
002F68  ori.b  #$0, d0
002F6C  ori.b  #$0, d0
002F70  ori.b  #$0, d0
002F74  ori.b  #$0, d0
002F78  ori.b  #$0, d0
002F7C  ori.b  #$0, d0
002F80  ori.b  #$0, d0
002F84  ori.b  #$0, d0
002F88  ori.b  #$0, d0
002F8C  ori.b  #$0, d0
002F90  ori.b  #$0, d0
002F94  ori.b  #$0, d0
002F98  ori.b  #$0, d0
002F9C  ori.b  #$0, d0
002FA0  ori.b  #$0, d0
002FA4  ori.b  #$0, d0
002FA8  ori.b  #$0, d0
002FAC  ori.b  #$0, d0
002FB0  ori.b  #$0, d0
002FB4  ori.b  #$0, d0
002FB8  ori.b  #$0, d0
002FBC  ori.b  #$0, d0
002FC0  ori.b  #$0, d0
002FC4  ori.b  #$0, d0
002FC8  ori.b  #$0, d0
002FCC  ori.b  #$0, d0
002FD0  ori.b  #$0, d0
002FD4  ori.b  #$0, d0
002FD8  ori.b  #$0, d0
002FDC  ori.b  #$0, d0
002FE0  ori.b  #$0, d0
002FE4  ori.b  #$0, d0
002FE8  ori.b  #$0, d0
002FEC  ori.b  #$0, d0
002FF0  ori.b  #$0, d0
002FF4  ori.b  #$0, d0
002FF8  ori.b  #$0, d0
002FFC  ori.b  #$0, d0
003000  ori.b  #$0, d0
003004  ori.b  #$0, d0
003008  ori.b  #$0, d0
00300C  ori.b  #$0, d0
003010  ori.b  #$0, d0
003014  ori.b  #$0, d0
003018  ori.b  #$0, d0
00301C  ori.b  #$0, d0
003020  ori.b  #$0, d0
003024  ori.b  #$0, d0
003028  ori.b  #$0, d0
00302C  ori.b  #$0, d0
003030  ori.b  #$0, d0
003034  ori.b  #$0, d0
003038  ori.b  #$0, d0
00303C  ori.b  #$0, d0
003040  ori.b  #$0, d0
003044  ori.b  #$0, d0
003048  ori.b  #$0, d0
00304C  ori.b  #$0, d0
003050  ori.b  #$0, d0
003054  ori.b  #$0, d0
003058  ori.b  #$0, d0
00305C  ori.b  #$0, d0
003060  ori.b  #$0, d0
003064  ori.b  #$0, d0
003068  ori.b  #$0, d0
00306C  ori.b  #$0, d0
003070  ori.b  #$0, d0
003074  ori.b  #$0, d0
003078  ori.b  #$0, d0
00307C  ori.b  #$0, d0
003080  ori.b  #$0, d0
003084  ori.b  #$0, d0
003088  ori.b  #$0, d0
00308C  ori.b  #$0, d0
003090  ori.b  #$0, d0
003094  ori.b  #$0, d0
003098  ori.b  #$0, d0
00309C  ori.b  #$0, d0
0030A0  ori.b  #$0, d0
0030A4  ori.b  #$0, d0
0030A8  ori.b  #$0, d0
0030AC  ori.b  #$0, d0
0030B0  ori.b  #$0, d0
0030B4  ori.b  #$0, d0
0030B8  ori.b  #$0, d0
0030BC  ori.b  #$0, d0
0030C0  ori.b  #$0, d0
0030C4  ori.b  #$0, d0
0030C8  ori.b  #$0, d0
0030CC  ori.b  #$0, d0
0030D0  ori.b  #$0, d0
0030D4  ori.b  #$0, d0
0030D8  ori.b  #$0, d0
0030DC  ori.b  #$0, d0
0030E0  ori.b  #$0, d0
0030E4  ori.b  #$0, d0
0030E8  ori.b  #$0, d0
0030EC  ori.b  #$0, d0
0030F0  ori.b  #$0, d0
0030F4  ori.b  #$0, d0
0030F8  movea.l $20(a0), a0
0030FC  movea.l $c(a0), a1
003100  move.w $16(a0), d7
003104  subq.w #$1, d7
003106  movem.l d0-d7/a0-a6, -(a7)
00310A  cmpi.b #$1, $8(a1)
003110  bne.b  $311e
003112  movem.l d7/a1, -(a7)
003116  movea.l (a1), a0
003118  jsr    (a0)
00311A  movem.l (a7)+, d7/a1
00311E  lea.l  $14(a1), a1
003122  dbra   d7, $310a
003126  movem.l (a7)+, d0-d7/a0-a6
00312A  rts    
00312C  bsr.w  $1c78
003130  bra.w  $33f6
003134  rts    
003136  movea.l $c(a1), a0
00313A  tst.w  $4(a0)
00313E  bne.w  $3226
003142  move.w $a(a0), d3
003146  beq.w  $3226
00314A  move.w $10(a1), d2
00314E  ext.l  d2
003150  lsl.l  #$8, d2
003152  divs.w d3, d2
003154  bvs.w  $3226
003158  movem.w (a0), d0-d1
00315C  move.w d1, d5
00315E  move.w d1, d6
003160  sub.w  d2, d5
003162  cmp.w  #$ff, d5
003166  bcc.w  $3226
00316A  add.w  d2, d6
00316C  cmp.w  #$ff, d6
003170  bcc.w  $3226
003174  movem.l d5-d6/a1/a5, -(a7)
003178  move.l a7, $3228.l
00317E  lea.l  $114d0.l, a3
003184  add.w  d5, d5
003186  lea.l  (a3, d5.w), a0
00318A  add.w  d1, d1
00318C  lea.l  (a3, d1.w), a2
003190  lea.l  $2(a2), a1
003194  add.w  d6, d6
003196  adda.w d6, a3
003198  addq.w #$2, a3
00319A  move.w #$208, d5
00319E  lea.l  (a0, d5.w), a4
0031A2  lea.l  (a1, d5.w), a5
0031A6  lea.l  (a2, d5.w), a6
0031AA  lea.l  (a3, d5.w), a7
0031AE  moveq  #$ff, d6
0031B0  move.w d6, (a3)
0031B2  move.w d6, (a7)
0031B4  move.w d2, d6
0031B6  ble.w  $321e
0031BA  moveq  #$0, d5
0031BC  move.w d2, d7
0031BE  subq.w #$1, d7
0031C0  move.w d0, d1
0031C2  move.w d0, d3
0031C4  sub.w  d2, d3
0031C6  cmp.w  #$ff, d3
0031CA  bhi.b  $321e
0031CC  add.w  d0, d2
0031CE  cmp.w  #$ff, d2
0031D2  bhi.b  $321e
0031D4  subq.w #$1, d0
0031D6  addq.w #$1, d1
0031D8  lsl.w  #$8, d0
0031DA  lsl.w  #$8, d1
0031DC  lsl.w  #$8, d2
0031DE  lsl.w  #$8, d3
0031E0  move.w #$100, d4
0031E4  add.w  d6, d6
0031E6  tst.w  d7
0031E8  bpl.b  $31fa
0031EA  move.w d1, (a0)+
0031EC  move.w d0, (a4)+
0031EE  move.w d1, -(a3)
0031F0  move.w d0, -(a7)
0031F2  subq.w #$2, d6
0031F4  sub.w  d4, d2
0031F6  add.w  d4, d3
0031F8  add.w  d6, d7
0031FA  move.w d2, (a6)+
0031FC  move.w d3, (a2)+
0031FE  move.w d3, -(a1)
003200  move.w d2, -(a5)
003202  sub.w  d5, d7
003204  subq.w #$1, d7
003206  addq.w #$2, d5
003208  add.w  d4, d0
00320A  sub.w  d4, d1
00320C  cmp.w  d6, d5
00320E  ble.b  $31e6
003210  movea.l $3228(pc), a7
003214  movem.l (a7)+, d5-d6/a1/a5
003218  addq.w #$1, d6
00321A  bra.w  $3450
00321E  movea.l $3228(pc), a7
003222  movem.l (a7)+, d5-d6/a1/a5
003226  rts    
003228  ori.b  #$0, d0
00322C  lea.l  $112cc.l, a0
003232  movea.l a0, a1
003234  moveq  #$1, d0
003236  move.w #$fe, d1
00323A  move.w #$0, (a0)+
00323E  move.l #$7fff, d2
003244  divs.w d0, d2
003246  move.w d2, (a0)+
003248  neg.w  d2
00324A  move.w d2, -(a1)
00324C  addq.w #$1, d0
00324E  dbra   d1, $323e
003252  rts    
003254  lea.l  $112cc.l, a6
00325A  movea.l (a2)+, a3
00325C  move.w (a3)+, d0
00325E  move.w (a3)+, d1
003260  move.w d1, d5
003262  move.w d1, d6
003264  subq.w #$1, d7
003266  movea.l (a2)+, a3
003268  move.w (a3)+, d2
00326A  move.w (a3)+, d3
00326C  movea.l d2, a5
00326E  move.l d3, d4
003270  cmp.w  d3, d5
003272  bls.b  $3276
003274  move.w d3, d5
003276  cmp.w  d3, d6
003278  bcc.b  $327c
00327A  move.w d3, d6
00327C  sub.w  d1, d3
00327E  bgt.b  $32b6
003280  beq.b  $32ac
003282  neg.w  d3
003284  lea.l  $114d0.l, a0
00328A  adda.w d4, a0
00328C  adda.w d4, a0
00328E  sub.w  d2, d0
003290  add.w  d0, d0
003292  move.w d3, d1
003294  add.w  d1, d1
003296  muls.w (a6, d1.w), d0
00329A  asr.l  #$8, d0
00329C  asl.l  #$8, d2
00329E  move.b #$80, d2
0032A2  bra.b  $32a8
0032A4  move.w d2, (a0)+
0032A6  add.w  d0, d2
0032A8  dbra   d3, $32a4
0032AC  move.w a5, d0
0032AE  move.w d4, d1
0032B0  dbra   d7, $3266
0032B4  rts    
0032B6  add.w  d1, d1
0032B8  lea.l  $116d8.l, a0
0032BE  adda.w d1, a0
0032C0  sub.w  d0, d2
0032C2  add.w  d2, d2
0032C4  move.w d3, d1
0032C6  add.w  d1, d1
0032C8  muls.w (a6, d1.w), d2
0032CC  asr.l  #$8, d2
0032CE  asl.l  #$8, d0
0032D0  move.b #$80, d0
0032D4  bra.b  $32da
0032D6  move.w d0, (a0)+
0032D8  add.w  d2, d0
0032DA  dbra   d3, $32d6
0032DE  move.w a5, d0
0032E0  move.w d4, d1
0032E2  dbra   d7, $3266
0032E6  rts    
0032E8  lea.l  $218dc.l, a0
0032EE  lea.l  $33ce.l, a1
0032F4  moveq  #$0, d0
0032F6  moveq  #$0, d1
0032F8  move.w d0, d2
0032FA  move.w d1, d3
0032FC  lsr.w  #$4, d2
0032FE  lsr.w  #$4, d3
003300  move.w d2, d4
003302  sub.w  d2, d3
003304  move.w d3, d2
003306  add.w  d2, d2
003308  move.w (a1, d2.w), (a0)+
00330C  add.w  d4, d4
00330E  move.w d4, (a0)+
003310  addq.b #$4, d1
003312  bne.b  $32f8
003314  addq.b #$1, d0
003316  bne.b  $32f6
003318  lea.l  $318dc.l, a0
00331E  lea.l  $336e.l, a2
003324  lea.l  $338e.l, a3
00332A  moveq  #$0, d0
00332C  moveq  #$0, d1
00332E  move.w d0, d2
003330  move.w d1, d3
003332  lsr.w  #$4, d2
003334  lsr.w  #$4, d3
003336  moveq  #$f, d4
003338  and.w  d0, d4
00333A  eori.w #$f, d4
00333E  add.w  d4, d4
003340  move.w (a2, d4.w), d3
003344  moveq  #$f, d4
003346  and.w  d1, d4
003348  add.w  d4, d4
00334A  move.w (a3, d4.w), d4
00334E  move.w d4, (a0)+
003350  move.w d3, (a0)+
003352  addq.b #$1, d1
003354  bne.b  $332e
003356  addq.b #$1, d0
003358  and.b  #$3f, d0
00335C  bne.b  $332c
00335E  rts    
003360  and.w  d3, d4
003362  move.w d4, (a0)+
003364  move.w d4, (a0)+
003366  bra.b  $3352
003368  move.w d3, (a0)+
00336A  move.w d4, (a0)+
00336C  bra.b  $3352
00336E  ori.b  #$3, d1
003372  ori.b  #$f, d7
003376  ori.b  #$3f, (a7)+
00337A  ; data: 0x00, 0x7f
00337C  ; data: 0x00, 0xff
00337E  ; data: 0x01, 0xff
003380  ; data: 0x03, 0xff
003382  ; data: 0x07, 0xff
003384  ; data: 0x0f, 0xff
003386  ; data: 0x1f, 0xff
003388  ; data: 0x3f, 0xff
00338A  ; data: 0x7f, 0xff
00338C  ; data: 0xff, 0xff
00338E  or.b   d0, d0
003390  and.b  d0, d0
003392  asr.b  #$8, d0
003394  dc.w   $f000
003396  dc.w   $f800
003398  dc.w   $fc00
00339A  dc.w   $fe00
00339C  ; data: 0xff, 0x00
00339E  ; data: 0xff, 0x80
0033A0  ; data: 0xff, 0xc0
0033A2  ; data: 0xff, 0xe0
0033A4  ; data: 0xff, 0xf0
0033A6  ; data: 0xff, 0xf8
0033A8  ; data: 0xff, 0xfc
0033AA  ; data: 0xff, 0xfe
0033AC  ; data: 0xff, 0xff
0033AE  ori.b  #$0, d0
0033B2  ori.b  #$0, d0
0033B6  ori.b  #$0, d0
0033BA  ori.b  #$0, d0
0033BE  ori.b  #$0, d0
0033C2  ori.b  #$0, d0
0033C6  ori.b  #$0, d0
0033CA  ori.b  #$0, d0
0033CE  ; data: 0x00, 0x08
0033D0  ori.b  #$30, (a6)+
0033D4  ori.w  #$70, (a0)
0033D8  ori.l  #$bc00e8, (a6)
0033DE  btst.l d0, (a4)
0033E0  bchg.b d0, d6
0033E2  bchg.b d0, $1b0.w
0033E6  bset.b d0, $226(a0)
0033EA  andi.w #$2a8, -(a4)
0033EE  ; data: 0x02, 0xec
0033F0  btst.l d1, (d0.w * 2)
0033F4  rts    
0033F6  movea.l $4(a1), a2
0033FA  move.w $2(a2), d7
0033FE  cmp.w  #$3, d7
003402  bcs.b  $33f4
003404  movea.l $8(a2), a2
003408  bsr.w  $3254
00340C  bra.w  $3450
003410  ori.b  #$d4, d0
003414  ori.b  #$a4, d0
003418  ori.b  #$74, d0
00341C  ori.b  #$44, d0
003420  ori.b  #$14, d0
003424  ori.b  #$e4, d0
003428  ori.b  #$b4, d0
00342C  ori.b  #$84, d0
003430  ori.b  #$14, d0
003434  ori.b  #$a4, d0
003438  ori.b  #$74, d0
00343C  ori.b  #$44, d0
003440  ori.b  #$14, d0
003444  ori.b  #$e4, d0
003448  ori.b  #$b4, d0
00344C  ori.b  #$84, d0
003450  moveq  #$0, d0
003452  move.b $b(a1), d0
003456  add.w  d0, d0
003458  add.w  d0, d0
00345A  movea.l $3410(pc, d0.w), a6
00345E  sub.w  d5, d6
003460  lea.l  $114d0.l, a0
003466  adda.w d5, a0
003468  adda.w d5, a0
00346A  tst.b  $9(a1)
00346E  lea.l  $208(a0), a1
003472  bpl.b  $3476
003474  exg.l  a0, a1
003476  lea.l  $0.l, a5
00347C  movea.l $c(a5), a2
003480  mulu.w #$60, d5
003484  adda.l d5, a2
003486  moveq  #$ff, d4
003488  moveq  #$0, d5
00348A  lea.l  $318dc.l, a5
003490  move.l a7, $5354.l
003496  movea.l a1, a7
003498  dbra   d6, $34a0
00349C  bra.w  $34cc
0034A0  moveq  #$0, d2
0034A2  move.w (a0)+, d2
0034A4  move.b (a7)+, d2
0034A6  moveq  #$fc, d3
0034A8  and.w  d2, d3
0034AA  move.l (a5, d3.l), d0
0034AE  add.w  d2, d2
0034B0  add.w  d2, d2
0034B2  move.l (a5, d2.l), d2
0034B6  lea.l  (a2, d0.w), a3
0034BA  lea.l  $60(a2), a2
0034BE  lea.l  $20(a3), a4
0034C2  lea.l  $20(a4), a1
0034C6  swap   d0
0034C8  jmp    (a6, d0.w)
0034CC  movea.l $5354.l, a7
0034D2  rts    
0034D4  dbra   d6, $34a0
0034D8  bra.w  $34cc
0034DC  move.l d2, d3
0034DE  swap   d3
0034E0  and.w  d3, d2
0034E2  not.w  d2
0034E4  and.w  d2, (a3)+
0034E6  and.w  d2, (a4)+
0034E8  and.w  d2, (a1)+
0034EA  dbra   d6, $34a0
0034EE  bra.w  $34cc
0034F2  swap   d2
0034F4  not.l  d2
0034F6  and.l  d2, (a3)+
0034F8  and.l  d2, (a4)+
0034FA  and.l  d2, (a1)+
0034FC  dbra   d6, $34a0
003500  bra.w  $34cc
003504  not.w  d2
003506  and.w  d2, (a3)+
003508  and.w  d2, (a4)+
00350A  and.w  d2, (a1)+
00350C  move.w d5, (a3)+
00350E  move.w d5, (a4)+
003510  move.w d5, (a1)+
003512  swap   d2
003514  not.w  d2
003516  and.w  d2, (a3)+
003518  and.w  d2, (a4)+
00351A  and.w  d2, (a1)+
00351C  dbra   d6, $34a0
003520  bra.w  $34cc
003524  not.w  d2
003526  and.w  d2, (a3)+
003528  and.w  d2, (a4)+
00352A  and.w  d2, (a1)+
00352C  move.l d5, (a3)+
00352E  move.l d5, (a4)+
003530  move.l d5, (a1)+
003532  swap   d2
003534  not.w  d2
003536  and.w  d2, (a3)+
003538  and.w  d2, (a4)+
00353A  and.w  d2, (a1)+
00353C  dbra   d6, $34a0
003540  bra.w  $34cc
003544  not.w  d2
003546  and.w  d2, (a3)+
003548  and.w  d2, (a4)+
00354A  and.w  d2, (a1)+
00354C  move.l d5, (a3)+
00354E  move.l d5, (a4)+
003550  move.l d5, (a1)+
003552  move.w d5, (a3)+
003554  move.w d5, (a4)+
003556  move.w d5, (a1)+
003558  swap   d2
00355A  not.w  d2
00355C  and.w  d2, (a3)+
00355E  and.w  d2, (a4)+
003560  and.w  d2, (a1)+
003562  dbra   d6, $34a0
003566  bra.w  $34cc
00356A  not.w  d2
00356C  and.w  d2, (a3)+
00356E  and.w  d2, (a4)+
003570  and.w  d2, (a1)+
003572  move.l d5, (a3)+
003574  move.l d5, (a4)+
003576  move.l d5, (a1)+
003578  move.l d5, (a3)+
00357A  move.l d5, (a4)+
00357C  move.l d5, (a1)+
00357E  swap   d2
003580  not.w  d2
003582  and.w  d2, (a3)+
003584  and.w  d2, (a4)+
003586  and.w  d2, (a1)+
003588  dbra   d6, $34a0
00358C  bra.w  $34cc
003590  not.w  d2
003592  and.w  d2, (a3)+
003594  and.w  d2, (a4)+
003596  and.w  d2, (a1)+
003598  move.w d5, (a3)+
00359A  move.w d5, (a4)+
00359C  move.w d5, (a1)+
00359E  move.l d5, (a3)+
0035A0  move.l d5, (a4)+
0035A2  move.l d5, (a1)+
0035A4  move.l d5, (a3)+
0035A6  move.l d5, (a4)+
0035A8  move.l d5, (a1)+
0035AA  swap   d2
0035AC  not.w  d2
0035AE  and.w  d2, (a3)+
0035B0  and.w  d2, (a4)+
0035B2  and.w  d2, (a1)+
0035B4  dbra   d6, $34a0
0035B8  bra.w  $34cc
0035BC  not.w  d2
0035BE  and.w  d2, (a3)+
0035C0  and.w  d2, (a4)+
0035C2  and.w  d2, (a1)+
0035C4  move.l d5, (a3)+
0035C6  move.l d5, (a4)+
0035C8  move.l d5, (a1)+
0035CA  move.l d5, (a3)+
0035CC  move.l d5, (a4)+
0035CE  move.l d5, (a1)+
0035D0  move.l d5, (a3)+
0035D2  move.l d5, (a4)+
0035D4  move.l d5, (a1)+
0035D6  swap   d2
0035D8  not.w  d2
0035DA  and.w  d2, (a3)+
0035DC  and.w  d2, (a4)+
0035DE  and.w  d2, (a1)+
0035E0  dbra   d6, $34a0
0035E4  bra.w  $34cc
0035E8  not.w  d2
0035EA  and.w  d2, (a3)+
0035EC  and.w  d2, (a4)+
0035EE  and.w  d2, (a1)+
0035F0  move.w d5, (a3)+
0035F2  move.w d5, (a4)+
0035F4  move.w d5, (a1)+
0035F6  move.l d5, (a3)+
0035F8  move.l d5, (a4)+
0035FA  move.l d5, (a1)+
0035FC  move.l d5, (a3)+
0035FE  move.l d5, (a4)+
003600  move.l d5, (a1)+
003602  move.l d5, (a3)+
003604  move.l d5, (a4)+
003606  move.l d5, (a1)+
003608  swap   d2
00360A  not.w  d2
00360C  and.w  d2, (a3)+
00360E  and.w  d2, (a4)+
003610  and.w  d2, (a1)+
003612  dbra   d6, $34a0
003616  bra.w  $34cc
00361A  not.w  d2
00361C  and.w  d2, (a3)+
00361E  and.w  d2, (a4)+
003620  and.w  d2, (a1)+
003622  move.l d5, (a3)+
003624  move.l d5, (a4)+
003626  move.l d5, (a1)+
003628  move.l d5, (a3)+
00362A  move.l d5, (a4)+
00362C  move.l d5, (a1)+
00362E  move.l d5, (a3)+
003630  move.l d5, (a4)+
003632  move.l d5, (a1)+
003634  move.l d5, (a3)+
003636  move.l d5, (a4)+
003638  move.l d5, (a1)+
00363A  swap   d2
00363C  not.w  d2
00363E  and.w  d2, (a3)+
003640  and.w  d2, (a4)+
003642  and.w  d2, (a1)+
003644  dbra   d6, $34a0
003648  bra.w  $34cc
00364C  not.w  d2
00364E  and.w  d2, (a3)+
003650  and.w  d2, (a4)+
003652  and.w  d2, (a1)+
003654  move.w d5, (a3)+
003656  move.w d5, (a4)+
003658  move.w d5, (a1)+
00365A  move.l d5, (a3)+
00365C  move.l d5, (a4)+
00365E  move.l d5, (a1)+
003660  move.l d5, (a3)+
003662  move.l d5, (a4)+
003664  move.l d5, (a1)+
003666  move.l d5, (a3)+
003668  move.l d5, (a4)+
00366A  move.l d5, (a1)+
00366C  move.l d5, (a3)+
00366E  move.l d5, (a4)+
003670  move.l d5, (a1)+
003672  swap   d2
003674  not.w  d2
003676  and.w  d2, (a3)+
003678  and.w  d2, (a4)+
00367A  and.w  d2, (a1)+
00367C  dbra   d6, $34a0
003680  bra.w  $34cc
003684  not.w  d2
003686  and.w  d2, (a3)+
003688  and.w  d2, (a4)+
00368A  and.w  d2, (a1)+
00368C  move.l d5, (a3)+
00368E  move.l d5, (a4)+
003690  move.l d5, (a1)+
003692  move.l d5, (a3)+
003694  move.l d5, (a4)+
003696  move.l d5, (a1)+
003698  move.l d5, (a3)+
00369A  move.l d5, (a4)+
00369C  move.l d5, (a1)+
00369E  move.l d5, (a3)+
0036A0  move.l d5, (a4)+
0036A2  move.l d5, (a1)+
0036A4  move.l d5, (a3)+
0036A6  move.l d5, (a4)+
0036A8  move.l d5, (a1)+
0036AA  swap   d2
0036AC  not.w  d2
0036AE  and.w  d2, (a3)+
0036B0  and.w  d2, (a4)+
0036B2  and.w  d2, (a1)+
0036B4  dbra   d6, $34a0
0036B8  bra.w  $34cc
0036BC  not.w  d2
0036BE  and.w  d2, (a3)+
0036C0  and.w  d2, (a4)+
0036C2  and.w  d2, (a1)+
0036C4  move.w d5, (a3)+
0036C6  move.w d5, (a4)+
0036C8  move.w d5, (a1)+
0036CA  move.l d5, (a3)+
0036CC  move.l d5, (a4)+
0036CE  move.l d5, (a1)+
0036D0  move.l d5, (a3)+
0036D2  move.l d5, (a4)+
0036D4  move.l d5, (a1)+
0036D6  move.l d5, (a3)+
0036D8  move.l d5, (a4)+
0036DA  move.l d5, (a1)+
0036DC  move.l d5, (a3)+
0036DE  move.l d5, (a4)+
0036E0  move.l d5, (a1)+
0036E2  move.l d5, (a3)+
0036E4  move.l d5, (a4)+
0036E6  move.l d5, (a1)+
0036E8  swap   d2
0036EA  not.w  d2
0036EC  and.w  d2, (a3)+
0036EE  and.w  d2, (a4)+
0036F0  and.w  d2, (a1)+
0036F2  dbra   d6, $34a0
0036F6  bra.w  $34cc
0036FA  not.w  d2
0036FC  and.w  d2, (a3)+
0036FE  and.w  d2, (a4)+
003700  and.w  d2, (a1)+
003702  move.l d5, (a3)+
003704  move.l d5, (a4)+
003706  move.l d5, (a1)+
003708  move.l d5, (a3)+
00370A  move.l d5, (a4)+
00370C  move.l d5, (a1)+
00370E  move.l d5, (a3)+
003710  move.l d5, (a4)+
003712  move.l d5, (a1)+
003714  move.l d5, (a3)+
003716  move.l d5, (a4)+
003718  move.l d5, (a1)+
00371A  move.l d5, (a3)+
00371C  move.l d5, (a4)+
00371E  move.l d5, (a1)+
003720  move.l d5, (a3)+
003722  move.l d5, (a4)+
003724  move.l d5, (a1)+
003726  swap   d2
003728  not.w  d2
00372A  and.w  d2, (a3)+
00372C  and.w  d2, (a4)+
00372E  and.w  d2, (a1)+
003730  dbra   d6, $34a0
003734  bra.w  $34cc
003738  not.w  d2
00373A  and.w  d2, (a3)+
00373C  and.w  d2, (a4)+
00373E  and.w  d2, (a1)+
003740  move.w d5, (a3)+
003742  move.w d5, (a4)+
003744  move.w d5, (a1)+
003746  move.l d5, (a3)+
003748  move.l d5, (a4)+
00374A  move.l d5, (a1)+
00374C  move.l d5, (a3)+
00374E  move.l d5, (a4)+
003750  move.l d5, (a1)+
003752  move.l d5, (a3)+
003754  move.l d5, (a4)+
003756  move.l d5, (a1)+
003758  move.l d5, (a3)+
00375A  move.l d5, (a4)+
00375C  move.l d5, (a1)+
00375E  move.l d5, (a3)+
003760  move.l d5, (a4)+
003762  move.l d5, (a1)+
003764  move.l d5, (a3)+
003766  move.l d5, (a4)+
003768  move.l d5, (a1)+
00376A  swap   d2
00376C  not.w  d2
00376E  and.w  d2, (a3)+
003770  and.w  d2, (a4)+
003772  and.w  d2, (a1)+
003774  dbra   d6, $34a0
003778  bra.w  $34cc
00377C  not.w  d2
00377E  and.w  d2, (a3)+
003780  and.w  d2, (a4)+
003782  and.w  d2, (a1)+
003784  move.l d5, (a3)+
003786  move.l d5, (a4)+
003788  move.l d5, (a1)+
00378A  move.l d5, (a3)+
00378C  move.l d5, (a4)+
00378E  move.l d5, (a1)+
003790  move.l d5, (a3)+
003792  move.l d5, (a4)+
003794  move.l d5, (a1)+
003796  move.l d5, (a3)+
003798  move.l d5, (a4)+
00379A  move.l d5, (a1)+
00379C  move.l d5, (a3)+
00379E  move.l d5, (a4)+
0037A0  move.l d5, (a1)+
0037A2  move.l d5, (a3)+
0037A4  move.l d5, (a4)+
0037A6  move.l d5, (a1)+
0037A8  move.l d5, (a3)+
0037AA  move.l d5, (a4)+
0037AC  move.l d5, (a1)+
0037AE  swap   d2
0037B0  not.w  d2
0037B2  and.w  d2, (a3)+
0037B4  and.w  d2, (a4)+
0037B6  and.w  d2, (a1)+
0037B8  dbra   d6, $34a0
0037BC  bra.w  $34cc
0037C0  not.w  d2
0037C2  and.w  d2, (a3)+
0037C4  and.w  d2, (a4)+
0037C6  and.w  d2, (a1)+
0037C8  move.w d5, (a3)+
0037CA  move.w d5, (a4)+
0037CC  move.w d5, (a1)+
0037CE  move.l d5, (a3)+
0037D0  move.l d5, (a4)+
0037D2  move.l d5, (a1)+
0037D4  move.l d5, (a3)+
0037D6  move.l d5, (a4)+
0037D8  move.l d5, (a1)+
0037DA  move.l d5, (a3)+
0037DC  move.l d5, (a4)+
0037DE  move.l d5, (a1)+
0037E0  move.l d5, (a3)+
0037E2  move.l d5, (a4)+
0037E4  move.l d5, (a1)+
0037E6  move.l d5, (a3)+
0037E8  move.l d5, (a4)+
0037EA  move.l d5, (a1)+
0037EC  move.l d5, (a3)+
0037EE  move.l d5, (a4)+
0037F0  move.l d5, (a1)+
0037F2  move.l d5, (a3)+
0037F4  move.l d5, (a4)+
0037F6  move.l d5, (a1)+
0037F8  swap   d2
0037FA  not.w  d2
0037FC  and.w  d2, (a3)+
0037FE  and.w  d2, (a4)+
003800  and.w  d2, (a1)+
003802  dbra   d6, $34a0
003806  bra.w  $34cc
00380A  not.w  d2
00380C  and.w  d2, (a3)+
00380E  and.w  d2, (a4)+
003810  and.w  d2, (a1)+
003812  move.l d5, (a3)+
003814  move.l d5, (a4)+
003816  move.l d5, (a1)+
003818  move.l d5, (a3)+
00381A  move.l d5, (a4)+
00381C  move.l d5, (a1)+
00381E  move.l d5, (a3)+
003820  move.l d5, (a4)+
003822  move.l d5, (a1)+
003824  move.l d5, (a3)+
003826  move.l d5, (a4)+
003828  move.l d5, (a1)+
00382A  move.l d5, (a3)+
00382C  move.l d5, (a4)+
00382E  move.l d5, (a1)+
003830  move.l d5, (a3)+
003832  move.l d5, (a4)+
003834  move.l d5, (a1)+
003836  move.l d5, (a3)+
003838  move.l d5, (a4)+
00383A  move.l d5, (a1)+
00383C  move.l d5, (a3)+
00383E  move.l d5, (a4)+
003840  move.l d5, (a1)+
003842  swap   d2
003844  not.w  d2
003846  and.w  d2, (a3)+
003848  and.w  d2, (a4)+
00384A  and.w  d2, (a1)+
00384C  dbra   d6, $34a0
003850  bra.w  $34cc
003854  not.w  d2
003856  and.w  d2, (a3)+
003858  and.w  d2, (a4)+
00385A  and.w  d2, (a1)+
00385C  move.w d5, (a3)+
00385E  move.w d5, (a4)+
003860  move.w d5, (a1)+
003862  move.l d5, (a3)+
003864  move.l d5, (a4)+
003866  move.l d5, (a1)+
003868  move.l d5, (a3)+
00386A  move.l d5, (a4)+
00386C  move.l d5, (a1)+
00386E  move.l d5, (a3)+
003870  move.l d5, (a4)+
003872  move.l d5, (a1)+
003874  move.l d5, (a3)+
003876  move.l d5, (a4)+
003878  move.l d5, (a1)+
00387A  move.l d5, (a3)+
00387C  move.l d5, (a4)+
00387E  move.l d5, (a1)+
003880  move.l d5, (a3)+
003882  move.l d5, (a4)+
003884  move.l d5, (a1)+
003886  move.l d5, (a3)+
003888  move.l d5, (a4)+
00388A  move.l d5, (a1)+
00388C  move.l d5, (a3)+
00388E  move.l d5, (a4)+
003890  move.l d5, (a1)+
003892  swap   d2
003894  not.w  d2
003896  and.w  d2, (a3)+
003898  and.w  d2, (a4)+
00389A  and.w  d2, (a1)+
00389C  dbra   d6, $34a0
0038A0  bra.w  $34cc
0038A4  dbra   d6, $34a0
0038A8  bra.w  $34cc
0038AC  move.l d2, d3
0038AE  swap   d3
0038B0  and.w  d3, d2
0038B2  or.w   d2, (a3)+
0038B4  not.w  d2
0038B6  and.w  d2, (a4)+
0038B8  and.w  d2, (a1)+
0038BA  dbra   d6, $34a0
0038BE  bra.w  $34cc
0038C2  swap   d2
0038C4  or.l   d2, (a3)+
0038C6  not.l  d2
0038C8  and.l  d2, (a4)+
0038CA  and.l  d2, (a1)+
0038CC  dbra   d6, $34a0
0038D0  bra.w  $34cc
0038D4  or.w   d2, (a3)+
0038D6  not.w  d2
0038D8  and.w  d2, (a4)+
0038DA  and.w  d2, (a1)+
0038DC  move.w d4, (a3)+
0038DE  move.w d5, (a4)+
0038E0  move.w d5, (a1)+
0038E2  swap   d2
0038E4  or.w   d2, (a3)+
0038E6  not.w  d2
0038E8  and.w  d2, (a4)+
0038EA  and.w  d2, (a1)+
0038EC  dbra   d6, $34a0
0038F0  bra.w  $34cc
0038F4  or.w   d2, (a3)+
0038F6  not.w  d2
0038F8  and.w  d2, (a4)+
0038FA  and.w  d2, (a1)+
0038FC  move.l d4, (a3)+
0038FE  move.l d5, (a4)+
003900  move.l d5, (a1)+
003902  swap   d2
003904  or.w   d2, (a3)+
003906  not.w  d2
003908  and.w  d2, (a4)+
00390A  and.w  d2, (a1)+
00390C  dbra   d6, $34a0
003910  bra.w  $34cc
003914  or.w   d2, (a3)+
003916  not.w  d2
003918  and.w  d2, (a4)+
00391A  and.w  d2, (a1)+
00391C  move.l d4, (a3)+
00391E  move.l d5, (a4)+
003920  move.l d5, (a1)+
003922  move.w d4, (a3)+
003924  move.w d5, (a4)+
003926  move.w d5, (a1)+
003928  swap   d2
00392A  or.w   d2, (a3)+
00392C  not.w  d2
00392E  and.w  d2, (a4)+
003930  and.w  d2, (a1)+
003932  dbra   d6, $34a0
003936  bra.w  $34cc
00393A  or.w   d2, (a3)+
00393C  not.w  d2
00393E  and.w  d2, (a4)+
003940  and.w  d2, (a1)+
003942  move.l d4, (a3)+
003944  move.l d5, (a4)+
003946  move.l d5, (a1)+
003948  move.l d4, (a3)+
00394A  move.l d5, (a4)+
00394C  move.l d5, (a1)+
00394E  swap   d2
003950  or.w   d2, (a3)+
003952  not.w  d2
003954  and.w  d2, (a4)+
003956  and.w  d2, (a1)+
003958  dbra   d6, $34a0
00395C  bra.w  $34cc
003960  or.w   d2, (a3)+
003962  not.w  d2
003964  and.w  d2, (a4)+
003966  and.w  d2, (a1)+
003968  move.w d4, (a3)+
00396A  move.w d5, (a4)+
00396C  move.w d5, (a1)+
00396E  move.l d4, (a3)+
003970  move.l d5, (a4)+
003972  move.l d5, (a1)+
003974  move.l d4, (a3)+
003976  move.l d5, (a4)+
003978  move.l d5, (a1)+
00397A  swap   d2
00397C  or.w   d2, (a3)+
00397E  not.w  d2
003980  and.w  d2, (a4)+
003982  and.w  d2, (a1)+
003984  dbra   d6, $34a0
003988  bra.w  $34cc
00398C  or.w   d2, (a3)+
00398E  not.w  d2
003990  and.w  d2, (a4)+
003992  and.w  d2, (a1)+
003994  move.l d4, (a3)+
003996  move.l d5, (a4)+
003998  move.l d5, (a1)+
00399A  move.l d4, (a3)+
00399C  move.l d5, (a4)+
00399E  move.l d5, (a1)+
0039A0  move.l d4, (a3)+
0039A2  move.l d5, (a4)+
0039A4  move.l d5, (a1)+
0039A6  swap   d2
0039A8  or.w   d2, (a3)+
0039AA  not.w  d2
0039AC  and.w  d2, (a4)+
0039AE  and.w  d2, (a1)+
0039B0  dbra   d6, $34a0
0039B4  bra.w  $34cc
0039B8  or.w   d2, (a3)+
0039BA  not.w  d2
0039BC  and.w  d2, (a4)+
0039BE  and.w  d2, (a1)+
0039C0  move.w d4, (a3)+
0039C2  move.w d5, (a4)+
0039C4  move.w d5, (a1)+
0039C6  move.l d4, (a3)+
0039C8  move.l d5, (a4)+
0039CA  move.l d5, (a1)+
0039CC  move.l d4, (a3)+
0039CE  move.l d5, (a4)+
0039D0  move.l d5, (a1)+
0039D2  move.l d4, (a3)+
0039D4  move.l d5, (a4)+
0039D6  move.l d5, (a1)+
0039D8  swap   d2
0039DA  or.w   d2, (a3)+
0039DC  not.w  d2
0039DE  and.w  d2, (a4)+
0039E0  and.w  d2, (a1)+
0039E2  dbra   d6, $34a0
0039E6  bra.w  $34cc
0039EA  or.w   d2, (a3)+
0039EC  not.w  d2
0039EE  and.w  d2, (a4)+
0039F0  and.w  d2, (a1)+
0039F2  move.l d4, (a3)+
0039F4  move.l d5, (a4)+
0039F6  move.l d5, (a1)+
0039F8  move.l d4, (a3)+
0039FA  move.l d5, (a4)+
0039FC  move.l d5, (a1)+
0039FE  move.l d4, (a3)+
003A00  move.l d5, (a4)+
003A02  move.l d5, (a1)+
003A04  move.l d4, (a3)+
003A06  move.l d5, (a4)+
003A08  move.l d5, (a1)+
003A0A  swap   d2
003A0C  or.w   d2, (a3)+
003A0E  not.w  d2
003A10  and.w  d2, (a4)+
003A12  and.w  d2, (a1)+
003A14  dbra   d6, $34a0
003A18  bra.w  $34cc
003A1C  or.w   d2, (a3)+
003A1E  not.w  d2
003A20  and.w  d2, (a4)+
003A22  and.w  d2, (a1)+
003A24  move.w d4, (a3)+
003A26  move.w d5, (a4)+
003A28  move.w d5, (a1)+
003A2A  move.l d4, (a3)+
003A2C  move.l d5, (a4)+
003A2E  move.l d5, (a1)+
003A30  move.l d4, (a3)+
003A32  move.l d5, (a4)+
003A34  move.l d5, (a1)+
003A36  move.l d4, (a3)+
003A38  move.l d5, (a4)+
003A3A  move.l d5, (a1)+
003A3C  move.l d4, (a3)+
003A3E  move.l d5, (a4)+
003A40  move.l d5, (a1)+
003A42  swap   d2
003A44  or.w   d2, (a3)+
003A46  not.w  d2
003A48  and.w  d2, (a4)+
003A4A  and.w  d2, (a1)+
003A4C  dbra   d6, $34a0
003A50  bra.w  $34cc
003A54  or.w   d2, (a3)+
003A56  not.w  d2
003A58  and.w  d2, (a4)+
003A5A  and.w  d2, (a1)+
003A5C  move.l d4, (a3)+
003A5E  move.l d5, (a4)+
003A60  move.l d5, (a1)+
003A62  move.l d4, (a3)+
003A64  move.l d5, (a4)+
003A66  move.l d5, (a1)+
003A68  move.l d4, (a3)+
003A6A  move.l d5, (a4)+
003A6C  move.l d5, (a1)+
003A6E  move.l d4, (a3)+
003A70  move.l d5, (a4)+
003A72  move.l d5, (a1)+
003A74  move.l d4, (a3)+
003A76  move.l d5, (a4)+
003A78  move.l d5, (a1)+
003A7A  swap   d2
003A7C  or.w   d2, (a3)+
003A7E  not.w  d2
003A80  and.w  d2, (a4)+
003A82  and.w  d2, (a1)+
003A84  dbra   d6, $34a0
003A88  bra.w  $34cc
003A8C  or.w   d2, (a3)+
003A8E  not.w  d2
003A90  and.w  d2, (a4)+
003A92  and.w  d2, (a1)+
003A94  move.w d4, (a3)+
003A96  move.w d5, (a4)+
003A98  move.w d5, (a1)+
003A9A  move.l d4, (a3)+
003A9C  move.l d5, (a4)+
003A9E  move.l d5, (a1)+
003AA0  move.l d4, (a3)+
003AA2  move.l d5, (a4)+
003AA4  move.l d5, (a1)+
003AA6  move.l d4, (a3)+
003AA8  move.l d5, (a4)+
003AAA  move.l d5, (a1)+
003AAC  move.l d4, (a3)+
003AAE  move.l d5, (a4)+
003AB0  move.l d5, (a1)+
003AB2  move.l d4, (a3)+
003AB4  move.l d5, (a4)+
003AB6  move.l d5, (a1)+
003AB8  swap   d2
003ABA  or.w   d2, (a3)+
003ABC  not.w  d2
003ABE  and.w  d2, (a4)+
003AC0  and.w  d2, (a1)+
003AC2  dbra   d6, $34a0
003AC6  bra.w  $34cc
003ACA  or.w   d2, (a3)+
003ACC  not.w  d2
003ACE  and.w  d2, (a4)+
003AD0  and.w  d2, (a1)+
003AD2  move.l d4, (a3)+
003AD4  move.l d5, (a4)+
003AD6  move.l d5, (a1)+
003AD8  move.l d4, (a3)+
003ADA  move.l d5, (a4)+
003ADC  move.l d5, (a1)+
003ADE  move.l d4, (a3)+
003AE0  move.l d5, (a4)+
003AE2  move.l d5, (a1)+
003AE4  move.l d4, (a3)+
003AE6  move.l d5, (a4)+
003AE8  move.l d5, (a1)+
003AEA  move.l d4, (a3)+
003AEC  move.l d5, (a4)+
003AEE  move.l d5, (a1)+
003AF0  move.l d4, (a3)+
003AF2  move.l d5, (a4)+
003AF4  move.l d5, (a1)+
003AF6  swap   d2
003AF8  or.w   d2, (a3)+
003AFA  not.w  d2
003AFC  and.w  d2, (a4)+
003AFE  and.w  d2, (a1)+
003B00  dbra   d6, $34a0
003B04  bra.w  $34cc
003B08  or.w   d2, (a3)+
003B0A  not.w  d2
003B0C  and.w  d2, (a4)+
003B0E  and.w  d2, (a1)+
003B10  move.w d4, (a3)+
003B12  move.w d5, (a4)+
003B14  move.w d5, (a1)+
003B16  move.l d4, (a3)+
003B18  move.l d5, (a4)+
003B1A  move.l d5, (a1)+
003B1C  move.l d4, (a3)+
003B1E  move.l d5, (a4)+
003B20  move.l d5, (a1)+
003B22  move.l d4, (a3)+
003B24  move.l d5, (a4)+
003B26  move.l d5, (a1)+
003B28  move.l d4, (a3)+
003B2A  move.l d5, (a4)+
003B2C  move.l d5, (a1)+
003B2E  move.l d4, (a3)+
003B30  move.l d5, (a4)+
003B32  move.l d5, (a1)+
003B34  move.l d4, (a3)+
003B36  move.l d5, (a4)+
003B38  move.l d5, (a1)+
003B3A  swap   d2
003B3C  or.w   d2, (a3)+
003B3E  not.w  d2
003B40  and.w  d2, (a4)+
003B42  and.w  d2, (a1)+
003B44  dbra   d6, $34a0
003B48  bra.w  $34cc
003B4C  or.w   d2, (a3)+
003B4E  not.w  d2
003B50  and.w  d2, (a4)+
003B52  and.w  d2, (a1)+
003B54  move.l d4, (a3)+
003B56  move.l d5, (a4)+
003B58  move.l d5, (a1)+
003B5A  move.l d4, (a3)+
003B5C  move.l d5, (a4)+
003B5E  move.l d5, (a1)+
003B60  move.l d4, (a3)+
003B62  move.l d5, (a4)+
003B64  move.l d5, (a1)+
003B66  move.l d4, (a3)+
003B68  move.l d5, (a4)+
003B6A  move.l d5, (a1)+
003B6C  move.l d4, (a3)+
003B6E  move.l d5, (a4)+
003B70  move.l d5, (a1)+
003B72  move.l d4, (a3)+
003B74  move.l d5, (a4)+
003B76  move.l d5, (a1)+
003B78  move.l d4, (a3)+
003B7A  move.l d5, (a4)+
003B7C  move.l d5, (a1)+
003B7E  swap   d2
003B80  or.w   d2, (a3)+
003B82  not.w  d2
003B84  and.w  d2, (a4)+
003B86  and.w  d2, (a1)+
003B88  dbra   d6, $34a0
003B8C  bra.w  $34cc
003B90  or.w   d2, (a3)+
003B92  not.w  d2
003B94  and.w  d2, (a4)+
003B96  and.w  d2, (a1)+
003B98  move.w d4, (a3)+
003B9A  move.w d5, (a4)+
003B9C  move.w d5, (a1)+
003B9E  move.l d4, (a3)+
003BA0  move.l d5, (a4)+
003BA2  move.l d5, (a1)+
003BA4  move.l d4, (a3)+
003BA6  move.l d5, (a4)+
003BA8  move.l d5, (a1)+
003BAA  move.l d4, (a3)+
003BAC  move.l d5, (a4)+
003BAE  move.l d5, (a1)+
003BB0  move.l d4, (a3)+
003BB2  move.l d5, (a4)+
003BB4  move.l d5, (a1)+
003BB6  move.l d4, (a3)+
003BB8  move.l d5, (a4)+
003BBA  move.l d5, (a1)+
003BBC  move.l d4, (a3)+
003BBE  move.l d5, (a4)+
003BC0  move.l d5, (a1)+
003BC2  move.l d4, (a3)+
003BC4  move.l d5, (a4)+
003BC6  move.l d5, (a1)+
003BC8  swap   d2
003BCA  or.w   d2, (a3)+
003BCC  not.w  d2
003BCE  and.w  d2, (a4)+
003BD0  and.w  d2, (a1)+
003BD2  dbra   d6, $34a0
003BD6  bra.w  $34cc
003BDA  or.w   d2, (a3)+
003BDC  not.w  d2
003BDE  and.w  d2, (a4)+
003BE0  and.w  d2, (a1)+
003BE2  move.l d4, (a3)+
003BE4  move.l d5, (a4)+
003BE6  move.l d5, (a1)+
003BE8  move.l d4, (a3)+
003BEA  move.l d5, (a4)+
003BEC  move.l d5, (a1)+
003BEE  move.l d4, (a3)+
003BF0  move.l d5, (a4)+
003BF2  move.l d5, (a1)+
003BF4  move.l d4, (a3)+
003BF6  move.l d5, (a4)+
003BF8  move.l d5, (a1)+
003BFA  move.l d4, (a3)+
003BFC  move.l d5, (a4)+
003BFE  move.l d5, (a1)+
003C00  move.l d4, (a3)+
003C02  move.l d5, (a4)+
003C04  move.l d5, (a1)+
003C06  move.l d4, (a3)+
003C08  move.l d5, (a4)+
003C0A  move.l d5, (a1)+
003C0C  move.l d4, (a3)+
003C0E  move.l d5, (a4)+
003C10  move.l d5, (a1)+
003C12  swap   d2
003C14  or.w   d2, (a3)+
003C16  not.w  d2
003C18  and.w  d2, (a4)+
003C1A  and.w  d2, (a1)+
003C1C  dbra   d6, $34a0
003C20  bra.w  $34cc
003C24  or.w   d2, (a3)+
003C26  not.w  d2
003C28  and.w  d2, (a4)+
003C2A  and.w  d2, (a1)+
003C2C  move.w d4, (a3)+
003C2E  move.w d5, (a4)+
003C30  move.w d5, (a1)+
003C32  move.l d4, (a3)+
003C34  move.l d5, (a4)+
003C36  move.l d5, (a1)+
003C38  move.l d4, (a3)+
003C3A  move.l d5, (a4)+
003C3C  move.l d5, (a1)+
003C3E  move.l d4, (a3)+
003C40  move.l d5, (a4)+
003C42  move.l d5, (a1)+
003C44  move.l d4, (a3)+
003C46  move.l d5, (a4)+
003C48  move.l d5, (a1)+
003C4A  move.l d4, (a3)+
003C4C  move.l d5, (a4)+
003C4E  move.l d5, (a1)+
003C50  move.l d4, (a3)+
003C52  move.l d5, (a4)+
003C54  move.l d5, (a1)+
003C56  move.l d4, (a3)+
003C58  move.l d5, (a4)+
003C5A  move.l d5, (a1)+
003C5C  move.l d4, (a3)+
003C5E  move.l d5, (a4)+
003C60  move.l d5, (a1)+
003C62  swap   d2
003C64  or.w   d2, (a3)+
003C66  not.w  d2
003C68  and.w  d2, (a4)+
003C6A  and.w  d2, (a1)+
003C6C  dbra   d6, $34a0
003C70  bra.w  $34cc
003C74  dbra   d6, $34a0
003C78  bra.w  $34cc
003C7C  move.l d2, d3
003C7E  swap   d3
003C80  and.w  d3, d2
003C82  or.w   d2, (a4)+
003C84  not.w  d2
003C86  and.w  d2, (a3)+
003C88  and.w  d2, (a1)+
003C8A  dbra   d6, $34a0
003C8E  bra.w  $34cc
003C92  swap   d2
003C94  or.l   d2, (a4)+
003C96  not.l  d2
003C98  and.l  d2, (a3)+
003C9A  and.l  d2, (a1)+
003C9C  dbra   d6, $34a0
003CA0  bra.w  $34cc
003CA4  or.w   d2, (a4)+
003CA6  not.w  d2
003CA8  and.w  d2, (a3)+
003CAA  and.w  d2, (a1)+
003CAC  move.w d5, (a3)+
003CAE  move.w d4, (a4)+
003CB0  move.w d5, (a1)+
003CB2  swap   d2
003CB4  or.w   d2, (a4)+
003CB6  not.w  d2
003CB8  and.w  d2, (a3)+
003CBA  and.w  d2, (a1)+
003CBC  dbra   d6, $34a0
003CC0  bra.w  $34cc
003CC4  or.w   d2, (a4)+
003CC6  not.w  d2
003CC8  and.w  d2, (a3)+
003CCA  and.w  d2, (a1)+
003CCC  move.l d5, (a3)+
003CCE  move.l d4, (a4)+
003CD0  move.l d5, (a1)+
003CD2  swap   d2
003CD4  or.w   d2, (a4)+
003CD6  not.w  d2
003CD8  and.w  d2, (a3)+
003CDA  and.w  d2, (a1)+
003CDC  dbra   d6, $34a0
003CE0  bra.w  $34cc
003CE4  or.w   d2, (a4)+
003CE6  not.w  d2
003CE8  and.w  d2, (a3)+
003CEA  and.w  d2, (a1)+
003CEC  move.l d5, (a3)+
003CEE  move.l d4, (a4)+
003CF0  move.l d5, (a1)+
003CF2  move.w d5, (a3)+
003CF4  move.w d4, (a4)+
003CF6  move.w d5, (a1)+
003CF8  swap   d2
003CFA  or.w   d2, (a4)+
003CFC  not.w  d2
003CFE  and.w  d2, (a3)+
003D00  and.w  d2, (a1)+
003D02  dbra   d6, $34a0
003D06  bra.w  $34cc
003D0A  or.w   d2, (a4)+
003D0C  not.w  d2
003D0E  and.w  d2, (a3)+
003D10  and.w  d2, (a1)+
003D12  move.l d5, (a3)+
003D14  move.l d4, (a4)+
003D16  move.l d5, (a1)+
003D18  move.l d5, (a3)+
003D1A  move.l d4, (a4)+
003D1C  move.l d5, (a1)+
003D1E  swap   d2
003D20  or.w   d2, (a4)+
003D22  not.w  d2
003D24  and.w  d2, (a3)+
003D26  and.w  d2, (a1)+
003D28  dbra   d6, $34a0
003D2C  bra.w  $34cc
003D30  or.w   d2, (a4)+
003D32  not.w  d2
003D34  and.w  d2, (a3)+
003D36  and.w  d2, (a1)+
003D38  move.w d5, (a3)+
003D3A  move.w d4, (a4)+
003D3C  move.w d5, (a1)+
003D3E  move.l d5, (a3)+
003D40  move.l d4, (a4)+
003D42  move.l d5, (a1)+
003D44  move.l d5, (a3)+
003D46  move.l d4, (a4)+
003D48  move.l d5, (a1)+
003D4A  swap   d2
003D4C  or.w   d2, (a4)+
003D4E  not.w  d2
003D50  and.w  d2, (a3)+
003D52  and.w  d2, (a1)+
003D54  dbra   d6, $34a0
003D58  bra.w  $34cc
003D5C  or.w   d2, (a4)+
003D5E  not.w  d2
003D60  and.w  d2, (a3)+
003D62  and.w  d2, (a1)+
003D64  move.l d5, (a3)+
003D66  move.l d4, (a4)+
003D68  move.l d5, (a1)+
003D6A  move.l d5, (a3)+
003D6C  move.l d4, (a4)+
003D6E  move.l d5, (a1)+
003D70  move.l d5, (a3)+
003D72  move.l d4, (a4)+
003D74  move.l d5, (a1)+
003D76  swap   d2
003D78  or.w   d2, (a4)+
003D7A  not.w  d2
003D7C  and.w  d2, (a3)+
003D7E  and.w  d2, (a1)+
003D80  dbra   d6, $34a0
003D84  bra.w  $34cc
003D88  or.w   d2, (a4)+
003D8A  not.w  d2
003D8C  and.w  d2, (a3)+
003D8E  and.w  d2, (a1)+
003D90  move.w d5, (a3)+
003D92  move.w d4, (a4)+
003D94  move.w d5, (a1)+
003D96  move.l d5, (a3)+
003D98  move.l d4, (a4)+
003D9A  move.l d5, (a1)+
003D9C  move.l d5, (a3)+
003D9E  move.l d4, (a4)+
003DA0  move.l d5, (a1)+
003DA2  move.l d5, (a3)+
003DA4  move.l d4, (a4)+
003DA6  move.l d5, (a1)+
003DA8  swap   d2
003DAA  or.w   d2, (a4)+
003DAC  not.w  d2
003DAE  and.w  d2, (a3)+
003DB0  and.w  d2, (a1)+
003DB2  dbra   d6, $34a0
003DB6  bra.w  $34cc
003DBA  or.w   d2, (a4)+
003DBC  not.w  d2
003DBE  and.w  d2, (a3)+
003DC0  and.w  d2, (a1)+
003DC2  move.l d5, (a3)+
003DC4  move.l d4, (a4)+
003DC6  move.l d5, (a1)+
003DC8  move.l d5, (a3)+
003DCA  move.l d4, (a4)+
003DCC  move.l d5, (a1)+
003DCE  move.l d5, (a3)+
003DD0  move.l d4, (a4)+
003DD2  move.l d5, (a1)+
003DD4  move.l d5, (a3)+
003DD6  move.l d4, (a4)+
003DD8  move.l d5, (a1)+
003DDA  swap   d2
003DDC  or.w   d2, (a4)+
003DDE  not.w  d2
003DE0  and.w  d2, (a3)+
003DE2  and.w  d2, (a1)+
003DE4  dbra   d6, $34a0
003DE8  bra.w  $34cc
003DEC  or.w   d2, (a4)+
003DEE  not.w  d2
003DF0  and.w  d2, (a3)+
003DF2  and.w  d2, (a1)+
003DF4  move.w d5, (a3)+
003DF6  move.w d4, (a4)+
003DF8  move.w d5, (a1)+
003DFA  move.l d5, (a3)+
003DFC  move.l d4, (a4)+
003DFE  move.l d5, (a1)+
003E00  move.l d5, (a3)+
003E02  move.l d4, (a4)+
003E04  move.l d5, (a1)+
003E06  move.l d5, (a3)+
003E08  move.l d4, (a4)+
003E0A  move.l d5, (a1)+
003E0C  move.l d5, (a3)+
003E0E  move.l d4, (a4)+
003E10  move.l d5, (a1)+
003E12  swap   d2
003E14  or.w   d2, (a4)+
003E16  not.w  d2
003E18  and.w  d2, (a3)+
003E1A  and.w  d2, (a1)+
003E1C  dbra   d6, $34a0
003E20  bra.w  $34cc
003E24  or.w   d2, (a4)+
003E26  not.w  d2
003E28  and.w  d2, (a3)+
003E2A  and.w  d2, (a1)+
003E2C  move.l d5, (a3)+
003E2E  move.l d4, (a4)+
003E30  move.l d5, (a1)+
003E32  move.l d5, (a3)+
003E34  move.l d4, (a4)+
003E36  move.l d5, (a1)+
003E38  move.l d5, (a3)+
003E3A  move.l d4, (a4)+
003E3C  move.l d5, (a1)+
003E3E  move.l d5, (a3)+
003E40  move.l d4, (a4)+
003E42  move.l d5, (a1)+
003E44  move.l d5, (a3)+
003E46  move.l d4, (a4)+
003E48  move.l d5, (a1)+
003E4A  swap   d2
003E4C  or.w   d2, (a4)+
003E4E  not.w  d2
003E50  and.w  d2, (a3)+
003E52  and.w  d2, (a1)+
003E54  dbra   d6, $34a0
003E58  bra.w  $34cc
003E5C  or.w   d2, (a4)+
003E5E  not.w  d2
003E60  and.w  d2, (a3)+
003E62  and.w  d2, (a1)+
003E64  move.w d5, (a3)+
003E66  move.w d4, (a4)+
003E68  move.w d5, (a1)+
003E6A  move.l d5, (a3)+
003E6C  move.l d4, (a4)+
003E6E  move.l d5, (a1)+
003E70  move.l d5, (a3)+
003E72  move.l d4, (a4)+
003E74  move.l d5, (a1)+
003E76  move.l d5, (a3)+
003E78  move.l d4, (a4)+
003E7A  move.l d5, (a1)+
003E7C  move.l d5, (a3)+
003E7E  move.l d4, (a4)+
003E80  move.l d5, (a1)+
003E82  move.l d5, (a3)+
003E84  move.l d4, (a4)+
003E86  move.l d5, (a1)+
003E88  swap   d2
003E8A  or.w   d2, (a4)+
003E8C  not.w  d2
003E8E  and.w  d2, (a3)+
003E90  and.w  d2, (a1)+
003E92  dbra   d6, $34a0
003E96  bra.w  $34cc
003E9A  or.w   d2, (a4)+
003E9C  not.w  d2
003E9E  and.w  d2, (a3)+
003EA0  and.w  d2, (a1)+
003EA2  move.l d5, (a3)+
003EA4  move.l d4, (a4)+
003EA6  move.l d5, (a1)+
003EA8  move.l d5, (a3)+
003EAA  move.l d4, (a4)+
003EAC  move.l d5, (a1)+
003EAE  move.l d5, (a3)+
003EB0  move.l d4, (a4)+
003EB2  move.l d5, (a1)+
003EB4  move.l d5, (a3)+
003EB6  move.l d4, (a4)+
003EB8  move.l d5, (a1)+
003EBA  move.l d5, (a3)+
003EBC  move.l d4, (a4)+
003EBE  move.l d5, (a1)+
003EC0  move.l d5, (a3)+
003EC2  move.l d4, (a4)+
003EC4  move.l d5, (a1)+
003EC6  swap   d2
003EC8  or.w   d2, (a4)+
003ECA  not.w  d2
003ECC  and.w  d2, (a3)+
003ECE  and.w  d2, (a1)+
003ED0  dbra   d6, $34a0
003ED4  bra.w  $34cc
003ED8  or.w   d2, (a4)+
003EDA  not.w  d2
003EDC  and.w  d2, (a3)+
003EDE  and.w  d2, (a1)+
003EE0  move.w d5, (a3)+
003EE2  move.w d4, (a4)+
003EE4  move.w d5, (a1)+
003EE6  move.l d5, (a3)+
003EE8  move.l d4, (a4)+
003EEA  move.l d5, (a1)+
003EEC  move.l d5, (a3)+
003EEE  move.l d4, (a4)+
003EF0  move.l d5, (a1)+
003EF2  move.l d5, (a3)+
003EF4  move.l d4, (a4)+
003EF6  move.l d5, (a1)+
003EF8  move.l d5, (a3)+
003EFA  move.l d4, (a4)+
003EFC  move.l d5, (a1)+
003EFE  move.l d5, (a3)+
003F00  move.l d4, (a4)+
003F02  move.l d5, (a1)+
003F04  move.l d5, (a3)+
003F06  move.l d4, (a4)+
003F08  move.l d5, (a1)+
003F0A  swap   d2
003F0C  or.w   d2, (a4)+
003F0E  not.w  d2
003F10  and.w  d2, (a3)+
003F12  and.w  d2, (a1)+
003F14  dbra   d6, $34a0
003F18  bra.w  $34cc
003F1C  or.w   d2, (a4)+
003F1E  not.w  d2
003F20  and.w  d2, (a3)+
003F22  and.w  d2, (a1)+
003F24  move.l d5, (a3)+
003F26  move.l d4, (a4)+
003F28  move.l d5, (a1)+
003F2A  move.l d5, (a3)+
003F2C  move.l d4, (a4)+
003F2E  move.l d5, (a1)+
003F30  move.l d5, (a3)+
003F32  move.l d4, (a4)+
003F34  move.l d5, (a1)+
003F36  move.l d5, (a3)+
003F38  move.l d4, (a4)+
003F3A  move.l d5, (a1)+
003F3C  move.l d5, (a3)+
003F3E  move.l d4, (a4)+
003F40  move.l d5, (a1)+
003F42  move.l d5, (a3)+
003F44  move.l d4, (a4)+
003F46  move.l d5, (a1)+
003F48  move.l d5, (a3)+
003F4A  move.l d4, (a4)+
003F4C  move.l d5, (a1)+
003F4E  swap   d2
003F50  or.w   d2, (a4)+
003F52  not.w  d2
003F54  and.w  d2, (a3)+
003F56  and.w  d2, (a1)+
003F58  dbra   d6, $34a0
003F5C  bra.w  $34cc
003F60  or.w   d2, (a4)+
003F62  not.w  d2
003F64  and.w  d2, (a3)+
003F66  and.w  d2, (a1)+
003F68  move.w d5, (a3)+
003F6A  move.w d4, (a4)+
003F6C  move.w d5, (a1)+
003F6E  move.l d5, (a3)+
003F70  move.l d4, (a4)+
003F72  move.l d5, (a1)+
003F74  move.l d5, (a3)+
003F76  move.l d4, (a4)+
003F78  move.l d5, (a1)+
003F7A  move.l d5, (a3)+
003F7C  move.l d4, (a4)+
003F7E  move.l d5, (a1)+
003F80  move.l d5, (a3)+
003F82  move.l d4, (a4)+
003F84  move.l d5, (a1)+
003F86  move.l d5, (a3)+
003F88  move.l d4, (a4)+
003F8A  move.l d5, (a1)+
003F8C  move.l d5, (a3)+
003F8E  move.l d4, (a4)+
003F90  move.l d5, (a1)+
003F92  move.l d5, (a3)+
003F94  move.l d4, (a4)+
003F96  move.l d5, (a1)+
003F98  swap   d2
003F9A  or.w   d2, (a4)+
003F9C  not.w  d2
003F9E  and.w  d2, (a3)+
003FA0  and.w  d2, (a1)+
003FA2  dbra   d6, $34a0
003FA6  bra.w  $34cc
003FAA  or.w   d2, (a4)+
003FAC  not.w  d2
003FAE  and.w  d2, (a3)+
003FB0  and.w  d2, (a1)+
003FB2  move.l d5, (a3)+
003FB4  move.l d4, (a4)+
003FB6  move.l d5, (a1)+
003FB8  move.l d5, (a3)+
003FBA  move.l d4, (a4)+
003FBC  move.l d5, (a1)+
003FBE  move.l d5, (a3)+
003FC0  move.l d4, (a4)+
003FC2  move.l d5, (a1)+
003FC4  move.l d5, (a3)+
003FC6  move.l d4, (a4)+
003FC8  move.l d5, (a1)+
003FCA  move.l d5, (a3)+
003FCC  move.l d4, (a4)+
003FCE  move.l d5, (a1)+
003FD0  move.l d5, (a3)+
003FD2  move.l d4, (a4)+
003FD4  move.l d5, (a1)+
003FD6  move.l d5, (a3)+
003FD8  move.l d4, (a4)+
003FDA  move.l d5, (a1)+
003FDC  move.l d5, (a3)+
003FDE  move.l d4, (a4)+
003FE0  move.l d5, (a1)+
003FE2  swap   d2
003FE4  or.w   d2, (a4)+
003FE6  not.w  d2
003FE8  and.w  d2, (a3)+
003FEA  and.w  d2, (a1)+
003FEC  dbra   d6, $34a0
003FF0  bra.w  $34cc
003FF4  or.w   d2, (a4)+
003FF6  not.w  d2
003FF8  and.w  d2, (a3)+
003FFA  and.w  d2, (a1)+
003FFC  move.w d5, (a3)+
003FFE  move.w d4, (a4)+
004000  move.w d5, (a1)+
004002  move.l d5, (a3)+
004004  move.l d4, (a4)+
004006  move.l d5, (a1)+
004008  move.l d5, (a3)+
00400A  move.l d4, (a4)+
00400C  move.l d5, (a1)+
00400E  move.l d5, (a3)+
004010  move.l d4, (a4)+
004012  move.l d5, (a1)+
004014  move.l d5, (a3)+
004016  move.l d4, (a4)+
004018  move.l d5, (a1)+
00401A  move.l d5, (a3)+
00401C  move.l d4, (a4)+
00401E  move.l d5, (a1)+
004020  move.l d5, (a3)+
004022  move.l d4, (a4)+
004024  move.l d5, (a1)+
004026  move.l d5, (a3)+
004028  move.l d4, (a4)+
00402A  move.l d5, (a1)+
00402C  move.l d5, (a3)+
00402E  move.l d4, (a4)+
004030  move.l d5, (a1)+
004032  swap   d2
004034  or.w   d2, (a4)+
004036  not.w  d2
004038  and.w  d2, (a3)+
00403A  and.w  d2, (a1)+
00403C  dbra   d6, $34a0
004040  bra.w  $34cc
004044  dbra   d6, $34a0
004048  bra.w  $34cc
00404C  move.l d2, d3
00404E  swap   d3
004050  and.w  d3, d2
004052  or.w   d2, (a3)+
004054  or.w   d2, (a4)+
004056  not.w  d2
004058  and.w  d2, (a1)+
00405A  dbra   d6, $34a0
00405E  bra.w  $34cc
004062  swap   d2
004064  or.l   d2, (a3)+
004066  or.l   d2, (a4)+
004068  not.l  d2
00406A  and.l  d2, (a1)+
00406C  dbra   d6, $34a0
004070  bra.w  $34cc
004074  or.w   d2, (a3)+
004076  or.w   d2, (a4)+
004078  not.w  d2
00407A  and.w  d2, (a1)+
00407C  move.w d4, (a3)+
00407E  move.w d4, (a4)+
004080  move.w d5, (a1)+
004082  swap   d2
004084  or.w   d2, (a3)+
004086  or.w   d2, (a4)+
004088  not.w  d2
00408A  and.w  d2, (a1)+
00408C  dbra   d6, $34a0
004090  bra.w  $34cc
004094  or.w   d2, (a3)+
004096  or.w   d2, (a4)+
004098  not.w  d2
00409A  and.w  d2, (a1)+
00409C  move.l d4, (a3)+
00409E  move.l d4, (a4)+
0040A0  move.l d5, (a1)+
0040A2  swap   d2
0040A4  or.w   d2, (a3)+
0040A6  or.w   d2, (a4)+
0040A8  not.w  d2
0040AA  and.w  d2, (a1)+
0040AC  dbra   d6, $34a0
0040B0  bra.w  $34cc
0040B4  or.w   d2, (a3)+
0040B6  or.w   d2, (a4)+
0040B8  not.w  d2
0040BA  and.w  d2, (a1)+
0040BC  move.l d4, (a3)+
0040BE  move.l d4, (a4)+
0040C0  move.l d5, (a1)+
0040C2  move.w d4, (a3)+
0040C4  move.w d4, (a4)+
0040C6  move.w d5, (a1)+
0040C8  swap   d2
0040CA  or.w   d2, (a3)+
0040CC  or.w   d2, (a4)+
0040CE  not.w  d2
0040D0  and.w  d2, (a1)+
0040D2  dbra   d6, $34a0
0040D6  bra.w  $34cc
0040DA  or.w   d2, (a3)+
0040DC  or.w   d2, (a4)+
0040DE  not.w  d2
0040E0  and.w  d2, (a1)+
0040E2  move.l d4, (a3)+
0040E4  move.l d4, (a4)+
0040E6  move.l d5, (a1)+
0040E8  move.l d4, (a3)+
0040EA  move.l d4, (a4)+
0040EC  move.l d5, (a1)+
0040EE  swap   d2
0040F0  or.w   d2, (a3)+
0040F2  or.w   d2, (a4)+
0040F4  not.w  d2
0040F6  and.w  d2, (a1)+
0040F8  dbra   d6, $34a0
0040FC  bra.w  $34cc
004100  or.w   d2, (a3)+
004102  or.w   d2, (a4)+
004104  not.w  d2
004106  and.w  d2, (a1)+
004108  move.w d4, (a3)+
00410A  move.w d4, (a4)+
00410C  move.w d5, (a1)+
00410E  move.l d4, (a3)+
004110  move.l d4, (a4)+
004112  move.l d5, (a1)+
004114  move.l d4, (a3)+
004116  move.l d4, (a4)+
004118  move.l d5, (a1)+
00411A  swap   d2
00411C  or.w   d2, (a3)+
00411E  or.w   d2, (a4)+
004120  not.w  d2
004122  and.w  d2, (a1)+
004124  dbra   d6, $34a0
004128  bra.w  $34cc
00412C  or.w   d2, (a3)+
00412E  or.w   d2, (a4)+
004130  not.w  d2
004132  and.w  d2, (a1)+
004134  move.l d4, (a3)+
004136  move.l d4, (a4)+
004138  move.l d5, (a1)+
00413A  move.l d4, (a3)+
00413C  move.l d4, (a4)+
00413E  move.l d5, (a1)+
004140  move.l d4, (a3)+
004142  move.l d4, (a4)+
004144  move.l d5, (a1)+
004146  swap   d2
004148  or.w   d2, (a3)+
00414A  or.w   d2, (a4)+
00414C  not.w  d2
00414E  and.w  d2, (a1)+
004150  dbra   d6, $34a0
004154  bra.w  $34cc
004158  or.w   d2, (a3)+
00415A  or.w   d2, (a4)+
00415C  not.w  d2
00415E  and.w  d2, (a1)+
004160  move.w d4, (a3)+
004162  move.w d4, (a4)+
004164  move.w d5, (a1)+
004166  move.l d4, (a3)+
004168  move.l d4, (a4)+
00416A  move.l d5, (a1)+
00416C  move.l d4, (a3)+
00416E  move.l d4, (a4)+
004170  move.l d5, (a1)+
004172  move.l d4, (a3)+
004174  move.l d4, (a4)+
004176  move.l d5, (a1)+
004178  swap   d2
00417A  or.w   d2, (a3)+
00417C  or.w   d2, (a4)+
00417E  not.w  d2
004180  and.w  d2, (a1)+
004182  dbra   d6, $34a0
004186  bra.w  $34cc
00418A  or.w   d2, (a3)+
00418C  or.w   d2, (a4)+
00418E  not.w  d2
004190  and.w  d2, (a1)+
004192  move.l d4, (a3)+
004194  move.l d4, (a4)+
004196  move.l d5, (a1)+
004198  move.l d4, (a3)+
00419A  move.l d4, (a4)+
00419C  move.l d5, (a1)+
00419E  move.l d4, (a3)+
0041A0  move.l d4, (a4)+
0041A2  move.l d5, (a1)+
0041A4  move.l d4, (a3)+
0041A6  move.l d4, (a4)+
0041A8  move.l d5, (a1)+
0041AA  swap   d2
0041AC  or.w   d2, (a3)+
0041AE  or.w   d2, (a4)+
0041B0  not.w  d2
0041B2  and.w  d2, (a1)+
0041B4  dbra   d6, $34a0
0041B8  bra.w  $34cc
0041BC  or.w   d2, (a3)+
0041BE  or.w   d2, (a4)+
0041C0  not.w  d2
0041C2  and.w  d2, (a1)+
0041C4  move.w d4, (a3)+
0041C6  move.w d4, (a4)+
0041C8  move.w d5, (a1)+
0041CA  move.l d4, (a3)+
0041CC  move.l d4, (a4)+
0041CE  move.l d5, (a1)+
0041D0  move.l d4, (a3)+
0041D2  move.l d4, (a4)+
0041D4  move.l d5, (a1)+
0041D6  move.l d4, (a3)+
0041D8  move.l d4, (a4)+
0041DA  move.l d5, (a1)+
0041DC  move.l d4, (a3)+
0041DE  move.l d4, (a4)+
0041E0  move.l d5, (a1)+
0041E2  swap   d2
0041E4  or.w   d2, (a3)+
0041E6  or.w   d2, (a4)+
0041E8  not.w  d2
0041EA  and.w  d2, (a1)+
0041EC  dbra   d6, $34a0
0041F0  bra.w  $34cc
0041F4  or.w   d2, (a3)+
0041F6  or.w   d2, (a4)+
0041F8  not.w  d2
0041FA  and.w  d2, (a1)+
0041FC  move.l d4, (a3)+
0041FE  move.l d4, (a4)+
004200  move.l d5, (a1)+
004202  move.l d4, (a3)+
004204  move.l d4, (a4)+
004206  move.l d5, (a1)+
004208  move.l d4, (a3)+
00420A  move.l d4, (a4)+
00420C  move.l d5, (a1)+
00420E  move.l d4, (a3)+
004210  move.l d4, (a4)+
004212  move.l d5, (a1)+
004214  move.l d4, (a3)+
004216  move.l d4, (a4)+
004218  move.l d5, (a1)+
00421A  swap   d2
00421C  or.w   d2, (a3)+
00421E  or.w   d2, (a4)+
004220  not.w  d2
004222  and.w  d2, (a1)+
004224  dbra   d6, $34a0
004228  bra.w  $34cc
00422C  or.w   d2, (a3)+
00422E  or.w   d2, (a4)+
004230  not.w  d2
004232  and.w  d2, (a1)+
004234  move.w d4, (a3)+
004236  move.w d4, (a4)+
004238  move.w d5, (a1)+
00423A  move.l d4, (a3)+
00423C  move.l d4, (a4)+
00423E  move.l d5, (a1)+
004240  move.l d4, (a3)+
004242  move.l d4, (a4)+
004244  move.l d5, (a1)+
004246  move.l d4, (a3)+
004248  move.l d4, (a4)+
00424A  move.l d5, (a1)+
00424C  move.l d4, (a3)+
00424E  move.l d4, (a4)+
004250  move.l d5, (a1)+
004252  move.l d4, (a3)+
004254  move.l d4, (a4)+
004256  move.l d5, (a1)+
004258  swap   d2
00425A  or.w   d2, (a3)+
00425C  or.w   d2, (a4)+
00425E  not.w  d2
004260  and.w  d2, (a1)+
004262  dbra   d6, $34a0
004266  bra.w  $34cc
00426A  or.w   d2, (a3)+
00426C  or.w   d2, (a4)+
00426E  not.w  d2
004270  and.w  d2, (a1)+
004272  move.l d4, (a3)+
004274  move.l d4, (a4)+
004276  move.l d5, (a1)+
004278  move.l d4, (a3)+
00427A  move.l d4, (a4)+
00427C  move.l d5, (a1)+
00427E  move.l d4, (a3)+
004280  move.l d4, (a4)+
004282  move.l d5, (a1)+
004284  move.l d4, (a3)+
004286  move.l d4, (a4)+
004288  move.l d5, (a1)+
00428A  move.l d4, (a3)+
00428C  move.l d4, (a4)+
00428E  move.l d5, (a1)+
004290  move.l d4, (a3)+
004292  move.l d4, (a4)+
004294  move.l d5, (a1)+
004296  swap   d2
004298  or.w   d2, (a3)+
00429A  or.w   d2, (a4)+
00429C  not.w  d2
00429E  and.w  d2, (a1)+
0042A0  dbra   d6, $34a0
0042A4  bra.w  $34cc
0042A8  or.w   d2, (a3)+
0042AA  or.w   d2, (a4)+
0042AC  not.w  d2
0042AE  and.w  d2, (a1)+
0042B0  move.w d4, (a3)+
0042B2  move.w d4, (a4)+
0042B4  move.w d5, (a1)+
0042B6  move.l d4, (a3)+
0042B8  move.l d4, (a4)+
0042BA  move.l d5, (a1)+
0042BC  move.l d4, (a3)+
0042BE  move.l d4, (a4)+
0042C0  move.l d5, (a1)+
0042C2  move.l d4, (a3)+
0042C4  move.l d4, (a4)+
0042C6  move.l d5, (a1)+
0042C8  move.l d4, (a3)+
0042CA  move.l d4, (a4)+
0042CC  move.l d5, (a1)+
0042CE  move.l d4, (a3)+
0042D0  move.l d4, (a4)+
0042D2  move.l d5, (a1)+
0042D4  move.l d4, (a3)+
0042D6  move.l d4, (a4)+
0042D8  move.l d5, (a1)+
0042DA  swap   d2
0042DC  or.w   d2, (a3)+
0042DE  or.w   d2, (a4)+
0042E0  not.w  d2
0042E2  and.w  d2, (a1)+
0042E4  dbra   d6, $34a0
0042E8  bra.w  $34cc
0042EC  or.w   d2, (a3)+
0042EE  or.w   d2, (a4)+
0042F0  not.w  d2
0042F2  and.w  d2, (a1)+
0042F4  move.l d4, (a3)+
0042F6  move.l d4, (a4)+
0042F8  move.l d5, (a1)+
0042FA  move.l d4, (a3)+
0042FC  move.l d4, (a4)+
0042FE  move.l d5, (a1)+
004300  move.l d4, (a3)+
004302  move.l d4, (a4)+
004304  move.l d5, (a1)+
004306  move.l d4, (a3)+
004308  move.l d4, (a4)+
00430A  move.l d5, (a1)+
00430C  move.l d4, (a3)+
00430E  move.l d4, (a4)+
004310  move.l d5, (a1)+
004312  move.l d4, (a3)+
004314  move.l d4, (a4)+
004316  move.l d5, (a1)+
004318  move.l d4, (a3)+
00431A  move.l d4, (a4)+
00431C  move.l d5, (a1)+
00431E  swap   d2
004320  or.w   d2, (a3)+
004322  or.w   d2, (a4)+
004324  not.w  d2
004326  and.w  d2, (a1)+
004328  dbra   d6, $34a0
00432C  bra.w  $34cc
004330  or.w   d2, (a3)+
004332  or.w   d2, (a4)+
004334  not.w  d2
004336  and.w  d2, (a1)+
004338  move.w d4, (a3)+
00433A  move.w d4, (a4)+
00433C  move.w d5, (a1)+
00433E  move.l d4, (a3)+
004340  move.l d4, (a4)+
004342  move.l d5, (a1)+
004344  move.l d4, (a3)+
004346  move.l d4, (a4)+
004348  move.l d5, (a1)+
00434A  move.l d4, (a3)+
00434C  move.l d4, (a4)+
00434E  move.l d5, (a1)+
004350  move.l d4, (a3)+
004352  move.l d4, (a4)+
004354  move.l d5, (a1)+
004356  move.l d4, (a3)+
004358  move.l d4, (a4)+
00435A  move.l d5, (a1)+
00435C  move.l d4, (a3)+
00435E  move.l d4, (a4)+
004360  move.l d5, (a1)+
004362  move.l d4, (a3)+
004364  move.l d4, (a4)+
004366  move.l d5, (a1)+
004368  swap   d2
00436A  or.w   d2, (a3)+
00436C  or.w   d2, (a4)+
00436E  not.w  d2
004370  and.w  d2, (a1)+
004372  dbra   d6, $34a0
004376  bra.w  $34cc
00437A  or.w   d2, (a3)+
00437C  or.w   d2, (a4)+
00437E  not.w  d2
004380  and.w  d2, (a1)+
004382  move.l d4, (a3)+
004384  move.l d4, (a4)+
004386  move.l d5, (a1)+
004388  move.l d4, (a3)+
00438A  move.l d4, (a4)+
00438C  move.l d5, (a1)+
00438E  move.l d4, (a3)+
004390  move.l d4, (a4)+
004392  move.l d5, (a1)+
004394  move.l d4, (a3)+
004396  move.l d4, (a4)+
004398  move.l d5, (a1)+
00439A  move.l d4, (a3)+
00439C  move.l d4, (a4)+
00439E  move.l d5, (a1)+
0043A0  move.l d4, (a3)+
0043A2  move.l d4, (a4)+
0043A4  move.l d5, (a1)+
0043A6  move.l d4, (a3)+
0043A8  move.l d4, (a4)+
0043AA  move.l d5, (a1)+
0043AC  move.l d4, (a3)+
0043AE  move.l d4, (a4)+
0043B0  move.l d5, (a1)+
0043B2  swap   d2
0043B4  or.w   d2, (a3)+
0043B6  or.w   d2, (a4)+
0043B8  not.w  d2
0043BA  and.w  d2, (a1)+
0043BC  dbra   d6, $34a0
0043C0  bra.w  $34cc
0043C4  or.w   d2, (a3)+
0043C6  or.w   d2, (a4)+
0043C8  not.w  d2
0043CA  and.w  d2, (a1)+
0043CC  move.w d4, (a3)+
0043CE  move.w d4, (a4)+
0043D0  move.w d5, (a1)+
0043D2  move.l d4, (a3)+
0043D4  move.l d4, (a4)+
0043D6  move.l d5, (a1)+
0043D8  move.l d4, (a3)+
0043DA  move.l d4, (a4)+
0043DC  move.l d5, (a1)+
0043DE  move.l d4, (a3)+
0043E0  move.l d4, (a4)+
0043E2  move.l d5, (a1)+
0043E4  move.l d4, (a3)+
0043E6  move.l d4, (a4)+
0043E8  move.l d5, (a1)+
0043EA  move.l d4, (a3)+
0043EC  move.l d4, (a4)+
0043EE  move.l d5, (a1)+
0043F0  move.l d4, (a3)+
0043F2  move.l d4, (a4)+
0043F4  move.l d5, (a1)+
0043F6  move.l d4, (a3)+
0043F8  move.l d4, (a4)+
0043FA  move.l d5, (a1)+
0043FC  move.l d4, (a3)+
0043FE  move.l d4, (a4)+
004400  move.l d5, (a1)+
004402  swap   d2
004404  or.w   d2, (a3)+
004406  or.w   d2, (a4)+
004408  not.w  d2
00440A  and.w  d2, (a1)+
00440C  dbra   d6, $34a0
004410  bra.w  $34cc
004414  dbra   d6, $34a0
004418  bra.w  $34cc
00441C  move.l d2, d3
00441E  swap   d3
004420  and.w  d3, d2
004422  or.w   d2, (a1)+
004424  not.w  d2
004426  and.w  d2, (a3)+
004428  and.w  d2, (a4)+
00442A  dbra   d6, $34a0
00442E  bra.w  $34cc
004432  swap   d2
004434  or.l   d2, (a1)+
004436  not.l  d2
004438  and.l  d2, (a3)+
00443A  and.l  d2, (a4)+
00443C  dbra   d6, $34a0
004440  bra.w  $34cc
004444  or.w   d2, (a1)+
004446  not.w  d2
004448  and.w  d2, (a3)+
00444A  and.w  d2, (a4)+
00444C  move.w d5, (a3)+
00444E  move.w d5, (a4)+
004450  move.w d4, (a1)+
004452  swap   d2
004454  or.w   d2, (a1)+
004456  not.w  d2
004458  and.w  d2, (a3)+
00445A  and.w  d2, (a4)+
00445C  dbra   d6, $34a0
004460  bra.w  $34cc
004464  or.w   d2, (a1)+
004466  not.w  d2
004468  and.w  d2, (a3)+
00446A  and.w  d2, (a4)+
00446C  move.l d5, (a3)+
00446E  move.l d5, (a4)+
004470  move.l d4, (a1)+
004472  swap   d2
004474  or.w   d2, (a1)+
004476  not.w  d2
004478  and.w  d2, (a3)+
00447A  and.w  d2, (a4)+
00447C  dbra   d6, $34a0
004480  bra.w  $34cc
004484  or.w   d2, (a1)+
004486  not.w  d2
004488  and.w  d2, (a3)+
00448A  and.w  d2, (a4)+
00448C  move.l d5, (a3)+
00448E  move.l d5, (a4)+
004490  move.l d4, (a1)+
004492  move.w d5, (a3)+
004494  move.w d5, (a4)+
004496  move.w d4, (a1)+
004498  swap   d2
00449A  or.w   d2, (a1)+
00449C  not.w  d2
00449E  and.w  d2, (a3)+
0044A0  and.w  d2, (a4)+
0044A2  dbra   d6, $34a0
0044A6  bra.w  $34cc
0044AA  or.w   d2, (a1)+
0044AC  not.w  d2
0044AE  and.w  d2, (a3)+
0044B0  and.w  d2, (a4)+
0044B2  move.l d5, (a3)+
0044B4  move.l d5, (a4)+
0044B6  move.l d4, (a1)+
0044B8  move.l d5, (a3)+
0044BA  move.l d5, (a4)+
0044BC  move.l d4, (a1)+
0044BE  swap   d2
0044C0  or.w   d2, (a1)+
0044C2  not.w  d2
0044C4  and.w  d2, (a3)+
0044C6  and.w  d2, (a4)+
0044C8  dbra   d6, $34a0
0044CC  bra.w  $34cc
0044D0  or.w   d2, (a1)+
0044D2  not.w  d2
0044D4  and.w  d2, (a3)+
0044D6  and.w  d2, (a4)+
0044D8  move.w d5, (a3)+
0044DA  move.w d5, (a4)+
0044DC  move.w d4, (a1)+
0044DE  move.l d5, (a3)+
0044E0  move.l d5, (a4)+
0044E2  move.l d4, (a1)+
0044E4  move.l d5, (a3)+
0044E6  move.l d5, (a4)+
0044E8  move.l d4, (a1)+
0044EA  swap   d2
0044EC  or.w   d2, (a1)+
0044EE  not.w  d2
0044F0  and.w  d2, (a3)+
0044F2  and.w  d2, (a4)+
0044F4  dbra   d6, $34a0
0044F8  bra.w  $34cc
0044FC  or.w   d2, (a1)+
0044FE  not.w  d2
004500  and.w  d2, (a3)+
004502  and.w  d2, (a4)+
004504  move.l d5, (a3)+
004506  move.l d5, (a4)+
004508  move.l d4, (a1)+
00450A  move.l d5, (a3)+
00450C  move.l d5, (a4)+
00450E  move.l d4, (a1)+
004510  move.l d5, (a3)+
004512  move.l d5, (a4)+
004514  move.l d4, (a1)+
004516  swap   d2
004518  or.w   d2, (a1)+
00451A  not.w  d2
00451C  and.w  d2, (a3)+
00451E  and.w  d2, (a4)+
004520  dbra   d6, $34a0
004524  bra.w  $34cc
004528  or.w   d2, (a1)+
00452A  not.w  d2
00452C  and.w  d2, (a3)+
00452E  and.w  d2, (a4)+
004530  move.w d5, (a3)+
004532  move.w d5, (a4)+
004534  move.w d4, (a1)+
004536  move.l d5, (a3)+
004538  move.l d5, (a4)+
00453A  move.l d4, (a1)+
00453C  move.l d5, (a3)+
00453E  move.l d5, (a4)+
004540  move.l d4, (a1)+
004542  move.l d5, (a3)+
004544  move.l d5, (a4)+
004546  move.l d4, (a1)+
004548  swap   d2
00454A  or.w   d2, (a1)+
00454C  not.w  d2
00454E  and.w  d2, (a3)+
004550  and.w  d2, (a4)+
004552  dbra   d6, $34a0
004556  bra.w  $34cc
00455A  or.w   d2, (a1)+
00455C  not.w  d2
00455E  and.w  d2, (a3)+
004560  and.w  d2, (a4)+
004562  move.l d5, (a3)+
004564  move.l d5, (a4)+
004566  move.l d4, (a1)+
004568  move.l d5, (a3)+
00456A  move.l d5, (a4)+
00456C  move.l d4, (a1)+
00456E  move.l d5, (a3)+
004570  move.l d5, (a4)+
004572  move.l d4, (a1)+
004574  move.l d5, (a3)+
004576  move.l d5, (a4)+
004578  move.l d4, (a1)+
00457A  swap   d2
00457C  or.w   d2, (a1)+
00457E  not.w  d2
004580  and.w  d2, (a3)+
004582  and.w  d2, (a4)+
004584  dbra   d6, $34a0
004588  bra.w  $34cc
00458C  or.w   d2, (a1)+
00458E  not.w  d2
004590  and.w  d2, (a3)+
004592  and.w  d2, (a4)+
004594  move.w d5, (a3)+
004596  move.w d5, (a4)+
004598  move.w d4, (a1)+
00459A  move.l d5, (a3)+
00459C  move.l d5, (a4)+
00459E  move.l d4, (a1)+
0045A0  move.l d5, (a3)+
0045A2  move.l d5, (a4)+
0045A4  move.l d4, (a1)+
0045A6  move.l d5, (a3)+
0045A8  move.l d5, (a4)+
0045AA  move.l d4, (a1)+
0045AC  move.l d5, (a3)+
0045AE  move.l d5, (a4)+
0045B0  move.l d4, (a1)+
0045B2  swap   d2
0045B4  or.w   d2, (a1)+
0045B6  not.w  d2
0045B8  and.w  d2, (a3)+
0045BA  and.w  d2, (a4)+
0045BC  dbra   d6, $34a0
0045C0  bra.w  $34cc
0045C4  or.w   d2, (a1)+
0045C6  not.w  d2
0045C8  and.w  d2, (a3)+
0045CA  and.w  d2, (a4)+
0045CC  move.l d5, (a3)+
0045CE  move.l d5, (a4)+
0045D0  move.l d4, (a1)+
0045D2  move.l d5, (a3)+
0045D4  move.l d5, (a4)+
0045D6  move.l d4, (a1)+
0045D8  move.l d5, (a3)+
0045DA  move.l d5, (a4)+
0045DC  move.l d4, (a1)+
0045DE  move.l d5, (a3)+
0045E0  move.l d5, (a4)+
0045E2  move.l d4, (a1)+
0045E4  move.l d5, (a3)+
0045E6  move.l d5, (a4)+
0045E8  move.l d4, (a1)+
0045EA  swap   d2
0045EC  or.w   d2, (a1)+
0045EE  not.w  d2
0045F0  and.w  d2, (a3)+
0045F2  and.w  d2, (a4)+
0045F4  dbra   d6, $34a0
0045F8  bra.w  $34cc
0045FC  or.w   d2, (a1)+
0045FE  not.w  d2
004600  and.w  d2, (a3)+
004602  and.w  d2, (a4)+
004604  move.w d5, (a3)+
004606  move.w d5, (a4)+
004608  move.w d4, (a1)+
00460A  move.l d5, (a3)+
00460C  move.l d5, (a4)+
00460E  move.l d4, (a1)+
004610  move.l d5, (a3)+
004612  move.l d5, (a4)+
004614  move.l d4, (a1)+
004616  move.l d5, (a3)+
004618  move.l d5, (a4)+
00461A  move.l d4, (a1)+
00461C  move.l d5, (a3)+
00461E  move.l d5, (a4)+
004620  move.l d4, (a1)+
004622  move.l d5, (a3)+
004624  move.l d5, (a4)+
004626  move.l d4, (a1)+
004628  swap   d2
00462A  or.w   d2, (a1)+
00462C  not.w  d2
00462E  and.w  d2, (a3)+
004630  and.w  d2, (a4)+
004632  dbra   d6, $34a0
004636  bra.w  $34cc
00463A  or.w   d2, (a1)+
00463C  not.w  d2
00463E  and.w  d2, (a3)+
004640  and.w  d2, (a4)+
004642  move.l d5, (a3)+
004644  move.l d5, (a4)+
004646  move.l d4, (a1)+
004648  move.l d5, (a3)+
00464A  move.l d5, (a4)+
00464C  move.l d4, (a1)+
00464E  move.l d5, (a3)+
004650  move.l d5, (a4)+
004652  move.l d4, (a1)+
004654  move.l d5, (a3)+
004656  move.l d5, (a4)+
004658  move.l d4, (a1)+
00465A  move.l d5, (a3)+
00465C  move.l d5, (a4)+
00465E  move.l d4, (a1)+
004660  move.l d5, (a3)+
004662  move.l d5, (a4)+
004664  move.l d4, (a1)+
004666  swap   d2
004668  or.w   d2, (a1)+
00466A  not.w  d2
00466C  and.w  d2, (a3)+
00466E  and.w  d2, (a4)+
004670  dbra   d6, $34a0
004674  bra.w  $34cc
004678  or.w   d2, (a1)+
00467A  not.w  d2
00467C  and.w  d2, (a3)+
00467E  and.w  d2, (a4)+
004680  move.w d5, (a3)+
004682  move.w d5, (a4)+
004684  move.w d4, (a1)+
004686  move.l d5, (a3)+
004688  move.l d5, (a4)+
00468A  move.l d4, (a1)+
00468C  move.l d5, (a3)+
00468E  move.l d5, (a4)+
004690  move.l d4, (a1)+
004692  move.l d5, (a3)+
004694  move.l d5, (a4)+
004696  move.l d4, (a1)+
004698  move.l d5, (a3)+
00469A  move.l d5, (a4)+
00469C  move.l d4, (a1)+
00469E  move.l d5, (a3)+
0046A0  move.l d5, (a4)+
0046A2  move.l d4, (a1)+
0046A4  move.l d5, (a3)+
0046A6  move.l d5, (a4)+
0046A8  move.l d4, (a1)+
0046AA  swap   d2
0046AC  or.w   d2, (a1)+
0046AE  not.w  d2
0046B0  and.w  d2, (a3)+
0046B2  and.w  d2, (a4)+
0046B4  dbra   d6, $34a0
0046B8  bra.w  $34cc
0046BC  or.w   d2, (a1)+
0046BE  not.w  d2
0046C0  and.w  d2, (a3)+
0046C2  and.w  d2, (a4)+
0046C4  move.l d5, (a3)+
0046C6  move.l d5, (a4)+
0046C8  move.l d4, (a1)+
0046CA  move.l d5, (a3)+
0046CC  move.l d5, (a4)+
0046CE  move.l d4, (a1)+
0046D0  move.l d5, (a3)+
0046D2  move.l d5, (a4)+
0046D4  move.l d4, (a1)+
0046D6  move.l d5, (a3)+
0046D8  move.l d5, (a4)+
0046DA  move.l d4, (a1)+
0046DC  move.l d5, (a3)+
0046DE  move.l d5, (a4)+
0046E0  move.l d4, (a1)+
0046E2  move.l d5, (a3)+
0046E4  move.l d5, (a4)+
0046E6  move.l d4, (a1)+
0046E8  move.l d5, (a3)+
0046EA  move.l d5, (a4)+
0046EC  move.l d4, (a1)+
0046EE  swap   d2
0046F0  or.w   d2, (a1)+
0046F2  not.w  d2
0046F4  and.w  d2, (a3)+
0046F6  and.w  d2, (a4)+
0046F8  dbra   d6, $34a0
0046FC  bra.w  $34cc
004700  or.w   d2, (a1)+
004702  not.w  d2
004704  and.w  d2, (a3)+
004706  and.w  d2, (a4)+
004708  move.w d5, (a3)+
00470A  move.w d5, (a4)+
00470C  move.w d4, (a1)+
00470E  move.l d5, (a3)+
004710  move.l d5, (a4)+
004712  move.l d4, (a1)+
004714  move.l d5, (a3)+
004716  move.l d5, (a4)+
004718  move.l d4, (a1)+
00471A  move.l d5, (a3)+
00471C  move.l d5, (a4)+
00471E  move.l d4, (a1)+
004720  move.l d5, (a3)+
004722  move.l d5, (a4)+
004724  move.l d4, (a1)+
004726  move.l d5, (a3)+
004728  move.l d5, (a4)+
00472A  move.l d4, (a1)+
00472C  move.l d5, (a3)+
00472E  move.l d5, (a4)+
004730  move.l d4, (a1)+
004732  move.l d5, (a3)+
004734  move.l d5, (a4)+
004736  move.l d4, (a1)+
004738  swap   d2
00473A  or.w   d2, (a1)+
00473C  not.w  d2
00473E  and.w  d2, (a3)+
004740  and.w  d2, (a4)+
004742  dbra   d6, $34a0
004746  bra.w  $34cc
00474A  or.w   d2, (a1)+
00474C  not.w  d2
00474E  and.w  d2, (a3)+
004750  and.w  d2, (a4)+
004752  move.l d5, (a3)+
004754  move.l d5, (a4)+
004756  move.l d4, (a1)+
004758  move.l d5, (a3)+
00475A  move.l d5, (a4)+
00475C  move.l d4, (a1)+
00475E  move.l d5, (a3)+
004760  move.l d5, (a4)+
004762  move.l d4, (a1)+
004764  move.l d5, (a3)+
004766  move.l d5, (a4)+
004768  move.l d4, (a1)+
00476A  move.l d5, (a3)+
00476C  move.l d5, (a4)+
00476E  move.l d4, (a1)+
004770  move.l d5, (a3)+
004772  move.l d5, (a4)+
004774  move.l d4, (a1)+
004776  move.l d5, (a3)+
004778  move.l d5, (a4)+
00477A  move.l d4, (a1)+
00477C  move.l d5, (a3)+
00477E  move.l d5, (a4)+
004780  move.l d4, (a1)+
004782  swap   d2
004784  or.w   d2, (a1)+
004786  not.w  d2
004788  and.w  d2, (a3)+
00478A  and.w  d2, (a4)+
00478C  dbra   d6, $34a0
004790  bra.w  $34cc
004794  or.w   d2, (a1)+
004796  not.w  d2
004798  and.w  d2, (a3)+
00479A  and.w  d2, (a4)+
00479C  move.w d5, (a3)+
00479E  move.w d5, (a4)+
0047A0  move.w d4, (a1)+
0047A2  move.l d5, (a3)+
0047A4  move.l d5, (a4)+
0047A6  move.l d4, (a1)+
0047A8  move.l d5, (a3)+
0047AA  move.l d5, (a4)+
0047AC  move.l d4, (a1)+
0047AE  move.l d5, (a3)+
0047B0  move.l d5, (a4)+
0047B2  move.l d4, (a1)+
0047B4  move.l d5, (a3)+
0047B6  move.l d5, (a4)+
0047B8  move.l d4, (a1)+
0047BA  move.l d5, (a3)+
0047BC  move.l d5, (a4)+
0047BE  move.l d4, (a1)+
0047C0  move.l d5, (a3)+
0047C2  move.l d5, (a4)+
0047C4  move.l d4, (a1)+
0047C6  move.l d5, (a3)+
0047C8  move.l d5, (a4)+
0047CA  move.l d4, (a1)+
0047CC  move.l d5, (a3)+
0047CE  move.l d5, (a4)+
0047D0  move.l d4, (a1)+
0047D2  swap   d2
0047D4  or.w   d2, (a1)+
0047D6  not.w  d2
0047D8  and.w  d2, (a3)+
0047DA  and.w  d2, (a4)+
0047DC  dbra   d6, $34a0
0047E0  bra.w  $34cc
0047E4  dbra   d6, $34a0
0047E8  bra.w  $34cc
0047EC  move.l d2, d3
0047EE  swap   d3
0047F0  and.w  d3, d2
0047F2  or.w   d2, (a3)+
0047F4  or.w   d2, (a1)+
0047F6  not.w  d2
0047F8  and.w  d2, (a4)+
0047FA  dbra   d6, $34a0
0047FE  bra.w  $34cc
004802  swap   d2
004804  or.l   d2, (a3)+
004806  or.l   d2, (a1)+
004808  not.l  d2
00480A  and.l  d2, (a4)+
00480C  dbra   d6, $34a0
004810  bra.w  $34cc
004814  or.w   d2, (a3)+
004816  or.w   d2, (a1)+
004818  not.w  d2
00481A  and.w  d2, (a4)+
00481C  move.w d4, (a3)+
00481E  move.w d5, (a4)+
004820  move.w d4, (a1)+
004822  swap   d2
004824  or.w   d2, (a3)+
004826  or.w   d2, (a1)+
004828  not.w  d2
00482A  and.w  d2, (a4)+
00482C  dbra   d6, $34a0
004830  bra.w  $34cc
004834  or.w   d2, (a3)+
004836  or.w   d2, (a1)+
004838  not.w  d2
00483A  and.w  d2, (a4)+
00483C  move.l d4, (a3)+
00483E  move.l d5, (a4)+
004840  move.l d4, (a1)+
004842  swap   d2
004844  or.w   d2, (a3)+
004846  or.w   d2, (a1)+
004848  not.w  d2
00484A  and.w  d2, (a4)+
00484C  dbra   d6, $34a0
004850  bra.w  $34cc
004854  or.w   d2, (a3)+
004856  or.w   d2, (a1)+
004858  not.w  d2
00485A  and.w  d2, (a4)+
00485C  move.l d4, (a3)+
00485E  move.l d5, (a4)+
004860  move.l d4, (a1)+
004862  move.w d4, (a3)+
004864  move.w d5, (a4)+
004866  move.w d4, (a1)+
004868  swap   d2
00486A  or.w   d2, (a3)+
00486C  or.w   d2, (a1)+
00486E  not.w  d2
004870  and.w  d2, (a4)+
004872  dbra   d6, $34a0
004876  bra.w  $34cc
00487A  or.w   d2, (a3)+
00487C  or.w   d2, (a1)+
00487E  not.w  d2
004880  and.w  d2, (a4)+
004882  move.l d4, (a3)+
004884  move.l d5, (a4)+
004886  move.l d4, (a1)+
004888  move.l d4, (a3)+
00488A  move.l d5, (a4)+
00488C  move.l d4, (a1)+
00488E  swap   d2
004890  or.w   d2, (a3)+
004892  or.w   d2, (a1)+
004894  not.w  d2
004896  and.w  d2, (a4)+
004898  dbra   d6, $34a0
00489C  bra.w  $34cc
0048A0  or.w   d2, (a3)+
0048A2  or.w   d2, (a1)+
0048A4  not.w  d2
0048A6  and.w  d2, (a4)+
0048A8  move.w d4, (a3)+
0048AA  move.w d5, (a4)+
0048AC  move.w d4, (a1)+
0048AE  move.l d4, (a3)+
0048B0  move.l d5, (a4)+
0048B2  move.l d4, (a1)+
0048B4  move.l d4, (a3)+
0048B6  move.l d5, (a4)+
0048B8  move.l d4, (a1)+
0048BA  swap   d2
0048BC  or.w   d2, (a3)+
0048BE  or.w   d2, (a1)+
0048C0  not.w  d2
0048C2  and.w  d2, (a4)+
0048C4  dbra   d6, $34a0
0048C8  bra.w  $34cc
0048CC  or.w   d2, (a3)+
0048CE  or.w   d2, (a1)+
0048D0  not.w  d2
0048D2  and.w  d2, (a4)+
0048D4  move.l d4, (a3)+
0048D6  move.l d5, (a4)+
0048D8  move.l d4, (a1)+
0048DA  move.l d4, (a3)+
0048DC  move.l d5, (a4)+
0048DE  move.l d4, (a1)+
0048E0  move.l d4, (a3)+
0048E2  move.l d5, (a4)+
0048E4  move.l d4, (a1)+
0048E6  swap   d2
0048E8  or.w   d2, (a3)+
0048EA  or.w   d2, (a1)+
0048EC  not.w  d2
0048EE  and.w  d2, (a4)+
0048F0  dbra   d6, $34a0
0048F4  bra.w  $34cc
0048F8  or.w   d2, (a3)+
0048FA  or.w   d2, (a1)+
0048FC  not.w  d2
0048FE  and.w  d2, (a4)+
004900  move.w d4, (a3)+
004902  move.w d5, (a4)+
004904  move.w d4, (a1)+
004906  move.l d4, (a3)+
004908  move.l d5, (a4)+
00490A  move.l d4, (a1)+
00490C  move.l d4, (a3)+
00490E  move.l d5, (a4)+
004910  move.l d4, (a1)+
004912  move.l d4, (a3)+
004914  move.l d5, (a4)+
004916  move.l d4, (a1)+
004918  swap   d2
00491A  or.w   d2, (a3)+
00491C  or.w   d2, (a1)+
00491E  not.w  d2
004920  and.w  d2, (a4)+
004922  dbra   d6, $34a0
004926  bra.w  $34cc
00492A  or.w   d2, (a3)+
00492C  or.w   d2, (a1)+
00492E  not.w  d2
004930  and.w  d2, (a4)+
004932  move.l d4, (a3)+
004934  move.l d5, (a4)+
004936  move.l d4, (a1)+
004938  move.l d4, (a3)+
00493A  move.l d5, (a4)+
00493C  move.l d4, (a1)+
00493E  move.l d4, (a3)+
004940  move.l d5, (a4)+
004942  move.l d4, (a1)+
004944  move.l d4, (a3)+
004946  move.l d5, (a4)+
004948  move.l d4, (a1)+
00494A  swap   d2
00494C  or.w   d2, (a3)+
00494E  or.w   d2, (a1)+
004950  not.w  d2
004952  and.w  d2, (a4)+
004954  dbra   d6, $34a0
004958  bra.w  $34cc
00495C  or.w   d2, (a3)+
00495E  or.w   d2, (a1)+
004960  not.w  d2
004962  and.w  d2, (a4)+
004964  move.w d4, (a3)+
004966  move.w d5, (a4)+
004968  move.w d4, (a1)+
00496A  move.l d4, (a3)+
00496C  move.l d5, (a4)+
00496E  move.l d4, (a1)+
004970  move.l d4, (a3)+
004972  move.l d5, (a4)+
004974  move.l d4, (a1)+
004976  move.l d4, (a3)+
004978  move.l d5, (a4)+
00497A  move.l d4, (a1)+
00497C  move.l d4, (a3)+
00497E  move.l d5, (a4)+
004980  move.l d4, (a1)+
004982  swap   d2
004984  or.w   d2, (a3)+
004986  or.w   d2, (a1)+
004988  not.w  d2
00498A  and.w  d2, (a4)+
00498C  dbra   d6, $34a0
004990  bra.w  $34cc
004994  or.w   d2, (a3)+
004996  or.w   d2, (a1)+
004998  not.w  d2
00499A  and.w  d2, (a4)+
00499C  move.l d4, (a3)+
00499E  move.l d5, (a4)+
0049A0  move.l d4, (a1)+
0049A2  move.l d4, (a3)+
0049A4  move.l d5, (a4)+
0049A6  move.l d4, (a1)+
0049A8  move.l d4, (a3)+
0049AA  move.l d5, (a4)+
0049AC  move.l d4, (a1)+
0049AE  move.l d4, (a3)+
0049B0  move.l d5, (a4)+
0049B2  move.l d4, (a1)+
0049B4  move.l d4, (a3)+
0049B6  move.l d5, (a4)+
0049B8  move.l d4, (a1)+
0049BA  swap   d2
0049BC  or.w   d2, (a3)+
0049BE  or.w   d2, (a1)+
0049C0  not.w  d2
0049C2  and.w  d2, (a4)+
0049C4  dbra   d6, $34a0
0049C8  bra.w  $34cc
0049CC  or.w   d2, (a3)+
0049CE  or.w   d2, (a1)+
0049D0  not.w  d2
0049D2  and.w  d2, (a4)+
0049D4  move.w d4, (a3)+
0049D6  move.w d5, (a4)+
0049D8  move.w d4, (a1)+
0049DA  move.l d4, (a3)+
0049DC  move.l d5, (a4)+
0049DE  move.l d4, (a1)+
0049E0  move.l d4, (a3)+
0049E2  move.l d5, (a4)+
0049E4  move.l d4, (a1)+
0049E6  move.l d4, (a3)+
0049E8  move.l d5, (a4)+
0049EA  move.l d4, (a1)+
0049EC  move.l d4, (a3)+
0049EE  move.l d5, (a4)+
0049F0  move.l d4, (a1)+
0049F2  move.l d4, (a3)+
0049F4  move.l d5, (a4)+
0049F6  move.l d4, (a1)+
0049F8  swap   d2
0049FA  or.w   d2, (a3)+
0049FC  or.w   d2, (a1)+
0049FE  not.w  d2
004A00  and.w  d2, (a4)+
004A02  dbra   d6, $34a0
004A06  bra.w  $34cc
004A0A  or.w   d2, (a3)+
004A0C  or.w   d2, (a1)+
004A0E  not.w  d2
004A10  and.w  d2, (a4)+
004A12  move.l d4, (a3)+
004A14  move.l d5, (a4)+
004A16  move.l d4, (a1)+
004A18  move.l d4, (a3)+
004A1A  move.l d5, (a4)+
004A1C  move.l d4, (a1)+
004A1E  move.l d4, (a3)+
004A20  move.l d5, (a4)+
004A22  move.l d4, (a1)+
004A24  move.l d4, (a3)+
004A26  move.l d5, (a4)+
004A28  move.l d4, (a1)+
004A2A  move.l d4, (a3)+
004A2C  move.l d5, (a4)+
004A2E  move.l d4, (a1)+
004A30  move.l d4, (a3)+
004A32  move.l d5, (a4)+
004A34  move.l d4, (a1)+
004A36  swap   d2
004A38  or.w   d2, (a3)+
004A3A  or.w   d2, (a1)+
004A3C  not.w  d2
004A3E  and.w  d2, (a4)+
004A40  dbra   d6, $34a0
004A44  bra.w  $34cc
004A48  or.w   d2, (a3)+
004A4A  or.w   d2, (a1)+
004A4C  not.w  d2
004A4E  and.w  d2, (a4)+
004A50  move.w d4, (a3)+
004A52  move.w d5, (a4)+
004A54  move.w d4, (a1)+
004A56  move.l d4, (a3)+
004A58  move.l d5, (a4)+
004A5A  move.l d4, (a1)+
004A5C  move.l d4, (a3)+
004A5E  move.l d5, (a4)+
004A60  move.l d4, (a1)+
004A62  move.l d4, (a3)+
004A64  move.l d5, (a4)+
004A66  move.l d4, (a1)+
004A68  move.l d4, (a3)+
004A6A  move.l d5, (a4)+
004A6C  move.l d4, (a1)+
004A6E  move.l d4, (a3)+
004A70  move.l d5, (a4)+
004A72  move.l d4, (a1)+
004A74  move.l d4, (a3)+
004A76  move.l d5, (a4)+
004A78  move.l d4, (a1)+
004A7A  swap   d2
004A7C  or.w   d2, (a3)+
004A7E  or.w   d2, (a1)+
004A80  not.w  d2
004A82  and.w  d2, (a4)+
004A84  dbra   d6, $34a0
004A88  bra.w  $34cc
004A8C  or.w   d2, (a3)+
004A8E  or.w   d2, (a1)+
004A90  not.w  d2
004A92  and.w  d2, (a4)+
004A94  move.l d4, (a3)+
004A96  move.l d5, (a4)+
004A98  move.l d4, (a1)+
004A9A  move.l d4, (a3)+
004A9C  move.l d5, (a4)+
004A9E  move.l d4, (a1)+
004AA0  move.l d4, (a3)+
004AA2  move.l d5, (a4)+
004AA4  move.l d4, (a1)+
004AA6  move.l d4, (a3)+
004AA8  move.l d5, (a4)+
004AAA  move.l d4, (a1)+
004AAC  move.l d4, (a3)+
004AAE  move.l d5, (a4)+
004AB0  move.l d4, (a1)+
004AB2  move.l d4, (a3)+
004AB4  move.l d5, (a4)+
004AB6  move.l d4, (a1)+
004AB8  move.l d4, (a3)+
004ABA  move.l d5, (a4)+
004ABC  move.l d4, (a1)+
004ABE  swap   d2
004AC0  or.w   d2, (a3)+
004AC2  or.w   d2, (a1)+
004AC4  not.w  d2
004AC6  and.w  d2, (a4)+
004AC8  dbra   d6, $34a0
004ACC  bra.w  $34cc
004AD0  or.w   d2, (a3)+
004AD2  or.w   d2, (a1)+
004AD4  not.w  d2
004AD6  and.w  d2, (a4)+
004AD8  move.w d4, (a3)+
004ADA  move.w d5, (a4)+
004ADC  move.w d4, (a1)+
004ADE  move.l d4, (a3)+
004AE0  move.l d5, (a4)+
004AE2  move.l d4, (a1)+
004AE4  move.l d4, (a3)+
004AE6  move.l d5, (a4)+
004AE8  move.l d4, (a1)+
004AEA  move.l d4, (a3)+
004AEC  move.l d5, (a4)+
004AEE  move.l d4, (a1)+
004AF0  move.l d4, (a3)+
004AF2  move.l d5, (a4)+
004AF4  move.l d4, (a1)+
004AF6  move.l d4, (a3)+
004AF8  move.l d5, (a4)+
004AFA  move.l d4, (a1)+
004AFC  move.l d4, (a3)+
004AFE  move.l d5, (a4)+
004B00  move.l d4, (a1)+
004B02  move.l d4, (a3)+
004B04  move.l d5, (a4)+
004B06  move.l d4, (a1)+
004B08  swap   d2
004B0A  or.w   d2, (a3)+
004B0C  or.w   d2, (a1)+
004B0E  not.w  d2
004B10  and.w  d2, (a4)+
004B12  dbra   d6, $34a0
004B16  bra.w  $34cc
004B1A  or.w   d2, (a3)+
004B1C  or.w   d2, (a1)+
004B1E  not.w  d2
004B20  and.w  d2, (a4)+
004B22  move.l d4, (a3)+
004B24  move.l d5, (a4)+
004B26  move.l d4, (a1)+
004B28  move.l d4, (a3)+
004B2A  move.l d5, (a4)+
004B2C  move.l d4, (a1)+
004B2E  move.l d4, (a3)+
004B30  move.l d5, (a4)+
004B32  move.l d4, (a1)+
004B34  move.l d4, (a3)+
004B36  move.l d5, (a4)+
004B38  move.l d4, (a1)+
004B3A  move.l d4, (a3)+
004B3C  move.l d5, (a4)+
004B3E  move.l d4, (a1)+
004B40  move.l d4, (a3)+
004B42  move.l d5, (a4)+
004B44  move.l d4, (a1)+
004B46  move.l d4, (a3)+
004B48  move.l d5, (a4)+
004B4A  move.l d4, (a1)+
004B4C  move.l d4, (a3)+
004B4E  move.l d5, (a4)+
004B50  move.l d4, (a1)+
004B52  swap   d2
004B54  or.w   d2, (a3)+
004B56  or.w   d2, (a1)+
004B58  not.w  d2
004B5A  and.w  d2, (a4)+
004B5C  dbra   d6, $34a0
004B60  bra.w  $34cc
004B64  or.w   d2, (a3)+
004B66  or.w   d2, (a1)+
004B68  not.w  d2
004B6A  and.w  d2, (a4)+
004B6C  move.w d4, (a3)+
004B6E  move.w d5, (a4)+
004B70  move.w d4, (a1)+
004B72  move.l d4, (a3)+
004B74  move.l d5, (a4)+
004B76  move.l d4, (a1)+
004B78  move.l d4, (a3)+
004B7A  move.l d5, (a4)+
004B7C  move.l d4, (a1)+
004B7E  move.l d4, (a3)+
004B80  move.l d5, (a4)+
004B82  move.l d4, (a1)+
004B84  move.l d4, (a3)+
004B86  move.l d5, (a4)+
004B88  move.l d4, (a1)+
004B8A  move.l d4, (a3)+
004B8C  move.l d5, (a4)+
004B8E  move.l d4, (a1)+
004B90  move.l d4, (a3)+
004B92  move.l d5, (a4)+
004B94  move.l d4, (a1)+
004B96  move.l d4, (a3)+
004B98  move.l d5, (a4)+
004B9A  move.l d4, (a1)+
004B9C  move.l d4, (a3)+
004B9E  move.l d5, (a4)+
004BA0  move.l d4, (a1)+
004BA2  swap   d2
004BA4  or.w   d2, (a3)+
004BA6  or.w   d2, (a1)+
004BA8  not.w  d2
004BAA  and.w  d2, (a4)+
004BAC  dbra   d6, $34a0
004BB0  bra.w  $34cc
004BB4  dbra   d6, $34a0
004BB8  bra.w  $34cc
004BBC  move.l d2, d3
004BBE  swap   d3
004BC0  and.w  d3, d2
004BC2  or.w   d2, (a4)+
004BC4  or.w   d2, (a1)+
004BC6  not.w  d2
004BC8  and.w  d2, (a3)+
004BCA  dbra   d6, $34a0
004BCE  bra.w  $34cc
004BD2  swap   d2
004BD4  or.l   d2, (a4)+
004BD6  or.l   d2, (a1)+
004BD8  not.l  d2
004BDA  and.l  d2, (a3)+
004BDC  dbra   d6, $34a0
004BE0  bra.w  $34cc
004BE4  or.w   d2, (a4)+
004BE6  or.w   d2, (a1)+
004BE8  not.w  d2
004BEA  and.w  d2, (a3)+
004BEC  move.w d5, (a3)+
004BEE  move.w d4, (a4)+
004BF0  move.w d4, (a1)+
004BF2  swap   d2
004BF4  or.w   d2, (a4)+
004BF6  or.w   d2, (a1)+
004BF8  not.w  d2
004BFA  and.w  d2, (a3)+
004BFC  dbra   d6, $34a0
004C00  bra.w  $34cc
004C04  or.w   d2, (a4)+
004C06  or.w   d2, (a1)+
004C08  not.w  d2
004C0A  and.w  d2, (a3)+
004C0C  move.l d5, (a3)+
004C0E  move.l d4, (a4)+
004C10  move.l d4, (a1)+
004C12  swap   d2
004C14  or.w   d2, (a4)+
004C16  or.w   d2, (a1)+
004C18  not.w  d2
004C1A  and.w  d2, (a3)+
004C1C  dbra   d6, $34a0
004C20  bra.w  $34cc
004C24  or.w   d2, (a4)+
004C26  or.w   d2, (a1)+
004C28  not.w  d2
004C2A  and.w  d2, (a3)+
004C2C  move.l d5, (a3)+
004C2E  move.l d4, (a4)+
004C30  move.l d4, (a1)+
004C32  move.w d5, (a3)+
004C34  move.w d4, (a4)+
004C36  move.w d4, (a1)+
004C38  swap   d2
004C3A  or.w   d2, (a4)+
004C3C  or.w   d2, (a1)+
004C3E  not.w  d2
004C40  and.w  d2, (a3)+
004C42  dbra   d6, $34a0
004C46  bra.w  $34cc
004C4A  or.w   d2, (a4)+
004C4C  or.w   d2, (a1)+
004C4E  not.w  d2
004C50  and.w  d2, (a3)+
004C52  move.l d5, (a3)+
004C54  move.l d4, (a4)+
004C56  move.l d4, (a1)+
004C58  move.l d5, (a3)+
004C5A  move.l d4, (a4)+
004C5C  move.l d4, (a1)+
004C5E  swap   d2
004C60  or.w   d2, (a4)+
004C62  or.w   d2, (a1)+
004C64  not.w  d2
004C66  and.w  d2, (a3)+
004C68  dbra   d6, $34a0
004C6C  bra.w  $34cc
004C70  or.w   d2, (a4)+
004C72  or.w   d2, (a1)+
004C74  not.w  d2
004C76  and.w  d2, (a3)+
004C78  move.w d5, (a3)+
004C7A  move.w d4, (a4)+
004C7C  move.w d4, (a1)+
004C7E  move.l d5, (a3)+
004C80  move.l d4, (a4)+
004C82  move.l d4, (a1)+
004C84  move.l d5, (a3)+
004C86  move.l d4, (a4)+
004C88  move.l d4, (a1)+
004C8A  swap   d2
004C8C  or.w   d2, (a4)+
004C8E  or.w   d2, (a1)+
004C90  not.w  d2
004C92  and.w  d2, (a3)+
004C94  dbra   d6, $34a0
004C98  bra.w  $34cc
004C9C  or.w   d2, (a4)+
004C9E  or.w   d2, (a1)+
004CA0  not.w  d2
004CA2  and.w  d2, (a3)+
004CA4  move.l d5, (a3)+
004CA6  move.l d4, (a4)+
004CA8  move.l d4, (a1)+
004CAA  move.l d5, (a3)+
004CAC  move.l d4, (a4)+
004CAE  move.l d4, (a1)+
004CB0  move.l d5, (a3)+
004CB2  move.l d4, (a4)+
004CB4  move.l d4, (a1)+
004CB6  swap   d2
004CB8  or.w   d2, (a4)+
004CBA  or.w   d2, (a1)+
004CBC  not.w  d2
004CBE  and.w  d2, (a3)+
004CC0  dbra   d6, $34a0
004CC4  bra.w  $34cc
004CC8  or.w   d2, (a4)+
004CCA  or.w   d2, (a1)+
004CCC  not.w  d2
004CCE  and.w  d2, (a3)+
004CD0  move.w d5, (a3)+
004CD2  move.w d4, (a4)+
004CD4  move.w d4, (a1)+
004CD6  move.l d5, (a3)+
004CD8  move.l d4, (a4)+
004CDA  move.l d4, (a1)+
004CDC  move.l d5, (a3)+
004CDE  move.l d4, (a4)+
004CE0  move.l d4, (a1)+
004CE2  move.l d5, (a3)+
004CE4  move.l d4, (a4)+
004CE6  move.l d4, (a1)+
004CE8  swap   d2
004CEA  or.w   d2, (a4)+
004CEC  or.w   d2, (a1)+
004CEE  not.w  d2
004CF0  and.w  d2, (a3)+
004CF2  dbra   d6, $34a0
004CF6  bra.w  $34cc
004CFA  or.w   d2, (a4)+
004CFC  or.w   d2, (a1)+
004CFE  not.w  d2
004D00  and.w  d2, (a3)+
004D02  move.l d5, (a3)+
004D04  move.l d4, (a4)+
004D06  move.l d4, (a1)+
004D08  move.l d5, (a3)+
004D0A  move.l d4, (a4)+
004D0C  move.l d4, (a1)+
004D0E  move.l d5, (a3)+
004D10  move.l d4, (a4)+
004D12  move.l d4, (a1)+
004D14  move.l d5, (a3)+
004D16  move.l d4, (a4)+
004D18  move.l d4, (a1)+
004D1A  swap   d2
004D1C  or.w   d2, (a4)+
004D1E  or.w   d2, (a1)+
004D20  not.w  d2
004D22  and.w  d2, (a3)+
004D24  dbra   d6, $34a0
004D28  bra.w  $34cc
004D2C  or.w   d2, (a4)+
004D2E  or.w   d2, (a1)+
004D30  not.w  d2
004D32  and.w  d2, (a3)+
004D34  move.w d5, (a3)+
004D36  move.w d4, (a4)+
004D38  move.w d4, (a1)+
004D3A  move.l d5, (a3)+
004D3C  move.l d4, (a4)+
004D3E  move.l d4, (a1)+
004D40  move.l d5, (a3)+
004D42  move.l d4, (a4)+
004D44  move.l d4, (a1)+
004D46  move.l d5, (a3)+
004D48  move.l d4, (a4)+
004D4A  move.l d4, (a1)+
004D4C  move.l d5, (a3)+
004D4E  move.l d4, (a4)+
004D50  move.l d4, (a1)+
004D52  swap   d2
004D54  or.w   d2, (a4)+
004D56  or.w   d2, (a1)+
004D58  not.w  d2
004D5A  and.w  d2, (a3)+
004D5C  dbra   d6, $34a0
004D60  bra.w  $34cc
004D64  or.w   d2, (a4)+
004D66  or.w   d2, (a1)+
004D68  not.w  d2
004D6A  and.w  d2, (a3)+
004D6C  move.l d5, (a3)+
004D6E  move.l d4, (a4)+
004D70  move.l d4, (a1)+
004D72  move.l d5, (a3)+
004D74  move.l d4, (a4)+
004D76  move.l d4, (a1)+
004D78  move.l d5, (a3)+
004D7A  move.l d4, (a4)+
004D7C  move.l d4, (a1)+
004D7E  move.l d5, (a3)+
004D80  move.l d4, (a4)+
004D82  move.l d4, (a1)+
004D84  move.l d5, (a3)+
004D86  move.l d4, (a4)+
004D88  move.l d4, (a1)+
004D8A  swap   d2
004D8C  or.w   d2, (a4)+
004D8E  or.w   d2, (a1)+
004D90  not.w  d2
004D92  and.w  d2, (a3)+
004D94  dbra   d6, $34a0
004D98  bra.w  $34cc
004D9C  or.w   d2, (a4)+
004D9E  or.w   d2, (a1)+
004DA0  not.w  d2
004DA2  and.w  d2, (a3)+
004DA4  move.w d5, (a3)+
004DA6  move.w d4, (a4)+
004DA8  move.w d4, (a1)+
004DAA  move.l d5, (a3)+
004DAC  move.l d4, (a4)+
004DAE  move.l d4, (a1)+
004DB0  move.l d5, (a3)+
004DB2  move.l d4, (a4)+
004DB4  move.l d4, (a1)+
004DB6  move.l d5, (a3)+
004DB8  move.l d4, (a4)+
004DBA  move.l d4, (a1)+
004DBC  move.l d5, (a3)+
004DBE  move.l d4, (a4)+
004DC0  move.l d4, (a1)+
004DC2  move.l d5, (a3)+
004DC4  move.l d4, (a4)+
004DC6  move.l d4, (a1)+
004DC8  swap   d2
004DCA  or.w   d2, (a4)+
004DCC  or.w   d2, (a1)+
004DCE  not.w  d2
004DD0  and.w  d2, (a3)+
004DD2  dbra   d6, $34a0
004DD6  bra.w  $34cc
004DDA  or.w   d2, (a4)+
004DDC  or.w   d2, (a1)+
004DDE  not.w  d2
004DE0  and.w  d2, (a3)+
004DE2  move.l d5, (a3)+
004DE4  move.l d4, (a4)+
004DE6  move.l d4, (a1)+
004DE8  move.l d5, (a3)+
004DEA  move.l d4, (a4)+
004DEC  move.l d4, (a1)+
004DEE  move.l d5, (a3)+
004DF0  move.l d4, (a4)+
004DF2  move.l d4, (a1)+
004DF4  move.l d5, (a3)+
004DF6  move.l d4, (a4)+
004DF8  move.l d4, (a1)+
004DFA  move.l d5, (a3)+
004DFC  move.l d4, (a4)+
004DFE  move.l d4, (a1)+
004E00  move.l d5, (a3)+
004E02  move.l d4, (a4)+
004E04  move.l d4, (a1)+
004E06  swap   d2
004E08  or.w   d2, (a4)+
004E0A  or.w   d2, (a1)+
004E0C  not.w  d2
004E0E  and.w  d2, (a3)+
004E10  dbra   d6, $34a0
004E14  bra.w  $34cc
004E18  or.w   d2, (a4)+
004E1A  or.w   d2, (a1)+
004E1C  not.w  d2
004E1E  and.w  d2, (a3)+
004E20  move.w d5, (a3)+
004E22  move.w d4, (a4)+
004E24  move.w d4, (a1)+
004E26  move.l d5, (a3)+
004E28  move.l d4, (a4)+
004E2A  move.l d4, (a1)+
004E2C  move.l d5, (a3)+
004E2E  move.l d4, (a4)+
004E30  move.l d4, (a1)+
004E32  move.l d5, (a3)+
004E34  move.l d4, (a4)+
004E36  move.l d4, (a1)+
004E38  move.l d5, (a3)+
004E3A  move.l d4, (a4)+
004E3C  move.l d4, (a1)+
004E3E  move.l d5, (a3)+
004E40  move.l d4, (a4)+
004E42  move.l d4, (a1)+
004E44  move.l d5, (a3)+
004E46  move.l d4, (a4)+
004E48  move.l d4, (a1)+
004E4A  swap   d2
004E4C  or.w   d2, (a4)+
004E4E  or.w   d2, (a1)+
004E50  not.w  d2
004E52  and.w  d2, (a3)+
004E54  dbra   d6, $34a0
004E58  bra.w  $34cc
004E5C  or.w   d2, (a4)+
004E5E  or.w   d2, (a1)+
004E60  not.w  d2
004E62  and.w  d2, (a3)+
004E64  move.l d5, (a3)+
004E66  move.l d4, (a4)+
004E68  move.l d4, (a1)+
004E6A  move.l d5, (a3)+
004E6C  move.l d4, (a4)+
004E6E  move.l d4, (a1)+
004E70  move.l d5, (a3)+
004E72  move.l d4, (a4)+
004E74  move.l d4, (a1)+
004E76  move.l d5, (a3)+
004E78  move.l d4, (a4)+
004E7A  move.l d4, (a1)+
004E7C  move.l d5, (a3)+
004E7E  move.l d4, (a4)+
004E80  move.l d4, (a1)+
004E82  move.l d5, (a3)+
004E84  move.l d4, (a4)+
004E86  move.l d4, (a1)+
004E88  move.l d5, (a3)+
004E8A  move.l d4, (a4)+
004E8C  move.l d4, (a1)+
004E8E  swap   d2
004E90  or.w   d2, (a4)+
004E92  or.w   d2, (a1)+
004E94  not.w  d2
004E96  and.w  d2, (a3)+
004E98  dbra   d6, $34a0
004E9C  bra.w  $34cc
004EA0  or.w   d2, (a4)+
004EA2  or.w   d2, (a1)+
004EA4  not.w  d2
004EA6  and.w  d2, (a3)+
004EA8  move.w d5, (a3)+
004EAA  move.w d4, (a4)+
004EAC  move.w d4, (a1)+
004EAE  move.l d5, (a3)+
004EB0  move.l d4, (a4)+
004EB2  move.l d4, (a1)+
004EB4  move.l d5, (a3)+
004EB6  move.l d4, (a4)+
004EB8  move.l d4, (a1)+
004EBA  move.l d5, (a3)+
004EBC  move.l d4, (a4)+
004EBE  move.l d4, (a1)+
004EC0  move.l d5, (a3)+
004EC2  move.l d4, (a4)+
004EC4  move.l d4, (a1)+
004EC6  move.l d5, (a3)+
004EC8  move.l d4, (a4)+
004ECA  move.l d4, (a1)+
004ECC  move.l d5, (a3)+
004ECE  move.l d4, (a4)+
004ED0  move.l d4, (a1)+
004ED2  move.l d5, (a3)+
004ED4  move.l d4, (a4)+
004ED6  move.l d4, (a1)+
004ED8  swap   d2
004EDA  or.w   d2, (a4)+
004EDC  or.w   d2, (a1)+
004EDE  not.w  d2
004EE0  and.w  d2, (a3)+
004EE2  dbra   d6, $34a0
004EE6  bra.w  $34cc
004EEA  or.w   d2, (a4)+
004EEC  or.w   d2, (a1)+
004EEE  not.w  d2
004EF0  and.w  d2, (a3)+
004EF2  move.l d5, (a3)+
004EF4  move.l d4, (a4)+
004EF6  move.l d4, (a1)+
004EF8  move.l d5, (a3)+
004EFA  move.l d4, (a4)+
004EFC  move.l d4, (a1)+
004EFE  move.l d5, (a3)+
004F00  move.l d4, (a4)+
004F02  move.l d4, (a1)+
004F04  move.l d5, (a3)+
004F06  move.l d4, (a4)+
004F08  move.l d4, (a1)+
004F0A  move.l d5, (a3)+
004F0C  move.l d4, (a4)+
004F0E  move.l d4, (a1)+
004F10  move.l d5, (a3)+
004F12  move.l d4, (a4)+
004F14  move.l d4, (a1)+
004F16  move.l d5, (a3)+
004F18  move.l d4, (a4)+
004F1A  move.l d4, (a1)+
004F1C  move.l d5, (a3)+
004F1E  move.l d4, (a4)+
004F20  move.l d4, (a1)+
004F22  swap   d2
004F24  or.w   d2, (a4)+
004F26  or.w   d2, (a1)+
004F28  not.w  d2
004F2A  and.w  d2, (a3)+
004F2C  dbra   d6, $34a0
004F30  bra.w  $34cc
004F34  or.w   d2, (a4)+
004F36  or.w   d2, (a1)+
004F38  not.w  d2
004F3A  and.w  d2, (a3)+
004F3C  move.w d5, (a3)+
004F3E  move.w d4, (a4)+
004F40  move.w d4, (a1)+
004F42  move.l d5, (a3)+
004F44  move.l d4, (a4)+
004F46  move.l d4, (a1)+
004F48  move.l d5, (a3)+
004F4A  move.l d4, (a4)+
004F4C  move.l d4, (a1)+
004F4E  move.l d5, (a3)+
004F50  move.l d4, (a4)+
004F52  move.l d4, (a1)+
004F54  move.l d5, (a3)+
004F56  move.l d4, (a4)+
004F58  move.l d4, (a1)+
004F5A  move.l d5, (a3)+
004F5C  move.l d4, (a4)+
004F5E  move.l d4, (a1)+
004F60  move.l d5, (a3)+
004F62  move.l d4, (a4)+
004F64  move.l d4, (a1)+
004F66  move.l d5, (a3)+
004F68  move.l d4, (a4)+
004F6A  move.l d4, (a1)+
004F6C  move.l d5, (a3)+
004F6E  move.l d4, (a4)+
004F70  move.l d4, (a1)+
004F72  swap   d2
004F74  or.w   d2, (a4)+
004F76  or.w   d2, (a1)+
004F78  not.w  d2
004F7A  and.w  d2, (a3)+
004F7C  dbra   d6, $34a0
004F80  bra.w  $34cc
004F84  dbra   d6, $34a0
004F88  bra.w  $34cc
004F8C  move.l d2, d3
004F8E  swap   d3
004F90  and.w  d3, d2
004F92  or.w   d2, (a3)+
004F94  or.w   d2, (a4)+
004F96  or.w   d2, (a1)+
004F98  not.w  d2
004F9A  dbra   d6, $34a0
004F9E  bra.w  $34cc
004FA2  swap   d2
004FA4  or.l   d2, (a3)+
004FA6  or.l   d2, (a4)+
004FA8  or.l   d2, (a1)+
004FAA  not.l  d2
004FAC  dbra   d6, $34a0
004FB0  bra.w  $34cc
004FB4  or.w   d2, (a3)+
004FB6  or.w   d2, (a4)+
004FB8  or.w   d2, (a1)+
004FBA  not.w  d2
004FBC  move.w d4, (a3)+
004FBE  move.w d4, (a4)+
004FC0  move.w d4, (a1)+
004FC2  swap   d2
004FC4  or.w   d2, (a3)+
004FC6  or.w   d2, (a4)+
004FC8  or.w   d2, (a1)+
004FCA  not.w  d2
004FCC  dbra   d6, $34a0
004FD0  bra.w  $34cc
004FD4  or.w   d2, (a3)+
004FD6  or.w   d2, (a4)+
004FD8  or.w   d2, (a1)+
004FDA  not.w  d2
004FDC  move.l d4, (a3)+
004FDE  move.l d4, (a4)+
004FE0  move.l d4, (a1)+
004FE2  swap   d2
004FE4  or.w   d2, (a3)+
004FE6  or.w   d2, (a4)+
004FE8  or.w   d2, (a1)+
004FEA  not.w  d2
004FEC  dbra   d6, $34a0
004FF0  bra.w  $34cc
004FF4  or.w   d2, (a3)+
004FF6  or.w   d2, (a4)+
004FF8  or.w   d2, (a1)+
004FFA  not.w  d2
004FFC  move.l d4, (a3)+
004FFE  move.l d4, (a4)+
005000  move.l d4, (a1)+
005002  move.w d4, (a3)+
005004  move.w d4, (a4)+
005006  move.w d4, (a1)+
005008  swap   d2
00500A  or.w   d2, (a3)+
00500C  or.w   d2, (a4)+
00500E  or.w   d2, (a1)+
005010  not.w  d2
005012  dbra   d6, $34a0
005016  bra.w  $34cc
00501A  or.w   d2, (a3)+
00501C  or.w   d2, (a4)+
00501E  or.w   d2, (a1)+
005020  not.w  d2
005022  move.l d4, (a3)+
005024  move.l d4, (a4)+
005026  move.l d4, (a1)+
005028  move.l d4, (a3)+
00502A  move.l d4, (a4)+
00502C  move.l d4, (a1)+
00502E  swap   d2
005030  or.w   d2, (a3)+
005032  or.w   d2, (a4)+
005034  or.w   d2, (a1)+
005036  not.w  d2
005038  dbra   d6, $34a0
00503C  bra.w  $34cc
005040  or.w   d2, (a3)+
005042  or.w   d2, (a4)+
005044  or.w   d2, (a1)+
005046  not.w  d2
005048  move.w d4, (a3)+
00504A  move.w d4, (a4)+
00504C  move.w d4, (a1)+
00504E  move.l d4, (a3)+
005050  move.l d4, (a4)+
005052  move.l d4, (a1)+
005054  move.l d4, (a3)+
005056  move.l d4, (a4)+
005058  move.l d4, (a1)+
00505A  swap   d2
00505C  or.w   d2, (a3)+
00505E  or.w   d2, (a4)+
005060  or.w   d2, (a1)+
005062  not.w  d2
005064  dbra   d6, $34a0
005068  bra.w  $34cc
00506C  or.w   d2, (a3)+
00506E  or.w   d2, (a4)+
005070  or.w   d2, (a1)+
005072  not.w  d2
005074  move.l d4, (a3)+
005076  move.l d4, (a4)+
005078  move.l d4, (a1)+
00507A  move.l d4, (a3)+
00507C  move.l d4, (a4)+
00507E  move.l d4, (a1)+
005080  move.l d4, (a3)+
005082  move.l d4, (a4)+
005084  move.l d4, (a1)+
005086  swap   d2
005088  or.w   d2, (a3)+
00508A  or.w   d2, (a4)+
00508C  or.w   d2, (a1)+
00508E  not.w  d2
005090  dbra   d6, $34a0
005094  bra.w  $34cc
005098  or.w   d2, (a3)+
00509A  or.w   d2, (a4)+
00509C  or.w   d2, (a1)+
00509E  not.w  d2
0050A0  move.w d4, (a3)+
0050A2  move.w d4, (a4)+
0050A4  move.w d4, (a1)+
0050A6  move.l d4, (a3)+
0050A8  move.l d4, (a4)+
0050AA  move.l d4, (a1)+
0050AC  move.l d4, (a3)+
0050AE  move.l d4, (a4)+
0050B0  move.l d4, (a1)+
0050B2  move.l d4, (a3)+
0050B4  move.l d4, (a4)+
0050B6  move.l d4, (a1)+
0050B8  swap   d2
0050BA  or.w   d2, (a3)+
0050BC  or.w   d2, (a4)+
0050BE  or.w   d2, (a1)+
0050C0  not.w  d2
0050C2  dbra   d6, $34a0
0050C6  bra.w  $34cc
0050CA  or.w   d2, (a3)+
0050CC  or.w   d2, (a4)+
0050CE  or.w   d2, (a1)+
0050D0  not.w  d2
0050D2  move.l d4, (a3)+
0050D4  move.l d4, (a4)+
0050D6  move.l d4, (a1)+
0050D8  move.l d4, (a3)+
0050DA  move.l d4, (a4)+
0050DC  move.l d4, (a1)+
0050DE  move.l d4, (a3)+
0050E0  move.l d4, (a4)+
0050E2  move.l d4, (a1)+
0050E4  move.l d4, (a3)+
0050E6  move.l d4, (a4)+
0050E8  move.l d4, (a1)+
0050EA  swap   d2
0050EC  or.w   d2, (a3)+
0050EE  or.w   d2, (a4)+
0050F0  or.w   d2, (a1)+
0050F2  not.w  d2
0050F4  dbra   d6, $34a0
0050F8  bra.w  $34cc
0050FC  or.w   d2, (a3)+
0050FE  or.w   d2, (a4)+
005100  or.w   d2, (a1)+
005102  not.w  d2
005104  move.w d4, (a3)+
005106  move.w d4, (a4)+
005108  move.w d4, (a1)+
00510A  move.l d4, (a3)+
00510C  move.l d4, (a4)+
00510E  move.l d4, (a1)+
005110  move.l d4, (a3)+
005112  move.l d4, (a4)+
005114  move.l d4, (a1)+
005116  move.l d4, (a3)+
005118  move.l d4, (a4)+
00511A  move.l d4, (a1)+
00511C  move.l d4, (a3)+
00511E  move.l d4, (a4)+
005120  move.l d4, (a1)+
005122  swap   d2
005124  or.w   d2, (a3)+
005126  or.w   d2, (a4)+
005128  or.w   d2, (a1)+
00512A  not.w  d2
00512C  dbra   d6, $34a0
005130  bra.w  $34cc
005134  or.w   d2, (a3)+
005136  or.w   d2, (a4)+
005138  or.w   d2, (a1)+
00513A  not.w  d2
00513C  move.l d4, (a3)+
00513E  move.l d4, (a4)+
005140  move.l d4, (a1)+
005142  move.l d4, (a3)+
005144  move.l d4, (a4)+
005146  move.l d4, (a1)+
005148  move.l d4, (a3)+
00514A  move.l d4, (a4)+
00514C  move.l d4, (a1)+
00514E  move.l d4, (a3)+
005150  move.l d4, (a4)+
005152  move.l d4, (a1)+
005154  move.l d4, (a3)+
005156  move.l d4, (a4)+
005158  move.l d4, (a1)+
00515A  swap   d2
00515C  or.w   d2, (a3)+
00515E  or.w   d2, (a4)+
005160  or.w   d2, (a1)+
005162  not.w  d2
005164  dbra   d6, $34a0
005168  bra.w  $34cc
00516C  or.w   d2, (a3)+
00516E  or.w   d2, (a4)+
005170  or.w   d2, (a1)+
005172  not.w  d2
005174  move.w d4, (a3)+
005176  move.w d4, (a4)+
005178  move.w d4, (a1)+
00517A  move.l d4, (a3)+
00517C  move.l d4, (a4)+
00517E  move.l d4, (a1)+
005180  move.l d4, (a3)+
005182  move.l d4, (a4)+
005184  move.l d4, (a1)+
005186  move.l d4, (a3)+
005188  move.l d4, (a4)+
00518A  move.l d4, (a1)+
00518C  move.l d4, (a3)+
00518E  move.l d4, (a4)+
005190  move.l d4, (a1)+
005192  move.l d4, (a3)+
005194  move.l d4, (a4)+
005196  move.l d4, (a1)+
005198  swap   d2
00519A  or.w   d2, (a3)+
00519C  or.w   d2, (a4)+
00519E  or.w   d2, (a1)+
0051A0  not.w  d2
0051A2  dbra   d6, $34a0
0051A6  bra.w  $34cc
0051AA  or.w   d2, (a3)+
0051AC  or.w   d2, (a4)+
0051AE  or.w   d2, (a1)+
0051B0  not.w  d2
0051B2  move.l d4, (a3)+
0051B4  move.l d4, (a4)+
0051B6  move.l d4, (a1)+
0051B8  move.l d4, (a3)+
0051BA  move.l d4, (a4)+
0051BC  move.l d4, (a1)+
0051BE  move.l d4, (a3)+
0051C0  move.l d4, (a4)+
0051C2  move.l d4, (a1)+
0051C4  move.l d4, (a3)+
0051C6  move.l d4, (a4)+
0051C8  move.l d4, (a1)+
0051CA  move.l d4, (a3)+
0051CC  move.l d4, (a4)+
0051CE  move.l d4, (a1)+
0051D0  move.l d4, (a3)+
0051D2  move.l d4, (a4)+
0051D4  move.l d4, (a1)+
0051D6  swap   d2
0051D8  or.w   d2, (a3)+
0051DA  or.w   d2, (a4)+
0051DC  or.w   d2, (a1)+
0051DE  not.w  d2
0051E0  dbra   d6, $34a0
0051E4  bra.w  $34cc
0051E8  or.w   d2, (a3)+
0051EA  or.w   d2, (a4)+
0051EC  or.w   d2, (a1)+
0051EE  not.w  d2
0051F0  move.w d4, (a3)+
0051F2  move.w d4, (a4)+
0051F4  move.w d4, (a1)+
0051F6  move.l d4, (a3)+
0051F8  move.l d4, (a4)+
0051FA  move.l d4, (a1)+
0051FC  move.l d4, (a3)+
0051FE  move.l d4, (a4)+
005200  move.l d4, (a1)+
005202  move.l d4, (a3)+
005204  move.l d4, (a4)+
005206  move.l d4, (a1)+
005208  move.l d4, (a3)+
00520A  move.l d4, (a4)+
00520C  move.l d4, (a1)+
00520E  move.l d4, (a3)+
005210  move.l d4, (a4)+
005212  move.l d4, (a1)+
005214  move.l d4, (a3)+
005216  move.l d4, (a4)+
005218  move.l d4, (a1)+
00521A  swap   d2
00521C  or.w   d2, (a3)+
00521E  or.w   d2, (a4)+
005220  or.w   d2, (a1)+
005222  not.w  d2
005224  dbra   d6, $34a0
005228  bra.w  $34cc
00522C  or.w   d2, (a3)+
00522E  or.w   d2, (a4)+
005230  or.w   d2, (a1)+
005232  not.w  d2
005234  move.l d4, (a3)+
005236  move.l d4, (a4)+
005238  move.l d4, (a1)+
00523A  move.l d4, (a3)+
00523C  move.l d4, (a4)+
00523E  move.l d4, (a1)+
005240  move.l d4, (a3)+
005242  move.l d4, (a4)+
005244  move.l d4, (a1)+
005246  move.l d4, (a3)+
005248  move.l d4, (a4)+
00524A  move.l d4, (a1)+
00524C  move.l d4, (a3)+
00524E  move.l d4, (a4)+
005250  move.l d4, (a1)+
005252  move.l d4, (a3)+
005254  move.l d4, (a4)+
005256  move.l d4, (a1)+
005258  move.l d4, (a3)+
00525A  move.l d4, (a4)+
00525C  move.l d4, (a1)+
00525E  swap   d2
005260  or.w   d2, (a3)+
005262  or.w   d2, (a4)+
005264  or.w   d2, (a1)+
005266  not.w  d2
005268  dbra   d6, $34a0
00526C  bra.w  $34cc
005270  or.w   d2, (a3)+
005272  or.w   d2, (a4)+
005274  or.w   d2, (a1)+
005276  not.w  d2
005278  move.w d4, (a3)+
00527A  move.w d4, (a4)+
00527C  move.w d4, (a1)+
00527E  move.l d4, (a3)+
005280  move.l d4, (a4)+
005282  move.l d4, (a1)+
005284  move.l d4, (a3)+
005286  move.l d4, (a4)+
005288  move.l d4, (a1)+
00528A  move.l d4, (a3)+
00528C  move.l d4, (a4)+
00528E  move.l d4, (a1)+
005290  move.l d4, (a3)+
005292  move.l d4, (a4)+
005294  move.l d4, (a1)+
005296  move.l d4, (a3)+
005298  move.l d4, (a4)+
00529A  move.l d4, (a1)+
00529C  move.l d4, (a3)+
00529E  move.l d4, (a4)+
0052A0  move.l d4, (a1)+
0052A2  move.l d4, (a3)+
0052A4  move.l d4, (a4)+
0052A6  move.l d4, (a1)+
0052A8  swap   d2
0052AA  or.w   d2, (a3)+
0052AC  or.w   d2, (a4)+
0052AE  or.w   d2, (a1)+
0052B0  not.w  d2
0052B2  dbra   d6, $34a0
0052B6  bra.w  $34cc
0052BA  or.w   d2, (a3)+
0052BC  or.w   d2, (a4)+
0052BE  or.w   d2, (a1)+
0052C0  not.w  d2
0052C2  move.l d4, (a3)+
0052C4  move.l d4, (a4)+
0052C6  move.l d4, (a1)+
0052C8  move.l d4, (a3)+
0052CA  move.l d4, (a4)+
0052CC  move.l d4, (a1)+
0052CE  move.l d4, (a3)+
0052D0  move.l d4, (a4)+
0052D2  move.l d4, (a1)+
0052D4  move.l d4, (a3)+
0052D6  move.l d4, (a4)+
0052D8  move.l d4, (a1)+
0052DA  move.l d4, (a3)+
0052DC  move.l d4, (a4)+
0052DE  move.l d4, (a1)+
0052E0  move.l d4, (a3)+
0052E2  move.l d4, (a4)+
0052E4  move.l d4, (a1)+
0052E6  move.l d4, (a3)+
0052E8  move.l d4, (a4)+
0052EA  move.l d4, (a1)+
0052EC  move.l d4, (a3)+
0052EE  move.l d4, (a4)+
0052F0  move.l d4, (a1)+
0052F2  swap   d2
0052F4  or.w   d2, (a3)+
0052F6  or.w   d2, (a4)+
0052F8  or.w   d2, (a1)+
0052FA  not.w  d2
0052FC  dbra   d6, $34a0
005300  bra.w  $34cc
005304  or.w   d2, (a3)+
005306  or.w   d2, (a4)+
005308  or.w   d2, (a1)+
00530A  not.w  d2
00530C  move.w d4, (a3)+
00530E  move.w d4, (a4)+
005310  move.w d4, (a1)+
005312  move.l d4, (a3)+
005314  move.l d4, (a4)+
005316  move.l d4, (a1)+
005318  move.l d4, (a3)+
00531A  move.l d4, (a4)+
00531C  move.l d4, (a1)+
00531E  move.l d4, (a3)+
005320  move.l d4, (a4)+
005322  move.l d4, (a1)+
005324  move.l d4, (a3)+
005326  move.l d4, (a4)+
005328  move.l d4, (a1)+
00532A  move.l d4, (a3)+
00532C  move.l d4, (a4)+
00532E  move.l d4, (a1)+
005330  move.l d4, (a3)+
005332  move.l d4, (a4)+
005334  move.l d4, (a1)+
005336  move.l d4, (a3)+
005338  move.l d4, (a4)+
00533A  move.l d4, (a1)+
00533C  move.l d4, (a3)+
00533E  move.l d4, (a4)+
005340  move.l d4, (a1)+
005342  swap   d2
005344  or.w   d2, (a3)+
005346  or.w   d2, (a4)+
005348  or.w   d2, (a1)+
00534A  not.w  d2
00534C  dbra   d6, $34a0
005350  bra.w  $34cc
005354  ori.b  #$0, d0
005358  ori.b  #$0, d0
00535C  ori.b  #$ac, d5
005360  move.l #$1dc, d0
005366  lea.l  $30.l, a0
00536C  move.l #$4, d1
005372  moveq  #$4, d2
005374  move.w #$120, d3
005378  jsr    -$72(a6)
00537C  move.l #$48a84, d0
005382  lea.l  $110.l, a0
005388  move.l #$438, d1
00538E  moveq  #$4, d2
005390  move.w #$120, d3
005394  jsr    -$72(a6)
005398  move.l #$48a84, d0
00539E  lea.l  $138.l, a0
0053A4  move.l #$438, d1
0053AA  moveq  #$4, d2
0053AC  move.w #$120, d3
0053B0  jsr    -$72(a6)
0053B4  lea.l  $78.l, a0
0053BA  lea.l  $53e0.l, a1
0053C0  moveq  #$10, d0
0053C2  moveq  #$10, d1
0053C4  jsr    -$9c(a6)
0053C8  jsr    $55b6.l
0053CE  lea.l  $51bac.l, a1
0053D4  lea.l  $5508.l, a0
0053DA  jsr    -$108(a6)
0053DE  rts    
0053E0  ori.b  #$ff, d0
0053E4  ; data: 0x0f, 0xff
0053E6  ; data: 0x0f, 0xff
0053E8  ori.b  #$ff, d0
0053EC  ; data: 0x0f, 0xff
0053EE  ; data: 0x0f, 0xff
0053F0  ori.b  #$ff, d0
0053F4  ; data: 0x0f, 0xff
0053F6  ; data: 0x0f, 0xff
0053F8  ori.b  #$ff, d0
0053FC  ; data: 0x0f, 0xff
0053FE  ; data: 0x0f, 0xff
005400  bchg.b #$0, $535a.l
005408  beq.w  $5506
00540C  move.w $5358(pc), d0
005410  addq.w #$1, d0
005412  cmp.w  #$10e, d0
005416  bcs.b  $541a
005418  moveq  #$0, d0
00541A  move.w d0, $5358.l
005420  move.w #$10d, d1
005424  sub.w  d0, d1
005426  lsl.w  #$8, d1
005428  bcs.b  $5438
00542A  add.w  #$2c4f, d1
00542E  bcc.b  $543e
005430  move.w d1, d2
005432  move.w #$ffdf, d1
005436  bra.b  $5440
005438  move.w #$ffff, d1
00543C  bra.b  $5440
00543E  move.w d1, d2
005440  move.w d1, $130.l
005446  move.w d2, $134.l
00544C  lea.l  $48a84.l, a0
005452  mulu.w #$4, d0
005456  adda.w d0, a0
005458  move.l a0, d0
00545A  lea.l  $110.l, a0
005460  move.l #$438, d1
005466  moveq  #$4, d2
005468  move.w #$120, d3
00546C  jsr    -$72(a6)
005470  move.w $5358(pc), d0
005474  sub.w  #$a, d0
005478  bcc.b  $547e
00547A  add.w  #$10e, d0
00547E  ext.l  d0
005480  divu.w #$a, d0
005484  swap   d0
005486  tst.w  d0
005488  bne.b  $5506
00548A  movea.l $535c(pc), a0
00548E  cmpi.b #$23, (a0)
005492  bne.b  $549c
005494  lea.l  $15c.l, a0
00549A  bra.b  $54ae
00549C  movea.l a0, a1
00549E  cmpi.b #$a, (a1)+
0054A2  bne.b  $549e
0054A4  clr.b  -$1(a1)
0054A8  move.l a1, $535c.l
0054AE  lea.l  $518dc.l, a1
0054B4  moveq  #$11, d2
0054B6  moveq  #$0, d1
0054B8  move.l d1, (a1)+
0054BA  dbra   d2, $54b8
0054BE  lea.l  $518dc.l, a1
0054C4  tst.b  (a0)
0054C6  beq.b  $54d4
0054C8  move.l d0, -(a7)
0054CA  moveq  #$0, d0
0054CC  jsr    $5518.l
0054D2  move.l (a7)+, d0
0054D4  swap   d0
0054D6  mulu.w #$28, d0
0054DA  lea.l  $48a84.l, a0
0054E0  adda.w d0, a0
0054E2  lea.l  $518dc.l, a1
0054E8  moveq  #$9, d0
0054EA  movem.w (a1), d1-d4
0054EE  move.w d1, (a0)
0054F0  move.w d2, $438(a0)
0054F4  move.w d3, $870(a0)
0054F8  move.w d4, $ca8(a0)
0054FC  addq.w #$4, a0
0054FE  adda.w #$8, a1
005502  dbra   d0, $54ea
005506  rts    
005508  moveq  #$78, d2
00550A  moveq  #$2e, d2
00550C  subq.w #$1, -(a3)
00550E  moveq  #$6f, d1
005510  bge.b  $557e
005512  moveq  #$65, d2
005514  moveq  #$74, d4
005516  ori.b  #$e7, d0
00551A  move.w $2849.w, d4
00551E  move.w d0, d4
005520  movea.l a0, a2
005522  moveq  #$0, d3
005524  lea.l  $51b2c.l, a3
00552A  bra.b  $5538
00552C  move.w d4, d0
00552E  move.b (a3, d1.w), d3
005532  add.w  d3, d4
005534  movea.l a4, a0
005536  bsr.b  $5544
005538  moveq  #$0, d1
00553A  move.b (a2)+, d1
00553C  bne.b  $552c
00553E  movem.l (a7)+, d2-d4/a2-a4
005542  rts    
005544  moveq  #$f, d2
005546  and.w  d0, d2
005548  neg.w  d2
00554A  add.w  #$18, d2
00554E  lsr.w  #$4, d0
005550  add.w  d0, d0
005552  adda.w d0, a0
005554  lea.l  $5192c.l, a1
00555A  ext.w  d1
00555C  add.w  d1, d1
00555E  add.w  d1, d1
005560  movea.l (a1, d1.w), a1
005564  moveq  #$0, d1
005566  move.b (a1), d1
005568  lsl.l  d2, d1
00556A  or.l   d1, (a0)
00556C  moveq  #$0, d1
00556E  move.b $52(a1), d1
005572  lsl.l  d2, d1
005574  or.l   d1, $8(a0)
005578  moveq  #$0, d1
00557A  move.b $a4(a1), d1
00557E  lsl.l  d2, d1
005580  or.l   d1, $10(a0)
005584  moveq  #$0, d1
005586  move.b $f6(a1), d1
00558A  lsl.l  d2, d1
00558C  or.l   d1, $18(a0)
005590  moveq  #$0, d1
005592  move.b $148(a1), d1
005596  lsl.l  d2, d1
005598  or.l   d1, $20(a0)
00559C  moveq  #$0, d1
00559E  move.b $19a(a1), d1
0055A2  lsl.l  d2, d1
0055A4  or.l   d1, $28(a0)
0055A8  moveq  #$0, d1
0055AA  move.b $1ec(a1), d1
0055AE  lsl.l  d2, d1
0055B0  or.l   d1, $30(a0)
0055B4  rts    
0055B6  movem.l a2-a4, -(a7)
0055BA  lea.l  $5192c.l, a0
0055C0  lea.l  $51b2c.l, a1
0055C6  lea.l  $56a1(pc), a2
0055CA  lea.l  $564f(pc), a3
0055CE  lea.l  $55fc(pc), a4
0055D2  bsr.b  $55f4
0055D4  subq.l #$1, a2
0055D6  move.l a2, $17c(a0)
0055DA  move.b #$4, $5f(a1)
0055E0  movem.l (a7)+, a2-a4
0055E4  rts    
0055E6  move.b (a3)+, (a1, d0.w)
0055EA  add.w  d0, d0
0055EC  add.w  d0, d0
0055EE  move.l a2, (a0, d0.w)
0055F2  addq.l #$1, a2
0055F4  moveq  #$0, d0
0055F6  move.b (a4)+, d0
0055F8  bne.b  $55e6
0055FA  rts    
0055FC  ; data: 0x41, 0x42
0055FE  ; data: 0x43, 0x44
005600  ; data: 0x45, 0x46
005602  ; data: 0x47, 0x48
005604  ; data: 0x49, 0x4a
005606  ; data: 0x4b, 0x4c
005608  ; data: 0x4d, 0x4e
00560A  ; data: 0x4f, 0x50
00560C  subq.w #$8, (a2)
00560E  subq.w #$1, (a4)
005610  subq.w #$2, (a6)
005612  subq.w #$3, (a0)+
005614  subq.w #$4, (a2)+
005616  move.l ([$33343536, a0, d3.w], $3738), -(a1)
005620  move.w $2c2d(a6), -(a4)
005624  move.l -(a1), -(a5)
005626  move.w $9150(pc), -(a7)
00562A  move.l -(a0), $225b(a4)
00562E  subq.w #$6, (a6)+
005630  ; data: 0x2f, 0x3e
005632  move.w -(a0), d6
005634  bsr.b  $5698
005636  bls.b  $569c
005638  bcs.b  $56a0
00563A  beq.b  $56a4
00563C  bvs.b  $56a8
00563E  bmi.b  $56ac
005640  blt.b  $56b0
005642  ble.b  $56b4
005644  ; data: 0x71, 0x72
005646  ; data: 0x73, 0x74
005648  ; data: 0x75, 0x76
00564A  ; data: 0x77, 0x78
00564C  ; data: 0x79, 0x7a
00564E  ori.b  #$5, d5
005652  btst.l d2, d5
005654  btst.l d2, d5
005656  btst.l d2, d2
005658  btst.l d2, d5
00565A  btst.l d2, d6
00565C  btst.l d2, d5
00565E  btst.l d2, d5
005660  btst.l d2, d5
005662  subi.b #$6, d5
005666  btst.l d2, d5
005668  btst.l d2, d7
00566A  btst.l d2, d2
00566C  btst.l d2, d5
00566E  btst.l d2, d5
005670  btst.l d2, d5
005672  btst.l d2, d5
005674  andi.b #$4, d3
005678  andi.b #$3, d5
00567C  btst.l d1, d3
00567E  btst.l d1, d4
005680  btst.l d1, d3
005682  subi.b #$5, d6
005686  subi.b #$4, d5
00568A  subi.b #$5, d5
00568E  subi.b #$4, d2
005692  btst.l d1, d6
005694  subi.b #$4, d4
005698  subi.b #$4, d5
00569C  subi.b #$4, d6
0056A0  bchg.b d2, -(a0)
0056A2  roxr.w d0, d0
0056A4  roxr.w d0, d0
0056A6  moveq  #$70, d0
0056A8  sub.l  d0, d0
0056AA  dc.w   $f090
0056AC  ; data: 0x80, 0x88
0056AE  sub.w  -(a0), d0
0056B0  asr.w  d0, d0
0056B2  roxr.w d0, d0
0056B4  roxr.l #$8, d0
0056B6  sub.l  a0, d0
0056B8  sub.l  (a0), d0
0056BA  dc.w   $f078
0056BC  bra.b  $563e
0056BE  asr.w  -(a0)
0056C0  suba.w -$20(a0, d6.w), a0
0056C4  bra.b  $5726
0056C6  ori.b  #$0, d0
0056CA  divu.w -(a0), d0
0056CC  ori.b  #$80, d0
0056D0  negx.l -(a0)
0056D2  mulu.w d0, d0
0056D4  negx.b (a0)
0056D6  or.b   (a0), d0
0056D8  ori.b  #$0, d0
0056DC  move.l d0, d0
0056DE  move.l d0, d0
0056E0  or.l   d0, d0
0056E2  negx.l d0
0056E4  or.b   d0, d0
0056E6  ori.b  #$0, d0
0056EA  ori.b  #$0, d0
0056EE  ori.b  #$0, d0
0056F2  ori.l  #$90809080, (a0)
0056F8  or.l   d0, d0
0056FA  sub.l  d0, d0
0056FC  move.b (a0), (a0)
0056FE  divu.w (a0)+, d0
005700  add.l  (a0), d0
005702  sub.l  (a0), d0
005704  sub.l  d0, d0
005706  negx.l (a0)
005708  sub.l  a0, d0
00570A  sub.l  (a0), d0
00570C  move.b d4, (a0)
00570E  sub.l  d0, d0
005710  move.b (a0), d0
005712  sub.l  d0, d0
005714  or.b   (a0), d0
005716  sub.l  (a0), d0
005718  ori.b  #$0, d0
00571C  or.b   (a0), d0
00571E  ori.b  #$40, d0
005722  or.l   -(a0), d0
005724  or.w   d0, d0
005726  ; data: 0xa0, 0x10
005728  negx.b -(a0)
00572A  ori.b  #$0, d0
00572E  move.l d0, d0
005730  negx.b d0
005732  or.b   d0, d0
005734  ori.l  #$80000000, d0
00573A  ori.b  #$0, d0
00573E  asr.b  #$8, d0
005740  ori.b  #$0, d0
005744  ; data: 0x00, 0xf0
005746  dc.w   $f080
005748  suba.w -(a0), a0
00574A  roxr.l d0, d0
00574C  dc.w   $f080
00574E  move.b -(a0), (a0)
005750  or.l   -$4f70(a0), d0
005754  sub.l  (a0), d0
005756  asr.w  d0, d0
005758  negx.l (a0)
00575A  sub.l  a0, d0
00575C  bra.b  $57ce
00575E  move.l -$80(a4, a1.w), (a0)
005762  move.b (a0), d0
005764  sub.l  d0, d0
005766  or.b   (a0), d0
005768  sub.l  (a0), d0
00576A  ori.b  #$40, d0
00576E  or.b   (a0), d0
005770  or.w   d0, d0
005772  or.w   d0, d0
005774  ori.b  #$40, d0
005778  ori.b  #$40, -(a0)
00577C  ori.w  #$c060, -(a0)
005780  bra.b  $57e2
005782  roxr.w d0, d0
005784  and.l  d0, d0
005786  negx.l -(a0)
005788  or.w   $6040.w, d0
00578C  and.w  -(a0), d0
00578E  ; data: 0xa0, 0x60
005790  negx.l -(a0)
005792  ; data: 0xa0, 0xa8
005794  ; data: 0xa0, 0xa0
005796  roxr.l #$8, d0
005798  sub.l  d0, d0
00579A  sub.l  d0, d0
00579C  or.l   (a0), d0
00579E  sub.l  d0, d0
0057A0  move.b -(a0), (a0)+
0057A2  ; data: 0x80, 0x88
0057A4  sub.l  (a0), d0
0057A6  roxr.l #$8, d0
0057A8  sub.b  (a0), d0
0057AA  negx.l (a0)
0057AC  sub.l  a0, d0
0057AE  sub.b  (a0), d0
0057B0  negx.l -(a4)
0057B2  sub.l  d0, d0
0057B4  bra.b  $5816
0057B6  dc.w   $f060
0057B8  roxr.w d0, d0
0057BA  bra.b  $582c
0057BC  ori.b  #$e0, d0
0057C0  or.b   -(a0), d0
0057C2  ori.b  #$40, d0
0057C6  ori.b  #$40, d0
0057CA  ori.w  #$1080, -(a0)
0057CE  ori.b  #$80, (a0)
0057D2  ; data: 0xa0, 0x90
0057D4  negx.l (a0)
0057D6  ; data: 0xa0, 0x80
0057D8  negx.l -(a0)
0057DA  or.l   -$5f60(a0), d0
0057DE  ; data: 0xa0, 0xa0
0057E0  and.l  d0, d0
0057E2  negx.l -(a0)
0057E4  ; data: 0xa0, 0xa8
0057E6  ; data: 0xa0, 0xa0
0057E8  move.l (a0), (a0)
0057EA  sub.l  d0, d0
0057EC  sub.l  d0, d0
0057EE  or.l   (a0), d0
0057F0  sub.l  d0, d0
0057F2  move.b (a0), (a0)
0057F4  ; data: 0x80, 0x88
0057F6  sub.l  (a0), d0
0057F8  or.l   (a0), d0
0057FA  sub.b  (a0), d0
0057FC  negx.l (a0)
0057FE  sub.l  -$6fe0(a0), d0
005802  or.l   -$80(a4, a1.w), d0
005806  or.b   (a0), d0
005808  move.b (a0), d0
00580A  sub.b  (a0), d0
00580C  sub.b  (a0), d0
00580E  ori.b  #$40, d0
005812  or.w   d0, d0
005814  or.w   d0, d0
005816  or.w   d0, d0
005818  ori.b  #$40, d0
00581C  ori.w  #$2040, d0
005820  ori.w  #$a080, -$20(a0, a2.w)
005826  negx.w -$80(a0, a2.w)
00582A  move.w sr, d0
00582C  or.l   -$5f60(a0), d0
005830  ; data: 0xa0, 0xa0
005832  or.w   d0, d0
005834  negx.l -(a0)
005836  ; data: 0xa0, 0xa8
005838  negx.w d0
00583A  negx.l (a0)
00583C  sub.l  d0, d0
00583E  sub.l  d0, d0
005840  or.l   (a0), d0
005842  sub.l  d0, d0
005844  sub.l  (a0), d0
005846  ; data: 0x80, 0x88
005848  sub.l  (a0), d0
00584A  or.l   $10(a0, a1.w), d0
00584E  negx.l (a0)
005850  st.b   (a0)+
005852  sub.w  d0, d0
005854  or.l   d4, d0
005856  sub.l  d0, d0
005858  or.b   (a0), d0
00585A  move.b (a0), d0
00585C  sub.b  (a0), d0
00585E  sub.b  (a0), d0
005860  ori.w  #$0, d0
005864  ori.b  #$80, d0
005868  or.w   d0, d0
00586A  ori.b  #$40, d0
00586E  ori.l  #$40200090, d0
005874  ; data: 0xa0, 0x80
005876  ; data: 0xa0, 0x80
005878  negx.b (a0)
00587A  ; data: 0xa0, 0x80
00587C  negx.l -(a0)
00587E  or.l   -$5f60(a0), d0
005882  and.w  -(a0), d0
005884  or.b   -(a0), d0
005886  negx.l -(a0)
005888  ; data: 0xa0, 0xa8
00588A  ; data: 0xa0, 0x80
00588C  or.l   (a0), d0
00588E  roxr.w d0, d0
005890  roxr.w d0, d0
005892  or.w   -(a0), d0
005894  sub.l  d0, d0
005896  bra.b  $5828
005898  moveq  #$88, d0
00589A  sub.w  -(a0), d0
00589C  or.w   -$20(a0, a1.w), d0
0058A0  negx.w -(a0)
0058A2  move.l a0, (a0)
0058A4  sub.l  d0, d0
0058A6  dc.w   $f078
0058A8  bra.b  $582a
0058AA  dc.w   $f0e0
0058AC  move.b -(a0), (a0)+
0058AE  bra.b  $58c0
0058B0  bra.b  $5912
0058B2  or.l   d0, d0
0058B4  ori.b  #$40, d0
0058B8  ori.b  #$80, d0
0058BC  ori.b  #$c0, d0
0058C0  ori.l  #$80100070, d0
0058C6  and.w  -(a0), d0
0058C8  bra.b  $592a
0058CA  negx.w -(a0)
0058CC  ; data: 0xa0, 0x80
0058CE  or.l   -(a0), d0
0058D0  negx.l -$5fc0(a0)
0058D4  or.b   -(a0), d0
0058D6  divu.w d0, d0
0058D8  movea.l -(a0), a0
0058DA  negx.w (a0)
0058DC  ; data: 0xa0, 0x80
0058DE  asr.b  #$8, d0
0058E0  jmp    $59ee.l
0058E6  jmp    $59d2.l
0058EC  jmp    $59ce.l
0058F2  movem.l d2-d7/a0-a4, -(a7)
0058F6  movea.l a0, a2
0058F8  movea.l a1, a3
0058FA  movea.l $34(a3), a4
0058FE  movem.l $1c(a2), d0-d2
005904  lea.l  $1c(a4), a1
005908  sub.l  (a1)+, d0
00590A  bpl.b  $590e
00590C  neg.l  d0
00590E  sub.l  (a1)+, d1
005910  bpl.b  $5914
005912  neg.l  d1
005914  sub.l  (a1)+, d2
005916  bpl.b  $591a
005918  neg.l  d2
00591A  add.l  d2, d0
00591C  add.l  d1, d0
00591E  cmp.l  #$7fff, d0
005924  bcs.b  $592a
005926  move.w #$7fff, d0
00592A  move.w d2, $3a(a3)
00592E  movem.l $1c(a2), d0-d2
005934  lea.l  $1c(a4), a0
005938  sub.l  (a0)+, d0
00593A  sub.l  (a0)+, d1
00593C  sub.l  (a0)+, d2
00593E  ext.l  d0
005940  ext.l  d1
005942  ext.l  d2
005944  asr.l  #$2, d0
005946  asr.l  #$2, d1
005948  asr.l  #$2, d2
00594A  lea.l  $28(a2), a0
00594E  bsr.w  $de4
005952  cmp.w  #$1fff, d2
005956  ble.b  $595c
005958  move.w #$1fff, d2
00595C  cmp.w  #$e001, d2
005960  bge.b  $5966
005962  move.w #$e001, d2
005966  asl.w  #$2, d2
005968  neg.w  d2
00596A  cmp.w  #$a, d2
00596E  ble.b  $59a8
005970  move.w $38(a3), d5
005974  move.w d0, d3
005976  move.w d1, d4
005978  muls.w d5, d3
00597A  muls.w d5, d4
00597C  moveq  #$0, d6
00597E  divs.w d2, d3
005980  addx.w d6, d3
005982  divs.w d2, d4
005984  neg.w  d4
005986  addx.w d6, d4
005988  move.w d5, d6
00598A  neg.w  d6
00598C  cmp.w  d5, d4
00598E  ble.b  $5992
005990  move.w d5, d4
005992  cmp.w  d6, d4
005994  bge.b  $5998
005996  move.w d6, d4
005998  cmp.w  d5, d3
00599A  ble.b  $599e
00599C  move.w d5, d3
00599E  cmp.w  d6, d3
0059A0  bge.b  $59a4
0059A2  move.w d6, d3
0059A4  bra.w  $59bc
0059A8  move.w $38(a3), d3
0059AC  move.w d3, d4
0059AE  neg.w  d4
0059B0  tst.w  d0
0059B2  bpl.b  $59b6
0059B4  neg.w  d3
0059B6  tst.w  d1
0059B8  bpl.b  $59bc
0059BA  neg.w  d4
0059BC  move.w d3, $2(a3)
0059C0  move.w d4, (a3)
0059C2  move.w d3, $4(a3)
0059C6  movem.l (a7)+, d2-d7/a0-a4
0059CA  jmp    $2594(pc)
0059CE  moveq  #$3c, d0
0059D0  rts    
0059D2  move.l (a1), $34(a0)
0059D6  move.w $4(a1), $30(a0)
0059DC  move.w $6(a1), $38(a0)
0059E2  move.w #$7fff, $3a(a0)
0059E8  jsr    $250c(pc)
0059EC  rts    
0059EE  jmp    $249e(pc)
0059F2  jmp    $5a7e.l
0059F8  jmp    $5a6c.l
0059FE  jmp    $5a68.l
005A04  movem.l d2/a0-a2, -(a7)
005A08  move.w $34(a5), d0
005A0C  sub.w  d0, $3e(a1)
005A10  bmi.b  $5a5a
005A12  movea.l $34(a1), a2
005A16  movem.l $1c(a0), d0-d2
005A1C  lea.l  $1c(a2), a2
005A20  sub.l  (a2)+, d0
005A22  bpl.b  $5a26
005A24  neg.l  d0
005A26  sub.l  (a2)+, d1
005A28  bpl.b  $5a2c
005A2A  neg.l  d1
005A2C  sub.l  (a2)+, d2
005A2E  bpl.b  $5a32
005A30  neg.l  d2
005A32  add.l  d2, d0
005A34  add.l  d1, d0
005A36  move.w $3c(a1), d1
005A3A  ext.l  d1
005A3C  cmp.w  d1, d0
005A3E  bhi.b  $5a60
005A40  movem.l a0-a2, -(a7)
005A44  movea.l $34(a1), a0
005A48  movea.l $c(a0), a2
005A4C  movea.l $10(a0), a1
005A50  moveq  #$2, d0
005A52  jsr    -$12(a2)
005A56  movem.l (a7)+, a0-a2
005A5A  moveq  #$2, d0
005A5C  bsr.w  $59ee
005A60  movem.l (a7)+, d2/a0-a2
005A64  jmp    $58f2(pc)
005A68  moveq  #$40, d0
005A6A  rts    
005A6C  move.w $8(a1), $3c(a0)
005A72  move.w #$1f4, $3e(a0)
005A78  jsr    $59d2(pc)
005A7C  rts    
005A7E  jmp    $59ee(pc)
005A82  move.l a1, $5aee.l
005A88  movea.l $10(a0), a1
005A8C  move.w $30(a1), d0
005A90  add.w  #$64, d0
005A94  move.w d0, $5af2.l
005A9A  lea.l  $5ada.l, a1
005AA0  moveq  #$5, d0
005AA2  lea.l  $1c(a0), a0
005AA6  move.w (a0)+, (a1)+
005AA8  dbra   d0, $5aa6
005AAC  move.l a0, -(a7)
005AAE  lea.l  $5aca(pc), a0
005AB2  bsr.w  $2314
005AB6  movea.l (a7)+, a0
005AB8  movea.l d0, a1
005ABA  lea.l  $28(a1), a1
005ABE  move.l (a0)+, (a1)+
005AC0  move.l (a0)+, (a1)+
005AC2  move.l (a0)+, (a1)+
005AC4  move.l (a0)+, (a1)+
005AC6  move.w (a0)+, (a1)+
005AC8  rts    
005ACA  ori.b  #$4, d0
005ACE  ori.b  #$ee, d0
005AD2  ori.b  #$e6, d0
005AD6  ori.b  #$f8, d0
005ADA  ori.b  #$0, d0
005ADE  ori.b  #$0, d0
005AE2  ori.b  #$0, d0
005AE6  ori.b  #$0, d0
005AEA  ori.b  #$0, d0
005AEE  ori.b  #$0, d0
005AF2  ori.b  #$aa, d0
005AF6  bset.b d3, (a0)
005AF8  ori.b  #$ac, d0
005AFC  ori.b  #$0, d0
005B00  jmp    $5b36.l
005B06  jmp    $5b2a.l
005B0C  jmp    $5b26.l
005B12  move.w $3a(a1), d0
005B16  bmi.b  $5b22
005B18  sub.w  $3c(a1), d0
005B1C  asr.w  #$4, d0
005B1E  move.w d0, $30(a1)
005B22  jmp    $58f2(pc)
005B26  moveq  #$40, d0
005B28  rts    
005B2A  move.w $8(a1), $3c(a0)
005B30  jsr    $59d2(pc)
005B34  rts    
005B36  jmp    $59ee(pc)
005B3A  jmp    $5bc0.l
005B40  jmp    $5ba4.l
005B46  jmp    $5ba0.l
005B4C  move.w $34(a5), d0
005B50  sub.w  d0, $40(a1)
005B54  bpl.b  $5b9c
005B56  move.w $30(a1), d0
005B5A  move.w d0, d1
005B5C  sub.w  $42(a1), d0
005B60  move.w d1, $42(a1)
005B64  add.w  #$32, d0
005B68  cmp.w  #$64, d0
005B6C  bhi.b  $5b9c
005B6E  move.w #$82, $40(a1)
005B74  movem.l a0-a1, -(a7)
005B78  movea.l $34(a1), a1
005B7C  bsr.w  $5a82
005B80  movea.l d0, a0
005B82  movea.l $28(a5), a1
005B86  bsr.w  $1f1a
005B8A  movem.l (a7), a0
005B8E  jsr    $7520.l
005B94  movem.l (a7)+, a0-a1
005B98  move.l d0, $34(a1)
005B9C  jmp    $5b12(pc)
005BA0  moveq  #$44, d0
005BA2  rts    
005BA4  movem.l a0-a1, -(a7)
005BA8  bsr.w  $7520
005BAC  movem.l (a7)+, a0-a1
005BB0  move.l d0, $34(a0)
005BB4  move.w #$fa, $40(a0)
005BBA  jsr    $5b2a(pc)
005BBE  rts    
005BC0  jmp    $5b36(pc)
005BC4  ori.b  #$0, d0
005BC8  ori.b  #$0, d0
005BCC  ori.b  #$0, d0
005BD0  ori.b  #$0, d0
005BD4  ori.b  #$0, d0
005BD8  ori.b  #$0, d0
005BDC  ori.b  #$0, d0
005BE0  ori.b  #$0, d0
005BE4  bsr.w  $22b4
005BE8  movea.l d0, a4
005BEA  move.l d0, $5bcc.l
005BF0  movea.l d0, a0
005BF2  lea.l  $5ca4(pc), a1
005BF6  bsr.w  $20fc
005BFA  movea.l $5bdc(pc), a0
005BFE  movea.l a4, a1
005C00  jsr    $239e(pc)
005C04  move.l a4, $20(a5)
005C08  bsr.w  $22b4
005C0C  movea.l d0, a4
005C0E  move.l d0, $5bc8.l
005C14  movea.l d0, a0
005C16  lea.l  $5fcc(pc), a1
005C1A  bsr.w  $20fc
005C1E  movea.l $5bdc(pc), a0
005C22  movea.l a4, a1
005C24  jsr    $239e(pc)
005C28  bsr.w  $22b4
005C2C  movea.l d0, a4
005C2E  move.l d0, $5bc4.l
005C34  movea.l d0, a0
005C36  lea.l  $6538(pc), a1
005C3A  bsr.w  $20fc
005C3E  movea.l $5bdc(pc), a0
005C42  movea.l a4, a1
005C44  jsr    $239e(pc)
005C48  move.l a4, $20(a5)
005C4C  bsr.w  $22b4
005C50  movea.l d0, a4
005C52  move.l d0, $5bd8.l
005C58  movea.l d0, a0
005C5A  lea.l  $6890(pc), a1
005C5E  bsr.w  $20fc
005C62  bsr.w  $22b4
005C66  movea.l d0, a4
005C68  move.l d0, $5bd0.l
005C6E  movea.l d0, a0
005C70  lea.l  $6b46(pc), a1
005C74  bsr.w  $20fc
005C78  movea.l $5bdc(pc), a0
005C7C  movea.l a4, a1
005C7E  jsr    $239e(pc)
005C82  bsr.w  $22b4
005C86  movea.l d0, a4
005C88  move.l d0, $5bd4.l
005C8E  movea.l d0, a0
005C90  lea.l  $6fb6(pc), a1
005C94  bsr.w  $20fc
005C98  movea.l $5bdc(pc), a0
005C9C  movea.l a4, a1
005C9E  jsr    $239e(pc)
005CA2  rts    
005CA4  ori.b  #$4, d0
005CA8  ori.b  #$c, d0
005CAC  ori.b  #$b8, d0
005CB0  ori.b  #$0, d0
005CB4  ori.b  #$0, d0
005CB8  ori.b  #$0, d0
005CBC  ori.b  #$0, d0
005CC0  ori.b  #$5, d0
005CC4  ori.b  #$c2, d0
005CC8  ori.b  #$1, d0
005CCC  ori.b  #$cc, d0
005CD0  ori.b  #$1, d0
005CD4  ori.b  #$96, d0
005CD8  ori.b  #$5, d0
005CDC  ori.b  #$8c, d0
005CE0  ori.b  #$1, d0
005CE4  ori.b  #$60, d0
005CE8  ori.b  #$5, d0
005CEC  ori.b  #$dc, d0
005CF0  ori.b  #$4, d0
005CF4  ori.b  #$c, d0
005CF8  ori.b  #$90, d0
005CFC  ori.b  #$e8, d0
005D00  ori.b  #$b8, d0
005D04  ori.b  #$3c, $50(a2, d0.w)
005D0A  ori.b  #$0, d0
005D0E  ori.b  #$0, d4
005D12  ; data: 0x5f, 0x0c
005D14  ori.b  #$d0, d0
005D18  ; data: 0xff, 0xff
005D1A  dc.w   $f448
005D1C  ori.b  #$90, d0
005D20  ori.b  #$1e, (a6)+
005D24  ori.b  #$0, ccr
005D28  ori.b  #$4, d0
005D2C  ori.b  #$c, d0
005D30  ; data: 0xff, 0xff
005D32  dc.w   $f254
005D34  ori.b  #$d0, d0
005D38  ori.b  #$90, d0
005D3C  ori.b  #$46, (a4)
005D40  ori.b  #$0, (a4)
005D44  ori.b  #$4, d0
005D48  ori.b  #$8c, d0
005D4C  ; data: 0xff, 0xff
005D4E  dc.w   $fa24
005D50  ori.b  #$e8, d0
005D54  ori.b  #$0, d0
005D58  subi.b #$0, d0
005D5C  ori.b  #$0, d0
005D60  ori.b  #$4, d0
005D64  ori.b  #$4c, d0
005D68  ori.b  #$60, d0
005D6C  ori.b  #$e8, d0
005D70  ori.b  #$fc, d0
005D74  ori.b  #$0, d0
005D78  ori.b  #$0, d0
005D7C  ori.b  #$4, d0
005D80  ori.b  #$8c, d0
005D84  ori.b  #$e8, d0
005D88  ori.b  #$48, d0
005D8C  ; data: 0xff, 0xff
005D8E  dc.w   $f448
005D90  subi.b #$0, d0
005D94  ori.b  #$0, d0
005D98  ori.b  #$4, d0
005D9C  ori.b  #$4c, d0
005DA0  ; data: 0xff, 0xff
005DA2  ; data: 0xf9, 0xc0
005DA4  ori.b  #$98, d0
005DA8  ; data: 0xff, 0xff
005DAA  dc.w   $f63c
005DAC  ori.b  #$0, d0
005DB0  ori.b  #$0, d0
005DB4  ori.b  #$4, d0
005DB8  ori.b  #$c, d0
005DBC  ori.b  #$f4, d0
005DC0  ori.b  #$b8, d0
005DC4  ori.b  #$d0, d0
005DC8  ori.b  #$1e, $32(a2, d0.w)
005DCE  ori.b  #$0, d0
005DD2  ori.b  #$0, d4
005DD6  subq.l #$7, a4
005DD8  ori.b  #$60, d0
005DDC  ; data: 0xff, 0xff
005DDE  dc.w   $fc18
005DE0  ori.b  #$fc, d0
005DE4  subi.b #$0, d0
005DE8  ori.b  #$0, d0
005DEC  ori.b  #$4, d0
005DF0  ori.b  #$c, d0
005DF4  ori.b  #$d0, d0
005DF8  ; data: 0xff, 0xff
005DFA  dc.w   $f448
005DFC  ; data: 0xff, 0xff
005DFE  dc.w   $f448
005E00  ori.w  #$14, (a0)
005E04  ori.b  #$0, $0(a0)
005E0A  ori.b  #$0, d4
005E0E  subq.w #$7, a4
005E10  ori.b  #$98, d0
005E14  ori.b  #$f4, d0
005E18  ori.b  #$0, d0
005E1C  ori.b  #$0, d0
005E20  ori.b  #$0, d0
005E24  ori.b  #$4, d0
005E28  ori.b  #$8c, d0
005E2C  ; data: 0xff, 0xff
005E2E  dc.w   $f448
005E30  ; data: 0xff, 0xff
005E32  dc.w   $f6a0
005E34  ori.b  #$dc, d0
005E38  subi.b #$0, d0
005E3C  ori.b  #$0, d0
005E40  ori.b  #$4, d0
005E44  ori.b  #$4c, d0
005E48  ; data: 0xff, 0xff
005E4A  ; data: 0xf7, 0x04
005E4C  ori.b  #$14, d0
005E50  ; data: 0xff, 0xff
005E52  dc.w   $f95c
005E54  ori.b  #$0, d0
005E58  ori.b  #$0, d0
005E5C  ori.b  #$0, d0
005E60  ori.b  #$12, d0
005E64  ori.b  #$8c, d0
005E68  ori.b  #$e6, d0
005E6C  ori.b  #$84, d0
005E70  ; data: 0xff, 0xff
005E72  lsr.l  d2, d0
005E74  ori.b  #$88, d0
005E78  ori.b  #$80, d0
005E7C  addi.b #$0, d0
005E80  bchg.b d0, d6
005E82  ori.b  #$0, d0
005E86  divs.w #$0, d4
005E8A  ori.b  #$0, d0
005E8E  ori.b  #$ce, d0
005E92  ; data: 0x00, 0x3c
005E94  addi.l #$5b4c, -(a4)
005E9A  ori.b  #$c2, d0
005E9E  ori.b  #$e6, d0
005EA2  ori.b  #$ba, d0
005EA6  ; data: 0xff, 0xff
005EA8  lsr.l  d2, d0
005EAA  ori.b  #$88, d0
005EAE  ori.b  #$70, d0
005EB2  andi.b #$0, d0
005EB6  ori.b  #$0, d0
005EBA  ori.b  #$f0, d0
005EBE  ori.b  #$0, d0
005EC2  ori.b  #$0, d0
005EC6  ori.b  #$14, d0
005ECA  subi.l #$2520, (a0, d0.w)
005ED2  sgt.b  (a0, d0.w)
005ED6  move.l -(a6), (a3)+
005ED8  ori.b  #$4, d0
005EDC  ori.b  #$d0, d0
005EE0  ori.b  #$0, d0
005EE4  ori.b  #$70, d0
005EE8  ori.b  #$0, d0
005EEC  ori.b  #$0, d0
005EF0  ori.b  #$0, d0
005EF4  ori.b  #$0, d0
005EF8  ; data: 0xff, 0xff
005EFA  ; data: 0xff, 0x06
005EFC  ori.b  #$3, d6
005F00  ; data: 0x00, 0x0a
005F02  ori.b  #$0, d0
005F06  sub.l  (a4)+, d1
005F08  ori.b  #$0, d0
005F0C  ori.b  #$20, d0
005F10  ori.b  #$30, d0
005F14  ori.b  #$e6, d0
005F18  ori.b  #$44, d0
005F1C  ori.b  #$0, d0
005F20  ori.b  #$0, d0
005F24  ori.b  #$0, d0
005F28  andi.b #$0, d0
005F2C  ori.b  #$0, d0
005F30  ori.b  #$0, d0
005F34  ori.b  #$0, d0
005F38  ; data: 0xff, 0xff
005F3A  ; data: 0xff, 0x06
005F3C  ori.b  #$4, d1
005F40  ; data: 0x00, 0x09
005F42  ori.b  #$0, d0
005F46  sub.l  (a4)+, d1
005F48  ori.b  #$0, d0
005F4C  ori.b  #$20, d0
005F50  ori.b  #$70, d0
005F54  ori.b  #$e6, d0
005F58  ori.b  #$84, d0
005F5C  ori.b  #$0, d0
005F60  ori.b  #$0, d0
005F64  ori.b  #$0, d0
005F68  ori.b  #$0, d0
005F6C  ori.b  #$0, d0
005F70  ori.b  #$0, d0
005F74  ori.b  #$0, d0
005F78  ; data: 0xff, 0xff
005F7A  ; data: 0xff, 0x06
005F7C  ori.b  #$0, d0
005F80  ori.b  #$0, d0
005F84  ori.b  #$fc, d0
005F88  ori.b  #$0, d0
005F8C  ori.b  #$20, d0
005F90  ori.b  #$b0, d0
005F94  ori.b  #$e6, d0
005F98  ori.b  #$c4, d0
005F9C  ori.b  #$0, d0
005FA0  ori.b  #$0, d0
005FA4  ori.b  #$0, d0
005FA8  andi.b #$0, d0
005FAC  ori.b  #$0, d0
005FB0  ori.b  #$0, d0
005FB4  ori.b  #$0, d0
005FB8  ; data: 0xff, 0xff
005FBA  ; data: 0xff, 0x06
005FBC  ori.b  #$0, d0
005FC0  ori.b  #$0, d0
005FC4  ori.b  #$d4, d0
005FC8  ori.b  #$0, d0
005FCC  ori.b  #$1, d0
005FD0  ori.b  #$9c, d0
005FD4  ori.b  #$5, d0
005FD8  ori.b  #$dc, d0
005FDC  ori.b  #$4, d0
005FE0  ori.b  #$c8, d0
005FE4  ori.b  #$0, d0
005FE8  ori.b  #$0, d0
005FEC  ori.b  #$b8, d0
005FF0  ori.b  #$0, d0
005FF4  ori.b  #$0, d0
005FF8  ori.b  #$4, d0
005FFC  ori.b  #$8, d0
006000  ori.b  #$0, d0
006004  ori.b  #$0, d0
006008  ; data: 0xff, 0xff
00600A  dc.w   $f448
00600C  ori.b  #$0, d0
006010  ori.b  #$0, d0
006014  ori.b  #$4, d0
006018  ori.b  #$48, d0
00601C  ori.b  #$b8, d0
006020  ori.b  #$0, d0
006024  ori.b  #$0, d0
006028  ori.b  #$0, d0
00602C  ori.b  #$0, d0
006030  ori.b  #$4, d0
006034  ori.b  #$88, d0
006038  ; data: 0xff, 0xff
00603A  dc.w   $f448
00603C  ori.b  #$0, d0
006040  ori.b  #$0, d0
006044  ori.b  #$0, d0
006048  ori.b  #$0, d0
00604C  ori.b  #$4, d0
006050  ori.b  #$c8, d0
006054  ori.b  #$0, d0
006058  ori.b  #$b8, d0
00605C  ori.b  #$0, d0
006060  ori.b  #$0, d0
006064  ori.b  #$0, d0
006068  ori.b  #$4, d0
00606C  ori.b  #$8, d0
006070  ori.b  #$0, d0
006074  ; data: 0xff, 0xff
006076  dc.w   $f448
006078  ori.b  #$0, d0
00607C  ori.b  #$0, d0
006080  ori.b  #$0, d0
006084  ori.b  #$4, d0
006088  ori.b  #$f8, d0
00608C  ; data: 0xff, 0xff
00608E  dc.w   $f448
006090  ori.b  #$0, d0
006094  ; data: 0xff, 0xff
006096  dc.w   $f448
006098  ori.b  #$0, d0
00609C  ori.b  #$0, d0
0060A0  ori.b  #$4, d0
0060A4  ori.b  #$38, d0
0060A8  ori.b  #$b8, d0
0060AC  ori.b  #$0, d0
0060B0  ; data: 0xff, 0xff
0060B2  dc.w   $f448
0060B4  ori.b  #$0, d0
0060B8  ori.b  #$0, d0
0060BC  ori.b  #$4, d0
0060C0  ori.b  #$78, d0
0060C4  ori.b  #$b8, d0
0060C8  ori.b  #$0, d0
0060CC  ori.b  #$b8, d0
0060D0  ori.b  #$0, d0
0060D4  ori.b  #$0, d0
0060D8  ori.b  #$4, d0
0060DC  ori.b  #$b8, d0
0060E0  ; data: 0xff, 0xff
0060E2  dc.w   $f448
0060E4  ori.b  #$0, d0
0060E8  ori.b  #$b8, d0
0060EC  ori.b  #$0, d0
0060F0  ori.b  #$0, d0
0060F4  ori.b  #$4, d0
0060F8  ori.b  #$f8, d0
0060FC  ori.b  #$0, d0
006100  ori.b  #$0, d0
006104  ori.b  #$0, d0
006108  andi.b #$0, d0
00610C  ori.b  #$0, d0
006110  ori.b  #$2, d0
006114  ori.b  #$48, d0
006118  ori.b  #$2, d0
00611C  ori.b  #$80, d0
006120  ori.b  #$4, d0
006124  ori.b  #$b8, d0
006128  ori.b  #$0, d0
00612C  ori.b  #$0, d0
006130  ori.b  #$d0, d0
006134  ori.b  #$0, d0
006138  ori.b  #$0, d0
00613C  ori.b  #$4, d0
006140  ori.b  #$b8, d0
006144  ori.b  #$0, d0
006148  ori.b  #$0, d0
00614C  ; data: 0xff, 0xff
00614E  dc.w   $f830
006150  ori.b  #$0, d0
006154  ori.b  #$0, d0
006158  ori.b  #$4, d0
00615C  ori.b  #$b8, d0
006160  ori.b  #$d0, d0
006164  ori.b  #$0, d0
006168  ori.b  #$0, d0
00616C  ori.b  #$0, d0
006170  ori.b  #$0, d0
006174  ori.b  #$4, d0
006178  ori.b  #$b8, d0
00617C  ; data: 0xff, 0xff
00617E  dc.w   $f830
006180  ori.b  #$0, d0
006184  ori.b  #$0, d0
006188  subi.b #$0, d0
00618C  ori.b  #$0, d0
006190  ori.b  #$3, d0
006194  ori.b  #$3, d0
006198  ori.b  #$0, d0
00619C  ori.b  #$36, d0
0061A0  ori.b  #$0, d0
0061A4  ori.b  #$e6, d0
0061A8  ori.b  #$c0, d0
0061AC  ori.b  #$d0, d0
0061B0  ori.b  #$0, d0
0061B4  ori.b  #$70, d0
0061B8  ori.b  #$0, d0
0061BC  ori.b  #$0, d0
0061C0  ori.b  #$9c, d0
0061C4  ori.b  #$0, d0
0061C8  ori.b  #$20, d0
0061CC  ori.b  #$ec, d0
0061D0  ori.b  #$e6, d0
0061D4  ori.b  #$0, d0
0061D8  ori.b  #$0, d0
0061DC  ori.b  #$0, d0
0061E0  ori.b  #$0, d0
0061E4  andi.b #$0, d0
0061E8  ori.b  #$0, d0
0061EC  ori.b  #$0, d0
0061F0  ori.b  #$0, d0
0061F4  ori.b  #$0, d0
0061F8  ori.b  #$4, d1
0061FC  ori.b  #$0, d5
006200  ori.b  #$9c, d0
006204  ori.b  #$0, d0
006208  ori.b  #$20, d0
00620C  ori.b  #$2c, d0
006210  ori.b  #$e6, d0
006214  ori.b  #$40, d0
006218  ori.b  #$0, d0
00621C  ori.b  #$0, d0
006220  ori.b  #$0, d0
006224  andi.b #$0, d0
006228  ori.b  #$0, d0
00622C  ori.b  #$0, d0
006230  ori.b  #$0, d0
006234  ori.b  #$0, d0
006238  ori.b  #$3, d2
00623C  ori.b  #$0, d5
006240  ori.b  #$9c, d0
006244  ori.b  #$0, d0
006248  ori.b  #$20, d0
00624C  ori.b  #$6c, d0
006250  ori.b  #$e6, d0
006254  ori.b  #$80, d0
006258  ori.b  #$0, d0
00625C  ori.b  #$0, d0
006260  ori.b  #$0, d0
006264  andi.b #$0, d0
006268  ori.b  #$0, d0
00626C  ori.b  #$0, d0
006270  ori.b  #$0, d0
006274  ori.b  #$0, d0
006278  ori.b  #$3, d1
00627C  ori.b  #$0, d4
006280  ori.b  #$9c, d0
006284  ori.b  #$0, d0
006288  ori.b  #$20, d0
00628C  ori.b  #$ac, d0
006290  ori.b  #$e6, d0
006294  ori.b  #$c0, d0
006298  ori.b  #$0, d0
00629C  ori.b  #$0, d0
0062A0  ori.b  #$0, d0
0062A4  andi.b #$0, d0
0062A8  ori.b  #$0, d0
0062AC  ori.b  #$0, d0
0062B0  ori.b  #$0, d0
0062B4  ori.b  #$0, d0
0062B8  ori.b  #$4, d2
0062BC  ori.b  #$0, d4
0062C0  ori.b  #$9c, d0
0062C4  ori.b  #$0, d0
0062C8  ori.b  #$20, d0
0062CC  ori.b  #$ec, d0
0062D0  ori.b  #$e6, d0
0062D4  ori.b  #$0, d0
0062D8  ori.b  #$0, d0
0062DC  ori.b  #$0, d0
0062E0  ori.b  #$0, d0
0062E4  andi.b #$0, d0
0062E8  ori.b  #$0, d0
0062EC  ori.b  #$0, d0
0062F0  ori.b  #$0, d0
0062F4  ori.b  #$0, d0
0062F8  ori.b  #$2, d4
0062FC  ori.b  #$0, d5
006300  ori.b  #$9c, d0
006304  ori.b  #$0, d0
006308  ori.b  #$20, d0
00630C  ori.b  #$2c, d0
006310  ori.b  #$e6, d0
006314  ori.b  #$40, d0
006318  ori.b  #$0, d0
00631C  ori.b  #$0, d0
006320  ori.b  #$0, d0
006324  andi.b #$0, d0
006328  ori.b  #$0, d0
00632C  ori.b  #$0, d0
006330  ori.b  #$0, d0
006334  ori.b  #$0, d0
006338  ori.b  #$1, d5
00633C  ori.b  #$0, d4
006340  ori.b  #$9c, d0
006344  ori.b  #$0, d0
006348  ori.b  #$20, d0
00634C  ori.b  #$6c, d0
006350  ori.b  #$1e, d0
006354  ori.b  #$0, d0
006358  ori.b  #$0, d0
00635C  ori.b  #$0, d0
006360  ori.b  #$f4, d0
006364  ori.b  #$0, d0
006368  ori.b  #$0, d0
00636C  ori.b  #$0, d0
006370  ori.b  #$0, d0
006374  ori.b  #$0, d0
006378  ori.b  #$2, d1
00637C  ori.b  #$0, d3
006380  ori.b  #$20, d0
006384  ori.b  #$a4, d0
006388  ori.b  #$1e, d0
00638C  ori.b  #$0, d0
006390  ori.b  #$0, d0
006394  ori.b  #$0, d0
006398  ori.b  #$0, d0
00639C  ori.b  #$0, d0
0063A0  ori.b  #$0, d0
0063A4  ori.b  #$0, d0
0063A8  ori.b  #$0, d0
0063AC  ori.b  #$0, d0
0063B0  ori.b  #$f6, d0
0063B4  ori.b  #$0, d0
0063B8  ori.b  #$20, d0
0063BC  ori.b  #$dc, d0
0063C0  ori.b  #$e6, d0
0063C4  ori.b  #$f0, d0
0063C8  ori.b  #$0, d0
0063CC  ori.b  #$0, d0
0063D0  ori.b  #$0, d0
0063D4  ori.b  #$0, d0
0063D8  ori.b  #$0, d0
0063DC  ori.b  #$0, d0
0063E0  ori.b  #$0, d0
0063E4  ori.b  #$0, d0
0063E8  ori.b  #$0, d0
0063EC  ori.b  #$0, d0
0063F0  ori.b  #$fc, d0
0063F4  ori.b  #$0, d0
0063F8  ori.b  #$20, d0
0063FC  ori.b  #$1c, d0
006400  ori.b  #$e6, d0
006404  ori.b  #$30, d0
006408  ori.b  #$0, d0
00640C  ori.b  #$0, d0
006410  ori.b  #$0, d0
006414  andi.b #$0, d0
006418  ori.b  #$0, d0
00641C  ori.b  #$0, d0
006420  ori.b  #$0, d0
006424  ori.b  #$0, d0
006428  ori.b  #$2, d3
00642C  ori.b  #$0, d1
006430  ori.b  #$cc, d0
006434  ori.b  #$0, d0
006438  ori.b  #$20, d0
00643C  ori.b  #$5c, d0
006440  ori.b  #$e6, d0
006444  ori.b  #$70, d0
006448  ori.b  #$0, d0
00644C  ori.b  #$0, d0
006450  ori.b  #$0, d0
006454  andi.b #$0, d0
006458  ori.b  #$0, d0
00645C  ori.b  #$0, d0
006460  ori.b  #$0, d0
006464  ori.b  #$0, d0
006468  ori.b  #$1, d3
00646C  ori.b  #$0, d2
006470  ori.b  #$a0, d0
006474  ori.b  #$0, d0
006478  ori.b  #$20, d0
00647C  ori.b  #$9c, d0
006480  ori.b  #$e6, d0
006484  ori.b  #$b0, d0
006488  ori.b  #$0, d0
00648C  ori.b  #$0, d0
006490  ori.b  #$0, d0
006494  andi.b #$0, d0
006498  ori.b  #$0, d0
00649C  ori.b  #$0, d0
0064A0  ori.b  #$0, d0
0064A4  ori.b  #$0, d0
0064A8  ori.b  #$3, d2
0064AC  ori.b  #$0, d1
0064B0  ori.b  #$80, d0
0064B4  ori.b  #$0, d0
0064B8  ori.b  #$20, d0
0064BC  ori.b  #$dc, d0
0064C0  ori.b  #$e6, d0
0064C4  ori.b  #$f0, d0
0064C8  ori.b  #$0, d0
0064CC  ori.b  #$0, d0
0064D0  ori.b  #$0, d0
0064D4  andi.b #$0, d0
0064D8  ori.b  #$0, d0
0064DC  ori.b  #$0, d0
0064E0  ori.b  #$0, d0
0064E4  ori.b  #$0, d0
0064E8  ori.b  #$2, d1
0064EC  ori.b  #$0, d3
0064F0  ori.b  #$7c, d0
0064F4  ori.b  #$0, d0
0064F8  ori.b  #$20, d0
0064FC  ori.b  #$1c, d0
006500  ori.b  #$e6, d0
006504  ori.b  #$30, d0
006508  ori.b  #$0, d0
00650C  ori.b  #$0, d0
006510  ori.b  #$0, d0
006514  ori.b  #$0, d0
006518  andi.b #$0, d0
00651C  ori.b  #$0, d0
006520  ori.b  #$0, d0
006524  ori.b  #$0, d0
006528  ori.b  #$0, d0
00652C  ori.b  #$0, d0
006530  ori.b  #$20, d0
006534  ori.b  #$0, d0
006538  ori.b  #$1, d0
00653C  ori.b  #$10, d0
006540  ori.b  #$5, d0
006544  ori.b  #$84, d0
006548  ori.b  #$1, d0
00654C  ori.b  #$50, d0
006550  ori.b  #$5, d0
006554  ori.b  #$ba, d0
006558  ori.b  #$1, d0
00655C  ori.b  #$90, d0
006560  ori.b  #$5, d0
006564  ori.b  #$f0, d0
006568  ori.b  #$1, d0
00656C  ori.b  #$d0, d0
006570  ori.b  #$5, d0
006574  ori.b  #$26, d0
006578  ori.b  #$1, d0
00657C  ori.b  #$10, d0
006580  ori.b  #$5, d0
006584  ori.b  #$5c, d0
006588  ori.b  #$1, d0
00658C  ori.b  #$50, d0
006590  ori.b  #$5, d0
006594  ori.b  #$92, d0
006598  ori.b  #$1, d0
00659C  ori.b  #$90, d0
0065A0  ori.b  #$5, d0
0065A4  ori.b  #$c8, d0
0065A8  ori.b  #$1, d0
0065AC  ori.b  #$d0, d0
0065B0  ori.b  #$5, d0
0065B4  ori.b  #$fe, d0
0065B8  ori.b  #$1, d0
0065BC  ori.b  #$10, d0
0065C0  ori.b  #$5, d0
0065C4  ori.b  #$34, d0
0065C8  ori.b  #$1, d0
0065CC  ori.b  #$50, d0
0065D0  ori.b  #$5, d0
0065D4  ori.b  #$4e, d0
0065D8  ori.b  #$1, d0
0065DC  ori.b  #$ec, d0
0065E0  ori.b  #$5, d0
0065E4  ori.b  #$dc, d0
0065E8  ori.b  #$0, d0
0065EC  ori.b  #$68, d0
0065F0  ori.b  #$0, d0
0065F4  ori.b  #$ce, d0
0065F8  ori.b  #$0, d0
0065FC  ori.b  #$0, d0
006600  ori.b  #$0, d0
006604  ori.b  #$0, d0
006608  ori.b  #$0, d0
00660C  ori.b  #$0, d0
006610  ori.b  #$20, d0
006614  ori.b  #$34, d0
006618  ori.b  #$e6, d0
00661C  ori.b  #$48, d0
006620  ori.b  #$0, d0
006624  ori.b  #$0, d0
006628  ori.b  #$5e, d0
00662C  ori.b  #$0, d0
006630  ori.b  #$0, d0
006634  ori.b  #$0, d0
006638  ori.b  #$0, d0
00663C  ; data: 0xff, 0xff
00663E  ; data: 0xff, 0xfe
006640  ori.b  #$0, d0
006644  ori.b  #$0, d0
006648  ori.b  #$1c, d0
00664C  ori.b  #$0, d0
006650  ori.b  #$20, d0
006654  ori.b  #$74, d0
006658  ori.b  #$e6, d0
00665C  ori.b  #$88, d0
006660  ori.b  #$0, d0
006664  ori.b  #$40, d0
006668  ori.b  #$5e, d0
00666C  ori.b  #$0, d0
006670  ori.b  #$0, d0
006674  ori.b  #$0, d0
006678  ori.b  #$0, d0
00667C  ; data: 0xff, 0xff
00667E  ; data: 0xff, 0xfe
006680  ori.b  #$0, d0
006684  ori.b  #$0, d0
006688  ori.b  #$c8, d0
00668C  ori.b  #$0, d0
006690  ori.b  #$20, d0
006694  ori.b  #$b4, d0
006698  ori.b  #$e6, d0
00669C  ori.b  #$c8, d0
0066A0  ori.b  #$40, d0
0066A4  ori.b  #$f0, d0
0066A8  ori.b  #$fe, d0
0066AC  ori.b  #$0, d0
0066B0  ori.b  #$0, d0
0066B4  ori.b  #$0, d0
0066B8  ori.b  #$0, d0
0066BC  ; data: 0xff, 0xff
0066BE  ; data: 0xff, 0xfe
0066C0  ori.b  #$0, d0
0066C4  ori.b  #$0, d0
0066C8  ori.b  #$f0, d0
0066CC  ori.b  #$0, d0
0066D0  ori.b  #$20, d0
0066D4  ori.b  #$f4, d0
0066D8  ori.b  #$e6, d0
0066DC  ori.b  #$8, d0
0066E0  ori.b  #$40, d0
0066E4  ori.b  #$a0, d0
0066E8  ori.b  #$1e, d0
0066EC  ori.b  #$0, d0
0066F0  ori.b  #$0, d0
0066F4  ori.b  #$0, d0
0066F8  ori.b  #$0, d0
0066FC  ; data: 0xff, 0xff
0066FE  ; data: 0xff, 0xfe
006700  ori.b  #$0, d0
006704  ori.b  #$0, d0
006708  ori.b  #$50, d0
00670C  ori.b  #$0, d0
006710  ori.b  #$20, d0
006714  ori.b  #$34, d0
006718  ori.b  #$e6, d0
00671C  ori.b  #$48, d0
006720  ; data: 0xff, 0xff
006722  ; data: 0xe0, 0xc0
006724  ori.b  #$d0, d0
006728  ori.b  #$ee, d0
00672C  ori.b  #$0, d0
006730  ori.b  #$0, d0
006734  ori.b  #$0, d0
006738  ori.b  #$0, d0
00673C  ; data: 0xff, 0xff
00673E  ; data: 0xff, 0xfe
006740  ori.b  #$0, d0
006744  ori.b  #$0, d0
006748  ori.b  #$f0, d0
00674C  ori.b  #$0, d0
006750  ori.b  #$20, d0
006754  ori.b  #$74, d0
006758  ori.b  #$e6, d0
00675C  ori.b  #$88, d0
006760  ori.b  #$e0, d0
006764  ori.b  #$40, d0
006768  ori.b  #$3e, d0
00676C  ori.b  #$0, d0
006770  ori.b  #$0, d0
006774  ori.b  #$0, d0
006778  ori.b  #$0, d0
00677C  ; data: 0xff, 0xff
00677E  ; data: 0xff, 0xfe
006780  ori.b  #$0, d0
006784  ori.b  #$0, d0
006788  ori.b  #$f0, d0
00678C  ori.b  #$0, d0
006790  ori.b  #$20, d0
006794  ori.b  #$b4, d0
006798  ori.b  #$e6, d0
00679C  ori.b  #$c8, d0
0067A0  ; data: 0xff, 0xff
0067A2  dc.w   $fce0
0067A4  ; data: 0xff, 0xff
0067A6  dc.w   $f060
0067A8  ori.b  #$9e, d0
0067AC  ori.b  #$0, d0
0067B0  ori.b  #$0, d0
0067B4  ori.b  #$0, d0
0067B8  ori.b  #$0, d0
0067BC  ; data: 0xff, 0xff
0067BE  ; data: 0xff, 0xfe
0067C0  ori.b  #$0, d0
0067C4  ori.b  #$0, d0
0067C8  ori.b  #$f0, d0
0067CC  ori.b  #$0, d0
0067D0  ori.b  #$20, d0
0067D4  ori.b  #$f4, d0
0067D8  ori.b  #$e6, d0
0067DC  ori.b  #$8, d0
0067E0  ; data: 0xff, 0xff
0067E2  ; data: 0xe0, 0xc0
0067E4  ori.b  #$e0, d0
0067E8  ori.b  #$de, d0
0067EC  ori.b  #$0, d0
0067F0  ori.b  #$0, d0
0067F4  ori.b  #$0, d0
0067F8  ori.b  #$0, d0
0067FC  ; data: 0xff, 0xff
0067FE  ; data: 0xff, 0xfe
006800  ori.b  #$0, d0
006804  ori.b  #$0, d0
006808  ori.b  #$c8, d0
00680C  ori.b  #$0, d0
006810  ori.b  #$20, d0
006814  ori.b  #$34, d0
006818  ori.b  #$e6, d0
00681C  ori.b  #$48, d0
006820  ; data: 0xff, 0xff
006822  ; data: 0xfb, 0x00
006824  ; data: 0xff, 0xff
006826  dc.w   $fb50
006828  ori.b  #$de, d0
00682C  ori.b  #$0, d0
006830  ori.b  #$0, d0
006834  ori.b  #$0, d0
006838  ori.b  #$0, d0
00683C  ; data: 0xff, 0xff
00683E  ; data: 0xff, 0xfe
006840  ori.b  #$0, d0
006844  ori.b  #$0, d0
006848  ori.b  #$1c, d0
00684C  ori.b  #$0, d0
006850  ori.b  #$20, d0
006854  ori.b  #$74, d0
006858  ori.b  #$e6, d0
00685C  ori.b  #$88, d0
006860  ; data: 0xff, 0xff
006862  dc.w   $f060
006864  ; data: 0xff, 0xff
006866  dc.w   $f6a0
006868  ori.b  #$fe, d0
00686C  ori.b  #$0, d0
006870  ori.b  #$0, d0
006874  ori.b  #$0, d0
006878  ori.b  #$0, d0
00687C  ; data: 0xff, 0xff
00687E  ; data: 0xff, 0xfe
006880  ori.b  #$0, d0
006884  ori.b  #$0, d0
006888  ori.b  #$f0, d0
00688C  ori.b  #$0, d0
006890  ori.b  #$1, d0
006894  ori.b  #$60, d0
006898  ori.b  #$5, d0
00689C  ori.b  #$20, d0
0068A0  ori.b  #$1, d0
0068A4  ori.b  #$96, d0
0068A8  ori.b  #$1, d0
0068AC  ori.b  #$cc, d0
0068B0  ori.b  #$1, d0
0068B4  ori.b  #$2, d0
0068B8  ori.b  #$1, d0
0068BC  ori.b  #$38, d0
0068C0  ori.b  #$1, d0
0068C4  ori.b  #$6e, d0
0068C8  ori.b  #$1, d0
0068CC  ori.b  #$a4, d0
0068D0  ori.b  #$1, d0
0068D4  ori.b  #$da, d0
0068D8  ori.b  #$1, d0
0068DC  ori.b  #$10, d0
0068E0  ori.b  #$1, d0
0068E4  ori.b  #$2a, d0
0068E8  ori.b  #$1, d0
0068EC  ori.b  #$fc, d0
0068F0  ori.b  #$5, d0
0068F4  ori.b  #$e0, d0
0068F8  ori.b  #$0, d0
0068FC  ori.b  #$12, d0
006900  ori.b  #$20, d0
006904  ori.b  #$ce, d0
006908  ori.b  #$20, d0
00690C  ori.b  #$90, d0
006910  ori.b  #$2c, d0
006914  ori.b  #$e8, d0
006918  ori.b  #$0, d0
00691C  ori.b  #$0, d0
006920  ori.b  #$0, d0
006924  ; data: 0xff, 0x1a
006926  ; data: 0x00, 0xc8
006928  move.w (a0, d0.w), (a3)
00692C  addq.b #$5, d4
00692E  ori.b  #$4e, d0
006932  ori.b  #$e6, d0
006936  ori.b  #$58, d0
00693A  ori.b  #$90, d0
00693E  ori.b  #$90, d0
006942  ori.b  #$40, d0
006946  ori.b  #$0, d0
00694A  ori.b  #$0, d0
00694E  ori.b  #$0, d0
006952  ori.w  #$32, d6
006956  bset.b d0, (a4, d0.w)
00695A  or.l   d5, $0(a4)
00695E  ori.b  #$0, d0
006962  addq.b #$5, d4
006964  ori.b  #$84, d0
006968  ori.b  #$e6, d0
00696C  ori.b  #$8e, d0
006970  ori.b  #$c8, d0
006974  ori.b  #$e8, d0
006978  ori.b  #$4c, d0
00697C  ori.b  #$0, d0
006980  ori.b  #$0, d0
006984  ori.b  #$0, d0
006988  ori.w  #$32, d6
00698C  bset.b d0, (a4, d0.w)
006990  or.l   d5, $0(a4)
006994  ori.b  #$0, d0
006998  addq.b #$5, d4
00699A  ori.b  #$ba, d0
00699E  ori.b  #$e6, d0
0069A2  ori.b  #$c4, d0
0069A6  ori.b  #$e8, d0
0069AA  ori.b  #$f4, d0
0069AE  ori.b  #$78, d0
0069B2  ori.b  #$0, d0
0069B6  ori.b  #$0, d0
0069BA  ori.b  #$0, d0
0069BE  ori.w  #$32, d6
0069C2  bset.b d0, (a4, d0.w)
0069C6  or.l   d5, $0(a4)
0069CA  ori.b  #$0, d0
0069CE  addq.b #$5, d4
0069D0  ori.b  #$f0, d0
0069D4  ori.b  #$e6, d0
0069D8  ori.b  #$fa, d0
0069DC  ori.b  #$0, d0
0069E0  ori.b  #$c8, d0
0069E4  ori.b  #$b0, d0
0069E8  ori.b  #$0, d0
0069EC  ori.b  #$0, d0
0069F0  ori.b  #$0, d0
0069F4  ori.w  #$32, d6
0069F8  bset.b d0, (a4, d0.w)
0069FC  or.l   d5, $0(a4)
006A00  ori.b  #$0, d0
006A04  addq.b #$5, d4
006A06  ori.b  #$26, d0
006A0A  ori.b  #$e6, d0
006A0E  ori.b  #$30, d0
006A12  ori.b  #$90, d0
006A16  ori.b  #$58, d0
006A1A  ori.b  #$8, d0
006A1E  ori.b  #$0, d0
006A22  ori.b  #$0, d0
006A26  ori.b  #$0, d0
006A2A  ori.w  #$32, d6
006A2E  bset.b d0, (a4, d0.w)
006A32  or.l   d5, $0(a4)
006A36  ori.b  #$0, d0
006A3A  addq.b #$5, d4
006A3C  ori.b  #$5c, d0
006A40  ori.b  #$e6, d0
006A44  ori.b  #$66, d0
006A48  ori.b  #$58, d0
006A4C  ori.b  #$c8, d0
006A50  ori.b  #$dc, d0
006A54  ori.b  #$0, d0
006A58  ori.b  #$0, d0
006A5C  ori.b  #$0, d0
006A60  ori.w  #$32, d6
006A64  bset.b d0, (a4, d0.w)
006A68  or.l   d5, $0(a4)
006A6C  ori.b  #$0, d0
006A70  addq.b #$5, d4
006A72  ori.b  #$92, d0
006A76  ori.b  #$e6, d0
006A7A  ori.b  #$9c, d0
006A7E  ori.b  #$c8, d0
006A82  ori.b  #$20, d0
006A86  ori.b  #$84, d0
006A8A  ori.b  #$0, d0
006A8E  ori.b  #$0, d0
006A92  ori.b  #$0, d0
006A96  ori.w  #$32, d6
006A9A  bset.b d0, (a4, d0.w)
006A9E  or.l   d5, $0(a4)
006AA2  ori.b  #$0, d0
006AA6  addq.b #$5, d4
006AA8  ori.b  #$c8, d0
006AAC  ori.b  #$e6, d0
006AB0  ori.b  #$d2, d0
006AB4  ori.b  #$90, d0
006AB8  ori.b  #$90, d0
006ABC  ori.b  #$b0, d0
006AC0  ori.b  #$0, d0
006AC4  ori.b  #$0, d0
006AC8  ori.b  #$0, d0
006ACC  ori.w  #$32, d6
006AD0  bset.b d0, (a4, d0.w)
006AD4  or.l   d5, $0(a4)
006AD8  ori.b  #$0, d0
006ADC  addq.b #$5, d4
006ADE  ori.b  #$fe, d0
006AE2  ori.b  #$e6, d0
006AE6  ori.b  #$8, d0
006AEA  ori.b  #$2c, d0
006AEE  ori.b  #$bc, d0
006AF2  ori.b  #$14, d0
006AF6  ori.b  #$0, d0
006AFA  ori.b  #$0, d0
006AFE  ori.b  #$0, d0
006B02  ori.w  #$32, d6
006B06  bset.b d0, (a4, d0.w)
006B0A  or.l   d5, $0(a4)
006B0E  ori.b  #$0, d0
006B12  addq.b #$5, d4
006B14  ori.b  #$34, d0
006B18  ori.b  #$e6, d0
006B1C  ori.b  #$3e, d0
006B20  ori.b  #$20, d0
006B24  ori.b  #$2c, d0
006B28  ori.b  #$e8, d0
006B2C  ori.b  #$0, d0
006B30  ori.b  #$0, d0
006B34  ori.b  #$0, d0
006B38  ori.w  #$32, d6
006B3C  bset.b d0, (a4, d0.w)
006B40  or.l   d5, $0(a4)
006B44  ori.b  #$0, d0
006B48  ori.b  #$0, d1
006B4C  bmi.b  $6b20
006B4E  ori.b  #$5, d0
006B52  ori.b  #$dc, d0
006B56  ori.b  #$1, d0
006B5A  ori.b  #$f6, d0
006B5E  ori.b  #$1, d0
006B62  ori.b  #$36, d0
006B66  ori.b  #$1, d0
006B6A  ori.b  #$76, d0
006B6E  ori.b  #$1, d0
006B72  ori.b  #$b6, d0
006B76  ori.b  #$1, d0
006B7A  ori.b  #$f6, d0
006B7E  ori.b  #$1, d0
006B82  ori.b  #$36, d0
006B86  ori.b  #$1, d0
006B8A  ori.b  #$76, d0
006B8E  ori.b  #$1, d0
006B92  ori.b  #$b6, d0
006B96  ori.b  #$1, d0
006B9A  ori.b  #$f6, d0
006B9E  ori.b  #$1, d0
006BA2  ori.b  #$36, d0
006BA6  ori.b  #$1, d0
006BAA  ori.b  #$76, d0
006BAE  ori.b  #$1, d0
006BB2  ori.b  #$b6, d0
006BB6  ori.b  #$1, d0
006BBA  ori.b  #$f6, d0
006BBE  ori.b  #$1, d0
006BC2  ori.b  #$36, d0
006BC6  ori.b  #$1, d0
006BCA  ori.b  #$76, d0
006BCE  ori.b  #$0, d0
006BD2  ori.b  #$36, d0
006BD6  ori.b  #$0, d0
006BDA  ori.b  #$ce, d0
006BDE  ori.b  #$0, d0
006BE2  ori.b  #$d0, d0
006BE6  ori.b  #$0, d0
006BEA  ori.b  #$70, d0
006BEE  ori.b  #$0, d0
006BF2  ori.b  #$0, d0
006BF6  ori.b  #$20, d0
006BFA  ori.b  #$1a, d0
006BFE  ori.b  #$e6, d0
006C02  ori.b  #$2e, d0
006C06  ori.b  #$0, d0
006C0A  ori.b  #$0, d0
006C0E  ori.b  #$0, d0
006C12  andi.b #$0, d0
006C16  ori.b  #$0, d0
006C1A  ; data: 0xff, 0xff
006C1C  ; data: 0xff, 0xd8
006C1E  ori.b  #$0, d0
006C22  ori.b  #$0, d0
006C26  ori.b  #$0, d0
006C2A  ori.b  #$0, d0
006C2E  ori.b  #$5c, d0
006C32  ori.b  #$0, d0
006C36  ori.b  #$20, d0
006C3A  ori.b  #$5a, d0
006C3E  ori.b  #$e6, d0
006C42  ori.b  #$6e, d0
006C46  ori.b  #$f0, d0
006C4A  ori.b  #$0, d0
006C4E  ori.b  #$0, d0
006C52  andi.w #$0, d0
006C56  ori.b  #$0, d0
006C5A  ; data: 0xff, 0xff
006C5C  ; data: 0xff, 0xd8
006C5E  ori.b  #$0, d0
006C62  ori.b  #$0, d0
006C66  ori.b  #$0, d0
006C6A  ori.b  #$0, d0
006C6E  ori.b  #$cc, d0
006C72  ori.b  #$0, d0
006C76  ori.b  #$20, d0
006C7A  ori.b  #$9a, d0
006C7E  ori.b  #$e6, d0
006C82  ori.b  #$ae, d0
006C86  ori.b  #$e0, d0
006C8A  ori.b  #$0, d0
006C8E  ori.b  #$0, d0
006C92  andi.l #$0, d0
006C98  ori.b  #$ff, d0
006C9C  ; data: 0xff, 0xd8
006C9E  ori.b  #$0, d0
006CA2  ori.b  #$0, d0
006CA6  ori.b  #$0, d0
006CAA  ori.b  #$0, d0
006CAE  ori.b  #$d4, d0
006CB2  ori.b  #$0, d0
006CB6  ori.b  #$20, d0
006CBA  ori.b  #$da, d0
006CBE  ori.b  #$e6, d0
006CC2  ori.b  #$ee, d0
006CC6  ori.b  #$d0, d0
006CCA  ori.b  #$0, d0
006CCE  ori.b  #$0, d0
006CD2  ; data: 0x02, 0xc0
006CD4  ori.b  #$0, d0
006CD8  ori.b  #$ff, d0
006CDC  ; data: 0xff, 0xd8
006CDE  ori.b  #$0, d0
006CE2  ori.b  #$0, d0
006CE6  ori.b  #$0, d0
006CEA  ori.b  #$0, d0
006CEE  ori.b  #$d8, d0
006CF2  ori.b  #$0, d0
006CF6  ori.b  #$20, d0
006CFA  ori.b  #$1a, d0
006CFE  ori.b  #$e6, d0
006D02  ori.b  #$2e, d0
006D06  ori.b  #$c0, d0
006D0A  ori.b  #$0, d0
006D0E  ori.b  #$0, d0
006D12  btst.l d1, d0
006D14  ori.b  #$0, d0
006D18  ori.b  #$ff, d0
006D1C  ; data: 0xff, 0xd8
006D1E  ori.b  #$0, d0
006D22  ori.b  #$0, d0
006D26  ori.b  #$0, d0
006D2A  ori.b  #$0, d0
006D2E  ori.b  #$80, d0
006D32  ori.b  #$0, d0
006D36  ori.b  #$20, d0
006D3A  ori.b  #$5a, d0
006D3E  ori.b  #$e6, d0
006D42  ori.b  #$6e, d0
006D46  ori.b  #$b0, d0
006D4A  ori.b  #$0, d0
006D4E  ori.b  #$0, d0
006D52  bchg.b d1, d0
006D54  ori.b  #$0, d0
006D58  ori.b  #$ff, d0
006D5C  ; data: 0xff, 0xd8
006D5E  ori.b  #$0, d0
006D62  ori.b  #$0, d0
006D66  ori.b  #$0, d0
006D6A  ori.b  #$0, d0
006D6E  ori.b  #$6c, d0
006D72  ori.b  #$0, d0
006D76  ori.b  #$20, d0
006D7A  ori.b  #$9a, d0
006D7E  ori.b  #$e6, d0
006D82  ori.b  #$ae, d0
006D86  ori.b  #$90, d0
006D8A  ori.b  #$0, d0
006D8E  ori.b  #$0, d0
006D92  bset.b d1, d0
006D94  ori.b  #$0, d0
006D98  ori.b  #$ff, d0
006D9C  ; data: 0xff, 0xd8
006D9E  ori.b  #$0, d0
006DA2  ori.b  #$0, d0
006DA6  ori.b  #$0, d0
006DAA  ori.b  #$0, d0
006DAE  ori.b  #$0, d0
006DB2  ori.b  #$0, d0
006DB6  ori.b  #$20, d0
006DBA  ori.b  #$da, d0
006DBE  ori.b  #$e6, d0
006DC2  ori.b  #$ee, d0
006DC6  ori.b  #$80, d0
006DCA  ori.b  #$0, d0
006DCE  ori.b  #$0, d0
006DD2  subi.b #$0, d0
006DD6  ori.b  #$0, d0
006DDA  ; data: 0xff, 0xff
006DDC  ; data: 0xff, 0xd8
006DDE  ori.b  #$0, d0
006DE2  ori.b  #$0, d0
006DE6  ori.b  #$0, d0
006DEA  ori.b  #$0, d0
006DEE  ori.b  #$7c, d0
006DF2  ori.b  #$0, d0
006DF6  ori.b  #$20, d0
006DFA  ori.b  #$1a, d0
006DFE  ori.b  #$e6, d0
006E02  ori.b  #$2e, d0
006E06  ori.b  #$70, d0
006E0A  ori.b  #$0, d0
006E0E  ori.b  #$0, d0
006E12  subi.w #$0, d0
006E16  ori.b  #$0, d0
006E1A  ; data: 0xff, 0xff
006E1C  ; data: 0xff, 0xd8
006E1E  ori.b  #$0, d0
006E22  ori.b  #$0, d0
006E26  ori.b  #$0, d0
006E2A  ori.b  #$0, d0
006E2E  ori.b  #$f8, d0
006E32  ori.b  #$0, d0
006E36  ori.b  #$20, d0
006E3A  ori.b  #$5a, d0
006E3E  ori.b  #$e6, d0
006E42  ori.b  #$6e, d0
006E46  ori.b  #$60, d0
006E4A  ori.b  #$0, d0
006E4E  ori.b  #$0, d0
006E52  subi.l #$0, d0
006E58  ori.b  #$ff, d0
006E5C  ; data: 0xff, 0xd8
006E5E  ori.b  #$0, d0
006E62  ori.b  #$0, d0
006E66  ori.b  #$0, d0
006E6A  ori.b  #$0, d0
006E6E  ori.b  #$a4, d0
006E72  ori.b  #$0, d0
006E76  ori.b  #$20, d0
006E7A  ori.b  #$9a, d0
006E7E  ori.b  #$e6, d0
006E82  ori.b  #$ae, d0
006E86  ori.b  #$40, d0
006E8A  ori.b  #$0, d0
006E8E  ori.b  #$0, d0
006E92  btst.l d2, d0
006E94  ori.b  #$0, d0
006E98  ori.b  #$ff, d0
006E9C  ; data: 0xff, 0xd8
006E9E  ori.b  #$0, d0
006EA2  ori.b  #$0, d0
006EA6  ori.b  #$0, d0
006EAA  ori.b  #$0, d0
006EAE  ori.b  #$a4, d0
006EB2  ori.b  #$0, d0
006EB6  ori.b  #$20, d0
006EBA  ori.b  #$da, d0
006EBE  ori.b  #$e6, d0
006EC2  ori.b  #$ee, d0
006EC6  ori.b  #$30, d0
006ECA  ori.b  #$0, d0
006ECE  ori.b  #$0, d0
006ED2  bchg.b d2, d0
006ED4  ori.b  #$0, d0
006ED8  ori.b  #$ff, d0
006EDC  ; data: 0xff, 0xd8
006EDE  ori.b  #$0, d0
006EE2  ori.b  #$0, d0
006EE6  ori.b  #$0, d0
006EEA  ori.b  #$0, d0
006EEE  ori.b  #$a0, d0
006EF2  ori.b  #$0, d0
006EF6  ori.b  #$20, d0
006EFA  ori.b  #$1a, d0
006EFE  ori.b  #$e6, d0
006F02  ori.b  #$2e, d0
006F06  ori.b  #$10, d0
006F0A  ori.b  #$0, d0
006F0E  ori.b  #$0, d0
006F12  bset.b d2, d0
006F14  ori.b  #$0, d0
006F18  ori.b  #$ff, d0
006F1C  ; data: 0xff, 0xd8
006F1E  ori.b  #$0, d0
006F22  ori.b  #$0, d0
006F26  ori.b  #$0, d0
006F2A  ori.b  #$0, d0
006F2E  ori.b  #$0, d0
006F32  ori.b  #$0, d0
006F36  ori.b  #$20, d0
006F3A  ori.b  #$5a, d0
006F3E  ori.b  #$e6, d0
006F42  ori.b  #$6e, d0
006F46  ori.b  #$0, d0
006F4A  ori.b  #$0, d0
006F4E  ori.b  #$0, d0
006F52  addi.b #$0, d0
006F56  ori.b  #$0, d0
006F5A  ; data: 0xff, 0xff
006F5C  ; data: 0xff, 0xd8
006F5E  ori.b  #$0, d0
006F62  ori.b  #$0, d0
006F66  ori.b  #$0, d0
006F6A  ori.b  #$0, d0
006F6E  ori.b  #$d8, d0
006F72  ori.b  #$0, d0
006F76  ori.b  #$20, d0
006F7A  ori.b  #$9a, d0
006F7E  ori.b  #$e6, d0
006F82  ori.b  #$ae, d0
006F86  ori.b  #$f0, d0
006F8A  ori.b  #$0, d0
006F8E  ori.b  #$0, d0
006F92  addi.w #$0, d0
006F96  ori.b  #$0, d0
006F9A  ; data: 0xff, 0xff
006F9C  ; data: 0xff, 0xd8
006F9E  ori.b  #$0, d0
006FA2  ori.b  #$0, d0
006FA6  ori.b  #$0, d0
006FAA  ori.b  #$0, d0
006FAE  ori.b  #$7c, d0
006FB2  ori.b  #$0, d0
006FB6  ori.b  #$4, d0
006FBA  ori.b  #$d6, d0
006FBE  ori.b  #$0, d0
006FC2  ori.b  #$0, d0
006FC6  ori.b  #$0, d0
006FCA  ori.b  #$0, d0
006FCE  ori.b  #$0, d0
006FD2  ori.b  #$1, d0
006FD6  ori.b  #$16, d0
006FDA  ori.b  #$5, d0
006FDE  ori.b  #$dc, d0
006FE2  ori.b  #$2, d0
006FE6  ori.b  #$fe, d0
006FEA  ori.b  #$2, d0
006FEE  ori.b  #$6e, d0
006FF2  ori.b  #$4, d0
006FF6  ori.b  #$a6, d0
006FFA  ori.b  #$0, d0
006FFE  ori.b  #$0, d0
007002  ori.b  #$84, d0
007006  ori.b  #$0, d0
00700A  ori.b  #$0, d0
00700E  ori.b  #$4, d0
007012  ori.b  #$a6, d0
007016  ori.b  #$0, d0
00701A  ori.b  #$0, d0
00701E  ; data: 0xff, 0xff
007020  dc.w   $fc7c
007022  ori.b  #$0, d0
007026  ori.b  #$0, d0
00702A  ori.b  #$4, d0
00702E  ori.b  #$a6, d0
007032  ori.b  #$84, d0
007036  ori.b  #$0, d0
00703A  ori.b  #$0, d0
00703E  ori.b  #$0, d0
007042  ori.b  #$0, d0
007046  ori.b  #$4, d0
00704A  ori.b  #$a6, d0
00704E  ; data: 0xff, 0xff
007050  dc.w   $fc7c
007052  ori.b  #$0, d0
007056  ori.b  #$0, d0
00705A  ori.b  #$0, d0
00705E  ori.b  #$0, d0
007062  ori.b  #$3, d0
007066  ori.b  #$4, d0
00706A  ori.b  #$42, d0
00706E  ori.b  #$0, d0
007072  ori.b  #$0, d0
007076  ori.b  #$0, d0
00707A  ori.b  #$0, d0
00707E  ori.b  #$0, d0
007082  ori.b  #$3, d0
007086  ori.b  #$2, d0
00708A  ori.b  #$22, d0
00708E  ori.b  #$2, d0
007092  ori.b  #$6e, d0
007096  ori.b  #$4, d0
00709A  ori.b  #$a6, d0
00709E  ori.b  #$0, d0
0070A2  ori.b  #$0, d0
0070A6  ori.b  #$84, d0
0070AA  ori.b  #$0, d0
0070AE  ori.b  #$0, d0
0070B2  ori.b  #$4, d0
0070B6  ori.b  #$a6, d0
0070BA  ori.b  #$0, d0
0070BE  ori.b  #$0, d0
0070C2  ; data: 0xff, 0xff
0070C4  dc.w   $fc7c
0070C6  ori.b  #$0, d0
0070CA  ori.b  #$0, d0
0070CE  ori.b  #$4, d0
0070D2  ori.b  #$a6, d0
0070D6  ori.b  #$84, d0
0070DA  ori.b  #$0, d0
0070DE  ori.b  #$0, d0
0070E2  ori.b  #$0, d0
0070E6  ori.b  #$0, d0
0070EA  ori.b  #$4, d0
0070EE  ori.b  #$a6, d0
0070F2  ; data: 0xff, 0xff
0070F4  dc.w   $fc7c
0070F6  ori.b  #$0, d0
0070FA  ori.b  #$0, d0
0070FE  ori.b  #$0, d0
007102  ori.b  #$0, d0
007106  ori.b  #$3, d0
00710A  ori.b  #$1, d0
00710E  ori.b  #$42, d0
007112  ori.b  #$3, d0
007116  ori.b  #$2, d0
00711A  ori.b  #$6a, d0
00711E  ori.b  #$2, d0
007122  ori.b  #$6e, d0
007126  ori.b  #$4, d0
00712A  ori.b  #$a6, d0
00712E  ori.b  #$0, d0
007132  ori.b  #$0, d0
007136  ori.b  #$84, d0
00713A  ori.b  #$0, d0
00713E  ori.b  #$0, d0
007142  ori.b  #$4, d0
007146  ori.b  #$a6, d0
00714A  ori.b  #$0, d0
00714E  ori.b  #$0, d0
007152  ; data: 0xff, 0xff
007154  dc.w   $fc7c
007156  ori.b  #$0, d0
00715A  ori.b  #$0, d0
00715E  ori.b  #$4, d0
007162  ori.b  #$a6, d0
007166  ori.b  #$84, d0
00716A  ori.b  #$0, d0
00716E  ori.b  #$0, d0
007172  ori.b  #$0, d0
007176  ori.b  #$0, d0
00717A  ori.b  #$4, d0
00717E  ori.b  #$a6, d0
007182  ; data: 0xff, 0xff
007184  dc.w   $fc7c
007186  ori.b  #$0, d0
00718A  ori.b  #$0, d0
00718E  ori.b  #$0, d0
007192  ori.b  #$0, d0
007196  ori.b  #$3, d0
00719A  ori.b  #$1, d0
00719E  ori.b  #$42, d0
0071A2  ori.b  #$3, d0
0071A6  ori.b  #$4, d0
0071AA  ori.b  #$42, d0
0071AE  ori.b  #$0, d0
0071B2  ; data: 0xff, 0xff
0071B4  lsr.w  d7, d4
0071B6  ori.b  #$0, d0
0071BA  ori.b  #$0, d0
0071BE  ori.b  #$0, d0
0071C2  ori.b  #$4, d0
0071C6  ori.b  #$42, d0
0071CA  ori.b  #$0, d0
0071CE  ori.b  #$0, d0
0071D2  ; data: 0xff, 0xff
0071D4  lsr.w  d7, d4
0071D6  ori.b  #$0, d0
0071DA  ori.b  #$0, d0
0071DE  ori.b  #$4, d0
0071E2  ori.b  #$42, d0
0071E6  ori.b  #$0, d0
0071EA  ori.b  #$0, d0
0071EE  ori.b  #$94, d0
0071F2  ori.b  #$0, d0
0071F6  ori.b  #$0, d0
0071FA  ori.b  #$0, d0
0071FE  ori.b  #$9a, d0
007202  ori.b  #$0, d0
007206  ori.b  #$1e, d0
00720A  ori.b  #$0, d0
00720E  ; data: 0xff, 0xff
007210  lsr.w  d7, d4
007212  ori.b  #$0, d0
007216  ori.b  #$0, d0
00721A  ori.b  #$4, d3
00721E  ori.b  #$0, d5
007222  ori.b  #$9a, d0
007226  ori.b  #$0, d0
00722A  ori.b  #$1e, d0
00722E  ori.b  #$0, d0
007232  ori.b  #$94, d0
007236  ori.b  #$0, d0
00723A  ori.b  #$0, d0
00723E  ori.b  #$4, d4
007242  ori.b  #$0, d5
007246  ori.b  #$9a, d0
00724A  ori.b  #$0, d0
00724E  ori.b  #$1e, d0
007252  ori.b  #$0, d0
007256  ori.b  #$0, d0
00725A  ; data: 0xff, 0xff
00725C  lsr.w  d7, d4
00725E  ori.b  #$0, d0
007262  ori.b  #$4, d5
007266  ori.b  #$0, d5
00726A  ori.b  #$9a, d0
00726E  ori.b  #$0, d0
007272  ori.b  #$1e, d0
007276  ori.b  #$0, d0
00727A  ori.b  #$0, d0
00727E  ori.b  #$94, d0
007282  ori.b  #$0, d0
007286  ori.b  #$4, d3
00728A  ori.b  #$0, d2
00728E  ori.b  #$9a, d0
007292  ori.b  #$0, d0
007296  ori.b  #$1e, d0
00729A  ori.b  #$0, d0
00729E  ori.b  #$0, d0
0072A2  ori.b  #$0, d0
0072A6  ; data: 0xff, 0xff
0072A8  lsr.w  d7, d4
0072AA  ori.b  #$3, d3
0072AE  ori.b  #$0, d4
0072B2  ori.b  #$9a, d0
0072B6  ori.b  #$0, d0
0072BA  ori.b  #$1e, d0
0072BE  ori.b  #$0, d0
0072C2  ori.b  #$0, d0
0072C6  ori.b  #$0, d0
0072CA  ori.b  #$94, d0
0072CE  ori.b  #$4, d5
0072D2  ori.b  #$0, d3
0072D6  ori.b  #$20, d0
0072DA  ori.b  #$2, d0
0072DE  ori.b  #$e6, d0
0072E2  ori.b  #$fa, d0
0072E6  ori.b  #$0, d0
0072EA  ori.b  #$0, d0
0072EE  ori.b  #$0, d0
0072F2  andi.b #$0, d0
0072F6  ori.b  #$0, d0
0072FA  ori.b  #$48, d0
0072FE  ori.b  #$0, d0
007302  ori.b  #$0, d0
007306  ori.b  #$0, d0
00730A  ori.b  #$0, d0
00730E  ori.b  #$2, d1
007312  ori.b  #$0, d3
007316  ori.b  #$36, d0
00731A  ori.b  #$0, d0
00731E  ori.b  #$e6, d0
007322  ori.b  #$3a, d0
007326  ori.b  #$0, d0
00732A  ori.b  #$0, d0
00732E  ori.b  #$0, d0
007332  andi.b #$0, d0
007336  ori.b  #$0, d0
00733A  ori.b  #$4c, d0
00733E  ori.b  #$0, d0
007342  ori.b  #$9a, d0
007346  ori.b  #$0, d0
00734A  ori.b  #$e6, d0
00734E  ori.b  #$66, d0
007352  ori.b  #$0, d0
007356  ori.b  #$0, d0
00735A  ori.b  #$0, d0
00735E  ori.b  #$0, d0
007362  ori.b  #$0, d0
007366  ori.b  #$4c, d0
00736A  ori.b  #$0, d0
00736E  ori.b  #$20, d0
007372  ori.b  #$92, d0
007376  ori.b  #$1e, d0
00737A  ori.b  #$0, d0
00737E  ori.b  #$0, d0
007382  ori.b  #$0, d0
007386  ori.b  #$0, d0
00738A  ori.b  #$0, d0
00738E  ori.b  #$0, d0
007392  ori.b  #$0, d0
007396  ori.b  #$0, d0
00739A  ori.b  #$0, d0
00739E  ori.b  #$f6, d0
0073A2  ori.b  #$0, d0
0073A6  ori.b  #$20, d0
0073AA  ori.b  #$ca, d0
0073AE  ori.b  #$e6, d0
0073B2  ori.b  #$de, d0
0073B6  ori.b  #$0, d0
0073BA  ori.b  #$0, d0
0073BE  ori.b  #$0, d0
0073C2  ori.b  #$0, d0
0073C6  ori.b  #$0, d0
0073CA  ori.b  #$0, d0
0073CE  ori.b  #$0, d0
0073D2  ori.b  #$0, d0
0073D6  ori.b  #$0, d0
0073DA  ori.b  #$0, d0
0073DE  ori.b  #$68, d0
0073E2  ori.b  #$0, d0
0073E6  ori.b  #$0, d0
0073EA  addq.w #$1, $73e6.l
0073F0  move.w $73e6(pc), d0
0073F4  move.w $73e8(pc), d1
0073F8  add.w  d1, d1
0073FA  add.w  d1, d1
0073FC  movea.l $7402(pc, d1.w), a0
007400  jmp    (a0)
007402  ori.b  #$22, d0
007406  ori.b  #$74, d0
00740A  ori.b  #$98, d0
00740E  ori.b  #$bc, d0
007412  ori.b  #$e0, d0
007416  ori.b  #$4, d0
00741A  ori.b  #$1a, d0
00741E  ori.b  #$1a, d0
007422  cmpi.w #$20, $73e6.l
00742A  bhi.b  $7448
00742C  moveq  #$1, d0
00742E  and.w  $73e6(pc), d0
007432  bne.b  $7448
007434  lea.l  $75fe.l, a0
00743A  lea.l  $d4.l, a1
007440  moveq  #$7, d0
007442  moveq  #$2, d1
007444  jsr    -$a2(a6)
007448  cmpi.w #$800, $73e6.l
007450  bcc.b  $7454
007452  rts    
007454  move.w #$1, $73e8.l
00745C  movea.l $5be0(pc), a0
007460  movea.l $20(a5), a1
007464  jsr    $239e(pc)
007468  movea.l $5bd8(pc), a0
00746C  movea.l $20(a5), a1
007470  bra.w  $1fe6
007474  cmpi.w #$a00, $73e6.l
00747C  bcc.b  $7480
00747E  rts    
007480  move.w #$2, $73e8.l
007488  move.l $5bc8(pc), $20(a5)
00748E  move.l #$760c, $2c(a5)
007496  rts    
007498  cmpi.w #$e00, $73e6.l
0074A0  bcc.b  $74a4
0074A2  rts    
0074A4  move.w #$3, $73e8.l
0074AC  move.l $5bd4(pc), $20(a5)
0074B2  move.l #$763c, $2c(a5)
0074BA  rts    
0074BC  cmpi.w #$1000, $73e6.l
0074C4  bcc.b  $74c8
0074C6  rts    
0074C8  move.w #$4, $73e8.l
0074D0  move.l $5bd0(pc), $20(a5)
0074D6  move.l #$761c, $2c(a5)
0074DE  rts    
0074E0  cmpi.w #$1442, $73e6.l
0074E8  bcc.b  $74ec
0074EA  rts    
0074EC  move.w #$5, $73e8.l
0074F4  move.l $5bcc(pc), $20(a5)
0074FA  move.l #$762c, $2c(a5)
007502  rts    
007504  cmpi.w #$1e02, $73e6.l
00750C  bcc.b  $7510
00750E  rts    
007510  movea.l $18(a5), a0
007514  move.w $e(a0), $c(a0)
00751A  rts    
00751C  ori.b  #$0, d0
007520  movea.l $28(a5), a0
007524  moveq  #$0, d0
007526  bra.b  $7532
007528  cmpi.l #$2520, $c(a0)
007530  beq.b  $7546
007532  movea.l (a0), a0
007534  tst.l  (a0)
007536  bne.b  $7528
007538  tst.l  d0
00753A  bne.b  $754e
00753C  movea.l $28(a5), a0
007540  move.l $10(a0), d0
007544  rts    
007546  move.l a0, d0
007548  cmp.l  $751c(pc), d0
00754C  beq.b  $7532
00754E  move.l d0, $751c.l
007554  rts    
007556  jmp    $249e.l
00755C  jmp    $75ee.l
007562  jmp    $75ea.l
007568  movem.l d2/a2-a3, -(a7)
00756C  movea.l a0, a2
00756E  movea.l a1, a3
007570  move.w $34(a5), d0
007574  bra.b  $758c
007576  addi.w #$1, (a3)
00757A  addi.w #$fffe, $2(a3)
007580  addi.w #$3, $4(a3)
007586  addi.w #$4, $8(a3)
00758C  dbra   d0, $7576
007590  lea.l  (a3), a0
007592  lea.l  $28(a2), a1
007596  bsr.w  $1f4c
00759A  move.w $8(a3), d0
00759E  lea.l  $1056(pc), a0
0075A2  and.w  #$7fe, d0
0075A6  move.w (a0, d0.w), d0
0075AA  muls.w #$e0c0, d0
0075AE  swap   d0
0075B0  add.w  #$e0c0, d0
0075B4  move.w d0, d1
0075B6  move.w d0, d2
0075B8  lea.l  $28(a2), a0
0075BC  muls.w $4(a0), d0
0075C0  muls.w $a(a0), d1
0075C4  muls.w $10(a0), d2
0075C8  add.l  d0, d0
0075CA  swap   d0
0075CC  add.l  d1, d1
0075CE  swap   d1
0075D0  add.l  d2, d2
0075D2  swap   d2
0075D4  ext.l  d0
0075D6  ext.l  d1
0075D8  ext.l  d2
0075DA  lea.l  $1c(a2), a0
0075DE  move.l d0, (a0)+
0075E0  move.l d1, (a0)+
0075E2  move.l d2, (a0)
0075E4  movem.l (a7)+, d2/a2-a3
0075E8  rts    
0075EA  moveq  #$c, d0
0075EC  rts    
0075EE  move.w #$400, $8(a0)
0075F4  move.w #$400, (a0)
0075F8  jmp    $250c(pc)
0075FC  ori.b  #$84, d0
007600  eori.w #$842, -(a3)
007604  ; data: 0x0a, 0x88
007606  ; data: 0x08, 0x66
007608  movep.l $473(a4), d0
00760C  ori.b  #$ca, d0
007610  bclr.b d1, $286(a0)
007614  ; data: 0x08, 0x86
007616  btst.l d1, $47(a2, invalid.w)
00761C  ori.b  #$8f, d0
007620  bchg.b d1, $248(a4)
007624  ; data: 0x0a, 0x88
007626  ; data: 0x08, 0x66
007628  bchg.b d0, -(a5)
00762A  bclr.b d1, $0(a1)
00762E  ; data: 0x0b, 0x7c
007630  ; data: 0x08, 0x59
007632  addi.w #$456, d7
007636  andi.b #$66, (a4, invalid.w)
00763C  ori.b  #$6, d0
007640  cmpi.b #$3, d5
007644  bset.b d7, d0
007646  cmpi.l #$7090507, d0
00764C  ori.b  #$68, d0
007650  ori.b  #$98, d0
007654  ori.b  #$e0, d0
007658  ori.b  #$58, d0
00765C  ; data: 0x00, 0x08
00765E  ori.b  #$6, d6
007662  ori.b  #$bb, d6
007666  ori.b  #$0, d0
00766A  btst.l d0, d0
00766C  btst.l d0, d0
00766E  btst.l d0, d0
007670  ; data: 0xff, 0x00
007672  btst.l d0, d0
007674  ; data: 0xff, 0x00
007676  ; data: 0xff, 0x00
007678  btst.l d0, d0
00767A  ; data: 0xff, 0x00
00767C  btst.l d0, d0
00767E  btst.l d0, d0
007680  btst.l d0, d0
007682  btst.l d0, d0
007684  ; data: 0xff, 0x00
007686  btst.l d0, d0
007688  ; data: 0xff, 0x00
00768A  ; data: 0xff, 0x00
00768C  ; data: 0xff, 0x00
00768E  ; data: 0xff, 0x00
007690  ; data: 0xff, 0x00
007692  ; data: 0xff, 0x00
007694  btst.l d0, d0
007696  ; data: 0xff, 0x00
007698  ori.b  #$4, d4
00769C  ori.b  #$d0, d0
0076A0  ori.b  #$d0, d0
0076A4  ori.b  #$4, d4
0076A8  ori.b  #$e4, d0
0076AC  ori.b  #$e4, d0
0076B0  ori.b  #$4, d4
0076B4  ori.b  #$f8, d0
0076B8  ori.b  #$f8, d0
0076BC  ori.b  #$4, d4
0076C0  ori.b  #$c, d0
0076C4  ori.b  #$c, d0
0076C8  ori.b  #$4, d4
0076CC  ori.b  #$20, d0
0076D0  ori.b  #$20, d0
0076D4  ori.b  #$4, d4
0076D8  ori.b  #$34, d0
0076DC  ori.b  #$34, d0
0076E0  ori.b  #$98, d0
0076E4  ori.b  #$0, d1
0076E8  ori.b  #$40, d0
0076EC  ori.b  #$44, d0
0076F0  ori.b  #$a4, d0
0076F4  ori.b  #$0, d1
0076F8  ori.b  #$44, d0
0076FC  ori.b  #$48, d0
007700  ori.b  #$b0, d0
007704  ori.b  #$0, d1
007708  ori.b  #$48, d0
00770C  ori.b  #$4c, d0
007710  ori.b  #$bc, d0
007714  ori.b  #$0, d1
007718  ori.b  #$4c, d0
00771C  ori.b  #$50, d0
007720  ori.b  #$c8, d0
007724  ori.b  #$0, d1
007728  ori.b  #$50, d0
00772C  ori.b  #$54, d0
007730  ori.b  #$d4, d0
007734  ori.b  #$0, d1
007738  ori.b  #$54, d0
00773C  ori.b  #$58, d0
007740  ori.b  #$58, d0
007744  ori.b  #$6c, d0
007748  ori.b  #$80, d0
00774C  ori.b  #$94, d0
007750  ori.b  #$a8, d0
007754  ori.b  #$bc, d0
007758  ori.b  #$2c, d0
00775C  ori.b  #$98, d0
007760  ori.b  #$5, d1
007764  ori.b  #$0, d0
007768  ori.b  #$0, d0
00776C  ori.b  #$2c, d0
007770  ori.b  #$a4, d0
007774  ori.b  #$5, d1
007778  ori.b  #$0, d0
00777C  ori.b  #$0, d0
007780  ori.b  #$2c, d0
007784  ori.b  #$b0, d0
007788  ori.b  #$0, d1
00778C  ori.b  #$0, d0
007790  ori.b  #$0, d0
007794  ori.b  #$2c, d0
007798  ori.b  #$bc, d0
00779C  ori.b  #$4, d1
0077A0  ori.b  #$0, d0
0077A4  ori.b  #$0, d0
0077A8  ori.b  #$2c, d0
0077AC  ori.b  #$c8, d0
0077B0  ori.b  #$0, d1
0077B4  ori.b  #$0, d0
0077B8  ori.b  #$0, d0
0077BC  ori.b  #$2c, d0
0077C0  ori.b  #$d4, d0
0077C4  ori.b  #$4, d1
0077C8  ori.b  #$0, d0
0077CC  ori.b  #$0, d0
0077D0  ori.b  #$b8, d5
0077D4  ori.b  #$c4, d5
0077D8  ori.b  #$d0, d5
0077DC  ori.b  #$ac, d5
0077E0  ori.b  #$b8, d5
0077E4  ori.b  #$0, d5
0077E8  ori.b  #$f4, d5
0077EC  ori.b  #$e8, d5
0077F0  ori.b  #$dc, d5
0077F4  ori.b  #$0, d5
0077F8  ori.b  #$ac, d5
0077FC  ori.b  #$d0, d5
007800  ori.b  #$0, d5
007804  ori.b  #$dc, d5
007808  ori.b  #$ac, d5
00780C  ori.b  #$e8, d5
007810  ori.b  #$b8, d5
007814  ori.b  #$ac, d5
007818  ori.b  #$dc, d5
00781C  ori.b  #$e8, d5
007820  ori.b  #$e8, d5
007824  ori.b  #$f4, d5
007828  ori.b  #$c4, d5
00782C  ori.b  #$b8, d5
007830  ori.b  #$e8, d5
007834  ori.b  #$f4, d5
007838  ori.b  #$0, d5
00783C  ori.b  #$d0, d5
007840  ori.b  #$c4, d5
007844  ori.b  #$f4, d5
007848  ori.b  #$64, d0
00784C  ori.b  #$54, d0
007850  ori.b  #$94, d0
007854  ori.b  #$54, d0
007858  ori.b  #$30, $30(a0)
00785E  ori.b  #$88, (a0, d0.w)
007864  dc.w   $f830
007866  bset.b d3, (a0)
007868  dc.w   $f830
00786A  ; data: 0xf9, 0xc0
00786C  addi.w #$f9c0, d0
007870  dc.w   $f830
007872  addi.w #$f9c0, d0
007876  ; data: 0xf9, 0xc0
007878  bset.b d3, (a0)
00787A  ; data: 0xf9, 0xc0
00787C  ; data: 0xf9, 0xc0
00787E  addi.w #$f830, d0
007882  bset.b d3, (a0)
007884  bset.b d3, (a0)
007886  dc.w   $f830
007888  addi.w #$640, d0
00788C  ; data: 0xf9, 0xc0
00788E  bset.b d3, (a0)
007890  addi.w #$f9c0, d0
007894  addi.w #$7d0, d0
007898  ; data: 0xf9, 0xc0
00789A  addi.w #$640, d0
00789E  dc.w   $f830
0078A0  bset.b d3, (a0)
0078A2  bset.b d3, (a0)
0078A4  bset.b d3, (a0)
0078A6  addi.w #$640, d0
0078AA  addi.w #$7d0, d0
0078AE  addi.w #$640, d0
0078B2  addi.w #$7d0, d0
0078B6  addi.w #$640, d0
0078BA  addi.w #$7d0, d0
0078BE  dc.w   $f830
0078C0  bset.b d3, (a0)
0078C2  bset.b d3, (a0)
0078C4  ; data: 0xf9, 0xc0
0078C6  addi.w #$640, d0
0078CA  dc.w   $f830
0078CC  addi.w #$640, d0
0078D0  ; data: 0xf9, 0xc0
0078D2  bset.b d3, (a0)
0078D4  addi.w #$f9c0, d0
0078D8  addi.w #$7d0, d0
0078DC  dc.w   $f830
0078DE  dc.w   $f830
0078E0  dc.w   $f830
0078E2  ; data: 0xf9, 0xc0
0078E4  ; data: 0xf9, 0xc0
0078E6  ; data: 0xf9, 0xc0
0078E8  dc.w   $f830
0078EA  ; data: 0xf9, 0xc0
0078EC  ; data: 0xf9, 0xc0
0078EE  ; data: 0xf9, 0xc0
0078F0  dc.w   $f830
0078F2  ; data: 0xf9, 0xc0
0078F4  ; data: 0xf9, 0xc0
0078F6  ; data: 0xf9, 0xc0
0078F8  dc.w   $f830
0078FA  bset.b d3, (a0)
0078FC  dc.w   $f830
0078FE  dc.w   $f830
007900  addi.w #$f9c0, d0
007904  ; data: 0xf9, 0xc0
007906  bset.b d3, (a0)
007908  ; data: 0xf9, 0xc0
00790A  ; data: 0xf9, 0xc0
00790C  addi.w #$f830, d0
007910  ; data: 0xf9, 0xc0
007912  addi.w #$f9c0, d0
007916  dc.w   $f830
007918  bset.b d3, (a0)
00791A  dc.w   $f830
00791C  bset.b d3, (a0)
00791E  addi.w #$f9c0, d0
007922  addi.w #$7d0, d0
007926  ; data: 0xf9, 0xc0
007928  addi.w #$640, d0
00792C  dc.w   $f830
00792E  addi.w #$640, d0
007932  ; data: 0xf9, 0xc0
007934  bset.b d3, (a0)
007936  dc.w   $f830
007938  dc.w   $f830
00793A  bset.b d3, (a0)
00793C  ; data: 0xf9, 0xc0
00793E  ; data: 0xf9, 0xc0
007940  addi.w #$f830, d0
007944  ; data: 0xf9, 0xc0
007946  addi.w #$f9c0, d0
00794A  dc.w   $f830
00794C  addi.w #$f9c0, d0
007950  ; data: 0xf9, 0xc0
007952  bset.b d3, (a0)
007954  ori.b  #$4, d4
007958  ori.b  #$14, d0
00795C  ori.b  #$14, d0
007960  ori.b  #$4, d4
007964  ori.b  #$28, d0
007968  ori.b  #$28, d0
00796C  ori.b  #$4, d4
007970  ori.b  #$3c, d0
007974  ori.b  #$3c, d0
007978  ori.b  #$4, d4
00797C  ori.b  #$50, d0
007980  ori.b  #$50, d0
007984  ori.b  #$4, d4
007988  ori.b  #$64, d0
00798C  ori.b  #$64, d0
007990  ori.b  #$4, d4
007994  ori.b  #$78, d0
007998  ori.b  #$78, d0
00799C  ori.b  #$4, d4
0079A0  ori.b  #$8c, d0
0079A4  ori.b  #$8c, d0
0079A8  ori.b  #$4, d4
0079AC  ori.b  #$a0, d0
0079B0  ori.b  #$a0, d0
0079B4  ori.b  #$4, d4
0079B8  ori.b  #$b4, d0
0079BC  ori.b  #$b4, d0
0079C0  ori.b  #$4, d4
0079C4  ori.b  #$c8, d0
0079C8  ori.b  #$c8, d0
0079CC  ori.b  #$4, d4
0079D0  ori.b  #$dc, d0
0079D4  ori.b  #$dc, d0
0079D8  ori.b  #$4, d4
0079DC  ori.b  #$f0, d0
0079E0  ori.b  #$f0, d0
0079E4  ori.b  #$4, d4
0079E8  ori.b  #$4, d0
0079EC  ori.b  #$4, d0
0079F0  ori.b  #$4, d4
0079F4  ori.b  #$18, d0
0079F8  ori.b  #$18, d0
0079FC  ori.b  #$4, d4
007A00  ori.b  #$2c, d0
007A04  ori.b  #$2c, d0
007A08  ori.b  #$4, d4
007A0C  ori.b  #$40, d0
007A10  ori.b  #$40, d0
007A14  ori.b  #$4, d4
007A18  ori.b  #$54, d0
007A1C  ori.b  #$54, d0
007A20  ori.b  #$4, d4
007A24  ori.b  #$68, d0
007A28  ori.b  #$68, d0
007A2C  ori.b  #$4, d4
007A30  ori.b  #$7c, d0
007A34  ori.b  #$7c, d0
007A38  ori.b  #$4, d4
007A3C  ori.b  #$90, d0
007A40  ori.b  #$90, d0
007A44  ori.b  #$4, d4
007A48  ori.b  #$a4, d0
007A4C  ori.b  #$a4, d0
007A50  ori.b  #$4, d4
007A54  ori.b  #$b8, d0
007A58  ori.b  #$b8, d0
007A5C  ori.b  #$4, d4
007A60  ori.b  #$cc, d0
007A64  ori.b  #$cc, d0
007A68  ori.b  #$4, d4
007A6C  ori.b  #$e0, d0
007A70  ori.b  #$e0, d0
007A74  ori.b  #$4, d4
007A78  ori.b  #$f4, d0
007A7C  ori.b  #$f4, d0
007A80  ori.b  #$4, d4
007A84  ori.b  #$8, d0
007A88  ori.b  #$8, d0
007A8C  ori.b  #$4, d4
007A90  ori.b  #$1c, d0
007A94  ori.b  #$1c, d0
007A98  ori.b  #$4, d4
007A9C  ori.b  #$30, d0
007AA0  ori.b  #$30, d0
007AA4  ori.b  #$4, d4
007AA8  ori.b  #$44, d0
007AAC  ori.b  #$44, d0
007AB0  ori.b  #$4, d4
007AB4  ori.b  #$58, d0
007AB8  ori.b  #$58, d0
007ABC  ori.b  #$4, d4
007AC0  ori.b  #$6c, d0
007AC4  ori.b  #$6c, d0
007AC8  ori.b  #$4, d4
007ACC  ori.b  #$80, d0
007AD0  ori.b  #$80, d0
007AD4  ori.b  #$4, d4
007AD8  ori.b  #$94, d0
007ADC  ori.b  #$94, d0
007AE0  ori.b  #$4, d4
007AE4  ori.b  #$a8, d0
007AE8  ori.b  #$a8, d0
007AEC  ori.b  #$4, d4
007AF0  ori.b  #$bc, d0
007AF4  ori.b  #$bc, d0
007AF8  ori.b  #$4, d4
007AFC  ori.b  #$d0, d0
007B00  ori.b  #$d0, d0
007B04  ori.b  #$4, d4
007B08  ori.b  #$e4, d0
007B0C  ori.b  #$e4, d0
007B10  ori.b  #$4, d4
007B14  ori.b  #$f8, d0
007B18  ori.b  #$f8, d0
007B1C  ori.b  #$4, d4
007B20  ori.b  #$c, d0
007B24  ori.b  #$c, d0
007B28  ori.b  #$4, d4
007B2C  ori.b  #$20, d0
007B30  ori.b  #$20, d0
007B34  ori.b  #$4, d4
007B38  ori.b  #$34, d0
007B3C  ori.b  #$34, d0
007B40  ori.b  #$4, d4
007B44  ori.b  #$48, d0
007B48  ori.b  #$48, d0
007B4C  ori.b  #$4, d4
007B50  ori.b  #$5c, d0
007B54  ori.b  #$5c, d0
007B58  ori.b  #$4, d4
007B5C  ori.b  #$70, d0
007B60  ori.b  #$70, d0
007B64  ori.b  #$4, d4
007B68  ori.b  #$84, d0
007B6C  ori.b  #$84, d0
007B70  ori.b  #$4, d4
007B74  ori.b  #$98, d0
007B78  ori.b  #$98, d0
007B7C  ori.b  #$4, d4
007B80  ori.b  #$ac, d0
007B84  ori.b  #$ac, d0
007B88  ori.b  #$4, d4
007B8C  ori.b  #$c0, d0
007B90  ori.b  #$c0, d0
007B94  ori.b  #$54, d0
007B98  ori.b  #$0, d1
007B9C  ori.b  #$94, d0
007BA0  ori.b  #$98, d0
007BA4  ori.b  #$60, d0
007BA8  ori.b  #$0, d1
007BAC  ori.b  #$98, d0
007BB0  ori.b  #$9c, d0
007BB4  ori.b  #$6c, d0
007BB8  ori.b  #$0, d1
007BBC  ori.b  #$9c, d0
007BC0  ori.b  #$a0, d0
007BC4  ori.b  #$78, d0
007BC8  ori.b  #$0, d1
007BCC  ori.b  #$a0, d0
007BD0  ori.b  #$a4, d0
007BD4  ori.b  #$84, d0
007BD8  ori.b  #$0, d1
007BDC  ori.b  #$a4, d0
007BE0  ori.b  #$a8, d0
007BE4  ori.b  #$90, d0
007BE8  ori.b  #$0, d1
007BEC  ori.b  #$a8, d0
007BF0  ori.b  #$ac, d0
007BF4  ori.b  #$9c, d0
007BF8  ori.b  #$0, d1
007BFC  ori.b  #$ac, d0
007C00  ori.b  #$b0, d0
007C04  ori.b  #$a8, d0
007C08  ori.b  #$0, d1
007C0C  ori.b  #$b0, d0
007C10  ori.b  #$b4, d0
007C14  ori.b  #$b4, d0
007C18  ori.b  #$0, d1
007C1C  ori.b  #$b4, d0
007C20  ori.b  #$b8, d0
007C24  ori.b  #$c0, d0
007C28  ori.b  #$0, d1
007C2C  ori.b  #$b8, d0
007C30  ori.b  #$bc, d0
007C34  ori.b  #$cc, d0
007C38  ori.b  #$0, d1
007C3C  ori.b  #$bc, d0
007C40  ori.b  #$c0, d0
007C44  ori.b  #$d8, d0
007C48  ori.b  #$0, d1
007C4C  ori.b  #$c0, d0
007C50  ori.b  #$c4, d0
007C54  ori.b  #$e4, d0
007C58  ori.b  #$0, d1
007C5C  ori.b  #$c4, d0
007C60  ori.b  #$c8, d0
007C64  ori.b  #$f0, d0
007C68  ori.b  #$0, d1
007C6C  ori.b  #$c8, d0
007C70  ori.b  #$cc, d0
007C74  ori.b  #$fc, d0
007C78  ori.b  #$0, d1
007C7C  ori.b  #$cc, d0
007C80  ori.b  #$d0, d0
007C84  ori.b  #$8, d0
007C88  ori.b  #$0, d1
007C8C  ori.b  #$d0, d0
007C90  ori.b  #$d4, d0
007C94  ori.b  #$14, d0
007C98  ori.b  #$0, d1
007C9C  ori.b  #$d4, d0
007CA0  ori.b  #$d8, d0
007CA4  ori.b  #$20, d0
007CA8  ori.b  #$0, d1
007CAC  ori.b  #$d8, d0
007CB0  ori.b  #$dc, d0
007CB4  ori.b  #$2c, d0
007CB8  ori.b  #$0, d1
007CBC  ori.b  #$dc, d0
007CC0  ori.b  #$e0, d0
007CC4  ori.b  #$38, d0
007CC8  ori.b  #$0, d1
007CCC  ori.b  #$e0, d0
007CD0  ori.b  #$e4, d0
007CD4  ori.b  #$44, d0
007CD8  ori.b  #$0, d1
007CDC  ori.b  #$e4, d0
007CE0  ori.b  #$e8, d0
007CE4  ori.b  #$50, d0
007CE8  ori.b  #$0, d1
007CEC  ori.b  #$e8, d0
007CF0  ori.b  #$ec, d0
007CF4  ori.b  #$5c, d0
007CF8  ori.b  #$0, d1
007CFC  ori.b  #$ec, d0
007D00  ori.b  #$f0, d0
007D04  ori.b  #$68, d0
007D08  ori.b  #$0, d1
007D0C  ori.b  #$f0, d0
007D10  ori.b  #$f4, d0
007D14  ori.b  #$74, d0
007D18  ori.b  #$0, d1
007D1C  ori.b  #$f4, d0
007D20  ori.b  #$f8, d0
007D24  ori.b  #$80, d0
007D28  ori.b  #$0, d1
007D2C  ori.b  #$f8, d0
007D30  ori.b  #$fc, d0
007D34  ori.b  #$8c, d0
007D38  ori.b  #$0, d1
007D3C  ori.b  #$fc, d0
007D40  ori.b  #$0, d0
007D44  ori.b  #$98, d0
007D48  ori.b  #$0, d1
007D4C  ori.b  #$0, d0
007D50  ori.b  #$4, d0
007D54  ori.b  #$a4, d0
007D58  ori.b  #$0, d1
007D5C  ori.b  #$4, d0
007D60  ori.b  #$8, d0
007D64  ori.b  #$b0, d0
007D68  ori.b  #$0, d1
007D6C  ori.b  #$8, d0
007D70  ori.b  #$c, d0
007D74  ori.b  #$bc, d0
007D78  ori.b  #$0, d1
007D7C  ori.b  #$c, d0
007D80  ori.b  #$10, d0
007D84  ori.b  #$c8, d0
007D88  ori.b  #$0, d1
007D8C  ori.b  #$10, d0
007D90  ori.b  #$14, d0
007D94  ori.b  #$d4, d0
007D98  ori.b  #$0, d1
007D9C  ori.b  #$14, d0
007DA0  ori.b  #$18, d0
007DA4  ori.b  #$e0, d0
007DA8  ori.b  #$0, d1
007DAC  ori.b  #$18, d0
007DB0  ori.b  #$1c, d0
007DB4  ori.b  #$ec, d0
007DB8  ori.b  #$0, d1
007DBC  ori.b  #$1c, d0
007DC0  ori.b  #$20, d0
007DC4  ori.b  #$f8, d0
007DC8  ori.b  #$0, d1
007DCC  ori.b  #$20, d0
007DD0  ori.b  #$24, d0
007DD4  ori.b  #$4, d0
007DD8  ori.b  #$0, d1
007DDC  ori.b  #$24, d0
007DE0  ori.b  #$28, d0
007DE4  ori.b  #$10, d0
007DE8  ori.b  #$0, d1
007DEC  ori.b  #$28, d0
007DF0  ori.b  #$2c, d0
007DF4  ori.b  #$1c, d0
007DF8  ori.b  #$0, d1
007DFC  ori.b  #$2c, d0
007E00  ori.b  #$30, d0
007E04  ori.b  #$28, d0
007E08  ori.b  #$0, d1
007E0C  ori.b  #$30, d0
007E10  ori.b  #$34, d0
007E14  ori.b  #$34, d0
007E18  ori.b  #$0, d1
007E1C  ori.b  #$34, d0
007E20  ori.b  #$38, d0
007E24  ori.b  #$40, d0
007E28  ori.b  #$0, d1
007E2C  ori.b  #$38, d0
007E30  ori.b  #$3c, d0
007E34  ori.b  #$4c, d0
007E38  ori.b  #$0, d1
007E3C  ori.b  #$3c, d0
007E40  ori.b  #$40, d0
007E44  ori.b  #$58, d0
007E48  ori.b  #$0, d1
007E4C  ori.b  #$40, d0
007E50  ori.b  #$44, d0
007E54  ori.b  #$64, d0
007E58  ori.b  #$0, d1
007E5C  ori.b  #$44, d0
007E60  ori.b  #$48, d0
007E64  ori.b  #$70, d0
007E68  ori.b  #$0, d1
007E6C  ori.b  #$48, d0
007E70  ori.b  #$4c, d0
007E74  ori.b  #$7c, d0
007E78  ori.b  #$0, d1
007E7C  ori.b  #$4c, d0
007E80  ori.b  #$50, d0
007E84  ori.b  #$88, d0
007E88  ori.b  #$0, d1
007E8C  ori.b  #$50, d0
007E90  ori.b  #$54, d0
007E94  ori.b  #$34, d0
007E98  ori.b  #$48, d0
007E9C  ori.b  #$5c, d0
007EA0  ori.b  #$70, d0
007EA4  ori.b  #$84, d0
007EA8  ori.b  #$98, d0
007EAC  ori.b  #$ac, d0
007EB0  ori.b  #$c0, d0
007EB4  ori.b  #$d4, d0
007EB8  ori.b  #$e8, d0
007EBC  ori.b  #$fc, d0
007EC0  ori.b  #$10, d0
007EC4  ori.b  #$24, d0
007EC8  ori.b  #$38, d0
007ECC  ori.b  #$4c, d0
007ED0  ori.b  #$60, d0
007ED4  ori.b  #$74, d0
007ED8  ori.b  #$88, d0
007EDC  ori.b  #$9c, d0
007EE0  ori.b  #$b0, d0
007EE4  ori.b  #$c4, d0
007EE8  ori.b  #$d8, d0
007EEC  ori.b  #$ec, d0
007EF0  ori.b  #$0, d0
007EF4  ori.b  #$54, d0
007EF8  ori.b  #$68, d0
007EFC  ori.b  #$7c, d0
007F00  ori.b  #$90, d0
007F04  ori.b  #$a4, d0
007F08  ori.b  #$b8, d0
007F0C  ori.b  #$cc, d0
007F10  ori.b  #$e0, d0
007F14  ori.b  #$f4, d0
007F18  ori.b  #$8, d0
007F1C  ori.b  #$1c, d0
007F20  ori.b  #$30, d0
007F24  ori.b  #$44, d0
007F28  ori.b  #$58, d0
007F2C  ori.b  #$6c, d0
007F30  ori.b  #$80, d0
007F34  ori.b  #$94, d0
007F38  ori.b  #$a8, d0
007F3C  ori.b  #$bc, d0
007F40  ori.b  #$d0, d0
007F44  ori.b  #$e4, d0
007F48  ori.b  #$f8, d0
007F4C  ori.b  #$c, d0
007F50  ori.b  #$20, d0
007F54  ori.b  #$2c, d0
007F58  ori.b  #$74, d0
007F5C  ori.b  #$4, d1
007F60  ori.b  #$0, d0
007F64  ori.b  #$0, d0
007F68  ori.b  #$2c, d0
007F6C  ori.b  #$80, d0
007F70  ori.b  #$5, d1
007F74  ori.b  #$0, d0
007F78  ori.b  #$0, d0
007F7C  ori.b  #$2c, d0
007F80  ori.b  #$8c, d0
007F84  ori.b  #$4, d1
007F88  ori.b  #$0, d0
007F8C  ori.b  #$0, d0
007F90  ori.b  #$2c, d0
007F94  ori.b  #$98, d0
007F98  ori.b  #$5, d1
007F9C  ori.b  #$0, d0
007FA0  ori.b  #$0, d0
007FA4  ori.b  #$2c, d0
007FA8  ori.b  #$a4, d0
007FAC  ori.b  #$5, d1
007FB0  ori.b  #$0, d0
007FB4  ori.b  #$0, d0
007FB8  ori.b  #$2c, d0
007FBC  ori.b  #$b0, d0
007FC0  ori.b  #$4, d1
007FC4  ori.b  #$0, d0
007FC8  ori.b  #$0, d0
007FCC  ori.b  #$2c, d0
007FD0  ori.b  #$bc, d0
007FD4  ori.b  #$5, d1
007FD8  ori.b  #$0, d0
007FDC  ori.b  #$0, d0
007FE0  ori.b  #$2c, d0
007FE4  ori.b  #$c8, d0
007FE8  ori.b  #$4, d1
007FEC  ori.b  #$0, d0
007FF0  ori.b  #$0, d0
007FF4  ori.b  #$2c, d0
007FF8  ori.b  #$d4, d0
007FFC  ori.b  #$4, d1
008000  ori.b  #$0, d0
008004  ori.b  #$0, d0
008008  ori.b  #$2c, d0
00800C  ori.b  #$e0, d0
008010  ori.b  #$5, d1
008014  ori.b  #$0, d0
008018  ori.b  #$0, d0
00801C  ori.b  #$2c, d0
008020  ori.b  #$ec, d0
008024  ori.b  #$4, d1
008028  ori.b  #$0, d0
00802C  ori.b  #$0, d0
008030  ori.b  #$2c, d0
008034  ori.b  #$f8, d0
008038  ori.b  #$5, d1
00803C  ori.b  #$0, d0
008040  ori.b  #$0, d0
008044  ori.b  #$2c, d0
008048  ori.b  #$4, d0
00804C  ori.b  #$5, d1
008050  ori.b  #$0, d0
008054  ori.b  #$0, d0
008058  ori.b  #$2c, d0
00805C  ori.b  #$10, d0
008060  ori.b  #$4, d1
008064  ori.b  #$0, d0
008068  ori.b  #$0, d0
00806C  ori.b  #$2c, d0
008070  ori.b  #$1c, d0
008074  ori.b  #$5, d1
008078  ori.b  #$0, d0
00807C  ori.b  #$0, d0
008080  ori.b  #$2c, d0
008084  ori.b  #$28, d0
008088  ori.b  #$4, d1
00808C  ori.b  #$0, d0
008090  ori.b  #$0, d0
008094  ori.b  #$2c, d0
008098  ori.b  #$34, d0
00809C  ori.b  #$5, d1
0080A0  ori.b  #$0, d0
0080A4  ori.b  #$0, d0
0080A8  ori.b  #$2c, d0
0080AC  ori.b  #$40, d0
0080B0  ori.b  #$4, d1
0080B4  ori.b  #$0, d0
0080B8  ori.b  #$0, d0
0080BC  ori.b  #$2c, d0
0080C0  ori.b  #$4c, d0
0080C4  ori.b  #$5, d1
0080C8  ori.b  #$0, d0
0080CC  ori.b  #$0, d0
0080D0  ori.b  #$2c, d0
0080D4  ori.b  #$58, d0
0080D8  ori.b  #$4, d1
0080DC  ori.b  #$0, d0
0080E0  ori.b  #$0, d0
0080E4  ori.b  #$2c, d0
0080E8  ori.b  #$64, d0
0080EC  ori.b  #$5, d1
0080F0  ori.b  #$0, d0
0080F4  ori.b  #$0, d0
0080F8  ori.b  #$2c, d0
0080FC  ori.b  #$70, d0
008100  ori.b  #$4, d1
008104  ori.b  #$0, d0
008108  ori.b  #$0, d0
00810C  ori.b  #$2c, d0
008110  ori.b  #$7c, d0
008114  ori.b  #$5, d1
008118  ori.b  #$0, d0
00811C  ori.b  #$0, d0
008120  ori.b  #$2c, d0
008124  ori.b  #$88, d0
008128  ori.b  #$4, d1
00812C  ori.b  #$0, d0
008130  ori.b  #$0, d0
008134  ori.b  #$2c, d0
008138  ori.b  #$54, d0
00813C  ori.b  #$1, d1
008140  ori.b  #$0, d0
008144  ori.b  #$0, d0
008148  ori.b  #$2c, d0
00814C  ori.b  #$60, d0
008150  ori.b  #$2, d1
008154  ori.b  #$0, d0
008158  ori.b  #$0, d0
00815C  ori.b  #$2c, d0
008160  ori.b  #$6c, d0
008164  ori.b  #$1, d1
008168  ori.b  #$0, d0
00816C  ori.b  #$0, d0
008170  ori.b  #$2c, d0
008174  ori.b  #$78, d0
008178  ori.b  #$2, d1
00817C  ori.b  #$0, d0
008180  ori.b  #$0, d0
008184  ori.b  #$2c, d0
008188  ori.b  #$84, d0
00818C  ori.b  #$2, d1
008190  ori.b  #$0, d0
008194  ori.b  #$0, d0
008198  ori.b  #$2c, d0
00819C  ori.b  #$90, d0
0081A0  ori.b  #$1, d1
0081A4  ori.b  #$0, d0
0081A8  ori.b  #$0, d0
0081AC  ori.b  #$2c, d0
0081B0  ori.b  #$9c, d0
0081B4  ori.b  #$2, d1
0081B8  ori.b  #$0, d0
0081BC  ori.b  #$0, d0
0081C0  ori.b  #$2c, d0
0081C4  ori.b  #$a8, d0
0081C8  ori.b  #$1, d1
0081CC  ori.b  #$0, d0
0081D0  ori.b  #$0, d0
0081D4  ori.b  #$2c, d0
0081D8  ori.b  #$b4, d0
0081DC  ori.b  #$1, d1
0081E0  ori.b  #$0, d0
0081E4  ori.b  #$0, d0
0081E8  ori.b  #$2c, d0
0081EC  ori.b  #$c0, d0
0081F0  ori.b  #$2, d1
0081F4  ori.b  #$0, d0
0081F8  ori.b  #$0, d0
0081FC  ori.b  #$2c, d0
008200  ori.b  #$cc, d0
008204  ori.b  #$1, d1
008208  ori.b  #$0, d0
00820C  ori.b  #$0, d0
008210  ori.b  #$2c, d0
008214  ori.b  #$d8, d0
008218  ori.b  #$2, d1
00821C  ori.b  #$0, d0
008220  ori.b  #$0, d0
008224  ori.b  #$2c, d0
008228  ori.b  #$e4, d0
00822C  ori.b  #$2, d1
008230  ori.b  #$0, d0
008234  ori.b  #$0, d0
008238  ori.b  #$2c, d0
00823C  ori.b  #$f0, d0
008240  ori.b  #$1, d1
008244  ori.b  #$0, d0
008248  ori.b  #$0, d0
00824C  ori.b  #$2c, d0
008250  ori.b  #$fc, d0
008254  ori.b  #$2, d1
008258  ori.b  #$0, d0
00825C  ori.b  #$0, d0
008260  ori.b  #$2c, d0
008264  ori.b  #$8, d0
008268  ori.b  #$1, d1
00826C  ori.b  #$0, d0
008270  ori.b  #$0, d0
008274  ori.b  #$2c, d0
008278  ori.b  #$14, d0
00827C  ori.b  #$2, d1
008280  ori.b  #$0, d0
008284  ori.b  #$0, d0
008288  ori.b  #$2c, d0
00828C  ori.b  #$20, d0
008290  ori.b  #$1, d1
008294  ori.b  #$0, d0
008298  ori.b  #$0, d0
00829C  ori.b  #$2c, d0
0082A0  ori.b  #$2c, d0
0082A4  ori.b  #$2, d1
0082A8  ori.b  #$0, d0
0082AC  ori.b  #$0, d0
0082B0  ori.b  #$2c, d0
0082B4  ori.b  #$38, d0
0082B8  ori.b  #$1, d1
0082BC  ori.b  #$0, d0
0082C0  ori.b  #$0, d0
0082C4  ori.b  #$2c, d0
0082C8  ori.b  #$44, d0
0082CC  ori.b  #$2, d1
0082D0  ori.b  #$0, d0
0082D4  ori.b  #$0, d0
0082D8  ori.b  #$2c, d0
0082DC  ori.b  #$50, d0
0082E0  ori.b  #$1, d1
0082E4  ori.b  #$0, d0
0082E8  ori.b  #$0, d0
0082EC  ori.b  #$2c, d0
0082F0  ori.b  #$5c, d0
0082F4  ori.b  #$2, d1
0082F8  ori.b  #$0, d0
0082FC  ori.b  #$0, d0
008300  ori.b  #$2c, d0
008304  ori.b  #$68, d0
008308  ori.b  #$1, d1
00830C  ori.b  #$0, d0
008310  ori.b  #$0, d0
008314  ori.b  #$ac, d5
008318  ori.b  #$dc, d5
00831C  ori.b  #$18, d5
008320  ori.b  #$e8, d5
008324  ori.b  #$ac, d5
008328  ori.b  #$e8, d5
00832C  ori.b  #$18, d5
008330  ori.b  #$8, d5
008334  ori.b  #$d8, d5
008338  ori.b  #$e8, d5
00833C  ori.b  #$d8, d5
008340  ori.b  #$8, d5
008344  ori.b  #$cc, d5
008348  ori.b  #$9c, d5
00834C  ori.b  #$d8, d5
008350  ori.b  #$9c, d5
008354  ori.b  #$cc, d5
008358  ori.b  #$dc, d5
00835C  ori.b  #$ac, d5
008360  ori.b  #$9c, d5
008364  ori.b  #$e8, d5
008368  ori.b  #$0, d5
00836C  ori.b  #$3c, d5
008370  ori.b  #$24, d5
008374  ori.b  #$e8, d5
008378  ori.b  #$24, d5
00837C  ori.b  #$3c, d5
008380  ori.b  #$2c, d5
008384  ori.b  #$14, d5
008388  ori.b  #$24, d5
00838C  ori.b  #$14, d5
008390  ori.b  #$2c, d5
008394  ori.b  #$f0, d5
008398  ori.b  #$d8, d5
00839C  ori.b  #$14, d5
0083A0  ori.b  #$d8, d5
0083A4  ori.b  #$f0, d5
0083A8  ori.b  #$0, d5
0083AC  ori.b  #$e8, d5
0083B0  ori.b  #$d8, d5
0083B4  ori.b  #$24, d5
0083B8  ori.b  #$54, d5
0083BC  ori.b  #$90, d5
0083C0  ori.b  #$60, d5
0083C4  ori.b  #$24, d5
0083C8  ori.b  #$60, d5
0083CC  ori.b  #$90, d5
0083D0  ori.b  #$80, d5
0083D4  ori.b  #$50, d5
0083D8  ori.b  #$60, d5
0083DC  ori.b  #$50, d5
0083E0  ori.b  #$80, d5
0083E4  ori.b  #$44, d5
0083E8  ori.b  #$14, d5
0083EC  ori.b  #$50, d5
0083F0  ori.b  #$14, d5
0083F4  ori.b  #$44, d5
0083F8  ori.b  #$54, d5
0083FC  ori.b  #$24, d5
008400  ori.b  #$14, d5
008404  ori.b  #$60, d5
008408  ori.b  #$78, d5
00840C  ori.b  #$c4, d5
008410  ori.b  #$ac, d5
008414  ori.b  #$60, d5
008418  ori.b  #$ac, d5
00841C  ori.b  #$c4, d5
008420  ori.b  #$b4, d5
008424  ori.b  #$9c, d5
008428  ori.b  #$ac, d5
00842C  ori.b  #$9c, d5
008430  ori.b  #$b4, d5
008434  ori.b  #$68, d5
008438  ori.b  #$50, d5
00843C  ori.b  #$9c, d5
008440  ori.b  #$50, d5
008444  ori.b  #$68, d5
008448  ori.b  #$78, d5
00844C  ori.b  #$60, d5
008450  ori.b  #$50, d5
008454  ori.b  #$9c, d5
008458  ori.b  #$c0, d5
00845C  ori.b  #$fc, d5
008460  ori.b  #$d8, d5
008464  ori.b  #$9c, d5
008468  ori.b  #$d8, d5
00846C  ori.b  #$fc, d5
008470  ori.b  #$38, d5
008474  ori.b  #$14, d5
008478  ori.b  #$d8, d5
00847C  ori.b  #$14, d5
008480  ori.b  #$38, d5
008484  ori.b  #$74, d5
008488  ori.b  #$50, d5
00848C  ori.b  #$14, d5
008490  ori.b  #$50, d5
008494  ori.b  #$74, d5
008498  ori.b  #$c0, d5
00849C  ori.b  #$9c, d5
0084A0  ori.b  #$50, d5
0084A4  ori.b  #$e8, d5
0084A8  ori.b  #$c, d5
0084AC  ori.b  #$d0, d5
0084B0  ori.b  #$ac, d5
0084B4  ori.b  #$e8, d5
0084B8  ori.b  #$24, d5
0084BC  ori.b  #$48, d5
0084C0  ori.b  #$c, d5
0084C4  ori.b  #$e8, d5
0084C8  ori.b  #$24, d5
0084CC  ori.b  #$60, d5
0084D0  ori.b  #$84, d5
0084D4  ori.b  #$48, d5
0084D8  ori.b  #$24, d5
0084DC  ori.b  #$60, d5
0084E0  ori.b  #$ac, d5
0084E4  ori.b  #$d0, d5
0084E8  ori.b  #$84, d5
0084EC  ori.b  #$60, d5
0084F0  ori.b  #$ac, d5
0084F4  ori.b  #$f4, d5
0084F8  ori.b  #$18, d5
0084FC  ori.b  #$dc, d5
008500  ori.b  #$b8, d5
008504  ori.b  #$f4, d5
008508  ori.b  #$e4, d5
00850C  ori.b  #$8, d5
008510  ori.b  #$18, d5
008514  ori.b  #$f4, d5
008518  ori.b  #$e4, d5
00851C  ori.b  #$a8, d5
008520  ori.b  #$cc, d5
008524  ori.b  #$8, d5
008528  ori.b  #$e4, d5
00852C  ori.b  #$a8, d5
008530  ori.b  #$b8, d5
008534  ori.b  #$dc, d5
008538  ori.b  #$cc, d5
00853C  ori.b  #$a8, d5
008540  ori.b  #$b8, d5
008544  ori.b  #$30, d5
008548  ori.b  #$3c, d5
00854C  ori.b  #$0, d5
008550  ori.b  #$f4, d5
008554  ori.b  #$30, d5
008558  ori.b  #$20, d5
00855C  ori.b  #$2c, d5
008560  ori.b  #$3c, d5
008564  ori.b  #$30, d5
008568  ori.b  #$20, d5
00856C  ori.b  #$e4, d5
008570  ori.b  #$f0, d5
008574  ori.b  #$2c, d5
008578  ori.b  #$20, d5
00857C  ori.b  #$e4, d5
008580  ori.b  #$f4, d5
008584  ori.b  #$0, d5
008588  ori.b  #$f0, d5
00858C  ori.b  #$e4, d5
008590  ori.b  #$f4, d5
008594  ori.b  #$6c, d5
008598  ori.b  #$90, d5
00859C  ori.b  #$54, d5
0085A0  ori.b  #$30, d5
0085A4  ori.b  #$6c, d5
0085A8  ori.b  #$5c, d5
0085AC  ori.b  #$80, d5
0085B0  ori.b  #$90, d5
0085B4  ori.b  #$6c, d5
0085B8  ori.b  #$5c, d5
0085BC  ori.b  #$20, d5
0085C0  ori.b  #$44, d5
0085C4  ori.b  #$80, d5
0085C8  ori.b  #$5c, d5
0085CC  ori.b  #$20, d5
0085D0  ori.b  #$30, d5
0085D4  ori.b  #$54, d5
0085D8  ori.b  #$44, d5
0085DC  ori.b  #$20, d5
0085E0  ori.b  #$30, d5
0085E4  ori.b  #$b8, d5
0085E8  ori.b  #$c4, d5
0085EC  ori.b  #$78, d5
0085F0  ori.b  #$6c, d5
0085F4  ori.b  #$b8, d5
0085F8  ori.b  #$a8, d5
0085FC  ori.b  #$b4, d5
008600  ori.b  #$c4, d5
008604  ori.b  #$b8, d5
008608  ori.b  #$a8, d5
00860C  ori.b  #$5c, d5
008610  ori.b  #$68, d5
008614  ori.b  #$b4, d5
008618  ori.b  #$a8, d5
00861C  ori.b  #$5c, d5
008620  ori.b  #$6c, d5
008624  ori.b  #$78, d5
008628  ori.b  #$68, d5
00862C  ori.b  #$5c, d5
008630  ori.b  #$6c, d5
008634  ori.b  #$e4, d5
008638  ori.b  #$fc, d5
00863C  ori.b  #$c0, d5
008640  ori.b  #$a8, d5
008644  ori.b  #$e4, d5
008648  ori.b  #$20, d5
00864C  ori.b  #$38, d5
008650  ori.b  #$fc, d5
008654  ori.b  #$e4, d5
008658  ori.b  #$20, d5
00865C  ori.b  #$5c, d5
008660  ori.b  #$74, d5
008664  ori.b  #$38, d5
008668  ori.b  #$20, d5
00866C  ori.b  #$5c, d5
008670  ori.b  #$a8, d5
008674  ori.b  #$c0, d5
008678  ori.b  #$74, d5
00867C  ori.b  #$5c, d5
008680  ori.b  #$a8, d5
008684  ori.b  #$b8, d5
008688  ori.b  #$d0, d5
00868C  ori.b  #$c, d5
008690  ori.b  #$f4, d5
008694  ori.b  #$b8, d5
008698  ori.b  #$f4, d5
00869C  ori.b  #$c, d5
0086A0  ori.b  #$48, d5
0086A4  ori.b  #$30, d5
0086A8  ori.b  #$f4, d5
0086AC  ori.b  #$30, d5
0086B0  ori.b  #$48, d5
0086B4  ori.b  #$84, d5
0086B8  ori.b  #$6c, d5
0086BC  ori.b  #$30, d5
0086C0  ori.b  #$6c, d5
0086C4  ori.b  #$84, d5
0086C8  ori.b  #$d0, d5
0086CC  ori.b  #$b8, d5
0086D0  ori.b  #$6c, d5
0086D4  ori.b  #$f0, d0
0086D8  ori.b  #$10, d0
0086DC  ori.b  #$4c, d0
0086E0  ori.b  #$b0, d0
0086E4  ori.b  #$5, d5
0086E8  ori.b  #$5, d5
0086EC  addi.b #$0, d0
0086F0  andi.b #$0, d0
0086F4  andi.b #$0, d0
0086F8  dc.w   $fe00
0086FA  andi.b #$0, d0
0086FE  dc.w   $fe00
008700  andi.b #$0, d0
008704  andi.b #$0, d0
008708  ori.b  #$0, d0
00870C  dc.w   $fa00
00870E  ori.b  #$4, d0
008712  ori.b  #$0, d4
008716  or.b   (a4), d4
008718  ori.b  #$14, d0
00871C  ori.b  #$3, d3
008720  ori.b  #$28, d0
008724  ori.b  #$28, d0
008728  ori.b  #$3, d3
00872C  ori.b  #$38, d0
008730  ori.b  #$38, d0
008734  ori.b  #$3, d3
008738  ori.b  #$48, d0
00873C  ori.b  #$48, d0
008740  ori.b  #$3, d3
008744  ori.b  #$58, d0
008748  ori.b  #$58, d0
00874C  ori.b  #$10, d0
008750  ori.b  #$0, d1
008754  ori.b  #$9c, d0
008758  ori.b  #$a0, d0
00875C  ori.b  #$1c, d0
008760  ori.b  #$0, d1
008764  ori.b  #$a0, d0
008768  ori.b  #$a4, d0
00876C  ori.b  #$28, d0
008770  ori.b  #$0, d1
008774  ori.b  #$a4, d0
008778  ori.b  #$a8, d0
00877C  ori.b  #$34, d0
008780  ori.b  #$0, d1
008784  ori.b  #$a8, d0
008788  ori.b  #$ac, d0
00878C  ori.b  #$40, d0
008790  ori.b  #$0, d1
008794  ori.b  #$ac, d0
008798  ori.b  #$b0, d0
00879C  ori.b  #$b0, d0
0087A0  ori.b  #$c4, d0
0087A4  ori.b  #$d8, d0
0087A8  ori.b  #$ec, d0
0087AC  ori.b  #$0, d0
0087B0  ori.b  #$2c, d0
0087B4  ori.b  #$10, d0
0087B8  ori.b  #$1, d1
0087BC  ori.b  #$0, d0
0087C0  ori.b  #$0, d0
0087C4  ori.b  #$2c, d0
0087C8  ori.b  #$1c, d0
0087CC  ori.b  #$2, d1
0087D0  ori.b  #$0, d0
0087D4  ori.b  #$0, d0
0087D8  ori.b  #$2c, d0
0087DC  ori.b  #$28, d0
0087E0  ori.b  #$3, d1
0087E4  ori.b  #$0, d0
0087E8  ori.b  #$0, d0
0087EC  ori.b  #$2c, d0
0087F0  ori.b  #$34, d0
0087F4  ori.b  #$2, d1
0087F8  ori.b  #$0, d0
0087FC  ori.b  #$0, d0
008800  ori.b  #$2c, d0
008804  ori.b  #$40, d0
008808  ori.b  #$3, d1
00880C  ori.b  #$0, d0
008810  ori.b  #$0, d0
008814  ori.b  #$b8, d5
008818  ori.b  #$c4, d5
00881C  ori.b  #$d0, d5
008820  ori.b  #$ac, d5
008824  ori.b  #$b8, d5
008828  ori.b  #$c4, d5
00882C  ori.b  #$dc, d5
008830  ori.b  #$d0, d5
008834  ori.b  #$c4, d5
008838  ori.b  #$b8, d5
00883C  ori.b  #$dc, d5
008840  ori.b  #$c4, d5
008844  ori.b  #$b8, d5
008848  ori.b  #$ac, d5
00884C  ori.b  #$dc, d5
008850  ori.b  #$b8, d5
008854  ori.b  #$ac, d5
008858  ori.b  #$d0, d5
00885C  ori.b  #$dc, d5
008860  ori.b  #$ac, d5
008864  ori.b  #$d0, d5
008868  ori.b  #$84, d0
00886C  ori.b  #$a4, d0
008870  ori.b  #$e0, d0
008874  ori.b  #$44, d0
008878  ori.b  #$5, d5
00887C  ori.b  #$5, d5
008880  andi.b #$0, -$45(a1, d0.w)
008886  ; data: 0x00, 0xbb
008888  ; data: 0x00, 0xbb
00888A  ; data: 0x00, 0xbb
00888C  ; data: 0xff, 0x45
00888E  ; data: 0x00, 0xbb
008890  ; data: 0xff, 0x45
008892  ; data: 0xff, 0x45
008894  ; data: 0x00, 0xbb
008896  ; data: 0xff, 0x45
008898  ; data: 0x00, 0xbb
00889A  ; data: 0x00, 0xbb
00889C  ori.b  #$0, d0
0088A0  ; data: 0xfd, 0xcf
0088A2  ori.b  #$4, d0
0088A6  ori.b  #$0, d4
0088AA  or.l   d4, $0(a0)
0088AE  or.l   d4, $3(a0)
0088B2  ori.b  #$0, d3
0088B6  ; data: 0x89, 0xbc
0088B8  ori.b  #$bc, d0
0088BC  ori.b  #$3, d3
0088C0  ori.b  #$cc, d0
0088C4  ori.b  #$cc, d0
0088C8  ori.b  #$3, d3
0088CC  ori.b  #$dc, d0
0088D0  ori.b  #$dc, d0
0088D4  ori.b  #$3, d3
0088D8  ori.b  #$ec, d0
0088DC  ori.b  #$ec, d0
0088E0  ori.b  #$a4, d0
0088E4  ori.b  #$0, d1
0088E8  ori.b  #$30, d0
0088EC  ori.b  #$34, d0
0088F0  ori.b  #$b0, d0
0088F4  ori.b  #$0, d1
0088F8  ori.b  #$34, d0
0088FC  ori.b  #$38, d0
008900  ori.b  #$bc, d0
008904  ori.b  #$0, d1
008908  ori.b  #$38, d0
00890C  ori.b  #$3c, d0
008910  ori.b  #$c8, d0
008914  ori.b  #$0, d1
008918  ori.b  #$3c, d0
00891C  ori.b  #$40, d0
008920  ori.b  #$d4, d0
008924  ori.b  #$0, d1
008928  ori.b  #$40, d0
00892C  ori.b  #$44, d0
008930  ori.b  #$44, d0
008934  ori.b  #$58, d0
008938  ori.b  #$6c, d0
00893C  ori.b  #$80, d0
008940  ori.b  #$94, d0
008944  ori.b  #$2c, d0
008948  ori.b  #$a4, d0
00894C  ori.b  #$1, d1
008950  ori.b  #$0, d0
008954  ori.b  #$0, d0
008958  ori.b  #$2c, d0
00895C  ori.b  #$b0, d0
008960  ori.b  #$2, d1
008964  ori.b  #$0, d0
008968  ori.b  #$0, d0
00896C  ori.b  #$2c, d0
008970  ori.b  #$bc, d0
008974  ori.b  #$3, d1
008978  ori.b  #$0, d0
00897C  ori.b  #$0, d0
008980  ori.b  #$2c, d0
008984  ori.b  #$c8, d0
008988  ori.b  #$2, d1
00898C  ori.b  #$0, d0
008990  ori.b  #$0, d0
008994  ori.b  #$2c, d0
008998  ori.b  #$d4, d0
00899C  ori.b  #$3, d1
0089A0  ori.b  #$0, d0
0089A4  ori.b  #$0, d0
0089A8  ori.b  #$b8, d5
0089AC  ori.b  #$c4, d5
0089B0  ori.b  #$d0, d5
0089B4  ori.b  #$ac, d5
0089B8  ori.b  #$b8, d5
0089BC  ori.b  #$c4, d5
0089C0  ori.b  #$dc, d5
0089C4  ori.b  #$d0, d5
0089C8  ori.b  #$c4, d5
0089CC  ori.b  #$b8, d5
0089D0  ori.b  #$dc, d5
0089D4  ori.b  #$c4, d5
0089D8  ori.b  #$b8, d5
0089DC  ori.b  #$ac, d5
0089E0  ori.b  #$dc, d5
0089E4  ori.b  #$b8, d5
0089E8  ori.b  #$ac, d5
0089EC  ori.b  #$d0, d5
0089F0  ori.b  #$dc, d5
0089F4  ori.b  #$ac, d5
0089F8  ori.b  #$d0, d5
0089FC  ori.b  #$18, d0
008A00  ori.b  #$3c, d0
008A04  ori.b  #$6c, d0
008A08  ori.b  #$cc, d0
008A0C  ori.b  #$4, d6
008A10  ori.b  #$8, d4
008A14  btst.l d2, d0
008A16  ori.b  #$0, d0
008A1A  ori.b  #$0, d0
008A1E  btst.l d1, d0
008A20  ori.b  #$0, d0
008A24  btst.l d0, d0
008A26  ori.b  #$0, d0
008A2A  ori.b  #$0, d0
008A2E  subi.b #$0, d0
008A32  ori.b  #$0, d0
008A36  ; data: 0xfd, 0x00
008A38  ori.b  #$0, d0
008A3C  ori.b  #$3, d3
008A40  ori.b  #$6c, d0
008A44  ori.b  #$6c, d0
008A48  ori.b  #$3, d3
008A4C  ori.b  #$7c, d0
008A50  ori.b  #$7c, d0
008A54  ori.b  #$3, d3
008A58  ori.b  #$8c, d0
008A5C  ori.b  #$8c, d0
008A60  ori.b  #$3, d3
008A64  ori.b  #$9c, d0
008A68  ori.b  #$9c, d0
008A6C  ori.b  #$3c, d0
008A70  ori.b  #$1, d1
008A74  ori.b  #$ac, d0
008A78  ori.b  #$b0, d0
008A7C  ori.b  #$48, d0
008A80  ori.b  #$1, d1
008A84  ori.b  #$b4, d0
008A88  ori.b  #$b8, d0
008A8C  ori.b  #$54, d0
008A90  ori.b  #$1, d1
008A94  ori.b  #$bc, d0
008A98  ori.b  #$c0, d0
008A9C  ori.b  #$60, d0
008AA0  ori.b  #$1, d1
008AA4  ori.b  #$c4, d0
008AA8  ori.b  #$c8, d0
008AAC  ori.b  #$8, d0
008AB0  ori.b  #$58, d0
008AB4  ori.b  #$1c, d0
008AB8  ori.b  #$e0, d0
008ABC  ori.b  #$30, d0
008AC0  ori.b  #$cc, d0
008AC4  ori.b  #$f4, d0
008AC8  ori.b  #$44, d0
008ACC  ori.b  #$2c, d0
008AD0  ori.b  #$54, d0
008AD4  ; data: 0x00, 0xff
008AD6  ori.b  #$0, d5
008ADA  ori.b  #$0, d0
008ADE  ori.b  #$0, d0
008AE2  move.w $0(a4), -(a0)
008AE6  ; data: 0x8a, 0x48
008AE8  ; data: 0x00, 0xff
008AEA  ori.b  #$0, d4
008AEE  ori.b  #$0, d0
008AF2  ori.b  #$0, d0
008AF6  move.w $0(a4), -(a0)
008AFA  or.w   -(a0), d5
008AFC  ori.b  #$4, d1
008B00  ori.b  #$0, d0
008B04  ori.b  #$0, d0
008B08  ori.b  #$2c, d0
008B0C  ori.b  #$3c, d0
008B10  ori.b  #$5, d1
008B14  ori.b  #$0, d0
008B18  ori.b  #$0, d0
008B1C  ori.b  #$2c, d0
008B20  ori.b  #$48, d0
008B24  ori.b  #$4, d1
008B28  ori.b  #$0, d0
008B2C  ori.b  #$0, d0
008B30  ori.b  #$2c, d0
008B34  ori.b  #$54, d0
008B38  ori.b  #$5, d1
008B3C  ori.b  #$0, d0
008B40  ori.b  #$0, d0
008B44  ori.b  #$2c, d0
008B48  ori.b  #$60, d0
008B4C  ; data: 0x00, 0xff
008B4E  ori.b  #$0, d4
008B52  ori.b  #$0, d0
008B56  ori.b  #$0, d0
008B5A  move.w $0(a4), -(a0)
008B5E  or.b   #$ff, d5
008B62  ori.b  #$0, d5
008B66  ori.b  #$0, d0
008B6A  ori.b  #$5, d0
008B6E  chk.w  $5.w, d1
008B72  ; data: 0x43, 0xc4
008B74  ori.b  #$ac, d5
008B78  ori.b  #$b8, d5
008B7C  ori.b  #$c4, d5
008B80  ori.b  #$d0, d5
008B84  ori.b  #$ac, d5
008B88  ori.b  #$c4, d5
008B8C  ori.b  #$d0, d5
008B90  ori.b  #$dc, d5
008B94  ori.b  #$ac, d5
008B98  ori.b  #$d0, d5
008B9C  ori.b  #$dc, d5
008BA0  ori.b  #$e8, d5
008BA4  ori.b  #$ac, d5
008BA8  ori.b  #$dc, d5
008BAC  ori.b  #$c8, d0
008BB0  ori.b  #$54, d0
008BB4  ori.b  #$20, d0
008BB8  ori.b  #$24, d0
008BBC  ori.b  #$11, (a7)
008BC0  ori.b  #$1d, (a1)
008BC4  andi.b #$0, -(a6)
008BC8  ori.b  #$0, d0
008BCC  andi.b #$9c, -(a6)
008BD0  ori.b  #$2c, d0
008BD4  ; data: 0xff, 0xce
008BD6  ori.w  #$12c, -(a4)
008BDA  ori.b  #$64, $64(a2, d0.w)
008BE2  ori.b  #$2c, d0
008BE6  ori.b  #$9c, $ffce(a2, d0.w)
008BEE  ; data: 0xff, 0x9c
008BF0  btst.l d0, -$64(a4)
008BF4  ori.b  #$d4, d0
008BF8  ; data: 0xff, 0xce
008BFA  ori.w  #$fed4, -(a4)
008BFE  ori.b  #$64, -$2c(a2, a7.l)
008C04  ori.w  #$0, -(a4)
008C08  dc.w   $fed4
008C0A  ori.b  #$9c, -$2c(a2, a7.l)
008C10  ; data: 0xff, 0xce
008C12  ; data: 0xff, 0x9c
008C14  dc.w   $fed4
008C16  ; data: 0xff, 0x9c
008C18  ori.b  #$ce, d0
008C1C  ; data: 0xff, 0x06
008C1E  ori.b  #$d4, d0
008C22  ori.b  #$64, d0
008C26  ; data: 0xff, 0xce
008C28  ori.b  #$fa, d0
008C2C  dc.w   $fed4
008C2E  ori.w  #$0, -(a4)
008C32  ; data: 0xff, 0xce
008C34  dc.w   $fa
008C36  ori.b  #$d4, d0
008C3A  ori.b  #$9c, d0
008C3E  ; data: 0xff, 0xce
008C40  ori.b  #$6, d0
008C44  dc.w   $fed4
008C46  ori.b  #$64, d0
008C4A  dc.w   $fed4
008C4C  ori.b  #$9c, d0
008C50  dc.w   $fed4
008C52  ori.b  #$4, d0
008C56  ori.b  #$0, d4
008C5A  sub.w  d0, $0(a0)
008C5E  sub.w  d0, $4(a0)
008C62  ori.b  #$0, d4
008C66  ; data: 0x91, 0x7c
008C68  ori.b  #$7c, d0
008C6C  ori.b  #$4, d4
008C70  ori.b  #$90, d0
008C74  ori.b  #$90, d0
008C78  ori.b  #$4, d4
008C7C  ori.b  #$a4, d0
008C80  ori.b  #$a4, d0
008C84  ori.b  #$4, d4
008C88  ori.b  #$b8, d0
008C8C  ori.b  #$b8, d0
008C90  ori.b  #$4, d4
008C94  ori.b  #$cc, d0
008C98  ori.b  #$cc, d0
008C9C  ori.b  #$3, d3
008CA0  ori.b  #$e0, d0
008CA4  ori.b  #$e0, d0
008CA8  ori.b  #$3, d3
008CAC  ori.b  #$f0, d0
008CB0  ori.b  #$f0, d0
008CB4  ori.b  #$3, d3
008CB8  ori.b  #$0, d0
008CBC  ori.b  #$0, d0
008CC0  ori.b  #$3, d3
008CC4  ori.b  #$10, d0
008CC8  ori.b  #$10, d0
008CCC  ori.b  #$3, d3
008CD0  ori.b  #$20, d0
008CD4  ori.b  #$20, d0
008CD8  ori.b  #$3, d3
008CDC  ori.b  #$30, d0
008CE0  ori.b  #$30, d0
008CE4  ori.b  #$6, d6
008CE8  ori.b  #$40, d0
008CEC  ori.b  #$40, d0
008CF0  ori.b  #$3, d3
008CF4  ori.b  #$5c, d0
008CF8  ori.b  #$5c, d0
008CFC  ori.b  #$3, d3
008D00  ori.b  #$6c, d0
008D04  ori.b  #$6c, d0
008D08  ori.b  #$3, d3
008D0C  ori.b  #$7c, d0
008D10  ori.b  #$7c, d0
008D14  ori.b  #$3, d3
008D18  ori.b  #$8c, d0
008D1C  ori.b  #$8c, d0
008D20  ori.b  #$54, d0
008D24  ori.b  #$0, d1
008D28  ori.b  #$30, d0
008D2C  ori.b  #$34, d0
008D30  ori.b  #$60, d0
008D34  ori.b  #$4, d5
008D38  ori.b  #$34, d0
008D3C  ori.b  #$48, d0
008D40  ori.b  #$6c, d0
008D44  ori.b  #$0, d1
008D48  ori.b  #$58, d0
008D4C  ori.b  #$5c, d0
008D50  ori.b  #$78, d0
008D54  ori.b  #$0, d1
008D58  ori.b  #$5c, d0
008D5C  ori.b  #$60, d0
008D60  ori.b  #$84, d0
008D64  ori.b  #$4, d5
008D68  ori.b  #$60, d0
008D6C  ori.b  #$74, d0
008D70  ori.b  #$90, d0
008D74  ori.b  #$0, d1
008D78  ori.b  #$84, d0
008D7C  ori.b  #$88, d0
008D80  ori.b  #$9c, d0
008D84  ori.b  #$0, d1
008D88  ori.b  #$88, d0
008D8C  ori.b  #$8c, d0
008D90  ori.b  #$a8, d0
008D94  ori.b  #$0, d1
008D98  ori.b  #$8c, d0
008D9C  ori.b  #$90, d0
008DA0  ori.b  #$b4, d0
008DA4  ori.b  #$0, d1
008DA8  ori.b  #$90, d0
008DAC  ori.b  #$94, d0
008DB0  ori.b  #$c0, d0
008DB4  ori.b  #$0, d1
008DB8  ori.b  #$94, d0
008DBC  ori.b  #$98, d0
008DC0  ori.b  #$cc, d0
008DC4  ori.b  #$0, d1
008DC8  ori.b  #$98, d0
008DCC  ori.b  #$9c, d0
008DD0  ori.b  #$d8, d0
008DD4  ori.b  #$0, d1
008DD8  ori.b  #$9c, d0
008DDC  ori.b  #$a0, d0
008DE0  ori.b  #$e4, d0
008DE4  ori.b  #$0, d1
008DE8  ori.b  #$a0, d0
008DEC  ori.b  #$a4, d0
008DF0  ori.b  #$f0, d0
008DF4  ori.b  #$2, d2
008DF8  ori.b  #$a4, d0
008DFC  ori.b  #$ac, d0
008E00  ori.b  #$fc, d0
008E04  ori.b  #$6, d6
008E08  ori.b  #$b4, d0
008E0C  ori.b  #$cc, d0
008E10  ori.b  #$8, d0
008E14  ori.b  #$2, d2
008E18  ori.b  #$e4, d0
008E1C  ori.b  #$ec, d0
008E20  ori.b  #$14, d0
008E24  ori.b  #$6, d6
008E28  ori.b  #$f4, d0
008E2C  ori.b  #$c, d0
008E30  ori.b  #$c4, d0
008E34  ori.b  #$d8, d0
008E38  ori.b  #$38, d0
008E3C  ori.b  #$38, d0
008E40  ori.b  #$24, d0
008E44  ori.b  #$24, d0
008E48  ori.b  #$2c, d0
008E4C  ori.b  #$2c, d0
008E50  ori.b  #$18, d0
008E54  ori.b  #$18, d0
008E58  ori.b  #$ec, d0
008E5C  ori.b  #$0, d0
008E60  ori.b  #$14, d0
008E64  ori.b  #$60, d0
008E68  ori.b  #$60, d0
008E6C  ori.b  #$4c, d0
008E70  ori.b  #$4c, d0
008E74  ori.b  #$54, d0
008E78  ori.b  #$54, d0
008E7C  ori.b  #$40, d0
008E80  ori.b  #$40, d0
008E84  ori.b  #$28, d0
008E88  ori.b  #$3c, d0
008E8C  ori.b  #$50, d0
008E90  ori.b  #$64, d0
008E94  ori.b  #$78, d0
008E98  ori.b  #$8c, d0
008E9C  ori.b  #$a0, d0
008EA0  ori.b  #$b4, d0
008EA4  ori.b  #$c8, d0
008EA8  ori.b  #$74, d0
008EAC  ori.b  #$dc, d0
008EB0  ori.b  #$88, d0
008EB4  ori.b  #$18, d0
008EB8  ori.b  #$24, d0
008EBC  ori.b  #$4, d0
008EC0  ori.b  #$4, d0
008EC4  ori.b  #$f0, d0
008EC8  ori.b  #$f0, d0
008ECC  ori.b  #$b0, d0
008ED0  ori.b  #$b0, d0
008ED4  ori.b  #$9c, d0
008ED8  ori.b  #$9c, d0
008EDC  ori.b  #$2c, d0
008EE0  ori.b  #$38, d0
008EE4  ori.b  #$f0, d0
008EE8  ori.b  #$9c, d0
008EEC  ori.b  #$4, d0
008EF0  ori.b  #$b0, d0
008EF4  ori.b  #$40, d0
008EF8  ori.b  #$4c, d0
008EFC  ori.b  #$dc, d0
008F00  ori.b  #$dc, d0
008F04  ori.b  #$c8, d0
008F08  ori.b  #$c8, d0
008F0C  ori.b  #$88, d0
008F10  ori.b  #$88, d0
008F14  ori.b  #$74, d0
008F18  ori.b  #$74, d0
008F1C  ori.b  #$54, d0
008F20  ori.b  #$60, d0
008F24  ori.b  #$2c, d0
008F28  ori.b  #$fc, d0
008F2C  ori.b  #$2, d1
008F30  ori.b  #$0, d0
008F34  ori.b  #$0, d0
008F38  ori.b  #$2c, d0
008F3C  ori.b  #$fc, d0
008F40  ; data: 0x00, 0xff
008F42  ori.b  #$0, d2
008F46  ori.b  #$0, d0
008F4A  ori.b  #$0, d0
008F4E  move.w $0(a4), -(a0)
008F52  or.b   d6, (a4)
008F54  ori.b  #$2, d1
008F58  ori.b  #$0, d0
008F5C  ori.b  #$0, d0
008F60  ori.b  #$2c, d0
008F64  ori.b  #$14, d0
008F68  ; data: 0x00, 0xff
008F6A  ori.b  #$0, d2
008F6E  ori.b  #$0, d0
008F72  ori.b  #$0, d0
008F76  move.w $0(a4), -(a0)
008F7A  divu.w $1(a0, d0.w), d6
008F7E  ori.b  #$0, d2
008F82  ori.b  #$0, d0
008F86  ori.b  #$0, d0
008F8A  move.w $0(a4), -(a0)
008F8E  divu.w -$1(a0, d0.w), d6
008F92  ori.b  #$0, d2
008F96  ori.b  #$0, d0
008F9A  ori.b  #$0, d0
008F9E  move.w $0(a4), -(a0)
008FA2  sbcd   -(a0), -(a6), #$1
008FA6  ori.b  #$0, d2
008FAA  ori.b  #$0, d0
008FAE  ori.b  #$0, d0
008FB2  move.w $0(a4), -(a0)
008FB6  sbcd   -(a0), -(a6), #$ff
008FBA  ori.b  #$0, d2
008FBE  ori.b  #$0, d0
008FC2  ori.b  #$0, d0
008FC6  move.w $0(a4), -(a0)
008FCA  or.w   (a4), d6
008FCC  ori.b  #$4, d1
008FD0  ori.b  #$0, d0
008FD4  ori.b  #$0, d0
008FD8  ori.b  #$2c, d0
008FDC  ori.b  #$60, d0
008FE0  ori.b  #$5, d1
008FE4  ori.b  #$0, d0
008FE8  ori.b  #$0, d0
008FEC  ori.b  #$2c, d0
008FF0  ori.b  #$6c, d0
008FF4  ori.b  #$4, d1
008FF8  ori.b  #$0, d0
008FFC  ori.b  #$0, d0
009000  ori.b  #$2c, d0
009004  ori.b  #$78, d0
009008  ori.b  #$5, d1
00900C  ori.b  #$0, d0
009010  ori.b  #$0, d0
009014  ori.b  #$2c, d0
009018  ori.b  #$84, d0
00901C  ori.b  #$4, d1
009020  ori.b  #$0, d0
009024  ori.b  #$0, d0
009028  ori.b  #$2c, d0
00902C  ori.b  #$90, d0
009030  ori.b  #$5, d1
009034  ori.b  #$0, d0
009038  ori.b  #$0, d0
00903C  ori.b  #$2c, d0
009040  ori.b  #$9c, d0
009044  ori.b  #$5, d1
009048  ori.b  #$0, d0
00904C  ori.b  #$0, d0
009050  ori.b  #$2c, d0
009054  ori.b  #$a8, d0
009058  ori.b  #$4, d1
00905C  ori.b  #$0, d0
009060  ori.b  #$0, d0
009064  ori.b  #$2c, d0
009068  ori.b  #$b4, d0
00906C  ori.b  #$5, d1
009070  ori.b  #$0, d0
009074  ori.b  #$0, d0
009078  ori.b  #$2c, d0
00907C  ori.b  #$c0, d0
009080  ori.b  #$4, d1
009084  ori.b  #$0, d0
009088  ori.b  #$0, d0
00908C  ori.b  #$2c, d0
009090  ori.b  #$cc, d0
009094  ori.b  #$5, d1
009098  ori.b  #$0, d0
00909C  ori.b  #$0, d0
0090A0  ori.b  #$2c, d0
0090A4  ori.b  #$d8, d0
0090A8  ori.b  #$4, d1
0090AC  ori.b  #$0, d0
0090B0  ori.b  #$0, d0
0090B4  ori.b  #$2c, d0
0090B8  ori.b  #$e4, d0
0090BC  ori.b  #$1, d1
0090C0  ori.b  #$0, d0
0090C4  ori.b  #$0, d0
0090C8  ori.b  #$2c, d0
0090CC  ori.b  #$f0, d0
0090D0  ori.b  #$2, d1
0090D4  ori.b  #$0, d0
0090D8  ori.b  #$0, d0
0090DC  ori.b  #$2c, d0
0090E0  ori.b  #$f0, d0
0090E4  ; data: 0x00, 0xff
0090E6  ori.b  #$0, d2
0090EA  ori.b  #$0, d0
0090EE  ori.b  #$0, d0
0090F2  move.w $0(a4), -(a0)
0090F6  sbcd   -(a0), -(a6), #$1
0090FA  ori.b  #$0, d2
0090FE  ori.b  #$0, d0
009102  ori.b  #$0, d0
009106  move.w $0(a4), -(a0)
00910A  sbcd   -(a0), -(a6), #$ff
00910E  ori.b  #$0, d2
009112  ori.b  #$0, d0
009116  ori.b  #$0, d0
00911A  move.w $0(a4), -(a0)
00911E  divu.w #$1, d6
009122  ori.b  #$0, d2
009126  ori.b  #$0, d0
00912A  ori.b  #$0, d0
00912E  move.w $0(a4), -(a0)
009132  divu.w #$ff, d6
009136  ori.b  #$0, d2
00913A  ori.b  #$0, d0
00913E  ori.b  #$0, d0
009142  move.w $0(a4), -(a0)
009146  or.b   d6, (a4)
009148  ori.b  #$2, d1
00914C  ori.b  #$0, d0
009150  ori.b  #$0, d0
009154  ori.b  #$2c, d0
009158  ori.b  #$14, d0
00915C  ; data: 0x00, 0xff
00915E  ori.b  #$0, d2
009162  ori.b  #$0, d0
009166  ori.b  #$5, d0
00916A  chk.w  $5.w, d1
00916E  neg.b  d0
009170  ori.b  #$c, d5
009174  ori.b  #$c4, d5
009178  ori.b  #$b8, d5
00917C  ori.b  #$c4, d5
009180  ori.b  #$c, d5
009184  ori.b  #$18, d5
009188  ori.b  #$d0, d5
00918C  ori.b  #$c4, d5
009190  ori.b  #$d0, d5
009194  ori.b  #$18, d5
009198  ori.b  #$24, d5
00919C  ori.b  #$dc, d5
0091A0  ori.b  #$d0, d5
0091A4  ori.b  #$dc, d5
0091A8  ori.b  #$24, d5
0091AC  ori.b  #$30, d5
0091B0  ori.b  #$e8, d5
0091B4  ori.b  #$dc, d5
0091B8  ori.b  #$e8, d5
0091BC  ori.b  #$30, d5
0091C0  ori.b  #$3c, d5
0091C4  ori.b  #$f4, d5
0091C8  ori.b  #$e8, d5
0091CC  ori.b  #$f4, d5
0091D0  ori.b  #$3c, d5
0091D4  ori.b  #$0, d5
0091D8  ori.b  #$b8, d5
0091DC  ori.b  #$f4, d5
0091E0  ori.b  #$b8, d5
0091E4  ori.b  #$c4, d5
0091E8  ori.b  #$ac, d5
0091EC  ori.b  #$b8, d5
0091F0  ori.b  #$c4, d5
0091F4  ori.b  #$d0, d5
0091F8  ori.b  #$ac, d5
0091FC  ori.b  #$c4, d5
009200  ori.b  #$d0, d5
009204  ori.b  #$dc, d5
009208  ori.b  #$ac, d5
00920C  ori.b  #$d0, d5
009210  ori.b  #$dc, d5
009214  ori.b  #$e8, d5
009218  ori.b  #$ac, d5
00921C  ori.b  #$dc, d5
009220  ori.b  #$e8, d5
009224  ori.b  #$f4, d5
009228  ori.b  #$ac, d5
00922C  ori.b  #$e8, d5
009230  ori.b  #$f4, d5
009234  ori.b  #$b8, d5
009238  ori.b  #$ac, d5
00923C  ori.b  #$f4, d5
009240  ori.b  #$3c, d5
009244  ori.b  #$30, d5
009248  ori.b  #$24, d5
00924C  ori.b  #$18, d5
009250  ori.b  #$c, d5
009254  ori.b  #$0, d5
009258  ori.b  #$3c, d5
00925C  ori.b  #$48, d5
009260  ori.b  #$0, d5
009264  ori.b  #$54, d5
009268  ori.b  #$48, d5
00926C  ori.b  #$6c, d5
009270  ori.b  #$60, d5
009274  ori.b  #$a8, d5
009278  ori.b  #$6c, d5
00927C  ori.b  #$84, d5
009280  ori.b  #$24, d5
009284  ori.b  #$78, d5
009288  ori.b  #$84, d5
00928C  ori.b  #$90, d5
009290  ori.b  #$b4, d5
009294  ori.b  #$9c, d5
009298  ori.b  #$90, d5
00929C  ori.b  #$b8, d0
0092A0  ori.b  #$e8, d0
0092A4  ori.b  #$24, d0
0092A8  ori.b  #$c4, d0
0092AC  ; data: 0x00, 0x08
0092AE  ori.b  #$5, d5
0092B2  ; data: 0x00, 0x0a
0092B4  bchg.b d1, (a6, d0.w)
0092B8  andi.b #$0, d0
0092BC  andi.b #$0, d0
0092C0  dc.w   $fe00
0092C2  andi.b #$0, d0
0092C6  dc.w   $fe00
0092C8  andi.b #$0, d0
0092CC  andi.b #$0, d0
0092D0  andi.b #$0, d0
0092D4  dc.w   $fe00
0092D6  andi.b #$0, d0
0092DA  dc.w   $fe00
0092DC  dc.w   $fe00
0092DE  dc.w   $fe00
0092E0  dc.w   $fe00
0092E2  dc.w   $fe00
0092E4  andi.b #$0, d0
0092E8  ori.b  #$4, d4
0092EC  ori.b  #$8c, d0
0092F0  ori.b  #$8c, d0
0092F4  ori.b  #$4, d4
0092F8  ori.b  #$a0, d0
0092FC  ori.b  #$a0, d0
009300  ori.b  #$4, d4
009304  ori.b  #$b4, d0
009308  ori.b  #$b4, d0
00930C  ori.b  #$4, d4
009310  ori.b  #$c8, d0
009314  ori.b  #$c8, d0
009318  ori.b  #$4, d4
00931C  ori.b  #$dc, d0
009320  ori.b  #$dc, d0
009324  ori.b  #$e8, d0
009328  ori.b  #$1, d1
00932C  ori.b  #$74, d0
009330  ori.b  #$78, d0
009334  ori.b  #$f4, d0
009338  ori.b  #$1, d1
00933C  ori.b  #$7c, d0
009340  ori.b  #$80, d0
009344  ori.b  #$0, d0
009348  ori.b  #$1, d1
00934C  ori.b  #$84, d0
009350  ori.b  #$88, d0
009354  ori.b  #$c, d0
009358  ; data: 0x00, 0x0b
00935A  ori.b  #$0, d1
00935E  subx.l -(a4), -(a1)
009360  ori.b  #$b8, d0
009364  ori.b  #$18, d0
009368  ori.b  #$1, d1
00936C  ori.b  #$bc, d0
009370  ori.b  #$c0, d0
009374  ori.b  #$28, d0
009378  ori.b  #$14, d0
00937C  ori.b  #$3c, d0
009380  ori.b  #$0, d0
009384  ori.b  #$50, d0
009388  ori.b  #$ec, d0
00938C  ori.b  #$78, d0
009390  ori.b  #$14, d0
009394  ori.b  #$14, d0
009398  ori.b  #$0, d0
00939C  ori.b  #$0, d0
0093A0  ori.b  #$ec, d0
0093A4  ori.b  #$ec, d0
0093A8  ori.b  #$d8, d0
0093AC  ori.b  #$d8, d0
0093B0  ori.b  #$c4, d0
0093B4  ori.b  #$c4, d0
0093B8  ori.b  #$c4, d0
0093BC  ori.b  #$64, d0
0093C0  ori.b  #$d8, d0
0093C4  ori.b  #$2c, d0
0093C8  ori.b  #$c, d0
0093CC  ; data: 0x00, 0xff
0093CE  ori.b  #$0, d4
0093D2  ori.b  #$0, d0
0093D6  ori.b  #$0, d0
0093DA  move.w $0(a4), -(a0)
0093DE  sub.b  d1, (a0)+
0093E0  ; data: 0x00, 0xff
0093E2  ori.b  #$0, d5
0093E6  ori.b  #$0, d0
0093EA  ori.b  #$0, d0
0093EE  move.w $0(a4), -(a0)
0093F2  subx.b d0, d1
0093F4  ; data: 0x00, 0xff
0093F6  ori.b  #$0, d5
0093FA  ori.b  #$0, d0
0093FE  ori.b  #$0, d0
009402  move.w $0(a4), -(a0)
009406  suba.w -$1(a4, d0.w), a1
00940A  ori.b  #$0, d0
00940E  ori.b  #$0, d0
009412  ori.b  #$0, d0
009416  move.w $0(a4), -(a0)
00941A  suba.w $ff(a0), a1
00941E  ori.b  #$0, d0
009422  ori.b  #$0, d0
009426  ori.b  #$0, d0
00942A  move.w $0(a4), -(a0)
00942E  suba.w $1(a0), a1
009432  ori.b  #$0, d0
009436  ori.b  #$0, d0
00943A  ori.b  #$0, d0
00943E  move.w $0(a4), -(a0)
009442  suba.w $1(a4, d0.w), a1
009446  ori.b  #$0, d0
00944A  ori.b  #$0, d0
00944E  ori.b  #$0, d0
009452  move.w $0(a4), -(a0)
009456  subx.b d0, d1
009458  ori.b  #$5, d1
00945C  ori.b  #$0, d0
009460  ori.b  #$0, d0
009464  ori.b  #$2c, d0
009468  ori.b  #$18, d0
00946C  ori.b  #$5, d1
009470  ori.b  #$0, d0
009474  ori.b  #$0, d0
009478  ori.b  #$2c, d0
00947C  ori.b  #$c, d0
009480  ori.b  #$4, d1
009484  ori.b  #$0, d0
009488  ori.b  #$0, d0
00948C  ori.b  #$b8, d5
009490  ori.b  #$c4, d5
009494  ori.b  #$d0, d5
009498  ori.b  #$ac, d5
00949C  ori.b  #$b8, d5
0094A0  ori.b  #$0, d5
0094A4  ori.b  #$f4, d5
0094A8  ori.b  #$e8, d5
0094AC  ori.b  #$dc, d5
0094B0  ori.b  #$0, d5
0094B4  ori.b  #$ac, d5
0094B8  ori.b  #$d0, d5
0094BC  ori.b  #$0, d5
0094C0  ori.b  #$dc, d5
0094C4  ori.b  #$ac, d5
0094C8  ori.b  #$e8, d5
0094CC  ori.b  #$b8, d5
0094D0  ori.b  #$ac, d5
0094D4  ori.b  #$dc, d5
0094D8  ori.b  #$e8, d5
0094DC  ori.b  #$e8, d5
0094E0  ori.b  #$f4, d5
0094E4  ori.b  #$c4, d5
0094E8  ori.b  #$b8, d5
0094EC  ori.b  #$e8, d5
0094F0  ori.b  #$c, d0
0094F4  ori.b  #$78, d0
0094F8  ori.b  #$e4, d0
0094FC  ori.b  #$d0, d0
009500  ori.b  #$9, (a2)
009504  ; data: 0x00, 0x09
009506  ; data: 0x00, 0x0f
009508  bset.b d3, (a7)+
00950A  ori.b  #$24, d0
00950E  bset.b d0, -$1e(a4, d0.w)
009512  dc.w   $fc18
009514  dc.w   $fe0c
009516  ; data: 0x02, 0xee
009518  dc.w   $fe0c
00951A  ; data: 0xff, 0x06
00951C  bset.b d0, $ff0601f4(invalid.w)
009524  bset.b d1, -$1f4(a0)
009528  ; data: 0x02, 0xee
00952A  bset.b d2, (a4)+
00952C  bset.b d0, -$1e(a4, d0.w)
009530  dc.w   $fe0c
009532  ; data: 0xff, 0x06
009534  ; data: 0x04, 0xe2
009536  bset.b d0, ([a4], a7.l * 8, $4e2)
00953C  ori.b  #$fa, d0
009540  ; data: 0x06, 0xd6
009542  dc.w   $fa24
009544  bset.b d0, ([a4], a7.l * 2, $fc18)
00954A  dc.w   $fe0c
00954C  dc.w   $fd12
00954E  dc.w   $fe0c
009550  ; data: 0xff, 0x06
009552  dc.w   $fe0c
009554  bset.b d0, ([a4], a7.l * 8, $fe0c)
00955A  bset.b d1, -$1f4(a0)
00955E  dc.w   $fd12
009560  bset.b d2, (a4)+
009562  bset.b d0, ([a4], a7.l * 2, $fe0c)
009568  ; data: 0xff, 0x06
00956A  ; data: 0xfb, 0x1e
00956C  bset.b d0, ([a4], a7.l * 8, $fb1e)
009572  ori.b  #$fa, d0
009576  dc.w   $fc18
009578  ; data: 0x00, 0x08
00957A  ; data: 0x00, 0x08
00957C  ori.b  #$fc, d0
009580  ori.b  #$fc, d0
009584  ori.b  #$6, d6
009588  ori.b  #$20, d0
00958C  ori.b  #$20, d0
009590  ori.b  #$6, d6
009594  ori.b  #$3c, d0
009598  ori.b  #$3c, d0
00959C  ori.b  #$3, d3
0095A0  ori.b  #$58, d0
0095A4  ori.b  #$58, d0
0095A8  ori.b  #$3, d3
0095AC  ori.b  #$68, d0
0095B0  ori.b  #$68, d0
0095B4  ori.b  #$4, d4
0095B8  ori.b  #$78, d0
0095BC  ori.b  #$78, d0
0095C0  ori.b  #$4, d4
0095C4  ori.b  #$8c, d0
0095C8  ori.b  #$8c, d0
0095CC  ori.b  #$4, d4
0095D0  ori.b  #$a0, d0
0095D4  ori.b  #$a0, d0
0095D8  ori.b  #$4, d4
0095DC  ori.b  #$b4, d0
0095E0  ori.b  #$b4, d0
0095E4  ori.b  #$78, d0
0095E8  ori.b  #$5, d4
0095EC  ori.b  #$74, d0
0095F0  ori.b  #$84, d0
0095F4  ori.b  #$84, d0
0095F8  ori.b  #$1, d0
0095FC  ori.b  #$98, d0
009600  ori.b  #$98, d0
009604  ori.b  #$90, d0
009608  ori.b  #$1, d0
00960C  ori.b  #$9c, d0
009610  ori.b  #$9c, d0
009614  ori.b  #$9c, d0
009618  ori.b  #$1, d0
00961C  ori.b  #$a0, d0
009620  ori.b  #$a0, d0
009624  ori.b  #$a8, d0
009628  ori.b  #$0, d1
00962C  ori.b  #$a4, d0
009630  ori.b  #$a8, d0
009634  ori.b  #$b4, d0
009638  ori.b  #$1, d2
00963C  ori.b  #$a8, d0
009640  ori.b  #$b0, d0
009644  ori.b  #$c0, d0
009648  ori.b  #$1, d1
00964C  ori.b  #$b4, d0
009650  ori.b  #$b8, d0
009654  ori.b  #$cc, d0
009658  ori.b  #$1, d2
00965C  ori.b  #$bc, d0
009660  ori.b  #$c4, d0
009664  ori.b  #$d8, d0
009668  ori.b  #$1, d1
00966C  ori.b  #$c8, d0
009670  ori.b  #$cc, d0
009674  ori.b  #$c0, d0
009678  ori.b  #$c0, d0
00967C  ori.b  #$ac, d0
009680  ori.b  #$ac, d0
009684  ori.b  #$e4, d0
009688  ori.b  #$e4, d0
00968C  ori.b  #$d0, d0
009690  ori.b  #$d0, d0
009694  ori.b  #$48, d0
009698  ori.b  #$5c, d0
00969C  ori.b  #$70, d0
0096A0  ori.b  #$84, d0
0096A4  ori.b  #$98, d0
0096A8  ori.b  #$c0, d0
0096AC  ori.b  #$e4, d0
0096B0  ori.b  #$34, d0
0096B4  ori.b  #$e8, d0
0096B8  ori.b  #$20, d0
0096BC  ori.b  #$ac, d0
0096C0  ori.b  #$d0, d0
0096C4  ori.b  #$f8, d0
0096C8  ori.b  #$d4, d0
0096CC  ori.b  #$c, d0
0096D0  ori.b  #$2c, d0
0096D4  ori.b  #$cc, d0
0096D8  ori.b  #$4, d1
0096DC  ori.b  #$0, d0
0096E0  ori.b  #$0, d0
0096E4  ori.b  #$2c, d0
0096E8  ori.b  #$b4, d0
0096EC  ori.b  #$5, d1
0096F0  ori.b  #$0, d0
0096F4  ori.b  #$0, d0
0096F8  ori.b  #$2c, d0
0096FC  ori.b  #$cc, d0
009700  ; data: 0x00, 0xff
009702  ori.b  #$0, d4
009706  ori.b  #$0, d0
00970A  ori.b  #$0, d0
00970E  move.w $0(a4), -(a0)
009712  suba.l (a0)+, a2
009714  ; data: 0x00, 0xff
009716  ori.b  #$0, d5
00971A  ori.b  #$0, d0
00971E  ori.b  #$0, d0
009722  move.w $0(a4), -(a0)
009726  suba.l d0, a2
009728  ; data: 0x00, 0xff
00972A  ori.b  #$0, d4
00972E  ori.b  #$0, d0
009732  ori.b  #$0, d0
009736  move.w $0(a4), -(a0)
00973A  sub.l  d2, -$1(a4, d0.w)
00973E  ori.b  #$0, d5
009742  ori.b  #$0, d0
009746  ori.b  #$0, d0
00974A  move.w $0(a4), -(a0)
00974E  sub.w  d2, $ff.w
009752  ori.b  #$0, d1
009756  ori.b  #$0, d0
00975A  ori.b  #$0, d0
00975E  move.w $0(a4), -(a0)
009762  subx.l d4, d2
009764  ; data: 0x00, 0xff
009766  ori.b  #$0, d2
00976A  ori.b  #$0, d0
00976E  ori.b  #$0, d0
009772  move.w $0(a4), -(a0)
009776  sub.l  d2, (a0)
009778  ; data: 0x00, 0xff
00977A  ori.b  #$0, d3
00977E  ori.b  #$0, d0
009782  ori.b  #$0, d0
009786  move.w $0(a4), -(a0)
00978A  sub.l  d2, (a4)+
00978C  ; data: 0x00, 0xff
00978E  ori.b  #$0, d5
009792  ori.b  #$0, d0
009796  ori.b  #$0, d0
00979A  move.w $0(a4), -(a0)
00979E  sub.l  d2, $1(a0)
0097A2  ori.b  #$0, d5
0097A6  ori.b  #$0, d0
0097AA  ori.b  #$0, d0
0097AE  move.w $0(a4), -(a0)
0097B2  suba.l a4, a2
0097B4  ori.b  #$4, d1
0097B8  ori.b  #$0, d0
0097BC  ori.b  #$0, d0
0097C0  ori.b  #$2c, d0
0097C4  ori.b  #$b4, d0
0097C8  ori.b  #$5, d1
0097CC  ori.b  #$0, d0
0097D0  ori.b  #$0, d0
0097D4  ori.b  #$2c, d0
0097D8  ori.b  #$d8, d0
0097DC  ori.b  #$5, d1
0097E0  ori.b  #$0, d0
0097E4  ori.b  #$0, d0
0097E8  ori.b  #$2c, d0
0097EC  ori.b  #$c0, d0
0097F0  ori.b  #$4, d1
0097F4  ori.b  #$0, d0
0097F8  ori.b  #$0, d0
0097FC  ori.b  #$0, d5
009800  ori.b  #$f4, d5
009804  ori.b  #$c4, d5
009808  ori.b  #$30, d5
00980C  ori.b  #$60, d5
009810  ori.b  #$6c, d5
009814  ori.b  #$3c, d5
009818  ori.b  #$d0, d5
00981C  ori.b  #$0, d5
009820  ori.b  #$c, d5
009824  ori.b  #$78, d5
009828  ori.b  #$60, d5
00982C  ori.b  #$30, d5
009830  ori.b  #$c4, d5
009834  ori.b  #$f4, d5
009838  ori.b  #$c, d5
00983C  ori.b  #$c, d5
009840  ori.b  #$0, d5
009844  ori.b  #$d0, d5
009848  ori.b  #$3c, d5
00984C  ori.b  #$6c, d5
009850  ori.b  #$78, d5
009854  ori.b  #$c, d5
009858  ori.b  #$0, d5
00985C  ori.b  #$c, d5
009860  ori.b  #$f4, d5
009864  ori.b  #$0, d5
009868  ori.b  #$60, d5
00986C  ori.b  #$6c, d5
009870  ori.b  #$78, d5
009874  ori.b  #$60, d5
009878  ori.b  #$d0, d5
00987C  ori.b  #$dc, d5
009880  ori.b  #$48, d5
009884  ori.b  #$3c, d5
009888  ori.b  #$d0, d5
00988C  ori.b  #$dc, d5
009890  ori.b  #$e8, d5
009894  ori.b  #$54, d5
009898  ori.b  #$48, d5
00989C  ori.b  #$dc, d5
0098A0  ori.b  #$b8, d5
0098A4  ori.b  #$c4, d5
0098A8  ori.b  #$30, d5
0098AC  ori.b  #$24, d5
0098B0  ori.b  #$b8, d5
0098B4  ori.b  #$ac, d5
0098B8  ori.b  #$b8, d5
0098BC  ori.b  #$24, d5
0098C0  ori.b  #$18, d5
0098C4  ori.b  #$ac, d5
0098C8  ori.b  #$e4, d0
0098CC  ori.b  #$34, d0
0098D0  ori.b  #$b8, d0
0098D4  ori.b  #$94, d0
0098D8  ; data: 0x00, 0x0d
0098DA  ; data: 0x00, 0x0b
0098DC  ; data: 0x00, 0x0b
0098DE  ; data: 0x00, 0x0b
0098E0  ; data: 0x08, 0xbc
0098E2  ori.b  #$0, d0
0098E6  ori.b  #$d0, d0
0098EA  bset.b d1, $0(a0)
0098EE  dc.w   $f830
0098F0  dc.w   $fc18
0098F2  ori.b  #$30, d0
0098F6  ori.b  #$18, d0
0098FA  dc.w   $f830
0098FC  ori.b  #$f4, d0
009900  dc.w   $fa24
009902  bset.b d0, $c(a4, a7.l)
009906  dc.w   $f830
009908  dc.w   $fe0c
00990A  dc.w   $fe0c
00990C  dc.w   $f830
00990E  ori.b  #$0, d0
009912  dc.w   $f830
009914  ori.b  #$f3, d0
009918  ori.b  #$0, d0
00991C  dc.w   $fd2b
00991E  dc.w   $fc95
009920  ; data: 0x00, 0xfa
009922  dc.w   $fe0c
009924  dc.w   $fd12
009926  ; data: 0xff, 0x06
009928  dc.w   $fe0c
00992A  dc.w   $fd12
00992C  ori.b  #$6, d0
009930  bset.b d1, $0(a0)
009934  ori.b  #$3, d3
009938  ori.b  #$70, d0
00993C  ori.b  #$70, d0
009940  ori.b  #$3, d3
009944  ori.b  #$80, d0
009948  ori.b  #$80, d0
00994C  ori.b  #$3, d3
009950  ori.b  #$90, d0
009954  ori.b  #$90, d0
009958  ori.b  #$3, d3
00995C  ori.b  #$a0, d0
009960  ori.b  #$a0, d0
009964  ori.b  #$3, d3
009968  ori.b  #$b0, d0
00996C  ori.b  #$b0, d0
009970  ori.b  #$3, d3
009974  ori.b  #$c0, d0
009978  ori.b  #$c0, d0
00997C  ori.b  #$3, d3
009980  ori.b  #$d0, d0
009984  ori.b  #$d0, d0
009988  ori.b  #$3, d3
00998C  ori.b  #$e0, d0
009990  ori.b  #$e0, d0
009994  ori.b  #$3, d3
009998  ori.b  #$f0, d0
00999C  ori.b  #$f0, d0
0099A0  ori.b  #$3, d3
0099A4  ori.b  #$0, d0
0099A8  ori.b  #$0, d0
0099AC  ori.b  #$3, d3
0099B0  ori.b  #$10, d0
0099B4  ori.b  #$10, d0
0099B8  ori.b  #$34, d0
0099BC  ori.b  #$1, d0
0099C0  ori.b  #$68, d0
0099C4  ori.b  #$68, d0
0099C8  ori.b  #$40, d0
0099CC  ori.b  #$1, d0
0099D0  ori.b  #$6c, d0
0099D4  ori.b  #$6c, d0
0099D8  ori.b  #$4c, d0
0099DC  ori.b  #$1, d0
0099E0  ori.b  #$70, d0
0099E4  ori.b  #$70, d0
0099E8  ori.b  #$58, d0
0099EC  ori.b  #$1, d0
0099F0  ori.b  #$74, d0
0099F4  ori.b  #$74, d0
0099F8  ori.b  #$64, d0
0099FC  ori.b  #$1, d0
009A00  ori.b  #$78, d0
009A04  ori.b  #$78, d0
009A08  ori.b  #$70, d0
009A0C  ori.b  #$1, d0
009A10  ori.b  #$7c, d0
009A14  ori.b  #$7c, d0
009A18  ori.b  #$7c, d0
009A1C  ori.b  #$1, d0
009A20  ori.b  #$80, d0
009A24  ori.b  #$80, d0
009A28  ori.b  #$88, d0
009A2C  ori.b  #$1, d0
009A30  ori.b  #$84, d0
009A34  ori.b  #$84, d0
009A38  ori.b  #$94, d0
009A3C  ori.b  #$1, d0
009A40  ori.b  #$88, d0
009A44  ori.b  #$88, d0
009A48  ori.b  #$a0, d0
009A4C  ori.b  #$1, d0
009A50  ori.b  #$8c, d0
009A54  ori.b  #$8c, d0
009A58  ori.b  #$ac, d0
009A5C  ori.b  #$1, d0
009A60  ori.b  #$90, d0
009A64  ori.b  #$90, d0
009A68  ori.b  #$94, d0
009A6C  ori.b  #$a8, d0
009A70  ori.b  #$bc, d0
009A74  ori.b  #$d0, d0
009A78  ori.b  #$e4, d0
009A7C  ori.b  #$f8, d0
009A80  ori.b  #$c, d0
009A84  ori.b  #$20, d0
009A88  ori.b  #$34, d0
009A8C  ori.b  #$48, d0
009A90  ori.b  #$5c, d0
009A94  ori.b  #$2c, d0
009A98  ori.b  #$34, d0
009A9C  ; data: 0x00, 0xff
009A9E  ori.b  #$0, d2
009AA2  ori.b  #$0, d0
009AA6  ori.b  #$0, d0
009AAA  move.w $0(a4), -(a0)
009AAE  subx.w d0, d4
009AB0  ; data: 0x00, 0xff
009AB2  ori.b  #$0, d3
009AB6  ori.b  #$0, d0
009ABA  ori.b  #$0, d0
009ABE  move.w $0(a4), -(a0)
009AC2  subx.w -(a4), -(a4)
009AC4  ; data: 0x00, 0xff
009AC6  ori.b  #$0, d1
009ACA  ori.b  #$0, d0
009ACE  ori.b  #$0, d0
009AD2  move.w $0(a4), -(a0)
009AD6  sub.w  d4, (a0)+
009AD8  ; data: 0x00, 0xff
009ADA  ori.b  #$0, d2
009ADE  ori.b  #$0, d0
009AE2  ori.b  #$0, d0
009AE6  move.w $0(a4), -(a0)
009AEA  sub.w  d4, -(a4)
009AEC  ; data: 0x00, 0xff
009AEE  ori.b  #$0, d1
009AF2  ori.b  #$0, d0
009AF6  ori.b  #$0, d0
009AFA  move.w $0(a4), -(a0)
009AFE  sub.w  d4, -$1(a0, d0.w)
009B02  ori.b  #$0, d2
009B06  ori.b  #$0, d0
009B0A  ori.b  #$0, d0
009B0E  move.w $0(a4), -(a0)
009B12  ; data: 0x99, 0x7c
009B14  ; data: 0x00, 0xff
009B16  ori.b  #$0, d2
009B1A  ori.b  #$0, d0
009B1E  ori.b  #$0, d0
009B22  move.w $0(a4), -(a0)
009B26  subx.l -(a0), -(a4)
009B28  ; data: 0x00, 0xff
009B2A  ori.b  #$0, d3
009B2E  ori.b  #$0, d0
009B32  ori.b  #$0, d0
009B36  move.w $0(a4), -(a0)
009B3A  sub.l  d4, (a4)
009B3C  ; data: 0x00, 0xff
009B3E  ori.b  #$0, d4
009B42  ori.b  #$0, d0
009B46  ori.b  #$0, d0
009B4A  move.w $0(a4), -(a0)
009B4E  sub.l  d4, -(a0)
009B50  ; data: 0x00, 0xff
009B52  ori.b  #$0, d5
009B56  ori.b  #$0, d0
009B5A  ori.b  #$0, d0
009B5E  move.w $0(a4), -(a0)
009B62  sub.l  d4, $ff(a4)
009B66  ori.b  #$0, d5
009B6A  ori.b  #$0, d0
009B6E  ori.b  #$5, d0
009B72  ; data: 0x43, 0xc4
009B74  ori.b  #$3c, d5
009B78  ori.b  #$ac, d5
009B7C  ori.b  #$c4, d5
009B80  ori.b  #$ac, d5
009B84  ori.b  #$3c, d5
009B88  ori.b  #$b8, d5
009B8C  ori.b  #$ac, d5
009B90  ori.b  #$c4, d5
009B94  ori.b  #$d0, d5
009B98  ori.b  #$3c, d5
009B9C  ori.b  #$c4, d5
009BA0  ori.b  #$3c, d5
009BA4  ori.b  #$d0, d5
009BA8  ori.b  #$b8, d5
009BAC  ori.b  #$3c, d5
009BB0  ori.b  #$ac, d5
009BB4  ori.b  #$dc, d5
009BB8  ori.b  #$c4, d5
009BBC  ori.b  #$ac, d5
009BC0  ori.b  #$ac, d5
009BC4  ori.b  #$b8, d5
009BC8  ori.b  #$dc, d5
009BCC  ori.b  #$ac, d5
009BD0  ori.b  #$c4, d5
009BD4  ori.b  #$dc, d5
009BD8  ori.b  #$b8, d5
009BDC  ori.b  #$c4, d5
009BE0  ori.b  #$d0, d5
009BE4  ori.b  #$c4, d5
009BE8  ori.b  #$b8, d5
009BEC  ori.b  #$d0, d5
009BF0  ori.b  #$f4, d5
009BF4  ori.b  #$0, d5
009BF8  ori.b  #$e8, d5
009BFC  ori.b  #$f4, d5
009C00  ori.b  #$c, d5
009C04  ori.b  #$30, d5
009C08  ori.b  #$18, d5
009C0C  ori.b  #$c, d5
009C10  ori.b  #$18, d5
009C14  ori.b  #$24, d5
009C18  ori.b  #$c, d5
009C1C  ori.b  #$18, d5
009C20  ori.b  #$3c, d0
009C24  ori.b  #$9c, d0
009C28  ori.b  #$5c, d0
009C2C  ori.b  #$9c, d0
009C30  ori.b  #$10, (a0)
009C34  ori.b  #$10, (a0)
009C38  dc.w   $4d4
009C3A  ori.b  #$0, d0
009C3E  dc.w   $fb50
009C40  btst.l d0, $0(a4)
009C44  dc.w   $fc18
009C46  btst.l d0, $0(a4)
009C4A  subi.l #$12c0000, $12c(invalid.w)
009C54  dc.w   $fb50
009C56  ori.b  #$2c, d0
009C5A  dc.w   $fc18
009C5C  ori.b  #$2c, d0
009C60  bset.b d1, $0(a0)
009C64  btst.l d0, $4b0(a4)
009C68  ori.b  #$2c, d0
009C6C  ori.b  #$50, d0
009C70  dc.w   $fed4
009C72  ori.b  #$18, d0
009C76  dc.w   $fed4
009C78  ori.b  #$b0, d0
009C7C  dc.w   $fed4
009C7E  ori.b  #$e8, d0
009C82  dc.w   $fed4
009C84  dc.w   $fb50
009C86  ori.b  #$d4, d0
009C8A  dc.w   $fc18
009C8C  ori.b  #$d4, d0
009C90  bset.b d1, $0(a0)
009C94  dc.w   $fed4
009C96  subi.l #$fed4, $4(a0, d0.w)
009C9E  ori.b  #$0, d4
009CA2  suba.l (a4)+, a7
009CA4  ori.b  #$dc, d0
009CA8  ori.b  #$4, d4
009CAC  ori.b  #$f0, d0
009CB0  ori.b  #$f0, d0
009CB4  ori.b  #$4, d4
009CB8  ori.b  #$4, d0
009CBC  ori.b  #$4, d0
009CC0  ori.b  #$4, d4
009CC4  ori.b  #$18, d0
009CC8  ori.b  #$18, d0
009CCC  ori.b  #$4, d4
009CD0  ori.b  #$2c, d0
009CD4  ori.b  #$2c, d0
009CD8  ori.b  #$4, d4
009CDC  ori.b  #$40, d0
009CE0  ori.b  #$40, d0
009CE4  ori.b  #$4, d4
009CE8  ori.b  #$54, d0
009CEC  ori.b  #$54, d0
009CF0  ori.b  #$4, d4
009CF4  ori.b  #$68, d0
009CF8  ori.b  #$68, d0
009CFC  ori.b  #$4, d4
009D00  ori.b  #$7c, d0
009D04  ori.b  #$7c, d0
009D08  ori.b  #$4, d4
009D0C  ori.b  #$90, d0
009D10  ori.b  #$90, d0
009D14  ori.b  #$4, d4
009D18  ori.b  #$a4, d0
009D1C  ori.b  #$a4, d0
009D20  ori.b  #$4, d4
009D24  ori.b  #$b8, d0
009D28  ori.b  #$b8, d0
009D2C  ori.b  #$4, d4
009D30  ori.b  #$cc, d0
009D34  ori.b  #$cc, d0
009D38  ori.b  #$4, d4
009D3C  ori.b  #$e0, d0
009D40  ori.b  #$e0, d0
009D44  ori.b  #$4, d4
009D48  ori.b  #$f4, d0
009D4C  ori.b  #$f4, d0
009D50  ori.b  #$4, d4
009D54  ori.b  #$8, d0
009D58  ori.b  #$8, d0
009D5C  ori.b  #$9c, d0
009D60  ori.b  #$0, d1
009D64  ori.b  #$5c, d0
009D68  ori.b  #$60, d0
009D6C  ori.b  #$a8, d0
009D70  ori.b  #$0, d1
009D74  ori.b  #$60, d0
009D78  ori.b  #$64, d0
009D7C  ori.b  #$b4, d0
009D80  ori.b  #$0, d1
009D84  ori.b  #$64, d0
009D88  ori.b  #$68, d0
009D8C  ori.b  #$c0, d0
009D90  ori.b  #$0, d1
009D94  ori.b  #$68, d0
009D98  ori.b  #$6c, d0
009D9C  ori.b  #$cc, d0
009DA0  ori.b  #$0, d1
009DA4  ori.b  #$6c, d0
009DA8  ori.b  #$70, d0
009DAC  ori.b  #$d8, d0
009DB0  ori.b  #$0, d1
009DB4  ori.b  #$70, d0
009DB8  ori.b  #$74, d0
009DBC  ori.b  #$e4, d0
009DC0  ori.b  #$0, d1
009DC4  ori.b  #$74, d0
009DC8  ori.b  #$78, d0
009DCC  ori.b  #$f0, d0
009DD0  ori.b  #$0, d1
009DD4  ori.b  #$78, d0
009DD8  ori.b  #$7c, d0
009DDC  ori.b  #$fc, d0
009DE0  ori.b  #$0, d1
009DE4  ori.b  #$7c, d0
009DE8  ori.b  #$80, d0
009DEC  ori.b  #$8, d0
009DF0  ori.b  #$0, d1
009DF4  ori.b  #$80, d0
009DF8  ori.b  #$84, d0
009DFC  ori.b  #$14, d0
009E00  ori.b  #$0, d1
009E04  ori.b  #$84, d0
009E08  ori.b  #$88, d0
009E0C  ori.b  #$20, d0
009E10  ori.b  #$0, d1
009E14  ori.b  #$88, d0
009E18  ori.b  #$8c, d0
009E1C  ori.b  #$2c, d0
009E20  ori.b  #$0, d1
009E24  ori.b  #$8c, d0
009E28  ori.b  #$90, d0
009E2C  ori.b  #$38, d0
009E30  ori.b  #$0, d1
009E34  ori.b  #$90, d0
009E38  ori.b  #$94, d0
009E3C  ori.b  #$44, d0
009E40  ori.b  #$0, d1
009E44  ori.b  #$94, d0
009E48  ori.b  #$98, d0
009E4C  ori.b  #$50, d0
009E50  ori.b  #$0, d1
009E54  ori.b  #$98, d0
009E58  ori.b  #$9c, d0
009E5C  ori.b  #$ec, d0
009E60  ori.b  #$0, d0
009E64  ori.b  #$14, d0
009E68  ori.b  #$28, d0
009E6C  ori.b  #$3c, d0
009E70  ori.b  #$50, d0
009E74  ori.b  #$64, d0
009E78  ori.b  #$78, d0
009E7C  ori.b  #$8c, d0
009E80  ori.b  #$a0, d0
009E84  ori.b  #$b4, d0
009E88  ori.b  #$c8, d0
009E8C  ori.b  #$9c, d0
009E90  ori.b  #$b0, d0
009E94  ori.b  #$c4, d0
009E98  ori.b  #$d8, d0
009E9C  ori.b  #$2c, d0
009EA0  ori.b  #$2c, d0
009EA4  ori.b  #$2, d1
009EA8  ori.b  #$0, d0
009EAC  ori.b  #$0, d0
009EB0  ori.b  #$2c, d0
009EB4  ori.b  #$38, d0
009EB8  ori.b  #$3, d1
009EBC  ori.b  #$0, d0
009EC0  ori.b  #$0, d0
009EC4  ori.b  #$2c, d0
009EC8  ori.b  #$44, d0
009ECC  ori.b  #$2, d1
009ED0  ori.b  #$0, d0
009ED4  ori.b  #$0, d0
009ED8  ori.b  #$2c, d0
009EDC  ori.b  #$50, d0
009EE0  ori.b  #$3, d1
009EE4  ori.b  #$0, d0
009EE8  ori.b  #$0, d0
009EEC  ori.b  #$2c, d0
009EF0  ori.b  #$9c, d0
009EF4  ori.b  #$1, d1
009EF8  ori.b  #$0, d0
009EFC  ori.b  #$0, d0
009F00  ori.b  #$2c, d0
009F04  ori.b  #$a8, d0
009F08  ori.b  #$1, d1
009F0C  ori.b  #$0, d0
009F10  ori.b  #$0, d0
009F14  ori.b  #$2c, d0
009F18  ori.b  #$b4, d0
009F1C  ori.b  #$1, d1
009F20  ori.b  #$0, d0
009F24  ori.b  #$0, d0
009F28  ori.b  #$2c, d0
009F2C  ori.b  #$c0, d0
009F30  ori.b  #$1, d1
009F34  ori.b  #$0, d0
009F38  ori.b  #$0, d0
009F3C  ori.b  #$2c, d0
009F40  ori.b  #$cc, d0
009F44  ori.b  #$1, d1
009F48  ori.b  #$0, d0
009F4C  ori.b  #$0, d0
009F50  ori.b  #$2c, d0
009F54  ori.b  #$d8, d0
009F58  ori.b  #$1, d1
009F5C  ori.b  #$0, d0
009F60  ori.b  #$0, d0
009F64  ori.b  #$2c, d0
009F68  ori.b  #$e4, d0
009F6C  ori.b  #$1, d1
009F70  ori.b  #$0, d0
009F74  ori.b  #$0, d0
009F78  ori.b  #$2c, d0
009F7C  ori.b  #$f0, d0
009F80  ori.b  #$1, d1
009F84  ori.b  #$0, d0
009F88  ori.b  #$0, d0
009F8C  ori.b  #$2c, d0
009F90  ori.b  #$fc, d0
009F94  ori.b  #$2, d1
009F98  ori.b  #$0, d0
009F9C  ori.b  #$0, d0
009FA0  ori.b  #$2c, d0
009FA4  ori.b  #$8, d0
009FA8  ori.b  #$3, d1
009FAC  ori.b  #$0, d0
009FB0  ori.b  #$0, d0
009FB4  ori.b  #$2c, d0
009FB8  ori.b  #$14, d0
009FBC  ori.b  #$2, d1
009FC0  ori.b  #$0, d0
009FC4  ori.b  #$0, d0
009FC8  ori.b  #$2c, d0
009FCC  ori.b  #$20, d0
009FD0  ori.b  #$3, d1
009FD4  ori.b  #$0, d0
009FD8  ori.b  #$0, d0
009FDC  ori.b  #$e8, d5
009FE0  ori.b  #$b8, d5
009FE4  ori.b  #$ac, d5
009FE8  ori.b  #$dc, d5
009FEC  ori.b  #$e8, d5
009FF0  ori.b  #$b8, d5
009FF4  ori.b  #$f4, d5
009FF8  ori.b  #$0, d5
009FFC  ori.b  #$ac, d5
00A000  ori.b  #$b8, d5
00A004  ori.b  #$d0, d5
00A008  ori.b  #$c4, d5
00A00C  ori.b  #$0, d5
00A010  ori.b  #$f4, d5
00A014  ori.b  #$d0, d5
00A018  ori.b  #$dc, d5
00A01C  ori.b  #$c4, d5
00A020  ori.b  #$d0, d5
00A024  ori.b  #$e8, d5
00A028  ori.b  #$dc, d5
00A02C  ori.b  #$c, d5
00A030  ori.b  #$18, d5
00A034  ori.b  #$48, d5
00A038  ori.b  #$3c, d5
00A03C  ori.b  #$c, d5
00A040  ori.b  #$60, d5
00A044  ori.b  #$54, d5
00A048  ori.b  #$18, d5
00A04C  ori.b  #$c, d5
00A050  ori.b  #$60, d5
00A054  ori.b  #$60, d5
00A058  ori.b  #$24, d5
00A05C  ori.b  #$30, d5
00A060  ori.b  #$54, d5
00A064  ori.b  #$60, d5
00A068  ori.b  #$48, d5
00A06C  ori.b  #$30, d5
00A070  ori.b  #$24, d5
00A074  ori.b  #$3c, d5
00A078  ori.b  #$48, d5
00A07C  ori.b  #$c, d5
00A080  ori.b  #$3c, d5
00A084  ori.b  #$dc, d5
00A088  ori.b  #$ac, d5
00A08C  ori.b  #$c, d5
00A090  ori.b  #$ac, d5
00A094  ori.b  #$0, d5
00A098  ori.b  #$60, d5
00A09C  ori.b  #$c, d5
00A0A0  ori.b  #$ac, d5
00A0A4  ori.b  #$0, d5
00A0A8  ori.b  #$c4, d5
00A0AC  ori.b  #$24, d5
00A0B0  ori.b  #$60, d5
00A0B4  ori.b  #$0, d5
00A0B8  ori.b  #$3c, d5
00A0BC  ori.b  #$24, d5
00A0C0  ori.b  #$c4, d5
00A0C4  ori.b  #$dc, d5
00A0C8  ori.b  #$3c, d5
00A0CC  ori.b  #$b8, d5
00A0D0  ori.b  #$e8, d5
00A0D4  ori.b  #$48, d5
00A0D8  ori.b  #$18, d5
00A0DC  ori.b  #$b8, d5
00A0E0  ori.b  #$18, d5
00A0E4  ori.b  #$54, d5
00A0E8  ori.b  #$f4, d5
00A0EC  ori.b  #$b8, d5
00A0F0  ori.b  #$18, d5
00A0F4  ori.b  #$54, d5
00A0F8  ori.b  #$30, d5
00A0FC  ori.b  #$d0, d5
00A100  ori.b  #$f4, d5
00A104  ori.b  #$54, d5
00A108  ori.b  #$e8, d5
00A10C  ori.b  #$d0, d5
00A110  ori.b  #$30, d5
00A114  ori.b  #$48, d5
00A118  ori.b  #$e8, d5
00A11C  ori.b  #$38, d0
00A120  ori.b  #$64, d0
00A124  ori.b  #$4, d0
00A128  ori.b  #$64, d0
00A12C  ori.b  #$38, $38(a2, d0.w)
00A132  ori.b  #$88, $0.w
00A138  subi.l #$fd5d0546, -$50(a0, d0.w)
00A140  dc.w   $faba
00A142  andi.l #$4b0faba, -(a3)
00A148  dc.w   $fd5d
00A14A  subi.l #$fd5dfaba, -$50(a0, d0.w)
00A152  andi.l #$faba04b0, -(a3)
00A158  bchg.b d2, d6
00A15A  dc.w   $fd5d
00A15C  subi.l #$54602a3, -$50(a0, d0.w)
00A164  andi.l #$546fb50, -(a3)
00A16A  dc.w   $fd5d
00A16C  bchg.b d2, d6
00A16E  dc.w   $fb50
00A170  dc.w   $faba
00A172  andi.l #$fb50faba, -(a3)
00A178  dc.w   $fd5d
00A17A  dc.w   $fb50
00A17C  dc.w   $fd5d
00A17E  dc.w   $faba
00A180  dc.w   $fb50
00A182  andi.l #$fabafb50, -(a3)
00A188  bchg.b d2, d6
00A18A  dc.w   $fd5d
00A18C  dc.w   $fb50
00A18E  bchg.b d2, d6
00A190  andi.l #$fb5002a3, -(a3)
00A196  bchg.b d2, d6
00A198  bclr.b d1, d4
00A19A  ; data: 0xff, 0x88
00A19C  ; data: 0x00, 0xf0
00A19E  bclr.b d1, d4
00A1A0  dc.w   $ff10
00A1A2  ori.w  #$384, $ff10.w
00A1A8  ; data: 0xff, 0x88
00A1AA  bclr.b d1, d4
00A1AC  ; data: 0xff, 0x88
00A1AE  dc.w   $ff10
00A1B0  bclr.b d1, d4
00A1B2  ori.w  #$ff10, $384.w
00A1B8  ; data: 0x00, 0xf0
00A1BA  ; data: 0xff, 0x88
00A1BC  bclr.b d1, d4
00A1BE  ; data: 0x00, 0xf0
00A1C0  ori.w  #$384, $78.w
00A1C6  ; data: 0x00, 0xf0
00A1C8  dc.w   $fc7c
00A1CA  ; data: 0xff, 0x88
00A1CC  ; data: 0x00, 0xf0
00A1CE  dc.w   $fc7c
00A1D0  dc.w   $ff10
00A1D2  ori.w  #$fc7c, $ff10.w
00A1D8  ; data: 0xff, 0x88
00A1DA  dc.w   $fc7c
00A1DC  ; data: 0xff, 0x88
00A1DE  dc.w   $ff10
00A1E0  dc.w   $fc7c
00A1E2  ori.w  #$ff10, $fc7c.w
00A1E8  ; data: 0x00, 0xf0
00A1EA  ; data: 0xff, 0x88
00A1EC  dc.w   $fc7c
00A1EE  ; data: 0x00, 0xf0
00A1F0  ori.w  #$fc7c, $78.w
00A1F6  ; data: 0x00, 0xf0
00A1F8  btst.l d0, -$12c(a4)
00A1FC  bset.b d0, d2
00A1FE  btst.l d0, -$1c2(a4)
00A202  btst.l d0, $12c(a4)
00A206  dc.w   $fe3e
00A208  dc.w   $fed4
00A20A  btst.l d0, -$12c(a4)
00A20E  dc.w   $fe3e
00A210  btst.l d0, $12c(a4)
00A214  dc.w   $fe3e
00A216  btst.l d0, $1c2(a4)
00A21A  dc.w   $fed4
00A21C  btst.l d0, $1c2(a4)
00A220  btst.l d0, $12c(a4)
00A224  btst.l d0, $1c2(a4)
00A228  dc.w   $fed4
00A22A  dc.w   $fed4
00A22C  bset.b d0, d2
00A22E  dc.w   $fed4
00A230  dc.w   $fe3e
00A232  btst.l d0, -$12c(a4)
00A236  dc.w   $fe3e
00A238  dc.w   $fed4
00A23A  dc.w   $fed4
00A23C  dc.w   $fed4
00A23E  dc.w   $fe3e
00A240  dc.w   $fed4
00A242  btst.l d0, -$1c2(a4)
00A246  dc.w   $fed4
00A248  bset.b d0, d2
00A24A  dc.w   $fed4
00A24C  dc.w   $fed4
00A24E  bset.b d0, d2
00A250  btst.l d0, -$12c(a4)
00A254  btst.l d0, $1c2(a4)
00A258  subi.l #$0, (a0, invalid.w)
00A260  ori.b  #$0, d0
00A264  ori.b  #$3, d3
00A268  ori.b  #$c4, d0
00A26C  ori.b  #$c4, d0
00A270  ori.b  #$3, d3
00A274  ori.b  #$d4, d0
00A278  ori.b  #$d4, d0
00A27C  ori.b  #$3, d3
00A280  ori.b  #$e4, d0
00A284  ori.b  #$e4, d0
00A288  ori.b  #$3, d3
00A28C  ori.b  #$f4, d0
00A290  ori.b  #$f4, d0
00A294  ori.b  #$3, d3
00A298  ori.b  #$4, d0
00A29C  ori.b  #$4, d0
00A2A0  ori.b  #$3, d3
00A2A4  ori.b  #$14, d0
00A2A8  ori.b  #$14, d0
00A2AC  ori.b  #$3, d3
00A2B0  ori.b  #$24, d0
00A2B4  ori.b  #$24, d0
00A2B8  ori.b  #$3, d3
00A2BC  ori.b  #$34, d0
00A2C0  ori.b  #$34, d0
00A2C4  ori.b  #$3, d3
00A2C8  ori.b  #$44, d0
00A2CC  ori.b  #$44, d0
00A2D0  ori.b  #$3, d3
00A2D4  ori.b  #$54, d0
00A2D8  ori.b  #$54, d0
00A2DC  ori.b  #$3, d3
00A2E0  ori.b  #$64, d0
00A2E4  ori.b  #$64, d0
00A2E8  ori.b  #$3, d3
00A2EC  ori.b  #$74, d0
00A2F0  ori.b  #$74, d0
00A2F4  ori.b  #$3, d3
00A2F8  ori.b  #$84, d0
00A2FC  ori.b  #$84, d0
00A300  ori.b  #$3, d3
00A304  ori.b  #$94, d0
00A308  ori.b  #$94, d0
00A30C  ori.b  #$3, d3
00A310  ori.b  #$a4, d0
00A314  ori.b  #$a4, d0
00A318  ori.b  #$3, d3
00A31C  ori.b  #$b4, d0
00A320  ori.b  #$b4, d0
00A324  ori.b  #$4, d4
00A328  ori.b  #$c4, d0
00A32C  ori.b  #$c4, d0
00A330  ori.b  #$4, d4
00A334  ori.b  #$d8, d0
00A338  ori.b  #$d8, d0
00A33C  ori.b  #$4, d4
00A340  ori.b  #$ec, d0
00A344  ori.b  #$ec, d0
00A348  ori.b  #$4, d4
00A34C  ori.b  #$0, d0
00A350  ori.b  #$0, d0
00A354  ori.b  #$4, d4
00A358  ori.b  #$14, d0
00A35C  ori.b  #$14, d0
00A360  ori.b  #$4, d4
00A364  ori.b  #$28, d0
00A368  ori.b  #$28, d0
00A36C  ori.b  #$4, d4
00A370  ori.b  #$3c, d0
00A374  ori.b  #$3c, d0
00A378  ori.b  #$4, d4
00A37C  ori.b  #$50, d0
00A380  ori.b  #$50, d0
00A384  ori.b  #$4, d4
00A388  ori.b  #$64, d0
00A38C  ori.b  #$64, d0
00A390  ori.b  #$4, d4
00A394  ori.b  #$78, d0
00A398  ori.b  #$78, d0
00A39C  ori.b  #$4, d4
00A3A0  ori.b  #$8c, d0
00A3A4  ori.b  #$8c, d0
00A3A8  ori.b  #$4, d4
00A3AC  ori.b  #$a0, d0
00A3B0  ori.b  #$a0, d0
00A3B4  ori.b  #$4, d4
00A3B8  ori.b  #$b4, d0
00A3BC  ori.b  #$b4, d0
00A3C0  ori.b  #$4, d4
00A3C4  ori.b  #$c8, d0
00A3C8  ori.b  #$c8, d0
00A3CC  ori.b  #$4, d4
00A3D0  ori.b  #$dc, d0
00A3D4  ori.b  #$dc, d0
00A3D8  ori.b  #$4, d4
00A3DC  ori.b  #$f0, d0
00A3E0  ori.b  #$f0, d0
00A3E4  ori.b  #$4, d4
00A3E8  ori.b  #$4, d0
00A3EC  ori.b  #$4, d0
00A3F0  ori.b  #$4, d4
00A3F4  ori.b  #$18, d0
00A3F8  ori.b  #$18, d0
00A3FC  ori.b  #$4, d4
00A400  ori.b  #$2c, d0
00A404  ori.b  #$2c, d0
00A408  ori.b  #$4, d4
00A40C  ori.b  #$40, d0
00A410  ori.b  #$40, d0
00A414  ori.b  #$4, d4
00A418  ori.b  #$54, d0
00A41C  ori.b  #$54, d0
00A420  ori.b  #$4, d4
00A424  ori.b  #$68, d0
00A428  ori.b  #$68, d0
00A42C  ori.b  #$4, d4
00A430  ori.b  #$7c, d0
00A434  ori.b  #$7c, d0
00A438  ori.b  #$4, d4
00A43C  ori.b  #$90, d0
00A440  ori.b  #$90, d0
00A444  ori.b  #$4, d4
00A448  ori.b  #$a4, d0
00A44C  ori.b  #$a4, d0
00A450  ori.b  #$4, d4
00A454  ori.b  #$b8, d0
00A458  ori.b  #$b8, d0
00A45C  ori.b  #$4, d4
00A460  ori.b  #$cc, d0
00A464  ori.b  #$cc, d0
00A468  ori.b  #$4, d4
00A46C  ori.b  #$e0, d0
00A470  ori.b  #$e0, d0
00A474  ori.b  #$4, d4
00A478  ori.b  #$f4, d0
00A47C  ori.b  #$f4, d0
00A480  ori.b  #$4, d4
00A484  ori.b  #$8, d0
00A488  ori.b  #$8, d0
00A48C  ori.b  #$4, d4
00A490  ori.b  #$1c, d0
00A494  ori.b  #$1c, d0
00A498  ori.b  #$4, d4
00A49C  ori.b  #$30, d0
00A4A0  ori.b  #$30, d0
00A4A4  ori.b  #$4, d4
00A4A8  ori.b  #$44, d0
00A4AC  ori.b  #$44, d0
00A4B0  ori.b  #$4, d4
00A4B4  ori.b  #$58, d0
00A4B8  ori.b  #$58, d0
00A4BC  ori.b  #$4, d4
00A4C0  ori.b  #$6c, d0
00A4C4  ori.b  #$6c, d0
00A4C8  ori.b  #$4, d4
00A4CC  ori.b  #$80, d0
00A4D0  ori.b  #$80, d0
00A4D4  ori.b  #$4, d4
00A4D8  ori.b  #$94, d0
00A4DC  ori.b  #$94, d0
00A4E0  ori.b  #$4, d4
00A4E4  ori.b  #$a8, d0
00A4E8  ori.b  #$a8, d0
00A4EC  ori.b  #$4, d4
00A4F0  ori.b  #$bc, d0
00A4F4  ori.b  #$bc, d0
00A4F8  ori.b  #$4, d4
00A4FC  ori.b  #$d0, d0
00A500  ori.b  #$d0, d0
00A504  ori.b  #$64, d0
00A508  ori.b  #$0, d1
00A50C  ori.b  #$84, d0
00A510  ori.b  #$88, d0
00A514  ori.b  #$70, d0
00A518  ori.b  #$0, d1
00A51C  ori.b  #$88, d0
00A520  ori.b  #$8c, d0
00A524  ori.b  #$7c, d0
00A528  ori.b  #$0, d1
00A52C  ori.b  #$8c, d0
00A530  ori.b  #$90, d0
00A534  ori.b  #$88, d0
00A538  ori.b  #$0, d1
00A53C  ori.b  #$90, d0
00A540  ori.b  #$94, d0
00A544  ori.b  #$94, d0
00A548  ori.b  #$0, d1
00A54C  ori.b  #$94, d0
00A550  ori.b  #$98, d0
00A554  ori.b  #$a0, d0
00A558  ori.b  #$0, d1
00A55C  ori.b  #$98, d0
00A560  ori.b  #$9c, d0
00A564  ori.b  #$ac, d0
00A568  ori.b  #$0, d1
00A56C  ori.b  #$9c, d0
00A570  ori.b  #$a0, d0
00A574  ori.b  #$b8, d0
00A578  ori.b  #$0, d1
00A57C  ori.b  #$a0, d0
00A580  ori.b  #$a4, d0
00A584  ori.b  #$c4, d0
00A588  ori.b  #$0, d1
00A58C  ori.b  #$a4, d0
00A590  ori.b  #$a8, d0
00A594  ori.b  #$d0, d0
00A598  ori.b  #$0, d1
00A59C  ori.b  #$a8, d0
00A5A0  ori.b  #$ac, d0
00A5A4  ori.b  #$dc, d0
00A5A8  ori.b  #$0, d1
00A5AC  ori.b  #$ac, d0
00A5B0  ori.b  #$b0, d0
00A5B4  ori.b  #$e8, d0
00A5B8  ori.b  #$0, d1
00A5BC  ori.b  #$b0, d0
00A5C0  ori.b  #$b4, d0
00A5C4  ori.b  #$f4, d0
00A5C8  ori.b  #$0, d1
00A5CC  ori.b  #$b4, d0
00A5D0  ori.b  #$b8, d0
00A5D4  ori.b  #$0, d0
00A5D8  ori.b  #$0, d1
00A5DC  ori.b  #$b8, d0
00A5E0  ori.b  #$bc, d0
00A5E4  ori.b  #$c, d0
00A5E8  ori.b  #$0, d1
00A5EC  ori.b  #$bc, d0
00A5F0  ori.b  #$c0, d0
00A5F4  ori.b  #$18, d0
00A5F8  ori.b  #$0, d1
00A5FC  ori.b  #$c0, d0
00A600  ori.b  #$c4, d0
00A604  ori.b  #$24, d0
00A608  ori.b  #$0, d1
00A60C  ori.b  #$c4, d0
00A610  ori.b  #$c8, d0
00A614  ori.b  #$30, d0
00A618  ori.b  #$0, d1
00A61C  ori.b  #$c8, d0
00A620  ori.b  #$cc, d0
00A624  ori.b  #$3c, d0
00A628  ori.b  #$0, d1
00A62C  ori.b  #$cc, d0
00A630  ori.b  #$d0, d0
00A634  ori.b  #$48, d0
00A638  ori.b  #$0, d1
00A63C  ori.b  #$d0, d0
00A640  ori.b  #$d4, d0
00A644  ori.b  #$54, d0
00A648  ori.b  #$0, d1
00A64C  ori.b  #$d4, d0
00A650  ori.b  #$d8, d0
00A654  ori.b  #$60, d0
00A658  ori.b  #$0, d1
00A65C  ori.b  #$d8, d0
00A660  ori.b  #$dc, d0
00A664  ori.b  #$6c, d0
00A668  ori.b  #$0, d1
00A66C  ori.b  #$dc, d0
00A670  ori.b  #$e0, d0
00A674  ori.b  #$78, d0
00A678  ori.b  #$0, d1
00A67C  ori.b  #$e0, d0
00A680  ori.b  #$e4, d0
00A684  ori.b  #$84, d0
00A688  ori.b  #$0, d1
00A68C  ori.b  #$e4, d0
00A690  ori.b  #$e8, d0
00A694  ori.b  #$90, d0
00A698  ori.b  #$0, d1
00A69C  ori.b  #$e8, d0
00A6A0  ori.b  #$ec, d0
00A6A4  ori.b  #$9c, d0
00A6A8  ori.b  #$0, d1
00A6AC  ori.b  #$ec, d0
00A6B0  ori.b  #$f0, d0
00A6B4  ori.b  #$a8, d0
00A6B8  ori.b  #$0, d1
00A6BC  ori.b  #$f0, d0
00A6C0  ori.b  #$f4, d0
00A6C4  ori.b  #$b4, d0
00A6C8  ori.b  #$0, d1
00A6CC  ori.b  #$f4, d0
00A6D0  ori.b  #$f8, d0
00A6D4  ori.b  #$c0, d0
00A6D8  ori.b  #$0, d1
00A6DC  ori.b  #$f8, d0
00A6E0  ori.b  #$fc, d0
00A6E4  ori.b  #$cc, d0
00A6E8  ori.b  #$0, d1
00A6EC  ori.b  #$fc, d0
00A6F0  ori.b  #$0, d0
00A6F4  ori.b  #$d8, d0
00A6F8  ori.b  #$0, d1
00A6FC  ori.b  #$0, d0
00A700  ori.b  #$4, d0
00A704  ori.b  #$e4, d0
00A708  ori.b  #$0, d1
00A70C  ori.b  #$4, d0
00A710  ori.b  #$8, d0
00A714  ori.b  #$f0, d0
00A718  ori.b  #$0, d1
00A71C  ori.b  #$8, d0
00A720  ori.b  #$c, d0
00A724  ori.b  #$fc, d0
00A728  ori.b  #$0, d1
00A72C  ori.b  #$c, d0
00A730  ori.b  #$10, d0
00A734  ori.b  #$8, d0
00A738  ori.b  #$0, d1
00A73C  ori.b  #$10, d0
00A740  ori.b  #$14, d0
00A744  ori.b  #$14, d0
00A748  ori.b  #$0, d1
00A74C  ori.b  #$14, d0
00A750  ori.b  #$18, d0
00A754  ori.b  #$20, d0
00A758  ori.b  #$0, d1
00A75C  ori.b  #$18, d0
00A760  ori.b  #$1c, d0
00A764  ori.b  #$2c, d0
00A768  ori.b  #$0, d1
00A76C  ori.b  #$1c, d0
00A770  ori.b  #$20, d0
00A774  ori.b  #$38, d0
00A778  ori.b  #$0, d1
00A77C  ori.b  #$20, d0
00A780  ori.b  #$24, d0
00A784  ori.b  #$44, d0
00A788  ori.b  #$0, d1
00A78C  ori.b  #$24, d0
00A790  ori.b  #$28, d0
00A794  ori.b  #$50, d0
00A798  ori.b  #$0, d1
00A79C  ori.b  #$28, d0
00A7A0  ori.b  #$2c, d0
00A7A4  ori.b  #$5c, d0
00A7A8  ori.b  #$0, d1
00A7AC  ori.b  #$2c, d0
00A7B0  ori.b  #$30, d0
00A7B4  ori.b  #$68, d0
00A7B8  ori.b  #$0, d1
00A7BC  ori.b  #$30, d0
00A7C0  ori.b  #$34, d0
00A7C4  ori.b  #$74, d0
00A7C8  ori.b  #$0, d1
00A7CC  ori.b  #$34, d0
00A7D0  ori.b  #$38, d0
00A7D4  ori.b  #$80, d0
00A7D8  ori.b  #$0, d1
00A7DC  ori.b  #$38, d0
00A7E0  ori.b  #$3c, d0
00A7E4  ori.b  #$8c, d0
00A7E8  ori.b  #$0, d1
00A7EC  ori.b  #$3c, d0
00A7F0  ori.b  #$40, d0
00A7F4  ori.b  #$98, d0
00A7F8  ori.b  #$0, d1
00A7FC  ori.b  #$40, d0
00A800  ori.b  #$44, d0
00A804  ori.b  #$a4, d0
00A808  ori.b  #$0, d1
00A80C  ori.b  #$44, d0
00A810  ori.b  #$48, d0
00A814  ori.b  #$b0, d0
00A818  ori.b  #$0, d1
00A81C  ori.b  #$48, d0
00A820  ori.b  #$4c, d0
00A824  ori.b  #$bc, d0
00A828  ori.b  #$0, d1
00A82C  ori.b  #$4c, d0
00A830  ori.b  #$50, d0
00A834  ori.b  #$c8, d0
00A838  ori.b  #$0, d1
00A83C  ori.b  #$50, d0
00A840  ori.b  #$54, d0
00A844  ori.b  #$d4, d0
00A848  ori.b  #$0, d1
00A84C  ori.b  #$54, d0
00A850  ori.b  #$58, d0
00A854  ori.b  #$e0, d0
00A858  ori.b  #$0, d1
00A85C  ori.b  #$58, d0
00A860  ori.b  #$5c, d0
00A864  ori.b  #$ec, d0
00A868  ori.b  #$0, d1
00A86C  ori.b  #$5c, d0
00A870  ori.b  #$60, d0
00A874  ori.b  #$f8, d0
00A878  ori.b  #$0, d1
00A87C  ori.b  #$60, d0
00A880  ori.b  #$64, d0
00A884  ori.b  #$84, d0
00A888  ori.b  #$98, d0
00A88C  ori.b  #$ac, d0
00A890  ori.b  #$c0, d0
00A894  ori.b  #$d4, d0
00A898  ori.b  #$e8, d0
00A89C  ori.b  #$fc, d0
00A8A0  ori.b  #$10, d0
00A8A4  ori.b  #$24, d0
00A8A8  ori.b  #$38, d0
00A8AC  ori.b  #$4c, d0
00A8B0  ori.b  #$60, d0
00A8B4  ori.b  #$74, d0
00A8B8  ori.b  #$88, d0
00A8BC  ori.b  #$9c, d0
00A8C0  ori.b  #$b0, d0
00A8C4  ori.b  #$4, d0
00A8C8  ori.b  #$18, d0
00A8CC  ori.b  #$2c, d0
00A8D0  ori.b  #$40, d0
00A8D4  ori.b  #$54, d0
00A8D8  ori.b  #$68, d0
00A8DC  ori.b  #$7c, d0
00A8E0  ori.b  #$90, d0
00A8E4  ori.b  #$64, d0
00A8E8  ori.b  #$78, d0
00A8EC  ori.b  #$8c, d0
00A8F0  ori.b  #$a0, d0
00A8F4  ori.b  #$b4, d0
00A8F8  ori.b  #$c8, d0
00A8FC  ori.b  #$dc, d0
00A900  ori.b  #$f0, d0
00A904  ori.b  #$a4, d0
00A908  ori.b  #$b8, d0
00A90C  ori.b  #$cc, d0
00A910  ori.b  #$e0, d0
00A914  ori.b  #$f4, d0
00A918  ori.b  #$8, d0
00A91C  ori.b  #$1c, d0
00A920  ori.b  #$30, d0
00A924  ori.b  #$44, d0
00A928  ori.b  #$58, d0
00A92C  ori.b  #$6c, d0
00A930  ori.b  #$80, d0
00A934  ori.b  #$94, d0
00A938  ori.b  #$a8, d0
00A93C  ori.b  #$bc, d0
00A940  ori.b  #$d0, d0
00A944  ori.b  #$e4, d0
00A948  ori.b  #$f8, d0
00A94C  ori.b  #$c, d0
00A950  ori.b  #$20, d0
00A954  ori.b  #$34, d0
00A958  ori.b  #$48, d0
00A95C  ori.b  #$5c, d0
00A960  ori.b  #$70, d0
00A964  ori.b  #$2c, d0
00A968  ori.b  #$84, d0
00A96C  ori.b  #$5, d1
00A970  ori.b  #$0, d0
00A974  ori.b  #$0, d0
00A978  ori.b  #$2c, d0
00A97C  ori.b  #$90, d0
00A980  ori.b  #$4, d1
00A984  ori.b  #$0, d0
00A988  ori.b  #$0, d0
00A98C  ori.b  #$2c, d0
00A990  ori.b  #$9c, d0
00A994  ori.b  #$5, d1
00A998  ori.b  #$0, d0
00A99C  ori.b  #$0, d0
00A9A0  ori.b  #$2c, d0
00A9A4  ori.b  #$a8, d0
00A9A8  ori.b  #$4, d1
00A9AC  ori.b  #$0, d0
00A9B0  ori.b  #$0, d0
00A9B4  ori.b  #$2c, d0
00A9B8  ori.b  #$b4, d0
00A9BC  ori.b  #$5, d1
00A9C0  ori.b  #$0, d0
00A9C4  ori.b  #$0, d0
00A9C8  ori.b  #$2c, d0
00A9CC  ori.b  #$c0, d0
00A9D0  ori.b  #$4, d1
00A9D4  ori.b  #$0, d0
00A9D8  ori.b  #$0, d0
00A9DC  ori.b  #$2c, d0
00A9E0  ori.b  #$cc, d0
00A9E4  ori.b  #$5, d1
00A9E8  ori.b  #$0, d0
00A9EC  ori.b  #$0, d0
00A9F0  ori.b  #$2c, d0
00A9F4  ori.b  #$d8, d0
00A9F8  ori.b  #$4, d1
00A9FC  ori.b  #$0, d0
00AA00  ori.b  #$0, d0
00AA04  ori.b  #$2c, d0
00AA08  ori.b  #$24, d0
00AA0C  ori.b  #$5, d1
00AA10  ori.b  #$0, d0
00AA14  ori.b  #$0, d0
00AA18  ori.b  #$2c, d0
00AA1C  ori.b  #$30, d0
00AA20  ori.b  #$4, d1
00AA24  ori.b  #$0, d0
00AA28  ori.b  #$0, d0
00AA2C  ori.b  #$2c, d0
00AA30  ori.b  #$3c, d0
00AA34  ori.b  #$5, d1
00AA38  ori.b  #$0, d0
00AA3C  ori.b  #$0, d0
00AA40  ori.b  #$2c, d0
00AA44  ori.b  #$48, d0
00AA48  ori.b  #$4, d1
00AA4C  ori.b  #$0, d0
00AA50  ori.b  #$0, d0
00AA54  ori.b  #$2c, d0
00AA58  ori.b  #$54, d0
00AA5C  ori.b  #$5, d1
00AA60  ori.b  #$0, d0
00AA64  ori.b  #$0, d0
00AA68  ori.b  #$2c, d0
00AA6C  ori.b  #$60, d0
00AA70  ori.b  #$4, d1
00AA74  ori.b  #$0, d0
00AA78  ori.b  #$0, d0
00AA7C  ori.b  #$2c, d0
00AA80  ori.b  #$6c, d0
00AA84  ori.b  #$5, d1
00AA88  ori.b  #$0, d0
00AA8C  ori.b  #$0, d0
00AA90  ori.b  #$2c, d0
00AA94  ori.b  #$78, d0
00AA98  ori.b  #$4, d1
00AA9C  ori.b  #$0, d0
00AAA0  ori.b  #$0, d0
00AAA4  ori.b  #$2c, d0
00AAA8  ori.b  #$e4, d0
00AAAC  ori.b  #$4, d1
00AAB0  ori.b  #$0, d0
00AAB4  ori.b  #$0, d0
00AAB8  ori.b  #$2c, d0
00AABC  ori.b  #$f0, d0
00AAC0  ori.b  #$5, d1
00AAC4  ori.b  #$0, d0
00AAC8  ori.b  #$0, d0
00AACC  ori.b  #$2c, d0
00AAD0  ori.b  #$fc, d0
00AAD4  ori.b  #$4, d1
00AAD8  ori.b  #$0, d0
00AADC  ori.b  #$0, d0
00AAE0  ori.b  #$2c, d0
00AAE4  ori.b  #$8, d0
00AAE8  ori.b  #$5, d1
00AAEC  ori.b  #$0, d0
00AAF0  ori.b  #$0, d0
00AAF4  ori.b  #$2c, d0
00AAF8  ori.b  #$14, d0
00AAFC  ori.b  #$4, d1
00AB00  ori.b  #$0, d0
00AB04  ori.b  #$0, d0
00AB08  ori.b  #$2c, d0
00AB0C  ori.b  #$20, d0
00AB10  ori.b  #$5, d1
00AB14  ori.b  #$0, d0
00AB18  ori.b  #$0, d0
00AB1C  ori.b  #$2c, d0
00AB20  ori.b  #$2c, d0
00AB24  ori.b  #$4, d1
00AB28  ori.b  #$0, d0
00AB2C  ori.b  #$0, d0
00AB30  ori.b  #$2c, d0
00AB34  ori.b  #$38, d0
00AB38  ori.b  #$5, d1
00AB3C  ori.b  #$0, d0
00AB40  ori.b  #$0, d0
00AB44  ori.b  #$2c, d0
00AB48  ori.b  #$44, d0
00AB4C  ori.b  #$4, d1
00AB50  ori.b  #$0, d0
00AB54  ori.b  #$0, d0
00AB58  ori.b  #$2c, d0
00AB5C  ori.b  #$50, d0
00AB60  ori.b  #$5, d1
00AB64  ori.b  #$0, d0
00AB68  ori.b  #$0, d0
00AB6C  ori.b  #$2c, d0
00AB70  ori.b  #$5c, d0
00AB74  ori.b  #$4, d1
00AB78  ori.b  #$0, d0
00AB7C  ori.b  #$0, d0
00AB80  ori.b  #$2c, d0
00AB84  ori.b  #$68, d0
00AB88  ori.b  #$5, d1
00AB8C  ori.b  #$0, d0
00AB90  ori.b  #$0, d0
00AB94  ori.b  #$2c, d0
00AB98  ori.b  #$74, d0
00AB9C  ori.b  #$4, d1
00ABA0  ori.b  #$0, d0
00ABA4  ori.b  #$0, d0
00ABA8  ori.b  #$2c, d0
00ABAC  ori.b  #$80, d0
00ABB0  ori.b  #$5, d1
00ABB4  ori.b  #$0, d0
00ABB8  ori.b  #$0, d0
00ABBC  ori.b  #$2c, d0
00ABC0  ori.b  #$8c, d0
00ABC4  ori.b  #$4, d1
00ABC8  ori.b  #$0, d0
00ABCC  ori.b  #$0, d0
00ABD0  ori.b  #$2c, d0
00ABD4  ori.b  #$98, d0
00ABD8  ori.b  #$5, d1
00ABDC  ori.b  #$0, d0
00ABE0  ori.b  #$0, d0
00ABE4  ori.b  #$2c, d0
00ABE8  ori.b  #$a4, d0
00ABEC  ori.b  #$3, d1
00ABF0  ori.b  #$0, d0
00ABF4  ori.b  #$0, d0
00ABF8  ori.b  #$2c, d0
00ABFC  ori.b  #$b0, d0
00AC00  ori.b  #$2, d1
00AC04  ori.b  #$0, d0
00AC08  ori.b  #$0, d0
00AC0C  ori.b  #$2c, d0
00AC10  ori.b  #$bc, d0
00AC14  ori.b  #$3, d1
00AC18  ori.b  #$0, d0
00AC1C  ori.b  #$0, d0
00AC20  ori.b  #$2c, d0
00AC24  ori.b  #$c8, d0
00AC28  ori.b  #$2, d1
00AC2C  ori.b  #$0, d0
00AC30  ori.b  #$0, d0
00AC34  ori.b  #$2c, d0
00AC38  ori.b  #$d4, d0
00AC3C  ori.b  #$3, d1
00AC40  ori.b  #$0, d0
00AC44  ori.b  #$0, d0
00AC48  ori.b  #$2c, d0
00AC4C  ori.b  #$e0, d0
00AC50  ori.b  #$2, d1
00AC54  ori.b  #$0, d0
00AC58  ori.b  #$0, d0
00AC5C  ori.b  #$2c, d0
00AC60  ori.b  #$ec, d0
00AC64  ori.b  #$3, d1
00AC68  ori.b  #$0, d0
00AC6C  ori.b  #$0, d0
00AC70  ori.b  #$2c, d0
00AC74  ori.b  #$f8, d0
00AC78  ori.b  #$2, d1
00AC7C  ori.b  #$0, d0
00AC80  ori.b  #$0, d0
00AC84  ori.b  #$2c, d0
00AC88  ori.b  #$64, d0
00AC8C  ori.b  #$1, d1
00AC90  ori.b  #$0, d0
00AC94  ori.b  #$0, d0
00AC98  ori.b  #$2c, d0
00AC9C  ori.b  #$70, d0
00ACA0  ori.b  #$2, d1
00ACA4  ori.b  #$0, d0
00ACA8  ori.b  #$0, d0
00ACAC  ori.b  #$2c, d0
00ACB0  ori.b  #$7c, d0
00ACB4  ori.b  #$1, d1
00ACB8  ori.b  #$0, d0
00ACBC  ori.b  #$0, d0
00ACC0  ori.b  #$2c, d0
00ACC4  ori.b  #$88, d0
00ACC8  ori.b  #$2, d1
00ACCC  ori.b  #$0, d0
00ACD0  ori.b  #$0, d0
00ACD4  ori.b  #$2c, d0
00ACD8  ori.b  #$94, d0
00ACDC  ori.b  #$1, d1
00ACE0  ori.b  #$0, d0
00ACE4  ori.b  #$0, d0
00ACE8  ori.b  #$2c, d0
00ACEC  ori.b  #$a0, d0
00ACF0  ori.b  #$2, d1
00ACF4  ori.b  #$0, d0
00ACF8  ori.b  #$0, d0
00ACFC  ori.b  #$2c, d0
00AD00  ori.b  #$ac, d0
00AD04  ori.b  #$1, d1
00AD08  ori.b  #$0, d0
00AD0C  ori.b  #$0, d0
00AD10  ori.b  #$2c, d0
00AD14  ori.b  #$b8, d0
00AD18  ori.b  #$2, d1
00AD1C  ori.b  #$0, d0
00AD20  ori.b  #$0, d0
00AD24  ori.b  #$2c, d0
00AD28  ori.b  #$c4, d0
00AD2C  ori.b  #$1, d1
00AD30  ori.b  #$0, d0
00AD34  ori.b  #$0, d0
00AD38  ori.b  #$2c, d0
00AD3C  ori.b  #$d0, d0
00AD40  ori.b  #$2, d1
00AD44  ori.b  #$0, d0
00AD48  ori.b  #$0, d0
00AD4C  ori.b  #$2c, d0
00AD50  ori.b  #$dc, d0
00AD54  ori.b  #$1, d1
00AD58  ori.b  #$0, d0
00AD5C  ori.b  #$0, d0
00AD60  ori.b  #$2c, d0
00AD64  ori.b  #$e8, d0
00AD68  ori.b  #$2, d1
00AD6C  ori.b  #$0, d0
00AD70  ori.b  #$0, d0
00AD74  ori.b  #$2c, d0
00AD78  ori.b  #$f4, d0
00AD7C  ori.b  #$1, d1
00AD80  ori.b  #$0, d0
00AD84  ori.b  #$0, d0
00AD88  ori.b  #$2c, d0
00AD8C  ori.b  #$0, d0
00AD90  ori.b  #$2, d1
00AD94  ori.b  #$0, d0
00AD98  ori.b  #$0, d0
00AD9C  ori.b  #$2c, d0
00ADA0  ori.b  #$c, d0
00ADA4  ori.b  #$1, d1
00ADA8  ori.b  #$0, d0
00ADAC  ori.b  #$0, d0
00ADB0  ori.b  #$2c, d0
00ADB4  ori.b  #$18, d0
00ADB8  ori.b  #$2, d1
00ADBC  ori.b  #$0, d0
00ADC0  ori.b  #$0, d0
00ADC4  ori.b  #$b8, d5
00ADC8  ori.b  #$ac, d5
00ADCC  ori.b  #$ec, d5
00ADD0  ori.b  #$b8, d5
00ADD4  ori.b  #$c4, d5
00ADD8  ori.b  #$b8, d5
00ADDC  ori.b  #$ec, d5
00ADE0  ori.b  #$c4, d5
00ADE4  ori.b  #$d0, d5
00ADE8  ori.b  #$c4, d5
00ADEC  ori.b  #$ec, d5
00ADF0  ori.b  #$d0, d5
00ADF4  ori.b  #$dc, d5
00ADF8  ori.b  #$d0, d5
00ADFC  ori.b  #$ec, d5
00AE00  ori.b  #$dc, d5
00AE04  ori.b  #$e8, d5
00AE08  ori.b  #$dc, d5
00AE0C  ori.b  #$ec, d5
00AE10  ori.b  #$e8, d5
00AE14  ori.b  #$f4, d5
00AE18  ori.b  #$e8, d5
00AE1C  ori.b  #$ec, d5
00AE20  ori.b  #$f4, d5
00AE24  ori.b  #$0, d5
00AE28  ori.b  #$f4, d5
00AE2C  ori.b  #$ec, d5
00AE30  ori.b  #$0, d5
00AE34  ori.b  #$ac, d5
00AE38  ori.b  #$0, d5
00AE3C  ori.b  #$ec, d5
00AE40  ori.b  #$ac, d5
00AE44  ori.b  #$c, d5
00AE48  ori.b  #$18, d5
00AE4C  ori.b  #$f8, d5
00AE50  ori.b  #$c, d5
00AE54  ori.b  #$18, d5
00AE58  ori.b  #$24, d5
00AE5C  ori.b  #$f8, d5
00AE60  ori.b  #$18, d5
00AE64  ori.b  #$24, d5
00AE68  ori.b  #$30, d5
00AE6C  ori.b  #$f8, d5
00AE70  ori.b  #$24, d5
00AE74  ori.b  #$30, d5
00AE78  ori.b  #$3c, d5
00AE7C  ori.b  #$f8, d5
00AE80  ori.b  #$30, d5
00AE84  ori.b  #$3c, d5
00AE88  ori.b  #$48, d5
00AE8C  ori.b  #$f8, d5
00AE90  ori.b  #$3c, d5
00AE94  ori.b  #$48, d5
00AE98  ori.b  #$54, d5
00AE9C  ori.b  #$f8, d5
00AEA0  ori.b  #$48, d5
00AEA4  ori.b  #$54, d5
00AEA8  ori.b  #$60, d5
00AEAC  ori.b  #$f8, d5
00AEB0  ori.b  #$54, d5
00AEB4  ori.b  #$60, d5
00AEB8  ori.b  #$c, d5
00AEBC  ori.b  #$f8, d5
00AEC0  ori.b  #$60, d5
00AEC4  ori.b  #$ac, d5
00AEC8  ori.b  #$b8, d5
00AECC  ori.b  #$78, d5
00AED0  ori.b  #$6c, d5
00AED4  ori.b  #$ac, d5
00AED8  ori.b  #$b8, d5
00AEDC  ori.b  #$c4, d5
00AEE0  ori.b  #$84, d5
00AEE4  ori.b  #$78, d5
00AEE8  ori.b  #$b8, d5
00AEEC  ori.b  #$c4, d5
00AEF0  ori.b  #$d0, d5
00AEF4  ori.b  #$90, d5
00AEF8  ori.b  #$84, d5
00AEFC  ori.b  #$c4, d5
00AF00  ori.b  #$d0, d5
00AF04  ori.b  #$dc, d5
00AF08  ori.b  #$9c, d5
00AF0C  ori.b  #$90, d5
00AF10  ori.b  #$d0, d5
00AF14  ori.b  #$dc, d5
00AF18  ori.b  #$e8, d5
00AF1C  ori.b  #$a8, d5
00AF20  ori.b  #$9c, d5
00AF24  ori.b  #$dc, d5
00AF28  ori.b  #$e8, d5
00AF2C  ori.b  #$f4, d5
00AF30  ori.b  #$b4, d5
00AF34  ori.b  #$a8, d5
00AF38  ori.b  #$e8, d5
00AF3C  ori.b  #$f4, d5
00AF40  ori.b  #$0, d5
00AF44  ori.b  #$c0, d5
00AF48  ori.b  #$b4, d5
00AF4C  ori.b  #$f4, d5
00AF50  ori.b  #$0, d5
00AF54  ori.b  #$ac, d5
00AF58  ori.b  #$6c, d5
00AF5C  ori.b  #$c0, d5
00AF60  ori.b  #$0, d5
00AF64  ori.b  #$d8, d5
00AF68  ori.b  #$18, d5
00AF6C  ori.b  #$c, d5
00AF70  ori.b  #$cc, d5
00AF74  ori.b  #$d8, d5
00AF78  ori.b  #$e4, d5
00AF7C  ori.b  #$24, d5
00AF80  ori.b  #$18, d5
00AF84  ori.b  #$d8, d5
00AF88  ori.b  #$e4, d5
00AF8C  ori.b  #$f0, d5
00AF90  ori.b  #$30, d5
00AF94  ori.b  #$24, d5
00AF98  ori.b  #$e4, d5
00AF9C  ori.b  #$f0, d5
00AFA0  ori.b  #$fc, d5
00AFA4  ori.b  #$3c, d5
00AFA8  ori.b  #$30, d5
00AFAC  ori.b  #$f0, d5
00AFB0  ori.b  #$fc, d5
00AFB4  ori.b  #$8, d5
00AFB8  ori.b  #$48, d5
00AFBC  ori.b  #$3c, d5
00AFC0  ori.b  #$fc, d5
00AFC4  ori.b  #$8, d5
00AFC8  ori.b  #$14, d5
00AFCC  ori.b  #$54, d5
00AFD0  ori.b  #$48, d5
00AFD4  ori.b  #$8, d5
00AFD8  ori.b  #$14, d5
00AFDC  ori.b  #$20, d5
00AFE0  ori.b  #$60, d5
00AFE4  ori.b  #$54, d5
00AFE8  ori.b  #$14, d5
00AFEC  ori.b  #$20, d5
00AFF0  ori.b  #$cc, d5
00AFF4  ori.b  #$c, d5
00AFF8  ori.b  #$60, d5
00AFFC  ori.b  #$20, d5
00B000  ori.b  #$cc, d5
00B004  ori.b  #$78, d5
00B008  ori.b  #$38, d5
00B00C  ori.b  #$2c, d5
00B010  ori.b  #$6c, d5
00B014  ori.b  #$78, d5
00B018  ori.b  #$84, d5
00B01C  ori.b  #$44, d5
00B020  ori.b  #$38, d5
00B024  ori.b  #$78, d5
00B028  ori.b  #$84, d5
00B02C  ori.b  #$90, d5
00B030  ori.b  #$50, d5
00B034  ori.b  #$44, d5
00B038  ori.b  #$84, d5
00B03C  ori.b  #$90, d5
00B040  ori.b  #$9c, d5
00B044  ori.b  #$5c, d5
00B048  ori.b  #$50, d5
00B04C  ori.b  #$90, d5
00B050  ori.b  #$9c, d5
00B054  ori.b  #$a8, d5
00B058  ori.b  #$68, d5
00B05C  ori.b  #$5c, d5
00B060  ori.b  #$9c, d5
00B064  ori.b  #$a8, d5
00B068  ori.b  #$b4, d5
00B06C  ori.b  #$74, d5
00B070  ori.b  #$68, d5
00B074  ori.b  #$a8, d5
00B078  ori.b  #$b4, d5
00B07C  ori.b  #$c0, d5
00B080  ori.b  #$80, d5
00B084  ori.b  #$74, d5
00B088  ori.b  #$b4, d5
00B08C  ori.b  #$c0, d5
00B090  ori.b  #$6c, d5
00B094  ori.b  #$2c, d5
00B098  ori.b  #$80, d5
00B09C  ori.b  #$c0, d5
00B0A0  ori.b  #$6c, d5
00B0A4  ori.b  #$8c, d5
00B0A8  ori.b  #$98, d5
00B0AC  ori.b  #$d8, d5
00B0B0  ori.b  #$cc, d5
00B0B4  ori.b  #$8c, d5
00B0B8  ori.b  #$98, d5
00B0BC  ori.b  #$a4, d5
00B0C0  ori.b  #$e4, d5
00B0C4  ori.b  #$d8, d5
00B0C8  ori.b  #$98, d5
00B0CC  ori.b  #$a4, d5
00B0D0  ori.b  #$b0, d5
00B0D4  ori.b  #$f0, d5
00B0D8  ori.b  #$e4, d5
00B0DC  ori.b  #$a4, d5
00B0E0  ori.b  #$b0, d5
00B0E4  ori.b  #$bc, d5
00B0E8  ori.b  #$fc, d5
00B0EC  ori.b  #$f0, d5
00B0F0  ori.b  #$b0, d5
00B0F4  ori.b  #$bc, d5
00B0F8  ori.b  #$c8, d5
00B0FC  ori.b  #$8, d5
00B100  ori.b  #$fc, d5
00B104  ori.b  #$bc, d5
00B108  ori.b  #$c8, d5
00B10C  ori.b  #$d4, d5
00B110  ori.b  #$14, d5
00B114  ori.b  #$8, d5
00B118  ori.b  #$c8, d5
00B11C  ori.b  #$d4, d5
00B120  ori.b  #$e0, d5
00B124  ori.b  #$20, d5
00B128  ori.b  #$14, d5
00B12C  ori.b  #$d4, d5
00B130  ori.b  #$e0, d5
00B134  ori.b  #$8c, d5
00B138  ori.b  #$cc, d5
00B13C  ori.b  #$20, d5
00B140  ori.b  #$e0, d5
00B144  ori.b  #$38, d5
00B148  ori.b  #$98, d5
00B14C  ori.b  #$8c, d5
00B150  ori.b  #$2c, d5
00B154  ori.b  #$38, d5
00B158  ori.b  #$44, d5
00B15C  ori.b  #$a4, d5
00B160  ori.b  #$98, d5
00B164  ori.b  #$38, d5
00B168  ori.b  #$44, d5
00B16C  ori.b  #$50, d5
00B170  ori.b  #$b0, d5
00B174  ori.b  #$a4, d5
00B178  ori.b  #$44, d5
00B17C  ori.b  #$50, d5
00B180  ori.b  #$5c, d5
00B184  ori.b  #$bc, d5
00B188  ori.b  #$b0, d5
00B18C  ori.b  #$50, d5
00B190  ori.b  #$5c, d5
00B194  ori.b  #$68, d5
00B198  ori.b  #$c8, d5
00B19C  ori.b  #$bc, d5
00B1A0  ori.b  #$5c, d5
00B1A4  ori.b  #$68, d5
00B1A8  ori.b  #$74, d5
00B1AC  ori.b  #$d4, d5
00B1B0  ori.b  #$c8, d5
00B1B4  ori.b  #$68, d5
00B1B8  ori.b  #$74, d5
00B1BC  ori.b  #$80, d5
00B1C0  ori.b  #$e0, d5
00B1C4  ori.b  #$d4, d5
00B1C8  ori.b  #$74, d5
00B1CC  ori.b  #$80, d5
00B1D0  ori.b  #$2c, d5
00B1D4  ori.b  #$8c, d5
00B1D8  ori.b  #$e0, d5
00B1DC  ori.b  #$80, d5
00B1E0  ori.b  #$2c, d5
00B1E4  ori.b  #$0, d0
00B1E8  ori.b  #$48, d0
00B1EC  ori.b  #$44, d0
00B1F0  ori.b  #$ac, d0
00B1F4  ; data: 0x00, 0x0c
00B1F6  ori.b  #$15, (a5)
00B1FA  ori.b  #$15, (a6)+
00B1FE  ori.b  #$0, d0
00B202  dc.w   $f254
00B204  ori.b  #$44, d0
00B208  dc.w   $fc18
00B20A  ori.b  #$1c, d0
00B20E  dc.w   $fc18
00B210  ori.b  #$50, d0
00B214  bset.b d0, (a4, d0.w)
00B218  dc.w   $f830
00B21A  bclr.b d5, $0.w
00B21E  ori.b  #$dc, d0
00B222  ori.b  #$d0, d0
00B226  bclr.b d5, $0.w
00B22A  subi.l #$1f40000, -$1c(a0, d0.l)
00B232  dc.w   $fc18
00B234  ori.b  #$bc, d0
00B238  dc.w   $fc18
00B23A  ori.b  #$0, d0
00B23E  ori.b  #$44, d0
00B242  ori.b  #$0, d0
00B246  ; data: 0x02, 0xbc
00B248  ori.b  #$3, d3
00B24C  ori.b  #$4, d0
00B250  ori.b  #$4, d0
00B254  ori.b  #$3, d3
00B258  ori.b  #$14, d0
00B25C  ori.b  #$14, d0
00B260  ori.b  #$3, d3
00B264  ori.b  #$24, d0
00B268  ori.b  #$24, d0
00B26C  ori.b  #$3, d3
00B270  ori.b  #$34, d0
00B274  ori.b  #$34, d0
00B278  ori.b  #$3, d3
00B27C  ori.b  #$44, d0
00B280  ori.b  #$44, d0
00B284  ori.b  #$3, d3
00B288  ori.b  #$54, d0
00B28C  ori.b  #$54, d0
00B290  ori.b  #$3, d3
00B294  ori.b  #$64, d0
00B298  ori.b  #$64, d0
00B29C  ori.b  #$3, d3
00B2A0  ori.b  #$74, d0
00B2A4  ori.b  #$74, d0
00B2A8  ori.b  #$3, d3
00B2AC  ori.b  #$84, d0
00B2B0  ori.b  #$84, d0
00B2B4  ori.b  #$3, d3
00B2B8  ori.b  #$94, d0
00B2BC  ori.b  #$94, d0
00B2C0  ori.b  #$3, d3
00B2C4  ori.b  #$a4, d0
00B2C8  ori.b  #$a4, d0
00B2CC  ori.b  #$3, d3
00B2D0  ori.b  #$b4, d0
00B2D4  ori.b  #$b4, d0
00B2D8  ori.b  #$3, d3
00B2DC  ori.b  #$c4, d0
00B2E0  ori.b  #$c4, d0
00B2E4  ori.b  #$3, d3
00B2E8  ori.b  #$d4, d0
00B2EC  ori.b  #$d4, d0
00B2F0  ori.b  #$3, d3
00B2F4  ori.b  #$e4, d0
00B2F8  ori.b  #$e4, d0
00B2FC  ori.b  #$3, d3
00B300  ori.b  #$f4, d0
00B304  ori.b  #$f4, d0
00B308  ori.b  #$3, d3
00B30C  ori.b  #$4, d0
00B310  ori.b  #$4, d0
00B314  ori.b  #$3, d3
00B318  ori.b  #$14, d0
00B31C  ori.b  #$14, d0
00B320  ori.b  #$3, d3
00B324  ori.b  #$24, d0
00B328  ori.b  #$24, d0
00B32C  ori.b  #$3, d3
00B330  ori.b  #$34, d0
00B334  ori.b  #$34, d0
00B338  ori.b  #$3, d3
00B33C  ori.b  #$44, d0
00B340  ori.b  #$44, d0
00B344  ori.b  #$48, d0
00B348  ori.b  #$0, d2
00B34C  ori.b  #$94, d0
00B350  ori.b  #$9c, d0
00B354  ori.b  #$54, d0
00B358  ori.b  #$0, d2
00B35C  ori.b  #$9c, d0
00B360  ori.b  #$a4, d0
00B364  ori.b  #$60, d0
00B368  ori.b  #$0, d2
00B36C  ori.b  #$a4, d0
00B370  ori.b  #$ac, d0
00B374  ori.b  #$6c, d0
00B378  ori.b  #$0, d2
00B37C  ori.b  #$ac, d0
00B380  ori.b  #$b4, d0
00B384  ori.b  #$78, d0
00B388  ori.b  #$0, d2
00B38C  ori.b  #$b4, d0
00B390  ori.b  #$bc, d0
00B394  ori.b  #$84, d0
00B398  ori.b  #$0, d2
00B39C  ori.b  #$bc, d0
00B3A0  ori.b  #$c4, d0
00B3A4  ori.b  #$90, d0
00B3A8  ori.b  #$0, d2
00B3AC  ori.b  #$c4, d0
00B3B0  ori.b  #$cc, d0
00B3B4  ori.b  #$9c, d0
00B3B8  ori.b  #$0, d2
00B3BC  ori.b  #$cc, d0
00B3C0  ori.b  #$d4, d0
00B3C4  ori.b  #$a8, d0
00B3C8  ori.b  #$0, d2
00B3CC  ori.b  #$d4, d0
00B3D0  ori.b  #$dc, d0
00B3D4  ori.b  #$b4, d0
00B3D8  ori.b  #$0, d2
00B3DC  ori.b  #$dc, d0
00B3E0  ori.b  #$e4, d0
00B3E4  ori.b  #$c0, d0
00B3E8  ori.b  #$0, d1
00B3EC  ori.b  #$e4, d0
00B3F0  ori.b  #$e8, d0
00B3F4  ori.b  #$cc, d0
00B3F8  ori.b  #$0, d1
00B3FC  ori.b  #$e8, d0
00B400  ori.b  #$ec, d0
00B404  ori.b  #$d8, d0
00B408  ori.b  #$0, d1
00B40C  ori.b  #$ec, d0
00B410  ori.b  #$f0, d0
00B414  ori.b  #$e4, d0
00B418  ori.b  #$0, d1
00B41C  ori.b  #$f0, d0
00B420  ori.b  #$f4, d0
00B424  ori.b  #$f0, d0
00B428  ori.b  #$0, d1
00B42C  ori.b  #$f4, d0
00B430  ori.b  #$f8, d0
00B434  ori.b  #$fc, d0
00B438  ori.b  #$0, d1
00B43C  ori.b  #$f8, d0
00B440  ori.b  #$fc, d0
00B444  ori.b  #$8, d0
00B448  ori.b  #$0, d1
00B44C  ori.b  #$fc, d0
00B450  ori.b  #$0, d0
00B454  ori.b  #$14, d0
00B458  ori.b  #$0, d1
00B45C  ori.b  #$0, d0
00B460  ori.b  #$4, d0
00B464  ori.b  #$20, d0
00B468  ori.b  #$0, d1
00B46C  ori.b  #$4, d0
00B470  ori.b  #$8, d0
00B474  ori.b  #$2c, d0
00B478  ori.b  #$0, d1
00B47C  ori.b  #$8, d0
00B480  ori.b  #$c, d0
00B484  ori.b  #$38, d0
00B488  ori.b  #$14, (a4)
00B48C  ori.b  #$c, d0
00B490  ori.b  #$5c, d0
00B494  ori.b  #$3c, d0
00B498  ori.b  #$ac, d0
00B49C  ori.b  #$50, d0
00B4A0  ori.b  #$c0, d0
00B4A4  ori.b  #$64, d0
00B4A8  ori.b  #$d4, d0
00B4AC  ori.b  #$78, d0
00B4B0  ori.b  #$e8, d0
00B4B4  ori.b  #$8c, d0
00B4B8  ori.b  #$fc, d0
00B4BC  ori.b  #$a0, d0
00B4C0  ori.b  #$10, d0
00B4C4  ori.b  #$b4, d0
00B4C8  ori.b  #$24, d0
00B4CC  ori.b  #$c8, d0
00B4D0  ori.b  #$38, d0
00B4D4  ori.b  #$dc, d0
00B4D8  ori.b  #$4c, d0
00B4DC  ori.b  #$f0, d0
00B4E0  ori.b  #$60, d0
00B4E4  ori.b  #$74, d0
00B4E8  ori.b  #$88, d0
00B4EC  ori.b  #$9c, d0
00B4F0  ori.b  #$b0, d0
00B4F4  ori.b  #$c4, d0
00B4F8  ori.b  #$d8, d0
00B4FC  ori.b  #$ec, d0
00B500  ori.b  #$0, d0
00B504  ori.b  #$14, d0
00B508  ori.b  #$28, d0
00B50C  ori.b  #$60, d0
00B510  ori.b  #$60, d0
00B514  ori.b  #$4c, d0
00B518  ori.b  #$4c, d0
00B51C  ori.b  #$38, d0
00B520  ori.b  #$38, d0
00B524  ori.b  #$24, d0
00B528  ori.b  #$24, d0
00B52C  ori.b  #$10, d0
00B530  ori.b  #$10, d0
00B534  ori.b  #$fc, d0
00B538  ori.b  #$fc, d0
00B53C  ori.b  #$e8, d0
00B540  ori.b  #$e8, d0
00B544  ori.b  #$d4, d0
00B548  ori.b  #$d4, d0
00B54C  ori.b  #$c0, d0
00B550  ori.b  #$c0, d0
00B554  ori.b  #$ac, d0
00B558  ori.b  #$ac, d0
00B55C  ori.b  #$f0, d0
00B560  ori.b  #$f0, d0
00B564  ori.b  #$dc, d0
00B568  ori.b  #$dc, d0
00B56C  ori.b  #$c8, d0
00B570  ori.b  #$c8, d0
00B574  ori.b  #$b4, d0
00B578  ori.b  #$b4, d0
00B57C  ori.b  #$a0, d0
00B580  ori.b  #$a0, d0
00B584  ori.b  #$8c, d0
00B588  ori.b  #$8c, d0
00B58C  ori.b  #$78, d0
00B590  ori.b  #$78, d0
00B594  ori.b  #$64, d0
00B598  ori.b  #$64, d0
00B59C  ori.b  #$50, d0
00B5A0  ori.b  #$50, d0
00B5A4  ori.b  #$3c, d0
00B5A8  ori.b  #$3c, d0
00B5AC  ori.b  #$2c, d0
00B5B0  ori.b  #$48, d0
00B5B4  ori.b  #$5, d1
00B5B8  ori.b  #$0, d0
00B5BC  ori.b  #$0, d0
00B5C0  ori.b  #$2c, d0
00B5C4  ori.b  #$54, d0
00B5C8  ori.b  #$4, d1
00B5CC  ori.b  #$0, d0
00B5D0  ori.b  #$0, d0
00B5D4  ori.b  #$2c, d0
00B5D8  ori.b  #$60, d0
00B5DC  ori.b  #$5, d1
00B5E0  ori.b  #$0, d0
00B5E4  ori.b  #$0, d0
00B5E8  ori.b  #$2c, d0
00B5EC  ori.b  #$6c, d0
00B5F0  ori.b  #$4, d1
00B5F4  ori.b  #$0, d0
00B5F8  ori.b  #$0, d0
00B5FC  ori.b  #$2c, d0
00B600  ori.b  #$78, d0
00B604  ori.b  #$5, d1
00B608  ori.b  #$0, d0
00B60C  ori.b  #$0, d0
00B610  ori.b  #$2c, d0
00B614  ori.b  #$84, d0
00B618  ori.b  #$4, d1
00B61C  ori.b  #$0, d0
00B620  ori.b  #$0, d0
00B624  ori.b  #$2c, d0
00B628  ori.b  #$90, d0
00B62C  ori.b  #$5, d1
00B630  ori.b  #$0, d0
00B634  ori.b  #$0, d0
00B638  ori.b  #$2c, d0
00B63C  ori.b  #$9c, d0
00B640  ori.b  #$4, d1
00B644  ori.b  #$0, d0
00B648  ori.b  #$0, d0
00B64C  ori.b  #$2c, d0
00B650  ori.b  #$a8, d0
00B654  ori.b  #$5, d1
00B658  ori.b  #$0, d0
00B65C  ori.b  #$0, d0
00B660  ori.b  #$2c, d0
00B664  ori.b  #$b4, d0
00B668  ori.b  #$4, d1
00B66C  ori.b  #$0, d0
00B670  ori.b  #$0, d0
00B674  ori.b  #$2c, d0
00B678  ori.b  #$c0, d0
00B67C  ori.b  #$1, d1
00B680  ori.b  #$0, d0
00B684  ori.b  #$0, d0
00B688  ori.b  #$2c, d0
00B68C  ori.b  #$cc, d0
00B690  ori.b  #$2, d1
00B694  ori.b  #$0, d0
00B698  ori.b  #$0, d0
00B69C  ori.b  #$2c, d0
00B6A0  ori.b  #$d8, d0
00B6A4  ori.b  #$1, d1
00B6A8  ori.b  #$0, d0
00B6AC  ori.b  #$0, d0
00B6B0  ori.b  #$2c, d0
00B6B4  ori.b  #$e4, d0
00B6B8  ori.b  #$2, d1
00B6BC  ori.b  #$0, d0
00B6C0  ori.b  #$0, d0
00B6C4  ori.b  #$2c, d0
00B6C8  ori.b  #$f0, d0
00B6CC  ori.b  #$1, d1
00B6D0  ori.b  #$0, d0
00B6D4  ori.b  #$0, d0
00B6D8  ori.b  #$2c, d0
00B6DC  ori.b  #$fc, d0
00B6E0  ori.b  #$2, d1
00B6E4  ori.b  #$0, d0
00B6E8  ori.b  #$0, d0
00B6EC  ori.b  #$2c, d0
00B6F0  ori.b  #$8, d0
00B6F4  ori.b  #$1, d1
00B6F8  ori.b  #$0, d0
00B6FC  ori.b  #$0, d0
00B700  ori.b  #$2c, d0
00B704  ori.b  #$14, d0
00B708  ori.b  #$2, d1
00B70C  ori.b  #$0, d0
00B710  ori.b  #$0, d0
00B714  ori.b  #$2c, d0
00B718  ori.b  #$20, d0
00B71C  ori.b  #$1, d1
00B720  ori.b  #$0, d0
00B724  ori.b  #$0, d0
00B728  ori.b  #$2c, d0
00B72C  ori.b  #$2c, d0
00B730  ori.b  #$2, d1
00B734  ori.b  #$0, d0
00B738  ori.b  #$0, d0
00B73C  ori.b  #$2c, d0
00B740  ori.b  #$48, d0
00B744  ori.b  #$5, d1
00B748  ori.b  #$0, d0
00B74C  ori.b  #$0, d0
00B750  ori.b  #$2c, d0
00B754  ori.b  #$54, d0
00B758  ori.b  #$4, d1
00B75C  ori.b  #$0, d0
00B760  ori.b  #$0, d0
00B764  ori.b  #$2c, d0
00B768  ori.b  #$60, d0
00B76C  ori.b  #$5, d1
00B770  ori.b  #$0, d0
00B774  ori.b  #$0, d0
00B778  ori.b  #$2c, d0
00B77C  ori.b  #$6c, d0
00B780  ori.b  #$4, d1
00B784  ori.b  #$0, d0
00B788  ori.b  #$0, d0
00B78C  ori.b  #$2c, d0
00B790  ori.b  #$78, d0
00B794  ori.b  #$5, d1
00B798  ori.b  #$0, d0
00B79C  ori.b  #$0, d0
00B7A0  ori.b  #$2c, d0
00B7A4  ori.b  #$84, d0
00B7A8  ori.b  #$4, d1
00B7AC  ori.b  #$0, d0
00B7B0  ori.b  #$0, d0
00B7B4  ori.b  #$2c, d0
00B7B8  ori.b  #$90, d0
00B7BC  ori.b  #$5, d1
00B7C0  ori.b  #$0, d0
00B7C4  ori.b  #$0, d0
00B7C8  ori.b  #$2c, d0
00B7CC  ori.b  #$9c, d0
00B7D0  ori.b  #$4, d1
00B7D4  ori.b  #$0, d0
00B7D8  ori.b  #$0, d0
00B7DC  ori.b  #$2c, d0
00B7E0  ori.b  #$a8, d0
00B7E4  ori.b  #$5, d1
00B7E8  ori.b  #$0, d0
00B7EC  ori.b  #$0, d0
00B7F0  ori.b  #$2c, d0
00B7F4  ori.b  #$b4, d0
00B7F8  ori.b  #$4, d1
00B7FC  ori.b  #$0, d0
00B800  ori.b  #$0, d0
00B804  ori.b  #$ac, d5
00B808  ori.b  #$24, d5
00B80C  ori.b  #$b8, d5
00B810  ori.b  #$ac, d5
00B814  ori.b  #$b8, d5
00B818  ori.b  #$24, d5
00B81C  ori.b  #$c4, d5
00B820  ori.b  #$b8, d5
00B824  ori.b  #$c4, d5
00B828  ori.b  #$24, d5
00B82C  ori.b  #$d0, d5
00B830  ori.b  #$c4, d5
00B834  ori.b  #$d0, d5
00B838  ori.b  #$24, d5
00B83C  ori.b  #$dc, d5
00B840  ori.b  #$d0, d5
00B844  ori.b  #$dc, d5
00B848  ori.b  #$24, d5
00B84C  ori.b  #$e8, d5
00B850  ori.b  #$dc, d5
00B854  ori.b  #$e8, d5
00B858  ori.b  #$24, d5
00B85C  ori.b  #$f4, d5
00B860  ori.b  #$e8, d5
00B864  ori.b  #$f4, d5
00B868  ori.b  #$24, d5
00B86C  ori.b  #$0, d5
00B870  ori.b  #$f4, d5
00B874  ori.b  #$0, d5
00B878  ori.b  #$24, d5
00B87C  ori.b  #$c, d5
00B880  ori.b  #$0, d5
00B884  ori.b  #$c, d5
00B888  ori.b  #$24, d5
00B88C  ori.b  #$18, d5
00B890  ori.b  #$c, d5
00B894  ori.b  #$18, d5
00B898  ori.b  #$24, d5
00B89C  ori.b  #$ac, d5
00B8A0  ori.b  #$18, d5
00B8A4  ori.b  #$b8, d5
00B8A8  ori.b  #$30, d5
00B8AC  ori.b  #$ac, d5
00B8B0  ori.b  #$b8, d5
00B8B4  ori.b  #$c4, d5
00B8B8  ori.b  #$30, d5
00B8BC  ori.b  #$b8, d5
00B8C0  ori.b  #$c4, d5
00B8C4  ori.b  #$d0, d5
00B8C8  ori.b  #$30, d5
00B8CC  ori.b  #$c4, d5
00B8D0  ori.b  #$d0, d5
00B8D4  ori.b  #$dc, d5
00B8D8  ori.b  #$30, d5
00B8DC  ori.b  #$d0, d5
00B8E0  ori.b  #$dc, d5
00B8E4  ori.b  #$e8, d5
00B8E8  ori.b  #$30, d5
00B8EC  ori.b  #$dc, d5
00B8F0  ori.b  #$e8, d5
00B8F4  ori.b  #$f4, d5
00B8F8  ori.b  #$30, d5
00B8FC  ori.b  #$e8, d5
00B900  ori.b  #$f4, d5
00B904  ori.b  #$0, d5
00B908  ori.b  #$30, d5
00B90C  ori.b  #$f4, d5
00B910  ori.b  #$0, d5
00B914  ori.b  #$c, d5
00B918  ori.b  #$30, d5
00B91C  ori.b  #$0, d5
00B920  ori.b  #$c, d5
00B924  ori.b  #$18, d5
00B928  ori.b  #$30, d5
00B92C  ori.b  #$c, d5
00B930  ori.b  #$18, d5
00B934  ori.b  #$ac, d5
00B938  ori.b  #$30, d5
00B93C  ori.b  #$18, d5
00B940  ori.b  #$ac, d5
00B944  ori.b  #$c, d5
00B948  ori.b  #$dc, d5
00B94C  ori.b  #$c4, d5
00B950  ori.b  #$6c, d0
00B954  ori.b  #$1c, d0
00B958  ori.b  #$dc, d0
00B95C  ori.b  #$dc, d0
00B960  ori.b  #$10, (a5)+
00B964  ori.b  #$24, d7
00B968  dc.w   $c3a
00B96A  ori.b  #$0, d0
00B96E  ori.b  #$60, d0
00B972  btst.l d1, -(a0)
00B974  ori.b  #$e8, d0
00B978  dc.w   $fce0
00B97A  ori.b  #$e8, d0
00B97E  ; data: 0xfd, 0xa8
00B980  ori.b  #$68, d0
00B984  andi.w #$0, (a0)+
00B988  dc.w   $f768
00B98A  bchg.b d4, -(a0)
00B98C  ori.b  #$30, d0
00B990  bchg.b d4, -(a0)
00B992  ori.b  #$50, d0
00B996  movep.w $0(a4), d1
00B99A  andi.w #$fcf4, (a0)+
00B99E  ori.b  #$58, d0
00B9A2  dc.w   $f6a0
00B9A4  ori.b  #$50, d0
00B9A8  dc.w   $f6a0
00B9AA  ori.b  #$30, d0
00B9AE  ; data: 0xfd, 0xa8
00B9B0  ori.b  #$30, d0
00B9B4  andi.w #$0, (a0)+
00B9B8  dc.w   $f830
00B9BA  ; data: 0xfd, 0xa8
00B9BC  dc.w   $fe70
00B9BE  bset.b d1, $258(a0)
00B9C2  dc.w   $fe70
00B9C4  bset.b d1, $190(a0)
00B9C8  dc.w   $fe70
00B9CA  dc.w   $f768
00B9CC  dc.w   $fe70
00B9CE  dc.w   $fe70
00B9D0  dc.w   $f768
00B9D2  dc.w   $f6a0
00B9D4  dc.w   $ff38
00B9D6  dc.w   $f830
00B9D8  bchg.b d4, -(a0)
00B9DA  dc.w   $ff38
00B9DC  dc.w   $f830
00B9DE  btst.l d0, -$190(a4)
00B9E2  dc.w   $f95c
00B9E4  btst.l d0, -$190(a4)
00B9E8  ; data: 0xfd, 0xa8
00B9EA  bclr.b d0, (a0)
00B9EC  ; data: 0xfd, 0xa8
00B9EE  dc.w   $f894
00B9F0  dc.w   $fed4
00B9F2  dc.w   $fe70
00B9F4  dc.w   $f95c
00B9F6  dc.w   $fed4
00B9F8  dc.w   $fe70
00B9FA  ; data: 0xfd, 0xa8
00B9FC  dc.w   $fe70
00B9FE  ; data: 0xfd, 0xa8
00BA00  dc.w   $f894
00BA02  dc.w   $fed4
00BA04  dc.w   $fed4
00BA06  dc.w   $f768
00BA08  btst.l d0, -$12c(a4)
00BA0C  dc.w   $f768
00BA0E  bclr.b d0, (a0)
00BA10  ; data: 0xff, 0x9c
00BA12  dc.w   $f768
00BA14  dc.w   $fe70
00BA16  ; data: 0xff, 0x9c
00BA18  dc.w   $f768
00BA1A  ori.b  #$3, d0
00BA1E  ori.b  #$0, d3
00BA22  cmp.l  $0(a4), d7
00BA26  cmp.l  $3(a4), d7
00BA2A  ori.b  #$0, d3
00BA2E  cmp.l  #$bebc, d7
00BA34  ori.b  #$3, d3
00BA38  ori.b  #$cc, d0
00BA3C  ori.b  #$cc, d0
00BA40  ori.b  #$3, d3
00BA44  ori.b  #$dc, d0
00BA48  ori.b  #$dc, d0
00BA4C  ori.b  #$4, d4
00BA50  ori.b  #$ec, d0
00BA54  ori.b  #$ec, d0
00BA58  ori.b  #$4, d4
00BA5C  ori.b  #$0, d0
00BA60  ori.b  #$0, d0
00BA64  ori.b  #$4, d4
00BA68  ori.b  #$14, d0
00BA6C  ori.b  #$14, d0
00BA70  ori.b  #$4, d4
00BA74  ori.b  #$28, d0
00BA78  ori.b  #$28, d0
00BA7C  ori.b  #$4, d4
00BA80  ori.b  #$3c, d0
00BA84  ori.b  #$3c, d0
00BA88  ori.b  #$4, d4
00BA8C  ori.b  #$50, d0
00BA90  ori.b  #$50, d0
00BA94  ori.b  #$3, d3
00BA98  ori.b  #$64, d0
00BA9C  ori.b  #$64, d0
00BAA0  ori.b  #$3, d3
00BAA4  ori.b  #$74, d0
00BAA8  ori.b  #$74, d0
00BAAC  ori.b  #$3, d3
00BAB0  ori.b  #$84, d0
00BAB4  ori.b  #$84, d0
00BAB8  ori.b  #$3, d3
00BABC  ori.b  #$94, d0
00BAC0  ori.b  #$94, d0
00BAC4  ori.b  #$4, d4
00BAC8  ori.b  #$a4, d0
00BACC  ori.b  #$a4, d0
00BAD0  ori.b  #$4, d4
00BAD4  ori.b  #$b8, d0
00BAD8  ori.b  #$b8, d0
00BADC  ori.b  #$4c, d0
00BAE0  ori.b  #$0, d1
00BAE4  ori.b  #$4c, d0
00BAE8  ori.b  #$50, d0
00BAEC  ori.b  #$58, d0
00BAF0  ori.b  #$1, d2
00BAF4  ori.b  #$50, d0
00BAF8  ori.b  #$58, d0
00BAFC  ori.b  #$64, d0
00BB00  ori.b  #$1, d2
00BB04  ori.b  #$5c, d0
00BB08  ori.b  #$64, d0
00BB0C  ori.b  #$70, d0
00BB10  ori.b  #$0, d1
00BB14  ori.b  #$68, d0
00BB18  ori.b  #$6c, d0
00BB1C  ori.b  #$7c, d0
00BB20  ori.b  #$5, d4
00BB24  ori.b  #$6c, d0
00BB28  ori.b  #$7c, d0
00BB2C  ori.b  #$88, d0
00BB30  ori.b  #$5, d4
00BB34  ori.b  #$90, d0
00BB38  ori.b  #$a0, d0
00BB3C  ori.b  #$c4, d0
00BB40  ori.b  #$4, d6
00BB44  ori.b  #$b4, d0
00BB48  ori.b  #$cc, d0
00BB4C  ori.b  #$f4, d0
00BB50  ori.b  #$8, d0
00BB54  ori.b  #$cc, d0
00BB58  ori.b  #$44, d0
00BB5C  ori.b  #$1c, d0
00BB60  ori.b  #$e0, d0
00BB64  ori.b  #$58, d0
00BB68  ori.b  #$30, d0
00BB6C  ori.b  #$5c, d0
00BB70  ori.b  #$34, d0
00BB74  ori.b  #$94, d0
00BB78  ori.b  #$6c, d0
00BB7C  ori.b  #$84, d0
00BB80  ori.b  #$a4, d0
00BB84  ori.b  #$7c, d0
00BB88  ori.b  #$54, d0
00BB8C  ori.b  #$2c, d0
00BB90  ori.b  #$70, d0
00BB94  ori.b  #$48, d0
00BB98  ori.b  #$a8, d0
00BB9C  ori.b  #$80, d0
00BBA0  ori.b  #$98, d0
00BBA4  ori.b  #$b8, d0
00BBA8  ori.b  #$90, d0
00BBAC  ori.b  #$68, d0
00BBB0  ori.b  #$40, d0
00BBB4  ori.b  #$d0, d0
00BBB8  ori.b  #$bc, d0
00BBBC  ori.b  #$18, d0
00BBC0  ori.b  #$4, d0
00BBC4  ori.b  #$f0, d0
00BBC8  ori.b  #$dc, d0
00BBCC  ori.b  #$20, d0
00BBD0  ori.b  #$c, d0
00BBD4  ori.b  #$f8, d0
00BBD8  ori.b  #$e4, d0
00BBDC  ori.b  #$2c, d0
00BBE0  ori.b  #$1c, d0
00BBE4  ori.b  #$1, d1
00BBE8  ori.b  #$0, d0
00BBEC  ori.b  #$0, d0
00BBF0  ori.b  #$2c, d0
00BBF4  ori.b  #$28, d0
00BBF8  ori.b  #$2, d1
00BBFC  ori.b  #$0, d0
00BC00  ori.b  #$0, d0
00BC04  ori.b  #$2c, d0
00BC08  ori.b  #$34, d0
00BC0C  ori.b  #$2, d1
00BC10  ori.b  #$0, d0
00BC14  ori.b  #$0, d0
00BC18  ori.b  #$2c, d0
00BC1C  ori.b  #$40, d0
00BC20  ori.b  #$1, d1
00BC24  ori.b  #$0, d0
00BC28  ori.b  #$0, d0
00BC2C  ori.b  #$2c, d0
00BC30  ori.b  #$94, d0
00BC34  ori.b  #$4, d1
00BC38  ori.b  #$0, d0
00BC3C  ori.b  #$0, d0
00BC40  ori.b  #$2c, d0
00BC44  ori.b  #$a0, d0
00BC48  ori.b  #$4, d1
00BC4C  ori.b  #$0, d0
00BC50  ori.b  #$0, d0
00BC54  ori.b  #$2c, d0
00BC58  ori.b  #$94, d0
00BC5C  ; data: 0x00, 0xff
00BC5E  ori.b  #$0, d4
00BC62  ori.b  #$0, d0
00BC66  ori.b  #$0, d0
00BC6A  move.w $0(a4), -(a0)
00BC6E  cmp.l  -(a0), d5
00BC70  ; data: 0x00, 0xff
00BC72  ori.b  #$0, d4
00BC76  ori.b  #$0, d0
00BC7A  ori.b  #$0, d0
00BC7E  move.w $0(a4), -(a0)
00BC82  cmp.l  $1(a4), d5
00BC86  ori.b  #$0, d4
00BC8A  ori.b  #$0, d0
00BC8E  ori.b  #$0, d0
00BC92  move.w $0(a4), -(a0)
00BC96  cmp.l  $1.w, d5
00BC9A  ori.b  #$0, d4
00BC9E  ori.b  #$0, d0
00BCA2  ori.b  #$0, d0
00BCA6  move.w $0(a4), -(a0)
00BCAA  cmp.l  $ff(a4), d5
00BCAE  ori.b  #$0, d4
00BCB2  ori.b  #$0, d0
00BCB6  ori.b  #$0, d0
00BCBA  move.w $0(a4), -(a0)
00BCBE  cmp.l  $ff.w, d5
00BCC2  ori.b  #$0, d4
00BCC6  ori.b  #$0, d0
00BCCA  ori.b  #$0, d0
00BCCE  move.w $0(a4), -(a0)
00BCD2  cmp.l  a0, d5
00BCD4  ori.b  #$2, d1
00BCD8  ori.b  #$0, d0
00BCDC  ori.b  #$0, d0
00BCE0  ori.b  #$2c, d0
00BCE4  ori.b  #$7c, d0
00BCE8  ori.b  #$2, d1
00BCEC  ori.b  #$0, d0
00BCF0  ori.b  #$0, d0
00BCF4  ori.b  #$2c, d0
00BCF8  ori.b  #$4c, d0
00BCFC  ori.b  #$2, d1
00BD00  ori.b  #$0, d0
00BD04  ori.b  #$0, d0
00BD08  ori.b  #$2c, d0
00BD0C  ori.b  #$58, d0
00BD10  ori.b  #$1, d1
00BD14  ori.b  #$0, d0
00BD18  ori.b  #$0, d0
00BD1C  ori.b  #$2c, d0
00BD20  ori.b  #$64, d0
00BD24  ori.b  #$1, d1
00BD28  ori.b  #$0, d0
00BD2C  ori.b  #$0, d0
00BD30  ori.b  #$2c, d0
00BD34  ori.b  #$70, d0
00BD38  ori.b  #$2, d1
00BD3C  ori.b  #$0, d0
00BD40  ori.b  #$0, d0
00BD44  ori.b  #$2c, d0
00BD48  ori.b  #$88, d0
00BD4C  ori.b  #$2, d1
00BD50  ori.b  #$0, d0
00BD54  ori.b  #$0, d0
00BD58  ori.b  #$2c, d0
00BD5C  ori.b  #$7c, d0
00BD60  ori.b  #$2, d1
00BD64  ori.b  #$0, d0
00BD68  ori.b  #$0, d0
00BD6C  ori.b  #$2c, d0
00BD70  ori.b  #$ac, d0
00BD74  ori.b  #$4, d1
00BD78  ori.b  #$0, d0
00BD7C  ori.b  #$0, d0
00BD80  ori.b  #$2c, d0
00BD84  ori.b  #$b8, d0
00BD88  ori.b  #$4, d1
00BD8C  ori.b  #$0, d0
00BD90  ori.b  #$0, d0
00BD94  ori.b  #$2c, d0
00BD98  ori.b  #$ac, d0
00BD9C  ; data: 0x00, 0xff
00BD9E  ori.b  #$0, d4
00BDA2  ori.b  #$0, d0
00BDA6  ori.b  #$0, d0
00BDAA  move.w $0(a4), -(a0)
00BDAE  cmp.l  $ff.w, d5
00BDB2  ori.b  #$0, d4
00BDB6  ori.b  #$0, d0
00BDBA  ori.b  #$0, d0
00BDBE  move.w $0(a4), -(a0)
00BDC2  cmpa.w d4, a5
00BDC4  ori.b  #$3, d1
00BDC8  ori.b  #$0, d0
00BDCC  ori.b  #$0, d0
00BDD0  ori.b  #$2c, d0
00BDD4  ori.b  #$d0, d0
00BDD8  ori.b  #$4, d1
00BDDC  ori.b  #$0, d0
00BDE0  ori.b  #$0, d0
00BDE4  ori.b  #$2c, d0
00BDE8  ori.b  #$1c, d0
00BDEC  ori.b  #$1, d1
00BDF0  ori.b  #$0, d0
00BDF4  ori.b  #$0, d0
00BDF8  ori.b  #$2c, d0
00BDFC  ori.b  #$28, d0
00BE00  ori.b  #$2, d1
00BE04  ori.b  #$0, d0
00BE08  ori.b  #$0, d0
00BE0C  ori.b  #$2c, d0
00BE10  ori.b  #$34, d0
00BE14  ori.b  #$2, d1
00BE18  ori.b  #$0, d0
00BE1C  ori.b  #$0, d0
00BE20  ori.b  #$2c, d0
00BE24  ori.b  #$40, d0
00BE28  ori.b  #$1, d1
00BE2C  ori.b  #$0, d0
00BE30  ori.b  #$0, d0
00BE34  ori.b  #$2c, d0
00BE38  ori.b  #$94, d0
00BE3C  ori.b  #$4, d1
00BE40  ori.b  #$0, d0
00BE44  ori.b  #$0, d0
00BE48  ori.b  #$2c, d0
00BE4C  ori.b  #$a0, d0
00BE50  ori.b  #$4, d1
00BE54  ori.b  #$0, d0
00BE58  ori.b  #$0, d0
00BE5C  ori.b  #$2c, d0
00BE60  ori.b  #$94, d0
00BE64  ; data: 0x00, 0xff
00BE66  ori.b  #$0, d4
00BE6A  ori.b  #$0, d0
00BE6E  ori.b  #$0, d0
00BE72  move.w $0(a4), -(a0)
00BE76  cmp.l  -(a0), d5
00BE78  ; data: 0x00, 0xff
00BE7A  ori.b  #$0, d4
00BE7E  ori.b  #$0, d0
00BE82  ori.b  #$0, d0
00BE86  move.w $0(a4), -(a0)
00BE8A  cmp.w  #$ff, d5
00BE8E  ori.b  #$0, d2
00BE92  ori.b  #$0, d0
00BE96  ori.b  #$0, d0
00BE9A  move.w $0(a4), -(a0)
00BE9E  cmp.l  a0, d5
00BEA0  ; data: 0x00, 0xff
00BEA2  ori.b  #$0, d2
00BEA6  ori.b  #$0, d0
00BEAA  ori.b  #$5, d0
00BEAE  chk.w  $5(a4), d1
00BEB2  neg.w  (a4)
00BEB4  ori.b  #$48, d5
00BEB8  ori.b  #$ac, d5
00BEBC  ori.b  #$ac, d5
00BEC0  ori.b  #$b8, d5
00BEC4  ori.b  #$54, d5
00BEC8  ori.b  #$ac, d5
00BECC  ori.b  #$ac, d5
00BED0  ori.b  #$48, d5
00BED4  ori.b  #$c4, d5
00BED8  ori.b  #$ac, d5
00BEDC  ori.b  #$b8, d5
00BEE0  ori.b  #$ac, d5
00BEE4  ori.b  #$c4, d5
00BEE8  ori.b  #$b8, d5
00BEEC  ori.b  #$54, d5
00BEF0  ori.b  #$60, d5
00BEF4  ori.b  #$6c, d5
00BEF8  ori.b  #$48, d5
00BEFC  ori.b  #$54, d5
00BF00  ori.b  #$b8, d5
00BF04  ori.b  #$dc, d5
00BF08  ori.b  #$60, d5
00BF0C  ori.b  #$54, d5
00BF10  ori.b  #$b8, d5
00BF14  ori.b  #$6c, d5
00BF18  ori.b  #$d0, d5
00BF1C  ori.b  #$c4, d5
00BF20  ori.b  #$48, d5
00BF24  ori.b  #$6c, d5
00BF28  ori.b  #$dc, d5
00BF2C  ori.b  #$b8, d5
00BF30  ori.b  #$c4, d5
00BF34  ori.b  #$d0, d5
00BF38  ori.b  #$dc, d5
00BF3C  ori.b  #$0, d5
00BF40  ori.b  #$f4, d5
00BF44  ori.b  #$e8, d5
00BF48  ori.b  #$3c, d5
00BF4C  ori.b  #$0, d5
00BF50  ori.b  #$30, d5
00BF54  ori.b  #$24, d5
00BF58  ori.b  #$18, d5
00BF5C  ori.b  #$c, d5
00BF60  ori.b  #$30, d5
00BF64  ori.b  #$e8, d5
00BF68  ori.b  #$84, d5
00BF6C  ori.b  #$f4, d5
00BF70  ori.b  #$e8, d5
00BF74  ori.b  #$18, d5
00BF78  ori.b  #$78, d5
00BF7C  ori.b  #$24, d5
00BF80  ori.b  #$18, d5
00BF84  ori.b  #$90, d5
00BF88  ori.b  #$a8, d5
00BF8C  ori.b  #$9c, d5
00BF90  ori.b  #$90, d5
00BF94  ori.b  #$c0, d5
00BF98  ori.b  #$cc, d5
00BF9C  ori.b  #$b4, d5
00BFA0  ori.b  #$c0, d5
00BFA4  ori.b  #$60, d5
00BFA8  ori.b  #$dc, d5
00BFAC  ori.b  #$d0, d5
00BFB0  ori.b  #$6c, d5
00BFB4  ori.b  #$60, d5
00BFB8  ori.b  #$e4, d5
00BFBC  ori.b  #$f0, d5
00BFC0  ori.b  #$fc, d5
00BFC4  ori.b  #$d8, d5
00BFC8  ori.b  #$e4, d5
00BFCC  ori.b  #$e8, d0
00BFD0  ori.b  #$60, d0
00BFD4  ori.b  #$20, d0
00BFD8  ori.b  #$60, d0
00BFDC  ori.b  #$10, (a4)
00BFE0  ori.b  #$10, (a0)
00BFE4  bset.b d3, (a1)+
00BFE6  ori.b  #$50, d0
00BFEA  addi.w #$c8, d0
00BFEE  ori.b  #$c0, d0
00BFF2  ; data: 0x00, 0xc8
00BFF4  subi.l #$64000c8, $640(a0, d0.w * 2)
00BFFE  ; data: 0x00, 0xc8
00C000  bset.b d0, -(a0)
00C002  btst.l d1, -(a0)
00C004  ; data: 0x00, 0xc8
00C006  bchg.b d0, d0
00C008  bclr.b d0, (a0)
00C00A  ; data: 0x00, 0xc8
00C00C  ori.b  #$70, d0
00C010  ; data: 0x00, 0xc8
00C012  dc.w   $fec0
00C014  bclr.b d0, (a0)
00C016  ; data: 0x00, 0xc8
00C018  dc.w   $fe20
00C01A  btst.l d1, -(a0)
00C01C  ; data: 0x00, 0xc8
00C01E  dc.w   $fce0
00C020  addi.w #$c8, d0
00C024  dc.w   $fb50
00C026  addi.w #$ff38, d0
00C02A  ori.b  #$c0, d0
00C02E  dc.w   $ff38
00C030  subi.l #$640ff38, $640(a0, d0.w * 2)
00C03A  dc.w   $ff38
00C03C  bset.b d0, -(a0)
00C03E  btst.l d1, -(a0)
00C040  dc.w   $ff38
00C042  bchg.b d0, d0
00C044  bclr.b d0, (a0)
00C046  dc.w   $ff38
00C048  ori.b  #$70, d0
00C04C  dc.w   $ff38
00C04E  dc.w   $fec0
00C050  bclr.b d0, (a0)
00C052  dc.w   $ff38
00C054  dc.w   $fe20
00C056  btst.l d1, -(a0)
00C058  dc.w   $ff38
00C05A  dc.w   $fce0
00C05C  addi.w #$ff38, d0
00C060  ori.b  #$6, d6
00C064  ori.b  #$a0, d0
00C068  ori.b  #$a0, d0
00C06C  ori.b  #$6, d6
00C070  ori.b  #$bc, d0
00C074  ori.b  #$bc, d0
00C078  ori.b  #$4, d4
00C07C  ori.b  #$d8, d0
00C080  ori.b  #$d8, d0
00C084  ori.b  #$6, d6
00C088  ori.b  #$ec, d0
00C08C  ori.b  #$ec, d0
00C090  ori.b  #$6, d6
00C094  ori.b  #$8, d0
00C098  ori.b  #$8, d0
00C09C  ori.b  #$4, d4
00C0A0  ori.b  #$24, d0
00C0A4  ori.b  #$24, d0
00C0A8  ori.b  #$4, d4
00C0AC  ori.b  #$38, d0
00C0B0  ori.b  #$38, d0
00C0B4  ori.b  #$4, d4
00C0B8  ori.b  #$4c, d0
00C0BC  ori.b  #$4c, d0
00C0C0  ori.b  #$4, d4
00C0C4  ori.b  #$60, d0
00C0C8  ori.b  #$60, d0
00C0CC  ori.b  #$4, d4
00C0D0  ori.b  #$74, d0
00C0D4  ori.b  #$74, d0
00C0D8  ori.b  #$4, d4
00C0DC  ori.b  #$88, d0
00C0E0  ori.b  #$88, d0
00C0E4  ori.b  #$4, d4
00C0E8  ori.b  #$9c, d0
00C0EC  ori.b  #$9c, d0
00C0F0  ori.b  #$4, d4
00C0F4  ori.b  #$b0, d0
00C0F8  ori.b  #$b0, d0
00C0FC  ori.b  #$4, d4
00C100  ori.b  #$c4, d0
00C104  ori.b  #$c4, d0
00C108  ori.b  #$4, d4
00C10C  ori.b  #$d8, d0
00C110  ori.b  #$d8, d0
00C114  ori.b  #$4, d4
00C118  ori.b  #$ec, d0
00C11C  ori.b  #$ec, d0
00C120  ori.b  #$60, d0
00C124  ori.b  #$1, d0
00C128  ori.b  #$20, d0
00C12C  ori.b  #$20, d0
00C130  ori.b  #$6c, d0
00C134  ori.b  #$1, d0
00C138  ori.b  #$24, d0
00C13C  ori.b  #$24, d0
00C140  ori.b  #$78, d0
00C144  ori.b  #$1, d0
00C148  ori.b  #$28, d0
00C14C  ori.b  #$28, d0
00C150  ori.b  #$84, d0
00C154  ori.b  #$1, d0
00C158  ori.b  #$2c, d0
00C15C  ori.b  #$2c, d0
00C160  ori.b  #$90, d0
00C164  ori.b  #$1, d0
00C168  ori.b  #$30, d0
00C16C  ori.b  #$30, d0
00C170  ori.b  #$9c, d0
00C174  ori.b  #$1, d0
00C178  ori.b  #$34, d0
00C17C  ori.b  #$34, d0
00C180  ori.b  #$a8, d0
00C184  ori.b  #$1, d0
00C188  ori.b  #$38, d0
00C18C  ori.b  #$38, d0
00C190  ori.b  #$b4, d0
00C194  ori.b  #$1, d0
00C198  ori.b  #$3c, d0
00C19C  ori.b  #$3c, d0
00C1A0  ori.b  #$c0, d0
00C1A4  ori.b  #$1, d0
00C1A8  ori.b  #$40, d0
00C1AC  ori.b  #$40, d0
00C1B0  ori.b  #$cc, d0
00C1B4  ori.b  #$1, d0
00C1B8  ori.b  #$44, d0
00C1BC  ori.b  #$44, d0
00C1C0  ori.b  #$d8, d0
00C1C4  ori.b  #$1, d0
00C1C8  ori.b  #$48, d0
00C1CC  ori.b  #$48, d0
00C1D0  ori.b  #$e4, d0
00C1D4  ori.b  #$1, d0
00C1D8  ori.b  #$4c, d0
00C1DC  ori.b  #$4c, d0
00C1E0  ori.b  #$f0, d0
00C1E4  ori.b  #$1, d0
00C1E8  ori.b  #$50, d0
00C1EC  ori.b  #$50, d0
00C1F0  ori.b  #$fc, d0
00C1F4  ori.b  #$1, d0
00C1F8  ori.b  #$54, d0
00C1FC  ori.b  #$54, d0
00C200  ori.b  #$8, d0
00C204  ori.b  #$1, d0
00C208  ori.b  #$58, d0
00C20C  ori.b  #$58, d0
00C210  ori.b  #$14, d0
00C214  ori.b  #$1, d0
00C218  ori.b  #$5c, d0
00C21C  ori.b  #$5c, d0
00C220  ori.b  #$0, d0
00C224  ori.b  #$14, d0
00C228  ori.b  #$28, d0
00C22C  ori.b  #$3c, d0
00C230  ori.b  #$50, d0
00C234  ori.b  #$64, d0
00C238  ori.b  #$d8, d0
00C23C  ori.b  #$78, d0
00C240  ori.b  #$8c, d0
00C244  ori.b  #$ec, d0
00C248  ori.b  #$60, d0
00C24C  ori.b  #$b0, d0
00C250  ori.b  #$74, d0
00C254  ori.b  #$c4, d0
00C258  ori.b  #$88, d0
00C25C  ori.b  #$9c, d0
00C260  ori.b  #$2c, d0
00C264  ori.b  #$d8, d0
00C268  ; data: 0x00, 0xff
00C26A  ori.b  #$0, d3
00C26E  ori.b  #$0, d0
00C272  ori.b  #$0, d0
00C276  move.w $0(a4), -(a0)
00C27A  mulu.w -$1(a0, d0.w), d0
00C27E  ori.b  #$0, d3
00C282  ori.b  #$0, d0
00C286  ori.b  #$0, d0
00C28A  move.w $0(a4), -(a0)
00C28E  abcd.b -(a0), -(a0)
00C290  ; data: 0x00, 0xff
00C292  ori.b  #$0, d3
00C296  ori.b  #$0, d0
00C29A  ori.b  #$0, d0
00C29E  move.w $0(a4), -(a0)
00C2A2  and.b  d0, (a4)
00C2A4  ; data: 0x00, 0xff
00C2A6  ori.b  #$0, d3
00C2AA  ori.b  #$0, d0
00C2AE  ori.b  #$0, d0
00C2B2  move.w $0(a4), -(a0)
00C2B6  mulu.w -(a4), d0
00C2B8  ; data: 0x00, 0xff
00C2BA  ori.b  #$0, d2
00C2BE  ori.b  #$0, d0
00C2C2  ori.b  #$0, d0
00C2C6  move.w $0(a4), -(a0)
00C2CA  mulu.w #$ff, d0
00C2CE  ori.b  #$0, d2
00C2D2  ori.b  #$0, d0
00C2D6  ori.b  #$0, d0
00C2DA  move.w $0(a4), -(a0)
00C2DE  and.l  $ff(a0), d0
00C2E2  ori.b  #$0, d2
00C2E6  ori.b  #$0, d0
00C2EA  ori.b  #$0, d0
00C2EE  move.w $0(a4), -(a0)
00C2F2  ; data: 0xc0, 0xcc
00C2F4  ; data: 0x00, 0xff
00C2F6  ori.b  #$0, d2
00C2FA  ori.b  #$0, d0
00C2FE  ori.b  #$0, d0
00C302  move.w $0(a4), -(a0)
00C306  and.w  -(a0), d0
00C308  ; data: 0x00, 0xff
00C30A  ori.b  #$0, d1
00C30E  ori.b  #$0, d0
00C312  ori.b  #$0, d0
00C316  move.w $0(a4), -(a0)
00C31A  and.w  $ff(a4), d0
00C31E  ori.b  #$0, d1
00C322  ori.b  #$0, d0
00C326  ori.b  #$0, d0
00C32A  move.w $0(a4), -(a0)
00C32E  and.w  $ff.w, d0
00C332  ori.b  #$0, d1
00C336  ori.b  #$0, d0
00C33A  ori.b  #$0, d0
00C33E  move.w $0(a4), -(a0)
00C342  and.l  d4, d0
00C344  ; data: 0x00, 0xff
00C346  ori.b  #$0, d1
00C34A  ori.b  #$0, d0
00C34E  ori.b  #$0, d0
00C352  move.w $0(a4), -(a0)
00C356  and.l  (a0), d0
00C358  ; data: 0x00, 0xff
00C35A  ori.b  #$0, d1
00C35E  ori.b  #$0, d0
00C362  ori.b  #$0, d0
00C366  move.w $0(a4), -(a0)
00C36A  and.l  (a4)+, d0
00C36C  ; data: 0x00, 0xff
00C36E  ori.b  #$0, d1
00C372  ori.b  #$0, d0
00C376  ori.b  #$0, d0
00C37A  move.w $0(a4), -(a0)
00C37E  and.l  -$1(a4, d0.w), d0
00C382  ori.b  #$0, d3
00C386  ori.b  #$0, d0
00C38A  ori.b  #$0, d0
00C38E  move.w $0(a4), -(a0)
00C392  mulu.w d0, d0
00C394  ; data: 0x00, 0xff
00C396  ori.b  #$0, d3
00C39A  ori.b  #$0, d0
00C39E  ori.b  #$5, d0
00C3A2  chk.w  $5.w, d1
00C3A6  lea.l  $5(a4, d0.w), a1
00C3AA  neg.b  d0
00C3AC  ori.b  #$c, d5
00C3B0  ori.b  #$18, d5
00C3B4  ori.b  #$ac, d5
00C3B8  ori.b  #$b8, d5
00C3BC  ori.b  #$c4, d5
00C3C0  ori.b  #$d0, d5
00C3C4  ori.b  #$dc, d5
00C3C8  ori.b  #$e8, d5
00C3CC  ori.b  #$f4, d5
00C3D0  ori.b  #$b8, d5
00C3D4  ori.b  #$c4, d5
00C3D8  ori.b  #$0, d5
00C3DC  ori.b  #$e8, d5
00C3E0  ori.b  #$dc, d5
00C3E4  ori.b  #$c, d5
00C3E8  ori.b  #$0, d5
00C3EC  ori.b  #$24, d5
00C3F0  ori.b  #$90, d5
00C3F4  ori.b  #$84, d5
00C3F8  ori.b  #$78, d5
00C3FC  ori.b  #$6c, d5
00C400  ori.b  #$30, d5
00C404  ori.b  #$24, d5
00C408  ori.b  #$3c, d5
00C40C  ori.b  #$30, d5
00C410  ori.b  #$6c, d5
00C414  ori.b  #$60, d5
00C418  ori.b  #$54, d5
00C41C  ori.b  #$48, d5
00C420  ori.b  #$3c, d5
00C424  ori.b  #$54, d5
00C428  ori.b  #$60, d5
00C42C  ori.b  #$78, d5
00C430  ori.b  #$84, d5
00C434  ori.b  #$54, d5
00C438  ori.b  #$ac, d5
00C43C  ori.b  #$18, d5
00C440  ori.b  #$90, d5
00C444  ori.b  #$24, d5
00C448  ori.b  #$ac, d5
00C44C  ori.b  #$ac, d5
00C450  ori.b  #$24, d5
00C454  ori.b  #$30, d5
00C458  ori.b  #$b8, d5
00C45C  ori.b  #$ac, d5
00C460  ori.b  #$b8, d5
00C464  ori.b  #$30, d5
00C468  ori.b  #$3c, d5
00C46C  ori.b  #$c4, d5
00C470  ori.b  #$b8, d5
00C474  ori.b  #$d0, d5
00C478  ori.b  #$c4, d5
00C47C  ori.b  #$3c, d5
00C480  ori.b  #$48, d5
00C484  ori.b  #$d0, d5
00C488  ori.b  #$dc, d5
00C48C  ori.b  #$d0, d5
00C490  ori.b  #$48, d5
00C494  ori.b  #$54, d5
00C498  ori.b  #$dc, d5
00C49C  ori.b  #$c, d5
00C4A0  ori.b  #$dc, d5
00C4A4  ori.b  #$54, d5
00C4A8  ori.b  #$84, d5
00C4AC  ori.b  #$c, d5
00C4B0  ori.b  #$18, d5
00C4B4  ori.b  #$c, d5
00C4B8  ori.b  #$84, d5
00C4BC  ori.b  #$90, d5
00C4C0  ori.b  #$18, d5
00C4C4  ori.b  #$e8, d5
00C4C8  ori.b  #$0, d5
00C4CC  ori.b  #$78, d5
00C4D0  ori.b  #$60, d5
00C4D4  ori.b  #$e8, d5
00C4D8  ori.b  #$0, d5
00C4DC  ori.b  #$f4, d5
00C4E0  ori.b  #$6c, d5
00C4E4  ori.b  #$78, d5
00C4E8  ori.b  #$0, d5
00C4EC  ori.b  #$f4, d5
00C4F0  ori.b  #$e8, d5
00C4F4  ori.b  #$60, d5
00C4F8  ori.b  #$6c, d5
00C4FC  ori.b  #$f4, d5
00C500  ori.b  #$1c, d0
00C504  ori.b  #$7c, d0
00C508  ori.b  #$24, d0
00C50C  ori.b  #$3c, d0
00C510  ori.b  #$e, (a0)
00C514  ; data: 0x00, 0x0e
00C516  ; data: 0x00, 0x0e
00C518  bset.b d3, (a1)+
00C51A  ori.b  #$50, d0
00C51E  ; data: 0xf9, 0xc0
00C520  ; data: 0x00, 0xc8
00C522  dc.w   $fce0
00C524  ; data: 0xf9, 0xc0
00C526  ; data: 0x00, 0xc8
00C528  dc.w   $fce0
00C52A  dc.w   $fce0
00C52C  ; data: 0x00, 0xc8
00C52E  dc.w   $fb50
00C530  addi.w #$c8, d0
00C534  dc.w   $fce0
00C536  addi.w #$c8, d0
00C53A  dc.w   $fce0
00C53C  btst.l d1, -(a0)
00C53E  ; data: 0x00, 0xc8
00C540  bclr.b d0, (a0)
00C542  ori.b  #$c8, d0
00C546  subi.l #$c8, (a0, invalid.w)
00C54E  ; data: 0xf9, 0xc0
00C550  dc.w   $ff38
00C552  dc.w   $fce0
00C554  ; data: 0xf9, 0xc0
00C556  dc.w   $ff38
00C558  dc.w   $fce0
00C55A  dc.w   $fce0
00C55C  dc.w   $ff38
00C55E  dc.w   $fb50
00C560  addi.w #$ff38, d0
00C564  dc.w   $fce0
00C566  addi.w #$ff38, d0
00C56A  dc.w   $fce0
00C56C  btst.l d1, -(a0)
00C56E  dc.w   $ff38
00C570  bclr.b d0, (a0)
00C572  ori.b  #$38, d0
00C576  subi.l #$ff38, $6(a0, d0.w)
00C57E  ori.b  #$0, d6
00C582  and.w  (a4), d4
00C584  ori.b  #$54, d0
00C588  ori.b  #$4, d4
00C58C  ori.b  #$70, d0
00C590  ori.b  #$70, d0
00C594  ori.b  #$4, d4
00C598  ori.b  #$84, d0
00C59C  ori.b  #$84, d0
00C5A0  ori.b  #$6, d6
00C5A4  ori.b  #$98, d0
00C5A8  ori.b  #$98, d0
00C5AC  ori.b  #$4, d4
00C5B0  ori.b  #$b4, d0
00C5B4  ori.b  #$b4, d0
00C5B8  ori.b  #$4, d4
00C5BC  ori.b  #$c8, d0
00C5C0  ori.b  #$c8, d0
00C5C4  ori.b  #$4, d4
00C5C8  ori.b  #$dc, d0
00C5CC  ori.b  #$dc, d0
00C5D0  ori.b  #$4, d4
00C5D4  ori.b  #$f0, d0
00C5D8  ori.b  #$f0, d0
00C5DC  ori.b  #$4, d4
00C5E0  ori.b  #$4, d0
00C5E4  ori.b  #$4, d0
00C5E8  ori.b  #$4, d4
00C5EC  ori.b  #$18, d0
00C5F0  ori.b  #$18, d0
00C5F4  ori.b  #$4, d4
00C5F8  ori.b  #$2c, d0
00C5FC  ori.b  #$2c, d0
00C600  ori.b  #$4, d4
00C604  ori.b  #$40, d0
00C608  ori.b  #$40, d0
00C60C  ori.b  #$4, d4
00C610  ori.b  #$54, d0
00C614  ori.b  #$54, d0
00C618  ori.b  #$4, d4
00C61C  ori.b  #$68, d0
00C620  ori.b  #$68, d0
00C624  ori.b  #$7c, d0
00C628  ori.b  #$1, d0
00C62C  ori.b  #$4, d0
00C630  ori.b  #$4, d0
00C634  ori.b  #$88, d0
00C638  ori.b  #$1, d0
00C63C  ori.b  #$8, d0
00C640  ori.b  #$8, d0
00C644  ori.b  #$94, d0
00C648  ori.b  #$1, d0
00C64C  ori.b  #$c, d0
00C650  ori.b  #$c, d0
00C654  ori.b  #$a0, d0
00C658  ori.b  #$1, d0
00C65C  ori.b  #$10, d0
00C660  ori.b  #$10, d0
00C664  ori.b  #$ac, d0
00C668  ori.b  #$1, d0
00C66C  ori.b  #$14, d0
00C670  ori.b  #$14, d0
00C674  ori.b  #$b8, d0
00C678  ori.b  #$1, d0
00C67C  ori.b  #$18, d0
00C680  ori.b  #$18, d0
00C684  ori.b  #$c4, d0
00C688  ori.b  #$1, d0
00C68C  ori.b  #$1c, d0
00C690  ori.b  #$1c, d0
00C694  ori.b  #$d0, d0
00C698  ori.b  #$1, d0
00C69C  ori.b  #$20, d0
00C6A0  ori.b  #$20, d0
00C6A4  ori.b  #$dc, d0
00C6A8  ori.b  #$1, d0
00C6AC  ori.b  #$24, d0
00C6B0  ori.b  #$24, d0
00C6B4  ori.b  #$e8, d0
00C6B8  ori.b  #$1, d0
00C6BC  ori.b  #$28, d0
00C6C0  ori.b  #$28, d0
00C6C4  ori.b  #$f4, d0
00C6C8  ori.b  #$1, d0
00C6CC  ori.b  #$2c, d0
00C6D0  ori.b  #$2c, d0
00C6D4  ori.b  #$0, d0
00C6D8  ori.b  #$1, d0
00C6DC  ori.b  #$30, d0
00C6E0  ori.b  #$30, d0
00C6E4  ori.b  #$c, d0
00C6E8  ori.b  #$1, d0
00C6EC  ori.b  #$34, d0
00C6F0  ori.b  #$34, d0
00C6F4  ori.b  #$18, d0
00C6F8  ori.b  #$1, d0
00C6FC  ori.b  #$38, d0
00C700  ori.b  #$38, d0
00C704  ori.b  #$78, d0
00C708  ori.b  #$8c, d0
00C70C  ori.b  #$a0, d0
00C710  ori.b  #$b4, d0
00C714  ori.b  #$c8, d0
00C718  ori.b  #$dc, d0
00C71C  ori.b  #$f0, d0
00C720  ori.b  #$4, d0
00C724  ori.b  #$18, d0
00C728  ori.b  #$3c, d0
00C72C  ori.b  #$50, d0
00C730  ori.b  #$64, d0
00C734  ori.b  #$2c, d0
00C738  ori.b  #$40, d0
00C73C  ori.b  #$2c, d0
00C740  ori.b  #$e8, d0
00C744  ; data: 0x00, 0xff
00C746  ori.b  #$0, d2
00C74A  ori.b  #$0, d0
00C74E  ori.b  #$0, d0
00C752  move.w $0(a4), -(a0)
00C756  muls.w -$1(a4, d0.w), d2
00C75A  ori.b  #$0, d2
00C75E  ori.b  #$0, d0
00C762  ori.b  #$0, d0
00C766  move.w $0(a4), -(a0)
00C76A  and.b  d0, d3
00C76C  ; data: 0x00, 0xff
00C76E  ori.b  #$0, d3
00C772  ori.b  #$0, d0
00C776  ori.b  #$0, d0
00C77A  move.w $0(a4), -(a0)
00C77E  ; data: 0xc5, 0x7c
00C780  ; data: 0x00, 0xff
00C782  ori.b  #$0, d1
00C786  ori.b  #$0, d0
00C78A  ori.b  #$0, d0
00C78E  move.w $0(a4), -(a0)
00C792  exg.l  d2, a0
00C794  ; data: 0x00, 0xff
00C796  ori.b  #$0, d1
00C79A  ori.b  #$0, d0
00C79E  ori.b  #$0, d0
00C7A2  move.w $0(a4), -(a0)
00C7A6  and.l  d2, (a4)
00C7A8  ; data: 0x00, 0xff
00C7AA  ori.b  #$0, d1
00C7AE  ori.b  #$0, d0
00C7B2  ori.b  #$0, d0
00C7B6  move.w $0(a4), -(a0)
00C7BA  and.l  d2, -(a0)
00C7BC  ; data: 0x00, 0xff
00C7BE  ori.b  #$0, d1
00C7C2  ori.b  #$0, d0
00C7C6  ori.b  #$0, d0
00C7CA  move.w $0(a4), -(a0)
00C7CE  and.l  d2, $ff(a4)
00C7D2  ori.b  #$0, d1
00C7D6  ori.b  #$0, d0
00C7DA  ori.b  #$0, d0
00C7DE  move.w $0(a4), -(a0)
00C7E2  and.l  d2, $ff.w
00C7E6  ori.b  #$0, d1
00C7EA  ori.b  #$0, d0
00C7EE  ori.b  #$0, d0
00C7F2  move.w $0(a4), -(a0)
00C7F6  muls.w d4, d2
00C7F8  ; data: 0x00, 0xff
00C7FA  ori.b  #$0, d2
00C7FE  ori.b  #$0, d0
00C802  ori.b  #$0, d0
00C806  move.w $0(a4), -(a0)
00C80A  muls.w (a0), d2
00C80C  ; data: 0x00, 0xff
00C80E  ori.b  #$0, d2
00C812  ori.b  #$0, d0
00C816  ori.b  #$0, d0
00C81A  move.w $0(a4), -(a0)
00C81E  muls.w (a4)+, d2
00C820  ; data: 0x00, 0xff
00C822  ori.b  #$0, d3
00C826  ori.b  #$0, d0
00C82A  ori.b  #$0, d0
00C82E  move.w $0(a4), -(a0)
00C832  ; data: 0xc6, 0x0c
00C834  ; data: 0x00, 0xff
00C836  ori.b  #$0, d3
00C83A  ori.b  #$0, d0
00C83E  ori.b  #$0, d0
00C842  move.w $0(a4), -(a0)
00C846  and.b  (a0)+, d3
00C848  ; data: 0x00, 0xff
00C84A  ori.b  #$0, d2
00C84E  ori.b  #$0, d0
00C852  ori.b  #$5, d0
00C856  chk.w  $5(a4), d1
00C85A  chk.w  $5.w, d1
00C85E  ; data: 0x43, 0xc4
00C860  ori.b  #$e8, d5
00C864  ori.b  #$dc, d5
00C868  ori.b  #$d0, d5
00C86C  ori.b  #$ac, d5
00C870  ori.b  #$0, d5
00C874  ori.b  #$f4, d5
00C878  ori.b  #$c4, d5
00C87C  ori.b  #$b8, d5
00C880  ori.b  #$0, d5
00C884  ori.b  #$dc, d5
00C888  ori.b  #$e8, d5
00C88C  ori.b  #$f4, d5
00C890  ori.b  #$0, d5
00C894  ori.b  #$dc, d5
00C898  ori.b  #$24, d5
00C89C  ori.b  #$18, d5
00C8A0  ori.b  #$c, d5
00C8A4  ori.b  #$30, d5
00C8A8  ori.b  #$3c, d5
00C8AC  ori.b  #$48, d5
00C8B0  ori.b  #$24, d5
00C8B4  ori.b  #$18, d5
00C8B8  ori.b  #$24, d5
00C8BC  ori.b  #$54, d5
00C8C0  ori.b  #$60, d5
00C8C4  ori.b  #$18, d5
00C8C8  ori.b  #$54, d5
00C8CC  ori.b  #$48, d5
00C8D0  ori.b  #$3c, d5
00C8D4  ori.b  #$60, d5
00C8D8  ori.b  #$54, d5
00C8DC  ori.b  #$ac, d5
00C8E0  ori.b  #$d0, d5
00C8E4  ori.b  #$30, d5
00C8E8  ori.b  #$c, d5
00C8EC  ori.b  #$ac, d5
00C8F0  ori.b  #$60, d5
00C8F4  ori.b  #$0, d5
00C8F8  ori.b  #$b8, d5
00C8FC  ori.b  #$18, d5
00C900  ori.b  #$60, d5
00C904  ori.b  #$0, d5
00C908  ori.b  #$60, d5
00C90C  ori.b  #$3c, d5
00C910  ori.b  #$dc, d5
00C914  ori.b  #$0, d5
00C918  ori.b  #$c4, d5
00C91C  ori.b  #$24, d5
00C920  ori.b  #$48, d5
00C924  ori.b  #$e8, d5
00C928  ori.b  #$c4, d5
00C92C  ori.b  #$f4, d5
00C930  ori.b  #$54, d5
00C934  ori.b  #$24, d5
00C938  ori.b  #$c4, d5
00C93C  ori.b  #$f4, d5
00C940  ori.b  #$e8, d5
00C944  ori.b  #$48, d5
00C948  ori.b  #$54, d5
00C94C  ori.b  #$f4, d5
00C950  ori.b  #$e8, d5
00C954  ori.b  #$18, d5
00C958  ori.b  #$b8, d5
00C95C  ori.b  #$ac, d5
00C960  ori.b  #$c, d5
00C964  ori.b  #$18, d5
00C968  ori.b  #$dc, d5
00C96C  ori.b  #$3c, d5
00C970  ori.b  #$30, d5
00C974  ori.b  #$d0, d5
00C978  ori.b  #$dc, d5
00C97C  ori.b  #$98, d0
00C980  ori.b  #$28, d0
00C984  ori.b  #$18, d0
00C988  ori.b  #$a8, d0
00C98C  ori.b  #$14, (a0)+
00C990  ori.b  #$14, (a4)
00C994  bset.b d3, (a1)+
00C996  ori.b  #$50, d0
00C99A  ; data: 0xf9, 0xc0
00C99C  ; data: 0x00, 0xc8
00C99E  subi.l #$f9c000c8, -$50(a0, d0.w)
00C9A6  dc.w   $fb50
00C9A8  ; data: 0x00, 0xc8
00C9AA  dc.w   $fce0
00C9AC  dc.w   $fb50
00C9AE  ; data: 0x00, 0xc8
00C9B0  dc.w   $fb50
00C9B2  addi.w #$c8, d0
00C9B6  subi.l #$64000c8, -$50(a0, d0.w)
00C9BE  subi.l #$c8fce0, -$50(a0, d0.w)
00C9C6  ; data: 0x00, 0xc8
00C9C8  dc.w   $fce0
00C9CA  btst.l d1, -(a0)
00C9CC  ; data: 0x00, 0xc8
00C9CE  bclr.b d0, (a0)
00C9D0  btst.l d1, -(a0)
00C9D2  ; data: 0x00, 0xc8
00C9D4  bclr.b d0, (a0)
00C9D6  bclr.b d0, (a0)
00C9D8  ; data: 0x00, 0xc8
00C9DA  dc.w   $fce0
00C9DC  bclr.b d0, (a0)
00C9DE  ; data: 0x00, 0xc8
00C9E0  dc.w   $fb50
00C9E2  ; data: 0xf9, 0xc0
00C9E4  dc.w   $ff38
00C9E6  subi.l #$f9c0ff38, -$50(a0, d0.w)
00C9EE  dc.w   $fb50
00C9F0  dc.w   $ff38
00C9F2  dc.w   $fce0
00C9F4  dc.w   $fb50
00C9F6  dc.w   $ff38
00C9F8  dc.w   $fb50
00C9FA  addi.w #$ff38, d0
00C9FE  subi.l #$640ff38, -$50(a0, d0.w)
00CA06  subi.l #$ff38fce0, -$50(a0, d0.w)
00CA0E  dc.w   $ff38
00CA10  dc.w   $fce0
00CA12  btst.l d1, -(a0)
00CA14  dc.w   $ff38
00CA16  bclr.b d0, (a0)
00CA18  btst.l d1, -(a0)
00CA1A  dc.w   $ff38
00CA1C  bclr.b d0, (a0)
00CA1E  bclr.b d0, (a0)
00CA20  dc.w   $ff38
00CA22  dc.w   $fce0
00CA24  bclr.b d0, (a0)
00CA26  dc.w   $ff38
00CA28  ori.b  #$4, d4
00CA2C  ori.b  #$38, d0
00CA30  ori.b  #$38, d0
00CA34  ori.b  #$6, d6
00CA38  ori.b  #$4c, d0
00CA3C  ori.b  #$4c, d0
00CA40  ori.b  #$4, d4
00CA44  ori.b  #$68, d0
00CA48  ori.b  #$68, d0
00CA4C  ori.b  #$4, d4
00CA50  ori.b  #$7c, d0
00CA54  ori.b  #$7c, d0
00CA58  ori.b  #$4, d4
00CA5C  ori.b  #$90, d0
00CA60  ori.b  #$90, d0
00CA64  ori.b  #$6, d6
00CA68  ori.b  #$a4, d0
00CA6C  ori.b  #$a4, d0
00CA70  ori.b  #$4, d4
00CA74  ori.b  #$c0, d0
00CA78  ori.b  #$c0, d0
00CA7C  ori.b  #$4, d4
00CA80  ori.b  #$d4, d0
00CA84  ori.b  #$d4, d0
00CA88  ori.b  #$4, d4
00CA8C  ori.b  #$e8, d0
00CA90  ori.b  #$e8, d0
00CA94  ori.b  #$4, d4
00CA98  ori.b  #$fc, d0
00CA9C  ori.b  #$fc, d0
00CAA0  ori.b  #$4, d4
00CAA4  ori.b  #$10, d0
00CAA8  ori.b  #$10, d0
00CAAC  ori.b  #$4, d4
00CAB0  ori.b  #$24, d0
00CAB4  ori.b  #$24, d0
00CAB8  ori.b  #$4, d4
00CABC  ori.b  #$38, d0
00CAC0  ori.b  #$38, d0
00CAC4  ori.b  #$4, d4
00CAC8  ori.b  #$4c, d0
00CACC  ori.b  #$4c, d0
00CAD0  ori.b  #$4, d4
00CAD4  ori.b  #$60, d0
00CAD8  ori.b  #$60, d0
00CADC  ori.b  #$4, d4
00CAE0  ori.b  #$74, d0
00CAE4  ori.b  #$74, d0
00CAE8  ori.b  #$4, d4
00CAEC  ori.b  #$88, d0
00CAF0  ori.b  #$88, d0
00CAF4  ori.b  #$4, d4
00CAF8  ori.b  #$9c, d0
00CAFC  ori.b  #$9c, d0
00CB00  ori.b  #$4, d4
00CB04  ori.b  #$b0, d0
00CB08  ori.b  #$b0, d0
00CB0C  ori.b  #$4, d4
00CB10  ori.b  #$c4, d0
00CB14  ori.b  #$c4, d0
00CB18  ori.b  #$28, d0
00CB1C  ori.b  #$0, d1
00CB20  ori.b  #$58, d0
00CB24  ori.b  #$5c, d0
00CB28  ori.b  #$34, d0
00CB2C  ori.b  #$0, d1
00CB30  ori.b  #$5c, d0
00CB34  ori.b  #$60, d0
00CB38  ori.b  #$40, d0
00CB3C  ori.b  #$0, d1
00CB40  ori.b  #$60, d0
00CB44  ori.b  #$64, d0
00CB48  ori.b  #$4c, d0
00CB4C  ori.b  #$0, d1
00CB50  ori.b  #$64, d0
00CB54  ori.b  #$68, d0
00CB58  ori.b  #$58, d0
00CB5C  ori.b  #$0, d1
00CB60  ori.b  #$68, d0
00CB64  ori.b  #$6c, d0
00CB68  ori.b  #$64, d0
00CB6C  ori.b  #$0, d1
00CB70  ori.b  #$6c, d0
00CB74  ori.b  #$70, d0
00CB78  ori.b  #$70, d0
00CB7C  ori.b  #$0, d1
00CB80  ori.b  #$70, d0
00CB84  ori.b  #$74, d0
00CB88  ori.b  #$7c, d0
00CB8C  ori.b  #$0, d1
00CB90  ori.b  #$74, d0
00CB94  ori.b  #$78, d0
00CB98  ori.b  #$88, d0
00CB9C  ori.b  #$0, d1
00CBA0  ori.b  #$78, d0
00CBA4  ori.b  #$7c, d0
00CBA8  ori.b  #$94, d0
00CBAC  ori.b  #$0, d1
00CBB0  ori.b  #$7c, d0
00CBB4  ori.b  #$80, d0
00CBB8  ori.b  #$a0, d0
00CBBC  ori.b  #$0, d1
00CBC0  ori.b  #$80, d0
00CBC4  ori.b  #$84, d0
00CBC8  ori.b  #$ac, d0
00CBCC  ori.b  #$0, d1
00CBD0  ori.b  #$84, d0
00CBD4  ori.b  #$88, d0
00CBD8  ori.b  #$b8, d0
00CBDC  ori.b  #$0, d1
00CBE0  ori.b  #$88, d0
00CBE4  ori.b  #$8c, d0
00CBE8  ori.b  #$c4, d0
00CBEC  ori.b  #$0, d1
00CBF0  ori.b  #$8c, d0
00CBF4  ori.b  #$90, d0
00CBF8  ori.b  #$d0, d0
00CBFC  ori.b  #$0, d1
00CC00  ori.b  #$90, d0
00CC04  ori.b  #$94, d0
00CC08  ori.b  #$dc, d0
00CC0C  ori.b  #$0, d1
00CC10  ori.b  #$94, d0
00CC14  ori.b  #$98, d0
00CC18  ori.b  #$e8, d0
00CC1C  ori.b  #$0, d1
00CC20  ori.b  #$98, d0
00CC24  ori.b  #$9c, d0
00CC28  ori.b  #$f4, d0
00CC2C  ori.b  #$0, d1
00CC30  ori.b  #$9c, d0
00CC34  ori.b  #$a0, d0
00CC38  ori.b  #$0, d0
00CC3C  ori.b  #$0, d1
00CC40  ori.b  #$a0, d0
00CC44  ori.b  #$a4, d0
00CC48  ori.b  #$c, d0
00CC4C  ori.b  #$0, d1
00CC50  ori.b  #$a4, d0
00CC54  ori.b  #$a8, d0
00CC58  ori.b  #$34, d0
00CC5C  ori.b  #$48, d0
00CC60  ori.b  #$5c, d0
00CC64  ori.b  #$70, d0
00CC68  ori.b  #$84, d0
00CC6C  ori.b  #$98, d0
00CC70  ori.b  #$ac, d0
00CC74  ori.b  #$c0, d0
00CC78  ori.b  #$d4, d0
00CC7C  ori.b  #$e8, d0
00CC80  ori.b  #$20, d0
00CC84  ori.b  #$fc, d0
00CC88  ori.b  #$10, d0
00CC8C  ori.b  #$24, d0
00CC90  ori.b  #$d0, d0
00CC94  ori.b  #$a8, d0
00CC98  ori.b  #$c, d0
00CC9C  ori.b  #$e4, d0
00CCA0  ori.b  #$f8, d0
00CCA4  ori.b  #$bc, d0
00CCA8  ori.b  #$2c, d0
00CCAC  ori.b  #$dc, d0
00CCB0  ori.b  #$3, d1
00CCB4  ori.b  #$0, d0
00CCB8  ori.b  #$0, d0
00CCBC  ori.b  #$2c, d0
00CCC0  ori.b  #$c, d0
00CCC4  ori.b  #$3, d1
00CCC8  ori.b  #$0, d0
00CCCC  ori.b  #$0, d0
00CCD0  ori.b  #$2c, d0
00CCD4  ori.b  #$d0, d0
00CCD8  ori.b  #$2, d1
00CCDC  ori.b  #$0, d0
00CCE0  ori.b  #$0, d0
00CCE4  ori.b  #$2c, d0
00CCE8  ori.b  #$f4, d0
00CCEC  ori.b  #$2, d1
00CCF0  ori.b  #$0, d0
00CCF4  ori.b  #$0, d0
00CCF8  ori.b  #$2c, d0
00CCFC  ori.b  #$0, d0
00CD00  ori.b  #$2, d1
00CD04  ori.b  #$0, d0
00CD08  ori.b  #$0, d0
00CD0C  ori.b  #$2c, d0
00CD10  ori.b  #$e8, d0
00CD14  ori.b  #$2, d1
00CD18  ori.b  #$0, d0
00CD1C  ori.b  #$0, d0
00CD20  ori.b  #$2c, d0
00CD24  ori.b  #$a0, d0
00CD28  ori.b  #$3, d1
00CD2C  ori.b  #$0, d0
00CD30  ori.b  #$0, d0
00CD34  ori.b  #$2c, d0
00CD38  ori.b  #$28, d0
00CD3C  ori.b  #$1, d1
00CD40  ori.b  #$0, d0
00CD44  ori.b  #$0, d0
00CD48  ori.b  #$2c, d0
00CD4C  ori.b  #$34, d0
00CD50  ori.b  #$1, d1
00CD54  ori.b  #$0, d0
00CD58  ori.b  #$0, d0
00CD5C  ori.b  #$2c, d0
00CD60  ori.b  #$40, d0
00CD64  ori.b  #$1, d1
00CD68  ori.b  #$0, d0
00CD6C  ori.b  #$0, d0
00CD70  ori.b  #$2c, d0
00CD74  ori.b  #$4c, d0
00CD78  ori.b  #$1, d1
00CD7C  ori.b  #$0, d0
00CD80  ori.b  #$0, d0
00CD84  ori.b  #$2c, d0
00CD88  ori.b  #$58, d0
00CD8C  ori.b  #$1, d1
00CD90  ori.b  #$0, d0
00CD94  ori.b  #$0, d0
00CD98  ori.b  #$2c, d0
00CD9C  ori.b  #$64, d0
00CDA0  ori.b  #$1, d1
00CDA4  ori.b  #$0, d0
00CDA8  ori.b  #$0, d0
00CDAC  ori.b  #$2c, d0
00CDB0  ori.b  #$70, d0
00CDB4  ori.b  #$1, d1
00CDB8  ori.b  #$0, d0
00CDBC  ori.b  #$0, d0
00CDC0  ori.b  #$2c, d0
00CDC4  ori.b  #$7c, d0
00CDC8  ori.b  #$1, d1
00CDCC  ori.b  #$0, d0
00CDD0  ori.b  #$0, d0
00CDD4  ori.b  #$2c, d0
00CDD8  ori.b  #$88, d0
00CDDC  ori.b  #$2, d1
00CDE0  ori.b  #$0, d0
00CDE4  ori.b  #$0, d0
00CDE8  ori.b  #$2c, d0
00CDEC  ori.b  #$94, d0
00CDF0  ori.b  #$3, d1
00CDF4  ori.b  #$0, d0
00CDF8  ori.b  #$0, d0
00CDFC  ori.b  #$2c, d0
00CE00  ori.b  #$ac, d0
00CE04  ori.b  #$3, d1
00CE08  ori.b  #$0, d0
00CE0C  ori.b  #$0, d0
00CE10  ori.b  #$2c, d0
00CE14  ori.b  #$b8, d0
00CE18  ori.b  #$2, d1
00CE1C  ori.b  #$0, d0
00CE20  ori.b  #$0, d0
00CE24  ori.b  #$2c, d0
00CE28  ori.b  #$c4, d0
00CE2C  ori.b  #$3, d1
00CE30  ori.b  #$0, d0
00CE34  ori.b  #$0, d0
00CE38  ori.b  #$ac, d5
00CE3C  ori.b  #$d0, d5
00CE40  ori.b  #$c4, d5
00CE44  ori.b  #$b8, d5
00CE48  ori.b  #$ac, d5
00CE4C  ori.b  #$ac, d5
00CE50  ori.b  #$dc, d5
00CE54  ori.b  #$0, d5
00CE58  ori.b  #$c, d5
00CE5C  ori.b  #$30, d5
00CE60  ori.b  #$d0, d5
00CE64  ori.b  #$ac, d5
00CE68  ori.b  #$0, d5
00CE6C  ori.b  #$dc, d5
00CE70  ori.b  #$e8, d5
00CE74  ori.b  #$f4, d5
00CE78  ori.b  #$0, d5
00CE7C  ori.b  #$30, d5
00CE80  ori.b  #$c, d5
00CE84  ori.b  #$18, d5
00CE88  ori.b  #$24, d5
00CE8C  ori.b  #$30, d5
00CE90  ori.b  #$48, d5
00CE94  ori.b  #$54, d5
00CE98  ori.b  #$60, d5
00CE9C  ori.b  #$3c, d5
00CEA0  ori.b  #$48, d5
00CEA4  ori.b  #$3c, d5
00CEA8  ori.b  #$60, d5
00CEAC  ori.b  #$c0, d5
00CEB0  ori.b  #$9c, d5
00CEB4  ori.b  #$90, d5
00CEB8  ori.b  #$6c, d5
00CEBC  ori.b  #$3c, d5
00CEC0  ori.b  #$90, d5
00CEC4  ori.b  #$84, d5
00CEC8  ori.b  #$78, d5
00CECC  ori.b  #$6c, d5
00CED0  ori.b  #$90, d5
00CED4  ori.b  #$b4, d5
00CED8  ori.b  #$a8, d5
00CEDC  ori.b  #$9c, d5
00CEE0  ori.b  #$c0, d5
00CEE4  ori.b  #$b4, d5
00CEE8  ori.b  #$ac, d5
00CEEC  ori.b  #$b8, d5
00CEF0  ori.b  #$48, d5
00CEF4  ori.b  #$3c, d5
00CEF8  ori.b  #$ac, d5
00CEFC  ori.b  #$b8, d5
00CF00  ori.b  #$c4, d5
00CF04  ori.b  #$54, d5
00CF08  ori.b  #$48, d5
00CF0C  ori.b  #$b8, d5
00CF10  ori.b  #$24, d5
00CF14  ori.b  #$18, d5
00CF18  ori.b  #$a8, d5
00CF1C  ori.b  #$b4, d5
00CF20  ori.b  #$24, d5
00CF24  ori.b  #$e8, d5
00CF28  ori.b  #$78, d5
00CF2C  ori.b  #$84, d5
00CF30  ori.b  #$f4, d5
00CF34  ori.b  #$e8, d5
00CF38  ori.b  #$78, d5
00CF3C  ori.b  #$e8, d5
00CF40  ori.b  #$dc, d5
00CF44  ori.b  #$6c, d5
00CF48  ori.b  #$78, d5
00CF4C  ori.b  #$3c, d5
00CF50  ori.b  #$6c, d5
00CF54  ori.b  #$dc, d5
00CF58  ori.b  #$ac, d5
00CF5C  ori.b  #$3c, d5
00CF60  ori.b  #$d0, d5
00CF64  ori.b  #$60, d5
00CF68  ori.b  #$54, d5
00CF6C  ori.b  #$c4, d5
00CF70  ori.b  #$d0, d5
00CF74  ori.b  #$d0, d5
00CF78  ori.b  #$30, d5
00CF7C  ori.b  #$c0, d5
00CF80  ori.b  #$60, d5
00CF84  ori.b  #$d0, d5
00CF88  ori.b  #$c0, d5
00CF8C  ori.b  #$30, d5
00CF90  ori.b  #$24, d5
00CF94  ori.b  #$b4, d5
00CF98  ori.b  #$c0, d5
00CF9C  ori.b  #$c, d5
00CFA0  ori.b  #$9c, d5
00CFA4  ori.b  #$a8, d5
00CFA8  ori.b  #$18, d5
00CFAC  ori.b  #$c, d5
00CFB0  ori.b  #$90, d5
00CFB4  ori.b  #$0, d5
00CFB8  ori.b  #$f4, d5
00CFBC  ori.b  #$84, d5
00CFC0  ori.b  #$90, d5
00CFC4  ori.b  #$c, d5
00CFC8  ori.b  #$0, d5
00CFCC  ori.b  #$90, d5
00CFD0  ori.b  #$9c, d5
00CFD4  ori.b  #$c, d5
00CFD8  ori.b  #$f4, d0
00CFDC  ori.b  #$24, d0
00CFE0  ori.b  #$6c, d0
00CFE4  ori.b  #$e4, d0
00CFE8  ; data: 0x00, 0x08
00CFEA  ori.b  #$6, d6
00CFEE  ori.b  #$58, d6
00CFF2  ori.b  #$38, d0
00CFF6  ; data: 0xf9, 0xc0
00CFF8  ; data: 0x00, 0xc8
00CFFA  ; data: 0x00, 0xc8
00CFFC  ; data: 0xf9, 0xc0
00CFFE  ; data: 0x00, 0xc8
00D000  dc.w   $ff38
00D002  addi.w #$c8, d0
00D006  ; data: 0x00, 0xc8
00D008  addi.w #$c8, d0
00D00C  dc.w   $ff38
00D00E  ; data: 0xf9, 0xc0
00D010  dc.w   $ff38
00D012  ; data: 0x00, 0xc8
00D014  ; data: 0xf9, 0xc0
00D016  dc.w   $ff38
00D018  dc.w   $ff38
00D01A  addi.w #$ff38, d0
00D01E  ; data: 0x00, 0xc8
00D020  addi.w #$ff38, d0
00D024  ori.b  #$4, d4
00D028  ori.b  #$5c, d0
00D02C  ori.b  #$5c, d0
00D030  ori.b  #$4, d4
00D034  ori.b  #$70, d0
00D038  ori.b  #$70, d0
00D03C  ori.b  #$4, d4
00D040  ori.b  #$84, d0
00D044  ori.b  #$84, d0
00D048  ori.b  #$4, d4
00D04C  ori.b  #$98, d0
00D050  ori.b  #$98, d0
00D054  ori.b  #$4, d4
00D058  ori.b  #$ac, d0
00D05C  ori.b  #$ac, d0
00D060  ori.b  #$4, d4
00D064  ori.b  #$c0, d0
00D068  ori.b  #$c0, d0
00D06C  ori.b  #$24, d0
00D070  ori.b  #$0, d1
00D074  ori.b  #$cc, d0
00D078  ori.b  #$d0, d0
00D07C  ori.b  #$30, d0
00D080  ori.b  #$0, d1
00D084  ori.b  #$d0, d0
00D088  ori.b  #$d4, d0
00D08C  ori.b  #$3c, d0
00D090  ori.b  #$0, d1
00D094  ori.b  #$d4, d0
00D098  ori.b  #$d8, d0
00D09C  ori.b  #$48, d0
00D0A0  ori.b  #$0, d1
00D0A4  ori.b  #$d8, d0
00D0A8  ori.b  #$dc, d0
00D0AC  ori.b  #$54, d0
00D0B0  ori.b  #$0, d1
00D0B4  ori.b  #$dc, d0
00D0B8  ori.b  #$e0, d0
00D0BC  ori.b  #$60, d0
00D0C0  ori.b  #$0, d1
00D0C4  ori.b  #$e0, d0
00D0C8  ori.b  #$e4, d0
00D0CC  ori.b  #$e4, d0
00D0D0  ori.b  #$f8, d0
00D0D4  ori.b  #$c, d0
00D0D8  ori.b  #$20, d0
00D0DC  ori.b  #$34, d0
00D0E0  ori.b  #$48, d0
00D0E4  ori.b  #$2c, d0
00D0E8  ori.b  #$24, d0
00D0EC  ori.b  #$1, d1
00D0F0  ori.b  #$0, d0
00D0F4  ori.b  #$0, d0
00D0F8  ori.b  #$2c, d0
00D0FC  ori.b  #$30, d0
00D100  ori.b  #$1, d1
00D104  ori.b  #$0, d0
00D108  ori.b  #$0, d0
00D10C  ori.b  #$2c, d0
00D110  ori.b  #$3c, d0
00D114  ori.b  #$2, d1
00D118  ori.b  #$0, d0
00D11C  ori.b  #$0, d0
00D120  ori.b  #$2c, d0
00D124  ori.b  #$48, d0
00D128  ori.b  #$3, d1
00D12C  ori.b  #$0, d0
00D130  ori.b  #$0, d0
00D134  ori.b  #$2c, d0
00D138  ori.b  #$54, d0
00D13C  ori.b  #$2, d1
00D140  ori.b  #$0, d0
00D144  ori.b  #$0, d0
00D148  ori.b  #$2c, d0
00D14C  ori.b  #$60, d0
00D150  ori.b  #$3, d1
00D154  ori.b  #$0, d0
00D158  ori.b  #$0, d0
00D15C  ori.b  #$ac, d5
00D160  ori.b  #$c4, d5
00D164  ori.b  #$d0, d5
00D168  ori.b  #$b8, d5
00D16C  ori.b  #$ac, d5
00D170  ori.b  #$e8, d5
00D174  ori.b  #$0, d5
00D178  ori.b  #$f4, d5
00D17C  ori.b  #$dc, d5
00D180  ori.b  #$e8, d5
00D184  ori.b  #$dc, d5
00D188  ori.b  #$f4, d5
00D18C  ori.b  #$c4, d5
00D190  ori.b  #$ac, d5
00D194  ori.b  #$dc, d5
00D198  ori.b  #$dc, d5
00D19C  ori.b  #$ac, d5
00D1A0  ori.b  #$b8, d5
00D1A4  ori.b  #$e8, d5
00D1A8  ori.b  #$dc, d5
00D1AC  ori.b  #$d0, d5
00D1B0  ori.b  #$0, d5
00D1B4  ori.b  #$e8, d5
00D1B8  ori.b  #$b8, d5
00D1BC  ori.b  #$d0, d5
00D1C0  ori.b  #$c4, d5
00D1C4  ori.b  #$f4, d5
00D1C8  ori.b  #$0, d5
00D1CC  ori.b  #$d0, d5
00D1D0  ori.b  #$c4, d5
00D1D4  ori.b  #$f0, d0
00D1D8  ori.b  #$68, d0
00D1DC  ori.b  #$28, d0
00D1E0  ori.b  #$68, d0
00D1E4  ori.b  #$10, (a4)
00D1E8  ori.b  #$10, (a0)
00D1EC  bset.b d3, (a1)+
00D1EE  ori.b  #$50, d0
00D1F2  ; data: 0xf9, 0xc0
00D1F4  ; data: 0x00, 0xc8
00D1F6  dc.w   $fce0
00D1F8  ; data: 0xf9, 0xc0
00D1FA  ; data: 0x00, 0xc8
00D1FC  btst.l d1, -(a0)
00D1FE  ; data: 0xf9, 0xc0
00D200  ; data: 0x00, 0xc8
00D202  subi.l #$f9c000c8, (a0, invalid.w)
00D20A  addi.w #$c8, d0
00D20E  dc.w   $fce0
00D210  addi.w #$c8, d0
00D214  btst.l d1, -(a0)
00D216  addi.w #$c8, d0
00D21A  subi.l #$64000c8, -$20(a0, a7.l)
00D222  dc.w   $fb50
00D224  ; data: 0x00, 0xc8
00D226  btst.l d1, -(a0)
00D228  subi.l #$c8fb50, (invalid.w)
00D230  dc.w   $ff38
00D232  dc.w   $fce0
00D234  ; data: 0xf9, 0xc0
00D236  dc.w   $ff38
00D238  btst.l d1, -(a0)
00D23A  ; data: 0xf9, 0xc0
00D23C  dc.w   $ff38
00D23E  subi.l #$f9c0ff38, (a0, invalid.w)
00D246  addi.w #$ff38, d0
00D24A  dc.w   $fce0
00D24C  addi.w #$ff38, d0
00D250  btst.l d1, -(a0)
00D252  addi.w #$ff38, d0
00D256  subi.l #$640ff38, -$20(a0, a7.l)
00D25E  dc.w   $fb50
00D260  dc.w   $ff38
00D262  btst.l d1, -(a0)
00D264  subi.l #$ff380005, $5(a0, d0.w)
00D26C  ori.b  #$a8, d0
00D270  ori.b  #$a8, d0
00D274  ori.b  #$5, d5
00D278  ori.b  #$c0, d0
00D27C  ori.b  #$c0, d0
00D280  ori.b  #$4, d4
00D284  ori.b  #$d8, d0
00D288  ori.b  #$d8, d0
00D28C  ori.b  #$5, d5
00D290  ori.b  #$ec, d0
00D294  ori.b  #$ec, d0
00D298  ori.b  #$5, d5
00D29C  ori.b  #$4, d0
00D2A0  ori.b  #$4, d0
00D2A4  ori.b  #$4, d4
00D2A8  ori.b  #$1c, d0
00D2AC  ori.b  #$1c, d0
00D2B0  ori.b  #$4, d4
00D2B4  ori.b  #$30, d0
00D2B8  ori.b  #$30, d0
00D2BC  ori.b  #$4, d4
00D2C0  ori.b  #$44, d0
00D2C4  ori.b  #$44, d0
00D2C8  ori.b  #$4, d4
00D2CC  ori.b  #$58, d0
00D2D0  ori.b  #$58, d0
00D2D4  ori.b  #$4, d4
00D2D8  ori.b  #$6c, d0
00D2DC  ori.b  #$6c, d0
00D2E0  ori.b  #$4, d4
00D2E4  ori.b  #$80, d0
00D2E8  ori.b  #$80, d0
00D2EC  ori.b  #$4, d4
00D2F0  ori.b  #$94, d0
00D2F4  ori.b  #$94, d0
00D2F8  ori.b  #$4, d4
00D2FC  ori.b  #$a8, d0
00D300  ori.b  #$a8, d0
00D304  ori.b  #$4, d4
00D308  ori.b  #$bc, d0
00D30C  ori.b  #$bc, d0
00D310  ori.b  #$4, d4
00D314  ori.b  #$d0, d0
00D318  ori.b  #$d0, d0
00D31C  ori.b  #$4, d4
00D320  ori.b  #$e4, d0
00D324  ori.b  #$e4, d0
00D328  ori.b  #$68, d0
00D32C  ori.b  #$0, d1
00D330  ori.b  #$28, d0
00D334  ori.b  #$2c, d0
00D338  ori.b  #$74, d0
00D33C  ori.b  #$0, d1
00D340  ori.b  #$2c, d0
00D344  ori.b  #$30, d0
00D348  ori.b  #$80, d0
00D34C  ori.b  #$0, d1
00D350  ori.b  #$30, d0
00D354  ori.b  #$34, d0
00D358  ori.b  #$8c, d0
00D35C  ori.b  #$0, d1
00D360  ori.b  #$34, d0
00D364  ori.b  #$38, d0
00D368  ori.b  #$98, d0
00D36C  ori.b  #$0, d1
00D370  ori.b  #$38, d0
00D374  ori.b  #$3c, d0
00D378  ori.b  #$a4, d0
00D37C  ori.b  #$0, d1
00D380  ori.b  #$3c, d0
00D384  ori.b  #$40, d0
00D388  ori.b  #$b0, d0
00D38C  ori.b  #$0, d1
00D390  ori.b  #$40, d0
00D394  ori.b  #$44, d0
00D398  ori.b  #$bc, d0
00D39C  ori.b  #$0, d1
00D3A0  ori.b  #$44, d0
00D3A4  ori.b  #$48, d0
00D3A8  ori.b  #$c8, d0
00D3AC  ori.b  #$0, d1
00D3B0  ori.b  #$48, d0
00D3B4  ori.b  #$4c, d0
00D3B8  ori.b  #$d4, d0
00D3BC  ori.b  #$0, d1
00D3C0  ori.b  #$4c, d0
00D3C4  ori.b  #$50, d0
00D3C8  ori.b  #$e0, d0
00D3CC  ori.b  #$0, d1
00D3D0  ori.b  #$50, d0
00D3D4  ori.b  #$54, d0
00D3D8  ori.b  #$ec, d0
00D3DC  ori.b  #$0, d1
00D3E0  ori.b  #$54, d0
00D3E4  ori.b  #$58, d0
00D3E8  ori.b  #$f8, d0
00D3EC  ori.b  #$0, d1
00D3F0  ori.b  #$58, d0
00D3F4  ori.b  #$5c, d0
00D3F8  ori.b  #$4, d0
00D3FC  ori.b  #$0, d1
00D400  ori.b  #$5c, d0
00D404  ori.b  #$60, d0
00D408  ori.b  #$10, d0
00D40C  ori.b  #$0, d1
00D410  ori.b  #$60, d0
00D414  ori.b  #$64, d0
00D418  ori.b  #$1c, d0
00D41C  ori.b  #$0, d1
00D420  ori.b  #$64, d0
00D424  ori.b  #$68, d0
00D428  ori.b  #$b8, d0
00D42C  ori.b  #$cc, d0
00D430  ori.b  #$e0, d0
00D434  ori.b  #$f4, d0
00D438  ori.b  #$8, d0
00D43C  ori.b  #$1c, d0
00D440  ori.b  #$30, d0
00D444  ori.b  #$44, d0
00D448  ori.b  #$58, d0
00D44C  ori.b  #$6c, d0
00D450  ori.b  #$80, d0
00D454  ori.b  #$94, d0
00D458  ori.b  #$7c, d0
00D45C  ori.b  #$90, d0
00D460  ori.b  #$a4, d0
00D464  ori.b  #$68, d0
00D468  ori.b  #$2c, d0
00D46C  ori.b  #$1c, d0
00D470  ori.b  #$3, d1
00D474  ori.b  #$0, d0
00D478  ori.b  #$0, d0
00D47C  ori.b  #$2c, d0
00D480  ori.b  #$f8, d0
00D484  ori.b  #$2, d1
00D488  ori.b  #$0, d0
00D48C  ori.b  #$0, d0
00D490  ori.b  #$2c, d0
00D494  ori.b  #$4, d0
00D498  ori.b  #$3, d1
00D49C  ori.b  #$0, d0
00D4A0  ori.b  #$0, d0
00D4A4  ori.b  #$2c, d0
00D4A8  ori.b  #$10, d0
00D4AC  ori.b  #$2, d1
00D4B0  ori.b  #$0, d0
00D4B4  ori.b  #$0, d0
00D4B8  ori.b  #$2c, d0
00D4BC  ori.b  #$68, d0
00D4C0  ori.b  #$1, d1
00D4C4  ori.b  #$0, d0
00D4C8  ori.b  #$0, d0
00D4CC  ori.b  #$2c, d0
00D4D0  ori.b  #$74, d0
00D4D4  ori.b  #$1, d1
00D4D8  ori.b  #$0, d0
00D4DC  ori.b  #$0, d0
00D4E0  ori.b  #$2c, d0
00D4E4  ori.b  #$80, d0
00D4E8  ori.b  #$1, d1
00D4EC  ori.b  #$0, d0
00D4F0  ori.b  #$0, d0
00D4F4  ori.b  #$2c, d0
00D4F8  ori.b  #$8c, d0
00D4FC  ori.b  #$1, d1
00D500  ori.b  #$0, d0
00D504  ori.b  #$0, d0
00D508  ori.b  #$2c, d0
00D50C  ori.b  #$98, d0
00D510  ori.b  #$1, d1
00D514  ori.b  #$0, d0
00D518  ori.b  #$0, d0
00D51C  ori.b  #$2c, d0
00D520  ori.b  #$a4, d0
00D524  ori.b  #$1, d1
00D528  ori.b  #$0, d0
00D52C  ori.b  #$0, d0
00D530  ori.b  #$2c, d0
00D534  ori.b  #$b0, d0
00D538  ori.b  #$2, d1
00D53C  ori.b  #$0, d0
00D540  ori.b  #$0, d0
00D544  ori.b  #$2c, d0
00D548  ori.b  #$bc, d0
00D54C  ori.b  #$3, d1
00D550  ori.b  #$0, d0
00D554  ori.b  #$0, d0
00D558  ori.b  #$2c, d0
00D55C  ori.b  #$c8, d0
00D560  ori.b  #$2, d1
00D564  ori.b  #$0, d0
00D568  ori.b  #$0, d0
00D56C  ori.b  #$2c, d0
00D570  ori.b  #$d4, d0
00D574  ori.b  #$3, d1
00D578  ori.b  #$0, d0
00D57C  ori.b  #$0, d0
00D580  ori.b  #$2c, d0
00D584  ori.b  #$e0, d0
00D588  ori.b  #$2, d1
00D58C  ori.b  #$0, d0
00D590  ori.b  #$0, d0
00D594  ori.b  #$2c, d0
00D598  ori.b  #$ec, d0
00D59C  ori.b  #$3, d1
00D5A0  ori.b  #$0, d0
00D5A4  ori.b  #$0, d0
00D5A8  ori.b  #$dc, d5
00D5AC  ori.b  #$e8, d5
00D5B0  ori.b  #$c, d5
00D5B4  ori.b  #$b8, d5
00D5B8  ori.b  #$ac, d5
00D5BC  ori.b  #$dc, d5
00D5C0  ori.b  #$18, d5
00D5C4  ori.b  #$f4, d5
00D5C8  ori.b  #$0, d5
00D5CC  ori.b  #$d0, d5
00D5D0  ori.b  #$c4, d5
00D5D4  ori.b  #$18, d5
00D5D8  ori.b  #$b8, d5
00D5DC  ori.b  #$c, d5
00D5E0  ori.b  #$f4, d5
00D5E4  ori.b  #$18, d5
00D5E8  ori.b  #$b8, d5
00D5EC  ori.b  #$84, d5
00D5F0  ori.b  #$60, d5
00D5F4  ori.b  #$54, d5
00D5F8  ori.b  #$24, d5
00D5FC  ori.b  #$30, d5
00D600  ori.b  #$84, d5
00D604  ori.b  #$48, d5
00D608  ori.b  #$78, d5
00D60C  ori.b  #$6c, d5
00D610  ori.b  #$90, d5
00D614  ori.b  #$3c, d5
00D618  ori.b  #$48, d5
00D61C  ori.b  #$90, d5
00D620  ori.b  #$6c, d5
00D624  ori.b  #$84, d5
00D628  ori.b  #$30, d5
00D62C  ori.b  #$90, d5
00D630  ori.b  #$24, d5
00D634  ori.b  #$54, d5
00D638  ori.b  #$dc, d5
00D63C  ori.b  #$ac, d5
00D640  ori.b  #$24, d5
00D644  ori.b  #$24, d5
00D648  ori.b  #$ac, d5
00D64C  ori.b  #$b8, d5
00D650  ori.b  #$30, d5
00D654  ori.b  #$24, d5
00D658  ori.b  #$3c, d5
00D65C  ori.b  #$c4, d5
00D660  ori.b  #$d0, d5
00D664  ori.b  #$48, d5
00D668  ori.b  #$3c, d5
00D66C  ori.b  #$d0, d5
00D670  ori.b  #$0, d5
00D674  ori.b  #$78, d5
00D678  ori.b  #$48, d5
00D67C  ori.b  #$d0, d5
00D680  ori.b  #$f4, d5
00D684  ori.b  #$6c, d5
00D688  ori.b  #$78, d5
00D68C  ori.b  #$0, d5
00D690  ori.b  #$f4, d5
00D694  ori.b  #$dc, d5
00D698  ori.b  #$54, d5
00D69C  ori.b  #$60, d5
00D6A0  ori.b  #$e8, d5
00D6A4  ori.b  #$dc, d5
00D6A8  ori.b  #$b8, d5
00D6AC  ori.b  #$18, d5
00D6B0  ori.b  #$90, d5
00D6B4  ori.b  #$30, d5
00D6B8  ori.b  #$b8, d5
00D6BC  ori.b  #$3c, d5
00D6C0  ori.b  #$90, d5
00D6C4  ori.b  #$18, d5
00D6C8  ori.b  #$c4, d5
00D6CC  ori.b  #$3c, d5
00D6D0  ori.b  #$c, d5
00D6D4  ori.b  #$e8, d5
00D6D8  ori.b  #$60, d5
00D6DC  ori.b  #$84, d5
00D6E0  ori.b  #$c, d5
00D6E4  ori.b  #$84, d5
00D6E8  ori.b  #$6c, d5
00D6EC  ori.b  #$f4, d5
00D6F0  ori.b  #$c, d5
00D6F4  ori.b  #$84, d5
00D6F8  ori.b  #$14, d0
00D6FC  ori.b  #$a4, d0
00D700  ori.b  #$94, d0
00D704  ori.b  #$4c, d0
00D708  ori.b  #$14, (a0)+
00D70C  ori.b  #$16, (a4)
00D710  bset.b d3, (a1)+
00D712  ori.b  #$50, d0
00D716  ; data: 0xf9, 0xc0
00D718  ; data: 0x00, 0xc8
00D71A  dc.w   $fce0
00D71C  ; data: 0xf9, 0xc0
00D71E  ; data: 0x00, 0xc8
00D720  ori.b  #$e0, d0
00D724  ; data: 0x00, 0xc8
00D726  btst.l d1, -(a0)
00D728  ; data: 0xf9, 0xc0
00D72A  ; data: 0x00, 0xc8
00D72C  subi.l #$f9c000c8, -$50(a0, d0.w)
00D734  addi.w #$c8, d0
00D738  btst.l d1, -(a0)
00D73A  addi.w #$c8, d0
00D73E  btst.l d1, -(a0)
00D740  dc.w   $fce0
00D742  ; data: 0x00, 0xc8
00D744  ori.b  #$0, d0
00D748  ; data: 0x00, 0xc8
00D74A  dc.w   $fce0
00D74C  dc.w   $fce0
00D74E  ; data: 0x00, 0xc8
00D750  dc.w   $fce0
00D752  addi.w #$c8, d0
00D756  dc.w   $fb50
00D758  addi.w #$c8, d0
00D75C  dc.w   $fb50
00D75E  ; data: 0xf9, 0xc0
00D760  dc.w   $ff38
00D762  dc.w   $fce0
00D764  ; data: 0xf9, 0xc0
00D766  dc.w   $ff38
00D768  ori.b  #$e0, d0
00D76C  dc.w   $ff38
00D76E  btst.l d1, -(a0)
00D770  ; data: 0xf9, 0xc0
00D772  dc.w   $ff38
00D774  subi.l #$f9c0ff38, -$50(a0, d0.w)
00D77C  addi.w #$ff38, d0
00D780  btst.l d1, -(a0)
00D782  addi.w #$ff38, d0
00D786  btst.l d1, -(a0)
00D788  dc.w   $fce0
00D78A  dc.w   $ff38
00D78C  ori.b  #$0, d0
00D790  dc.w   $ff38
00D792  dc.w   $fce0
00D794  dc.w   $fce0
00D796  dc.w   $ff38
00D798  dc.w   $fce0
00D79A  addi.w #$ff38, d0
00D79E  dc.w   $fb50
00D7A0  addi.w #$ff38, d0
00D7A4  ori.b  #$5, d5
00D7A8  ori.b  #$4, d0
00D7AC  ori.b  #$4, d0
00D7B0  ori.b  #$4, d4
00D7B4  ori.b  #$1c, d0
00D7B8  ori.b  #$1c, d0
00D7BC  ori.b  #$4, d4
00D7C0  ori.b  #$30, d0
00D7C4  ori.b  #$30, d0
00D7C8  ori.b  #$5, d5
00D7CC  ori.b  #$44, d0
00D7D0  ori.b  #$44, d0
00D7D4  ori.b  #$5, d5
00D7D8  ori.b  #$5c, d0
00D7DC  ori.b  #$5c, d0
00D7E0  ori.b  #$4, d4
00D7E4  ori.b  #$74, d0
00D7E8  ori.b  #$74, d0
00D7EC  ori.b  #$4, d4
00D7F0  ori.b  #$88, d0
00D7F4  ori.b  #$88, d0
00D7F8  ori.b  #$5, d5
00D7FC  ori.b  #$9c, d0
00D800  ori.b  #$9c, d0
00D804  ori.b  #$4, d4
00D808  ori.b  #$b4, d0
00D80C  ori.b  #$b4, d0
00D810  ori.b  #$4, d4
00D814  ori.b  #$c8, d0
00D818  ori.b  #$c8, d0
00D81C  ori.b  #$4, d4
00D820  ori.b  #$dc, d0
00D824  ori.b  #$dc, d0
00D828  ori.b  #$4, d4
00D82C  ori.b  #$f0, d0
00D830  ori.b  #$f0, d0
00D834  ori.b  #$4, d4
00D838  ori.b  #$4, d0
00D83C  ori.b  #$4, d0
00D840  ori.b  #$4, d4
00D844  ori.b  #$18, d0
00D848  ori.b  #$18, d0
00D84C  ori.b  #$4, d4
00D850  ori.b  #$2c, d0
00D854  ori.b  #$2c, d0
00D858  ori.b  #$4, d4
00D85C  ori.b  #$40, d0
00D860  ori.b  #$40, d0
00D864  ori.b  #$4, d4
00D868  ori.b  #$54, d0
00D86C  ori.b  #$54, d0
00D870  ori.b  #$4, d4
00D874  ori.b  #$68, d0
00D878  ori.b  #$68, d0
00D87C  ori.b  #$4, d4
00D880  ori.b  #$7c, d0
00D884  ori.b  #$7c, d0
00D888  ori.b  #$4, d4
00D88C  ori.b  #$90, d0
00D890  ori.b  #$90, d0
00D894  ori.b  #$a4, d0
00D898  ori.b  #$0, d1
00D89C  ori.b  #$d4, d0
00D8A0  ori.b  #$d8, d0
00D8A4  ori.b  #$b0, d0
00D8A8  ori.b  #$0, d1
00D8AC  ori.b  #$d8, d0
00D8B0  ori.b  #$dc, d0
00D8B4  ori.b  #$bc, d0
00D8B8  ori.b  #$0, d1
00D8BC  ori.b  #$dc, d0
00D8C0  ori.b  #$e0, d0
00D8C4  ori.b  #$c8, d0
00D8C8  ori.b  #$0, d1
00D8CC  ori.b  #$e0, d0
00D8D0  ori.b  #$e4, d0
00D8D4  ori.b  #$d4, d0
00D8D8  ori.b  #$0, d1
00D8DC  ori.b  #$e4, d0
00D8E0  ori.b  #$e8, d0
00D8E4  ori.b  #$e0, d0
00D8E8  ori.b  #$0, d1
00D8EC  ori.b  #$e8, d0
00D8F0  ori.b  #$ec, d0
00D8F4  ori.b  #$ec, d0
00D8F8  ori.b  #$0, d1
00D8FC  ori.b  #$ec, d0
00D900  ori.b  #$f0, d0
00D904  ori.b  #$f8, d0
00D908  ori.b  #$0, d1
00D90C  ori.b  #$f0, d0
00D910  ori.b  #$f4, d0
00D914  ori.b  #$4, d0
00D918  ori.b  #$0, d1
00D91C  ori.b  #$f4, d0
00D920  ori.b  #$f8, d0
00D924  ori.b  #$10, d0
00D928  ori.b  #$4, d5
00D92C  ori.b  #$f8, d0
00D930  ori.b  #$c, d0
00D934  ori.b  #$1c, d0
00D938  ori.b  #$0, d1
00D93C  ori.b  #$1c, d0
00D940  ori.b  #$20, d0
00D944  ori.b  #$28, d0
00D948  ori.b  #$0, d1
00D94C  ori.b  #$20, d0
00D950  ori.b  #$24, d0
00D954  ori.b  #$34, d0
00D958  ori.b  #$0, d1
00D95C  ori.b  #$24, d0
00D960  ori.b  #$28, d0
00D964  ori.b  #$40, d0
00D968  ori.b  #$0, d1
00D96C  ori.b  #$28, d0
00D970  ori.b  #$2c, d0
00D974  ori.b  #$4c, d0
00D978  ori.b  #$0, d1
00D97C  ori.b  #$2c, d0
00D980  ori.b  #$30, d0
00D984  ori.b  #$58, d0
00D988  ori.b  #$0, d1
00D98C  ori.b  #$30, d0
00D990  ori.b  #$34, d0
00D994  ori.b  #$64, d0
00D998  ori.b  #$0, d2
00D99C  ori.b  #$34, d0
00D9A0  ori.b  #$3c, d0
00D9A4  ori.b  #$70, d0
00D9A8  ori.b  #$0, d2
00D9AC  ori.b  #$3c, d0
00D9B0  ori.b  #$44, d0
00D9B4  ori.b  #$7c, d0
00D9B8  ori.b  #$0, d1
00D9BC  ori.b  #$44, d0
00D9C0  ori.b  #$48, d0
00D9C4  ori.b  #$88, d0
00D9C8  ori.b  #$0, d1
00D9CC  ori.b  #$48, d0
00D9D0  ori.b  #$4c, d0
00D9D4  ori.b  #$ec, d0
00D9D8  ori.b  #$0, d0
00D9DC  ori.b  #$14, d0
00D9E0  ori.b  #$28, d0
00D9E4  ori.b  #$3c, d0
00D9E8  ori.b  #$50, d0
00D9EC  ori.b  #$64, d0
00D9F0  ori.b  #$78, d0
00D9F4  ori.b  #$8c, d0
00D9F8  ori.b  #$a0, d0
00D9FC  ori.b  #$88, d0
00DA00  ori.b  #$88, d0
00DA04  ori.b  #$74, d0
00DA08  ori.b  #$74, d0
00DA0C  ori.b  #$d8, d0
00DA10  ori.b  #$d8, d0
00DA14  ori.b  #$c4, d0
00DA18  ori.b  #$c4, d0
00DA1C  ori.b  #$b4, d0
00DA20  ori.b  #$c8, d0
00DA24  ori.b  #$dc, d0
00DA28  ori.b  #$f0, d0
00DA2C  ori.b  #$9c, d0
00DA30  ori.b  #$b0, d0
00DA34  ori.b  #$c4, d0
00DA38  ori.b  #$74, d0
00DA3C  ori.b  #$d8, d0
00DA40  ori.b  #$88, d0
00DA44  ori.b  #$4c, d0
00DA48  ori.b  #$60, d0
00DA4C  ori.b  #$2c, d0
00DA50  ori.b  #$7c, d0
00DA54  ori.b  #$2, d1
00DA58  ori.b  #$0, d0
00DA5C  ori.b  #$0, d0
00DA60  ori.b  #$2c, d0
00DA64  ori.b  #$88, d0
00DA68  ori.b  #$3, d1
00DA6C  ori.b  #$0, d0
00DA70  ori.b  #$0, d0
00DA74  ori.b  #$2c, d0
00DA78  ori.b  #$64, d0
00DA7C  ori.b  #$2, d1
00DA80  ori.b  #$0, d0
00DA84  ori.b  #$0, d0
00DA88  ori.b  #$2c, d0
00DA8C  ori.b  #$70, d0
00DA90  ori.b  #$3, d1
00DA94  ori.b  #$0, d0
00DA98  ori.b  #$0, d0
00DA9C  ori.b  #$2c, d0
00DAA0  ori.b  #$4c, d0
00DAA4  ori.b  #$2, d1
00DAA8  ori.b  #$0, d0
00DAAC  ori.b  #$0, d0
00DAB0  ori.b  #$2c, d0
00DAB4  ori.b  #$58, d0
00DAB8  ori.b  #$3, d1
00DABC  ori.b  #$0, d0
00DAC0  ori.b  #$0, d0
00DAC4  ori.b  #$2c, d0
00DAC8  ori.b  #$64, d0
00DACC  ori.b  #$2, d1
00DAD0  ori.b  #$0, d0
00DAD4  ori.b  #$0, d0
00DAD8  ori.b  #$2c, d0
00DADC  ori.b  #$70, d0
00DAE0  ori.b  #$3, d1
00DAE4  ori.b  #$0, d0
00DAE8  ori.b  #$0, d0
00DAEC  ori.b  #$2c, d0
00DAF0  ori.b  #$a4, d0
00DAF4  ori.b  #$1, d1
00DAF8  ori.b  #$0, d0
00DAFC  ori.b  #$0, d0
00DB00  ori.b  #$2c, d0
00DB04  ori.b  #$b0, d0
00DB08  ori.b  #$1, d1
00DB0C  ori.b  #$0, d0
00DB10  ori.b  #$0, d0
00DB14  ori.b  #$2c, d0
00DB18  ori.b  #$bc, d0
00DB1C  ori.b  #$1, d1
00DB20  ori.b  #$0, d0
00DB24  ori.b  #$0, d0
00DB28  ori.b  #$2c, d0
00DB2C  ori.b  #$c8, d0
00DB30  ori.b  #$1, d1
00DB34  ori.b  #$0, d0
00DB38  ori.b  #$0, d0
00DB3C  ori.b  #$2c, d0
00DB40  ori.b  #$d4, d0
00DB44  ori.b  #$1, d1
00DB48  ori.b  #$0, d0
00DB4C  ori.b  #$0, d0
00DB50  ori.b  #$2c, d0
00DB54  ori.b  #$e0, d0
00DB58  ori.b  #$1, d1
00DB5C  ori.b  #$0, d0
00DB60  ori.b  #$0, d0
00DB64  ori.b  #$2c, d0
00DB68  ori.b  #$ec, d0
00DB6C  ori.b  #$1, d1
00DB70  ori.b  #$0, d0
00DB74  ori.b  #$0, d0
00DB78  ori.b  #$2c, d0
00DB7C  ori.b  #$f8, d0
00DB80  ori.b  #$1, d1
00DB84  ori.b  #$0, d0
00DB88  ori.b  #$0, d0
00DB8C  ori.b  #$2c, d0
00DB90  ori.b  #$4, d0
00DB94  ori.b  #$2, d1
00DB98  ori.b  #$0, d0
00DB9C  ori.b  #$0, d0
00DBA0  ori.b  #$2c, d0
00DBA4  ori.b  #$10, d0
00DBA8  ori.b  #$3, d1
00DBAC  ori.b  #$0, d0
00DBB0  ori.b  #$0, d0
00DBB4  ori.b  #$2c, d0
00DBB8  ori.b  #$1c, d0
00DBBC  ori.b  #$2, d1
00DBC0  ori.b  #$0, d0
00DBC4  ori.b  #$0, d0
00DBC8  ori.b  #$2c, d0
00DBCC  ori.b  #$28, d0
00DBD0  ori.b  #$3, d1
00DBD4  ori.b  #$0, d0
00DBD8  ori.b  #$0, d0
00DBDC  ori.b  #$2c, d0
00DBE0  ori.b  #$34, d0
00DBE4  ori.b  #$2, d1
00DBE8  ori.b  #$0, d0
00DBEC  ori.b  #$0, d0
00DBF0  ori.b  #$2c, d0
00DBF4  ori.b  #$40, d0
00DBF8  ori.b  #$3, d1
00DBFC  ori.b  #$0, d0
00DC00  ori.b  #$0, d0
00DC04  ori.b  #$30, d5
00DC08  ori.b  #$24, d5
00DC0C  ori.b  #$18, d5
00DC10  ori.b  #$b8, d5
00DC14  ori.b  #$ac, d5
00DC18  ori.b  #$30, d5
00DC1C  ori.b  #$18, d5
00DC20  ori.b  #$c, d5
00DC24  ori.b  #$c4, d5
00DC28  ori.b  #$b8, d5
00DC2C  ori.b  #$18, d5
00DC30  ori.b  #$c, d5
00DC34  ori.b  #$0, d5
00DC38  ori.b  #$d0, d5
00DC3C  ori.b  #$c4, d5
00DC40  ori.b  #$c, d5
00DC44  ori.b  #$f4, d5
00DC48  ori.b  #$e8, d5
00DC4C  ori.b  #$dc, d5
00DC50  ori.b  #$d0, d5
00DC54  ori.b  #$0, d5
00DC58  ori.b  #$f4, d5
00DC5C  ori.b  #$3c, d5
00DC60  ori.b  #$48, d5
00DC64  ori.b  #$a8, d5
00DC68  ori.b  #$b4, d5
00DC6C  ori.b  #$c0, d5
00DC70  ori.b  #$3c, d5
00DC74  ori.b  #$54, d5
00DC78  ori.b  #$9c, d5
00DC7C  ori.b  #$a8, d5
00DC80  ori.b  #$48, d5
00DC84  ori.b  #$54, d5
00DC88  ori.b  #$60, d5
00DC8C  ori.b  #$90, d5
00DC90  ori.b  #$9c, d5
00DC94  ori.b  #$54, d5
00DC98  ori.b  #$60, d5
00DC9C  ori.b  #$6c, d5
00DCA0  ori.b  #$78, d5
00DCA4  ori.b  #$84, d5
00DCA8  ori.b  #$90, d5
00DCAC  ori.b  #$60, d5
00DCB0  ori.b  #$6c, d5
00DCB4  ori.b  #$3c, d5
00DCB8  ori.b  #$c0, d5
00DCBC  ori.b  #$30, d5
00DCC0  ori.b  #$ac, d5
00DCC4  ori.b  #$3c, d5
00DCC8  ori.b  #$3c, d5
00DCCC  ori.b  #$ac, d5
00DCD0  ori.b  #$b8, d5
00DCD4  ori.b  #$48, d5
00DCD8  ori.b  #$3c, d5
00DCDC  ori.b  #$60, d5
00DCE0  ori.b  #$d0, d5
00DCE4  ori.b  #$dc, d5
00DCE8  ori.b  #$6c, d5
00DCEC  ori.b  #$60, d5
00DCF0  ori.b  #$dc, d5
00DCF4  ori.b  #$e8, d5
00DCF8  ori.b  #$78, d5
00DCFC  ori.b  #$6c, d5
00DD00  ori.b  #$dc, d5
00DD04  ori.b  #$f4, d5
00DD08  ori.b  #$84, d5
00DD0C  ori.b  #$78, d5
00DD10  ori.b  #$e8, d5
00DD14  ori.b  #$f4, d5
00DD18  ori.b  #$30, d5
00DD1C  ori.b  #$c0, d5
00DD20  ori.b  #$b4, d5
00DD24  ori.b  #$24, d5
00DD28  ori.b  #$30, d5
00DD2C  ori.b  #$18, d5
00DD30  ori.b  #$a8, d5
00DD34  ori.b  #$9c, d5
00DD38  ori.b  #$c, d5
00DD3C  ori.b  #$18, d5
00DD40  ori.b  #$c, d5
00DD44  ori.b  #$9c, d5
00DD48  ori.b  #$90, d5
00DD4C  ori.b  #$0, d5
00DD50  ori.b  #$c, d5
00DD54  ori.b  #$48, d5
00DD58  ori.b  #$b8, d5
00DD5C  ori.b  #$c4, d5
00DD60  ori.b  #$54, d5
00DD64  ori.b  #$48, d5
00DD68  ori.b  #$54, d5
00DD6C  ori.b  #$c4, d5
00DD70  ori.b  #$d0, d5
00DD74  ori.b  #$60, d5
00DD78  ori.b  #$54, d5
00DD7C  ori.b  #$18, d5
00DD80  ori.b  #$24, d5
00DD84  ori.b  #$b4, d5
00DD88  ori.b  #$a8, d5
00DD8C  ori.b  #$18, d5
00DD90  ori.b  #$90, d5
00DD94  ori.b  #$84, d5
00DD98  ori.b  #$f4, d5
00DD9C  ori.b  #$0, d5
00DDA0  ori.b  #$90, d5
00DDA4  ori.b  #$c0, d0
00DDA8  ori.b  #$20, d0
00DDAC  ori.b  #$e0, d0
00DDB0  ori.b  #$20, d0
00DDB4  ori.b  #$10, (a0)
00DDB8  ori.b  #$10, (a0)
00DDBC  ; data: 0x06, 0x4c
00DDBE  ori.b  #$0, d0
00DDC2  ; data: 0xf9, 0xc0
00DDC4  ; data: 0x00, 0xc8
00DDC6  ori.b  #$e0, d0
00DDCA  ; data: 0x00, 0xc8
00DDCC  ori.b  #$40, d0
00DDD0  ; data: 0x00, 0xc8
00DDD2  ori.b  #$20, d0
00DDD6  ; data: 0x00, 0xc8
00DDD8  dc.w   $fb50
00DDDA  ori.b  #$c8, d0
00DDDE  dc.w   $fe70
00DDE0  ori.b  #$c8, d0
00DDE4  bclr.b d0, (a0)
00DDE6  ori.b  #$c8, d0
00DDEA  subi.l #$c8, (a0, d0.w)
00DDF2  ; data: 0xf9, 0xc0
00DDF4  dc.w   $ff38
00DDF6  ori.b  #$e0, d0
00DDFA  dc.w   $ff38
00DDFC  ori.b  #$40, d0
00DE00  dc.w   $ff38
00DE02  ori.b  #$20, d0
00DE06  dc.w   $ff38
00DE08  dc.w   $fb50
00DE0A  ori.b  #$38, d0
00DE0E  dc.w   $fe70
00DE10  ori.b  #$38, d0
00DE14  bclr.b d0, (a0)
00DE16  ori.b  #$38, d0
00DE1A  subi.l #$ff38, $4(a0, d0.w)
00DE22  ori.b  #$0, d4
00DE26  asl.w  d0, d0
00DE28  ori.b  #$60, d0
00DE2C  ori.b  #$4, d4
00DE30  ori.b  #$74, d0
00DE34  ori.b  #$74, d0
00DE38  ori.b  #$4, d4
00DE3C  ori.b  #$88, d0
00DE40  ori.b  #$88, d0
00DE44  ori.b  #$4, d4
00DE48  ori.b  #$9c, d0
00DE4C  ori.b  #$9c, d0
00DE50  ori.b  #$4, d4
00DE54  ori.b  #$b0, d0
00DE58  ori.b  #$b0, d0
00DE5C  ori.b  #$4, d4
00DE60  ori.b  #$c4, d0
00DE64  ori.b  #$c4, d0
00DE68  ori.b  #$4, d4
00DE6C  ori.b  #$d8, d0
00DE70  ori.b  #$d8, d0
00DE74  ori.b  #$4, d4
00DE78  ori.b  #$ec, d0
00DE7C  ori.b  #$ec, d0
00DE80  ori.b  #$4, d4
00DE84  ori.b  #$0, d0
00DE88  ori.b  #$0, d0
00DE8C  ori.b  #$4, d4
00DE90  ori.b  #$14, d0
00DE94  ori.b  #$14, d0
00DE98  ori.b  #$4, d4
00DE9C  ori.b  #$28, d0
00DEA0  ori.b  #$28, d0
00DEA4  ori.b  #$4, d4
00DEA8  ori.b  #$3c, d0
00DEAC  ori.b  #$3c, d0
00DEB0  ori.b  #$4, d4
00DEB4  ori.b  #$50, d0
00DEB8  ori.b  #$50, d0
00DEBC  ori.b  #$4, d4
00DEC0  ori.b  #$64, d0
00DEC4  ori.b  #$64, d0
00DEC8  ori.b  #$4, d4
00DECC  ori.b  #$78, d0
00DED0  ori.b  #$78, d0
00DED4  ori.b  #$4, d4
00DED8  ori.b  #$8c, d0
00DEDC  ori.b  #$8c, d0
00DEE0  ori.b  #$20, d0
00DEE4  ori.b  #$0, d1
00DEE8  ori.b  #$e0, d0
00DEEC  ori.b  #$e4, d0
00DEF0  ori.b  #$2c, d0
00DEF4  ori.b  #$0, d1
00DEF8  ori.b  #$e4, d0
00DEFC  ori.b  #$e8, d0
00DF00  ori.b  #$38, d0
00DF04  ori.b  #$0, d1
00DF08  ori.b  #$e8, d0
00DF0C  ori.b  #$ec, d0
00DF10  ori.b  #$44, d0
00DF14  ori.b  #$0, d1
00DF18  ori.b  #$ec, d0
00DF1C  ori.b  #$f0, d0
00DF20  ori.b  #$50, d0
00DF24  ori.b  #$0, d1
00DF28  ori.b  #$f0, d0
00DF2C  ori.b  #$f4, d0
00DF30  ori.b  #$5c, d0
00DF34  ori.b  #$0, d1
00DF38  ori.b  #$f4, d0
00DF3C  ori.b  #$f8, d0
00DF40  ori.b  #$68, d0
00DF44  ori.b  #$0, d1
00DF48  ori.b  #$f8, d0
00DF4C  ori.b  #$fc, d0
00DF50  ori.b  #$74, d0
00DF54  ori.b  #$0, d1
00DF58  ori.b  #$fc, d0
00DF5C  ori.b  #$0, d0
00DF60  ori.b  #$80, d0
00DF64  ori.b  #$0, d1
00DF68  ori.b  #$0, d0
00DF6C  ori.b  #$4, d0
00DF70  ori.b  #$8c, d0
00DF74  ori.b  #$0, d1
00DF78  ori.b  #$4, d0
00DF7C  ori.b  #$8, d0
00DF80  ori.b  #$98, d0
00DF84  ori.b  #$0, d1
00DF88  ori.b  #$8, d0
00DF8C  ori.b  #$c, d0
00DF90  ori.b  #$a4, d0
00DF94  ori.b  #$0, d1
00DF98  ori.b  #$c, d0
00DF9C  ori.b  #$10, d0
00DFA0  ori.b  #$b0, d0
00DFA4  ori.b  #$0, d1
00DFA8  ori.b  #$10, d0
00DFAC  ori.b  #$14, d0
00DFB0  ori.b  #$bc, d0
00DFB4  ori.b  #$0, d1
00DFB8  ori.b  #$14, d0
00DFBC  ori.b  #$18, d0
00DFC0  ori.b  #$c8, d0
00DFC4  ori.b  #$0, d1
00DFC8  ori.b  #$18, d0
00DFCC  ori.b  #$1c, d0
00DFD0  ori.b  #$d4, d0
00DFD4  ori.b  #$0, d1
00DFD8  ori.b  #$1c, d0
00DFDC  ori.b  #$20, d0
00DFE0  ori.b  #$70, d0
00DFE4  ori.b  #$84, d0
00DFE8  ori.b  #$98, d0
00DFEC  ori.b  #$ac, d0
00DFF0  ori.b  #$c0, d0
00DFF4  ori.b  #$d4, d0
00DFF8  ori.b  #$e8, d0
00DFFC  ori.b  #$fc, d0
00E000  ori.b  #$10, d0
00E004  ori.b  #$24, d0
00E008  ori.b  #$38, d0
00E00C  ori.b  #$4c, d0
00E010  ori.b  #$20, d0
00E014  ori.b  #$34, d0
00E018  ori.b  #$48, d0
00E01C  ori.b  #$5c, d0
00E020  ori.b  #$2c, d0
00E024  ori.b  #$b0, d0
00E028  ori.b  #$2, d1
00E02C  ori.b  #$0, d0
00E030  ori.b  #$0, d0
00E034  ori.b  #$2c, d0
00E038  ori.b  #$bc, d0
00E03C  ori.b  #$3, d1
00E040  ori.b  #$0, d0
00E044  ori.b  #$0, d0
00E048  ori.b  #$2c, d0
00E04C  ori.b  #$c8, d0
00E050  ori.b  #$2, d1
00E054  ori.b  #$0, d0
00E058  ori.b  #$0, d0
00E05C  ori.b  #$2c, d0
00E060  ori.b  #$d4, d0
00E064  ori.b  #$3, d1
00E068  ori.b  #$0, d0
00E06C  ori.b  #$0, d0
00E070  ori.b  #$2c, d0
00E074  ori.b  #$20, d0
00E078  ori.b  #$1, d1
00E07C  ori.b  #$0, d0
00E080  ori.b  #$0, d0
00E084  ori.b  #$2c, d0
00E088  ori.b  #$2c, d0
00E08C  ori.b  #$1, d1
00E090  ori.b  #$0, d0
00E094  ori.b  #$0, d0
00E098  ori.b  #$2c, d0
00E09C  ori.b  #$38, d0
00E0A0  ori.b  #$1, d1
00E0A4  ori.b  #$0, d0
00E0A8  ori.b  #$0, d0
00E0AC  ori.b  #$2c, d0
00E0B0  ori.b  #$44, d0
00E0B4  ori.b  #$1, d1
00E0B8  ori.b  #$0, d0
00E0BC  ori.b  #$0, d0
00E0C0  ori.b  #$2c, d0
00E0C4  ori.b  #$50, d0
00E0C8  ori.b  #$1, d1
00E0CC  ori.b  #$0, d0
00E0D0  ori.b  #$0, d0
00E0D4  ori.b  #$2c, d0
00E0D8  ori.b  #$5c, d0
00E0DC  ori.b  #$1, d1
00E0E0  ori.b  #$0, d0
00E0E4  ori.b  #$0, d0
00E0E8  ori.b  #$2c, d0
00E0EC  ori.b  #$68, d0
00E0F0  ori.b  #$1, d1
00E0F4  ori.b  #$0, d0
00E0F8  ori.b  #$0, d0
00E0FC  ori.b  #$2c, d0
00E100  ori.b  #$74, d0
00E104  ori.b  #$1, d1
00E108  ori.b  #$0, d0
00E10C  ori.b  #$0, d0
00E110  ori.b  #$2c, d0
00E114  ori.b  #$80, d0
00E118  ori.b  #$2, d1
00E11C  ori.b  #$0, d0
00E120  ori.b  #$0, d0
00E124  ori.b  #$2c, d0
00E128  ori.b  #$8c, d0
00E12C  ori.b  #$3, d1
00E130  ori.b  #$0, d0
00E134  ori.b  #$0, d0
00E138  ori.b  #$2c, d0
00E13C  ori.b  #$98, d0
00E140  ori.b  #$2, d1
00E144  ori.b  #$0, d0
00E148  ori.b  #$0, d0
00E14C  ori.b  #$2c, d0
00E150  ori.b  #$a4, d0
00E154  ori.b  #$3, d1
00E158  ori.b  #$0, d0
00E15C  ori.b  #$0, d0
00E160  ori.b  #$e8, d5
00E164  ori.b  #$b8, d5
00E168  ori.b  #$ac, d5
00E16C  ori.b  #$dc, d5
00E170  ori.b  #$e8, d5
00E174  ori.b  #$b8, d5
00E178  ori.b  #$f4, d5
00E17C  ori.b  #$0, d5
00E180  ori.b  #$ac, d5
00E184  ori.b  #$b8, d5
00E188  ori.b  #$d0, d5
00E18C  ori.b  #$c4, d5
00E190  ori.b  #$0, d5
00E194  ori.b  #$f4, d5
00E198  ori.b  #$d0, d5
00E19C  ori.b  #$dc, d5
00E1A0  ori.b  #$c4, d5
00E1A4  ori.b  #$d0, d5
00E1A8  ori.b  #$e8, d5
00E1AC  ori.b  #$dc, d5
00E1B0  ori.b  #$c, d5
00E1B4  ori.b  #$18, d5
00E1B8  ori.b  #$48, d5
00E1BC  ori.b  #$3c, d5
00E1C0  ori.b  #$c, d5
00E1C4  ori.b  #$60, d5
00E1C8  ori.b  #$54, d5
00E1CC  ori.b  #$18, d5
00E1D0  ori.b  #$c, d5
00E1D4  ori.b  #$60, d5
00E1D8  ori.b  #$60, d5
00E1DC  ori.b  #$24, d5
00E1E0  ori.b  #$30, d5
00E1E4  ori.b  #$54, d5
00E1E8  ori.b  #$60, d5
00E1EC  ori.b  #$48, d5
00E1F0  ori.b  #$30, d5
00E1F4  ori.b  #$24, d5
00E1F8  ori.b  #$3c, d5
00E1FC  ori.b  #$48, d5
00E200  ori.b  #$c, d5
00E204  ori.b  #$3c, d5
00E208  ori.b  #$dc, d5
00E20C  ori.b  #$ac, d5
00E210  ori.b  #$c, d5
00E214  ori.b  #$ac, d5
00E218  ori.b  #$0, d5
00E21C  ori.b  #$60, d5
00E220  ori.b  #$c, d5
00E224  ori.b  #$ac, d5
00E228  ori.b  #$0, d5
00E22C  ori.b  #$c4, d5
00E230  ori.b  #$24, d5
00E234  ori.b  #$60, d5
00E238  ori.b  #$0, d5
00E23C  ori.b  #$3c, d5
00E240  ori.b  #$24, d5
00E244  ori.b  #$c4, d5
00E248  ori.b  #$dc, d5
00E24C  ori.b  #$3c, d5
00E250  ori.b  #$b8, d5
00E254  ori.b  #$e8, d5
00E258  ori.b  #$48, d5
00E25C  ori.b  #$18, d5
00E260  ori.b  #$b8, d5
00E264  ori.b  #$18, d5
00E268  ori.b  #$54, d5
00E26C  ori.b  #$f4, d5
00E270  ori.b  #$b8, d5
00E274  ori.b  #$18, d5
00E278  ori.b  #$54, d5
00E27C  ori.b  #$30, d5
00E280  ori.b  #$d0, d5
00E284  ori.b  #$f4, d5
00E288  ori.b  #$54, d5
00E28C  ori.b  #$e8, d5
00E290  ori.b  #$d0, d5
00E294  ori.b  #$30, d5
00E298  ori.b  #$48, d5
00E29C  ori.b  #$e8, d5
00E2A0  ori.b  #$bc, d0
00E2A4  ori.b  #$4c, d0
00E2A8  ori.b  #$3c, d0
00E2AC  ori.b  #$f4, d0
00E2B0  ori.b  #$14, (a0)+
00E2B4  ori.b  #$16, (a4)
00E2B8  bset.b d3, (a1)+
00E2BA  ori.b  #$50, d0
00E2BE  ; data: 0xf9, 0xc0
00E2C0  ; data: 0x00, 0xc8
00E2C2  dc.w   $fce0
00E2C4  ; data: 0xf9, 0xc0
00E2C6  ; data: 0x00, 0xc8
00E2C8  subi.l #$fe7000c8, (a0, d0.w)
00E2D0  bclr.b d0, (a0)
00E2D2  ; data: 0x00, 0xc8
00E2D4  subi.l #$4b000c8, $640(a0, d0.w * 2)
00E2DE  ; data: 0x00, 0xc8
00E2E0  dc.w   $fce0
00E2E2  bclr.b d0, (a0)
00E2E4  ; data: 0x00, 0xc8
00E2E6  dc.w   $fce0
00E2E8  addi.w #$c8, d0
00E2EC  dc.w   $fb50
00E2EE  addi.w #$c8, d0
00E2F2  dc.w   $fce0
00E2F4  dc.w   $fb50
00E2F6  ; data: 0x00, 0xc8
00E2F8  bclr.b d0, (a0)
00E2FA  dc.w   $fe70
00E2FC  ; data: 0x00, 0xc8
00E2FE  dc.w   $fce0
00E300  ori.b  #$c8, d0
00E304  dc.w   $fb50
00E306  ; data: 0xf9, 0xc0
00E308  dc.w   $ff38
00E30A  dc.w   $fce0
00E30C  ; data: 0xf9, 0xc0
00E30E  dc.w   $ff38
00E310  subi.l #$fe70ff38, (a0, d0.w)
00E318  bclr.b d0, (a0)
00E31A  dc.w   $ff38
00E31C  subi.l #$4b0ff38, $640(a0, d0.w * 2)
00E326  dc.w   $ff38
00E328  dc.w   $fce0
00E32A  bclr.b d0, (a0)
00E32C  dc.w   $ff38
00E32E  dc.w   $fce0
00E330  addi.w #$ff38, d0
00E334  dc.w   $fb50
00E336  addi.w #$ff38, d0
00E33A  dc.w   $fce0
00E33C  dc.w   $fb50
00E33E  dc.w   $ff38
00E340  bclr.b d0, (a0)
00E342  dc.w   $fe70
00E344  dc.w   $ff38
00E346  dc.w   $fce0
00E348  ori.b  #$38, d0
00E34C  ori.b  #$7, d7
00E350  ori.b  #$ac, d0
00E354  ori.b  #$ac, d0
00E358  ori.b  #$4, d4
00E35C  ori.b  #$cc, d0
00E360  ori.b  #$cc, d0
00E364  ori.b  #$5, d5
00E368  ori.b  #$e0, d0
00E36C  ori.b  #$e0, d0
00E370  ori.b  #$4, d4
00E374  ori.b  #$f8, d0
00E378  ori.b  #$f8, d0
00E37C  ori.b  #$7, d7
00E380  ori.b  #$c, d0
00E384  ori.b  #$c, d0
00E388  ori.b  #$4, d4
00E38C  ori.b  #$2c, d0
00E390  ori.b  #$2c, d0
00E394  ori.b  #$5, d5
00E398  ori.b  #$40, d0
00E39C  ori.b  #$40, d0
00E3A0  ori.b  #$4, d4
00E3A4  ori.b  #$58, d0
00E3A8  ori.b  #$58, d0
00E3AC  ori.b  #$4, d4
00E3B0  ori.b  #$6c, d0
00E3B4  ori.b  #$6c, d0
00E3B8  ori.b  #$4, d4
00E3BC  ori.b  #$80, d0
00E3C0  ori.b  #$80, d0
00E3C4  ori.b  #$4, d4
00E3C8  ori.b  #$94, d0
00E3CC  ori.b  #$94, d0
00E3D0  ori.b  #$4, d4
00E3D4  ori.b  #$a8, d0
00E3D8  ori.b  #$a8, d0
00E3DC  ori.b  #$4, d4
00E3E0  ori.b  #$bc, d0
00E3E4  ori.b  #$bc, d0
00E3E8  ori.b  #$4, d4
00E3EC  ori.b  #$d0, d0
00E3F0  ori.b  #$d0, d0
00E3F4  ori.b  #$4, d4
00E3F8  ori.b  #$e4, d0
00E3FC  ori.b  #$e4, d0
00E400  ori.b  #$4, d4
00E404  ori.b  #$f8, d0
00E408  ori.b  #$f8, d0
00E40C  ori.b  #$4, d4
00E410  ori.b  #$c, d0
00E414  ori.b  #$c, d0
00E418  ori.b  #$4, d4
00E41C  ori.b  #$20, d0
00E420  ori.b  #$20, d0
00E424  ori.b  #$4, d4
00E428  ori.b  #$34, d0
00E42C  ori.b  #$34, d0
00E430  ori.b  #$4, d4
00E434  ori.b  #$48, d0
00E438  ori.b  #$48, d0
00E43C  ori.b  #$4c, d0
00E440  ori.b  #$0, d1
00E444  ori.b  #$7c, d0
00E448  ori.b  #$80, d0
00E44C  ori.b  #$58, d0
00E450  ori.b  #$0, d1
00E454  ori.b  #$80, d0
00E458  ori.b  #$84, d0
00E45C  ori.b  #$64, d0
00E460  ori.b  #$0, d1
00E464  ori.b  #$84, d0
00E468  ori.b  #$88, d0
00E46C  ori.b  #$70, d0
00E470  ori.b  #$0, d1
00E474  ori.b  #$88, d0
00E478  ori.b  #$8c, d0
00E47C  ori.b  #$7c, d0
00E480  ori.b  #$0, d1
00E484  ori.b  #$8c, d0
00E488  ori.b  #$90, d0
00E48C  ori.b  #$88, d0
00E490  ori.b  #$0, d1
00E494  ori.b  #$90, d0
00E498  ori.b  #$94, d0
00E49C  ori.b  #$94, d0
00E4A0  ori.b  #$0, d1
00E4A4  ori.b  #$94, d0
00E4A8  ori.b  #$98, d0
00E4AC  ori.b  #$a0, d0
00E4B0  ori.b  #$0, d1
00E4B4  ori.b  #$98, d0
00E4B8  ori.b  #$9c, d0
00E4BC  ori.b  #$ac, d0
00E4C0  ori.b  #$0, d1
00E4C4  ori.b  #$9c, d0
00E4C8  ori.b  #$a0, d0
00E4CC  ori.b  #$b8, d0
00E4D0  ori.b  #$0, d1
00E4D4  ori.b  #$a0, d0
00E4D8  ori.b  #$a4, d0
00E4DC  ori.b  #$c4, d0
00E4E0  ori.b  #$0, d1
00E4E4  ori.b  #$a4, d0
00E4E8  ori.b  #$a8, d0
00E4EC  ori.b  #$d0, d0
00E4F0  ori.b  #$0, d1
00E4F4  ori.b  #$a8, d0
00E4F8  ori.b  #$ac, d0
00E4FC  ori.b  #$dc, d0
00E500  ori.b  #$4, d5
00E504  ori.b  #$ac, d0
00E508  ori.b  #$c0, d0
00E50C  ori.b  #$e8, d0
00E510  ori.b  #$0, d1
00E514  ori.b  #$d0, d0
00E518  ori.b  #$d4, d0
00E51C  ori.b  #$f4, d0
00E520  ori.b  #$0, d1
00E524  ori.b  #$d4, d0
00E528  ori.b  #$d8, d0
00E52C  ori.b  #$0, d0
00E530  ori.b  #$0, d2
00E534  ori.b  #$d8, d0
00E538  ori.b  #$e0, d0
00E53C  ori.b  #$c, d0
00E540  ori.b  #$0, d1
00E544  ori.b  #$e0, d0
00E548  ori.b  #$e4, d0
00E54C  ori.b  #$18, d0
00E550  ori.b  #$0, d1
00E554  ori.b  #$e4, d0
00E558  ori.b  #$e8, d0
00E55C  ori.b  #$24, d0
00E560  ori.b  #$0, d2
00E564  ori.b  #$e8, d0
00E568  ori.b  #$f0, d0
00E56C  ori.b  #$30, d0
00E570  ori.b  #$0, d1
00E574  ori.b  #$f0, d0
00E578  ori.b  #$f4, d0
00E57C  ori.b  #$a8, d0
00E580  ori.b  #$bc, d0
00E584  ori.b  #$d0, d0
00E588  ori.b  #$e4, d0
00E58C  ori.b  #$f8, d0
00E590  ori.b  #$c, d0
00E594  ori.b  #$20, d0
00E598  ori.b  #$34, d0
00E59C  ori.b  #$48, d0
00E5A0  ori.b  #$5c, d0
00E5A4  ori.b  #$70, d0
00E5A8  ori.b  #$84, d0
00E5AC  ori.b  #$98, d0
00E5B0  ori.b  #$80, d0
00E5B4  ori.b  #$80, d0
00E5B8  ori.b  #$1c, d0
00E5BC  ori.b  #$1c, d0
00E5C0  ori.b  #$94, d0
00E5C4  ori.b  #$94, d0
00E5C8  ori.b  #$30, d0
00E5CC  ori.b  #$30, d0
00E5D0  ori.b  #$58, d0
00E5D4  ori.b  #$6c, d0
00E5D8  ori.b  #$94, d0
00E5DC  ori.b  #$1c, d0
00E5E0  ori.b  #$f4, d0
00E5E4  ori.b  #$8, d0
00E5E8  ori.b  #$80, d0
00E5EC  ori.b  #$30, d0
00E5F0  ori.b  #$44, d0
00E5F4  ori.b  #$2c, d0
00E5F8  ori.b  #$c, d0
00E5FC  ori.b  #$2, d1
00E600  ori.b  #$0, d0
00E604  ori.b  #$0, d0
00E608  ori.b  #$2c, d0
00E60C  ori.b  #$18, d0
00E610  ori.b  #$3, d1
00E614  ori.b  #$0, d0
00E618  ori.b  #$0, d0
00E61C  ori.b  #$2c, d0
00E620  ori.b  #$0, d0
00E624  ori.b  #$2, d1
00E628  ori.b  #$0, d0
00E62C  ori.b  #$0, d0
00E630  ori.b  #$2c, d0
00E634  ori.b  #$24, d0
00E638  ori.b  #$2, d1
00E63C  ori.b  #$0, d0
00E640  ori.b  #$0, d0
00E644  ori.b  #$2c, d0
00E648  ori.b  #$30, d0
00E64C  ori.b  #$2, d1
00E650  ori.b  #$0, d0
00E654  ori.b  #$0, d0
00E658  ori.b  #$2c, d0
00E65C  ori.b  #$e8, d0
00E660  ori.b  #$3, d1
00E664  ori.b  #$0, d0
00E668  ori.b  #$0, d0
00E66C  ori.b  #$2c, d0
00E670  ori.b  #$f4, d0
00E674  ori.b  #$2, d1
00E678  ori.b  #$0, d0
00E67C  ori.b  #$0, d0
00E680  ori.b  #$2c, d0
00E684  ori.b  #$24, d0
00E688  ori.b  #$2, d1
00E68C  ori.b  #$0, d0
00E690  ori.b  #$0, d0
00E694  ori.b  #$2c, d0
00E698  ori.b  #$0, d0
00E69C  ori.b  #$2, d1
00E6A0  ori.b  #$0, d0
00E6A4  ori.b  #$0, d0
00E6A8  ori.b  #$2c, d0
00E6AC  ori.b  #$4c, d0
00E6B0  ori.b  #$1, d1
00E6B4  ori.b  #$0, d0
00E6B8  ori.b  #$0, d0
00E6BC  ori.b  #$2c, d0
00E6C0  ori.b  #$58, d0
00E6C4  ori.b  #$1, d1
00E6C8  ori.b  #$0, d0
00E6CC  ori.b  #$0, d0
00E6D0  ori.b  #$2c, d0
00E6D4  ori.b  #$64, d0
00E6D8  ori.b  #$1, d1
00E6DC  ori.b  #$0, d0
00E6E0  ori.b  #$0, d0
00E6E4  ori.b  #$2c, d0
00E6E8  ori.b  #$70, d0
00E6EC  ori.b  #$1, d1
00E6F0  ori.b  #$0, d0
00E6F4  ori.b  #$0, d0
00E6F8  ori.b  #$2c, d0
00E6FC  ori.b  #$7c, d0
00E700  ori.b  #$1, d1
00E704  ori.b  #$0, d0
00E708  ori.b  #$0, d0
00E70C  ori.b  #$2c, d0
00E710  ori.b  #$88, d0
00E714  ori.b  #$1, d1
00E718  ori.b  #$0, d0
00E71C  ori.b  #$0, d0
00E720  ori.b  #$2c, d0
00E724  ori.b  #$94, d0
00E728  ori.b  #$1, d1
00E72C  ori.b  #$0, d0
00E730  ori.b  #$0, d0
00E734  ori.b  #$2c, d0
00E738  ori.b  #$a0, d0
00E73C  ori.b  #$1, d1
00E740  ori.b  #$0, d0
00E744  ori.b  #$0, d0
00E748  ori.b  #$2c, d0
00E74C  ori.b  #$ac, d0
00E750  ori.b  #$2, d1
00E754  ori.b  #$0, d0
00E758  ori.b  #$0, d0
00E75C  ori.b  #$2c, d0
00E760  ori.b  #$b8, d0
00E764  ori.b  #$3, d1
00E768  ori.b  #$0, d0
00E76C  ori.b  #$0, d0
00E770  ori.b  #$2c, d0
00E774  ori.b  #$c4, d0
00E778  ori.b  #$2, d1
00E77C  ori.b  #$0, d0
00E780  ori.b  #$0, d0
00E784  ori.b  #$2c, d0
00E788  ori.b  #$d0, d0
00E78C  ori.b  #$3, d1
00E790  ori.b  #$0, d0
00E794  ori.b  #$0, d0
00E798  ori.b  #$2c, d0
00E79C  ori.b  #$dc, d0
00E7A0  ori.b  #$3, d1
00E7A4  ori.b  #$0, d0
00E7A8  ori.b  #$0, d0
00E7AC  ori.b  #$c, d5
00E7B0  ori.b  #$0, d5
00E7B4  ori.b  #$f4, d5
00E7B8  ori.b  #$30, d5
00E7BC  ori.b  #$18, d5
00E7C0  ori.b  #$b8, d5
00E7C4  ori.b  #$ac, d5
00E7C8  ori.b  #$c, d5
00E7CC  ori.b  #$b8, d5
00E7D0  ori.b  #$18, d5
00E7D4  ori.b  #$24, d5
00E7D8  ori.b  #$c4, d5
00E7DC  ori.b  #$b8, d5
00E7E0  ori.b  #$24, d5
00E7E4  ori.b  #$30, d5
00E7E8  ori.b  #$f4, d5
00E7EC  ori.b  #$d0, d5
00E7F0  ori.b  #$c4, d5
00E7F4  ori.b  #$24, d5
00E7F8  ori.b  #$f4, d5
00E7FC  ori.b  #$e8, d5
00E800  ori.b  #$dc, d5
00E804  ori.b  #$d0, d5
00E808  ori.b  #$f4, d5
00E80C  ori.b  #$3c, d5
00E810  ori.b  #$48, d5
00E814  ori.b  #$a8, d5
00E818  ori.b  #$c0, d5
00E81C  ori.b  #$84, d5
00E820  ori.b  #$90, d5
00E824  ori.b  #$9c, d5
00E828  ori.b  #$3c, d5
00E82C  ori.b  #$54, d5
00E830  ori.b  #$b4, d5
00E834  ori.b  #$a8, d5
00E838  ori.b  #$48, d5
00E83C  ori.b  #$54, d5
00E840  ori.b  #$54, d5
00E844  ori.b  #$60, d5
00E848  ori.b  #$84, d5
00E84C  ori.b  #$c0, d5
00E850  ori.b  #$b4, d5
00E854  ori.b  #$54, d5
00E858  ori.b  #$60, d5
00E85C  ori.b  #$6c, d5
00E860  ori.b  #$78, d5
00E864  ori.b  #$84, d5
00E868  ori.b  #$60, d5
00E86C  ori.b  #$3c, d5
00E870  ori.b  #$9c, d5
00E874  ori.b  #$c, d5
00E878  ori.b  #$ac, d5
00E87C  ori.b  #$3c, d5
00E880  ori.b  #$3c, d5
00E884  ori.b  #$ac, d5
00E888  ori.b  #$b8, d5
00E88C  ori.b  #$48, d5
00E890  ori.b  #$3c, d5
00E894  ori.b  #$48, d5
00E898  ori.b  #$b8, d5
00E89C  ori.b  #$c4, d5
00E8A0  ori.b  #$54, d5
00E8A4  ori.b  #$48, d5
00E8A8  ori.b  #$dc, d5
00E8AC  ori.b  #$e8, d5
00E8B0  ori.b  #$78, d5
00E8B4  ori.b  #$6c, d5
00E8B8  ori.b  #$dc, d5
00E8BC  ori.b  #$c, d5
00E8C0  ori.b  #$9c, d5
00E8C4  ori.b  #$90, d5
00E8C8  ori.b  #$0, d5
00E8CC  ori.b  #$c, d5
00E8D0  ori.b  #$c4, d5
00E8D4  ori.b  #$d0, d5
00E8D8  ori.b  #$60, d5
00E8DC  ori.b  #$54, d5
00E8E0  ori.b  #$c4, d5
00E8E4  ori.b  #$d0, d5
00E8E8  ori.b  #$dc, d5
00E8EC  ori.b  #$6c, d5
00E8F0  ori.b  #$60, d5
00E8F4  ori.b  #$d0, d5
00E8F8  ori.b  #$84, d5
00E8FC  ori.b  #$78, d5
00E900  ori.b  #$e8, d5
00E904  ori.b  #$f4, d5
00E908  ori.b  #$84, d5
00E90C  ori.b  #$f4, d5
00E910  ori.b  #$0, d5
00E914  ori.b  #$90, d5
00E918  ori.b  #$84, d5
00E91C  ori.b  #$f4, d5
00E920  ori.b  #$18, d5
00E924  ori.b  #$30, d5
00E928  ori.b  #$c0, d5
00E92C  ori.b  #$a8, d5
00E930  ori.b  #$18, d5
00E934  ori.b  #$a8, d5
00E938  ori.b  #$b4, d5
00E93C  ori.b  #$24, d5
00E940  ori.b  #$18, d5
00E944  ori.b  #$a8, d5
00E948  ori.b  #$b4, d5
00E94C  ori.b  #$c0, d5
00E950  ori.b  #$30, d5
00E954  ori.b  #$24, d5
00E958  ori.b  #$b4, d5
00E95C  ori.b  #$78, d0
00E960  ori.b  #$f0, d0
00E964  ori.b  #$b0, d0
00E968  ori.b  #$f0, d0
00E96C  ori.b  #$10, (a4)
00E970  ori.b  #$10, (a0)
00E974  movep.w $0(a0), d3
00E978  btst.l d1, -(a0)
00E97A  ; data: 0xf9, 0xc0
00E97C  ; data: 0x00, 0xc8
00E97E  subi.l #$fb5000c8, $70(a0, a7.l)
00E986  dc.w   $fe70
00E988  ; data: 0x00, 0xc8
00E98A  dc.w   $fb50
00E98C  ; data: 0xfd, 0xa8
00E98E  ; data: 0x00, 0xc8
00E990  dc.w   $fb50
00E992  ori.b  #$c8, d0
00E996  dc.w   $fce0
00E998  addi.w #$c8, d0
00E99C  dc.w   $fb50
00E99E  subi.l #$c80190, (d0.w)
00E9A6  ; data: 0x00, 0xc8
00E9A8  subi.l #$25800c8, -$50(a0, d0.w)
00E9B0  ori.b  #$c8, d0
00E9B4  btst.l d1, -(a0)
00E9B6  ; data: 0xf9, 0xc0
00E9B8  dc.w   $ff38
00E9BA  subi.l #$fb50ff38, $70(a0, a7.l)
00E9C2  dc.w   $fe70
00E9C4  dc.w   $ff38
00E9C6  dc.w   $fb50
00E9C8  ; data: 0xfd, 0xa8
00E9CA  dc.w   $ff38
00E9CC  dc.w   $fb50
00E9CE  ori.b  #$38, d0
00E9D2  dc.w   $fce0
00E9D4  addi.w #$ff38, d0
00E9D8  dc.w   $fb50
00E9DA  subi.l #$ff380190, (d0.w)
00E9E2  dc.w   $ff38
00E9E4  subi.l #$258ff38, -$50(a0, d0.w)
00E9EC  ori.b  #$38, d0
00E9F0  ori.b  #$4, d4
00E9F4  ori.b  #$30, d0
00E9F8  ori.b  #$30, d0
00E9FC  ori.b  #$6, d6
00EA00  ori.b  #$44, d0
00EA04  ori.b  #$44, d0
00EA08  ori.b  #$4, d4
00EA0C  ori.b  #$60, d0
00EA10  ori.b  #$60, d0
00EA14  ori.b  #$4, d4
00EA18  ori.b  #$74, d0
00EA1C  ori.b  #$74, d0
00EA20  ori.b  #$6, d6
00EA24  ori.b  #$88, d0
00EA28  ori.b  #$88, d0
00EA2C  ori.b  #$4, d4
00EA30  ori.b  #$a4, d0
00EA34  ori.b  #$a4, d0
00EA38  ori.b  #$4, d4
00EA3C  ori.b  #$b8, d0
00EA40  ori.b  #$b8, d0
00EA44  ori.b  #$4, d4
00EA48  ori.b  #$cc, d0
00EA4C  ori.b  #$cc, d0
00EA50  ori.b  #$4, d4
00EA54  ori.b  #$e0, d0
00EA58  ori.b  #$e0, d0
00EA5C  ori.b  #$4, d4
00EA60  ori.b  #$f4, d0
00EA64  ori.b  #$f4, d0
00EA68  ori.b  #$4, d4
00EA6C  ori.b  #$8, d0
00EA70  ori.b  #$8, d0
00EA74  ori.b  #$4, d4
00EA78  ori.b  #$1c, d0
00EA7C  ori.b  #$1c, d0
00EA80  ori.b  #$4, d4
00EA84  ori.b  #$30, d0
00EA88  ori.b  #$30, d0
00EA8C  ori.b  #$4, d4
00EA90  ori.b  #$44, d0
00EA94  ori.b  #$44, d0
00EA98  ori.b  #$4, d4
00EA9C  ori.b  #$58, d0
00EAA0  ori.b  #$58, d0
00EAA4  ori.b  #$4, d4
00EAA8  ori.b  #$6c, d0
00EAAC  ori.b  #$6c, d0
00EAB0  ori.b  #$f0, d0
00EAB4  ori.b  #$0, d1
00EAB8  ori.b  #$b0, d0
00EABC  ori.b  #$b4, d0
00EAC0  ori.b  #$fc, d0
00EAC4  ori.b  #$0, d1
00EAC8  ori.b  #$b4, d0
00EACC  ori.b  #$b8, d0
00EAD0  ori.b  #$8, d0
00EAD4  ori.b  #$0, d1
00EAD8  ori.b  #$b8, d0
00EADC  ori.b  #$bc, d0
00EAE0  ori.b  #$14, d0
00EAE4  ori.b  #$0, d1
00EAE8  ori.b  #$bc, d0
00EAEC  ori.b  #$c0, d0
00EAF0  ori.b  #$20, d0
00EAF4  ori.b  #$0, d1
00EAF8  ori.b  #$c0, d0
00EAFC  ori.b  #$c4, d0
00EB00  ori.b  #$2c, d0
00EB04  ori.b  #$0, d1
00EB08  ori.b  #$c4, d0
00EB0C  ori.b  #$c8, d0
00EB10  ori.b  #$38, d0
00EB14  ori.b  #$0, d1
00EB18  ori.b  #$c8, d0
00EB1C  ori.b  #$cc, d0
00EB20  ori.b  #$44, d0
00EB24  ori.b  #$0, d1
00EB28  ori.b  #$cc, d0
00EB2C  ori.b  #$d0, d0
00EB30  ori.b  #$50, d0
00EB34  ori.b  #$0, d1
00EB38  ori.b  #$d0, d0
00EB3C  ori.b  #$d4, d0
00EB40  ori.b  #$5c, d0
00EB44  ori.b  #$0, d1
00EB48  ori.b  #$d4, d0
00EB4C  ori.b  #$d8, d0
00EB50  ori.b  #$68, d0
00EB54  ori.b  #$0, d1
00EB58  ori.b  #$d8, d0
00EB5C  ori.b  #$dc, d0
00EB60  ori.b  #$74, d0
00EB64  ori.b  #$0, d1
00EB68  ori.b  #$dc, d0
00EB6C  ori.b  #$e0, d0
00EB70  ori.b  #$80, d0
00EB74  ori.b  #$0, d1
00EB78  ori.b  #$e0, d0
00EB7C  ori.b  #$e4, d0
00EB80  ori.b  #$8c, d0
00EB84  ori.b  #$0, d1
00EB88  ori.b  #$e4, d0
00EB8C  ori.b  #$e8, d0
00EB90  ori.b  #$98, d0
00EB94  ori.b  #$0, d1
00EB98  ori.b  #$e8, d0
00EB9C  ori.b  #$ec, d0
00EBA0  ori.b  #$a4, d0
00EBA4  ori.b  #$0, d1
00EBA8  ori.b  #$ec, d0
00EBAC  ori.b  #$f0, d0
00EBB0  ori.b  #$40, d0
00EBB4  ori.b  #$54, d0
00EBB8  ori.b  #$68, d0
00EBBC  ori.b  #$7c, d0
00EBC0  ori.b  #$90, d0
00EBC4  ori.b  #$a4, d0
00EBC8  ori.b  #$b8, d0
00EBCC  ori.b  #$cc, d0
00EBD0  ori.b  #$e0, d0
00EBD4  ori.b  #$f4, d0
00EBD8  ori.b  #$8, d0
00EBDC  ori.b  #$1c, d0
00EBE0  ori.b  #$f0, d0
00EBE4  ori.b  #$4, d0
00EBE8  ori.b  #$18, d0
00EBEC  ori.b  #$2c, d0
00EBF0  ori.b  #$2c, d0
00EBF4  ori.b  #$80, d0
00EBF8  ori.b  #$3, d1
00EBFC  ori.b  #$0, d0
00EC00  ori.b  #$0, d0
00EC04  ori.b  #$2c, d0
00EC08  ori.b  #$8c, d0
00EC0C  ori.b  #$2, d1
00EC10  ori.b  #$0, d0
00EC14  ori.b  #$0, d0
00EC18  ori.b  #$2c, d0
00EC1C  ori.b  #$98, d0
00EC20  ori.b  #$2, d1
00EC24  ori.b  #$0, d0
00EC28  ori.b  #$0, d0
00EC2C  ori.b  #$2c, d0
00EC30  ori.b  #$a4, d0
00EC34  ori.b  #$3, d1
00EC38  ori.b  #$0, d0
00EC3C  ori.b  #$0, d0
00EC40  ori.b  #$2c, d0
00EC44  ori.b  #$f0, d0
00EC48  ori.b  #$1, d1
00EC4C  ori.b  #$0, d0
00EC50  ori.b  #$0, d0
00EC54  ori.b  #$2c, d0
00EC58  ori.b  #$fc, d0
00EC5C  ori.b  #$1, d1
00EC60  ori.b  #$0, d0
00EC64  ori.b  #$0, d0
00EC68  ori.b  #$2c, d0
00EC6C  ori.b  #$8, d0
00EC70  ori.b  #$1, d1
00EC74  ori.b  #$0, d0
00EC78  ori.b  #$0, d0
00EC7C  ori.b  #$2c, d0
00EC80  ori.b  #$14, d0
00EC84  ori.b  #$1, d1
00EC88  ori.b  #$0, d0
00EC8C  ori.b  #$0, d0
00EC90  ori.b  #$2c, d0
00EC94  ori.b  #$20, d0
00EC98  ori.b  #$1, d1
00EC9C  ori.b  #$0, d0
00ECA0  ori.b  #$0, d0
00ECA4  ori.b  #$2c, d0
00ECA8  ori.b  #$2c, d0
00ECAC  ori.b  #$1, d1
00ECB0  ori.b  #$0, d0
00ECB4  ori.b  #$0, d0
00ECB8  ori.b  #$2c, d0
00ECBC  ori.b  #$38, d0
00ECC0  ori.b  #$2, d1
00ECC4  ori.b  #$0, d0
00ECC8  ori.b  #$0, d0
00ECCC  ori.b  #$2c, d0
00ECD0  ori.b  #$44, d0
00ECD4  ori.b  #$3, d1
00ECD8  ori.b  #$0, d0
00ECDC  ori.b  #$0, d0
00ECE0  ori.b  #$2c, d0
00ECE4  ori.b  #$50, d0
00ECE8  ori.b  #$2, d1
00ECEC  ori.b  #$0, d0
00ECF0  ori.b  #$0, d0
00ECF4  ori.b  #$2c, d0
00ECF8  ori.b  #$5c, d0
00ECFC  ori.b  #$3, d1
00ED00  ori.b  #$0, d0
00ED04  ori.b  #$0, d0
00ED08  ori.b  #$2c, d0
00ED0C  ori.b  #$68, d0
00ED10  ori.b  #$2, d1
00ED14  ori.b  #$0, d0
00ED18  ori.b  #$0, d0
00ED1C  ori.b  #$2c, d0
00ED20  ori.b  #$74, d0
00ED24  ori.b  #$3, d1
00ED28  ori.b  #$0, d0
00ED2C  ori.b  #$0, d0
00ED30  ori.b  #$c4, d5
00ED34  ori.b  #$b8, d5
00ED38  ori.b  #$ac, d5
00ED3C  ori.b  #$d0, d5
00ED40  ori.b  #$c4, d5
00ED44  ori.b  #$d0, d5
00ED48  ori.b  #$dc, d5
00ED4C  ori.b  #$0, d5
00ED50  ori.b  #$c, d5
00ED54  ori.b  #$18, d5
00ED58  ori.b  #$c4, d5
00ED5C  ori.b  #$d0, d5
00ED60  ori.b  #$0, d5
00ED64  ori.b  #$f4, d5
00ED68  ori.b  #$e8, d5
00ED6C  ori.b  #$c, d5
00ED70  ori.b  #$0, d5
00ED74  ori.b  #$24, d5
00ED78  ori.b  #$30, d5
00ED7C  ori.b  #$3c, d5
00ED80  ori.b  #$48, d5
00ED84  ori.b  #$24, d5
00ED88  ori.b  #$90, d5
00ED8C  ori.b  #$84, d5
00ED90  ori.b  #$78, d5
00ED94  ori.b  #$54, d5
00ED98  ori.b  #$48, d5
00ED9C  ori.b  #$3c, d5
00EDA0  ori.b  #$90, d5
00EDA4  ori.b  #$84, d5
00EDA8  ori.b  #$60, d5
00EDAC  ori.b  #$6c, d5
00EDB0  ori.b  #$78, d5
00EDB4  ori.b  #$84, d5
00EDB8  ori.b  #$24, d5
00EDBC  ori.b  #$48, d5
00EDC0  ori.b  #$d0, d5
00EDC4  ori.b  #$ac, d5
00EDC8  ori.b  #$24, d5
00EDCC  ori.b  #$ac, d5
00EDD0  ori.b  #$b8, d5
00EDD4  ori.b  #$30, d5
00EDD8  ori.b  #$24, d5
00EDDC  ori.b  #$ac, d5
00EDE0  ori.b  #$18, d5
00EDE4  ori.b  #$c, d5
00EDE8  ori.b  #$84, d5
00EDEC  ori.b  #$90, d5
00EDF0  ori.b  #$18, d5
00EDF4  ori.b  #$c, d5
00EDF8  ori.b  #$e8, d5
00EDFC  ori.b  #$60, d5
00EE00  ori.b  #$84, d5
00EE04  ori.b  #$c, d5
00EE08  ori.b  #$6c, d5
00EE0C  ori.b  #$60, d5
00EE10  ori.b  #$e8, d5
00EE14  ori.b  #$f4, d5
00EE18  ori.b  #$6c, d5
00EE1C  ori.b  #$48, d5
00EE20  ori.b  #$54, d5
00EE24  ori.b  #$dc, d5
00EE28  ori.b  #$d0, d5
00EE2C  ori.b  #$48, d5
00EE30  ori.b  #$c4, d5
00EE34  ori.b  #$18, d5
00EE38  ori.b  #$90, d5
00EE3C  ori.b  #$3c, d5
00EE40  ori.b  #$c4, d5
00EE44  ori.b  #$b8, d5
00EE48  ori.b  #$c4, d5
00EE4C  ori.b  #$3c, d5
00EE50  ori.b  #$30, d5
00EE54  ori.b  #$b8, d5
00EE58  ori.b  #$54, d5
00EE5C  ori.b  #$78, d5
00EE60  ori.b  #$0, d5
00EE64  ori.b  #$dc, d5
00EE68  ori.b  #$54, d5
00EE6C  ori.b  #$78, d5
00EE70  ori.b  #$6c, d5
00EE74  ori.b  #$f4, d5
00EE78  ori.b  #$0, d5
00EE7C  ori.b  #$78, d5
00EE80  ori.b  #$9c, d0
00EE84  ori.b  #$fc, d0
00EE88  ori.b  #$8c, d0
00EE8C  ori.b  #$7c, d0
00EE90  ori.b  #$c, (a0)
00EE94  ; data: 0x00, 0x0c
00EE96  ; data: 0x00, 0x0c
00EE98  bset.b d3, (a1)+
00EE9A  ori.b  #$50, d0
00EE9E  ; data: 0xf9, 0xc0
00EEA0  ; data: 0x00, 0xc8
00EEA2  subi.l #$f9c000c8, -$50(a0, d0.w)
00EEAA  dc.w   $fb50
00EEAC  ; data: 0x00, 0xc8
00EEAE  ; data: 0x00, 0xc8
00EEB0  dc.w   $fb50
00EEB2  ; data: 0x00, 0xc8
00EEB4  ; data: 0x00, 0xc8
00EEB6  addi.w #$c8, d0
00EEBA  dc.w   $ff38
00EEBC  addi.w #$c8, d0
00EEC0  dc.w   $ff38
00EEC2  dc.w   $fb50
00EEC4  ; data: 0x00, 0xc8
00EEC6  dc.w   $fb50
00EEC8  dc.w   $fb50
00EECA  ; data: 0x00, 0xc8
00EECC  dc.w   $fb50
00EECE  ; data: 0xf9, 0xc0
00EED0  dc.w   $ff38
00EED2  subi.l #$f9c0ff38, -$50(a0, d0.w)
00EEDA  dc.w   $fb50
00EEDC  dc.w   $ff38
00EEDE  ; data: 0x00, 0xc8
00EEE0  dc.w   $fb50
00EEE2  dc.w   $ff38
00EEE4  ; data: 0x00, 0xc8
00EEE6  addi.w #$ff38, d0
00EEEA  dc.w   $ff38
00EEEC  addi.w #$ff38, d0
00EEF0  dc.w   $ff38
00EEF2  dc.w   $fb50
00EEF4  dc.w   $ff38
00EEF6  dc.w   $fb50
00EEF8  dc.w   $fb50
00EEFA  dc.w   $ff38
00EEFC  ori.b  #$6, d6
00EF00  ori.b  #$6c, d0
00EF04  ori.b  #$6c, d0
00EF08  ori.b  #$4, d4
00EF0C  ori.b  #$88, d0
00EF10  ori.b  #$88, d0
00EF14  ori.b  #$6, d6
00EF18  ori.b  #$9c, d0
00EF1C  ori.b  #$9c, d0
00EF20  ori.b  #$4, d4
00EF24  ori.b  #$b8, d0
00EF28  ori.b  #$b8, d0
00EF2C  ori.b  #$4, d4
00EF30  ori.b  #$cc, d0
00EF34  ori.b  #$cc, d0
00EF38  ori.b  #$4, d4
00EF3C  ori.b  #$e0, d0
00EF40  ori.b  #$e0, d0
00EF44  ori.b  #$4, d4
00EF48  ori.b  #$f4, d0
00EF4C  ori.b  #$f4, d0
00EF50  ori.b  #$4, d4
00EF54  ori.b  #$8, d0
00EF58  ori.b  #$8, d0
00EF5C  ori.b  #$4, d4
00EF60  ori.b  #$1c, d0
00EF64  ori.b  #$1c, d0
00EF68  ori.b  #$4, d4
00EF6C  ori.b  #$30, d0
00EF70  ori.b  #$30, d0
00EF74  ori.b  #$4, d4
00EF78  ori.b  #$44, d0
00EF7C  ori.b  #$44, d0
00EF80  ori.b  #$4, d4
00EF84  ori.b  #$58, d0
00EF88  ori.b  #$58, d0
00EF8C  ori.b  #$fc, d0
00EF90  ori.b  #$0, d1
00EF94  ori.b  #$4c, d0
00EF98  ori.b  #$50, d0
00EF9C  ori.b  #$8, d0
00EFA0  ori.b  #$0, d1
00EFA4  ori.b  #$50, d0
00EFA8  ori.b  #$54, d0
00EFAC  ori.b  #$14, d0
00EFB0  ori.b  #$0, d1
00EFB4  ori.b  #$54, d0
00EFB8  ori.b  #$58, d0
00EFBC  ori.b  #$20, d0
00EFC0  ori.b  #$0, d1
00EFC4  ori.b  #$58, d0
00EFC8  ori.b  #$5c, d0
00EFCC  ori.b  #$2c, d0
00EFD0  ori.b  #$0, d1
00EFD4  ori.b  #$5c, d0
00EFD8  ori.b  #$60, d0
00EFDC  ori.b  #$38, d0
00EFE0  ori.b  #$0, d1
00EFE4  ori.b  #$60, d0
00EFE8  ori.b  #$64, d0
00EFEC  ori.b  #$44, d0
00EFF0  ori.b  #$0, d1
00EFF4  ori.b  #$64, d0
00EFF8  ori.b  #$68, d0
00EFFC  ori.b  #$50, d0
00F000  ori.b  #$0, d1
00F004  ori.b  #$68, d0
00F008  ori.b  #$6c, d0
00F00C  ori.b  #$5c, d0
00F010  ori.b  #$0, d1
00F014  ori.b  #$6c, d0
00F018  ori.b  #$70, d0
00F01C  ori.b  #$68, d0
00F020  ori.b  #$0, d1
00F024  ori.b  #$70, d0
00F028  ori.b  #$74, d0
00F02C  ori.b  #$74, d0
00F030  ori.b  #$0, d1
00F034  ori.b  #$74, d0
00F038  ori.b  #$78, d0
00F03C  ori.b  #$80, d0
00F040  ori.b  #$0, d1
00F044  ori.b  #$78, d0
00F048  ori.b  #$7c, d0
00F04C  ori.b  #$cc, d0
00F050  ori.b  #$e0, d0
00F054  ori.b  #$f4, d0
00F058  ori.b  #$8, d0
00F05C  ori.b  #$1c, d0
00F060  ori.b  #$30, d0
00F064  ori.b  #$44, d0
00F068  ori.b  #$58, d0
00F06C  ori.b  #$7c, d0
00F070  ori.b  #$a4, d0
00F074  ori.b  #$b8, d0
00F078  ori.b  #$90, d0
00F07C  ori.b  #$2c, d0
00F080  ori.b  #$5c, d0
00F084  ori.b  #$2, d1
00F088  ori.b  #$0, d0
00F08C  ori.b  #$0, d0
00F090  ori.b  #$2c, d0
00F094  ori.b  #$80, d0
00F098  ori.b  #$2, d1
00F09C  ori.b  #$0, d0
00F0A0  ori.b  #$0, d0
00F0A4  ori.b  #$2c, d0
00F0A8  ori.b  #$68, d0
00F0AC  ori.b  #$3, d1
00F0B0  ori.b  #$0, d0
00F0B4  ori.b  #$0, d0
00F0B8  ori.b  #$2c, d0
00F0BC  ori.b  #$74, d0
00F0C0  ori.b  #$3, d1
00F0C4  ori.b  #$0, d0
00F0C8  ori.b  #$0, d0
00F0CC  ori.b  #$2c, d0
00F0D0  ori.b  #$fc, d0
00F0D4  ori.b  #$1, d1
00F0D8  ori.b  #$0, d0
00F0DC  ori.b  #$0, d0
00F0E0  ori.b  #$2c, d0
00F0E4  ori.b  #$8, d0
00F0E8  ori.b  #$1, d1
00F0EC  ori.b  #$0, d0
00F0F0  ori.b  #$0, d0
00F0F4  ori.b  #$2c, d0
00F0F8  ori.b  #$14, d0
00F0FC  ori.b  #$1, d1
00F100  ori.b  #$0, d0
00F104  ori.b  #$0, d0
00F108  ori.b  #$2c, d0
00F10C  ori.b  #$20, d0
00F110  ori.b  #$1, d1
00F114  ori.b  #$0, d0
00F118  ori.b  #$0, d0
00F11C  ori.b  #$2c, d0
00F120  ori.b  #$2c, d0
00F124  ori.b  #$2, d1
00F128  ori.b  #$0, d0
00F12C  ori.b  #$0, d0
00F130  ori.b  #$2c, d0
00F134  ori.b  #$38, d0
00F138  ori.b  #$3, d1
00F13C  ori.b  #$0, d0
00F140  ori.b  #$0, d0
00F144  ori.b  #$2c, d0
00F148  ori.b  #$44, d0
00F14C  ori.b  #$2, d1
00F150  ori.b  #$0, d0
00F154  ori.b  #$0, d0
00F158  ori.b  #$2c, d0
00F15C  ori.b  #$50, d0
00F160  ori.b  #$3, d1
00F164  ori.b  #$0, d0
00F168  ori.b  #$0, d0
00F16C  ori.b  #$b8, d5
00F170  ori.b  #$ac, d5
00F174  ori.b  #$0, d5
00F178  ori.b  #$f4, d5
00F17C  ori.b  #$d0, d5
00F180  ori.b  #$c4, d5
00F184  ori.b  #$b8, d5
00F188  ori.b  #$f4, d5
00F18C  ori.b  #$e8, d5
00F190  ori.b  #$dc, d5
00F194  ori.b  #$d0, d5
00F198  ori.b  #$f4, d5
00F19C  ori.b  #$60, d5
00F1A0  ori.b  #$c, d5
00F1A4  ori.b  #$18, d5
00F1A8  ori.b  #$24, d5
00F1AC  ori.b  #$30, d5
00F1B0  ori.b  #$54, d5
00F1B4  ori.b  #$60, d5
00F1B8  ori.b  #$30, d5
00F1BC  ori.b  #$3c, d5
00F1C0  ori.b  #$48, d5
00F1C4  ori.b  #$54, d5
00F1C8  ori.b  #$30, d5
00F1CC  ori.b  #$c, d5
00F1D0  ori.b  #$ac, d5
00F1D4  ori.b  #$b8, d5
00F1D8  ori.b  #$18, d5
00F1DC  ori.b  #$c, d5
00F1E0  ori.b  #$b8, d5
00F1E4  ori.b  #$c4, d5
00F1E8  ori.b  #$24, d5
00F1EC  ori.b  #$18, d5
00F1F0  ori.b  #$b8, d5
00F1F4  ori.b  #$e8, d5
00F1F8  ori.b  #$48, d5
00F1FC  ori.b  #$3c, d5
00F200  ori.b  #$dc, d5
00F204  ori.b  #$e8, d5
00F208  ori.b  #$c, d5
00F20C  ori.b  #$60, d5
00F210  ori.b  #$0, d5
00F214  ori.b  #$ac, d5
00F218  ori.b  #$c, d5
00F21C  ori.b  #$0, d5
00F220  ori.b  #$60, d5
00F224  ori.b  #$54, d5
00F228  ori.b  #$f4, d5
00F22C  ori.b  #$0, d5
00F230  ori.b  #$54, d5
00F234  ori.b  #$48, d5
00F238  ori.b  #$e8, d5
00F23C  ori.b  #$f4, d5
00F240  ori.b  #$54, d5
00F244  ori.b  #$d0, d5
00F248  ori.b  #$dc, d5
00F24C  ori.b  #$3c, d5
00F250  ori.b  #$30, d5
00F254  ori.b  #$d0, d5
00F258  ori.b  #$d0, d5
00F25C  ori.b  #$30, d5
00F260  ori.b  #$24, d5
00F264  ori.b  #$c4, d5
00F268  ori.b  #$d0, d5
00F26C  ori.b  #$88, d0
00F270  ori.b  #$e8, d0
00F274  ori.b  #$78, d0
00F278  ori.b  #$68, d0
00F27C  ori.b  #$c, (a0)
00F280  ; data: 0x00, 0x0c
00F282  ; data: 0x00, 0x0c
00F284  movep.w $0(a0), d3
00F288  subi.l #$fb5000c8, -$20(a0, a7.l)
00F290  addi.w #$c8, d0
00F294  dc.w   $fb50
00F296  subi.l #$c8fe70, (a0, d0.w)
00F29E  ; data: 0x00, 0xc8
00F2A0  dc.w   $fb50
00F2A2  dc.w   $fb50
00F2A4  ; data: 0x00, 0xc8
00F2A6  dc.w   $fce0
00F2A8  ; data: 0xf9, 0xc0
00F2AA  ; data: 0x00, 0xc8
00F2AC  ori.b  #$a8, d0
00F2B0  ; data: 0x00, 0xc8
00F2B2  btst.l d1, -(a0)
00F2B4  ; data: 0xf9, 0xc0
00F2B6  ; data: 0x00, 0xc8
00F2B8  subi.l #$fb50ff38, -$20(a0, a7.l)
00F2C0  addi.w #$ff38, d0
00F2C4  dc.w   $fb50
00F2C6  subi.l #$ff38fe70, (a0, d0.w)
00F2CE  dc.w   $ff38
00F2D0  dc.w   $fb50
00F2D2  dc.w   $fb50
00F2D4  dc.w   $ff38
00F2D6  dc.w   $fce0
00F2D8  ; data: 0xf9, 0xc0
00F2DA  dc.w   $ff38
00F2DC  ori.b  #$a8, d0
00F2E0  dc.w   $ff38
00F2E2  btst.l d1, -(a0)
00F2E4  ; data: 0xf9, 0xc0
00F2E6  dc.w   $ff38
00F2E8  ori.b  #$6, d6
00F2EC  ori.b  #$58, d0
00F2F0  ori.b  #$58, d0
00F2F4  ori.b  #$4, d4
00F2F8  ori.b  #$74, d0
00F2FC  ori.b  #$74, d0
00F300  ori.b  #$6, d6
00F304  ori.b  #$88, d0
00F308  ori.b  #$88, d0
00F30C  ori.b  #$4, d4
00F310  ori.b  #$a4, d0
00F314  ori.b  #$a4, d0
00F318  ori.b  #$4, d4
00F31C  ori.b  #$b8, d0
00F320  ori.b  #$b8, d0
00F324  ori.b  #$4, d4
00F328  ori.b  #$cc, d0
00F32C  ori.b  #$cc, d0
00F330  ori.b  #$4, d4
00F334  ori.b  #$e0, d0
00F338  ori.b  #$e0, d0
00F33C  ori.b  #$4, d4
00F340  ori.b  #$f4, d0
00F344  ori.b  #$f4, d0
00F348  ori.b  #$4, d4
00F34C  ori.b  #$8, d0
00F350  ori.b  #$8, d0
00F354  ori.b  #$4, d4
00F358  ori.b  #$1c, d0
00F35C  ori.b  #$1c, d0
00F360  ori.b  #$4, d4
00F364  ori.b  #$30, d0
00F368  ori.b  #$30, d0
00F36C  ori.b  #$4, d4
00F370  ori.b  #$44, d0
00F374  ori.b  #$44, d0
00F378  ori.b  #$e8, d0
00F37C  ori.b  #$0, d1
00F380  ori.b  #$38, d0
00F384  ori.b  #$3c, d0
00F388  ori.b  #$f4, d0
00F38C  ori.b  #$0, d1
00F390  ori.b  #$3c, d0
00F394  ori.b  #$40, d0
00F398  ori.b  #$0, d0
00F39C  ori.b  #$0, d1
00F3A0  ori.b  #$40, d0
00F3A4  ori.b  #$44, d0
00F3A8  ori.b  #$c, d0
00F3AC  ori.b  #$0, d1
00F3B0  ori.b  #$44, d0
00F3B4  ori.b  #$48, d0
00F3B8  ori.b  #$18, d0
00F3BC  ori.b  #$0, d1
00F3C0  ori.b  #$48, d0
00F3C4  ori.b  #$4c, d0
00F3C8  ori.b  #$24, d0
00F3CC  ori.b  #$0, d1
00F3D0  ori.b  #$4c, d0
00F3D4  ori.b  #$50, d0
00F3D8  ori.b  #$30, d0
00F3DC  ori.b  #$0, d1
00F3E0  ori.b  #$50, d0
00F3E4  ori.b  #$54, d0
00F3E8  ori.b  #$3c, d0
00F3EC  ori.b  #$0, d1
00F3F0  ori.b  #$54, d0
00F3F4  ori.b  #$58, d0
00F3F8  ori.b  #$48, d0
00F3FC  ori.b  #$0, d1
00F400  ori.b  #$58, d0
00F404  ori.b  #$5c, d0
00F408  ori.b  #$54, d0
00F40C  ori.b  #$0, d1
00F410  ori.b  #$5c, d0
00F414  ori.b  #$60, d0
00F418  ori.b  #$60, d0
00F41C  ori.b  #$0, d1
00F420  ori.b  #$60, d0
00F424  ori.b  #$64, d0
00F428  ori.b  #$6c, d0
00F42C  ori.b  #$0, d1
00F430  ori.b  #$64, d0
00F434  ori.b  #$68, d0
00F438  ori.b  #$b8, d0
00F43C  ori.b  #$cc, d0
00F440  ori.b  #$e0, d0
00F444  ori.b  #$f4, d0
00F448  ori.b  #$8, d0
00F44C  ori.b  #$1c, d0
00F450  ori.b  #$30, d0
00F454  ori.b  #$44, d0
00F458  ori.b  #$68, d0
00F45C  ori.b  #$90, d0
00F460  ori.b  #$a4, d0
00F464  ori.b  #$7c, d0
00F468  ori.b  #$2c, d0
00F46C  ori.b  #$48, d0
00F470  ori.b  #$2, d1
00F474  ori.b  #$0, d0
00F478  ori.b  #$0, d0
00F47C  ori.b  #$2c, d0
00F480  ori.b  #$6c, d0
00F484  ori.b  #$2, d1
00F488  ori.b  #$0, d0
00F48C  ori.b  #$0, d0
00F490  ori.b  #$2c, d0
00F494  ori.b  #$54, d0
00F498  ori.b  #$3, d1
00F49C  ori.b  #$0, d0
00F4A0  ori.b  #$0, d0
00F4A4  ori.b  #$2c, d0
00F4A8  ori.b  #$60, d0
00F4AC  ori.b  #$3, d1
00F4B0  ori.b  #$0, d0
00F4B4  ori.b  #$0, d0
00F4B8  ori.b  #$2c, d0
00F4BC  ori.b  #$e8, d0
00F4C0  ori.b  #$1, d1
00F4C4  ori.b  #$0, d0
00F4C8  ori.b  #$0, d0
00F4CC  ori.b  #$2c, d0
00F4D0  ori.b  #$f4, d0
00F4D4  ori.b  #$1, d1
00F4D8  ori.b  #$0, d0
00F4DC  ori.b  #$0, d0
00F4E0  ori.b  #$2c, d0
00F4E4  ori.b  #$0, d0
00F4E8  ori.b  #$1, d1
00F4EC  ori.b  #$0, d0
00F4F0  ori.b  #$0, d0
00F4F4  ori.b  #$2c, d0
00F4F8  ori.b  #$c, d0
00F4FC  ori.b  #$1, d1
00F500  ori.b  #$0, d0
00F504  ori.b  #$0, d0
00F508  ori.b  #$2c, d0
00F50C  ori.b  #$18, d0
00F510  ori.b  #$2, d1
00F514  ori.b  #$0, d0
00F518  ori.b  #$0, d0
00F51C  ori.b  #$2c, d0
00F520  ori.b  #$24, d0
00F524  ori.b  #$3, d1
00F528  ori.b  #$0, d0
00F52C  ori.b  #$0, d0
00F530  ori.b  #$2c, d0
00F534  ori.b  #$30, d0
00F538  ori.b  #$2, d1
00F53C  ori.b  #$0, d0
00F540  ori.b  #$0, d0
00F544  ori.b  #$2c, d0
00F548  ori.b  #$3c, d0
00F54C  ori.b  #$3, d1
00F550  ori.b  #$0, d0
00F554  ori.b  #$0, d0
00F558  ori.b  #$b8, d5
00F55C  ori.b  #$ac, d5
00F560  ori.b  #$0, d5
00F564  ori.b  #$f4, d5
00F568  ori.b  #$d0, d5
00F56C  ori.b  #$c4, d5
00F570  ori.b  #$b8, d5
00F574  ori.b  #$f4, d5
00F578  ori.b  #$e8, d5
00F57C  ori.b  #$dc, d5
00F580  ori.b  #$d0, d5
00F584  ori.b  #$f4, d5
00F588  ori.b  #$60, d5
00F58C  ori.b  #$c, d5
00F590  ori.b  #$18, d5
00F594  ori.b  #$24, d5
00F598  ori.b  #$30, d5
00F59C  ori.b  #$54, d5
00F5A0  ori.b  #$60, d5
00F5A4  ori.b  #$30, d5
00F5A8  ori.b  #$3c, d5
00F5AC  ori.b  #$48, d5
00F5B0  ori.b  #$54, d5
00F5B4  ori.b  #$30, d5
00F5B8  ori.b  #$c, d5
00F5BC  ori.b  #$ac, d5
00F5C0  ori.b  #$b8, d5
00F5C4  ori.b  #$18, d5
00F5C8  ori.b  #$c, d5
00F5CC  ori.b  #$b8, d5
00F5D0  ori.b  #$c4, d5
00F5D4  ori.b  #$24, d5
00F5D8  ori.b  #$18, d5
00F5DC  ori.b  #$b8, d5
00F5E0  ori.b  #$e8, d5
00F5E4  ori.b  #$48, d5
00F5E8  ori.b  #$3c, d5
00F5EC  ori.b  #$dc, d5
00F5F0  ori.b  #$e8, d5
00F5F4  ori.b  #$c, d5
00F5F8  ori.b  #$60, d5
00F5FC  ori.b  #$0, d5
00F600  ori.b  #$ac, d5
00F604  ori.b  #$c, d5
00F608  ori.b  #$0, d5
00F60C  ori.b  #$60, d5
00F610  ori.b  #$54, d5
00F614  ori.b  #$f4, d5
00F618  ori.b  #$0, d5
00F61C  ori.b  #$54, d5
00F620  ori.b  #$48, d5
00F624  ori.b  #$e8, d5
00F628  ori.b  #$f4, d5
00F62C  ori.b  #$54, d5
00F630  ori.b  #$d0, d5
00F634  ori.b  #$dc, d5
00F638  ori.b  #$3c, d5
00F63C  ori.b  #$30, d5
00F640  ori.b  #$d0, d5
00F644  ori.b  #$d0, d5
00F648  ori.b  #$30, d5
00F64C  ori.b  #$24, d5
00F650  ori.b  #$c4, d5
00F654  ori.b  #$d0, d5