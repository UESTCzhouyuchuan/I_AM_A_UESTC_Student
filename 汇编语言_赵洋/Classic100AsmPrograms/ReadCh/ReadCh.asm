;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ReadCh.asm
;��������������������������������������������������������������������
;�ڣ���ʾҳ�ģ�����������λ�ö�ȡ�ַ�������, ���Ƚ���궨λ������ʾҳ
;�ģ�����������λ�ã��Ա��ȡ�ô����ַ�������

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ReadCharacrer
	;now ah = attribute, al = ascii code

	ret
main endp


ReadCharacrer proc near
	mov	ah, 2		;set cursor pos
	mov	bh, 0		;page 0
	mov	dh, 11		;row 11
	mov	dl, 0		;col 0
	int     10h		;BIOS video ROM call

	mov	ah, 8		;read cursor pos's char and attribute
	mov	bh, 0		;page 0
	int	10h		;BIOS video ROM call

	ret
ReadCharacrer  endp

code ends

	end start