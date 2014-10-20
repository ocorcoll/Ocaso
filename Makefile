all: boot

boot: 
	nasm src/boot/boot.asm -f bin -o bin/boot.bin

clean:
	rm -rf bin/*
