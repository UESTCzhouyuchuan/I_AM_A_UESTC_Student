;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Macro4.asm
;��������������������������������������������������������������������
;movif�궨�����������Ϊ�»�׶������ңţС��ͣϣ֣ӣ»�
;�ңţС��ͣϣ֣ӣ׵�ָ��粻��������������ңţС��ͣϣ֣ӣ�

movif	macro	tag
	ifidn	<&tag>,<b>
		rep	movsb
		exitm
	endif
	ifidn	<&tag>,<w>
		rep	movsw
	else
		rep	movsb
	endif
endm

	if1
		include Macro.mac
	endif
	purge	prompt

.model	small
.386
.stack	200h
.data

.code

main proc far
start:
	.sall
	initz
	.xall
	movif	b
	movif	w
	movif
	.sall
	finish
main endp

	end  start

