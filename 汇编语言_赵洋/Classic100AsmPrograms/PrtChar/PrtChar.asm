;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; PrtChar.asm
;��������������������������������������������������������������������
;��ӡ�ַ���������һ�����ò�ѯ��ʽ�Ĵ�ӡ�ַ�����ͨ��������ȡ������
;��ӡ����״̬������������ڴ�ӡ���ӿ��У����ݼĴ����Ķ˿ڵ�ַΪ��������
;״̬�Ĵ����Ķ˿�Ϊ�������ȣ����ƼĴ����Ķ˿ڵ�ַΪ��������


data segment
	mess		db	'Printer is normal',0dh,0ah
	count		equ	$ - mess
data ends

code segment
	assume	cs:code, ds:data

main proc far
start:
	mov	ax, data
	mov	ds, ax

	mov	si, offset mess
	mov	cx, count

next:
	mov	dx, 379h
query:
	in	al, dx
	test	al, 80h		;80h = 1000 0000 B,��ѯ��ӡ��״̬�Ĵ�����æ��λ
	je	query

	;��һ�ַ�����ӡ�����ݼĴ���
	mov	al, [si]
	mov	dx, 378h
	out	dx, al

	;�Ϳ���������ӡ���Ŀ��ƼĴ���
	mov	dx, 37ah
	mov	al, 0dh		;0dh = 0000 1101 B,ѡͨ����ʼ������ͨ��ӡ��
	out	dx, al
	
	;�ٴ��Ϳ���������ӡ���Ŀ��ƼĴ���
	mov	al, 0ch		;0ch = 0000 1100 B,��ʼ������ͨ��ӡ��
	out	dx, al

	;�����������Ա�����һ�ַ�����ӡ��
	inc	si
	loop	next

	mov	ax, 4c00h
	int	21h
main endp

code ends
	
	end start
