;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; BiniHex.asm
;��������������������������������������������������������������������
;��������������������ת������
;������ѣ£ؼĴ����ڵģ��������ã������Ƶ���ʽ����Ļ����ʾ����

program segment

main proc far
	assume cs:program
start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	;main part of prognam
	mov	bx, 16

	mov	ch, 4		;number of digits
rotate:
	mov	cl, 4		;set count to 4 bits
	rol	bx, cl		;left digit to right
	mov	al, bl		;mov to al
	and	al, 0fh		;mask off left digit
	add	al, 30h		;convert hex to ASC2
	cmp	al, 3ah		;is it > 9 ?
	jl	printit		;jump if digit =0 to 9
	add	al,7h		;digit is A to F

printit:
	mov	dl, al
	mov	ah, 2
	int	21h
	dec	ch
	jnz	rotate
	ret

main endp

program ends

	end