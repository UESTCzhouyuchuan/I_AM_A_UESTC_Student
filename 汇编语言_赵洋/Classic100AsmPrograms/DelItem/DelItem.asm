;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; DelItem.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;附加段中有一个字数字ＬＩＳＴ，该数组的第一个字存放着该数组的长度（元素个数）
;数组首地址存放在ＤＩ中，ＡＸ中存放着一个数。
;编程在ＬＩＳＴ中查找该数，找到把它从数组中删除

extra segment
	list	dw	100 dup(?)
extra ends

code segment
	assume cs:code, ds:code, es:extra

del_ul proc near

	cld
	push	di
	mov	cx, es:[di]
	add	di, 2
	repne	scasw
	je	delete
	pop	di
	jmp	short exit

delete:
	jcxz	dec_cnt

next_el:
	mov	bx, es:[di]
	mov	es:[di-2], bx
	add	di, 2
	loop	next_el

dec_cnt:
	pop	di
	dec	word ptr es:[di]

exit:
	ret

del_ul endp


main proc far

start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, code
	mov	ds, ax

	mov	ax, extra
	mov	es, ax


	lea	di, list
	mov	word ptr [di], 100
	mov	ax, 33

	call	del_ul
	ret
main endp

code ends
	end start