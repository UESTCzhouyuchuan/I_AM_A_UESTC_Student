;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Main.asm
;��������������������������������������������������������������������
;ͨ���ɸ������ݶ���ʵ�ֶ�ģ���Ĳ�������
;source module 1

extrn	proadd:far

data	segment	common
	ary		dw	100 dup(?)
	count		dw	100
	sum		dw	?
data	ends

stack segment stack
stack ends

code1	segment
	assume cs:code1, ds:data

main	proc	far

start:
	mov	ax, data
	mov	ds, ax

	call	far ptr proadd

	mov	ax, 4c00h
	int	21h
main	endp

code1	ends
	
	end start