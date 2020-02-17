cursor  equ     45H
attrib  equ     2fh
code    segment
        assume cs:code,ds:code
start:  
        jmp     go
oldcur  dw      ?
OLD1C   DW      2 DUP(?)
NEWINT1C:
        PUSHF
        CALL DWORD PTR CS:OLD1C        
        push    ax
        PUSH    BX
        PUSH    CX
        PUSH    DX                     
        XOR     BH,BH
        MOV     AH,3
        INT     10H                              
        MOV     CS:OLDCUR,DX
        MOV     AH,2
        xor     bh,bh
        MOV     DX,CURSOR
        INT     10H
        MOV     AH,2　　　　　；读取系统时钟
        INT     1AH             
        PUSH    DX              
        PUSH    CX
        POP     BX
        PUSH    BX
        CALL    SHOWBYTE
        CALL    SHOWCOLON
        POP     BX
        XCHG    BH,BL
        CALL    SHOWBYTE
        CALL    SHOWCOLON
        POP     BX
        CALL    SHOWBYTE
        MOV     DX,CS:OLDCUR
        MOV     AH,2
        XOR     BH,BH
        INT     10H
        POP     DX
        POP     CX
        POP     BX
        POP     AX
        IRET
SHOWBYTE PROC NEAR
        PUSH    BX
        MOV     CL,4
        MOV     AL,BH
        SHR     AL,CL
        ADD     AL,30H
        CALL    SHOW
        CALL    CURMOVE
        POP     BX
        MOV     AL,BH
        AND     AL,0FH
        ADD     AL,30H
        CALL    SHOW
        CALL    CURMOVE
        RET
SHOWBYTE ENDP

SHOWCOLON PROC NEAR
        MOV     AL,':'
        CALL    SHOW
        CALL    CURMOVE
        RET
SHOWCOLON ENDP

CURMOVE PROC NEAR
        PUSH    AX
        PUSH    BX
        PUSH    CX
        PUSH    DX
        MOV     AH,3
        MOV     BH,0
        INT     10H
        INC     DL
        MOV     AH,2
        INT     10H
        POP     DX
        POP     CX
        POP     BX
        POP     AX
        RET
CURMOVE ENDP

SHOW    PROC NEAR
        PUSH    AX
        PUSH    BX
        PUSH    CX
        MOV     AH,09H
        MOV     BX,attrib
        MOV     CX,1
        INT     10H
        POP     CX
        POP     BX
        POP     AX
        RET
SHOW    ENDP

GO:
        PUSH    CS
        POP     DS
        MOV     AX,351CH           ;取中断向量
        INT     21H
        MOV     OLD1C,BX　　　　　　；保存原中断向量
        MOV     BX,ES
        MOV     OLD1C+2,BX
        MOV     DX,OFFSET NEWINT1C　；置新的中断向量
        MOV     AX,251CH
        INT     21H
        MOV     DX,OFFSET GO
        SUB     DX,OFFSET START
        MOV     CL,4
        SHR     DX,CL
        ADD     DX,11H
        MOV     AX,3100H　　　　　　　；结束并驻留
        INT     21H
CODE ENDS
        END START

