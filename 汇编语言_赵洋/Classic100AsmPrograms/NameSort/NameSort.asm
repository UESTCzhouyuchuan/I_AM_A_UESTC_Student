;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; NameSort.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;这是一个人名排序程序，先在终端上键入最多３０个人名，当所有人名都进入
;后，按字母上升的次序将人名排序，并在屏幕上显示已经排好次序的人名。

.model	small
.8086
.stack	40h
.data
	namepar		label	byte
	maxnlen		db	21
	namelen		db	?
	namefld		db	21 dup(?)
	crlf		db	13,10,'$'
	endaddr		dw	?
	messg1		db	'Name?','$'
	messg2		db	'Sorted names:',13,10,'$'
	namectr		db	0
	nametab		db	30 dup(20 dup(' '))
	namesav		db	20 dup(?),13,10,'$'
	swapped		db	0

.code
main	proc	far
start:
	mov	ax, @data
	mov	ds, ax
	mov	es, ax

	cld
	lea	di, nametab
	
a20loop:
	call	b10read
	cmp	namelen, 0
	jz	a30

	cmp	namectr, 30
	je	a30
	call	d10stor
	jmp	a20loop

a30:
	cmp	namectr, 1
	jbe	a40
	call	g10sort
	call	k10disp

a40:
	mov	ax, 4c00h
	int	21h

main	endp

b10read	proc	near
	mov	ah, 09
	lea	dx, messg1
	int	21h
	mov	ax, 0ah
	lea	dx, namepar
	int	21h
	mov	ah, 09
	lea	dx, crlf
	int	21h

	mov	bh, 0
	mov	bl, namelen
	mov	cx, 21
	sub	cx, bx

b20:
	mov	namefld[bx], 20h
	inc	bx
	loop	b20

	ret
b10read	endp

d10stor	proc	near
	inc	namectr
	cld
	lea	si, namefld
	mov	cx, 10
	rep	movsw
	ret
d10stor	endp

g10sort	proc	near
	sub	di, 40
	mov	endaddr, di
g20:
	mov	swapped, 0
	lea	si, nametab
g30:
	mov	cx, 20
	mov	di, si
	add	di, 20
	mov	ax, di
	mov	bx, si
	repe	cmpsb
	jbe	g40
	call	h10xchg

g40:
	mov	si, ax
	cmp	si, endaddr
	jbe	g30
	cmp	swapped, 0
	jnz	g20
	ret
g10sort	endp

h10xchg	proc	near
	mov	cx, 10
	lea	di, namesav
	mov	si, bx
	rep	movsw

	mov	cx, 10
	mov	di, bx
	rep	movsw

	mov	cx, 10
	lea	si, namesav
	rep	movsw
	mov	swapped, 1
	ret
h10xchg	endp

k10disp	proc	near
	mov	ah, 09
	lea	dx, messg2
	int	21h
	lea	si, nametab
k20:
	lea	di, namesav
	mov	cx, 10
	rep	movsw
	mov	ah, 9
	lea	dx, namesav
	int	21h
	dec	namectr
	jnz	k20
	ret
k10disp	endp

	end start