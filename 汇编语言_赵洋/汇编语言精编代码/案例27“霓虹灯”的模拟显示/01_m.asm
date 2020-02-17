 HONG        MACRO        
             push  ds
             sub   ax,ax
             sub   cx,cx
             push  ax
             push  cx
             mov   ax,data_seg
             mov   ds,ax
             HONG
             ENDM
;*************************************************
 data_seg    segment
  star       db 46
             db 02ah,0bh,0,0
             db 40h,0ch,0,1

             db 02ah,0bh,-1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,2,-1
             db 40h,0bh,0,1
             db 02ah,0bh,1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,-4,-1
             db 40h,0bh,0,1
             db 02ah,0bh,-1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,6,-1
             db 40h,0bh,0,1
             db 02ah,0bh,1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,-8,-1
             db 40h,0bh,0,1
             db 02ah,0bh,-1,-2
             db 40h,0bh,0,1
             db 02ah,0bh,10,-1
             db 40h,0bh,0,1

             db 40h,0eh,1,-1
             db 40h,0eh,-12,0

             db 40h,0bh,1,-1
             db 02ah,0bh,0,1
             db 40h,0bh,10,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-2
             db 02ah,0bh,0,1
             db 40h,0bh,-8,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-2
             db 02ah,0bh,0,1
             db 40h,0bh,6,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-2
             db 02ah,0bh,0,1
             db 40h,0bh,-4,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-2
             db 02ah,0bh,0,1
             db 40h,0bh,2,-1
             db 02ah,0bh,0,1

             db 40h,0ch,-1,-2
             db 02ah,0bh,0,1
  star1      db  16
             db 40h,0ch,0,1
             db 40h,0fh,-1,1
             db 40h,0fh,2,0
             db 40h,0fh,1,1
             db 40h,0fh,-4,0
             db 40h,0fh,-1,1
             db 40h,0fh,6,0
             db 40h,0eh,1,1
             db 40h,0eh,-8,0
             db 40h,0fh,1,1
             db 40h,0fh,6,0
             db 40h,0fh,-1,1
             db 40h,0fh,-4,0
             db 40h,0fh,1,1
             db 40h,0fh,2,0
             db 40h,0ch,-1,1
  car        db 4
             db 3eh,0bh,0,0
             db 40h,0bh,0,-1
             db 3dh,0bh,0,-1
             db 3dh,0bh,0,-1
 char_cnt1   dw ?
 pointer1    dw ?             
 line_on1    db ?
 col_on1     db ?
 char        dw ?
 count_cx    db ?
 cool        dw ?
 count       db ?
 data_seg    ends
 ;---------------------------------------
 code_seg    segment
             assume cs:code_seg,ds:data_seg
 main        proc  far
             HONG 
             mov   count,2
             mov   cool,2000
 again:
             lea   di,car
             mov   dh,10
             mov   dl,3
             call  move_shape1
             call  must_2

             lea   di,star
             mov   dh,10
             mov   dl,75
             call  move_shape1
             call  must_21

             lea   di,star1
             mov   dh,10
             mov   dl,65
             call  move_shape1
             dec   count
             call  must_2

             lea   di,star
             mov   dh,10
             mov   dl,3
             call  move_shape1
             dec   count
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
             mov    ch,4
             mov    cl,3
             mov    dh,16
             mov    dl,63
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
 must_2       proc       near
                push ax
                push bx
                push cx
                push dx
                push di
                mov  ah,0fh
                int  10h
               sub  cx,cx
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,col_on1
plot_next0:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  dl,64
             je   exit6
             cmp  dl,3
             jb   exit7  
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
             call dly_qrtr1
             loop plot_next0
             cmp  count,1
             je   exit6
  exit7:     call dly_qrtr
             call erase
             jmp  plot_next0
  exit6:     
             pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret

  must_2    endp
;---------------------------------------------
;*********************************************** 
 must_21      proc       near
                push ax
                push bx
                push cx
                push dx
                push di
                mov  ah,0fh
                int  10h
 exit5:         sub  cx,cx
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,col_on1
plot_next:
             add  dh,[di+2]
             add  dl,[di+3]
             cmp  count,0
             jne  exit8
             cmp  dl,3
             jb   exit1  
             mov  ah,2
             int  10h
             cmp  dl,64
             jae  exit2
             mov  al,[di]
             mov  bl,[di+1]
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             jmp  exit2
 exit0:      jmp  exit5
 exit8:
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
             call dly_qrtr1
             loop plot_next
             jmp  exit4
 exit2:
             add  di,4
             loop plot_next
             dec  cool
             je   exit4
             sub  dl,2
             mov  cx,char_cnt1
             mov  di,pointer1
             mov  dh,line_on1
             jmp  plot_next
 exit1:      
             call erase2
             call clear_screen
             cmp  col_on1,77
             jne  exit0

             mov  col_on1,62
             mov  cx,char_cnt1
             mov  di,pointer1
             mov  dh,line_on1
             mov  dl,col_on1
             jmp  plot_next
  exit4:
             pop  di
             pop  dx
             pop  cx
             pop  bx
             pop  ax
             ret
  must_21    endp
;********************************************
;-----------------------------------------
 erase        proc       near
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col_on1
 erase_next:
             add        dh,[di+2]
             add        dl,[di+3]
             cmp        dl,3
             jb         left0
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,03h
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
             add        di,4
             loop       erase_next
  left0:     inc        col_on1
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,col_on1
             ret

 erase        endp
;-----------------------------------------
 erase2       proc       near
            sub  cx,cx
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col_on1
 erase_next2:
             add        dh,[di+2]
             add        dl,[di+3]
             cmp        dl,3
             jb         left
             mov        ah,2
             int        10h
             cmp        dl,63
             jae        exit3
             mov        al,[di]
             mov        bl,0fh
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
 exit3:
             add        di,4
             call       dly_qrtr
             loop       erase_next2
             sub  dl,2
             mov  cx,char_cnt1
             mov  di,pointer1
             mov  dh,line_on1
             jmp        erase_next2
  left:      add        col_on1,2
             ret
 erase2       endp
 ;------------------------------------------
 dly_qrtr    proc       near
             push       cx
             push       dx
             mov        dx,25
 dll:        mov        cx,2000
 dl2:        loop       dl2
             dec        dx
             jnz        dll
             pop        dx
             pop        cx
             ret
 dly_qrtr    endp
 ;---------------------------------------
 dly_qrtr1    proc       near
             push       cx
             push       dx
             mov        dx,25
 dll1:       mov        cx,65530
 dl21:       loop       dl21
             dec        dx
             jnz        dll1
             pop        dx
             pop        cx
             ret
 dly_qrtr1    endp
 ;---------------------------------------
 code_seg    ends
             end    main
