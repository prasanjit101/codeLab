org 100h

CR EQU 0DH 
LF EQU 0AH

.MODEL SMALL
.STACK 100H
.DATA    
message DB 'Enter a hexadecimal number :', CR, LF, CR, LF,'$' 

.CODE
MAIN PROC 

      MOV ax,@DATA        
      MOV ds,ax
      
      MOV bx,0        ;BX value set to 0
      MOV cl,4 
      
      ;printing message
      lea dx, message
      mov ah, 09h 
      int 21h
        
      mov ax,0 
      MOV ah,01h 
      INT 21h
      
      IN1:
          CMP al,0DH   
          JE TOGRAY     
          CMP al,39h   
          JG ALPHA
          AND al,0FH   
          ;if digit then convert it's ascii value to real value 
          JMP SHIFTLEFT
          
      ALPHA:          
          ;if letter then subtract 37h
          SUB al,37H
       
      SHIFTLEFT:
          SHL bx,cl    
          ;shift bx 4 digit left 
          OR  bl,al   
          
          INT 21h
          JMP IN1

      TOGRAY:
          XOR dx,dx   
          ;set dx value zero   
          ; conversion into gray code
          mov ax,bx
          SHR bx,1  
          XOR  bx,ax
          mov ax,bx 
    
    MOV ah,2      
    MOV dl,0AH    
    INT 21H       
    MOV dl,0DH    
    INT 21H
 
    MOV cl,1
    MOV ch,0
    OUTPUT:
          CMP ch,4        
          JE ENDING        
          INC ch  
          MOV dl,bh       
          SHR dl,4         ;SHIFT dl 4 TIMES IN THE RIGHT
          CMP dl,0AH      
          JL NUM         
          ADD dl,37H       
          MOV ah,2         
          INT 21H          
          ROL bx,4         ;ROTATE BX LEFT 4 TIMES
          JMP OUTPUT  

    ;PRINT THE OUTPUT   
    NUM:
        ADD dl,30H
        MOV ah,2 
        INT 21H            
        ROL bx,4      
        ;ROTATE BX LEFT 4 TIMES    
        JMP OUTPUT         
  
     
    ENDING:  
    MOV ah,4CH
    INT 21H
        
       
        
MAIN ENDP
END MAIN