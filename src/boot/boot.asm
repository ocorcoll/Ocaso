; Base address
[org 0x7c00]
KERNEL_OFFSET equ 0x1000
    ; Save boot drive
    mov [BOOT_DRIVE],dl
    ; Set the stack
    mov bp,0x9000
    mov sp,bp
    ; Print initial message
    mov bx,MSG_LOADING_OS
    call print_string
    ; Load kernel
    call load_kernel
    ; Change to protected mode
    call switch_to_32_bits
    ; Jump forever
    jmp $

; Load 16-bit libs
%include "src/boot/gdt.asm"
%include "src/boot/print_string.asm"
%include "src/boot/load_disk.asm"
; Load 32-bit libs
%include "src/boot/print_string_32_bits.asm"
%include "src/boot/switch_to_32_bits.asm"

[bits 16]
load_kernel:
    mov ebx,MSG_LOADING_KERNEL
    call print_string
    ; Destination address
    mov bx,KERNEL_OFFSET
    ; Load number of sectors
    mov dh,3
    ; Boot drive
    mov dl,[BOOT_DRIVE]
    call load_disk
    ; Print kernel loaded
    mov bx,MSG_OK
    call print_string
    ; Return
    ret

[bits 32]
BEGIN_32_BITS:
    ; Print running kernel
    mov ebx,MSG_RUNNING_KERNEL
    call print_string_32_bits
    ; Run the kernel
    call KERNEL_OFFSET
    ; Forever
    jmp $


BOOT_DRIVE:         db 0
MSG_LOADING_OS:     db "Loading Ocaso OS...",0
MSG_LOADING_KERNEL: db "Loading kernel...",0
MSG_OK:             db "[OK]",0
MSG_RUNNING_KERNEL: db "Running kernel...",0

; Padding of 0s
times 510-($-$$) db 0
; Set boot sector flag
dw 0xaa55
