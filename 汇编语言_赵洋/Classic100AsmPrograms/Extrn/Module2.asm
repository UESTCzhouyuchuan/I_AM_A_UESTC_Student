;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Module2.asm
;��������������������������������������������������������������������
;������������public��extrnα�������÷�
;source module 2

extrn	var1:byte
public	var2

data2	segment
	var2	dw	0
	var3	db	5 dup(?)
data2	ends

code2 segment
	assume	cs:code2, ds:data2

code2 ends

	end