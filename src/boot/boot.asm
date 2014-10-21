; Base address
[org 0x7c00]

    ; Save the boot drive to memory
    mov [BOOT_DRIVE], dl
    ; Set the stack
    mov bp,0x8000
    mov sp,bp

    ; Print initial message
    mov bx,INITIAL_MSG
    call print_string

    ; Load 2 sectors from the
    ; boot disk and put them
    ; into ES:BX
    mov bx,0x9000
    mov dh,2
    mov dl,[BOOT_DRIVE]
    call disk_load

    ; Print the first loaded word
    mov dx, [bx]
    call print_hex

    ; Print the first loaded word
    ; from the second sector
    mov dx, [bx + 512]
    call print_hex

    ; Jump forever
    jmp $

%include "src/lib/io/print_string.asm"
%include "src/lib/io/print_hex.asm"
%include "src/lib/dev/load_disk.asm"

INITIAL_MSG: db 'Loading Ocaso OS...',0
BOOT_DRIVE: db 0

; Padding of 0s
times 510-($-$$) db 0
; Set boot sector flag
dw 0xaa55

; Define sector 2
times 256 dw 0xdada
; Define sector 3
times 256 dw 0xface
