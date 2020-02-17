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
 char         dw ?
 char1        db ?
 char2        db ?
 char3        db ?
 char4        db ?
 count        db ?
 count_cx     dw ?
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
             mov   char1,1
             mov   char2,77
             mov   char3,2
             mov   char4,76
             mov   count,2
             call  clear_screen

again:
             mov   char1,1
             mov   char2,77
             mov   count_cx,cx
             lea   di,car
             mov   dh,3
             mov   dl,38
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,40
             call  move_shape2
             call  must_2
             dec   count
             jne   again
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
;----------------------------------------
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
 exit5:
             cmp        char1,dl
             je         exit2
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       erase
             jmp        exit4
 exit2:         cmp  count,1
                je   exit1
                cmp  char1,37
                je   exit1
                add  char1,2
                sub  char2,2
                add  char3,2
                mov  dl,char3
                mov  col_on1,dl
                sub  char4,2
                mov  dl,char4
                mov  col_on2,dl
                call dly_qrtr
                jmp  exit4
 exit1:         call erase
                pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax                             
             ret
 plot_next:  add  dh,[di+2]
             add  dl,[di+3]
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
             cmp  char,28
             je   short exit5
             jmp  exit3
must_2       endp
;---------------------------------------------
erase       proc       near
            sub  cx,cx
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col_on1
            mov        char,cx
            jmp        erase_next

exit6:      sub  cx,cx
            mov        cx,char_cnt2
            mov        di,pointer2
            mov        dh,line_on2
            mov        dl,col_on2
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
          ;---------------------------
             cmp        char,28
             jz         left
             inc        col_on1
             mov        dl,col_on1
             jmp        short exit6 
 left:       dec        col_on2
             mov        dl,col_on2
             ret

 erase       endp
;-----------------------------------------
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
