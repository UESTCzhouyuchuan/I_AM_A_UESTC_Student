red_chr macro                              ;读取字符宏定义
        mov ah,0
        int 16h
endm
string  macro p1                          ;输入字符光标
        mov ah,9
        lea dx,p1
        int 21h
endm
win macro opr1,opr2,opr3,opr4,opr5,opr6    ;建立窗口
         mov ah,06h
         mov al,opr1
         mov bh,opr2
         mov ch,opr3
         mov cl,opr4
         mov dh,opr5
         mov dl,opr6
         int 10h
endm
pos_curse macro op1,op2,op3               ;定义光标位置
         mov ah,2
         mov bh,op1
         mov dh,op2
         mov dl,op3
         int 10h
endm
pos_get  macro                             ;显示光标位置
         mov ah,03h
         mov bh,0
         int 10h
endm
data     segment                           ;定义数据段
         menu     db 'File  Edit  Help $'
        
         mass_1   db 'F1 Active file     F10 Active help','$'
         manu_1   db ' New      ',13,10,'$'
         manu_2   db ' Open     ',13,10,'$'
         manu_3   db ' Save     ',13,10,'$'
         manu_4   db ' Save as  ',13,10,'$'
         manu_5   db ' Exit     ','$'
         handle   dw ?
         message1 db ' Please input file name:','$'
         message2 db ' Please input save file name:','$'
         message3 db ' Please input open file name:','$'
         message4 db ' ***The file is not save! Save it now? (Y/N)***: ','$'
         path     db 50 dup(0),'$'
         buffer   db 2000 dup(?)
         bak      db 3850 dup(0)
         line     db ?
         row      db ?
         char     db ?
    help_mas1 db ' welcome use editor! $'       ;帮助内容
    help_mas2 db 'please the first active help! $'
    help_mas3 db 'good lucky!! $'
    help_mas4 db '==========================================================$'
    help_mas5 db 'Press F1 to active file. $'
    help_mas6 db 'You can use DOWN cursor key to choose the fuction $'
    help_mas7 db 'Press F10 to show the help massage.Press Esc To Quit$'
    date  db  'today ??/??/','$'　　　　　　;调用日期
    hanglie db '???//???','$'　　　　　　　 ;行//列
data     ends
code     segment                       
main     proc far                           ;主程序
         assume cs:code,ds:data
start:
         push ds
         sub  ax,ax
         push ax
         mov  ax,data
         mov  ds,ax
         call wind　　　　　　　　　　　　　　　  
         call edit                                
         ret
main     endp
wind proc near                               ;创建窗口子程序
         win 0,3eh,1,0,24,79                 ;定义窗口背景
         win 1,1fh,0,0,0,79
         win 0,1fh,24,0,24,79
show:			                     ;显示菜单位置及内容
         pos_curse 0,0,1			 
         mov ah,9
         lea dx,menu
         int 21h
show_2:					    　;显示状态栏位置及内容
         pos_curse 0,24,1
         mov ah,9
         lea dx,mass_1
         int 21h
         call win3
         call win4
         pos_curse  0,1,0
         mov row,dh
         mov line,dl
wind endp
edit proc near
char_get:                             ;读字符
      call com
com proc near                         ;定义功能鍵
        pos_get
        mov  row,dh
        mov  line,dl
first:
        pos_curse 0,row,line
j00:    mov ah,0
        int 16h                        ;从键盘读字符 ah=扫描码 al=字符码
        push ax
        lea dx,buffer
        mov buffer[bx],al
        inc bx
        cmp  ah,48h                    ;上
        jz   up_1
        cmp  ah,50h                    ;下
        jz   down_1
        cmp  ah,4bh                    ;左
        jz   left
        cmp  ah,4dh                    ;右
        jz   right
        cmp  ah,1ch                    ;回车
        jz   enter_1
        call fuc_key
        mov ah,2
        mov dl,al
        int 21h
        pop ax
        call  menu_show
        jmp   j6
down_1:
        jmp down
enter_1:
        jmp enter_2
up_1:   jmp up
left:                                   ;光标左移
        pos_get
        mov row,dh
        mov dl,line
        cmp line,0
        jnz direct
        mov line,79
        dec row
        cmp row,0
        je  stop2                                            
        jmp first
stop2: 
        mov row,1
        jmp first
direct:   
        dec line
        call win4                      ;显示光标位置
        jmp first
right:                                 ;光标右移
        pos_get
        mov row,dh
        mov dl,line
        cmp line,79
        jnz direct2
        mov line,0
        inc row
        cmp row,24
        je  returns1       
        jmp first
direct2:
        inc  line
        call win4
        jmp first
enter_2:
        jmp enter
up:                                     ;上移光标
        pos_get
        mov row,dh
        mov dl,line
        dec row
        cmp row,0
        je  stop1
        call win4
        jmp first
stop1:  
        mov row,1
        jmp first
down:                                    ;下移光标
        pos_get
        mov row,dh
        mov dl,line   
        inc row
        cmp row,24
        je  stop3
        call win4
        jmp first
stop3:  
        mov row,23
        jmp first
returns1:
        jmp returns
enter:                                   ;回车换行
        pos_get
        mov row,dh
        mov line,dl
        inc row
        cmp row,24
        je  returns
        mov line,0
        call win4
        jmp first
returns:
        mov row,24
 	mov line,0
	jmp first
j6:     
        ret
com     endp
fuc_key proc near                 ;功能键子程序  
 next:  
        cmp ah,47h                ;home
        jz  home
        cmp ah,4fh                ;end
        jz  _end
        cmp ah,0eh                ;backspace
        jz  bak_sp
        cmp ah,53h
        jz  del
        cmp ah,44h                ;F10
        jz  help_0
        ret
help_0: call help
home:                             ;HOME键的功能
        pos_get
        mov row,dh
        mov line,0
       call win4
        jmp first    
_end:                             ;END键的功能
        pos_get
        mov row,dh
        mov line,79
       call win4
        jmp first
bak_sp:                           ;退格键的功能
        pos_get
        mov row,dh
        mov line,dl
        cmp line,0
        je  stop
        dec line
        jmp ab
stop:	
        mov line,0 
ab:     
        pos_get 0,row,line
        mov ah,2
        mov dl,00
        int 21h
        call win4
        jmp first
del:                                ;DEL删除
        pos_get
        mov row,dh
        mov line,dl
        dec line
        pos_get 0,row,line
        mov ah,2
        mov dl,00
        int 21h
        inc line
        call win4
        jmp first
cm:     
        cmp line,00
        jz  pos_cm
pos_cm:
        pos_curse 0,0,0
        jmp first
help proc near                       ;显示帮助信息
      call savedisplay               ;显示帮助信息每行的位置
      pos_get
      push dx
      win 0,57h,4,5,21,70
      pos_curse 0,6,25
      string help_mas1
      pos_curse 0,8,11
      string help_mas2
      pos_curse 0,10,11
      string help_mas3
      pos_curse 0,12,11
      string help_mas4
      pos_curse 0,14,11
      string help_mas5
      pos_curse 0,16,11
      string help_mas6
      pos_curse 0,18,11
      string help_mas7
      pop dx
      pos_curse 0,dh,dl
      mov  ah,0
      int  16h
      cmp  ah,36h                       ;F10 active help
      jnz  cls
      call help
cls:    
      win 0,1eh,9,10,13,70              ;清屏
      call backdisplay
help endp 
fuc_key endp
menu_show proc near                     ;显示菜单
        call savedisplay
        push cx
        cmp ah,3bh                      ;F1功能
        jz  menu_sh
        jmp char_get
menu_sh:                                ;定义菜单的背景字体颜色
        pos_get
        push dx
        win 0,06h,2,1,7,11
        win 0,65h,1,0,6,10
        pos_curse 0,1,0
        string manu_1
        string manu_2
        string manu_3
        string manu_4
        string manu_5
        pop dx
        dec dl
        pos_curse 0,dh,dl
copmar:    
        red_chr 
        cmp ah,50h                 
        jz  manu_n
        jmp manu_hid
manu_hid:                               ;菜单隐藏
        win 0,1eh,1,1,7,11
        call backdisplay
        jmp char_get
manu_n:					;开始定义各个菜单项
        win 0,65h,5,1,5,8
        pos_curse 0,5,0
        string manu_5
        win 0,15h,1,1,1,8
        pos_curse 0,1,0
        string manu_1
        red_chr
        cmp ah,48h
        je  manu_n
        cmp al,0dh
        jz  new_1
        cmp ah,50h
        je  manu_o
        jmp manu_hid
manu_n0:
        jmp manu_n
manu_o:
        win 0,65h,1,1,1,8
        pos_curse 0,1,0
        string manu_1
        win 0,15h,2,1,2,8
        pos_curse 0,2,0
        string manu_2
        red_chr
        cmp ah,48h
        je  manu_o
        cmp al,0dh
        jz open_1
        cmp ah,50h
        je  manu_s
        jmp manu_hid
new_1:  jmp new_2
manu_s:
        win 0,65h,2,1,2,8
        pos_curse 0,2,0
        string manu_2
        win 0,15h,3,1,3,8
        pos_curse 0,3,0
        string manu_3
        red_chr
        cmp al,0dh
        jz  save_1
        cmp ah,48h
        je  manu_s
        cmp ah,50h
        je  manu_a
        jmp manu_hid
open_1: jmp open_2
manu_n1:
        jmp manu_n
manu_a:
        win 0,65h,3,1,3,8
        pos_curse 0,3,0
        string manu_3
        win 0,15h,4,1,4,8
        pos_curse 0,4,0
        string manu_4 
        red_chr
        cmp ah,1ch
        jz  save_2
        cmp ah,48h
        je  manu_a
        cmp ah,50h
        je  manu_e
        jmp manu_hid
manu_n2:
        jmp manu_n1
new_2:  jmp new
save_1: call save
save_2: call saveas
manu_e:
        win 0,65h,4,1,4,8
        pos_curse 0,4,0
        string manu_4
        win 0,15h,5,1,5,8
        pos_curse 0,5,0
        string manu_5
        red_chr
        cmp ah,50h
        je  manu_n2
        cmp ah,48h
        je  manu_e
        cmp ah,1ch
        je  exit 
        jmp manu_hid
exit:
        call backdisplay
        win 0,07h,15,10,17,61
        win 0,24h,14,9,16,60
        mov dh,15
        mov dl,9
        mov bh,0
        mov ah,2
        int 10h
        lea  dx,message4
        mov ah,9     
        int 21h
        mov ah,1
        int 21h
        cmp al,79h                                    
        jnz q
        call quitt
q:      cmp al,6eh
        jz  quit
quit:   win 0,07h,0,0,24,79
        pos_curse 0,0,0
        mov ah,4ch
        int 21h
        ret
menu_show endp
new proc near                        ;新建文件
        pos_get
        push dx
        call backdisplay
        win 0,07h,15,10,17,61
        win 0,24h,14,9,16,60,
        mov dh,15
        mov dl,9
        mov bh,0
        mov ah,2
        int 10h
        lea dx,message1
        cmp al,0dh
        mov ah,9
        int 21h
        mov bx,0
all:
        mov ah,1
        int 21h
        cmp al,0dh
        je  alll
        mov path[bx],al
        inc bx
        jmp all
alll:
        win 0,3eh,15,9,17,61 
        pop dx
        pos_curse 0,dh,dl
        lea dx,path
        mov ah,3ch
        mov cx,00
        int 21h
        mov handle,ax
        mov bx,ax
        mov ah,3eh
        int 21h
        win 0,3eh,1,0,23,79
        mov dh,1
        mov dl,0
        mov bh,0
        mov ah,2
        int 10h
        jmp char_get
new     endp
open_2: jmp open
saveas  proc near                       ;另存为文件                                                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        win 0,3eh,1,0,6,10
        call backdisplay
        win 0,07h,15,10,17,61
        win 0,24h,14,9,16,60,
        mov dh,15
        mov dl,9
        mov bh,0
        mov ah,2
        int 10h
        lea dx,message2
        mov ah,9
        int 21h
        mov bx,0
bll: 
        mov ah,1
        int 21h
        cmp al,0dh
        je blll
        mov path[bx],al
        inc bx
        jmp bll
blll:
        pos_get
        push dx
        win 0,3eh,1,0,23,79
        call backdisplay
        pop dx
        pos_curse 0,dh,dl
        lea dx,path
        mov ah,3ch
        mov cx,00
        int 21h
        mov handle,ax
        lea dx,buffer
        mov bx,handle
        mov cx,2000
        mov ah,40h
        int 21h
        mov bx,handle
        mov ah,3eh
        int 21h
        call backdisplay 
        jmp char_get
saveas  endp
open proc near                            ;打开文件
        call backdisplay 
        win 0,07h,15,10,17,61    
        win 0,24h,14,9,16,60
        mov dh,15
        mov dl,9
        mov bh,0
        mov ah,2
        int 10h
        lea  dx,message3
        mov ah,9
        int 21h
        mov bx,0
cll: 
        mov ah,1
        int 21h
        cmp al,13
        je  clll
        mov path[bx],al
        inc bx
        jmp cll
clll:
        win 0,3eh,1,0,23,79
        lea dx,path
        mov ah,3dh
        mov al,0
        int 21h
        mov handle,ax
        lea dx,buffer
        mov bx,handle
        mov cx,2000
        mov ah,3fh
        int 21h
        win 0,3eh,1,23,1,79
        mov dh,1
        mov dl,0
        mov bh,0
        mov ah,2
        int 10h
        mov cx,1000
        sub bx,bx
replay:
        mov dl,buffer[bx]
        inc bx
        mov ah,2
        int 21h
        loop replay
        mov bx,handle
        mov ah,3eh
        int 21h
        mov dh,1
        mov dl,0
        mov bh,0
        mov ah,2
        int 10h
        mov cx,10
        mov bx,0
cleapath_3:
        mov bl,0
        mov path[bx],bl
        loop cleapath_3
        jmp char_get
open    endp
save proc near                               ;保存文件
        pos_get
        push dx
        win 0,3eh,1,0,6,10
        call backdisplay
        mov ah,path
        cmp ah,21h
        jl j_3
        jmp j_4
j_3: 
        win 0,07h,15,10,17,61
        win 0,24h,14,9,16,60,
        mov dh,15
        mov dl,9
        mov bh,0
        mov ah,2
        int 10h
        lea dx,message2
        mov ah,9
        int 21h
        mov bx,0
dll: 
        mov ah,1
        int 21h
        cmp al,0dh
        je dlll
        mov path[bx],al
        inc bx
        jmp dll
dlll:
        win 0,3eh,1,0,23,79
        pop dx
        pos_curse 0,dh,dl 
j_4:    lea dx,path
        mov ah,3ch
        mov cx,00
        int 21h
        mov handle,ax
        lea dx,buffer
        mov bx,handle
        mov cx,2000
        mov ah,40h
        int 21h
        mov bx,handle
        mov ah,3eh
        int 21h
        call backdisplay
        jmp char_get
save endp
savedisplay proc near
        push ax
        push bx
        push cx
        push dx
        push ds
        mov ax,0002h
        int 33h
        mov bx,0d
        mov cx,3840d
loop1:
        mov ax,0b800h
        mov ds,ax
        mov dl,ds:[bx]
        mov ax,data
        mov ds,ax
        mov bak[bx],dl
        inc bx
        loop loop1
        mov ax,0001h
        int 33h
        pop ds
        pop dx
        pop cx
        pop bx
        pop ax
savedisplay endp
backdisplay proc near
        push ax
        push bx
        push cx
        push dx
        push ds
        mov bx,0d
        mov cx,3840d
loop11:
        mov ax,data
        mov ds,ax
        mov dl,bak[bx]
        mov ax,0b800h
        mov ds,ax
        mov ds:[bx],dl
        inc bx
        loop loop11
        pop ds
        pop dx
        pop cx
        pop bx
        pop ax
        ret
backdisplay endp
quitt   proc near                     ;退出
        call backdisplay
        win 0,07h,15,10,17,61
        win 0,24h,14,9,16,60,
        mov dh,15
        mov dl,9
        mov bh,0
        mov ah,2
        int 10h
        lea dx,message2
        mov ah,9
        int 21h
        mov bx,0
qll: 
        mov ah,1
        int 21h
        cmp al,0dh
        je  qlll
        mov path[bx],al
        inc bx
        jmp qll
qlll:
        win 0,07h,15,10,17,61
        win 0,3eh,14,9,16,60
        call backdisplay
        lea dx,path
        mov ah,3ch
        mov cx,00
        int 21h
        mov handle,ax
        lea dx,buffer
        mov bx,handle
        mov cx,2000
        mov ah,40h
        int 21h
        mov bx,handle
        mov ah,3eh
        int 21h
        call backdisplay 
        win 0,07h,0,0,24,79
        mov ah,4ch
        int 21h
        ret
quitt   endp
edit    endp                                
win3    proc near                         ;显示日期
        mov ah,2ah
        int 21h
        mov  bl,10d
        mov  ax,0
        mov  al,dh
        div  bl 
        add  ax,3030h
        mov  [date+6],al                    
        mov  [date+7],ah
        mov  ax,0
        mov  al,dl
        div  bl
        add  ax,3030h
        mov  [date+9],al
        mov  [date+10],ah
        win 0,1dh,0,67,0,79
        pos_curse 0,0,67
        mov  dx,offset date
        mov  ah,09h
	int  21h
        ret
win3    endp
win4    proc  near                             ;显示行//列 
        mov ah,03h
        mov bh,0
        int 10h                                    
        mov  bl,100d
        mov  bh,10d
        mov  ax,0
        mov  al,dh
        div bl 
        add  al,30h                              
        mov  [hanglie+0],al
        mov al,ah      
        mov ah,0                                    
        div bh  
        add ax,3030h
        mov [hanglie+1],al
        mov [hanglie+2],ah                                                      
        mov  ax,0                                       
        mov  al,dl
        div bl 
        add  al,30h                            
        mov  [hanglie+5],al
        mov al,ah      
        mov ah,0                                  
        div bh  
        add ax,3030h
        mov [hanglie+6],al
        mov [hanglie+7],ah
        win 0,1dh,24,60,24,70
        pos_curse 0,24,61
        mov  dx,offset hanglie
        mov  ah,09h
        int  21h
        ret
win4    endp
code    ends                           
        end start                          ;结束
      
