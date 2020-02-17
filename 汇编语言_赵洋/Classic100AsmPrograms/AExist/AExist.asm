;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; AExist.asm
;--------------------------------------------------------------------
;判断在驱动器Ａ中是否有已经格式化的软盘

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
;
data segment
	BadDiskMsg	db	'No, there is not a floopy disk in drive A.',13,10
	GoodDiskMsg	db	'Yes, a floopy disk in drive A is avalable.',13,10
	nGoodDiskMsgLen	equ	$-GoodDiskMsg
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

	call	IsThereAExist
	jc	@BadDisk
	lea	dx, GoodDiskMsg
	mov	cx, nGoodDiskMsgLen
	call	ShowTestResult
	ret

@BadDisk:
	lea	dx, BadDiskMsg
	mov	cx, GoodDiskMsg-BadDiskMsg
	call	ShowTestResult
	ret
main endp

;判断在驱动器Ａ中是否有已经格式化的软盘
;OUTPUT:
;AL = 实际检测到的扇区数
IsThereAExist proc near
	mov	ah, 4		;request verify
	mov	al, 1		;one sector
	mov	ch, 0		;track 0
	mov	cl, 1		;sector 1
	mov	dh, 0		;head 0
	mov	dl, 0		;drive 0(Floopy B)
	int	13h		;call BIOS
	ret
IsThereAExist endp


;在屏幕上显示检测结果
ShowTestResult proc near
	mov	ah, 3fh			;request read function
	mov	bx, 1			;handle 1 = CRT
	int	21h			;call DOS
	ret
ShowTestResult endp

code ends

	end start