data            segment
file             db    'c:\masm\l.txt' , 0       ;�ļ���
buf             db   256 dup(0)        ;�ļ������ݴ���
error_message    db   0ah , 'error !' , '$'    ;����ʱ����ʾ
handle           dw  ?                ;�����ļ���
data             ends
code            segment
                assume  cs:code  , ds:data
start:
              mov ax , data
              mov ds , ax
              mov dx , offset file
              mov al , 0
              mov ah , 3dh
              int 21h                  ;���ļ�
              jc error                  ;���򿪳���תerror
              mov handle , ax           ;�����ļ���
              mov bx , ax
              mov cx , 255
              mov dx , offset buf
              mov ah , 3fh
              int 21h                  ;���ļ��ж�255�ֽڡ�buf
              jc error                  ;��������תerror
              mov bx , ax              ;ʵ�ʶ������ַ�������bx
              mov buf[bx] , '$'          ;���ļ�����������һ��$����
              mov dx , offset buf
              mov ah , 9
              int 21h                            ;��ʾ�ļ�����
              mov bx , handle
              mov ah , 3eh
              int 21h                            ;�ر��ļ�
              jnc end1             ;���رչ����޴�ת��end1������dos
error:
              mov dx , offset error_message
              mov ah , 9
              int 21h                            ;��ʾ������ʾ
end1:
             mov ah , 4ch
             int 21h
code   ends
             end  start
