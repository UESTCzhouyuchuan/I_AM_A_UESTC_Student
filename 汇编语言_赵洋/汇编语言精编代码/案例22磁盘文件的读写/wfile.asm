data            segment
file            db     'c:\masm\l.txt' , 0           ;创建文件的文件名
buf            db      'this is a test !'       ;写到文件中去的内容
error_message   db     0ah , 'error !' , '$'     ;出错时的提示
message        db     0ah , 'ok !$'          ;操作成功后的提示
handle          dw    ?                    ;保存文件号
data           ends
code           segment
              assume  cs:code  , ds:data
start:
              mov ax , data
              mov ds , ax
              mov dx , offset file
              mov cx , 0
              mov ah , 3ch
              int 21h               ;创建文件，若磁盘上原有此文件，则覆盖
              jc error               ;创建出错，转error处
              mov handle , ax         ;保存文件号
              mov bx , ax
              mov cx , 16 
              mov dx , offset buf
              mov ah , 40h
              int 21h                          ;向文件中写入16个字节内容
              jc error                          ;写出错，转error处
              mov bx , handle
              mov ah , 3eh
              int 21h                          ;关闭文件
             jc error                           ;关闭文件出错，转error处
             mov dx , offset message
              mov ah , 9
              int 21h                            ;操作成功后显示提示
              jmp end1
error:
              mov dx , offset error_message
              mov ah , 9
              int 21h                              ;显示错误提示`
end1:
              mov ah , 4ch
              int 21h
code   ends
             end  start
