Disassembly of section .data:

00000000 <.data>:
   0:	444f           	.short 0x444f
   2:	5300           	subq.b #1,d0
   4:	0b83           	bclr d5,d3
   6:	a8a5 0000      	mac.w d0l,d0l,-(a5),d4
   a:	0370 6022      	bchg d1,(34,a0,d6.w)
   e:	0000 534f      	ori.b #79,d0
  12:	5331 0002      	subq.b #1,(2,a1,d0.w)
  16:	0000 0004      	ori.b #4,d0
	...
  2e:	0000 41f8      	ori.b #-8,d0
  32:	0120           	btst d0,-(a0)
  34:	303c 00b7      	move.w #183,d0
  38:	4298           	clr.l (a0)+
  3a:	51c8 fffc      	dbf d0,0x38
  3e:	43fa 0097      	lea 0xd7(pc),a1
  42:	7000           	moveq #0,d0
  44:	4eae fdd8      	jsr -552(a6)
  48:	2240           	movea.l d0,a1
  4a:	31e9 00a4 02fc 	move.w 164(a1),0x2fc
  50:	4eae fe62      	jsr -414(a6)
  54:	41f8 0200      	lea 0x200,a0
  58:	7070           	moveq #112,d0
  5a:	4298           	clr.l (a0)+
  5c:	51c8 fffc      	dbf d0,0x5a
  60:	203c 0000 2c00 	move.l #11264,d0
  66:	7203           	moveq #3,d1
  68:	2c78 0004      	movea.l 0x4,a6
  6c:	4eae ff3a      	jsr -198(a6)
  70:	2a40           	movea.l d0,a5
  72:	2c78 0004      	movea.l 0x4,a6
  76:	93c9           	suba.l a1,a1
  78:	4eae feda      	jsr -294(a6)
  7c:	43f8 0250      	lea 0x250,a1
  80:	2340 0010      	move.l d0,16(a1)
  84:	4eae fe9e      	jsr -354(a6)
  88:	43f8 0200      	lea 0x200,a1
  8c:	7200           	moveq #0,d1
  8e:	7000           	moveq #0,d0
  90:	41fa 0034      	lea 0xc6(pc),a0
  94:	4eae fe44      	jsr -444(a6)
  98:	43f8 0200      	lea 0x200,a1
  9c:	41f8 0250      	lea 0x250,a0
  a0:	2348 000e      	move.l a0,14(a1)
  a4:	337c 0002 001c 	move.w #2,28(a1)
  aa:	237c 0000 2c00 	move.l #11264,36(a1)
  b0:	0024 
  b2:	234d 0028      	move.l a5,40(a1)
  b6:	42a9 002c      	clr.l 44(a1)
  ba:	4eae fe38      	jsr -456(a6)
  be:	4bed 00e8      	lea 232(a5),a5
  c2:	4eae ffe2      	jsr -30(a6)
  c6:	7472           	moveq #114,d2
  c8:	6163           	bsr.s 0x12d
  ca:	6b64           	bmi.s 0x130
  cc:	6973           	bvs.s 0x141
  ce:	6b2e           	bmi.s 0xfe
  d0:	6465           	bcc.s 0x137
  d2:	7669           	moveq #105,d3
  d4:	6365           	bls.s 0x13b
  d6:	0067 7261      	ori.w #29281,-(sp)
  da:	7068           	moveq #104,d0
  dc:	6963           	bvs.s 0x141
  de:	732e 6c69      	mvs.b 27753(a6),d1
  e2:	6272           	bhi.s 0x156
  e4:	6172           	bsr.s 0x158
  e6:	7900           	mvs.b d0,d4
  e8:	33fc 7fff 00df 	move.w #32767,0xdff09a
  ee:	f09a 
  f0:	33fc 7fff 00df 	move.w #32767,0xdff096
  f6:	f096 
  f8:	43f8 02f8      	lea 0x2f8,a1
  fc:	703d           	moveq #61,d0
  fe:	42a1           	clr.l -(a1)
 100:	51c8 fffc      	dbf d0,0xfe
 104:	41e9 0008      	lea 8(a1),a0
 108:	2c78 0004      	movea.l 0x4,a6
 10c:	246e 0142      	movea.l 322(a6),a2
 110:	7620           	moveq #32,d3
 112:	202a 0014      	move.l 20(a2),d0
 116:	222a 0018      	move.l 24(a2),d1
 11a:	2400           	move.l d0,d2
 11c:	9483           	sub.l d3,d2
 11e:	b48a           	cmp.l a2,d2
 120:	6602           	bne.s 0x124
 122:	3002           	move.w d2,d0
 124:	2401           	move.l d1,d2
 126:	0282 0007 ffff 	andi.l #524287,d2
 12c:	b4bc 0007 e800 	cmp.l #518144,d2
 132:	6606           	bne.s 0x13a
 134:	0681 0000 1800 	addi.l #6144,d1
 13a:	082a 0001 000f 	btst #1,15(a2)
 140:	670a           	beq.s 0x14c
 142:	22fc 0000 0800 	move.l #2048,(a1)+
 148:	22c1           	move.l d1,(a1)+
 14a:	6004           	bra.s 0x150
 14c:	20c0           	move.l d0,(a0)+
 14e:	20c1           	move.l d1,(a0)+
 150:	2452           	movea.l (a2),a2
 152:	4a92           	tst.l (a2)
 154:	66bc           	bne.s 0x112
 156:	0c78 00c0 0208 	cmpi.w #192,0x208
 15c:	4e71           	nop
 15e:	6618           	bne.s 0x178
 160:	4ab8 0210      	tst.l 0x210
 164:	6712           	beq.s 0x178
 166:	4cf8 000f 0208 	movem.l 0x208,d0-d3
 16c:	48f8 0003 0210 	movem.l d0-d1,0x210
 172:	48f8 000c 0208 	movem.l d2-d3,0x208
 178:	4bf8 0200      	lea 0x200,a5
 17c:	4ab8 0208      	tst.l 0x208
 180:	6704           	beq.s 0x186
 182:	4bf8 0208      	lea 0x208,a5
 186:	41f8 0120      	lea 0x120,a0
 18a:	43fa 0014      	lea 0x1a0(pc),a1
 18e:	303c 001d      	move.w #29,d0
 192:	30d9           	move.w (a1)+,(a0)+
 194:	51c8 fffc      	dbf d0,0x192
 198:	43fa 0042      	lea 0x1dc(pc),a1
 19c:	4ef8 0120      	jmp 0x120
 1a0:	2455           	movea.l (a5),a2
 1a2:	45ea 0200      	lea 512(a2),a2
 1a6:	4e62           	move.l a2,usp
 1a8:	45ea 0200      	lea 512(a2),a2
 1ac:	2e4a           	movea.l a2,sp
 1ae:	2078 0204      	movea.l 0x204,a0
 1b2:	43e9 26e4      	lea 9956(a1),a1
 1b6:	303c 09b8      	move.w #2488,d0
 1ba:	2121           	move.l -(a1),-(a0)
 1bc:	51c8 fffc      	dbf d0,0x1ba
 1c0:	224a           	movea.l a2,a1
 1c2:	303c 09b8      	move.w #2488,d0
 1c6:	24d8           	move.l (a0)+,(a2)+
 1c8:	51c8 fffc      	dbf d0,0x1c6
 1cc:	d5fc 0000 0706 	adda.l #1798,a2
 1d2:	2a8a           	move.l a2,(a5)
 1d4:	4e91           	jsr (a1)
 1d6:	4eee ffe2      	jmp -30(a6)
 1da:	0000 4dfa      	ori.b #-6,d0
 1de:	26de           	move.l (a6)+,(a3)+
 1e0:	7000           	moveq #0,d0
 1e2:	4e75           	rts
 1e4:	3d78 02fc 0666 	move.w 0x2fc,1638(a6)
 1ea:	45ee 0042      	lea 66(a6),a2
 1ee:	42aa 0028      	clr.l 40(a2)
 1f2:	42aa 002c      	clr.l 44(a2)
 1f6:	43f8 0200      	lea 0x200,a1
 1fa:	41ea 0020      	lea 32(a2),a0
 1fe:	20d9           	move.l (a1)+,(a0)+
 200:	20d9           	move.l (a1)+,(a0)+
 202:	7403           	moveq #3,d2
 204:	24d9           	move.l (a1)+,(a2)+
 206:	24d9           	move.l (a1)+,(a2)+
 208:	51ca fffa      	dbf d2,0x204
 20c:	4e75           	rts
 20e:	4e71           	nop
 210:	224e           	movea.l a6,a1
 212:	323c 0380      	move.w #896,d1
 216:	7000           	moveq #0,d0
 218:	32c0           	move.w d0,(a1)+
 21a:	51c9 fffc      	dbf d1,0x218
 21e:	6100 0e44      	bsr.w 0x1064
 222:	3d40 064a      	move.w d0,1610(a6)
 226:	46fc 0000      	move.w #0,sr
 22a:	6100 ffb8      	bsr.w 0x1e4
 22e:	6100 0194      	bsr.w 0x3c4
 232:	7008           	moveq #8,d0
 234:	4e4d           	trap #13
 236:	6100 0792      	bsr.w 0x9ca
 23a:	6100 0cce      	bsr.w 0xf0a
 23e:	6100 0394      	bsr.w 0x5d4
 242:	6100 0890      	bsr.w 0xad4
 246:	2d7c 42af d867 	move.l #1118820455,1586(a6)
 24c:	0632 
 24e:	2d7c 7294 bd7f 	move.l #1922350463,1590(a6)
 254:	0636 
 256:	1d7c 0006 0660 	move.b #6,1632(a6)
 25c:	1d7c 0004 0661 	move.b #4,1633(a6)
 262:	41ee 0004      	lea 4(a6),a0
 266:	2d48 0658      	move.l a0,1624(a6)
 26a:	41ee 0042      	lea 66(a6),a0
 26e:	2d48 065c      	move.l a0,1628(a6)
 272:	4eae ffa0      	jsr -96(a6)
 276:	2d6e 0668 0000 	move.l 1640(a6),0(a6)
 27c:	41fa 22a4      	lea 0x2522(pc),a0
 280:	4eae feda      	jsr -294(a6)
 284:	7051           	moveq #81,d0
 286:	4dfa 2634      	lea 0x28bc(pc),a6
 28a:	4eee ff94      	jmp -108(a6)
 28e:	4e75           	rts
 290:	43ee 00de      	lea 222(a6),a1
 294:	700f           	moveq #15,d0
 296:	12d8           	move.b (a0)+,(a1)+
 298:	51c8 fffc      	dbf d0,0x296
 29c:	2d6e 0000 0668 	move.l 0(a6),1640(a6)
 2a2:	4eae ffa6      	jsr -90(a6)
 2a6:	6100 082c      	bsr.w 0xad4
 2aa:	41ee 00de      	lea 222(a6),a0
 2ae:	4eae ffb8      	jsr -72(a6)
 2b2:	4ee8 0006      	jmp 6(a0)
 2b6:	7607           	moveq #7,d3
 2b8:	e998           	rol.l #4,d0
 2ba:	720f           	moveq #15,d1
 2bc:	c240           	and.w d0,d1
 2be:	12fb 1008      	move.b (0x2c8,pc,d1.w),(a1)+
 2c2:	51cb fff4      	dbf d3,0x2b8
 2c6:	4e75           	rts
 2c8:	3031 3233      	move.w (51,a1,d3.w:2),d0
 2cc:	3435 3637      	move.w (55,a5,d3.w:8),d2
 2d0:	3839 4142 4344 	move.w 0x41424344,d4
 2d6:	4546           	.short 0x4546
 2d8:	2f08           	move.l a0,-(sp)
 2da:	41fa 2c62      	lea 0x2f3e(pc),a0
 2de:	48d0 ffff      	movem.l d0-sp,(a0)
 2e2:	215f 0020      	move.l (sp)+,32(a0)
 2e6:	33fc 7fff 00df 	move.w #32767,0xdff09a
 2ec:	f09a 
 2ee:	33fc 7fff 00df 	move.w #32767,0xdff09c
 2f4:	f09c 
 2f6:	33fc e000 00df 	move.w #-8192,0xdff09a
 2fc:	f09a 
 2fe:	2c02           	move.l d2,d6
 300:	2a01           	move.l d1,d5
 302:	2800           	move.l d0,d4
 304:	6100 0842      	bsr.w 0xb48
 308:	4dfa 25b2      	lea 0x28bc(pc),a6
 30c:	42ae 00fe      	clr.l 254(a6)
 310:	4eae ff52      	jsr -174(a6)
 314:	41fa 0008      	lea 0x31e(pc),a0
 318:	21c8 00bc      	move.l a0,0xbc
 31c:	4e4f           	trap #15
 31e:	46fc 0000      	move.w #0,sr
 322:	43fa 2221      	lea 0x2545(pc),a1
 326:	2004           	move.l d4,d0
 328:	6100 ff8c      	bsr.w 0x2b6
 32c:	41fa 21fb      	lea 0x2529(pc),a0
 330:	4eae ff4c      	jsr -180(a6)
 334:	41fa 2245      	lea 0x257b(pc),a0
 338:	0004 0080      	ori.b #-128,d4
 33c:	b818           	cmp.b (a0)+,d4
 33e:	62fc           	bhi.s 0x33c
 340:	1e18           	move.b (a0)+,d7
 342:	4eae ff4c      	jsr -180(a6)
 346:	1207           	move.b d7,d1
 348:	e809           	lsr.b #4,d1
 34a:	671a           	beq.s 0x366
 34c:	2005           	move.l d5,d0
 34e:	6100 0046      	bsr.w 0x396
 352:	4eae ff4c      	jsr -180(a6)
 356:	720f           	moveq #15,d1
 358:	c207           	and.b d7,d1
 35a:	670a           	beq.s 0x366
 35c:	2006           	move.l d6,d0
 35e:	6100 0036      	bsr.w 0x396
 362:	4eae ff4c      	jsr -180(a6)
 366:	41fa 21e8      	lea 0x2550(pc),a0
 36a:	4eae ff4c      	jsr -180(a6)
 36e:	4eae ff40      	jsr -192(a6)
 372:	4a00           	tst.b d0
 374:	67f8           	beq.s 0x36e
 376:	6bf6           	bmi.s 0x36e
 378:	b03c 0064      	cmp.b #100,d0
 37c:	6614           	bne.s 0x392
 37e:	203c 4442 5547 	move.l #1145197895,d0
 384:	4eae fec8      	jsr -312(a6)
 388:	2848           	movea.l a0,a4
 38a:	41ee 0682      	lea 1666(a6),a0
 38e:	4eac ffee      	jsr -18(a4)
 392:	4eee feda      	jmp -294(a6)
 396:	5301           	subq.b #1,d1
 398:	6714           	beq.s 0x3ae
 39a:	5301           	subq.b #1,d1
 39c:	6704           	beq.s 0x3a2
 39e:	202e 0102      	move.l 258(a6),d0
 3a2:	2f08           	move.l a0,-(sp)
 3a4:	2040           	movea.l d0,a0
 3a6:	4eae ff4c      	jsr -180(a6)
 3aa:	205f           	movea.l (sp)+,a0
 3ac:	4e75           	rts
 3ae:	2f08           	move.l a0,-(sp)
 3b0:	43fa 2167      	lea 0x2519(pc),a1
 3b4:	6100 ff00      	bsr.w 0x2b6
 3b8:	41fa 215f      	lea 0x2519(pc),a0
 3bc:	4eae ff4c      	jsr -180(a6)
 3c0:	205f           	movea.l (sp)+,a0
 3c2:	4e75           	rts
 3c4:	0c6e 000a 064a 	cmpi.w #10,1610(a6)
 3ca:	6424           	bcc.s 0x3f0
 3cc:	41fa 0034      	lea 0x402(pc),a0
 3d0:	2008           	move.l a0,d0
 3d2:	41f8 0008      	lea 0x8,a0
 3d6:	722d           	moveq #45,d1
 3d8:	20c0           	move.l d0,(a0)+
 3da:	5480           	addq.l #2,d0
 3dc:	51c9 fffa      	dbf d1,0x3d8
 3e0:	41fa 15e2      	lea 0x19c4(pc),a0
 3e4:	21c8 00b8      	move.l a0,0xb8
 3e8:	21ee 00ee 00b4 	move.l 238(a6),0xb4
 3ee:	4e75           	rts
 3f0:	41fa 00da      	lea 0x4cc(pc),a0
 3f4:	43f8 0008      	lea 0x8,a1
 3f8:	703d           	moveq #61,d0
 3fa:	22c8           	move.l a0,(a1)+
 3fc:	51c8 fffc      	dbf d0,0x3fa
