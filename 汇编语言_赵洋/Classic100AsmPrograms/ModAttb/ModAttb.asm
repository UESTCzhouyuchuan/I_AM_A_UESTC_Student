;--------------------------------------------------------------------
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; ModAttb.asm
;--------------------------------------------------------------------
;改变现有文件的属性，注意本例假定拥有常规属性的D:\ModAttb.dat文件存在
;为了检验程序效果，你运行前不妨自己先在D盘根目录下手动建立一个这样
;的文件

data segment
	szFileName	db	'D:\ModAttb.dat',0
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

	mov	dx, offset szFileName
	call	ModifyFileAttribute

	ret
main endp

;改变现有文件的属性
;INPUT:
;DS = 文件绝对路径数据所在段
;DX = 文件绝对路径名(0结束)偏移地址
;OUTPUT:
;设置D:\ModAttb.dat文件的属性为：只读，隐藏，系统，归档
;操作失败AX返回的错误码可能为：
;	01(非法功能号)
;	02(文件未找到)
;	03(路径未找到)
;	05(拒绝访问)
ModifyFileAttribute proc near
	mov	ah, 43h			;check or change attribute
	mov	al, 01			;set file attribute
	mov	cx, 0000000000100111B	;其中的1依次表示归档，系统，隐藏，只读
	int	21h			;call DOS
	ret
ModifyFileAttribute endp

code ends

	end start