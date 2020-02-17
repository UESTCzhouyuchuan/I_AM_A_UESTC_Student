extrn info1:byte,info2:byte,bufa:byte,bufb:byte,info0:byte
public change1
code segment
  assume cs:code
lowtohigh proc near
   cmp al,'a'
   jb stop
   cmp al,'z'
   ja stop
   sub al,20h
stop :ret
lowtohigh endp
change1 proc far
   lea dx,info0
   mov ah,9
   int 21h

   lea dx,info1
   mov ah,9
   int 21h
   lea dx,bufa
   mov ah,10
   int 21h
   lea si,bufa+1
   lea di,bufb
   mov ch,0
   mov cl,[si]
   add si,1
next:mov al,[si]
     call lowtohigh
     mov [di],al
     inc si
     inc di
     loop next
     mov byte ptr [di],'$'
     lea dx,info2
     mov ah,9
     int 21h
     lea dx,bufb
     mov ah,9
     int 21h
     ret
change1 endp
  code ends
  end 

