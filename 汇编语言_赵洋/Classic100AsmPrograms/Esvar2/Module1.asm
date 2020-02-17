;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; module1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;通过附加段来实现多模块间的参数传递
;source module 1

global segment public
	extrn	var1:word, var2:word
global ends

local_data segment
local_data ends

stack segment stack
stack ends

;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
code	segment
	assume	cs:code, ds:local_data, es:global

main	proc	far

start:
	mov	ax, local_data
	mov	ds, ax

	mov	ax, global
	mov	es, ax

	mov     bx, es:var1
	add	es:var2, bx

	mov	ax, 4c00h
	int	21h

main	endp

code	ends

	end start