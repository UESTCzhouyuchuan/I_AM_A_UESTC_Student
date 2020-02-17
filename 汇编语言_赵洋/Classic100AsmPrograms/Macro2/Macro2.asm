;гнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгн
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ╚╣г║30515563
; Macro2.asm
;гнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгнгн
;╜▓╩Ў║ъ╡─╩╣╙├

;include	macro.mac

if1
	include	macro.mac
endif

.model	small
.386

.stack	200h

.data
	messg1		db	'Customer Name?',13,10,'$'
	messg2		db	'Customer address?',13,10,'$'

.code

main proc far
start:
	.sall
	initz
	.xall
	prompt	messg1
	.lall
	prompt	messg2
	.xall
	finish
main endp

	end start

