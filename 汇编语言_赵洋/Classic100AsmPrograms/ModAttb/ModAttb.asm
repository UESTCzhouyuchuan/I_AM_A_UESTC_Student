;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ModAttb.asm
;--------------------------------------------------------------------
;�ı������ļ������ԣ�ע�Ȿ���ٶ�ӵ�г������Ե�D:\ModAttb.dat�ļ�����
;Ϊ�˼������Ч����������ǰ�����Լ�����D�̸�Ŀ¼���ֶ�����һ������
;���ļ�

data segment
	szFileName	db	'D:\ModAttb.dat',0
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

	mov	dx, offset szFileName
	call	ModifyFileAttribute

	ret
main endp

;�ı������ļ�������
;INPUT:
;DS = �ļ�����·���������ڶ�
;DX = �ļ�����·����(0����)ƫ�Ƶ�ַ
;OUTPUT:
;����D:\ModAttb.dat�ļ�������Ϊ��ֻ�������أ�ϵͳ���鵵
;����ʧ��AX���صĴ��������Ϊ��
;	01(�Ƿ����ܺ�)
;	02(�ļ�δ�ҵ�)
;	03(·��δ�ҵ�)
;	05(�ܾ�����)
ModifyFileAttribute proc near
	mov	ah, 43h			;check or change attribute
	mov	al, 01			;set file attribute
	mov	cx, 0000000000100111B	;���е�1���α�ʾ�鵵��ϵͳ�����أ�ֻ��
	int	21h			;call DOS
	ret
ModifyFileAttribute endp

code ends

	end start