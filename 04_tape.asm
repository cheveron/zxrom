;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $04aa
zx81_name:
	call scanning;						// 
	ld a, (flags);						// 
	add a, a;							// 
	jp m, report_c;						// 
	pop hl;								// 
	ret nc;								// 
	push hl;							// 
	call stk_fetch;						// 
	ld h, d;							// 
	ld l, e;							// 
	dec c;								// 
	ret m;								// 
	add hl, bc ;						// 
	set 7, (hl);						// 
	ret

	org $04c2
sa_bytes:
	ld hl, sa_ld_ret;					// 
	push hl;							// 
	ld hl, $1f80;						// 
	bit 7, a;							// 
	jr z, sa_flag;						// 
	ld hl, $0c98;						//

	org $04d0
sa_flag:
	ex af, af';							// 
	inc de;								// 
	dec ix;								// 
	di;									// 
	ld a, red;							// 
	ld b, a;							//

	org $04d8
sa_leader:
	djnz sa_leader;						// 
	out (ula), a;						// 
	xor %00001111;						// 
	ld b, 164;							// 
	dec l;								// 
	jr nz, sa_leader;					// 
	dec b;								// 
	dec h;								// 
	jp p, sa_leader;					// 
	ld b, 47;							//

	org $04ea
sa_sync_1:
	djnz sa_sync_1;						// 
	out (ula), a;						// 
	ld a, 13;							// 
	ld b, 55;							//

	org $04f2
sa_sync_2:
	djnz sa_sync_2;						// 
	out (ula), a;						// 
	ld bc, $3b0e;						// 
	ex af, af';							// 
	ld l, a;							// 
	jp sa_start;						//

	org $04fe
sa_loop:
	ld a, d;							// 
	or e;								// 
	jr z, sa_parity;					// 
	ld l, (ix + $00);					//

	org $0505
sa_loop_p:
	ld a, h;							// 
	xor l;								//

	org $0507
sa_start:
	ld h, a;							// 
	ld a, blue;							// 
	scf;								// 
	jp sa_8_bits;						//

	org $050e
sa_parity:
	ld l, h;							// 
	jr sa_loop_p;						//

	org $0511
sa_bit_2:
	ld a, c;							// 
	bit 7, b;							//

	org $0514
sa_bit_1:
	djnz sa_bit_1;						// 
	jr nc, sa_out;						// 
	ld b, 66;							//

	org $051a
sa_set:
	djnz sa_set;						//

	org $051c
sa_out:
	out (ula), a;						// 
	ld b, 62;							// 
	jr nz, sa_bit_2;					// 
	dec b;								// 
	xor a;								// 
	inc a;								//

	org $0525
sa_8_bits:
	rl l;								// 
	jp nz, sa_bit_1;					// 
	dec de;								// 
	inc ix;								// 
	ld b, 49;							// 
	ld a, 127;							// 
	in a, (ula);						// 
	rra;								// 
	ret nc;								// 
	ld a, d;							// 
	inc a;								// 
	jp nz, sa_loop;						// 
	ld b, 59;							//

	org $053c
sa_delay:
	djnz sa_delay;						// 
	ret;								//

	org $053f
sa_ld_ret:
	push af;							// 
	ld a, (bordcr);						// 
	and %00111000;						// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	out (ula), a;						// 
	ld a, 127;							// 
	in a, (ula);						// 
	rra;								// 
	ei;									// 
	jr c, sa_ld_end;					//

	org $0552
report_da:
	rst error;							// 
	defb break_cont_repeats;			// 

	org $0554
sa_ld_end:
	pop af;								// 
	ret;								//

	org $0556
ld_bytes:
	inc d;								// 
	ex af, af';							// 
	dec d;								// 
	di;									// 
	ld a, 15;							// 
	out (ula), a;						// 
	ld hl, sa_ld_ret;					// 
	push hl;							// 
	in a, (ula);						// 
	rra;								// 
	and %00100000;						// 
	or red;								// 
	ld c, a;							// 
	cp a;								//

	org $056b
ld_break:
	ret nz;								//

	org $056c
ld_start:
	call ld_edge_1;						// 
	jr nc, ld_break;					// 
	ld hl, $0415;						//

	org $0574
ld_wait:
	djnz ld_wait;						// 
	dec hl;								// 
	ld a, h;							// 
	or l;								// 
	jr nz, ld_wait;						// 
	call ld_edge_2;						// 
	jr nc, ld_break;					//

	org $0580
ld_leader:
	ld b, 156;							// 
	call ld_edge_2;						// 
	jr nc, ld_break;					// 
	ld a, 198;							// 
	cp b;								// 
	jr nc, ld_start;					// 
	inc h;								// 
	jr nz, ld_leader;					//

	org $058f
ld_sync:
	ld b, 201;							// 
	call ld_edge_1;						// 
	jr nc, ld_break;					// 
	ld a, b;							// 
	cp 212;								// 
	jr nc, ld_sync;						// 
	call ld_edge_1;						// 
	ret nc;								// 
	ld a, c;							// 
	xor %00000011;						// 
	ld c, a;							// 
	ld h, 0;							// 
	ld b, 176;							// 
	jr ld_marker;						//

	org $05a9
ld_loop:
	ex af, af';							// 
	jr nz, ld_flag;						// 
	jr nc, ld_verify;					// 
	ld (ix + $00), l;					// 
	jr ld_next;							//

	org $05b3
ld_flag:
	rl c;								// 
	xor l;								// 
	ret nz;								// 
	ld a, c;							// 
	rra;								// 
	ld c, a;							// 
	inc de;								// 
	jr ld_dec;							//

	org $05bd
ld_verify:
	ld a, (ix + $00);					// 
	xor l;								// 
	ret nz;								//

	org $05c2
ld_next:
	inc ix;								//

	org $05c4
ld_dec:
	dec de;								// 
	ex af, af';							// 
	ld b, 178;							//

	org $05c8
ld_marker:
	ld l, %00000001;					//

	org $05ca
ld_8_bits:
	call ld_edge_2;						// 
	ret nc;								// 
	ld a, 203;							// 
	cp b;								// 
	rl l;								// 
	ld b, 176;							// 
	jp nc, ld_8_bits;					// 
	ld a, h;							// 
	xor l;								// 
	ld h, a;							// 
	ld a, d;							// 
	or e;								// 
	jr nz, ld_loop ;					// 
	ld a, h;							// 
	cp 1;								// 
	ret;								//

	org $05e3
ld_edge_2:
	call ld_edge_1;						// 
	ret nc;								//

	org $05e7
ld_edge_1:
	ld a, 22;							//

	org $05e9
ld_delay:
	dec a;								// 
	jr nz, ld_delay;					// 
	and a;								//

	org $05ed
ld_sample:
	inc b;								// 
	ret z;								// 
	ld a, 127;							// 
	in a, (ula);						// 
	rra;								// 
	ret nc;								// 
	xor c;								// 
	and %00100000;						// 
	jr z, ld_sample;					// 
	ld a, c;							// 
	cpl;								// 
	ld c, a;							// 
	and %00000111;						// 
	or %00001000;						// 
	out (ula), a;						// 
	scf;								// 
	ret;								//

	org $0605
save_etc:
	pop af;								// 
	ld a, (t_addr);						// 
	sub p_save + 1 % 256;				// 
	ld (t_addr), a;						// 
	call expt_exp;						// 
	call syntax_z;						// 
	jr z, sa_data;						// 
	ld bc, $0011;						// 
	ld a, (t_addr);						// 
	and a;								// 
	jr z, sa_space;						// 
	ld c, 34;							//

	org $0621
sa_space:
	rst bc_spaces;						// 
	push de;							// 
	pop ix;								// 
	ld b, 11;							// 
	ld a, ' ';							//

	org $0629
sa_blank:
	ld (de), a;							// 
	inc de;								// 
	djnz sa_blank;						// 
	ld (ix + $01), 255;					// 
	call stk_fetch;						// 
	ld hl, $fff6;						// 
	dec bc;								// 
	add hl, bc;							// 
	inc bc;								// 
	jr nc, sa_name;						// 
	ld a, (t_addr);						// 
	and a;								// 
	jr nz, sa_null;						//

	org $0642
report_fa:
	rst error;							// 
	defb invalid_file_name;				//

	org $0644
sa_null:
	ld a, b;							// 
	or c;								// 
	jr z, sa_data;						// 
	ld bc, $000a;						// 

	org $064b
sa_name:
	push ix;							// 
	pop hl;								// 
	inc hl;								// 
	ex de, hl;							// 
	ldir;								//

	org $0652
sa_data:
	rst get_char;						// 
	cp tk_data;							// 
	jr nz, sa_scr_str;					// 
	ld a, (t_addr);						// 
	cp 3;								// 
	jp z, report_c;						// 
	rst next_char;						// 
	call look_vars;						// 
	set 7, c;							// 
	jr nc, sa_v_old;					// 
	ld hl, $0000;						// 
	ld a, (t_addr);						// 
	dec a;								// 
	jr z, sa_v_new;						//

	org $0670
report_2a:
	rst error;							// 
	defb variable_not_found;			//

	org $0672
sa_v_old:
	jp nz, report_c;					// 
	call syntax_z;						// 
	jr z, sa_data_1;					// 
	inc hl;								// 
	ld a, (hl);							// 
	ld (ix + $0b), a;					// 
	inc hl;								// 
	ld a, (hl);							// 
	ld (ix + $0c), a;					// 
	inc hl;								//

	org $0685
sa_v_new:
	ld (ix + $0e), c;					// 
	ld a, 1;							// 
	bit 6, c;							// 
	jr z, sa_v_type;					// 
	inc a;								//

	org $068f
sa_v_type:
	ld (ix + $00), a;					//
	org $0692
sa_data_1:
	ex de, hl;							// 
	rst next_char;						// 
	cp 41;')';							// 
	jr nz, sa_v_old;					// 
	rst next_char;						// 
	call check_end;						// 
	ex de, hl;							// 
	jp sa_all;							//

	org $06a0
sa_scr_str:
	cp tk_screen_str;					// 
	jr nz, sa_code;						// 
	ld a, (t_addr);						// 
	cp 3;								// 
	jp z, report_c;						// 
	rst next_char;						// 
	call check_end;						// 
	ld (ix + $0b), 0;					// 
	ld (ix + $0c), 27;					// 
	ld hl, bitmap;						// 
	ld (ix + $0d), l;					// 
	ld (ix + $0e), h;					// 
	jr sa_type_3;						//

	org $06c3
sa_code:
	cp tk_code;							// 
	jr nz, sa_line;						// 
	ld a, (t_addr);						// 
	cp 3;								// 
	jp z, report_c;						// 
	rst next_char;						// 
	call pr_st_end;						// 
	jr nz, sa_code_1;					// 
	ld a, (t_addr);						// 
	and a;								// 
	jp z, report_c;						// 
	call use_zero;						// 
	jr sa_code_2;						//

	org $06e1
sa_code_1:
	call expt_1num;						// 
	rst get_char;						// 
	cp 44;',';							// 
	jr z, sa_code_3;					// 
	ld a, (t_addr);						// 
	and a;								// 
	jp z, report_c;						//

	org $06f0
sa_code_2:
	call use_zero;						// 
	jr sa_code_4;						//

	org $06f5
sa_code_3:
	rst next_char;						// 
	call expt_1num;						//

	org $06f9
sa_code_4:
	call check_end;						// 
	call find_int2;						// 
	ld (ix + $0b), c;					// 
	ld (ix + $0c), b;					// 
	call find_int2;						// 
	ld (ix + $0d), c;					// 
	ld (ix + $0e), b;					// 
	ld h, b;							// 
	ld l, c;							//

	org $0710
sa_type_3:
	ld (ix + $00), 3;					// 
	jr sa_all;							//

	org $0716
sa_line:
	cp tk_line;							// 
	jr z, sa_line_1;					// 
	call check_end;						// 
	ld (ix + $0e), $80;					// 
	jr sa_type_0;						//

	org $0723
sa_line_1:
	ld a, (t_addr);						// 
	and a;								// 
	jp nz, report_c;					// 
	rst next_char;						// 
	call expt_1num;						// 
	call check_end;						// 
	call find_int2;						// 
	ld (ix + $0d), c;					// 
	ld (ix + $0e), b;					//

	org $073a
sa_type_0:
	ld (ix + $00), 0;					// 
	ld hl, (e_line);					// 
	ld de, (prog);						// 
	scf;								// 
	sbc hl, de;							// 
	ld (ix + $0b), l;					// 
	ld (ix + $0c), h;					// 
	ld hl, (vars);						// 
	sbc hl, de;							// 
	ld (ix + $0f), l;					// 
	ld (ix + $10), h;					// 
	ex de, hl;							//

	org $075a
sa_all:
	ld a, (t_addr);						// 
	and a;								// 
	jp z, sa_contrl;					// 
	push hl;							// 
	ld bc, $0011;						// 
	add ix, bc;							//

	org $0767
ld_look_h:
	push ix;							// 
	ld de, $0011;						// 
	xor a;								// 
	scf;								// 
	call ld_bytes;						// 
	pop ix;								// 
	jr nc, ld_look_h;					// 
	ld a, 254;							// 
	call chan_open;						// 
	ld (iy + $52), 3;					// 
	ld c, $80;							// 
	ld a, (ix + $00);					// 
	cp (ix - $11);						// 
	jr nz, ld_type;						// 
	ld c, 246;							//

	org $078a
ld_type:
	cp 4;								// 
	jr nc, ld_look_h;					// 
	ld de, tape_msgs2;					// 
	push bc;							// 
	call po_msg;						// 
	pop bc;								// 
	push ix;							// 
	pop de;								// 
	ld hl, $fff0;						// 
	add hl, de;							// 
	ld b, 10;							// 
	ld a, (hl);							// 
	inc a;								// 
	jr nz, ld_name;						// 
	ld a, c;							// 
	add a, b;							// 
	ld c, a;							//

	org $07a6
ld_name:
	inc de;								// 
	ld a, (de);							// 
	cp (hl);							// 
	inc hl;								// 
	jr nz, ld_ch_pr;					// 
	inc c;								//

	org $07ad
ld_ch_pr:
	rst print_a;						// 
	djnz ld_name;						// 
	bit 7, c;							// 
	jr nz, ld_look_h;					// 
	ld a, ctrl_enter;					// 
	rst print_a;						// 
	pop hl;								// 
	ld a, (ix + $00);					// 
	cp 3;								// 
	jr z, vr_contrl;					// 
	ld a, (t_addr);						// 
	dec a;								// 
	jp z, ld_contrl;					// 
	cp 2;								// 
	jp z, me_contrl;					//

	org $07cb
vr_contrl:
	push hl;							// 
	ld l, (ix - $06);					// 
	ld h, (ix - $05);					// 
	ld e, (ix + $0b);					// 
	ld d, (ix + $0c);					// 
	ld a, h;							// 
	or l;								// 
	jr z, vr_cont_1;					// 
	sbc hl, de;							// 
	jr c, report_r;						// 
	jr z, vr_cont_1;					// 
	ld a, (ix + $00);					// 
	cp 3;								// 
	jr nz, report_r;					//

	org $07e9
vr_cont_1:
	pop hl;								// 
	ld a, h;							// 
	or l;								// 
	jr nz, vr_cont_2;					// 
	ld l, (ix + $0d);					// 
	ld h, (ix + $0e);					//

	org $07f4
vr_cont_2:
	push hl;							// 
	pop ix;								// 
	ld a, (t_addr);						// 
	cp 2;								// 
	scf;								// 
	jr nz, vr_cont_3;					// 
	and a;								//

	org $0800
vr_cont_3:
	ld a, 255;							//

	org $0802
ld_block:
	call ld_bytes;						// 
	ret c;								//

	org $0806
report_r:
	rst error;							// 
	defb tape_loading_error;			//

	org $0808
ld_contrl:
	ld e, (ix + $0b);					// 
	ld d, (ix + $0c);					// 
	push hl;							// 
	ld a, h;							// 
	or l;								// 
	jr nz, ld_cont_1;					// 
	inc de;								// 
	inc de;								// 
	inc de;								// 
	ex de, hl;							// 
	jr ld_cont_2;						//

	org $0819
ld_cont_1:
	ld l, (ix - $06);					// 
	ld h, (ix - $05);					// 
	ex de, hl;							// 
	scf;								// 
	sbc hl, de;							// 
	jr c, ld_data;						//

	org $0825
ld_cont_2:
	ld de, $0005;						// 
	add hl, de;							// 
	ld b, h;							// 
	ld c, l;							// 
	call test_room;						//

	org $082e
ld_data:
	pop hl;								// 
	ld a, (ix + $00);					// 
	and a;								// 
	jr z, ld_prog;						// 
	ld a, h;							// 
	or l;								// 
	jr z, ld_data_1;					// 
	dec hl;								// 
	ld b, (hl);							// 
	dec hl;								// 
	ld c, (hl);							// 
	dec hl;								// 
	inc bc;								// 
	inc bc;								// 
	inc bc;								// 
	ld (x_ptr), ix;						// 
	call reclaim_2;						// 
	ld ix, (x_ptr);						//

	org $084c
ld_data_1:
	ld hl, (e_line);					// 
	dec hl;								// 
	ld c, (ix + $0b);					// 
	ld b, (ix + $0c);					// 
	push bc;							// 
	inc bc;								// 
	inc bc;								// 
	inc bc;								// 
	ld a, (ix - $03);					// 
	push af;							// 
	call make_room;						// 
	inc hl;								// 
	pop af;								// 
	ld (hl), a;							// 
	pop de;								// 
	inc hl;								// 
	ld (hl), e;							// 
	inc hl;								// 
	ld (hl), d;							// 
	inc hl;								// 
	push hl;							// 
	pop ix;								// 
	scf;								// 
	ld a, 255;							// 
	jp ld_block;						//

	org $0873
ld_prog:
	ex de, hl;							// 
	ld hl, (e_line);					// 
	dec hl;								// 
	ld (x_ptr), ix;						// 
	ld c, (ix + $0b);					// 
	ld b, (ix + $0c);					// 
	push bc;							// 
	call reclaim_1;						// 
	pop bc;								// 
	push hl;							// 
	push bc;							// 
	call make_room;						// 
	ld ix, (x_ptr);						// 
	inc hl;								// 
	ld c, (ix + $0f);					// 
	ld b, (ix + $10);					// 
	add hl, bc;							// 
	ld (vars), hl;						// 
	ld h, (ix + $0e);					// 
	ld a, h;							// 
	and %11000000;						// 
	jr nz, ld_prog_1;					// 
	ld l, (ix + $0d);					// 
	ld (newppc), hl;					// 
	ld (iy + _nsppc), 0;				//

	org $08ad
ld_prog_1:
	pop de;								// 
	pop ix;								// 
	scf;								// 
	ld a, 255;							// 
	jp ld_block;						//

	org $08b6
me_contrl:
	ld c, (ix + $0b);					// 
	ld b, (ix + $0c);					// 
	push bc;							// 
	inc bc;								// 
	rst bc_spaces;						// 
	ld (hl), $80;						// 
	ex de, hl;							// 
	pop de;								// 
	push hl;							// 
	push hl;							// 
	pop ix;								// 
	scf;								// 
	ld a, 255;							// 
	call ld_block;						// 
	pop hl;								// 
	ld de, (prog);						//

	org $08d2
me_new_lp:
	ld a, (hl);							// 
	and %11000000;						// 
	jr nz, me_var_lp;					//

	org $08d7
me_old_lp:
	ld a, (de);							// 
	inc de;								// 
	cp (hl);							// 
	inc hl;								// 
	jr nz, me_old_l1;					// 
	ld a, (de);							// 
	cp (hl);							//

	org $08df
me_old_l1:
	dec de;								// 
	dec hl;								// 
	jr nc, me_new_l2;					// 
	push hl;							// 
	ex de, hl;							// 
	call next_one;						// 
	pop hl;								// 
	jr me_old_lp;						//

	org $08eb
me_new_l2:
	call me_enter;						// 
	jr me_new_lp;						//

	org $08f0
me_var_lp:
	ld a, (hl);							// 
	ld c, a;							// 
	cp $80;								// 
	ret z;								// 
	push hl;							// 
	ld hl, (vars);						//

	org $08f9
me_old_vp:
	ld a, (hl);							// 
	cp $80;								// 
	jr z, me_var_l2;					// 
	cp c;								// 
	jr z, me_old_v2;					//

	org $0901
me_old_v1:
	push bc;							// 
	call next_one;						// 
	pop bc;								// 
	ex de, hl;							// 
	jr me_old_vp;						//

	org $0909
me_old_v2:
	and %11100000;						// 
	cp %10100000;						// 
	jr nz, me_var_l1;					// 
	pop de;								// 
	push de;							// 
	push hl;							//

	org $0912
me_old_v3:
	inc hl;								// 
	inc de;								// 
	ld a, (de);							// 
	cp (hl);							// 
	jr nz, me_old_v4;					// 
	rla;								// 
	jr nc, me_old_v3;					// 
	pop hl;								// 
	jr me_var_l1;						//

	org $091e
me_old_v4:
	pop hl;								// 
	jr me_old_v1;						//

	org $0921
me_var_l1:
	ld a, 255;							//

	org $0923
me_var_l2:
	pop de;								// 
	ex de, hl;							// 
	inc a;								// 
	scf;								// 
	call me_enter;						// 
	jr me_var_lp;						//

	org $092c
me_enter:
	jr nz, me_ent_1;					// 
	ex af, af';							// 
	ld (x_ptr), hl;						// 
	ex de, hl;							// 
	call next_one;						// 
	call reclaim_2;						// 
	ex de, hl;							// 
	ld hl, (x_ptr);						// 
	ex af, af';							//

	org $093e
me_ent_1:
	ex af, af';							// 
	push de;							// 
	call next_one;						// 
	ld (x_ptr), hl;						// 
	ld hl, (prog);						// 
	ex (sp), hl;						// 
	push bc;							// 
	ex af, af';							// 
	jr c, me_ent_2;						// 
	dec hl;								// 
	call make_room;						// 
	inc hl;								// 
	jr me_ent_3;						//

	org $0955
me_ent_2:
	call make_room;						//

	org $0958
me_ent_3:
	inc hl;								// 
	pop bc;								// 
	pop de;								// 
	ld (prog), de;						// 
	ld de, (x_ptr);						// 
	push bc;							// 
	push de;							// 
	ex de, hl;							// 
	ldir;								// 
	pop hl;								// 
	pop bc;								// 
	push de;							// 
	call reclaim_2;						// 
	pop de;								// 
	ret;								//

	org $0970
sa_contrl:
	push hl;							// 
	ld a, 253;							// 
	call chan_open;						// 
	xor a;								// 
	ld de, tape_msgs;					// 
	call po_msg;						// 
	set 5, (iy + _vdu_flag);			// 
	call wait_key;						// 
	push ix;							// 
	ld de, $0011;						// 
	xor a;								// 
	call sa_bytes;						// 
	pop ix;								// 
	ld b, 50;							//

	org $0991
sa_1_sec:
	halt;								// 
	djnz sa_1_sec;						// 
	ld e, (ix + $0b);					// 
	ld d, (ix + $0c);					// 
	ld a, 255;							// 
	pop ix;								// 
	jp sa_bytes;						//

	org $09a1
tape_msgs:
	defb $80, "Start tape, then press any key";

	org $09c0
tape_msgs2:
	defb '.' + $80; 
	defb ctrl_enter, "Program:", ' ' + $80;
	defb ctrl_enter, "Number array:", ' ' + $80;
	defb ctrl_enter, "Character array:", ' ' + $80;
	defb ctrl_enter, "Bytes:", ' ' + $80;
