data            segment
file            db     'c:\masm\l.txt' , 0           ;�����ļ����ļ���
buf            db      'this is a test !'       ;д���ļ���ȥ������
error_message   db     0ah , 'error !' , '$'     ;����ʱ����ʾ
message        db     0ah , 'ok !$'          ;�����ɹ������ʾ
handle          dw    ?                    ;�����ļ���
data           ends
code           segment
              assume  cs:code  , ds:data
start:
              mov ax , data
              mov ds , ax
              mov dx , offset file
              mov cx , 0
              mov ah , 3ch
              int 21h               ;�����ļ�����������ԭ�д��ļ����򸲸�
              jc error               ;��������תerror��
              mov handle , ax         ;�����ļ���
              mov bx , ax
              mov cx , 16 
              mov dx , offset buf
              mov ah , 40h
              int 21h                          ;���ļ���д��16���ֽ�����
              jc error                          ;д����תerror��
              mov bx , handle
              mov ah , 3eh
              int 21h                          ;�ر��ļ�
             jc error                           ;�ر��ļ�����תerror��
             mov dx , offset message
              mov ah , 9
              int 21h                            ;�����ɹ�����ʾ��ʾ
              jmp end1
error:
              mov dx , offset error_message
              mov ah , 9
              int 21h                              ;��ʾ������ʾ`
end1:
              mov ah , 4ch
              int 21h
code   ends
             end  start
