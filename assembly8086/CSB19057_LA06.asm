CR EQU 0DH
LF EQU 0AH
MAX_SIZE EQU 20
.MODEL SMALL
.STACK 100H
.DATA
array DW MAX_SIZE DUP(?)
sum DW 0
prompt_msg DB 'Enter some non-zero single digit positive integers.', CR, LF, '$'
output_msg DB CR,LF, 'Sum of the integers is: $'
ten DB 10

.CODE
main PROC
.STARTUP
lea dx, prompt_msg
mov ah, 09h
int 21h
mov bx, OFFSET array
mov cx, MAX_SIZE
mov dx, 0
read:
    mov ax, 0
    mov ah, 01h ; to read a character from the keyboard, 1 byte char gets stored in AL
    int 21h
    sub al, 30h ; to convert from character to number
    cmp al, 0
    je calc_sum
    mov ah, 0 ; AH = 0, AL = [num] : AX = [num]
    mov [bx], ax
    add bx, 2
    dec cx
    inc  dx
    cmp cx, 0
    je calc_sum
    jmp read

calc_sum:
mov bx, OFFSET array
mov cx, dx

mov ax, 0
;summation of array elements using conditional jump instruction
summa:
 add ax, [bx]
add bx, 2
sub cx, 1
cmp cx, 0
jnz summa
 
mov sum, ax
mov dx,OFFSET output_msg
mov ah, 09h
int 21h
mov  dx, 0
mov ax, sum
div ten ; al = ax/10, ah = ax%10
mov dx, ax 
add dh, 30h ; converting number to character
add dl, 30h 
mov ah, 02h
int 21h
mov dl, bh
mov ah, 02h
int 21h
mov ah ,4ch
mov al ,0
int 21h
main  ENDP
END main 
