;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $11b7
new:
	di;								// 
	ld a, 255;								// 
	ld de, (ramtop);								// 
	exx;								// 
	ld bc, (p_ramt);								// 
	ld de, (rasp);								// 
	ld hl, (udg);								// 
	exx

	org $11cb
start_new:
	ld b, a ;								// 
	ld a, white;								// 
	out (ula), a;								// 
	ld a, 63;								// 
	ld i, a;								// 
	nop;								// 
	nop;								// 
	nop;								// 
	nop;								// 
	nop;								// 
	nop

	org $11da
ram_check:
	ld h, d;								// 
	ld l, e

	org $11dc
ram_fill:
	ld (hl), red;								// 
	dec hl;								// 
	cp h;								// 
	jr nz, ram_fill

	org $11e2
ram_read:
	and a;								// 
	sbc hl, de;								// 
	add hl, de;								// 
	inc hl;								// 
	jr nc, ram_done;								// 
	dec (hl);								// 
	jr z, ram_done;								// 
	dec (hl);								// 
	jr z, ram_read

	org $11ef
ram_done:
	dec hl;								// 
	exx;								// 
	ld (p_ramt), bc;								// 
	ld (rasp), de;								// 
	ld (udg), hl;								// 
	exx;								// 
	inc b;								// 
	jr z, ram_set;								// 
	ld (p_ramt), hl;								// 
	ld de, font + $01af;								// 
	ld bc, $00a8;								// 
	ex de, hl;								// 
	lddr;								// 
	ex de, hl;								// 
	inc hl;								// 
	ld (udg), hl;								// 
	dec hl;								// 
	ld bc, $0040;								// 
	ld (rasp), bc

	org $1219
ram_set:
	ld (ramtop), hl;								// 
	ld hl, $3c00;								// 
	ld (chars), hl;								// 
	ld hl, (ramtop);								// 
	ld (hl), $3e;								// 
	dec hl;								// 
	ld sp, hl;								// 
	dec hl;								// 
	dec hl;								// 
	ld (err_sp), hl;								// 
	im 1;								// 
	ld iy, err_nr;								// 
	ei;								// 
	ld hl, channels;								// 
	ld (chans), hl;								// 
	ld de, init_chan;								// 
	ld bc, $0015;								// 
	ex de, hl;								// 
	ldir;								// 
	ex de, hl;								// 
	dec hl;								// 
	ld (datadd), hl;								// 
	inc hl;								// 
	ld (prog), hl;								// 
	ld (vars), hl;								// 
	ld (hl), $80;								// 
	inc hl;								// 
	ld (e_line), hl;								// 
	ld (hl), ctrl_enter;								// 
	inc hl;								// 
	ld (hl), $80;								// 
	inc hl;								// 
	ld (worksp), hl;								// 
	ld (stkbot), hl;								// 
	ld (stkend), hl;								// 
	ld a, 56;								// 
	ld (attr_p), a;								// 
	ld (attr_t), a;								// 
	ld (bordcr), a;								// 
	ld hl, $0523;								// 
	ld (repdel), hl;								// 
	dec (iy - _kstate);								// 
	dec (iy - _kstate_4);								// 
	ld hl, init_strm;								// 
	ld de, strms;								// 
	ld bc, $000e;								// 
	ldir;								// 
	set 1, (iy + _flags);								// 
	call clear_prb;								// 
	ld (iy + _df_sz), 2;								// 
	call cls;								// 
	xor a;								// 
	ld de, copyright - 1;								// 
	call po_msg;								// 
	set 5, (iy + _vdu_flag);								// 
	jr main_1

	org $12a2
main_exec:
	ld (iy + _df_sz), 2;								// 
	call auto_list

	org $12a9
main_1:
	call set_min

	org $12ac
main_2:
	ld a, 0;								// 
	call chan_open;								// 
	call editor;								// 
	call line_scan;								// 
	bit 7, (iy + _err_nr);								// 
	jr nz, main_3;								// 
	bit 4, (iy + _flags2);								// 
	jr z, main_4;								// 
	ld hl, (e_line);								// 
	call remove_fp;								// 
	ld (iy + _err_nr), 255;								// 
	jr main_2

	org $12cf
main_3:
	ld hl, (e_line);								// 
	ld (ch_add), hl;								// 
	call e_line_no;								// 
	ld a, b;								// 
	or c;								// 
	jp nz, main_add;								// 
	rst get_char;								// 
	cp ctrl_enter;								// 
	jr z, main_exec;								// 
	bit 0, (iy + _flags2);								// 
	call nz, cl_all;								// 
	call cls_lower;								// 
	ld a, 25;								// 
	sub (iy + _s_posn_h);								// 
	ld (scr_ct), a;								// 
	set 7, (iy + _flags);								// 
	ld (iy + _err_nr), 255;								// 
	ld (iy + _nsppc), 1;								// 
	call line_run

	org $1303
main_4:
	halt;								// 
	res 5, (iy + _flags);								// 
	bit 1, (iy + _flags2);								// 
	call nz, copy_buff;								// 
	ld a, (err_nr);								// 
	inc a

	org $1313
main_g:
	push af;								// 
	ld hl, $0000;								// 
	ld (iy + _flagx), h;								// 
	ld (iy + _x_ptr_h), h;								// 
	ld (defadd), hl;								// 
	ld hl, $0001;								// 
	ld (strms_00), hl;								// 
	call set_min;								// 
	res 5, (iy + _flagx);								// 
	call cls_lower;								// 
	set 5, (iy + _vdu_flag);								// 
	pop af;								// 
	ld b, a;								// 
	cp 10;								// 
	jr c, main_5;								// 
	add a, 7

	org $133c
main_5:
	call out_code;								// 
	ld a, ' ';								// 
	rst print_a;								// 
	ld a, b;								// 
	ld de, rpt_mesgs;								// 
	call po_msg;								// 
	xor a;								// 
	ld de, comma_sp - 1;								// 
	call po_msg;								// 
	ld bc, (ppc);								// 
	call out_num_1;								// 
	ld a, ':';								// 
	rst print_a;								// 
	ld c, (iy + _subppc);								// 
	ld b, 0;								// 
	call out_num_1;								// 
	call clear_sp;								// 
	ld a, (err_nr);								// 
	inc a;								// 
	jr z, main_9;								// 
	cp 9;								// 
	jr z, main_6;								// 
	cp 21;								// 
	jr nz, main_7

	org $1373
main_6:
	inc (iy + _subppc)

	org $1376
main_7:
	ld bc, $0003;								// 
	ld de, osppc;								// 
	ld hl, nsppc;								// 
	bit 7, (hl);								// 
	jr z, main_8;								// 
	add hl, bc

	org $1384
main_8:
	lddr

	org $1386
main_9:
	ld (iy + _nsppc), 255;								// 
	res 3, (iy + _flags);								// 
	jp main_2

	org $1391
rpt_mesgs:
	defb $80;								// 
	defb 'O', 'K' + $80;								// 
	defb "NEXT without FO", 'R' + $80;								// 
	defb "Variable not foun", 'd' + $80;								// 
	defb "Subscript wron", 'g' + $80;								// 
	defb "Out of memor", 'y' + $80;								// 
	defb "Out of scree", 'n' + $80;								// 
	defb "Number too bi", 'g' + $80;								// 
	defb "RETURN without GOSU", 'B' + $80;								// 
	defb "End of fil", 'e' + $80;								// 
	defb "STOP statemen", 't' + $80;								// 
	defb "Invalid argumen", 't' + $80;								// 
	defb "Integer out of rang", 'e' + $80;								// 
	defb "Nonsense in BASI", 'C' + $80;								// 
	defb "BREAK - CONT repeat", 's' + $80;								// 
	defb "Out of DAT", 'A' + $80;								// 
	defb "Invalid file nam", 'e' + $80;								// 
	defb "No room for lin", 'e' + $80;								// 
	defb "STOP in INPU", 'T' + $80;								// 
	defb "FOR without NEX", 'T' + $80;								// 
	defb "Invalid I/O devic", 'e' + $80;								// 
	defb "Invalid colou", 'r' + $80;								// 
	defb "BREAK into progra", 'm' + $80;								// 
	defb "RAMTOP no goo", 'd' + $80;								// 
	defb "Statement los", 't' + $80;								// 
	defb "Invalid strea", 'm' + $80;								// 
	defb "FN without DE", 'F' + $80;								// 
	defb "Parameter erro", 'r' + $80;								// 
	defb "Tape loading erro", 'r' + $80

	org $1537
comma_sp:
	defb ',', ' ' + $80

	org $1539
copyright:
	defb pchr_copyright, " 1982 Sinclair Research Lt", 'd' + $80

	org $1555
report_g:
	ld a, 16;								// 
	ld bc, $0000;								// 
	jp main_g

	org $155d
main_add:
	ld (e_ppc), bc;								// 
	ld hl, (ch_add);								// 
	ex de, hl;								// 
	ld hl, report_g;								// 
	push hl;								// 
	ld hl, (worksp);								// 
	scf;								// 
	sbc hl, de;								// 
	push hl;								// 
	ld h, b;								// 
	ld l, c;								// 
	call line_addr;								// 
	jr nz, main_add1;								// 
	call next_one;								// 
	call reclaim_2

	org $157d
main_add1:
	pop bc;								// 
	ld a, c;								// 
	dec a;								// 
	or b;								// 
	jr z, main_add2;								// 
	push bc;								// 
	inc bc;								// 
	inc bc;								// 
	inc bc;								// 
	inc bc;								// 
	dec hl;								// 
	ld de, (prog);								// 
	push de;								// 
	call make_room;								// 
	pop hl;								// 
	ld (prog), hl;								// 
	pop bc;								// 
	push bc;								// 
	inc de;								// 
	ld hl, (worksp);								// 
	dec hl;								// 
	dec hl;								// 
	lddr;								// 
	ld hl, (e_ppc);								// 
	ex de, hl;								// 
	pop bc;								// 
	ld (hl), b;								// 
	dec hl;								// 
	ld (hl), c;								// 
	dec hl;								// 
	ld (hl), e;								// 
	dec hl;								// 
	ld (hl), d

	org $15ab
main_add2:
	pop af;								// 
	jp main_exec

	org $15af
init_chan:
	defw print_out, key_input;								// 
	defb 'K';								// 
	defw print_out, report_j;								// 
	defb 'S';								// 
	defw add_char, report_j;								// 
	defb 'R';								// 
	defw print_out, report_j;								// 
	defb 'P', $80

	org $15c4
report_j:
	rst error;								// 
	defb invalid_io_device

	org $15c6
init_strm:
	defb $01, $00;								// 
	defb $06, $00;								// 
	defb $0b, $00;								// 
	defb $01, $00;								// 
	defb $01, $00;								// 
	defb $06, $00;								// 
	defb $10, $00

	org $15d4
wait_key:
	bit 5, (iy + _vdu_flag);								// 
	jr nz, wait_key1;								// 
	set 3, (iy + _vdu_flag)

	org $15de
wait_key1:
	call input_ad;								// 
	ret c;								// 
	jr z, wait_key1

	org $15e4
report_8:
	rst error;								// 
	defb end_of_file

	org $15e6
input_ad:
	exx;								// 
	push hl;								// 
	ld hl, (curchl);								// 
	inc hl;								// 
	inc hl;								// 
	jr call_sub

	org $15ef
out_code:
	ld e, '0';								// 
	add a, e

	org $15f2
print_a_2:
	exx;								// 
	push hl;								// 
	ld hl, (curchl)

	org $15f7
call_sub:
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	ex de, hl;								// 
	call call_jump;								// 
	pop hl;								// 
	exx;								// 
	ret

	org $1601
chan_open:
	add a, a;								// 
	add a, 22;								// 
	ld l, a;								// 
	ld h, 92;								// 
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	ld a, d;								// 
	or e;								// 
	jr nz, chan_op_1

	org $160e
report_oa:
	rst error;								// 
	defb invalid_stream

	org $1610
chan_op_1:
	dec de;								// 
	ld hl, (chans);								// 
	add hl, de

	org $1615
chan_flag:
	ld (curchl), hl;								// 
	res 4, (iy + _flags2);								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld c, (hl);								// 
	ld hl, chn_cd_lu;								// 
	call indexer;								// 
	ret nc;								// 
	ld d, 0;								// 
	ld e, (hl);								// 
	add hl, de

	org $162c
call_jump:
	jp (hl)

	org $162d
chn_cd_lu:
	defb 'K', chan_k - $ - 1;								// 
	defb 'S', chan_s - $ - 1;								// 
	defb 'P', chan_p - $ - 1;								// 
	defb $00

	org $1634
chan_k:
	set 0, (iy + _vdu_flag);								// 
	res 5, (iy + _flags);								// 
	set 4, (iy + _flags2);								// 
	jr chan_s_1

	org $1642
chan_s:
	res 0, (iy + _vdu_flag)

	org $1646
chan_s_1:
	res 1, (iy + _flags);								// 
	jp temps

	org $164d
chan_p:
	set 1, (iy + _flags);								// 
	ret

	org $1652
one_space:
	ld bc, $0001

	org $1655
make_room:
	push hl;								// 
	call test_room;								// 
	pop hl;								// 
	call pointers;								// 
	ld hl, (stkend);								// 
	ex de, hl;								// 
	lddr;								// 
	ret

	org $1664
pointers:
	push af;								// 
	push hl;								// 
	ld hl, vars;								// 
	ld a, 14

	org $166b
ptr_next:
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	ex (sp), hl;								// 
	and a;								// 
	sbc hl, de;								// 
	add hl, de;								// 
	ex (sp), hl;								// 
	jr nc, ptr_done;								// 
	push de;								// 
	ex de, hl;								// 
	add hl, bc;								// 
	ex de, hl;								// 
	ld (hl), d;								// 
	dec hl;								// 
	ld (hl), e;								// 
	inc hl;								// 
	pop de

	org $167f
ptr_done:
	inc hl;								// 
	dec a;								// 
	jr nz, ptr_next;								// 
	ex de, hl;								// 
	pop de;								// 
	pop af;								// 
	and a;								// 
	sbc hl, de;								// 
	ld b, h;								// 
	ld c, l;								// 
	inc bc;								// 
	add hl, de;								// 
	ex de, hl;								// 
	ret

	org $168f
line_zero:
	defw $0000

	org $1691
line_no_a:
	ex de, hl;								// 
	ld de, line_zero

	org $1695
line_no:
	ld a, (hl);								// 
	and %11000000;								// 
	jr nz, line_no_a;								// 
	ld d, (hl);								// 
	inc hl;								// 
	ld e, (hl);								// 
	ret

	org $169e
reserve:
	ld hl, (stkbot);								// 
	dec hl;								// 
	call make_room;								// 
	inc hl;								// 
	inc hl;								// 
	pop bc;								// 
	ld (worksp), bc;								// 
	pop bc;								// 
	ex de, hl;								// 
	inc hl;								// 
	ret

	org $16b0
set_min:
	ld hl, (e_line);								// 
	ld (hl), 13;								// 
	ld (k_cur), hl;								// 
	inc hl;								// 
	ld (hl), $80;								// 
	inc hl;								// 
	ld (worksp), hl

	org $16bf
set_work:
	ld hl, (worksp);								// 
	ld (stkbot), hl

	org $16c5
set_stk:
	ld hl, (stkbot);								// 
	ld (stkend), hl;								// 
	push hl;								// 
	ld hl, membot;								// 
	ld (mem), hl;								// 
	pop hl;								// 
	ret

	org $16d4
rec_edit:
	ld de, (e_line);								// 
	jp reclaim_1

	org $16db
indexer_1:
	inc hl

	org $16dc
indexer:
	ld a, (hl);								// 
	and a;								// 
	ret z;								// 
	cp c;								// 
	inc hl;								// 
	jr nz, indexer_1;								// 
	scf;								// 
	ret

	org $16e5
close:
	call str_data;								// 
	call close_2;								// 
	ld bc, $0000;								// 
	ld de, $a3e2;								// 
	ex de, hl;								// 
	add hl, de;								// 
	jr c, close_1;								// 
	ld bc, init_strm + 14;								// 
	add hl, bc;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl)

	org $16fc
close_1:
	ex de, hl;								// 
	ld (hl), c;								// 
	inc hl;								// 
	ld (hl), b;								// 
	ret

	org $1701
close_2:
	push hl;								// 
	ld hl, (chans);								// 
	add hl, bc;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld c, (hl);								// 
	ex de, hl;								// 
	ld hl, cl_str_lu;								// 
	call indexer;								// 
	ld c, (hl);								// 
	ld b, 0;								// 
	add hl, bc;								// 
	jp (hl)

	org $1716
cl_str_lu:
	defb 'K', close_str - $ - 1;								// 
	defb 'S', close_str - $ - 1;								// 
	defb 'P', close_str - $ - 1;								//

	org $171c
close_str:   ;								// 
	pop hl;								// 
	ret

	org $171e
str_data:
	call find_int1;								// 
	cp 16;								// 
	jr c, str_data1

	org $1725
report_ob:
	rst error;								// 
	defb invalid_stream

	org $1727
str_data1:
	add a, 3;								// 
	rlca;								// 
	ld hl, strms;								// 
	ld c, a;								// 
	ld b, 0;								// 
	add hl, bc;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	dec hl;								// 
	ret

	org $1736
open:
	fwait;								// 
	fxch;								// 
	fce;								// 
	call str_data;								// 
	ld a, b;								// 
	or c;								// 
	jr z, open_1;								// 
	ex de, hl;								// 
	ld hl, (chans);								// 
	add hl, bc;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld a, (hl);								// 
	ex de, hl;								// 
	cp 75;'K';								// 
	jr z, open_1;								// 
	cp 83;'S';								// 
	jr z, open_1;								// 
	cp 80;								// 
	jr nz, report_ob

	org $1756
open_1:
	call open_2;								// 
	ld (hl), e;								// 
	inc hl;								// 
	ld (hl), d;								// 
	ret

	org $175d
open_2:
	push hl;								// 
	call stk_fetch;								// 
	ld a, b;								// 
	or c;								// 
	jr nz, open_3

	org $1765
report_fb:
	rst error;								// 
	defb invalid_file_name

	org $1767
open_3:
	push bc;								// 
	ld a, (de);								// 
	and %11011111;								// 
	ld c, a;								// 
	ld hl, op_str_lu;								// 
	call indexer;								// 
	jr nc, report_fb;								// 
	ld c, (hl);								// 
	ld b, 0;								// 
	add hl, bc;								// 
	pop bc;								// 
	jp (hl)

	org $177a
op_str_lu:
	defb 'K', open_k - $ - 1;								// 
	defb 'S', open_s - $ - 1;								// 
	defb 'P', open_p - $ - 1;								// 
	defb $00

	org $1781
open_k:
	ld e, 1;								// 
	jr open_end

	org $1785
open_s:
	ld e, 6;								// 
	jr open_end

	org $1789
open_p:
	ld e, 16

	org $178b
open_end:
	dec bc;								// 
	ld a, b;								// 
	or c;								// 
	jr nz, report_fb;								// 
	ld d, a;								// 
	pop hl;								// 
	ret

	org $1793
cat_etc:
	jr report_ob

	org $1795
auto_list:
	ld (list_sp), sp;								// 
	ld (iy + _vdu_flag), 16;								// 
	call cl_all;								// 
	set 0, (iy + _vdu_flag);								// 
	ld b, (iy + _df_sz);								// 
	call cl_line;								// 
	res 0, (iy + _vdu_flag);								// 
	set 0, (iy + _flags2);								// 
	ld hl, (e_ppc);								// 
	ld de, (s_top);								// 
	and a;								// 
	sbc hl, de;								// 
	add hl, de;								// 
	jr c, auto_l_2;								// 
	push de;								// 
	call line_addr;								// 
	ld de, $02c0;								// 
	ex de, hl;								// 
	sbc hl, de;								// 
	ex (sp), hl;								// 
	call line_addr;								// 
	pop bc

	org $17ce
auto_l_1:
	push bc;								// 
	call next_one;								// 
	pop bc;								// 
	add hl, bc;								// 
	jr c, auto_l_3;								// 
	ex de, hl;								// 
	ld d, (hl);								// 
	inc hl;								// 
	ld e, (hl);								// 
	dec hl;								// 
	ld (s_top), de;								// 
	jr auto_l_1

	org $17e1
auto_l_2:
	ld (s_top), hl

	org $17e4
auto_l_3:
	ld hl, (s_top);								// 
	call line_addr;								// 
	jr z, auto_l_4;								// 
	ex de, hl

	org $17ed
auto_l_4:
	call list_all;								// 
	res 4, (iy + _vdu_flag);								// 
	ret

	org $17f5
llist:
	ld a, 3;								// 
	jr list_1

	org $17f9
c_list:
	ld a, 2

	org $17fb
list_1:
	ld (iy + _vdu_flag), 0;								// 
	call syntax_z;								// 
	call nz, chan_open;								// 
	rst get_char;								// 
	call str_alter;								// 
	jr c, list_4;								// 
	rst get_char;								// 
	cp 59;':';;								// 
	jr z, list_2;								// 
	cp 44;',';								// 
	jr nz, list_3

	org $1814
list_2:
	rst next_char;								// 
	call expt_1num;								// 
	jr list_5

	org $181a
list_3:
	call use_zero;								// 
	jr list_5

	org $181f
list_4:
	call fetch_num

	org $1822
list_5:
	call check_end;								// 
	call find_int2;								// 
	ld a, b;								// 
	and %00111111;								// 
	ld h, a;								// 
	ld l, c;								// 
	ld (e_ppc), hl;								// 
	call line_addr

	org $1833
list_all:
	ld e, 1

	org $1835
list_all_2:
	call out_line;								// 
	rst print_a;								// 
	bit 4, (iy + _vdu_flag);								// 
	jr z, list_all_2;								// 
	ld a, (df_sz);								// 
	sub (iy + _s_posn_h);								// 
	jr nz, list_all_2;								// 
	xor e;								// 
	ret z;								// 
	push hl;								// 
	push de;								// 
	ld hl, s_top;								// 
	call ln_fetch;								// 
	pop de;								// 
	pop hl;								// 
	jr list_all_2

	org $1855
out_line:
	ld bc, (e_ppc);								// 
	call cp_lines;								// 
	ld d, '>';								// 
	jr z, out_line1;								// 
	ld de, $0000;								// 
	rl e

	org $1865
out_line1:
	ld (iy + $2d), e ;breg;								// 
	ld a, (hl);								// 
	cp 64;								// 
	pop bc;								// 
	ret nc;								// 
	push bc;								// 
	call out_num_2;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	res 0, (iy + _flags);								// 
	ld a, d;								// 
	and a;								// 
	jr z, out_line3;								// 
	rst print_a

	org $187d
out_line2:
	set 0, (iy + _flags)

	org $1881
out_line3:
	push de;								// 
	ex de, hl;								// 
	res 2, (iy + _flags2);								// 
	ld hl, flags;								// 
	res 2, (hl);								// 
	bit 5, (iy + _flagx);								// 
	jr z, out_line4;								// 
	set 2, (hl)

	org $1894
out_line4:
	ld hl, (x_ptr);								// 
	and a;								// 
	sbc hl, de;								// 
	jr nz, out_line5;								// 
	ld a, '?';								// 
	call out_flash

	org $18a1
out_line5:
	call out_curs;								// 
	ex de, hl;								// 
	ld a, (hl);								// 
	call number;								// 
	inc hl;								// 
	cp ctrl_enter;								// 
	jr z, out_line6;								// 
	ex de, hl;								// 
	call out_char;								// 
	jr out_line4

	org $18b4
out_line6:
	pop de;								// 
	ret

	org $18b6
number:
	cp ctrl_number;								// 
	ret nz;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld a, (hl);								// 
	ret

	org $18c1
out_flash:
	exx;								// 
	ld hl, (attr_t);								// 
	push hl;								// 
	res 7, h;								// 
	set 7, l;								// 
	ld (attr_t), hl;								// 
	ld hl, p_flag;								// 
	ld d, (hl);								// 
	push de;								// 
	ld (hl), 0;								// 
	call print_out;								// 
	pop hl;								// 
	ld (iy + _p_flag), h;								// 
	pop hl;								// 
	ld (attr_t), hl;								// 
	exx;								// 
	ret

	org $18e1
out_curs:
	ld hl, (k_cur);								// 
	and a;								// 
	sbc hl, de;								// 
	ret nz;								// 
	ld a, (mode);								// 
	rlc a;								// 
	jr z, out_c_1;								// 
	add a, 'C';								// 
	jr out_c_2

	org $18f3
out_c_1:
	ld hl, flags;								// 
	res 3, (hl);								// 
	ld a, 'K';								// 
	bit 2, (hl);								// 
	jr z, out_c_2;								// 
	set 3, (hl);								// 
	inc a;								// 
	bit 3, (iy + _flags2);								// 
	jr z, out_c_2;								// 
	ld a, 'C'

	org $1909
out_c_2:
	push de;								// 
	call out_flash;								// 
	pop de;								// 
	ret

	org $190f
ln_fetch:
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	push hl;								// 
	ex de, hl;								// 
	inc hl;								// 
	call line_addr;								// 
	call line_no;								// 
	pop hl

	org $191c
ln_store:
	bit 5, (iy + _flagx);								// 
	ret nz;								// 
	ld (hl), d;								// 
	dec hl;								// 
	ld (hl), e;								// 
	ret

	org $1925
out_sp_2:
	ld a, e;								// 
	and a;								// 
	ret m;								// 
	jr out_char

	org $192a
out_sp_no:
	xor a

	org $192b
out_sp_1:
	add hl, bc;								// 
	inc a;								// 
	jr c, out_sp_1;								// 
	sbc hl, bc;								// 
	dec a;								// 
	jr z, out_sp_2;								// 
	jp out_code

	org $1937
out_char:
	call numeric;								// 
	jr nc, out_ch_3;								// 
	cp 33;'!';;								// 
	jr c, out_ch_3;								// 
	res 2, (iy + _flags);								// 
	cp tk_then;								// 
	jr z, out_ch_3;								// 
	cp 58;':';;								// 
	jr nz, out_ch_1;								// 
	bit 5, (iy + _flagx);								// 
	jr nz, out_ch_2;								// 
	bit 2, (iy + _flags2);								// 
	jr z, out_ch_3;								// 
	jr out_ch_2

	org $195a
out_ch_1:
	cp 34;'";";								// 
	jr nz, out_ch_2;								// 
	push af;								// 
	ld a, (flags2);								// 
	xor %00000100;								// 
	ld (flags2), a;								// 
	pop af

	org $1968
out_ch_2:
	set 2, (iy + _flags)

	org $196c
out_ch_3:
	rst print_a;								// 
	ret

	org $196e
line_addr:
	push hl;								// 
	ld hl, (prog);								// 
	ld d, h;								// 
	ld e, l

	org $1974
line_ad_1:
	pop bc;								// 
	call cp_lines;								// 
	ret nc;								// 
	push bc;								// 
	call next_one;								// 
	ex de, hl;								// 
	jr line_ad_1

	org $1980
cp_lines:
	ld a, (hl);								// 
	cp b;								// 
	ret nz;								// 
	inc hl;								// 
	ld a, (hl);								// 
	dec hl;								// 
	cp c;								// 
	ret;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl

	org $198b
each_stmt:
	ld (ch_add), hl;								// 
	ld c, 0

	org $1990
each_s_1:
	dec d;								// 
	ret z;								// 
	rst next_char;								// 
	cp e;								// 
	jr nz, each_s_3;								// 
	and a;								// 
	ret

	org $1998
each_s_2:
	inc hl;								// 
	ld a, (hl)

	org $199a
each_s_3:
	call number;								// 
	ld (ch_add), hl;								// 
	cp 34;'";";								// 
	jr nz, each_s_4;								// 
	dec c

	org $19a5
each_s_4:
	cp 58;':';;								// 
	jr z, each_s_5;								// 
	cp tk_then;								// 
	jr nz, each_s_6

	org $19ad
each_s_5:
	bit 0, c ;								// 
	jr z, each_s_1

	org $19b1
each_s_6:
	cp ctrl_enter;								// 
	jr nz, each_s_2;								// 
	dec d;								// 
	scf;								// 
	ret

	org $19b8
next_one:
	push hl;								// 
	ld a, (hl);								// 
	cp 64;								// 
	jr c, next_o_3;								// 
	bit 5, a;								// 
	jr z, next_o_4;								// 
	add a, a;								// 
	jp m, next_o_1;								// 
	ccf

	org $19c7
next_o_1:
	ld bc, $0005;								// 
	jr nc, next_o_2;								// 
	ld c, 18

	org $19ce
next_o_2:
	rla;								// 
	inc hl;								// 
	ld a, (hl);								// 
	jr nc, next_o_2;								// 
	jr next_o_5

	org $19d5
next_o_3:
	inc hl

	org $19d6
next_o_4:
	inc hl;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	inc hl

	org $19db
next_o_5:
	add hl, bc;								// 
	pop de

	org $19dd
differ:
	and a;								// 
	sbc hl, de;								// 
	ld b, h;								// 
	ld c, l;								// 
	add hl, de;								// 
	ex de, hl;								// 
	ret

	org $19e5
reclaim_1:
	call differ

	org $19e8
reclaim_2:
	push bc;								// 
	ld a, b;								// 
	cpl ;								// 
	ld b, a;								// 
	ld a, c;								// 
	cpl ;								// 
	ld c, a;								// 
	inc bc;								// 
	call pointers;								// 
	ex de, hl;								// 
	pop hl;								// 
	add hl, de;								// 
	push de;								// 
	ldir;								// 
	pop hl;								// 
	ret 

	org $19fb
e_line_no:
	ld hl, (e_line);								// 
	dec hl;								// 
	ld (ch_add), hl;								// 
	rst next_char;								// 
	ld hl, membot;								// 
	ld (stkend), hl;								// 
	call int_to_fp;								// 
	call fp_to_bc;								// 
	jr c, e_l_1;								// 
	ld hl, $d8f0;								// 
	add hl, bc

	org $1a15
e_l_1:
	jp c, report_c;								// 
	jp set_stk

	org $1a1b
out_num_1:
	push de;								// 
	push hl;								// 
	xor a;								// 
	bit 7, b;								// 
	jr nz, out_num_4;								// 
	ld h, b;								// 
	ld l, c;								// 
	ld e, 255;								// 
	jr out_num_3

	org $1a28
out_num_2:
	push de;								// 
	ld d, (hl);								// 
	inc hl;								// 
	ld e, (hl);								// 
	push hl;								// 
	ex de, hl;								// 
	ld e, ' '

	org $1a30
out_num_3:
	ld bc, $fc18;								// 
	call out_sp_no;								// 
	ld bc, $ff9c;								// 
	call out_sp_no;								// 
	ld c, $f6;								// 
	call out_sp_no;								// 
	ld a, l

	org $1a42
out_num_4:
	call out_code;								// 
	pop hl;								// 
	pop de;								// 
	ret
