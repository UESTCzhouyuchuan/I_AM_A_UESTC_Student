;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Com01.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;COM源文件格式01

;program title goes here
;followed by descriptive phrases
;EQU statements goes here

code segment
	org 100h
	assume cs:code,ds:code,es:code,ss:code

main proc near

	;code goes here
	mov	ax, 4c00h
	int	21h


	;data goes here


main endp

code ends

	end main