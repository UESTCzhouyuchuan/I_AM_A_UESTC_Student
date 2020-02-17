;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ColorCh.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;利用ＢＩＯＳ　１０Ｈ的０９功能显示彩色字符串
;本例在品红背景下，显示25个浅绿色闪烁的星号

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ColorCharacter

	ret
main endp


ColorCharacter proc near
	mov	ah, 09h		;display a char and attr
	mov	al, '*'
	mov	bh, 0		;page 0
	mov	bl, 0dah	;color attribute
	mov	cx, 25
	int     10h

	ret
ColorCharacter endp

code ends

	end start