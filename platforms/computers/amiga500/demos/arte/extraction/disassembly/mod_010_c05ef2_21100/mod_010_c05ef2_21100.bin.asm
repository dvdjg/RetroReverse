; mod_010_c05ef2_21100.bin desensamblado
; base 0x10 len 21100
; sha1 2c858c7121d0cb2716f9838992364202dd659a6c

00000010  jmp    $10.l
00000016  jmp    $9a.l
0000001C  ; data: 0x73, 0x6f
0000001E  ; data: 0x73, 0x00
00000020  movea.l $4.w, a6
00000024  movea.l $114(a6), a4
00000028  tst.l  $ac(a4)
0000002C  bne.b  $48
0000002E  lea.l  $5c(a4), a0
00000032  jsr    -$180(a6)
00000036  lea.l  $5c(a4), a0
0000003A  jsr    -$174(a6)
0000003E  move.l d0, $7a.l
00000044  lea.l  $8e(pc), a2
00000048  lea.l  $9e(pc), a1
0000004C  moveq  #$0, d0
0000004E  movea.l $4.w, a6
00000052  jsr    -$228(a6)
00000056  tst.l  d0
00000058  beq.b  $72
0000005A  movea.l d0, a6
0000005C  move.l a6, -(a7)
0000005E  lea.l  $9a.l, a0
00000064  jsr    -$1e(a6)
00000068  movea.l (a7)+, a1
0000006A  movea.l $4.w, a6
0000006E  jsr    -$19e(a6)
00000072  move.l $8a(pc), d2
00000076  beq.b  $86
00000078  movea.l $4.w, a6
0000007C  jsr    -$84(a6)
00000080  movea.l d2, a1
00000082  jsr    -$17a(a6)
00000086  moveq  #$0, d0
00000088  rts    
0000008A  ori.b  #$0, d0
0000008E  ori.b  #$0, d0
00000092  ori.b  #$0, d0
00000096  ori.b  #$0, d0
0000009A  ori.b  #$0, d0
0000009E  ; data: 0x73, 0x6f
000000A0  ; data: 0x73, 0x2e
000000A2  bge.b  $10d
000000A4  bhi.b  $118
000000A6  bsr.b  $11a
000000A8  ; data: 0x79, 0x00
000000AA  moveq  #$8, d0
000000AC  suba.l a0, a0
000000AE  jsr    -$ba(a6)
000000B2  lea.l  $0.l, a5
000000B8  move.l a6, $0(a5)
000000BC  move.l a2, -(a7)
000000BE  jsr    -$11a(a6)
000000C2  movea.l a0, a2
000000C4  movea.l $26(a2), a0
000000C8  move.l a0, d0
000000CA  bne.b  $e2
000000CC  moveq  #$1c, d0
000000CE  moveq  #$0, d1
000000D0  jsr    -$2a(a6)
000000D4  movea.l d0, a0
000000D6  moveq  #$6, d1
000000D8  clr.l  (a0)+
000000DA  dbra   d1, $d8
000000DE  move.l d0, $26(a2)
000000E2  movea.l d0, a2
000000E4  move.l a2, $8(a5)
000000E8  tst.w  $e(a2)
000000EC  bne.b  $f4
000000EE  move.w #$6c0, $e(a2)
000000F4  tst.l  $4(a2)
000000F8  bne.b  $114
000000FA  move.l #$44425547, d0
00000100  jsr    -$138(a6)
00000104  movea.l $8(a5), a1
00000108  move.l a0, $18(a1)
0000010C  move.l #$114, $4(a2)
00000114  tst.l  $8(a2)
00000118  bne.b  $164
0000011A  move.l #$12c, $8(a2)
00000122  bra.b  $164
00000124  move.l a5, -(a7)
00000126  lea.l  $0.l, a5
0000012C  movea.l $8(a5), a4
00000130  movea.l $18(a4), a4
00000134  jsr    -$c(a4)
00000138  movea.l (a7)+, a5
0000013A  rts    
0000013C  move.l a5, -(a7)
0000013E  lea.l  $0.l, a5
00000144  movea.l $8(a5), a0
00000148  btst.b #$2, $dff016.l
00000150  bne.b  $15c
00000152  move.w $e(a0), $c(a0)
00000158  movea.l (a7)+, a5
0000015A  rts    
0000015C  movea.l (a7)+, a5
0000015E  addq.w #$1, $c(a0)
00000162  rts    
00000164  movea.l (a7)+, a2
00000166  bsr.w  $b9c
0000016A  movea.l $8(a5), a0
0000016E  movea.l $4(a0), a0
00000172  jsr    (a0)
00000174  movea.l $8(a5), a0
00000178  move.w $c(a0), d0
0000017C  cmp.w  $10(a0), d0
00000180  bcs.b  $16a
00000182  moveq  #$9, d0
00000184  trap   #$d
00000186  lea.l  $0.l, a0
0000018C  lea.l  $1cc(pc), a1
00000190  moveq  #$20, d0
00000192  jsr    -$54(a6)
00000196  bsr.w  $b72
0000019A  bsr.w  $1f8
0000019E  jsr    -$11a(a6)
000001A2  movea.l $26(a0), a1
000001A6  cmpi.w #$13, $1c(a1)
000001AC  beq.b  $1c8
000001AE  movea.l $8(a5), a0
000001B2  movea.l $4(a0), a0
000001B6  jsr    (a0)
000001B8  movea.l $8(a5), a0
000001BC  move.w $c(a0), d0
000001C0  cmp.w  $e(a0), d0
000001C4  bcs.w  $19a
000001C8  moveq  #$0, d0
000001CA  rts    
000001CC  movem.l d0-d7/a0-a6, -(a7)
000001D0  lea.l  $0.l, a5
000001D6  movea.l $0(a5), a6
000001DA  movea.l $8(a5), a0
000001DE  movea.l $8(a0), a0
000001E2  jsr    (a0)
000001E4  bsr.w  $1fa
000001E8  movem.l (a7)+, d0-d7/a0-a6
000001EC  move.w #$30, $dff09c.l
000001F4  nop    
000001F6  rte    
000001F8  rts    
000001FA  addq.w #$1, $26c.l
00000200  bsr.w  $f34
00000204  cmpi.w #$6a0, $26c.l
0000020C  bne.b  $216
0000020E  move.b #$10, $fd2.l
00000216  cmpi.w #$3, $26c.l
0000021E  ble.b  $27a
00000220  lea.l  $dff002.l, a4
00000226  cmpi.w #$14, $b60.l
0000022E  beq.b  $246
00000230  bsr.w  $dba
00000234  bsr.w  $f0a
00000238  bsr.w  $8c4
0000023C  bsr.w  $ecc
00000240  bsr.w  $e6e
00000244  bra.b  $262
00000246  tst.w  $2f4.l
0000024C  bne.b  $25a
0000024E  bsr.w  $280
00000252  move.w #$1, $2f4.l
0000025A  bsr.w  $306
0000025E  bsr.w  $648
00000262  btst.b #$6, (a4)
00000266  bne.b  $262
00000268  cmpi.w #$67a, $26c.l
00000270  bne.b  $27a
00000272  move.w #$1, $26e.l
0000027A  rts    
0000027C  ori.b  #$0, d0
00000280  lea.l  $1476.l, a0
00000286  lea.l  $9a.l, a1
0000028C  moveq  #$f, d7
0000028E  move.w (a0)+, (a1)
00000290  addq.w #$4, a1
00000292  dbra   d7, $28e
00000296  clr.l  $826.l
0000029C  clr.w  $82a.l
000002A2  clr.w  $8b0.l
000002A8  clr.w  $8b2.l
000002AE  ori.w  #$6400, $16.l
000002B6  lea.l  $e16.l, a0
000002BC  movem.l (a0)+, d0-d5
000002C0  lea.l  $68.l, a0
000002C6  move.w d0, $6(a0)
000002CA  swap   d0
000002CC  move.w d0, $2(a0)
000002D0  move.w d1, $e(a0)
000002D4  swap   d1
000002D6  move.w d1, $a(a0)
000002DA  move.w d2, $16(a0)
000002DE  swap   d2
000002E0  move.w d2, $12(a0)
000002E4  move.w d3, $1e(a0)
000002E8  swap   d3
000002EA  move.w d3, $1a(a0)
000002EE  move.w d4, $26(a0)
000002F2  swap   d4
000002F4  move.w d4, $22(a0)
000002F8  move.w d5, $2e(a0)
000002FC  swap   d5
000002FE  move.w d5, $2a(a0)
00000302  rts    
00000304  ori.b  #$f9, d0
00000308  ori.b  #$9e, d0
0000030C  lea.l  $be.l, a3
00000312  moveq  #$0, d6
00000314  cmpi.l #$4000, $826.l
0000031E  ble.b  $322
00000320  moveq  #$2, d6
00000322  lea.l  $618.l, a0
00000328  adda.l $382.l, a0
0000032E  movea.l (a0)+, a1
00000330  adda.w d6, a1
00000332  move.w (a1), d0
00000334  move.w d0, (a2)
00000336  movea.l (a0)+, a1
00000338  adda.w d6, a1
0000033A  move.w $4(a1), d0
0000033E  move.w d0, $4(a2)
00000342  move.w d0, $8(a2)
00000346  movea.l (a0)+, a1
00000348  adda.w d6, a1
0000034A  move.w $8(a1), d0
0000034E  move.w d0, $c(a2)
00000352  move.w d0, $10(a2)
00000356  move.w d0, $14(a2)
0000035A  move.w d0, $18(a2)
0000035E  movea.l (a0)+, a1
00000360  adda.w d6, a1
00000362  move.w $c(a1), d0
00000366  move.w d0, (a3)
00000368  movea.l (a0)+, a1
0000036A  adda.w d6, a1
0000036C  move.w $10(a1), d0
00000370  move.w d0, $4(a3)
00000374  move.w d0, $8(a3)
00000378  movea.l (a0)+, a1
0000037A  adda.w d6, a1
0000037C  move.w $14(a1), d0
00000380  move.w d0, $c(a3)
00000384  move.w d0, $10(a3)
00000388  move.w d0, $14(a3)
0000038C  move.w d0, $18(a3)
00000390  rts    
00000392  ori.b  #$0, d0
00000396  ori.b  #$0, d0
0000039A  move.b $0(a6), (a2)
0000039E  move.b (a6), (a2)
000003A0  ori.b  #$c6, d0
000003A4  ori.b  #$96, d0
000003A8  ori.b  #$ae, d0
000003AC  ori.b  #$96, d0
000003B0  ori.b  #$c6, d0
000003B4  ori.b  #$96, d0
000003B8  ori.b  #$ae, d0
000003BC  ori.b  #$96, d0
000003C0  ori.b  #$c6, d0
000003C4  ori.b  #$96, d0
000003C8  ori.b  #$ae, d0
000003CC  ori.b  #$96, d0
000003D0  ori.b  #$c6, d0
000003D4  ori.b  #$96, d0
000003D8  ori.b  #$ae, d0
000003DC  ori.b  #$96, d0
000003E0  ori.b  #$c6, d0
000003E4  ori.b  #$96, d0
000003E8  ori.b  #$ae, d0
000003EC  ori.b  #$96, d0
000003F0  ori.b  #$c6, d0
000003F4  ori.b  #$96, d0
000003F8  ori.b  #$ae, d0
000003FC  ori.b  #$96, d0
00000400  ori.b  #$c6, d0
00000404  ori.b  #$96, d0
00000408  ori.b  #$ae, d0
0000040C  ori.b  #$96, d0
00000410  ori.b  #$c6, d0
00000414  ori.b  #$96, d0
00000418  ori.b  #$ae, d0
0000041C  ori.b  #$96, d0
00000420  ori.b  #$c6, d0
00000424  ori.b  #$96, d0
00000428  ori.b  #$ae, d0
0000042C  ori.b  #$96, d0
00000430  ori.b  #$c6, d0
00000434  ori.b  #$96, d0
00000438  ori.b  #$ae, d0
0000043C  ori.b  #$96, d0
00000440  ori.b  #$c6, d0
00000444  ori.b  #$96, d0
00000448  ori.b  #$ae, d0
0000044C  ori.b  #$96, d0
00000450  ori.b  #$c6, d0
00000454  ori.b  #$96, d0
00000458  ori.b  #$ae, d0
0000045C  ori.b  #$96, d0
00000460  ori.b  #$c6, d0
00000464  ori.b  #$96, d0
00000468  ori.b  #$ae, d0
0000046C  ori.b  #$96, d0
00000470  ori.b  #$c6, d0
00000474  ori.b  #$96, d0
00000478  ori.b  #$ae, d0
0000047C  ori.b  #$96, d0
00000480  ori.b  #$c6, d0
00000484  ori.b  #$96, d0
00000488  ori.b  #$ae, d0
0000048C  ori.b  #$96, d0
00000490  ori.b  #$c6, d0
00000494  ori.b  #$96, d0
00000498  ori.b  #$ae, d0
0000049C  ori.b  #$96, d0
000004A0  ori.b  #$c6, d0
000004A4  ori.b  #$96, d0
000004A8  ori.b  #$ae, d0
000004AC  ori.b  #$96, d0
000004B0  ori.b  #$c6, d0
000004B4  ori.b  #$96, d0
000004B8  ori.b  #$ae, d0
000004BC  ori.b  #$96, d0
000004C0  ori.b  #$c6, d0
000004C4  ori.b  #$96, d0
000004C8  ori.b  #$ae, d0
000004CC  ori.b  #$96, d0
000004D0  ori.b  #$c6, d0
000004D4  ori.b  #$96, d0
000004D8  ori.b  #$ae, d0
000004DC  ori.b  #$96, d0
000004E0  ori.b  #$c6, d0
000004E4  ori.b  #$96, d0
000004E8  ori.b  #$ae, d0
000004EC  ori.b  #$96, d0
000004F0  ori.b  #$c6, d0
000004F4  ori.b  #$96, d0
000004F8  ori.b  #$ae, d0
000004FC  ori.b  #$96, d0
00000500  ori.b  #$c6, d0
00000504  ori.b  #$96, d0
00000508  ori.b  #$ae, d0
0000050C  ori.b  #$96, d0
00000510  ori.b  #$c6, d0
00000514  ori.b  #$96, d0
00000518  ori.b  #$ae, d0
0000051C  ori.b  #$96, d0
00000520  ori.b  #$c6, d0
00000524  ori.b  #$96, d0
00000528  ori.b  #$ae, d0
0000052C  ori.b  #$96, d0
00000530  ori.b  #$c6, d0
00000534  ori.b  #$96, d0
00000538  ori.b  #$ae, d0
0000053C  ori.b  #$96, d0
00000540  ori.b  #$c6, d0
00000544  ori.b  #$96, d0
00000548  ori.b  #$ae, d0
0000054C  ori.b  #$96, d0
00000550  ori.b  #$c6, d0
00000554  ori.b  #$96, d0
00000558  ori.b  #$ae, d0
0000055C  ori.b  #$96, d0
00000560  ori.b  #$c6, d0
00000564  ori.b  #$96, d0
00000568  ori.b  #$ae, d0
0000056C  ori.b  #$96, d0
00000570  ori.b  #$c6, d0
00000574  ori.b  #$96, d0
00000578  ori.b  #$ae, d0
0000057C  ori.b  #$96, d0
00000580  ori.b  #$c6, d0
00000584  ori.b  #$96, d0
00000588  ori.b  #$ae, d0
0000058C  ori.b  #$96, d0
00000590  ori.b  #$c6, d0
00000594  ori.b  #$96, d0
00000598  ori.b  #$ae, d0
0000059C  ori.b  #$96, d0
000005A0  ori.b  #$c6, d0
000005A4  ori.b  #$96, d0
000005A8  ori.b  #$ae, d0
000005AC  ori.b  #$96, d0
000005B0  ori.b  #$c6, d0
000005B4  ori.b  #$96, d0
000005B8  ori.b  #$ae, d0
000005BC  ori.b  #$96, d0
000005C0  ori.b  #$c6, d0
000005C4  ori.b  #$96, d0
000005C8  ori.b  #$ae, d0
000005CC  ori.b  #$96, d0
000005D0  ori.b  #$c6, d0
000005D4  ori.b  #$96, d0
000005D8  ori.b  #$ae, d0
000005DC  ori.b  #$96, d0
000005E0  ori.b  #$c6, d0
000005E4  ori.b  #$96, d0
000005E8  ori.b  #$ae, d0
000005EC  ori.b  #$96, d0
000005F0  ori.b  #$c6, d0
000005F4  ori.b  #$96, d0
000005F8  ori.b  #$ae, d0
000005FC  ori.b  #$96, d0
00000600  ori.b  #$c6, d0
00000604  ori.b  #$96, d0
00000608  ori.b  #$ae, d0
0000060C  ori.b  #$96, d0
00000610  ori.b  #$c6, d0
00000614  ori.b  #$96, d0
00000618  ori.b  #$ae, d0
0000061C  ori.b  #$96, d0
00000620  ori.b  #$c6, d0
00000624  ori.b  #$96, d0
00000628  ori.b  #$96, d0
0000062C  ori.b  #$96, d0
00000630  ori.b  #$96, d0
00000634  ori.b  #$96, d0
00000638  ori.b  #$96, d0
0000063C  ori.b  #$96, d0
00000640  ori.b  #$96, d0
00000644  ori.b  #$96, d0
00000648  btst.b #$6, (a4)
0000064C  bne.b  $648
0000064E  move.l #$ffffffff, $42(a4)
00000656  clr.w  $40(a4)
0000065A  movea.l $ce8.l, a0
00000660  lea.l  $800(a0), a0
00000664  adda.l $826.l, a0
0000066A  lea.l  $e46.l, a1
00000670  lea.l  $82c.l, a2
00000676  lea.l  $838.l, a3
0000067C  move.w $824.l, d6
00000682  move.w $82a.l, d7
00000688  move.l a0, d3
0000068A  movem.w (a2)+, d0
0000068E  move.w d0, d1
00000690  asr.l  #$4, d0
00000692  add.l  d0, d0
00000694  not.w  d1
00000696  andi.w #$f, d1
0000069A  ror.w  #$4, d1
0000069C  tst.w  d6
0000069E  bgt.b  $6a6
000006A0  ori.w  #$9f0, d1
000006A4  bra.b  $6ac
000006A6  ori.w  #$100, d1
000006AA  subq.w #$1, d6
000006AC  add.l  d0, d3
000006AE  move.l (a1)+, d4
000006B0  movem.w (a3)+, d2
000006B4  cmp.w  #$40, d2
000006B8  bge.b  $6f8
000006BA  asr.l  #$1, d2
000006BC  asl.l  #$5, d2
000006BE  add.l  d2, d3
000006C0  add.l  d2, d2
000006C2  neg.l  d2
000006C4  addi.l #$1010, d2
000006CA  cmp.l  #$1010, d2
000006D0  ble.b  $6d8
000006D2  move.l #$1010, d2
000006D8  btst.b #$6, (a4)
000006DC  bne.b  $6d8
000006DE  move.w d1, $3e(a4)
000006E2  clr.l  $62(a4)
000006E6  move.l d3, $4e(a4)
000006EA  addi.l #$800, d4
000006F0  move.l d4, $52(a4)
000006F4  move.w d2, $56(a4)
000006F8  adda.l #$a000, a0
000006FE  dbra   d7, $688
00000702  move.l $dff004.l, d0
00000708  andi.l #$fff80, d0
0000070E  cmp.l  #$b000, d0
00000714  bne.b  $702
00000716  addi.l #$1000, $826.l
00000720  addq.w #$4, $8b2.l
00000726  cmpi.l #$a000, $826.l
00000730  bne.b  $782
00000732  clr.l  $826.l
00000738  addq.w #$2, $8b0.l
0000073E  clr.w  $8b2.l
00000744  bchg.b #$0, $386.l
0000074C  cmpi.w #$5, $82a.l
00000754  bge.b  $75c
00000756  addq.w #$1, $82a.l
0000075C  tst.w  $26e.l
00000762  beq.b  $772
00000764  tst.w  $82a.l
0000076A  ble.b  $772
0000076C  addq.w #$1, $824.l
00000772  cmpi.w #$240, $26c.l
0000077A  blt.b  $782
0000077C  subq.l #$4, $382.l
00000782  bsr.w  $854
00000786  movea.l $ce8.l, a0
0000078C  adda.l $826.l, a0
00000792  lea.l  $e46.l, a1
00000798  lea.l  $82c.l, a2
0000079E  lea.l  $838.l, a3
000007A4  move.w $824.l, d6
000007AA  move.w $82a.l, d7
000007B0  move.l a0, d3
000007B2  movem.w (a2)+, d0
000007B6  move.w d0, d1
000007B8  asr.l  #$4, d0
000007BA  add.l  d0, d0
000007BC  not.w  d1
000007BE  andi.w #$f, d1
000007C2  ror.w  #$4, d1
000007C4  tst.w  d6
000007C6  bgt.b  $7ce
000007C8  ori.w  #$9f0, d1
000007CC  bra.b  $7d4
000007CE  ori.w  #$100, d1
000007D2  subq.w #$1, d6
000007D4  add.l  d0, d3
000007D6  move.l (a1)+, d4
000007D8  movem.w (a3)+, d2
000007DC  cmp.w  #$ffc0, d2
000007E0  ble.b  $828
000007E2  asr.l  #$1, d2
000007E4  asl.l  #$5, d2
000007E6  tst.l  d2
000007E8  blt.b  $7ec
000007EA  add.l  d2, d3
000007EC  add.l  d2, d2
000007EE  addi.l #$1010, d2
000007F4  cmp.l  #$1010, d2
000007FA  ble.b  $802
000007FC  move.l #$1010, d2
00000802  move.l #$1010, d5
00000808  sub.l  d2, d5
0000080A  asr.l  #$1, d5
0000080C  add.l  d5, d4
0000080E  btst.b #$6, (a4)
00000812  bne.b  $80e
00000814  move.w d1, $3e(a4)
00000818  clr.l  $62(a4)
0000081C  move.l d3, $4e(a4)
00000820  move.l d4, $52(a4)
00000824  move.w d2, $56(a4)
00000828  adda.l #$a000, a0
0000082E  dbra   d7, $7b0
00000832  rts    
00000834  ori.b  #$0, d0
00000838  ori.b  #$0, d0
0000083C  ori.b  #$0, d0
00000840  ori.b  #$0, d0
00000844  ori.b  #$0, d0
00000848  ori.b  #$0, d0
0000084C  ori.b  #$0, d0
00000850  ori.b  #$0, d0
00000854  lea.l  $fda.l, a0
0000085A  adda.w $8b0.l, a0
00000860  lea.l  $11fa.l, a1
00000866  adda.w $8b0.l, a1
0000086C  lea.l  $838.l, a2
00000872  lea.l  $844.l, a3
00000878  moveq  #$14, d1
0000087A  sub.w  $8b2.l, d1
00000880  move.w #$5, d7
00000884  moveq  #$0, d0
00000886  moveq  #$0, d2
00000888  tst.w  d1
0000088A  ble.b  $898
0000088C  move.w (a0), d0
0000088E  muls.w d1, d0
00000890  swap   d0
00000892  move.w (a1), d2
00000894  muls.w d1, d2
00000896  swap   d2
00000898  addi.w #$f, d0
0000089C  move.w d0, -(a2)
0000089E  move.w d2, -(a3)
000008A0  addi.w #$28, d1
000008A4  lea.l  $2(a0), a0
000008A8  lea.l  $2(a1), a1
000008AC  dbra   d7, $884
000008B0  cmpi.l #$ffffffff, (a0)
000008B6  bne.b  $8be
000008B8  clr.w  $8b0.l
000008BE  rts    
000008C0  ori.b  #$0, d0
000008C4  lea.l  $180e.l, a0
000008CA  adda.l $b5a.l, a0
000008D0  addi.l #$600, $b5a.l
000008DA  cmpi.l #$3c00, $b5a.l
000008E4  bne.b  $8ec
000008E6  clr.l  $b5a.l
000008EC  movea.l $ce0.l, a1
000008F2  lea.l  $400(a1), a1
000008F6  movea.l $ce4.l, a2
000008FC  lea.l  $510e.l, a3
00000902  adda.w $b5e.l, a3
00000908  addq.w #$2, $b5e.l
0000090E  move.w (a3)+, d0
00000910  tst.l  (a3)
00000912  bne.b  $924
00000914  move.w #$4b, d0
00000918  subq.w #$2, $b5e.l
0000091E  addq.w #$1, $b60.l
00000924  move.l #$8000, d7
0000092A  divu.w d0, d7
0000092C  move.w #$800, d0
00000930  move.w #$7e0, d1
00000934  moveq  #$0, d2
00000936  move.w d7, d3
00000938  add.w  d3, d3
0000093A  move.l #$80000, d6
00000940  divu.w d7, d6
00000942  andi.l #$ffff, d6
00000948  lsl.l  #$4, d6
0000094A  move.l d6, $b18.l
00000950  moveq  #$7f, d6
00000952  move.w #$3f, d7
00000956  move.l d2, d4
00000958  swap   d4
0000095A  move.w d4, d5
0000095C  add.w  d5, d5
0000095E  add.w  d5, d5
00000960  lsl.w  #$3, d4
00000962  add.w  d5, d4
00000964  move.w (a0, d4.w), d5
00000968  tst.w  d5
0000096A  beq.w  $a42
0000096E  muls.w d3, d5
00000970  swap   d5
00000972  cmp.w  d6, d5
00000974  ble.b  $978
00000976  move.w d6, d5
00000978  lsl.w  #$3, d5
0000097A  move.l (a1, d5.w), (a2)+
0000097E  add.w  d0, -$2(a2)
00000982  move.l $4(a1, d5.w), (a2)+
00000986  add.w  d1, -$2(a2)
0000098A  move.w $2(a0, d4.w), d5
0000098E  tst.w  d5
00000990  beq.w  $a42
00000994  muls.w d3, d5
00000996  swap   d5
00000998  cmp.w  d6, d5
0000099A  ble.b  $99e
0000099C  move.w d6, d5
0000099E  lsl.w  #$3, d5
000009A0  move.l (a1, d5.w), (a2)+
000009A4  add.w  d0, -$2(a2)
000009A8  move.l $4(a1, d5.w), (a2)+
000009AC  add.w  d1, -$2(a2)
000009B0  move.w $4(a0, d4.w), d5
000009B4  tst.w  d5
000009B6  beq.w  $a42
000009BA  muls.w d3, d5
000009BC  swap   d5
000009BE  cmp.w  d6, d5
000009C0  ble.b  $9c4
000009C2  move.w d6, d5
000009C4  lsl.w  #$3, d5
000009C6  move.l (a1, d5.w), (a2)+
000009CA  add.w  d0, -$2(a2)
000009CE  move.l $4(a1, d5.w), (a2)+
000009D2  add.w  d1, -$2(a2)
000009D6  move.w $6(a0, d4.w), d5
000009DA  tst.w  d5
000009DC  beq.b  $a42
000009DE  muls.w d3, d5
000009E0  swap   d5
000009E2  cmp.w  d6, d5
000009E4  ble.b  $9e8
000009E6  move.w d6, d5
000009E8  lsl.w  #$3, d5
000009EA  move.l (a1, d5.w), (a2)+
000009EE  add.w  d0, -$2(a2)
000009F2  move.l $4(a1, d5.w), (a2)+
000009F6  add.w  d1, -$2(a2)
000009FA  move.w $8(a0, d4.w), d5
000009FE  tst.w  d5
00000A00  beq.b  $a42
00000A02  muls.w d3, d5
00000A04  swap   d5
00000A06  cmp.w  d6, d5
00000A08  ble.b  $a0c
00000A0A  move.w d6, d5
00000A0C  lsl.w  #$3, d5
00000A0E  move.l (a1, d5.w), (a2)+
00000A12  add.w  d0, -$2(a2)
00000A16  move.l $4(a1, d5.w), (a2)+
00000A1A  add.w  d1, -$2(a2)
00000A1E  move.w $a(a0, d4.w), d5
00000A22  tst.w  d5
00000A24  beq.b  $a42
00000A26  muls.w d3, d5
00000A28  swap   d5
00000A2A  cmp.w  d6, d5
00000A2C  ble.b  $a30
00000A2E  move.w d6, d5
00000A30  lsl.w  #$3, d5
00000A32  move.l (a1, d5.w), (a2)+
00000A36  add.w  d0, -$2(a2)
00000A3A  move.l $4(a1, d5.w), (a2)+
00000A3E  add.w  d1, -$2(a2)
00000A42  neg.w  d4
00000A44  subi.w #$c, d4
00000A48  move.w (a0, d4.w), d5
00000A4C  tst.w  d5
00000A4E  beq.w  $b26
00000A52  muls.w d3, d5
00000A54  swap   d5
00000A56  cmp.w  d6, d5
00000A58  ble.b  $a5c
00000A5A  move.w d6, d5
00000A5C  lsl.w  #$3, d5
00000A5E  move.l (a1, d5.w), (a2)+
00000A62  add.w  d1, -$2(a2)
00000A66  move.l $4(a1, d5.w), (a2)+
00000A6A  add.w  d0, -$2(a2)
00000A6E  move.w $2(a0, d4.w), d5
00000A72  tst.w  d5
00000A74  beq.w  $b26
00000A78  muls.w d3, d5
00000A7A  swap   d5
00000A7C  cmp.w  d6, d5
00000A7E  ble.b  $a82
00000A80  move.w d6, d5
00000A82  lsl.w  #$3, d5
00000A84  move.l (a1, d5.w), (a2)+
00000A88  add.w  d1, -$2(a2)
00000A8C  move.l $4(a1, d5.w), (a2)+
00000A90  add.w  d0, -$2(a2)
00000A94  move.w $4(a0, d4.w), d5
00000A98  tst.w  d5
00000A9A  beq.w  $b26
00000A9E  muls.w d3, d5
00000AA0  swap   d5
00000AA2  cmp.w  d6, d5
00000AA4  ble.b  $aa8
00000AA6  move.w d6, d5
00000AA8  lsl.w  #$3, d5
00000AAA  move.l (a1, d5.w), (a2)+
00000AAE  add.w  d1, -$2(a2)
00000AB2  move.l $4(a1, d5.w), (a2)+
00000AB6  add.w  d0, -$2(a2)
00000ABA  move.w $6(a0, d4.w), d5
00000ABE  tst.w  d5
00000AC0  beq.b  $b26
00000AC2  muls.w d3, d5
00000AC4  swap   d5
00000AC6  cmp.w  d6, d5
00000AC8  ble.b  $acc
00000ACA  move.w d6, d5
00000ACC  lsl.w  #$3, d5
00000ACE  move.l (a1, d5.w), (a2)+
00000AD2  add.w  d1, -$2(a2)
00000AD6  move.l $4(a1, d5.w), (a2)+
00000ADA  add.w  d0, -$2(a2)
00000ADE  move.w $8(a0, d4.w), d5
00000AE2  tst.w  d5
00000AE4  beq.b  $b26
00000AE6  muls.w d3, d5
00000AE8  swap   d5
00000AEA  cmp.w  d6, d5
00000AEC  ble.b  $af0
00000AEE  move.w d6, d5
00000AF0  lsl.w  #$3, d5
00000AF2  move.l (a1, d5.w), (a2)+
00000AF6  add.w  d1, -$2(a2)
00000AFA  move.l $4(a1, d5.w), (a2)+
00000AFE  add.w  d0, -$2(a2)
00000B02  move.w $a(a0, d4.w), d5
00000B06  tst.w  d5
00000B08  beq.b  $b26
00000B0A  muls.w d3, d5
00000B0C  swap   d5
00000B0E  cmp.w  d6, d5
00000B10  ble.b  $b14
00000B12  move.w d6, d5
00000B14  lsl.w  #$3, d5
00000B16  move.l (a1, d5.w), (a2)+
00000B1A  add.w  d1, -$2(a2)
00000B1E  move.l $4(a1, d5.w), (a2)+
00000B22  add.w  d0, -$2(a2)
00000B26  addi.l #$0, d2
00000B2C  addi.w #$20, d0
00000B30  subi.w #$20, d1
00000B34  cmp.l  #$400000, d2
00000B3A  dbge   d7, $956
00000B3E  move.w $b58.l, (a2)+
00000B44  movea.l $e0c.l, a0
00000B4A  move.w #$1, d7
00000B4E  moveq  #$2, d6
00000B50  moveq  #$4, d5
00000B52  moveq  #$8, d4
00000B54  moveq  #$10, d3
00000B56  moveq  #$20, d2
00000B58  moveq  #$40, d1
00000B5A  move.w #$80, d0
00000B5E  movea.l $ce4.l, a1
00000B64  jmp    (a1)
00000B66  rts    
00000B68  rts    
00000B6A  ori.b  #$0, d0
00000B6E  ori.b  #$0, d0
00000B72  movem.l a4-a6, -(a7)
00000B76  move.l #$3c000, d0
00000B7C  move.l #$1, d1
00000B82  jsr    -$2a(a6)
00000B86  move.l d0, $ce8.l
00000B8C  move.l $ce8.l, $eb6.l
00000B96  movem.l (a7)+, a4-a6
00000B9A  rts    
00000B9C  lea.l  $28.l, a0
00000BA2  move.l #$12c, d0
00000BA8  moveq  #$0, d1
00000BAA  moveq  #$8, d2
00000BAC  move.w #$120, d3
00000BB0  jsr    -$72(a6)
00000BB4  jsr    -$11a(a6)
00000BB8  move.w $1c(a0), d0
00000BBC  or.w   d0, $16.l
00000BC2  movem.l a4-a6, -(a7)
00000BC6  move.l #$3e80, d0
00000BCC  move.l #$0, d1
00000BD2  jsr    -$2a(a6)
00000BD6  move.l d0, $ce4.l
00000BDC  move.l #$800, d0
00000BE2  move.l #$0, d1
00000BE8  jsr    -$2a(a6)
00000BEC  move.l d0, $ce0.l
00000BF2  move.l #$c04, d0
00000BF8  move.l #$1, d1
00000BFE  jsr    -$2a(a6)
00000C02  move.l d0, $cec.l
00000C08  move.l #$6000, d0
00000C0E  move.l #$41, d1
00000C14  jsr    -$2a(a6)
00000C18  lea.l  $e16.l, a0
00000C1E  lea.l  $e2e.l, a1
00000C24  moveq  #$5, d7
00000C26  move.l d0, (a0)+
00000C28  move.l d0, (a1)+
00000C2A  addi.l #$1000, d0
00000C30  dbra   d7, $c26
00000C34  lea.l  $e16.l, a0
00000C3A  lea.l  $e46.l, a1
00000C40  move.l (a0), (a1)+
00000C42  move.l $8(a0), (a1)+
00000C46  move.l $10(a0), (a1)+
00000C4A  move.l $4(a0), (a1)+
00000C4E  move.l $c(a0), (a1)+
00000C52  move.l $14(a0), (a1)+
00000C56  lea.l  $1456.l, a0
00000C5C  lea.l  $9a.l, a1
00000C62  moveq  #$f, d7
00000C64  move.w (a0)+, (a1)
00000C66  addq.w #$4, a1
00000C68  dbra   d7, $c64
00000C6C  lea.l  $122.l, a0
00000C72  move.l $cec.l, d0
00000C78  move.w d0, $4(a0)
00000C7C  swap   d0
00000C7E  move.w d0, (a0)
00000C80  move.l #$1416, $fce.l
00000C8A  move.l #$98, $fca.l
00000C94  clr.w  $fd6.l
00000C9A  move.w #$1, $fd4.l
00000CA2  move.b #$0, $fd2.l
00000CAA  move.w #$1, $fd8.l
00000CB2  clr.w  $2f4.l
00000CB8  clr.w  $b5e.l
00000CBE  clr.w  $b60.l
00000CC4  clr.w  $eba.l
00000CCA  clr.w  $26c.l
00000CD0  clr.w  $26e.l
00000CD6  clr.w  $824.l
00000CDC  clr.l  $382.l
00000CE2  bsr.w  $d00
00000CE6  bsr.w  $dba
00000CEA  movem.l (a7)+, a4-a6
00000CEE  rts    
00000CF0  ori.b  #$0, d0
00000CF4  ori.b  #$0, d0
00000CF8  ori.b  #$0, d0
00000CFC  ori.b  #$0, d0
00000D00  movea.l $ce0.l, a0
00000D06  moveq  #$0, d0
00000D08  moveq  #$1f, d7
00000D0A  lea.l  $d8a.l, a1
00000D10  moveq  #$7, d6
00000D12  move.l (a1)+, (a0)
00000D14  move.w d0, $2(a0)
00000D18  lea.l  $8(a0), a0
00000D1C  dbra   d6, $d12
00000D20  addq.w #$1, d0
00000D22  dbra   d7, $d0a
00000D26  movea.l $ce0.l, a0
00000D2C  lea.l  $4(a0), a0
00000D30  movea.l $ce0.l, a1
00000D36  lea.l  $7f8(a1), a1
00000D3A  move.w #$ff, d7
00000D3E  move.l (a1), (a0)
00000D40  lea.l  $8(a0), a0
00000D44  lea.l  -$8(a1), a1
00000D48  dbra   d7, $d3e
00000D4C  movea.l $cec.l, a0
00000D52  move.w #$28df, d0
00000D56  move.w #$7f, d7
00000D5A  move.w d0, (a0)+
00000D5C  addi.w #$100, d0
00000D60  move.w #$fffe, (a0)+
00000D64  move.w #$108, (a0)+
00000D68  move.w #$ffe0, (a0)+
00000D6C  move.w #$10a, (a0)+
00000D70  move.w #$ffe0, (a0)+
00000D74  move.w d0, (a0)+
00000D76  addi.w #$100, d0
00000D7A  move.w #$fffe, (a0)+
00000D7E  move.w #$108, (a0)+
00000D82  move.w #$0, (a0)+
00000D86  move.w #$10a, (a0)+
00000D8A  move.w #$0, (a0)+
00000D8E  dbra   d7, $d5a
00000D92  move.l #$fffffffe, (a0)+
00000D98  rts    
00000D9A  eor.b  d0, $0(a0)
00000D9E  eor.b  d1, $0(a0)
00000DA2  eor.b  d2, $0(a0)
00000DA6  eor.b  d3, $0(a0)
00000DAA  eor.b  d4, $0(a0)
00000DAE  eor.b  d5, $0(a0)
00000DB2  eor.b  d6, $0(a0)
00000DB6  eor.b  d7, $0(a0)
00000DBA  addq.w #$4, $e14.l
00000DC0  cmpi.w #$18, $e14.l
00000DC8  bne.b  $dd0
00000DCA  clr.w  $e14.l
00000DD0  lea.l  $e16.l, a0
00000DD6  adda.w $e14.l, a0
00000DDC  movem.l (a0)+, d0-d3
00000DE0  move.l (a0)+, $e0c.l
00000DE6  move.l (a0), $e10.l
00000DEC  lea.l  $68.l, a0
00000DF2  move.w d0, $6(a0)
00000DF6  swap   d0
00000DF8  move.w d0, $2(a0)
00000DFC  move.w d1, $e(a0)
00000E00  swap   d1
00000E02  move.w d1, $a(a0)
00000E06  move.w d2, $16(a0)
00000E0A  swap   d2
00000E0C  move.w d2, $12(a0)
00000E10  move.w d3, $1e(a0)
00000E14  swap   d3
00000E16  move.w d3, $1a(a0)
00000E1A  rts    
00000E1C  ori.b  #$0, d0
00000E20  ori.b  #$0, d0
00000E24  ori.b  #$0, d0
00000E28  ori.b  #$0, d0
00000E2C  ori.b  #$0, d0
00000E30  ori.b  #$0, d0
00000E34  ori.b  #$0, d0
00000E38  ori.b  #$0, d0
00000E3C  ori.b  #$0, d0
00000E40  ori.b  #$0, d0
00000E44  ori.b  #$0, d0
00000E48  ori.b  #$0, d0
00000E4C  ori.b  #$0, d0
00000E50  ori.b  #$0, d0
00000E54  ori.b  #$0, d0
00000E58  ori.b  #$0, d0
00000E5C  ori.b  #$0, d0
00000E60  ori.b  #$0, d0
00000E64  ori.b  #$0, d0
00000E68  ori.b  #$0, d0
00000E6C  ori.b  #$79, d0
00000E70  ; data: 0x00, 0xe0
00000E72  ori.b  #$5e, d0
00000E76  blt.b  $ec4
00000E78  cmpi.w #$3c, $eba.l
00000E80  beq.b  $ec4
00000E82  movea.l $eb6.l, a0
00000E88  addi.l #$1000, $eb6.l
00000E92  addq.w #$1, $eba.l
00000E98  btst.b #$6, (a4)
00000E9C  bne.b  $e98
00000E9E  move.l #$ffffffff, $42(a4)
00000EA6  move.l #$9f00000, $3e(a4)
00000EAE  clr.l  $62(a4)
00000EB2  move.l $e0c.l, $4e(a4)
00000EBA  move.l a0, $52(a4)
00000EBE  move.w #$2010, $56(a4)
00000EC4  rts    
00000EC6  ori.b  #$0, d0
00000ECA  ori.b  #$79, d0
00000ECE  ori.b  #$c, d0
00000ED2  adda.l #$ffe, a0
00000ED8  btst.b #$6, (a4)
00000EDC  bne.b  $ed8
00000EDE  move.l #$9f0000a, $3e(a4)
00000EE6  move.l #$ffffffff, $42(a4)
00000EEE  move.l a0, $4e(a4)
00000EF2  move.l a0, $52(a4)
00000EF6  move.w #$0, $62(a4)
00000EFC  move.w #$0, $64(a4)
00000F02  move.w #$2010, $56(a4)
00000F08  rts    
00000F0A  btst.b #$6, (a4)
00000F0E  bne.b  $f0a
00000F10  move.l #$ffffffff, $42(a4)
00000F18  move.l #$1000000, $3e(a4)
00000F20  clr.w  $64(a4)
00000F24  move.l $e10.l, $52(a4)
00000F2C  move.w #$2010, $56(a4)
00000F32  rts    
00000F34  tst.w  $fd6.l
00000F3A  beq.b  $f46
00000F3C  subq.w #$1, $fd6.l
00000F42  bra.w  $fd8
00000F46  move.w $fe4(pc), $fd6.l
00000F4E  tst.b  $fd2.l
00000F54  bne.b  $f5a
00000F56  bra.w  $fd8
00000F5A  subq.b #$1, $fd2.l
00000F60  movea.l $fde(pc), a1
00000F64  movea.l $fda(pc), a0
00000F68  lea.l  $2(a0), a0
00000F6C  move.w $fd8.l, d4
00000F72  subq.w #$1, d4
00000F74  move.w (a0), d0
00000F76  move.w (a1)+, d2
00000F78  move.w d0, d1
00000F7A  move.w d2, d3
00000F7C  andi.w #$f, d1
00000F80  andi.w #$f, d3
00000F84  cmp.w  d1, d3
00000F86  beq.b  $f90
00000F88  blt.b  $f8e
00000F8A  addq.w #$1, (a0)
00000F8C  bra.b  $f90
00000F8E  subq.w #$1, (a0)
00000F90  move.w d0, d1
00000F92  move.w d2, d3
00000F94  lsr.w  #$4, d1
00000F96  lsr.w  #$4, d3
00000F98  andi.w #$f, d1
00000F9C  andi.w #$f, d3
00000FA0  cmp.w  d1, d3
00000FA2  beq.b  $fb0
00000FA4  blt.b  $fac
00000FA6  addi.w #$10, (a0)
00000FAA  bra.b  $fb0
00000FAC  subi.w #$10, (a0)
00000FB0  move.w d0, d1
00000FB2  move.w d2, d3
00000FB4  lsr.w  #$8, d1
00000FB6  lsr.w  #$8, d3
00000FB8  andi.w #$f, d1
00000FBC  andi.w #$f, d3
00000FC0  cmp.w  d1, d3
00000FC2  beq.b  $fd0
00000FC4  blt.b  $fcc
00000FC6  addi.w #$100, (a0)
00000FCA  bra.b  $fd0
00000FCC  subi.w #$100, (a0)
00000FD0  lea.l  $4(a0), a0
00000FD4  dbra   d4, $f74
00000FD8  rts    
00000FDA  ori.b  #$0, d0
00000FDE  ori.b  #$0, d0
00000FE2  ori.b  #$0, d0
00000FE6  ori.b  #$0, d0
00000FEA  ori.b  #$0, d0
00000FEE  ori.b  #$0, d0
00000FF2  ori.b  #$0, d0
00000FF6  ori.b  #$0, d0
00000FFA  ori.b  #$0, d0
00000FFE  ori.b  #$0, d0
00001002  ori.b  #$0, d0
00001006  ori.b  #$0, d0
0000100A  ori.b  #$0, d0
0000100E  ori.b  #$0, d0
00001012  ori.b  #$0, d0
00001016  ori.b  #$0, d0
0000101A  ori.b  #$0, d0
0000101E  ori.b  #$0, d0
00001022  ori.b  #$0, d0
00001026  ori.b  #$0, d0
0000102A  ori.b  #$0, d0
0000102E  ori.b  #$0, d0
00001032  ori.b  #$0, d0
00001036  ori.b  #$0, d0
0000103A  ori.b  #$0, d0
0000103E  ori.b  #$0, d0
00001042  ori.b  #$0, d0
00001046  ori.b  #$0, d0
0000104A  ori.b  #$0, d0
0000104E  ori.b  #$0, d0
00001052  ori.b  #$0, d0
00001056  ori.b  #$0, d0
0000105A  ori.b  #$0, d0
0000105E  ori.b  #$0, d0
00001062  ori.b  #$0, d0
00001066  ori.b  #$0, d0
0000106A  ori.b  #$0, d0
0000106E  ori.b  #$0, d0
00001072  ori.b  #$0, d0
00001076  ori.b  #$0, d0
0000107A  ori.b  #$0, d0
0000107E  ori.b  #$0, d0
00001082  ori.b  #$0, d0
00001086  ori.b  #$0, d0
0000108A  ori.b  #$0, d0
0000108E  ori.b  #$0, d0
00001092  ori.b  #$0, d0
00001096  ori.b  #$0, d0
0000109A  ori.b  #$24, d0
0000109E  ; data: 0xf1, 0x08
000010A0  asr.b  #$8, d2
000010A2  and.b  d5, (a6)+
000010A4  cmpa.w -(a6), a2
000010A6  ; data: 0xa0, 0x02
000010A8  divu.w #$83de, d7
000010AC  or.b   d1, d0
000010AE  or.b   d1, d0
000010B0  or.b   d1, d0
000010B2  or.b   d1, d0
000010B4  or.b   d1, d0
000010B6  or.b   d1, d0
000010B8  or.b   d1, d0
000010BA  or.b   d1, d0
000010BC  or.b   d1, d0
000010BE  or.b   d1, d0
000010C0  or.b   d1, d0
000010C2  or.b   d1, d0
000010C4  or.b   d1, d0
000010C6  or.b   d1, d0
000010C8  or.b   d1, d0
000010CA  or.b   d1, d0
000010CC  or.b   d1, d0
000010CE  or.b   d1, d0
000010D0  or.b   d1, d0
000010D2  divs.w ([$91249df0], a0.w * 8, $adb6bffc), d0
000010DE  add.b  (invalid.w), d2
000010E2  ori.b  #$3a, d0
000010E6  ; data: 0x2b, 0xc7
000010E8  ; data: 0x3f, 0xff
000010EA  addq.w #$1, d6
000010EC  bhi.b  $10fa
000010EE  bgt.b  $10c9
000010F0  moveq  #$47, d4
000010F2  moveq  #$d, d7
000010F4  ; data: 0x7f, 0xff
000010F6  ; data: 0x7f, 0xff
000010F8  ; data: 0x7f, 0xff
000010FA  ; data: 0x7f, 0xff
000010FC  ; data: 0x7f, 0xff
000010FE  ; data: 0x7f, 0xff
00001100  ; data: 0x7f, 0xff
00001102  ; data: 0x7f, 0xff
00001104  ; data: 0x7f, 0xff
00001106  ; data: 0x7f, 0xff
00001108  moveq  #$24, d6
0000110A  ; data: 0x71, 0x06
0000110C  bra.w  $5c2c
00001110  move.w -(a4), (a2)+
00001112  move.l d2, d0
00001114  ; data: 0x0e, 0xfa
00001116  bset.b d1, (a4)+
00001118  ori.b  #$0, d0
0000111C  ori.b  #$0, d0
00001120  ori.b  #$0, d0
00001124  ori.b  #$0, d0
00001128  ori.b  #$0, d0
0000112C  bset.b d1, (a4)+
0000112E  ; data: 0x0e, 0xf8
00001130  ; data: 0x1f, 0xfe
00001132  move.w -(a0), (a2)+
00001134  dc.w   $4b1a
00001136  dc.w   $5ffc
00001138  ; data: 0x71, 0x04
0000113A  moveq  #$22, d6
0000113C  ; data: 0x7f, 0xff
0000113E  moveq  #$d, d7
00001140  moveq  #$48, d4
00001142  bgt.b  $111e
00001144  bhi.b  $1154
00001146  addq.w #$1, a0
00001148  negx.b d2
0000114A  ; data: 0x2b, 0xca
0000114C  ; data: 0x16, 0x3d
0000114E  ori.b  #$c9, d3
00001152  add.b  #$4, d2
00001156  ; data: 0xad, 0xbd
00001158  suba.l ([$87bb, a6, a1.w]), a6
0000115E  divs.w $1(a4, a0.w), d0
00001162  or.b   d1, d0
00001164  or.b   d1, d0
00001166  or.b   d1, d0
00001168  or.b   d1, d0
0000116A  or.b   d1, d0
0000116C  or.b   d1, d0
0000116E  or.b   d1, d0
00001170  or.b   d1, d0
00001172  or.b   d0, d0
00001174  divs.w (a4)+, d1
00001176  divu.w $9ffe.w, d7
0000117A  cmpa.w -(a0), a2
0000117C  and.b  d5, (a2)+
0000117E  ; data: 0xdf, 0xfe
00001180  ; data: 0xf1, 0x04
00001182  dc.w   $fc22
00001184  ori.b  #$0, d0
00001188  ori.b  #$0, d0
0000118C  ori.b  #$0, d0
00001190  ori.b  #$0, d0
00001194  ori.b  #$0, d0
00001198  bset.b d1, (a4)+
0000119A  ; data: 0x0e, 0xf8
0000119C  ; data: 0x1f, 0xfe
0000119E  move.w -(a0), (a2)+
000011A0  dc.w   $4b1a
000011A2  dc.w   $5ffc
000011A4  ; data: 0x71, 0x04
000011A6  moveq  #$22, d6
000011A8  ; data: 0x7f, 0xff
000011AA  moveq  #$d, d7
000011AC  moveq  #$48, d4
000011AE  bgt.b  $118a
000011B0  bhi.b  $11c0
000011B2  addq.w #$1, a0
000011B4  negx.b d2
000011B6  ; data: 0x2b, 0xca
000011B8  ; data: 0x16, 0x3d
000011BA  ori.b  #$c9, d3
000011BE  add.b  #$4, d2
000011C2  ; data: 0xad, 0xbd
000011C4  suba.l ([$87bb, a6, a1.w]), a6
000011CA  divs.w (a4, a0.w), d0
000011CE  divs.w (a4)+, d1
000011D0  divu.w $9ffe.w, d7
000011D4  cmpa.w -(a0), a2
000011D6  and.b  d5, (a2)+
000011D8  ; data: 0xdf, 0xfe
000011DA  ; data: 0xf1, 0x04
000011DC  dc.w   $fc22
000011DE  ori.b  #$0, d0
000011E2  ori.b  #$0, d0
000011E6  ori.b  #$0, d0
000011EA  ori.b  #$0, d0
000011EE  ori.b  #$0, d0
000011F2  ori.b  #$0, d0
000011F6  ori.b  #$0, d0
000011FA  ori.b  #$0, d0
000011FE  ori.b  #$0, d0
00001202  ori.b  #$0, d0
00001206  ; data: 0xff, 0xff
00001208  ; data: 0xff, 0xff
0000120A  ori.b  #$0, d0
0000120E  ori.b  #$0, d0
00001212  ori.b  #$0, d0
00001216  ori.b  #$0, d0
0000121A  ori.b  #$0, d0
0000121E  ori.b  #$0, d0
00001222  ori.b  #$0, d0
00001226  ori.b  #$0, d0
0000122A  ori.b  #$0, d0
0000122E  ori.b  #$0, d0
00001232  ori.b  #$0, d0
00001236  ori.b  #$0, d0
0000123A  ori.b  #$0, d0
0000123E  ori.b  #$0, d0
00001242  ori.b  #$0, d0
00001246  ori.b  #$0, d0
0000124A  ori.b  #$0, d0
0000124E  ori.b  #$0, d0
00001252  ori.b  #$0, d0
00001256  ori.b  #$0, d0
0000125A  ori.b  #$0, d0
0000125E  ori.b  #$0, d0
00001262  ori.b  #$0, d0
00001266  ori.b  #$0, d0
0000126A  ori.b  #$0, d0
0000126E  ori.b  #$0, d0
00001272  ori.b  #$0, d0
00001276  ori.b  #$0, d0
0000127A  ori.b  #$0, d0
0000127E  ori.b  #$0, d0
00001282  ori.b  #$0, d0
00001286  ori.b  #$0, d0
0000128A  ori.b  #$0, d0
0000128E  ori.b  #$0, d0
00001292  ori.b  #$0, d0
00001296  ori.b  #$0, d0
0000129A  ori.b  #$0, d0
0000129E  ori.b  #$0, d0
000012A2  ori.b  #$0, d0
000012A6  ori.b  #$0, d0
000012AA  bset.b d1, (a4)+
000012AC  ; data: 0x0e, 0xf8
000012AE  ; data: 0x1f, 0xfe
000012B0  move.w -(a0), (a2)+
000012B2  dc.w   $4b1a
000012B4  dc.w   $5ffc
000012B6  ; data: 0x71, 0x04
000012B8  moveq  #$22, d6
000012BA  ; data: 0x7f, 0xff
000012BC  ; data: 0x7f, 0xff
000012BE  ; data: 0x7f, 0xff
000012C0  ; data: 0x7f, 0xff
000012C2  ; data: 0x7f, 0xff
000012C4  ; data: 0x7f, 0xff
000012C6  ; data: 0x7f, 0xff
000012C8  ; data: 0x7f, 0xff
000012CA  ; data: 0x7f, 0xff
000012CC  ; data: 0x7f, 0xff
000012CE  ; data: 0x7f, 0xff
000012D0  ; data: 0x7f, 0xff
000012D2  ; data: 0x7f, 0xff
000012D4  ; data: 0x7f, 0xff
000012D6  ; data: 0x7f, 0xff
000012D8  ; data: 0x7f, 0xff
000012DA  ; data: 0x7f, 0xff
000012DC  ; data: 0x7f, 0xff
000012DE  ; data: 0x7f, 0xff
000012E0  moveq  #$d, d7
000012E2  moveq  #$48, d4
000012E4  bgt.b  $12c0
000012E6  bhi.b  $12f6
000012E8  addq.w #$1, a0
000012EA  negx.b d2
000012EC  ; data: 0x2b, 0xca
000012EE  ; data: 0x16, 0x3d
000012F0  ori.b  #$c9, d3
000012F4  add.b  #$4, d2
000012F8  ; data: 0xad, 0xbd
000012FA  suba.l ([$87bb, a6, a1.w]), a6
00001300  divs.w $1(a4, a0.w), d0
00001304  or.b   d1, d0
00001306  or.b   d1, d0
00001308  or.b   d1, d0
0000130A  or.b   d1, d0
0000130C  or.b   d1, d0
0000130E  or.b   d1, d0
00001310  or.b   d1, d0
00001312  or.b   d1, d0
00001314  or.b   d1, d0
00001316  divs.w ([$91249df0], a0.w * 8, $adb6bffc), d0
00001322  add.b  (invalid.w), d2
00001326  ori.b  #$3a, d0
0000132A  ; data: 0x2b, 0xc7
0000132C  ; data: 0x3f, 0xff
0000132E  addq.w #$1, d6
00001330  bhi.b  $133e
00001332  bgt.b  $130d
00001334  moveq  #$47, d4
00001336  moveq  #$d, d7
00001338  ; data: 0x7f, 0xff
0000133A  moveq  #$24, d6
0000133C  ; data: 0x71, 0x06
0000133E  bra.w  $5e5e
00001342  move.w -(a4), (a2)+
00001344  move.l d2, d0
00001346  ; data: 0x0e, 0xfa
00001348  bset.b d1, (a4)+
0000134A  ori.b  #$0, d0
0000134E  ori.b  #$0, d0
00001352  ori.b  #$0, d0
00001356  ori.b  #$0, d0
0000135A  ori.b  #$0, d0
0000135E  ori.b  #$0, d0
00001362  ori.b  #$0, d0
00001366  ori.b  #$0, d0
0000136A  ori.b  #$0, d0
0000136E  ori.b  #$dc, d0
00001372  ; data: 0x0e, 0xf8
00001374  ; data: 0x1f, 0xfe
00001376  move.w -(a0), (a2)+
00001378  dc.w   $4b1a
0000137A  dc.w   $5ffc
0000137C  ; data: 0x71, 0x04
0000137E  moveq  #$22, d6
00001380  ; data: 0x7f, 0xff
00001382  ; data: 0x7f, 0xff
00001384  ; data: 0x7f, 0xff
00001386  ; data: 0x7f, 0xff
00001388  ; data: 0x7f, 0xff
0000138A  ; data: 0x7f, 0xff
0000138C  ; data: 0x7f, 0xff
0000138E  ; data: 0x7f, 0xff
00001390  ; data: 0x7f, 0xff
00001392  ; data: 0x7f, 0xff
00001394  moveq  #$24, d6
00001396  ; data: 0x71, 0x06
00001398  bra.w  $5eb8
0000139C  move.w -(a4), (a2)+
0000139E  move.l d2, d0
000013A0  ; data: 0x0e, 0xfa
000013A2  bset.b d1, (a4)+
000013A4  ori.b  #$0, d0
000013A8  ori.b  #$0, d0
000013AC  ori.b  #$0, d0
000013B0  ori.b  #$0, d0
000013B4  ori.b  #$0, d0
000013B8  dc.w   $fc24
000013BA  ; data: 0xf1, 0x08
000013BC  asr.b  #$8, d2
000013BE  and.b  d5, (a6)+
000013C0  cmpa.w -(a6), a2
000013C2  ; data: 0xa0, 0x02
000013C4  divu.w #$83de, d7
000013C8  or.b   d1, d0
000013CA  or.b   d1, d0
000013CC  or.b   d1, d0
000013CE  or.b   d1, d0
000013D0  or.b   d1, d0
000013D2  or.b   d1, d0
000013D4  or.b   d1, d0
000013D6  or.b   d1, d0
000013D8  or.b   d1, d0
000013DA  or.b   d0, d0
000013DC  divs.w (a4)+, d1
000013DE  divu.w $9ffe.w, d7
000013E2  cmpa.w -(a0), a2
000013E4  and.b  d5, (a2)+
000013E6  ; data: 0xdf, 0xfe
000013E8  ; data: 0xf1, 0x04
000013EA  dc.w   $fc22
000013EC  ori.b  #$0, d0
000013F0  ori.b  #$0, d0
000013F4  ori.b  #$0, d0
000013F8  ori.b  #$0, d0
000013FC  ori.b  #$0, d0
00001400  ori.b  #$0, d0
00001404  ori.b  #$0, d0
00001408  ori.b  #$0, d0
0000140C  ori.b  #$0, d0
00001410  ori.b  #$0, d0
00001414  ori.b  #$0, d0
00001418  ori.b  #$0, d0
0000141C  ori.b  #$0, d0
00001420  ori.b  #$0, d0
00001424  ori.b  #$0, d0
00001428  ori.b  #$0, d0
0000142C  ori.b  #$0, d0
00001430  ori.b  #$0, d0
00001434  ori.b  #$0, d0
00001438  ori.b  #$0, d0
0000143C  ori.b  #$0, d0
00001440  ori.b  #$0, d0
00001444  ori.b  #$0, d0
00001448  ori.b  #$0, d0
0000144C  ori.b  #$0, d0
00001450  ori.b  #$0, d0
00001454  ori.b  #$0, d0
00001458  ori.b  #$0, d0
0000145C  ori.b  #$0, d0
00001460  ori.b  #$0, d0
00001464  ori.b  #$0, d0
00001468  addi.w #$977, d4
0000146C  bchg.b d4, -$56(a7, d0.l)
00001470  cmpi.l #$caa0caa, $fdd(a2)
00001478  bset.b d7, (a5)+
0000147A  bset.b d7, (a5)+
0000147C  bset.b d7, (a5)+
0000147E  bset.b d7, (a5)+
00001480  bset.b d7, (a5)+
00001482  bset.b d7, (a5)+
00001484  bset.b d7, (a5)+
00001486  andi.b #$44, d0
0000148A  bchg.b d3, (a5)
0000148C  bchg.b d3, (a5)
0000148E  ; data: 0x08, 0x66
00001490  ; data: 0x08, 0x66
00001492  ; data: 0x08, 0x66
00001494  ; data: 0x08, 0x66
00001496  andi.b #$77, d0
0000149A  ; data: 0x0a, 0x88
0000149C  ; data: 0x0a, 0x88
0000149E  bclr.b d5, (a1)+
000014A0  bclr.b d5, (a1)+
000014A2  bclr.b d5, (a1)+
000014A4  bclr.b d5, (a1)+
000014A6  btst.l d1, -(a2)
000014A8  subi.b #$44, $55(a3, d0.w)
000014AE  bchg.b d3, -(a6)
000014B0  ; data: 0x08, 0x77
000014B2  movep.w d4, $a99(a0)
000014B6  bclr.b d5, $cbb(a2)
000014BA  movep.l d6, $edd(a4)
000014BE  ori.b  #$34, -(a3)
000014C2  bchg.b d0, d5
000014C4  bchg.b d0, (a6)
000014C6  bchg.b d0, -(a7)
000014C8  bchg.b d0, $189.w
000014CC  bclr.b d0, (a2)+
000014CE  bclr.b d0, $2bc(a3)
000014D2  movep.l d1, $4de(a5)
000014D6  subi.b #$0, d0
000014DA  addi.b #$0, d0
000014DE  ; data: 0x08, 0x01
000014E0  btst.l d4, d2
000014E2  eori.b #$14, d3
000014E6  cmpi.b #$36, -(a5)
000014EA  ; data: 0x0e, 0x47
000014EC  bchg.b d7, (a0)+
000014EE  btst.l d0, (a3)
000014F0  andi.b #$35, -(a4)
000014F4  subi.w #$557, d6
000014F8  addi.w #$779, $88a(a0)
000014FE  bclr.b d4, (a3)+
00001500  eori.l #$bbd0cce, $2(a4)
00001508  ori.b  #$4, d3
0000150C  ori.b  #$6, d5
00001510  andi.b #$8, d7
00001514  subi.b #$2a, (a1)+
00001518  ; data: 0x06, 0x3b
0000151A  movep.l $9ae(a4), d3
0000151E  ; data: 0x02, 0xe2
00001520  ori.b  #$0, d0
00001524  ori.b  #$0, d0
00001528  ori.b  #$6, d0
0000152C  ori.b  #$0, d0
00001530  ori.b  #$0, d0
00001534  ori.b  #$74, d0
00001538  ori.b  #$0, d0
0000153C  ori.b  #$0, d0
00001540  ori.b  #$9e, d0
00001544  ori.b  #$0, d0
00001548  ori.b  #$0, d0
0000154C  ori.b  #$8a, d0
00001550  ori.b  #$0, d0
00001554  ori.b  #$0, d0
00001558  ori.b  #$3e, d0
0000155C  ori.b  #$0, d0
00001560  ori.b  #$0, d0
00001564  ori.b  #$12, d0
00001568  ori.b  #$0, d0
0000156C  ori.b  #$0, d0
00001570  ori.b  #$b1, d0
00001574  ori.b  #$0, d0
00001578  ori.b  #$0, d0
0000157C  ori.b  #$47, d0
00001580  ori.b  #$0, d0
00001584  ori.b  #$0, d0
00001588  ori.b  #$b1, d0
0000158C  ori.b  #$0, d0
00001590  ori.b  #$0, d0
00001594  ori.b  #$35, d0
00001598  ori.b  #$0, d0
0000159C  ori.b  #$0, d0
000015A0  ori.b  #$92, d0
000015A4  ori.b  #$0, d0
000015A8  ori.b  #$0, d0
000015AC  ori.b  #$bf, d0
000015B0  clr.b  (a3)+
000015B2  btst.l d6, d5
000015B4  ori.b  #$0, d0
000015B8  ori.b  #$6, d0
000015BC  movea.w (a5), a7
000015BE  bchg.b d6, (a4)
000015C0  ori.b  #$0, d0
000015C4  ori.b  #$82, d0
000015C8  move.w (a6), -(a5)
000015CA  bclr.b d6, (a6)+
000015CC  ori.b  #$0, d0
000015D0  ori.b  #$a6, d0
000015D4  move.w a7, (a4)
000015D6  bset.b d6, -(a3)
000015D8  ori.b  #$0, d0
000015DC  ori.b  #$8b, d0
000015E0  ; data: 0x35, 0xf9
000015E2  dc.w   $e36
000015E4  ori.b  #$0, d0
000015E8  ori.b  #$45, d0
000015EC  move.w a3, $e6d040f.l
000015F2  ori.b  #$0, d0
000015F6  movem.l $1383(a6), d0-d1/d3-d4/d7/a0/a4-a5
000015FC  dc.w   $ea0
000015FE  ori.b  #$0, d0
00001602  ; data: 0x4c, 0x5c
00001604  ; data: 0x2f, 0xdb
00001606  move.b -$32(a7, d0.l), -(a5)
0000160A  ori.b  #$0, d0
0000160E  ; data: 0x4b, 0xcb
00001610  move.l $210e(a6), -$8(a6, d0.l)
00001616  ori.b  #$0, d0
0000161A  dc.w   $4b21
0000161C  ; data: 0x2b, 0xf6
0000161E  ; data: 0x25, 0xdd
00001620  btst.l d7, $0(a0)
00001624  ori.b  #$60, d0
00001628  movea.l d3, a5
0000162A  move.l (a6)+, d5
0000162C  movep.l $0(a0), d7
00001630  ori.b  #$8a, d0
00001634  ; data: 0x2d, 0xd7
00001636  move.l $f63(a6), d4
0000163A  ori.b  #$0, d0
0000163E  ; data: 0x48, 0xdb
00001640  move.w -$73(a1, d2.w), -(a0)
00001644  bclr.b d7, d3
00001646  ori.b  #$0, d0
0000164A  ; data: 0x47, 0xe2
0000164C  move.w -$9(a0, d2.w), d2
00001650  bclr.b d7, (a0)+
00001652  ori.b  #$0, d0
00001656  move.w (a7), sr
00001658  move.w (a4)+, -(a3)
0000165A  move.l $faf(a4), $0(a1)
00001660  ori.b  #$5, d0
00001664  move.w (d2.w), ([], d0.l * 8, $44e03c16)
00001672  move.l -(a2), d0
00001674  bset.b d7, (a0)
00001676  ori.b  #$0, d0
0000167A  chk.w  $3e69(a7), d1
0000167E  ; data: 0x1e, 0x6e
00001680  bset.b d7, -(a1)
00001682  ori.b  #$0, d0
00001686  dc.w   $42c3
00001688  ; data: 0x40, 0x8c
0000168A  move.b (a2), (a6)+
0000168C  bset.b d7, (a0, d0.w)
00001690  ori.b  #$9f, d0
00001694  chk.w  d2, d0
00001696  move.b (a0), $1004(a5)
0000169A  ori.b  #$0, d0
0000169E  neg.l  d6
000016A0  ; data: 0x40, 0x3a
000016A2  ; data: 0x19, 0xe7
000016A4  move.b (a3)+, d0
000016A6  ori.b  #$0, d0
000016AA  not.w  d1
000016AC  move.w d1, $185b(a7)
000016B0  ; data: 0x10, 0x3e
000016B2  ori.b  #$0, d0
000016B6  lea.l  $3df3(a7), a3
000016BA  ; data: 0x16, 0xbd
000016BC  ; data: 0x10, 0x6c
000016BE  ori.b  #$0, d0
000016C2  ; data: 0x49, 0x8e
000016C4  move.w -(a5), (a6)
000016C6  move.b $10cf.w, (a2)+
000016CA  ori.b  #$0, d0
000016CE  dc.w   $4b06
000016D0  move.w (a1)+, $0(a5)
000016D4  ori.b  #$0, d0
000016D8  ori.b  #$70, d0
000016DC  move.w (a2), d5
000016DE  ori.b  #$0, d0
000016E2  ori.b  #$0, d0
000016E6  ; data: 0x4d, 0xce
000016E8  move.w d3, (a4)
000016EA  ori.b  #$0, d0
000016EE  ori.b  #$0, d0
000016F2  dc.w   $4f1d
000016F4  move.w a7, $0(a3)
000016F8  ori.b  #$0, d0
000016FC  ori.b  #$4a, d0
00001700  ; data: 0x35, 0xdf
00001702  ori.b  #$0, d0
00001706  ori.b  #$0, d0
0000170A  blt.b  $16cb
0000170C  bcs.b  $1699
0000170E  subq.w #$8, $3486(a3)
00001712  ori.b  #$0, d0
00001716  moveq  #$4c, d3
00001718  ; data: 0x56, 0x08
0000171A  ; data: 0x52, 0x7f
0000171C  move.w a1, $0(a1)
00001720  ori.b  #$d9, d0
00001724  subq.l #$1, d6
00001726  movem.l (a7), d2/d6-d7/a0/a4-a5
0000172A  ori.b  #$0, d0
0000172E  ; data: 0x79, 0xd9
00001730  addq.l #$2, d1
00001732  ; data: 0x45, 0x49
00001734  move.w d7, (a0)
00001736  ori.b  #$0, d0
0000173A  ; data: 0x79, 0xdb
0000173C  subq.w #$2, (a6)+
0000173E  movea.w ([, d2.l * 8]), a7
00001742  ori.b  #$0, d0
00001746  ; data: 0x79, 0x46
00001748  addq.w #$3, d0
0000174A  ; data: 0x37, 0x7e
0000174C  move.l (a4)+, (a7)+
0000174E  ori.b  #$0, d0
00001752  ; data: 0x77, 0xff
00001754  subq.b #$3, d5
00001756  ori.b  #$0, d0
0000175A  ori.b  #$0, d0
0000175E  moveq  #$5c, d3
00001760  seq.b  d0
00001762  ori.b  #$0, d0
00001766  ori.b  #$0, d0
0000176A  moveq  #$98, d2
0000176C  addq.w #$4, $0(a6)
00001770  ori.b  #$0, d0
00001774  ori.b  #$25, d0
00001778  subq.b #$4, (a1)
0000177A  ori.b  #$0, d0
0000177E  ori.b  #$0, d0
00001782  ble.b  $17d2
00001784  subq.l #$4, $0(a1)
00001788  ori.b  #$0, d0
0000178C  ori.b  #$99, d0
00001790  addq.b #$5, $0(a2)
00001794  ori.b  #$0, d0
00001798  ori.b  #$2b, d0
0000179C  addq.l #$5, $0(a2)
000017A0  ori.b  #$0, d0
000017A4  ori.b  #$80, d0
000017A8  subq.b #$5, (a7)+
000017AA  ori.b  #$0, d0
000017AE  ori.b  #$0, d0
000017B2  bsr.b  $1759
000017B4  subq.l #$5, d0
000017B6  ori.b  #$0, d0
000017BA  ori.b  #$0, d0
000017BE  subq.b #$6, (a0)+
000017C0  smi.b  (a5)+
000017C2  ori.b  #$0, d0
000017C6  ori.b  #$0, d0
000017CA  addq.b #$6, $587b(a1)
000017CE  ori.b  #$0, d0
000017D2  ori.b  #$0, d0
000017D6  addq.w #$6, $53e6(a7)
000017DA  ori.b  #$0, d0
000017DE  ori.b  #$0, d0
000017E2  addq.l #$6, -(a5)
000017E4  unlk   a6
000017E6  ori.b  #$0, d0
000017EA  ori.b  #$0, d0
000017EE  sge.b  (a0)
000017F0  ; data: 0x48, 0xbb
000017F2  ori.b  #$0, d0
000017F6  ori.b  #$0, d0
000017FA  sge.b  ([a4])
000017FE  ori.b  #$0, d0
00001802  ori.b  #$0, d0
00001806  ; data: 0x5d, 0x09
00001808  move.w (a1, d0.w), d7
0000180C  ori.b  #$0, d0
00001810  ori.b  #$15, d0
00001814  move.w (a4, d0.w), (a5)
00001818  ori.b  #$0, d0
0000181C  ori.b  #$9a, d0
00001820  subq.b #$6, (a5)
00001822  ori.b  #$0, d0
00001826  ori.b  #$0, d0
0000182A  ; data: 0x3d, 0xea
0000182C  ; data: 0x5d, 0x0b
0000182E  ori.b  #$0, d0
00001832  ori.b  #$0, d0
00001836  dc.w   $42f7
00001838  sge.b  (a6, d0.w)
0000183C  ori.b  #$0, d0
00001840  ori.b  #$3f, d0
00001844  sge.b  (a3)
00001846  ori.b  #$0, d0
0000184A  ori.b  #$0, d0
0000184E  lea.l  (a5), a6
00001850  addq.l #$6, $0(a1)
00001854  ori.b  #$0, d0
00001858  ori.b  #$56, d0
0000185C  addq.w #$6, (a4, d0.w)
00001860  ori.b  #$0, d0
00001864  ori.b  #$e7, d0
00001868  addq.b #$6, $0(a7)
0000186C  ori.b  #$0, d0
00001870  ori.b  #$e4, d0
00001874  addq.l #$6, d5
00001876  ori.b  #$0, d0
0000187A  ori.b  #$0, d0
0000187E  subq.l #$5, a0
00001880  bsr.b  $1897
00001882  ori.b  #$0, d0
00001886  ori.b  #$0, d0
0000188A  subq.b #$5, -(a7)
0000188C  bcc.b  $1883
0000188E  ori.b  #$0, d0
00001892  ori.b  #$0, d0
00001896  addq.l #$5, -$57(a4, d6.l)
0000189A  ori.b  #$0, d0
0000189E  ori.b  #$0, d0
000018A2  addq.b #$5, $20(a4, d6.l)
000018A6  ori.b  #$0, d0
000018AA  ori.b  #$0, d0
000018AE  subq.l #$4, -$21(a4, d6.l)
000018B2  ori.b  #$0, d0
000018B6  ori.b  #$0, d0
000018BA  subq.b #$4, (a5)+
000018BC  ; data: 0x71, 0xc3
000018BE  ori.b  #$0, d0
000018C2  ori.b  #$0, d0
000018C6  ; data: 0x58, 0x7b
000018C8  moveq  #$45, d2
000018CA  ori.b  #$0, d0
000018CE  ori.b  #$0, d0
000018D2  dbeq   d6, $8eea
000018D6  ori.b  #$0, d0
000018DA  ori.b  #$0, d0
000018DE  subq.b #$3, (a4)
000018E0  ; data: 0x77, 0xca
000018E2  ori.b  #$0, d0
000018E6  ori.b  #$0, d0
000018EA  move.l (a3)+, (a7)+
000018EC  ; data: 0x37, 0xe0
000018EE  addq.w #$3, a7
000018F0  ; data: 0x79, 0x26
000018F2  ori.b  #$0, d0
000018F6  move.l $3ef5(a1), $556f(a7)
000018FC  ; data: 0x79, 0xce
000018FE  ori.b  #$0, d0
00001902  movea.w -(a0), a0
00001904  ; data: 0x45, 0xd8
00001906  addq.l #$2, (a2)
00001908  ; data: 0x79, 0xe4
0000190A  ori.b  #$0, d0
0000190E  move.w (a2), ([$539878fe, a0])
00001916  ori.b  #$0, d0
0000191A  move.w a6, -(a1)
0000191C  addq.l #$1, (a2)
0000191E  addq.l #$3, -(a6)
00001920  moveq  #$91, d3
00001922  ori.b  #$0, d0
00001926  movea.w d4, a2
00001928  ; data: 0x51, 0x7f
0000192A  bne.b  $1945
0000192C  bgt.b  $1963
0000192E  ori.b  #$0, d0
00001932  move.w (a0)+, $5f(a2, d5.w)
00001936  ori.b  #$0, d0
0000193A  ori.b  #$0, d0
0000193E  move.w d4, -(a3)
00001940  dc.w   $4f33
00001942  ori.b  #$0, d0
00001946  ori.b  #$0, d0
0000194A  move.w ([]), d4
00001950  ori.b  #$0, d0
00001954  ori.b  #$c1, d0
00001958  ; data: 0x4c, 0x88
0000195A  ori.b  #$0, d0
0000195E  ori.b  #$0, d0
00001962  move.w d7, -(a5)
00001964  dc.w   $4b1e
00001966  ori.b  #$0, d0
0000196A  ori.b  #$0, d0
0000196E  move.b (a5)+, (a0)+
00001970  move.b -(a6), -(a2)
00001972  movea.w (a2), a6
00001974  chk.w  -(a7), d4
00001976  ori.b  #$0, d0
0000197A  ; data: 0x10, 0x75
0000197C  move.b ([], d3.l * 4, $48090000), (a3)+
00001984  ori.b  #$45, d0
00001988  move.b (a2)+, (a4)
0000198A  move.w $465c(a5), (a7)+
0000198E  ori.b  #$0, d0
00001992  move.b -(a0), d0
00001994  move.b $3fe7(a5), d5
00001998  neg.l  -(a2)
0000199A  ori.b  #$0, d0
0000199E  ; data: 0x10, 0x09
000019A0  move.b (a3)+, $42bc0000(a5, d4.w)
000019A8  ori.b  #$f4, d0
000019AC  move.b -(a3), -(a6)
000019AE  negx.l $4274(a2)
000019B2  ori.b  #$0, d0
000019B6  bset.b d7, -(a5)
000019B8  move.b d3, (a7)+
000019BA  move.w d7, (a7)
000019BC  ; data: 0x43, 0x61
000019BE  ori.b  #$0, d0
000019C2  bset.b d7, (a5)
000019C4  movea.l #$3c354495, a0
000019CA  ori.b  #$0, d0
000019CE  bset.b d7, d3
000019D0  move.l $39d2(a5), $45bd.w
000019D6  ori.b  #$0, d0
000019DA  bclr.b d7, ([])
000019DE  ; data: 0x37, 0x3d
000019E0  not.l  (a2)
000019E2  ori.b  #$0, d0
000019E6  bclr.b d7, (a6)+
000019E8  move.l (a3)+, $3453(a2)
000019EC  chk.w  -(a1), d3
000019EE  ori.b  #$0, d0
000019F2  movep.w d7, $26f4(a2)
000019F6  move.w (a4), $489f(a0)
000019FA  ori.b  #$0, d0
000019FE  bchg.b d7, $2897(a4)
00001A02  ; data: 0x2d, 0xfb
00001A04  ; data: 0x49, 0x51
00001A06  ori.b  #$0, d0
00001A0A  bchg.b d7, (a1)
00001A0C  movea.l d3, a5
00001A0E  move.l $4a2d(a7), (a5)
00001A12  ori.b  #$0, d0
00001A16  btst.l d7, $3(a3, d2.w)
00001A1A  movea.l -(a3), a6
00001A1C  tas.b  (a3, d0.w)
00001A20  ori.b  #$4, d0
00001A24  move.l $1d(a5, d2.l), -(a0)
00001A28  chk.w  -(a3), d5
00001A2A  ori.b  #$0, d0
00001A2E  ; data: 0x0e, 0xdd
00001A30  move.b (a7)+, $304b(a5)
00001A34  dc.w   $4c3a
00001A36  ori.b  #$0, d0
00001A3A  ; data: 0x0e, 0xb0
00001A3C  move.b $320b(a4), -$2c(a1, d4.l)
00001A42  ori.b  #$0, d0
00001A46  subi.b #$7f, $343b4d32.l
00001A4E  ori.b  #$0, d0
00001A52  ; data: 0x0e, 0x49
00001A54  movea.w $4d81(a0), a3
00001A58  ori.b  #$0, d0
00001A5C  ori.b  #$f8, d0
00001A60  move.w #$4da6, (a4)+
00001A64  ori.b  #$0, d0
00001A68  ori.b  #$b6, d0
00001A6C  move.w d0, (d4.l * 4)
00001A70  ori.b  #$0, d0
00001A74  ori.b  #$6e, d0
00001A78  move.w $4d1d0000.l, (a7)
00001A7E  ori.b  #$0, d0
00001A82  btst.l d6, -(a0)
00001A84  clr.w  (invalid.w)
00001A8A  ori.b  #$0, d0
00001A8E  cmpi.l #$0, (a0, d0.w)
00001A96  ori.b  #$0, d0
00001A9A  cmpi.w #$0, (a5)
00001A9E  ori.b  #$0, d0
00001AA2  ori.b  #$0, d0
00001AA6  bset.b d5, (a3)
00001AA8  ori.b  #$0, d0
00001AAC  ori.b  #$0, d0
00001AB0  ori.b  #$6b, d0
00001AB4  ori.b  #$0, d0
00001AB8  ori.b  #$0, d0
00001ABC  ori.b  #$d7, d0
00001AC0  ori.b  #$0, d0
00001AC4  ori.b  #$0, d0
00001AC8  ori.b  #$3a, d0
00001ACC  ori.b  #$0, d0
00001AD0  ori.b  #$0, d0
00001AD4  ori.b  #$69, d0
00001AD8  ori.b  #$0, d0
00001ADC  ori.b  #$0, d0
00001AE0  ori.b  #$b8, d0
00001AE4  ori.b  #$0, d0
00001AE8  ori.b  #$0, d0
00001AEC  ori.b  #$ce, d0
00001AF0  ori.b  #$0, d0
00001AF4  ori.b  #$0, d0
00001AF8  ori.b  #$a7, d0
00001AFC  ori.b  #$0, d0
00001B00  ori.b  #$0, d0
00001B04  ori.b  #$3c, d0
00001B08  ori.b  #$0, d0
00001B0C  ori.b  #$0, d0
00001B10  ori.b  #$1a, d0
00001B14  ori.b  #$0, d0
00001B18  ori.b  #$0, d0
00001B1C  ori.b  #$39, d0
00001B20  ; data: 0x04, 0xe0
00001B22  ori.b  #$0, d0
00001B26  ori.b  #$0, d0
00001B2A  dc.w   $c7b
00001B2C  andi.l #$0, (a6)+
00001B32  ori.b  #$0, d0
00001B36  bset.b d6, (a0)
00001B38  ; data: 0x00, 0xdb
00001B3A  ori.b  #$0, d0
00001B3E  ori.b  #$0, d0
00001B42  dc.w   $edf
00001B44  ori.b  #$0, d0
00001B48  ori.b  #$0, d0
00001B4C  ori.b  #$b1, d0
00001B50  ori.b  #$0, d0
00001B54  ori.b  #$0, d0
00001B58  ori.b  #$73, d0
00001B5C  ori.b  #$0, d0
00001B60  ori.b  #$0, d0
00001B64  ori.b  #$3, d0
00001B68  ori.b  #$0, d0
00001B6C  ori.b  #$0, d0
00001B70  ori.b  #$87, d0
00001B74  ori.b  #$0, d0
00001B78  ori.b  #$0, d0
00001B7C  ori.b  #$1, d0
00001B80  ori.b  #$0, d0
00001B84  ori.b  #$0, d0
00001B88  ori.b  #$55, d0
00001B8C  ori.b  #$0, d0
00001B90  ori.b  #$0, d0
00001B94  ori.b  #$bb, d0
00001B98  ori.b  #$0, d0
00001B9C  ori.b  #$0, d0
00001BA0  ori.b  #$15, d0
00001BA4  ori.b  #$0, d0
00001BA8  ori.b  #$0, d0
00001BAC  ori.b  #$52, d0
00001BB0  ori.b  #$0, d0
00001BB4  ori.b  #$0, d0
00001BB8  ori.b  #$88, d0
00001BBC  ori.b  #$0, d0
00001BC0  ori.b  #$0, d0
00001BC4  ori.b  #$a, d0
00001BC8  dc.w   $492b
00001BCA  move.b $0.l, (a1, d0.w)
00001BD2  shi.b  (a1)+
00001BD4  ; data: 0x44, 0x8b
00001BD6  move.b (a0, d0.w), $0.l
00001BDE  subq.w #$1, $412b1413.l
00001BE4  ori.b  #$0, d0
00001BE8  ori.b  #$a0, d0
00001BEC  move.w (a3), d7
00001BEE  move.b $f(a0, d0.w), d2
00001BF2  ori.b  #$0, d0
00001BF6  subq.l #$1, d4
00001BF8  move.w (a2)+, $1448(a5)
00001BFC  move.b d3, (a1, d0.w)
00001C00  ori.b  #$39, d0
00001C04  move.w a4, -(a4)
00001C06  move.b $5b(a7, d1.w), -(a5)
00001C0A  ori.b  #$0, d0
00001C0E  shi.b  d0
00001C10  move.w ([$1c12pc], d2.w, $146c), (a3)
00001C16  ori.b  #$0, d0
00001C1A  addq.b #$1, (a4)+
00001C1C  movea.w $25dd(a2), a2
00001C20  ; data: 0x14, 0x75
00001C22  ori.b  #$0, d0
00001C26  subq.w #$8, $321d2a1e.l
00001C2C  ; data: 0x14, 0x79
00001C2E  ori.b  #$0, d0
00001C32  ; data: 0x50, 0xbd
00001C34  ; data: 0x2f, 0xd6
00001C36  ; data: 0x2d, 0xd7
00001C38  ; data: 0x14, 0x7a
00001C3A  ori.b  #$0, d0
00001C3E  ; data: 0x4f, 0xe7
00001C40  move.w $b(a1, d2.l), -(a0)
00001C44  ; data: 0x14, 0x76
00001C46  ori.b  #$0, d0
00001C4A  jmp    $1c7c(pc, d3.w)
00001C4E  ; data: 0x2b, 0xd9
00001C50  ; data: 0x14, 0x70
00001C52  ori.b  #$0, d0
00001C56  lea.l  $371c.w, a6
00001C5A  move.l -(a2), d5
00001C5C  ; data: 0x14, 0x65
00001C5E  ori.b  #$0, d0
00001C62  ; data: 0x4c, 0xe2
00001C64  move.w $e(a2, d2.l), $5b(a4, d1.w)
00001C6A  ori.b  #$0, d0
00001C6E  chk.w  $3c162673.l, d5
00001C74  ; data: 0x14, 0x4b
00001C76  ori.b  #$0, d0
00001C7A  ; data: 0x4a, 0xcf
00001C7C  movea.w $2485(a1), a7
00001C80  move.b $1c82(pc,d0.w), d2
00001C84  ori.b  #$8b, d0
00001C88  ; data: 0x40, 0x8c
00001C8A  move.l $142b(a6), (a1)
00001C8E  ori.b  #$0, d0
00001C92  ; data: 0x48, 0x3a
00001C94  clr.l  (a7)+
00001C96  move.l $1d(a2, d1.w), (a0)+
00001C9A  ori.b  #$0, d0
00001C9E  move.w (a6)+, sr
00001CA0  neg.l  d6
00001CA2  move.b (a1), $1410(a7)
00001CA6  ori.b  #$0, d0
00001CAA  not.w  d1
00001CAC  ; data: 0x45, 0x7a
00001CAE  move.b d2, $9(a6, d1.w)
00001CB2  ori.b  #$0, d0
00001CB6  lea.l  $446b(a7), a3
00001CBA  ; data: 0x1b, 0xde
00001CBC  ; data: 0x14, 0x0e
00001CBE  ori.b  #$0, d0
00001CC2  ; data: 0x49, 0x8e
00001CC4  ; data: 0x42, 0xfe
00001CC6  ; data: 0x19, 0xf1
00001CC8  move.b (a2, d0.w), d2
00001CCC  ori.b  #$6, d0
00001CD0  ; data: 0x41, 0x8f
00001CD2  ; data: 0x17, 0xc9
00001CD4  move.b (a2)+, (a2)
00001CD6  ori.b  #$0, d0
00001CDA  ; data: 0x4c, 0x70
00001CDC  negx.b -(a0)
00001CDE  ori.b  #$0, d0
00001CE2  ori.b  #$0, d0
00001CE6  ; data: 0x4d, 0xce
00001CE8  movea.w (a3)+, a7
00001CEA  ori.b  #$0, d0
00001CEE  ori.b  #$0, d0
00001CF2  dc.w   $4f1d
00001CF4  move.w (a7, d0.w), (a6)+
00001CF8  ori.b  #$0, d0
00001CFC  ori.b  #$4a, d0
00001D00  move.w (a3)+, (a5, d0.w)
00001D04  ori.b  #$0, d0
00001D08  ori.b  #$6b, d0
00001D0C  ; data: 0x39, 0xf9
00001D0E  ori.b  #$0, d0
00001D12  ori.b  #$0, d0
00001D16  ; data: 0x52, 0x7f
00001D18  movea.w $0(a4), a4
00001D1C  ori.b  #$0, d0
00001D20  ori.b  #$86, d0
00001D24  move.w (a4, d0.w), (a3)
00001D28  ori.b  #$0, d0
00001D2C  ori.b  #$81, d0
00001D30  move.w $0(a1), -(a2)
00001D34  ori.b  #$0, d0
00001D38  ori.b  #$f3, d0
00001D3C  subq.w #$2, $555e(a7)
00001D40  move.w (a2), $0.l
00001D46  ; data: 0x79, 0x83
00001D48  addq.w #$3, d0
00001D4A  ; data: 0x49, 0xe2
00001D4C  movea.w -(a6), a1
00001D4E  ori.b  #$0, d0
00001D52  ; data: 0x7b, 0x73
00001D54  subq.b #$3, d5
00001D56  negx.l $3147(a1)
00001D5A  ori.b  #$0, d0
00001D5E  moveq  #$18, d6
00001D60  seq.b  d0
00001D62  move.w $3140(a3), $0(a3)
00001D68  ori.b  #$df, d0
00001D6C  addq.w #$4, $0(a6)
00001D70  ori.b  #$0, d0
00001D74  ori.b  #$f4, d0
00001D78  subq.b #$4, (a1)
00001D7A  ori.b  #$0, d0
00001D7E  ori.b  #$0, d0
00001D82  ; data: 0x79, 0x9c
00001D84  subq.l #$4, $0(a1)
00001D88  ori.b  #$0, d0
00001D8C  ori.b  #$7d, d0
00001D90  addq.b #$5, $0(a2)
00001D94  ori.b  #$0, d0
00001D98  ori.b  #$26, d0
00001D9C  addq.l #$5, $0(a2)
00001DA0  ori.b  #$0, d0
00001DA4  ori.b  #$66, d0
00001DA8  subq.b #$5, (a7)+
00001DAA  ori.b  #$0, d0
00001DAE  ori.b  #$0, d0
00001DB2  ble.b  $1dfc
00001DB4  subq.l #$5, d0
00001DB6  ori.b  #$0, d0
00001DBA  ori.b  #$0, d0
00001DBE  bmi.b  $1e16
00001DC0  smi.b  (a5)+
00001DC2  ori.b  #$0, d0
00001DC6  ori.b  #$0, d0
00001DCA  beq.b  $1dda
00001DCC  addq.b #$6, $0(a1)
00001DD0  ori.b  #$0, d0
00001DD4  ori.b  #$88, d0
00001DD8  addq.w #$6, $0(a7)
00001DDC  ori.b  #$0, d0
00001DE0  ori.b  #$a5, d0
00001DE4  slt.b  (a3)+
00001DE6  ori.b  #$0, d0
00001DEA  ori.b  #$0, d0
00001DEE  sge.b  (a0)
00001DF0  seq.b  (a2, d0.w)
00001DF4  ori.b  #$0, d0
00001DF8  ori.b  #$f4, d0
00001DFC  addq.b #$1, -(a3)
00001DFE  ori.b  #$0, d0
00001E02  ori.b  #$0, d0
00001E06  ; data: 0x5d, 0x09
00001E08  ; data: 0x4b, 0x0c
00001E0A  ori.b  #$0, d0
00001E0E  ori.b  #$0, d0
00001E12  subq.b #$6, (a5)
00001E14  neg.w  -(a5)
00001E16  ori.b  #$0, d0
00001E1A  ori.b  #$0, d0
00001E1E  ; data: 0x3d, 0xfa
00001E20  subq.b #$6, (a5)
00001E22  ori.b  #$0, d0
00001E26  ori.b  #$0, d0
00001E2A  movea.w (a6)+, a5
00001E2C  ; data: 0x5d, 0x0b
00001E2E  ori.b  #$0, d0
00001E32  ori.b  #$0, d0
00001E36  move.w #$5cf6, (a5)
00001E3A  ori.b  #$0, d0
00001E3E  ori.b  #$0, d0
00001E42  ; data: 0x3d, 0xe1
00001E44  sge.b  (a3)
00001E46  ori.b  #$0, d0
00001E4A  ori.b  #$0, d0
00001E4E  clr.b  -(a4)
00001E50  addq.l #$6, $0(a1)
00001E54  ori.b  #$0, d0
00001E58  ori.b  #$c1, d0
00001E5C  addq.w #$6, (a4, d0.w)
00001E60  ori.b  #$0, d0
00001E64  ori.b  #$13, d0
00001E68  addq.b #$6, $0(a7)
00001E6C  ori.b  #$0, d0
00001E70  ori.b  #$c4, d0
00001E74  smi.b  -(a4)
00001E76  ori.b  #$0, d0
00001E7A  ori.b  #$0, d0
00001E7E  addq.b #$2, -(a3)
00001E80  subq.l #$5, a0
00001E82  ori.b  #$0, d0
00001E86  ori.b  #$0, d0
00001E8A  ; data: 0x58, 0x0c
00001E8C  subq.b #$5, -(a7)
00001E8E  ori.b  #$0, d0
00001E92  ori.b  #$0, d0
00001E96  addq.l #$5, ([])
00001E9E  ori.b  #$0, d0
00001EA2  addq.b #$5, (a4, invalid.w)
00001EA6  ori.b  #$0, d0
00001EAA  ori.b  #$0, d0
00001EAE  subq.l #$4, (a4, d6.w * 2)
00001EB2  ori.b  #$0, d0
00001EB6  ori.b  #$0, d0
00001EBA  subq.b #$4, (a5)+
00001EBC  bne.b  $1ee2
00001EBE  ori.b  #$0, d0
00001EC2  ori.b  #$0, d0
00001EC6  ; data: 0x58, 0x7b
00001EC8  bvs.b  $1edd
00001ECA  ori.b  #$0, d0
00001ECE  ori.b  #$0, d0
00001ED2  dbeq   d6, $8aa4
00001ED6  ori.b  #$0, d0
00001EDA  ori.b  #$0, d0
00001EDE  subq.b #$3, (a4)
00001EE0  bgt.b  $1f33
00001EE2  ori.b  #$0, d0
00001EE6  ori.b  #$0, d0
00001EEA  addq.w #$3, a7
00001EEC  moveq  #$ea, d0
00001EEE  ori.b  #$0, d0
00001EF2  ori.b  #$0, d0
00001EF6  move.l $30bf556f.l, (a6)+
00001EFC  moveq  #$d3, d1
00001EFE  ori.b  #$0, d0
00001F02  move.l ([$5492, a1, d3.w * 8], $746b0000), (a6)
00001F0C  ori.b  #$7b, d0
00001F10  ; data: 0x3c, 0xfe
00001F12  subq.l #$1, (a0)+
00001F14  ; data: 0x75, 0xdc
00001F16  ori.b  #$0, d0
00001F1A  movea.l $42b5(a4), a7
00001F1E  addq.l #$1, (a2)
00001F20  moveq  #$d2, d3
00001F22  ori.b  #$0, d0
00001F26  move.l $5d(a5, d4.l), $517f(a7)
00001F2C  ; data: 0x77, 0x51
00001F2E  ori.b  #$0, d0
00001F32  move.w $4eea(a6), (a0)
00001F36  addq.w #$8, (a7)+
00001F38  ; data: 0x77, 0x16
00001F3A  ori.b  #$0, d0
00001F3E  move.w (a2), $4f33.w
00001F42  sne.b  (a1)
00001F44  ; data: 0x75, 0xad
00001F46  ori.b  #$0, d0
00001F4A  move.w a7, -(a1)
00001F4C  ; data: 0x4d, 0xe5
00001F4E  bra.b  $1f27
00001F50  ; data: 0x71, 0xdb
00001F52  ori.b  #$0, d0
00001F56  move.w (a3)+, d2
00001F58  ; data: 0x4c, 0x88
00001F5A  ori.b  #$0, d0
00001F5E  ori.b  #$0, d0
00001F62  move.w $4b1e0000.l, $0(a2)
00001F6A  ori.b  #$0, d0
00001F6E  bclr.b d6, $1044(a7)
00001F72  move.w (a2)+, (a3)
00001F74  chk.w  -(a7), d4
00001F76  ori.b  #$0, d0
00001F7A  ; data: 0x0c, 0xf2
00001F7C  ; data: 0x12, 0x0b
00001F7E  ; data: 0x37, 0xc2
00001F80  dc.w   $4809
00001F82  ori.b  #$0, d0
00001F86  cmpi.l #$139c38a2, d5
00001F8C  not.w  (a4)+
00001F8E  ori.b  #$0, d0
00001F92  ; data: 0x0c, 0x3d
00001F94  move.b $39ce(a6), -(a2)
00001F98  neg.l  -(a2)
00001F9A  ori.b  #$0, d0
00001F9E  cmpi.b #$69, d5
00001FA2  move.w $42bc0000.l, (a5)+
00001FA8  ori.b  #$ce, d0
00001FAC  ; data: 0x17, 0xbe
00001FAE  ; data: 0x3b, 0xd9
00001FB0  negx.l $0(a2)
00001FB4  ori.b  #$a1, d0
00001FB8  move.b $3cff(a1), -(a4)
00001FBC  move.w d7, (a7)
00001FBE  ori.b  #$0, d0
00001FC2  bchg.b d5, -$54(a2, d1.l)
00001FC6  move.w $1e(a5, d3.l), d6
00001FCA  ori.b  #$0, d0
00001FCE  bchg.b d5, d1
00001FD0  ; data: 0x1b, 0xf2
00001FD2  ; data: 0x39, 0xd2
00001FD4  move.w (a1, d0.w), (a7)+
00001FD8  ori.b  #$d, d0
00001FDC  move.b d5, $373d(a6)
00001FE0  negx.b d1
00001FE2  ori.b  #$0, d0
00001FE6  ; data: 0x0a, 0xe2
00001FE8  move.b -(a5), (a7)
00001FEA  movea.w (a3), a2
00001FEC  move.w sr, d5
00001FEE  ori.b  #$0, d0
00001FF2  eori.l #$206e3154, -(a5)
00001FF8  ; data: 0x41, 0xbf
00001FFA  ori.b  #$0, d0
00001FFE  eori.w #$21e8, ([$42710000], $a2c)
0000200C  move.l $2a43(a4), $4350(a1)
00002012  ori.b  #$0, d0
00002016  bset.b d4, -$8(a2, d2.w)
0000201A  move.l d3, d3
0000201C  lea.l  $0(a3), a1
00002020  ori.b  #$b3, d0
00002024  move.l -$74(a5, d2.w), -(a0)
00002028  neg.l  $0(a2)
0000202C  ori.b  #$59, d0
00002030  move.b (a7)+, $2827(a5)
00002034  ; data: 0x45, 0x54
00002036  ori.b  #$0, d0
0000203A  btst.l d4, (a0)
0000203C  move.b $29c6(a4), ([])
00002044  ori.b  #$39, d0
00002048  ; data: 0x08, 0xc3
0000204A  move.l $4667(a0), $0(a5)
00002050  ori.b  #$70, d0
00002054  move.l -$32(a6, d4.w), $0(a6)
0000205A  ori.b  #$0, d0
0000205E  ; data: 0x08, 0x18
00002060  move.l (a3)+, -(a7)
00002062  dc.w   $472b
00002064  ori.b  #$0, d0
00002068  ori.b  #$9b, d0
0000206C  move.w -(a7), -(a0)
0000206E  ; data: 0x47, 0x62
00002070  ori.b  #$0, d0
00002074  ori.b  #$38, d0
00002078  move.w (a4), ([a1])
0000207E  ori.b  #$0, d0
00002082  dc.w   $6cf
00002084  ; data: 0x35, 0xf3
00002086  ; data: 0x47, 0x49
00002088  ori.b  #$0, d0
0000208C  ori.b  #$3b, d0
00002090  move.w (a7)+, (a4)
00002092  move.w (a1), sr
00002094  ori.b  #$0, d0
00002098  ori.b  #$c6, d0
0000209C  ; data: 0x3b, 0xdb
0000209E  ; data: 0x45, 0xe6
000020A0  ori.b  #$0, d0
000020A4  ori.b  #$22, d0
000020A8  ori.b  #$0, d0
000020AC  ori.b  #$0, d0
000020B0  ori.b  #$75, d0
000020B4  ori.b  #$0, d0
000020B8  ori.b  #$0, d0
000020BC  ori.b  #$ee, d0
000020C0  ori.b  #$0, d0
000020C4  ori.b  #$0, d0
000020C8  ori.b  #$33, d0
000020CC  ori.b  #$0, d0
000020D0  ori.b  #$0, d0
000020D4  ori.b  #$3e, d0
000020D8  ori.b  #$0, d0
000020DC  ori.b  #$0, d0
000020E0  ori.b  #$73, d0
000020E4  ori.b  #$0, d0
000020E8  ori.b  #$0, d0
000020EC  ori.b  #$36, d0
000020F0  ori.b  #$0, d0
000020F4  ori.b  #$0, d0
000020F8  ori.b  #$0, d0
000020FC  ori.b  #$0, d0
00002100  ori.b  #$0, d0
00002104  ori.b  #$0, d0
00002108  ori.b  #$0, d0
0000210C  ori.b  #$0, d0
00002110  ori.b  #$0, d0
00002114  ori.b  #$0, d0
00002118  ori.b  #$0, d0
0000211C  ori.b  #$d2, d0
00002120  dc.w   $eeb
00002122  ori.b  #$0, d0
00002126  ori.b  #$0, d0
0000212A  move.b -(a0), $aef(a1)
0000212E  ori.b  #$0, d0
00002132  ori.b  #$0, d0
00002136  move.b (a0)+, (a2)+
00002138  movep.w $0(a0), d4
0000213C  ori.b  #$0, d0
00002140  ori.b  #$ff, d0
00002144  bchg.b d3, -(a3)
00002146  ori.b  #$0, d0
0000214A  ori.b  #$0, d0
0000214E  move.b #$3b, (a3)
00002152  ori.b  #$0, d0
00002156  ori.b  #$0, d0
0000215A  move.b -(a7), $519(a3)
0000215E  ori.b  #$0, d0
00002162  ori.b  #$0, d0
00002166  ; data: 0x17, 0xe2
00002168  subi.b #$0, (a7, d0.w)
0000216E  ori.b  #$0, d0
00002172  ; data: 0x18, 0x50
00002174  btst.l d1, -(a5)
00002176  ori.b  #$0, d0
0000217A  ori.b  #$0, d0
0000217E  move.b $51(a2, d0.w), (a4)
00002182  ori.b  #$0, d0
00002186  ori.b  #$0, d0
0000218A  move.b d7, -(a4)
0000218C  bclr.b d0, (a6, d0.w)
00002190  ori.b  #$0, d0
00002194  ori.b  #$4f, d0
00002198  dc.w   $ee
0000219A  ori.b  #$0, d0
0000219E  ori.b  #$0, d0
000021A2  ; data: 0x19, 0x7d
000021A4  ori.b  #$0, $0(a7)
000021AA  ori.b  #$0, d0
000021AE  move.b $0(a7), (a4, d0.w)
000021B4  ori.b  #$0, d0
000021B8  ori.b  #$cd, d0
000021BC  ori.b  #$0, d0
000021C0  ori.b  #$0, d0
000021C4  ori.b  #$e4, d0
000021C8  ori.b  #$0, d0
000021CC  ori.b  #$0, d0
000021D0  ori.b  #$f5, d0
000021D4  ori.b  #$0, d0
000021D8  ori.b  #$0, d0
000021DC  ori.b  #$1, d0
000021E0  ori.b  #$0, d0
000021E4  ori.b  #$0, d0
000021E8  ori.b  #$c7, d0
000021EC  chk.w  #$1a04, d5
000021F0  ; data: 0x04, 0x0f
000021F2  ori.b  #$0, d0
000021F6  svc.b  ([$1a011383, a2])
000021FE  ori.b  #$0, d0
00002202  subq.w #$4, (a1)
00002204  ; data: 0x44, 0x3e
00002206  move.b ([]), -(a5)
0000220E  subq.w #$4, d4
00002210  move.w sr, $210e(a6)
00002214  ; data: 0x19, 0xeb
00002216  ori.b  #$0, d0
0000221A  subq.b #$4, d2
0000221C  move.w a0, d7
0000221E  ; data: 0x25, 0xdd
00002220  ; data: 0x19, 0xd3
00002222  ori.b  #$0, d0
00002226  addq.w #$4, (d3.l * 2)
0000222A  move.l (a6)+, d5
0000222C  move.b #$0, (a4, d0.w)
00002232  seq.b  $38ab(a4)
00002236  ; data: 0x2d, 0xd7
00002238  move.b -(a1), (a4, d0.w)
0000223C  ori.b  #$1c, d0
00002240  ; data: 0x36, 0x3e
00002242  move.w (d1.l), -(a0)
00002246  ori.b  #$0, d0
0000224A  addq.b #$3, (a7)+
0000224C  movea.w (a3), a2
0000224E  move.w (a0, invalid.w), d2
00002252  ori.b  #$0, d0
00002256  subq.b #$2, $371c.w
0000225A  move.w ([a6], d1.l, $5437), $39b2.w
00002266  move.l -(a7), ([a7], d1.l)
0000226A  ori.b  #$0, d0
0000226E  subq.b #$1, (a7)+
00002270  move.w (a6), d6
00002272  move.l $18e0(a1), $0(a6)
00002278  ori.b  #$f2, d0
0000227C  movea.w $2b3e(a1), a7
00002280  move.b $0(a6), (a4)
00002284  ori.b  #$b1, d0
00002288  ; data: 0x40, 0x8c
0000228A  move.l $187d(a2), -(a4)
0000228E  ori.b  #$0, d0
00002292  ; data: 0x4f, 0x5e
00002294  clr.l  (a7)+
00002296  move.l $184e(a6), -(a3)
0000229A  ori.b  #$0, d0
0000229E  ; data: 0x4d, 0xfc
000022A0  neg.l  d6
000022A2  move.l a6, $181a(a2)
000022A6  ori.b  #$0, d0
000022AA  ; data: 0x4c, 0x8c
000022AC  not.w  d1
000022AE  move.l ([]), -(a1)
000022B4  ori.b  #$11, d0
000022B8  lea.l  $2144(a7), a3
000022BC  ; data: 0x17, 0xcd
000022BE  ori.b  #$0, d0
000022C2  ; data: 0x49, 0x8e
000022C4  ; data: 0x49, 0x8e
000022C6  ; data: 0x1f, 0x3d
000022C8  move.b $0.w, (a3, d0.w)
000022CE  dc.w   $4b06
000022D0  nbcd.b d4
000022D2  move.b (invalid.w), -(a6)
000022D6  ori.b  #$0, d0
000022DA  ; data: 0x4c, 0x70
000022DC  not.w  -$7c(a7, d1.l)
000022E0  ; data: 0x18, 0x4d
000022E2  ori.b  #$0, d0
000022E6  ; data: 0x4d, 0xce
000022E8  move.w $0(a0), ccr
000022EC  ori.b  #$0, d0
000022F0  ori.b  #$1d, d0
000022F4  ; data: 0x43, 0x5b
000022F6  ori.b  #$0, d0
000022FA  ori.b  #$0, d0
000022FE  addq.w #$8, a2
00002300  ; data: 0x41, 0x70
00002302  ori.b  #$0, d0
00002306  ori.b  #$0, d0
0000230A  subq.w #$8, $3fef(a3)
0000230E  ori.b  #$0, d0
00002312  ori.b  #$0, d0
00002316  ; data: 0x52, 0x7f
00002318  move.w (a3)+, d7
0000231A  ori.b  #$0, d0
0000231E  ori.b  #$0, d0
00002322  subq.l #$1, d6
00002324  movea.w (a4)+, a6
00002326  ori.b  #$0, d0
0000232A  ori.b  #$0, d0
0000232E  addq.l #$2, d1
00002330  move.w (a5, d0.w), (a5)
00002334  ori.b  #$0, d0
00002338  ori.b  #$5e, d0
0000233C  move.w -(a2), (a4)+
0000233E  ori.b  #$0, d0
00002342  ori.b  #$0, d0
00002346  addq.w #$3, d0
00002348  ; data: 0x36, 0xff
0000234A  ori.b  #$0, d0
0000234E  ori.b  #$0, d0
00002352  subq.b #$3, d5
00002354  move.w $0(a4), $0(a2)
0000235A  ori.b  #$0, d0
0000235E  ; data: 0x71, 0x99
00002360  seq.b  d0
00002362  sf.b   $33e9.w
00002366  ori.b  #$0, d0
0000236A  moveq  #$70, d4
0000236C  addq.w #$4, $439e(a6)
00002370  move.w $0(a1), (a1)+
00002374  ori.b  #$e5, d0
00002378  subq.b #$4, (a1)
0000237A  ori.b  #$0, d0
0000237E  ori.b  #$0, d0
00002382  ; data: 0x7d, 0x62
00002384  subq.l #$4, $0(a1)
00002388  ori.b  #$0, d0
0000238C  ori.b  #$cf, d0
00002390  addq.b #$5, $0(a2)
00002394  ori.b  #$0, d0
00002398  ori.b  #$74, d0
0000239C  addq.l #$5, $0(a2)
000023A0  ori.b  #$0, d0
000023A4  ori.b  #$3b, d0
000023A8  subq.b #$5, (a7)+
000023AA  ori.b  #$0, d0
000023AE  ori.b  #$0, d0
000023B2  moveq  #$b4, d5
000023B4  subq.l #$5, d0
000023B6  ori.b  #$0, d0
000023BA  ori.b  #$0, d0
000023BE  moveq  #$5f, d4
000023C0  smi.b  (a5)+
000023C2  ori.b  #$0, d0
000023C6  ori.b  #$0, d0
000023CA  ; data: 0x75, 0x76
000023CC  addq.b #$6, $0(a1)
000023D0  ori.b  #$0, d0
000023D4  ori.b  #$8, d0
000023D8  addq.w #$6, $0(a7)
000023DC  ori.b  #$0, d0
000023E0  ori.b  #$a4, d0
000023E4  addq.l #$6, -(a5)
000023E6  ori.b  #$0, d0
000023EA  ori.b  #$0, d0
000023EE  bvs.b  $244a
000023F0  sge.b  (a0)
000023F2  ori.b  #$0, d0
000023F6  ori.b  #$0, d0
000023FA  bls.b  $239b
000023FC  sge.b  (a4, d0.w)
00002400  ori.b  #$0, d0
00002404  ori.b  #$9, d0
00002408  subq.l #$6, -(a5)
0000240A  ori.b  #$0, d0
0000240E  ori.b  #$0, d0
00002412  subq.b #$6, (a5)
00002414  addq.w #$3, $0(a4)
00002418  ori.b  #$0, d0
0000241C  ori.b  #$54, d0
00002420  subq.b #$6, (a5)
00002422  ori.b  #$0, d0
00002426  ori.b  #$0, d0
0000242A  chk.w  $5d0b(a3), d2
0000242E  ori.b  #$0, d0
00002432  ori.b  #$0, d0
00002436  move.w d4, -$a(a6, d5.l)
0000243A  ori.b  #$0, d0
0000243E  ori.b  #$0, d0
00002442  ; data: 0x39, 0xce
00002444  sge.b  (a3)
00002446  ori.b  #$0, d0
0000244A  ori.b  #$0, d0
0000244E  move.w -$57(a0, d5.l), (a5)
00002452  ori.b  #$0, d0
00002456  ori.b  #$0, d0
0000245A  move.w (a6), $74(a6, d5.l)
0000245E  ori.b  #$0, d0
00002462  ori.b  #$0, d0
00002466  dc.w   $4115
00002468  addq.b #$6, $0(a7)
0000246C  ori.b  #$0, d0
00002470  ori.b  #$e, d0
00002474  smi.b  -(a4)
00002476  ori.b  #$0, d0
0000247A  ori.b  #$0, d0
0000247E  movem.w d3/d7/a0-a1/a3-a4/a6, $0(a6)
00002484  ori.b  #$0, d0
00002488  ori.b  #$9d, d0
0000248C  subq.b #$5, -(a7)
0000248E  ori.b  #$0, d0
00002492  ori.b  #$0, d0
00002496  ; data: 0x50, 0x3e
00002498  addq.l #$5, (a4, d0.w)
0000249C  ori.b  #$0, d0
000024A0  ori.b  #$fb, d0
000024A4  addq.b #$5, (a4, d0.w)
000024A8  ori.b  #$0, d0
000024AC  ori.b  #$3a, d0
000024B0  subq.l #$4, (a4, d0.w)
000024B4  ori.b  #$0, d0
000024B8  ori.b  #$1d, d0
000024BC  subq.b #$5, d2
000024BE  ori.b  #$0, d0
000024C2  ori.b  #$0, d0
000024C6  ; data: 0x58, 0x7b
000024C8  addq.b #$7, (a1, d0.w)
000024CC  ori.b  #$0, d0
000024D0  ori.b  #$ce, d0
000024D4  bra.b  $249e
000024D6  ori.b  #$0, d0
000024DA  ori.b  #$0, d0
000024DE  subq.b #$3, (a4)
000024E0  bls.b  $24a8
000024E2  ori.b  #$0, d0
000024E6  ori.b  #$0, d0
000024EA  addq.w #$3, a7
000024EC  bne.b  $248a
000024EE  ori.b  #$0, d0
000024F2  ori.b  #$0, d0
000024F6  subq.w #$2, $68d3(a7)
000024FA  ori.b  #$0, d0
000024FE  ori.b  #$0, d0
00002502  addq.l #$2, (a2)
00002504  bmi.b  $254f
00002506  ori.b  #$0, d0
0000250A  ori.b  #$0, d0
0000250E  move.l (a7), d5
00002510  move.w a1, $5398(a0)
00002514  blt.b  $2594
00002516  ori.b  #$0, d0
0000251A  movea.l $2554(pc, d3.w), a5
0000251E  addq.l #$1, (a2)
00002520  ble.b  $258f
00002522  ori.b  #$0, d0
00002526  move.l d1, $3ac5(a5)
0000252A  ; data: 0x51, 0x7f
0000252C  ; data: 0x71, 0x0f
0000252E  ori.b  #$0, d0
00002532  move.l ([$2534pc]), d6
00002536  addq.w #$8, (a7)+
00002538  moveq  #$60, d1
0000253A  ori.b  #$0, d0
0000253E  move.l (a4), -(a6)
00002540  neg.w  d2
00002542  dc.w   $4f33
00002544  ; data: 0x73, 0x5a
00002546  ori.b  #$0, d0
0000254A  ; data: 0x2e, 0x3e
0000254C  ; data: 0x49, 0x71
0000254E  ; data: 0x4d, 0xe5
00002550  moveq  #$1d, d2
00002552  ori.b  #$0, d0
00002556  move.l (a7), -(a7)
00002558  ; data: 0x4c, 0x88
0000255A  ; data: 0x4f, 0x61
0000255C  moveq  #$3c, d2
0000255E  ori.b  #$0, d0
00002562  move.w $4b1e5558.l, d0
00002568  ; data: 0x73, 0x9b
0000256A  ori.b  #$0, d0
0000256E  move.w $49a7(a5), -(a0)
00002572  subq.w #$6, ([a2])
00002576  ori.b  #$0, d0
0000257A  bchg.b d4, ([$322a, d0.l * 4])
00002580  dc.w   $4809
00002582  ori.b  #$0, d0
00002586  ; data: 0x08, 0xdf
00002588  ; data: 0x0e, 0xfe
0000258A  move.w $465c(a5), -(a1)
0000258E  ori.b  #$0, d0
00002592  ; data: 0x08, 0x65
00002594  ; data: 0x10, 0x54
00002596  move.w -$5e(a4, d4.w), d2
0000259A  ori.b  #$0, d0
0000259E  ; data: 0x08, 0x0f
000025A0  move.b (a1)+, -$6(a0, d3.w)
000025A4  ; data: 0x42, 0xbc
000025A6  ori.b  #$0, d0
000025AA  bclr.b d3, $12c0.w
000025AE  move.w d4, d3
000025B0  negx.l $0(a2)
000025B4  ori.b  #$5d, d0
000025B8  ; data: 0x13, 0xfd
000025BA  move.w a3, -(a3)
000025BC  move.w d7, (a7)
000025BE  ori.b  #$0, d0
000025C2  btst.l d3, (a0)
000025C4  ; data: 0x15, 0x0a
000025C6  ; data: 0x37, 0xcf
000025C8  move.w (a5, d0.w), d6
000025CC  ori.b  #$c0, d0
000025D0  ; data: 0x16, 0x6d
000025D2  move.w a7, (a4)+
000025D4  ; data: 0x39, 0xd2
000025D6  ori.b  #$0, d0
000025DA  addi.w #$1797, $373d(a2)
000025E0  move.w a2, (a4, d0.w)
000025E4  ori.b  #$27, d0
000025E8  ; data: 0x18, 0xcf
000025EA  movea.w (a3), a2
000025EC  movea.w d1, a5
000025EE  ori.b  #$0, d0
000025F2  bset.b d2, d7
000025F4  move.b (a2), d5
000025F6  move.w (a4), $3b2c(a0)
000025FA  ori.b  #$0, d0
000025FE  bchg.b d2, -(a1)
00002600  move.b -(a0), $2dfb(a5)
00002604  ; data: 0x3b, 0xd4
00002606  ori.b  #$0, d0
0000260A  movep.w $1cba(a7), d2
0000260E  movea.l d3, a5
00002610  move.w $0(a1), (a6)
00002614  ori.b  #$ba, d0
00002618  move.b (a5)+, d7
0000261A  move.l d3, d3
0000261C  move.w d0, $0(a6)
00002620  ori.b  #$40, d0
00002624  move.b $2135(a5), -(a7)
00002628  ; data: 0x3d, 0xfa
0000262A  ori.b  #$0, d0
0000262E  bset.b d1, -(a0)
00002630  move.b (a7)+, $209e(a5)
00002634  movea.w $2636(pc,d0.w), a7
00002638  ori.b  #$7b, d0
0000263C  move.b $2217(a4), ([a1], d3.l * 8)
00002644  ori.b  #$11, d0
00002648  subi.b #$96, $3f9f0000.l
00002650  ori.b  #$7c, d0
00002654  move.l (a1)+, -(a2)
00002656  negx.b (a2)
00002658  ori.b  #$0, d0
0000265C  ori.b  #$7, d0
00002660  move.l (a7)+, (a3)
00002662  negx.w (a1, d0.w)
00002666  ori.b  #$0, d0
0000266A  movep.w d0, $288a(a4)
0000266E  negx.l $0.l
00002674  ori.b  #$e2, d0
00002678  move.l (a2), d5
0000267A  move.w sr, $0(a2)
0000267E  ori.b  #$0, d0
00002682  ori.w  #$2bfb, (a4)+
00002686  dc.w   $4106
00002688  ori.b  #$0, d0
0000268C  ori.b  #$3f, d0
00002690  ; data: 0x40, 0xfc
00002692  ori.b  #$0, d0
00002696  ori.b  #$0, d0
0000269A  move.w (a1)+, d0
0000269C  ; data: 0x40, 0xbe
0000269E  ori.b  #$0, d0
000026A2  ori.b  #$0, d0
000026A6  move.w (a6)+, (a1)
000026A8  negx.b (a0, d0.w)
000026AC  ori.b  #$0, d0
000026B0  ori.b  #$ac, d0
000026B4  move.w a6, -(a7)
000026B6  ori.b  #$0, d0
000026BA  ori.b  #$0, d0
000026BE  ori.b  #$0, d0
000026C2  ori.b  #$0, d0
000026C6  ori.b  #$0, d0
000026CA  ori.b  #$0, d0
000026CE  ori.b  #$0, d0
000026D2  ori.b  #$0, d0
000026D6  ori.b  #$0, d0
000026DA  ori.b  #$0, d0
000026DE  ori.b  #$0, d0
000026E2  ori.b  #$0, d0
000026E6  ori.b  #$0, d0
000026EA  ori.b  #$0, d0
000026EE  ori.b  #$0, d0
000026F2  ori.b  #$0, d0
000026F6  ori.b  #$0, d0
000026FA  ori.b  #$0, d0
000026FE  ori.b  #$0, d0
00002702  ori.b  #$0, d0
00002706  ori.b  #$0, d0
0000270A  ori.b  #$0, d0
0000270E  ori.b  #$0, d0
00002712  ori.b  #$0, d0
00002716  ori.b  #$0, d0
0000271A  ori.b  #$0, d0
0000271E  ori.b  #$0, d0
00002722  ori.b  #$0, d0
00002726  ori.b  #$0, d0
0000272A  move.b $1401(a3), (a4, d0.w)
00002730  ori.b  #$0, d0
00002734  ori.b  #$b9, d0
00002738  move.b d0, (a0, d0.w)
0000273C  ori.b  #$0, d0
00002740  ori.b  #$d8, d0
00002744  bchg.b d7, (a6, d0.w)
00002748  ori.b  #$0, d0
0000274C  ori.b  #$af, d0
00002750  dc.w   $e30
00002752  ori.b  #$0, d0
00002756  ori.b  #$0, d0
0000275A  ; data: 0x1e, 0x4a
0000275C  cmpi.l #$0, $0(a4)
00002764  ori.b  #$b6, d0
00002768  bclr.b d5, $0(a5)
0000276C  ori.b  #$0, d0
00002770  ori.b  #$29, d0
00002774  eori.w #$0, (a3, d0.w)
0000277A  ori.b  #$0, d0
0000277E  move.b ([a5]), $0(a7)
00002788  ori.b  #$b2, d0
0000278C  ; data: 0x08, 0x8c
0000278E  ori.b  #$0, d0
00002792  ori.b  #$0, d0
00002796  ; data: 0x1f, 0xd7
00002798  bclr.b d3, -(a1)
0000279A  ori.b  #$0, d0
0000279E  ori.b  #$0, d0
000027A2  ; data: 0x1f, 0xfb
000027A4  dc.w   $6f6
000027A6  ori.b  #$0, d0
000027AA  ori.b  #$0, d0
000027AE  move.l a5, d0
000027B0  addi.b #$0, (a7)
000027B4  ori.b  #$0, d0
000027B8  ori.b  #$1a, d0
000027BC  bchg.b d2, (a5, d0.w)
000027C0  ori.b  #$0, d0
000027C4  ori.b  #$1b, d0
000027C8  subi.l #$0, -(a4)
000027CE  ori.b  #$0, d0
000027D2  move.l (a4), d0
000027D4  ; data: 0x04, 0x0d
000027D6  ori.b  #$0, d0
000027DA  ori.b  #$0, d0
000027DE  move.l d2, d0
000027E0  ; data: 0x03, 0x7a
000027E2  ori.b  #$0, d0
000027E6  ori.b  #$0, d0
000027EA  ; data: 0x1f, 0xec
000027EC  ; data: 0x04, 0x0f
000027EE  ; data: 0x02, 0xbe
000027F0  ori.b  #$0, d0
000027F4  ori.b  #$d0, d0
000027F8  move.b d3, $37(a1, d0.w)
000027FC  ori.b  #$0, d0
00002800  ori.b  #$e8, d0
00002804  dc.w   $54fc
00002806  move.b $1b37(a7), ([$5dba], d0.w)
00002810  jmp    (a1)
00002812  move.l a6, -(a0)
00002814  ; data: 0x1f, 0x88
00002816  movep.w $0(a6), d0
0000281A  addq.l #$7, a6
0000281C  tst.l  -(a7)
0000281E  ; data: 0x25, 0xdd
00002820  ; data: 0x1f, 0x4d
00002822  ori.l  #$5ebb, (a7)
00002828  move.w d0, sr
0000282A  move.l (a6)+, d5
0000282C  move.b (a4)+, -(a7)
0000282E  ori.b  #$0, -(a5)
00002832  addq.l #$7, a7
00002834  dc.w   $433b
00002836  ; data: 0x2d, 0xd7
00002838  move.b -(a7), (a7)+
0000283A  ori.b  #$0, d0
0000283E  addq.b #$7, (a0)+
00002840  negx.b $3131(a4)
00002844  move.b $0(a7), (a7)
00002848  ori.b  #$7c, d0
0000284C  move.w (a6)+, $30(a6, d3.w)
00002850  ; data: 0x1e, 0x60
00002852  ori.b  #$0, d0
00002856  addq.l #$6, -$6f(a0, d3.l)
0000285A  move.w (a4)+, -(a3)
0000285C  move.b -(a3), d7
0000285E  ori.b  #$0, d0
00002862  subq.l #$5, ([$380e1dcf, d3.l])
0000286C  ori.b  #$ca, d0
00002870  move.w (a6), d6
00002872  move.w (a6), ([], d1.l * 4)
0000287A  ; data: 0x59, 0x7f
0000287C  movea.w $332d(a1), a7
00002880  move.b $2882(pc), -(a6)
00002884  ori.b  #$5a, d0
00002888  ; data: 0x40, 0x8c
0000288A  move.w (a5), (a0)+
0000288C  move.b -(a7), (a6)+
0000288E  ori.b  #$0, d0
00002892  subq.b #$3, (a5)+
00002894  clr.l  (a7)+
00002896  move.l -(a3), d7
00002898  move.b (a6), (a6)
0000289A  ori.b  #$0, d0
0000289E  subq.w #$2, -$7a(a4, d4.w)
000028A2  ; data: 0x2b, 0xfe
000028A4  ; data: 0x1c, 0x4a
000028A6  ori.b  #$0, d0
000028AA  ; data: 0x54, 0x09
000028AC  not.w  d1
000028AE  move.l (a0), (invalid.w)
000028B6  addq.l #$1, a6
000028B8  lea.l  $274d(a7), a3
000028BC  move.b $0(a1), (a5, d0.w)
000028C2  subq.b #$8, d5
000028C4  ; data: 0x49, 0x8e
000028C6  move.l $1b6e0000.l, -(a2)
000028CC  ori.b  #$6f, d0
000028D0  dc.w   $4b06
000028D2  move.l a1, -(a1)
000028D4  move.b $28d6(pc), -(a5)
000028D8  ori.b  #$d0, d0
000028DC  ; data: 0x4c, 0x70
000028DE  movea.l -(a3), a0
000028E0  move.b (a3, d0.w), -(a5)
000028E4  ori.b  #$ce, d0
000028E8  ; data: 0x4c, 0x2a
000028EA  move.b (a2), $1bf1(a6)
000028EE  ori.b  #$0, d0
000028F2  dc.w   $4f1d
000028F4  tst.b  (a4)
000028F6  ori.b  #$0, d0
000028FA  ori.b  #$0, d0
000028FE  addq.w #$8, a2
00002900  ; data: 0x48, 0x67
00002902  ori.b  #$0, d0
00002906  ori.b  #$0, d0
0000290A  subq.w #$8, $46bb(a3)
0000290E  ori.b  #$0, d0
00002912  ori.b  #$0, d0
00002916  ; data: 0x52, 0x7f
00002918  neg.l  $0(a3)
0000291C  ori.b  #$0, d0
00002920  ori.b  #$86, d0
00002924  clr.l  -(a6)
00002926  ori.b  #$0, d0
0000292A  ori.b  #$0, d0
0000292E  addq.l #$2, d1
00002930  negx.l (a2, d0.w)
00002934  ori.b  #$0, d0
00002938  ori.b  #$5e, d0
0000293C  move.w (a3), (a7)+
0000293E  ori.b  #$0, d0
00002942  ori.b  #$0, d0
00002946  addq.w #$3, d0
00002948  move.w $0.l, (a6)
0000294E  ori.b  #$0, d0
00002952  subq.b #$3, d5
00002954  move.w a5, (a5)+
00002956  ori.b  #$0, d0
0000295A  ori.b  #$0, d0
0000295E  seq.b  d0
00002960  move.w (a3), (a4)+
00002962  ori.b  #$0, d0
00002966  ori.b  #$0, d0
0000296A  addq.w #$4, $36c8(a6)
0000296E  ori.b  #$0, d0
00002972  ori.b  #$0, d0
00002976  subq.b #$4, (a1)
00002978  ; data: 0x35, 0x3f
0000297A  ori.b  #$0, d0
0000297E  ori.b  #$0, d0
00002982  blt.b  $29c9
00002984  subq.l #$4, $4885(a1)
00002988  move.w a6, (a2)
0000298A  ori.b  #$0, d0
0000298E  moveq  #$61, d3
00002990  addq.b #$5, $0(a2)
00002994  ori.b  #$0, d0
00002998  ori.b  #$f1, d0
0000299C  addq.l #$5, $0(a2)
000029A0  ori.b  #$0, d0
000029A4  ori.b  #$59, d0
000029A8  subq.b #$5, (a7)+
000029AA  ori.b  #$0, d0
000029AE  ori.b  #$0, d0
000029B2  moveq  #$b6, d7
000029B4  subq.l #$5, d0
000029B6  ori.b  #$0, d0
000029BA  ori.b  #$0, d0
000029BE  ; data: 0x7f, 0x03
000029C0  smi.b  (a5)+
000029C2  ori.b  #$0, d0
000029C6  ori.b  #$0, d0
000029CA  moveq  #$6e, d7
000029CC  addq.b #$6, $0(a1)
000029D0  ori.b  #$0, d0
000029D4  ori.b  #$2e, d0
000029D8  addq.w #$6, $0(a7)
000029DC  ori.b  #$0, d0
000029E0  ori.b  #$fd, d0
000029E4  addq.l #$6, -(a5)
000029E6  ori.b  #$0, d0
000029EA  ori.b  #$0, d0
000029EE  moveq  #$62, d4
000029F0  sge.b  (a0)
000029F2  ori.b  #$0, d0
000029F6  ori.b  #$0, d0
000029FA  moveq  #$c9, d2
000029FC  sge.b  (a4, d0.w)
00002A00  ori.b  #$0, d0
00002A04  ori.b  #$91, d0
00002A08  ; data: 0x5d, 0x09
00002A0A  ori.b  #$0, d0
00002A0E  ori.b  #$0, d0
00002A12  bmi.b  $2a5c
00002A14  subq.b #$6, (a5)
00002A16  ori.b  #$0, d0
00002A1A  ori.b  #$0, d0
00002A1E  subq.b #$6, (a5)
00002A20  bcc.b  $2a12
00002A22  ori.b  #$0, d0
00002A26  ori.b  #$0, d0
00002A2A  ; data: 0x5d, 0x0b
00002A2C  ; data: 0x5d, 0x0b
00002A2E  ori.b  #$0, d0
00002A32  ori.b  #$0, d0
00002A36  subq.w #$1, (a2)
00002A38  sge.b  (a6, d0.w)
00002A3C  ori.b  #$0, d0
00002A40  ori.b  #$41, d0
00002A44  sge.b  (a3)
00002A46  ori.b  #$0, d0
00002A4A  ori.b  #$0, d0
00002A4E  move.w a3, (a6)
00002A50  addq.l #$6, $0(a1)
00002A54  ori.b  #$0, d0
00002A58  ori.b  #$26, d0
00002A5C  addq.w #$6, (a4, d0.w)
00002A60  ori.b  #$0, d0
00002A64  ori.b  #$4a, d0
00002A68  addq.b #$6, $0(a7)
00002A6C  ori.b  #$0, d0
00002A70  ori.b  #$b, d0
00002A74  smi.b  -(a4)
00002A76  ori.b  #$0, d0
00002A7A  ori.b  #$0, d0
00002A7E  negx.b -(a5)
00002A80  subq.l #$5, a0
00002A82  ori.b  #$0, d0
00002A86  ori.b  #$0, d0
00002A8A  chk.w  (a1), d1
00002A8C  subq.b #$5, -(a7)
00002A8E  ori.b  #$0, d0
00002A92  ori.b  #$0, d0
00002A96  not.l  (a3)
00002A98  addq.l #$5, (a4, d0.w)
00002A9C  ori.b  #$0, d0
00002AA0  ori.b  #$d3, d0
00002AA4  addq.b #$5, (a4, d0.w)
00002AA8  ori.b  #$0, d0
00002AAC  ori.b  #$44, d0
00002AB0  subq.l #$4, (a4, d0.w)
00002AB4  ori.b  #$0, d0
00002AB8  ori.b  #$51, d0
00002ABC  subq.b #$4, (a5)+
00002ABE  ori.b  #$0, d0
00002AC2  ori.b  #$0, d0
00002AC6  subq.w #$1, $587b(a4)
00002ACA  ori.b  #$0, d0
00002ACE  ori.b  #$0, d0
00002AD2  addq.l #$3, a4
00002AD4  dbeq   d6, $2ad6
00002AD8  ori.b  #$0, d0
00002ADC  ori.b  #$14, d0
00002AE0  subq.l #$4, -(a6)
00002AE2  ori.b  #$0, d0
00002AE6  ori.b  #$0, d0
00002AEA  addq.w #$3, a7
00002AEC  addq.b #$6, (a0, d0.w)
00002AF0  ori.b  #$0, d0
00002AF4  ori.b  #$6f, d0
00002AF8  addq.l #$7, $0(a1)
00002AFC  ori.b  #$0, d0
00002B00  ori.b  #$92, d0
00002B04  bsr.b  $2b13
00002B06  ori.b  #$0, d0
00002B0A  ori.b  #$0, d0
00002B0E  subq.l #$1, (a0)+
00002B10  bls.b  $2ad9
00002B12  ori.b  #$0, d0
00002B16  ori.b  #$0, d0
00002B1A  move.l d3, $3e(a3, d2.l)
00002B1E  addq.l #$1, (a2)
00002B20  bcs.b  $2b0a
00002B22  ori.b  #$0, d0
00002B26  move.l (a3)+, -$52(a3, d3.w)
00002B2A  ; data: 0x51, 0x7f
00002B2C  beq.b  $2b11
00002B2E  ori.b  #$0, d0
00002B32  move.l $34ab(a1), d4
00002B36  addq.w #$8, (a7)+
00002B38  bpl.b  $2b45
00002B3A  ori.b  #$0, d0
00002B3E  move.l $38c5(a7), (a4)+
00002B42  dc.w   $4f33
00002B44  bmi.b  $2aea
00002B46  ori.b  #$0, d0
00002B4A  move.l -(a0), -$3a(a4, d3.l)
00002B4E  ; data: 0x4d, 0xe5
00002B50  blt.b  $2b9e
00002B52  ori.b  #$0, d0
00002B56  move.l (a0)+, (a5)
00002B58  ; data: 0x41, 0x0b
00002B5A  ; data: 0x4c, 0x88
00002B5C  bgt.b  $2bd0
00002B5E  ori.b  #$0, d0
00002B62  move.l (a0), $44f4(a5)
00002B66  dc.w   $4b1e
00002B68  ble.b  $2b17
00002B6A  ori.b  #$0, d0
00002B6E  movea.l d7, a6
00002B70  ; data: 0x49, 0x8e
00002B72  chk.w  -(a7), d4
00002B74  moveq  #$5e, d0
00002B76  ori.b  #$0, d0
00002B7A  ; data: 0x05, 0xfc
00002B7C  bchg.b d4, (a6)+
00002B7E  move.l (a0)+, -(a6)
00002B80  dc.w   $4809
00002B82  ; data: 0x4e, 0xcf
00002B84  moveq  #$c1, d0
00002B86  btst.l d2, (a7)+
00002B88  eori.l #$2df1465c, $5409(a0)
00002B90  moveq  #$84, d0
00002B92  subi.l #$bcd2ed1, (a3)+
00002B98  neg.l  -(a2)
00002B9A  spl.b  d6
00002B9C  ble.b  $2bcb
00002B9E  subi.b #$e3, (a2)
00002BA2  move.l -$44(a4, d4.w), $71(a7, d6.w)
00002BA8  bvc.b  $2b79
00002BAA  bclr.b d1, (a4)+
00002BAC  ; data: 0x0e, 0x14
00002BAE  movea.w -(a0), a0
00002BB0  negx.l $0(a2)
00002BB4  ori.b  #$1f, d0
00002BB8  ; data: 0x0e, 0xee
00002BBA  move.w d6, $3e87(a0)
00002BBE  ori.b  #$0, d0
00002BC2  andi.l #$101031f1, $35(a6, d3.l)
00002BCA  ori.b  #$0, d0
00002BCE  ; data: 0x02, 0x48
00002BD0  move.b d6, -(a0)
00002BD2  move.w (a3), (a1)+
00002BD4  ; data: 0x39, 0xd2
00002BD6  ori.b  #$0, d0
00002BDA  bset.b d0, (a3)
00002BDC  ; data: 0x12, 0x08
00002BDE  move.w $631d(pc), $0(a1)
00002BE4  ori.b  #$57, d0
00002BE8  move.b (a6), -(a1)
00002BEA  movea.w (a3), a2
00002BEC  movea.w (a3), a2
00002BEE  ori.b  #$0, d0
00002BF2  ; data: 0x00, 0xd3
00002BF4  move.b $3154(a7), d2
00002BF8  move.w (a0, d0.w), (a2)+
00002BFC  ori.b  #$6c, d0
00002C00  move.b (a4), $2dfb(a2)
00002C04  move.w a1, (a2, d0.w)
00002C08  ori.b  #$84, d0
00002C0C  movea.l d3, a5
00002C0E  movea.w a2, a3
00002C10  ori.b  #$0, d0
00002C14  ori.b  #$6e, d0
00002C18  move.l d3, d3
00002C1A  move.w (a4), (a3)+
00002C1C  ori.b  #$0, d0
00002C20  ori.b  #$af, d0
00002C24  move.l ([a5]), -(a0)
00002C28  ori.b  #$0, d0
00002C2C  ori.b  #$f9, d0
00002C30  move.b (a7)+, $37f7(a5)
00002C34  ori.b  #$0, d0
00002C38  ori.b  #$ac, d0
00002C3C  move.b $66(a5, d3.l), (a5)+
00002C40  ori.b  #$0, d0
00002C44  ori.b  #$39, d0
00002C48  ; data: 0x1c, 0x4c
00002C4A  move.w $0(a3), (a4)+
00002C4E  ori.b  #$0, d0
00002C52  move.b $3944(a2), (a6, d0.w)
00002C58  ori.b  #$0, d0
00002C5C  ori.b  #$c, d0
00002C60  move.w $0(a1), (a4, d0.w)
00002C66  ori.b  #$0, d0
00002C6A  movea.l ([]), a0
00002C76  move.l (a5)+, $3a39.w
00002C7A  ori.b  #$0, d0
00002C7E  ori.b  #$0, d0
00002C82  move.l a1, $3a62(a1)
00002C86  ori.b  #$0, d0
00002C8A  ori.b  #$0, d0
00002C8E  move.l (a1), -(a2)
00002C90  movea.w (a6, d0.w), a5
00002C94  ori.b  #$0, d0
00002C98  ori.b  #$d6, d0
00002C9C  movea.w $0(a7), a5
00002CA0  ori.b  #$0, d0
00002CA4  ori.b  #$97, d0
00002CA8  movea.w d6, a5
00002CAA  ori.b  #$0, d0
00002CAE  ori.b  #$0, d0
00002CB2  move.l $39e7(a0), (a5)
00002CB6  ori.b  #$0, d0
00002CBA  ori.b  #$0, d0
00002CBE  ; data: 0x2c, 0xfe
00002CC0  move.w $0.w, -(a4)
00002CC4  ori.b  #$0, d0
00002CC8  ori.b  #$22, d0
00002CCC  ; data: 0x37, 0xcc
00002CCE  ori.b  #$0, d0
00002CD2  ori.b  #$0, d0
00002CD6  ori.b  #$0, d0
00002CDA  ori.b  #$0, d0
00002CDE  ori.b  #$0, d0
00002CE2  ori.b  #$0, d0
00002CE6  ori.b  #$0, d0
00002CEA  ori.b  #$0, d0
00002CEE  ori.b  #$0, d0
00002CF2  ori.b  #$0, d0
00002CF6  ori.b  #$0, d0
00002CFA  ori.b  #$0, d0
00002CFE  ori.b  #$0, d0
00002D02  ori.b  #$0, d0
00002D06  ori.b  #$0, d0
00002D0A  ori.b  #$0, d0
00002D0E  ori.b  #$0, d0
00002D12  ori.b  #$0, d0
00002D16  ori.b  #$0, d0
00002D1A  ori.b  #$0, d0
00002D1E  ori.b  #$0, d0
00002D22  ori.b  #$0, d0
00002D26  ori.b  #$0, d0
00002D2A  ori.b  #$0, d0
00002D2E  ori.b  #$0, d0
00002D32  ori.b  #$0, d0
00002D36  move.l $1b09(a1), (a0, d0.w)
00002D3C  ori.b  #$0, d0
00002D40  ori.b  #$64, d0
00002D44  ; data: 0x18, 0x60
00002D46  ori.b  #$0, d0
00002D4A  ori.b  #$0, d0
00002D4E  movea.l -(a4), a2
00002D50  ; data: 0x16, 0x76
00002D52  ori.b  #$0, d0
00002D56  ori.b  #$0, d0
00002D5A  ; data: 0x24, 0xfd
00002D5C  ; data: 0x14, 0xcd
00002D5E  ori.b  #$0, d0
00002D62  ori.b  #$0, d0
00002D66  ; data: 0x25, 0x7e
00002D68  move.b $0(a3), $0(a1)
00002D6E  ori.b  #$0, d0
00002D72  ; data: 0x25, 0xe6
00002D74  ; data: 0x12, 0x0c
00002D76  ori.b  #$0, d0
00002D7A  ori.b  #$0, d0
00002D7E  move.l -(a6), d3
00002D80  move.b (a5, d0.w), (a0)+
00002D84  ori.b  #$0, d0
00002D88  ori.b  #$56, d0
00002D8C  bset.b d7, -(a2)
00002D8E  ori.b  #$0, d0
00002D92  ori.b  #$0, d0
00002D96  movea.l -$2e(a6, d0.l), a3
00002D9A  ori.b  #$0, d0
00002D9E  ori.b  #$0, d0
00002DA2  move.l d6, (a3)
00002DA4  movep.l d6, $0(a1)
00002DA8  ori.b  #$0, d0
00002DAC  ori.b  #$87, d0
00002DB0  ; data: 0x0c, 0xc4
00002DB2  ori.b  #$0, d0
00002DB6  ori.b  #$0, d0
00002DBA  ; data: 0x26, 0x7e
00002DBC  cmpi.b #$0, d6
00002DC0  ori.b  #$0, d0
00002DC4  ori.b  #$6c, d0
00002DC8  movep.w $0(a5), d5
00002DCC  ori.b  #$0, d0
00002DD0  ori.b  #$48, d0
00002DD4  eori.w #$0, (a0)+
00002DD8  ori.b  #$0, d0
00002DDC  ori.b  #$25, d0
00002DE0  bchg.b d4, $0(a5)
00002DE4  ori.b  #$0, d0
00002DE8  ori.b  #$fa, d0
00002DEC  ; data: 0x08, 0xc3
00002DEE  ; data: 0x04, 0x0f
00002DF0  ori.b  #$0, d0
00002DF4  ori.b  #$b7, d0
00002DF8  move.b d3, $1d(a1, d0.l)
00002DFC  ori.b  #$0, d0
00002E00  ori.b  #$7d, d0
00002E04  move.b ([a7]), -(a5)
00002E08  ori.b  #$0, d0
00002E0C  ori.b  #$3d, d0
00002E10  move.l a6, -(a0)
00002E12  addi.l #$0, $0(a5)
00002E1A  ; data: 0x25, 0xdd
00002E1C  move.l $5e8.w, (a2)+
00002E20  ori.b  #$0, d0
00002E24  ori.b  #$8d, d0
00002E28  ; data: 0x58, 0x09
00002E2A  move.l (a6)+, d5
00002E2C  move.l $559(a7), (a2)
00002E30  ori.b  #$3, d0
00002E34  dbra   d0, $5c0d
00002E38  movea.l d6, a2
00002E3A  subi.l #$63b6, -(a3)
00002E40  ; data: 0x4d, 0x58
00002E42  move.w ([$4210000], $63c54937), -(a0)
00002E4E  move.w ([], d2.w * 2, $37b), d2
00002E54  ori.b  #$7b, d0
00002E58  chk.w  d4, d2
00002E5A  move.w (a4)+, -(a3)
00002E5C  move.l $2dd(a1), -(a1)
00002E60  ori.b  #$e2, d0
00002E64  clr.w  (a3)
00002E66  move.w -$31(a2, d2.w), $48(a4, d0.w)
00002E6C  ori.b  #$28, d0
00002E70  move.w -(a4), -(a7)
00002E72  move.w (a6), d6
00002E74  movea.l (a6), a1
00002E76  ; data: 0x01, 0xba
00002E78  ori.b  #$3c, d0
00002E7C  movea.w $3bfe(a1), a7
00002E80  move.l $601e(a16, d0.w), $408c.w
00002E8A  move.w $2183(a3), $95(a4)
00002E90  ori.b  #$d2, d0
00002E94  clr.l  (a7)+
00002E96  movea.w $210f(a0), a3
00002E9A  ori.b  #$0, d0
00002E9E  subq.l #$6, $4486(a2)
00002EA2  move.w d2, -$62(a1, d2.w)
00002EA6  ori.b  #$0, d0
00002EAA  addq.b #$6, (a3)
00002EAC  not.w  d1
00002EAE  move.w $34(a1, d2.w), -(a0)
00002EB2  ori.b  #$0, d0
00002EB6  addq.l #$5, ([$2e8d])
00002EBC  move.b $2ebe(pc,d0.w), (a7, d0.w)
00002EC2  svc.b  (a5)+
00002EC4  ; data: 0x49, 0x8e
00002EC6  move.l $1f51(a7), (a5, d0.w)
00002ECC  ori.b  #$50, d0
00002ED0  dc.w   $4b06
00002ED2  move.l $1eea(a6), $0(a4)
00002ED8  ori.b  #$b2, d0
00002EDC  ; data: 0x4c, 0x70
00002EDE  move.l $2e79(pc, d1.l), (a3)
00002EE2  ori.b  #$0, d0
00002EE6  subq.l #$1, (a2)+
00002EE8  ; data: 0x4d, 0xce
00002EEA  move.l -(a4), $1e7c0000.l
00002EF0  ori.b  #$e1, d0
00002EF4  dc.w   $4f1d
00002EF6  move.l $1f75(a6), d0
00002EFA  ori.b  #$0, d0
00002EFE  addq.w #$8, a2
00002F00  addq.b #$8, -(a0)
00002F02  ori.b  #$0, d0
00002F06  ori.b  #$0, d0
00002F0A  subq.w #$8, $4de7(a3)
00002F0E  ori.b  #$0, d0
00002F12  ori.b  #$0, d0
00002F16  ; data: 0x52, 0x7f
00002F18  dc.w   $4c1e
00002F1A  ori.b  #$0, d0
00002F1E  ori.b  #$0, d0
00002F22  subq.l #$1, d6
00002F24  ; data: 0x49, 0xe3
00002F26  ori.b  #$0, d0
00002F2A  ori.b  #$0, d0
00002F2E  addq.l #$2, d1
00002F30  chk.w  $0(a7), d3
00002F34  ori.b  #$0, d0
00002F38  ori.b  #$5e, d0
00002F3C  chk.w  d7, d2
00002F3E  ori.b  #$0, d0
00002F42  ori.b  #$0, d0
00002F46  addq.w #$3, d0
00002F48  dc.w   $4307
00002F4A  ori.b  #$0, d0
00002F4E  ori.b  #$0, d0
00002F52  subq.b #$3, d5
00002F54  ; data: 0x41, 0x0b
00002F56  ori.b  #$0, d0
00002F5A  ori.b  #$0, d0
00002F5E  seq.b  d0
00002F60  movea.w (a5, d0.w), a7
00002F64  ori.b  #$0, d0
00002F68  ori.b  #$6e, d0
00002F6C  movea.w (a4, d0.w), a6
00002F70  ori.b  #$0, d0
00002F74  ori.b  #$11, d0
00002F78  move.w -(a3), d5
00002F7A  ori.b  #$0, d0
00002F7E  ori.b  #$0, d0
00002F82  subq.l #$4, $3818(a1)
00002F86  ori.b  #$0, d0
00002F8A  ori.b  #$0, d0
00002F8E  addq.b #$5, $3682(a2)
00002F92  ori.b  #$0, d0
00002F96  ori.b  #$0, d0
00002F9A  addq.l #$5, $3652(a2)
00002F9E  ori.b  #$0, d0
00002FA2  ori.b  #$0, d0
00002FA6  bvs.b  $2faa
00002FA8  subq.b #$5, (a7)+
00002FAA  ori.b  #$0, d0
00002FAE  ori.b  #$0, d0
00002FB2  ; data: 0x73, 0x32
00002FB4  subq.l #$5, d0
00002FB6  ori.b  #$0, d0
00002FBA  ori.b  #$0, d0
00002FBE  moveq  #$c0, d4
00002FC0  smi.b  (a5)+
00002FC2  ori.b  #$0, d0
00002FC6  ori.b  #$0, d0
00002FCA  moveq  #$4b, d6
00002FCC  addq.b #$6, $0(a1)
00002FD0  ori.b  #$0, d0
00002FD4  ori.b  #$7a, d0
00002FD8  addq.w #$6, $0(a7)
00002FDC  ori.b  #$0, d0
00002FE0  ori.b  #$89, d0
00002FE4  addq.l #$6, -(a5)
00002FE6  ori.b  #$0, d0
00002FEA  ori.b  #$0, d0
00002FEE  ; data: 0x7f, 0xb6
00002FF0  sge.b  (a0)
00002FF2  ori.b  #$0, d0
00002FF6  ori.b  #$0, d0
00002FFA  ; data: 0x7f, 0x00
00002FFC  sge.b  (a4, d0.w)
00003000  ori.b  #$0, d0
00003004  ori.b  #$6b, d0
00003008  ; data: 0x5d, 0x09
0000300A  ori.b  #$0, d0
0000300E  ori.b  #$0, d0
00003012  ; data: 0x7b, 0x01
00003014  subq.b #$6, (a5)
00003016  ori.b  #$0, d0
0000301A  ori.b  #$0, d0
0000301E  subq.b #$6, (a5)
00003020  ; data: 0x77, 0xd4
00003022  ori.b  #$0, d0
00003026  ori.b  #$0, d0
0000302A  ; data: 0x5d, 0x0b
0000302C  ; data: 0x73, 0x7e
0000302E  ori.b  #$0, d0
00003032  ori.b  #$0, d0
00003036  sge.b  ([a6])
0000303A  ori.b  #$0, d0
0000303E  ori.b  #$0, d0
00003042  sge.b  (a3)
00003044  bcs.b  $3029
00003046  ori.b  #$0, d0
0000304A  ori.b  #$0, d0
0000304E  subq.w #$5, $5ca9(a6)
00003052  ori.b  #$0, d0
00003056  ori.b  #$0, d0
0000305A  ; data: 0x4b, 0x5e
0000305C  addq.w #$6, (a4, d0.w)
00003060  ori.b  #$0, d0
00003064  ori.b  #$e1, d0
00003068  addq.b #$6, $0(a7)
0000306C  ori.b  #$0, d0
00003070  ori.b  #$5a, d0
00003074  smi.b  -(a4)
00003076  ori.b  #$0, d0
0000307A  ori.b  #$0, d0
0000307E  move.w $5b88(a3), (a4, d0.w)
00003084  ori.b  #$0, d0
00003088  ori.b  #$3e, d0
0000308C  subq.b #$5, -(a7)
0000308E  ori.b  #$0, d0
00003092  ori.b  #$0, d0
00003096  move.w -$4c(a4, d5.l), (a7)+
0000309A  ori.b  #$0, d0
0000309E  ori.b  #$0, d0
000030A2  ; data: 0x41, 0xda
000030A4  addq.b #$5, (a4, d0.w)
000030A8  ori.b  #$0, d0
000030AC  ori.b  #$b4, d0
000030B0  subq.l #$4, (a4, d0.w)
000030B4  ori.b  #$0, d0
000030B8  ori.b  #$cc, d0
000030BC  subq.b #$4, (a5)+
000030BE  ori.b  #$0, d0
000030C2  ori.b  #$0, d0
000030C6  tst.l  (a1)+
000030C8  ; data: 0x58, 0x7b
000030CA  ori.b  #$0, d0
000030CE  ori.b  #$0, d0
000030D2  ; data: 0x4d, 0x7f
000030D4  dbeq   d6, $30d6
000030D8  ori.b  #$0, d0
000030DC  ori.b  #$f7, d0
000030E0  subq.b #$3, (a4)
000030E2  ori.b  #$0, d0
000030E6  ori.b  #$0, d0
000030EA  addq.w #$1, $4f(a3, d5.w)
000030EE  ori.b  #$0, d0
000030F2  ori.b  #$0, d0
000030F6  subq.w #$2, $556f(a7)
000030FA  ori.b  #$0, d0
000030FE  ori.b  #$0, d0
00003102  addq.l #$2, (a2)
00003104  seq.b  -(a3)
00003106  ori.b  #$0, d0
0000310A  ori.b  #$0, d0
0000310E  subq.l #$1, (a0)+
00003110  addq.w #$5, a3
00003112  ori.b  #$0, d0
00003116  ori.b  #$0, d0
0000311A  addq.l #$1, (a2)
0000311C  addq.l #$6, -(a1)
0000311E  ori.b  #$0, d0
00003122  ori.b  #$0, d0
00003126  move.l (invalid.w), (a2)+
0000312A  ; data: 0x51, 0x7f
0000312C  addq.w #$7, $0(a7)
00003130  ori.b  #$a7, d0
00003134  move.l (a1), d6
00003136  addq.w #$8, (a7)+
00003138  bra.b  $30d2
0000313A  ori.b  #$0, d0
0000313E  move.l d0, -(a2)
00003140  move.l (a2)+, ([$62a00000, a7, d4.l * 8], $2593)
0000314C  move.w -(a1), (a1)+
0000314E  ; data: 0x4d, 0xe5
00003150  bcc.b  $30d5
00003152  ori.b  #$0, d0
00003156  ; data: 0x26, 0x3d
00003158  move.w d3, (a3)
0000315A  ; data: 0x4c, 0x88
0000315C  bne.b  $319c
0000315E  ori.b  #$0, d0
00003162  move.l -(a6), (a3)+
00003164  ; data: 0x39, 0xf1
00003166  dc.w   $4b1e
00003168  beq.b  $3135
0000316A  ori.b  #$0, d0
0000316E  move.l -(a4), ([, d3.l * 4], $49a76968)
00003176  ori.b  #$0, d0
0000317A  andi.w #$547, $2848.w
00003180  ; data: 0x41, 0x5c
00003182  dc.w   $4809
00003184  bpl.b  $310d
00003186  bchg.b d0, -(a2)
00003188  ; data: 0x06, 0x88
0000318A  move.l -(a3), -(a4)
0000318C  ; data: 0x45, 0x43
0000318E  not.w  (a4)+
00003190  bmi.b  $312a
00003192  ori.l  #$78429db, $44a2(a1)
0000319A  dc.w   $493b
0000319C  bge.b  $31f4
0000319E  ori.b  #$72, d1
000031A2  movea.l $42bc(a0), a5
000031A6  dc.w   $4d36
000031A8  bge.b  $3172
000031AA  bchg.b d4, $40aa(a6, d2.l * 2)
000031B0  addq.w #$1, d6
000031B2  bge.b  $316e
000031B4  ori.b  #$60, d0
000031B8  ; data: 0x2b, 0xe9
000031BA  move.w d7, (a7)
000031BC  subq.l #$3, (invalid.w)
000031C0  ori.b  #$27, d0
000031C4  movea.l $6dfb(pc), a6
000031C8  bra.b  $31cc
000031CA  bvc.b  $323f
000031CC  ori.b  #$f9, d0
000031D0  move.l ([$31d2]), -(a6)
000031D6  ori.b  #$0, d0
000031DA  ; data: 0x0c, 0xd5
000031DC  ; data: 0x2d, 0xc9
000031DE  ; data: 0x37, 0x3d
000031E0  ori.b  #$0, d0
000031E4  ori.b  #$bd, d0
000031E8  movea.l (a5), a7
000031EA  movea.w (a3), a2
000031EC  ori.b  #$0, d0
000031F0  ori.b  #$af, d0
000031F4  move.l a3, -(a7)
000031F6  move.w (a4), $0(a0)
000031FA  ori.b  #$0, d0
000031FE  bclr.b d7, $2dfb(a4)
00003202  move.l a6, (a7, d0.w)
00003206  ori.b  #$0, d0
0000320A  ; data: 0x10, 0x71
0000320C  movea.l d3, a5
0000320E  move.w a5, d0
00003210  ori.b  #$0, d0
00003214  ori.b  #$80, d0
00003218  move.l d3, d3
0000321A  move.w $0(a5), (a0)
0000321E  ori.b  #$0, d0
00003222  move.b (a0)+, (a1)
00003224  move.l ([a5], d3.w), -(a0)
0000322A  ori.b  #$0, d0
0000322E  move.b ([a1]), $3189(a1)
00003234  ori.b  #$0, d0
00003238  ori.b  #$ac, d0
0000323C  move.b (a1)+, (a2)
0000323E  move.w $0(a4), $0.w
00003244  ori.b  #$39, d0
00003248  ; data: 0x15, 0x7d
0000324A  movea.w -(a3), a1
0000324C  ori.b  #$0, d0
00003250  ori.b  #$b3, d0
00003254  move.w (a3, d0.w), (a1)
00003258  ori.b  #$0, d0
0000325C  ori.b  #$f0, d0
00003260  move.w a7, -(a1)
00003262  ori.b  #$0, d0
00003266  ori.b  #$0, d0
0000326A  move.b -(a1), (a4)+
0000326C  move.w a1, $0(a1)
00003270  ori.b  #$0, d0
00003274  ori.b  #$27, d0
00003278  move.w d7, (a1, d0.w)
0000327C  ori.b  #$0, d0
00003280  ori.b  #$71, d0
00003284  move.w (a2, d0.w), (a1, d0.w)
0000328A  ori.b  #$0, d0
0000328E  ; data: 0x1c, 0xbf
00003290  move.w a3, $0.l
00003296  ori.b  #$0, d0
0000329A  ; data: 0x1e, 0x62
0000329C  move.w (a0), $0.l
000032A2  ori.b  #$0, d0
000032A6  move.b ([, d3.w * 2]), (a7, d0.w)
000032B2  move.l (a5), $3385(a0)
000032B6  ori.b  #$0, d0
000032BA  ori.b  #$0, d0
000032BE  move.l d6, $3330(a1)
000032C2  ori.b  #$0, d0
000032C6  ori.b  #$0, d0
000032CA  move.l $32a0(a6), -(a2)
000032CE  ori.b  #$0, d0
000032D2  ori.b  #$0, d0
000032D6  move.l -(a2), ([, d3.w])
000032DE  ori.b  #$0, d0
000032E2  move.l (a1), $2f53(a5)
000032E6  ori.b  #$0, d0
000032EA  ori.b  #$0, d0
000032EE  ori.b  #$0, d0
000032F2  ori.b  #$0, d0
000032F6  ori.b  #$0, d0
000032FA  ori.b  #$0, d0
000032FE  ori.b  #$0, d0
00003302  ori.b  #$0, d0
00003306  ori.b  #$0, d0
0000330A  ori.b  #$0, d0
0000330E  ori.b  #$0, d0
00003312  ori.b  #$0, d0
00003316  ori.b  #$0, d0
0000331A  ori.b  #$0, d0
0000331E  ori.b  #$0, d0
00003322  ori.b  #$0, d0
00003326  ori.b  #$0, d0
0000332A  ori.b  #$0, d0
0000332E  ori.b  #$0, d0
00003332  ori.b  #$0, d0
00003336  ori.b  #$0, d0
0000333A  ori.b  #$0, d0
0000333E  ori.b  #$0, d0
00003342  move.l d4, (a4)+
00003344  movea.l $0(a6), a1
00003348  ori.b  #$0, d0
0000334C  ori.b  #$a2, d0
00003350  move.b -(a1), (a7, d0.w)
00003354  ori.b  #$0, d0
00003358  ori.b  #$90, d0
0000335C  move.b (a5), (a6, d0.w)
00003360  ori.b  #$0, d0
00003364  ori.b  #$32, d0
00003368  ; data: 0x1b, 0xcb
0000336A  ori.b  #$0, d0
0000336E  ori.b  #$0, d0
00003372  move.l (a1)+, (a6)
00003374  ; data: 0x1a, 0x4a
00003376  ori.b  #$0, d0
0000337A  ori.b  #$0, d0
0000337E  move.l -(a4), (a6)+
00003380  ; data: 0x18, 0xc8
00003382  ori.b  #$0, d0
00003386  ori.b  #$0, d0
0000338A  move.l a3, -(a6)
0000338C  ; data: 0x17, 0x48
0000338E  ori.b  #$0, d0
00003392  ori.b  #$0, d0
00003396  move.l -(a0), -(a6)
00003398  move.b (a7), d3
0000339A  ori.b  #$0, d0
0000339E  ori.b  #$0, d0
000033A2  move.l -(a3), -(a6)
000033A4  move.b $0(a2), (a2)+
000033A8  ori.b  #$0, d0
000033AC  ori.b  #$15, d0
000033B0  move.b d0, $0.l
000033B6  ori.b  #$0, d0
000033BA  ; data: 0x2c, 0xff
000033BC  move.b -(a5), (a1)+
000033BE  ori.b  #$0, d0
000033C2  ori.b  #$0, d0
000033C6  move.l (a4), (a6)+
000033C8  move.b d5, $0.w
000033CC  ori.b  #$0, d0
000033D0  ori.b  #$a9, d0
000033D4  move.b $0(a4), (a0)
000033D8  ori.b  #$0, d0
000033DC  ori.b  #$63, d0
000033E0  bset.b d7, (a6)+
000033E2  ori.b  #$0, d0
000033E6  ori.b  #$0, d0
000033EA  move.l -(a5), d6
000033EC  ; data: 0x0e, 0xd2
000033EE  ; data: 0x04, 0x0f
000033F0  ori.b  #$0, d0
000033F4  ori.b  #$df, d0
000033F8  move.b d3, $e(a1, d0.l)
000033FC  ori.b  #$0, d0
00003400  ori.b  #$77, d0
00003404  move.b ([a7, d0.l * 4]), -(a5)
00003408  ori.b  #$0, d0
0000340C  ori.b  #$21, d0
00003410  move.l a6, -(a0)
00003412  cmpi.w #$0, (a1)+
00003416  ori.b  #$0, d0
0000341A  move.l d5, (a5)+
0000341C  ; data: 0x25, 0xdd
0000341E  bchg.b d5, $0(a4)
00003422  ori.b  #$0, d0
00003426  move.l (a6)+, d5
00003428  movea.l -(a4), a5
0000342A  ; data: 0x0a, 0xc0
0000342C  ori.b  #$0, d0
00003430  ori.b  #$d7, d0
00003434  ; data: 0x29, 0xdb
00003436  bset.b d4, -(a4)
00003438  ori.b  #$0, d0
0000343C  ori.b  #$31, d0
00003440  move.l ([a0]), $0(a4)
00003446  ori.b  #$0, d0
0000344A  bcs.b  $3467
0000344C  subq.w #$5, (a3)+
0000344E  move.w ([a0, d2.l]), d2
00003452  ; data: 0x08, 0x7a
00003454  ori.b  #$ae, d0
00003458  addq.l #$2, (a7, d3.w * 8)
0000345C  movea.l $7b8(a1), a4
00003460  ori.b  #$6a, d0
00003464  chk.w  d2, d7
00003466  move.w $7010000(invalid.w), $7a(a4, d6.l)
00003470  dc.w   $4b2d
00003472  move.w (a6), d6
00003474  ; data: 0x27, 0x7f
00003476  addi.w #$0, (a2)
0000347A  bvc.b  $3495
0000347C  ; data: 0x47, 0x53
0000347E  movea.w $26e1(a1), a7
00003482  bclr.b d2, d5
00003484  ori.b  #$6d, d0
00003488  ; data: 0x43, 0x77
0000348A  ; data: 0x40, 0x8c
0000348C  movea.l d5, a3
0000348E  dc.w   $4eb
00003490  ori.b  #$71, d0
00003494  clr.l  (a7)+
00003496  negx.b ([])
0000349A  subi.b #$0, (a2)
0000349E  bcs.b  $3505
000034A0  neg.l  d6
000034A2  move.w ([$34a34a4, pc, d2.w * 4], $6427), (a6)+
000034AC  not.w  d1
000034AE  ; data: 0x39, 0xdc
000034B0  move.l d6, (a2)
000034B2  andi.w #$0, -$46(a2, d6.w)
000034B8  lea.l  $365d(a7), a3
000034BC  ; data: 0x23, 0xfe
000034BE  btst.l d0, #$6176
000034C4  ; data: 0x49, 0x8e
000034C6  move.w d5, ([a1])
000034CE  ; data: 0x5f, 0xbb
000034D0  dc.w   $4b06
000034D2  movea.w $22d8(a2), a0
000034D6  ori.b  #$0, d0
000034DA  slt.b  (a4)+
000034DC  ; data: 0x4c, 0x70
000034DE  move.l (a0), $4f(a6, d2.w)
000034E2  ori.b  #$0, d0
000034E6  addq.w #$6, d5
000034E8  ; data: 0x4d, 0xce
000034EA  move.l -(a6), (a5)
000034EC  move.l $0(a3), $0.w
000034F2  addq.b #$5, $4f1d(a5)
000034F6  move.l a7, ([, d2.w])
000034FE  addq.w #$4, $504a(a7)
00003502  move.l a4, $22480000.l
00003508  ori.b  #$30, d0
0000350C  subq.w #$8, $0(a3)
00003510  ori.b  #$0, d0
00003514  ori.b  #$e1, d0
00003518  ; data: 0x52, 0x7f
0000351A  ori.b  #$0, d0
0000351E  ori.b  #$0, d0
00003522  subq.l #$1, d6
00003524  subq.l #$8, a0
00003526  ori.b  #$0, d0
0000352A  ori.b  #$0, d0
0000352E  addq.l #$2, d1
00003530  chk.w  -(a3), d7
00003532  ori.b  #$0, d0
00003536  ori.b  #$0, d0
0000353A  subq.w #$2, (a6)+
0000353C  ; data: 0x4d, 0x46
0000353E  ori.b  #$0, d0
00003542  ori.b  #$0, d0
00003546  addq.w #$3, d0
00003548  tst.w  $0.w
0000354C  ori.b  #$0, d0
00003550  ori.b  #$5, d0
00003554  nbcd.b $0(a6)
00003558  ori.b  #$0, d0
0000355C  ori.b  #$c0, d0
00003560  chk.w  d7, d2
00003562  ori.b  #$0, d0
00003566  ori.b  #$0, d0
0000356A  addq.w #$4, $4301(a6)
0000356E  ori.b  #$0, d0
00003572  ori.b  #$0, d0
00003576  subq.b #$4, (a1)
00003578  ; data: 0x40, 0x48
0000357A  ori.b  #$0, d0
0000357E  ori.b  #$0, d0
00003582  subq.l #$4, $3dd7(a1)
00003586  ori.b  #$0, d0
0000358A  ori.b  #$0, d0
0000358E  addq.b #$5, $3b74(a2)
00003592  ori.b  #$0, d0
00003596  ori.b  #$0, d0
0000359A  addq.l #$5, $392b(a2)
0000359E  ori.b  #$0, d0
000035A2  ori.b  #$0, d0
000035A6  subq.b #$5, (a7)+
000035A8  move.w d3, (a3, d0.w)
000035AC  ori.b  #$0, d0
000035B0  ori.b  #$80, d0
000035B4  movea.w $0(a5), a4
000035B8  ori.b  #$0, d0
000035BC  ori.b  #$dd, d0
000035C0  sne.b  (a1, d0.w)
000035C4  ori.b  #$0, d0
000035C8  ori.b  #$e, d0
000035CC  addq.b #$6, $0(a1)
000035D0  ori.b  #$0, d0
000035D4  ori.b  #$8c, d0
000035D8  addq.w #$6, $0(a7)
000035DC  ori.b  #$0, d0
000035E0  ori.b  #$da, d0
000035E4  addq.l #$6, -(a5)
000035E6  ori.b  #$0, d0
000035EA  ori.b  #$0, d0
000035EE  moveq  #$29, d5
000035F0  sge.b  (a0)
000035F2  ori.b  #$0, d0
000035F6  ori.b  #$0, d0
000035FA  ; data: 0x7d, 0x1f
000035FC  sge.b  (a4, d0.w)
00003600  ori.b  #$0, d0
00003604  ori.b  #$ec, d0
00003608  ; data: 0x5d, 0x09
0000360A  ori.b  #$0, d0
0000360E  ori.b  #$0, d0
00003612  ; data: 0x7f, 0xdc
00003614  subq.b #$6, (a5)
00003616  ori.b  #$0, d0
0000361A  ori.b  #$0, d0
0000361E  subq.b #$6, (a5)
00003620  ; data: 0x7f, 0xe8
00003622  ori.b  #$0, d0
00003626  ori.b  #$0, d0
0000362A  ; data: 0x5d, 0x0b
0000362C  ; data: 0x7f, 0x12
0000362E  ori.b  #$0, d0
00003632  ori.b  #$0, d0
00003636  sge.b  ([a6])
0000363A  ori.b  #$0, d0
0000363E  ori.b  #$0, d0
00003642  sge.b  (a3)
00003644  moveq  #$80, d5
00003646  ori.b  #$0, d0
0000364A  ori.b  #$0, d0
0000364E  addq.l #$6, $7649(a1)
00003652  ori.b  #$0, d0
00003656  ori.b  #$0, d0
0000365A  addq.w #$6, $12(a4, d7.w)
0000365E  ori.b  #$0, d0
00003662  ori.b  #$0, d0
00003666  addq.b #$6, $67a7(a7)
0000366A  ori.b  #$0, d0
0000366E  ori.b  #$0, d0
00003672  subq.l #$3, (a0)
00003674  smi.b  -(a4)
00003676  ori.b  #$0, d0
0000367A  ori.b  #$0, d0
0000367E  move.w (a5), (a4)
00003680  subq.l #$5, a0
00003682  ori.b  #$0, d0
00003686  ori.b  #$0, d0
0000368A  move.w ([a3], d5.l * 2), $0(a3)
00003696  ; data: 0x38, 0xfd
00003698  addq.l #$5, (a4, d0.w)
0000369C  ori.b  #$0, d0
000036A0  ori.b  #$30, d0
000036A4  addq.b #$5, (a4, d0.w)
000036A8  ori.b  #$0, d0
000036AC  ori.b  #$84, d0
000036B0  subq.l #$4, (a4, d0.w)
000036B4  ori.b  #$0, d0
000036B8  ori.b  #$ea, d0
000036BC  subq.b #$4, (a5)+
000036BE  ori.b  #$0, d0
000036C2  ori.b  #$0, d0
000036C6  clr.l  (a2)+
000036C8  ; data: 0x58, 0x7b
000036CA  ori.b  #$0, d0
000036CE  ori.b  #$0, d0
000036D2  dc.w   $4518
000036D4  dbeq   d6, $36d6
000036D8  ori.b  #$0, d0
000036DC  ori.b  #$bb, d0
000036E0  subq.b #$3, (a4)
000036E2  ori.b  #$0, d0
000036E6  ori.b  #$0, d0
000036EA  tst.b  d2
000036EC  addq.w #$3, a7
000036EE  ori.b  #$0, d0
000036F2  ori.b  #$0, d0
000036F6  ; data: 0x4c, 0xce
000036F8  subq.w #$2, $0(a7)
000036FC  ori.b  #$0, d0
00003700  ori.b  #$2a, d0
00003704  addq.l #$2, (a2)
00003706  ori.b  #$0, d0
0000370A  ori.b  #$0, d0
0000370E  ; data: 0x51, 0x0f
00003710  subq.l #$1, (a0)+
00003712  ori.b  #$0, d0
00003716  ori.b  #$0, d0
0000371A  addq.l #$1, (a2)
0000371C  subq.w #$1, $0(a1)
00003720  ori.b  #$0, d0
00003724  ori.b  #$7f, d0
00003728  ; data: 0x55, 0xbb
0000372A  ori.b  #$0, d0
0000372E  ori.b  #$0, d0
00003732  movea.l -(a0), a1
00003734  move.l $505f.w, $57fe0000.l
0000373C  ori.b  #$a1, d0
00003740  ; data: 0x27, 0xd6
00003742  dc.w   $4f33
00003744  ; data: 0x59, 0xbf
00003746  ori.b  #$0, d0
0000374A  move.l (a6)+, $2afe.w
0000374E  ; data: 0x4d, 0xe5
00003750  smi.b  (a4)+
00003752  ori.b  #$0, d0
00003756  move.l #$2df44c88, d1
0000375C  subq.w #$6, $0.w
00003760  ori.b  #$bf, d0
00003764  move.w (a0)+, (a0)+
00003766  dc.w   $4b1e
00003768  subq.w #$7, (a6)+
0000376A  ori.b  #$0, d0
0000376E  move.l d5, $33fc(a1)
00003772  chk.w  -(a7), d4
00003774  bsr.b  $3796
00003776  ori.b  #$0, d0
0000377A  bchg.b d0, (a7)
0000377C  move.l (a6)+, $36da4809.l
00003782  bhi.b  $37ef
00003784  ori.b  #$90, d0
00003788  movea.l -(a3), a2
0000378A  movea.w (a7)+, a5
0000378C  not.w  (a4)+
0000378E  bls.b  $3772
00003790  ori.b  #$6a, d0
00003794  move.l (a5), -(a2)
00003796  move.w d3, -$5e(a6, d4.w)
0000379A  bcs.b  $37c6
0000379C  ori.b  #$35, d0
000037A0  move.l $40bc(a3), -$44(a2, d4.w)
000037A6  bne.b  $37e8
000037A8  ori.b  #$11, d0
000037AC  move.l (a6)+, d3
000037AE  negx.l $4404(a2)
000037B2  beq.b  $37fc
000037B4  ori.b  #$ad, d0
000037B8  move.l $7641(pc), (a3)
000037BC  ; data: 0x47, 0xe0
000037BE  bvc.b  $37c2
000037C0  ori.b  #$7d, d0
000037C4  move.l (a7), $3c35(a3)
000037C8  chk.w  $68730000.l, d5
000037CE  btst.l d3, $27cd(a6)
000037D2  ; data: 0x39, 0xd2
000037D4  ; data: 0x50, 0x0b
000037D6  bvc.b  $384b
000037D8  ori.b  #$e8, d0
000037DC  movea.l d2, a4
000037DE  ; data: 0x37, 0x3d
000037E0  subq.b #$2, $67cc.w
000037E4  ori.b  #$ac, d0
000037E8  move.l (a3)+, (a4)+
000037EA  movea.w (a3), a2
000037EC  dbmi   d3, $9d46
000037F0  ori.b  #$79, d0
000037F4  move.l a3, $3154(a4)
000037F8  ori.b  #$0, d0
000037FC  ori.b  #$1a, d0
00003800  move.l $2dfb.w, (a4, d0.w)
00003806  ori.b  #$0, d0
0000380A  ; data: 0x0a, 0xf9
0000380C  movea.l d3, a5
0000380E  movea.l d3, a5
00003810  ori.b  #$0, d0
00003814  ori.b  #$a6, d0
00003818  move.l d3, d3
0000381A  move.l -(a6), (a5)
0000381C  ori.b  #$0, d0
00003820  ori.b  #$96, d0
00003824  move.l ([a5, d2.l * 2]), -(a0)
0000382C  ori.b  #$4f, d0
00003830  move.b (a7)+, $2b5b(a5)
00003834  ori.b  #$0, d0
00003838  ori.b  #$4f, d0
0000383C  move.b $2bc6(a4), (a1, d0.w)
00003842  ori.b  #$0, d0
00003846  subi.b #$14, $2c0e0000.l
0000384E  ori.b  #$0, d0
00003852  move.b -(a2), d0
00003854  movea.l a7, a6
00003856  ori.b  #$0, d0
0000385A  ori.b  #$0, d0
0000385E  move.b -$67(a2, d2.l), (a0)+
00003862  ori.b  #$0, d0
00003866  ori.b  #$0, d0
0000386A  ; data: 0x12, 0x0c
0000386C  move.l d7, (a6)+
0000386E  ori.b  #$0, d0
00003872  ori.b  #$0, d0
00003876  move.b $2cf6(a6), -(a1)
0000387A  ori.b  #$0, d0
0000387E  ori.b  #$0, d0
00003882  ; data: 0x14, 0x0a
00003884  move.l a7, -(a6)
00003886  ori.b  #$0, d0
0000388A  ori.b  #$0, d0
0000388E  move.b ([a5, d2.l * 4]), -(a2)
00003894  ori.b  #$0, d0
00003898  ori.b  #$63, d0
0000389C  move.l -(a2), -(a6)
0000389E  ori.b  #$0, d0
000038A2  ori.b  #$0, d0
000038A6  move.b (a5), ([a3, d2.l * 4])
000038AC  ori.b  #$0, d0
000038B0  ori.b  #$15, d0
000038B4  move.l $0(a7), (a6)+
000038B8  ori.b  #$0, d0
000038BC  ori.b  #$97, d0
000038C0  move.l $0(a2), (a6)
000038C4  ori.b  #$0, d0
000038C8  ori.b  #$18, d0
000038CC  movea.l a1, a6
000038CE  ori.b  #$0, d0
000038D2  ori.b  #$0, d0
000038D6  ; data: 0x1d, 0xe1
000038D8  move.l $0(a6), (a5, d0.w)
000038DE  ori.b  #$0, d0
000038E2  ; data: 0x1f, 0xeb
000038E4  move.l d7, (a5)+
000038E6  ori.b  #$0, d0
000038EA  ori.b  #$0, d0
000038EE  move.l -$c(a3, d2.l), (a1)
000038F2  ori.b  #$0, d0
000038F6  ori.b  #$0, d0
000038FA  ori.b  #$0, d0
000038FE  ori.b  #$0, d0
00003902  ori.b  #$0, d0
00003906  ori.b  #$0, d0
0000390A  ori.b  #$0, d0
0000390E  ori.b  #$0, d0
00003912  ori.b  #$0, d0
00003916  ori.b  #$0, d0
0000391A  ori.b  #$0, d0
0000391E  ori.b  #$0, d0
00003922  ori.b  #$0, d0
00003926  ori.b  #$0, d0
0000392A  ori.b  #$0, d0
0000392E  ori.b  #$0, d0
00003932  ori.b  #$0, d0
00003936  ori.b  #$0, d0
0000393A  ori.b  #$0, d0
0000393E  ori.b  #$0, d0
00003942  ori.b  #$0, d0
00003946  ori.b  #$0, d0
0000394A  ori.b  #$0, d0
0000394E  move.l (a6)+, -(a7)
00003950  move.l a4, -(a5)
00003952  ori.b  #$0, d0
00003956  ori.b  #$0, d0
0000395A  move.w ([a5]), $0(a0)
00003960  ori.b  #$0, d0
00003964  ori.b  #$84, d0
00003968  move.l (a6)+, (a2)+
0000396A  ori.b  #$0, d0
0000396E  ori.b  #$0, d0
00003972  move.w (a3)+, -(a1)
00003974  move.l (a4, d0.w), (a1)+
00003978  ori.b  #$0, d0
0000397C  ori.b  #$77, d0
00003980  move.l d1, -(a0)
00003982  ori.b  #$0, d0
00003986  ori.b  #$0, d0
0000398A  move.w ([a2]), (a1, d0.w)
00003990  ori.b  #$0, d0
00003994  ori.b  #$ce, d0
00003998  ; data: 0x1e, 0x0e
0000399A  ori.b  #$0, d0
0000399E  ori.b  #$0, d0
000039A2  move.w a6, $1c6b0000.l
000039A8  ori.b  #$0, d0
000039AC  ori.b  #$ba, d0
000039B0  move.b (a7)+, -(a5)
000039B2  ori.b  #$0, d0
000039B6  ori.b  #$0, d0
000039BA  move.w (a4), ([])
000039BE  ori.b  #$0, d0
000039C2  ori.b  #$0, d0
000039C6  move.w (a2)+, $1890(a1)
000039CA  ori.b  #$0, d0
000039CE  ori.b  #$0, d0
000039D2  move.w -(a3), -(a1)
000039D4  move.b -(a0), (a3, d0.w)
000039D8  ori.b  #$0, d0
000039DC  ori.b  #$cb, d0
000039E0  ; data: 0x16, 0x65
000039E2  ori.b  #$0, d0
000039E6  ori.b  #$0, d0
000039EA  ; data: 0x32, 0x7f
000039EC  move.b $f(a1, d0.w), -(a2)
000039F0  ori.b  #$0, d0
000039F4  ori.b  #$b, d0
000039F8  ; data: 0x14, 0x4e
000039FA  move.b d3, (a1, d0.w)
000039FE  ori.b  #$0, d0
00003A02  move.w $1b37(a2), (a0, d1.w * 2)
00003A0A  ori.b  #$0, d0
00003A0E  move.w d3, $210e(a0)
00003A12  ; data: 0x12, 0x51
00003A14  ori.b  #$0, d0
00003A18  ori.b  #$d4, d0
00003A1C  ; data: 0x25, 0xdd
00003A1E  move.b $3a20(pc,d0.w), -(a0)
00003A22  ori.b  #$0, d0
00003A26  move.w $1e(a6, d2.l), d0
00003A2A  move.b $0(a7), d0
00003A2E  ori.b  #$0, d0
00003A32  move.l $2dd70f6c.l, (a7, d0.w)
00003A3A  ori.b  #$0, d0
00003A3E  move.w ([$e720000, a1], d2.l * 8), -(a0)
00003A4A  move.w -$7d(a0, d2.l), d2
00003A4E  bclr.b d6, d2
00003A50  ori.b  #$0, d0
00003A54  ori.b  #$1c, d0
00003A58  ; data: 0x2d, 0xf8
00003A5A  cmpi.l #$0, (a5)+
00003A60  ori.b  #$b2, d0
00003A64  move.l $bc3(a2), $0(a6)
00003A6A  ori.b  #$0, d0
00003A6E  bvc.b  $3a9b
00003A70  subq.l #$7, a7
00003A72  move.w (a6), d6
00003A74  move.l $af4(a2), (a6)
00003A78  ori.b  #$ab, d0
00003A7C  subq.b #$3, $3e69(a2)
00003A80  move.l (a1)+, d6
00003A82  eori.b #$0, -$52(a0, d6.l)
00003A88  subq.l #$8, -$74(a7, d4.w)
00003A8C  move.l (a0)+, $949(a5)
00003A90  ori.b  #$cf, d0
00003A94  ; data: 0x4c, 0xa5
00003A96  clr.l  (a7)+
00003A98  move.l (a0)+, (a5)
00003A9A  ; data: 0x08, 0x49
00003A9C  ori.b  #$6d, d0
00003AA0  movem.w d1-d2/d7/a2/a6, $2a0a(a1)
00003AA6  bchg.b d3, (a7)+
00003AA8  ; data: 0x00, 0x8d
00003AAA  bmi.b  $3a69
00003AAC  not.w  d1
00003AAE  neg.l  ([a3])
00003AB2  addi.w #$148, -(a6)
00003AB6  bpl.b  $3a72
00003AB8  lea.l  $40d0(a7), a3
00003ABC  movea.l ([$25f, a3, d0.w * 4]), a4
00003AC2  bvs.b  $3a6a
00003AC4  ; data: 0x49, 0x8e
00003AC6  move.w a3, -(a6)
00003AC8  ; data: 0x27, 0xcc
00003ACA  ori.b  #$0, d0
00003ACE  bvc.b  $3ae5
00003AD0  dc.w   $4b06
00003AD2  move.w ([a0, d2.w * 8]), $0(a4)
00003ADA  bne.b  $3a6d
00003ADC  ; data: 0x4c, 0x70
00003ADE  move.w a2, d3
00003AE0  movea.l (a5)+, a3
00003AE2  ori.b  #$0, d0
00003AE6  bcc.b  $3ac7
00003AE8  ; data: 0x4d, 0xce
00003AEA  movea.w (d2.w * 4), a1
00003AF0  ori.b  #$4, d0
00003AF4  dc.w   $4f1d
00003AF6  move.l $25110000.l, -(a7)
00003AFC  ori.b  #$2, d0
00003B00  addq.w #$8, a2
00003B02  ; data: 0x2b, 0xc0
00003B04  move.l $0(a5), (a2)
00003B08  ori.b  #$e0, d0
00003B0C  subq.w #$8, $279b(a3)
00003B10  move.l -(a1), (a2)+
00003B12  ori.b  #$0, d0
00003B16  subq.b #$6, (a6)
00003B18  ; data: 0x52, 0x7f
00003B1A  ori.b  #$0, d0
00003B1E  ori.b  #$0, d0
00003B22  spl.b  d4
00003B24  subq.l #$1, d6
00003B26  ori.b  #$0, d0
00003B2A  ori.b  #$0, d0
00003B2E  addq.w #$4, -(a0)
00003B30  addq.l #$2, d1
00003B32  ori.b  #$0, d0
00003B36  ori.b  #$0, d0
00003B3A  subq.w #$2, (a6)+
00003B3C  scs.b  $0(a5)
00003B40  ori.b  #$0, d0
00003B44  ori.b  #$40, d0
00003B48  shi.b  (a3, d0.w)
00003B4C  ori.b  #$0, d0
00003B50  ori.b  #$5, d0
00003B54  addq.w #$8, (a6, d0.w)
00003B58  ori.b  #$0, d0
00003B5C  ori.b  #$c0, d0
00003B60  ; data: 0x4d, 0xfd
00003B62  ori.b  #$0, d0
00003B66  ori.b  #$0, d0
00003B6A  addq.w #$4, $4b13(a6)
00003B6E  ori.b  #$0, d0
00003B72  ori.b  #$0, d0
00003B76  subq.b #$4, (a1)
00003B78  swap   d1
00003B7A  ori.b  #$0, d0
00003B7E  ori.b  #$0, d0
00003B82  subq.l #$4, $4522(a1)
00003B86  ori.b  #$0, d0
00003B8A  ori.b  #$0, d0
00003B8E  addq.b #$5, $423e(a2)
00003B92  ori.b  #$0, d0
00003B96  ori.b  #$0, d0
00003B9A  addq.l #$5, $3f4b(a2)
00003B9E  ori.b  #$0, d0
00003BA2  ori.b  #$0, d0
00003BA6  subq.b #$5, (a7)+
00003BA8  move.w d3, (a6)
00003BAA  ori.b  #$0, d0
00003BAE  ori.b  #$0, d0
00003BB2  subq.l #$5, d0
00003BB4  ; data: 0x39, 0xd5
00003BB6  ori.b  #$0, d0
00003BBA  ori.b  #$0, d0
00003BBE  smi.b  (a5)+
00003BC0  movea.w -(a2), a4
00003BC2  ori.b  #$0, d0
00003BC6  ori.b  #$0, d0
00003BCA  addq.b #$6, $3aa8(a1)
00003BCE  ori.b  #$0, d0
00003BD2  ori.b  #$0, d0
00003BD6  addq.w #$6, $4ad3(a7)
00003BDA  ori.b  #$0, d0
00003BDE  ori.b  #$0, d0
00003BE2  addq.l #$6, -(a5)
00003BE4  dbpl   d7, $3be6
00003BE8  ori.b  #$0, d0
00003BEC  ori.b  #$49, d0
00003BF0  sge.b  (a0)
00003BF2  ori.b  #$0, d0
00003BF6  ori.b  #$0, d0
00003BFA  bge.b  $3bcd
00003BFC  sge.b  (a4, d0.w)
00003C00  ori.b  #$0, d0
00003C04  ori.b  #$4, d0
00003C08  ; data: 0x5d, 0x09
00003C0A  ori.b  #$0, d0
00003C0E  ori.b  #$0, d0
00003C12  ; data: 0x77, 0x6e
00003C14  subq.b #$6, (a5)
00003C16  ori.b  #$0, d0
00003C1A  ori.b  #$0, d0
00003C1E  subq.b #$6, (a5)
00003C20  moveq  #$b0, d5
00003C22  ori.b  #$0, d0
00003C26  ori.b  #$0, d0
00003C2A  ; data: 0x5d, 0x0b
00003C2C  ; data: 0x7d, 0x30
00003C2E  ori.b  #$0, d0
00003C32  ori.b  #$0, d0
00003C36  sge.b  -$22(a6, d7.l)
00003C3A  ori.b  #$0, d0
00003C3E  ori.b  #$0, d0
00003C42  sge.b  (a3)
00003C44  ; data: 0x7f, 0xad
00003C46  ori.b  #$0, d0
00003C4A  ori.b  #$0, d0
00003C4E  addq.l #$6, $7f99(a1)
00003C52  ori.b  #$0, d0
00003C56  ori.b  #$0, d0
00003C5A  addq.w #$6, -$5d(a4, d7.l)
00003C5E  ori.b  #$0, d0
00003C62  ori.b  #$0, d0
00003C66  addq.b #$6, $7c8f(a7)
00003C6A  ori.b  #$0, d0
00003C6E  ori.b  #$0, d0
00003C72  smi.b  -(a4)
00003C74  ; data: 0x79, 0x1e
00003C76  ori.b  #$0, d0
00003C7A  ori.b  #$0, d0
00003C7E  subq.l #$5, a0
00003C80  ; data: 0x73, 0xac
00003C82  ori.b  #$0, d0
00003C86  ori.b  #$0, d0
00003C8A  subq.b #$5, -(a7)
00003C8C  bvs.b  $3c25
00003C8E  ori.b  #$0, d0
00003C92  ori.b  #$0, d0
00003C96  movea.w -(a7), a3
00003C98  addq.l #$5, (a4, d0.w)
00003C9C  ori.b  #$0, d0
00003CA0  ori.b  #$6b, d0
00003CA4  addq.b #$5, (a4, d0.w)
00003CA8  ori.b  #$0, d0
00003CAC  ori.b  #$e8, d0
00003CB0  subq.l #$4, (a4, d0.w)
00003CB4  ori.b  #$0, d0
00003CB8  ori.b  #$e1, d0
00003CBC  subq.b #$4, (a5)+
00003CBE  ori.b  #$0, d0
00003CC2  ori.b  #$0, d0
00003CC6  move.w -(a4), d6
00003CC8  ; data: 0x58, 0x7b
00003CCA  ori.b  #$0, d0
00003CCE  ori.b  #$0, d0
00003CD2  move.w (a4)+, d7
00003CD4  dbeq   d6, $3cd6
00003CD8  ori.b  #$0, d0
00003CDC  ori.b  #$a9, d0
00003CE0  subq.b #$3, (a4)
00003CE2  ori.b  #$0, d0
00003CE6  ori.b  #$0, d0
00003CEA  clr.l  (a7)+
00003CEC  addq.w #$3, a7
00003CEE  ori.b  #$0, d0
00003CF2  ori.b  #$0, d0
00003CF6  dc.w   $451a
00003CF8  subq.w #$2, $0(a7)
00003CFC  ori.b  #$0, d0
00003D00  ori.b  #$3f, d0
00003D04  addq.l #$2, (a2)
00003D06  ori.b  #$0, d0
00003D0A  ori.b  #$0, d0
00003D0E  ; data: 0x49, 0x71
00003D10  subq.l #$1, (a0)+
00003D12  ori.b  #$0, d0
00003D16  ori.b  #$0, d0
00003D1A  chk.w  $5292(a3), d5
00003D1E  ori.b  #$0, d0
00003D22  ori.b  #$0, d0
00003D26  ; data: 0x4d, 0x75
00003D28  ; data: 0x51, 0x7f
00003D2A  ori.b  #$0, d0
00003D2E  ori.b  #$0, d0
00003D32  chk.w  $505f(a7), d7
00003D36  ori.b  #$0, d0
00003D3A  ori.b  #$0, d0
00003D3E  move.b (a0), $52(a7, d2.w)
00003D42  dc.w   $4f33
00003D44  subq.w #$8, (a1, d0.w)
00003D48  ori.b  #$7d, d0
00003D4C  move.l -(a6), d2
00003D4E  ; data: 0x4d, 0xe5
00003D50  subq.b #$1, $0(a5)
00003D54  ori.b  #$92, d0
00003D58  move.l a5, -(a3)
00003D5A  ; data: 0x4c, 0x88
00003D5C  subq.w #$2, a1
00003D5E  ori.b  #$0, d0
00003D62  move.b (a3)+, (a7)+
00003D64  ; data: 0x29, 0xca
00003D66  dc.w   $4b1e
00003D68  sne.b  $0(a2)
00003D6C  ori.b  #$3d, d0
00003D70  move.l (a4), d6
00003D72  chk.w  -(a7), d4
00003D74  ; data: 0x58, 0x7b
00003D76  ori.b  #$0, d0
00003D7A  move.b -(a4), -$5(a7, d2.l)
00003D7E  dc.w   $4809
00003D80  addq.w #$5, (a7)
00003D82  ori.b  #$0, d0
00003D86  move.l (a3)+, d0
00003D88  move.w -(a6), $5c(a0, d4.w)
00003D8C  ; data: 0x5b, 0xbd
00003D8E  ori.b  #$0, d0
00003D92  move.l d3, (a0)
00003D94  move.w $3d38(pc, d4.w), $5d5b0000.l
00003D9C  ori.b  #$1d, d0
00003DA0  move.l -$19(a2, d3.w), (a0)+
00003DA4  ; data: 0x42, 0xbc
00003DA6  addq.l #$7, a3
00003DA8  ori.b  #$b4, d0
00003DAC  move.l -(a6), $39ee(a0)
00003DB0  negx.l $5fdf(a2)
00003DB4  ori.b  #$54, d0
00003DB8  move.l (a5)+, $3c83.w
00003DBC  move.w d7, (a7)
00003DBE  bsr.b  $3dc6
00003DC0  ori.b  #$dd, d0
00003DC4  move.l $3c35.w, d1
00003DC8  move.w $61fd(a3), (a7, d0.w)
00003DCE  andi.w #$22b1, $39d2(a4)
00003DD4  dc.w   $42db
00003DD6  bhi.b  $3d99
00003DD8  ori.b  #$4, d0
00003DDC  move.l a3, -(a1)
00003DDE  ; data: 0x37, 0x3d
00003DE0  ; data: 0x46, 0x0c
00003DE2  bls.b  $3e4b
00003DE4  ori.b  #$a3, d0
00003DE8  move.l d1, $53(a1, d3.w)
00003DEC  chk.w  #$63be, d4
00003DF0  ori.b  #$4c, d0
00003DF4  move.l (a7), $31544dd9.l
00003DFA  bls.b  $3dbb
00003DFC  ori.b  #$d0, d0
00003E00  move.l $2dfb(a3), d2
00003E04  addq.w #$1, d2
00003E06  bls.b  $3e28
00003E08  ori.b  #$88, d0
00003E0C  move.l (a5), (a2)
00003E0E  movea.l d3, a5
00003E10  addq.w #$4, -$38(a2, d6.w)
00003E14  ori.b  #$18, d0
00003E18  move.l -(a0), (a2)+
00003E1A  move.l d3, d3
00003E1C  ori.b  #$0, d0
00003E20  ori.b  #$e0, d0
00003E24  move.l ([a5], d2.w * 4), -(a0)
00003E2E  ; data: 0x07, 0x7c
00003E30  move.b (a7)+, $2568(a5)
00003E34  ori.b  #$0, d0
00003E38  ori.b  #$54, d0
00003E3C  move.b $25a4(a4), (a1, d0.w)
00003E42  ori.b  #$0, d0
00003E46  subi.b #$fb, $25ea0000.l
00003E4E  ori.b  #$0, d0
00003E52  bclr.b d4, -(a7)
00003E54  move.l (a7), d3
00003E56  ori.b  #$0, d0
00003E5A  ori.b  #$0, d0
00003E5E  eori.l #$263d0000, (a4)
00003E64  ori.b  #$0, d0
00003E68  ori.b  #$4b, d0
00003E6C  movea.l -(a4), a3
00003E6E  ori.b  #$0, d0
00003E72  ori.b  #$0, d0
00003E76  cmpi.w #$2679, d5
00003E7A  ori.b  #$0, d0
00003E7E  ori.b  #$0, d0
00003E82  btst.l d6, d5
00003E84  move.l d5, (a3)
00003E86  ori.b  #$0, d0
00003E8A  ori.b  #$0, d0
00003E8E  ; data: 0x0e, 0x0a
00003E90  move.l a0, (a3)
00003E92  ori.b  #$0, d0
00003E96  ori.b  #$0, d0
00003E9A  btst.l d7, (a6)
00003E9C  movea.l #$0, a3
00003EA2  ori.b  #$0, d0
00003EA6  move.b -(a6), d0
00003EA8  movea.l -(a0), a3
00003EAA  ori.b  #$0, d0
00003EAE  ori.b  #$0, d0
00003EB2  move.b $64e8(pc), -(a0)
00003EB6  ori.b  #$0, d0
00003EBA  ori.b  #$0, d0
00003EBE  ; data: 0x12, 0x52
00003EC0  ; data: 0x25, 0xf7
00003EC2  ori.b  #$0, d0
00003EC6  ori.b  #$0, d0
00003ECA  move.b ([], d2.w * 4), (a1, d0.w)
00003ED0  ori.b  #$0, d0
00003ED4  ori.b  #$14, d0
00003ED8  move.l (a1)+, -(a2)
00003EDA  ori.b  #$0, d0
00003EDE  ori.b  #$0, d0
00003EE2  move.b #$84, (a3)
00003EE6  ori.b  #$0, d0
00003EEA  ori.b  #$0, d0
00003EEE  move.b -(a5), (a4)
00003EF0  move.l a3, (a1, d0.w)
00003EF4  ori.b  #$0, d0
00003EF8  ori.b  #$4b, d0
00003EFC  move.l (a1)+, $0.w
00003F00  ori.b  #$0, d0
00003F04  ori.b  #$0, d0
00003F08  ori.b  #$0, d0
00003F0C  ori.b  #$0, d0
00003F10  ori.b  #$0, d0
00003F14  ori.b  #$0, d0
00003F18  ori.b  #$0, d0
00003F1C  ori.b  #$0, d0
00003F20  ori.b  #$0, d0
00003F24  ori.b  #$0, d0
00003F28  ori.b  #$0, d0
00003F2C  ori.b  #$0, d0
00003F30  ori.b  #$0, d0
00003F34  ori.b  #$0, d0
00003F38  ori.b  #$0, d0
00003F3C  ori.b  #$0, d0
00003F40  ori.b  #$0, d0
00003F44  ori.b  #$0, d0
00003F48  ori.b  #$0, d0
00003F4C  ori.b  #$0, d0
00003F50  ori.b  #$0, d0
00003F54  ori.b  #$0, d0
00003F58  ori.b  #$0, d0
00003F5C  ori.b  #$0, d0
00003F60  ori.b  #$0, d0
00003F64  ori.b  #$a0, d0
00003F68  ; data: 0x2f, 0xd5
00003F6A  ori.b  #$0, d0
00003F6E  ori.b  #$0, d0
00003F72  move.w (a2)+, -(a4)
00003F74  move.l $0(a2), (a6)
00003F78  ori.b  #$0, d0
00003F7C  ori.b  #$d2, d0
00003F80  movea.l (a1), a5
00003F82  ori.b  #$0, d0
00003F86  ori.b  #$0, d0
00003F8A  move.w $67ca(pc), d5
00003F8E  ori.b  #$0, d0
00003F92  ori.b  #$0, d0
00003F96  movea.w $267c(a2), a5
00003F9A  ori.b  #$0, d0
00003F9E  ori.b  #$0, d0
00003FA2  movea.w -$4a(a7, d2.w), a5
00003FA6  ori.b  #$0, d0
00003FAA  ori.b  #$0, d0
00003FAE  movea.w $22ee(a1), a5
00003FB2  ori.b  #$0, d0
00003FB6  ori.b  #$0, d0
00003FBA  movea.w d5, a5
00003FBC  move.l d3, (a0, d0.w)
00003FC0  ori.b  #$0, d0
00003FC4  ori.b  #$d, d0
00003FC8  move.l (a1)+, d0
00003FCA  ori.b  #$0, d0
00003FCE  ori.b  #$0, d0
00003FD2  ; data: 0x39, 0xbf
00003FD4  move.b (a3, d0.w), (a7)
00003FD8  ori.b  #$0, d0
00003FDC  ori.b  #$5f, d0
00003FE0  move.b (a2), $0(a6)
00003FE4  ori.b  #$0, d0
00003FE8  ori.b  #$a, d0
00003FEC  ; data: 0x1b, 0xf6
00003FEE  ; data: 0x04, 0x0f
00003FF0  ori.b  #$0, d0
00003FF4  ori.b  #$89, d0
00003FF8  move.b -(a0), (a5)
00003FFA  move.b d3, (a1, d0.w)
00003FFE  ori.b  #$0, d0
00004002  move.w (a5)+, d4
00004004  move.b ([], d1.l), -(a5)
0000400A  ori.b  #$0, d0
0000400E  move.w d0, ([a3], d2.w, $185e)
00004014  ori.b  #$0, d0
00004018  ori.b  #$0, d0
0000401C  ; data: 0x25, 0xdd
0000401E  move.b (a7)+, -(a3)
00004020  ori.b  #$0, d0
00004024  ori.b  #$79, d0
00004028  move.l (a6)+, d5
0000402A  move.b (a7, d0.w), d3
0000402E  ori.b  #$0, d0
00004032  move.w $6e0b(pc), ([a2, d1.w * 4], $49)
0000403A  ori.b  #$0, d0
0000403E  move.w -(a4), -(a2)
00004040  move.w $b1(invalid.w), -(a0)
00004046  ori.b  #$0, d0
0000404A  move.w -$78(a0, d3.w), d2
0000404E  move.b (a1), (a1)+
00004050  btst.l d0, (a7, d0.w)
00004054  ori.b  #$1c, d0
00004058  move.w ([]), (d0.w)
00004062  move.w ([a2, d3.w * 2], $10c7022b), (a4, d0.w)
0000406C  ori.b  #$16, d0
00004070  move.w $fd5(a2), d1
00004074  andi.l #$0, (a3)+
0000407A  movea.w $317f(a1), a7
0000407E  ; data: 0x0e, 0xb6
00004080  btst.l d1, d6
00004082  ori.b  #$0, d0
00004086  ; data: 0x40, 0x8c
00004088  move.w (a2)+, (a0)
0000408A  bset.b d6, (a7)+
0000408C  bclr.b d1, d4
0000408E  ori.b  #$0, d0
00004092  bvc.b  $4103
00004094  bne.b  $409c
00004096  clr.l  (a7)+
00004098  ; data: 0x2f, 0xed
0000409A  cmpi.l #$3fb6eff, $3a(a3, d5.l)
000040A2  neg.l  d6
000040A4  move.l a1, -(a7)
000040A6  bclr.b d5, -(a1)
000040A8  subi.l #$70715376, d4
000040AE  not.w  d1
000040B0  move.l $a81(a1), d7
000040B4  movep.w $70c2(a1), d2
000040B8  ; data: 0x4e, 0x39
000040BA  lea.l  $2d4e(a7), a3
000040BE  ; data: 0x09, 0x3d
000040C0  bset.b d2, -(a6)
000040C2  moveq  #$73, d0
000040C4  ; data: 0x49, 0x8e
000040C6  movem.l d1/d3-d6/a2-a3/a5, $0.l
000040CE  ble.b  $40a1
000040D0  dc.w   $4b06
000040D2  neg.w  -(a3)
000040D4  move.l d0, (a5, d0.w)
000040D8  ori.b  #$a6, d0
000040DC  ; data: 0x4c, 0x70
000040DE  ; data: 0x40, 0x7f
000040E0  move.l d5, (a5)+
000040E2  ori.b  #$0, d0
000040E6  blt.b  $4073
000040E8  ; data: 0x4d, 0xce
000040EA  movea.w d1, a6
000040EC  ; data: 0x29, 0xc7
000040EE  ori.b  #$0, d0
000040F2  bmi.b  $40e4
000040F4  dc.w   $4f1d
000040F6  movea.w a3, a4
000040F8  move.l (a0), -(a4)
000040FA  ori.b  #$0, d0
000040FE  bpl.b  $4161
00004100  addq.w #$8, a2
00004102  ; data: 0x34, 0x3e
00004104  movea.l d2, a4
00004106  ori.b  #$0, d0
0000410A  bvc.b  $414f
0000410C  subq.w #$8, $3051(a3)
00004110  move.l -(a7), (a3, d0.w)
00004114  ori.b  #$50, d0
00004118  ; data: 0x52, 0x7f
0000411A  ; data: 0x2b, 0xfb
0000411C  move.l $411e(pc,d0.w), $0(a3)
00004122  bcc.b  $415a
00004124  subq.l #$1, d6
00004126  ori.b  #$0, d0
0000412A  ori.b  #$0, d0
0000412E  bsr.b  $40b4
00004130  addq.l #$2, d1
00004132  ori.b  #$0, d0
00004136  ori.b  #$0, d0
0000413A  subq.b #$7, -(a6)
0000413C  subq.w #$2, (a6)+
0000413E  ori.b  #$0, d0
00004142  ori.b  #$0, d0
00004146  addq.l #$6, $40(a0, d5.w)
0000414A  ori.b  #$0, d0
0000414E  ori.b  #$0, d0
00004152  addq.b #$5, $5705(a1)
00004156  ori.b  #$0, d0
0000415A  ori.b  #$0, d0
0000415E  seq.b  d0
00004160  subq.b #$3, (a1)
00004162  ori.b  #$0, d0
00004166  ori.b  #$0, d0
0000416A  addq.w #$4, $53f2(a6)
0000416E  ori.b  #$0, d0
00004172  ori.b  #$0, d0
00004176  subq.b #$4, (a1)
00004178  st.b   (a5)
0000417A  ori.b  #$0, d0
0000417E  ori.b  #$0, d0
00004182  subq.l #$4, $4dc4(a1)
00004186  ori.b  #$0, d0
0000418A  ori.b  #$0, d0
0000418E  addq.b #$5, $4a4f(a2)
00004192  ori.b  #$0, d0
00004196  ori.b  #$0, d0
0000419A  addq.l #$5, $4706(a2)
0000419E  ori.b  #$0, d0
000041A2  ori.b  #$0, d0
000041A6  subq.b #$5, (a7)+
000041A8  lea.l  $41aa(pc,d0.w), a1
000041AC  ori.b  #$0, d0
000041B0  ori.b  #$80, d0
000041B4  negx.l d0
000041B6  ori.b  #$0, d0
000041BA  ori.b  #$0, d0
000041BE  smi.b  (a5)+
000041C0  move.w (a1), $0(a6)
000041C4  ori.b  #$0, d0
000041C8  ori.b  #$29, d0
000041CC  movea.w (a2, d0.w), a5
000041D0  ori.b  #$0, d0
000041D4  ori.b  #$6f, d0
000041D8  move.w -(a3), -(a4)
000041DA  ori.b  #$0, d0
000041DE  ori.b  #$0, d0
000041E2  addq.l #$6, -(a5)
000041E4  movea.w a1, a6
000041E6  ori.b  #$0, d0
000041EA  ori.b  #$0, d0
000041EE  sge.b  (a0)
000041F0  move.w d5, sr
000041F2  ori.b  #$0, d0
000041F6  ori.b  #$0, d0
000041FA  sge.b  -$46(a4, d5.w)
000041FE  ori.b  #$0, d0
00004202  ori.b  #$0, d0
00004206  ; data: 0x5d, 0x09
00004208  addq.w #$6, $0(a6)
0000420C  ori.b  #$0, d0
00004210  ori.b  #$57, d0
00004214  subq.b #$6, (a5)
00004216  ori.b  #$0, d0
0000421A  ori.b  #$0, d0
0000421E  subq.b #$6, (a5)
00004220  bpl.b  $41db
00004222  ori.b  #$0, d0
00004226  ori.b  #$0, d0
0000422A  ; data: 0x5d, 0x0b
0000422C  moveq  #$10, d0
0000422E  ori.b  #$0, d0
00004232  ori.b  #$0, d0
00004236  sge.b  $58(a6, d7.w)
0000423A  ori.b  #$0, d0
0000423E  ori.b  #$0, d0
00004242  sge.b  (a3)
00004244  moveq  #$4, d4
00004246  ori.b  #$0, d0
0000424A  ori.b  #$0, d0
0000424E  addq.l #$6, $7ab2(a1)
00004252  ori.b  #$0, d0
00004256  ori.b  #$0, d0
0000425A  addq.w #$6, -$6(a4, d7.l)
0000425E  ori.b  #$0, d0
00004262  ori.b  #$0, d0
00004266  addq.b #$6, $7e4f(a7)
0000426A  ori.b  #$0, d0
0000426E  ori.b  #$0, d0
00004272  smi.b  -(a4)
00004274  moveq  #$fd, d7
00004276  ori.b  #$0, d0
0000427A  ori.b  #$0, d0
0000427E  subq.l #$5, a0
00004280  moveq  #$ca, d7
00004282  ori.b  #$0, d0
00004286  ori.b  #$0, d0
0000428A  subq.b #$5, -(a7)
0000428C  ; data: 0x7d, 0x88
0000428E  ori.b  #$0, d0
00004292  ori.b  #$0, d0
00004296  addq.l #$5, ([a4, d7.l * 2])
000042A0  ori.b  #$34, d0
000042A4  moveq  #$c9, d3
000042A6  ori.b  #$0, d0
000042AA  ori.b  #$0, d0
000042AE  move.w (a3), (a2)
000042B0  dc.w   $4913
000042B2  subq.l #$4, ([])
000042B6  ori.b  #$0, d0
000042BA  move.w -(a3), -(a2)
000042BC  subq.b #$4, (a5)+
000042BE  ori.b  #$0, d0
000042C2  ori.b  #$0, d0
000042C6  move.w (a7), (a3)
000042C8  ; data: 0x58, 0x7b
000042CA  ori.b  #$0, d0
000042CE  ori.b  #$0, d0
000042D2  move.w (a2), (a4)
000042D4  dbeq   d6, $42d6
000042D8  ori.b  #$0, d0
000042DC  ori.b  #$80, d0
000042E0  subq.b #$3, (a4)
000042E2  ori.b  #$0, d0
000042E6  ori.b  #$0, d0
000042EA  movea.w -(a3), a6
000042EC  addq.w #$3, a7
000042EE  ori.b  #$0, d0
000042F2  ori.b  #$0, d0
000042F6  movea.w ([a7]), a7
000042FC  ori.b  #$0, d0
00004300  ori.b  #$50, d0
00004304  addq.l #$2, (a2)
00004306  ori.b  #$0, d0
0000430A  ori.b  #$0, d0
0000430E  clr.w  d0
00004310  subq.l #$1, (a0)+
00004312  ori.b  #$0, d0
00004316  ori.b  #$0, d0
0000431A  neg.w  d2
0000431C  addq.l #$1, (a2)
0000431E  ori.b  #$0, d0
00004322  ori.b  #$0, d0
00004326  not.w  (a1)
00004328  ; data: 0x51, 0x7f
0000432A  ori.b  #$0, d0
0000432E  ori.b  #$0, d0
00004332  ; data: 0x47, 0xfc
00004334  addq.w #$8, (a7)+
00004336  ori.b  #$0, d0
0000433A  ori.b  #$0, d0
0000433E  chk.w  $4f33(a1), d4
00004342  ori.b  #$0, d0
00004346  ori.b  #$0, d0
0000434A  move.b d7, d6
0000434C  move.b $4bbf4de5.l, $0(a6)
00004354  ori.b  #$36, d0
00004358  move.l -(a0), (a0)
0000435A  ; data: 0x4c, 0x88
0000435C  ; data: 0x4d, 0x67
0000435E  ori.b  #$0, d0
00004362  move.b ([a6]), -(a5)
00004366  dc.w   $4b1e
00004368  ; data: 0x4f, 0x08
0000436A  ori.b  #$0, d0
0000436E  move.b -(a4), $258e(a5)
00004372  chk.w  -(a7), d4
00004374  addq.l #$8, -(a1)
00004376  ori.b  #$0, d0
0000437A  move.b (a4)+, ([$4809, d2.w * 8], $522d0000)
00004384  ori.b  #$e4, d0
00004388  ; data: 0x29, 0xf5
0000438A  not.w  (a4)+
0000438C  subq.l #$1, $0(a4)
00004390  ori.b  #$38, d0
00004394  movea.l $44a2(a2), a6
00004398  subq.b #$2, (a3)+
0000439A  ori.b  #$0, d0
0000439E  move.b d3, (a6)
000043A0  move.l (a4), (a7)
000043A2  ; data: 0x42, 0xbc
000043A4  dbne   d3, $43a6
000043A8  ori.b  #$d2, d0
000043AC  move.w a4, $40aa(a0)
000043B0  ; data: 0x58, 0x0d
000043B2  ori.b  #$0, d0
000043B6  move.b -(a5), -(a6)
000043B8  move.w -(a7), -$79(a1, d3.l)
000043BC  subq.b #$4, $0.w
000043C0  ori.b  #$7a, d0
000043C4  move.w (a3), d3
000043C6  move.w -$75(a5, d5.l), d6
000043CA  ori.b  #$0, d0
000043CE  move.b $7c5e(pc), ([], $5b7c)
000043D6  ori.b  #$0, d0
000043DA  ; data: 0x1e, 0x0e
000043DC  ; data: 0x37, 0x3d
000043DE  move.w (a3), -(a5)
000043E0  addq.l #$6, d1
000043E2  ori.b  #$0, d0
000043E6  ; data: 0x1e, 0x4c
000043E8  movea.w (a3), a2
000043EA  move.w -(a1), d7
000043EC  subq.w #$6, (a7)
000043EE  ori.b  #$0, d0
000043F2  move.b (a4)+, (a7)
000043F4  move.w (a4), $40af(a0)
000043F8  ; data: 0x5d, 0xfd
000043FA  ori.b  #$0, d0
000043FE  move.b (a5), (a7)+
00004400  ; data: 0x2d, 0xfb
00004402  chk.w  #$5e80, d1
00004406  ori.b  #$0, d0
0000440A  ; data: 0x00, 0x4b
0000440C  ; data: 0x1f, 0x0b
0000440E  movea.l d3, a5
00004410  ; data: 0x47, 0x3f
00004412  addq.l #$7, $be.l
00004418  ; data: 0x1f, 0x3d
0000441A  move.l d3, d3
0000441C  dc.w   $4b21
0000441E  addq.l #$7, (a2)+
00004420  ori.b  #$37, d0
00004424  move.b $655b(pc), $4f43(a7)
0000442A  slt.b  (a2)+
0000442C  ori.b  #$e0, d0
00004430  move.b (a7)+, $1fa3(a5)
00004434  subq.w #$2, (a3)+
00004436  subq.b #$5, -(a6)
00004438  ori.b  #$64, d0
0000443C  move.b $1fc6(a4), (a1, d0.w)
00004442  ori.b  #$0, d0
00004446  ; data: 0x02, 0xed
00004448  subi.b #$e3, $0.l
00004450  ori.b  #$ab, d0
00004454  ; data: 0x1f, 0xfb
00004456  ori.b  #$0, d0
0000445A  ori.b  #$0, d0
0000445E  ; data: 0x04, 0x3f
00004460  move.l (a1), d0
00004462  ori.b  #$0, d0
00004466  ori.b  #$0, d0
0000446A  ; data: 0x04, 0xd8
0000446C  move.l (a1)+, d0
0000446E  ori.b  #$0, d0
00004472  ori.b  #$0, d0
00004476  bclr.b d2, $201b(a3)
0000447A  ori.b  #$0, d0
0000447E  ori.b  #$0, d0
00004482  ; data: 0x06, 0x4e
00004484  move.l (a2), d0
00004486  ori.b  #$0, d0
0000448A  ori.b  #$0, d0
0000448E  btst.l d3, $2002(a7)
00004492  ori.b  #$0, d0
00004496  ori.b  #$0, d0
0000449A  bset.b d3, (a4)+
0000449C  ; data: 0x1f, 0xe1
0000449E  ori.b  #$0, d0
000044A2  ori.b  #$0, d0
000044A6  ; data: 0x08, 0xc8
000044A8  ; data: 0x1f, 0xbf
000044AA  ori.b  #$0, d0
000044AE  ori.b  #$0, d0
000044B2  ; data: 0x09, 0xba
000044B4  move.b d5, (a7, d0.w)
000044B8  ori.b  #$0, d0
000044BC  ori.b  #$b1, d0
000044C0  ; data: 0x1f, 0x3d
000044C2  ori.b  #$0, d0
000044C6  ori.b  #$0, d0
000044CA  bset.b d5, $1ecf(a4)
000044CE  ori.b  #$0, d0
000044D2  ori.b  #$0, d0
000044D6  ; data: 0x0c, 0xec
000044D8  ; data: 0x1e, 0x66
000044DA  ori.b  #$0, d0
000044DE  ori.b  #$0, d0
000044E2  ; data: 0x0e, 0x71
000044E4  ; data: 0x1d, 0xcf
000044E6  ori.b  #$0, d0
000044EA  ori.b  #$0, d0
000044EE  bclr.b d7, -$2(a7, d1.l)
000044F2  ori.b  #$0, d0
000044F6  ori.b  #$0, d0
000044FA  move.b d1, $1be4.w
000044FE  ori.b  #$0, d0
00004502  ori.b  #$0, d0
00004506  ; data: 0x14, 0x3f
00004508  ; data: 0x19, 0xde
0000450A  ori.b  #$0, d0
0000450E  ori.b  #$0, d0
00004512  ori.b  #$0, d0
00004516  ori.b  #$0, d0
0000451A  ori.b  #$0, d0
0000451E  ori.b  #$0, d0
00004522  ori.b  #$0, d0
00004526  ori.b  #$0, d0
0000452A  ori.b  #$0, d0
0000452E  ori.b  #$0, d0
00004532  ori.b  #$0, d0
00004536  ori.b  #$0, d0
0000453A  ori.b  #$0, d0
0000453E  ori.b  #$0, d0
00004542  ori.b  #$0, d0
00004546  ori.b  #$0, d0
0000454A  ori.b  #$0, d0
0000454E  ori.b  #$0, d0
00004552  ori.b  #$0, d0
00004556  ori.b  #$0, d0
0000455A  ori.b  #$0, d0
0000455E  ori.b  #$0, d0
00004562  ori.b  #$0, d0
00004566  ori.b  #$0, d0
0000456A  ori.b  #$0, d0
0000456E  ori.b  #$0, d0
00004572  ori.b  #$0, d0
00004576  ori.b  #$0, d0
0000457A  ori.b  #$0, d0
0000457E  move.w -(a6), (a7)+
00004580  move.w (a0)+, $0(a2)
00004584  ori.b  #$0, d0
00004588  ori.b  #$16, d0
0000458C  movea.w d3, a1
0000458E  ori.b  #$0, d0
00004592  ori.b  #$0, d0
00004596  negx.l $2fbb(a6)
0000459A  ori.b  #$0, d0
0000459E  ori.b  #$0, d0
000045A2  move.w sr, ([])
000045A6  ori.b  #$0, d0
000045AA  ori.b  #$0, d0
000045AE  dc.w   $4107
000045B0  move.l (a2)+, $2e(a5, d0.w)
000045B4  ori.b  #$0, d0
000045B8  ori.b  #$f2, d0
000045BC  move.l -$4b(a0, d0.w), (a4, d0.w)
000045C2  ori.b  #$0, d0
000045C6  move.w sr, d7
000045C8  move.l -(a7), d4
000045CA  bchg.b d0, -(a2)
000045CC  ori.b  #$0, d0
000045D0  ori.b  #$85, d0
000045D4  ; data: 0x26, 0x3d
000045D6  bset.b d0, (a6)+
000045D8  ori.b  #$0, d0
000045DC  ori.b  #$2c, d0
000045E0  move.l $255.w, (a2)
000045E4  ori.b  #$0, d0
000045E8  ori.b  #$be, d0
000045EC  move.l $f(a5, d0.w), -(a1)
000045F0  dc.w   $2ed
000045F2  ori.b  #$0, d0
000045F6  move.w $67b0(pc), -(a7)
000045FA  move.b d3, (a1, invalid.w)
000045FE  ori.b  #$0, d0
00004602  move.w -(a4), (a7)
00004604  movea.l d1, a0
00004606  move.b ([], d0.w * 2, $3e26210e), -(a5)
00004612  move.b (a1), (a7)+
00004614  subi.b #$0, -(a1)
00004618  ori.b  #$70, d0
0000461C  ; data: 0x25, 0xdd
0000461E  ; data: 0x1d, 0xc3
00004620  subi.l #$0, (a4)+
00004626  move.w (a4)+, (a6)+
00004628  move.l (a6)+, d5
0000462A  ; data: 0x1c, 0x62
0000462C  dc.w   $4f3
0000462E  ori.b  #$0, d0
00004632  move.w a3, d6
00004634  ; data: 0x2d, 0xd7
00004636  ; data: 0x1b, 0x0c
00004638  bchg.b d2, d6
0000463A  ori.b  #$0, d0
0000463E  move.w -(a5), $3131(a5)
00004642  ; data: 0x19, 0xc0
00004644  bclr.b d2, $0(a6)
00004648  ori.b  #$7d, d0
0000464C  move.w -$80(a0, d1.l), d2
00004650  ; data: 0x06, 0x0f
00004652  ori.b  #$0, d0
00004656  ; data: 0x39, 0xc8
00004658  move.w (a4)+, -(a3)
0000465A  ; data: 0x17, 0x4c
0000465C  addi.w #$0, (a4)
00004660  ori.b  #$b2, d0
00004664  move.w a6, -(a4)
00004666  move.b -(a4), d3
00004668  addi.l #$0, $3c16(a3)
00004670  move.w (a0), d4
00004672  move.b d5, (a2)+
00004674  ; data: 0x06, 0xfd
00004676  ori.b  #$0, d0
0000467A  movea.w $374d(a1), a7
0000467E  move.b #$4a, (a1, d0.w)
00004684  ori.b  #$8c, d0
00004688  movea.w d6, a3
0000468A  move.b d4, (a1)
0000468C  bclr.b d3, -(a6)
0000468E  ori.b  #$0, d0
00004692  clr.l  (a7)+
00004694  ; data: 0x35, 0x3d
00004696  move.b -(a1), $7fe(a0)
0000469A  ori.b  #$0, d0
0000469E  neg.l  d6
000046A0  movea.w $20(a6, d1.w), a2
000046A4  bchg.b #$0, (a4)
000046A8  ori.b  #$41, d0
000046AC  move.w $ed1(a6), $8cd(a1)
000046B2  ori.b  #$0, d0
000046B6  lea.l  $326a(a7), a3
000046BA  bclr.b d6, d2
000046BC  bchg.b d4, (a6)+
000046BE  ori.b  #$0, d0
000046C2  ; data: 0x71, 0x0a
000046C4  sge.b  -(a2)
000046C6  ; data: 0x49, 0x8e
000046C8  move.w $0(a4), $0(a0)
000046CE  ; data: 0x73, 0x7c
000046D0  scc.b  d0
000046D2  dc.w   $4b06
000046D4  movea.w (a5, d0.w), a0
000046D8  ori.b  #$34, d0
000046DC  ; data: 0x4e, 0xc8
000046DE  ; data: 0x4c, 0x70
000046E0  move.l (a0), $0(a7)
000046E4  ori.b  #$2a, d0
000046E8  ; data: 0x4d, 0xce
000046EA  ; data: 0x48, 0xdb
000046EC  movea.l (a3, d0.w), a7
000046F0  ori.b  #$7b, d0
000046F4  dc.w   $4f1d
000046F6  chk.w  ([a2]), d1
000046FE  moveq  #$8f, d1
00004700  addq.w #$8, a2
00004702  move.w a7, (a7)+
00004704  movea.l -(a4), a6
00004706  ori.b  #$0, d0
0000470A  ; data: 0x71, 0x4d
0000470C  subq.w #$8, $3a49(a3)
00004710  move.l -(a1), $0(a5)
00004714  ori.b  #$b8, d0
00004718  ; data: 0x52, 0x7f
0000471A  ; data: 0x35, 0xcd
0000471C  move.l a6, (a5)
0000471E  ori.b  #$0, d0
00004722  blt.b  $46fa
00004724  subq.l #$1, d6
00004726  move.w $19(a4, d2.l), (a0)+
0000472A  ori.b  #$0, d0
0000472E  bmi.b  $46db
00004730  addq.l #$2, d1
00004732  ori.b  #$0, d0
00004736  ori.b  #$0, d0
0000473A  bvs.b  $477c
0000473C  subq.w #$2, (a6)+
0000473E  ori.b  #$0, d0
00004742  ori.b  #$0, d0
00004746  beq.b  $4758
00004748  addq.w #$3, d0
0000474A  ori.b  #$0, d0
0000474E  ori.b  #$0, d0
00004752  bcc.b  $4796
00004754  subq.b #$3, d5
00004756  ori.b  #$0, d0
0000475A  ori.b  #$0, d0
0000475E  bsr.b  $47aa
00004760  seq.b  d0
00004762  ori.b  #$0, d0
00004766  ori.b  #$0, d0
0000476A  addq.l #$7, $6e(a7, d5.l)
0000476E  ori.b  #$0, d0
00004772  ori.b  #$0, d0
00004776  subq.l #$5, a3
00004778  subq.b #$4, (a1)
0000477A  ori.b  #$0, d0
0000477E  ori.b  #$0, d0
00004782  subq.l #$4, $57c5(a1)
00004786  ori.b  #$0, d0
0000478A  ori.b  #$0, d0
0000478E  addq.b #$5, $5486(a2)
00004792  ori.b  #$0, d0
00004796  ori.b  #$0, d0
0000479A  addq.l #$5, $50c5(a2)
0000479E  ori.b  #$0, d0
000047A2  ori.b  #$0, d0
000047A6  subq.b #$5, (a7)+
000047A8  dc.w   $4d1f
000047AA  ori.b  #$0, d0
000047AE  ori.b  #$0, d0
000047B2  subq.l #$5, d0
000047B4  dc.w   $4928
000047B6  ori.b  #$0, d0
000047BA  ori.b  #$0, d0
000047BE  smi.b  (a5)+
000047C0  ; data: 0x45, 0x7d
000047C2  ori.b  #$0, d0
000047C6  ori.b  #$0, d0
000047CA  addq.b #$6, $4173(a1)
000047CE  ori.b  #$0, d0
000047D2  ori.b  #$0, d0
000047D6  addq.w #$6, $3ddd(a7)
000047DA  ori.b  #$0, d0
000047DE  ori.b  #$0, d0
000047E2  addq.l #$6, -(a5)
000047E4  move.w (a5), (a5)+
000047E6  ori.b  #$0, d0
000047EA  ori.b  #$0, d0
000047EE  sge.b  (a0)
000047F0  ; data: 0x39, 0xc4
000047F2  ori.b  #$0, d0
000047F6  ori.b  #$0, d0
000047FA  sge.b  ([a4], d3.l * 4)
00004804  ori.b  #$9, d0
00004808  dc.w   $4537
0000480A  ori.b  #$0, d0
0000480E  ori.b  #$0, d0
00004812  subq.b #$6, (a5)
00004814  ; data: 0x4d, 0xc7
00004816  ori.b  #$0, d0
0000481A  ori.b  #$0, d0
0000481E  subq.b #$6, (a5)
00004820  scs.b  (a3)
00004822  ori.b  #$0, d0
00004826  ori.b  #$0, d0
0000482A  ; data: 0x5d, 0x0b
0000482C  ; data: 0x5d, 0x0b
0000482E  ori.b  #$0, d0
00004832  ori.b  #$0, d0
00004836  sge.b  (a6, d6.w * 2)
0000483A  ori.b  #$0, d0
0000483E  ori.b  #$0, d0
00004842  sge.b  (a3)
00004844  bvc.b  $4812
00004846  ori.b  #$0, d0
0000484A  ori.b  #$0, d0
0000484E  addq.l #$6, $6d20(a1)
00004852  ori.b  #$0, d0
00004856  ori.b  #$0, d0
0000485A  addq.w #$6, ([, d7.w])
00004860  ori.b  #$0, d0
00004864  ori.b  #$2f, d0
00004868  ; data: 0x75, 0x0f
0000486A  ori.b  #$0, d0
0000486E  ori.b  #$0, d0
00004872  smi.b  -(a4)
00004874  moveq  #$a, d4
00004876  ori.b  #$0, d0
0000487A  ori.b  #$0, d0
0000487E  subq.l #$5, a0
00004880  moveq  #$72, d5
00004882  ori.b  #$0, d0
00004886  ori.b  #$0, d0
0000488A  subq.b #$5, -(a7)
0000488C  moveq  #$b, d6
0000488E  ori.b  #$0, d0
00004892  ori.b  #$0, d0
00004896  addq.l #$5, (a4, invalid.w)
0000489A  ori.b  #$0, d0
0000489E  ori.b  #$0, d0
000048A2  addq.b #$5, ([])
000048A6  ori.b  #$0, d0
000048AA  ori.b  #$0, d0
000048AE  subq.l #$4, ([a4])
000048B8  ori.b  #$1d, d0
000048BC  moveq  #$18, d6
000048BE  ori.b  #$0, d0
000048C2  ori.b  #$0, d0
000048C6  move.w -(a2), (a1)+
000048C8  neg.b  -(a3)
000048CA  ; data: 0x58, 0x7b
000048CC  moveq  #$c3, d4
000048CE  ori.b  #$0, d0
000048D2  move.w a0, $529757ce.l
000048D8  moveq  #$10, d1
000048DA  ori.b  #$0, d0
000048DE  move.w $57140000.l, -(a2)
000048E4  ori.b  #$0, d0
000048E8  ori.b  #$c1, d0
000048EC  addq.w #$3, a7
000048EE  ori.b  #$0, d0
000048F2  ori.b  #$0, d0
000048F6  move.w (a0)+, (a4)
000048F8  subq.w #$2, $0(a7)
000048FC  ori.b  #$0, d0
00004900  ori.b  #$64, d0
00004904  addq.l #$2, (a2)
00004906  ori.b  #$0, d0
0000490A  ori.b  #$0, d0
0000490E  move.w d5, d6
00004910  subq.l #$1, (a0)+
00004912  ori.b  #$0, d0
00004916  ori.b  #$0, d0
0000491A  ; data: 0x3d, 0xc0
0000491C  addq.l #$1, (a2)
0000491E  ori.b  #$0, d0
00004922  ori.b  #$0, d0
00004926  move.w (a0), ([a7])
0000492E  ori.b  #$0, d0
00004932  ; data: 0x41, 0x0f
00004934  addq.w #$8, (a7)+
00004936  ori.b  #$0, d0
0000493A  ori.b  #$0, d0
0000493E  dc.w   $42f8
00004940  dc.w   $4f33
00004942  ori.b  #$0, d0
00004946  ori.b  #$0, d0
0000494A  neg.l  d4
0000494C  ; data: 0x4d, 0xe5
0000494E  ori.b  #$0, d0
00004952  ori.b  #$0, d0
00004956  ; data: 0x18, 0x5e
00004958  move.b $4613(a5), (a5)
0000495C  ; data: 0x4c, 0x88
0000495E  ori.b  #$0, d0
00004962  ; data: 0x17, 0xc9
00004964  move.b ([$4b1e, d4.w * 8]), $0(a6)
0000496C  ori.b  #$b7, d0
00004970  move.b d4, ([$492c], d4.l)
0000497A  ; data: 0x17, 0xc8
0000497C  move.l (a4), $9(a0, d4.l)
00004980  tst.l  (a1, d0.w)
00004984  ori.b  #$e6, d0
00004988  move.l a2, $5c(a1, d4.w)
0000498C  dc.w   $4c2e
0000498E  ori.b  #$0, d0
00004992  move.b (a0), d4
00004994  move.l $44a2(a3), ([, d4.l * 4])
0000499C  ori.b  #$43, d0
000049A0  move.l (a2), -$44(a3, d4.w)
000049A4  dc.w   $4f07
000049A6  ori.b  #$0, d0
000049AA  ; data: 0x18, 0x71
000049AC  move.l (a2), -$56(a4, d4.w)
000049B0  addq.w #$8, (a6)+
000049B2  ori.b  #$0, d0
000049B6  move.b -(a1), (a4)
000049B8  move.l $3e87(a3), ([, d5.w], $18d3)
000049C4  ; data: 0x2d, 0xda
000049C6  move.w -$2a(a5, d5.w), d6
000049CA  ori.b  #$0, d0
000049CE  move.b $301c39d2.l, (a4)+
000049D4  sls.b  (a3, d0.w)
000049D8  ori.b  #$2a, d0
000049DC  movea.w $373d(a6), a1
000049E0  dc.w   $54fa
000049E2  ori.b  #$0, d0
000049E6  ; data: 0x19, 0x4d
000049E8  movea.w (a3), a2
000049EA  move.w a5, (a2)+
000049EC  scs.b  $0(a0)
000049F0  ori.b  #$79, d0
000049F4  move.w (a4), $36ba(a0)
000049F8  sne.b  $0(a5)
000049FC  ori.b  #$98, d0
00004A00  ; data: 0x2d, 0xfb
00004A02  move.w -(a7), -(a4)
00004A04  seq.b  d6
00004A06  ori.b  #$0, d0
00004A0A  move.b $43(a4, d2.l), $15(a4, d3.l)
00004A10  addq.w #$4, (a3)
00004A12  ori.b  #$0, d0
00004A16  ; data: 0x19, 0xcc
00004A18  move.l d3, d3
00004A1A  move.w d4, (a7)
00004A1C  svc.b  $0(a7)
00004A20  ori.b  #$e6, d0
00004A24  move.l $593b(a5, invalid.w), -(a0)
00004A2A  ori.b  #$0, d0
00004A2E  ; data: 0x19, 0xf5
00004A30  move.b (a7)+, $44b5(a5)
00004A34  subq.w #$4, (a4)
00004A36  ori.b  #$0, d0
00004A3A  move.b $19ff(a4), ([$5905])
00004A46  subi.b #$3, $4c2557ee.l
00004A4E  ori.b  #$0, d0
00004A52  move.b d3, d5
00004A54  ori.b  #$0, d0
00004A58  ori.b  #$0, d0
00004A5C  ori.b  #$f9, d0
00004A60  ori.b  #$0, d0
00004A64  ori.b  #$0, d0
00004A68  ori.b  #$ea, d0
00004A6C  ori.b  #$0, d0
00004A70  ori.b  #$0, d0
00004A74  ori.b  #$d5, d0
00004A78  ori.b  #$0, d0
00004A7C  ori.b  #$0, d0
00004A80  ori.b  #$ba, d0
00004A84  ori.b  #$0, d0
00004A88  ori.b  #$0, d0
00004A8C  ori.b  #$5e, d0
00004A90  ; data: 0x19, 0x8a
00004A92  ori.b  #$0, d0
00004A96  ori.b  #$0, d0
00004A9A  btst.l d0, -(a0)
00004A9C  move.b (a7)+, $0(a4)
00004AA0  ori.b  #$0, d0
00004AA4  ori.b  #$e9, d0
00004AA8  move.b (a2)+, -(a4)
00004AAA  ori.b  #$0, d0
00004AAE  ori.b  #$0, d0
00004AB2  andi.l #$18c80000, d5
00004AB8  ori.b  #$0, d0
00004ABC  ori.b  #$5b, d0
00004AC0  ; data: 0x18, 0x6a
00004AC2  ori.b  #$0, d0
00004AC6  ori.b  #$0, d0
00004ACA  subi.w #$17ff, $0(a7)
00004AD0  ori.b  #$0, d0
00004AD4  ori.b  #$53, d0
00004AD8  move.b d7, (a3, d0.w)
00004ADC  ori.b  #$0, d0
00004AE0  ori.b  #$75, d0
00004AE4  move.b -(a0), (a3)+
00004AE6  ori.b  #$0, d0
00004AEA  ori.b  #$0, d0
00004AEE  bclr.b d3, (a6)+
00004AF0  move.b -(a6), d3
00004AF2  ori.b  #$0, d0
00004AF6  ori.b  #$0, d0
00004AFA  bchg.b d4, d5
00004AFC  move.b d4, -(a2)
00004AFE  ori.b  #$0, d0
00004B02  ori.b  #$0, d0
00004B06  btst.l d5, $1391(a4)
00004B0A  ori.b  #$0, d0
00004B0E  ori.b  #$0, d0
00004B12  btst.l d7, -(a5)
00004B14  ; data: 0x10, 0x0b
00004B16  ori.b  #$0, d0
00004B1A  ori.b  #$0, d0
00004B1E  ori.b  #$0, d0
00004B22  ori.b  #$0, d0
00004B26  ori.b  #$0, d0
00004B2A  ori.b  #$0, d0
00004B2E  ori.b  #$0, d0
00004B32  ori.b  #$0, d0
00004B36  ori.b  #$0, d0
00004B3A  ori.b  #$0, d0
00004B3E  ori.b  #$0, d0
00004B42  ori.b  #$0, d0
00004B46  ori.b  #$0, d0
00004B4A  ori.b  #$0, d0
00004B4E  ; data: 0x01, 0x3f
00004B50  ori.b  #$0, d0
00004B54  ori.b  #$0, d0
00004B58  ori.b  #$c, d0
00004B5C  ori.b  #$0, d0
00004B60  ori.b  #$0, d0
00004B64  ori.b  #$3, d0
00004B68  ori.b  #$0, d0
00004B6C  ori.b  #$0, d0
00004B70  ori.b  #$c0, d0
00004B74  ori.b  #$0, d0
00004B78  ori.b  #$0, d0
00004B7C  ori.b  #$49, d0
00004B80  ori.b  #$0, d0
00004B84  ori.b  #$0, d0
00004B88  ori.b  #$f7, d0
00004B8C  ori.b  #$0, d0
00004B90  ori.b  #$0, d0
00004B94  ori.b  #$c2, d0
00004B98  move.w d3, ([], d0.w * 4)
00004B9C  ori.b  #$0, d0
00004BA0  ori.b  #$ba, d0
00004BA4  ; data: 0x38, 0x3f
00004BA6  addi.b #$0, (a4)
00004BAA  ori.b  #$0, d0
00004BAE  ; data: 0x47, 0x3d
00004BB0  move.w a7, -$56(a2, d0.w)
00004BB4  ori.b  #$0, d0
00004BB8  ori.b  #$6d, d0
00004BBC  move.w $715(a5), -(a1)
00004BC0  ori.b  #$0, d0
00004BC4  ori.b  #$68, d0
00004BC8  ; data: 0x30, 0xbe
00004BCA  ; data: 0x07, 0x7b
00004BCC  ori.b  #$0, d0
00004BD0  ori.b  #$3a, d0
00004BD4  move.l ([]), (a7)
00004BDE  move.w -(a4), sr
00004BE0  move.l a5, -(a6)
00004BE2  bchg.b #$0, (a3)
00004BE6  ori.b  #$0, d0
00004BEA  not.l  d3
00004BEC  ; data: 0x2a, 0xff
00004BEE  ; data: 0x08, 0xa8
00004BF0  ; data: 0x04, 0x0f
00004BF2  ori.b  #$0, d0
00004BF6  ; data: 0x46, 0x0b
00004BF8  move.l (a5)+, $1383(a4)
00004BFC  bset.b #$0, (a7, d0.w)
00004C02  ; data: 0x45, 0x7b
00004C04  ; data: 0x27, 0xbf
00004C06  move.b ([a7]), -(a5)
00004C0C  ori.b  #$d6, d0
00004C10  move.l -(a7), d3
00004C12  move.l a6, -(a0)
00004C14  bclr.b d4, (a6)+
00004C16  ori.b  #$0, d0
00004C1A  neg.b  (a5)+
00004C1C  ; data: 0x25, 0xdd
00004C1E  move.l (a4), (a2)
00004C20  bset.b d4, (a5)+
00004C22  ori.b  #$0, d0
00004C26  chk.w  d4, d1
00004C28  move.l (a6)+, d5
00004C2A  move.l a2, -(a1)
00004C2C  eori.b #$0, (a1)+
00004C30  ori.b  #$aa, d0
00004C34  ; data: 0x2d, 0xd7
00004C36  move.l a1, $62(a0, d0.l)
00004C3A  ori.b  #$0, d0
00004C3E  lea.l  ([$201156d5, pc, d3.w]), a0
00004C46  ori.b  #$0, d0
00004C4A  dc.w   $4105
00004C4C  move.w $4c(a0, d1.l), d2
00004C50  dc.w   $ad3
00004C52  ori.b  #$0, d0
00004C56  negx.w d3
00004C58  move.w (a4)+, -(a3)
00004C5A  move.b $aff(a7), (a6)+
00004C5E  ori.b  #$0, d0
00004C62  move.w ([$1b9f0b34, d3.l]), -(a7)
00004C6C  ori.b  #$65, d0
00004C70  move.w (a6), d6
00004C72  ; data: 0x1a, 0x5d
00004C74  bchg.b d5, -(a6)
00004C76  ori.b  #$0, d0
00004C7A  movea.w $3d47(a1), a7
00004C7E  move.b (a7)+, (a4)+
00004C80  bclr.b d5, (a6)
00004C82  ori.b  #$0, d0
00004C86  ; data: 0x40, 0x8c
00004C88  move.w -(a3), d6
00004C8A  move.b $bc3.w, $0(a3)
00004C90  ori.b  #$9f, d0
00004C94  move.w d4, $1628(a5)
00004C98  ; data: 0x0b, 0xfa
00004C9A  ori.b  #$0, d0
00004C9E  neg.l  d6
00004CA0  move.w (a1)+, d5
00004CA2  move.b $32(a1, d0.l), (a2)+
00004CA6  ori.b  #$0, d0
00004CAA  not.w  d1
00004CAC  move.w $1367(a4), (a4)+
00004CB0  cmpi.w #$0, $47ef.l
00004CB8  move.w a4, d4
00004CBA  move.b (a5)+, $ce3.w
00004CBE  ori.b  #$0, d0
00004CC2  ; data: 0x49, 0x8e
00004CC4  move.w -(a4), (a3)+
00004CC6  move.b -(a0), d0
00004CC8  bclr.b d6, (a3)+
00004CCA  ori.b  #$0, d0
00004CCE  dc.w   $4b06
00004CD0  ; data: 0x35, 0xc1
00004CD2  ori.b  #$0, d0
00004CD6  ori.b  #$0, d0
00004CDA  ; data: 0x4c, 0x70
00004CDC  movea.w -(a0), a2
00004CDE  ori.b  #$0, d0
00004CE2  ori.b  #$0, d0
00004CE6  ; data: 0x71, 0x86
00004CE8  bra.b  $4d30
00004CEA  ; data: 0x4d, 0xce
00004CEC  move.w (a1), $0(a1)
00004CF0  ori.b  #$7d, d0
00004CF4  addq.b #$3, ([a6], d4.l * 8)
00004CF8  move.w a7, d1
00004CFA  ori.b  #$0, d0
00004CFE  ; data: 0x77, 0x02
00004D00  addq.w #$8, a2
00004D02  trap   #$f
00004D04  move.w -(a6), (a0)+
00004D06  ori.b  #$0, d0
00004D0A  ; data: 0x77, 0x55
00004D0C  subq.w #$8, $47c8(a3)
00004D10  move.l -(a6), (a7, d0.w)
00004D14  ori.b  #$eb, d0
00004D18  ; data: 0x52, 0x7f
00004D1A  clr.b  $2e95(a2)
00004D1E  ori.b  #$0, d0
00004D22  moveq  #$7, d3
00004D24  subq.l #$1, d6
00004D26  move.w d1, (a6)
00004D28  move.l (a0)+, (a6, d0.w)
00004D2C  ori.b  #$a7, d0
00004D30  addq.l #$2, d1
00004D32  move.w #$2cbd, (a3)
00004D36  ori.b  #$0, d0
00004D3A  ; data: 0x73, 0x1d
00004D3C  subq.w #$2, (a6)+
00004D3E  ; data: 0x30, 0x7d
00004D40  move.l -(a6), (a6)+
00004D42  ori.b  #$0, d0
00004D46  ; data: 0x71, 0x41
00004D48  addq.w #$3, d0
00004D4A  ori.b  #$0, d0
00004D4E  ori.b  #$0, d0
00004D52  bgt.b  $4d0a
00004D54  subq.b #$3, d5
00004D56  ori.b  #$0, d0
00004D5A  ori.b  #$0, d0
00004D5E  bge.b  $4d9f
00004D60  seq.b  d0
00004D62  ori.b  #$0, d0
00004D66  ori.b  #$0, d0
00004D6A  bvs.b  $4cf8
00004D6C  addq.w #$4, $0(a6)
00004D70  ori.b  #$0, d0
00004D74  ori.b  #$a5, d0
00004D78  subq.b #$4, (a1)
00004D7A  ori.b  #$0, d0
00004D7E  ori.b  #$0, d0
00004D82  bls.b  $4d16
00004D84  subq.l #$4, $0(a1)
00004D88  ori.b  #$0, d0
00004D8C  ori.b  #$d3, d0
00004D90  addq.b #$5, $0(a2)
00004D94  ori.b  #$0, d0
00004D98  ori.b  #$85, d0
00004D9C  addq.l #$5, $0(a2)
00004DA0  ori.b  #$0, d0
00004DA4  ori.b  #$1f, d0
00004DA8  addq.l #$4, (a3)+
00004DAA  ori.b  #$0, d0
00004DAE  ori.b  #$0, d0
00004DB2  subq.l #$5, d0
00004DB4  addq.l #$2, (a1, d0.w)
00004DB8  ori.b  #$0, d0
00004DBC  ori.b  #$dd, d0
00004DC0  addq.w #$8, a5
00004DC2  ori.b  #$0, d0
00004DC6  ori.b  #$0, d0
00004DCA  addq.b #$6, $4b95(a1)
00004DCE  ori.b  #$0, d0
00004DD2  ori.b  #$0, d0
00004DD6  addq.w #$6, $4736(a7)
00004DDA  ori.b  #$0, d0
00004DDE  ori.b  #$0, d0
00004DE2  addq.l #$6, -(a5)
00004DE4  clr.l  d6
00004DE6  ori.b  #$0, d0
00004DEA  ori.b  #$0, d0
00004DEE  sge.b  (a0)
00004DF0  move.w $0(a0), d7
00004DF4  ori.b  #$0, d0
00004DF8  ori.b  #$f4, d0
00004DFC  move.w (a4)+, (a5)+
00004DFE  ori.b  #$0, d0
00004E02  ori.b  #$0, d0
00004E06  ; data: 0x5d, 0x09
00004E08  movea.w a3, a5
00004E0A  ori.b  #$0, d0
00004E0E  ori.b  #$0, d0
00004E12  subq.b #$6, (a5)
00004E14  move.w (a4, d0.w), (a6, d0.w)
00004E1A  ori.b  #$0, d0
00004E1E  lea.l  $5d150000.l, a1
00004E24  ori.b  #$0, d0
00004E28  ori.b  #$89, d0
00004E2C  ; data: 0x5d, 0x0b
00004E2E  ori.b  #$0, d0
00004E32  ori.b  #$0, d0
00004E36  subq.l #$8, (a2)
00004E38  sge.b  (a6, d0.w)
00004E3C  ori.b  #$0, d0
00004E40  ori.b  #$5b, d0
00004E44  sge.b  (a3)
00004E46  ori.b  #$0, d0
00004E4A  ori.b  #$0, d0
00004E4E  addq.l #$6, $5d44(a1)
00004E52  ori.b  #$0, d0
00004E56  ori.b  #$0, d0
00004E5A  addq.w #$6, (invalid.w)
00004E62  ori.b  #$0, d0
00004E66  addq.b #$6, $6681(a7)
00004E6A  ori.b  #$0, d0
00004E6E  ori.b  #$0, d0
00004E72  smi.b  -(a4)
00004E74  bpl.b  $4e47
00004E76  ori.b  #$0, d0
00004E7A  ori.b  #$0, d0
00004E7E  subq.l #$5, a0
00004E80  bgt.b  $4e51
00004E82  ori.b  #$0, d0
00004E86  ori.b  #$0, d0
00004E8A  subq.b #$5, -(a7)
00004E8C  ; data: 0x71, 0xfa
00004E8E  ori.b  #$0, d0
00004E92  ori.b  #$0, d0
00004E96  addq.l #$5, -$38(a4, d7.w)
00004E9A  ori.b  #$0, d0
00004E9E  ori.b  #$0, d0
00004EA2  addq.b #$5, ([a4], d7.w * 8)
00004EAA  ori.b  #$0, d0
00004EAE  subq.l #$4, ([a4])
00004EB4  ori.b  #$0, d0
00004EB8  ori.b  #$1d, d0
00004EBC  moveq  #$cb, d5
00004EBE  ori.b  #$0, d0
00004EC2  ori.b  #$0, d0
00004EC6  ; data: 0x58, 0x7b
00004EC8  ; data: 0x7b, 0xcb
00004ECA  ori.b  #$0, d0
00004ECE  ori.b  #$0, d0
00004ED2  move.w (a3), $37c2(a0)
00004ED6  dbeq   d6, $caf5
00004EDA  ori.b  #$0, d0
00004EDE  move.w ([$5714, a5, d4.w]), -(a0)
00004EE4  ; data: 0x7b, 0x90
00004EE6  ori.b  #$0, d0
00004EEA  movea.w d1, a1
00004EEC  tst.w  $564f.w
00004EF0  ; data: 0x79, 0xbd
00004EF2  ori.b  #$0, d0
00004EF6  move.w (a7)+, ([$560e, a1])
00004EFC  ; data: 0x75, 0x51
00004EFE  ori.b  #$0, d0
00004F02  move.w $5492(a4), (a2)+
00004F06  ori.b  #$0, d0
00004F0A  ori.b  #$0, d0
00004F0E  movea.w $5398(a6), a3
00004F12  ori.b  #$0, d0
00004F16  ori.b  #$0, d0
00004F1A  move.w -(a0), d4
00004F1C  addq.l #$1, (a2)
00004F1E  ori.b  #$0, d0
00004F22  ori.b  #$0, d0
00004F26  move.w $517f(a0), (a4, d0.w)
00004F2C  ori.b  #$0, d0
00004F30  ori.b  #$46, d0
00004F34  addq.w #$8, (a7)+
00004F36  ori.b  #$0, d0
00004F3A  ori.b  #$0, d0
00004F3E  move.w (a7)+, (a6)
00004F40  dc.w   $4f33
00004F42  ori.b  #$0, d0
00004F46  ori.b  #$0, d0
00004F4A  move.w d1, d7
00004F4C  ; data: 0x4d, 0xe5
00004F4E  ori.b  #$0, d0
00004F52  ori.b  #$0, d0
00004F56  ; data: 0x3f, 0xc5
00004F58  ; data: 0x4c, 0x88
00004F5A  ori.b  #$0, d0
00004F5E  ori.b  #$0, d0
00004F62  move.b $17f5(a0), (a2)
00004F66  dc.w   $4133
00004F68  dc.w   $4b1e
00004F6A  ori.b  #$0, d0
00004F6E  move.b $1a2b42a2.l, d2
00004F74  chk.w  -(a7), d4
00004F76  ori.b  #$0, d0
00004F7A  move.b (a1), d2
00004F7C  move.b -(a1), d6
00004F7E  neg.b  (a0)
00004F80  dc.w   $4809
00004F82  ori.b  #$0, d0
00004F86  ; data: 0x14, 0x09
00004F88  ; data: 0x1d, 0xcd
00004F8A  dc.w   $4520
00004F8C  not.w  (a4)+
00004F8E  ori.b  #$0, d0
00004F92  ; data: 0x14, 0x0e
00004F94  move.b -(a2), -$5e(a7, d4.w)
00004F98  not.l  d6
00004F9A  ori.b  #$0, d0
00004F9E  move.b (a2)+, d2
00004FA0  move.l a1, $42bc(a0)
00004FA4  ; data: 0x47, 0xe4
00004FA6  ori.b  #$0, d0
00004FAA  move.b -(a7), d2
00004FAC  move.l a2, -(a1)
00004FAE  negx.l $4938(a2)
00004FB2  ori.b  #$0, d0
00004FB6  move.b -$1a(a7, d2.w), d2
00004FBA  move.w d7, (a7)
00004FBC  ; data: 0x4a, 0x7f
00004FBE  ori.b  #$0, d0
00004FC2  ; data: 0x14, 0x47
00004FC4  move.l (a0)+, (a3)+
00004FC6  move.w (a5, invalid.w), d6
00004FCC  ori.b  #$57, d0
00004FD0  movea.l ([], $4c99), a4
00004FD6  ori.b  #$0, d0
00004FDA  ; data: 0x14, 0x62
00004FDC  move.l a7, (a5)
00004FDE  ; data: 0x37, 0x3d
00004FE0  chk.w  (a4, d0.w), d6
00004FE4  ori.b  #$6e, d0
00004FE8  movea.l a0, a6
00004FEA  movea.w (a3), a2
00004FEC  ; data: 0x4e, 0xbc
00004FEE  ori.b  #$0, d0
00004FF2  ; data: 0x14, 0x75
00004FF4  ; data: 0x2e, 0x7d
00004FF6  move.w (a4), $4fae(a0)
00004FFA  ori.b  #$0, d0
00004FFE  ; data: 0x14, 0x7a
00005000  ; data: 0x2d, 0xfb
00005002  movea.w a2, a0
00005004  addq.l #$8, a2
00005006  ori.b  #$0, d0
0000500A  ; data: 0x14, 0x7a
0000500C  movea.l d3, a5
0000500E  move.w (a2), (a1)
00005010  subq.w #$8, a4
00005012  ori.b  #$0, d0
00005016  ; data: 0x14, 0x77
00005018  move.l d3, d3
0000501A  move.w -(a1), (a2)+
0000501C  sf.b   (a5, d0.w)
00005020  ori.b  #$70, d0
00005024  move.l ([$52a30000, a5, d3.w * 8]), -(a0)
0000502E  ; data: 0x14, 0x60
00005030  move.b (a7)+, $3983(a5)
00005034  subq.b #$1, -(a5)
00005036  ori.b  #$0, d0
0000503A  move.b $144e(a4), ([])
00005040  subq.w #$1, $0.l
00005046  subi.b #$38, $3e8653a0.l
0000504E  ori.b  #$0, d0
00005052  move.b (a5)+, d2
00005054  chk.w  (a2)+, d0
00005056  subq.l #$1, d4
00005058  ori.b  #$0, d0
0000505C  ori.b  #$fc, d0
00005060  move.w -$c(a4, d5.w), ccr
00005064  ori.b  #$0, d0
00005068  ori.b  #$c7, d0
0000506C  chk.w  d7, d4
0000506E  ; data: 0x51, 0x3b
00005070  ori.b  #$0, d0
00005074  ori.b  #$99, d0
00005078  ori.b  #$0, d0
0000507C  ori.b  #$0, d0
00005080  ori.b  #$65, d0
00005084  ori.b  #$0, d0
00005088  ori.b  #$0, d0
0000508C  ori.b  #$2a, d0
00005090  ori.b  #$0, d0
00005094  ori.b  #$0, d0
00005098  ori.b  #$d2, d0
0000509C  ori.b  #$0, d0
000050A0  ori.b  #$0, d0
000050A4  ori.b  #$6f, d0
000050A8  ori.b  #$0, d0
000050AC  ori.b  #$0, d0
000050B0  ori.b  #$1e, d0
000050B4  ori.b  #$0, d0
000050B8  ori.b  #$0, d0
000050BC  ori.b  #$a7, d0
000050C0  ori.b  #$0, d0
000050C4  ori.b  #$0, d0
000050C8  ori.b  #$25, d0
000050CC  ori.b  #$0, d0
000050D0  ori.b  #$0, d0
000050D4  ori.b  #$98, d0
000050D8  ori.b  #$0, d0
000050DC  ori.b  #$0, d0
000050E0  ori.b  #$d9, d0
000050E4  ori.b  #$0, d0
000050E8  ori.b  #$0, d0
000050EC  ori.b  #$1, d0
000050F0  movep.w $0(a2), d7
000050F4  ori.b  #$0, d0
000050F8  ori.b  #$13, d0
000050FC  ; data: 0x0d, 0xfe
000050FE  ori.b  #$0, d0
00005102  ori.b  #$0, d0
00005106  ; data: 0x02, 0xd7
00005108  cmpi.l #$0, $0(a6)
00005110  ori.b  #$1a, d0
00005114  eori.w #$0, $0(a7)
0000511A  ori.b  #$0, d0
0000511E  ; data: 0x00, 0x4b
00005120  ori.w  #$97, -$43(a1, d0.w)
00005126  ; data: 0x00, 0xe3
00005128  movep.w $12f(a1), d0
0000512C  bchg.b d0, (a4)
0000512E  ; data: 0x01, 0x7a
00005130  bclr.b d0, -(a0)
00005132  bset.b d0, d5
00005134  bset.b d0, $20f(a2)
00005138  andi.b #$59, $7d(a4, d0.w)
0000513E  andi.l #$2c502e9, -(a1)
00005144  movep.w $330(a5), d1
00005148  bchg.b d1, (a3)
0000514A  bchg.b d1, ([], d0.w * 2, $3b903db)
00005152  ; data: 0x03, 0xfc
00005154  subi.b #$3d, (a5)+
00005158  subi.w #$47d, (a5)+
0000515C  subi.l #$4bb04d9, (a4)+
00005162  ; data: 0x04, 0xf7
00005164  btst.l d2, (a4)
00005166  btst.l d2, ([a1])
0000516A  bchg.b d2, $585(a1)
0000516E  bclr.b d2, (a7)+
00005170  bclr.b d2, $5d305ec.l
00005176  addi.b #$1d, d5
0000517A  addi.b #$4b, $61(a4, d0.w)
00005180  addi.w #$68b, -$61(a6, d0.w)
00005186  addi.l #$6c606d8, -$17(a3, d0.w)
0000518E  ; data: 0x06, 0xfa
00005190  movep.w $71a(a3), d3
00005194  btst.l d3, $737(a1)
00005198  bchg.b d3, d4
0000519A  bchg.b d3, (a1)
0000519C  bchg.b d3, (a5)+
0000519E  bchg.b d3, $773(a0)
000051A2  ; data: 0x07, 0x7c
000051A4  bclr.b d3, d5
000051A6  movep.w d3, $795(a6)
000051AA  bclr.b d3, (a4)+
000051AC  bclr.b d3, -(a2)
000051AE  bclr.b d3, -(a7)
000051B0  bclr.b d3, $7af(a4)
000051B4  bclr.b d3, ([$7b607b7], d0.w * 8)
000051BC  bclr.b d3, ([$7b507b2], d0.w * 8, $7af)
000051C6  bclr.b d3, $7a7(a3)
000051CA  bclr.b d3, -(a1)
000051CC  bclr.b d3, (a3)+
000051CE  bclr.b d3, (a4)
000051D0  movep.w d3, $784(a5)
000051D4  ; data: 0x07, 0x7b
000051D6  bchg.b d3, ([$75c, a1])
000051DC  bchg.b d3, (a0)
000051DE  bchg.b d3, d3
000051E0  btst.l d3, ([$718, a5], d0.w * 8, $70906f8)
000051EA  ; data: 0x06, 0xe8
000051EC  ; data: 0x06, 0xd6
000051EE  dc.w   $6c4
000051F0  addi.l #$69d0689, $74(a1, d0.w)
000051F8  addi.w #$648, (a6)+
000051FC  addi.b #$18, ([$5e605cd])
00005206  bclr.b d2, ([, d0.w * 4], $5820569)
0000520E  bchg.b d2, (a0)
00005210  btst.l d2, ([a7], d0.w * 4, $505)
00005216  ; data: 0x04, 0xec
00005218  ; data: 0x04, 0xd3
0000521A  ; data: 0x04, 0xba
0000521C  subi.l #$488046f, -(a1)
00005222  subi.w #$43d, (a6)
00005226  subi.b #$b, -(a4)
0000522A  bset.b d1, ([])
0000522E  bset.b d1, d0
00005230  bclr.b d1, -(a7)
00005232  movep.w d1, $375(a6)
00005236  bchg.b d1, (a4)+
00005238  bchg.b d1, d3
0000523A  btst.l d1, $311(a2)
0000523E  ; data: 0x02, 0xf8
00005240  ; data: 0x02, 0xdf
00005242  ; data: 0x02, 0xc6
00005244  andi.l #$294027b, $262(a5)
0000524C  ; data: 0x02, 0x49
0000524E  andi.b #$17, ([$1e501cc])
00005258  bclr.b d0, ([, d0.w], $181)
0000525E  bchg.b d0, $14f(a0)
00005262  btst.l d0, ([a6], d0.w)
00005266  btst.l d0, d4
00005268  ; data: 0x00, 0xeb
0000526A  ; data: 0x00, 0xd2
0000526C  ori.l  #$a00087, $6e0055.l
00005276  ori.b  #$0, d0
0000527A  ori.b  #$aa, d0