 data_seg    segment

 line_on1    db ?
 col_on1     db ?
 line_on2    db ?
 col_on2     db ?
 char        db ?
 count       db ?
 count0      db ?
 count1      db ?
 char0       db ?
 cool0       db ?
 cool1       db ?
 cool2       db ?
 count_cx    dw ?
 data_seg    ends
;--------------------------------------------
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
             mov   count,2
             mov   char0,4
             mov   cool1,0eh
             mov   cool2,0ah
             mov   count0,8
             mov   count1,10
 again:      call  clear_screen
             mov   line_on1,4
             mov   col_on1,4
             call  must_2
             mov   count,1
 again1:             
             mov   line_on1,4
             mov   col_on1,4
             call  must_21
             cmp   count,1
             jne   exit0
             mov   cool1,0eh
             mov   cool2,0ah
             inc   count
             jmp   exit12
 exit0:      mov   cool1,0ch
             mov   cool2,03h
             dec   count
 exit12:     dec   count1
             jne   again1

             mov   line_on1,4
             mov   col_on1,4
             mov   line_on2,16
             mov   col_on2,3
             call  must_22
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
             mov    cl,4
             mov    dh,16
             mov    dl,74
             mov    bh,7
             int    10h
             pop     dx
             pop     cx
             pop     bx
             pop     ax
             ret
 clear_screen  endp
 ;-----------------------------------------
 ;----------------------------------------------
 must_2       proc near
                push ax
                push bx
                push dx
                mov  ah,0fh
                int  10h
                mov  cool0,1
  plot_next:
             mov  dh,line_on1
             mov  dl,col_on1
             mov  ah,2
             int  10h
             mov  al,40h
             mov  bl,0ch
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             call dly_qrtr
             call dly_qrtr
             call dly_qrtr
             mov  dl,cool0
             cmp  char0,dl
             je   exit3
             call erase
             jmp  plot_next

 exit3:      cmp  col_on1,74
             je   exit1
             cmp  col_on1,38
             jne  exit7
             add  col_on1,2
             mov  cool0,1
             mov  line_on1,4
             jmp  plot_next

 exit7:      add  col_on1,2
             mov  cool0,1
             mov  line_on1,4
             cmp  count,1
             je   exit5
             cmp  char0,5
             je   exit4
             inc  char0
             jmp  plot_next
 exit5:      cmp  char0,1
             je   exit6
             dec  char0
             jmp  plot_next
 exit4:      dec  count
             dec  char0
             jmp  plot_next
 exit6:      inc  count
             inc  char0
             jmp  plot_next
 exit1:       
             pop  dx
             pop  bx
             pop  ax
 must_2     endp
;----------------------------------------
  must_21    proc near
                push ax
                push bx
                push dx
                mov  ah,0fh
                int  10h
 plot_next1:
             mov  dh,line_on1
             mov  dl,col_on1
             mov  ah,2
             int  10h
             mov  ah,8
             int  10h

             cmp  al,' '
             je   exit9
             cmp  al,40h
             jne  exit10
             mov  bl,cool1
             jmp  exit11
 exit10:     mov  al,'*'    
             mov  bl,cool2
 exit11:     push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
 exit9:      cmp  col_on1,74
             je   exit8 
             add  col_on1,2
             jmp  plot_next1
 exit8:      call dly_qrtr
             dec  count0
             jne  exit8
             mov  count0,10
             mov  col_on1,4             
             inc  line_on1
             cmp  line_on1,9
             jne  plot_next1
             pop  dx
             pop  bx
             pop  ax
             ret
 must_21   endp
;---------------------------------------
;----------------------------------------
 must_22      proc near
                push ax
                push bx
                push dx
             mov  count,10
             mov  dh,line_on1
             mov  dl,col_on1
 plot_next2:
             mov  ah,2
             int  10h
             mov  al,40h    
             mov  bl,0ch
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             cmp  char,1
             je   exit17
             cmp  dl,74
             je   exit19
             jmp  exit18
 exit17:     cmp  dl,75
             je   exit19
 exit18:     add  dl,2
             jmp  plot_next2

 exit19:     cmp  char,1
             je   exit14
             mov  dh,line_on2
             mov  dl,col_on2
             dec  char
             jmp  plot_next2

 exit14:     cmp  line_on2,4
             je   exit16
             call dly_qrtr
             dec  count
             jne  exit14
             call erase1
             mov  dh,line_on1
             mov  dl,col_on1
             mov  char,2
             mov  count,10
             call dly_qrtr
             jmp  plot_next2
 exit16:     pop  dx
             pop  bx
             pop  ax
             ret
  must_22  endp
 ;-------------------------------------------------
 erase       proc       near
             mov        dh,line_on1
             mov        dl,col_on1
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,03h
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
             inc        cool0
             inc        line_on1
             ret
 erase       endp
;-----------------------------------------
 erase1       proc       near
             mov        char,2
             mov        dh,line_on1
             mov        dl,col_on1
 erase_next:
             mov        ah,2
             int        10h
             mov        al,'*'
             mov        bl,03h
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
             cmp        char,1
             je         exit20
             cmp        dl,74
             je         left
             jmp        exit21
 exit20:     cmp        dl,75
             je         left
 exit21:     add        dl,2
             jmp        erase_next
 left:       cmp        char,1
             je         exit15
             mov        dh,line_on2
             mov        dl,col_on2
             dec        char
             jmp        erase_next
 exit15:     inc        line_on1
             dec        line_on2
             mov        col_on1,4
             mov        col_on2,3
             ret
 erase1       endp
;-----------------------------------------
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

