STACK SEGMENT STACK
      DW 200 DUP (?)
STACK ENDS
DATA SEGMENT
      SPACE DB 1000 DUP (' ')
      PATTERN DB 6 DUP (' '),0C9H,26 DUP (0CDH),0BBH,6 DUP (' ')
              DB 6 DUP (' '),0BAH,26 DUP (20H),0BAH,6 DUP (' ')
              DB 6 DUP (' '),0C8H,26 DUP (0CDH),0BCH,6 DUP (' ')
      DBUFFER DB 8 DUP (':'),12 DUP (' ')
      DBUFFER1 DB 20 DUP (' ')
      STR  DB 0DH,0AH, 'PLEASE INPUT DATE(D) OR TIME(T) OR QUIT(Q): $'
DATA ENDS
CODE SEGMENT
      ASSUME CS:CODE,DS:DATA,ES:DATA,SS:STACK
START: MOV AX,0001H          ;设置显示方式为40*25彩色文本方式            
       INT 10H
       MOV AX,DATA
       MOV DS,AX
       MOV ES,AX
       MOV BP,OFFSET SPACE       
       MOV DX,0B00H
       MOV CX,1000
       MOV BX,0040H
       MOV AX,1300H
       INT 10H
       MOV BP,OFFSET PATTERN ;显示矩形条     
       MOV DX,0B00H
       MOV CX,120
       MOV BX,004EH
       MOV AX,1301H
       INT 10H
       LEA DX,STR            ;显示提示信息
       MOV AH,9
       INT 21H
       MOV AH,1              ;从键盘输入单个字符
       INT 21H
       CMP AL,44H            ;AL='D'？
       JNE A
       CALL DATE             ;显示系统日期
A:     CMP AL,54H            ;AL='T'？
       JNE B                 
       CALL TIME             ;显示系统时间             
B:     CMP AL,51H            ;AL='Q'？            
       JNE START
       MOV AH,4CH            ;返回dos状态
       INT 21H

DATE   PROC NEAR             ;显示日期子程序
DISPLAY:MOV AH,2AH           ;取日期
       INT 21H
       MOV SI,0
       MOV AX,CX
       MOV BX,100
       DIV BL
       MOV BL,AH
       CALL BCDASC1         ;日期数值转换成相应的ASCII码字符
       MOV AL,BL
       CALL BCDASC1
       INC SI
       MOV AL,DH
       CALL BCDASC1
       INC SI
       MOV AL,DL
       CALL BCDASC1
       MOV BP,OFFSET DBUFFER1
       MOV DX,0C0DH
       MOV CX,20
       MOV BX,004EH
       MOV AX,1301H
       INT 10H
       MOV AH,02H          ;设置光标位置
       MOV DX,0300H
       MOV BH,0
       INT 10H
       MOV BX,0018H
REPEA: MOV CX,0FFFFH       ;延时
REPEAT:LOOP REPEAT
       DEC BX
       JNZ REPEA
       MOV AH,01H          ;读键盘缓冲区字符到AL寄存器
       INT 16H
       JE  DISPLAY
       JMP START
       MOV AX,4C00H
       INT 21H
       RET
DATE  ENDP

TIME   PROC NEAR        ;显示时间子程序
DISPLAY1:MOV SI,0
       MOV BX,100
       DIV BL
       MOV AH,2CH       ;取时间
       INT 21H
       MOV AL,CH
       CALL BCDASC      ;将时间数值转换成ASCII码字符
       INC SI
       MOV AL,CL
       CALL BCDASC
       INC SI
       MOV AL,DH
       CALL BCDASC
       MOV BP,OFFSET DBUFFER
       MOV DX,0C0DH
       MOV CX,20
       MOV BX,004EH
       MOV AX,1301H
       INT 10H
       MOV AH,02H
       MOV DX,0300H
       MOV BH,0
       INT 10H
       MOV BX,0018H
RE:    MOV CX,0FFFFH
REA:   LOOP REA
       DEC BX
       JNZ RE
       MOV AH,01H
       INT 16H
       JE  DISPLAY1
       JMP START
       MOV AX,4C00H
       INT 21H
       RET
TIME  ENDP

BCDASC PROC NEAR                ;时间数值转换成ASCII码字符子程序
       PUSH BX
       CBW
       MOV BL,10
       DIV BL
       ADD AL,'0'
       MOV DBUFFER[SI],AL
       INC SI
       ADD AH,'0'
       MOV DBUFFER[SI],AH
       INC SI
       POP BX
       RET
BCDASC ENDP

BCDASC1 PROC NEAR              ;日期数值转换成ASCII码字符子程序
       PUSH BX
       CBW
       MOV BL,10
       DIV BL
       ADD AL,'0'
       MOV DBUFFER1[SI],AL
       INC SI
       ADD AH,'0'
       MOV DBUFFER1[SI],AH
       INC SI
       POP BX
       RET
BCDASC1 ENDP
CODE   ENDS
       END START


