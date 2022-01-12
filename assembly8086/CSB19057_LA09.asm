org 100h
.MODEL SMALL
.STACK 100H
.DATA 
output_msg DB 'The number is: $'
ten DW 10
len DB 0 
newline DB 10,13,'$'

.CODE
  main PROC   
    .STARTUP   
    
        ; cl count
        mov bh, 10
        mov bl, 0Dh
        mov cl, 0 
        
    loop_:
        mov ah, 1
        int 21h
        mov ah,0 
        mov dl, al 
        sub al,30h
        push ax
        add cl,1
        sub dl,bl
        jnz loop_
                       
    pop dx 
    sub cl, 1 
    mov bx,ten
    mov len,cl  
    
 lea dx, output_msg 
 mov ah, 09h 
 int 21h 
    
    loop2:
        cmp len,1
        je done  
        pop cx 
        pop ax
        mul bx
        add ax, cx
        push ax  
        mov ax,bx
        mul ten
        mov bx,ax
        sub len,1
        jnz loop2         
    
    done:
    mov ah,09
    lea dx,newline
    int 21h
    
    pop ax
    mov dx, 0 
    mov len,0
             
    loop3: 
        div ten
        push dx 
        add len,1
        mov dx,0
        cmp ax,0
        jne loop3 
         
    print:
        pop bx
        mov dl,bl
        add dl,30h
        mov ah,2
        int 21h 
        mov dx, 0
        sub len,1
        jnz print
        
main ENDP
END main
