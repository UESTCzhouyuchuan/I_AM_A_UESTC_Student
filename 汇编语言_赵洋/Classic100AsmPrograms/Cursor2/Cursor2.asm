;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Cursor2.asm
;��������������������������������������������������������������������
;����0ҳ�ĵ�ǰ����λ��, int 10h����3�Ƕ�ȡ���λ�ã�ҳ��bhָ��
;�˹��ܰѹ��λ�õ��кŻ���dh���кŻ���dl
;�˹��ܰѹ���С��ch��cl

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax
	
	call	GetCursor
	;dh = row
	;dl = col

	ret
main endp


GetCursor proc near

	mov	ah, 3		;define cursor
	mov	bh, 0		;page 0
	int	10h
	ret
GetCursor  endp

code ends

	end start