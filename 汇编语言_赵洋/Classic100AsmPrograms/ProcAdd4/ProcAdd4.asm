;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ProcAdd4.asm	在MASM6.11环境下nmake编译链接，以支持栈参数
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;用过程累加数组的所有元素，并把和(不考虑溢出的可能性)送到指定的存储
;单元中。　这里用增强功能的过程定义伪操作程序实现

.model	medium
.data
	array	dw	100 dup(?)
	count	dw	100
	sum	dw	?

.stack 200h

.code	code1

main	proc
start:
	mov	ax, @data
	mov	ds, ax

	mov	bx, offset array
	push	bx
	mov	bx, offset count
	push	bx
	mov	bx, offset sum
	push	bx
	call	proadd

	mov	ax, 4c00h
	int	21h
main endp

.code	code2
proadd proc pascal uses ax cx si di,
		para:word,parc:word,pars:word

	mov	si, para
	mov	di, parc
	mov	cx, [di]
	mov	di, pars
	xor	ax, ax
next:
	add	ax, [si]
	add	si, 2
	loop	next

	mov	[di], ax
	ret
proadd endp

	end	start