DATA SEGMENT 
     CC DB '+'
     ww db '-'
     GG DB '='
     II DB 0DH,0AH,'$'
     AA DB 5 DUP(?)
     www dw 0
     ghh db '0',0dh,0ah,'$'
     bnm dw 0
DATA ENDS

STACK SEGMENT
    DB  200  DUP(0)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK

START: MOV AX,DATA
       MOV DS,AX
       MOV CX,20
       CALL RAND            ;����һ�����
       CALL MCAT            ;�������ת��Ϊ16���Ʊ�ʾ��ASCII���ַ�
       MOV  AX,BX
       PUSH AX
       CMP  www,0           ;WWW=0?
       JE  A1               ;ִ��'+'
       CMP  www,1           ;www=1?
       JE  A2               ;ִ��'-' 
  A1:  MOV DL,CC            ;��ʾ'+'
       MOV AH,2
       INT 21H
       CALL RAND            ;������һ�����
       add bx,0fh
       CALL MCAT            ;�������ת��Ϊ16���Ʊ�ʾ��ASCII���ַ�
       MOV DL,GG            ;��ʾ'='
       MOV AH,2
       INT 21H
       POP AX
       ADD AX,BX
       cmp ax,0
       jne  yjw1
       lea dx,ghh
       mov ah,9
       int 21h
       jmp qq1
 yjw1: JMP B1
   A2: MOV DL,WW             ;��ʾ'-'
       MOV AH,2
       INT 21H
       mov cx,65535
 mai1: loop mai1
       CALL RAND1 
       CALL MCAT
       MOV DL,GG
       MOV AH,2
       INT 21H
       POP AX
       Sbb AX,BX
       cmp ax,0
       jne  yjw2
       lea dx,ghh
       mov ah,9
       int 21h
       jmp qq1    
 yjw2: JMP B1
   B1: MOV  BX,AX
       CALL MCAT
       lea  DX,II
       MOV  AH,9
       INT  21H
  QQ1: MOV  AH,4CH
       INT  21H

MCAT PROC                 ;�������ת��Ϊ16���Ʊ�ʾ��ASCII���ַ��ӳ���
     PUSH AX
     push bx
     PUSH CX
     PUSH DX
     CMP BX,9
     JA S1
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     mov ax,bx
     mov bl,5
     div bl
     cmp ah,3
     jae vb1
     mov www,1
     jmp vn1
 vb1:mov www,0
 vn1:pop dx
     pop cx
     pop bx
     pop ax
     ADD BL,30H
     MOV AA,BL
     MOV AA+1,'$'
     LEA DX,AA
     MOV AH,9
     INT 21H
     JMP s3
  s1:MOV CL,4
     MOV AL,0
     PUSH BX
     SHL BX,CL
     CMP BH,9
     JBE V1
     SUB BH,9
     ADD BH,40H
     JMP MM1
  V1:ADD BH,30H
 MM1:MOV AA,BH
     POP BX
     AND BL,0FH
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     mov ax,bx
     mov bl,5
     div bl
     cmp ah,3
     jae vb2
     mov www,1
     jmp vn2
 vb2:mov www,0
 vn2:pop dx
     pop cx
     pop bx
     pop ax
     CMP BL,9
     JBE TT1
     SUB BL,9
     ADD BL,40H
     JMP RR1
TT1: ADD BL,30H
RR1: MOV AA+1,BL
     MOV AA+2,'$'
     LEA DX,AA
     MOV AH,9
     INT 21H
  s3:POP DX
     POP CX
     POP BX
     POP AX
     RET
MCAT  ENDP

RAND  PROC
      PUSH CX
      PUSH DX
      PUSH AX
      STI
      MOV AH,0             ;��ʱ�Ӽ�����ֵ
      INT 1AH
      MOV AX,DX            ;���6λ
      AND AH,3
      MOV DL,101           ;��101������0~100����
      DIV DL
      MOV BL,AH            ;������BX���������
      POP AX
      POP DX
      POP CX
      RET
RAND  ENDP

RAND1 PROC
      PUSH CX
      PUSH DX
      PUSH AX
      STI
      MOV AH,0
      INT 1AH
      MOV ax,cx
      AND AH,3
      MOV DL,101
      DIV DL
      MOV BL,AH
      POP AX
      POP DX
      POP CX
      RET
RAND1  ENDP

CODE   ENDS
       END  START  
       

         

