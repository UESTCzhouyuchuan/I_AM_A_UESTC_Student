;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Sound.asm
;��������������������������������������������������������������������
;����Sound��һ����������

stack   segment stack
	db	100   dup(?)
stack   ends

code segment
	assume cs:code,ds:code,ss:stack

main proc near
start:
	mov	ax, code
	mov	ds, ax
	mov	ax, stack
	mov	ss, ax

@next:
	mov	bx, 32767
	mov	cx, 1000
	call	Sound
	call	Sleep
	jmp	@next

	mov	ax, 4c00h
	int	21h
main endp

Sound	proc near
	push	ax
	push	dx

	mov	dx, cx
	in	al, 61h           ;ȡ���豸�������Ŀ�����
	and     al, 11111100B     ;���ڣ�����λ�ã�����---��λ���ֲ���
trig:
	xor	al, 2		  ;���ڣ�λ�ã����ڣ���ѭ��ʱ���ڣ�λ�ã���Ҳ���ǹر���������
	out	61h, al		  ;���������������������ȶ˿��Կ��ƽ�ͨ������
	mov	cx, bx
delay:
	loop	delay
	dec	dx
	jne	trig

	pop	dx
	pop	ax
	ret

Sound	endp

Sleep	proc	near

	mov	bx, 32767
Loop1:
	mov	cx, 32767
Loop2:
	loop	loop2
	dec	bx
	mov	cx, bx
	loop	loop1

	ret
Sleep	endp

code ends

	end  start