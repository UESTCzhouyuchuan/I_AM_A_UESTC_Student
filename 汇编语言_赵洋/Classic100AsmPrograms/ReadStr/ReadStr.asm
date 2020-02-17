;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ReadStr.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;检测键盘输入的功能键是否是Ｆ１，Ｆ２等，如果是就退出程序

data segment
	buffer		db	50,0,50 dup(?)
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	mov	ax, data
	mov	ds, ax

	call	GetKeyBdString

	mov	ax, 4c00h
	int	21h

main endp

GetKeyBdString	proc near

	lea	dx, buffer
	mov	ah, 0ah
	int	21h

	sub	ch, ch
	mov	cl, buffer+1
	add	dx, 2

	ret
GetKeyBdString	endp

code ends

	end start