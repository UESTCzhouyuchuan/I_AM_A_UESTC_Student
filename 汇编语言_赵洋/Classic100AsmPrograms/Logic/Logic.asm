;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Logic.asm
;��������������������������������������������������������������������
;��������Уأ����أ����أ���... ... �أ�����
;��������У٣����٣����٣���... ... �٣�����
;��̼��㣺
;	�ڣ� �� �أ� �� �٣�,	�ڣ�  �� �أ�   �� �٣�,
;	�ڣ� �� �أ� �� �٣�,	�ڣ�  �� �أ�   �� �٣�,
;	�ڣ� �� �أ� �� �٣�,	�ڣ�  �� �أ�   �� �٣�,
;	�ڣ� �� �أ� �� �٣�,	�ڣ�  �� �أ�   �� �٣�,
;	�ڣ� �� �أ� �� �٣�,	�ڣ����� �أ��� �� �٣���,
;������������

data segment
	x		dw	1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	y		dw	19,18,17,16,15,14,13,12,11,10
	z		dw	10 dup(?)
	logic_rule	dw	0000000011011100B
data ends

code segment
	assume cs:code, ds:data

main proc far

start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	mov	bx, 0
	mov	cx, 10
	mov	dx, logic_rule

next:
	mov	ax, x[bx]
	shr	dx, 1
	jc	subtract
	add	ax, y[bx]
	jmp	short result

subtract:
	sub	ax, y[bx]

result:
	mov	z[bx], ax
	add	bx, 2
	loop	next

	ret
main endp

code ends
	end start