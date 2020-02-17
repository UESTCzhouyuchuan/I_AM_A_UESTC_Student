EXTRN  ASC_TO_BIN:FAR ,  BIN_TO_ASCII:FAR
DATA  SEGMENT   COMMON
INPUT_MESSAGE  DB  0AH , 'PLEASE INPUT A NUMBER(LESS THAN 5 FIGURES):$'
IN_ASC_BUF          DB 6                  ;十进制数的输入缓冲区，共可接收6个字符
                                  DB ?                  ;保留，用于10号调用时DOS填入实际输入字符个数
                                  DB 6 DUP(?)    ;一个符号位，四位数字ASCII码，加上一个回车符，
                                                            ;共计6字符
BIN_BUF1 DW ?                               ;将第一个数转换为二进制后，放于此处
OUTPUT_MESSAGE  DB   0AH , 'THE SUM IS:' , '$'
OUT_ASC_SUM DB 6 DUP(?) , '$'       ;将二个数的和转换为ASCII码后，放于此处，
                                                                 ;以供9号调用显示
DATA ENDS

CODE   SEGMENT
             ASSUME  CS:CODE ,  DS:DATA
START:
              MOV AX , DATA
              MOV DS , AX
              MOV DX , OFFSET INPUT_MESSAGE 
              MOV AH , 9
              INT 21H                                    ;提示输入一个数
              MOV DX , OFFSET IN_ASC_BUF 
              MOV AH , 10
              INT 21H                                    ;读取第一个数
              CALL ASC_TO_BIN               ;转换第一个数为二进制
              MOV BIN_BUF1 , AX             ;保存第一个数
              MOV DX , OFFSET INPUT_MESSAGE 
              MOV AH , 9
              INT 21H                                    ;提示输入一个数
              MOV DX , OFFSET IN_ASC_BUF 
              MOV AH , 10
              INT 21H                                    ;读取第二个数
              CALL ASC_TO_BIN               ; 转换第二个数为二进制
              ADD AX ,  BIN_BUF1            ;计算这二个数之和
              CALL BIN_TO_ASCII            ;将和转换为ASCII码，以供显示用
              MOV DX , OFFSET OUTPUT_MESSAGE
              MOV AH , 9
              INT 21H
              MOV DX , OFFSET OUT_ASC_SUM
              MOV AH , 9
              INT 21H
              MOV AH , 4CH
              INT 21H
CODE ENDS
              END START
