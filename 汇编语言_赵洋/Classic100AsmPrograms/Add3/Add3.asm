;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Add3.asm
;��������������������������������������������������������������������
;���������ֳ������ֽڣ����ֱ����ڣģ��ԣ����ͣģ��ԣ���
;���ã�������ָ��������ǵĺͣ����ѽ�����ڣģ��ԣ���

.model small
.386
.data
	data1		dq	123456789abcdefh
	data2		dq	0fedcba987654321h
	data3		dq	?

.code

start:
	mov	ax, @data
	mov	ds, ax

	clc
	lea	si, data1
	lea	di, data2
	lea	bx, data3
	mov	cx, 2

back:
	mov	eax, [si]
	adc	eax, [di]
	mov	[bx], eax
	pushf
	add	si, 4
	add	di, 4
	add	bx, 4
	popf

	loop	back

	mov	ax, 4c00h
	int	21h

	end start