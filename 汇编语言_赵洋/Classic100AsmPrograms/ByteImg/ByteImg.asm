;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ByteImg.asm
;--------------------------------------------------------------------
;��ˮƽ8������Ϊ1�У��Դ�ֱ8������Ϊ1�е��������꣬��д�����д���ص�
;�ֽڵ�ַ�ĺ���CalcByteAddr���ٶ��Ѿ��趨����ʾ��ʽΪVGA 12H��ʽ����
;��16ɫ��640*480����ˮƽ����80�ֽڣ���ֱ����60�ֽ�

code segment

main proc far
	assume	cs:code
start:
	push ds
	sub  ax, ax
	push ax

	mov  ch, 10
	mov  cl, 20
	call CalcByteAddr

	ret
main endp

;INPUT:
;CH = ˮƽƫ���� ��0 �� 79��
;CL = ��ֱƫ���� ��0 �� 59��
;OUTPUT:
;BX = �Դ���ڴ��ַ
;���㹫ʽ��
;byte address = (CL * 640) + CH
CalcByteAddr proc near

	push	ax
	push	dx
	push	cx

	mov	ax, cx
	mov	ah, 0
	mov	cx, 640
	mul	cx
	pop	cx
	pop	dx

	mov	cl, ch
	mov	ch, 0
	add	ax, cx
	mov	bx, ax
	pop	ax
	ret

CalcByteAddr endp

code ends

	end start