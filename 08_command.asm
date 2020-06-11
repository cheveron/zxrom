;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $1a48
offst_tbl:
	defb p_def_fn - $;								// 
	defb p_cat - $;								// 
	defb p_format - $;								// 
	defb p_move - $;								// 
	defb p_erase - $;								// 
	defb p_open  - $;								// 
	defb p_close - $;								// 
	defb p_merge - $;								// 
	defb p_verify - $;								// 
	defb p_beep - $;								// 
	defb p_circle - $;								// 
	defb p_ink - $;								// 
	defb p_paper - $;								// 
	defb p_flash - $;								// 
	defb p_bright - $;								// 
	defb p_inverse - $;								// 
	defb p_over - $;								// 
	defb p_out - $;								// 
	defb p_lprint - $;								// 
	defb p_llist - $;								// 
	defb p_stop - $;								// 
	defb p_read - $;								// 
	defb p_data - $;								// 
	defb p_restore - $;								// 
	defb p_new - $;								// 
	defb p_border - $;								// 
	defb p_continue - $;								// 
	defb p_dim - $;								// 
	defb p_rem - $;								// 
	defb p_for - $;								// 
	defb p_go_to - $;								// 
	defb p_go_sub - $;								// 
	defb p_input - $;								// 
	defb p_load - $;								// 
	defb p_list - $;								// 
	defb p_let - $;								// 
	defb p_pause - $;								// 
	defb p_next - $;								// 
	defb p_poke - $;								// 
	defb p_print - $;								// 
	defb p_plot - $;								// 
	defb p_run - $;								// 
	defb p_save - $;								// 
	defb p_random - $;								// 
	defb p_if - $;								// 
	defb p_cls - $;								// 
	defb p_draw - $;								// 
	defb p_clear - $;								// 
	defb p_return - $;								// 
	defb p_copy - $

	org $1a7a
p_let:
	defb var_rqd, '=', expr_num_str

	org $1a7d
p_go_to:
	defb num_exp, no_f_ops;								// 
	defw go_to

	org $1a81
p_if:
	defb num_exp, tk_then, var_syn;								// 
	defw fn_if

	org $1a86
p_go_sub:
	defb num_exp, no_f_ops;								// 
	defw go_sub

	org $1a8a
p_stop:
	defb no_f_ops;								// 
	defw c_stop

	org $1a8d
p_return:
	defb no_f_ops;								// 
	defw return

	org $1a90
p_for:
	defb chr_var, '=', num_exp, tk_to, num_exp, var_syn;								// 
	defw for

	org $1a98
p_next:
	defb chr_var, no_f_ops;								// 
	defw next

	org $1a9c
p_print:
	defb var_syn;								// 
	defw c_print

	org $1a9f
p_input:
	defb var_syn;								// 
	defw input

	org $1aa2
p_dim:
	defb var_syn;								// 
	defw dim

	org $1aa5
p_rem:
	defb var_syn;								// 
	defw rem

	org $1aa8
p_new:
	defb no_f_ops;								// 
	defw new

	org $1aab
p_run:
	defb num_exp_0;								// 
	defw c_run

	org $1aae
p_list:
	defb var_syn;								// 
	defw c_list

	org $1ab1
p_poke:
	defb two_c_s_num, no_f_ops;								// 
	defw poke

	org $1ab5
p_random:
	defb num_exp_0;								// 
	defw randomize

	org $1ab8
p_continue:
	defb no_f_ops;								// 
	defw continue

	org $1abb
p_clear:
	defb num_exp_0;								// 
	defw clear

	org $1abe
p_cls:
	defb no_f_ops;								// 
	defw cls

	org $1ac1
p_plot:
	defb two_csn_col, no_f_ops;								// 
	defw plot

	org $1ac5
p_pause:
	defb num_exp, no_f_ops;								// 
	defw pause

	org $1ac9
p_read:
	defb var_syn;								// 
	defw read

	org $1acc
p_data:
	defb var_syn;								// 
	defw data

	org $1acf
p_restore:
	defb num_exp_0;								// 
	defw restore

	org $1ad2
p_draw:
	defb two_csn_col, var_syn;								// 
	defw draw

	org $1ad6
p_copy:
	defb no_f_ops;								// 
	defw copy

	org $1ad9
p_lprint:
	defb var_syn;								// 
	defw lprint

	org $1adc
p_llist:
	defb var_syn;								// 
	defw llist

	org $1adf
p_save:
	defb tap_offst

	org $1ae0
p_load:
	defb tap_offst

	org $1ae1
p_verify:
	defb tap_offst

	org $1ae2
p_merge:
	defb tap_offst

	org $1ae3
p_beep:
	defb two_c_s_num, no_f_ops;								// 
	defw beep

	org $1ae7
p_circle:
	defb two_csn_col, var_syn;								// 
	defw circle

	org $1aeb
p_ink:
	defb col_offst

	org $1aec
p_paper:
	defb col_offst

	org $1aed
p_flash:
	defb col_offst

	org $1aee
p_bright:
	defb col_offst

	org $1aef
p_inverse:
	defb col_offst

	org $1af0
p_over:
	defb col_offst

	org $1af1
p_out:
	defb two_c_s_num, no_f_ops;								// 
	defw fn_out

	org $1af5
p_border:
	defb num_exp, no_f_ops;								// 
	defw border

	org $1af9
p_def_fn:
	defb var_syn;								// 
	defw def_fn

	org $1afc
p_open:
	defb num_exp, 44, str_exp, no_f_ops;								// 
	defw open

	org $1b02
p_close:
	defb num_exp, no_f_ops;								// 
	defw close

	org $1b06
p_format:
	defb str_exp, no_f_ops;								// 
	defw cat_etc

	org $1b0a
p_move:
	defb str_exp, 44, str_exp, no_f_ops;								// 
	defw cat_etc

	org $1b10
p_erase:
	defb str_exp, no_f_ops;								// 
	defw cat_etc

	org $1b14
p_cat:
	defb no_f_ops;								// 
	defw cat_etc

	org $1b17
line_scan:
	res 7, (iy + _flags);								// 
	call e_line_no;								// 
	xor a;								// 
	ld (subppc), a;								// 
	dec a;								// 
	ld (err_nr), a;								// 
	jr stmt_l_1

	org $1b28
stmt_loop:
	rst next_char

	org $1b29
stmt_l_1:
	call set_work;								// 
	inc (iy + _subppc);								// 
	jp m, report_c;								// 
	rst get_char;								// 
	ld b, 0;								// 
	cp ctrl_enter;								// 
	jr z, line_end;								// 
	cp 58;':';;								// 
	jr z, stmt_loop;								// 
	ld hl, stmt_ret;								// 
	push hl;								// 
	ld c, a;								// 
	rst next_char;								// 
	ld a, c;								// 
	sub tk_def_fn;								// 
	jp c, report_c;								// 
	ld c, a;								// 
	ld hl, offst_tbl;								// 
	add hl, bc;								// 
	ld c, (hl);								// 
	add hl, bc;								// 
	jr get_param

	org $1b52
scan_loop:
	ld hl, (t_addr)

	org $1b55
get_param:
	ld a, (hl);								// 
	inc hl;								// 
	ld (t_addr), hl;								// 
	ld bc, scan_loop;								// 
	push bc;								// 
	ld c, a;								// 
	cp 32;' ';								// 
	jr nc, separator;								// 
	ld hl, class_tbl;								// 
	ld b, 0;								// 
	add hl, bc;								// 
	ld c, (hl);								// 
	add hl, bc;								// 
	push hl;								// 
	rst get_char;								// 
	dec b;								// 
	ret

	org $1b6f
separator:
	rst get_char;								// 
	cp c;								// 
	jp nz, report_c;								// 
	rst next_char;								// 
	ret

	org $1b76
stmt_ret:
	call break_key;								// 
	jr c, stmt_r_1

	org $1b7b
report_l:
	rst error;								// 
	defb break_into_program

	org $1b7d
stmt_r_1:
	bit 7, (iy + $0a) ;nsppc;								// 
	jr nz, stmt_next;								// 
	ld hl, (newppc);								// 
	bit 7, h;								// 
	jr z, line_new

	org $1b8a
line_run:
	ld hl, $fffe;								// 
	ld (ppc), hl;								// 
	ld hl, (worksp);								// 
	dec hl;								// 
	ld de, (e_line);								// 
	dec de;								// 
	ld a, (nsppc);								// 
	jr next_line

	org $1b9e
line_new:
	call line_addr;								// 
	ld a, (nsppc);								// 
	jr z, line_use;								// 
	and a;								// 
	jr nz, report_n;								// 
	ld b, a;								// 
	ld a, (hl);								// 
	and %11000000;								// 
	ld a, b;								// 
	jr z, line_use

	org $1bb0
report_0:
	rst error;								// 
	defb ok

	org $1bb2
rem:
	pop bc

	org $1bb3
line_end:
	call syntax_z;								// 
	ret z;								// 
	ld hl, (nxtlin);								// 
	ld a, 192;								// 
	and (hl);								// 
	ret nz;								// 
	xor a

	org $1bbf
line_use:
	cp 1;								// 
	adc a, 0;								// 
	ld d, (hl);								// 
	inc hl;								// 
	ld e, (hl);								// 
	ld (ppc), de;								// 
	inc hl;								// 
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	ex de, hl;								// 
	add hl, de;								// 
	inc hl

	org $1bd1
next_line:
	ld (nxtlin), hl;								// 
	ex de, hl;								// 
	ld (ch_add), hl;								// 
	ld d, a;								// 
	ld e, 0;								// 
	ld (iy + _nsppc), 255;								// 
	dec d;								// 
	ld (iy + _subppc), d;								// 
	jp z, stmt_loop;								// 
	inc d;								// 
	call each_stmt;								// 
	jr z, stmt_next

	org $1bec
report_n:
	rst error;								// 
	defb statement_lost

	org $1bee
check_end:
	call syntax_z;								// 
	ret nz;								// 
	pop bc;								// 
	pop bc

	org $1bf4
stmt_next:
	rst get_char;								// 
	cp ctrl_enter;								// 
	jr z, line_end;								// 
	cp 58;':';;								// 
	jp z, stmt_loop;								// 
	jp report_c

	org $1c01
class_tbl:
	defb class_00 - $;								// 
	defb class_01 - $;								// 
	defb class_02 - $;								// 
	defb class_03 - $;								// 
	defb class_04 - $;								// 
	defb class_05 - $;								// 
	defb class_06 - $;								// 
	defb class_07 - $;								// 
	defb class_08 - $;								// 
	defb class_09 - $;								// 
	defb class_0a - $;								// 
	defb class_0b - $

	org $1c0d
class_03:
	call fetch_num

	org $1c10
class_00:
	cp a

	org $1c11
class_05:
	pop bc;								// 
	call z, check_end;								// 
	ex de, hl;								// 
	ld hl, (t_addr);								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	ex de, hl;								// 
	push bc;								// 
	ret

	org $1c1f
class_01:
	call look_vars

	org $1c22
var_a_1:
	ld (iy + _flagx), 0;								// 
	jr nc, var_a_2;								// 
	set 1, (iy + _flagx);								// 
	jr nz, var_a_3

	org $1c2e
report_2:
	rst error;								// 
	defb variable_not_found

	org $1c30
var_a_2:
	call z, stk_var;								// 
	bit 6, (iy + _flags);								// 
	jr nz, var_a_3;								// 
	xor a;								// 
	call syntax_z;								// 
	call nz, stk_fetch;								// 
	ld hl, flagx;								// 
	or (hl);								// 
	ld (hl), a;								// 
	ex de, hl

	org $1c46
var_a_3:
	ld (strlen), bc;								// 
	ld (dest), hl;								// 
	ret

	org $1c4e
class_02:
	pop bc;								// 
	call val_fet_1;								// 
	call check_end;								// 
	ret

	org $1c56
val_fet_1:
	ld a, (flags)

	org $1c59
val_fet_2:
	push af;								// 
	call scanning;								// 
	pop af;								// 
	ld d, (iy + _flags);								// 
	xor d;								// 
	and %01000000;								// 
	jr nz, report_c;								// 
	bit 7, d;								// 
	jp nz, c_let;								// 
	ret

	org $1c6c
class_04:
	call look_vars;								// 
	push af;								// 
	ld a, c;								// 
	or %10011111;								// 
	inc a;								// 
	jr nz, report_c;								// 
	pop af;								// 
	jr var_a_1

	org $1c79
next_2num:
	rst next_char

	org $1c7a
class_08:
expt_2num:
	call expt_1num;								// 
	cp 44;',';								// 
	jr nz, report_c;								// 
	rst next_char

	org $1c82
class_06:
expt_1num:
	call scanning;								// 
	bit 6, (iy + _flags);								// 
	ret nz

	org $1c8a
report_c:
	rst error;								// 
	defb nonsense_in_basic

	org $1c8c
class_0a:
expt_exp:
	call scanning;								// 
	bit 6, (iy + _flags);								// 
	ret z;								// 
	jr report_c

	org $1c96
class_07:
	bit 7, (iy + _flags);								// 
	res 0, (iy + _vdu_flag);								// 
	call nz, temps;								// 
	pop af;								// 
	ld a, (t_addr);								// 
	sub p_ink - 216 % 256;								// 
	call co_temp_4;								// 
	call check_end;								// 
	ld hl, (attr_t);								// 
	ld (attr_p), hl;								// 
	ld hl, p_flag;								// 
	ld a, (hl);								// 
	rlca;								// 
	xor (hl);								// 
	and %10101010;								// 
	xor (hl);								// 
	ld (hl), a;								// 
	ret

	org $1cbe
class_09:
	call syntax_z;								// 
	jr z, cl_09_1;								// 
	res 0, (iy + _vdu_flag);								// 
	call temps;								// 
	ld hl, mask_t;								// 
	ld a, (hl);								// 
	or %11111000;								// 
	ld (hl), a;								// 
	res 6, (iy + _p_flag);								// 
	rst get_char

	org $1cd6
cl_09_1:
	call co_temp_2;								// 
	jr expt_2num

	org $1cdb
class_0b:
	jp save_etc

	org $1cde
fetch_num:
	cp ctrl_enter;								// 
	jr z, use_zero;								// 
	cp 58;':';;								// 
	jr nz, expt_1num

	org $1ce6
use_zero:
	call syntax_z;								// 
	ret z;								// 
	fwait;								// 
	fstk0;								// 
	fce;								// 
	ret

	org $1cee
report_9:
c_stop:
	rst error;								// 
	defb stop_statement

	org $1cf0
fn_if:
	pop bc;								// 
	call syntax_z;								// 
	jr z, if_1;								// 
	fwait;								// 
	fdel ;								// 
	fce;								// 
	ex de, hl;								// 
	call test_zero;								// 
	jp c, line_end

	org $1d00
if_1:
	jp stmt_l_1

	org $1d03
for:
	cp tk_step;								// 
	jr nz, f_use_1;								// 
	rst next_char;								// 
	call expt_1num;								// 
	call check_end;								// 
	jr f_reorder

	org $1d10
f_use_1:
	call check_end;								// 
	fwait;								// 
	fstk1;								// 
	fce

	org $1d16
f_reorder:
	fwait;								// 
	fst 0;								// 
	fdel;								// 
	fxch;								// 
	fgt 0;								// 
	fxch;								// 
	fce;								// 
	call c_let;								// 
	ld (mem), hl;								// 
	dec hl;								// 
	ld a, (hl);								// 
	set 7, (hl);								// 
	ld bc, $0006;								// 
	add hl, bc;								// 
	rlca;								// 
	jr c, f_l_s;								// 
	ld c, 13;								// 
	call make_room;								// 
	inc hl

	org $1d34
f_l_s:
	push hl;								// 
	fwait;								// 
	fdel;								// 
	fdel;								// 
	fce;								// 
	pop hl;								// 
	ex de, hl;								// 
	ld c, 10;								// 
	ldir;								// 
	ld hl, (ppc);								// 
	ex de, hl;								// 
	ld (hl), e;								// 
	inc hl;								// 
	ld (hl), d;								// 
	ld d, (iy + _subppc);								// 
	inc d;								// 
	inc hl;								// 
	ld (hl), d;								// 
	call next_loop;								// 
	ret nc;								// 
	ld b, (iy + $38) ;strlen_lo;								// 
	ld hl, (ppc);								// 
	ld (newppc), hl;								// 
	ld a, (subppc);								// 
	neg;								// 
	ld d, a;								// 
	ld hl, (ch_add);								// 
	ld e, tk_next

	org $1d64
f_loop:
	push bc;								// 
	ld bc, (nxtlin);								// 
	call look_prog;								// 
	ld (nxtlin), bc;								// 
	pop bc;								// 
	jr c, report_i;								// 
	rst next_char;								// 
	or %00100000;								// 
	cp b;								// 
	jr z, f_found;								// 
	rst next_char;								// 
	jr f_loop

	org $1d7c
f_found:
	rst next_char;								// 
	ld a, 1;								// 
	sub d;								// 
	ld (nsppc), a;								// 
	ret

	org $1d84
report_i:
	rst error;								// 
	defb for_without_next

	org $1d86
look_prog:
	ld a, (hl);								// 
	cp 58;':';;								// 
	jr z, look_p_2

	org $1d8b
look_p_1:
	inc hl;								// 
	ld a, (hl);								// 
	and %11000000;								// 
	scf;								// 
	ret nz;								// 
	ld b, (hl);								// 
	inc hl;								// 
	ld c, (hl);								// 
	ld (newppc), bc;								// 
	inc hl;								// 
	ld c, (hl);								// 
	inc hl;								// 
	ld b, (hl);								// 
	push hl;								// 
	add hl, bc;								// 
	ld b, h;								// 
	ld c, l;								// 
	pop hl;								// 
	ld d, 0

	org $1da3
look_p_2:
	push bc;								// 
	call each_stmt;								// 
	pop bc;								// 
	ret nc;								// 
	jr look_p_1

	org $1dab
next:
	bit 1, (iy + _flagx);								// 
	jp nz, report_2;								// 
	ld hl, (dest);								// 
	bit 7, (hl);								// 
	jr z, report_1;								// 
	inc hl;								// 
	ld (mem), hl;								// 
	fwait;								// 
	fgt 0;								// 
	fgt 2;								// 
	fadd;								// 
	fst 0;								// 
	fdel;								// 
	fce;								// 
	call next_loop;								// 
	ret c;								// 
	ld hl, (mem);								// 
	ld de, $000f;								// 
	add hl, de;								// 
	ld e, (hl);								// 
	inc hl;								// 
	ld d, (hl);								// 
	inc hl;								// 
	ld h, (hl);								// 
	ex de, hl;								// 
	jp go_to_2

	org $1dd8
report_1:
	rst error;								// 
	defb next_without_for

	org $1dda
next_loop:
	fwait;								// 
	fgt 1;								// 
	fgt 0;								// 
	fgt 2;								// 
	fcp lz;								// 
	fjpt next_1;								// 
	fxch

	org $1de2
next_1:
	fsub;								// 
	fcp gz;								// 
	fjpt next_2;								// 
	fce;								// 
	and a;								// 
	ret

	org $1de9
next_2:
	fce;								// 
	scf;								// 
	ret

	org $1dec
read_3:
	rst next_char

	org $1ded
read:
	call class_01;								// 
	call syntax_z;								// 
	jr z, read_2;								// 
	rst get_char;								// 
	ld (x_ptr), hl;								// 
	ld hl, (datadd);								// 
	ld a, (hl);								// 
	cp 44;								// 
	jr z, read_1;								// 
	ld e, tk_data;								// 
	call look_prog;								// 
	jr nc, read_1

	org $1e08
report_e:
	rst error;								// 
	defb out_of_data

	org $1e0a
read_1:
	call temp_ptr1;								// 
	call val_fet_1;								// 
	rst get_char;								// 
	ld (datadd), hl;								// 
	ld hl, (x_ptr);								// 
	ld (iy + _x_ptr_h), 0;								// 
	call temp_ptr2

	org $1e1e
read_2:
	rst get_char;								// 
	cp 44;								// 
	jr z, read_3;								// 
	call check_end;								// 
	ret

	org $1e27
data:
	call syntax_z;								// 
	jr nz, data_2

	org $1e2c
data_1:
	call scanning;								// 
	cp 44;								// 
	call nz, check_end;								// 
	rst next_char;								// 
	jr data_1

	org $1e37
data_2:
	ld a, tk_data

	org $1e39
pass_by:
	ld b, a;								// 
	cpdr;								// 
	ld de, $0200;								// 
	jp each_stmt

	org $1e42
restore:
	call find_int2

	org $1e45
rest_run:
	ld h, b;								// 
	ld l, c;								// 
	call line_addr;								// 
	dec hl;								// 
	ld (datadd), hl;								// 
	ret

	org $1e4f
randomize:
	call find_int2;								// 
	ld a, b;								// 
	or c;								// 
	jr nz, rand_1;								// 
	ld bc, (frames)

	org $1e5a
rand_1:
	ld (seed), bc;								// 
	ret

	org $1e5f
continue:
	ld hl, (oldppc);								// 
	ld d, (iy + _osppc);								// 
	jr go_to_2

	org $1e67
go_to:
	call find_int2;								// 
	ld h, b;								// 
	ld l, c;								// 
	ld d, 0;								// 
	ld a, h;								// 
	cp 240;								// 
	jr nc, report_bb

	org $1e73
go_to_2:
	ld (newppc), hl;								// 
	ld (iy + $0a), d;								// 
	ret

	org $1e7a
fn_out:
	call two_param;								// 
	out (c), a;								// 
	ret

	org $1e80
poke:
	call two_param;								// 
	ld (bc), a;								// 
	ret

	org $1e85
two_param:
	call fp_to_a;								// 
	jr c, report_bb;								// 
	jr z, two_p_1;								// 
	neg

	org $1e8e
two_p_1:
	push af;								// 
	call find_int2;								// 
	pop af;								// 
	ret

	org $1e94
find_int1:
	call fp_to_a;								// 
	jr find_i_1

	org $1e99
find_int2:
	call fp_to_bc

	org $1e9c
find_i_1:
	jr c, report_bb;								// 
	ret z

	org $1e9f
report_bb:
	rst error;								// 
	defb integer_out_of_range

	org $1ea1
c_run:
	call go_to;								// 
	ld bc, $0000;								// 
	call rest_run;								// 
	jr clear_run

	org $1eac
clear:
	call find_int2

	org $1eaf
clear_run:
	ld a, b;								// 
	or c;								// 
	jr nz, clear_1;								// 
	ld bc, (ramtop)

	org $1eb7
clear_1:
	push bc;								// 
	ld de, (vars);								// 
	ld hl, (e_line);								// 
	dec hl;								// 
	call reclaim_1;								// 
	call cls;								// 
	ld hl, (stkend);								// 
	ld de, $0032;								// 
	add hl, de;								// 
	pop de;								// 
	sbc hl, de;								// 
	jr nc, report_m;								// 
	ld hl, (p_ramt);								// 
	and a;								// 
	sbc hl, de;								// 
	jr nc, clear_2

	org $1eda
report_m:
	rst error;								// 
	defb ramtop_no_good

	org $1edc
clear_2:
	ex de, hl;								// 
	ld (ramtop), hl;								// 
	pop de;								// 
	pop bc;								// 
	ld (hl), $3e;								// 
	dec hl;								// 
	ld sp, hl;								// 
	push bc;								// 
	ld (err_sp), sp;								// 
	ex de, hl;								// 
	jp (hl)

	org $1eed
go_sub:
	pop de;								// 
	ld h, (iy + _subppc);								// 
	inc h;								// 
	ex (sp), hl;								// 
	inc sp;								// 
	ld bc, (ppc);								// 
	push bc;								// 
	push hl;								// 
	ld (err_sp), sp;								// 
	push de;								// 
	call go_to;								// 
	ld bc, $0014

	org $1f05
test_room:
	ld hl, (stkend);								// 
	add hl, bc;								// 
	jr c, report_4;								// 
	ex de, hl;								// 
	ld hl, $0050;								// 
	add hl, de;								// 
	jr c, report_4;								// 
	sbc hl, sp;								// 
	ret c

	org $1f15
report_4:
	ld l, 3;								// 
	jp error_3

	org $1f1a
free_mem:
	ld bc, $0000;								// 
	call test_room;								// 
	ld b, h;								// 
	ld c, l;								// 
	ret

	org $1f23
return:
	pop bc;								// 
	pop hl;								// 
	pop de;								// 
	ld a, d;								// 
	cp $3e;								// 
	jr z, report_7;								// 
	dec sp;								// 
	ex (sp), hl;								// 
	ex de, hl;								// 
	ld (err_sp), sp;								// 
	push bc;								// 
	jp go_to_2

	org $1f36
report_7:
	push de;								// 
	push hl;								// 
	rst error;								// 
	defb return_without_gosub

	org $1f3a
pause:
	call find_int2

	org $1f3d
pause_1:
	halt;								// 
	dec bc;								// 
	ld a, b;								// 
	or c;								// 
	jr z, pause_end;								// 
	ld a, b;								// 
	and c;								// 
	inc a;								// 
	jr nz, pause_2;								// 
	inc bc

	org $1f49
pause_2:
	bit 5, (iy + _flags);								// 
	jr z, pause_1

	org $1f4f
pause_end:
	res 5, (iy + _flags);								// 
	ret

	org $1f54
break_key:
	ld a, 127;								// 
	in a, (ula);								// 
	rra;								// 
	ret c;								// 
	ld a, 254;								// 
	in a, (ula);								// 
	rra;								// 
	ret

	org $1f60
def_fn:
	call syntax_z;								// 
	jr z, def_fn_1;								// 
	ld a, tk_def_fn;								// 
	jp pass_by

	org $1f6a
def_fn_1:
	set 6, (iy + _flags);								// 
	call alpha;								// 
	jr nc, def_fn_4;								// 
	rst next_char;								// 
	cp 36;'$';;								//  
	jr nz, def_fn_2;								// 
	res 6, (iy + _flags);								// 
	rst next_char

	org $1f7d
def_fn_2:
	cp 40;'(';;								// 
	jr nz, def_fn_7;								// 
	rst next_char;								// 
	cp 41;')';;								// 
	jr z, def_fn_6

	org $1f86
def_fn_3:
	call alpha

	org $1f89
def_fn_4:
	jp nc, report_c;								// 
	ex de, hl;								// 
	rst next_char;								// 
	cp 36;'$';;								//  
	jr nz, def_fn_5;								// 
	ex de, hl;								// 
	rst next_char

	org $1f94
def_fn_5:
	ex de, hl;								// 
	ld bc, $0006;								// 
	call make_room;								// 
	inc hl;								// 
	inc hl;								// 
	ld (hl), ctrl_number;								// 
	cp 44;',';								// 
	jr nz, def_fn_6;								// 
	rst next_char;								// 
	jr def_fn_3

	org $1fa6
def_fn_6:
	cp 41;								// ')' 
	jr nz, def_fn_7;								// 
	rst next_char;								// 
	cp 61;'=';								// 
	jr nz, def_fn_7;								// 
	rst next_char;								// 
	ld a, (flags);								// 
	push af;								// 
	call scanning;								// 
	pop af;								// 
	xor (iy + _flags);								// 
	and %01000000

	org $1fbd
def_fn_7:
	jp nz, report_c;								// 
	call check_end

	org $1fc3
unstack_z:
	call syntax_z;								// 
	pop hl;								// 
	ret z;								// 
	jp (hl)

	org $1fc9
lprint:
	ld a, 3;								// 
	jr print_1

	org $1fcd
c_print:
	ld a, 2

	org $1fcf
print_1:
	call syntax_z;								// 
	call nz, chan_open;								// 
	call temps;								// 
	call print_2;								// 
	call check_end;								// 
	ret

	org $1fdf
print_2:
	rst get_char;								// 
	call pr_end_z;								// 
	jr z, print_4

	org $1fe5
print_3:
	call pr_posn_1   ;								// 
	jr z, print_3;								// 
	call pr_item_1;								// 
	call pr_posn_1;								// 
	jr z, print_3

	org $1ff2
print_4:
	cp 41;')';;								// 
	ret z

	org $1ff5
print_cr:
	call unstack_z;								// 
	ld a, ctrl_enter;								// 
	rst print_a;								// 
	ret

	org $1ffc
pr_item_1:
	rst get_char;								// 
	cp tk_at;								// 
	jr nz, pr_item_2;								// 
	call next_2num;								// 
	call unstack_z;								// 
	call stk_to_bc;								// 
	ld a, ctrl_at;								// 
	jr pr_at_tab

	org $200e
pr_item_2:
	cp tk_tab;								// 
	jr nz, pr_item_3;								// 
	rst next_char;								// 
	call expt_1num;								// 
	call unstack_z;								// 
	call find_int2;								// 
	ld a, ctrl_tab

	org $201e
pr_at_tab:
	rst print_a;								// 
	ld a, c;								// 
	rst print_a;								// 
	ld a, b;								// 
	rst print_a;								// 
	ret

	org $2024
pr_item_3:
	call co_temp_3;								// 
	ret nc;								// 
	call str_alter;								// 
	ret nc;								// 
	call scanning;								// 
	call unstack_z;								// 
	bit 6, (iy + _flags);								// 
	call z, stk_fetch;								// 
	jp nz, print_fp

	org $203c
pr_string:
	ld a, b;								// 
	or c;								// 
	dec bc;								// 
	ret z;								// 
	ld a, (de);								// 
	inc de;								// 
	rst print_a;								// 
	jr pr_string

	org $2045
pr_end_z:
	cp 41;')';;								// 
	ret z

	org $2048
pr_st_end:
	cp ctrl_enter;								// 
	ret z;								// 
	cp 58;':';;								// 
	ret

	org $204e
pr_posn_1:
	rst get_char;								// 
	cp 59;':';;								// 
	jr z, pr_posn_3;								// 
	cp 44;',';								// 
	jr nz, pr_posn_2;								// 
	call syntax_z;								// 
	jr z, pr_posn_3;								// 
	ld a, ctrl_comma;								// 
	rst print_a;								// 
	jr pr_posn_3

	org $2061
pr_posn_2:
	cp 39;"'";								// 
	ret nz;								// 
	call print_cr

	org $2067
pr_posn_3:
	rst next_char;								// 
	call pr_end_z;								// 
	jr nz, pr_posn_4;								// 
	pop bc

	org $206e
pr_posn_4:
	cp a;								// 
	ret

	org $2070
str_alter:
	cp 35;'#';								// 
	scf;								// 
	ret nz;								// 
	rst next_char;								// 
	call expt_1num;								// 
	and a;								// 
	call unstack_z;								// 
	call find_int1;								// 
	cp 16;								// 
	jp nc, report_oa;								// 
	call chan_open;								// 
	and a;								// 
	ret

	org $2089
input:
	call syntax_z;								// 
	jr z, input_1;								// 
	ld a, 1;								// 
	call chan_open;								// 
	call cls_lower

	org $2096
input_1:
	ld (iy + _vdu_flag), $01;								// 
	call in_item_1;								// 
	call check_end;								// 
	ld bc, (s_posn);								// 
	ld a, (df_sz);								// 
	cp b;								// 
	jr c, input_2;								// 
	ld c, 33;								// 
	ld b, a

	org $20ad
input_2:
	ld (s_posn), bc;								// 
	ld a, 25;								// 
	sub b;								// 
	ld (scr_ct), a;								// 
	res 0, (iy + _vdu_flag);								// 
	call cl_set;								// 
	jp cls_lower

	org $20c1
in_item_1:
	call pr_posn_1;								// 
	jr z, in_item_1;								// 
	cp 40;'(';;								// 
	jr nz, in_item_2;								// 
	rst next_char;								// 
	call print_2;								// 
	rst get_char;								// 
	cp 41;')';;								// 
	jp nz, report_c;								// 
	rst next_char;								// 
	jp in_next_2

	org $20d8
in_item_2:
	cp tk_line;								// 
	jr nz, in_item_3;								// 
	rst next_char;								// 
	call class_01;								// 
	set 7, (iy + _flagx);								// 
	bit 6, (iy + _flags);								// 
	jp nz, report_c;								// 
	jr in_prompt

	org $20ed
in_item_3:
	call alpha;								// 
	jp nc, in_next_1;								// 
	call class_01;								// 
	res 7, (iy + _flagx)

	org $20fa
in_prompt:
	call syntax_z;								// 
	jp z, in_next_2;								// 
	call set_work;								// 
	ld hl, flagx;								// 
	res 6, (hl);								// 
	set 5, (hl);								// 
	ld bc, $0001;								// 
	bit 7, (hl) ;flagx;								// 
	jr nz, in_pr_2;								// 
	ld a, (flags);								// 
	and %01000000;								// 
	jr nz, in_pr_1;								// 
	ld c, 3

	org $211a
in_pr_1:
	or (hl);								// 
	ld (hl), a

	org $211c
in_pr_2:
	rst bc_spaces;								// 
	ld (hl), ctrl_enter;								// 
	ld a, c;								// 
	rrca;								// 
	rrca;								// 
	jr nc, in_pr_3;								// 
	ld a, 34;'"';";"								// 
	ld (de), a;								// 
	dec hl;								// 
	ld (hl), a

	org $2129
in_pr_3:
	ld (k_cur), hl;								// 
	bit 7, (iy + _flagx);								// 
	jr nz, in_var_3;								// 
	ld hl, (ch_add);								// 
	push hl;								// 
	ld hl, (err_sp);								// 
	push hl

	org $213a
in_var_1:
	ld hl, in_var_1;								// 
	push hl;								// 
	bit 4, (iy + _flags2);								// 
	jr z, in_var_2;								// 
	ld (err_sp), sp

	org $2148
in_var_2:
	ld hl, (worksp);								// 
	call remove_fp;								// 
	ld (iy + _err_nr), 255;								// 
	call editor;								// 
	res 7, (iy + _flags);								// 
	call in_assign;								// 
	jr in_var_4

	org $215e
in_var_3:
	call editor

	org $2161
in_var_4:
	ld (iy + _k_cur_h), 0;								// 
	call in_chan_k;								// 
	jr nz, in_var_5;								// 
	call ed_copy;								// 
	ld bc, (echo_e);								// 
	call cl_set

	org $2174
in_var_5:
	ld hl, flagx;								// 
	res 5, (hl);								// 
	bit 7, (hl);								// 
	res 7, (hl);								// 
	jr nz, in_var_6;								// 
	pop hl;								// 
	pop hl;								// 
	ld (err_sp), hl;								// 
	pop hl;								// 
	ld (x_ptr), hl;								// 
	set 7, (iy + _flags);								// 
	call in_assign;								// 
	ld hl, (x_ptr);								// 
	ld (iy + _x_ptr_h), 0;								// 
	ld (ch_add), hl;								// 
	jr in_next_2

	org $219b
in_var_6:
	ld hl, (stkbot);								// 
	ld de, (worksp);								// 
	scf;								// 
	sbc hl, de;								// 
	ld b, h;								// 
	ld c, l;								// 
	call stk_sto_str;								// 
	call c_let;								// 
	jr in_next_2

	org $21af
in_next_1:
	call pr_item_1

	org $21b2
in_next_2:
	call pr_posn_1;								// 
	jp z, in_item_1;								// 
	ret

	org $21b9
in_assign:
	ld hl, (worksp);								// 
	ld (ch_add), hl;								// 
	rst get_char;								// 
	cp tk_stop;								// 
	jr z, in_stop;								// 
	ld a, (flagx);								// 
	call val_fet_2;								// 
	rst get_char;								// 
	cp ctrl_enter;								// 
	ret z

	org $21ce
report_cb:
	rst error;								// 
	defb nonsense_in_basic

	org $21d0
in_stop:
	call syntax_z;								// 
	ret z

	org $21d4
report_h:
	rst error;								// 
	defb stop_in_input

	org $21d6
in_chan_k:
	ld hl, (curchl);								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	inc hl;								// 
	ld a, (hl);								// 
	cp 75;'K';								// 
	ret

	org $21e1
co_temp_1:
	rst next_char

	org $21e2
co_temp_2:
	call co_temp_3;								// 
	ret c;								// 
	rst get_char;								// 
	cp 44;',';								// 
	jr z, co_temp_1;								// 
	cp 59;':';;								// 
	jr z, co_temp_1;								// 
	jp report_c

	org $21f2
co_temp_3:
	cp tk_ink;								// 
	ret c;								// 
	cp tk_out;								// 
	ccf;								// 
	ret c;								// 
	push af;								// 
	rst next_char;								// 
	pop af

	org $21fc
co_temp_4:
	sub 201;								// 
	push af;								// 
	call expt_1num;								// 
	pop af;								// 
	and a;								// 
	call unstack_z;								// 
	push af;								// 
	call find_int1;								// 
	ld d, a;								// 
	pop af;								// 
	rst print_a;								// 
	ld a, d;								// 
	rst print_a;								// 
	ret

	org $2211
co_temp_5:
	sub 17;								// 
	adc a, 0;								// 
	jr z, co_temp_7;								// 
	sub 2;								// 
	adc a, 0;								// 
	jr z, co_temp_c;								// 
	cp 1;								// 
	ld a, d;								// 
	ld b, 1;								// 
	jr nz, co_temp_6;								// 
	rlca;								// 
	rlca;								// 
	ld b, 4

	org $2228
co_temp_6:
	ld c, a;								// 
	ld a, d;								// 
	cp 2;								// 
	jr nc, report_k;								// 
	ld a, c;								// 
	ld hl, p_flag;								// 
	jr co_change

	org $2234
co_temp_7:
	ld a, d;								// 
	ld b, %00000111;								// 
	jr c, co_temp_8;								// 
	rlca;								// 
	rlca;								// 
	rlca;								// 
	ld b, %00111000

	org $223e
co_temp_8:
	ld c, a;								// 
	ld a, d;								// 
	cp 10;								// 
	jr c, co_temp_9

	org $2244
report_k:
	rst error;								// 
	defb invalid_colour

	org $2246
co_temp_9:
	ld hl, attr_t;								// 
	cp 8;								// 
	jr c, co_temp_b;								// 
	ld a, (hl);								// 
	jr z, co_temp_a;								// 
	or b;								// 
	cpl;								// 
	and %00100100;								// 
	jr z, co_temp_a;								// 
	ld a, b

	org $2257
co_temp_a:
	ld c, a

	org $2258
co_temp_b:
	ld a, c;								// 
	call co_change;								// 
	ld a, 7;								// 
	cp d;								// 
	sbc a, a;								// 
	call co_change;								// 
	rlca;								// 
	rlca;								// 
	and %01010000;								// 
	ld b, a;								// 
	ld a, 8;								// 
	cp d;								// 
	sbc a, a

	org $226c
co_change:
	xor (hl);								// 
	and b;								// 
	xor (hl);								// 
	ld (hl), a;								// 
	inc hl;								// 
	ld a, b;								// 
	ret

	org $2273
co_temp_c:
	sbc a, a;								// 
	ld a, d;								// 
	rrca;								// 
	ld b, %10000000;								// 
	jr nz, co_temp_d;								// 
	rrca;								// 
	ld b, %01000000

	org $227d
co_temp_d:
	ld c, a;								// 
	ld a, d;								// 
	cp 8;								// 
	jr z, co_temp_e;								// 
	cp 2;								// 
	jr nc, report_k

	org $2287
co_temp_e:
	ld a, c;								// 
	ld hl, attr_t;								// 
	call co_change;								// 
	ld a, c;								// 
	rrca;								// 
	rrca;								// 
	rrca;								// 
	jr co_change

	org $2294
border:
	call find_int1;								// 
	cp 8;								// 
	jr nc, report_k;								// 
	out (ula), a;								// 
	rlca;								// 
	rlca;								// 
	rlca;								// 
	bit 5, a;								// 
	jr nz, border_1;								// 
	xor %00000111

	org $22a6
border_1:
	ld (bordcr), a;								// 
	ret

	org $22aa
pixel_add:
	ld a, 175;								// 
	sub b;								// 
	jp c, report_bc;								// 
	ld b, a;								// 
	and a;								// 
	rra;								// 
	scf;								// 
	rra;								// 
	and a;								// 
	rra;								// 
	xor b;								// 
	and %11111000;								// 
	xor b;								// 
	ld h, a;								// 
	ld a, c;								// 
	rlca;								// 
	rlca;								// 
	rlca;								// 
	xor b;								// 
	and %11000111;								// 
	xor b;								// 
	rlca;								// 
	rlca;								// 
	ld l, a;								// 
	ld a, c;								// 
	and %00000111;								// 
	ret

	org $22cb
point_sub:
	call stk_to_bc;								// 
	call pixel_add;								// 
	ld b, a;								// 
	inc b;								// 
	ld a, (hl)

	org $22d4
point_lp:
	rlca;								// 
	djnz point_lp;								// 
	and %00000001;								// 
	jp stack_a

	org $22dc
plot:
	call stk_to_bc;								// 
	call plot_sub;								// 
	jp temps

	org $22e5
plot_sub:
	ld (coords), bc;								// 
	call pixel_add;								// 
	ld b, a;								// 
	inc b;								// 
	ld a, %11111110

	org $22f0
plot_loop:
	rrca;								// 
	djnz plot_loop;								// 
	ld b, a;								// 
	ld a, (hl);								// 
	ld c, (iy + _p_flag);								// 
	bit 0, c;								// 
	jr nz, pl_tst_in;								// 
	and b

	org $22fd
pl_tst_in:
	bit 2, c;								// 
	jr nz, plot_end;								// 
	xor b;								// 
	cpl

	org $2303
plot_end:
	ld (hl), a;								// 
	jp po_attr

	org $2307
stk_to_bc:
	call stk_to_a;								// 
	ld b, a;								// 
	push bc;								// 
	call stk_to_a;								// 
	ld e, c;								// 
	pop bc;								// 
	ld d, c;								// 
	ld c, a;								// 
	ret

	org $2314
stk_to_a:
	call fp_to_a;								// 
	jp c, report_bc;								// 
	ld c, 1;								// 
	ret z;								// 
	ld c, 255;								// 
	ret

	org $2320
circle:
	rst get_char;								// 
	cp 44;',';								// 
	jp nz, report_c;								// 
	rst next_char;								// 
	call expt_1num;								// 
	call check_end;								// 
	fwait;								// 
	fabs;								// 
	frstk;								// 
	fce;								// 
	ld a, (hl);								// 
	cp 129;								// 
	jr nc, c_r_gre_1;								// 
	fwait;								// 
	fdel;								// 
	fce;								// 
	jr plot

	org $233b
c_r_gre_1:
	fwait;								// 
	fstkpix.5;								// 
	fce;								// 
	ld (hl), 131;								// 
	fwait;								// 
	fst 5;								// 
	fdel;								// 
	fce;								// 
	call cd_prms1;								// 
	push bc;								// 
	fwait;								// 
	fmove;								// 
	fgt 1;								// 
	fmul;								// 
	fce;								// 
	ld a, (hl);								// 
	cp 128;								// 
	jr nc, c_arc_ge1;								// 
	fwait;								// 
	fdel;								// 
	fdel;								// 
	fce;								// 
	pop bc;								// 
	jp plot

	org $235a
c_arc_ge1:
	fwait;								// 
	fst 2;								// 
	fxch;								// 
	fst 0;								// 
	fdel;								// 
	fsub;								// 
	fxch;								// 
	fgt 0;								// 
	fadd;								// 
	fst 0;								// 
	fxch;								// 
	fmove;								// 
	fgt 0;								// 
	fxch;								// 
	fmove;								// 
	fgt 0;								// 
	fstk0;								// 
	fst 1;								// 
	fdel;								// 
	fce;								// 
	inc (iy + _mem_2);								// 
	call find_int1;								// 
	ld l, a;								// 
	push hl;								// 
	call find_int1;								// 
	pop hl;								// 
	ld h, a;								// 
	ld (coords), hl;								// 
	pop bc;								// 
	jp drw_steps

	org $2382
draw:
	rst get_char;								// 
	cp 44;',';								// 
	jr z, dr_3_prms;								// 
	call check_end;								// 
	jp line_draw

	org $238d
dr_3_prms:
	rst next_char;								// 
	call expt_1num;								// 
	call check_end;								// 
	fwait;								// 
	fst 5;								// 
	fstk.5;								// 
	fmul;								// 
	fsin;								// 
	fmove;								// 
	fnot;								// 
	fnot;								// 
	fjpt dr_sin_nz;								// 
	fdel;								// 
	fce;								// 
	jp line_draw

	org $23a3
dr_sin_nz:
	fst 0;								// 
	fdel;								// 
	fst 1;								// 
	fdel;								// 
	fmove;								// 
	fabs;								// 
	fgt 1;								// 
	fxch;								// 
	fgt 1;								// 
	fabs;								// 
	fadd;								// 
	fgt 0;								// 
	fdiv;								// 
	fabs;								// 
	fgt 0;								// 
	fxch;								// 
	frstk;								// 
	fce;								// 
	ld a, (hl);								// 
	cp 129;								// 
	jr nc, dr_prms;								// 
	fwait;								// 
	fdel;								// 
	fdel;								// 
	fce;								// 
	jp line_draw

	org $23c1
dr_prms:
	call cd_prms1;								// 
	push bc;								// 
	fwait;								// 
	fdel;								// 
	fgt 1;								// 
	fxch;								// 
	fdiv;								// 
	fst 1;								// 
	fdel;								// 
	fxch;								// 
	fmove;								// 
	fgt 1;								// 
	fmul;								// 
	fst 2;								// 
	fdel;								// 
	fxch;								// 
	fmove;								// 
	fgt 1;								// 
	fmul;								// 
	fgt 2;								// 
	fgt 5;								// 
	fgt 0;								// 
	fsub;								// 
	fstk.5;								// 
	fmul;								// 
	fmove;								// 
	fsin;								// 
	fst 5;								// 
	fdel;								// 
	fcos;								// 
	fst 0;								// 
	fdel;								// 
	fst 2;								// 
	fdel;								// 
	fst 1;								// 
	fgt 5;								// 
	fmul;								// 
	fgt 0;								// 
	fgt 2;								// 
	fmul;								// 
	fadd;								// 
	fgt 1;								// 
	fxch;								// 
	fst 1;								// 
	fdel;								// 
	fgt 0;								// 
	fmul;								// 
	fgt 2;								// 
	fgt 5;								// 
	fmul;								// 
	fsub;								// 
	fst 2;								// 
	fabs;								// 
	fgt 1;								// 
	fabs;								// 
	fadd;								// 
	fdel;								// 
	fce;								// 
	ld a, (de);								// 
	cp 129;								// 
	pop bc;								// 
	jp c, line_draw;								// 
	push bc;								// 
	fwait;								// 
	fxch;								// 
	fce;								// 
	ld a, (coords);								// 
	call stack_a;								// 
	fwait;								// 
	fst 0;								// 
	fadd;								// 
	fxch;								// 
	fce;								// 
	ld a, (coord_y);								// 
	call stack_a;								// 
	fwait;								// 
	fst 5;								// 
	fadd;								// 
	fgt 0;								// 
	fgt 5;								// 
	fce;								// 
	pop bc

	org $2420
drw_steps:
	dec b;								// 
	jr z, arc_end;								// 
	jr arc_start

	org $2425
arc_loop:
	fwait;								// 
	fgt 1;								// 
	fmove;								// 
	fgt 3;								// 
	fmul;								// 
	fgt 2;								// 
	fgt 4;								// 
	fmul;								// 
	fsub;								// 
	fst 1;								// 
	fdel;								// 
	fgt 4;								// 
	fmul;								// 
	fgt 2;								// 
	fgt 3;								// 
	fmul;								// 
	fadd;								// 
	fst 2;								// 
	fdel;								// 
	fce

	org $2439
arc_start:
	push bc;								// 
	fwait;								// 
	fst 0;								// 
	fdel;								// 
	fgt 1;								// 
	fadd;								// 
	fmove;								// 
	fce;								// 
	ld a, (coords);								// 
	call stack_a;								// 
	fwait;								// 
	fsub;								// 
	fgt 0;								// 
	fgt 2;								// 
	fadd;								// 
	fst 0;								// 
	fxch;								// 
	fgt 0;								// 
	fce;								// 
	ld a, (coord_y);								// 
	call stack_a;								// 
	fwait;								// 
	fsub;								// 
	fce;								// 
	call draw_line;								// 
	pop bc;								// 
	djnz arc_loop

	org $245f
arc_end:
	fwait;								// 
	fdel;								// 
	fdel;								// 
	fxch;								// 
	fce;								// 
	ld a, (coords);								// 
	call stack_a;								// 
	fwait;								// 
	fsub;								// 
	fxch;								// 
	fce;								// 
	ld a, (coord_y);								// 
	call stack_a;								// 
	fwait;								// 
	fsub;								// 
	fce

	org $2477
line_draw:
	call draw_line;								// 
	jp temps

	org $247d
cd_prms1:
	fwait;								// 
	fmove;								// 
	fsqrt;								// 
	fstk;								// 
	defb $32, $00;								// 
	fxch;								// 
	fdiv;								// 
	fgt 5;								// 
	fxch;								// 
	fdiv;								// 
	fabs;								// 
	fce;								// 
	call fp_to_a;								// 
	jr c, use_252;								// 
	and 252;								// 
	add a, 4;								// 
	jr nc, draw_save

	org $2495
use_252:
	ld a, 252

	org $2497
draw_save:
	push af;								// 
	call stack_a;								// 
	fwait;								// 
	fgt 5;								// 
	fxch;								// 
	fdiv;								// 
	fmove;								// 
	fsin;								// 
	fst 4;								// 
	fdel;								// 
	fmove;								// 
	fstk.5;								// 
	fmul;								// 
	fsin;								// 
	fst 1;								// 
	fxch;								// 
	fst 0;								// 
	fdel;								// 
	fmove;								// 
	fmul;								// 
	fmove;								// 
	fadd;								// 
	fstk1;								// 
	fsub;								// 
	fneg;								// 
	fst 3;								// 
	fdel;								// 
	fce;								// 
	pop bc;								// 
	ret

	org $24b7
draw_line:
	call stk_to_bc;								// 
	ld a, c;								// 
	cp b;								// 
	jr nc, dl_x_ge_y;								// 
	ld l, c;								// 
	push de;								// 
	xor a;								// 
	ld e, a;								// 
	jr dl_larger

	org $24c4
dl_x_ge_y:
	or c;								// 
	ret z;								// 
	ld l, b;								// 
	ld b, c;								// 
	push de;								// 
	ld d, 0

	org $24cb
dl_larger:
	ld h, b;								// 
	ld a, b;								// 
	rra 

	org $24ce
d_l_loop:
	add a, l;								// 
	jr c, d_l_diag;								// 
	cp h;								// 
	jr c, d_l_hr_vt

	org $24d4
d_l_diag:
	sub h;								// 
	ld c, a;								// 
	exx;								// 
	pop bc;								// 
	push bc;								// 
	jr d_l_step

	org $24db
d_l_hr_vt:
	ld c, a;								// 
	push de;								// 
	exx;								// 
	pop bc

	org $24df
d_l_step:
	ld hl, (coords);								// 
	ld a, b;								// 
	add a, h;								// 
	ld b, a;								// 
	ld a, c;								// 
	inc a;								// 
	add a, l;								// 
	jr c, d_l_range;								// 
	jr z, report_bc

	org $24ec
d_l_plot:
	dec a;								// 
	ld c, a;								// 
	call plot_sub;								// 
	exx;								// 
	ld a, c;								// 
	djnz d_l_loop;								// 
	pop de;								// 
	ret

	org $24f7
d_l_range:
	jr z, d_l_plot

	org $24f9
report_bc:
	rst error;								// 
	defb integer_out_of_range
