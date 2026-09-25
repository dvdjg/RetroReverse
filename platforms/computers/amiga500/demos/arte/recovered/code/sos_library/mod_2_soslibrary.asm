; sos.library (mod_2) desde mod_002_c05ef2_26676.bin
; base 0xC05EF2 len 26676 (6834 B)
; generado con capstone (m68k, skipdata)

00C05EF2  jmp    $10.l
00C05EF8  jmp    $9a.l
00C05EFE  ; data: 0x73, 0x6f
00C05F00  ; data: 0x73, 0x00
00C05F02  movea.l $4.w, a6
00C05F06  movea.l $114(a6), a4
00C05F0A  tst.l  $ac(a4)
00C05F0E  bne.b  $c05f2a
00C05F10  lea.l  $5c(a4), a0
00C05F14  jsr    -$180(a6)
00C05F18  lea.l  $5c(a4), a0
00C05F1C  jsr    -$174(a6)
00C05F20  move.l d0, $7a.l
00C05F26  lea.l  $c05f70(pc), a2
00C05F2A  lea.l  $c05f80(pc), a1
00C05F2E  moveq  #$0, d0
00C05F30  movea.l $4.w, a6
00C05F34  jsr    -$228(a6)
00C05F38  tst.l  d0
00C05F3A  beq.b  $c05f54
00C05F3C  movea.l d0, a6
00C05F3E  move.l a6, -(a7)
00C05F40  lea.l  $9a.l, a0
00C05F46  jsr    -$1e(a6)
00C05F4A  movea.l (a7)+, a1
00C05F4C  movea.l $4.w, a6
00C05F50  jsr    -$19e(a6)
00C05F54  move.l $c05f6c(pc), d2
00C05F58  beq.b  $c05f68
00C05F5A  movea.l $4.w, a6
00C05F5E  jsr    -$84(a6)
00C05F62  movea.l d2, a1
00C05F64  jsr    -$17a(a6)
00C05F68  moveq  #$0, d0
00C05F6A  rts    
00C05F6C  ori.b  #$0, d0
00C05F70  ori.b  #$0, d0
00C05F74  ori.b  #$0, d0
00C05F78  ori.b  #$0, d0
00C05F7C  ori.b  #$0, d0
00C05F80  ; data: 0x73, 0x6f
00C05F82  ; data: 0x73, 0x2e
00C05F84  bge.b  $c05fef
00C05F86  bhi.b  $c05ffa
00C05F88  bsr.b  $c05ffc
00C05F8A  ; data: 0x79, 0x00
00C05F8C  moveq  #$8, d0
00C05F8E  suba.l a0, a0
00C05F90  jsr    -$ba(a6)
00C05F94  lea.l  $0.l, a5
00C05F9A  move.l a6, $0(a5)
00C05F9E  move.l a2, -(a7)
00C05FA0  jsr    -$11a(a6)
00C05FA4  movea.l a0, a2
00C05FA6  movea.l $26(a2), a0
00C05FAA  move.l a0, d0
00C05FAC  bne.b  $c05fc4
00C05FAE  moveq  #$1c, d0
00C05FB0  moveq  #$0, d1
00C05FB2  jsr    -$2a(a6)
00C05FB6  movea.l d0, a0
00C05FB8  moveq  #$6, d1
00C05FBA  clr.l  (a0)+
00C05FBC  dbra   d1, $c05fba
00C05FC0  move.l d0, $26(a2)
00C05FC4  movea.l d0, a2
00C05FC6  move.l a2, $8(a5)
00C05FCA  tst.w  $e(a2)
00C05FCE  bne.b  $c05fd6
00C05FD0  move.w #$300, $e(a2)
00C05FD6  tst.l  $4(a2)
00C05FDA  bne.b  $c05ff6
00C05FDC  move.l #$44425547, d0
00C05FE2  jsr    -$138(a6)
00C05FE6  movea.l $8(a5), a1
00C05FEA  move.l a0, $18(a1)
00C05FEE  move.l #$114, $4(a2)
00C05FF6  tst.l  $8(a2)
00C05FFA  bne.b  $c06046
00C05FFC  move.l #$12c, $8(a2)
00C06004  bra.b  $c06046
00C06006  move.l a5, -(a7)
00C06008  lea.l  $0.l, a5
00C0600E  movea.l $8(a5), a4
00C06012  movea.l $18(a4), a4
00C06016  jsr    -$c(a4)
00C0601A  movea.l (a7)+, a5
00C0601C  rts    
00C0601E  move.l a5, -(a7)
00C06020  lea.l  $0.l, a5
00C06026  movea.l $8(a5), a0
00C0602A  btst.b #$2, $dff016.l
00C06032  bne.b  $c0603e
00C06034  move.w $e(a0), $c(a0)
00C0603A  movea.l (a7)+, a5
00C0603C  rts    
00C0603E  movea.l (a7)+, a5
00C06040  addq.w #$1, $c(a0)
00C06044  rts    
00C06046  movea.l (a7)+, a2
00C06048  bsr.w  $c06eba
00C0604C  movea.l $8(a5), a0
00C06050  movea.l $4(a0), a0
00C06054  jsr    (a0)
00C06056  movea.l $8(a5), a0
00C0605A  move.w $c(a0), d0
00C0605E  cmp.w  $10(a0), d0
00C06062  bcs.b  $c0604c
00C06064  lea.l  $0.l, a0
00C0606A  lea.l  $c060b0(pc), a1
00C0606E  moveq  #$20, d0
00C06070  jsr    -$54(a6)
00C06074  bsr.w  $c06f86
00C06078  lea.l  $dff002.l, a4
00C0607E  bsr.w  $c060dc
00C06082  jsr    -$11a(a6)
00C06086  movea.l $26(a0), a1
00C0608A  cmpi.w #$13, $1c(a1)
00C06090  beq.b  $c060ac
00C06092  movea.l $8(a5), a0
00C06096  movea.l $4(a0), a0
00C0609A  jsr    (a0)
00C0609C  movea.l $8(a5), a0
00C060A0  move.w $c(a0), d0
00C060A4  cmp.w  $e(a0), d0
00C060A8  bcs.w  $c0607e
00C060AC  moveq  #$0, d0
00C060AE  rts    
00C060B0  movem.l d0-d7/a0-a6, -(a7)
00C060B4  lea.l  $0.l, a5
00C060BA  movea.l $0(a5), a6
00C060BE  movea.l $8(a5), a0
00C060C2  movea.l $8(a0), a0
00C060C6  jsr    (a0)
00C060C8  bsr.w  $c060de
00C060CC  movem.l (a7)+, d0-d7/a0-a6
00C060D0  move.w #$30, $dff09c.l
00C060D8  nop    
00C060DA  rte    
00C060DC  rts    
00C060DE  subq.w #$1, $1142.l
00C060E4  bge.b  $c0611e
00C060E6  lea.l  $dff002.l, a4
00C060EC  lea.l  $360.l, a6
00C060F2  bsr.w  $c082b2
00C060F6  bsr.w  $c08388
00C060FA  bsr.w  $c08414
00C060FE  bsr.w  $c06120
00C06102  bsr.w  $c06186
00C06106  move.w #$400, $dff096.l
00C0610E  bsr.w  $c06266
00C06112  move.w #$8400, $dff096.l
00C0611A  bsr.w  $c0659e
00C0611E  rts    
00C06120  tst.w  $28da.l
00C06126  bne.b  $c06162
00C06128  lea.l  $28dc.l, a0
00C0612E  adda.w $28d8.l, a0
00C06134  addq.w #$8, $28d8.l
00C0613A  move.l (a0)+, d0
00C0613C  move.w d0, $28da.l
00C06142  move.l (a0)+, $25cc.l
00C06148  move.b #$10, $25d0.l
00C06150  tst.l  (a0)
00C06152  bne.b  $c06162
00C06154  move.w #$3e8, $28da.l
00C0615C  clr.w  $28d8.l
00C06162  cmpi.w #$10, $28da.l
00C0616A  bne.b  $c0617e
00C0616C  move.l #$2900, $25cc.l
00C06176  move.b #$10, $25d0.l
00C0617E  subq.w #$1, $28da.l
00C06184  rts    
00C06186  lea.l  $25d8.l, a0
00C0618C  adda.w $35e.l, a0
00C06192  addq.w #$2, $35e.l
00C06198  cmpi.w #$180, $35e.l
00C061A0  bne.b  $c061a8
00C061A2  clr.w  $35e.l
00C061A8  move.w (a0), d1
00C061AA  muls.w #$133, d1
00C061AE  swap   d1
00C061B0  addi.w #$100, d1
00C061B4  move.w $60(a0), d3
00C061B8  muls.w #$5000, d3
00C061BC  swap   d3
00C061BE  lsl.w  #$1, d3
00C061C0  tst.w  d3
00C061C2  bge.b  $c061cc
00C061C4  ori.l  #$ffff0000, d3
00C061CA  bra.b  $c061d2
00C061CC  andi.l #$ffff, d3
00C061D2  move.w $c0(a0), d2
00C061D6  muls.w #$133, d2
00C061DA  swap   d2
00C061DC  addi.w #$100, d2
00C061E0  move.w $120(a0), d4
00C061E4  muls.w #$5000, d4
00C061E8  swap   d4
00C061EA  lsl.w  #$1, d4
00C061EC  tst.w  d4
00C061EE  bge.b  $c061f8
00C061F0  ori.l  #$ffff0000, d4
00C061F6  bra.b  $c061fe
00C061F8  andi.l #$ffff, d4
00C061FE  cmpi.w #$10, $28d8.l
00C06206  bne.b  $c0620e
00C06208  move.w #$100, d2
00C0620C  moveq  #$0, d4
00C0620E  cmp.w  d1, d2
00C06210  bge.b  $c0621c
00C06212  move.w #$40, $1e.l
00C0621A  bra.b  $c06224
00C0621C  move.w #$0, $1e.l
00C06224  moveq  #$0, d0
00C06226  move.w $8(a6), d0
00C0622A  divu.w d1, d0
00C0622C  move.w d0, (a6)
00C0622E  divs.w d1, d3
00C06230  addi.w #$a0, d3
00C06234  move.w d3, $2(a6)
00C06238  moveq  #$0, d0
00C0623A  move.w $e(a6), d0
00C0623E  divu.w d2, d0
00C06240  move.w d0, $4(a6)
00C06244  divs.w d2, d4
00C06246  addi.w #$a0, d4
00C0624A  move.w d4, $6(a6)
00C0624E  rts    
00C06250  ori.b  #$0, d0
00C06254  ori.l  #$a0, -(a0)
00C0625A  negx.b d0
00C0625C  ori.b  #$67, d0
00C06260  negx.b d0
00C06262  ori.b  #$9a, d0
00C06266  cmpi.w #$8, $28d8.l
00C0626E  beq.w  $c062c2
00C06272  movea.l $24d6.l, a0
00C06278  lea.l  $6(a0), a0
00C0627C  lea.l  $42c.l, a1
00C06282  move.w #$a0, d0
00C06286  sub.w  (a6), d0
00C06288  lsr.w  #$1, d0
00C0628A  mulu.w #$c, d0
00C0628E  adda.w d0, a0
00C06290  move.w (a6), d7
00C06292  move.l #$a200, d5
00C06298  divu.w d7, d5
00C0629A  andi.l #$ffff, d5
00C062A0  lsl.l  #$8, d5
00C062A2  moveq  #$0, d6
00C062A4  subq.w #$1, d7
00C062A6  add.l  d5, d6
00C062A8  move.l d6, d1
00C062AA  clr.w  d1
00C062AC  swap   d1
00C062AE  move.w d1, d0
00C062B0  swap   d1
00C062B2  sub.l  d1, d6
00C062B4  add.w  d0, d0
00C062B6  move.w (a1, d0.w), (a0)
00C062BA  lea.l  $c(a0), a0
00C062BE  dbra   d7, $c062a6
00C062C2  movea.l $24d6.l, a0
00C062C8  lea.l  $a(a0), a0
00C062CC  lea.l  $56c.l, a1
00C062D2  move.w #$a0, d0
00C062D6  sub.w  $4(a6), d0
00C062DA  lsr.w  #$1, d0
00C062DC  mulu.w #$c, d0
00C062E0  adda.w d0, a0
00C062E2  move.w $4(a6), d7
00C062E6  move.l #$a200, d5
00C062EC  divu.w d7, d5
00C062EE  andi.l #$ffff, d5
00C062F4  lsl.l  #$8, d5
00C062F6  moveq  #$0, d6
00C062F8  subq.w #$1, d7
00C062FA  add.l  d5, d6
00C062FC  move.l d6, d1
00C062FE  clr.w  d1
00C06300  swap   d1
00C06302  move.w d1, d0
00C06304  swap   d1
00C06306  sub.l  d1, d6
00C06308  add.w  d0, d0
00C0630A  move.w (a1, d0.w), (a0)
00C0630E  lea.l  $c(a0), a0
00C06312  dbra   d7, $c062fa
00C06316  rts    
00C06318  ; data: 0xff, 0xd8
00C0631A  movep.w -$28(a2), d0
00C0631E  ori.b  #$0, d0
00C06322  ori.b  #$0, d0
00C06326  ori.b  #$0, d0
00C0632A  ori.b  #$0, d0
00C0632E  ori.b  #$0, d0
00C06332  ori.b  #$0, d0
00C06336  ori.b  #$0, d0
00C0633A  ori.b  #$0, d0
00C0633E  ori.b  #$0, d0
00C06342  ori.b  #$0, d0
00C06346  ori.b  #$0, d0
00C0634A  ori.b  #$0, d0
00C0634E  ori.b  #$0, d0
00C06352  ori.b  #$0, d0
00C06356  ori.b  #$0, d0
00C0635A  ori.b  #$0, d0
00C0635E  ori.b  #$0, d0
00C06362  ori.b  #$0, d0
00C06366  ori.b  #$0, d0
00C0636A  ori.b  #$0, d0
00C0636E  ori.b  #$0, d0
00C06372  ori.b  #$0, d0
00C06376  ori.b  #$0, d0
00C0637A  ori.b  #$0, d0
00C0637E  ori.b  #$0, d0
00C06382  ori.b  #$0, d0
00C06386  ori.b  #$0, d0
00C0638A  ori.b  #$0, d0
00C0638E  ori.b  #$0, d0
00C06392  ori.b  #$0, d0
00C06396  ori.b  #$0, d0
00C0639A  ori.b  #$0, d0
00C0639E  ori.b  #$0, d0
00C063A2  ori.b  #$0, d0
00C063A6  ori.b  #$0, d0
00C063AA  ori.b  #$0, d0
00C063AE  ori.b  #$0, d0
00C063B2  ori.b  #$0, d0
00C063B6  ori.b  #$0, d0
00C063BA  ori.b  #$0, d0
00C063BE  ori.b  #$0, d0
00C063C2  ori.b  #$0, d0
00C063C6  ori.b  #$0, d0
00C063CA  ori.b  #$0, d0
00C063CE  ori.b  #$0, d0
00C063D2  ori.b  #$0, d0
00C063D6  ori.b  #$0, d0
00C063DA  ori.b  #$0, d0
00C063DE  ori.b  #$0, d0
00C063E2  ori.b  #$0, d0
00C063E6  ori.b  #$0, d0
00C063EA  ori.b  #$0, d0
00C063EE  ori.b  #$0, d0
00C063F2  ori.b  #$0, d0
00C063F6  ori.b  #$0, d0
00C063FA  ori.b  #$0, d0
00C063FE  ori.b  #$0, d0
00C06402  ori.b  #$0, d0
00C06406  ori.b  #$0, d0
00C0640A  ori.b  #$0, d0
00C0640E  ori.b  #$0, d0
00C06412  ori.b  #$0, d0
00C06416  ori.b  #$0, d0
00C0641A  ori.b  #$0, d0
00C0641E  ori.b  #$0, d0
00C06422  ori.b  #$0, d0
00C06426  ori.b  #$0, d0
00C0642A  ori.b  #$0, d0
00C0642E  ori.b  #$0, d0
00C06432  ori.b  #$0, d0
00C06436  ori.b  #$0, d0
00C0643A  ori.b  #$0, d0
00C0643E  ori.b  #$0, d0
00C06442  ori.b  #$0, d0
00C06446  ori.b  #$0, d0
00C0644A  ori.b  #$0, d0
00C0644E  ori.b  #$0, d0
00C06452  ori.b  #$0, d0
00C06456  ori.b  #$0, d0
00C0645A  ori.b  #$0, d0
00C0645E  ori.b  #$0, d0
00C06462  ori.b  #$0, d0
00C06466  ori.b  #$0, d0
00C0646A  ori.b  #$0, d0
00C0646E  ori.b  #$0, d0
00C06472  ori.b  #$0, d0
00C06476  ori.b  #$0, d0
00C0647A  ori.b  #$0, d0
00C0647E  ori.b  #$0, d0
00C06482  ori.b  #$0, d0
00C06486  ori.b  #$0, d0
00C0648A  ori.b  #$0, d0
00C0648E  ori.b  #$0, d0
00C06492  ori.b  #$0, d0
00C06496  ori.b  #$0, d0
00C0649A  ori.b  #$0, d0
00C0649E  ori.b  #$0, d0
00C064A2  ori.b  #$0, d0
00C064A6  ori.b  #$0, d0
00C064AA  ori.b  #$0, d0
00C064AE  ori.b  #$0, d0
00C064B2  ori.b  #$0, d0
00C064B6  ori.b  #$0, d0
00C064BA  ori.b  #$0, d0
00C064BE  ori.b  #$0, d0
00C064C2  ori.b  #$0, d0
00C064C6  ori.b  #$0, d0
00C064CA  ori.b  #$0, d0
00C064CE  ori.b  #$0, d0
00C064D2  ori.b  #$0, d0
00C064D6  ori.b  #$0, d0
00C064DA  ori.b  #$0, d0
00C064DE  ori.b  #$0, d0
00C064E2  ori.b  #$0, d0
00C064E6  ori.b  #$0, d0
00C064EA  ori.b  #$0, d0
00C064EE  ori.b  #$0, d0
00C064F2  ori.b  #$0, d0
00C064F6  ori.b  #$0, d0
00C064FA  ori.b  #$0, d0
00C064FE  ori.b  #$0, d0
00C06502  ori.b  #$0, d0
00C06506  ori.b  #$0, d0
00C0650A  ori.b  #$0, d0
00C0650E  ori.b  #$0, d0
00C06512  ori.b  #$0, d0
00C06516  ori.b  #$0, d0
00C0651A  ori.b  #$0, d0
00C0651E  ori.b  #$0, d0
00C06522  ori.b  #$0, d0
00C06526  ori.b  #$0, d0
00C0652A  ori.b  #$0, d0
00C0652E  ori.b  #$0, d0
00C06532  ori.b  #$0, d0
00C06536  ori.b  #$0, d0
00C0653A  ori.b  #$0, d0
00C0653E  ori.b  #$0, d0
00C06542  ori.b  #$0, d0
00C06546  ori.b  #$0, d0
00C0654A  ori.b  #$0, d0
00C0654E  ori.b  #$0, d0
00C06552  ori.b  #$0, d0
00C06556  ori.b  #$0, d0
00C0655A  ori.b  #$0, d0
00C0655E  ori.b  #$0, d0
00C06562  ori.b  #$0, d0
00C06566  ori.b  #$0, d0
00C0656A  ori.b  #$0, d0
00C0656E  ori.b  #$0, d0
00C06572  ori.b  #$0, d0
00C06576  ori.b  #$0, d0
00C0657A  ori.b  #$0, d0
00C0657E  ori.b  #$0, d0
00C06582  ori.b  #$0, d0
00C06586  ori.b  #$0, d0
00C0658A  ori.b  #$0, d0
00C0658E  ori.b  #$0, d0
00C06592  ori.b  #$0, d0
00C06596  ori.b  #$0, d0
00C0659A  ori.b  #$0, d0
00C0659E  moveq  #$0, d5
00C065A0  move.w (a6), d5
00C065A2  lsl.w  #$8, d5
00C065A4  divu.w #$a, d5
00C065A8  andi.l #$ffff, d5
00C065AE  lsl.l  #$8, d5
00C065B0  moveq  #$0, d6
00C065B2  movea.l $2480.l, a0
00C065B8  lea.l  $78(a0), a0
00C065BC  movea.l a0, a2
00C065BE  movea.l $1132.l, a1
00C065C4  movea.l a1, a3
00C065C6  add.l  d5, d6
00C065C8  move.l d6, d1
00C065CA  clr.w  d1
00C065CC  swap   d1
00C065CE  move.w d1, d0
00C065D0  swap   d1
00C065D2  sub.l  d1, d6
00C065D4  moveq  #$10, d2
00C065D6  sub.w  d0, d2
00C065D8  mulu.w #$2580, d2
00C065DC  adda.l d2, a1
00C065DE  cmpi.w #$8, $28d8.l
00C065E6  beq.w  $c06798
00C065EA  btst.b #$6, (a4)
00C065EE  bne.b  $c065ea
00C065F0  move.l #$ffffffff, $42(a4)
00C065F8  move.l #$9f00000, $3e(a4)
00C06600  move.l #$26, $62(a4)
00C06608  move.l a1, $4e(a4)
00C0660C  move.l a0, $52(a4)
00C06610  move.w #$7801, $56(a4)
00C06616  lea.l  $3c0(a1), a1
00C0661A  btst.b #$6, (a4)
00C0661E  bne.b  $c0661a
00C06620  move.l #$ffffffff, $42(a4)
00C06628  move.l #$26, $62(a4)
00C06630  move.w #$26, $5e(a4)
00C06636  moveq  #$8, d7
00C06638  movea.l a2, a0
00C0663A  movea.l a3, a1
00C0663C  add.l  d5, d6
00C0663E  move.l d6, d2
00C06640  clr.w  d2
00C06642  swap   d2
00C06644  move.w d2, d1
00C06646  swap   d2
00C06648  sub.l  d2, d6
00C0664A  moveq  #$10, d2
00C0664C  sub.w  d1, d2
00C0664E  mulu.w #$2580, d2
00C06652  adda.l d2, a1
00C06654  moveq  #$9, d2
00C06656  sub.w  d7, d2
00C06658  mulu.w #$3c0, d2
00C0665C  adda.l d2, a1
00C0665E  move.w d0, d2
00C06660  lsr.w  #$4, d2
00C06662  add.w  d2, d2
00C06664  adda.w d2, a0
00C06666  moveq  #$0, d2
00C06668  move.w d0, d2
00C0666A  andi.w #$f, d2
00C0666E  tst.w  d2
00C06670  bne.b  $c06696
00C06672  move.l #$9f00000, d2
00C06678  btst.b #$6, (a4)
00C0667C  bne.b  $c06678
00C0667E  move.l d2, $3e(a4)
00C06682  move.l a1, $4e(a4)
00C06686  move.l a0, $52(a4)
00C0668A  move.w #$7801, $56(a4)
00C06690  add.w  d1, d0
00C06692  bra.w  $c0670a
00C06696  moveq  #$10, d4
00C06698  sub.w  d2, d4
00C0669A  ror.w  #$4, d2
00C0669C  move.w d2, d3
00C0669E  ori.w  #$be2, d2
00C066A2  swap   d2
00C066A4  move.w d3, d2
00C066A6  btst.b #$6, (a4)
00C066AA  bne.b  $c066a6
00C066AC  move.l d2, $3e(a4)
00C066B0  move.w #$ffff, $70(a4)
00C066B6  move.l a1, $4e(a4)
00C066BA  move.l a0, $46(a4)
00C066BE  move.l a0, $52(a4)
00C066C2  move.w #$7801, $56(a4)
00C066C8  move.w d0, d2
00C066CA  lsr.w  #$4, d2
00C066CC  add.w  d1, d0
00C066CE  move.w d0, d3
00C066D0  lsr.w  #$4, d3
00C066D2  cmp.w  d2, d3
00C066D4  beq.b  $c0670a
00C066D6  lea.l  $4b02(a0), a0
00C066DA  lea.l  $3c0(a1), a1
00C066DE  moveq  #$0, d2
00C066E0  ror.w  #$4, d4
00C066E2  move.w d4, d2
00C066E4  ori.w  #$2, d4
00C066E8  ori.w  #$9f0, d2
00C066EC  swap   d2
00C066EE  move.w d4, d2
00C066F0  btst.b #$6, (a4)
00C066F4  bne.b  $c066f0
00C066F6  move.l d2, $3e(a4)
00C066FA  move.l a1, $4e(a4)
00C066FE  move.l a0, $52(a4)
00C06702  move.w #$78c1, $56(a4)
00C06708  bra.b  $c0670e
00C0670A  lea.l  $3c0(a1), a1
00C0670E  dbra   d7, $c06638
00C06712  lea.l  -$78(a2), a1
00C06716  clr.l  (a1)+
00C06718  clr.l  (a1)+
00C0671A  clr.l  (a1)+
00C0671C  clr.l  (a1)+
00C0671E  clr.l  (a1)+
00C06720  lea.l  $14(a1), a1
00C06724  clr.l  (a1)+
00C06726  clr.l  (a1)+
00C06728  clr.l  (a1)+
00C0672A  clr.l  (a1)+
00C0672C  clr.l  (a1)+
00C0672E  lea.l  $14(a1), a1
00C06732  clr.l  (a1)+
00C06734  clr.l  (a1)+
00C06736  clr.l  (a1)+
00C06738  clr.l  (a1)+
00C0673A  clr.l  (a1)+
00C0673C  lea.l  $4b00(a2), a1
00C06740  clr.l  (a1)+
00C06742  clr.l  (a1)+
00C06744  clr.l  (a1)+
00C06746  clr.l  (a1)+
00C06748  clr.l  (a1)+
00C0674A  lea.l  $c06e9a(pc), a1
00C0674E  movea.l a2, a0
00C06750  move.w d0, d2
00C06752  lsr.w  #$4, d2
00C06754  add.w  d2, d2
00C06756  adda.w d2, a0
00C06758  andi.w #$f, d0
00C0675C  add.w  d0, d0
00C0675E  move.w (a1, d0.w), d0
00C06762  moveq  #$24, d2
00C06764  btst.b #$6, (a4)
00C06768  bne.b  $c06764
00C0676A  move.w #$ffff, $72(a4)
00C06770  move.w #$ffff, $44(a4)
00C06776  move.w d0, $42(a4)
00C0677A  move.w d2, $5e(a4)
00C0677E  move.w d2, $64(a4)
00C06782  move.l a0, $46(a4)
00C06786  move.l a0, $52(a4)
00C0678A  move.l #$30a0000, $3e(a4)
00C06792  move.w #$7802, $56(a4)
00C06798  moveq  #$0, d5
00C0679A  move.w $4(a6), d5
00C0679E  lsl.w  #$8, d5
00C067A0  divu.w #$a, d5
00C067A4  andi.l #$ffff, d5
00C067AA  lsl.l  #$8, d5
00C067AC  moveq  #$0, d6
00C067AE  movea.l $2480.l, a0
00C067B4  lea.l  $4c40(a0), a0
00C067B8  movea.l a0, a2
00C067BA  movea.l $1136.l, a1
00C067C0  movea.l a1, a3
00C067C2  add.l  d5, d6
00C067C4  move.l d6, d1
00C067C6  clr.w  d1
00C067C8  swap   d1
00C067CA  move.w d1, d0
00C067CC  swap   d1
00C067CE  sub.l  d1, d6
00C067D0  moveq  #$10, d2
00C067D2  sub.w  d0, d2
00C067D4  mulu.w #$1900, d2
00C067D8  adda.l d2, a1
00C067DA  movea.l $24da.l, a5
00C067E0  lea.l  $6(a5), a5
00C067E4  bsr.w  $c06996
00C067E8  btst.b #$6, (a4)
00C067EC  bne.b  $c067e8
00C067EE  cmpi.w #$10, $28d8.l
00C067F6  bne.w  $c06808
00C067FA  cmpi.w #$bd, $28da.l
00C06802  bge.b  $c06808
00C06804  bra.w  $c06994
00C06808  move.l #$ffffffff, $42(a4)
00C06810  move.l #$9f00000, $3e(a4)
00C06818  move.l #$26, $62(a4)
00C06820  move.l a1, $4e(a4)
00C06824  move.l a0, $52(a4)
00C06828  move.w #$5001, $56(a4)
00C0682E  lea.l  $280(a1), a1
00C06832  btst.b #$6, (a4)
00C06836  bne.b  $c06832
00C06838  move.l #$ffffffff, $42(a4)
00C06840  move.l #$26, $62(a4)
00C06848  move.w #$26, $5e(a4)
00C0684E  moveq  #$8, d7
00C06850  movea.l a2, a0
00C06852  movea.l a3, a1
00C06854  add.l  d5, d6
00C06856  move.l d6, d2
00C06858  clr.w  d2
00C0685A  swap   d2
00C0685C  move.w d2, d1
00C0685E  swap   d2
00C06860  sub.l  d2, d6
00C06862  moveq  #$10, d2
00C06864  sub.w  d1, d2
00C06866  mulu.w #$1900, d2
00C0686A  adda.l d2, a1
00C0686C  moveq  #$9, d2
00C0686E  sub.w  d7, d2
00C06870  mulu.w #$280, d2
00C06874  adda.l d2, a1
00C06876  move.w d0, d2
00C06878  lsr.w  #$4, d2
00C0687A  add.w  d2, d2
00C0687C  adda.w d2, a0
00C0687E  moveq  #$0, d2
00C06880  move.w d0, d2
00C06882  andi.w #$f, d2
00C06886  tst.w  d2
00C06888  bne.b  $c068ae
00C0688A  move.l #$9f00000, d2
00C06890  btst.b #$6, (a4)
00C06894  bne.b  $c06890
00C06896  move.l d2, $3e(a4)
00C0689A  move.l a1, $4e(a4)
00C0689E  move.l a0, $52(a4)
00C068A2  move.w #$5001, $56(a4)
00C068A8  add.w  d1, d0
00C068AA  bra.w  $c06922
00C068AE  moveq  #$10, d4
00C068B0  sub.w  d2, d4
00C068B2  ror.w  #$4, d2
00C068B4  move.w d2, d3
00C068B6  ori.w  #$be2, d2
00C068BA  swap   d2
00C068BC  move.w d3, d2
00C068BE  btst.b #$6, (a4)
00C068C2  bne.b  $c068be
00C068C4  move.l d2, $3e(a4)
00C068C8  move.w #$ffff, $70(a4)
00C068CE  move.l a1, $4e(a4)
00C068D2  move.l a0, $46(a4)
00C068D6  move.l a0, $52(a4)
00C068DA  move.w #$5001, $56(a4)
00C068E0  move.w d0, d2
00C068E2  lsr.w  #$4, d2
00C068E4  add.w  d1, d0
00C068E6  move.w d0, d3
00C068E8  lsr.w  #$4, d3
00C068EA  cmp.w  d2, d3
00C068EC  beq.b  $c06922
00C068EE  lea.l  $3202(a0), a0
00C068F2  lea.l  $280(a1), a1
00C068F6  moveq  #$0, d2
00C068F8  ror.w  #$4, d4
00C068FA  move.w d4, d2
00C068FC  ori.w  #$2, d4
00C06900  ori.w  #$9f0, d2
00C06904  swap   d2
00C06906  move.w d4, d2
00C06908  btst.b #$6, (a4)
00C0690C  bne.b  $c06908
00C0690E  move.l d2, $3e(a4)
00C06912  move.l a1, $4e(a4)
00C06916  move.l a0, $52(a4)
00C0691A  move.w #$5081, $56(a4)
00C06920  bra.b  $c06926
00C06922  lea.l  $280(a1), a1
00C06926  dbra   d7, $c06850
00C0692A  lea.l  -$50(a2), a1
00C0692E  clr.l  (a1)+
00C06930  clr.l  (a1)+
00C06932  clr.l  (a1)+
00C06934  clr.l  (a1)+
00C06936  clr.l  (a1)+
00C06938  lea.l  $14(a1), a1
00C0693C  clr.l  (a1)+
00C0693E  clr.l  (a1)+
00C06940  clr.l  (a1)+
00C06942  clr.l  (a1)+
00C06944  clr.l  (a1)+
00C06946  lea.l  $c06e9a(pc), a1
00C0694A  movea.l a2, a0
00C0694C  move.w d0, d2
00C0694E  lsr.w  #$4, d2
00C06950  add.w  d2, d2
00C06952  adda.w d2, a0
00C06954  andi.w #$f, d0
00C06958  add.w  d0, d0
00C0695A  move.w (a1, d0.w), d0
00C0695E  moveq  #$24, d2
00C06960  btst.b #$6, (a4)
00C06964  bne.b  $c06960
00C06966  move.w #$ffff, $72(a4)
00C0696C  move.w #$ffff, $44(a4)
00C06972  move.w d0, $42(a4)
00C06976  move.w d2, $5e(a4)
00C0697A  move.w d2, $64(a4)
00C0697E  move.l a0, $46(a4)
00C06982  move.l a0, $52(a4)
00C06986  move.l #$30a0000, $3e(a4)
00C0698E  move.w #$5002, $56(a4)
00C06994  rts    
00C06996  moveq  #$d8, d2
00C06998  move.w d2, $0(a5)
00C0699C  move.w d2, $c(a5)
00C069A0  move.w d2, $18(a5)
00C069A4  move.w d2, $24(a5)
00C069A8  move.w d2, $30(a5)
00C069AC  move.w d2, $3c(a5)
00C069B0  move.w d2, $48(a5)
00C069B4  move.w d2, $54(a5)
00C069B8  move.w d2, $60(a5)
00C069BC  move.w d2, $6c(a5)
00C069C0  move.w d2, $78(a5)
00C069C4  move.w d2, $84(a5)
00C069C8  move.w d2, $90(a5)
00C069CC  move.w d2, $9c(a5)
00C069D0  move.w d2, $a8(a5)
00C069D4  move.w d2, $b4(a5)
00C069D8  move.w d2, $c0(a5)
00C069DC  move.w d2, $cc(a5)
00C069E0  move.w d2, $d8(a5)
00C069E4  move.w d2, $e4(a5)
00C069E8  move.w d2, $f0(a5)
00C069EC  move.w d2, $fc(a5)
00C069F0  move.w d2, $108(a5)
00C069F4  move.w d2, $114(a5)
00C069F8  move.w d2, $120(a5)
00C069FC  move.w d2, $12c(a5)
00C06A00  move.w d2, $138(a5)
00C06A04  move.w d2, $144(a5)
00C06A08  move.w d2, $150(a5)
00C06A0C  move.w d2, $15c(a5)
00C06A10  move.w d2, $168(a5)
00C06A14  move.w d2, $174(a5)
00C06A18  move.w d2, $180(a5)
00C06A1C  move.w d2, $18c(a5)
00C06A20  move.w d2, $198(a5)
00C06A24  move.w d2, $1a4(a5)
00C06A28  move.w d2, $1b0(a5)
00C06A2C  move.w d2, $1bc(a5)
00C06A30  move.w d2, $1c8(a5)
00C06A34  move.w d2, $1d4(a5)
00C06A38  move.w d2, $1e0(a5)
00C06A3C  move.w d2, $1ec(a5)
00C06A40  move.w d2, $1f8(a5)
00C06A44  move.w d2, $204(a5)
00C06A48  move.w d2, $210(a5)
00C06A4C  move.w d2, $21c(a5)
00C06A50  move.w d2, $228(a5)
00C06A54  move.w d2, $234(a5)
00C06A58  move.w d2, $240(a5)
00C06A5C  move.w d2, $24c(a5)
00C06A60  move.w d2, $258(a5)
00C06A64  move.w d2, $264(a5)
00C06A68  move.w d2, $270(a5)
00C06A6C  move.w d2, $27c(a5)
00C06A70  move.w d2, $288(a5)
00C06A74  move.w d2, $294(a5)
00C06A78  move.w d2, $2a0(a5)
00C06A7C  move.w d2, $2ac(a5)
00C06A80  move.w d2, $2b8(a5)
00C06A84  move.w d2, $2c4(a5)
00C06A88  move.w d2, $2d0(a5)
00C06A8C  move.w d2, $2dc(a5)
00C06A90  move.w d2, $2e8(a5)
00C06A94  move.w d2, $2f4(a5)
00C06A98  move.w d2, $300(a5)
00C06A9C  move.w d2, $30c(a5)
00C06AA0  move.w d2, $318(a5)
00C06AA4  move.w d2, $324(a5)
00C06AA8  move.w d2, $330(a5)
00C06AAC  move.w d2, $33c(a5)
00C06AB0  move.w d2, $348(a5)
00C06AB4  move.w d2, $354(a5)
00C06AB8  move.w d2, $360(a5)
00C06ABC  move.w d2, $36c(a5)
00C06AC0  move.w d2, $378(a5)
00C06AC4  move.w d2, $384(a5)
00C06AC8  move.w d2, $390(a5)
00C06ACC  move.w d2, $39c(a5)
00C06AD0  move.w d2, $3a8(a5)
00C06AD4  move.w d2, $3b4(a5)
00C06AD8  move.w d2, $3c0(a5)
00C06ADC  move.w d2, $3cc(a5)
00C06AE0  move.w d2, $3d8(a5)
00C06AE4  move.w d2, $3e4(a5)
00C06AE8  move.w d2, $3f0(a5)
00C06AEC  move.w d2, $3fc(a5)
00C06AF0  move.w d2, $408(a5)
00C06AF4  move.w d2, $414(a5)
00C06AF8  move.w d2, $420(a5)
00C06AFC  move.w d2, $42c(a5)
00C06B00  move.w d2, $438(a5)
00C06B04  move.w d2, $444(a5)
00C06B08  move.w d2, $450(a5)
00C06B0C  move.w d2, $45c(a5)
00C06B10  move.w d2, $468(a5)
00C06B14  move.w d2, $474(a5)
00C06B18  move.w d2, $480(a5)
00C06B1C  move.w d2, $48c(a5)
00C06B20  move.w d2, $498(a5)
00C06B24  move.w d2, $4a4(a5)
00C06B28  move.w d2, $4b0(a5)
00C06B2C  move.w d2, $4bc(a5)
00C06B30  move.w d2, $4c8(a5)
00C06B34  move.w d2, $4d4(a5)
00C06B38  move.w d2, $4e0(a5)
00C06B3C  move.w d2, $4ec(a5)
00C06B40  move.w d2, $4f8(a5)
00C06B44  move.w d2, $504(a5)
00C06B48  move.w d2, $510(a5)
00C06B4C  move.w d2, $51c(a5)
00C06B50  move.w d2, $528(a5)
00C06B54  move.w d2, $534(a5)
00C06B58  move.w d2, $540(a5)
00C06B5C  move.w d2, $54c(a5)
00C06B60  move.w d2, $558(a5)
00C06B64  move.w d2, $564(a5)
00C06B68  move.w d2, $570(a5)
00C06B6C  move.w d2, $57c(a5)
00C06B70  move.w d2, $588(a5)
00C06B74  move.w d2, $594(a5)
00C06B78  move.w d2, $5a0(a5)
00C06B7C  move.w d2, $5ac(a5)
00C06B80  move.w d2, $5b8(a5)
00C06B84  move.w d2, $5c4(a5)
00C06B88  move.w d2, $5d0(a5)
00C06B8C  move.w d2, $5dc(a5)
00C06B90  move.w d2, $5e8(a5)
00C06B94  move.w d2, $5f4(a5)
00C06B98  move.w d2, $600(a5)
00C06B9C  move.w d2, $60c(a5)
00C06BA0  move.w d2, $618(a5)
00C06BA4  move.w d2, $624(a5)
00C06BA8  move.w d2, $630(a5)
00C06BAC  move.w d2, $63c(a5)
00C06BB0  move.w d2, $648(a5)
00C06BB4  move.w d2, $654(a5)
00C06BB8  move.w d2, $660(a5)
00C06BBC  move.w d2, $66c(a5)
00C06BC0  move.w d2, $678(a5)
00C06BC4  move.w d2, $684(a5)
00C06BC8  move.w d2, $690(a5)
00C06BCC  move.w d2, $69c(a5)
00C06BD0  move.w d2, $6a8(a5)
00C06BD4  move.w d2, $6b4(a5)
00C06BD8  move.w d2, $6c0(a5)
00C06BDC  move.w d2, $6cc(a5)
00C06BE0  move.w d2, $6d8(a5)
00C06BE4  move.w d2, $6e4(a5)
00C06BE8  move.w d2, $6f0(a5)
00C06BEC  move.w d2, $6fc(a5)
00C06BF0  move.w d2, $708(a5)
00C06BF4  move.w d2, $714(a5)
00C06BF8  move.w d2, $720(a5)
00C06BFC  move.w d2, $72c(a5)
00C06C00  move.w d2, $738(a5)
00C06C04  move.w d2, $744(a5)
00C06C08  move.w d2, $750(a5)
00C06C0C  move.w d2, $75c(a5)
00C06C10  move.w d2, $768(a5)
00C06C14  move.w d2, $774(a5)
00C06C18  move.w d2, $4(a5)
00C06C1C  move.w d2, $10(a5)
00C06C20  move.w d2, $1c(a5)
00C06C24  move.w d2, $28(a5)
00C06C28  move.w d2, $34(a5)
00C06C2C  move.w d2, $40(a5)
00C06C30  move.w d2, $4c(a5)
00C06C34  move.w d2, $58(a5)
00C06C38  move.w d2, $64(a5)
00C06C3C  move.w d2, $70(a5)
00C06C40  move.w d2, $7c(a5)
00C06C44  move.w d2, $88(a5)
00C06C48  move.w d2, $94(a5)
00C06C4C  move.w d2, $a0(a5)
00C06C50  move.w d2, $ac(a5)
00C06C54  move.w d2, $b8(a5)
00C06C58  move.w d2, $c4(a5)
00C06C5C  move.w d2, $d0(a5)
00C06C60  move.w d2, $dc(a5)
00C06C64  move.w d2, $e8(a5)
00C06C68  move.w d2, $f4(a5)
00C06C6C  move.w d2, $100(a5)
00C06C70  move.w d2, $10c(a5)
00C06C74  move.w d2, $118(a5)
00C06C78  move.w d2, $124(a5)
00C06C7C  move.w d2, $130(a5)
00C06C80  move.w d2, $13c(a5)
00C06C84  move.w d2, $148(a5)
00C06C88  move.w d2, $154(a5)
00C06C8C  move.w d2, $160(a5)
00C06C90  move.w d2, $16c(a5)
00C06C94  move.w d2, $178(a5)
00C06C98  move.w d2, $184(a5)
00C06C9C  move.w d2, $190(a5)
00C06CA0  move.w d2, $19c(a5)
00C06CA4  move.w d2, $1a8(a5)
00C06CA8  move.w d2, $1b4(a5)
00C06CAC  move.w d2, $1c0(a5)
00C06CB0  move.w d2, $1cc(a5)
00C06CB4  move.w d2, $1d8(a5)
00C06CB8  move.w d2, $1e4(a5)
00C06CBC  move.w d2, $1f0(a5)
00C06CC0  move.w d2, $1fc(a5)
00C06CC4  move.w d2, $208(a5)
00C06CC8  move.w d2, $214(a5)
00C06CCC  move.w d2, $220(a5)
00C06CD0  move.w d2, $22c(a5)
00C06CD4  move.w d2, $238(a5)
00C06CD8  move.w d2, $244(a5)
00C06CDC  move.w d2, $250(a5)
00C06CE0  move.w d2, $25c(a5)
00C06CE4  move.w d2, $268(a5)
00C06CE8  move.w d2, $274(a5)
00C06CEC  move.w d2, $280(a5)
00C06CF0  move.w d2, $28c(a5)
00C06CF4  move.w d2, $298(a5)
00C06CF8  move.w d2, $2a4(a5)
00C06CFC  move.w d2, $2b0(a5)
00C06D00  move.w d2, $2bc(a5)
00C06D04  move.w d2, $2c8(a5)
00C06D08  move.w d2, $2d4(a5)
00C06D0C  move.w d2, $2e0(a5)
00C06D10  move.w d2, $2ec(a5)
00C06D14  move.w d2, $2f8(a5)
00C06D18  move.w d2, $304(a5)
00C06D1C  move.w d2, $310(a5)
00C06D20  move.w d2, $31c(a5)
00C06D24  move.w d2, $328(a5)
00C06D28  move.w d2, $334(a5)
00C06D2C  move.w d2, $340(a5)
00C06D30  move.w d2, $34c(a5)
00C06D34  move.w d2, $358(a5)
00C06D38  move.w d2, $364(a5)
00C06D3C  move.w d2, $370(a5)
00C06D40  move.w d2, $37c(a5)
00C06D44  move.w d2, $388(a5)
00C06D48  move.w d2, $394(a5)
00C06D4C  move.w d2, $3a0(a5)
00C06D50  move.w d2, $3ac(a5)
00C06D54  move.w d2, $3b8(a5)
00C06D58  move.w d2, $3c4(a5)
00C06D5C  move.w d2, $3d0(a5)
00C06D60  move.w d2, $3dc(a5)
00C06D64  move.w d2, $3e8(a5)
00C06D68  move.w d2, $3f4(a5)
00C06D6C  move.w d2, $400(a5)
00C06D70  move.w d2, $40c(a5)
00C06D74  move.w d2, $418(a5)
00C06D78  move.w d2, $424(a5)
00C06D7C  move.w d2, $430(a5)
00C06D80  move.w d2, $43c(a5)
00C06D84  move.w d2, $448(a5)
00C06D88  move.w d2, $454(a5)
00C06D8C  move.w d2, $460(a5)
00C06D90  move.w d2, $46c(a5)
00C06D94  move.w d2, $478(a5)
00C06D98  move.w d2, $484(a5)
00C06D9C  move.w d2, $490(a5)
00C06DA0  move.w d2, $49c(a5)
00C06DA4  move.w d2, $4a8(a5)
00C06DA8  move.w d2, $4b4(a5)
00C06DAC  move.w d2, $4c0(a5)
00C06DB0  move.w d2, $4cc(a5)
00C06DB4  move.w d2, $4d8(a5)
00C06DB8  move.w d2, $4e4(a5)
00C06DBC  move.w d2, $4f0(a5)
00C06DC0  move.w d2, $4fc(a5)
00C06DC4  move.w d2, $508(a5)
00C06DC8  move.w d2, $514(a5)
00C06DCC  move.w d2, $520(a5)
00C06DD0  move.w d2, $52c(a5)
00C06DD4  move.w d2, $538(a5)
00C06DD8  move.w d2, $544(a5)
00C06DDC  move.w d2, $550(a5)
00C06DE0  move.w d2, $55c(a5)
00C06DE4  move.w d2, $568(a5)
00C06DE8  move.w d2, $574(a5)
00C06DEC  move.w d2, $580(a5)
00C06DF0  move.w d2, $58c(a5)
00C06DF4  move.w d2, $598(a5)
00C06DF8  move.w d2, $5a4(a5)
00C06DFC  move.w d2, $5b0(a5)
00C06E00  move.w d2, $5bc(a5)
00C06E04  move.w d2, $5c8(a5)
00C06E08  move.w d2, $5d4(a5)
00C06E0C  move.w d2, $5e0(a5)
00C06E10  move.w d2, $5ec(a5)
00C06E14  move.w d2, $5f8(a5)
00C06E18  move.w d2, $604(a5)
00C06E1C  move.w d2, $610(a5)
00C06E20  move.w d2, $61c(a5)
00C06E24  move.w d2, $628(a5)
00C06E28  move.w d2, $634(a5)
00C06E2C  move.w d2, $640(a5)
00C06E30  move.w d2, $64c(a5)
00C06E34  move.w d2, $658(a5)
00C06E38  move.w d2, $664(a5)
00C06E3C  move.w d2, $670(a5)
00C06E40  move.w d2, $67c(a5)
00C06E44  move.w d2, $688(a5)
00C06E48  move.w d2, $694(a5)
00C06E4C  move.w d2, $6a0(a5)
00C06E50  move.w d2, $6ac(a5)
00C06E54  move.w d2, $6b8(a5)
00C06E58  move.w d2, $6c4(a5)
00C06E5C  move.w d2, $6d0(a5)
00C06E60  move.w d2, $6dc(a5)
00C06E64  move.w d2, $6e8(a5)
00C06E68  move.w d2, $6f4(a5)
00C06E6C  move.w d2, $700(a5)
00C06E70  move.w d2, $70c(a5)
00C06E74  move.w d2, $718(a5)
00C06E78  move.w d2, $724(a5)
00C06E7C  move.w d2, $730(a5)
00C06E80  move.w d2, $73c(a5)
00C06E84  move.w d2, $748(a5)
00C06E88  move.w d2, $754(a5)
00C06E8C  move.w d2, $760(a5)
00C06E90  move.w d2, $76c(a5)
00C06E94  move.w d2, $778(a5)
00C06E98  rts    
00C06E9A  ; data: 0xff, 0xff
00C06E9C  ; data: 0x7f, 0xff
00C06E9E  ; data: 0x3f, 0xff
00C06EA0  ; data: 0x1f, 0xff
00C06EA2  ; data: 0x0f, 0xff
00C06EA4  ; data: 0x07, 0xff
00C06EA6  ; data: 0x03, 0xff
00C06EA8  ; data: 0x01, 0xff
00C06EAA  ; data: 0x00, 0xff
00C06EAC  ; data: 0x00, 0x7f
00C06EAE  ; data: 0x00, 0x3f
00C06EB0  ori.b  #$f, (a7)+
00C06EB4  ori.b  #$3, d7
00C06EB8  ori.b  #$f9, d1
00C06EBC  ori.b  #$28, d0
00C06EC0  move.l #$17bc, d0
00C06EC6  moveq  #$0, d1
00C06EC8  moveq  #$8, d2
00C06ECA  move.w #$120, d3
00C06ECE  jsr    -$72(a6)
00C06ED2  jsr    -$11a(a6)
00C06ED6  move.w $1c(a0), d0
00C06EDA  or.w   d0, $16.l
00C06EE0  movem.l a4-a6, -(a7)
00C06EE4  move.l #$17700, d0
00C06EEA  move.l #$0, d1
00C06EF0  jsr    -$2a(a6)
00C06EF4  move.l d0, $1136.l
00C06EFA  move.l #$23280, d0
00C06F00  move.l #$0, d1
00C06F06  jsr    -$2a(a6)
00C06F0A  move.l d0, $1132.l
00C06F10  bsr.w  $c0711c
00C06F14  bsr.w  $c0706e
00C06F18  lea.l  $dff002.l, a4
00C06F1E  lea.l  $2900.l, a0
00C06F24  lea.l  $a6.l, a1
00C06F2A  moveq  #$f, d7
00C06F2C  move.w (a0)+, (a1)
00C06F2E  addq.w #$4, a1
00C06F30  dbra   d7, $c06f2c
00C06F34  bsr.w  $c082b2
00C06F38  bsr.w  $c08388
00C06F3C  bsr.w  $c0706e
00C06F40  move.l #$a4, $25c8.l
00C06F4A  clr.w  $25d4.l
00C06F50  move.w #$0, $25d2.l
00C06F58  move.w #$10, $25d6.l
00C06F60  clr.w  $28d8.l
00C06F66  clr.w  $28da.l
00C06F6C  clr.w  $35e.l
00C06F72  move.w #$a, $1142.l
00C06F7A  btst.b #$6, (a4)
00C06F7E  bne.b  $c06f7a
00C06F80  movem.l (a7)+, a4-a6
00C06F84  rts    
00C06F86  movem.l a4-a6, -(a7)
00C06F8A  move.l #$fed8, d0
00C06F90  move.l #$41, d1
00C06F96  jsr    -$2a(a6)
00C06F9A  addi.l #$28, d0
00C06FA0  lea.l  $248a.l, a0
00C06FA6  move.l d0, (a0)
00C06FA8  move.l d0, $8(a0)
00C06FAC  addi.l #$7f58, d0
00C06FB2  move.l d0, $4(a0)
00C06FB6  move.l #$17700, d0
00C06FBC  move.l #$1, d1
00C06FC2  jsr    -$2a(a6)
00C06FC6  move.l d0, $113e.l
00C06FCC  movea.l $1136.l, a0
00C06FD2  movea.l $113e.l, a1
00C06FD8  move.w #$3bf, d7
00C06FDC  bsr.w  $c07036
00C06FE0  move.l $113e.l, $1136.l
00C06FEA  move.l #$23280, d0
00C06FF0  move.l #$1, d1
00C06FF6  jsr    -$2a(a6)
00C06FFA  move.l d0, $113a.l
00C07000  movea.l $1132.l, a0
00C07006  movea.l $113a.l, a1
00C0700C  move.w #$59f, d7
00C07010  bsr.w  $c07036
00C07014  move.l $113a.l, $1132.l
00C0701E  movem.l (a7)+, a4-a6
00C07022  rts    
00C07024  ori.b  #$0, d0
00C07028  ori.b  #$0, d0
00C0702C  ori.b  #$0, d0
00C07030  ori.b  #$0, d0
00C07034  ori.b  #$d8, d0
00C07038  move.l (a0)+, (a1)+
00C0703A  move.l (a0)+, (a1)+
00C0703C  move.l (a0)+, (a1)+
00C0703E  move.l (a0)+, (a1)+
00C07040  move.l (a0)+, (a1)+
00C07042  move.l (a0)+, (a1)+
00C07044  move.l (a0)+, (a1)+
00C07046  move.l (a0)+, (a1)+
00C07048  move.l (a0)+, (a1)+
00C0704A  move.l (a0)+, (a1)+
00C0704C  move.l (a0)+, (a1)+
00C0704E  move.l (a0)+, (a1)+
00C07050  move.l (a0)+, (a1)+
00C07052  move.l (a0)+, (a1)+
00C07054  move.l (a0)+, (a1)+
00C07056  move.l (a0)+, (a1)+
00C07058  move.l (a0)+, (a1)+
00C0705A  move.l (a0)+, (a1)+
00C0705C  move.l (a0)+, (a1)+
00C0705E  move.l (a0)+, (a1)+
00C07060  move.l (a0)+, (a1)+
00C07062  move.l (a0)+, (a1)+
00C07064  move.l (a0)+, (a1)+
00C07066  move.l (a0)+, (a1)+
00C07068  dbra   d7, $c07036
00C0706C  rts    
00C0706E  lea.l  $88a.l, a0
00C07074  lea.l  $101e.l, a1
00C0707A  lea.l  $17b2.l, a2
00C07080  move.l #$f0, d0
00C07086  move.w d0, $4(a0)
00C0708A  move.w d0, $4(a1)
00C0708E  move.w d0, $4(a2)
00C07092  swap   d0
00C07094  move.w d0, (a0)
00C07096  move.w d0, (a1)
00C07098  move.w d0, (a2)
00C0709A  lea.l  $100.l, a0
00C070A0  lea.l  $894.l, a1
00C070A6  lea.l  $1028.l, a2
00C070AC  move.w #$5901, d0
00C070B0  move.w #$9f, d7
00C070B4  move.w d0, (a0)+
00C070B6  move.w d0, (a1)+
00C070B8  move.w d0, (a2)+
00C070BA  addi.w #$100, d0
00C070BE  move.w #$fffe, (a0)+
00C070C2  move.w #$fffe, (a1)+
00C070C6  move.w #$fffe, (a2)+
00C070CA  move.l #$108ffd8, (a0)+
00C070D0  move.l #$108ffd8, (a1)+
00C070D6  move.l #$108ffd8, (a2)+
00C070DC  move.l #$10affd8, (a0)+
00C070E2  move.l #$10affd8, (a1)+
00C070E8  move.l #$10affd8, (a2)+
00C070EE  dbra   d7, $c070b4
00C070F2  lea.l  $42c.l, a0
00C070F8  lea.l  $56c.l, a1
00C070FE  move.w #$ffd8, d0
00C07102  move.w #$ffd8, d1
00C07106  move.w #$9f, d7
00C0710A  move.w d0, (a0)+
00C0710C  move.w d1, (a1)+
00C0710E  addi.w #$78, d0
00C07112  addi.w #$50, d1
00C07116  dbra   d7, $c0710a
00C0711A  rts    
00C0711C  lea.l  $2362.l, a0
00C07122  lea.l  $1362.l, a1
00C07128  moveq  #$d, d7
00C0712A  lea.l  $2380.l, a2
00C07130  movea.l a1, a3
00C07132  move.w (a0)+, d0
00C07134  moveq  #$f, d6
00C07136  btst.b #$0, d0
00C0713A  beq.b  $c0713e
00C0713C  move.l (a2), (a3)+
00C0713E  lsr.w  #$1, d0
00C07140  lea.l  $4(a2), a2
00C07144  dbra   d6, $c07136
00C07148  lea.l  $3c(a1), a1
00C0714C  dbra   d7, $c0712a
00C07150  lea.l  $1362.l, a4
00C07156  lea.l  $16f6.l, a3
00C0715C  moveq  #$e, d7
00C0715E  movea.l a3, a2
00C07160  movea.l a4, a0
00C07162  tst.w  (a0)
00C07164  beq.b  $c0717e
00C07166  lea.l  $16e8.l, a1
00C0716C  move.l (a1)+, (a2)+
00C0716E  move.l (a1)+, (a2)+
00C07170  move.w (a0)+, -$2(a2)
00C07174  move.l (a1)+, (a2)+
00C07176  move.w (a0)+, -$2(a2)
00C0717A  move.w (a1)+, (a2)+
00C0717C  bra.b  $c07162
00C0717E  move.w $16e6.l, (a2)+
00C07184  lea.l  $d4(a3), a3
00C07188  lea.l  $3c(a4), a4
00C0718C  dbra   d7, $c0715e
00C07190  movea.l $1136.l, a0
00C07196  lea.l  $4f34.l, a1
00C0719C  lea.l  $c80(a1), a2
00C071A0  lea.l  $16f6.l, a5
00C071A6  move.w #$d, d5
00C071AA  move.w #$9, d6
00C071AE  move.w #$9f, d7
00C071B2  move.w (a1), d0
00C071B4  jsr    (a5)
00C071B6  move.w d0, (a0)+
00C071B8  move.w (a2), d0
00C071BA  jsr    (a5)
00C071BC  move.w d0, (a0)+
00C071BE  lea.l  $14(a1), a1
00C071C2  lea.l  $14(a2), a2
00C071C6  dbra   d7, $c071b2
00C071CA  lea.l  -$c7e(a1), a1
00C071CE  lea.l  -$c7e(a2), a2
00C071D2  dbra   d6, $c071ae
00C071D6  lea.l  $d4(a5), a5
00C071DA  lea.l  -$14(a1), a1
00C071DE  lea.l  -$14(a2), a2
00C071E2  dbra   d5, $c071aa
00C071E6  movea.l $1132.l, a0
00C071EC  lea.l  $29b4.l, a1
00C071F2  lea.l  $c80(a1), a2
00C071F6  lea.l  $c80(a2), a3
00C071FA  lea.l  $16f6.l, a5
00C07200  move.w #$d, d5
00C07204  move.w #$9, d6
00C07208  move.w #$9f, d7
00C0720C  move.w (a1), d0
00C0720E  jsr    (a5)
00C07210  move.w d0, (a0)+
00C07212  move.w (a2), d0
00C07214  jsr    (a5)
00C07216  move.w d0, (a0)+
00C07218  move.w (a3), d0
00C0721A  jsr    (a5)
00C0721C  move.w d0, (a0)+
00C0721E  lea.l  $14(a1), a1
00C07222  lea.l  $14(a2), a2
00C07226  lea.l  $14(a3), a3
00C0722A  dbra   d7, $c0720c
00C0722E  lea.l  -$c7e(a1), a1
00C07232  lea.l  -$c7e(a2), a2
00C07236  lea.l  -$c7e(a3), a3
00C0723A  dbra   d6, $c07208
00C0723E  lea.l  $d4(a5), a5
00C07242  lea.l  -$14(a1), a1
00C07246  lea.l  -$14(a2), a2
00C0724A  lea.l  -$14(a3), a3
00C0724E  dbra   d5, $c07204
00C07252  rts    
00C07254  ori.b  #$0, d0
00C07258  ori.b  #$0, d0
00C0725C  ori.b  #$0, d0
00C07260  ori.b  #$0, d0
00C07264  ori.b  #$0, d0
00C07268  ori.b  #$0, d0
00C0726C  ori.b  #$0, d0
00C07270  ori.b  #$0, d0
00C07274  ori.b  #$0, d0
00C07278  ori.b  #$0, d0
00C0727C  ori.b  #$0, d0
00C07280  ori.b  #$0, d0
00C07284  ori.b  #$0, d0
00C07288  ori.b  #$0, d0
00C0728C  ori.b  #$0, d0
00C07290  ori.b  #$0, d0
00C07294  ori.b  #$0, d0
00C07298  ori.b  #$0, d0
00C0729C  ori.b  #$0, d0
00C072A0  ori.b  #$0, d0
00C072A4  ori.b  #$0, d0
00C072A8  ori.b  #$0, d0
00C072AC  ori.b  #$0, d0
00C072B0  ori.b  #$0, d0
00C072B4  ori.b  #$0, d0
00C072B8  ori.b  #$0, d0
00C072BC  ori.b  #$0, d0
00C072C0  ori.b  #$0, d0
00C072C4  ori.b  #$0, d0
00C072C8  ori.b  #$0, d0
00C072CC  ori.b  #$0, d0
00C072D0  ori.b  #$0, d0
00C072D4  ori.b  #$0, d0
00C072D8  ori.b  #$0, d0
00C072DC  ori.b  #$0, d0
00C072E0  ori.b  #$0, d0
00C072E4  ori.b  #$0, d0
00C072E8  ori.b  #$0, d0
00C072EC  ori.b  #$0, d0
00C072F0  ori.b  #$0, d0
00C072F4  ori.b  #$0, d0
00C072F8  ori.b  #$0, d0
00C072FC  ori.b  #$0, d0
00C07300  ori.b  #$0, d0
00C07304  ori.b  #$0, d0
00C07308  ori.b  #$0, d0
00C0730C  ori.b  #$0, d0
00C07310  ori.b  #$0, d0
00C07314  ori.b  #$0, d0
00C07318  ori.b  #$0, d0
00C0731C  ori.b  #$0, d0
00C07320  ori.b  #$0, d0
00C07324  ori.b  #$0, d0
00C07328  ori.b  #$0, d0
00C0732C  ori.b  #$0, d0
00C07330  ori.b  #$0, d0
00C07334  ori.b  #$0, d0
00C07338  ori.b  #$0, d0
00C0733C  ori.b  #$0, d0
00C07340  ori.b  #$0, d0
00C07344  ori.b  #$0, d0
00C07348  ori.b  #$0, d0
00C0734C  ori.b  #$0, d0
00C07350  ori.b  #$0, d0
00C07354  ori.b  #$0, d0
00C07358  ori.b  #$0, d0
00C0735C  ori.b  #$0, d0
00C07360  ori.b  #$0, d0
00C07364  ori.b  #$0, d0
00C07368  ori.b  #$0, d0
00C0736C  ori.b  #$0, d0
00C07370  ori.b  #$0, d0
00C07374  ori.b  #$0, d0
00C07378  ori.b  #$0, d0
00C0737C  ori.b  #$0, d0
00C07380  ori.b  #$0, d0
00C07384  ori.b  #$0, d0
00C07388  ori.b  #$0, d0
00C0738C  ori.b  #$0, d0
00C07390  ori.b  #$0, d0
00C07394  ori.b  #$0, d0
00C07398  ori.b  #$0, d0
00C0739C  ori.b  #$0, d0
00C073A0  ori.b  #$0, d0
00C073A4  ori.b  #$0, d0
00C073A8  ori.b  #$0, d0
00C073AC  ori.b  #$0, d0
00C073B0  ori.b  #$0, d0
00C073B4  ori.b  #$0, d0
00C073B8  ori.b  #$0, d0
00C073BC  ori.b  #$0, d0
00C073C0  ori.b  #$0, d0
00C073C4  ori.b  #$0, d0
00C073C8  ori.b  #$0, d0
00C073CC  ori.b  #$0, d0
00C073D0  ori.b  #$0, d0
00C073D4  ori.b  #$0, d0
00C073D8  ori.b  #$0, d0
00C073DC  ori.b  #$0, d0
00C073E0  ori.b  #$0, d0
00C073E4  ori.b  #$0, d0
00C073E8  ori.b  #$0, d0
00C073EC  ori.b  #$0, d0
00C073F0  ori.b  #$0, d0
00C073F4  ori.b  #$0, d0
00C073F8  ori.b  #$0, d0
00C073FC  ori.b  #$0, d0
00C07400  ori.b  #$0, d0
00C07404  ori.b  #$0, d0
00C07408  ori.b  #$0, d0
00C0740C  ori.b  #$0, d0
00C07410  ori.b  #$0, d0
00C07414  ori.b  #$0, d0
00C07418  ori.b  #$0, d0
00C0741C  ori.b  #$0, d0
00C07420  ori.b  #$0, d0
00C07424  ori.b  #$0, d0
00C07428  ori.b  #$0, d0
00C0742C  ori.b  #$0, d0
00C07430  ori.b  #$0, d0
00C07434  ori.b  #$0, d0
00C07438  ori.b  #$0, d0
00C0743C  ori.b  #$0, d0
00C07440  ori.b  #$0, d0
00C07444  ori.b  #$0, d0
00C07448  ori.b  #$0, d0
00C0744C  ori.b  #$0, d0
00C07450  ori.b  #$0, d0
00C07454  ori.b  #$0, d0
00C07458  ori.b  #$0, d0
00C0745C  ori.b  #$0, d0
00C07460  ori.b  #$0, d0
00C07464  ori.b  #$0, d0
00C07468  ori.b  #$0, d0
00C0746C  ori.b  #$0, d0
00C07470  ori.b  #$0, d0
00C07474  ori.b  #$0, d0
00C07478  ori.b  #$0, d0
00C0747C  ori.b  #$0, d0
00C07480  ori.b  #$0, d0
00C07484  ori.b  #$0, d0
00C07488  ori.b  #$0, d0
00C0748C  ori.b  #$0, d0
00C07490  ori.b  #$0, d0
00C07494  ori.b  #$0, d0
00C07498  ori.b  #$0, d0
00C0749C  ori.b  #$0, d0
00C074A0  ori.b  #$0, d0
00C074A4  ori.b  #$0, d0
00C074A8  ori.b  #$0, d0
00C074AC  ori.b  #$0, d0
00C074B0  ori.b  #$0, d0
00C074B4  ori.b  #$0, d0
00C074B8  ori.b  #$0, d0
00C074BC  ori.b  #$0, d0
00C074C0  ori.b  #$0, d0
00C074C4  ori.b  #$0, d0
00C074C8  ori.b  #$0, d0
00C074CC  ori.b  #$0, d0
00C074D0  ori.b  #$0, d0
00C074D4  ori.b  #$0, d0
00C074D8  ori.b  #$0, d0
00C074DC  ori.b  #$0, d0
00C074E0  ori.b  #$0, d0
00C074E4  ori.b  #$0, d0
00C074E8  ori.b  #$0, d0
00C074EC  ori.b  #$0, d0
00C074F0  ori.b  #$0, d0
00C074F4  ori.b  #$0, d0
00C074F8  ori.b  #$0, d0
00C074FC  ori.b  #$0, d0
00C07500  ori.b  #$0, d0
00C07504  ori.b  #$0, d0
00C07508  ori.b  #$0, d0
00C0750C  ori.b  #$0, d0
00C07510  ori.b  #$0, d0
00C07514  ori.b  #$0, d0
00C07518  ori.b  #$0, d0
00C0751C  ori.b  #$0, d0
00C07520  ori.b  #$0, d0
00C07524  ori.b  #$0, d0
00C07528  ori.b  #$0, d0
00C0752C  ori.b  #$0, d0
00C07530  ori.b  #$0, d0
00C07534  ori.b  #$0, d0
00C07538  ori.b  #$0, d0
00C0753C  ori.b  #$0, d0
00C07540  ori.b  #$0, d0
00C07544  ori.b  #$0, d0
00C07548  ori.b  #$0, d0
00C0754C  ori.b  #$0, d0
00C07550  ori.b  #$0, d0
00C07554  ori.b  #$0, d0
00C07558  ori.b  #$0, d0
00C0755C  ori.b  #$0, d0
00C07560  ori.b  #$0, d0
00C07564  ori.b  #$0, d0
00C07568  ori.b  #$0, d0
00C0756C  ori.b  #$0, d0
00C07570  ori.b  #$0, d0
00C07574  ori.b  #$0, d0
00C07578  ori.b  #$0, d0
00C0757C  ori.b  #$0, d0
00C07580  ori.b  #$0, d0
00C07584  ori.b  #$0, d0
00C07588  ori.b  #$0, d0
00C0758C  ori.b  #$0, d0
00C07590  ori.b  #$0, d0
00C07594  ori.b  #$0, d0
00C07598  ori.b  #$0, d0
00C0759C  ori.b  #$0, d0
00C075A0  ori.b  #$0, d0
00C075A4  ori.b  #$0, d0
00C075A8  ori.b  #$0, d0
00C075AC  ori.b  #$0, d0
00C075B0  ori.b  #$0, d0
00C075B4  ori.b  #$0, d0
00C075B8  ori.b  #$0, d0
00C075BC  ori.b  #$0, d0
00C075C0  ori.b  #$0, d0
00C075C4  ori.b  #$0, d0
00C075C8  ori.b  #$0, d0
00C075CC  ori.b  #$0, d0
00C075D0  ori.b  #$0, d0
00C075D4  ori.b  #$0, d0
00C075D8  rts    
00C075DA  move.w d0, d1
00C075DC  add.w  d1, d1
00C075DE  andi.w #$0, d1
00C075E2  andi.w #$0, d0
00C075E6  or.w   d1, d0
00C075E8  ori.b  #$0, d0
00C075EC  ori.b  #$0, d0
00C075F0  ori.b  #$0, d0
00C075F4  ori.b  #$0, d0
00C075F8  ori.b  #$0, d0
00C075FC  ori.b  #$0, d0
00C07600  ori.b  #$0, d0
00C07604  ori.b  #$0, d0
00C07608  ori.b  #$0, d0
00C0760C  ori.b  #$0, d0
00C07610  ori.b  #$0, d0
00C07614  ori.b  #$0, d0
00C07618  ori.b  #$0, d0
00C0761C  ori.b  #$0, d0
00C07620  ori.b  #$0, d0
00C07624  ori.b  #$0, d0
00C07628  ori.b  #$0, d0
00C0762C  ori.b  #$0, d0
00C07630  ori.b  #$0, d0
00C07634  ori.b  #$0, d0
00C07638  ori.b  #$0, d0
00C0763C  ori.b  #$0, d0
00C07640  ori.b  #$0, d0
00C07644  ori.b  #$0, d0
00C07648  ori.b  #$0, d0
00C0764C  ori.b  #$0, d0
00C07650  ori.b  #$0, d0
00C07654  ori.b  #$0, d0
00C07658  ori.b  #$0, d0
00C0765C  ori.b  #$0, d0
00C07660  ori.b  #$0, d0
00C07664  ori.b  #$0, d0
00C07668  ori.b  #$0, d0
00C0766C  ori.b  #$0, d0
00C07670  ori.b  #$0, d0
00C07674  ori.b  #$0, d0
00C07678  ori.b  #$0, d0
00C0767C  ori.b  #$0, d0
00C07680  ori.b  #$0, d0
00C07684  ori.b  #$0, d0
00C07688  ori.b  #$0, d0
00C0768C  ori.b  #$0, d0
00C07690  ori.b  #$0, d0
00C07694  ori.b  #$0, d0
00C07698  ori.b  #$0, d0
00C0769C  ori.b  #$0, d0
00C076A0  ori.b  #$0, d0
00C076A4  ori.b  #$0, d0
00C076A8  ori.b  #$0, d0
00C076AC  ori.b  #$0, d0
00C076B0  ori.b  #$0, d0
00C076B4  ori.b  #$0, d0
00C076B8  ori.b  #$0, d0
00C076BC  ori.b  #$0, d0
00C076C0  ori.b  #$0, d0
00C076C4  ori.b  #$0, d0
00C076C8  ori.b  #$0, d0
00C076CC  ori.b  #$0, d0
00C076D0  ori.b  #$0, d0
00C076D4  ori.b  #$0, d0
00C076D8  ori.b  #$0, d0
00C076DC  ori.b  #$0, d0
00C076E0  ori.b  #$0, d0
00C076E4  ori.b  #$0, d0
00C076E8  ori.b  #$0, d0
00C076EC  ori.b  #$0, d0
00C076F0  ori.b  #$0, d0
00C076F4  ori.b  #$0, d0
00C076F8  ori.b  #$0, d0
00C076FC  ori.b  #$0, d0
00C07700  ori.b  #$0, d0
00C07704  ori.b  #$0, d0
00C07708  ori.b  #$0, d0
00C0770C  ori.b  #$0, d0
00C07710  ori.b  #$0, d0
00C07714  ori.b  #$0, d0
00C07718  ori.b  #$0, d0
00C0771C  ori.b  #$0, d0
00C07720  ori.b  #$0, d0
00C07724  ori.b  #$0, d0
00C07728  ori.b  #$0, d0
00C0772C  ori.b  #$0, d0
00C07730  ori.b  #$0, d0
00C07734  ori.b  #$0, d0
00C07738  ori.b  #$0, d0
00C0773C  ori.b  #$0, d0
00C07740  ori.b  #$0, d0
00C07744  ori.b  #$0, d0
00C07748  ori.b  #$0, d0
00C0774C  ori.b  #$0, d0
00C07750  ori.b  #$0, d0
00C07754  ori.b  #$0, d0
00C07758  ori.b  #$0, d0
00C0775C  ori.b  #$0, d0
00C07760  ori.b  #$0, d0
00C07764  ori.b  #$0, d0
00C07768  ori.b  #$0, d0
00C0776C  ori.b  #$0, d0
00C07770  ori.b  #$0, d0
00C07774  ori.b  #$0, d0
00C07778  ori.b  #$0, d0
00C0777C  ori.b  #$0, d0
00C07780  ori.b  #$0, d0
00C07784  ori.b  #$0, d0
00C07788  ori.b  #$0, d0
00C0778C  ori.b  #$0, d0
00C07790  ori.b  #$0, d0
00C07794  ori.b  #$0, d0
00C07798  ori.b  #$0, d0
00C0779C  ori.b  #$0, d0
00C077A0  ori.b  #$0, d0
00C077A4  ori.b  #$0, d0
00C077A8  ori.b  #$0, d0
00C077AC  ori.b  #$0, d0
00C077B0  ori.b  #$0, d0
00C077B4  ori.b  #$0, d0
00C077B8  ori.b  #$0, d0
00C077BC  ori.b  #$0, d0
00C077C0  ori.b  #$0, d0
00C077C4  ori.b  #$0, d0
00C077C8  ori.b  #$0, d0
00C077CC  ori.b  #$0, d0
00C077D0  ori.b  #$0, d0
00C077D4  ori.b  #$0, d0
00C077D8  ori.b  #$0, d0
00C077DC  ori.b  #$0, d0
00C077E0  ori.b  #$0, d0
00C077E4  ori.b  #$0, d0
00C077E8  ori.b  #$0, d0
00C077EC  ori.b  #$0, d0
00C077F0  ori.b  #$0, d0
00C077F4  ori.b  #$0, d0
00C077F8  ori.b  #$0, d0
00C077FC  ori.b  #$0, d0
00C07800  ori.b  #$0, d0
00C07804  ori.b  #$0, d0
00C07808  ori.b  #$0, d0
00C0780C  ori.b  #$0, d0
00C07810  ori.b  #$0, d0
00C07814  ori.b  #$0, d0
00C07818  ori.b  #$0, d0
00C0781C  ori.b  #$0, d0
00C07820  ori.b  #$0, d0
00C07824  ori.b  #$0, d0
00C07828  ori.b  #$0, d0
00C0782C  ori.b  #$0, d0
00C07830  ori.b  #$0, d0
00C07834  ori.b  #$0, d0
00C07838  ori.b  #$0, d0
00C0783C  ori.b  #$0, d0
00C07840  ori.b  #$0, d0
00C07844  ori.b  #$0, d0
00C07848  ori.b  #$0, d0
00C0784C  ori.b  #$0, d0
00C07850  ori.b  #$0, d0
00C07854  ori.b  #$0, d0
00C07858  ori.b  #$0, d0
00C0785C  ori.b  #$0, d0
00C07860  ori.b  #$0, d0
00C07864  ori.b  #$0, d0
00C07868  ori.b  #$0, d0
00C0786C  ori.b  #$0, d0
00C07870  ori.b  #$0, d0
00C07874  ori.b  #$0, d0
00C07878  ori.b  #$0, d0
00C0787C  ori.b  #$0, d0
00C07880  ori.b  #$0, d0
00C07884  ori.b  #$0, d0
00C07888  ori.b  #$0, d0
00C0788C  ori.b  #$0, d0
00C07890  ori.b  #$0, d0
00C07894  ori.b  #$0, d0
00C07898  ori.b  #$0, d0
00C0789C  ori.b  #$0, d0
00C078A0  ori.b  #$0, d0
00C078A4  ori.b  #$0, d0
00C078A8  ori.b  #$0, d0
00C078AC  ori.b  #$0, d0
00C078B0  ori.b  #$0, d0
00C078B4  ori.b  #$0, d0
00C078B8  ori.b  #$0, d0
00C078BC  ori.b  #$0, d0
00C078C0  ori.b  #$0, d0
00C078C4  ori.b  #$0, d0
00C078C8  ori.b  #$0, d0
00C078CC  ori.b  #$0, d0
00C078D0  ori.b  #$0, d0
00C078D4  ori.b  #$0, d0
00C078D8  ori.b  #$0, d0
00C078DC  ori.b  #$0, d0
00C078E0  ori.b  #$0, d0
00C078E4  ori.b  #$0, d0
00C078E8  ori.b  #$0, d0
00C078EC  ori.b  #$0, d0
00C078F0  ori.b  #$0, d0
00C078F4  ori.b  #$0, d0
00C078F8  ori.b  #$0, d0
00C078FC  ori.b  #$0, d0
00C07900  ori.b  #$0, d0
00C07904  ori.b  #$0, d0
00C07908  ori.b  #$0, d0
00C0790C  ori.b  #$0, d0
00C07910  ori.b  #$0, d0
00C07914  ori.b  #$0, d0
00C07918  ori.b  #$0, d0
00C0791C  ori.b  #$0, d0
00C07920  ori.b  #$0, d0
00C07924  ori.b  #$0, d0
00C07928  ori.b  #$0, d0
00C0792C  ori.b  #$0, d0
00C07930  ori.b  #$0, d0
00C07934  ori.b  #$0, d0
00C07938  ori.b  #$0, d0
00C0793C  ori.b  #$0, d0
00C07940  ori.b  #$0, d0
00C07944  ori.b  #$0, d0
00C07948  ori.b  #$0, d0
00C0794C  ori.b  #$0, d0
00C07950  ori.b  #$0, d0
00C07954  ori.b  #$0, d0
00C07958  ori.b  #$0, d0
00C0795C  ori.b  #$0, d0
00C07960  ori.b  #$0, d0
00C07964  ori.b  #$0, d0
00C07968  ori.b  #$0, d0
00C0796C  ori.b  #$0, d0
00C07970  ori.b  #$0, d0
00C07974  ori.b  #$0, d0
00C07978  ori.b  #$0, d0
00C0797C  ori.b  #$0, d0
00C07980  ori.b  #$0, d0
00C07984  ori.b  #$0, d0
00C07988  ori.b  #$0, d0
00C0798C  ori.b  #$0, d0
00C07990  ori.b  #$0, d0
00C07994  ori.b  #$0, d0
00C07998  ori.b  #$0, d0
00C0799C  ori.b  #$0, d0
00C079A0  ori.b  #$0, d0
00C079A4  ori.b  #$0, d0
00C079A8  ori.b  #$0, d0
00C079AC  ori.b  #$0, d0
00C079B0  ori.b  #$0, d0
00C079B4  ori.b  #$0, d0
00C079B8  ori.b  #$0, d0
00C079BC  ori.b  #$0, d0
00C079C0  ori.b  #$0, d0
00C079C4  ori.b  #$0, d0
00C079C8  ori.b  #$0, d0
00C079CC  ori.b  #$0, d0
00C079D0  ori.b  #$0, d0
00C079D4  ori.b  #$0, d0
00C079D8  ori.b  #$0, d0
00C079DC  ori.b  #$0, d0
00C079E0  ori.b  #$0, d0
00C079E4  ori.b  #$0, d0
00C079E8  ori.b  #$0, d0
00C079EC  ori.b  #$0, d0
00C079F0  ori.b  #$0, d0
00C079F4  ori.b  #$0, d0
00C079F8  ori.b  #$0, d0
00C079FC  ori.b  #$0, d0
00C07A00  ori.b  #$0, d0
00C07A04  ori.b  #$0, d0
00C07A08  ori.b  #$0, d0
00C07A0C  ori.b  #$0, d0
00C07A10  ori.b  #$0, d0
00C07A14  ori.b  #$0, d0
00C07A18  ori.b  #$0, d0
00C07A1C  ori.b  #$0, d0
00C07A20  ori.b  #$0, d0
00C07A24  ori.b  #$0, d0
00C07A28  ori.b  #$0, d0
00C07A2C  ori.b  #$0, d0
00C07A30  ori.b  #$0, d0
00C07A34  ori.b  #$0, d0
00C07A38  ori.b  #$0, d0
00C07A3C  ori.b  #$0, d0
00C07A40  ori.b  #$0, d0
00C07A44  ori.b  #$0, d0
00C07A48  ori.b  #$0, d0
00C07A4C  ori.b  #$0, d0
00C07A50  ori.b  #$0, d0
00C07A54  ori.b  #$0, d0
00C07A58  ori.b  #$0, d0
00C07A5C  ori.b  #$0, d0
00C07A60  ori.b  #$0, d0
00C07A64  ori.b  #$0, d0
00C07A68  ori.b  #$0, d0
00C07A6C  ori.b  #$0, d0
00C07A70  ori.b  #$0, d0
00C07A74  ori.b  #$0, d0
00C07A78  ori.b  #$0, d0
00C07A7C  ori.b  #$0, d0
00C07A80  ori.b  #$0, d0
00C07A84  ori.b  #$0, d0
00C07A88  ori.b  #$0, d0
00C07A8C  ori.b  #$0, d0
00C07A90  ori.b  #$0, d0
00C07A94  ori.b  #$0, d0
00C07A98  ori.b  #$0, d0
00C07A9C  ori.b  #$0, d0
00C07AA0  ori.b  #$0, d0
00C07AA4  ori.b  #$0, d0
00C07AA8  ori.b  #$0, d0
00C07AAC  ori.b  #$0, d0
00C07AB0  ori.b  #$0, d0
00C07AB4  ori.b  #$0, d0
00C07AB8  ori.b  #$0, d0
00C07ABC  ori.b  #$0, d0
00C07AC0  ori.b  #$0, d0
00C07AC4  ori.b  #$0, d0
00C07AC8  ori.b  #$0, d0
00C07ACC  ori.b  #$0, d0
00C07AD0  ori.b  #$0, d0
00C07AD4  ori.b  #$0, d0
00C07AD8  ori.b  #$0, d0
00C07ADC  ori.b  #$0, d0
00C07AE0  ori.b  #$0, d0
00C07AE4  ori.b  #$0, d0
00C07AE8  ori.b  #$0, d0
00C07AEC  ori.b  #$0, d0
00C07AF0  ori.b  #$0, d0
00C07AF4  ori.b  #$0, d0
00C07AF8  ori.b  #$0, d0
00C07AFC  ori.b  #$0, d0
00C07B00  ori.b  #$0, d0
00C07B04  ori.b  #$0, d0
00C07B08  ori.b  #$0, d0
00C07B0C  ori.b  #$0, d0
00C07B10  ori.b  #$0, d0
00C07B14  ori.b  #$0, d0
00C07B18  ori.b  #$0, d0
00C07B1C  ori.b  #$0, d0
00C07B20  ori.b  #$0, d0
00C07B24  ori.b  #$0, d0
00C07B28  ori.b  #$0, d0
00C07B2C  ori.b  #$0, d0
00C07B30  ori.b  #$0, d0
00C07B34  ori.b  #$0, d0
00C07B38  ori.b  #$0, d0
00C07B3C  ori.b  #$0, d0
00C07B40  ori.b  #$0, d0
00C07B44  ori.b  #$0, d0
00C07B48  ori.b  #$0, d0
00C07B4C  ori.b  #$0, d0
00C07B50  ori.b  #$0, d0
00C07B54  ori.b  #$0, d0
00C07B58  ori.b  #$0, d0
00C07B5C  ori.b  #$0, d0
00C07B60  ori.b  #$0, d0
00C07B64  ori.b  #$0, d0
00C07B68  ori.b  #$0, d0
00C07B6C  ori.b  #$0, d0
00C07B70  ori.b  #$0, d0
00C07B74  ori.b  #$0, d0
00C07B78  ori.b  #$0, d0
00C07B7C  ori.b  #$0, d0
00C07B80  ori.b  #$0, d0
00C07B84  ori.b  #$0, d0
00C07B88  ori.b  #$0, d0
00C07B8C  ori.b  #$0, d0
00C07B90  ori.b  #$0, d0
00C07B94  ori.b  #$0, d0
00C07B98  ori.b  #$0, d0
00C07B9C  ori.b  #$0, d0
00C07BA0  ori.b  #$0, d0
00C07BA4  ori.b  #$0, d0
00C07BA8  ori.b  #$0, d0
00C07BAC  ori.b  #$0, d0
00C07BB0  ori.b  #$0, d0
00C07BB4  ori.b  #$0, d0
00C07BB8  ori.b  #$0, d0
00C07BBC  ori.b  #$0, d0
00C07BC0  ori.b  #$0, d0
00C07BC4  ori.b  #$0, d0
00C07BC8  ori.b  #$0, d0
00C07BCC  ori.b  #$0, d0
00C07BD0  ori.b  #$0, d0
00C07BD4  ori.b  #$0, d0
00C07BD8  ori.b  #$0, d0
00C07BDC  ori.b  #$0, d0
00C07BE0  ori.b  #$0, d0
00C07BE4  ori.b  #$0, d0
00C07BE8  ori.b  #$0, d0
00C07BEC  ori.b  #$0, d0
00C07BF0  ori.b  #$0, d0
00C07BF4  ori.b  #$0, d0
00C07BF8  ori.b  #$0, d0
00C07BFC  ori.b  #$0, d0
00C07C00  ori.b  #$0, d0
00C07C04  ori.b  #$0, d0
00C07C08  ori.b  #$0, d0
00C07C0C  ori.b  #$0, d0
00C07C10  ori.b  #$0, d0
00C07C14  ori.b  #$0, d0
00C07C18  ori.b  #$0, d0
00C07C1C  ori.b  #$0, d0
00C07C20  ori.b  #$0, d0
00C07C24  ori.b  #$0, d0
00C07C28  ori.b  #$0, d0
00C07C2C  ori.b  #$0, d0
00C07C30  ori.b  #$0, d0
00C07C34  ori.b  #$0, d0
00C07C38  ori.b  #$0, d0
00C07C3C  ori.b  #$0, d0
00C07C40  ori.b  #$0, d0
00C07C44  ori.b  #$0, d0
00C07C48  ori.b  #$0, d0
00C07C4C  ori.b  #$0, d0
00C07C50  ori.b  #$0, d0
00C07C54  ori.b  #$0, d0
00C07C58  ori.b  #$0, d0
00C07C5C  ori.b  #$0, d0
00C07C60  ori.b  #$0, d0
00C07C64  ori.b  #$0, d0
00C07C68  ori.b  #$0, d0
00C07C6C  ori.b  #$0, d0
00C07C70  ori.b  #$0, d0
00C07C74  ori.b  #$0, d0
00C07C78  ori.b  #$0, d0
00C07C7C  ori.b  #$0, d0
00C07C80  ori.b  #$0, d0
00C07C84  ori.b  #$0, d0
00C07C88  ori.b  #$0, d0
00C07C8C  ori.b  #$0, d0
00C07C90  ori.b  #$0, d0
00C07C94  ori.b  #$0, d0
00C07C98  ori.b  #$0, d0
00C07C9C  ori.b  #$0, d0
00C07CA0  ori.b  #$0, d0
00C07CA4  ori.b  #$0, d0
00C07CA8  ori.b  #$0, d0
00C07CAC  ori.b  #$0, d0
00C07CB0  ori.b  #$0, d0
00C07CB4  ori.b  #$0, d0
00C07CB8  ori.b  #$0, d0
00C07CBC  ori.b  #$0, d0
00C07CC0  ori.b  #$0, d0
00C07CC4  ori.b  #$0, d0
00C07CC8  ori.b  #$0, d0
00C07CCC  ori.b  #$0, d0
00C07CD0  ori.b  #$0, d0
00C07CD4  ori.b  #$0, d0
00C07CD8  ori.b  #$0, d0
00C07CDC  ori.b  #$0, d0
00C07CE0  ori.b  #$0, d0
00C07CE4  ori.b  #$0, d0
00C07CE8  ori.b  #$0, d0
00C07CEC  ori.b  #$0, d0
00C07CF0  ori.b  #$0, d0
00C07CF4  ori.b  #$0, d0
00C07CF8  ori.b  #$0, d0
00C07CFC  ori.b  #$0, d0
00C07D00  ori.b  #$0, d0
00C07D04  ori.b  #$0, d0
00C07D08  ori.b  #$0, d0
00C07D0C  ori.b  #$0, d0
00C07D10  ori.b  #$0, d0
00C07D14  ori.b  #$0, d0
00C07D18  ori.b  #$0, d0
00C07D1C  ori.b  #$0, d0
00C07D20  ori.b  #$0, d0
00C07D24  ori.b  #$0, d0
00C07D28  ori.b  #$0, d0
00C07D2C  ori.b  #$0, d0
00C07D30  ori.b  #$0, d0
00C07D34  ori.b  #$0, d0
00C07D38  ori.b  #$0, d0
00C07D3C  ori.b  #$0, d0
00C07D40  ori.b  #$0, d0
00C07D44  ori.b  #$0, d0
00C07D48  ori.b  #$0, d0
00C07D4C  ori.b  #$0, d0
00C07D50  ori.b  #$0, d0
00C07D54  ori.b  #$0, d0
00C07D58  ori.b  #$0, d0
00C07D5C  ori.b  #$0, d0
00C07D60  ori.b  #$0, d0
00C07D64  ori.b  #$0, d0
00C07D68  ori.b  #$0, d0
00C07D6C  ori.b  #$0, d0
00C07D70  ori.b  #$0, d0
00C07D74  ori.b  #$0, d0
00C07D78  ori.b  #$0, d0
00C07D7C  ori.b  #$0, d0
00C07D80  ori.b  #$0, d0
00C07D84  ori.b  #$0, d0
00C07D88  ori.b  #$0, d0
00C07D8C  ori.b  #$0, d0
00C07D90  ori.b  #$0, d0
00C07D94  ori.b  #$0, d0
00C07D98  ori.b  #$0, d0
00C07D9C  ori.b  #$0, d0
00C07DA0  ori.b  #$0, d0
00C07DA4  ori.b  #$0, d0
00C07DA8  ori.b  #$0, d0
00C07DAC  ori.b  #$0, d0
00C07DB0  ori.b  #$0, d0
00C07DB4  ori.b  #$0, d0
00C07DB8  ori.b  #$0, d0
00C07DBC  ori.b  #$0, d0
00C07DC0  ori.b  #$0, d0
00C07DC4  ori.b  #$0, d0
00C07DC8  ori.b  #$0, d0
00C07DCC  ori.b  #$0, d0
00C07DD0  ori.b  #$0, d0
00C07DD4  ori.b  #$0, d0
00C07DD8  ori.b  #$0, d0
00C07DDC  ori.b  #$0, d0
00C07DE0  ori.b  #$0, d0
00C07DE4  ori.b  #$0, d0
00C07DE8  ori.b  #$0, d0
00C07DEC  ori.b  #$0, d0
00C07DF0  ori.b  #$0, d0
00C07DF4  ori.b  #$0, d0
00C07DF8  ori.b  #$0, d0
00C07DFC  ori.b  #$0, d0
00C07E00  ori.b  #$0, d0
00C07E04  ori.b  #$0, d0
00C07E08  ori.b  #$0, d0
00C07E0C  ori.b  #$0, d0
00C07E10  ori.b  #$0, d0
00C07E14  ori.b  #$0, d0
00C07E18  ori.b  #$0, d0
00C07E1C  ori.b  #$0, d0
00C07E20  ori.b  #$0, d0
00C07E24  ori.b  #$0, d0
00C07E28  ori.b  #$0, d0
00C07E2C  ori.b  #$0, d0
00C07E30  ori.b  #$0, d0
00C07E34  ori.b  #$0, d0
00C07E38  ori.b  #$0, d0
00C07E3C  ori.b  #$0, d0
00C07E40  ori.b  #$0, d0
00C07E44  ori.b  #$0, d0
00C07E48  ori.b  #$0, d0
00C07E4C  ori.b  #$0, d0
00C07E50  ori.b  #$0, d0
00C07E54  ori.b  #$0, d0
00C07E58  ori.b  #$0, d0
00C07E5C  ori.b  #$0, d0
00C07E60  ori.b  #$0, d0
00C07E64  ori.b  #$0, d0
00C07E68  ori.b  #$0, d0
00C07E6C  ori.b  #$0, d0
00C07E70  ori.b  #$0, d0
00C07E74  ori.b  #$0, d0
00C07E78  ori.b  #$0, d0
00C07E7C  ori.b  #$0, d0
00C07E80  ori.b  #$0, d0
00C07E84  ori.b  #$0, d0
00C07E88  ori.b  #$0, d0
00C07E8C  ori.b  #$0, d0
00C07E90  ori.b  #$0, d0
00C07E94  ori.b  #$0, d0
00C07E98  ori.b  #$0, d0
00C07E9C  ori.b  #$0, d0
00C07EA0  ori.b  #$0, d0
00C07EA4  ori.b  #$0, d0
00C07EA8  ori.b  #$0, d0
00C07EAC  ori.b  #$0, d0
00C07EB0  ori.b  #$0, d0
00C07EB4  ori.b  #$0, d0
00C07EB8  ori.b  #$0, d0
00C07EBC  ori.b  #$0, d0
00C07EC0  ori.b  #$0, d0
00C07EC4  ori.b  #$0, d0
00C07EC8  ori.b  #$0, d0
00C07ECC  ori.b  #$0, d0
00C07ED0  ori.b  #$0, d0
00C07ED4  ori.b  #$0, d0
00C07ED8  ori.b  #$0, d0
00C07EDC  ori.b  #$0, d0
00C07EE0  ori.b  #$0, d0
00C07EE4  ori.b  #$0, d0
00C07EE8  ori.b  #$0, d0
00C07EEC  ori.b  #$0, d0
00C07EF0  ori.b  #$0, d0
00C07EF4  ori.b  #$0, d0
00C07EF8  ori.b  #$0, d0
00C07EFC  ori.b  #$0, d0
00C07F00  ori.b  #$0, d0
00C07F04  ori.b  #$0, d0
00C07F08  ori.b  #$0, d0
00C07F0C  ori.b  #$0, d0
00C07F10  ori.b  #$0, d0
00C07F14  ori.b  #$0, d0
00C07F18  ori.b  #$0, d0
00C07F1C  ori.b  #$0, d0
00C07F20  ori.b  #$0, d0
00C07F24  ori.b  #$0, d0
00C07F28  ori.b  #$0, d0
00C07F2C  ori.b  #$0, d0
00C07F30  ori.b  #$0, d0
00C07F34  ori.b  #$0, d0
00C07F38  ori.b  #$0, d0
00C07F3C  ori.b  #$0, d0
00C07F40  ori.b  #$0, d0
00C07F44  ori.b  #$0, d0
00C07F48  ori.b  #$0, d0
00C07F4C  ori.b  #$0, d0
00C07F50  ori.b  #$0, d0
00C07F54  ori.b  #$0, d0
00C07F58  ori.b  #$0, d0
00C07F5C  ori.b  #$0, d0
00C07F60  ori.b  #$0, d0
00C07F64  ori.b  #$0, d0
00C07F68  ori.b  #$0, d0
00C07F6C  ori.b  #$0, d0
00C07F70  ori.b  #$0, d0
00C07F74  ori.b  #$0, d0
00C07F78  ori.b  #$0, d0
00C07F7C  ori.b  #$0, d0
00C07F80  ori.b  #$0, d0
00C07F84  ori.b  #$0, d0
00C07F88  ori.b  #$0, d0
00C07F8C  ori.b  #$0, d0
00C07F90  ori.b  #$0, d0
00C07F94  ori.b  #$0, d0
00C07F98  ori.b  #$0, d0
00C07F9C  ori.b  #$0, d0
00C07FA0  ori.b  #$0, d0
00C07FA4  ori.b  #$0, d0
00C07FA8  ori.b  #$0, d0
00C07FAC  ori.b  #$0, d0
00C07FB0  ori.b  #$0, d0
00C07FB4  ori.b  #$0, d0
00C07FB8  ori.b  #$0, d0
00C07FBC  ori.b  #$0, d0
00C07FC0  ori.b  #$0, d0
00C07FC4  ori.b  #$0, d0
00C07FC8  ori.b  #$0, d0
00C07FCC  ori.b  #$0, d0
00C07FD0  ori.b  #$0, d0
00C07FD4  ori.b  #$0, d0
00C07FD8  ori.b  #$0, d0
00C07FDC  ori.b  #$0, d0
00C07FE0  ori.b  #$0, d0
00C07FE4  ori.b  #$0, d0
00C07FE8  ori.b  #$0, d0
00C07FEC  ori.b  #$0, d0
00C07FF0  ori.b  #$0, d0
00C07FF4  ori.b  #$0, d0
00C07FF8  ori.b  #$0, d0
00C07FFC  ori.b  #$0, d0
00C08000  ori.b  #$0, d0
00C08004  ori.b  #$0, d0
00C08008  ori.b  #$0, d0
00C0800C  ori.b  #$0, d0
00C08010  ori.b  #$0, d0
00C08014  ori.b  #$0, d0
00C08018  ori.b  #$0, d0
00C0801C  ori.b  #$0, d0
00C08020  ori.b  #$0, d0
00C08024  ori.b  #$0, d0
00C08028  ori.b  #$0, d0
00C0802C  ori.b  #$0, d0
00C08030  ori.b  #$0, d0
00C08034  ori.b  #$0, d0
00C08038  ori.b  #$0, d0
00C0803C  ori.b  #$0, d0
00C08040  ori.b  #$0, d0
00C08044  ori.b  #$0, d0
00C08048  ori.b  #$0, d0
00C0804C  ori.b  #$0, d0
00C08050  ori.b  #$0, d0
00C08054  ori.b  #$0, d0
00C08058  ori.b  #$0, d0
00C0805C  ori.b  #$0, d0
00C08060  ori.b  #$0, d0
00C08064  ori.b  #$0, d0
00C08068  ori.b  #$0, d0
00C0806C  ori.b  #$0, d0
00C08070  ori.b  #$0, d0
00C08074  ori.b  #$0, d0
00C08078  ori.b  #$0, d0
00C0807C  ori.b  #$0, d0
00C08080  ori.b  #$0, d0
00C08084  ori.b  #$0, d0
00C08088  ori.b  #$0, d0
00C0808C  ori.b  #$0, d0
00C08090  ori.b  #$0, d0
00C08094  ori.b  #$0, d0
00C08098  ori.b  #$0, d0
00C0809C  ori.b  #$0, d0
00C080A0  ori.b  #$0, d0
00C080A4  ori.b  #$0, d0
00C080A8  ori.b  #$0, d0
00C080AC  ori.b  #$0, d0
00C080B0  ori.b  #$0, d0
00C080B4  ori.b  #$0, d0
00C080B8  ori.b  #$0, d0
00C080BC  ori.b  #$0, d0
00C080C0  ori.b  #$0, d0
00C080C4  ori.b  #$0, d0
00C080C8  ori.b  #$0, d0
00C080CC  ori.b  #$0, d0
00C080D0  ori.b  #$0, d0
00C080D4  ori.b  #$0, d0
00C080D8  ori.b  #$0, d0
00C080DC  ori.b  #$0, d0
00C080E0  ori.b  #$0, d0
00C080E4  ori.b  #$0, d0
00C080E8  ori.b  #$0, d0
00C080EC  ori.b  #$0, d0
00C080F0  ori.b  #$0, d0
00C080F4  ori.b  #$0, d0
00C080F8  ori.b  #$0, d0
00C080FC  ori.b  #$0, d0
00C08100  ori.b  #$0, d0
00C08104  ori.b  #$0, d0
00C08108  ori.b  #$0, d0
00C0810C  ori.b  #$0, d0
00C08110  ori.b  #$0, d0
00C08114  ori.b  #$0, d0
00C08118  ori.b  #$0, d0
00C0811C  ori.b  #$0, d0
00C08120  ori.b  #$0, d0
00C08124  ori.b  #$0, d0
00C08128  ori.b  #$0, d0
00C0812C  ori.b  #$0, d0
00C08130  ori.b  #$0, d0
00C08134  ori.b  #$0, d0
00C08138  ori.b  #$0, d0
00C0813C  ori.b  #$0, d0
00C08140  ori.b  #$0, d0
00C08144  ori.b  #$0, d0
00C08148  ori.b  #$0, d0
00C0814C  ori.b  #$0, d0
00C08150  ori.b  #$0, d0
00C08154  ori.b  #$0, d0
00C08158  ori.b  #$0, d0
00C0815C  ori.b  #$0, d0
00C08160  ori.b  #$0, d0
00C08164  ori.b  #$0, d0
00C08168  ori.b  #$0, d0
00C0816C  ori.b  #$0, d0
00C08170  ori.b  #$0, d0
00C08174  ori.b  #$0, d0
00C08178  ori.b  #$0, d0
00C0817C  ori.b  #$0, d0
00C08180  ori.b  #$0, d0
00C08184  ori.b  #$0, d0
00C08188  ori.b  #$0, d0
00C0818C  ori.b  #$0, d0
00C08190  ori.b  #$0, d0
00C08194  ori.b  #$0, d0
00C08198  ori.b  #$0, d0
00C0819C  ori.b  #$0, d0
00C081A0  ori.b  #$0, d0
00C081A4  ori.b  #$0, d0
00C081A8  ori.b  #$0, d0
00C081AC  ori.b  #$0, d0
00C081B0  ori.b  #$0, d0
00C081B4  ori.b  #$0, d0
00C081B8  ori.b  #$0, d0
00C081BC  ori.b  #$0, d0
00C081C0  ori.b  #$0, d0
00C081C4  ori.b  #$0, d0
00C081C8  ori.b  #$0, d0
00C081CC  ori.b  #$0, d0
00C081D0  ori.b  #$0, d0
00C081D4  ori.b  #$0, d0
00C081D8  ori.b  #$0, d0
00C081DC  ori.b  #$0, d0
00C081E0  ori.b  #$0, d0
00C081E4  ori.b  #$0, d0
00C081E8  ori.b  #$0, d0
00C081EC  ori.b  #$0, d0
00C081F0  ori.b  #$0, d0
00C081F4  ori.b  #$0, d0
00C081F8  ori.b  #$0, d0
00C081FC  ori.b  #$0, d0
00C08200  ori.b  #$0, d0
00C08204  ori.b  #$0, d0
00C08208  ori.b  #$0, d0
00C0820C  ori.b  #$0, d0
00C08210  ori.b  #$0, d0
00C08214  ori.b  #$0, d0
00C08218  ori.b  #$0, d0
00C0821C  ori.b  #$0, d0
00C08220  ori.b  #$0, d0
00C08224  ori.b  #$0, d0
00C08228  ori.b  #$0, d0
00C0822C  ori.b  #$0, d0
00C08230  ori.b  #$0, d0
00C08234  ori.b  #$0, d0
00C08238  ori.b  #$0, d0
00C0823C  ori.b  #$0, d0
00C08240  ori.b  #$0, d0
00C08244  ori.b  #$0, d0
00C08248  ori.b  #$0, d0
00C0824C  ori.b  #$0, d0
00C08250  ori.b  #$0, d0
00C08254  ori.b  #$0, d0
00C08258  or.l   d0, d0
00C0825A  or.b   (a0), d2
00C0825C  ; data: 0x88, 0x88
00C0825E  sub.b  d0, -(a4)
00C08260  sub.l  (a2), d1
00C08262  ; data: 0xaa, 0x54
00C08264  ; data: 0xaa, 0xaa
00C08266  ; data: 0xab, 0xaa
00C08268  cmp.l  $c03e18(pc), d5
00C0826C  ; data: 0xbb, 0xbb
00C0826E  adda.w ([$1]), a7
00C08274  ; data: 0xff, 0xfe
00C08276  ori.b  #$fc, d3
00C0827A  ori.b  #$f8, d7
00C0827E  ; data: 0x00, 0x0f
00C08280  ; data: 0xff, 0xf0
00C08282  ori.b  #$e0, (a7)+
00C08286  ; data: 0x00, 0x3f
00C08288  ; data: 0xff, 0xc0
00C0828A  ; data: 0x00, 0x7f
00C0828C  ; data: 0xff, 0x80
00C0828E  ; data: 0x00, 0xff
00C08290  ; data: 0xff, 0x00
00C08292  ; data: 0x01, 0xff
00C08294  dc.w   $fe00
00C08296  ; data: 0x03, 0xff
00C08298  dc.w   $fc00
00C0829A  ; data: 0x07, 0xff
00C0829C  dc.w   $f800
00C0829E  ; data: 0x0f, 0xff
00C082A0  dc.w   $f000
00C082A2  ; data: 0x1f, 0xff
00C082A4  asr.b  #$8, d0
00C082A6  ; data: 0x3f, 0xff
00C082A8  and.b  d0, d0
00C082AA  ; data: 0x7f, 0xff
00C082AC  or.b   d0, d0
00C082AE  ; data: 0xff, 0xff
00C082B0  ori.b  #$79, d0
00C082B4  ori.b  #$88, d0
00C082B8  cmpi.w #$8, $2488.l
00C082C0  bne.b  $c082c8
00C082C2  clr.w  $2488.l
00C082C8  lea.l  $248a.l, a0
00C082CE  adda.w $2488.l, a0
00C082D4  move.l (a0)+, d3
00C082D6  move.l (a0), $2480.l
00C082DC  move.w (a6), d0
00C082DE  lsr.w  #$1, d0
00C082E0  move.w $2(a6), d1
00C082E4  sub.w  d0, d1
00C082E6  move.w d1, d2
00C082E8  lsr.w  #$4, d1
00C082EA  add.w  d1, d1
00C082EC  andi.w #$f, d2
00C082F0  move.w $4(a6), d0
00C082F4  lsr.w  #$1, d0
00C082F6  move.w $6(a6), d5
00C082FA  sub.w  d0, d5
00C082FC  move.w d5, d4
00C082FE  lsr.w  #$4, d5
00C08300  add.w  d5, d5
00C08302  andi.w #$f, d4
00C08306  lsl.w  #$4, d4
00C08308  or.w   d4, d2
00C0830A  move.w d2, $1a.l
00C08310  lea.l  $68.l, a0
00C08316  move.l d3, d0
00C08318  sub.w  d1, d0
00C0831A  move.w d0, $6(a0)
00C0831E  swap   d0
00C08320  move.w d0, $2(a0)
00C08324  swap   d0
00C08326  addi.l #$28, d0
00C0832C  move.w d0, $16(a0)
00C08330  swap   d0
00C08332  move.w d0, $12(a0)
00C08336  swap   d0
00C08338  addi.l #$28, d0
00C0833E  move.w d0, $26(a0)
00C08342  swap   d0
00C08344  move.w d0, $22(a0)
00C08348  swap   d0
00C0834A  move.l d3, d0
00C0834C  addi.l #$4bf0, d0
00C08352  sub.w  d5, d0
00C08354  move.w d0, $e(a0)
00C08358  swap   d0
00C0835A  move.w d0, $a(a0)
00C0835E  swap   d0
00C08360  addi.l #$28, d0
00C08366  move.w d0, $1e(a0)
00C0836A  swap   d0
00C0836C  move.w d0, $1a(a0)
00C08370  rts    
00C08372  ori.b  #$0, d0
00C08376  ori.b  #$0, d0
00C0837A  ori.b  #$0, d0
00C0837E  ori.b  #$0, d0
00C08382  ori.b  #$0, d0
00C08386  ori.b  #$79, d0
00C0838A  ori.b  #$de, d0
00C0838E  cmpi.w #$c, $24de.l
00C08396  bne.b  $c0839e
00C08398  clr.w  $24de.l
00C0839E  lea.l  $24e0.l, a0
00C083A4  adda.w $24de.l, a0
00C083AA  move.l (a0)+, d0
00C083AC  move.l (a0)+, $24d6.l
00C083B2  move.l (a0), $24da.l
00C083B8  lea.l  $e6.l, a0
00C083BE  move.w d0, $4(a0)
00C083C2  swap   d0
00C083C4  move.w d0, (a0)
00C083C6  rts    
00C083C8  ori.b  #$0, d0
00C083CC  ori.b  #$0, d0
00C083D0  ori.b  #$0, d0
00C083D4  btst.l d0, d0
00C083D6  ori.b  #$94, d0
00C083DA  ori.b  #$28, d0
00C083DE  ori.b  #$0, d0
00C083E2  ori.b  #$94, d0
00C083E6  ori.b  #$28, d0
00C083EA  btst.b #$6, (a4)
00C083EE  bne.b  $c083ea
00C083F0  move.l #$ffffffff, $42(a4)
00C083F8  move.l #$1000000, $3e(a4)
00C08400  clr.w  $64(a4)
00C08404  move.l $2480.l, $52(a4)
00C0840C  move.w #$cbd4, $56(a4)
00C08412  rts    
00C08414  tst.w  $25d4.l
00C0841A  beq.b  $c08426
00C0841C  subq.w #$1, $25d4.l
00C08422  bra.w  $c084b8
00C08426  move.w $c084c4(pc), $25d4.l
00C0842E  tst.b  $25d0.l
00C08434  bne.b  $c0843a
00C08436  bra.w  $c084b8
00C0843A  subq.b #$1, $25d0.l
00C08440  movea.l $c084be(pc), a1
00C08444  movea.l $c084ba(pc), a0
00C08448  lea.l  $2(a0), a0
00C0844C  move.w $25d6.l, d4
00C08452  subq.w #$1, d4
00C08454  move.w (a0), d0
00C08456  move.w (a1)+, d2
00C08458  move.w d0, d1
00C0845A  move.w d2, d3
00C0845C  andi.w #$f, d1
00C08460  andi.w #$f, d3
00C08464  cmp.w  d1, d3
00C08466  beq.b  $c08470
00C08468  blt.b  $c0846e
00C0846A  addq.w #$1, (a0)
00C0846C  bra.b  $c08470
00C0846E  subq.w #$1, (a0)
00C08470  move.w d0, d1
00C08472  move.w d2, d3
00C08474  lsr.w  #$4, d1
00C08476  lsr.w  #$4, d3
00C08478  andi.w #$f, d1
00C0847C  andi.w #$f, d3
00C08480  cmp.w  d1, d3
00C08482  beq.b  $c08490
00C08484  blt.b  $c0848c
00C08486  addi.w #$10, (a0)
00C0848A  bra.b  $c08490
00C0848C  subi.w #$10, (a0)
00C08490  move.w d0, d1
00C08492  move.w d2, d3
00C08494  lsr.w  #$8, d1
00C08496  lsr.w  #$8, d3
00C08498  andi.w #$f, d1
00C0849C  andi.w #$f, d3
00C084A0  cmp.w  d1, d3
00C084A2  beq.b  $c084b0
00C084A4  blt.b  $c084ac
00C084A6  addi.w #$100, (a0)
00C084AA  bra.b  $c084b0
00C084AC  subi.w #$100, (a0)
00C084B0  lea.l  $4(a0), a0
00C084B4  dbra   d4, $c08454
00C084B8  rts    
00C084BA  ori.b  #$0, d0
00C084BE  ori.b  #$0, d0
00C084C2  ori.b  #$0, d0
00C084C6  ori.b  #$0, d0
00C084CA  ori.b  #$30, d0
00C084CE  ; data: 0x08, 0x5f
00C084D0  ; data: 0x0c, 0x8c
00C084D2  move.b -$27(a5, d1.w), (a0)
00C084D6  move.b $1d10.w, (a4)+
00C084DA  move.l -(a0), -(a0)
00C084DC  move.l -(a7), -(a2)
00C084DE  move.l -(a4), -(a4)
00C084E0  move.l (a6), -(a6)
00C084E2  move.w $c084b7(pc, d3.w), (a0)+
00C084E6  move.w (a4)+, (a4)
00C084E8  movea.w (a6), a6
00C084EA  ; data: 0x3f, 0xff
00C084EC  chk.w  (a7), d1
00C084EE  dc.w   $471c
00C084F0  dc.w   $4a8e
00C084F2  lea.l  $5133(a3), a6
00C084F6  addq.w #$2, -(a4)
00C084F8  ; data: 0x57, 0x7f
00C084FA  addq.l #$5, d1
00C084FC  subq.w #$6, $603b(a3)
00C08500  bhi.b  $c084f3
00C08502  bcs.b  $c0848f
00C08504  bvc.b  $c08510
00C08506  bpl.b  $c08574
00C08508  bge.b  $c084bb
00C0850A  bgt.b  $c084e5
00C0850C  moveq  #$e1, d0
00C0850E  moveq  #$cb, d1
00C08510  moveq  #$96, d2
00C08512  moveq  #$40, d3
00C08514  ; data: 0x77, 0xca
00C08516  ; data: 0x79, 0x34
00C08518  moveq  #$7c, d5
00C0851A  ; data: 0x7b, 0xa2
00C0851C  moveq  #$a7, d6
00C0851E  ; data: 0x7d, 0x89
00C08520  moveq  #$49, d7
00C08522  moveq  #$e6, d7
00C08524  ; data: 0x7f, 0x61
00C08526  ; data: 0x7f, 0xb9
00C08528  ; data: 0x7f, 0xed
00C0852A  ; data: 0x7f, 0xff
00C0852C  ; data: 0x7f, 0xee
00C0852E  ; data: 0x7f, 0xb9
00C08530  ; data: 0x7f, 0x61
00C08532  moveq  #$e7, d7
00C08534  moveq  #$4a, d7
00C08536  ; data: 0x7d, 0x8a
00C08538  moveq  #$a7, d6
00C0853A  ; data: 0x7b, 0xa3
00C0853C  moveq  #$7d, d5
00C0853E  ; data: 0x79, 0x35
00C08540  ; data: 0x77, 0xcb
00C08542  moveq  #$41, d3
00C08544  moveq  #$97, d2
00C08546  moveq  #$cd, d1
00C08548  moveq  #$e3, d0
00C0854A  bgt.b  $c08526
00C0854C  bge.b  $c08501
00C0854E  bpl.b  $c085be
00C08550  bvc.b  $c0855e
00C08552  bcs.b  $c084e1
00C08554  bhi.b  $c08549
00C08556  bra.b  $c08595
00C08558  subq.w #$6, $5a83(a5)
00C0855C  subq.l #$3, d1
00C0855E  addq.w #$2, -(a7)
00C08560  subq.b #$8, ([$4a90])
00C08566  dc.w   $471e
00C08568  chk.w  (a1)+, d1
00C0856A  negx.b d2
00C0856C  movea.w (a1)+, a6
00C0856E  move.w (a7)+, (a4)
00C08570  move.w (a6), (a2)+
00C08572  ; data: 0x30, 0xfe
00C08574  move.l (a1)+, -(a6)
00C08576  move.l -(a7), -(a4)
00C08578  move.l $2123(a2), -(a2)
00C0857C  move.b (a3), -(a6)
00C0857E  move.b $c0855c(pc, d1.w), (a4)+
00C08582  move.b $c8f.w, (a0)
00C08586  ; data: 0x08, 0x62
00C08588  subi.b #$3, ([], $f7a4f377)
00C08592  lsl.w  #$7, d6
00C08594  lsl.b  d5, d2
00C08596  lsl.b  #$3, d3
00C08598  lsr.w  -$1e(a3, a5.l)
00C0859C  adda.w (a3)+, a5
00C0859E  adda.w (a7)+, a3
00C085A0  adda.w -$30f8(a5), a1
00C085A4  and.b  d5, ([$c3ad, a0])
00C085AA  and.b  d4, d0
00C085AC  cmp.w  -$4719(a4), d6
00C085B0  eor.w  d2, $18(a5, a3.w)
00C085B4  ; data: 0xae, 0xd0
00C085B6  ; data: 0xab, 0x9e
00C085B8  ; data: 0xa8, 0x83
00C085BA  ; data: 0xa5, 0x81
00C085BC  ; data: 0xa2, 0x97
00C085BE  suba.l d7, a7
00C085C0  sub.b  d6, (a1)
00C085C2  sub.w  $95959350(invalid.w), d5
00C085CA  sub.b  d0, -$70e0(a1)
00C085CE  or.b   d6, ([$89c1, a6], $883786cd)
00C085D8  dc.w   $8585
00C085DA  or.w   (a7)+, d2
00C085DC  or.w   d1, (a2)+
00C085DE  or.w   ([$811a809f], a0.w, $80478013), d1
00C085EA  or.b   d1, d0
00C085EC  or.b   (a2), d0
00C085EE  or.w   d7, d0
00C085F0  or.l   (a6)+, d0
00C085F2  or.b   d0, (a1)+
00C085F4  or.l   d0, $76(a6, a0.w)
00C085F8  or.w   d1, (a0)+
00C085FA  or.w   (a4)+, d2
00C085FC  dc.w   $8583
00C085FE  ; data: 0x86, 0xca
00C08600  or.b   ([$8b688d32], a0.l), d4
00C08608  or.b   d7, (a4)+
00C0860A  sub.b  d0, -(a4)
00C0860C  subx.w -(a4), -(a1)
00C0860E  sub.l  d2, (a0)
00C08610  suba.l $71(a2, a1.l), a3
00C08614  subx.b -(a3), -(a6)
00C08616  suba.l d1, a7
00C08618  ; data: 0xa2, 0x91
00C0861A  ; data: 0xa5, 0x7a
00C0861C  ; data: 0xa8, 0x7d
00C0861E  ; data: 0xab, 0x97
00C08620  ; data: 0xae, 0xc9
00C08622  cmp.b  (a0), d1
00C08624  eor.w  d2, -$4721(a6)
00C08628  cmp.w  -(a4), d6
00C0862A  cmpa.l #$c3a5c75e, a7
00C08630  and.b  d5, -$3101(a0)
00C08634  adda.w -(a4), a1
00C08636  adda.w (a6), a3
00C08638  adda.w (a3), a5
00C0863A  adda.w (a2)+, a7
00C0863C  lsr.w  -$18fe(a2)
00C08640  asl.b  d5, d1
00C08642  asl.w  #$7, d5
00C08644  dc.w   $f36e
00C08646  ; data: 0xf7, 0x9b
00C08648  ; data: 0xfb, 0xca
00C0864A  ori.b  #$30, d0
00C0864E  ; data: 0x08, 0x5f
00C08650  ; data: 0x0c, 0x8c
00C08652  move.b -$27(a5, d1.w), (a0)
00C08656  move.b $1d10.w, (a4)+
00C0865A  move.l -(a0), -(a0)
00C0865C  move.l -(a7), -(a2)
00C0865E  move.l -(a4), -(a4)
00C08660  move.l (a6), -(a6)
00C08662  move.w $c08637(pc, d3.w), (a0)+
00C08666  move.w (a4)+, (a4)
00C08668  movea.w (a6), a6
00C0866A  ; data: 0x3f, 0xff
00C0866C  chk.w  (a7), d1
00C0866E  dc.w   $471c
00C08670  dc.w   $4a8e
00C08672  lea.l  $5133(a3), a6
00C08676  addq.w #$2, -(a4)
00C08678  ; data: 0x57, 0x7f
00C0867A  addq.l #$5, d1
00C0867C  subq.w #$6, $603b(a3)
00C08680  bhi.b  $c08673
00C08682  bcs.b  $c0860f
00C08684  bvc.b  $c08690
00C08686  bpl.b  $c086f4
00C08688  bge.b  $c0863b
00C0868A  bgt.b  $c08665
00C0868C  moveq  #$e1, d0
00C0868E  moveq  #$cb, d1
00C08690  moveq  #$96, d2
00C08692  moveq  #$40, d3
00C08694  ; data: 0x77, 0xca
00C08696  ; data: 0x79, 0x34
00C08698  moveq  #$7c, d5
00C0869A  ; data: 0x7b, 0xa2
00C0869C  moveq  #$a7, d6
00C0869E  ; data: 0x7d, 0x89
00C086A0  moveq  #$49, d7
00C086A2  moveq  #$e6, d7
00C086A4  ; data: 0x7f, 0x61
00C086A6  ; data: 0x7f, 0xb9
00C086A8  ; data: 0x7f, 0xed
00C086AA  ; data: 0x7f, 0xff
00C086AC  ; data: 0x7f, 0xee
00C086AE  ; data: 0x7f, 0xb9
00C086B0  ; data: 0x7f, 0x61
00C086B2  moveq  #$e7, d7
00C086B4  moveq  #$4a, d7
00C086B6  ; data: 0x7d, 0x8a
00C086B8  moveq  #$a7, d6
00C086BA  ; data: 0x7b, 0xa3
00C086BC  moveq  #$7d, d5
00C086BE  ; data: 0x79, 0x35
00C086C0  ; data: 0x77, 0xcb
00C086C2  moveq  #$41, d3
00C086C4  moveq  #$97, d2
00C086C6  moveq  #$cd, d1
00C086C8  moveq  #$e3, d0
00C086CA  bgt.b  $c086a6
00C086CC  bge.b  $c08681
00C086CE  bpl.b  $c0873e
00C086D0  bvc.b  $c086de
00C086D2  bcs.b  $c08661
00C086D4  bhi.b  $c086c9
00C086D6  bra.b  $c08715
00C086D8  subq.w #$6, $5a83(a5)
00C086DC  subq.l #$3, d1
00C086DE  addq.w #$2, -(a7)
00C086E0  subq.b #$8, ([$4a90])
00C086E6  dc.w   $471e
00C086E8  chk.w  (a1)+, d1
00C086EA  negx.b d2
00C086EC  movea.w (a1)+, a6
00C086EE  move.w (a7)+, (a4)
00C086F0  move.w (a6), (a2)+
00C086F2  ; data: 0x30, 0xfe
00C086F4  move.l (a1)+, -(a6)
00C086F6  move.l -(a7), -(a4)
00C086F8  move.l $2123(a2), -(a2)
00C086FC  move.b (a3), -(a6)
00C086FE  move.b $c086dc(pc, d1.w), (a4)+
00C08702  move.b $c8f.w, (a0)
00C08706  ; data: 0x08, 0x62
00C08708  subi.b #$3, ([], $f7a4f377)
00C08712  lsl.w  #$7, d6
00C08714  lsl.b  d5, d2
00C08716  lsl.b  #$3, d3
00C08718  lsr.w  -$1e(a3, a5.l)
00C0871C  adda.w (a3)+, a5
00C0871E  adda.w (a7)+, a3
00C08720  adda.w -$30f8(a5), a1
00C08724  and.b  d5, ([$c3ad, a0])
00C0872A  and.b  d4, d0
00C0872C  cmp.w  -$4719(a4), d6
00C08730  eor.w  d2, $18(a5, a3.w)
00C08734  ; data: 0xae, 0xd0
00C08736  ; data: 0xab, 0x9e
00C08738  ; data: 0xa8, 0x83
00C0873A  ; data: 0xa5, 0x81
00C0873C  ; data: 0xa2, 0x97
00C0873E  suba.l d7, a7
00C08740  sub.b  d6, (a1)
00C08742  sub.w  $95959350(invalid.w), d5
00C0874A  sub.b  d0, -$70e0(a1)
00C0874E  or.b   d6, ([$89c1, a6], $883786cd)
00C08758  dc.w   $8585
00C0875A  or.w   (a7)+, d2
00C0875C  or.w   d1, (a2)+
00C0875E  or.w   ([$811a809f], a0.w, $80478013), d1
00C0876A  or.b   d1, d0
00C0876C  or.b   (a2), d0
00C0876E  or.w   d7, d0
00C08770  or.l   (a6)+, d0
00C08772  or.b   d0, (a1)+
00C08774  or.l   d0, $76(a6, a0.w)
00C08778  or.w   d1, (a0)+
00C0877A  or.w   (a4)+, d2
00C0877C  dc.w   $8583
00C0877E  ; data: 0x86, 0xca
00C08780  or.b   ([$8b688d32], a0.l), d4
00C08788  or.b   d7, (a4)+
00C0878A  sub.b  d0, -(a4)
00C0878C  subx.w -(a4), -(a1)
00C0878E  sub.l  d2, (a0)
00C08790  suba.l $71(a2, a1.l), a3
00C08794  subx.b -(a3), -(a6)
00C08796  suba.l d1, a7
00C08798  ; data: 0xa2, 0x91
00C0879A  ; data: 0xa5, 0x7a
00C0879C  ; data: 0xa8, 0x7d
00C0879E  ; data: 0xab, 0x97
00C087A0  ; data: 0xae, 0xc9
00C087A2  cmp.b  (a0), d1
00C087A4  eor.w  d2, -$4721(a6)
00C087A8  cmp.w  -(a4), d6
00C087AA  cmpa.l #$c3a5c75e, a7
00C087B0  and.b  d5, -$3101(a0)
00C087B4  adda.w -(a4), a1
00C087B6  adda.w (a6), a3
00C087B8  adda.w (a3), a5
00C087BA  adda.w (a2)+, a7
00C087BC  lsr.w  -$18fe(a2)
00C087C0  asl.b  d5, d1
00C087C2  asl.w  #$7, d5
00C087C4  dc.w   $f36e
00C087C6  ; data: 0xf7, 0x9b
00C087C8  ; data: 0xfb, 0xca
00C087CA  ori.b  #$0, d0
00C087CE  ori.b  #$c0, d0
00C087D2  ori.b  #$54, d0
00C087D6  ori.b  #$c0, d0
00C087DA  ori.b  #$94, d0
00C087DE  ori.b  #$80, d0
00C087E2  ori.b  #$94, d0
00C087E6  ori.b  #$c0, d0
00C087EA  ori.b  #$0, d0
00C087EE  ori.b  #$0, d0
00C087F2  subi.b #$11, (a1)
00C087F6  subi.b #$11, (a1)
00C087FA  subi.b #$11, (a1)
00C087FE  subi.b #$11, (a1)
00C08802  subi.b #$11, (a1)
00C08806  subi.b #$11, (a1)
00C0880A  subi.b #$11, (a1)
00C0880E  subi.b #$11, (a1)
00C08812  subi.b #$11, (a1)
00C08816  subi.b #$11, (a1)
00C0881A  subi.b #$11, (a1)
00C0881E  subi.b #$11, (a1)
00C08822  subi.b #$11, (a1)
00C08826  subi.b #$11, (a1)
00C0882A  subi.b #$11, (a1)
00C0882E  subi.b #$11, (a1)
00C08832  bclr.b d4, (a1)+
00C08834  bchg.b d2, (a6)
00C08836  btst.l d1, ([], d0.l, $8870677)
00C0883E  addi.w #$545, (a6)
00C08842  subi.b #$b9, $11(a5, d0.w)
00C08848  subi.b #$11, (a1)
00C0884C  subi.b #$11, (a1)
00C08850  subi.b #$11, (a1)
00C08854  subi.b #$0, (a1)
00C08858  bclr.b d4, (a1)+
00C0885A  bchg.b d2, (a6)
00C0885C  btst.l d1, (a4, d0.w)
00C08860  ori.b  #$0, d0
00C08864  ori.b  #$11, d0
00C08868  bclr.b d4, (a7)
00C0886A  ; data: 0x08, 0x87
00C0886C  addi.w #$656, ([a7])
00C08872  subi.b #$b9, $11(a5, d0.w)
00C08878  subi.b #$11, (a1)
00C0887C  subi.b #$11, (a1)
00C08880  subi.b #$11, (a1)
00C08884  subi.b #$11, (a1)
00C08888  bclr.b d4, (a7)
00C0888A  ; data: 0x08, 0x87
00C0888C  addi.w #$656, ([a7])
00C08892  subi.b #$b9, (a5, d0.w)
00C08898  bclr.b d4, (a1)+
00C0889A  bchg.b d2, (a6)
00C0889C  btst.l d1, (a4, d0.w)
00C088A0  ori.b  #$0, d0
00C088A4  ori.b  #$0, d0
00C088A8  ori.b  #$0, d0
00C088AC  ori.b  #$0, d0
00C088B0  ori.b  #$2, d0
00C088B4  bra.w  $c088b6
00C088B8  ori.b  #$0, d0
00C088BC  ori.b  #$0, d0
00C088C0  ori.b  #$0, d0
00C088C4  ori.b  #$0, d0
00C088C8  ori.b  #$0, d0
00C088CC  ori.b  #$0, d0
00C088D0  ori.b  #$0, d0
00C088D4  ori.b  #$0, d0
00C088D8  ori.b  #$0, d0
00C088DC  move.l d0, d0
00C088DE  ori.b  #$0, d0
00C088E2  ori.b  #$0, d0
00C088E6  ori.b  #$0, d0
00C088EA  ori.b  #$0, d0
00C088EE  ori.b  #$0, d0
00C088F2  ori.b  #$0, d0
00C088F6  ori.b  #$0, d0
00C088FA  ori.b  #$0, d0
00C088FE  ori.b  #$0, d0
00C08902  ori.b  #$0, d0
00C08906  ori.b  #$0, d0
00C0890A  ori.b  #$0, d0
00C0890E  ori.b  #$0, d0
00C08912  ori.b  #$0, d0
00C08916  ori.b  #$0, d0
00C0891A  ori.b  #$0, d0
00C0891E  ori.b  #$0, d0
00C08922  ori.b  #$0, d0
00C08926  ori.b  #$0, d0
00C0892A  and.b  $c0892c(pc,a4.w), d0
00C0892E  ori.b  #$0, d0
00C08932  ori.b  #$0, d0
00C08936  ori.b  #$0, d0
00C0893A  ori.b  #$1, d0
00C0893E  move.b d1, -(a0)
00C08940  or.b   d0, d0
00C08942  ori.b  #$0, d0
00C08946  ori.b  #$0, d0
00C0894A  ori.b  #$0, d3
00C0894E  ; data: 0x08, 0x39
00C08950  dc.w   $f000
00C08952  ; data: 0x7f, 0x40
00C08954  ori.b  #$0, d0
00C08958  ori.b  #$0, d0
00C0895C  ori.b  #$83, d4
00C08960  negx.b d0
00C08962  bset.b d0, (a7)+
00C08964  dc.w   $f002
00C08966  ; data: 0x7f, 0xe0
00C08968  ori.b  #$0, d0
00C0896C  ori.b  #$0, d0
00C08970  ; data: 0x00, 0x0f
00C08972  bclr.b d0, d3
00C08974  and.b  d1, d0
00C08976  ; data: 0x80, 0x4f
00C08978  dc.w   $f002
00C0897A  ; data: 0xff, 0x00
00C0897C  ori.b  #$0, d0
00C08980  ori.b  #$0, d0
00C08984  ori.b  #$5b, d3
00C08988  ; data: 0xc0, 0x08
00C0898A  ori.b  #$0, (a1)
00C0898E  adda.w (a0, d0.w), a4
00C08992  ori.b  #$0, d0
00C08996  ori.b  #$1, d0
00C0899A  and.w  #$2000, d4
00C0899E  ori.b  #$4, d0
00C089A2  move.b d6, (a7)
00C089A4  ori.b  #$0, d0
00C089A8  ori.b  #$0, d0
00C089AC  ori.b  #$3d, d0
00C089B0  ori.b  #$e0, d0
00C089B4  ori.b  #$80, d0
00C089B8  ori.b  #$0, d0
00C089BC  ori.b  #$0, d0
00C089C0  ori.b  #$39, d0
00C089C4  and.b  d0, d0
00C089C6  ori.b  #$8, d0
00C089CA  ori.b  #$0, d0
00C089CE  ori.b  #$0, d0
00C089D2  ori.b  #$0, d0
00C089D6  ; data: 0x04, 0x3f
00C089D8  ; data: 0x00, 0x08
00C089DA  ori.b  #$18, d0
00C089DE  btst.l d3, d0
00C089E0  ori.b  #$0, d0
00C089E4  ori.b  #$0, d0
00C089E8  ; data: 0x00, 0x0c
00C089EA  move.b -(a4), d0
00C089EC  ori.w  #$0, d0
00C089F0  ; data: 0x00, 0x08
00C089F2  btst.l d4, d0
00C089F4  ori.b  #$0, d0
00C089F8  ori.b  #$0, d0
00C089FC  ; data: 0x00, 0x0c
00C089FE  move.b -(a4), d0
00C08A00  ori.w  #$20, d0
00C08A04  ; data: 0x00, 0x08
00C08A06  btst.l d4, d0
00C08A08  ori.b  #$0, d0
00C08A0C  ori.b  #$0, d0
00C08A10  ; data: 0x00, 0x08
00C08A12  subi.b #$0, d0
00C08A16  ori.b  #$18, d0
00C08A1A  ; data: 0x00, 0xc0
00C08A1C  ori.b  #$0, d0
00C08A20  ori.b  #$0, d0
00C08A24  ; data: 0x00, 0x0a
00C08A26  move.w d4, d1
00C08A28  ori.b  #$2, d0
00C08A2C  ; data: 0x40, 0x08
00C08A2E  adda.l d0, a1
00C08A30  ori.b  #$0, d0
00C08A34  ori.b  #$0, d0
00C08A38  ori.b  #$82, d2
00C08A3C  ori.b  #$34, d0
00C08A40  ori.b  #$0, d1
00C08A44  ori.b  #$0, d0
00C08A48  ori.b  #$0, d0
00C08A4C  ori.b  #$0, d7
00C08A50  ori.b  #$0, d0
00C08A54  ori.b  #$0, -(a0)
00C08A58  ori.b  #$0, d0
00C08A5C  ori.b  #$0, d0
00C08A60  ; data: 0x00, 0x0f
00C08A62  ; data: 0xfb, 0x84
00C08A64  ori.b  #$0, d0
00C08A68  ori.b  #$0, -(a2)
00C08A6C  ori.b  #$0, d0
00C08A70  ori.b  #$0, d0
00C08A74  ; data: 0x00, 0x0a
00C08A76  eor.l  d5, (a0)+
00C08A78  ori.b  #$31, d0
00C08A7C  ori.b  #$0, d5
00C08A80  ori.b  #$0, d0
00C08A84  ori.b  #$0, d0
00C08A88  ; data: 0x00, 0x09
00C08A8A  eor.l  d5, d0
00C08A8C  ori.b  #$31, d0
00C08A90  or.b   d5, d0
00C08A92  and.b  d0, d0
00C08A94  ori.b  #$0, d0
00C08A98  ori.b  #$0, d0
00C08A9C  ori.b  #$20, (a4)+
00C08AA0  ori.b  #$e1, d0
00C08AA4  or.b   d3, d0
00C08AA6  ori.b  #$0, d0
00C08AAA  ori.b  #$0, d0
00C08AAE  ori.b  #$1e, d0
00C08AB2  ; data: 0x0e, 0x00
00C08AB4  ori.b  #$7, d0
00C08AB8  or.b   -(a3), d0
00C08ABA  ori.b  #$0, d0
00C08ABE  ori.b  #$0, d0
00C08AC2  ori.b  #$0, d0
00C08AC6  not.b  d0
00C08AC8  ori.b  #$7, d0
00C08ACC  or.b   -(a2), d0
00C08ACE  dc.w   $f000
00C08AD0  ori.b  #$0, d0
00C08AD4  ori.b  #$0, d0
00C08AD8  ori.b  #$0, d7
00C08ADC  ori.b  #$20, d0
00C08AE0  ; data: 0x80, 0x0f
00C08AE2  dc.w   $f000
00C08AE4  ori.b  #$0, d0
00C08AE8  ori.b  #$0, d0
00C08AEC  ori.b  #$0, $0(a1)
00C08AF2  ori.b  #$1f, -(a0)
00C08AF6  ori.b  #$0, d0
00C08AFA  ori.b  #$0, d0
00C08AFE  ori.b  #$17, d0
00C08B02  and.b  d0, d6
00C08B04  ori.b  #$38, d0
00C08B08  ; data: 0x00, 0x0f
00C08B0A  ori.b  #$0, d0
00C08B0E  ori.b  #$0, d0
00C08B12  ori.b  #$17, d0
00C08B16  and.b  d0, d6
00C08B18  ori.b  #$38, d0
00C08B1C  ; data: 0x00, 0x0f
00C08B1E  ori.b  #$0, d0
00C08B22  ori.b  #$0, d0
00C08B26  ori.b  #$17, d0
00C08B2A  or.b   d0, d6
00C08B2C  ori.b  #$6, d0
00C08B30  ; data: 0x00, 0x0f
00C08B32  move.b d0, d0
00C08B34  ori.b  #$0, d0
00C08B38  ori.b  #$0, d0
00C08B3C  ori.w  #$4c00, -(a7)
00C08B40  ori.b  #$6, d0
00C08B44  ori.b  #$0, d6
00C08B48  ori.b  #$0, d0
00C08B4C  ori.b  #$0, d0
00C08B50  ori.b  #$0, d7
00C08B54  ori.b  #$20, d0
00C08B58  dc.w   $f84c
00C08B5A  ori.b  #$0, d0
00C08B5E  ori.b  #$0, d0
00C08B62  ori.b  #$47, d0
00C08B66  or.b   d0, d7
00C08B68  ori.b  #$c7, d0
00C08B6C  ; data: 0x80, 0x49
00C08B6E  ori.b  #$0, d0
00C08B72  ori.b  #$0, d0
00C08B76  ori.b  #$4e, d0
00C08B7A  cmp.b  d0, d6
00C08B7C  ori.b  #$e6, d0
00C08B80  moveq  #$0, d4
00C08B82  ori.b  #$0, d0
00C08B86  ori.b  #$0, d0
00C08B8A  ori.b  #$5e, d0
00C08B8E  or.b   d0, d2
00C08B90  ori.b  #$6, d0
00C08B94  dc.w   $f800
00C08B96  ori.b  #$0, d0
00C08B9A  ori.b  #$0, d0
00C08B9E  ori.b  #$de, d0
00C08BA2  or.b   d0, d2
00C08BA4  ori.b  #$6, d0
00C08BA8  dc.w   $f800
00C08BAA  ori.b  #$0, d0
00C08BAE  ori.b  #$0, d0
00C08BB2  ori.b  #$d1, d0
00C08BB6  addi.w #$0, d0
00C08BBA  ori.b  #$0, d1
00C08BBE  ori.b  #$0, d0
00C08BC2  ori.b  #$0, d0
00C08BC6  ori.b  #$df, d0
00C08BCA  and.w  d0, d2
00C08BCC  ori.b  #$7, d0
00C08BD0  dc.w   $f040
00C08BD2  ori.b  #$0, d0
00C08BD6  ori.b  #$0, d0
00C08BDA  ori.b  #$7, d0
00C08BDE  and.w  d0, d2
00C08BE0  ori.b  #$7, d0
00C08BE4  pea.l  (a3)
00C08BE6  ori.b  #$0, d0
00C08BEA  ori.b  #$0, d0
00C08BEE  ori.b  #$f, d0
00C08BF2  ; data: 0xc7, 0x80
00C08BF4  ori.b  #$0, d0
00C08BF8  ; data: 0x08, 0x13
00C08BFA  and.b  d0, d0
00C08BFC  ori.b  #$0, d0
00C08C00  ori.b  #$0, d0
00C08C04  movep.w -$3e20(a7), d2
00C08C08  ori.b  #$0, d0
00C08C0C  ; data: 0x02, 0x0f
00C08C0E  or.b   d0, d0
00C08C10  ori.b  #$0, d0
00C08C14  ori.b  #$0, d0
00C08C18  btst.l d0, (a7)+
00C08C1A  muls.w -(a0), d0
00C08C1C  btst.l d1, d1
00C08C1E  and.b  d1, d0
00C08C20  ; data: 0x37, 0xd7
00C08C22  and.b  d0, d0
00C08C24  ori.b  #$0, d0
00C08C28  ori.b  #$0, d0
00C08C2C  btst.l d0, (a7)+
00C08C2E  muls.w -(a0), d0
00C08C30  btst.l d3, d1
00C08C32  and.b  d1, d0
00C08C34  cmpa.l d5, a3
00C08C36  and.b  d0, d0
00C08C38  ori.b  #$0, d0
00C08C3C  ori.b  #$0, d0
00C08C40  bset.b d0, d7
00C08C42  and.w  -(a0), d1
00C08C44  bchg.b d4, $1(a0, d0.w)
00C08C48  and.b  d0, d5
00C08C4A  moveq  #$0, d7
00C08C4C  ori.b  #$0, d0
00C08C50  ori.b  #$0, d0
00C08C54  movep.w -$e28(a7), d6
00C08C58  ; data: 0x1e, 0x44
00C08C5A  move.b -(a7), d4
00C08C5C  ; data: 0xf3, 0xde
00C08C5E  dc.w   $f080
00C08C60  ori.b  #$0, d0
00C08C64  ori.b  #$0, d0
00C08C68  movep.w -$363c(a7), d3
00C08C6C  ; data: 0xe1, 0xfd
00C08C6E  mulu.w d7, d0
00C08C70  dc.w   $f641
00C08C72  and.w  d0, d0
00C08C74  bra.w  $c08c76
00C08C78  bset.b d0, (a0, d0.w)
00C08C7C  addi.b #$ff, -$1f34(a7)
00C08C82  ; data: 0x00, 0xf9
00C08C84  cmpa.l $f901d800.l, a6
00C08C8A  ori.b  #$b0, d0
00C08C8E  ori.b  #$2f, d0
00C08C92  dc.w   $f85f
00C08C94  muls.w d0, d0
00C08C96  ori.b  #$ff, d6
00C08C9A  dc.w   $fe3b
00C08C9C  sub.b  d0, d7
00C08C9E  ori.b  #$f0, d0
00C08CA2  ori.b  #$1f, d0
00C08CA6  cmp.b  d0, d6
00C08CA8  ; data: 0x08, 0x00
00C08CAA  dc.w   $42c0
00C08CAC  ; data: 0xc7, 0xff
00C08CAE  dc.w   $fe37
00C08CB0  subx.b d0, d7
00C08CB2  ori.b  #$c0, d3
00C08CB6  ori.b  #$1f, d0
00C08CBA  cmp.b  d0, d6
00C08CBC  ; data: 0x08, 0x00
00C08CBE  dc.w   $42c0
00C08CC0  ; data: 0xc7, 0xff
00C08CC2  dc.w   $fe37
00C08CC4  sub.b  d7, -(a0)
00C08CC6  ; data: 0x00, 0x0d
00C08CC8  ; data: 0x17, 0xc0
00C08CCA  ori.b  #$1f, d0
00C08CCE  ; data: 0x4e, 0x00
00C08CD0  move.b ([$f1fffe31]), (a7)+
00C08CD8  roxl.w -(a0)
00C08CDA  ori.w  #$cf80, d1
00C08CDE  ori.b  #$1f, d0
00C08CE2  or.l   d7, -(a1)
00C08CE4  ; data: 0xff, 0xc4
00C08CE6  ; data: 0x07, 0xff
00C08CE8  or.b   (a7)+, d0
00C08CEA  dc.w   $f075
00C08CEC  ; data: 0xff, 0xf8
00C08CEE  ori.w  #$39c0, d1
00C08CF2  ori.b  #$df, d0
00C08CF6  bset.b d5, (a5)+
00C08CF8  ; data: 0xf9, 0xc5
00C08CFA  divs.w $3f(a6, d3.w), d2
00C08CFE  ; data: 0xe1, 0xff
00C08D00  ; data: 0xff, 0xfe
00C08D02  move.w $fec0.w, (a3, d0.w)
00C08D08  movep.l d3, -$7801(a7)
00C08D0C  and.b  d7, -$40(a6, d0.w)
00C08D10  dc.w   $f83f
00C08D12  ; data: 0xe8, 0xcf
00C08D14  ; data: 0xff, 0xf7
00C08D16  ; data: 0xc1, 0x87
00C08D18  ; data: 0xff, 0xc0
00C08D1A  ori.b  #$c7, d0
00C08D1E  muls.w ([$9aa1899f]), d3
00C08D26  ; data: 0x01, 0xbf
00C08D28  ; data: 0xff, 0xff
00C08D2A  dc.w   $f047
00C08D2C  ; data: 0xcf, 0x80
00C08D2E  ori.b  #$26, d0
00C08D32  and.w  -(a0), d0
00C08D34  ; data: 0x01, 0xff
00C08D36  ; data: 0xff, 0xff
00C08D38  ; data: 0xff, 0xff
00C08D3A  ; data: 0xc0, 0x4f
00C08D3C  ; data: 0xff, 0xff
00C08D3E  ; data: 0xc9, 0xff
00C08D40  addx.b d0, d7
00C08D42  ori.b  #$26, d0
00C08D46  and.w  -(a0), d0
00C08D48  ; data: 0x01, 0xff
00C08D4A  ; data: 0xff, 0xff
00C08D4C  ; data: 0xff, 0xff
00C08D4E  ; data: 0xc0, 0x4f
00C08D50  ; data: 0xff, 0xff
00C08D52  ; data: 0xc9, 0xff
00C08D54  addx.b d0, d7
00C08D56  ori.b  #$f, d2
00C08D5A  or.w   d0, d0
00C08D5C  movea.w ([$ffffe6bf]), a4
00C08D64  ; data: 0xff, 0xff
00C08D66  ; data: 0xff, 0xfb
00C08D68  move.b d0, d3
00C08D6A  ori.b  #$1, d2
00C08D6E  divs.w -(a4), d0
00C08D70  ; data: 0x3e, 0xff
00C08D72  ; data: 0xff, 0xff
00C08D74  ; data: 0xff, 0xff
00C08D76  ; data: 0x0e, 0x07
00C08D78  ; data: 0xff, 0xff
00C08D7A  ; data: 0xff, 0xdc
00C08D7C  asr.b  #$7, d0
00C08D7E  ori.b  #$c6, d0
00C08D82  ; data: 0x0f, 0xff
00C08D84  ; data: 0x37, 0xcf
00C08D86  ; data: 0xff, 0xff
00C08D88  ; data: 0xff, 0xff
00C08D8A  dc.w   $fe01
00C08D8C  ; data: 0xff, 0xff
00C08D8E  ; data: 0xff, 0xfc
00C08D90  asl.l  #$3, d0
00C08D92  ori.b  #$9, d0
00C08D96  ; data: 0x0b, 0xff
00C08D98  ; data: 0xff, 0xff
00C08D9A  ; data: 0xff, 0xff
00C08D9C  ; data: 0xff, 0xff
00C08D9E  dc.w   $f687
00C08DA0  ; data: 0xff, 0xff
00C08DA2  dc.w   $f666
00C08DA4  addx.b d0, d0
00C08DA6  ori.b  #$f, d3
00C08DAA  ; data: 0x3f, 0xfd
00C08DAC  ; data: 0xdf, 0xff
00C08DAE  ; data: 0xff, 0xff
00C08DB0  ; data: 0xff, 0xff
00C08DB2  ; data: 0xff, 0x7f
00C08DB4  ; data: 0xff, 0xff
00C08DB6  ; data: 0xc1, 0xcc
00C08DB8  dc.w   $f800
00C08DBA  ori.b  #$31, d2
00C08DBE  ; data: 0xfb, 0xff
00C08DC0  ; data: 0xff, 0xff
00C08DC2  ; data: 0xbf, 0xff
00C08DC4  ; data: 0xff, 0xff
00C08DC6  ; data: 0xff, 0x8b
00C08DC8  ; data: 0xff, 0xff
00C08DCA  and.w  $c0c9cc(pc), d2
00C08DCE  ori.b  #$31, d2
00C08DD2  ; data: 0xfb, 0xff
00C08DD4  ; data: 0xff, 0xff
00C08DD6  ; data: 0xbf, 0xff
00C08DD8  ; data: 0xff, 0xff
00C08DDA  ; data: 0xff, 0x8b
00C08DDC  ; data: 0xff, 0xff
00C08DDE  and.w  $c0c5e0(pc), d2
00C08DE2  ori.b  #$ff, d3
00C08DE6  ; data: 0xfb, 0xff
00C08DE8  ; data: 0xff, 0xfe
00C08DEA  ; data: 0x3f, 0xff
00C08DEC  ; data: 0xff, 0xff
00C08DEE  ; data: 0xff, 0xff
00C08DF0  ; data: 0xff, 0xfe
00C08DF2  bset.b d0, $3000.w
00C08DF6  ori.b  #$ff, d7
00C08DFA  ; data: 0xff, 0xff
00C08DFC  ; data: 0xff, 0xfe
00C08DFE  ; data: 0x3f, 0xff
00C08E00  ; data: 0xff, 0xff
00C08E02  ; data: 0xff, 0xfe
00C08E04  ; data: 0x7f, 0xf8
00C08E06  bclr.b d4, (a0)+
00C08E08  ori.b  #$7, d0
00C08E0C  ; data: 0x84, 0xff
00C08E0E  ; data: 0xf7, 0xff
00C08E10  ; data: 0xff, 0xfe
00C08E12  ; data: 0x1f, 0xff
00C08E14  ; data: 0xff, 0xff
00C08E16  ; data: 0xff, 0xff
00C08E18  ; data: 0xff, 0xfe
00C08E1A  move.w $0.w, d1
00C08E1E  ori.b  #$1, d6
00C08E22  ; data: 0xc7, 0xff
00C08E24  ; data: 0xff, 0xfd
00C08E26  ; data: 0x9f, 0xff
00C08E28  ; data: 0xff, 0xff
00C08E2A  ; data: 0xff, 0xc6
00C08E2C  ; data: 0x3f, 0xfe
00C08E2E  moveq  #$78, d7
00C08E30  ori.b  #$7, d0
00C08E34  ; data: 0xe5, 0xc0
00C08E36  ; data: 0xc3, 0xff
00C08E38  ; data: 0xff, 0xfe
00C08E3A  ; data: 0x07, 0xff
00C08E3C  ; data: 0xff, 0xff
00C08E3E  ; data: 0xff, 0xff
00C08E40  rol.w  (a7.l * 2)
00C08E46  ori.b  #$e0, d7
00C08E4A  ; data: 0x0f, 0xff
00C08E4C  ; data: 0xff, 0xfe
00C08E4E  ; data: 0x07, 0xff
00C08E50  ; data: 0xff, 0xff
00C08E52  ; data: 0xff, 0xff
00C08E54  lsl.w  $7bba.w
00C08E58  or.b   d0, d0
00C08E5A  ori.b  #$e0, d7
00C08E5E  ; data: 0x0f, 0xff
00C08E60  ; data: 0xff, 0xfe
00C08E62  ; data: 0x07, 0xff
00C08E64  ; data: 0xff, 0xff
00C08E66  ; data: 0xff, 0xff
00C08E68  lsl.w  $7bba.w
00C08E6C  or.b   d0, d0
00C08E6E  ori.b  #$f0, d7
00C08E72  ; data: 0xcf, 0xff
00C08E74  ; data: 0xff, 0xff
00C08E76  ; data: 0xc1, 0xff
00C08E78  ; data: 0xff, 0xff
00C08E7A  ; data: 0xff, 0xff
00C08E7C  muls.w -(a0), d0
00C08E7E  ; data: 0x37, 0xdd
00C08E80  ori.b  #$6, d0
00C08E84  subi.b #$ff, ([$e1fffff9])
00C08E8E  ; data: 0xff, 0xff
00C08E90  mulu.w $8fc3.w, d0
00C08E94  ori.b  #$3, d0
00C08E98  or.b   (a0)+, d0
00C08E9A  ; data: 0x77, 0xff
00C08E9C  ; data: 0xff, 0xff
00C08E9E  ; data: 0xa1, 0xff
00C08EA0  ; data: 0xff, 0xfb
00C08EA2  ; data: 0xff, 0xff
00C08EA4  roxl.w $47(a0, a0.l)
00C08EA8  ori.b  #$3, d0
00C08EAC  ; data: 0x98, 0xbd
00C08EAE  ; data: 0x3f, 0xfe
00C08EB0  move.w ([$ffc2ffff]), (a7)
00C08EB8  ; data: 0xc1, 0xff
00C08EBA  ; data: 0xb5, 0xbe
00C08EBC  ori.b  #$3, d0
00C08EC0  muls.w #$7ffc, d3
00C08EC4  ; data: 0x00, 0x08
00C08EC6  ; data: 0x07, 0xff
00C08EC8  ; data: 0xff, 0xe1
00C08ECA  ; data: 0xff, 0xff
00C08ECC  dc.w   $faff
00C08ECE  bge.b  $c08f0e
00C08ED0  ori.b  #$1, d0
00C08ED4  muls.w d4, d3
00C08ED6  ; data: 0x7f, 0xfc
00C08ED8  move.l d0, -(a7)
00C08EDA  ; data: 0x1f, 0xff
00C08EDC  ; data: 0xff, 0xe4
00C08EDE  ; data: 0x3f, 0xff
00C08EE0  ; data: 0xff, 0xf0
00C08EE2  dc.w   $f85c
00C08EE4  ori.b  #$7, d0
00C08EE8  muls.w d4, d3
00C08EEA  ; data: 0x7f, 0xfc
00C08EEC  move.l d0, -(a7)
00C08EEE  ; data: 0x1f, 0xff
00C08EF0  ; data: 0xff, 0xc4
00C08EF2  ; data: 0x3f, 0xff
00C08EF4  ; data: 0xff, 0xf0
00C08EF6  dc.w   $f85c
00C08EF8  ori.b  #$1, d0
00C08EFC  sbcd   -(a7), -(a0), #$fffc
00C08F00  move.b d0, (a3)
00C08F02  ; data: 0x3f, 0xff
00C08F04  ; data: 0xff, 0xfa
00C08F06  ; data: 0x71, 0xff
00C08F08  dc.w   $fc27
00C08F0A  cmp.b  (a0)+, d4
00C08F0C  ori.b  #$7, d0
00C08F10  or.b   d2, (a1)
00C08F12  cmpa.l #$1e41ffff, a7
00C08F18  ; data: 0xff, 0xef
00C08F1A  ; data: 0x11, 0xff
00C08F1C  dc.w   $f8c7
00C08F1E  dc.w   $f018
00C08F20  ori.b  #$1, d0
00C08F24  mulu.w $bbff.w, d2
00C08F28  ; data: 0x3e, 0xff
00C08F2A  ; data: 0xff, 0xff
00C08F2C  ; data: 0xff, 0xff
00C08F2E  ; data: 0xf9, 0xff
00C08F30  ; data: 0xe1, 0xfb
00C08F32  moveq  #$10, d0
00C08F34  ori.b  #$7, d0
00C08F38  ; data: 0xa1, 0xf0
00C08F3A  ; data: 0x33, 0xff
00C08F3C  ; data: 0xff, 0xff
00C08F3E  ; data: 0xff, 0xff
00C08F40  ; data: 0xff, 0xff
00C08F42  ; data: 0xff, 0xff
00C08F44  muls.w -$3fe0(a7), d1
00C08F48  ori.b  #$1, d0
00C08F4C  rol.b  d0, d6
00C08F4E  ; data: 0x03, 0xff
00C08F50  ; data: 0xff, 0xff
00C08F52  ; data: 0xff, 0xff
00C08F54  ; data: 0xff, 0xdf
00C08F56  ; data: 0xbf, 0xff
00C08F58  ; data: 0xff, 0x3f
00C08F5A  or.b   d0, d0
00C08F5C  ori.b  #$9, d0
00C08F60  adda.l -(a6), a4
00C08F62  ; data: 0x41, 0xff
00C08F64  ; data: 0xff, 0xff
00C08F66  dc.w   $fc01
00C08F68  ; data: 0xff, 0xbf
00C08F6A  ; data: 0xdf, 0xfe
00C08F6C  ; data: 0x5e, 0x7f
00C08F6E  ori.b  #$0, d0
00C08F72  ; data: 0x00, 0x08
00C08F74  adda.l -(a6), a4
00C08F76  ; data: 0x41, 0xff
00C08F78  ; data: 0xff, 0xff
00C08F7A  dc.w   $fc01
00C08F7C  ; data: 0xff, 0xbf
00C08F7E  ; data: 0x7f, 0xfe
00C08F80  ; data: 0x5e, 0x3f
00C08F82  ori.b  #$0, d0
00C08F86  ori.b  #$20, d3
00C08F8A  ; data: 0x00, 0x3f
00C08F8C  ; data: 0xff, 0xff
00C08F8E  dc.w   $f800
00C08F90  dc.w   $f807
00C08F92  ; data: 0xff, 0xfc
00C08F94  ; data: 0x24, 0xff
00C08F96  and.b  d0, d0
00C08F98  ori.b  #$5, d0
00C08F9C  roxr.l #$3, d7
00C08F9E  ori.b  #$ff, (a7)+
00C08FA2  asr.b  #$8, d0
00C08FA4  ori.b  #$fc, d4
00C08FA8  move.b -$8000(a7), -(a3)
00C08FAC  ori.b  #$7, d0
00C08FB0  asl.b  d3, d1
00C08FB2  nbcd.b d3
00C08FB4  ; data: 0xff, 0xff
00C08FB6  ; data: 0xe7, 0xc0
00C08FB8  ori.b  #$f0, d6
00C08FBC  ; data: 0x19, 0xff
00C08FBE  or.b   d0, d0
00C08FC0  ori.b  #$2, d0
00C08FC4  moveq  #$1e, d6
00C08FC6  ; data: 0x08, 0x03
00C08FC8  ; data: 0xff, 0xff
00C08FCA  ; data: 0xff, 0xf8
00C08FCC  moveq  #$3f, d4
00C08FCE  eor.w  d7, d1
00C08FD0  ori.b  #$0, (a7, d0.w)
00C08FD6  ori.b  #$0, d3
00C08FDA  ; data: 0xff, 0x83
00C08FDC  ; data: 0xff, 0xff
00C08FDE  ; data: 0xff, 0xd0
00C08FE0  moveq  #$7f, d7
00C08FE2  dc.w   $fe03
00C08FE4  ori.b  #$0, d7
00C08FE8  ori.b  #$0, d0
00C08FEC  ; data: 0x46, 0xce
00C08FEE  ; data: 0xff, 0xc3
00C08FF0  ; data: 0xff, 0x7f
00C08FF2  ; data: 0xff, 0xf9
00C08FF4  ; data: 0xff, 0xff
00C08FF6  dc.w   $fe82
00C08FF8  movep.w -$2000(a7), d0
00C08FFC  ori.b  #$0, d0
00C09000  ; data: 0x46, 0xce
00C09002  ; data: 0xff, 0xc3
00C09004  ; data: 0xff, 0x7f
00C09006  ; data: 0xff, 0xf9
00C09008  ; data: 0xff, 0xff
00C0900A  ; data: 0xff, 0x90
00C0900C  movep.w -$2000(a7), d0
00C09010  ori.b  #$0, d0
00C09014  btst.l d1, -(a0)
00C09016  ; data: 0x7f, 0xdc
00C09018  dc.w   $feff
00C0901A  ; data: 0xff, 0xff
00C0901C  ; data: 0xff, 0xff
00C0901E  ; data: 0xff, 0xa4
00C09020  ori.b  #$0, (a7)+
00C09024  ori.b  #$0, d0
00C09028  ; data: 0x41, 0xe0
00C0902A  ; data: 0x3f, 0xfe
00C0902C  ; data: 0x38, 0xff
00C0902E  dc.w   $fe1f
00C09030  ; data: 0xff, 0xfd
00C09032  ; data: 0xff, 0x1a
00C09034  ; data: 0x00, 0x3f
00C09036  or.b   d0, d0
00C09038  ori.b  #$0, d0
00C0903C  bset.b d3, ([$c03f])
00C09042  dc.w   $fc1f
00C09044  ; data: 0xfd, 0xfe
00C09046  ; data: 0x1f, 0xf0
00C09048  ; data: 0x00, 0x0f
00C0904A  or.b   d0, d0
00C0904C  ori.b  #$0, d0
00C09050  bsr.b  $c0906a
00C09052  ; data: 0x3f, 0xff
00C09054  muls.w ([$cebc924e]), d4
00C0905C  subi.b #$0, d7
00C09060  ori.b  #$0, d0
00C09064  ; data: 0x7f, 0xee
00C09066  ; data: 0x07, 0xff
00C09068  ; data: 0xef, 0xcc
00C0906A  ; data: 0x7f, 0xf9
00C0906C  ; data: 0xf0, 0x7f
00C0906E  bset.b d3, d0
00C09070  ori.b  #$0, d6
00C09074  ori.b  #$0, d0
00C09078  beq.b  $c09072
00C0907A  ; data: 0xb7, 0xff
00C0907C  ; data: 0xff, 0xff
00C0907E  adda.l $3e(a7, a7.w), a7
00C09082  ; data: 0x3f, 0xd0
00C09084  ori.b  #$0, d0
00C09088  ori.b  #$0, d0
00C0908C  beq.b  $c09086
00C0908E  ; data: 0xb7, 0xff
00C09090  ; data: 0xff, 0xff
00C09092  adda.l $3c(a7, a7.w), a7
00C09096  ; data: 0x3f, 0xe0
00C09098  ori.b  #$0, d0
00C0909C  ori.b  #$0, d0
00C090A0  ; data: 0x20, 0x3e
00C090A2  ; data: 0x47, 0xff
00C090A4  ; data: 0xff, 0xcf
00C090A6  adda.w d1, a4
00C090A8  muls.w (invalid.w), d3
00C090AE  ori.b  #$0, d0
00C090B2  ori.b  #$df, d0
00C090B6  bset.b d3, -(a7)
00C090B8  ; data: 0xff, 0xfe
00C090BA  ori.b  #$e1, d7
00C090BE  ; data: 0xff, 0x80
00C090C0  ori.b  #$0, d0
00C090C4  ori.b  #$0, d0
00C090C8  ; data: 0x1c, 0xcf
00C090CA  muls.w -(a1), d7
00C090CC  dc.w   $ff77
00C090CE  ; data: 0xf9, 0x3f
00C090D0  ; data: 0xfd, 0xc7
00C090D2  asl.b  #$7, d0
00C090D4  ori.b  #$0, d0
00C090D8  ori.b  #$0, d0
00C090DC  ; data: 0x0a, 0x3f
00C090DE  divs.w -(a2), d3
00C090E0  ; data: 0xff, 0x3f
00C090E2  dc.w   $fe3f
00C090E4  ; data: 0xf1, 0xe7
00C090E6  move.w d0, -(a4)
00C090E8  ori.b  #$0, d0
00C090EC  ori.b  #$0, d0
00C090F0  bset.b d2, (a7)
00C090F2  or.l   d1, (a1)+
00C090F4  dc.w   $f0f7
00C090F6  dc.w   $fe3f
00C090F8  ; data: 0xb3, 0xfe
00C090FA  ori.b  #$0, d0
00C090FE  ori.b  #$0, d0
00C09102  ori.b  #$3e, d0
00C09106  moveq  #$0, d4
00C09108  ; data: 0x30, 0x3f
00C0910A  dc.w   $f806
00C0910C  divs.w d0, d2
00C0910E  move.b d0, d0
00C09110  ori.b  #$0, d0
00C09114  ori.b  #$0, d0
00C09118  ; data: 0x00, 0x3e
00C0911A  moveq  #$0, d4
00C0911C  ; data: 0x30, 0x3f
00C0911E  dc.w   $f806
00C09120  divs.w d0, d2
00C09122  move.b d0, d0
00C09124  ori.b  #$0, d0
00C09128  ori.b  #$0, d0
00C0912C  ; data: 0x01, 0xff
00C0912E  ; data: 0xf9, 0x9e
00C09130  ; data: 0x00, 0x3f
00C09132  dc.w   $f807
00C09134  dc.w   $8780
00C09136  and.b  d0, d0
00C09138  ori.b  #$0, d0
00C0913C  ori.b  #$0, d0
00C09140  ; data: 0x00, 0xef
00C09142  cmp.w  (a2)+, d0
00C09144  ; data: 0xc7, 0xff
00C09146  and.b  (a6)+, d0
00C09148  dc.w   $8386
00C0914A  move.l d0, (a0)
00C0914C  ori.b  #$0, d0
00C09150  ori.b  #$0, d0
00C09154  ori.b  #$5e, (a7)
00C09158  ; data: 0x39, 0xff
00C0915A  ; data: 0x9c, 0xfe
00C0915C  subi.b #$fe, d1
00C09160  ori.b  #$0, d0
00C09164  ori.b  #$0, d0
00C09168  ; data: 0x00, 0x09
00C0916A  ; data: 0xfa, 0x7f
00C0916C  ; data: 0x21, 0xff
00C0916E  muls.w $1(a7, d0.w), d0
00C09172  dc.w   $feff
00C09174  or.b   d0, d0
00C09176  ori.b  #$0, d0
00C0917A  ori.b  #$7, d0
00C0917E  dc.w   $fa1f
00C09180  ; data: 0xf1, 0xff
00C09182  ; data: 0x9f, 0xff
00C09184  negx.b d2
00C09186  ; data: 0x3f, 0xcc
00C09188  ori.b  #$0, d0
00C0918C  ori.b  #$0, d0
00C09190  ori.b  #$1e, d1
00C09194  muls.w #$5ffe, d0
00C09198  ori.b  #$bb, d0
00C0919C  and.b  d0, d1
00C0919E  ori.b  #$0, d0
00C091A2  ori.b  #$1, d0
00C091A6  dc.w   $fc1e
00C091A8  muls.w #$5ffe, d0
00C091AC  ori.b  #$bb, d0
00C091B0  and.b  d0, d1
00C091B2  ori.b  #$0, d0
00C091B6  ori.b  #$0, d0
00C091BA  move.w $20c03ff9.l, d6
00C091C0  ori.b  #$bc, d0
00C091C4  move.l d0, d0
00C091C6  ori.b  #$0, d0
00C091CA  ori.b  #$0, d0
00C091CE  ; data: 0x0e, 0x1e
00C091D0  move.b d0, d3
00C091D2  ; data: 0x27, 0xf9
00C091D4  negx.b d0
00C091D6  movep.w d7, $600(a6)
00C091DA  ori.b  #$0, d0
00C091DE  andi.l #$1e0387, d0
00C091E4  add.l  d1, d0
00C091E6  ; data: 0xb9, 0xfe
00C091E8  ori.b  #$ce, d0
00C091EC  move.b d0, d5
00C091EE  ori.b  #$0, d0
00C091F2  addi.l #$f03c3, d0
00C091F8  asr.b  #$4, d0
00C091FA  ; data: 0x1b, 0xfe
00C091FC  ori.b  #$fa, d0
00C09200  bset.b d2, d0
00C09202  ori.b  #$0, d0
00C09206  btst.l d3, d0
00C09208  movep.l d0, $407d(a0)
00C0920C  dc.w   $fef8
00C0920E  btst.l d1, $0.w
00C09212  ; data: 0x09, 0xfd
00C09214  sbcd.b d0, d3
00C09216  ori.b  #$0, d0
00C0921A  bset.b d2, d0
00C0921C  bclr.b d0, $383c.w
00C09220  movep.l d7, $19f8(a6)
00C09224  ori.b  #$4e, d0
00C09228  bset.b d1, d0
00C0922A  ori.b  #$0, d0
00C0922E  bset.b d2, d0
00C09230  btst.l d1, $383c.w
00C09234  movep.l d7, $19f8(a6)
00C09238  ori.b  #$4e, d0
00C0923C  bset.b d1, d0
00C0923E  ori.b  #$0, d0
00C09242  bclr.b d0, d0
00C09244  btst.l d3, $3806.w
00C09248  ; data: 0x07, 0x7f
00C0924A  sbcd.b d0, d0
00C0924C  ori.b  #$73, d0
00C09250  or.b   d0, d1
00C09252  ori.b  #$0, d0
00C09256  bset.b d0, d0
00C09258  addi.b #$5, (a1)+
00C0925C  and.b  $c0925e(pc,a7.l * 4), d0
00C09260  ori.b  #$0, d0
00C09264  ori.b  #$0, d0
00C09268  ori.b  #$c0, d0
00C0926C  move.b d7, d6
00C0926E  ; data: 0xf1, 0x83
00C09270  ; data: 0xc6, 0xff
00C09272  dc.w   $f800
00C09274  ori.b  #$2, d0
00C09278  ori.b  #$0, d1
00C0927C  ori.b  #$60, d0
00C09280  move.b d0, -(a5)
00C09282  moveq  #$3f, d6
00C09284  ; data: 0xff, 0xff
00C09286  or.b   -(a0), d0
00C09288  ori.b  #$1, d0
00C0928C  and.b  d0, d0
00C0928E  negx.b d0
00C09290  ori.b  #$0, d0
00C09294  ; data: 0x39, 0xc0
00C09296  move.w d7, d7
00C09298  ; data: 0xf1, 0xfd
00C0929A  add.b  -(a0), d6
00C0929C  ori.b  #$0, d0
00C092A0  moveq  #$0, d5
00C092A2  ori.b  #$0, d0
00C092A6  ori.b  #$f8, d0
00C092AA  ; data: 0x7f, 0x81
00C092AC  ror.b  d0, d7
00C092AE  ; data: 0xa2, 0x08
00C092B0  ori.b  #$0, d3
00C092B4  dc.w   $4100
00C092B6  ori.b  #$0, d0
00C092BA  ; data: 0x00, 0x08
00C092BC  ; data: 0x08, 0xf8
00C092BE  ; data: 0x7f, 0x81
00C092C0  ror.b  d0, d7
00C092C2  ; data: 0xa2, 0x08
00C092C4  ori.b  #$0, d3
00C092C8  dc.w   $4100
00C092CA  or.b   d0, d0
00C092CC  ori.b  #$0, d0
00C092D0  ; data: 0x1c, 0x3e
00C092D2  move.w #$2000, d7
00C092D6  ; data: 0x18, 0x08
00C092D8  ori.b  #$0, d7
00C092DC  move.w d0, d7
00C092DE  ori.b  #$0, d0
00C092E2  btst.l d0, d0
00C092E4  ; data: 0x4c, 0x1e
00C092E6  dc.w   $f61e
00C092EC  moveq  #$1e, d0
00C092EE  dc.w   $f002
00C092F0  moveq  #$1, d6
00C092F2  ori.b  #$0, d0
00C092F6  ori.b  #$ef, d2
00C092FA  dc.w   $fe67
00C092FC  abcd.b d0, d0
00C092FE  moveq  #$df, d5
00C09300  ; data: 0x8c, 0x3f
00C09302  dc.w   $f83b
00C09304  dc.w   $f800
00C09306  ori.b  #$0, d0
00C0930A  ori.b  #$e1, d3
00C0930E  dc.w   $fa3b
00C09310  ; data: 0xe0, 0xc0
00C09312  dc.w   $62ff
00C09314  ; data: 0xb0, 0x7f
00C09316  add.b  d1, d4
00C09318  add.b  d0, d6
00C0931A  ori.b  #$0, d0
00C0931E  ori.w  #$c7d6, d1
00C09322  moveq  #$7d, d4
00C09324  and.w  d4, ([$c3bfe00a])
00C0932C  bra.w  $c0932e
00C09330  ori.b  #$30, d0
00C09334  beq.b  $c09334
00C09336  ; data: 0x03, 0xfc
00C09338  ror.w  d0, d0
00C0933A  ; data: 0x05, 0xff
00C0933C  dc.w   $8580
00C0933E  ori.b  #$0, d2
00C09342  ori.b  #$0, d0
00C09346  ori.b  #$fe, d0
00C0934A  ; data: 0x03, 0xfc
00C0934C  ror.w  d0, d0
00C0934E  ; data: 0x05, 0xff
00C09350  dc.w   $8580
00C09352  ori.b  #$8, d2
00C09356  ori.b  #$0, d0
00C0935A  ori.b  #$ff, d1
00C0935E  ; data: 0x01, 0xfc
00C09360  add.l  a2, d3
00C09362  ; data: 0x04, 0x3f
00C09364  and.b  -(a0), d0
00C09366  ori.b  #$8, d5
00C0936A  ori.b  #$0, d0
00C0936E  ori.b  #$ff, d0
00C09372  ; data: 0xf9, 0xa0
00C09374  dc.w   $f831
00C09376  divs.w (a1)+, d0
00C09378  bclr.b d2, d0
00C0937A  ori.b  #$10, d2
00C0937E  ori.b  #$0, d0
00C09382  ori.b  #$ff, d0
00C09386  cmp.w  d0, d3
00C09388  dc.w   $fe01
00C0938A  muls.w -(a7), d1
00C0938C  btst.b #$0, d0
00C09390  ori.b  #$0, (a0)
00C09394  ori.b  #$0, d0
00C09398  ; data: 0x43, 0xe7
00C0939A  ; data: 0x0e, 0x60
00C0939C  dc.w   $fe73
00C0939E  and.b  d0, (a0)
00C093A0  or.b   d0, d0
00C093A2  ori.b  #$20, d0
00C093A6  ori.b  #$0, d0
00C093AA  ori.b  #$f8, d0
00C093AE  move.w -(a0), d6
00C093B0  move.b $c0d6c3(pc), $4000(a7)
00C093B6  ; data: 0x00, 0x3f
00C093B8  asr.b  #$8, d0
00C093BA  ori.b  #$0, d0
00C093BE  ori.b  #$c8, d0
00C093C2  bclr.b d3, (a4)+
00C093C4  ; data: 0xd0, 0x0d
00C093C6  ; data: 0xc0, 0x0f
00C093C8  bclr.b d4, d0
00C093CA  ; data: 0x00, 0x7f
00C093CC  add.b  d0, d6
00C093CE  ori.b  #$0, d0
00C093D2  ori.b  #$c8, d0
00C093D6  bclr.b d3, (a4)+
00C093D8  ; data: 0xd0, 0x0d
00C093DA  ; data: 0xc0, 0x0f
00C093DC  bclr.b d4, d0
00C093DE  ; data: 0x00, 0x7f
00C093E0  add.w  d0, d6
00C093E2  ori.b  #$0, d0
00C093E6  ori.b  #$7, d0
00C093EA  chk.w  d7, d5
00C093EC  move.w d2, -(a0)
00C093EE  ; data: 0x00, 0x0f
00C093F0  ; data: 0x79, 0x80
00C093F2  ; data: 0x09, 0x3f
00C093F4  dc.w   $fc00
00C093F6  ori.b  #$0, d0
00C093FA  ori.b  #$1, d0
00C093FE  divs.w (a3)+, d1
00C09400  adda.w $1f(a3, a2.w), a0
00C09404  cmpa.l -(a0), a7
00C09406  ; data: 0x0e, 0x4b
00C09408  dc.w   $fc00
00C0940A  ori.b  #$0, d0
00C0940E  ori.b  #$6, d0
00C09412  ; data: 0xc3, 0xbb
00C09414  ; data: 0x39, 0xf3
00C09416  ; data: 0xa0, 0x07
00C09418  ; data: 0xf9, 0xbc
00C0941A  move.w d2, (a4)
00C0941C  moveq  #$80, d4
00C0941E  ori.b  #$0, d0
00C09422  ori.b  #$10, d0
00C09426  dc.w   $f87c
00C09428  ; data: 0x00, 0x7f
00C0942A  or.b   d1, d0
00C0942C  ; data: 0x77, 0xe3
00C0942E  ror.b  d4, d4
00C09430  ori.b  #$0, d0
00C09434  ori.b  #$0, d0
00C09438  ori.b  #$7f, d0
00C0943C  ; data: 0x09, 0xff
00C0943E  and.b  d0, d0
00C09440  ; data: 0xf5, 0xff
00C09442  ; data: 0xf6, 0x7e
00C09444  move.b d0, -(a7)
00C09446  ori.b  #$0, d0
00C0944A  ori.b  #$0, d0
00C0944E  ; data: 0x08, 0x23
00C09450  ; data: 0xc9, 0x7f
00C09452  ori.b  #$7f, d0
00C09456  ; data: 0x21, 0xff
00C09458  asl.b  #$3, d0
00C0945A  ori.b  #$0, d0
00C0945E  ori.b  #$0, d0
00C09462  ; data: 0x08, 0x23
00C09464  ; data: 0xc9, 0x7e
00C09466  ori.b  #$7f, d0
00C0946A  ; data: 0x21, 0xff
00C0946C  asr.b  #$3, d0
00C0946E  ori.b  #$0, d0
00C09472  ori.b  #$0, d0
00C09476  ori.b  #$fe, d1
00C0947A  ; data: 0x00, 0x08
00C0947C  bset.b d6, (a6)+
00C0947E  ; data: 0x07, 0xff
00C09480  dc.w   $fe00
00C09482  ori.b  #$0, d0
00C09486  ori.b  #$0, d0
00C0948A  ; data: 0x40, 0x3f
00C0948C  and.b  d0, d0
00C0948E  ori.b  #$fc, d4
00C09492  ; data: 0x00, 0xff
00C09494  and.b  d0, d1
00C09496  ori.b  #$0, d0
00C0949A  ori.b  #$0, d0
00C0949E  ori.b  #$8, d7
00C094A2  ori.b  #$c0, d4
00C094A6  ; data: 0x01, 0x7f
00C094A8  and.b  d0, d0
00C094AA  ori.b  #$0, d0
00C094AE  ori.b  #$0, d0
00C094B2  ori.b  #$c0, (a7)+
00C094B6  ori.b  #$0, d0
00C094BA  move.b (a4, d0.w), $0(a0)
00C094C0  ori.b  #$0, d0
00C094C4  ori.b  #$27, d0
00C094C8  asr.l  #$7, d0
00C094CA  ori.b  #$0, (a1)
00C094CE  ori.w  #$d000, d5
00C094D2  ori.b  #$0, d0
00C094D6  ori.b  #$0, d0
00C094DA  ori.b  #$0, d5
00C094DE  ori.b  #$0, d0
00C094E2  ori.l  #$80000000, $0(a7)
00C094EA  ori.b  #$0, d0
00C094EE  ori.b  #$0, d5
00C094F2  ori.b  #$0, d0
00C094F6  ; data: 0x00, 0x8f
00C094F8  or.b   d0, d0
00C094FA  ori.b  #$0, d0
00C094FE  ori.b  #$0, d0
00C09502  ; data: 0x00, 0x08
00C09504  dc.w   $f600
00C0950A  move.w $0.w, (a4)+
00C0950E  ori.b  #$0, d0
00C09512  ori.b  #$0, d0
00C09516  ori.b  #$0, d0
00C0951A  ori.b  #$0, d0
00C0951E  ori.b  #$0, d0
00C09522  ori.b  #$0, d0
00C09526  ori.b  #$0, d0
00C0952A  ori.b  #$0, d0
00C0952E  ori.b  #$0, d0
00C09532  ; data: 0x00, 0x0b
00C09534  and.b  d0, d0
00C09536  ori.b  #$0, d0
00C0953A  ori.b  #$0, d0
00C0953E  ori.b  #$0, d0
00C09542  ori.b  #$0, d0
00C09546  ; data: 0x00, 0x7f
00C09548  asr.b  #$8, d0
00C0954A  ori.b  #$0, d0
00C0954E  ori.b  #$0, d0
00C09552  ori.b  #$0, d0
00C09556  ori.b  #$0, d0
00C0955A  ; data: 0x00, 0x7f
00C0955C  asr.b  #$8, d0
00C0955E  ori.b  #$0, d0
00C09562  ori.b  #$0, d0
00C09566  ori.b  #$0, d0
00C0956A  ori.b  #$0, d0
00C0956E  ; data: 0x00, 0x7f
00C09570  asr.b  #$8, d0
00C09572  ori.b  #$0, d0
00C09576  ori.b  #$0, d0
00C0957A  ori.b  #$0, d0
00C0957E  ori.b  #$0, d0
00C09582  ; data: 0x01, 0xff
00C09584  and.b  d0, d0
00C09586  ori.b  #$0, d0
00C0958A  ori.b  #$0, d0
00C0958E  ori.b  #$0, d0
00C09592  ori.b  #$0, d0
00C09596  ; data: 0x0f, 0xff
00C09598  and.b  d0, d0
00C0959A  ori.b  #$0, d0
00C0959E  ori.b  #$0, d0
00C095A2  ori.b  #$0, d0
00C095A6  ori.b  #$0, d0
00C095AA  ; data: 0x3f, 0xf8
00C095AC  ori.b  #$0, d0
00C095B0  ori.b  #$0, d0
00C095B4  ori.b  #$1, d0
00C095B8  ori.b  #$0, d0
00C095BC  or.b   d0, d0
00C095BE  ; data: 0xff, 0xff
00C095C0  and.b  d0, d0
00C095C2  ori.b  #$0, d0
00C095C6  ori.b  #$0, d0
00C095CA  ori.b  #$0, d1
00C095CE  move.b d0, d0
00C095D0  ori.b  #$ff, d1
00C095D4  or.b   d0, d0
00C095D6  ori.b  #$0, d0
00C095DA  ori.b  #$0, d0
00C095DE  bchg.b d0, -(a2)
00C095E0  and.b  d0, d0
00C095E2  negx.b d0
00C095E4  ori.b  #$ff, d3
00C095E8  or.b   d0, d0
00C095EA  ori.b  #$0, d0
00C095EE  ori.b  #$6, d0
00C095F2  ori.w  #$c002, -(a2)
00C095F6  ori.b  #$3, d0
00C095FA  ; data: 0xff, 0xff
00C095FC  or.b   d0, d0
00C095FE  ori.b  #$0, d0
00C09602  ori.b  #$0, d0
00C09606  bset.b d5, (a5)+
00C09608  and.b  d0, d0
00C0960A  ori.b  #$7, d0
00C0960E  ; data: 0xd8, 0x3f
00C09610  or.b   d0, d0
00C09612  ori.b  #$0, d0
00C09616  ori.b  #$0, d0
00C0961A  ; data: 0xb7, 0xbc
00C0961C  ori.w  #$0, d0
00C09620  move.w d3, d0
00C09622  dc.w   $fe0b
00C09624  or.b   d0, d0
00C09626  ori.b  #$0, d0
00C0962A  ori.b  #$0, d0
00C0962E  cmpa.l (a4)+, a1
00C09630  move.l d2, d0
00C09632  move.b d0, d4
00C09634  ori.b  #$0, d7
00C09638  ori.b  #$0, d0
00C0963C  ori.b  #$0, d0
00C09640  ori.b  #$c0, d0
00C09644  ; data: 0x00, 0x08
00C09646  ; data: 0x00, 0x08
00C09648  ori.b  #$0, (a7)
00C0964C  ori.b  #$0, d0
00C09650  ori.b  #$0, d0
00C09654  ; data: 0x00, 0x08
00C09656  ; data: 0x2b, 0xc0
00C09658  and.b  d0, d0
00C0965A  ori.b  #$7, d0
00C0965E  asl.b  #$3, d0
00C09660  ori.b  #$0, d0
00C09664  ori.b  #$0, d0
00C09668  ; data: 0x00, 0x08
00C0966A  bls.b  $c095ef
00C0966C  ori.b  #$20, d0
00C09670  ori.b  #$0, d7
00C09674  ori.b  #$0, d0
00C09678  ori.b  #$0, d0
00C0967C  ; data: 0x00, 0x08
00C0967E  beq.b  $c09683
00C09680  ori.b  #$c1, d0
00C09684  ori.b  #$0, d7
00C09688  ori.b  #$0, d0
00C0968C  ori.b  #$0, d0
00C09690  ori.b  #$3, d0
00C09694  ori.b  #$0, d0
00C09698  ori.b  #$c0, (a7)
00C0969C  ori.b  #$0, d0
00C096A0  ori.b  #$0, d0
00C096A4  ori.b  #$3, d6
00C096A8  ori.b  #$1, d0
00C096AC  ori.b  #$c0, (a6)
00C096B0  ori.b  #$0, d0
00C096B4  ori.b  #$0, d0
00C096B8  ; data: 0x00, 0x0e
00C096BA  bclr.b d2, d0
00C096BC  ori.b  #$3, d0
00C096C0  ; data: 0x40, 0x3f
00C096C2  dc.w   $f800
00C096C4  ori.b  #$0, d0
00C096C8  ori.b  #$0, d0
00C096CC  ; data: 0x00, 0x0e
00C096CE  move.w d2, d7
00C096D0  ori.b  #$0, d0
00C096D4  ori.b  #$80, (a7)+
00C096D8  ori.b  #$0, d0
00C096DC  ori.b  #$0, d0
00C096E0  ori.b  #$80, d7
00C096E4  ori.b  #$0, d0
00C096E8  ori.b  #$0, (a7)+
00C096EC  ori.b  #$0, d0
00C096F0  ori.b  #$0, d0
00C096F4  ori.b  #$98, (a3)
00C096F8  ori.b  #$30, d0
00C096FC  ori.b  #$0, (a7)+
00C09700  ori.b  #$0, d0
00C09704  ori.b  #$0, d0
00C09708  ori.b  #$90, (a1)
00C0970C  ori.b  #$30, d0
00C09710  ori.b  #$0, (a7)+
00C09714  ori.b  #$0, d0
00C09718  ori.b  #$0, d0
00C0971C  ori.b  #$20, d0
00C09720  ori.b  #$e0, d0
00C09724  ori.b  #$0, (a7)+
00C09728  ori.b  #$0, d0
00C0972C  ori.b  #$0, d0
00C09730  ori.b  #$0, d0
00C09734  ori.b  #$0, d0
00C09738  ; data: 0x00, 0x3f
00C0973A  ori.b  #$0, d0
00C0973E  ori.b  #$0, d0
00C09742  ori.b  #$0, d0
00C09746  moveq  #$0, d7
00C09748  ori.b  #$0, d0
00C0974C  ; data: 0x00, 0x3a
00C0974E  ori.b  #$0, d0
00C09752  ori.b  #$0, d0
00C09756  ori.b  #$27, d0
00C0975A  dc.w   $fe00
00C0975C  ori.b  #$0, d0
00C09760  ; data: 0x00, 0x3f
00C09762  dc.w   $f000
00C09764  ori.b  #$0, d0
00C09768  ori.b  #$0, d0
00C0976C  ; data: 0x00, 0x0e
00C0976E  dc.w   $fe00
00C09770  ori.b  #$0, d0
00C09774  ; data: 0x00, 0x3f
00C09776  dc.w   $f000
00C09778  ori.b  #$0, d0
00C0977C  ori.b  #$0, d0
00C09780  ori.b  #$0, (a0)+
00C09784  ori.b  #$38, d0
00C09788  ; data: 0x00, 0x7f
00C0978A  dc.w   $f000
00C0978C  ori.b  #$0, d0
00C09790  ori.b  #$0, d0
00C09794  ori.b  #$0, (a0)+
00C09798  ori.b  #$38, d0
00C0979C  ; data: 0x00, 0x7f
00C0979E  dc.w   $f000
00C097A0  ori.b  #$0, d0
00C097A4  ori.b  #$0, d0
00C097A8  ori.w  #$7c00, (a1)+
00C097AC  ori.b  #$6, d0
00C097B0  ; data: 0x00, 0x7f
00C097B2  dc.w   $f000
00C097B4  ori.b  #$0, d0
00C097B8  ori.b  #$0, d0
00C097BC  ori.b  #$0, $e.l
00C097C4  ; data: 0x30, 0x7f
00C097C6  and.b  d0, d0
00C097C8  ori.b  #$0, d0
00C097CC  ori.b  #$0, d0
00C097D0  ori.b  #$0, $0.w
00C097D6  ori.b  #$3f, (a0, d0.w)
00C097DC  ori.b  #$0, d0
00C097E0  ori.b  #$0, d0
00C097E4  ; data: 0x00, 0xf8
00C097E6  moveq  #$0, d7
00C097E8  ori.b  #$37, d0
00C097EC  ; data: 0x40, 0x3e
00C097EE  ori.b  #$0, d0
00C097F2  ori.b  #$0, d0
00C097F6  ori.b  #$71, d0
00C097FA  moveq  #$40, d6
00C097FC  ori.b  #$7, d0
00C09800  dc.w   $f83e
00C09802  ori.b  #$0, d0
00C09806  ori.b  #$0, d0
00C0980A  ori.b  #$61, d0
00C0980E  moveq  #$40, d6
00C09810  ori.b  #$6, d0
00C09814  dc.w   $f83c
00C09816  ori.b  #$0, d0
00C0981A  ori.b  #$0, d0
00C0981E  ori.b  #$e1, d0
00C09822  moveq  #$40, d6
00C09824  ori.b  #$6, d0
00C09828  dc.w   $f83c
00C0982A  ori.b  #$0, d0
00C0982E  ori.b  #$0, d0
00C09832  ori.b  #$ee, d0
00C09836  dc.w   $fe00
00C09838  ori.b  #$1, d0
00C0983C  dc.w   $f83c
00C0983E  ori.b  #$0, d0
00C09842  ori.b  #$0, d0
00C09846  ori.b  #$e0, d0
00C0984A  move.w d0, d6
00C0984C  ori.b  #$7, d0
00C09850  ; data: 0xf0, 0x7e
00C09852  ori.b  #$0, d0
00C09856  ori.b  #$0, d0
00C0985A  ori.b  #$f8, d0
00C0985E  move.w d0, d6
00C09860  ori.b  #$1, d0
00C09864  ; data: 0x48, 0x7f
00C09866  ori.b  #$0, d0
00C0986A  ori.b  #$0, d0
00C0986E  ori.b  #$f0, d0
00C09872  move.w -(a0), d7
00C09874  ori.b  #$0, d0
00C09878  ; data: 0x08, 0x7f
00C0987A  ori.b  #$0, d0
00C0987E  ori.b  #$0, d0
00C09882  ori.b  #$f0, d0
00C09886  move.w d0, d4
00C09888  ori.b  #$0, d0
00C0988C  ; data: 0x04, 0x7f
00C0988E  ; data: 0xa0, 0x00
00C09890  ori.b  #$0, d0
00C09894  ori.b  #$0, d0
00C09898  bset.b d0, -(a0)
00C0989A  move.w d0, d4
00C0989C  btst.l d0, d0
00C0989E  move.l d0, d0
00C098A0  ; data: 0x37, 0xff
00C098A2  and.b  d0, d4
00C098A4  ori.b  #$0, d0
00C098A8  ori.b  #$0, d0
00C098AC  bset.b d0, -(a0)
00C098AE  move.w d0, d4
00C098B0  btst.l d0, d0
00C098B2  move.w d0, d4
00C098B4  ; data: 0x37, 0xff
00C098B6  and.b  d0, d0
00C098B8  ori.b  #$0, d0
00C098BC  ori.b  #$0, d0
00C098C0  bset.b d4, $3818.w
00C098C4  move.b -$40(a0, d0.w), $e7f(a3)
00C098CA  dc.w   $f800
00C098CC  ori.b  #$0, d0
00C098D0  ori.b  #$0, d0
00C098D4  bset.b d2, $21(a0, d0.l)
00C098D8  asr.w  #$7, d4
00C098DA  ; data: 0x1f, 0xc0
00C098DC  bset.b d7, -(a7)
00C098DE  ble.b  $c09860
00C098E0  ori.b  #$0, d0
00C098E4  ori.b  #$0, d0
00C098E8  bset.b d3, $3b(a0, d3.l)
00C098EC  ; data: 0x01, 0xff
00C098EE  dc.w   $ff20
00C098F0  ; data: 0x1b, 0xbe
00C098F2  ; data: 0x3f, 0xf1
00C098F4  sub.b  d0, d4
00C098F6  ori.b  #$80, d0
00C098FA  ori.b  #$d0, d0
00C098FE  moveq  #$0, d4
00C09900  ; data: 0x00, 0xff
00C09902  dc.w   $ff30
00C09904  andi.b #$c2, d6
00C09908  move.w d0, d4
00C0990A  ori.b  #$0, d0
00C0990E  ori.b  #$de, d0
00C09912  move.w d0, d4
00C09914  ; data: 0x01, 0xff
00C09916  ; data: 0xff, 0xe0
00C09918  ; data: 0x4c, 0x00
00C0991A  bset.b d0, (a0, d6.w)
00C0991E  ori.b  #$0, d0
00C09922  ori.b  #$e6, d0
00C09926  moveq  #$0, d6
00C09928  ; data: 0x08, 0x7f
00C0992A  cmpa.l d0, a7
00C0992C  dc.w   $f800
00C0992E  bset.b d0, -$80(a0, d7.l)
00C09932  ori.b  #$30, d1
00C09936  ori.b  #$e6, d0
00C0993A  moveq  #$0, d6
00C0993C  ; data: 0x08, 0x7f
00C0993E  cmpa.l d0, a7
00C09940  dc.w   $f800
00C09942  bset.b d0, -$40(a0, d7.l)
00C09946  ori.b  #$30, (a7)
00C0994A  ori.b  #$e8, d0
00C0994E  cmp.b  d0, d7
00C09950  move.b $fffffe00.l, (a7)+
00C09956  bset.b d0, (a1, a7.l * 2)
00C0995A  ; data: 0x00, 0x3e
00C0995C  dc.w   $f030
00C0995E  ori.b  #$ee, d0
00C09962  ; data: 0x7f, 0xa1
00C09964  ; data: 0xff, 0xfb
00C09966  ; data: 0xff, 0xff
00C09968  ; data: 0xff, 0xe0
00C0996A  bset.b d7, (invalid.w)
00C0996E  ; data: 0x02, 0x7e
00C09970  and.b  (a0, d0.w), d0
00C09974  bset.b d7, -(a6)
00C09976  ; data: 0xff, 0xdd
00C09978  ; data: 0xff, 0xba
00C0997A  ; data: 0x7f, 0xff
00C0997C  muls.w d0, d7
00C0997E  ; data: 0x1f, 0xfc
00C09980  bcs.b  $c09943
00C09982  chk.w  -(a7), d3
00C09984  btst.b #$1, $7fffffc9(invalid.w)
00C0998E  ; data: 0xff, 0xff
00C09990  bset.b d3, d0
00C09992  ; data: 0x1f, 0xfb
00C09994  dc.w   $fa08
00C09996  movea.w $30.w, a7
00C0999A  ori.b  #$f8, d0
00C0999E  ; data: 0x3f, 0xff
00C099A0  ; data: 0xff, 0x80
00C099A2  bne.b  $c099c3
00C099A4  move.w d0, $18c00fb8(invalid.w)
00C099AC  movea.w $2(a0, d0.w), a0
00C099B0  ; data: 0x27, 0xd9
00C099B2  ; data: 0x3f, 0xff
00C099B4  dc.w   $fe00
00C099B6  ori.b  #$0, d0
00C099BA  move.w (a0, d0.w), (a7, d3.w * 8)
00C099C0  move.w $2(a0, d0.w), (a0)+
00C099C4  bset.b d1, (a1)+
00C099C6  ; data: 0x3f, 0xff
00C099C8  dc.w   $fe00
00C099CA  ori.b  #$0, d0
00C099CE  move.w (a0, d0.w), (a7, d3.w * 8)
00C099D4  move.w -(a0), (a0)+
00C099D6  ori.b  #$f0, d0
00C099DA  ; data: 0x7f, 0xff
00C099DC  exg.l  d3, a0
00C099DE  ori.b  #$0, (a1, invalid.w)
00C099E4  ori.b  #$4, d0
00C099E8  ; data: 0xe9, 0xe0
00C099EA  ori.b  #$3e, d0
00C099EE  moveq  #$1b, d7
00C099F0  abcd.b d0, d0
00C099F2  ori.b  #$0, (a7)+
00C099F6  ; data: 0xf1, 0xf8
00C099F8  ori.b  #$23, d0
00C099FC  bset.b d0, d0
00C099FE  ori.b  #$f9, d0
00C09A02  dc.w   $f000
00C09A04  and.b  $3f(a0, d0.w), d4
00C09A08  ; data: 0xfd, 0xc0
00C09A0A  ; data: 0x01, 0xfe
00C09A0C  ori.b  #$3, d0
00C09A10  move.l d0, d0
00C09A12  ori.b  #$f6, d4
00C09A16  dc.w   $f400
00C09A18  ori.b  #$ff, d0
00C09A1C  dc.w   $fe40
00C09A1E  bchg.b d4, $0.w
00C09A22  bclr.b d4, (a7)+
00C09A24  and.b  d0, d0
00C09A26  ori.b  #$f0, d4
00C09A2A  and.b  d2, d0
00C09A2C  move.l d0, d0
00C09A2E  ; data: 0x01, 0xff
00C09A30  ; data: 0xff, 0xc0
00C09A32  ori.l  #$3e20, d0
00C09A38  ori.b  #$4, d0
00C09A3C  movep.l d0, $400(a6)
00C09A40  ; data: 0x08, 0x00
00C09A42  ; data: 0x41, 0xff
00C09A44  ; data: 0xf1, 0xc0
00C09A46  ori.w  #$0, (invalid.w)
00C09A4E  ori.b  #$ce, d4
00C09A52  subi.b #$0, d0
00C09A56  ; data: 0x41, 0xff
00C09A58  ; data: 0xf1, 0xc0
00C09A5A  ori.w  #$0, (invalid.w)
00C09A60  ori.b  #$4, d0
00C09A64  btst.l d0, d0
00C09A66  subi.b #$71, (a0)+
00C09A6A  ; data: 0xc1, 0xff
00C09A6C  ; data: 0xf9, 0x80
00C09A6E  ori.b  #$1, d0
00C09A72  ; data: 0xff, 0x80
00C09A74  ori.b  #$0, d0
00C09A78  btst.l d1, d0
00C09A7A  ori.b  #$c9, d0
00C09A7E  and.b  $fdd80001.l, d1
00C09A84  or.b   d7, d0
00C09A86  dc.w   $f660
00C09A88  move.b d0, d0
00C09A8A  ori.b  #$0, d0
00C09A8E  ; data: 0x08, 0x07
00C09A90  dc.w   $ff79
00C09A92  asr.w  $40(a6, a3.w)
00C09A96  ori.b  #$1, d0
00C09A9A  muls.w d0, d6
00C09A9C  ori.b  #$0, d0
00C09AA0  ; data: 0x1f, 0xfe
00C09AA2  move.w (a7)+, d4
00C09AA4  ; data: 0xff, 0xf2
00C09AA6  bsr.b  $c09a90
00C09AA8  ; data: 0xc3, 0x80
00C09AAA  ori.b  #$1, $fd802000.l
00C09AB2  ori.b  #$ff, d0
00C09AB6  move.w -(a1), d6
00C09AB8  ; data: 0xef, 0xc9
00C09ABA  dc.w   $f82f
00C09ABC  move.w d0, d6
00C09ABE  ori.b  #$f, d0
00C09AC2  dc.w   $f840
00C09AC4  ori.b  #$8, d0
00C09AC8  ; data: 0x00, 0xff
00C09ACA  dc.w   $f01f
00C09ACC  ; data: 0xff, 0xc9
00C09ACE  dc.w   $fa10
00C09AD0  subi.b #$0, d0
00C09AD4  move.b d7, d6
00C09AD6  dc.w   $f800
00C09AD8  negx.b d0
00C09ADA  ; data: 0x00, 0x08
00C09ADC  ; data: 0x00, 0xff
00C09ADE  dc.w   $f01f
00C09AE0  ; data: 0xff, 0xc9
00C09AE2  dc.w   $fa10
00C09AE4  subi.b #$0, d0
00C09AE8  move.b d7, d6
00C09AEA  dc.w   $f800
00C09AEC  ori.b  #$8, d0
00C09AF0  ; data: 0x00, 0xff
00C09AF2  move.w d1, d0
00C09AF4  move.w d0, $3eef(a7)
00C09AF8  move.w d0, d6
00C09AFA  ori.b  #$1f, d0
00C09AFE  dc.w   $f000
00C09B00  or.b   d0, d0
00C09B02  ; data: 0x00, 0x08
00C09B04  ; data: 0x04, 0x3f
00C09B06  dc.w   $f801
00C09B08  add.l  d7, $2f(a0, d1.l)
00C09B0C  or.b   d6, d0
00C09B0E  ori.b  #$7, d0
00C09B12  moveq  #$0, d0
00C09B14  ori.b  #$c, d0
00C09B18  ori.b  #$0, (a7)+
00C09B1C  addi.l #$5e06001a, d0
00C09B22  ori.b  #$f, d0
00C09B26  moveq  #$0, d0
00C09B28  ori.b  #$c, d0
00C09B2C  ; data: 0x18, 0xfe
00C09B2E  and.b  d1, d0
00C09B30  exg.l  a0, a4
00C09B32  move.w d0, d6
00C09B34  ori.b  #$0, -(a3)
00C09B38  move.w d0, d7
00C09B3A  moveq  #$1, d0
00C09B3C  ori.b  #$c, d0
00C09B40  ; data: 0x07, 0xff
00C09B42  or.b   d3, d0
00C09B44  ; data: 0xff, 0xf7
00C09B46  dc.w   $f801
00C09B48  ori.b  #$0, -(a1)
00C09B4C  btst.l d2, d0
00C09B4E  asr.b  #$8, d0
00C09B50  ori.b  #$e, d0
00C09B54  ; data: 0x07, 0xbf
00C09B56  or.b   d3, d0
00C09B58  ; data: 0xd0, 0xff
00C09B5A  asr.b  #$8, d7
00C09B5C  ori.b  #$0, -(a0)
00C09B60  ; data: 0x00, 0x0f
00C09B62  asr.b  #$8, d0
00C09B64  ori.b  #$8, d0
00C09B68  btst.l d3, $c09b6d(pc, a0.w)
00C09B6C  ; data: 0xd0, 0xff
00C09B6E  asr.b  #$8, d7
00C09B70  ori.b  #$0, -(a2)
00C09B74  ; data: 0x00, 0x0f
00C09B76  and.b  d0, d0
00C09B78  ori.b  #$c, d0
00C09B7C  bset.b d1, $3(a0, d0.w)
00C09B80  rol.w  d4, d7
00C09B82  and.b  d0, d0
00C09B84  ori.b  #$0, (a5)
00C09B88  ; data: 0x03, 0xff
00C09B8A  or.b   d0, d0
00C09B8C  ori.b  #$8, d0
00C09B90  bset.b d3, $4003(a6)
00C09B94  rol.l  d0, d6
00C09B96  ori.b  #$10, d0
00C09B9A  asr.b  #$4, d0
00C09B9C  ; data: 0x1f, 0xff
00C09B9E  ori.b  #$0, d0
00C09BA2  ; data: 0x00, 0x0c
00C09BA4  bset.b d3, -(a7)
00C09BA6  neg.b  d0
00C09BA8  abcd.b d0, d0
00C09BAA  ori.b  #$0, d0
00C09BAE  addi.b #$f8, d0
00C09BB2  or.b   d0, d0
00C09BB4  ori.b  #$8, d0
00C09BB8  ; data: 0x03, 0xff
00C09BBA  and.b  d0, d6
00C09BBC  ori.b  #$0, d0
00C09BC0  ori.w  #$0, -(a0)
00C09BC4  ; data: 0x7f, 0xe0
00C09BC6  ori.b  #$0, d0
00C09BCA  ; data: 0x00, 0x0e
00C09BCC  ; data: 0x01, 0xff
00C09BCE  dc.w   $fc00
00C09BD0  ori.b  #$0, d0
00C09BD4  ori.w  #$4000, d0
00C09BD8  ; data: 0x7f, 0x20
00C09BDA  ori.b  #$0, d0
00C09BDE  ori.b  #$ff, d6
00C09BE2  cmp.b  d0, d7
00C09BE4  ori.b  #$fe, d0
00C09BE8  ori.w  #$2001, d0
00C09BEC  add.w  d0, d7
00C09BEE  ori.b  #$0, d0
00C09BF2  ori.b  #$ff, d7
00C09BF6  cmp.b  d0, d7
00C09BF8  ori.b  #$fe, d0
00C09BFC  ori.w  #$8001, d0
00C09C00  add.b  d0, d7
00C09C02  ori.b  #$0, d0
00C09C06  ; data: 0x00, 0x0c
00C09C08  bset.b d1, (a7)+
00C09C0A  ; data: 0xff, 0xc0
00C09C0C  ori.b  #$ff, d0
00C09C10  bset.b d3, $3.w
00C09C14  ; data: 0xa4, 0x00
00C09C16  ori.b  #$0, d0
00C09C1A  ; data: 0x00, 0x0a
00C09C1C  movep.l d3, -$20(a0)
00C09C20  ori.b  #$ff, d0
00C09C24  ; data: 0xff, 0xfb
00C09C26  ; data: 0x08, 0x03
00C09C28  move.b (a0), (a2)+
00C09C2A  andi.b #$0, d0
00C09C2E  ; data: 0x00, 0x08
00C09C30  bset.b d3, (a6)+
00C09C32  cmpa.l #$183f, a3
00C09C38  ; data: 0xff, 0xf9
00C09C3A  move.w a7, d0
00C09C3C  move.b d0, d5
00C09C3E  subi.b #$0, d0
00C09C42  ; data: 0x00, 0x0c
00C09C44  ; data: 0x1f, 0xe1
00C09C46  ; data: 0xf7, 0xfc
00C09C48  ori.b  #$7, d0
00C09C4C  divs.w d0, d3
00C09C4E  ; data: 0x00, 0xbf
00C09C50  movep.l d3, $800(a0)
00C09C54  ori.b  #$c, d0
00C09C58  ; data: 0x07, 0xff
00C09C5A  ori.w  #$0, sr
00C09C5E  ori.b  #$80, $11fd(a7)
00C09C64  bset.b d7, $0.w
00C09C68  ori.b  #$6, d0
00C09C6C  bset.b d3, $3c(a1, d0.w)
00C09C70  ori.l  #$60000, d0
00C09C76  ; data: 0x01, 0x7e
00C09C78  move.b (a0, d0.w), (a7)+
00C09C7C  ori.b  #$6, d0
00C09C80  bset.b d3, $3c(a1, d0.w)
00C09C84  ori.l  #$60000, d0
00C09C8A  ori.w  #$3ef0, $0(a4)
00C09C90  ori.b  #$7, d0
00C09C94  ; data: 0x83, 0xff
00C09C96  or.b   -(a3), d0
00C09C98  btst.l d0, d0
00C09C9A  ori.b  #$0, d0
00C09C9E  ori.w  #$7fe0, (a4)+
00C09CA2  ori.b  #$0, d0
00C09CA6  ori.b  #$ff, d3
00C09CAA  and.b  d1, d0
00C09CAC  abcd.b d0, d3
00C09CAE  bset.b d0, -(a0)
00C09CB0  ori.b  #$f9, d2
00C09CB4  ; data: 0xff, 0xc0
00C09CB6  ori.b  #$0, d0
00C09CBA  ori.b  #$ff, d3
00C09CBE  and.b  (a0)+, d0
00C09CC0  ; data: 0x3f, 0xc0
00C09CC2  bset.b d1, -(a0)
00C09CC4  andi.b #$77, d1
00C09CC8  ; data: 0xff, 0xf0
00C09CCA  ori.b  #$0, d0
00C09CCE  ori.b  #$ff, d1
00C09CD2  and.b  -(a0), d0
00C09CD4  move.w d4, d3
00C09CD6  ori.b  #$3, d0
00C09CDA  dc.w   $fef7
00C09CDC  ; data: 0xfb, 0xf8
00C09CDE  ori.b  #$0, d0
00C09CE2  ori.b  #$ff, d1
00C09CE6  dc.w   $f805
00C09CE8  move.b $6(a3, a0.w), d0
00C09CEC  bclr.b d7, d0
00C09CEE  ; data: 0xff, 0xff
00C09CF0  ; data: 0xff, 0xf8
00C09CF2  ori.b  #$0, d0
00C09CF6  ori.b  #$ff, d0
00C09CFA  and.b  (a5)+, d4
00C09CFC  ori.b  #$8, d0
00C09D00  bset.b d7, d5
00C09D02  ; data: 0x3f, 0xef
00C09D04  ; data: 0xff, 0xfe
00C09D06  ori.b  #$0, d0
00C09D0A  ori.b  #$ff, d0
00C09D0E  and.b  (a5)+, d4
00C09D10  ori.b  #$8, d0
00C09D14  bset.b d7, d3
00C09D16  ; data: 0x3f, 0xdf
00C09D18  ; data: 0xff, 0xfc
00C09D1A  ori.b  #$0, d0
00C09D1E  ori.b  #$ff, d0
00C09D22  cmp.b  d5, d4
00C09D24  and.b  ([$380effdf, a0], d3.l * 8, $fff8), d0
00C09D2E  ori.b  #$0, d0
00C09D32  ori.b  #$3f, d0
00C09D36  dc.w   $f81b
00C09D38  dc.w   $f001
00C09D3A  ; data: 0xff, 0xf8
00C09D3C  ori.w  #$ff7f, (a5)+
00C09D40  ; data: 0xff, 0xf8
00C09D42  ori.b  #$0, d0
00C09D46  ori.b  #$ff, d0
00C09D4A  dc.w   $f01f
00C09D4C  lsr.l  #$8, d0
00C09D4E  dc.w   $6c0
00C09D50  ; data: 0x03, 0xbb
00C09D52  ; data: 0xcf, 0x7f
00C09D54  ; data: 0xff, 0xf0
00C09D56  ori.b  #$0, d0
00C09D5A  ori.b  #$1f, d0
00C09D5E  dc.w   $fe1d
00C09D60  mulu.w d0, d0
00C09D62  bset.b d0, d0
00C09D64  ; data: 0x08, 0x1f
00C09D66  ; data: 0xc0, 0xff
00C09D68  ; data: 0xff, 0xf0
00C09D6A  ori.b  #$0, d0
00C09D6E  ori.b  #$7, d0
00C09D72  ; data: 0xff, 0xe6
00C09D74  movep.w $1c0(a0), d7
00C09D78  moveq  #$1f, d0
00C09D7A  ; data: 0xef, 0xff
00C09D7C  ; data: 0xff, 0xe0
00C09D7E  ori.b  #$0, d0
00C09D82  ori.b  #$0, d0
00C09D86  ; data: 0x7f, 0xff
00C09D88  muls.w d0, d7
00C09D8A  bset.b d3, $803fefff.l
00C09D90  ; data: 0xff, 0xe0
00C09D92  ori.b  #$0, d0
00C09D96  ori.b  #$0, d0
00C09D9A  ; data: 0x7f, 0xff
00C09D9C  muls.w d0, d7
00C09D9E  bset.b d3, $803fefff.l
00C09DA4  ; data: 0xff, 0xe0
00C09DA6  ori.b  #$0, d0
00C09DAA  ori.b  #$0, d0
00C09DAE  ; data: 0xff, 0xbd
00C09DB0  ; data: 0xff, 0xc0
00C09DB2  ; data: 0x07, 0xff
00C09DB4  ; data: 0x80, 0x7f
00C09DB6  ; data: 0xff, 0xff
00C09DB8  ; data: 0xff, 0xe0
00C09DBA  ori.b  #$0, d0
00C09DBE  ori.b  #$10, d0
00C09DC2  ; data: 0x3f, 0xdb
00C09DC4  dc.w   $fe00
00C09DC6  ; data: 0x3f, 0xfe
00C09DC8  ; data: 0x81, 0xff
00C09DCA  ; data: 0xf7, 0x7f
00C09DCC  ; data: 0xff, 0xc0
00C09DCE  ori.b  #$0, d0
00C09DD2  ori.b  #$60, d0
00C09DD6  ; data: 0x0f, 0xff
00C09DD8  and.b  d0, d7
00C09DDA  bls.b  $c09dda
00C09DDC  ; data: 0x01, 0xff
00C09DDE  ; data: 0xf9, 0x01
00C09DE0  ; data: 0xff, 0xc0
00C09DE2  ori.b  #$0, d0
00C09DE6  ori.b  #$36, d0
00C09DEA  ; data: 0x0d, 0xbf
00C09DEC  dc.w   $fe00
00C09DEE  ; data: 0x3f, 0xf7
00C09DF0  ; data: 0x03, 0xff
00C09DF2  ; data: 0xff, 0x00
00C09DF4  ; data: 0x7f, 0xc0
00C09DF6  ori.b  #$0, d0
00C09DFA  ori.b  #$18, d0
00C09DFE  ; data: 0x03, 0xff
00C09E00  dc.w   $f600
00C09E06  dc.w   $ff30
00C09E08  ; data: 0x7f, 0xc0
00C09E0A  ori.b  #$0, d0
00C09E0E  ori.b  #$e, d0
00C09E12  ; data: 0x00, 0x3f
00C09E14  abcd.b d3, d0
00C09E16  ; data: 0xff, 0xfe
00C09E18  ; data: 0x0f, 0xff
00C09E1A  ; data: 0xff, 0xc0
00C09E1C  ; data: 0x3d, 0xc0
00C09E1E  ori.b  #$0, d0
00C09E22  ori.b  #$e, d0
00C09E26  ; data: 0x00, 0x3f
00C09E28  abcd.b d3, d0
00C09E2A  ; data: 0xff, 0xfe
00C09E2C  ; data: 0x0f, 0xff
00C09E2E  ; data: 0xff, 0xc0
00C09E30  ; data: 0x3d, 0xc0
00C09E32  ori.b  #$0, d0
00C09E36  ori.b  #$f, d0
00C09E3A  ; data: 0xc0, 0x3e
00C09E3C  ; data: 0xe0, 0xff
00C09E3E  ; data: 0xff, 0xf9
00C09E40  ; data: 0x3f, 0xff
00C09E42  ; data: 0xff, 0xc0
00C09E44  ; data: 0x1f, 0xc0
00C09E46  ori.b  #$0, d0
00C09E4A  ori.b  #$1f, d0
00C09E4E  dc.w   $f01f
00C09E50  ror.w  d7, d7
00C09E52  ; data: 0xff, 0xf9
00C09E54  ; data: 0x7f, 0xff
00C09E56  ; data: 0xff, 0xf0
00C09E58  ; data: 0x19, 0xe0
00C09E5A  ori.b  #$0, d0
00C09E5E  ori.l  #$21fc07, d0
00C09E64  ; data: 0xff, 0xff
00C09E66  ; data: 0xff, 0xfe
00C09E68  ; data: 0x7f, 0xff
00C09E6A  ; data: 0xff, 0xb0
00C09E6C  bset.b d2, -(a0)
00C09E6E  ori.b  #$0, d0
00C09E72  btst.l d0, d0
00C09E74  ori.l  #$fc03ffff, d0
00C09E7A  ; data: 0xff, 0xfe
00C09E7C  ; data: 0xff, 0xff
00C09E7E  ; data: 0xff, 0xc0
00C09E80  andi.b #$0, -(a0)
00C09E84  ori.b  #$c0, d0
00C09E88  ; data: 0x00, 0xf8
00C09E8A  move.w d1, ([$ff39ffff])
00C09E92  ; data: 0xff, 0xf0
00C09E94  ; data: 0x00, 0xe0
00C09E96  ori.b  #$0, d0
00C09E9A  bclr.b d0, d0
00C09E9C  bset.b d1, (a6)
00C09E9E  bset.b d3, d0
00C09EA0  movep.l d7, -$1(a7)
00C09EA4  ; data: 0xff, 0xff
00C09EA6  ; data: 0xff, 0xf8
00C09EA8  ori.b  #$0, (a0, d0.w)
00C09EAE  bclr.b d0, d0
00C09EB0  bset.b d1, (a6)
00C09EB2  bset.b d3, d0
00C09EB4  movep.l d7, -$1(a7)
00C09EB8  ; data: 0xff, 0xff
00C09EBA  ; data: 0xff, 0xf8
00C09EBC  ori.b  #$0, (a0, d0.w)
00C09EC2  bclr.b d2, d0
00C09EC4  bset.b d1, d7
00C09EC6  bset.b d3, $77f.w
00C09ECA  ; data: 0xfd, 0x0f
00C09ECC  ; data: 0xff, 0xff
00C09ECE  ; data: 0xff, 0xf8
00C09ED0  ori.b  #$0, (a0)
00C09ED4  ori.b  #$c0, d0
00C09ED8  bset.b d5, -(a7)
00C09EDA  divs.w $c09f17(pc), d1
00C09EDE  dc.w   $fc1f
00C09EE0  ; data: 0xff, 0xff
00C09EE2  ; data: 0xff, 0xfc
00C09EE4  ori.b  #$0, d6
00C09EE8  ori.b  #$e0, d0
00C09EEC  ; data: 0x03, 0xff
00C09EEE  dc.w   $f07c
00C09EF0  ori.b  #$1f, d1
00C09EF4  ; data: 0xff, 0xff
00C09EF6  ; data: 0xff, 0xfe
00C09EF8  ori.b  #$0, (a6)+
00C09EFC  ori.b  #$40, d0
00C09F00  ; data: 0x23, 0xff
00C09F02  dc.w   $fe00
00C09F04  ori.b  #$3f, d0
00C09F08  ; data: 0xff, 0xff
00C09F0A  ; data: 0xf9, 0xff
00C09F0C  ; data: 0xc0, 0x3f
00C09F0E  ori.b  #$0, d0
00C09F12  andi.b #$ff, d0
00C09F16  ; data: 0xff, 0x80
00C09F18  ; data: 0x0e, 0x02
00C09F1A  ; data: 0x00, 0x3f
00C09F1C  ; data: 0xff, 0xff
00C09F1E  dc.w   $f0ff
00C09F20  dc.w   $faff
00C09F22  negx.b d0
00C09F24  ori.b  #$0, d0
00C09F28  dc.w   $60ff
00C09F2A  ; data: 0xff, 0x80
00C09F2C  ; data: 0x1f, 0xc0
00C09F2E  negx.b ([$c0ffc1ff])
00C09F36  ori.b  #$0, d0
00C09F3A  ori.b  #$ff, d0
00C09F3E  ; data: 0xff, 0x80
00C09F40  ; data: 0x1f, 0xc0
00C09F42  negx.b ([$c0ffc1ff])
00C09F4A  ori.b  #$0, d0
00C09F4E  ori.b  #$3f, d4
00C09F52  dc.w   $fe3c
00C09F54  ; data: 0x1f, 0xff
00C09F56  and.b  ([$f0fffefe]), d0
00C09F5E  ori.b  #$0, d0
00C09F62  ori.b  #$1f, d3
00C09F66  dc.w   $f61e
00C09F6C  ; data: 0x8f, 0xff
00C09F6E  dc.w   $f0ff
00C09F70  ; data: 0xfd, 0xfe
00C09F72  ori.b  #$0, d0
00C09F76  ori.b  #$f, d1
00C09F7A  ; data: 0xfe, 0x7f
00C09F7C  ; data: 0xc0, 0xff
00C09F7E  divu.w -(a0), d1
00C09F80  ; data: 0x73, 0xff
00C09F82  dc.w   $f8ff
00C09F84  ; data: 0xfb, 0xfe
00C09F86  ori.b  #$0, d0
00C09F8A  ori.l  #$7001fa07, d0
00C09F90  ror.b  d0, d7
00C09F92  divu.w d7, d1
00C09F94  ; data: 0x4f, 0xff
00C09F96  ; data: 0xdf, 0xff
00C09F98  ; data: 0xff, 0xfc
00C09F9A  ori.b  #$0, d0
00C09F9E  ori.b  #$0, d0
00C09FA2  moveq  #$63, d4
00C09FA4  ; data: 0xc8, 0x0f
00C09FA6  ; data: 0xc1, 0xcf
00C09FA8  ; data: 0xbf, 0xbf
00C09FAA  ; data: 0xff, 0xff
00C09FAC  ; data: 0xff, 0xfc
00C09FAE  ori.b  #$0, d0
00C09FB2  ori.b  #$0, d0
00C09FB6  ; data: 0x03, 0xbb
00C09FB8  asr.b  #$8, d7
00C09FBA  ; data: 0xf9, 0xcf
00C09FBC  ; data: 0x75, 0x83
00C09FBE  ; data: 0xff, 0xff
00C09FC0  ; data: 0xff, 0xf8
00C09FC2  ori.b  #$0, d0
00C09FC6  ori.b  #$0, (a0)
00C09FCA  ; data: 0x03, 0xbb
00C09FCC  asr.b  #$8, d7
00C09FCE  ; data: 0xf9, 0xcf
00C09FD0  ; data: 0x75, 0x83
00C09FD2  ; data: 0xff, 0xff
00C09FD4  ; data: 0xff, 0xf8
00C09FD6  ori.b  #$0, d0
00C09FDA  ; data: 0x00, 0x08
00C09FDC  subi.b #$83, d0
00C09FE0  add.b  d1, d3
00C09FE2  dc.w   $f8e0
00C09FE4  ; data: 0x40, 0x3f
00C09FE6  ; data: 0xff, 0xff
00C09FE8  ; data: 0xff, 0xf0
00C09FEA  ori.b  #$0, d0
00C09FEE  ori.b  #$0, d0
00C09FF2  bset.b d0, (a7)+
00C09FF4  dc.w   $f830
00C09FF6  ; data: 0x7d, 0xf7
00C09FF8  ; data: 0x07, 0xff
00C09FFA  ; data: 0xff, 0xff
00C09FFC  ; data: 0xff, 0xf0
00C09FFE  ori.b  #$0, d0
00C0A002  ori.b  #$0, d1
00C0A006  ; data: 0x40, 0x7f
00C0A008  dc.w   $fe00
00C0A00A  bset.b d1, ([$ffffffe0])
00C0A012  ori.b  #$0, d0
00C0A016  ori.b  #$18, d0
00C0A01A  ; data: 0xf0, 0x7f
00C0A01C  dc.w   $fe70
00C0A01E  btst.l d0, (a0)
00C0A020  ; data: 0xff, 0xff
00C0A022  ; data: 0xff, 0xff
00C0A024  ; data: 0xff, 0xe0
00C0A026  ori.b  #$0, d0
00C0A02A  ori.b  #$7, d0
00C0A02E  ; data: 0xc0, 0x3f
00C0A030  ; data: 0xff, 0xf8
00C0A032  move.l d1, -(a0)
00C0A034  ; data: 0xff, 0xff
00C0A036  ; data: 0xff, 0xff
00C0A038  ; data: 0xff, 0xe0
00C0A03A  ori.b  #$0, d0
00C0A03E  ori.b  #$7, d0
00C0A042  dc.w   $f81f
00C0A044  ; data: 0xff, 0xfc
00C0A046  move.l a7, d1
00C0A048  ; data: 0xff, 0xff
00C0A04A  ; data: 0xff, 0xff
00C0A04C  ; data: 0xff, 0xc0
00C0A04E  ori.b  #$0, d0
00C0A052  ori.b  #$7, d0
00C0A056  dc.w   $f81f
00C0A058  ; data: 0xff, 0xfc
00C0A05A  move.l a7, d0
00C0A05C  ; data: 0xff, 0xff
00C0A05E  ; data: 0xff, 0xff
00C0A060  ; data: 0xff, 0x80
00C0A062  ori.b  #$0, d0
00C0A066  ori.b  #$0, d0
00C0A06A  cmp.b  d7, d2
00C0A06C  dc.w   $fefe
00C0A06E  move.l a7, -(a0)
00C0A070  ; data: 0xff, 0xff
00C0A072  ; data: 0xf9, 0x3f
00C0A074  ; data: 0xff, 0x40
00C0A076  ori.b  #$0, d0
00C0A07A  ori.b  #$0, d0
00C0A07E  moveq  #$1b, d6
00C0A080  ; data: 0xff, 0x0f
00C0A082  or.b   (a7)+, d0
00C0A084  ; data: 0xff, 0xff
00C0A086  ; data: 0xc0, 0x4b
00C0A088  dc.w   $fe00
00C0A08A  ori.b  #$0, d0
00C0A08E  ori.b  #$40, d0
00C0A092  movea.w d3, a6
00C0A094  dc.w   $fe0f
00C0A096  or.l   d7, d0
00C0A098  ; data: 0xff, 0xff
00C0A09A  ori.b  #$0, d2
00C0A09E  ori.b  #$0, d0
00C0A0A2  ori.b  #$0, d0
00C0A0A6  bclr.b d3, d1
00C0A0A8  ; data: 0xff, 0x83
00C0A0AA  ; data: 0xa0, 0x01
00C0A0AC  ; data: 0x77, 0xe3
00C0A0AE  ori.b  #$80, (a3, d0.w)
00C0A0B4  ori.b  #$0, d0
00C0A0B8  ; data: 0x00, 0x08
00C0A0BA  bclr.b d1, d1
00C0A0BC  dc.w   $f607
00C0A0C2  bclr.b d3, (a1)+
00C0A0C4  asr.b  #$4, d0
00C0A0C6  ori.b  #$0, d0
00C0A0CA  ori.b  #$0, d0
00C0A0CE  ori.b  #$87, (a4)+
00C0A0D2  ori.b  #$7f, d0
00C0A0D6  dc.w   $e1c
00C0A0D8  move.b d0, d0
00C0A0DA  ori.b  #$0, d0
00C0A0DE  ori.b  #$0, d0
00C0A0E2  ori.b  #$86, (a4)+
00C0A0E6  ori.b  #$7f, (a0)
00C0A0EA  ; data: 0x0e, 0x3f
00C0A0EC  btst.l d0, d0
00C0A0EE  ori.b  #$0, d0
00C0A0F2  ori.b  #$0, d0
00C0A0F6  ori.b  #$e, d6
00C0A0FA  ori.b  #$3e, d0
00C0A0FE  move.b d2, d4
00C0A100  move.l d0, d0
00C0A102  ori.b  #$0, d0
00C0A106  ori.b  #$0, d0
00C0A10A  ori.b  #$f0, d0
00C0A10E  ori.b  #$e3, d0
00C0A112  ; data: 0xff, 0x00
00C0A114  negx.b d0
00C0A116  ori.b  #$0, d0
00C0A11A  ori.b  #$0, d0
00C0A11E  move.l d0, d0
00C0A120  muls.w d0, d7
00C0A122  ori.b  #$3f, d1
00C0A126  dc.w   $fe81
00C0A128  ori.b  #$0, d0
00C0A12C  ori.b  #$0, d0
00C0A130  ori.b  #$0, d0
00C0A134  move.l $f(a0, d0.w), ([$ee8c0000])
00C0A13E  ori.b  #$0, d0
00C0A142  ori.b  #$0, d0
00C0A146  andi.b #$0, d0
00C0A14A  ; data: 0x00, 0x0e
00C0A14C  dc.w   $6fff
00C0A14E  ; data: 0xff, 0xb0
00C0A150  ori.b  #$0, d0
00C0A154  ori.b  #$0, d0
00C0A158  ori.b  #$0, d0
00C0A15C  move.b d0, d0
00C0A15E  ; data: 0x00, 0x0f
00C0A160  ; data: 0xdf, 0xff
00C0A162  ; data: 0xff, 0x60
00C0A164  move.l d0, d0
00C0A166  ori.b  #$0, d0
00C0A16A  ori.b  #$0, d0
00C0A16E  ori.w  #$1000, d0
00C0A172  ; data: 0x00, 0x0f
00C0A174  ; data: 0xff, 0xff
00C0A176  ; data: 0xff, 0x40
00C0A178  ori.b  #$0, d0
00C0A17C  ori.b  #$0, d0
00C0A180  ori.b  #$10, d0
00C0A184  btst.l d4, d0
00C0A186  ori.b  #$80, d3
00C0A18A  move.w d6, (a7, d0.w)
00C0A18E  ori.b  #$0, d0
00C0A192  ori.b  #$0, d0
00C0A196  ori.b  #$0, d3
00C0A19A  ori.b  #$0, d0
00C0A19E  ori.b  #$0, d0
00C0A1A2  ori.b  #$0, d0
00C0A1A6  ori.b  #$0, d0
00C0A1AA  ori.b  #$0, d0
00C0A1AE  ori.b  #$0, d0
00C0A1B2  ; data: 0x00, 0x0c
00C0A1B4  move.l d0, d0
00C0A1B6  ori.b  #$0, d0
00C0A1BA  ori.b  #$0, d0
00C0A1BE  ori.b  #$0, d0
00C0A1C2  ori.b  #$0, d0
00C0A1C6  ori.w  #$0, d0
00C0A1CA  ori.b  #$0, d0
00C0A1CE  ori.b  #$0, d0
00C0A1D2  ori.b  #$0, d0
00C0A1D6  ori.b  #$0, d0
00C0A1DA  ori.l  #$0, d0
00C0A1E0  ori.b  #$0, d0
00C0A1E4  ori.b  #$0, d0
00C0A1E8  ori.b  #$0, d0
00C0A1EC  ori.b  #$80, d0
00C0A1F0  ori.b  #$0, d0
00C0A1F4  ori.b  #$0, d0
00C0A1F8  ori.b  #$0, d0
00C0A1FC  ori.b  #$0, d0
00C0A200  ori.b  #$0, d0
00C0A204  ori.b  #$0, d0
00C0A208  ori.b  #$0, d0
00C0A20C  ori.b  #$0, d0
00C0A210  ori.b  #$0, d0
00C0A214  ori.b  #$0, d0
00C0A218  ori.b  #$0, d0
00C0A21C  ori.b  #$0, d0
00C0A220  ori.b  #$0, d0
00C0A224  ori.b  #$0, d0
00C0A228  ori.b  #$7, d0
00C0A22C  and.b  d0, d0
00C0A22E  ori.b  #$0, d0
00C0A232  ori.b  #$0, d0
00C0A236  ori.b  #$0, d1
00C0A23A  ori.b  #$1, d0
00C0A23E  ori.b  #$0, d0
00C0A242  ori.b  #$0, d0
00C0A246  ori.b  #$0, d0
00C0A24A  ori.b  #$0, d3
00C0A24E  ; data: 0x1f, 0xff
00C0A250  dc.w   $f800
00C0A252  ori.b  #$0, d0
00C0A256  ori.b  #$0, d0
00C0A25A  ori.b  #$c, d0
00C0A25E  bset.b d0, -(a6)
00C0A260  move.l d0, d0
00C0A262  ; data: 0x7f, 0xff
00C0A264  dc.w   $f800
00C0A266  ori.b  #$0, d0
00C0A26A  ori.b  #$0, d0
00C0A26E  ori.b  #$1, d0
00C0A272  bset.b d1, -(a6)
00C0A274  move.l d3, d0
00C0A276  ; data: 0xff, 0xff
00C0A278  dc.w   $f800
00C0A27A  ori.b  #$0, d0
00C0A27E  ori.b  #$0, d0
00C0A282  ori.b  #$4, d0
00C0A286  or.w   -(a0), d7
00C0A288  move.l a7, d0
00C0A28A  ; data: 0xff, 0xff
00C0A28C  dc.w   $f804
00C0A28E  ; data: 0x27, 0xc0
00C0A290  ori.b  #$0, d0
00C0A294  ori.b  #$0, d0
00C0A298  ori.b  #$c3, d0
00C0A29C  ror.w  d0, d7
00C0A29E  ; data: 0xff, 0xff
00C0A2A0  dc.w   $f004
00C0A2A2  movep.w d0, $0(a4)
00C0A2A6  ori.b  #$0, d0
00C0A2AA  ori.b  #$0, d0
00C0A2AE  ; data: 0x7f, 0xe3
00C0A2B0  ror.w  d0, d6
00C0A2B2  ; data: 0x1f, 0xe1
00C0A2B4  and.b  d0, d0
00C0A2B6  ori.l  #$0, d0
00C0A2BC  ori.b  #$0, d0
00C0A2C0  ; data: 0x00, 0x08
00C0A2C2  ; data: 0xfb, 0xff
00C0A2C4  and.w  $f.w, d0
00C0A2C8  or.b   (a0), d0
00C0A2CA  ori.b  #$0, d0
00C0A2CE  ori.b  #$0, d0
00C0A2D2  ori.b  #$0, d0
00C0A2D6  ; data: 0x73, 0xff
00C0A2D8  and.w  $f.w, d0
00C0A2DC  and.b  (a0), d0
00C0A2DE  move.b d0, d4
00C0A2E0  ori.b  #$0, d0
00C0A2E4  ori.b  #$0, d0
00C0A2E8  ori.b  #$ff, d4
00C0A2EC  ori.w  #$3f, $c010.w
00C0A2F2  addi.l #$0, d0
00C0A2F8  ori.b  #$0, d0
00C0A2FC  ori.b  #$ff, d4
00C0A300  ori.w  #$ff, $c010.w
00C0A306  addi.l #$0, d0
00C0A30C  ori.b  #$0, d0
00C0A310  ; data: 0x00, 0x0c
00C0A312  ; data: 0x3f, 0xff
00C0A314  ori.b  #$ff, d0
00C0A318  and.b  d0, d0
00C0A31A  ori.b  #$0, d0
00C0A31E  ori.b  #$0, d0
00C0A322  ori.b  #$8, d0
00C0A326  ; data: 0x3d, 0xff
00C0A328  ori.b  #$ff, d0
00C0A32C  and.b  d1, d0
00C0A32E  ori.b  #$0, d0
00C0A332  ori.b  #$0, d0
00C0A336  ori.b  #$8, d0
00C0A33A  ; data: 0x3a, 0x7e
00C0A33C  ori.b  #$ff, d0
00C0A340  and.b  -(a0), d0
00C0A342  bset.b d3, d0
00C0A344  ori.b  #$0, d0
00C0A348  ori.b  #$0, d0
00C0A34C  ; data: 0x00, 0x09
00C0A34E  ; data: 0x41, 0xfe
00C0A350  ori.b  #$ff, d1
00C0A354  or.b   -(a0), d0
00C0A356  ori.w  #$0, d0
00C0A35A  ori.b  #$0, d0
00C0A35E  ori.b  #$8, d0
00C0A362  ori.w  #$1, sr
00C0A366  dc.w   $f8ff
00C0A368  or.b   -(a0), d0
00C0A36A  ori.l  #$0, d0
00C0A370  ori.b  #$0, d0
00C0A374  ori.b  #$60, (a4)+
00C0A378  ori.b  #$cf, d0
00C0A37C  or.b   -(a0), d0
00C0A37E  andi.b #$0, d0
00C0A382  ori.b  #$0, d0
00C0A386  ori.b  #$1e, d0
00C0A38A  ori.w  #$0, -(a0)
00C0A38E  ; data: 0x00, 0xcf
00C0A390  or.b   -(a0), d0
00C0A392  andi.b #$0, d0
00C0A396  ori.b  #$0, d0
00C0A39A  ori.b  #$1f, d0
00C0A39E  bset.b d0, d0
00C0A3A0  ori.b  #$1f, d0
00C0A3A4  or.b   -(a0), d0
00C0A3A6  or.b   d0, d2
00C0A3A8  ori.b  #$0, d0
00C0A3AC  ori.b  #$0, d0
00C0A3B0  ori.b  #$c0, (a7)+
00C0A3B4  ori.b  #$ff, d0
00C0A3B8  or.b   d0, d0
00C0A3BA  asr.b  #$8, d0
00C0A3BC  ori.b  #$0, d0
00C0A3C0  ori.b  #$0, d0
00C0A3C4  ori.b  #$80, (a7)+
00C0A3C8  ori.b  #$ff, d0
00C0A3CC  or.b   d5, d0
00C0A3CE  dc.w   $f000
00C0A3D0  ori.b  #$0, d0
00C0A3D4  ori.b  #$0, d0
00C0A3D8  ori.b  #$80, $0.w
00C0A3DE  ; data: 0x00, 0x3f
00C0A3E0  or.b   d0, d0
00C0A3E2  ori.b  #$0, d0
00C0A3E6  ori.b  #$0, d0
00C0A3EA  ori.b  #$30, d0
00C0A3EE  bclr.b d0, d0
00C0A3F0  ori.b  #$3f, d0
00C0A3F4  or.b   d0, d0
00C0A3F6  ori.b  #$0, d0
00C0A3FA  ori.b  #$0, d0
00C0A3FE  ori.b  #$20, d0
00C0A402  bclr.b d1, d0
00C0A404  ori.b  #$c7, d0
00C0A408  or.w   d0, d0
00C0A40A  ori.b  #$0, d0
00C0A40E  ori.b  #$0, d0
00C0A412  ori.b  #$20, d0
00C0A416  bclr.b d1, d0
00C0A418  ori.b  #$c7, d0
00C0A41C  or.w   d0, d0
00C0A41E  ori.b  #$0, d0
00C0A422  ori.b  #$0, d0
00C0A426  ori.b  #$61, d0
00C0A42A  bclr.b d1, d0
00C0A42C  ori.b  #$f9, d0
00C0A430  or.w   d0, d0
00C0A432  ori.b  #$0, d0
00C0A436  ori.b  #$0, d0
00C0A43A  ori.b  #$41, d0
00C0A43E  bclr.b d1, d0
00C0A440  ori.b  #$11, d0
00C0A444  dc.w   $f040
00C0A446  move.l d0, d0
00C0A448  ori.b  #$0, d0
00C0A44C  ori.b  #$0, d0
00C0A450  ori.w  #$180, d0
00C0A454  ori.b  #$f, d0
00C0A458  bchg.b #$0, d0
00C0A45C  ori.b  #$0, d0
00C0A460  ori.b  #$0, d0
00C0A464  ori.l  #$1800000, d0
00C0A46A  ; data: 0x00, 0xc8
00C0A46C  movea.w d1, a4
00C0A46E  ori.b  #$0, d0
00C0A472  ori.b  #$0, d0
00C0A476  ori.b  #$80, d0
00C0A47A  bset.b d1, d0
00C0A47C  ori.b  #$e0, d0
00C0A480  ori.w  #$0, d0
00C0A484  ori.b  #$0, d0
00C0A488  ori.b  #$0, d0
00C0A48C  bclr.b d0, d0
00C0A48E  bset.b d1, d0
00C0A490  ori.b  #$1, d0
00C0A494  ori.w  #$0, d2
00C0A498  ori.b  #$0, d0
00C0A49C  ori.b  #$0, d0
00C0A4A0  btst.l d0, d0
00C0A4A2  bset.b d1, d0
00C0A4A4  ori.b  #$1, d0
00C0A4A8  ori.w  #$0, d2
00C0A4AC  ori.b  #$0, d0
00C0A4B0  ori.b  #$0, d0
00C0A4B4  btst.l d1, d0
00C0A4B6  bset.b d0, d0
00C0A4B8  ori.b  #$6, d0
00C0A4BC  ori.w  #$0, d2
00C0A4C0  ori.b  #$0, d0
00C0A4C4  ori.b  #$0, d0
00C0A4C8  andi.b #$c0, d0
00C0A4CC  ori.b  #$0, d0
00C0A4D0  btst.b #$0, d0
00C0A4D4  ori.b  #$0, d0
00C0A4D8  ori.b  #$0, d0
00C0A4DC  andi.b #$c0, d0
00C0A4E0  ori.b  #$6, d0
00C0A4E4  cmp.b  d0, d0
00C0A4E6  ori.b  #$0, d0
00C0A4EA  ori.b  #$0, d0
00C0A4EE  ori.b  #$0, d0
00C0A4F2  bset.b d0, -(a0)
00C0A4F4  ori.b  #$1, d0
00C0A4F8  dc.w   $f000
00C0A4FA  and.b  d0, d0
00C0A4FC  ori.b  #$0, d0
00C0A500  ori.b  #$0, d0
00C0A504  addi.b #$e0, d0
00C0A508  ori.b  #$1, d0
00C0A50C  ; data: 0xff, 0x80
00C0A50E  bra.w  $c0a510
00C0A512  ori.b  #$0, d0
00C0A516  ori.b  #$0, d0
00C0A51A  bset.b d3, -(a0)
00C0A51C  ; data: 0x02, 0xff
00C0A51E  asr.b  #$8, d1
00C0A520  and.b  d0, d4
00C0A522  move.w d0, d4
00C0A524  ori.b  #$0, d0
00C0A528  ori.b  #$0, d0
00C0A52C  addi.b #$e0, d0
00C0A530  ; data: 0x06, 0xff
00C0A532  dc.w   $f801
00C0A534  and.b  d0, d4
00C0A536  move.w d0, d4
00C0A538  ori.b  #$0, d0
00C0A53C  ori.b  #$0, d0
00C0A540  ; data: 0x0e, 0x00
00C0A542  bset.b d3, $188f.w
00C0A546  ; data: 0xfd, 0xc1
00C0A548  ; data: 0xf1, 0x80
00C0A54A  addi.b #$0, d0
00C0A54E  ori.b  #$0, d0
00C0A552  ori.b  #$0, d0
00C0A556  bset.b d3, $f1bbe027.l
00C0A55C  dc.w   $f000
00C0A55E  ori.b  #$0, d0
00C0A562  ori.b  #$0, d0
00C0A566  ori.b  #$0, d0
00C0A56A  ; data: 0x07, 0xff
00C0A56C  dc.w   $fe00
00C0A56E  ori.b  #$0, (a7)+
00C0A572  ori.b  #$0, (a1, d0.w)
00C0A578  btst.l d0, (a0, d0.w)
00C0A57C  ; data: 0x08, 0x00
00C0A57E  ; data: 0x07, 0xff
00C0A580  ; data: 0xff, 0x00
00C0A582  ; data: 0x00, 0x0f
00C0A584  and.b  d0, d0
00C0A586  ; data: 0x00, 0x3f
00C0A588  asr.b  #$2, d0
00C0A58A  ori.b  #$70, d0
00C0A58E  ori.b  #$e, d0
00C0A592  ; data: 0x07, 0xff
00C0A594  dc.w   $fe00
00C0A596  ori.b  #$0, (a7)+
00C0A59A  ; data: 0x00, 0x0f
00C0A59C  abcd.b d0, d0
00C0A59E  ori.b  #$f0, d0
00C0A5A2  ori.b  #$6, d0
00C0A5A6  ; data: 0x03, 0xff
00C0A5A8  ; data: 0xf7, 0x80
00C0A5AA  ; data: 0x00, 0x3f
00C0A5AC  ori.b  #$f, d0
00C0A5B0  or.b   d0, d0
00C0A5B2  ori.b  #$f0, d2
00C0A5B6  ori.b  #$6, d0
00C0A5BA  ; data: 0x03, 0xff
00C0A5BC  ; data: 0xf7, 0x80
00C0A5BE  ; data: 0x00, 0x3f
00C0A5C0  ori.b  #$f, d0
00C0A5C4  or.b   -(a0), d0
00C0A5C6  ori.b  #$f0, (a0)+
00C0A5CA  ori.b  #$8, d0
00C0A5CE  ; data: 0x01, 0xff
00C0A5D0  asl.b  #$8, d0
00C0A5D2  ori.b  #$0, d0
00C0A5D6  ; data: 0x00, 0x0e
00C0A5D8  bsr.w  $c0a61a
00C0A5DC  bset.b d0, (a0, d0.w)
00C0A5E0  moveq  #$e, d4
00C0A5E2  ori.w  #$0, (a6)+
00C0A5E6  ori.b  #$0, d0
00C0A5EA  ; data: 0x00, 0x0b
00C0A5EC  ; data: 0xfb, 0xc6
00C0A5EE  bclr.b d1, d0
00C0A5F0  bset.b d3, (a0, d0.w)
00C0A5F4  dc.w   $f006
00C0A5F6  ori.b  #$0, -(a2)
00C0A5FA  ori.b  #$0, d0
00C0A5FE  ori.b  #$c0, d0
00C0A602  dc.w   $f840
00C0A604  bset.b d3, $1(a0, d0.w)
00C0A608  dc.w   $f800
00C0A60A  ori.b  #$0, d0
00C0A60E  ori.b  #$0, d0
00C0A612  ori.b  #$0, d3
00C0A616  ori.b  #$f0, d0
00C0A61A  ori.b  #$0, d1
00C0A61E  ori.b  #$0, d0
00C0A622  ori.b  #$0, d0
00C0A626  ori.b  #$c0, d0
00C0A62A  ori.b  #$f0, d0
00C0A62E  ori.b  #$0, d3
00C0A632  ori.b  #$0, d0
00C0A636  ori.b  #$0, d0
00C0A63A  ori.b  #$0, d0
00C0A63E  ori.b  #$f0, d0
00C0A642  ori.b  #$0, d3
00C0A646  ori.b  #$0, d0
00C0A64A  ori.b  #$0, d0
00C0A64E  ori.b  #$0, d0
00C0A652  ori.b  #$e0, d0
00C0A656  ori.b  #$0, d3
00C0A65A  ori.b  #$0, d0
00C0A65E  ori.b  #$0, (a1, d0.w)
00C0A664  ori.b  #$0, d0
00C0A668  ; data: 0x1f, 0xe0
00C0A66A  ori.b  #$c0, d3
00C0A66E  ori.b  #$0, d0
00C0A672  ori.b  #$0, (a7)+
00C0A676  ori.b  #$0, d0
00C0A67A  ori.b  #$c0, d0
00C0A67E  ori.b  #$0, d3
00C0A682  ori.b  #$0, d0
00C0A686  ; data: 0x00, 0x3f
00C0A688  ; data: 0xfd, 0xc0
00C0A68A  ori.b  #$0, d0
00C0A68E  ori.b  #$80, d0
00C0A692  ori.b  #$0, d7
00C0A696  ori.b  #$0, d0
00C0A69A  ; data: 0x03, 0xff
00C0A69C  dc.w   $fe40
00C0A69E  ori.b  #$0, d0
00C0A6A2  ori.b  #$0, d0
00C0A6A6  ori.b  #$0, d7
00C0A6AA  ori.b  #$0, d0
00C0A6AE  ; data: 0x01, 0xff
00C0A6B0  ; data: 0xff, 0xc0
00C0A6B2  ori.b  #$0, d0
00C0A6B6  ori.b  #$0, (a7)+
00C0A6BA  ori.b  #$0, d7
00C0A6BE  ori.b  #$0, d0
00C0A6C2  ; data: 0x01, 0xff
00C0A6C4  ; data: 0xf1, 0xc0
00C0A6C6  ori.b  #$0, d0
00C0A6CA  ori.b  #$0, (a7)+
00C0A6CE  ori.b  #$0, d7
00C0A6D2  ori.b  #$0, d0
00C0A6D6  ; data: 0x01, 0xff
00C0A6D8  ; data: 0xf1, 0xc0
00C0A6DA  ori.b  #$0, d0
00C0A6DE  ; data: 0x00, 0x3f
00C0A6E0  dc.w   $f800
00C0A6E2  ori.b  #$0, d7
00C0A6E6  ori.b  #$70, (a0)+
00C0A6EA  ; data: 0x01, 0xff
00C0A6EC  ; data: 0xf9, 0x80
00C0A6EE  ori.b  #$0, d0
00C0A6F2  ; data: 0x00, 0x7f
00C0A6F4  dc.w   $f000
00C0A6F6  ori.b  #$0, d7
00C0A6FA  ori.b  #$c8, d0
00C0A6FE  andi.b #$d8, $0.l
00C0A706  ; data: 0x01, 0xff
00C0A708  dc.w   $f000
00C0A70A  ori.b  #$0, d7
00C0A70E  ori.b  #$78, d7
00C0A712  ; data: 0x00, 0xf6
00C0A714  cmp.w  d0, d0
00C0A716  ori.b  #$0, d0
00C0A71A  ; data: 0x03, 0xff
00C0A71C  asr.b  #$8, d0
00C0A71E  ori.b  #$0, d7
00C0A722  ori.b  #$f0, (a7)+
00C0A726  bset.b d0, -$3c80(a0)
00C0A72A  ori.b  #$0, d0
00C0A72E  ; data: 0x03, 0xff
00C0A730  asr.b  #$8, d0
00C0A732  ori.b  #$0, d7
00C0A736  ori.b  #$c8, -(a1)
00C0A73A  ori.b  #$0, $0(a7)
00C0A740  ori.b  #$ff, d0
00C0A744  and.b  d0, d0
00C0A746  ; data: 0x00, 0x0f
00C0A748  ; data: 0xff, 0x00
00C0A74A  ori.b  #$c8, (a7)+
00C0A74E  andi.b #$0, (a0)
00C0A752  ori.b  #$0, d0
00C0A756  ; data: 0x07, 0xff
00C0A758  and.b  d0, d0
00C0A75A  ; data: 0x00, 0x0f
00C0A75C  ; data: 0xff, 0x00
00C0A75E  ori.b  #$c8, (a7)+
00C0A762  andi.b #$0, (a0)
00C0A766  ori.b  #$0, d0
00C0A76A  ; data: 0x07, 0xff
00C0A76C  or.b   d0, d0
00C0A76E  ; data: 0x00, 0x0f
00C0A770  ; data: 0xff, 0x00
00C0A772  ori.b  #$40, d1
00C0A776  ; data: 0x00, 0xef
00C0A778  move.w d0, d6
00C0A77A  ori.b  #$0, d0
00C0A77E  ; data: 0x0f, 0xff
00C0A780  or.b   d0, d0
00C0A782  ; data: 0x00, 0x0f
00C0A784  ; data: 0xfb, 0xc0
00C0A786  ori.b  #$b0, d1
00C0A78A  ori.b  #$0, $0(a7)
00C0A790  ori.b  #$ff, d0
00C0A794  ori.b  #$f, d0
00C0A798  ; data: 0xff, 0xe0
00C0A79A  ori.b  #$80, d0
00C0A79E  ori.b  #$4, d6
00C0A7A2  ori.b  #$0, d0
00C0A7A6  ; data: 0x0f, 0xff
00C0A7A8  ori.b  #$f, d0
00C0A7AC  asl.b  #$3, d0
00C0A7AE  ori.b  #$0, d0
00C0A7B2  ori.b  #$1c, d0
00C0A7B6  ori.b  #$0, d0
00C0A7BA  ; data: 0x0f, 0xff
00C0A7BC  ori.b  #$f, d0
00C0A7C0  dc.w   $f800
00C0A7C2  ori.b  #$0, d0
00C0A7C6  ori.b  #$1e, d1
00C0A7CA  ori.b  #$0, d0
00C0A7CE  ; data: 0x1f, 0xfe
00C0A7D0  ori.b  #$f, d0
00C0A7D4  dc.w   $f800
00C0A7D6  ori.b  #$0, d0
00C0A7DA  ori.b  #$1b, d7
00C0A7DE  ori.b  #$0, d0
00C0A7E2  ; data: 0x1f, 0xfc
00C0A7E4  ori.b  #$f, d0
00C0A7E8  dc.w   $f800
00C0A7EA  ori.b  #$0, d0
00C0A7EE  ori.b  #$19, d7
00C0A7F2  ori.b  #$0, d0
00C0A7F6  ; data: 0x3f, 0xfc
00C0A7F8  ori.b  #$f, d0
00C0A7FC  dc.w   $fc00
00C0A7FE  ori.b  #$0, d0
00C0A802  ori.b  #$8, d0
00C0A806  or.b   d0, d3
00C0A808  ori.b  #$f8, d0
00C0A80C  ori.b  #$f, d0
00C0A810  dc.w   $f800
00C0A812  ori.b  #$0, d0
00C0A816  ori.b  #$c, d0
00C0A81A  addi.b #$0, d0
00C0A81E  ; data: 0xff, 0xf8
00C0A820  ori.b  #$f, d0
00C0A824  dc.w   $f800
00C0A826  ori.b  #$0, d0
00C0A82A  ori.b  #$6, d0
00C0A82E  ori.b  #$7, d0
00C0A832  ; data: 0xff, 0xf0
00C0A834  ori.b  #$f, d0
00C0A838  dc.w   $fc00
00C0A83A  ori.b  #$0, d0
00C0A83E  ori.b  #$3, d0
00C0A842  ori.b  #$1f, d0
00C0A846  ; data: 0xff, 0xe0
00C0A848  ori.b  #$f, d0
00C0A84C  dc.w   $fe00
00C0A84E  ori.b  #$0, d0
00C0A852  ori.b  #$21, d0
00C0A856  or.b   d0, d0
00C0A858  ; data: 0x00, 0xdf
00C0A85A  ; data: 0xff, 0xc0
00C0A85C  ori.b  #$f, d0
00C0A860  dc.w   $fe00
00C0A862  ori.b  #$0, d0
00C0A866  ori.b  #$0, d0
00C0A86A  and.b  d0, d0
00C0A86C  ; data: 0x21, 0xbf
00C0A86E  ; data: 0xff, 0x80
00C0A870  ori.b  #$f, d0
00C0A874  dc.w   $fe00
00C0A876  ori.b  #$0, d0
00C0A87A  ori.b  #$0, d0
00C0A87E  bra.w  $c0ca7f
00C0A882  ; data: 0xff, 0x00
00C0A884  ori.b  #$f, d0
00C0A888  dc.w   $fc00
00C0A88A  ori.b  #$0, d0
00C0A88E  ori.b  #$0, d0
00C0A892  move.w d0, d0
00C0A894  ; data: 0x5b, 0xff
00C0A896  dc.w   $fe00
00C0A898  ori.b  #$f, d0
00C0A89C  dc.w   $f800
00C0A89E  ori.b  #$0, d0
00C0A8A2  ori.b  #$0, d0
00C0A8A6  move.b d0, d0
00C0A8A8  ; data: 0xeb, 0xff
00C0A8AA  dc.w   $fe00
00C0A8AC  ori.b  #$f, d0
00C0A8B0  dc.w   $f800
00C0A8B2  ori.b  #$0, d0
00C0A8B6  ori.b  #$0, d0
00C0A8BA  and.b  d0, d4
00C0A8BC  ; data: 0xe7, 0xff
00C0A8BE  dc.w   $fc00
00C0A8C0  ori.b  #$f, d0
00C0A8C4  asr.b  #$8, d0
00C0A8C6  ori.b  #$0, d0
00C0A8CA  ori.b  #$0, d0
00C0A8CE  moveq  #$0, d4
00C0A8D0  ; data: 0xff, 0xff
00C0A8D2  dc.w   $f800
00C0A8D4  ori.b  #$f, d0
00C0A8D8  dc.w   $f800
00C0A8DA  ori.b  #$0, d0
00C0A8DE  ori.b  #$0, d0
00C0A8E2  ; data: 0x08, 0x00
00C0A8E4  ; data: 0xff, 0xff
00C0A8E6  dc.w   $f000
00C0A8E8  ori.b  #$7, d0
00C0A8EC  dc.w   $f800
00C0A8EE  ori.b  #$0, d0
00C0A8F2  ori.b  #$0, d0
00C0A8F6  ori.b  #$ff, d1
00C0A8FA  asr.b  #$8, d0
00C0A8FC  ori.b  #$7, d0
00C0A900  dc.w   $f800
00C0A902  ori.b  #$0, d0
00C0A906  ori.b  #$0, d0
00C0A90A  ori.b  #$ff, d3
00C0A90E  asr.b  #$8, d0
00C0A910  ori.b  #$7, d0
00C0A914  dc.w   $fc00
00C0A916  ori.b  #$0, d0
00C0A91A  ori.b  #$0, d0
00C0A91E  ori.b  #$ff, d3
00C0A922  and.b  d0, d0
00C0A924  ori.b  #$3, d0
00C0A928  dc.w   $fe00
00C0A92A  ori.b  #$0, d0
00C0A92E  ori.b  #$0, d0
00C0A932  ori.b  #$ff, d7
00C0A936  or.b   d0, d0
00C0A938  ori.b  #$3, d0
00C0A93C  dc.w   $f800
00C0A93E  ori.b  #$0, d0
00C0A942  ori.b  #$0, d0
00C0A946  ; data: 0x00, 0x0f
00C0A948  ; data: 0xff, 0xff
00C0A94A  or.b   d0, d0
00C0A94C  ori.b  #$1, d0
00C0A950  dc.w   $fe00
00C0A952  ori.b  #$0, -(a0)
00C0A956  ori.b  #$0, d0
00C0A95A  ; data: 0x00, 0x0f
00C0A95C  ; data: 0xff, 0xff
00C0A95E  ori.b  #$0, d0
00C0A962  ori.b  #$0, d1
00C0A966  ori.b  #$0, d5
00C0A96A  ori.b  #$0, d0
00C0A96E  ; data: 0x00, 0x0f
00C0A970  ; data: 0xff, 0xfe
00C0A972  ori.b  #$0, d0
00C0A976  ori.b  #$0, d0
00C0A97A  ori.b  #$0, (a5)+
00C0A97E  ori.b  #$3, d0
00C0A982  and.b  (a7)+, d0
00C0A984  ; data: 0xff, 0xfe
00C0A986  ori.b  #$0, d0
00C0A98A  ori.b  #$0, d0
00C0A98E  ori.b  #$0, (a5)+
00C0A992  ori.b  #$7, d0
00C0A996  and.b  (a7)+, d0
00C0A998  ; data: 0xff, 0xfc
00C0A99A  ori.b  #$0, d0
00C0A99E  ori.b  #$0, d0
00C0A9A2  ori.b  #$0, d5
00C0A9A6  ori.b  #$1f, d0
00C0A9AA  ; data: 0x00, 0x7f
00C0A9AC  ; data: 0xff, 0xf8
00C0A9AE  ori.b  #$0, d0
00C0A9B2  ori.b  #$0, d0
00C0A9B6  ori.b  #$0, d3
00C0A9BA  ori.b  #$3e, d0
00C0A9BE  ; data: 0x00, 0x3f
00C0A9C0  ; data: 0xff, 0xf8
00C0A9C2  ori.b  #$0, d0
00C0A9C6  ori.b  #$0, d0
00C0A9CA  ori.b  #$0, d1
00C0A9CE  ori.b  #$7c, d0
00C0A9D2  ; data: 0x30, 0xff
00C0A9D4  ; data: 0xff, 0xf0
00C0A9D6  ori.b  #$0, d0
00C0A9DA  ori.b  #$e0, d0
00C0A9DE  ori.b  #$0, d0
00C0A9E2  ori.b  #$f8, d0
00C0A9E6  ; data: 0x3f, 0xff
00C0A9E8  ; data: 0xff, 0xf0
00C0A9EA  ori.b  #$0, d0
00C0A9EE  ori.b  #$f8, d0
00C0A9F2  ori.b  #$0, d0
00C0A9F6  ori.b  #$e0, d0
00C0A9FA  ; data: 0x1f, 0xff
00C0A9FC  ; data: 0xff, 0xe0
00C0A9FE  ori.b  #$0, d0
00C0AA02  ori.b  #$ff, d0
00C0AA06  or.b   d0, d0
00C0AA08  ori.b  #$0, d0
00C0AA0C  ; data: 0x7f, 0xc0
00C0AA0E  ; data: 0x1f, 0xff
00C0AA10  ; data: 0xff, 0xe0
00C0AA12  ori.b  #$0, d0
00C0AA16  ori.b  #$ff, d0
00C0AA1A  or.b   d0, d0
00C0AA1C  ori.b  #$0, d0
00C0AA20  ; data: 0x7f, 0xc0
00C0AA22  ; data: 0x1f, 0xff
00C0AA24  ; data: 0xff, 0xe0
00C0AA26  ori.b  #$0, d0
00C0AA2A  ori.b  #$ff, d0
00C0AA2E  ori.w  #$0, d0
00C0AA32  ori.b  #$80, d0
00C0AA36  ; data: 0x0f, 0xff
00C0AA38  ; data: 0xff, 0xe0
00C0AA3A  ori.b  #$0, d0
00C0AA3E  ori.b  #$ff, d0
00C0AA42  and.b  -(a4), d0
00C0AA44  ori.b  #$1, d0
00C0AA48  moveq  #$0, d7
00C0AA4A  ; data: 0x0f, 0xff
00C0AA4C  ; data: 0xff, 0xc0
00C0AA4E  ori.b  #$0, d0
00C0AA52  ori.b  #$7f, d0
00C0AA56  dc.w   $f000
00C0AA58  ori.b  #$1, d0
00C0AA5C  dc.w   $fe00
00C0AA5E  ; data: 0x07, 0xff
00C0AA60  ; data: 0xff, 0xc0
00C0AA62  ori.b  #$0, d0
00C0AA66  ori.b  #$3f, d0
00C0AA6A  dc.w   $f000
00C0AA6C  ori.b  #$8, d0
00C0AA70  dc.w   $fc00
00C0AA72  ; data: 0x01, 0xff
00C0AA74  ; data: 0xff, 0xc0
00C0AA76  ori.b  #$0, d0
00C0AA7A  ori.b  #$1f, d0
00C0AA7E  dc.w   $fc00
00C0AA80  btst.b #$0, d0
00C0AA84  cmp.b  d0, d4
00C0AA86  ; data: 0x00, 0xff
00C0AA88  ; data: 0xff, 0xc0
00C0AA8A  ori.b  #$0, d0
00C0AA8E  ori.b  #$f, d0
00C0AA92  ; data: 0xff, 0xc0
00C0AA94  move.w d0, d7
00C0AA96  ori.b  #$0, d1
00C0AA9A  ; data: 0x00, 0x7f
00C0AA9C  ; data: 0xff, 0xc0
00C0AA9E  ori.b  #$0, d0
00C0AAA2  ori.b  #$f, d0
00C0AAA6  ; data: 0xff, 0xc0
00C0AAA8  move.w d0, d7
00C0AAAA  ori.b  #$0, d1
00C0AAAE  ; data: 0x00, 0x7f
00C0AAB0  ; data: 0xff, 0xc0
00C0AAB2  ori.b  #$0, d0
00C0AAB6  ori.b  #$f, d0
00C0AABA  ; data: 0xff, 0xc0
00C0AABC  move.b d0, -(a7)
00C0AABE  ori.b  #$0, d6
00C0AAC2  ; data: 0x00, 0x7f
00C0AAC4  ; data: 0xff, 0xc0
00C0AAC6  ori.b  #$0, d0
00C0AACA  ori.b  #$1f, d0
00C0AACE  ; data: 0xff, 0xe0
00C0AAD0  bclr.b d0, d0
00C0AAD2  ori.b  #$0, d6
00C0AAD6  ; data: 0x00, 0x7f
00C0AAD8  ; data: 0xff, 0xe0
00C0AADA  ori.b  #$0, d0
00C0AADE  btst.l d1, d0
00C0AAE0  ; data: 0x00, 0x3f
00C0AAE2  ; data: 0xff, 0xf8
00C0AAE4  ori.b  #$1, d0
00C0AAE8  or.b   d0, d0
00C0AAEA  ; data: 0x00, 0x7f
00C0AAEC  ; data: 0xff, 0xe0
00C0AAEE  ori.b  #$0, d0
00C0AAF2  addi.b #$ff, d0
00C0AAF6  ; data: 0xff, 0xfc
00C0AAF8  ori.b  #$1, d0
00C0AAFC  ori.b  #$3f, d0
00C0AB00  ; data: 0xff, 0xe0
00C0AB02  ori.b  #$0, d0
00C0AB06  addi.w #$107, d0
00C0AB0A  ; data: 0xff, 0xfe
00C0AB0C  ori.b  #$c6, d0
00C0AB10  ori.b  #$f, d0
00C0AB14  ; data: 0xff, 0xe0
00C0AB16  ori.b  #$0, d0
00C0AB1A  addi.w #$211, d0
00C0AB1E  ; data: 0xff, 0xff
00C0AB20  dc.w   $f030
00C0AB22  ori.b  #$0, d0
00C0AB26  ori.b  #$f0, d7
00C0AB2A  ori.b  #$0, d0
00C0AB2E  addi.w #$11, d0
00C0AB32  ; data: 0xff, 0xff
00C0AB34  dc.w   $f030
00C0AB36  ori.b  #$0, d0
00C0AB3A  ori.b  #$f0, d7
00C0AB3E  ori.b  #$0, d0
00C0AB42  addi.w #$400, d0
00C0AB46  ; data: 0xff, 0xff
00C0AB48  dc.w   $f880
00C0AB4A  dc.w   $2f0
00C0AB4C  ori.b  #$7, d0
00C0AB50  ; data: 0xff, 0xf0
00C0AB52  ori.b  #$0, d0
00C0AB56  addi.b #$0, d0
00C0AB5A  ; data: 0x7f, 0xff
00C0AB5C  ; data: 0xff, 0xc4
00C0AB5E  bset.b d1, -(a0)
00C0AB60  ori.b  #$3, d0
00C0AB64  ; data: 0xff, 0xfe
00C0AB66  and.b  d0, d0
00C0AB68  ori.b  #$20, d0
00C0AB6C  move.b d0, d6
00C0AB6E  ; data: 0x0f, 0xff
00C0AB70  ; data: 0xff, 0xfe
00C0AB72  bset.b d3, -(a0)
00C0AB74  ori.b  #$1, d0
00C0AB78  ; data: 0xff, 0xe1
00C0AB7A  and.b  d0, d0
00C0AB7C  ori.b  #$a0, d0
00C0AB80  move.w d0, d6
00C0AB82  ; data: 0x01, 0xff
00C0AB84  ; data: 0xff, 0xff
00C0AB86  ; data: 0xff, 0xc0
00C0AB88  ori.b  #$0, d0
00C0AB8C  ; data: 0x3f, 0xc0
00C0AB8E  and.b  d0, d0
00C0AB90  ori.b  #$e0, d0
00C0AB94  move.w d0, d7
00C0AB96  ; data: 0x00, 0x7f
00C0AB98  ; data: 0xff, 0xff
00C0AB9A  ; data: 0xff, 0xc0
00C0AB9C  ori.b  #$0, d0
00C0ABA0  btst.l d2, d0
00C0ABA2  and.b  d0, d0
00C0ABA4  ori.b  #$f0, d0
00C0ABA8  ; data: 0x7f, 0x00
00C0ABAA  ; data: 0x00, 0x7f
00C0ABAC  ; data: 0xff, 0xff
00C0ABAE  ; data: 0xff, 0xc0
00C0ABB0  ori.b  #$0, d0
00C0ABB4  move.w d0, d7
00C0ABB6  or.b   d0, d0
00C0ABB8  ori.b  #$f8, d0
00C0ABBC  ; data: 0x7f, 0x00
00C0ABBE  ; data: 0x00, 0x7f
00C0ABC0  ; data: 0xff, 0xff
00C0ABC2  ; data: 0xff, 0xc0
00C0ABC4  ori.b  #$0, d0
00C0ABC8  move.w d0, d7
00C0ABCA  or.b   d0, d0
00C0ABCC  ori.b  #$fc, d0
00C0ABD0  ; data: 0x7f, 0xc0
00C0ABD2  bset.b d0, d3
00C0ABD4  ; data: 0xff, 0xff
00C0ABD6  ; data: 0xff, 0xc0
00C0ABD8  ori.b  #$0, d0
00C0ABDC  btst.l d0, d1
00C0ABDE  ori.b  #$0, d0
00C0ABE2  ; data: 0x01, 0xff
00C0ABE4  ; data: 0xff, 0xe0
00C0ABE6  bset.b d4, -(a1)
00C0ABE8  ; data: 0xff, 0xff
00C0ABEA  dc.w   $fec0
00C0ABEC  ori.b  #$0, d0
00C0ABF0  andi.b #$0, d1
00C0ABF4  ori.b  #$ff, d0
00C0ABF8  ; data: 0xff, 0xf0
00C0ABFA  bclr.b d0, d0
00C0ABFC  ; data: 0x3f, 0xff
00C0ABFE  ; data: 0xfd, 0x00
00C0AC00  ori.b  #$0, d0
00C0AC04  subi.b #$0, d0
00C0AC08  ori.b  #$ff, d0
00C0AC0C  ; data: 0xff, 0xfe
00C0AC0E  bset.b d2, d0
00C0AC10  ; data: 0x1f, 0xff
00C0AC12  ; data: 0xfd, 0x07
00C0AC14  ori.b  #$0, d0
00C0AC18  ori.b  #$0, d2
00C0AC1C  ori.b  #$7f, d0
00C0AC20  ; data: 0xff, 0xff
00C0AC22  or.l   d3, -(a0)
00C0AC24  ; data: 0x37, 0xff
00C0AC26  dc.w   $fe0f
00C0AC28  or.w   d0, d0
00C0AC2A  ori.b  #$0, d0
00C0AC2E  ori.b  #$0, d0
00C0AC32  ; data: 0x00, 0x3f
00C0AC34  ; data: 0xff, 0xff
00C0AC36  dc.w   $fc38
00C0AC38  ; data: 0x1f, 0xff
00C0AC3A  dc.w   $fe0f
00C0AC3C  eori.w #$0, sr
00C0AC40  ori.b  #$0, d4
00C0AC44  ori.b  #$1f, d0
00C0AC48  ; data: 0xff, 0xff
00C0AC4A  dc.w   $fc38
00C0AC4C  ; data: 0x1f, 0xff
00C0AC4E  dc.w   $fe0f
00C0AC50  eori.w #$0, sr
00C0AC54  ori.b  #$0, d0
00C0AC58  ori.b  #$f, d0
00C0AC5C  ; data: 0xff, 0xff
00C0AC5E  dc.w   $fe00
00C0AC60  ; data: 0x29, 0xff
00C0AC62  dc.w   $ff20
00C0AC64  ; data: 0x3f, 0xc0
00C0AC66  ori.b  #$8, d0
00C0AC6A  ori.b  #$0, d0
00C0AC6E  ori.b  #$ff, d3
00C0AC72  dc.w   $fe00
00C0AC74  movep.l d3, -$1f0(a7)
00C0AC78  dc.w   $f800
00C0AC7A  ori.b  #$0, d0
00C0AC7E  ori.b  #$0, d0
00C0AC82  ori.b  #$ff, d1
00C0AC86  ; data: 0xff, 0x80
00C0AC88  ; data: 0x01, 0xff
00C0AC8A  ; data: 0xc0, 0x08
00C0AC8C  dc.w   $f000
00C0AC8E  ori.b  #$10, d0
00C0AC92  ori.b  #$0, d0
00C0AC96  ori.b  #$ff, d0
00C0AC9A  ; data: 0xff, 0x80
00C0AC9C  movep.w d0, -$3d11(a7)
00C0ACA0  ori.b  #$0, d0
00C0ACA4  ori.b  #$0, d0
00C0ACA8  ori.b  #$0, d0
00C0ACAC  ; data: 0x3f, 0xff
00C0ACAE  ; data: 0xff, 0xc0
00C0ACB0  ori.b  #$fe, d7
00C0ACB4  ori.b  #$0, d0
00C0ACB8  ori.b  #$0, -(a0)
00C0ACBC  ori.b  #$0, d0
00C0ACC0  ; data: 0x0f, 0xff
00C0ACC2  ; data: 0xff, 0xe0
00C0ACC4  ori.b  #$f0, d3
00C0ACC8  ori.b  #$0, d0
00C0ACCC  ori.b  #$0, d0
00C0ACD0  ori.b  #$0, d0
00C0ACD4  ; data: 0x07, 0xff
00C0ACD6  ; data: 0xff, 0xe0
00C0ACD8  ori.b  #$f0, d3
00C0ACDC  ori.b  #$0, d0
00C0ACE0  ori.w  #$0, d0
00C0ACE4  ori.b  #$0, d0
00C0ACE8  ; data: 0x03, 0xff
00C0ACEA  ; data: 0xff, 0xf8
00C0ACEC  ori.b  #$f0, d1
00C0ACF0  ori.b  #$c0, d0
00C0ACF4  ; data: 0x00, 0xc0
00C0ACF6  ori.b  #$0, d0
00C0ACFA  ori.b  #$ff, d0
00C0ACFE  ; data: 0xff, 0xe4
00C0AD00  ori.b  #$e0, d0
00C0AD04  ori.b  #$b4, d0
00C0AD08  bclr.b d0, d0
00C0AD0A  ori.b  #$0, d0
00C0AD0E  ori.b  #$7f, d0
00C0AD12  ; data: 0xff, 0xfc
00C0AD14  ori.b  #$f8, d0
00C0AD18  ori.b  #$fd, d0
00C0AD1C  dc.w   $8380
00C0AD1E  ori.b  #$0, d0
00C0AD22  ori.b  #$1f, d0
00C0AD26  ; data: 0xff, 0xfe
00C0AD28  ori.b  #$7e, d0
00C0AD2C  or.b   (a4)+, d4
00C0AD2E  ; data: 0xff, 0xc0
00C0AD30  bclr.b d3, d0
00C0AD32  ori.b  #$0, d0
00C0AD36  ori.b  #$f, d0
00C0AD3A  ; data: 0xff, 0xfe
00C0AD3C  ori.b  #$3f, d0
00C0AD40  eori.b #$18, d0
00C0AD44  btst.l d3, d0
00C0AD46  ori.b  #$0, d0
00C0AD4A  ori.b  #$3, d0
00C0AD4E  ; data: 0xff, 0xff
00C0AD50  and.b  d0, d0
00C0AD52  or.b   (a7)+, d0
00C0AD54  ; data: 0xff, 0x80
00C0AD56  dc.w   $f01c
00C0AD58  btst.l d7, d0
00C0AD5A  ori.b  #$0, d0
00C0AD5E  ori.b  #$1, d0
00C0AD62  ; data: 0xff, 0xff
00C0AD64  and.b  d1, d0
00C0AD66  ori.b  #$80, (a7)+
00C0AD6A  dc.w   $f03f
00C0AD6C  move.b d0, -(a7)
00C0AD6E  ori.b  #$0, d0
00C0AD72  ori.b  #$0, d0
00C0AD76  ; data: 0xff, 0xff
00C0AD78  asr.b  #$8, d0
00C0AD7A  ; data: 0x00, 0x0f
00C0AD7C  dc.w   $f001
00C0AD7E  asr.b  #$8, d2
00C0AD80  move.b d0, d7
00C0AD82  ori.b  #$0, d0
00C0AD86  ori.b  #$0, d0
00C0AD8A  ; data: 0x7f, 0xff
00C0AD8C  lsr.b  #$8, d4
00C0AD8E  ori.b  #$e0, d7
00C0AD92  ori.b  #$0, d0
00C0AD96  ori.b  #$0, d0
00C0AD9A  ori.b  #$0, d0
00C0AD9E  ; data: 0x3f, 0xff
00C0ADA0  dc.w   $f038
00C0ADA2  ori.b  #$0, d6
00C0ADA6  ori.b  #$0, d0
00C0ADAA  ori.b  #$0, d0
00C0ADAE  ori.b  #$0, d0
00C0ADB2  ; data: 0x0f, 0xff
00C0ADB4  dc.w   $f870
00C0ADB6  ori.b  #$0, (a0)
00C0ADBA  ori.b  #$0, d3
00C0ADBE  ori.b  #$0, d0
00C0ADC2  ori.b  #$0, d0
00C0ADC6  ; data: 0x03, 0xff
00C0ADC8  ; data: 0xff, 0x80
00C0ADCA  ori.b  #$0, (a0)
00C0ADCE  ; data: 0x00, 0x0f
00C0ADD0  dc.w   $f000
00C0ADD2  ori.b  #$0, d0
00C0ADD6  ori.b  #$0, d0
00C0ADDA  ; data: 0x00, 0xff
00C0ADDC  ; data: 0xff, 0x00
00C0ADDE  ori.b  #$0, d0
00C0ADE2  ori.b  #$0, (a7)+
00C0ADE6  ori.b  #$0, d0
00C0ADEA  ori.b  #$0, d0
00C0ADEE  ; data: 0x00, 0x7f
00C0ADF0  ; data: 0xff, 0x00
00C0ADF2  ; data: 0x00, 0x08
00C0ADF4  ori.b  #$3f, d0
00C0ADF8  or.b   d0, d0
00C0ADFA  ori.b  #$0, d0
00C0ADFE  ori.b  #$0, d0
00C0AE02  ori.b  #$0, (a7)+
00C0AE06  ori.b  #$ff, d4
00C0AE0A  ; data: 0xc0, 0x7e
00C0AE0C  ori.b  #$0, d0
00C0AE10  ori.b  #$0, d0
00C0AE14  ori.b  #$3, d0
00C0AE18  dc.w   $f800
00C0AE1A  ori.b  #$0, d0
00C0AE1E  ori.b  #$0, d0
00C0AE22  ori.b  #$0, d0
00C0AE26  ori.b  #$0, d0
00C0AE2A  ori.b  #$0, d0
00C0AE2E  ori.b  #$0, d0
00C0AE32  ori.b  #$0, d0
00C0AE36  ori.b  #$0, d0
00C0AE3A  ori.b  #$0, d0
00C0AE3E  ori.b  #$0, d0
00C0AE42  ori.b  #$0, d0
00C0AE46  addq.b #$4, d0
00C0AE48  ori.b  #$0, d0
00C0AE4C  ori.b  #$0, d0
00C0AE50  ori.b  #$0, d0
00C0AE54  ori.b  #$0, d0
00C0AE58  ori.b  #$0, d0
00C0AE5C  ori.b  #$0, d0
00C0AE60  ori.b  #$0, d0
00C0AE64  ori.b  #$0, d0
00C0AE68  ori.b  #$0, d0
00C0AE6C  ori.b  #$0, d1
00C0AE70  ori.b  #$0, d0
00C0AE74  ori.b  #$0, d0
00C0AE78  ori.b  #$0, d0
00C0AE7C  ori.b  #$0, d0
00C0AE80  ori.b  #$0, d3
00C0AE84  ori.b  #$0, d0
00C0AE88  ori.b  #$0, d0
00C0AE8C  ori.b  #$0, d0
00C0AE90  ori.b  #$0, ccr
00C0AE94  ori.b  #$0, d6
00C0AE98  ori.b  #$0, d0
00C0AE9C  ori.b  #$0, d0
00C0AEA0  ori.b  #$0, d0
00C0AEA4  ori.b  #$2, (a6)
00C0AEA8  ; data: 0x00, 0x0c
00C0AEAA  move.b d0, d4
00C0AEAC  ori.b  #$0, d0
00C0AEB0  ori.b  #$0, d0
00C0AEB4  ori.b  #$0, d0
00C0AEB8  ori.b  #$2, d1
00C0AEBC  ori.b  #$0, (a0)+
00C0AEC0  ori.b  #$0, d0
00C0AEC4  ori.b  #$0, d0
00C0AEC8  ori.b  #$0, d0
00C0AECC  ori.b  #$37, d0
00C0AED0  ; data: 0xf9, 0xb0
00C0AED2  move.b d0, d4
00C0AED4  ori.b  #$0, d0
00C0AED8  ori.b  #$0, d0
00C0AEDC  ori.b  #$0, d0
00C0AEE0  ori.b  #$3, d0
00C0AEE4  ; data: 0xf9, 0xe0
00C0AEE6  move.b d0, d4
00C0AEE8  ori.b  #$0, d0
00C0AEEC  ori.b  #$0, d0
00C0AEF0  ori.b  #$0, d0
00C0AEF4  ori.b  #$2e, d7
00C0AEF8  ori.b  #$0, d0
00C0AEFC  ori.b  #$0, d0
00C0AF00  ori.b  #$0, d0
00C0AF04  ori.b  #$0, d0
00C0AF08  ori.b  #$19, d0
00C0AF0C  ori.w  #$1800, -(a0)
00C0AF10  ori.b  #$0, d0
00C0AF14  ori.b  #$0, d0
00C0AF18  ori.b  #$0, d0
00C0AF1C  ori.b  #$19, d0
00C0AF20  or.w   d0, d0
00C0AF22  move.b d0, d4
00C0AF24  ori.b  #$0, d0
00C0AF28  ori.b  #$0, d0
00C0AF2C  ori.b  #$0, d0
00C0AF30  ori.b  #$98, d0
00C0AF34  or.w   d0, d0
00C0AF36  move.b d0, d4
00C0AF38  ori.b  #$0, d0
00C0AF3C  ori.b  #$0, d0
00C0AF40  ori.b  #$0, d0
00C0AF44  ori.b  #$f8, d0
00C0AF48  and.w  d0, d0
00C0AF4A  move.b d0, d4
00C0AF4C  ori.b  #$0, d0
00C0AF50  ori.b  #$0, d0
00C0AF54  ori.b  #$0, d0
00C0AF58  ori.b  #$f8, -(a0)
00C0AF5C  ; data: 0x41, 0xfe
00C0AF5E  add.b  d0, d4
00C0AF60  ori.b  #$0, d0
00C0AF64  ori.b  #$0, d0
00C0AF68  ori.b  #$0, d0
00C0AF6C  ori.b  #$d8, d0
00C0AF70  lsl.l  #$3, d3
00C0AF72  dc.w   $fc00
00C0AF74  ori.b  #$0, d0
00C0AF78  ori.b  #$0, d0
00C0AF7C  ori.b  #$0, d0
00C0AF80  ori.b  #$dc, (a0)
00C0AF84  moveq  #$20, d7
00C0AF86  move.l d0, d6
00C0AF88  ori.b  #$0, d0
00C0AF8C  ori.b  #$0, d0
00C0AF90  ; data: 0x00, 0x0f
00C0AF92  ori.b  #$0, d0
00C0AF96  ; data: 0x0e, 0x80
00C0AF98  moveq  #$60, d4
00C0AF9A  ori.b  #$0, d0
00C0AF9E  ori.b  #$0, d0
00C0AFA2  ori.b  #$f, d0
00C0AFA6  or.b   d0, d0
00C0AFA8  ori.b  #$0, d1
00C0AFAC  move.l (a0)+, d0
00C0AFAE  btst.b #$0, d0
00C0AFB2  ori.b  #$0, d0
00C0AFB6  ori.b  #$f, d0
00C0AFBA  and.b  d0, d0
00C0AFBC  ori.b  #$0, d2
00C0AFC0  ; data: 0x00, 0x0d
00C0AFC2  negx.b d0
00C0AFC4  ori.b  #$0, d0
00C0AFC8  ori.b  #$0, d0
00C0AFCC  ; data: 0x00, 0x0f
00C0AFCE  asr.b  #$8, d0
00C0AFD0  ori.b  #$17, d0
00C0AFD4  ; data: 0x00, 0x08
00C0AFD6  ori.b  #$0, d0
00C0AFDA  ori.b  #$0, d0
00C0AFDE  ori.b  #$f, d0
00C0AFE2  dc.w   $f000
00C0AFE4  ori.b  #$1f, d0
00C0AFE8  ori.b  #$0, d2
00C0AFEC  ori.b  #$0, d0
00C0AFF0  ori.b  #$0, d0
00C0AFF4  ; data: 0x00, 0x0f
00C0AFF6  dc.w   $f800
00C0AFF8  ori.b  #$ff, d0
00C0AFFC  ori.b  #$0, d0
00C0B000  ori.b  #$0, d0
00C0B004  ori.b  #$0, d0
00C0B008  ; data: 0x00, 0x0f
00C0B00A  dc.w   $fc00
00C0B00C  ori.b  #$ff, d0
00C0B010  ori.b  #$0, d0
00C0B014  ori.b  #$0, d0
00C0B018  ori.b  #$0, d0
00C0B01C  ; data: 0x00, 0x0f
00C0B01E  dc.w   $fe00
00C0B020  ori.b  #$ff, d0
00C0B024  ori.b  #$0, d0
00C0B028  ori.b  #$0, d0
00C0B02C  ori.b  #$0, d0
00C0B030  ; data: 0x00, 0x0f
00C0B032  ; data: 0xff, 0x80
00C0B034  ori.b  #$ff, d0
00C0B038  ori.b  #$0, d0
00C0B03C  ori.b  #$0, d0
00C0B040  ori.b  #$0, d0
00C0B044  ; data: 0x00, 0x0f
00C0B046  ; data: 0xff, 0x80
00C0B048  ori.b  #$ff, d0
00C0B04C  ori.b  #$0, d0
00C0B050  ori.b  #$0, d0
00C0B054  ori.b  #$0, d0
00C0B058  ; data: 0x00, 0x0f
00C0B05A  ; data: 0xff, 0xe0
00C0B05C  ori.b  #$ff, d1
00C0B060  ori.b  #$0, d0
00C0B064  ori.b  #$1e, d0
00C0B068  ori.b  #$0, d0
00C0B06C  ; data: 0x00, 0x0f
00C0B06E  ; data: 0xff, 0xf8
00C0B070  ; data: 0x00, 0x0b
00C0B072  ; data: 0xff, 0xff
00C0B074  ori.b  #$0, d0
00C0B078  ori.b  #$3e, d0
00C0B07C  ori.b  #$0, d0
00C0B080  ; data: 0x00, 0x0f
00C0B082  ; data: 0xff, 0xf8
00C0B084  ori.l  #$ffff0000, (a7)+
00C0B08A  ori.b  #$0, d0
00C0B08E  ; data: 0x00, 0xfe
00C0B090  ori.b  #$0, d0
00C0B094  ; data: 0x00, 0x0f
00C0B096  ; data: 0xff, 0xff
00C0B098  ; data: 0x03, 0xff
00C0B09A  ; data: 0xff, 0xff
00C0B09C  ori.b  #$0, d0
00C0B0A0  ori.b  #$fe, d0
00C0B0A4  ori.b  #$0, d0
00C0B0A8  ori.b  #$ff, d7
00C0B0AC  ; data: 0x03, 0xff
00C0B0AE  ; data: 0xff, 0xff
00C0B0B0  ori.b  #$0, d0
00C0B0B4  ori.b  #$fe, d0
00C0B0B8  ori.b  #$0, d0
00C0B0BC  ori.b  #$ff, d3
00C0B0C0  ; data: 0xc3, 0xff
00C0B0C2  ; data: 0xff, 0xff
00C0B0C4  ori.b  #$0, d0
00C0B0C8  ori.b  #$fe, d0
00C0B0CC  ori.b  #$0, d0
00C0B0D0  ori.b  #$ff, d3
00C0B0D4  ; data: 0xf3, 0xff
00C0B0D6  ; data: 0xff, 0xff
00C0B0D8  sub.b  d0, d4
00C0B0DA  ori.b  #$0, d0
00C0B0DE  ; data: 0x7f, 0xfe
00C0B0E0  ori.b  #$0, d0
00C0B0E4  ori.b  #$ff, d0
00C0B0E8  ; data: 0xf3, 0xff
00C0B0EA  ; data: 0xff, 0xff
00C0B0EC  ; data: 0xff, 0xff
00C0B0EE  sub.b  d0, d4
00C0B0F0  ori.b  #$fe, d0
00C0B0F4  ori.b  #$0, d0
00C0B0F8  ori.b  #$ff, d1
00C0B0FC  ; data: 0xff, 0xff
00C0B0FE  ; data: 0xff, 0xff
00C0B100  ; data: 0xff, 0xff
00C0B102  ; data: 0xff, 0x98
00C0B104  ori.b  #$fe, d3
00C0B108  ori.b  #$0, d0
00C0B10C  ori.b  #$ff, d0
00C0B110  ; data: 0xff, 0xff
00C0B112  ; data: 0xff, 0xff
00C0B114  ; data: 0xff, 0xff
00C0B116  ; data: 0xff, 0xfc
00C0B118  ori.b  #$fe, d3
00C0B11C  ori.b  #$e, d0
00C0B120  ori.b  #$ff, d0
00C0B124  ; data: 0xff, 0xff
00C0B126  ; data: 0xff, 0xff
00C0B128  ; data: 0xff, 0xff
00C0B12A  ; data: 0xff, 0xfc
00C0B12C  ori.b  #$fe, d7
00C0B130  ori.b  #$e, d0
00C0B134  ori.b  #$ff, d0
00C0B138  ; data: 0xff, 0xff
00C0B13A  ; data: 0xff, 0xff
00C0B13C  ; data: 0xff, 0xff
00C0B13E  ; data: 0xff, 0xfc
00C0B140  ori.b  #$fe, (a7)+
00C0B144  ori.b  #$f, d0
00C0B148  ori.b  #$ff, d0
00C0B14C  ; data: 0xff, 0xff
00C0B14E  ; data: 0xff, 0xff
00C0B150  ; data: 0xff, 0xff
00C0B152  ; data: 0xff, 0xfc
00C0B154  ; data: 0x00, 0x3f
00C0B156  ; data: 0xff, 0xfe
00C0B158  ori.b  #$f, d0
00C0B15C  ori.b  #$ff, d0
00C0B160  ; data: 0xff, 0xff
00C0B162  ; data: 0xff, 0xff
00C0B164  ; data: 0xff, 0xff
00C0B166  ; data: 0xff, 0xfc
00C0B168  ; data: 0x00, 0x7f
00C0B16A  ; data: 0xff, 0xfe
00C0B16C  ; data: 0x0e, 0x00
00C0B16E  ; data: 0x00, 0x0e
00C0B170  ori.b  #$3f, d0
00C0B174  ; data: 0xff, 0xff
00C0B176  ; data: 0xff, 0xff
00C0B178  ; data: 0xff, 0xff
00C0B17A  ; data: 0xff, 0xfc
00C0B17C  ; data: 0x00, 0xff
00C0B17E  ; data: 0xff, 0xfe
00C0B180  move.b d0, d7
00C0B182  ; data: 0x00, 0x0e
00C0B184  ori.b  #$9f, d0
00C0B188  ; data: 0xff, 0xff
00C0B18A  ; data: 0xff, 0xff
00C0B18C  ; data: 0xff, 0xff
00C0B18E  ; data: 0xff, 0xfc
00C0B190  ; data: 0x01, 0xff
00C0B192  ; data: 0xff, 0xfe
00C0B194  move.w d0, d7
00C0B196  ; data: 0x00, 0x0f
00C0B198  ori.b  #$c7, d0
00C0B19C  ; data: 0xff, 0xff
00C0B19E  ; data: 0xff, 0xff
00C0B1A0  ; data: 0xff, 0xff
00C0B1A2  ; data: 0xff, 0xfc
00C0B1A4  ; data: 0x03, 0xff
00C0B1A6  ; data: 0xff, 0xfe
00C0B1A8  moveq  #$0, d7
00C0B1AA  ; data: 0x00, 0x0f
00C0B1AC  or.b   d0, d0
00C0B1AE  ; data: 0x1f, 0xc7
00C0B1B0  ; data: 0xff, 0xff
00C0B1B2  ; data: 0xff, 0xff
00C0B1B4  ; data: 0xff, 0xff
00C0B1B6  ; data: 0xff, 0xfc
00C0B1B8  ; data: 0x07, 0xff
00C0B1BA  ; data: 0xff, 0xfd
00C0B1BC  dc.w   $fe00
00C0B1BE  ; data: 0x00, 0x0f
00C0B1C0  ori.b  #$e1, d0
00C0B1C4  ; data: 0xff, 0xff
00C0B1C6  ; data: 0xff, 0xff
00C0B1C8  ; data: 0xff, 0xff
00C0B1CA  ; data: 0xff, 0xfc
00C0B1CC  ; data: 0x0f, 0xff
00C0B1CE  ; data: 0xff, 0xf9
00C0B1D0  dc.w   $fe00
00C0B1D2  ; data: 0x00, 0x0f
00C0B1D4  or.b   d0, d0
00C0B1D6  ; data: 0x1f, 0xc0
00C0B1D8  ; data: 0x7f, 0xff
00C0B1DA  ; data: 0x83, 0x3f
00C0B1DC  ; data: 0xff, 0xff
00C0B1DE  ; data: 0xff, 0xfc
00C0B1E0  ; data: 0x0f, 0xff
00C0B1E2  ; data: 0xff, 0xff
00C0B1E4  dc.w   $fe00
00C0B1E6  ; data: 0x00, 0x0f
00C0B1E8  and.b  d0, d0
00C0B1EA  bset.b d7, -(a0)
00C0B1EC  ; data: 0x7f, 0xff
00C0B1EE  ; data: 0x80, 0x0f
00C0B1F0  dc.w   $67ff
00C0B1F2  ; data: 0xff, 0xec
00C0B1F4  ; data: 0x3f, 0xff
00C0B1F6  ; data: 0xff, 0xff
00C0B1F8  dc.w   $fe00
00C0B1FA  ; data: 0x00, 0x0f
00C0B1FC  or.b   d0, d0
00C0B1FE  bset.b d3, ([$c00f00ff])
00C0B206  ; data: 0xff, 0xdc
00C0B208  ; data: 0x3f, 0xff
00C0B20A  ; data: 0xdf, 0xff
00C0B20C  dc.w   $fe00
00C0B20E  ; data: 0x00, 0x0f
00C0B210  and.b  d0, d0
00C0B212  bset.b d7, -(a0)
00C0B214  ; data: 0x0f, 0xff
00C0B216  lsr.b  #$8, d7
00C0B218  ; data: 0x00, 0xff
00C0B21A  ; data: 0xff, 0x8c
00C0B21C  ; data: 0x3f, 0xff
00C0B21E  ; data: 0x9f, 0xff
00C0B220  dc.w   $fe00
00C0B222  ; data: 0x00, 0x0f
00C0B224  asr.b  #$8, d0
00C0B226  bset.b d3, ([$e00f00ff])
00C0B22E  dc.w   $ff38
00C0B230  ; data: 0xff, 0xff
00C0B232  ; data: 0x1f, 0xff
00C0B234  dc.w   $fe00
00C0B236  ori.b  #$0, d7
00C0B23A  bset.b d1, $3ff.w
00C0B23E  dc.w   $f00f
00C0B240  ; data: 0x00, 0xff
00C0B242  dc.w   $ff10
00C0B244  ; data: 0x7f, 0xfe
00C0B246  ; data: 0x3f, 0xff
00C0B248  dc.w   $fe00
00C0B24A  ori.b  #$0, d7
00C0B24E  bset.b d3, ([$f00f007f])
00C0B256  ; data: 0xfd, 0xc1
00C0B258  ; data: 0xff, 0xfc
00C0B25A  ; data: 0x1f, 0xff
00C0B25C  dc.w   $fe00
00C0B25E  ; data: 0x00, 0x0f
00C0B260  asr.b  #$8, d0
00C0B262  bset.b d1, $7f.w
00C0B266  dc.w   $f80f
00C0B268  ; data: 0x00, 0x7f
00C0B26A  ; data: 0xff, 0xc0
00C0B26C  ; data: 0xff, 0xf8
00C0B26E  ; data: 0x7f, 0xff
00C0B270  dc.w   $fe00
00C0B272  ; data: 0x00, 0x0f
00C0B274  dc.w   $f000
00C0B276  ; data: 0x01, 0xfc
00C0B278  ; data: 0x00, 0x3f
00C0B27A  dc.w   $f80f
00C0B27C  ; data: 0x00, 0xff
00C0B27E  ; data: 0xff, 0x03
00C0B280  ; data: 0xff, 0xf0
00C0B282  ; data: 0x7f, 0xff
00C0B284  dc.w   $fe00
00C0B286  ori.b  #$0, d7
00C0B28A  bset.b d1, $1f.w
00C0B28E  dc.w   $fc0f
00C0B290  ; data: 0x80, 0x7f
00C0B292  dc.w   $fe01
00C0B294  ; data: 0xff, 0xe0
00C0B296  ; data: 0xff, 0xff
00C0B298  dc.w   $fe00
00C0B29A  ori.b  #$0, d7
00C0B29E  ; data: 0x01, 0xfc
00C0B2A0  ; data: 0x00, 0x0f
00C0B2A2  dc.w   $fe0f
00C0B2A4  ; data: 0x80, 0x3f
00C0B2A6  dc.w   $fc03
00C0B2A8  ; data: 0x7f, 0xc1
00C0B2AA  ; data: 0xff, 0xff
00C0B2AC  dc.w   $fe00
00C0B2AE  ori.b  #$0, d7
00C0B2B2  ; data: 0x00, 0xfe
00C0B2B4  ori.b  #$f, d7
00C0B2B8  ; data: 0x80, 0x7f
00C0B2BA  dc.w   $f007
00C0B2BC  ; data: 0xff, 0x81
00C0B2BE  ; data: 0xff, 0xff
00C0B2C0  dc.w   $fe00
00C0B2C2  ori.b  #$0, d3
00C0B2C6  ; data: 0x01, 0xfc
00C0B2C8  ori.b  #$f, d7
00C0B2CC  ; data: 0x00, 0x3f
00C0B2CE  add.b  d6, d0
00C0B2D0  ; data: 0xff, 0x01
00C0B2D2  ; data: 0xff, 0xff
00C0B2D4  dc.w   $f800
00C0B2D6  ori.b  #$0, d3
00C0B2DA  ; data: 0x00, 0xfe
00C0B2DC  ori.b  #$f, d1
00C0B2E0  ; data: 0x00, 0x3c
00C0B2E2  or.b   d0, d0
00C0B2E4  dc.w   $fe01
00C0B2E6  ; data: 0xff, 0xff
00C0B2E8  asr.b  #$8, d0
00C0B2EA  ori.b  #$0, d7
00C0B2EE  ; data: 0x00, 0x7f
00C0B2F0  ori.b  #$f, d1
00C0B2F4  ori.b  #$0, d0
00C0B2F8  dc.w   $fc01
00C0B2FA  ; data: 0xff, 0xff
00C0B2FC  or.b   d0, d0
00C0B2FE  ori.b  #$0, d7
00C0B302  ; data: 0x00, 0xfe
00C0B304  ori.b  #$f, d1
00C0B308  or.b   d0, d0
00C0B30A  ori.b  #$1, d5
00C0B30E  ; data: 0xff, 0xfe
00C0B310  ori.b  #$3, d0
00C0B314  ; data: 0xff, 0x00
00C0B316  ; data: 0x00, 0x7f
00C0B318  ori.b  #$f, d0
00C0B31C  or.b   d0, d0
00C0B31E  ori.b  #$1, d7
00C0B322  ; data: 0xff, 0xf8
00C0B324  ori.b  #$3, d0
00C0B328  ; data: 0xff, 0x80
00C0B32A  ; data: 0x00, 0x3f
00C0B32C  or.b   d0, d0
00C0B32E  ; data: 0xff, 0x0f
00C0B330  or.b   d0, d0
00C0B332  ori.b  #$1, d5
00C0B336  ; data: 0xff, 0xe0
00C0B338  ori.b  #$1, d0
00C0B33C  ; data: 0xff, 0x00
00C0B33E  ; data: 0x00, 0x7f
00C0B340  or.b   d0, d0
00C0B342  move.w a7, -(a7)
00C0B344  and.b  d0, d0
00C0B346  ori.b  #$1, d7
00C0B34A  ; data: 0xff, 0x80
00C0B34C  ori.b  #$1, d0
00C0B350  ; data: 0xff, 0x80
00C0B352  ; data: 0x00, 0x3f
00C0B354  and.b  d0, d0
00C0B356  ; data: 0x7f, 0x0f
00C0B358  and.b  d0, d0
00C0B35A  ori.b  #$1, d7
00C0B35E  dc.w   $fe00
00C0B360  ori.b  #$3, d0
00C0B364  ; data: 0xff, 0x80
00C0B366  ori.b  #$0, (a7)+
00C0B36A  ; data: 0x1f, 0x0f
00C0B36C  and.b  d0, d0
00C0B36E  ori.b  #$81, d7
00C0B372  dc.w   $f800
00C0B374  ori.b  #$3, d0
00C0B378  ; data: 0xff, 0xc0
00C0B37A  ; data: 0x00, 0x3f
00C0B37C  asr.b  #$8, d0
00C0B37E  move.w a7, -(a7)
00C0B380  or.b   d0, d0
00C0B382  ori.b  #$e1, d7
00C0B386  asr.b  #$8, d0
00C0B388  ori.b  #$1, d0
00C0B38C  ; data: 0xff, 0xc0
00C0B38E  ori.b  #$0, (a7)+
00C0B392  move.w a7, -(a7)
00C0B394  or.b   d0, d0
00C0B396  ori.b  #$f8, d7
00C0B39A  ori.b  #$0, d0
00C0B39E  ori.b  #$e0, d1
00C0B3A2  ; data: 0x00, 0x0f
00C0B3A4  dc.w   $f000
00C0B3A6  move.w a7, -(a7)
00C0B3A8  or.b   d0, d0
00C0B3AA  ori.b  #$fd, d7
00C0B3AE  ori.b  #$0, d0
00C0B3B2  move.l d1, (a0)
00C0B3B4  ; data: 0xff, 0xe0
00C0B3B6  ori.b  #$0, (a7)+
00C0B3BA  ; data: 0x1f, 0x0f
00C0B3BC  and.b  d0, d0
00C0B3BE  ori.b  #$ff, d7
00C0B3C2  cmp.b  d0, d0
00C0B3C4  ori.b  #$0, d0
00C0B3C8  ; data: 0xff, 0xf0
00C0B3CA  ; data: 0x00, 0x0f
00C0B3CC  dc.w   $f800
00C0B3CE  moveq  #$f, d7
00C0B3D0  and.b  d0, d0
00C0B3D2  ori.b  #$ff, d7
00C0B3D6  dc.w   $fe00
00C0B3D8  ori.b  #$81, d0
00C0B3DC  ; data: 0xff, 0xf0
00C0B3DE  ori.b  #$0, d7
00C0B3E2  moveq  #$f, d7
00C0B3E4  asr.b  #$8, d0
00C0B3E6  ; data: 0x00, 0x0f
00C0B3E8  ; data: 0xff, 0xff
00C0B3EA  dc.w   $fe00
00C0B3EC  ori.b  #$1, d0
00C0B3F0  ; data: 0xff, 0xf8
00C0B3F2  ; data: 0x00, 0x0f
00C0B3F4  dc.w   $fc00
00C0B3F6  ; data: 0x7f, 0x0f
00C0B3F8  asr.b  #$8, d0
00C0B3FA  ori.b  #$ff, (a7)+
00C0B3FE  dc.w   $fe00
00C0B400  ori.b  #$0, d0
00C0B404  ; data: 0xff, 0xfc
00C0B406  ori.b  #$3, d7
00C0B40A  ; data: 0xff, 0x0f
00C0B40C  asr.b  #$8, d0
00C0B40E  ; data: 0x00, 0x3f
00C0B410  ; data: 0xff, 0xff
00C0B412  dc.w   $fe00
00C0B414  ori.b  #$0, d0
00C0B418  ; data: 0xff, 0xfe
00C0B41A  ori.b  #$b, d3
00C0B41E  dc.w   $fe0f
00C0B420  and.b  d0, d0
00C0B422  ; data: 0x00, 0x7f
00C0B424  ; data: 0xff, 0xff
00C0B426  dc.w   $fe00
00C0B428  ori.b  #$0, d0
00C0B42C  ; data: 0x7d, 0xfe
00C0B42E  ori.b  #$3f, d7
00C0B432  dc.w   $fe0f
00C0B434  and.b  d0, d0
00C0B436  ; data: 0x00, 0xff
00C0B438  ; data: 0xff, 0xff
00C0B43A  dc.w   $fe00
00C0B43C  ori.b  #$0, d0
00C0B440  ; data: 0x7b, 0xff
00C0B442  ori.b  #$ff, d3
00C0B446  dc.w   $fc0f
00C0B448  and.b  d0, d0
00C0B44A  ; data: 0x01, 0xff
00C0B44C  ; data: 0xff, 0xff
00C0B44E  dc.w   $fe00
00C0B450  ori.b  #$0, d0
00C0B454  ; data: 0xff, 0xff
00C0B456  ; data: 0x83, 0x3f
00C0B458  ; data: 0xff, 0xff
00C0B45A  dc.w   $fc0f
00C0B45C  asr.b  #$8, d0
00C0B45E  ; data: 0x03, 0xff
00C0B460  ; data: 0xff, 0xff
00C0B462  dc.w   $fe00
00C0B464  ori.b  #$0, d0
00C0B468  ; data: 0xff, 0xff
00C0B46A  ; data: 0xff, 0xff
00C0B46C  ; data: 0xff, 0xff
00C0B46E  dc.w   $fe0f
00C0B470  asr.b  #$8, d0
00C0B472  ; data: 0x07, 0xff
00C0B474  ; data: 0xff, 0xff
00C0B476  dc.w   $fe00
00C0B478  bclr.b d1, d0
00C0B47A  ori.b  #$ff, d5
00C0B47E  ; data: 0xff, 0xff
00C0B480  ; data: 0xff, 0xff
00C0B482  dc.w   $fc0f
00C0B484  asr.b  #$8, d0
00C0B486  ; data: 0x07, 0xff
00C0B488  ; data: 0xff, 0xff
00C0B48A  dc.w   $fe00
00C0B48C  bclr.b d1, d0
00C0B48E  ; data: 0x00, 0x7f
00C0B490  ; data: 0xff, 0xff
00C0B492  ; data: 0xff, 0xff
00C0B494  ; data: 0xff, 0xff
00C0B496  dc.w   $f80f
00C0B498  dc.w   $f000
00C0B49A  ; data: 0x1f, 0xff
00C0B49C  ; data: 0xff, 0xff
00C0B49E  dc.w   $fe00
00C0B4A0  bset.b d1, -(a0)
00C0B4A2  ; data: 0x00, 0x7f
00C0B4A4  ; data: 0xff, 0xff
00C0B4A6  ; data: 0xff, 0xff
00C0B4A8  ; data: 0xff, 0xff
00C0B4AA  dc.w   $fc0f
00C0B4AC  dc.w   $f000
00C0B4AE  ; data: 0x1f, 0xff
00C0B4B0  ; data: 0xff, 0xff
00C0B4B2  dc.w   $fe00
00C0B4B4  bset.b d1, $7f(a0, d0.w)
00C0B4B8  ; data: 0xff, 0xff
00C0B4BA  ; data: 0xff, 0xff
00C0B4BC  ; data: 0xff, 0xff
00C0B4BE  dc.w   $f80f
00C0B4C0  asr.b  #$8, d0
00C0B4C2  ; data: 0x1f, 0xff
00C0B4C4  dc.w   $f66f
00C0B4C6  dc.w   $fe00
00C0B4C8  bset.b d1, $7f(a0, d0.w)
00C0B4CC  ; data: 0xff, 0xff
00C0B4CE  ; data: 0xff, 0xff
00C0B4D0  ; data: 0xff, 0xff
00C0B4D2  dc.w   $f80f
00C0B4D4  asr.b  #$8, d0
00C0B4D6  ; data: 0x3f, 0xff
00C0B4D8  ; data: 0xa0, 0x06
00C0B4DA  dc.w   $fe00
00C0B4DC  bset.b d1, $7f(a0, d0.w)
00C0B4E0  ; data: 0xff, 0xff
00C0B4E2  ; data: 0xff, 0xff
00C0B4E4  ; data: 0xff, 0xff
00C0B4E6  dc.w   $f00f
00C0B4E8  dc.w   $f000
00C0B4EA  ; data: 0x3f, 0xfe
00C0B4EC  or.b   d0, d0
00C0B4EE  ori.b  #$f0, d0
00C0B4F2  ; data: 0x00, 0x7f
00C0B4F4  ; data: 0xff, 0xff
00C0B4F6  ; data: 0xff, 0xff
00C0B4F8  ; data: 0xff, 0xff
00C0B4FA  dc.w   $f00f
00C0B4FC  dc.w   $f000
00C0B4FE  ; data: 0x7f, 0xfe
00C0B500  ori.b  #$0, d0
00C0B504  bset.b d0, $7f(a0, d0.w)
00C0B508  ; data: 0xff, 0xff
00C0B50A  ; data: 0xff, 0xff
00C0B50C  ; data: 0xff, 0xff
00C0B50E  lsr.b  #$8, d7
00C0B510  dc.w   $f800
00C0B512  ; data: 0x7f, 0xf8
00C0B514  ori.b  #$0, d0
00C0B518  ; data: 0x00, 0xf0
00C0B51A  ; data: 0x00, 0x7f
00C0B51C  ; data: 0xff, 0xff
00C0B51E  ; data: 0xff, 0xff
00C0B520  ; data: 0xff, 0xff
00C0B522  lsr.b  #$8, d7
00C0B524  dc.w   $f800
00C0B526  ; data: 0xff, 0xf0
00C0B528  ori.b  #$0, d0
00C0B52C  ; data: 0x00, 0xf0
00C0B52E  ; data: 0x00, 0x7f
00C0B530  ; data: 0xff, 0xff
00C0B532  ; data: 0xff, 0xff
00C0B534  ; data: 0xff, 0xff
00C0B536  dc.w   $f80f
00C0B538  dc.w   $f000
00C0B53A  ; data: 0xff, 0xe0
00C0B53C  ori.b  #$0, d0
00C0B540  bset.b d0, $7f(a0, d0.w)
00C0B544  ; data: 0xff, 0xff
00C0B546  ; data: 0xff, 0xff
00C0B548  ; data: 0xff, 0xff
00C0B54A  dc.w   $fe0f
00C0B54C  dc.w   $f001
00C0B54E  ; data: 0xff, 0xc0
00C0B550  ori.b  #$0, d0
00C0B554  ; data: 0x00, 0xf0
00C0B556  ; data: 0x00, 0x7f
00C0B558  ; data: 0xff, 0xff
00C0B55A  ; data: 0xff, 0xff
00C0B55C  ; data: 0xff, 0xff
00C0B55E  ; data: 0xff, 0x8f
00C0B560  dc.w   $f801
00C0B562  ; data: 0xff, 0x80
00C0B564  ori.b  #$0, d0
00C0B568  bset.b d1, $7f(a0, d0.w)
00C0B56C  ; data: 0xff, 0xff
00C0B56E  ; data: 0xff, 0xff
00C0B570  ; data: 0xff, 0xff
00C0B572  ; data: 0xff, 0xef
00C0B574  dc.w   $fc07
00C0B576  ; data: 0xff, 0x00
00C0B578  ori.b  #$0, d0
00C0B57C  bset.b d1, $7f(a0, d0.w)
00C0B580  dc.w   $fc00
00C0B582  ; data: 0xff, 0xff
00C0B584  ; data: 0xff, 0xff
00C0B586  ; data: 0xff, 0xff
00C0B588  dc.w   $f807
00C0B58A  dc.w   $fe00
00C0B58C  ori.b  #$0, d0
00C0B590  bset.b d1, $7f(a0, d0.w)
00C0B594  dc.w   $fc00
00C0B596  ; data: 0xff, 0xff
00C0B598  ; data: 0xff, 0xff
00C0B59A  ; data: 0xff, 0xff
00C0B59C  dc.w   $fc0f
00C0B59E  dc.w   $fe00
00C0B5A0  ori.b  #$0, d0
00C0B5A4  bset.b d7, $7f(a0, d0.w)
00C0B5A8  dc.w   $fc00
00C0B5AA  ; data: 0x3f, 0xff
00C0B5AC  ; data: 0xff, 0xff
00C0B5AE  ; data: 0xff, 0xff
00C0B5B0  dc.w   $fe1f
00C0B5B2  ; data: 0xff, 0x80
00C0B5B4  ori.b  #$0, d0
00C0B5B8  ; data: 0x1f, 0xf0
00C0B5BA  ; data: 0x00, 0x7f
00C0B5BC  dc.w   $fc00
00C0B5BE  ; data: 0x3f, 0xff
00C0B5C0  ; data: 0xfd, 0xff
00C0B5C2  ; data: 0xff, 0xff
00C0B5C4  dc.w   $fc3f
00C0B5C6  ; data: 0xff, 0x80
00C0B5C8  ori.b  #$0, d0
00C0B5CC  ; data: 0x1f, 0xe0
00C0B5CE  ; data: 0x00, 0x3f
00C0B5D0  dc.w   $fc00
00C0B5D2  ; data: 0x1f, 0xff
00C0B5D4  ; data: 0xf9, 0xff
00C0B5D6  ; data: 0xff, 0xff
00C0B5D8  ; data: 0xfe, 0x7f
00C0B5DA  ; data: 0xff, 0xc0
00C0B5DC  ori.b  #$0, d0
00C0B5E0  ; data: 0x7f, 0xe0
00C0B5E2  ; data: 0x00, 0x3f
00C0B5E4  dc.w   $fc00
00C0B5E6  ; data: 0x0f, 0xff
00C0B5E8  dc.w   $f0ff
00C0B5EA  ; data: 0xff, 0xff
00C0B5EC  ; data: 0xff, 0xff
00C0B5EE  ; data: 0xff, 0xe0
00C0B5F0  ori.b  #$0, d0
00C0B5F4  ; data: 0x7f, 0xf0
00C0B5F6  ; data: 0x00, 0x0f
00C0B5F8  dc.w   $fc00
00C0B5FA  ; data: 0x07, 0xff
00C0B5FC  ; data: 0xe1, 0xff
00C0B5FE  ; data: 0xff, 0xff
00C0B600  ; data: 0xff, 0xff
00C0B602  ; data: 0xff, 0xf0
00C0B604  ori.b  #$1, d0
00C0B608  ; data: 0xff, 0xf0
00C0B60A  ; data: 0x00, 0x0f
00C0B60C  dc.w   $fc00
00C0B60E  ; data: 0x07, 0xfe
00C0B610  ; data: 0x81, 0xff
00C0B612  ; data: 0xff, 0xff
00C0B614  ; data: 0xff, 0xff
00C0B616  ; data: 0xff, 0xfc
00C0B618  ori.b  #$7, d0
00C0B61C  ; data: 0xff, 0xe0
00C0B61E  ori.b  #$0, d7
00C0B622  bset.b d0, -$9(a0, d0.w)
00C0B626  ; data: 0xff, 0xff
00C0B628  ; data: 0xff, 0xff
00C0B62A  ; data: 0xff, 0xfd
00C0B62C  ori.b  #$5f, d0
00C0B630  ; data: 0xff, 0xc0
00C0B632  ori.b  #$0, d1
00C0B636  bset.b d0, -$20(a0, d0.w)
00C0B63A  ; data: 0xff, 0xff
00C0B63C  ; data: 0xff, 0xff
00C0B63E  ; data: 0xff, 0xff
00C0B640  negx.b d0
00C0B642  ; data: 0x02, 0xff
00C0B644  ; data: 0xff, 0xe0
00C0B646  ori.b  #$0, d1
00C0B64A  dc.w   $f0
00C0B64C  ori.b  #$ff, d0
00C0B650  ; data: 0xff, 0xff
00C0B652  ; data: 0xbf, 0xff
00C0B654  asl.b  #$3, d0
00C0B656  ; data: 0xcf, 0xff
00C0B658  ; data: 0xff, 0xe0
00C0B65A  ori.b  #$0, d0
00C0B65E  ori.b  #$0, -(a0)
00C0B662  ; data: 0x0f, 0xff
00C0B664  ; data: 0xff, 0xff
00C0B666  ; data: 0x9f, 0xff
00C0B668  ; data: 0xff, 0xff
00C0B66A  ; data: 0xff, 0xff
00C0B66C  ; data: 0xff, 0x80
00C0B66E  ori.b  #$0, d0
00C0B672  ori.b  #$0, d0
00C0B676  ; data: 0x03, 0xff
00C0B678  ; data: 0xff, 0xff
00C0B67A  ; data: 0x9f, 0xff
00C0B67C  ; data: 0xff, 0xff
00C0B67E  ; data: 0xff, 0xff
00C0B680  ; data: 0xff, 0xc0
00C0B682  ori.b  #$0, d0
00C0B686  ori.b  #$0, d0
00C0B68A  ; data: 0x00, 0xff
00C0B68C  ; data: 0xff, 0xfe
00C0B68E  ; data: 0x1f, 0xff
00C0B690  ; data: 0xff, 0xff
00C0B692  ; data: 0xff, 0xff
00C0B694  ; data: 0xff, 0x00
00C0B696  ori.b  #$0, d0
00C0B69A  ori.b  #$0, d0
00C0B69E  ; data: 0x00, 0x3f
00C0B6A0  ; data: 0xff, 0xfe
00C0B6A2  ; data: 0x1f, 0xff
00C0B6A4  ; data: 0xff, 0xff
00C0B6A6  ; data: 0xff, 0xff
00C0B6A8  ; data: 0xff, 0x00
00C0B6AA  ori.b  #$0, d0
00C0B6AE  ori.b  #$0, d0
00C0B6B2  ; data: 0x00, 0x0b
00C0B6B4  ; data: 0xff, 0xfc
00C0B6B6  ; data: 0x07, 0xff
00C0B6B8  ; data: 0xff, 0xff
00C0B6BA  ; data: 0xff, 0xff
00C0B6BC  dc.w   $fe00
00C0B6BE  ori.b  #$0, d0
00C0B6C2  ori.b  #$0, d0
00C0B6C6  ori.b  #$f8, d3
00C0B6CA  ; data: 0x07, 0xff
00C0B6CC  ; data: 0xff, 0xff
00C0B6CE  ; data: 0xff, 0xff
00C0B6D0  dc.w   $fc00
00C0B6D2  ; data: 0x00, 0x08
00C0B6D4  ; data: 0x00, 0x0c
00C0B6D6  ori.b  #$0, d0
00C0B6DA  ori.b  #$f0, d0
00C0B6DE  ; data: 0x03, 0xff
00C0B6E0  ; data: 0xff, 0xff
00C0B6E2  ; data: 0xff, 0xff
00C0B6E4  dc.w   $f800
00C0B6E6  ori.b  #$0, d0
00C0B6EA  move.b d0, d6
00C0B6EC  ori.b  #$0, d0
00C0B6F0  bset.b d7, -(a0)
00C0B6F2  ; data: 0x01, 0xff
00C0B6F4  ; data: 0xff, 0xff
00C0B6F6  ; data: 0xff, 0xff
00C0B6F8  dc.w   $f000
00C0B6FA  ori.b  #$0, d0
00C0B6FE  ori.w  #$0, (a0, d0.w)
00C0B704  bset.b d3, d0
00C0B706  ; data: 0x00, 0x7f
00C0B708  ; data: 0xff, 0xff
00C0B70A  ; data: 0xff, 0xff
00C0B70C  and.b  d0, d0
00C0B70E  ori.b  #$0, d0
00C0B712  ori.b  #$0, d3
00C0B716  ori.b  #$80, d0
00C0B71A  ; data: 0x00, 0x7f
00C0B71C  ; data: 0xff, 0xff
00C0B71E  ; data: 0xff, 0xff
00C0B720  and.b  d0, d0
00C0B722  ori.b  #$0, d0
00C0B726  ori.b  #$0, d0
00C0B72A  ori.b  #$0, d0
00C0B72E  ; data: 0x00, 0x0f
00C0B730  ; data: 0xff, 0xff
00C0B732  ; data: 0xff, 0xfd
00C0B734  ori.b  #$0, d0
00C0B738  ori.b  #$0, d0
00C0B73C  addi.b #$0, d0
00C0B740  ori.b  #$f, d0
00C0B744  ; data: 0xff, 0xff
00C0B746  ; data: 0xff, 0xe8
00C0B748  ori.b  #$0, d0
00C0B74C  ori.b  #$0, d0
00C0B750  ori.w  #$0, d0
00C0B754  ori.b  #$2, d0
00C0B758  ; data: 0x7f, 0xff
00C0B75A  ; data: 0xff, 0x40
00C0B75C  ori.l  #$1000000, d0
00C0B762  ori.b  #$10, d0
00C0B766  ori.b  #$0, d0
00C0B76A  ori.b  #$ff, d0
00C0B76E  and.b  d0, d6
00C0B770  andi.b #$0, d0
00C0B774  ori.b  #$0, d0
00C0B778  ori.b  #$0, d4
00C0B77C  ori.b  #$0, d0
00C0B780  ori.b  #$0, d0
00C0B784  btst.b #$0, d0
00C0B788  ori.b  #$0, d0
00C0B78C  ori.b  #$0, d1
00C0B790  ori.b  #$0, d0
00C0B794  ori.b  #$0, d0
00C0B798  negx.b d0
00C0B79A  ori.w  #$7800, d0
00C0B79E  ori.b  #$0, d0
00C0B7A2  negx.b d0
00C0B7A4  ori.b  #$0, d0
00C0B7A8  ori.b  #$6, d0
00C0B7AC  ori.b  #$0, d0
00C0B7B0  ori.w  #$0, (a0, d0.w)
00C0B7B6  move.b d0, d0
00C0B7B8  ori.b  #$0, d0
00C0B7BC  ori.b  #$60, d0
00C0B7C0  ori.b  #$0, d0
00C0B7C4  negx.b d0
00C0B7C6  moveq  #$0, d0
00C0B7C8  ori.b  #$0, d0
00C0B7CC  ori.b  #$0, d0
00C0B7D0  ori.b  #$0, d0
00C0B7D4  ori.b  #$10, d0
00C0B7D8  ori.b  #$c0, d0
00C0B7DC  ori.b  #$0, d0
00C0B7E0  ori.b  #$0, d0
00C0B7E4  ori.b  #$0, d0
00C0B7E8  ori.b  #$8, d0
00C0B7EC  move.l d0, d0
00C0B7EE  ori.b  #$0, d6
00C0B7F2  ori.w  #$0, d0
00C0B7F6  ori.b  #$6, d0
00C0B7FA  ori.b  #$0, d0
00C0B7FE  ; data: 0x00, 0x08
00C0B800  ori.b  #$0, d0
00C0B804  negx.b d0
00C0B806  ori.b  #$0, d0
00C0B80A  ori.b  #$60, d0
00C0B80E  ori.b  #$0, d0
00C0B812  ori.b  #$0, d0
00C0B816  ori.b  #$0, d0
00C0B81A  ; data: 0x00, 0x08
00C0B81C  ori.b  #$0, d0
00C0B820  addi.b #$0, d0
00C0B824  ori.b  #$0, (a0)
00C0B828  move.b d0, d0
00C0B82A  ori.b  #$0, d0
00C0B82E  ori.b  #$0, d0
00C0B832  ori.b  #$0, d0
00C0B836  ori.b  #$0, d0
00C0B83A  andi.b #$0, d0
00C0B83E  ori.b  #$20, d0
00C0B842  ori.b  #$0, d0
00C0B846  ori.b  #$0, d0
00C0B84A  ori.b  #$0, d0
00C0B84E  ori.b  #$0, d0
00C0B852  ori.b  #$8, d0
00C0B856  ori.b  #$0, d0
00C0B85A  ori.b  #$0, d0
00C0B85E  ori.b  #$0, d0
00C0B862  btst.l d0, d0
00C0B864  btst.b #$0, d0
00C0B868  ori.b  #$0, d2
00C0B86C  ori.b  #$0, d0
00C0B870  ori.b  #$0, d0
00C0B874  move.w -(a0), d4
00C0B876  ori.b  #$0, d0
00C0B87A  ori.b  #$0, d0
00C0B87E  or.b   d0, d0
00C0B880  move.b d0, d0
00C0B882  ori.b  #$0, d0
00C0B886  ori.b  #$20, d3
00C0B88A  ori.l  #$0, d0
00C0B890  ori.b  #$0, d0
00C0B894  ori.b  #$0, d0
00C0B898  ori.b  #$18, d0
00C0B89C  ori.b  #$0, d0
00C0B8A0  subi.b #$0, d0
00C0B8A4  ori.b  #$0, d0
00C0B8A8  andi.b #$0, d0
00C0B8AC  ori.b  #$80, d0
00C0B8B0  move.l d0, d0
00C0B8B2  ori.w  #$400, d0
00C0B8B6  ori.b  #$0, d0
00C0B8BA  subi.b #$0, d0
00C0B8BE  ori.b  #$0, d0
00C0B8C2  move.b d0, d4
00C0B8C4  ori.b  #$0, d0
00C0B8C8  ori.b  #$0, d0
00C0B8CC  ori.b  #$0, d0
00C0B8D0  ori.w  #$0, d0
00C0B8D4  ori.b  #$0, d1
00C0B8D8  ori.w  #$20, d0
00C0B8DC  ori.b  #$0, d0
00C0B8E0  ori.b  #$80, d0
00C0B8E4  ori.b  #$0, (a0)
00C0B8E8  ori.b  #$0, (a0)+
00C0B8EC  ori.w  #$0, d0
00C0B8F0  ori.b  #$0, d0
00C0B8F4  ori.b  #$0, d0
00C0B8F8  ori.b  #$0, d4
00C0B8FC  bclr.b d0, d0
00C0B8FE  ori.b  #$0, d0
00C0B902  ori.b  #$0, (a0)
00C0B906  ori.b  #$0, d0
00C0B90A  ori.b  #$1, (a0)
00C0B90E  ori.b  #$0, d0
00C0B912  ori.b  #$0, d0
00C0B916  ori.b  #$0, d0
00C0B91A  ori.b  #$0, d0
00C0B91E  ori.b  #$0, d0
00C0B922  negx.b d0
00C0B924  ori.b  #$0, d0
00C0B928  ori.l  #$80200, d0
00C0B92E  ori.b  #$0, d0
00C0B932  ori.b  #$0, d0
00C0B936  move.b d0, d0
00C0B938  ori.b  #$0, d0
00C0B93C  ori.b  #$0, d0
00C0B940  ori.b  #$0, d0
00C0B944  ori.b  #$1, d0
00C0B948  ori.b  #$0, d0
00C0B94C  ori.b  #$20, d0
00C0B950  btst.l d0, d0
00C0B952  ori.b  #$0, d4
00C0B956  ori.b  #$0, d0
00C0B95A  ori.b  #$0, d0
00C0B95E  ori.l  #$80, d0
00C0B964  ori.b  #$0, d0
00C0B968  ori.b  #$0, d0
00C0B96C  ori.b  #$0, d0
00C0B970  move.l d0, d0
00C0B972  ori.b  #$0, (a0, d0.w * 2)
00C0B978  ori.b  #$2, d0
00C0B97C  ori.b  #$0, d0
00C0B980  ori.b  #$0, d0
00C0B984  ori.b  #$4, d0
00C0B988  ori.b  #$0, d0
00C0B98C  ori.b  #$0, d0
00C0B990  ori.b  #$0, d0
00C0B994  ori.b  #$0, d0
00C0B998  subi.b #$0, d0
00C0B99C  or.b   d0, d0
00C0B99E  move.l d0, d0
00C0B9A0  ori.b  #$1, d0
00C0B9A4  ori.b  #$0, d0
00C0B9A8  ori.b  #$0, d0
00C0B9AC  btst.l d0, d0
00C0B9AE  ori.b  #$3, d0
00C0B9B2  ori.b  #$0, d0
00C0B9B6  ori.b  #$0, d0
00C0B9BA  ori.b  #$0, d0
00C0B9BE  ori.b  #$40, d0
00C0B9C2  ori.b  #$0, d0
00C0B9C6  ori.b  #$0, d0
00C0B9CA  ori.b  #$0, d0
00C0B9CE  ori.b  #$0, d0
00C0B9D2  ori.b  #$10, d0
00C0B9D6  ori.b  #$0, d0
00C0B9DA  ori.b  #$0, d0
00C0B9DE  ori.b  #$0, d0
00C0B9E2  ori.b  #$0, d0
00C0B9E6  ori.b  #$4, d0
00C0B9EA  ori.b  #$0, d0
00C0B9EE  ori.b  #$0, d0
00C0B9F2  ori.b  #$0, d0
00C0B9F6  ori.b  #$0, d0
00C0B9FA  ori.b  #$1, d0
00C0B9FE  ori.b  #$0, d0
00C0BA02  ori.b  #$0, d0
00C0BA06  ori.b  #$0, d0
00C0BA0A  ori.b  #$0, d0
00C0BA0E  ori.b  #$0, d0
00C0BA12  negx.b d0
00C0BA14  ori.b  #$4, d0
00C0BA18  ori.b  #$0, d0
00C0BA1C  move.l d0, d0
00C0BA1E  ori.b  #$0, d0
00C0BA22  ori.b  #$0, d0
00C0BA26  move.b d0, d0
00C0BA28  ori.b  #$10, d0
00C0BA2C  ori.b  #$0, d0
00C0BA30  ori.b  #$0, d0
00C0BA34  ori.b  #$0, d0
00C0BA38  ori.b  #$0, d0
00C0BA3C  ori.b  #$40, d0
00C0BA40  ori.b  #$0, d0
00C0BA44  move.b d0, d0
00C0BA46  ori.b  #$0, d0
00C0BA4A  ori.b  #$0, d0
00C0BA4E  ori.w  #$0, d0
00C0BA52  btst.l d0, d0
00C0BA54  ori.b  #$0, d0
00C0BA58  ori.b  #$0, d0
00C0BA5C  ori.b  #$0, d0
00C0BA60  ori.b  #$10, d0
00C0BA64  ori.b  #$0, d0
00C0BA68  ori.b  #$0, d0
00C0BA6C  ori.b  #$0, d0
00C0BA70  ori.b  #$0, d0
00C0BA74  ori.b  #$3, d0
00C0BA78  ori.b  #$0, d0
00C0BA7C  ori.b  #$0, d0
00C0BA80  ori.b  #$0, d0
00C0BA84  ori.b  #$0, d0
00C0BA88  ori.b  #$0, d0
00C0BA8C  move.b d7, d4
00C0BA8E  ori.b  #$0, d0
00C0BA92  ori.b  #$0, d0
00C0BA96  ori.b  #$0, d0
00C0BA9A  ori.b  #$0, d0
00C0BA9E  ori.b  #$0, d0
00C0BAA2  ori.b  #$0, d0
00C0BAA6  ori.b  #$0, d0
00C0BAAA  ori.b  #$0, d0
00C0BAAE  ori.b  #$0, d0
00C0BAB2  ori.b  #$0, d0
00C0BAB6  ori.b  #$0, d0
00C0BABA  ori.b  #$0, d0
00C0BABE  ori.b  #$0, d0
00C0BAC2  ori.b  #$0, d0
00C0BAC6  bra.w  $c0bac8
00C0BACA  ori.b  #$0, d0
00C0BACE  ori.b  #$0, d0
00C0BAD2  ori.b  #$0, d0
00C0BAD6  ori.b  #$0, d0
00C0BADA  or.b   d0, d0
00C0BADC  ori.b  #$0, d0
00C0BAE0  ori.b  #$0, d0
00C0BAE4  ori.b  #$0, d0
00C0BAE8  ori.b  #$0, d0
00C0BAEC  ori.b  #$0, d0
00C0BAF0  ori.b  #$0, d0
00C0BAF4  ori.b  #$0, d0
00C0BAF8  ori.b  #$0, d0
00C0BAFC  ori.b  #$0, d0
00C0BB00  ori.b  #$0, d0
00C0BB04  ori.b  #$0, d0
00C0BB08  ori.b  #$0, d0
00C0BB0C  ori.b  #$0, d0
00C0BB10  ori.b  #$0, d4
00C0BB14  ori.b  #$0, d0
00C0BB18  ori.b  #$0, d0
00C0BB1C  ori.b  #$0, d0
00C0BB20  ori.b  #$0, d0
00C0BB24  ori.b  #$32, (a1)+
00C0BB28  ori.b  #$0, d0
00C0BB2C  ori.b  #$0, d0
00C0BB30  ori.b  #$0, d0
00C0BB34  ori.b  #$0, d0
00C0BB38  ; data: 0x00, 0x09
00C0BB3A  move.l (a4, d0.w), d0
00C0BB3E  ori.b  #$0, d0
00C0BB42  ori.b  #$0, d0
00C0BB46  ori.b  #$0, d0
00C0BB4A  ori.b  #$8, d0
00C0BB4E  ori.b  #$80, d0
00C0BB52  ori.b  #$0, d0
00C0BB56  ori.b  #$0, d0
00C0BB5A  ori.b  #$0, d0
00C0BB5E  ori.b  #$8, d0
00C0BB62  ori.b  #$c0, d4
00C0BB66  ori.b  #$0, d0
00C0BB6A  ori.b  #$0, d0
00C0BB6E  ori.b  #$0, d0
00C0BB72  ori.b  #$c, d0
00C0BB76  move.l (a5)+, d0
00C0BB78  ori.w  #$0, -(a0)
00C0BB7C  ori.b  #$0, d0
00C0BB80  ori.b  #$0, d0
00C0BB84  ori.b  #$0, d0
00C0BB88  ; data: 0x00, 0x08
00C0BB8A  bge.b  $c0bb8e
00C0BB8C  ori.b  #$0, -(a0)
00C0BB90  ori.b  #$0, d0
00C0BB94  ori.b  #$0, d0
00C0BB98  ori.b  #$0, d0
00C0BB9C  ; data: 0x00, 0x48
00C0BB9E  btst.l d5, d0
00C0BBA0  or.b   d0, d0
00C0BBA2  ori.b  #$0, d0
00C0BBA6  ori.b  #$0, d0
00C0BBAA  ori.b  #$0, d0
00C0BBAE  ori.b  #$f8, d0
00C0BBB2  ori.b  #$0, d1
00C0BBB6  ori.b  #$0, d0
00C0BBBA  ori.b  #$0, d0
00C0BBBE  ori.b  #$0, d0
00C0BBC2  ori.b  #$38, d0
00C0BBC6  ori.b  #$0, d0
00C0BBCA  ori.b  #$0, d0
00C0BBCE  ori.b  #$0, d0
00C0BBD2  ori.b  #$0, d0
00C0BBD6  ori.b  #$38, d0
00C0BBDA  ori.b  #$1, d0
00C0BBDE  and.b  d0, d0
00C0BBE0  ori.b  #$0, d0
00C0BBE4  ori.b  #$0, d0
00C0BBE8  ori.b  #$0, d0
00C0BBEC  ori.b  #$0, (a0)+
00C0BBF0  ; data: 0xa4, 0x8c
00C0BBF2  ori.b  #$0, d0
00C0BBF6  ori.b  #$0, d0
00C0BBFA  ori.b  #$0, d0
00C0BBFE  ori.b  #$18, d0
00C0BC02  andi.b #$40, (a0)
00C0BC06  move.w d0, d0
00C0BC08  ori.b  #$0, d0
00C0BC0C  ori.b  #$0, d0
00C0BC10  ori.b  #$0, d0
00C0BC14  ; data: 0x00, 0x0c
00C0BC16  bclr.b d4, d0
00C0BC18  swap   d0
00C0BC1A  ori.b  #$0, d0
00C0BC1E  ori.b  #$0, d0
00C0BC22  ori.b  #$0, d0
00C0BC26  ori.b  #$6, d0
00C0BC2A  addi.b #$28, d0
00C0BC2E  btst.b #$0, d0
00C0BC32  ori.b  #$0, d0
00C0BC36  ori.b  #$0, d0
00C0BC3A  ori.b  #$3, d0
00C0BC3E  move.w d0, d0
00C0BC40  ori.b  #$0, (a3)
00C0BC44  ori.b  #$0, d0
00C0BC48  ori.b  #$0, d0
00C0BC4C  ori.b  #$0, d0
00C0BC50  ori.b  #$19, d0
00C0BC54  ; data: 0x00, 0x0f
00C0BC56  asr.b  #$8, d0
00C0BC58  ori.b  #$0, d0
00C0BC5C  ori.b  #$0, d0
00C0BC60  ori.b  #$0, d0
00C0BC64  ori.b  #$20, d0
00C0BC68  ori.b  #$0, d3
00C0BC6C  ori.b  #$0, d0
00C0BC70  ori.b  #$0, d0
00C0BC74  ori.b  #$0, d0
00C0BC78  ori.b  #$80, d0
00C0BC7C  ori.b  #$0, d0
00C0BC80  ori.b  #$0, d0
00C0BC84  ori.b  #$0, d0
00C0BC88  ori.b  #$0, d0
00C0BC8C  ori.b  #$0, d0
00C0BC90  ori.b  #$0, d0
00C0BC94  ori.b  #$0, d0
00C0BC98  ori.b  #$0, d0
00C0BC9C  ori.b  #$0, d0
00C0BCA0  ori.b  #$0, d0
00C0BCA4  ori.b  #$0, d0
00C0BCA8  ori.b  #$0, d0
00C0BCAC  ori.b  #$0, d0
00C0BCB0  ori.b  #$80, d1
00C0BCB4  ori.b  #$0, d0
00C0BCB8  ori.b  #$0, d0
00C0BCBC  ori.b  #$0, d0
00C0BCC0  ori.b  #$0, d0
00C0BCC4  ori.b  #$40, d3
00C0BCC8  ori.b  #$30, d0
00C0BCCC  ori.b  #$0, d0
00C0BCD0  ori.b  #$0, d0
00C0BCD4  ori.b  #$0, d0
00C0BCD8  ori.b  #$0, d3
00C0BCDC  ori.b  #$70, d1
00C0BCE0  ori.b  #$0, d0
00C0BCE4  ori.b  #$0, d0
00C0BCE8  ori.b  #$0, d0
00C0BCEC  ori.b  #$8, d1
00C0BCF0  ; data: 0x00, 0x0c
00C0BCF2  dc.w   $f0
00C0BCF4  ori.b  #$0, d0
00C0BCF8  ori.b  #$0, d0
00C0BCFC  ori.b  #$0, d0
00C0BD00  ori.b  #$4, d1
00C0BD04  ; data: 0x00, 0xe0
00C0BD06  bset.b d1, (a0, d0.w)
00C0BD0A  ori.b  #$0, d0
00C0BD0E  ori.l  #$0, d0
00C0BD14  ori.b  #$1, d0
00C0BD18  ori.b  #$f0, d0
00C0BD1C  ori.b  #$0, d0
00C0BD20  ori.b  #$0, d0
00C0BD24  ori.b  #$0, d0
00C0BD28  ori.b  #$0, d0
00C0BD2C  or.b   d0, d0
00C0BD2E  ; data: 0x1f, 0xf0
00C0BD30  ori.b  #$0, d0
00C0BD34  ori.b  #$0, d0
00C0BD38  ori.b  #$0, d0
00C0BD3C  ori.b  #$0, d0
00C0BD40  ori.b  #$f0, d0
00C0BD44  ori.b  #$0, d0
00C0BD48  ori.b  #$0, d0
00C0BD4C  ori.b  #$0, d0
00C0BD50  ori.b  #$80, d2
00C0BD54  move.b d0, d0
00C0BD56  ; data: 0xff, 0xf0
00C0BD58  moveq  #$0, d4
00C0BD5A  ori.b  #$0, d0
00C0BD5E  negx.b d0
00C0BD60  ori.b  #$0, d0
00C0BD64  ori.b  #$c0, d1
00C0BD68  ; data: 0x08, 0x01
00C0BD6A  ; data: 0xff, 0xf0
00C0BD6C  ori.b  #$0, d0
00C0BD70  ori.b  #$20, d0
00C0BD74  ori.b  #$0, d0
00C0BD78  ori.b  #$e0, d1
00C0BD7C  ori.b  #$f8, d3
00C0BD80  ori.b  #$78, d0
00C0BD84  ori.b  #$60, d2
00C0BD88  ori.b  #$0, d0
00C0BD8C  ori.b  #$30, d0
00C0BD90  ori.b  #$f8, d7
00C0BD94  ori.b  #$0, d0
00C0BD98  ori.b  #$60, d4
00C0BD9C  ori.b  #$0, d0
00C0BDA0  ori.b  #$0, d0
00C0BDA4  ori.b  #$fc, d1
00C0BDA8  ori.b  #$0, d0
00C0BDAC  ; data: 0x00, 0x08
00C0BDAE  ; data: 0x00, 0xc0
00C0BDB0  ori.b  #$0, d0
00C0BDB4  ori.b  #$0, d0
00C0BDB8  ori.b  #$bc, d0
00C0BDBC  move.w d0, d0
00C0BDBE  ori.b  #$0, d0
00C0BDC2  bset.b d0, d0
00C0BDC4  ori.b  #$1, d0
00C0BDC8  ori.b  #$0, d0
00C0BDCC  ori.b  #$1f, d0
00C0BDD0  dc.w   $f000
00C0BDD2  ori.b  #$0, d0
00C0BDD6  bset.b d1, d0
00C0BDD8  ori.b  #$1, d0
00C0BDDC  ori.b  #$0, d0
00C0BDE0  ori.b  #$1f, d0
00C0BDE4  asr.b  #$8, d0
00C0BDE6  ori.b  #$0, d0
00C0BDEA  bclr.b d7, d0
00C0BDEC  ori.b  #$1, d0
00C0BDF0  ori.b  #$c0, d0
00C0BDF4  ori.b  #$f, d0
00C0BDF8  and.b  d0, d0
00C0BDFA  ori.b  #$0, d0
00C0BDFE  move.b d0, (a7, d0.w)
00C0BE02  ori.b  #$0, d1
00C0BE06  move.l d0, d0
00C0BE08  ori.b  #$7, d0
00C0BE0C  and.b  d0, d0
00C0BE0E  ori.b  #$1, d0
00C0BE12  ; data: 0xff, 0x80
00C0BE14  ori.b  #$0, d0
00C0BE18  ori.b  #$48, d0
00C0BE1C  ori.b  #$3, d0
00C0BE20  or.b   d0, d0
00C0BE22  ori.b  #$f, d0
00C0BE26  ; data: 0xff, 0x82
00C0BE28  ori.b  #$0, d0
00C0BE2C  or.b   d0, d0
00C0BE2E  ori.b  #$0, d4
00C0BE32  ori.b  #$0, d3
00C0BE36  ori.b  #$1f, d0
00C0BE3A  ; data: 0xff, 0x01
00C0BE3C  ori.b  #$0, d0
00C0BE40  or.b   d0, d0
00C0BE42  move.b -(a0), d0
00C0BE44  ori.b  #$0, d0
00C0BE48  ori.b  #$0, d0
00C0BE4C  ori.b  #$2, (a0, d0.w)
00C0BE52  ori.b  #$0, d0
00C0BE56  move.b -(a0), d0
00C0BE58  or.b   d0, d0
00C0BE5A  divs.w d0, d1
00C0BE5C  ori.b  #$0, d0
00C0BE60  move.b d0, d0
00C0BE62  btst.l d7, d0
00C0BE64  ori.b  #$0, d0
00C0BE68  negx.b d0
00C0BE6A  ori.b  #$0, d0
00C0BE6E  ori.b  #$0, d0
00C0BE72  ori.b  #$0, (a0)
00C0BE76  btst.l d1, d0
00C0BE78  ori.b  #$0, d0
00C0BE7C  negx.b d0
00C0BE7E  btst.b #$0, (a0)
00C0BE82  ori.b  #$0, d0
00C0BE86  ori.b  #$0, -(a0)
00C0BE8A  btst.l d1, d0
00C0BE8C  ori.b  #$0, d0
00C0BE90  ori.b  #$10, d0
00C0BE94  ori.b  #$0, d0
00C0BE98  ori.b  #$70, d0
00C0BE9C  negx.b d0
00C0BE9E  btst.l d1, d0
00C0BEA0  ori.b  #$0, d0
00C0BEA4  move.l d0, d0
00C0BEA6  ori.b  #$0, d0
00C0BEAA  move.b d0, d0
00C0BEAC  ori.b  #$c4, d0
00C0BEB0  or.b   d0, d0
00C0BEB2  btst.l d1, d0
00C0BEB4  ori.b  #$8, d0
00C0BEB8  move.l d0, d0
00C0BEBA  ; data: 0x04, 0x08
00C0BEBC  andi.b #$0, d0
00C0BEC0  ori.b  #$e8, d0
00C0BEC4  or.b   d0, d0
00C0BEC6  move.l d0, d1
00C0BEC8  ori.b  #$8, d0
00C0BECC  ori.b  #$8, d0
00C0BED0  btst.l d0, d0
00C0BED2  btst.b #$80, d0
00C0BED6  andi.b #$0, -(a1)
00C0BEDA  move.l d0, d1
00C0BEDC  ori.b  #$8, d0
00C0BEE0  move.b d0, d0
00C0BEE2  ori.b  #$0, d0
00C0BEE6  ori.b  #$80, d0
00C0BEEA  ori.w  #$0, d1
00C0BEEE  clr.b  d0
00C0BEF0  ori.b  #$8, d0
00C0BEF4  ori.b  #$4, d0
00C0BEF8  ori.b  #$0, d0
00C0BEFC  ori.l  #$20000, d0
00C0BF02  ori.b  #$0, d0
00C0BF06  ori.b  #$0, d0
00C0BF0A  andi.b #$0, d4
00C0BF0E  ori.b  #$0, d0
00C0BF12  ori.b  #$0, d2
00C0BF16  ori.b  #$0, d0
00C0BF1A  ori.b  #$0, d0
00C0BF1E  ori.b  #$0, d0
00C0BF22  andi.b #$40, d0
00C0BF26  ori.b  #$0, d0
00C0BF2A  ori.b  #$0, d0
00C0BF2E  ori.b  #$0, d0
00C0BF32  btst.l d0, d2
00C0BF34  ori.b  #$0, d0
00C0BF38  or.w   d0, d0
00C0BF3A  btst.b #$0, d4
00C0BF3E  ori.b  #$0, d0
00C0BF42  ori.b  #$0, d4
00C0BF46  btst.l d0, d2
00C0BF48  ori.b  #$0, d4
00C0BF4C  or.b   d0, d0
00C0BF4E  move.w d5, d0
00C0BF50  ori.b  #$0, d0
00C0BF54  btst.b #$4, d0
00C0BF58  andi.b #$0, d0
00C0BF5C  ori.b  #$0, d2
00C0BF60  or.b   -(a3), d0
00C0BF62  or.b   d7, d0
00C0BF64  ori.b  #$0, d0
00C0BF68  move.l d0, d0
00C0BF6A  ori.b  #$0, d4
00C0BF6E  ori.l  #$100, d1
00C0BF74  or.b   d0, d0
00C0BF76  ori.b  #$0, d7
00C0BF7A  ori.b  #$0, d0
00C0BF7E  ori.b  #$0, d4
00C0BF82  ori.l  #$10100, d1
00C0BF88  ori.b  #$2, d0
00C0BF8C  ori.b  #$2, d0
00C0BF90  ori.b  #$0, d0
00C0BF94  ori.b  #$0, d0
00C0BF98  ori.b  #$0, d0
00C0BF9C  ori.b  #$0, d0
00C0BFA0  ori.b  #$8, d0
00C0BFA4  ori.b  #$0, d0
00C0BFA8  ori.l  #$408000, d0
00C0BFAE  or.b   d0, d0
00C0BFB0  ori.b  #$2, d0
00C0BFB4  ori.b  #$20, d0
00C0BFB8  ori.b  #$2, d0
00C0BFBC  ori.l  #$400000, d0
00C0BFC2  negx.b d0
00C0BFC4  negx.b d0
00C0BFC6  ori.b  #$0, d0
00C0BFCA  ori.l  #$2, d0
00C0BFD0  ori.b  #$0, d0
00C0BFD4  negx.b d0
00C0BFD6  negx.b d0
00C0BFD8  negx.b d0
00C0BFDA  ori.b  #$0, d0
00C0BFDE  andi.b #$0, d0
00C0BFE2  ori.b  #$40, d2
00C0BFE6  ori.b  #$0, -(a0)
00C0BFEA  move.l d0, d0
00C0BFEC  negx.b d0
00C0BFEE  ori.b  #$80, d0
00C0BFF2  btst.b #$0, d0
00C0BFF6  ori.b  #$0, d2
00C0BFFA  ori.b  #$0, -(a0)
00C0BFFE  move.l d0, d0
00C0C000  negx.b d0
00C0C002  ori.b  #$20, d0
00C0C006  move.l d0, d0
00C0C008  ori.b  #$0, d0
00C0C00C  ori.b  #$0, -(a0)
00C0C010  ori.b  #$0, d0
00C0C014  negx.b d0
00C0C016  ori.b  #$8, d0
00C0C01A  ori.b  #$0, d0
00C0C01E  move.b d0, -(a7)
00C0C020  ori.b  #$10, d0
00C0C024  move.b d0, d0
00C0C026  move.l d0, d0
00C0C028  negx.b d0
00C0C02A  ori.b  #$3, d0
00C0C02E  ori.b  #$0, d0
00C0C032  move.w d0, $10(a7, d0.w)
00C0C036  ori.b  #$0, (a0)
00C0C03A  move.l d0, d0
00C0C03C  ori.b  #$0, d0
00C0C040  move.b d0, d4
00C0C042  moveq  #$0, d0
00C0C044  ori.b  #$81, d0
00C0C048  ori.b  #$0, d0
00C0C04C  ; data: 0x08, 0x00
00C0C04E  dc.w   $4100
00C0C050  ori.b  #$0, d0
00C0C054  cmpi.b #$0, d0
00C0C058  ori.b  #$81, d0
00C0C05C  ; data: 0x00, 0x08
00C0C05E  ; data: 0x00, 0x08
00C0C060  ori.b  #$0, d0
00C0C064  move.l d0, d0
00C0C066  ori.b  #$0, d0
00C0C06A  ori.b  #$0, d0
00C0C06E  move.b d1, -(a7)
00C0C070  ori.b  #$8, d0
00C0C074  subi.b #$0, d0
00C0C078  move.l d0, d0
00C0C07A  ori.b  #$0, d0
00C0C07E  ori.b  #$0, d0
00C0C082  ; data: 0x0e, 0x00
00C0C084  ori.b  #$0, d0
00C0C088  subi.b #$0, d2
00C0C08C  move.l d0, d0
00C0C08E  ori.b  #$c0, d0
00C0C092  ori.b  #$0, d0
00C0C096  ori.b  #$2, d0
00C0C09A  ori.b  #$c, d5
00C0C09E  ori.b  #$0, d0
00C0C0A2  ori.b  #$e0, d1
00C0C0A6  ori.b  #$0, d0
00C0C0AA  ori.b  #$0, d0
00C0C0AE  ori.b  #$c0, d5
00C0C0B2  ori.b  #$0, d0
00C0C0B6  ori.b  #$f8, d3
00C0C0BA  ori.b  #$0, d0
00C0C0BE  ori.b  #$0, d0
00C0C0C2  ori.b  #$0, d1
00C0C0C6  andi.b #$0, d0
00C0C0CA  ori.b  #$7e, d7
00C0C0CE  ori.b  #$0, d0
00C0C0D2  ori.b  #$0, d0
00C0C0D6  bset.b d1, d1
00C0C0D8  and.b  d0, d0
00C0C0DA  andi.b #$0, d0
00C0C0DE  ori.b  #$3f, d3
00C0C0E2  and.b  d0, d0
00C0C0E4  ori.b  #$0, d0
00C0C0E8  or.b   d0, d0
00C0C0EA  ori.b  #$3, d1
00C0C0EE  andi.b #$0, d0
00C0C0F2  ori.b  #$1f, d1
00C0C0F6  and.b  d0, d0
00C0C0F8  ori.l  #$60000, d0
00C0C0FE  ori.b  #$6, d3
00C0C102  ori.b  #$0, d0
00C0C106  ; data: 0x08, 0x00
00C0C108  ror.b  #$8, d7
00C0C10A  ori.b  #$40, d0
00C0C10E  ori.b  #$0, d0
00C0C112  ori.b  #$3c, d3
00C0C116  subi.b #$0, d0
00C0C11A  move.b d0, d0
00C0C11C  negx.b (a6)+
00C0C11E  ori.b  #$0, d0
00C0C122  ori.b  #$0, d0
00C0C126  ori.b  #$f8, d7
00C0C12A  subi.b #$0, d0
00C0C12E  ori.b  #$0, d0
00C0C132  ori.b  #$10, d0
00C0C136  ori.b  #$0, d0
00C0C13A  ori.b  #$f0, d7
00C0C13E  ori.b  #$0, d0
00C0C142  move.l d0, d0
00C0C144  dc.w   $e70
00C0C146  ori.b  #$0, d0
00C0C14A  ori.b  #$0, d0
00C0C14E  ; data: 0x00, 0x0f
00C0C150  ; data: 0xff, 0xe0
00C0C152  ; data: 0x08, 0x00
00C0C154  move.b d0, d0
00C0C156  ori.b  #$7, d0
00C0C15A  ori.b  #$0, d0
00C0C15E  ori.b  #$ff, d0
00C0C162  ; data: 0xff, 0xff
00C0C164  ; data: 0xff, 0xc0
00C0C166  ori.b  #$0, d0
00C0C16A  negx.b d1
00C0C16C  or.b   d0, d0
00C0C16E  ori.b  #$0, d0
00C0C172  ori.b  #$ff, d0
00C0C176  ; data: 0xff, 0xff
00C0C178  ; data: 0xff, 0xc0
00C0C17A  move.b d0, d0
00C0C17C  ori.b  #$2, d0
00C0C180  ori.b  #$0, d0
00C0C184  ori.b  #$1, d0
00C0C188  ; data: 0xff, 0xff
00C0C18A  ; data: 0xff, 0xff
00C0C18C  ; data: 0xff, 0x80
00C0C18E  ori.b  #$0, d0
00C0C192  or.b   d0, d0
00C0C194  ori.b  #$0, d0
00C0C198  ori.b  #$1, d0
00C0C19C  ; data: 0xff, 0xff
00C0C19E  ; data: 0xff, 0xff
00C0C1A0  ; data: 0xff, 0x00
00C0C1A2  move.l d0, d0
00C0C1A4  or.b   d0, d4
00C0C1A6  move.l d0, d0
00C0C1A8  ori.b  #$0, d0
00C0C1AC  ori.b  #$0, d0
00C0C1B0  ; data: 0x3f, 0xff
00C0C1B2  ; data: 0xff, 0xff
00C0C1B4  dc.w   $fe00
00C0C1B6  ; data: 0x08, 0x00
00C0C1B8  or.b   d1, d4
00C0C1BA  move.l d0, d0
00C0C1BC  ori.b  #$0, d0
00C0C1C0  btst.l d0, d0
00C0C1C2  ori.b  #$ff, d0
00C0C1C6  ; data: 0xe7, 0xff
00C0C1C8  dc.w   $fc00
00C0C1CA  andi.b #$0, d0
00C0C1CE  move.l d0, d0
00C0C1D0  ori.b  #$0, d0
00C0C1D4  btst.l d0, d0
00C0C1D6  ori.b  #$0, d0
00C0C1DA  ; data: 0x03, 0xff
00C0C1DC  asr.b  #$8, d0
00C0C1DE  ori.l  #$c0026000, d0
00C0C1E4  ori.b  #$0, d0
00C0C1E8  andi.b #$0, d0
00C0C1EC  ori.b  #$ff, d0
00C0C1F0  or.b   d0, d0
00C0C1F2  ori.b  #$4, -(a0)
00C0C1F6  bra.w  $c0c1f8
00C0C1FA  ori.b  #$0, d0
00C0C1FE  ori.b  #$0, d0
00C0C202  ; data: 0x00, 0xff
00C0C204  ori.b  #$6, d0
00C0C208  and.b  d0, d2
00C0C20A  ; data: 0x71, 0x00
00C0C20C  ori.b  #$0, d0
00C0C210  subi.b #$0, d0
00C0C214  ori.b  #$7c, d0
00C0C218  ori.b  #$7, d0
00C0C21C  and.b  d0, d0
00C0C21E  ; data: 0x71, 0x00
00C0C220  ori.b  #$0, d0
00C0C224  bclr.b #$0, d0
00C0C228  ori.b  #$38, d0
00C0C22C  ori.b  #$7, d0
00C0C230  asr.b  #$1, d0
00C0C232  dc.w   $f080
00C0C234  ori.b  #$0, d0
00C0C238  move.b d0, -(a0)
00C0C23A  ori.b  #$0, d0
00C0C23E  ori.b  #$0, (a0)
00C0C242  ; data: 0x07, 0xff
00C0C244  asr.b  #$1, d0
00C0C246  dc.w   $f000
00C0C248  ori.b  #$0, d0
00C0C24C  btst.l d1, (a0)
00C0C24E  ori.b  #$0, d0
00C0C252  ori.b  #$0, d0
00C0C256  ; data: 0x03, 0xff
00C0C258  asr.b  #$8, d1
00C0C25A  dc.w   $f800
00C0C25C  ori.b  #$0, d0
00C0C260  not.b  (a0)
00C0C262  ori.b  #$0, -(a0)
00C0C266  ori.b  #$0, d0
00C0C26A  ; data: 0x01, 0xff
00C0C26C  asr.b  #$8, d1
00C0C26E  dc.w   $f800
00C0C270  ori.b  #$0, d0
00C0C274  or.b   (a0), d7
00C0C276  ori.b  #$0, (a0)
00C0C27A  ori.b  #$0, d0
00C0C27E  ; data: 0x00, 0x7f
00C0C280  dc.w   $f000
00C0C282  move.w d0, d4
00C0C284  ori.b  #$2, d0
00C0C288  move.b (a0), d7
00C0C28A  ori.b  #$0, d0
00C0C28E  subi.b #$0, d1
00C0C292  ori.b  #$0, (a7)+
00C0C296  move.w d4, d6
00C0C298  ori.b  #$8, d0
00C0C29C  move.w d0, d6
00C0C29E  ori.b  #$0, d0
00C0C2A2  ; data: 0x02, 0x08
00C0C2A4  ori.b  #$f, (a6)
00C0C2A8  dc.w   $f800
00C0C2AA  move.b d3, d6
00C0C2AC  ori.b  #$60, d0
00C0C2B0  moveq  #$20, d6
00C0C2B2  ori.b  #$0, d2
00C0C2B6  ori.b  #$0, d0
00C0C2BA  or.b   d7, d0
00C0C2BC  sub.b  d0, d4
00C0C2BE  move.b d0, d7
00C0C2C0  and.b  d0, d0
00C0C2C2  btst.l d1, d1
00C0C2C4  dc.w   $f820
00C0C2C6  ori.b  #$0, d1
00C0C2CA  ori.b  #$0, d0
00C0C2CE  move.l d3, d0
00C0C2D0  or.b   d0, d2
00C0C2D2  ; data: 0x0e, 0x00
00C0C2D4  move.b d0, -(a7)
00C0C2D6  dc.w   $f00f
00C0C2D8  dc.w   $f820
00C0C2DA  ori.b  #$0, d0
00C0C2DE  ori.w  #$0, (a0)
00C0C2E2  ; data: 0x08, 0x01
00C0C2E4  and.b  d0, d0
00C0C2E6  move.l d0, d3
00C0C2E8  ori.b  #$1e, d0
00C0C2EC  moveq  #$40, d4
00C0C2EE  ori.b  #$0, d0
00C0C2F2  ori.b  #$0, d0
00C0C2F6  andi.b #$0, d0
00C0C2FA  or.b   d0, d1
00C0C2FC  ori.b  #$4, d0
00C0C300  movea.w d0, a0
00C0C302  ori.b  #$0, d0
00C0C306  ori.b  #$0, d0
00C0C30A  ori.l  #$40010000, d0
00C0C310  ori.b  #$0, d0
00C0C314  move.b d0, (a0)
00C0C316  ori.b  #$0, d0
00C0C31A  ori.b  #$0, d0
00C0C31E  ori.b  #$0, -(a0)
00C0C322  move.b d0, d0
00C0C324  ori.b  #$0, d0
00C0C328  ori.b  #$0, d0
00C0C32C  ori.b  #$0, d0
00C0C330  ori.b  #$c, d0
00C0C334  ori.b  #$0, d0
00C0C338  ori.b  #$0, d0
00C0C33C  ori.b  #$7, d0
00C0C340  dc.w   $fe00
00C0C342  ori.b  #$0, d0
00C0C346  ori.b  #$0, d2
00C0C34A  ori.b  #$0, d0
00C0C34E  ori.b  #$0, d0
00C0C352  ; data: 0x00, 0x0f
00C0C354  ; data: 0xff, 0xfc
00C0C356  ori.b  #$0, d0
00C0C35A  ori.b  #$0, d0
00C0C35E  ori.b  #$0, d0
00C0C362  ori.b  #$0, d0
00C0C366  ; data: 0x00, 0x0f
00C0C368  ; data: 0xff, 0xff
00C0C36A  dc.w   $fc00
00C0C36C  ori.b  #$0, d0
00C0C370  btst.b #$0, d0
00C0C374  ori.b  #$0, d0
00C0C378  ori.b  #$f, d0
00C0C37C  ; data: 0xff, 0xff
00C0C37E  ; data: 0xff, 0xf0
00C0C380  ori.b  #$0, d0
00C0C384  ori.b  #$80, d0
00C0C388  ori.b  #$0, d0
00C0C38C  move.l d0, d0
00C0C38E  move.w a7, d0
00C0C390  ; data: 0xff, 0xff
00C0C392  ; data: 0xff, 0xff
00C0C394  or.b   d0, d0
00C0C396  ori.b  #$0, d0
00C0C39A  ori.w  #$0, d0
00C0C39E  ori.b  #$0, d0
00C0C3A2  move.w a7, d4
00C0C3A4  ; data: 0xff, 0xff
00C0C3A6  ; data: 0xff, 0xff
00C0C3A8  dc.w   $f000
00C0C3AA  ori.b  #$0, d0
00C0C3AE  ori.b  #$0, (a0)
00C0C3B2  ori.b  #$0, d3
00C0C3B6  move.w a7, d6
00C0C3B8  ; data: 0xff, 0xff
00C0C3BA  ; data: 0xff, 0xff
00C0C3BC  dc.w   $fe00
00C0C3BE  ori.b  #$0, d0
00C0C3C2  ; data: 0x00, 0x08
00C0C3C4  ori.b  #$18, d0
00C0C3C8  ori.b  #$f, $ffff.w
00C0C3CE  ; data: 0xff, 0xff
00C0C3D0  ; data: 0xff, 0xc0
00C0C3D2  ori.b  #$0, d0
00C0C3D6  ori.b  #$0, d3
00C0C3DA  ; data: 0x00, 0xc0
00C0C3DC  ; data: 0x00, 0xf8
00C0C3DE  move.w a7, -(a7)
00C0C3E0  ; data: 0xff, 0xff
00C0C3E2  ; data: 0xff, 0xff
00C0C3E4  ; data: 0xff, 0xf0
00C0C3E6  ori.b  #$0, d0
00C0C3EA  ori.b  #$0, d0
00C0C3EE  move.w d0, d6
00C0C3F0  bset.b d1, $3f0f.w
00C0C3F4  ; data: 0xff, 0xff
00C0C3F6  ; data: 0xff, 0xff
00C0C3F8  ; data: 0xff, 0xfc
00C0C3FA  ori.b  #$0, d0
00C0C3FE  ori.b  #$0, d0
00C0C402  ori.b  #$f8, d0
00C0C406  move.w a7, ([$ffffffff])
00C0C40E  ori.b  #$0, d0
00C0C412  ori.b  #$0, d0
00C0C416  ori.b  #$f8, d0
00C0C41A  ; data: 0x3f, 0xcf
00C0C41C  ; data: 0xff, 0xff
00C0C41E  ; data: 0xff, 0xff
00C0C420  ; data: 0xff, 0xff
00C0C422  and.b  d0, d0
00C0C424  ori.b  #$0, d0
00C0C428  ori.b  #$7, d0
00C0C42C  ; data: 0xff, 0xf8
00C0C42E  ; data: 0x3f, 0xcf
00C0C430  ; data: 0x80, 0x7f
00C0C432  ; data: 0xff, 0xff
00C0C434  ; data: 0xff, 0xff
00C0C436  dc.w   $f000
00C0C438  ori.b  #$0, d0
00C0C43C  ori.b  #$7f, d0
00C0C440  ; data: 0xff, 0xf8
00C0C442  ; data: 0x3f, 0xef
00C0C444  and.b  d0, d0
00C0C446  ; data: 0x7f, 0xff
00C0C448  ; data: 0xff, 0xff
00C0C44A  dc.w   $fc00
00C0C44C  ori.b  #$0, d0
00C0C450  ori.b  #$ff, d0
00C0C454  ; data: 0xff, 0xf8
00C0C456  ; data: 0x3f, 0xff
00C0C458  and.b  d0, d0
00C0C45A  ; data: 0x00, 0xff
00C0C45C  ; data: 0xff, 0xff
00C0C45E  ; data: 0xff, 0x00
00C0C460  ori.b  #$0, d0
00C0C464  ori.b  #$ff, d0
00C0C468  ; data: 0xff, 0xf8
00C0C46A  ; data: 0x3f, 0xff
00C0C46C  asr.b  #$8, d0
00C0C46E  ori.b  #$ff, d7
00C0C472  ; data: 0xff, 0xc0
00C0C474  ori.b  #$0, d0
00C0C478  ori.b  #$ff, d7
00C0C47C  ; data: 0xff, 0xf8
00C0C47E  ; data: 0x0f, 0xff
00C0C480  asr.b  #$8, d0
00C0C482  ori.b  #$ff, d0
00C0C486  ; data: 0xff, 0xe0
00C0C488  ori.b  #$0, d0
00C0C48C  ; data: 0x00, 0x7f
00C0C48E  ; data: 0xff, 0xff
00C0C490  ; data: 0xff, 0xf8
00C0C492  ; data: 0x07, 0xff
00C0C494  dc.w   $f000
00C0C496  ori.b  #$ff, d0
00C0C49A  ; data: 0xff, 0xf8
00C0C49C  ori.b  #$0, d0
00C0C4A0  ; data: 0x07, 0xff
00C0C4A2  ; data: 0xff, 0xff
00C0C4A4  ; data: 0xff, 0xf0
00C0C4A6  ; data: 0x03, 0xff
00C0C4A8  dc.w   $f000
00C0C4AA  ori.b  #$ff, d0
00C0C4AE  ; data: 0xff, 0xfc
00C0C4B0  ori.b  #$0, d0
00C0C4B4  ; data: 0x7f, 0xff
00C0C4B6  ; data: 0xff, 0xff
00C0C4B8  ; data: 0xff, 0xe0
00C0C4BA  ; data: 0x03, 0xff
00C0C4BC  dc.w   $f000
00C0C4BE  ori.b  #$3f, d0
00C0C4C2  ; data: 0xff, 0xfe
00C0C4C4  ori.b  #$0, d0
00C0C4C8  ; data: 0xff, 0xff
00C0C4CA  ; data: 0xff, 0xff
00C0C4CC  ; data: 0xff, 0xe0
00C0C4CE  ; data: 0x01, 0xff
00C0C4D0  dc.w   $f800
00C0C4D2  ori.b  #$f, d0
00C0C4D6  ; data: 0xff, 0xff
00C0C4D8  or.b   d0, d0
00C0C4DA  ori.b  #$ff, d0
00C0C4DE  ; data: 0xff, 0xff
00C0C4E0  ; data: 0xff, 0xe0
00C0C4E2  ; data: 0x01, 0xff
00C0C4E4  dc.w   $f800
00C0C4E6  ori.b  #$3, d0
00C0C4EA  ; data: 0xff, 0xff
00C0C4EC  and.b  d0, d0
00C0C4EE  ori.b  #$ff, d0
00C0C4F2  ; data: 0xff, 0xff
00C0C4F4  ; data: 0xff, 0xe0
00C0C4F6  ; data: 0x00, 0xff
00C0C4F8  dc.w   $f800
00C0C4FA  ori.b  #$0, d0
00C0C4FE  ; data: 0xff, 0xff
00C0C500  dc.w   $f000
00C0C502  ori.b  #$ff, d0
00C0C506  ; data: 0xff, 0xff
00C0C508  bset.b d7, -(a0)
00C0C50A  ; data: 0x00, 0xff
00C0C50C  dc.w   $f800
00C0C50E  ori.b  #$0, d0
00C0C512  ; data: 0x3f, 0xff
00C0C514  dc.w   $f800
00C0C516  ori.b  #$ff, d0
00C0C51A  ; data: 0xff, 0xf8
00C0C51C  ; data: 0x1f, 0xc0
00C0C51E  ; data: 0x00, 0x7f
00C0C520  dc.w   $fc00
00C0C522  ori.b  #$0, d0
00C0C526  ; data: 0x0f, 0xff
00C0C528  dc.w   $fe00
00C0C52A  ori.b  #$ff, d0
00C0C52E  ; data: 0xff, 0x80
00C0C530  ; data: 0x3f, 0xc0
00C0C532  ; data: 0x00, 0x7f
00C0C534  dc.w   $fc00
00C0C536  ori.b  #$0, d0
00C0C53A  ; data: 0x07, 0xff
00C0C53C  ; data: 0xff, 0x00
00C0C53E  ori.b  #$ff, d0
00C0C542  dc.w   $f800
00C0C544  ; data: 0x3f, 0xc0
00C0C546  ; data: 0x00, 0x3f
00C0C548  dc.w   $fc00
00C0C54A  ori.b  #$0, d0
00C0C54E  ; data: 0x01, 0xff
00C0C550  ; data: 0xff, 0xc0
00C0C552  ori.b  #$ff, d0
00C0C556  or.b   d0, d0
00C0C558  ; data: 0x7f, 0xc0
00C0C55A  ; data: 0x00, 0x3f
00C0C55C  dc.w   $fc00
00C0C55E  ori.b  #$0, d0
00C0C562  ; data: 0x00, 0xff
00C0C564  ; data: 0xff, 0xf0
00C0C566  ori.b  #$f8, d0
00C0C56A  ori.b  #$c0, d0
00C0C56E  ori.b  #$0, (a7)+
00C0C572  ori.b  #$0, d0
00C0C576  ; data: 0x00, 0x3f
00C0C578  ; data: 0xff, 0xfc
00C0C57A  ori.b  #$80, d0
00C0C57E  ori.b  #$80, d1
00C0C582  ori.b  #$0, (a7)+
00C0C586  ori.b  #$0, d0
00C0C58A  ori.b  #$ff, (a7)+
00C0C58E  ori.b  #$0, d0
00C0C592  ori.b  #$80, d3
00C0C596  ; data: 0x00, 0x0f
00C0C598  dc.w   $fe00
00C0C59A  ori.b  #$0, d0
00C0C59E  ori.b  #$ff, d7
00C0C5A2  and.b  d0, d0
00C0C5A4  ori.b  #$7, d0
00C0C5A8  ; data: 0xff, 0x80
00C0C5AA  ; data: 0x00, 0x0f
00C0C5AC  dc.w   $fe00
00C0C5AE  ori.b  #$0, d0
00C0C5B2  ori.b  #$ff, d3
00C0C5B6  dc.w   $f000
00C0C5B8  ori.b  #$f, d0
00C0C5BC  ; data: 0xff, 0x00
00C0C5BE  ori.b  #$0, d7
00C0C5C2  ori.b  #$0, d0
00C0C5C6  ori.b  #$ff, d1
00C0C5CA  dc.w   $fc00
00C0C5CC  ori.b  #$3f, d0
00C0C5D0  ; data: 0xff, 0x00
00C0C5D2  ori.b  #$0, d7
00C0C5D6  ori.b  #$0, d0
00C0C5DA  ori.b  #$ff, d0
00C0C5DE  ; data: 0xff, 0x80
00C0C5E0  ori.b  #$ff, d0
00C0C5E4  dc.w   $fe00
00C0C5E6  ori.b  #$0, d3
00C0C5EA  ori.b  #$0, d0
00C0C5EE  ori.b  #$ff, d0
00C0C5F2  ; data: 0xff, 0xf0
00C0C5F4  ori.b  #$ff, d0
00C0C5F8  dc.w   $fc00
00C0C5FA  ori.b  #$0, d3
00C0C5FE  ori.b  #$0, d0
00C0C602  ori.b  #$ff, d0
00C0C606  ; data: 0xff, 0xfc
00C0C608  ori.b  #$ff, d0
00C0C60C  dc.w   $f800
00C0C60E  ori.b  #$0, d1
00C0C612  ori.b  #$0, d0
00C0C616  ori.b  #$ff, d0
00C0C61A  ; data: 0xff, 0xff
00C0C61C  or.b   d0, d0
00C0C61E  ; data: 0x3f, 0xff
00C0C620  dc.w   $f000
00C0C622  ori.b  #$0, d1
00C0C626  ori.b  #$0, d0
00C0C62A  ori.b  #$ff, d0
00C0C62E  ; data: 0xff, 0xff
00C0C630  dc.w   $fc03
00C0C632  ; data: 0xff, 0xff
00C0C634  asr.b  #$8, d0
00C0C636  ori.b  #$0, d0
00C0C63A  ori.b  #$0, d0
00C0C63E  ori.b  #$7f, d0
00C0C642  ; data: 0xff, 0xff
00C0C644  ; data: 0xff, 0xff
00C0C646  ; data: 0xff, 0xff
00C0C648  and.b  d0, d0
00C0C64A  ori.b  #$0, d0
00C0C64E  ori.b  #$0, d0
00C0C652  ori.b  #$1f, d0
00C0C656  ; data: 0xff, 0xff
00C0C658  ; data: 0xff, 0xff
00C0C65A  ; data: 0xff, 0xff
00C0C65C  or.b   d0, d0
00C0C65E  ori.b  #$0, d0
00C0C662  ori.b  #$0, d0
00C0C666  ori.b  #$7, d0
00C0C66A  ; data: 0xff, 0xff
00C0C66C  ; data: 0xff, 0xff
00C0C66E  ; data: 0xff, 0xff
00C0C670  ori.b  #$0, d0
00C0C674  moveq  #$0, d7
00C0C676  ori.b  #$0, d0
00C0C67A  ori.b  #$1, d0
00C0C67E  ; data: 0xff, 0xff
00C0C680  ; data: 0xff, 0xff
00C0C682  ; data: 0xff, 0xfe
00C0C684  ori.b  #$0, d0
00C0C688  move.w d0, d7
00C0C68A  ori.b  #$0, d0
00C0C68E  ori.b  #$0, d0
00C0C692  ; data: 0x7f, 0xff
00C0C694  ; data: 0xff, 0xff
00C0C696  ; data: 0xff, 0xfc
00C0C698  ori.b  #$0, d0
00C0C69C  move.w d0, d7
00C0C69E  ori.b  #$0, d0
00C0C6A2  ori.b  #$0, d0
00C0C6A6  ; data: 0x1f, 0xff
00C0C6A8  ; data: 0xff, 0xff
00C0C6AA  ; data: 0xff, 0xf0
00C0C6AC  ori.b  #$0, d0
00C0C6B0  move.b d0, d7
00C0C6B2  ori.b  #$0, d0
00C0C6B6  ori.b  #$0, d0
00C0C6BA  ; data: 0x03, 0xff
00C0C6BC  ; data: 0xff, 0xff
00C0C6BE  ; data: 0xff, 0xc0
00C0C6C0  ori.b  #$0, d0
00C0C6C4  move.b d0, d7
00C0C6C6  ori.b  #$0, d0
00C0C6CA  ori.b  #$0, d0
00C0C6CE  ; data: 0x00, 0x7f
00C0C6D0  ; data: 0xff, 0xff
00C0C6D2  ; data: 0xff, 0x00
00C0C6D4  ori.b  #$0, d0
00C0C6D8  ; data: 0x0e, 0x00
00C0C6DA  ori.b  #$0, d0
00C0C6DE  ori.b  #$0, d0
00C0C6E2  ori.b  #$ff, (a7)+
00C0C6E6  dc.w   $fc00
00C0C6E8  ori.b  #$0, d0
00C0C6EC  ; data: 0x0e, 0x00
00C0C6EE  ori.b  #$0, d0
00C0C6F2  ori.b  #$0, d0
00C0C6F6  ori.b  #$ff, d3
00C0C6FA  dc.w   $f000
00C0C6FC  ori.b  #$0, d0
00C0C700  ori.b  #$0, d0
00C0C704  ori.b  #$0, d0
00C0C708  ori.b  #$0, d0
00C0C70C  ; data: 0x1f, 0xff
00C0C70E  ori.b  #$0, d0
00C0C712  ori.b  #$0, d0
00C0C716  ori.b  #$0, d0
00C0C71A  ori.b  #$0, d0
00C0C71E  ori.b  #$0, d0
00C0C722  ori.b  #$0, d0