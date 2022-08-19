; nasm test.asm -felf64 && ld test.o -o test -z noseparate-code
bits 64

section .rodata
certo: db 'PRIMEIRO FOI MAIOR',0xa,0
len equ $ - certo

errado: db 'SEGUNDO FOI MAIOR',0xa,0
len2 equ $ - errado

ig: db 'OS DOIS SAO IGUAIS!',0xa,0
len3 equ $ - ig

no_argv: db 'VOCE PRECISA DIGITAR 2 NUMEROS!',0xa,0
len_error equ $ - no_argv

; ------------------------------ CODE ------------------------------------------------------------------------------------------->
section .text

global _start

; -------------------------- STRLEN --------------------->
strlen_compare2:
   inc edx   ; Para fazer o loop depois na funcao strcomp
   inc rdi
   inc rsi

   cmp byte [rdi], 0x0
   jz another_check

   cmp byte [rsi], 0x0   ; Se esse ja tiver terminado e o outro nao, (o que aconteceria caso a comparacao acima nao ocorrer) entao o primeiro eh maior que o segundo.
   jz primeiro
   jmp strlen_compare2
; ------------------------------------------------------->

another_check:
    cmp byte [rsi], 0x0
    jnz segundo

  ; Se tiverem o mesmo numero de digitos, entao...  Outra comparacao...
    pop rsi   ; r15  (segundo numero)
    pop rdi   ; r14  (primeiro numero)

        mov r13b, byte[rsi]   ; Isso pois nao se pode fazer  (cmp byte [rdi], byte [rsi])
    cmp byte [rdi], r13b   ; (argv[1][0] > argv[2][0])
    je strcomp
    jg primeiro
    jl segundo

; ---------------------------------------------------------------------------------------------------------------------------------------------------------
; Lembrando que isso so vai ser executado caso os dois numeros tiverem a mesma quantidade de digitos.  O que ficara em EDX, por isso uso ele aqui.
strcomp:
  mov r13b, byte[rsi]   ; Isso pois nao se pode fazer  (cmp byte [rdi], byte [rsi])
  cmp byte [rdi], r13b
  jg primeiro
  jl segundo

  inc rsi
  inc rdi

  dec edx
  cmp edx, 0   ; for(int len; len != 0; len--)
  jz iguais

jmp strcomp   ; Tinha dado problema, tive que debuggar e a solução foi trocar o (call strcomp por jmp strcomp)

primeiro:
   mov eax,1
   mov edi,eax
   mov edx,len
   lea rsi, [certo]
   syscall

   xor edi,edi   ; return 0  (Sucessful)
   jmp end
; ------------------------------------------------------->

_start:
   mov edi,1   ; return 1  (error)
   cmp byte [rsp], 3
   jnz error

   mov r14, [rsp + 0x10]  ; ==  argv[1]  |  argv[0] == [rsp + 0x8] | argv[2] == [rsp + 0x18]
   mov r15, [rsp + 0x18]

   xor edx,edx  ; edx = 0x0
   mov rdi, r14  ; Pegando o primeiro numero
   mov rsi, r15

   push r14  ; Salvando o primeiro numero
   push r15  ; Salvando o segundo numero

   jmp strlen_compare2   ; Retorna a quantidade da String em edx

; --------------   MENOR  --------------------------------->

segundo:
   mov eax,1
   mov edi,eax
   mov edx,len2
   lea rsi, [errado]
   syscall
   xor edi,edi   ; return 0  (Sucessful)

end:
   mov eax,60
   syscall

error:
   mov eax,1
   ; mov edi,eax  ---> Nem precisa porque edi ja estara setado com 1
   mov edx,len_error
   lea rsi, [no_argv]
   syscall
   jmp end

iguais:
   mov eax,1
   mov edi,eax
   mov edx,len3
   lea rsi, [ig]
   syscall

   xor edi,edi   ; return 0  (Sucessful)
   jmp end
