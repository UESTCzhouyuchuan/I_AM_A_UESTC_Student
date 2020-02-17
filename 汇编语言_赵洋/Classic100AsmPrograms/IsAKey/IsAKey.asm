;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; IsAKey.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;检测键盘是否有输入，如果有就退出程序

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	WaitUntilAKeyPressed
	ret
main	endp

WaitUntilAKeyPressed proc near

again:
	mov	ah, 0bh		;get keyboard stat
	int	21h
	cmp	al, 0ffh	;if al not 0ffh, then no key pressed
	jnz	again
	ret

WaitUntilAKeyPressed endp

code ends

	end start