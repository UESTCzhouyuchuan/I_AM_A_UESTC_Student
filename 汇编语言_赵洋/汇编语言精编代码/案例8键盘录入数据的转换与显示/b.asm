;ģ��B��
PUBLIC  ASC_TO_BIN ,  BIN_TO_ASCII
DATA   SEGMENT   COMMON
INPUT_MESSAGE      DB  0AH , 'PLEASE INPUT A NUMBER(LESS THAN 5 FIGURES):$'
IN_ASC_BUF              DB 6                 ;ʮ�����������뻺���������ɽ���6���ַ�
                                      DB ?                 ;����������10�ŵ���ʱDOS����ʵ�������ַ�����
                                      DB 6 DUP(?)   ;һ������λ����λ����ASCII�룬����һ���س�����
                                                                ;����6�ַ�
BIN_BUF1                   DW ?                ;����һ����ת��Ϊ�����ƺ󣬷��ڴ˴�
OUTPUT_MESSAGE  DB 0AH , 'THE SUM IS:' , '$'
OUT_ASC_SUM         DB 6 DUP(?) , '$'       ;���������ĺ�ת��ΪASCII��󣬷��ڴ˴���
                                                                         ;�Թ�9�ŵ�����ʾ
DATA ENDS
CSEG   SEGMENT
             ASSUME CS:CSEG ,  DS:DATA
ASC_TO_BIN PROC  FAR
;ASCII��ת��Ϊ��������
;��ڣ�ʮ��������ASCII����IN_ASC_BUF��
;���ڣ�ת����Ķ���������AX��
;�㷨���Ƚ���ת����ʮ�������֣������ۼӺͳ�10��X�ķ�����ɶ����������罫
;358ת��Ϊ�������������Ƚ��ۼӺ͸�0���ټ���(((0*10+3)*10+5)*10+8)�����Ϊ��
;�����������ɷ���λ�����Ƿ���Ҫ�󲹡�
             MOV CL ,  IN_ASC_BUF+1         ;ȡ�ַ�����
             MOV CH , 0
             DEC CL                                          ;�۳�����λ
             MOV BX , OFFSET IN_ASC_BUF+3      ;����BXָ��ʮ�����������λ
             PUSH BX
             PUSH CX
L1:
             MOV AL , [BX]
             AND AL , 0FH
             MOV [BX] , AL
             INC BX
             LOOP L1                                        ;�����������ַ��ĸ���λ��0��ʹ֮��Ϊ����ֵ
             POP CX
             POP BX
             MOV AX , 0                                   ;�ۼӺ͸���ֵ
             MOV SI , 10
L2:
             MUL SI
             ADD AL , [BX]
             ADC AH , 0
             INC BX
             LOOP L2                                        ;�ۼӳ�10
            CMP IN_ASC_BUF+2 , '+'
             JZ L3                                               ;���������ţ�ת��
             NEG AX                                         ;�����Ǹ��ţ���
L3:
             RET
ASC_TO_BIN ENDP

BIN_TO_ASCII PROC  FAR
;����������ת��Ϊ��Ӧʮ���������ֵ�ASCII��
;��ڣ�����������AX��
;���ڣ�ת�����ASCII����OUT_ASC_SUM������
;�㷨��AX�е�����Χ��+32767��-32768֮�䣬�ȼ��AX�еķ���λ���Ծ��������+��
;���ǡ�-�������Ǹ�����Ӧ���󲹣��õ�ԭ��󼴿���������ͳһ����ת������Ϊ����ת����
;���������ȳ���10000����;��Ϊ��λ�����ٽ���������1000����Ϊǧλ�����Դ����ƣ����
;�١�ʮλ����ʣ�µ�Ϊ��λ������󣬽�����������30H������Ϊ��Ӧ�ַ���
            MOV OUT_ASC_SUM , '+'
            CMP AX , 0
            JGE L4                                             ;���Ǹ�����ת��
            NEG AX
           MOV OUT_ASC_SUM , '-'
L4:
           CWD
            MOV BX , 10000
            DIV BX
           ADD AL , 30H                                 ; ����λת��Ϊ����(��Ӧ��AX�ڣ�����Ϊ�̲�����3��
                                                                     ;������Ч������AL��) 
            MOV OUT_ASC_SUM+1 , AL     ;������λ����
            MOV AX , DX                                ;����������AX�ڣ��Ա㵱��������
            CWD
            MOV BX , 1000
            DIV BX
            ADD AL , 30H
            MOV OUT_ASC_SUM+2 , AL     ;����ǧλ����
            MOV AX , DX                                ;����������AX�ڣ��Ա㵱��������
            MOV BL , 100
           DIV BL
            ADD AL , 30H
            MOV OUT_ASC_SUM+3 , AL     ;�����λ����
            MOV AL , AH
           CBW
           MOV BL , 10
           DIV BL
            ADD AL , 30H
           MOV OUT_ASC_SUM+4 , AL      ;����ʮλ����
            ADD AH , 30H
            MOV OUT_ASC_SUM+5 , AH     ;�����λ����
            RET
BIN_TO_ASCII   ENDP
CSEG  ENDS
            END 
