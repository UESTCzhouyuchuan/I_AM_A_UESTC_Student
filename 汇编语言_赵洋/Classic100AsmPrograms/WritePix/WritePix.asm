;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; SetMode.asm
;--------------------------------------------------------------------
;写像素的例程
;ＶＧＡ 12h模式下写一个单一像素点和像素掩码到显存

code segment

main proc far
	assume	cs:code
start:
	push	ds
	sub	ax, ax
	push	ax

	mov	al, 2
	call	SetWriteMode

	mov	ax, 0a000h
	mov	es, ax
	mov	bx, 200h
	mov	al, 2
	mov	ah, 0ffh
	call	WritePixel

	ret
main endp

;VGA mode 12h device driver for writting an individual pixel
;or a pixel pattern to the graphics screen
;INPUT:
;ES = 0a000h
;BX = byte offset into the video buffer
;AL = pixel color in IRGB format
;AH = bit pattern to set
;this routine assumes that write mode 2 has been set
WritePixel	proc near
	push	dx	;save outer loop counter
	push	ax	;color byte
	push	ax	;twice

	;set bit mask requster according to mask in AH
	mov	dx, 3ceh	;Graphics controller latch
	mov	al, 8
	out	dx, al		;select data register 8
	jmp	short $+2
	inc	dx		;to 3cfh
	pop	ax		;ax once from stack
	mov	al, ah		;bit pattern
	out	dx, al		;load bit mask
	jmp	short $+2

	;write color code
	mov	al, es:[bx]	;dummy read to load latch register
	pop	ax		;restore color code
	mov	es:[bx], al	;write the pixel with the color code in al
	pop	dx		;restore outer loop counter
	ret

WritePixel	endp

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