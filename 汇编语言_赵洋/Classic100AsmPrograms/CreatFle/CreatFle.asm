;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; CreatFle.asm
;--------------------------------------------------------------------
;������EXEͬĿ¼�½���һ���������Ե��ļ�TEST.TXT
;дһ�����ļ�����ͬһ���ļ�����дһ�����ļ�ʱ������Ҫ�����ļ���������
;һ�����ԣ����DOS����Ҫ�������ļ��Ѿ����ڣ���ôԭ�����ļ��ͱ��ƻ���
;�������ļ��ĳ�����0�����CFλ��1����Ѵ�����뷵�ص�AX��

data segment
	szFileName	db	'TEST.TXT',0
	hFile		dw	?			;file handle
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
	mov	cx, 0000000000000000B	;Ҫ�����������Ե��ļ�
	call	CreateFile
	
	mov	bx, hFile
	call	CloseFile

	ret
main endp

;����һ���ļ�
;INPUT:
;DS = �ļ�·���������ڶ�
;DX = �ļ�·����(0����)ƫ�Ƶ�ַ
;CX = �ļ�����
;OUTPUT:
;AX = �ļ����
;�������ļ��ĳ�����0�����CFλ��1����Ѵ�����뷵�ص�AX��:
;����ʧ��AX���صĴ��������Ϊ��
;	03: ·��δ�ҵ�
;	04: ͬʱ�򿪵��ļ�̫��
;	05: �ܾ�����
CreateFile proc near
	mov	ah, 3ch			;request create
	int	21h			;call DOS
	jc	@Error			;exit if error
	mov	hFile, ax
@Error:
	ret
CreateFile endp

;�ر�һ���ļ�
;INPUT:
;BX = �ļ����
CloseFile proc near
	mov	ah, 3eh			;request close
	int	21h			;call DOS
	ret
CloseFile endp

code ends

	end start