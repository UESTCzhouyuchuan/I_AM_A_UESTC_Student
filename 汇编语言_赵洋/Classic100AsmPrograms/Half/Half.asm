;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Half.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;折半查找程序实现：
;附加段中有一从小到大排序的无符号数数组，其首地址已经存放在ＤＩ中，
;数组的第一个元素中存放着数组的长度,ＡＸ中有一个数，要求在数组中查找
;（ＡＸ），如果找到使ＣＦ＝０，并在ＳＩ中给出该元素在数组中的偏移地址
;，如未找到则使ＣＦ＝１

extra segment
	a		dw	10, 11, 22, 33, 44, 55, 66, 77, 88, 99
extra ends

data segment
	low_idx		dw	?
	high_idx	dw	?
data ends

code segment
	assume cs:code, ds:data, es:extra

b_search proc near

	push	ds
	push	ax
	mov	ax, data
	mov	ds, ax
	mov	es, ax
	pop	ax

	cmp	ax, es:[di+2]
	ja	chk_last
	lea	si, es:[di+2]
	je	exit
	stc
	jmp	exit

chk_last:
	mov	si, es:[di]
	shl	si, 1
	add	si, di
	cmp	ax, es:[si]
	jb	search
	je	exit
	stc
	jmp	exit

search:
	mov	low_idx, 1
	mov	bx, es:[di]
	mov	high_idx, bx
	mov	bx, di

mid:
	mov	cx, low_idx
	mov	dx, high_idx
	cmp	cx, dx
	ja	no_match
	add	cx, dx
	shr	cx, 1
	mov	si, cx
	shl	si, 1

compare:
	cmp	ax, es:[bx+si]
	je	exit
	ja	higher

	dec	cx
	mov	high_idx, cx
	jmp	mid
	
higher:
	inc	cx
	mov	low_idx, cx
	jmp	mid

no_match:
	stc

exit:
	pop	ds
	ret
b_search endp

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

	lea	di, a
	call	b_search

	ret
main endp

code ends

	end start