 data_seg    segment
 car         db 29
             db 40h,0bh,0,0
             db 14 dup(40h,0bh,1,0)
             db 40h,00h,0,1
             db 13 dup(02ah,0bh,-1,0)
;--------------------------------------
  jeep       db 28      
             db 40h,0bh,0,0
             db 14 dup(40h,0bh,1,0)
             db 02ah,0bh,-1,-1
             db 12 dup(02ah,0bh,-1,0)
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
 char0        db ?
 char10       db ?
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
             mov   char1,3
             mov   char2,77
             mov   char0,38
             mov   count_cx,2
             call  clear_screen
again:       
             lea   di,car
             mov   dh,3
             mov   dl,39
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,41
             call  move_shape2
             call  must_2
             cmp   char1,40
             jb    again

             dec   count_cx
             call  dly_qrtr
             call  dly_qrtr
             lea   di,car
             mov   dh,3
             mov   dl,40
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,40
             call  move_shape2
             call  erase
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

 exit5:      call       dly_qrtr
             call       erase
             jmp        exit4

 plot_next:  add  dh,[di+2]
             add  dl,[di+3]
             cmp  char,28
             je   exit1
             cmp  dl,char2
             jb   mov_crsr 
             jmp  exit2
 exit1:      cmp  dl,char1
             ja   mov_crsr
 exit2:      mov  ah,2
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
             jne  short exit3
             add  char1,2
             sub  char2,2
                pop  di
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
             cmp  char,28
             je   exit5
             jmp  exit3
must_2       endp
;---------------------------------------------
;--------------$$$$$$$$$$$$----------------
erase       proc       near
exit7:      mov  char10,10
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

             cmp        char,28
             jz         left
             inc        col_on1
             jmp        short exit6 
 left:       dec        col_on2
             cmp        count_cx,1
             jne        exit8
exit9:       dec        char10
             je         exit10
             call       dly_qrtr
             jmp        exit9
exit10:      dec        char0           
             jne        exit7
 exit8:      ret                     
 erase       endp
;-----------------------------------------
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
