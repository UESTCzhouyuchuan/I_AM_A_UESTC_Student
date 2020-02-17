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
  star       db 1
             db 02ah,0ch,0,0
 char_cnt    dw ?
 pointer     dw ?
 line_on     db ?
 col         db ?
 col_on      db ?
 char0       db ?
 char1       db ?
 char2       db ?
 char3       db ?
 char4       db ?
 count_cx    dw ?
 count_cx1   dw ?
 count_cx2   dw ?
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
             mov   col,1
             mov   char0,2
             mov   char1,7
             mov   char2,74
             mov   char3,4
             mov   char4,16
             mov   count_cx,5
             mov   count_cx1,5
             mov   count_cx2,6
             call  clear_screen
again:       lea   di,car
             mov   dh,3
             mov   dl,2
             call  move_shape
             lea   di,jeep
             mov   dh,3
             mov   dl,73
             call  move_shape
             lea   di,star
             mov   dh,4
             mov   dl,8
             call  move_shape1
             lea   di,jeep
             mov   dh,3
             mov   dl,76
             call  move_shape2
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
                mov  char_cnt,cx
                mov  pointer,di
                mov  line_on,dh
                mov  col_on,dl
plot_next:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  char_cnt,28
             je   exit1
             cmp  dl,77
             jb   mov_crsr
             jmp  exit2
 exit1:      cmp  dl,5
             ja   mov_crsr
 exit2:      pop  di
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
             call dly_qrtr

             cmp  char_cnt,28
             je   exit3

             cmp  dl,3
             je   exit4
             cmp  dl,5
             je   exit4
             cmp  dl,77
             je   exit4
             dec  count_cx1  
             je   exit7
             call erase
             jmp  exit4
 exit7:      mov  count_cx1,5
 exit4:      add        col_on,2
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp  short plot_next
 exit3:   
             dec  count_cx2 
             je   exit5
             call erase
             jmp  exit6      
 exit5:      sub        col_on,2
             mov        count_cx2,6
 exit6:      sub        col_on,2
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        plot_next

 move_shape  endp
;---------------------------------------
 move_shape1     proc near
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
                mov  char0,2
plot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  char0,1
             je   exit0
             cmp  dl,18
             je   exit8
             cmp  dl,32
             je   exit8
             cmp  dl,46
             je   exit8
             cmp  dl,60
             je   exit8
             cmp  dl,char2
             je   exit9
             jmp  mov_crsr1
  exit9:     dec  dl
             inc  dh
             cmp  dh,char4
             je   exit18      
             jmp  mov_crsr1
  exit8:     add  dl,4
             jmp  mov_crsr1
  exit18:    dec  char0
  exit0:     cmp  dl,63
             je   exit10
             cmp  dl,49
             je   exit10
             cmp  dl,35
             je   exit10
             cmp  dl,21
             je   exit10
             cmp  dl,char1
             je   exit11
             jmp  mov_crsr1
 exit10:     sub  dl,4
             jmp  mov_crsr1
 exit11:     inc  dl
             dec  dh
             cmp  dh,char3
             je   exit12
             jmp  mov_crsr1
 exit12:     inc  char3
             dec  char4
             inc  char1
             cmp  char1,18
             jne  exit13
             add  char1,4
 exit13:     dec  char2
             cmp  char2,63
             jne  exit14
             sub  char2,4
 exit14:     mov  dh,char3
             mov  dl,char1
             inc  char0
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
 exit19:     dec  count_cx
             je   exit20
             call dly_qrtr
             jmp  exit19
 exit20:     mov  count_cx,5
             cmp  char0,1
             je   exit15
             inc  dl
             cmp  dh,10
             je   exit16
             jmp  plot_next1
 exit16:     cmp  dl,68
             je   exit17
             jmp  plot_next1
 exit15:     dec  dl            
             jmp  plot_next1
 exit17:     pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
 move_shape1  endp
;-----------------------------------------------
 move_shape2     proc near
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
                dec  col
plot_next2:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  dl,1
             ja   mov_crsr2
             call erase
             pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
 mov_crsr2:
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
             loop plot_next2
             call dly_qrtr
             call erase
             jmp  short plot_next2
 move_shape2  endp
;----------------------------------------
;-----------------------------------------------
 erase       proc       near
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             mov        dl,col_on
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
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             cmp        char_cnt,28
             je         exit
             inc        col_on
             mov        dl,col_on
             ret
 exit:       cmp        col,0
             jne        left
             dec        col_on
             mov        dl,col_on
 left:       ret
 erase       endp
;----------------------------------------------
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
 ;---------------------------------

