;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Asc2Bin.asm, ��MASM6.11������nmake�������ӣ���֧��ջ����
;��������������������������������������������������������������������
;���ԣ��ӣãɣ���ʽ��ʾ��ʮ������ת��Ϊ��������

.model	small
.386
.stack 200h
.data
	ascval	db	'12345'
	binval	dw	?

.code
main proc
start:
	mov	ax, @data
	mov	ds, ax

	lea	bx, ascval
	push	bx
	lea	bx, binval
	push	bx
	call	convascbin

	mov	ax, 4c00h
	int	21h
main	endp

convascbin proc pascal uses ax bx cx si di par1:word, par2:word

	local	asclen:word, mulfact:word
	mov	bx, 10
	mov	si, par1
	mov	di, par2
	sub	di, si
	mov	asclen, di
	mov	cx, asclen
	add	si, asclen
	dec	si
	mov	mulfact, 1
	mov	di, par2
	mov	[di], 0

next:
	mov	al, [si]
	and	ax, 000fh
	mul	mulfact
	add	[di], ax
	mov	ax, mulfact
	mul	bx
	mov	mulfact, ax
	dec	si
	loop	next
	ret
convascbin	endp

	end	start

