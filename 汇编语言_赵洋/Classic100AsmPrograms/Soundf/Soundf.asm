;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Soundf.asm
;--------------------------------------------------------------------
;编写通用发声程序，它能利用定时器发出指定频率的声音
;这个程序是比较简单的，如果想演奏另一个乐曲，只需要把music_freq和
;music_time两个表中的数据换成另一个乐曲的频率和节拍时间就可以了

data segment
;	mus_freq	dw	330,294,262,294,3 dup(330)
;			dw	3 dup(294),330,392,392
;			dw	330,294,262,294,4 dup(330)
;			dw	294,294,330,294,262,-1
;	mus_time	dw	6 dup(25),50
;			dw	2 dup(25,25,50)
;			dw	12 dup(25),100
	;<<太湖船>>
;	mus_freq	dw	330,392,330,294,330,392,330,294,330
;			dw	330,392,330,294,262,294,330,392,294
;			dw	262,262,220,196,196,220,262,294,330,262
;			dw	-1
;	mus_time	dw	3 dup(50),25,25,50,25,25,100
;			dw	2 dup(50,50,25,25),100
;			dw	3 dup(50,25,25),100

	;<<世上只有妈妈好>>
	mus_freq	dw	440,392,330,392,523,440,392,440 
			dw	330,392,440,392,330,262,440,392,330,294 
			dw	294,330,392,392,440,330,294,262 
			dw	392,330,294,262,440,262,196 
			dw	-1 
	mus_time	dw	5 dup(50),2 dup(20),100 
			dw	50,2 dup(20),2 dup(50),4 dup(20),100 
			dw	3 dup(50),2 dup(20),2 dup(50),100 
			dw	2 dup(50),4 dup(20),100

	;<<祝贺大家新年好>>
;	mus_freq	dw	262,262,262,196,330,330,330,262,262,330,392,392 
;			dw	349,330,294,294,330,349,349,330,294,262,330 
;			dw	262,330,294,193,247,294,262 
;			dw	-1 
;	mus_time	dw	12 dup(50) 
;			dw	2 dup(50),100,8 dup(50)
;			dw	6 dup(50),100

	;<<两只老虎>>
;	mus_freq	dw	262,294,330,262,262,294,330,262
;			dw	330,349,392,330,349,392,392,440
;			dw	392,349,330,262,392,440,392,349
;			dw	330,262,294,196,262,294,196,262,-1
;	mus_time	dw	25,25,25,25,25,25,25,25,25,25
;			dw	50,25,25,50,12,12,12,12,25,25
;			dw	12,12,12,12,25,25,25,25,50,25,25,50
data ends

code segment

main proc far
	assume	cs:code, ds:data
start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	lea	si, mus_freq		;puts the freq table offset in si
	lea	bp, ds:mus_time		;puts the time table offset in bp

@Frequency:
	mov	di, [si]		;read next frequency
	cmp	di, -1			;end of tone?
	je	@EndMusic		;if yes, exit
	mov	bx, ds:[bp]		;else, fetch the duration
	call	Soundf			;play the note
	add	si, 2			;update the table pointer
	add	bp, 2
	jmp	@Frequency

@EndMusic:
	ret
main endp


Soundf proc near
	
	push	ax
	push	bx
	push	cx
	push	dx
	push	di
	mov	al, 0b6h		;write timer mode reg
	out	43h, al
	mov	dx, 12h			;timer divisor
	mov	ax, 348ch		;1193100Hz/freq
	div	di			;value of freq
	out     42h, al			;write timer 2 count low byte
	mov	al, ah
	out	42h, al			;write timer 2 count high byte
	in	al, 61h			;get current port setting
	mov	ah, al			;and save it in ah
	or	al, 3			;turn speeker on
	out	61h, al

@Next:
	mov	cx, 663
	call	Waitf
	dec	bx
	jnz	@Next

	mov	al, ah			;recover value of port
	out     61h, al
	pop	di			;recover the register
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	
	ret

Soundf endp

;Waitf函数，产生Ｎ×１５.０８ｕｓ时间延迟的程序
;ＣＸ必须装入１５.０８ｕｓ的倍数Ｎ
;INPUT:
;CX = Count of 15.08us
Waitf proc near
	push	ax
@Waitf:
	in	al, 61h
	and	al, 10h			;check PB4
	cmp	al, ah			;did it just change
	je	@Waitf			;wait for change
	mov	ah, al			;save new PB4 status
	loop	@Waitf			;continue until cx becomes 0
	
	pop	ax
	ret
Waitf endp

code ends

	end start