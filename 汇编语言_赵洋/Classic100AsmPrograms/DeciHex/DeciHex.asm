;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; DeciHex.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;从键盘取得一个１０进制数，然后把该数以１６进制形式在屏幕上显示出来
;通过寄存器传递参数,CTRL+C退出程序

code segment
	assume cs:code

main proc far

start:
	call	decihex
	call	crlf
	call	binihex
	call	crlf
	jmp	start

main endp

decihex proc near

	mov bx, 0

newchar:
	mov	ah, 1
	int	21h
	sub	al, 30h
	jl	exit
	cmp	al, 9d
	jg	exit
	cbw

	xchg	ax, bx
	mov	cx, 10d
	mul	cx
	xchg	ax, bx

	add	bx, ax
	jmp	newchar
 
 exit:
	ret

decihex endp

binihex proc near

	mov	ch, 4

rotate:
	mov	cl, 4
	rol	bx, cl
	mov	al, bl
	and	al, 0fh
	add	al, 30h
	cmp	al, 3ah
	jl	printit
	add	al, 7h

printit:
	mov	dl, al
	mov	ah, 2
	int	21h
	dec	ch
	jnz	rotate
	ret

binihex endp

crlf proc near

	mov	dl, 0dh
	mov	ah, 2
	int	21h
	mov	dl, 0ah
	mov	ah, 2
	int	21h
	ret

crlf endp

code ends

	end start