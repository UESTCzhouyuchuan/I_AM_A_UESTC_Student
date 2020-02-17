;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; IsVGA.asm
;��������������������������������������������������������������������
;����BIOS�ģɣΣԡ�������������ʾ��ʽ
;ȷ��ϵͳ�Ƿ�װ���У֣ǣ�ͼ��������, �Ƿ�װ���Уţǣ�ͼ��������

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax
	
	call	IsVGA
	call	IsEGA
	;call	IsEGAActived

	ret
main endp

IsVGA proc near

	mov	ah, 1ah		;Request VGA function
	mov	al, 0		;and sub function 0
	int	10h		;BIOS video ROM call 

	cmp	al, 1ah		;if AL contains 1ah on return
	je	@YesVGA
	mov	al, 'N'
@YesVGA:
	mov	al, 'Y'
	mov	ah, 0eh
	mov     bh, 0
	int     10h

	ret
IsVGA	endp


IsEGA	proc near

	mov	ah, 12h		;Request EGA function
	mov	bl, 10h		;and sub function 10h
	int	10h		;BIOS video ROM call 

	cmp	bl, 10h		;if BL no longer contains 10h
	je	@YesEGA
	mov	al, 'N'
@YesEGA:
	mov	al, 'Y'
	mov	ah, 0eh
	mov     bh, 0
	int     10h

	ret
IsEGA endp

;��Ϊϵͳ����ͬʱ��װ�ˣţǣ����ͣģ����ãǣ������Ի�Ҫȷ���ţǣ��Ƿ��ڼ���״̬��
;�£ɣϣӵ��������ģ����������ֽ��а������йأţǣ�����Ϣ�����еڣ�λΪ��ʱ��ʾ
;�ţǣ��Ǽ���ģ�Ϊ����˵��û�Уţǣ������ϵͳ�л�������һ��������
IsEGAActived proc near
	push	ds
	mov	ax, 400h
	mov	ds, ax
	mov	dx, 87h
	test	dx, 8
	je	@EGAinfo
	mov	al, 'N'
@EGAinfo:
	mov	al, 'Y'
	mov	ah, 0eh
	mov     bh, 0
	int     10h
	pop	ds
	ret
IsEGAActived endp

code ends

	end start