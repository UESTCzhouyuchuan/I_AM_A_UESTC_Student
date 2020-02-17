;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; TestRed.asm
;--------------------------------------------------------------------
;在图形方式12h下，测试屏幕上第一行中是否含有红色像素测试结果保存在
;szResult中。VGA 12H方式即：16色，640*480, 水平80字节，竖直60字节

data segment
	szResult	db	640 dup(?)
data ends

code segment

main proc far
	assume	cs:code, ds:data
start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	call TestRed

	ret
main endp

TestRed proc near

	mov	ax, 0a000h	;VGA graphics mode start address
	mov	es, ax

	;graphics controller set to read mode 1
	mov	dx, 3ceh	;graphics controller address register
	mov	al, 5		;select read type register
	out	dx, al		;activate
	inc	dx		;controller register is at 3cfh
	mov	al, 00001000B	;set bit 3 for read mode 1
	out	dx, al

	;set color compare register
	mov	dx, 3ceh	;graphics controller address register
	mov	al, 2		;select color compare
	out	dx, al

	inc	dx		;write to color compare register
	mov	al, 00000100B	;red color
	out	dx, al		;color loaded

	;set color don't care register
	mov	dx, 3ceh	;graphics controller address register
	mov	al, 7		;select color don't care
	out	dx, al

	inc	dx		;write to color don't care
	mov	al, 00001111B	;all of 4 bit planes
	out	dx, al

	;reset address in bx
	mov	bx, 0		;byte offset in video buffer
	mov	si, 0		;pointer to szResult

	;read pixel into al
ReadPixel:
	mov	al, es:[bx]		;read byte in video buffer
	mov	szResult[si], al	;result in szResult
	inc	bx
	inc	si
	cmp	bx, 80			;end of row?
	jnz	ReadPixel		;read next byte in video buffer

	ret

TestRed endp

code ends

	end start