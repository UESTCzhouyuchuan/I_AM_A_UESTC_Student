;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Mul.asm
;��������������������������������������������������������������������
;����������Ϊ������˫�ֳ�����Ķ�ӦԪ�طֱ���ˣ���������˻���һ����������
;�ñ�����ַѰַ��ʽ��д����

.model small
.386
.stack 200h

.data
	data1		dd	20 dup(?)
	data2		dd	20 dup(?)
	result		dq      20 dup(?)

.code

start:
	mov	ax, @data
	mov	ds, ax

	sub	ebx, ebx
	mov	cx, 20

back:
	mov	eax, data1[ebx*4]
	mul	data2[ebx*4]

	mov	dword ptr result[ebx*8], eax
	mov	dword ptr result+4[ebx*8], edx

	inc	ebx
	dec	cx
	jnz	back

	mov	ax, 4c00h
	int	21h

	end start