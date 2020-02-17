.486
;���߻����Ӧ������486������������ߣ���α���롣

.model flat, stdcall
;ʹ��ƽ̹�ڴ�ģʽ��ʹ��stdcall����ϰ��,�����Ĳ�����������ѹ��

option casemap:none
;�����ַ���ӳ��Ϊ��д��Ϊ��Windows.inc�ļ����������������Ӧ��Ϊ��none��

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\gdi32.lib
includelib \masm32\lib\msvcrt.lib
includelib \masm32\lib\masm32.lib

include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc
include \masm32\include\windows.inc
include \masm32\include\msvcrt.inc
include \masm32\include\masm32.inc
include \masm32\macros\macros.asm
;Ϊ��ʹ������WindowsAPI�ĺ���������Ҫ����dll�Ͱ����ļ�
.data
    kernel             dd 00 ; ��¼kernel�Ļ���ַ
    L                  dd 00 ; ��¼LoadLibraryA�ĵ�ַ
    G                  dd 00 ; ��¼GetProcAdress�ĵ�ַ
    kernelTip          db "The address of Kernel32.dll base is %x",0
    load               db "The address of LoadLibraryA is %x",0
    get                db "The address of GetProcAdress is %x",0

.code
start:
assume fs:nothing
push eax
push esi
push ebx
push edi
push ecx
push ebp
push 00000000h
push 41797261h    ; �ַ���LoadLibraryA��16����asicc��
push 7262694ch
push 64616f4ch

mov L, esp        ; ��¼�ַ�LoadLibraryA�ĵ�ַ

push 00007373h    ; GetProcAddress
push 65726464h
push 41636f72h
push 50746547h

mov G, esp        ; ��¼�ַ�GetProcAdress�ĵ�ַ
        
xor eax, eax
mov eax, fs:30h ;PEB    
mov eax, dword ptr [eax+0ch]    ; PROCESS_ MODAULE_INFO
mov esi, dword ptr [eax+1ch]    ; InInitOrder.flink
lodsd                           ; eax=InInitOrder.flink
mov ebx, [eax+08h]              ; ebx=kernel32.dll base address
mov kernel,ebx                  ; ���kernel�Ļ���ַ
push eax
push ebx
invoke crt_printf,addr kernelTip
add esp,4
print chr$(" ",13,10)
pop eax

push L                          ; ���ַ���LoadLibrary���׵�ַ��Ϊ��������
push 0bh                        ; ���ַ����ĳ�����Ϊ��������
call GetProAddess_fun           ; ���ú���
mov dword ptr L, eax            ; �Ѻ������������
add esp,8                       ; ƽ��ջ

push eax
invoke crt_printf,addr load
add esp,4
print chr$(" ",13,10)

push G                          ; ���ַ���GetProcAddress���׵�ַ��Ϊ��������
push 0dh                        ; �����ַ���GetProcAdress�ĳ���
call GetProAddess_fun           ; ���ú���
mov dword ptr G,eax             ; ��ú�������ֵ
add esp,8                       ; ƽ��ջ

push eax
invoke crt_printf,addr get
add esp,4
print chr$(" ",13,10)

add esp,20h                     ; �ջ���ʱ�����ռ䣬ƽ��ջ
pop ebp                         ;
pop ecx                         ; �ָ��ֳ�
pop edi
pop ebx
pop esi
pop eax
ret
GetProAddess_fun:
    mov  esi,[ebx+03Ch]    ; ���PEͷ��Ե�ַ
    mov  esi,[ebx+esi+078h]; ��õ�����ƫ�Ƶ�ַ
    add  esi,ebx           ; ��õ������VA
    
    push esi               ; ������������VA
    push ebp
    mov ecx, dword ptr [esi + 014h]  ; ������ƫ14h����ź����ĸ���
        
    mov eax, [esi+020h]              ; ��ú������Ʊ�ƫ�Ƶ�ַ
    add eax, ebx                     ; ��ú������Ʊ�VA
    
    mov ebp, eax
    xor edx, edx                     ; ��edx��¼����
    
    find_start:
        push ecx
        
        mov eax, dword ptr [eax]    ; ��ú������Ʊ��д�ŵ��ַ�����ƫ�Ƶ�ַ       
        add eax, ebx                ; ��ú��������Ƶ�ʵ�ʵ�ַ
        mov edi, eax                ; ���ַ�����VA��ֵ��edi�����Ƚ�׼��
        
        mov esi, dword ptr [esp + 14h]    ; ��ô���Ĳ�������Ҫ��Ҫ���ַ������ַ��׵�ַ
        mov ecx, dword ptr [esp + 10h]    ; ����ַ�����
        
        cld                               ;
        repz cmpsb                        ; ����αָ����бȽ�
        je find                           ; ��������ַ���Ⱦʹ����ҵ���
                                          ; ���Ҳ���
        inc edx                           ; ������1
        add ebp, 4                        ; �������Ʊ�ĵ�ַ��4
        mov eax, ebp                      ; ��ֵ����eax
        pop ecx
        loop find_start                 
    find:
    add esp,4           ; ƽ��ջ
    pop ebp             ; �ָ�ebpֵ
    pop esi             ; �ָ�esi���������ַ
    
    mov edi, [esi+24h]  ; AddressofNameOrdinals
    add edi, ebx
    shl edx, 1
    movzx ecx,word ptr [edi+edx] ; ��ñ�NameOrdinals�д�ŵĺ������
    mov edi, [esi+1Ch]           ; ��ñ�AdressofFunction��ƫ�Ƶ�ַ
    add edi, ebx                 ; ��ñ�AdressofFunction��VA
    shl ecx, 2
    mov eax, [edi+ecx]           ; �����Ѱ�Һ�����ƫ�Ƶ�ַ
    add eax, ebx                 ; �����Ѱ�Һ�����RVA���������eax����Ϊ����ֵ
    ret
end start