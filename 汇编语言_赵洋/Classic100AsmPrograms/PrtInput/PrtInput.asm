;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; PrtInput.asm
;--------------------------------------------------------------------
;本例演示文件代号式Ｉ/Ｏ,从键盘上输入文件并从打印机输出
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
	Buffer				db	130 dup(?)
	GetStringFromKeyBoardErrorMsg	db	'Get string from keyboard error!',13,10
	PutStringOnPrinterErrorMsg	db	'Put string on printer error',13,10
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
	mov     es, ax

	call	InitializePrinter

@Input:
	call	GetStringFromKeyBoard
	mov	dx, offset GetStringFromKeyBoardErrorMsg	;buffer offset
	jc	@Error
	cmp	Buffer, 1ah					;is ctrl + z typed?
	je	@Exit

@Output:
	mov	cx, ax						;number of char
	call	PutStringOnPrinter
	mov	dx, offset PutStringOnPrinterErrorMsg
	jc	@Error
	jmp	@Input

@Error:
	call	PutErrorStringOnCRT		
@Exit:
	ret
main endp

InitializePrinter proc near
	sti
	cld
	mov	ah, 1			;initialize printer
	mov	dx, 0			;printer #0
	int	17h			;call BIOS
	ret
InitializePrinter endp

;从键盘输入一行字符到缓冲区
GetStringFromKeyBoard proc near
	mov	ah, 3fh			;request read function
	mov	bx, 0			;handle 0 = KeyBoard
	mov	dx, offset Buffer	;buffer offset
	mov	cx, 130			;buffer size
	int	21h			;call DOS
	ret
GetStringFromKeyBoard endp

;从键盘输入一行字符到缓冲区
PutErrorStringOnCRT proc near
	mov	ah, 3fh			;request read function
	mov	bx, 1			;handle 1 = CRT
	mov	cx, 40
	int	21h			;call DOS
	ret
PutErrorStringOnCRT endp

;从打印机输出字符串
;INPUT:
;DS = 字符串缓冲区所在段
;DX = 字符串缓冲区偏移地址
;CX = 字符串长度
PutStringOnPrinter proc near
	mov	ah, 40h			;request write function
	mov	bx, 4			;handle 4 = printer
	mov	dx, offset Buffer	;buffer offset
	mov	cx, 130			;buffer size
	int	21h			;call DOS
	ret
PutStringOnPrinter endp

code ends

	end start