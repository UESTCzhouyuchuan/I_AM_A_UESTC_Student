;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; SetMode.asm
;--------------------------------------------------------------------
;选择写模式的通用例程
;设置图形控制寄存器的模式选择寄存器为０，１，２，３.其中３是ＶＧＡ系统
;独有的，在ＥＧＡ中没有等同的模式

code segment

main proc far
	assume	cs:code
start:
	push ds
	sub  ax, ax
	push ax

	mov  al, 2
	call SetWriteMode

	ret
main endp

;Set the Graphics controller's graphics mode register to the desired write mode
;INPUT:
;ＡＬ = 写模式 （０ 至 ３）
;also set default bit mask:0ffh
SetWriteMode proc near

	push	ax		;save mode

	mov	dx, 3ceh	;graphics controller address register
	mov	al, 5		;offset of the mode register
	out	dx, al		;select this register
	jmp	short $+2
	mov	dx, 3cfh	;point to data register
	pop	ax		;recover mode in al
	out	dx, al		;selected
	jmp	short $+2

	;set bit mask register to default setting
	mov	dx, 3ceh	;graphics controller address register
	mov	al, 8
	out	dx, al		;select data register 8
	jmp	short $+2
	mov	dx, 3cfh	;to 3cfh
	mov	al, 0ffh	;default mask
	out	dx, al		;load bit mask
	jmp	short $+2

	ret

SetWriteMode endp

code ends

	end start