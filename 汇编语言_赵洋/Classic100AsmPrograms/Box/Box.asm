;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Box.asm
;--------------------------------------------------------------------
;在屏幕上画一个方框，方框的大小和在屏幕上的位置是随意的，通过寄存器
;把方框的参数传递给画方框的函数Box
;假定已经设定的显示方式为VGA 13H方式即：
;（256色，320*200）即水平方向80字节，竖直放心50字节

code segment

main proc far
	assume	cs:code
start:
	push	ds
	sub	ax, ax
	push	ax

	call	SetMode

	mov	ax, 50
	mov	cx, 20
	mov	si, 30
	mov	bp, 40
	call	Box

	ret
main endp

;设置显示器为256色，320*200模式，即VGA 13H方式
SetMode proc near
	mov	ah, 00h
	mov	al, 13h
	int	10h
	ret
SetMode endp

;在屏幕上任意位置显示一个方框的函数
;INPUT:
;AX = color (0 至 255)
;CX = start column (0 至 319)
;SI = start row (0 至 199)
;BP = box size
Box proc near

	mov	bx, 0a000h	;video address
	mov	es, bx
	push	ax		;saving color
	mov	ax, 320		;calc start pixel
	mul	si
	mov	di, ax
	add	di, cx
	pop	ax
	push	di		;saving start offset
	mov	cx, bp

BOX1:
	rep	stosb		;drawing top line, ds:si -> es:di
	mov	cx, bp
	sub	cx, 2		;update cx

BOX2:
	pop	di
	add	di, 320		;point to the next row
	push	di
	stosb			;drawing the left side
	add	di, bp
	sub	di, 2
	stosb			;drawing the right side
	loop	BOX2

	pop	di
	add	di, 320		;point to the last row
	mov	cx, bp
	rep	stosb		;drawing bottom line
	
	ret
Box endp

code ends

	end start