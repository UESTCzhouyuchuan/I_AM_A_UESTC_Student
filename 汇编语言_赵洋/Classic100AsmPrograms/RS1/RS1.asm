;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; RS1.asm
;��������������������������������������������������������������������
;ʹ�ãģϣӴ��ڣ�/�ϵ�����
;�Ӵ�������һ���ַ�������INPUT_CHAR��Ԫ��

data segment
	INPUT_CHAR	db	?
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

	call	GetChar
	
	ret
main endp

GetChar	proc near
	
	mov	ah, 3
	int	21h
	mov	INPUT_CHAR, al

	ret
GetChar	endp

code ends

	end start