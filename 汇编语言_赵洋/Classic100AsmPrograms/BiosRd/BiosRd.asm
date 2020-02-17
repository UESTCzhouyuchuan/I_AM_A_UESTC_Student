;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; BiosRd.asm
;--------------------------------------------------------------------
;�������ã£ɣϣ�ָ��ʵ���˶�����
;���������������ÿһ�����̵�ַ��ÿ�ζ�����֮�������ţ�����������
;�żӵ�������������������Ϊ������������ǣ������Ӵŵ��ţ�Ȼ��ı�����
;�����ɣ���Ϊ�����ɣ���Ϊ��
;������������CurrentAddr������ʼ�Ĵŵ�/�����ַ��EndAddr���������Ĵ�
;��/�����ַ

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

data segment
	Buffer		db	512 dup(' ')
	EndCode		db	0
	CurrentAddr	dw	0304h			;beginning track/sector
	EndAddr		dw	0501h			;Ending track/sector
	ReadErrorMsg	db	'Read error!'
	Side		db	0
	User		db	1, 1 dup(?)		;user input
data ends

code segment
	assume	cs:code, ds:data

main proc near

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax
	mov     es, ax

	mov	ax, 0600h			;request scroll

@Continue:
	call	ScrollScreen			;Scroll screen
	call	SetCursor			;set cursor
	call	CalcNextDiskAddr		;calculate next disk address
	mov	cx, CurrentAddr			;
	mov	dx, EndAddr			;
	cmp	cx, dx				;is at ending sector?
	je	@Exit				;yes, exit
	call	ReadDiskRecord			;read disk record
	cmp	EndCode, 0			;normal read?
	jnz	@Exit				;no, exit
	call	DisplaySector			;display sector content
	jmp	@Continue

@Exit:
	ret
main endp

;calculate next disk address
CalcNextDiskAddr proc near
	mov	cx, CurrentAddr			;get track/sector
	cmp	cl, 10				;pass last sector
	jne	@CNDAExit			;no, exit
	cmp	Side, 0				;bypass if Side = 0
	je	@ChangeSide			;
	inc	ch

@ChangeSide:
	xor	Side, 1				;change Side
	mov	al, 1				;set sector to 1
	mov	CurrentAddr, cx

@CNDAExit:
	ret

CalcNextDiskAddr endp


;OUTPUT:
;AL = ʵ�ʶ�ȡ��������
ReadDiskRecord proc near
	mov	ah, 2		;request read
	mov	al, 1		;one sector
	lea	bx, Buffer	;input buffer at ES:BX
	mov	cx, CurrentAddr	;track/sector
	mov	dh, Side	;head 0
	mov	dl, 0		;drive A(Floopy A)
	int	13h		;call BIOS
	cmp	ah, 0		;normal read?
	jz	@IncreaseSector ;yes, exit
	mov     EndCode, 1	;no
	call	ShowErrorMsg	;invlaid read

@IncreaseSector:
	inc	CurrentAddr	;increase sector
	ret
ReadDiskRecord endp


;display sector
DisplaySector proc near
	mov	ah, 40h			;request display
	mov	bx, 1			;handle
	mov	cx, 512			;length
	lea	dx, Buffer		;address of input
	int	21h
@Wait:
	mov	ah, 0ah			;user input
	lea	dx, User
	int	21h
	cmp	User+1, 0dh
	je	@Wait			;wait until user input return

	ret
DisplaySector endp

;clear screen
ScrollScreen proc near
	mov	ax, 0600h		;full screen
	mov	bh, 1eh			;set color
	mov	cx, 0			;request scroll
	mov	dx, 184fh
	int	10h
	ret
ScrollScreen endp

;set cursor
SetCursor proc near
	mov	ah, 02			;request set cursor
	mov	bh, 0
	mov	dx, 0
	int	10h
	ret
SetCursor endp

;disk error function
ShowErrorMsg proc near
	mov	ah, 40h			;request display
	mov	bx, 1			;handle
	mov	cx, 11			;length of message
	lea	dx, ReadErrorMsg
	int	21h
	ret
ShowErrorMsg endp

code ends

	end start