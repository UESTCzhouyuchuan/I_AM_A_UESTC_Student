DATA   SEGMENT
LINE   DW   0                     ;���ο����Ͻǵ���
ROW    DW   0                     ;���ο����Ͻǵ���
PIX    DB   0                    ;���ο����ɫ
DATA   ENDS

CODE         SEGMENT
             ASSUME  CS:CODE,DS:DATA
START:                               ;������
             MOV AX , DATA
             MOV DS , AX
             MOV AH , 0
             MOV AL , 4
             INT 10H                 ;����320��200��ɫͼ�η�ʽ
             
             mov ah,0bh
             mov bh,01
             mov bl,0
             int 10h
             MOV CX, 4
L1:
             CALL DISP_RECT
             call delay
             inc PIX                 ;ÿѭ��һ�Σ������ɫ��1
             ADD ROW , 30            ;�ı���һ���������ʾλ��
             LOOP L1
             MOV AH , 4CH
             INT 21H                 ;����DOS
;��ʾ���ο���ӳ��򣬾��ο����ʾλ����DATA���е�LINE��ROW����ָ����
;��ɫ��PIX����ָ�������ο�Ĵ�С�ǹ̶��ģ�Ϊ10�����100����ߡ�
DISP_RECT    PROC  near
             PUSH AX
             PUSH CX
             PUSH DX
             PUSH SI
             PUSH DI
             MOV AH , 0CH       ;ָ��д�����
             MOV AL , PIX       ;ȡ�����ɫ
             MOV DI , 100       ;���ڿ�������ʾѭ��
             MOV DX , LINE      ;ȡ���������
DISP_2: 
             MOV SI , 10        ;��������ʾѭ��
             MOV CX , ROW       ;ȡ��ʾ���������
DISP_1: 
             INT 10H            ;��ɵ����ʾ
             INC CX             ;�������1���в��䣩
             DEC SI
             JNZ DISP_1         ;ѭ����ʾ��һ�е�10����
             INC DX             ;�������1
             DEC DI
             JNZ DISP_2         ;ѭ����ʾ��100��
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
