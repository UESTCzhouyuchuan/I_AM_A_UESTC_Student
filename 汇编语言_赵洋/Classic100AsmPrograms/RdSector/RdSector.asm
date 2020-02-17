;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; RdSector.asm
;--------------------------------------------------------------------
;把一个扇区的内容入到一个缓冲区,然后存入一个名为Sector.dat的文件中
;BIOS磁盘操作ＩＮＴ　１３Ｈ处理的记录都是一个扇区(512 bytes)的大小，
;都是以实际的磁道号和扇区号寻址的。读，写和检验磁盘文件之前，先把
;下列寄存器初始化：
;AH = 要执行的操作：复位(0),读状态(1),读磁盘(2),写磁盘(3) 检验扇区(4)
;AL = 扇区数
;CH = 柱面/磁道号(0为起始号)
;CL = 起始扇区号(1为起始号)
;DH = 磁头/盘面号，对软盘是０或１
;DL = 驱动器号: 软盘:0=驱动器Ａ，1=驱动器Ｂ，...
;		硬盘:80h=驱动器１，81h=驱动器２，...
;ES:BX = 数据区中Ｉ/Ｏ缓冲区的地址(除检验操作外)

;在大多数情况下，程序只指定读一个扇区或读取一个磁道上的全部扇区。
;读操作只是顺序读取ＣＨ和ＣＬ指定的扇区内容，并递增ＣＨ和ＣＬ中的磁道
;号和扇区号，如果扇区号超过了磁道的最大扇区号，必须把扇区号重新置１，
;并把磁道号增１，或者把双面盘的０面变１面。
;
data segment
	szFileName		db	'Sector.dat',0
	hFile			dw	?			;file handle
	Buffer			db	512 dup('0')
	nBytes			equ     $-Buffer
	ReadSectorFailedMsg	db	'Failed to read 1 sector',13,10
	nFailMsgLen		equ	$-ReadSectorFailedMsg
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
	mov     es, ax

	call	ReadOneSector
	cmp	al, 1
	lea	dx, ReadSectorFailedMsg
	jne	@Error
	mov	dx, offset szFileName
	mov	cx, 0000000000000000B	;要建立正常属性的文件
	call	CreateFile
	mov	bx, hFile
	mov	cx, nBytes
	mov	dx, offset Buffer
	call	WriteFile

	mov	bx, hFile
	call	CloseFile

	ret

@Error:
	call	PutErrorStringOnCRT
	ret
main endp

;OUTPUT:
;AL = 实际读取的扇区数

ReadOneSector proc near
	mov	ah, 2		;request read
	mov	al, 1		;one sector
	lea	bx, Buffer	;input buffer at ES:BX
	mov	ch, 5		;track 5
	mov	cl, 3		;sector 3
	mov	dh, 0		;head 0
	mov	dl, 1		;drive 1(Floopy B)
	int	13h		;call BIOS
	ret
ReadOneSector endp


;从键盘输入一行字符到缓冲区
PutErrorStringOnCRT proc near
	mov	ah, 3fh			;request read function
	mov	bx, 1			;handle 1 = CRT
	mov	cx, nFailMsgLen
	int	21h			;call DOS
	ret
PutErrorStringOnCRT endp


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
	jc	@CFError		;exit if error
	mov	hFile, ax
@CFError:
	ret
CreateFile endp


;写文件
;INPUT:
;BX = 文件代号即句柄
;CX = 要写入的字节数
;DX = 输入缓冲区的地址
;OUTPUT:
;如果从内存写入文件成功，则CF=0并把实际写入字节数送人AX
;如果磁盘满，实际写入字节数可能小于要求写入字节数
WriteFile proc	near
	mov	ah, 40h			;request write
	int	21h			;call DOS
	jc	@WFError1		;special action is error
	cmp	ax, nBytes		;all bytes written?
	jne	@WFError2

@WFError1:

@WFError2:
	ret
WriteFile endp

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