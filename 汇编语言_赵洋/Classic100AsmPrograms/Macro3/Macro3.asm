;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Macro3.asm
;��������������������������������������������������������������������
;����һ�������궨��ģɣ֣ɣģ����ڵĳ���
;�ģɣ֣ɣģ���һ������̵ļ�����ʵ�ֳ����ĳ����ڽ���ó�������ǰ
;ʹ�ãɣƣΣģţ������ú궨������������Ƿ����ڳ����ж��壬�������
;��һ����δ�����壬���ããΣԣҼ��Լ�¼������ã�
;IF	CNDR
;	EXITM
;ENDIF
;����ֻ֤Ҫ��һ��δ�����壬������򽫴ӣţأɣԣʹ��˳��ú궨�����
;����һ����չ��

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

