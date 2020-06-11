;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $24fb
scanning:
	rst get_char;								// 
	ld b, 0;								// 
	push bc

	org $24ff
s_loop_1:
	ld c, a;								// 
	ld hl, scan_func;								// 
	call indexer;								// 
	ld a, c;								// 
	jp nc, s_alphnum;								// 
	ld b, 0;								// 
	ld c, (hl);								// 
	add hl, bc;								// 
	jp (hl)

	org $250f
s_quote_s:
	call ch_add_plus_1;								// 
	inc bc;								// 
	cp ctrl_enter;								// 
	jp z, report_c;								// 
	cp 34;'";";								// 
	jr nz, s_quote_s;								// 
	call ch_add_plus_1;								// 
	cp 34;'";";								// 
	ret

	org $2522
s_2_coord:
	rst next_char;								// 
	cp 40;'(';;								// 
	jr nz, s_rport_c;								// 
	call next_2num;								// 
	rst get_char;								// 
	cp 41;')';

	org $252d
s_rport_c:
	jp nz, report_c

	org $2530
syntax_z:
	bit 7, (iy + _flags);								// 
	ret

	org $2535
s_scrn_str_s:
	call stk_to_bc;								// 
	ld hl, (chars);								// 
	ld de, $0100;								// 
	add hl, de;								// 
	ld a, c;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	and %11100000;								// 
	xor b;								// 
	ld e, a;								// 
	ld a, c;								// 
	and %00011000;								// 
	xor %01000000;								// 
	ld d, a;								// 
	ld b, 96

	org $254f
s_scrn_lp:
	push bc;								// 
	push de;								// 
	push hl;								// 
	ld a, (de);								// 
	xor (hl);								// 
	jr z, s_sc_mtch;								// 
	inc a;								// 
	jr nz, s_scr_nxt;								// 
	dec a

	org $255a
s_sc_mtch:
	ld c, a;								// 
	ld b, 7

	org $255d
s_sc_rows:
	inc d;								// 
	inc hl;								// 
	ld a, (de);								// 
	xor (hl);								// 
	xor c;								// 
	jr nz, s_scr_nxt;								// 
	djnz s_sc_rows;								// 
	pop bc;								// 
	pop bc;								// 
	pop bc;								// 
	ld a, $80;								// 
	sub b;								// 
	ld bc, $0001;								// 
	rst bc_spaces;								// 
	ld (de), a;								// 
	jr s_scr_sto

	org $2573
s_scr_nxt:
	pop hl;								// 
	ld de, $0008;								// 
	add hl, de;								// 
	pop de;								// 
	pop bc;								// 
	djnz s_scrn_lp;								// 
	ld c, b

	org $257d
s_scr_sto:
	jp stk_sto_str

	org $2580
s_attr_s:
	call stk_to_bc;								// 
	ld a, c;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	ld c, a;								// 
	and %11100000;								// 
	xor b;								// 
	ld l, a;								// 
	ld a, c;								// 
	and %00000011;								// 
	xor %01011000;								// 
	ld h, a;								// 
	ld a, (hl);								// 
	jp stack_a

	org $2596
scan_func:
	defb '"', s_quote - $ - 1;";"								// 
	defb '(', s_bracket - $ - 1;								// 
	defb '.', s_decimal - $ - 1;								// 
	defb '+', s_u_plus - $ - 1;								// 
	defb tk_fn, s_fn - $ - 1;								// 
	defb tk_rnd, s_rnd - $ - 1;								// 
	defb tk_pi, s_pi - $ - 1;								// 
	defb tk_inkey_str, s_inkey_str - $ - 1;								// 
	defb tk_bin, s_bin - $ - 1;								// 
	defb tk_screen_str, s_screen_str - $ - 1;								// 
	defb tk_attr, s_attr - $ - 1;								// 
	defb tk_point, s_point - $ - 1;								// 
	defb $00

	org $25af
s_u_plus:
	rst next_char;								// 
	jp s_loop_1

	org $25b3
s_quote:
	rst get_char;								// 
	inc hl;								// 
	push hl;								// 
	ld bc, $0000;								// 
	call s_quote_s;								// 
	jr nz, s_q_prms

	org $25be
s_q_again:
	call s_quote_s;								// 
	jr z, s_q_again;								// 
	call syntax_z;								// 
	jr z, s_q_prms;								// 
	rst bc_spaces;								// 
	pop hl;								// 
	push de

	org $25cb
s_q_copy:
	ld a, (hl);								// 
	inc hl;								// 
	ld (de), a;								// 
	inc de;								// 
	cp 34;'";";								// 
	jr nz, s_q_copy;								// 
	ld a, (hl);								// 
	inc hl;								// 
	cp 34;'";";								// 
	jr z, s_q_copy

	org $25d9
s_q_prms:
	dec bc;								// 
	pop de

	org $25db
s_string:
	ld hl, flags;								// 
	res 6, (hl);								// 
	bit 7, (hl);								// 
	call nz, stk_sto_str;								// 
	jp s_cont_2

	org $25e8
s_bracket:
	rst next_char;								// 
	call scanning;								// 
	cp 41;')';;								// 
	jp nz, report_c;								// 
	rst next_char;								// 
	jp s_cont_2

	org $25f5
s_fn:
	jp s_fn_sbrn

	org $25f8
s_rnd:
	call syntax_z;								// 
	jr z, s_rnd_end;								// 
	ld bc, (seed);								// 
	call stack_bc;								// 
	fwait;								// 
	fstk1;								// 
	fadd;								// 
	fstk;								// 
	defb $37, $16;								// 
	fmul;								// 
	fstk;								// 
	defb $80, $41, $00, $00, $80;								// 
	fmod;								// 
	fdel;								// 
	fstk1;								// 
	fsub;								// 
	fmove;								// 
	fce;								// 
	call fp_to_bc;								// 
	ld (seed), bc;								// 
	ld a, (hl);								// 
	and a;								// 
	jr z, s_rnd_end;								// 
	sub 16;								// 
	ld (hl), a

	org $2625
s_rnd_end:
	jr s_pi_end

	org $2627
s_pi:
	call syntax_z;								// 
	jr z, s_pi_end;								// 
	fwait;								// 
	fstkpix.5;								// 
	fce;								// 
	inc (hl)

	org $2630
s_pi_end:
	rst next_char;								// 
	jp s_numeric

	org $2634
s_inkey_str:
	ld bc, $105a;								// 
	rst next_char;								// 
	cp 35;'#';								// 
	jp z, s_push_po;								// 
	ld hl, flags;								// 
	res 6, (hl);								// 
	bit 7, (hl);								// 
	jr z, s_ink_str_en;								// 
	call key_scan;								// 
	ld c, 0;								// 
	jr nz, s_ik_str_stk;								// 
	call k_test;								// 
	jr nc, s_ik_str_stk;								// 
	dec d;								// 
	ld e, a;								// 
	call k_decode;								// 
	push af;								// 
	ld bc, $0001;								// 
	rst bc_spaces;								// 
	pop af;								// 
	ld (de), a;								// 
	ld c, 1

	org $2660
s_ik_str_stk:
	ld b, 0;								// 
	call stk_sto_str

	org $2665
s_ink_str_en:
	jp s_cont_2

	org $2668
s_screen_str:
	call s_2_coord;								// 
	call nz, s_scrn_str_s;								// 
	rst next_char;								// 
	jp s_string

	org $2672
s_attr:
	call s_2_coord;								// 
	call nz, s_attr_s;								// 
	rst next_char;								// 
	jr s_numeric

	org $267b
s_point:
	call s_2_coord;								// 
	call nz, point_sub;								// 
	rst next_char;								// 
	jr s_numeric

	org $2684
s_alphnum:
	call alphanum;								// 
	jr nc, s_negate;								// 
	cp 65;'A';								// 
	jr nc, s_letter

	org $268d
s_bin:
s_decimal:
	call syntax_z;								// 
	jr nz, s_stk_dec;								// 
	call dec_to_fp;								// 
	rst get_char;								// 
	ld bc, $0006;								// 
	call make_room;								// 
	inc hl;								// 
	ld (hl), ctrl_number;								// 
	inc hl;								// 
	ex de, hl;								// 
	ld hl, (stkend);								// 
	ld c, 5;								// 
	and a;								// 
	sbc hl, bc;								// 
	ld (stkend), hl;								// 
	ldir;								// 
	ex de, hl;								// 
	dec hl;								// 
	call temp_ptr1;								// 
	jr s_numeric

	org $26b5
s_stk_dec:
	rst get_char

	org $26b6
s_sd_skip:
	inc hl;								// 
	ld a, (hl);								// 
	cp ctrl_number;								// 
	jr nz, s_sd_skip;								// 
	inc hl;								// 
	call stack_num;								// 
	ld (ch_add), hl

	org $26c3
s_numeric:
	set 6, (iy + _flags);								// 
	jr s_cont_1

	org $26c9
s_letter:
	call look_vars;								// 
	jp c, report_2;								// 
	call z, stk_var;								// 
	ld a, (flags);								// 
	cp %11000000;								// 
	jr c, s_cont_1;								// 
	inc hl;								// 
	call stack_num

	org $26dd
s_cont_1:
	jr s_cont_2 

	org $26df
s_negate:
	ld bc, $09db;								// 
	cp 45;'-';								// 
	jr z, s_push_po;								// 
	ld bc, $1018;								// 
	cp tk_val_str;								// 
	jr z, s_push_po;								// 
	sub tk_code;								// 
	jp c, report_c;								// 
	ld bc, $04f0;								// 
	cp 20;								// 
	jr z, s_push_po;								// 
	jp nc, report_c;								// 
	ld b, 16;								// 
	add a, 220;								// 
	ld c, a;								// 
	cp 223;								// 
	jr nc, s_no_to_str;								// 
	res 6, c

	org $2707
s_no_to_str:
	cp 238;								// 
	jr c, s_push_po;								// 
	res 7, c

	org $270d
s_push_po:
	push bc;								// 
	rst next_char;								// 
	jp s_loop_1

	org $2712
s_cont_2:
	rst get_char

	org $2713
s_cont_3:
	cp 40;'(';;								// 
	jr nz, s_opertr ;								// 
	bit 6, (iy + _flags);								// 
	jr nz, s_loop;								// 
	call slicing;								// 
	rst next_char;								// 
	jr s_cont_3

	org $2723
s_opertr:
	ld b, 0;								// 
	ld c, a;								// 
	ld hl, tbl_of_ops;								// 
	call indexer;								// 
	jr nc, s_loop;								// 
	ld c, (hl);								// 
	ld hl, tbl_priors - 195;								// 
	add hl, bc;								// 
	ld b, (hl)

	org $2734
s_loop:
	pop de;								// 
	ld a, d;								// 
	cp b;								// 
	jr c, s_tighter;								// 
	and a;								// 
	jp z, jp_get_char;								// 
	push bc;								// 
	ld hl, flags;								// 
	ld a, e;								// 
	cp 237;								// 
	jr nz, s_stk_lst;								// 
	bit 6, (hl);								// 
	jr nz, s_stk_lst;								// 
	ld e, 153

	org $274c
s_stk_lst:
	push de;								// 
	call syntax_z;								// 
	jr z, s_syntest;								// 
	ld a, e;								// 
	and %00111111;								// 
	ld b, a;								// 
	fwait;								// 
	fsgl;								// 
	fce;								// 
	jr s_runtest

	org $275b
s_syntest:
	ld a, e;								// 
	xor (iy + _flags);								// 
	and %01000000

	org $2761
s_rport_c2:
	jp nz, report_c

	org $2764
s_runtest:
	pop de;								// 
	ld hl, flags;								// 
	set 6, (hl);								// 
	bit 7, e;								// 
	jr nz, s_loopend;								// 
	res 6, (hl)

	org $2770
s_loopend:
	pop bc;								// 
	jr s_loop

	org $2773
s_tighter:
	push de;								// 
	ld a, c;								// 
	bit 6, (iy + _flags);								// 
	jr nz, s_next;								// 
	and %00111111;								// 
	add a, 8;								// 
	ld c, a;								// 
	cp $10; fbands;								// 
	jr nz, s_not_and;								// 
	set 6, c;								// 
	jr s_next

	org $2788
s_not_and:
	jr c, s_rport_c2;								// 
	cp $17; fcat;								// 
	jr z, s_next;								// 
	set 7, c

	org $2790
s_next:
	push bc;								// 
	rst next_char;								// 
	jp s_loop_1

	org $2795
tbl_of_ops:
	defb '+', $cf;								// 
	defb '-', $c3;								// 
	defb '*', $c4;								// 
	defb '/', $c5;								// 
	defb '^', $c6;								// 
	defb '=', $ce;								// 
	defb '>', $cc;								// 
	defb '<', $cd;								// 
	defb tk_l_eql, $c9;								// 
	defb tk_gr_eq, $ca;								// 
	defb tk_neql, $cb;								// 
	defb tk_or, $c7;								// 
	defb tk_and, $c8;								// 
	defb $00

	org $27b0
tbl_priors:
	defb $06, $08, $08, $0a, $02, $03, $05, $05;								// 
	defb $05, $05, $05, $05, $06

	org $27bd
s_fn_sbrn:
	call syntax_z;								// 
	jr nz, sf_run;								// 
	rst next_char;								// 
	call alpha;								// 
	jp nc, report_c;								// 
	rst next_char;								// 
	cp 36;'$';;								// 
	push af;								// 
	jr nz, sf_brkt_1;								// 
	rst next_char

	org $27d0
sf_brkt_1:
	cp 40;'(';;								// 
	jr nz, sf_rprt_c;								// 
	rst next_char;								// 
	cp 41;')';;								// 
	jr z, sf_flag_6

	org $27d9
sf_argmts:
	call scanning;								// 
	rst get_char;								// 
	cp 44;',';								// 
	jr nz, sf_brkt_2;								// 
	rst next_char;								// 
	jr sf_argmts

	org $27e4
sf_brkt_2:
	cp 41;')';

	org $27e6
sf_rprt_c:
	jp nz, report_c

	org $27e9
sf_flag_6:
	rst next_char;								// 
	ld hl, flags;								// 
	res 6, (hl);								// 
	pop af;								// 
	jr z, sf_syn_en;								// 
	set 6, (hl)

	org $27f4
sf_syn_en:
	jp s_cont_2

	org $27f7
sf_run:
	rst next_char;								// 
	and %11011111;								// 
	ld b, a;								// 
	rst next_char;								// 
	sub '$';								// 
	ld c, a;								// 
	jr nz, sf_argmt1;								// 
	rst next_char

	org $2802
sf_argmt1:
	rst next_char;								// 
	push hl;								// 
	ld hl, (prog);								// 
	dec hl

	org $2808
sf_fnd_df:
	ld de, $00ce;								// 
	push bc;								// 
	call look_prog;								// 
	pop bc;								// 
	jr nc, sf_cp_def

	org $2812
report_p:
	rst error;								// 
	defb fn_without_def

	org $2814
sf_cp_def:
	push hl;								// 
	call fn_skpovr;								// 
	and %11011111;								// 
	cp b;								// 
	jr nz, sf_not_fd;								// 
	call fn_skpovr;								// 
	sub '$';								// 
	cp c;								// 
	jr z, sf_values

	org $2825
sf_not_fd:
	pop hl;								// 
	dec hl;								// 
	ld de, $0200;								// 
	push bc;								// 
	call each_stmt;								// 
	pop bc;								// 
	jr sf_fnd_df

	org $2831
sf_values:
	and a;								// 
	call z, fn_skpovr;								// 
	pop de;								// 
	pop de;								// 
	ld (ch_add), de;								// 
	call fn_skpovr;								// 
	push hl;								// 
	cp 41;')';;								// 
	jr z, sf_r_br_2

	org $2843
sf_arg_lp:
	inc hl;								// 
	ld a, (hl);								// 
	cp ctrl_number;								// 
	ld d, 64;								// 
	jr z, sf_arg_vl;								// 
	dec hl;								// 
	call fn_skpovr;								// 
	inc hl;								// 
	ld d, 0

	org $2852
sf_arg_vl:
	inc hl;								// 
	push hl;								// 
	push de;								// 
	call scanning;								// 
	pop af;								// 
	xor (iy + _flags);								// 
	and %01000000;								// 
	jr nz, report_q;								// 
	pop hl;								// 
	ex de, hl;								// 
	ld hl, (stkend);								// 
	ld bc, $0005;								// 
	sbc hl, bc;								// 
	ld (stkend), hl;								// 
	ldir;								// 
	ex de, hl;								// 
	dec hl;								// 
	call fn_skpovr;								// 
	cp 41;')';;								// 
	jr z, sf_r_br_2;								// 
	push hl;								// 
	rst get_char;								// 
	cp 44;',';								// 
	jr nz, report_q;								// 
	rst next_char;								// 
	pop hl;								// 
	call fn_skpovr;								// 
	jr sf_arg_lp

	org $2885
sf_r_br_2:
	push hl;								// 
	rst get_char;								// 
	cp 41;')';;								// 
	jr z, sf_value

	org $288b
report_q:
	rst error;								// 
	defb parameter_error

	org $288d
sf_value:
	pop de;								// 
	ex de, hl;								// 
	ld (ch_add), hl;								// 
	ld hl, (defadd);								// 
	ex (sp), hl;								// 
	ld (defadd), hl;								// 
	push de;								// 
	rst next_char;								// 
	rst next_char;								// 
	call scanning;								// 
	pop hl;								// 
	ld (ch_add), hl;								// 
	pop hl;								// 
	ld (defadd), hl;								// 
	rst next_char;								// 
	jp s_cont_2

	org $28ab
fn_skpovr:
	inc hl;								// 
	ld a, (hl);								// 
	cp 33;'!';								// 
	jr c, fn_skpovr;								// 
	ret

	org $28b2
look_vars:
	set 6, (iy + _flags);								// 
	rst get_char;								// 
	call alpha;								// 
	jp nc, report_c;								// 
	push hl;								// 
	and %00011111;								// 
	ld c, a;								// 
	rst next_char;								// 
	push hl;								// 
	cp 40;'(';;								// 
	jr z, v_run_syn;								// 
	set 6, c;								// 
	cp 36;'$';;								// 
	jr z, v_str_var;								// 
	set 5, c;								// 
	call alphanum;								// 
	jr nc, v_test_fn

	org $28d4
v_char:
	call alphanum;								// 
	jr nc, v_run_syn;								// 
	res 6, c;								// 
	rst next_char;								// 
	jr v_char

	org $28de
v_str_var:
	rst next_char;								// 
	res 6, (iy + _flags)

	org $28e3
v_test_fn:
	ld a, (defadd_h);								// 
	and a;								// 
	jr z, v_run_syn;								// 
	call syntax_z;								// 
	jp nz, stk_f_arg

	org $28ef
v_run_syn:
	ld b, c;								// 
	call syntax_z;								// 
	jr nz, v_run;								// 
	ld a, c;								// 
	and %11100000;								// 
	set 7, a;								// 
	ld c, a;								// 
	jr v_syntax

	org $28fd
v_run:
	ld hl, (vars)

	org $2900
v_each:
	ld a, (hl);								// 
	and %01111111;								// 
	jr z, v_80_byte;								// 
	cp c;								// 
	jr nz, v_next;								// 
	rla;								// 
	add a, a;								// 
	jp p, v_found_2;								// 
	jr c, v_found_2;								// 
	pop de;								// 
	push de;								// 
	push hl

	org $2912
v_matches:
	inc hl

	org $2913
v_spaces:
	ld a, (de);								// 
	inc de;								// 
	cp 32;' ';								// 
	jr z, v_spaces;								// 
	or %00100000;								// 
	cp (hl);								// 
	jr z, v_matches;								// 
	or %10000000;								// 
	cp (hl);								// 
	jr nz, v_get_ptr;								// 
	ld a, (de);								// 
	call alphanum;								// 
	jr nc, v_found_1

	org $2929
v_get_ptr:
	pop hl

	org $292a
v_next:
	push bc;								// 
	call next_one;								// 
	ex de, hl;								// 
	pop bc;								// 
	jr v_each

	org $2932
v_80_byte:
	set 7, b

	org $2934
v_syntax:
	pop de;								// 
	rst get_char;								// 
	cp 40;'(';;								// 
	jr z, v_pass;								// 
	set 5, b;								// 
	jr v_end

	org $293e
v_found_1:
	pop de

	org $293f
v_found_2:
	pop de;								// 
	pop de;								// 
	push hl;								// 
	rst get_char

	org $2943
v_pass:
	call alphanum;								// 
	jr nc, v_end;								// 
	rst next_char;								// 
	jr v_pass

	org $294b
v_end:
	pop hl;								// 
	rl b;								// 
	bit 6, b;								// 
	ret

	org $2951
stk_f_arg:
	ld hl, (defadd);								// 
	ld a, (hl);								// 
	cp 41;')';;								// 
	jp z, v_run_syn

	org $295a
sfa_loop:
	ld a, (hl);								// 
	or %01100000;								// 
	ld b, a;								// 
	inc hl;								// 
	ld a, (hl);								// 
	cp ctrl_number;								// 
	jr z, sfa_cp_vr;								// 
	dec hl;								// 
	call fn_skpovr;								// 
	inc hl;								// 
	res 5, b

	org $296b
sfa_cp_vr:
	ld a, b;								// 
	cp c;								// 
	jr z, sfa_match;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	call fn_skpovr;								// 
	cp 41;')';;								// 
	jp z, v_run_syn;								// 
	call fn_skpovr;								// 
	jr sfa_loop

	org $2981
sfa_match:
	bit 5, c;								// 
	jr nz, sfa_end;								// 
	inc hl;								// 
	ld de, (stkend);								// 
	call move_fp;								// 
	ex de, hl;								// 
	ld (stkend), hl

	org $2991
sfa_end:
	pop de;								// 
	pop de;								// 
	xor a;								// 
	inc a;								// 
	ret

	org $2996
stk_var:
	xor a;								// 
	ld b, a;								// 
	bit 7, c;								// 
	jr nz, sv_count;								// 
	bit 7, (hl);								// 
	jr nz, sv_arrays;								// 
	inc a

	org $29a1
sv_simple_str:
	inc hl;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	inc hl;								// 
	ex de, hl;								// 
	call stk_sto_str;								// 
	rst get_char;								// 
	jp sv_slice_query

	org $29ae
sv_arrays:
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld b, (hl);								// 
	bit 6, c;								// 
	jr z, sv_ptr;								// 
	dec b;								// 
	jr z, sv_simple_str;								// 
	ex de, hl;								// 
	rst get_char;								// 
	cp 40;'(';;								// 
	jr nz, report_3;								// 
	ex de, hl

	org $29c0
sv_ptr:
	ex de, hl;								// 
	jr sv_count

	org $29c3
sv_comma:
	push hl;								// 
	rst get_char;								// 
	pop hl;								// 
	cp 44;',';								// 
	jr z, sv_loop;								// 
	bit 7, c;								// 
	jr z, report_3;								// 
	bit 6, c;								// 
	jr nz, sv_close;								// 
	cp 41;')';;								// 
	jr nz, sv_rpt_c;								// 
	rst next_char;								// 
	ret

	org $29d8
sv_close:
	cp 41;')';;								// 
	jr z, sv_dim;								// 
	cp tk_to;								// 
	jr nz, sv_rpt_c

	org $29e0
sv_ch_add:
	rst get_char;								// 
	dec hl;								// 
	ld (ch_add), hl;								// 
	jr sv_slice

	org $29e7
sv_count:
	ld hl, $0000

	org $29ea
sv_loop:
	push hl;								// 
	rst next_char;								// 
	pop hl ;								// 
	ld a, c;								// 
	cp %11000000;								// 
	jr nz, sv_mult;								// 
	rst get_char;								// 
	cp 41;')';;								// 
	jr z, sv_dim;								// 
	cp tk_to;								// 
	jr z, sv_ch_add

	org $29fb
sv_mult:
	push bc;								// 
	push hl;								// 
	call de_plus_1_to_de;								// 
	ex (sp), hl;								// 
	ex de, hl;								// 
	call int_exp1;								// 
	jr c, report_3;								// 
	dec bc;								// 
	call get_hl_x_de;								// 
	add hl, bc;								// 
	pop de;								// 
	pop bc;								// 
	djnz sv_comma;								// 
	bit 7, c

	org $2a12
sv_rpt_c:
	jr nz, sl_rpt_c;								// 
	push hl;								// 
	bit 6, c;								// 
	jr nz, sv_elem_str;								// 
	ld b, d;								// 
	ld c, e;								// 
	rst get_char;								// 
	cp 41;')';;								// 
	jr z, sv_number

	org $2a20
report_3:
	rst error;								// 
	defb subscript_wrong

	org $2a22
sv_number:
	rst next_char;								// 
	pop hl;								// 
	ld de, $0005;								// 
	call get_hl_x_de;								// 
	add hl, bc;								// 
	ret

	org $2a2c
sv_elem_str:
	call de_plus_1_to_de;								// 
	ex (sp), hl;								// 
	call get_hl_x_de;								// 
	pop bc;								// 
	add hl, bc;								// 
	inc hl;								// 
	ld b, d;								// 
	ld c, e;								// 
	ex de, hl;								// 
	call stk_st_0;								// 
	rst get_char;								// 
	cp 41;')';;								// 
	jr z, sv_dim;								// 
	cp 44;',';								// 
	jr nz, report_3

	org $2a45
sv_slice:
	call slicing

	org $2a48
sv_dim:
	rst next_char

	org $2a49
sv_slice_query:
	cp 40;'(';;								// 
	jr z, sv_slice;								// 
	res 6, (iy + _flags);								// 
	ret

	org $2a52
slicing:
	call syntax_z;								// 
	call nz, stk_fetch;								// 
	rst next_char;								// 
	cp 41;')';;								// 
	jr z, sl_store;								// 
	push de;								// 
	xor a;								// 
	push af;								// 
	push bc;								// 
	ld de, $0001;								// 
	rst get_char;								// 
	pop hl;								// 
	cp tk_to;								// 
	jr z, sl_second;								// 
	pop af;								// 
	call int_exp2;								// 
	push af;								// 
	ld d, b;								// 
	ld e, c;								// 
	push hl;								// 
	rst get_char;								// 
	pop hl;								// 
	cp tk_to;								// 
	jr z, sl_second;								// 
	cp 41;')';

	org $2a7a
sl_rpt_c:
	jp nz, report_c;								// 
	ld h, d;								// 
	ld l, e;								// 
	jr sl_define

	org $2a81
sl_second:
	push hl;								// 
	rst next_char;								// 
	pop hl;								// 
	cp 41;')';;								// 
	jr z, sl_define;								// 
	pop af;								// 
	call int_exp2;								// 
	push af;								// 
	rst get_char;								// 
	ld h, b;								// 
	ld l, c;								// 
	cp 41;')';;								// 
	jr nz, sl_rpt_c

	org $2a94
sl_define:
	pop af;								// 
	ex (sp), hl;								// 
	add hl, de;								// 
	dec hl;								// 
	ex (sp), hl;								// 
	and a;								// 
	sbc hl, de;								// 
	ld bc, $0000;								// 
	jr c, sl_over;								// 
	inc hl;								// 
	and a;								// 
	jp m, report_3;								// 
	ld b, h;								// 
	ld c, l

	org $2aa8
sl_over:
	pop de;								// 
	res 6, (iy + _flags)

	org $2aad
sl_store:
	call syntax_z;								// 
	ret z

	org $2ab1
stk_st_0:
	xor a

	org $2ab2
stk_sto_str:
	res 6, (iy + _flags)

	org $2ab6
stk_store:
	push bc;								// 
	call test_5_sp;								// 
	pop bc;								// 
	ld hl, (stkend);								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld (hl), e;								// 
	inc hl;								// 
	ld (hl), d;								// 
	inc hl;								// 
	ld (hl), c;								// 
	inc hl;								// 
	ld (hl), b;								// 
	inc hl;								// 
	ld (stkend), hl;								// 
	ret

	org $2acc
int_exp1:
	xor a

	org $2acd
int_exp2:
	push de;								// 
	push hl;								// 
	push af;								// 
	call expt_1num;								// 
	pop af;								// 
	call syntax_z;								// 
	jr z, i_restore;								// 
	push af;								// 
	call find_int2;								// 
	pop de;								// 
	ld a, b;								// 
	or c;								// 
	scf;								// 
	jr z, i_carry;								// 
	pop hl;								// 
	push hl;								// 
	and a;								// 
	sbc hl, bc

	org $2ae8
i_carry:
	ld a, d;								// 
	sbc a, 0

	org $2aeb
i_restore:
	pop hl;								// 
	pop de;								// 
	ret

	org $2aee
de_plus_1_to_de:
	ex de, hl;								// 
	inc hl;								// 
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	ret 

	org $2af4
get_hl_x_de:
	call syntax_z;								// 
	ret z;								// 
	call hl_hl_x_de;								// 
	jp c, report_4;								// 
	ret

	org $2aff
c_let:
	ld hl, (dest);								// 
	bit 1, (iy + _flagx);								// 
	jr z, l_exists;								// 
	ld bc, $0005

	org $2b0b
l_each_ch:
	inc bc

	org $2b0c
l_no_sp:
	inc hl;								// 
	ld a, (hl);								// 
	cp 32;' ';								// 
	jr z, l_no_sp;								// 
	jr nc, l_test_ch;								// 
	cp 16;								// 
	jr c, l_spaces;								// 
	cp 22;								// 
	jr nc, l_spaces;								// 
	inc hl;								// 
	jr l_no_sp

	org $2b1f
l_test_ch:
	call alphanum;								// 
	jr c, l_each_ch;								// 
	cp 36;'$';;								// 
	jp z, l_new_str

	org $2b29
l_spaces:
	ld a, c;								// 
	ld hl, (e_line);								// 
	dec hl;								// 
	call make_room;								// 
	inc hl;								// 
	inc hl;								// 
	ex de, hl;								// 
	push de;								// 
	ld hl, (dest);								// 
	dec de;								// 
	sub 6;								// 
	ld b, a;								// 
	jr z, l_single

	org $2b3e
l_char:
	inc hl;								// 
	ld a, (hl);								// 
	cp 33;'!';								// 
	jr c, l_char;								// 
	or %00100000;								// 
	inc de;								// 
	ld (de), a;								// 
	djnz l_char;								// 
	or %10000000;								// 
	ld (de), a;								// 
	ld a, %11000000

	org $2b4f
l_single:
	ld hl, (dest);								// 
	xor (hl);								// 
	or %00100000;								// 
	pop hl;								// 
	call l_first

	org $2b59
l_numeric:
	push hl;								// 
	fwait;								// 
	fdel;								// 
	fce;								// 
	pop hl;								// 
	ld bc, $0005;								// 
	and a;								// 
	sbc hl, bc;								// 
	jr l_enter

	org $2b66
l_exists:
	bit 6, (iy + _flags);								// 
	jr z, l_delete_str;								// 
	ld de, $0006;								// 
	add hl, de;								// 
	jr l_numeric

	org $2b72
l_delete_str:
	ld hl, (dest);								// 
	ld bc, (strlen);								// 
	bit 0, (iy + _flagx);								// 
	jr nz, l_add_str;								// 
	ld a, b;								// 
	or c;								// 
	ret z;								// 
	push hl;								// 
	rst bc_spaces;								// 
	push de;								// 
	push bc;								// 
	ld d, h;								// 
	ld e, l;								// 
	inc hl;								// 
	ld (hl), ' ';								// 
	lddr;								// 
	push hl;								// 
	call stk_fetch;								// 
	pop hl;								// 
	ex (sp), hl;								// 
	and a;								// 
	sbc hl, bc;								// 
	add hl, bc;								// 
	jr nc, l_length;								// 
	ld b, h;								// 
	ld c, l

	org $2b9b
l_length:
	ex (sp), hl;								// 
	ex de, hl;								// 
	ld a, b;								// 
	or c;								// 
	jr z, l_in_w_s;								// 
	ldir

	org $2ba3
l_in_w_s:
	pop bc;								// 
	pop de;								// 
	pop hl

	org $2ba6
l_enter:
	ex de, hl;								// 
	ld a, b;								// 
	or c;								// 
	ret z;								// 
	push de;								// 
	ldir;								// 
	pop hl;								// 
	ret

	org $2baf
l_add_str:
	dec hl;								// 
	dec hl;								// 
	dec hl;								// 
	ld a, (hl);								// 
	push hl;								// 
	push bc;								// 
	call l_string;								// 
	pop bc;								// 
	pop hl;								// 
	inc bc;								// 
	inc bc;								// 
	inc bc;								// 
	jp reclaim_2

	org $2bc0
l_new_str:
	ld a, %11011111;								// 
	ld hl, (dest);								// 
	and (hl)

	org $2bc6
l_string:
	push af;								// 
	call stk_fetch;								// 
	ex de, hl;								// 
	add hl, bc;								// 
	push bc;								// 
	dec hl;								// 
	ld (dest), hl;								// 
	inc bc;								// 
	inc bc;								// 
	inc bc;								// 
	ld hl, (e_line);								// 
	dec hl;								// 
	call make_room;								// 
	ld hl, (dest);								// 
	pop bc;								// 
	push bc;								// 
	inc bc;								// 
	lddr;								// 
	ex de, hl;								// 
	inc hl;								// 
	pop bc;								// 
	ld (hl), b;								// 
	dec hl;								// 
	ld (hl), c;								// 
	pop af

	org $2bea
l_first:
	dec hl;								// 
	ld (hl), a;								// 
	ld hl, (e_line);								// 
	dec hl;								// 
	ret

	org $2bf1
stk_fetch:
	ld hl, (stkend);								// 
	dec hl;								// 
	ld b, (hl);								// 
	dec hl;								// 
	ld c, (hl);								// 
	dec hl;								// 
	ld d, (hl);								// 
	dec hl;								// 
	ld e, (hl);								// 
	dec hl;								// 
	ld a, (hl);								// 
	ld (stkend), hl;								// 
	ret

	org $2c02
dim:
	call look_vars

	org $2c05
d_rport_c:
	jp nz, report_c;								// 
	call syntax_z;								// 
	jr nz, d_run;								// 
	res 6, c;								// 
	call stk_var;								// 
	call check_end

	org $2c15
d_run:
	jr c, d_letter;								// 
	push bc;								// 
	call next_one;								// 
	call reclaim_2;								// 
	pop bc

	org $2c1f
d_letter:
	set 7, c;								// 
	ld b, 0;								// 
	push bc;								// 
	ld hl, $0001;								// 
	bit 6, c;								// 
	jr nz, d_size;								// 
	ld l, 5

	org $2c2d
d_size:
	ex de, hl

	org $2c2e
d_no_loop:
	rst next_char;								// 
	ld h, 255;								// 
	call int_exp1;								// 
	jp c, report_3;								// 
	pop hl;								// 
	push bc;								// 
	inc h;								// 
	push hl;								// 
	ld h, b;								// 
	ld l, c;								// 
	call get_hl_x_de;								// 
	ex de, hl;								// 
	rst get_char;								// 
	cp 44;',';								// 
	jr z, d_no_loop;								// 
	cp 41;')';;								// 
	jr nz, d_rport_c;								// 
	rst next_char;								// 
	pop bc;								// 
	ld a, c;								// 
	ld l, b;								// 
	ld h, 0;								// 
	inc hl;								// 
	inc hl;								// 
	add hl, hl;								// 
	add hl, de;								// 
	jp c, report_4;								// 
	push de;								// 
	push bc;								// 
	push hl;								// 
	ld b, h;								// 
	ld c, l;								// 
	ld hl, (e_line);								// 
	dec hl;								// 
	call make_room;								// 
	inc hl;								// 
	ld (hl), a;								// 
	pop bc;								// 
	dec bc;								// 
	dec bc;								// 
	dec bc;								// 
	inc hl;								// 
	ld (hl), c;								// 
	inc hl;								// 
	ld (hl), b;								// 
	pop bc;								// 
	ld a, b;								// 
	inc hl;								// 
	ld (hl), a ;								// 
	ld h, d;								// 
	ld l, e;								// 
	dec de;								// 
	ld (hl), 0;								// 
	bit 6, c;								// 
	jr z, dim_clear;								// 
	ld (hl), ' '

	org $2c7c
dim_clear:
	pop bc;								// 
	lddr

	org $2c7f
dim_sizes:
	pop bc;								// 
	ld (hl), b;								// 
	dec hl;								// 
	ld (hl), c;								// 
	dec hl;								// 
	dec a;								// 
	jr nz, dim_sizes;								// 
	ret

	org $2c88
alphanum:
	call numeric;								// 
	ccf;								// 
	ret c

	org $2c8d
alpha:
	cp 65;'A';								// 
	ccf;								// 
	ret nc;								// 
	cp 91;'[';								// 
	ret c;								// 
	cp 97;'a';								// 
	ccf;								// 
	ret nc;								// 
	cp 123;'{';								// 
	ret

	org $2c9b
dec_to_fp:
	cp tk_bin;								// 
	jr nz, not_bin;								// 
	ld de, $0000

	org $2ca2
bin_digit:
	rst next_char;								// 
	sub '1';								// 
	adc a, 0;								// 
	jr nz, bin_end;								// 
	ex de, hl;								// 
	ccf;								// 
	adc hl, hl;								// 
	jp c, report_6;								// 
	ex de, hl;								// 
	jr bin_digit

	org $2cb3
bin_end:
	ld b, d;								// 
	ld c, e;								// 
	jp stack_bc

	org $2cb8
not_bin:
	cp 46;'.';								// 
	jr z, decimal;								// 
	call int_to_fp;								// 
	cp 46;'.';								// 
	jr nz, e_format;								// 
	rst next_char;								// 
	call numeric;								// 
	jr c, e_format;								// 
	jr dec_sto_1

	org $2ccb
decimal:
	rst next_char;								// 
	call numeric

	org $2ccf
dec_rpt_c:
	jp c, report_c;								// 
	fwait;								// 
	fstk0;								// 
	fce

	org $2cd5
dec_sto_1:
	fwait;								// 
	fstk1;								// 
	fst 0;								// 
	fdel;								// 
	fce

	org $2cda
nxt_dgt_1:
	rst get_char;								// 
	call stk_digit;								// 
	jr c, e_format;								// 
	fwait;								// 
	fgt 0;								// 
	fstk10;								// 
	fdiv;								// 
	fst 0;								// 
	fmul;								// 
	fadd;								// 
	fce;								// 
	rst next_char;								// 
	jr nxt_dgt_1

	org $2ceb
e_format:
	cp 69;'E';								// 
	jr z, sign_flag;								// 
	cp 101;'e';								// 
	ret nz

	org $2cf2
sign_flag:
	ld b, 255;								// 
	rst next_char;								// 
	cp 43;'+';								// 
	jr z, sign_done;								// 
	cp 45;'-';								// 
	jr nz, st_e_part;								// 
	inc b

	org $2cfe
sign_done:
	rst next_char

	org $2cff
st_e_part:
	call numeric;								// 
	jr c, dec_rpt_c;								// 
	push bc;								// 
	call int_to_fp;								// 
	call fp_to_a;								// 
	pop bc;								// 
	jp c, report_6;								// 
	and a;								// 
	jp m, report_6;								// 
	inc b;								// 
	jr z, e_fp_jump;								// 
	neg

	org $2d18
e_fp_jump:
	jp fp_e_to_fp

	org $2d1b
numeric:
	cp 48;'0';								// 
	ret c;								// 
	CP 58;'9' + 1;								// 
	ccf;								// 
	ret

	org $2d22
stk_digit:
	call numeric;								// 
	ret c;								// 
	sub '0'

	org $2d28
stack_a:
	ld c, a;								// 
	ld b, 0

	org $2d2b
stack_bc:
	ld iy, err_nr;								// 
	xor a;								// 
	ld e, a;								// 
	ld d, c;								// 
	ld c, b;								// 
	ld b, a;								// 
	call stk_store;								// 
	fwait;								// 
	fce;								// 
	and a;								// 
	ret

	org $2d3b
int_to_fp:
	push af;								// 
	fwait;								// 
	fstk0;								// 
	fce;								// 
	pop af

	org $2d40
nxt_dgt_2:
	call stk_digit;								// 
	ret c;								// 
	fwait;								// 
	fxch;								// 
	fstk10;								// 
	fmul;								// 
	fadd;								// 
	fce;								// 
	call ch_add_plus_1;								// 
	jr nxt_dgt_2
