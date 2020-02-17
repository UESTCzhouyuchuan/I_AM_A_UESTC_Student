;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Module1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;本例讲述关于public与extrn伪操作的用法,通过外部符号来实现多模块间的
;参数传递 source module 1
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－

extrn	var2:word, lab2:far
public	var1, lab1

data1	segment
	var1	db	?
	var3	dw	?
	var4	dw	?
data1	ends

stack   segment stack
stack	ends

code1	segment
	assume	cs:code1, ds:data1
main	proc	far
start:
	mov	ax, data1
	mov	ds, ax

	;.......

lab1:
	mov	ax, 4c00h
	int	21h
main	endp

code1	ends

	end start