;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; PrtInput.asm
;--------------------------------------------------------------------
;������ʾ�ļ�����ʽ��/��,�Ӽ����������ļ����Ӵ�ӡ�����
;�ַ��豸���ļ������ǣģϣӣ�.��Ϊ�û��ṩ������һ�������Ӳ���ģģϣ�
;���ܣ����õ��ַ��豸���ļ����Ŷ����ɣģϣ�Ԥ�ȶ���õġ���һ���û�����
;�õ�����Ȩ�����͵õ��ˣ����Ѿ��򿪵��ļ����ţ�
;0000 = ��׼�����豸��ͨ���Ǽ���
;0001 = ��׼����豸��ͨ������ʾ��
;0002 = ��������豸��������ʾ��
;0003 = ��׼�����豸��һ��Ϊͨ�Ŷ˿�
;0004 = ��׼��ӡ������������ӡ����
;�豸���ļ����Ž����˶�Ӧ��ϵ���û��Ϳ��Խ���Щ�豸��Ϊ�ļ���
;����ǰ�����豸��/�Ϲ������������������磬�����û�������ԴӼ����ļ�
;����Ҳ���Դӱ���ļ����룬��������ʾ���ļ����Ҳ���������ļ������
;���Ҳ��ش򿪻�ر���Щ�ļ�����Щ�豸�ļ�Ҳû�ж�дָ�롣
;�������룬��ʾ���������ӡ��������豸ʹ�ô���ʽ��/���Ƿǳ��򵥵ġ�

data segment
	Buffer				db	130 dup(?)
	GetStringFromKeyBoardErrorMsg	db	'Get string from keyboard error!',13,10
	PutStringOnPrinterErrorMsg	db	'Put string on printer error',13,10
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax			;buffer segment
	mov     es, ax

	call	InitializePrinter

@Input:
	call	GetStringFromKeyBoard
	mov	dx, offset GetStringFromKeyBoardErrorMsg	;buffer offset
	jc	@Error
	cmp	Buffer, 1ah					;is ctrl + z typed?
	je	@Exit

@Output:
	mov	cx, ax						;number of char
	call	PutStringOnPrinter
	mov	dx, offset PutStringOnPrinterErrorMsg
	jc	@Error
	jmp	@Input

@Error:
	call	PutErrorStringOnCRT		
@Exit:
	ret
main endp

InitializePrinter proc near
	sti
	cld
	mov	ah, 1			;initialize printer
	mov	dx, 0			;printer #0
	int	17h			;call BIOS
	ret
InitializePrinter endp

;�Ӽ�������һ���ַ���������
GetStringFromKeyBoard proc near
	mov	ah, 3fh			;request read function
	mov	bx, 0			;handle 0 = KeyBoard
	mov	dx, offset Buffer	;buffer offset
	mov	cx, 130			;buffer size
	int	21h			;call DOS
	ret
GetStringFromKeyBoard endp

;�Ӽ�������һ���ַ���������
PutErrorStringOnCRT proc near
	mov	ah, 3fh			;request read function
	mov	bx, 1			;handle 1 = CRT
	mov	cx, 40
	int	21h			;call DOS
	ret
PutErrorStringOnCRT endp

;�Ӵ�ӡ������ַ���
;INPUT:
;DS = �ַ������������ڶ�
;DX = �ַ���������ƫ�Ƶ�ַ
;CX = �ַ�������
PutStringOnPrinter proc near
	mov	ah, 40h			;request write function
	mov	bx, 4			;handle 4 = printer
	mov	dx, offset Buffer	;buffer offset
	mov	cx, 130			;buffer size
	int	21h			;call DOS
	ret
PutStringOnPrinter endp

code ends

	end start