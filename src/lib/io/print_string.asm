; Change to protected 32-bits mode
[bits 32]
; Define video constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

;
; Print a string.
;   bx - String address.
;
print_string:
    ; Save registers
    pusha
    ; Set edx to point the video memory
    mov edx,VIDEO_MEMORY
    ; Print loop
    loop:
        ; Set the character and attributes
        mov al,[ebx]
        mov ah,WHITE_ON_BLACK

        ; Checks if it is the end of the string
        cmp byte al,0
        je end_loop
        ; Move the character to the video memory
        mov [edx],ax
        ; Next character and jump
        inc ebx
        add edx,2
        jmp loop

    end_loop:
        ; Return
        popa
        ret
