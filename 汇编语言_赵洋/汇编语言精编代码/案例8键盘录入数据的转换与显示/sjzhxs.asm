EXTRN  ASC_TO_BIN:FAR ,  BIN_TO_ASCII:FAR
DATA  SEGMENT   COMMON
INPUT_MESSAGE  DB  0AH , 'PLEASE INPUT A NUMBER(LESS THAN 5 FIGURES):$'
IN_ASC_BUF          DB 6                  ;ʮ�����������뻺���������ɽ���6���ַ�
                                  DB ?                  ;����������10�ŵ���ʱDOS����ʵ�������ַ�����
                                  DB 6 DUP(?)    ;һ������λ����λ����ASCII�룬����һ���س�����
                                                            ;����6�ַ�
BIN_BUF1 DW ?                               ;����һ����ת��Ϊ�����ƺ󣬷��ڴ˴�
OUTPUT_MESSAGE  DB   0AH , 'THE SUM IS:' , '$'
OUT_ASC_SUM DB 6 DUP(?) , '$'       ;���������ĺ�ת��ΪASCII��󣬷��ڴ˴���
                                                                 ;�Թ�9�ŵ�����ʾ
DATA ENDS

CODE   SEGMENT
             ASSUME  CS:CODE ,  DS:DATA
START:
              MOV AX , DATA
              MOV DS , AX
              MOV DX , OFFSET INPUT_MESSAGE 
              MOV AH , 9
              INT 21H                                    ;��ʾ����һ����
              MOV DX , OFFSET IN_ASC_BUF 
              MOV AH , 10
              INT 21H                                    ;��ȡ��һ����
              CALL ASC_TO_BIN               ;ת����һ����Ϊ������
              MOV BIN_BUF1 , AX             ;�����һ����
              MOV DX , OFFSET INPUT_MESSAGE 
              MOV AH , 9
              INT 21H                                    ;��ʾ����һ����
              MOV DX , OFFSET IN_ASC_BUF 
              MOV AH , 10
              INT 21H                                    ;��ȡ�ڶ�����
              CALL ASC_TO_BIN               ; ת���ڶ�����Ϊ������
              ADD AX ,  BIN_BUF1            ;�����������֮��
              CALL BIN_TO_ASCII            ;����ת��ΪASCII�룬�Թ���ʾ��
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
