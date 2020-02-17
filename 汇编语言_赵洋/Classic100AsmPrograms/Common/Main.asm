;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Main.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;通过可覆盖数据段来实现多模块间的参数传递
;source module 1

extrn	proadd:far

data	segment	common
	ary		dw	100 dup(?)
	count		dw	100
	sum		dw	?
data	ends

stack segment stack
stack ends

code1	segment
	assume cs:code1, ds:data

main	proc	far

start:
	mov	ax, data
	mov	ds, ax

	call	far ptr proadd

	mov	ax, 4c00h
	int	21h
main	endp

code1	ends
	
	end start