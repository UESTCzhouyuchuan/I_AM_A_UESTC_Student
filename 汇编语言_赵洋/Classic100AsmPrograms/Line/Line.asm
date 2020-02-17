;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Line.asm
;--------------------------------------------------------------------
;������(50,100)��ʼ������(50,200)������һ����ֱ��

code segment

main proc far
	assume	cs:code
start:
	push	ds
	sub	ax, ax
	push	ax

	call	ClearScreen

	mov	ah, 0		;set mode function
	mov	al, 06		;640*200 in graphics mode
	int	10h		;call BIOS routine


	mov	cx, 50
	mov	dx, 100
	mov	si, 50
	mov	di, 200
	call	DrawVerticalLine

	ret
main endp

ClearScreen proc near

	mov	ax, 0600h	;scroll the screen
	mov	bh, 07		;normal attribute
	mov	cx, 0		;from (0, 0)
	mov	dx, 184fh	;to (18h, 4fh)
	int	10h		;clear the screen

	ret
ClearScreen endp

;��һ��ˮƽ��
;INPUT:
;CX = ���X����
;DX = ���Y����
;SI = �յ�X����
;DI = �յ�Y����
;��(CX, DX) - (SI, DI)
DrawHorizontalLine proc near
	
@@:
	mov	ah, 0ch		;to draw a line
	mov	al, 01		;pixels = white
	mov	bh, 0		;page 0
	int	10h		;call BIOS routine
	
	inc	cx		;next dot
	cmp	cx, si		;end of line?
	jnz	@@		;no, continue

	ret

DrawHorizontalLine endp


;��һ����ֱ��
;INPUT:
;CX = ���X����
;DX = ���Y����
;SI = �յ�X����
;DI = �յ�Y����
;��(CX, DX) - (SI, DI)
DrawVerticalLine proc near
	
next:
	mov	ah, 0ch		;to draw a line
	mov	al, 01		;pixels = white
	mov	bh, 0		;page 0
	int	10h		;call BIOS routine
	
	inc	dx		;next dot
	cmp	dx, di		;end of line?
	jnz	next		;no, continue

	ret

DrawVerticalLine endp

code ends

	end start