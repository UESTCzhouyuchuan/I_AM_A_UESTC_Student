;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Cursor3.asm
;��������������������������������������������������������������������
;�ù�굽����ʾҳ�ģ�������������λ�ã���������������ʾһ���Ǻš�*��
;int 10h�Ĺ��ܣ��͹��ܣ������ܰ�һ���ַ��͵���ʾ��Ļ��Ȼ���귵��
;�����ĳ�ʼλ�ã������ڵ�ǰ���λ����дһ���ַ�֮�󣬱�����int 10h
;�Ĺ���02�ƶ���굽��һ���ַ�λ����

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	SetCursor
	ret
main endp


SetCursor proc near
	mov	ah, 2		;set cursor pos
	mov	bh, 0		;page 0
	mov	dh, 20		;row 20
	mov	dl, 25		;col 25
	int     10h		;BIOS video ROM call

	mov	ah, 9		;write charactor
	mov	al, '*'		;charactor '*'
	mov	bh, 0		;page 0
	mov	bl, 7		;normal attribute
	mov	cx, 1		;number of repeat char
	int	10h

	ret
SetCursor endp

code ends

	end start