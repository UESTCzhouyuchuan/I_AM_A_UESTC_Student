extrn buf:byte,info3:byte
public change3
code segment
change3 proc far
       assume cs:code
       sub ax,ax
       mov ch,4
       mov cl,4
       mov bx,4a8fh
rotate: rol bx,cl
        mov al,bl
        and al,0fh
        add al,30h
        cmp al,3ah
        jl printit
        add al,7h
printit: mov dl,al
         mov ah,2
         int 21h
         dec ch
         jnz rotate
         mov dl,'H'
         mov ah,2
         int 21h
         ret
change3  endp
code     ends
         end 
