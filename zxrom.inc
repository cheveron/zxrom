;	// Definitions file for zxrom.asm
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// X80 maths co-processor instruction set (requires macro support)

;	// never called directly:
;	//
;	// ftop
;	// fbor
;	// fband
;	// fbands
;	// fcps (6 opcodes)
;	// fvals
;	// fusrs
;	// fread
;	// fasc
;	// fval
;	// flen
;	// ftan
;	// facos
;	// fexp
;	// fsgn
;	// fpeek
;	// fin
;	// fusr
;	// fstrs
;	// fchrs
;	// fetof

;	// parameter definitions
;	// (period used to distinguish from assembler commands)

le	equ	0;								// less than or equal
ge	equ	1;								// greater or equal
ne	equ	2;								// not equal
gt	equ	3;								// greater than
lt	equ	4;								// less than
eq	equ	5;								// equal
lz	equ	$2d;							// less than zero
gz	equ	$2e;							// greater than zero

; instruction macros

MACRO fwait; stop the Z80
	rst	28h
ENDM

MACRO fjpt n; jump if true
	defb $00, {n} - $ - 1
ENDM

MACRO fxch; exchange
	defb $01
ENDM

MACRO fdel; delete
	defb $02
ENDM

MACRO fsub; subtract
	defb $03
ENDM

MACRO fmul; multiply
	defb $04
ENDM

MACRO fdiv; divide
	defb $05
ENDM

MACRO ftop; to power
	defb $06
ENDM

MACRO fbor; binary or
	defb $07
ENDM

MACRO fband; binary and
	defb $08
ENDM

MACRO fcp n; compare (le ... gtz)
	defb $09 + {n}
ENDM

MACRO fadd; add
	defb $0f
ENDM

MACRO fbands; binary and string
	defb $10
ENDM

MACRO fcps n; compare string (le to eq)
	defb $11 + {n}
ENDM

MACRO fcat; concatenate string
	defb $17
ENDM

MACRO fvals; value string
	defb $18
ENDM

MACRO fusrs; user string
	defb $19
ENDM

MACRO fread; read in
	defb $1a
ENDM

MACRO fneg; negate
	defb $1b
ENDM

MACRO fasc; character to ASCII
	defb $1c
ENDM

MACRO fval; value
	defb $1d
ENDM

MACRO flen; length of string
	defb $1e
ENDM

MACRO fsin; sine
	defb $1f
ENDM

MACRO fcos; cosine
	defb $20
ENDM

MACRO ftan; tangent
	defb $21
ENDM

MACRO fasin; arcsine
	defb $22
ENDM

MACRO facos; arccosine
	defb $23
ENDM

MACRO fatan; arctangent
	defb $24
ENDM

MACRO flogn; natural logarithm
	defb $25
ENDM

MACRO fexp; exponential
	defb $26
ENDM

MACRO fint; integer (rounded down)
	defb $27
ENDM

MACRO fsqrt; square root
	defb $28
ENDM

MACRO fsgn; signum
	defb $29
ENDM

MACRO fabs; absolute value
	defb $2a
ENDM

MACRO fpeek; PEEK
	defb $2b
ENDM

MACRO fin; IN
	defb $2c
ENDM

MACRO fusr; user address
	defb $2d
ENDM

MACRO fstrs; string
	defb $2e
ENDM

MACRO fchrs; character
	defb $2f
ENDM

MACRO fnot; not
	defb $30
ENDM

MACRO fmove; move
	defb $31
ENDM

MACRO fmod; modulus
	defb $32
ENDM

MACRO fjp n; jump
	defb $33, {n} - $ - 1
ENDM

MACRO fstk; stack data
	defb $34
ENDM

MACRO fdjnz n; djnz
	defb $35, {n} - $ - 1
ENDM

MACRO fce; chip enable
	defb $38
ENDM

MACRO fget; get
	defb $39
ENDM

MACRO ftrn; truncate
	defb $3a
ENDM

MACRO fsgl; single operation
	defb $3b
ENDM

MACRO fetof; e to floating-point
	defb $3c
ENDM

MACRO frstk; restack
	defb $3d
ENDM

MACRO fstk0; stack 0
	defb $a0
ENDM

MACRO fstk1; stack 1
	defb $a1
ENDM

MACRO fstk.5; stack half
	defb $a2
ENDM

MACRO fstkpix.5	; stack pi/2
	defb $a3
ENDM

MACRO fstk10; stack 10
	defb $a4
ENDM

MACRO fst n; store (mem 0-5)
	defb $c0 + {n}
ENDM

MACRO fgt n; get (mem 0-5)
	defb $e0 + {n}
ENDM


;	// colors

black			equ	$00
blue			equ	$01
red				equ	$02
magenta			equ	$03
green			equ	$04
cyan			equ	$05
yellow			equ	$06
white			equ	$07


;	// control characters

ctrl_true_vid	equ	$04
ctrl_inv_vid	equ	$05
ctrl_caps		equ	$06
ctrl_comma		equ	$06
ctrl_edit		equ	$07
ctrl_left		equ	$08
ctrl_right		equ	$09
ctrl_down		equ	$0a
ctrl_up			equ	$0b
ctrl_delete		equ	$0c
ctrl_enter		equ	$0d
ctrl_symbol		equ	$0e
ctrl_number		equ	$0e
ctrl_graphics	equ	$0f
ctrl_ink		equ	$10
ctrl_paper		equ	$11
ctrl_flash		equ	$12
ctrl_bright		equ	$13
ctrl_inverse	equ	$14
ctrl_over		equ	$15
ctrl_at			equ	$16
ctrl_tab		equ	$17


;	// printable characters

pchr_pound		equ	'`'
pchr_copyright	equ	$7f


;	// tokens

tk_rnd			equ	$a5
tk_inkey_str	equ	$a6
tk_pi			equ	$a7
tk_fn			equ	$a8
tk_point		equ	$a9
tk_screen_str	equ	$aa
tk_attr			equ	$ab
tk_at			equ	$ac
tk_tab			equ	$ad
tk_val_str		equ	$ae
tk_code			equ	$af
tk_val			equ	$b0
tk_len			equ	$b1
tk_sin			equ	$b2
tk_cos			equ	$b3
tk_tan			equ	$b4
tk_asn			equ	$b5
tk_acs			equ	$b6
tk_atn			equ	$b7
tk_ln			equ	$b8
tk_exp			equ	$b9
tk_int			equ	$ba
tk_sqr			equ	$bb
tk_sgn			equ	$bc
tk_abs			equ	$bd
tk_peek			equ	$be
tk_in			equ	$bf
tk_usr			equ	$c0
tk_str_str		equ	$c1
tk_chr_str		equ	$c2
tk_not			equ	$c3
tk_bin			equ	$c4
tk_or			equ	$c5
tk_and			equ	$c6
tk_l_eql		equ	$c7
tk_gr_eq		equ	$c8
tk_neql			equ	$c9
tk_line			equ	$ca
tk_then			equ	$cb
tk_to			equ	$cc
tk_step			equ	$cd
tk_def_fn		equ	$ce
tk_cat			equ	$cf
tk_format		equ	$d0
tk_move			equ	$d1
tk_erase		equ	$d2
tk_open			equ	$d3
tk_close		equ	$d4
tk_merge		equ	$d5
tk_verify		equ	$d6
tk_beep			equ	$d7
tk_circle		equ	$d8
tk_ink			equ	$d9
tk_paper		equ	$da
tk_flash		equ	$db
tk_bright		equ	$dc
tk_inverse		equ	$dd
tk_over			equ	$de
tk_out			equ	$df
tk_lprint		equ	$e0
tk_llist		equ	$e1
tk_stop			equ	$e2
tk_read			equ	$e3
tk_data			equ	$e4
tk_restore		equ	$e5
tk_new			equ	$e6
tk_border		equ	$e7
tk_continue		equ	$e8
tk_dim			equ	$e9
tk_rem			equ	$ea
tk_for			equ	$eb
tk_go_to		equ	$ec
tk_go_sub		equ	$ed
tk_input		equ	$ee
tk_load			equ	$ef
tk_list			equ	$f0
tk_let			equ	$f1
tk_pause		equ	$f2
tk_next			equ	$f3
tk_poke			equ	$f4
tk_print		equ	$f5
tk_plot			equ	$f6
tk_run			equ	$f7
tk_save			equ	$f8
tk_randomize	equ	$f9
tk_if			equ	$fa
tk_cls			equ	$fb
tk_draw			equ	$fc
tk_clear		equ	$fd
tk_return		equ	$fe
tk_copy			equ	$ff


;	// i/o ports

printer			equ	$fb
ula				equ	$fe


;	// restarts

start			equ	$00
error			equ	$08
print_a			equ	$10
get_char		equ	$18
next_char		equ	$20
;calc			equ	$28
bc_spaces		equ	$30
mask_int		equ	$38


;	// command classes

no_f_ops		equ	$00
var_rqd			equ	$01
expr_num_str	equ	$02
num_exp_0		equ	$03
chr_var			equ	$04
var_syn			equ	$05
num_exp			equ	$06
col_offst		equ	$07
two_c_s_num		equ	$08
two_csn_col		equ	$09
str_exp			equ	$0a
tap_offst		equ	$0b


;	// errors

ok						equ	$ff
next_without_for		equ	$00
variable_not_found		equ	$01
subscript_wrong			equ	$02
out_of_memory			equ	$03
out_of_screen			equ	$04
number_too_big			equ	$05
return_without_gosub	equ	$06
end_of_file				equ	$07
stop_statement			equ	$08
invalid_argument		equ	$09
integer_out_of_range	equ	$0a
nonsense_in_basic		equ	$0b
break_cont_repeats		equ	$0c
out_of_data				equ	$0d
invalid_file_name		equ	$0e
no_room_for_line		equ	$0f
stop_in_input			equ	$10
for_without_next		equ	$11
invalid_io_device		equ	$12
invalid_colour			equ	$13
break_into_program		equ	$14
ramtop_no_good			equ	$15
statement_lost			equ	$16
invalid_stream			equ	$17
fn_without_def			equ	$18
parameter_error			equ	$19
tape_loading_error		equ	$1a

;	// system variables
bitmap		equ	$4000;						// 
attrmap		equ	$5800;						// 
prt_buff	equ	$5b00;						// 
kstate		equ	$5c00;						// (iy - $3a)
kstate_4	equ	kstate + 4;					// (iy - $36)
last_k		equ	kstate + 8;					// (iy - $32)
repdel		equ	last_k + 1;					// (iy - $31)
repper		equ	repdel + 1;					// (iy - $30)
defadd		equ	repper + 1;					// (iy - $2f)
defadd_h	equ	defadd + 1;					// (iy - $2e)
k_data		equ	defadd + 2;					// (iy - $2d)
vdu_data	equ	k_data + 1;					// (iy - $2c)
vdu_data_h	equ	vdu_data + 1;				// (iy - $2b)
strms		equ	vdu_data + 2;				// (iy - $2a)
strms_fe	equ	strms + 2;					// (iy - $28)
strms_ff	equ	strms + 4;					// (iy - $26)
strms_00	equ	strms + 6;					// (iy - $24)
strms_01	equ	strms + 8;					// (iy - $22)
strms_02	equ	strms + 10;					// (iy - $20)
strms_03	equ	strms + 12;					// (iy - $1e)
strms_04	equ	strms + 14;					// (iy - $1c)
strms_05	equ	strms + 16;					// (iy - $1a)
strms_06	equ	strms + 18;					// (iy - $18)
strms_07	equ	strms + 20;					// (iy - $16)
strms_08	equ	strms + 22;					// (iy - $14)
strms_09	equ	strms + 24;					// (iy - $12)
strms_10	equ	strms + 26;					// (iy - $10)
strms_11	equ	strms + 28;					// (iy - $0e)
strms_12	equ	strms + 30;					// (iy - $0c)
strms_13	equ	strms + 32;					// (iy - $0a)
strms_14	equ	strms + 34;					// (iy - $08)
strms_15	equ	strms + 36;					// (iy - $06)
chars		equ	strms + 38;					// (iy - $04)
rasp		equ	chars + 2;					// (iy - $02)
pip			equ	rasp + 1;					// (iy - $01)
err_nr		equ	pip + 1	;					// (iy + $00)
flags		equ	err_nr + 1;					// (iy + $01)
vdu_flag	equ	flags + 1;					// (iy + $02)
err_sp		equ	vdu_flag + 1;				// (iy + $03)
list_sp		equ	err_sp + 2;					// (iy + $05)
mode		equ	list_sp + 2;				// (iy + $07)
newppc		equ	mode + 1;					// (iy + $08)
nsppc		equ	newppc + 2;					// (iy + $0a)
ppc			equ	nsppc + 1;					// (iy + $0b)
subppc		equ	ppc + 2	;					// (iy + $0d)
bordcr		equ	subppc + 1;					// (iy + $0e)
e_ppc		equ	bordcr + 1;					// (iy + $0f)
e_ppc_h		equ	e_ppc + 1;					// (iy + $10)
vars		equ	e_ppc + 2;					// (iy + $11)
dest		equ	vars + 2;					// (iy + $13)
chans		equ	dest + 2;					// (iy + $15)
curchl		equ	chans + 2;					// (iy + $17)
prog		equ	curchl + 2;					// (iy + $19)
nxtlin		equ	prog + 2;					// (iy + $1b)
datadd		equ	nxtlin + 2;					// (iy + $1d)
e_line		equ	datadd + 2;					// (iy + $1f)
k_cur		equ	e_line	+2;					// (iy + $21)
ch_add		equ	k_cur + 2;					// (iy + $23)
x_ptr		equ	ch_add + 2;					// (iy + $25)
worksp		equ	x_ptr + 2;					// (iy + $27)
stkbot		equ	worksp + 2;					// (iy + $29)
stkend		equ	stkbot + 2;					// (iy + $2b)
stkend_h	equ	stkend + 1;					// (iy + $2c)
breg		equ	stkend + 2;					// (iy + $2d)
mem			equ	breg + 1;					// (iy + $2e)
flags2		equ	mem + 2	;					// (iy + $30)
df_sz		equ	flags2 + 1;					// (iy + $31)
s_top		equ	df_sz + 1;					// (iy + $32)
oldppc		equ	s_top + 2;					// (iy + $34)
osppc		equ	oldppc + 2;					// (iy + $36)
flagx		equ	osppc + 1;					// (iy + $37)
strlen		equ	flagx + 1;					// (iy + $38)
t_addr		equ	strlen + 2;					// (iy + $3a)
seed		equ	t_addr + 2;					// (iy + $3c)
frames		equ	seed + 2;					// (iy + $3e)
frames_h	equ	frames + 2;					// (iy + $40)
udg			equ	frames + 3;					// (iy + $41)
coords		equ	udg + 2	;					// (iy + $43)
coord_y		equ	coords + 1;					// (iy + $44)
p_posn		equ	coords + 2;					// (iy + $45)
pr_cc		equ	p_posn + 1;					// (iy + $46)
echo_e		equ	pr_cc + 2;					// (iy + $48)
df_cc		equ	echo_e + 2;					// (iy + $4a)
df_ccl		equ	df_cc + 2;					// (iy + $4c)
s_posn		equ	df_ccl + 2;					// (iy + $4e)
s_posn_h	equ	s_posn + 1;					// (iy + $4f)
sposnl		equ	s_posn + 2;					// (iy + $50)
sposnl_h	equ	sposnl + 1;					// (iy + $51)
scr_ct		equ	sposnl + 2;					// (iy + $52)
attr_p		equ	scr_ct + 1;					// (iy + $53)
mask_p		equ	attr_p + 1;					// (iy + $54)
attr_t		equ	mask_p + 1;					// (iy + $55)
mask_t		equ	attr_t + 1;					// (iy + $56)
p_flag		equ	mask_t + 1;					// (iy + $57)
membot		equ	p_flag + 1;					// (iy + $58)
mem_0_1		equ membot + 1;					// (iy + $59)
mem_0_2		equ	membot + 2;					// (iy + $5a)
mem_0_3		equ	membot + 3;					// (iy + $5b)
mem_0_4		equ	membot + 4;					// (iy + $5c)
mem_1		equ	membot + 5;					// (iy + $5d)
mem_1_1		equ	membot + 6;					// (iy + $5e)
mem_1_2		equ	membot + 7;					// (iy + $5f)
mem_1_3		equ	membot + 8;					// (iy + $60)
mem_1_4		equ	membot + 9;					// (iy + $61)
mem_2		equ	membot + 10;				// (iy + $62)
mem_2_1		equ	membot + 11;				// (iy + $63)
mem_2_2		equ	membot + 12;				// (iy + $64)
mem_2_3		equ	membot + 13;				// (iy + $65)
mem_2_4		equ	membot + 14;				// (iy + $66)
mem_3		equ	membot + 15;				// (iy + $67)
mem_3_1		equ	membot + 15;				// (iy + $68)
mem_3_2		equ	membot + 17;				// (iy + $69)
mem_3_3		equ	membot + 18;				// (iy + $6a)
mem_3_4		equ	membot + 19;				// (iy + $6b)
mem_4		equ	membot + 20;				// (iy + $6c)
mem_4_1		equ	membot + 21;				// (iy + $6d)
mem_4_2		equ	membot + 22;				// (iy + $6e)
mem_4_3		equ	membot + 23;				// (iy + $6f)
mem_4_4		equ	membot + 24;				// (iy + $70)
mem_5		equ	membot + 25;				// (iy + $71)
mem_5_1		equ	membot + 26;				// (iy + $72)
mem_5_2		equ	membot + 27;				// (iy + $73)
mem_5_3		equ	membot + 28;				// (iy + $74)
mem_5_4		equ	membot + 29;				// (iy + $75)
nmiadd		equ	membot + 30;				// (iy + $76)
ramtop		equ	nmiadd + 2;					// (iy + $78)
p_ramt		equ	ramtop + 2;					// (iy + $7a)
channels	equ	p_ramt + 2;					// 


;	// system variable IY offsets

;	// negative

_kstate			equ	$3a
_kstate_4		equ	$36
_last_k			equ	$32
_repdel			equ	$31
_repper			equ	$30
_defadd			equ	$2f
_defadd_h		equ	$2e
_k_data			equ	$2d
_vdu_data		equ	$2c
_vdu_data_h		equ	$2b
_strms			equ	$2a
_strms_fe		equ	$28
_strms_ff		equ	$26
_strms_00		equ	$24
_strms_01		equ	$22
_strms_02		equ	$20
_strms_03		equ	$1e
_strms_04		equ	$1c
_strms_05		equ	$1a
_strms_06		equ	$18
_strms_07		equ	$16
_strms_08		equ	$14
_strms_09		equ	$12
_strms_10		equ	$10
_strms_11		equ	$0e
_strms_12		equ	$0c
_strms_13		equ	$0a
_strms_14		equ	$08
_strms_15		equ	$06
_chars			equ	$04
_rasp			equ	$02
_pip			equ	$01

;	// positive

_err_nr			equ	$00
_flags			equ	$01
_vdu_flag		equ	$02
_err_sp			equ	$03
_list_sp		equ	$05
_mode			equ	$07
_newppc			equ	$08
_nsppc			equ	$0a
_ppc			equ	$0b
_subppc			equ	$0d
_bordcr			equ	$0e
_e_ppc			equ	$0f
_e_ppc_h		equ	$10
_vars			equ	$11
_dest			equ	$13
_chans			equ	$15
_curchl			equ	$17
_prog			equ	$19
_nxtlin			equ	$1b
_datadd			equ	$1d
_e_line			equ	$1f
_k_cur			equ	$21
_k_cur_h		equ	$22
_ch_add			equ	$23
_x_ptr			equ	$25
_x_ptr_h		equ	$26
_worksp			equ	$27
_stkbot			equ	$29
_stkend			equ	$2b
_stkend_h		equ	$2c
_breg			equ	$2d
_mem			equ	$2e
_flags2			equ	$30
_df_sz			equ	$31
_s_top			equ	$32
_oldppc			equ	$34
_osppc			equ	$36
_flagx			equ	$37
_strlen			equ	$38
_t_addr			equ	$3a
_seed			equ	$3c
_frames			equ	$3e
_frames_h		equ	$40
_udg			equ	$41
_coords			equ	$43
_coord_y		equ	$44
_p_posn			equ	$45
_pr_cc			equ	$46
_echo_e			equ	$48
_df_cc			equ	$4a
_df_ccl			equ	$4c
_s_posn			equ	$4e
_s_posn_h		equ	$4f
_sposnl			equ	$50
_sposnl_h		equ	$51
_scr_ct			equ	$52
_attr_p			equ	$53
_mask_p			equ	$54
_attr_t			equ	$55
_mask_t			equ	$56
_p_flag			equ	$57
_membot			equ	$58
_mem_0_1		equ	$59
_mem_0_2		equ	$5a
_mem_0_3		equ	$5b
_mem_0_4		equ	$5c
_mem_1			equ	$5d
_mem_1_1		equ	$5e
_mem_1_2		equ	$5f
_mem_1_3		equ	$60
_mem_1_4		equ	$61
_mem_2			equ	$62
_mem_2_1		equ	$63
_mem_2_2		equ	$64
_mem_2_3		equ	$65
_mem_2_4		equ	$66
_mem_3			equ	$67
_mem_3_1		equ	$68
_mem_3_2		equ	$69
_mem_3_3		equ	$6a
_mem_3_4		equ	$6b
_mem_4			equ	$6c
_mem_4_1		equ	$6d
_mem_4_2		equ	$6e
_mem_4_3		equ	$6f
_mem_4_4		equ	$70
_mem_5			equ	$71
_mem_5_1		equ	$72
_mem_5_2		equ	$73
_mem_5_3		equ	$74
_mem_5_4		equ	$75
_nmiadd			equ	$76
_ramtop			equ	$78
_p_ramt			equ	$7a
