CR EQU 0DH
LF EQU 0AH
MAX_SIZE EQU 5
.MODEL SMALL
.STACK 100H
.DATA
array DW MAX_SIZE DUP(?)
sum DW 0
dig DB 0
prompt_msg DB 'Enter 5 single digit positive integers', CR, LF, CR,LF, '$'  ;
output_msg DB 'Sum of  integers are : $';
ten DB 10
.CODE
main PROC
.STARTUP
lea dx, prompt_msg
mov ah, 09h
int 21h
mov bx, OFFSET array
mov cx, MAX_SIZE
sub dx, dx
rd_loop:  ; for reading a set of double digit numbers
sub ax, ax
mov ah, 01h ; read character from keyboard
int 21h
sub al, 30h ; from character to number
mov ah, 0; AH = O, AL = [num] : AX = [num]
cmp al,0
je compute_sum
mul ten
mov dig,al
sub ax,ax
mov ah,01h
int 21h
add al,dig
sub al, 30h ; convert from character to number
mov ah, 0; AH = 0, AL = [num] : AX = [num]
cmp al,0
mov [bx],ax
add bx, 2
loop rd_loop
compute_sum:
mov bx, OFFSET array
mov cx, MAX_SIZE
mov ax, 0
sum_loop:
add ax, [bx]
add bx, 2
loop sum_loop
mov sum, ax ; display output message
lea dx, output_msg
mov ah, 09h
int 21h ; print a two digit sum
sub dx, dx
mov ax, sum
div ten ; al = ax/ 10, ah = ax%10
mov bx, ax ; 
add bh, 30h ; convert number to character
add bl, 30h ; convert number to character
mov dl, bl
mov ah, 02h
int 21h
mov dl, bh
mov ah, 02h
int 21h
.EXIT
mov ah ,4ch
mov al,0
int 21h
main ENDP
END main
