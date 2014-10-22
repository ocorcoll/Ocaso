; Base address
[org 0x7c00]

    ; Set the stack
    mov bp,0x9000
    mov sp,bp

    ; Change to protected mode
    call switch_to_32_bits

    ; Jump forever
    jmp $

; Load libs
%include "src/boot/gdt.asm"
%include "src/lib/io/print_string.asm"
%include "src/boot/switch_to_32_bits.asm"

[bits 32]
BEGIN_32_BITS:
    ; Print initial message
    mov ebx,INITIAL_MSG
    call print_string

    jmp $

INITIAL_MSG: db "Loading Ocaso OS...",0

; Padding of 0s
times 510-($-$$) db 0
; Set boot sector flag
dw 0xaa55
