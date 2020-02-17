DATA   SEGMENT
INFO1  DB 0DH,0AH,'INPUT 1,2,OR 3:(1:bird,2:car,3:exit) $'
BUFA   DB 200
       DB ?
       DB 200 DUP(0)
BUFB   DB 200 DUP(?)
BIRD   DB 76H,10,0,0              ;小鸟的字符图形表
       DB 0C4H,07,0,1
       DB 76H,10,-2,2
       DB 0C4H,07,0,1
       DB 76H,10,-2,2
       DB 0C4H,07,0,1
       DB 76H,10,-2,2
       DB 0C4H,07,0,1
       DB 76H,10,2,-2
       DB 0C4H,07,0,1
       DB 76H,10,2,-2
       DB 0C4H,07,0,1
       DB 76H,10,2,-2
       DB 0C4H,07,0,1
CAR    DB 7                   ;小汽车的字符图形表
       DB 52H,7,0,0
       DB 0B1H,7,0,1
       DB 0DBH,7,0,1
       DB 0DBH,7,0,1
       DB 4FH,7,1,0
       DB 4FH,7,0,-3
       DB 2,7,-2,1
       CHAR_CNT DW ?
       POINTER DW ?
       LINE_ON DB ?
       COL_ON DB ?
DATA   ENDS
STACK  SEGMENT stack
       DB 200 DUP(0)
STACK  ENDS
CODE   SEGMENT
       ASSUME CS:CODE,DS:DATA,SS:STACK
 start:mov ax,data
       mov ds,ax
       mov ah,0              ;设置显示方式为320*200彩色图形方式
       mov al,4
       int 10h
       lea dx,info1          ;在显示器上显示字符串提示信息        
       mov ah,9
       int 21h
       mov ah,0              ;从键盘读取字符到AL寄存器
       int 16h 
       CMP AL,31H            ;比较AL是否等于1 
       JNE  A
       CALL XIAO
   A:  CMP AL,32H            ;比较AL是否等于2           
       JNE  B
       CALL QICHE
   B:  CMP AL,33H            ;比较AL是否等于3
       JNE START
       MOV AH,4CH            ;终止当前程序并返回调用程序
       INT 21H
CLEAR  MACRO pch,pcl,pdh,pdl,pbh ;清屏宏定义
       MOV AH,0
       MOV AL,4
       INT 10H
       MOV AH,6              ;调用6号功能
       MOV AL,0              ;设置整个屏幕为空白
       MOV CH,pch            
       MOV CL,pcl            ;窗口左上角（0行，0列）
       MOV DH,pdh
       MOV DL,pdl            ;窗口右下角（24行，79列）
       MOV BH,pbh            ;正常属性显示
       INT 10H
ENDM
xiao   proc                    ;小鸟子程序
       PUSH  DS
       MOV AX,0
       PUSH AX
       MOV AX,DATA
       MOV DS,AX
       MOV AH,0
       MOV AL,4
       INT 10H
       MOV AH,0BH            ;设置背景色 
       MOV BH,0
       MOV BL,1
       INT 10H
       MOV AH,0BH            ;设置彩色组 
       MOV BH,1
       MOV BL,1
       INT 10H
       CLEAR 0,0,24,79,7
       MOV AH,0FH            ;读当前显示状态
       INT 10H
       MOV DH,10
       MOV DL,0
BEGIN: MOV SI,2
       MOV CX,1
       LEA DI,BIRD            ;DI指向小鸟字符表的首字母
DISP:  CMP DL,80
       JAE exit1
       MOV AH,2               ;设置光标位置
       INT 10H
       MOV AH,9               ;显示小鸟字符图形
       MOV AL,[DI]
       MOV BL,[DI+1]
       INT 10H
       CALL DLY               ;延时
       MOV AH,9
       MOV AL,' '
       MOV BL,04
       INT 10H
       INC DL
       ADD DI,2
       DEC SI
       JNZ DISP
       JMP BEGIN
exit1: RET
xiao endp
DLY PROC NEAR                ;延时子程序
       PUSH CX
       PUSH DX
       MOV  DX,10000
DL1:   MOV  CX,6801
DL2:   LOOP DL2
       DEC  DX
       JNZ  DL1
       POP  DX
       POP  CX
       RET
DLY    ENDP
QICHE  PROC near              ;汽车子程序 
       PUSH AX
       PUSH BX
       PUSH CX
       PUSH DX     
       MOV AH,0
       MOV AL,4
       INT 10H
       MOV AH,0BH            ;设置彩色组颜色为绿、红、黄
       MOV BH,01
       MOV BL,00
       INT 10H
       CLEAR 0,0,24,79,7     ;清屏宏调用
       LEA DI,CAR            ;DI指向字符图形表
       MOV DH,5              ;从第5行5列位置开始显示汽车
       MOV DL,0
       CALL MOVE_SHAPE
       RET
QICHE  ENDP
MOVE_SHAPE PROC NEAR         
       PUSH AX
       PUSH BX
       PUSH CX
       PUSH DX
       PUSH DI
       MOV AH,0FH             ;取当前显示方式
       INT 10H
       SUB CH,CH
       MOV CL,[DI]            ;CL放字符个数
       INC DI                 ;DI指向字符图形表中的第一个字符
       MOV CHAR_CNT,CX
       MOV POINTER,DI
       MOV LINE_ON,DH
       MOV COL_ON,DL
PLOT_NEXT: 
       ADD DH,[DI+2]          ;改变行列坐标
       ADD DL,[DI+3]
       CMP DL,80              ;出屏否？
       JB MOV_CRSR
       Pop DI
       Pop DX
       Pop CX
       Pop BX
       Pop AX
       jmp exit2
MOV_CRSR:  
       MOV AH,2               
       INT 10H
       MOV AL,[DI]            ;取字符值
       MOV BL,[DI+1]          ;取字符属性
       PUSH CX
       MOV CX,1
       MOV AH,09              ;显示字符
       INT 10H
       POP CX
       ADD DI,4               ;DI指向下一个字符
       LOOP PLOT_NEXT
       CALL DLY
       CALL ERASE
       JMP SHORT PLOT_NEXT
exit2: ret    
MOVE_SHAPE ENDP
ERASE  PROC NEAR
       MOV CX,CHAR_CNT
       MOV DI,POINTER
       MOV DH,LINE_ON
       MOV DL,COL_ON
ERASE_NEXT: 
       ADD DH,[DI+2]
       ADD DL,[DI+3]
       MOV AH,2
       INT 10H
       MOV AL,[DI]
       MOV BL,0
       PUSH CX
       MOV CX,1
       MOV AH,9
       INT 10H
       POP CX
       ADD DI,4
       LOOP ERASE_NEXT
       MOV CX,CHAR_CNT
       MOV DI,POINTER
       MOV DH,LINE_ON
       INC COL_ON
       MOV DL,COL_ON
       RET
ERASE  ENDP
CODE ENDS 
     END start
