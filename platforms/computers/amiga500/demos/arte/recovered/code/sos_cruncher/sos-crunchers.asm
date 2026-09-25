Disassembly of section .data:

00c02380 <.data+0x2380>:
  c02380:	3401           	move.w d1,d2
  c02382:	5741           	subq.w #3,d1
  c02384:	6618           	bne.s 0xc0239e
  c02386:	6130           	bsr.s 0xc023b8
  c02388:	6502           	bcs.s 0xc0238c
  c0238a:	7007           	moveq #7,d0
  c0238c:	5340           	subq.w #1,d0
  c0238e:	617e           	bsr.s 0xc0240e
  c02390:	3601           	move.w d1,d3
  c02392:	6100 0052      	bsr.w 0xc023e6
  c02396:	d441           	add.w d1,d2
  c02398:	5f41           	subq.w #7,d1
  c0239a:	67f6           	beq.s 0xc02392
  c0239c:	6006           	bra.s 0xc023a4
  c0239e:	5340           	subq.w #1,d0
  c023a0:	616c           	bsr.s 0xc0240e
  c023a2:	3601           	move.w d1,d3
  c023a4:	1331 3000      	move.b (0,a1,d3.w),-(a1)
  c023a8:	1331 3000      	move.b (0,a1,d3.w),-(a1)
  c023ac:	51ca fffa      	dbf d2,0xc023a8
  c023b0:	b5c9           	cmpa.l a1,a2
  c023b2:	6500 ffa0      	bcs.w 0xc02354
  c023b6:	4e75           	rts
  c023b8:	5347           	subq.w #1,d7
  c023ba:	6704           	beq.s 0xc023c0
  c023bc:	e24d           	lsr.w #1,d5
  c023be:	4e75           	rts
  c023c0:	3205           	move.w d5,d1
  c023c2:	7e10           	moveq #16,d7
  c023c4:	3a20           	move.w -(a0),d5
  c023c6:	e249           	lsr.w #1,d1
  c023c8:	4e75           	rts
  c023ca:	7201           	moveq #1,d1
  c023cc:	c245           	and.w d5,d1
  c023ce:	e24d           	lsr.w #1,d5
  c023d0:	5347           	subq.w #1,d7
  c023d2:	6604           	bne.s 0xc023d8
  c023d4:	7e10           	moveq #16,d7
  c023d6:	3a20           	move.w -(a0),d5
  c023d8:	e24d           	lsr.w #1,d5
  c023da:	d341           	addx.w d1,d1
  c023dc:	5347           	subq.w #1,d7
  c023de:	66e8           	bne.s 0xc023c8
  c023e0:	7e10           	moveq #16,d7
  c023e2:	3a20           	move.w -(a0),d5
  c023e4:	4e75           	rts
  c023e6:	7201           	moveq #1,d1
  c023e8:	c245           	and.w d5,d1
  c023ea:	e24d           	lsr.w #1,d5
  c023ec:	5347           	subq.w #1,d7
  c023ee:	6604           	bne.s 0xc023f4
  c023f0:	7e10           	moveq #16,d7
  c023f2:	3a20           	move.w -(a0),d5
  c023f4:	e24d           	lsr.w #1,d5
  c023f6:	d341           	addx.w d1,d1
  c023f8:	5347           	subq.w #1,d7
  c023fa:	6604           	bne.s 0xc02400
  c023fc:	7e10           	moveq #16,d7
  c023fe:	3a20           	move.w -(a0),d5
  c02400:	e24d           	lsr.w #1,d5
  c02402:	d341           	addx.w d1,d1
  c02404:	5347           	subq.w #1,d7
  c02406:	66c0           	bne.s 0xc023c8
  c02408:	7e10           	moveq #16,d7
  c0240a:	3a20           	move.w -(a0),d5
  c0240c:	4e75           	rts
  c0240e:	7200           	moveq #0,d1
  c02410:	e24d           	lsr.w #1,d5
  c02412:	d341           	addx.w d1,d1
  c02414:	5307           	subq.b #1,d7
  c02416:	57c8 fff8      	dbeq d0,0xc02410
  c0241a:	66ac           	bne.s 0xc023c8
  c0241c:	7e10           	moveq #16,d7
  c0241e:	3a20           	move.w -(a0),d5
  c02420:	51c8 ffee      	dbf d0,0xc02410
  c02424:	4e75           	rts
  c02426:	48e7 3c38      	movem.l d2-d5/a2-a4,-(sp)
  c0242a:	2648           	movea.l a0,a3
  c0242c:	2848           	movea.l a0,a4
  c0242e:	0c98 494d 5021 	cmpi.l #1229803553,(a0)+
  c02434:	663e           	bne.s 0xc02474
  c02436:	d9d8           	adda.l (a0)+,a4
  c02438:	d7d8           	adda.l (a0)+,a3
  c0243a:	244b           	movea.l a3,a2
  c0243c:	211a           	move.l (a2)+,-(a0)
  c0243e:	211a           	move.l (a2)+,-(a0)
  c02440:	211a           	move.l (a2)+,-(a0)
  c02442:	241a           	move.l (a2)+,d2
  c02444:	361a           	move.w (a2)+,d3
  c02446:	6b02           	bmi.s 0xc0244a
  c02448:	538b           	subq.l #1,a3
  c0244a:	4fef ffe4      	lea -28(sp),sp
  c0244e:	224f           	movea.l sp,a1
  c02450:	7006           	moveq #6,d0
  c02452:	22da           	move.l (a2)+,(a1)+
  c02454:	51c8 fffc      	dbf d0,0xc02452
  c02458:	224f           	movea.l sp,a1
  c0245a:	7800           	moveq #0,d4
  c0245c:	4a82           	tst.l d2
  c0245e:	6706           	beq.s 0xc02466
  c02460:	1923           	move.b -(a3),-(a4)
  c02462:	5382           	subq.l #1,d2
  c02464:	66fa           	bne.s 0xc02460
  c02466:	b1cc           	cmpa.l a4,a0
  c02468:	6514           	bcs.s 0xc0247e
  c0246a:	4fef 001c      	lea 28(sp),sp
  c0246e:	70ff           	moveq #-1,d0
  c02470:	b1cb           	cmpa.l a3,a0
  c02472:	6702           	beq.s 0xc02476
  c02474:	7000           	moveq #0,d0
  c02476:	4cdf 1c3c      	movem.l (sp)+,d2-d5/a2-a4
  c0247a:	4a80           	tst.l d0
  c0247c:	4e75           	rts
  c0247e:	d603           	add.b d3,d3
  c02480:	6604           	bne.s 0xc02486
  c02482:	1623           	move.b -(a3),d3
  c02484:	d703           	addx.b d3,d3
  c02486:	6464           	bcc.s 0xc024ec
  c02488:	d603           	add.b d3,d3
  c0248a:	6604           	bne.s 0xc02490
  c0248c:	1623           	move.b -(a3),d3
  c0248e:	d703           	addx.b d3,d3
  c02490:	6454           	bcc.s 0xc024e6
  c02492:	d603           	add.b d3,d3
  c02494:	6604           	bne.s 0xc0249a
  c02496:	1623           	move.b -(a3),d3
  c02498:	d703           	addx.b d3,d3
  c0249a:	6444           	bcc.s 0xc024e0
  c0249c:	d603           	add.b d3,d3
  c0249e:	6604           	bne.s 0xc024a4
  c024a0:	1623           	move.b -(a3),d3
  c024a2:	d703           	addx.b d3,d3
  c024a4:	6434           	bcc.s 0xc024da
  c024a6:	d603           	add.b d3,d3
  c024a8:	6604           	bne.s 0xc024ae
  c024aa:	1623           	move.b -(a3),d3
  c024ac:	d703           	addx.b d3,d3
  c024ae:	6406           	bcc.s 0xc024b6
  c024b0:	1823           	move.b -(a3),d4
  c024b2:	7003           	moveq #3,d0
  c024b4:	603a           	bra.s 0xc024f0
  c024b6:	d603           	add.b d3,d3
  c024b8:	6604           	bne.s 0xc024be
  c024ba:	1623           	move.b -(a3),d3
  c024bc:	d703           	addx.b d3,d3
  c024be:	d904           	addx.b d4,d4
  c024c0:	d603           	add.b d3,d3
  c024c2:	6604           	bne.s 0xc024c8
  c024c4:	1623           	move.b -(a3),d3
  c024c6:	d703           	addx.b d3,d3
  c024c8:	d904           	addx.b d4,d4
  c024ca:	d603           	add.b d3,d3
  c024cc:	6604           	bne.s 0xc024d2
  c024ce:	1623           	move.b -(a3),d3
  c024d0:	d703           	addx.b d3,d3
  c024d2:	d904           	addx.b d4,d4
  c024d4:	5c04           	addq.b #6,d4
  c024d6:	7003           	moveq #3,d0
  c024d8:	6016           	bra.s 0xc024f0
  c024da:	7805           	moveq #5,d4
  c024dc:	7003           	moveq #3,d0
  c024de:	6010           	bra.s 0xc024f0
  c024e0:	7804           	moveq #4,d4
  c024e2:	7002           	moveq #2,d0
  c024e4:	600a           	bra.s 0xc024f0
  c024e6:	7803           	moveq #3,d4
  c024e8:	7001           	moveq #1,d0
  c024ea:	6004           	bra.s 0xc024f0
  c024ec:	7802           	moveq #2,d4
  c024ee:	7000           	moveq #0,d0
  c024f0:	7a00           	moveq #0,d5
  c024f2:	3200           	move.w d0,d1
  c024f4:	d603           	add.b d3,d3
  c024f6:	6604           	bne.s 0xc024fc
  c024f8:	1623           	move.b -(a3),d3
  c024fa:	d703           	addx.b d3,d3
  c024fc:	6416           	bcc.s 0xc02514
  c024fe:	d603           	add.b d3,d3
  c02500:	6604           	bne.s 0xc02506
  c02502:	1623           	move.b -(a3),d3
  c02504:	d703           	addx.b d3,d3
  c02506:	6408           	bcc.s 0xc02510
  c02508:	1a3b 006a      	move.b (0xc02574,pc,d0.w),d5
  c0250c:	5000           	addq.b #8,d0
  c0250e:	6004           	bra.s 0xc02514
  c02510:	7a02           	moveq #2,d5
  c02512:	5800           	addq.b #4,d0
  c02514:	103b 0062      	move.b (0xc02578,pc,d0.w),d0
  c02518:	d603           	add.b d3,d3
  c0251a:	6604           	bne.s 0xc02520
  c0251c:	1623           	move.b -(a3),d3
  c0251e:	d703           	addx.b d3,d3
  c02520:	d542           	addx.w d2,d2
  c02522:	5300           	subq.b #1,d0
  c02524:	66f2           	bne.s 0xc02518
  c02526:	d445           	add.w d5,d2
  c02528:	7a00           	moveq #0,d5
  c0252a:	2445           	movea.l d5,a2
  c0252c:	3001           	move.w d1,d0
  c0252e:	d603           	add.b d3,d3
  c02530:	6604           	bne.s 0xc02536
  c02532:	1623           	move.b -(a3),d3
  c02534:	d703           	addx.b d3,d3
  c02536:	641a           	bcc.s 0xc02552
  c02538:	d241           	add.w d1,d1
  c0253a:	d603           	add.b d3,d3
  c0253c:	6604           	bne.s 0xc02542
  c0253e:	1623           	move.b -(a3),d3
  c02540:	d703           	addx.b d3,d3
  c02542:	6408           	bcc.s 0xc0254c
  c02544:	3471 1008      	movea.w (8,a1,d1.w),a2
  c02548:	5000           	addq.b #8,d0
  c0254a:	6006           	bra.s 0xc02552
  c0254c:	3471 1000      	movea.w (0,a1,d1.w),a2
  c02550:	5800           	addq.b #4,d0
  c02552:	1031 0010      	move.b (16,a1,d0.w),d0
  c02556:	d603           	add.b d3,d3
  c02558:	6604           	bne.s 0xc0255e
  c0255a:	1623           	move.b -(a3),d3
  c0255c:	d703           	addx.b d3,d3
  c0255e:	db85           	addx.l d5,d5
  c02560:	5300           	subq.b #1,d0
  c02562:	66f2           	bne.s 0xc02556
  c02564:	524a           	addq.w #1,a2
  c02566:	d5c5           	adda.l d5,a2
  c02568:	d5cc           	adda.l a4,a2
  c0256a:	1922           	move.b -(a2),-(a4)
  c0256c:	5304           	subq.b #1,d4
  c0256e:	66fa           	bne.s 0xc0256a
  c02570:	6000 feea      	bra.w 0xc0245c
  c02574:	060a           	.short 0x060a
  c02576:	0a12 0101      	eori.b #1,(a2)
  c0257a:	0101           	btst d0,d1
  c0257c:	0203 0304      	andi.b #4,d3
  c02580:	0405 070e      	subi.b #14,d5
  c02584:	48e7 fffe      	movem.l d0-a6,-(sp)
  c02588:	2018           	move.l (a0)+,d0
  c0258a:	4bfa 0026      	lea 0xc025b2(pc),a5
  c0258e:	b0bc 4372 4d21 	cmp.l #1131564321,d0
  c02594:	670c           	beq.s 0xc025a2
  c02596:	4bfa 0112      	lea 0xc026aa(pc),a5
  c0259a:	b0bc 4372 4d32 	cmp.l #1131564338,d0
  c025a0:	660a           	bne.s 0xc025ac
  c025a2:	4a58           	tst.w (a0)+
  c025a4:	2218           	move.l (a0)+,d1
  c025a6:	2418           	move.l (a0)+,d2
  c025a8:	2448           	movea.l a0,a2
  c025aa:	4e95           	jsr (a5)
  c025ac:	4cdf 7fff      	movem.l (sp)+,d0-a6
  c025b0:	4e75           	rts
  c025b2:	2a49           	movea.l a1,a5
  c025b4:	d3c1           	adda.l d1,a1
  c025b6:	d5c2           	adda.l d2,a2
  c025b8:	3022           	move.w -(a2),d0
  c025ba:	2c22           	move.l -(a2),d6
  c025bc:	7e10           	moveq #16,d7
  c025be:	9e40           	sub.w d0,d7
  c025c0:	eeae           	lsr.l d7,d6
  c025c2:	3e00           	move.w d0,d7
  c025c4:	5347           	subq.w #1,d7
  c025c6:	7611           	moveq #17,d3
  c025c8:	7800           	moveq #0,d4
  c025ca:	b3cd           	cmpa.l a5,a1
  c025cc:	6fff 0000 00da 	ble.l 0xc026a8
  c025d2:	617e           	bsr.s 0xc02652
  c025d4:	6420           	bcc.s 0xc025f6
  c025d6:	7800           	moveq #0,d4
  c025d8:	7208           	moveq #8,d1
  c025da:	6100 008e      	bsr.w 0xc0266a
  c025de:	1300           	move.b d0,-(a1)
  c025e0:	51cc fff6      	dbf d4,0xc025d8
  c025e4:	60e4           	bra.s 0xc025ca
  c025e6:	780e           	moveq #14,d4
  c025e8:	7205           	moveq #5,d1
  c025ea:	6166           	bsr.s 0xc02652
  c025ec:	6502           	bcs.s 0xc025f0
  c025ee:	720e           	moveq #14,d1
  c025f0:	6178           	bsr.s 0xc0266a
  c025f2:	d840           	add.w d0,d4
  c025f4:	60e2           	bra.s 0xc025d8
  c025f6:	615a           	bsr.s 0xc02652
  c025f8:	6506           	bcs.s 0xc02600
  c025fa:	7201           	moveq #1,d1
  c025fc:	7801           	moveq #1,d4
  c025fe:	6018           	bra.s 0xc02618
  c02600:	6150           	bsr.s 0xc02652
  c02602:	6506           	bcs.s 0xc0260a
  c02604:	7202           	moveq #2,d1
  c02606:	7803           	moveq #3,d4
  c02608:	600e           	bra.s 0xc02618
  c0260a:	6146           	bsr.s 0xc02652
  c0260c:	6506           	bcs.s 0xc02614
  c0260e:	7204           	moveq #4,d1
  c02610:	7807           	moveq #7,d4
  c02612:	6004           	bra.s 0xc02618
  c02614:	7208           	moveq #8,d1
  c02616:	7817           	moveq #23,d4
  c02618:	6150           	bsr.s 0xc0266a
  c0261a:	d840           	add.w d0,d4
  c0261c:	b87c 0016      	cmp.w #22,d4
  c02620:	67c4           	beq.s 0xc025e6
  c02622:	6d02           	blt.s 0xc02626
  c02624:	5344           	subq.w #1,d4
  c02626:	612a           	bsr.s 0xc02652
  c02628:	6506           	bcs.s 0xc02630
  c0262a:	7209           	moveq #9,d1
  c0262c:	7420           	moveq #32,d2
  c0262e:	6010           	bra.s 0xc02640
  c02630:	6120           	bsr.s 0xc02652
  c02632:	6506           	bcs.s 0xc0263a
  c02634:	7205           	moveq #5,d1
  c02636:	7400           	moveq #0,d2
  c02638:	6006           	bra.s 0xc02640
  c0263a:	720e           	moveq #14,d1
  c0263c:	343c 0220      	move.w #544,d2
  c02640:	6128           	bsr.s 0xc0266a
  c02642:	d042           	add.w d2,d0
  c02644:	47f1 0000      	lea (0,a1,d0.w),a3
  c02648:	1323           	move.b -(a3),-(a1)
  c0264a:	51cc fffc      	dbf d4,0xc02648
  c0264e:	6000 ff7a      	bra.w 0xc025ca
  c02652:	51cf 0012      	dbf d7,0xc02666
  c02656:	7e0f           	moveq #15,d7
  c02658:	3006           	move.w d6,d0
  c0265a:	e28e           	lsr.l #1,d6
  c0265c:	4846           	swap d6
  c0265e:	3c22           	move.w -(a2),d6
  c02660:	4846           	swap d6
  c02662:	e248           	lsr.w #1,d0
  c02664:	4e75           	rts
  c02666:	e28e           	lsr.l #1,d6
  c02668:	4e75           	rts
  c0266a:	3006           	move.w d6,d0
  c0266c:	e2ae           	lsr.l d1,d6
  c0266e:	9e41           	sub.w d1,d7
  c02670:	6c12           	bge.s 0xc02684
  c02672:	d241           	add.w d1,d1
  c02674:	c07b 1014      	and.w (0xc0268a,pc,d1.w),d0
  c02678:	de43           	add.w d3,d7
  c0267a:	3222           	move.w -(a2),d1
  c0267c:	efa9           	lsl.l d7,d1
  c0267e:	8c81           	or.l d1,d6
  c02680:	5347           	subq.w #1,d7
  c02682:	4e75           	rts
  c02684:	d241           	add.w d1,d1
  c02686:	c07b 1002      	and.w (0xc0268a,pc,d1.w),d0
  c0268a:	4e75           	rts
  c0268c:	0001 0003      	ori.b #3,d1
  c02690:	0007 000f      	ori.b #15,d7
  c02694:	001f 003f      	ori.b #63,(sp)+
  c02698:	007f           	.short 0x007f
  c0269a:	00ff           	.short 0x00ff
  c0269c:	01ff           	.short 0x01ff
  c0269e:	03ff           	.short 0x03ff
  c026a0:	07ff           	.short 0x07ff
  c026a2:	0fff           	.short 0x0fff
  c026a4:	1fff           	.short 0x1fff
  c026a6:	3fff           	.short 0x3fff
  c026a8:	4e75           	rts
  c026aa:	4dee 0152      	lea 338(a6),a6
  c026ae:	548e           	addq.l #2,a6
  c026b0:	d3c1           	adda.l d1,a1
  c026b2:	d5c2           	adda.l d2,a2
  c026b4:	3022           	move.w -(a2),d0
  c026b6:	2c22           	move.l -(a2),d6
  c026b8:	7e10           	moveq #16,d7
  c026ba:	9e40           	sub.w d0,d7
  c026bc:	eeae           	lsr.l d7,d6
  c026be:	3e00           	move.w d0,d7
  c026c0:	5347           	subq.w #1,d7
  c026c2:	4bf8 0011      	lea 0x11,a5
  c026c6:	41ee 049e      	lea 1182(a6),a0
  c026ca:	740f           	moveq #15,d2
  c026cc:	4298           	clr.l (a0)+
  c026ce:	51ca fffc      	dbf d2,0xc026cc
  c026d2:	41ee 04be      	lea 1214(a6),a0
  c026d6:	49ee 009e      	lea 158(a6),a4
  c026da:	7409           	moveq #9,d2
  c026dc:	6100 0106      	bsr.w 0xc027e4
