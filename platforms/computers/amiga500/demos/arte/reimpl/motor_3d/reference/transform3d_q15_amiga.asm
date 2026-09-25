; ============================================================================
; motor_3d/reference/transform3d_q15_amiga.asm
;
; RUTINA ASM CANÓNICA (optimizada) del motor 3D de «Arte» (Sanity, 1993).
; Extraída por ingeniería inversa del bloque 0x0B0C2C (out/modules_all/), NO
; es código fuente redistribuido del autor: es el desensamblado del binario.
;
; Esta es la versión "crítica" a preservar: la aritmética Q15 con `muls.w` +
; `add.l d,d` + `swap` (2 instrucciones de 16 bits por producto) es la que el
; autor consideró "la rutina más optimizada". Se usa como referencia canónica
; para el port y (si hace falta) para las partes críticas.
;
; Base relativa 0x0 (el bloque se carga en una dirección arbitraria).
; A0 = puntero de destino (matriz de 9 words), A1 = tabla de seno/coseno.
; ============================================================================

; --- 0x0C16: construcción de la matriz de rotación (R = Rx(a)*Ry(b)*Rz(c)) ---
; Entradas: d5, d6, d7 = índices de los 3 ángulos (máscara 0x7FE = 1024 entradas)
;           $1056 = tabla de senos ; $1256 = tabla de cosenos (= +0x200, 1/4)
; Salidas:  9 words en (a0)+ (column-major de R)
;
; Carga sin/cos:
;   d0 = sin(a)  d1 = sin(b)  d2 = sin(c)
;   d3 = cos(a)  d4 = cos(b)  d5 = cos(c)

00C16  move.w #$7fe, d0
00C1A  and.w  d0, d5
00C1C  and.w  d0, d6
00C1E  and.w  d0, d7
00C20  lea.l  $1056.l, a1
00C26  move.w (a1, d5.w), d0        ; d0 = sin(a)
00C2A  move.w (a1, d6.w), d1        ; d1 = sin(b)
00C2E  move.w (a1, d7.w), d2        ; d2 = sin(c)
00C32  lea.l  $1256.l, a1
00C38  move.w (a1, d5.w), d3        ; d3 = cos(a)
00C3C  move.w (a1, d6.w), d4        ; d4 = cos(b)
00C40  move.w (a1, d7.w), d5        ; d5 = cos(c)

; --- m[0] = Q15(cos(b)*cos(c)) ---
00C44  move.w d4, d6
00C46  muls.w d5, d6                ; d6 = cos(b)*cos(c)
00C48  add.l  d6, d6                ; *2
00C4A  swap   d6                    ; >>16 (Q15)
00C4C  move.w d6, (a0)+             ; m[0]

; --- m[1] = Q15( sin(a)*Q15(sin(b)*cos(c)) + cos(a)*sin(c) ) ---
00C4E  move.w d1, d6
00C50  muls.w d5, d6                ; d6 = sin(b)*cos(c)
00C52  add.l  d6, d6
00C54  swap   d6                    ; Q15(sin(b)*cos(c))
00C56  movea.w d6, a1               ; a1 = Q15(sin(b)*cos(c))
00C58  muls.w d0, d6                ; d6 = sin(a)*a1
00C5A  move.w d2, d7
00C5C  muls.w d3, d7                ; d7 = cos(a)*sin(c)
00C5E  add.l  d6, d7
00C60  add.l  d7, d7
00C62  swap   d7
00C64  move.w d7, (a0)+             ; m[1]

; --- m[2] = Q15( sin(a)*sin(c) - cos(a)*Q15(sin(b)*cos(c)) ) ---
00C66  move.w a1, d6
00C68  muls.w d3, d6                ; d6 = cos(a)*a1
00C6A  move.w d2, d7
00C6C  muls.w d0, d7                ; d7 = sin(a)*sin(c)
00C6E  sub.l  d6, d7
00C70  add.l  d7, d7
00C72  swap   d7
00C74  move.w d7, (a0)+             ; m[2]

; --- m[3] = Q15(-cos(b)*sin(c)) ---
00C76  move.w d2, d6
00C78  neg.w  d6
00C7A  muls.w d4, d6                ; d6 = -cos(b)*sin(c)
00C7C  add.l  d6, d6
00C7E  swap   d6
00C80  move.w d6, (a0)+             ; m[3]

; --- m[4] = Q15( cos(a)*cos(c) - sin(a)*Q15(sin(b)*sin(c)) ) ---
00C82  muls.w d1, d2                ; d2 = sin(b)*sin(c)
00C84  add.l  d2, d2
00C86  swap   d2                    ; Q15(sin(b)*sin(c))
00C88  move.w d2, d7
00C8A  muls.w d0, d2                ; d2 = sin(a)*Q15(sin(b)*sin(c))
00C8C  move.w d5, d6
00C8E  muls.w d3, d6                ; d6 = cos(a)*cos(c)
00C90  sub.l  d2, d6
00C92  add.l  d6, d6
00C94  swap   d6
00C96  move.w d6, (a0)+             ; m[4]

; --- m[5] = Q15( cos(a)*Q15(sin(b)*sin(c)) + sin(a)*cos(c) ) ---
00C98  muls.w d3, d7                ; d7 = cos(a)*Q15(sin(b)*sin(c))
00C9A  muls.w d0, d5                ; d5 = sin(a)*cos(c)
00C9C  add.l  d7, d5
00C9E  add.l  d5, d5
00CA0  swap   d5
00CA2  move.w d5, (a0)+             ; m[5]

; --- m[6] = sin(b) ---
00CA4  move.w d1, (a0)+             ; m[6]

; --- m[7] = Q15(-cos(b)*sin(a)) ---
00CA6  neg.w  d0
00CA8  muls.w d4, d0                ; d0 = -cos(b)*sin(a)
00CAA  add.l  d0, d0
00CAC  swap   d0
00CAE  move.w d0, (a0)+             ; m[7]

; --- m[8] = Q15(cos(b)*cos(a)) ---
00CB0  muls.w d4, d3                ; d3 = cos(b)*cos(a)
00CB2  add.l  d3, d3
00CB4  swap   d3
00CB6  move.w d3, (a0)              ; m[8]
00CB8  rts

; ============================================================================
; --- 0x0CBA: transformación de un punto  (a0)=punto, (a1)=matriz, (a2)=salida
;     X' = Q15( m[0]*x + m[3]*y + m[6]*z )
;     Y' = Q15( m[1]*x + m[4]*y + m[7]*z )
;     Z' = Q15( m[2]*x + m[5]*y + m[8]*z )
; La suma de los 3 productos se acumula en 32 bits y se hace UN solo >>15.
; ============================================================================

00CBA  movem.w (a0)+, d0-d2         ; d0=x, d1=y, d2=z
00CBE  move.w (a1), d3              ; m[0]
00CC0  move.w $6(a1), d4            ; m[3]
00CC4  move.w $c(a1), d5            ; m[6]
00CC8  muls.w d0, d3
00CCA  muls.w d1, d4
00CCC  muls.w d2, d5
00CCE  add.l  d3, d4
00CD0  add.l  d4, d5
00CD2  add.l  d5, d5
00CD4  swap   d5
00CD6  move.w d5, (a2)+             ; X'
00CD8  move.w $2(a1), d3            ; m[1]
00CDC  move.w $8(a1), d4            ; m[4]
00CE0  move.w $e(a1), d5            ; m[7]
00CE4  muls.w d0, d3
00CE6  muls.w d1, d4
00CE8  muls.w d2, d5
00CEA  add.l  d3, d4
00CEC  add.l  d4, d5
00CEE  add.l  d5, d5
00CF0  swap   d5
00CF2  move.w d5, (a2)+             ; Y'
00CF4  muls.w $4(a1), d0            ; m[2]*x
00CF8  muls.w $a(a1), d1            ; m[5]*y
00CFC  muls.w $10(a1), d2           ; m[8]*z
00D00  add.l  d1, d0
00D02  add.l  d2, d0
00D04  add.l  d0, d0
00D06  swap   d0
00D08  move.w d0, (a2)+             ; Z'
; (sigue la construcción de la matriz ortonormal por cross-product, 0x0E1E)

; ============================================================================
; NOTA: esta rutina se conserva como REFERENCIA CANÓNICA. Para el port a C++,
; ver src/transform3d.cpp (implementación de referencia equivalente). Si se
; necesita el rendimiento del original en 68000, esta es la versión a usar
; (inline asm o traducción literal).
; ============================================================================