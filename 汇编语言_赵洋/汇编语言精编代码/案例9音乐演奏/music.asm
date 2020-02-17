DATA      SEGMENT PARA 'DATA'
INFO1     DB 0DH,0AH,'WELCOME YOU TO COME HERE!$'
INFO2     DB 0DH,0AH,'this is a music program!$'
INFO3     DB 0DH,0AH,'please select!$'
INFO4     DB 0DH,0AH,'INPUT ERROR!$'
INFO5     DB 0DH,0AH,'PLEASE INPUT AGAIN!$'
MUSLIST   DB 0DH,0AH,'A MUSIC1'
          DB 0DH,0AH,'B MUSIC2'
          DB 0DH,0AH,'C MUSIC3'
          DB 0DH,0AH,'Q EXIT'
          db 0dh,0ah,'$'
MUS_FREG1 DW 330,294,262,294,3 DUP (330)
          DW 3 DUP (294),330,392,392
          DW 330,294,262,294,4 DUP (330)
          DW 294,294,330,294,262,-1
MUS_TIME1 DW 6 DUP (25*8),50*8
          DW 2 DUP (25*8,25*8,50*8)
          DW 12 DUP (25*8),100*8

MUS_FREG2 DW 330,392,330,294,330,392,330,294,330
          DW 330,392,330,294,262,294,330,392,294
          DW 262,262,220,196,196,220,262,294,332,262,-1
MUS_TIME2 DW 3 DUP(50),25,25,50,25,25,100
          DW 2 DUP(50,50,25,25),100
          DW 3 DUP(50,25,25),100

MUS_FREG3 DW 262,262,294,262,349
          DW 330,262,262,294,262
          DW 392,349,262,262,523
          DW 440,349,262,262,466
          DW 466,440,262,392,349,-1
        
MUS_TIME3 DW 50,50,100,100,100
          DW 100,100,50,50,100,100
          DW 100,100,100,50,50,100
          DW 100,100,100,100,100,50
          DW 50,100,100,100,100,100
DATA      ENDS

STACK     SEGMENT PARA STACK 'STACK'
          DB 200 DUP ('STACK')
STACK     ENDS

CODE      SEGMENT
          ASSUME DS:DATA,SS:STACK,CS:CODE
MAIN      PROC FAR
          MOV AX,DATA
          MOV DS,AX
          MOV aH, 0
          MOV AL,4
          INT 10H
          MOV AH,0BH
          MOV BH,0
          MOV BL,4
          INT 10H
          MOV AH,0BH
          MOV BH,01H
          MOV BL,00
          INT 10H
;*****定义一个宏*****
SHOW      MACRO b
          LEA DX,b
          MOV AH,9
          INT 21H
          ENDM
;**********************
          show INFO1
          show INFO2
          show INFO3
          show MUSLIST
INPUT:    MOV AH,01H
          INT 21H
          CMP AL,'Q'
          JZ retu
          CMP AL,'A'
          JNZ B0
          CALL MUSIC1
          JMP EXIT1
B0:       CMP AL,'B'
          JNZ C0
          CALL MUSIC2
          JMP EXIT1
C0:       CMP AL,'C'
          JNZ exit
          CALL MUSIC3
EXIT1:    show INFO5
          JMP INPUT 
EXIT:     
          call clear
          show INFO4
          show INFO5
          show INFO1
          show INFO2
          show INFO3
          show MUSLIST
          jmp input
RETU:     MOV AH,4CH
          INT 21H
MAIN ENDP 

MUSIC1    PROC NEAR
          PUSH DS
          SUB AX,AX
          PUSH AX
          LEA SI,MUS_FREG1
          LEA BP,DS:MUS_TIME1
FREG1:     MOV DI,[SI]
          CMP DI,-1
          JE END_MUS1
          MOV DX,DS:[BP]
          MOV BX,1400
          CALL GENSOUND
          ADD SI,2
          ADD BP,2
          JMP FREG1
END_MUS1:
          RET
MUSIC1    ENDP

GENSOUND PROC NEAR
          PUSH AX
          PUSH BX
          PUSH CX
          PUSH DX
          PUSH DI
          MOV AL,0B6H
          OUT 43H,AL
          MOV DX,12H
          MOV AX,533H*896
          DIV DI
          OUT 42H,AL
          MOV AL,AH
          OUT 42H,AL
          IN AL,61H
          MOV AH,AL
          OR AL,3
          OUT 61H,AL

WAIT1:    MOV CX,8FF0H
DELAY1:   LOOP DELAY1
          DEC BX
          JNZ WAIT1
          MOV AL,AH
          OUT 61H,AL
          POP DI
          POP DX
          POP CX
          POP BX
          POP AX
          RET
GENSOUND ENDP

MUSIC2    PROC NEAR
          PUSH DS
          SUB AX,AX
          PUSH AX
          LEA SI,MUS_FREG2
          LEA BP,DS:MUS_TIME2
FREG2:    MOV DI,[SI]
          CMP DI,-1
          JE END_MUS2
          MOV DX,DS:[BP]
          MOV BX,1400
          CALL GENSOUND
          ADD SI,2
          ADD BP,2
          JMP FREG1
END_MUS2:
          RET
MUSIC2    ENDP
MUSIC3    PROC NEAR
          PUSH DS
          SUB AX,AX
          PUSH AX
          LEA SI,MUS_FREG3
          LEA BP,DS:MUS_TIME3
FREG3:    MOV DI,[SI]
          CMP DI,-1
          JE END_MUS3
          MOV DX,DS:[BP]
          MOV BX,1400
          CALL GENSOUND
          ADD SI,2
          ADD BP,2
          JMP FREG1
END_MUS3:
          RET
MUSIC3    ENDP
clear proc near
      push ax
      push bx
      push cx
      push dx
      mov  ah,6
      mov al,0
      mov ch,0
      mov cl,0
      mov dh,24
      mov dl,79
      mov bh,7
      int 10h
      pop dx
      pop cx
      pop bx
      pop ax
      ret
clear endp
CODE      ENDS
          END MAIN

