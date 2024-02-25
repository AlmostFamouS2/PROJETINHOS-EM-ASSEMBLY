NOME = c

all: $(NOME).o
	ld -m elf_i386 -o $(NOME) $(NOME).o
	rm -rf *.o

%.o: %.asm
	nasm -f elf  $<
