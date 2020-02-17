;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Typer.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;应用ＢＩＯＳ和ＤＯＳ功能调用，编写的一个打字程序
;它把从键盘上接收的字符显示在屏幕上，并由打印机输出，在按下ＥＳＣ时
;退出程序

;macro parameter str_addr = string address
PRINT_STRING MACRO str_addr
	push	dx
	push	ax

	mov	dx, offset str_addr
	mov	ah, 09
	int	21h

	pop	ax
	pop	dx
ENDM	


data segment
	introduction	db	'You are using a typer simulator.'
			db	'To quit this program, press ESC',13,10,'$'
	prompt_msg	db	9eh,10h,'$'
	KEY_ESC		equ	1bh		;esc   key
	KEY_CR		equ	0dh		;回车　key
	KEY_LF		equ	0ah		;换行　key
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax
	
	sti
	cld
	mov	ah, 0		;initialize printer
	mov	dx, 0
	int	17h

	call	ClearScreen

	mov	dx, 0
	mov	ah, 2
	int	10h		;locate the cursor

	PRINT_STRING introduction

	PRINT_STRING prompt_msg

	;accept and check keyboard input
get_char:
	mov	ah, 1		;to accept keyboard input
	int	21h		;call DOS
	cmp	al, 0
	jz	get_char	;judge whether non-ASC key pressed
	cmp	al, KEY_ESC	;judge whether ESC key pressed
	jz	exit

	;print the normal input charactor
	mov	dl, al
	mov	ah, 5
	int	21h

	;handle CR/LF condition
	cmp	al, KEY_CR	;judge whether CR key pressed
	jnz	get_char

	;if CR pressed, LF ensures
	mov	dl, KEY_LF
	mov	ah, 2
	int	21h		;display LF

	mov	ah, 5
	int	21h		;print LF
	 
	PRINT_STRING prompt_msg

	jmp	get_char
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
	mov	bh, 7		;blank line
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