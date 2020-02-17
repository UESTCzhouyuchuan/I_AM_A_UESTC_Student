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
  star2      db 18
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,3,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 40h,0bh,3,0
             db 40h,0bh,1,0
             db 40h,0bh,1,0
             db 02ah,0bh,0,1
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-3,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-3,0
             db 02ah,0bh,-1,0
             db 02ah,0bh,-1,0
  star3      db 8
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 40h,0bh,4,0
             db 40h,0bh,1,0
             db 02ah,0bh,0,-1
             db 02ah,0bh,-1,0
             db 02ah,0bh,-4,0
             db 02ah,0bh,-1,0
 char_cnt1    dw ?
 pointer1     dw ?
 line_on1     db ?
 col_on1      db ?
 char_cnt2   dw ?
 pointer2    dw ?
 line_on2    db ?
 col_on2     db ?
 count       db ?
 count0      db ?
 count1      db ?
 count_cx    db ?
 char        dw ?
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
             mov   count,5
             mov   count0,4
             mov   count1,2
             mov   count_cx,2
again:    
             call  clear_screen
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
     ;-------------------------------
 again1:     lea   di,star2
             mov   dh,4
             mov   dl,2
             call  move_shape1
             lea   di,star3
             mov   dh,7
             mov   dl,76
             call  move_shape2
             call  must_2
             dec   count1
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
;----------------------------------------
 must_2      proc       near
                push ax
                push bx
                push cx
                push dx
                push di
                mov  ah,0fh
                int  10h
 exit4m:     sub  cx,cx
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,col_on1
             mov        char,cx
             jmp        plot_next2
 exit3m:      sub  cx,cx
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,col_on2
             mov        char,cx
             jmp        plot_next2

 plot_next2: add  dh,[di+2]
             add  dl,[di+3]
             cmp  char,8
             je   exit1m
             cmp  dl,78
             jb   mov_crsr2
             jmp  exit2m
 exit1m:     cmp  dl,0
             ja   mov_crsr2
 exit2m:     
                pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax                             
             ret
 mov_crsr2:
             mov  ah,2
             int  10h
             cmp  count1,1
             je   exit5
             mov  al,[di]
             mov  bl,[di+1]
             jmp  exit11
 exit5:      mov  al,[di]
             mov  bl,0
 exit11:     push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             add  di,4
             loop plot_next2
             cmp        char,8
             je         short exit5m
             jmp        exit3m
 exit5m:     dec        count
             je         exit6m
             call       dly_qrtr
             jmp        exit5m
 exit6m:     add        col_on1,2
             sub        col_on2,2
             mov        count,5
             jmp        exit4m
must_2       endp
;---------------------------------------------
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
 dly_qrtr    proc       near
             push       cx
             push       dx
             mov        dx,25
 dll:        mov        cx,65000
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

