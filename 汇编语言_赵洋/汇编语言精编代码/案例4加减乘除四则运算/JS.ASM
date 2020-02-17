B_P     EQU BYTE PTR
W_P     EQU WORD PTR
D_P     EQU DWORD PTR
CODE    SEGMENT
ASSUME  CS:CODE,DS:CODE
        ORG 100H
;主程序开始
NEWSTAR:
        JMP STAR
        EVEN
NUM1    DW 0,0
NUM2    DW 0,0
NUM3    DW 0,0
JGV4    DW 0,0
YSF     LABEL WORD
YSF1    DB 0
YSF2    DB 0
JUV     DB 0
UV      DB 0
;使DS:SI指向第一有效字符
OVERS   LABEL NEAR
        CLD
        PUSH AX
OVERS1:
        LODSB
        CMP AL,' '
        JZ OVERS1
        CMP AL,9
        JZ OVERS1
        DEC SI
        CMP AL,13
        POP AX
        RET
;输出一个制表符
TAB     LABEL NEAR
        MOV AL,9
        JMP SHORT DISP
;输出一个回车换行符
CRLF    LABEL NEAR
        MOV AL,13
        CALL DISP
        MOV AL,10
;显示一个字符
DISP    LABEL NEAR
        PUSH AX
        PUSH DX
        MOV AH,2
        MOV DL,AL
        INT 21H
        POP DX
        POP AX
        RET
;检查是否为运算符
ISYSF   LABEL NEAR
        CLD
        LODSB
        CALL ISJJ
        JZ ISYSF1
        CALL ISII
        JZ ISYSF1
        DEC SI
ISYSF1:
        RET
;检查是否是加减运算
ISJJ    LABEL NEAR
        CMP AL,'+'
        JZ ISYSF1
        CMP AL,'-'
        RET
;检查是否为乘除运算
ISII    LABEL NEAR
        CMP AL,'*'
        JZ ISYSF1
        CMP AL,'/'
        JZ ISYSF1
        CMP AL,'\'
        RET
;数据输出
;CX=10 十进制
;CX=16 十六进制
DOUT    LABEL NEAR
        PUSH AX
        PUSH BX
        PUSH DX
        PUSH BP
        XOR BP,BP
DOUT1:
        INC BP
        PUSH AX
        MOV AX,DX
        XOR DX,DX
        DIV CX
        MOV BX,AX
        POP AX
        DIV CX
        PUSH DX
        MOV DX,BX
        OR BX,AX
        JNZ DOUT1
DOUT2:
        POP AX
        ADD AL,'0'
        CMP AL,'9'
        JBE DOUT3
        ADD AL,'A'-'9'-1
DOUT3:
        CALL DISP
        DEC BP
        JNZ DOUT2
        POP BP
        POP DX
        POP BX
        POP AX
        RET
;输入数据在DX:AX中返回
;CX=0 数据为10进制
;CX#0 数据为16进制
DATE    LABEL NEAR
        PUSH BX
        PUSH BP
        PUSH DI
        XOR AX,AX
        XOR DX,DX
DATE1:
        MOV DI,AX
        LODSB
        CMP AL,'0'
        JB DATE7
        CMP AL,'9'
        JA DATE6
DATE2:
        AND AX,0FH
        SHL DI,1
        RCL DX,1
        MOV BX,DI
        MOV BP,DX
        SHL DI,1
        RCL DX,1
        SHL DI,1
        RCL DX,1
        JCXZ DATE3
        SHL DI,1
        RCL DX,1
        Jmp short DATE4
DATE3:
        ADD DI,BX
        ADC DX,BP
DATE4:
        ADD AX,DI
        ADC DX,0
        JMP DATE1
DATE5:
        ADD AL,9
        JMP DATE2
DATE6:
        JCXZ DATE7
        CMP AL,'A'
        JB DATE7
        CMP AL,'F'
        JBE DATE5
        CMP AL,'a'
        JB DATE7
        CMP AL,'f'
        JBE DATE5
DATE7:
        MOV AX,DI
        DEC SI
        OR DI,DX
        POP DI
        POP BP
        POP BX
        RET
;数据1与数据2根据YSF1进行加减运算
JSJJ    LABEL NEAR
        MOV AX,NUM2
        MOV DX,NUM2+2
        CMP YSF1,'+'
        JZ JSJJ1
        SUB NUM1,AX
        SBB NUM1+2,DX
        JMP SHORT JSJJ2
JSJJ1:
        ADD NUM1,AX
        ADC NUM1+2,DX
JSJJ2:
        RET
;数据1与数据2根据YSF1进行乘除运算
JSII1   LABEL NEAR
        MOV BX,OFFSET NUM1
        JMP SHORT JSII2_1
;数据2与数据3根据YSF2进行乘除运算
JSII2   LABEL NEAR
        MOV BX,OFFSET NUM2
JSII2_1:
        DB 66H
        MOV AX,[BX]
        DB 66H
        MOV CX,[BX+4]
        CMP YSF2,'*'
        JNZ JSII2_2
        DB 66H
        IMUL CX
        JMP SHORT JSII2_3
JSII2_2:
        DB 66H
        CWD
        DB 66H
        IDIV CX
        CMP YSF2,'/'
        JZ JSII2_3
        DB 66H
        XCHG DX,AX
JSII2_3:
        DB 66H
        MOV [BX],AX
        RET
;显示结果
XUJG    LABEL NEAR
        MOV AX,JGV4
        MOV DX,JGV4+2
        MOV CX,10
        CMP UV,10
        JZ XUJG0
        MOV CX,16
XUJG0:
        TEST DX,8000H
        JZ XUJG1
        CMP UV,10
        JZ XUJG2
        CALL DOUT
XUJG2:
        NOT AX
        NOT DX
        ADD AX,1
        ADC DX,0
        PUSH AX
        CMP UV,10
        JZ XUJG3
        MOV AL,' '
        CALL DISP
        MOV AL,'('
        CALL DISP
XUJG3:
        MOV AL,'-'
        CALL DISP
        POP AX
        CMP UV,10
        JZ XUJG1
        CALL DOUT
        MOV AL,')'
        CALL DISP
        RET
XUJG1:
        CALL DOUT
        RET
;计算结果放入DX:AX中
JSJG    LABEL NEAR
        CALL JSJJ
        MOV AX,NUM1
        MOV DX,NUM1+2
        RET
;从DS:SI处取一个数据
LOADATE LABEL NEAR
        LODSB
        CMP AL,'('
        JZ LOADATE1
        DEC SI
        PUSH CX
        XOR CX,CX
        CMP UV,10
        JZ LOADATE0
        INC CX          ;取16进制数
LOADATE0:
        CALL DATE       ;取数据放入DX:AX中
        POP CX
        RET
LOADATE1:
        PUSH NUM1       ;保存数据1数据2及运算符
        PUSH NUM1+2
        PUSH NUM2
        PUSH NUM2+2
        PUSH YSF
        INC JUV
        MOV JGV4,0      ;结果值清零
        MOV JGV4+2,0
;进行四则运算
SZYS    LABEL NEAR
        CALL ISYSF      ;首字符是运算符？
        JZ SZYS2
        CALL LOADATE    ;不是，取数并保存
        MOV NUM1,AX
        MOV NUM1+2,DX
SZYS1:
        XOR AX,AX       ;数据2清零
        MOV NUM2,AX
        MOV NUM2+2,AX
        CALL ISYSF      ;下个是运算符？
        JZ SZYS3
        JNZ SZYS6
SZYS2:
        PUSH AX
        MOV AX,JGV4     ;将结果作为数据1
        MOV NUM1,AX
        MOV AX,JGV4+2
        MOV NUM1+2,AX
        POP AX
SZYS3:
        MOV YSF1,AL
        MOV YSF2,AL
        CALL ISJJ       ;是加减运算转
        JZ SZYS4
        CALL LOADATE    ;取数据2
        MOV NUM2,AX
        MOV NUM2+2,DX
        CALL JSII1      ;数据1与数据2根据YSF1进行乘除运算
        JMP SZYS1       ;    结果保存在数据1中
SZYS4:
        CALL LOADATE    ;取数据2并保存
        MOV NUM2,AX
        MOV NUM2+2,DX
SZYS4_1:
        CALL ISYSF
        JNZ SZYS6
        CALL ISJJ       ;运算符2是加减运算？
        JNZ SZYS5       ;不是转
        PUSH AX
        CALL JSJJ       ;数据1与数据2根据YSF1进行加减运算
        POP AX          ;    结果保存在数据1中
        MOV YSF1,AL     ;保存新的运算符
        JMP SZYS4
SZYS5:
        MOV YSF2,AL     ;保存运算符2
        CALL LOADATE    ;取数据3
        MOV NUM3,AX
        MOV NUM3+2,DX
        CALL JSII2      ;数据2与数据3根据YSF2进行乘除运算
        JMP SZYS4_1     ;    结果保存在数据2中
SZYS6:
        MOV CL,AL
        CMP AL,13
        JNZ SZYS9
SZYS7:
        CALL JSJG
        CMP JUV,0
        JZ SZYS8
        DEC JUV
        POP YSF
        POP NUM2+2
        POP NUM2
        POP NUM1+2
        POP NUM1
        RET
SZYS8:
        CMP CL,')'
        JZ SZYS10
        MOV JGV4,AX
        MOV JGV4+2,DX
        JNZ SZYS12
SZYS9:
        CMP AL,')'
        JNZ SZYS11
        INC SI
        JMP SZYS7
SZYS10:
        MOV NUM1,AX
        MOV NUM1+2,DX
        JMP SZYS1
SZYS11:
        STC
        RET
SZYS12:
        CLC
        RET
;数制处理
UVIL    LABEL NEAR
        PUSH SI
UVIL1:
        LODSB
        CMP AL,' '
        JZ UVIL2
        CMP AL,9
        JZ UVIL2
        CMP AL,13
        JZ UVIL4
        JNZ UVIL1
UVIL2:
        MOV BX,SI
        CALL OVERS
        JZ UVIL3
        LODSW
        CALL OVERS
        POP SI
        JNZ SZYS11
        CMP AX,'01'
        JNZ SZYS11
        PUSH SI
        MOV UV,10
UVIL3:
        MOV AL,13
        MOV [BX-1],AL
UVIL4:
        POP SI
        CLC
        RET
;预置结果
YVJG    LABEL NEAR
        MOV AH,52H
        INT 21H
        MOV AX,ES:[BX-2]
        MOV DS,AX
        MOV AX,DS:[0CH]
        MOV CS:JGV4,AX
        MOV AX,DS:[0EH]
        MOV CS:JGV4+2,AX
        PUSH CS
        POP DS
        PUSH CS
        POP ES
        RET
;保存结果
BCJG    LABEL NEAR
        MOV AH,52H
        INT 21H
        MOV AX,ES:[BX-2]
        MOV DS,AX
        MOV AX,CS:JGV4
        MOV DS:[0CH],AX
        MOV AX,CS:JGV4+2
        MOV DS:[0EH],AX
        PUSH CS
        POP DS
        PUSH CS
        POP ES
        RET
STAR:
        MOV SI,81H
        CLD
        CALL OVERS
        JNZ STAR1
STAR0:
        MOV DX,OFFSET MESS1
        JMP STAR4
STAR1:
        CALL YVJG
        CALL UVIL
        JB STAR0
        MOV SAVESP,SP
        CALL SZYS
        MOV SP,SAVESP
        MOV DX,OFFSET MESS2
        JB STAR4
        CALL CRLF
        CALL XUJG
        CALL BCJG
        MOV DX,OFFSET MESS3
STAR4:
        MOV AH,9
        INT 21H
        INT 20H
SAVESP  DW 0
MESS1   DB 13,10,'  Syntax:',13,10
        DB '     JS  <Expression>  [10]',13,10,'$'
MESS2   DB 'Error in expression !$'
MESS3   DB 13,10,'$'
CODE    ENDS
        END NEWSTAR
