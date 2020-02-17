;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; FillArea.asm
;--------------------------------------------------------------------
;��VGA 640*480��ʽ�£���д���ָ����Ļ���������FillArea
;������ָ������ɫ���ĳ����Ļ����ָ����Ļλ�õ�XY��������8��ˮƽ����
;��8����ֱ����Ϊ��λ�ģ���ˣ����ǲ������ֽڼ��Ĵ���������Ϊλ����
;�Ĵ����ṩ��0ffh��λģʽ��ʹ���õĿ���д��������һ�ξ�д8������

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
;CH = ������x (0--79)
;CL = ������y (0--59)
;DL = �������� (1--60) 
;DH = ��������(1--80)
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

;�����д���ص��ֽڵ�ַ�ĺ���
;INPUT:
;CH = ˮƽƫ���� ��0 �� 79��
;CL = ��ֱƫ���� ��0 �� 59��
;OUTPUT:
;BX = �Դ���ڴ��ַ
;���㹫ʽ��
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