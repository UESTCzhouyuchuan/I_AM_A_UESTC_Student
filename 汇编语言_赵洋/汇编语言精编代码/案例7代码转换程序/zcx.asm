extrn main:far,change5:far
stack segment para public 'stack'
      db 200 dup (0)
stack ends
data segment
;*****主程序中的提示信息*****
str1  DB 0AH,0DH, '********************************************$'
str2  DB 0AH,0DH, '**                                        **$'
str3  DB 0AH,0DH, '**            welcome     you !           **$'
str4  DB 0AH,0DH, '**                                        **$'
str5  DB 0AH,0DH, '** this is programme of shuzhizhuanghuan  **$'
str6  db 0AH,0DH, '**                                        **$'
str7  db 0AH,0DH, '**       press b to begin exchange!       **$'
str8  DB 0AH,0DH, '**           press q to exit !            **$'
str9  DB 0AH,0DH, '**                                        **$'
str10 DB 0AH,0DH, '********************************************$'
str11 db 0ah,0dh,'input error,please repess!','$'
data ends
code segment
     assume cs:code,ds:data,ss:stack
start: mov ax,data
      mov ds,ax
disp  macro m
      lea dx,m
      mov ah,9
      int 21h
      endm
      
      disp str1
      disp str3
      disp str4
      disp str5
      disp str6
      disp str7
      disp str8
      disp str9
      disp str10
lop:  mov ah,8
      int 21h
      cmp al,'b'
      jz  ltol
      cmp al,'q'
      jz exit
      disp str11
      jmp lop
ltol: call main
      call change5
      jmp lop
exit: mov ah,4ch
      int 21h
code  ends
      end start


