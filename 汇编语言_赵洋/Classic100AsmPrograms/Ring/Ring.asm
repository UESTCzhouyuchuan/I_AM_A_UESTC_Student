;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Ring.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;这是一个中断处理程序。在主程序运行过程中，每隔１０秒钟响铃一次，同时
;在屏幕上显示出信息“The bell is ring!”

;在系统定时器（中断类型为８）的中断处理程序中，有一条中断指令
;ＩＮＴ　１ＣＨ, 时钟中断每发生一次（约每秒１８.２次）都要嵌套调用
;一次中断类型１ＣＨ的处理程序。在ＲＯＭ　ＢＩＯＳ例程中，１ＣＨ的处理
;程序只有一条ＩＲＥＴ指令，实际上它并没有做任何工作，只是为用户提供了
;一个中断类型号。如果用户有某种定时周期性的工作需要完成，就可以利用
;系统定时器的中断间隔，用自己设计的处理程序来代替原有的１ＣＨ中断程序
;１ＣＨ作为用户使用的中断类型，可能已经被其他功能的程序所引用，所以在
;编写新的中断程序时，应做下述工作：
;(1)在主程序的初始化部分，先保存当前１ＣＨ的中断向量，再设置新中断向量
;(2)在主程序的结束部分恢复保持的１ＣＨ中断向量


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

	;保存旧的１ＣＨ中断向量
	mov	al, 1ch
	mov	ah, 35h
	int	21h
	push	es
	push	bx	;３５Ｈ中断返回的中断向量在ＥＳ：ＢＸ中

	push	ds	;先保存，再恢复见４８行，因为设置新中断向量时要用到ＤＳ

	;设置新中断向量
	mov	dx, offset ring
	mov	ax, seg	ring
	mov	ds, ax
	mov	al, 1ch
	mov	ah, 25h		;新中断向量在ＤＳ：ＤＸ中
	int	21h

	pop	ds
	in	al, 21h
	and	al, 11111110B	;设置设备的中断屏蔽位，允许定时器中断，其他中断不改变
	out	21h, al
	
	sti			;开中断，允许其他设备请求的中断

	call	Sleep

	;恢复旧中断向量
	pop	dx
	pop	ds
	mov	al, 1ch
	mov	ah, 25h
	int	21h

	mov	ax, 4c00h
	int	21h
main endp

Sleep proc near

	mov	cx, 10		;这里可以程序调整等待时间
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

	sti			;开中断，允许其他设备请求的中断

	dec	count
	jnz	exit

	mov	dx, offset msg
	mov	ah, 09h
	int	21h

	mov	dx, 1000
	in	al, 61h		;取得设备控制器的开关量
	and	al, 11111100B	;将第０，１位置０，２---７位保持不变

sound:
	xor	al, 02		;将第１位置１，第２次循环时将第１位置０，也就是关闭了扬声器
	out	61h, al		;把这个开关量输出到６１Ｈ端口以控制接通扬声器

	mov	cx, 32767
wait1:
	loop	wait1

	dec	dx
	jne	sound
	mov	count, 18	;182为每１０秒响一次,这里写１８大约是每秒响一次

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