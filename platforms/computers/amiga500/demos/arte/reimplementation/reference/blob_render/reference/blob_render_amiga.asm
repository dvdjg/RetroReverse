; ============================================================================
; blob_render/reference/blob_render_amiga.asm
;
; RUTINA ASM CANONICA (optimizada) del motor de blobs/sprites de «Arte».
; Desensamblado del bloque 0x0B0C2C (out/modules_all/). NO es codigo fuente
; del autor: es el desensamblado del binario, conservado como referencia.
; sha1 del bloque: b37f140c327309db4e8f2894ad100b9018144302
;
; 0x3318-0x3360: construccion de la LUT de expansion en $318dc (RAM).
; 0x336E/0x338E: tablas auxiliares (mascaras / patrones).
; 0x34A0-0x3560: render de blobs (lookup + writes a 3 bitplanes).
; ============================================================================

; --- construccion de la LUT (0x318dc) ---
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

; --- tablas auxiliares ---
; 0x336E (mascaras de N bits): 00 01 00 03 00 07 00 0f 00 1f 00 3f 00 7f 00 ff 01 ff 03 ff 07 ff 0f ff 1f ff 3f ff 7f ff ff ff
; 0x338E (patrones altos):     80 00 c0 00 e0 00 f0 00 f8 00 fc 00 fe 00 ff 00 ff 80 ff c0 ff e0 ff f0 ff f8 ff fc ff fe ff ff

; --- render de blobs (por byte: lookup pixel + lookup mascara -> 3 planos) ---
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