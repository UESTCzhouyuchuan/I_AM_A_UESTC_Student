;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; RdSector.asm
;--------------------------------------------------------------------
;��һ�������������뵽һ��������,Ȼ�����һ����ΪSector.dat���ļ���
;BIOS���̲����ɣΣԡ������ȴ���ļ�¼����һ������(512 bytes)�Ĵ�С��
;������ʵ�ʵĴŵ��ź�������Ѱַ�ġ�����д�ͼ�������ļ�֮ǰ���Ȱ�
;���мĴ�����ʼ����
;AH = Ҫִ�еĲ�������λ(0),��״̬(1),������(2),д����(3) ��������(4)
;AL = ������
;CH = ����/�ŵ���(0Ϊ��ʼ��)
;CL = ��ʼ������(1Ϊ��ʼ��)
;DH = ��ͷ/����ţ��������ǣ���
;DL = ��������: ����:0=����������1=�������£�...
;		Ӳ��:80h=����������81h=����������...
;ES:BX = �������У�/�ϻ������ĵ�ַ(�����������)

;�ڴ��������£�����ָֻ����һ���������ȡһ���ŵ��ϵ�ȫ��������
;������ֻ��˳���ȡ�ãȺͣã�ָ�����������ݣ��������ãȺͣã��еĴŵ�
;�ź������ţ���������ų����˴ŵ�����������ţ�����������������ã���
;���Ѵŵ������������߰�˫���̵ģ���䣱�档
;
data segment
	szFileName		db	'Sector.dat',0
	hFile			dw	?			;file handle
	Buffer			db	512 dup('0')
	nBytes			equ     $-Buffer
	ReadSectorFailedMsg	db	'Failed to read 1 sector',13,10
	nFailMsgLen		equ	$-ReadSectorFailedMsg
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
	mov     es, ax

	call	ReadOneSector
	cmp	al, 1
	lea	dx, ReadSectorFailedMsg
	jne	@Error
	mov	dx, offset szFileName
	mov	cx, 0000000000000000B	;Ҫ�����������Ե��ļ�
	call	CreateFile
	mov	bx, hFile
	mov	cx, nBytes
	mov	dx, offset Buffer
	call	WriteFile

	mov	bx, hFile
	call	CloseFile

	ret

@Error:
	call	PutErrorStringOnCRT
	ret
main endp

;OUTPUT:
;AL = ʵ�ʶ�ȡ��������

ReadOneSector proc near
	mov	ah, 2		;request read
	mov	al, 1		;one sector
	lea	bx, Buffer	;input buffer at ES:BX
	mov	ch, 5		;track 5
	mov	cl, 3		;sector 3
	mov	dh, 0		;head 0
	mov	dl, 1		;drive 1(Floopy B)
	int	13h		;call BIOS
	ret
ReadOneSector endp


;�Ӽ�������һ���ַ���������
PutErrorStringOnCRT proc near
	mov	ah, 3fh			;request read function
	mov	bx, 1			;handle 1 = CRT
	mov	cx, nFailMsgLen
	int	21h			;call DOS
	ret
PutErrorStringOnCRT endp


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
	jc	@CFError		;exit if error
	mov	hFile, ax
@CFError:
	ret
CreateFile endp


;д�ļ�
;INPUT:
;BX = �ļ����ż����
;CX = Ҫд����ֽ���
;DX = ���뻺�����ĵ�ַ
;OUTPUT:
;������ڴ�д���ļ��ɹ�����CF=0����ʵ��д���ֽ�������AX
;�����������ʵ��д���ֽ�������С��Ҫ��д���ֽ���
WriteFile proc	near
	mov	ah, 40h			;request write
	int	21h			;call DOS
	jc	@WFError1		;special action is error
	cmp	ax, nBytes		;all bytes written?
	jne	@WFError2

@WFError1:

@WFError2:
	ret
WriteFile endp

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