;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Cls2.asm
;��������������������������������������������������������������������
;������Ͻ�Ϊ�������������½�Ϊ���������������Ĵ��ڵĳ��򣬳�ʼ��Ϊ
;������ʾ���ô����൱��ȫ��Ļ����벿��

;int 10h����7��ʹ��Ļ�����¾�ָ�����У����������Ҫ���ã���������
;�����Ļ����ʼ���в�Ϊ�����������������в�Ϊ������������������
;��Ļֻ��ָ����һ���־����Ͼ�Ĺ��ܣ������Ļ�ϵĲ��������������
;�������Ĵ��ڿ�������Ļ�����ö������Щ���ڶ����Զ���ʹ�ã����
;�Ͼ���ָ�����ڵĶ�������Щ�е����ݾ���ʧ�������ڴ��ڵײ�������
;����Ϊ�ո��������ɣ£ȼĴ���������������̣�������ʵ����ɵ�
;�����������Ļ���ݣ������������е�blank�ַ�������ʹָ���Ĵ���Ϊ
;�հ�

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	call	ClearScreen

	ret
main endp


ClearScreen proc near uses ax bx cx dx
	
	;clear screen
	mov	ah, 7		;to scroll up screen
	mov	al, 0		;blank screen
	mov	bh, 70h		;reverse video attribute
	mov	ch, 0		;up left row
	mov	cl, 0		;up left col
	mov	dh, 24		;low right row
	mov	dl, 39		;low right col
	int	10h

	;locate cursor
	mov	dx, 0
	mov	ah, 2
	int	10h

	ret
ClearScreen endp

code ends

	end start