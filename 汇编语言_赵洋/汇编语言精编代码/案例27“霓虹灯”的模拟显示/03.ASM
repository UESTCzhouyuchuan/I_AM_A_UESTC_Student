 data_seg    segment
  car        db 2
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
  jeep       db 2      
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
  star       db 2
             db 40h,0bh,0,0
             db 02ah,0,0,1
  star1      db 2      
             db 40h,0bh,0,0
             db 02ah,0,0,-1

  star2      db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,1

             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,2,-1
             db 02ah,0bh,0,1

             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-4,-1
             db 02ah,0bh,0,1

             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,6,-1
             db 02ah,0bh,0,1

             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-8,-1
             db 02ah,0bh,0,1

             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,10,-1
             db 02ah,0bh,0,1

             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-12,-1
             db 02ah,0bh,0,1
  star3      db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1

             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,2,1
             db 02ah,0bh,0,-1

             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-4,1
             db 02ah,0bh,0,-1

             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,6,1
             db 02ah,0bh,0,-1

             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-8,1
             db 02ah,0bh,0,-1

             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,10,1
             db 02ah,0bh,0,-1

             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-12,1
             db 02ah,0bh,0,-1

 char_cnt1   dw ?
 pointer1    dw ?
 line_on1    db ?
 col_on1     db ?
 char_cnt2   dw ?
 pointer2    dw ?
 line_on2    db ?
 col_on2     db ?
 char        dw ?
 col         db ?
 col0        db ?
 col00       db ?
 col01       db ?
 count       db ?
 count0      db ?
 count1      db ?
 count2      db ?
 char0       db ?
 char1       db ?
 char01      db ?
 char2       db ?
 line1       db ?
 col1        db ?
 pot1        dw ?
 line2       db ?
 col2        db ?
 pot2        dw ?
 count_cx    db ?
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

             mov   col,2
             mov   col0,2
             mov   col01,2
             mov   char0,2
             mov   char01,2
             mov   count,5
             mov   char1,76
             mov   char2,2
             mov   count0,4
             mov   count1,2
             mov   count_cx,2
again:    
             lea   di,star
             mov   dh,3
             mov   dl,2
             call  move_shape
             dec   count0
             lea   di,star1
             mov   dh,17
             mov   dl,76
             call  move_shape
             dec   count0
             lea   di,jeep
             mov   dh,4
             mov   dl,2
             call  move_shape
             dec   count0
             lea   di,car
             mov   dh,16
             mov   dl,76
             call  move_shape
   ;------------------------------
             mov   count0,13
  again1:
             mov   col,2
             mov   col0,2
             mov   col01,2
             mov   char0,2
             mov   char01,2
             mov   count,5
             mov   char1,76
             mov   char2,2
             mov   count1,2
             mov   count_cx,2

             lea   di,star2
             mov   dh,10
             mov   dl,40
             call  move_shape1
             lea   di,star3
             mov   dh,10
             mov   dl,38
             call  move_shape2
             call  must_2
             dec   count0
             jne   again1
             pop   cx
             ret
 main        endp
 ;----------------------------
 clear_screen proc near
             push   ax
             push   bx
             push   cx
             push   dx
             mov    ah,6
             mov    al,0
             mov    ch,0
             mov    cl,0
             mov    dh,24
             mov    dl,79
             mov    bh,7
             int    10h
             pop     dx
             pop     cx
             pop     bx
             pop     ax
             ret
 clear_screen  endp
 ;-------------------------------------
 move_shape     proc near
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
                mov  char_cnt1,cx
                mov  pointer1,di
                mov  line_on1,dh
                mov  col_on1,dl
plot_next:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  count0,3
             je   exit2
             cmp  count0,2
             je   exit9
             cmp  count0,1
             je   exit10
             cmp  dl,78
             jb   mov_crsr
             jmp  exit1
exit2:       cmp  dl,1
             jnb  mov_crsr
             jmp  exit1
exit9:       cmp  dh,17
             jb   mov_crsr
             jmp  exit1
exit10:      cmp  dh,3
             ja   mov_crsr
exit1:       pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
 mov_crsr:
             mov  ah,2
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
 exit4:      dec  count
             je   exit3
             call dly_qrtr
             jmp  exit4
 exit3:      call erase
             mov  count,5
             jmp  short plot_next
 move_shape  endp
;----------------------------------------
 ;-------------------------------------
 move_shape1    proc near
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
                mov  char_cnt1,cx
                mov  pointer1,di
                mov  line_on1,dh
                mov  col_on1,dl
                mov  char,cx
                pop  di
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
                mov  char_cnt2,cx
                mov  pointer2,di
                mov  line_on2,dh
                mov  col_on2,dl
                mov  char,cx
                pop  di
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
 exit41:     sub  cx,cx
             mov        col,2
             mov        col01,2
             mov        char0,2
             mov        char01,2
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,col_on1
             mov        char,cx
             jmp        plot_next1
 exit31:     sub  cx,cx
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,col_on2
             mov        char,cx
             jmp        plot_next1
 ;------------------------------------------
 exit61:     call       dly_qrtr
             mov        char0,2
             mov        char01,2
             mov        col01,2
             mov        col,2
             mov        dl,col_on2
             cmp        dl,38
             je         exit71
             cmp        dl,32
             je         exit71
             cmp        dl,26
             je         exit71
             cmp        dl,20
             je         exit71
             cmp        dl,14
             je         exit71
             cmp        dl,8
             je         exit71
             cmp        dl,2
             je         exit72
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       erase1
             cmp        col0,26
             je         exit81
             add        col0,4
 exit81:     jmp        exit41

 exit71:     add        col_on1,2
             sub        col_on2,2
             cmp        col0,26
             je         exit81  
             add        col0,4
             jmp        exit41
 exit02:     jmp        exit61
 exit72:     jmp        exit21
 exit01:     mov  line2,dh
             mov  col2,dl
             add  di,4
             mov  pot2,di

             mov  dl,col01
             cmp  col0,dl
             je   exit02

             add  col01,4
             mov  col,4
             mov  char01,2 
             dec  char01
             jmp  exit410
             
 exit21:        pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax                             
             ret
 exit410:    mov        dh,line1
             mov        di,pot1
             mov        dl,col1
             jmp        plot_next1
 exit310:    mov        dh,line2
             mov        di,pot2
             mov        dl,col2
             jmp        plot_next1
 exit03:     jmp  exit01
 ;----------------------------------------
 plot_next1: add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             mov  ah,8
             int  10h
             cmp  dl,3
             jb   exitx0
             cmp  dl,76
             jae  exitx0
             cmp  ah,0bh
             je   exitx
             cmp  ah,0dh
             je   exitx2
             cmp  ah,0ah
             je   exitx3
             cmp  ah,0eh
             je   exitx4
 exitx0:     mov  al,[di]
             mov  bl,[di+1]
             jmp  exitx1
 exitx:      mov  bl,0dh
             jmp  exitx1
 exitx2:     mov  bl,0ah
             jmp  exitx1
 exitx3:     mov  bl,0eh
             jmp  exitx1
 exitx4:     mov  bl,0ch
 exitx1:     push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             dec  col
             je   exit51
             add  di,4
             jmp  plot_next1

 exit51:     cmp  char01,0
             je   exit03   ;-------------
             cmp  char01,1
             je   exit12
             cmp  char0,1
             je   exit03  ;--------------------
             mov  line1,dh
             mov  col1,dl
             add  di,4
             mov  pot1,di
             mov  col,2     
             dec  char0
             jmp  exit31

 exit12:     mov  line1,dh
             mov  col1,dl             
             add  di,4
             mov  pot1,di
             dec  char01
             mov  col,4
             jmp  exit310
must_2       endp
;--------------------------------------------
 erase       proc       near
             cmp        count0,4
             jne        exit6
             add        col_on1,2
             jmp        exit
 exit6:      cmp        count0,3
             jne        exit7
             sub        col_on1,2
             jmp        exit
 exit7:      cmp        count0,2
             jne        exit8
             inc        line_on1
             jmp        exit
 exit8:      cmp        count0,1
             jne        exit
             dec        line_on1
 exit:       mov        dh,line_on1
             mov        dl,col_on1
             mov        cx,char_cnt1
             mov        di,pointer1
             ret
 erase       endp
;-----------------------------------------
 erase1       proc       near
            sub  cx,cx
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col_on1
            mov        char,cx
            jmp        erase_next1

exit62:     sub  cx,cx
            mov        cx,char_cnt2
            mov        di,pointer2
            mov        dh,line_on2
            mov        dl,col_on2
            mov        char,cx
            jmp        erase_next1

 exit011:    mov  line2,dh
             mov  col2,dl
             add  di,4
             mov  pot2,di

             mov  dl,col01
             cmp  col0,dl
             je   exit021

             add  col01,4
             mov  col,4      
             mov  char01,2 
             dec  char01 
             jmp  exit4101                 

 exit4101:   mov        dh,line1
             mov        di,pot1
             mov        dl,col1
             jmp        erase_next1
 exit3101:   mov        dh,line2
             mov        di,pot2
             mov        dl,col2
             jmp        erase_next1
 exit012:    jmp  exit011
 exit021:    jmp  left
            
 erase_next1:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,0
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
  ;-------------------------------------
             dec        col
             je         exit0
             add        di,4
             jmp        erase_next1
 exit0:      cmp  char01,0
             je   exit012  ;-------------
             cmp  char01,1
             je   exit121
             cmp  char0,1
             je   exit012  ;--------------------
             mov  line1,dh
             mov  col1,dl
             add  di,4
             mov  pot1,di
             mov  col,2     
             dec  char0
             jmp  exit62
 exit121:    mov  line1,dh
             mov  col1,dl
             add  di,4
             mov  pot1,di
             dec  char01
             mov  col,4
             jmp  exit3101
 left:       add        col_on1,2
             sub        col_on2,2
             ret
 erase1       endp
 ;------------------------------------------
 dly_qrtr    proc       near
             push       cx
             push       dx
             mov        dx,25
 dll:        mov        cx,65530
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

