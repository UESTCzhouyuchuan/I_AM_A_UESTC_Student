;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Sub.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;通过可覆盖数据段来实现多模块间的参数传递
;source module 2

public	proadd

data	segment	common
	ary	dw	100 dup(?)
	count	dw	100
	sum	dw	?
data	ends

code2	segment
	assume cs:code2, ds:data

proadd	proc	far
	
	mov	ax, data
	mov	ds, ax

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

proadd	endp

code2	ends

	end