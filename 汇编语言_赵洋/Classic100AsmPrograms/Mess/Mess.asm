;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Mess.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;把数据段中的字符串转送到附加段中

data segment
	mess1	db	'personal computer',13,10,'$'
data ends

extra segment
	mess2	db	20 dup(?)
extra ends 

code segment
	assume cs:code, ds:data, es:extra

main proc far
	
start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	mov	ax, extra
	mov	es, ax

	lea	si, mess1
	lea	di, mess2

	mov	cx, 20
	cld
	rep movsb
	
	ret
main endp

code ends
	end start