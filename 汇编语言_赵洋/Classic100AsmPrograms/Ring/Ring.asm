;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Ring.asm
;��������������������������������������������������������������������
;����һ���жϴ�����������������й����У�ÿ��������������һ�Σ�ͬʱ
;����Ļ����ʾ����Ϣ��The bell is ring!��

;��ϵͳ��ʱ�����ж�����Ϊ�������жϴ�������У���һ���ж�ָ��
;�ɣΣԡ����ã�, ʱ���ж�ÿ����һ�Σ�Լÿ�룱��.���Σ���ҪǶ�׵���
;һ���ж����ͣ��ãȵĴ�������ڣңϣ͡��£ɣϣ������У����ãȵĴ���
;����ֻ��һ���ɣңţ�ָ�ʵ��������û�����κι�����ֻ��Ϊ�û��ṩ��
;һ���ж����ͺš�����û���ĳ�ֶ�ʱ�����ԵĹ�����Ҫ��ɣ��Ϳ�������
;ϵͳ��ʱ�����жϼ�������Լ���ƵĴ������������ԭ�еģ��ã��жϳ���
;���ã���Ϊ�û�ʹ�õ��ж����ͣ������Ѿ����������ܵĳ��������ã�������
;��д�µ��жϳ���ʱ��Ӧ������������
;(1)��������ĳ�ʼ�����֣��ȱ��浱ǰ���ãȵ��ж����������������ж�����
;(2)��������Ľ������ָֻ����ֵģ��ã��ж�����


stack segment stack
	db   4096   dup(?)
tos	label	word
stack ends

data segment
	count	dw	1
	msg	db	'The bell is ringing!',0dh,0ah,'$'
data ends

code segment
	assume cs:code, ds:data, ss:stack

main proc far
start:
	mov	ax, data
	mov	ds, ax

	mov	ax, stack
	mov	ss, ax
	mov	sp, offset tos

	;����ɵģ��ã��ж�����
	mov	al, 1ch
	mov	ah, 35h
	int	21h
	push	es
	push	bx	;�������жϷ��ص��ж������ڣţӣ��£���

	push	ds	;�ȱ��棬�ٻָ��������У���Ϊ�������ж�����ʱҪ�õ��ģ�

	;�������ж�����
	mov	dx, offset ring
	mov	ax, seg	ring
	mov	ds, ax
	mov	al, 1ch
	mov	ah, 25h		;���ж������ڣģӣ��ģ���
	int	21h

	pop	ds
	in	al, 21h
	and	al, 11111110B	;�����豸���ж�����λ������ʱ���жϣ������жϲ��ı�
	out	21h, al
	
	sti			;���жϣ����������豸������ж�

	call	Sleep

	;�ָ����ж�����
	pop	dx
	pop	ds
	mov	al, 1ch
	mov	ah, 25h
	int	21h

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
Sleep	endp

ring proc near
	push	ds
	push	ax
	push	cx
	push	dx

	mov	ax, data
	mov	ds, ax

	sti			;���жϣ����������豸������ж�

	dec	count
	jnz	exit

	mov	dx, offset msg
	mov	ah, 09h
	int	21h

	mov	dx, 1000
	in	al, 61h		;ȡ���豸�������Ŀ�����
	and	al, 11111100B	;���ڣ�����λ�ã�����---��λ���ֲ���

sound:
	xor	al, 02		;���ڣ�λ�ã����ڣ���ѭ��ʱ���ڣ�λ�ã���Ҳ���ǹر���������
	out	61h, al		;���������������������ȶ˿��Կ��ƽ�ͨ������

	mov	cx, 32767
wait1:
	loop	wait1

	dec	dx
	jne	sound
	mov	count, 18	;182Ϊÿ��������һ��,����д������Լ��ÿ����һ��

exit:
	cli
	pop	dx
	pop	cx
	pop	ax
	pop	ds
	iret
ring endp

code ends

	end start