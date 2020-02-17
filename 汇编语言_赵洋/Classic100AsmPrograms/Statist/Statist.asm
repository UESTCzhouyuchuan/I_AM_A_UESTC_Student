;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Statist.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;有一个N字数组array，统计其中正数，０，负数的个数

data segment
	N		equ		100	
	array		dw		N dup(?)
	nPositive	dw		?		;正数个数
	nZero		dw		?		;0的个数
	nNegative	dw		?		;负数个数
data ends

code segment
	assume cs:code, ds:data

main proc far
	
start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	call	Statist
	
	ret
main endp

Statist proc near
	mov	cx, N			;Load array size
	mov	nPositive, 0
	mov	nZero, 0
	mov	si, 0

Again:
	cmp	array[si], 0
	jle	LessOrEq
	inc	nPositive
	jmp	Next

LessOrEq:
	jl	next
	inc	nZero

Next:
	add	si, 2
	dec	cx
	jnz	Again

	mov	ax, N
	sub	ax, nPositive
	sub	ax, nZero
	mov	nNegative, ax
	
	ret
Statist endp

code ends

	end start