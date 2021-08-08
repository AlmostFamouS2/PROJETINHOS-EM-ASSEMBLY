section .rodata
msg: db 'Hello World!', 0xa
length equ $ - msg

section .text

global _start

_start:
    mov rcx, 5
    call loop
    jmp exit

loop:
    call nn
    dec rcx
    test ecx,ecx
    jne loop
	ret
	
nn:
    push rcx
    mov eax,1
    mov edi,eax
    mov edx, length
    lea rsi, [msg]
    syscall
    pop rcx
    ret
    
exit:
    mov eax,60
    xor edi,edi
    syscall
