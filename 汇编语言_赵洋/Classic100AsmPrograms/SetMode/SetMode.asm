;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; SetMode.asm
;--------------------------------------------------------------------
;ѡ��дģʽ��ͨ������
;����ͼ�ο��ƼĴ�����ģʽѡ��Ĵ���Ϊ��������������.���У��ǣ֣ǣ�ϵͳ
;���еģ��ڣţǣ���û�е�ͬ��ģʽ

code segment

main proc far
	assume	cs:code
start:
	push ds
	sub  ax, ax
	push ax

	mov  al, 2
	call SetWriteMode

	ret
main endp

;Set the Graphics controller's graphics mode register to the desired write mode
;INPUT:
;���� = дģʽ ���� �� ����
;also set default bit mask:0ffh
SetWriteMode proc near

	push	ax		;save mode

	mov	dx, 3ceh	;graphics controller address register
	mov	al, 5		;offset of the mode register
	out	dx, al		;select this register
	jmp	short $+2
	mov	dx, 3cfh	;point to data register
	pop	ax		;recover mode in al
	out	dx, al		;selected
	jmp	short $+2

	;set bit mask register to default setting
	mov	dx, 3ceh	;graphics controller address register
	mov	al, 8
	out	dx, al		;select data register 8
	jmp	short $+2
	mov	dx, 3cfh	;to 3cfh
	mov	al, 0ffh	;default mask
	out	dx, al		;load bit mask
	jmp	short $+2

	ret

SetWriteMode endp

code ends

	end start