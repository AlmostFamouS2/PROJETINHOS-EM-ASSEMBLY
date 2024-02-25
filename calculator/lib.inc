segment .rodata
    SYS_WRITE equ 0x4    ; Output System Call code func
    STD_OUT   equ 0x1    ; valor de saida padrao
    STD_IN    equ 0x0    ; entrada padrao
    SYS_READ  equ 0x3    ; operaçao de leitura
    SYS_EXIT  equ 0x1    ; codigo de chamada para finalizar o programa
    SYS_CALL  equ 0x80    ; syscall

input:
    mov eax, SYS_READ
    mov ebx, STD_IN
    int SYS_CALL
    ret

print:
	mov eax, SYS_WRITE
	mov ebx, STD_OUT
    ;pusha
    int SYS_CALL
    ;popa
    ret
; -------------------------------------------------------------------------------->
;   -----------------------------------
;   [+[ calcular o tamanho da string
;   -----------------------------------
;   Entrada: valor da string em ECX
;   Saida:   tamanho da string em EDX
;   -----------------------------------

tamStr:
    mov EDX, ECX

proxchar:
    cmp byte[EDX], NULL
    jz fin
    inc EDX
    jmp proxchar

fin:
    sub EDX, ECX
    ret
