;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; module1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;通过附加段来实现多模块间的参数传递
;source module 1

extrn	var1:word, output:far
extrn	var2:word
public	exit


local_data	segment
	var	dw	5
local_data	ends

stack segment stack
stack ends

;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
code	segment
	assume	cs:code, ds:local_data

main	proc	far

start:
	mov	ax, local_data
	mov	ds, ax

	mov	bx, var
	mov	ax, seg	var1
	mov	es, ax
	add	bx, es:var1

	mov	ax, seg var2
	mov	es, ax
	sub	es:var2, 50

	jmp	output

exit:	
	mov	ax, 4c00h
	int	21h
main	endp

code	ends

	end start