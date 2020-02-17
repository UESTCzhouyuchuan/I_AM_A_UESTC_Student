data    segment
mess1   db '          student grade management system',0ah,0dh,'$'
mess2   db '   this is main menu',0ah,0dh,'$'
mess3   db '    insert  (i)         please input:',0ah,0dh,'$' 
mess4   db '    modify  (m)         name    :',0ah,0dh,'$'
mess5   db '    delete  (d)         maths   :',0ah,0dh,'$'
mess6   db '    query   (q)         english :',0ah,0dh,'$'
mess7   db '    count   (c)         computer:',0ah,0dh,'$'
mess8   db '    print   (p)         chinese :',0ah,0dh,'$'
mess9   db '    exit    (e)',0ah,0dh,'$'
mess10  db '**********************************************************$'
mess11  db 'name            Ma   En   Co   Ch',0ah,0dh,'$'
mess13  db '    list    (l)',0ah,0dh,'$'
mess12  db 'maths  <60  <70  <80  <90  <100',0ah,0dh,'$'
err1    db ' there is not this student$'
err2    db ' file close wrong$'

fname   db "e:\hbyy\score.txt"

buffer1 db 23 dup(?)
buffeer db 0ah,0dh,'$'
buffer2 db 30 dup(?)
buffer3 db 8 dup('0')
count   db 5
handle  dw ?
del     db 8 dup('0')
x       db ?
data    ends

score struc
names    db 15 dup(' ')
maths    db 0,0
english  db 0,0
computer db 0,0
chinese  db 0,0
score ends

show macro addrs
        lea dx,addrs
        mov ah,9
        int 21h
        endm

set_p1 macro  a
        mov ah,2
        mov dh,a
        mov dl,36
        mov bh,0
        int 10h
        endm

set_p2 macro
       mov ah,2
       mov dh,12
       mov dl,2
       mov bh,0
       int 10h
       endm
set_p3 macro
       mov ah,2
       mov dh,1
       mov dl,30
       mov bh,0
       int 10h
       endm

clear  macro                        ;all screen
       mov al,0
       mov cl,0
       mov ch,0
       mov dh,24
       mov dl,79
       mov bh,7
       mov ah,6
       int 21h
       endm

clear1 macro                   ;lefe screen
       mov al,0
       mov bh,7
       mov ch,4
       mov cl,36
       mov dh,10
       mov dl,79
       mov ah,6
       int 10h
       endm

clear2 macro                      ;down screen
       mov al,0
       mov bh,7
       mov ch,12
       mov cl,0
       mov dh,24
       mov dl,79
       int 10h
       endm

newline macro
        push ax
        push dx
        mov dl,0dh
        mov ah,2
        int 21h
        mov dl,0ah
        mov ah,2
        int 21h
        pop dx
        pop ax
        endm

show_item macro addrs
        local iloop,w10
        push bx
        push cx
        mov bx,0
iloop:  mov dl,addrs[bx]         ;display char
        mov ah,2
        int 21h
        inc bx
        cmp bx,15
        jl  iloop
        mov cx,4
w10:    mov dl,' '
        mov ah,2
        int 21h
        mov dl,' '
        mov ah,2
        int 21h
        mov dl,' '
        mov ah,2
        int 21h

        mov dl,addrs[bx]
        mov ah,2
        int 21h
        inc bx
        mov dl,addrs[bx]
        mov ah,2
        int 21h
        inc bx
        loop  w10
        newline
        pop cx
        pop bx
        endm

getin   macro addrs,count2
local   zeroit,lp,input_end,exit
        push bx
        push ax
        mov bx,0
zeroit: mov addrs[bx],' '
        inc bx
        cmp bx,15
        jl  zeroit

        mov bx,0
lp:     mov ah,1
        int 21h
        cmp al,0ah
        jz  input_end
        cmp al,0dh
        jz  input_end
        mov addrs[bx],al
        inc bx
        cmp bx,count2
        jl lp
input_end: cmp al,0dh
        jz  exit
        cmp al,0ah
        jz  exit
        mov ah,7
        int 21h
        jmp input_end
exit:   
        pop ax
        pop bx
        endm


code    segment
main proc far
     assume  cs:code,ds:data,es:data

start: 
      mov ax,data
      mov ds,ax
      mov ah,0
      mov al,3
      int 10h
     
      clear
      show mess1
      show mess2
      show mess13
      show mess3
      show mess4
      show mess5
      show mess6
      show mess7
      show mess8
      show mess9
      newline
      show mess10
      set_p3
w:    mov ah,7
      int 21h
      cmp al,'i'
      jnz n1            
      call insert
      jmp  w
n1:   cmp al,'m'
      jnz  n2
      call modify
      jmp  w
n2:   cmp al,'d'
      jnz  n3
      call delete
      jmp  w
n3:   cmp al,'q'
      jnz  n4
      call query
      jmp  w
n4:   cmp  al,'c'
      jnz  n5
      call cot
      jmp  w
n5:   cmp  al,'p'
      jnz  n6
      call print
      jmp  w
n6:   cmp  al,'l'
      jnz  n7
      call list
      jmp  w
n7:   cmp al,'e'
      jz  exitf
      jmp  w
exitf:
       mov ah,4ch
       int 21h
       ret
main   endp

insert proc near
       push ax
       push bx
       push cx
       push dx
      
       mov dx,offset fname
       mov al,2
       mov ah,3dh
       int 21h
       mov bx,ax
       clear1
       set_p1 4
       call get_rec
       mov cx,0               ;move file pointer to end
       mov dx,0
       mov al,2
       mov ah,42h
       int 21h
             
       mov cx,23                    ;write file
       mov dx,offset buffer1
       mov ah,40h 
       int 21h
       mov ah,3eh
       int 21h
       set_p3
       pop dx
       pop cx
       pop bx
       pop ax
       ret
insert endp

get_rec proc near
       push ax
       push bx
       getin buffer2,15
       mov bx,0
       mov  cx,15
continue:   mov al,buffer2[bx]
       mov buffer1[bx],al
       inc bx
       loop  continue
       set_p1 5
       getin buffer2,2
       mov al,buffer2
       mov buffer1[bx],al
       inc bx
       mov al,buffer2+1
       mov buffer1[bx],al
       inc bx
       set_p1 6 
       getin buffer2,2
       mov al,buffer2
       mov buffer1[bx],al
       inc bx
       mov al,buffer2+1
       mov buffer1[bx],al
       inc bx
       set_p1 7
       getin buffer2,2
       mov al,buffer2
       mov buffer1[bx],al
       inc bx
       mov al,buffer2+1
       mov buffer1[bx],al
       inc bx
       set_p1 8
       getin buffer2,2
       mov al,buffer2
       mov buffer1[bx],al
       inc bx
       mov al,buffer2+1
       mov buffer1[bx],al
       inc bx
       pop bx
       pop ax
       ret
get_rec endp

openf proc near
      mov dx,offset fname
      mov al,02
      mov ah,3dh
      int 21h
      mov handle,ax
      ret
openf endp

query  proc near
       push ax
       push bx
       push cx
       push dx
       clear1
       clear2
       mov dx,offset fname
       mov al,2
       mov ah,3dh
       int 21h
       mov bx,ax
       set_p2
       getin buffer1,15
       lea dx,mess11
       mov ah,9
       int 21h
b:  
       mov ah,3fh
       mov cx,23
       mov dx,offset buffer2
       int 21h
       lea si,buffer2
       lea di,buffer1
       mov cx,15
c: 
       mov al,byte ptr[si] 
       cmp al,byte ptr[di]
       jnz b
       inc si
       inc di
       loop c
       mov [buffer2+23],'$'
       show_item buffer2
       mov ah,3eh
       int 21h
       pop dx 
       pop cx
       pop bx
       pop ax
       ret
query  endp

modify proc near
       push ax
       push bx
       push cx
       push dx
       clear1
       set_p1 4
       mov dx,offset fname
       mov al,2
       mov ah,3dh
       int 21h
       mov bx,ax
       mov handle,ax
       call get_rec          ; contact is in  buffer1
read: 
       mov dx,offset buffer2
       mov cx,23
       mov ah,3fh
       int 21h
       lea si,buffer2
       lea di,buffer1
       mov cx,15
c5:  
       mov dl,byte ptr[si] 
       cmp dl,byte ptr[di]
       jnz read
       inc si
       inc di
       loop c5
       mov bx,handle
       mov ah,42h
       mov al,1
       mov cx,0ffffh
       mov dx,-23
       int 21h
       mov cx,23
       mov dx,offset buffer1
       mov ah,40h
       int 21h
       mov ah,3eh
       int 21h
       jmp exit2
exit1: 
       set_p2
       show err1 
exit2:
       set_p3 
       pop dx
       pop cx
       pop bx
       pop ax
       ret
modify endp

delete proc near
       push ax
       push bx
       push cx
       push dx
       clear1
       set_p1 4
       mov dx,offset fname
       mov al,2
       mov ah,3dh
       int 21h
       mov bx,ax
       mov handle,ax
       getin buffer1,15          ; contact is in  buffer1
read5: 
       mov dx,offset buffer2
       mov cx,23
       mov ah,3fh
       int 21h
       lea si,buffer2
       lea di,buffer1
       mov cx,15
 c6:   
       mov dl,byte ptr[si] 
       cmp dl,byte ptr[di]
       jnz read5
       inc si
       inc di
       loop c6
       mov bx,handle
       mov ah,42h
       mov al,1
       mov cx,0ffffh
       mov dx,-8
       int 21h
       mov cx,8
       mov dx,offset del
       mov ah,40h
       int 21h
       mov ah,3eh
       int 21h
       jmp exit6

exit5: 
       set_p2
       show err1 
exit6:
       set_p3 
       pop dx
       pop cx
       pop bx
       pop ax
       ret
delete endp             

list   proc   near
       push ax
       push bx
       push cx
       push dx
      
       clear1
       clear2
       set_p2
       show mess11
       mov dx,offset fname
       mov al,2
       mov ah,3dh
       int 21h
       mov bx,ax
again: 
       mov dx,offset buffer1
       mov cx,23
       mov ah,3fh
       int 21h
       cmp ax,0
       jz p
       show_item buffer1
       jmp again
p:         
       mov ah,3eh
       int 21h
       set_p3
       pop dx
       pop cx
       pop bx
       pop ax
       ret
list   endp

print  proc near
       push ax
       call openf
       mov cl,count
       mov ch,0
read2:
       mov dx,offset buffer1
       mov cx,type score
       mov ah,3fh
       int 21h
       mov cx,23h
       mov bx,0
next:  mov ah,5
       mov dl,byte ptr buffer1[bx]
       int 21h
       inc bx
       loop next
       mov ah,5
       mov dl,0dh
       int 21h
       dec x
       cmp x,0
       jnz read2
       mov bx,handle
       mov ah,3eh
       int 21h
       pop ax
       ret
print  endp

cot  proc 
       push ax
       clear2
       set_p2
       show mess12
       mov dx,offset fname
       mov ah,3dh
       int 21h
       mov bx,ax
       mov handle,ax
read0: mov dx,offset buffer2
       mov cx,23
       mov ah,3fh
       int 21h
       mov dl,[buffer2+15]
       cmp dl,'6'
       jl  five
       cmp dl,'7'
       jl  six
       cmp dl,'8'
       jl  seven
       cmp dl,'9'
       jl  eight
       inc [buffer3+4]
       jmp quit
eight:  
       inc [buffer3+3]
       jmp quit
seven: inc [buffer3+2]
       jmp quit
six:   inc [buffer3+1]
       jmp quit
five:  inc [buffer3]
quit:  cmp ax,0
       jnz read0
       mov cx,10
a:     mov dl,' '
       mov ah,2
       int 21h
       loop a 
       mov bx,0               
a0:    mov dl,[buffer3+bx]
       mov ah,2
       int 21h
       inc bx
       mov dl,' '
       mov ah,2
       int 21h
       mov dl,' '
       mov ah,2
       int 21h
       cmp bx,5
       jnz a0
       mov bx,handle
       mov ah,3eh
       int 21h
       set_p3
       pop ax
       ret
cot  endp
code   ends
       end start

       




    
