;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Macro4.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;movif宏定义利用其参数为Ｂ或Ｗ而产生ＲＥＰ　ＭＯＶＳＢ或
;ＲＥＰ　ＭＯＶＳＷ的指令，如不给出参数则产生ＲＥＰ　ＭＯＶＳＢ

movif	macro	tag
	ifidn	<&tag>,<b>
		rep	movsb
		exitm
	endif
	ifidn	<&tag>,<w>
		rep	movsw
	else
		rep	movsb
	endif
endm

	if1
		include Macro.mac
	endif
	purge	prompt

.model	small
.386
.stack	200h
.data

.code

main proc far
start:
	.sall
	initz
	.xall
	movif	b
	movif	w
	movif
	.sall
	finish
main endp

	end  start

