 data_seg    segment
 car         db 26
             db 3dh,0eh,0,0
             db 40h,0ah,1,0
             db 9 dup(02ah,0bh,1,0)
             db 40h,0ah,1,0
             db 3dh,0eh,1,0
             db 3ch,0eh,0,-1
             db 2ah,0bh,-1,0
             db 9 dup(40h,0bh,-1,0)
             db 2ah,0bh,-1,0
             db 3ch,0eh,-1,0
  car1       db 26
             db 3dh,0eh,0,0
             db 11 dup(40h,0bh,1,0)
             db 3dh,0eh,1,0
             db 3eh,0eh,0,1
             db 11 dup(02ah,0bh,-1,0)
             db 3eh,0eh,-1,0
 ;---------------------------------------
  jeep1      db 26
             db 3dh,0eh,0,0
             db 11 dup(40h,0bh,1,0)
             db 3dh,0eh,1,0
             db 3ch,0eh,0,-1
             db 11 dup(02ah,0bh,-1,0)
             db 3ch,0eh,-1,0
;--------------------------------------
  jeep       db 26     
             db 3dh,0eh,0,0
             db 40h,0ah,1,0
             db 9 dup(02ah,0bh,1,0)
             db 40h,0ah,1,0
             db 3dh,0eh,1,0
             db 3eh,0eh,0,1
             db 2ah,0bh,-1,0
             db 9 dup(40h,0bh,-1,0)
             db 2ah,0bh,-1,0
             db 3eh,0eh,-1,0
 ;----------------------------------------
  left       db '_',0ch,0,0
             db 5ch,0ch,1,0
             db 2fh,0ch,1,0
             db 4 dup(7ch,0ch,1,0)
             db 5ch,0ch,2,0
             db 5ch,0ch,1,0
             db 2ah,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,-9,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,1,0
             db 5ch,0ch,1,0
             db 2ah,0ch,1,0
             db 5ch,0ch,2,0
             db '_',0ch,-9,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2ah,0ch,1,0
             db '_',0ch,-7,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2ah,0ch,1,0
             db 5ch,0ch,-10,-1
             db 9 dup(7ch,0ch,1,0)
             db 2ah,0ch,1,0
             db 2ah,0ch,-10,-1
             db 9 dup(7ch,0ch,1,0)
             db 2ah,0ch,1,0
             db '_',0ch,-7,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2ah,0ch,1,0
             db '_',0ch,-7,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2fh,0ch,1,0
             db '_',0ch,-7,-1
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,2,0
             db 2 dup(2fh,0ch,1,0)
             db 5ch,0ch,-8,-1
             db 4 dup(7ch,0ch,1,0)
             db 2fh,0ch,1,0
             db 2ah,0ch,2,0
             db 3dh,0ch,1,0
             db 2fh,0ch,1,0
             db 7ch,0ch,-9,-1
             db 5 dup(7ch,0ch,1,0)
             db 2fh,0ch,3,0
             db 5ch,0ch,1,0      
        ;---------------------------
             db 5ch,0ch,-9,-2
             db 5ch,0ch,8,0
             db 2fh,0ch,1,0
             db '_',0ch,-10,-1
             db 2 dup(2fh,0ch,1,0)
             db 2fh,0ch,7,0
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 7ch,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2fh,0ch,1,0
             db '_',0ch,7,0
             db '_',0ch,1,0
             db 5ch,0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 5ch,0ch,3,0            
             db 2 dup(7ch,0ch,1,0)
             db 2fh,0ch,1,0
             db '_',0ch,2,0
             db '_',0ch,1,0
             db 2fh,0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(3eh,0ch,1,0)
             db 2fh,0ch,1,0
             db 3 dup(7ch,0ch,1,0)
             db '_',0ch,2,0
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2ah,0ch,1,0
             db 3eh,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,2,0
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db '_',0ch,2,0
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 2 dup(7dh,0ch,1,0)
             db '_',0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 3 dup(2ah,0ch,1,0)
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(3ch,0ch,1,0)
             db 3ch,0ch,2,0
             db 3ch,0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(7bh,0ch,1,0)
             db 5ch,0ch,1,0
             db '_',0ch,-12,-1
             db 2 dup(3dh,0ch,1,0,7ch,0ch,1,0)
             db 7ch,0ch,1,0
             db 3dh,0ch,4,0
             db '_',0ch,-9,-1
             db 2 dup(3dh,0ch,1,0,2bh,0ch,1,0)
             db 2bh,0ch,1,0
             db 5ch,0ch,2,0
             db 3dh,0ch,2,0
             db '_',0ch,-9,-1
             db 2 dup(3dh,0ch,1,0,7ch,0ch,1,0)
             db 7ch,0ch,1,0
             db '_',0ch,1,0
             db 2fh,0ch,1,0
             db 5ch,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,-9,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0              
             db 2 dup(3eh,0ch,1,0)
             db '_',0ch,1,0
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db 3dh,0ch,1,0
             db 7dh,0ch,1,0
             db '_',0ch,-10,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db '_',0ch,-11,-1      
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 7bh,0ch,1,0
             db 2ah,0ch,1,0
             db 3eh,0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2 dup(2ah,0ch,1,0)
             db 3dh,0ch,1,0
             db 2fh,0ch,2,0
             db 3dh,0ch,1,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3 dup(3dh,0ch,1,0)
             db '_',0ch,1,0
             db 2ah,0ch,1,0
             db 3ch,0ch,1,0
             db 3dh,0ch,1,0
             db 3dh,0ch,3,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2 dup(3ch,0ch,1,0)
             db '_',0ch,1,0
             db 3 dup(7ch,0ch,1,0)
             db 3dh,0ch,3,0
             db '_',0ch,-12,-1
             db 3dh,0ch,1,0
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 2fh,0ch,4,0
             db 2 dup(7ch,0ch,1,0)
             db 3dh,0ch,3,0
             db 2fh,0ch,-11,-1
             db '_',0ch,1,0
             db 3dh,0ch,1,0
             db 3ch,0ch,9,0
             db 2fh,0ch,-9,-1
             db 2fh,0ch,1,0
             db 3ch,0ch,8,0
             db 2fh,0ch,-8,-1      
             db 3ch,0ch,8,0
 right       db 189
             db '_',0ch,0,0
             db 3dh,0ch,1,0
             db 5ch,0ch,1,0
             db 3 dup(7ch,0ch,1,0)
             db 2fh,0ch,1,0
             db 5ch,0ch,3,0
             db 2ah,0ch,1,0
             db 3dh,0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 40h,0ch,9,0
             db 3dh,0ch,1,0
             db 2 dup('_',0ch,-11,1,3dh,0ch,1,0,3dh,0ch,10,0)
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 9 dup(7ch,0ch,1,0)
             db 3dh,0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 9 dup(2bh,0ch,1,0)
             db 3dh,0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 9 dup(7ch,0ch,1,0)
             db 3dh,0ch,1,0
             db 3 dup('_',0ch,-11,1,3dh,0ch,1,0,3dh,0ch,10,0)
             db '_',0ch,-11,1
             db 2fh,0ch,1,0
             db 3dh,0ch,10,0
             db 5ch,0ch,-10,1      
             db 2fh,0ch,10,0
        ;--------------------------
             db 2fh,0ch,-6,1
             db 5ch,0ch,1,0
             db 2ah,0ch,4,0
             db 5ch,0ch,1,0       
             db 2fh,0ch,-7,1
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db 2fh,0ch,3,0
             db 3dh,0ch,1,0
             db 7ch,0ch,-6,1
             db 7ch,0ch,1,0
             db 2fh,0ch,3,0
             db 2ah,0ch,1,0
             db 2fh,0ch,-2,1
             db 2ah,0ch,1,0
             db 7ch,0ch,-9,1
             db 5 dup(7ch,0ch,1,0)
             db 7bh,0ch,1,0
             db 40h,0ch,1,0
             db 2ah,0ch,1,0
             db 5ch,0ch,-8,1               
             db 8 dup(2ah,0ch,1,0) ;101
             db '_',0ch,-8,1
             db 5 dup(7ch,0ch,1,0)
             db 7dh,0ch,1,0
             db 40h,0ch,1,0
             db 2ah,0ch,1,0
             db 2fh,0ch,-4,1
             db 2ah,0ch,1,0
             db 5ch,0ch,3,0
             db 5ch,0ch,1,0
             db 2fh,0ch,-6,1
             db 2ah,0ch,1,0
             db 2fh,0ch,1,0
             db 5ch,0ch,4,0
             db 5ch,0ch,1,0
             db 5ch,0ch,-7,1
             db 2fh,0ch,1,0
             db '_',0ch,5,0
             db 2ah,0ch,1,0
             db 5ch,0ch,1,0
             db '_',0ch,-10,1
             db 5ch,0ch,1,0
             db 5ch,0ch,8,0
             db 2fh,0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 2fh,0ch,8,0
             db '^',0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 5ch,0ch,8,0
             db '^',0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 3dh,0ch,8,0
             db '^',0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 3dh,0ch,8,0
             db 5ch,0ch,1,0
             db '_',0ch,-10,1
             db 3dh,0ch,1,0
             db 7 dup(7ch,0ch,1,0)
             db 3dh,0ch,1,0
             db 40h,0ch,1,0
             db '^',0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 8 dup(2bh,0ch,1,0)
             db 2 dup(2ah,0ch,1,0)
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db 8 dup(7ch,0ch,1,0)
             db 7dh,0ch,1,0
             db 2fh,0ch,1,0
             db '_',0ch,-11,1
             db 3dh,0ch,1,0
             db '_',0ch,-1,1
             db 3dh,0ch,1,0
             db '_',0ch,-1,1
             db 2fh,0ch,1,0
             db 5ch,0ch,0,1     

 char_cnt1   dw ?
 pointer1    dw ?
 line_on1    db ?
 col_on1     db ?
 char_cnt2   dw ?
 pointer2    dw ?
 line_on2    db ?
 col_on2     db ?
 char        dw ?
 char0       db ?
 count       db ?
 count1       db ?
 line        db ?   
 line1       db ?
 line2       db ?
 col         db ?
 col1        db ?
 col2        db ?
 point1      dw ?
 point2      dw ?
 data_seg    ends
 ;---------------------------------------
 code_seg    segment
             assume cs:code_seg,ds:data_seg
 main        proc  far
             push  ds
             sub   ax,ax
             sub   cx,cx
             push  ax
             push  cx
             mov   ax,data_seg
             mov   ds,ax
             mov   char0,2
             mov   count,2
             mov   count1,200
again:       
             lea   di,car
             mov   dh,4
             mov   dl,38
             call  move_shape1
             lea   di,jeep
             mov   dh,4
             mov   dl,39
             call  move_shape2
             dec   count
             lea   di,left
             mov   dh,5
             mov   dl,38
             call  move_shape1
             lea   di,right
             mov   dh,5
             mov   dl,39
             call  move_shape2
             call  must_2
             inc   count
             lea   di,jeep1
             mov   dh,4
             mov   dl,76
             call  move_shape1      
             lea   di,car1
             mov   dh,4
             mov   dl,3
             call  move_shape2 
             mov   char0,2      
  exit01:           
             call  dly_qrtr
             dec   count1
             jne   exit01
             call  must_2
             pop   cx
             ret
 main        endp
 ;-------------------------------------
 move_shape1    proc near
                push ax
                push bx
                push cx
                push dx
                push di
                mov  ah,0fh
                int  10h
                cmp  count,1
                je   exit20
                sub  ch,ch
                mov  cl,[di]
                inc  di
                mov  char_cnt1,cx
                mov  pointer1,di
                mov  line_on1,dh
                mov  col_on1,dl
                mov  char,cx
                jmp  exit21

 exit20:        mov  point1,di
                mov  line1,dh
                mov  col1,dl

 exit21:        pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax
                ret
 move_shape1    endp
 ;----------------------------
 move_shape2    proc near
                push ax
                push bx
                push cx
                push dx
                push di
                mov  ah,0fh
                int  10h
                sub  ch,ch
                mov  cl,[di]
                inc  di
                cmp  count,1
                je   exit23
                mov  char_cnt2,cx
                mov  pointer2,di
                mov  line_on2,dh
                mov  col_on2,dl
                mov  char,cx
                jmp  exit22

 exit23:        mov  point2,di
                mov  line2,dh
                mov  col2,dl

 exit22:        pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax
                ret
 move_shape2    endp
;-----------------------------------------
 must_2      proc       near
                push ax
                push bx
                push cx
                push dx
                push di
                mov  ah,0fh
                int  10h
 exit4:      sub  cx,cx
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,col_on1
             mov        char,cx
             jmp        plot_next
 exit3:      sub  cx,cx
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,col_on2
             mov        char,cx
             jmp        plot_next  
 exit5:      call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       erase
             mov        char0,2
             jmp        exit4

 plot_next:  add  dh,[di+2]
             add  dl,[di+3]
             cmp  count,1
             jne  exit1
             cmp  dl,3
             je   exit2
             jmp  exit
 exit1:      cmp  dl,40
             je   exit2
 exit:       mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,[di+1]
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             add  di,4
             loop plot_next
             cmp  char0,1
             je   exit5
             dec  char0
             jmp  exit3

 exit2:      call   erase
                pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax                             
             ret
must_2       endp
;------------------------------------------
erase       proc       near
            push  si
            sub   si,si
            mov  char0,2
 exit7:     sub  cx,cx
            push   bx
            sub    bx,bx
            mov        bl,line1
            mov        line,bl
            mov        bl,col1
            mov        col,bl
            pop    bx
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col_on1
            mov        si,point1
            jmp        erase_next
 exit6:     sub  cx,cx
            push   bx
            sub    bx,bx
            mov        bl,line2
            mov        line,bl
            mov        bl,col2
            mov        col,bl
            pop    bx
            mov        cx,char_cnt2
            mov        di,pointer2
            mov        dh,line_on2
            mov        dl,col_on2
            mov        si,point2
            jmp        erase_next
 erase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
    ;------------------------------------
             cmp        count,2
             je     exit31
             cmp        cx,13
             jb     exit31
             cmp        dl,col
             jne    exit31
             cmp        dh,line 
             jne    exit31
             mov        al,[si]
             mov        bl,[si+1]
             push       cx                        
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
             add        di,4
             add        si,4
             cmp        char0,1
             je     exit40
             push   dx
             sub    dx,dx
             mov      dh,[si+2]
             add        dh,line1
             mov        line1,dh
             mov        line,dh
             mov      al,[si+3]
             add        al,col1
             mov        col1,al
             mov        col,al
             pop    dx
 exit41:     loop   erase_next
             jmp    exit8
 exit31:     mov        al,'*'
             mov        bl,0
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
             add        di,4
             jmp    exit41
 exit40:     push   dx   
             sub    dx,dx
             mov         dh,[si+2]
             add      dh,line2
             mov        line2,dh
             mov        line,dh
             mov         dl,[si+3]
             add      dl,col2
             mov        col2,dl
             mov        col,dl
             pop    dx
             jmp     exit41
 exit8:      cmp        char0,1
             je         left0
             mov        point1,si
             dec        char0
             jmp        exit6 
 left0:      mov        point2,si
             dec        col_on1
             inc        col_on2
             pop   si
             ret
 erase       endp
 ;------------------------------------------
 dly_qrtr    proc       near
             push       cx
             push       dx
             mov        dx,25
 dll:        mov        cx,60000
 dl2:        loop       dl2
             dec        dx
             jnz        dll
             pop        dx
             pop        cx
             ret
 dly_qrtr    endp
 ;---------------------------------------
 code_seg    ends
             end    main
 ;---------------------------------

