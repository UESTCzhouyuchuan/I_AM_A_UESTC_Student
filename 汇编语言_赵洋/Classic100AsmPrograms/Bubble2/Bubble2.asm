;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Bubble2.asm
;��������������������������������������������������������������������
;ð���������ʵ��2��ʹ���������С�����˳������
;���Ӷ�����һ�����飬���׵�ַ�Ѿ�����ڣģ��У�����ĵ�һ��Ԫ���д��������ĳ���
;���ʵ��ʹ���������С�����˳������

extra segment
	a		dw	10, 99, 88, 77, 66, 55, 44, 33, 22, 11
extra ends

data segment
	save_cnt	dw	?
	start_addr	dw	?
data ends

code segment
	assume cs:code, ds:data, es:extra
main proc far

start:
	;set up stack for return
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	mov	ax, extra
	mov	es, ax

;program started--------------------------------------------------
	lea	di, a

	mov	start_addr, di
	mov	cx, es:[di]		;����Ԫ�ظ���
	mov	save_cnt, cx

init:
	mov	bx, 1
	dec	save_cnt
	jz	sorted
	mov	cx, save_cnt
	mov	di, start_addr

next:
	add	di, 2
	mov	ax, es:[di]
	cmp	es:[di+2], ax
	jae	cont
	xchg	es:[di+2], ax
	mov	es:[di], ax
	sub	bx, bx
	
cont:
	loop	next
	cmp	bx, 0
	je	init

sorted:
	mov	di, start_addr

	ret
main endp

code ends
	end start