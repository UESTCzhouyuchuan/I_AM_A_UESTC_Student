 data_seg    segment
  star2      db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
  star3      db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
 char_cnt    dw ?
 pointer     dw ?
 line_on     db ?
 col_on      db ?
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
             mov   count,1
             mov   char1,1
             mov   char2,77
             mov   count0,4
             mov   count1,2
             mov   count_cx,2
again:    
             lea   di,star2
             mov   dh,16
             mov   dl,38
             call  move_shape1
             lea   di,star3
             mov   dh,16
             mov   dl,40
             call  move_shape2
             dec   count_cx
             call  must_2
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
;----------------------------------------
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
                mov  char_cnt,cx
                mov  pointer,di
                mov  line_on,dh
                mov  col_on,dl
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
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             mov        dl,col_on
             mov        char,cx
             jmp        plot_next1
 exit31:     sub  cx,cx
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,col_on2
             mov        char,cx
             jmp        plot_next1
  ;-------------------------------------
 exit61:     call       dly_qrtr
             mov        char0,2
             mov        char01,2
             mov        col01,2
             mov        col,2
             mov        dl,col_on2
             inc        dl
             cmp        char2,dl
             je         exit71
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       erase1
             cmp        col0,26
             je         exit41
             add        col0,2
             jmp        exit41
       ;----------------------------
 exit71:     cmp        count1,1
             je         exit93
             cmp        line_on,16
             jne        exit91
             cmp        col0,26
             jne        exit92
 exit91:     sub        col0,2
             je         exit82
             dec        line_on
             dec        line_on2
             add        col_on,2
             sub        col_on2,2
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       erase1
             mov        count1,2
             jmp        exit41
 exit82:     cmp        count_cx,1
             je         exit22
             jmp        exit81
 exit92:     mov        al,26
             sub        al,col0
             mov        count2,al
             add        count2,2
             mov        dl,col0
             mov        col00,dl
 exit93:     sub        count2,2
             je         exit91
             dec        line_on
             dec        line_on2
             add        col_on,2
             sub        col_on2,2
             sub        col0,2
             call       dly_qrtr
             call       dly_qrtr
             call       erase1             
             mov        dl,col00
             mov        col0,dl
             dec        count1
             cmp        count1,1
             je         exit94
             mov        count1,1
 exit94:     jmp        exit41 
 exit22:     jmp        exit21
 exit81:     add        char1,2
             sub        char2,2
             cmp        char1,39
             je         exit21
             mov        line_on,4
             mov        line_on2,4
             mov        dl,char1
             inc        dl
             mov        col_on,dl
             mov        dl,char2
             dec        dl
             mov        col_on2,dl
             mov        col0,2
             mov        count1,2
             jmp        exit41
 exit01:     mov  line2,dh
             mov  col2,dl
             add  di,4
             mov  pot2,di
             mov  dl,col01
             cmp  col0,dl
             je   exit02
             add  col01,2
             mov  col,2
             mov  char01,2 
             dec  char01 
             jmp  exit410
 exit02:     jmp        exit61
 exit21:        pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax                             
             ret
 exit03:     jmp  exit01
 exit410:    mov        dh,line1
             mov        di,pot1
             mov        dl,col1
             jmp        plot_next1
 exit310:    mov        dh,line2
             mov        di,pot2
             mov        dl,col2
 ;----------------------------------------
 plot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,0ch
             push cx                    
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             dec  col
             je   exit51
             add  di,4
             jmp  plot_next1
 exit51:     cmp  char01,0
             je   exit03  ;-------------
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
             mov  col,2
             dec  char01
             jmp  exit310
must_2       endp
;----------------------------------------
 erase1      proc       near
            sub  cx,cx
            mov        cx,char_cnt
            mov        di,pointer
            mov        dh,line_on
            mov        dl,col_on
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
             add  col01,2
             mov  col,2
             mov  char01,2 
             dec  char01 
             jmp  exit4101
 exit021:    jmp        left
 exit012:    jmp  exit011

 exit4101:   mov        dh,line1
             mov        di,pot1
             mov        dl,col1
             jmp        erase_next1
 exit3101:   mov        dh,line2
             mov        di,pot2
             mov        dl,col2
 erase_next1:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             mov        al,[di]
             mov        bl,0ah
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
             je   exit011  ;-------------
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
             mov  col,2
             dec  char01
             jmp  exit3101
 left:       sub        col_on,2
             add        col_on2,2
             ret
 erase1       endp
 ;------------------------------
 ;--------------------------------------
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

