;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Branch1.asm
;��������������������������������������������������������������������
;��Ծ�����ʵ�֣�
;���ݣ��̼Ĵ�������һλΪ�����ӵ�λ����λ���ѳ���ת�Ƶ�������ͬ�ķ�֧��ȥ

data segment
	branch_table	dw	routine_1
			dw	routine_2
			dw	routine_3
			dw	routine_4
			dw	routine_5
			dw	routine_6
			dw	routine_7
			dw	routine_8
data ends

code segment
	assume cs:code, ds:data

main proc far

start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	cmp	al, 0
	je	continue_main_line
	mov	si, 0

loop1:
	shr	al, 1
	jnb	not_yet
	jmp	branch_table[si]

not_yet:
	add	si, type branch_table
	jmp	loop1

continue_main_line:

routine_1:

routine_2:

routine_3:

routine_4:

routine_5:

routine_6:

routine_7:

routine_8:

	ret
main endp

code ends

	end start