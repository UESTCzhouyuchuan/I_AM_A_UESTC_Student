;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Print1.asm
;��������������������������������������������������������������������
;���ãģϣӹ��ܴ�ӡ�ַ���
;����DOS��int 21h����5����һ���ַ��͵���ӡ�����ַ�������ڣģ̼Ĵ���
;�У�����Ψһ�ģģϣӴ�ӡ���ܣ�Ϊ��������ӡ����ָ���˴�ӡ���ֽ���
;������text�е�0ch�ǻ�ҳ�룬0dh�ǻس��룬0ah�ǻ�����

data segment
	text		db	0ch,'Hello everybody!',0dh,0ah,0ah
	count		equ	$-text
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax
	
	call	Print

	ret
main endp

Print proc near
	mov	cx, count
	mov	bx, 0
next:
	mov	ah, 5
	mov	dl, text[bx]
	int	21h
	inc	bx
	loop	next

	ret
Print endp

code ends

	end start