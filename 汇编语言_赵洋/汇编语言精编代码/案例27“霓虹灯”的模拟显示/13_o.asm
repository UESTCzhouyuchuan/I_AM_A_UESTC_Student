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
 char_cnt    dw ?
 pointer     dw ?
 line_on     db ?
 col_on      db ?
 char0       db ?
 char1       db ?
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

             mov   count_cx,30  
             mov   count_cx1,3 
             mov   count_cx2,9 
             mov   char1,2
again:       
             lea   di,car
             mov   dh,3
             mov   dl,2
             call  move_shape
again1:      lea   di,car
             mov   dh,3
             mov   dl,4
             call  must_2
             dec   count_cx
             jne   again1
             lea   di,car
             mov   dh,3
             mov   dl,2
             mov   char1,2
             call  must_21
   ;-------------------------------------
             mov   count_cx,30  
             mov   count_cx1,3 
             mov   count_cx2,9 
             mov   char1,2
             lea   di,jeep
             mov   dh,3
             mov   dl,77
             call  move_shape
again2:      lea   di,jeep
             mov   dh,3
             mov   dl,75
             call  must_2
             dec   count_cx
             jne   again2
             lea   di,jeep
             mov   dh,3
             mov   dl,77
             mov   char1,2
             call  must_21
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
             je   exitr1
             cmp  dl,78
             jb   mov_crsr
             jmp  exitr2
 exitr1:     cmp  dl,1
             ja   mov_crsr
 exitr2:     pop  di
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
             je   exitr3
             cmp  dl,3
             je   exit3
             cmp  dl,5
             je   exit3
             cmp  dl,77
             je   exit3
             dec  count_cx1  
             je   exit2
             call erase
             jmp  exit3
 exit2:      mov  count_cx1,3
 exit3:      add        col_on,2
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp  short plot_next
 exitr3:
             cmp  dl,76
             je   exit3r
             cmp  dl,74
             je   exit3r
             cmp  dl,2
             je   exit3r
             dec  count_cx1  
             je   exit2r
             call erase
             jmp  exit3r
 exit2r:     mov  count_cx1,3
 exit3r:     sub        col_on,2
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        plot_next
 move_shape  endp
  ;----------------------------------------
 must_2       proc near
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

                mov  char0,dl
                mov  count_cx2,9
plot_next1:
             add  dh,[di+2]
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
             loop plot_next1
;---------------------------------
             dec  count_cx2
             je   exit21
             cmp  char_cnt,28
             je   exitr4
             add  char0,8
             jmp  exitr5
 exitr4:     sub  char0,8
 exitr5:     mov        dl,char0
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        plot_next1
 exit21:     
             cmp        char_cnt,28
             je         exitr9
             cmp        col_on,12
             je         exit1
             jmp        exit9r
 exitr9:     cmp        col_on,67
             je         exit1
 exit9r:     dec        char1 
             mov        count_cx2,9
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       erase      
             inc        char1
             mov  count_cx2,9
             jmp  plot_next1
exit1:       pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
 
 must_2      endp
;-------------------------------------
 must_21     proc near
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
plot_next2:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  char_cnt,28
             je   exitr6
             cmp  dl,78
             jb   mov_crsr2
             jmp  exit6r
 exitr6:     cmp  dl,1
             ja   mov_crsr2
 exit6r:     call erase
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
             call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             call erase
             jmp  short plot_next2
 must_21     endp
;----------------------------------------
 erase       proc       near
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             mov        dl,col_on
             mov        char0,dl
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

             cmp        char1,1
             jne        exit31
             dec        count_cx2
             je         exit31
             cmp        char_cnt,28
             je         exitr7
             add        char0,8
             jmp        exit7r
 exitr7:     sub        char0,8
 exit7r:     mov        dl,char0
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        erase_next

 exit31:     cmp        char_cnt,28
             je         exitr8
             inc        col_on
             jmp        exit8r
 exitr8:     dec        col_on
 exit8r:     mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             mov        dl,col_on
             mov        char0,dl
 exit:       ret
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

