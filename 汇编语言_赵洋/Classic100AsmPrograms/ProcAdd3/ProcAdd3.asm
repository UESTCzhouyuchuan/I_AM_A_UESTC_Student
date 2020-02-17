;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ群：30515563
; ProcAdd3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;用过程累加数组的所有元素，并把和(不考虑溢出的可能性)送到指定的存储
;单元中。　这里通过堆栈传递参数或参数地址

;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
data segment
	ary	dw	100 dup(?)
	count	dw	100
	sum	dw	?
data ends

;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
stack segment stack
		dw	100 dup(?)
	tos	label	word
stack ends

;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
code1 segment

;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
main proc far

	assume cs:code1, ds:data, ss:stack

start:
	mov	ax, stack
	mov	ss, ax
	mov	sp, offset tos

	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	mov	bx, offset ary
	push	bx

	mov	bx, offset count
	push	bx
	
	mov	bx, offset sum
	push	bx

	call	far ptr procadd

	ret

main endp

code1 ends

;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
code2 segment

procadd proc far

	assume cs:code2

	push	bp
	mov	bp, sp

	push	ax
	push	cx
	push	si
	push	di

	mov	si, [bp+0ah]
	mov	di, [bp+8]
	mov	cx, [di]
	mov	di, [bp+6]

	xor	ax, ax

next:
	add	ax, [si]
	add	si, 2
	loop	next

	mov	[di], ax

	pop	di
	pop	si
	pop	cx
	pop	ax

	pop	bp

	ret	6

procadd endp

code2 ends

	end start