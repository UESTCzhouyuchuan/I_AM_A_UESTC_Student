;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Count1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;把number中１的个数存入ＣＯＵＮＴ单元中
;
data segment
	number		dw	1111111111111111B
	count		dw	?
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	mov	cx, 0
	lea	bx, number
	mov	ax, [bx]

repeat1:
	test	ax, 0ffffh		;test all bits, set SF ZF, CF=OF=0
	jz	exit			;ax = 0
	jns	shift			;ax < 0
	inc	cx
shift:
	shl	ax, 1			;move to left, fill 0 at the right
	jmp	repeat1
exit:
	mov	count, cx
	mov	bx, count
	call	PrintHex

	ret
main endp

;把ＢＸ寄存器内的２进制数用１６进制的形式在屏幕上显示出来
;INPUT:
;BX = number to display
PrintHex proc near

	mov	ch, 4		;number of digits
rotate:
	mov	cl, 4		;set count to 4 bits
	rol	bx, cl		;left digit to right
	mov	al, bl		;mov to al
	and	al, 0fh		;mask off left digit
	add	al, 30h		;convert hex to ASC2
	cmp	al, 3ah		;is it > 9 ?
	jl	printit		;jump if digit =0 to 9
	add	al,7h		;digit is A to F

printit:
	mov	dl, al
	mov	ah, 2
	int	21h
	dec	ch
	jnz	rotate
	ret

PrintHex endp

code ends
	end start