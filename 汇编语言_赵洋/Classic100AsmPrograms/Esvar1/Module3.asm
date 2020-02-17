;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; module3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;通过附加段来实现多模块间的参数传递
;source module 3

public	var2
extrn	exit:far

extdata2 segment
	var2	dw	3
extdata2 ends

public	output

prognam	segment
	assume	cs:prognam, ds:extdata2

output:
	jmp	exit

prognam	ends

	end