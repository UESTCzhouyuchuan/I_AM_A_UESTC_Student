;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; SelPage.asm
;��������������������������������������������������������������������
;int 10h�Ĺ���5�����ɳ���ȷ���Դ��е���ʾ���򣬣ңϣ� �£ɣϣӽ��ãǣ�
;���Դ��Ϊ��ҳ��ÿҳ�������������ַ������Ϊ��ҳ��ÿҳ�������������ַ�
;ÿһҳ����ʼ��ַ�ڣ��ˣµı߽磬�⣴����ʼ��ַ�ֱ�Ϊ��
;B800:0000, B800:1000, B800:2000, B800:3000

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	al, 1
	call	SelPage

	ret
main endp

;input: al = video page number
SelPage  proc near

	mov	ah, 5		;function number
	int	10h		;call bios routine
	ret
SelPage  endp


code ends

	end start