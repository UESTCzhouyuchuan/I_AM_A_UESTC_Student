;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Search.asm
;��������������������������������������������������������������������
;����һ���򵥵���Ϣ����ϵͳ�������ݶ�����10����ͬ����Ϣ�����Ϊ0��9
;ÿ����Ϣ����30���ַ���������ʵ�ִӼ��̽���0��9֮��ı�ţ�Ȼ������Ļ
;����ʾ����Ӧ��ŵ���Ϣ����

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

