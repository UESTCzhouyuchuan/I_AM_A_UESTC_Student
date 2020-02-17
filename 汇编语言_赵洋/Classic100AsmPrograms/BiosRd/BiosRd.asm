;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; BiosRd.asm
;--------------------------------------------------------------------
;本例利用ＢＩＯＳ指令实现了读磁盘
;（１）本程序计算每一个磁盘地址，每次读操作之后，扇区号＋１，当扇区
;号加到１０则重新置扇区号为１，如果盘面是１则增加磁道号，然后改变盘面
;，或由０改为１或由１改为０
;（２）数据项CurrentAddr包含起始的磁道/扇面地址，EndAddr包含结束的磁
;道/扇面地址

;BIOS磁盘操作ＩＮＴ　１３Ｈ处理的记录都是一个扇区(512 bytes)的大小，
;都是以实际的磁道号和扇区号寻址的。读，写和检验磁盘文件之前，先把
;下列寄存器初始化：
;AH = 要执行的操作：复位(0),读状态(1),读磁盘(2),写磁盘(3) 检验扇区(4)
;AL = 扇区数
;CH = 柱面/磁道号(0为起始号)
;CL = 起始扇区号(1为起始号)
;DH = 磁头/盘面号，对软盘是０或１
;DL = 驱动器号: 软盘:0=驱动器Ａ，1=驱动器Ｂ，...
;		硬盘:80h=驱动器１，81h=驱动器２，...
;ES:BX = 数据区中Ｉ/Ｏ缓冲区的地址(除检验操作外)

;在大多数情况下，程序只指定读一个扇区或读取一个磁道上的全部扇区。
;读操作只是顺序读取ＣＨ和ＣＬ指定的扇区内容，并递增ＣＨ和ＣＬ中的磁道
;号和扇区号，如果扇区号超过了磁道的最大扇区号，必须把扇区号重新置１，
;并把磁道号增１，或者把双面盘的０面变１面。

data segment
	Buffer		db	512 dup(' ')
	EndCode		db	0
	CurrentAddr	dw	0304h			;beginning track/sector
	EndAddr		dw	0501h			;Ending track/sector
	ReadErrorMsg	db	'Read error!'
	Side		db	0
	User		db	1, 1 dup(?)		;user input
data ends

code segment
	assume	cs:code, ds:data

main proc near

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax
	mov     es, ax

	mov	ax, 0600h			;request scroll

@Continue:
	call	ScrollScreen			;Scroll screen
	call	SetCursor			;set cursor
	call	CalcNextDiskAddr		;calculate next disk address
	mov	cx, CurrentAddr			;
	mov	dx, EndAddr			;
	cmp	cx, dx				;is at ending sector?
	je	@Exit				;yes, exit
	call	ReadDiskRecord			;read disk record
	cmp	EndCode, 0			;normal read?
	jnz	@Exit				;no, exit
	call	DisplaySector			;display sector content
	jmp	@Continue

@Exit:
	ret
main endp

;calculate next disk address
CalcNextDiskAddr proc near
	mov	cx, CurrentAddr			;get track/sector
	cmp	cl, 10				;pass last sector
	jne	@CNDAExit			;no, exit
	cmp	Side, 0				;bypass if Side = 0
	je	@ChangeSide			;
	inc	ch

@ChangeSide:
	xor	Side, 1				;change Side
	mov	al, 1				;set sector to 1
	mov	CurrentAddr, cx

@CNDAExit:
	ret

CalcNextDiskAddr endp


;OUTPUT:
;AL = 实际读取的扇区数
ReadDiskRecord proc near
	mov	ah, 2		;request read
	mov	al, 1		;one sector
	lea	bx, Buffer	;input buffer at ES:BX
	mov	cx, CurrentAddr	;track/sector
	mov	dh, Side	;head 0
	mov	dl, 0		;drive A(Floopy A)
	int	13h		;call BIOS
	cmp	ah, 0		;normal read?
	jz	@IncreaseSector ;yes, exit
	mov     EndCode, 1	;no
	call	ShowErrorMsg	;invlaid read

@IncreaseSector:
	inc	CurrentAddr	;increase sector
	ret
ReadDiskRecord endp


;display sector
DisplaySector proc near
	mov	ah, 40h			;request display
	mov	bx, 1			;handle
	mov	cx, 512			;length
	lea	dx, Buffer		;address of input
	int	21h
@Wait:
	mov	ah, 0ah			;user input
	lea	dx, User
	int	21h
	cmp	User+1, 0dh
	je	@Wait			;wait until user input return

	ret
DisplaySector endp

;clear screen
ScrollScreen proc near
	mov	ax, 0600h		;full screen
	mov	bh, 1eh			;set color
	mov	cx, 0			;request scroll
	mov	dx, 184fh
	int	10h
	ret
ScrollScreen endp

;set cursor
SetCursor proc near
	mov	ah, 02			;request set cursor
	mov	bh, 0
	mov	dx, 0
	int	10h
	ret
SetCursor endp

;disk error function
ShowErrorMsg proc near
	mov	ah, 40h			;request display
	mov	bx, 1			;handle
	mov	cx, 11			;length of message
	lea	dx, ReadErrorMsg
	int	21h
	ret
ShowErrorMsg endp

code ends

	end start