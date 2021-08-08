section .rodata
err: db 'DIGITE PELO MENOS 1 ARGUMENTO!',0xa
len equ $ - err
msg: db 'REVERSA ====> '
len2 equ $ - msg


section .text
global _start

_start:
  mov eax,1
  cmp byte [rsp],1   ; if (argc != 1)
  jz error           ; error();
  mov rsi,[rsp+16]   ; else  {  char *ok = &argv[1] }
  mov rdi,rsi        ; strcpy(new, ok);
  xor edx,edx
  call strlen		 ; strlen(new);
  mov word [rsi+rdx], `\n`
  push rsi
  inc edx  ; NECESSARIO, POIS VAI INCLUIR O \n
  push rdx
  mov edi,eax
  syscall

  lea rsi,[msg]
  mov edx,len2
  mov eax,1
  mov edi,eax
  syscall

  pop rdx
  pop rsi

  mov byte [rsi-1], `\n`
  lea rsi, [rsi+rdx-2]
; ------------------------>  Loop para ir chamando letra por letra em ordem reversa.
.loop:
  push rdx
  call print
  pop rdx
  dec rsi
  dec edx
  cmp edx,0
  jnz .loop

  xor edi,edi

end:
  mov eax,60
  syscall

;  ============>  FUNCAO DE ERRO, CASO ARGC == 1 =============================>
error:
  mov eax,1
  mov edi,eax
  mov edx,len
  lea rsi,[err]
  syscall
  mov edi,1
  jmp end
 ; -------------------->   Calcular o tamanho da string feito em 5 linhas de assembly
strlen:
  inc edx
  inc rdi
  cmp byte [rdi],0
  jnz strlen
  ret
;  --------------------->   Apenas uma subrotina para ir mostrando na tela nos conformes ==============>
print:
  mov eax,1
  mov edx,eax
  mov edi,eax
  syscall
  ret
