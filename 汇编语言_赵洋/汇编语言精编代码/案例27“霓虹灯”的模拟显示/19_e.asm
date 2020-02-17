 data_seg    segment
  car        db 2
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
  jeep       db 2      
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
  star2      db 8
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 02ah,0bh,0,1
             db 02ah,0bh,-1,0
             db 40h,0bh,0,1
             db 40h,0bh,1,0
             db 02ah,0bh,0,1
             db 02ah,0bh,-1,0
  star3      db 8
             db 40h,0bh,0,0
             db 40h,0bh,1,0
             db 02ah,0bh,0,-1
             db 02ah,0bh,-1,0
             db 40h,0bh,0,-1
             db 40h,0bh,1,0
             db 02ah,0bh,0,-1
             db 02ah,0bh,-1,0
  star       db 2
             db 40h,0bh,0,0
             db 02ah,0,0,1
  star1      db 2      
             db 40h,0bh,0,0
             db 02ah,0,0,-1
 char_cnt    dw ?
 pointer     dw ?
 line_on     db ?
 col_on      db ?
 char0       db ?
 char1       db ?
 char2       db ?
 count       db ?
 count0      db ?
 count1      db ?
 count_cx    dw ?
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

             mov   count0,4
             mov   count,5
             mov   count1,3
             mov   char1,4
             mov   char2,6
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

 again2:     mov   char0,4
 again1:     dec   char0
             je    exit0
             lea   di,star2
             mov   dh,char1
             mov   dl,2
             add   char1,4
             call  must_2
             dec   char0
             je    exit0
             lea   di,star3
             mov   dh,char2
             mov   dl,76
             add   char2,7
             call  must_2
             jmp   again1

 exit0:      dec   count1
             je    exit02
             dec   char1
             lea   di,jeep
             mov   dh,10
             mov   dl,76
             call  must_2
             dec   count1
             jmp   again2

 exit02:     mov   count,5
             mov   count0,4
             mov   count1,3
             mov   char1,4
             mov   char2,6
             dec   count_cx
 again25:    mov   char0,4
 again15:    dec   char0
             je    exit05
             lea   di,star3
             mov   dh,char1
             mov   dl,75
             add   char1,4
             call  must_2
             dec   char0
             je    exit05
             lea   di,star2
             mov   dh,char2
             mov   dl,3
             add   char2,7
             call  must_2
             jmp   again15

 exit05:     dec   count1
             je    exit025
             dec   char1
             lea   di,car
             mov   dh,10
             mov   dl,3
             call  must_2
             dec   count1
             jmp   again25
 exit025:    pop   cx
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
                cmp  count_cx,1
                je   plot_next2
plot_next1:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  char0,2
             je   exit12
             cmp  count1,2
             je   exit12
             cmp  dl,78
             jb   mov_crsr1
             sub  dl,2
             jmp  exit13
exit12:      cmp  dl,0
             ja   mov_crsr1
             add  dl,2
             jmp  exit13
exit13:      pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
plot_next2:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  char0,2
             je   exit122
             cmp  count1,2
             je   exit122
             cmp  dl,2
             ja   mov_crsr2
             add  dl,2
             jmp  exit13
exit122:     cmp  dl,76
             jb   mov_crsr2
             sub  dl,2
             jmp  exit13
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
             loop plot_next1
             jmp  exit41
 mov_crsr2:
             mov  ah,2
             int  10h
             mov  al,[di]
             mov  bl,0
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             add  di,4
             loop plot_next2
 exit41:     dec  count
             je   exit31
             call dly_qrtr
             jmp  exit41
 exit31:     cmp  count_cx,1
             je   exit51
             call erase1
             mov  count,5
             jmp  plot_next1
 exit51:     call erase2
             mov  count,5
             jmp  plot_next2
 must_2     endp
;--------------------------------------------
 erase       proc       near
             cmp        count0,4
             jne        exit6
             add        col_on,2
             jmp        exit
 exit6:      cmp        count0,3
             jne        exit7
             sub        col_on,2
             jmp        exit
 exit7:      cmp        count0,2
             jne        exit8
             inc        line_on
             jmp        exit
 exit8:      cmp        count0,1
             jne        exit
             dec        line_on
 exit:       mov        dh,line_on
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             ret
 erase       endp
 ;--------------------------------
 erase1       proc       near
             cmp        char0,2
             je         exit15
             cmp        char0,3
             je         exit14
             cmp        char0,1
             je         exit14
             cmp        count1,2
             je         exit16
             jmp        exit01
 exit14:     add        col_on,4
             jmp        exit01
 exit15:     sub        col_on,4
             jmp        exit01
 exit16:     sub        col_on,2
 exit01:     mov        dh,line_on
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             ret
 erase1       endp
 ;------------------------------------------------
 erase2       proc       near
             cmp        char0,2
             je         exit152
             cmp        char0,3
             je         exit142
             cmp        char0,1
             je         exit142
             cmp        count1,2
             je         exit162
             jmp        exit012
 exit142:    sub        col_on,4
             jmp        exit012
 exit152:    add        col_on,4
             jmp        exit012
 exit162:    add        col_on,2
 exit012:    mov        dh,line_on
             mov        dl,col_on
             mov        cx,char_cnt
             mov        di,pointer
             ret
 erase2       endp
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

