;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Print2.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;编写一个能打印ＡＳＣＩＩ文件的函数，它的基本功能是把已读到缓冲区
;(file_buffer)中的字符送到一个打印区(print_buffer),并检查行尾和文件尾
;处理换行符和ＴＡＢ符

data segment
	count		dw	0
	file_buffer	db	'Hello',09h
			db	'Hello',0dh,0ah
			db	'Hello world',1ah
			db	487 dup(' ')
	print_buffer	db	82 dup(' ')
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax
	
	call	Print

	ret
main endp


;print an ascii file in file_buffer
Print proc near

	cld				;set left to right
	lea	si, file_buffer
load_di:
	lea	di, print_buffer
	mov	count, 0

load_dx:
	lea	dx, file_buffer+512
	cmp	si, dx
	je	print_lastline
	mov	bx, count
	cmp	bx, 80
	jb	not_endl

	mov	word ptr[di+bx], 0d0ah	;insert crlf
	add	count, 2
	call	PrintLine
	mov	count, 0
	mov	bx, 0

not_endl:
	lodsb
	mov	[di+bx],al
	inc	bx
	cmp	al, 1ah			;end of file?
	je	print_lastline
	cmp	al, 0ah			;end of line?
	jne	handle_tab
	call	PrintLine
	jmp	load_di

;dispose if meeting tab charactor
handle_tab:
	cmp	al, 09h
	jne	not_tab
	dec	bx
	mov	byte ptr[di+bx], 20h	;tab->blank

;get the correct pos of the charactor right after TAB
	and	bx, 0fff8h		;clear right most 3 bits
	add	bx, 8			;add 8 -> tab stop
not_tab:
	mov	count, bx
	jmp	load_dx

print_lastline:
	mov	bx, count
	mov	byte ptr[di+bx], 0ch	;insert page break
	call	PrintLine		;print the line

	ret
Print endp

PrintLine proc near
	mov	cx, count
	inc	cx
	mov	bx, 0
print_char:
	mov	ah, 5
	mov	dl, print_buffer[bx]
	int	21h
	inc	bx
	loop	print_char

;clear print_buffer
	mov	ax, 2020h
	mov	cx, 41
	lea	di, print_buffer
	rep	stosw
	ret
PrintLine endp

code ends

	end start