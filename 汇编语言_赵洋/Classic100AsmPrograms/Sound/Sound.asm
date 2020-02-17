;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Sound.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;过程Sound是一个发声函数

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
	in	al, 61h           ;取得设备控制器的开关量
	and     al, 11111100B     ;将第０，１位置０，２---７位保持不变
trig:
	xor	al, 2		  ;将第１位置１，第２次循环时将第１位置０，也就是关闭了扬声器
	out	61h, al		  ;把这个开关量输出到６１Ｈ端口以控制接通扬声器
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