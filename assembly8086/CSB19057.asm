.model small
.stack 100h

.data 

string db 100 dup("$") 
inp_Msg db 10,13,'Enter String: $'  
outp_Msg db 10,13,'Count of uppercase letter : $'

.code 
main proc 
lea ax, data 
mov ds,ax 
    
    lea dx,inp_Msg
    mov ah,09h
    int 21h
    mov bl, 0 
    mov si,offset string 
    looper: 
        mov ah,1 
        int 21h  
        cmp al,"." 
        je prnt
        mov [si],al
        inc si
        cmp al,"A"
        jb  jump
        cmp al,"Z"
        ja  jump 
        inc bl
        jmp looper
    
    prnt:
        lea dx, outp_Msg
        mov ah, 09h
        int 21h  
        jmp value
    
    value: 
        mov ax, bx
        call printing
        int 21h
          
    mov ah,4ch  
    
    jump:
        jmp looper
        
    int 21h 
main endp 


printing PROC          
     
    ;initialize count
    mov cx,0
    mov dx,0
    l1:
        cmp ax,0
        je pr     
        mov bx,10       
         
        div bx                 
        push dx             
         
        inc cx             
        xor dx,dx
        jmp l1
    pr:
        cmp cx,0
        je ter
         
        pop dx
         
        add dx,48
         
        mov ah,02h
        int 21h
        dec cx
        jmp pr
    ter:
        printing endp

end main