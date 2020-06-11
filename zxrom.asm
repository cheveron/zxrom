;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

;	// This file compiles with RASM, the cross-platform Z80 cross-assembler
;	// https://www.cpcwiki.eu/forum/programming/rasm-z80-assembler-in-beta/

;	// RASM -pasmo busra.asm -ob 48.ROM
;	// The -pasmo option advances the position of '- $' (beahves like Zeus)

include "zxrom.inc";	// label definitions and X80 instruction set

include "01_restarts.asm";
include "02_keyboard.asm";
include "03_audio.asm";
include "04_tape.asm";
include "05_screen_printer.asm";
include "06_editor.asm";
include "07_executive.asm";
include "08_command.asm";
include "09_expression.asm";
include "10_arithmetic.asm";
include "11_calculator.asm";
include "12_miscellaneous.asm";
include "13_font.asm";
