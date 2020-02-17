;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; GrpText.asm
;--------------------------------------------------------------------
;图形方式下的文本显示例程

data segment
	text	db	2			;start row
		db	2			;start column
		db	10011100B		;color attribute

		db	41 dup(20h),0ffh
		db	'Hello,World!',29 dup(20h),0ffh
		db	41 dup(20h),0ffh,0ffh

		db	20h,20h,0dbh,3 dup(0dfh),0dbh,34 dup(20h),0ffh ;graphics encoding of the word Gallery using IBM character set
		
		db	20h,0dbh,0ddh,6 dup(20h),0dbh,0dfh,0dbh,20h,20h
		db	0dfh,0dbh,3 dup(20h),0dfh,0dbh,3 dup(20h),0dfh
		db	0dbh,0dfh,0dbh,20h,0dfh,0dbh,0dfh,0dbh,0dch,20h
		db	0dfh,0dbh,20h,0dbh,0dfh,20h,0ffh

		db	20h,0dbh,0ddh,6 dup(20h),0dbh,20h,0dbh,3 dup(20h)
		db	0dbh,4 dup(20h),0dbh,4 dup(20h),0dbh,4 dup(20h)
		db	0dbh,20h,20h,0dbh,20h,20h,0dbh,20h,0dbh,20h,20h,0ffh

		db	20h,0dbh,0ddh,20h,0dbh,0dfh,0dbh,20h,20h,0dbh
		db	0dch,0dbh,3 dup(20h),0dbh,20h,20h,20h,20h,0dbh
		db	4 dup(20h),0dbh,0dch,0dbh,20h,20h,0dbh,0dch
		db	0dbh,0dfh,20h,20h,0dbh,0dch,0dbh,20h,20h,0ffh

		db	20h,0dbh,0ddh,3 dup(20h),0dbh,20h,20h,0dbh,20h
		db	0dbh,3 dup(20h),0dbh,4 dup(20h),0dbh,4 dup(20h)
		db	0dbh,20h,0dfh,2 dup(20h),0dbh,20h,0dbh,4 dup(20h)
		db	0dbh,20h,20h,20h,0ffh

		db	20h,20h,0dbh,3 dup(0dch),0dbh,20h,0dch,0dbh,20h,0dbh
		db	0dch,20h,0dch,0dbh,0dch,0dbh,20h,0dch,0dbh,0dch
		db	0dbh,20h,0dch,0dbh,0dch,0dbh,20h,0dch,0dbh,20h
		db	0dbh,0dch,20h,20h,0dch,0dbh,0dch,20h,20h
		db	00
	start_col	db	?
data ends

code segment

main proc far
	assume	cs:code
start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax
	lea	di, text
	call	ShowGraphicText

	ret
main endp

;Display a message on the graphic screen
;INPUT:
;DS:DI = address of graphics display block
ShowGraphicText proc near
	mov	dh, [di]		;get row into dh
	inc	di
	mov	dl, [di]		;and column into dl
	mov	start_col, dl		;store start column
	mov	ah, 2			;set cursor position
	mov	bh, 0			;page 0
	int	10h			;BIOS video call
	inc	di			;bump pointer to attribute
	mov	bl, [di]		;get color code into bl

WriteChar:
	inc	di			;bump to message start
	mov	al, [di]		;get character
	cmp	al, 0ffh		;end of line?
	je	BumpRow			;next row
	cmp	al, 0			;test for terminator
	jz	EndText			;exit routine
	call	ShowChar		
	jmp	WriteChar

BumpRow:
	inc	dh			;row control register
	mov	dl, start_col		;column control to start column
	mov	ah, 2			;set cursor position
	mov	bh, 0			;page 0
	int     10h			;BIOS video call
	jmp	WriteChar

EndText:
	ret
ShowGraphicText	endp

;display character in AL and using the color code in BL
ShowChar proc near
	mov	ah, 9			;BIOS service request number
	mov	bh, 0			;page 0
	mov	cx, 1			;no repeat
	int	10h

	;bump cursor
	inc	dl
	mov	ah, 2			;set cursor position
	mov	bh, 0			;page 0
	int	10h			;BIOS video call
	ret
ShowChar endp

code ends

	end start