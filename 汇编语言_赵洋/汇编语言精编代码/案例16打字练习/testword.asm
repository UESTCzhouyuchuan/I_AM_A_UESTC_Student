Init_game macro op1,op2,op3,op4,op5,op6     
    mov cx,00h       
    mov dh,op1       
    mov dl,op2
op6:mov ah,02h
    mov bh,00h           
    int 10h
    push cx
    mov ah,0ah
    mov al,op3
    mov bh,00h
    mov cx,01h
    int 10h
    pop cx
    inc cx
    inc op4
    cmp cx,op5
    jne op6  
endm
clear_screen macro op1,op2,op3,op4 ;清屏宏定义    
    mov ah,06h          
    mov al,00h
    mov bh,07h
    mov ch,op1
    mov cl,op2
    mov dh,op3
    mov dl,op4
    int 10h
    mov ah,02h
    mov bh,00h
    mov dh,00h
    mov dl,00h
    int 10h
endm
menu  macro op1,op2,op3 ;菜单显示宏定义      
   mov ah,02h
   mov bh,00h
   mov dh,op1
   mov dl,op2
   int 10h
   mov ah,09h
   lea dx,op3
   int 21h
endm
data segment          
ZK   db "WELCOME TO PLAY$"     
no   db "date:2003/6/24$"
meg  db "press Enter key to continue.......$"
meg1 db "when a letter is dropping,please hit it!$"
meg2 db "press space key to pause!$"
meg3 db "press ESC key to return main interface!$"
meg4 db "press letter 'E' to exit!$"
speed dw 600d
letters db "jwmilzoeucgpravskntxhdyqfb"   
        db "iytpkwnxlsvxrmofzhgaebudjq"
        db "nwimzoexrphysfqtvdcgljukda"
letters_bak db "jwmilzoeucgpravskntxhdyqfb"   
            db "iytpkwnxlsvxrmofzhgaebudjq"   
            db "nwimzoexrphysfqtvdcgljukda"
letter_counter db 0        
life_flag db 78 dup(0)
position_flag db 78 dup(0)      
present_position db 1        
data ends
stack segment para stack 'stack'
      db 64 dup(0)
stack ends
code  segment
      main proc far
           assume cs:code,ds:data,ss:stack
    start: mov ax,data
           mov ds,ax
           mov letter_counter,00h        
           mov present_position,1      
           lea si,position_flag      
           mov ah,00h
           mov cx,00h
init_postion_flag:  
           mov [si],ah
           inc si
           inc cx
           cmp cx,78d
           jne init_postion_flag
           lea di,letters        
           lea si,letters_bak
           mov cx,00h
init_letters:
           mov ah,[si]
           mov [di],ah
           inc si
           inc di
           inc cx
           cmp cx,78d
           jne init_letters
           mov ah,00h
           lea si,life_flag
           mov cx,00h
init_life_flag:
           mov [si],ah
           inc si
           inc cx
           cmp cx,78d
           jne init_life_flag
           mov cx,00h        
           mov ah,01h        
           or  ch,00010000b
           int 10h
clear_screen 00d,00d,24d,79d     
         Init_game 00d,00d,0ah,dl,80d,nextsign1       
         Init_game 24d,00d,0ah,dl,80d,nextsign2
         Init_game 00d,00d,0ah,dh,25d,nextsign3
         Init_game 00d,79d,0ah,dh,25d,nextsign4
         menu 05d,15d,ZK         ;菜单信息的宏调用
         menu 07h,15d,no       
         menu 09d,15d,meg
         menu 11d,15d,meg1
         menu 13d,15d,meg2
         menu 15d,15d,meg3
         menu 17d,15d,meg4
    put: mov ah,02h               ;设置光标位置
         mov bh,00h
         mov dh,22d
         mov dl,33d
         int 10h
         mov ah,01h              ;从键盘输入任意字符
         int 21h
         cmp al,0dh
         je speed3
         cmp al,45h
         je exit
 exit:   mov ah,4ch
         int 21h  
 speed3: mov ax,speed+12
         mov speed,ax
         jmp begin
  begin: clear_screen 01d,01d,23d,78d ;清屏宏调用    
         clear_screen 01d,01d,23d,78d     
         Init_game 23d,01d,01h,dl,78d,nextsign5
         mov ah,02h   
         mov bh,00h
         mov dh,01h
         mov dl,01h
         int 10h
         mov cx,00h     
         lea si,letters
nextletter:    
         mov ah,02h               ;显示字母
         mov dl,[si]
         int 21h
         inc si
         inc cx
         cmp cx,78d
         je nextcycle
         jmp nextletter
from_front:     
         sub present_position,78d     
         jmp gobackto_si
find_zero:
         cmp letter_counter,78d   
         je recycle
         cmp present_position,78d
         je from_one
         mov ah,00h
 nextsi: add present_position,01h
         inc si
         cmp [si],ah
         je gobackto_di
         cmp present_position,78d
         je from_one
         jmp nextsi
from_one:mov present_position,01h   
         jmp gobackto_si
 recycle:mov letter_counter,00h
         mov present_position,01d
         lea si,position_flag
         mov cx,00h
         mov ah,00h
clearsi: mov [si],ah
         inc cx
         cmp cx,78d
         je nextcycle
         inc si
         jmp clearsi
nextcycle:        
         lea di,letters
         lea si,position_flag
         add present_position,31d
         cmp present_position,78
         ja from_front
gobackto_si:
         add si,word ptr present_position
         dec si
         mov ah,[si]
         cmp ah,01h
         je find_zero
gobackto_di:
         mov ah,01h
         mov [si],ah
         add di,word ptr present_position
         dec di
         mov dl,present_position
         mov ah,02h  
         mov bh,00h          
         mov dh,01h
         int 10h
         mov cx,00h
nextrow: push cx  
         mov cx,00h
out_cycle:              ; 延迟
         push cx
         mov cx,00h
in_cycle:
         add cx,01h
         cmp cx,1000
         jne in_cycle 
         push dx
         mov ah,06h     ;从键盘输入字符
         mov dl,0ffh
         int 21h
         pop dx
         jz pass         
         cmp al,1bh     ;如果键入ESC，则返回主菜单
         je to_start1
         cmp al," "     ;如果键入SPACE，则游戏暂停
         je pause
         cmp al,[di]    ;输入字母正确！则字母消失
         je disappear
pass:    pop cx
         inc cx
         cmp cx,speed
         je print
         jmp out_cycle
pause:   push dx        ;暂停处理
         mov ah,06h
         mov dl,0ffh
         int 21h
         pop dx
         cmp al," "
         jne pause
         jmp pass
to_start1:              ;返回主菜单
        jmp start
print:   
        mov ah,0ah      ;在当前光标位置写空格        
        mov al," "
        mov bh,00h
        mov cx,01h
        int 10h
        inc dh
        mov ah,02h      ;改变光标位置
        mov bh,00h
        int 10h
        mov ah,0ah      ;在当前光标位置写字母     
        mov al,[di]
        mov bh,00h
        mov cx,01h
        int 10h
        pop cx
        inc cx
        cmp cx,21d
        je print_next_letter
        jmp nextrow     ;下一行
disappear:              ;击中字母后输出空格
        pop cx
        pop cx
        mov ah,0ah
        mov al," "
        mov bh,00h
        mov cx,01h
        int 10h
        jmp hit         
print_next_letter:    
        lea si,life_flag
        add si,word ptr present_position
        dec si
        mov ah,0ah
        mov al," "
        mov bh,00h
        mov cx,01h
        int 10h
        inc dh      
        mov ah,02h
        mov bh,00h
        int 10h
        mov ah,0ah
        mov al," "
        mov bh,00h
        mov cx,01h
        int 10h
        mov ah,1
        mov [si],ah
  hit:  mov ah,02h
        mov bh,00h
        mov dh,01h
        mov dl,present_position
        int 10h
        mov al,[di]  ; 出现下一个新字母的数法
        add al,7
        cmp al,7ah
        ja convey_letter
        mov ah,0ah
        mov bh,00h
        mov cx,01h
        int 10h
        mov [di],al
        add letter_counter,01h
        jmp nextcycle
  convey_letter:   
        sub al,7ah
        add al,61h
        mov ah,0ah
        mov bh,00h
        mov cx,01h
        int 10h
        mov [di],al
        add letter_counter,01h
        jmp nextcycle 
        clear_screen 01,01,23,78
        mov ah,02h
        mov bh,00h
        mov dh,11d
        mov dl,20d
        int 10h
        inc dh
        inc dh
        mov ah,02h
        mov bh,00h
        int 10h
notkey:  
        mov ah,07h
        int 21h
        cmp al,0dh
        je to_start
        cmp al,1bh
        je over
        jmp notkey
to_start:     
        clear_screen 00,00,24,79
        jmp start
over:   clear_screen 01,01,23,78   
        mov ah,02h
        mov bh,00h
        mov dh,11d
        mov dl,15h
        int 10h
        mov ah,02h
        mov bh,00h
        mov dh,13d
        mov dl,15h
        int 10h
        mov ah,07h
        int 21h
        mov ah,07h
        int 21h
        clear_screen 00,00,24,79   
        mov ax,4c00h
        int 21h
main endp
code ends
end start