; 0x07E42C (zoom/render 4 planos) - zona render
; len 20268 sha1 a1f62fbac5ccd7d25e73f939d8800b88400c99e4

01300  .byte  0x08, 0x80
01302  move.l #$0, d1
01308  jsr    -$2a(a6)
0130C  move.l d0, $13f8.l
01312  move.l #$2d00, d0
01318  move.l #$0, d1
0131E  jsr    -$2a(a6)
01322  move.l d0, $13f0.l
01328  move.w $408c.l, $408a.l
01332  clr.w  $404a.l
01338  lea.l  $408a.l, a0
0133E  lea.l  $9a.l, a1
01344  moveq  #$1f, d7
01346  move.w (a0)+, (a1)
01348  addq.w #$4, a1
0134A  dbra   d7, $1346
0134E  lea.l  $4f0a.l, a0
01354  lea.l  $da.l, a1
0135A  moveq  #$f, d7
0135C  move.w (a0)+, (a1)
0135E  addq.w #$4, a1
01360  dbra   d7, $135c
01364  bsr.w  $14f2
01368  bsr.w  $146a
0136C  bsr.w  $140c
01370  movea.l $13f0.l, a1
01376  move.w #$f, d7
0137A  lea.l  $3d7a.l, a0
01380  move.w #$11, d6
01384  move.l (a0)+, (a1)+
01386  move.l (a0)+, (a1)+
01388  move.l (a0)+, (a1)+
0138A  move.l (a0)+, (a1)+
0138C  move.l (a0)+, (a1)+
0138E  move.l (a0)+, (a1)+
01390  move.l (a0)+, (a1)+
01392  move.l (a0)+, (a1)+
01394  move.l (a0)+, (a1)+
01396  move.l (a0)+, (a1)+
01398  dbra   d6, $1384
0139C  dbra   d7, $137a
013A0  lea.l  $68.l, a0
013A6  move.l #$2e0, d0
013AC  moveq  #$4, d7
013AE  move.w d0, $6(a0)
013B2  swap   d0
013B4  move.w d0, $2(a0)
013B8  swap   d0
013BA  addi.w #$28, d0
013BE  addq.w #$8, a0
013C0  dbra   d7, $13ae
013C4  clr.w  $232.l
013CA  clr.w  $2d0.l
013D0  clr.w  $2d2.l
013D6  lea.l  $dff002.l, a4
013DC  bsr.w  $1746
013E0  lea.l  $dff002.l, a4
013E6  bsr.w  $1746
013EA  movem.l (a7)+, a4-a6
013EE  rts    
013F0  ori.b  #$0, d0
013F4  ori.b  #$0, d0
013F8  ori.b  #$0, d0
013FC  ori.b  #$0, d0
01400  ori.b  #$0, d0
01404  ori.b  #$0, d0
01408  ori.b  #$0, d0
0140C  lea.l  $404a.l, a0
01412  movea.l $13f8.l, a1
01418  moveq  #$3f, d7
0141A  move.w (a0)+, (a1)+
0141C  dbra   d7, $141a
01420  move.l $13f8.l, $1932.l
0142A  move.l #$40ca, $1936.l
01434  move.b #$10, $193a.l
0143C  move.w #$40, $193c.l
01444  bsr.w  $18b8
01448  movea.l $1932.l, a0
0144E  lea.l  $80(a0), a1
01452  move.l a1, $1932.l
01458  moveq  #$3f, d7
0145A  move.w (a0)+, (a1)+
0145C  dbra   d7, $145a
01460  tst.b  $193a.l
01466  bne.b  $1444
01468  rts    
0146A  movea.l $13f4.l, a0
01470  lea.l  $414a.l, a1
01476  lea.l  $370(a1), a2
0147A  lea.l  $370(a2), a3
0147E  lea.l  $370(a3), a4
01482  move.w #$3, d7
01486  clr.l  (a0)+
01488  move.w #$6d, d6
0148C  move.w (a1), (a0)+
0148E  move.w (a2), (a0)+
01490  lea.l  $8(a1), a1
01494  lea.l  $8(a2), a2
01498  dbra   d6, $148c
0149C  clr.l  (a0)+
0149E  clr.l  (a0)+
014A0  move.w #$6d, d6
014A4  move.w (a3), (a0)+
014A6  move.w (a4), (a0)+
014A8  lea.l  $8(a3), a3
014AC  lea.l  $8(a4), a4
014B0  dbra   d6, $14a4
014B4  clr.l  (a0)+
014B6  lea.l  -$36e(a1), a1
014BA  lea.l  -$36e(a2), a2
014BE  lea.l  -$36e(a3), a3
014C2  lea.l  -$36e(a4), a4
014C6  dbra   d7, $1486
014CA  move.l $13f4.l, d0
014D0  lea.l  $2a.l, a1
014D6  moveq  #$7, d7
014D8  move.w d0, $4(a1)
014DC  swap   d0
014DE  move.w d0, (a1)
014E0  swap   d0
014E2  addi.l #$1c0, d0
014E8  lea.l  $8(a1), a1
014EC  dbra   d7, $14d8
014F0  rts    
014F2  move.l $1400.l, d0
014F8  move.w d0, $126.l
014FE  swap   d0
01500  move.w d0, $122.l
01506  move.l #$0, d1
0150C  movea.l $1404.l, a0
01512  move.w #$82, (a0)+
01516  move.w d1, (a0)+
01518  move.w #$80, (a0)+
0151C  swap   d1
0151E  move.w d1, (a0)+
01520  move.l #$fffffffe, (a0)+
01526  movea.l $1408.l, a0
0152C  move.l a0, d1
0152E  swap   d1
01530  movea.l $1400.l, a1
01536  move.w #$80, (a1)+
0153A  move.w d1, (a1)+
0153C  swap   d1
0153E  addi.w #$10, d1
01542  move.w #$2889, d0
01546  move.w #$ff, d7
0154A  move.w d0, (a0)+
0154C  addi.w #$100, d0
01550  move.w #$fffe, (a0)+
01554  move.w #$82, (a0)+
01558  move.w d1, (a0)+
0155A  addi.w #$14, d1
0155E  move.w #$86, (a0)+
01562  move.w #$0, (a0)+
01566  move.w #$8a, (a0)+
0156A  move.w #$0, (a0)+
0156E  move.l #$1005200, (a0)+
01574  dbra   d7, $154a
01578  movea.l $13fc.l, a0
0157E  move.l a0, d0
01580  swap   d0
01582  movea.l $1400.l, a1
01588  lea.l  $4(a1), a1
0158C  move.w #$84, (a1)+
01590  move.w d0, (a1)+
01592  movea.l #$404a, a2
01598  move.w #$29af, d0
0159C  move.w #$20, d7
015A0  movea.l a2, a1
015A2  tst.w  d7
015A4  beq.b  $15a8
015A6  addq.w #$2, a2
015A8  move.w #$1be, (a0)+
015AC  move.w (a1)+, (a0)+
015AE  move.w #$1bc, (a0)+
015B2  move.w (a1)+, (a0)+
015B4  move.w #$1ba, (a0)+
015B8  move.w (a1)+, (a0)+
015BA  move.w #$1b8, (a0)+
015BE  move.w (a1)+, (a0)+
015C0  move.w #$1b6, (a0)+
015C4  move.w (a1)+, (a0)+
015C6  move.w #$1b4, (a0)+
015CA  move.w (a1)+, (a0)+
015CC  move.w #$1b2, (a0)+
015D0  move.w (a1)+, (a0)+
015D2  move.w #$1b0, (a0)+
015D6  move.w (a1)+, (a0)+
015D8  move.w #$1ae, (a0)+
015DC  move.w (a1)+, (a0)+
015DE  move.w #$1ac, (a0)+
015E2  move.w (a1)+, (a0)+
015E4  move.w #$1aa, (a0)+
015E8  move.w (a1)+, (a0)+
015EA  move.w #$1a8, (a0)+
015EE  move.w (a1)+, (a0)+
015F0  move.w #$1a6, (a0)+
015F4  move.w (a1)+, (a0)+
015F6  move.w #$1a4, (a0)+
015FA  move.w (a1)+, (a0)+
015FC  move.w #$1a2, (a0)+
01600  move.w (a1)+, (a0)+
01602  move.w #$1a0, (a0)+
01606  move.w (a1)+, (a0)+
01608  move.w #$19e, (a0)+
0160C  move.w (a1)+, (a0)+
0160E  move.w #$19c, (a0)+
01612  move.w (a1)+, (a0)+
01614  move.w #$19a, (a0)+
01618  move.w (a1)+, (a0)+
0161A  move.w #$198, (a0)+
0161E  move.w (a1)+, (a0)+
01620  move.w #$196, (a0)+
01624  move.w (a1)+, (a0)+
01626  move.w #$194, (a0)+
0162A  move.w (a1)+, (a0)+
0162C  move.w #$192, (a0)+
01630  move.w (a1)+, (a0)+
01632  move.w #$190, (a0)+
01636  move.w (a1)+, (a0)+
01638  move.w #$18e, (a0)+
0163C  move.w (a1)+, (a0)+
0163E  move.w #$18c, (a0)+
01642  move.w (a1)+, (a0)+
01644  move.w #$18a, (a0)+
01648  move.w (a1)+, (a0)+
0164A  move.w #$188, (a0)+
0164E  move.w (a1)+, (a0)+
01650  move.w #$186, (a0)+
01654  move.w (a1)+, (a0)+
01656  move.w #$184, (a0)+
0165A  move.w (a1)+, (a0)+
0165C  move.w #$182, (a0)+
01660  move.w (a1)+, (a0)+
01662  move.w #$88, (a0)+
01666  move.w #$0, (a0)+
0166A  dbra   d7, $15a0
0166E  bsr.w  $2d4
01672  btst.b #$6, (a4)
01676  bne.b  $1672
01678  move.l #$ffffffff, $42(a4)
01680  move.l #$1000000, $3e(a4)
01688  clr.w  $64(a4)
0168C  move.l #$2e0, $52(a4)
01694  move.w #$154, $56(a4)
0169A  btst.b #$6, (a4)
0169E  bne.b  $169a
016A0  clr.w  $248.l
016A6  clr.w  $23c.l
016AC  clr.w  $1296.l
016B2  clr.w  $1298.l
016B8  clr.l  $240.l
016BE  clr.l  $244.l
016C4  clr.w  $238.l
016CA  clr.w  $23a.l
016D0  clr.w  $129a.l
016D6  move.w #$220, $23e.l
016DE  move.w #$5200, $16.l
016E6  lea.l  $68.l, a0
016EC  move.l #$2e0, d0
016F2  moveq  #$4, d7
016F4  move.w d0, $6(a0)
016F8  swap   d0
016FA  move.w d0, $2(a0)
016FE  swap   d0