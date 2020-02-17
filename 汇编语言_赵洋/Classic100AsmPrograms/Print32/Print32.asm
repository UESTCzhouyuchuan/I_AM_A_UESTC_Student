;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Print32.asm
;��������������������������������������������������������������������
;�������˼������루�ж����ͣ����ȣ��ʹ�ӡ��������ж����ͣ��ƣȣ�
;�����ⲿ�豸�ģ����أ����ж�ϵͳ�С���Ҫ�Ӽ����Ͻ����ַ���ͬʱ��
;�����ֽڵ����뻺�������в��ԣ��������������������̹��𣨽�ֹ��
;���ж����룬�ɴ�ӡ�����һ����ʾ��Ϣ��

;���̺ʹ�ӡ���ֱ����ж����μĴ����������ȣ��ģ�λ�ͣ�λ���ƣ�����
;������Ĵ����˿ڵ�ַ�ǣ����ȣ����ƼĴ����Ķ˿ڵ�ַ�ǣ����ȣ���ӡ
;������Ĵ����Ķ˿ڵ�ַΪ�������ȣ���ӡ�����ƼĴ����Ķ˿ڵ�ַΪ��������


stack segment stack
	db   4096   dup(?)
tos	label	word
stack ends

data segment
	old_ip09	dw	?
	old_cs09	dw	?
	old_ip0f	dw	?
	old_cs0f	dw	?
	count		dw	?
	buffer		db	20h dup(' ')
	buf_p		dw	?
	start_msg	db	0ah,0dh,'RUN',0ah,0dh,'$'
	end_msg		db	0ah,0dh,'END',0ah,0dh,'$'
	full_msg	db	'Buffer full!',0ah,0dh,0
data ends

code segment
	assume cs:code, ds:data, ss:stack

main	proc	far
start:
	mov	ax, data
	mov	ds, ax

	mov	ax, stack
	mov	ss, ax
	mov	sp, offset tos

	;Initialize
	lea	ax, buffer
	mov	buf_p, ax
	mov	count, 0

	;save old interrupt 09h
	mov	al, 09h
	mov	ah, 35h
	int	21h
	mov	old_cs09, es
	mov	old_ip09, bx

	push	ds

	;set new interrupt 09h
	lea	dx, KeybdInt
	mov	ax, seg KeybdInt
	mov	ds, ax
	mov	al, 09h
	mov	ah, 25h
	int	21h

	pop	ds

	;set KeybdInt interrupt mask bits
	in	al, 21h
	and	al, 11111101B	;�ж����μĴ�������������жϣ��������ı�
	out	21h, al

	;save old interrupt 0fh
	mov	al, 0fh
	mov	ah, 35h
	int	21h
	mov	old_cs0f, es
	mov	old_ip0f, bx

	push	ds

	;set new interrupt 0fh
	lea	dx, PrintInt
	mov	ax, seg PrintInt
	mov	ds, ax
	mov	al, 0fh
	mov	ah, 25h
	int	21h

	pop	ds

	mov	ah, 09h
	lea	dx, start_msg
	int	21h

	sti

	;ѭ����ʱ
	call	Sleep

	mov	ah, 09h
	lea	dx, end_msg
	int	21h

	cli

	;restore old interrupt 09h
	push	ds
	mov	dx, old_ip09
	mov	ax, old_cs09
	mov	ds, ax
	mov	al, 09h
	mov	ah, 25h
	int	21h
	pop	ds

	;restore old interrupt 0fh
	push	ds
	mov	dx, old_ip0f
	mov	ax, old_cs0f
	mov	ds, ax
	mov	al, 0fh
	mov	ah, 25h
	int	21h
	pop	ds

	;set KeyBoard interrupt mask bits
	in	al, 21h
	and	al, 11111101B	;�ж����μĴ�������������жϣ��������ı�
	out	21h, al

	sti
	mov	ax, 4c00h
	int	21h

main endp


Sleep proc near

	mov	cx, 10		;������Գ�������ȴ�ʱ��
Loop0:
	mov	di, 32767
Loop1:
	mov	si, 32767
Loop2:
	dec	si
	jnz	Loop2
	dec	di
	jnz	Loop1
	loop	Loop0

	ret

Sleep endp

;fill buffer until full when substituted for interrupt 09h
KeybdInt proc near
	push	ax
	push	bx

	cld
	in	al, 60h

	push	ax

	in	al, 61h
	mov	ah, al
	or	al, 10000000B
	out	61h, al
	xchg	ah, al
	out	61h, al

	pop	ax
	test	al, 10000000B	;press or release?
	jnz	return1

	mov	bx, buf_p
	mov	[bx], al
	call	DisplayHex
	inc	count
	mov	buf_p, bx

check:
	cmp	count, 20h
	jb	return1

	in	al, 21h
	or	al, 02h
	and	al, 7fh
	out	21h, al		;��ֹ�����жϣ������ӡ���жϣ��������ı�

	call	InitPrint

return1:
	cli
	mov	al, 20h	
	out	20h, al		;���ţϣ��������Ӳ���ж�

	;restore registers
	pop	bx
	pop	ax
	iret

KeybdInt endp


;print	characters when substituted interrupt 0fh
PrintInt proc near
	push	ax
	push	bx
	push	dx

	mov	bx, buf_p
	mov	al, [bx]
	mov	dx, 378h
	out	dx, al		;��һ�ַ�����ӡ�����ݼĴ���

	push	ax
	mov	dx, 37ah
	mov	al, 1dh
	out	dx, al		;ѡͨ��ӡ��
	jmp	$+2		;��ʱһС��
	mov	al, 1ch		
	out	dx, al		;���жϣ���ʼ������ͨ��ӡ��
	pop	ax

	inc	bx
	mov	buf_p, bx
	cmp	al, 0ah
	jnz	return2

	in	al, 21h		;��ֹ��ӡ���жϣ��������ı�
	or	al, 80h
	out	21h, al

return2:
	mov	al, 20h
	out	20h, al		;���ţϣ��������Ӳ���ж�

	pop	dx
	pop	bx
	pop	ax
	iret

PrintInt endp

InitPrint proc near
	push	ax
	push	bx
	push	dx

	cli
	lea	bx, full_msg
	mov	buf_p, bx

	mov	dx, 378h
	mov	al, 0dh
	out	dx, al
	
	mov	dx, 37ah
	mov	al, 1dh
	out	dx, al
	jmp	$+2
	mov	al, 1ch
	out	dx, al

	pop	dx
	pop	bx
	pop	ax
	ret
InitPrint endp

DisplayHex proc near

	push	ax
	push	cx
	push	dx

	mov	ch, 2
	mov	cl, 4
nextb:
	rol	al, cl
	push	ax
	mov	dl, al
	and	dl, 0fh
	or	dl, 30h
	cmp	dl, 3ah
	jl	dispit
	add	dl, 7h
dispit:
	mov	ah, 2
	int	21h
	pop	ax
	dec	ch
	jnz	nextb
	mov	ah, 2
	mov	dl, ','
	int	21h

	pop	dx
	pop	cx
	pop	ax
	ret

DisplayHex endp

code ends
	
	end start