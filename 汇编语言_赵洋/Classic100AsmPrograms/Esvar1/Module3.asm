;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; module3.asm
;��������������������������������������������������������������������
;ͨ�����Ӷ���ʵ�ֶ�ģ���Ĳ�������
;source module 3

public	var2
extrn	exit:far

extdata2 segment
	var2	dw	3
extdata2 ends

public	output

prognam	segment
	assume	cs:prognam, ds:extdata2

output:
	jmp	exit

prognam	ends

	end