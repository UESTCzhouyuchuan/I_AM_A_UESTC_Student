;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Branch3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;用基址变址寻址方式实现跳跃表程序：
;根据ＡＬ寄存器中哪一位为１（从低位到高位）把程序转移到８个不同的分支中去

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
	lea	bx, branch_table

	mov	si, 7*type branch_table
	mov	cx, 8

loop1:
	shr	al, 1
	jnb	not_yet
	jmp	word ptr[bx][si]

not_yet:
	sub	si, type branch_table
	loop	loop1

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