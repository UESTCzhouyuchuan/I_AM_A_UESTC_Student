;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; DispMode.asm
;��������������������������������������������������������������������
;����BIOS�ģɣΣԡ�������������ʾ��ʽ
;ͼ�������������ֲ�����ʽ���ı���ʽ��ͼ�η�ʽ���ı���ʽ��ͼ����������
;Ĭ�Ϸ�ʽ����ʾ��һ�����ó�ͼ�η�ʽ����꼴��ʧ

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax
	
	call	SetVGAMode

	ret
main endp

SetTextMode proc near

	mov	ah, 00h		;Request set mode
	mov	al, 03h		;color text
	int	10h		;BIOS video ROM call 

	ret
SetTextMode endp

SetVGAMode proc near

	mov	ah, 00h		;Request set mode
	mov	al, 12h		;color graphics
	int	10h		;BIOS video ROM call 

	ret
SetVGAMode endp

code ends

	end start