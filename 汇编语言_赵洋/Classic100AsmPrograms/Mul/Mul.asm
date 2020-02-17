;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Mul.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;把两个长度为２０的双字长数组的对应元素分别相乘，并保存其乘积到一个４字数组
;用比例变址寻址方式编写程序

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