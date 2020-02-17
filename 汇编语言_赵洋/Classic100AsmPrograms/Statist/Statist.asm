;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Statist.asm
;��������������������������������������������������������������������
;��һ��N������array��ͳ���������������������ĸ���

data segment
	N		equ		100	
	array		dw		N dup(?)
	nPositive	dw		?		;��������
	nZero		dw		?		;0�ĸ���
	nNegative	dw		?		;��������
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