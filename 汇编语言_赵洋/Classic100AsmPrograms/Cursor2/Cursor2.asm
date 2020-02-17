;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Cursor2.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;读第0页的当前光标的位置, int 10h功能3是读取光标位置，页号bh指定
;此功能把光标位置的行号回送dh，列号回送dl
;此功能把光标大小的ch与cl

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax
	
	call	GetCursor
	;dh = row
	;dl = col

	ret
main endp


GetCursor proc near

	mov	ah, 3		;define cursor
	mov	bh, 0		;page 0
	int	10h
	ret
GetCursor  endp

code ends

	end start