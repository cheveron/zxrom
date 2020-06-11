;	// The Uncommented Spectrum ROM Assembly
;	// Copyright (c) 2011 Source Solutions, Inc.

;	// This document is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
;	// https://creativecommons.org/licenses/by-sa/4.0/legalcode

;	// The binary produced by this source code is proprietary software owned by Comcast
;	// Copyright (c) 1982 Sky In-Home Service Ltd.

;	// Comcast places restrictions on the use this software:
;	// https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ 

	org $386e
spare:
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff, $ffff, $ffff, $ffff;								// 
	defw $ffff, $ffff, $ffff, $ffff;
