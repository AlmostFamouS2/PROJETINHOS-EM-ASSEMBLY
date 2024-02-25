%include 'lib.inc'

section .rodata
msg1: db 'numero 1: ',0
msg2: db 0xa,'numero 2: '
len equ $ - msg2

section .bss
	num1 resd 0;   dd = DWORD
	num2 resd 0;   dd = DWORD

section .text
	global _start

_start:
; Write 1
    mov ecx, msg1
    mov edx, len
    call print
;  READ 1
    mov ecx, num1
    mov edx, 0x4
    call input

; Write 2
    mov ecx, msg2
    mov edx, len
    call print
; Read 2
    mov ecx, num2
    mov edx, 0x4
    call input

    mov ecx, num1
    mov edx, 0x4
    call print

exit:
    mov eax, SYS_EXIT  ;0x1
    syscall
