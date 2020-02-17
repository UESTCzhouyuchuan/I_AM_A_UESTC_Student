;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; RandRead.asm
;--------------------------------------------------------------------
;利用文件代号随机读取磁盘文件
;本例读取的是由NameFile程序产生的文件
;若键入文件中的相对记录号，屏幕上则显示出所要求的记录，如果文件有７０
;个记录，那么合法的记录号为０１－－７０，要从键盘上输入的记录号是
;ＡＳＣＩＩ码的形式，所以记录号应该是１位数字或２位数字，每条记录的
;的长度是３２字节
;函数KeyBoardInputProcess从键盘接收记录号并检测它的长度，有３种情况
;00 = 处理请求结束
;01 = １位记录号，保存在ＡＬ中
;02 = ２位记录号，保存在ＡＸ中
;接着把输入的记录号转换为文件中的字节数，例如，从键盘输入数字１２
;ＡＸ中得到３１３２，ＡＮＤ指令将它变为０１０２，ＡＡＤ指令又将
;０１０２转换为０００ＣＨ(12),ＳＨＬ指令再将它左移５位即乘３２变成
;０１８０Ｈ(384),结果，从文件的３８４字节开始的３２字节即一个记录就
;被读取并显示出来了

data segment
	hFile		dw	?			;file handle
	szBuffer	db	32 dup(' ')
	szFileName	db	'NAME.DAT',0
	nIndex		dw	?			;record index
	ErrorCode	db	0			;Error indicator
	Prompt		db	'Record Number? '
	OpenErrorMsg	db	'Open file error!',13,10
	MoveErrorMsg	db	'Move file pointer error!',13,10
	ReadErrorMsg	db	'Read file error!',13,10
	Row		db	0
	Col		db	0
	ReadPar		label	byte		;input parameter list
	MaxLen		db	3		;maximum length
	ActLen		db	?		;actual length
	RecordNo	db	3 dup(' ')	;record number
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
	call	KeyBoardInputProcess	;request record number
	cmp	ActLen, 0		;any more request?
	je	@Exit			;no, exit
	call	MoveFilePointer		;move file pointer
	call	Read32Bytes		;read disk record	
	cmp	ErrorCode, 0		;normal read?
	jnz	@Continue		;no bypass
	call	DisplayRecord		;yes display it
	jmp	@Continue		;continue

@Exit:
	call	CloseFile		;yes, close
	ret
main endp


;建立文件,把代号保存在hFile中
OpenFile proc near
	mov	ah, 3dh			;request open
	mov	al, 0			;normal file
	lea	dx, szFileName		
	int	21h			;call DOS
	jc	@OFError			;exit if error
	mov	hFile, ax		;no, save handle
	ret
@OFError:
	mov	ErrorCode, 1		;yes
	lea	dx, OpenErrorMsg	;error message
	call	ShowErrorMsg
	ret
OpenFile endp


KeyBoardInputProcess proc near
	mov	ah, 40h			;request display prompt
	mov	bx, 1			;CRT file handle
	mov	cx, 15			;15 characters
	lea	dx, Prompt
	int	21h
	mov	ah, 0ah			;request input
	lea	dx, ReadPar		;of record number
	int	21h
	cmp	ActLen,	1		;check length
	jb	@KBExit			;length 0, terminate
	ja	@TwoDigits		;length = 2
	xor	ah, ah			;length = 1
	mov	al, RecordNo		;
	jmp	@Convert

@TwoDigits:
	mov	ah, RecordNo		;length = 2
	mov	al, RecordNo+1

@Convert:
	and	ax, 0f0fh		;clear ASCII 3s
	aad				;convert to binary
	dec	ax			;adjust (first reord is 0)
	mov	cl, 5
	shl	ax, cl			;multiply by 32
	mov	nIndex, ax		;save index	

@KBExit:
	mov	Col, 20
	call	SetCursor
	ret

KeyBoardInputProcess endp

;移动文件指针
MoveFilePointer proc near
	mov	ah, 42h			;request set file pointer
	mov	al, 0			;to start file
	mov	bx, hFile		;file handle
	mov	cx, 0			;high word of offset number
	mov	dx, nIndex		;low word of offset number
	int	21h
	jc	@MFPError
	ret
@MFPError:
	mov	ErrorCode, 1		;yes
	lea	dx, MoveErrorMsg	;error message
	call	ShowErrorMsg
	ret
	
MoveFilePointer endp

;从当前指针位置读取３２字节
Read32Bytes proc near
	
	mov	ah, 3fh			;request read
	mov	bx, hFile		;file handle
	mov	cx, 32			;for name and CR/LF
	lea	dx, szBuffer
	int	21h			;call DOS
	jc	@R32BError		;valid read?
	cmp	szBuffer, 1ah		;EOF mark?
	je	@R32BExit		;yes, exit
	ret

@R32BError:
	lea	dx, ReadErrorMsg	;no, invalid read
	call	ShowErrorMsg
@R32BExit:
	mov	ErrorCode, 1		;force end
	ret
Read32Bytes endp

;显示记录并卷屏
DisplayRecord proc near
	mov	ah, 40h			;request display
	mov	bx, 01			;set handle
	mov	cx, 32			;and length
	lea	dx, szBuffer
	int	21h
	
	mov	Col, 0			;clear column
	cmp	Row, 20			;bottom of screen?
	jae	@NeedScrollScreen	;yes, bypass
	inc	Row
	ret
@NeedScrollScreen:
	mov	ax, 0601h
	call	ScrollScreen
	call	SetCursor
	ret

DisplayRecord endp

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
	mov	ah, 2
	mov	bh, 0
	mov	dh, Row			;set cursor
	mov	dl, Col			;column
	int	10h
	ret
SetCursor endp

;Show error msg
ShowErrorMsg proc near
	mov	ah, 40h			;of message
	mov	bx, 1			;handle
	mov	cx, 20			;length of message
	int	21h
	inc	Row
	ret
ShowErrorMsg endp

code ends

	end start