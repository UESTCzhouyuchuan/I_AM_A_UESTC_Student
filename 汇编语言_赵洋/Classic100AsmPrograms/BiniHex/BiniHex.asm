;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; BiniHex.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;二进制数到１６进制数转换程序
;本程序把ＢＸ寄存器内的２进制数用１６进制的形式在屏幕上显示出来

program segment

main proc far
	assume cs:program
start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	;main part of prognam
	mov	bx, 16

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

main endp

program ends

	end