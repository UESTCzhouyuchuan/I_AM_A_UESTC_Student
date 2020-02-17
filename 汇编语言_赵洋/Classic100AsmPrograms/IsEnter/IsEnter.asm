;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; IsEnter.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;检测键盘输入的字符是否是ＥＮＴＥＲ，如果是就退出程序

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	GetKeyDown
	ret

main	endp


GetKeyDown proc	near

again:
	mov	ah, 7
	int	21h
	cmp	al, 0dh		;判断是否是enter被按下
	jne	again
	ret

GetKeyDown	endp

code ends

	end start