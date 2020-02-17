;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ByteImg.asm
;--------------------------------------------------------------------
;以水平8个像素为1列，以垂直8个像素为1行的行列坐标，编写计算读写像素的
;字节地址的函数CalcByteAddr。假定已经设定的显示方式为VGA 12H方式即：
;（16色，640*480）即水平方向80字节，竖直放心60字节

code segment

main proc far
	assume	cs:code
start:
	push ds
	sub  ax, ax
	push ax

	mov  ch, 10
	mov  cl, 20
	call CalcByteAddr

	ret
main endp

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

code ends

	end start