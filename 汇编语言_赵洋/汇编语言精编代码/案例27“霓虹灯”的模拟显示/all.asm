;--<<<********************>>>HONG<<<*******************>>>--  ;HONG部分为宏定义
 HONG           MACRO
                push ax
                push bx
                push cx
                push dx
                push di
                mov  ah,0fh                               ;取当前显示方式并返回字符列数参数AH和显示方式参数AL     
                int  10h                                  ;BIOS显示中断语句
                ENDM
;-------------------------------------
 HONG1          MACRO
                pop  di
                pop  dx
                pop  cx
                pop  bx
                pop  ax
                ENDM
;--------------------------------------------
 HONG2          MACRO
                mov        cx,char_cnt1                             
                mov        di,pointer1
                mov        dh,line_on1
                mov        dl,col_on1
                ENDM
;----------------------------------------
 HONG3          MACRO
                mov        cx,char_cnt2
                mov        di,pointer2
                mov        dh,line_on2
                mov        dl,col_on2
                ENDM
;-----------------------------------------
 HONG4          MACRO
                mov        cx,char_cnt
                mov        di,pointer
                mov        dh,line_on
                mov        dl,col_on
                ENDM
;-----------------------------------------
 HONG5          MACRO
                mov        char_cnt,cx
                mov        pointer,di
                mov        line_on,dh
                mov        col_on,dl
                ENDM
;-----------------------------------------
 HONG6          MACRO
                push cx
                mov  cx,1
                mov  ah,09
                int  10h
                pop  cx
                add  di,4					
                ENDM
;------------------------------------------
 HONG7          MACRO
                mov   Bcount0,4
                mov   Bcount,5
                lea   di,Bstar
                mov   dh,3
                mov   dl,2
                call  move_shape
                dec   Bcount0
                lea   di,Bstar1
                mov   dh,17
                mov   dl,76
                call  move_shape
                dec   Bcount0
                lea   di,Bjeep
                mov   dh,4
                mov   dl,2
                call  move_shape
                dec   Bcount0
                lea   di,Bcar
                mov   dh,16
                mov   dl,76
                call  move_shape
                ENDM
 ;---------------------------------------
 HONG8          MACRO
                mov   Hline1,dh
                mov   Hcol1,dl             
                add   di,4
                mov   Hpot1,di
                ENDM
 ;---------------------------------------
 HONG9          MACRO
                mov   Hline2,dh
                mov   Hcol2,dl             
                add   di,4
                mov   Hpot2,di
                ENDM
 ;---------------------------------------
 HONG10         MACRO
                mov        dh,Hline1
                mov        di,Hpot1
                mov        dl,Hcol1
                ENDM
 ;---------------------------------------
 HONG11         MACRO
                mov        dh,Hline2
                mov        di,Hpot2
                mov        dl,Hcol2
                ENDM

;--<<<***************>>>DATA_SEGMENT<<<*************>>>-- ;DATA_SEGMENT部分为定义数据段
 data_seg    segment
 ;---S--**************************--S---
 Scar        db 26
             db 3dh,0eh,0,0
             db 40h,0ah,1,0
             db 9 dup(02ah,0bh,1,0)
             db 40h,0ah,1,0
             db 3dh,0eh,1,0
             db 3ch,0eh,0,-1
             db 2ah,0bh,-1,0
             db 9 dup(40h,0bh,-1,0)
             db 2ah,0bh,-1,0
             db 3ch,0eh,-1,0
;-------------------------------------
  Scar1      db 26
             db 3dh,0eh,0,0
             db 11 dup(40h,0bh,1,0)
             db 3dh,0eh,1,0
             db 3eh,0eh,0,1
             db 11 dup(02ah,0bh,-1,0)
             db 3eh,0eh,-1,0
 ;--------------------------------------
  Sjeep      db 26     
             db 3dh,0eh,0,0
             db 40h,0ah,1,0
             db 9 dup(02ah,0bh,1,0)
             db 40h,0ah,1,0
             db 3dh,0eh,1,0
             db 3eh,0eh,0,1
             db 2ah,0bh,-1,0
             db 9 dup(40h,0bh,-1,0)
             db 2ah,0bh,-1,0
             db 3eh,0eh,-1,0
 ;---------------------------------------
  Sjeep1     db 26
             db 3dh,0eh,0,0
             db 11 dup(40h,0bh,1,0)
             db 3dh,0eh,1,0
             db 3ch,0eh,0,-1
             db 11 dup(02ah,0bh,-1,0)
             db 3ch,0eh,-1,0
 ;----------------------------------------
  Sleft      db '_',0ch,0,0
             db 5ch,0ch,1,0
             db 2fh,0ch,1,0
             db 4 dup(7ch,0ch,1,0)
             db 5ch,0ch,2,0
             db 5ch,0ch,1,0
             db 2ah,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,-9,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,1,0
             db 5ch,0ch,1,0
             db 2ah,0ch,1,0
             db 5ch,0ch,2,0
             db '_',0ch,-9,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2ah,0ch,1,0
             db '_',0ch,-7,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2ah,0ch,1,0
             db 5ch,0ch,-10,-1
             db 9 dup(7ch,0ch,1,0)
             db 2ah,0ch,1,0
             db 2ah,0ch,-10,-1
             db 9 dup(7ch,0ch,1,0)
             db 2ah,0ch,1,0
             db '_',0ch,-7,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2ah,0ch,1,0
             db '_',0ch,-7,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2fh,0ch,1,0
             db '_',0ch,-7,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2 dup(2fh,0ch,1,0)
             db 5ch,0ch,-8,-1
             db 4 dup(7ch,0ch,1,0)
             db 2fh,0ch,1,0
             db 2ah,0ch,2,0
             db 3dh,0ch,1,0
             db 2fh,0ch,1,0
             db 7ch,0ch,-9,-1
             db 5 dup(7ch,0ch,1,0)
             db 2fh,0ch,3,0
             db 5ch,0ch,1,0
  ;--------------------------------------
             db 5ch,0ch,-9,-2
             db 5ch,0ch,8,0
             db 2fh,0ch,1,0
             db '_',0ch,-10,-1
             db 2 dup(2fh,0ch,1,0)
             db 2fh,0ch,7,0
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 7ch,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2fh,0ch,1,0
             db '_',0ch,7,0
             db '_',0ch,1,0
             db 5ch,0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 5ch,0ch,3,0            
             db 2 dup(7ch,0ch,1,0)
             db 2fh,0ch,1,0
             db '_',0ch,2,0
             db '_',0ch,1,0
             db 2fh,0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(3eh,0ch,1,0)
             db 2fh,0ch,1,0
             db 3 dup(7ch,0ch,1,0)
             db '_',0ch,2,0
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2ah,0ch,1,0
             db 3eh,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,2,0
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db '_',0ch,2,0
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 2 dup(7dh,0ch,1,0)
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 3 dup(2ah,0ch,1,0)
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(3ch,0ch,1,0)
             db 3ch,0ch,2,0
             db 3ch,0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(7bh,0ch,1,0)
             db 5ch,0ch,1,0
             db '_',0ch,-12,-1
             db 2 dup(3dh,0ch,1,0,7ch,0ch,1,0)
             db 7ch,0ch,1,0
             db 3dh,0ch,4,0
             db '_',0ch,-9,-1
             db 2 dup(3dh,0ch,1,0,2bh,0ch,1,0)
             db 2bh,0ch,1,0
             db 5ch,0ch,2,0
             db 3dh,0ch,2,0
             db '_',0ch,-9,-1
             db 2 dup(3dh,0ch,1,0,7ch,0ch,1,0)
             db 7ch,0ch,1,0
             db '_',0ch,1,0
             db 2fh,0ch,1,0
             db 5ch,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,-9,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0              
             db 2 dup(3eh,0ch,1,0)
             db '_',0ch,1,0
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db 3dh,0ch,1,0
             db 7dh,0ch,1,0
             db '_',0ch,-10,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db '_',0ch,-11,-1      
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 7bh,0ch,1,0
             db 2ah,0ch,1,0
             db 3eh,0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 2fh,0ch,2,0
             db 3dh,0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2ah,0ch,1,0
             db 3ch,0ch,1,0
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(3ch,0ch,1,0)
             db '_',0ch,1,0
             db 3 dup(7ch,0ch,1,0)
             db 3dh,0ch,3,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2fh,0ch,4,0
             db 2 dup(7ch,0ch,1,0)
             db 3dh,0ch,3,0
             db 2fh,0ch,-11,-1
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 3ch,0ch,9,0
             db 2fh,0ch,-9,-1
             db 2fh,0ch,1,0
             db 3ch,0ch,8,0
             db 2fh,0ch,-8,-1      
             db 3ch,0ch,8,0
 Sright      db 189
             db '_',0ch,0,0
             db 3dh,0ch,1,0
             db 5ch,0ch,1,0
             db 3 dup(7ch,0ch,1,0)
             db 2fh,0ch,1,0
             db 5ch,0ch,3,0
             db 2ah,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 40h,0ch,9,0
             db 3dh,0ch,1,0
             db 2 dup('_',0ch,-11,1,3dh,0ch,1,0,3dh,0ch,10,0)
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 9 dup(7ch,0ch,1,0)
             db 3dh,0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 9 dup(2bh,0ch,1,0)
             db 3dh,0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 9 dup(7ch,0ch,1,0)
             db 3dh,0ch,1,0
             db 3 dup('_',0ch,-11,1,3dh,0ch,1,0,3dh,0ch,10,0)
             db '_',0ch,-11,1
             db 2fh,0ch,1,0
             db 3dh,0ch,10,0
             db 5ch,0ch,-10,1      
             db 2fh,0ch,10,0
        ;--------------------------
             db 2fh,0ch,-6,1
             db 5ch,0ch,1,0
             db 2ah,0ch,4,0
             db 5ch,0ch,1,0       
             db 2fh,0ch,-7,1
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db 2fh,0ch,3,0
             db 3dh,0ch,1,0
             db 7ch,0ch,-6,1
             db 7ch,0ch,1,0
             db 2fh,0ch,3,0
             db 2ah,0ch,1,0
             db 2fh,0ch,-2,1
             db 2ah,0ch,1,0
             db 7ch,0ch,-9,1
             db 5 dup(7ch,0ch,1,0)
             db 7bh,0ch,1,0
             db 40h,0ch,1,0
             db 2ah,0ch,1,0
             db 5ch,0ch,-8,1               
             db 8 dup(2ah,0ch,1,0) ;101
             db '_',0ch,-8,1
             db 5 dup(7ch,0ch,1,0)
             db 7dh,0ch,1,0
             db 40h,0ch,1,0
             db 2ah,0ch,1,0
             db 2fh,0ch,-4,1
             db 2ah,0ch,1,0
             db 5ch,0ch,3,0
             db 5ch,0ch,1,0
             db 2fh,0ch,-6,1
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db 5ch,0ch,4,0
             db 5ch,0ch,1,0
             db 5ch,0ch,-7,1
             db 2fh,0ch,1,0
             db '_',0ch,5,0
             db 2ah,0ch,1,0
             db 5ch,0ch,1,0
             db '_',0ch,-10,1
             db 5ch,0ch,1,0
             db 5ch,0ch,8,0
             db 2fh,0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 2fh,0ch,8,0
             db '^',0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 5ch,0ch,8,0
             db '^',0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 3dh,0ch,8,0
             db '^',0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 3dh,0ch,8,0
             db 5ch,0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 7 dup(7ch,0ch,1,0)
             db 3dh,0ch,1,0
             db 40h,0ch,1,0
             db '^',0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 8 dup(2bh,0ch,1,0)
             db 2 dup(2ah,0ch,1,0)
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 8 dup(7ch,0ch,1,0)
             db 7dh,0ch,1,0
             db 2fh,0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db '_',0ch,-1,1
             db 3dh,0ch,1,0
             db '_',0ch,-1,1
             db 2fh,0ch,1,0
             db 5ch,0ch,0,1     
 ;---A--**************************--A---
  III        db 65                                     ;从III地址开始存放的是写字符'I'时所用的所有符号
             db 7ch,0ch,0,0                            ;  及每个字符的显示颜色属性和位置
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 7ch,0ch,-8,0
             db '_',0ch,-1,1
             db 3dh,0ch,1,0
             db '_',0ch,8,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 3dh,0ch,-8,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db '_',0ch,8,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db 8 dup(7ch,0ch,-1,0)			;使用复制操作符来复制操作数
             db 3dh,0ch,-1,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db 8 dup(2bh,0ch,1,0)
             db '_',0ch,1,0
             db '_',0ch,0,1
             db 8 dup(7ch,0ch,-1,0)
             db 3dh,0ch,-1,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db '_',0ch,8,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 3dh,0ch,-8,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db '_',0ch,8,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 7ch,0ch,-8,0
             db 7ch,0ch,9,1
  AAAA       db 57						;从AAAA地址开始存放的是写字符'A'时所用的所有符号  
             db '_',0ch,0,0					;  及每个字符的显示颜色属性和位置
             db 7ch,0ch,1,0
             db 3dh,0ch,0,1
             db 2fh,0ch,-1,0
             db 2fh,0ch,-1,1
             db 2fh,0ch,1,0
             db 3dh,0ch,1,0
             db 3dh,0ch,0,1
             db '_',0ch,-1,0
             db 2 dup(2fh,0ch,-1,0)
             db 2fh,0ch,-1,1
             db 2fh,0ch,1,0
             db '_',0ch,2,0
             db 7ch,0ch,1,0
             db '_',0ch,-3,1
             db 2 dup(2fh,0ch,-1,0)
             db 2fh,0ch,-1,1
             db 2fh,0ch,1,0
             db 2 dup('_',0ch,1,0)
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 2fh,0ch,-2,0
             db 2fh,0ch,-1,0
             db '_',0ch,-1,1
             db 2fh,0ch,1,0
             db '_',0ch,3,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 5ch,0ch,-2,0
             db 5ch,0ch,-1,0
             db 5ch,0ch,1,1
             db 5ch,0ch,1,0
             db 2 dup('_',0ch,1,0)
             db '_',0ch,0,1
             db 2 dup(5ch,0ch,-1,0)
             db 5ch,0ch,1,1
             db 5ch,0ch,1,0
             db '_',0ch,2,0
             db 7ch,0ch,1,0
             db 3dh,0ch,0,1
             db '_',0ch,-1,0
             db 2 dup(5ch,0ch,-1,0)
             db 5ch,0ch,1,1
             db 5ch,0ch,1,0
             db 3dh,0ch,1,0
             db 3dh,0ch,0,1
             db 5ch,0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db 7ch,0ch,0,1
  QQQ        db 90						;从QQQ地址开始存放的是写字符'Q'时所用的所有符号  
             db 7ch,0ch,0,0					;  及每个字符的显示颜色属性和位置
             db 5 dup(7ch,0ch,1,0)
             db 5ch,0ch,1,1
             db 6 dup(7ch,0ch,-1,0)
             db 2fh,0ch,-1,0
             db 2fh,0ch,-1,1
             db 2fh,0ch,1,0
             db 5ch,0ch,7,0
             db 5ch,0ch,1,0
             db 5ch,0ch,0,1
             db '_',0ch,-1,0
             db 2fh,0ch,-8,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db '_',0ch,1,0
             db 2fh,0ch,7,0
             db 2 dup('_',0ch,1,0)
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 2 dup(2fh,0ch,-1,0)
             db '_',0ch,-6,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db '_',0ch,1,0
             db '_',0ch,5,0
             db 2fh,0ch,1,0
             db '_',0ch,2,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db '_',0ch,-3,0
             db '_',0ch,-5,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db '_',0ch,1,0
             db '_',0ch,5,0
             db 5ch,0ch,1,0
             db '_',0ch,2,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 5ch,0ch,-2,0
             db '_',0ch,-6,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db '_',0ch,1,0
             db '_',0ch,6,0
             db 5ch,0ch,1,0
             db '_',0ch,1,0
             db '_',0ch,1,0
             db 2fh,0ch,0,1
             db '_',0ch,-1,0
             db 5ch,0ch,-1,0
             db 5ch,0ch,-7,0
             db '_',0ch,-1,0
             db 5ch,0ch,1,1
             db 5ch,0ch,1,0
             db 2fh,0ch,7,0
             db 2fh,0ch,1,0
             db 5ch,0ch,0,1
             db 2fh,0ch,-1,0
             db 6 dup(7ch,0ch,-1,0)
             db 5ch,0ch,-1,0
             db 7ch,0ch,1,1
             db 5 dup(7ch,0ch,1,0)
             db 5ch,0ch,2,0
             db '_',0ch,0,1
             db 2 dup(2fh,0ch,0,1)
             db '_',0ch,-1,0
  NNN        db 68						;从NNN地址开始存放的是写字符'N'时所用的所有符号  
             db 7ch,0ch,0,0					;  及每个字符的显示颜色属性和位置
             db 3dh,0ch,0,1
             db 9 dup(7ch,0ch,-1,0)
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 9 dup(7ch,0ch,1,0)
             db 3dh,0ch,1,0
             db 7ch,0ch,0,1
             db 5ch,0ch,-9,0
             db '_',0ch,-1,0
             db 5ch,0ch,1,1
             db 8 dup(5ch,0ch,1,0,5ch,0ch,0,1)       
             db 3dh,0ch,1,0
             db '_',0ch,0,1
             db 9 dup(7ch,0ch,-1,0)
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 10 dup(7ch,0ch,1,0)
             db 2fh,0ch,-9,1
             db '_',0ch,-1,0
  GGG        db 91						;从GGG地址开始存放的是写字符'G'时所用的所有符号  
             db 7ch,0ch,0,0					;  及每个字符的显示颜色属性和位置
             db 5 dup(7ch,0ch,1,0)
             db 5ch,0ch,1,1
             db 6 dup(7ch,0ch,-1,0)    
             db 2fh,0ch,-1,0
             db 2fh,0ch,-1,1
             db 2fh,0ch,1,0
             db 5ch,0ch,7,0
             db 5ch,0ch,1,0
             db 5ch,0ch,0,1
             db '_',0ch,-1,0
             db 2fh,0ch,-8,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db '_',0ch,1,0
             db '_',0ch,8,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db '_',0ch,-8,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db '_',0ch,1,0
             db '_',0ch,8,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 7ch,0ch,-3,0
             db '_',0ch,-5,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db '_',0ch,1,0
             db '_',0ch,4,0
             db 3dh,0ch,1,0
             db '_',0ch,3,0
             db '_',0ch,1,0
             db '_',0ch,0,1
             db '_',0ch,-1,0
             db 3dh,0ch,-3,0
             db '_',0ch,-1,0
             db '_',0ch,-4,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 5ch,0ch,1,0
             db 7ch,0ch,3,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,3,0
             db 2fh,0ch,1,0
             db 2fh,0ch,0,1
             db 2fh,0ch,-1,0
             db 3dh,0ch,-3,0
             db '_',0ch,-1,0
             db 3dh,0ch,-1,0
             db '_',0ch,-1,0
             db 2 dup(5ch,0ch,-1,0)
             db 5ch,0ch,1,1
             db 7ch,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(7ch,0ch,1,0)
             db 2fh,0ch,1,0
             db 7ch,0ch,-1,1
             db 7ch,0ch,-1,0
             db 3dh,0ch,-1,0
             db '_',0ch,-1,0
             db 3dh,0ch,-1,0
             db 7ch,0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 3dh,0ch,1,1
             db 5ch,0ch,-1,0
             db '_',0ch,-1,0
             db 7ch,0ch,-1,0
             db 5ch,0ch,2,1
             db 3dh,0ch,1,0
             db 3dh,0ch,0,1
  JJJ        db 58						;从JJJ地址开始存放的是写字符'J'时所用的所有符号  
             db 7ch,0ch,0,0					;  及每个字符的显示颜色属性和位置
             db 2ah,0ch,7,0
             db 5ch,0ch,1,0
             db 5ch,0ch,1,1
             db 5ch,0ch,-1,0
             db 3dh,0ch,-8,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db '_',0ch,8,0
             db 3dh,0ch,1,0
             db 3dh,0ch,0,1
             db '_',0ch,-1,0
             db 3dh,0ch,-8,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db '_',0ch,8,0
             db 3dh,0ch,1,0
             db 2bh,0ch,0,1
             db 2fh,0ch,-1,0
             db 7 dup(7ch,0ch,-1,0)
             db 3dh,0ch,-1,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db 8 dup(2bh,0ch,1,0)
             db 2fh,0ch,1,0
             db 2fh,0ch,-1,1
             db 7 dup(7ch,0ch,-1,0)
             db 3dh,0ch,-1,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db 3dh,0ch,0,1
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db 7ch,0ch,0,1

  DDD        db 77						;从DDD地址开始存放的是写字符'D'时所用的所有符号  
             db '_',0ch,0,0					;  及每个字符的显示颜色属性和位置
             db 5ch,0ch,1,0
             db 2fh,0ch,9,0
             db 2fh,0ch,0,1
             db 8 dup(7ch,0ch,-1,0)
             db 5ch,0ch,-1,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db 8 dup(7ch,0ch,1,0)   
             db 4 dup(3dh,0ch,1,0,3dh,0ch,0,1,'_',0ch,-1,0,3dh,0ch,-8,0,'_',0ch,-1,0,'_',0ch,0,1,3dh,0ch,1,0,'_',0ch,8,0)
             db 3dh,0ch,1,0
             db 3dh,0ch,0,1
             db '_',0ch,-1,0
             db 5ch,0ch,-7,0
             db 5ch,0ch,-1,0
             db 5ch,0ch,1,1
             db 5ch,0ch,1,0
             db 2fh,0ch,6,0
             db 2ah,0ch,1,0
             db 2fh,0ch,-1,1
             db 28h,0ch,-1,0
             db 4 dup(7ch,0ch,-1,0)
             db 5ch,0ch,-1,0
             db 7ch,0ch,1,1
             db 3 dup(7ch,0ch,1,0)
             db 29h,0ch,1,0

  UUU        db 77						;从UUU地址开始存放的是写字符'U'时所用的所有符号  
             db '_',0ch,0,0					;  及每个字符的显示颜色属性和位置
             db 7ch,0ch,1,0
             db '_',0ch,-1,1
             db 3dh,0ch,1,0
             db 7 dup(7ch,0ch,1,0)
             db 5ch,0ch,1,1
             db 7 dup(7ch,0ch,-1,0)
             db 3dh,0ch,-1,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 7ch,0ch,1,0
             db 5ch,0ch,8,0
             db 5ch,0ch,1,0
             db 5ch,0ch,0,1
             db 3 dup('_',0ch,-1,0,'_',0ch,0,1,'_',0ch,1,0,'_',0ch,0,1)     
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 2fh,0ch,1,0
             db 2bh,0ch,0,1
             db 2fh,0ch,-1,0
             db 7ch,0ch,-8,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db 7 dup(7ch,0ch,1,0)
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db 2fh,0ch,-1,1
             db 7 dup(2bh,0ch,-1,0)
             db 3dh,0ch,-1,0
             db '_',0ch,-1,0
             db '_',0ch,0,1
             db 3dh,0ch,1,0
             db 7 dup(7ch,0ch,1,0)
             db 7ch,0ch,-7,1
             db '_',0ch,-1,0
             db '_',0ch,0,1

  Ajeep      db 6
             db 3dh,0eh,0,0
             db 40h,0bh,1,0
             db 3dh,0eh,1,0
             db 3ch,0eh,0,-1
             db 02ah,0bh,-1,0
             db 3ch,0eh,-1,0
;---B--******************************--B---
  Bcar       db 2
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
  Bjeep      db 2      
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
  Bstar      db 2
             db 40h,0bh,0,0
             db 02ah,0,0,1
  Bstar1     db 2      
             db 40h,0bh,0,0
             db 02ah,0,0,-1

  Bcar1      db 2
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
  Bjeep1     db 2     
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
;---C-->F******************************--C-->F---
  Cstar2     db 26
             db 40h,0bh,0,0
             db 12 dup(02ah,0bh,0,1,40h,0bh,1,-3)            
             db 02ah,0bh,0,1
  Cstar3     db 26
             db 40h,0bh,0,0
             db 12 dup(02ah,0bh,0,-1,40h,0bh,1,3)
             db 02ah,0bh,0,-1
;---D-L-N-O-P-Q********************Q-P-O-N-L-D---
  car        db 29
             db 40h,0bh,0,0
             db 14 dup(40h,0bh,1,0)
             db 40h,00h,0,1
             db 13 dup(02ah,0bh,-1,0)             
  jeep       db 28      
             db 40h,0bh,0,0
             db 14 dup(40h,0bh,1,0)             
             db 02ah,0bh,-1,-1
             db 12 dup(02ah,0bh,-1,0)
;---E--******************************--E---
  Estar2     db 8
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 02ah,0bh,0,1
             db 02ah,0bh,-1,0
             db 40h,0bh,0,1
             db 40h,0bh,1,0
             db 02ah,0bh,0,1
             db 02ah,0bh,-1,0
  Estar3     db 8
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 02ah,0bh,0,-1
             db 02ah,0bh,-1,0
             db 40h,0bh,0,-1
             db 40h,0bh,1,0
             db 02ah,0bh,0,-1
             db 02ah,0bh,-1,0
;---G--******************************--G---
  Gstar2     db 18
             db 40h,0bh,0,0
             db 2 dup(40h,0bh,1,0,40h,0bh,1,0,40h,0bh,3,0)
             db 2 dup(40h,0bh,1,0)
             db 02ah,0bh,0,1
             db 2 dup(02ah,0bh,-1,0,02ah,0bh,-1,0,02ah,0bh,-3,0)
             db 2 dup(02ah,0bh,-1,0)
  Gstar3     db 8
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 40h,0bh,4,0
             db 40h,0bh,1,0
             db 02ah,0bh,0,-1
             db 02ah,0bh,-1,0
             db 02ah,0bh,-4,0
             db 02ah,0bh,-1,0
;---H--******************************--H---
  Hstar2     db 26
             db 40h,0bh,0,0
             db 12 dup(02ah,0bh,0,-1,40h,0bh,-1,3)         
             db 02ah,0bh,0,-1
  Hstar3     db 26
             db 40h,0bh,0,0
             db 12 dup(02ah,0bh,0,1,40h,0bh,-1,-3)
             db 02ah,0bh,0,1
;---I--******************************--I---
  Istar2     db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
             db 40h,0bh,12,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-10,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,8,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-6,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,4,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-2,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
  Istar3     db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
             db 40h,0bh,12,1
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-10,1
             db 02ah,0bh,0,-1
             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,8,1
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-6,1
             db 02ah,0bh,0,-1
             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,4,1
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-2,1
             db 02ah,0bh,0,-1
             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
  Istar1     db 2,8,14,20,26,32,38
;---K--******************************--K---
  Kstar2     db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,1

             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,2,-1
             db 02ah,0bh,0,1

             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-4,-1
             db 02ah,0bh,0,1

             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,6,-1
             db 02ah,0bh,0,1

             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-8,-1
             db 02ah,0bh,0,1

             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,10,-1
             db 02ah,0bh,0,1

             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-12,-1
             db 02ah,0bh,0,1
  Kstar3     db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1

             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,2,1
             db 02ah,0bh,0,-1

             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-4,1
             db 02ah,0bh,0,-1

             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,6,1
             db 02ah,0bh,0,-1

             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-8,1
             db 02ah,0bh,0,-1

             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,10,1
             db 02ah,0bh,0,-1

             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-12,1
             db 02ah,0bh,0,-1  
  Kstar1     db 38,32,26,20,14,8
;---M--******************************--M---
  Mstar      db 46
             db 02ah,0bh,0,0
             db 40h,0ch,0,1

             db 02ah,0bh,-1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,2,-1
             db 40h,0bh,0,1
             db 02ah,0bh,1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,-4,-1
             db 40h,0bh,0,1
             db 02ah,0bh,-1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,6,-1
             db 40h,0bh,0,1
             db 02ah,0bh,1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,-8,-1
             db 40h,0bh,0,1
             db 02ah,0bh,-1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,10,-1
             db 40h,0bh,0,1

             db 40h,0eh,1,-1
             db 40h,0eh,-12,0

             db 40h,0bh,1,-1
             db 02ah,0bh,0,1
             db 40h,0bh,10,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-2
             db 02ah,0bh,0,1
             db 40h,0bh,-8,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-2
             db 02ah,0bh,0,1
             db 40h,0bh,6,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-2
             db 02ah,0bh,0,1
             db 40h,0bh,-4,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-2
             db 02ah,0bh,0,1
             db 40h,0bh,2,-1
             db 02ah,0bh,0,1

             db 40h,0ch,-1,-2
             db 02ah,0bh,0,1
  Mstar1     db  16
             db 40h,0ch,0,1
             db 40h,0fh,-1,1
             db 40h,0fh,2,0
             db 40h,0fh,1,1
             db 40h,0fh,-4,0
             db 40h,0fh,-1,1
             db 40h,0fh,6,0
             db 40h,0eh,1,1
             db 40h,0eh,-8,0
             db 40h,0fh,1,1
             db 40h,0fh,6,0
             db 40h,0fh,-1,1
             db 40h,0fh,-4,0
             db 40h,0fh,1,1
             db 40h,0fh,2,0
             db 40h,0ch,-1,1
  Mcar       db 4
             db 3eh,0bh,0,0
             db 40h,0bh,0,-1
             db 3dh,0bh,0,-1
             db 3dh,0bh,0,-1
;---P--******************************--P---
  Pstar      db 1
             db 02ah,0ch,0,0
;-------*****************************-------
 char_cnt     dw ?
 pointer      dw ?
 line_on      db ?
 col_on       db ?
 char_cnt1    dw ?
 pointer1     dw ?
 line_on1     db ?
 col_on1      db ?
 char_cnt2    dw ?
 pointer2     dw ?
 line_on2     db ?
 col_on2      db ?
 char         dw ?
 col          dw ?
 point1       dw ?
 point2       dw ?
 
 Sline        db ?
 Scol         db ?
 Scount       db ?
 Scount1      dw ?
 Schar0       db ?

 A_Xchar      db ?
 A_Xcount     db ?
 A_Xcount0    db ?
 A_Xcount1    db ?
 A_Xchar0     db ?
 A_Xcool0     db ?
 A_Xcool1     db ?
 A_Xcool2     db ?
 A_Xcount_cx  dw ?

 Acount       db ?
 Acount0      db ?
 Acount1      db ?

 Bcol         db ?
 Bchar        db ?
 Bchar0       db ?
 Bchar1       db ?
 Bchar2       db ?
 Bcount0      db ?
 Bcount       db ?
 Bcount_cx    dw ?

 Ccol         db ?
 Ccol0        db ?
 Ccol00       db ?
 Ccol01       db ?
 Ccount       db ?
 Ccount0      db ?
 Ccount1      db ?
 Ccount2      db ?
 Cchar0       db ?
 Cchar1       db ?
 Cchar01      db ?
 Cchar2       db ?
 Ccount_cx    db ?

 Dchar1       db ?
 Dchar2       db ?
 Dchar3       db ?
 Dchar4       db ?
 Dcount       db ?
 Dcount_cx    dw ?

 Echar0      db ?
 Echar1      db ?
 Echar2      db ?
 Ecount      db ?
 Ecount1     db ?
 Ecount0     db ?
 Ecount_cx   dw ?

 Fcount      db ?
 Fchar1      db ?
 Fchar2      db ?

 Hcol         db ?
 Hcol0        db ?
 Hcol00       db ?
 Hcol01       db ?
 Hcount       db ?
 Hcount0      db ?
 Hcount1      db ?
 Hcount2      db ?
 Hchar0       db ?
 Hchar1       db ?
 Hchar01      db ?
 Hchar2       db ?
 Hline1       db ?
 Hcol1        db ?
 Hpot1        dw ?
 Hline2       db ?
 Hcol2        db ?
 Hpot2        dw ?
 Hcount_cx    db ?

 Icol         db ?
 Icol0        db ?
 Icol01       db ?
 Icount0      db ?
 Icount       db ?
 Icount1      db ?
 Ichar0       db ?
 Ichar01      db ?
 Ichar02      db ?
 Ichar1       db ?
 Ichar2       db ?
 Icount_cx    db ?

  cool        dw ?
 Jcool0       db ?
 Jcool1       db ?
 Jcool3       db ?
 Jcount       db ?

 Lchar1      db ?
 Lchar2      db ?
 Lchar0      db ?
 Lchar10     db ?
 Lcount_cx   dw ?

 Ncount_cx1  dw ?
 Ocount_cx2  db ?

 Pchar3      db ?
 Pchar4      db ?

 C_F         db ?
 E_B         db ?
 count       db ?
 data_seg    ends                                             ;结束数据段
;--<<<*****************>>CODE_SEGMENT<<***************>>>--  ;CODE_SEGMENT部分为定义代码段
 code_seg    segment
             assume cs:code_seg,ds:data_seg                   ;用ASSUME伪操作来指定某个段分配给哪一个段寄存器
 main        proc  far					      ;main part of program
             push  ds					      ;save old data segment
             sub   ax,ax                                      ;put zero in AX 
             sub   cx,cx                                             
             push  ax
             push  cx
             mov   ax,data_seg				      ;先将数据段地址输入AX数据寄存器
             mov   ds,ax                                      ;  再将AX数据寄存器的值装入数据段寄存器 
             mov   count,2
;--<<<****************>>VARIABLE<<***************>>>--        ;VARIABLE部分为给各个子程序独有的变量附初始值
             mov   Schar0,2
             mov   Scount,2
             mov   Scount1,500
 ;---A_X--**************************--A_X---
             mov   A_Xchar,2
             mov   A_Xcount,2
             mov   A_Xchar0,4
             mov   A_Xcool1,0eh
             mov   A_Xcool2,0ah
             mov   A_Xcount0,8
             mov   A_Xcount1,10
 ;---A--**************************--A---
             mov   Acount1,2
             mov   Acount0,11
 ;---B--**************************--B---
             mov   Bchar,2
             mov   Bchar0,2
             mov   Bchar1,16
             mov   Bchar2,4
             mov   Bcount,5
             mov   Bcount0,4
             mov   Bcount_cx,13
 ;---C--**************************--C---
             mov   C_F,2
             mov   Ccol,2
             mov   Ccol0,2
             mov   Ccol01,2
             mov   Cchar0,2
             mov   Cchar01,2
             mov   Ccount,1
             mov   Cchar1,40
             mov   Cchar2,38
             mov   Ccount0,4
             mov   Ccount1,2
             mov   Ccount_cx,2
 ;---D--**************************--D---
             mov   Dchar1,1
             mov   Dchar2,77
             mov   Dchar3,2
             mov   Dchar4,76
             mov   Dcount,2
 ;---E--**************************--E---
             mov   E_B,3
             mov   Ecount0,4
             mov   Ecount1,3
             mov   Echar1,4
             mov   Echar2,6
             mov   Ecount_cx,2
 ;---F--**************************--F---
             mov   Fcount,5
             mov   Fchar1,1
             mov   Fchar2,77
 ;---H--**************************--H---
             mov   Hcol,2
             mov   Hcol0,2
             mov   Hcol01,2
             mov   Hchar0,2
             mov   Hchar01,2
             mov   Hcount,1
             mov   Hchar1,1
             mov   Hchar2,77
             mov   Hcount0,4
             mov   Hcount1,2
             mov   Hcount_cx,2
 ;---I--**************************--I---
             mov   Icount0,10
             mov   Icol,4
             mov   Icol0,4
             mov   Icol01,4
             mov   Ichar0,2
             mov   Ichar01,2
             mov   Icount,5
             mov   Ichar1,39
             mov   Ichar2,39
             mov   Icount1,2
             mov   Icount_cx,2
 ;---J--**************************--J---
             mov   Jcount,15
             mov   Jcool3,4
 ;---L--**************************--L---
             mov   Lchar1,3
             mov   Lchar2,77
             mov   Lchar0,38
             mov   Lcount_cx,2
 ;---P--**************************--P---
             mov   Pchar3,4
             mov   Pchar4,16

             call  clear_screen                           ;调用清屏子程序
             HONG7
;--<<<****************>>>AGAIN<<<***************>>>--
Sagain:       
             lea   di,Scar
             mov   dh,4
             mov   dl,38
             call  move_shape1
             lea   di,Sjeep
             mov   dh,4
             mov   dl,39
             call  move_shape2
             dec   Scount
             lea   di,Sleft
             mov   dh,5
             mov   dl,38
             call  move_shape1
             lea   di,Sright
             mov   dh,5
             mov   dl,39
             call  move_shape2
             call  Smust_2
             inc   Scount
             lea   di,Sjeep1
             mov   dh,4
             mov   dl,75
             call  move_shape1      
             lea   di,Scar1
             mov   dh,4
             mov   dl,3
             call  move_shape2 
             mov   Schar0,2      
  Sexit01:   call  dly_qrtr
             dec   Scount1
             jne   Sexit01
             call  Smust_2
 ;---A_X--*****************************--A_X---
 A_Xagain:      
             mov   line_on1,4				;变量line_on1 用以存放指定光标初始显示的行号 
             mov   col_on1,4				;变量col_on1 用以存放指定光标初始显示的列号 
             call  A_Xmust_2
             mov   A_Xcount,1
 A_Xagain1:             
             mov   line_on1,4
             mov   col_on1,4
             call  A_Xmust_21
             cmp   A_Xcount,1
             jne   A_Xexit0
             mov   A_Xcool1,0eh
             mov   A_Xcool2,0ah
             inc   A_Xcount
             jmp   A_Xexit12
 A_Xexit0:   mov   A_Xcool1,0ch
             mov   A_Xcool2,03h
             dec   A_Xcount
 A_Xexit12:  dec   A_Xcount1
             jne   A_Xagain1

             mov   line_on1,4
             mov   col_on1,4
             mov   line_on2,16
             mov   col_on2,3
             call  A_Xmust_22
 ;---A--*****************************--A---
 Aagain:
             lea   di,QQQ					;将QQQ的值附给目的变址寄存器DI
             mov   dh,8					;将QQQ的值附给目的变址寄存器DI
             mov   dl,4					;dl数据寄存器存放列号
             call  move_shape1
             call  Amust_2                                             

 Aagain0:    lea   di,III
             mov   dh,15
             mov   dl,23
             call  move_shape1
             call  Amust_2

             lea   di,AAAA
             mov   dh,13
             mov   dl,38
             call  move_shape1
             call  Amust_2

             lea   di,NNN
             mov   dh,15
             mov   dl,58
             call  move_shape1
             call  Amust_2

             lea   di,Ajeep
             mov   dh,4
             mov   dl,75
             call  move_shape1
             call  Amust_21
             cmp   Acount1,1
             jne   Aagain1
             jmp   Bagain1     
  ;---------------------------------
 Aagain1:
             lea   di,JJJ
             mov   dh,6
             mov   dl,3
             call  move_shape1
             call  Amust_2

             lea   di,III
             mov   dh,15
             mov   dl,14
             call  move_shape1
             call  Amust_2

             lea   di,AAAA
             mov   dh,12
             mov   dl,24
             call  move_shape1
             call  Amust_2

             lea   di,NNN
             mov   dh,15
             mov   dl,42
             call  move_shape1
             call  Amust_2

             lea   di,GGG
             mov   dh,8
             mov   dl,58
             call  move_shape1
             call  Amust_2

             lea   di,Ajeep
             mov   dh,4
             mov   dl,75
             call  move_shape1
             call  Amust_21
  ;-----------------------------
  Aagain2:
             lea   di,DDD
             mov   dh,5
             mov   dl,3
             call  move_shape1
             call  Amust_2

             lea   di,AAAA
             mov   dh,13
             mov   dl,18
             call  move_shape1
             call  Amust_2

             lea   di,JJJ
             mov   dh,6
             mov   dl,36
             call  move_shape1
             call  Amust_2

             lea   di,III
             mov   dh,15
             mov   dl,47
             call  move_shape1
             call  Amust_2

             lea   di,UUU
             mov   dh,5
             mov   dl,59
             call  move_shape1
             call  Amust_2

             lea   di,Ajeep
             mov   dh,4
             mov   dl,75
             call  move_shape1
             call  Amust_21
 ;-----------------------------------
  Aagain3:
             lea   di,DDD
             mov   dh,5
             mov   dl,5
             call  move_shape1
             call  Amust_2
             dec   Acount1
             jmp   Aagain0
 ;---B--*****************************--B---
 Bagain1:    mov   Bcount,5
             mov   Bchar2,4
             mov   Bchar,2
             mov   Bchar0,2
             lea   di,Bcar1
             mov   dh,4
             mov   dl,2
             call  move_shape1

             lea   di,Bjeep1
             mov   dh,4
             mov   dl,76
             call  move_shape2
             call  Bmust_2
             dec   Bcount_cx
             jne   Bagain1
 ;---C--*****************************--C---
Cagain:    
             lea   di,Cstar2
             mov   dh,4
             mov   dl,3
             call  move_shape1
             lea   di,Cstar3        
             mov   dh,4
             mov   dl,75
             call  move_shape2
             dec   Ccount_cx
             call  Cmust_2
 ;---D--*****************************--D---
  Dagain:
             mov   Dchar1,1
             mov   Dchar2,77
             mov   Dcount_cx,cx
             lea   di,car
             mov   dh,3
             mov   dl,38
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,40
             call  move_shape2
             call  Dmust_2
             dec   Dcount
             jne   Dagain
 ;---E--*****************************--E---
             HONG7
 Eagain2:    mov   Echar0,4
 Eagain1:    dec   Echar0
             je    Eexit0
             lea   di,Estar2
             mov   dh,Echar1
             mov   dl,2
             add   Echar1,4
             call  Emust_2
             dec   Echar0
             je    Eexit0
             lea   di,Estar3
             mov   dh,Echar2
             mov   dl,76
             add   Echar2,7
             call  Emust_2
             jmp   Eagain1

 Eexit0:     dec   Ecount1
             je    Eexit02
             dec   Echar1
             lea   di,Bjeep
             mov   dh,10
             mov   dl,76
             call  Emust_2
             dec   Ecount1
             jmp   Eagain2
           
 Eexit02:    mov   Ecount,5
             mov   Ecount0,4
             mov   Ecount1,3
             mov   Echar1,4
             mov   Echar2,6
             dec   Ecount_cx
 Eagain25:   mov   Echar0,4
 Eagain15:   dec   Echar0
             je    Eexit05
             lea   di,Estar3
             mov   dh,Echar1
             mov   dl,75
             add   Echar1,4    
             call  Emust_2
             dec   Echar0
             je    Eexit05
             lea   di,Estar2
             mov   dh,Echar2
             mov   dl,3
             add   Echar2,7
             call  Emust_2
             jmp   Eagain15

 Eexit05:    dec   Ecount1
             je    Eexit025
             dec   Echar1
             lea   di,Bcar
             mov   dh,10
             mov   dl,3
             call  Emust_2
             dec   Ecount1
             jmp   Eagain25
 Eexit025:   dec   E_B 
 ;---F--*****************************--F---
             mov   Ccol,2
             mov   Ccol0,2
             mov   Ccol01,2
             mov   Cchar0,2
             mov   Cchar01,2
             mov   Ccount0,4
             mov   Ccount1,2
             mov   Ccount_cx,2
             mov   dl,Fcount
             mov   Ccount,dl
             mov   dl,Fchar1
             mov   Cchar1,dl
             mov   dl,Fchar2
             mov   Cchar2,dl
             dec   C_F

             lea   di,Cstar2
             mov   dh,4
             mov   dl,2
             call  move_shape1
             lea   di,Cstar3
             mov   dh,4
             mov   dl,76
             call  move_shape2
             call  Cmust_2
  ;-------------------------------------
             lea   di,Cstar2
             mov   dh,4
             mov   dl,40
             call  move_shape1
             lea   di,Cstar3
             mov   dh,4
             mov   dl,38
             call  move_shape2
             mov   Ccol,2
             mov   Ccol0,2
             mov   Ccol01,2
             mov   Cchar0,2
             mov   Cchar01,2
             mov   Cchar1,1
             mov   Cchar2,77
             dec   Ccount_cx
             call  Cmust_2             
 ;---G--*****************************--G---
             mov   Ccount,5
             mov   Ccount1,2
             mov   Ccount_cx,2
 Gagain:     lea   di,Gstar2
             mov   dh,4
             mov   dl,2
             call  move_shape1
             lea   di,Gstar3
             mov   dh,7
             mov   dl,76
             call  move_shape2
             call  Gmust_2
             dec   Ccount1
             dec   Ccount_cx
             jne   Gagain
 ;---H--*****************************--H---
 Hagain:    
             lea   di,Hstar2
             mov   dh,16
             mov   dl,38
             call  move_shape1
             lea   di,Hstar3
             mov   dh,16
             mov   dl,40
             call  move_shape2
             dec   Hcount_cx
             call  Hmust_2
 ;---I--*****************************--I---
  Iagain1:
             mov   Icol,4
             mov   Icol0,4
             mov   Icol01,4
             mov   Hchar0,2
             mov   Hchar01,2
             mov   Icount,5
             mov   Ichar1,39
             mov   Ichar2,39
             mov   Hcount1,2
             mov   Hcount_cx,2
             lea   di,Istar2
             mov   dh,4
             mov   dl,2
             call  move_shape1
             lea   di,Istar3
             mov   dh,4
             mov   dl,76
             call  move_shape2
             call  Imust_2
             dec   Icount0
             jne   Iagain1
 ;---J--*****************************--J---
 Jagain:
             mov   Icol,4
             mov   Icol01,4
             mov   Ichar0,2
             mov   Ichar01,2
             mov   Ichar02,2
             mov   Ichar1,39
             mov   Ichar2,39
             mov   Icount0,4
             mov   Icount1,2
             mov   Icount_cx,8
             mov   Jcool3,4
             mov   Icol0,4

             lea   di,Istar2
             mov   dh,4
             mov   dl,2
             call  move_shape1
             lea   di,Istar3
             mov   dh,4
             mov   dl,76
             call  move_shape2
             call  Jmust_21
             dec   Jcount
             jne   Jagain
 ;---K--*****************************--K---
             mov   Icount0,13
  Kagain1:
             mov   Icol,2
             mov   Icol0,2
             mov   Icol01,2
             mov   Ichar0,2
             mov   Ichar01,2
             mov   Icount,5
             mov   Ichar1,76
             mov   Ichar2,2
             mov   Icount1,2
             mov   Icount_cx,2

             lea   di,Kstar2
             mov   dh,10
             mov   dl,40
             call  move_shape1
             lea   di,Kstar3
             mov   dh,10
             mov   dl,38
             call  move_shape2
             call  Kmust_2
             dec   Icount0
             jne   Kagain1
 ;---L--*****************************--L---
  Lagain:       
             lea   di,car
             mov   dh,3
             mov   dl,39
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,41
             call  move_shape2
             call  Lmust_2
             cmp   Lchar1,40
             jb    Lagain

             dec   Lcount_cx
             call  dly_qrtr
             call  dly_qrtr
             lea   di,car
             mov   dh,3
             mov   dl,40
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,40
             call  move_shape2
             call  Lerase
 ;---M--*****************************--M---
             HONG7
             mov   Icount,2
             mov   cool,2000
 Magain1:
             lea   di,Mcar
             mov   dh,10
             mov   dl,3
             call  move_shape1
             call  Mmust_2

             lea   di,Mstar
             mov   dh,10
             mov   dl,75
             call  move_shape1
             call  Mmust_21

             lea   di,Mstar1
             mov   dh,10
             mov   dl,65
             call  move_shape1
             dec   Icount
             call  Mmust_2

             lea   di,Mstar
             mov   dh,10
             mov   dl,3
             call  move_shape1
             dec   Icount
             call  Mmust_21
 ;---N--*****************************--N---
             mov   Lcount_cx,80  
             mov   Ncount_cx1,5 
             mov   Lchar1,2
  Nagain:    lea   di,car
             mov   dh,3
             mov   dl,2
             call  Nmust_2
  Nagain1:   lea   di,car
             mov   dh,3
             mov   dl,4
             call  Nmust_21
             dec   Lcount_cx
             jne   Nagain1
 ;---O--*****************************--O---
             mov   Lcount_cx,30  
             mov   Ncount_cx1,3 
             mov   Ocount_cx2,9 
             mov   Lchar1,2
 Oagain:       
             lea   di,car
             mov   dh,3
             mov   dl,2
             call  Omust_1
 Oagain1:    lea   di,car
             mov   dh,3
             mov   dl,4
             call  Omust_2
             dec   Lcount_cx
             jne   Oagain1
             lea   di,car
             mov   dh,3
             mov   dl,2
             mov   Lchar1,2
             call  Omust_21
   ;-------------------------------------
             mov   Lcount_cx,30  
             mov   Ncount_cx1,3 
             mov   Ocount_cx2,9 
             mov   Lchar1,2
             lea   di,jeep
             mov   dh,3
             mov   dl,77
             call  Omust_1
Oagain2:     lea   di,jeep
             mov   dh,3
             mov   dl,75
             call  Omust_2
             dec   Lcount_cx
             jne   Oagain2
             lea   di,jeep
             mov   dh,3
             mov   dl,77
             mov   Lchar1,2
             call  Omust_21
 ;---P--*****************************--P---
             mov   Icol,1
             mov   Ichar0,2
             mov   Ichar1,7
             mov   Ichar2,74
             mov   Pchar3,4
             mov   Pchar4,16
             mov   Icount_cx,5
             mov   Ncount_cx1,5
             mov   Ocount_cx2,6
  Pagain:    lea   di,car
             mov   dh,3
             mov   dl,2
             call  Pmust_2
             lea   di,jeep
             mov   dh,3
             mov   dl,73
             call  Pmust_2
             lea   di,Pstar
             mov   dh,4
             mov   dl,8
             call  Pmust_21
             lea   di,jeep
             mov   dh,3
             mov   dl,76
             call  Pmust_22
 ;---Q--*****************************--Q---
             mov   Lchar1,1
             mov   Lchar2,78
             mov   Icount,0
             mov   Lchar0,2
 Qagain:     mov   Lcount_cx,38
             lea   di,car
             mov   dh,3
             mov   dl,1
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,78
             call  move_shape2
             cmp   Lchar0,1
             je    Qexit11
             call  Qmust_2
             call  dly_qrtr
             dec   Lchar0
             jmp   Qagain
 Qexit11:    call  Qerase1
             pop   cx
             ret						;return to main program
 main        endp						;end of main part of program 
;--<<<***************>>>CLEAR_SCREEN<<<**************>>>-- ;CLEAR_SCREEN程序部分实现清屏
 clear_screen proc near
             push   ax
             push   bx
             push   cx
             push   dx
             mov    ah,6					;scroll up function 
             mov    al,0					;code to blank screen
             cmp    count,1
             je     exit
             mov    ch,0					;upper left row
             mov    cl,0					;upper left column
             mov    dh,24					;lower right row
             mov    dl,79					;lower right column
             mov    bh,7
             jmp    exit1
 exit:       mov    ch,4
             mov    cl,3
             mov    dh,16
             mov    dl,63
             mov    bh,7
 exit1:      int    10h
             pop     dx
             pop     cx
             pop     bx
             pop     ax
             ret
 clear_screen  endp
;--<<<***************>>>MOVE_SHAPE<<<**************>>>--
 move_shape     proc near					;move_shape程序部分实现写方框功能  
                HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
             HONG5
 plot_nextR:
             add  dh,[di+2]					;update row  pointer
             add  dl,[di+3]					;update column pointer
             cmp  Bcount0,3
             je   exit2R
             cmp  Bcount0,2
             je   exit9R
             cmp  Bcount0,1
             je   exit10R
             cmp  dl,78
             jb   mov_crsrR
             jmp  exit1R
 exit2R:     cmp  dl,1
             jnb  mov_crsrR
             jmp  exit1R
 exit9R:     cmp  dh,17
             jb   mov_crsrR
             jmp  exit1R
 exit10R:    cmp  dh,3
             ja   mov_crsrR
 exit1R:     HONG1
             ret
 mov_crsrR:
             mov  ah,2
             int  10h
             mov  al,[di]					;fetch char value
             mov  bl,[di+1]					;fetch char attribute
             HONG6
             loop plot_nextR
 exit4R:     dec  Bcount
             je   exit3R
             call dly_qrtr					;调用延迟子程序                      
             jmp  exit4R
 exit3R:     call Berase1					;调用清除或改变光标位置的字符或其属性子程序
             mov  Bcount,5
             jmp  short plot_nextR
 move_shape  endp
;----------------------------------------
 move_shape1    proc near					;move_shape1和move_shape2程序为存放光标的起始位置 
                HONG
                cmp  Scount,1
                je   Sexit20
                sub  ch,ch
                mov  cl,[di]
                inc  di
                mov  char_cnt1,cx
                mov  pointer1,di
                mov  line_on1,dh
                mov  col_on1,dl
                mov  char,cx
                jmp  Sexit21

 Sexit20:       mov  point1,di
                mov  Hline1,dh
                mov  Hcol1,dl
 Sexit21:       HONG1
                ret
 move_shape1    endp
 ;-----------------------------------
 move_shape2    proc near
                HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
                cmp  Scount,1
                je   Sexit23
                mov  char_cnt2,cx
                mov  pointer2,di
                mov  line_on2,dh
                mov  col_on2,dl
                mov  char,cx
                jmp  Sexit22

 Sexit23:       mov  point2,di
                mov  Hline2,dh
                mov  Hcol2,dl

 Sexit22:       HONG1 
                ret
 move_shape2    endp
;--<<<****************>>>MUST_2<<<***************>>>-- ;MUST_2部分用于显示图形  

 Smust_2      proc       near
             HONG
 Sexit4:      sub  cx,cx
             HONG2
             mov        char,cx
             jmp        Splot_next
 Sexit3:      sub  cx,cx
             HONG3
             mov        char,cx
             jmp        Splot_next  
 Sexit5:     call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       Serase
             mov        Schar0,2
             jmp        Sexit4

 Splot_next: add  dh,[di+2]
             add  dl,[di+3]
             cmp  Scount,1
             jne  Sexit1
             cmp  dl,3
             je   Sexit2
             jmp  Sexit
 Sexit1:     cmp  dl,39
             je   Sexit2
 Sexit:      mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Splot_next
             cmp  Schar0,1
             je   Sexit5
             dec  Schar0
             jmp  Sexit3

 Sexit2:     call   Serase
             HONG1
             ret
 Smust_2       endp
;---A_X--*******************************--A_X---
 A_Xmust_2       proc near
                push ax
                push bx
                push dx
                mov  ah,0fh
                int  10h
                mov  A_Xcool0,1
  A_Xplot_next:
             mov  dh,line_on1
             mov  dl,col_on1
             mov  ah,2
             int  10h
             mov  al,40h
             mov  bl,0ch
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             mov  dl,A_Xcool0
             cmp  A_Xchar0,dl
             je   A_Xexit3
             call A_Xerase
             jmp  A_Xplot_next

 A_Xexit3:   cmp  col_on1,74
             je   A_Xexit1
             cmp  col_on1,38
             jne  A_Xexit7
             add  col_on1,2
             mov  A_Xcool0,1
             mov  line_on1,4
             jmp  A_Xplot_next

 A_Xexit7:   add  col_on1,2
             mov  A_Xcool0,1
             mov  line_on1,4
             cmp  A_Xcount,1
             je   A_Xexit5
             cmp  A_Xchar0,5
             je   A_Xexit4
             inc  A_Xchar0
             jmp  A_Xplot_next
 A_Xexit5:   cmp  A_Xchar0,1
             je   A_Xexit6
             dec  A_Xchar0
             jmp  A_Xplot_next
 A_Xexit4:   dec  A_Xcount
             dec  A_Xchar0
             jmp  A_Xplot_next
 A_Xexit6:   inc  A_Xcount
             inc  A_Xchar0
             jmp  A_Xplot_next
 A_Xexit1:       
             pop  dx
             pop  bx
             pop  ax
             ret
 A_Xmust_2   endp
;----------------------------------------
 A_Xmust_21    proc near
                push ax
                push bx
                push dx
                mov  ah,0fh
                int  10h
  A_Xplot_next1:
             mov  dh,line_on1
             mov  dl,col_on1
             mov  ah,2
             int  10h
             mov  ah,8					;读光标位置的字符和属性并返回属性参数AH、字符参数AL
             int  10h

             cmp  al,' '
             je   A_Xexit9
             cmp  al,40h
             jne  A_Xexit10
             mov  bl,A_Xcool1
             jmp  A_Xexit11
 A_Xexit10:  mov  al,'*'    
             mov  bl,A_Xcool2
 A_Xexit11:  push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
 A_Xexit9:   cmp  col_on1,74
             je   A_Xexit8 
             add  col_on1,2
             jmp  A_Xplot_next1
 A_Xexit8:   call dly_qrtr
             dec  A_Xcount0
             jne  A_Xexit8
             mov  A_Xcount0,10
             mov  col_on1,4             
             inc  line_on1
             cmp  line_on1,9
             jne  A_Xplot_next1
             pop  dx
             pop  bx
             pop  ax
             ret
 A_Xmust_21   endp
;---------------------------------------
;----------------------------------------
 A_Xmust_22    proc near
                push ax
                push bx
                push dx
             mov  A_Xcount,10
             mov  dh,line_on1
             mov  dl,col_on1
 A_Xplot_next2:
             mov  ah,2
             int  10h
             mov  al,40h    
             mov  bl,0ch
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             cmp  A_Xchar,1
             je   A_Xexit17
             cmp  dl,74
             je   A_Xexit19
             jmp  A_Xexit18
 A_Xexit17:  cmp  dl,75
             je   A_Xexit19
 A_Xexit18:  add  dl,2
             jmp  A_Xplot_next2

 A_Xexit19:  cmp  A_Xchar,1
             je   A_Xexit14
             mov  dh,line_on2
             mov  dl,col_on2
             dec  A_Xchar
             jmp  A_Xplot_next2

 A_Xexit14:  cmp  line_on2,4
             je   A_Xexit16
             call dly_qrtr
             dec  A_Xcount
             jne  A_Xexit14
             call A_Xerase1
             mov  dh,line_on1
             mov  dl,col_on1
             mov  A_Xchar,2
             mov  A_Xcount,10
             call dly_qrtr
             jmp  A_Xplot_next2
 A_Xexit16:  pop  dx
             pop  bx
             pop  ax
             ret
 A_Xmust_22  endp
;---A--*********************************--A---
 Amust_2       proc       near            
             HONG						;调用HONG
               sub  cx,cx
             HONG2
Aplot_next0: 
             add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             call dly_qrtr
             loop Aplot_next0
  Aexit6:    HONG1 
             ret              
  Amust_2    endp
;*********************************************** 
 Amust_21      proc       near
             HONG
                mov  Acount,20
 Aexit1:        call dly_qrtr
                dec  Acount
                je   Aexit5
                jmp  Aexit1
 Aexit5:        sub  cx,cx         
             HONG2
Aplot_next:
             add  dh,[di+2]
             add  dl,[di+3]             
             cmp  dl,2
             je   Aexit4
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             cmp  al,40h
             je   Aexitx0
             cmp  al,02ah
             je   Aexitx0
             jmp  Aexitx1
 Aexitx0:    dec  Acount0
             jne  Aplot_next 
             mov  Acount0,11
 Aexitx1:    add  di,4
             loop Aplot_next
             call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             call Aerase
             jmp  Aexit5
  Aexit4:    call Aerase
             HONG1
             ret        
  Amust_21   endp
;---B--*********************************--B---
 Bmust_2      proc       near
              HONG
 Bexit4:     sub  cx,cx
             HONG2
             jmp        Bplot_next
 Bexit3:     sub  cx,cx
             HONG3
             jmp        Bplot_next

 Bexit5:     dec  Bcount
             je   Bexit7
             call dly_qrtr
             jmp  Bexit5
 Bexit7:     inc  Bchar
             call Berase
             mov  Bcount,5
             cmp  Bchar0,1
             jne  Bexit11
             inc  Bchar0
 Bexit11:    jmp        short Bexit4

 Bplot_next: add  dh,[di+2]
             add  dl,[di+3]
             cmp  dh,Bchar1 
             jne  Bmov_crsr1   
             dec  Bchar2
             jmp  Bmov_crsr1
 Bexit2:     HONG1
             ret
 Bexit10:    call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             jmp  Bexit4
 Bmov_crsr1:                 
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Bplot_next

             cmp  Bchar,1
             je   Bexit8
             dec  Bchar
             jmp  Bexit3
 Bexit8:     cmp  Bchar2,0
             je   Bexit9
             cmp  dl,39   
             jne  Bexit5
             dec  Bchar0
             jmp  Bexit5
 Bexit9:     cmp  col_on2,2
             je   Bexit12
             add  col_on1,2
             sub  col_on2,2
             mov  Bchar2,4
             inc  Bchar
             jmp  Bexit10
 Bexit12:    dec  Bchar1
             jmp  Bexit2
 Bmust_2       endp
;---C-->F--*******************************--C-->F---  ;C、F程序公用部分
 Cmust_2      proc       near
                HONG
 Cexit41:    sub  cx,cx
             mov        Ccol,2
             mov        Ccol01,2
             mov        Cchar0,2
             mov        Cchar01,2
             HONG2
             mov        char,cx
             jmp        Cplot_next1
 Cexit31:    sub  cx,cx
             HONG3
             mov        char,cx
             jmp        Cplot_next1
 ;---------------------------------------------
 Cexit61:    call       dly_qrtr
             mov        Cchar0,2
             mov        Cchar01,2
             mov        Ccol01,2
             mov        Ccol,2
             mov        dl,col_on2
             dec        dl
             cmp        Cchar1,dl
             je         Cexit71
             call       dly_qrtr
             call       dly_qrtr
             call       Cerase1
             cmp        Ccol0,26
             je         Cexit41
             add        Ccol0,2
             jmp        Cexit41
 ;------------------------------------------
 Cexit71:    cmp        Ccount1,1
             je         Cexit93
             cmp        line_on1,4
             jne        Cexit91
             cmp        Ccol0,26
             jne        Cexit92
 Cexit91:    sub        Ccol0,2
             je         Cexit82
             inc        line_on1
             inc        line_on2
             sub        col_on1,2
             add        col_on2,2
             call       dly_qrtr
             call       dly_qrtr
             call       Cerase1
             mov        Ccount1,2
             jmp        Cexit41
 Cexit82:    cmp        Ccount_cx,1
             je         Cexit22
             jmp        Cexit81
 Cexit92:    mov        al,26
             sub        al,Ccol0
             mov        Ccount2,al
             add        Ccount2,2
             mov        dl,Ccol0
             mov        Ccol00,dl
 Cexit93:    sub        Ccount2,2
             je         Cexit91
             inc        line_on1
             inc        line_on2
             sub        col_on1,2
             add        col_on2,2
             sub        Ccol0,2
             call       dly_qrtr
             call       dly_qrtr
             call       Cerase1             
             mov        dl,Ccol00
             mov        Ccol0,dl
             dec        Ccount1
             cmp        Ccount1,1
             je         Cexit94
             mov        Ccount1,1
 Cexit94:    jmp        Cexit41 
 Cexit22:    jmp        Cexit21
 Cexit81:    add        Cchar1,2
             sub        Cchar2,2
             cmp        Cchar1,39
             je         Cexit21
             mov        line_on1,4
             mov        line_on2,4
             mov        dl,Cchar1
             inc        dl
             mov        col_on1,dl
             mov        dl,Cchar2
             dec        dl
             mov        col_on2,dl
             mov        Ccol0,2
             mov        Ccount1,2
             jmp        Cexit41
 Cexit01:    HONG9
             mov  dl,Ccol01
             cmp  Ccol0,dl
             je   Cexit02
             add  Ccol01,2
             mov  Ccol,2
             mov  Cchar01,2 
             dec  Cchar01 
             jmp  Cexit410
 Cexit02:    jmp        Cexit61
 Cexit21:    HONG1
             ret
 Cexit03:    jmp  Cexit01
 Cexit410:   HONG10
             jmp        Cplot_next1
 Cexit310:   HONG11
 ;--------------------------------------------
 Cplot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             cmp  C_F,1
             je   CF
             mov  al,[di]
             mov  bl,0ch
             jmp  CF1
 CF:         mov  al,[di]
             mov  bl,[di+1]
 CF1:        push cx                    
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             dec  Ccol
             je   Cexit51
             add  di,4
             jmp  Cplot_next1

 Cexit51:    cmp  Cchar01,0
             je   Cexit03  
             cmp  Cchar01,1
             je   Cexit12
             cmp  Cchar0,1
             je   Cexit03
             HONG8
             mov  Ccol,2     
             dec  Cchar0
             jmp  Cexit31

 Cexit12:    HONG8
             mov  Ccol,2
             dec  Cchar01
             jmp  Cexit310
Cmust_2      endp
;---D--*******************************--D---
 Dmust_2      proc       near
             HONG
 Dexit4:     sub  cx,cx
             HONG2
             mov        char,cx
             jmp        Dplot_next

 Dexit3:     sub  cx,cx
             HONG3
             mov        char,cx
             jmp        Dplot_next
 Dexit5:     cmp        Dchar1,dl
             je         Dexit2
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       Derase
             jmp        Dexit4
 Dexit2:     cmp        Dcount,1
             je         Dexit1
             cmp        Dchar1,37
             je         Dexit1
             add        Dchar1,2
             sub        Dchar2,2
             add        Dchar3,2
             mov        dl,Dchar3
             mov        col_on1,dl
             sub        Dchar4,2
             mov        dl,Dchar4
             mov        col_on2,dl
             call       dly_qrtr
             jmp        Dexit4
 Dexit1:     call   Derase
             HONG1
             ret              

 Dplot_next: add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Dplot_next
             cmp  char,28
             je   short Dexit5
             jmp  Dexit3
Dmust_2      endp
;---E--*******************************--E---
 Emust_2       proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
                HONG5
                cmp  Ecount_cx,1
                je   Eplot_next2
Eplot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  Echar0,2
             je   Eexit12
             cmp  Ecount1,2
             je   Eexit12
             cmp  dl,78
             jb   Emov_crsr1
             sub  dl,2
             jmp  Eexit13
Eexit12:     cmp  dl,0
             ja   Emov_crsr1
             add  dl,2
             jmp  Eexit13
Eexit13:     HONG1
             ret
Eplot_next2:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  Echar0,2
             je   Eexit122
             cmp  Ecount1,2
             je   Eexit122
             cmp  dl,2
             ja   Emov_crsr2
             add  dl,2
             jmp  Eexit13
 Eexit122:   cmp  dl,76
             jb   Emov_crsr2
             sub  dl,2
             jmp  Eexit13
 Emov_crsr1:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Eplot_next1
             jmp  Eexit41
 Emov_crsr2:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,0
             HONG6
             loop Eplot_next2
 Eexit41:    dec  Ecount
             je   Eexit31
             call dly_qrtr
             jmp  Eexit41
 Eexit31:    cmp  Ecount_cx,1
             je   Eexit51
             call Eerase1
             mov  Ecount,5
             jmp  Eplot_next1
 Eexit51:    call Eerase2
             mov  Ecount,5
             jmp  Eplot_next2
 Emust_2     endp
;---G--*******************************--G---
 Gmust_2      proc       near
             HONG
 Gexit4:     sub  cx,cx
             HONG2
             mov        char,cx
             jmp        Gplot_next
 Gexit3:     sub  cx,cx
             HONG3
             mov        char,cx
             jmp        Gplot_next

 Gplot_next: add  dh,[di+2]
             add  dl,[di+3]
             cmp  char,8
             je   Gexit1
             cmp  dl,78
             jb   Gmov_crsr
             jmp  Gexit2
 Gexit1:     cmp  dl,0
             ja   Gmov_crsr
 Gexit2:     HONG1
             ret
 Gmov_crsr:
             mov  ah,2
             int  10h
             cmp  Ccount1,1
             je   Gexit5
             mov  al,[di]
             mov  bl,[di+1]
             jmp  Gexit11
 Gexit5:     mov  al,[di]
             mov  bl,0
 Gexit11:    HONG6
             loop Gplot_next
             cmp        char,8
             je         short Gexit12
             jmp        Gexit3
 Gexit12:    dec        Ccount
             je         Gexit6
             call       dly_qrtr
             jmp        Gexit12
 Gexit6:     add        col_on1,2
             sub        col_on2,2
             mov        Ccount,5
             jmp        Gexit4
Gmust_2      endp
;---H--*******************************--H---
 Hmust_2      proc       near
             HONG
 Hexit41:     sub  cx,cx
             mov        Hcol,2
             mov        Hcol01,2
             mov        Hchar0,2
             mov        Hchar01,2
             HONG2
             mov        char,cx
             jmp        Hplot_next1
 Hexit31:     sub  cx,cx
             HONG3
             mov        char,cx
             jmp        Hplot_next1
 ;-----------------------------------------
 Hexit61:    call       dly_qrtr
             mov        Hchar0,2
             mov        Hchar01,2
             mov        Hcol01,2
             mov        Hcol,2
             mov        dl,col_on2
             inc        dl
             cmp        Hchar2,dl
             je         Hexit71
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       Herase1
             cmp        Hcol0,26
             je         Hexit41
             add        Hcol0,2
             jmp        Hexit41
 ;-----------------------------------------
 Hexit71:    cmp        Hcount1,1
             je         Hexit93
             cmp        line_on1,16
             jne        Hexit91
             cmp        Hcol0,26
             jne        Hexit92
 Hexit91:    sub        Hcol0,2
             je         Hexit82
             dec        line_on1
             dec        line_on2
             add        col_on1,2
             sub        col_on2,2
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       Herase1
             mov        Hcount1,2
             jmp        Hexit41
 Hexit82:    cmp        Hcount_cx,1
             je         Hexit22
             jmp        Hexit81
 Hexit92:    mov        al,26
             sub        al,Hcol0
             mov        Hcount2,al
             add        Hcount2,2
             mov        dl,Hcol0
             mov        Hcol00,dl
 Hexit93:    sub        Hcount2,2
             je         Hexit91
             dec        line_on1
             dec        line_on2
             add        col_on1,2
             sub        col_on2,2
             sub        Hcol0,2
             call       dly_qrtr
             call       dly_qrtr
             call       Herase1             
             mov        dl,Hcol00
             mov        Hcol0,dl
             dec        Hcount1
             cmp        Hcount1,1
             je         Hexit94
             mov        Hcount1,1
 Hexit94:    jmp        Hexit41 
 Hexit22:    jmp        Hexit21
 Hexit81:    add        Hchar1,2
             sub        Hchar2,2
             cmp        Hchar1,39
             je         Hexit21
             mov        line_on1,4
             mov        line_on2,4
             mov        dl,Hchar1
             inc        dl
             mov        col_on1,dl
             mov        dl,Hchar2
             dec        dl
             mov        col_on2,dl
             mov        Hcol0,2
             mov        Hcount1,2
             jmp        Hexit41
 Hexit01:    HONG9
             mov  dl,Hcol01
             cmp  Hcol0,dl
             je   Hexit02
             add  Hcol01,2
             mov  Hcol,2
             mov  Hchar01,2 
             dec  Hchar01 
             jmp  Hexit410
 Hexit02:    jmp        Hexit61
 Hexit21:    HONG1
             ret
 Hexit03:    jmp  Hexit01
 Hexit410:   HONG10
             jmp        Hplot_next1
 Hexit310:   HONG11
 ;----------------------------------------
 Hplot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,0ch
             push cx                    
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             dec  Hcol
             je   Hexit51
             add  di,4
             jmp  Hplot_next1
 Hexit51:    cmp  Hchar01,0
             je   Hexit03  
             cmp  Hchar01,1
             je   Hexit12
             cmp  Hchar0,1
             je   Hexit03
             HONG8
             mov  Hcol,2     
             dec  Hchar0
             jmp  Hexit31
 Hexit12:    HONG8
             mov  Hcol,2
             dec  Hchar01
             jmp  Hexit310
Hmust_2      endp
;---I--*******************************--I---
 Imust_2      proc       near
             HONG
 Iexit41:     sub  cx,cx
             mov        Icol,4
             mov        Icol01,4
             mov        Ichar0,2
             mov        Ichar01,2
             HONG2
             mov        char,cx
             jmp        Iplot_next1
 Iexit31:     sub  cx,cx
             HONG3
             mov        char,cx
             jmp        Iplot_next1
 ;------------------------------------------
 Iexit61:    call       dly_qrtr
             mov        Ichar0,2
             mov        Ichar01,2
             mov        Icol01,4
             mov        Icol,4
             mov        si,0
             mov        dl,col_on1
 Iexit66:    cmp        dl,Istar1[si]
             je         Iexit71
             inc        si
             cmp        si,7
             jne        Iexit66
             cmp        dl,38
             ja         Iexit72
 Iexit75:    call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       Ierase1
             cmp        Icol0,26
             je         Iexit81
             cmp        Icol0,24
             je         Iexit91
             add        Icol0,4
             jmp        Iexit41
 Iexit91:    add        Icol0,2
 Iexit81:    jmp        Iexit41

 Iexit71:  
             add        col_on1,2
             sub        col_on2,2
             cmp        Icol0,26
             je         Iexit81  
             add        Icol0,4
             jmp        Iexit41

 Iexit72:    cmp        dl,44       
             je         Iexit71
             cmp        dl,50
             je         Iexit21
             jmp        Iexit75 

 Iexit01:    HONG9
             mov  dl,Icol01
             cmp  Icol0,dl
             je   Iexit02
             cmp  Icol01,24
             je   Iexit73
             add  Icol01,4
             jmp  Iexit74
 Iexit73:    add  Icol01,2  
             mov  Icol,2
             jmp  Iexit70
 Iexit74:    mov  Icol,4
 Iexit70:    mov  Ichar01,2 
             dec  Ichar01 
             jmp  Iexit410
 Iexit02:    jmp        Iexit61
 Iexit21:    HONG1
             ret
 Iexit410:   HONG10
             jmp        Iplot_next1
 Iexit310:   HONG11
             jmp        Iplot_next1
 Iexit03:    jmp  Iexit01
 ;----------------------------------------
 Iplot_next1:add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             cmp  Ichar0,1
             je   Iexit77          
             cmp  dl,39
             ja   Iexit76
             jmp  Iexit78
 Iexit77:    cmp  Ichar01,1
             je   Iexit79
             cmp  Ichar01,0
             je   Iexit82
             cmp  dl,39
             jb   Iexit76
             jmp  Iexit78
 Iexit79:    cmp  dl,39
             ja   Iexit76
             jmp  Iexit78
 Iexit82:    cmp  dl,39
             jb   Iexit76
             jmp  Iexit78
 Iexit78:    mov  al,[di]
             mov  bl,[di+1]
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
 Iexit76:
             dec  Icol
             je   Iexit51
             add  di,4
             jmp  Iplot_next1
 Iexit51:    cmp  Ichar01,0
             je   Iexit03   
             cmp  Ichar01,1
             je   Iexit12
             cmp  Ichar0,1
             je   Iexit03
             HONG8
             mov  Icol,4     
             dec  Ichar0
             jmp  Iexit31

 Iexit12:    HONG8
             dec  Ichar01
             cmp  Icol01,26
             je   Iexit83
             mov  Icol,4
             jmp  Iexit310
 Iexit83:    mov  Icol,2
             jmp  Iexit310
Imust_2       endp
;---J--*******************************--J---
 Jmust_21      proc       near
             HONG
 Jexit710:      sub  cx,cx
             mov        Icol,4
             mov        Icol01,4
             mov        Ichar0,2
             mov        Ichar01,2
             mov        Ichar02,2
             HONG2
             mov        Jcool0,dl
             mov        Icount_cx,8
             jmp        Jplot_next10
 Jexit711:      sub  cx,cx
             HONG3
             mov        Jcool1,dl
             dec        Ichar0
             jmp        Jplot_next10

 Jexit610:   dec        Icount0       
             je         Jexit210
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       Jerase2
             add        Jcool3,4
             mov        dl,Jcool3
             mov        Icol0,dl
             jmp        Jexit710
 Jexit210:   HONG1
             ret

 Jexit010:   HONG9
             mov  dl,Icol01
             cmp  Icol0,dl
             je   Jexit0210
             cmp  Icol01,24
             je   Jexit730
             add  Icol01,4
             jmp  Jexit740
 Jexit730:   add  Icol01,2  
             mov  Icol,2
             jmp  Jexit700

 Jexit740:   mov  Icol,4
 Jexit700:   mov  Ichar01,2 
             dec  Ichar01 
             jmp  Jexit720

 Jexit0210:
             dec  Icount_cx
             je   Jexit610
             add  Jcool0,6             
             sub  Jcool1,6
             cmp  Icol0,26
             je   Jexit733
             mov  dl,Icol0
             add  dl,12
             cmp  dl,26
             jae  Jexit732
             mov  Icol0,dl
             jmp  Jexit733
 Jexit732:   mov  Icol0,26
             jmp  Jexit733

 Jexit720:   HONG10
             jmp    Jplot_next10
 Jexit721:   HONG11
             jmp    Jplot_next10
 Jexit733:     sub  cx,cx
             mov        Icol,4
             mov        Icol01,4
             mov        Ichar01,2
             mov        Ichar02,2
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,Jcool0
             dec        Ichar02
             jmp        Jplot_next10
 Jexit734:     sub  cx,cx
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,Jcool1
             jmp        Jplot_next10

 Jexit031:   jmp  Jexit010

 Jplot_next10:
             add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             cmp  Ichar0,0
             je   Jexit770
             cmp  dl,39
             ja   Jexit760
             jmp  Jexit780
 Jexit770:   cmp  Ichar01,1             
             je   Jexit790
             cmp  Ichar01,0
             je   Jexit820
             cmp  Ichar02,1
             je   Jexit790
             cmp  Ichar02,0
             je   Jexit820
 Jexit790:   cmp  dl,39
             ja   Jexit760
             jmp  Jexit780
 Jexit820:   cmp  dl,39
             jb   Jexit760
             jmp  Jexit780
 Jexit780:   mov  al,[di]     
             mov  bl,[di+1]
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             jmp  Jexit760
 Jexit032:   jmp  Jexit031
 Jexit760:
             dec  Icol
             je   Jexit510
             add  di,4
             jmp  Jplot_next10

 Jexit510:   cmp  Ichar01,0
             je   Jexit032   
             cmp  Ichar01,1
             je   Jexit120
             cmp  Ichar02,1
             je   Jexit520
             cmp  Ichar02,0
             je   Jexit032
             cmp  Ichar0,0  
             je   Jexit032
             HONG8
             mov  Icol,4     
             dec  Ichar0
             jmp  Jexit711
  Jexit520:  HONG8
             mov  Icol,4     
             dec  Ichar02
             jmp  Jexit734

 Jexit120:   HONG8
             dec  Ichar01
             cmp  Icol01,26
             je   Jexit830
             mov  Icol,4
             jmp  Jexit721
 Jexit830:   mov  Icol,2
             jmp  Jexit721
 Jmust_21    endp
;---K--*******************************--K---
 Kmust_2      proc       near
             HONG
 Kexit41:     sub  cx,cx
             mov        Icol,2
             mov        Icol01,2
             mov        Ichar0,2
             mov        Ichar01,2
             HONG2
             mov        char,cx
             jmp        Kplot_next1
 Kexit31:     sub  cx,cx
             HONG3
             mov        char,cx
             jmp        Kplot_next1
 ;------------------------------------------
 Kexit61:    call       dly_qrtr
             mov        Ichar0,2
             mov        Ichar01,2
             mov        Icol01,2
             mov        Icol,2
             mov        si,0
             mov        dl,col_on2
 Kexit66:    cmp        dl,Kstar1[si]
             je         Kexit71
             inc        si
             cmp        si,6
             jne        Kexit66
             cmp        dl,2
             je         Kexit72
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       Kerase1
             cmp        Icol0,26
             je         Kexit81
             add        Icol0,4
 Kexit81:    jmp        Kexit41

 Kexit71:    add        col_on1,2
             sub        col_on2,2
             cmp        Icol0,26
             je         Kexit81  
             add        Icol0,4
             jmp        Kexit41
 Kexit02:    jmp        Kexit61
 Kexit72:    jmp        Kexit21
 Kexit01:    HONG9
             mov  dl,Icol01
             cmp  Icol0,dl
             je   Kexit02

             add  Icol01,4
             mov  Icol,4
             mov  Ichar01,2 
             dec  Ichar01
             jmp  Kexit410
             
 Kexit21:    HONG1
             ret
 Kexit410:   HONG10
             jmp        Kplot_next1
 Kexit310:   HONG11
             jmp        Kplot_next1
 Kexit03:    jmp  Kexit01
 ;----------------------------------------
 Kplot_next1:add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             mov  ah,8
             int  10h
             cmp  dl,3
             jb   Kexitx0
             cmp  dl,76
             jae  Kexitx0
             cmp  ah,0bh
             je   Kexitx
             cmp  ah,0dh
             je   Kexitx2
             cmp  ah,0ah
             je   Kexitx3
             cmp  ah,0eh
             je   Kexitx4
 Kexitx0:    mov  al,[di]
             mov  bl,[di+1]
             jmp  Kexitx1
 Kexitx:     mov  bl,0dh
             jmp  Kexitx1
 Kexitx2:    mov  bl,0ah
             jmp  Kexitx1
 Kexitx3:    mov  bl,0eh
             jmp  Kexitx1
 Kexitx4:    mov  bl,0ch
 Kexitx1:    push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             dec  Icol
             je   Kexit51
             add  di,4
             jmp  Kplot_next1

 Kexit51:    cmp  Ichar01,0
             je   Kexit03   
             cmp  Ichar01,1
             je   Kexit12
             cmp  Ichar0,1
             je   Kexit03
             HONG8
             mov  Icol,2     
             dec  Ichar0
             jmp  Kexit31

 Kexit12:    HONG8
             dec  Ichar01
             mov  Icol,4
             jmp  Kexit310
Kmust_2      endp
;---L--*******************************--L---
 Lmust_2      proc       near
             HONG
 Lexit4:      sub  cx,cx
             HONG2
             mov        char,cx
             jmp        Lplot_next
 Lexit3:     sub  cx,cx
             HONG3
             mov        char,cx
             jmp        Lplot_next

 Lexit5:     call       dly_qrtr
             call       Lerase
             jmp        Lexit4

 Lplot_next: add  dh,[di+2]
             add  dl,[di+3]
             cmp  char,28
             je   Lexit1
             cmp  dl,Lchar2
             jb   Lmov_crsr 
             jmp  Lexit2
 Lexit1:     cmp  dl,Lchar1
             ja   Lmov_crsr
 Lexit2:     mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Lplot_next
             cmp  char,28
             jne  short Lexit3
             add  Lchar1,2
             sub  Lchar2,2
             HONG1
             ret
 Lmov_crsr:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Lplot_next
             cmp  char,28
             je   Lexit5
             jmp  Lexit3
 Lmust_2     endp
;---M--*******************************--M---
 Mmust_2       proc       near
             HONG
               sub  cx,cx
             HONG2
 Mplot_next0:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  dl,64
             je   Mexit6
             cmp  dl,3
             jb   Mexit7  
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             call dly_qrtr
             loop Mplot_next0
             cmp  Icount,1
             je   Mexit6
  Mexit7:    call dly_qrtr1
             call Merase
             jmp  Mplot_next0
  Mexit6:    HONG1 
             ret
 Mmust_2     endp
;---------------------------------------------
 Mmust_21      proc       near
             HONG
 Mexit5:        sub  cx,cx
             HONG2
 Mplot_next:  
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  Icount,0
             jne  Mexit8
             cmp  dl,3
             jb   Mexit1  
             mov  ah,2
             int  10h
             cmp  dl,64
             jae  Mexit2
             mov  al,[di]
             mov  bl,[di+1]
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             jmp  Mexit2
 Mexit0:     jmp  Mexit5
 Mexit8:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             call dly_qrtr
             loop Mplot_next
             jmp  Mexit4
 Mexit2:
             add  di,4
             loop Mplot_next
             dec  cool
             je   Mexit4
             sub  dl,2
             mov  cx,char_cnt1
             mov  di,pointer1
             mov  dh,line_on1
             jmp  Mplot_next
 Mexit1:      
             call Merase2
             mov  count,1
             call clear_screen
             cmp  col_on1,77
             jne  Mexit0

             mov  col_on1,62
             HONG2
             jmp  Mplot_next
  Mexit4:    HONG1
             ret
 Mmust_21    endp
;---N--*******************************--N---
 Nmust_2     proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
             HONG5
 Nplot_next:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  dl,78
             jb   Nmov_crsr
             HONG1
             ret         
 Nmov_crsr:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Nplot_next
             call dly_qrtr
             cmp  dl,3
             je   Nexit3
             cmp  dl,5
             je   Nexit3
             cmp  dl,77
             je   Nexit3
             dec  Ncount_cx1  
             je   Nexit2
             call Nerase
             jmp  Nexit3
 Nexit2:     mov  Ncount_cx1,5
 Nexit3:     add        col_on,2
             HONG4
             jmp  short Nplot_next
 Nmust_2     endp
  ;----------------------------------------
 Nmust_21     proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
                HONG5
                mov  Lchar0,dl
                mov  Ncount_cx1,5
  Nplot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Nplot_next1
;---------------------------------
             dec  Ncount_cx1
             je   Nexit21
             add  Lchar0,14
             mov        dl,Lchar0
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        Nplot_next1

 Nexit21:    call       dly_qrtr
             cmp        col_on,18
             je         Nexit1
             mov        Ncount_cx1,5
             add        col_on,2
             mov        dl,col_on
             mov        Lchar0,dl
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        Nplot_next1
 Nexit1:
             dec        Lchar1 
             mov        Ncount_cx1,5
             mov        dl,Lchar0
             mov        col_on,dl
             call       Nerase
             inc        Lchar1
             HONG1
             ret          
 Nmust_21   endp
;---O--*******************************--O---
 Omust_1      proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
             HONG5
 Oplot_next:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  char_cnt,28
             je   Oexitr1
             cmp  dl,78
             jb   Omov_crsr
             jmp  Oexitr2
 Oexitr1:    cmp  dl,1
             ja   Omov_crsr
 Oexitr2:    HONG1
             ret
 Omov_crsr:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Oplot_next
             call dly_qrtr
             cmp  char_cnt,28
             je   Oexitr3
             cmp  dl,3
             je   Oexit3
             cmp  dl,5
             je   Oexit3
             cmp  dl,77
             je   Oexit3
             dec  Ncount_cx1  
             je   Oexit2
             call Oerase
             jmp  Oexit3
 Oexit2:     mov  Ncount_cx1,3
 Oexit3:     add        col_on,2
             HONG4
             jmp  short Oplot_next
 Oexitr3:
             cmp  dl,76
             je   Oexit3r
             cmp  dl,74
             je   Oexit3r
             cmp  dl,2
             je   Oexit3r
             dec  Ncount_cx1  
             je   Oexit2r
             call Oerase
             jmp  Oexit3r
 Oexit2r:    mov  Ncount_cx1,3
 Oexit3r:    sub        col_on,2
             HONG4
             jmp        Oplot_next
 Omust_1    endp
 ;----------------------------------------
 Omust_2       proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
                HONG5

                mov  Lchar0,dl
                mov  Ocount_cx2,9
 Oplot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Oplot_next1
;---------------------------------
             dec  Ocount_cx2
             je   Oexit21
             cmp  char_cnt,28
             je   Oexitr4
             add  Lchar0,8
             jmp  Oexitr5
 Oexitr4:    sub  Lchar0,8
 Oexitr5:    mov        dl,Lchar0
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        Oplot_next1
 Oexit21:     
             cmp        char_cnt,28
             je         Oexitr9
             cmp        col_on,12
             je         Oexit1
             jmp        Oexit9r
 Oexitr9:    cmp        col_on,67
             je         Oexit1
 Oexit9r:    dec        Lchar1 
             mov        Ocount_cx2,9
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       Oerase      
             inc        Lchar1
             mov  Ocount_cx2,9
             jmp  Oplot_next1
 Oexit1:     HONG1
             ret
 Omust_2      endp
;-------------------------------------
 Omust_21     proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
             HONG5
 Oplot_next2:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  char_cnt,28
             je   Oexitr6
             cmp  dl,78
             jb   Omov_crsr2
             jmp  Oexit6r
 Oexitr6:    cmp  dl,1
             ja   Omov_crsr2
 Oexit6r:    call Oerase
             HONG1
             ret
 Omov_crsr2:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Oplot_next2
             call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             call Oerase
             jmp  short Oplot_next2
 Omust_21    endp
;---P--*******************************--P---
  Pmust_2     proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
                HONG5
 Pplot_next:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  char_cnt,28
             je   Pexit1
             cmp  dl,77
             jb   Pmov_crsr
             jmp  Pexit2
 Pexit1:     cmp  dl,5
             ja   Pmov_crsr
 Pexit2:     HONG1
             ret
 Pmov_crsr:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Pplot_next
             call dly_qrtr

             cmp  char_cnt,28
             je   Pexit3

             cmp  dl,3
             je   Pexit4
             cmp  dl,5
             je   Pexit4
             cmp  dl,77
             je   Pexit4
             dec  Ncount_cx1  
             je   Pexit7
             call Perase
             jmp  Pexit4
 Pexit7:     mov  Ncount_cx1,5
 Pexit4:     add        col_on,2
             HONG4
             jmp  short Pplot_next
 Pexit3:   
             dec  Ocount_cx2 
             je   Pexit5
             call Perase
             jmp  Pexit6      
 Pexit5:     sub        col_on,2
             mov        Ocount_cx2,6
 Pexit6:     sub        col_on,2
             HONG4
             jmp        Pplot_next

 Pmust_2    endp
;---------------------------------------
 Pmust_21     proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
             HONG5
                mov  Ichar0,2
  Pplot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  Ichar0,1
             je   Pexit0
             cmp  dl,18
             je   Pexit8
             cmp  dl,32
             je   Pexit8
             cmp  dl,46
             je   Pexit8
             cmp  dl,60
             je   Pexit8
             cmp  dl,Ichar2
             je   Pexit9
             jmp  Pmov_crsr1
  Pexit9:    dec  dl
             inc  dh
             cmp  dh,Pchar4
             je   Pexit18      
             jmp  Pmov_crsr1
  Pexit8:    add  dl,4
             jmp  Pmov_crsr1
  Pexit18:   dec  Ichar0
  Pexit0:    cmp  dl,63
             je   Pexit10
             cmp  dl,49
             je   Pexit10
             cmp  dl,35
             je   Pexit10
             cmp  dl,21
             je   Pexit10
             cmp  dl,Ichar1
             je   Pexit11
             jmp  Pmov_crsr1
 Pexit10:    sub  dl,4
             jmp  Pmov_crsr1
 Pexit11:    inc  dl
             dec  dh
             cmp  dh,Pchar3
             je   Pexit12
             jmp  Pmov_crsr1
 Pexit12:    inc  Pchar3
             dec  Pchar4
             inc  Ichar1
             cmp  Ichar1,18
             jne  Pexit13
             add  Ichar1,4
 Pexit13:    dec  Ichar2
             cmp  Ichar2,63
             jne  Pexit14
             sub  Ichar2,4
 Pexit14:    mov  dh,Pchar3
             mov  dl,Ichar1
             inc  Ichar0
 Pmov_crsr1:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
 Pexit19:    dec  Icount_cx
             je   Pexit20
             call dly_qrtr
             jmp  Pexit19
 Pexit20:    mov  Icount_cx,5
             cmp  Ichar0,1
             je   Pexit15
             inc  dl
             cmp  dh,10
             je   Pexit16
             jmp  Pplot_next1
 Pexit16:    cmp  dl,68
             je   Pexit17
             jmp  Pplot_next1
 Pexit15:    dec  dl            
             jmp  Pplot_next1
 Pexit17:    HONG1
             ret
 Pmust_21   endp
;-----------------------------------------------
 Pmust_22     proc near
             HONG
                sub  ch,ch
                mov  cl,[di]
                inc  di
                HONG5
                dec  Icol
  Pplot_next2:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  dl,1
             ja   Pmov_crsr2
             call Perase
             HONG1
             ret
 Pmov_crsr2:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             HONG6
             loop Pplot_next2
             call dly_qrtr
             call Perase
             jmp  Pplot_next2
 Pmust_22   endp
;---Q--*********************************--Q---
 Qmust_2       proc near
             HONG
 Qexit4:      sub  cx,cx
             HONG2
             mov        Hcol1,dl
             mov        char,cx     
             jmp        Qplot_next
 Qexit9:     call       dly_qrtr
             call       Qerase
 Qplot_next: add        dh,[di+2]
             add        dl,[di+3]
             cmp        char,28
             je         Qexit2
             cmp        dl,Lchar2
             jb         Qmov_crsr
             mov        Icount,1
             jmp        Qmov_crsr
 Qexit2:     cmp        dl,Lchar1 
             ja         Qmov_crsr
             mov        Icount,1
             jmp        Qmov_crsr
 Qexit5:     add        col_on1,2  
             add        Lchar1,2
             dec        Icount
             dec        Lcount_cx
             jne        Qexit4
             HONG1
             ret

 Qexit3:     sub  cx,cx
             HONG3
             mov        Hcol2,dl
             mov        char,cx
             jmp        Qplot_next
 Qmov_crsr:  mov        ah,2
             int        10h
             mov        al,[di]
             mov        bl,[di+1]
             HONG6
             loop       Qplot_next
             cmp        Icount,1
             je         Qexit10
             jmp        Qexit9
 Qexit10:    cmp        char,28
             je         Qexit5
             sub        Lchar2,2
             sub        col_on2,2  
             dec        Icount
             jmp        Qexit3
 Qmust_2      endp
;--<<<***************>>>ERASE<<<***************>>>--   ;ERASE部分为清除或改变光标所在位置或光标所在位置
 Serase       proc       near
            push  si
            sub   si,si
            mov  Schar0,2
 Sexit7:     sub  cx,cx
            push   bx
            sub    bx,bx
            mov        bl,Hline1
            mov        Sline,bl
            mov        bl,Hcol1
            mov        Scol,bl
            pop    bx
            HONG2
            mov        si,point1
            jmp        Serase_next
 Sexit6:     sub  cx,cx
            push   bx
            sub    bx,bx
            mov        bl,Hline2
            mov        Sline,bl
            mov        bl,Hcol2
            mov        Scol,bl
            pop    bx
            HONG3
            mov        si,point2
            jmp        Serase_next
 Serase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
    ;------------------------------------
             cmp        Scount,2
             je     Sexit31
             cmp        cx,13
             jb     Sexit31
             cmp        dl,Scol
             jne    Sexit31
             cmp        dh,Sline 
             jne    Sexit31
             mov        al,[si]
             mov        bl,[si+1]
             HONG6
             add        si,4
             cmp        Schar0,1
             je     Sexit40
             push   dx
             sub    dx,dx
             mov      dh,[si+2]
             add        dh,Hline1
             mov        Hline1,dh
             mov        Sline,dh
             mov      al,[si+3]
             add        al,Hcol1
             mov        Hcol1,al
             mov        Scol,al
             pop    dx
 Sexit41:    loop   Serase_next
             jmp    Sexit8
 Sexit31:    mov        al,' '
             mov        bl,0
             HONG6
             jmp    Sexit41
 Sexit40:     push   dx   
             sub    dx,dx
             mov         dh,[si+2]
             add      dh,Hline2
             mov        Hline2,dh
             mov        Sline,dh
             mov         dl,[si+3]
             add      dl,Hcol2
             mov        Hcol2,dl
             mov        Scol,dl
             pop    dx
             jmp     Sexit41
 Sexit8:     cmp        Schar0,1
             je         Sleft0
             mov        point1,si
             dec        Schar0
             jmp        Sexit6 
 Sleft0:     mov        point2,si
             dec        col_on1
             inc        col_on2
             pop   si
             ret
 Serase       endp
;---A_X--******************************--A_X---        ;  的字符的显示属性                     
 A_Xerase   proc       near
             mov        dh,line_on1
             mov        dl,col_on1
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,03h
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
             inc        A_Xcool0
             inc        line_on1
             ret
 A_Xerase       endp
;-----------------------------------------
 A_Xerase1     proc       near
             mov        A_Xchar,2
             mov        dh,line_on1
             mov        dl,col_on1
 A_Xerase_next:
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,03h
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
             cmp        A_Xchar,1
             je         A_Xexit20
             cmp        dl,74
             je         A_Xleft
             jmp        A_Xexit21
 A_Xexit20:  cmp        dl,75
             je         A_Xleft
 A_Xexit21:  add        dl,2
             jmp        A_Xerase_next
 A_Xleft:    cmp        A_Xchar,1
             je         A_Xexit15
             mov        dh,line_on2
             mov        dl,col_on2
             dec        A_Xchar
             jmp        A_Xerase_next
 A_Xexit15:  inc        line_on1
             dec        line_on2
             mov        col_on1,4
             mov        col_on2,3
             ret
 A_Xerase1       endp
;---A--*******************************--A---
 Aerase        proc       near
             HONG2
 Aerase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             cmp        dl,2
             je         Aleft
             mov        ah,2
             int        10h
             mov        ah,8
             int        10h
             cmp        al,40h
             je         Aexitx2
             cmp        al,02ah
             je         Aexitx2
             jmp        Aexitx3
 Aexitx2:    dec        Acount0
             jne        Aexitx3 
             mov        Acount0,11
 Aexitx3:    cmp        Acount1,1
             je         Aexit0
             mov        al,'*'
             mov        bl,03h
             jmp        Aexit7
 Aexit0:     mov        al,'*'
             mov        bl,0
 Aexit7:     push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
             cmp        Acount0,11
             jne        Aerase_next
             add        di,4
             loop       Aerase_next
             dec        col_on1
             HONG2
 Aleft:      ret
 Aerase        endp
;---B--*********************************--B---
Berase       proc       near
            sub  cx,cx
            HONG2
            jmp        Berase_next

Bexit6:     sub  cx,cx
            HONG3
            jmp        Berase_next
 Berase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             HONG6
             loop       Berase_next
 ;-------------------------------------------
             cmp        Bchar0,1
             je         Bleft1
             cmp        Bchar,1
             jz         Bleft
             inc        col_on1
             dec        Bchar
             jmp        short Bexit6
 Bleft:      dec        col_on2
             inc        Bchar
             ret

 Bleft1:     cmp        Bchar,1
             jz         Bleft2
             inc        line_on1
             dec        Bchar
             jmp        short Bexit6
 Bleft2:     inc        line_on2
             inc        Bchar
             ret
 Berase       endp
;--------------------------------------------
 Berase1       proc       near
             cmp        Bcount0,4
             jne        exit6R
             add        col_on,2
             jmp        exitR
 exit6R:     cmp        Bcount0,3
             jne        exit7R
             sub        col_on,2
             jmp        exitR
 exit7R:     cmp        Bcount0,2
             jne        exit8R
             inc        line_on
             jmp        exitR
 exit8R:     cmp        Bcount0,1
             jne        exitR
             dec        line_on
 exitR:      HONG4
             ret
 Berase1       endp
;---C--*************************************--C---
 Cerase1     proc       near
            sub  cx,cx
            HONG2
            mov        char,cx
            jmp        Cerase_next1

Cexit62:     sub  cx,cx
            mov        char,cx
            HONG3
            jmp   Cerase_next1

 Cexit011:   HONG9
             mov        dl,Ccol01
             cmp        Ccol0,dl
             je         Cexit021
             add        Ccol01,2
             mov        Ccol,2
             mov        Cchar01,2 
             dec        Cchar01 
             jmp  Cexit4101
 Cexit021:   jmp  Cleft
 Cexit012:   jmp  Cexit011

 Cexit4101:  HONG10
             jmp        Cerase_next1
 Cexit3101:  HONG11
 Cerase_next1:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
  ;-------------------------------------
             dec        Ccol
             je         Cexit0
             add        di,4
             jmp  Cerase_next1
 Cexit0:     cmp        Cchar01,0
             je         Cexit011 
             cmp        Cchar01,1
             je         Cexit121
             cmp        Cchar0,1
             je         Cexit012
             HONG8
             mov        Ccol,2     
             dec        Cchar0
             jmp  Cexit62

 Cexit121:   HONG8
             mov        Ccol,2
             dec        Cchar01
             jmp  Cexit3101
 Cleft:      add        col_on1,2
             sub        col_on2,2
             ret
 Cerase1      endp
;---D--*************************************--D---
Derase      proc       near
            sub  cx,cx
            HONG2
            mov        char,cx
            jmp        Derase_next

 Dexit6:       sub  cx,cx
            HONG3
            mov        char,cx
 Derase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             HONG6
             loop       Derase_next
          ;---------------------------
             cmp        char,28
             jz         Dleft
             inc        col_on1
             mov        dl,col_on1
             jmp  short Dexit6 
 Dleft:      dec        col_on2
             mov        dl,col_on2
             ret
 Derase      endp
;---E--*************************************--E---
 Eerase1     proc       near
             cmp        Echar0,2
             je         Eexit15
             cmp        Echar0,3
             je         Eexit14
             cmp        Echar0,1
             je         Eexit14
             cmp        Ecount1,2
             je         Eexit16
             jmp    Eexit01
 Eexit14:    add        col_on,4
             jmp    Eexit01
 Eexit15:    sub        col_on,4
             jmp    Eexit01
 Eexit16:    sub        col_on,2
 Eexit01:    HONG4
             ret                   
 Eerase1      endp
 ;------------------------------------------------
 Eerase2      proc       near
             cmp        Echar0,2
             je         Eexit152
             cmp        Echar0,3
             je         Eexit142
             cmp        Echar0,1
             je         Eexit142
             cmp        Ecount1,2
             je         Eexit162
             jmp        Eexit012
 Eexit142:   sub        col_on,4
             jmp        Eexit012
 Eexit152:   add        col_on,4
             jmp        Eexit012
 Eexit162:   add        col_on,2
 Eexit012:   HONG4
             ret
 Eerase2      endp
;---H--*************************************--H---
 Herase1    proc       near
            sub  cx,cx
            HONG2
            mov        char,cx
            jmp        Herase_next1

Hexit62:     sub  cx,cx
            HONG3
            mov        char,cx
            jmp     Herase_next1

 Hexit011:   HONG9
             mov        dl,Hcol01
             cmp        Hcol0,dl
             je         Hexit021
             add        Hcol01,2
             mov        Hcol,2
             mov        Hchar01,2 
             dec        Hchar01 
             jmp    Hexit4101
 Hexit021:   jmp        Hleft
 Hexit012:   jmp    Hexit011

 Hexit4101:  HONG10
             jmp    Herase_next1
 Hexit3101:  HONG11
 Herase_next1:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,[di]
             mov        bl,0ah
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
  ;-------------------------------------
             dec        Hcol
             je         Hexit0
             add        di,4
             jmp     Herase_next1
 Hexit0:     cmp        Hchar01,0
             je         Hexit011  
             cmp        Hchar01,1
             je         Hexit121
             cmp        Hchar0,1
             je         Hexit012
             HONG8 
             mov        Hcol,2     
             dec        Hchar0
             jmp     Hexit62

 Hexit121:   HONG8
             mov        Hcol,2
             dec        Hchar01
             jmp     Hexit3101
 Hleft:      sub        col_on1,2
             add        col_on2,2
             ret
 Herase1       endp
;---I--*************************************--I---
 Ierase1     proc       near
            sub  cx,cx
            HONG2
            mov        char,cx
            jmp     Ierase_next1

Iexit62:     sub  cx,cx
            HONG3
            mov        char,cx
            jmp     Ierase_next1

 Iexit011:   HONG9
             mov        dl,Icol01
             cmp        Icol0,dl
             je      Iexit021

             cmp        Icol01,24
             je      Iexit013
             add        Icol01,4
             jmp     Iexit014
 Iexit013:   add        Icol01,2  
             mov        Icol,2
             jmp     Iexit015
 Iexit014:   mov        Icol,4
 Iexit015:   mov        Ichar01,2 
             dec        Ichar01 
             jmp     Iexit4101
 Iexit021:   jmp     Ileft

 Iexit4101:  HONG10
             jmp     Ierase_next1
 Iexit3101:  HONG11
             jmp     Ierase_next1
 Iexit012:   jmp     Iexit011
 Ierase_next1:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             cmp        Ichar0,1
             je         Iexit770          
             cmp        dl,39
             ja         Iexit760
             jmp     Iexit780
 Iexit770:   cmp        Ichar01,1
             je         Iexit790
             cmp        Ichar01,0
             je         Iexit820
             cmp        dl,39
             jb         Iexit760
             jmp     Iexit780
 Iexit790:   cmp        dl,39
             ja         Iexit760
             jmp     Iexit780
 Iexit820:   cmp        dl,39
             jb         Iexit760
             jmp     Iexit780
 Iexit780:   mov        al,'*'
             mov        bl,0
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
  ;-------------------------------------
 Iexit760:   dec        Icol
             je         Iexit0
             add        di,4
             jmp     Ierase_next1
 Iexit0:     cmp        Ichar01,0
             je      Iexit012  ;-------------
             cmp        Ichar01,1
             je      Iexit121
             cmp        Ichar0,1
             je      Iexit012  ;--------------------
             HONG8
             mov        Icol,4
             dec        Ichar0
             jmp     Iexit62
 Iexit121:   HONG8
             dec        Ichar01
             cmp        Icol01,26
             je      Iexit122
             mov        Icol,4
             jmp     Iexit3101
 Iexit122:   mov        Icol,2
             jmp     Iexit3101

 Ileft:      add        col_on1,2
             sub        col_on2,2
             ret
 Ierase1      endp
;---J--*************************************--J---
 Jerase2       proc       near
            mov  dl,Jcool3
            mov  Icol0,dl
            mov        Icol,4
            mov        Icol01,4
            mov        Ichar0,2
            mov        Ichar01,2
            mov        Ichar02,2
            sub  cx,cx
            HONG2
            mov        Jcool0,dl
            mov        Icount_cx,8
            jmp     Jerase_next2

Jexit62L:     sub  cx,cx
            HONG3
            mov        Jcool1,dl
            dec        Ichar0
            jmp     Jerase_next2

 Jexit011L:  HONG9
             mov        dl,Icol01
             cmp        Icol0,dl
             je      Jexit021L

             cmp        Icol01,24
             je      Jexit013L
             add        Icol01,4
             jmp     Jexit014L
 Jexit013L:  add        Icol01,2  
             mov        Icol,2
             jmp     Jexit015L
 Jexit014L:  mov        Icol,4
 Jexit015L:  mov        Ichar01,2 
             dec        Ichar01 
             jmp     Jexit4101L

 Jexit021L:  dec        Icount_cx
             jne     JleftL
             add        col_on1,2
             sub        col_on2,2
             ret
                         
 JleftL:     add        Jcool0,6             
             sub        Jcool1,6
             cmp        Icol0,26
             je      Jexit733L
             mov        dl,Icol0
             add        dl,12
             cmp        dl,26
             jae     Jexit732L
             mov        Icol0,dl
             jmp     Jexit733L
 Jexit732L:  mov        Icol0,26
             jmp     Jexit733L

 Jexit4101L: HONG10
             jmp     Jerase_next2
 Jexit3101L: HONG11
             jmp     Jerase_next2
 Jexit733L:     sub  cx,cx
             mov        Icol,4
             mov        Icol01,4
             mov        Ichar01,2
             mov        Ichar02,2
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,Jcool0
             dec        Ichar02
             jmp     Jerase_next2
 Jexit734L:    sub  cx,cx
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,Jcool1
             jmp     Jerase_next2
 Jexit012L:  jmp     Jexit011L
 Jerase_next2:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             cmp        Ichar0,0
             je      Jexit77L
             cmp        dl,39
             ja      Jexit76L
             jmp     Jexit78L
 Jexit77L:   cmp        Ichar01,1             
             je      Jexit79L
             cmp        Ichar01,0
             je      Jexit82L
             cmp        Ichar02,1
             je      Jexit79L
             cmp        Ichar02,0
             je      Jexit82L
 Jexit79L:   cmp        dl,39
             ja      Jexit76L
             jmp     Jexit78L
 Jexit82L:   cmp        dl,39
             jb      Jexit76L
             jmp     Jexit78L
 Jexit78L:   mov        al,'*'
             mov        bl,0
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
  ;-------------------------------------
 Jexit76L:   dec        Icol
             je         Jexit07L
             add        di,4
             jmp     Jerase_next2

 Jexit018L:  jmp     Jexit012L

 Jexit07L:   cmp        Ichar01,0
             je      Jexit018L  
             cmp        Ichar01,1
             je      Jexit121L
             cmp        Ichar02,1
             je      Jexit01L
             cmp        Ichar02,0
             je      Jexit018L  ;--------------------
             cmp        Ichar0,0
             je      Jexit018L
             HONG8
             mov  Icol,4     
             dec  Ichar0
             jmp  Jexit62L
 Jexit01L:   HONG8
             mov  Icol,4     
             dec  Ichar02
             jmp  Jexit734L

 Jexit121L:  HONG8
             dec  Ichar01
             cmp  Icol01,26
             je   Jexit122L
             mov  Icol,4
             jmp  Jexit3101L
 Jexit122L:  mov  Icol,2
             jmp  Jexit3101L
 Jerase2       endp
;---K--*************************************--K---
 Kerase1       proc       near
            sub  cx,cx
            HONG2
            mov        char,cx
            jmp        Kerase_next1

 Kexit62:   sub  cx,cx
            HONG3
            mov        char,cx
            jmp        Kerase_next1

 Kexit011:   HONG9
             mov  dl,Icol01
             cmp  Icol0,dl
             je   Kexit021

             add  Icol01,4
             mov  Icol,4      
             mov  Ichar01,2 
             dec  Ichar01 
             jmp  Kexit4101                 

 Kexit4101:  HONG10
             jmp        Kerase_next1
 Kexit3101:  HONG11
             jmp        Kerase_next1
 Kexit012:   jmp   Kexit011
 Kexit021:   jmp   Kleft
            
 Kerase_next1:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
  ;-------------------------------------
             dec        Icol
             je         Kexit0
             add        di,4
             jmp        Kerase_next1
 Kexit0:     cmp  Ichar01,0
             je   Kexit012  
             cmp  Ichar01,1
             je   Kexit121
             cmp  Ichar0,1
             je   Kexit012
             HONG8
             mov  Icol,2     
             dec  Ichar0
             jmp  Kexit62
 Kexit121:   HONG8
             dec  Ichar01
             mov  Icol,4
             jmp  Kexit3101
 Kleft:      add        col_on1,2
             sub        col_on2,2
             ret
 Kerase1       endp
;---L--*************************************--L---
Lerase      proc       near                     
Lexit7:     mov  Lchar10,10
            sub  cx,cx
            HONG2
            mov        char,cx
            jmp        Lerase_next
Lexit6:     sub  cx,cx
            HONG3
            mov        char,cx
Lerase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             HONG6
             loop       Lerase_next

             cmp        char,28
             jz         Lleft
             inc        col_on1
             jmp        short Lexit6 
 Lleft:      dec        col_on2
             cmp        Lcount_cx,1
             jne        Lexit8
 Lexit9:     dec        Lchar10
             je         Lexit10
             call       dly_qrtr
             jmp        Lexit9
 Lexit10:    dec        Lchar0           
             jne        Lexit7
 Lexit8:     ret                     
 Lerase      endp
;---M--*************************************--M---
 Merase       proc       near
              HONG2
 Merase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             cmp        dl,3
             jb         Mleft0
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,03h
             HONG6
             loop       Merase_next
  Mleft0:    inc        col_on1
             HONG2
             ret
 Merase       endp
;-----------------------------------------
 Merase2      proc       near
            sub  cx,cx
            HONG2
 Merase_next2:
             add        dh,[di+2]
             add        dl,[di+3]
             cmp        dl,3
             jb         Mleft
             mov        ah,2
             int        10h
             cmp        dl,63
             jae        Mexit3
             mov        al,[di]
             mov        bl,0fh
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
 Mexit3:
             add        di,4
             loop       Merase_next2
             call       dly_qrtr1
             sub  dl,2
             mov  cx,char_cnt1
             mov  di,pointer1
             mov  dh,line_on1
             jmp        Merase_next2
  Mleft:     add        col_on1,2
             ret
 Merase2      endp
;---N--*************************************--N---
 Nerase       proc       near
             HONG4
             mov        Lchar0,dl
 Nerase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             HONG6
             loop       Nerase_next

             cmp        Lchar1,1
             jne        Nexit31
             dec        Ncount_cx1
             je         Nexitr
             sub        Lchar0,14
             mov        dl,Lchar0
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        Nerase_next

 Nexit31:    inc        col_on
             HONG4
             mov        Lchar0,dl
             ret
 Nexitr:     sub        col_on,2
             HONG4
             mov        Lchar0,dl
             mov        Ncount_cx1,5
             cmp        col_on,60
             jne        Nerase_next
 Nexit:      ret
 Nerase      endp
;---O--*************************************--O---
 Oerase       proc       near
             HONG4
             mov        Lchar0,dl
 Oerase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             HONG6
             loop       Oerase_next

             cmp        Lchar1,1
             jne        Oexit31
             dec        Ocount_cx2
             je         Oexit31
             cmp        char_cnt,28
             je         Oexitr7
             add        Lchar0,8
             jmp        Oexit7r
 Oexitr7:    sub        Lchar0,8
 Oexit7r:    mov        dl,Lchar0
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        Oerase_next

 Oexit31:    cmp        char_cnt,28
             je         Oexitr8
             inc        col_on
             jmp        Oexit8r
 Oexitr8:    dec        col_on
 Oexit8r:    HONG4
             mov        Lchar0,dl
 Oexit:      ret
 Oerase      endp
;---P--*************************************--P---
 Perase       proc       near
             HONG4
  Perase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             HONG6
             loop       Perase_next
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             cmp        char_cnt,28
             je         Pexit
             inc        col_on
             mov        dl,col_on
             ret
 Pexit:      cmp        Icol,0
             jne        Pleft
             dec        col_on
             mov        dl,col_on
 Pleft:      ret
 Perase      endp
;---Q--*************************************--Q---
 Qerase       proc       near
            cmp  char,28
            je   Qexit6
 Qexit7:     sub  cx,cx
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,Hcol1
            mov        char,cx
            jmp        Qerase_next
 Qexit6:     sub  cx,cx
            mov        cx,char_cnt2
            mov        di,pointer2
            mov        dh,line_on2
            mov        dl,Hcol2
            mov        char,cx
 Qerase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             HONG6
             loop       Qerase_next
             cmp        char,28
             je         Qleft
             inc        Hcol1
             mov        dl,Hcol1
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             ret
 Qleft:      dec        Hcol2
             mov        dl,Hcol2
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             ret                     
 Qerase       endp
;-----------------------------------------
 Qerase1      proc       near
 Qexit15:   mov  Lchar10,10
            sub  cx,cx
            HONG2
            mov        char,cx
            jmp        Qerase_next1
 Qexit14:     sub  cx,cx
            HONG3
            mov        char,cx
 Qerase_next1:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             HONG6
             loop       Qerase_next1

             cmp        char,28
             jz         Qleft1
             inc        col_on1
             jmp        Qexit14 
 Qleft1:     dec        col_on2
 Qexit13:    dec        Lchar10
             je         Qexit16
             call       dly_qrtr
             jmp        Qexit13
 Qexit16:    dec        Lcount_cx         
             jne        Qexit15
             ret                     
 Qerase1     endp
;--<<<***************>>>DLY_QRTR<<<***************>>>--   ;DLY_QRTR程序部分实现延迟功能
 dly_qrtr    proc       near
             push       cx
             push       dx
             mov        dx,25
 dll:        mov        cx,60000
 dl2:        loop       dl2
             dec        dx
             jnz        dll
             pop        dx
             pop        cx
             ret
 dly_qrtr    endp
 ;---------------------------------------
 dly_qrtr1   proc       near
             push       cx
             push       dx
             mov        dx,25
 dll1:       mov        cx,150
 dl21:       loop       dl2
             dec        dx
             jnz        dll
             pop        dx
             pop        cx
             ret
 dly_qrtr1   endp
;*******************************************
 code_seg    ends          
             end    main
                                           
