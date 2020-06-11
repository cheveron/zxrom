;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $2d4f
fp_e_to_fp:
	rlca;								// 
	rrca;								// 
	jr nc, e_save;								// 
	cpl;								// 
	inc a

	org $2d55
e_save:
	push af;								// 
	ld hl, membot;								// 
	call fp_0_div_1;								// 
	fwait;								// 
	fstk10;								// 
	fce;								// 
	pop af

	org $2d60
e_loop:
	srl a;								// 
	jr nc, e_tst_end;								// 
	push af;								// 
	fwait;								// 
	fst 1;								// 
	fgt 0;								// 
	fjpt e_divsn;								// 
	fmul;								// 
	fjp e_fetch

	org $2d6d
e_divsn:
	fdiv

	org $2d6e
e_fetch:
	fgt 1;								// 
	fce;								// 
	pop af

	org $2d71
e_tst_end:
	jr z, e_end;								// 
	push af;								// 
	fwait;								// 
	fmove;								// 
	fmul;								// 
	fce;								// 
	pop af;								// 
	jr e_loop

	org $2d7b
e_end:
	fwait;								// 
	fdel;								// 
	fce;								// 
	ret

	org $2d7f
int_fetch:
	inc hl;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld a, (hl);								// 
	xor c;								// 
	sub c;								// 
	ld e, a;								// 
	inc hl;								// 
	ld a, (hl);								// 
	adc a, c;								// 
	xor c;								// 
	ld d, a;								// 
	ret

	org $2d8c
p_int_sto:
	ld c, 0

	org $2d8e
int_store:
	push hl;								// 
	ld (hl), 0;								// 
	inc hl;								// 
	ld (hl), c;								// 
	inc hl;								// 
	ld a, e;								// 
	xor c;								// 
	sub c;								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld a, d;								// 
	adc a, c;								// 
	xor c;								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld (hl), 0;								// 
	pop hl;								// 
	ret

	org $2da2
fp_to_bc:
	fwait;								// 
	fce;								// 
	ld a, (hl);								// 
	and a;								// 
	jr z, fp_to_bc_delete;								// 
	fwait;								// 
	fstk.5;								// 
	fadd;								// 
	fint;								// 
	fce

	org $2dad
fp_to_bc_delete:
	fwait;								// 
	fdel;								// 
	fce;								// 
	push hl;								// 
	push de;								// 
	ex de, hl;								// 
	ld b, (hl);								// 
	call int_fetch;								// 
	xor a;								// 
	sub b;								// 
	bit 7, c;								// 
	ld b, d;								// 
	ld c, e;								// 
	ld a, e;								// 
	pop de;								// 
	pop hl;								// 
	ret

	org $2dc1
log_2_a:
	ld d, a;								// 
	rla;								// 
	sbc a, a;								// 
	ld e, a;								// 
	ld c, a;								// 
	xor a;								// 
	ld b, a;								// 
	call stk_store;								// 
	fwait;								// 
	fstk;								// 
	defb $ef, $1a, $20, $9a, $85;								// 
	fmul;								// 
	fint;								// 
	fce

	org $2dd5
fp_to_a:
	call fp_to_bc;								// 
	ret c;								// 
	push af;								// 
	dec b;								// 
	inc b;								// 
	jr z, fp_a_end;								// 
	pop af;								// 
	scf;								// 
	ret

	org $2de1
fp_a_end:
	pop af;								// 
	ret

	org $2de3
print_fp:
	fwait;								// 
	fmove;								// 
	fcp lz;								// 
	fjpt pf_negtve;								// 
	fmove;								// 
	fcp gz;								// 
	fjpt pf_postve;								// 
	fdel;								// 
	fce;								// 
	ld a, '0';								// 
	rst print_a;								// 
	ret

	org $2df2
pf_negtve:
	fabs;								// 
	fce;								// 
	ld a, '-';								// 
	rst print_a;								// 
	fwait

	org $2df8
pf_postve:
	fstk0;								// 
	fst 3;								// 
	fst 4;								// 
	fst 5;								// 
	fdel;								// 
	fce;								// 
	exx;								// 
	push hl;								// 
	exx

	org $2e01
pf_loop:
	fwait;								// 
	fmove;								// 
	fint;								// 
	fst 2;								// 
	fsub;								// 
	fgt 2;								// 
	fxch;								// 
	fst 2;								// 
	fdel;								// 
	fce;								// 
	ld a, (hl);								// 
	and a;								// 
	jr nz, pf_large;								// 
	call int_fetch;								// 
	ld b, 16;								// 
	ld a, d;								// 
	and a;								// 
	jr nz, pf_save;								// 
	or e;								// 
	jr z, pf_small ;								// 
	ld d, e;								// 
	ld b, 8

	org $2e1e
pf_save:
	push de;								// 
	exx;								// 
	pop de;								// 
	exx;								// 
	jr pf_bits

	org $2e24
pf_small:
	fwait;								// 
	fgt 2;								// 
	fce;								// 
	ld a, (hl);								// 
	sub 126;								// 
	call log_2_a;								// 
	ld d, a;								// 
	ld a, (mem_5_1);								// 
	sub d;								// 
	ld (mem_5_1), a;								// 
	ld a, d ;								// 
	call fp_e_to_fp;								// 
	fwait;								// 
	fmove;								// 
	fint;								// 
	fst 1;								// 
	fsub;								// 
	fgt 1;								// 
	fce;								// 
	call fp_to_a;								// 
	push hl;								// 
	ld (mem_3), a;								// 
	dec a;								// 
	rla;								// 
	sbc a, a;								// 
	inc a;								// 
	ld hl, mem_5;								// 
	ld (hl), a;								// 
	inc hl;								// 
	add a, (hl);								// 
	ld (hl), a;								// 
	pop hl;								// 
	jp pf_fractn

	org $2e56
pf_large:
	sub 128;								// 
	cp 28;								// 
	jr c, pf_medium;								// 
	call log_2_a;								// 
	sub 7;								// 
	ld b, a;								// 
	ld hl, mem_5_1;								// 
	add a, (hl);								// 
	ld (hl), a;								// 
	ld a, b ;								// 
	neg;								// 
	call fp_e_to_fp;								// 
	jr pf_loop

	org $2e6f
pf_medium:
	ex de, hl;								// 
	call fetch_two;								// 
	exx;								// 
	set 7, d;								// 
	ld a, l;								// 
	exx;								// 
	sub 128;								// 
	ld b, a

	org $2e7b
pf_bits:
	sla e;								// 
	rl d;								// 
	exx;								// 
	rl e;								// 
	rl d;								// 
	exx;								// 
	ld hl, mem_4_4;								// 
	ld c, 5

	org $2e8a
pf_bytes:
	ld a, (hl);								// 
	adc a, a;								// 
	daa;								// 
	ld (hl), a;								// 
	dec hl;								// 
	dec c;								// 
	jr nz, pf_bytes;								// 
	djnz pf_bits;								// 
	xor a;								// 
	ld hl, mem_4;								// 
	ld de, mem_3;								// 
	ld b, $09;								// 
	rld;								// 
	ld c, 255

	org $2ea1
pf_digits:
	rld;								// 
	jr nz, pf_insert;								// 
	dec c;								// 
	inc c;								// 
	jr nz, pf_test_2

	org $2ea9
pf_insert:
	ld (de), a;								// 
	inc de;								// 
	inc (iy + _mem_5);								// 
	inc (iy + _mem_5_1);								// 
	ld c, 0

	org $2eb3
pf_test_2:
	bit 0, b;								// 
	jr z, pf_all_9;								// 
	inc hl

	org $2eb8
pf_all_9:
	djnz pf_digits;								// 
	ld a, (mem_5);								// 
	sub 9;								// 
	jr c, pf_more;								// 
	dec (iy + _mem_5);								// 
	ld a, 4;								// 
	cp (iy + _mem_4_3);								// 
	jr pf_round;								// 
	
	org $2ecb
pf_more:
	fwait;								// 
	fdel;								// 
	fgt 2;								// 
	fce

	org $2ecf
pf_fractn:
	ex de, hl;								// 
	call fetch_two;								// 
	exx;								// 
	ld a, 128;								// 
	sub l;								// 
	ld l, 0;								// 
	set 7, d;								// 
	exx;								// 
	call shift_fp

	org $2edf
pf_frn_lp:
	ld a, (iy + _mem_5);								// 
	cp 8;								// 
	jr c, pf_fr_dgt;								// 
	exx;								// 
	rl d;								// 
	exx;								// 
	jr pf_round

	org $2eec
pf_fr_dgt:
	ld bc, $0200

	org $2eef
pf_fr_exx:
	ld a, e;								// 
	call ca_10a_plus_c;								// 
	ld e, a;								// 
	ld a, d;								// 
	call ca_10a_plus_c;								// 
	ld d, a;								// 
	push bc;								// 
	exx;								// 
	pop bc;								// 
	djnz pf_fr_exx;								// 
	ld hl, mem_3;								// 
	ld a, c;								// 
	ld c, (iy + _mem_5);								// 
	add hl, bc;								// 
	ld (hl), a;								// 
	inc (iy + _mem_5);								// 
	jr pf_frn_lp

	org $2f0c
pf_round:
	push af;								// 
	ld hl, mem_3;								// 
	ld c, (iy + _mem_5);								// 
	ld b, 0;								// 
	add hl, bc;								// 
	ld b, c;								// 
	pop af

	org $2f18
pf_rnd_lp:
	dec hl;								// 
	ld a, (hl);								// 
	adc a, 0;								// 
	ld (hl), a;								// 
	and a;								// 
	jr z, pf_r_back;								// 
	cp 10;								// 
	ccf;								// 
	jr nc, pf_count

	org $2f25
pf_r_back:
	djnz pf_rnd_lp;								// 
	ld (hl), 1;								// 
	inc b;								// 
	inc (iy + _mem_5_1)

	org $2f2d
pf_count:
	ld (iy + _mem_5), b;								// 
	fwait;								// 
	fdel;								// 
	fce;								// 
	exx;								// 
	pop hl;								// 
	exx;								// 
	ld bc, (mem_5);								// 
	ld hl, mem_3;								// 
	ld a, b;								// 
	cp 9;								// 
	jr c, pf_not_e;								// 
	cp 252;								// 
	jr c, pf_e_frmt

	org $2f46
pf_not_e:
	and a;								// 
	call z, out_code

	org $2f4a
pf_e_sbrn:
	xor a;								// 
	sub b;								// 
	jp m, pf_out_lp;								// 
	ld b, a;								// 
	jr pf_dc_out

	org $2f52
pf_out_lp:
	ld a, c;								// 
	and a;								// 
	jr z, pf_out_dt;								// 
	ld a, (hl);								// 
	inc hl;								// 
	dec c

	org $2f59
pf_out_dt:
	call out_code;								// 
	djnz pf_out_lp

	org $2f5e
pf_dc_out:
	ld a, c;								// 
	and a;								// 
	ret z;								// 
	inc b;								// 
	ld a, '.'

	org $2f64
pf_dec_0s:
	rst print_a;								// 
	ld a, '0';								// 
	djnz pf_dec_0s;								// 
	ld b, c;								// 
	jr pf_out_lp

	org $2f6c
pf_e_frmt:
	ld d, b;								// 
	dec d;								// 
	ld b, 1;								// 
	call pf_e_sbrn;								// 
	ld a, 'E';								// 
	rst print_a;								// 
	ld c, d;								// 
	ld a, c;								// 
	and a;								// 
	jp p, pf_e_pos;								// 
	neg;								// 
	ld c, a;								// 
	ld a, '-';								// 
	jr pf_e_sign

	org $2f83
pf_e_pos:
	ld a, '+'

	org $2f85
pf_e_sign:
	rst print_a;								// 
	ld b, 0;								// 
	jp out_num_1

	org $2f8b
ca_10a_plus_c:
	push de;								// 
	ld l, a;								// 
	ld h, 0;								// 
	ld e, l;								// 
	ld d, h;								// 
	add hl, hl;								// 
	add hl, hl;								// 
	add hl, de;								// 
	add hl, hl;								// 
	ld e, c;								// 
	add hl, de;								// 
	ld c, h;								// 
	ld a, l;								// 
	pop de;								// 
	ret

	org $2f9b
prep_add:
	ld a, (hl);								// 
	ld (hl), 0;								// 
	and a;								// 
	ret z;								// 
	inc hl;								// 
	bit 7, (hl);								// 
	set 7, (hl);								// 
	dec hl;								// 
	ret z;								// 
	push bc;								// 
	ld bc, $0005;								// 
	add hl, bc;								// 
	ld b, c;								// 
	ld c, a;								// 
	scf

	org $2faf
neg_byte:
	dec hl;								// 
	ld a, (hl);								// 
	cpl;								// 
	adc a, 0;								// 
	ld (hl), a;								// 
	djnz neg_byte;								// 
	ld a, c;								// 
	pop bc;								// 
	ret

	org $2fba
fetch_two:
	push hl;								// 
	push af;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld a, c;								// 
	ld c, (hl);								// 
	push bc;								// 
	inc hl;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	ex de, hl;								// 
	ld d, a;								// 
	ld e, (hl);								// 
	push de;								// 
	inc hl;								// 
	ld d, (hl);								// 
	inc hl;								// 
	ld e, (hl);								// 
	push de;								// 
	exx;								// 
	pop de;								// 
	pop hl;								// 
	pop bc;								// 
	exx;								// 
	inc hl;								// 
	ld d, (hl);								// 
	inc hl;								// 
	ld e, (hl);								// 
	pop af;								// 
	pop hl;								// 
	ret

	org $2fdd
shift_fp:
	and a;								// 
	ret z;								// 
	cp 33;								// 
	jr nc, addend_0;								// 
	push bc;								// 
	ld b, a

	org $2fe5
one_shift:
	exx;								// 
	sra l;								// 
	rr d;								// 
	rr e;								// 
	exx;								// 
	rr d;								// 
	rr e;								// 
	djnz one_shift;								// 
	pop bc;								// 
	ret nc;								// 
	call add_back;								// 
	ret nz

	org $2ff9
addend_0:
	exx;								// 
	xor a

	org $2ffb
zeros_4_5:
	ld l, 0;								// 
	ld d, a;								// 
	ld e, l;								// 
	exx;								// 
	ld de, $0000;								// 
	ret 

	org $3004
add_back:
	inc e;								// 
	ret nz;								// 
	inc d;								// 
	ret nz;								// 
	exx;								// 
	inc e;								// 
	jr nz, all_added;								// 
	inc d

	org $300d
all_added:
	exx;								// 
	ret 

	org $300f
fp_subtract:
	ex de, hl;								// 
	call fp_negate;								// 
	ex de, hl

	org $3014
fp_addition:
	ld a, (de);								// 
	or (hl);								// 
	jr nz, full_addn;								// 
	push de;								// 
	inc hl;								// 
	push hl;								// 
	inc hl;								// 
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld a, (hl);								// 
	inc hl;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	pop hl;								// 
	ex de, hl;								// 
	add hl, bc;								// 
	ex de, hl;								// 
	adc a, (hl);								// 
	rrca;								// 
	adc a, 0;								// 
	jr nz, addn_oflw;								// 
	sbc a, a;								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld (hl), e;								// 
	inc hl;								// 
	ld (hl), d;								// 
	dec hl;								// 
	dec hl;								// 
	dec hl;								// 
	pop de;								// 
	ret

	org $303c
addn_oflw:
	dec hl;								// 
	pop de

	org $303e
full_addn:
	call re_st_two;								// 
	exx;								// 
	push hl;								// 
	exx;								// 
	push de;								// 
	push hl;								// 
	call prep_add;								// 
	ld b, a;								// 
	ex de, hl;								// 
	call prep_add;								// 
	ld c, a;								// 
	cp b;								// 
	jr nc, shift_len;								// 
	ld a, b;								// 
	ld b, c;								// 
	ex de, hl

	org $3055
shift_len:
	push af;								// 
	sub b;								// 
	call fetch_two;								// 
	call shift_fp;								// 
	pop af;								// 
	pop hl;								// 
	ld (hl), a;								// 
	push hl;								// 
	ld l, b;								// 
	ld h, c;								// 
	add hl, de;								// 
	exx;								// 
	ex de, hl;								// 
	adc hl, bc;								// 
	ex de, hl;								// 
	ld a, h;								// 
	adc a, l;								// 
	ld l, a;								// 
	rra ;								// 
	xor l;								// 
	exx;								// 
	ex de, hl;								// 
	pop hl;								// 
	rra ;								// 
	jr nc, test_neg;								// 
	ld a, 1;								// 
	call shift_fp;								// 
	inc (hl);								// 
	jr z, add_rep_6

	org $307c
test_neg:
	exx;								// 
	ld a, l;								// 
	and %10000000;								// 
	exx;								// 
	inc hl;								// 
	ld (hl), a;								// 
	dec hl;								// 
	jr z, go_nc_mlt;								// 
	ld a, e;								// 
	neg;								// 
	ccf;								// 
	ld e, a;								// 
	ld a, d;								// 
	cpl ;								// 
	adc a, 0;								// 
	ld d, a;								// 
	exx;								// 
	ld a, e;								// 
	cpl ;								// 
	adc a, 0;								// 
	ld e, a;								// 
	ld a, d;								// 
	cpl ;								// 
	adc a, 0;								// 
	jr nc, end_compl;								// 
	rra ;								// 
	exx;								// 
	inc (hl)

	org $309f
add_rep_6:
	jp z, report_6;								// 
	exx

	org $30a3
end_compl:
	ld d, a;								// 
	exx

	org $30a5
go_nc_mlt:
	xor a;								// 
	jp test_norm

	org $30a9
hl_hl_x_de:
	push bc;								// 
	ld b, 16;								// 
	ld a, h;								// 
	ld c, l;								// 
	ld hl, $0000

	org $30b1
hl_loop:
	add hl, hl;								// 
	jr c, hl_end;								// 
	rl c;								// 
	rla;								// 
	jr nc, hl_again;								// 
	add hl, de;								// 
	jr c, hl_end

	org $30bc
hl_again:
	djnz hl_loop

	org $30be
hl_end:
	pop bc;								// 
	ret

	org $30c0
prep_m_d:
	call test_zero;								// 
	ret c;								// 
	inc hl;								// 
	xor (hl);								// 
	set 7, (hl);								// 
	dec hl;								// 
	ret

	org $30ca
fp_multiply:
	ld a, (de);								// 
	or (hl);								// 
	jr nz, mult_long;								// 
	push de;								// 
	push hl;								// 
	push de;								// 
	call int_fetch;								// 
	ex de, hl;								// 
	ex (sp), hl;								// 
	ld b, c;								// 
	call int_fetch;								// 
	ld a, b;								// 
	xor c;								// 
	ld c, a;								// 
	pop hl;								// 
	call hl_hl_x_de;								// 
	ex de, hl;								// 
	pop hl;								// 
	jr c, mult_oflw;								// 
	ld a, d;								// 
	or e;								// 
	jr nz, mult_rslt;								// 
	ld c, a

	org $30ea
mult_rslt:
	call int_store;								// 
	pop de;								// 
	ret

	org $30ef
mult_oflw:
	pop de

	org $30f0
mult_long:
	call re_st_two;								// 
	xor a;								// 
	call prep_m_d;								// 
	ret c;								// 
	exx;								// 
	push hl;								// 
	exx;								// 
	push de;								// 
	ex de, hl;								// 
	call prep_m_d;								// 
	ex de, hl;								// 
	jr c, zero_rslt;								// 
	push hl;								// 
	call fetch_two;								// 
	ld a, b;								// 
	and a;								// 
	sbc hl, hl;								// 
	exx;								// 
	push hl;								// 
	sbc hl, hl;								// 
	exx;								// 
	ld b, 33;								// 
	jr strt_mlt

	org $3114
mlt_loop:
	jr nc, no_add;								// 
	add hl, de;								// 
	exx;								// 
	adc hl, de;								// 
	exx

	org $311b
no_add:
	exx;								// 
	rr h;								// 
	rr l;								// 
	exx;								// 
	rr h;								// 
	rr l

	org $3125
strt_mlt:
	exx;								// 
	rr b;								// 
	rr c;								// 
	exx;								// 
	rr c;								// 
	rra;								// 
	djnz mlt_loop;								// 
	ex de, hl;								// 
	exx;								// 
	ex de, hl;								// 
	exx;								// 
	pop bc;								// 
	pop hl;								// 
	ld a, b;								// 
	add a, c;								// 
	jr nz, make_expt;								// 
	and a

	org $313b
make_expt:
	dec a;								// 
	ccf

	org $313d
divn_expt:
	rla ;								// 
	ccf;								// 
	rra ;								// 
	jp p, oflw1_clr;								// 
	jr nc, report_6;								// 
	and a

	org $3146
oflw1_clr:
	inc a;								// 
	jr nz, oflw2_clr;								// 
	jr c, oflw2_clr;								// 
	exx;								// 
	bit 7, d;								// 
	exx;								// 
	jr nz, report_6

	org $3151
oflw2_clr:
	ld (hl), a;								// 
	exx;								// 
	ld a, b;								// 
	exx

	org $3155
test_norm:
	jr nc, normalise;								// 
	ld a, (hl);								// 
	and a

	org $3159
near_zero:
	ld a, 128;								// 
	jr z, skip_zero

	org $315d
zero_rslt:
	xor a

	org $315e
skip_zero:
	exx;								// 
	and d;								// 
	call zeros_4_5;								// 
	rlca;								// 
	ld (hl), a;								// 
	jr c, oflow_clr;								// 
	inc hl;								// 
	ld (hl), a;								// 
	dec hl;								// 
	jr oflow_clr

	org $316c
normalise:
	ld b, 32

	org $316e
shift_one:
	exx;								// 
	bit 7, d;								// 
	exx;								// 
	jr nz, norml_now;								// 
	rlca;								// 
	rl e;								// 
	rl d;								// 
	exx;								// 
	rl e;								// 
	rl d;								// 
	exx;								// 
	dec (hl);								// 
	jr z, near_zero;								// 
	djnz shift_one;								// 
	jr zero_rslt

	org $3186
norml_now:
	rla ;								// 
	jr nc, oflow_clr;								// 
	call add_back;								// 
	jr nz, oflow_clr;								// 
	exx;								// 
	ld d, 128;								// 
	exx;								// 
	inc (hl);								// 
	jr z, report_6

	org $3195
oflow_clr:
	push hl;								// 
	inc hl;								// 
	exx;								// 
	push de;								// 
	exx;								// 
	pop bc;								// 
	ld a, b;								// 
	rla;								// 
	rl (hl);								// 
	rra;								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld (hl), c;								// 
	inc hl;								// 
	ld (hl), d;								// 
	inc hl;								// 
	ld (hl), e;								// 
	pop hl;								// 
	pop de;								// 
	exx;								// 
	pop hl;								// 
	exx;								// 
	ret

	org $31ad
report_6:
	rst error;								// 
	defb number_too_big

	org $31af
fp_division:
	call re_st_two;								// 
	ex de, hl;								// 
	xor a;								// 
	call prep_m_d;								// 
	jr c, report_6;								// 
	ex de, hl;								// 
	call prep_m_d;								// 
	ret c;								// 
	exx;								// 
	push hl;								// 
	exx;								// 
	push de;								// 
	push hl;								// 
	call fetch_two;								// 
	exx;								// 
	push hl;								// 
	ld h, b;								// 
	ld l, c;								// 
	exx;								// 
	ld h, c;								// 
	ld l, b;								// 
	xor a;								// 
	ld b, $df;								// 
	jr div_start

	org $31d2
div_loop:
	rla ;								// 
	rl c;								// 
	exx;								// 
	rl c;								// 
	rl b;								// 
	exx

	org $31db
div_34th:
	add hl, hl;								// 
	exx;								// 
	adc hl, hl;								// 
	exx;								// 
	jr c, subn_only

	org $31e2
div_start:
	sbc hl, de;								// 
	exx;								// 
	sbc hl, de;								// 
	exx;								// 
	jr nc, no_rstore;								// 
	add hl, de;								// 
	exx;								// 
	adc hl, de;								// 
	exx;								// 
	and a;								// 
	jr count_one

	org $31f2
subn_only:
	and a;								// 
	sbc hl, de;								// 
	exx;								// 
	sbc hl, de;								// 
	exx

	org $31f9
no_rstore:
	scf

	org $31fa
count_one:
	inc b;								// 
	jp m, div_loop;								// 
	push af;								// 
	jr z, div_start;								// 
	ld e, a;								// 
	ld d, c;								// 
	exx;								// 
	ld e, c;								// 
	ld d, b;								// 
	pop af;								// 
	rr b;								// 
	pop af;								// 
	rr b;								// 
	exx;								// 
	pop bc;								// 
	pop hl;								// 
	ld a, b;								// 
	sub c;								// 
	jp divn_expt

	org $3214
fp_truncate:
	ld a, (hl);								// 
	and a;								// 
	ret z;								// 
	cp 129;								// 
	jr nc, t_gr_zero;								// 
	ld (hl), 0;								// 
	ld a, 32;								// 
	jr nil_bytes

	org $3221
t_gr_zero:
	cp 145;								// 
	jr nz, t_small;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld a, 128;								// 
	and (hl);								// 
	dec hl;								// 
	or (hl);								// 
	dec hl;								// 
	jr nz, t_first;								// 
	ld a, 128;								// 
	xor (hl)

	org $3233
t_first:
	dec hl;								// 
	jr nz, t_expnent;								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld (hl), 255;								// 
	dec hl;								// 
	ld a, 24;								// 
	jr nil_bytes

	org $323f
t_small:
	jr nc, x_large;								// 
	push de;								// 
	cpl ;								// 
	add a, 145;								// 
	inc hl;								// 
	ld d, (hl);								// 
	inc hl;								// 
	ld e, (hl);								// 
	dec hl;								// 
	dec hl;								// 
	ld c, 0;								// 
	bit 7, d;								// 
	jr z, t_numeric;								// 
	dec c

	org $3252
t_numeric:
	set 7, d;								// 
	ld b, 08;								// 
	sub b;								// 
	add a, b;								// 
	jr c, t_test;								// 
	ld e, d;								// 
	ld d, 0;								// 
	sub b

	org $325e
t_test:
	jr z, t_store;								// 
	ld b, a

	org $3261
t_shift:
	srl d;								// 
	rr e;								// 
	djnz t_shift

	org $3267
t_store:
	call int_store;								// 
	pop de;								// 
	ret

	org $326c
t_expnent:
	ld a, (hl)

	org $326d
x_large:
	sub 160;								// 
	ret p;								// 
	neg

	org $3272
nil_bytes:
	push de;								// 
	ex de, hl;								// 
	dec hl;								// 
	ld b, a;								// 
	srl b;								// 
	srl b;								// 
	srl b;								// 
	jr z, bits_zero

	org $327e
byte_zero:
	ld (hl), 0;								// 
	dec hl;								// 
	djnz byte_zero

	org $3283
bits_zero:
	and %00000111;								// 
	jr z, ix_end;								// 
	ld b, a;								// 
	ld a, 255

	org $328a
less_mask:
	sla a;								// 
	djnz less_mask;								// 
	and (hl);								// 
	ld (hl), a

	org $3290
ix_end:
	ex de, hl;								// 
	pop de;								// 
	ret 

	org $3293
re_st_two:
	call restk_sub

	org $3296
restk_sub:
	ex de, hl

	org $3297
fp_re_stack:
	ld a, (hl);								// 
	and a;								// 
	ret nz;								// 
	push de;								// 
	call int_fetch;								// 
	xor a;								// 
	inc hl;								// 
	ld (hl), a;								// 
	dec hl;								// 
	ld (hl), a;								// 
	ld b, 145;								// 
	ld a, d;								// 
	and a;								// 
	jr nz, rs_nrmlse;								// 
	or e;								// 
	ld b, d;								// 
	jr z, rs_store;								// 
	ld d, e;								// 
	ld e, b;								// 
	ld b, 137

	org $32b1
rs_nrmlse:
	ex de, hl

	org $32b2
rstk_loop:
	dec b;								// 
	add hl, hl;								// 
	jr nc, rstk_loop;								// 
	rrc c;								// 
	rr h;								// 
	rr l;								// 
	ex de, hl

	org $32bd
rs_store:
	dec hl;								// 
	ld (hl), e;								// 
	dec hl;								// 
	ld (hl), d;								// 
	dec hl;								// 
	ld (hl), b;								// 
	pop de;								// 
	ret
