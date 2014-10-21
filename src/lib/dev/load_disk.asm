;
; Load sectors from disk.
; dh - Number of sectors to read.
;
disk_load:
    ; Save registers
    pusha
    push dx

    ; BIOS read sector function
    mov ah,0x02
    ; Set the number of sectors to read
    mov al,dh
    ; Select cylinder 0
    mov ch,0x00
    ; Select cylinder 0
    mov dh,0x00
    ; Start reading from sector 2
    ; after the boot sector
    mov cl,0x02
    ; Read de data
    int 0x13

    ; Handle errors
    jc disk_error
    pop dx
    cmp dh,al
    jne disk_error

    ; Return
    popa
    ret

    disk_error:
        mov bx, DISK_ERROR_MSG
        call print_string
        jmp $


DISK_ERROR_MSG: db "Fatal error while reading the disk!",0
