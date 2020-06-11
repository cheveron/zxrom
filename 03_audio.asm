;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $03b5
beeper:
	di;									// 
	ld a, l;							// 
	srl l;								// 
	srl l;								// 
	cpl;								// 
	and %00000011;						// 
	ld c, a;							// 
	ld b, 0;							// 
	ld ix, be_ix_plus_3;				// 
	add ix, bc;							// 
	ld a, (bordcr);						// 
	and %00111000;						// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	or %00001000;						// 

	org $03d1
be_ix_plus_3:
	nop;								// 

	org $03d2
be_ix_plus_2:
	nop;								//

	org $03d3
be_ix_plus_1:
	nop;								//

	org $03d4
be_ix_plus_0:
	inc b;								// 
	inc c;								//

	org $03d6
be_h_and_l_lp:
	dec c;								// 
	jr nz, be_h_and_l_lp;				// 
	ld c, 63;							// 
	dec b;								// 
	jp nz, be_h_and_l_lp;				// 
	xor %00010000;						// 
	out (ula), a;						// 
	ld b, h;							// 
	ld c, a;							// 
	bit 4, a;							// 
	jr nz, be_again;					// 
	ld a, d;							// 
	or e;								// 
	jr z, be_end;						// 
	ld a, c;							// 
	ld c, l;							// 
	dec de;								// 
	jp (ix);							//

	org $03f2
be_again:
	ld c, l;							// 
	inc c;								// 
	jp (ix);							//

	org $03f6
be_end:
	ei;									// 
	ret;								//

	org $03f8
beep:
	fwait;								// 
	fmove;								// 
	fint;								// 
	fst 0;								// 
	fsub;								// 
	fstk;								// 
	defb $ec, $6c, $98, $1f, $f5;		// 
	fmul;								// 
	fstk1;								// 
	fadd;								// 
	fce;								// 
	ld hl, membot;						// 
	ld a, (hl);							// 
	and a;								// 
	jr nz, report_b;					// 
	inc hl;								// 
	ld c, (hl);							// 
	inc hl;								// 
	ld b, (hl);							// 
	ld a, b;							// 
	rla;								// 
	sbc a, a;							// 
	cp c;								// 
	jr nz, report_b;					// 
	inc hl;								// 
	cp (hl);							// 
	jr nz, report_b;					// 
	ld a, b;							// 
	add a, 60;							// 
	jp p, be_i_ok;						// 
	jp po, report_b;					//

	org $0425
be_i_ok:
	ld b, 250;							//

	org $0427
be_octave:
	inc b;								// 
	sub 12;								// 
	jr nc, be_octave;					// 
	add a, 12;							// 
	push bc;							// 
	ld hl, semi_tone;					// 
	call loc_mem;						// 
	call stack_num;						// 
	fwait;								// 
	fmul;								// 
	fce;								// 
	pop af;								// 
	add a, (hl);						// 
	ld (hl), a;							// 
	fwait;								// 
	fst 0;								// 
	fdel;								// 
	fmove;								// 
	fce;								// 
	call find_int1;						// 
	cp 11;								// 
	jr nc, report_b;					// 
	fwait;								// 
	fgt 0;								// 
	fmul;								// 
	fgt 0;								// 
	fstk;								// 
	defb $80, $43, $55, $9f, $80;		// 
	fxch;								// 
	fdiv;								// 
	fstk;								// 
	defb $35, $71;						// 
	fsub;								// 
	fce;								// 
	call find_int2;						// 
	push bc;							// 
	call find_int2;						// 
	pop hl;								// 
	ld d, b;							// 
	ld e, c;							// 
	ld a, d;							// 
	or e;								// 
	ret z;								// 
	dec de;								// 
	jp beeper;							//

	org $046c
report_b:
	rst error;							// 
	defb integer_out_of_range;			//

	org $046e
semi_tone:
	defb $89, $02, $d0, $12, $86;		// 
	defb $89, $0a, $97, $60, $75;		// 
	defb $89, $12, $d5, $17, $1f;		// 
	defb $89, $1b, $90, $41, $02;		// 
	defb $89, $24, $d0, $53, $ca;		// 
	defb $89, $2e, $9d, $36, $b1;		// 
	defb $89, $38, $ff, $49, $3e;		// 
	defb $89, $43, $ff, $6a, $73;		// 
	defb $89, $4f, $a7, $00, $54;		// 
	defb $89, $5c, $00, $00, $00;		// 
	defb $89, $69, $14, $f6, $24;		// 
	defb $89, $76, $f1, $10, $05;		//
