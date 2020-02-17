;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Logic.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;数组Ｘ中有Ｘ１，Ｘ２，Ｘ３，... ... Ｘ１０；
;数组Ｙ中有Ｙ１，Ｙ２，Ｙ３，... ... Ｙ１０；
;编程计算：
;	Ｚ１ ＝ Ｘ１ ＋ Ｙ１,	Ｚ２  ＝ Ｘ２   ＋ Ｙ２,
;	Ｚ３ ＝ Ｘ３ － Ｙ３,	Ｚ４  ＝ Ｘ４   － Ｙ４,
;	Ｚ５ ＝ Ｘ５ － Ｙ５,	Ｚ６  ＝ Ｘ６   ＋ Ｙ６,
;	Ｚ７ ＝ Ｘ７ － Ｙ７,	Ｚ８  ＝ Ｘ８   － Ｙ８,
;	Ｚ９ ＝ Ｘ９ ＋ Ｙ９,	Ｚ１０＝ Ｘ１０ ＋ Ｙ１０,
;结果存入Ｚ数组

data segment
	x		dw	1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	y		dw	19,18,17,16,15,14,13,12,11,10
	z		dw	10 dup(?)
	logic_rule	dw	0000000011011100B
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

	mov	bx, 0
	mov	cx, 10
	mov	dx, logic_rule

next:
	mov	ax, x[bx]
	shr	dx, 1
	jc	subtract
	add	ax, y[bx]
	jmp	short result

subtract:
	sub	ax, y[bx]

result:
	mov	z[bx], ax
	add	bx, 2
	loop	next

	ret
main endp

code ends
	end start