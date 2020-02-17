.486
;告诉汇编器应该生成486处理器（或更高）的伪代码。

.model flat, stdcall
;使用平坦内存模式并使用stdcall调用习惯,函数的参数从右往左压入

option casemap:none
;控制字符的映射为大写。为了Windows.inc文件能正常工作，这个应该为”none”

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
;为了使用来自WindowsAPI的函数，你需要导入dll和包含文件
.data
    kernel             dd 00 ; 记录kernel的基地址
    L                  dd 00 ; 记录LoadLibraryA的地址
    G                  dd 00 ; 记录GetProcAdress的地址
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
push 41797261h    ; 字符串LoadLibraryA的16进制asicc码
push 7262694ch
push 64616f4ch

mov L, esp        ; 记录字符LoadLibraryA的地址

push 00007373h    ; GetProcAddress
push 65726464h
push 41636f72h
push 50746547h

mov G, esp        ; 记录字符GetProcAdress的地址
        
xor eax, eax
mov eax, fs:30h ;PEB    
mov eax, dword ptr [eax+0ch]    ; PROCESS_ MODAULE_INFO
mov esi, dword ptr [eax+1ch]    ; InInitOrder.flink
lodsd                           ; eax=InInitOrder.flink
mov ebx, [eax+08h]              ; ebx=kernel32.dll base address
mov kernel,ebx                  ; 获得kernel的基地址
push eax
push ebx
invoke crt_printf,addr kernelTip
add esp,4
print chr$(" ",13,10)
pop eax

push L                          ; 把字符串LoadLibrary的首地址作为参数传入
push 0bh                        ; 把字符串的长度作为参数传入
call GetProAddess_fun           ; 调用函数
mov dword ptr L, eax            ; 把函数结果存下来
add esp,8                       ; 平衡栈

push eax
invoke crt_printf,addr load
add esp,4
print chr$(" ",13,10)

push G                          ; 把字符串GetProcAddress的首地址作为参数传入
push 0dh                        ; 传入字符串GetProcAdress的长度
call GetProAddess_fun           ; 调用函数
mov dword ptr G,eax             ; 获得函数返回值
add esp,8                       ; 平衡栈

push eax
invoke crt_printf,addr get
add esp,4
print chr$(" ",13,10)

add esp,20h                     ; 收回临时变量空间，平衡栈
pop ebp                         ;
pop ecx                         ; 恢复现场
pop edi
pop ebx
pop esi
pop eax
ret
GetProAddess_fun:
    mov  esi,[ebx+03Ch]    ; 获得PE头相对地址
    mov  esi,[ebx+esi+078h]; 获得导出表偏移地址
    add  esi,ebx           ; 获得导出表的VA
    
    push esi               ; 存起来导出表VA
    push ebp
    mov ecx, dword ptr [esi + 014h]  ; 导出表偏14h存放着函数的个数
        
    mov eax, [esi+020h]              ; 获得函数名称表偏移地址
    add eax, ebx                     ; 获得函数名称表VA
    
    mov ebp, eax
    xor edx, edx                     ; 用edx记录索引
    
    find_start:
        push ecx
        
        mov eax, dword ptr [eax]    ; 获得函数名称表中存放的字符串的偏移地址       
        add eax, ebx                ; 获得函数的名称的实际地址
        mov edi, eax                ; 把字符串的VA赋值给edi，做比较准备
        
        mov esi, dword ptr [esp + 14h]    ; 获得传入的参数，即要需要的字符串的字符首地址
        mov ecx, dword ptr [esp + 10h]    ; 获得字符个数
        
        cld                               ;
        repz cmpsb                        ; 调用伪指令进行比较
        je find                           ; 如果两个字符相等就代表找到了
                                          ; 若找不到
        inc edx                           ; 计数加1
        add ebp, 4                        ; 函数名称表的地址加4
        mov eax, ebp                      ; 把值赋给eax
        pop ecx
        loop find_start                 
    find:
    add esp,4           ; 平衡栈
    pop ebp             ; 恢复ebp值
    pop esi             ; 恢复esi即导出表地址
    
    mov edi, [esi+24h]  ; AddressofNameOrdinals
    add edi, ebx
    shl edx, 1
    movzx ecx,word ptr [edi+edx] ; 获得表NameOrdinals中存放的函数序号
    mov edi, [esi+1Ch]           ; 获得表AdressofFunction的偏移地址
    add edi, ebx                 ; 获得表AdressofFunction的VA
    shl ecx, 2
    mov eax, [edi+ecx]           ; 获得所寻找函数的偏移地址
    add eax, ebx                 ; 获得所寻找函数的RVA，并存放在eax中作为返回值
    ret
end start