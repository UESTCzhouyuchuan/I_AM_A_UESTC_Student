;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Macro3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;这是一个包含宏定义ＤＩＶＩＤＥ在内的程序
;ＤＩＶＩＤＥ是一个用相继的减法来实现除法的程序，在进入该程序主题前
;使用ＩＦＮＤＥＦ来检查该宏定义的三个参数是否已在程序中定义，如果其中
;任一参数未经定义，则将用ＣＮＴＲ加以记录，最后用：
;IF	CNDR
;	EXITM
;ENDIF
;来保证只要有一个未被定义，则汇编程序将从ＥＸＩＴＭ处退出该宏定义而不
;做进一步的展开

divide	macro	dividend, divisor, quotient
	local	comp, out
	cntr = 0
	ifndef	dividend
		cntr = 1
	endif
	ifndef	divisor
		cntr = 1
	endif
	ifndef	quotient
		cntr = 1
	endif
	if	cntr
		exitm
	endif

	mov	ax, dividend
	mov	bx, divisor
	sub	cx, cx
comp:
	cmp	ax, bx
	jb	out
	sub	ax, bx
	inc	cx
	jmp	comp

out:	
	mov	quotient, cx
endm

	if1
		include Macro.mac
	endif
	purge	prompt

.model	small
.386

.stack	200h

.data
	divdnd	dw	200
	divsor	dw	25
	quotnt	dw	?

.code

main	proc	far
start:
	.sall
	initz
	.xall
	divide	divdnd, divsor, quotnt
	.lall
	divide	divdnd, divsor, quotnt
	.sall
	finish
main	endp

	end  start

