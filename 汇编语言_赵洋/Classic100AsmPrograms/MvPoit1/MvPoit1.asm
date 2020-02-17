;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; MvPoit1.asm
;--------------------------------------------------------------------
;��ȡһ���ļ�ʱ�ƶ���дָ��
;Ϊ�˴�ȡ�ļ��м�ĳһ�ض��ļ�¼������Ҫʹ��дָ��ָ�������¼���ģϣ�
;�ṩ���ƶ���дָ��Ĺ��ܣ����ȣ��ù���Ҫ���ڣ£���ָ���ļ����ţ���
;�����еĴ���ȷ���ƶ�ָ��ģ��ַ�ʽ��
;AL = 00: �����ƶ���ƫ��ֵ���ļ��׿�ʼ����
;AL = 01: ����ƶ�����ǰ��ָ��ֵ����ƫ��ֵ��Ϊ�µ�ָ��ֵ
;AL = 02: ���Ե��ƣ��µ�ָ��λ��ͨ����ƫ��ֵ���ļ�βλ����Ӷ�ȷ��

;��ÿ�ַ�ʽ�£��ɣãغͣģ�ָ��һ��˫�ֳ���ƫ��ֵ����λ���ڣģ��У���
;λ���ڣã��У����ƫ��ֵ��һ�������ŵ�����������������Ҳ�����Ǹ���
;������ȡ������NameFile����������ļ�

data segment
	hFile		dw	?			;file handle
	szBuffer	db	32 dup(' ')
	szFileName	db	'NAME.DAT',0
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

	call	OpenFile		;open file, set DTA

	mov	cx, 0
	mov	dx, 64
	call	AbsoluteMove		;move file pointer
	call	Read32Bytes		;read disk record
	call	ShowBuffer

	mov	cx, 0
	mov	dx, -96
	call	RelativeMove
	call	Read32Bytes		;read disk record
	call	ShowBuffer
	
	;��ָ��ָ���ļ�β��һ����¼
	mov	cx, 0
	not	cx
	mov	dx, -64
	call	InvertedMove
	call	Read32Bytes		;read disk record
	call	ShowBuffer

	call	CloseFile		;yes, close

	ret
main endp


;�����ļ�,�Ѵ��ű�����hFile��
OpenFile proc near
	mov	ah, 3dh			;request open
	mov	al, 0			;normal file
	lea	dx, szFileName		
	int	21h			;call DOS
	mov	hFile, ax		;no, save handle
	ret
OpenFile endp

;INPUT:
;DX = ���ļ��׿�ʼƫ��ֵ��λ��
;CX = ���ļ��׿�ʼƫ��ֵ��λ��
AbsoluteMove proc near
	mov	ah, 42h		;request move pointer
	mov	al, 0		;to start of file
	mov	bx, hFile	;set file handler
	int	21h
	ret
AbsoluteMove endp


;INPUT:
;DX = ���ļ��׿�ʼƫ��ֵ��λ��
;CX = ���ļ��׿�ʼƫ��ֵ��λ��
RelativeMove proc near
	mov	ah, 42h		;request move pointer
	mov	al, 1		;relative move
	mov	bx, hFile	;set file handler
	cmp	dx, 0
	jge	@GreatEq0	;>=0
	not	cx		;extending the sign

@GreatEq0:
	int	21h
	ret
RelativeMove endp

;INPUT:
;DX = ���ļ��׿�ʼƫ��ֵ��λ��
;CX = ���ļ��׿�ʼƫ��ֵ��λ��
InvertedMove proc near
	mov	ah, 42h		;request move pointer
	mov	al, 2		;inverted move
	mov	bx, hFile	;set file handler
	int	21h
	ret
InvertedMove endp

;���ļ�
;������ڴ�д���ļ��ɹ�����CF=0����ʵ��д���ֽ�������AX
;�����������ʵ��д���ֽ�������С��Ҫ��д���ֽ���
Read32Bytes proc near
	mov	ah, 3fh			;request read
	mov	bx, hFile		;file handle
	mov	cx, 32			;for name and CR/LF
	lea	dx, szBuffer
	int	21h			;call DOS
	ret
Read32Bytes endp

;�ر��ļ�
CloseFile proc near
	mov	bx, hFile		;file handle
	mov	ah, 3eh			;request close
	int	21h			;call DOS
	ret
CloseFile endp


;Show error msg
ShowBuffer proc near
	lea	dx, szBuffer		;message
	mov	ah, 40h			;of message
	mov	bx, 01			;handle
	mov	cx, 32			;length of message
	int	21h
	ret
ShowBuffer endp

code ends

	end start