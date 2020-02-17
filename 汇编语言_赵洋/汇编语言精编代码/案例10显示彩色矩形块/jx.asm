DATA   SEGMENT
LINE   DW   0                     ;矩形块左上角的行
ROW    DW   0                     ;矩形块左上角的列
PIX    DB   0                    ;矩形块的颜色
DATA   ENDS

CODE         SEGMENT
             ASSUME  CS:CODE,DS:DATA
START:                               ;主程序
             MOV AX , DATA
             MOV DS , AX
             MOV AH , 0
             MOV AL , 4
             INT 10H                 ;设置320×200彩色图形方式
             
             mov ah,0bh
             mov bh,01
             mov bl,0
             int 10h
             MOV CX, 4
L1:
             CALL DISP_RECT
             call delay
             inc PIX                 ;每循环一次，点的颜色加1
             ADD ROW , 30            ;改变下一个方块的显示位置
             LOOP L1
             MOV AH , 4CH
             INT 21H                 ;返回DOS
;显示矩形块的子程序，矩形块的显示位置由DATA段中的LINE、ROW变量指定，
;颜色由PIX变量指定，矩形块的大小是固定的，为10个点宽，100个点高。
DISP_RECT    PROC  near
             PUSH AX
             PUSH CX
             PUSH DX
             PUSH SI
             PUSH DI
             MOV AH , 0CH       ;指明写点调用
             MOV AL , PIX       ;取点的颜色
             MOV DI , 100       ;用于控制行显示循环
             MOV DX , LINE      ;取点的行坐标
DISP_2: 
             MOV SI , 10        ;控制列显示循环
             MOV CX , ROW       ;取显示点的列坐标
DISP_1: 
             INT 10H            ;完成点的显示
             INC CX             ;列坐标加1（行不变）
             DEC SI
             JNZ DISP_1         ;循环显示完一行的10个点
             INC DX             ;行坐标加1
             DEC DI
             JNZ DISP_2         ;循环显示完100行
             POP DI
             POP SI
             POP DX
             POP CX
             POP AX
             RET
DISP_RECT    ENDP
delay        proc near       
             push cx
             push dx
             mov dx,5000
d11:         mov cx,25000  
d12:         loop d12
             dec   dx
             jnz   d11
             pop   dx
             pop   cx
             ret
delay        endp
CODE         ENDS
             END  START
