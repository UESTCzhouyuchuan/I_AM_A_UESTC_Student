extrn info1:byte,info2:byte,bufa:byte,bufb:byte
public change2
code segment
  assume cs:code
hightolow proc near
     cmp al,'A'
     jb  stop
     cmp al,'Z'
     ja stop
     add al,20h
stop:ret
hightolow endp
change2 proc far
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
     inc si
next:mov al,[si]
     call hightolow
     mov [di],al
     inc si
     inc di
     loop next
     mov byte ptr [di] ,'$'
     lea dx,info2
     mov ah,9
     int 21h
     lea dx,bufb
     mov ah,9
     int 21h
     ret
change2 endp
  code ends
  end
     
                                    
