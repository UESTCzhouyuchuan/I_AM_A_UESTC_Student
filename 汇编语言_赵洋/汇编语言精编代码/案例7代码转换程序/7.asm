public change5
data segment
binary dw 7fffh,50h
       n=($-binary)/2
buf  db 7 dup(0)
info1 db 0ah,0dh,'this is the change from hexnumber to decimal:$'
info2 db 0ah,0dh,'the number is:7fffh,50h$',0ah,0dh
info3 db 0ah,0dh,'the result is:$'
data ends
stack segment stack
      db 200 dup(0)
stack ends     
code segment
     assume cs:code,ds:data,ss:stack
f2to10 proc near
      push bx
      push dx
      push si
      push cx
disp  macro m
      lea dx,m
      mov ah,9
      int 21h
      endm
      lea si,buf
      or  ax,ax
      jns plus
      neg ax
      mov [si],byte ptr '-'
      inc si
plus: mov bx,10
      mov cx,0
lop1: mov dx,0
      div bx
      push dx
      inc cx
      or ax,ax
      jne lop1
lop2: pop ax
      cmp al,10
      jb l1
      add al,7
l1:   add al,30h
      mov [si],al
      inc si
      dec cx
      jne lop2
      mov [si],byte ptr 'D'
      inc si
      mov [si],byte ptr '$'
      disp  info3
      disp buf
      pop cx
      pop si
      pop dx
      pop bx
      ret
f2to10 endp
change5 proc far
start: mov ax,data
       mov ds,ax
       disp info1
       disp info2
       mov cx,n
       lea di,binary
lopa:  mov ax,[di]
       call f2to10
       add di,2
       loop lopa
       ret
change5 endp
code ends
      end 



                             
