;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; ChDevHdl.asm
;--------------------------------------------------------------------
;������ʾ�����ַ��豸���ļ������÷�
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
	buffer	db	80 dup(?)
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
	mov	dx, offset buffer	;buffer offset
	mov	cx, 80			;buffer size
	call	GetStringFromKeyBoard
	
	mov	cx, 80			;buffer size
	call	PutStringOnDisplayer


	ret
main endp


;�Ӽ�������һ���ַ���������
;INPUT:
;DS = ���������ڶ�
;DX = ������ƫ�Ƶ�ַ
;CX = ��������С
GetStringFromKeyBoard proc near
	mov	ah, 3fh			;request read function
	mov	bx, 0			;handle 0 = KeyBoard
	int	21h			;call DOS
	jc	@GSFKBError
@GSFKBError:
	ret
GetStringFromKeyBoard endp


;�ӱ�׼����豸(��������ʾ��)����ַ���
;INPUT:
;DS = �ַ������������ڶ�
;DX = �ַ���������ƫ�Ƶ�ַ
;CX = �ַ�������
PutStringOnDisplayer proc near
	mov	ah, 40h			;request write function
	mov	bx, 1			;handle 1 = maybe CRT
	int	21h			;call DOS
	jc	@PSODError
@PSODError:
	ret
PutStringOnDisplayer endp


;�ӿ���̨(������ʾ��)����ַ���
;INPUT:
;DS = �ַ������������ڶ�
;DX = �ַ���������ƫ�Ƶ�ַ
;CX = �ַ�������
PutStringOnConsole proc near
	mov	ah, 40h			;request write function
	mov	bx, 2			;handle 2 = console(always CRT)
	int	21h			;call DOS
	jc	@PSOCSError
@PSOCSError:
	ret
PutStringOnConsole endp


;�Ӵ�������ַ���
;INPUT:
;DS = �ַ������������ڶ�
;DX = �ַ���������ƫ�Ƶ�ַ
;CX = �ַ�������
PutStringOnComm proc near
	mov	ah, 40h			;request write function
	mov	bx, 3			;handle 3 = communication
	int	21h			;call DOS
	jc	@PSOCError
@PSOCError:
	ret
PutStringOnComm endp


;�Ӵ�ӡ������ַ���
;INPUT:
;DS = �ַ������������ڶ�
;DX = �ַ���������ƫ�Ƶ�ַ
;CX = �ַ�������
PutStringOnPrinter proc near
	mov	ah, 40h			;request write function
	mov	bx, 4			;handle 4 = printer
	int	21h			;call DOS
	jc	@PSOPError
@PSOPError:
	ret
PutStringOnPrinter endp

code ends

	end start