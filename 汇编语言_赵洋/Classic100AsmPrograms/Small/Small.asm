;��������������������������������������������������������������������
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQȹ��30515563
; Small.asm
;��������������������������������������������������������������������
;�����ݶ��е��ַ���ת�͵����Ӷ���

.model small
.stack 100h
.data
	mess1	db	'personal computer',13,10,'$'

.fardata?
	mess2	db	20 dup(?)

.code

main proc far

start:
	push	ds			;set up stack for return
	sub	ax, ax
	push	ax			;set up stack for return

	mov	ax, @data
	mov	ds, ax

	mov	ax, @fardata?
	mov	es, ax

	lea	si, mess1
	lea	di, mess2

	mov	cx, 20
	cld
	rep movsb

	ret				;return to DOS
main endp

	end start