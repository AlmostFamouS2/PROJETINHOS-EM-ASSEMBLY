;  acabei de reparar que  section = segment.   Eh um alias

segment .rodata
    SYS_READ  equ 0x0    ; operaçao de leitura
    SYS_WRITE equ 0x1    ; Output System Call code func
    STD_OUT   equ 0x1    ; valor de saida padrao
    STD_IN    equ 0x0    ; entrada padrao
    SYS_EXIT  equ 0x1    ; codigo de chamada para finalizar o programa
    ;SYS_CALL  equ 0x80    ; syscall  (x86)
        NL      db 0xa,0

        SYS_OPEN equ 0x2
        SYS_CLOSE equ 0x3
        OPEN_READ   equ 0x0   ; Arquivo para leitura
        OPEN_WRITE  equ 0x1   ; Arquivo para escrita
        OPEN_RW     equ 0x2   ; Arquivo para leitura/escrita
        OPEN_CREATE equ 0x40  ; Se o arquivo não existe, cria
        OPEN_APPEND equ 0x400 ; Arquivo para adição de informação

        SEEK_SET      equ 0x0    ; Inicio do Arquivo
        SEEK_CUR      equ 0x1    ; Posição do Cursor
        SEEK_END      equ 0x2    ; Final do Arquivo

input:
    mov eax, SYS_READ
    mov ebx, STD_IN
    int SYS_CALL
    ret

print:
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
    ;pusha
    ;int SYS_CALL
    ;popa
    ret

pstr:
        call strlen
        mov rsi, rcx
        mov eax, SYS_WRITE
        mov ebx, STD_OUT
        syscall
        ;call print
        ret

nw:
    mov rsi, NL
        mov edx,0x1
        call print
        ret

; ----------------------------------------------------------------------------------------------------------------------------------------

  ; [ + ] PARA O PROGRAMA ABAIXO FUNCIONAR, EH PRECISO ADICIONAR
  ; O SEGUINTE TRECHO DE CODIGO NO PROGRAMA PRINCIPAL

  ;section .bss
  ;     digitSpace resb 100   ; Isso que vai de fato salvar a string
  ;     digitSpacePos resb 8  ; Isso vai salvar os enderecos de memoria da string atuais

; ----------------------------------------------------------------------------------------------------------------------------------------


exit:
    mov eax,60
        xor edi,edi
        syscall

; -------------------------------------------------------------------------------->
;   -----------------------------------
;   [+[ calcular o tamanho da string
;   -----------------------------------
;   Entrada: valor da string em ECX
;   Saida:   tamanho da string em EDX
;   -----------------------------------

strlen:
    mov rdx, rcx

loop:
    cmp byte[rcx], 0
    jz fin
    inc rdx
    jmp loop

fin:
    sub rdx, rcx
    ret
