;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; NameFile.asm
;--------------------------------------------------------------------
;本例用文件代号(句柄)建立文件
;该程序接受一个由姓名组成的文件，它包括以下函数块：
;1) CreateFile 利用int 21的3ch功能调用来建立文件把代号保存在hFile中
;2) GetKeyBoardInput 键盘接受输入并把输入缓冲区的其余的单元用空格填入
;3) WriteFile 利用int 21的40h功能调用来写文件
;4) CloseFile 利用int 21的3eh功能调用来关闭文件

data segment
	NamePar		label   byte			;name parameter list
	MaxLen		db	30
	NameLen		db	?
	NameRecorder	db	30 dup(' '),13,10	;entered name
	CrLf		db	13,10,'$'
	ErrorCode	db	?
	hFile		dw	?			;file handle
	szFileName	db	'NAME.DAT',0
	Prompt		db	'Name ?'
	Row		db	01
	OpenErrorMsg	db	'open file error!',13,10,'$'
	WriteErrorMsg	db	'write file error!',13,10,'$'
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax
	mov	es, ax

	mov	ax, 0600h
	call	ScrollScreen		;scroll screen
	call	SetCursor		;set cursor
	call	CreateFile		;create file
	cmp	ErrorCode, 0		;create error?
	jz	@Continue		;yes, continue
	jmp	@Exit			;no, exit

@Continue:
	call	GetKeyBoardInput	
	cmp	NameLen, 0		;end of input?
	jne	@Continue		;no, continue
	call	CloseFile		;yes, close

@Exit:
	ret
main endp


;建立文件,把代号保存在hFile中
CreateFile proc near
	mov	ah, 3ch			;request create
	mov	cx, 0			;normal attribute
	lea	dx, szFileName		
	int	21h			;call DOS
	jc	@Error			;exit if error
	mov	hFile, ax
	ret
@Error:
	lea	dx, OpenErrorMsg	;error message
	call	ShowErrorMsg
	ret
CreateFile endp

;键盘接受输入并把输入缓冲区的其余的单元用空格填入
GetKeyBoardInput proc near
	mov	ah, 40h			;request display
	mov	bx, 01			;01 = output device
	mov	cx, 06			;length of Prompt
	lea	dx, Prompt		;display prompt
	int	21h			;call DOS

	mov	ah, 0ah			;request input
	lea	dx, NamePar		;accept name
	int	21h			

	cmp	NameLen, 0		;is there a name?
	jne	@BlankDeal		;yes
	ret				;no, exit

@BlankDeal:
	mov	al, 20h			;blank for storing
	sub	ch, ch
	mov	cl, NameLen		;length
	lea	di, NameRecorder	
	add	di, cx			;address + length
	neg	cx			;calculate remaining
	add	cx, 30			;length
	cld
	rep	stosb			;set to blank
	call	WriteFile		;write disk record
	call	CheckScroll		;check for scroll

	ret
GetKeyBoardInput endp

;check for scroll
CheckScroll proc near
	cmp	Row, 18h		;bottom of screen?
	jae	@NeedScrollUp		;yes, bypass
	mov	ah, 09			;no, to next row
	lea	dx, CrLf
	int	21h
	inc	Row			;no, add to Row
	ret

@NeedScrollUp:
	mov	ax, 0601h		;scroll one row
	call	ScrollScreen		;scroll screen
	call	SetCursor		;set cursor
	ret
CheckScroll endp


;写文件
;如果从内存写入文件成功，则CF=0并把实际写入字节数送人AX
;如果磁盘满，实际写入字节数可能小于要求写入字节数
WriteFile proc	near
	mov	ah, 40h			;request write
	mov	bx, hFile		;file handle
	mov	cx, 32			;for name and CR/LF
	lea	dx, NameRecorder
	int	21h			;call DOS
	jnc	@SuccessWrite		;valid write?
	lea	dx, WriteErrorMsg	;no
	call	ShowErrorMsg		;call error routine
	mov	NameLen, 0

@SuccessWrite:
	ret
WriteFile endp

;关闭文件
CloseFile proc near
	mov	NameRecorder, 1ah	;set EOF mark
	call	WriteFile
	mov	bx, hFile		;file handle
	mov	ah, 3eh			;request close
	int	21h			;call DOS
	ret
CloseFile endp

;Scroll Screen
ScrollScreen proc near
	mov	bh, 1eh			;set yellow on blue
	mov	cx, 0
	mov	dx, 184fh
	int	10h			;scroll
	ret
ScrollScreen endp

;Set cursor
SetCursor proc near
	mov	ah, 02
	mov	bh, 0
	mov	dh, Row			;set cursor
	mov	dl, 0
	int	10h
	ret
SetCursor endp

;Show error msg
ShowErrorMsg proc near
	mov	ah, 40h			;of message
	mov	bx, 01			;handle
	mov	cx, 21			;length
	int	21h
	mov	ErrorCode, 01		;set error code
	ret
ShowErrorMsg endp

code ends

	end start