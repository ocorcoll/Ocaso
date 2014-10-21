;
; Print a hexadecimal.
;   dx - Hexadecimal address.
;
print_hex:
    ; Save registers
    pusha

    ; High nibble
    mov al,dh
    and al,0xf0
    shr al,4
    call hex_to_char
    mov [HEX_OUT+2],al
    ; Low nibble
    mov al,dh
    and al,0x0f
    call hex_to_char
    mov [HEX_OUT+3],al

    ; High nibble
    mov al,dl
    and al,0xf0
    shr al,4
    call hex_to_char
    mov [HEX_OUT+4],al
    ; Low nibble
    mov al,dl
    and al,0x0f
    call hex_to_char
    mov [HEX_OUT+5],al

    ; Print the string
    mov bx,HEX_OUT
    call print_string
    
    ; Return
    popa
    ret

;
; Converts the hexadecimal nibble
; to a character.
; al - Hexadecimal to convert (org,src)
;
hex_to_char:
    and al,0xF
    add al,'0'
    cmp al,'9'
    jbe endif
    if:
        add al,7
    endif:

    ; Return
    ret

; ASCII Hexadecimal template
HEX_OUT: db '0x0000',0

