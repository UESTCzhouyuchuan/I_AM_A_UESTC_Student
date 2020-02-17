;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; CentWind.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;在屏幕中心的小窗口显示字符
;在屏幕的中间建立一个２０列宽和９行高的窗口，然后把键盘输入的内容在
;这个窗口显示出来，键入的字符将被显示在窗口的最下面一行，每当输入２０
;个字符，该行就向上卷动，９行字符输入完后，顶端行的内容消失

ESC_KEY		equ	1bh
win_ulc		equ	30	;up left col
win_ulr		equ	8	;up left row
win_lrc		equ	50	;low right col
win_lrr		equ	16	;low right row
win_width	equ	20	;width of window


code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ClearScreen

locate:
	;locate cursor
	mov	ah, 2
	mov	dh, win_lrr
	mov	dl, win_ulc
	mov	bh, 0
	int	10h

	;get charactors from keyboard
	mov     cx, win_width

get_char:
	mov	ah, 1		;to accept input
	int     21h		;call DOS
	cmp	al, ESC_KEY	;judge whether ESC pressed
	jz	exit
	loop	get_char

	;scroll up
	mov	ah, 6
	mov     al, 1
	mov	ch, win_ulr
	mov	cl, win_ulc
	mov	dh, win_lrr
	mov	dl, win_lrc
	mov	bh, 7
	int	10h
	jmp	locate

exit:
	ret
main endp


ClearScreen proc near
	
	push	ax
	push	bx
	push	cx
	push	dx

	;clear screen
	mov	ah, 6		;to scroll up screen
	mov	al, 0		;blank screen
	mov	bh, 7h		;reverse video attribute
	mov	ch, 0		;up left row
	mov	cl, 0		;up left col
	mov	dh, 24		;low right row
	mov	dl, 79		;low right col
	int	10h

	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
ClearScreen endp

code ends

	end start