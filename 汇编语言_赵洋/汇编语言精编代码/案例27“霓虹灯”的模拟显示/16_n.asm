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
 char_cnt    dw ?
 pointer     dw ?
 line_on     db ?
 col_on      db ?
 char0       db ?
 char1       db ?
 count_cx    dw ?
 count_cx1   dw ?
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
             mov   count_cx,80  
             mov   count_cx1,5 
             mov   char1,2
             call  clear_screen
again:       lea   di,car
             mov   dh,3
             mov   dl,2
             call  move_shape
again1:      lea   di,car
             mov   dh,3
             mov   dl,4
             call  move_shape1
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
                mov  char_cnt,cx
                mov  pointer,di
                mov  line_on,dh
                mov  col_on,dl
plot_next:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  dl,78
             jb   mov_crsr
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
             call dly_qrtr
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
 exit2:      mov  count_cx1,5
 exit3:      add        col_on,2
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp  short plot_next
 move_shape  endp
  ;----------------------------------------
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
                mov  char0,dl
                mov  count_cx1,5
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
             dec  count_cx1
             je   exit21
             add  char0,14
             mov        dl,char0
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        plot_next1      

 exit21:     call       dly_qrtr
             cmp        col_on,18
             je         exit1
             mov        count_cx1,5
             add        col_on,2
             mov        dl,col_on
             mov        char0,dl
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        plot_next1
exit1:
             dec        char1 
             mov        count_cx1,5
             mov        dl,char0
             mov        col_on,dl
             call       erase
             inc        char1
             pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
 move_shape1  endp
;-------------------------------------
;---------------------------------------
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
             dec        count_cx1
             je         exitr
             sub        char0,14
             mov        dl,char0
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             jmp        erase_next

 exit31:     inc        col_on
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             mov        dl,col_on
             mov        char0,dl
             ret
 exitr:      sub        col_on,2
             mov        cx,char_cnt
             mov        di,pointer
             mov        dh,line_on
             mov        dl,col_on
             mov        char0,dl
             mov        count_cx1,5
             cmp        col_on,60
             jne        erase_next
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

