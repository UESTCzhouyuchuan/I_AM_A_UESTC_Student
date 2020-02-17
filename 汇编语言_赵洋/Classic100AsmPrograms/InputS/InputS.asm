;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; InputS.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;编程：从键盘输入一行字符，要求第一个键入的字符必须是空格字符，如不是
;则退出程序，如果是，则开始接受键入的字符，并顺序存放到首地址为ＢＵＦＦＥＲ
;的缓冲区中，空格符不存入，知道接受到第２个空格符时退出程序
;

data segment
	buffer		db	512 dup(?)
	flag            db      ?
data ends

code segment
	assume cs:code, ds:data
main proc far

start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	lea	bx, buffer
	mov	flag, 0
next:
	mov	ah, 01
	int	21h
	test	flag, 01h
	jnz	follow
	cmp	al,20h
	jnz	exit
	mov	flag, 1
	jmp	next
follow:
	cmp	al, 20h
	jz	exit
	mov	[bx], al
	inc	bx
	jmp	next
exit:
	ret
main endp

code ends
	end start