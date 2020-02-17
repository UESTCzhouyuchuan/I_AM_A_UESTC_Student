;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; CharPad.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;读取键盘状态字节，并以１６进制打印出来, 按下ＥＳＣ退出程序

code segment
main proc far
	assume	cs:code

start:
	push	ds
	sub	ax, ax
	push	ax

	call	GetKeyBoardStat

	ret
main	endp

GetKeyBoardStat	proc	near
again:
	mov	ah, 1
	int	21h
	cmp	al, 1bh		;判断是否是ＥＳＣ被按下
	jz	exit
	
	call	CrLf
	mov	ah, 2h		;BIOS键盘中断１６h的０２h功能得到键盘状态字节
	int	16h
	mov	bx, ax
	call	BiniHex
	call	CrLf
	jmp	again
exit:
	ret
GetKeyBoardStat	endp

BiniHex proc near
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

BiniHex endp

CrLf proc near
	mov	dl, 0ah
	mov	ah, 2h
	int	21h

	mov	dl, 0dh
	mov	ah, 2h
	int	21h
	ret
CrLf endp

code ends

	end start