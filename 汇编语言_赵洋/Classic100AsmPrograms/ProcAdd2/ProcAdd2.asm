;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ProcAdd2.asm
;��������������������������������������������������������������������
;�ù����ۼ����������Ԫ�أ����Ѻ�(����������Ŀ�����)�͵�ָ���Ĵ洢
;��Ԫ�С����������ͨ����ַ���ݲ���

code segment
	assume cs:code,ds:code,es:code,ss:code
main proc near
start:
	org 100h
	mov	ax, code
	mov	ds, ax

	mov	table, offset ary
	mov	table+2, offset count
	mov	table+4, offset sum
	mov	bx, offset table

	call	procadd

	mov	ax, 4c00h
	int	21h

main endp

procadd proc near

	push	ax
	push	cx
	push	si
	push	di

	mov	si, [bx]
	mov	di, [bx+2]
	mov	cx, [di]
	mov	di, [bx+4]

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
	ret

procadd endp

;��������������������������������������������������������������������
	;data goes here
	ary		dw	100 dup(?)
	count		dw	100
	sum		dw	?
	table		dw	3 dup(?)

code ends

	end start