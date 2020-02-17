;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Print3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;调用BIOS 17h功能0打印字符串
;利用BIOS的int 17h功能0来把一个字符送到打印机，字符必须放在ＤＬ寄存器
;中，为了连续打印，还指定了打印的字节数
;本例中text中的0ch是换页码，0dh是回车码，0ah是换行码

data segment
	text		db	0ch,'Hello everybody!',0dh,0ah,0ah
	count		equ	$-text
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
	
	call	Print

	ret
main endp

Print proc near
	mov	cx, count
	mov	bx, 0
next:
	mov	ah, 0		;request print
	mov	al, text[bx]    ;charactor to be printed
	mov	dx, 0		;select printer 0#
	int	17h		;call BIOS

	inc	bx
	loop	next

	ret
Print endp

code ends

	end start