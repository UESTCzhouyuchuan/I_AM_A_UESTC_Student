;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; DelItem.asm
;��������������������������������������������������������������������
;���Ӷ�����һ�������֣̣ɣӣԣ�������ĵ�һ���ִ���Ÿ�����ĳ��ȣ�Ԫ�ظ�����
;�����׵�ַ����ڣģ��У������д����һ������
;����ڣ̣ɣӣ��в��Ҹ������ҵ�������������ɾ��

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