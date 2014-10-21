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
    loop:
        ; Checks if it is the end of the string
        cmp byte [bx],0
        je end_loop
        ; Print character
        mov al,[bx]
        int 0x10
        ; Next character and jump
        inc bx
        jmp loop

    end_loop:
        ; Return
        popa
        ret
