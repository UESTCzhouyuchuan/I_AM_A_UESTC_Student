;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; HexiDec.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;把16进制数转换成10进制数，把从键盘输入的0～FFFFH的16进制正数转换成
;10进制数并在屏幕上显示出来

display		equ	2h	;video output
key_in		equ	1h	;keyboard input
doscall		equ	21h	;DOS interrupt number

code segment
main	proc	far
	assume	cs:code

start:
	push	ds
	sub	ax, ax
	push	ax

	call	hexibin
	call	crlf

	call	binidec
	call	crlf
	jmp	main

	ret
main	endp

hexibin	proc	near

	mov	bx, 0
newchar:
	mov	ah, key_in
	int	doscall
	sub	al, 30h
	jl	exit
	cmp	al, 10d
	jl	add_to

	sub	al, 27h
	cmp	al, 0ah
	jl	exit
	cmp	al, 10h
	jge	exit

add_to:
	mov	cl, 4
	shl	bx, cl
	mov	ah, 0
	add	bx, ax
	jmp	newchar
exit:
	ret
hexibin endp

binidec	proc	near
	mov	cx, 10000d
	call	dec_div
	mov	cx, 1000d
	call	dec_div
	mov	cx, 100d
	call	dec_div
	mov	cx, 10d
	call	dec_div
	mov	cx, 1d
	call	dec_div
	ret
binidec endp

dec_div proc	near
	mov	ax, bx
	mov	dx, 0
	div	cx
	mov	bx, dx
	mov	dl, al

	add	dl, 30h
	mov	ah, display
	int	doscall
	ret
dec_div	endp

crlf	proc	near
	mov	dl, 0ah
	mov	ah, display
	int	doscall

	mov	dl, 0dh
	mov	ah, display
	int	doscall
	ret
crlf	endp

code ends

	end start

