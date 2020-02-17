data segment
info1 db 0dh,0ah,'please choose the letter y,s,z:'
      db 0dh,0ah,'input q to quit','$' 
info2 db 0dh,0ah,'choose error!','$'
d3 dw  0
total db 12
dotyx db 50,160
      db 60,135
      db 60,185
      db 75,115
      db 75,205
      db 95,110
      db 95,210
      db 110,114
      db 110,210
      db 130,135
      db 130,195
      db 145,165
data  ends
stack segment stack
      db 200 dup(0)
stack ends
code  segment
      assume cs:code,ds:data,ss:stack
main   proc far
       mov ax,data
       mov ds,ax
       mov ah,0
       mov al,4
       int 10h
input: lea dx,info1
         mov ah,9
         int 21h
         mov ah,08
         int 21h
         cmp al,'s'
         jz sa
         cmp al,'z'
         jz zhen
         cmp al,'y'
         jz yua
         cmp al,'q'
         jz exit
         mov dx,offset info2
         mov ah,09
         int 21h
sa:      
         call san
         jmp input
     
zhen:  
         call zheng
         jmp input
yua:
         call yuan
         jmp input
exit:    
         mov ah,4ch
         int 21h
         ret
main     endp

san      proc near
         push ax
         push bx
         push cx
         push dx 
         mov ah,0
         mov al,12h
         int 10h
         mov al,1
a0:      mov dx,1
         mov d3,1
         mov cx,320
a1:      push cx
         push d3
a2:      mov  ah,12
         push ax
         int 10h
         pop ax
         inc cx
         sub d3,1
         jnz a2
         pop d3
         add d3,2
         pop cx
         inc dx
         dec cx
         jne a1
         inc al
         cmp al,5
         jne a0
         pop dx
         pop cx
         pop bx
         pop ax
         ret
san      endp
zheng    proc near
         push ax
         push bx
         push cx
         push dx
         mov ah,0fh
         int 10h
         mov ah,0 
         mov al,3
         int 10h
         mov cx,1                 ;字符数量
         mov ah,2
         mov dh,5                 ;5行开始
         mov dl,25                ;25列开始
         int 10h
;*****光标向下动********
line:    mov ah,2
         int 10h
         mov al,2
         mov ah,9
         mov bl,0e0h            ;字符黄色
         int 10h
         inc dh                 ;行增加 
         cmp dh,20               ;20行
         jne line 
         jmp line1
;****光标向右动*****
line1:   mov ah,2
         int 10h
         mov al,2
         mov ah,9
         mov bl,0e0h                ;字符为黄色
         int 10h
         inc dl                  ;列增加
         cmp dl,55                 ;55列
         jne line1
         jmp line2
;*****光标向上动*********
line2:   mov ah,2
         int 10h  
         mov al,2
         mov ah,9
         mov bl,0e0h               ;字符为黄色
         int 10h
         dec dh
         cmp dh,5
         jne line2
         jmp line3  
;***光标向左动***
line3:   mov ah,2
         int 10h
         mov al,2
         mov ah,9
         mov bl,0e0h ;字符为黄色
         int 10h
         dec dl 
         cmp dl,25
         jne line3
l00:     mov ah,7
         mov al,14
         mov bh,20h  ;绿色
         mov ch,6 
         mov cl,26
         mov dh,19
         mov dl,54
         int 10h
;*****时间控制*****
l01:    mov ah,0
        int 1ah
        cmp dl,10
        jnz l01
l1:     mov ah,6
        mov al,14
        mov bh,0f0h ;白色
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
l2:     mov ah,0
        int 1ah
        cmp dl,15
        jnz l2
l3:     mov ah,7
        mov al,14
        mov bh,40h ;红色
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
l4:     mov ah,0
        int 1ah
        cmp dl,30
        jnz l4
l5:     mov ah,6
        mov al,14
        mov bh,0d0h ;品红
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
l004:   mov ah,0
        int 1ah
        cmp dl,10
        jnz l004
l005:   mov ah,7
        mov al,14
        mov bh,30h ;青
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
l006:   mov ah,0
        int 1ah
        cmp dl,10
        jnz l006
l02:    mov ah,7
        mov al,14
        mov bh,20h ;绿色
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
;****时间控制****

  mov ah,2
       mov dh,23
       mov dl,0
       int 10h
       pop dx
       pop cx
       pop bx
       pop ax          
       ret
zheng  endp
yuan   proc near
       push ax
       push bx
       push cx
       push dx
       mov ax,0004h
       int 10h
       mov bx,00
       push bx
       mov ah,0bh
       int 10h
       mov bx,0003h
       mov ah,0bh
       int 10h
       mov bl,total
       mov si,offset dotyx
       mov ch,0
       mov dh,ch
plo:   mov dl,[si]
       mov cl,[si+1]
       mov al,02h
       mov ah,0ch
       int 10h
       inc si
       inc si
       dec bl
       jnz plo
       mov bx,50
       pop bx
       pop dx
       pop cx
       pop bx
       pop ax
       ret
yuan   endp
code   ends
       end main

