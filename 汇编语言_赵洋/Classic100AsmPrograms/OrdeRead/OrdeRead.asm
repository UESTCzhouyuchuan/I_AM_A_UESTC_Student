;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; OrdeRead.asm
;--------------------------------------------------------------------
;本例用文件代号(句柄)顺序地读取一个文件
;一个文件分几次读取取决于文件的大小和输入缓冲区的空间，如果文件比较小
;又有足够的输入缓冲区，则用一次调用就能读入整个文件的内容，如果文件很
;大,程序中不能设置如此大缓冲区，则必须循环调用读取功能，直到整个文件
;结束。
;本例读取的是由NameFile程序产生的文件
;
;该程序接受一个由姓名组成的文件，它包括以下函数块：
;1) OpenFile 利用int 21的3dh功能调用来建立文件把代号保存在hFile中
;2) ReadFile 利用int 21的3fh功能调用来写文件
;3) DisplayFile 显示记录并卷屏
;4) CloseFile 利用int 21的3eh功能调用来关闭文件

data segment
	ErrorCode	db	0			;End process indicator
	hFile		dw	?			;file handle
	szBuffer	db	32 dup(' ')
	szFileName	db	'NAME.DAT',0
	OpenErrorMsg	db	'open file error!',13,10,'$'
	ReadErrorMsg	db	'write file error!',13,10,'$'
	Row		db	0
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
	call	OpenFile		;open file, set DTA
	cmp	ErrorCode, 0		;valid open?
	jnz	@Exit			;no, exit		

@Continue:
	call	ReadFile		;read disk record	
	cmp	ErrorCode, 0		;normal read?
	jnz	@Exit
	call	DisplayFile		;yes display it
	jmp	@Continue		;continue

	call	CloseFile		;yes, close

@Exit:
	ret
main endp


;建立文件,把代号保存在hFile中
OpenFile proc near
	mov	ah, 3dh			;request open
	mov	al, 0			;normal file
	lea	dx, szFileName		
	int	21h			;call DOS
	jc	@Error			;exit if error
	mov	hFile, ax		;no, save handle
	ret
@Error:
	mov	ErrorCode, 01		;yes
	lea	dx, OpenErrorMsg	;error message
	call	ShowErrorMsg
	ret
OpenFile endp


;读文件
;如果从内存写入文件成功，则CF=0并把实际写入字节数送人AX
;如果磁盘满，实际写入字节数可能小于要求写入字节数
ReadFile proc	near
	mov	ah, 3fh			;request read
	mov	bx, hFile		;file handle
	mov	cx, 32			;for name and CR/LF
	lea	dx, szBuffer
	int	21h			;call DOS
	jc	@ErrorRead		;valid read?
	cmp	ax, 0			;end of file?
	je	@EndRead
	cmp	szBuffer, 1ah		;EOF mark?
	je	@EndRead		;yes, exit
	ret

@ErrorRead:
	lea	dx, ReadErrorMsg	;no, invalid read
	call	ShowErrorMsg
@EndRead:
	mov	ErrorCode, 1		;force end
	ret
ReadFile endp

;显示记录并卷屏
DisplayFile proc near
	mov	ah, 40h			;request display
	mov	bx, 01			;set handle
	mov	cx, 32			;and length
	lea	dx, szBuffer
	int	21h
	
	cmp	Row, 24			;bottom of screen?
	jae	@NeedScrollScreen	;yes, bypass
	inc	Row
	ret
@NeedScrollScreen:
	mov	ax, 0601h
	call	ScrollScreen
	call	SetCursor
	ret

DisplayFile endp

;关闭文件
CloseFile proc near
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
	mov	cx, 20			;length of message
	int	21h
	ret
ShowErrorMsg endp

code ends

	end start