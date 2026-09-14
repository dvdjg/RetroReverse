; Motor de blobs - zona 0x34C6-0x5342 (render con lookup tables)
; len 63064 sha1 b37f140c327309db4e8f2894ad100b9018144302

03300  move.w d2, d4
03302  sub.w  d2, d3
03304  move.w d3, d2
03306  add.w  d2, d2
03308  move.w (a1, d2.w), (a0)+
0330C  add.w  d4, d4
0330E  move.w d4, (a0)+
03310  addq.b #$4, d1
03312  bne.b  $32f8
03314  addq.b #$1, d0
03316  bne.b  $32f6
03318  lea.l  $318dc.l, a0
0331E  lea.l  $336e.l, a2
03324  lea.l  $338e.l, a3
0332A  moveq  #$0, d0
0332C  moveq  #$0, d1
0332E  move.w d0, d2
03330  move.w d1, d3
03332  lsr.w  #$4, d2
03334  lsr.w  #$4, d3
03336  moveq  #$f, d4
03338  and.w  d0, d4
0333A  eori.w #$f, d4
0333E  add.w  d4, d4
03340  move.w (a2, d4.w), d3
03344  moveq  #$f, d4
03346  and.w  d1, d4
03348  add.w  d4, d4
0334A  move.w (a3, d4.w), d4
0334E  move.w d4, (a0)+
03350  move.w d3, (a0)+
03352  addq.b #$1, d1
03354  bne.b  $332e
03356  addq.b #$1, d0
03358  and.b  #$3f, d0
0335C  bne.b  $332c
0335E  rts    
03360  and.w  d3, d4
03362  move.w d4, (a0)+
03364  move.w d4, (a0)+
03366  bra.b  $3352
03368  move.w d3, (a0)+
0336A  move.w d4, (a0)+
0336C  bra.b  $3352
0336E  ori.b  #$3, d1
03372  ori.b  #$f, d7
03376  ori.b  #$3f, (a7)+
0337A  .byte  0x00, 0x7f
0337C  .byte  0x00, 0xff
0337E  .byte  0x01, 0xff
03380  .byte  0x03, 0xff
03382  .byte  0x07, 0xff
03384  .byte  0x0f, 0xff
03386  .byte  0x1f, 0xff
03388  .byte  0x3f, 0xff
0338A  .byte  0x7f, 0xff
0338C  .byte  0xff, 0xff
0338E  or.b   d0, d0
03390  and.b  d0, d0
03392  asr.b  #$8, d0
03394  dc.w   $f000
03396  dc.w   $f800
03398  dc.w   $fc00
0339A  dc.w   $fe00
0339C  .byte  0xff, 0x00
0339E  .byte  0xff, 0x80
033A0  .byte  0xff, 0xc0
033A2  .byte  0xff, 0xe0
033A4  .byte  0xff, 0xf0
033A6  .byte  0xff, 0xf8
033A8  .byte  0xff, 0xfc
033AA  .byte  0xff, 0xfe
033AC  .byte  0xff, 0xff
033AE  ori.b  #$0, d0
033B2  ori.b  #$0, d0
033B6  ori.b  #$0, d0
033BA  ori.b  #$0, d0
033BE  ori.b  #$0, d0
033C2  ori.b  #$0, d0
033C6  ori.b  #$0, d0
033CA  ori.b  #$0, d0
033CE  .byte  0x00, 0x08
033D0  ori.b  #$30, (a6)+
033D4  ori.w  #$70, (a0)
033D8  ori.l  #$bc00e8, (a6)
033DE  btst.l d0, (a4)
033E0  bchg.b d0, d6
033E2  bchg.b d0, $1b0.w
033E6  bset.b d0, $226(a0)
033EA  andi.w #$2a8, -(a4)
033EE  .byte  0x02, 0xec
033F0  btst.l d1, (d0.w * 2)
033F4  rts    
033F6  movea.l $4(a1), a2
033FA  move.w $2(a2), d7
033FE  cmp.w  #$3, d7
03402  bcs.b  $33f4
03404  movea.l $8(a2), a2
03408  bsr.w  $3254
0340C  bra.w  $3450
03410  ori.b  #$d4, d0
03414  ori.b  #$a4, d0
03418  ori.b  #$74, d0
0341C  ori.b  #$44, d0
03420  ori.b  #$14, d0
03424  ori.b  #$e4, d0
03428  ori.b  #$b4, d0
0342C  ori.b  #$84, d0
03430  ori.b  #$14, d0
03434  ori.b  #$a4, d0
03438  ori.b  #$74, d0
0343C  ori.b  #$44, d0
03440  ori.b  #$14, d0
03444  ori.b  #$e4, d0
03448  ori.b  #$b4, d0
0344C  ori.b  #$84, d0
03450  moveq  #$0, d0
03452  move.b $b(a1), d0
03456  add.w  d0, d0
03458  add.w  d0, d0
0345A  movea.l $3410(pc, d0.w), a6
0345E  sub.w  d5, d6
03460  lea.l  $114d0.l, a0
03466  adda.w d5, a0
03468  adda.w d5, a0
0346A  tst.b  $9(a1)
0346E  lea.l  $208(a0), a1
03472  bpl.b  $3476
03474  exg.l  a0, a1
03476  lea.l  $0.l, a5
0347C  movea.l $c(a5), a2
03480  mulu.w #$60, d5
03484  adda.l d5, a2
03486  moveq  #$ff, d4
03488  moveq  #$0, d5
0348A  lea.l  $318dc.l, a5
03490  move.l a7, $5354.l
03496  movea.l a1, a7
03498  dbra   d6, $34a0
0349C  bra.w  $34cc
034A0  moveq  #$0, d2
034A2  move.w (a0)+, d2
034A4  move.b (a7)+, d2
034A6  moveq  #$fc, d3
034A8  and.w  d2, d3
034AA  move.l (a5, d3.l), d0
034AE  add.w  d2, d2
034B0  add.w  d2, d2
034B2  move.l (a5, d2.l), d2
034B6  lea.l  (a2, d0.w), a3
034BA  lea.l  $60(a2), a2
034BE  lea.l  $20(a3), a4
034C2  lea.l  $20(a4), a1
034C6  swap   d0
034C8  jmp    (a6, d0.w)
034CC  movea.l $5354.l, a7
034D2  rts    
034D4  dbra   d6, $34a0
034D8  bra.w  $34cc
034DC  move.l d2, d3
034DE  swap   d3
034E0  and.w  d3, d2
034E2  not.w  d2
034E4  and.w  d2, (a3)+
034E6  and.w  d2, (a4)+
034E8  and.w  d2, (a1)+
034EA  dbra   d6, $34a0
034EE  bra.w  $34cc
034F2  swap   d2
034F4  not.l  d2
034F6  and.l  d2, (a3)+
034F8  and.l  d2, (a4)+
034FA  and.l  d2, (a1)+
034FC  dbra   d6, $34a0
03500  bra.w  $34cc
03504  not.w  d2
03506  and.w  d2, (a3)+
03508  and.w  d2, (a4)+
0350A  and.w  d2, (a1)+
0350C  move.w d5, (a3)+
0350E  move.w d5, (a4)+
03510  move.w d5, (a1)+
03512  swap   d2
03514  not.w  d2
03516  and.w  d2, (a3)+
03518  and.w  d2, (a4)+
0351A  and.w  d2, (a1)+
0351C  dbra   d6, $34a0
03520  bra.w  $34cc
03524  not.w  d2
03526  and.w  d2, (a3)+
03528  and.w  d2, (a4)+
0352A  and.w  d2, (a1)+
0352C  move.l d5, (a3)+
0352E  move.l d5, (a4)+
03530  move.l d5, (a1)+
03532  swap   d2
03534  not.w  d2
03536  and.w  d2, (a3)+
03538  and.w  d2, (a4)+
0353A  and.w  d2, (a1)+
0353C  dbra   d6, $34a0
03540  bra.w  $34cc
03544  not.w  d2
03546  and.w  d2, (a3)+
03548  and.w  d2, (a4)+
0354A  and.w  d2, (a1)+
0354C  move.l d5, (a3)+
0354E  move.l d5, (a4)+
03550  move.l d5, (a1)+
03552  move.w d5, (a3)+
03554  move.w d5, (a4)+
03556  move.w d5, (a1)+
03558  swap   d2
0355A  not.w  d2
0355C  and.w  d2, (a3)+
0355E  and.w  d2, (a4)+
03560  and.w  d2, (a1)+
03562  dbra   d6, $34a0
03566  bra.w  $34cc
0356A  not.w  d2
0356C  and.w  d2, (a3)+
0356E  and.w  d2, (a4)+
03570  and.w  d2, (a1)+
03572  move.l d5, (a3)+
03574  move.l d5, (a4)+
03576  move.l d5, (a1)+
03578  move.l d5, (a3)+
0357A  move.l d5, (a4)+
0357C  move.l d5, (a1)+
0357E  swap   d2
03580  not.w  d2
03582  and.w  d2, (a3)+
03584  and.w  d2, (a4)+
03586  and.w  d2, (a1)+
03588  dbra   d6, $34a0
0358C  bra.w  $34cc
03590  not.w  d2
03592  and.w  d2, (a3)+
03594  and.w  d2, (a4)+
03596  and.w  d2, (a1)+
03598  move.w d5, (a3)+
0359A  move.w d5, (a4)+
0359C  move.w d5, (a1)+
0359E  move.l d5, (a3)+
035A0  move.l d5, (a4)+
035A2  move.l d5, (a1)+
035A4  move.l d5, (a3)+
035A6  move.l d5, (a4)+
035A8  move.l d5, (a1)+
035AA  swap   d2
035AC  not.w  d2
035AE  and.w  d2, (a3)+
035B0  and.w  d2, (a4)+
035B2  and.w  d2, (a1)+
035B4  dbra   d6, $34a0
035B8  bra.w  $34cc
035BC  not.w  d2
035BE  and.w  d2, (a3)+
035C0  and.w  d2, (a4)+
035C2  and.w  d2, (a1)+
035C4  move.l d5, (a3)+
035C6  move.l d5, (a4)+
035C8  move.l d5, (a1)+
035CA  move.l d5, (a3)+
035CC  move.l d5, (a4)+
035CE  move.l d5, (a1)+
035D0  move.l d5, (a3)+
035D2  move.l d5, (a4)+
035D4  move.l d5, (a1)+
035D6  swap   d2
035D8  not.w  d2
035DA  and.w  d2, (a3)+
035DC  and.w  d2, (a4)+
035DE  and.w  d2, (a1)+
035E0  dbra   d6, $34a0
035E4  bra.w  $34cc
035E8  not.w  d2
035EA  and.w  d2, (a3)+
035EC  and.w  d2, (a4)+
035EE  and.w  d2, (a1)+
035F0  move.w d5, (a3)+
035F2  move.w d5, (a4)+
035F4  move.w d5, (a1)+
035F6  move.l d5, (a3)+
035F8  move.l d5, (a4)+
035FA  move.l d5, (a1)+
035FC  move.l d5, (a3)+
035FE  move.l d5, (a4)+
03600  move.l d5, (a1)+
03602  move.l d5, (a3)+
03604  move.l d5, (a4)+
03606  move.l d5, (a1)+
03608  swap   d2
0360A  not.w  d2
0360C  and.w  d2, (a3)+
0360E  and.w  d2, (a4)+
03610  and.w  d2, (a1)+
03612  dbra   d6, $34a0
03616  bra.w  $34cc
0361A  not.w  d2
0361C  and.w  d2, (a3)+
0361E  and.w  d2, (a4)+
03620  and.w  d2, (a1)+
03622  move.l d5, (a3)+
03624  move.l d5, (a4)+
03626  move.l d5, (a1)+
03628  move.l d5, (a3)+
0362A  move.l d5, (a4)+
0362C  move.l d5, (a1)+
0362E  move.l d5, (a3)+
03630  move.l d5, (a4)+
03632  move.l d5, (a1)+
03634  move.l d5, (a3)+
03636  move.l d5, (a4)+
03638  move.l d5, (a1)+
0363A  swap   d2
0363C  not.w  d2
0363E  and.w  d2, (a3)+
03640  and.w  d2, (a4)+
03642  and.w  d2, (a1)+
03644  dbra   d6, $34a0
03648  bra.w  $34cc
0364C  not.w  d2
0364E  and.w  d2, (a3)+
03650  and.w  d2, (a4)+
03652  and.w  d2, (a1)+
03654  move.w d5, (a3)+
03656  move.w d5, (a4)+
03658  move.w d5, (a1)+
0365A  move.l d5, (a3)+
0365C  move.l d5, (a4)+
0365E  move.l d5, (a1)+
03660  move.l d5, (a3)+
03662  move.l d5, (a4)+
03664  move.l d5, (a1)+
03666  move.l d5, (a3)+
03668  move.l d5, (a4)+
0366A  move.l d5, (a1)+
0366C  move.l d5, (a3)+
0366E  move.l d5, (a4)+
03670  move.l d5, (a1)+
03672  swap   d2
03674  not.w  d2
03676  and.w  d2, (a3)+
03678  and.w  d2, (a4)+
0367A  and.w  d2, (a1)+
0367C  dbra   d6, $34a0
03680  bra.w  $34cc
03684  not.w  d2
03686  and.w  d2, (a3)+
03688  and.w  d2, (a4)+
0368A  and.w  d2, (a1)+
0368C  move.l d5, (a3)+
0368E  move.l d5, (a4)+
03690  move.l d5, (a1)+
03692  move.l d5, (a3)+
03694  move.l d5, (a4)+
03696  move.l d5, (a1)+
03698  move.l d5, (a3)+
0369A  move.l d5, (a4)+
0369C  move.l d5, (a1)+
0369E  move.l d5, (a3)+
036A0  move.l d5, (a4)+
036A2  move.l d5, (a1)+
036A4  move.l d5, (a3)+
036A6  move.l d5, (a4)+
036A8  move.l d5, (a1)+
036AA  swap   d2
036AC  not.w  d2
036AE  and.w  d2, (a3)+
036B0  and.w  d2, (a4)+
036B2  and.w  d2, (a1)+
036B4  dbra   d6, $34a0
036B8  bra.w  $34cc
036BC  not.w  d2
036BE  and.w  d2, (a3)+
036C0  and.w  d2, (a4)+
036C2  and.w  d2, (a1)+
036C4  move.w d5, (a3)+
036C6  move.w d5, (a4)+
036C8  move.w d5, (a1)+
036CA  move.l d5, (a3)+
036CC  move.l d5, (a4)+
036CE  move.l d5, (a1)+
036D0  move.l d5, (a3)+
036D2  move.l d5, (a4)+
036D4  move.l d5, (a1)+
036D6  move.l d5, (a3)+
036D8  move.l d5, (a4)+
036DA  move.l d5, (a1)+
036DC  move.l d5, (a3)+
036DE  move.l d5, (a4)+
036E0  move.l d5, (a1)+
036E2  move.l d5, (a3)+
036E4  move.l d5, (a4)+
036E6  move.l d5, (a1)+
036E8  swap   d2
036EA  not.w  d2
036EC  and.w  d2, (a3)+
036EE  and.w  d2, (a4)+
036F0  and.w  d2, (a1)+
036F2  dbra   d6, $34a0
036F6  bra.w  $34cc
036FA  not.w  d2
036FC  and.w  d2, (a3)+
036FE  and.w  d2, (a4)+
03700  and.w  d2, (a1)+
03702  move.l d5, (a3)+
03704  move.l d5, (a4)+
03706  move.l d5, (a1)+
03708  move.l d5, (a3)+
0370A  move.l d5, (a4)+
0370C  move.l d5, (a1)+
0370E  move.l d5, (a3)+
03710  move.l d5, (a4)+
03712  move.l d5, (a1)+
03714  move.l d5, (a3)+
03716  move.l d5, (a4)+
03718  move.l d5, (a1)+
0371A  move.l d5, (a3)+
0371C  move.l d5, (a4)+
0371E  move.l d5, (a1)+
03720  move.l d5, (a3)+
03722  move.l d5, (a4)+
03724  move.l d5, (a1)+
03726  swap   d2
03728  not.w  d2
0372A  and.w  d2, (a3)+
0372C  and.w  d2, (a4)+
0372E  and.w  d2, (a1)+
03730  dbra   d6, $34a0
03734  bra.w  $34cc
03738  not.w  d2
0373A  and.w  d2, (a3)+
0373C  and.w  d2, (a4)+
0373E  and.w  d2, (a1)+
03740  move.w d5, (a3)+
03742  move.w d5, (a4)+
03744  move.w d5, (a1)+
03746  move.l d5, (a3)+
03748  move.l d5, (a4)+
0374A  move.l d5, (a1)+
0374C  move.l d5, (a3)+
0374E  move.l d5, (a4)+
03750  move.l d5, (a1)+
03752  move.l d5, (a3)+
03754  move.l d5, (a4)+
03756  move.l d5, (a1)+
03758  move.l d5, (a3)+
0375A  move.l d5, (a4)+
0375C  move.l d5, (a1)+
0375E  move.l d5, (a3)+
03760  move.l d5, (a4)+
03762  move.l d5, (a1)+
03764  move.l d5, (a3)+
03766  move.l d5, (a4)+
03768  move.l d5, (a1)+
0376A  swap   d2
0376C  not.w  d2
0376E  and.w  d2, (a3)+
03770  and.w  d2, (a4)+
03772  and.w  d2, (a1)+
03774  dbra   d6, $34a0
03778  bra.w  $34cc
0377C  not.w  d2
0377E  and.w  d2, (a3)+
03780  and.w  d2, (a4)+
03782  and.w  d2, (a1)+
03784  move.l d5, (a3)+
03786  move.l d5, (a4)+
03788  move.l d5, (a1)+
0378A  move.l d5, (a3)+
0378C  move.l d5, (a4)+
0378E  move.l d5, (a1)+
03790  move.l d5, (a3)+
03792  move.l d5, (a4)+
03794  move.l d5, (a1)+
03796  move.l d5, (a3)+
03798  move.l d5, (a4)+
0379A  move.l d5, (a1)+
0379C  move.l d5, (a3)+
0379E  move.l d5, (a4)+
037A0  move.l d5, (a1)+
037A2  move.l d5, (a3)+
037A4  move.l d5, (a4)+
037A6  move.l d5, (a1)+
037A8  move.l d5, (a3)+
037AA  move.l d5, (a4)+
037AC  move.l d5, (a1)+
037AE  swap   d2
037B0  not.w  d2
037B2  and.w  d2, (a3)+
037B4  and.w  d2, (a4)+
037B6  and.w  d2, (a1)+
037B8  dbra   d6, $34a0
037BC  bra.w  $34cc
037C0  not.w  d2
037C2  and.w  d2, (a3)+
037C4  and.w  d2, (a4)+
037C6  and.w  d2, (a1)+
037C8  move.w d5, (a3)+
037CA  move.w d5, (a4)+
037CC  move.w d5, (a1)+
037CE  move.l d5, (a3)+
037D0  move.l d5, (a4)+
037D2  move.l d5, (a1)+
037D4  move.l d5, (a3)+
037D6  move.l d5, (a4)+
037D8  move.l d5, (a1)+
037DA  move.l d5, (a3)+
037DC  move.l d5, (a4)+
037DE  move.l d5, (a1)+
037E0  move.l d5, (a3)+
037E2  move.l d5, (a4)+
037E4  move.l d5, (a1)+
037E6  move.l d5, (a3)+
037E8  move.l d5, (a4)+
037EA  move.l d5, (a1)+
037EC  move.l d5, (a3)+
037EE  move.l d5, (a4)+
037F0  move.l d5, (a1)+
037F2  move.l d5, (a3)+
037F4  move.l d5, (a4)+
037F6  move.l d5, (a1)+
037F8  swap   d2
037FA  not.w  d2
037FC  and.w  d2, (a3)+
037FE  and.w  d2, (a4)+
03800  and.w  d2, (a1)+
03802  dbra   d6, $34a0
03806  bra.w  $34cc
0380A  not.w  d2
0380C  and.w  d2, (a3)+
0380E  and.w  d2, (a4)+
03810  and.w  d2, (a1)+
03812  move.l d5, (a3)+
03814  move.l d5, (a4)+
03816  move.l d5, (a1)+
03818  move.l d5, (a3)+
0381A  move.l d5, (a4)+
0381C  move.l d5, (a1)+
0381E  move.l d5, (a3)+
03820  move.l d5, (a4)+
03822  move.l d5, (a1)+
03824  move.l d5, (a3)+
03826  move.l d5, (a4)+
03828  move.l d5, (a1)+
0382A  move.l d5, (a3)+
0382C  move.l d5, (a4)+
0382E  move.l d5, (a1)+
03830  move.l d5, (a3)+
03832  move.l d5, (a4)+
03834  move.l d5, (a1)+
03836  move.l d5, (a3)+
03838  move.l d5, (a4)+
0383A  move.l d5, (a1)+
0383C  move.l d5, (a3)+
0383E  move.l d5, (a4)+
03840  move.l d5, (a1)+
03842  swap   d2
03844  not.w  d2
03846  and.w  d2, (a3)+
03848  and.w  d2, (a4)+
0384A  and.w  d2, (a1)+
0384C  dbra   d6, $34a0
03850  bra.w  $34cc
03854  not.w  d2
03856  and.w  d2, (a3)+
03858  and.w  d2, (a4)+
0385A  and.w  d2, (a1)+
0385C  move.w d5, (a3)+
0385E  move.w d5, (a4)+
03860  move.w d5, (a1)+
03862  move.l d5, (a3)+
03864  move.l d5, (a4)+
03866  move.l d5, (a1)+
03868  move.l d5, (a3)+
0386A  move.l d5, (a4)+
0386C  move.l d5, (a1)+
0386E  move.l d5, (a3)+
03870  move.l d5, (a4)+
03872  move.l d5, (a1)+
03874  move.l d5, (a3)+
03876  move.l d5, (a4)+
03878  move.l d5, (a1)+
0387A  move.l d5, (a3)+
0387C  move.l d5, (a4)+
0387E  move.l d5, (a1)+
03880  move.l d5, (a3)+
03882  move.l d5, (a4)+
03884  move.l d5, (a1)+
03886  move.l d5, (a3)+
03888  move.l d5, (a4)+
0388A  move.l d5, (a1)+
0388C  move.l d5, (a3)+
0388E  move.l d5, (a4)+
03890  move.l d5, (a1)+
03892  swap   d2
03894  not.w  d2
03896  and.w  d2, (a3)+
03898  and.w  d2, (a4)+
0389A  and.w  d2, (a1)+
0389C  dbra   d6, $34a0
038A0  bra.w  $34cc
038A4  dbra   d6, $34a0
038A8  bra.w  $34cc
038AC  move.l d2, d3
038AE  swap   d3
038B0  and.w  d3, d2
038B2  or.w   d2, (a3)+
038B4  not.w  d2
038B6  and.w  d2, (a4)+
038B8  and.w  d2, (a1)+
038BA  dbra   d6, $34a0
038BE  bra.w  $34cc
038C2  swap   d2
038C4  or.l   d2, (a3)+
038C6  not.l  d2
038C8  and.l  d2, (a4)+
038CA  and.l  d2, (a1)+
038CC  dbra   d6, $34a0
038D0  bra.w  $34cc
038D4  or.w   d2, (a3)+
038D6  not.w  d2
038D8  and.w  d2, (a4)+
038DA  and.w  d2, (a1)+
038DC  move.w d4, (a3)+
038DE  move.w d5, (a4)+
038E0  move.w d5, (a1)+
038E2  swap   d2
038E4  or.w   d2, (a3)+
038E6  not.w  d2
038E8  and.w  d2, (a4)+
038EA  and.w  d2, (a1)+
038EC  dbra   d6, $34a0
038F0  bra.w  $34cc
038F4  or.w   d2, (a3)+
038F6  not.w  d2
038F8  and.w  d2, (a4)+
038FA  and.w  d2, (a1)+
038FC  move.l d4, (a3)+
038FE  move.l d5, (a4)+
03900  move.l d5, (a1)+
03902  swap   d2
03904  or.w   d2, (a3)+
03906  not.w  d2
03908  and.w  d2, (a4)+
0390A  and.w  d2, (a1)+
0390C  dbra   d6, $34a0
03910  bra.w  $34cc
03914  or.w   d2, (a3)+
03916  not.w  d2
03918  and.w  d2, (a4)+
0391A  and.w  d2, (a1)+
0391C  move.l d4, (a3)+
0391E  move.l d5, (a4)+
03920  move.l d5, (a1)+
03922  move.w d4, (a3)+
03924  move.w d5, (a4)+
03926  move.w d5, (a1)+
03928  swap   d2
0392A  or.w   d2, (a3)+
0392C  not.w  d2
0392E  and.w  d2, (a4)+
03930  and.w  d2, (a1)+
03932  dbra   d6, $34a0
03936  bra.w  $34cc
0393A  or.w   d2, (a3)+
0393C  not.w  d2
0393E  and.w  d2, (a4)+
03940  and.w  d2, (a1)+
03942  move.l d4, (a3)+
03944  move.l d5, (a4)+
03946  move.l d5, (a1)+
03948  move.l d4, (a3)+
0394A  move.l d5, (a4)+
0394C  move.l d5, (a1)+
0394E  swap   d2
03950  or.w   d2, (a3)+
03952  not.w  d2
03954  and.w  d2, (a4)+
03956  and.w  d2, (a1)+
03958  dbra   d6, $34a0
0395C  bra.w  $34cc
03960  or.w   d2, (a3)+
03962  not.w  d2
03964  and.w  d2, (a4)+
03966  and.w  d2, (a1)+
03968  move.w d4, (a3)+
0396A  move.w d5, (a4)+
0396C  move.w d5, (a1)+
0396E  move.l d4, (a3)+
03970  move.l d5, (a4)+
03972  move.l d5, (a1)+
03974  move.l d4, (a3)+
03976  move.l d5, (a4)+
03978  move.l d5, (a1)+
0397A  swap   d2
0397C  or.w   d2, (a3)+
0397E  not.w  d2
03980  and.w  d2, (a4)+
03982  and.w  d2, (a1)+
03984  dbra   d6, $34a0
03988  bra.w  $34cc
0398C  or.w   d2, (a3)+
0398E  not.w  d2
03990  and.w  d2, (a4)+
03992  and.w  d2, (a1)+
03994  move.l d4, (a3)+
03996  move.l d5, (a4)+
03998  move.l d5, (a1)+
0399A  move.l d4, (a3)+
0399C  move.l d5, (a4)+
0399E  move.l d5, (a1)+
039A0  move.l d4, (a3)+
039A2  move.l d5, (a4)+
039A4  move.l d5, (a1)+
039A6  swap   d2
039A8  or.w   d2, (a3)+
039AA  not.w  d2
039AC  and.w  d2, (a4)+
039AE  and.w  d2, (a1)+
039B0  dbra   d6, $34a0
039B4  bra.w  $34cc
039B8  or.w   d2, (a3)+
039BA  not.w  d2
039BC  and.w  d2, (a4)+
039BE  and.w  d2, (a1)+
039C0  move.w d4, (a3)+
039C2  move.w d5, (a4)+
039C4  move.w d5, (a1)+
039C6  move.l d4, (a3)+
039C8  move.l d5, (a4)+
039CA  move.l d5, (a1)+
039CC  move.l d4, (a3)+
039CE  move.l d5, (a4)+
039D0  move.l d5, (a1)+
039D2  move.l d4, (a3)+
039D4  move.l d5, (a4)+
039D6  move.l d5, (a1)+
039D8  swap   d2
039DA  or.w   d2, (a3)+
039DC  not.w  d2
039DE  and.w  d2, (a4)+
039E0  and.w  d2, (a1)+
039E2  dbra   d6, $34a0
039E6  bra.w  $34cc
039EA  or.w   d2, (a3)+
039EC  not.w  d2
039EE  and.w  d2, (a4)+
039F0  and.w  d2, (a1)+
039F2  move.l d4, (a3)+
039F4  move.l d5, (a4)+
039F6  move.l d5, (a1)+
039F8  move.l d4, (a3)+
039FA  move.l d5, (a4)+
039FC  move.l d5, (a1)+
039FE  move.l d4, (a3)+
03A00  move.l d5, (a4)+
03A02  move.l d5, (a1)+
03A04  move.l d4, (a3)+
03A06  move.l d5, (a4)+
03A08  move.l d5, (a1)+
03A0A  swap   d2
03A0C  or.w   d2, (a3)+
03A0E  not.w  d2
03A10  and.w  d2, (a4)+
03A12  and.w  d2, (a1)+
03A14  dbra   d6, $34a0
03A18  bra.w  $34cc
03A1C  or.w   d2, (a3)+
03A1E  not.w  d2
03A20  and.w  d2, (a4)+
03A22  and.w  d2, (a1)+
03A24  move.w d4, (a3)+
03A26  move.w d5, (a4)+
03A28  move.w d5, (a1)+
03A2A  move.l d4, (a3)+
03A2C  move.l d5, (a4)+
03A2E  move.l d5, (a1)+
03A30  move.l d4, (a3)+
03A32  move.l d5, (a4)+
03A34  move.l d5, (a1)+
03A36  move.l d4, (a3)+
03A38  move.l d5, (a4)+
03A3A  move.l d5, (a1)+
03A3C  move.l d4, (a3)+
03A3E  move.l d5, (a4)+
03A40  move.l d5, (a1)+
03A42  swap   d2
03A44  or.w   d2, (a3)+
03A46  not.w  d2
03A48  and.w  d2, (a4)+
03A4A  and.w  d2, (a1)+
03A4C  dbra   d6, $34a0
03A50  bra.w  $34cc
03A54  or.w   d2, (a3)+
03A56  not.w  d2
03A58  and.w  d2, (a4)+
03A5A  and.w  d2, (a1)+
03A5C  move.l d4, (a3)+
03A5E  move.l d5, (a4)+
03A60  move.l d5, (a1)+
03A62  move.l d4, (a3)+
03A64  move.l d5, (a4)+
03A66  move.l d5, (a1)+
03A68  move.l d4, (a3)+
03A6A  move.l d5, (a4)+
03A6C  move.l d5, (a1)+
03A6E  move.l d4, (a3)+
03A70  move.l d5, (a4)+
03A72  move.l d5, (a1)+
03A74  move.l d4, (a3)+
03A76  move.l d5, (a4)+
03A78  move.l d5, (a1)+
03A7A  swap   d2
03A7C  or.w   d2, (a3)+
03A7E  not.w  d2
03A80  and.w  d2, (a4)+
03A82  and.w  d2, (a1)+
03A84  dbra   d6, $34a0
03A88  bra.w  $34cc
03A8C  or.w   d2, (a3)+
03A8E  not.w  d2
03A90  and.w  d2, (a4)+
03A92  and.w  d2, (a1)+
03A94  move.w d4, (a3)+
03A96  move.w d5, (a4)+
03A98  move.w d5, (a1)+
03A9A  move.l d4, (a3)+
03A9C  move.l d5, (a4)+
03A9E  move.l d5, (a1)+
03AA0  move.l d4, (a3)+
03AA2  move.l d5, (a4)+
03AA4  move.l d5, (a1)+
03AA6  move.l d4, (a3)+
03AA8  move.l d5, (a4)+
03AAA  move.l d5, (a1)+
03AAC  move.l d4, (a3)+
03AAE  move.l d5, (a4)+
03AB0  move.l d5, (a1)+
03AB2  move.l d4, (a3)+
03AB4  move.l d5, (a4)+
03AB6  move.l d5, (a1)+
03AB8  swap   d2
03ABA  or.w   d2, (a3)+
03ABC  not.w  d2
03ABE  and.w  d2, (a4)+
03AC0  and.w  d2, (a1)+
03AC2  dbra   d6, $34a0
03AC6  bra.w  $34cc
03ACA  or.w   d2, (a3)+
03ACC  not.w  d2
03ACE  and.w  d2, (a4)+
03AD0  and.w  d2, (a1)+
03AD2  move.l d4, (a3)+
03AD4  move.l d5, (a4)+
03AD6  move.l d5, (a1)+
03AD8  move.l d4, (a3)+
03ADA  move.l d5, (a4)+
03ADC  move.l d5, (a1)+
03ADE  move.l d4, (a3)+
03AE0  move.l d5, (a4)+
03AE2  move.l d5, (a1)+
03AE4  move.l d4, (a3)+
03AE6  move.l d5, (a4)+
03AE8  move.l d5, (a1)+
03AEA  move.l d4, (a3)+
03AEC  move.l d5, (a4)+
03AEE  move.l d5, (a1)+
03AF0  move.l d4, (a3)+
03AF2  move.l d5, (a4)+
03AF4  move.l d5, (a1)+
03AF6  swap   d2
03AF8  or.w   d2, (a3)+
03AFA  not.w  d2
03AFC  and.w  d2, (a4)+
03AFE  and.w  d2, (a1)+
03B00  dbra   d6, $34a0
03B04  bra.w  $34cc
03B08  or.w   d2, (a3)+
03B0A  not.w  d2
03B0C  and.w  d2, (a4)+
03B0E  and.w  d2, (a1)+
03B10  move.w d4, (a3)+
03B12  move.w d5, (a4)+
03B14  move.w d5, (a1)+
03B16  move.l d4, (a3)+
03B18  move.l d5, (a4)+
03B1A  move.l d5, (a1)+
03B1C  move.l d4, (a3)+
03B1E  move.l d5, (a4)+
03B20  move.l d5, (a1)+
03B22  move.l d4, (a3)+
03B24  move.l d5, (a4)+
03B26  move.l d5, (a1)+
03B28  move.l d4, (a3)+
03B2A  move.l d5, (a4)+
03B2C  move.l d5, (a1)+
03B2E  move.l d4, (a3)+
03B30  move.l d5, (a4)+
03B32  move.l d5, (a1)+
03B34  move.l d4, (a3)+
03B36  move.l d5, (a4)+
03B38  move.l d5, (a1)+
03B3A  swap   d2
03B3C  or.w   d2, (a3)+
03B3E  not.w  d2
03B40  and.w  d2, (a4)+
03B42  and.w  d2, (a1)+
03B44  dbra   d6, $34a0
03B48  bra.w  $34cc
03B4C  or.w   d2, (a3)+
03B4E  not.w  d2
03B50  and.w  d2, (a4)+
03B52  and.w  d2, (a1)+
03B54  move.l d4, (a3)+
03B56  move.l d5, (a4)+
03B58  move.l d5, (a1)+
03B5A  move.l d4, (a3)+
03B5C  move.l d5, (a4)+
03B5E  move.l d5, (a1)+
03B60  move.l d4, (a3)+
03B62  move.l d5, (a4)+
03B64  move.l d5, (a1)+
03B66  move.l d4, (a3)+
03B68  move.l d5, (a4)+
03B6A  move.l d5, (a1)+
03B6C  move.l d4, (a3)+
03B6E  move.l d5, (a4)+
03B70  move.l d5, (a1)+
03B72  move.l d4, (a3)+
03B74  move.l d5, (a4)+
03B76  move.l d5, (a1)+
03B78  move.l d4, (a3)+
03B7A  move.l d5, (a4)+
03B7C  move.l d5, (a1)+
03B7E  swap   d2
03B80  or.w   d2, (a3)+
03B82  not.w  d2
03B84  and.w  d2, (a4)+
03B86  and.w  d2, (a1)+
03B88  dbra   d6, $34a0
03B8C  bra.w  $34cc
03B90  or.w   d2, (a3)+
03B92  not.w  d2
03B94  and.w  d2, (a4)+
03B96  and.w  d2, (a1)+
03B98  move.w d4, (a3)+
03B9A  move.w d5, (a4)+
03B9C  move.w d5, (a1)+
03B9E  move.l d4, (a3)+
03BA0  move.l d5, (a4)+
03BA2  move.l d5, (a1)+
03BA4  move.l d4, (a3)+
03BA6  move.l d5, (a4)+
03BA8  move.l d5, (a1)+
03BAA  move.l d4, (a3)+
03BAC  move.l d5, (a4)+
03BAE  move.l d5, (a1)+
03BB0  move.l d4, (a3)+
03BB2  move.l d5, (a4)+
03BB4  move.l d5, (a1)+
03BB6  move.l d4, (a3)+
03BB8  move.l d5, (a4)+
03BBA  move.l d5, (a1)+
03BBC  move.l d4, (a3)+
03BBE  move.l d5, (a4)+
03BC0  move.l d5, (a1)+
03BC2  move.l d4, (a3)+
03BC4  move.l d5, (a4)+
03BC6  move.l d5, (a1)+
03BC8  swap   d2
03BCA  or.w   d2, (a3)+
03BCC  not.w  d2
03BCE  and.w  d2, (a4)+
03BD0  and.w  d2, (a1)+
03BD2  dbra   d6, $34a0
03BD6  bra.w  $34cc
03BDA  or.w   d2, (a3)+
03BDC  not.w  d2
03BDE  and.w  d2, (a4)+
03BE0  and.w  d2, (a1)+
03BE2  move.l d4, (a3)+
03BE4  move.l d5, (a4)+
03BE6  move.l d5, (a1)+
03BE8  move.l d4, (a3)+
03BEA  move.l d5, (a4)+
03BEC  move.l d5, (a1)+
03BEE  move.l d4, (a3)+
03BF0  move.l d5, (a4)+
03BF2  move.l d5, (a1)+
03BF4  move.l d4, (a3)+
03BF6  move.l d5, (a4)+
03BF8  move.l d5, (a1)+
03BFA  move.l d4, (a3)+
03BFC  move.l d5, (a4)+
03BFE  move.l d5, (a1)+
03C00  move.l d4, (a3)+
03C02  move.l d5, (a4)+
03C04  move.l d5, (a1)+
03C06  move.l d4, (a3)+
03C08  move.l d5, (a4)+
03C0A  move.l d5, (a1)+
03C0C  move.l d4, (a3)+
03C0E  move.l d5, (a4)+
03C10  move.l d5, (a1)+
03C12  swap   d2
03C14  or.w   d2, (a3)+
03C16  not.w  d2
03C18  and.w  d2, (a4)+
03C1A  and.w  d2, (a1)+
03C1C  dbra   d6, $34a0
03C20  bra.w  $34cc
03C24  or.w   d2, (a3)+
03C26  not.w  d2
03C28  and.w  d2, (a4)+
03C2A  and.w  d2, (a1)+
03C2C  move.w d4, (a3)+
03C2E  move.w d5, (a4)+
03C30  move.w d5, (a1)+
03C32  move.l d4, (a3)+
03C34  move.l d5, (a4)+
03C36  move.l d5, (a1)+
03C38  move.l d4, (a3)+
03C3A  move.l d5, (a4)+
03C3C  move.l d5, (a1)+
03C3E  move.l d4, (a3)+
03C40  move.l d5, (a4)+
03C42  move.l d5, (a1)+
03C44  move.l d4, (a3)+
03C46  move.l d5, (a4)+
03C48  move.l d5, (a1)+
03C4A  move.l d4, (a3)+
03C4C  move.l d5, (a4)+
03C4E  move.l d5, (a1)+
03C50  move.l d4, (a3)+
03C52  move.l d5, (a4)+
03C54  move.l d5, (a1)+
03C56  move.l d4, (a3)+
03C58  move.l d5, (a4)+
03C5A  move.l d5, (a1)+
03C5C  move.l d4, (a3)+
03C5E  move.l d5, (a4)+
03C60  move.l d5, (a1)+
03C62  swap   d2
03C64  or.w   d2, (a3)+
03C66  not.w  d2
03C68  and.w  d2, (a4)+
03C6A  and.w  d2, (a1)+
03C6C  dbra   d6, $34a0
03C70  bra.w  $34cc
03C74  dbra   d6, $34a0
03C78  bra.w  $34cc
03C7C  move.l d2, d3
03C7E  swap   d3
03C80  and.w  d3, d2
03C82  or.w   d2, (a4)+
03C84  not.w  d2
03C86  and.w  d2, (a3)+
03C88  and.w  d2, (a1)+
03C8A  dbra   d6, $34a0
03C8E  bra.w  $34cc
03C92  swap   d2
03C94  or.l   d2, (a4)+
03C96  not.l  d2
03C98  and.l  d2, (a3)+
03C9A  and.l  d2, (a1)+
03C9C  dbra   d6, $34a0
03CA0  bra.w  $34cc
03CA4  or.w   d2, (a4)+
03CA6  not.w  d2
03CA8  and.w  d2, (a3)+
03CAA  and.w  d2, (a1)+
03CAC  move.w d5, (a3)+
03CAE  move.w d4, (a4)+
03CB0  move.w d5, (a1)+
03CB2  swap   d2
03CB4  or.w   d2, (a4)+
03CB6  not.w  d2
03CB8  and.w  d2, (a3)+
03CBA  and.w  d2, (a1)+
03CBC  dbra   d6, $34a0
03CC0  bra.w  $34cc
03CC4  or.w   d2, (a4)+
03CC6  not.w  d2
03CC8  and.w  d2, (a3)+
03CCA  and.w  d2, (a1)+
03CCC  move.l d5, (a3)+
03CCE  move.l d4, (a4)+
03CD0  move.l d5, (a1)+
03CD2  swap   d2
03CD4  or.w   d2, (a4)+
03CD6  not.w  d2
03CD8  and.w  d2, (a3)+
03CDA  and.w  d2, (a1)+
03CDC  dbra   d6, $34a0
03CE0  bra.w  $34cc
03CE4  or.w   d2, (a4)+
03CE6  not.w  d2
03CE8  and.w  d2, (a3)+
03CEA  and.w  d2, (a1)+
03CEC  move.l d5, (a3)+
03CEE  move.l d4, (a4)+
03CF0  move.l d5, (a1)+
03CF2  move.w d5, (a3)+
03CF4  move.w d4, (a4)+
03CF6  move.w d5, (a1)+
03CF8  swap   d2
03CFA  or.w   d2, (a4)+
03CFC  not.w  d2
03CFE  and.w  d2, (a3)+
03D00  and.w  d2, (a1)+
03D02  dbra   d6, $34a0
03D06  bra.w  $34cc
03D0A  or.w   d2, (a4)+
03D0C  not.w  d2
03D0E  and.w  d2, (a3)+
03D10  and.w  d2, (a1)+
03D12  move.l d5, (a3)+
03D14  move.l d4, (a4)+
03D16  move.l d5, (a1)+
03D18  move.l d5, (a3)+
03D1A  move.l d4, (a4)+
03D1C  move.l d5, (a1)+
03D1E  swap   d2
03D20  or.w   d2, (a4)+
03D22  not.w  d2
03D24  and.w  d2, (a3)+
03D26  and.w  d2, (a1)+
03D28  dbra   d6, $34a0
03D2C  bra.w  $34cc
03D30  or.w   d2, (a4)+
03D32  not.w  d2
03D34  and.w  d2, (a3)+
03D36  and.w  d2, (a1)+
03D38  move.w d5, (a3)+
03D3A  move.w d4, (a4)+
03D3C  move.w d5, (a1)+
03D3E  move.l d5, (a3)+
03D40  move.l d4, (a4)+
03D42  move.l d5, (a1)+
03D44  move.l d5, (a3)+
03D46  move.l d4, (a4)+
03D48  move.l d5, (a1)+
03D4A  swap   d2
03D4C  or.w   d2, (a4)+
03D4E  not.w  d2
03D50  and.w  d2, (a3)+
03D52  and.w  d2, (a1)+
03D54  dbra   d6, $34a0
03D58  bra.w  $34cc
03D5C  or.w   d2, (a4)+
03D5E  not.w  d2
03D60  and.w  d2, (a3)+
03D62  and.w  d2, (a1)+
03D64  move.l d5, (a3)+
03D66  move.l d4, (a4)+
03D68  move.l d5, (a1)+
03D6A  move.l d5, (a3)+
03D6C  move.l d4, (a4)+
03D6E  move.l d5, (a1)+
03D70  move.l d5, (a3)+
03D72  move.l d4, (a4)+
03D74  move.l d5, (a1)+
03D76  swap   d2
03D78  or.w   d2, (a4)+
03D7A  not.w  d2
03D7C  and.w  d2, (a3)+
03D7E  and.w  d2, (a1)+
03D80  dbra   d6, $34a0
03D84  bra.w  $34cc
03D88  or.w   d2, (a4)+
03D8A  not.w  d2
03D8C  and.w  d2, (a3)+
03D8E  and.w  d2, (a1)+
03D90  move.w d5, (a3)+
03D92  move.w d4, (a4)+
03D94  move.w d5, (a1)+
03D96  move.l d5, (a3)+
03D98  move.l d4, (a4)+
03D9A  move.l d5, (a1)+
03D9C  move.l d5, (a3)+
03D9E  move.l d4, (a4)+
03DA0  move.l d5, (a1)+
03DA2  move.l d5, (a3)+
03DA4  move.l d4, (a4)+
03DA6  move.l d5, (a1)+
03DA8  swap   d2
03DAA  or.w   d2, (a4)+
03DAC  not.w  d2
03DAE  and.w  d2, (a3)+
03DB0  and.w  d2, (a1)+
03DB2  dbra   d6, $34a0
03DB6  bra.w  $34cc
03DBA  or.w   d2, (a4)+
03DBC  not.w  d2
03DBE  and.w  d2, (a3)+
03DC0  and.w  d2, (a1)+
03DC2  move.l d5, (a3)+
03DC4  move.l d4, (a4)+
03DC6  move.l d5, (a1)+
03DC8  move.l d5, (a3)+
03DCA  move.l d4, (a4)+
03DCC  move.l d5, (a1)+
03DCE  move.l d5, (a3)+
03DD0  move.l d4, (a4)+
03DD2  move.l d5, (a1)+
03DD4  move.l d5, (a3)+
03DD6  move.l d4, (a4)+
03DD8  move.l d5, (a1)+
03DDA  swap   d2
03DDC  or.w   d2, (a4)+
03DDE  not.w  d2
03DE0  and.w  d2, (a3)+
03DE2  and.w  d2, (a1)+
03DE4  dbra   d6, $34a0
03DE8  bra.w  $34cc
03DEC  or.w   d2, (a4)+
03DEE  not.w  d2
03DF0  and.w  d2, (a3)+
03DF2  and.w  d2, (a1)+
03DF4  move.w d5, (a3)+
03DF6  move.w d4, (a4)+
03DF8  move.w d5, (a1)+
03DFA  move.l d5, (a3)+
03DFC  move.l d4, (a4)+
03DFE  move.l d5, (a1)+
03E00  move.l d5, (a3)+
03E02  move.l d4, (a4)+
03E04  move.l d5, (a1)+
03E06  move.l d5, (a3)+
03E08  move.l d4, (a4)+
03E0A  move.l d5, (a1)+
03E0C  move.l d5, (a3)+
03E0E  move.l d4, (a4)+
03E10  move.l d5, (a1)+
03E12  swap   d2
03E14  or.w   d2, (a4)+
03E16  not.w  d2
03E18  and.w  d2, (a3)+
03E1A  and.w  d2, (a1)+
03E1C  dbra   d6, $34a0
03E20  bra.w  $34cc
03E24  or.w   d2, (a4)+
03E26  not.w  d2
03E28  and.w  d2, (a3)+
03E2A  and.w  d2, (a1)+
03E2C  move.l d5, (a3)+
03E2E  move.l d4, (a4)+
03E30  move.l d5, (a1)+
03E32  move.l d5, (a3)+
03E34  move.l d4, (a4)+
03E36  move.l d5, (a1)+
03E38  move.l d5, (a3)+
03E3A  move.l d4, (a4)+
03E3C  move.l d5, (a1)+
03E3E  move.l d5, (a3)+
03E40  move.l d4, (a4)+
03E42  move.l d5, (a1)+
03E44  move.l d5, (a3)+
03E46  move.l d4, (a4)+
03E48  move.l d5, (a1)+
03E4A  swap   d2
03E4C  or.w   d2, (a4)+
03E4E  not.w  d2
03E50  and.w  d2, (a3)+
03E52  and.w  d2, (a1)+
03E54  dbra   d6, $34a0
03E58  bra.w  $34cc
03E5C  or.w   d2, (a4)+
03E5E  not.w  d2
03E60  and.w  d2, (a3)+
03E62  and.w  d2, (a1)+
03E64  move.w d5, (a3)+
03E66  move.w d4, (a4)+
03E68  move.w d5, (a1)+
03E6A  move.l d5, (a3)+
03E6C  move.l d4, (a4)+
03E6E  move.l d5, (a1)+
03E70  move.l d5, (a3)+
03E72  move.l d4, (a4)+
03E74  move.l d5, (a1)+
03E76  move.l d5, (a3)+
03E78  move.l d4, (a4)+
03E7A  move.l d5, (a1)+
03E7C  move.l d5, (a3)+
03E7E  move.l d4, (a4)+
03E80  move.l d5, (a1)+
03E82  move.l d5, (a3)+
03E84  move.l d4, (a4)+
03E86  move.l d5, (a1)+
03E88  swap   d2
03E8A  or.w   d2, (a4)+
03E8C  not.w  d2
03E8E  and.w  d2, (a3)+
03E90  and.w  d2, (a1)+
03E92  dbra   d6, $34a0
03E96  bra.w  $34cc
03E9A  or.w   d2, (a4)+
03E9C  not.w  d2
03E9E  and.w  d2, (a3)+
03EA0  and.w  d2, (a1)+
03EA2  move.l d5, (a3)+
03EA4  move.l d4, (a4)+
03EA6  move.l d5, (a1)+
03EA8  move.l d5, (a3)+
03EAA  move.l d4, (a4)+
03EAC  move.l d5, (a1)+
03EAE  move.l d5, (a3)+
03EB0  move.l d4, (a4)+
03EB2  move.l d5, (a1)+
03EB4  move.l d5, (a3)+
03EB6  move.l d4, (a4)+
03EB8  move.l d5, (a1)+
03EBA  move.l d5, (a3)+
03EBC  move.l d4, (a4)+
03EBE  move.l d5, (a1)+
03EC0  move.l d5, (a3)+
03EC2  move.l d4, (a4)+
03EC4  move.l d5, (a1)+
03EC6  swap   d2
03EC8  or.w   d2, (a4)+
03ECA  not.w  d2
03ECC  and.w  d2, (a3)+
03ECE  and.w  d2, (a1)+
03ED0  dbra   d6, $34a0
03ED4  bra.w  $34cc
03ED8  or.w   d2, (a4)+
03EDA  not.w  d2
03EDC  and.w  d2, (a3)+
03EDE  and.w  d2, (a1)+
03EE0  move.w d5, (a3)+
03EE2  move.w d4, (a4)+
03EE4  move.w d5, (a1)+
03EE6  move.l d5, (a3)+
03EE8  move.l d4, (a4)+
03EEA  move.l d5, (a1)+
03EEC  move.l d5, (a3)+
03EEE  move.l d4, (a4)+
03EF0  move.l d5, (a1)+
03EF2  move.l d5, (a3)+
03EF4  move.l d4, (a4)+
03EF6  move.l d5, (a1)+
03EF8  move.l d5, (a3)+
03EFA  move.l d4, (a4)+
03EFC  move.l d5, (a1)+
03EFE  move.l d5, (a3)+
03F00  move.l d4, (a4)+
03F02  move.l d5, (a1)+
03F04  move.l d5, (a3)+
03F06  move.l d4, (a4)+
03F08  move.l d5, (a1)+
03F0A  swap   d2
03F0C  or.w   d2, (a4)+
03F0E  not.w  d2
03F10  and.w  d2, (a3)+
03F12  and.w  d2, (a1)+
03F14  dbra   d6, $34a0
03F18  bra.w  $34cc
03F1C  or.w   d2, (a4)+
03F1E  not.w  d2
03F20  and.w  d2, (a3)+
03F22  and.w  d2, (a1)+
03F24  move.l d5, (a3)+
03F26  move.l d4, (a4)+
03F28  move.l d5, (a1)+
03F2A  move.l d5, (a3)+
03F2C  move.l d4, (a4)+
03F2E  move.l d5, (a1)+
03F30  move.l d5, (a3)+
03F32  move.l d4, (a4)+
03F34  move.l d5, (a1)+
03F36  move.l d5, (a3)+
03F38  move.l d4, (a4)+
03F3A  move.l d5, (a1)+
03F3C  move.l d5, (a3)+
03F3E  move.l d4, (a4)+
03F40  move.l d5, (a1)+
03F42  move.l d5, (a3)+
03F44  move.l d4, (a4)+
03F46  move.l d5, (a1)+
03F48  move.l d5, (a3)+
03F4A  move.l d4, (a4)+
03F4C  move.l d5, (a1)+
03F4E  swap   d2
03F50  or.w   d2, (a4)+
03F52  not.w  d2
03F54  and.w  d2, (a3)+
03F56  and.w  d2, (a1)+
03F58  dbra   d6, $34a0
03F5C  bra.w  $34cc
03F60  or.w   d2, (a4)+
03F62  not.w  d2
03F64  and.w  d2, (a3)+
03F66  and.w  d2, (a1)+
03F68  move.w d5, (a3)+
03F6A  move.w d4, (a4)+
03F6C  move.w d5, (a1)+
03F6E  move.l d5, (a3)+
03F70  move.l d4, (a4)+
03F72  move.l d5, (a1)+
03F74  move.l d5, (a3)+
03F76  move.l d4, (a4)+
03F78  move.l d5, (a1)+
03F7A  move.l d5, (a3)+
03F7C  move.l d4, (a4)+
03F7E  move.l d5, (a1)+
03F80  move.l d5, (a3)+
03F82  move.l d4, (a4)+
03F84  move.l d5, (a1)+
03F86  move.l d5, (a3)+
03F88  move.l d4, (a4)+
03F8A  move.l d5, (a1)+
03F8C  move.l d5, (a3)+
03F8E  move.l d4, (a4)+
03F90  move.l d5, (a1)+
03F92  move.l d5, (a3)+
03F94  move.l d4, (a4)+
03F96  move.l d5, (a1)+
03F98  swap   d2
03F9A  or.w   d2, (a4)+
03F9C  not.w  d2
03F9E  and.w  d2, (a3)+
03FA0  and.w  d2, (a1)+
03FA2  dbra   d6, $34a0
03FA6  bra.w  $34cc
03FAA  or.w   d2, (a4)+
03FAC  not.w  d2
03FAE  and.w  d2, (a3)+
03FB0  and.w  d2, (a1)+
03FB2  move.l d5, (a3)+
03FB4  move.l d4, (a4)+
03FB6  move.l d5, (a1)+
03FB8  move.l d5, (a3)+
03FBA  move.l d4, (a4)+
03FBC  move.l d5, (a1)+
03FBE  move.l d5, (a3)+
03FC0  move.l d4, (a4)+
03FC2  move.l d5, (a1)+
03FC4  move.l d5, (a3)+
03FC6  move.l d4, (a4)+
03FC8  move.l d5, (a1)+
03FCA  move.l d5, (a3)+
03FCC  move.l d4, (a4)+
03FCE  move.l d5, (a1)+
03FD0  move.l d5, (a3)+
03FD2  move.l d4, (a4)+
03FD4  move.l d5, (a1)+
03FD6  move.l d5, (a3)+
03FD8  move.l d4, (a4)+
03FDA  move.l d5, (a1)+
03FDC  move.l d5, (a3)+
03FDE  move.l d4, (a4)+
03FE0  move.l d5, (a1)+
03FE2  swap   d2
03FE4  or.w   d2, (a4)+
03FE6  not.w  d2
03FE8  and.w  d2, (a3)+
03FEA  and.w  d2, (a1)+
03FEC  dbra   d6, $34a0
03FF0  bra.w  $34cc
03FF4  or.w   d2, (a4)+
03FF6  not.w  d2
03FF8  and.w  d2, (a3)+
03FFA  and.w  d2, (a1)+
03FFC  move.w d5, (a3)+
03FFE  move.w d4, (a4)+
04000  move.w d5, (a1)+
04002  move.l d5, (a3)+
04004  move.l d4, (a4)+
04006  move.l d5, (a1)+
04008  move.l d5, (a3)+
0400A  move.l d4, (a4)+
0400C  move.l d5, (a1)+
0400E  move.l d5, (a3)+
04010  move.l d4, (a4)+
04012  move.l d5, (a1)+
04014  move.l d5, (a3)+
04016  move.l d4, (a4)+
04018  move.l d5, (a1)+
0401A  move.l d5, (a3)+
0401C  move.l d4, (a4)+
0401E  move.l d5, (a1)+
04020  move.l d5, (a3)+
04022  move.l d4, (a4)+
04024  move.l d5, (a1)+
04026  move.l d5, (a3)+
04028  move.l d4, (a4)+
0402A  move.l d5, (a1)+
0402C  move.l d5, (a3)+
0402E  move.l d4, (a4)+
04030  move.l d5, (a1)+
04032  swap   d2
04034  or.w   d2, (a4)+
04036  not.w  d2
04038  and.w  d2, (a3)+
0403A  and.w  d2, (a1)+
0403C  dbra   d6, $34a0
04040  bra.w  $34cc
04044  dbra   d6, $34a0
04048  bra.w  $34cc
0404C  move.l d2, d3
0404E  swap   d3
04050  and.w  d3, d2
04052  or.w   d2, (a3)+
04054  or.w   d2, (a4)+
04056  not.w  d2
04058  and.w  d2, (a1)+
0405A  dbra   d6, $34a0
0405E  bra.w  $34cc
04062  swap   d2
04064  or.l   d2, (a3)+
04066  or.l   d2, (a4)+
04068  not.l  d2
0406A  and.l  d2, (a1)+
0406C  dbra   d6, $34a0
04070  bra.w  $34cc
04074  or.w   d2, (a3)+
04076  or.w   d2, (a4)+
04078  not.w  d2
0407A  and.w  d2, (a1)+
0407C  move.w d4, (a3)+
0407E  move.w d4, (a4)+
04080  move.w d5, (a1)+
04082  swap   d2
04084  or.w   d2, (a3)+
04086  or.w   d2, (a4)+
04088  not.w  d2
0408A  and.w  d2, (a1)+
0408C  dbra   d6, $34a0
04090  bra.w  $34cc
04094  or.w   d2, (a3)+
04096  or.w   d2, (a4)+
04098  not.w  d2
0409A  and.w  d2, (a1)+
0409C  move.l d4, (a3)+
0409E  move.l d4, (a4)+
040A0  move.l d5, (a1)+
040A2  swap   d2
040A4  or.w   d2, (a3)+
040A6  or.w   d2, (a4)+
040A8  not.w  d2
040AA  and.w  d2, (a1)+
040AC  dbra   d6, $34a0
040B0  bra.w  $34cc
040B4  or.w   d2, (a3)+
040B6  or.w   d2, (a4)+
040B8  not.w  d2
040BA  and.w  d2, (a1)+
040BC  move.l d4, (a3)+
040BE  move.l d4, (a4)+
040C0  move.l d5, (a1)+
040C2  move.w d4, (a3)+
040C4  move.w d4, (a4)+
040C6  move.w d5, (a1)+
040C8  swap   d2
040CA  or.w   d2, (a3)+
040CC  or.w   d2, (a4)+
040CE  not.w  d2
040D0  and.w  d2, (a1)+
040D2  dbra   d6, $34a0
040D6  bra.w  $34cc
040DA  or.w   d2, (a3)+
040DC  or.w   d2, (a4)+
040DE  not.w  d2
040E0  and.w  d2, (a1)+
040E2  move.l d4, (a3)+
040E4  move.l d4, (a4)+
040E6  move.l d5, (a1)+
040E8  move.l d4, (a3)+
040EA  move.l d4, (a4)+
040EC  move.l d5, (a1)+
040EE  swap   d2
040F0  or.w   d2, (a3)+
040F2  or.w   d2, (a4)+
040F4  not.w  d2
040F6  and.w  d2, (a1)+
040F8  dbra   d6, $34a0
040FC  bra.w  $34cc
04100  or.w   d2, (a3)+
04102  or.w   d2, (a4)+
04104  not.w  d2
04106  and.w  d2, (a1)+
04108  move.w d4, (a3)+
0410A  move.w d4, (a4)+
0410C  move.w d5, (a1)+
0410E  move.l d4, (a3)+
04110  move.l d4, (a4)+
04112  move.l d5, (a1)+
04114  move.l d4, (a3)+
04116  move.l d4, (a4)+
04118  move.l d5, (a1)+
0411A  swap   d2
0411C  or.w   d2, (a3)+
0411E  or.w   d2, (a4)+
04120  not.w  d2
04122  and.w  d2, (a1)+
04124  dbra   d6, $34a0
04128  bra.w  $34cc
0412C  or.w   d2, (a3)+
0412E  or.w   d2, (a4)+
04130  not.w  d2
04132  and.w  d2, (a1)+
04134  move.l d4, (a3)+
04136  move.l d4, (a4)+
04138  move.l d5, (a1)+
0413A  move.l d4, (a3)+
0413C  move.l d4, (a4)+
0413E  move.l d5, (a1)+
04140  move.l d4, (a3)+
04142  move.l d4, (a4)+
04144  move.l d5, (a1)+
04146  swap   d2
04148  or.w   d2, (a3)+
0414A  or.w   d2, (a4)+
0414C  not.w  d2
0414E  and.w  d2, (a1)+
04150  dbra   d6, $34a0
04154  bra.w  $34cc
04158  or.w   d2, (a3)+
0415A  or.w   d2, (a4)+
0415C  not.w  d2
0415E  and.w  d2, (a1)+
04160  move.w d4, (a3)+
04162  move.w d4, (a4)+
04164  move.w d5, (a1)+
04166  move.l d4, (a3)+
04168  move.l d4, (a4)+
0416A  move.l d5, (a1)+
0416C  move.l d4, (a3)+
0416E  move.l d4, (a4)+
04170  move.l d5, (a1)+
04172  move.l d4, (a3)+
04174  move.l d4, (a4)+
04176  move.l d5, (a1)+
04178  swap   d2
0417A  or.w   d2, (a3)+
0417C  or.w   d2, (a4)+
0417E  not.w  d2
04180  and.w  d2, (a1)+
04182  dbra   d6, $34a0
04186  bra.w  $34cc
0418A  or.w   d2, (a3)+
0418C  or.w   d2, (a4)+
0418E  not.w  d2
04190  and.w  d2, (a1)+
04192  move.l d4, (a3)+
04194  move.l d4, (a4)+
04196  move.l d5, (a1)+
04198  move.l d4, (a3)+
0419A  move.l d4, (a4)+
0419C  move.l d5, (a1)+
0419E  move.l d4, (a3)+
041A0  move.l d4, (a4)+
041A2  move.l d5, (a1)+
041A4  move.l d4, (a3)+
041A6  move.l d4, (a4)+
041A8  move.l d5, (a1)+
041AA  swap   d2
041AC  or.w   d2, (a3)+
041AE  or.w   d2, (a4)+
041B0  not.w  d2
041B2  and.w  d2, (a1)+
041B4  dbra   d6, $34a0
041B8  bra.w  $34cc
041BC  or.w   d2, (a3)+
041BE  or.w   d2, (a4)+
041C0  not.w  d2
041C2  and.w  d2, (a1)+
041C4  move.w d4, (a3)+
041C6  move.w d4, (a4)+
041C8  move.w d5, (a1)+
041CA  move.l d4, (a3)+
041CC  move.l d4, (a4)+
041CE  move.l d5, (a1)+
041D0  move.l d4, (a3)+
041D2  move.l d4, (a4)+
041D4  move.l d5, (a1)+
041D6  move.l d4, (a3)+
041D8  move.l d4, (a4)+
041DA  move.l d5, (a1)+
041DC  move.l d4, (a3)+
041DE  move.l d4, (a4)+
041E0  move.l d5, (a1)+
041E2  swap   d2
041E4  or.w   d2, (a3)+
041E6  or.w   d2, (a4)+
041E8  not.w  d2
041EA  and.w  d2, (a1)+
041EC  dbra   d6, $34a0
041F0  bra.w  $34cc
041F4  or.w   d2, (a3)+
041F6  or.w   d2, (a4)+
041F8  not.w  d2
041FA  and.w  d2, (a1)+
041FC  move.l d4, (a3)+
041FE  move.l d4, (a4)+
04200  move.l d5, (a1)+
04202  move.l d4, (a3)+
04204  move.l d4, (a4)+
04206  move.l d5, (a1)+
04208  move.l d4, (a3)+
0420A  move.l d4, (a4)+
0420C  move.l d5, (a1)+
0420E  move.l d4, (a3)+
04210  move.l d4, (a4)+
04212  move.l d5, (a1)+
04214  move.l d4, (a3)+
04216  move.l d4, (a4)+
04218  move.l d5, (a1)+
0421A  swap   d2
0421C  or.w   d2, (a3)+
0421E  or.w   d2, (a4)+
04220  not.w  d2
04222  and.w  d2, (a1)+
04224  dbra   d6, $34a0
04228  bra.w  $34cc
0422C  or.w   d2, (a3)+
0422E  or.w   d2, (a4)+
04230  not.w  d2
04232  and.w  d2, (a1)+
04234  move.w d4, (a3)+
04236  move.w d4, (a4)+
04238  move.w d5, (a1)+
0423A  move.l d4, (a3)+
0423C  move.l d4, (a4)+
0423E  move.l d5, (a1)+
04240  move.l d4, (a3)+
04242  move.l d4, (a4)+
04244  move.l d5, (a1)+
04246  move.l d4, (a3)+
04248  move.l d4, (a4)+
0424A  move.l d5, (a1)+
0424C  move.l d4, (a3)+
0424E  move.l d4, (a4)+
04250  move.l d5, (a1)+
04252  move.l d4, (a3)+
04254  move.l d4, (a4)+
04256  move.l d5, (a1)+
04258  swap   d2
0425A  or.w   d2, (a3)+
0425C  or.w   d2, (a4)+
0425E  not.w  d2
04260  and.w  d2, (a1)+
04262  dbra   d6, $34a0
04266  bra.w  $34cc
0426A  or.w   d2, (a3)+
0426C  or.w   d2, (a4)+
0426E  not.w  d2
04270  and.w  d2, (a1)+
04272  move.l d4, (a3)+
04274  move.l d4, (a4)+
04276  move.l d5, (a1)+
04278  move.l d4, (a3)+
0427A  move.l d4, (a4)+
0427C  move.l d5, (a1)+
0427E  move.l d4, (a3)+
04280  move.l d4, (a4)+
04282  move.l d5, (a1)+
04284  move.l d4, (a3)+
04286  move.l d4, (a4)+
04288  move.l d5, (a1)+
0428A  move.l d4, (a3)+
0428C  move.l d4, (a4)+
0428E  move.l d5, (a1)+
04290  move.l d4, (a3)+
04292  move.l d4, (a4)+
04294  move.l d5, (a1)+
04296  swap   d2
04298  or.w   d2, (a3)+
0429A  or.w   d2, (a4)+
0429C  not.w  d2
0429E  and.w  d2, (a1)+
042A0  dbra   d6, $34a0
042A4  bra.w  $34cc
042A8  or.w   d2, (a3)+
042AA  or.w   d2, (a4)+
042AC  not.w  d2
042AE  and.w  d2, (a1)+
042B0  move.w d4, (a3)+
042B2  move.w d4, (a4)+
042B4  move.w d5, (a1)+
042B6  move.l d4, (a3)+
042B8  move.l d4, (a4)+
042BA  move.l d5, (a1)+
042BC  move.l d4, (a3)+
042BE  move.l d4, (a4)+
042C0  move.l d5, (a1)+
042C2  move.l d4, (a3)+
042C4  move.l d4, (a4)+
042C6  move.l d5, (a1)+
042C8  move.l d4, (a3)+
042CA  move.l d4, (a4)+
042CC  move.l d5, (a1)+
042CE  move.l d4, (a3)+
042D0  move.l d4, (a4)+
042D2  move.l d5, (a1)+
042D4  move.l d4, (a3)+
042D6  move.l d4, (a4)+
042D8  move.l d5, (a1)+
042DA  swap   d2
042DC  or.w   d2, (a3)+
042DE  or.w   d2, (a4)+
042E0  not.w  d2
042E2  and.w  d2, (a1)+
042E4  dbra   d6, $34a0
042E8  bra.w  $34cc
042EC  or.w   d2, (a3)+
042EE  or.w   d2, (a4)+
042F0  not.w  d2
042F2  and.w  d2, (a1)+
042F4  move.l d4, (a3)+
042F6  move.l d4, (a4)+
042F8  move.l d5, (a1)+
042FA  move.l d4, (a3)+
042FC  move.l d4, (a4)+
042FE  move.l d5, (a1)+
04300  move.l d4, (a3)+
04302  move.l d4, (a4)+
04304  move.l d5, (a1)+
04306  move.l d4, (a3)+
04308  move.l d4, (a4)+
0430A  move.l d5, (a1)+
0430C  move.l d4, (a3)+
0430E  move.l d4, (a4)+
04310  move.l d5, (a1)+
04312  move.l d4, (a3)+
04314  move.l d4, (a4)+
04316  move.l d5, (a1)+
04318  move.l d4, (a3)+
0431A  move.l d4, (a4)+
0431C  move.l d5, (a1)+
0431E  swap   d2
04320  or.w   d2, (a3)+
04322  or.w   d2, (a4)+
04324  not.w  d2
04326  and.w  d2, (a1)+
04328  dbra   d6, $34a0
0432C  bra.w  $34cc
04330  or.w   d2, (a3)+
04332  or.w   d2, (a4)+
04334  not.w  d2
04336  and.w  d2, (a1)+
04338  move.w d4, (a3)+
0433A  move.w d4, (a4)+
0433C  move.w d5, (a1)+
0433E  move.l d4, (a3)+
04340  move.l d4, (a4)+
04342  move.l d5, (a1)+
04344  move.l d4, (a3)+
04346  move.l d4, (a4)+
04348  move.l d5, (a1)+
0434A  move.l d4, (a3)+
0434C  move.l d4, (a4)+
0434E  move.l d5, (a1)+
04350  move.l d4, (a3)+
04352  move.l d4, (a4)+
04354  move.l d5, (a1)+
04356  move.l d4, (a3)+
04358  move.l d4, (a4)+
0435A  move.l d5, (a1)+
0435C  move.l d4, (a3)+
0435E  move.l d4, (a4)+
04360  move.l d5, (a1)+
04362  move.l d4, (a3)+
04364  move.l d4, (a4)+
04366  move.l d5, (a1)+
04368  swap   d2
0436A  or.w   d2, (a3)+
0436C  or.w   d2, (a4)+
0436E  not.w  d2
04370  and.w  d2, (a1)+
04372  dbra   d6, $34a0
04376  bra.w  $34cc
0437A  or.w   d2, (a3)+
0437C  or.w   d2, (a4)+
0437E  not.w  d2
04380  and.w  d2, (a1)+
04382  move.l d4, (a3)+
04384  move.l d4, (a4)+
04386  move.l d5, (a1)+
04388  move.l d4, (a3)+
0438A  move.l d4, (a4)+
0438C  move.l d5, (a1)+
0438E  move.l d4, (a3)+
04390  move.l d4, (a4)+
04392  move.l d5, (a1)+
04394  move.l d4, (a3)+
04396  move.l d4, (a4)+
04398  move.l d5, (a1)+
0439A  move.l d4, (a3)+
0439C  move.l d4, (a4)+
0439E  move.l d5, (a1)+
043A0  move.l d4, (a3)+
043A2  move.l d4, (a4)+
043A4  move.l d5, (a1)+
043A6  move.l d4, (a3)+
043A8  move.l d4, (a4)+
043AA  move.l d5, (a1)+
043AC  move.l d4, (a3)+
043AE  move.l d4, (a4)+
043B0  move.l d5, (a1)+
043B2  swap   d2
043B4  or.w   d2, (a3)+
043B6  or.w   d2, (a4)+
043B8  not.w  d2
043BA  and.w  d2, (a1)+
043BC  dbra   d6, $34a0
043C0  bra.w  $34cc
043C4  or.w   d2, (a3)+
043C6  or.w   d2, (a4)+
043C8  not.w  d2
043CA  and.w  d2, (a1)+
043CC  move.w d4, (a3)+
043CE  move.w d4, (a4)+
043D0  move.w d5, (a1)+
043D2  move.l d4, (a3)+
043D4  move.l d4, (a4)+
043D6  move.l d5, (a1)+
043D8  move.l d4, (a3)+
043DA  move.l d4, (a4)+
043DC  move.l d5, (a1)+
043DE  move.l d4, (a3)+
043E0  move.l d4, (a4)+
043E2  move.l d5, (a1)+
043E4  move.l d4, (a3)+
043E6  move.l d4, (a4)+
043E8  move.l d5, (a1)+
043EA  move.l d4, (a3)+
043EC  move.l d4, (a4)+
043EE  move.l d5, (a1)+
043F0  move.l d4, (a3)+
043F2  move.l d4, (a4)+
043F4  move.l d5, (a1)+
043F6  move.l d4, (a3)+
043F8  move.l d4, (a4)+
043FA  move.l d5, (a1)+
043FC  move.l d4, (a3)+
043FE  move.l d4, (a4)+
04400  move.l d5, (a1)+
04402  swap   d2
04404  or.w   d2, (a3)+
04406  or.w   d2, (a4)+
04408  not.w  d2
0440A  and.w  d2, (a1)+
0440C  dbra   d6, $34a0
04410  bra.w  $34cc
04414  dbra   d6, $34a0
04418  bra.w  $34cc
0441C  move.l d2, d3
0441E  swap   d3
04420  and.w  d3, d2
04422  or.w   d2, (a1)+
04424  not.w  d2
04426  and.w  d2, (a3)+
04428  and.w  d2, (a4)+
0442A  dbra   d6, $34a0
0442E  bra.w  $34cc
04432  swap   d2
04434  or.l   d2, (a1)+
04436  not.l  d2
04438  and.l  d2, (a3)+
0443A  and.l  d2, (a4)+
0443C  dbra   d6, $34a0
04440  bra.w  $34cc
04444  or.w   d2, (a1)+
04446  not.w  d2
04448  and.w  d2, (a3)+
0444A  and.w  d2, (a4)+
0444C  move.w d5, (a3)+
0444E  move.w d5, (a4)+
04450  move.w d4, (a1)+
04452  swap   d2
04454  or.w   d2, (a1)+
04456  not.w  d2
04458  and.w  d2, (a3)+
0445A  and.w  d2, (a4)+
0445C  dbra   d6, $34a0
04460  bra.w  $34cc
04464  or.w   d2, (a1)+
04466  not.w  d2
04468  and.w  d2, (a3)+
0446A  and.w  d2, (a4)+
0446C  move.l d5, (a3)+
0446E  move.l d5, (a4)+
04470  move.l d4, (a1)+
04472  swap   d2
04474  or.w   d2, (a1)+
04476  not.w  d2
04478  and.w  d2, (a3)+
0447A  and.w  d2, (a4)+
0447C  dbra   d6, $34a0
04480  bra.w  $34cc
04484  or.w   d2, (a1)+
04486  not.w  d2
04488  and.w  d2, (a3)+
0448A  and.w  d2, (a4)+
0448C  move.l d5, (a3)+
0448E  move.l d5, (a4)+
04490  move.l d4, (a1)+
04492  move.w d5, (a3)+
04494  move.w d5, (a4)+
04496  move.w d4, (a1)+
04498  swap   d2
0449A  or.w   d2, (a1)+
0449C  not.w  d2
0449E  and.w  d2, (a3)+
044A0  and.w  d2, (a4)+
044A2  dbra   d6, $34a0
044A6  bra.w  $34cc
044AA  or.w   d2, (a1)+
044AC  not.w  d2
044AE  and.w  d2, (a3)+
044B0  and.w  d2, (a4)+
044B2  move.l d5, (a3)+
044B4  move.l d5, (a4)+
044B6  move.l d4, (a1)+
044B8  move.l d5, (a3)+
044BA  move.l d5, (a4)+
044BC  move.l d4, (a1)+
044BE  swap   d2
044C0  or.w   d2, (a1)+
044C2  not.w  d2
044C4  and.w  d2, (a3)+
044C6  and.w  d2, (a4)+
044C8  dbra   d6, $34a0
044CC  bra.w  $34cc
044D0  or.w   d2, (a1)+
044D2  not.w  d2
044D4  and.w  d2, (a3)+
044D6  and.w  d2, (a4)+
044D8  move.w d5, (a3)+
044DA  move.w d5, (a4)+
044DC  move.w d4, (a1)+
044DE  move.l d5, (a3)+
044E0  move.l d5, (a4)+
044E2  move.l d4, (a1)+
044E4  move.l d5, (a3)+
044E6  move.l d5, (a4)+
044E8  move.l d4, (a1)+
044EA  swap   d2
044EC  or.w   d2, (a1)+
044EE  not.w  d2
044F0  and.w  d2, (a3)+
044F2  and.w  d2, (a4)+
044F4  dbra   d6, $34a0
044F8  bra.w  $34cc
044FC  or.w   d2, (a1)+
044FE  not.w  d2
04500  and.w  d2, (a3)+
04502  and.w  d2, (a4)+
04504  move.l d5, (a3)+
04506  move.l d5, (a4)+
04508  move.l d4, (a1)+
0450A  move.l d5, (a3)+
0450C  move.l d5, (a4)+
0450E  move.l d4, (a1)+
04510  move.l d5, (a3)+
04512  move.l d5, (a4)+
04514  move.l d4, (a1)+
04516  swap   d2
04518  or.w   d2, (a1)+
0451A  not.w  d2
0451C  and.w  d2, (a3)+
0451E  and.w  d2, (a4)+
04520  dbra   d6, $34a0
04524  bra.w  $34cc
04528  or.w   d2, (a1)+
0452A  not.w  d2
0452C  and.w  d2, (a3)+
0452E  and.w  d2, (a4)+
04530  move.w d5, (a3)+
04532  move.w d5, (a4)+
04534  move.w d4, (a1)+
04536  move.l d5, (a3)+
04538  move.l d5, (a4)+
0453A  move.l d4, (a1)+
0453C  move.l d5, (a3)+
0453E  move.l d5, (a4)+
04540  move.l d4, (a1)+
04542  move.l d5, (a3)+
04544  move.l d5, (a4)+
04546  move.l d4, (a1)+
04548  swap   d2
0454A  or.w   d2, (a1)+
0454C  not.w  d2
0454E  and.w  d2, (a3)+
04550  and.w  d2, (a4)+
04552  dbra   d6, $34a0
04556  bra.w  $34cc
0455A  or.w   d2, (a1)+
0455C  not.w  d2
0455E  and.w  d2, (a3)+
04560  and.w  d2, (a4)+
04562  move.l d5, (a3)+
04564  move.l d5, (a4)+
04566  move.l d4, (a1)+
04568  move.l d5, (a3)+
0456A  move.l d5, (a4)+
0456C  move.l d4, (a1)+
0456E  move.l d5, (a3)+
04570  move.l d5, (a4)+
04572  move.l d4, (a1)+
04574  move.l d5, (a3)+
04576  move.l d5, (a4)+
04578  move.l d4, (a1)+
0457A  swap   d2
0457C  or.w   d2, (a1)+
0457E  not.w  d2
04580  and.w  d2, (a3)+
04582  and.w  d2, (a4)+
04584  dbra   d6, $34a0
04588  bra.w  $34cc
0458C  or.w   d2, (a1)+
0458E  not.w  d2
04590  and.w  d2, (a3)+
04592  and.w  d2, (a4)+
04594  move.w d5, (a3)+
04596  move.w d5, (a4)+
04598  move.w d4, (a1)+
0459A  move.l d5, (a3)+
0459C  move.l d5, (a4)+
0459E  move.l d4, (a1)+
045A0  move.l d5, (a3)+
045A2  move.l d5, (a4)+
045A4  move.l d4, (a1)+
045A6  move.l d5, (a3)+
045A8  move.l d5, (a4)+
045AA  move.l d4, (a1)+
045AC  move.l d5, (a3)+
045AE  move.l d5, (a4)+
045B0  move.l d4, (a1)+
045B2  swap   d2
045B4  or.w   d2, (a1)+
045B6  not.w  d2
045B8  and.w  d2, (a3)+
045BA  and.w  d2, (a4)+
045BC  dbra   d6, $34a0
045C0  bra.w  $34cc
045C4  or.w   d2, (a1)+
045C6  not.w  d2
045C8  and.w  d2, (a3)+
045CA  and.w  d2, (a4)+
045CC  move.l d5, (a3)+
045CE  move.l d5, (a4)+
045D0  move.l d4, (a1)+
045D2  move.l d5, (a3)+
045D4  move.l d5, (a4)+
045D6  move.l d4, (a1)+
045D8  move.l d5, (a3)+
045DA  move.l d5, (a4)+
045DC  move.l d4, (a1)+
045DE  move.l d5, (a3)+
045E0  move.l d5, (a4)+
045E2  move.l d4, (a1)+
045E4  move.l d5, (a3)+
045E6  move.l d5, (a4)+
045E8  move.l d4, (a1)+
045EA  swap   d2
045EC  or.w   d2, (a1)+
045EE  not.w  d2
045F0  and.w  d2, (a3)+
045F2  and.w  d2, (a4)+
045F4  dbra   d6, $34a0
045F8  bra.w  $34cc
045FC  or.w   d2, (a1)+
045FE  not.w  d2
04600  and.w  d2, (a3)+
04602  and.w  d2, (a4)+
04604  move.w d5, (a3)+
04606  move.w d5, (a4)+
04608  move.w d4, (a1)+
0460A  move.l d5, (a3)+
0460C  move.l d5, (a4)+
0460E  move.l d4, (a1)+
04610  move.l d5, (a3)+
04612  move.l d5, (a4)+
04614  move.l d4, (a1)+
04616  move.l d5, (a3)+
04618  move.l d5, (a4)+
0461A  move.l d4, (a1)+
0461C  move.l d5, (a3)+
0461E  move.l d5, (a4)+
04620  move.l d4, (a1)+
04622  move.l d5, (a3)+
04624  move.l d5, (a4)+
04626  move.l d4, (a1)+
04628  swap   d2
0462A  or.w   d2, (a1)+
0462C  not.w  d2
0462E  and.w  d2, (a3)+
04630  and.w  d2, (a4)+
04632  dbra   d6, $34a0
04636  bra.w  $34cc
0463A  or.w   d2, (a1)+
0463C  not.w  d2
0463E  and.w  d2, (a3)+
04640  and.w  d2, (a4)+
04642  move.l d5, (a3)+
04644  move.l d5, (a4)+
04646  move.l d4, (a1)+
04648  move.l d5, (a3)+
0464A  move.l d5, (a4)+
0464C  move.l d4, (a1)+
0464E  move.l d5, (a3)+
04650  move.l d5, (a4)+
04652  move.l d4, (a1)+
04654  move.l d5, (a3)+
04656  move.l d5, (a4)+
04658  move.l d4, (a1)+
0465A  move.l d5, (a3)+
0465C  move.l d5, (a4)+
0465E  move.l d4, (a1)+
04660  move.l d5, (a3)+
04662  move.l d5, (a4)+
04664  move.l d4, (a1)+
04666  swap   d2
04668  or.w   d2, (a1)+
0466A  not.w  d2
0466C  and.w  d2, (a3)+
0466E  and.w  d2, (a4)+
04670  dbra   d6, $34a0
04674  bra.w  $34cc
04678  or.w   d2, (a1)+
0467A  not.w  d2
0467C  and.w  d2, (a3)+
0467E  and.w  d2, (a4)+
04680  move.w d5, (a3)+
04682  move.w d5, (a4)+
04684  move.w d4, (a1)+
04686  move.l d5, (a3)+
04688  move.l d5, (a4)+
0468A  move.l d4, (a1)+
0468C  move.l d5, (a3)+
0468E  move.l d5, (a4)+
04690  move.l d4, (a1)+
04692  move.l d5, (a3)+
04694  move.l d5, (a4)+
04696  move.l d4, (a1)+
04698  move.l d5, (a3)+
0469A  move.l d5, (a4)+
0469C  move.l d4, (a1)+
0469E  move.l d5, (a3)+
046A0  move.l d5, (a4)+
046A2  move.l d4, (a1)+
046A4  move.l d5, (a3)+
046A6  move.l d5, (a4)+
046A8  move.l d4, (a1)+
046AA  swap   d2
046AC  or.w   d2, (a1)+
046AE  not.w  d2
046B0  and.w  d2, (a3)+
046B2  and.w  d2, (a4)+
046B4  dbra   d6, $34a0
046B8  bra.w  $34cc
046BC  or.w   d2, (a1)+
046BE  not.w  d2
046C0  and.w  d2, (a3)+
046C2  and.w  d2, (a4)+
046C4  move.l d5, (a3)+
046C6  move.l d5, (a4)+
046C8  move.l d4, (a1)+
046CA  move.l d5, (a3)+
046CC  move.l d5, (a4)+
046CE  move.l d4, (a1)+
046D0  move.l d5, (a3)+
046D2  move.l d5, (a4)+
046D4  move.l d4, (a1)+
046D6  move.l d5, (a3)+
046D8  move.l d5, (a4)+
046DA  move.l d4, (a1)+
046DC  move.l d5, (a3)+
046DE  move.l d5, (a4)+
046E0  move.l d4, (a1)+
046E2  move.l d5, (a3)+
046E4  move.l d5, (a4)+
046E6  move.l d4, (a1)+
046E8  move.l d5, (a3)+
046EA  move.l d5, (a4)+
046EC  move.l d4, (a1)+
046EE  swap   d2
046F0  or.w   d2, (a1)+
046F2  not.w  d2
046F4  and.w  d2, (a3)+
046F6  and.w  d2, (a4)+
046F8  dbra   d6, $34a0
046FC  bra.w  $34cc
04700  or.w   d2, (a1)+
04702  not.w  d2
04704  and.w  d2, (a3)+
04706  and.w  d2, (a4)+
04708  move.w d5, (a3)+
0470A  move.w d5, (a4)+
0470C  move.w d4, (a1)+
0470E  move.l d5, (a3)+
04710  move.l d5, (a4)+
04712  move.l d4, (a1)+
04714  move.l d5, (a3)+
04716  move.l d5, (a4)+
04718  move.l d4, (a1)+
0471A  move.l d5, (a3)+
0471C  move.l d5, (a4)+
0471E  move.l d4, (a1)+
04720  move.l d5, (a3)+
04722  move.l d5, (a4)+
04724  move.l d4, (a1)+
04726  move.l d5, (a3)+
04728  move.l d5, (a4)+
0472A  move.l d4, (a1)+
0472C  move.l d5, (a3)+
0472E  move.l d5, (a4)+
04730  move.l d4, (a1)+
04732  move.l d5, (a3)+
04734  move.l d5, (a4)+
04736  move.l d4, (a1)+
04738  swap   d2
0473A  or.w   d2, (a1)+
0473C  not.w  d2
0473E  and.w  d2, (a3)+
04740  and.w  d2, (a4)+
04742  dbra   d6, $34a0
04746  bra.w  $34cc
0474A  or.w   d2, (a1)+
0474C  not.w  d2
0474E  and.w  d2, (a3)+
04750  and.w  d2, (a4)+
04752  move.l d5, (a3)+
04754  move.l d5, (a4)+
04756  move.l d4, (a1)+
04758  move.l d5, (a3)+
0475A  move.l d5, (a4)+
0475C  move.l d4, (a1)+
0475E  move.l d5, (a3)+
04760  move.l d5, (a4)+
04762  move.l d4, (a1)+
04764  move.l d5, (a3)+
04766  move.l d5, (a4)+
04768  move.l d4, (a1)+
0476A  move.l d5, (a3)+
0476C  move.l d5, (a4)+
0476E  move.l d4, (a1)+
04770  move.l d5, (a3)+
04772  move.l d5, (a4)+
04774  move.l d4, (a1)+
04776  move.l d5, (a3)+
04778  move.l d5, (a4)+
0477A  move.l d4, (a1)+
0477C  move.l d5, (a3)+
0477E  move.l d5, (a4)+
04780  move.l d4, (a1)+
04782  swap   d2
04784  or.w   d2, (a1)+
04786  not.w  d2
04788  and.w  d2, (a3)+
0478A  and.w  d2, (a4)+
0478C  dbra   d6, $34a0
04790  bra.w  $34cc
04794  or.w   d2, (a1)+
04796  not.w  d2
04798  and.w  d2, (a3)+
0479A  and.w  d2, (a4)+
0479C  move.w d5, (a3)+
0479E  move.w d5, (a4)+
047A0  move.w d4, (a1)+
047A2  move.l d5, (a3)+
047A4  move.l d5, (a4)+
047A6  move.l d4, (a1)+
047A8  move.l d5, (a3)+
047AA  move.l d5, (a4)+
047AC  move.l d4, (a1)+
047AE  move.l d5, (a3)+
047B0  move.l d5, (a4)+
047B2  move.l d4, (a1)+
047B4  move.l d5, (a3)+
047B6  move.l d5, (a4)+
047B8  move.l d4, (a1)+
047BA  move.l d5, (a3)+
047BC  move.l d5, (a4)+
047BE  move.l d4, (a1)+
047C0  move.l d5, (a3)+
047C2  move.l d5, (a4)+
047C4  move.l d4, (a1)+
047C6  move.l d5, (a3)+
047C8  move.l d5, (a4)+
047CA  move.l d4, (a1)+
047CC  move.l d5, (a3)+
047CE  move.l d5, (a4)+
047D0  move.l d4, (a1)+
047D2  swap   d2
047D4  or.w   d2, (a1)+
047D6  not.w  d2
047D8  and.w  d2, (a3)+
047DA  and.w  d2, (a4)+
047DC  dbra   d6, $34a0
047E0  bra.w  $34cc
047E4  dbra   d6, $34a0
047E8  bra.w  $34cc
047EC  move.l d2, d3
047EE  swap   d3
047F0  and.w  d3, d2
047F2  or.w   d2, (a3)+
047F4  or.w   d2, (a1)+
047F6  not.w  d2
047F8  and.w  d2, (a4)+
047FA  dbra   d6, $34a0
047FE  bra.w  $34cc
04802  swap   d2
04804  or.l   d2, (a3)+
04806  or.l   d2, (a1)+
04808  not.l  d2
0480A  and.l  d2, (a4)+
0480C  dbra   d6, $34a0
04810  bra.w  $34cc
04814  or.w   d2, (a3)+
04816  or.w   d2, (a1)+
04818  not.w  d2
0481A  and.w  d2, (a4)+
0481C  move.w d4, (a3)+
0481E  move.w d5, (a4)+
04820  move.w d4, (a1)+
04822  swap   d2
04824  or.w   d2, (a3)+
04826  or.w   d2, (a1)+
04828  not.w  d2
0482A  and.w  d2, (a4)+
0482C  dbra   d6, $34a0
04830  bra.w  $34cc
04834  or.w   d2, (a3)+
04836  or.w   d2, (a1)+
04838  not.w  d2
0483A  and.w  d2, (a4)+
0483C  move.l d4, (a3)+
0483E  move.l d5, (a4)+
04840  move.l d4, (a1)+
04842  swap   d2
04844  or.w   d2, (a3)+
04846  or.w   d2, (a1)+
04848  not.w  d2
0484A  and.w  d2, (a4)+
0484C  dbra   d6, $34a0
04850  bra.w  $34cc
04854  or.w   d2, (a3)+
04856  or.w   d2, (a1)+
04858  not.w  d2
0485A  and.w  d2, (a4)+
0485C  move.l d4, (a3)+
0485E  move.l d5, (a4)+
04860  move.l d4, (a1)+
04862  move.w d4, (a3)+
04864  move.w d5, (a4)+
04866  move.w d4, (a1)+
04868  swap   d2
0486A  or.w   d2, (a3)+
0486C  or.w   d2, (a1)+
0486E  not.w  d2
04870  and.w  d2, (a4)+
04872  dbra   d6, $34a0
04876  bra.w  $34cc
0487A  or.w   d2, (a3)+
0487C  or.w   d2, (a1)+
0487E  not.w  d2
04880  and.w  d2, (a4)+
04882  move.l d4, (a3)+
04884  move.l d5, (a4)+
04886  move.l d4, (a1)+
04888  move.l d4, (a3)+
0488A  move.l d5, (a4)+
0488C  move.l d4, (a1)+
0488E  swap   d2
04890  or.w   d2, (a3)+
04892  or.w   d2, (a1)+
04894  not.w  d2
04896  and.w  d2, (a4)+
04898  dbra   d6, $34a0
0489C  bra.w  $34cc
048A0  or.w   d2, (a3)+
048A2  or.w   d2, (a1)+
048A4  not.w  d2
048A6  and.w  d2, (a4)+
048A8  move.w d4, (a3)+
048AA  move.w d5, (a4)+
048AC  move.w d4, (a1)+
048AE  move.l d4, (a3)+
048B0  move.l d5, (a4)+
048B2  move.l d4, (a1)+
048B4  move.l d4, (a3)+
048B6  move.l d5, (a4)+
048B8  move.l d4, (a1)+
048BA  swap   d2
048BC  or.w   d2, (a3)+
048BE  or.w   d2, (a1)+
048C0  not.w  d2
048C2  and.w  d2, (a4)+
048C4  dbra   d6, $34a0
048C8  bra.w  $34cc
048CC  or.w   d2, (a3)+
048CE  or.w   d2, (a1)+
048D0  not.w  d2
048D2  and.w  d2, (a4)+
048D4  move.l d4, (a3)+
048D6  move.l d5, (a4)+
048D8  move.l d4, (a1)+
048DA  move.l d4, (a3)+
048DC  move.l d5, (a4)+
048DE  move.l d4, (a1)+
048E0  move.l d4, (a3)+
048E2  move.l d5, (a4)+
048E4  move.l d4, (a1)+
048E6  swap   d2
048E8  or.w   d2, (a3)+
048EA  or.w   d2, (a1)+
048EC  not.w  d2
048EE  and.w  d2, (a4)+
048F0  dbra   d6, $34a0
048F4  bra.w  $34cc
048F8  or.w   d2, (a3)+
048FA  or.w   d2, (a1)+
048FC  not.w  d2
048FE  and.w  d2, (a4)+
04900  move.w d4, (a3)+
04902  move.w d5, (a4)+
04904  move.w d4, (a1)+
04906  move.l d4, (a3)+
04908  move.l d5, (a4)+
0490A  move.l d4, (a1)+
0490C  move.l d4, (a3)+
0490E  move.l d5, (a4)+
04910  move.l d4, (a1)+
04912  move.l d4, (a3)+
04914  move.l d5, (a4)+
04916  move.l d4, (a1)+
04918  swap   d2
0491A  or.w   d2, (a3)+
0491C  or.w   d2, (a1)+
0491E  not.w  d2
04920  and.w  d2, (a4)+
04922  dbra   d6, $34a0
04926  bra.w  $34cc
0492A  or.w   d2, (a3)+
0492C  or.w   d2, (a1)+
0492E  not.w  d2
04930  and.w  d2, (a4)+
04932  move.l d4, (a3)+
04934  move.l d5, (a4)+
04936  move.l d4, (a1)+
04938  move.l d4, (a3)+
0493A  move.l d5, (a4)+
0493C  move.l d4, (a1)+
0493E  move.l d4, (a3)+
04940  move.l d5, (a4)+
04942  move.l d4, (a1)+
04944  move.l d4, (a3)+
04946  move.l d5, (a4)+
04948  move.l d4, (a1)+
0494A  swap   d2
0494C  or.w   d2, (a3)+
0494E  or.w   d2, (a1)+
04950  not.w  d2
04952  and.w  d2, (a4)+
04954  dbra   d6, $34a0
04958  bra.w  $34cc
0495C  or.w   d2, (a3)+
0495E  or.w   d2, (a1)+
04960  not.w  d2
04962  and.w  d2, (a4)+
04964  move.w d4, (a3)+
04966  move.w d5, (a4)+
04968  move.w d4, (a1)+
0496A  move.l d4, (a3)+
0496C  move.l d5, (a4)+
0496E  move.l d4, (a1)+
04970  move.l d4, (a3)+
04972  move.l d5, (a4)+
04974  move.l d4, (a1)+
04976  move.l d4, (a3)+
04978  move.l d5, (a4)+
0497A  move.l d4, (a1)+
0497C  move.l d4, (a3)+
0497E  move.l d5, (a4)+
04980  move.l d4, (a1)+
04982  swap   d2
04984  or.w   d2, (a3)+
04986  or.w   d2, (a1)+
04988  not.w  d2
0498A  and.w  d2, (a4)+
0498C  dbra   d6, $34a0
04990  bra.w  $34cc
04994  or.w   d2, (a3)+
04996  or.w   d2, (a1)+
04998  not.w  d2
0499A  and.w  d2, (a4)+
0499C  move.l d4, (a3)+
0499E  move.l d5, (a4)+
049A0  move.l d4, (a1)+
049A2  move.l d4, (a3)+
049A4  move.l d5, (a4)+
049A6  move.l d4, (a1)+
049A8  move.l d4, (a3)+
049AA  move.l d5, (a4)+
049AC  move.l d4, (a1)+
049AE  move.l d4, (a3)+
049B0  move.l d5, (a4)+
049B2  move.l d4, (a1)+
049B4  move.l d4, (a3)+
049B6  move.l d5, (a4)+
049B8  move.l d4, (a1)+
049BA  swap   d2
049BC  or.w   d2, (a3)+
049BE  or.w   d2, (a1)+
049C0  not.w  d2
049C2  and.w  d2, (a4)+
049C4  dbra   d6, $34a0
049C8  bra.w  $34cc
049CC  or.w   d2, (a3)+
049CE  or.w   d2, (a1)+
049D0  not.w  d2
049D2  and.w  d2, (a4)+
049D4  move.w d4, (a3)+
049D6  move.w d5, (a4)+
049D8  move.w d4, (a1)+
049DA  move.l d4, (a3)+
049DC  move.l d5, (a4)+
049DE  move.l d4, (a1)+
049E0  move.l d4, (a3)+
049E2  move.l d5, (a4)+
049E4  move.l d4, (a1)+
049E6  move.l d4, (a3)+
049E8  move.l d5, (a4)+
049EA  move.l d4, (a1)+
049EC  move.l d4, (a3)+
049EE  move.l d5, (a4)+
049F0  move.l d4, (a1)+
049F2  move.l d4, (a3)+
049F4  move.l d5, (a4)+
049F6  move.l d4, (a1)+
049F8  swap   d2
049FA  or.w   d2, (a3)+
049FC  or.w   d2, (a1)+
049FE  not.w  d2
04A00  and.w  d2, (a4)+
04A02  dbra   d6, $34a0
04A06  bra.w  $34cc
04A0A  or.w   d2, (a3)+
04A0C  or.w   d2, (a1)+
04A0E  not.w  d2
04A10  and.w  d2, (a4)+
04A12  move.l d4, (a3)+
04A14  move.l d5, (a4)+
04A16  move.l d4, (a1)+
04A18  move.l d4, (a3)+
04A1A  move.l d5, (a4)+
04A1C  move.l d4, (a1)+
04A1E  move.l d4, (a3)+
04A20  move.l d5, (a4)+
04A22  move.l d4, (a1)+
04A24  move.l d4, (a3)+
04A26  move.l d5, (a4)+
04A28  move.l d4, (a1)+
04A2A  move.l d4, (a3)+
04A2C  move.l d5, (a4)+
04A2E  move.l d4, (a1)+
04A30  move.l d4, (a3)+
04A32  move.l d5, (a4)+
04A34  move.l d4, (a1)+
04A36  swap   d2
04A38  or.w   d2, (a3)+
04A3A  or.w   d2, (a1)+
04A3C  not.w  d2
04A3E  and.w  d2, (a4)+
04A40  dbra   d6, $34a0
04A44  bra.w  $34cc
04A48  or.w   d2, (a3)+
04A4A  or.w   d2, (a1)+
04A4C  not.w  d2
04A4E  and.w  d2, (a4)+
04A50  move.w d4, (a3)+
04A52  move.w d5, (a4)+
04A54  move.w d4, (a1)+
04A56  move.l d4, (a3)+
04A58  move.l d5, (a4)+
04A5A  move.l d4, (a1)+
04A5C  move.l d4, (a3)+
04A5E  move.l d5, (a4)+
04A60  move.l d4, (a1)+
04A62  move.l d4, (a3)+
04A64  move.l d5, (a4)+
04A66  move.l d4, (a1)+
04A68  move.l d4, (a3)+
04A6A  move.l d5, (a4)+
04A6C  move.l d4, (a1)+
04A6E  move.l d4, (a3)+
04A70  move.l d5, (a4)+
04A72  move.l d4, (a1)+
04A74  move.l d4, (a3)+
04A76  move.l d5, (a4)+
04A78  move.l d4, (a1)+
04A7A  swap   d2
04A7C  or.w   d2, (a3)+
04A7E  or.w   d2, (a1)+
04A80  not.w  d2
04A82  and.w  d2, (a4)+
04A84  dbra   d6, $34a0
04A88  bra.w  $34cc
04A8C  or.w   d2, (a3)+
04A8E  or.w   d2, (a1)+
04A90  not.w  d2
04A92  and.w  d2, (a4)+
04A94  move.l d4, (a3)+
04A96  move.l d5, (a4)+
04A98  move.l d4, (a1)+
04A9A  move.l d4, (a3)+
04A9C  move.l d5, (a4)+
04A9E  move.l d4, (a1)+
04AA0  move.l d4, (a3)+
04AA2  move.l d5, (a4)+
04AA4  move.l d4, (a1)+
04AA6  move.l d4, (a3)+
04AA8  move.l d5, (a4)+
04AAA  move.l d4, (a1)+
04AAC  move.l d4, (a3)+
04AAE  move.l d5, (a4)+
04AB0  move.l d4, (a1)+
04AB2  move.l d4, (a3)+
04AB4  move.l d5, (a4)+
04AB6  move.l d4, (a1)+
04AB8  move.l d4, (a3)+
04ABA  move.l d5, (a4)+
04ABC  move.l d4, (a1)+
04ABE  swap   d2
04AC0  or.w   d2, (a3)+
04AC2  or.w   d2, (a1)+
04AC4  not.w  d2
04AC6  and.w  d2, (a4)+
04AC8  dbra   d6, $34a0
04ACC  bra.w  $34cc
04AD0  or.w   d2, (a3)+
04AD2  or.w   d2, (a1)+
04AD4  not.w  d2
04AD6  and.w  d2, (a4)+
04AD8  move.w d4, (a3)+
04ADA  move.w d5, (a4)+
04ADC  move.w d4, (a1)+
04ADE  move.l d4, (a3)+
04AE0  move.l d5, (a4)+
04AE2  move.l d4, (a1)+
04AE4  move.l d4, (a3)+
04AE6  move.l d5, (a4)+
04AE8  move.l d4, (a1)+
04AEA  move.l d4, (a3)+
04AEC  move.l d5, (a4)+
04AEE  move.l d4, (a1)+
04AF0  move.l d4, (a3)+
04AF2  move.l d5, (a4)+
04AF4  move.l d4, (a1)+
04AF6  move.l d4, (a3)+
04AF8  move.l d5, (a4)+
04AFA  move.l d4, (a1)+
04AFC  move.l d4, (a3)+
04AFE  move.l d5, (a4)+
04B00  move.l d4, (a1)+
04B02  move.l d4, (a3)+
04B04  move.l d5, (a4)+
04B06  move.l d4, (a1)+
04B08  swap   d2
04B0A  or.w   d2, (a3)+
04B0C  or.w   d2, (a1)+
04B0E  not.w  d2
04B10  and.w  d2, (a4)+
04B12  dbra   d6, $34a0
04B16  bra.w  $34cc
04B1A  or.w   d2, (a3)+
04B1C  or.w   d2, (a1)+
04B1E  not.w  d2
04B20  and.w  d2, (a4)+
04B22  move.l d4, (a3)+
04B24  move.l d5, (a4)+
04B26  move.l d4, (a1)+
04B28  move.l d4, (a3)+
04B2A  move.l d5, (a4)+
04B2C  move.l d4, (a1)+
04B2E  move.l d4, (a3)+
04B30  move.l d5, (a4)+
04B32  move.l d4, (a1)+
04B34  move.l d4, (a3)+
04B36  move.l d5, (a4)+
04B38  move.l d4, (a1)+
04B3A  move.l d4, (a3)+
04B3C  move.l d5, (a4)+
04B3E  move.l d4, (a1)+
04B40  move.l d4, (a3)+
04B42  move.l d5, (a4)+
04B44  move.l d4, (a1)+
04B46  move.l d4, (a3)+
04B48  move.l d5, (a4)+
04B4A  move.l d4, (a1)+
04B4C  move.l d4, (a3)+
04B4E  move.l d5, (a4)+
04B50  move.l d4, (a1)+
04B52  swap   d2
04B54  or.w   d2, (a3)+
04B56  or.w   d2, (a1)+
04B58  not.w  d2
04B5A  and.w  d2, (a4)+
04B5C  dbra   d6, $34a0
04B60  bra.w  $34cc
04B64  or.w   d2, (a3)+
04B66  or.w   d2, (a1)+
04B68  not.w  d2
04B6A  and.w  d2, (a4)+
04B6C  move.w d4, (a3)+
04B6E  move.w d5, (a4)+
04B70  move.w d4, (a1)+
04B72  move.l d4, (a3)+
04B74  move.l d5, (a4)+
04B76  move.l d4, (a1)+
04B78  move.l d4, (a3)+
04B7A  move.l d5, (a4)+
04B7C  move.l d4, (a1)+
04B7E  move.l d4, (a3)+
04B80  move.l d5, (a4)+
04B82  move.l d4, (a1)+
04B84  move.l d4, (a3)+
04B86  move.l d5, (a4)+
04B88  move.l d4, (a1)+
04B8A  move.l d4, (a3)+
04B8C  move.l d5, (a4)+
04B8E  move.l d4, (a1)+
04B90  move.l d4, (a3)+
04B92  move.l d5, (a4)+
04B94  move.l d4, (a1)+
04B96  move.l d4, (a3)+
04B98  move.l d5, (a4)+
04B9A  move.l d4, (a1)+
04B9C  move.l d4, (a3)+
04B9E  move.l d5, (a4)+
04BA0  move.l d4, (a1)+
04BA2  swap   d2
04BA4  or.w   d2, (a3)+
04BA6  or.w   d2, (a1)+
04BA8  not.w  d2
04BAA  and.w  d2, (a4)+
04BAC  dbra   d6, $34a0
04BB0  bra.w  $34cc
04BB4  dbra   d6, $34a0
04BB8  bra.w  $34cc
04BBC  move.l d2, d3
04BBE  swap   d3
04BC0  and.w  d3, d2
04BC2  or.w   d2, (a4)+
04BC4  or.w   d2, (a1)+
04BC6  not.w  d2
04BC8  and.w  d2, (a3)+
04BCA  dbra   d6, $34a0
04BCE  bra.w  $34cc
04BD2  swap   d2
04BD4  or.l   d2, (a4)+
04BD6  or.l   d2, (a1)+
04BD8  not.l  d2
04BDA  and.l  d2, (a3)+
04BDC  dbra   d6, $34a0
04BE0  bra.w  $34cc
04BE4  or.w   d2, (a4)+
04BE6  or.w   d2, (a1)+
04BE8  not.w  d2
04BEA  and.w  d2, (a3)+
04BEC  move.w d5, (a3)+
04BEE  move.w d4, (a4)+
04BF0  move.w d4, (a1)+
04BF2  swap   d2
04BF4  or.w   d2, (a4)+
04BF6  or.w   d2, (a1)+
04BF8  not.w  d2
04BFA  and.w  d2, (a3)+
04BFC  dbra   d6, $34a0
04C00  bra.w  $34cc
04C04  or.w   d2, (a4)+
04C06  or.w   d2, (a1)+
04C08  not.w  d2
04C0A  and.w  d2, (a3)+
04C0C  move.l d5, (a3)+
04C0E  move.l d4, (a4)+
04C10  move.l d4, (a1)+
04C12  swap   d2
04C14  or.w   d2, (a4)+
04C16  or.w   d2, (a1)+
04C18  not.w  d2
04C1A  and.w  d2, (a3)+
04C1C  dbra   d6, $34a0
04C20  bra.w  $34cc
04C24  or.w   d2, (a4)+
04C26  or.w   d2, (a1)+
04C28  not.w  d2
04C2A  and.w  d2, (a3)+
04C2C  move.l d5, (a3)+
04C2E  move.l d4, (a4)+
04C30  move.l d4, (a1)+
04C32  move.w d5, (a3)+
04C34  move.w d4, (a4)+
04C36  move.w d4, (a1)+
04C38  swap   d2
04C3A  or.w   d2, (a4)+
04C3C  or.w   d2, (a1)+
04C3E  not.w  d2
04C40  and.w  d2, (a3)+
04C42  dbra   d6, $34a0
04C46  bra.w  $34cc
04C4A  or.w   d2, (a4)+
04C4C  or.w   d2, (a1)+
04C4E  not.w  d2
04C50  and.w  d2, (a3)+
04C52  move.l d5, (a3)+
04C54  move.l d4, (a4)+
04C56  move.l d4, (a1)+
04C58  move.l d5, (a3)+
04C5A  move.l d4, (a4)+
04C5C  move.l d4, (a1)+
04C5E  swap   d2
04C60  or.w   d2, (a4)+
04C62  or.w   d2, (a1)+
04C64  not.w  d2
04C66  and.w  d2, (a3)+
04C68  dbra   d6, $34a0
04C6C  bra.w  $34cc
04C70  or.w   d2, (a4)+
04C72  or.w   d2, (a1)+
04C74  not.w  d2
04C76  and.w  d2, (a3)+
04C78  move.w d5, (a3)+
04C7A  move.w d4, (a4)+
04C7C  move.w d4, (a1)+
04C7E  move.l d5, (a3)+
04C80  move.l d4, (a4)+
04C82  move.l d4, (a1)+
04C84  move.l d5, (a3)+
04C86  move.l d4, (a4)+
04C88  move.l d4, (a1)+
04C8A  swap   d2
04C8C  or.w   d2, (a4)+
04C8E  or.w   d2, (a1)+
04C90  not.w  d2
04C92  and.w  d2, (a3)+
04C94  dbra   d6, $34a0
04C98  bra.w  $34cc
04C9C  or.w   d2, (a4)+
04C9E  or.w   d2, (a1)+
04CA0  not.w  d2
04CA2  and.w  d2, (a3)+
04CA4  move.l d5, (a3)+
04CA6  move.l d4, (a4)+
04CA8  move.l d4, (a1)+
04CAA  move.l d5, (a3)+
04CAC  move.l d4, (a4)+
04CAE  move.l d4, (a1)+
04CB0  move.l d5, (a3)+
04CB2  move.l d4, (a4)+
04CB4  move.l d4, (a1)+
04CB6  swap   d2
04CB8  or.w   d2, (a4)+
04CBA  or.w   d2, (a1)+
04CBC  not.w  d2
04CBE  and.w  d2, (a3)+
04CC0  dbra   d6, $34a0
04CC4  bra.w  $34cc
04CC8  or.w   d2, (a4)+
04CCA  or.w   d2, (a1)+
04CCC  not.w  d2
04CCE  and.w  d2, (a3)+
04CD0  move.w d5, (a3)+
04CD2  move.w d4, (a4)+
04CD4  move.w d4, (a1)+
04CD6  move.l d5, (a3)+
04CD8  move.l d4, (a4)+
04CDA  move.l d4, (a1)+
04CDC  move.l d5, (a3)+
04CDE  move.l d4, (a4)+
04CE0  move.l d4, (a1)+
04CE2  move.l d5, (a3)+
04CE4  move.l d4, (a4)+
04CE6  move.l d4, (a1)+
04CE8  swap   d2
04CEA  or.w   d2, (a4)+
04CEC  or.w   d2, (a1)+
04CEE  not.w  d2
04CF0  and.w  d2, (a3)+
04CF2  dbra   d6, $34a0
04CF6  bra.w  $34cc
04CFA  or.w   d2, (a4)+
04CFC  or.w   d2, (a1)+
04CFE  not.w  d2
04D00  and.w  d2, (a3)+
04D02  move.l d5, (a3)+
04D04  move.l d4, (a4)+
04D06  move.l d4, (a1)+
04D08  move.l d5, (a3)+
04D0A  move.l d4, (a4)+
04D0C  move.l d4, (a1)+
04D0E  move.l d5, (a3)+
04D10  move.l d4, (a4)+
04D12  move.l d4, (a1)+
04D14  move.l d5, (a3)+
04D16  move.l d4, (a4)+
04D18  move.l d4, (a1)+
04D1A  swap   d2
04D1C  or.w   d2, (a4)+
04D1E  or.w   d2, (a1)+
04D20  not.w  d2
04D22  and.w  d2, (a3)+
04D24  dbra   d6, $34a0
04D28  bra.w  $34cc
04D2C  or.w   d2, (a4)+
04D2E  or.w   d2, (a1)+
04D30  not.w  d2
04D32  and.w  d2, (a3)+
04D34  move.w d5, (a3)+
04D36  move.w d4, (a4)+
04D38  move.w d4, (a1)+
04D3A  move.l d5, (a3)+
04D3C  move.l d4, (a4)+
04D3E  move.l d4, (a1)+
04D40  move.l d5, (a3)+
04D42  move.l d4, (a4)+
04D44  move.l d4, (a1)+
04D46  move.l d5, (a3)+
04D48  move.l d4, (a4)+
04D4A  move.l d4, (a1)+
04D4C  move.l d5, (a3)+
04D4E  move.l d4, (a4)+
04D50  move.l d4, (a1)+
04D52  swap   d2
04D54  or.w   d2, (a4)+
04D56  or.w   d2, (a1)+
04D58  not.w  d2
04D5A  and.w  d2, (a3)+
04D5C  dbra   d6, $34a0
04D60  bra.w  $34cc
04D64  or.w   d2, (a4)+
04D66  or.w   d2, (a1)+
04D68  not.w  d2
04D6A  and.w  d2, (a3)+
04D6C  move.l d5, (a3)+
04D6E  move.l d4, (a4)+
04D70  move.l d4, (a1)+
04D72  move.l d5, (a3)+
04D74  move.l d4, (a4)+
04D76  move.l d4, (a1)+
04D78  move.l d5, (a3)+
04D7A  move.l d4, (a4)+
04D7C  move.l d4, (a1)+
04D7E  move.l d5, (a3)+
04D80  move.l d4, (a4)+
04D82  move.l d4, (a1)+
04D84  move.l d5, (a3)+
04D86  move.l d4, (a4)+
04D88  move.l d4, (a1)+
04D8A  swap   d2
04D8C  or.w   d2, (a4)+
04D8E  or.w   d2, (a1)+
04D90  not.w  d2
04D92  and.w  d2, (a3)+
04D94  dbra   d6, $34a0
04D98  bra.w  $34cc
04D9C  or.w   d2, (a4)+
04D9E  or.w   d2, (a1)+
04DA0  not.w  d2
04DA2  and.w  d2, (a3)+
04DA4  move.w d5, (a3)+
04DA6  move.w d4, (a4)+
04DA8  move.w d4, (a1)+
04DAA  move.l d5, (a3)+
04DAC  move.l d4, (a4)+
04DAE  move.l d4, (a1)+
04DB0  move.l d5, (a3)+
04DB2  move.l d4, (a4)+
04DB4  move.l d4, (a1)+
04DB6  move.l d5, (a3)+
04DB8  move.l d4, (a4)+
04DBA  move.l d4, (a1)+
04DBC  move.l d5, (a3)+
04DBE  move.l d4, (a4)+
04DC0  move.l d4, (a1)+
04DC2  move.l d5, (a3)+
04DC4  move.l d4, (a4)+
04DC6  move.l d4, (a1)+
04DC8  swap   d2
04DCA  or.w   d2, (a4)+
04DCC  or.w   d2, (a1)+
04DCE  not.w  d2
04DD0  and.w  d2, (a3)+
04DD2  dbra   d6, $34a0
04DD6  bra.w  $34cc
04DDA  or.w   d2, (a4)+
04DDC  or.w   d2, (a1)+
04DDE  not.w  d2
04DE0  and.w  d2, (a3)+
04DE2  move.l d5, (a3)+
04DE4  move.l d4, (a4)+
04DE6  move.l d4, (a1)+
04DE8  move.l d5, (a3)+
04DEA  move.l d4, (a4)+
04DEC  move.l d4, (a1)+
04DEE  move.l d5, (a3)+
04DF0  move.l d4, (a4)+
04DF2  move.l d4, (a1)+
04DF4  move.l d5, (a3)+
04DF6  move.l d4, (a4)+
04DF8  move.l d4, (a1)+
04DFA  move.l d5, (a3)+
04DFC  move.l d4, (a4)+
04DFE  move.l d4, (a1)+
04E00  move.l d5, (a3)+
04E02  move.l d4, (a4)+
04E04  move.l d4, (a1)+
04E06  swap   d2
04E08  or.w   d2, (a4)+
04E0A  or.w   d2, (a1)+
04E0C  not.w  d2
04E0E  and.w  d2, (a3)+
04E10  dbra   d6, $34a0
04E14  bra.w  $34cc
04E18  or.w   d2, (a4)+
04E1A  or.w   d2, (a1)+
04E1C  not.w  d2
04E1E  and.w  d2, (a3)+
04E20  move.w d5, (a3)+
04E22  move.w d4, (a4)+
04E24  move.w d4, (a1)+
04E26  move.l d5, (a3)+
04E28  move.l d4, (a4)+
04E2A  move.l d4, (a1)+
04E2C  move.l d5, (a3)+
04E2E  move.l d4, (a4)+
04E30  move.l d4, (a1)+
04E32  move.l d5, (a3)+
04E34  move.l d4, (a4)+
04E36  move.l d4, (a1)+
04E38  move.l d5, (a3)+
04E3A  move.l d4, (a4)+
04E3C  move.l d4, (a1)+
04E3E  move.l d5, (a3)+
04E40  move.l d4, (a4)+
04E42  move.l d4, (a1)+
04E44  move.l d5, (a3)+
04E46  move.l d4, (a4)+
04E48  move.l d4, (a1)+
04E4A  swap   d2
04E4C  or.w   d2, (a4)+
04E4E  or.w   d2, (a1)+
04E50  not.w  d2
04E52  and.w  d2, (a3)+
04E54  dbra   d6, $34a0
04E58  bra.w  $34cc
04E5C  or.w   d2, (a4)+
04E5E  or.w   d2, (a1)+
04E60  not.w  d2
04E62  and.w  d2, (a3)+
04E64  move.l d5, (a3)+
04E66  move.l d4, (a4)+
04E68  move.l d4, (a1)+
04E6A  move.l d5, (a3)+
04E6C  move.l d4, (a4)+
04E6E  move.l d4, (a1)+
04E70  move.l d5, (a3)+
04E72  move.l d4, (a4)+
04E74  move.l d4, (a1)+
04E76  move.l d5, (a3)+
04E78  move.l d4, (a4)+
04E7A  move.l d4, (a1)+
04E7C  move.l d5, (a3)+
04E7E  move.l d4, (a4)+
04E80  move.l d4, (a1)+
04E82  move.l d5, (a3)+
04E84  move.l d4, (a4)+
04E86  move.l d4, (a1)+
04E88  move.l d5, (a3)+
04E8A  move.l d4, (a4)+
04E8C  move.l d4, (a1)+
04E8E  swap   d2
04E90  or.w   d2, (a4)+
04E92  or.w   d2, (a1)+
04E94  not.w  d2
04E96  and.w  d2, (a3)+
04E98  dbra   d6, $34a0
04E9C  bra.w  $34cc
04EA0  or.w   d2, (a4)+
04EA2  or.w   d2, (a1)+
04EA4  not.w  d2
04EA6  and.w  d2, (a3)+
04EA8  move.w d5, (a3)+
04EAA  move.w d4, (a4)+
04EAC  move.w d4, (a1)+
04EAE  move.l d5, (a3)+
04EB0  move.l d4, (a4)+
04EB2  move.l d4, (a1)+
04EB4  move.l d5, (a3)+
04EB6  move.l d4, (a4)+
04EB8  move.l d4, (a1)+
04EBA  move.l d5, (a3)+
04EBC  move.l d4, (a4)+
04EBE  move.l d4, (a1)+
04EC0  move.l d5, (a3)+
04EC2  move.l d4, (a4)+
04EC4  move.l d4, (a1)+
04EC6  move.l d5, (a3)+
04EC8  move.l d4, (a4)+
04ECA  move.l d4, (a1)+
04ECC  move.l d5, (a3)+
04ECE  move.l d4, (a4)+
04ED0  move.l d4, (a1)+
04ED2  move.l d5, (a3)+
04ED4  move.l d4, (a4)+
04ED6  move.l d4, (a1)+
04ED8  swap   d2
04EDA  or.w   d2, (a4)+
04EDC  or.w   d2, (a1)+
04EDE  not.w  d2
04EE0  and.w  d2, (a3)+
04EE2  dbra   d6, $34a0
04EE6  bra.w  $34cc
04EEA  or.w   d2, (a4)+
04EEC  or.w   d2, (a1)+
04EEE  not.w  d2
04EF0  and.w  d2, (a3)+
04EF2  move.l d5, (a3)+
04EF4  move.l d4, (a4)+
04EF6  move.l d4, (a1)+
04EF8  move.l d5, (a3)+
04EFA  move.l d4, (a4)+
04EFC  move.l d4, (a1)+
04EFE  move.l d5, (a3)+
04F00  move.l d4, (a4)+
04F02  move.l d4, (a1)+
04F04  move.l d5, (a3)+
04F06  move.l d4, (a4)+
04F08  move.l d4, (a1)+
04F0A  move.l d5, (a3)+
04F0C  move.l d4, (a4)+
04F0E  move.l d4, (a1)+
04F10  move.l d5, (a3)+
04F12  move.l d4, (a4)+
04F14  move.l d4, (a1)+
04F16  move.l d5, (a3)+
04F18  move.l d4, (a4)+
04F1A  move.l d4, (a1)+
04F1C  move.l d5, (a3)+
04F1E  move.l d4, (a4)+
04F20  move.l d4, (a1)+
04F22  swap   d2
04F24  or.w   d2, (a4)+
04F26  or.w   d2, (a1)+
04F28  not.w  d2
04F2A  and.w  d2, (a3)+
04F2C  dbra   d6, $34a0
04F30  bra.w  $34cc
04F34  or.w   d2, (a4)+
04F36  or.w   d2, (a1)+
04F38  not.w  d2
04F3A  and.w  d2, (a3)+
04F3C  move.w d5, (a3)+
04F3E  move.w d4, (a4)+
04F40  move.w d4, (a1)+
04F42  move.l d5, (a3)+
04F44  move.l d4, (a4)+
04F46  move.l d4, (a1)+
04F48  move.l d5, (a3)+
04F4A  move.l d4, (a4)+
04F4C  move.l d4, (a1)+
04F4E  move.l d5, (a3)+
04F50  move.l d4, (a4)+
04F52  move.l d4, (a1)+
04F54  move.l d5, (a3)+
04F56  move.l d4, (a4)+
04F58  move.l d4, (a1)+
04F5A  move.l d5, (a3)+
04F5C  move.l d4, (a4)+
04F5E  move.l d4, (a1)+
04F60  move.l d5, (a3)+
04F62  move.l d4, (a4)+
04F64  move.l d4, (a1)+
04F66  move.l d5, (a3)+
04F68  move.l d4, (a4)+
04F6A  move.l d4, (a1)+
04F6C  move.l d5, (a3)+
04F6E  move.l d4, (a4)+
04F70  move.l d4, (a1)+
04F72  swap   d2
04F74  or.w   d2, (a4)+
04F76  or.w   d2, (a1)+
04F78  not.w  d2
04F7A  and.w  d2, (a3)+
04F7C  dbra   d6, $34a0
04F80  bra.w  $34cc
04F84  dbra   d6, $34a0
04F88  bra.w  $34cc
04F8C  move.l d2, d3
04F8E  swap   d3
04F90  and.w  d3, d2
04F92  or.w   d2, (a3)+
04F94  or.w   d2, (a4)+
04F96  or.w   d2, (a1)+
04F98  not.w  d2
04F9A  dbra   d6, $34a0
04F9E  bra.w  $34cc
04FA2  swap   d2
04FA4  or.l   d2, (a3)+
04FA6  or.l   d2, (a4)+
04FA8  or.l   d2, (a1)+
04FAA  not.l  d2
04FAC  dbra   d6, $34a0
04FB0  bra.w  $34cc
04FB4  or.w   d2, (a3)+
04FB6  or.w   d2, (a4)+
04FB8  or.w   d2, (a1)+
04FBA  not.w  d2
04FBC  move.w d4, (a3)+
04FBE  move.w d4, (a4)+
04FC0  move.w d4, (a1)+
04FC2  swap   d2
04FC4  or.w   d2, (a3)+
04FC6  or.w   d2, (a4)+
04FC8  or.w   d2, (a1)+
04FCA  not.w  d2
04FCC  dbra   d6, $34a0
04FD0  bra.w  $34cc
04FD4  or.w   d2, (a3)+
04FD6  or.w   d2, (a4)+
04FD8  or.w   d2, (a1)+
04FDA  not.w  d2
04FDC  move.l d4, (a3)+
04FDE  move.l d4, (a4)+
04FE0  move.l d4, (a1)+
04FE2  swap   d2
04FE4  or.w   d2, (a3)+
04FE6  or.w   d2, (a4)+
04FE8  or.w   d2, (a1)+
04FEA  not.w  d2
04FEC  dbra   d6, $34a0
04FF0  bra.w  $34cc
04FF4  or.w   d2, (a3)+
04FF6  or.w   d2, (a4)+
04FF8  or.w   d2, (a1)+
04FFA  not.w  d2
04FFC  move.l d4, (a3)+
04FFE  move.l d4, (a4)+
05000  move.l d4, (a1)+
05002  move.w d4, (a3)+
05004  move.w d4, (a4)+
05006  move.w d4, (a1)+
05008  swap   d2
0500A  or.w   d2, (a3)+
0500C  or.w   d2, (a4)+
0500E  or.w   d2, (a1)+
05010  not.w  d2
05012  dbra   d6, $34a0
05016  bra.w  $34cc
0501A  or.w   d2, (a3)+
0501C  or.w   d2, (a4)+
0501E  or.w   d2, (a1)+
05020  not.w  d2
05022  move.l d4, (a3)+
05024  move.l d4, (a4)+
05026  move.l d4, (a1)+
05028  move.l d4, (a3)+
0502A  move.l d4, (a4)+
0502C  move.l d4, (a1)+
0502E  swap   d2
05030  or.w   d2, (a3)+
05032  or.w   d2, (a4)+
05034  or.w   d2, (a1)+
05036  not.w  d2
05038  dbra   d6, $34a0
0503C  bra.w  $34cc
05040  or.w   d2, (a3)+
05042  or.w   d2, (a4)+
05044  or.w   d2, (a1)+
05046  not.w  d2
05048  move.w d4, (a3)+
0504A  move.w d4, (a4)+
0504C  move.w d4, (a1)+
0504E  move.l d4, (a3)+
05050  move.l d4, (a4)+
05052  move.l d4, (a1)+
05054  move.l d4, (a3)+
05056  move.l d4, (a4)+
05058  move.l d4, (a1)+
0505A  swap   d2
0505C  or.w   d2, (a3)+
0505E  or.w   d2, (a4)+
05060  or.w   d2, (a1)+
05062  not.w  d2
05064  dbra   d6, $34a0
05068  bra.w  $34cc
0506C  or.w   d2, (a3)+
0506E  or.w   d2, (a4)+
05070  or.w   d2, (a1)+
05072  not.w  d2
05074  move.l d4, (a3)+
05076  move.l d4, (a4)+
05078  move.l d4, (a1)+
0507A  move.l d4, (a3)+
0507C  move.l d4, (a4)+
0507E  move.l d4, (a1)+
05080  move.l d4, (a3)+
05082  move.l d4, (a4)+
05084  move.l d4, (a1)+
05086  swap   d2
05088  or.w   d2, (a3)+
0508A  or.w   d2, (a4)+
0508C  or.w   d2, (a1)+
0508E  not.w  d2
05090  dbra   d6, $34a0
05094  bra.w  $34cc
05098  or.w   d2, (a3)+
0509A  or.w   d2, (a4)+
0509C  or.w   d2, (a1)+
0509E  not.w  d2
050A0  move.w d4, (a3)+
050A2  move.w d4, (a4)+
050A4  move.w d4, (a1)+
050A6  move.l d4, (a3)+
050A8  move.l d4, (a4)+
050AA  move.l d4, (a1)+
050AC  move.l d4, (a3)+
050AE  move.l d4, (a4)+
050B0  move.l d4, (a1)+
050B2  move.l d4, (a3)+
050B4  move.l d4, (a4)+
050B6  move.l d4, (a1)+
050B8  swap   d2
050BA  or.w   d2, (a3)+
050BC  or.w   d2, (a4)+
050BE  or.w   d2, (a1)+
050C0  not.w  d2
050C2  dbra   d6, $34a0
050C6  bra.w  $34cc
050CA  or.w   d2, (a3)+
050CC  or.w   d2, (a4)+
050CE  or.w   d2, (a1)+
050D0  not.w  d2
050D2  move.l d4, (a3)+
050D4  move.l d4, (a4)+
050D6  move.l d4, (a1)+
050D8  move.l d4, (a3)+
050DA  move.l d4, (a4)+
050DC  move.l d4, (a1)+
050DE  move.l d4, (a3)+
050E0  move.l d4, (a4)+
050E2  move.l d4, (a1)+
050E4  move.l d4, (a3)+
050E6  move.l d4, (a4)+
050E8  move.l d4, (a1)+
050EA  swap   d2
050EC  or.w   d2, (a3)+
050EE  or.w   d2, (a4)+
050F0  or.w   d2, (a1)+
050F2  not.w  d2
050F4  dbra   d6, $34a0
050F8  bra.w  $34cc
050FC  or.w   d2, (a3)+
050FE  or.w   d2, (a4)+
05100  or.w   d2, (a1)+
05102  not.w  d2
05104  move.w d4, (a3)+
05106  move.w d4, (a4)+
05108  move.w d4, (a1)+
0510A  move.l d4, (a3)+
0510C  move.l d4, (a4)+
0510E  move.l d4, (a1)+
05110  move.l d4, (a3)+
05112  move.l d4, (a4)+
05114  move.l d4, (a1)+
05116  move.l d4, (a3)+
05118  move.l d4, (a4)+
0511A  move.l d4, (a1)+
0511C  move.l d4, (a3)+
0511E  move.l d4, (a4)+
05120  move.l d4, (a1)+
05122  swap   d2
05124  or.w   d2, (a3)+
05126  or.w   d2, (a4)+
05128  or.w   d2, (a1)+
0512A  not.w  d2
0512C  dbra   d6, $34a0
05130  bra.w  $34cc
05134  or.w   d2, (a3)+
05136  or.w   d2, (a4)+
05138  or.w   d2, (a1)+
0513A  not.w  d2
0513C  move.l d4, (a3)+
0513E  move.l d4, (a4)+
05140  move.l d4, (a1)+
05142  move.l d4, (a3)+
05144  move.l d4, (a4)+
05146  move.l d4, (a1)+
05148  move.l d4, (a3)+
0514A  move.l d4, (a4)+
0514C  move.l d4, (a1)+
0514E  move.l d4, (a3)+
05150  move.l d4, (a4)+
05152  move.l d4, (a1)+
05154  move.l d4, (a3)+
05156  move.l d4, (a4)+
05158  move.l d4, (a1)+
0515A  swap   d2
0515C  or.w   d2, (a3)+
0515E  or.w   d2, (a4)+
05160  or.w   d2, (a1)+
05162  not.w  d2
05164  dbra   d6, $34a0
05168  bra.w  $34cc
0516C  or.w   d2, (a3)+
0516E  or.w   d2, (a4)+
05170  or.w   d2, (a1)+
05172  not.w  d2
05174  move.w d4, (a3)+
05176  move.w d4, (a4)+
05178  move.w d4, (a1)+
0517A  move.l d4, (a3)+
0517C  move.l d4, (a4)+
0517E  move.l d4, (a1)+
05180  move.l d4, (a3)+
05182  move.l d4, (a4)+
05184  move.l d4, (a1)+
05186  move.l d4, (a3)+
05188  move.l d4, (a4)+
0518A  move.l d4, (a1)+
0518C  move.l d4, (a3)+
0518E  move.l d4, (a4)+
05190  move.l d4, (a1)+
05192  move.l d4, (a3)+
05194  move.l d4, (a4)+
05196  move.l d4, (a1)+
05198  swap   d2
0519A  or.w   d2, (a3)+
0519C  or.w   d2, (a4)+
0519E  or.w   d2, (a1)+
051A0  not.w  d2
051A2  dbra   d6, $34a0
051A6  bra.w  $34cc
051AA  or.w   d2, (a3)+
051AC  or.w   d2, (a4)+
051AE  or.w   d2, (a1)+
051B0  not.w  d2
051B2  move.l d4, (a3)+
051B4  move.l d4, (a4)+
051B6  move.l d4, (a1)+
051B8  move.l d4, (a3)+
051BA  move.l d4, (a4)+
051BC  move.l d4, (a1)+
051BE  move.l d4, (a3)+
051C0  move.l d4, (a4)+
051C2  move.l d4, (a1)+
051C4  move.l d4, (a3)+
051C6  move.l d4, (a4)+
051C8  move.l d4, (a1)+
051CA  move.l d4, (a3)+
051CC  move.l d4, (a4)+
051CE  move.l d4, (a1)+
051D0  move.l d4, (a3)+
051D2  move.l d4, (a4)+
051D4  move.l d4, (a1)+
051D6  swap   d2
051D8  or.w   d2, (a3)+
051DA  or.w   d2, (a4)+
051DC  or.w   d2, (a1)+
051DE  not.w  d2
051E0  dbra   d6, $34a0
051E4  bra.w  $34cc
051E8  or.w   d2, (a3)+
051EA  or.w   d2, (a4)+
051EC  or.w   d2, (a1)+
051EE  not.w  d2
051F0  move.w d4, (a3)+
051F2  move.w d4, (a4)+
051F4  move.w d4, (a1)+
051F6  move.l d4, (a3)+
051F8  move.l d4, (a4)+
051FA  move.l d4, (a1)+
051FC  move.l d4, (a3)+
051FE  move.l d4, (a4)+
05200  move.l d4, (a1)+
05202  move.l d4, (a3)+
05204  move.l d4, (a4)+
05206  move.l d4, (a1)+
05208  move.l d4, (a3)+
0520A  move.l d4, (a4)+
0520C  move.l d4, (a1)+
0520E  move.l d4, (a3)+
05210  move.l d4, (a4)+
05212  move.l d4, (a1)+
05214  move.l d4, (a3)+
05216  move.l d4, (a4)+
05218  move.l d4, (a1)+
0521A  swap   d2
0521C  or.w   d2, (a3)+
0521E  or.w   d2, (a4)+
05220  or.w   d2, (a1)+
05222  not.w  d2
05224  dbra   d6, $34a0
05228  bra.w  $34cc
0522C  or.w   d2, (a3)+
0522E  or.w   d2, (a4)+
05230  or.w   d2, (a1)+
05232  not.w  d2
05234  move.l d4, (a3)+
05236  move.l d4, (a4)+
05238  move.l d4, (a1)+
0523A  move.l d4, (a3)+
0523C  move.l d4, (a4)+
0523E  move.l d4, (a1)+
05240  move.l d4, (a3)+
05242  move.l d4, (a4)+
05244  move.l d4, (a1)+
05246  move.l d4, (a3)+
05248  move.l d4, (a4)+
0524A  move.l d4, (a1)+
0524C  move.l d4, (a3)+
0524E  move.l d4, (a4)+
05250  move.l d4, (a1)+
05252  move.l d4, (a3)+
05254  move.l d4, (a4)+
05256  move.l d4, (a1)+
05258  move.l d4, (a3)+
0525A  move.l d4, (a4)+
0525C  move.l d4, (a1)+
0525E  swap   d2
05260  or.w   d2, (a3)+
05262  or.w   d2, (a4)+
05264  or.w   d2, (a1)+
05266  not.w  d2
05268  dbra   d6, $34a0
0526C  bra.w  $34cc
05270  or.w   d2, (a3)+
05272  or.w   d2, (a4)+
05274  or.w   d2, (a1)+
05276  not.w  d2
05278  move.w d4, (a3)+
0527A  move.w d4, (a4)+
0527C  move.w d4, (a1)+
0527E  move.l d4, (a3)+
05280  move.l d4, (a4)+
05282  move.l d4, (a1)+
05284  move.l d4, (a3)+
05286  move.l d4, (a4)+
05288  move.l d4, (a1)+
0528A  move.l d4, (a3)+
0528C  move.l d4, (a4)+
0528E  move.l d4, (a1)+
05290  move.l d4, (a3)+
05292  move.l d4, (a4)+
05294  move.l d4, (a1)+
05296  move.l d4, (a3)+
05298  move.l d4, (a4)+
0529A  move.l d4, (a1)+
0529C  move.l d4, (a3)+
0529E  move.l d4, (a4)+
052A0  move.l d4, (a1)+
052A2  move.l d4, (a3)+
052A4  move.l d4, (a4)+
052A6  move.l d4, (a1)+
052A8  swap   d2
052AA  or.w   d2, (a3)+
052AC  or.w   d2, (a4)+
052AE  or.w   d2, (a1)+
052B0  not.w  d2
052B2  dbra   d6, $34a0
052B6  bra.w  $34cc
052BA  or.w   d2, (a3)+
052BC  or.w   d2, (a4)+
052BE  or.w   d2, (a1)+
052C0  not.w  d2
052C2  move.l d4, (a3)+
052C4  move.l d4, (a4)+
052C6  move.l d4, (a1)+
052C8  move.l d4, (a3)+
052CA  move.l d4, (a4)+
052CC  move.l d4, (a1)+
052CE  move.l d4, (a3)+
052D0  move.l d4, (a4)+
052D2  move.l d4, (a1)+
052D4  move.l d4, (a3)+
052D6  move.l d4, (a4)+
052D8  move.l d4, (a1)+
052DA  move.l d4, (a3)+
052DC  move.l d4, (a4)+
052DE  move.l d4, (a1)+
052E0  move.l d4, (a3)+
052E2  move.l d4, (a4)+
052E4  move.l d4, (a1)+
052E6  move.l d4, (a3)+
052E8  move.l d4, (a4)+
052EA  move.l d4, (a1)+
052EC  move.l d4, (a3)+
052EE  move.l d4, (a4)+
052F0  move.l d4, (a1)+
052F2  swap   d2
052F4  or.w   d2, (a3)+
052F6  or.w   d2, (a4)+
052F8  or.w   d2, (a1)+
052FA  not.w  d2
052FC  dbra   d6, $34a0
05300  bra.w  $34cc
05304  or.w   d2, (a3)+
05306  or.w   d2, (a4)+
05308  or.w   d2, (a1)+
0530A  not.w  d2
0530C  move.w d4, (a3)+
0530E  move.w d4, (a4)+
05310  move.w d4, (a1)+
05312  move.l d4, (a3)+
05314  move.l d4, (a4)+
05316  move.l d4, (a1)+
05318  move.l d4, (a3)+
0531A  move.l d4, (a4)+
0531C  move.l d4, (a1)+
0531E  move.l d4, (a3)+
05320  move.l d4, (a4)+
05322  move.l d4, (a1)+
05324  move.l d4, (a3)+
05326  move.l d4, (a4)+
05328  move.l d4, (a1)+
0532A  move.l d4, (a3)+
0532C  move.l d4, (a4)+
0532E  move.l d4, (a1)+
05330  move.l d4, (a3)+
05332  move.l d4, (a4)+
05334  move.l d4, (a1)+
05336  move.l d4, (a3)+
05338  move.l d4, (a4)+
0533A  move.l d4, (a1)+
0533C  move.l d4, (a3)+
0533E  move.l d4, (a4)+
05340  move.l d4, (a1)+