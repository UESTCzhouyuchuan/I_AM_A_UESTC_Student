;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Sum.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;用比例变址寻址方式编写一程序，把５个双字相加，并保存其结果

.model small
.386
.stack 200h
.data
	array		dd	234556h, 0f983f5h, 6754ae2h, 0c5231239h, 0af34acb4h
	sum		dq	?

.code

start:
	mov	ax, @data
	mov	ds, ax

	sub	ebx, ebx
	mov	edx, ebx
	mov	eax, ebx
	mov	cx, 5

back:
	add	eax, array[ebx*4]
	adc	edx, 0
	inc	ebx
	dec	cx
	jnz	back
	mov	dword ptr sum, eax
	mov	dword ptr sum+4, edx

	mov	ax, 4c00h
	int	21h

	end start