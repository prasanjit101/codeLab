org 100h
CR EQU 0DH 
LF EQU 0AH

.MODEL SMALL
.STACK 100H
.DATA    
  message DB 'Enter the hexadecimal representation of the gray code :', CR, LF, CR, LF,'$' 
  hs DW 0     
  temp  DW  0 
  hn DW 0
  
.CODE
   MAIN PROC 
        
      MOV ax,@DATA        
      ; moving data to data segment
      MOV ds,ax
      MOV bx,0       
      MOV cl,4   
      
      
      LEA dx, message 
      MOV ah, 09h 
      INT 21h
      XOR ax,ax   
      
      
      MOV ah,1   
      INT 21h      
      
      
      INP:
          CMP al,0DH  
          JE TOBIN    
         
      
          CMP al,39h 
          JG ALPHA
          
          AND al,0FH 
          JMP SHIFTL
          
      ALPHA:         
          SUB al,37H
       
      SHIFTL:
          SHL bx,cl    
          OR  bl,al    
          
          INT 21h
          JMP INP
TOBIN:
          
MOV dx,0   
MOV hn,bx 
MOV ax,0
MOV bx,0                                 
MOV bx,80h    

H:
MOV ax,hn
MOV temp,ax
AND temp,bx
MOV ax,temp
ADD hs,ax
MOV dx,ax
SHR dx,1
SHR bx,1

HH:
MOV ax,hn
XOR ax,dx
MOV temp,ax
AND temp,bx
MOV dx,temp
ADD hs,dx
SHR dx,1
SHR bx,1
CMP bx,0
JNE HH


MOV ax,hs
MOV bx,ax
MOV ah,2               
MOV dl,0AH             
INT 21H                
MOV dl,0DH         
INT 21H

MOV cl,1
MOV ch,0
OUTPUT:
    CMP ch,4         
    JE FINISH     
    INC ch           

    MOV dl,bh        
    SHR dl,4         

    CMP dl,0AH       
    JL DIGIT        

    ADD dl,37H       
    MOV ah,2         
    INT 21H          
    ROL bx,4         
    JMP OUTPUT       
DIGIT:
    ADD dl,30H       
    MOV ah,2
    INT 21H          
    ROL bx,4         
    JMP OUTPUT         
  
    FINISH:  
    MOV ah,4CH
    INT 21H  
        
    MAIN ENDP
    END MAIN