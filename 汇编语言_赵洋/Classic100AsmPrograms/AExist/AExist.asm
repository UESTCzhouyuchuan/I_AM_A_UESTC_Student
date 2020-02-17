;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; AExist.asm
;--------------------------------------------------------------------
;�ж��������������Ƿ����Ѿ���ʽ��������

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
	BadDiskMsg	db	'No, there is not a floopy disk in drive A.',13,10
	GoodDiskMsg	db	'Yes, a floopy disk in drive A is avalable.',13,10
	nGoodDiskMsgLen	equ	$-GoodDiskMsg
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

	call	IsThereAExist
	jc	@BadDisk
	lea	dx, GoodDiskMsg
	mov	cx, nGoodDiskMsgLen
	call	ShowTestResult
	ret

@BadDisk:
	lea	dx, BadDiskMsg
	mov	cx, GoodDiskMsg-BadDiskMsg
	call	ShowTestResult
	ret
main endp

;�ж��������������Ƿ����Ѿ���ʽ��������
;OUTPUT:
;AL = ʵ�ʼ�⵽��������
IsThereAExist proc near
	mov	ah, 4		;request verify
	mov	al, 1		;one sector
	mov	ch, 0		;track 0
	mov	cl, 1		;sector 1
	mov	dh, 0		;head 0
	mov	dl, 0		;drive 0(Floopy B)
	int	13h		;call BIOS
	ret
IsThereAExist endp


;����Ļ����ʾ�����
ShowTestResult proc near
	mov	ah, 3fh			;request read function
	mov	bx, 1			;handle 1 = CRT
	int	21h			;call DOS
	ret
ShowTestResult endp

code ends

	end start