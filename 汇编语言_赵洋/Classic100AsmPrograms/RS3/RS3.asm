;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; RS3.asm
;��������������������������������������������������������������������
;ʹ��BIOS���ڣ�/�ϵ�����
;��0�Ŵ��ڵĴ�������Ϊ�����������أ��ֳ���λ����λ��ֹλ������żУ��

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ConfigComm
	
	ret
main endp

ConfigComm proc near
	
	mov	ah, 0		;initialize comm
	mov	al, 0a3h	;0a3h = 10100011B
	mov	dx, 0		;COM1
	int	14h		;call BIOS

	ret
ConfigComm endp

code ends

	end start