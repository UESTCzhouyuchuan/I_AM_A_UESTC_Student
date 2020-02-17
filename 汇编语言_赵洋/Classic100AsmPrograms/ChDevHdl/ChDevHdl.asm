;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ChDevHdl.asm
;--------------------------------------------------------------------
;本例演示常用字符设备的文件代号用法
;字符设备的文件代号是ＤＯＳ２.０为用户提供的另外一组独立于硬件的ＤＯＳ
;功能，常用的字符设备的文件代号都是由ＤＯＳ预先定义好的。当一个用户程序
;得到控制权后，它就得到了５个已经打开的文件代号：
;0000 = 标准输入设备，通常是键盘
;0001 = 标准输出设备，通常是显示器
;0002 = 错误输出设备，总是显示器
;0003 = 标准辅助设备，一般为通信端口
;0004 = 标准打印机，（＃０打印机）
;设备和文件代号建立了对应关系，用户就可以将这些设备视为文件。
;上面前２种设备Ｉ/Ｏ功能允许改向操作，比如，允许用户程序可以从键盘文件
;输入也可以从别的文件输入，可以向显示器文件输出也可以向别的文件输出，
;而且不必打开或关闭这些文件，这些设备文件也没有读写指针。
;键盘输入，显示器输出，打印机输出等设备使用代号式Ｉ/Ｏ是非常简单的。

data segment
	buffer	db	80 dup(?)
data ends

code segment
	assume	cs:code, ds:data
main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax			;buffer segment
	mov	dx, offset buffer	;buffer offset
	mov	cx, 80			;buffer size
	call	GetStringFromKeyBoard
	
	mov	cx, 80			;buffer size
	call	PutStringOnDisplayer


	ret
main endp


;从键盘输入一行字符到缓冲区
;INPUT:
;DS = 缓冲区所在段
;DX = 缓冲区偏移地址
;CX = 缓冲区大小
GetStringFromKeyBoard proc near
	mov	ah, 3fh			;request read function
	mov	bx, 0			;handle 0 = KeyBoard
	int	21h			;call DOS
	jc	@GSFKBError
@GSFKBError:
	ret
GetStringFromKeyBoard endp


;从标准输出设备(可能是显示器)输出字符串
;INPUT:
;DS = 字符串缓冲区所在段
;DX = 字符串缓冲区偏移地址
;CX = 字符串长度
PutStringOnDisplayer proc near
	mov	ah, 40h			;request write function
	mov	bx, 1			;handle 1 = maybe CRT
	int	21h			;call DOS
	jc	@PSODError
@PSODError:
	ret
PutStringOnDisplayer endp


;从控制台(总是显示器)输出字符串
;INPUT:
;DS = 字符串缓冲区所在段
;DX = 字符串缓冲区偏移地址
;CX = 字符串长度
PutStringOnConsole proc near
	mov	ah, 40h			;request write function
	mov	bx, 2			;handle 2 = console(always CRT)
	int	21h			;call DOS
	jc	@PSOCSError
@PSOCSError:
	ret
PutStringOnConsole endp


;从串口输出字符串
;INPUT:
;DS = 字符串缓冲区所在段
;DX = 字符串缓冲区偏移地址
;CX = 字符串长度
PutStringOnComm proc near
	mov	ah, 40h			;request write function
	mov	bx, 3			;handle 3 = communication
	int	21h			;call DOS
	jc	@PSOCError
@PSOCError:
	ret
PutStringOnComm endp


;从打印机输出字符串
;INPUT:
;DS = 字符串缓冲区所在段
;DX = 字符串缓冲区偏移地址
;CX = 字符串长度
PutStringOnPrinter proc near
	mov	ah, 40h			;request write function
	mov	bx, 4			;handle 4 = printer
	int	21h			;call DOS
	jc	@PSOPError
@PSOPError:
	ret
PutStringOnPrinter endp

code ends

	end start