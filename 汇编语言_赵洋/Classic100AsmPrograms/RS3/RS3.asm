;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; RS3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;使用BIOS串口Ｉ/Ｏ的例子
;把0号串口的传输率设为２４００波特，字长８位，１位终止位，无奇偶校验

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ConfigComm
	
	ret
main endp

ConfigComm proc near
	
	mov	ah, 0		;initialize comm
	mov	al, 0a3h	;0a3h = 10100011B
	mov	dx, 0		;COM1
	int	14h		;call BIOS

	ret
ConfigComm endp

code ends

	end start