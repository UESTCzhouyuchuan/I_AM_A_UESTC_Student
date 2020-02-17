;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ProcAdd1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;用过程累加数组的所有元素，并把和(不考虑溢出的可能性)送到指定的存储
;单元中, 该过程ProcAdd直接访问模块的数据区

data segment
	ary		dw	100 dup(?)
	count		dw	100
	sum		dw	?
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

	call	near ptr procadd

	ret
main endp

procadd proc near

	push	ax
	push	cx
	push	si

	lea	si, ary
	mov	cx, count
	xor	ax, ax

next:
	add	ax, [si]
	add	si, 2
	loop	next
	mov	sum, ax

	pop	si
	pop	cx
	pop	ax
	ret

procadd endp

code ends

	end start