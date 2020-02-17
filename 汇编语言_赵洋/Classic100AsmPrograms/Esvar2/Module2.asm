;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; module2.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;通过附加段来实现多模块间的参数传递
;source module 2

global	segment	public
	public		var1, var2
	var1		dw	?
	var2		dw	?
global	ends

	end