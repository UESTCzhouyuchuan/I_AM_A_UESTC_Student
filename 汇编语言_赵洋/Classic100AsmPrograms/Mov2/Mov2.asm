;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Mov2.asm
;��������������������������������������������������������������������
;���ݶ�����һ�������ֽڵ��ֽڱ�һ�������ֵ��ֱ��Ա��Ƴ�����ֽڱ���
;��ÿ��������Ϊ�ֱ��еĸ�λ�ֽڲ��������ֱ���
;�ñ�����ַѰַ��ʽ��д����

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

	xor	esi, esi

next:
	mov	ax, word_table[esi*2]
	mov	ah, byte_table[esi]

	mov	word_table[esi*2], ax
	inc	esi
	cmp	esi, 20
	jl	next


	mov	ax, 4c00h
	int	21h

	end start