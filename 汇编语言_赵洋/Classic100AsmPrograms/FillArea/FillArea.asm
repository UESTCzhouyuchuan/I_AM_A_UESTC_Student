;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; FillArea.asm
;--------------------------------------------------------------------
;在VGA 640*480方式下，编写填充指定屏幕区域的例程FillArea
;本例按指定的颜色填充某块屏幕区域，指定屏幕位置的XY坐标是以8个水平像素
;和8个垂直像素为单位的，因此，这是采用了字节级的处理方法。并为位屏蔽
;寄存器提供了0ffh的位模式，使调用的快速写像素例程一次就写8个像素

code segment

main proc far
	assume	cs:code
start:
	push	ds
	sub	ax, ax
	push	ax

	call	FillArea

	ret
main endp

;Fill a screen area on a byte boundary base
;INPUT:
;CH = 横坐标x (0--79)
;CL = 纵坐标y (0--59)
;DL = 填充的行数 (1--60) 
;DH = 填充的列数(1--80)
;AL = IRGB color to use in fill area
FillArea proc near
	push	cx
	push	dx
	push	ax

	mov	ah, 0ffh		;bit pattern for all bits set
	push	ax
	call	CalcByteAddr		;get byte offset in video ROM into BX
	
	;Setup column counter in CX and row counter in DX
	mov	cl, dh			;horizontal fill
	mov	ch, 0			;cx = horizontal counter
	push	cx			;save temporarily

	;row counter = dl*8
	mov	ax, dx
	mov	ah, 0			;clear high-order byte
	mov	cl, 8			;multiplier
	mul	cl			;ax=dl*8

	;setup outer counter in dx
	mov	dx, ax
	pop	cx			;Inner loop counter
	pop	ax			;al = color, ah = 1111 1111 B, all bits set
Outer:
	push	cx			;save inner loop counter
	push	bx			;save start address
Inner:
	call	WritePixel
	inc	bx			;index to next 8-pixel block
	loop	Inner

	;Index to next column
	pop	bx			;restore start of this row
	add	bx, 80			;index to next row start
	pop	cx			;restore inner loop counter
	dec	dx			;decrement total rows
	jnz	Outer			;continue if not end of count

	;restore input registers
	pop	ax
	pop	dx
	pop	cx
	
	ret
FillArea endp

;计算读写像素的字节地址的函数
;INPUT:
;CH = 水平偏移量 （0 至 79）
;CL = 竖直偏移量 （0 至 59）
;OUTPUT:
;BX = 显存的内存地址
;计算公式：
;byte address = (CL * 640) + CH
CalcByteAddr proc near

	push	ax
	push	dx
	push	cx

	mov	ax, cx
	mov	ah, 0
	mov	cx, 640
	mul	cx
	pop	cx
	pop	dx

	mov	cl, ch
	mov	ch, 0
	add	ax, cx
	mov	bx, ax
	pop	ax
	ret

CalcByteAddr endp

;VGA mode 12h device driver for writting an individual pixel
;or a pixel pattern to the graphics screen
;INPUT:
;ES = 0a000h
;BX = byte offset into the video buffer
;AL = pixel color in IRGB format
;AH = bit pattern to set
;this routine assumes that write mode 2 has been set
WritePixel proc near
	push	dx		;save outer loop counter
	push	ax		;color byte
	push	ax		;twice

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

WritePixel endp

code ends

	end start