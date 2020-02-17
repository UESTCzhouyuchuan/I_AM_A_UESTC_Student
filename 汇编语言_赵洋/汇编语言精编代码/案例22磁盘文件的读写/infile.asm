data            segment
file             db    'c:\masm\l.txt' , 0       ;文件名
buf             db   256 dup(0)        ;文件内容暂存区
error_message    db   0ah , 'error !' , '$'    ;出错时的提示
handle           dw  ?                ;保存文件号
data             ends
code            segment
                assume  cs:code  , ds:data
start:
              mov ax , data
              mov ds , ax
              mov dx , offset file
              mov al , 0
              mov ah , 3dh
              int 21h                  ;打开文件
              jc error                  ;若打开出错，转error
              mov handle , ax           ;保存文件号
              mov bx , ax
              mov cx , 255
              mov dx , offset buf
              mov ah , 3fh
              int 21h                  ;从文件中读255字节→buf
              jc error                  ;若读出错，转error
              mov bx , ax              ;实际读到的字符数送入bx
              mov buf[bx] , '$'          ;在文件结束处放置一“$”符
              mov dx , offset buf
              mov ah , 9
              int 21h                            ;显示文件内容
              mov bx , handle
              mov ah , 3eh
              int 21h                            ;关闭文件
              jnc end1             ;若关闭过程无错，转到end1处返回dos
error:
              mov dx , offset error_message
              mov ah , 9
              int 21h                            ;显示错误提示
end1:
             mov ah , 4ch
             int 21h
code   ends
             end  start
