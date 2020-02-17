public  info1,info2,bufa,bufb,buf,main,info0,info3
extrn  change1:far,change2:far,change3:far,change4:far
data segment
info0  db 0ah,0dh,'this is the change of letter to leter:$' 
info1  db 0ah,0dh,'please input string:$'
info2  db 0ah,0dh,'output string:$'
bufa   db  81
       db ?
       db 80 dup (?)
bufb  db 80 dup (?)
info3 db 0ah,0dh,'this is the change of digital to digital:',0ah,0dh,'$'
buf   db 0dh,0ah,'the number is:0100101010001111b',0ah,0dh,'the result is:$'
data ends
stack segment stack
     db 200 dup (?)
stack ends
code segment
main proc far
      assume ds:data,cs:code,ss:stack
      mov ax,data
      mov ds,ax
      
disp  macro m
      lea dx,m
      mov ah,9
      int 21h
      endm
      call change1
      call change2
      disp info3
      
      disp  buf
      call change3
      call change4
      ret
main endp
code ends
     end 

