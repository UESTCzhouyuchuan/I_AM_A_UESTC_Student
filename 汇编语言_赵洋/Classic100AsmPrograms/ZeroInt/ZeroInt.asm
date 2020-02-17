;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ZeroInt.asm
;��������������������������������������������������������������������
;����Ϊ��ʱ������жϴ�����򣬳�ʼ�����֣ɣ��������µģ����ж�����
;��ʾһ����Ϣ��Ȼ�������ֹ��פ�����˳���������������˳�����
;�ɣΣԡ������ȵĹ��ܣ����ȣ���������������ռ�õ��ڴ棬�Ӷ�ʹ��Щ�ڴ�
;��Ԫ�����Ժ��Ӧ�ó����ƻ�

code segment
	assume cs:code

main proc near
start:
	;reset interrupt vector 0
	lea	dx, ZeroInt
	mov	ax, seg ZeroInt
	mov	ds, ax
	mov	al, 0
	mov	ah, 25h
	int	21h

	;print introduction message
	mov	ax, code
	mov	ds, ax
	mov	dx, offset ok_msg
	mov	ah, 09h
	int	21h

	;simulate zero_division condition
	mov	ax, 1
	mov	dl, 0
	div	dl

	;display '#' after return from interrupt handler interrupt
	mov	ah, 2
	mov	dl, '#'
	int	21h

	;exit and reside in memory
	mov	ah, 31h
	mov	al, 0
	mov	dx, ((prog_len+15)/16)+16
	int	21h

main endp

ZeroInt	proc far
	push	ax
	push	bx
	push	cx
	push	dx
	push	si
	push	di
	push	bp
	push	ds
	push	es
	
	sti

print_warn:
	mov	ax, code
	mov	ds, ax
	mov	ax, offset warn_msg
	mov	ah, 9
	int	21h
input:
	mov	ah, 1
	int	21h
	cmp	al, 'c'
	je	continue
	cmp	al, 'q'
	je	exit

	mov	dx, offset beep
	mov	ah, 09
	int	21h
	jmp	print_warn

exit:
	mov	ax, 4cffh
	int	21h
continue:
	mov	dx, offset crlf
	mov	ah, 09
	int	21h
	cli

	pop	es
	pop	ds
	pop	bp
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	iret

ZeroInt	endp

;data area
ok_msg		db	0dh,0ah,'Zero-division Handler installed!'
		db	0dh,0ah,'$'
warn_msg	db	'Zero-division detected,',07h
		db	'Continue or Quit(c/q)? $'
beep		db	07h,'$'
crlf		db	0dh,0ah,'$'
prog_len	equ	$-main

code ends

	end start