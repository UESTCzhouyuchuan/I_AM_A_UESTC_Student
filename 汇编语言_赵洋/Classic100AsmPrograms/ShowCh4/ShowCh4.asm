;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ShowCh4.asm
;��������������������������������������������������������������������
;����DOS��int 21h���ܣ�����ʾ�ַ���,һ��Ҫ����ʾ��֮����϶����'$'
;��ʧ��������ܻ�����Ļ���������벻���ĺ��

;macro parameter str_addr = string address
PRINT_STRING MACRO str_addr
	push	dx
	push	ax

	mov	dx, offset str_addr
	mov	ah, 09
	int	21h

	pop	ax
	pop	dx
ENDM

data segment
	message		db	'Hello world!',13,10,'$'
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
	
	PRINT_STRING message

	ret
main endp

code ends

	end start