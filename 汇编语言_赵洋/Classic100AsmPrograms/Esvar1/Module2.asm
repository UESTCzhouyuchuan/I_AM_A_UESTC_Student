;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; module2.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;通过附加段来实现多模块间的参数传递
;source module 2

public	var1

extdata1 segment
	var1	dw	10
extdata1 ends

	end