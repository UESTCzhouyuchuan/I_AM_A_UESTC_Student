;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; PrtChar.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;打印字符程序，这是一个采用查询方式的打印字符程序，通过反复读取并测试
;打印机的状态来控制输出。在打印机接口中，数据寄存器的端口地址为３７８Ｈ
;状态寄存器的端口为３７９Ｈ，控制寄存器的端口地址为３７ＡＨ


data segment
	mess		db	'Printer is normal',0dh,0ah
	count		equ	$ - mess
data ends

code segment
	assume	cs:code, ds:data

main proc far
start:
	mov	ax, data
	mov	ds, ax

	mov	si, offset mess
	mov	cx, count

next:
	mov	dx, 379h
query:
	in	al, dx
	test	al, 80h		;80h = 1000 0000 B,查询打印机状态寄存器的忙闲位
	je	query

	;送一字符到打印机数据寄存器
	mov	al, [si]
	mov	dx, 378h
	out	dx, al

	;送控制码至打印机的控制寄存器
	mov	dx, 37ah
	mov	al, 0dh		;0dh = 0000 1101 B,选通，初始化，接通打印机
	out	dx, al
	
	;再次送控制码至打印机的控制寄存器
	mov	al, 0ch		;0ch = 0000 1100 B,初始化，接通打印机
	out	dx, al

	;增加索引，以便送下一字符至打印机
	inc	si
	loop	next

	mov	ax, 4c00h
	int	21h
main endp

code ends
	
	end start
