CR EQU 0DH
  LF EQU 0AH
  MAX_SIZE EQU 20
  .MODEL SMALL
  .STACK 100H
  .DATA
  array DW MAX_SIZE DUP(?)
  sum DW 0
  prompt_msg DB 'Enter 20 non-zero positive integers less than 10', CR,LF, CR, LF, '$'
  output_msg DB 'Sum of integers are: $'
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
rd_loop: ;reading a set of 5 single digit numbers
sub ax, ax
mov ah, 01h ; read character from  keyboard
int 21h;1 byte char gets stored in AL
sub al, 30h ; convert from character to number
mov ah, 0; AH = 0, AL = [num] : AX = [num]
cmp al,0
je compute_sum
mov [bx), ax
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
mov sum, ax
lea dx, output_msg
mov ah, 09h
int 21h ; print a two digit integer value
sub dx, dx
mov ax, sum
div ten; al = ax/10, ah = ax%10
mov bx, ax ; keeping a copy in bx because ax will be used for display operations
add bh, 30h ; converting number to character
add bl, 30h; converting number to character
mov dl, bl
mov ah, 02h     
int 21h
mov dl, bh
mov ah, 02h
int 21h
.EXIT
mov ah ,4ch
mov al, 0
int 21h
main ENDP
  END main
