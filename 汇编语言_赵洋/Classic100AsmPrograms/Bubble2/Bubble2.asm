;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Bubble2.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;冒泡排序程序实现2：使数组的数从小到大的顺序排序
;附加段中有一字数组，其首地址已经存放在ＤＩ中，数组的第一个元素中存放着数组的长度
;编程实现使数组的数从小到大的顺序排序

extra segment
	a		dw	10, 99, 88, 77, 66, 55, 44, 33, 22, 11
extra ends

data segment
	save_cnt	dw	?
	start_addr	dw	?
data ends

code segment
	assume cs:code, ds:data, es:extra
main proc far

start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	mov	ax, extra
	mov	es, ax

;program started--------------------------------------------------
	lea	di, a

	mov	start_addr, di
	mov	cx, es:[di]		;数组元素个数
	mov	save_cnt, cx

init:
	mov	bx, 1
	dec	save_cnt
	jz	sorted
	mov	cx, save_cnt
	mov	di, start_addr

next:
	add	di, 2
	mov	ax, es:[di]
	cmp	es:[di+2], ax
	jae	cont
	xchg	es:[di+2], ax
	mov	es:[di], ax
	sub	bx, bx
	
cont:
	loop	next
	cmp	bx, 0
	je	init

sorted:
	mov	di, start_addr

	ret
main endp

code ends
	end start