public change4
data segment
buf db 0ah,0dh,'please input the four  hexnumber:$'
data ends
code segment
     assume cs:code,ds:data
change4 proc far
       mov ax,data
       mov ds,ax
       lea dx,buf
       mov ah,9
       int 21h
       mov bx,0
       mov ch,4
input: mov cl,4
       sal bx,cl
       mov ah,1
       int 21h
       cmp al,39h
       ja af
       and al,0fh
       jmp binary
af:    and al,0fh
       add al,9
binary: or bl,al
        dec ch
        cmp ch,0
        jne input
        mov dl,'H'
        mov ah,2
        int 21h
        mov dl,0ah
        mov ah,2
        int 21h
        mov dl,0dh
        mov ah,02
        int 21h
       mov cx,16
disp:  mov dl,0
       rol bx,1
       rcl dl,1
       or dl,30h
       mov ah,02h
       int 21h
       loop disp
       mov dl,'B'
       mov ah,2
       int 21h
       ret
change4 endp
code  ends
      end 

