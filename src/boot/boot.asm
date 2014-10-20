; Base address
[org 0x7c00]

    ; Print initial message
    mov bx,INITIAL_MSG
    call print_string

    ; Jump forever
    jmp $

%include "src/boot/print_string.asm"

INITIAL_MSG:
    db 'Loading Ocaso OS...',0

; Padding of 0s
times 510-($-$$) db 0

; Boot sector
dw 0xaa55
