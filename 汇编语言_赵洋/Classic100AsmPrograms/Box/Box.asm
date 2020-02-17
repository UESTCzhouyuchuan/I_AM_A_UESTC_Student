;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Box.asm
;--------------------------------------------------------------------
;����Ļ�ϻ�һ�����򣬷���Ĵ�С������Ļ�ϵ�λ��������ģ�ͨ���Ĵ���
;�ѷ���Ĳ������ݸ�������ĺ���Box
;�ٶ��Ѿ��趨����ʾ��ʽΪVGA 13H��ʽ����
;��256ɫ��320*200����ˮƽ����80�ֽڣ���ֱ����50�ֽ�

code segment

main proc far
	assume	cs:code
start:
	push	ds
	sub	ax, ax
	push	ax

	call	SetMode

	mov	ax, 50
	mov	cx, 20
	mov	si, 30
	mov	bp, 40
	call	Box

	ret
main endp

;������ʾ��Ϊ256ɫ��320*200ģʽ����VGA 13H��ʽ
SetMode proc near
	mov	ah, 00h
	mov	al, 13h
	int	10h
	ret
SetMode endp

;����Ļ������λ����ʾһ������ĺ���
;INPUT:
;AX = color (0 �� 255)
;CX = start column (0 �� 319)
;SI = start row (0 �� 199)
;BP = box size
Box proc near

	mov	bx, 0a000h	;video address
	mov	es, bx
	push	ax		;saving color
	mov	ax, 320		;calc start pixel
	mul	si
	mov	di, ax
	add	di, cx
	pop	ax
	push	di		;saving start offset
	mov	cx, bp

BOX1:
	rep	stosb		;drawing top line, ds:si -> es:di
	mov	cx, bp
	sub	cx, 2		;update cx

BOX2:
	pop	di
	add	di, 320		;point to the next row
	push	di
	stosb			;drawing the left side
	add	di, bp
	sub	di, 2
	stosb			;drawing the right side
	loop	BOX2

	pop	di
	add	di, 320		;point to the last row
	mov	cx, bp
	rep	stosb		;drawing bottom line
	
	ret
Box endp

code ends

	end start