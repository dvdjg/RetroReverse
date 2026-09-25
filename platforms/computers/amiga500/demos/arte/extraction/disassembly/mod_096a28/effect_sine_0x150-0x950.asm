; 0x096A28 - efecto SINE (distorsion) - init + tabla de distorsion
; len 3260 sha1 79cdb836cd66e522ae7d034c5ea9add92604a0d5

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
02AA  move.l #$3a8, $64.w
02B2  lea.l  $0.l, a0
02B8  lea.l  $352(pc), a1
02BC  move.w #$8010, d0
02C0  jsr    -$54(a6)
02C4  move.w #$4, $dff09c.l
02CC  move.w #$8004, $dff09a.l
02D4  moveq  #$a, d0
02D6  trap   #$d
02D8  move.w #$87e0, $dff096.l
02E0  jsr    -$11a(a6)
02E4  movea.l $26(a0), a1
02E8  cmpi.w #$13, $1c(a1)
02EE  beq.b  $30a
02F0  movea.l $20(a5), a0
02F4  movea.l $4(a0), a0
02F8  jsr    (a0)
02FA  movea.l $20(a5), a0
02FE  move.w $c(a0), d0
0302  cmp.w  $e(a0), d0
0306  bcs.w  $2e0
030A  movea.l #$dff002, a4
0310  btst.b #$6, (a4)
0314  bne.b  $310
0316  moveq  #$0, d0
0318  rts    
031A  ori.b  #$4, d0
031E  ori.b  #$0, d0
0322  ori.b  #$8, d0
0326  ori.b  #$1, d0
032A  ori.b  #$c, d0
032E  ori.b  #$f, d0
0332  ori.b  #$10, d0
0336  ori.b  #$b, d0
033A  ori.b  #$14, d0
033E  ori.b  #$4, d0
0342  ori.b  #$18, d0
0346  ori.b  #$0, d0
034A  or.b   d0, d0
034C  ori.b  #$0, d0
0350  ori.b  #$e7, d0
0354  .byte  0xff, 0xfe
0356  lea.l  $0.l, a5
035C  movea.l $10(a5), a6
0360  movea.l $20(a5), a0
0364  movea.l $8(a0), a0
0368  jsr    (a0)
036A  cmpi.w #$570, $0(a5)
0370  blt.b  $386
0372  lea.l  $118.l, a0
0378  lea.l  $90.l, a1
037E  moveq  #$f, d0
0380  moveq  #$2, d1
0382  jsr    -$a2(a6)
0386  addq.w #$1, $0(a5)
038A  jsr    $7b6.l
0390  movem.l (a7)+, d0-d7/a0-a6
0394  move.w #$8004, $dff09c.l
039C  move.w #$10, $dff09c.l
03A4  nop    
03A6  rte    
03A8  movem.l d0-d7/a0-a6, -(a7)
03AC  lea.l  $0.l, a5
03B2  movea.l $10(a5), a6
03B6  bsr.w  $906
03BA  move.b #$0, $2(a5)
03C0  movem.l (a7)+, d0-d7/a0-a6
03C4  move.w #$4, $dff09c.l
03CC  nop    
03CE  rte    
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
047E  ori.b  #$3, d0
0482  ori.b  #$0, d0
0486  ori.b  #$3, d0
048A  ori.b  #$0, d3
048E  ori.b  #$3, d3
0492  ori.b  #$0, d3
0496  ori.b  #$3, d3
049A  btst.l d1, d0
049C  ori.b  #$0, d0
04A0  ori.b  #$0, d3
04A4  btst.l d1, d0
04A6  btst.l d1, d0
04A8  btst.l d1, d3
04AA  btst.l d1, d3
04AC  ori.b  #$3, d0
04B0  ori.b  #$3, d3
04B4  btst.l d1, d0
04B6  btst.l d1, d3
04B8  btst.l d1, d3
04BA  ori.b  #$0, d0
04BE  ori.b  #$0, d0
04C2  ori.b  #$3, d0
04C6  ori.b  #$3, d0
04CA  btst.l d1, d0
04CC  ori.b  #$0, d0
04D0  btst.l d1, d0
04D2  btst.l d1, d0
04D4  ori.b  #$0, d3
04D8  btst.l d1, d3
04DA  ori.b  #$0, d3
04DE  ori.b  #$0, d3
04E2  ori.b  #$3, d3
04E6  ori.b  #$3, d3
04EA  btst.l d1, d3
04EC  ori.b  #$3, d0
04F0  btst.l d1, d0
04F2  btst.l d1, d3
04F4  ori.b  #$3, d3
04F8  btst.l d1, d3
04FA  movea.l $68(a5), a0
04FE  moveq  #$2a, d0
0500  moveq  #$b, d1
0502  lea.l  $674(pc), a1
0506  moveq  #$37, d2
0508  move.w (a1)+, (a0)+
050A  dbra   d2, $508
050E  dbra   d1, $502
0512  lea.l  $6e4(pc), a1
0516  moveq  #$d, d1
0518  move.w (a1)+, (a0)+
051A  dbra   d1, $518
051E  dbra   d0, $500
0522  lea.l  $700(pc), a1
0526  moveq  #$0, d1
0528  move.w (a1)+, (a0)+
052A  dbra   d1, $518
052E  movea.l $6c(a5), a0
0532  moveq  #$0, d0
0534  moveq  #$0, d3
0536  move.w d0, d1
0538  add.w  d1, d1
053A  roxr.w #$1, d2
053C  add.w  d1, d1
053E  roxr.w #$1, d2
0540  add.w  d1, d1
0542  roxr.w #$1, d2
0544  add.w  d1, d1
0546  roxr.w #$1, d2
0548  add.w  d1, d1
054A  roxr.w #$1, d2
054C  add.w  d1, d1
054E  roxr.w #$1, d2
0550  add.w  d1, d1
0552  roxr.w #$1, d2
0554  add.w  d1, d1
0556  roxr.w #$1, d2
0558  add.w  d1, d1
055A  roxr.w #$1, d2
055C  add.w  d1, d1
055E  roxr.w #$1, d2
0560  add.w  d1, d1
0562  roxr.w #$1, d2
0564  add.w  d1, d1
0566  roxr.w #$1, d2
0568  add.w  d1, d1
056A  roxr.w #$1, d2
056C  add.w  d1, d1
056E  roxr.w #$1, d2
0570  add.w  d1, d1
0572  roxr.w #$1, d2
0574  add.w  d1, d1
0576  roxr.w #$1, d2
0578  move.w d2, (a0, d3.w)
057C  addq.w #$3, d0
057E  addq.w #$2, d3
0580  move.w d0, d1
0582  add.w  d1, d1
0584  roxr.w #$1, d2
0586  add.w  d1, d1
0588  roxr.w #$1, d2
058A  add.w  d1, d1
058C  roxr.w #$1, d2
058E  add.w  d1, d1
0590  roxr.w #$1, d2
0592  add.w  d1, d1
0594  roxr.w #$1, d2
0596  add.w  d1, d1
0598  roxr.w #$1, d2
059A  add.w  d1, d1
059C  roxr.w #$1, d2
059E  add.w  d1, d1
05A0  roxr.w #$1, d2
05A2  add.w  d1, d1
05A4  roxr.w #$1, d2
05A6  add.w  d1, d1
05A8  roxr.w #$1, d2
05AA  add.w  d1, d1
05AC  roxr.w #$1, d2
05AE  add.w  d1, d1
05B0  roxr.w #$1, d2
05B2  add.w  d1, d1
05B4  roxr.w #$1, d2
05B6  add.w  d1, d1
05B8  roxr.w #$1, d2
05BA  add.w  d1, d1
05BC  roxr.w #$1, d2
05BE  add.w  d1, d1
05C0  roxr.w #$1, d2
05C2  move.w d2, (a0, d3.w)
05C6  addq.w #$1, d0
05C8  addq.w #$2, d3
05CA  cmp.w  #$4000, d3
05CE  bne.w  $536
05D2  move.w #$c000, d0
05D6  move.w d0, d1
05D8  add.w  d1, d1
05DA  roxr.w #$1, d2
05DC  add.w  d1, d1
05DE  roxr.w #$1, d2
05E0  add.w  d1, d1
05E2  roxr.w #$1, d2
05E4  add.w  d1, d1
05E6  roxr.w #$1, d2
05E8  add.w  d1, d1
05EA  roxr.w #$1, d2
05EC  add.w  d1, d1
05EE  roxr.w #$1, d2
05F0  add.w  d1, d1
05F2  roxr.w #$1, d2
05F4  add.w  d1, d1
05F6  roxr.w #$1, d2
05F8  add.w  d1, d1
05FA  roxr.w #$1, d2
05FC  add.w  d1, d1
05FE  roxr.w #$1, d2
0600  add.w  d1, d1
0602  roxr.w #$1, d2
0604  add.w  d1, d1
0606  roxr.w #$1, d2
0608  add.w  d1, d1
060A  roxr.w #$1, d2
060C  add.w  d1, d1
060E  roxr.w #$1, d2
0610  add.w  d1, d1
0612  roxr.w #$1, d2
0614  add.w  d1, d1
0616  roxr.w #$1, d2
0618  move.w d2, (a0, d3.w)
061C  addq.w #$3, d0
061E  addq.w #$2, d3
0620  move.w d0, d1
0622  add.w  d1, d1
0624  roxr.w #$1, d2
0626  add.w  d1, d1
0628  roxr.w #$1, d2
062A  add.w  d1, d1
062C  roxr.w #$1, d2
062E  add.w  d1, d1
0630  roxr.w #$1, d2
0632  add.w  d1, d1
0634  roxr.w #$1, d2
0636  add.w  d1, d1
0638  roxr.w #$1, d2
063A  add.w  d1, d1
063C  roxr.w #$1, d2
063E  add.w  d1, d1
0640  roxr.w #$1, d2
0642  add.w  d1, d1
0644  roxr.w #$1, d2
0646  add.w  d1, d1
0648  roxr.w #$1, d2
064A  add.w  d1, d1
064C  roxr.w #$1, d2
064E  add.w  d1, d1
0650  roxr.w #$1, d2
0652  add.w  d1, d1
0654  roxr.w #$1, d2
0656  add.w  d1, d1
0658  roxr.w #$1, d2
065A  add.w  d1, d1
065C  roxr.w #$1, d2
065E  add.w  d1, d1
0660  roxr.w #$1, d2
0662  move.w d2, (a0, d3.w)
0666  addq.w #$1, d0
0668  addq.w #$2, d3
066A  cmp.w  #$8000, d3
066E  bne.w  $5d6
0672  rts    
0674  move.w $2(a5), d5
0678  move.b $2(a5), d5
067C  movea.l d5, a6
067E  move.w $2(a5), d5
0682  move.b $2(a5), d5
0686  move.l (a6), d0
0688  movea.l d5, a6
068A  or.l   -(a6), d0
068C  move.w d0, d1
068E  move.b d0, d2
0690  move.w d2, (a0)+
0692  and.w  d7, d2
0694  move.w (a4, d2.w), d2
0698  move.w d2, -(a2)
069A  swap   d0
069C  move.b d0, d3
069E  move.w d3, $1176(a0)
06A2  and.w  d7, d3
06A4  move.w (a4, d3.w), d3
06A8  move.w d3, $1178(a2)
06AC  move.w $2(a5), d6
06B0  move.b $2(a5), d6
06B4  movea.l d6, a6
06B6  move.w $2(a5), d6
06BA  move.b $2(a5), d6
06BE  move.l (a6), d3
06C0  movea.l d6, a6
06C2  or.l   -(a6), d3
06C4  move.w d3, d2
06C6  move.b d3, d1
06C8  move.w d1, (a1)+
06CA  and.w  d7, d1
06CC  move.w (a4, d1.w), d1
06D0  move.w d1, -(a3)
06D2  swap   d3
06D4  move.b d3, d0
06D6  move.w d0, $1176(a1)
06DA  and.w  d7, d0
06DC  move.w (a4, d0.w), d0
06E0  move.w d0, $1178(a3)
06E4  move.w d2, (a0)+
06E6  move.w d3, $1176(a0)
06EA  and.w  d7, d2
06EC  move.w (a4, d2.w), d2
06F0  move.w d2, -(a2)
06F2  and.w  d7, d3
06F4  move.w (a4, d3.w), d3
06F8  move.w d3, $1178(a2)
06FC  subq.w #$2, a3
06FE  addq.w #$2, a1
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
0830  move.w (a0), d1
0832  addq.w #$1, d1
0834  cmp.w  d1, d0
0836  bne.b  $83a
0838  moveq  #$0, d1
083A  move.w d1, (a0)
083C  add.w  d1, d1
083E  add.w  d1, d1
0840  movem.l (a1, d1.w), d0/a0
0846  rts    
0848  moveq  #$0, d0
084A  move.w $48(a5), d0
084E  addi.w #$100, $48(a5)
0854  movea.l $60(a5), a0
0858  adda.l d0, a0
085A  movea.l a0, a1
085C  adda.l #$10000, a1
0862  lea.l  $c90.l, a2
0868  movea.l $64(a5), a3
086C  move.w #$3ffe, d7
0870  addi.w #$8, $4e(a5)
0876  move.w $4e(a5), d0
087A  and.w  d7, d0
087C  move.w (a3, d0.w), d0
0880  lsr.w  #$7, d0
0882  move.w d0, $4a(a5)
0886  move.w d0, $4c(a5)
088A  move.w $50(a5), d1
088E  addq.w #$8, d1
0890  add.w  d1, $4e(a5)
0894  move.w $4e(a5), d1
0898  and.w  d7, d1
089A  move.w (a3, d1.w), d1
089E  addi.w #$8000, d1
08A2  asr.w  #$8, d1
08A4  asr.w  #$3, d1
08A6  add.w  d1, d0
08A8  move.w d0, $4c(a5)
08AC  move.l $50(a5), d0
08B0  move.l d0, d1
08B2  lsr.l  #$8, d1
08B4  add.l  d1, d0
08B6  addq.l #$1, d0
08B8  move.l d0, $50(a5)
08BC  moveq  #$0, d1
08BE  move.w $48(a5), d1
08C2  lsr.w  #$2, d1
08C4  move.w $4a(a5), d2
08C8  move.w d2, d5
08CA  lsl.w  #$6, d5
08CC  sub.w  d5, d1
08CE  moveq  #$0, d3
08D0  move.w $4c(a5), d4
08D4  move.w d4, d5
08D6  lsl.w  #$6, d5
08D8  sub.w  d5, d3
08DA  moveq  #$7f, d0
08DC  add.w  d2, d1
08DE  and.w  d7, d1
08E0  add.w  d4, d3
08E2  and.w  d7, d3
08E4  move.b (a3, d1.w), d5
08E8  add.b  (a3, d3.w), d5
08EC  addi.w #$80, d5
08F0  lsr.b  #$3, d5
08F2  andi.w #$3e, d5
08F6  move.w (a2, d5.w), d5
08FA  move.w d5, (a0)+
08FC  move.w d5, (a1)+
08FE  dbra   d0, $8dc
0902  rts    
0904  rts    
0906  movem.l a5-a6, -(a7)
090A  movea.l $64(a5), a0
090E  lea.l  $38(a5), a1
0912  move.w #$3ffe, d2
0916  move.w (a1)+, d0
0918  and.w  d2, d0
091A  move.w (a0, d0.w), d0
091E  muls.w #$a0, d0
0922  swap   d0
0924  move.w (a1)+, d1
0926  and.w  d2, d1
0928  move.w (a0, d1.w), d1
092C  muls.w #$80, d1
0930  swap   d1
0932  add.w  d1, d0
0934  addi.w #$10, d0
0938  add.w  d0, $30(a5)
093C  move.w (a1)+, d0
093E  and.w  d2, d0
0940  move.w (a0, d0.w), d0
0944  muls.w #$1800, d0
0948  swap   d0
094A  move.w (a1)+, d1
094C  and.w  d2, d1
094E  move.w -$56(a0, a2.l), d1