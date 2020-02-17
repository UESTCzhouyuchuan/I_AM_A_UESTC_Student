;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Cursor3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;置光标到０显示页的（２０，２５）位置，并以正常属性显示一个星号‘*’
;int 10h的功能９和功能０Ａ都能把一个字符送到显示屏幕，然后光标返回
;到它的初始位置，所以在当前光标位置上写一个字符之后，必须用int 10h
;的功能02移动光标到下一个字符位置上

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	SetCursor
	ret
main endp


SetCursor proc near
	mov	ah, 2		;set cursor pos
	mov	bh, 0		;page 0
	mov	dh, 20		;row 20
	mov	dl, 25		;col 25
	int     10h		;BIOS video ROM call

	mov	ah, 9		;write charactor
	mov	al, '*'		;charactor '*'
	mov	bh, 0		;page 0
	mov	bl, 7		;normal attribute
	mov	cx, 1		;number of repeat char
	int	10h

	ret
SetCursor endp

code ends

	end start