org 100h
.MODEL SMALL
.STACK 100H
.DATA
V1 DB 1, 2, 3, 4, 5, 6
V2 DB 13, 12, 45, 27, 31, 41
V3 DB ?, ?, ?, ?, ?, ?
num DB 6
ten db 10
spc db &#39
output_msg DB 10, 13, &#39
.CODE
    main PROC
    .STARTUP
        mov cl, num
        mov ch, 0
        mov ax, 0  
    Add_loop:
        mov al, V1[si]
        add al, V2[si]
        mov V3[si], al
        inc si
        dec cl
        jne add_loop

    mov ah, 09h
    lea dx, output_msg 
    
    int 21h
    mov si, OFFSET V3
    mov cl, num
    Print_loop:
    mov ax, 0
    mov al, [si]
    inc si
    div ten 
    push ax 
    mov dl, al
    add dl, 30h
    mov ah, 02h
    int 21h  
    pop ax 
    mov dl, ah
    add dl, 30h
    mov ah, 02h
    int 21h 
    mov ah,09h
    lea dx, spc
    int 21h
    dec cl
    jne Print_loop
    
    mov ah ,4ch
    mov al ,0
    int 21h
main ENDP
END main