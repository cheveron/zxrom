;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

;	// start
	org $0000
	di;									// 
	xor a;								// 
	ld de, $ffff;						// 
	jp start_new;						// 

;	// error
	org $0008
	ld hl, (ch_add);					// 
	ld (x_ptr), hl;						// 
	jr error_2;							// 

;	// print_a
	org $0010
	jp print_a_2;						// 
	defb $ff, $ff, $ff, $ff, $ff;		// 

;	// get_char
	org $0018
jp_get_char:;							// 
	ld hl, (ch_add);					// 
	ld a, (hl);							// 

	org $001c
test_char:
	call skip_over;						// 
	ret nc;								// 

;	// next_char
	org $0020
	call ch_add_plus_1;					// 
	jr test_char;						// 
	defb $ff, $ff, $ff;					// 

;	// calc
	org $0028
	jp calculate;						// 
	defb $ff, $ff, $ff, $ff, $ff;		// 

;	// bc_spaces
	org $0030
	push bc;							// 
	ld hl, (worksp);					// 
	push hl;							// 
	jp reserve;							// 

;	// mask_int
	org $0038
	push af;							// 
	push hl;							// 
	ld hl, (frames);					// 
	inc hl;								// 
	ld (frames), hl;					// 
	ld a, h;							// 
	or l;								// 
	jr nz, key_int;						// 
	inc (iy + _frames_h);				// 

	org $0048
key_int:
	push bc;							// 
	push de;							// 
	call keyboard;						// 
	pop de;								// 
	pop bc;								// 
	pop hl;								// 
	pop af;								// 
	ei;									// 
	ret;								// 

	org $0053
error_2:
	pop hl;								// 
	ld l, (hl);							// 

	org $0055
error_3:
	ld (iy + _err_nr), l;				// 
	ld sp, (err_sp);					// 
	jp set_stk;							// 
	defb $ff, $ff, $ff, $ff;			// 
	defb $ff, $ff, $ff;					// 

	org $0066
reset:
	push af;							// 
	push hl;							// 
	ld hl, (nmiadd);					// 
	ld a, h;							// 
	or l;								// 
	jr nz, no_reset;					// 
	jp (hl);							// 

	org $0070
no_reset:
	pop hl;								// 
	pop af;								// 
	retn;								// 

	org $0074
ch_add_plus_1:
	ld hl, (ch_add);					//

	org $0077
temp_ptr1:
	inc hl;								//

	org $0078
temp_ptr2:
	ld (ch_add), hl;					// 
	ld a, (hl);							// 
	ret;								//

	org $007d
skip_over:
	cp 33;'!';							// 
	ret nc;								// 
	cp ctrl_enter;						// 
	ret z;								// 
	cp ctrl_ink;						// 
	ret c;								// 
	cp ctrl_tab + 1;					// 
	ccf;								// 
	ret c;								// 
	inc hl;								// 
	cp ctrl_at;							// 
	jr c, skips;						// 
	inc hl;								// 

	org $0090
skips:
	scf;								// 
	ld (ch_add), hl;					// 
	ret;								// 
