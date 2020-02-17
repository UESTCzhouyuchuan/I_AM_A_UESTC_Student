;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ByteMask.asm
;--------------------------------------------------------------------
;�������ص��ֽ�λ�ú�λ������ӳ���
;�ٶ��Ѿ��趨����ʾ��ʽΪVGA 12H��ʽ������16ɫ��640*480��
;��ˮƽ����80�ֽڣ���ֱ����60�ֽڡ�����VGA 12H��һ���������̣�����ָ
;�����ص�x���꣨0-639����y���꣨0-479���������Դ��е��ֽڵ�ַ���Լ�
;���ڷ��뵥�����ص�λ���룬����дģʽ0��2�����λ����������ͼ�ο�
;������λ���μĴ����С�
;ȷ��λ����һ�������ַ�����
;1)ͨ�ض�һ������λģʽ(10000000B)������������룬��λ������x�������
;8�õ�����������������(18��0),X/8��������2��������λ������2����õ�
;λ������00100000B
;2)�����������Ϊ����ֵ��ȥ��һ��������8������ı�����0��Ӧ10000000B
;����1��Ӧ01000000B,... ... �������ơ�
;�������������ƻ���λģʽ�������������ļ���

code segment

main proc far
	assume	cs:code
start:
	push ds
	sub  ax, ax
	push ax

	mov  cx, 100
	mov  dx, 200
	call GetByteMask

	ret
main endp

;�������ص��ֽ�λ�ú�λ������ӳ���
;INPUT:
;CX = ˮƽ����ƫ���� ��0 �� 639��
;DX = ��ֱ����ƫ���� ��0 �� 479��
;OUTPUT:
;BX = �Դ���ڴ�ƫ�Ƶ�ַ
;AH = λ����
;���㹫ʽ��
;BX = (DX * 80) + CX/8
;AH = 10000000B >> ( CX mode 8 )
GetByteMask proc near

	push	cx	;save all entry registers
	push	dx

	;compute address
	push	ax	;save accummulator
	push	cx	;save x coordinate

	mov	ax, dx	;y coordinate to ax
	mov	cx, 80	;multiplier(80 byte per row)
	mul	cx	;now, ax = y*80
	mov	bx, ax  ;now, bx = y*80, and also ax = y*80
	pop	ax	;x coordinate from stack

	;prepear for division
	mov	cl, 8
	div	cl	;AX/CL=quotient in AL and remainder in AH
	
	;add in quotient
	mov	cl, ah	;save remainder in cl
	mov	ah, 0	;clear high-order byte
	add	bx, ax	;offset into buffer to BX
	pop	ax	;

	;compute bit mask from remainder
	mov	ah, 10000000B	;unit mask for 0 remainder
	shr	ah, cl		;shift right cl times

	;restore all entry registers
	pop	dx
	pop	cx

	ret

GetByteMask endp

code ends
	end start