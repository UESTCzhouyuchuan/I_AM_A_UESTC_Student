 data_seg    segment
 car         db 29
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,00h,0,1
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
;--------------------------------------
  jeep       db 28      
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 02ah,0bh,-1,-1
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
 char_cnt1    dw ?
 pointer1     dw ?
 line_on1     db ?
 col_on1      db ?
 char_cnt2    dw ?
 pointer2     dw ?
 line_on2     db ?
 col_on2      db ?
 col1         db ?
 col2         db ?
 char         dw ?
 char1        db ?
 char2        db ?
 char0        db ?
 char10       db ?
 count        db ?
 count_cx     dw ?
 count_cx1    dw ?
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
             mov   count_cx1,5
again1:      mov   char1,1
             mov   char2,78
             mov   count,0
             mov   char0,2
             call  clear_screen
again:       mov   count_cx,38
             lea   di,car
             mov   dh,3
             mov   dl,1
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,78
             call  move_shape2
             cmp   char0,1
             je    exit11
             call  must_2
             call  dly_qrtr
             dec   char0
             jmp   again
 exit11:     call  erase1
             dec   count_cx1
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
                mov  col1,dl
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
                mov  col2,dl
                pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax
                ret
 move_shape2    endp
;-----------------------------------------
 must_2         proc near
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
             mov        dl,col_on1    ;---1
             mov        col1,dl     
             mov        char,cx       ;---29
             jmp        plot_next
 exit9:      call       dly_qrtr
             call       erase
plot_next:   add  dh,[di+2]
             add  dl,[di+3]
             cmp  char,28
             je   exit2
             cmp  dl,char2 ;------------76
             jb   mov_crsr
             mov  count,1
             jmp  mov_crsr
 exit2:      cmp  dl,char1 ;------------3
             ja   mov_crsr
             mov  count,1
             jmp  mov_crsr
 exit5:      add  col_on1,2  
             add  char1,2
             dec  count
             dec  count_cx
             jne  exit4
             pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
 exit3:      sub  cx,cx
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,col_on2 
             mov        col2,dl  
             mov        char,cx
             jmp        plot_next
 mov_crsr:   mov  ah,2
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
             cmp  count,1
             je   exit10
             jmp  exit9
 exit10:     cmp  char,28
             je   exit5
             sub  char2,2
             sub  col_on2,2  
             dec  count
             jmp  exit3

 must_2      endp
;----------------------------------------
 erase       proc       near
            cmp  char,28
            je   exit6
 exit7:     sub  cx,cx
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col1
            mov        char,cx
            jmp        erase_next
exit6:      sub  cx,cx
            mov        cx,char_cnt2
            mov        di,pointer2
            mov        dh,line_on2
            mov        dl,col2
            mov        char,cx
erase_next:
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
             add        di,4
             loop       erase_next
             cmp        char,28
             je         left
             inc        col1
             mov        dl,col1
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             ret
 left:       dec        col2
             mov        dl,col2
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             ret                     
 erase       endp
;-----------------------------------------
;--------------$$$$$$$$$$$$----------------
erase1       proc       near
exit15:     mov  char10,10
            sub  cx,cx
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col_on1
            mov        char,cx
            jmp        erase_next1
exit14:      sub  cx,cx
            mov        cx,char_cnt2
            mov        di,pointer2
            mov        dh,line_on2
            mov        dl,col_on2
            mov        char,cx
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
             add        di,4
             loop       erase_next1

             cmp        char,28
             jz         left1
             inc        col_on1
             jmp        short exit14 
 left1:      dec        col_on2
 exit13:     dec        char10
             je         exit16
             call       dly_qrtr
             jmp        exit13
 exit16:     dec        count_cx         
             jne        exit15
             ret                     
 erase1      endp
 ;---------------------------------------
 dly_qrtr    proc       near
             push       cx
             push       dx
             mov        dx,25
 dll:        mov        cx,65500
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
