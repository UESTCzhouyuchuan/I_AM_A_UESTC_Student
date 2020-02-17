;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Add4.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;有两个４字长（８字节）数分别存放在ＤＡＴＡ１和ＤＡＴＡ２
;请用８０８６指令求出他们的和，并把结果放在ＤＡＴＡ３

.model small
.386
.stack 200h
.data
	data1		dq	123456789abcdefh
	data2		dq	0fedcba987654321h
	data3		dq	?

.code

start:
	mov	ax, @data
	mov	ds, ax

	mov	eax, dword ptr data1
	add	eax, dword ptr data2
	mov	edx, dword ptr data1+4
	adc	edx, dword ptr data2+4
	mov	dword ptr data3, eax
	mov	dword ptr data3+4, edx

	mov	ax, 4c00h
	int	21h

	end start