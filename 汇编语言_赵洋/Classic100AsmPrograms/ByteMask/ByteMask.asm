;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ByteMask.asm
;--------------------------------------------------------------------
;计算像素的字节位置和位掩码的子程序。
;假定已经设定的显示方式为VGA 12H方式即：（16色，640*480）
;即水平方向80字节，竖直放心60字节。这是VGA 12H的一个典型例程，根据指
;定像素的x坐标（0-639）和y坐标（0-479），计算显存中的字节地址，以及
;用于分离单个像素的位掩码，对于写模式0和2，这个位掩码必须放入图形控
;制器的位屏蔽寄存器中。
;确定位掩码一般有两种方法：
;1)通关对一个基本位模式(10000000B)右移来获得掩码，移位次数是x坐标除以
;8得到的余数。例如像素(18，0),X/8的余数是2，所以移位次数是2，获得的
;位掩码是00100000B
;2)用这个余数作为索引值，去查一个包含有8个掩码的表，索引0对应10000000B
;索引1对应01000000B,... ... 依此类推。
;本例采用了右移基本位模式来完成像素掩码的计算

code segment

main proc far
	assume	cs:code
start:
	push ds
	sub  ax, ax
	push ax

	mov  cx, 100
	mov  dx, 200
	call GetByteMask

	ret
main endp

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

code ends
	end start