;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; OrdeRead.asm
;--------------------------------------------------------------------
;�������ļ�����(���)˳��ض�ȡһ���ļ�
;һ���ļ��ּ��ζ�ȡȡ�����ļ��Ĵ�С�����뻺�����Ŀռ䣬����ļ��Ƚ�С
;�����㹻�����뻺����������һ�ε��þ��ܶ��������ļ������ݣ�����ļ���
;��,�����в���������˴󻺳����������ѭ�����ö�ȡ���ܣ�ֱ�������ļ�
;������
;������ȡ������NameFile����������ļ�
;
;�ó������һ����������ɵ��ļ������������º����飺
;1) OpenFile ����int 21��3dh���ܵ����������ļ��Ѵ��ű�����hFile��
;2) ReadFile ����int 21��3fh���ܵ�����д�ļ�
;3) DisplayFile ��ʾ��¼������
;4) CloseFile ����int 21��3eh���ܵ������ر��ļ�

data segment
	ErrorCode	db	0			;End process indicator
	hFile		dw	?			;file handle
	szBuffer	db	32 dup(' ')
	szFileName	db	'NAME.DAT',0
	OpenErrorMsg	db	'open file error!',13,10,'$'
	ReadErrorMsg	db	'write file error!',13,10,'$'
	Row		db	0
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
	mov	es, ax

	mov	ax, 0600h
	call	ScrollScreen		;scroll screen
	call	SetCursor		;set cursor
	call	OpenFile		;open file, set DTA
	cmp	ErrorCode, 0		;valid open?
	jnz	@Exit			;no, exit		

@Continue:
	call	ReadFile		;read disk record	
	cmp	ErrorCode, 0		;normal read?
	jnz	@Exit
	call	DisplayFile		;yes display it
	jmp	@Continue		;continue

	call	CloseFile		;yes, close

@Exit:
	ret
main endp


;�����ļ�,�Ѵ��ű�����hFile��
OpenFile proc near
	mov	ah, 3dh			;request open
	mov	al, 0			;normal file
	lea	dx, szFileName		
	int	21h			;call DOS
	jc	@Error			;exit if error
	mov	hFile, ax		;no, save handle
	ret
@Error:
	mov	ErrorCode, 01		;yes
	lea	dx, OpenErrorMsg	;error message
	call	ShowErrorMsg
	ret
OpenFile endp


;���ļ�
;������ڴ�д���ļ��ɹ�����CF=0����ʵ��д���ֽ�������AX
;�����������ʵ��д���ֽ�������С��Ҫ��д���ֽ���
ReadFile proc	near
	mov	ah, 3fh			;request read
	mov	bx, hFile		;file handle
	mov	cx, 32			;for name and CR/LF
	lea	dx, szBuffer
	int	21h			;call DOS
	jc	@ErrorRead		;valid read?
	cmp	ax, 0			;end of file?
	je	@EndRead
	cmp	szBuffer, 1ah		;EOF mark?
	je	@EndRead		;yes, exit
	ret

@ErrorRead:
	lea	dx, ReadErrorMsg	;no, invalid read
	call	ShowErrorMsg
@EndRead:
	mov	ErrorCode, 1		;force end
	ret
ReadFile endp

;��ʾ��¼������
DisplayFile proc near
	mov	ah, 40h			;request display
	mov	bx, 01			;set handle
	mov	cx, 32			;and length
	lea	dx, szBuffer
	int	21h
	
	cmp	Row, 24			;bottom of screen?
	jae	@NeedScrollScreen	;yes, bypass
	inc	Row
	ret
@NeedScrollScreen:
	mov	ax, 0601h
	call	ScrollScreen
	call	SetCursor
	ret

DisplayFile endp

;�ر��ļ�
CloseFile proc near
	mov	bx, hFile		;file handle
	mov	ah, 3eh			;request close
	int	21h			;call DOS
	ret
CloseFile endp

;Scroll Screen
ScrollScreen proc near
	mov	bh, 1eh			;set yellow on blue
	mov	cx, 0
	mov	dx, 184fh
	int	10h			;scroll
	ret
ScrollScreen endp


;Set cursor
SetCursor proc near
	mov	ah, 02
	mov	bh, 0
	mov	dh, Row			;set cursor
	mov	dl, 0
	int	10h
	ret
SetCursor endp

;Show error msg
ShowErrorMsg proc near
	mov	ah, 40h			;of message
	mov	bx, 01			;handle
	mov	cx, 20			;length of message
	int	21h
	ret
ShowErrorMsg endp

code ends

	end start