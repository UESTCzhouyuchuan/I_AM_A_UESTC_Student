data segment
obf  db  '***** welcome you !*****',0dh,0ah 
     db             ' input data:','$'
a0   db ?
a1   db ?
b0   db ?
b1   db ?
a    db ?
b    db ?
data ends
stack segment stack
      db 200 dup(0)
      stack ends
code  segment
      assume cs:code, ds:data,ss:stack
main:mov ax, data
     mov ds, ax
     mov ah, 9
     lea dx, [obf]
     int 21h
     inc dx
     mov dl, 13
     mov ah, 2
     int 21h
     mov dl,10
     int 21h
     mov ah,1
     int 21h
     cmp al, 13
     jz lab1
     mov [a0], al
     mov [a], al
     mov [a1], 1
x1:  mov ah, 1
     int 21h
     cmp al, 13
     jz lab1
     mov [b], al
     mov bl, [b]
     cmp bl, [a]
     jnz x2
     add [a1], 1
     jmp x1
x2:  mov [b0], bl
     mov [b1], 1
x3:  mov ah, 1   
     int 21h
     mov [a], al
     cmp bl,[a]
     jnz x4
     add [b1],1
     jmp x3
x4:  mov cl, [b1]
     cmp cl, [a1]
     jb  y1
     mov cl, [b0]
     mov [a0], cl
     mov cl, [b1]
     mov [a1],cl
 y1: cmp al, 13
     jz  lab1
     mov [b0], al
     mov [b1], 1
     mov [b], al
     mov bl, [b]
     jmp x3
lab1: mov ah, 2
      mov dl,13
      int 21h
      mov dl,10
      int 21h
      cmp [a1],10
      jb  z1
      mov ah,0
      mov al, [a1]
      mov bl, 10
      div bl
      add ax, 3030h
      mov bx, ax
      mov ah, 2
      mov dl, bl
      int 21h
      mov dl, bh
      int 21h
      jmp z2
z1: add [a1], 30h
    mov dl, [a1]
    int 21h
    sub [a1],30h
z2: mov ah,2
    mov dl, 13
    int 21h
    mov dl, 10
    int 21h
    mov cx, 0
    mov cl, [a1]
    mov ah, 2
m:  mov dl,[a0]
    int 21h
    loop m
    mov ah, 4ch
    int 21h
code ends
     end main

