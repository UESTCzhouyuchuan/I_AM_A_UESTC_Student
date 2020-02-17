data     segment
car      db 133                 ；定义字符图形表
         db 05h,122,0,0
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1  
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,0,3
         db 05h,122,1,0
         db 05h,122,2,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,-8,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,0,7
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0 
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0 
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1 
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,2,2
         db 05h,122,0,1
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,0,-1 
         db 05h,122,-2,0
         db 05h,122,2,2
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-2,0
         db 05h,122,0,6
         db 05h,122,3,0
         db 05h,122,0,1  
         db 05h,122,-3,0
         db 05h,122,-3,1
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,0,2
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,-1,-2
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,-1,-2
         db 05h,122,-1,0
         db 05h,122,-1,0
         db 05h,122,0,9 
         db 05h,122,1,-3 
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,0,1
         db 05h,122,2,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,1,0
         db 05h,122,0,4
         db 05h,122,1,0
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,0,-1
         db 05h,122,1,2
         db 05h,122,1,0   
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,1,0
         db 05h,122,-3,-1
         db 05h,122,0,2
         db 05h,122,1,1
         db 05h,122,0,-4
         db 05h,122,1,-1
         db 05h,122,0,6
char_cnt dw ?               
pointer  dw ?
line_on  db ?
col_on   db ?
data     ends
stack    segment
         db  2000 dup (0)
stack    ends
code     segment
         assume cs:code,ds:data,ss:stack
main proc  far
     push  ds
     sub   ax,ax
     push  ax
     mov   ax,data
     mov   ds,ax
     
　　 mov   ah,0
     mov   al,4
     int   10h
     
     mov   ah,0bh
     mov   bh,0
     mov   bl,2
     int   10h
     
     mov   ah,0bh
     mov   bh,01
     mov   bl,00
     int   10h
     
     call  clear_screen       ；调用清屏子程序
     lea   di,car
     mov   dh,10
     mov   dl,2
     call  move_shape         
     mov   ah,8
     int   21h
     cmp   al,'q'
     jz    exit
     main endp  

clear_screen proc near
     push  ax
     push  bx
     push  cx
     push  dx
     mov   ah,6
     mov   al,0
     mov   ch,0
     mov   cl,0
     mov   dh,120
     mov   dl,200
     mov   bh,7
     int   10h
     pop   dx
     pop   cx
     pop   bx
     pop   ax
     ret
clear_screen endp

move_shape proc near
     push  ax
     push  bx
     push  cx
     push  dx
     push  di
     mov   ah,0fh
     int   10h
     sub   ch,ch
     mov   cl,[di]
     inc   di
     mov   char_cnt,cx
     mov   pointer,di
     mov   line_on,dh
     mov   col_on,dl
mov_crsr: 
     add   dh,[di+2]
     add   dl,[di+3]
     mov   ah ,2
     int   10h
     mov   al,[di]
     mov   bl,[di+1]
     push  cx
     mov   cx,1
     mov   ah,09
     int   10h
     pop   cx
     add   di,4
     loop  mov_crsr
     call  dly_qrtr　　　　　；调用延时子程序
     pop   di         
     pop   dx
     pop   cx
     pop   bx
     pop   ax
     ret
move_shape endp

dly_qrtr proc near       
     push  cx
     push  dx
     mov   dx,5000
 d11:mov   cx,25000  
 d12:loop d12
     dec   dx
     jnz   d11
     pop   dx
     pop   cx
     ret
dly_qrtr endp
exit:mov   ah,4ch
     int   21h
code ends
     end main



