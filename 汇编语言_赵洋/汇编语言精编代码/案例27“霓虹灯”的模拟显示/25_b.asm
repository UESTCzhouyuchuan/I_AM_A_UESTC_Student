
 data_seg    segment
  car        db 2						;用于写方框左竖杠图形的字符组
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
  jeep       db 2  						;用于写方框右竖杠图形的字符组    
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
  star       db 2						;用于写方框上横杠图形的字符组
             db 40h,0bh,0,0
             db 02ah,0,0,1
  star1      db 2   						;用于写方框下横杠图形的字符组   
             db 40h,0bh,0,0
             db 02ah,0,0,-1

  car1       db 2						;用于从左向右写的运动字符组
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
  jeep1      db 2                                               ;用于从左向右写的运动字符组
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
 char_cnt     dw ?
 pointer      dw ?
 line_on      db ?
 col_on       db ?
 char_cnt1    dw ?
 pointer1     dw ?
 line_on1     db ?
 col_on1      db ?
 char_cnt2    dw ?
 pointer2     dw ?
 line_on2     db ?
 col_on2      db ?
 col          db ?
 char0        db ?
 char         db ?
 char1        db ?
 char2        db ?
 count0       db ?
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

             mov   char,2
             mov   char0,2
             mov   char1,16
             mov   char2,4
             mov   count_cx,13
             call  clear_screen
             mov   count,5
             mov   count0,4

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

 again1:     mov   count,5
             mov   char2,4
             mov   char,2
             mov   char0,2
             lea   di,car1
             mov   dh,4
             mov   dl,2
             call  move_shape1

             lea   di,jeep1
             mov   dh,4
             mov   dl,76
             call  move_shape2
             call  must_2
             dec   count_cx
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
                mov  char_cnt,cx
                mov  pointer,di
                mov  line_on,dh
                mov  col_on,dl
plot_nextR:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  count0,3
             je   exit2R
             cmp  count0,2
             je   exit9R
             cmp  count0,1
             je   exit10R
             cmp  dl,78
             jb   mov_crsrR
             jmp  exit1R
exit2R:      cmp  dl,1
             jnb  mov_crsrR
             jmp  exit1R
exit9R:      cmp  dh,17
             jb   mov_crsrR
             jmp  exit1R
exit10R:     cmp  dh,3
             ja   mov_crsrR
exit1R:      pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
 mov_crsrR:
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
             loop plot_nextR
 exit4R:     dec  count
             je   exit3R
             call dly_qrtr
             jmp  exit4R
 exit3R:     call erase1
             mov  count,5
             jmp  short plot_nextR
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
                pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax
                ret
 move_shape2    endp
;-----------------------------------------
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
             jmp        plot_next
 exit3:      sub  cx,cx
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,col_on2
             jmp        plot_next

 exit5:      dec  count
             je   exit7
             call dly_qrtr
             jmp  exit5
 exit7:      inc  char
             call erase
             mov  count,5
             cmp  char0,1
             jne  exit11
             inc  char0
 exit11:     jmp        short exit4

 plot_next:  add  dh,[di+2]
             add  dl,[di+3]
             cmp  dh,char1 
             jne  mov_crsr1   
             dec  char2
             jmp  mov_crsr1
 exit2:         pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax                             
             ret
 exit10:     call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             jmp  exit4
 mov_crsr1:                 
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

             cmp  char,1
             je   exit8
             dec  char
             jmp  exit3
 exit8:      cmp  char2,0
             je   exit9
             cmp  dl,39   
             jne  exit5
             dec  char0
             jmp  exit5
 exit9:      cmp  col_on2,2
             je   exit12
             add  col_on1,2
             sub  col_on2,2
             mov  char2,4
             inc  char
             jmp  exit10
 exit12:     dec  char1
             jmp  exit2
must_2       endp
;--------------$$$$$$$$$$$$----------------
erase       proc       near
            sub  cx,cx
            mov        cx,char_cnt1                             
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col_on1
            jmp        erase_next

exit6:      sub  cx,cx
            mov        cx,char_cnt2
            mov        di,pointer2
            mov        dh,line_on2
            mov        dl,col_on2
            jmp        erase_next
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
             cmp        char0,1
             je         left1
             cmp        char,1
             jz         left
             inc        col_on1
             dec        char
             jmp        short exit6
 left:       dec        col_on2
             inc        char
             ret
 left1:      cmp        char,1
             jz         left2
             inc        line_on1
             dec        char
             jmp        short exit6
 left2:      inc        line_on2
             inc        char
             ret
 erase       endp
;-----------------------------------------
;--------------------------------------------
 erase1       proc       near
             cmp        count0,4
             jne        exit6R
             add        col_on,2
             jmp        exitR
 exit6R:     cmp        count0,3
             jne        exit7R
             sub        col_on,2
             jmp        exitR
 exit7R:     cmp        count0,2
             jne        exit8R
             inc        line_on
             jmp        exitR
 exit8R:     cmp        count0,1
             jne        exitR
             dec        line_on
 exitR:      mov        dh,line_on
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             ret
 erase1       endp
;------------------------------------------
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
