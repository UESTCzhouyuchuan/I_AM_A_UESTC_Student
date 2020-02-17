;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; CharAddr.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;计算屏幕上某一个字符位置所对应的显存地址

;INPUT:
;DH = row
;DL = col
;OUTPUT:
;DI = char_offset
VIDEO_ADDR Macro width, page_num
	push	ax
	mov	al, width
	mul	dh
	xor	dh, dh
	add	ax, dx
	shl	ax, 1
	add	ax, page_num * 1000h
	mov	di, ax
	pop	ax
endm

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax
	
	mov	dh, 1
	mov	dl, 1
	VIDEO_ADDR 20, 1
	ret

main endp

code ends

	end start