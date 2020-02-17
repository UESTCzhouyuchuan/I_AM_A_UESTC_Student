PUBLIC  GENSOUND
CODE    SEGMENT PARA 'CODE'
           ASSUME CS: CODE
GENSOUND   PROC  FAR
           PUSH  AX
           PUSH  BX
           PUSH  CX
           PUSH  DX
           PUSH  DI
           MOV   AL, 0B6H
           OUT   43H, AL
           MOV   DX, 12H
           MOV   AX, 533H*896
           DIV   DI
           OUT   42H, AL
           MOV   AL, AH
           OUT   42H, AL
           IN    AL, 61H
           OR    AL,  3
           OUT   61H,  AL
WAIT1:     MOV   CX, 8FF0H
DELAY:     LOOP  DELAY
           DEC   BX
           JNZ   WAIT1
           MOV   AL, AH
           OUT   61H, AL
           POP   DI
           POP   DX
           POP   CX
           POP   BX
           POP   AX
           RET
GENSOUND   ENDP
CODE       ENDS
           END
