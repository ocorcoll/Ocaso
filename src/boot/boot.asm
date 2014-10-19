; Sets the BIOS routine
mov ah,0x0e

; Print characters:
mov al,'O'
int 0x10
mov al,'r'
int 0x10
mov al,'i'
int 0x10
mov al,'o'
int 0x10
mov al,'l'
int 0x10

; Jump forever
jmp $

; Padding of 0s
times 510-($-$$) db 0

; Boot sector
dw 0xaa55
