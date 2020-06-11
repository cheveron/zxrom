;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $0f2c
editor:
	ld hl, (err_sp);								// 
	push hl

	org $0f30
ed_again:
	ld hl, ed_error;								// 
	push hl;								// 
	ld (err_sp), sp

	org $0f38
ed_loop:
	call wait_key;								// 
	push af;								// 
	ld d, 0;								// 
	ld e, (iy - _pip);								// 
	ld hl, $00c8;								// 
	call beeper;								// 
	pop af;								// 
	ld hl, ed_loop;								// 
	push hl;								// 
	cp 24;								// 
	jr nc, add_char;								// 
	cp 7;								// 
	jr c, add_char;								// 
	cp 16;								// 
	jr c, ed_keys;								// 
	ld bc, $0002;								// 
	ld d, a;								// 
	cp 22;								// 
	jr c, ed_contr;								// 
	inc bc;								// 
	bit 7, (iy + _flagx);								// 
	jp z, ed_ignore;								// 
	call wait_key;								// 
	ld e, a

	org $0f6c
ed_contr:
	call wait_key;								// 
	push de;								// 
	ld hl, (k_cur);								// 
	res 0, (iy + _mode);								// 
	call make_room;								// 
	pop bc;								// 
	inc hl;								// 
	ld (hl), b;								// 
	inc hl;								// 
	ld (hl), c;								// 
	jr add_ch_1

	org $0f81
add_char:
	res 0, (iy + _mode);								// 
	ld hl, (k_cur);								// 
	call one_space

	org $0f8b
add_ch_1:
	ld (de), a;								// 
	inc de;								// 
	ld (k_cur), de;								// 
	ret

	org $0f92
ed_keys:
	ld e, a;								// 
	ld d, 0;								// 
	ld hl, ed_keys_t - 7;								// 
	add hl, de;								// 
	ld e, (hl);								// 
	add hl, de;								// 
	push hl;								// 
	ld hl, (k_cur);								// 
	ret

	org $0fa0
ed_keys_t:
	defb ed_edit - $;								// 
	defb ed_left - $;								// 
	defb ed_right - $;								// 
	defb ed_down - $;								// 
	defb ed_up - $;								// 
	defb ed_delete - $;								// 
	defb ed_enter - $;								// 
	defb ed_symbol - $;								// 
	defb ed_graph - $

	org $0fa9
ed_edit:
	ld hl, (e_ppc);								// 
	bit 5, (iy + _flagx);								// 
	jp nz, clear_sp;								// 
	call line_addr;								// 
	call line_no;								// 
	ld a, d;								// 
	or e;								// 
	jp z, clear_sp;								// 
	push hl;								// 
	inc hl;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	ld hl, $000a;								// 
	add hl, bc;								// 
	ld b, h;								// 
	ld c, l;								// 
	call test_room;								// 
	call clear_sp;								// 
	ld hl, (curchl);								// 
	ex (sp), hl;								// 
	push hl;								// 
	ld a, 255;								// 
	call chan_open;								// 
	pop hl;								// 
	dec hl;								// 
	dec (iy + _e_ppc);								// 
	call out_line;								// 
	inc (iy + _e_ppc);								// 
	ld hl, (e_line);								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld (k_cur), hl;								// 
	pop hl;								// 
	call chan_flag;								// 
	ret

	org $0ff3
ed_down:
	bit 5, (iy + _flagx);								// 
	jr nz, ed_stop;								// 
	ld hl, e_ppc;								// 
	call ln_fetch;								// 
	jr ed_list

	org $1001
ed_stop:
	ld (iy + _err_nr), 16;								// 
	jr ed_enter

	org $1007
ed_left:
	call ed_edge;								// 
	jr ed_cur

	org $100c
ed_right:
	ld a, (hl);								// 
	cp 13;								// 
	ret z;								// 
	inc hl

	org $1011
ed_cur:
	ld (k_cur), hl;								// 
	ret

	org $1015
ed_delete:
	call ed_edge;								// 
	ld bc, $0001;								// 
	jp reclaim_2

	org $101e
ed_ignore:
	call wait_key;								// 
	call wait_key

	org $1024
ed_enter:
	pop hl;								// 
	pop hl

	org $1026
ed_end:
	pop hl;								// 
	ld (err_sp), hl;								// 
	bit 7, (iy + _err_nr);								// 
	ret nz;								// 
	ld sp, hl;								// 
	ret

	org $1031
ed_edge:
	scf;								// 
	call set_de;								// 
	sbc hl, de;								// 
	add hl, de;								// 
	inc hl;								// 
	pop bc;								// 
	ret c;								// 
	push bc;								// 
	ld b, h;								// 
	ld c, l

	org $103e
ed_edge_1:
	ld h, d;								// 
	ld l, e;								// 
	inc hl;								// 
	ld a, (de);								// 
	and %11110000;								// 
	cp ctrl_ink;								// 
	jr nz, ed_edge_2;								// 
	inc hl;								// 
	ld a, (de);								// 
	sub ctrl_tab;								// 
	adc a, 0;								// 
	jr nz, ed_edge_2;								// 
	inc hl

	org $1051
ed_edge_2:
	and a;								// 
	sbc hl, bc;								// 
	add hl, bc;								// 
	ex de, hl;								// 
	jr c, ed_edge_1;								// 
	ret

	org $1059
ed_up:
	bit 5, (iy + _flagx);								// 
	ret nz;								// 
	ld hl, (e_ppc);								// 
	call line_addr;								// 
	ex de, hl;								// 
	call line_no;								// 
	ld hl, e_ppc_h;								// 
	call ln_store

	org $106e
ed_list:
	call auto_list;								// 
	ld a, 0;								// 
	jp chan_open

	org $1076
ed_symbol:
	bit 7, (iy + _flagx);								// 
	jr z, ed_enter

	org $107c
ed_graph:
	jp add_char

	org $107f
ed_error:
	bit 4, (iy + _flags2);								// 
	jr z, ed_end;								// 
	ld (iy + _err_nr), 255;								// 
	ld d, 0;								// 
	ld e, (iy - _rasp);								// 
	ld hl, $1a90;								// 
	call beeper;								// 
	jp ed_again

	org $1097
clear_sp:
	push hl;								// 
	call set_hl;								// 
	dec hl;								// 
	call reclaim_1;								// 
	ld (k_cur), hl;								// 
	ld (iy + $07), 0;								// 
	pop hl;								// 
	ret

	org $10a8
key_input:
	bit 3, (iy + _vdu_flag);								// 
	call nz, ed_copy;								// 
	and a;								// 
	bit 5, (iy + _flags);								// 
	ret z;								// 
	ld a, (last_k);								// 
	res 5, (iy + _flags);								// 
	push af;								// 
	bit 5, (iy + _vdu_flag);								// 
	call nz, cls_lower;								// 
	pop af;								// 
	cp 32;' ';								// 
	jr nc, key_done2;								// 
	cp ctrl_ink;								// 
	jr nc, key_contr;								// 
	cp 6;								// 
	jr nc, key_m_cl;								// 
	ld b, a;								// 
	and %00000001;								// 
	ld c, a;								// 
	ld a, b;								// 
	rra;								// 
	add a, 18;								// 
	jr key_data

	org $10db
key_m_cl:
	jr nz, key_mode;								// 
	ld hl, flags2;								// 
	ld a, %00001000;								// 
	xor (hl);								// 
	ld (hl), a;								// 
	jr key_flag

	org $10e6
key_mode:
	cp ctrl_symbol;								// 
	ret c;								// 
	sub 13;								// 
	ld hl, mode;								// 
	cp (hl);								// 
	ld (hl), a;								// 
	jr nz, key_flag;								// 
	ld (hl), 0

	org $10f4
key_flag:
	set 3, (iy + _vdu_flag);								// 
	cp a;								// 
	ret

	org $10fa
key_contr:
	ld b, a;								// 
	and %00000111;								// 
	ld c, a;								// 
	ld a, ctrl_ink;								// 
	bit 3, b;								// 
	jr nz, key_data;								// 
	inc a

	org $1105
key_data:
	ld (iy - _k_data), c;								// 
	ld de, key_next;								// 
	jr key_chan

	org $110d
key_next:
	ld a, (k_data);								// 
	ld de, key_input

	org $1113
key_chan:
	ld hl, (chans);								// 
	inc hl;								// 
	inc hl;								// 
	ld (hl), e;								// 
	inc hl;								// 
	ld (hl), d

	org $111b
key_done2:
	scf;								// 
	ret

	org $111d
ed_copy:
	call temps;								// 
	res 3, (iy + _vdu_flag);								// 
	res 5, (iy + _vdu_flag);								// 
	ld hl, (sposnl);								// 
	push hl;								// 
	ld hl, (err_sp);								// 
	push hl;								// 
	ld hl, ed_full;								// 
	push hl;								// 
	ld (err_sp), sp;								// 
	ld hl, (echo_e);								// 
	push hl;								// 
	scf;								// 
	call set_de;								// 
	ex de, hl;								// 
	call out_line2;								// 
	ex de, hl;								// 
	call out_curs;								// 
	ld hl, (sposnl);								// 
	ex (sp), hl;								// 
	ex de, hl;								// 
	call temps

	org $1150
ed_blank:
	ld a, (sposnl_h);								// 
	sub d;								// 
	jr c, ed_c_done;								// 
	jr nz, ed_spaces;								// 
	ld a, e;								// 
	sub (iy + $50) ;sposnl;								// 
	jr nc, ed_c_done

	org $115e
ed_spaces:
	ld a, ' ';								// 
	push de;								// 
	call print_out;								// 
	pop de;								// 
	jr ed_blank

	org $1167
ed_full:
	ld d, 0;								// 
	ld e, (iy - _rasp);								// 
	ld hl, $1a90;								// 
	call beeper;								// 
	ld (iy + _err_nr), 255;								// 
	ld de, (sposnl);								// 
	jr ed_c_end

	org $117c
ed_c_done:
	pop de;								// 
	pop hl

	org $117e
ed_c_end:
	pop hl;								// 
	ld (err_sp), hl;								// 
	pop bc;								// 
	push de;								// 
	call cl_set;								// 
	pop hl;								// 
	ld (echo_e), hl;								// 
	ld (iy + _x_ptr_h), 0;								// 
	ret

	org $1190
set_hl:
	ld hl, (worksp);								// 
	dec hl;								// 
	and a

	org $1195
set_de:
	ld de, (e_line);								// 
	bit 5, (iy + _flagx);								// 
	ret z;								// 
	ld de, (worksp);								// 
	ret c;								// 
	ld hl, (stkbot);								// 
	ret

	org $11a7
remove_fp:
	ld a, (hl);								// 
	cp $0e;								// 
	ld bc, $0006;								// 
	call z, reclaim_2;								// 
	ld a, (hl);								// 
	inc hl;								// 
	cp ctrl_enter;								// 
	jr nz, remove_fp;								// 
	ret
