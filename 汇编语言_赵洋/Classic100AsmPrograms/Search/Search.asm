;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Search.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;这是一个简单的信息检索系统，在数据段里有10个不同的信息，编号为0～9
;每个信息包含30个字符，本程序实现从键盘接受0～9之间的编号，然后在屏幕
;上显示出相应编号的信息内容

data	segment
	thirty		db	30
	msg0		db	'I like	my IBM-PC--------------'
	msg1		db	'8086 programming is fun-------'
	msg2		db	'Time to buy more diskettes----'
	msg3		db	'This program works------------'
	msg4		db	'Turn off that printer---------'
	msg5		db	'I have more money than you----'
	msg6		db	'The PSP can be useful---------'
	msg7		db	'BASIC was easier than this----'
	msg8		db	'DOS is indispensable----------'
	msg9		db	'Last massage of the day-------'
	errmsg		db	'error!!!  invalid parameter!!!'
data	ends

stack	segment stack
	db	256	dup(0)
tos	label	word
stack	ends

code	segment
main	proc	far
	assume cs:code, ds:data, ss:stack
start:
	mov	ax, stack
	mov	ss, ax
	mov	sp, offset tos

	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

begin:
	mov	ah, 1
	int	21h
	sub	al, '0'
	jc	error
	cmp	al, 9
	ja	error

	mov	bx, offset msg0
	mul	thirty
	add	bx, ax
	call	display
	jmp	begin

error:
	mov	bx, offset errmsg
	call	display
	ret

main	endp

display	proc	near
	mov	cx, 30
disp1:
	mov	dl, [bx]
	call	dispchar
	inc	bx
	loop	disp1

	mov	dl, 0dh
	call	dispchar
	mov	dl, 0ah
	call	dispchar
	ret
display	endp

dispchar	proc	near
	mov	ah, 2
	int	21h
	ret
dispchar	endp

code ends

	end	start

