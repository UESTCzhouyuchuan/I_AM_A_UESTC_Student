;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; IsVGA.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;调用BIOS的ＩＮＴ　１０Ｈ设置显示方式
;确定系统是否装备有ＶＧＡ图形适配器, 是否装备有ＥＧＡ图形适配器

code segment
	assume	cs:code

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax
	
	call	IsVGA
	call	IsEGA
	;call	IsEGAActived

	ret
main endp

IsVGA proc near

	mov	ah, 1ah		;Request VGA function
	mov	al, 0		;and sub function 0
	int	10h		;BIOS video ROM call 

	cmp	al, 1ah		;if AL contains 1ah on return
	je	@YesVGA
	mov	al, 'N'
@YesVGA:
	mov	al, 'Y'
	mov	ah, 0eh
	mov     bh, 0
	int     10h

	ret
IsVGA	endp


IsEGA	proc near

	mov	ah, 12h		;Request EGA function
	mov	bl, 10h		;and sub function 10h
	int	10h		;BIOS video ROM call 

	cmp	bl, 10h		;if BL no longer contains 10h
	je	@YesEGA
	mov	al, 'N'
@YesEGA:
	mov	al, 'Y'
	mov	ah, 0eh
	mov     bh, 0
	int     10h

	ret
IsEGA endp

;因为系统可能同时安装了ＥＧＡ，ＭＤＡ，ＣＧＡ，所以还要确定ＥＧＡ是否在激活状态，
;ＢＩＯＳ的数据区的４０：８７字节中包含了有关ＥＧＡ的信息，其中第３位为０时表示
;ＥＧＡ是激活的，为１则说明没有ＥＧＡ被激活，系统中还存在另一个适配器
IsEGAActived proc near
	push	ds
	mov	ax, 400h
	mov	ds, ax
	mov	dx, 87h
	test	dx, 8
	je	@EGAinfo
	mov	al, 'N'
@EGAinfo:
	mov	al, 'Y'
	mov	ah, 0eh
	mov     bh, 0
	int     10h
	pop	ds
	ret
IsEGAActived endp

code ends

	end start