;гнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгн
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ╚╣г║30515563
; Macro1.asm
;гнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгн
;╜▓╩Ў║ъ╡─╩╣╙├

initz	macro
	mov	ax, @data
	mov	ds, ax
	mov	es, ax
endm

prompt	macro	message
	mov	ah, 09h
	lea	dx, message
	int	21h
endm

finish	macro
	mov	ax, 4c00h
	int	21h
endm

.model	small
.386

.stack	200h

.data
	messg1		db	'Customer Name?',13,10,'$'
	messg2		db	'Customer address?',13,10,'$'

.code

main	proc	far
start:
	.sall
	initz
	.xall
	prompt	messg1
	.lall
	prompt	messg2
	.xall
	finish
main	endp

	end start

