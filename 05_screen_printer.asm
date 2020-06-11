;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $09f4
print_out:
	call po_fetch;						// 
	cp 32;' ';							// 
	jp nc, po_able;						// 
	cp 6;								// 
	jr c, po_quest;						// 
	cp 24;								// 
	jr nc, po_quest;					// 
	ld hl, ctlchrtab - 6;				// 
	ld e, a;							// 
	ld d, 0;							// 
	add hl, de;							// 
	ld e, (hl);							// 
	add hl, de;							// 
	push hl;							// 
	jp po_fetch;						//

	org $0a11
ctlchrtab:
	defb po_comma - $;					// 
	defb po_quest - $;					// 
	defb po_back_1 - $;					// 
	defb po_right - $;					// 
	defb po_quest - $;					// 
	defb po_quest - $;					// 
	defb po_quest - $;					// 
	defb po_enter - $;					// 
	defb po_quest - $;					// 
	defb po_quest - $;					// 
	defb po_1_oper - $;					// 
	defb po_1_oper - $;					// 
	defb po_1_oper - $;					// 
	defb po_1_oper - $;					// 
	defb po_1_oper - $;					// 
	defb po_1_oper - $;					// 
	defb po_2_oper - $;					// 
	defb po_2_oper - $;					// 

	org $0a23
po_back_1:
	inc c;								// 
	ld a, 34;							// 
	cp c;								// 
	jr nz, po_back_3;					// 
	bit 1, (iy + _flags);				// 
	jr nz, po_back_2;					// 
	inc b;								// 
	ld c, 2;							// 
	ld a, 24;							// 
	cp b;								// 
	jr nz, po_back_3;					// 
	dec b;								// 

	org $0a38
po_back_2:
	ld c, 33;							// 

	org $0a3a
po_back_3:
	jp cl_set;							// 

	org $0a3d
po_right:
	ld a, (p_flag);						// 
	push af;							// 
	ld (iy +  _p_flag), $01;			// 
	ld a, ' ';							// 
	call po_char;						// 
	pop af;								// 
	ld (p_flag), a;						// 
	ret;								// 

	org $0a4f
po_enter:
	bit 1, (iy + _flags);				// 
	jp nz, copy_buff;					// 
	ld c, 33;							// 
	call po_scr;						// 
	dec b;								// 
	jp cl_set;							// 

	org $0a5f
po_comma:
	call po_fetch;						// 
	ld a, c;							// 
	dec a;								// 
	dec a;								// 
	and %00010000;						// 
	jr po_fill;							// 

	org $0a69
po_quest:
	ld a, '?';							// 
	jr po_able;							// 

	org $0a6d
po_vdu_2:
	ld de, po_cont;						// 
	ld (vdu_data_h), a;					// 
	jr po_change;						// 

	org $0a75
po_2_oper:
	ld de, po_vdu_2;					// 
	jr po_vdu_1;						// 

	org $0a7a
po_1_oper:
	ld de, po_cont;						// 

	org $0a7d
po_vdu_1:
	ld (vdu_data), a;					// 

	org $0a80
po_change:
	ld hl, (curchl);					// 
	ld (hl), e;							// 
	inc hl;								// 
	ld (hl), d;							// 
	ret;								// 

	org $0a87
po_cont:
	ld de, print_out;					// 
	call po_change;						// 
	ld hl, (vdu_data);					// 
	ld d, a;							// 
	ld a, l;							// 
	cp 22;								// 
	jp c, co_temp_5;					// 
	jr nz, po_tab;						// 
	ld b, h;							// 
	ld c, d;							// 
	ld a, 31;							// 
	sub c;								// 
	jr c, po_at_err;					// 
	add a, 2;							// 
	ld c, a;							// 
	bit 1, (iy + _flags);				// 
	jr nz, po_at_set;					// 
	ld a, 22;							// 
	sub b

	org $0aac
po_at_err:
	jp c, report_bb;					// 
	inc a;								// 
	ld b, a;							// 
	inc b;								// 
	bit 0, (iy + _vdu_flag);			// 
	jp nz, po_scr;						// 
	cp (iy + _df_sz);					// 
	jp c, report_5;						// 

	org $0abf
po_at_set:
	jp cl_set;							// 

	org $0ac2
po_tab:
	ld a, h;							// 

	org $0ac3
po_fill:
	call po_fetch;						// 
	add a, c;							// 
	dec a;								// 
	and %00011111;						// 
	ret z;								// 
	ld d, a;							// 
	set 0, (iy + _flags);				// 

	org $0ad0
po_space:
	ld a, ' ';							// 
	call po_save;						// 
	dec d;								// 
	jr nz, po_space;					// 
	ret;								// 

	org $0ad9
po_able:
	call po_any;						// 

	org $0adc
po_store:
	bit 1, (iy + _flags);				// 
	jr nz, po_st_pr;					// 
	bit 0, (iy + _vdu_flag);			// 
	jr nz, po_st_e;						// 
	ld (s_posn), bc;					// 
	ld (df_cc), hl;						// 
	ret;								// 

	org $0af0
po_st_e:
	ld (sposnl), bc;					// 
	ld (echo_e), bc;					// 
	ld (df_ccl), hl;					// 
	ret;								// 

	org $0afc
po_st_pr:
	ld (iy + _p_posn), c;				// 
	ld (pr_cc), hl;						// 
	ret;								// 

	org $0b03
po_fetch:
	bit 1, (iy + _flags);								// 
	jr nz, po_f_pr;								// 
	ld bc, (s_posn);								// 
	ld hl, (df_cc);								// 
	bit 0, (iy + _vdu_flag);								// 
	ret z;								// 
	ld bc, (sposnl);								// 
	ld hl, (df_ccl);								// 
	ret;						// 

	org $0b1d
po_f_pr:
	ld c, (iy + _p_posn);								// 
	ld hl, (pr_cc);								// 
	ret;						// 

	org $0b24
po_any:
	cp $80;								// 
	jr c, po_char;								// 
	cp 144;								// 
	jr nc, po_t_and_udg;								// 
	ld b, a;								// 
	call po_gr_1;								// 
	call po_fetch;								// 
	ld de, membot;								// 
	jr pr_all;						// 

	org $0b38
po_gr_1:
	ld hl, membot;								// 
	call po_gr_2;						// 

	org $0b3e
po_gr_2:
	rr b;								// 
	sbc a, a;								// 
	and %00001111;								// 
	ld c, a;								// 
	rr b;								// 
	sbc a, a;								// 
	and %11110000;								// 
	or c;								// 
	ld c, 4;						// 

	org $0b4c
po_gr_3:
	ld (hl), a;								// 
	inc hl;								// 
	dec c;								// 
	jr nz, po_gr_3;								// 
	ret;						// 

	org $0b52
po_t_and_udg:
	sub tk_rnd;								// 
	jr nc, po_t;								// 
	add a, 21;								// 
	push bc;								// 
	ld bc, (udg);								// 
	jr po_char_2;						// 

	org $0b5f
po_t:
	call po_tokens;								// 
	jp po_fetch;						// 

	org $0b65
po_char:
	push bc;								// 
	ld bc, (chars);						// 

	org $0b6a
po_char_2:
	ex de, hl;								// 
	ld hl, flags;								// 
	res 0, (hl);								// 
	cp 32;' ';								// 
	jr nz, po_char_3;								// 
	set 0, (hl);						// 

	org $0b76
po_char_3:
	ld h, 0;								// 
	ld l, a;								// 
	add hl, hl;								// 
	add hl, hl;								// 
	add hl, hl;								// 
	add hl, bc;								// 
	pop bc;								// 
	ex de, hl;						// 

	org $0b7f
pr_all:
	ld a, c;								// 
	dec a;								// 
	ld a, 33;								// 
	jr nz, pr_all_1;								// 
	dec b;								// 
	ld c, a;								// 
	bit 1, (iy + _flags);								// 
	jr z, pr_all_1;								// 
	push de;								// 
	call copy_buff;								// 
	pop de;								// 
	ld a, c;						// 

	org $0b93
pr_all_1:
	cp c;								// 
	push de;								// 
	call z, po_scr;								// 
	pop de;								// 
	push bc;								// 
	push hl;								// 
	ld a, (p_flag);								// 
	ld b, 255;								// 
	rra;								// 
	jr c, pr_all_2;								// 
	inc b;						// 

	org $0ba4
pr_all_2:
	rra;								// 
	rra;								// 
	sbc a, a;								// 
	ld c, a;								// 
	ld a, 8;								// 
	and a;								// 
	bit 1, (iy + _flags);								// 
	jr z, pr_all_3;								// 
	set 1, (iy + _flags2);								// 
	scf;						// 

	org $0bb6
pr_all_3:
	ex de, hl;						// 

	org $0bb7
pr_all_4:
	ex af, af';								// 
	ld a, (de);								// 
	and b;								// 
	xor (hl);								// 
	xor c;								// 
	ld (de), a;								// 
	ex af, af';								// 
	jr c, pr_all_6;								// 
	inc d;						// 

	org $0bc1
pr_all_5:
	inc hl;								// 
	dec a;								// 
	jr nz, pr_all_4;								// 
	ex de, hl;								// 
	dec h;								// 
	bit 1, (iy + _flags);								// 
	call z, po_attr;								// 
	pop hl;								// 
	pop bc;								// 
	dec c;								// 
	inc hl;								// 
	ret;						// 

	org $0bd3
pr_all_6:
	ex af, af';								// 
	ld a, 32;								// 
	add a, e;								// 
	ld e, a;								// 
	ex af, af';								// 
	jr pr_all_5;						// 

	org $0bdb
po_attr:
	ld a, h;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	and %00000011;								// 
	or %01011000;								// 
	ld h, a;								// 
	ld de, (attr_t);								// 
	ld a, (hl);								// 
	xor e;								// 
	and d;								// 
	xor e;								// 
	bit 6, (iy + _p_flag);								// 
	jr z, $0bfa;								// 
	and %11000111;								// 
	bit 2, a;								// 
	jr nz, po_attr_1;								// 
	xor %00111000;						// 

	org $0bfa
po_attr_1:
	bit 4, (iy + _p_flag);								// 
	jr z, po_attr_2;								// 
	and %11111000;								// 
	bit 5, a;								// 
	jr nz, po_attr_2;								// 
	xor %00000111;						// 

	org $0c08
po_attr_2:
	ld (hl), a;								// 
	ret;						// 

	org $0c0a
po_msg:
	push hl;								// 
	ld h, 0;								// 
	ex (sp), hl;								// 
	jr po_table;						// 

	org $0c10
po_tokens:
	ld de, token_table;								// 
	push af;						// 

	org $0c14
po_table:
	call po_search;								// 
	jr c, po_each;								// 
	ld a, ' ';								// 
	bit 0, (iy + _flags);								// 
	call z, po_save;						// 

	org $0c22
po_each:
	ld a, (de);								// 
	and %01111111;								// 
	call po_save;								// 
	ld a, (de);								// 
	inc de;								// 
	add a, a;								// 
	jr nc, po_each;								// 
	pop de;								// 
	cp 72;								// 
	jr z, po_tr_sp;								// 
	cp 130;								// 
	ret c;						// 

	org $0c35
po_tr_sp:
	ld a, d;								// 
	cp 3;								// 
	ret c;								// 
	ld a, ' ';						// 

	org $0c3b
po_save:
	push de;								// 
	exx;								// 
	rst print_a;								// 
	exx;								// 
	pop de;								// 
	ret;						// 

	org $0c41
po_search:
	push af;								// 
	ex de, hl;								// 
	inc a;						// 

	org $0c44
po_step:
	bit 7, (hl);								// 
	inc hl;								// 
	jr z, po_step;								// 
	dec a;								// 
	jr nz, po_step;								// 
	ex de, hl;								// 
	pop af;								// 
	cp 32;' ';								// 
	ret c;								// 
	ld a, (de);								// 
	sub 'A';								// 
	ret;						// 

	org $0c55
po_scr:
	bit 1, (iy + _flags);								// 
	ret nz;								// 
	ld de, cl_set;								// 
	push de;								// 
	ld a, b;								// 
	bit 0, (iy + _vdu_flag);								// 
	jp nz, po_scr_4;								// 
	cp (iy + _df_sz);								// 
	jr c, report_5;								// 
	ret nz;								// 
	bit 4, (iy + _vdu_flag);								// 
	jr z, po_scr_2;								// 
	ld e, (iy + _breg);								// 
	dec e;								// 
	jr z, po_scr_3;								// 
	ld a, 0;								// 
	call chan_open;								// 
	ld sp, (list_sp);								// 
	res 4, (iy + _vdu_flag);								// 
	ret;						// 

	org $0c86
report_5:
	rst error;								// 
	defb out_of_screen;						// 

	org $0c88
po_scr_2:
	dec (iy + _scr_ct);								// 
	jr nz, po_scr_3;								// 
	ld a, 24;								// 
	sub b;								// 
	ld (scr_ct), a;								// 
	ld hl, (attr_t);								// 
	push hl;								// 
	ld a, (p_flag);								// 
	push af;								// 
	ld a, 253;								// 
	call chan_open;								// 
	xor a;								// 
	ld de, scrl_mssg;								// 
	call po_msg;								// 
	set 5, (iy + _vdu_flag);								// 
	ld hl, flags;								// 
	set 3, (hl);								// 
	res 5, (hl);								// 
	exx;								// 
	call wait_key;								// 
	exx;								// 
	cp 32;' ';								// 
	jr z, report_d;								// 
	cp tk_stop;								// 
	jr z, report_d;								// 
	or %00100000;								// 
	cp 110;'n';								// 
	jr z, report_d;								// 
	ld a, 254;								// 
	call chan_open;								// 
	pop af;								// 
	ld (p_flag), a;								// 
	pop hl;								// 
	ld (attr_t), hl;						// 

	org $0cd2
po_scr_3:
	call cl_sc_all;								// 
	ld b, (iy + _df_sz);								// 
	inc b;								// 
	ld c, 33;								// 
	push bc;								// 
	call cl_addr;								// 
	ld a, h;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	and %00000011;								// 
	or %01011000;								// 
	ld h, a;								// 
	ld de, attrmap + $02e0;								// 
	ld a, (de);								// 
	ld c, (hl);								// 
	ld b, 32;								// 
	ex de, hl;						// 

	org $0cf0
po_scr_3a:
	ld (de), a;								// 
	ld (hl), c;								// 
	inc de;								// 
	inc hl;								// 
	djnz po_scr_3a;								// 
	pop bc;								// 
	ret;						// 

	org $0cf8
scrl_mssg:
	defb $80, "scroll", '?' + $80;

	org $0d00
report_d:
	rst error;								// 
	defb break_cont_repeats

	org $0d02
po_scr_4:
	cp 2;								// 
	jr c, report_5;								// 
	add a, (iy + _df_sz);								// 
	sub 25;								// 
	ret nc;								// 
	neg;								// 
	push bc;								// 
	ld b, a;								// 
	ld hl, (attr_t);								// 
	push hl;								// 
	ld hl, (p_flag);								// 
	push hl;								// 
	call temps;								// 
	ld a, b;						// 

	org $0d1c
po_scr_4a:
	push af;								// 
	ld hl, df_sz;								// 
	ld b, (hl);								// 
	ld a, b;								// 
	inc a;								// 
	ld (hl), a;								// 
	ld hl, s_posn_h;								// 
	cp (hl);								// 
	jr c, po_scr_4b;								// 
	inc (hl);								// 
	ld b, 24;						// 

	org $0d2d
po_scr_4b:
	call cl_scroll;								// 
	pop af;								// 
	dec a;								// 
	jr nz, po_scr_4a;								// 
	pop hl;								// 
	ld (iy + _p_flag), l;								// 
	pop hl;								// 
	ld (attr_t), hl;								// 
	ld bc, (s_posn);								// 
	res 0, (iy + _vdu_flag);								// 
	call cl_set;								// 
	set 0, (iy + _vdu_flag);								// 
	pop bc;								// 
	ret;						// 

	org $0d4d
temps:
	xor a;								// 
	ld hl, (attr_p);								// 
	bit 0, (iy + _vdu_flag);								// 
	jr z, temps_1;								// 
	ld h, a;								// 
	ld l, (iy + _bordcr);						// 

	org $0d5b
temps_1:
	ld (attr_t), hl;								// 
	ld hl, p_flag;								// 
	jr nz, temps_2;								// 
	ld a, (hl);								// 
	rrca;						// 

	org $0d65
temps_2:
	xor (hl);								// 
	and %01010101;								// 
	xor (hl);								// 
	ld (hl), a;								// 
	ret;						// 

	org $0d6b
cls:
	call cl_all;								// 
	
	org $0d6e
cls_lower:
	ld hl, vdu_flag;								// 
	res 5, (hl);								// 
	set 0, (hl);								// 
	call temps;								// 
	ld b, (iy + _df_sz);								// 
	call cl_line;								// 
	ld hl, attrmap + $02c0;								// 
	ld a, (attr_p);								// 
	dec b;								// 
	jr cls_3;						// 

	org $0d87
cls_1:
	ld c, 32;						// 

	org $0d89
cls_2:
	dec hl;								// 
	ld (hl), a;								// 
	dec c;								// 
	jr nz, cls_2;						// 

	org $0d8e
cls_3:
	djnz cls_1;								// 
	ld (iy + _df_sz), $02

	org $0d94
cl_chan:
	ld a, 253;								// 
	call chan_open;								// 
	ld hl, (curchl);								// 
	ld de, print_out;								// 
	and a;						// 

	org $0da0
cl_chan_a:
	ld (hl), e;								// 
	inc hl;								// 
	ld (hl), d;								// 
	inc hl;								// 
	ld de, key_input;								// 
	ccf;								// 
	jr c, cl_chan_a;								// 
	ld bc, $1721;								// 
	jr cl_set;						// 

	org $0daf
cl_all:
	ld hl, $0000;								// 
	ld (coords), hl;								// 
	res 0, (iy + _flags2);								// 
	call cl_chan;								// 
	ld a, 254;								// 
	call chan_open;								// 
	call temps;								// 
	ld b, 24;								// 
	call cl_line;								// 
	ld hl, (curchl);								// 
	ld de, print_out;								// 
	ld (hl), e;								// 
	inc hl;								// 
	ld (hl), d;								// 
	ld (iy + _scr_ct), 1;								// 
	ld bc, $1821;						// 

	org $0dd9
cl_set:
	ld hl, prt_buff;								// 
	bit 1, (iy + _flags);								// 
	jr nz, cl_set_2;								// 
	ld a, b;								// 
	bit 0, (iy + _vdu_flag);								// 
	jr z, cl_set_1;								// 
	add a, (iy + _df_sz);								// 
	sub 24;						// 

	org $0dee
cl_set_1:
	push bc;								// 
	ld b, a;								// 
	call cl_addr;								// 
	pop bc;						// 

	org $0df4
cl_set_2:
	ld a, 33;								// 
	sub c;								// 
	ld e, a;								// 
	ld d, 0;								// 
	add hl, de;								// 
	jp po_store;						// 

	org $0dfe
cl_sc_all:
	ld b, 23;						// 

	org $0e00
cl_scroll:
	call cl_addr;								// 
	ld c, 8;						// 

	org $0e05
cl_scr_1:
	push bc;								// 
	push hl;								// 
	ld a, b;								// 
	and %00000111;								// 
	ld a, b;								// 
	jr nz, cl_scr_3;						// 

	org $0e0d
cl_scr_2:
	ex de, hl;								// 
	ld hl, $f8e0;								// 
	add hl, de;								// 
	ex de, hl;								// 
	ld bc, $0020;								// 
	dec a;								// 
	ldir;						// 

	org $0e19
cl_scr_3:
	ex de, hl;								// 
	ld hl, $ffe0;								// 
	add hl, de;								// 
	ex de, hl;								// 
	ld b, a;								// 
	and %00000111;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	ld c, a;								// 
	ld a, b;								// 
	ld b, 0;								// 
	ldir;								// 
	ld b, 7;								// 
	add hl, bc;								// 
	and %11111000;								// 
	jr nz, cl_scr_2;								// 
	pop hl;								// 
	inc h;								// 
	pop bc;								// 
	dec c;								// 
	jr nz, cl_scr_1;								// 
	call cl_attr;								// 
	ld hl, $ffe0;								// 
	add hl, de;								// 
	ex de, hl;								// 
	ldir;								// 
	ld b, 1;						// 

	org $0e44
cl_line:
	push bc;								// 
	call cl_addr;								// 
	ld c, 8;						// 

	org $0e4a
cl_line_1:
	push bc;								// 
	push hl;								// 
	ld a, b;						// 

	org $0e4d
cl_line_2:
	and %00000111;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	ld c, a;								// 
	ld a, b;								// 
	ld b, 0;								// 
	dec c;								// 
	ld d, h;								// 
	ld e, l;								// 
	ld (hl), 0;								// 
	inc de;								// 
	ldir;								// 
	ld de, $0701;								// 
	add hl, de;								// 
	dec a;								// 
	and %11111000;								// 
	ld b, a;								// 
	jr nz, cl_line_2;								// 
	pop hl;								// 
	inc h;								// 
	pop bc;								// 
	dec c;								// 
	jr nz, cl_line_1;								// 
	call cl_attr;								// 
	ld h, d;								// 
	ld l, e;								// 
	inc de;								// 
	ld a, (attr_p);								// 
	bit 0, (iy + _vdu_flag);								// 
	jr z, cl_line_3;								// 
	ld a, (bordcr);						// 

	org $0e80
cl_line_3:
	ld (hl), a;								// 
	dec bc;								// 
	ldir;								// 
	pop bc;								// 
	ld c, 33;								// 
	ret;						// 

	org $0e88
cl_attr:
	ld a, h;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	dec a;								// 
	or %01010000;								// 
	ld h, a;								// 
	ex de, hl;								// 
	ld h, c;								// 
	ld l, b;								// 
	add hl, hl;								// 
	add hl, hl;								// 
	add hl, hl;								// 
	add hl, hl;								// 
	add hl, hl;								// 
	ld b, h;								// 
	ld c, l;								// 
	ret;						// 

	org $0e9b
cl_addr:
	ld a, 24;								// 
	sub b;								// 
	ld d, a;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	and %11100000;								// 
	ld l, a;								// 
	ld a, d;								// 
	and %00011000;								// 
	or %01000000;								// 
	ld h, a;								// 
	ret;						// 

	org $0eac
copy:
	di;								// 
	ld b, 176;								// 
	ld hl, bitmap;						// 

	org $0eb2
copy_1:
	push hl;								// 
	push bc;								// 
	call copy_line;								// 
	pop bc;								// 
	pop hl;								// 
	inc h;								// 
	ld a, h;								// 
	and %00000111;								// 
	jr nz, copy_2;								// 
	ld a, l;								// 
	add a, 32;								// 
	ld l, a;								// 
	ccf;								// 
	sbc a, a;								// 
	and %11111000;								// 
	add a, h;								// 
	ld h, a;						// 

	org $0ec9
copy_2:
	djnz copy_1;								// 
	jr copy_end;						// 

	org $0ecd
copy_buff:
	di;								// 
	ld hl, prt_buff;								// 
	ld b, 8;						// 

	org $0ed3
copy_3:
	push bc;								// 
	call copy_line;								// 
	pop bc;								// 
	djnz copy_3;						// 

	org $0eda
copy_end:
	ld a, 4;								// 
	out (printer), a;								// 
	ei;						// 

	org $0edf
clear_prb:
	ld hl, prt_buff;								// 
	ld (iy + _pr_cc), l;								// 
	xor a;								// 
	ld b, a;						// 

	org $0ee7
prb_bytes:
	ld (hl), a;								// 
	inc hl;								// 
	djnz prb_bytes;								// 
	res 1, (iy + _flags2);								// 
	ld c, 33;								// 
	jp cl_set;						// 

	org $0ef4
copy_line:
	ld a, b;								// 
	cp 3;								// 
	sbc a, a;								// 
	and %00000010;								// 
	out (printer), a;								// 
	ld d, a;						// 

	org $0efd
copy_l_1:
	call break_key;								// 
	jr c, copy_l_2;								// 
	ld a, 4;								// 
	out (printer), a;								// 
	ei;								// 
	call clear_prb;						// 

	org $0f0a
report_dc:
	rst error;								// 
	defb break_cont_repeats

	org $0f0c
copy_l_2:
	in a, (printer);								// 
	add a, a;								// 
	ret m;								// 
	jr nc, copy_l_1;								// 
	ld c, 32;						// 

	org $0f14
copy_l_3:
	ld e, (hl);								// 
	inc hl;								// 
	ld b, 8;						// 

	org $0f18
copy_l_4:
	rl d;								// 
	rl e;								// 
	rr d;						// 

	org $0f1e
copy_l_5:
	in a, (printer);								// 
	rra;								// 
	jr nc, copy_l_5;								// 
	ld a, d;								// 
	out (printer), a;								// 
	djnz copy_l_4;								// 
	dec c;								// 
	jr nz, copy_l_3;								// 
	ret;						// 
