;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; IsF1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;检测键盘输入的功能键是否是Ｆ１，Ｆ２等，如果是就退出程序

code segment

main proc far
	assume	cs:code

start:
	push	ds
	sub	ax, ax
	push	ax

	call	GetKeyDown
	ret

main	endp

GetKeyDown proc	near

@next:
	mov	ah, 7
	int	21h
	cmp	al, 0		;判断是否是功能键被按下
	je	@scancode
	jmp	@next
@scancode:
	mov	ah, 7
	int	21h
	cmp	al, 3bh		;F1?
	je	@option1
	cmp	al, 3ch		;F2?
	je	@option2
	cmp	al, 3dh		;F3?
	je	@option3

@option1:

@option2:

@option3:

	ret
GetKeyDown endp

code ends

	end start