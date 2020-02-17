;模块B：
PUBLIC  ASC_TO_BIN ,  BIN_TO_ASCII
DATA   SEGMENT   COMMON
INPUT_MESSAGE      DB  0AH , 'PLEASE INPUT A NUMBER(LESS THAN 5 FIGURES):$'
IN_ASC_BUF              DB 6                 ;十进制数的输入缓冲区，共可接收6个字符
                                      DB ?                 ;保留，用于10号调用时DOS填入实际输入字符个数
                                      DB 6 DUP(?)   ;一个符号位，四位数字ASCII码，加上一个回车符，
                                                                ;共计6字符
BIN_BUF1                   DW ?                ;将第一个数转换为二进制后，放于此处
OUTPUT_MESSAGE  DB 0AH , 'THE SUM IS:' , '$'
OUT_ASC_SUM         DB 6 DUP(?) , '$'       ;将二个数的和转换为ASCII码后，放于此处，
                                                                         ;以供9号调用显示
DATA ENDS
CSEG   SEGMENT
             ASSUME CS:CSEG ,  DS:DATA
ASC_TO_BIN PROC  FAR
;ASCII码转换为二进制数
;入口：十进制数的ASCII码在IN_ASC_BUF内
;出口：转换后的二进制数在AX内
;算法：先将其转换成十进制数字，再用累加和乘10加X的方法变成二进制数，如将
;358转换为二进制数，可先将累加和赋0，再计算(((0*10+3)*10+5)*10+8)，结果为二
;进制数，再由符号位决定是否需要求补。
             MOV CL ,  IN_ASC_BUF+1         ;取字符个数
             MOV CH , 0
             DEC CL                                          ;扣除符号位
             MOV BX , OFFSET IN_ASC_BUF+3      ;调整BX指向十进制数的最高位
             PUSH BX
             PUSH CX
L1:
             MOV AL , [BX]
             AND AL , 0FH
             MOV [BX] , AL
             INC BX
             LOOP L1                                        ;将所有数字字符的高四位清0，使之变为数字值
             POP CX
             POP BX
             MOV AX , 0                                   ;累加和赋初值
             MOV SI , 10
L2:
             MUL SI
             ADD AL , [BX]
             ADC AH , 0
             INC BX
             LOOP L2                                        ;累加乘10
            CMP IN_ASC_BUF+2 , '+'
             JZ L3                                               ;符号是正号，转移
             NEG AX                                         ;符号是负号，求补
L3:
             RET
ASC_TO_BIN ENDP

BIN_TO_ASCII PROC  FAR
;将二进制数转换为对应十进制数数字的ASCII码
;入口：二进制数在AX内
;出口：转换后的ASCII码在OUT_ASC_SUM变量内
;算法：AX中的数范围在+32767到-32768之间，先检查AX中的符号位，以决定输出“+”
;还是“-”，若是负数，应先求补，得到原码后即可与正数作统一处理。转换方法为将被转换的
;二进制数先除以10000，商;即为万位数，再将余数除以1000，商为千位数，以此类推，求出
;百、十位数，剩下的为个位数。最后，将各个数加上30H，即成为对应字符。
            MOV OUT_ASC_SUM , '+'
            CMP AX , 0
            JGE L4                                             ;不是负数，转移
            NEG AX
           MOV OUT_ASC_SUM , '-'
L4:
           CWD
            MOV BX , 10000
            DIV BX
           ADD AL , 30H                                 ; 将万位转换为数字(商应在AX内，但因为商不大于3，
                                                                     ;所以有效部分在AL内) 
            MOV OUT_ASC_SUM+1 , AL     ;保存万位数字
            MOV AX , DX                                ;将余数置入AX内，以便当作被除数
            CWD
            MOV BX , 1000
            DIV BX
            ADD AL , 30H
            MOV OUT_ASC_SUM+2 , AL     ;保存千位数字
            MOV AX , DX                                ;将余数置入AX内，以便当作被除数
            MOV BL , 100
           DIV BL
            ADD AL , 30H
            MOV OUT_ASC_SUM+3 , AL     ;保存百位数字
            MOV AL , AH
           CBW
           MOV BL , 10
           DIV BL
            ADD AL , 30H
           MOV OUT_ASC_SUM+4 , AL      ;保存十位数字
            ADD AH , 30H
            MOV OUT_ASC_SUM+5 , AH     ;保存个位数字
            RET
BIN_TO_ASCII   ENDP
CSEG  ENDS
            END 
