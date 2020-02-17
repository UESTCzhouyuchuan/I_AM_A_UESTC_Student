;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Cursor1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;置光标开始行为５，结束行为７，并把它设置到第５行第６列

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax
	
	call	SetCursor
	ret

main	endp


SetCursor proc near
	mov	ch, 5
	mov	cl, 7
	mov	ah, 1		;define cursor
	int	10h		;call bios routine

	mov	dh, 4		;row 5
	mov	dl, 5		;col 6
	mov	bh, 0		;page 0
	mov	ah, 2		;place cursor
	int	10h

	ret
SetCursor  endp


code ends

	end start