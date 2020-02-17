;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; RandRead.asm
;--------------------------------------------------------------------
;�����ļ����������ȡ�����ļ�
;������ȡ������NameFile����������ļ�
;�������ļ��е���Լ�¼�ţ���Ļ������ʾ����Ҫ��ļ�¼������ļ��У���
;����¼����ô�Ϸ��ļ�¼��Ϊ��������������Ҫ�Ӽ���������ļ�¼����
;���ӣãɣ������ʽ�����Լ�¼��Ӧ���ǣ�λ���ֻ�λ���֣�ÿ����¼��
;�ĳ����ǣ����ֽ�
;����KeyBoardInputProcess�Ӽ��̽��ռ�¼�Ų�������ĳ��ȣ��У������
;00 = �����������
;01 = ��λ��¼�ţ������ڣ�����
;02 = ��λ��¼�ţ������ڣ�����
;���Ű�����ļ�¼��ת��Ϊ�ļ��е��ֽ��������磬�Ӽ����������֣���
;�����еõ��������������Σ�ָ�����Ϊ����������������ָ���ֽ�
;��������ת��Ϊ�������ã�(12),�ӣȣ�ָ���ٽ������ƣ�λ���ˣ������
;����������(384),��������ļ��ģ������ֽڿ�ʼ�ģ����ֽڼ�һ����¼��
;����ȡ����ʾ������

data segment
	hFile		dw	?			;file handle
	szBuffer	db	32 dup(' ')
	szFileName	db	'NAME.DAT',0
	nIndex		dw	?			;record index
	ErrorCode	db	0			;Error indicator
	Prompt		db	'Record Number? '
	OpenErrorMsg	db	'Open file error!',13,10
	MoveErrorMsg	db	'Move file pointer error!',13,10
	ReadErrorMsg	db	'Read file error!',13,10
	Row		db	0
	Col		db	0
	ReadPar		label	byte		;input parameter list
	MaxLen		db	3		;maximum length
	ActLen		db	?		;actual length
	RecordNo	db	3 dup(' ')	;record number
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
	call	KeyBoardInputProcess	;request record number
	cmp	ActLen, 0		;any more request?
	je	@Exit			;no, exit
	call	MoveFilePointer		;move file pointer
	call	Read32Bytes		;read disk record	
	cmp	ErrorCode, 0		;normal read?
	jnz	@Continue		;no bypass
	call	DisplayRecord		;yes display it
	jmp	@Continue		;continue

@Exit:
	call	CloseFile		;yes, close
	ret
main endp


;�����ļ�,�Ѵ��ű�����hFile��
OpenFile proc near
	mov	ah, 3dh			;request open
	mov	al, 0			;normal file
	lea	dx, szFileName		
	int	21h			;call DOS
	jc	@OFError			;exit if error
	mov	hFile, ax		;no, save handle
	ret
@OFError:
	mov	ErrorCode, 1		;yes
	lea	dx, OpenErrorMsg	;error message
	call	ShowErrorMsg
	ret
OpenFile endp


KeyBoardInputProcess proc near
	mov	ah, 40h			;request display prompt
	mov	bx, 1			;CRT file handle
	mov	cx, 15			;15 characters
	lea	dx, Prompt
	int	21h
	mov	ah, 0ah			;request input
	lea	dx, ReadPar		;of record number
	int	21h
	cmp	ActLen,	1		;check length
	jb	@KBExit			;length 0, terminate
	ja	@TwoDigits		;length = 2
	xor	ah, ah			;length = 1
	mov	al, RecordNo		;
	jmp	@Convert

@TwoDigits:
	mov	ah, RecordNo		;length = 2
	mov	al, RecordNo+1

@Convert:
	and	ax, 0f0fh		;clear ASCII 3s
	aad				;convert to binary
	dec	ax			;adjust (first reord is 0)
	mov	cl, 5
	shl	ax, cl			;multiply by 32
	mov	nIndex, ax		;save index	

@KBExit:
	mov	Col, 20
	call	SetCursor
	ret

KeyBoardInputProcess endp

;�ƶ��ļ�ָ��
MoveFilePointer proc near
	mov	ah, 42h			;request set file pointer
	mov	al, 0			;to start file
	mov	bx, hFile		;file handle
	mov	cx, 0			;high word of offset number
	mov	dx, nIndex		;low word of offset number
	int	21h
	jc	@MFPError
	ret
@MFPError:
	mov	ErrorCode, 1		;yes
	lea	dx, MoveErrorMsg	;error message
	call	ShowErrorMsg
	ret
	
MoveFilePointer endp

;�ӵ�ǰָ��λ�ö�ȡ�����ֽ�
Read32Bytes proc near
	
	mov	ah, 3fh			;request read
	mov	bx, hFile		;file handle
	mov	cx, 32			;for name and CR/LF
	lea	dx, szBuffer
	int	21h			;call DOS
	jc	@R32BError		;valid read?
	cmp	szBuffer, 1ah		;EOF mark?
	je	@R32BExit		;yes, exit
	ret

@R32BError:
	lea	dx, ReadErrorMsg	;no, invalid read
	call	ShowErrorMsg
@R32BExit:
	mov	ErrorCode, 1		;force end
	ret
Read32Bytes endp

;��ʾ��¼������
DisplayRecord proc near
	mov	ah, 40h			;request display
	mov	bx, 01			;set handle
	mov	cx, 32			;and length
	lea	dx, szBuffer
	int	21h
	
	mov	Col, 0			;clear column
	cmp	Row, 20			;bottom of screen?
	jae	@NeedScrollScreen	;yes, bypass
	inc	Row
	ret
@NeedScrollScreen:
	mov	ax, 0601h
	call	ScrollScreen
	call	SetCursor
	ret

DisplayRecord endp

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
	mov	ah, 2
	mov	bh, 0
	mov	dh, Row			;set cursor
	mov	dl, Col			;column
	int	10h
	ret
SetCursor endp

;Show error msg
ShowErrorMsg proc near
	mov	ah, 40h			;of message
	mov	bx, 1			;handle
	mov	cx, 20			;length of message
	int	21h
	inc	Row
	ret
ShowErrorMsg endp

code ends

	end start