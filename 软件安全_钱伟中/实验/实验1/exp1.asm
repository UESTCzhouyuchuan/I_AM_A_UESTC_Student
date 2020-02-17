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

.data               ;数据段
    a dd 0
    b dd 0
.code               ;代码段
start:              ;程序开始的标志
    push ebp        ;保存上一个栈的栈底，所白了就是备份，方便后续回复
    mov ebp,esp     ;把上一个栈的栈顶，当做当前栈的栈底，相当于创造了一个新的栈
    sub esp,0D8h    ;为当前栈预留本地变量的空间
    push ebx        ;
    push esi        ;
    push edi        ;保护寄存器的值
    lea edi,[ebp+0FFFFFF28h]    ;
    mov ecx,36h                 ;
    mov eax,0CCCCCCCh           ;
    rep stos dword ptr es:[edi] ;初始化
    mov esi,esp                 ;保存esp值
    print chr$("this is a simple")
    print chr$(" ",13,10)
    print chr$("program you are analyzing now")
    print chr$(" ",13,10)
    mov dword ptr [ebp-8],39h   ;
    mov dword ptr [ebp-14h],3Ch ;初始化本地变量，所以是栈低减一个数值(进栈)
    mov eax,dword ptr [ebp-8h]  ;
    mov ecx,dword ptr [ebp-14h] ;因为寄存器的锁机制，存入值后读取一次后，寄存器就会释放，所以要再存一次。
    .IF eax <= ecx              ;伪指令比较,相当于条件转址,注意点：其中至少一个值在寄存器中
                                ;例如：把值mov给data中定义的变量a,b，然后.IF a<b，这样会报错
        mov eax,dword ptr [ebp-14h]     ;
        push eax                        ;
        mov ecx,dword ptr [ebp-8h]      ;
        push ecx                        ;把参数按从右到左顺序压入栈中,同样需要重新读
        call fun                        ;调用函数
        add esp,8                       ;这里加8的原因是函数参数占用8字节,因为函数已经执行完，所以回收栈
    .ELSE
        print chr$("hello")
    .ENDIF
    mov dword ptr [ebp-14h],32h
    mov eax,dword ptr [ebp-8h]
    mov ecx,dword ptr [ebp-14h]
    .IF eax > ecx
       mov eax,dword ptr [ebp-14h]
       push eax
       mov ecx,dword ptr [ebp-8h]
       push ecx
       call fun
       add esp,8                        ;这里同上理
    .ENDIF
    print chr$("this is true end! but you should not relax yourself!!! Be careful")
    print chr$(" ",13,10)
    print chr$("trap")
    print chr$(" ",13,10)
    mov eax,dword ptr [ebp-8]
    pop edi                             ;
    pop esi                             ;
    pop ebx                             ;
    add esp,0D8h                        ;
    mov esp,ebp                         ;
    pop ebp                             ;这里的作用就是恢复现场
    ret
    
    fun:
    push ebp
    mov ebp,esp                         ;把上一个状态保存下来，创造一个新栈
    sub esp,0CCh
    push ebx                            ;
    push esi                            ;
    push edi                            ;保存寄存器值
    lea edi,[ebp+0FFFFFF34h]
    mov ecx,33h
    mov eax,0CCCCCCCh                   ;初始化
    rep stos dword ptr es:[edi]
    mov eax,dword ptr [ebp+8h]          ;解释：当前栈低ebp是上一状态栈的栈顶esp,上一个栈的栈顶是call产生的下一条指令的ip地址,->
                                        ;倒数第二个是参数a，倒数第三个是参数b，示意图: 高地址->[参数b,参数a,ip地址(call指令的下一条)]->低地址
                                        ;所以说[ebp+8]是参数a，[ebp+0Ch]是参数b
    mov a,eax                           
    print chr$("The value of A is ")
    print str$(a)
    print chr$(" ",13,10)
    mov ecx,dword ptr [ebp+0Ch]         ;获取参数b，道理同上
    mov b,ecx
    print chr$("The value of B is ")
    print str$(b)
    print chr$(" ",13,10)
    mov eax,dword ptr [ebp+8h]
    mov ecx,dword ptr [ebp+0Ch]
    .IF eax < ecx
        mov eax, dword ptr [ebp+0Ch]
        sub eax, dword ptr [ebp+8]
        mov dword ptr [ebp-8],eax
    .ELSE
        mov eax,dword ptr [ebp+8]
        sub eax,dword ptr [ebp+0Ch]
        mov dword ptr [ebp-8],eax
    .ENDIF                          ; 通俗讲：大的减小的，将结果保存在[ebp-8]
    mov esi,esp
    mov eax,dword ptr [ebp-8]
    push eax
    print chr$("their sum is ")
    mov eax,dword ptr [ebp-8]
    print str$(eax)
    print chr$(" ",13,10)
    print chr$("can you have ")
    print chr$("the ability of ")
    print chr$("reverse analysis")
    print chr$(" ",13,10)
    mov eax,dword ptr [ebp-8]
    pop edi
    pop esi
    pop ebx
    add esp,0CCh
    mov esp,ebp
    pop ebp                     ;恢复现场
    ret                         ;返回上一个状态
end start