;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ShowCh2.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;在屏幕上以红底蓝字显示字符串："Hello "
;然后分别以红底绿字和红底蓝字相间地显示"world!"

data segment
	string1		db	'Hello '
	string2		db	'w',42h,'o',41h,'r',42h,'l',41h,'d',42h,'!',41h
	string2_len	equ	$-string2
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

	mov	bp, seg string1		;base of string
	mov	es, bp

	mov	bp, offset string1	;offset of string
	mov	cx, string2-string1	;charactor count

	mov	dx, 0			;start at top left corner
	mov	bl, 41h			;use blue on red lettering
	mov	al, 1			;make curson return
	mov	ah, 13h			;display the string
	int	10h			;call BIOS

	mov	ah, 3			;read the cursor pos
	int	10h
	mov	bp, offset string2	
	mov	cx, string2_len
	mov	al, 3			;display char and attribute
	mov	ah, 13h			;display the string2
	int	10h			;call BIOS

	ret
ShowString  endp

code ends

	end start