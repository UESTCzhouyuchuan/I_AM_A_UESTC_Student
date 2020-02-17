;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; Module3.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;本例讲述关于public与extrn伪操作的用法
;source module 3

extrn	lab1:far
public	lab2, lab3

code3 segment
	assume	cs:code3

lab2:

lab3:

code3 ends

	end