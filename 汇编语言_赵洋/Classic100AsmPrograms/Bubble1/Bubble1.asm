;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Bubble1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;冒泡排序程序实现：使数组的数从大到小的顺序排序

data segment
	a	dw	20 dup(?)
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

;program started--------------------------------------------------

	mov	cx, 100
	dec	cx

loop1:
	mov	di, cx
	mov	bx, 0
loop2:
	mov	ax, a[bx]
	cmp	ax, a[bx+2]
	jge	continue
	xchg	ax, a[bx+2]
	mov	a[bx], ax

continue:
	add	bx, 2
	loop	loop2
	mov	cx, di
	loop	loop1

	ret
main endp

code ends
	end start