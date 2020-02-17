;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Mov2.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;数据段中有一个２０字节的字节表，一个２０字的字表，试编制程序把字节表中
;的每个数据作为字表中的高位字节部分移入字表中
;用比例变址寻址方式编写程序

.model small
.386
.stack 200h

.data
	byte_table	db	20 dup(?)
	word_table	dw	20 dup(?)

.code

start:
	mov	ax, @data
	mov	ds, ax

	xor	esi, esi

next:
	mov	ax, word_table[esi*2]
	mov	ah, byte_table[esi]

	mov	word_table[esi*2], ax
	inc	esi
	cmp	esi, 20
	jl	next


	mov	ax, 4c00h
	int	21h

	end start