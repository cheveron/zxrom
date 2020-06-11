;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $0095
token_table:
	defb '?' + $80;						// 
	defb "RN", 'D' + $80;				// 
	defb "INKEY", '$' + $80;			// 
	defb 'P', 'I' + $80;				// 
	defb 'F', 'N' + $80;				// 
	defb "POIN", 'T' + $80;				// 
	defb "SCREEN", '$' + $80;			// 
	defb "ATT", 'R' + $80;				// 
	defb 'A', 'T' + $80;				// 
	defb "TA", 'B' + $80;				// 
	defb "VAL", '$' + $80;				// 
	defb "COD", 'E' + $80;				// 
	defb "VA", 'L' + $80;				// 
	defb "LE", 'N' + $80;				// 
	defb "SI", 'N' + $80;				// 
	defb "CO", 'S' + $80;				// 
	defb "TA", 'N' + $80;				// 
	defb "AS", 'N' + $80;				// 
	defb "AC", 'S' + $80;				// 
	defb "AT", 'N' + $80;				// 
	defb 'L', 'N' + $80;				// 
	defb "EX", 'P' + $80;				// 
	defb "IN", 'T' + $80;				// 
	defb "SQ", 'R' + $80;				// 
	defb "SG", 'N' + $80;				// 
	defb "AB", 'S' + $80;				// 
	defb "PEE", 'K' + $80;				// 
	defb 'I', 'N' + $80;				// 
	defb "US", 'R' + $80;				// 
	defb "STR", '$' + $80;				// 
	defb "CHR", '$' + $80;				// 
	defb "NO", 'T' + $80;				// 
	defb "BI", 'N' + $80;				// 
	defb 'O', 'R' + $80;				// 
	defb "AN", 'D' + $80;				// 
	defb '<', '=' + $80;				// 
	defb '>', '=' + $80;				// 
	defb '<', '>' + $80;				// 
	defb "LIN", 'E' + $80;				// 
	defb "THE", 'N' + $80;				// 
	defb 'T', 'O' + $80;				// 
	defb "STE", 'P' + $80;				// 
	defb "DEF F", 'N' + $80;			// 
	defb "CA", 'T' + $80;				// 
	defb "FORMA", 'T' + $80;			// 
	defb "MOV", 'E' + $80;				// 
	defb "ERAS", 'E' + $80;				// 
	defb "OPEN ", '#' + $80;			// 
	defb "CLOSE ", '#' + $80;			// 
	defb "MERG", 'E' + $80;				// 
	defb "VERIF", 'Y' + $80;			// 
	defb "BEE", 'P' + $80;				// 
	defb "CIRCL", 'E' + $80;			// 
	defb "IN", 'K' + $80;				// 
	defb "PAPE", 'R' + $80;				// 
	defb "FLAS", 'H' + $80;				// 
	defb "BRIGH", 'T' + $80;			// 
	defb "INVERS", 'E' + $80;			// 
	defb "OVE", 'R' + $80;				// 
	defb "OU", 'T' + $80;				// 
	defb "LPRIN", 'T' + $80;			// 
	defb "LLIS", 'T' + $80;				// 
	defb "STO", 'P' + $80;				// 
	defb "REA", 'D' + $80;				// 
	defb "DAT", 'A' + $80;				// 
	defb "RESTOR", 'E' + $80;			// 
	defb "NE", 'W' + $80;				// 
	defb "BORDE", 'R' + $80;			// 
	defb "CONTINU", 'E' + $80;			// 
	defb "DI", 'M' + $80;				// 
	defb "RE", 'M' + $80;				// 
	defb "FO", 'R' + $80;				// 
	defb "GO T", 'O' + $80;				// 
	defb "GO SU", 'B' + $80;			// 
	defb "INPU", 'T' + $80;				// 
	defb "LOA", 'D' + $80;				// 
	defb "LIS", 'T' + $80;				// 
	defb "LE", 'T' + $80;				// 
	defb "PAUS", 'E' + $80;				// 
	defb "NEX", 'T' + $80;				// 
	defb "POK", 'E' + $80;				// 
	defb "PRIN", 'T' + $80;				// 
	defb "PLO", 'T' + $80;				// 
	defb "RU", 'N' + $80;				// 
	defb "SAV", 'E' + $80;				// 
	defb "RANDOMIZ", 'E' + $80;			// 
	defb 'I', 'F' + $80;				// 
	defb "CL", 'S' + $80;				// 
	defb "DRA", 'W' + $80;				// 
	defb "CLEA", 'R' + $80;				// 
	defb "RETUR", 'N' + $80;			// 
	defb "COP", 'Y' + $80;				// 

	org $0205
kt_main:
	defb "BHY65TGVNJU74RFCMKI83EDX", ctrl_symbol;								// 
	defb "LO92WSZ ", ctrl_enter, "P01QA";

	org $022c
kt_ext:
	defb tk_read, tk_bin, tk_lprint, tk_data, tk_tan, tk_sgn, tk_abs;								// 
	defb tk_sqr, tk_code, tk_val, tk_len, tk_usr, tk_pi;								// 
	defb tk_inkey_str, tk_peek, tk_tab, tk_sin, tk_int, tk_restore;								// 
	defb tk_rnd, tk_chr_str, tk_llist, tk_cos, tk_exp, tk_str_str;								// 
	defb tk_ln;

	org $0246
kt_ext_shft:
	defb '~', tk_bright, tk_paper, '\\', tk_atn, '{', '}', tk_circle;								// 
	defb tk_in, tk_val_str, tk_screen_str, tk_attr, tk_inverse;								// 
	defb tk_over, tk_out, pchr_copyright, tk_asn, tk_verify, '|';								// 
	defb tk_merge, ']', tk_flash, tk_acs, tk_ink, '[', tk_beep;

	org $0260
kt_dig_shft:
	defb ctrl_delete, ctrl_edit, ctrl_caps, ctrl_true_vid, ctrl_inv_vid;								// 
	defb ctrl_left, ctrl_down, ctrl_up, ctrl_right, ctrl_graphics;

	org $026a
kt_sym:
	defb tk_stop, '*', '?', tk_step, tk_gr_eq, tk_to, tk_then, '^';								// 
	defb tk_at, '-', '+', '=', '.', ',', ';', '"', tk_l_eql, '<';								// 
	defb tk_not, '>', tk_or, '/', tk_neql, pchr_pound, tk_and, ':';

	org $0284
kt_ext_dig_shft:
	defb tk_format, tk_def_fn, tk_fn, tk_line, tk_open, tk_close;								// 
	defb tk_move, tk_erase, tk_point, tk_cat;

	org $028e
key_scan:
	ld l, 47;							// 
	ld de, $ffff;						// 
	ld bc, $fefe;						// 

	org $0296
key_line:
	in a, (c);							// 
	cpl;								// 
	and %00011111;						// 
	jr z, key_done;						// 
	ld h, a;							// 
	ld a, l;							// 

	org $029f
key_3keys:
	inc d;								// 
	ret nz;								// 

	org $02a1
key_bits:
	sub 8;								// 
	srl h;								// 
	jr nc, key_bits;					// 
	ld d, e;							// 
	ld e, a;							// 
	jr nz, key_3keys;					// 

	org $02ab
key_done:
	dec l;								// 
	rlc b;								// 
	jr c, key_line;						// 
	ld a, d;							// 
	inc a;								// 
	ret z;								// 
	cp 40;								// 
	ret z;								// 
	cp 25;								// 
	ret z;								// 
	ld a, e;							// 
	ld e, d;							// 
	ld d, a;							// 
	cp 24;								// 
	ret;								// 

	org $02bf
keyboard:
	call key_scan;						// 
	ret nz;								// 
	ld hl, kstate;						// 

	org $02c6
k_st_loop:
	bit 7, (hl);						// 
	jr nz, k_ch_set;					// 
	inc hl;								// 
	dec (hl);							// 
	dec hl;								// 
	jr nz, k_ch_set;					// 
	ld (hl), 255;						// 

	org $02d1
k_ch_set:
	ld a, l;							// 
	ld hl, kstate_4;					// 
	cp l;								// 
	jr nz, k_st_loop;					// 
	call k_test;						// 
	ret nc;								// 
	ld hl, kstate;						// 
	cp (hl);							// 
	jr z, k_repeat;						// 
	ex de, hl;							// 
	ld hl, kstate_4;					// 
	cp (hl);							// 
	jr z, k_repeat;						// 
	bit 7, (hl);						// 
	jr nz, k_new;						// 
	ex de, hl;							// 
	bit 7, (hl);						// 
	ret z;								// 

	org $02f1
k_new:
	ld e, a;							// 
	ld (hl), a;							// 
	inc hl;								// 
	ld (hl), 5;							// 
	inc hl;								// 
	ld a, (repdel);						// 
	ld (hl), a;							// 
	inc hl;								// 
	ld c, (iy + _mode);					// 
	ld d, (iy + _flags);				// 
	push hl;							// 
	call k_decode;						// 
	pop hl;								// 
	ld (hl), a;							// 

	org $0308
k_end:
	ld (last_k), a;						// 
	set 5, (iy + _flags);				// 
	ret;								// 

	org $0310
k_repeat:
	inc hl;								// 
	ld (hl), 5;							// 
	inc hl;								// 
	dec (hl);							// 
	ret nz;								// 
	ld a, (repper);						// 
	ld (hl), a;							// 
	inc hl;								// 
	ld a, (hl);							// 
	jr k_end;							// 

	org $031e
k_test:
	ld b, d;							// 
	ld d, 0;							// 
	ld a, e;							// 
	cp 39;								// 
	ret nc;								// 
	cp 24;								// 
	jr nz, k_main;						// 
	bit 7, b;							// 
	ret nz;								// 

	org $032c
k_main:
	ld hl, kt_main;						// 
	add hl, de;							// 
	ld a, (hl);							// 
	scf;								// 
	ret;								// 

	org $0333
k_decode:
	ld a, e;							// 
	cp 58;':';							// 
	jr c, k_digit;						// 
	dec c;								// 
	jp m, k_klc_let;					// 
	jr z, k_e_let;						// 
	add a, 79;							// 
	ret;								// 

	org $0341
k_e_let:
	ld hl, kt_ext - 'A';				// 
	inc b;								// 
	jr z, k_look_up;					// 
	ld hl, kt_ext_shft - 'A';			// 

	org $034a
k_look_up:
	ld d, 0;							// 
	add hl, de;							// 
	ld a, (hl);							// 
	ret;								// 

	org $034f
k_klc_let:
	ld hl, kt_sym - 'A';				// 
	bit 0, b;							// 
	jr z, k_look_up;					// 
	bit 3, d;							// 
	jr z, k_tokens;						// 
	bit 3, (iy + _flags2);				// 
	ret nz;								// 
	inc b;								// 
	ret nz;								// 
	add a, 32;							// 
	ret;								// 

	org $0364
k_tokens:
	add a, tk_rnd;						// 
	ret;								// 

	org $0367
k_digit:
	cp 48;'0';							// 
	ret c;								// 
	dec c;								// 
	jp m, k_klc_dgt;					// 
	jr nz, k_gra_dgt;					// 
	ld hl, kt_ext_dig_shft - '0';		// 
	bit 5, b;							// 
	jr z, k_look_up;					// 
	CP 56;'8';							// 
	jr nc, k_8_and_9;					// 
	sub 32;								// 
	inc b;								// 
	ret z;								// 
	add a, 8;							// 
	ret;								// 

	org $0382
k_8_and_9:
	sub 54;								// 
	inc b;								// 
	ret z;								// 
	add a, 254;							// 
	ret;								// 

	org $0389
k_gra_dgt:
	ld hl, kt_dig_shft - '0';			// 
	CP 57;'9';							// 
	jr z, k_look_up;					// 
	cp 48;'0';							// 
	jr z, k_look_up;					// 
	and %00000111;						// 
	add a, $80;							// 
	inc b;								// 
	ret z;								// 
	xor %00001111;						// 
	ret;								// 

	org $039d
k_klc_dgt:
	inc b;								// 
	ret z;								// 
	bit 5, b;							// 
	ld hl, kt_dig_shft - '0';			// 
	jr nz, k_look_up;					// 
	sub 16;								// 
	cp 34;'"';";						//
	jr z, k_at_char;					// 
	cp 32;' ';							// 
	ret nz;								// 
	ld a, '_';							// 
	ret;								//

	org $03b2
k_at_char:
	ld a, '@';							// 
	ret;								// 
