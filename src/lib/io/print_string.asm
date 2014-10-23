;
; Print a string.
;   bx - String address.
;
print_string:
    ; Save registers
    pusha
    ; Sets the print BIOS routine
    mov ah,0x0e
    ; Print loop
    print_string_loop:
        ; Checks if it is the end of the string
        cmp byte [bx],0
        je print_string_end_loop
        ; Print character
        mov al,[bx]
        int 0x10
        ; Next character and jump
        inc bx
        jmp print_string_loop
    print_string_end_loop:

    ; Return
    popa
    ret
