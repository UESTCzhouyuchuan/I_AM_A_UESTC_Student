            EXTRN GENSOUND:FAR
PUBLIC   MUSIC
STACK    SEGMENT PARA STACK 'STACK'
         DB 64 DUP ('STACK')
STACK    ENDS
DATA     SEGMENT PARA 'DATA'
MUS_FREQ DW  330, 294, 262, 294, 3 DUP (330)
         DW  3 DUP (294), 330,392,392
         DW  330, 294, 262, 294, 4 DUP (330)
         DW  293, 294, 330, 294, 262,-1
MUS_TIME DW  6 DUP (25*8), 50*8
         DW  2 DUP (25*8, 25*8, 50*8)
         DW  12 DUP (25*8), 100*8
DATA     ENDS
CODE     SEGMENT PARA 'CODE'
         ASSUME CS: CODE, SS: STACK
         ASSUME DS: DATA
MUSIC    PROC  FAR
         PUSH  DS
         PUSH  DX
         PUSH  CX
         PUSH  BX
         PUSH  AX
         MOV   AX, DATA
         MOV   DS, AX
         LEA   SI, MUS_FREQ
         LEA   BP, DS: MUS_TIME
FREQ:    MOV   DI, [SI]
         CMP   DI, -1
         JE    END_MUS
         MOV   BX, DS: [BP]
         CALL  GENSOUND
         ADD   SI, 2
         ADD   BP, 2
         JMP   FREQ
END_MUS:
         POP AX
         POP BX
         POP CX
         POP DX
         POP DS
         RET
MUSIC    ENDP
CODE     ENDS
         END 

