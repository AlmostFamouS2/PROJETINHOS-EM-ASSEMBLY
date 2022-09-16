; The number will be in the rax in _start before calling the primes test sub-routine

section .rodata
n_prime: db 'O NUMERO NAO EH PRIMO!',0xa,0
len equ $ - n_prime
prime: db 'O NUMERO EH PRIMO',0xa,0
len2 equ $ - prime

section .text

global _start

primes:
        push rax  ; Saving on the stack
        cdq
        idiv rbx
    test edx,edx
        je not_prime
        pop rax  ; Returning from the stack
        add rbx,0x2
        cmp rax,rbx
        jnz primes
        ret

primo:
   mov eax,1
   mov edi,eax
   mov edx,len2
   lea rsi, [prime]
   syscall
   jmp end

not_prime:
   mov eax,1
   mov edi,eax
   mov edx,len
   lea rsi, [n_prime]
   syscall

end:
        mov eax,60
        xor edi,edi
        syscall

_start:
        mov rbx,0x3
        mov rax,2305843009213693953

   mov rcx,rax
   and rcx,0x1
   test rcx,rcx
   jz not_prime

        call primes
        jmp primo
