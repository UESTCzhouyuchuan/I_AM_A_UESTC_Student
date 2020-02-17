data segment
;*****定义please等提示信息*****
  str db 20
         db 50h,7,0,0
           db 6ch,7,0,1
           db 65h,7,0,1
           db 61h,7,0,1
           db 73h,7,0,1
           db 65h, 7,0,1
           db 70h,7,1,-10
           db 72h,7,0,1
           db 65h,7,0,1  
           db 73h,7,0,1 
           db 73h,7,0,1
           db 53h,7,0,2 
          db 6bh,7,0,2
          db 65h,7,0,1
          db 79h,7,0,1
          db 65h,7,0,2
          db 78h,7,0,1
          db 69h,7,0,1 
         db 74h,7,0,1 
         db 21h,7,0,1
;*****定义0－9十个图形数字*****
s0 db 6
     db 5fh,7,0,0
     db 7ch,7,1,-1
     db 7ch,7,1,0
     db 5fh,7,0,1
     db 7ch,7,0,1
     db 7ch,7,-1,0
  sy db 2
     db 7ch,7,1,0
     db 7ch,7,1,0
  s2 db 5
     db 5fh,7,0,0
     db 7ch,7,1,1
     db 5fh,7,0,-1
     db 7ch,7,1,-1
     db 5fh,7,0,1
  s3 db 5
     db 5fh,7,0,0
     db 7ch,7,1,1
     db 5fh,7,0,-1
     db 7ch,7,1,1
     db 5fh,7,0,-1
  s4 db 4
     db 7ch,7,1,0
     db 5fh,7,0,1
     db 7ch,7,1,1
     db 7ch,7,-1,0
  s5 db 5
     db 5fh,7,0,0
     db 7ch,7,1,-1
     db 5fh,7,0,1
     db 7ch,7,1,1
     db 5fh,7,0,-1
  s6 db 6
     db 5fh,7,0,0
     db 7ch,7,1,-1
     db 5fh,7,0,1
     db 7ch,7,1,1
     db 5fh,7,0,-1
     db 7ch,7,0,-1
  s7 db 3
     db 5fh,7,0,0
     db 7ch,7,1,1
     db 7ch,7,1,0
  s8 db 7
     db 7ch,7,1,0
     db 5fh,7,-1,1
     db 7ch,7,1,1
     db 5fh,7,0,-1
     db 7ch,7,1,1
     db 5fh,7,0,-1
     db 7ch,7,0,-1
  s9 db 6
     db 7ch,7,1,0
     db 5fh,7,-1,1
     db 7ch,7,1,1
     db 5fh,7,0,-1
     db 7ch,7,1,1
     db 5fh,7,0,-1
 s11 db 2
     db 03h,7,1,0
     db 03h,7,1,0

data ends
stack segment 
         db 200 dup (0)
stack ends
code segment
     assume cs:code,ss:stack,ds:data

start:
        mov ax,data
        mov ds,ax
        mov ah,0         ;设置显示方式
        mov al,4
        int 10h
        mov ah,0bh        ;置彩色调板
        mov bh,0
        mov bl,1
        int 10h
        mov ah,0bh        ;置彩色调板
        mov bh,1
        mov bl,4
        int 10h

        mov ah,2               ;取系统时间
        int 1ah
        mov ax,0
        mov bx,0
        mov ah,ch            ;取系统时间
        mov al,cl                ;保存分钟
        mov bh,dh          ;保存秒
        mov bl,dl           ;保存百分之一秒
       
  tt:  
push ax
       push bx
       mov ah,0
       mov al,4
       int 10h
mov ah,0bh
        mov bh,0
        mov bl,1
        int 10h
        mov ah,0bh
        mov bh,1
        mov bl,4
        int 10h
 
       MOV       AH,1              ;读键盘缓冲区字符
       INT       16h
       JZ        ww
       MOV       AH,8                ;从键盘输入字符
       INT       21h
       CMP       AL,'s'             ;输入s，结束程序
       JE       tu
  ww:  pop bx
       pop ax

  call xian                       ;调用显示子程序
       push ax
       
       
  qu:  mov ah,2                   ;取系统时间
       int 1ah
       cmp bh,dh
       je qu
       pop ax
       inc bh                       ;对时间进行加1
       cmp bh,100
       jl tt
       mov  bh,0
       inc al
       call beep
            cmp al,100
       
            jl tt
       mov al,0
       inc ah
       cmp ah,24
       jl tt
      mov ah,0
    
      jmp tt
   tu: mov ah,4ch
      int 21h
      ret
 xian proc                          ;对时间值进行处理并显示的子程序
      push si
      push di
      push dx
      push cx
      push bx
      push ax
      pop ax
      push ax
      mov bx,ax
      mov ax,0
      mov al,bh
    
      mov cl,4
      shr al,cl
      mov bl,al     
      mov dh,10
      mov dl,2
      call ff
      pop ax
      push ax
      mov bx,ax
      mov ax,0
      mov al, bh
      and al,0fh
      mov bl,al
      mov dh,10 
      mov dl,6
      call ff
      mov dh,10
      mov dl,10
      mov bl,10 
      call ff
      pop ax
      push ax
      mov cl,4
      shr al,cl
      mov bl,al
      mov dh,10 
      mov dl,14
      call ff
      pop ax
      push ax
      and al ,0fh
    
    
      mov bl,al
      mov dh,10 
      mov dl,18
      call ff
      mov dh,10
      mov dl,22
      mov bl,10
      call ff
      pop ax
      pop bx
      push bx
      push ax

      mov ax,0
      mov al,bh
      mov cl,4
      shr al,cl
     
      mov bl,al
      mov dh,10
      mov dl,26
      call ff
      pop ax
      pop bx
      push bx
      push ax
      mov al,bh
      and al,0fh
  
      mov bl,al
      mov dh,10 
      mov dl,30
      call ff
      mov dh,0
      mov dl,15
      mov bl,22
      call ff
      pop ax
      pop bx
      pop cx
      pop dx
      pop di
      pop si
      ret
xian endp
ff proc ;显示具体数值
       push ax
       push bx
       push cx
       push dx
  
      cmp bl,0
       je l0
      cmp bl,1
       je l1
      cmp bl,2
       je l2
      cmp bl,3
      je l3
      cmp bl,4
      je l4
      cmp bl,5
      je l5
      cmp bl,6
       je l6
      cmp bl,7
      je l7
      cmp bl,8
      je l8
      cmp bl,9
      je l9
      cmp bl,10
      je l10
      cmp bl,22
      je ld
l0:   lea di,s0
      jmp ty
l1 :  lea di,sy
      jmp ty
l2:   lea di,s2
      jmp ty
l3:   lea di,s3
      jmp ty
l4:   lea di,s4
      jmp ty
l5:   lea di,s5
      jmp ty
l6:   lea di,s6
      jmp ty
l7:   lea di,s7
      jmp ty
l8:   lea di,s8
      jmp ty
l9:   lea di,s9
      jmp ty
l10:  lea di,s11
      jmp ty
ld :  lea di,str
ty:   mov ah,0fh  ;示方式
      int 10h
      sub cx,cx
      mov cl,[di]
      inc di
plot_next:   add dh,[di+2]
             add dl,[di+3]
             mov ah,2
             int 10h
             mov al,[di]
             mov bl,[di+1]
             push cx
             mov cx,1
             mov ah,09
             int 10h
             pop cx
             add di,4
        loop plot_next

    pop dx
    pop cx
    pop bx
    pop ax
    mov cx,100
gg: dec cx
loop gg

ret
ff endp
clear  proc 
       push ax
       push bx
       push cx
       push dx
       mov ah,6
       mov al,0
       mov bh,1
       int 10h
       pop dx
       pop cx
       pop bx
       pop ax
ret
clear endp
beep proc
 push ax
 push bx
 push cx
 push dx
  mov al ,10110110b
  out 43h,al
  mov ax,533h
  out 42h,al
  mov al,ah
  out 42h,al
  in al,61h
  mov ah,al
  or al,03
  out 61h,al
  sub cx,cx
  mov bl,28h
g7: loop g7
    dec bl
    jnz g7
    mov al,ah
    out 61h,al
   pop dx
   pop cx
   pop bx
   pop ax


    ret
beep endp

code ends
     end start
