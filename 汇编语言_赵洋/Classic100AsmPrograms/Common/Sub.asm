;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Sub.asm
;��������������������������������������������������������������������
;ͨ���ɸ������ݶ���ʵ�ֶ�ģ���Ĳ�������
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