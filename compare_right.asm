section .rodata
  msg1:
      db 'abcd',0xa, 0   ; SEMPRE COLOCAR O ZERO NO FINAL

  ha: db ' == ',0

  msg2:
      db 'bbcd',0   ; SEMPRE COLOCAR O ZERO NO FINAL

c: db 'certo'
r: db 'errado'
;---------------------------------------------------------

section .text
global _start

_start:
        lea rsi,[msg2]
        lea rdi,[msg1]

        mov eax,1
        push rdi   ; Salvando o conteudo de rdi
        mov edi,eax
        mov edx,5
        ;push rdx  Desnecessario pq rdx nao eh afetado
        push rsi
        syscall

        mov eax,1
        mov edi,eax
        lea rsi,[ha]
        syscall

        pop rsi
        pop rdi
        push rsi
        xchg rsi,rdi   ; TROCANDO OS VALORES
        mov eax,1
        mov edi,eax
        ; pop rdx   Desnecessario pq RDX nao eh afetado
        syscall

        pop rdi
        xor edx,edx
        call strlen

        sub rdi,rdx

        jmp te

end:
    mov eax,60
        xor edi,edi
        syscall

certo:
    mov eax,1
    mov edi,1
        mov edx,5
        lea rsi,[c]
        syscall
        jmp end

strlen:
        inc edx
        inc rdi
    cmp byte [rdi],0
        jnz strlen
        ret

te:
        test edx,edx
        jz certo
        cmpsb     ; ISSO AQUI JA INCREMENTA AMBOS.  Nao precisa usar inc rsi, nem inc rdi
    jnz wrong
        dec edx
        jmp te

wrong:
    mov eax,1
    mov edi,1
        mov edx,6
        lea rsi,[r]
        syscall
        jmp end
