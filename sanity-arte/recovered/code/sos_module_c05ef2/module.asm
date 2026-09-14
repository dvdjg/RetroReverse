Disassembly of section .data:

00000000 <.data>:
       0:	4ef9 0000 0010 	jmp 0x10
       6:	4ef9 0000 009a 	jmp 0x9a
       c:	736f 7300      	mvs.w 29440(sp),d1
      10:	2c78 0004      	movea.l 0x4,a6
      14:	286e 0114      	movea.l 276(a6),a4
      18:	4aac 00ac      	tst.l 172(a4)
      1c:	661a           	bne.s 0x38
      1e:	41ec 005c      	lea 92(a4),a0
      22:	4eae fe80      	jsr -384(a6)
      26:	41ec 005c      	lea 92(a4),a0
      2a:	4eae fe8c      	jsr -372(a6)
      2e:	23c0 0000 007a 	move.l d0,0x7a
      34:	45fa 0048      	lea 0x7e(pc),a2
      38:	43fa 0054      	lea 0x8e(pc),a1
      3c:	7000           	moveq #0,d0
      3e:	2c78 0004      	movea.l 0x4,a6
      42:	4eae fdd8      	jsr -552(a6)
      46:	4a80           	tst.l d0
      48:	6718           	beq.s 0x62
      4a:	2c40           	movea.l d0,a6
      4c:	2f0e           	move.l a6,-(sp)
      4e:	41f9 0000 009a 	lea 0x9a,a0
      54:	4eae ffe2      	jsr -30(a6)
      58:	225f           	movea.l (sp)+,a1
      5a:	2c78 0004      	movea.l 0x4,a6
      5e:	4eae fe62      	jsr -414(a6)
      62:	243a 0016      	move.l 0x7a(pc),d2
      66:	670e           	beq.s 0x76
      68:	2c78 0004      	movea.l 0x4,a6
      6c:	4eae ff7c      	jsr -132(a6)
      70:	2242           	movea.l d2,a1
      72:	4eae fe86      	jsr -378(a6)
      76:	7000           	moveq #0,d0
      78:	4e75           	rts
	...
      8e:	736f 732e      	mvs.w 29486(sp),d1
      92:	6c69           	bge.s 0xfd
      94:	6272           	bhi.s 0x108
      96:	6172           	bsr.s 0x10a
      98:	7900           	mvs.b d0,d4
      9a:	7008           	moveq #8,d0
      9c:	91c8           	suba.l a0,a0
      9e:	4eae ff46      	jsr -186(a6)
      a2:	4bf9 0000 0000 	lea 0x0,a5
      a8:	2b4e 0000      	move.l a6,0(a5)
      ac:	2f0a           	move.l a2,-(sp)
      ae:	4eae fee6      	jsr -282(a6)
      b2:	2448           	movea.l a0,a2
      b4:	206a 0026      	movea.l 38(a2),a0
      b8:	2008           	move.l a0,d0
      ba:	6616           	bne.s 0xd2
      bc:	701c           	moveq #28,d0
      be:	7200           	moveq #0,d1
      c0:	4eae ffd6      	jsr -42(a6)
      c4:	2040           	movea.l d0,a0
      c6:	7206           	moveq #6,d1
      c8:	4298           	clr.l (a0)+
      ca:	51c9 fffc      	dbf d1,0xc8
      ce:	2540 0026      	move.l d0,38(a2)
      d2:	2440           	movea.l d0,a2
      d4:	2b4a 0008      	move.l a2,8(a5)
      d8:	4a6a 000e      	tst.w 14(a2)
      dc:	6606           	bne.s 0xe4
      de:	357c 0300 000e 	move.w #768,14(a2)
      e4:	4aaa 0004      	tst.l 4(a2)
      e8:	661a           	bne.s 0x104
      ea:	203c 4442 5547 	move.l #1145197895,d0
      f0:	4eae fec8      	jsr -312(a6)
      f4:	226d 0008      	movea.l 8(a5),a1
      f8:	2348 0018      	move.l a0,24(a1)
      fc:	257c 0000 0114 	move.l #276,4(a2)
     102:	0004 
     104:	4aaa 0008      	tst.l 8(a2)
     108:	664a           	bne.s 0x154
     10a:	257c 0000 012c 	move.l #300,8(a2)
     110:	0008 
     112:	6040           	bra.s 0x154
     114:	2f0d           	move.l a5,-(sp)
     116:	4bf9 0000 0000 	lea 0x0,a5
     11c:	286d 0008      	movea.l 8(a5),a4
     120:	286c 0018      	movea.l 24(a4),a4
     124:	4eac fff4      	jsr -12(a4)
     128:	2a5f           	movea.l (sp)+,a5
     12a:	4e75           	rts
     12c:	2f0d           	move.l a5,-(sp)
     12e:	4bf9 0000 0000 	lea 0x0,a5
     134:	206d 0008      	movea.l 8(a5),a0
     138:	0839 0002 00df 	btst #2,0xdff016
     13e:	f016 
     140:	660a           	bne.s 0x14c
     142:	3168 000e 000c 	move.w 14(a0),12(a0)
     148:	2a5f           	movea.l (sp)+,a5
     14a:	4e75           	rts
     14c:	2a5f           	movea.l (sp)+,a5
     14e:	5268 000c      	addq.w #1,12(a0)
     152:	4e75           	rts
     154:	245f           	movea.l (sp)+,a2
     156:	6100 0e70      	bsr.w 0xfc8
     15a:	206d 0008      	movea.l 8(a5),a0
     15e:	2068 0004      	movea.l 4(a0),a0
     162:	4e90           	jsr (a0)
     164:	206d 0008      	movea.l 8(a5),a0
     168:	3028 000c      	move.w 12(a0),d0
     16c:	b068 0010      	cmp.w 16(a0),d0
     170:	65e8           	bcs.s 0x15a
     172:	41f9 0000 0000 	lea 0x0,a0
     178:	43fa 0044      	lea 0x1be(pc),a1
     17c:	7020           	moveq #32,d0
     17e:	4eae ffac      	jsr -84(a6)
     182:	6100 0f10      	bsr.w 0x1094
     186:	49f9 00df f002 	lea 0xdff002,a4
     18c:	6100 005c      	bsr.w 0x1ea
     190:	4eae fee6      	jsr -282(a6)
     194:	2268 0026      	movea.l 38(a0),a1
     198:	0c69 0013 001c 	cmpi.w #19,28(a1)
     19e:	671a           	beq.s 0x1ba
     1a0:	206d 0008      	movea.l 8(a5),a0
     1a4:	2068 0004      	movea.l 4(a0),a0
     1a8:	4e90           	jsr (a0)
     1aa:	206d 0008      	movea.l 8(a5),a0
     1ae:	3028 000c      	move.w 12(a0),d0
     1b2:	b068 000e      	cmp.w 14(a0),d0
     1b6:	6500 ffd4      	bcs.w 0x18c
     1ba:	7000           	moveq #0,d0
     1bc:	4e75           	rts
     1be:	48e7 fffe      	movem.l d0-a6,-(sp)
     1c2:	4bf9 0000 0000 	lea 0x0,a5
     1c8:	2c6d 0000      	movea.l 0(a5),a6
     1cc:	206d 0008      	movea.l 8(a5),a0
     1d0:	2068 0008      	movea.l 8(a0),a0
     1d4:	4e90           	jsr (a0)
     1d6:	6100 0014      	bsr.w 0x1ec
     1da:	4cdf 7fff      	movem.l (sp)+,d0-a6
     1de:	33fc 0030 00df 	move.w #48,0xdff09c
     1e4:	f09c 
     1e6:	4e71           	nop
     1e8:	4e73           	rte
     1ea:	4e75           	rts
     1ec:	5379 0000 1142 	subq.w #1,0x1142
     1f2:	6c38           	bge.s 0x22c
     1f4:	49f9 00df f002 	lea 0xdff002,a4
     1fa:	4df9 0000 0360 	lea 0x360,a6
     200:	6100 21be      	bsr.w 0x23c0
     204:	6100 2290      	bsr.w 0x2496
     208:	6100 2318      	bsr.w 0x2522
     20c:	6100 0020      	bsr.w 0x22e
     210:	6100 0082      	bsr.w 0x294
     214:	33fc 0400 00df 	move.w #1024,0xdff096
     21a:	f096 
     21c:	6100 0156      	bsr.w 0x374
     220:	33fc 8400 00df 	move.w #-31744,0xdff096
     226:	f096 
     228:	6100 0482      	bsr.w 0x6ac
     22c:	4e75           	rts
     22e:	4a79 0000 28da 	tst.w 0x28da
     234:	663a           	bne.s 0x270
     236:	41f9 0000 28dc 	lea 0x28dc,a0
     23c:	d0f9 0000 28d8 	adda.w 0x28d8,a0
     242:	5079 0000 28d8 	addq.w #8,0x28d8
     248:	2018           	move.l (a0)+,d0
     24a:	33c0 0000 28da 	move.w d0,0x28da
     250:	23d8 0000 25cc 	move.l (a0)+,0x25cc
     256:	13fc 0010 0000 	move.b #16,0x25d0
     25c:	25d0 
     25e:	4a90           	tst.l (a0)
     260:	660e           	bne.s 0x270
     262:	33fc 03e8 0000 	move.w #1000,0x28da
     268:	28da 
     26a:	4279 0000 28d8 	clr.w 0x28d8
     270:	0c79 0010 0000 	cmpi.w #16,0x28da
     276:	28da 
     278:	6612           	bne.s 0x28c
     27a:	23fc 0000 2900 	move.l #10496,0x25cc
     280:	0000 25cc 
     284:	13fc 0010 0000 	move.b #16,0x25d0
     28a:	25d0 
     28c:	5379 0000 28da 	subq.w #1,0x28da
     292:	4e75           	rts
     294:	41f9 0000 25d8 	lea 0x25d8,a0
     29a:	d0f9 0000 035e 	adda.w 0x35e,a0
     2a0:	5479 0000 035e 	addq.w #2,0x35e
     2a6:	0c79 0180 0000 	cmpi.w #384,0x35e
     2ac:	035e 
     2ae:	6606           	bne.s 0x2b6
     2b0:	4279 0000 035e 	clr.w 0x35e
     2b6:	3210           	move.w (a0),d1
     2b8:	c3fc 0133      	muls.w #307,d1
     2bc:	4841           	swap d1
     2be:	0641 0100      	addi.w #256,d1
     2c2:	3628 0060      	move.w 96(a0),d3
     2c6:	c7fc 5000      	muls.w #20480,d3
     2ca:	4843           	swap d3
     2cc:	e34b           	lsl.w #1,d3
     2ce:	4a43           	tst.w d3
     2d0:	6c08           	bge.s 0x2da
     2d2:	0083 ffff 0000 	ori.l #-65536,d3
     2d8:	6006           	bra.s 0x2e0
     2da:	0283 0000 ffff 	andi.l #65535,d3
     2e0:	3428 00c0      	move.w 192(a0),d2
     2e4:	c5fc 0133      	muls.w #307,d2
     2e8:	4842           	swap d2
     2ea:	0642 0100      	addi.w #256,d2
     2ee:	3828 0120      	move.w 288(a0),d4
     2f2:	c9fc 5000      	muls.w #20480,d4
     2f6:	4844           	swap d4
     2f8:	e34c           	lsl.w #1,d4
     2fa:	4a44           	tst.w d4
     2fc:	6c08           	bge.s 0x306
     2fe:	0084 ffff 0000 	ori.l #-65536,d4
     304:	6006           	bra.s 0x30c
     306:	0284 0000 ffff 	andi.l #65535,d4
     30c:	0c79 0010 0000 	cmpi.w #16,0x28d8
     312:	28d8 
     314:	6606           	bne.s 0x31c
     316:	343c 0100      	move.w #256,d2
     31a:	7800           	moveq #0,d4
     31c:	b441           	cmp.w d1,d2
     31e:	6c0a           	bge.s 0x32a
     320:	33fc 0040 0000 	move.w #64,0x1e
     326:	001e 
     328:	6008           	bra.s 0x332
     32a:	33fc 0000 0000 	move.w #0,0x1e
     330:	001e 
     332:	7000           	moveq #0,d0
     334:	302e 0008      	move.w 8(a6),d0
     338:	80c1           	divu.w d1,d0
     33a:	3c80           	move.w d0,(a6)
     33c:	87c1           	divs.w d1,d3
     33e:	0643 00a0      	addi.w #160,d3
     342:	3d43 0002      	move.w d3,2(a6)
     346:	7000           	moveq #0,d0
     348:	302e 000e      	move.w 14(a6),d0
     34c:	80c2           	divu.w d2,d0
     34e:	3d40 0004      	move.w d0,4(a6)
     352:	89c2           	divs.w d2,d4
     354:	0644 00a0      	addi.w #160,d4
     358:	3d44 0006      	move.w d4,6(a6)
     35c:	4e75           	rts
     35e:	0000 0000      	ori.b #0,d0
     362:	00a0 0000 00a0 	ori.l #160,-(a0)
     368:	4000           	negx.b d0
     36a:	0000 0067      	ori.b #103,d0
     36e:	4000           	negx.b d0
     370:	0000 019a      	ori.b #-102,d0
     374:	0c79 0008 0000 	cmpi.w #8,0x28d8
     37a:	28d8 
     37c:	6700 0052      	beq.w 0x3d0
     380:	2079 0000 24d6 	movea.l 0x24d6,a0
     386:	41e8 0006      	lea 6(a0),a0
     38a:	43f9 0000 042c 	lea 0x42c,a1
     390:	303c 00a0      	move.w #160,d0
     394:	9056           	sub.w (a6),d0
     396:	e248           	lsr.w #1,d0
     398:	c0fc 000c      	mulu.w #12,d0
     39c:	d0c0           	adda.w d0,a0
     39e:	3e16           	move.w (a6),d7
     3a0:	2a3c 0000 a200 	move.l #41472,d5
     3a6:	8ac7           	divu.w d7,d5
     3a8:	0285 0000 ffff 	andi.l #65535,d5
     3ae:	e18d           	lsl.l #8,d5
     3b0:	7c00           	moveq #0,d6
     3b2:	5347           	subq.w #1,d7
     3b4:	dc85           	add.l d5,d6
     3b6:	2206           	move.l d6,d1
     3b8:	4241           	clr.w d1
     3ba:	4841           	swap d1
     3bc:	3001           	move.w d1,d0
     3be:	4841           	swap d1
     3c0:	9c81           	sub.l d1,d6
     3c2:	d040           	add.w d0,d0
     3c4:	30b1 0000      	move.w (0,a1,d0.w),(a0)
     3c8:	41e8 000c      	lea 12(a0),a0
     3cc:	51cf ffe6      	dbf d7,0x3b4
     3d0:	2079 0000 24d6 	movea.l 0x24d6,a0
     3d6:	41e8 000a      	lea 10(a0),a0
     3da:	43f9 0000 056c 	lea 0x56c,a1
     3e0:	303c 00a0      	move.w #160,d0
     3e4:	906e 0004      	sub.w 4(a6),d0
     3e8:	e248           	lsr.w #1,d0
     3ea:	c0fc 000c      	mulu.w #12,d0
     3ee:	d0c0           	adda.w d0,a0
     3f0:	3e2e 0004      	move.w 4(a6),d7
     3f4:	2a3c 0000 a200 	move.l #41472,d5
     3fa:	8ac7           	divu.w d7,d5
     3fc:	0285 0000 ffff 	andi.l #65535,d5
     402:	e18d           	lsl.l #8,d5
     404:	7c00           	moveq #0,d6
     406:	5347           	subq.w #1,d7
     408:	dc85           	add.l d5,d6
     40a:	2206           	move.l d6,d1
     40c:	4241           	clr.w d1
     40e:	4841           	swap d1
     410:	3001           	move.w d1,d0
     412:	4841           	swap d1
     414:	9c81           	sub.l d1,d6
     416:	d040           	add.w d0,d0
     418:	30b1 0000      	move.w (0,a1,d0.w),(a0)
     41c:	41e8 000c      	lea 12(a0),a0
     420:	51cf ffe6      	dbf d7,0x408
     424:	4e75           	rts
     426:	ffd8           	.short 0xffd8
     428:	010a ffd8      	movep.w -40(a2),d0
	...
     6ac:	7a00           	moveq #0,d5
     6ae:	3a16           	move.w (a6),d5
     6b0:	e14d           	lsl.w #8,d5
     6b2:	8afc 000a      	divu.w #10,d5
     6b6:	0285 0000 ffff 	andi.l #65535,d5
     6bc:	e18d           	lsl.l #8,d5
     6be:	7c00           	moveq #0,d6
     6c0:	2079 0000 2480 	movea.l 0x2480,a0
     6c6:	41e8 0078      	lea 120(a0),a0
     6ca:	2448           	movea.l a0,a2
     6cc:	2279 0000 1132 	movea.l 0x1132,a1
     6d2:	2649           	movea.l a1,a3
     6d4:	dc85           	add.l d5,d6
     6d6:	2206           	move.l d6,d1
     6d8:	4241           	clr.w d1
     6da:	4841           	swap d1
     6dc:	3001           	move.w d1,d0
     6de:	4841           	swap d1
     6e0:	9c81           	sub.l d1,d6
     6e2:	7410           	moveq #16,d2
     6e4:	9440           	sub.w d0,d2
     6e6:	c4fc 2580      	mulu.w #9600,d2
     6ea:	d3c2           	adda.l d2,a1
     6ec:	0c79 0008 0000 	cmpi.w #8,0x28d8
     6f2:	28d8 
     6f4:	6700 01b0      	beq.w 0x8a6
     6f8:	0814 0006      	btst #6,(a4)
     6fc:	66fa           	bne.s 0x6f8
     6fe:	297c ffff ffff 	move.l #-1,66(a4)
     704:	0042 
     706:	297c 09f0 0000 	move.l #166723584,62(a4)
     70c:	003e 
     70e:	297c 0000 0026 	move.l #38,98(a4)
     714:	0062 
     716:	2949 004e      	move.l a1,78(a4)
     71a:	2948 0052      	move.l a0,82(a4)
     71e:	397c 7801 0056 	move.w #30721,86(a4)
     724:	43e9 03c0      	lea 960(a1),a1
     728:	0814 0006      	btst #6,(a4)
     72c:	66fa           	bne.s 0x728
     72e:	297c ffff ffff 	move.l #-1,66(a4)
     734:	0042 
     736:	297c 0000 0026 	move.l #38,98(a4)
     73c:	0062 
     73e:	397c 0026 005e 	move.w #38,94(a4)
     744:	7e08           	moveq #8,d7
     746:	204a           	movea.l a2,a0
     748:	224b           	movea.l a3,a1
     74a:	dc85           	add.l d5,d6
     74c:	2406           	move.l d6,d2
     74e:	4242           	clr.w d2
     750:	4842           	swap d2
     752:	3202           	move.w d2,d1
     754:	4842           	swap d2
     756:	9c82           	sub.l d2,d6
     758:	7410           	moveq #16,d2
     75a:	9441           	sub.w d1,d2
     75c:	c4fc 2580      	mulu.w #9600,d2
     760:	d3c2           	adda.l d2,a1
     762:	7409           	moveq #9,d2
     764:	9447           	sub.w d7,d2
     766:	c4fc 03c0      	mulu.w #960,d2
     76a:	d3c2           	adda.l d2,a1
     76c:	3400           	move.w d0,d2
     76e:	e84a           	lsr.w #4,d2
     770:	d442           	add.w d2,d2
     772:	d0c2           	adda.w d2,a0
     774:	7400           	moveq #0,d2
     776:	3400           	move.w d0,d2
     778:	0242 000f      	andi.w #15,d2
     77c:	4a42           	tst.w d2
     77e:	6624           	bne.s 0x7a4
     780:	243c 09f0 0000 	move.l #166723584,d2
     786:	0814 0006      	btst #6,(a4)
     78a:	66fa           	bne.s 0x786
     78c:	2942 003e      	move.l d2,62(a4)
     790:	2949 004e      	move.l a1,78(a4)
     794:	2948 0052      	move.l a0,82(a4)
     798:	397c 7801 0056 	move.w #30721,86(a4)
     79e:	d041           	add.w d1,d0
     7a0:	6000 0076      	bra.w 0x818
     7a4:	7810           	moveq #16,d4
     7a6:	9842           	sub.w d2,d4
     7a8:	e85a           	ror.w #4,d2
     7aa:	3602           	move.w d2,d3
     7ac:	0042 0be2      	ori.w #3042,d2
     7b0:	4842           	swap d2
     7b2:	3403           	move.w d3,d2
     7b4:	0814 0006      	btst #6,(a4)
     7b8:	66fa           	bne.s 0x7b4
     7ba:	2942 003e      	move.l d2,62(a4)
     7be:	397c ffff 0070 	move.w #-1,112(a4)
     7c4:	2949 004e      	move.l a1,78(a4)
     7c8:	2948 0046      	move.l a0,70(a4)
     7cc:	2948 0052      	move.l a0,82(a4)
     7d0:	397c 7801 0056 	move.w #30721,86(a4)
     7d6:	3400           	move.w d0,d2
     7d8:	e84a           	lsr.w #4,d2
     7da:	d041           	add.w d1,d0
     7dc:	3600           	move.w d0,d3
     7de:	e84b           	lsr.w #4,d3
     7e0:	b642           	cmp.w d2,d3
     7e2:	6734           	beq.s 0x818
     7e4:	41e8 4b02      	lea 19202(a0),a0
     7e8:	43e9 03c0      	lea 960(a1),a1
     7ec:	7400           	moveq #0,d2
     7ee:	e85c           	ror.w #4,d4
     7f0:	3404           	move.w d4,d2
     7f2:	0044 0002      	ori.w #2,d4
     7f6:	0042 09f0      	ori.w #2544,d2
     7fa:	4842           	swap d2
     7fc:	3404           	move.w d4,d2
     7fe:	0814 0006      	btst #6,(a4)
     802:	66fa           	bne.s 0x7fe
     804:	2942 003e      	move.l d2,62(a4)
     808:	2949 004e      	move.l a1,78(a4)
     80c:	2948 0052      	move.l a0,82(a4)
     810:	397c 78c1 0056 	move.w #30913,86(a4)
     816:	6004           	bra.s 0x81c
     818:	43e9 03c0      	lea 960(a1),a1
     81c:	51cf ff28      	dbf d7,0x746
     820:	43ea ff88      	lea -120(a2),a1
     824:	4299           	clr.l (a1)+
     826:	4299           	clr.l (a1)+
     828:	4299           	clr.l (a1)+
     82a:	4299           	clr.l (a1)+
     82c:	4299           	clr.l (a1)+
     82e:	43e9 0014      	lea 20(a1),a1
     832:	4299           	clr.l (a1)+
     834:	4299           	clr.l (a1)+
     836:	4299           	clr.l (a1)+
     838:	4299           	clr.l (a1)+
     83a:	4299           	clr.l (a1)+
     83c:	43e9 0014      	lea 20(a1),a1
     840:	4299           	clr.l (a1)+
     842:	4299           	clr.l (a1)+
     844:	4299           	clr.l (a1)+
     846:	4299           	clr.l (a1)+
     848:	4299           	clr.l (a1)+
     84a:	43ea 4b00      	lea 19200(a2),a1
     84e:	4299           	clr.l (a1)+
     850:	4299           	clr.l (a1)+
     852:	4299           	clr.l (a1)+
     854:	4299           	clr.l (a1)+
     856:	4299           	clr.l (a1)+
     858:	43fa 074e      	lea 0xfa8(pc),a1
     85c:	204a           	movea.l a2,a0
     85e:	3400           	move.w d0,d2
     860:	e84a           	lsr.w #4,d2
     862:	d442           	add.w d2,d2
     864:	d0c2           	adda.w d2,a0
     866:	0240 000f      	andi.w #15,d0
     86a:	d040           	add.w d0,d0
     86c:	3031 0000      	move.w (0,a1,d0.w),d0
     870:	7424           	moveq #36,d2
     872:	0814 0006      	btst #6,(a4)
     876:	66fa           	bne.s 0x872
     878:	397c ffff 0072 	move.w #-1,114(a4)
     87e:	397c ffff 0044 	move.w #-1,68(a4)
     884:	3940 0042      	move.w d0,66(a4)
     888:	3942 005e      	move.w d2,94(a4)
     88c:	3942 0064      	move.w d2,100(a4)
     890:	2948 0046      	move.l a0,70(a4)
     894:	2948 0052      	move.l a0,82(a4)
     898:	297c 030a 0000 	move.l #50987008,62(a4)
     89e:	003e 
     8a0:	397c 7802 0056 	move.w #30722,86(a4)
     8a6:	7a00           	moveq #0,d5
     8a8:	3a2e 0004      	move.w 4(a6),d5
     8ac:	e14d           	lsl.w #8,d5
     8ae:	8afc 000a      	divu.w #10,d5
     8b2:	0285 0000 ffff 	andi.l #65535,d5
     8b8:	e18d           	lsl.l #8,d5
     8ba:	7c00           	moveq #0,d6
     8bc:	2079 0000 2480 	movea.l 0x2480,a0
     8c2:	41e8 4c40      	lea 19520(a0),a0
     8c6:	2448           	movea.l a0,a2
     8c8:	2279 0000 1136 	movea.l 0x1136,a1
     8ce:	2649           	movea.l a1,a3
     8d0:	dc85           	add.l d5,d6
     8d2:	2206           	move.l d6,d1
     8d4:	4241           	clr.w d1
     8d6:	4841           	swap d1
     8d8:	3001           	move.w d1,d0
     8da:	4841           	swap d1
     8dc:	9c81           	sub.l d1,d6
     8de:	7410           	moveq #16,d2
     8e0:	9440           	sub.w d0,d2
     8e2:	c4fc 1900      	mulu.w #6400,d2
     8e6:	d3c2           	adda.l d2,a1
     8e8:	2a79 0000 24da 	movea.l 0x24da,a5
     8ee:	4bed 0006      	lea 6(a5),a5
     8f2:	6100 01b0      	bsr.w 0xaa4
     8f6:	0814 0006      	btst #6,(a4)
     8fa:	66fa           	bne.s 0x8f6
     8fc:	0c79 0010 0000 	cmpi.w #16,0x28d8
     902:	28d8 
     904:	6600 0010      	bne.w 0x916
     908:	0c79 00bd 0000 	cmpi.w #189,0x28da
     90e:	28da 
     910:	6c04           	bge.s 0x916
     912:	6000 018e      	bra.w 0xaa2
     916:	297c ffff ffff 	move.l #-1,66(a4)
     91c:	0042 
     91e:	297c 09f0 0000 	move.l #166723584,62(a4)
     924:	003e 
     926:	297c 0000 0026 	move.l #38,98(a4)
     92c:	0062 
     92e:	2949 004e      	move.l a1,78(a4)
     932:	2948 0052      	move.l a0,82(a4)
     936:	397c 5001 0056 	move.w #20481,86(a4)
     93c:	43e9 0280      	lea 640(a1),a1
     940:	0814 0006      	btst #6,(a4)
     944:	66fa           	bne.s 0x940
     946:	297c ffff ffff 	move.l #-1,66(a4)
     94c:	0042 
     94e:	297c 0000 0026 	move.l #38,98(a4)
     954:	0062 
     956:	397c 0026 005e 	move.w #38,94(a4)
     95c:	7e08           	moveq #8,d7
     95e:	204a           	movea.l a2,a0
     960:	224b           	movea.l a3,a1
     962:	dc85           	add.l d5,d6
     964:	2406           	move.l d6,d2
     966:	4242           	clr.w d2
     968:	4842           	swap d2
     96a:	3202           	move.w d2,d1
     96c:	4842           	swap d2
     96e:	9c82           	sub.l d2,d6
     970:	7410           	moveq #16,d2
     972:	9441           	sub.w d1,d2
     974:	c4fc 1900      	mulu.w #6400,d2
     978:	d3c2           	adda.l d2,a1
     97a:	7409           	moveq #9,d2
     97c:	9447           	sub.w d7,d2
     97e:	c4fc 0280      	mulu.w #640,d2
     982:	d3c2           	adda.l d2,a1
     984:	3400           	move.w d0,d2
     986:	e84a           	lsr.w #4,d2
     988:	d442           	add.w d2,d2
     98a:	d0c2           	adda.w d2,a0
     98c:	7400           	moveq #0,d2
     98e:	3400           	move.w d0,d2
     990:	0242 000f      	andi.w #15,d2
     994:	4a42           	tst.w d2
     996:	6624           	bne.s 0x9bc
     998:	243c 09f0 0000 	move.l #166723584,d2
     99e:	0814 0006      	btst #6,(a4)
     9a2:	66fa           	bne.s 0x99e
     9a4:	2942 003e      	move.l d2,62(a4)
     9a8:	2949 004e      	move.l a1,78(a4)
     9ac:	2948 0052      	move.l a0,82(a4)
     9b0:	397c 5001 0056 	move.w #20481,86(a4)
     9b6:	d041           	add.w d1,d0
     9b8:	6000 0076      	bra.w 0xa30
     9bc:	7810           	moveq #16,d4
     9be:	9842           	sub.w d2,d4
     9c0:	e85a           	ror.w #4,d2
     9c2:	3602           	move.w d2,d3
     9c4:	0042 0be2      	ori.w #3042,d2
     9c8:	4842           	swap d2
     9ca:	3403           	move.w d3,d2
     9cc:	0814 0006      	btst #6,(a4)
     9d0:	66fa           	bne.s 0x9cc
     9d2:	2942 003e      	move.l d2,62(a4)
     9d6:	397c ffff 0070 	move.w #-1,112(a4)
     9dc:	2949 004e      	move.l a1,78(a4)
     9e0:	2948 0046      	move.l a0,70(a4)
     9e4:	2948 0052      	move.l a0,82(a4)
     9e8:	397c 5001 0056 	move.w #20481,86(a4)
     9ee:	3400           	move.w d0,d2
     9f0:	e84a           	lsr.w #4,d2
     9f2:	d041           	add.w d1,d0
     9f4:	3600           	move.w d0,d3
     9f6:	e84b           	lsr.w #4,d3
     9f8:	b642           	cmp.w d2,d3
     9fa:	6734           	beq.s 0xa30
     9fc:	41e8 3202      	lea 12802(a0),a0
     a00:	43e9 0280      	lea 640(a1),a1
     a04:	7400           	moveq #0,d2
     a06:	e85c           	ror.w #4,d4
     a08:	3404           	move.w d4,d2
     a0a:	0044 0002      	ori.w #2,d4
     a0e:	0042 09f0      	ori.w #2544,d2
     a12:	4842           	swap d2
     a14:	3404           	move.w d4,d2
     a16:	0814 0006      	btst #6,(a4)
     a1a:	66fa           	bne.s 0xa16
     a1c:	2942 003e      	move.l d2,62(a4)
     a20:	2949 004e      	move.l a1,78(a4)
     a24:	2948 0052      	move.l a0,82(a4)
     a28:	397c 5081 0056 	move.w #20609,86(a4)
     a2e:	6004           	bra.s 0xa34
     a30:	43e9 0280      	lea 640(a1),a1
     a34:	51cf ff28      	dbf d7,0x95e
     a38:	43ea ffb0      	lea -80(a2),a1
     a3c:	4299           	clr.l (a1)+
     a3e:	4299           	clr.l (a1)+
     a40:	4299           	clr.l (a1)+
     a42:	4299           	clr.l (a1)+
     a44:	4299           	clr.l (a1)+
     a46:	43e9 0014      	lea 20(a1),a1
     a4a:	4299           	clr.l (a1)+
     a4c:	4299           	clr.l (a1)+
     a4e:	4299           	clr.l (a1)+
     a50:	4299           	clr.l (a1)+
     a52:	4299           	clr.l (a1)+
     a54:	43fa 0552      	lea 0xfa8(pc),a1
     a58:	204a           	movea.l a2,a0
     a5a:	3400           	move.w d0,d2
     a5c:	e84a           	lsr.w #4,d2
     a5e:	d442           	add.w d2,d2
     a60:	d0c2           	adda.w d2,a0
     a62:	0240 000f      	andi.w #15,d0
     a66:	d040           	add.w d0,d0
     a68:	3031 0000      	move.w (0,a1,d0.w),d0
     a6c:	7424           	moveq #36,d2
     a6e:	0814 0006      	btst #6,(a4)
     a72:	66fa           	bne.s 0xa6e
     a74:	397c ffff 0072 	move.w #-1,114(a4)
     a7a:	397c ffff 0044 	move.w #-1,68(a4)
     a80:	3940 0042      	move.w d0,66(a4)
     a84:	3942 005e      	move.w d2,94(a4)
     a88:	3942 0064      	move.w d2,100(a4)
     a8c:	2948 0046      	move.l a0,70(a4)
     a90:	2948 0052      	move.l a0,82(a4)
     a94:	297c 030a 0000 	move.l #50987008,62(a4)
     a9a:	003e 
     a9c:	397c 5002 0056 	move.w #20482,86(a4)
     aa2:	4e75           	rts
     aa4:	74d8           	moveq #-40,d2
     aa6:	3b42 0000      	move.w d2,0(a5)
     aaa:	3b42 000c      	move.w d2,12(a5)
     aae:	3b42 0018      	move.w d2,24(a5)
     ab2:	3b42 0024      	move.w d2,36(a5)
     ab6:	3b42 0030      	move.w d2,48(a5)
     aba:	3b42 003c      	move.w d2,60(a5)
     abe:	3b42 0048      	move.w d2,72(a5)
     ac2:	3b42 0054      	move.w d2,84(a5)
     ac6:	3b42 0060      	move.w d2,96(a5)
     aca:	3b42 006c      	move.w d2,108(a5)
     ace:	3b42 0078      	move.w d2,120(a5)
     ad2:	3b42 0084      	move.w d2,132(a5)
     ad6:	3b42 0090      	move.w d2,144(a5)
     ada:	3b42 009c      	move.w d2,156(a5)
     ade:	3b42 00a8      	move.w d2,168(a5)
     ae2:	3b42 00b4      	move.w d2,180(a5)
     ae6:	3b42 00c0      	move.w d2,192(a5)
     aea:	3b42 00cc      	move.w d2,204(a5)
     aee:	3b42 00d8      	move.w d2,216(a5)
     af2:	3b42 00e4      	move.w d2,228(a5)
     af6:	3b42 00f0      	move.w d2,240(a5)
     afa:	3b42 00fc      	move.w d2,252(a5)
     afe:	3b42 0108      	move.w d2,264(a5)
     b02:	3b42 0114      	move.w d2,276(a5)
     b06:	3b42 0120      	move.w d2,288(a5)
     b0a:	3b42 012c      	move.w d2,300(a5)
     b0e:	3b42 0138      	move.w d2,312(a5)
     b12:	3b42 0144      	move.w d2,324(a5)
     b16:	3b42 0150      	move.w d2,336(a5)
     b1a:	3b42 015c      	move.w d2,348(a5)
     b1e:	3b42 0168      	move.w d2,360(a5)
     b22:	3b42 0174      	move.w d2,372(a5)
     b26:	3b42 0180      	move.w d2,384(a5)
     b2a:	3b42 018c      	move.w d2,396(a5)
     b2e:	3b42 0198      	move.w d2,408(a5)
     b32:	3b42 01a4      	move.w d2,420(a5)
     b36:	3b42 01b0      	move.w d2,432(a5)
     b3a:	3b42 01bc      	move.w d2,444(a5)
     b3e:	3b42 01c8      	move.w d2,456(a5)
     b42:	3b42 01d4      	move.w d2,468(a5)
     b46:	3b42 01e0      	move.w d2,480(a5)
     b4a:	3b42 01ec      	move.w d2,492(a5)
     b4e:	3b42 01f8      	move.w d2,504(a5)
     b52:	3b42 0204      	move.w d2,516(a5)
     b56:	3b42 0210      	move.w d2,528(a5)
     b5a:	3b42 021c      	move.w d2,540(a5)
     b5e:	3b42 0228      	move.w d2,552(a5)
     b62:	3b42 0234      	move.w d2,564(a5)
     b66:	3b42 0240      	move.w d2,576(a5)
     b6a:	3b42 024c      	move.w d2,588(a5)
     b6e:	3b42 0258      	move.w d2,600(a5)
     b72:	3b42 0264      	move.w d2,612(a5)
     b76:	3b42 0270      	move.w d2,624(a5)
     b7a:	3b42 027c      	move.w d2,636(a5)
     b7e:	3b42 0288      	move.w d2,648(a5)
     b82:	3b42 0294      	move.w d2,660(a5)
     b86:	3b42 02a0      	move.w d2,672(a5)
     b8a:	3b42 02ac      	move.w d2,684(a5)
     b8e:	3b42 02b8      	move.w d2,696(a5)
     b92:	3b42 02c4      	move.w d2,708(a5)
     b96:	3b42 02d0      	move.w d2,720(a5)
     b9a:	3b42 02dc      	move.w d2,732(a5)
     b9e:	3b42 02e8      	move.w d2,744(a5)
     ba2:	3b42 02f4      	move.w d2,756(a5)
     ba6:	3b42 0300      	move.w d2,768(a5)
     baa:	3b42 030c      	move.w d2,780(a5)
     bae:	3b42 0318      	move.w d2,792(a5)
     bb2:	3b42 0324      	move.w d2,804(a5)
     bb6:	3b42 0330      	move.w d2,816(a5)
     bba:	3b42 033c      	move.w d2,828(a5)
     bbe:	3b42 0348      	move.w d2,840(a5)
     bc2:	3b42 0354      	move.w d2,852(a5)
     bc6:	3b42 0360      	move.w d2,864(a5)
     bca:	3b42 036c      	move.w d2,876(a5)
     bce:	3b42 0378      	move.w d2,888(a5)
     bd2:	3b42 0384      	move.w d2,900(a5)
     bd6:	3b42 0390      	move.w d2,912(a5)
     bda:	3b42 039c      	move.w d2,924(a5)
     bde:	3b42 03a8      	move.w d2,936(a5)
     be2:	3b42 03b4      	move.w d2,948(a5)
     be6:	3b42 03c0      	move.w d2,960(a5)
     bea:	3b42 03cc      	move.w d2,972(a5)
     bee:	3b42 03d8      	move.w d2,984(a5)
     bf2:	3b42 03e4      	move.w d2,996(a5)
     bf6:	3b42 03f0      	move.w d2,1008(a5)
     bfa:	3b42 03fc      	move.w d2,1020(a5)
     bfe:	3b42 0408      	move.w d2,1032(a5)
     c02:	3b42 0414      	move.w d2,1044(a5)
     c06:	3b42 0420      	move.w d2,1056(a5)
     c0a:	3b42 042c      	move.w d2,1068(a5)
     c0e:	3b42 0438      	move.w d2,1080(a5)
     c12:	3b42 0444      	move.w d2,1092(a5)
     c16:	3b42 0450      	move.w d2,1104(a5)
     c1a:	3b42 045c      	move.w d2,1116(a5)
     c1e:	3b42 0468      	move.w d2,1128(a5)
     c22:	3b42 0474      	move.w d2,1140(a5)
     c26:	3b42 0480      	move.w d2,1152(a5)
     c2a:	3b42 048c      	move.w d2,1164(a5)
     c2e:	3b42 0498      	move.w d2,1176(a5)
     c32:	3b42 04a4      	move.w d2,1188(a5)
     c36:	3b42 04b0      	move.w d2,1200(a5)
     c3a:	3b42 04bc      	move.w d2,1212(a5)
     c3e:	3b42 04c8      	move.w d2,1224(a5)
     c42:	3b42 04d4      	move.w d2,1236(a5)
     c46:	3b42 04e0      	move.w d2,1248(a5)
     c4a:	3b42 04ec      	move.w d2,1260(a5)
     c4e:	3b42 04f8      	move.w d2,1272(a5)
     c52:	3b42 0504      	move.w d2,1284(a5)
     c56:	3b42 0510      	move.w d2,1296(a5)
     c5a:	3b42 051c      	move.w d2,1308(a5)
     c5e:	3b42 0528      	move.w d2,1320(a5)
     c62:	3b42 0534      	move.w d2,1332(a5)
     c66:	3b42 0540      	move.w d2,1344(a5)
     c6a:	3b42 054c      	move.w d2,1356(a5)
     c6e:	3b42 0558      	move.w d2,1368(a5)
     c72:	3b42 0564      	move.w d2,1380(a5)
     c76:	3b42 0570      	move.w d2,1392(a5)
     c7a:	3b42 057c      	move.w d2,1404(a5)
     c7e:	3b42 0588      	move.w d2,1416(a5)
     c82:	3b42 0594      	move.w d2,1428(a5)
     c86:	3b42 05a0      	move.w d2,1440(a5)
     c8a:	3b42 05ac      	move.w d2,1452(a5)
     c8e:	3b42 05b8      	move.w d2,1464(a5)
     c92:	3b42 05c4      	move.w d2,1476(a5)
     c96:	3b42 05d0      	move.w d2,1488(a5)
     c9a:	3b42 05dc      	move.w d2,1500(a5)
     c9e:	3b42 05e8      	move.w d2,1512(a5)
     ca2:	3b42 05f4      	move.w d2,1524(a5)
     ca6:	3b42 0600      	move.w d2,1536(a5)
     caa:	3b42 060c      	move.w d2,1548(a5)
     cae:	3b42 0618      	move.w d2,1560(a5)
     cb2:	3b42 0624      	move.w d2,1572(a5)
     cb6:	3b42 0630      	move.w d2,1584(a5)
     cba:	3b42 063c      	move.w d2,1596(a5)
     cbe:	3b42 0648      	move.w d2,1608(a5)
     cc2:	3b42 0654      	move.w d2,1620(a5)
     cc6:	3b42 0660      	move.w d2,1632(a5)
     cca:	3b42 066c      	move.w d2,1644(a5)
     cce:	3b42 0678      	move.w d2,1656(a5)
     cd2:	3b42 0684      	move.w d2,1668(a5)
     cd6:	3b42 0690      	move.w d2,1680(a5)
     cda:	3b42 069c      	move.w d2,1692(a5)
     cde:	3b42 06a8      	move.w d2,1704(a5)
     ce2:	3b42 06b4      	move.w d2,1716(a5)
     ce6:	3b42 06c0      	move.w d2,1728(a5)
     cea:	3b42 06cc      	move.w d2,1740(a5)
     cee:	3b42 06d8      	move.w d2,1752(a5)
     cf2:	3b42 06e4      	move.w d2,1764(a5)
     cf6:	3b42 06f0      	move.w d2,1776(a5)
     cfa:	3b42 06fc      	move.w d2,1788(a5)
     cfe:	3b42 0708      	move.w d2,1800(a5)
     d02:	3b42 0714      	move.w d2,1812(a5)
     d06:	3b42 0720      	move.w d2,1824(a5)
     d0a:	3b42 072c      	move.w d2,1836(a5)
     d0e:	3b42 0738      	move.w d2,1848(a5)
     d12:	3b42 0744      	move.w d2,1860(a5)
     d16:	3b42 0750      	move.w d2,1872(a5)
     d1a:	3b42 075c      	move.w d2,1884(a5)
     d1e:	3b42 0768      	move.w d2,1896(a5)
     d22:	3b42 0774      	move.w d2,1908(a5)
     d26:	3b42 0004      	move.w d2,4(a5)
     d2a:	3b42 0010      	move.w d2,16(a5)
     d2e:	3b42 001c      	move.w d2,28(a5)
     d32:	3b42 0028      	move.w d2,40(a5)
     d36:	3b42 0034      	move.w d2,52(a5)
     d3a:	3b42 0040      	move.w d2,64(a5)
     d3e:	3b42 004c      	move.w d2,76(a5)
     d42:	3b42 0058      	move.w d2,88(a5)
     d46:	3b42 0064      	move.w d2,100(a5)
     d4a:	3b42 0070      	move.w d2,112(a5)
     d4e:	3b42 007c      	move.w d2,124(a5)
     d52:	3b42 0088      	move.w d2,136(a5)
     d56:	3b42 0094      	move.w d2,148(a5)
     d5a:	3b42 00a0      	move.w d2,160(a5)
     d5e:	3b42 00ac      	move.w d2,172(a5)
     d62:	3b42 00b8      	move.w d2,184(a5)
     d66:	3b42 00c4      	move.w d2,196(a5)
     d6a:	3b42 00d0      	move.w d2,208(a5)
     d6e:	3b42 00dc      	move.w d2,220(a5)
     d72:	3b42 00e8      	move.w d2,232(a5)
     d76:	3b42 00f4      	move.w d2,244(a5)
     d7a:	3b42 0100      	move.w d2,256(a5)
     d7e:	3b42 010c      	move.w d2,268(a5)
     d82:	3b42 0118      	move.w d2,280(a5)
     d86:	3b42 0124      	move.w d2,292(a5)
     d8a:	3b42 0130      	move.w d2,304(a5)
     d8e:	3b42 013c      	move.w d2,316(a5)
     d92:	3b42 0148      	move.w d2,328(a5)
     d96:	3b42 0154      	move.w d2,340(a5)
     d9a:	3b42 0160      	move.w d2,352(a5)
     d9e:	3b42 016c      	move.w d2,364(a5)
     da2:	3b42 0178      	move.w d2,376(a5)
     da6:	3b42 0184      	move.w d2,388(a5)
     daa:	3b42 0190      	move.w d2,400(a5)
     dae:	3b42 019c      	move.w d2,412(a5)
     db2:	3b42 01a8      	move.w d2,424(a5)
     db6:	3b42 01b4      	move.w d2,436(a5)
     dba:	3b42 01c0      	move.w d2,448(a5)
     dbe:	3b42 01cc      	move.w d2,460(a5)
     dc2:	3b42 01d8      	move.w d2,472(a5)
     dc6:	3b42 01e4      	move.w d2,484(a5)
     dca:	3b42 01f0      	move.w d2,496(a5)
     dce:	3b42 01fc      	move.w d2,508(a5)
     dd2:	3b42 0208      	move.w d2,520(a5)
     dd6:	3b42 0214      	move.w d2,532(a5)
     dda:	3b42 0220      	move.w d2,544(a5)
     dde:	3b42 022c      	move.w d2,556(a5)
     de2:	3b42 0238      	move.w d2,568(a5)
     de6:	3b42 0244      	move.w d2,580(a5)
     dea:	3b42 0250      	move.w d2,592(a5)
     dee:	3b42 025c      	move.w d2,604(a5)
     df2:	3b42 0268      	move.w d2,616(a5)
     df6:	3b42 0274      	move.w d2,628(a5)
     dfa:	3b42 0280      	move.w d2,640(a5)
     dfe:	3b42 028c      	move.w d2,652(a5)
     e02:	3b42 0298      	move.w d2,664(a5)
     e06:	3b42 02a4      	move.w d2,676(a5)
     e0a:	3b42 02b0      	move.w d2,688(a5)
     e0e:	3b42 02bc      	move.w d2,700(a5)
     e12:	3b42 02c8      	move.w d2,712(a5)
     e16:	3b42 02d4      	move.w d2,724(a5)
     e1a:	3b42 02e0      	move.w d2,736(a5)
     e1e:	3b42 02ec      	move.w d2,748(a5)
     e22:	3b42 02f8      	move.w d2,760(a5)
     e26:	3b42 0304      	move.w d2,772(a5)
     e2a:	3b42 0310      	move.w d2,784(a5)
     e2e:	3b42 031c      	move.w d2,796(a5)
     e32:	3b42 0328      	move.w d2,808(a5)
     e36:	3b42 0334      	move.w d2,820(a5)
     e3a:	3b42 0340      	move.w d2,832(a5)
     e3e:	3b42 034c      	move.w d2,844(a5)
     e42:	3b42 0358      	move.w d2,856(a5)
     e46:	3b42 0364      	move.w d2,868(a5)
     e4a:	3b42 0370      	move.w d2,880(a5)
     e4e:	3b42 037c      	move.w d2,892(a5)
     e52:	3b42 0388      	move.w d2,904(a5)
     e56:	3b42 0394      	move.w d2,916(a5)
     e5a:	3b42 03a0      	move.w d2,928(a5)
     e5e:	3b42 03ac      	move.w d2,940(a5)
     e62:	3b42 03b8      	move.w d2,952(a5)
     e66:	3b42 03c4      	move.w d2,964(a5)
     e6a:	3b42 03d0      	move.w d2,976(a5)
     e6e:	3b42 03dc      	move.w d2,988(a5)
     e72:	3b42 03e8      	move.w d2,1000(a5)
     e76:	3b42 03f4      	move.w d2,1012(a5)
     e7a:	3b42 0400      	move.w d2,1024(a5)
     e7e:	3b42 040c      	move.w d2,1036(a5)
     e82:	3b42 0418      	move.w d2,1048(a5)
     e86:	3b42 0424      	move.w d2,1060(a5)
     e8a:	3b42 0430      	move.w d2,1072(a5)
     e8e:	3b42 043c      	move.w d2,1084(a5)
     e92:	3b42 0448      	move.w d2,1096(a5)
     e96:	3b42 0454      	move.w d2,1108(a5)
     e9a:	3b42 0460      	move.w d2,1120(a5)
     e9e:	3b42 046c      	move.w d2,1132(a5)
     ea2:	3b42 0478      	move.w d2,1144(a5)
     ea6:	3b42 0484      	move.w d2,1156(a5)
     eaa:	3b42 0490      	move.w d2,1168(a5)
     eae:	3b42 049c      	move.w d2,1180(a5)
     eb2:	3b42 04a8      	move.w d2,1192(a5)
     eb6:	3b42 04b4      	move.w d2,1204(a5)
     eba:	3b42 04c0      	move.w d2,1216(a5)
     ebe:	3b42 04cc      	move.w d2,1228(a5)
     ec2:	3b42 04d8      	move.w d2,1240(a5)
     ec6:	3b42 04e4      	move.w d2,1252(a5)
     eca:	3b42 04f0      	move.w d2,1264(a5)
     ece:	3b42 04fc      	move.w d2,1276(a5)
     ed2:	3b42 0508      	move.w d2,1288(a5)
     ed6:	3b42 0514      	move.w d2,1300(a5)
     eda:	3b42 0520      	move.w d2,1312(a5)
     ede:	3b42 052c      	move.w d2,1324(a5)
     ee2:	3b42 0538      	move.w d2,1336(a5)
     ee6:	3b42 0544      	move.w d2,1348(a5)
     eea:	3b42 0550      	move.w d2,1360(a5)
     eee:	3b42 055c      	move.w d2,1372(a5)
     ef2:	3b42 0568      	move.w d2,1384(a5)
     ef6:	3b42 0574      	move.w d2,1396(a5)
     efa:	3b42 0580      	move.w d2,1408(a5)
     efe:	3b42 058c      	move.w d2,1420(a5)
     f02:	3b42 0598      	move.w d2,1432(a5)
     f06:	3b42 05a4      	move.w d2,1444(a5)
     f0a:	3b42 05b0      	move.w d2,1456(a5)
     f0e:	3b42 05bc      	move.w d2,1468(a5)
     f12:	3b42 05c8      	move.w d2,1480(a5)
     f16:	3b42 05d4      	move.w d2,1492(a5)
     f1a:	3b42 05e0      	move.w d2,1504(a5)
     f1e:	3b42 05ec      	move.w d2,1516(a5)
     f22:	3b42 05f8      	move.w d2,1528(a5)
     f26:	3b42 0604      	move.w d2,1540(a5)
     f2a:	3b42 0610      	move.w d2,1552(a5)
     f2e:	3b42 061c      	move.w d2,1564(a5)
     f32:	3b42 0628      	move.w d2,1576(a5)
     f36:	3b42 0634      	move.w d2,1588(a5)
     f3a:	3b42 0640      	move.w d2,1600(a5)
     f3e:	3b42 064c      	move.w d2,1612(a5)
     f42:	3b42 0658      	move.w d2,1624(a5)
     f46:	3b42 0664      	move.w d2,1636(a5)
     f4a:	3b42 0670      	move.w d2,1648(a5)
     f4e:	3b42 067c      	move.w d2,1660(a5)
     f52:	3b42 0688      	move.w d2,1672(a5)
     f56:	3b42 0694      	move.w d2,1684(a5)
     f5a:	3b42 06a0      	move.w d2,1696(a5)
     f5e:	3b42 06ac      	move.w d2,1708(a5)
     f62:	3b42 06b8      	move.w d2,1720(a5)
     f66:	3b42 06c4      	move.w d2,1732(a5)
     f6a:	3b42 06d0      	move.w d2,1744(a5)
     f6e:	3b42 06dc      	move.w d2,1756(a5)
     f72:	3b42 06e8      	move.w d2,1768(a5)
     f76:	3b42 06f4      	move.w d2,1780(a5)
     f7a:	3b42 0700      	move.w d2,1792(a5)
     f7e:	3b42 070c      	move.w d2,1804(a5)
     f82:	3b42 0718      	move.w d2,1816(a5)
     f86:	3b42 0724      	move.w d2,1828(a5)
     f8a:	3b42 0730      	move.w d2,1840(a5)
     f8e:	3b42 073c      	move.w d2,1852(a5)
     f92:	3b42 0748      	move.w d2,1864(a5)
     f96:	3b42 0754      	move.w d2,1876(a5)
     f9a:	3b42 0760      	move.w d2,1888(a5)
     f9e:	3b42 076c      	move.w d2,1900(a5)
     fa2:	3b42 0778      	move.w d2,1912(a5)
     fa6:	4e75           	rts
     fa8:	ffff           	.short 0xffff
     faa:	7fff           	.short 0x7fff
     fac:	3fff           	.short 0x3fff
     fae:	1fff           	.short 0x1fff
     fb0:	0fff           	.short 0x0fff
     fb2:	07ff           	.short 0x07ff
     fb4:	03ff           	.short 0x03ff
     fb6:	01ff           	.short 0x01ff
     fb8:	00ff           	.short 0x00ff
     fba:	007f           	.short 0x007f
     fbc:	003f           	.short 0x003f
     fbe:	001f 000f      	ori.b #15,(sp)+
     fc2:	0007 0003      	ori.b #3,d7
     fc6:	0001 41f9      	ori.b #-7,d1
     fca:	0000 0028      	ori.b #40,d0
     fce:	203c 0000 17bc 	move.l #6076,d0
     fd4:	7200           	moveq #0,d1
     fd6:	7408           	moveq #8,d2
     fd8:	363c 0120      	move.w #288,d3
     fdc:	4eae ff8e      	jsr -114(a6)
     fe0:	4eae fee6      	jsr -282(a6)
     fe4:	3028 001c      	move.w 28(a0),d0
     fe8:	8179 0000 0016 	or.w d0,0x16
     fee:	48e7 000e      	movem.l a4-a6,-(sp)
     ff2:	203c 0001 7700 	move.l #96000,d0
     ff8:	223c 0000 0000 	move.l #0,d1
     ffe:	4eae ffd6      	jsr -42(a6)
    1002:	23c0 0000 1136 	move.l d0,0x1136
    1008:	203c 0002 3280 	move.l #144000,d0
    100e:	223c 0000 0000 	move.l #0,d1
    1014:	4eae ffd6      	jsr -42(a6)
    1018:	23c0 0000 1132 	move.l d0,0x1132
    101e:	6100 020a      	bsr.w 0x122a
    1022:	6100 0158      	bsr.w 0x117c
    1026:	49f9 00df f002 	lea 0xdff002,a4
    102c:	41f9 0000 2900 	lea 0x2900,a0
    1032:	43f9 0000 00a6 	lea 0xa6,a1
    1038:	7e0f           	moveq #15,d7
    103a:	3298           	move.w (a0)+,(a1)
    103c:	5849           	addq.w #4,a1
    103e:	51cf fffa      	dbf d7,0x103a
    1042:	6100 137c      	bsr.w 0x23c0
    1046:	6100 144e      	bsr.w 0x2496
    104a:	6100 0130      	bsr.w 0x117c
    104e:	23fc 0000 00a4 	move.l #164,0x25c8
    1054:	0000 25c8 
    1058:	4279 0000 25d4 	clr.w 0x25d4
    105e:	33fc 0000 0000 	move.w #0,0x25d2
    1064:	25d2 
    1066:	33fc 0010 0000 	move.w #16,0x25d6
    106c:	25d6 
    106e:	4279 0000 28d8 	clr.w 0x28d8
    1074:	4279 0000 28da 	clr.w 0x28da
    107a:	4279 0000 035e 	clr.w 0x35e
    1080:	33fc 000a 0000 	move.w #10,0x1142
    1086:	1142 
    1088:	0814 0006      	btst #6,(a4)
    108c:	66fa           	bne.s 0x1088
    108e:	4cdf 7000      	movem.l (sp)+,a4-a6
    1092:	4e75           	rts
    1094:	48e7 000e      	movem.l a4-a6,-(sp)
    1098:	203c 0000 fed8 	move.l #65240,d0
    109e:	223c 0000 0041 	move.l #65,d1
    10a4:	4eae ffd6      	jsr -42(a6)
    10a8:	0680 0000 0028 	addi.l #40,d0
    10ae:	41f9 0000 248a 	lea 0x248a,a0
    10b4:	2080           	move.l d0,(a0)
    10b6:	2140 0008      	move.l d0,8(a0)
    10ba:	0680 0000 7f58 	addi.l #32600,d0
    10c0:	2140 0004      	move.l d0,4(a0)
    10c4:	203c 0001 7700 	move.l #96000,d0
    10ca:	223c 0000 0001 	move.l #1,d1
    10d0:	4eae ffd6      	jsr -42(a6)
    10d4:	23c0 0000 113e 	move.l d0,0x113e
    10da:	2079 0000 1136 	movea.l 0x1136,a0
    10e0:	2279 0000 113e 	movea.l 0x113e,a1
    10e6:	3e3c 03bf      	move.w #959,d7
    10ea:	6100 0058      	bsr.w 0x1144
    10ee:	23f9 0000 113e 	move.l 0x113e,0x1136
    10f4:	0000 1136 
    10f8:	203c 0002 3280 	move.l #144000,d0
    10fe:	223c 0000 0001 	move.l #1,d1
    1104:	4eae ffd6      	jsr -42(a6)
    1108:	23c0 0000 113a 	move.l d0,0x113a
    110e:	2079 0000 1132 	movea.l 0x1132,a0
    1114:	2279 0000 113a 	movea.l 0x113a,a1
    111a:	3e3c 059f      	move.w #1439,d7
    111e:	6100 0024      	bsr.w 0x1144
    1122:	23f9 0000 113a 	move.l 0x113a,0x1132
    1128:	0000 1132 
    112c:	4cdf 7000      	movem.l (sp)+,a4-a6
    1130:	4e75           	rts
	...
    1142:	0000 22d8      	ori.b #-40,d0
    1146:	22d8           	move.l (a0)+,(a1)+
    1148:	22d8           	move.l (a0)+,(a1)+
    114a:	22d8           	move.l (a0)+,(a1)+
    114c:	22d8           	move.l (a0)+,(a1)+
    114e:	22d8           	move.l (a0)+,(a1)+
    1150:	22d8           	move.l (a0)+,(a1)+
    1152:	22d8           	move.l (a0)+,(a1)+
    1154:	22d8           	move.l (a0)+,(a1)+
    1156:	22d8           	move.l (a0)+,(a1)+
    1158:	22d8           	move.l (a0)+,(a1)+
    115a:	22d8           	move.l (a0)+,(a1)+
    115c:	22d8           	move.l (a0)+,(a1)+
    115e:	22d8           	move.l (a0)+,(a1)+
    1160:	22d8           	move.l (a0)+,(a1)+
    1162:	22d8           	move.l (a0)+,(a1)+
    1164:	22d8           	move.l (a0)+,(a1)+
    1166:	22d8           	move.l (a0)+,(a1)+
    1168:	22d8           	move.l (a0)+,(a1)+
    116a:	22d8           	move.l (a0)+,(a1)+
    116c:	22d8           	move.l (a0)+,(a1)+
    116e:	22d8           	move.l (a0)+,(a1)+
    1170:	22d8           	move.l (a0)+,(a1)+
    1172:	22d8           	move.l (a0)+,(a1)+
    1174:	22d8           	move.l (a0)+,(a1)+
    1176:	51cf ffcc      	dbf d7,0x1144
    117a:	4e75           	rts
    117c:	41f9 0000 088a 	lea 0x88a,a0
    1182:	43f9 0000 101e 	lea 0x101e,a1
    1188:	45f9 0000 17b2 	lea 0x17b2,a2
    118e:	203c 0000 00f0 	move.l #240,d0
    1194:	3140 0004      	move.w d0,4(a0)
    1198:	3340 0004      	move.w d0,4(a1)
    119c:	3540 0004      	move.w d0,4(a2)
    11a0:	4840           	swap d0
    11a2:	3080           	move.w d0,(a0)
    11a4:	3280           	move.w d0,(a1)
    11a6:	3480           	move.w d0,(a2)
    11a8:	41f9 0000 0100 	lea 0x100,a0
    11ae:	43f9 0000 0894 	lea 0x894,a1
    11b4:	45f9 0000 1028 	lea 0x1028,a2
    11ba:	303c 5901      	move.w #22785,d0
    11be:	3e3c 009f      	move.w #159,d7
    11c2:	30c0           	move.w d0,(a0)+
    11c4:	32c0           	move.w d0,(a1)+
    11c6:	34c0           	move.w d0,(a2)+
    11c8:	0640 0100      	addi.w #256,d0
    11cc:	30fc fffe      	move.w #-2,(a0)+
    11d0:	32fc fffe      	move.w #-2,(a1)+
    11d4:	34fc fffe      	move.w #-2,(a2)+
    11d8:	20fc 0108 ffd8 	move.l #17367000,(a0)+
    11de:	22fc 0108 ffd8 	move.l #17367000,(a1)+
    11e4:	24fc 0108 ffd8 	move.l #17367000,(a2)+
    11ea:	20fc 010a ffd8 	move.l #17498072,(a0)+
    11f0:	22fc 010a ffd8 	move.l #17498072,(a1)+
    11f6:	24fc 010a ffd8 	move.l #17498072,(a2)+
    11fc:	51cf ffc4      	dbf d7,0x11c2
    1200:	41f9 0000 042c 	lea 0x42c,a0
    1206:	43f9 0000 056c 	lea 0x56c,a1
    120c:	303c ffd8      	move.w #-40,d0
    1210:	323c ffd8      	move.w #-40,d1
    1214:	3e3c 009f      	move.w #159,d7
    1218:	30c0           	move.w d0,(a0)+
    121a:	32c1           	move.w d1,(a1)+
    121c:	0640 0078      	addi.w #120,d0
    1220:	0641 0050      	addi.w #80,d1
    1224:	51cf fff2      	dbf d7,0x1218
    1228:	4e75           	rts
    122a:	41f9 0000 2362 	lea 0x2362,a0
    1230:	43f9 0000 1362 	lea 0x1362,a1
    1236:	7e0d           	moveq #13,d7
    1238:	45f9 0000 2380 	lea 0x2380,a2
    123e:	2649           	movea.l a1,a3
    1240:	3018           	move.w (a0)+,d0
    1242:	7c0f           	moveq #15,d6
    1244:	0800 0000      	btst #0,d0
    1248:	6702           	beq.s 0x124c
    124a:	26d2           	move.l (a2),(a3)+
    124c:	e248           	lsr.w #1,d0
    124e:	45ea 0004      	lea 4(a2),a2
    1252:	51ce fff0      	dbf d6,0x1244
    1256:	43e9 003c      	lea 60(a1),a1
    125a:	51cf ffdc      	dbf d7,0x1238
    125e:	49f9 0000 1362 	lea 0x1362,a4
    1264:	47f9 0000 16f6 	lea 0x16f6,a3
    126a:	7e0e           	moveq #14,d7
    126c:	244b           	movea.l a3,a2
    126e:	204c           	movea.l a4,a0
    1270:	4a50           	tst.w (a0)
    1272:	6718           	beq.s 0x128c
    1274:	43f9 0000 16e8 	lea 0x16e8,a1
    127a:	24d9           	move.l (a1)+,(a2)+
    127c:	24d9           	move.l (a1)+,(a2)+
    127e:	3558 fffe      	move.w (a0)+,-2(a2)
    1282:	24d9           	move.l (a1)+,(a2)+
    1284:	3558 fffe      	move.w (a0)+,-2(a2)
    1288:	34d9           	move.w (a1)+,(a2)+
    128a:	60e4           	bra.s 0x1270
    128c:	34f9 0000 16e6 	move.w 0x16e6,(a2)+
    1292:	47eb 00d4      	lea 212(a3),a3
    1296:	49ec 003c      	lea 60(a4),a4
    129a:	51cf ffd0      	dbf d7,0x126c
    129e:	2079 0000 1136 	movea.l 0x1136,a0
    12a4:	43f9 0000 4f34 	lea 0x4f34,a1
    12aa:	45e9 0c80      	lea 3200(a1),a2
    12ae:	4bf9 0000 16f6 	lea 0x16f6,a5
    12b4:	3a3c 000d      	move.w #13,d5
    12b8:	3c3c 0009      	move.w #9,d6
    12bc:	3e3c 009f      	move.w #159,d7
    12c0:	3011           	move.w (a1),d0
    12c2:	4e95           	jsr (a5)
    12c4:	30c0           	move.w d0,(a0)+
    12c6:	3012           	move.w (a2),d0
    12c8:	4e95           	jsr (a5)
    12ca:	30c0           	move.w d0,(a0)+
    12cc:	43e9 0014      	lea 20(a1),a1
    12d0:	45ea 0014      	lea 20(a2),a2
    12d4:	51cf ffea      	dbf d7,0x12c0
    12d8:	43e9 f382      	lea -3198(a1),a1
    12dc:	45ea f382      	lea -3198(a2),a2
    12e0:	51ce ffda      	dbf d6,0x12bc
    12e4:	4bed 00d4      	lea 212(a5),a5
    12e8:	43e9 ffec      	lea -20(a1),a1
    12ec:	45ea ffec      	lea -20(a2),a2
    12f0:	51cd ffc6      	dbf d5,0x12b8
    12f4:	2079 0000 1132 	movea.l 0x1132,a0
    12fa:	43f9 0000 29b4 	lea 0x29b4,a1
    1300:	45e9 0c80      	lea 3200(a1),a2
    1304:	47ea 0c80      	lea 3200(a2),a3
    1308:	4bf9 0000 16f6 	lea 0x16f6,a5
    130e:	3a3c 000d      	move.w #13,d5
    1312:	3c3c 0009      	move.w #9,d6
    1316:	3e3c 009f      	move.w #159,d7
    131a:	3011           	move.w (a1),d0
    131c:	4e95           	jsr (a5)
    131e:	30c0           	move.w d0,(a0)+
    1320:	3012           	move.w (a2),d0
    1322:	4e95           	jsr (a5)
    1324:	30c0           	move.w d0,(a0)+
    1326:	3013           	move.w (a3),d0
    1328:	4e95           	jsr (a5)
    132a:	30c0           	move.w d0,(a0)+
    132c:	43e9 0014      	lea 20(a1),a1
    1330:	45ea 0014      	lea 20(a2),a2
    1334:	47eb 0014      	lea 20(a3),a3
    1338:	51cf ffe0      	dbf d7,0x131a
    133c:	43e9 f382      	lea -3198(a1),a1
    1340:	45ea f382      	lea -3198(a2),a2
    1344:	47eb f382      	lea -3198(a3),a3
    1348:	51ce ffcc      	dbf d6,0x1316
    134c:	4bed 00d4      	lea 212(a5),a5
    1350:	43e9 ffec      	lea -20(a1),a1
    1354:	45ea ffec      	lea -20(a2),a2
    1358:	47eb ffec      	lea -20(a3),a3
    135c:	51cd ffb4      	dbf d5,0x1312
    1360:	4e75           	rts
	...
    16e6:	4e75           	rts
    16e8:	3200           	move.w d0,d1
    16ea:	d241           	add.w d1,d1
    16ec:	0241 0000      	andi.w #0,d1
    16f0:	0240 0000      	andi.w #0,d0
    16f4:	8041           	or.w d1,d0
	...
    2362:	0000 8000      	ori.b #0,d0
    2366:	8080           	or.l d0,d0
    2368:	8410           	or.b (a0),d2
    236a:	8888           	.short 0x8888
    236c:	9124           	sub.b d0,-(a4)
    236e:	9292           	sub.l (a2),d1
    2370:	aa54           	.short 0xaa54
    2372:	aaaa abaa baba 	msac.l a2,a2,<<,-17734(a2)&,d5
    2378:	bbae bbbb      	eor.l d5,-17477(a6)
    237c:	def7 efef 0001 	([,-131069)adda.w ([1],-131069),sp
    2382:	fffe 0003 
    2386:	fffc           	.short 0xfffc
    2388:	0007 fff8      	ori.b #-8,d7
    238c:	000f           	.short 0x000f
    238e:	fff0           	.short 0xfff0
    2390:	001f ffe0      	ori.b #-32,(sp)+
    2394:	003f           	.short 0x003f
    2396:	ffc0           	.short 0xffc0
    2398:	007f           	.short 0x007f
    239a:	ff80 00ff      	cp1st.l d0,d0,#1,#255
    239e:	ff00 01ff      	cp1st.b d0,d0,#1,#511
    23a2:	fe00 03ff      	cp1ld.b d0,d0,#2,#511
    23a6:	fc00 07ff      	cp0ld.b d0,d0,#4,#511
    23aa:	f800           	.short 0xf800
    23ac:	0fff           	.short 0x0fff
    23ae:	f000           	.short 0xf000
    23b0:	1fff           	.short 0x1fff
    23b2:	e000           	asr.b #8,d0
    23b4:	3fff           	.short 0x3fff
    23b6:	c000           	and.b d0,d0
    23b8:	7fff           	.short 0x7fff
    23ba:	8000           	or.b d0,d0
    23bc:	ffff           	.short 0xffff
    23be:	0000 5879      	ori.b #121,d0
    23c2:	0000 2488      	ori.b #-120,d0
    23c6:	0c79 0008 0000 	cmpi.w #8,0x2488
    23cc:	2488 
    23ce:	6606           	bne.s 0x23d6
    23d0:	4279 0000 2488 	clr.w 0x2488
    23d6:	41f9 0000 248a 	lea 0x248a,a0
    23dc:	d0f9 0000 2488 	adda.w 0x2488,a0
    23e2:	2618           	move.l (a0)+,d3
    23e4:	23d0 0000 2480 	move.l (a0),0x2480
    23ea:	3016           	move.w (a6),d0
    23ec:	e248           	lsr.w #1,d0
    23ee:	322e 0002      	move.w 2(a6),d1
    23f2:	9240           	sub.w d0,d1
    23f4:	3401           	move.w d1,d2
    23f6:	e849           	lsr.w #4,d1
    23f8:	d241           	add.w d1,d1
    23fa:	0242 000f      	andi.w #15,d2
    23fe:	302e 0004      	move.w 4(a6),d0
    2402:	e248           	lsr.w #1,d0
    2404:	3a2e 0006      	move.w 6(a6),d5
    2408:	9a40           	sub.w d0,d5
    240a:	3805           	move.w d5,d4
    240c:	e84d           	lsr.w #4,d5
    240e:	da45           	add.w d5,d5
    2410:	0244 000f      	andi.w #15,d4
    2414:	e94c           	lsl.w #4,d4
    2416:	8444           	or.w d4,d2
    2418:	33c2 0000 001a 	move.w d2,0x1a
    241e:	41f9 0000 0068 	lea 0x68,a0
    2424:	2003           	move.l d3,d0
    2426:	9041           	sub.w d1,d0
    2428:	3140 0006      	move.w d0,6(a0)
    242c:	4840           	swap d0
    242e:	3140 0002      	move.w d0,2(a0)
    2432:	4840           	swap d0
    2434:	0680 0000 0028 	addi.l #40,d0
    243a:	3140 0016      	move.w d0,22(a0)
    243e:	4840           	swap d0
    2440:	3140 0012      	move.w d0,18(a0)
    2444:	4840           	swap d0
    2446:	0680 0000 0028 	addi.l #40,d0
    244c:	3140 0026      	move.w d0,38(a0)
    2450:	4840           	swap d0
    2452:	3140 0022      	move.w d0,34(a0)
    2456:	4840           	swap d0
    2458:	2003           	move.l d3,d0
    245a:	0680 0000 4bf0 	addi.l #19440,d0
    2460:	9045           	sub.w d5,d0
    2462:	3140 000e      	move.w d0,14(a0)
    2466:	4840           	swap d0
    2468:	3140 000a      	move.w d0,10(a0)
    246c:	4840           	swap d0
    246e:	0680 0000 0028 	addi.l #40,d0
    2474:	3140 001e      	move.w d0,30(a0)
    2478:	4840           	swap d0
    247a:	3140 001a      	move.w d0,26(a0)
    247e:	4e75           	rts
	...
    2494:	0000 5879      	ori.b #121,d0
    2498:	0000 24de      	ori.b #-34,d0
    249c:	0c79 000c 0000 	cmpi.w #12,0x24de
    24a2:	24de 
    24a4:	6606           	bne.s 0x24ac
    24a6:	4279 0000 24de 	clr.w 0x24de
    24ac:	41f9 0000 24e0 	lea 0x24e0,a0
    24b2:	d0f9 0000 24de 	adda.w 0x24de,a0
    24b8:	2018           	move.l (a0)+,d0
    24ba:	23d8 0000 24d6 	move.l (a0)+,0x24d6
    24c0:	23d0 0000 24da 	move.l (a0),0x24da
    24c6:	41f9 0000 00e6 	lea 0xe6,a0
    24cc:	3140 0004      	move.w d0,4(a0)
    24d0:	4840           	swap d0
    24d2:	3080           	move.w d0,(a0)
    24d4:	4e75           	rts
	...
    24e2:	0100           	btst d0,d0
    24e4:	0000 0894      	ori.b #-108,d0
    24e8:	0000 1028      	ori.b #40,d0
    24ec:	0000 0100      	ori.b #0,d0
    24f0:	0000 0894      	ori.b #-108,d0
    24f4:	0000 1028      	ori.b #40,d0
    24f8:	0814 0006      	btst #6,(a4)
    24fc:	66fa           	bne.s 0x24f8
    24fe:	297c ffff ffff 	move.l #-1,66(a4)
    2504:	0042 
    2506:	297c 0100 0000 	move.l #16777216,62(a4)
    250c:	003e 
    250e:	426c 0064      	clr.w 100(a4)
    2512:	2979 0000 2480 	move.l 0x2480,82(a4)
    2518:	0052 
    251a:	397c cbd4 0056 	move.w #-13356,86(a4)
    2520:	4e75           	rts
    2522:	4a79 0000 25d4 	tst.w 0x25d4
    2528:	670a           	beq.s 0x2534
    252a:	5379 0000 25d4 	subq.w #1,0x25d4
    2530:	6000 0094      	bra.w 0x25c6
    2534:	33fa 009c 0000 	move.w 0x25d2(pc),0x25d4
    253a:	25d4 
    253c:	4a39 0000 25d0 	tst.b 0x25d0
    2542:	6604           	bne.s 0x2548
    2544:	6000 0080      	bra.w 0x25c6
    2548:	5339 0000 25d0 	subq.b #1,0x25d0
    254e:	227a 007c      	movea.l 0x25cc(pc),a1
    2552:	207a 0074      	movea.l 0x25c8(pc),a0
    2556:	41e8 0002      	lea 2(a0),a0
    255a:	3839 0000 25d6 	move.w 0x25d6,d4
    2560:	5344           	subq.w #1,d4
    2562:	3010           	move.w (a0),d0
    2564:	3419           	move.w (a1)+,d2
    2566:	3200           	move.w d0,d1
    2568:	3602           	move.w d2,d3
    256a:	0241 000f      	andi.w #15,d1
    256e:	0243 000f      	andi.w #15,d3
    2572:	b641           	cmp.w d1,d3
    2574:	6708           	beq.s 0x257e
    2576:	6d04           	blt.s 0x257c
    2578:	5250           	addq.w #1,(a0)
    257a:	6002           	bra.s 0x257e
    257c:	5350           	subq.w #1,(a0)
    257e:	3200           	move.w d0,d1
    2580:	3602           	move.w d2,d3
    2582:	e849           	lsr.w #4,d1
    2584:	e84b           	lsr.w #4,d3
    2586:	0241 000f      	andi.w #15,d1
    258a:	0243 000f      	andi.w #15,d3
    258e:	b641           	cmp.w d1,d3
    2590:	670c           	beq.s 0x259e
    2592:	6d06           	blt.s 0x259a
    2594:	0650 0010      	addi.w #16,(a0)
    2598:	6004           	bra.s 0x259e
    259a:	0450 0010      	subi.w #16,(a0)
    259e:	3200           	move.w d0,d1
    25a0:	3602           	move.w d2,d3
    25a2:	e049           	lsr.w #8,d1
    25a4:	e04b           	lsr.w #8,d3
    25a6:	0241 000f      	andi.w #15,d1
    25aa:	0243 000f      	andi.w #15,d3
    25ae:	b641           	cmp.w d1,d3
    25b0:	670c           	beq.s 0x25be
    25b2:	6d06           	blt.s 0x25ba
    25b4:	0650 0100      	addi.w #256,(a0)
    25b8:	6004           	bra.s 0x25be
    25ba:	0450 0100      	subi.w #256,(a0)
    25be:	41e8 0004      	lea 4(a0),a0
    25c2:	51cc ff9e      	dbf d4,0x2562
    25c6:	4e75           	rts
	...
    25d8:	0000 0430      	ori.b #48,d0
    25dc:	085f 0c8c      	bchg #-116,(sp)+
    25e0:	10b5 14d9      	move.b (-39,a5,d1.w:4),(a0)
    25e4:	18f8 1d10      	move.b 0x1d10,(a4)+
    25e8:	2120           	move.l -(a0),-(a0)
    25ea:	2527           	move.l -(sp),-(a2)
    25ec:	2924           	move.l -(a4),-(a4)
    25ee:	2d16           	move.l (a6),-(a6)
    25f0:	30fb 34d3      	move.w (0x25c5,pc,d3.w:4),(a0)+
    25f4:	389c           	move.w (a4)+,(a4)
    25f6:	3c56           	movea.w (a6),a6
    25f8:	3fff           	.short 0x3fff
    25fa:	4397           	chk.w (sp),d1
    25fc:	471c           	chk.l (a4)+,d3
    25fe:	4a8e           	tst.l a6
    2600:	4deb 5133      	lea 20787(a3),a6
    2604:	5464           	addq.w #2,-(a4)
    2606:	577f           	.short 0x577f
    2608:	5a81           	addq.l #5,d1
    260a:	5d6b 603b      	subq.w #6,24635(a3)
    260e:	62f1           	bhi.s 0x2601
    2610:	658b           	bcs.s 0x259d
    2612:	680a           	bvc.s 0x261e
    2614:	6a6c           	bpl.s 0x2682
    2616:	6cb1           	bge.s 0x25c9
    2618:	6ed9           	bgt.s 0x25f3
    261a:	70e1           	moveq #-31,d0
    261c:	72cb           	moveq #-53,d1
    261e:	7496           	moveq #-106,d2
    2620:	7640           	moveq #64,d3
    2622:	77ca           	mvz.w a2,d3
    2624:	7934 7a7c      	mvs.b (124,a4,d7.l:2),d4
    2628:	7ba2           	mvz.b -(a2),d5
    262a:	7ca7           	moveq #-89,d6
    262c:	7d89           	mvz.b a1,d6
    262e:	7e49           	moveq #73,d7
    2630:	7ee6           	moveq #-26,d7
    2632:	7f61           	mvs.w -(a1),d7
    2634:	7fb9 7fed 7fff 	mvz.b 0x7fed7fff,d7
    263a:	7fee 7fb9      	mvz.w 32697(a6),d7
    263e:	7f61           	mvs.w -(a1),d7
    2640:	7ee7           	moveq #-25,d7
    2642:	7e4a           	moveq #74,d7
    2644:	7d8a           	mvz.b a2,d6
    2646:	7ca7           	moveq #-89,d6
    2648:	7ba3           	mvz.b -(a3),d5
    264a:	7a7d           	moveq #125,d5
    264c:	7935 77cb 7641 	([,1984001175)mvs.b ([0],1984001175),d4
    2652:	7497 
    2654:	72cd           	moveq #-51,d1
    2656:	70e3           	moveq #-29,d0
    2658:	6eda           	bgt.s 0x2634
    265a:	6cb3           	bge.s 0x260f
    265c:	6a6e           	bpl.s 0x26cc
    265e:	680c           	bvc.s 0x266c
    2660:	658d           	bcs.s 0x25ef
    2662:	62f3           	bhi.s 0x2657
    2664:	603d           	bra.s 0x26a3
    2666:	5d6d 5a83      	subq.w #6,23171(a5)
    266a:	5781           	subq.l #3,d1
    266c:	5467           	addq.w #2,-(sp)
    266e:	5135 4ded 4a90 	([,0)subq.b #8,([19088],0)
    2674:	471e           	chk.l (a6)+,d3
    2676:	4399           	chk.w (a1)+,d1
    2678:	4002           	negx.b d2
    267a:	3c59           	movea.w (a1)+,a6
    267c:	389f           	move.w (sp)+,(a4)
    267e:	34d6           	move.w (a6),(a2)+
    2680:	30fe           	.short 0x30fe
    2682:	2d19           	move.l (a1)+,-(a6)
    2684:	2927           	move.l -(sp),-(a4)
    2686:	252a 2123      	move.l 8483(a2),-(a2)
    268a:	1d13           	move.b (a3),-(a6)
    268c:	18fb 14dc      	move.b (0x266a,pc,d1.w:4),(a4)+
    2690:	10b8 0c8f      	move.b 0xc8f,(a0)
    2694:	0862 0433      	bchg #51,-(a2)
    2698:	0003 fbd3      	ori.b #-45,d3
    269c:	f7a4           	.short 0xf7a4
    269e:	f377 ef4e eb2a 	([,-5334)frestore ([0,sp],-5334)
    26a4:	e70b           	lsl.b #3,d3
    26a6:	e2f3 dee2      	lsr.w (-30,a3,a5.l:8)
    26aa:	dadb           	adda.w (a3)+,a5
    26ac:	d6df           	adda.w (sp)+,a3
    26ae:	d2ed cf08      	adda.w -12536(a5),a1
    26b2:	cb30 c767 c3ad 	([,-1073431444)and.b d5,([-15443,a0],-1073431444)
    26b8:	c004 bc6c 
    26bc:	b8e7           	cmpa.w -(sp),a4
    26be:	b575 b218      	eor.w d2,(24,a5,a3.w:2)
    26c2:	aed0           	.short 0xaed0
    26c4:	ab9e           	.short 0xab9e
    26c6:	a883           	.short 0xa883
    26c8:	a581           	.short 0xa581
    26ca:	a297 9fc7      	msac.l d7,a1,>>,(sp),d1
    26ce:	9d11           	sub.b d6,(a1)
    26d0:	9a77 97f8 9595 	sub.w (-1785359536),d5
    26d6:	9350 
    26d8:	9129 8f20      	sub.b d0,-28896(a1)
    26dc:	8d36 8b6b 89c1 	([,-2009626931)or.b d6,([-30271,a6],-2009626931)
    26e2:	8837 86cd 
    26e6:	8585 845f      	unpk d5,d2,#-31649
    26ea:	835a           	or.w d1,(a2)+
    26ec:	8277 81b7 811a 	([,-2142797805)or.w ([-2128969569],a0.w,-2142797805),d1
    26f2:	809f 8047 8013 
    26f8:	8001           	or.b d1,d0
    26fa:	8012           	or.b (a2),d0
    26fc:	8047           	or.w d7,d0
    26fe:	809e           	or.l (a6)+,d0
    2700:	8119           	or.b d0,(a1)+
    2702:	81b6 8276      	or.l d0,(118,a6,a0.w:2)
    2706:	8358           	or.w d1,(a0)+
    2708:	845c           	or.w (a4)+,d2
    270a:	8583 86ca      	unpk d3,d2,#-31030
    270e:	8833 89bd 8b68 	([,0)or.b ([-1956082382],a0.l,0),d4
    2714:	8d32 
    2716:	8f1c           	or.b d7,(a4)+
    2718:	9124           	sub.b d0,-(a4)
    271a:	934c           	subx.w -(a4),-(a1)
    271c:	9590           	sub.l d2,(a0)
    271e:	97f2 9a71      	suba.l (113,a2,a1.l:2),a3
    2722:	9d0b           	subx.b -(a3),-(a6)
    2724:	9fc1           	suba.l d1,sp
    2726:	a291           	.short 0xa291
    2728:	a57a           	.short 0xa57a
    272a:	a87d           	.short 0xa87d
    272c:	ab97           	.short 0xab97
    272e:	aec9           	.short 0xaec9
    2730:	b210           	cmp.b (a0),d1
    2732:	b56e b8df      	eor.w d2,-18209(a6)
    2736:	bc64           	cmp.w -(a4),d6
    2738:	bffc c3a5 c75e 	cmpa.l #-1012545698,sp
    273e:	cb28 ceff      	and.b d5,-12545(a0)
    2742:	d2e4           	adda.w -(a4),a1
    2744:	d6d6           	adda.w (a6),a3
    2746:	dad3           	adda.w (a3),a5
    2748:	deda           	adda.w (a2)+,sp
    274a:	e2ea e702      	lsr.w -6398(a2)
    274e:	eb21           	asl.b d5,d1
    2750:	ef45           	asl.w #7,d5
    2752:	f36e f79b      	frestore -2149(a6)
    2756:	fbca           	.short 0xfbca
    2758:	0000 0430      	ori.b #48,d0
    275c:	085f 0c8c      	bchg #-116,(sp)+
    2760:	10b5 14d9      	move.b (-39,a5,d1.w:4),(a0)
    2764:	18f8 1d10      	move.b 0x1d10,(a4)+
    2768:	2120           	move.l -(a0),-(a0)
    276a:	2527           	move.l -(sp),-(a2)
    276c:	2924           	move.l -(a4),-(a4)
    276e:	2d16           	move.l (a6),-(a6)
    2770:	30fb 34d3      	move.w (0x2745,pc,d3.w:4),(a0)+
    2774:	389c           	move.w (a4)+,(a4)
    2776:	3c56           	movea.w (a6),a6
    2778:	3fff           	.short 0x3fff
    277a:	4397           	chk.w (sp),d1
    277c:	471c           	chk.l (a4)+,d3
    277e:	4a8e           	tst.l a6
    2780:	4deb 5133      	lea 20787(a3),a6
    2784:	5464           	addq.w #2,-(a4)
    2786:	577f           	.short 0x577f
    2788:	5a81           	addq.l #5,d1
    278a:	5d6b 603b      	subq.w #6,24635(a3)
    278e:	62f1           	bhi.s 0x2781
    2790:	658b           	bcs.s 0x271d
    2792:	680a           	bvc.s 0x279e
    2794:	6a6c           	bpl.s 0x2802
    2796:	6cb1           	bge.s 0x2749
    2798:	6ed9           	bgt.s 0x2773
    279a:	70e1           	moveq #-31,d0
    279c:	72cb           	moveq #-53,d1
    279e:	7496           	moveq #-106,d2
    27a0:	7640           	moveq #64,d3
    27a2:	77ca           	mvz.w a2,d3
    27a4:	7934 7a7c      	mvs.b (124,a4,d7.l:2),d4
    27a8:	7ba2           	mvz.b -(a2),d5
    27aa:	7ca7           	moveq #-89,d6
    27ac:	7d89           	mvz.b a1,d6
    27ae:	7e49           	moveq #73,d7
    27b0:	7ee6           	moveq #-26,d7
    27b2:	7f61           	mvs.w -(a1),d7
    27b4:	7fb9 7fed 7fff 	mvz.b 0x7fed7fff,d7
    27ba:	7fee 7fb9      	mvz.w 32697(a6),d7
    27be:	7f61           	mvs.w -(a1),d7
    27c0:	7ee7           	moveq #-25,d7
    27c2:	7e4a           	moveq #74,d7
    27c4:	7d8a           	mvz.b a2,d6
    27c6:	7ca7           	moveq #-89,d6
    27c8:	7ba3           	mvz.b -(a3),d5
    27ca:	7a7d           	moveq #125,d5
    27cc:	7935 77cb 7641 	([,1984001175)mvs.b ([0],1984001175),d4
    27d2:	7497 
    27d4:	72cd           	moveq #-51,d1
    27d6:	70e3           	moveq #-29,d0
    27d8:	6eda           	bgt.s 0x27b4
    27da:	6cb3           	bge.s 0x278f
    27dc:	6a6e           	bpl.s 0x284c
    27de:	680c           	bvc.s 0x27ec
    27e0:	658d           	bcs.s 0x276f
    27e2:	62f3           	bhi.s 0x27d7
    27e4:	603d           	bra.s 0x2823
    27e6:	5d6d 5a83      	subq.w #6,23171(a5)
    27ea:	5781           	subq.l #3,d1
    27ec:	5467           	addq.w #2,-(sp)
    27ee:	5135 4ded 4a90 	([,0)subq.b #8,([19088],0)
    27f4:	471e           	chk.l (a6)+,d3
    27f6:	4399           	chk.w (a1)+,d1
    27f8:	4002           	negx.b d2
    27fa:	3c59           	movea.w (a1)+,a6
    27fc:	389f           	move.w (sp)+,(a4)
    27fe:	34d6           	move.w (a6),(a2)+
    2800:	30fe           	.short 0x30fe
    2802:	2d19           	move.l (a1)+,-(a6)
    2804:	2927           	move.l -(sp),-(a4)
    2806:	252a 2123      	move.l 8483(a2),-(a2)
    280a:	1d13           	move.b (a3),-(a6)
    280c:	18fb 14dc      	move.b (0x27ea,pc,d1.w:4),(a4)+
    2810:	10b8 0c8f      	move.b 0xc8f,(a0)
    2814:	0862 0433      	bchg #51,-(a2)
    2818:	0003 fbd3      	ori.b #-45,d3
    281c:	f7a4           	.short 0xf7a4
    281e:	f377 ef4e eb2a 	([,-5334)frestore ([0,sp],-5334)
    2824:	e70b           	lsl.b #3,d3
    2826:	e2f3 dee2      	lsr.w (-30,a3,a5.l:8)
    282a:	dadb           	adda.w (a3)+,a5
    282c:	d6df           	adda.w (sp)+,a3
    282e:	d2ed cf08      	adda.w -12536(a5),a1
    2832:	cb30 c767 c3ad 	([,-1073431444)and.b d5,([-15443,a0],-1073431444)
    2838:	c004 bc6c 
    283c:	b8e7           	cmpa.w -(sp),a4
    283e:	b575 b218      	eor.w d2,(24,a5,a3.w:2)
    2842:	aed0           	.short 0xaed0
    2844:	ab9e           	.short 0xab9e
    2846:	a883           	.short 0xa883
    2848:	a581           	.short 0xa581
    284a:	a297 9fc7      	msac.l d7,a1,>>,(sp),d1
    284e:	9d11           	sub.b d6,(a1)
    2850:	9a77 97f8 9595 	sub.w (-1785359536),d5
    2856:	9350 
    2858:	9129 8f20      	sub.b d0,-28896(a1)
    285c:	8d36 8b6b 89c1 	([,-2009626931)or.b d6,([-30271,a6],-2009626931)
    2862:	8837 86cd 
    2866:	8585 845f      	unpk d5,d2,#-31649
    286a:	835a           	or.w d1,(a2)+
    286c:	8277 81b7 811a 	([,-2142797805)or.w ([-2128969569],a0.w,-2142797805),d1
    2872:	809f 8047 8013 
    2878:	8001           	or.b d1,d0
    287a:	8012           	or.b (a2),d0
    287c:	8047           	or.w d7,d0
    287e:	809e           	or.l (a6)+,d0
    2880:	8119           	or.b d0,(a1)+
    2882:	81b6 8276      	or.l d0,(118,a6,a0.w:2)
    2886:	8358           	or.w d1,(a0)+
    2888:	845c           	or.w (a4)+,d2
    288a:	8583 86ca      	unpk d3,d2,#-31030
    288e:	8833 89bd 8b68 	([,0)or.b ([-1956082382],a0.l,0),d4
    2894:	8d32 
    2896:	8f1c           	or.b d7,(a4)+
    2898:	9124           	sub.b d0,-(a4)
    289a:	934c           	subx.w -(a4),-(a1)
    289c:	9590           	sub.l d2,(a0)
    289e:	97f2 9a71      	suba.l (113,a2,a1.l:2),a3
    28a2:	9d0b           	subx.b -(a3),-(a6)
    28a4:	9fc1           	suba.l d1,sp
    28a6:	a291           	.short 0xa291
    28a8:	a57a           	.short 0xa57a
    28aa:	a87d           	.short 0xa87d
    28ac:	ab97           	.short 0xab97
    28ae:	aec9           	.short 0xaec9
    28b0:	b210           	cmp.b (a0),d1
    28b2:	b56e b8df      	eor.w d2,-18209(a6)
    28b6:	bc64           	cmp.w -(a4),d6
    28b8:	bffc c3a5 c75e 	cmpa.l #-1012545698,sp
    28be:	cb28 ceff      	and.b d5,-12545(a0)
    28c2:	d2e4           	adda.w -(a4),a1
    28c4:	d6d6           	adda.w (a6),a3
    28c6:	dad3           	adda.w (a3),a5
    28c8:	deda           	adda.w (a2)+,sp
    28ca:	e2ea e702      	lsr.w -6398(a2)
    28ce:	eb21           	asl.b d5,d1
    28d0:	ef45           	asl.w #7,d5
    28d2:	f36e f79b      	frestore -2149(a6)
    28d6:	fbca           	.short 0xfbca
    28d8:	0000 0000      	ori.b #0,d0
    28dc:	0000 00c0      	ori.b #-64,d0
    28e0:	0000 2954      	ori.b #84,d0
    28e4:	0000 00c0      	ori.b #-64,d0
    28e8:	0000 2994      	ori.b #-108,d0
    28ec:	0000 0180      	ori.b #-128,d0
    28f0:	0000 2994      	ori.b #-108,d0
    28f4:	0000 00c0      	ori.b #-64,d0
    28f8:	0000 2900      	ori.b #0,d0
    28fc:	0000 0000      	ori.b #0,d0
    2900:	0411 0411      	subi.b #17,(a1)
    2904:	0411 0411      	subi.b #17,(a1)
    2908:	0411 0411      	subi.b #17,(a1)
    290c:	0411 0411      	subi.b #17,(a1)
    2910:	0411 0411      	subi.b #17,(a1)
    2914:	0411 0411      	subi.b #17,(a1)
    2918:	0411 0411      	subi.b #17,(a1)
    291c:	0411 0411      	subi.b #17,(a1)
    2920:	0411 0411      	subi.b #17,(a1)
    2924:	0411 0411      	subi.b #17,(a1)
    2928:	0411 0411      	subi.b #17,(a1)
    292c:	0411 0411      	subi.b #17,(a1)
    2930:	0411 0411      	subi.b #17,(a1)
    2934:	0411 0411      	subi.b #17,(a1)
    2938:	0411 0411      	subi.b #17,(a1)
    293c:	0411 0411      	subi.b #17,(a1)
    2940:	0999           	bclr d4,(a1)+
    2942:	0556           	bchg d2,(a6)
    2944:	0334 0997 0887 	([,143066743)btst d1,([0],d0.l,143066743)
    294a:	0677 
    294c:	0656 0545      	addi.w #1349,(a6)
    2950:	0435 0bb9 0411 	subi.b #-71,(17,a5,d0.w:4)
    2956:	0411 0411      	subi.b #17,(a1)
    295a:	0411 0411      	subi.b #17,(a1)
    295e:	0411 0411      	subi.b #17,(a1)
    2962:	0411 0000      	subi.b #0,(a1)
    2966:	0999           	bclr d4,(a1)+
    2968:	0556           	bchg d2,(a6)
    296a:	0334 0000      	btst d1,(0,a4,d0.w)
    296e:	0000 0000      	ori.b #0,d0
    2972:	0000 0411      	ori.b #17,d0
    2976:	0997           	bclr d4,(sp)
    2978:	0887 0677      	bclr #119,d7
    297c:	0656 0545      	addi.w #1349,(a6)
    2980:	0435 0bb9 0411 	subi.b #-71,(17,a5,d0.w:4)
    2986:	0411 0411      	subi.b #17,(a1)
    298a:	0411 0411      	subi.b #17,(a1)
    298e:	0411 0411      	subi.b #17,(a1)
    2992:	0411 0411      	subi.b #17,(a1)
    2996:	0997           	bclr d4,(sp)
    2998:	0887 0677      	bclr #119,d7
    299c:	0656 0545      	addi.w #1349,(a6)
    29a0:	0435 0bb9 0000 	subi.b #-71,(0,a5,d0.w)
    29a6:	0999           	bclr d4,(a1)+
    29a8:	0556           	bchg d2,(a6)
    29aa:	0334 0000      	btst d1,(0,a4,d0.w)
	...
    29be:	0000 0002      	ori.b #2,d0
    29c2:	6000 0000      	bra.w 0x29c4
	...
    29ea:	2000           	move.l d0,d0
	...
    29fc:	0000 2000      	ori.b #0,d0
	...
    2a24:	0000 4000      	ori.b #0,d0
	...
    2a38:	c03b c000      	and.b (0x2a3a,pc,a4.w),d0
	...
    2a48:	0000 7001      	ori.b #1,d0
    2a4c:	1101           	move.b d1,-(a0)
    2a4e:	8000           	or.b d0,d0
	...
    2a58:	0003 0000      	ori.b #0,d3
    2a5c:	0839 f000 7f40 	btst #0,0x7f400000
    2a62:	0000 
    2a64:	0000 0000      	ori.b #0,d0
    2a68:	0000 0004      	ori.b #4,d0
    2a6c:	0083 4000 01df 	ori.l #1073742303,d3
    2a72:	f002           	.short 0xf002
    2a74:	7fe0           	mvz.w -(a0),d7
	...
    2a7e:	000f           	.short 0x000f
    2a80:	0183           	bclr d0,d3
    2a82:	c001           	and.b d1,d0
    2a84:	804f           	.short 0x804f
    2a86:	f002           	.short 0xf002
    2a88:	ff00 0000      	cp1st.b d0,d0,#1,#0
    2a8c:	0000 0000      	ori.b #0,d0
    2a90:	0000 0003      	ori.b #3,d0
    2a94:	045b c008      	subi.w #-16376,(a3)+
    2a98:	0011 8000      	ori.b #0,(a1)
    2a9c:	d8f0 0000      	adda.w (0,a0,d0.w),a4
    2aa0:	0000 0000      	ori.b #0,d0
    2aa4:	0000 0001      	ori.b #1,d0
    2aa8:	c87c 2000      	and.w #8192,d4
    2aac:	0000 0004      	ori.b #4,d0
    2ab0:	1e86           	move.b d6,(sp)
	...
    2aba:	0000 8c3d      	ori.b #61,d0
    2abe:	0000 04e0      	ori.b #-32,d0
    2ac2:	0000 0180      	ori.b #-128,d0
	...
    2ace:	0000 8039      	ori.b #57,d0
    2ad2:	c000           	and.b d0,d0
    2ad4:	0000 0008      	ori.b #8,d0
	...
    2ae4:	043f           	.short 0x043f
    2ae6:	0008           	.short 0x0008
    2ae8:	0000 0018      	ori.b #24,d0
    2aec:	0700           	btst d3,d0
	...
    2af6:	000c           	.short 0x000c
    2af8:	1024           	move.b -(a4),d0
    2afa:	0040 0000      	ori.w #0,d0
    2afe:	0008           	.short 0x0008
    2b00:	0900           	btst d4,d0
	...
    2b0a:	000c           	.short 0x000c
    2b0c:	1024           	move.b -(a4),d0
    2b0e:	0040 0020      	ori.w #32,d0
    2b12:	0008           	.short 0x0008
    2b14:	0900           	btst d4,d0
	...
    2b1e:	0008           	.short 0x0008
    2b20:	0400 0000      	subi.b #0,d0
    2b24:	0000 0018      	ori.b #24,d0
    2b28:	00c0           	bitrev d0
	...
    2b32:	000a           	.short 0x000a
    2b34:	3204           	move.w d4,d1
    2b36:	0000 1f02      	ori.b #2,d0
    2b3a:	4008           	.short 0x4008
    2b3c:	d3c0           	adda.l d0,a1
	...
    2b46:	0002 0582      	ori.b #-126,d2
    2b4a:	0000 2434      	ori.b #52,d0
    2b4e:	0001 f000      	ori.b #0,d1
	...
    2b5a:	0007 3e00      	ori.b #0,d7
    2b5e:	0000 0000      	ori.b #0,d0
    2b62:	0020 0000      	ori.b #0,-(a0)
	...
    2b6e:	000f           	.short 0x000f
    2b70:	fb84           	.short 0xfb84
    2b72:	0000 0000      	ori.b #0,d0
    2b76:	0022 0000      	ori.b #0,-(a2)
	...
    2b82:	000a           	.short 0x000a
    2b84:	bb98           	eor.l d5,(a0)+
    2b86:	0000 0031      	ori.b #49,d0
    2b8a:	0005 dc00      	ori.b #0,d5
	...
    2b96:	0009           	.short 0x0009
    2b98:	bb80           	eor.l d5,d0
    2b9a:	0000 0031      	ori.b #49,d0
    2b9e:	8005           	or.b d5,d0
    2ba0:	c000           	and.b d0,d0
	...
    2baa:	001c b620      	ori.b #32,(a4)+
    2bae:	0000 01e1      	ori.b #-31,d0
    2bb2:	8003           	or.b d3,d0
	...
    2bbc:	0000 001e      	ori.b #30,d0
    2bc0:	0e00           	.short 0x0e00
    2bc2:	0000 0007      	ori.b #7,d0
    2bc6:	8023           	or.b -(a3),d0
	...
    2bd4:	4600           	not.b d0
    2bd6:	0000 0107      	ori.b #7,d0
    2bda:	8022           	or.b -(a2),d0
    2bdc:	f000           	.short 0xf000
	...
    2be6:	0007 8200      	ori.b #0,d7
    2bea:	0000 0020      	ori.b #32,d0
    2bee:	800f           	.short 0x800f
    2bf0:	f000           	.short 0xf000
	...
    2bfa:	0029 0600 0000 	ori.b #0,0(a1)
    2c00:	0020 801f      	ori.b #31,-(a0)
	...
    2c0c:	0000 0017      	ori.b #23,d0
    2c10:	cc00           	and.b d0,d6
    2c12:	0000 0038      	ori.b #56,d0
    2c16:	000f           	.short 0x000f
	...
    2c20:	0000 0017      	ori.b #23,d0
    2c24:	cc00           	and.b d0,d6
    2c26:	0000 0038      	ori.b #56,d0
    2c2a:	000f           	.short 0x000f
	...
    2c34:	0000 0017      	ori.b #23,d0
    2c38:	8c00           	or.b d0,d6
    2c3a:	0000 0006      	ori.b #6,d0
    2c3e:	000f           	.short 0x000f
    2c40:	1000           	move.b d0,d0
	...
    2c4a:	0067 4c00      	ori.w #19456,-(sp)
    2c4e:	0000 0006      	ori.b #6,d0
    2c52:	0006 e000      	ori.b #0,d6
	...
    2c5e:	0007 8e00      	ori.b #0,d7
    2c62:	0000 0020      	ori.b #32,d0
    2c66:	f84c           	.short 0xf84c
	...
    2c70:	0000 0047      	ori.b #71,d0
    2c74:	8e00           	or.b d0,d7
    2c76:	0000 00c7      	ori.b #-57,d0
    2c7a:	8049           	.short 0x8049
	...
    2c84:	0000 004e      	ori.b #78,d0
    2c88:	bc00           	cmp.b d0,d6
    2c8a:	0000 00e6      	ori.b #-26,d0
    2c8e:	7800           	moveq #0,d4
	...
    2c98:	0000 005e      	ori.b #94,d0
    2c9c:	8400           	or.b d0,d2
    2c9e:	0000 0006      	ori.b #6,d0
    2ca2:	f800 0000      	tblu.b d0,d0,d0
	...
    2cae:	00de           	.short 0x00de
    2cb0:	8400           	or.b d0,d2
    2cb2:	0000 0006      	ori.b #6,d0
    2cb6:	f800 0000      	tblu.b d0,d0,d0
	...
    2cc2:	00d1           	.short 0x00d1
    2cc4:	0640 0000      	addi.w #0,d0
    2cc8:	0001 f800      	ori.b #0,d1
	...
    2cd4:	0000 03df      	ori.b #-33,d0
    2cd8:	c440           	and.w d0,d2
    2cda:	0000 0007      	ori.b #7,d0
    2cde:	f040 0000      	psb.s d0
	...
    2cea:	0107           	btst d0,d7
    2cec:	c440           	and.w d0,d2
    2cee:	0000 0007      	ori.b #7,d0
    2cf2:	4853           	pea (a3)
	...
    2cfc:	0000 010f      	ori.b #15,d0
    2d00:	c780           	.short 0xc780
    2d02:	0000 0000      	ori.b #0,d0
    2d06:	0813 c000      	btst #0,(a3)
	...
    2d12:	050f c1e0      	movep.w -15904(sp),d2
    2d16:	0000 0000      	ori.b #0,d0
    2d1a:	020f           	.short 0x020f
    2d1c:	8000           	or.b d0,d0
	...
    2d26:	011f           	btst d0,(sp)+
    2d28:	c1e0           	muls.w -(a0),d0
    2d2a:	0301           	btst d1,d1
    2d2c:	c001           	and.b d1,d0
    2d2e:	37d7           	.short 0x37d7
    2d30:	c000           	and.b d0,d0
	...
    2d3a:	011f           	btst d0,(sp)+
    2d3c:	c1e0           	muls.w -(a0),d0
    2d3e:	0701           	btst d3,d1
    2d40:	c001           	and.b d1,d0
    2d42:	b7c5           	cmpa.l d5,a3
    2d44:	c000           	and.b d0,d0
	...
    2d4e:	01c7           	bset d0,d7
    2d50:	c260           	and.w -(a0),d1
    2d52:	0970 0201      	bchg d4,(1,a0,d0.w:2)
    2d56:	ca00           	and.b d0,d5
    2d58:	7e00           	moveq #0,d7
	...
    2d62:	0d0f f1d8      	movep.w -3624(sp),d6
    2d66:	1e44           	.short 0x1e44
    2d68:	1827           	move.b -(sp),d4
    2d6a:	f3de           	.short 0xf3de
    2d6c:	f080 0000      	pbb.s 0x2d6e
    2d70:	0000 0000      	ori.b #0,d0
    2d74:	0000 070f      	ori.b #15,d0
    2d78:	c9c4           	muls.w d4,d4
    2d7a:	e1fd           	.short 0xe1fd
    2d7c:	c0c7           	mulu.w d7,d0
    2d7e:	f641           	.short 0xf641
    2d80:	c040           	and.w d0,d0
    2d82:	6000 0000      	bra.w 0x2d84
    2d86:	01f0 0000      	bset d0,(0,a0,d0.w)
    2d8a:	062f b9ff e0cc 	addi.b #-1,-7988(sp)
    2d90:	00f9           	.short 0x00f9
    2d92:	bdf9 f901 d800 	cmpa.l 0xf901d800,a6
    2d98:	0000 07b0      	ori.b #-80,d0
    2d9c:	0000 032f      	ori.b #47,d0
    2da0:	f85f           	.short 0xf85f
    2da2:	c1c0           	muls.w d0,d0
    2da4:	0006 33ff      	ori.b #-1,d6
    2da8:	fe3b           	.short 0xfe3b
    2daa:	9e00           	sub.b d0,d7
    2dac:	0000 0ef0      	ori.b #-16,d0
    2db0:	0000 1b1f      	ori.b #31,d0
    2db4:	bc00           	cmp.b d0,d6
    2db6:	0800 42c0      	btst #-64,d0
    2dba:	c7ff           	.short 0xc7ff
    2dbc:	fe37           	.short 0xfe37
    2dbe:	9f00           	subx.b d0,d7
    2dc0:	0003 17c0      	ori.b #-64,d3
    2dc4:	0000 0b1f      	ori.b #31,d0
    2dc8:	bc00           	cmp.b d0,d6
    2dca:	0800 42c0      	btst #-64,d0
    2dce:	c7ff           	.short 0xc7ff
    2dd0:	fe37           	.short 0xfe37
    2dd2:	9f20           	sub.b d7,-(a0)
    2dd4:	000d           	.short 0x000d
    2dd6:	17c0           	.short 0x17c0
    2dd8:	0000 041f      	ori.b #31,d0
    2ddc:	4e00           	.short 0x4e00
    2dde:	1ef6 01ff f1ff 	([,-438304703)move.b ([-234881487],-438304703),(sp)+
    2de4:	fe31 e5e0 0041 
    2dea:	cf80           	.short 0xcf80
    2dec:	0000 071f      	ori.b #31,d0
    2df0:	8fa1           	or.l d7,-(a1)
    2df2:	ffc4           	.short 0xffc4
    2df4:	07ff           	.short 0x07ff
    2df6:	801f           	or.b (sp)+,d0
    2df8:	f075           	.short 0xf075
    2dfa:	fff8           	.short 0xfff8
    2dfc:	0041 39c0      	ori.w #14784,d1
    2e00:	0000 8edf      	ori.b #-33,d0
    2e04:	0bdd           	bset d5,(a5)+
    2e06:	f9c5           	.short 0xf9c5
    2e08:	85f6 303f      	divs.w (63,a6,d3.w),d2
    2e0c:	e1ff           	.short 0xe1ff
    2e0e:	fffe           	.short 0xfffe
    2e10:	37b8 fec0 0000 	move.w 0xfffffec0,(0,a3,d0.w)
    2e16:	07cf 87ff      	movep.l d3,-30721(sp)
    2e1a:	cf36 00c0      	and.b d7,(-64,a6,d0.w)
    2e1e:	f83f           	.short 0xf83f
    2e20:	e8cf           	.short 0xe8cf
    2e22:	fff7           	.short 0xfff7
    2e24:	c187           	.short 0xc187
    2e26:	ffc0           	.short 0xffc0
    2e28:	0000 3fc7      	ori.b #-57,d0
    2e2c:	c7fb c1ff 99e0 	([,29360127)muls.w ([-1713308545,zpc],29360127),d3
    2e32:	fc7f 01bf ffff 
    2e38:	f047           	.short 0xf047
    2e3a:	cf80           	.short 0xcf80
    2e3c:	0000 2726      	ori.b #38,d0
    2e40:	c060           	and.w -(a0),d0
    2e42:	01ff           	.short 0x01ff
    2e44:	ffff           	.short 0xffff
    2e46:	ffff           	.short 0xffff
    2e48:	c04f           	.short 0xc04f
    2e4a:	ffff           	.short 0xffff
    2e4c:	c9ff           	.short 0xc9ff
    2e4e:	df00           	addx.b d0,d7
    2e50:	0000 0326      	ori.b #38,d0
    2e54:	c060           	and.w -(a0),d0
    2e56:	01ff           	.short 0x01ff
    2e58:	ffff           	.short 0xffff
    2e5a:	ffff           	.short 0xffff
    2e5c:	c04f           	.short 0xc04f
    2e5e:	ffff           	.short 0xffff
    2e60:	c9ff           	.short 0xc9ff
    2e62:	df00           	addx.b d0,d7
    2e64:	0002 4f0f      	ori.b #15,d2
    2e68:	8040           	or.w d0,d0
    2e6a:	3877 ffff ffff 	([,-5)movea.w ([-6465],-5),a4
    2e70:	e6bf ffff fffb 
    2e76:	1600           	move.b d0,d3
    2e78:	0002 0801      	ori.b #1,d2
    2e7c:	81e4           	divs.w -(a4),d0
    2e7e:	3eff           	.short 0x3eff
    2e80:	ffff           	.short 0xffff
    2e82:	ffff           	.short 0xffff
    2e84:	0e07           	.short 0x0e07
    2e86:	ffff           	.short 0xffff
    2e88:	ffdc           	.short 0xffdc
    2e8a:	ee00           	asr.b #7,d0
    2e8c:	0000 44c6      	ori.b #-58,d0
    2e90:	0fff           	.short 0x0fff
    2e92:	37cf           	.short 0x37cf
    2e94:	ffff           	.short 0xffff
    2e96:	ffff           	.short 0xffff
    2e98:	fe01 ffff      	cp1ld.b d1,sp,#8,#511
    2e9c:	fffc           	.short 0xfffc
    2e9e:	e780           	asl.l #3,d0
    2ea0:	0000 0009      	ori.b #9,d0
    2ea4:	0bff           	.short 0x0bff
    2ea6:	ffff           	.short 0xffff
    2ea8:	ffff           	.short 0xffff
    2eaa:	ffff           	.short 0xffff
    2eac:	f687           	.short 0xf687
    2eae:	ffff           	.short 0xffff
    2eb0:	f666           	.short 0xf666
    2eb2:	d100           	addx.b d0,d0
    2eb4:	0003 800f      	ori.b #15,d3
    2eb8:	3ffd           	.short 0x3ffd
    2eba:	dfff           	.short 0xdfff
    2ebc:	ffff           	.short 0xffff
    2ebe:	ffff           	.short 0xffff
    2ec0:	ff7f           	.short 0xff7f
    2ec2:	ffff           	.short 0xffff
    2ec4:	c1cc           	.short 0xc1cc
    2ec6:	f800 0002      	tblu.b d0,d2,d0
    2eca:	1931 fbff ffff 	([,-117)move.b ([-16385],-117),-(a4)
    2ed0:	bfff ffff ff8b 
    2ed6:	ffff           	.short 0xffff
    2ed8:	c47a 3c00      	and.w 0x6ada(pc),d2
    2edc:	0002 1931      	ori.b #49,d2
    2ee0:	fbff           	.short 0xfbff
    2ee2:	ffff           	.short 0xffff
    2ee4:	bfff           	.short 0xbfff
    2ee6:	ffff           	.short 0xffff
    2ee8:	ff8b ffff      	cp1st.l sp,a3,#8,#511
    2eec:	c47a 3800      	and.w 0x66ee(pc),d2
    2ef0:	0003 b9ff      	ori.b #-1,d3
    2ef4:	fbff           	.short 0xfbff
    2ef6:	fffe           	.short 0xfffe
    2ef8:	3fff           	.short 0x3fff
    2efa:	ffff           	.short 0xffff
    2efc:	ffff           	.short 0xffff
    2efe:	fffe           	.short 0xfffe
    2f00:	01f8 3000      	bset d0,0x3000
    2f04:	0007 daff      	ori.b #-1,d7
    2f08:	ffff           	.short 0xffff
    2f0a:	fffe           	.short 0xfffe
    2f0c:	3fff           	.short 0x3fff
    2f0e:	ffff           	.short 0xffff
    2f10:	fffe           	.short 0xfffe
    2f12:	7ff8 0998      	mvz.w 0x998,d7
    2f16:	0000 0007      	ori.b #7,d0
    2f1a:	84ff           	.short 0x84ff
    2f1c:	f7ff           	.short 0xf7ff
    2f1e:	fffe           	.short 0xfffe
    2f20:	1fff           	.short 0x1fff
    2f22:	ffff           	.short 0xffff
    2f24:	ffff           	.short 0xffff
    2f26:	fffe           	.short 0xfffe
    2f28:	3238 0000      	move.w 0x0,d1
    2f2c:	0006 5e01      	ori.b #1,d6
    2f30:	c7ff           	.short 0xc7ff
    2f32:	fffd           	.short 0xfffd
    2f34:	9fff           	.short 0x9fff
    2f36:	ffff           	.short 0xffff
    2f38:	ffc6           	.short 0xffc6
    2f3a:	3ffe           	.short 0x3ffe
    2f3c:	7e78           	moveq #120,d7
    2f3e:	0000 0007      	ori.b #7,d0
    2f42:	e5c0           	.short 0xe5c0
    2f44:	c3ff           	.short 0xc3ff
    2f46:	fffe           	.short 0xfffe
    2f48:	07ff           	.short 0x07ff
    2f4a:	ffff           	.short 0xffff
    2f4c:	ffff           	.short 0xffff
    2f4e:	e7f0 fba0 0000 	rol.w (0,sp.l:2)
    2f54:	0007 c0e0      	ori.b #-32,d7
    2f58:	0fff           	.short 0x0fff
    2f5a:	fffe           	.short 0xfffe
    2f5c:	07ff           	.short 0x07ff
    2f5e:	ffff           	.short 0xffff
    2f60:	ffff           	.short 0xffff
    2f62:	e3f8 7bba      	lsl.w 0x7bba
    2f66:	8000           	or.b d0,d0
    2f68:	0007 c0e0      	ori.b #-32,d7
    2f6c:	0fff           	.short 0x0fff
    2f6e:	fffe           	.short 0xfffe
    2f70:	07ff           	.short 0x07ff
    2f72:	ffff           	.short 0xffff
    2f74:	ffff           	.short 0xffff
    2f76:	e3f8 7bba      	lsl.w 0x7bba
    2f7a:	8000           	or.b d0,d0
    2f7c:	0007 80f0      	ori.b #-16,d7
    2f80:	cfff           	.short 0xcfff
    2f82:	ffff           	.short 0xffff
    2f84:	c1ff           	.short 0xc1ff
    2f86:	ffff           	.short 0xffff
    2f88:	ffff           	.short 0xffff
    2f8a:	c1e0           	muls.w -(a0),d0
    2f8c:	37dd           	.short 0x37dd
    2f8e:	0000 0006      	ori.b #6,d0
    2f92:	0430 07ff ffff 	([,-16136)subi.b #-1,([-503316487],-16136)
    2f98:	e1ff fff9 ffff 
    2f9e:	c0f8 
    2fa0:	8fc3           	divs.w d3,d7
    2fa2:	0000 0003      	ori.b #3,d0
    2fa6:	8018           	or.b (a0)+,d0
    2fa8:	77ff           	.short 0x77ff
    2faa:	ffff           	.short 0xffff
    2fac:	a1ff           	.short 0xa1ff
    2fae:	fffb           	.short 0xfffb
    2fb0:	ffff           	.short 0xffff
    2fb2:	e5f0 8e47      	roxl.w (71,a0,a0.l:8)
    2fb6:	0000 0003      	ori.b #3,d0
    2fba:	98bd           	.short 0x98bd
    2fbc:	3ffe           	.short 0x3ffe
    2fbe:	3eb3 c3ff ffc2 	([,-1040206402)move.w ([-3997697],-1040206402),(sp)
    2fc4:	ffff c1ff b5be 
    2fca:	0000 0003      	ori.b #3,d0
    2fce:	c7fc 7ffc      	muls.w #32764,d3
    2fd2:	0008           	.short 0x0008
    2fd4:	07ff           	.short 0x07ff
    2fd6:	ffe1           	.short 0xffe1
    2fd8:	ffff           	.short 0xffff
    2fda:	faff           	.short 0xfaff
    2fdc:	6c3e           	bge.s 0x301c
    2fde:	0000 0001      	ori.b #1,d0
    2fe2:	c7c4           	muls.w d4,d3
    2fe4:	7ffc 2f00      	mvz.w #12032,d7
    2fe8:	1fff           	.short 0x1fff
    2fea:	ffe4           	.short 0xffe4
    2fec:	3fff           	.short 0x3fff
    2fee:	fff0           	.short 0xfff0
    2ff0:	f85c           	.short 0xf85c
    2ff2:	0000 0007      	ori.b #7,d0
    2ff6:	c7c4           	muls.w d4,d3
    2ff8:	7ffc 2f00      	mvz.w #12032,d7
    2ffc:	1fff           	.short 0x1fff
    2ffe:	ffc4           	.short 0xffc4
    3000:	3fff           	.short 0x3fff
    3002:	fff0           	.short 0xfff0
    3004:	f85c           	.short 0xf85c
    3006:	0000 0001      	ori.b #1,d0
    300a:	810f           	sbcd -(sp),-(a0)
    300c:	fffc           	.short 0xfffc
    300e:	1680           	move.b d0,(a3)
    3010:	3fff           	.short 0x3fff
    3012:	fffa           	.short 0xfffa
    3014:	71ff           	.short 0x71ff
    3016:	fc27 b818      	cp0ld.b -(sp),a3,#5,#24
    301a:	0000 0007      	ori.b #7,d0
    301e:	8511           	or.b d2,(a1)
    3020:	bffc 1e41 ffff 	cmpa.l #507641855,sp
    3026:	ffef           	.short 0xffef
    3028:	11ff           	.short 0x11ff
    302a:	f8c7           	.short 0xf8c7
    302c:	f018           	.short 0xf018
    302e:	0000 0001      	ori.b #1,d0
    3032:	c4f8 bbff      	mulu.w 0xffffbbff,d2
    3036:	3eff           	.short 0x3eff
    3038:	ffff           	.short 0xffff
    303a:	ffff           	.short 0xffff
    303c:	f9ff           	.short 0xf9ff
    303e:	e1fb           	.short 0xe1fb
    3040:	7010           	moveq #16,d0
    3042:	0000 0007      	ori.b #7,d0
    3046:	a1f0           	.short 0xa1f0
    3048:	33ff           	.short 0x33ff
    304a:	ffff           	.short 0xffff
    304c:	ffff           	.short 0xffff
    304e:	ffff           	.short 0xffff
    3050:	ffff           	.short 0xffff
    3052:	c3ef c020      	muls.w -16352(sp),d1
    3056:	0000 0001      	ori.b #1,d0
    305a:	e13e           	rol.b d0,d6
    305c:	03ff           	.short 0x03ff
    305e:	ffff           	.short 0xffff
    3060:	ffff           	.short 0xffff
    3062:	ffdf           	.short 0xffdf
    3064:	bfff           	.short 0xbfff
    3066:	ff3f           	.short 0xff3f
    3068:	8000           	or.b d0,d0
    306a:	0000 0009      	ori.b #9,d0
    306e:	d9e6           	adda.l -(a6),a4
    3070:	41ff           	.short 0x41ff
    3072:	ffff           	.short 0xffff
    3074:	fc01 ffbf      	cp0ld.b d1,sp,#8,#447
    3078:	dffe           	.short 0xdffe
    307a:	5e7f           	.short 0x5e7f
    307c:	0000 0000      	ori.b #0,d0
    3080:	0008           	.short 0x0008
    3082:	d9e6           	adda.l -(a6),a4
    3084:	41ff           	.short 0x41ff
    3086:	ffff           	.short 0xffff
    3088:	fc01 ffbf      	cp0ld.b d1,sp,#8,#447
    308c:	7ffe           	.short 0x7ffe
    308e:	5e3f           	.short 0x5e3f
    3090:	0000 0000      	ori.b #0,d0
    3094:	0003 e120      	ori.b #32,d3
    3098:	003f           	.short 0x003f
    309a:	ffff           	.short 0xffff
    309c:	f800           	.short 0xf800
    309e:	f807           	.short 0xf807
    30a0:	fffc           	.short 0xfffc
    30a2:	24ff           	.short 0x24ff
    30a4:	c000           	and.b d0,d0
    30a6:	0000 0005      	ori.b #5,d0
    30aa:	e637           	roxr.b d3,d7
    30ac:	001f ffff      	ori.b #-1,(sp)+
    30b0:	e000           	asr.b #8,d0
    30b2:	0004 f7fc      	ori.b #-4,d4
    30b6:	172f 8000      	move.b -32768(sp),-(a3)
    30ba:	0000 0007      	ori.b #7,d0
    30be:	e721           	asl.b d3,d1
    30c0:	4803           	nbcd d3
    30c2:	ffff           	.short 0xffff
    30c4:	e7c0           	.short 0xe7c0
    30c6:	0006 fff0      	ori.b #-16,d6
    30ca:	19ff           	.short 0x19ff
    30cc:	8000           	or.b d0,d0
    30ce:	0000 0002      	ori.b #2,d0
    30d2:	7c1e           	moveq #30,d6
    30d4:	0803 ffff      	btst #-1,d3
    30d8:	fff8           	.short 0xfff8
    30da:	783f           	moveq #63,d4
    30dc:	bf41           	eor.w d7,d1
    30de:	0037 f000 0000 	ori.b #0,(0,sp,d0.w)
    30e4:	0003 e700      	ori.b #0,d3
    30e8:	ff83 ffff      	cp1st.l sp,d3,#8,#511
    30ec:	ffd0           	.short 0xffd0
    30ee:	7e7f           	moveq #127,d7
    30f0:	fe03 0007      	cp1ld.b d3,d0,#1,#7
    30f4:	f000           	.short 0xf000
    30f6:	0000 0000      	ori.b #0,d0
    30fa:	46ce           	move d6,sr
    30fc:	ffc3           	.short 0xffc3
    30fe:	ff7f           	.short 0xff7f
    3100:	fff9           	.short 0xfff9
    3102:	ffff           	.short 0xffff
    3104:	fe82 010f      	cp1ld.l d2,d0,#1,#271
    3108:	e000           	asr.b #8,d0
    310a:	0000 0000      	ori.b #0,d0
    310e:	46ce           	move d6,sr
    3110:	ffc3           	.short 0xffc3
    3112:	ff7f           	.short 0xff7f
    3114:	fff9           	.short 0xfff9
    3116:	ffff           	.short 0xffff
    3118:	ff90 010f      	cp1st.l d0,(a0),#1,#271
    311c:	e000           	asr.b #8,d0
    311e:	0000 0000      	ori.b #0,d0
    3122:	0320           	btst d1,-(a0)
    3124:	7fdc           	mvz.w (a4)+,d7
    3126:	feff           	.short 0xfeff
    3128:	ffff           	.short 0xffff
    312a:	ffff           	.short 0xffff
    312c:	ffa4 001f      	cp1st.l d0,-(a4),#1,#31
    3130:	c000           	and.b d0,d0
    3132:	0000 0000      	ori.b #0,d0
    3136:	41e0           	.short 0x41e0
    3138:	3ffe           	.short 0x3ffe
    313a:	38ff           	.short 0x38ff
    313c:	fe1f fffd      	cp1ld.b (sp)+,sp,#8,#509
    3140:	ff1a 003f      	cp1st.b d0,(a2)+,#1,#63
    3144:	8000           	or.b d0,d0
    3146:	0000 0000      	ori.b #0,d0
    314a:	07f0 3fe7 c03f 	([,-65012226)bset d3,([-16321],-65012226)
    3150:	fc1f fdfe 
    3154:	1ff0           	.short 0x1ff0
    3156:	000f           	.short 0x000f
    3158:	8000           	or.b d0,d0
    315a:	0000 0000      	ori.b #0,d0
    315e:	6118           	bsr.s 0x3178
    3160:	3fff           	.short 0x3fff
    3162:	c9fb ffff cdfc 	([,67567616)muls.w ([-839122440,zpc],67567616),d4
    3168:	01f8 0407 0000 
    316e:	0000 0000      	ori.b #0,d0
    3172:	7fee 07ff      	mvz.w 2047(a6),d7
    3176:	efcc           	.short 0xefcc
    3178:	7ff9 f07f 07c0 	mvz.w 0xf07f07c0,d7
    317e:	0006 0000      	ori.b #0,d6
    3182:	0000 0000      	ori.b #0,d0
    3186:	67f8           	beq.s 0x3180
    3188:	b7ff           	.short 0xb7ff
    318a:	ffff           	.short 0xffff
    318c:	dff7 f03e      	adda.l (62,sp,sp.w),sp
    3190:	3fd0           	.short 0x3fd0
	...
    319a:	67f8           	beq.s 0x3194
    319c:	b7ff           	.short 0xb7ff
    319e:	ffff           	.short 0xffff
    31a0:	dff7 f03c      	adda.l (60,sp,sp.w),sp
    31a4:	3fe0           	.short 0x3fe0
	...
    31ae:	203e           	.short 0x203e
    31b0:	47ff           	.short 0x47ff
    31b2:	ffcf           	.short 0xffcf
    31b4:	d8c1           	adda.w d1,a4
    31b6:	c7f0 ffe0 0000 	muls.w (0),d3
    31bc:	0000 0000      	ori.b #0,d0
    31c0:	0000 01df      	ori.b #-33,d0
    31c4:	07e7           	bset d3,-(sp)
    31c6:	fffe           	.short 0xfffe
    31c8:	0007 ffe1      	ori.b #-31,d7
    31cc:	ff80 0000      	cp1st.l d0,d0,#1,#0
    31d0:	0000 0000      	ori.b #0,d0
    31d4:	0000 1ccf      	ori.b #-49,d0
    31d8:	cfe1           	muls.w -(a1),d7
    31da:	ff77           	.short 0xff77
    31dc:	f93f           	.short 0xf93f
    31de:	fdc7           	.short 0xfdc7
    31e0:	ef00           	asl.b #7,d0
	...
    31ea:	0a3f           	.short 0x0a3f
    31ec:	87e2           	divs.w -(a2),d3
    31ee:	ff3f           	.short 0xff3f
    31f0:	fe3f           	.short 0xfe3f
    31f2:	f1e7           	.short 0xf1e7
    31f4:	3900           	move.w d0,-(a4)
	...
    31fe:	05d7           	bset d2,(sp)
    3200:	8399           	or.l d1,(a1)+
    3202:	f0f7           	.short 0xf0f7
    3204:	fe3f           	.short 0xfe3f
    3206:	b3fe           	.short 0xb3fe
	...
    3210:	0000 023e      	ori.b #62,d0
    3214:	7800           	moveq #0,d4
    3216:	303f           	.short 0x303f
    3218:	f806           	.short 0xf806
    321a:	85c0           	divs.w d0,d2
    321c:	1000           	move.b d0,d0
	...
    3226:	003e           	.short 0x003e
    3228:	7800           	moveq #0,d4
    322a:	303f           	.short 0x303f
    322c:	f806           	.short 0xf806
    322e:	85c0           	divs.w d0,d2
    3230:	1000           	move.b d0,d0
	...
    323a:	01ff           	.short 0x01ff
    323c:	f99e           	.short 0xf99e
    323e:	003f           	.short 0x003f
    3240:	f807           	.short 0xf807
    3242:	8780 c000      	unpk d0,d3,#-16384
	...
    324e:	00ef           	.short 0x00ef
    3250:	b05a           	cmp.w (a2)+,d0
    3252:	c7ff           	.short 0xc7ff
    3254:	c01e           	and.b (a6)+,d0
    3256:	8386 2080      	unpk d6,d1,#8320
	...
    3262:	0017 c05e      	ori.b #94,(sp)
    3266:	39ff           	.short 0x39ff
    3268:	9cfe           	.short 0x9cfe
    326a:	0401 d6fe      	subi.b #-2,d1
	...
    3276:	0009           	.short 0x0009
    3278:	fa7f           	.short 0xfa7f
    327a:	21ff           	.short 0x21ff
    327c:	c1f7 0001      	muls.w (1,sp,d0.w),d0
    3280:	feff           	.short 0xfeff
    3282:	8000           	or.b d0,d0
    3284:	0000 0000      	ori.b #0,d0
    3288:	0000 0007      	ori.b #7,d0
    328c:	fa1f           	.short 0xfa1f
    328e:	f1ff           	.short 0xf1ff
    3290:	9fff           	.short 0x9fff
    3292:	4002           	negx.b d2
    3294:	3fcc           	.short 0x3fcc
	...
    329e:	0001 fc1e      	ori.b #30,d1
    32a2:	c1fc 5ffe      	muls.w #24574,d0
    32a6:	0000 e9bb      	ori.b #-69,d0
    32aa:	c200           	and.b d0,d1
    32ac:	0000 0000      	ori.b #0,d0
    32b0:	0000 0001      	ori.b #1,d0
    32b4:	fc1e c1fc      	cp0ld.b (a6)+,a4,#1,#508
    32b8:	5ffe           	sle d6
    32ba:	0000 e9bb      	ori.b #-69,d0
    32be:	c200           	and.b d0,d1
	...
    32c8:	3c39 20c0 3ff9 	move.w 0x20c03ff9,d6
    32ce:	0000 07bc      	ori.b #-68,d0
    32d2:	2000           	move.l d0,d0
	...
    32dc:	0e1e           	.short 0x0e1e
    32de:	1600           	move.b d0,d3
    32e0:	27f9           	.short 0x27f9
    32e2:	4000           	negx.b d0
    32e4:	0f8e 0600      	movep.w d7,1536(a6)
    32e8:	0000 0000      	ori.b #0,d0
    32ec:	0280 001e 0387 	andi.l #1966983,d0
    32f2:	d081           	add.l d1,d0
    32f4:	b9fe           	.short 0xb9fe
    32f6:	0000 0fce      	ori.b #-50,d0
    32fa:	1a00           	move.b d0,d5
    32fc:	0000 0000      	ori.b #0,d0
    3300:	0680 000f 03c3 	addi.l #984003,d0
    3306:	e800           	asr.b #4,d0
    3308:	1bfe           	.short 0x1bfe
    330a:	0000 27fa      	ori.b #-6,d0
    330e:	05c0           	bset d2,d0
    3310:	0000 0000      	ori.b #0,d0
    3314:	0700           	btst d3,d0
    3316:	01c8 407d      	movep.l d0,16509(a0)
    331a:	fef8           	.short 0xfef8
    331c:	0338 0000      	btst d1,0x0
    3320:	09fd           	.short 0x09fd
    3322:	8700           	sbcd d0,d3
    3324:	0000 0000      	ori.b #0,d0
    3328:	05c0           	bset d2,d0
    332a:	01b8 383c      	bclr d0,0x383c
    332e:	0fce 19f8      	movep.l d7,6648(a6)
    3332:	0000 094e      	ori.b #78,d0
    3336:	03c0           	bset d1,d0
    3338:	0000 0000      	ori.b #0,d0
    333c:	05c0           	bset d2,d0
    333e:	0338 383c      	btst d1,0x383c
    3342:	0fce 19f8      	movep.l d7,6648(a6)
    3346:	0000 094e      	ori.b #78,d0
    334a:	03c0           	bset d1,d0
    334c:	0000 0000      	ori.b #0,d0
    3350:	0180           	bclr d0,d0
    3352:	0738 3806      	btst d3,0x3806
    3356:	077f           	.short 0x077f
    3358:	8100           	sbcd d0,d0
    335a:	0000 0073      	ori.b #115,d0
    335e:	8200           	or.b d0,d1
    3360:	0000 0000      	ori.b #0,d0
    3364:	01c0           	bset d0,d0
    3366:	0619 8405      	addi.b #5,(a1)+
    336a:	c03b fc00      	and.b (0x336c,pc,sp.l:4),d0
	...
    3376:	0000 02c0      	ori.b #-64,d0
    337a:	1c07           	move.b d7,d6
    337c:	f183           	.short 0xf183
    337e:	c6ff           	.short 0xc6ff
    3380:	f800 0000      	tblu.b d0,d0,d0
    3384:	0702           	btst d3,d2
    3386:	0001 0000      	ori.b #0,d1
    338a:	0000 0260      	ori.b #96,d0
    338e:	1b00           	move.b d0,-(a5)
    3390:	7c3f           	moveq #63,d6
    3392:	ffff           	.short 0xffff
    3394:	8020           	or.b -(a0),d0
    3396:	0000 0901      	ori.b #1,d0
    339a:	c000           	and.b d0,d0
    339c:	4000           	negx.b d0
    339e:	0000 0000      	ori.b #0,d0
    33a2:	39c0           	.short 0x39c0
    33a4:	3e07           	move.w d7,d7
    33a6:	f1fd           	.short 0xf1fd
    33a8:	dc20           	add.b -(a0),d6
    33aa:	0000 3e00      	ori.b #0,d0
    33ae:	7a00           	moveq #0,d5
    33b0:	0000 0000      	ori.b #0,d0
    33b4:	0000 18f8      	ori.b #-8,d0
    33b8:	7f81           	mvz.b d1,d7
    33ba:	e03f           	ror.b d0,d7
    33bc:	a208 0003      	mac.w a0l,d1l
    33c0:	c000           	and.b d0,d0
    33c2:	4100           	chk.l d0,d0
    33c4:	0000 0000      	ori.b #0,d0
    33c8:	0008           	.short 0x0008
    33ca:	08f8 7f81 e03f 	bset #-127,0xffffe03f
    33d0:	a208 0003      	mac.w a0l,d1l
    33d4:	c000           	and.b d0,d0
    33d6:	4100           	chk.l d0,d0
    33d8:	8000           	or.b d0,d0
    33da:	0000 0000      	ori.b #0,d0
    33de:	1c3e           	.short 0x1c3e
    33e0:	3e3c 2000      	move.w #8192,d7
    33e4:	1808           	.short 0x1808
    33e6:	0007 f000      	ori.b #0,d7
    33ea:	3e00           	move.w d0,d7
    33ec:	0000 0000      	ori.b #0,d0
    33f0:	0100           	btst d0,d0
    33f2:	4c1e           	.short 0x4c1e
    33f4:	f61e 0800 611f 	move16 0x800611f,(a6)
    33fa:	701e           	moveq #30,d0
    33fc:	f002           	.short 0xf002
    33fe:	7c01           	moveq #1,d6
    3400:	0000 0000      	ori.b #0,d0
    3404:	0002 0eef      	ori.b #-17,d2
    3408:	fe67 c100      	cp1ld.w -(sp),a4,#1,#256
    340c:	7adf           	moveq #-33,d5
    340e:	8c3f           	.short 0x8c3f
    3410:	f83b           	.short 0xf83b
    3412:	f800 0000      	tblu.b d0,d0,d0
    3416:	0000 0003      	ori.b #3,d0
    341a:	8fe1           	divs.w -(a1),d7
    341c:	fa3b           	.short 0xfa3b
    341e:	e0c0           	.short 0xe0c0
    3420:	62ff b07f d801 	bhi.l 0xb0800c23
    3426:	dc00           	add.b d0,d6
    3428:	0000 0000      	ori.b #0,d0
    342c:	0041 c7d6      	ori.w #-14378,d1
    3430:	787d           	moveq #125,d4
    3432:	c970 21ff c3bf 	([,1610612736)and.w d4,([-1010835446],1610612736)
    3438:	e00a 6000 0000 
    343e:	0000 0030      	ori.b #48,d0
    3442:	67fe           	beq.s 0x3442
    3444:	03fc           	.short 0x03fc
    3446:	e078           	ror.w d0,d0
    3448:	05ff           	.short 0x05ff
    344a:	8580 0002      	unpk d0,d2,#2
    344e:	2000           	move.l d0,d0
    3450:	0000 0000      	ori.b #0,d0
    3454:	0000 67fe      	ori.b #-2,d0
    3458:	03fc           	.short 0x03fc
    345a:	e078           	ror.w d0,d0
    345c:	05ff           	.short 0x05ff
    345e:	8580 0002      	unpk d0,d2,#2
    3462:	2008           	move.l a0,d0
    3464:	0000 0000      	ori.b #0,d0
    3468:	0001 fbff      	ori.b #-1,d1
    346c:	01fc           	.short 0x01fc
    346e:	d68a           	add.l a2,d3
    3470:	043f           	.short 0x043f
    3472:	c020           	and.b -(a0),d0
    3474:	0005 c008      	ori.b #8,d5
    3478:	0000 0000      	ori.b #0,d0
    347c:	0000 7eff      	ori.b #-1,d0
    3480:	f9a0           	.short 0xf9a0
    3482:	f831           	.short 0xf831
    3484:	81d9           	divs.w (a1)+,d0
    3486:	0580           	bclr d2,d0
    3488:	0002 0010      	ori.b #16,d2
    348c:	0000 0000      	ori.b #0,d0
    3490:	0000 1fff      	ori.b #-1,d0
    3494:	b640           	cmp.w d0,d3
    3496:	fe01 c3e7      	cp1ld.b d1,a4,#2,#487
    349a:	0800 0000      	btst #0,d0
    349e:	0010 0000      	ori.b #0,(a0)
    34a2:	0000 0000      	ori.b #0,d0
    34a6:	43e7           	.short 0x43e7
    34a8:	0e60           	.short 0x0e60
    34aa:	fe73           	.short 0xfe73
    34ac:	c110           	and.b d0,(a0)
    34ae:	8000           	or.b d0,d0
    34b0:	0000 0020      	ori.b #32,d0
    34b4:	0000 0000      	ori.b #0,d0
    34b8:	0000 01f8      	ori.b #-8,d0
    34bc:	3c20           	move.w -(a0),d6
    34be:	1f7a 4311 4000 	move.b 0x77d1(pc),16384(sp)
    34c4:	003f           	.short 0x003f
    34c6:	e000           	asr.b #8,d0
    34c8:	0000 0000      	ori.b #0,d0
    34cc:	0000 00c8      	ori.b #-56,d0
    34d0:	079c           	bclr d3,(a4)+
    34d2:	d00d           	.short 0xd00d
    34d4:	c00f           	.short 0xc00f
    34d6:	0980           	bclr d4,d0
    34d8:	007f           	.short 0x007f
    34da:	dc00           	add.b d0,d6
    34dc:	0000 0000      	ori.b #0,d0
    34e0:	0000 04c8      	ori.b #-56,d0
    34e4:	079c           	bclr d3,(a4)+
    34e6:	d00d           	.short 0xd00d
    34e8:	c00f           	.short 0xc00f
    34ea:	0980           	bclr d4,d0
    34ec:	007f           	.short 0x007f
    34ee:	dc40           	add.w d0,d6
    34f0:	0000 0000      	ori.b #0,d0
    34f4:	0000 0007      	ori.b #7,d0
    34f8:	4b87           	chk.w d7,d5
    34fa:	3102           	move.w d2,-(a0)
    34fc:	000f           	.short 0x000f
    34fe:	7980           	mvz.b d0,d4
    3500:	093f           	.short 0x093f
    3502:	fc00 0000      	cp0nop #1
    3506:	0000 0000      	ori.b #0,d0
    350a:	0001 83db      	ori.b #-37,d1
    350e:	d0f3 a01f      	adda.w (31,a3,a2.w),a0
    3512:	bfe0           	cmpa.l -(a0),sp
    3514:	0e4b           	.short 0x0e4b
    3516:	fc00 0000      	cp0nop #1
    351a:	0000 0000      	ori.b #0,d0
    351e:	0006 c3bb      	ori.b #-69,d6
    3522:	39f3           	.short 0x39f3
    3524:	a007 f9bc      	msac.l d7,d0
    3528:	3882           	move.w d2,(a4)
    352a:	7880           	moveq #-128,d4
    352c:	0000 0000      	ori.b #0,d0
    3530:	0000 0010      	ori.b #16,d0
    3534:	f87c           	.short 0xf87c
    3536:	007f           	.short 0x007f
    3538:	8001           	or.b d1,d0
    353a:	77e3           	mvz.w -(a3),d3
    353c:	e83c           	ror.b d4,d4
	...
    3546:	0000 0c7f      	ori.b #127,d0
    354a:	09ff           	.short 0x09ff
    354c:	c000           	and.b d0,d0
    354e:	f5ff           	.short 0xf5ff
    3550:	f67e           	.short 0xf67e
    3552:	1f00           	move.b d0,-(sp)
	...
    355c:	0823 c97f      	btst #127,-(a3)
    3560:	0000 027f      	ori.b #127,d0
    3564:	21ff           	.short 0x21ff
    3566:	e700           	asl.b #3,d0
	...
    3570:	0823 c97e      	btst #126,-(a3)
    3574:	0000 027f      	ori.b #127,d0
    3578:	21ff           	.short 0x21ff
    357a:	e600           	asr.b #3,d0
	...
    3584:	0001 c6fe      	ori.b #-2,d1
    3588:	0008           	.short 0x0008
    358a:	0dde           	bset d6,(a6)+
    358c:	07ff           	.short 0x07ff
    358e:	fe00 0000      	cp1nop #1
    3592:	0000 0000      	ori.b #0,d0
    3596:	0000 403f      	ori.b #63,d0
    359a:	c000           	and.b d0,d0
    359c:	0004 cffc      	ori.b #-4,d4
    35a0:	00ff           	.short 0x00ff
    35a2:	c200           	and.b d0,d1
	...
    35ac:	0007 2808      	ori.b #8,d7
    35b0:	0004 3fc0      	ori.b #-64,d4
    35b4:	017f           	.short 0x017f
    35b6:	c000           	and.b d0,d0
	...
    35c0:	001f d7c0      	ori.b #-64,(sp)+
    35c4:	0000 fc00      	ori.b #0,d0
    35c8:	1174 0000 0000 	move.b (0,a4,d0.w),0(a0)
    35ce:	0000 0000      	ori.b #0,d0
    35d2:	0000 0027      	ori.b #39,d0
    35d6:	ee80           	asr.l #7,d0
    35d8:	0011 9000      	ori.b #0,(a1)
    35dc:	0045 d000      	ori.w #-12288,d5
	...
    35e8:	0005 ef00      	ori.b #0,d5
    35ec:	0000 2000      	ori.b #0,d0
    35f0:	00af 8000 0000 	ori.l #-2147483648,0(sp)
    35f6:	0000 
    35f8:	0000 0000      	ori.b #0,d0
    35fc:	0005 ef00      	ori.b #0,d5
    3600:	0000 0000      	ori.b #0,d0
    3604:	008f 8000 0000 	ori.l #-2147483648,d7
    360a:	0000 0000      	ori.b #0,d0
    360e:	0000 0008      	ori.b #8,d0
    3612:	f600 0007 3078 	move16 (a0)+,0x73078
    3618:	38f8 0000      	move.w 0x0,(a4)+
	...
    3624:	0000 f000      	ori.b #0,d0
	...
    3640:	000b           	.short 0x000b
    3642:	c000           	and.b d0,d0
	...
    3654:	007f           	.short 0x007f
    3656:	e000           	asr.b #8,d0
	...
    3668:	007f           	.short 0x007f
    366a:	e000           	asr.b #8,d0
	...
    367c:	007f           	.short 0x007f
    367e:	e000           	asr.b #8,d0
	...
    3690:	01ff           	.short 0x01ff
    3692:	c000           	and.b d0,d0
	...
    36a4:	0fff           	.short 0x0fff
    36a6:	c000           	and.b d0,d0
	...
    36b8:	3ff8           	.short 0x3ff8
	...
    36c2:	0000 0001      	ori.b #1,d0
    36c6:	0000 0000      	ori.b #0,d0
    36ca:	8000           	or.b d0,d0
    36cc:	ffff           	.short 0xffff
    36ce:	c000           	and.b d0,d0
	...
    36d8:	0001 8000      	ori.b #0,d1
    36dc:	1000           	move.b d0,d0
    36de:	0001 ffff      	ori.b #-1,d1
    36e2:	8000           	or.b d0,d0
	...
    36ec:	0162           	bchg d0,-(a2)
    36ee:	c000           	and.b d0,d0
    36f0:	4000           	negx.b d0
    36f2:	0003 ffff      	ori.b #-1,d3
    36f6:	8000           	or.b d0,d0
    36f8:	0000 0000      	ori.b #0,d0
    36fc:	0000 0006      	ori.b #6,d0
    3700:	0062 c002      	ori.w #-16382,-(a2)
    3704:	0000 0003      	ori.b #3,d0
    3708:	ffff           	.short 0xffff
    370a:	8000           	or.b d0,d0
	...
    3714:	0bdd           	bset d5,(a5)+
    3716:	c000           	and.b d0,d0
    3718:	0000 0807      	ori.b #7,d0
    371c:	d83f           	.short 0xd83f
    371e:	8000           	or.b d0,d0
	...
    3728:	b7bc           	.short 0xb7bc
    372a:	0040 0000      	ori.w #0,d0
    372e:	3003           	move.w d3,d0
    3730:	fe0b 8000      	cp1ld.b a3,a0,#1,#0
	...
    373c:	b3dc           	cmpa.l (a4)+,a1
    373e:	2002           	move.l d2,d0
    3740:	1800           	move.b d0,d4
    3742:	0007 ff00      	ori.b #0,d7
	...
    374e:	0000 37c0      	ori.b #-64,d0
    3752:	0008           	.short 0x0008
    3754:	0008           	.short 0x0008
    3756:	0017 ff00      	ori.b #0,(sp)
	...
    3762:	0008           	.short 0x0008
    3764:	2bc0           	.short 0x2bc0
    3766:	c000           	and.b d0,d0
    3768:	0000 4007      	ori.b #7,d0
    376c:	e700           	asl.b #3,d0
	...
    3776:	0008           	.short 0x0008
    3778:	6383           	bls.s 0x36fd
    377a:	0000 0020      	ori.b #32,d0
    377e:	0007 f900      	ori.b #0,d7
	...
    378a:	0008           	.short 0x0008
    378c:	6703           	beq.s 0x3791
    378e:	0000 00c1      	ori.b #-63,d0
    3792:	0007 f900      	ori.b #0,d7
	...
    379e:	0000 3803      	ori.b #3,d0
    37a2:	0000 0000      	ori.b #0,d0
    37a6:	0017 ffc0      	ori.b #-64,(sp)
	...
    37b2:	0006 0203      	ori.b #3,d6
    37b6:	0000 2701      	ori.b #1,d0
    37ba:	0016 ffc0      	ori.b #-64,(a6)
	...
    37c6:	000e           	.short 0x000e
    37c8:	0580           	bclr d2,d0
    37ca:	0000 3c03      	ori.b #3,d0
    37ce:	403f           	.short 0x403f
    37d0:	f800 0000      	tblu.b d0,d0,d0
    37d4:	0000 0000      	ori.b #0,d0
    37d8:	0000 000e      	ori.b #14,d0
    37dc:	3e02           	move.w d2,d7
    37de:	0000 0000      	ori.b #0,d0
    37e2:	001f ff80      	ori.b #-128,(sp)+
	...
    37ee:	0007 ff80      	ori.b #-128,d7
    37f2:	0000 0000      	ori.b #0,d0
    37f6:	001f ff00      	ori.b #0,(sp)+
	...
    3802:	0013 ff98      	ori.b #-104,(a3)
    3806:	0000 0030      	ori.b #48,d0
    380a:	001f fc00      	ori.b #0,(sp)+
	...
    3816:	0011 7f90      	ori.b #-112,(a1)
    381a:	0000 0030      	ori.b #48,d0
    381e:	001f fc00      	ori.b #0,(sp)+
	...
    382a:	0000 fe20      	ori.b #32,d0
    382e:	0000 00e0      	ori.b #-32,d0
    3832:	001f 7800      	ori.b #0,(sp)+
	...
    383e:	0000 3e00      	ori.b #0,d0
    3842:	0000 0000      	ori.b #0,d0
    3846:	003f           	.short 0x003f
	...
    3854:	7e00           	moveq #0,d7
    3856:	0000 0000      	ori.b #0,d0
    385a:	003a           	.short 0x003a
	...
    3864:	0000 0027      	ori.b #39,d0
    3868:	fe00 0000      	cp1nop #1
    386c:	0000 003f      	ori.b #63,d0
    3870:	f000           	.short 0xf000
	...
    387a:	000e           	.short 0x000e
    387c:	fe00 0000      	cp1nop #1
    3880:	0000 003f      	ori.b #63,d0
    3884:	f000           	.short 0xf000
	...
    388e:	0018 3c00      	ori.b #0,(a0)+
    3892:	0000 0038      	ori.b #56,d0
    3896:	007f           	.short 0x007f
    3898:	f000           	.short 0xf000
	...
    38a2:	0018 3c00      	ori.b #0,(a0)+
    38a6:	0000 0038      	ori.b #56,d0
    38aa:	007f           	.short 0x007f
    38ac:	f000           	.short 0xf000
	...
    38b6:	0059 7c00      	ori.w #31744,(a1)+
    38ba:	0000 0006      	ori.b #6,d0
    38be:	007f           	.short 0x007f
    38c0:	f000           	.short 0xf000
	...
    38ca:	0039 bc00 0000 	ori.b #0,0xe
    38d0:	000e 
    38d2:	307f           	.short 0x307f
    38d4:	c000           	and.b d0,d0
	...
    38de:	0038 7e00 0000 	ori.b #0,0x0
    38e4:	0030 f03f 0000 	ori.b #63,(0,a0,d0.w)
	...
    38f2:	00f8           	.short 0x00f8
    38f4:	7e00           	moveq #0,d7
    38f6:	0000 0037      	ori.b #55,d0
    38fa:	403e           	.short 0x403e
	...
    3904:	0000 0071      	ori.b #113,d0
    3908:	7c40           	moveq #64,d6
    390a:	0000 0007      	ori.b #7,d0
    390e:	f83e           	.short 0xf83e
	...
    3918:	0000 0161      	ori.b #97,d0
    391c:	7c40           	moveq #64,d6
    391e:	0000 0006      	ori.b #6,d0
    3922:	f83c           	.short 0xf83c
	...
    392c:	0000 00e1      	ori.b #-31,d0
    3930:	7c40           	moveq #64,d6
    3932:	0000 0006      	ori.b #6,d0
    3936:	f83c           	.short 0xf83c
	...
    3940:	0000 02ee      	ori.b #-18,d0
    3944:	fe00 0000      	cp1nop #1
    3948:	0001 f83c      	ori.b #60,d1
	...
    3954:	0000 01e0      	ori.b #-32,d0
    3958:	3c00           	move.w d0,d6
    395a:	0000 0007      	ori.b #7,d0
    395e:	f07e           	.short 0xf07e
	...
    3968:	0000 01f8      	ori.b #-8,d0
    396c:	3c00           	move.w d0,d6
    396e:	0000 0001      	ori.b #1,d0
    3972:	487f           	.short 0x487f
	...
    397c:	0000 05f0      	ori.b #-16,d0
    3980:	3e20           	move.w -(a0),d7
    3982:	0000 0000      	ori.b #0,d0
    3986:	087f           	.short 0x087f
	...
    3990:	0000 01f0      	ori.b #-16,d0
    3994:	3800           	move.w d0,d4
    3996:	0000 0000      	ori.b #0,d0
    399a:	047f           	.short 0x047f
    399c:	a000 0000      	mac.w d0l,d0l
    39a0:	0000 0000      	ori.b #0,d0
    39a4:	0000 01e0      	ori.b #-32,d0
    39a8:	3800           	move.w d0,d4
    39aa:	0100           	btst d0,d0
    39ac:	2000           	move.l d0,d0
    39ae:	37ff           	.short 0x37ff
    39b0:	c800           	and.b d0,d4
	...
    39ba:	01e0           	bset d0,-(a0)
    39bc:	3800           	move.w d0,d4
    39be:	0100           	btst d0,d0
    39c0:	3800           	move.w d0,d4
    39c2:	37ff           	.short 0x37ff
    39c4:	c000           	and.b d0,d0
	...
    39ce:	09f8 3818      	bset d4,0x3818
    39d2:	1770 02c0 0e7f 	move.b (-64,a0,d0.w:2),3711(a3)
    39d8:	f800 0000      	tblu.b d0,d0,d0
    39dc:	0000 0000      	ori.b #0,d0
    39e0:	0000 05f0      	ori.b #-16,d0
    39e4:	0821 ee44      	btst #68,-(a1)
    39e8:	1fc0           	.short 0x1fc0
    39ea:	0fe7           	bset d7,-(sp)
    39ec:	6f80           	ble.s 0x396e
	...
    39f6:	07f0 383b      	bset d3,(59,a0,d3.l)
    39fa:	01ff           	.short 0x01ff
    39fc:	ff20 1bbe      	cp1st.b d1,-(a0),#6,#446
    3a00:	3ff1           	.short 0x3ff1
    3a02:	9800           	sub.b d0,d4
    3a04:	0000 0080      	ori.b #-128,d0
    3a08:	0000 07d0      	ori.b #-48,d0
    3a0c:	7800           	moveq #0,d4
    3a0e:	00ff           	.short 0x00ff
    3a10:	ff30           	.short 0xff30
    3a12:	0206 06c2      	andi.b #-62,d6
    3a16:	3800           	move.w d0,d4
    3a18:	0000 1400      	ori.b #0,d0
    3a1c:	0000 17de      	ori.b #-34,d0
    3a20:	3800           	move.w d0,d4
    3a22:	01ff           	.short 0x01ff
    3a24:	ffe0           	.short 0xffe0
    3a26:	4c00           	.short 0x4c00
    3a28:	01f0 6000      	bset d0,(0,a0,d6.w)
    3a2c:	0000 b000      	ori.b #0,d0
    3a30:	0000 0fe6      	ori.b #-26,d0
    3a34:	7c00           	moveq #0,d6
    3a36:	087f           	.short 0x087f
    3a38:	bfc0           	cmpa.l d0,sp
    3a3a:	f800           	.short 0xf800
    3a3c:	01f0 7880      	bset d0,(-128,a0,d7.l)
    3a40:	0001 e830      	ori.b #48,d1
    3a44:	0000 2fe6      	ori.b #-26,d0
    3a48:	7c00           	moveq #0,d6
    3a4a:	087f           	.short 0x087f
    3a4c:	bfc0           	cmpa.l d0,sp
    3a4e:	f800           	.short 0xf800
    3a50:	01f0 78c0      	bset d0,(-64,a0,d7.l)
    3a54:	0017 e830      	ori.b #48,(sp)
    3a58:	0000 07e8      	ori.b #-24,d0
    3a5c:	be00           	cmp.b d0,d7
    3a5e:	1ef9 ffff fe00 	move.b 0xfffffe00,(sp)+
    3a64:	01f1 fb10      	bset d0,(0,a1,sp.l:2)
    3a68:	003e           	.short 0x003e
    3a6a:	f030           	.short 0xf030
    3a6c:	0000 07ee      	ori.b #-18,d0
    3a70:	7fa1           	mvz.b -(a1),d7
    3a72:	fffb           	.short 0xfffb
    3a74:	ffff           	.short 0xffff
    3a76:	ffe0           	.short 0xffe0
    3a78:	0ff5 fbc0      	bset d7,(0)
    3a7c:	027e           	.short 0x027e
    3a7e:	c030 0000      	and.b (0,a0,d0.w),d0
    3a82:	0fe6           	bset d7,-(a6)
    3a84:	ffdd           	.short 0xffdd
    3a86:	ffba           	.short 0xffba
    3a88:	7fff           	.short 0x7fff
    3a8a:	cfc0           	muls.w d0,d7
    3a8c:	1ffc           	.short 0x1ffc
    3a8e:	65c1           	bcs.s 0x3a51
    3a90:	47a7           	chk.w -(sp),d3
    3a92:	0830 0001 07f0 	btst #1,(2147483593)
    3a98:	7fff ffc9 
    3a9c:	ffff           	.short 0xffff
    3a9e:	07c0           	bset d3,d0
    3aa0:	1ffb           	.short 0x1ffb
    3aa2:	fa08           	.short 0xfa08
    3aa4:	3e78 0030      	movea.w 0x30,sp
    3aa8:	0000 3ff8      	ori.b #-8,d0
    3aac:	3fff           	.short 0x3fff
    3aae:	ff80 661f      	cp1st.l d6,d0,#4,#31
    3ab2:	3380 fff0 18c0 	move.w d0,(415240120)
    3ab8:	0fb8 
    3aba:	3070 0002      	movea.w (2,a0,d0.w),a0
    3abe:	27d9           	.short 0x27d9
    3ac0:	3fff           	.short 0x3fff
    3ac2:	fe00 0000      	cp1nop #1
    3ac6:	7000           	moveq #0,d0
    3ac8:	3fb0 0000 3600 	move.w (0,a0,d0.w),(0,sp,d3.w:8)
    3ace:	30f0 0002      	move.w (2,a0,d0.w),(a0)+
    3ad2:	03d9           	bset d1,(a1)+
    3ad4:	3fff           	.short 0x3fff
    3ad6:	fe00 0000      	cp1nop #1
    3ada:	7000           	moveq #0,d0
    3adc:	3fb0 0000 3600 	move.w (0,a0,d0.w),(0,sp,d3.w:8)
    3ae2:	30e0           	move.w -(a0),(a0)+
    3ae4:	0000 4ff0      	ori.b #-16,d0
    3ae8:	7fff           	.short 0x7fff
    3aea:	c788           	exg d3,a0
    3aec:	0031 7800 1940 	ori.b #0,(0,a1)
    3af2:	0000 0004      	ori.b #4,d0
    3af6:	e9e0           	.short 0xe9e0
    3af8:	0000 083e      	ori.b #62,d0
    3afc:	7e1b           	moveq #27,d7
    3afe:	c100           	abcd d0,d0
    3b00:	001f c200      	ori.b #0,(sp)+
    3b04:	f1f8           	.short 0xf1f8
    3b06:	0000 0023      	ori.b #35,d0
    3b0a:	01c0           	bset d0,d0
    3b0c:	0000 44f9      	ori.b #-7,d0
    3b10:	f000           	.short 0xf000
    3b12:	c830 003f      	and.b (63,a0,d0.w),d4
    3b16:	fdc0           	.short 0xfdc0
    3b18:	01fe           	.short 0x01fe
    3b1a:	0000 0003      	ori.b #3,d0
    3b1e:	2000           	move.l d0,d0
    3b20:	0004 00f6      	ori.b #-10,d4
    3b24:	f400           	.short 0xf400
    3b26:	0000 03ff      	ori.b #-1,d0
    3b2a:	fe40 0978      	cp1ld.w d0,d0,#5,#376
    3b2e:	0000 099f      	ori.b #-97,d0
    3b32:	c000           	and.b d0,d0
    3b34:	0004 00f0      	ori.b #-16,d4
    3b38:	c002           	and.b d2,d0
    3b3a:	2000           	move.l d0,d0
    3b3c:	01ff           	.short 0x01ff
    3b3e:	ffc0           	.short 0xffc0
    3b40:	0080 0000 3e20 	ori.l #15904,d0
    3b46:	0000 0004      	ori.b #4,d0
    3b4a:	01ce 0400      	movep.l d0,1024(a6)
    3b4e:	0800 41ff      	btst #-1,d0
    3b52:	f1c0           	.short 0xf1c0
    3b54:	0074 0000 3be0 	ori.w #0,(0)
    3b5a:	0000 
    3b5c:	0004 01ce      	ori.b #-50,d4
    3b60:	0400 0800      	subi.b #0,d0
    3b64:	41ff           	.short 0x41ff
    3b66:	f1c0           	.short 0xf1c0
    3b68:	0074 0000 3bc0 	ori.w #0,(0)
    3b6e:	0000 0004      	ori.b #4,d0
    3b72:	0100           	btst d0,d0
    3b74:	0418 0871      	subi.b #113,(a0)+
    3b78:	c1ff           	.short 0xc1ff
    3b7a:	f980           	.short 0xf980
    3b7c:	0000 0001      	ori.b #1,d0
    3b80:	ff80 0000      	cp1st.l d0,d0,#1,#0
    3b84:	0000 0300      	ori.b #0,d0
    3b88:	0000 1ec9      	ori.b #-55,d0
    3b8c:	c239 fdd8 0001 	and.b 0xfdd80001,d1
    3b92:	8007           	or.b d7,d0
    3b94:	f660           	.short 0xf660
    3b96:	1000           	move.b d0,d0
    3b98:	0000 0700      	ori.b #0,d0
    3b9c:	0807 ff79      	btst #121,d7
    3ba0:	e0f6 b040      	asr.w (64,a6,a3.w)
    3ba4:	0000 0001      	ori.b #1,d0
    3ba8:	cdc0           	muls.w d0,d6
    3baa:	0000 0000      	ori.b #0,d0
    3bae:	1ffe           	.short 0x1ffe
    3bb0:	381f           	move.w (sp)+,d4
    3bb2:	fff2           	.short 0xfff2
    3bb4:	61e8           	bsr.s 0x3b9e
    3bb6:	c380           	.short 0xc380
    3bb8:	0039 c001 fd80 	ori.b #1,0xfd802000
    3bbe:	2000 
    3bc0:	0000 05ff      	ori.b #-1,d0
    3bc4:	3c21           	move.w -(a1),d6
    3bc6:	efc9           	.short 0xefc9
    3bc8:	f82f           	.short 0xf82f
    3bca:	3c00           	move.w d0,d6
    3bcc:	0000 180f      	ori.b #15,d0
    3bd0:	f840           	.short 0xf840
    3bd2:	0000 0008      	ori.b #8,d0
    3bd6:	00ff           	.short 0x00ff
    3bd8:	f01f           	.short 0xf01f
    3bda:	ffc9           	.short 0xffc9
    3bdc:	fa10           	.short 0xfa10
    3bde:	0400 0000      	subi.b #0,d0
    3be2:	1c07           	move.b d7,d6
    3be4:	f800 4000      	tblu.b d0,d0,d4
    3be8:	0008           	.short 0x0008
    3bea:	00ff           	.short 0x00ff
    3bec:	f01f           	.short 0xf01f
    3bee:	ffc9           	.short 0xffc9
    3bf0:	fa10           	.short 0xfa10
    3bf2:	0400 0000      	subi.b #0,d0
    3bf6:	1c07           	move.b d7,d6
    3bf8:	f800 0000      	tblu.b d0,d0,d0
    3bfc:	0008           	.short 0x0008
    3bfe:	00ff           	.short 0x00ff
    3c00:	3001           	move.w d1,d0
    3c02:	3f40 3eef      	move.w d0,16111(sp)
    3c06:	3c00           	move.w d0,d6
    3c08:	0000 3e1f      	ori.b #31,d0
    3c0c:	f000           	.short 0xf000
    3c0e:	8000           	or.b d0,d0
    3c10:	0008           	.short 0x0008
    3c12:	043f           	.short 0x043f
    3c14:	f801           	.short 0xf801
    3c16:	dfb0 1e2f      	add.l d7,(47,a0,d1.l:8)
    3c1a:	8006           	or.b d6,d0
    3c1c:	0000 3f07      	ori.b #7,d0
    3c20:	7000           	moveq #0,d0
    3c22:	0000 000c      	ori.b #12,d0
    3c26:	001f 8800      	ori.b #0,(sp)+
    3c2a:	0680 5e06 001a 	addi.l #1577451546,d0
    3c30:	0000 1b0f      	ori.b #15,d0
    3c34:	7000           	moveq #0,d0
    3c36:	0000 000c      	ori.b #12,d0
    3c3a:	18fe           	.short 0x18fe
    3c3c:	c001           	and.b d1,d0
    3c3e:	c14c           	exg a0,a4
    3c40:	3c00           	move.w d0,d6
    3c42:	0023 0000      	ori.b #0,-(a3)
    3c46:	3e00           	move.w d0,d7
    3c48:	7001           	moveq #1,d0
    3c4a:	0000 000c      	ori.b #12,d0
    3c4e:	07ff           	.short 0x07ff
    3c50:	8003           	or.b d3,d0
    3c52:	fff7           	.short 0xfff7
    3c54:	f801           	.short 0xf801
    3c56:	0021 0000      	ori.b #0,-(a1)
    3c5a:	0500           	btst d2,d0
    3c5c:	e000           	asr.b #8,d0
    3c5e:	0000 000e      	ori.b #14,d0
    3c62:	07bf           	.short 0x07bf
    3c64:	8003           	or.b d3,d0
    3c66:	d0ff           	.short 0xd0ff
    3c68:	e007           	asr.b #8,d7
    3c6a:	0020 c000      	ori.b #0,-(a0)
    3c6e:	000f           	.short 0x000f
    3c70:	e000           	asr.b #8,d0
    3c72:	0000 0008      	ori.b #8,d0
    3c76:	073b 8003      	btst d3,(0x3c7b,pc,a0.w)
    3c7a:	d0ff           	.short 0xd0ff
    3c7c:	e007           	asr.b #8,d7
    3c7e:	0022 c000      	ori.b #0,-(a2)
    3c82:	000f           	.short 0x000f
    3c84:	c000           	and.b d0,d0
    3c86:	0000 000c      	ori.b #12,d0
    3c8a:	03f0 0003      	bset d1,(3,a0,d0.w)
    3c8e:	e97f           	rol.w d4,d7
    3c90:	c000           	and.b d0,d0
    3c92:	0015 4800      	ori.b #0,(a5)
    3c96:	03ff           	.short 0x03ff
    3c98:	8000           	or.b d0,d0
    3c9a:	0000 0008      	ori.b #8,d0
    3c9e:	07ee 4003      	bset d3,16387(a6)
    3ca2:	e1be           	rol.l d0,d6
    3ca4:	0000 0010      	ori.b #16,d0
    3ca8:	e800           	asr.b #4,d0
    3caa:	1fff           	.short 0x1fff
    3cac:	0000 0000      	ori.b #0,d0
    3cb0:	000c           	.short 0x000c
    3cb2:	07e7           	bset d3,-(sp)
    3cb4:	4400           	neg.b d0
    3cb6:	c100           	abcd d0,d0
    3cb8:	0000 0000      	ori.b #0,d0
    3cbc:	0600 3ff8      	addi.b #-8,d0
    3cc0:	8000           	or.b d0,d0
    3cc2:	0000 0008      	ori.b #8,d0
    3cc6:	03ff           	.short 0x03ff
    3cc8:	cc00           	and.b d0,d6
    3cca:	0000 0000      	ori.b #0,d0
    3cce:	0060 0000      	ori.w #0,-(a0)
    3cd2:	7fe0           	mvz.w -(a0),d7
    3cd4:	0000 0000      	ori.b #0,d0
    3cd8:	000e           	.short 0x000e
    3cda:	01ff           	.short 0x01ff
    3cdc:	fc00 0000      	cp0nop #1
    3ce0:	0000 0040      	ori.b #64,d0
    3ce4:	4000           	negx.b d0
    3ce6:	7f20           	mvs.b -(a0),d7
    3ce8:	0000 0000      	ori.b #0,d0
    3cec:	0006 01ff      	ori.b #-1,d6
    3cf0:	be00           	cmp.b d0,d7
    3cf2:	0000 03fe      	ori.b #-2,d0
    3cf6:	0040 2001      	ori.w #8193,d0
    3cfa:	de40           	add.w d0,d7
    3cfc:	0000 0000      	ori.b #0,d0
    3d00:	0007 01ff      	ori.b #-1,d7
    3d04:	be00           	cmp.b d0,d7
    3d06:	0000 03fe      	ori.b #-2,d0
    3d0a:	0040 8001      	ori.w #-32767,d0
    3d0e:	de00           	add.b d0,d7
    3d10:	0000 0000      	ori.b #0,d0
    3d14:	000c           	.short 0x000c
    3d16:	03df           	bset d1,(sp)+
    3d18:	ffc0           	.short 0xffc0
    3d1a:	0000 07ff      	ori.b #-1,d0
    3d1e:	07f8 0003      	bset d3,0x3
    3d22:	a400 0000      	mac.w d0l,d2l
    3d26:	0000 000a      	ori.b #10,d0
    3d2a:	07c8 ffe0      	movep.l d3,-32(a0)
    3d2e:	0000 1fff      	ori.b #-1,d0
    3d32:	fffb           	.short 0xfffb
    3d34:	0803 14d0      	btst #-48,d3
    3d38:	0200 0000      	andi.b #0,d0
    3d3c:	0008           	.short 0x0008
    3d3e:	07de           	bset d3,(a6)+
    3d40:	b7fc 0000 183f 	cmpa.l #6207,a3
    3d46:	fff9           	.short 0xfff9
    3d48:	300f           	move.w sp,d0
    3d4a:	1a00           	move.b d0,d5
    3d4c:	0400 0000      	subi.b #0,d0
    3d50:	000c           	.short 0x000c
    3d52:	1fe1           	.short 0x1fe1
    3d54:	f7fc           	.short 0xf7fc
    3d56:	0000 0007      	ori.b #7,d0
    3d5a:	87c0           	divs.w d0,d3
    3d5c:	00bf 07c8 0800 	ori.l #130549760,d7
    3d62:	0000 000c      	ori.b #12,d0
    3d66:	07ff           	.short 0x07ff
    3d68:	007c 0000      	ori.w #0,sr
    3d6c:	002f 8180 11fd 	ori.b #-128,4605(sp)
    3d72:	0ff8 0000      	bset d7,0x0
    3d76:	0000 0006      	ori.b #6,d0
    3d7a:	07f1 003c      	bset d3,(60,a1,d0.w)
    3d7e:	0080 0006 0000 	ori.l #393216,d0
    3d84:	017e           	.short 0x017e
    3d86:	1ef0 0000      	move.b (0,a0,d0.w),(sp)+
    3d8a:	0000 0006      	ori.b #6,d0
    3d8e:	07f1 003c      	bset d3,(60,a1,d0.w)
    3d92:	0080 0006 0000 	ori.l #393216,d0
    3d98:	006c 3ef0 0000 	ori.w #16112,0(a4)
    3d9e:	0000 0007      	ori.b #7,d0
    3da2:	83ff           	.short 0x83ff
    3da4:	8023           	or.b -(a3),d0
    3da6:	0100           	btst d0,d0
    3da8:	0000 0000      	ori.b #0,d0
    3dac:	005c 7fe0      	ori.w #32736,(a4)+
    3db0:	0000 0000      	ori.b #0,d0
    3db4:	0003 81ff      	ori.b #-1,d3
    3db8:	c001           	and.b d1,d0
    3dba:	c700           	abcd d0,d3
    3dbc:	01e0           	bset d0,-(a0)
    3dbe:	0002 00f9      	ori.b #-7,d2
    3dc2:	ffc0           	.short 0xffc0
    3dc4:	0000 0000      	ori.b #0,d0
    3dc8:	0003 c7ff      	ori.b #-1,d3
    3dcc:	c018           	and.b (a0)+,d0
    3dce:	3fc0           	.short 0x3fc0
    3dd0:	03e0           	bset d1,-(a0)
    3dd2:	0201 e077      	andi.b #119,d1
    3dd6:	fff0           	.short 0xfff0
    3dd8:	0000 0000      	ori.b #0,d0
    3ddc:	0001 81ff      	ori.b #-1,d1
    3de0:	c020           	and.b -(a0),d0
    3de2:	3604           	move.w d4,d3
    3de4:	0000 3203      	ori.b #3,d0
    3de8:	fef7           	.short 0xfef7
    3dea:	fbf8           	.short 0xfbf8
    3dec:	0000 0000      	ori.b #0,d0
    3df0:	0001 87ff      	ori.b #-1,d1
    3df4:	f805           	.short 0xf805
    3df6:	1033 8006      	move.b (6,a3,a0.w),d0
    3dfa:	0f80           	bclr d7,d0
    3dfc:	ffff           	.short 0xffff
    3dfe:	fff8           	.short 0xfff8
    3e00:	0000 0000      	ori.b #0,d0
    3e04:	0000 83ff      	ori.b #-1,d0
    3e08:	c81d           	and.b (a5)+,d4
    3e0a:	0000 6008      	ori.b #8,d0
    3e0e:	0fc5           	bset d7,d5
    3e10:	3fef           	.short 0x3fef
    3e12:	fffe           	.short 0xfffe
    3e14:	0000 0000      	ori.b #0,d0
    3e18:	0000 03ff      	ori.b #-1,d0
    3e1c:	c81d           	and.b (a5)+,d4
    3e1e:	0000 6008      	ori.b #8,d0
    3e22:	0fc3           	bset d7,d3
    3e24:	3fdf           	.short 0x3fdf
    3e26:	fffc           	.short 0xfffc
    3e28:	0000 0000      	ori.b #0,d0
    3e2c:	0000 41ff      	ori.b #-1,d0
    3e30:	b805           	cmp.b d5,d4
    3e32:	c030 3f3e 380e 	([,-8)and.b ([940507103,a0],d3.l:8,-8),d0
    3e38:	ffdf fff8 
    3e3c:	0000 0000      	ori.b #0,d0
    3e40:	0000 213f      	ori.b #63,d0
    3e44:	f81b           	.short 0xf81b
    3e46:	f001           	.short 0xf001
    3e48:	fff8           	.short 0xfff8
    3e4a:	005d ff7f      	ori.w #-129,(a5)+
    3e4e:	fff8           	.short 0xfff8
    3e50:	0000 0000      	ori.b #0,d0
    3e54:	0000 00ff      	ori.b #-1,d0
    3e58:	f01f           	.short 0xf01f
    3e5a:	e088           	lsr.l #8,d0
    3e5c:	06c0           	rtm d0
    3e5e:	03bb           	.short 0x03bb
    3e60:	cf7f           	.short 0xcf7f
    3e62:	fff0           	.short 0xfff0
    3e64:	0000 0000      	ori.b #0,d0
    3e68:	0000 001f      	ori.b #31,d0
    3e6c:	fe1d c0c0      	cp1ld.b (a5)+,a4,#1,#192
    3e70:	01c0           	bset d0,d0
    3e72:	081f c0ff      	btst #-1,(sp)+
    3e76:	fff0           	.short 0xfff0
    3e78:	0000 0000      	ori.b #0,d0
    3e7c:	0000 0007      	ori.b #7,d0
    3e80:	ffe6           	.short 0xffe6
    3e82:	0f08 01c0      	movep.w 448(a0),d7
    3e86:	701f           	moveq #31,d0
    3e88:	efff           	.short 0xefff
    3e8a:	ffe0           	.short 0xffe0
	...
    3e94:	7fff           	.short 0x7fff
    3e96:	cfc0           	muls.w d0,d7
    3e98:	07f9 803f efff 	bset d3,0x803fefff
    3e9e:	ffe0           	.short 0xffe0
    3ea0:	0000 0000      	ori.b #0,d0
    3ea4:	0000 0200      	ori.b #0,d0
    3ea8:	7fff           	.short 0x7fff
    3eaa:	cfc0           	muls.w d0,d7
    3eac:	07f9 803f efff 	bset d3,0x803fefff
    3eb2:	ffe0           	.short 0xffe0
	...
    3ebc:	ffbd           	.short 0xffbd
    3ebe:	ffc0           	.short 0xffc0
    3ec0:	07ff           	.short 0x07ff
    3ec2:	807f           	.short 0x807f
    3ec4:	ffff           	.short 0xffff
    3ec6:	ffe0           	.short 0xffe0
    3ec8:	0000 0000      	ori.b #0,d0
    3ecc:	0000 0010      	ori.b #16,d0
    3ed0:	3fdb           	.short 0x3fdb
    3ed2:	fe00 3ffe      	cp1ld.b d0,d3,#8,#510
    3ed6:	81ff           	.short 0x81ff
    3ed8:	f77f           	.short 0xf77f
    3eda:	ffc0           	.short 0xffc0
    3edc:	0000 0000      	ori.b #0,d0
    3ee0:	0000 0060      	ori.b #96,d0
    3ee4:	0fff           	.short 0x0fff
    3ee6:	ce00           	and.b d0,d7
    3ee8:	63fe           	bls.s 0x3ee8
    3eea:	01ff           	.short 0x01ff
    3eec:	f901           	.short 0xf901
    3eee:	ffc0           	.short 0xffc0
    3ef0:	0000 0000      	ori.b #0,d0
    3ef4:	0000 0036      	ori.b #54,d0
    3ef8:	0dbf           	.short 0x0dbf
    3efa:	fe00 3ff7      	cp1ld.b d0,d3,#8,#503
    3efe:	03ff           	.short 0x03ff
    3f00:	ff00 7fc0      	cp1st.b d7,d0,#8,#448
    3f04:	0000 0000      	ori.b #0,d0
    3f08:	0000 0018      	ori.b #24,d0
    3f0c:	03ff           	.short 0x03ff
    3f0e:	f600 7fff 47ff 	move16 (a0)+,0x7fff47ff
    3f14:	ff30           	.short 0xff30
    3f16:	7fc0           	mvz.w d0,d7
    3f18:	0000 0000      	ori.b #0,d0
    3f1c:	0000 000e      	ori.b #14,d0
    3f20:	003f           	.short 0x003f
    3f22:	c103           	abcd d3,d0
    3f24:	fffe           	.short 0xfffe
    3f26:	0fff           	.short 0x0fff
    3f28:	ffc0           	.short 0xffc0
    3f2a:	3dc0           	.short 0x3dc0
    3f2c:	0000 0000      	ori.b #0,d0
    3f30:	0000 000e      	ori.b #14,d0
    3f34:	003f           	.short 0x003f
    3f36:	c103           	abcd d3,d0
    3f38:	fffe           	.short 0xfffe
    3f3a:	0fff           	.short 0x0fff
    3f3c:	ffc0           	.short 0xffc0
    3f3e:	3dc0           	.short 0x3dc0
    3f40:	0000 0000      	ori.b #0,d0
    3f44:	0000 000f      	ori.b #15,d0
    3f48:	c03e           	.short 0xc03e
    3f4a:	e0ff           	.short 0xe0ff
    3f4c:	fff9           	.short 0xfff9
    3f4e:	3fff           	.short 0x3fff
    3f50:	ffc0           	.short 0xffc0
    3f52:	1fc0           	.short 0x1fc0
    3f54:	0000 0000      	ori.b #0,d0
    3f58:	0000 001f      	ori.b #31,d0
    3f5c:	f01f           	.short 0xf01f
    3f5e:	ee7f           	ror.w d7,d7
    3f60:	fff9           	.short 0xfff9
    3f62:	7fff           	.short 0x7fff
    3f64:	fff0           	.short 0xfff0
    3f66:	19e0           	.short 0x19e0
    3f68:	0000 0000      	ori.b #0,d0
    3f6c:	0080 0021 fc07 	ori.l #2227207,d0
    3f72:	ffff           	.short 0xffff
    3f74:	fffe           	.short 0xfffe
    3f76:	7fff           	.short 0x7fff
    3f78:	ffb0           	.short 0xffb0
    3f7a:	05e0           	bset d2,-(a0)
    3f7c:	0000 0000      	ori.b #0,d0
    3f80:	0100           	btst d0,d0
    3f82:	0080 fc03 ffff 	ori.l #-66846721,d0
    3f88:	fffe           	.short 0xfffe
    3f8a:	ffff           	.short 0xffff
    3f8c:	ffc0           	.short 0xffc0
    3f8e:	0220 0000      	andi.b #0,-(a0)
    3f92:	0000 01c0      	ori.b #-64,d0
    3f96:	00f8           	.short 0x00f8
    3f98:	3f81 ffff ff39 	([,-1048352)move.w d1,([-12976129],-1048352)
    3f9e:	ffff fff0 00e0 
    3fa4:	0000 0000      	ori.b #0,d0
    3fa8:	0180           	bclr d0,d0
    3faa:	03d6           	bset d1,(a6)
    3fac:	07c0           	bset d3,d0
    3fae:	0fcf ffff      	movep.l d7,-1(sp)
    3fb2:	ffff           	.short 0xffff
    3fb4:	fff8           	.short 0xfff8
    3fb6:	0030 0000 0000 	ori.b #0,(0,a0,d0.w)
    3fbc:	0180           	bclr d0,d0
    3fbe:	03d6           	bset d1,(a6)
    3fc0:	07c0           	bset d3,d0
    3fc2:	0fcf ffff      	movep.l d7,-1(sp)
    3fc6:	ffff           	.short 0xffff
    3fc8:	fff8           	.short 0xfff8
    3fca:	0030 0000 0000 	ori.b #0,(0,a0,d0.w)
    3fd0:	0580           	bclr d2,d0
    3fd2:	03c7           	bset d1,d7
    3fd4:	07f8 077f      	bset d3,0x77f
    3fd8:	fd0f ffff      	cp0st.b sp,sp,#8,#511
    3fdc:	fff8           	.short 0xfff8
    3fde:	0010 0000      	ori.b #0,(a0)
    3fe2:	0000 05c0      	ori.b #-64,d0
    3fe6:	0be7           	bset d5,-(sp)
    3fe8:	83fa 003b      	divs.w 0x4025(pc),d1
    3fec:	fc1f ffff      	cp0ld.b (sp)+,sp,#8,#511
    3ff0:	fffc           	.short 0xfffc
    3ff2:	0006 8000      	ori.b #0,d6
    3ff6:	0000 00e0      	ori.b #-32,d0
    3ffa:	03ff           	.short 0x03ff
    3ffc:	f07c 0001      	ptrapbc
    4000:	f81f           	.short 0xf81f
    4002:	ffff           	.short 0xffff
    4004:	fffe           	.short 0xfffe
    4006:	001e 0000      	ori.b #0,(a6)+
    400a:	0000 0040      	ori.b #64,d0
    400e:	23ff           	.short 0x23ff
    4010:	fe00 0000      	cp1nop #1
    4014:	003f           	.short 0x003f
    4016:	ffff           	.short 0xffff
    4018:	f9ff           	.short 0xf9ff
    401a:	c03f           	.short 0xc03f
    401c:	0000 0000      	ori.b #0,d0
    4020:	0200 01ff      	andi.b #-1,d0
    4024:	ff80 0e02      	cp1st.l d0,d0,#8,#2
    4028:	003f           	.short 0x003f
    402a:	ffff           	.short 0xffff
    402c:	f0ff           	.short 0xf0ff
    402e:	faff           	.short 0xfaff
    4030:	4000           	negx.b d0
    4032:	0000 0200      	ori.b #0,d0
    4036:	60ff ff80 1fc0 	bra.l 0xff805ff8
    403c:	4037 ffff c0ff 	([,0)negx.b ([-1056980481],0)
    4042:	c1ff 0000 0000 
    4048:	0000 70ff      	ori.b #-1,d0
    404c:	ff80 1fc0      	cp1st.l d1,d0,#8,#448
    4050:	4037 ffff c0ff 	([,0)negx.b ([-1056980481],0)
    4056:	c1ff 0000 0000 
    405c:	0004 603f      	ori.b #63,d4
    4060:	fe3c           	.short 0xfe3c
    4062:	1fff           	.short 0x1fff
    4064:	c037 ffff f0ff 	([,0)and.b ([-251658498],0),d0
    406a:	fefe 0000 0000 
    4070:	0003 b01f      	ori.b #31,d3
    4074:	f61e 07ff 8120 	move16 0x7ff8120,(a6)
    407a:	8fff           	.short 0x8fff
    407c:	f0ff           	.short 0xf0ff
    407e:	fdfe           	.short 0xfdfe
    4080:	0000 0000      	ori.b #0,d0
    4084:	0001 f00f      	ori.b #15,d1
    4088:	fe7f           	.short 0xfe7f
    408a:	c0ff           	.short 0xc0ff
    408c:	82e0           	divu.w -(a0),d1
    408e:	73ff           	.short 0x73ff
    4090:	f8ff           	.short 0xf8ff
    4092:	fbfe           	.short 0xfbfe
    4094:	0000 0000      	ori.b #0,d0
    4098:	0080 7001 fa07 	ori.l #1879177735,d0
    409e:	e03f           	ror.b d0,d7
    40a0:	82c7           	divu.w d7,d1
    40a2:	4fff           	.short 0x4fff
    40a4:	dfff           	.short 0xdfff
    40a6:	fffc           	.short 0xfffc
    40a8:	0000 0000      	ori.b #0,d0
    40ac:	0000 3800      	ori.b #0,d0
    40b0:	7863           	moveq #99,d4
    40b2:	c80f           	.short 0xc80f
    40b4:	c1cf           	.short 0xc1cf
    40b6:	bfbf           	.short 0xbfbf
    40b8:	ffff           	.short 0xffff
    40ba:	fffc           	.short 0xfffc
    40bc:	0000 0000      	ori.b #0,d0
    40c0:	0000 1800      	ori.b #0,d0
    40c4:	03bb           	.short 0x03bb
    40c6:	e007           	asr.b #8,d7
    40c8:	f9cf           	.short 0xf9cf
    40ca:	7583           	mvz.b d3,d2
    40cc:	ffff           	.short 0xffff
    40ce:	fff8           	.short 0xfff8
    40d0:	0000 0000      	ori.b #0,d0
    40d4:	0010 1800      	ori.b #0,(a0)
    40d8:	03bb           	.short 0x03bb
    40da:	e007           	asr.b #8,d7
    40dc:	f9cf           	.short 0xf9cf
    40de:	7583           	mvz.b d3,d2
    40e0:	ffff           	.short 0xffff
    40e2:	fff8           	.short 0xfff8
    40e4:	0000 0000      	ori.b #0,d0
    40e8:	0008           	.short 0x0008
    40ea:	0400 0183      	subi.b #-125,d0
    40ee:	d601           	add.b d1,d3
    40f0:	f8e0           	.short 0xf8e0
    40f2:	403f           	.short 0x403f
    40f4:	ffff           	.short 0xffff
    40f6:	fff0           	.short 0xfff0
    40f8:	0000 0000      	ori.b #0,d0
    40fc:	0000 0100      	ori.b #0,d0
    4100:	01df           	bset d0,(sp)+
    4102:	f830           	.short 0xf830
    4104:	7df7 07ff ffff 	([,0)mvz.w ([-16],0),d6
    410a:	fff0 0000 0000 
    4110:	0001 0000      	ori.b #0,d1
    4114:	407f           	.short 0x407f
    4116:	fe00 03f7      	cp1ld.b d0,d0,#2,#503
    411a:	0fff           	.short 0x0fff
    411c:	ffff           	.short 0xffff
    411e:	ffe0           	.short 0xffe0
    4120:	0000 0000      	ori.b #0,d0
    4124:	0000 0018      	ori.b #24,d0
    4128:	f07f           	.short 0xf07f
    412a:	fe70           	.short 0xfe70
    412c:	0110           	btst d0,(a0)
    412e:	ffff           	.short 0xffff
    4130:	ffff           	.short 0xffff
    4132:	ffe0           	.short 0xffe0
    4134:	0000 0000      	ori.b #0,d0
    4138:	0000 2007      	ori.b #7,d0
    413c:	c03f           	.short 0xc03f
    413e:	fff8           	.short 0xfff8
    4140:	2101           	move.l d1,-(a0)
    4142:	ffff           	.short 0xffff
    4144:	ffff           	.short 0xffff
    4146:	ffe0           	.short 0xffe0
    4148:	0000 0000      	ori.b #0,d0
    414c:	0000 0007      	ori.b #7,d0
    4150:	f81f           	.short 0xf81f
    4152:	fffc           	.short 0xfffc
    4154:	220f           	move.l sp,d1
    4156:	ffff           	.short 0xffff
    4158:	ffff           	.short 0xffff
    415a:	ffc0           	.short 0xffc0
    415c:	0000 0000      	ori.b #0,d0
    4160:	0000 0007      	ori.b #7,d0
    4164:	f81f           	.short 0xf81f
    4166:	fffc           	.short 0xfffc
    4168:	200f           	move.l sp,d0
    416a:	ffff           	.short 0xffff
    416c:	ffff           	.short 0xffff
    416e:	ff80 0000      	cp1st.l d0,d0,#1,#0
    4172:	0000 0000      	ori.b #0,d0
    4176:	0200 b407      	andi.b #7,d0
    417a:	fefe           	.short 0xfefe
    417c:	210f           	move.l sp,-(a0)
    417e:	ffff           	.short 0xffff
    4180:	f93f           	.short 0xf93f
    4182:	ff40 0000      	cp1st.w d0,d0,#1,#0
    4186:	0000 0000      	ori.b #0,d0
    418a:	0000 7c1b      	ori.b #27,d0
    418e:	ff0f 801f      	cp1st.b a0,sp,#1,#31
    4192:	ffff           	.short 0xffff
    4194:	c04b           	.short 0xc04b
    4196:	fe00 0000      	cp1nop #1
    419a:	0000 0000      	ori.b #0,d0
    419e:	0040 3c43      	ori.w #15427,d0
    41a2:	fe0f 8087      	cp1ld.b sp,a0,#1,#135
    41a6:	ffff           	.short 0xffff
    41a8:	0002 7c00      	ori.b #0,d2
	...
    41b4:	0781           	bclr d3,d1
    41b6:	ff83 a001      	cp1st.l a2,d3,#1,#1
    41ba:	77e3           	mvz.w -(a3),d3
    41bc:	0033 f880 0000 	ori.b #-128,(0,a3,d0.w)
    41c2:	0000 0000      	ori.b #0,d0
    41c6:	0008           	.short 0x0008
    41c8:	0381           	bclr d1,d1
    41ca:	f607 8000 f5ff 	move16 (sp)+,0x8000f5ff
    41d0:	0799           	bclr d3,(a1)+
    41d2:	e800           	asr.b #4,d0
	...
    41dc:	001c 3687      	ori.b #-121,(a4)+
    41e0:	0000 007f      	ori.b #127,d0
    41e4:	0e1c 1000      	moves.b (a4)+,d1
	...
    41f0:	001c 3686      	ori.b #-122,(a4)+
    41f4:	0010 007f      	ori.b #127,(a0)
    41f8:	0e3f           	.short 0x0e3f
    41fa:	0100           	btst d0,d0
	...
    4204:	0006 190e      	ori.b #14,d6
    4208:	0000 0e3e      	ori.b #62,d0
    420c:	1802           	move.b d2,d4
    420e:	2000           	move.l d0,d0
	...
    4218:	0000 1ff0      	ori.b #-16,d0
    421c:	0000 f7e3      	ori.b #-29,d0
    4220:	ff00 4000      	cp1st.b d4,d0,#1,#0
	...
    422c:	2000           	move.l d0,d0
    422e:	cfc0           	muls.w d0,d7
    4230:	0001 c03f      	ori.b #63,d1
    4234:	fe81 0000      	cp1ld.l d1,d0,#1,#0
	...
    4240:	0800 27b0      	btst #-80,d0
    4244:	000f           	.short 0x000f
    4246:	03ff           	.short 0x03ff
    4248:	ee8c           	lsr.l #7,d4
	...
    4252:	0000 0200      	ori.b #0,d0
    4256:	1000           	move.b d0,d0
    4258:	000e           	.short 0x000e
    425a:	6fff ffb0 0000 	ble.l 0xffb0425c
	...
    4268:	0000 1000      	ori.b #0,d0
    426c:	000f           	.short 0x000f
    426e:	dfff           	.short 0xdfff
    4270:	ff60 2000      	cp1st.w d2,-(a0),#1,#0
	...
    427c:	0040 1000      	ori.w #4096,d0
    4280:	000f           	.short 0x000f
    4282:	ffff           	.short 0xffff
    4284:	ff40 0000      	cp1st.w d0,d0,#1,#0
	...
    4290:	0010 0900      	ori.b #0,(a0)
    4294:	0003 0380      	ori.b #-128,d3
    4298:	3f86 0000      	move.w d6,(0,sp,d0.w)
	...
    42a4:	0003 0800      	ori.b #0,d3
	...
    42c0:	000c           	.short 0x000c
    42c2:	2000           	move.l d0,d0
	...
    42d4:	0040 0000      	ori.w #0,d0
	...
    42e8:	0080 0000 0000 	ori.l #0,d0
	...
    42fa:	0000 0080      	ori.b #-128,d0
	...
    430e:	0000 0600      	ori.b #0,d0
	...
    4322:	0000 1000      	ori.b #0,d0
	...
    4336:	0000 c007      	ori.b #7,d0
    433a:	c000           	and.b d0,d0
	...
    4344:	0001 0000      	ori.b #0,d1
    4348:	0000 f801      	ori.b #1,d0
    434c:	0000 4000      	ori.b #0,d0
	...
    4358:	0003 4000      	ori.b #0,d3
    435c:	1fff           	.short 0x1fff
    435e:	f800 0000      	tblu.b d0,d0,d0
	...
    436a:	000c           	.short 0x000c
    436c:	01e6           	bset d0,-(a6)
    436e:	2000           	move.l d0,d0
    4370:	7fff           	.short 0x7fff
    4372:	f800 0000      	tblu.b d0,d0,d0
	...
    437e:	0001 03e6      	ori.b #-26,d1
    4382:	2003           	move.l d3,d0
    4384:	ffff           	.short 0xffff
    4386:	f800 0000      	tblu.b d0,d0,d0
	...
    4392:	0004 8e60      	ori.b #96,d4
    4396:	200f           	move.l sp,d0
    4398:	ffff           	.short 0xffff
    439a:	f804           	.short 0xf804
    439c:	27c0           	.short 0x27c0
	...
    43a6:	0000 7fc3      	ori.b #-61,d0
    43aa:	e07f           	ror.w d0,d7
    43ac:	ffff           	.short 0xffff
    43ae:	f004           	.short 0xf004
    43b0:	018c 0000      	movep.w d0,0(a4)
	...
    43bc:	7fe3           	mvz.w -(a3),d7
    43be:	e07e           	ror.w d0,d6
    43c0:	1fe1           	.short 0x1fe1
    43c2:	c000           	and.b d0,d0
    43c4:	0080 0000 0000 	ori.l #0,d0
    43ca:	0000 0000      	ori.b #0,d0
    43ce:	0008           	.short 0x0008
    43d0:	fbff           	.short 0xfbff
    43d2:	c078 000f      	and.w 0xf,d0
    43d6:	8010           	or.b (a0),d0
	...
    43e4:	73ff           	.short 0x73ff
    43e6:	c078 000f      	and.w 0xf,d0
    43ea:	c010           	and.b (a0),d0
    43ec:	1800           	move.b d0,d4
	...
    43f6:	0004 7fff      	ori.b #-1,d4
    43fa:	0078 003f c010 	ori.w #63,0xffffc010
    4400:	0680 0000 0000 	addi.l #0,d0
    4406:	0000 0000      	ori.b #0,d0
    440a:	0004 7fff      	ori.b #-1,d4
    440e:	0078 00ff c010 	ori.w #255,0xffffc010
    4414:	0680 0000 0000 	addi.l #0,d0
    441a:	0000 0000      	ori.b #0,d0
    441e:	000c           	.short 0x000c
    4420:	3fff           	.short 0x3fff
    4422:	0000 01ff      	ori.b #-1,d0
    4426:	c000           	and.b d0,d0
	...
    4430:	0000 0008      	ori.b #8,d0
    4434:	3dff           	.short 0x3dff
    4436:	0000 38ff      	ori.b #-1,d0
    443a:	c001           	and.b d1,d0
	...
    4444:	0000 0008      	ori.b #8,d0
    4448:	3a7e           	.short 0x3a7e
    444a:	0000 43ff      	ori.b #-1,d0
    444e:	c020           	and.b -(a0),d0
    4450:	07c0           	bset d3,d0
	...
    445a:	0009           	.short 0x0009
    445c:	41fe           	.short 0x41fe
    445e:	0001 ffff      	ori.b #-1,d1
    4462:	8020           	or.b -(a0),d0
    4464:	0040 0000      	ori.w #0,d0
    4468:	0000 0000      	ori.b #0,d0
    446c:	0000 0008      	ori.b #8,d0
    4470:	007c 0001      	ori.w #1,sr
    4474:	f8ff           	.short 0xf8ff
    4476:	8020           	or.b -(a0),d0
    4478:	0080 0000 0000 	ori.l #0,d0
    447e:	0000 0000      	ori.b #0,d0
    4482:	001c 0060      	ori.b #96,(a4)+
    4486:	0000 00cf      	ori.b #-49,d0
    448a:	8020           	or.b -(a0),d0
    448c:	0200 0000      	andi.b #0,d0
    4490:	0000 0000      	ori.b #0,d0
    4494:	0000 001e      	ori.b #30,d0
    4498:	0060 0000      	ori.w #0,-(a0)
    449c:	00cf           	.short 0x00cf
    449e:	8020           	or.b -(a0),d0
    44a0:	0200 0000      	andi.b #0,d0
    44a4:	0000 0000      	ori.b #0,d0
    44a8:	0000 001f      	ori.b #31,d0
    44ac:	01c0           	bset d0,d0
    44ae:	0000 011f      	ori.b #31,d0
    44b2:	8020           	or.b -(a0),d0
    44b4:	8400           	or.b d0,d2
	...
    44be:	001f c1c0      	ori.b #-64,(sp)+
    44c2:	0000 01ff      	ori.b #-1,d0
    44c6:	8000           	or.b d0,d0
    44c8:	e000           	asr.b #8,d0
	...
    44d2:	001f 8180      	ori.b #-128,(sp)+
    44d6:	0000 01ff      	ori.b #-1,d0
    44da:	8005           	or.b d5,d0
    44dc:	f000           	.short 0xf000
	...
    44e6:	0038 0180 0000 	ori.b #-128,0x0
    44ec:	003f           	.short 0x003f
    44ee:	8000           	or.b d0,d0
	...
    44f8:	0000 0030      	ori.b #48,d0
    44fc:	0180           	bclr d0,d0
    44fe:	0000 003f      	ori.b #63,d0
    4502:	8000           	or.b d0,d0
	...
    450c:	0000 0020      	ori.b #32,d0
    4510:	0380           	bclr d1,d0
    4512:	0000 00c7      	ori.b #-57,d0
    4516:	8040           	or.w d0,d0
	...
    4520:	0000 0020      	ori.b #32,d0
    4524:	0380           	bclr d1,d0
    4526:	0000 00c7      	ori.b #-57,d0
    452a:	8040           	or.w d0,d0
	...
    4534:	0000 0061      	ori.b #97,d0
    4538:	0380           	bclr d1,d0
    453a:	0000 00f9      	ori.b #-7,d0
    453e:	8040           	or.w d0,d0
	...
    4548:	0000 0041      	ori.b #65,d0
    454c:	0380           	bclr d1,d0
    454e:	0000 0011      	ori.b #17,d0
    4552:	f040           	.short 0xf040
    4554:	2000           	move.l d0,d0
	...
    455e:	0040 0180      	ori.w #384,d0
    4562:	0000 000f      	ori.b #15,d0
    4566:	0840 0000      	bchg #0,d0
	...
    4572:	0080 0180 0000 	ori.l #25165824,d0
    4578:	00c8           	.short 0x00c8
    457a:	3841           	movea.w d1,a4
	...
    4584:	0000 0080      	ori.b #-128,d0
    4588:	03c0           	bset d1,d0
    458a:	0000 00e0      	ori.b #-32,d0
    458e:	0040 0000      	ori.w #0,d0
	...
    459a:	0180           	bclr d0,d0
    459c:	03c0           	bset d1,d0
    459e:	0000 0001      	ori.b #1,d0
    45a2:	0042 0000      	ori.w #0,d2
	...
    45ae:	0100           	btst d0,d0
    45b0:	03c0           	bset d1,d0
    45b2:	0000 0001      	ori.b #1,d0
    45b6:	0042 0000      	ori.w #0,d2
	...
    45c2:	0300           	btst d1,d0
    45c4:	01c0           	bset d0,d0
    45c6:	0000 0006      	ori.b #6,d0
    45ca:	0042 0000      	ori.w #0,d2
	...
    45d6:	0200 03c0      	andi.b #-64,d0
    45da:	0000 0000      	ori.b #0,d0
    45de:	0800 0000      	btst #0,d0
	...
    45ea:	0200 03c0      	andi.b #-64,d0
    45ee:	0000 0006      	ori.b #6,d0
    45f2:	b000           	cmp.b d0,d0
	...
    45fc:	0000 0600      	ori.b #0,d0
    4600:	01e0           	bset d0,-(a0)
    4602:	0000 0001      	ori.b #1,d0
    4606:	f000           	.short 0xf000
    4608:	c000           	and.b d0,d0
	...
    4612:	0600 07e0      	addi.b #-32,d0
    4616:	0000 0001      	ori.b #1,d0
    461a:	ff80 6000      	cp1st.l d6,d0,#1,#0
	...
    4626:	0600 07e0      	addi.b #-32,d0
    462a:	02ff           	.short 0x02ff
    462c:	e001           	asr.b #8,d1
    462e:	c800           	and.b d0,d4
    4630:	3800           	move.w d0,d4
	...
    463a:	0600 07e0      	addi.b #-32,d0
    463e:	06ff           	.short 0x06ff
    4640:	f801           	.short 0xf801
    4642:	c800           	and.b d0,d4
    4644:	3800           	move.w d0,d4
	...
    464e:	0e00           	.short 0x0e00
    4650:	07f8 188f      	bset d3,0x188f
    4654:	fdc1           	.short 0xfdc1
    4656:	f180           	.short 0xf180
    4658:	0600 0000      	addi.b #0,d0
    465c:	0000 0000      	ori.b #0,d0
    4660:	0000 0a00      	ori.b #0,d0
    4664:	07f9 f1bb e027 	bset d3,0xf1bbe027
    466a:	f000           	.short 0xf000
	...
    4674:	0000 0800      	ori.b #0,d0
    4678:	07ff           	.short 0x07ff
    467a:	fe00 001f      	cp1ld.b d0,d0,#1,#31
    467e:	e000           	asr.b #8,d0
    4680:	0031 f800 0000 	ori.b #0,(0,a1,d0.w)
    4686:	0130 0000      	btst d0,(0,a0,d0.w)
    468a:	0800 07ff      	btst #-1,d0
    468e:	ff00 000f      	cp1st.b d0,d0,#1,#15
    4692:	c000           	and.b d0,d0
    4694:	003f           	.short 0x003f
    4696:	e400           	asr.b #2,d0
    4698:	0000 1870      	ori.b #112,d0
    469c:	0000 180e      	ori.b #14,d0
    46a0:	07ff           	.short 0x07ff
    46a2:	fe00 001f      	cp1ld.b d0,d0,#1,#31
    46a6:	8000           	or.b d0,d0
    46a8:	000f           	.short 0x000f
    46aa:	c100           	abcd d0,d0
    46ac:	0000 c1f0      	ori.b #-16,d0
    46b0:	0000 1006      	ori.b #6,d0
    46b4:	03ff           	.short 0x03ff
    46b6:	f780           	.short 0xf780
    46b8:	003f           	.short 0x003f
    46ba:	0000 000f      	ori.b #15,d0
    46be:	8000           	or.b d0,d0
    46c0:	0002 01f0      	ori.b #-16,d2
    46c4:	0000 3006      	ori.b #6,d0
    46c8:	03ff           	.short 0x03ff
    46ca:	f780           	.short 0xf780
    46cc:	003f           	.short 0x003f
    46ce:	0000 000f      	ori.b #15,d0
    46d2:	8020           	or.b -(a0),d0
    46d4:	0018 01f0      	ori.b #-16,(a0)+
    46d8:	0000 3808      	ori.b #8,d0
    46dc:	01ff           	.short 0x01ff
    46de:	e100           	asl.b #8,d0
    46e0:	0000 0000      	ori.b #0,d0
    46e4:	000e           	.short 0x000e
    46e6:	6100 0040      	bsr.w 0x4728
    46ea:	01f0 0000      	bset d0,(0,a0,d0.w)
    46ee:	780e           	moveq #14,d4
    46f0:	005e 0000      	ori.w #0,(a6)+
    46f4:	0000 0000      	ori.b #0,d0
    46f8:	000b           	.short 0x000b
    46fa:	fbc6           	.short 0xfbc6
    46fc:	0380           	bclr d1,d0
    46fe:	07f0 0000      	bset d3,(0,a0,d0.w)
    4702:	f006           	.short 0xf006
    4704:	0022 0000      	ori.b #0,-(a2)
    4708:	0000 0000      	ori.b #0,d0
    470c:	0000 65c0      	ori.b #-64,d0
    4710:	f840           	.short 0xf840
    4712:	07f0 0001      	bset d3,(1,a0,d0.w)
    4716:	f800 0000      	tblu.b d0,d0,d0
    471a:	0000 0000      	ori.b #0,d0
    471e:	0000 0003      	ori.b #3,d0
    4722:	fa00           	.short 0xfa00
    4724:	0000 0ff0      	ori.b #-16,d0
    4728:	0001 c000      	ori.b #0,d1
    472c:	0000 0000      	ori.b #0,d0
    4730:	0000 3000      	ori.b #0,d0
    4734:	0000 18c0      	ori.b #-64,d0
    4738:	0000 0ff0      	ori.b #-16,d0
    473c:	0003 d800      	ori.b #0,d3
    4740:	0000 0000      	ori.b #0,d0
    4744:	0000 7000      	ori.b #0,d0
    4748:	0000 0000      	ori.b #0,d0
    474c:	0000 0ff0      	ori.b #-16,d0
    4750:	0003 fc00      	ori.b #0,d3
    4754:	0000 0000      	ori.b #0,d0
    4758:	0000 7000      	ori.b #0,d0
    475c:	0000 0000      	ori.b #0,d0
    4760:	0000 0fe0      	ori.b #-32,d0
    4764:	0003 b000      	ori.b #0,d3
    4768:	0000 0000      	ori.b #0,d0
    476c:	0031 7800 0000 	ori.b #0,(0,a1,d0.w)
    4772:	0000 0000      	ori.b #0,d0
    4776:	1fe0           	.short 0x1fe0
    4778:	0003 f7c0      	ori.b #-64,d3
    477c:	0000 0000      	ori.b #0,d0
    4780:	001f c200      	ori.b #0,(sp)+
    4784:	0000 0000      	ori.b #0,d0
    4788:	0000 1fc0      	ori.b #-64,d0
    478c:	0003 bb00      	ori.b #0,d3
    4790:	0000 0000      	ori.b #0,d0
    4794:	003f           	.short 0x003f
    4796:	fdc0           	.short 0xfdc0
    4798:	0000 0000      	ori.b #0,d0
    479c:	0000 1f80      	ori.b #-128,d0
    47a0:	0007 ff00      	ori.b #0,d7
    47a4:	0000 0000      	ori.b #0,d0
    47a8:	03ff           	.short 0x03ff
    47aa:	fe40 0000      	cp1nop #1
    47ae:	0000 0000      	ori.b #0,d0
    47b2:	3f00           	move.w d0,-(sp)
    47b4:	0007 ff00      	ori.b #0,d7
    47b8:	0000 0000      	ori.b #0,d0
    47bc:	01ff           	.short 0x01ff
    47be:	ffc0           	.short 0xffc0
    47c0:	0000 0000      	ori.b #0,d0
    47c4:	001f fe00      	ori.b #0,(sp)+
    47c8:	0007 fe00      	ori.b #0,d7
    47cc:	0000 0800      	ori.b #0,d0
    47d0:	01ff           	.short 0x01ff
    47d2:	f1c0           	.short 0xf1c0
    47d4:	0000 0000      	ori.b #0,d0
    47d8:	001f fc00      	ori.b #0,(sp)+
    47dc:	0007 fe00      	ori.b #0,d7
    47e0:	0000 0800      	ori.b #0,d0
    47e4:	01ff           	.short 0x01ff
    47e6:	f1c0           	.short 0xf1c0
    47e8:	0000 0000      	ori.b #0,d0
    47ec:	003f           	.short 0x003f
    47ee:	f800 0007      	tblu.b d0,d7,d0
    47f2:	fe00 0018      	cp1ld.b d0,d0,#1,#24
    47f6:	0870 01ff f980 	bchg #-1,(0,sp.l)
    47fc:	0000 0000      	ori.b #0,d0
    4800:	007f           	.short 0x007f
    4802:	f000           	.short 0xf000
    4804:	0007 fc00      	ori.b #0,d7
    4808:	0000 1ec8      	ori.b #-56,d0
    480c:	0239 fdd8 0000 	andi.b #-40,0x0
    4812:	0000 
    4814:	01ff           	.short 0x01ff
    4816:	f000           	.short 0xf000
    4818:	0007 f800      	ori.b #0,d7
    481c:	0007 ff78      	ori.b #120,d7
    4820:	00f6           	.short 0x00f6
    4822:	b040           	cmp.w d0,d0
    4824:	0000 0000      	ori.b #0,d0
    4828:	03ff           	.short 0x03ff
    482a:	e000           	asr.b #8,d0
    482c:	0007 e000      	ori.b #0,d7
    4830:	001f fff0      	ori.b #-16,(sp)+
    4834:	01e8 c380      	bset d0,-15488(a0)
    4838:	0000 0000      	ori.b #0,d0
    483c:	03ff           	.short 0x03ff
    483e:	e000           	asr.b #8,d0
    4840:	0007 fa00      	ori.b #0,d7
    4844:	0021 efc8      	ori.b #-56,-(a1)
    4848:	002f 3c00 0000 	ori.b #0,0(sp)
    484e:	0000 07ff      	ori.b #-1,d0
    4852:	c000           	and.b d0,d0
    4854:	000f           	.short 0x000f
    4856:	ff00 001f      	cp1st.b d0,d0,#1,#31
    485a:	ffc8           	.short 0xffc8
    485c:	0210 0400      	andi.b #0,(a0)
    4860:	0000 0000      	ori.b #0,d0
    4864:	07ff           	.short 0x07ff
    4866:	c000           	and.b d0,d0
    4868:	000f           	.short 0x000f
    486a:	ff00 001f      	cp1st.b d0,d0,#1,#31
    486e:	ffc8           	.short 0xffc8
    4870:	0210 0400      	andi.b #0,(a0)
    4874:	0000 0000      	ori.b #0,d0
    4878:	07ff           	.short 0x07ff
    487a:	8000           	or.b d0,d0
    487c:	000f           	.short 0x000f
    487e:	ff00 0001      	cp1st.b d0,d0,#1,#1
    4882:	3f40 00ef      	move.w d0,239(sp)
    4886:	3c00           	move.w d0,d6
    4888:	0000 0000      	ori.b #0,d0
    488c:	0fff           	.short 0x0fff
    488e:	8000           	or.b d0,d0
    4890:	000f           	.short 0x000f
    4892:	fbc0           	.short 0xfbc0
    4894:	0001 dfb0      	ori.b #-80,d1
    4898:	002f 8000 0000 	ori.b #0,0(sp)
    489e:	0000 0fff      	ori.b #-1,d0
    48a2:	0000 000f      	ori.b #15,d0
    48a6:	ffe0           	.short 0xffe0
    48a8:	0000 0680      	ori.b #-128,d0
    48ac:	0006 0004      	ori.b #4,d6
    48b0:	0000 0000      	ori.b #0,d0
    48b4:	0fff           	.short 0x0fff
    48b6:	0000 000f      	ori.b #15,d0
    48ba:	e700           	asl.b #3,d0
    48bc:	0000 0000      	ori.b #0,d0
    48c0:	0000 001c      	ori.b #28,d0
    48c4:	0000 0000      	ori.b #0,d0
    48c8:	0fff           	.short 0x0fff
    48ca:	0000 000f      	ori.b #15,d0
    48ce:	f800 0000      	tblu.b d0,d0,d0
    48d2:	0000 0001      	ori.b #1,d0
    48d6:	001e 0000      	ori.b #0,(a6)+
    48da:	0000 1ffe      	ori.b #-2,d0
    48de:	0000 000f      	ori.b #15,d0
    48e2:	f800 0000      	tblu.b d0,d0,d0
    48e6:	0000 0007      	ori.b #7,d0
    48ea:	001b 0000      	ori.b #0,(a3)+
    48ee:	0000 1ffc      	ori.b #-4,d0
    48f2:	0000 000f      	ori.b #15,d0
    48f6:	f800 0000      	tblu.b d0,d0,d0
    48fa:	0000 0007      	ori.b #7,d0
    48fe:	0019 0000      	ori.b #0,(a1)+
    4902:	0000 3ffc      	ori.b #-4,d0
    4906:	0000 000f      	ori.b #15,d0
    490a:	fc00 0000      	cp0nop #1
    490e:	0000 0000      	ori.b #0,d0
    4912:	0008           	.short 0x0008
    4914:	8600           	or.b d0,d3
    4916:	0000 7ff8      	ori.b #-8,d0
    491a:	0000 000f      	ori.b #15,d0
    491e:	f800 0000      	tblu.b d0,d0,d0
    4922:	0000 0000      	ori.b #0,d0
    4926:	000c           	.short 0x000c
    4928:	0600 0000      	addi.b #0,d0
    492c:	fff8           	.short 0xfff8
    492e:	0000 000f      	ori.b #15,d0
    4932:	f800 0000      	tblu.b d0,d0,d0
    4936:	0000 0000      	ori.b #0,d0
    493a:	0006 0000      	ori.b #0,d6
    493e:	0007 fff0      	ori.b #-16,d7
    4942:	0000 000f      	ori.b #15,d0
    4946:	fc00 0000      	cp0nop #1
    494a:	0000 0000      	ori.b #0,d0
    494e:	0003 0000      	ori.b #0,d3
    4952:	001f ffe0      	ori.b #-32,(sp)+
    4956:	0000 000f      	ori.b #15,d0
    495a:	fe00 0000      	cp1nop #1
    495e:	0000 0000      	ori.b #0,d0
    4962:	0021 8000      	ori.b #0,-(a1)
    4966:	00df           	.short 0x00df
    4968:	ffc0           	.short 0xffc0
    496a:	0000 000f      	ori.b #15,d0
    496e:	fe00 0000      	cp1nop #1
    4972:	0000 0000      	ori.b #0,d0
    4976:	0000 c000      	ori.b #0,d0
    497a:	21bf           	.short 0x21bf
    497c:	ff80 0000      	cp1st.l d0,d0,#1,#0
    4980:	000f           	.short 0x000f
    4982:	fe00 0000      	cp1nop #1
    4986:	0000 0000      	ori.b #0,d0
    498a:	0000 6000      	ori.b #0,d0
    498e:	21ff           	.short 0x21ff
    4990:	ff00 0000      	cp1st.b d0,d0,#1,#0
    4994:	000f           	.short 0x000f
    4996:	fc00 0000      	cp0nop #1
    499a:	0000 0000      	ori.b #0,d0
    499e:	0000 3000      	ori.b #0,d0
    49a2:	5bff           	smi d7
    49a4:	fe00 0000      	cp1nop #1
    49a8:	000f           	.short 0x000f
    49aa:	f800 0000      	tblu.b d0,d0,d0
    49ae:	0000 0000      	ori.b #0,d0
    49b2:	0000 1000      	ori.b #0,d0
    49b6:	ebff           	.short 0xebff
    49b8:	fe00 0000      	cp1nop #1
    49bc:	000f           	.short 0x000f
    49be:	f800 0000      	tblu.b d0,d0,d0
    49c2:	0000 0000      	ori.b #0,d0
    49c6:	0000 c800      	ori.b #0,d0
    49ca:	e7ff           	.short 0xe7ff
    49cc:	fc00 0000      	cp0nop #1
    49d0:	000f           	.short 0x000f
    49d2:	e000           	asr.b #8,d0
	...
    49dc:	7800           	moveq #0,d4
    49de:	ffff           	.short 0xffff
    49e0:	f800 0000      	tblu.b d0,d0,d0
    49e4:	000f           	.short 0x000f
    49e6:	f800 0000      	tblu.b d0,d0,d0
    49ea:	0000 0000      	ori.b #0,d0
    49ee:	0000 0800      	ori.b #0,d0
    49f2:	ffff           	.short 0xffff
    49f4:	f000           	.short 0xf000
    49f6:	0000 0007      	ori.b #7,d0
    49fa:	f800 0000      	tblu.b d0,d0,d0
    49fe:	0000 0000      	ori.b #0,d0
    4a02:	0000 0001      	ori.b #1,d0
    4a06:	ffff           	.short 0xffff
    4a08:	e000           	asr.b #8,d0
    4a0a:	0000 0007      	ori.b #7,d0
    4a0e:	f800 0000      	tblu.b d0,d0,d0
    4a12:	0000 0000      	ori.b #0,d0
    4a16:	0000 0003      	ori.b #3,d0
    4a1a:	ffff           	.short 0xffff
    4a1c:	e000           	asr.b #8,d0
    4a1e:	0000 0007      	ori.b #7,d0
    4a22:	fc00 0000      	cp0nop #1
    4a26:	0000 0000      	ori.b #0,d0
    4a2a:	0000 0003      	ori.b #3,d0
    4a2e:	ffff           	.short 0xffff
    4a30:	c000           	and.b d0,d0
    4a32:	0000 0003      	ori.b #3,d0
    4a36:	fe00 0000      	cp1nop #1
    4a3a:	0000 0000      	ori.b #0,d0
    4a3e:	0000 0007      	ori.b #7,d0
    4a42:	ffff           	.short 0xffff
    4a44:	8000           	or.b d0,d0
    4a46:	0000 0003      	ori.b #3,d0
    4a4a:	f800 0000      	tblu.b d0,d0,d0
    4a4e:	0000 0000      	ori.b #0,d0
    4a52:	0000 000f      	ori.b #15,d0
    4a56:	ffff           	.short 0xffff
    4a58:	8000           	or.b d0,d0
    4a5a:	0000 0001      	ori.b #1,d0
    4a5e:	fe00 0020      	cp1ld.b d0,d0,#1,#32
    4a62:	0000 0000      	ori.b #0,d0
    4a66:	0000 000f      	ori.b #15,d0
    4a6a:	ffff           	.short 0xffff
    4a6c:	0000 0000      	ori.b #0,d0
    4a70:	0001 f800      	ori.b #0,d1
    4a74:	0005 0000      	ori.b #0,d5
    4a78:	0000 0000      	ori.b #0,d0
    4a7c:	000f           	.short 0x000f
    4a7e:	fffe           	.short 0xfffe
    4a80:	0000 0000      	ori.b #0,d0
    4a84:	0000 fc00      	ori.b #0,d0
    4a88:	001d 0000      	ori.b #0,(a5)+
    4a8c:	0000 0003      	ori.b #3,d0
    4a90:	c01f           	and.b (sp)+,d0
    4a92:	fffe           	.short 0xfffe
    4a94:	0000 0000      	ori.b #0,d0
    4a98:	0000 7c00      	ori.b #0,d0
    4a9c:	001d 0000      	ori.b #0,(a5)+
    4aa0:	0000 0007      	ori.b #7,d0
    4aa4:	c01f           	and.b (sp)+,d0
    4aa6:	fffc           	.short 0xfffc
    4aa8:	0000 0000      	ori.b #0,d0
    4aac:	0000 7e00      	ori.b #0,d0
    4ab0:	0005 c000      	ori.b #0,d5
    4ab4:	0000 001f      	ori.b #31,d0
    4ab8:	007f           	.short 0x007f
    4aba:	fff8           	.short 0xfff8
    4abc:	0000 0000      	ori.b #0,d0
    4ac0:	0000 3e00      	ori.b #0,d0
    4ac4:	0003 f000      	ori.b #0,d3
    4ac8:	0000 003e      	ori.b #62,d0
    4acc:	003f           	.short 0x003f
    4ace:	fff8           	.short 0xfff8
    4ad0:	0000 0000      	ori.b #0,d0
    4ad4:	0000 1f00      	ori.b #0,d0
    4ad8:	0001 e000      	ori.b #0,d1
    4adc:	0000 007c      	ori.b #124,d0
    4ae0:	30ff           	.short 0x30ff
    4ae2:	fff0           	.short 0xfff0
    4ae4:	0000 0000      	ori.b #0,d0
    4ae8:	0000 0fe0      	ori.b #-32,d0
    4aec:	0000 c000      	ori.b #0,d0
    4af0:	0000 07f8      	ori.b #-8,d0
    4af4:	3fff           	.short 0x3fff
    4af6:	fff0           	.short 0xfff0
    4af8:	0000 0000      	ori.b #0,d0
    4afc:	0000 07f8      	ori.b #-8,d0
    4b00:	0000 0000      	ori.b #0,d0
    4b04:	0000 0fe0      	ori.b #-32,d0
    4b08:	1fff           	.short 0x1fff
    4b0a:	ffe0           	.short 0xffe0
    4b0c:	0000 0000      	ori.b #0,d0
    4b10:	0000 03ff      	ori.b #-1,d0
    4b14:	8000           	or.b d0,d0
    4b16:	0000 0000      	ori.b #0,d0
    4b1a:	7fc0           	mvz.w d0,d7
    4b1c:	1fff           	.short 0x1fff
    4b1e:	ffe0           	.short 0xffe0
    4b20:	0000 0000      	ori.b #0,d0
    4b24:	0000 03ff      	ori.b #-1,d0
    4b28:	8000           	or.b d0,d0
    4b2a:	0000 0000      	ori.b #0,d0
    4b2e:	7fc0           	mvz.w d0,d7
    4b30:	1fff           	.short 0x1fff
    4b32:	ffe0           	.short 0xffe0
    4b34:	0000 0000      	ori.b #0,d0
    4b38:	0000 01ff      	ori.b #-1,d0
    4b3c:	0040 0000      	ori.w #0,d0
    4b40:	0000 7f80      	ori.b #-128,d0
    4b44:	0fff           	.short 0x0fff
    4b46:	ffe0           	.short 0xffe0
    4b48:	0000 0000      	ori.b #0,d0
    4b4c:	0000 00ff      	ori.b #-1,d0
    4b50:	c024           	and.b -(a4),d0
    4b52:	0000 0001      	ori.b #1,d0
    4b56:	7e00           	moveq #0,d7
    4b58:	0fff           	.short 0x0fff
    4b5a:	ffc0           	.short 0xffc0
    4b5c:	0000 0000      	ori.b #0,d0
    4b60:	0000 007f      	ori.b #127,d0
    4b64:	f000           	.short 0xf000
    4b66:	0000 0001      	ori.b #1,d0
    4b6a:	fe00 07ff      	cp1ld.b d0,d0,#4,#511
    4b6e:	ffc0           	.short 0xffc0
    4b70:	0000 0000      	ori.b #0,d0
    4b74:	0000 003f      	ori.b #63,d0
    4b78:	f000           	.short 0xf000
    4b7a:	0000 0008      	ori.b #8,d0
    4b7e:	fc00 01ff      	cp0ld.b d0,d0,#1,#511
    4b82:	ffc0           	.short 0xffc0
    4b84:	0000 0000      	ori.b #0,d0
    4b88:	0000 001f      	ori.b #31,d0
    4b8c:	fc00 0800      	cp0nop #5
    4b90:	0000 b800      	ori.b #0,d0
    4b94:	00ff           	.short 0x00ff
    4b96:	ffc0           	.short 0xffc0
    4b98:	0000 0000      	ori.b #0,d0
    4b9c:	0000 000f      	ori.b #15,d0
    4ba0:	ffc0           	.short 0xffc0
    4ba2:	3e00           	move.w d0,d7
    4ba4:	0001 f000      	ori.b #0,d1
    4ba8:	007f           	.short 0x007f
    4baa:	ffc0           	.short 0xffc0
    4bac:	0000 0000      	ori.b #0,d0
    4bb0:	0000 000f      	ori.b #15,d0
    4bb4:	ffc0           	.short 0xffc0
    4bb6:	3e00           	move.w d0,d7
    4bb8:	0001 f000      	ori.b #0,d1
    4bbc:	007f           	.short 0x007f
    4bbe:	ffc0           	.short 0xffc0
    4bc0:	0000 0000      	ori.b #0,d0
    4bc4:	0000 000f      	ori.b #15,d0
    4bc8:	ffc0           	.short 0xffc0
    4bca:	1f00           	move.b d0,-(sp)
    4bcc:	0006 c000      	ori.b #0,d6
    4bd0:	007f           	.short 0x007f
    4bd2:	ffc0           	.short 0xffc0
    4bd4:	0000 0000      	ori.b #0,d0
    4bd8:	0000 001f      	ori.b #31,d0
    4bdc:	ffe0           	.short 0xffe0
    4bde:	0180           	bclr d0,d0
    4be0:	0006 8000      	ori.b #0,d6
    4be4:	007f           	.short 0x007f
    4be6:	ffe0           	.short 0xffe0
    4be8:	0000 0000      	ori.b #0,d0
    4bec:	0300           	btst d1,d0
    4bee:	003f           	.short 0x003f
    4bf0:	fff8           	.short 0xfff8
    4bf2:	0000 0001      	ori.b #1,d0
    4bf6:	8000           	or.b d0,d0
    4bf8:	007f           	.short 0x007f
    4bfa:	ffe0           	.short 0xffe0
    4bfc:	0000 0000      	ori.b #0,d0
    4c00:	0600 00ff      	addi.b #-1,d0
    4c04:	fffc           	.short 0xfffc
    4c06:	0000 0001      	ori.b #1,d0
    4c0a:	0000 003f      	ori.b #63,d0
    4c0e:	ffe0           	.short 0xffe0
    4c10:	0000 0000      	ori.b #0,d0
    4c14:	0640 0107      	addi.w #263,d0
    4c18:	fffe           	.short 0xfffe
    4c1a:	0000 00c6      	ori.b #-58,d0
    4c1e:	0000 000f      	ori.b #15,d0
    4c22:	ffe0           	.short 0xffe0
    4c24:	0000 0000      	ori.b #0,d0
    4c28:	0640 0211      	addi.w #529,d0
    4c2c:	ffff           	.short 0xffff
    4c2e:	f030           	.short 0xf030
    4c30:	0000 0000      	ori.b #0,d0
    4c34:	0007 fff0      	ori.b #-16,d7
    4c38:	0000 0000      	ori.b #0,d0
    4c3c:	0640 0011      	addi.w #17,d0
    4c40:	ffff           	.short 0xffff
    4c42:	f030           	.short 0xf030
    4c44:	0000 0000      	ori.b #0,d0
    4c48:	0007 fff0      	ori.b #-16,d7
    4c4c:	0000 0000      	ori.b #0,d0
    4c50:	0640 0400      	addi.w #1024,d0
    4c54:	ffff           	.short 0xffff
    4c56:	f880           	.short 0xf880
    4c58:	02f0 0000 0007 	cmp2.w (7,a0,d0.w),d0
    4c5e:	fff0           	.short 0xfff0
    4c60:	0000 0000      	ori.b #0,d0
    4c64:	0600 0c00      	addi.b #0,d0
    4c68:	7fff           	.short 0x7fff
    4c6a:	ffc4           	.short 0xffc4
    4c6c:	03e0           	bset d1,-(a0)
    4c6e:	0000 0003      	ori.b #3,d0
    4c72:	fffe           	.short 0xfffe
    4c74:	c000           	and.b d0,d0
    4c76:	0000 0320      	ori.b #32,d0
    4c7a:	1c00           	move.b d0,d6
    4c7c:	0fff           	.short 0x0fff
    4c7e:	fffe           	.short 0xfffe
    4c80:	07e0           	bset d3,-(a0)
    4c82:	0000 0001      	ori.b #1,d0
    4c86:	ffe1           	.short 0xffe1
    4c88:	c000           	and.b d0,d0
    4c8a:	0000 03a0      	ori.b #-96,d0
    4c8e:	3c00           	move.w d0,d6
    4c90:	01ff           	.short 0x01ff
    4c92:	ffff           	.short 0xffff
    4c94:	ffc0           	.short 0xffc0
    4c96:	0000 0600      	ori.b #0,d0
    4c9a:	3fc0           	.short 0x3fc0
    4c9c:	c000           	and.b d0,d0
    4c9e:	0000 03e0      	ori.b #-32,d0
    4ca2:	3e00           	move.w d0,d7
    4ca4:	007f           	.short 0x007f
    4ca6:	ffff           	.short 0xffff
    4ca8:	ffc0           	.short 0xffc0
    4caa:	0000 0f00      	ori.b #0,d0
    4cae:	0500           	btst d2,d0
    4cb0:	c000           	and.b d0,d0
    4cb2:	0000 03f0      	ori.b #-16,d0
    4cb6:	7f00           	mvs.b d0,d7
    4cb8:	007f           	.short 0x007f
    4cba:	ffff           	.short 0xffff
    4cbc:	ffc0           	.short 0xffc0
    4cbe:	0000 3f00      	ori.b #0,d0
    4cc2:	3e00           	move.w d0,d7
    4cc4:	8000           	or.b d0,d0
    4cc6:	0000 01f8      	ori.b #-8,d0
    4cca:	7f00           	mvs.b d0,d7
    4ccc:	007f           	.short 0x007f
    4cce:	ffff           	.short 0xffff
    4cd0:	ffc0           	.short 0xffc0
    4cd2:	0000 3f00      	ori.b #0,d0
    4cd6:	3e00           	move.w d0,d7
    4cd8:	8000           	or.b d0,d0
    4cda:	0000 01fc      	ori.b #-4,d0
    4cde:	7fc0           	mvz.w d0,d7
    4ce0:	01c3           	bset d0,d3
    4ce2:	ffff           	.short 0xffff
    4ce4:	ffc0           	.short 0xffc0
    4ce6:	0000 0f00      	ori.b #0,d0
    4cea:	0101           	btst d0,d1
    4cec:	0000 0000      	ori.b #0,d0
    4cf0:	01ff           	.short 0x01ff
    4cf2:	ffe0           	.short 0xffe0
    4cf4:	09e1           	bset d4,-(a1)
    4cf6:	ffff           	.short 0xffff
    4cf8:	fec0 0000      	cp1bcbusy 0x4cfa
    4cfc:	0f00           	btst d7,d0
    4cfe:	0201 0000      	andi.b #0,d1
    4d02:	0000 00ff      	ori.b #-1,d0
    4d06:	fff0           	.short 0xfff0
    4d08:	0180           	bclr d0,d0
    4d0a:	3fff           	.short 0x3fff
    4d0c:	fd00 0000      	cp0st.b d0,d0,#1,#0
    4d10:	0700           	btst d3,d0
    4d12:	0400 0000      	subi.b #0,d0
    4d16:	0000 00ff      	ori.b #-1,d0
    4d1a:	fffe           	.short 0xfffe
    4d1c:	05c0           	bset d2,d0
    4d1e:	1fff           	.short 0x1fff
    4d20:	fd07 0000      	cp0st.b d0,d7,#1,#0
    4d24:	2000           	move.l d0,d0
    4d26:	0002 0000      	ori.b #0,d2
    4d2a:	0000 007f      	ori.b #127,d0
    4d2e:	ffff           	.short 0xffff
    4d30:	87a0           	or.l d3,-(a0)
    4d32:	37ff           	.short 0x37ff
    4d34:	fe0f 8040      	cp1ld.b sp,a0,#1,#64
	...
    4d40:	003f           	.short 0x003f
    4d42:	ffff           	.short 0xffff
    4d44:	fc38           	.short 0xfc38
    4d46:	1fff           	.short 0x1fff
    4d48:	fe0f 0a7c      	cp1ld.b sp,d0,#6,#124
    4d4c:	0000 0004      	ori.b #4,d0
    4d50:	0000 0000      	ori.b #0,d0
    4d54:	001f ffff      	ori.b #-1,(sp)+
    4d58:	fc38           	.short 0xfc38
    4d5a:	1fff           	.short 0x1fff
    4d5c:	fe0f 0a7c      	cp1ld.b sp,d0,#6,#124
	...
    4d68:	000f           	.short 0x000f
    4d6a:	ffff           	.short 0xffff
    4d6c:	fe00 29ff      	cp1ld.b d0,d2,#5,#511
    4d70:	ff20 3fc0      	cp1st.b d3,-(a0),#8,#448
    4d74:	0000 0008      	ori.b #8,d0
    4d78:	0000 0000      	ori.b #0,d0
    4d7c:	0003 ffff      	ori.b #-1,d3
    4d80:	fe00 07cf      	cp1ld.b d0,d0,#4,#463
    4d84:	fe10 f800      	cp1ld.b (a0),sp,#5,#0
	...
    4d90:	0001 ffff      	ori.b #-1,d1
    4d94:	ff80 01ff      	cp1st.l d0,d0,#1,#511
    4d98:	c008           	.short 0xc008
    4d9a:	f000           	.short 0xf000
    4d9c:	0000 0010      	ori.b #16,d0
    4da0:	0000 0000      	ori.b #0,d0
    4da4:	0000 7fff      	ori.b #-1,d0
    4da8:	ff80 018f      	cp1st.l d0,d0,#1,#399
    4dac:	c2ef 0000      	mulu.w 0(sp),d1
	...
    4db8:	0000 3fff      	ori.b #-1,d0
    4dbc:	ffc0           	.short 0xffc0
    4dbe:	0007 e2fe      	ori.b #-2,d7
    4dc2:	0000 0000      	ori.b #0,d0
    4dc6:	0020 0000      	ori.b #0,-(a0)
    4dca:	0000 0000      	ori.b #0,d0
    4dce:	0fff           	.short 0x0fff
    4dd0:	ffe0           	.short 0xffe0
    4dd2:	0003 e3f0      	ori.b #-16,d3
	...
    4de2:	07ff           	.short 0x07ff
    4de4:	ffe0           	.short 0xffe0
    4de6:	0003 e1f0      	ori.b #-16,d3
    4dea:	0000 0000      	ori.b #0,d0
    4dee:	0040 0000      	ori.w #0,d0
    4df2:	0000 0000      	ori.b #0,d0
    4df6:	03ff           	.short 0x03ff
    4df8:	fff8           	.short 0xfff8
    4dfa:	0001 e1f0      	ori.b #-16,d1
    4dfe:	0000 06c0      	ori.b #-64,d0
    4e02:	00c0           	bitrev d0
    4e04:	0000 0000      	ori.b #0,d0
    4e08:	0000 00ff      	ori.b #-1,d0
    4e0c:	ffe4           	.short 0xffe4
    4e0e:	0000 60e0      	ori.b #-32,d0
    4e12:	0000 3fb4      	ori.b #-76,d0
    4e16:	0180           	bclr d0,d0
    4e18:	0000 0000      	ori.b #0,d0
    4e1c:	0000 007f      	ori.b #127,d0
    4e20:	fffc           	.short 0xfffc
    4e22:	0000 60f8      	ori.b #-8,d0
    4e26:	0000 fffd      	ori.b #-3,d0
    4e2a:	8380 0000      	unpk d0,d1,#0
    4e2e:	0000 0000      	ori.b #0,d0
    4e32:	001f fffe      	ori.b #-2,(sp)+
    4e36:	0000 607e      	ori.b #126,d0
    4e3a:	881c           	or.b (a4)+,d4
    4e3c:	ffc0           	.short 0xffc0
    4e3e:	0780           	bclr d3,d0
    4e40:	0000 0000      	ori.b #0,d0
    4e44:	0000 000f      	ori.b #15,d0
    4e48:	fffe           	.short 0xfffe
    4e4a:	0000 403f      	ori.b #63,d0
    4e4e:	0a00 f818      	eori.b #24,d0
    4e52:	0700           	btst d3,d0
    4e54:	0000 0000      	ori.b #0,d0
    4e58:	0000 0003      	ori.b #3,d0
    4e5c:	ffff           	.short 0xffff
    4e5e:	c000           	and.b d0,d0
    4e60:	801f           	or.b (sp)+,d0
    4e62:	ff80 f01c      	cp1st.l sp,d0,#1,#28
    4e66:	0f00           	btst d7,d0
    4e68:	0000 0000      	ori.b #0,d0
    4e6c:	0000 0001      	ori.b #1,d0
    4e70:	ffff           	.short 0xffff
    4e72:	c001           	and.b d1,d0
    4e74:	001f ff80      	ori.b #-128,(sp)+
    4e78:	f03f           	.short 0xf03f
    4e7a:	1f00           	move.b d0,-(sp)
	...
    4e84:	ffff           	.short 0xffff
    4e86:	e000           	asr.b #8,d0
    4e88:	000f           	.short 0x000f
    4e8a:	f001           	.short 0xf001
    4e8c:	e002           	asr.b #8,d2
    4e8e:	1e00           	move.b d0,d7
	...
    4e98:	7fff           	.short 0x7fff
    4e9a:	e00c           	lsr.b #8,d4
    4e9c:	0007 07e0      	ori.b #-32,d7
    4ea0:	0000 3e00      	ori.b #0,d0
	...
    4eac:	3fff           	.short 0x3fff
    4eae:	f038           	.short 0xf038
    4eb0:	0006 0000      	ori.b #0,d6
    4eb4:	0000 fc00      	ori.b #0,d0
	...
    4ec0:	0fff           	.short 0x0fff
    4ec2:	f870           	.short 0xf870
    4ec4:	0010 0000      	ori.b #0,(a0)
    4ec8:	0003 f800      	ori.b #0,d3
	...
    4ed4:	03ff           	.short 0x03ff
    4ed6:	ff80 0010      	cp1st.l d0,d0,#1,#16
    4eda:	0000 000f      	ori.b #15,d0
    4ede:	f000           	.short 0xf000
	...
    4ee8:	00ff           	.short 0x00ff
    4eea:	ff00 0000      	cp1st.b d0,d0,#1,#0
    4eee:	0000 001f      	ori.b #31,d0
    4ef2:	e000           	asr.b #8,d0
	...
    4efc:	007f           	.short 0x007f
    4efe:	ff00 0008      	cp1st.b d0,d0,#1,#8
    4f02:	0000 003f      	ori.b #63,d0
    4f06:	8000           	or.b d0,d0
	...
    4f10:	001f ff00      	ori.b #0,(sp)+
    4f14:	0004 f3ff      	ori.b #-1,d4
    4f18:	c07e           	.short 0xc07e
	...
    4f22:	0000 0003      	ori.b #3,d0
    4f26:	f800 0000      	tblu.b d0,d0,d0
	...
    4f52:	0000 5800      	ori.b #0,d0
	...
    4f66:	0000 7800      	ori.b #0,d0
	...
    4f7a:	0001 9800      	ori.b #0,d1
	...
    4f8e:	0003 1800      	ori.b #0,d3
	...
    4f9e:	003c 0000      	ori.b #0,ccr
    4fa2:	0006 1800      	ori.b #0,d6
	...
    4fb2:	0016 8002      	ori.b #2,(a6)
    4fb6:	000c           	.short 0x000c
    4fb8:	1800           	move.b d0,d4
	...
    4fc6:	0001 e002      	ori.b #2,d1
    4fca:	0018 1800      	ori.b #0,(a0)+
	...
    4fda:	0000 6037      	ori.b #55,d0
    4fde:	f9b0           	.short 0xf9b0
    4fe0:	1800           	move.b d0,d4
	...
    4fee:	0000 6003      	ori.b #3,d0
    4ff2:	f9e0           	.short 0xf9e0
    4ff4:	1800           	move.b d0,d4
	...
    5002:	0007 e02e      	ori.b #46,d7
    5006:	0000 1800      	ori.b #0,d0
	...
    5016:	0000 5419      	ori.b #25,d0
    501a:	0060 1800      	ori.w #6144,-(a0)
	...
    502a:	0000 0519      	ori.b #25,d0
    502e:	8040           	or.w d0,d0
    5030:	1800           	move.b d0,d4
	...
    503e:	0000 0398      	ori.b #-104,d0
    5042:	8040           	or.w d0,d0
    5044:	1800           	move.b d0,d4
	...
    5052:	0000 01f8      	ori.b #-8,d0
    5056:	c040           	and.w d0,d0
    5058:	1800           	move.b d0,d4
	...
    5066:	0020 00f8      	ori.b #-8,-(a0)
    506a:	41fe           	.short 0x41fe
    506c:	d800           	add.b d0,d4
	...
    507a:	0000 00d8      	ori.b #-40,d0
    507e:	e78b           	lsl.l #3,d3
    5080:	fc00 0000      	cp0nop #1
	...
    508c:	0000 0010      	ori.b #16,d0
    5090:	03dc           	bset d1,(a4)+
    5092:	7e20           	moveq #32,d7
    5094:	2c00           	move.l d0,d6
	...
    509e:	000f           	.short 0x000f
    50a0:	0000 0000      	ori.b #0,d0
    50a4:	0e80           	.short 0x0e80
    50a6:	7860           	moveq #96,d4
	...
    50b0:	0000 000f      	ori.b #15,d0
    50b4:	8000           	or.b d0,d0
    50b6:	0001 fa00      	ori.b #0,d1
    50ba:	2018           	move.l (a0)+,d0
    50bc:	0800 0000      	btst #0,d0
    50c0:	0000 0000      	ori.b #0,d0
    50c4:	0000 000f      	ori.b #15,d0
    50c8:	c000           	and.b d0,d0
    50ca:	0002 d000      	ori.b #0,d2
    50ce:	000d           	.short 0x000d
    50d0:	4000           	negx.b d0
	...
    50da:	000f           	.short 0x000f
    50dc:	e000           	asr.b #8,d0
    50de:	0000 0017      	ori.b #23,d0
    50e2:	0008           	.short 0x0008
	...
    50ec:	0000 000f      	ori.b #15,d0
    50f0:	f000           	.short 0xf000
    50f2:	0000 001f      	ori.b #31,d0
    50f6:	0002 4000      	ori.b #0,d2
	...
    5102:	000f           	.short 0x000f
    5104:	f800 0000      	tblu.b d0,d0,d0
    5108:	00ff           	.short 0x00ff
	...
    5116:	000f           	.short 0x000f
    5118:	fc00 0000      	cp0nop #1
    511c:	00ff           	.short 0x00ff
	...
    512a:	000f           	.short 0x000f
    512c:	fe00 0000      	cp1nop #1
    5130:	07ff           	.short 0x07ff
	...
    513e:	000f           	.short 0x000f
    5140:	ff80 0000      	cp1st.l d0,d0,#1,#0
    5144:	1fff           	.short 0x1fff
	...
    5152:	000f           	.short 0x000f
    5154:	ff80 0000      	cp1st.l d0,d0,#1,#0
    5158:	7fff           	.short 0x7fff
	...
    5166:	000f           	.short 0x000f
    5168:	ffe0           	.short 0xffe0
    516a:	0001 ffff      	ori.b #-1,d1
    516e:	0000 0000      	ori.b #0,d0
    5172:	0000 001e      	ori.b #30,d0
    5176:	0000 0000      	ori.b #0,d0
    517a:	000f           	.short 0x000f
    517c:	fff8           	.short 0xfff8
    517e:	000b           	.short 0x000b
    5180:	ffff           	.short 0xffff
    5182:	0000 0000      	ori.b #0,d0
    5186:	0000 003e      	ori.b #62,d0
    518a:	0000 0000      	ori.b #0,d0
    518e:	000f           	.short 0x000f
    5190:	fff8           	.short 0xfff8
    5192:	009f ffff 0000 	ori.l #-65536,(sp)+
    5198:	0000 0000      	ori.b #0,d0
    519c:	00fe           	.short 0x00fe
    519e:	0000 0000      	ori.b #0,d0
    51a2:	000f           	.short 0x000f
    51a4:	ffff           	.short 0xffff
    51a6:	03ff           	.short 0x03ff
    51a8:	ffff           	.short 0xffff
    51aa:	0000 0000      	ori.b #0,d0
    51ae:	0000 03fe      	ori.b #-2,d0
    51b2:	0000 0000      	ori.b #0,d0
    51b6:	0007 ffff      	ori.b #-1,d7
    51ba:	03ff           	.short 0x03ff
    51bc:	ffff           	.short 0xffff
    51be:	0000 0000      	ori.b #0,d0
    51c2:	0000 0ffe      	ori.b #-2,d0
    51c6:	0000 0000      	ori.b #0,d0
    51ca:	0003 ffff      	ori.b #-1,d3
    51ce:	c3ff           	.short 0xc3ff
    51d0:	ffff           	.short 0xffff
    51d2:	0000 0000      	ori.b #0,d0
    51d6:	0000 0ffe      	ori.b #-2,d0
    51da:	0000 0000      	ori.b #0,d0
    51de:	0003 ffff      	ori.b #-1,d3
    51e2:	f3ff           	.short 0xf3ff
    51e4:	ffff           	.short 0xffff
    51e6:	9800           	sub.b d0,d4
    51e8:	0000 0000      	ori.b #0,d0
    51ec:	7ffe           	.short 0x7ffe
    51ee:	0000 0000      	ori.b #0,d0
    51f2:	0000 ffff      	ori.b #-1,d0
    51f6:	f3ff           	.short 0xf3ff
    51f8:	ffff           	.short 0xffff
    51fa:	ffff           	.short 0xffff
    51fc:	9800           	sub.b d0,d4
    51fe:	0000 7ffe      	ori.b #-2,d0
    5202:	0000 0000      	ori.b #0,d0
    5206:	0001 ffff      	ori.b #-1,d1
    520a:	ffff           	.short 0xffff
    520c:	ffff           	.short 0xffff
    520e:	ffff           	.short 0xffff
    5210:	ff98 0003      	cp1st.l d0,(a0)+,#1,#3
    5214:	fffe           	.short 0xfffe
    5216:	0000 0000      	ori.b #0,d0
    521a:	0000 ffff      	ori.b #-1,d0
    521e:	ffff           	.short 0xffff
    5220:	ffff           	.short 0xffff
    5222:	ffff           	.short 0xffff
    5224:	fffc           	.short 0xfffc
    5226:	0003 fffe      	ori.b #-2,d3
    522a:	0000 000e      	ori.b #14,d0
    522e:	0000 ffff      	ori.b #-1,d0
    5232:	ffff           	.short 0xffff
    5234:	ffff           	.short 0xffff
    5236:	ffff           	.short 0xffff
    5238:	fffc           	.short 0xfffc
    523a:	0007 fffe      	ori.b #-2,d7
    523e:	0000 000e      	ori.b #14,d0
    5242:	0000 7fff      	ori.b #-1,d0
    5246:	ffff           	.short 0xffff
    5248:	ffff           	.short 0xffff
    524a:	ffff           	.short 0xffff
    524c:	fffc           	.short 0xfffc
    524e:	001f fffe      	ori.b #-2,(sp)+
    5252:	0000 000f      	ori.b #15,d0
    5256:	0000 3fff      	ori.b #-1,d0
    525a:	ffff           	.short 0xffff
    525c:	ffff           	.short 0xffff
    525e:	ffff           	.short 0xffff
    5260:	fffc           	.short 0xfffc
    5262:	003f           	.short 0x003f
    5264:	fffe           	.short 0xfffe
    5266:	0000 000f      	ori.b #15,d0
    526a:	0000 7fff      	ori.b #-1,d0
    526e:	ffff           	.short 0xffff
    5270:	ffff           	.short 0xffff
    5272:	ffff           	.short 0xffff
    5274:	fffc           	.short 0xfffc
    5276:	007f           	.short 0x007f
    5278:	fffe           	.short 0xfffe
    527a:	0e00           	.short 0x0e00
    527c:	000e           	.short 0x000e
    527e:	0000 3f3f      	ori.b #63,d0
    5282:	ffff           	.short 0xffff
    5284:	ffff           	.short 0xffff
    5286:	ffff           	.short 0xffff
    5288:	fffc           	.short 0xfffc
    528a:	00ff           	.short 0x00ff
    528c:	fffe           	.short 0xfffe
    528e:	1e00           	move.b d0,d7
    5290:	000e           	.short 0x000e
    5292:	0000 1f9f      	ori.b #-97,d0
    5296:	ffff           	.short 0xffff
    5298:	ffff           	.short 0xffff
    529a:	ffff           	.short 0xffff
    529c:	fffc           	.short 0xfffc
    529e:	01ff           	.short 0x01ff
    52a0:	fffe           	.short 0xfffe
    52a2:	3e00           	move.w d0,d7
    52a4:	000f           	.short 0x000f
    52a6:	0000 3fc7      	ori.b #-57,d0
    52aa:	ffff           	.short 0xffff
    52ac:	ffff           	.short 0xffff
    52ae:	ffff           	.short 0xffff
    52b0:	fffc           	.short 0xfffc
    52b2:	03ff           	.short 0x03ff
    52b4:	fffe           	.short 0xfffe
    52b6:	7e00           	moveq #0,d7
    52b8:	000f           	.short 0x000f
    52ba:	8000           	or.b d0,d0
    52bc:	1fc7           	.short 0x1fc7
    52be:	ffff           	.short 0xffff
    52c0:	ffff           	.short 0xffff
    52c2:	ffff           	.short 0xffff
    52c4:	fffc           	.short 0xfffc
    52c6:	07ff           	.short 0x07ff
    52c8:	fffd           	.short 0xfffd
    52ca:	fe00 000f      	cp1ld.b d0,d0,#1,#15
    52ce:	0000 0fe1      	ori.b #-31,d0
    52d2:	ffff           	.short 0xffff
    52d4:	ffff           	.short 0xffff
    52d6:	ffff           	.short 0xffff
    52d8:	fffc           	.short 0xfffc
    52da:	0fff           	.short 0x0fff
    52dc:	fff9           	.short 0xfff9
    52de:	fe00 000f      	cp1ld.b d0,d0,#1,#15
    52e2:	8000           	or.b d0,d0
    52e4:	1fc0           	.short 0x1fc0
    52e6:	7fff           	.short 0x7fff
    52e8:	833f           	.short 0x833f
    52ea:	ffff           	.short 0xffff
    52ec:	fffc           	.short 0xfffc
    52ee:	0fff           	.short 0x0fff
    52f0:	ffff           	.short 0xffff
    52f2:	fe00 000f      	cp1ld.b d0,d0,#1,#15
    52f6:	c000           	and.b d0,d0
    52f8:	0fe0           	bset d7,-(a0)
    52fa:	7fff           	.short 0x7fff
    52fc:	800f           	.short 0x800f
    52fe:	67ff ffec 3fff 	beq.l 0xffec92ff
    5304:	ffff           	.short 0xffff
    5306:	fe00 000f      	cp1ld.b d0,d0,#1,#15
    530a:	8000           	or.b d0,d0
    530c:	07f0 1fff c00f 	([,-2342913)bset d3,([-1072758529],-2342913)
    5312:	00ff ffdc 3fff 
    5318:	dfff           	.short 0xdfff
    531a:	fe00 000f      	cp1ld.b d0,d0,#1,#15
    531e:	c000           	and.b d0,d0
    5320:	0fe0           	bset d7,-(a0)
    5322:	0fff           	.short 0x0fff
    5324:	e00f           	lsr.b #8,d7
    5326:	00ff           	.short 0x00ff
    5328:	ff8c 3fff      	cp1st.l d3,a4,#8,#511
    532c:	9fff           	.short 0x9fff
    532e:	fe00 000f      	cp1ld.b d0,d0,#1,#15
    5332:	e000           	asr.b #8,d0
    5334:	07f0 03ff e00f 	([,-13041665)bset d3,([-535887617],-13041665)
    533a:	00ff ff38 ffff 
    5340:	1fff           	.short 0x1fff
    5342:	fe00 0007      	cp1ld.b d0,d0,#1,#7
    5346:	c000           	and.b d0,d0
    5348:	03f8 03ff      	bset d1,0x3ff
    534c:	f00f           	.short 0xf00f
    534e:	00ff           	.short 0x00ff
    5350:	ff10 7ffe      	cp1st.b d7,(a0),#8,#510
    5354:	3fff           	.short 0x3fff
    5356:	fe00 0007      	cp1ld.b d0,d0,#1,#7
    535a:	e000           	asr.b #8,d0
    535c:	07f0 01ff f00f 	([,-37617668)bset d3,([-267452289],-37617668)
    5362:	007f fdc1 fffc 
    5368:	1fff           	.short 0x1fff
    536a:	fe00 000f      	cp1ld.b d0,d0,#1,#15
    536e:	e000           	asr.b #8,d0
    5370:	03f8 007f      	bset d1,0x7f
    5374:	f80f           	.short 0xf80f
    5376:	007f           	.short 0x007f
    5378:	ffc0           	.short 0xffc0
    537a:	fff8           	.short 0xfff8
    537c:	7fff           	.short 0x7fff
    537e:	fe00 000f      	cp1ld.b d0,d0,#1,#15
    5382:	f000           	.short 0xf000
    5384:	01fc           	.short 0x01fc
    5386:	003f           	.short 0x003f
    5388:	f80f           	.short 0xf80f
    538a:	00ff           	.short 0x00ff
    538c:	ff03 fff0      	cp1st.b sp,d3,#8,#496
    5390:	7fff           	.short 0x7fff
    5392:	fe00 0007      	cp1ld.b d0,d0,#1,#7
    5396:	f000           	.short 0xf000
    5398:	03f8 001f      	bset d1,0x1f
    539c:	fc0f 807f      	cp0ld.b sp,a0,#1,#127
    53a0:	fe01 ffe0      	cp1ld.b d1,sp,#8,#480
    53a4:	ffff           	.short 0xffff
    53a6:	fe00 0007      	cp1ld.b d0,d0,#1,#7
    53aa:	f800           	.short 0xf800
    53ac:	01fc           	.short 0x01fc
    53ae:	000f           	.short 0x000f
    53b0:	fe0f 803f      	cp1ld.b sp,a0,#1,#63
    53b4:	fc03 7fc1      	cp0ld.b d3,d7,#8,#449
    53b8:	ffff           	.short 0xffff
    53ba:	fe00 0007      	cp1ld.b d0,d0,#1,#7
    53be:	f800           	.short 0xf800
    53c0:	00fe           	.short 0x00fe
    53c2:	0007 fc0f      	ori.b #15,d7
    53c6:	807f           	.short 0x807f
    53c8:	f007           	.short 0xf007
    53ca:	ff81 ffff      	cp1st.l sp,d1,#8,#511
    53ce:	fe00 0003      	cp1ld.b d0,d0,#1,#3
    53d2:	fc00 01fc      	cp0ld.b d0,d0,#1,#508
    53d6:	0007 fe0f      	ori.b #15,d7
    53da:	003f           	.short 0x003f
    53dc:	d006           	add.b d6,d0
    53de:	ff01 ffff      	cp1st.b sp,d1,#8,#511
    53e2:	f800 0003      	tblu.b d0,d3,d0
    53e6:	fc00 00fe      	cp0ld.b d0,d0,#1,#254
    53ea:	0001 ff0f      	ori.b #15,d1
    53ee:	003c 8000      	ori.b #0,ccr
    53f2:	fe01 ffff      	cp1ld.b d1,sp,#8,#511
    53f6:	e000           	asr.b #8,d0
    53f8:	0007 fe00      	ori.b #0,d7
    53fc:	007f           	.short 0x007f
    53fe:	0001 ff0f      	ori.b #15,d1
    5402:	0000 0000      	ori.b #0,d0
    5406:	fc01 ffff      	cp0ld.b d1,sp,#8,#511
    540a:	8000           	or.b d0,d0
    540c:	0007 ff00      	ori.b #0,d7
    5410:	00fe           	.short 0x00fe
    5412:	0001 fe0f      	ori.b #15,d1
    5416:	8000           	or.b d0,d0
    5418:	0005 f801      	ori.b #1,d5
    541c:	fffe           	.short 0xfffe
    541e:	0000 0003      	ori.b #3,d0
    5422:	ff00 007f      	cp1st.b d0,d0,#1,#127
    5426:	0000 7f0f      	ori.b #15,d0
    542a:	8000           	or.b d0,d0
    542c:	0007 f001      	ori.b #1,d7
    5430:	fff8           	.short 0xfff8
    5432:	0000 0003      	ori.b #3,d0
    5436:	ff80 003f      	cp1st.l d0,d0,#1,#63
    543a:	8000           	or.b d0,d0
    543c:	ff0f 8000      	cp1st.b a0,sp,#1,#0
    5440:	0005 f001      	ori.b #1,d5
    5444:	ffe0           	.short 0xffe0
    5446:	0000 0001      	ori.b #1,d0
    544a:	ff00 007f      	cp1st.b d0,d0,#1,#127
    544e:	8000           	or.b d0,d0
    5450:	3f0f           	move.w sp,-(sp)
    5452:	c000           	and.b d0,d0
    5454:	0007 f801      	ori.b #1,d7
    5458:	ff80 0000      	cp1st.l d0,d0,#1,#0
    545c:	0001 ff80      	ori.b #-128,d1
    5460:	003f           	.short 0x003f
    5462:	c000           	and.b d0,d0
    5464:	7f0f           	mvs.b sp,d7
    5466:	c000           	and.b d0,d0
    5468:	0007 fe01      	ori.b #1,d7
    546c:	fe00 0000      	cp1nop #1
    5470:	0003 ff80      	ori.b #-128,d3
    5474:	001f c000      	ori.b #0,(sp)+
    5478:	1f0f           	.short 0x1f0f
    547a:	c000           	and.b d0,d0
    547c:	0007 ff81      	ori.b #-127,d7
    5480:	f800 0000      	tblu.b d0,d0,d0
    5484:	0003 ffc0      	ori.b #-64,d3
    5488:	003f           	.short 0x003f
    548a:	e000           	asr.b #8,d0
    548c:	3f0f           	move.w sp,-(sp)
    548e:	8000           	or.b d0,d0
    5490:	0007 ffe1      	ori.b #-31,d7
    5494:	e000           	asr.b #8,d0
    5496:	0000 0a01      	ori.b #1,d0
    549a:	ffc0           	.short 0xffc0
    549c:	001f e000      	ori.b #0,(sp)+
    54a0:	3f0f           	move.w sp,-(sp)
    54a2:	8000           	or.b d0,d0
    54a4:	0007 fff8      	ori.b #-8,d7
    54a8:	0000 0000      	ori.b #0,d0
    54ac:	0001 ffe0      	ori.b #-32,d1
    54b0:	000f           	.short 0x000f
    54b2:	f000           	.short 0xf000
    54b4:	3f0f           	move.w sp,-(sp)
    54b6:	8000           	or.b d0,d0
    54b8:	0007 fffd      	ori.b #-3,d7
    54bc:	0000 0000      	ori.b #0,d0
    54c0:	2081           	move.l d1,(a0)
    54c2:	ffe0           	.short 0xffe0
    54c4:	001f f000      	ori.b #0,(sp)+
    54c8:	1f0f           	.short 0x1f0f
    54ca:	c000           	and.b d0,d0
    54cc:	0007 ffff      	ori.b #-1,d7
    54d0:	b000           	cmp.b d0,d0
    54d2:	0000 0000      	ori.b #0,d0
    54d6:	fff0           	.short 0xfff0
    54d8:	000f           	.short 0x000f
    54da:	f800           	.short 0xf800
    54dc:	7e0f           	moveq #15,d7
    54de:	c000           	and.b d0,d0
    54e0:	0007 ffff      	ori.b #-1,d7
    54e4:	fe00 0000      	cp1nop #1
    54e8:	2081           	move.l d1,(a0)
    54ea:	fff0           	.short 0xfff0
    54ec:	0007 f800      	ori.b #0,d7
    54f0:	7e0f           	moveq #15,d7
    54f2:	e000           	asr.b #8,d0
    54f4:	000f           	.short 0x000f
    54f6:	ffff           	.short 0xffff
    54f8:	fe00 0000      	cp1nop #1
    54fc:	0001 fff8      	ori.b #-8,d1
    5500:	000f           	.short 0x000f
    5502:	fc00 7f0f      	cp0ld.b d0,d7,#8,#271
    5506:	e000           	asr.b #8,d0
    5508:	001f ffff      	ori.b #-1,(sp)+
    550c:	fe00 0000      	cp1nop #1
    5510:	0a00 fffc      	eori.b #-4,d0
    5514:	0007 f803      	ori.b #3,d7
    5518:	ff0f e000      	cp1st.b a6,sp,#1,#0
    551c:	003f           	.short 0x003f
    551e:	ffff           	.short 0xffff
    5520:	fe00 0000      	cp1nop #1
    5524:	0000 fffe      	ori.b #-2,d0
    5528:	0003 fe0b      	ori.b #11,d3
    552c:	fe0f c000      	cp1ld.b sp,a4,#1,#0
    5530:	007f           	.short 0x007f
    5532:	ffff           	.short 0xffff
    5534:	fe00 0000      	cp1nop #1
    5538:	0000 7dfe      	ori.b #-2,d0
    553c:	0007 ff3f      	ori.b #63,d7
    5540:	fe0f c000      	cp1ld.b sp,a4,#1,#0
    5544:	00ff           	.short 0x00ff
    5546:	ffff           	.short 0xffff
    5548:	fe00 0000      	cp1nop #1
    554c:	0000 7bff      	ori.b #-1,d0
    5550:	0003 ffff      	ori.b #-1,d3
    5554:	fc0f c000      	cp0ld.b sp,a4,#1,#0
    5558:	01ff           	.short 0x01ff
    555a:	ffff           	.short 0xffff
    555c:	fe00 0000      	cp1nop #1
    5560:	0000 ffff      	ori.b #-1,d0
    5564:	833f           	.short 0x833f
    5566:	ffff           	.short 0xffff
    5568:	fc0f e000      	cp0ld.b sp,a6,#1,#0
    556c:	03ff           	.short 0x03ff
    556e:	ffff           	.short 0xffff
    5570:	fe00 0000      	cp1nop #1
    5574:	0000 ffff      	ori.b #-1,d0
    5578:	ffff           	.short 0xffff
    557a:	ffff           	.short 0xffff
    557c:	fe0f e000      	cp1ld.b sp,a6,#1,#0
    5580:	07ff           	.short 0x07ff
    5582:	ffff           	.short 0xffff
    5584:	fe00 0380      	cp1ld.b d0,d0,#2,#384
    5588:	0005 ffff      	ori.b #-1,d5
    558c:	ffff           	.short 0xffff
    558e:	ffff           	.short 0xffff
    5590:	fc0f e000      	cp0ld.b sp,a6,#1,#0
    5594:	07ff           	.short 0x07ff
    5596:	ffff           	.short 0xffff
    5598:	fe00 0380      	cp1ld.b d0,d0,#2,#384
    559c:	007f           	.short 0x007f
    559e:	ffff           	.short 0xffff
    55a0:	ffff           	.short 0xffff
    55a2:	ffff           	.short 0xffff
    55a4:	f80f           	.short 0xf80f
    55a6:	f000           	.short 0xf000
    55a8:	1fff           	.short 0x1fff
    55aa:	ffff           	.short 0xffff
    55ac:	fe00 03e0      	cp1ld.b d0,d0,#2,#480
    55b0:	007f           	.short 0x007f
    55b2:	ffff           	.short 0xffff
    55b4:	ffff           	.short 0xffff
    55b6:	ffff           	.short 0xffff
    55b8:	fc0f f000      	cp0ld.b sp,sp,#1,#0
    55bc:	1fff           	.short 0x1fff
    55be:	ffff           	.short 0xffff
    55c0:	fe00 03f0      	cp1ld.b d0,d0,#2,#496
    55c4:	007f           	.short 0x007f
    55c6:	ffff           	.short 0xffff
    55c8:	ffff           	.short 0xffff
    55ca:	ffff           	.short 0xffff
    55cc:	f80f           	.short 0xf80f
    55ce:	e000           	asr.b #8,d0
    55d0:	1fff           	.short 0x1fff
    55d2:	f66f           	.short 0xf66f
    55d4:	fe00 03f0      	cp1ld.b d0,d0,#2,#496
    55d8:	007f           	.short 0x007f
    55da:	ffff           	.short 0xffff
    55dc:	ffff           	.short 0xffff
    55de:	ffff           	.short 0xffff
    55e0:	f80f           	.short 0xf80f
    55e2:	e000           	asr.b #8,d0
    55e4:	3fff           	.short 0x3fff
    55e6:	a006 fe00      	mac.l d6,d0,>>
    55ea:	03f0 007f      	bset d1,(127,a0,d0.w)
    55ee:	ffff           	.short 0xffff
    55f0:	ffff           	.short 0xffff
    55f2:	ffff           	.short 0xffff
    55f4:	f00f           	.short 0xf00f
    55f6:	f000           	.short 0xf000
    55f8:	3ffe           	.short 0x3ffe
    55fa:	8000           	or.b d0,d0
    55fc:	0000 01f0      	ori.b #-16,d0
    5600:	007f           	.short 0x007f
    5602:	ffff           	.short 0xffff
    5604:	ffff           	.short 0xffff
    5606:	ffff           	.short 0xffff
    5608:	f00f           	.short 0xf00f
    560a:	f000           	.short 0xf000
    560c:	7ffe           	.short 0x7ffe
    560e:	0000 0000      	ori.b #0,d0
    5612:	01f0 007f      	bset d0,(127,a0,d0.w)
    5616:	ffff           	.short 0xffff
    5618:	ffff           	.short 0xffff
    561a:	ffff           	.short 0xffff
    561c:	e00f           	lsr.b #8,d7
    561e:	f800           	.short 0xf800
    5620:	7ff8 0000      	mvz.w 0x0,d7
    5624:	0000 00f0      	ori.b #-16,d0
    5628:	007f           	.short 0x007f
    562a:	ffff           	.short 0xffff
    562c:	ffff           	.short 0xffff
    562e:	ffff           	.short 0xffff
    5630:	e00f           	lsr.b #8,d7
    5632:	f800           	.short 0xf800
    5634:	fff0           	.short 0xfff0
    5636:	0000 0000      	ori.b #0,d0
    563a:	00f0           	.short 0x00f0
    563c:	007f           	.short 0x007f
    563e:	ffff           	.short 0xffff
    5640:	ffff           	.short 0xffff
    5642:	ffff           	.short 0xffff
    5644:	f80f           	.short 0xf80f
    5646:	f000           	.short 0xf000
    5648:	ffe0           	.short 0xffe0
    564a:	0000 0000      	ori.b #0,d0
    564e:	01f0 007f      	bset d0,(127,a0,d0.w)
    5652:	ffff           	.short 0xffff
    5654:	ffff           	.short 0xffff
    5656:	ffff           	.short 0xffff
    5658:	fe0f f001      	cp1ld.b sp,sp,#1,#1
    565c:	ffc0           	.short 0xffc0
    565e:	0000 0000      	ori.b #0,d0
    5662:	00f0           	.short 0x00f0
    5664:	007f           	.short 0x007f
    5666:	ffff           	.short 0xffff
    5668:	ffff           	.short 0xffff
    566a:	ffff           	.short 0xffff
    566c:	ff8f f801      	cp1st.l sp,sp,#5,#1
    5670:	ff80 0000      	cp1st.l d0,d0,#1,#0
    5674:	0000 03f0      	ori.b #-16,d0
    5678:	007f           	.short 0x007f
    567a:	ffff           	.short 0xffff
    567c:	ffff           	.short 0xffff
    567e:	ffff           	.short 0xffff
    5680:	ffef           	.short 0xffef
    5682:	fc07 ff00      	cp0ld.b d7,sp,#8,#256
    5686:	0000 0000      	ori.b #0,d0
    568a:	03f0 007f      	bset d1,(127,a0,d0.w)
    568e:	fc00 ffff      	cp0ld.b d0,sp,#8,#511
    5692:	ffff           	.short 0xffff
    5694:	ffff           	.short 0xffff
    5696:	f807           	.short 0xf807
    5698:	fe00 0000      	cp1nop #1
    569c:	0000 03f0      	ori.b #-16,d0
    56a0:	007f           	.short 0x007f
    56a2:	fc00 ffff      	cp0ld.b d0,sp,#8,#511
    56a6:	ffff           	.short 0xffff
    56a8:	ffff           	.short 0xffff
    56aa:	fc0f fe00      	cp0ld.b sp,sp,#8,#0
    56ae:	0000 0000      	ori.b #0,d0
    56b2:	0ff0 007f      	bset d7,(127,a0,d0.w)
    56b6:	fc00 3fff      	cp0ld.b d0,d3,#8,#511
    56ba:	ffff           	.short 0xffff
    56bc:	ffff           	.short 0xffff
    56be:	fe1f ff80      	cp1ld.b (sp)+,sp,#8,#384
    56c2:	0000 0000      	ori.b #0,d0
    56c6:	1ff0           	.short 0x1ff0
    56c8:	007f           	.short 0x007f
    56ca:	fc00 3fff      	cp0ld.b d0,d3,#8,#511
    56ce:	fdff           	.short 0xfdff
    56d0:	ffff           	.short 0xffff
    56d2:	fc3f           	.short 0xfc3f
    56d4:	ff80 0000      	cp1st.l d0,d0,#1,#0
    56d8:	0000 1fe0      	ori.b #-32,d0
    56dc:	003f           	.short 0x003f
    56de:	fc00 1fff      	cp0ld.b d0,d1,#8,#511
    56e2:	f9ff           	.short 0xf9ff
    56e4:	ffff           	.short 0xffff
    56e6:	fe7f           	.short 0xfe7f
    56e8:	ffc0           	.short 0xffc0
    56ea:	0000 0000      	ori.b #0,d0
    56ee:	7fe0           	mvz.w -(a0),d7
    56f0:	003f           	.short 0x003f
    56f2:	fc00 0fff      	cp0ld.b d0,d0,#8,#511
    56f6:	f0ff           	.short 0xf0ff
    56f8:	ffff           	.short 0xffff
    56fa:	ffff           	.short 0xffff
    56fc:	ffe0           	.short 0xffe0
    56fe:	0000 0000      	ori.b #0,d0
    5702:	7ff0 000f      	mvz.w (15,a0,d0.w),d7
    5706:	fc00 07ff      	cp0ld.b d0,d0,#4,#511
    570a:	e1ff           	.short 0xe1ff
    570c:	ffff           	.short 0xffff
    570e:	ffff           	.short 0xffff
    5710:	fff0           	.short 0xfff0
    5712:	0000 0001      	ori.b #1,d0
    5716:	fff0           	.short 0xfff0
    5718:	000f           	.short 0x000f
    571a:	fc00 07fe      	cp0ld.b d0,d0,#4,#510
    571e:	81ff           	.short 0x81ff
    5720:	ffff           	.short 0xffff
    5722:	ffff           	.short 0xffff
    5724:	fffc           	.short 0xfffc
    5726:	0000 0007      	ori.b #7,d0
    572a:	ffe0           	.short 0xffe0
    572c:	0007 fc00      	ori.b #0,d7
    5730:	01f0 00f7      	bset d0,(-9,a0,d0.w)
    5734:	ffff           	.short 0xffff
    5736:	ffff           	.short 0xffff
    5738:	fffd           	.short 0xfffd
    573a:	0000 005f      	ori.b #95,d0
    573e:	ffc0           	.short 0xffc0
    5740:	0001 fc00      	ori.b #0,d1
    5744:	01f0 00e0      	bset d0,(-32,a0,d0.w)
    5748:	ffff           	.short 0xffff
    574a:	ffff           	.short 0xffff
    574c:	ffff           	.short 0xffff
    574e:	4000           	negx.b d0
    5750:	02ff           	.short 0x02ff
    5752:	ffe0           	.short 0xffe0
    5754:	0001 f800      	ori.b #0,d1
    5758:	00f0 0000 3fff 	([,-419377153)cmp2.b ([-16385],-419377153),d0
    575e:	ffff bfff e700 
    5764:	cfff 
    5766:	ffe0           	.short 0xffe0
    5768:	0000 5c00      	ori.b #0,d0
    576c:	0020 0000      	ori.b #0,-(a0)
    5770:	0fff           	.short 0x0fff
    5772:	ffff           	.short 0xffff
    5774:	9fff           	.short 0x9fff
    5776:	ffff           	.short 0xffff
    5778:	ffff           	.short 0xffff
    577a:	ff80 0000      	cp1st.l d0,d0,#1,#0
    577e:	0000 0000      	ori.b #0,d0
    5782:	0000 03ff      	ori.b #-1,d0
    5786:	ffff           	.short 0xffff
    5788:	9fff           	.short 0x9fff
    578a:	ffff           	.short 0xffff
    578c:	ffff           	.short 0xffff
    578e:	ffc0           	.short 0xffc0
	...
    5798:	00ff           	.short 0x00ff
    579a:	fffe           	.short 0xfffe
    579c:	1fff           	.short 0x1fff
    579e:	ffff           	.short 0xffff
    57a0:	ffff           	.short 0xffff
    57a2:	ff00 0000      	cp1st.b d0,d0,#1,#0
    57a6:	0000 0000      	ori.b #0,d0
    57aa:	0000 003f      	ori.b #63,d0
    57ae:	fffe           	.short 0xfffe
    57b0:	1fff           	.short 0x1fff
    57b2:	ffff           	.short 0xffff
    57b4:	ffff           	.short 0xffff
    57b6:	ff00 0000      	cp1st.b d0,d0,#1,#0
    57ba:	0000 0000      	ori.b #0,d0
    57be:	0000 000b      	ori.b #11,d0
    57c2:	fffc           	.short 0xfffc
    57c4:	07ff           	.short 0x07ff
    57c6:	ffff           	.short 0xffff
    57c8:	ffff           	.short 0xffff
    57ca:	fe00 0000      	cp1nop #1
    57ce:	0e00           	.short 0x0e00
    57d0:	0000 0000      	ori.b #0,d0
    57d4:	0003 fff8      	ori.b #-8,d3
    57d8:	07ff           	.short 0x07ff
    57da:	ffff           	.short 0xffff
    57dc:	ffff           	.short 0xffff
    57de:	fc00 0008      	cp0ld.b d0,d0,#1,#8
    57e2:	000c           	.short 0x000c
    57e4:	0000 0000      	ori.b #0,d0
    57e8:	0000 fff0      	ori.b #-16,d0
    57ec:	03ff           	.short 0x03ff
    57ee:	ffff           	.short 0xffff
    57f0:	ffff           	.short 0xffff
    57f2:	f800 0000      	tblu.b d0,d0,d0
    57f6:	0000 1c00      	ori.b #0,d0
    57fa:	0000 0000      	ori.b #0,d0
    57fe:	0fe0           	bset d7,-(a0)
    5800:	01ff           	.short 0x01ff
    5802:	ffff           	.short 0xffff
    5804:	ffff           	.short 0xffff
    5806:	f000           	.short 0xf000
    5808:	0000 0000      	ori.b #0,d0
    580c:	0070 0000 0000 	ori.w #0,(0,a0,d0.w)
    5812:	07c0           	bset d3,d0
    5814:	007f           	.short 0x007f
    5816:	ffff           	.short 0xffff
    5818:	ffff           	.short 0xffff
    581a:	c000           	and.b d0,d0
    581c:	0000 0000      	ori.b #0,d0
    5820:	0003 8000      	ori.b #0,d3
    5824:	0000 0780      	ori.b #-128,d0
    5828:	007f           	.short 0x007f
    582a:	ffff           	.short 0xffff
    582c:	ffff           	.short 0xffff
    582e:	c000           	and.b d0,d0
    5830:	0000 0000      	ori.b #0,d0
    5834:	0000 3000      	ori.b #0,d0
    5838:	0000 0000      	ori.b #0,d0
    583c:	000f           	.short 0x000f
    583e:	ffff           	.short 0xffff
    5840:	fffd           	.short 0xfffd
	...
    584a:	0600 0000      	addi.b #0,d0
    584e:	0000 000f      	ori.b #15,d0
    5852:	ffff           	.short 0xffff
    5854:	ffe8           	.short 0xffe8
	...
    585e:	0040 0000      	ori.w #0,d0
    5862:	0000 0002      	ori.b #2,d0
    5866:	7fff           	.short 0x7fff
    5868:	ff40 0080      	cp1st.w d0,d0,#1,#128
    586c:	0100           	btst d0,d0
    586e:	0000 0000      	ori.b #0,d0
    5872:	0010 0000      	ori.b #0,(a0)
    5876:	0000 0000      	ori.b #0,d0
    587a:	33ff           	.short 0x33ff
    587c:	cc00           	and.b d0,d6
    587e:	0200 0000      	andi.b #0,d0
    5882:	0000 0000      	ori.b #0,d0
    5886:	0004 0000      	ori.b #0,d4
	...
    5892:	0800 0000      	btst #0,d0
    5896:	0000 0000      	ori.b #0,d0
    589a:	0001 0000      	ori.b #0,d1
	...
    58a6:	4000           	negx.b d0
    58a8:	0040 7800      	ori.w #30720,d0
    58ac:	0000 0000      	ori.b #0,d0
    58b0:	4000           	negx.b d0
    58b2:	0000 0000      	ori.b #0,d0
    58b6:	0000 0006      	ori.b #6,d0
    58ba:	0000 0000      	ori.b #0,d0
    58be:	0070 0000 0000 	ori.w #0,(0,a0,d0.w)
    58c4:	1000           	move.b d0,d0
    58c6:	0000 0000      	ori.b #0,d0
    58ca:	0000 0060      	ori.b #96,d0
    58ce:	0000 0000      	ori.b #0,d0
    58d2:	4000           	negx.b d0
    58d4:	7000           	moveq #0,d0
    58d6:	0000 0400      	ori.b #0,d0
    58da:	0000 0000      	ori.b #0,d0
    58de:	0000 0600      	ori.b #0,d0
    58e2:	0000 0010      	ori.b #16,d0
    58e6:	0000 00c0      	ori.b #-64,d0
    58ea:	0000 0100      	ori.b #0,d0
    58ee:	0000 0000      	ori.b #0,d0
    58f2:	0000 6000      	ori.b #0,d0
    58f6:	0000 2008      	ori.b #8,d0
    58fa:	2000           	move.l d0,d0
    58fc:	0006 0000      	ori.b #0,d6
    5900:	0040 0000      	ori.w #0,d0
    5904:	0000 0006      	ori.b #6,d0
    5908:	0000 0000      	ori.b #0,d0
    590c:	0008           	.short 0x0008
    590e:	0000 0000      	ori.b #0,d0
    5912:	4000           	negx.b d0
    5914:	0000 0000      	ori.b #0,d0
    5918:	0000 0060      	ori.b #96,d0
    591c:	0000 0000      	ori.b #0,d0
    5920:	0000 1000      	ori.b #0,d0
    5924:	0000 0800      	ori.b #0,d0
    5928:	0008           	.short 0x0008
    592a:	0000 0000      	ori.b #0,d0
    592e:	0600 0000      	addi.b #0,d0
    5932:	0010 0000      	ori.b #0,(a0)
    5936:	1000           	move.b d0,d0
    5938:	0000 0100      	ori.b #0,d0
    593c:	0000 0000      	ori.b #0,d0
    5940:	0000 6000      	ori.b #0,d0
    5944:	0000 0000      	ori.b #0,d0
    5948:	0200 0000      	andi.b #0,d0
    594c:	0000 0020      	ori.b #32,d0
	...
    595c:	0000 0800      	ori.b #0,d0
    5960:	0000 0008      	ori.b #8,d0
    5964:	0000 8000      	ori.b #0,d0
    5968:	0000 0000      	ori.b #0,d0
    596c:	0000 0400      	ori.b #0,d0
    5970:	0100           	btst d0,d0
    5972:	0800 0000      	btst #0,d0
    5976:	0002 0000      	ori.b #0,d2
	...
    5982:	3820           	move.w -(a0),d4
	...
    598c:	8000           	or.b d0,d0
    598e:	1000           	move.b d0,d0
    5990:	0000 0000      	ori.b #0,d0
    5994:	0003 0020      	ori.b #32,d3
    5998:	0080 0000 0000 	ori.l #0,d0
    599e:	0000 2000      	ori.b #0,d0
    59a2:	0000 0000      	ori.b #0,d0
    59a6:	0000 0018      	ori.b #24,d0
    59aa:	0000 0000      	ori.b #0,d0
    59ae:	0400 0000      	subi.b #0,d0
    59b2:	0000 0000      	ori.b #0,d0
    59b6:	0200 0000      	andi.b #0,d0
    59ba:	0000 0180      	ori.b #-128,d0
    59be:	2000           	move.l d0,d0
    59c0:	0040 0400      	ori.w #1024,d0
    59c4:	0000 0000      	ori.b #0,d0
    59c8:	0400 0000      	subi.b #0,d0
    59cc:	0000 0000      	ori.b #0,d0
    59d0:	1800           	move.b d0,d4
	...
    59de:	0040 0000      	ori.w #0,d0
    59e2:	0001 8000      	ori.b #0,d1
    59e6:	0040 0020      	ori.w #32,d0
    59ea:	0000 0000      	ori.b #0,d0
    59ee:	0000 0080      	ori.b #-128,d0
    59f2:	0010 0000      	ori.b #0,(a0)
    59f6:	0018 0000      	ori.b #0,(a0)+
    59fa:	0040 0000      	ori.w #0,d0
	...
    5a06:	0004 0000      	ori.b #0,d4
    5a0a:	0180           	bclr d0,d0
    5a0c:	0000 0000      	ori.b #0,d0
    5a10:	0010 0200      	ori.b #0,(a0)
    5a14:	0000 0000      	ori.b #0,d0
    5a18:	0010 0001      	ori.b #1,(a0)
    5a1c:	0000 3000      	ori.b #0,d0
    5a20:	0000 0000      	ori.b #0,d0
    5a24:	0000 0200      	ori.b #0,d0
	...
    5a30:	4000           	negx.b d0
    5a32:	0000 0000      	ori.b #0,d0
    5a36:	0080 0008 0200 	ori.l #524800,d0
	...
    5a44:	1000           	move.b d0,d0
	...
    5a52:	0000 0001      	ori.b #1,d0
    5a56:	0000 0400      	ori.b #0,d0
    5a5a:	0000 0020      	ori.b #32,d0
    5a5e:	0100           	btst d0,d0
    5a60:	0004 0000      	ori.b #0,d4
	...
    5a6c:	0080 0000 0080 	ori.l #128,d0
	...
    5a7e:	2000           	move.l d0,d0
    5a80:	0030 0000 0200 	ori.b #0,(0,a0,d0.w:2)
    5a86:	0000 0002      	ori.b #2,d0
	...
    5a92:	0000 0004      	ori.b #4,d0
    5a96:	0000 0800      	ori.b #0,d0
	...
    5aa6:	0400 0000      	subi.b #0,d0
    5aaa:	8000           	or.b d0,d0
    5aac:	2000           	move.l d0,d0
    5aae:	0000 0001      	ori.b #1,d0
	...
    5aba:	0100           	btst d0,d0
    5abc:	0000 0c03      	ori.b #3,d0
	...
    5acc:	0000 0040      	ori.b #64,d0
	...
    5ad8:	0000 8000      	ori.b #0,d0
    5adc:	0000 0000      	ori.b #0,d0
    5ae0:	0000 0010      	ori.b #16,d0
	...
    5af4:	0000 0004      	ori.b #4,d0
	...
    5b00:	0000 4000      	ori.b #0,d0
    5b04:	0000 0000      	ori.b #0,d0
    5b08:	0000 0001      	ori.b #1,d0
	...
    5b20:	4000           	negx.b d0
    5b22:	0000 0004      	ori.b #4,d0
    5b26:	0000 0000      	ori.b #0,d0
    5b2a:	2000           	move.l d0,d0
	...
    5b34:	1000           	move.b d0,d0
    5b36:	0000 0010      	ori.b #16,d0
	...
    5b46:	0000 0200      	ori.b #0,d0
    5b4a:	0000 0040      	ori.b #64,d0
    5b4e:	0000 0000      	ori.b #0,d0
    5b52:	1000           	move.b d0,d0
	...
    5b5c:	0040 0000      	ori.w #0,d0
    5b60:	0100           	btst d0,d0
	...
    5b6e:	0000 0010      	ori.b #16,d0
    5b72:	0000 0400      	ori.b #0,d0
	...
    5b82:	0000 0003      	ori.b #3,d0
    5b86:	0000 3000      	ori.b #0,d0
	...
    5b9a:	1807           	move.b d7,d4
	...
    5bd4:	6000 0000      	bra.w 0x5bd6
	...
    5be8:	8000           	or.b d0,d0
	...
    5c1e:	0004 0000      	ori.b #0,d4
	...
    5c32:	0019 8032      	ori.b #50,(a1)+
	...
    5c46:	0009           	.short 0x0009
    5c48:	2034 0000      	move.l (0,a4,d0.w),d0
	...
    5c58:	0000 0008      	ori.b #8,d0
    5c5c:	0000 0780      	ori.b #-128,d0
	...
    5c6c:	0000 0008      	ori.b #8,d0
    5c70:	0004 07c0      	ori.b #-64,d4
	...
    5c80:	0000 000c      	ori.b #12,d0
    5c84:	201d           	move.l (a5)+,d0
    5c86:	0060 0000      	ori.w #0,-(a0)
	...
    5c96:	0008           	.short 0x0008
    5c98:	6c02           	bge.s 0x5c9c
    5c9a:	0020 0000      	ori.b #0,-(a0)
	...
    5caa:	0048           	.short 0x0048
    5cac:	0b00           	btst d5,d0
    5cae:	8000           	or.b d0,d0
	...
    5cbc:	0000 00f8      	ori.b #-8,d0
    5cc0:	0001 0000      	ori.b #0,d1
	...
    5cd0:	0000 0038      	ori.b #56,d0
    5cd4:	0000 4000      	ori.b #0,d0
	...
    5ce4:	0000 0038      	ori.b #56,d0
    5ce8:	0000 8101      	ori.b #1,d0
    5cec:	c000           	and.b d0,d0
	...
    5cfa:	0018 0000      	ori.b #0,(a0)+
    5cfe:	a48c           	.short 0xa48c
	...
    5d0c:	0000 0018      	ori.b #24,d0
    5d10:	0210 0240      	andi.b #64,(a0)
    5d14:	3000           	move.w d0,d0
	...
    5d22:	000c           	.short 0x000c
    5d24:	0980           	bclr d4,d0
    5d26:	4840           	swap d0
	...
    5d34:	0000 0006      	ori.b #6,d0
    5d38:	0600 0028      	addi.b #40,d0
    5d3c:	0800 0000      	btst #0,d0
	...
    5d48:	0000 0003      	ori.b #3,d0
    5d4c:	3000           	move.w d0,d0
    5d4e:	0013 7000      	ori.b #0,(a3)
	...
    5d5e:	0000 0019      	ori.b #25,d0
    5d62:	000f           	.short 0x000f
    5d64:	e000           	asr.b #8,d0
	...
    5d72:	0000 0020      	ori.b #32,d0
    5d76:	0003 c000      	ori.b #0,d3
	...
    5d86:	0000 0080      	ori.b #-128,d0
	...
    5d9a:	0000 0100      	ori.b #0,d0
	...
    5dae:	0000 0400      	ori.b #0,d0
	...
    5dbe:	0001 0080      	ori.b #-128,d1
    5dc2:	0000 1000      	ori.b #0,d0
	...
    5dd2:	0003 8040      	ori.b #64,d3
    5dd6:	0000 4030      	ori.b #48,d0
	...
    5de6:	0003 c000      	ori.b #0,d3
    5dea:	0001 0070      	ori.b #112,d1
	...
    5dfa:	0001 f008      	ori.b #8,d1
    5dfe:	000c           	.short 0x000c
    5e00:	00f0 0000 0000 	cmp2.b (0,a0,d0.w),d0
	...
    5e0e:	0001 f804      	ori.b #4,d1
    5e12:	00e0           	.short 0x00e0
    5e14:	03f0 0000      	bset d1,(0,a0,d0.w)
    5e18:	0000 0000      	ori.b #0,d0
    5e1c:	0080 0000 0000 	ori.l #0,d0
    5e22:	0000 fc01      	ori.b #1,d0
    5e26:	0000 07f0      	ori.b #-16,d0
    5e2a:	0000 0000      	ori.b #0,d0
    5e2e:	0000 0200      	ori.b #0,d0
    5e32:	0000 0000      	ori.b #0,d0
    5e36:	0000 fe00      	ori.b #0,d0
    5e3a:	8000           	or.b d0,d0
    5e3c:	1ff0           	.short 0x1ff0
    5e3e:	0000 0000      	ori.b #0,d0
    5e42:	0000 0800      	ori.b #0,d0
    5e46:	0000 0000      	ori.b #0,d0
    5e4a:	0000 7f00      	ori.b #0,d0
    5e4e:	0000 3ff0      	ori.b #-16,d0
    5e52:	0000 0000      	ori.b #0,d0
    5e56:	0000 1000      	ori.b #0,d0
    5e5a:	0000 0000      	ori.b #0,d0
    5e5e:	0002 7f80      	ori.b #-128,d2
    5e62:	1000           	move.b d0,d0
    5e64:	fff0           	.short 0xfff0
    5e66:	7800           	moveq #0,d4
    5e68:	0000 0000      	ori.b #0,d0
    5e6c:	4000           	negx.b d0
    5e6e:	0000 0000      	ori.b #0,d0
    5e72:	0001 3fc0      	ori.b #-64,d1
    5e76:	0801 fff0      	btst #-16,d1
    5e7a:	0000 7800      	ori.b #0,d0
    5e7e:	0000 8020      	ori.b #32,d0
    5e82:	0000 0000      	ori.b #0,d0
    5e86:	0001 3fe0      	ori.b #-32,d1
    5e8a:	0003 fff8      	ori.b #-8,d3
    5e8e:	0000 0078      	ori.b #120,d0
    5e92:	0002 0060      	ori.b #96,d2
    5e96:	0000 0000      	ori.b #0,d0
    5e9a:	0000 3c30      	ori.b #48,d0
    5e9e:	0007 fff8      	ori.b #-8,d7
    5ea2:	0000 0000      	ori.b #0,d0
    5ea6:	0004 0060      	ori.b #96,d4
    5eaa:	0000 0000      	ori.b #0,d0
    5eae:	0000 9c00      	ori.b #0,d0
    5eb2:	0001 fffc      	ori.b #-4,d1
    5eb6:	0000 0000      	ori.b #0,d0
    5eba:	0008           	.short 0x0008
    5ebc:	00c0           	bitrev d0
    5ebe:	0000 0000      	ori.b #0,d0
    5ec2:	0000 0c00      	ori.b #0,d0
    5ec6:	0000 ffbc      	ori.b #-68,d0
    5eca:	3000           	move.w d0,d0
    5ecc:	0000 0000      	ori.b #0,d0
    5ed0:	01c0           	bset d0,d0
    5ed2:	0000 0001      	ori.b #1,d0
    5ed6:	0000 4c00      	ori.b #0,d0
    5eda:	0000 3f1f      	ori.b #31,d0
    5ede:	f000           	.short 0xf000
    5ee0:	0000 0000      	ori.b #0,d0
    5ee4:	03c0           	bset d1,d0
    5ee6:	0000 0001      	ori.b #1,d0
    5eea:	0000 4400      	ori.b #0,d0
    5eee:	0000 1e1f      	ori.b #31,d0
    5ef2:	e000           	asr.b #8,d0
    5ef4:	0000 0000      	ori.b #0,d0
    5ef8:	0f80           	bclr d7,d0
    5efa:	0000 0001      	ori.b #1,d0
    5efe:	0000 00c0      	ori.b #-64,d0
    5f02:	0000 0c0f      	ori.b #15,d0
    5f06:	c000           	and.b d0,d0
    5f08:	0000 0000      	ori.b #0,d0
    5f0c:	1f80 0000      	move.b d0,(0,sp,d0.w)
    5f10:	0001 0000      	ori.b #0,d1
    5f14:	2000           	move.l d0,d0
    5f16:	0000 0007      	ori.b #7,d0
    5f1a:	c000           	and.b d0,d0
    5f1c:	0000 0001      	ori.b #1,d0
    5f20:	ff80 0000      	cp1st.l d0,d0,#1,#0
    5f24:	0000 0000      	ori.b #0,d0
    5f28:	2048           	movea.l a0,a0
    5f2a:	0000 0003      	ori.b #3,d0
    5f2e:	8000           	or.b d0,d0
    5f30:	0000 000f      	ori.b #15,d0
    5f34:	ff82 0000      	cp1st.l d0,d2,#1,#0
    5f38:	0000 8000      	ori.b #0,d0
    5f3c:	0004 0000      	ori.b #0,d4
    5f40:	0003 0000      	ori.b #0,d3
    5f44:	0000 001f      	ori.b #31,d0
    5f48:	ff01 0000      	cp1st.b d0,d1,#1,#0
    5f4c:	0000 8000      	ori.b #0,d0
    5f50:	1020           	move.b -(a0),d0
	...
    5f5a:	0030 3f02 0000 	ori.b #2,(0,a0,d0.w)
    5f60:	0000 0000      	ori.b #0,d0
    5f64:	1020           	move.b -(a0),d0
    5f66:	8000           	or.b d0,d0
    5f68:	83c0           	divs.w d0,d1
    5f6a:	0000 0000      	ori.b #0,d0
    5f6e:	1000           	move.b d0,d0
    5f70:	0f00           	btst d7,d0
    5f72:	0000 0000      	ori.b #0,d0
    5f76:	4000           	negx.b d0
    5f78:	0000 4000      	ori.b #0,d0
    5f7c:	0000 7800      	ori.b #0,d0
    5f80:	0010 2000      	ori.b #0,(a0)
    5f84:	0300           	btst d1,d0
    5f86:	0000 0000      	ori.b #0,d0
    5f8a:	4000           	negx.b d0
    5f8c:	0810 0000      	btst #0,(a0)
    5f90:	0000 0000      	ori.b #0,d0
    5f94:	0020 0000      	ori.b #0,-(a0)
    5f98:	0300           	btst d1,d0
    5f9a:	0000 0000      	ori.b #0,d0
    5f9e:	0000 0810      	ori.b #16,d0
    5fa2:	0000 0000      	ori.b #0,d0
    5fa6:	0000 0070      	ori.b #112,d0
    5faa:	4000           	negx.b d0
    5fac:	0300           	btst d1,d0
    5fae:	0000 0000      	ori.b #0,d0
    5fb2:	2000           	move.l d0,d0
    5fb4:	0000 0400      	ori.b #0,d0
    5fb8:	1000           	move.b d0,d0
    5fba:	0000 00c4      	ori.b #-60,d0
    5fbe:	8000           	or.b d0,d0
    5fc0:	0300           	btst d1,d0
    5fc2:	0000 0008      	ori.b #8,d0
    5fc6:	2000           	move.l d0,d0
    5fc8:	0408           	.short 0x0408
    5fca:	0200 0000      	andi.b #0,d0
    5fce:	0000 00e8      	ori.b #-24,d0
    5fd2:	8000           	or.b d0,d0
    5fd4:	2200           	move.l d0,d1
    5fd6:	0000 0008      	ori.b #8,d0
    5fda:	0000 0408      	ori.b #8,d0
    5fde:	0100           	btst d0,d0
    5fe0:	0800 0080      	btst #-128,d0
    5fe4:	0221 0000      	andi.b #0,-(a1)
    5fe8:	2200           	move.l d0,d1
    5fea:	0000 0008      	ori.b #8,d0
    5fee:	1000           	move.b d0,d0
    5ff0:	0000 0000      	ori.b #0,d0
    5ff4:	0000 0080      	ori.b #-128,d0
    5ff8:	0041 0000      	ori.w #0,d1
    5ffc:	4200           	clr.b d0
    5ffe:	0000 0008      	ori.b #8,d0
    6002:	0000 0204      	ori.b #4,d0
    6006:	0000 0400      	ori.b #0,d0
    600a:	0080 0002 0000 	ori.l #131072,d0
    6010:	0000 0000      	ori.b #0,d0
    6014:	0000 0800      	ori.b #0,d0
    6018:	0204 0000      	andi.b #0,d4
    601c:	0000 8000      	ori.b #0,d0
    6020:	0002 0000      	ori.b #0,d2
	...
    6030:	0200 8040      	andi.b #64,d0
    6034:	0000 8000      	ori.b #0,d0
    6038:	0000 0000      	ori.b #0,d0
    603c:	0000 0400      	ori.b #0,d0
    6040:	0102           	btst d0,d2
    6042:	0000 0200      	ori.b #0,d0
    6046:	8040           	or.w d0,d0
    6048:	0804 0000      	btst #0,d4
    604c:	0000 0200      	ori.b #0,d0
    6050:	0004 0000      	ori.b #0,d4
    6054:	0102           	btst d0,d2
    6056:	0004 0000      	ori.b #0,d4
    605a:	8000           	or.b d0,d0
    605c:	3005           	move.w d5,d0
    605e:	0000 0000      	ori.b #0,d0
    6062:	0800 0004      	btst #4,d0
    6066:	0200 0000      	andi.b #0,d0
    606a:	0002 0100      	ori.b #0,d2
    606e:	8023           	or.b -(a3),d0
    6070:	8007           	or.b d7,d0
    6072:	0000 0000      	ori.b #0,d0
    6076:	2000           	move.l d0,d0
    6078:	0004 0000      	ori.b #0,d4
    607c:	0081 0000 0100 	ori.l #256,d1
    6082:	8000           	or.b d0,d0
    6084:	0007 0000      	ori.b #0,d7
    6088:	0000 8000      	ori.b #0,d0
    608c:	0004 0100      	ori.b #0,d4
    6090:	0081 0001 0100 	ori.l #65792,d1
    6096:	0000 0002      	ori.b #2,d0
    609a:	0000 0002      	ori.b #2,d0
	...
    60a6:	0000 8000      	ori.b #0,d0
    60aa:	0000 0000      	ori.b #0,d0
    60ae:	0000 0008      	ori.b #8,d0
    60b2:	0000 0000      	ori.b #0,d0
    60b6:	0080 0040 8000 	ori.l #4227072,d0
    60bc:	8000           	or.b d0,d0
    60be:	0000 0002      	ori.b #2,d0
    60c2:	0000 0020      	ori.b #32,d0
    60c6:	0000 0002      	ori.b #2,d0
    60ca:	0080 0040 0000 	ori.l #4194304,d0
    60d0:	4000           	negx.b d0
    60d2:	4000           	negx.b d0
    60d4:	0000 0000      	ori.b #0,d0
    60d8:	0080 0000 0002 	ori.l #2,d0
    60de:	0000 0000      	ori.b #0,d0
    60e2:	4000           	negx.b d0
    60e4:	4000           	negx.b d0
    60e6:	4000           	negx.b d0
    60e8:	0000 0200      	ori.b #0,d0
    60ec:	0200 0000      	andi.b #0,d0
    60f0:	0002 0040      	ori.b #64,d2
    60f4:	0020 0000      	ori.b #0,-(a0)
    60f8:	2000           	move.l d0,d0
    60fa:	4000           	negx.b d0
    60fc:	0000 0080      	ori.b #-128,d0
    6100:	0800 0000      	btst #0,d0
    6104:	0002 0000      	ori.b #0,d2
    6108:	0020 2000      	ori.b #0,-(a0)
    610c:	2000           	move.l d0,d0
    610e:	4000           	negx.b d0
    6110:	0000 2020      	ori.b #32,d0
    6114:	2000           	move.l d0,d0
    6116:	0000 0e00      	ori.b #0,d0
    611a:	0020 0000      	ori.b #0,-(a0)
    611e:	0000 2000      	ori.b #0,d0
    6122:	4000           	negx.b d0
    6124:	0000 1008      	ori.b #8,d0
    6128:	0000 0000      	ori.b #0,d0
    612c:	1f00           	move.b d0,-(sp)
    612e:	0000 0010      	ori.b #16,d0
    6132:	1000           	move.b d0,d0
    6134:	2000           	move.l d0,d0
    6136:	4000           	negx.b d0
    6138:	0000 1003      	ori.b #3,d0
    613c:	0000 0000      	ori.b #0,d0
    6140:	3f80 0010      	move.w d0,(16,sp,d0.w)
    6144:	0010 0000      	ori.b #0,(a0)
    6148:	2000           	move.l d0,d0
    614a:	0000 0000      	ori.b #0,d0
    614e:	1800           	move.b d0,d4
    6150:	7000           	moveq #0,d0
    6152:	0000 3f81      	ori.b #-127,d0
    6156:	0000 0000      	ori.b #0,d0
    615a:	0800 4100      	btst #0,d0
    615e:	0000 0000      	ori.b #0,d0
    6162:	0c00 0000      	cmpi.b #0,d0
    6166:	0000 3f81      	ori.b #-127,d0
    616a:	0008           	.short 0x0008
    616c:	0008           	.short 0x0008
    616e:	0000 0100      	ori.b #0,d0
    6172:	2000           	move.l d0,d0
    6174:	0000 1e00      	ori.b #0,d0
    6178:	0000 0000      	ori.b #0,d0
    617c:	1f01           	move.b d1,-(sp)
    617e:	0000 0008      	ori.b #8,d0
    6182:	0400 8100      	subi.b #0,d0
    6186:	2000           	move.l d0,d0
    6188:	0000 7f00      	ori.b #0,d0
    618c:	0000 0000      	ori.b #0,d0
    6190:	0e00           	.short 0x0e00
    6192:	0000 0000      	ori.b #0,d0
    6196:	0402 0100      	subi.b #0,d2
    619a:	2000           	move.l d0,d0
    619c:	0000 ffc0      	ori.b #-64,d0
    61a0:	0000 0000      	ori.b #0,d0
    61a4:	0000 0402      	ori.b #2,d0
    61a8:	0005 020c      	ori.b #12,d5
    61ac:	0000 2000      	ori.b #0,d0
    61b0:	0001 ffe0      	ori.b #-32,d1
    61b4:	0000 0000      	ori.b #0,d0
    61b8:	0000 8600      	ori.b #0,d0
    61bc:	0005 01c0      	ori.b #-64,d5
    61c0:	0000 2000      	ori.b #0,d0
    61c4:	0003 fff8      	ori.b #-8,d3
    61c8:	0000 0000      	ori.b #0,d0
    61cc:	0000 8200      	ori.b #0,d0
    61d0:	0001 8000      	ori.b #0,d1
    61d4:	0200 2000      	andi.b #0,d0
    61d8:	0007 fe7e      	ori.b #126,d7
    61dc:	0000 0000      	ori.b #0,d0
    61e0:	0000 8000      	ori.b #0,d0
    61e4:	03c1           	bset d1,d1
    61e6:	c000           	and.b d0,d0
    61e8:	0200 0000      	andi.b #0,d0
    61ec:	0003 f83f      	ori.b #63,d3
    61f0:	c000           	and.b d0,d0
    61f2:	0000 0000      	ori.b #0,d0
    61f6:	8000           	or.b d0,d0
    61f8:	0001 c003      	ori.b #3,d1
    61fc:	0200 0000      	andi.b #0,d0
    6200:	0001 f01f      	ori.b #31,d1
    6204:	c000           	and.b d0,d0
    6206:	0080 0006 0000 	ori.l #393216,d0
    620c:	0003 e006      	ori.b #6,d3
    6210:	0000 0000      	ori.b #0,d0
    6214:	0800 e01f      	btst #31,d0
    6218:	0000 0040      	ori.b #64,d0
    621c:	0000 0000      	ori.b #0,d0
    6220:	0003 e03c      	ori.b #60,d3
    6224:	0400 1000      	subi.b #0,d0
    6228:	1000           	move.b d0,d0
    622a:	401e           	negx.b (a6)+
	...
    6234:	0007 f0f8      	ori.b #-8,d7
    6238:	0400 1000      	subi.b #0,d0
    623c:	0000 0000      	ori.b #0,d0
    6240:	0000 0010      	ori.b #16,d0
    6244:	0000 0000      	ori.b #0,d0
    6248:	0007 fff0      	ori.b #-16,d7
    624c:	0000 1000      	ori.b #0,d0
    6250:	2000           	move.l d0,d0
    6252:	0e70 0000 0000 	moves.w (0,a0,d0.w),d0
    6258:	0000 0000      	ori.b #0,d0
    625c:	000f           	.short 0x000f
    625e:	ffe0           	.short 0xffe0
    6260:	0800 1000      	btst #0,d0
    6264:	0000 6007      	ori.b #7,d0
    6268:	0000 0000      	ori.b #0,d0
    626c:	0000 3fff      	ori.b #-1,d0
    6270:	ffff           	.short 0xffff
    6272:	ffc0           	.short 0xffc0
    6274:	0000 0000      	ori.b #0,d0
    6278:	4001           	negx.b d1
    627a:	8000           	or.b d0,d0
    627c:	0000 0200      	ori.b #0,d0
    6280:	0000 ffff      	ori.b #-1,d0
    6284:	ffff           	.short 0xffff
    6286:	ffc0           	.short 0xffc0
    6288:	1000           	move.b d0,d0
    628a:	0000 0002      	ori.b #2,d0
    628e:	0000 0000      	ori.b #0,d0
    6292:	0000 0001      	ori.b #1,d0
    6296:	ffff           	.short 0xffff
    6298:	ffff           	.short 0xffff
    629a:	ff80 0000      	cp1st.l d0,d0,#1,#0
    629e:	8800           	or.b d0,d4
    62a0:	8000           	or.b d0,d0
    62a2:	0000 0000      	ori.b #0,d0
    62a6:	0000 0001      	ori.b #1,d0
    62aa:	ffff           	.short 0xffff
    62ac:	ffff           	.short 0xffff
    62ae:	ff00 2000      	cp1st.b d2,d0,#1,#0
    62b2:	8800           	or.b d0,d4
    62b4:	2000           	move.l d0,d0
	...
    62be:	3fff           	.short 0x3fff
    62c0:	ffff           	.short 0xffff
    62c2:	fe00 0800      	cp1nop #5
    62c6:	8801           	or.b d1,d4
    62c8:	2000           	move.l d0,d0
    62ca:	0000 0000      	ori.b #0,d0
    62ce:	0100           	btst d0,d0
    62d0:	0000 00ff      	ori.b #-1,d0
    62d4:	e7ff           	.short 0xe7ff
    62d6:	fc00 0200      	cp0nop #2
    62da:	c800           	and.b d0,d4
    62dc:	2000           	move.l d0,d0
    62de:	0000 0000      	ori.b #0,d0
    62e2:	0100           	btst d0,d0
    62e4:	0000 0000      	ori.b #0,d0
    62e8:	03ff           	.short 0x03ff
    62ea:	e000           	asr.b #8,d0
    62ec:	0080 c002 6000 	ori.l #-1073586176,d0
    62f2:	0000 0000      	ori.b #0,d0
    62f6:	0200 0000      	andi.b #0,d0
    62fa:	0000 01ff      	ori.b #-1,d0
    62fe:	8000           	or.b d0,d0
    6300:	0020 c404      	ori.b #4,-(a0)
    6304:	6000 0000      	bra.w 0x6306
	...
    6310:	00ff           	.short 0x00ff
    6312:	0000 0006      	ori.b #6,d0
    6316:	c400           	and.b d0,d2
    6318:	7100           	mvs.b d0,d0
    631a:	0000 0000      	ori.b #0,d0
    631e:	0400 0000      	subi.b #0,d0
    6322:	0000 807c      	ori.b #124,d0
    6326:	0000 0007      	ori.b #7,d0
    632a:	c000           	and.b d0,d0
    632c:	7100           	mvs.b d0,d0
    632e:	0000 0000      	ori.b #0,d0
    6332:	0880 0000      	bclr #0,d0
    6336:	0000 4038      	ori.b #56,d0
    633a:	0000 0007      	ori.b #7,d0
    633e:	e200           	asr.b #1,d0
    6340:	f080 0000      	pbb.s 0x6342
    6344:	0000 1100      	ori.b #0,d0
    6348:	0000 0000      	ori.b #0,d0
    634c:	0010 0000      	ori.b #0,(a0)
    6350:	07ff           	.short 0x07ff
    6352:	e200           	asr.b #1,d0
    6354:	f000           	.short 0xf000
    6356:	0000 0000      	ori.b #0,d0
    635a:	0310           	btst d1,(a0)
	...
    6364:	03ff           	.short 0x03ff
    6366:	e001           	asr.b #8,d1
    6368:	f800 0000      	tblu.b d0,d0,d0
    636c:	0000 4610      	ori.b #16,d0
    6370:	0020 0000      	ori.b #0,-(a0)
    6374:	0000 0100      	ori.b #0,d0
    6378:	01ff           	.short 0x01ff
    637a:	e001           	asr.b #8,d1
    637c:	f800 0000      	tblu.b d0,d0,d0
    6380:	0000 8e10      	ori.b #16,d0
    6384:	0010 0000      	ori.b #0,(a0)
    6388:	0000 2100      	ori.b #0,d0
    638c:	007f           	.short 0x007f
    638e:	f000           	.short 0xf000
    6390:	3800           	move.w d0,d4
    6392:	0000 0002      	ori.b #2,d0
    6396:	1e10           	move.b (a0),d7
    6398:	0000 0000      	ori.b #0,d0
    639c:	0401 8100      	subi.b #0,d1
    63a0:	001f f000      	ori.b #0,(sp)+
    63a4:	3c04           	move.w d4,d6
    63a6:	0000 0008      	ori.b #8,d0
    63aa:	3c00           	move.w d0,d6
    63ac:	0000 0000      	ori.b #0,d0
    63b0:	0208           	.short 0x0208
    63b2:	0016 000f      	ori.b #15,(a6)
    63b6:	f800 1c03      	tblsn.b d0,d3,d1
    63ba:	0000 0060      	ori.b #96,d0
    63be:	7c20           	moveq #32,d6
    63c0:	0002 0000      	ori.b #0,d2
    63c4:	0000 0000      	ori.b #0,d0
    63c8:	8007           	or.b d7,d0
    63ca:	9800           	sub.b d0,d4
    63cc:	1e00           	move.b d0,d7
    63ce:	c000           	and.b d0,d0
    63d0:	0301           	btst d1,d1
    63d2:	f820           	.short 0xf820
    63d4:	0001 0400      	ori.b #0,d1
    63d8:	0000 0000      	ori.b #0,d0
    63dc:	2003           	move.l d3,d0
    63de:	8400           	or.b d0,d2
    63e0:	0e00           	.short 0x0e00
    63e2:	1f00           	move.b d0,-(sp)
    63e4:	f00f           	.short 0xf00f
    63e6:	f820           	.short 0xf820
    63e8:	0000 6400      	ori.b #0,d0
    63ec:	0050 0000      	ori.w #0,(a0)
    63f0:	0801 c000      	btst #0,d1
    63f4:	2600           	move.l d0,d3
    63f6:	0000 001e      	ori.b #30,d0
    63fa:	7840           	moveq #64,d4
	...
    6404:	0200 c000      	andi.b #0,d0
    6408:	8200           	or.b d0,d1
    640a:	0000 0004      	ori.b #4,d0
    640e:	3040           	movea.w d0,a0
	...
    6418:	0080 4001 0000 	ori.l #1073807360,d0
    641e:	0000 0000      	ori.b #0,d0
    6422:	1080           	move.b d0,(a0)
	...
    642c:	0020 0000      	ori.b #0,-(a0)
    6430:	1000           	move.b d0,d0
	...
    643e:	0000 000c      	ori.b #12,d0
    6442:	0000 0800      	ori.b #0,d0
    6446:	0000 0000      	ori.b #0,d0
    644a:	0000 0007      	ori.b #7,d0
    644e:	fe00 0000      	cp1nop #1
    6452:	0000 0002      	ori.b #2,d0
	...
    645e:	0000 000f      	ori.b #15,d0
    6462:	fffc           	.short 0xfffc
	...
    6474:	000f           	.short 0x000f
    6476:	ffff           	.short 0xffff
    6478:	fc00 0000      	cp0nop #1
    647c:	0000 0800      	ori.b #0,d0
	...
    6488:	000f           	.short 0x000f
    648a:	ffff           	.short 0xffff
    648c:	fff0           	.short 0xfff0
    648e:	0000 0000      	ori.b #0,d0
    6492:	0000 0080      	ori.b #-128,d0
    6496:	0000 0000      	ori.b #0,d0
    649a:	2000           	move.l d0,d0
    649c:	300f           	move.w sp,d0
    649e:	ffff           	.short 0xffff
    64a0:	ffff           	.short 0xffff
    64a2:	8000           	or.b d0,d0
    64a4:	0000 0400      	ori.b #0,d0
    64a8:	0040 0000      	ori.w #0,d0
    64ac:	0000 4000      	ori.b #0,d0
    64b0:	380f           	move.w sp,d4
    64b2:	ffff           	.short 0xffff
    64b4:	ffff           	.short 0xffff
    64b6:	f000           	.short 0xf000
    64b8:	0000 0000      	ori.b #0,d0
    64bc:	0010 0000      	ori.b #0,(a0)
    64c0:	0003 0000      	ori.b #0,d3
    64c4:	3c0f           	move.w sp,d6
    64c6:	ffff           	.short 0xffff
    64c8:	ffff           	.short 0xffff
    64ca:	fe00 0000      	cp1nop #1
    64ce:	0000 0008      	ori.b #8,d0
    64d2:	0000 0018      	ori.b #24,d0
    64d6:	0038 3e0f ffff 	ori.b #15,0xffffffff
    64dc:	ffff           	.short 0xffff
    64de:	ffc0           	.short 0xffc0
    64e0:	0000 0000      	ori.b #0,d0
    64e4:	0003 8000      	ori.b #0,d3
    64e8:	00c0           	bitrev d0
    64ea:	00f8           	.short 0x00f8
    64ec:	3f0f           	move.w sp,-(sp)
    64ee:	ffff           	.short 0xffff
    64f0:	ffff           	.short 0xffff
    64f2:	fff0           	.short 0xfff0
    64f4:	0000 0000      	ori.b #0,d0
    64f8:	0000 3c00      	ori.b #0,d0
    64fc:	3c00           	move.w d0,d6
    64fe:	03f8 3f0f      	bset d1,0x3f0f
    6502:	ffff           	.short 0xffff
    6504:	ffff           	.short 0xffff
    6506:	fffc           	.short 0xfffc
	...
    6510:	0000 0ff8      	ori.b #-8,d0
    6514:	3f8f ffff ffff 	([,0)move.w sp,([-1],0)
    651a:	ffff 0000 0000 
    6520:	0000 0000      	ori.b #0,d0
    6524:	0000 7ff8      	ori.b #-8,d0
    6528:	3fcf           	.short 0x3fcf
    652a:	ffff           	.short 0xffff
    652c:	ffff           	.short 0xffff
    652e:	ffff           	.short 0xffff
    6530:	c000           	and.b d0,d0
    6532:	0000 0000      	ori.b #0,d0
    6536:	0000 0007      	ori.b #7,d0
    653a:	fff8           	.short 0xfff8
    653c:	3fcf           	.short 0x3fcf
    653e:	807f           	.short 0x807f
    6540:	ffff           	.short 0xffff
    6542:	ffff           	.short 0xffff
    6544:	f000           	.short 0xf000
    6546:	0000 0000      	ori.b #0,d0
    654a:	0000 007f      	ori.b #127,d0
    654e:	fff8           	.short 0xfff8
    6550:	3fef           	.short 0x3fef
    6552:	c000           	and.b d0,d0
    6554:	7fff           	.short 0x7fff
    6556:	ffff           	.short 0xffff
    6558:	fc00 0000      	cp0nop #1
    655c:	0000 0000      	ori.b #0,d0
    6560:	07ff           	.short 0x07ff
    6562:	fff8           	.short 0xfff8
    6564:	3fff           	.short 0x3fff
    6566:	c000           	and.b d0,d0
    6568:	00ff           	.short 0x00ff
    656a:	ffff           	.short 0xffff
    656c:	ff00 0000      	cp1st.b d0,d0,#1,#0
    6570:	0000 0000      	ori.b #0,d0
    6574:	7fff           	.short 0x7fff
    6576:	fff8           	.short 0xfff8
    6578:	3fff           	.short 0x3fff
    657a:	e000           	asr.b #8,d0
    657c:	0007 ffff      	ori.b #-1,d7
    6580:	ffc0           	.short 0xffc0
    6582:	0000 0000      	ori.b #0,d0
    6586:	0007 ffff      	ori.b #-1,d7
    658a:	fff8           	.short 0xfff8
    658c:	0fff           	.short 0x0fff
    658e:	e000           	asr.b #8,d0
    6590:	0000 7fff      	ori.b #-1,d0
    6594:	ffe0           	.short 0xffe0
    6596:	0000 0000      	ori.b #0,d0
    659a:	007f           	.short 0x007f
    659c:	ffff           	.short 0xffff
    659e:	fff8           	.short 0xfff8
    65a0:	07ff           	.short 0x07ff
    65a2:	f000           	.short 0xf000
    65a4:	0000 0fff      	ori.b #-1,d0
    65a8:	fff8           	.short 0xfff8
    65aa:	0000 0000      	ori.b #0,d0
    65ae:	07ff           	.short 0x07ff
    65b0:	ffff           	.short 0xffff
    65b2:	fff0           	.short 0xfff0
    65b4:	03ff           	.short 0x03ff
    65b6:	f000           	.short 0xf000
    65b8:	0000 01ff      	ori.b #-1,d0
    65bc:	fffc           	.short 0xfffc
    65be:	0000 0000      	ori.b #0,d0
    65c2:	7fff           	.short 0x7fff
    65c4:	ffff           	.short 0xffff
    65c6:	ffe0           	.short 0xffe0
    65c8:	03ff           	.short 0x03ff
    65ca:	f000           	.short 0xf000
    65cc:	0000 003f      	ori.b #63,d0
    65d0:	fffe           	.short 0xfffe
    65d2:	0000 0000      	ori.b #0,d0
    65d6:	ffff           	.short 0xffff
    65d8:	ffff           	.short 0xffff
    65da:	ffe0           	.short 0xffe0
    65dc:	01ff           	.short 0x01ff
    65de:	f800 0000      	tblu.b d0,d0,d0
    65e2:	000f           	.short 0x000f
    65e4:	ffff           	.short 0xffff
    65e6:	8000           	or.b d0,d0
    65e8:	0000 ffff      	ori.b #-1,d0
    65ec:	ffff           	.short 0xffff
    65ee:	ffe0           	.short 0xffe0
    65f0:	01ff           	.short 0x01ff
    65f2:	f800 0000      	tblu.b d0,d0,d0
    65f6:	0003 ffff      	ori.b #-1,d3
    65fa:	c000           	and.b d0,d0
    65fc:	0000 ffff      	ori.b #-1,d0
    6600:	ffff           	.short 0xffff
    6602:	ffe0           	.short 0xffe0
    6604:	00ff           	.short 0x00ff
    6606:	f800 0000      	tblu.b d0,d0,d0
    660a:	0000 ffff      	ori.b #-1,d0
    660e:	f000           	.short 0xf000
    6610:	0000 ffff      	ori.b #-1,d0
    6614:	ffff           	.short 0xffff
    6616:	0fe0           	bset d7,-(a0)
    6618:	00ff           	.short 0x00ff
    661a:	f800 0000      	tblu.b d0,d0,d0
    661e:	0000 3fff      	ori.b #-1,d0
    6622:	f800 0000      	tblu.b d0,d0,d0
    6626:	ffff           	.short 0xffff
    6628:	fff8           	.short 0xfff8
    662a:	1fc0           	.short 0x1fc0
    662c:	007f           	.short 0x007f
    662e:	fc00 0000      	cp0nop #1
    6632:	0000 0fff      	ori.b #-1,d0
    6636:	fe00 0000      	cp1nop #1
    663a:	ffff           	.short 0xffff
    663c:	ff80 3fc0      	cp1st.l d3,d0,#8,#448
    6640:	007f           	.short 0x007f
    6642:	fc00 0000      	cp0nop #1
    6646:	0000 07ff      	ori.b #-1,d0
    664a:	ff00 0000      	cp1st.b d0,d0,#1,#0
    664e:	ffff           	.short 0xffff
    6650:	f800           	.short 0xf800
    6652:	3fc0           	.short 0x3fc0
    6654:	003f           	.short 0x003f
    6656:	fc00 0000      	cp0nop #1
    665a:	0000 01ff      	ori.b #-1,d0
    665e:	ffc0           	.short 0xffc0
    6660:	0000 ffff      	ori.b #-1,d0
    6664:	8000           	or.b d0,d0
    6666:	7fc0           	mvz.w d0,d7
    6668:	003f           	.short 0x003f
    666a:	fc00 0000      	cp0nop #1
    666e:	0000 00ff      	ori.b #-1,d0
    6672:	fff0           	.short 0xfff0
    6674:	0000 fff8      	ori.b #-8,d0
    6678:	0000 ffc0      	ori.b #-64,d0
    667c:	001f fc00      	ori.b #0,(sp)+
    6680:	0000 0000      	ori.b #0,d0
    6684:	003f           	.short 0x003f
    6686:	fffc           	.short 0xfffc
    6688:	0000 ff80      	ori.b #-128,d0
    668c:	0001 ff80      	ori.b #-128,d1
    6690:	001f fe00      	ori.b #0,(sp)+
    6694:	0000 0000      	ori.b #0,d0
    6698:	001f ffff      	ori.b #-1,(sp)+
    669c:	0000 f000      	ori.b #0,d0
    66a0:	0003 ff80      	ori.b #-128,d3
    66a4:	000f           	.short 0x000f
    66a6:	fe00 0000      	cp1nop #1
    66aa:	0000 0007      	ori.b #7,d0
    66ae:	ffff           	.short 0xffff
    66b0:	c000           	and.b d0,d0
    66b2:	0000 0007      	ori.b #7,d0
    66b6:	ff80 000f      	cp1st.l d0,d0,#1,#15
    66ba:	fe00 0000      	cp1nop #1
    66be:	0000 0003      	ori.b #3,d0
    66c2:	ffff           	.short 0xffff
    66c4:	f000           	.short 0xf000
    66c6:	0000 000f      	ori.b #15,d0
    66ca:	ff00 0007      	cp1st.b d0,d0,#1,#7
    66ce:	fe00 0000      	cp1nop #1
    66d2:	0000 0001      	ori.b #1,d0
    66d6:	ffff           	.short 0xffff
    66d8:	fc00 0000      	cp0nop #1
    66dc:	003f           	.short 0x003f
    66de:	ff00 0007      	cp1st.b d0,d0,#1,#7
    66e2:	fe00 0000      	cp1nop #1
    66e6:	0000 0000      	ori.b #0,d0
    66ea:	7fff           	.short 0x7fff
    66ec:	ff80 0000      	cp1st.l d0,d0,#1,#0
    66f0:	00ff           	.short 0x00ff
    66f2:	fe00 0003      	cp1ld.b d0,d0,#1,#3
    66f6:	fe00 0000      	cp1nop #1
    66fa:	0000 0000      	ori.b #0,d0
    66fe:	3fff           	.short 0x3fff
    6700:	fff0           	.short 0xfff0
    6702:	0000 03ff      	ori.b #-1,d0
    6706:	fc00 0003      	cp0ld.b d0,d0,#1,#3
    670a:	fe00 0000      	cp1nop #1
    670e:	0000 0000      	ori.b #0,d0
    6712:	0fff           	.short 0x0fff
    6714:	fffc           	.short 0xfffc
    6716:	0000 0fff      	ori.b #-1,d0
    671a:	f800 0001      	tblu.b d0,d1,d0
    671e:	fe00 0000      	cp1nop #1
    6722:	0000 0000      	ori.b #0,d0
    6726:	07ff           	.short 0x07ff
    6728:	ffff           	.short 0xffff
    672a:	8000           	or.b d0,d0
    672c:	3fff           	.short 0x3fff
    672e:	f000           	.short 0xf000
    6730:	0001 fe00      	ori.b #0,d1
    6734:	0000 0000      	ori.b #0,d0
    6738:	0000 01ff      	ori.b #-1,d0
    673c:	ffff           	.short 0xffff
    673e:	fc03 ffff      	cp0ld.b d3,sp,#8,#511
    6742:	e000           	asr.b #8,d0
    6744:	0000 fe00      	ori.b #0,d0
    6748:	0000 0000      	ori.b #0,d0
    674c:	0000 007f      	ori.b #127,d0
    6750:	ffff           	.short 0xffff
    6752:	ffff           	.short 0xffff
    6754:	ffff           	.short 0xffff
    6756:	c000           	and.b d0,d0
    6758:	0000 fe00      	ori.b #0,d0
    675c:	0000 0000      	ori.b #0,d0
    6760:	0000 001f      	ori.b #31,d0
    6764:	ffff           	.short 0xffff
    6766:	ffff           	.short 0xffff
    6768:	ffff           	.short 0xffff
    676a:	8000           	or.b d0,d0
    676c:	0000 7e00      	ori.b #0,d0
    6770:	0000 0000      	ori.b #0,d0
    6774:	0000 0007      	ori.b #7,d0
    6778:	ffff           	.short 0xffff
    677a:	ffff           	.short 0xffff
    677c:	ffff           	.short 0xffff
    677e:	0000 0000      	ori.b #0,d0
    6782:	7e00           	moveq #0,d7
    6784:	0000 0000      	ori.b #0,d0
    6788:	0000 0001      	ori.b #1,d0
    678c:	ffff           	.short 0xffff
    678e:	ffff           	.short 0xffff
    6790:	fffe           	.short 0xfffe
    6792:	0000 0000      	ori.b #0,d0
    6796:	3e00           	move.w d0,d7
	...
    67a0:	7fff           	.short 0x7fff
    67a2:	ffff           	.short 0xffff
    67a4:	fffc           	.short 0xfffc
    67a6:	0000 0000      	ori.b #0,d0
    67aa:	3e00           	move.w d0,d7
	...
    67b4:	1fff           	.short 0x1fff
    67b6:	ffff           	.short 0xffff
    67b8:	fff0           	.short 0xfff0
    67ba:	0000 0000      	ori.b #0,d0
    67be:	1e00           	move.b d0,d7
	...
    67c8:	03ff           	.short 0x03ff
    67ca:	ffff           	.short 0xffff
    67cc:	ffc0           	.short 0xffc0
    67ce:	0000 0000      	ori.b #0,d0
    67d2:	1e00           	move.b d0,d7
	...
    67dc:	007f           	.short 0x007f
    67de:	ffff           	.short 0xffff
    67e0:	ff00 0000      	cp1st.b d0,d0,#1,#0
    67e4:	0000 0e00      	ori.b #0,d0
	...
    67f0:	001f ffff      	ori.b #-1,(sp)+
    67f4:	fc00 0000      	cp0nop #1
    67f8:	0000 0e00      	ori.b #0,d0
	...
    6804:	0003 ffff      	ori.b #-1,d3
    6808:	f000           	.short 0xf000
	...
    681a:	1fff           	.short 0x1fff
	...
