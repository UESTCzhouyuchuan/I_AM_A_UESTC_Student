;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; IsEnter.asm
;��������������������������������������������������������������������
;������������ַ��Ƿ��ǣţΣԣţң�����Ǿ��˳�����

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	GetKeyDown
	ret

main	endp


GetKeyDown proc	near

again:
	mov	ah, 7
	int	21h
	cmp	al, 0dh		;�ж��Ƿ���enter������
	jne	again
	ret

GetKeyDown	endp

code ends

	end start