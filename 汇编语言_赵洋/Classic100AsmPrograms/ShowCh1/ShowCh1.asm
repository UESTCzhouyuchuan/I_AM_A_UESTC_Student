;гнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгн
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ╚╣г║30515563
; ShowCh1.asm
;гнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгн
;╘┌╞┴─╗╔╧╥╘║ь╡╫└╢╫╓╧╘╩╛╫╓╖√┤ог║"Hello world!"

data segment
	string		db	'Hello world!'
	string_len	equ	$-string
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

	call	ShowString

	ret
main endp


ShowString proc near

	mov	al, 3			;select 80*25 color text
	mov	ah, 0			;change mode
	int	10h

	mov	bp, seg string		;base of string
	mov	es, bp

	mov	bp, offset string	;offset of string
	mov	cx, string_len		;charactor count

	mov	dx, 0			;start at top left corner
	mov	bl, 41h			;use blue on red lettering
	mov	al, 0			;make curson return
	mov	ah, 13h			;display the string
	int	10h			;call BIOS

	ret
ShowString endp

code ends

	end start