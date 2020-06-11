# The Uncommented Spectrum ROM Assembly
__Copyright &copy; 2011 Source Solutions, Inc.__

This repo contains the recreated source-code for the original ZX Spectrum ROM.

## License
All files within this repo are released under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/legalcode).

The binary produced by this source code is proprietary software owned by Comcast
(Copyright &copy; 1982 Sky In-Home Service Ltd).
Comcast places [restrictions](https://groups.google.com/forum/#!msg/comp.sys.amstrad.8bit/HtpBU2Bzv_U/HhNDSU3MksAJ) on the use this software.

## Contribute!
The source files in this repo are for historical reference and will be kept static, so please don’t send Pull Requests suggesting any modifications to the source files, but feel free to fork this repo and experiment.

The source builds with the cross-platform [RASM Z80 Assembler](https://www.cpcwiki.eu/forum/programming/rasm-z80-assembler-in-beta/).
From the command line: `RASM -pasmo busra.asm -ob 48.ROM`
