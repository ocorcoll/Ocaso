all: kernel

boot.bin: 
	nasm src/boot/boot.asm -f bin -o bin/boot.bin

kernel.o: src/kernel/kernel.c src/drivers/screen.c
	gcc -m32 -ffreestanding -c $< -o bin/kernel.o

kernel_entry.o: src/kernel/kernel_entry.asm
	nasm src/kernel/kernel_entry.asm -f elf -o bin/kernel_entry.o

kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -o bin/kernel.bin -Ttext 0x1000 bin/kernel_entry.o bin/kernel.o --oformat binary

kernel: boot.bin kernel.bin
	cat bin/boot.bin bin/kernel.bin > bin/ocaso-image

run: kernel
	qemu-system-i386 bin/ocaso-image

clean:
	rm -rf bin/*
