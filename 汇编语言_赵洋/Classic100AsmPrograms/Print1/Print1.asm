;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Print1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;调用ＤＯＳ功能打印字符串
;利用DOS的int 21h功能5来把一个字符送到打印机，字符必须放在ＤＬ寄存器
;中，这是唯一的ＤＯＳ打印功能，为了连续打印，还指定了打印的字节数
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
	mov	ah, 5
	mov	dl, text[bx]
	int	21h
	inc	bx
	loop	next

	ret
Print endp

code ends

	end start