;
; Switch from 16 bits real mode
; to 32 bits protected mode.
;
[bits 16]
switch_to_32_bits:
    ; Disable the interruptions
    cli
    ; Load the GDT
    lgdt [gdt_descriptor]

    ; Enable 32 bits mode in CPU
    mov eax,cr0
    or eax,0x1
    mov cr0,eax

    ; Jump to avoid pipelining
    jmp CODE_SEG:init_32_bits


[bits 32]
init_32_bits:

    ; Segment registers are meaningless
    mov ax,DATA_SEG
    mov ds,ax
    mov ss,ax
    mov es,ax
    mov fs,ax
    mov gs,ax

    ; Set the stack
    mov ebp,0x90000
    mov esp,ebp

    call BEGIN_32_BITS

