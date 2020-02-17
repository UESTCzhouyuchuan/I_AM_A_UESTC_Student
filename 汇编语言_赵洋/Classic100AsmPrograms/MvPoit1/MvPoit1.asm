;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; MvPoit1.asm
;--------------------------------------------------------------------
;读取一个文件时移动读写指针
;为了存取文件中间某一特定的记录，首先要使读写指针指向这个记录，ＤＯＳ
;提供了移动读写指针的功能４２Ｈ，该功能要求在ＢＸ中指定文件代号，由
;ＡＬ中的代码确定移动指针的３种方式：
;AL = 00: 绝对移动，偏移值从文件首开始计算
;AL = 01: 相对移动，当前的指针值加上偏移值作为新的指针值
;AL = 02: 绝对倒移，新的指针位置通过把偏移值和文件尾位置相加而确定

;在每种方式下，由ＣＸ和ＤＸ指定一个双字长的偏移值，低位字在ＤＸ中，高
;位字在ＣＸ中，这个偏移值是一个带符号的整数，可以是正数也可以是负数
;本例读取的是由NameFile程序产生的文件

data segment
	hFile		dw	?			;file handle
	szBuffer	db	32 dup(' ')
	szFileName	db	'NAME.DAT',0
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

	call	OpenFile		;open file, set DTA

	mov	cx, 0
	mov	dx, 64
	call	AbsoluteMove		;move file pointer
	call	Read32Bytes		;read disk record
	call	ShowBuffer

	mov	cx, 0
	mov	dx, -96
	call	RelativeMove
	call	Read32Bytes		;read disk record
	call	ShowBuffer
	
	;把指针指向文件尾的一条记录
	mov	cx, 0
	not	cx
	mov	dx, -64
	call	InvertedMove
	call	Read32Bytes		;read disk record
	call	ShowBuffer

	call	CloseFile		;yes, close

	ret
main endp


;建立文件,把代号保存在hFile中
OpenFile proc near
	mov	ah, 3dh			;request open
	mov	al, 0			;normal file
	lea	dx, szFileName		
	int	21h			;call DOS
	mov	hFile, ax		;no, save handle
	ret
OpenFile endp

;INPUT:
;DX = 从文件首开始偏移值低位字
;CX = 从文件首开始偏移值高位字
AbsoluteMove proc near
	mov	ah, 42h		;request move pointer
	mov	al, 0		;to start of file
	mov	bx, hFile	;set file handler
	int	21h
	ret
AbsoluteMove endp


;INPUT:
;DX = 从文件首开始偏移值低位字
;CX = 从文件首开始偏移值高位字
RelativeMove proc near
	mov	ah, 42h		;request move pointer
	mov	al, 1		;relative move
	mov	bx, hFile	;set file handler
	cmp	dx, 0
	jge	@GreatEq0	;>=0
	not	cx		;extending the sign

@GreatEq0:
	int	21h
	ret
RelativeMove endp

;INPUT:
;DX = 从文件首开始偏移值低位字
;CX = 从文件首开始偏移值高位字
InvertedMove proc near
	mov	ah, 42h		;request move pointer
	mov	al, 2		;inverted move
	mov	bx, hFile	;set file handler
	int	21h
	ret
InvertedMove endp

;读文件
;如果从内存写入文件成功，则CF=0并把实际写入字节数送人AX
;如果磁盘满，实际写入字节数可能小于要求写入字节数
Read32Bytes proc near
	mov	ah, 3fh			;request read
	mov	bx, hFile		;file handle
	mov	cx, 32			;for name and CR/LF
	lea	dx, szBuffer
	int	21h			;call DOS
	ret
Read32Bytes endp

;关闭文件
CloseFile proc near
	mov	bx, hFile		;file handle
	mov	ah, 3eh			;request close
	int	21h			;call DOS
	ret
CloseFile endp


;Show error msg
ShowBuffer proc near
	lea	dx, szBuffer		;message
	mov	ah, 40h			;of message
	mov	bx, 01			;handle
	mov	cx, 32			;length of message
	int	21h
	ret
ShowBuffer endp

code ends

	end start