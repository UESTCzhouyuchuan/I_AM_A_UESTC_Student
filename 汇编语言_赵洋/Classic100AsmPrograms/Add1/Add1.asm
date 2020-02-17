;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Add1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;有两个４字长（８字节）数分别存放在ＤＡＴＡ１和ＤＡＴＡ２
;请用８０８６指令求出他们的和，并把结果放在ＤＡＴＡ３

.model small

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
	mov	cx, 4

back:
	mov	ax, [si]
	adc	ax, [di]
	mov	[bx], ax
	inc	si
	inc	si
	inc	di
	inc	di
	inc	bx
	inc	bx

	loop	back

	mov	ax, 4c00h
	int	21h

	end start