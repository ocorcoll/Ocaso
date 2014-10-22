;
; GDT - Global Descriptor Table.
;
gdt_start:
    ; Null segment defined for safeness
    gdt_null:
        dd 0x0
        dd 0x0

    ; Code segment:
    ;   base=0x0
    ;   limit=0xffff
    ;   present=1, privilege=00,descriptor_type=1
    ;   code=1,conforming=0,readable=1,accessed=0
    ;   granularity=1,32-bits=1,64-bits=0,avl=0
    gdt_code:
        dw 0xffff
        dw 0x0
        db 0x0
        db 10011010b
        db 11001111b
        db 0x0

    ; Data segment:
    ;   Same as code segment but:
    ;   code=0,expand_down=0,writable=1,accessed=0
    gdt_data:
        dw 0xffff
        dw 0x0
        db 0x0
        db 10010010b
        db 11001111b
        db 0x0

gdt_end:

;
; GDT descriptor.
;
gdt_descriptor:
    ; Size of the GDT
    dw gdt_end - gdt_start - 1
    ; Address of the GDT
    dd gdt_start

; Constants for the GDT descriptor offset
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

