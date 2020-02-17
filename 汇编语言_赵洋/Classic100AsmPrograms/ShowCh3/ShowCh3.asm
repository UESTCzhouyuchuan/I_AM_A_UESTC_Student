;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ShowCh3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;利用DOS的int 21h功能９来显示字符串

data segment
	message		db	'Hello world!',13,10,'$'
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	call	ShowString

	ret
main endp


ShowString proc near

	mov	ah, 9
	mov	dx, seg message
	mov	ds, dx
	mov	dx, offset message
	int     21h

	ret
ShowString  endp

code ends

	end start