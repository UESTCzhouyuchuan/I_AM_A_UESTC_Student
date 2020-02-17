;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; RS1.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;使用ＤＯＳ串口Ｉ/Ｏ的例子
;从串口输入一个字符并存入INPUT_CHAR单元中

data segment
	INPUT_CHAR	db	?
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

	call	GetChar
	
	ret
main endp

GetChar	proc near
	
	mov	ah, 3
	int	21h
	mov	INPUT_CHAR, al

	ret
GetChar	endp

code ends

	end start