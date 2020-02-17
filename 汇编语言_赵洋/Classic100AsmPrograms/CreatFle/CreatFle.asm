;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; CreatFle.asm
;--------------------------------------------------------------------
;本例在EXE同目录下建立一个正常属性的文件TEST.TXT
;写一个新文件或用同一个文件名重写一个旧文件时，首先要建立文件并赋给它
;一个属性，如果DOS发现要建立的文件已经存在，那么原来的文件就被破坏，
;操作将文件的长度置0，如果CF位置1，则把错误代码返回到AX中

data segment
	szFileName	db	'TEST.TXT',0
	hFile		dw	?			;file handle
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

	mov	dx, offset szFileName
	mov	cx, 0000000000000000B	;要建立正常属性的文件
	call	CreateFile
	
	mov	bx, hFile
	call	CloseFile

	ret
main endp

;建立一个文件
;INPUT:
;DS = 文件路径数据所在段
;DX = 文件路径名(0结束)偏移地址
;CX = 文件属性
;OUTPUT:
;AX = 文件句柄
;操作将文件的长度置0，如果CF位置1，则把错误代码返回到AX中:
;操作失败AX返回的错误码可能为：
;	03: 路径未找到
;	04: 同时打开的文件太多
;	05: 拒绝访问
CreateFile proc near
	mov	ah, 3ch			;request create
	int	21h			;call DOS
	jc	@Error			;exit if error
	mov	hFile, ax
@Error:
	ret
CreateFile endp

;关闭一个文件
;INPUT:
;BX = 文件句柄
CloseFile proc near
	mov	ah, 3eh			;request close
	int	21h			;call DOS
	ret
CloseFile endp

code ends

	end start