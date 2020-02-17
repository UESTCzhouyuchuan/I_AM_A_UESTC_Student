;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Insert.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;将正数Ｎ插入一个已经从小到大排序的正数字数组的正确位置
;该数组的首地址和末地址分别为ARRAY_HEAD,ARRAY_END
;

data segment
	x		dw	?
	array_head	dw	3,5,15,23,37,49,52,65,78,99
	array_end	dw	105
	n		dw	32
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

	mov	ax, n
	mov	array_head-2, 0ffffh
	mov	si, 0

compare:
	cmp	array_end[si], ax
	jle	insert
	mov	bx, array_end[si]
	mov	array_end[si+2], bx
	sub	si, 2
	jmp	short compare

insert:
	mov	array_end[si+2], ax
	
	ret
main endp

code ends
	end start