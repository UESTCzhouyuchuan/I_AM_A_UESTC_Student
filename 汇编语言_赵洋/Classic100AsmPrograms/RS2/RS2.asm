;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; RS2.asm
;��������������������������������������������������������������������
;ʹ�ãģϣӴ��ڣ�/�ϵ�����
;���ַ���"HELLO"���������

data segment
	BUFFER		db	'HELLO'
	BUF_LEN		equ	$-BUFFER
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	call	WriteComm
	
	ret
main endp

WriteComm proc near
	
	mov	bx, seg BUFFER
	mov	ds, bx
	mov	bx, offset BUFFER
	mov	cx, BUF_LEN
next:
	mov	dl, [bx]	;take the next char
	mov	ah, 4		;comm output
	int	21h		;call DOS
	inc	bx		;increase pointer
	loop	next

	ret
WriteComm endp

code ends

	end start