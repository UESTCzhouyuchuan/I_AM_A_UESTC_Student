extrn music:far,gensound:far
;******************************************************
;* 堆栈段 
.286;******************************************************
STACK_SEG     SEGMENT   STACK
    STACK_BUF DW        120 DUP(?)
    TOP       EQU       $-STACK_BUF
STACK_SEG     ENDS
;******************************************************
;* 数据段 
;******************************************************
DATA_SEG      SEGMENT   PARA
;------------------------------------------------------
; TODO: 数据的定义及存储器的分配
ts1           DB        0
quitbuf       DB        'welcome you to run this programme.                                       '        
quitbuf2      DB        'C: change color;  B:extend the colck;  S:reduce the clock                '   
quitbuf3      DB        'press e to sound; Press q to quit !                                      '   
sigle         DB        80h                         
absx          DW        0  
absy          DW        0               
sut           DW        0
erroybz       DB        0  
r0            DW        90
x0            DW        320
y0            DW        245                                                                                                                                                                          

count0        db    0               
count_hour    DB        11              
count_minute  DB        11
yuanxinx      DW        0
yuanxiny      DW        0                           
             
s             DB        0
s2            DB        0              
s3            DB        0
hour          DW        0
hour2         DW        0              
minute        DW        0
minute2       DW        0              
second        DB        0 
second2       DB        0                                                       
sin_x         DW        0
sin_xx        DW        0 
x             DW        0
y             DW        0
x1            DW        0
              
xminy         DW        0
yminx         DW        0              
xmax          DW        0  
ymax          DW        0   
ymin          DW        0
xmin          DW        0  
sjx_xminy     DW        0
sjx_yminx     DW        0              
sjx_xmax      DW        0  
sjx_ymax      DW        0   
sjx_ymin      DW        0
sjx_xmin      DW        0     
yuanx         DW        0
yuany         DW        0                                                                                                                                                                     
y1            DW        0
x2            DW        0
y2            DW        0
x3            DW        0
y3            DW        0     
DIancolor     DB        0                                     
color         DB        2
color_hour    DB        2
color_min     DB        6
color_second  DB        9  
color4        DB        10
color5        DB        11
color6        DB        12 
backgroundcolor DB      1              
page1         DB        0
y2y1          DW        0    
x2x1          DW        0 
sjx_y2y1      DW        0    
sjx_x2x1      DW        0                                                                                         
                                                       
;------------------------------------------------------

DATA_SEG      ENDS
;******************************************************
;* 代码段 
;******************************************************
CODE_SEG      SEGMENT   PARA
;------------------------------------------------------
MAIN          PROC      FAR
              ASSUME    CS:CODE_SEG,DS:DATA_SEG
              ASSUME    SS:STACK_SEG
START:
              MOV       AX,STACK_SEG
              MOV       SS,AX
              MOV       SP,TOP
              MOV       AX,DATA_SEG
              MOV       DS,AX
;------------------------------------------------------
; TODO: 从这里开始您的代码
;------------------------------------------------------
 beg:         MOV       AX,0012h
              INT       10h
              MOV       DX,0010h
              CALL      b1002
              LEA       BP,quitbuf
              CALL      msg
              MOV       DX,010ah
              LEA       BP,quitbuf2
              CALL      msg
              MOV       DX,020ah
              LEA       BP,quitbuf3
              CALL      msg
                          
 beg2:        CALL      skin
              CALL      skin2
              CALL      skin3
              CALL      CLk
              MOV       second,DH
              MOV       second2,DH
              MOV       count_minute,11
              CALL      minute_lin
              XOR       DX,DX              
              MOV       AX,minute2
              MOV       CX,12
              DIV       CX
              MOV       CX,AX                 ;minurte2/12
              POP       AX
              ADD       AX,CX
              MOV       hour2,AX
              MOV       count_hour,11            
              CALL      hour_lin              
              CALL      CLk
              MOV       DL,DH
              CALL      bcd2
              XOR       AH,AH
              MOV       CL,12
              DIV       CL
              MOV       count_minute,AH            ;second%12初始值
              DEC       count_minute
              
              XOR       DX,DX
              MOV       AX,minute2
              MOV       CX,12
              DIV       CX                        ;minurte2%12
              MOV        count_hour,DL
              DEC       count_hour
              INC       second2
kk3:          CLI
              CALL      second_lin 
              STI
              JMP       ks
              
              
ks:           MOV       AH,1
              INT       16h
              JZ        kk3
              MOV       AH,8
              INT       21h
              CMP       AL,'q'
              JE        quit
              CMP       AL,'b'
              JE        CHange_rb
              CMP       AL,'s'
              JE        CHange_rs
              CMP       AL,'c'
              JE        CHange_color              
              cmp       al,'e'
              je        a0
              JMP       kk3

CHange_rs:    CMP       r0,190
              JA        ks
              ADD       r0,5
             
              JMP       tobeg2           
CHange_rb:    CMP       r0,60
              JB        ks
              SUB       r0,5
              
              JMP       tobeg2        
CHange_color: LEA       SI,color_hour
              MOV       CX,6
CHange_kk1:   MOV       AL,  [SI]
              INC       AL
              CMP       AL,15
              JC       CHange_color_kk2
              MOV       AL,1
CHange_color_kk2:              
              MOV       [SI],AL
              INC       SI
              LOOP      CHange_kk1
              JMP       tobeg2
a0:           call music
              call music
              call music
tobeg2:       CALL      CLear
              JMP       beg2              
quit:         MOV       AX,4C00H
              INT       21H    
;*************************************              
              
              
hour_lin      PROC      NEAR
              PUSHa
              CMP       count_hour,11
              JB        tohour_yl
              JMP       hour_lin_next
tohour_yl:    MOV       SIgle,3
              JMP       hour_yl
hour_lin_next:   
              MOV       count_hour,0
              MOV       SIgle,5                         
              CALL      CLk
              MOV       DL,CH
              CALL      bcd2
              CMP       AL,12
              JB        hour_kk1
              SUB       AL,12
hour_kk1:     MOV       CL,30
              MUL       CL
              PUSH      AX
              XOR       DX,DX
              MOV       AX,minute2
              MOV       CX,12
              DIV       CX
              MOV       CX,AX       ;minurte2/12
              POP       AX
              ADD       AX,CX
              
              MOV       hour2,AX           
 ;擦掉              
              MOV       Color,0
              MOV       AX,hour
              MOV       BX,r0
              ADD       BX,20
              CALL      renovate
      
              MOV       DX,yuanx
              MOV       x3,DX
              MOV       DX,yuany
              MOV       y3,DX
              ADD       AX,270
              ADD       BX,400              ;90
              
              CALL      renovate  
              
              MOV       DX,yuanx         ;擦掉
              MOV       x2,DX
              MOV       DX,yuany
              MOV       y2,DX  
              
              MOV       DX,x0
              MOV       x1,DX
              MOV       DX,y0   ;擦掉
              MOV       y1,DX
              CALL      sjx  
              
              ADD       AX,180
              CALL      renovate  
              MOV       DX,yuanx         ;擦掉
              MOV       x2,DX
              MOV       DX,yuany
              MOV       y2,DX                
              
              SUB       BX,100    
              CALL      renovate                
              MOV       DX,yuanx
              MOV       x3,DX
              MOV       DX,yuany
              MOV       y3,DX            ;擦掉
              CALL      sjx
            
              MOV       SIgle,4
              
;***************************；;  ;重写       
hour_yl:      MOV       AL,color_hour              
              MOV       color,AL
              MOV       AX,hour2
              MOV       BX,r0
              ADD       BX,70
              CALL      renovate
         
              MOV       DX,yuanx
              MOV       x3,DX
              MOV       DX,yuany
              MOV       y3,DX
              ADD       AX,90
              ADD       BX,600                ;90
              
              CALL      renovate  
              
              MOV       DX,yuanx
              MOV       x2,DX
              MOV       DX,yuany
              MOV       y2,DX             ;重写
              
              ADD       AX,180
               
              CALL      renovate  
              
              MOV       DX,yuanx
              MOV       x1,DX
              MOV       DX,yuany
              MOV       y1,DX
              CALL      sjxx
              CALL      sjxy 
              
              ADD       AX,270
              SUB       BX,100  
              CALL      renovate                  
              MOV       DX,yuanx
              MOV       x3,DX                ;重写
              MOV       DX,yuany
              MOV       y3,DX
              CALL      sjx 
              CALL      sjxx
              CALL      sjxy                                           
              
              MOV       CX,hour2
              MOV       hour,CX
hour_quit:    POPa
              RET
hour_lin      ENDP                                                    
              
;********************************                  
              
              
minute_lin    PROC      NEAR
              PUSHa
              CMP       count_minute,11
              JB        tominute_yl        ;仍是原来的一个   
              JMP       minute_lin_next
tominute_yl:  MOV       SIgle,0
              JMP       minute_yl
minute_lin_next:
              INC       count_hour
              CALL      CLk
              MOV       DL,CL
              CALL      bcd2            ;bcd->16
              MOV       CL,6
              MUL       CL              ;al*cl
              PUSH      AX
              MOV       DL,second2
              CALL      bcd2                             
              XOR       AH,AH
              MOV       CL,12
              DIV       CL
              MOV       CL,AL       ;second2/12
              POP       AX
              MOV       CH,0
              ADD       AX,CX
              
              MOV       minute2,AX 
                                              
AAAa1:        
                         
              MOV       SIgle,2   
              MOV       Color,0
              MOV       AX,minute
              MOV       BX,r0
              ADD       BX,10
              CALL      renovate
              
              MOV       DX,yuanx
              MOV       x3,DX
              MOV       DX,yuany
              MOV       y3,DX
              ADD       AX,268
              ADD       BX,800              ;90
              
              CALL      renovate  
              
              MOV       DX,yuanx
              MOV       x2,DX
              MOV       DX,yuany
              MOV       y2,DX  
                                       
              MOV       DX,x0
              MOV       x1,DX
              MOV       DX,y0
              MOV       y1,DX
              CALL      sjx 
              
              ADD       AX,180
              CALL      renovate  
              
              MOV       DX,yuanx
              MOV       x2,DX
              MOV       DX,yuany
              MOV       y2,DX                 
              
              ADD       AX,90
              SUB       BX,200    
              CALL      renovate                
              MOV       DX,yuanx
              MOV       x3,DX
              MOV       DX,yuany
              MOV       y3,DX
              CALL      sjx 
              inc count0
              cmp count0,5
              jnz minute_yl
              mov count0,0
              call music
              call music
              call music                          
;**********************************重写                            
              
minute_yl:    MOV       sigle,1
              MOV       AL,color_min
              MOV       color,AL
              MOV       AX,minute2
              MOV       BX,r0
              ADD       BX,30
              CALL      renovate
              
              MOV       DX,yuanx
              MOV       x3,DX
              MOV       DX,yuany
              MOV       y3,DX
              ADD       AX,90
              ADD       BX,900                ;90
              
              CALL      renovate  
              
              MOV       DX,yuanx
              MOV       x2,DX
              MOV       DX,yuany
              MOV       y2,DX  
              
              ADD       AX,180
              CALL      renovate  
              
              MOV       DX,yuanx
              MOV       x1,DX
              MOV       DX,yuany
              MOV       y1,DX
              CALL      sjxx
              CALL      sjxy 
              
              ADD       AX,270
              SUB       BX,200  
              CALL      renovate                  
              MOV       DX,yuanx
              MOV       x3,DX
              MOV       DX,yuany
              MOV       y3,DX
              CALL      sjxx
              CALL      sjxy       
                       
              MOV       CX,minute2
              MOV       minute,CX
              CALL      hour_lin
                      
minute_kk1: 
minute_quit:  POPa
              RET
minute_lin    ENDP                            
                            
;******************in   dh秒数*********************              
second_lin    PROC      NEAR
              PUSHa
              CALL      CLk
              CMP       second2,DH
              JE        to_second_quit 
              JMP       second_lin_next
to_second_quit:JMP       second_quit
second_lin_next:           
                         
              MOV       SIgle,80h
              MOV       second2,DH 
              MOV       Color,0          
              MOV       DL,second             ;erase
              CALL      bcd2
              MOV       AH,0
              MOV       CL,6
              MUL       CL
              MOV       BX,r0
              ADD       BX,10
              CALL      renovate
             
              MOV       DX,yuanx
              MOV       x1,DX
              MOV       DX,yuany
              MOV       y1,DX
              ADD       AX,180
              ADD       BX,300
              
              CALL      renovate  
              
              MOV       DX,yuanx
              MOV       x2,DX
              MOV       DX,yuany
              MOV       y2,DX  
              CALL      linex
              CALL      liney
           
 ;重写             
              MOV       SIgle,80h
              MOV       AL,color_second
              MOV       color,AL
              MOV       DL,second2
              CALL      bcd2
              MOV       AH,0
              MOV       CL,6
              MUL       CL
              
              MOV       BX,r0
              ADD       BX,10
              CALL      renovate
              MOV       DX,yuanx
              MOV       x1,DX
              MOV       DX,yuany
              MOV       y1,DX
                                       
              ADD       AX,180
              ADD       BX, 300
              CALL      renovate  
              
              MOV       DX,yuanx
              MOV       x2,DX
              MOV       DX,yuany
              MOV       y2,DX  
              CALL      linex
              CALL      liney  
                              
              CALL      yuanxin
              MOV       DL,second2
              MOV       second,DL
              CALL      minute_lin
              CALL      skin2
              MOV       CL,second2
              MOV       second,CL
              
              CMP       count_minute,11
              JE        second_kk1
              INC       count_minute
              JMP       second_quit
second_kk1:   MOV       count_minute,0                            
second_quit:  POPa
              RET
second_lin    ENDP          
                                         
;******bxbbx*********in ax度数***bx长度,*********
 ;OUT x2->ax,y2->dx ;**
renovate      PROC      NEAR
              PUSHa
              ADD       AX,270
              PUSH      AX
              CALL      SIn
              MOV       DX,0
              MOV       CX,BX
              DIV       CX
              CMP       SI,1
              JE        hjian
              ADD       AX,y0
              JMP       renovate_kk1
hjian:        MOV       CX,y0
              SUB       CX,AX
              MOV       AX,CX
renovate_kk1: MOV       yuany,AX
              POP       AX  
              CALL      cos
              
              MOV       DX,0
              MOV       CX,BX
              DIV       CX
              CMP       SI,1
              JE        hjian2
              ADD       AX,x0
              JMP       renovate_kk2
hjian2:        MOV      CX,x0
              SUB       CX,AX
              MOV       AX,CX
renovate_kk2: MOV       yuanx,AX
              POPa   
              RET
renovate      ENDP                                              
;**************************              
Clk           PROC                                              
              MOV       AH,2
              INT       1ah
              RET
CLk           ENDP              
                      
;*****************cosx  in ax  out ax ,si符号******************              
cos           PROC      NEAR
              
              ADD       AX,90                   
cos_kk1:      CALL      SIn              
              RET
cos           ENDP                                                                                                                                                                         
;*********Sinx  in ax out ax ,si符号*******************************             
SIn           PROC      NEAR           ;out ax

              PUSH      CX
              PUSH      DX
              PUSH      BX
sin360:       CMP       AX,90
              JA        dy90
sto0_90:      MOV       SI,0
              JMP       pp1
dy90:         CMP       AX,180
              JBE       z91to180
              JMP       dy180
z91to180:     MOV       CX,180
              SUB       CX,AX
              MOV       AX,CX
              MOV       SI,0
              JMP       pp1
z181to270:    SUB       AX,180
              MOV       SI,1
              JMP       pp1
z271to360:    CMP       AX,359
              JA        zdy359
              MOV       CX,360
              SUB       CX,AX
              MOV       AX,CX
              MOV       SI,1
              JMP       pp1
zdy359:       SUB       AX,360
              JMP       SIn360                                                                  
              
dy180:        CMP       AX,270
              JBE       z181to270
              JMP       z271to360                            
              
pp1:          MOV       CX,175
              XOR       DX,DX
              MUL       CX
              MOV       sin_x,AX
              XOR       DX,DX
              MOV       CX,AX
              MUL       CX
              MOV       CX,10000 
              DIV       CX
              MOV       sin_xx,AX
              XOR       DX,DX
              MOV       CX,120
              DIV       CX
              MOV       BX,1677;1667
              CALL      SUBab
              MOV       CX,sin_xx
              XOR       DX,DX
              MUL       CX
              MOV       CX,10000
              DIV       CX               ;xx(xx/120-10000/6)
              MOV       CX,10000
              MOV       DL,0
              CMP       DL,s
              JE        jia
              SUB       CX,AX
              MOV       AX,CX
              JMP       kk1
jia:          ADD       AX,CX
kk1:          MOV       CX,sin_x
              XOR       DX,DX
              MUL       CX
              MOV       CX,10000
              DIV       CX
              POP       BX
              POP       DX
              POP       CX
              MOV       s,0
              RET 
SIn           ENDP  
              
              
;**************;绝对值在ax中符号在S中ax-bx*****s要定义db*************
subab         PROC                        
              CMP AX,BX
              JAE goab
              XOR s,1
              XCHG AX,BX
goab: 
              SUB AX,BX              
              RET
subab ENDP
  
              
;***************************linex***y=(y2-y1)*(x-x1)/(x2-x1)+y1
;****in (x1,y1),(x2,y2)******************x++                           
linex  PROC NEAR
              PUSH      x1
              PUSH      x2
              PUSH      y1
              PUSH      y2
              pusha 
              CALL    xymaxmin 
             MOV AX,y2
             MOV BX,y1
             CALL subab
             MOV  y2y1,AX
             MOV AX,x2
             MOV BX,x1
             CALL subab
             MOV  SI,0
             CMP  SI,AX
             JE   zhixian
             JMP  lopx
zhixian:     JMP  zhixianxs              
lopx:        MOV  x2x1,AX
             MOV  AX,xmin
             MOV       x,AX                                    
line0x:      SUB       AX,xmin
             MOV       DX,0 
              MOV       CX,y2y1    
              MUL       CX
              MOV       CX,x2x1
              DIV       CX
              MOV       DX,0
              CMP       DL,s
              
              JE        zhengx
              MOV       CX,AX
              MOV       AX,xminy
              SUB       AX,CX
              JMP       kk2x
zhengx:        ADD       AX,xminy
kk2x:         MOV       y,AX
               CALL      DIan 

               INC       x              
               MOV       AX,x
               CMP       AX,xmax
               JBE       line0x
               JMP       quit12             
              
zhixianxs:    MOV       AX,xmin
              MOV       x,AX
              MOV       AX,ymin
              MOV       y,AX
lopxx:        CALL      DIan

              INC       y
              MOV       AX,ymax
              CMP       AX,y
              JAE      lopxx                                                        
 quit12:      MOV       s,0             
              POPa
              POP       y2
              POP       y1
              POP       x2
              POP       x1              
              RET
linex         ENDP 
              
                
 ;**************************liney      x=(x2-x1)(y-y1)/(y2-y1)+x1
              ;*****************y++                        
              
sjx  PROC NEAR
              PUSH      x1
              PUSH      x2
              PUSH      y1
              PUSH      y2
              pusha 
              CALL      xymaxmin 
              MOV       AX,y2
              MOV       BX,y1
              CALL      subab
              MOV       y2y1,AX
              MOV       SI,0
              CMP       SI,AX
              JE        to_sjxx
sjx_lop1:     MOV       AX,x2
              MOV       BX,x1
              CALL      subab
              MOV       x2x1,AX
              MOV       SI,0
              CMP       SI,AX
              JE        to_sjxy
              MOV       DX,0
              MOV       AX,y2y1
              MOV       CX,x2x1
              DIV       CX
              CMP       AX,1
              JE        to_sjxx
              CMP       AX,0
              JE        to_sjxx
              JMP       to_sjxy
to_sjxx:      MOV       s,0
              CALL      sjxx    
              JMP       sjx_quit
to_sjxy:      MOV       s,0
              CALL      sjxy    
sjx_quit:     POPa
              POP       y2
              POP       y1
              POP       x2
              POP       x1   
              MOV       s,0        
              RET
sjx           ENDP              

liney  PROC NEAR
              PUSH      x1
              PUSH      x2
              PUSH      y1
              PUSH      y2
              pusha 
              CALL      xymaxmin 
              MOV       AX,y2
              MOV       BX,y1
              CALL      subab
              MOV       y2y1,AX
              MOV       SI,0
              CMP       SI,AX
              JE        heng
              JMP       lop1  
heng:         JMP       hengxian                     
lop1:         MOV AX,x2
              MOV BX,x1
              CALL subab
              MOV       x2x1,AX
              MOV       AX,ymin
              MOV       y,AX        
                            
line0y: SUB   AX,ymin
        MOV   DX,0 
              MOV       CX,x2x1    
              MUL       CX
              MOV       CX,y2y1
              DIV       CX
              MOV       DX,0
              CMP       DL,s
              JE        zhengy
              MOV       CX,AX
              MOV       AX,yminx
              SUB       AX,CX
              JMP       kky
zhengy:       ADD       AX,yminx
 kky:         MOV       x,AX
               
              CALL      DIan 
              INC       y              
              MOV       AX,y
              CMP       AX,ymax
              JBE       line0y
              JMP       quity
hengxian:     MOV       AX,ymin
              MOV       y,AX
              MOV       AX,xmin
              MOV       x,AX
lopy:         CALL      DIan
              INC       x
              MOV       AX,xmax
              CMP       AX,x
              JAE       lopy                     

 quity:       MOV       s,0             
              POPa
              POP      y2
              POP      y1
              POP      x2
              POP      x1              
              RET
liney         ENDP 
              
              
      
                      
              
              
;***************************linex***y=(y2-y1)*(x-x1)/(x2-x1)+y1
;****in (x1,y1),(x2,y2)******************x++                           
sjxx  PROC NEAR
              pusha 
              PUSH      x1
              PUSH      x2
              PUSH      x3
              PUSH      y1
              PUSH      y2
              PUSH      y3                            
              
              CALL      xymaxmin
              MOV       AX,xmin
              MOV       sjx_xmin,AX
              MOV       AX,ymin
              MOV       sjx_ymin,AX
              MOV       AX,xmax
              MOV       sjx_xmax,AX
              MOV       AX,ymax
              MOV       sjx_ymax,AX
              MOV       AX,xminy
              MOV       sjx_xminy,AX              
              
              
             MOV AX,y2
             MOV BX,y1
             CALL subab
             MOV       sjx_y2y1,AX
             MOV AX,x2
             MOV BX,x1
             CALL subab
              MOV       DL,s
              MOV       s2,DL
              MOV       s,0              
              MOV       SI,0
              CMP       SI,AX
              JE        sjx_zhixian
              JMP       sjx_lopx
sjx_zhixian:      
              MOV       x1,AX
              MOV       AX,x3
              MOV       x2,AX
              MOV       AX,y3
              MOV       y2,AX                 
              JMP       sjx_zhixianxs              
sjx_lopx:     MOV       sjx_x2x1,AX
              MOV       AX,x3
              MOV       x2,AX
              MOV       AX,y3
              MOV       y2,AX   
              MOV       AX,sjx_xmin
              MOV       x1,AX                    
                                               
sjx_line0x:   SUB       AX,sjx_xmin
              MOV       DX,0                         ;***y=(y2-y1)*(x-x1)/(x2-x1)+y1
              MOV       CX,sjx_y2y1    
              MUL       CX
              MOV       CX,sjx_x2x1
              DIV       CX
              MOV       DX,0
              CMP       DL,s2
              JE        sjx_zhengx
              MOV       CX,AX
              MOV       AX,sjx_xminy
              SUB       AX,CX
              JMP       sjx_kk2
sjx_zhengx:                 
              ADD       AX,sjx_xminy
sjx_kk2:                    
              MOV       y1,AX
               CALL      linex
               CALL      liney
               INC       x1              
               MOV       AX,x1
               CMP       AX,sjx_xmax
               JBE       sjx_line0x
               JMP       sjx_quit12             
              
sjx_zhixianxs: MOV       AX,sjx_xmin
              MOV       x1,AX
              MOV       AX,sjx_ymin
              MOV       y1,AX
sjx_lopxx:         
              CALL      linex
              CALL      liney
              INC       y1
              MOV       AX,sjx_ymax
              CMP       AX,y1
              JAE      sjx_lopxx                                                        
 sjx_quit12:  MOV       s,0
              POP       y3   
              POP      y2
              POP      y1
              POP       x3
              POP      x2
              POP      x1                                     
              POPa
              RET
sjxx           ENDP 
              
              
               
 ;**************************liney      x=(x2-x1)(y-y1)/(y2-y1)+x1
              ;*****************y++                        
              
              
sjxy  PROC NEAR
              PUSH      x1
              PUSH      x2
              PUSH      x3
              PUSH      y1
              PUSH      y2
              PUSH      y3
              pusha 
              CALL      xymaxmin 
              MOV       AX,xmin
              MOV       sjx_xmin,AX
              MOV       AX,ymin
              MOV       sjx_ymin,AX
              MOV       AX,xmax
              MOV       sjx_xmax,AX
              MOV       AX,ymax
              MOV       sjx_ymax,AX  
              MOV       AX,yminx
              MOV       sjx_yminx,AX                          
              MOV AX,y2
              MOV BX,y1    
              CALL subab
              MOV       sjx_y2y1,AX
              MOV       SI,0
              CMP       SI,AX
              JE        sjxy_heng
              JMP       sjxy_lop1  
sjxy_heng:     
              MOV       DL,s
              MOV       s2,DL
              MOV       s,0                 
              MOV       AX,x3
              MOV       x2,AX
              MOV       AX,y3
              MOV       y2,AX                               
              JMP       sjxy_hengxian                     
sjxy_lop1:    MOV      AX,x2
              MOV      BX,x1            ;x=(x2-x1)(y-y1)/(y2-y1)+x1
              CALL     subab
              MOV       DL,s
              MOV       s2,DL
              MOV       s,0
              MOV       sjx_x2x1,AX
              MOV       AX,x3
              MOV       x2,AX
              MOV       AX,y3
              MOV       y2,AX                               
              MOV       AX,sjx_ymin
              MOV       y1,AX     
             
sjxy_line0y:  SUB       AX,sjx_ymin
              MOV       DX,0 
              MOV       CX,sjx_x2x1    
              MUL       CX
              MOV       CX,sjx_y2y1
              DIV       CX
              MOV       DX,0
              CMP       DL,s2
              JE        sjxy_zhengy
              MOV       CX,AX
              MOV       AX,sjx_yminx
              SUB       AX,CX
              JMP       sjxy_kky3
sjxy_zhengy:                
              ADD       AX,sjx_yminx
sjxy_kky3:                   
               MOV       x1,AX
               CALL      linex
             
               CALL      liney  
               INC       y1              
               MOV       AX,y1
               CMP       AX,sjx_ymax
               JBE       sjxy_line0y
               JMP       sjxy_quity
sjxy_hengxian:     MOV       AX,sjx_ymin
              MOV       y1,AX
              MOV       AX,sjx_xmin
              MOV       x1,AX
sjxy_lopy:    CALL      liney
              CALL      linex
              INC       x1
              MOV       AX,sjx_xmax
              CMP       AX,x1
              JAE       sjxy_lopy                     

sjxy_quity:  MOV       s,0             
              POPa
              POP       y3
              POP      y2
              POP      y1
              POP       x3
              POP      x2
              POP      x1              
              RET
sjxy          ENDP 
              
 ;             
xymaxmin      PROC      NEAR
              PUSHa
              PUSH      x1
              PUSH      x2
              PUSH      y1
              PUSH      y2                            
              MOV       AX,x1
              CMP       AX,x2
              JAE       x1dyx2
              MOV       xmin,AX    ;x1<x2
              MOV       AX,y1
              MOV       xminy,AX
              MOV       AX,x2
              MOV       xmax,AX
              JMP       ymaxmin
x1dyx2:       MOV       xmax,AX
              MOV       AX,x2
              MOV       xmin,AX
              MOV       AX,y2
              MOV       xminy,AX        ;xminx 所对应的y
ymaxmin:      MOV       AX,y1
              CMP       AX,y2
              JAE       y1dyy2
              MOV       ymin,AX
              MOV       AX,x1
              MOV       yminx,AX       ;所对应的x
              MOV       AX,y2
              MOV       ymax,AX
              JMP       xymax_quit
y1dyy2:       MOV       ymax,AX
              MOV       AX,y2
              MOV       ymin,AX
              MOV       AX,x2
              MOV       yminx,AX
xymax_quit:                 
              POP      y2
              POP      y1
              POP      x2
              POP      x1                            
              POPa
              RET 
xymaxmin      ENDP   
                      
DIan PROC NEAR           ;画一点x,y
       PUSHa
       MOV       AH,s       
       MOV       s3,AH       
       MOV       AH,SIgle       
       AND       AH,80h
       CMP       AH,0
       JE        puanduan
paint:                                                         
       MOV AL,color
       MOV BH,page1   
       MOV       DX,y                
       MOV CX,x        ;列号
       MOV AH,0ch
       INT 10h
       JMP       DIanquit       
puanduan:
              CALL      readerdian
              MOV       DIancolor,AL
              MOV       AH,SIgle
               
              AND       AH,7fh
              CMP       AH,0
              JE        NEw0
              CMP       AH,1
              JE        NEw1
              CMP       AH,2
              JE        NEw2
              CMP       AH,3
              JE        NEw3
              CMP       AH,4
              JE        NEw4
              CMP       AH,5
              JE        NEw5
              CMP       AH,6
              JE        NEw6
              JMP       DIanquit
              
NEw0:         CMP       DIancolor,0
              JE        topaint
              JMP       DIanquit
NEw1:         CMP       DIancolor,0
              JE        topaint
              MOV       AH,color_hour
              CMP       DIancolor,AH
              JE        topaint
              JMP       DIanquit
topaint:      JMP       paint              
                                   
NEw2:         MOV       AH,color_min
              CMP       DIancolor, AH
              JE        topaint
              JMP       DIanquit
NEw3:         JMP       NEw0
NEw4:         JMP       NEw0
NEw5:         MOV       AH,color_hour                                                
              CMP       DIancolor,AH
              JE        topaint
              JMP       DIanquit
NEw6:         CMP       DIancolor,0
              JE        topaint
              JMP       DIanquit
              MOV       AX,x
              MOV       BX,x0
              CALL      SUBab
              CMP       AX,5
              JA        topaint
              MOV       AX,y
              MOV       BX,y0
              CALL      SUBab
              CMP       AX,5
              JA        topaint
            
                            
DIanquit:     MOV       AH,s3
              MOV       s,AH                                              
              POPa
              RET
DIan ENDP
              
yuanxin       PROC
              MOV       AL,color_second
              ADD       AL,1
              MOV       BH,PAGE1
              MOV       DX,y0
              MOV       CX,x0
              MOV       AH,0ch
              INT       10h
              DEC       DX              
              MOV       AH,0ch
              INT       10h
              DEC       CX
              MOV       AH,0ch
              INT       10h
              INC       DX
              MOV       AH,0ch
              INT       10h
              INC       DX
              MOV       AH,0ch
              INT       10h
              INC       CX
              MOV       AH,0ch
              INT       10h
              INC       CX
              MOV       AH,0ch
              INT       10h
              SUB       DX,1
              MOV       AH,0ch
              INT       10h
              DEC       DX
              MOV       AH,0ch
              INT       10h              
              
              RET
yuanxin       ENDP                            
              
readerdian    PROC
              MOV       BH,page1   
              MOV       DX,y                
              MOV       CX,x        ;列号
              MOV       AH,0dh
              INT       10h  
              RET
readerdian    ENDP                                 
                            
              
b1002         PROC      NEAR           ;入口DX-光标定位
              MOV       BH,0
              MOV       AH,02h
              INT       10h
              RET
b1002         ENDP

              
CLear         PROC
              MOV       DX,0410h
              CALL      b1002
              MOV       CX,6000
              MOV       BH,PAGE1
              MOV       AL,' '
              MOV       AH,0ah
              INT       10h
              RET
CLear         ENDP              
                        

 ;      12根******************************             
skin2         PROC
              PUSHa
              MOV       AL,color6
              MOV       color,AL
              
              MOV       CX,12
              MOV       AX,0
skin2_kk1:    PUSH      CX   
                  
              PUSH      AX
              MOV       BX,r0
              MOV       CX,y0
              MOV       DX,x0
              
              CALL      enovate
              MOV       AX,x
              MOV       x1,AX
              MOV       AX,y
              MOV       y1,AX
              POP       AX
              PUSH      AX
              
              MOV       BX,r0
              ADD       BX,10
              MOV       CX,y0
              MOV       DX,x0

              CALL      enovate
              MOV       AX,x
              MOV       x2,AX
              MOV       AX,y
              MOV       y2,AX
              CALL      linex
              CALL      liney
              POP       AX
              ADD       AX,30
              
              POP       CX
              LOOP      skin2_kk1
              MOV       CX,4
              MOV       AX,0
skin2_kk2:    PUSH      CX   
                  
              PUSH      AX
              MOV       BX,r0
              MOV       CX,y0
              MOV       DX,x0
              
              CALL      enovate
              MOV       AX,x
              MOV       x1,AX
              MOV       AX,y
              MOV       y1,AX
              POP       AX
              PUSH      AX
              
              MOV       BX,r0
              ADD       BX,20
              MOV       CX,y0
              MOV       DX,x0

              CALL      enovate
              MOV       AX,x
              MOV       x2,AX
              MOV       AX,y
              MOV       y2,AX
              CALL      linex
              CALL      liney
              POP       AX
              ADD       AX,90
                            
              POP       CX
              LOOP      skin2_kk2
                                    
              POPa
              RET
skin2         ENDP     
;60根**********************************88              
              
skin3         PROC
              PUSHa
              MOV       AL,color5
              MOV       color,AL
              MOV       CX,60
              MOV       AX,0
skin2_kk3:    PUSH      CX   
                  
              PUSH      AX
              MOV       BX,r0
              MOV       CX,y0
              MOV       DX,x0
              
              CALL      enovate
              MOV       AX,x
              MOV       x1,AX
              MOV       AX,y
              MOV       y1,AX
              POP       AX
              PUSH      AX
              
              MOV       BX,r0
              ADD       BX,3
              MOV       CX,y0
              MOV       DX,x0

              CALL      enovate
              MOV       AX,x
              MOV       x2,AX
              MOV       AX,y
              MOV       y2,AX
              CALL      linex
              CALL      liney
              POP       AX
              ADD       AX,6
                            
              POP       CX
              LOOP      skin2_kk3
              POPa
              RET
skin3         ENDP                       
;数字加圆**************************************88                            
skin          PROC      NEAR
              MOV       AL,color4
              MOV       color,AL
              MOV       BX,r0
              CALL      yuan
              MOV       BX,r0              
              MOV       DH,7
              MOV       DL,39
              CALL      b1002
              MOV       DL,'1'
              MOV       AH,2
              INT       21h
              MOV       DH,7
              MOV       DL,40
              CALL      b1002
              MOV       DL,'2'
              MOV       AH,2
              INT       21h 
              
              
              MOV       DH,8
              MOV       DL,47
              CALL      b1002
              MOV       DL,'1'
              MOV       AH,2
              INT       21h  
              
              MOV       DH,11
              MOV       DL,53
              CALL      b1002
              MOV       DL,'2'
              MOV       AH,2
              INT       21h 
  
              MOV       DH,19
              MOV       DL,53
              CALL      b1002
              MOV       DL,'4'
              MOV       AH,2
              INT       21h

              MOV       DH,22
              MOV       DL,47
              CALL      b1002
              MOV       DL,'5'
              MOV       AH,2
              INT       21h 

              MOV       DH,22
              MOV       DL,32
              CALL      b1002
              MOV       DL,'7'
              MOV       AH,2
              INT       21h
 
              MOV       DH,19
              MOV       DL,26
              CALL      b1002
              MOV       DL,'8'
              MOV       AH,2
              INT       21h 
 
              MOV       DH,11
              MOV       DL,25
              CALL      b1002
              MOV       DL,'1'
              MOV       AH,2
              INT       21h
              MOV       DH,11
              MOV       DL,26
              CALL      b1002
              MOV       DL,'0'
              MOV       AH,2
              INT       21h 

              MOV       DH,8
              MOV       DL,30
              CALL      b1002
              MOV       DL,'1'
              MOV       AH,2
              INT       21h 
              MOV       DH,8
              MOV       DL,31
              CALL      b1002
              MOV       DL,'1'
              MOV       AH,2
              INT       21h
        
              MOV       DH,15
              MOV       DL,55
              CALL      b1002
              MOV       DL,'3'
              MOV       AH,2
              INT       21h         
              MOV       DH,23
              MOV       DL,40
              CALL      b1002
              MOV       DL,'6'
              MOV       AH,2
              INT       21h
              MOV       DH,15
              MOV       DL,24
              CALL      b1002
              MOV       DL,'9'
              MOV       AH,2
              INT       21h
              RET
                            
skin          ENDP             
 
msg           PROC      NEAR        ;in bp为输出字符串地址
              PUSH      ES
              PUSH      DS
              POP       ES
              MOV       CX,40h
              MOV       AL,0
              MOV       BX,2
              MOV       AH,13h
              INT       10h
              POP       ES
              RET
msg           ENDP

;*****************in dl  out al
bcd2          PROC      NEAR                            
              MOV       AH,0
              MOV       AL,DL
              SHR       AL,4
              AND       AL,0fh
              MOV       CL,10
              MUL       CL
              MOV       CL,AL
              MOV       AL,DL
              AND       AL,0fh
              ADD       AL,CL;;;;;      bcd转16进制
              RET
bcd2          ENDP                            
                                                                                            
;r0=bx    圆心cx 行 dx列********************               
yuan          PROC
              PUSHa
              MOV       CX,360
              MOV       AX,0
yuan_kk1:     PUSH      CX   
              PUSH      AX
              MOV       CX,y0
              MOV       DX,x0
              CALL      enovate
              CALL      dian
              POP       AX
              ADD       AX,1
              POP       CX
              LOOP      yuan_kk1
                         
              POPa
              RET
yuan          ENDP                                          
             
;*****************in ax度数    bx=半径r长度,cx 列 dx行  圆心 out  x,y************
enovate       PROC      NEAR
              PUSHa
              PUSH      DX
              PUSH      AX
              PUSH      CX
              CALL      SIn
              MOV       DX,0
              MOV       CX,BX
              DIV       CX
              POP       CX
              CMP       SI,1
              JE        ian
                         
              ADD       AX,CX
              JMP       enovate_kk1
ian:          SUB       CX,AX
              MOV       AX,CX
enovate_kk1:  MOV       y,AX
              POP       AX                            
              CALL      cos
              MOV       DX,0
              MOV       CX,BX
              DIV       CX
              POP       DX
              CMP       SI,1
              JE        ian2
              ADD       AX,DX
              JMP       enovate_kk2
ian2:         MOV       CX,DX
              SUB       CX,AX
              MOV       AX,CX
enovate_kk2:  MOV       x,AX                                   
              POPa
              RET
enovate     ENDP       
              
                            
                                                                                         
   MAIN          ENDP                 
;------------------------------------------------------
CODE_SEG      ENDS
;******************************************************
              END       START    ;程序结束

