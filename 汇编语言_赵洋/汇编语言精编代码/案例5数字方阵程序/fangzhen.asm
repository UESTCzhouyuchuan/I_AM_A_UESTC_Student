data  segment
buf1  db '1  2  38  9  47  6  5'
buf2  db '1  2  3  412 13 14 511 16 15 610 9  8  7'
buf3  db '1  2  3  4  516 17 18 19 615 24 25 20 714 23 22 21 813 12 11 10 9'
dbuf  db 14 dup(?)
i1    db 0dh,0ah,'this is a fangzhen programme'
      db 0dh,0ah,'input q to exit'
      db 0dh,0ah,'Please input a number(3--5):','$'
i2    db 0dh,0ah,'input error,please reinput!','$'
n     db ?
b     db 1
data  ends
stack segment
      db 100 dup(?)
stack ends
code  segment
      assume ds:data,cs:code,ss:stack
main: 
      mov ax,data
      mov ds,ax
      call clear
lop:  lea dx,i1
      mov ah,9
      int 21h
      mov ah,1
      int 21h
      cmp al,'q'
      jz quit
      lea si,buf1
      mov n,7
      mov cl,3
      call clear
      cmp al,'3'
      jz  s
      lea si,buf2
      mov n,10
      mov cl,4
      cmp al,'4'
      jz  s
      lea si,buf3
      mov cl,5
      mov n,13
      cmp al,'5'
      jz s
      lea dx,i2
      mov ah,9
      int 21h
      call clear
      jmp lop
s:    
      mov bl,n
      lea di,dbuf
l:    mov al,[si]
      mov [di],al
      inc si
      inc di
      dec bl
      jne l
      mov [di],byte ptr '$'
      mov ah,2
      mov dh,b
      mov dl,0
      int 10h
      lea dx,dbuf
      mov ah,9
      int 21h
      inc b
      loop s
      
      jmp lop
quit: mov ah,4ch
      int 21h
;***«Â∆¡***
clear proc near
      push ax
      push bx
      push cx
      push dx
      mov  ah,6
      mov al,0
      mov ch,0
      mov cl,0
      mov dh,24
      mov dl,79
      mov bh,7
      int 10h
      pop dx
      pop cx
      pop bx
      pop ax
      ret
clear endp
code  ends
      end main
