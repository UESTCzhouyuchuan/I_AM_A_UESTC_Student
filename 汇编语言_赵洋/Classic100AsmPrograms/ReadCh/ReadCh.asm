;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ReadCh.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;在０显示页的（１１，０）位置读取字符和属性, 首先将光标定位到０显示页
;的（１１，０）位置，以便读取该处的字符和属性

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ReadCharacrer
	;now ah = attribute, al = ascii code

	ret
main endp


ReadCharacrer proc near
	mov	ah, 2		;set cursor pos
	mov	bh, 0		;page 0
	mov	dh, 11		;row 11
	mov	dl, 0		;col 0
	int     10h		;BIOS video ROM call

	mov	ah, 8		;read cursor pos's char and attribute
	mov	bh, 0		;page 0
	int	10h		;BIOS video ROM call

	ret
ReadCharacrer  endp

code ends

	end start