;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ColorCh.asm
;��������������������������������������������������������������������
;���ã£ɣϣӡ������ȵģ���������ʾ��ɫ�ַ���
;������Ʒ�챳���£���ʾ25��ǳ��ɫ��˸���Ǻ�

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ColorCharacter

	ret
main endp


ColorCharacter proc near
	mov	ah, 09h		;display a char and attr
	mov	al, '*'
	mov	bh, 0		;page 0
	mov	bl, 0dah	;color attribute
	mov	cx, 25
	int     10h

	ret
ColorCharacter endp

code ends

	end start