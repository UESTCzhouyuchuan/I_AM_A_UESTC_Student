;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; SelPage.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;int 10h的功能5可以由程序确定显存中的显示区域，ＲＯＭ ＢＩＯＳ将ＣＧＡ
;的显存分为４页，每页２５×８０个字符，或分为８页，每页２５×４０个字符
;每一页的起始地址在１ＫＢ的边界，这４个起始地址分别为：
;B800:0000, B800:1000, B800:2000, B800:3000

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	al, 1
	call	SelPage

	ret
main endp

;input: al = video page number
SelPage  proc near

	mov	ah, 5		;function number
	int	10h		;call bios routine
	ret
SelPage  endp


code ends

	end start