;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Mov1.asm
;��������������������������������������������������������������������
;���ݶ�����һ�������ֽڵ��ֽڱ�һ�������ֵ��ֱ��Ա��Ƴ�����ֽڱ���
;��ÿ��������Ϊ�ֱ��еĸ�λ�ֽڲ��������ֱ���
;��һ��Ѱַ��ʽ��д����

.model small
.386
.stack 200h
.data
	byte_table	db	20 dup(?)
	word_table	dw	20 dup(?)

.code

start:
	mov	ax, @data
	mov	ds, ax

	xor	si, si
	xor	di, di

next:
	mov	ax, word_table[di]
	mov	ah, byte_table[si]

	mov	word_table[di], ax
	inc	si
	add	di, 2
	cmp	si, 20
	jl	next

	mov	ax, 4c00h
	int	21h

	end start