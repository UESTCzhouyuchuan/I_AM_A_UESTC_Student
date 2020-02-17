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
  star2      db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,1
             db 40h,0bh,12,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-10,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,8,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-6,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,4,-1
             db 02ah,0bh,0,1
             db 40h,0bh,-1,-3
             db 02ah,0bh,0,1
             db 40h,0bh,-2,-1
             db 02ah,0bh,0,1
             db 40h,0bh,1,-3
             db 02ah,0bh,0,1
  star3      db 26
             db 40h,0bh,0,0
             db 02ah,0bh,0,-1
             db 40h,0bh,12,1
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-10,1
             db 02ah,0bh,0,-1
             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,8,1
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-6,1
             db 02ah,0bh,0,-1
             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,4,1
             db 02ah,0bh,0,-1
             db 40h,0bh,-1,3
             db 02ah,0bh,0,-1
             db 40h,0bh,-2,1
             db 02ah,0bh,0,-1
             db 40h,0bh,1,3
             db 02ah,0bh,0,-1
 char_cnt1   dw ?
 pointer1    dw ?
 line_on1    db ?
 col_on1     db ?
 char_cnt2   dw ?
 pointer2    dw ?
 line_on2    db ?
 col_on2     db ?
 char        dw ?
 col         db ?
 col0        db ?
 col00       db ?
 col01       db ?
 count       db ?
 count0      db ?
 count1      db ?
 count2      db ?
 char0       db ?
 char1       db ?
 char01      db ?
 char02      db ?
 char2       db ?
 line1       db ?
 col1        db ?
 pot1        dw ?
 line2       db ?
 col2        db ?
 pot2        dw ?
 cool0       db ?
 cool1       db ?
 cool3       db ?
 count_cx    db ?
 data_seg    ends
 ;---------------------------------------
 code_seg    segment
             assume cs:code_seg,ds:data_seg
 main        proc  far
    	      HONG 
             mov   count,15
 again:
             mov   col,4
             mov   col01,4
             mov   char0,2
             mov   char01,2
             mov   char02,2
             mov   char1,39
             mov   char2,39
             mov   count0,4
             mov   count1,2
             mov   count_cx,8
             mov   cool3,4
             mov   col0,4

             lea   di,star2
             mov   dh,4
             mov   dl,2
             call  move_shape1
             lea   di,star3
             mov   dh,4
             mov   dl,76
             call  move_shape2
             call  must_21
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
;---------------------------------------------
 must_21      proc       near
                push ax
                push bx
                push cx
                push dx
                push di
                mov  ah,0fh
                int  10h
 exit710:      sub  cx,cx
             mov        col,4
             mov        col01,4
             mov        char0,2
             mov        char01,2
             mov        char02,2
             mov        cx,char_cnt1
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,col_on1
             mov        cool0,dl
             mov        count_cx,8
             jmp        plot_next10
 exit711:      sub  cx,cx
             mov        cx,char_cnt2
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,col_on2
             mov        cool1,dl
             dec        char0
             jmp        plot_next10

 exit610:    dec        count0       
             je         exit210
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       dly_qrtr
             call       erase2
             add        cool3,4
             mov        dl,cool3
             mov        col0,dl
             jmp        exit710
 exit210:       pop  di
                pop  dx
                pop  cx
                pop  bx                  
                pop  ax                             
             ret

 exit010:    mov  line2,dh
             mov  col2,dl
             add  di,4
             mov  pot2,di
             mov  dl,col01
             cmp  col0,dl
             je   exit0210
             cmp  col01,24
             je   exit730
             add  col01,4
             jmp  exit740
 exit730:    add  col01,2  
             mov  col,2
             jmp  exit700
 exit740:    mov  col,4
 exit700:    mov  char01,2 
             dec  char01 
             jmp  exit720
 exit0210:
             dec  count_cx
             je   exit610
             add  cool0,6             
             sub  cool1,6
             cmp  col0,26
             je   exit733
             mov  dl,col0
             add  dl,12
             cmp  dl,26
             jae  exit732
             mov  col0,dl
             jmp  exit733
 exit732:    mov  col0,26
             jmp  exit733
 exit720:    mov        dh,line1
             mov        di,pot1
             mov        dl,col1
             jmp        plot_next10
 exit721:    mov        dh,line2
             mov        di,pot2
             mov        dl,col2
             jmp        plot_next10
 exit733:      sub  cx,cx
             mov        col,4
             mov        col01,4
             mov        char01,2
             mov        char02,2
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,cool0
             dec        char02
             jmp        plot_next10
 exit734:      sub  cx,cx
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,cool1
             jmp        plot_next10
 exit031:      jmp  exit010
 plot_next10:
             add  dh,[di+2]
             add  dl,[di+3]
             mov  ah,2
             int  10h
             cmp  char0,0
             je   exit770
 exit770:    cmp  char01,1             
             je   exit790
             cmp  char01,0
             je   exit820
             cmp  char02,1
             je   exit790
             cmp  char02,0
             je   exit820
             cmp  dl,39
             jb   exit760
             jmp  exit780
 exit790:    cmp  dl,39
             ja   exit760
             jmp  exit780
 exit820:    cmp  dl,39
             jb   exit760
             jmp  exit780
 exit780:    mov  al,[di]     
             mov  bl,[di+1]
             push cx
             mov  cx,1
             mov  ah,09
             int  10h
             pop  cx
             jmp  exit760
 exit032:    jmp  exit031
 exit760:
             dec  col
             je   exit510
             add  di,4
             jmp  plot_next10
 exit510:    cmp  char01,0
             je   exit032   ;-------------
             cmp  char01,1
             je   exit120
             cmp  char02,1
             je   exit520
             cmp  char02,0
             je   exit032
             cmp  char0,0  
             je   exit032
             mov  line1,dh
             mov  col1,dl
             add  di,4
             mov  pot1,di
             mov  col,4     
             dec  char0
             jmp  exit711
  exit520:
             mov  line1,dh
             mov  col1,dl
             add  di,4
             mov  pot1,di
             mov  col,4     
             dec  char02
             jmp  exit734

 exit120:    mov  line1,dh
             mov  col1,dl             
             add  di,4
             mov  pot1,di
             dec  char01
             cmp  col01,26
             je   exit830
             mov  col,4
             jmp  exit721
 exit830:    mov  col,2
             jmp  exit721
  must_21    endp
 ;------------------------------------------
;-----------------------------------------
 erase2       proc       near
            mov  dl,cool3
            mov  col0,dl
            mov        col,4
            mov        col01,4
            mov        char0,2
            mov        char01,2
            mov        char02,2
            sub  cx,cx
            mov        cx,char_cnt1
            mov        di,pointer1
            mov        dh,line_on1
            mov        dl,col_on1
            mov        cool0,dl
            mov        count_cx,8
            jmp        erase_next2

exit62L:     sub  cx,cx
            mov        cx,char_cnt2
            mov        di,pointer2
            mov        dh,line_on2
            mov        dl,col_on2
            mov        cool1,dl
            dec        char0
            jmp        erase_next2

 exit011L:   mov  line2,dh
             mov  col2,dl
             add  di,4
             mov  pot2,di
             mov  dl,col01

             cmp  col0,dl
             je   exit021L

             cmp  col01,24
             je   exit013L
             add  col01,4
             jmp  exit014L
 exit013L:   add  col01,2  
             mov  col,2
             jmp  exit015L
 exit014L:   mov  col,4
 exit015L:   mov  char01,2 
             dec  char01 
             jmp  exit4101L

 exit021L:   dec  count_cx
             jne  leftL
             add        col_on1,2
             sub        col_on2,2
             ret
                         
 leftL:      add  cool0,6             
             sub  cool1,6
             cmp  col0,26
             je   exit733L
             mov  dl,col0
             add  dl,12
             cmp  dl,26
             jae  exit732L
             mov  col0,dl
             jmp  exit733L
 exit732L:   mov  col0,26
             jmp  exit733L

 exit4101L:  mov        dh,line1
             mov        di,pot1
             mov        dl,col1
             jmp        erase_next2
 exit3101L:  mov        dh,line2
             mov        di,pot2
             mov        dl,col2
             jmp        erase_next2
 exit733L:     sub  cx,cx
             mov        col,4
             mov        col01,4
             mov        char01,2
             mov        char02,2
             mov        di,pointer1
             mov        dh,line_on1
             mov        dl,cool0
             dec        char02
             jmp        erase_next2
 exit734L:     sub  cx,cx
             mov        di,pointer2
             mov        dh,line_on2
             mov        dl,cool1
             jmp        erase_next2
 exit012L:   jmp  exit011L
 erase_next2:
             add        dh,[di+2]
             add        dl,[di+3]
             mov        ah,2
             int        10h
             cmp  char0,0
             je   exit77L
             cmp  dl,39
             ja   exit76L
             jmp  exit78L
 exit77L:    cmp  char01,1             
             je   exit79L
             cmp  char01,0
             je   exit82L
             cmp  char02,1
             je   exit79L
             cmp  char02,0
             je   exit82L
 exit79L:    cmp  dl,39
             ja   exit76L
             jmp  exit78L
 exit82L:    cmp  dl,39
             jb   exit76L
             jmp  exit78L
 exit78L:    mov        al,'*'
             mov        bl,0
             push       cx
             mov        cx,1
             mov        ah,9
             int        10h
             pop        cx
  ;-------------------------------------
 exit76L:    dec        col
             je         exit07L
             add        di,4
             jmp        erase_next2

 exit018L:   jmp  exit012L

 exit07L:    cmp  char01,0
             je   exit018L  ;-------------
             cmp  char01,1
             je   exit121L
             cmp  char02,1
             je   exit01L
             cmp  char02,0
             je   exit018L  ;--------------------
             cmp  char0,0
             je   exit018L

             mov  line1,dh
             mov  col1,dl
             add  di,4
             mov  pot1,di
             mov  col,4     
             dec  char0
             jmp  exit62L
 exit01L:
             mov  line1,dh
             mov  col1,dl
             add  di,4
             mov  pot1,di
             mov  col,4     
             dec  char02
             jmp  exit734L

 exit121L:   mov  line1,dh
             mov  col1,dl
             add  di,4
             mov  pot1,di
             dec  char01
             cmp  col01,26
             je   exit122L
             mov  col,4
             jmp  exit3101L
 exit122L:   mov  col,2
             jmp  exit3101L
 erase2       endp
 ;------------------------------------------
 ;------------------------------------------
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
