;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; InputS.asm
;��������������������������������������������������������������������
;��̣��Ӽ�������һ���ַ���Ҫ���һ��������ַ������ǿո��ַ����粻��
;���˳���������ǣ���ʼ���ܼ�����ַ�����˳���ŵ��׵�ַΪ�£գƣƣţ�
;�Ļ������У��ո�������룬֪�����ܵ��ڣ����ո��ʱ�˳�����
;

data segment
	buffer		db	512 dup(?)
	flag            db      ?
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

	lea	bx, buffer
	mov	flag, 0
next:
	mov	ah, 01
	int	21h
	test	flag, 01h
	jnz	follow
	cmp	al,20h
	jnz	exit
	mov	flag, 1
	jmp	next
follow:
	cmp	al, 20h
	jz	exit
	mov	[bx], al
	inc	bx
	jmp	next
exit:
	ret
main endp

code ends
	end start