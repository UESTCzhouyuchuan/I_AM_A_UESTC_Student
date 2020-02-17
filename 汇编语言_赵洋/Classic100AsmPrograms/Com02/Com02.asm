;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Com02.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;COM 源文件格式02

;program title goes here

.model tiny

.code
	org 100h

;data goes here

;code goes here
main proc near

start:
	
	mov ax, 4c00h
	int 21h

main endp

	end start