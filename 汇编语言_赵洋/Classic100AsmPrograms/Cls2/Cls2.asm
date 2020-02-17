;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Cls2.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;清除左上角为（０，０）右下角为（２４，３９）的窗口的程序，初始化为
;反向显示，该窗口相当于全屏幕的左半部分

;int 10h功能7能使屏幕内容下卷指定的行，这个功能需要设置７个参数。
;如果屏幕的起始行列不为（０，０）结束行列不为（２４，７９），则
;屏幕只有指定的一部分具有上卷的功能，这个屏幕上的部分区域叫做窗口
;像这样的窗口可以在屏幕上设置多个，这些窗口都可以独立使用，如果
;上卷超过指定窗口的顶部，这些行的内容就消失，出现在窗口底部的新行
;被填为空格，其属性由ＢＨ寄存器决定。如果ＡＬ＝０，则实际完成的
;工作是清除屏幕内容，它将按ＡＬ中的blank字符（０）使指定的窗口为
;空白

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ClearScreen

	ret
main endp


ClearScreen proc near uses ax bx cx dx
	
	;clear screen
	mov	ah, 7		;to scroll up screen
	mov	al, 0		;blank screen
	mov	bh, 70h		;reverse video attribute
	mov	ch, 0		;up left row
	mov	cl, 0		;up left col
	mov	dh, 24		;low right row
	mov	dl, 39		;low right col
	int	10h

	;locate cursor
	mov	dx, 0
	mov	ah, 2
	int	10h

	ret
ClearScreen endp

code ends

	end start