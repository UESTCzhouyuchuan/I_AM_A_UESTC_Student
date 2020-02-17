;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; BitIns.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;位串插入程序。把一个小于３２位的位串插入到存储器内的一个大位串中的
;任意位置中去。欲插入的位串存放在bitsg中，它是一个右对齐的位串，可称
;其为子串，其长度用bitsg_length为符合名的＝伪操作来说明，大位串存放在
;string中，并为要插入的子串准备了一个符号名为sg_end的双字单元。这里
;用双字来定义位串的原因在于用双字处理位串可以获得更快的速度

.model	small
.386
.stack	200h
.data
	bitsg		dd	7fffh
	string		dd	12345678h, 12345678h, 12345678h, 12345678h
	sg_end		dd	?
	bit_offset	dd	58

	bitsg_length	=	15

.code
main	proc
start:
	mov	ax, @data
	mov	ds, ax
	mov	es, ax

	mov	cx, bitsg_length
	cmp	cx, 0
	je	exit
	cmp	cx, 32
	jae	exit
	mov	edi, bit_offset
	mov	ecx, (sg_end-string)/4

	shl	ecx, 5
	cmp	edi, ecx
	ja	exit
	jb	move
	mov	esi, bitsg
	mov	sg_end, esi
	jmp	exit

move:
	call	mov_string
	call	insert_bitsg

exit:
	mov	ax, 4c00h
	int	21h
main	endp

mov_string	proc
	sub	eax, eax
	std
	mov	si, offset sg_end-4
	mov	di, offset sg_end
	mov	ecx, (sg_end-string)/4
	mov	ebx, bit_offset
	shr	ebx, 5
	sub	ecx, ebx

next:
	mov	ebx, [si]
	shld	eax, ebx, bitsg_length
	stosd
	mov	eax, ebx
	sub	si, 4
	loop	next

	sub	ebx, ebx
	sub	edx, edx
	mov	ecx, bit_offset
	and	cl, 1fh
	shrd	ebx, eax, cl
	shld	edx, ebx, cl
	shl	eax, bitsg_length
	mov	ebx, -1
	shl	ebx, cl
	and	eax, ebx
	or	eax, edx
	mov	[edi], eax
	ret
mov_string	endp

insert_bitsg	proc
	mov	esi, bitsg
	mov	edi, bit_offset
	mov	ecx, edi
	shr	edi, 5
	shl	edi, 2
	and	cl, 1fh

	mov	eax, string[edi]
	mov	edx, string+4[edi]
	mov	ebx, eax
	shrd	eax, edx, cl
	shrd	edx, ebx, cl
	shrd	eax, esi, bitsg_length
	rol	eax, bitsg_length
	mov	ebx, eax
	shld	eax, edx, cl
	shld	edx, ebx, cl
	mov	string[edi], eax
	mov	string+4[edi], edx
	ret
insert_bitsg	endp

	end	start
