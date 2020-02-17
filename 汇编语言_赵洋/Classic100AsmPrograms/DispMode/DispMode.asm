;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; DispMode.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;调用BIOS的ＩＮＴ　１０Ｈ设置显示方式
;图形适配器有两种操作方式：文本方式和图形方式，文本方式是图形适配器的
;默认方式。显示器一旦设置成图形方式，光标即消失

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax
	
	call	SetVGAMode

	ret
main endp

SetTextMode proc near

	mov	ah, 00h		;Request set mode
	mov	al, 03h		;color text
	int	10h		;BIOS video ROM call 

	ret
SetTextMode endp

SetVGAMode proc near

	mov	ah, 00h		;Request set mode
	mov	al, 12h		;color graphics
	int	10h		;BIOS video ROM call 

	ret
SetVGAMode endp

code ends

	end start