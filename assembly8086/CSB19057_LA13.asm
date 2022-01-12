.MODEL	SMALL
.STACK	100H
.DATA

No_Records	EQU	5
No_Fields	EQU	7
Bytes_Record	EQU	No_Fields * 2
Subjects	db	3
Marks_Records	DW	01, 22, 66, 54, 75, 00, 00     	
		DW	02, 21, 70, 67, 77, 00, 00
		DW	03, 21, 55, 60, 65, 00, 00 
		DW	04, 22, 75, 66, 83, 00, 00
		DW	05, 21, 49, 59, 69, 00, 00	;field 1: roll, field 2: age, field 3-5: marks, 
; field 6: total, field 7: average
Subject_Av	DW	?,?,?,?,?,?,?
guide_Msg DB '(CSB19057 PRASANJIT DUTTA)',10,13,'Guide: Enter any digit of number for each entry, to enter next number i.e to move to next entry just press enter $'
Output_Msg1	DB	'Roll No $'
Output_Msg2	DB	':  Total- $'
Output_Msg3	DB	'  Average- $'
nwln 		db 10, 13, '$'         
ten 		db 10    
hun 		db 100

.CODE

main	PROC
.STARTUP     

lea	dx, guide_Msg      
    	mov 	ah, 09h
    	int 	21h
lea	dx, nwln      
    	mov 	ah, 09h
    	int 	21h
sub bx,bx
mov cx,No_Records
lp_outer:
	;bx for i in rows, si for j in columns
	mov si,0
	lp_inner:
		cmp si,10
		je resume
		call inp
		mov Marks_Records[bx][si],ax
		add si,2
		jmp	lp_inner

	resume:
		add	bx, Bytes_Record
	loop lp_outer

mov cx,No_Records
sub bx,bx

Repeat1:
	sub	ax, ax
	mov si,4
	ad:
	add	ax, Marks_Records[bx+si]
	add si,2
	cmp si,8
	jne ad
	mov	Marks_Records[bx+10], ax
	div	Subjects
	sub	ah, ah
	mov	Marks_Records[bx+12], ax
	add	bx, Bytes_Record
	loop	Repeat1
	
	mov	cx, No_Records
    	sub	bx, bx
    	sub	dx, dx

Repeat2:

	lea	dx, nwln      
    	mov 	ah, 09h
    	int 	21h
	
	lea	dx, Output_Msg1     
    	mov 	ah, 09h
    	int 	21h


pusha                	; save all register values in stack so that they can be restored after printing 
; integer is done
    	mov	ax, Marks_Records[bx]     ; to print roll
    	div 	ten
    	mov 	bx, ax          ; saving value of ax in bx in order to avoid being overwritten
    	mov 	dl, al
    	add 	dl, 30h
    	mov 	ah, 02h
    	int 	21h
    	mov 	dl, bh          ; bx = ax thus bh = ah that is bh = remainder of the div operation
    	add 	dl, 30h
    	mov 	ah, 02h
    	int 	21h    
    	popa                ; restore all register values


	                   
	lea	dx, Output_Msg2     
    	mov 	ah, 09h
    	int 	21h
	
    	pusha               
    	mov	ax, Marks_Records[bx+10] ;to print total     
    	div 	hun
    	mov 	bx, ax          
    	mov 	dl, al
    	add 	dl, 30h
    	mov 	ah, 02h
    	int 	21h
    	mov 	ah, 0
    	mov 	al, bh
    	div 	ten 
    	mov 	bx, ax          
    	mov 	dl, al
    	add 	dl, 30h
    	mov 	ah, 02h
    	int 	21h  
    	mov 	dl, bh          
    	add 	dl, 30h
    	mov 	ah, 02h
    	int 	21h    
    	popa                ; restore all register values

                                             
	lea	dx, Output_Msg3     
    	mov 	ah, 09h
    	int 	21h            
    
    
    	pusha               
    	mov	ax, Marks_Records[bx+12]     ; to print average
    	div 	ten
    	mov 	bx, ax          
    	mov 	dl, al
    	add 	dl, 30h
    	mov 	ah, 02h
    	int 	21h
    	mov 	dl, bh          
    	add 	dl, 30h
    	mov 	ah, 02h
    	int 	21h    
    	popa                ; restore all register values

	lea	dx, nwln      
mov 	ah, 09h
    	int 	21h
    
	add	bx, Bytes_Record     ; to point bx to next record
	
	loop	Repeat2
	
;	.EXIT
 	mov 	ah ,4ch
    mov 	al ,0
int 	21h
main	ENDP       


inp PROC
	mov dh,0
    scanNum:
      mov ah, 01h
      int 21h
      cmp al,13    
      je  done 	 
      mov dl, al
	  sub dl, 48
      mov al, dh  
      mul ten  
      add al, dl
      mov dh, al   
      jmp scanNum ;dh will hold the input data
done:
mov  al,dh
mov  ah,0 ;ax contains the number    
lea	dx, nwln      
    	mov 	ah, 09h
    	int 	21h
 ret                
inp endp


END main