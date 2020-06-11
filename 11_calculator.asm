;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $32c5
cn_stk_zero:
	defb $00, $b0, $00;					// 

	org $32c8
cn_stk_one:
	defb $40, $b0, $00, $01;			// 

	org $32cc
cn_stk_half:
	defb $30, $00;						// 

	org $32ce
cn_stk_pi_div_2:
	defb $f1, $49, $0f, $da, $a2;		// 

	org $32d3
cn_stk_ten:
	defb $40, $b0, $00, $0a;			// 

	org $32d7
tbl_addrs:
	defw fp_jump_true;					// 
	defw fp_exchange;					// 
	defw fp_delete;						// 
	defw fp_subtract;					// 
	defw fp_multiply;					// 
	defw fp_division;					// 
	defw fp_to_power;					// 
	defw fp_or;							// 
	defw fp_no_and_no;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_addition;					// 
	defw fp_str_and_no;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_comparison;					// 
	defw fp_strs_add;					// 
	defw fp_val_str;					// 
	defw fp_usr_str;					// 
	defw fp_read_in;					// 
	defw fp_negate;						// 
	defw fp_code;						// 
	defw fp_val;						// 
	defw fp_len;						// 
	defw fp_sin;						// 
	defw fp_cos;						// 
	defw fp_tan;						// 
	defw fp_asn;						// 
	defw fp_acs;						// 
	defw fp_atn;						// 
	defw fp_ln;							// 
	defw fp_exp;						// 
	defw fp_int;						// 
	defw fp_sqr;						// 
	defw fp_sgn;						// 
	defw fp_abs;						// 
	defw fp_peek;						// 
	defw fp_in;							// 
	defw fp_usr_no;						// 
	defw fp_str_str;					// 
	defw fp_chr_str;					// 
	defw fp_not;						// 
	defw fp_duplicate;					// 
	defw fp_n_mod_m;					// 
	defw fp_jump;						// 
	defw fp_stk_data;					// 
	defw fp_dec_jr_nz;					// 
	defw fp_less_0;						// 
	defw fp_greater_0;					// 
	defw fp_end_calc;					// 
	defw fp_get_argt;					// 
	defw fp_truncate;					// 
	defw fp_calc_2;						// 
	defw fp_e_to_fp;					// 
	defw fp_re_stack;					// 
	defw fp_series_xx;					// 
	defw fp_stk_const_xx;				// 
	defw fp_st_mem_xx;					// 
	defw fp_get_mem_xx;					//

	org $335b
calculate:
	call stk_pntrs;						// 

	org $335e
gen_ent_1:
	ld a, b;							// 
	ld (breg),a;							// 

	org $3362
gen_ent_2:
	exx;								// 
	ex (sp), hl;								// 
	exx;							// 

	org $3365
re_entry:
	ld (stkend), de;								// 
	exx;								// 
	ld a, (hl);								// 
	inc hl;							// 

	org $336c
scan_ent:
	push hl;								// 
	and a;								// 
	jp p, first_3d;								// 
	ld d, a;								// 
	and %01100000;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	add a, 124;								// 
	ld l, a;								// 
	ld a, d;								// 
	and %00011111;								// 
	jr ent_table;							// 

	org $3380
first_3d:
	cp 24;								// 
	jr nc, double_a;								// 
	exx;								// 
	ld bc, $fffb;								// 
	ld d, h;								// 
	ld e, l;								// 
	add hl, bc;								// 
	exx;							// 

	org $338c
double_a:
	rlca;								// 
	ld l, a

	org $338e
ent_table:
	ld de, tbl_addrs;								// 
	ld h, 0;								// 
	add hl, de;								// 
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	ld hl, re_entry;								// 
	ex (sp), hl;								// 
	push de;								// 
	exx;								// 
	ld bc, (stkend_h)

	org $33a1
fp_delete:
	ret

	org $33a2
fp_calc_2:
	pop af;								// 
	ld a, (breg);								// 
	exx;								// 
	jr scan_ent

	org $33a9
test_5_sp:
	push de;								// 
	push hl;								// 
	ld bc, $0005;								// 
	call test_room;								// 
	pop hl;								// 
	pop de;								// 
	ret

	org $33b4
stack_num:
	ld de, (stkend);								// 
	call move_fp;								// 
	ld (stkend), de;								// 
	ret

	org $33c0
fp_duplicate:
move_fp:
	call test_5_sp;								// 
	ldir;								// 
	ret

	org $33c6
fp_stk_data:
	ld h, d;								// 
	ld l, e

	org $33c8
stk_const:
	call test_5_sp;								// 
	exx;								// 
	push hl;								// 
	exx;								// 
	ex (sp), hl;								// 
	push bc;								// 
	ld a, (hl);								// 
	and %11000000;								// 
	rlca;								// 
	rlca;								// 
	ld c, a;								// 
	inc c;								// 
	ld a, (hl);								// 
	and %00111111;								// 
	jr nz, form_exp;								// 
	inc hl;								// 
	ld a, (hl)

	org $33de
form_exp:
	add a, 80;								// 
	ld (de), a;								// 
	ld a, 5;								// 
	sub c;								// 
	inc hl;								// 
	inc de;								// 
	ld b, 0;								// 
	ldir;								// 
	pop bc;								// 
	ex (sp), hl;								// 
	exx;								// 
	pop hl;								// 
	exx;								// 
	ld b, a;								// 
	xor a

	org $33f1
stk_zeros:
	dec b;								// 
	ret z;								// 
	ld (de), a;								// 
	inc de;								// 
	jr stk_zeros

	org $33f7
skip_cons:
	and a

	org $33f8
skip_next:
	ret z;								// 
	push af;								// 
	push de;								// 
	ld de, $0000;								// 
	call stk_const;								// 
	pop de;								// 
	pop af;								// 
	dec a;								// 
	jr skip_next

	org $3406
loc_mem:
	ld c, a;								// 
	rlca;								// 
	rlca;								// 
	add a, c;								// 
	ld c, a;								// 
	ld b, 0;								// 
	add hl, bc;								// 
	ret

	org $340f
fp_get_mem_xx:
	push de;								// 
	ld hl, (mem);								// 
	call loc_mem;								// 
	call move_fp;								// 
	pop hl;								// 
	ret

	org $341b
fp_stk_const_xx:
	ld h, d;								// 
	ld l, e;								// 
	exx;								// 
	push hl;								// 
	ld hl, cn_stk_zero;								// 
	exx;								// 
	call skip_cons;								// 
	call stk_const;								// 
	exx;								// 
	pop hl;								// 
	exx;								// 
	ret

	org $342d
fp_st_mem_xx:
	push hl;								// 
	ex de, hl;								// 
	ld hl, (mem);								// 
	call loc_mem;								// 
	ex de, hl;								// 
	call move_fp;								// 
	ex de, hl;								// 
	pop hl;								// 
	ret

	org $343c
fp_exchange:
	ld b, 5

	org $343e
swap_byte:
	ld a, (de);								// 
	ld c, (hl);								// 
	ex de, hl;								// 
	ld (de), a;								// 
	ld (hl), c;								// 
	inc hl;								// 
	inc de;								// 
	djnz swap_byte;								// 
	ex de, hl;								// 
	ret

	org $3449
fp_series_xx:
	ld b, a;								// 
	call gen_ent_1;								// 
	fmove;								// 
	fadd;								// 
	fst 0;								// 
	fdel;								// 
	fstk0;								// 
	fst 2

	org $3453
g_loop:
	fmove;								// 
	fgt 0;								// 
	fmul;								// 
	fgt 2;								// 
	fst 1;								// 
	fsub;								// 
	fce;								// 
	call fp_stk_data;								// 
	call gen_ent_2;								// 
	fadd;								// 
	fxch;								// 
	fst 2;								// 
	fdel;								// 
	fdjnz g_loop;								// 
	fgt 1;								// 
	fsub;								// 
	fce;								// 
	ret

	org $346a
fp_abs:
	ld b, $ff;								// 
	jr neg_test

	org $346e
fp_negate:
	call test_zero;								// 
	ret c;								// 
	ld b, 0

	org $3474
neg_test:
	ld a, (hl);								// 
	and a;								// 
	jr z, int_case;								// 
	inc hl;								// 
	ld a, b;								// 
	and %10000000;								// 
	or (hl);								// 
	rla;								// 
	ccf;								// 
	rra;								// 
	ld (hl), a;								// 
	dec hl;								// 
	ret

	org $3483
int_case:
	push de;								// 
	push hl;								// 
	call int_fetch;								// 
	pop hl;								// 
	ld a, b;								// 
	or c;								// 
	cpl;								// 
	ld c, a;								// 
	call int_store;								// 
	pop de;								// 
	ret

	org $3492
fp_sgn:
	call test_zero;								// 
	ret c;								// 
	push de;								// 
	ld de, $0001;								// 
	inc hl;								// 
	rl (hl);								// 
	dec hl;								// 
	sbc a, a;								// 
	ld c, a;								// 
	call int_store;								// 
	pop de;								// 
	ret

	org $34a5
fp_in:
	call find_int2;								// 
	in a, (c);								// 
	jr in_pk_stk

	org $34ac
fp_peek:
	call find_int2;								// 
	ld a, (bc)

	org $34b0
in_pk_stk:
	jp stack_a

	org $34b3
fp_usr_no:
	call find_int2;								// 
	ld hl, stack_bc;								// 
	push hl;								// 
	push bc;								// 
	ret

	org $34bc
fp_usr_str:
	call stk_fetch;								// 
	dec bc;								// 
	ld a, b;								// 
	or c;								// 
	jr nz, report_a;								// 
	ld a, (de);								// 
	call alpha;								// 
	jr c, usr_range;								// 
	sub 144;								// 
	jr c, report_a;								// 
	cp 21;								// 
	jr nc, report_a;								// 
	inc a

	org $34d3
usr_range:
	dec a;								// 
	add a, a;								// 
	add a, a;								// 
	add a, a;								// 
	cp $a8;								// 
	jr nc, report_a;								// 
	ld bc, (udg);								// 
	add a, c;								// 
	ld c, a;								// 
	jr nc, usr_stack;								// 
	inc b

	org $34e4
usr_stack:
	jp stack_bc

	org $34e7
report_a:
	rst error;								// 
	defb invalid_argument

	org $34e9
test_zero:
	push hl;								// 
	push bc;								// 
	ld b, a;								// 
	ld a, (hl);								// 
	inc hl;								// 
	or (hl);								// 
	inc hl;								// 
	or (hl);								// 
	inc hl;								// 
	or (hl);								// 
	ld a, b;								// 
	pop bc;								// 
	pop hl;								// 
	ret nz;								// 
	scf;								// 
	ret

	org $34f9
fp_greater_0:
	call test_zero;								// 
	ret c;								// 
	ld a, $ff;								// 
	jr sign_to_c

	org $3501
fp_not:
	call test_zero;								// 
	jr fp_0_div_1

	org $3506
fp_less_0:
	xor a

	org $3507
sign_to_c:
	inc hl;								// 
	xor (hl);								// 
	dec hl;								// 
	rlca

	org $350b
fp_0_div_1:
	push hl;								// 
	ld a, 0;								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld (hl), a;								// 
	inc hl;								// 
	rla;								// 
	ld (hl), a;								// 
	rra;								// 
	inc hl;								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld (hl), a;								// 
	pop hl;								// 
	ret

	org $351b
fp_or:
	ex de, hl;								// 
	call test_zero;								// 
	ex de, hl;								// 
	ret c;								// 
	scf;								// 
	jr fp_0_div_1

	org $3524
fp_no_and_no:
	ex de, hl;								// 
	call test_zero;								// 
	ex de, hl;								// 
	ret nc;								// 
	and a;								// 
	jr fp_0_div_1

	org $352d
fp_str_and_no:
	ex de, hl;								// 
	call test_zero;								// 
	ex de, hl;								// 
	ret nc;								// 
	push de;								// 
	dec de;								// 
	xor a;								// 
	ld (de), a;								// 
	dec de;								// 
	ld (de), a;								// 
	pop de;								// 
	ret

	org $353b
fp_comparison:
	ld a, b;								// 
	sub 8;								// 
	bit 2, a;								// 
	jr nz, ex_or_not;								// 
	dec a

	org $3543
ex_or_not:
	rrca;								// 
	jr nc, nu_or_str;								// 
	push af;								// 
	push hl;								// 
	call fp_exchange;								// 
	pop de;								// 
	ex de, hl;								// 
	pop af

	org $354e
nu_or_str:
	bit 2, a;								// 
	jr nz, strings;								// 
	rrca;								// 
	push af;								// 
	call fp_subtract;								// 
	jr end_tests

	org $3559
strings:
	rrca;								// 
	push af;								// 
	call stk_fetch;								// 
	push de;								// 
	push bc;								// 
	call stk_fetch;								// 
	pop hl

	org $3564
byte_comp:
	ld a, h;								// 
	or l;								// 
	ex (sp), hl;								// 
	ld a, b;								// 
	jr nz, sec_plus;								// 
	or c

	org $356b
secnd_low:
	pop bc;								// 
	jr z, both_null;								// 
	pop af;								// 
	ccf;								// 
	jr str_test

	org $3572
both_null:
	pop af;								// 
	jr str_test

	org $3575
sec_plus:
	or c;								// 
	jr z, frst_less;								// 
	ld a, (de);								// 
	sub (hl);								// 
	jr c, frst_less;								// 
	jr nz, secnd_low;								// 
	dec bc;								// 
	inc de;								// 
	inc hl;								// 
	ex (sp), hl;								// 
	dec hl;								// 
	jr byte_comp

	org $3585
frst_less:
	pop bc;								// 
	pop af;								// 
	and a

	org $3588
str_test:
	push af;								// 
	fwait;								// 
	fstk0;								// 
	fce

	org $358c
end_tests:
	pop af;								// 
	push af;								// 
	call c, fp_not;								// 
	pop af;								// 
	push af;								// 
	call nc, fp_greater_0;								// 
	pop af;								// 
	rrca;								// 
	call nc, fp_not;								// 
	ret

	org $359c
fp_strs_add:
	call stk_fetch;								// 
	push de;								// 
	push bc;								// 
	call stk_fetch;								// 
	pop hl;								// 
	push hl;								// 
	push de;								// 
	push bc;								// 
	add hl, bc;								// 
	ld b, h;								// 
	ld c, l;								// 
	rst bc_spaces;								// 
	call stk_sto_str;								// 
	pop bc;								// 
	pop hl;								// 
	ld a, b;								// 
	or c;								// 
	jr z, other_str;								// 
	ldir

	org $35b7
other_str:
	pop bc;								// 
	pop hl;								// 
	ld a, b;								// 
	or c;								// 
	jr z, stk_pntrs;								// 
	ldir

	org $35bf
stk_pntrs:
	ld hl, (stkend);								// 
	ld de, $fffb;								// 
	push hl;								// 
	add hl, de;								// 
	pop de;								// 
	ret

	org $35c9
fp_chr_str:
	call fp_to_a;								// 
	jr c, report_bd;								// 
	jr nz, report_bd;								// 
	push af;								// 
	ld bc, $0001;								// 
	rst bc_spaces;								// 
	pop af;								// 
	ld (de), a;								// 
	call stk_sto_str;								// 
	ex de, hl;								// 
	ret

	org $35dc
report_bd:
	rst error;								// 
	defb integer_out_of_range

	org $35de
fp_val:
fp_val_str:
	ld hl, (ch_add);								// 
	push hl;								// 
	ld a, b;								// 
	add a, 227;								// 
	sbc a, a;								// 
	push af;								// 
	call stk_fetch;								// 
	push de;								// 
	inc bc;								// 
	rst bc_spaces;								// 
	pop hl;								// 
	ld (ch_add), de;								// 
	push de;								// 
	ldir;								// 
	ex de, hl;								// 
	dec hl;								// 
	ld (hl), ctrl_enter;								// 
	res 7, (iy + _flags);								// 
	call scanning;								// 
	rst get_char;								// 
	cp ctrl_enter;								// 
	jr nz, v_rport_c;								// 
	pop hl;								// 
	pop af;								// 
	xor (iy + _flags);								// 
	and %01000000

	org $360c
v_rport_c:
	jp nz, report_c;								// 
	ld (ch_add), hl;								// 
	set 7, (iy + _flags);								// 
	call scanning;								// 
	pop hl;								// 
	ld (ch_add), hl;								// 
	jr stk_pntrs

	org $361f
fp_str_str:
	ld bc, $0001;								// 
	rst bc_spaces;								// 
	ld (k_cur), hl;								// 
	push hl;								// 
	ld hl, (curchl);								// 
	push hl;								// 
	ld a, $ff;								// 
	call chan_open;								// 
	call print_fp;								// 
	pop hl;								// 
	call chan_flag;								// 
	pop de;								// 
	ld hl, (k_cur);								// 
	and a;								// 
	sbc hl, de;								// 
	ld b, h;								// 
	ld c, l;								// 
	call stk_sto_str;								// 
	ex de, hl;								// 
	ret

	org $3645
fp_read_in:
	call find_int1;								// 
	cp 16;								// 
	jp nc, report_bb;								// 
	ld hl, (curchl);								// 
	push hl;								// 
	call chan_open;								// 
	call input_ad;								// 
	ld bc, $0000;								// 
	jr nc, r_i_store;								// 
	inc c;								// 
	rst bc_spaces;								// 
	ld (de), a

	org $365f
r_i_store:
	call stk_sto_str;								// 
	pop hl;								// 
	call chan_flag;								// 
	jp stk_pntrs

	org $3669
fp_code:
	call stk_fetch;								// 
	ld a, b;								// 
	or c;								// 
	jr z, stk_code;								// 
	ld a, (de)

	org $3671
stk_code:
	jp stack_a

	org $3674
fp_len:
	call stk_fetch;								// 
	jp stack_bc

	org $367a
fp_dec_jr_nz:
	exx;								// 
	push hl;								// 
	ld hl, breg;								// 
	dec (hl);								// 
	pop hl;								// 
	jr nz, jump_2;								// 
	inc hl;								// 
	exx;								// 
	ret

	org $3686
fp_jump:
	exx

	org $3687
jump_2:
	ld e, (hl);								// 
	ld a, e;								// 
	rla;								// 
	sbc a, a;								// 
	ld d, a;								// 
	add hl, de;								// 
	exx;								// 
	ret

	org $368f
fp_jump_true:
	inc de;								// 
	inc de;								// 
	ld a, (de);								// 
	dec de;								// 
	dec de;								// 
	and a;								// 
	jr nz, fp_jump;								// 
	exx;								// 
	inc hl;								// 
	exx;								// 
	ret

	org $369b
fp_end_calc:
	pop af;								// 
	exx;								// 
	ex (sp), hl;								// 
	exx;								// 
	ret

	org $36a0
fp_n_mod_m:
	fwait;								// 
	fst 0;								// 
	fdel;								// 
	fmove;								// 
	fgt 0;								// 
	fdiv;								// 
	fint;								// 
	fgt 0;								// 
	fxch;								// 
	fst 0;								// 
	fmul;								// 
	fsub;								// 
	fgt 0;								// 
	fce;								// 
	ret

	org $36af
fp_int:
	fwait;								// 
	fmove;								// 
	fcp lz;								// 
	fjpt x_neg;								// 
	ftrn;								// 
	fce;								// 
	ret

	org $36b7
x_neg:
	fmove;								// 
	ftrn;								// 
	fst 0;								// 
	fsub;								// 
	fgt 0;								// 
	fxch;								// 
	fnot;								// 
	fjpt exit;								// 
	fstk1;								// 
	fsub

	org $36c2
exit:
	fce;								// 
	ret

	org $36c4
fp_exp:
	fwait;								// 
	frstk;								// 
	fstk;								// 
	defb $f1, $38, $aa, $3b, $29;								// 
	fmul;								// 
	fmove;								// 
	fint;								// 
	fst 3;								// 
	fsub;								// 
	fmove;								// 
	fadd;								// 
	fstk1;								// 
	fsub;								// 
	defb $88;								// 
	defb $13, $36;								// 
	defb $58, $65, $66;								// 
	defb $9d, $78, $65, $40;								// 
	defb $a2, $60, $32, $c9;								// 
	defb $e7, $21, $f7, $af, $24;								// 
	defb $eb, $2f, $b0, $b0, $14;								// 
	defb $ee, $7e, $bb, $94, $58;								// 
	defb $f1, $3a, $7e, $f8, $cf;								// 
	fgt 3;								// 
	fce;								// 
	call fp_to_a;								// 
	jr nz, n_negtv;								// 
	jr c, report_6b;								// 
	add a, (hl);								// 
	jr nc, result_ok

	org $3703
report_6b:
	rst error;								// 
	defb number_too_big

	org $3705
n_negtv:
	jr c, rslt_zero;								// 
	sub (hl);								// 
	jr nc, rslt_zero;								// 
	neg

	org $370c
result_ok:
	ld (hl), a;								// 
	ret

	org $370e
rslt_zero:
	fwait;								// 
	fdel;								// 
	fstk0;								// 
	fce;								// 
	ret

	org $3713
fp_ln:
	fwait;								// 
	frstk;								// 
	fmove;								// 
	fcp gz;								// 
	fjpt valid;								// 
	fce

	org $371a
report_ab:
	rst error;								// 
	defb invalid_argument

	org $371c
valid:
	fstk0;								// 
	fdel;								// 
	fce;								// 
	ld a, (hl);								// 
	ld (hl), $80;								// 
	call stack_a;								// 
	fwait;								// 
	fstk;								// 
	defb $38, $00;								// 
	fsub;								// 
	fxch;								// 
	fmove;								// 
	fstk;								// 
	defb $f0, $4c, $cc, $cc, $cd;								// 
	fsub;								// 
	fcp gz;								// 
	fjpt gre_8;								// 
	fxch;								// 
	fstk1;								// 
	fsub;								// 
	fxch;								// 
	fce;								// 
	inc (hl);								// 
	fwait

	org $373d
gre_8:
	fxch;								// 
	fstk;								// 
	defb $f0, $31, $72, $17, $f8;								// 
	fmul;								// 
	fxch;								// 
	fstk.5;								// 
	fsub;								// 
	fstk.5;								// 
	fsub;								// 
	fmove;								// 
	fstk;								// 
	defb $32, $20;								// 
	fmul;								// 
	fstk.5;								// 
	fsub;								// 
	defb $8c;								// 
	defb $11, $ac;								// 
	defb $14, $09;								// 
	defb $56, $da, $a5;								// 
	defb $59, $30, $c5;								// 
	defb $5c, $90, $aa;								// 
	defb $9e, $70, $6f, $61;								// 
	defb $a1, $cb, $da, $96;								// 
	defb $a4, $31, $9f, $b4;								// 
	defb $e7, $a0, $fe, $5c, $fc;								// 
	defb $ea, $1b, $43, $ca, $36;								// 
	defb $ed, $a7, $9c, $7e, $5e;								// 
	defb $f0, $6e, $23, $80, $93;								// 
	fmul;								// 
	fadd;								// 
	fce;								// 
	ret

	org $3783
fp_get_argt:
	fwait;								// 
	frstk;								// 
	fstk;								// 
	defb $ee, $22, $f9, $83, $6e;								// 
	fmul;								// 
	fmove;								// 
	fstk.5;								// 
	fadd;								// 
	fint;								// 
	fsub;								// 
	fmove;								// 
	fadd;								// 
	fmove;								// 
	fadd;								// 
	fmove;								// 
	fabs;								// 
	fstk1;								// 
	fsub;								// 
	fmove;								// 
	fcp gz;								// 
	fst 0;								// 
	fjpt zplus;								// 
	fdel;								// 
	fce;								// 
	ret

	org $37a1
zplus:
	fstk1;								// 
	fsub;								// 
	fxch;								// 
	fcp lz;								// 
	fjpt yneg;								// 
	fneg

	org $37a8
yneg:
	fce;								// 
	ret

	org $37aa
fp_cos:
	fwait;								// 
	fget;								// 
	fabs;								// 
	fstk1;								// 
	fsub;								// 
	fgt 0;								// 
	fjpt c_ent;								// 
	fneg;								// 
	fjp c_ent

	org $37b5
fp_sin:
	fwait;								// 
	fget

	org $37b7
c_ent:
	fmove;								// 
	fmove;								// 
	fmul;								// 
	fmove;								// 
	fadd;								// 
	fstk1;								// 
	fsub;								// 
	defb $86;								// 
	defb $14, $e6;								// 
	defb $5c, $1f, $0b;								// 
	defb $a3, $8f, $38, $ee;								// 
	defb $e9, $15, $63, $bb, $23;								// 
	defb $ee, $92, $0d, $cd, $ed;								// 
	defb $f1, $23, $5d, $1b, $ea;								// 
	fmul;								// 
	fce;								// 
	ret

	org $37da
fp_tan:
	fwait;								// 
	fmove;								// 
	fsin;								// 
	fxch;								// 
	fcos;								// 
	fdiv;								// 
	fce;								// 
	ret

	org $37e2
fp_atn:
	call fp_re_stack;								// 
	ld a, (hl);								// 
	cp $81;								// 
	jr c, small;								// 
	fwait;								// 
	fstk1;								// 
	fneg;								// 
	fxch;								// 
	fdiv;								// 
	fmove;								// 
	fcp lz;								// 
	fstkpix.5;								// 
	fxch;								// 
	fjpt cases;								// 
	fneg;								// 
	fjp cases

	org $37f8
small:
	fwait;								// 
	fstk0

	org $37fa
cases:
	fxch;								// 
	fmove;								// 
	fmove;								// 
	fmul;								// 
	fmove;								// 
	fadd;								// 
	fstk1;								// 
	fsub;								// 
	defb $8c;								// 
	defb $10, $b2;								// 
	defb $13, $0e;								// 
	defb $55, $e4, $8d;								// 
	defb $58, $39, $bc;								// 
	defb $5b, $98, $fd;								// 
	defb $9e, $00, $36, $75;								// 
	defb $a0, $db, $e8, $b4;								// 
	defb $63, $42, $c4;								// 
	defb $e6, $b5, $09, $36, $be;								// 
	defb $e9, $36, $73, $1b, $5d;								// 
	defb $ec, $d8, $de, $63, $be;								// 
	defb $f0, $61, $a1, $b3, $0c;								// 
	fmul;								// 
	fadd;								// 
	fce;								// 
	ret

	org $3833
fp_asn:
	fwait;								// 
	fmove;								// 
	fmove;								// 
	fmul;								// 
	fstk1;								// 
	fsub;								// 
	fneg;								// 
	fsqrt;								// 
	fstk1;								// 
	fadd;								// 
	fdiv;								// 
	fatan;								// 
	fmove;								// 
	fadd;								// 
	fce;								// 
	ret

	org $3843
fp_acs:
	fwait;								// 
	fasin;								// 
	fstkpix.5;								// 
	fsub;								// 
	fneg;								// 
	fce;								// 
	ret

	org $384a
fp_sqr:
	fwait;								// 
	fmove;								// 
	fnot;								// 
	fjpt last;								// 
	fstk.5;								// 
	fce

	org $3851
fp_to_power:
	fwait;								// 
	fxch;								// 
	fmove;								// 
	fnot;								// 
	fjpt xis0;								// 
	flogn;								// 
	fmul;								// 
	fce;								// 
	jp fp_exp

	org $385d
xis0:
	fdel;								// 
	fmove;								// 
	fnot;								// 
	fjpt one;								// 
	fstk0;								// 
	fxch;								// 
	fcp gz;								// 
	fjpt last;								// 
	fstk1;								// 
	fxch;								// 
	fdiv

	org $386a
one:
	fdel;								// 
	fstk1

	org $386c
last:
	fce;								// 
	ret  
