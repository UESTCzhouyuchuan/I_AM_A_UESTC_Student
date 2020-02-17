p macro buf
  lea dx,buf
  mov ah,9
  int 21h
  endm
data segment
pp    db 0dh,0ah,'       welcome you to run this programme!$'
qq    db 0dh,0ah,'      when you input number,press enter.$'
qw    db 0dh,0ah,'6eh,52h,94h,52h,$'
qa    db 0dh,0ah,'                    $'
info1 db 0dh,0ah,0dh,'   input number:$' 
info2 db 0dh,0ah,'  output number:$'
bufa  db 20
      db ?
      db 20 dup(0)
bufb  db 20 dup(0)
buf1  db 20
      db ?
      db 20 dup(0)
buf2  db 20 dup(0)
buf3  db 20
      db ?
      db 20 dup(0)
buf4  db 20 dup(0)
data ends
stack segment
     db 100 dup(0)
stack ends
code segment
     assume ds:data,cs:code
s:  mov ax,data
    mov ds,ax
    mov ah,0
    mov al,3
    int 10h
    mov ah,0bh
    mov bh,0
    mov bl,3
    int 10h

    p   pp
    p   qq
    lea si,qw
    mov di,5
    mov dx,0405h
    mov ah,15
    int 10h
lp: mov ah,2
    inc dl
    int 10h
    mov bl,[si]
    mov cx,1
    mov ah,9
    int 10h
    inc si
    jnz lp
    p   qa
    p   qa
    p   qa
    p   info1
    lea dx,bufa
    mov ah,10
    int 21h
    lea si,bufa+1
    mov ch,0
    mov cl,[si]
    lea di,bufb
n:  mov bx,offset bufa
    mov al,0
    xlat bufa
    mov [di],al
    inc di
    loop n
    mov byte ptr [di],'$'
    p  info2
    p  bufb

    p   info1
    lea dx,buf1
    mov ah,10
    int 21h
    lea si,buf1+1
    mov ch,0
    mov cl,[si]
    lea di,buf2
n1:  mov bx,offset buf1
    mov al,2
    xlat buf1
    mov [di],al
    inc di
    loop n1
    mov byte ptr [di],'$'
    p  info2
    p  buf2

    p   info1
    lea dx,buf3
    mov ah,10
    int 21h
    lea si,buf3+1
    mov ch,0
    mov cl,[si]
    lea di,buf4
n2:  mov bx,offset buf3
    mov al,3
    xlat buf3
    mov [di],al
    inc di
    loop n2
    mov byte ptr [di],'$'
    p  info2
    p  buf4
    mov ah,4ch
    int 21h
    code ends
       end s
