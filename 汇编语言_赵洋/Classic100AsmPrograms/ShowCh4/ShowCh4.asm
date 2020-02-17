;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ShowCh4.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;利用DOS的int 21h功能９来显示字符串,一定要在显示串之后加上定界符'$'
;丢失定界符可能会在屏幕上引起意想不到的后果

;macro parameter str_addr = string address
PRINT_STRING MACRO str_addr
	push	dx
	push	ax

	mov	dx, offset str_addr
	mov	ah, 09
	int	21h

	pop	ax
	pop	dx
ENDM

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
	
	PRINT_STRING message

	ret
main endp

code ends

	end start