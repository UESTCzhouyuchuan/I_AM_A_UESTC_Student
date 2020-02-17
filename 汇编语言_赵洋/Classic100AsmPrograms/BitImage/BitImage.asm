;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; BitImage.asm
;--------------------------------------------------------------------
;显示图形设计成位印象的图样，并对图样的位模式及颜色进行编码，这些编码
;作为数据，放在程序的数据段。本例给出了"十"和"鸭子"的位印象图。
;要注意的是用来描述图形的数据结构必须符合显示例程的要求。

data segment
	cross_x	  dw	320	;present x coordinate, 0--630
	cross_y	  dw	360	;present y coordinate, 360--460
		  db	15	;horizontal rows in block
		  db	2	;number of bytes per row

		  ;symbol encoding of cross-hair symbol
		  db	07h,0e0h,11h,10h,21h,08h,41h,04h,81h,02h
		  db	81h,02h,81h,02h,0ffh,0ffh,81h,02h,81h,02h
		  db	81h,02h,41h,04h,21h,08h,11h,10h,07h,0e0h
		  dw	0000h	;safety padding

	;color encoding of cross-hair symbol
	cr_col	  db	0,0,0,0,0,0fh,0fh,0fh,0fh,0fh,0fh,0,0,0,0,0
		  db	0,0,0,0fh,0,0,0,0fh,0,0,0,0fh,0,0,0,0
		  db	0,0,0fh,0,0,0,0,0fh,0,0,0,0,0fh,0,0,0
		  db	0,0fh,0,0,0,0,0,0fh,0,0,0,0,0,0fh,0,0
		  db	0fh,0,0,0,0,0,0,0ch,0,0,0,0,0,0,0fh,0
		  db	0fh,0,0,0,0,0,0,0ch,0,0,0,0,0,0,0fh,0
		  db	0fh,0,0,0,0,0,0,0ch,0,0,0,0,0,0,0fh,0
		  db	0fh,0,0,0,0,0,0,0ch,0,0,0,0,0,0,0fh,0
		  db	0fh,0fh,0fh,0fh,0ch,0ch,0ch,0,0ch,0ch,0ch,0fh,0fh,0fh,0fh,0
		  db	0fh,0,0,0,0,0,0,0ch,0,0,0,0,0,0,0fh,0
		  db	0fh,0,0,0,0,0,0,0ch,0,0,0,0,0,0,0fh,0
		  db	0fh,0,0,0,0,0,0,0ch,0,0,0,0,0,0,0fh,0
		  db	0,0fh,0,0,0,0,0,0fh,0,0,0,0,0,0fh,0,0
		  db	0,0,0fh,0,0,0,0,0fh,0,0,0,0,0fh,0,0,0
		  db	0,0,0,0fh,0,0,0,0fh,0,0,0,0fh,0,0,0,0
		  db	0,0,0,0,0,0fh,0fh,0fh,0fh,0fh,0fh,0,0,0,0,0

	;block control area for duck
	duck_x    dw	620		;present x coordinate
	duck_y	  dw    410		;y coordinate
		  db	9		;horizontal rows in block
		  db	2		;number of bytes per row

		  ;symbol encoding for duck
		  db	0eh,00h,1fh,03h,3fh,07h,7fh,0fh,0ffh,0ffh
		  db	1fh,0feh,3fh,0feh,7fh,0ffh,7fh,0ffh
		  dw	0000h

	;color encoding of duck symbol
	duck_col  db	0,0,0,0,0fh,0fh,0fh,0,0,0,0,0,0,0,0,0
	          db	0,0,0,0fh,0fh,0fh,0fh,0fh,0,0,0,0,0,0,0fh,0fh
		  db	0,0,0fh,0fh,0fh,0fh,0fh,0fh,0,0,0,0,0,0fh,0fh,0fh
		  db	0,0fh,0fh,0fh,0fh,0fh,0fh,0fh,0,0,0,0,20 dup(0fh)
		  db	0,0,0,12 dup(0fh),0,0,0,13 dup(0fh),0,0,15 dup(0fh)
		  db	0,15 dup(0fh)
		  dw	0000h			;safety padding
	x_coord   dw	0000h			;storage for x coordinate
	bytes	  db    0h			;number of bytes per block row
	count_8   db    8			;operational bit counter
data ends

code segment

main proc far
	assume	cs:code
start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax


	call	ShowBitImage

	ret
main endp

;display an encoded graphics block
;INPUT:
;SI = Start of control area of graphics block to be displayed
;BX = Start of block holding color codes
;register setup
;CX = x coordinate of block start
;DX = y coordinate of block start
;BL = number of rows in block
;BH = number of bytes per blcok row
;DI = start of encoded graphics block
;SI = start of encoded color codes
ShowBitImage proc near
	
	call	DataXor			;set the data rotate register to the XOR mode
	push	bx			;save pointer in stack
	mov	cx, word ptr [si]	;x coordinate
	mov	x_coord, cx		;store in variable
	add	si, 2			;bump pointer
	mov	dx, word ptr [si]	;y coordinate
	add	si, 2			;bump pointer
	mov	bl, byte ptr [si]	;number of rows
	inc	si			;bump pointer
	mov	bh, byte ptr [si]	;bytes per block
	mov	bytes, bh		;store in variable
	inc	si			;bump pointer
	xchg	si, di			;buffer start to di
	pop	si			;color code block pointer
	mov	count_8, 8		;prime bit counter

DisplayByte:
	mov	ah, [di]		;high-order nibble to ah

TestBit:
	test	ah, 10000000B		;is high-order bit set?
	jz	NextBit			;bit not set
	mov	al, [si]		;get color code

	;set the pixel
	push	ax			;save entry reqisters
	push	bx

	call	GetByteMask
	call	WritePixel
	pop	bx
	pop	ax

NextBit:
	sal	ah, 1			;shift ah to test next bit
	inc	cx			;bump x coordinate counter
	inc	si			;bumo color table pointer
	dec	count_8			;bit counter
	jz	NextBit			;exit if counter rewound
	jmp	TestBit			;continue

	;index to next byte in row, if not an end of row
NextByte:
	dec	bh			;bytes per row counter
	jz	NextRow			;End of graphics row

ByteEntry:
	inc	di			;bump graphics code pointer
	mov	count_8, 8		;reset bit counter
	jmp	DisplayByte

	;index to next row
NextRow:
	
	;test for last graphic row
	dec	dl			;row counter
	jz	GraphEnd		;done,exit
	mov	bh, bytes		;reset bytes counter
	inc	dx			;bump y coordinate control
	mov	cx, x_coord		;reset x coordinate control
	jmp	ByteEntry

GraphEnd:
	call	DataNormal		;set the data rotate register to the normal mode

	ret
ShowBitImage endp

;设置数据循环寄存器为正常方式
;set the graphics controller data rotate register to the normal mode
DataNormal proc near

	mov	dx, 03ceh		;graphics controller port address
	mov	al, 3			;select data rotate register
	out	dx, al			
	jmp	short $+2
	inc	dx			;03cfh register
	mov	al, 00000000B		;reset bits 3 and 4 for normal
	out	dx, al
	jmp	short $+2

	ret
DataNormal endp

;设置数据循环寄存器为异或方式
;set the graphics controller data rotate register to the XOR mode
DataXor proc near

	mov	dx, 03ceh		;graphics controller port address
	mov	al, 3			;select data rotate register
	out	dx, al			
	jmp	short $+2
	inc	dx			;03cfh register
	mov	al, 00011000B		;set bits 3 and 4 for XOR
	out	dx, al
	jmp	short $+2
	ret
DataXor endp


;计算像素的字节位置和位掩码的子程序
;INPUT:
;CX = 水平像素偏移量 （0 至 639）
;DX = 竖直像素偏移量 （0 至 479）
;OUTPUT:
;BX = 显存的内存偏移地址
;AH = 位掩码
;计算公式：
;BX = (DX * 80) + CX/8
;AH = 10000000B >> ( CX mode 8 )
GetByteMask proc near

	push	cx	;save all entry registers
	push	dx

	;compute address
	push	ax	;save accummulator
	push	cx	;save x coordinate

	mov	ax, dx	;y coordinate to ax
	mov	cx, 80	;multiplier(80 byte per row)
	mul	cx	;now, ax = y*80
	mov	bx, ax  ;now, bx = y*80, and also ax = y*80
	pop	ax	;x coordinate from stack

	;prepear for division
	mov	cl, 8
	div	cl	;AX/CL=quotient in AL and remainder in AH
	
	;add in quotient
	mov	cl, ah	;save remainder in cl
	mov	ah, 0	;clear high-order byte
	add	bx, ax	;offset into buffer to BX
	pop	ax	;

	;compute bit mask from remainder
	mov	ah, 10000000B	;unit mask for 0 remainder
	shr	ah, cl		;shift right cl times

	;restore all entry registers
	pop	dx
	pop	cx

	ret

GetByteMask endp

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

WritePixel endp

code ends

	end start